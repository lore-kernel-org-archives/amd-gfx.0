Return-Path: <SRS0=8BU1=C7=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BED81C4363D
	for <amd-gfx@archiver.kernel.org>; Tue, 22 Sep 2020 07:27:19 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2106921548
	for <amd-gfx@archiver.kernel.org>; Tue, 22 Sep 2020 07:27:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="GCQenf9a"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2106921548
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8E1928997E;
	Tue, 22 Sep 2020 07:27:18 +0000 (UTC)
Received: from NAM02-SN1-obe.outbound.protection.outlook.com
 (mail-eopbgr770087.outbound.protection.outlook.com [40.107.77.87])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2EA4D8930E
 for <amd-gfx@lists.freedesktop.org>; Tue, 22 Sep 2020 07:25:04 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=j3tviY2YxP5WakSPu3y3LChCOiWOOyPKogR+rntRLytrJ5IHYN+726q7l4+9LALyMBnfQbEEyBWczSqvl6KOJ05gaWcEG2MpHKa9fxg7CGvHVeTFlI2o0rLxF9N9wHgb4FFBTrCE/rtt6h94AX7xQg7L6CD3jUOBJNYJ+vdYRJ4eseBs7idHG6z1I1NmR47ud7ar8jEcapwkoHfj4qiEx5+Xrf1FKQVCPGzqriv9r3hC0F4P/yThjFlpJyJjkiPX2xuGcl6ZJQ5Qq5e8ACHxZ16cjjm9H9O3J1FaOJZgQN6aThnlrk8pTcYQBma0CMmAb+L+sGW+PnE8yCTuzo3EeQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0vF6CQh8XJtbydfIz2pakBAyqjt7PbWzLD0BxZMJOsw=;
 b=nA1hOc0jMMpH9lXk6QVCmv/r1j8D6zYTSq9uixrDG4KA0f6OsTBTfxqo/X67oPC6fp/iasQjLmIdtJcn4fBFwR/btt9Un648XZzxh8IPMpzI5MEo8pBJ5hs+hkd8XjDT2BjHv3ghy4j5FHJ2ZfQoTqIoxh2i+OA5f+j4CJpaEcyj9iqyTSbB1slaHoCTDtOuiLzkwGl0b53EL52U6r5BKV0A7RevlqxIDEUZ2Iv7sYz7Kdw80Aq3dfUScwF425uUzUnlyHQoV+TZutrAAN61SbL/wKQm77FgUjh+9NR1t6tRtipsmWTLYcZ4QlbzxwNBy0C1HoSGMvO2cJTvzJz+ng==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0vF6CQh8XJtbydfIz2pakBAyqjt7PbWzLD0BxZMJOsw=;
 b=GCQenf9aldA+/Kpzf7WPub6dAc0H2mFJ6/W6OnxRTG0LcpQi6H5fSd6r4YO6R8UHR3cxDMTU6vam2XDu+1r6DxftDu3Xp5/fUTtJWtE+4V9BkySx83gp/7yhLmkpqMOoHcPijlHVNiUX87BfXGGryqORggnSAI5VRzXD5IZ2R6c=
Received: from DM6PR12MB4075.namprd12.prod.outlook.com (2603:10b6:5:21d::8) by
 DM6PR12MB4699.namprd12.prod.outlook.com (2603:10b6:5:36::24) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3391.11; Tue, 22 Sep 2020 07:25:03 +0000
Received: from DM6PR12MB4075.namprd12.prod.outlook.com
 ([fe80::b51c:2b0e:7e1:b233]) by DM6PR12MB4075.namprd12.prod.outlook.com
 ([fe80::b51c:2b0e:7e1:b233%9]) with mapi id 15.20.3412.020; Tue, 22 Sep 2020
 07:25:03 +0000
