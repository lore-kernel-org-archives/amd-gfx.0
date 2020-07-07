Return-Path: <SRS0=Rnur=AS=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74814C433DF
	for <amd-gfx@archiver.kernel.org>; Tue,  7 Jul 2020 13:24:38 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 36FA8206E2
	for <amd-gfx@archiver.kernel.org>; Tue,  7 Jul 2020 13:24:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="cu9haEuY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 36FA8206E2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EC4646E0BA;
	Tue,  7 Jul 2020 13:24:37 +0000 (UTC)
Received: from NAM02-CY1-obe.outbound.protection.outlook.com
 (mail-eopbgr760082.outbound.protection.outlook.com [40.107.76.82])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5AFCF6E0BA
 for <amd-gfx@lists.freedesktop.org>; Tue,  7 Jul 2020 13:24:37 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cXBu4BuZmekm1m2etAzyo8+AFGJ9rdr3+tRhrQr+su3XklSQDg6OQl69imgAetYgsm1i14/Rlm88jFbJzGqbUPQalNE1nHGgD2PBqVgzQuE/003xfqSF7gOfNIdvt7ttWEqahWMqCdcWVCa1M3B/YZ+WM0beuLY7XOrFr4Dv1aXJBiaOOfOGMYIHAxYlEJw1q9IHxPz0QCK4neoSZkKxWw9We/bGZB/qaoBuIXxYy/TedxkkdzWoHyt7j3LELZLWDpEneTLrsOMVI9YXUvwr988fX22uDJTfauSVU0fOT1/fvBlfJcA+Z1d8hqjs/QB/IzZZdigqtlMm7MMNAopLug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=X11QGft3J3WCgK1mh1vz1q9gx2Vl5BlbUtCmvTEPVD0=;
 b=b8zIfwK7DkMo/HM322CQjdkk67XzxMXdrZxfcv1Di2eDFk2qhwE6J/zJtg+j+HrFoJTunk8ABZKK9iFWD3NFDGfPc1cWncw6lG+JXZE3KLD1RrJy1HX/GJHkCE1H0TQ9DssBIsWcgT65BnGpPFgCB/IeOq1fRRIwTdeRWnEr3mI3HI6X3LHzORZ+0UB0mlHGbJCaCLR+S4JHsFtPRVxoaa+U7hZiqc3wj5Vo9gv5er2IMfkaRbpFP2gaauxttR0ml79oSN4mVL2P5BuVw1Hi7Gi8oVTmigO9vXQhrQPnLJqcr2VUBgi5X7bMg6ctwrsUVK2x71RGX8VbMsaQMYf0ew==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=X11QGft3J3WCgK1mh1vz1q9gx2Vl5BlbUtCmvTEPVD0=;
 b=cu9haEuY0fSMfUaFYdkzm5w+Cl8GNPEoKUh4Kc4Vahpk3HpcqQq2SQ+uTZNxTfKMbS2q78qoRPHqC7KW5TFVpbMIthXhVniSUsxKCHmdYbCDNCqVyXPuAU6PBN65+VH4Di7/pGLZjDYlFnINz6s3RpFB5j8P3dYL7wJXz+8e5vU=
Received: from MN2PR12MB4078.namprd12.prod.outlook.com (2603:10b6:208:1de::18)
 by BL0PR12MB2564.namprd12.prod.outlook.com (2603:10b6:207:49::28)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3153.29; Tue, 7 Jul
 2020 13:24:33 +0000
Received: from MN2PR12MB4078.namprd12.prod.outlook.com
 ([fe80::acd3:39ec:eda9:89d7]) by MN2PR12MB4078.namprd12.prod.outlook.com
 ([fe80::acd3:39ec:eda9:89d7%6]) with mapi id 15.20.3153.029; Tue, 7 Jul 2020
 13:24:33 +0000
