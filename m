Return-Path: <SRS0=B7jy=6A=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4BF2FC2BB55
	for <amd-gfx@archiver.kernel.org>; Thu, 16 Apr 2020 16:06:31 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 119732223E
	for <amd-gfx@archiver.kernel.org>; Thu, 16 Apr 2020 16:06:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="4D/Nxgyd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 119732223E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B4DC46E328;
	Thu, 16 Apr 2020 16:06:30 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on20621.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7e88::621])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0429C6E328
 for <amd-gfx@lists.freedesktop.org>; Thu, 16 Apr 2020 16:06:29 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nomg9ViyL/e8b4FqsgvPBXkCY0Welwg/J+esDxelC8svNDrvE2DJ7HgIywk1F5I9QM+KdaqNUlaC8o5ecC/8b8LOOid/ya8bYoG0prsfWOu5zFj9w9C1JpLZZNDCMFXkWAxgam7Okck21rZoVDVqFSlU3HPk1vpXhwyJFkvNSsccr3uef/+rLru0w+qNlQKjHVUCCDyzsdjU1Ng76BexjZx+Jpa2xupe3U5WBzq0xe6thnIFSnykJUOldX5jJpWb3VMAWoeW/PoUMiJySx6l+I2fyIeFAnZdEd+mNw9ZLBwB5U1KDh3yNflECnR6poeW5TxrLfqFf2WC1NmX3nYkaQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3iEXdt+RV8tGurPgx1PdQtHcdZ5B0DLH+fXJeNdaM+g=;
 b=MGVtwimFrZfU0oFbfunJxArUAO6+M1MUQ6uaJW0uhWvEdrB9WzwBfkDWRpazoX5UJ/jKy7lEvX+UwkXWnINBo/ZlEI3UCTnTKh9f3HCTQGagq4fgvHCYWlON5qgbzTqW4NubQMMCtiWenEJnNp6RsNM+u3LajMDsic0XtIXyb3aqHgHwgdfrxxheEbOtiSjau089SdVvbvpPSOgjU7y+TeNTI/8k58UPk8QzfR7FYEKOlN8P6SaAYniYLOMgPZ+o3Xz5WcOZ/rvQaRxnbDiPzwSW2xFSTNeSmBUc3gFfVtoUFBdY8E57K/as11oF9jqM2PUjMeEevPYzP7UBUvgFGw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3iEXdt+RV8tGurPgx1PdQtHcdZ5B0DLH+fXJeNdaM+g=;
 b=4D/NxgydDmlLfQKfvYx4SCmjAEyl30X8NAUEVbih5dArQ0o3oePfA/JvbPRZYMl2OmrMcv931rA1pzsd5bIHP6NGvOxlmuP/dySoF6xPtv6inCUpWYS3Bj4c3i/0gVg6juH1RaUQkWa6pEHkEJ52o2rf0h1s/orqiVLaJJI1YXE=
