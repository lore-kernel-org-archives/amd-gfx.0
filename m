Return-Path: <SRS0=KDYH=4M=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 901A1C3567B
	for <amd-gfx@archiver.kernel.org>; Mon, 24 Feb 2020 10:27:50 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6016B20828
	for <amd-gfx@archiver.kernel.org>; Mon, 24 Feb 2020 10:27:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="eYyqFNdt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6016B20828
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 064F689FC9;
	Mon, 24 Feb 2020 10:27:50 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2064.outbound.protection.outlook.com [40.107.93.64])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 87C7389FC9
 for <amd-gfx@lists.freedesktop.org>; Mon, 24 Feb 2020 10:27:48 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VrcYBCAjXQq2aEsv30Aciy0OaNKrkDcmMh9QIem56qugglSTAX9DGsxiqL9+g59YmMmmuUOOEl6uFecCIDRyR9L0YlZniA/1/LNOBRrFecMirrXQGGKAE6tgLv1sbGeWZTxIHiUC9S2duKc3w/EAF57f9rGxrQWsWFrscYKyNkXLW9k11Je2NFlFNF+RK3n3y/94mMkrtBI1m1nInJKgPbwkZ+/d9XS2oPZpxOFKVvgXjgs44u9Pleu+Or5Eac96nz7hgHYGNn5ZL33OdLEGbblnJ6PhGoc5cKc+dUcuxtftP48GU+1jYbcp9Z98yex1KkNCdYfY/ICu1GPGABXI6g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ei8nizTYX5khXIVO6WX9WeWtVevR1zUAOkuo7J6p3p0=;
 b=XGNzdzNbJc0OFZQthxiC2tsCmTxgm5umv5m9C6CdrkMmL4YXd9gj7E/lKNmknJ1XXIhbjV87lnWUpyojLfF2jksRtPNudNAA2y/q/qb6CI0dEjHVZrK43xI5qyhmnF6hLAD16bIyTnAJZAQ4sxuYKnPE1lrXqwMWuqMBEApMJnmEIwfc/aKVcmPY5Qn20NCAouY8/z5HDdSfGBk6iKKrlbzCp7KR+mbnW1tiFNW42AloZdyKXq8oYalcudj9d3PlugBwR5irA7DbUq4KkvBIkZzLhU5PkzPyHqXQXD4Dqzb6Wpn71UL8N7+EDH6eVOdxzrrIfqOzTAPoKs3ap/ibWw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ei8nizTYX5khXIVO6WX9WeWtVevR1zUAOkuo7J6p3p0=;
 b=eYyqFNdtkPrDSUgK2niofX290Z11Csz3MUineitqGjJvhDShQgEc4+f/llCvonai4uLykVBazT+RluLstsnsp8xZDL4TPM5t/4GtYjQ4YNmKLyAFHsQVmzstH4vd9y+XaLxLxZGs0SbHut109LN991GlYEcYzg4u4rd9AJ23jlM=