From: "Zhang, Hawking" <Hawking.Zhang@amd.com>
To: "Gao, Likun" <Likun.Gao@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] tests/amdgpu: set emit fence flag for multi fence
Thread-Topic: [PATCH] tests/amdgpu: set emit fence flag for multi fence
Thread-Index: AQHWVGCq9/j3D4/yXE6TcY3iY3V5fqj8GlrQ
Date: Tue, 7 Jul 2020 13:24:33 +0000
Message-ID: <MN2PR12MB4078A186CF4FB3333A6837F9FC660@MN2PR12MB4078.namprd12.prod.outlook.com>
References: <20200707131504.2994506-1-likun.gao@amd.com>
In-Reply-To: <20200707131504.2994506-1-likun.gao@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Enabled=true;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_SetDate=2020-07-07T13:24:29Z; 
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Method=Privileged;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Name=Public_0;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_ActionId=904c2dbc-2bc3-4de4-9085-000083d716b8;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_ContentBits=1
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_enabled: true
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_setdate: 2020-07-07T13:24:16Z
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_method: Standard
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_name: Internal Use Only -
 Unrestricted
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_actionid: 6bdf560d-b1fa-41a8-a220-0000f0e5f29b
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_contentbits: 0
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_enabled: true
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_setdate: 2020-07-07T13:24:30Z
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_method: Privileged
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_name: Public_0
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_actionid: ed27cf7e-f1d8-4d04-a0f9-0000b1e50ee6
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_contentbits: 0
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [58.247.170.242]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: a88318b6-41db-448d-018f-08d82279165d
x-ms-traffictypediagnostic: BL0PR12MB2564:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BL0PR12MB2564F8BB5D98064F83B033B9FC660@BL0PR12MB2564.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:3513;
x-forefront-prvs: 0457F11EAF
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: bZXqKmYz0FwSCWKkzA/YXAxjpVL4aBQJPCeoRbw+Krg9RevJF+R3URBVfs4uFLmAaMWfrSkK5Y2tgGOpY8biaMrQqrJUKgBltoIEtxvy9+1wT/f/4WWigcqw3rVrx2nebwgNlCsdGmLX7WFfp2ldj0qZ5H1Ue590lsw+RTjn+YQs4btNTZ10qASp8tUNvHyRigRxWEY67hskCvZPHTk1QOIHxs2YB3srFts99oJDoRKjxZ+jiFX8B6BJ6z1Ra8G62TKO6sHJEXO9JWwNfno+8df502TBbNOw9qfVofxCtBBLVuKVsxeLapKHRqlFAR3zQV7Z0oyxTE1A33gB24/K8A==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB4078.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(396003)(136003)(39860400002)(376002)(346002)(366004)(26005)(8676002)(83380400001)(9686003)(33656002)(186003)(71200400001)(6506007)(66946007)(76116006)(7696005)(64756008)(5660300002)(8936002)(53546011)(66556008)(2906002)(66446008)(66476007)(478600001)(52536014)(110136005)(86362001)(55016002)(316002);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: RFzz6kdc6X6CsuMLR0Vl+MaB9Jug30/CxRVf2tCZjlaZV0YewEAOLu6fGqzjYwC63mcXykw3miys9gA9jljH1t/sUdokX1F0qvrHPO82OQFDcs8KNGJa1S+Y5w8QxKUWh2L7xX6xkaGr0YXTUEts/xUM5ORjN5HeKzTK6xd4tWK2XHutvffzbEeb3Rxp0XtfA9CwzX2QhfuEBOG9wuHywSP5ZCpS0Ymf0Y8T9tvtOQ8wBklwR+Wt4w0UMCtoKjPA19CexClBGTiKdFhe16igNcyQHAPpIBOidTYTYzWw+F+jB8PPkrl9KwexuXxS5lCS/uVPpLoh3higzO0w+32bj6n3P8+1SMOxQEQ635TRbqzBPhb0F7vRKicNv9LFxPmjiEi0vTh5vL/GiIzAp+SFmhHN7j6AS7XgHpX3pqSFPA3tNq1b+l0OIq6Ll6BCPxqU2JwU4m9uA2kcr9zsCYgaW5CMUpPOmZeycJBpCxhfPIUBjG7GP2DU1eB81cZTAXZ3
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB4078.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a88318b6-41db-448d-018f-08d82279165d
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Jul 2020 13:24:33.3560 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: KKygujIgHVTdUjmurWVBc2ozpUXatkfPfm0WZOIoeU2cfHJK2zboiH4ZMmqJMTMPekoPe3qa20UByxQcXtJcdw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR12MB2564
X-BeenThere: amd-gfx@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Discussion list for AMD gfx <amd-gfx.lists.freedesktop.org>
List-Unsubscribe: <https://lists.freedesktop.org/mailman/options/amd-gfx>,
 <mailto:amd-gfx-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <https://lists.freedesktop.org/archives/amd-gfx>