From: "Zhang, Hawking" <Hawking.Zhang@amd.com>
To: "Chen, JingWen" <JingWen.Chen2@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH 2/2] drm/amd: Skip not used microcode loading in SRIOV
Thread-Topic: [PATCH 2/2] drm/amd: Skip not used microcode loading in SRIOV
Thread-Index: AQHWkK9SYjzu26SjKEWL2Mxo6esohKl0P4WA
Date: Tue, 22 Sep 2020 07:25:02 +0000
Message-ID: <DM6PR12MB40754DDA2888F313D7C18005FC3B0@DM6PR12MB4075.namprd12.prod.outlook.com>
References: <20200922070842.366545-1-Jingwen.Chen2@amd.com>
 <20200922070842.366545-2-Jingwen.Chen2@amd.com>
In-Reply-To: <20200922070842.366545-2-Jingwen.Chen2@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Enabled=true;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_SetDate=2020-09-22T07:24:57Z; 
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Method=Privileged;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Name=Public_0;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_ActionId=8f1406e2-c69a-4ade-bb96-000088f047aa;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_ContentBits=1
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_enabled: true
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_setdate: 2020-09-22T07:24:50Z
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_method: Standard
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_name: Internal Use Only -
 Unrestricted
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_actionid: 4126e39d-61c8-4ec1-9d20-0000c72276e4
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_contentbits: 0
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_enabled: true
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_setdate: 2020-09-22T07:25:00Z
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_method: Privileged
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_name: Public_0
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_actionid: 93b7eeda-7aa8-45a5-9799-0000c0ef30a4
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_contentbits: 0
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [58.247.170.242]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 86cbb73c-75e4-446a-8b23-08d85ec89f3e
x-ms-traffictypediagnostic: DM6PR12MB4699:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM6PR12MB46991E14C0F634A91488A660FC3B0@DM6PR12MB4699.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: MHd2C/UDDSsOKGBDFUHtap/6qufRVcGfC1baWwLocs0v+I+uFzgc/6/bPXewirKF+zsOPlK0paXaYixlFU1spzKC84gSXuKz7jcIJUtXZrvDYuiMfrouEWahtkN5g45wE2FJG805cIz8frzysGwg1DOWJ3l8AQyZW9EYJXL6gFBdUzw1a6S8W6U9T9F2zD0Ssbw0I5pBPn8RchlIGQDCy3k8ZjxEuJXLaV+OeinGaHbBEIwNdIKFrXmOiYuJBeHJt8Rc5AQxKQsdZWems5Wof+s0e995RhgnGbZmw1zZFUZQJc3QF9f0pwkpJDA8FFJYoODXD4ToMLX+vBEbeCSiq7fZrhr2j9ouBKyBOS4z4rk=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB4075.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(136003)(346002)(366004)(396003)(39860400002)(376002)(66446008)(64756008)(66556008)(45080400002)(6506007)(53546011)(71200400001)(5660300002)(76116006)(478600001)(8936002)(7696005)(26005)(186003)(86362001)(8676002)(966005)(83380400001)(66476007)(66946007)(4326008)(33656002)(52536014)(316002)(2906002)(110136005)(9686003)(55016002);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: WAoDgCk2jked8JwxdJYkVz59wUNMymU36A54AnTOiHEJrQ3EHJqBX3amRUwps+1y2DOM9RtktQknIGhQl4Rlaz1APl6YAgDLnj+bkOJA/fZlWVY/MjZmxT1X3vVAF9uKmLaMBTVIlsdz8E8hx2BpLJQa6Skc1NMmAzXHxvIk4xCgOsmp4rggEfo0vc9X3OGxHY5BeGSTGwncIYZXZHvTGktKX+/Pm46yhOO/aWrTGLmHUudwtFqFCXJgFzpSd4F0STNneKBgydh0Mrfkoc5ilQE9gXaW8hXD9XjIOiwPVi1UUwmgrqX6aTXus9pBbZWbNpAEkjlYWKk4YkUatNfaAbeej0uzXgPWKDGKHBLk4mJB+Ry/6STMHMtmgKuPxAaFhWuQjRHW/BBWMlMxacTGyNBkL36lRmzWOQMbQynqj33piq0LsuEhqSdAMIeDOpciDZHDHrgebdlHzMLxzXJyxbFfEoisL9pg+XdjWFc7IawozTQ8ssCb3CXSh2+gzyQrT/c+MqmX6bD1RktSPC6i4/bobpTR9IQmlG28ndNsH5kBHlA3S0O2FSUjtVEsncv/EnMBM8AyCtumdhaTIv3bFngChsQi8hLVoSc5fZT3rR9UbFpgnXgOZL8jEzVdr5ebuPb5nJDWecG7un9fekOA+w==
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4075.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 86cbb73c-75e4-446a-8b23-08d85ec89f3e
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Sep 2020 07:25:02.9468 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: EDJ/Ub6sQVrd4yX6x2evp6uC1uM4y5obv3cDw1GwRT0MxWY0psjsu9+6SEDIWxB3Rfoj20YDHN/tCnrLHIogrQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4699
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
Cc: "Chen, JingWen" <JingWen.Chen2@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Public Use]