Received: from MN2PR12MB4032.namprd12.prod.outlook.com (2603:10b6:208:16d::32)
 by MN2PR12MB3598.namprd12.prod.outlook.com (2603:10b6:208:d1::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2900.28; Thu, 16 Apr
 2020 16:06:27 +0000
Received: from MN2PR12MB4032.namprd12.prod.outlook.com
 ([fe80::51c:c7d9:bfb6:1265]) by MN2PR12MB4032.namprd12.prod.outlook.com
 ([fe80::51c:c7d9:bfb6:1265%3]) with mapi id 15.20.2900.028; Thu, 16 Apr 2020
 16:06:27 +0000
From: "Clements, John" <John.Clements@amd.com>
To: "Chen, Guchun" <Guchun.Chen@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>, "Zhang, Hawking" <Hawking.Zhang@amd.com>,
 "Li, Dennis" <Dennis.Li@amd.com>
Subject: RE: [PATCH] drm/amdgpu: fix kernel page fault issue by ras recovery
 on sGPU
Thread-Topic: [PATCH] drm/amdgpu: fix kernel page fault issue by ras recovery
 on sGPU
Thread-Index: AQHWFAZtzTToZn5yQUGtcYGqkZP/96h76cHQ
Date: Thu, 16 Apr 2020 16:06:26 +0000
Message-ID: <MN2PR12MB40320540D6C05AFE96F8F670FBD80@MN2PR12MB4032.namprd12.prod.outlook.com>
References: <20200416154748.32138-1-guchun.chen@amd.com>
In-Reply-To: <20200416154748.32138-1-guchun.chen@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Enabled=true;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SetDate=2020-04-16T16:06:24Z; 
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Method=Standard;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Name=Internal Use Only -
 Unrestricted;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ActionId=94f88fb2-039a-44ce-b44b-00001700b394;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ContentBits=1
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_enabled: true
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_setdate: 2020-04-16T16:06:24Z
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_method: Standard
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_name: Internal Use Only -
 Unrestricted
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_actionid: 917837fa-5115-4091-bcb6-0000712ed5c3
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_contentbits: 0
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=John.Clements@amd.com; 
x-originating-ip: [114.88.224.33]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: dd8f2b8f-dbbe-4125-63d6-08d7e2201e3e
x-ms-traffictypediagnostic: MN2PR12MB3598:|MN2PR12MB3598:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MN2PR12MB3598D526AD7CFEC64009CE8AFBD80@MN2PR12MB3598.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2733;
x-forefront-prvs: 0375972289
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB4032.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(10009020)(4636009)(396003)(39860400002)(136003)(366004)(376002)(346002)(110136005)(8936002)(478600001)(5660300002)(8676002)(33656002)(86362001)(81156014)(71200400001)(9686003)(186003)(52536014)(7696005)(2906002)(66446008)(76116006)(66946007)(316002)(6636002)(55016002)(66476007)(64756008)(53546011)(6506007)(26005)(66556008);
 DIR:OUT; SFP:1101; 
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: u1gBgNmgt3Frc0K9BaGLwufpIhFtOV9kL789l/MG7sVUMhnNXx8zpPwquX6uFT26RcpEOwqiuLECxxN1ZYV6EcPpaumnSAIOWiqK3sj50w+253+BpoqeOyS9XpcrGjF0AngN7mfMN8ixkgwqDNUAXsAsm90t4A/11Y/vediPS159GOv/ea8sGROUkrqUTFae0sQm0u7ZlaXdkuvh5YqBvPG6/eYbAmD0wftCYgkl1KCmklOeV57MJ6rYGBBOgXgdTK8XKsJCbMoxXUOBAVIgZpFPXu/IJxnZtBbLQsjnTTd/j/XkU9ThVdQA/3VqX2NRKIB0yMsm85hTirCx6z3qiTpPtc9ZlXvlsG5ko0uSJSrV7rOcwQSuMbiKvE65b1+hxKpHcmMyXiJjX1+DNb+sHjQn5PUpH/F8dRc6Uq6PL2QD0fmlfi/sLXzXJfLajScA
x-ms-exchange-antispam-messagedata: kwaB2Xgnjv6KiQsZCVnCSVFgtr8JUvM6XiMxsBhO/aJdVCp3M+iQImqIAIN1tMwG9m3cAk9MnUOOvM8HiuK1Ioy4UdJoTxT11YqjMNKw1xKBxv5fkvpq2bEjq0gm+Ah45lSGPqNcTCibdDEqlRBBuQ==
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dd8f2b8f-dbbe-4125-63d6-08d7e2201e3e
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Apr 2020 16:06:26.9331 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: KWJ8+jmcZ5Zhaw0nwQ48FijmBDVt9K2fHlj+HIcWZFLPBrtqGnA0w3O8MLNm+OszAyvDQkSIo3P2DakuurA22Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3598
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

[AMD Official Use Only - Internal Distribution Only]

Reviewed-by: John Clements <John.Clements@amd.com>

-----Original Message-----
From: Chen, Guchun <Guchun.Chen@amd.com> 
Sent: Thursday, April 16, 2020 11:48 PM
To: amd-gfx@lists.freedesktop.org; Zhang, Hawking <Hawking.Zhang@amd.com>; Li, Dennis <Dennis.Li@amd.com>; Clements, John <John.Clements@amd.com>
Cc: Chen, Guchun <Guchun.Chen@amd.com>
Subject: [PATCH] drm/amdgpu: fix kernel page fault issue by ras recovery on sGPU

When running ras uncorrectable error injection and trigger GPU reset on sGPU, below issue is observed. It's caused by the list uninitialized when accessing.

[   80.047227] BUG: unable to handle page fault for address: ffffffffc0f4f750
[   80.047300] #PF: supervisor write access in kernel mode
[   80.047351] #PF: error_code(0x0003) - permissions violation
[   80.047404] PGD 12c20e067 P4D 12c20e067 PUD 12c210067 PMD 41c4ee067 PTE 404316061
[   80.047477] Oops: 0003 [#1] SMP PTI
[   80.047516] CPU: 7 PID: 377 Comm: kworker/7:2 Tainted: G           OE     5.4.0-rc7-guchchen #1
[   80.047594] Hardware name: System manufacturer System Product Name/TUF Z370-PLUS GAMING II, BIOS 0411 09/21/2018
[   80.047888] Workqueue: events amdgpu_ras_do_recovery [amdgpu]

Signed-off-by: Guchun Chen <guchun.chen@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
index b27d9d62c9df..260b4a42e0ae 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
@@ -1448,9 +1448,10 @@ static void amdgpu_ras_do_recovery(struct work_struct *work)
 	struct amdgpu_hive_info *hive = amdgpu_get_xgmi_hive(adev, false);
 
 	/* Build list of devices to query RAS related errors */
-	if  (hive && adev->gmc.xgmi.num_physical_nodes > 1) {
+	if  (hive && adev->gmc.xgmi.num_physical_nodes > 1)
 		device_list_handle = &hive->device_list;
-	} else {
+	else {
+		INIT_LIST_HEAD(&device_list);
 		list_add_tail(&adev->gmc.xgmi.head, &device_list);
 		device_list_handle = &device_list;
 	}
--
2.17.1
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