Received: from MN2PR12MB3344.namprd12.prod.outlook.com (2603:10b6:208:c5::10)
 by MN2PR12MB4158.namprd12.prod.outlook.com (2603:10b6:208:15f::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2750.21; Mon, 24 Feb
 2020 10:27:44 +0000
Received: from MN2PR12MB3344.namprd12.prod.outlook.com
 ([fe80::69c7:b493:690:2173]) by MN2PR12MB3344.namprd12.prod.outlook.com
 ([fe80::69c7:b493:690:2173%3]) with mapi id 15.20.2750.021; Mon, 24 Feb 2020
 10:27:44 +0000
From: "Quan, Evan" <Evan.Quan@amd.com>
To: "Zhang, Hawking" <Hawking.Zhang@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amdgpu: update psp firmwares loading sequence
Thread-Topic: [PATCH] drm/amdgpu: update psp firmwares loading sequence
Thread-Index: AQHV6vR6FPKp8pF8TkWyKSXFGIOxVagqINsAgAAAu4CAAABEAIAAAHLQ
Date: Mon, 24 Feb 2020 10:27:44 +0000
Message-ID: <MN2PR12MB3344F1675F6AAA3465C05377E4EC0@MN2PR12MB3344.namprd12.prod.outlook.com>
References: <20200224092417.7589-1-evan.quan@amd.com>
 <DM5PR12MB1418D5CF6F341DC174C6AF5EFCEC0@DM5PR12MB1418.namprd12.prod.outlook.com>
 <DM5PR12MB141877F6C4E39995151C8D93FCEC0@DM5PR12MB1418.namprd12.prod.outlook.com>
 <DM5PR12MB1418C508A68C7E2F4D738565FCEC0@DM5PR12MB1418.namprd12.prod.outlook.com>
In-Reply-To: <DM5PR12MB1418C508A68C7E2F4D738565FCEC0@DM5PR12MB1418.namprd12.prod.outlook.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Enabled=true;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SetDate=2020-02-24T10:15:45Z; 
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Method=Standard;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Name=Internal Use Only -
 Unrestricted;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ActionId=f0986d10-208a-4c63-a13d-000072765be6;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ContentBits=1
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Evan.Quan@amd.com; 
x-originating-ip: [180.167.199.189]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 19695339-9dd0-4744-fa2c-08d7b9142fac
x-ms-traffictypediagnostic: MN2PR12MB4158:|MN2PR12MB4158:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MN2PR12MB41582D5D8AC72CF07317E5BDE4EC0@MN2PR12MB4158.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7219;
x-forefront-prvs: 032334F434
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(4636009)(39860400002)(396003)(376002)(366004)(346002)(136003)(189003)(199004)(76116006)(186003)(5660300002)(9686003)(8936002)(55016002)(4326008)(86362001)(66476007)(66946007)(66446008)(66556008)(64756008)(26005)(71200400001)(316002)(8676002)(15650500001)(110136005)(2906002)(7696005)(478600001)(81156014)(6506007)(53546011)(52536014)(81166006)(33656002);
 DIR:OUT; SFP:1101; SCL:1; SRVR:MN2PR12MB4158;
 H:MN2PR12MB3344.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: rP1PHxaiDhrIiPBA17ZvEjmSigm9uC6WexVgJgh7Y7E06qsOySu92Ggh4lnQx2e++Ioq+IVIVMIklwnitnf773lkPHRjt78ho7EIX8DksIRSJ6jnZtPOvNSBP6gc+f3MTEl65QTqCt2uFLY0uGxjkxm1kRBlPhVttm1EzOtVcfsraPORfSOGXwLy36MrymIP1atbqSaiFsIJdV98Nqd2cr+92aNnuAdVZEJDpkYl7MqDVyl2tXH3PG5B1ZCaro5uXtD/Pcnz6/Uix0ltPqWSSUM75Q+RdAT+Q338+bguUDLcddHGcm5iHfNoKb4s2GSRqN+ZvyJ2jyxkR3PWoQ5m/CxhwWOwjEPwHN1YM27MvUFvCgmxvGXKfiOHtxljhjsNCvYYvgSW7O47ib8cREf8IX5BQ1qgCz086PUheKy9Gp1jMvhvWWjrQJ99OyyneHSr
x-ms-exchange-antispam-messagedata: yFmTVKObNmqodnrC49elfq2mWmec/4TvGlFHokLiUAgA1JIgxcIJHng3PUfM+1Vz69X+vadph5MuhsC09D9NwiXEXsjSWnlOuMGlGc+ea7tZs7gdjYz201TC+v9wl5wGPHkAiG7mvfTgJ4HE8iKARA==
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 19695339-9dd0-4744-fa2c-08d7b9142fac
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Feb 2020 10:27:44.4735 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: fYe/YmeKEa6n6IcjFtsM0ijNccYk88kIrtIOzp2X6MXx2a0PnByotWNiH7JKVJxJ
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4158
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
Cc: "Feng, Kenneth" <Kenneth.Feng@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Thanks. Will update that in V2.
Only Arcturus was affected since Navi1x was already protected by autoload_supported.

As I know, psp will skip smu fw loading if SMU is already alive. So, there should be no reloading.
But there should be a skip in driver.

Regards,
Evan
-----Original Message-----
From: Zhang, Hawking <Hawking.Zhang@amd.com> 
Sent: Monday, February 24, 2020 6:19 PM
To: Quan, Evan <Evan.Quan@amd.com>; amd-gfx@lists.freedesktop.org
Cc: Feng, Kenneth <Kenneth.Feng@amd.com>
Subject: RE: [PATCH] drm/amdgpu: update psp firmwares loading sequence

[AMD Official Use Only - Internal Distribution Only]

Sorry just for Navi12. Arcturus should be fine as it doesn't support autoload.

Regards,
Hawking

-----Original Message-----
From: Zhang, Hawking 
Sent: Monday, February 24, 2020 18:18
To: Quan, Evan <Evan.Quan@amd.com>; 'amd-gfx@lists.freedesktop.org' <amd-gfx@lists.freedesktop.org>
Cc: Feng, Kenneth <Kenneth.Feng@amd.com>
Subject: RE: [PATCH] drm/amdgpu: update psp firmwares loading sequence

[AMD Official Use Only - Internal Distribution Only]

That's saying I suspect the PMFW was loaded twice with the patch for Arcturus and Navi12.

Regards,
Hawking

-----Original Message-----
From: Zhang, Hawking 
Sent: Monday, February 24, 2020 18:16
To: Quan, Evan <Evan.Quan@amd.com>; amd-gfx@lists.freedesktop.org
Cc: Feng, Kenneth <Kenneth.Feng@amd.com>
Subject: RE: [PATCH] drm/amdgpu: update psp firmwares loading sequence

[AMD Official Use Only - Internal Distribution Only]

Can you double check the following logic after your setup the TMR in psp_np_fw_load? For Arcturus and Navi12, it should be skipped as well.

if (ucode->ucode_id == AMDGPU_UCODE_ID_SMC &&
    (psp_smu_reload_quirk(psp) || psp->autoload_supported))
			continue;

Regards,
Hawking
-----Original Message-----
From: Quan, Evan <Evan.Quan@amd.com> 
Sent: Monday, February 24, 2020 17:24
To: amd-gfx@lists.freedesktop.org
Cc: Zhang, Hawking <Hawking.Zhang@amd.com>; Feng, Kenneth <Kenneth.Feng@amd.com>; Quan, Evan <Evan.Quan@amd.com>
Subject: [PATCH] drm/amdgpu: update psp firmwares loading sequence

For those ASICs with DF Cstate management centralized to PMFW, TMR setup should be performed between pmfw loading and other non-psp firmwares loading.

Change-Id: I8986ddb4d9ffe63ed0823d1dce8d9d52812a1240
Signed-off-by: Evan Quan <evan.quan@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c | 61 +++++++++++++++++++++++--  drivers/gpu/drm/amd/amdgpu/amdgpu_psp.h |  2 +
 2 files changed, 58 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
index 51839ab02b84..ef800ad68e1c 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
@@ -38,6 +38,39 @@
 
 static void psp_set_funcs(struct amdgpu_device *adev);
 
+/*
+ * Due to DF Cstate management centralized to PMFW, the firmware
+ * loading sequence will be updated as below:
+ *   - Load KDB
+ *   - Load SYS_DRV
+ *   - Load tOS
+ *   - Load PMFW
+ *   - Setup TMR
+ *   - Load other non-psp fw
+ *   - Load ASD
+ *   - Load XGMI/RAS/HDCP/DTM TA if any
+ *
+ * This new sequence is required for
+ *   - Arcturus
+ *   - Navi12 and onwards
+ */
+static void psp_check_pmfw_centralized_cstate_management(struct 
+psp_context *psp) {
+	struct amdgpu_device *adev = psp->adev;
+
+	psp->pmfw_centralized_cstate_management = false;
+
+	if (amdgpu_sriov_vf(adev))
+		return;
+
+	if (adev->flags & AMD_IS_APU)
+		return;
+
+	if ((adev->asic_type == CHIP_ARCTURUS) ||
+	    (adev->asic_type >= CHIP_NAVI12))
+		psp->pmfw_centralized_cstate_management = true; }
+
 static int psp_early_init(void *handle)  {
 	struct amdgpu_device *adev = (struct amdgpu_device *)handle; @@ -75,6 +108,8 @@ static int psp_early_init(void *handle)
 
 	psp->adev = adev;
 
+	psp_check_pmfw_centralized_cstate_management(psp);
+
 	return 0;
 }
 
@@ -1116,10 +1151,17 @@ static int psp_hw_start(struct psp_context *psp)
 		return ret;
 	}
 
