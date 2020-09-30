Return-Path: <SRS0=9SYE=DH=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F06FC2D0A8
	for <amd-gfx@archiver.kernel.org>; Wed, 30 Sep 2020 05:21:58 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A26B820659
	for <amd-gfx@archiver.kernel.org>; Wed, 30 Sep 2020 05:21:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="t9EQAm+S"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A26B820659
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B0F776E090;
	Wed, 30 Sep 2020 05:21:56 +0000 (UTC)
Received: from NAM02-CY1-obe.outbound.protection.outlook.com
 (mail-eopbgr760079.outbound.protection.outlook.com [40.107.76.79])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 38AD36E090
 for <amd-gfx@lists.freedesktop.org>; Wed, 30 Sep 2020 05:21:55 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BKTfnziI7d95AptoG9yrG5kntSwE5rLF9mf1Laabvjfmf2+UedXWAiX0Iei0X38Pxq7qiPheixj+2rXFrUo+NJHfdAFdTrslKxv9YrRU//X3Mmn05JTRRnoIPC+vQ2IsFOJ4Iea64YFznZbyECHwwvFLIfTlPYVqAYnVM0ojeK+pyOZonhxWTzWvn54ERgCd/KZUKJuRjjJHnrTX7tta859eda2XV5mAE4/G/tWYxogWS8uWJ7QawrEFv5MaQRXctafdcmngSkQ9WFQGu7tkQy78G9WfjfPbGlR7vdfQfv6fDPDKSKVtEfdCm+D1XQocPHRRKiol6vA4APmPxnCjqA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rojh12rLYr6QOGhs+baRhkU2b51H/JNf4BDIUMihV1k=;
 b=RuKDm7TaFtyaHfMFs61tejGW8c5np+CsTCTUIyL0DSaomImnB6VXNdD5HXzMHzzEJ/s5i/ETw7VzisdjuRnbUFMNxL817omHpRmiqk4wPH0Lu0S1ZJvB5nQSugLDY7yPW2m3xzJrTgoXTGagVWotQfKH7tu+W08cCPN0ricGUb8QSakeGTTKHmAa9Q+WXPDyeTJB9h/1RcFEqNFUUBO7W0aculU6wBwq9j0ddL6VK6jgF5FYznMLADNnn7dzu702Ss2zcvsfMVF7t9NMOVn3wCoze9Jko7U4sGATKxaFHV/cu1aF5nXDmTw5VsU13zw5bdY8LgLw5YaGxzyqg9mTww==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rojh12rLYr6QOGhs+baRhkU2b51H/JNf4BDIUMihV1k=;
 b=t9EQAm+SaMHkJBxgITBtJExMuQURv4MuiC4dp8lS5tcTmXHdxvf3cEPTg16VGeGMPFfdFyUrgbTnJIwaeqjKR7rkNBu0TRMoudX7MXU1/I18l0j9bD7Fo2054crR2mXt4ynNEkjaK61eZF8SgjNGpXZqJFFDV2SYF4MJK1nEW/o=
Received: from DM6PR12MB4075.namprd12.prod.outlook.com (2603:10b6:5:21d::8) by
 DM6PR12MB4385.namprd12.prod.outlook.com (2603:10b6:5:2a6::14) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3433.32; Wed, 30 Sep 2020 05:21:49 +0000
Received: from DM6PR12MB4075.namprd12.prod.outlook.com
 ([fe80::b51c:2b0e:7e1:b233]) by DM6PR12MB4075.namprd12.prod.outlook.com
 ([fe80::b51c:2b0e:7e1:b233%9]) with mapi id 15.20.3412.029; Wed, 30 Sep 2020
 05:21:49 +0000
From: "Zhang, Hawking" <Hawking.Zhang@amd.com>
To: "Chen, Guchun" <Guchun.Chen@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>, "Deucher, Alexander"
 <Alexander.Deucher@amd.com>, "Li, Dennis" <Dennis.Li@amd.com>, "Zhou1, Tao"
 <Tao.Zhou1@amd.com>, "Clements, John" <John.Clements@amd.com>