1. Please do not add the amdgpu_sriov_vf check in every psp fw init_microcode function. psp_init_microcode is the entry point for all kinds of psp fw microcode initialization.
2. I'd like to get a whole picture on all the sequence you want to skip from guest side so that we can have more organized/reasonable approach to exclude those programing sequence for SRIOV, instead of having the amdgpu_sriov_vf patched case by case...

Regards,
Hawking

-----Original Message-----
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Jingwen Chen
Sent: Tuesday, September 22, 2020 15:09
To: amd-gfx@lists.freedesktop.org
Cc: Chen, JingWen <JingWen.Chen2@amd.com>
Subject: [PATCH 2/2] drm/amd: Skip not used microcode loading in SRIOV

smc, sdma, sos, ta and asd fw is not used in SRIOV. Skip them to accelerate sw_init for navi12.

v2: skip above fw in SRIOV for vega10 and sienna_cichlid
Signed-off-by: Jingwen Chen <Jingwen.Chen2@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c              |  9 +++++++++
 drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c               |  3 +++
 drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c               |  3 +++
 drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c               |  3 +++
 .../gpu/drm/amd/pm/powerplay/smumgr/vega10_smumgr.c  | 12 +++++++-----
 drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c            | 11 +++++++----
 6 files changed, 32 insertions(+), 9 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