-	ret = psp_tmr_load(psp);
-	if (ret) {
-		DRM_ERROR("PSP load tmr failed!\n");
-		return ret;
+	/*
+	 * For those ASICs with DF Cstate management centralized
+	 * to PMFW, TMR setup should be performed after PMFW
+	 * loaded and before other non-psp firmware loaded.
+	 */
+	if (!psp->pmfw_centralized_cstate_management) {
+		ret = psp_tmr_load(psp);
+		if (ret) {
+			DRM_ERROR("PSP load tmr failed!\n");
+			return ret;
+		}
 	}
 
 	return 0;
@@ -1316,7 +1358,8 @@ static int psp_np_fw_load(struct psp_context *psp)
 	struct amdgpu_firmware_info *ucode;
 	struct amdgpu_device* adev = psp->adev;
 
-	if (psp->autoload_supported) {
+	if (psp->autoload_supported ||
+	    psp->pmfw_centralized_cstate_management) {
 		ucode = &adev->firmware.ucode[AMDGPU_UCODE_ID_SMC];
 		if (!ucode->fw || amdgpu_sriov_vf(adev))
 			goto out;
@@ -1326,6 +1369,14 @@ static int psp_np_fw_load(struct psp_context *psp)
 			return ret;
 	}
 
+	if (psp->pmfw_centralized_cstate_management) {
+		ret = psp_tmr_load(psp);
+		if (ret) {
+			DRM_ERROR("PSP load tmr failed!\n");
+			return ret;
+		}
+	}
+
 out:
 	for (i = 0; i < adev->firmware.max_ucodes; i++) {
 		ucode = &adev->firmware.ucode[i];
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.h
index c77e1abb538a..37fa184f27f6 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.h
@@ -264,6 +264,8 @@ struct psp_context
 	atomic_t			fence_value;
 	/* flag to mark whether gfx fw autoload is supported or not */
 	bool				autoload_supported;
+	/* flag to mark whether df cstate management centralized to PMFW */
+	bool				pmfw_centralized_cstate_management;
 
 	/* xgmi ta firmware and buffer */
 	const struct firmware		*ta_fw;
--
2.25.0
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