Subject: RE: [PATCH] drm/amdgpu: drop duplicated ecc check for vega10 (v4)
Thread-Topic: [PATCH] drm/amdgpu: drop duplicated ecc check for vega10 (v4)
Thread-Index: AQHWluOAHkM8axSAy02iX/evvpixVamApUnA
Date: Wed, 30 Sep 2020 05:21:49 +0000
Message-ID: <DM6PR12MB4075BD2B8AC0BF9EC7B1E106FC330@DM6PR12MB4075.namprd12.prod.outlook.com>
References: <20200930043752.25037-1-guchun.chen@amd.com>
In-Reply-To: <20200930043752.25037-1-guchun.chen@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Enabled=true;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_SetDate=2020-09-30T05:21:45Z; 
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Method=Privileged;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Name=Public_0;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_ActionId=25c94994-18cc-42e4-b720-00009dfe8dac;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_ContentBits=1
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_enabled: true
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_setdate: 2020-09-30T05:21:37Z
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_method: Standard
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_name: Internal Use Only -
 Unrestricted
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_actionid: 620b1fd7-7dbc-4836-8192-0000af4c840a
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_contentbits: 0
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_enabled: true
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_setdate: 2020-09-30T05:21:46Z
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_method: Privileged
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_name: Public_0
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_actionid: 626b52a5-4bbb-49a7-8bcb-0000b30c8cf0
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_contentbits: 0
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [58.247.170.242]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: ee2015c9-1a78-457f-c208-08d86500bbcc
x-ms-traffictypediagnostic: DM6PR12MB4385:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM6PR12MB4385D38F1238FB32358FE5DEFC330@DM6PR12MB4385.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 5d9lk7ZFe7BE0KPn2CBL3cbvAUoaH2izfRfVUmzjNC3LyiVDei4u/7USTIC9KG63oMNS9Coj7gji+eknpISaaNF6fZZ0k5wl4RDRfy4tZLlNVoI5ZAqxM5I42/GkRkZ5eFONztAUdgmpyQN8CUL1p4auRkTgZAbVUr0I1i4qqR2pEWiRoVuLCVhI9WvI5DCp7MlT79vtR11vAbzNg2B+BrwqWHUplUNerj1jvZj1/ZmCnR1htDPUqOst8BY+buTstonulzQ86PwNzzYcRtXjcgkKhxKAzLKn+12S9CXDr3YLBYHc4VqmY1chzNTLSE7zVGjJtglAvT5jSd/l1w6pqoAkmrhyqLwGWxrySUD9uSxw87m1OCbVQ3petbqB2mmr
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB4075.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(136003)(366004)(39850400004)(376002)(346002)(396003)(110136005)(71200400001)(186003)(26005)(83380400001)(7696005)(53546011)(6506007)(2906002)(76116006)(33656002)(478600001)(55016002)(6636002)(86362001)(9686003)(316002)(8936002)(5660300002)(8676002)(52536014)(66946007)(64756008)(66556008)(66476007)(66446008)(921003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: SNzuJAD5FBUV2AWlOXCfWy0ECA7ZPe6dpPwyb9X6bzoPtfHkOAEwbdnCoawmwQXsKWT7g4+XOK8y8Ti/jCyz9wILZHufj2u+ubpre69BFNW+oChYrfD5bgeJfQ/dx7YYNrRKFmmPiqbDmtDqNTGEPNKZWgqrmi36y5Tv/pKna/Vuv345fJpA1aTUPeMQZrCRymgKAQZPzTPSv5V7Poi4CU3pQFe1Ox6F7wFlg15hdk2W4d/SS+LRgJ3jzCC1Wg2aJxpvqpLaUgLrviPQZtAle2gjeZr2xF//JjDzL5Dd1ZlbhbQAcvg5KETjGYmZevU9hVPWMprfpSxL3TY6VaiRiEXzkbdGGewxqjy2Aeq0lPeRZXZBbi8Y8qjbLgQ02PNkwqzOa5xRBlYUnpKk8yYnfSx/sMrRzPh1rM435r+zEJR/cjIm95AGgwiVgT6vr921tjdUS05QRSGDWCo9VsH6ufibmvt8s3wpqYYrmctG7xH+47cO7M5rn5o3tV7Qm95rqYqWR3p2NzI/zS8cAN7bPrhJqiGoi8poaROSOnlGre54TbrIfcgvNwAkuIAL03WrOLnDHGLTOGgctDc1/YAF7XuEW7ZFCGdwkDjPkDun1QEotUSsheSnH9BQwbskFaTr3zYojgZioV7e7vPMChAzHw==
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4075.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ee2015c9-1a78-457f-c208-08d86500bbcc
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Sep 2020 05:21:49.5998 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: wQQnhf/kg05XYEiSttfEKM45m7Lsf8mRFcnfiVT0QWwFZe2xi+cd9k8OsM0pziTb+92CfVSSSl2TvrHqJGORyA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4385
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

Series is 

Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>

Regards,
Hawking
-----Original Message-----
From: Chen, Guchun <Guchun.Chen@amd.com> 
Sent: Wednesday, September 30, 2020 12:38
To: amd-gfx@lists.freedesktop.org; Deucher, Alexander <Alexander.Deucher@amd.com>; Zhang, Hawking <Hawking.Zhang@amd.com>; Li, Dennis <Dennis.Li@amd.com>; Zhou1, Tao <Tao.Zhou1@amd.com>; Clements, John <John.Clements@amd.com>
Cc: Chen, Guchun <Guchun.Chen@amd.com>
Subject: [PATCH] drm/amdgpu: drop duplicated ecc check for vega10 (v4)

The same ECC check has been executed in amdgpu_ras_init for vega10, prior to gmc_v9_0_late_init.

v2: drop all atombios helper callings
v3: use bit operation
v4: correct inline comment, remove parity check statement

Signed-off-by: Guchun Chen <guchun.chen@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c | 19 +++++++------------
 1 file changed, 7 insertions(+), 12 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
index 3dddbc60fe3d..3784483badcf 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
@@ -1193,21 +1193,16 @@ static int gmc_v9_0_late_init(void *handle)
 	r = amdgpu_gmc_allocate_vm_inv_eng(adev);
 	if (r)
 		return r;
-	/* Check if ecc is available */
+
+	/*
+	 * Workaround performance drop issue with VBIOS enables partial
+	 * writes, while disables HBM ECC for vega10.
+	 */
 	if (!amdgpu_sriov_vf(adev) && (adev->asic_type == CHIP_VEGA10)) {
-		r = amdgpu_atomfirmware_mem_ecc_supported(adev);
-		if (!r) {
-			DRM_INFO("ECC is not present.\n");
+		if (!(adev->ras_features & (1 << AMDGPU_RAS_BLOCK__UMC)) {
 			if (adev->df.funcs->enable_ecc_force_par_wr_rmw)
 				adev->df.funcs->enable_ecc_force_par_wr_rmw(adev, false);
-		} else
-			DRM_INFO("ECC is active.\n");
-
-		r = amdgpu_atomfirmware_sram_ecc_supported(adev);
-		if (!r)
-			DRM_INFO("SRAM ECC is not present.\n");
-		else
-			DRM_INFO("SRAM ECC is active.\n");
+		}
 	}
 
 	if (adev->mmhub.funcs && adev->mmhub.funcs->reset_ras_error_count)
--
2.17.1
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