index 2c66e20b2ed9..9e2038de6ea7 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
@@ -2385,6 +2385,9 @@ int psp_init_asd_microcode(struct psp_context *psp,
 	const struct psp_firmware_header_v1_0 *asd_hdr;
 	int err = 0;
 
+	if (amdgpu_sriov_vf(adev))
+		return 0;
+
 	if (!chip_name) {
 		dev_err(adev->dev, "invalid chip name for asd microcode\n");
 		return -EINVAL;
@@ -2424,6 +2427,9 @@ int psp_init_sos_microcode(struct psp_context *psp,
 	const struct psp_firmware_header_v1_3 *sos_hdr_v1_3;
 	int err = 0;
 
+	if (amdgpu_sriov_vf(adev))
+		return 0;
+
 	if (!chip_name) {
 		dev_err(adev->dev, "invalid chip name for sos microcode\n");
 		return -EINVAL;
@@ -2558,6 +2564,9 @@ int psp_init_ta_microcode(struct psp_context *psp,
 	int err = 0;
 	int ta_index = 0;
 
+	if (amdgpu_sriov_vf(adev))
+		return 0;
+
 	if (!chip_name) {
 		dev_err(adev->dev, "invalid chip name for ta microcode\n");
 		return -EINVAL;
diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c b/drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c
index 810635cbf4c1..86fb1eddf5a6 100644
--- a/drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c
@@ -592,6 +592,9 @@ static int sdma_v4_0_init_microcode(struct amdgpu_device *adev)
 	struct amdgpu_firmware_info *info = NULL;
 	const struct common_firmware_header *header = NULL;
 
+	if (amdgpu_sriov_vf(adev))
+		return 0;
+
 	DRM_DEBUG("\n");
 
 	switch (adev->asic_type) {
diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c b/drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c
index 48c95a78a173..9c72b95b7463 100644
--- a/drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c
@@ -203,6 +203,9 @@ static int sdma_v5_0_init_microcode(struct amdgpu_device *adev)
 	const struct common_firmware_header *header = NULL;
 	const struct sdma_firmware_header_v1_0 *hdr;
 
+	if (amdgpu_sriov_vf(adev))
+		return 0;
+
 	DRM_DEBUG("\n");
 
 	switch (adev->asic_type) {
diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c b/drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c
index 34ccf376ee45..9f3952723c63 100644
--- a/drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c
+++ b/drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c
@@ -148,6 +148,9 @@ static int sdma_v5_2_init_microcode(struct amdgpu_device *adev)
 	struct amdgpu_firmware_info *info = NULL;
 	const struct common_firmware_header *header = NULL;
 
+	if (amdgpu_sriov_vf(adev))
+		return 0;
+
 	DRM_DEBUG("\n");
 
 	switch (adev->asic_type) {
diff --git a/drivers/gpu/drm/amd/pm/powerplay/smumgr/vega10_smumgr.c b/drivers/gpu/drm/amd/pm/powerplay/smumgr/vega10_smumgr.c
index 1e222c5d91a4..daf122f24f23 100644
--- a/drivers/gpu/drm/amd/pm/powerplay/smumgr/vega10_smumgr.c
+++ b/drivers/gpu/drm/amd/pm/powerplay/smumgr/vega10_smumgr.c
@@ -209,11 +209,13 @@ static int vega10_smu_init(struct pp_hwmgr *hwmgr)
 	int ret;
 	struct cgs_firmware_info info = {0};
 
-	ret = cgs_get_firmware_info(hwmgr->device,
-				    CGS_UCODE_ID_SMU,
-				    &info);
-	if (ret || !info.kptr)
-		return -EINVAL;
+	if (!amdgpu_sriov_vf((struct amdgpu_device *)hwmgr->adev)) {
+		ret = cgs_get_firmware_info(hwmgr->device,
+						CGS_UCODE_ID_SMU,
+						&info);
+		if (ret || !info.kptr)
+			return -EINVAL;
+	}
 
 	priv = kzalloc(sizeof(struct vega10_smumgr), GFP_KERNEL);
 
diff --git a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
index 538e6f5e19eb..3010cb31324a 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
@@ -832,10 +832,13 @@ static int smu_sw_init(void *handle)
 
 	smu->smu_dpm.dpm_level = AMD_DPM_FORCED_LEVEL_AUTO;
 	smu->smu_dpm.requested_dpm_level = AMD_DPM_FORCED_LEVEL_AUTO;
-	ret = smu_init_microcode(smu);
-	if (ret) {
-		dev_err(adev->dev, "Failed to load smu firmware!\n");
-		return ret;
+
+	if (!amdgpu_sriov_vf(adev)) {
+		ret = smu_init_microcode(smu);
+		if (ret) {
+			dev_err(adev->dev, "Failed to load smu firmware!\n");
+			return ret;
+		}
 	}
 
 	ret = smu_smc_table_sw_init(smu);
--
2.25.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Flists.freedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;data=02%7C01%7Chawking.zhang%40amd.com%7Cea76bd18f89f4ae12fcd08d85ec67345%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637363553725085588&amp;sdata=JfOYc84afi3hoePrWjP%2FON8yJZJW%2BrS%2FEkYjtdrgvnc%3D&amp;reserved=0
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