List-Post: <mailto:amd-gfx@lists.freedesktop.org>
List-Help: <mailto:amd-gfx-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/amd-gfx>,
 <mailto:amd-gfx-request@lists.freedesktop.org?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Public Use]

It seems to me the kernel amdgpu_drm.h doesn't sync up with libdrm amdgpu_drm.h if your patch is based on drm-master.

I'd expect another patch to add AMDGPU_IB_FLAG_EMIT_MEM_SYNC flag in libdrm since kernel already has the flag for a while.

Other than that, the patch is Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>

Regards,
Hawking
-----Original Message-----
From: Gao, Likun <Likun.Gao@amd.com> 
Sent: Tuesday, July 7, 2020 21:15
To: amd-gfx@lists.freedesktop.org
Cc: Zhang, Hawking <Hawking.Zhang@amd.com>; Gao, Likun <Likun.Gao@amd.com>
Subject: [PATCH] tests/amdgpu: set emit fence flag for multi fence

From: Likun Gao <Likun.Gao@amd.com>

Set AMDGPU_IB_FLAG_EMIT_MEM_SYNC flag for specific ASIC when test multi fence.

Signed-off-by: Likun Gao <Likun.Gao@amd.com>
Change-Id: I41e5cb19d9ca72c1d396cc28d1b54c31773fe4d5
---
 include/drm/amdgpu_drm.h   | 2 ++
 tests/amdgpu/basic_tests.c | 6 ++++++
 2 files changed, 8 insertions(+)

diff --git a/include/drm/amdgpu_drm.h b/include/drm/amdgpu_drm.h index 4fe35d60..8a4d7da9 100644
--- a/include/drm/amdgpu_drm.h
+++ b/include/drm/amdgpu_drm.h
@@ -586,6 +586,8 @@ union drm_amdgpu_cs {
  */
 #define AMDGPU_IB_FLAG_RESET_GDS_MAX_WAVE_ID (1 << 4)
 
+#define AMDGPU_IB_FLAG_EMIT_MEM_SYNC  (1 << 6)
+
 struct drm_amdgpu_cs_chunk_ib {
 	__u32 _pad;
 	/** AMDGPU_IB_FLAG_* */
diff --git a/tests/amdgpu/basic_tests.c b/tests/amdgpu/basic_tests.c index 57496c82..c0f7ec33 100644
--- a/tests/amdgpu/basic_tests.c
+++ b/tests/amdgpu/basic_tests.c
@@ -45,6 +45,8 @@ static  amdgpu_device_handle device_handle;  static  uint32_t  major_version;  static  uint32_t  minor_version;  static  uint32_t  family_id;
+static  uint32_t  chip_rev;
+static  uint32_t  chip_id;
 
 static void amdgpu_query_info_test(void);  static void amdgpu_command_submission_gfx(void);
@@ -607,6 +609,8 @@ int suite_basic_tests_init(void)
 		return CUE_SINIT_FAILED;
 
 	family_id = gpu_info.family_id;
+	chip_rev = gpu_info.chip_rev;
+	chip_id = gpu_info.chip_external_rev;
 
 	return CUE_SUCCESS;
 }
@@ -1769,6 +1773,8 @@ static void amdgpu_command_submission_multi_fence_wait_all(bool wait_all)
 	ib_info[0].ib_mc_address = ib_result_ce_mc_address;
 	ib_info[0].size = i;
 	ib_info[0].flags = AMDGPU_IB_FLAG_CE;
+	if (chip_id == (chip_rev + 0x28))
+		ib_info[0].flags |= AMDGPU_IB_FLAG_EMIT_MEM_SYNC;
 
 	/* IT_WAIT_ON_CE_COUNTER */
 	ptr = ib_result_cpu;
--
2.25.1
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
