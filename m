Return-Path: <SRS0=NRDG=IQ=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0BD49C433E0
	for <amd-gfx@archiver.kernel.org>; Thu, 18 Mar 2021 09:27:52 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 88C0B64ED2
	for <amd-gfx@archiver.kernel.org>; Thu, 18 Mar 2021 09:27:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 88C0B64ED2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2215D6E0D1;
	Thu, 18 Mar 2021 09:27:51 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2082.outbound.protection.outlook.com [40.107.243.82])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 677BE6E0DB
 for <amd-gfx@lists.freedesktop.org>; Thu, 18 Mar 2021 09:27:49 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=f7FFxURgcZAWml3wAYZ7oKz59M9y8ux6v2Jt6ddaWvuhP91z7VoQMNN8rYDqVXrdJuND43FUqca1vwXMIdALCNvonEu49GEOJ8ClY6CBV9xr0nzGXYyb0THcEgIxFUiE/tHLQO/8XdE0WwAPOOzsV92+xj6ULVuQrKg6Jm+2U6f8fv5Op9AAA+NTWJUJpaJQhO8NaIS0ZXNZIxE83/Fti+MgyEgPtXCffYE2TiCmnAFc7iVy9i7q0Mb24zQWE8+EQRmSo3u38bDW+vzf+NyM1EBOJ8YeFrRpBIAVqTcIo648Nr4SSYHul2ISZXbsFdhYlK+O+vr4ZYya/vEwIIjbFw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sbVWjRsSlORTy5D9TDkUcp7VDKhcumV9GC8W/dFZOTw=;
 b=aDSg/YM+eNrZ44Vde01W7AAmeDpTjznrgmWG0g/UxECY+GcOdlgiEkZ3ao01KN4fSf/aaCkF/c22Mm3i6TKW/KMq3LhX31BZna4pdh4JcH54npp3dxxlVzyyrqI7pF+gdE0Of/Vx3c7vs1iIR4/QubZUJMLS9+M4Hd2qPWCUudAW3zrfJ0lPuRcO7wAsRtZ5v9W0U6htM2TgD7LxJHPIZWSC1m0oS59JF2MKJgacn/nudIl8PIQ4rrVyVwWD3/Xx8/cdVuxLJuQu9M6kIhLxNMtHVGD6Yup+rqO+ftOIM4x/jU17NITy0RLYaxQUBPRWLI4/GK5q8RJ+neB9xnMzFQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sbVWjRsSlORTy5D9TDkUcp7VDKhcumV9GC8W/dFZOTw=;
 b=VeHmb3H3+bdVXcAv6H8TJf7OzhwtOLrnWuHIdoU0dFMd2MQdJgvgOgv7T8e5zubCR6EpsgPaj++iNR2AISMJxeg0T6mX4X1fvqIhrDd6R7qz0vdpkmvpc3Jro4Dn2w4AHtAyGr6v1U7GVPKoVAha7sdkekhQ3nsbBo9p5yUK86M=
Received: from CY4PR12MB1287.namprd12.prod.outlook.com (2603:10b6:903:40::8)
 by CY4PR1201MB0005.namprd12.prod.outlook.com (2603:10b6:903:d1::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3933.31; Thu, 18 Mar
 2021 09:27:44 +0000
Received: from CY4PR12MB1287.namprd12.prod.outlook.com
 ([fe80::8908:d7:5544:6007]) by CY4PR12MB1287.namprd12.prod.outlook.com
 ([fe80::8908:d7:5544:6007%8]) with mapi id 15.20.3933.033; Thu, 18 Mar 2021
 09:27:44 +0000
From: "Chen, Guchun" <Guchun.Chen@amd.com>
To: "Quan, Evan" <Evan.Quan@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amd/pm: fix Navi1x runtime resume failure V2
Thread-Topic: [PATCH] drm/amd/pm: fix Navi1x runtime resume failure V2
Thread-Index: AQHXG9gRxXyfuP0ebkW4Yy5wJUwmwaqJeXyw
Date: Thu, 18 Mar 2021 09:27:44 +0000
Message-ID: <CY4PR12MB1287D25EBCB9DC7DE4D1B45AF1699@CY4PR12MB1287.namprd12.prod.outlook.com>
References: <20210318092055.437406-1-evan.quan@amd.com>
In-Reply-To: <20210318092055.437406-1-evan.quan@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Enabled=true;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_SetDate=2021-03-18T09:27:40Z; 
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Method=Privileged;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Name=Public_0;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_ActionId=13c3d2a1-4ba0-40fe-a480-83a0057d9526;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_ContentBits=1
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [180.167.199.189]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: aca8c393-7312-4b1d-3246-08d8e9f015fe
x-ms-traffictypediagnostic: CY4PR1201MB0005:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <CY4PR1201MB00058BC105DC6906C75A7598F1699@CY4PR1201MB0005.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: AopWdbByeFgp4DnEFto1KkOClzOSMtS1i90NmvQmq4d69kaY951i1Mol72Zb4cVcrS0f1XD5Q60hqGZUqQ+C7NH18gsLu0ZBV+kGCVHVq2S0AOILYTq7FolHUdAsoXB1igLeFgdcguo2ASITL7f1RXJNAmdALiHVtehB20fMpNzXnufy0YnkhPh/Z+q68a4ywStNJr5tF21E3j+5SMmrzf3nglXc9O7yeVX0n+8N6q0xa0z/RuSXWEA00bLwVDAdn14kFAC2wmhPcqyRKrxbv0tXV/ka4URHvcZyaoBZpSLDroTZRwzdgGDKkITa60ZkHiU2ryo6maBl9olTdpY0UkofpV1JptflkA40YCimGhR0CR+s2HN1vneq6hnQcPDZ9T0VWsGdia6pSXj2DGk/9nXs3ZqiLPspCftjhVXAeLTucEAMBXMJ6eIGWbTQzub41YvhJIzjXnswGi5HGfRkcS7QNH+2CIAYNNeoz+vEv77Udb+NOVdcA7PLhhEypTmiT/6HZM4Rih3bANcdwTuiSpAy52xX1PxTBKstF7clOUG0+0fIEoZTdRkg02y5H4qSRcPeCk6YUX1RAjxdeUPNqfOyUN0HoViC3Pxn6ThalGPG0R3ivPLrkhfwkMDzb6VbmrTPk8k9sl9D9LBQ1amIP2PiI/pw1mnI6ZJltgE247ty6SJ+6a2d8g1X0en0lS5e
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CY4PR12MB1287.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(136003)(376002)(346002)(396003)(39860400002)(366004)(71200400001)(55016002)(7696005)(186003)(45080400002)(83380400001)(2906002)(6506007)(5660300002)(110136005)(54906003)(38100700001)(86362001)(316002)(53546011)(66556008)(64756008)(8676002)(8936002)(4326008)(66946007)(966005)(52536014)(66446008)(66476007)(26005)(33656002)(478600001)(9686003)(76116006)(32563001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?gBDXjG3EZt2T5vNl3s/FDenYFPoHSRmFKaXzV9zddWjqFR8Tkg0HqCnjsVQe?=
 =?us-ascii?Q?YVZLFXPCcnnkgymXshRzZUOm/AsqLoZQJt5hkJVqR1rj8Daot6qoWDelWjCI?=
 =?us-ascii?Q?IiMsRe1cAfpaVpL3VEbzuGS/ld2b6X4lZ61FUpVhzh+mR38G9y/oxMmDZA0P?=
 =?us-ascii?Q?1abyElC1zzpN7sRA2GjKC1ZGK9eG05aNoxq1MvUS59M84jguQV747N7vE4fJ?=
 =?us-ascii?Q?1UiCDVFpVcvgowIeltV4KEPyCZY2m7sCQ53jgfH2Tbz+hPBwoBg0ICaNeGHM?=
 =?us-ascii?Q?mJm25Dua2h166gTnNpE5e71MRVveaLAt0oQNlsvEAedOkw60hygxSDhO6HKj?=
 =?us-ascii?Q?xiAgY+JFFKlai1jJaZLpol/LxaSwffaYWiJ6UoW5wV1ogw4IOzKKKb84bwC3?=
 =?us-ascii?Q?d8bWdQFC5HizyussoZm0lHTaTndd+vTLzS3Xg2Kq+2MElgqWp4bRyYvCTEf9?=
 =?us-ascii?Q?RXvc93mHqfro5cmUK1zugc0mfXAEMAR4bIKs7jrV04cyJqXz2Mx5Cz8yLXhV?=
 =?us-ascii?Q?ZZ29AMPpzhBaepzjru6gqYXn/jYXwWERayWVTJmm8q0V5iAepuX81cOBOYe6?=
 =?us-ascii?Q?V6TfriQh6XCz3cKanNsZ6EnRDV0rekddt9dkhsPMIrW5Q/tsJeuNOtPsyw57?=
 =?us-ascii?Q?pUf91aWTX+YKBstBd9rDp865DtdaTste3Gtr+RTgH8WGaOI01uu1bdQ4Osy7?=
 =?us-ascii?Q?IggFgYkr9dutwWNi56WcY6fx60dYEKGiiQItb88mdb8VriaOldT7qh/ecb9T?=
 =?us-ascii?Q?gUjdjQVY3ckW/AtnTlknO4YWoEXvScHd5+oYCdrHscKJfqcGaekRuWWCJs9F?=
 =?us-ascii?Q?FhSyjZDqvoeNs33WV1YOL4GmhzvbLjaZjtqRFsYJ+vvnkYFuj5ttQ4jHO/2l?=
 =?us-ascii?Q?9WW+Zpz4kamonyYOjBsjSsTO1uaWkhtktqJA4nmLpuVcaWH9iUjzUoX8Rkqw?=
 =?us-ascii?Q?/wZNcb36+wwnnLGrRIj68xwUqW2vTtDr1tM6/q1G8H3L3yedHAT5QE0x2M92?=
 =?us-ascii?Q?D/khFrc47p1MR0ZSP914rMMVBVCaMNDVsF7pjbIgCvvXq8puj6aK4u9Z1q0W?=
 =?us-ascii?Q?mJts0jvmUoI/mzgiTfokiuSwUFJUXz/MGP88DCCDpHIo7lihk8zgfoFqisyv?=
 =?us-ascii?Q?JyNDpz2Dsp5/g0d9EsgdUuAg1OwA9LlpOG8L1gvyek2QDIvQu34othdTPLhF?=
 =?us-ascii?Q?a0Wc9+SwbGrS23XR9ajdKV9aRAFzFl42PTHOJ3K6oHBbDBfOvWRcKZtdoRZo?=
 =?us-ascii?Q?E6wGLKJWrJSSmp+WN7JTMr4Lfaab4aelyY+b2cSjk3tRqBFkalLC+uNWQ5Wl?=
 =?us-ascii?Q?67dNnxBaETBa7gXW05sGDyuM?=
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY4PR12MB1287.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: aca8c393-7312-4b1d-3246-08d8e9f015fe
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Mar 2021 09:27:44.1679 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: oq0le5m5jQ01eR8N+TNevePeGS/LSsxbGeWHrqdg+uynFTT4pUtH0E5VNaD+4lbmjz9vLxRpdr3UuuPOcGKdug==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR1201MB0005
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
Cc: "Lazar, Lijo" <Lijo.Lazar@amd.com>, "Quan, Evan" <Evan.Quan@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Public Use]

One comment inline. Other than this, the patch is:

Reviewed-by: Guchun Chen <guchun.chen@amd.com>

Regards,
Guchun

-----Original Message-----
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Evan Quan
Sent: Thursday, March 18, 2021 5:21 PM
To: amd-gfx@lists.freedesktop.org
Cc: Lazar, Lijo <Lijo.Lazar@amd.com>; Quan, Evan <Evan.Quan@amd.com>
Subject: [PATCH] drm/amd/pm: fix Navi1x runtime resume failure V2

The RLC was put into a wrong state on runtime suspend. Thus the RLC autoload will fail on the succeeding runtime resume. By adding an intermediate PPSMC_MSG_PrepareMp1ForUnload(some GC hard reset involved, designed for PnP), we can bring RLC back into the desired state.

V2: integrate INTERRUPTS_ENABLED flag clearing into current
    mp1 state set routines

Change-Id: I4eb3d5d76068412a6ab228af7fe7f794e53c1eaa
Signed-off-by: Evan Quan <evan.quan@amd.com>
Reviewed-by: Lijo Lazar <lijo.lazar@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c       |  9 ++++--
 drivers/gpu/drm/amd/pm/inc/amdgpu_smu.h       |  7 +++++
 drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c     | 28 +++----------------
 .../gpu/drm/amd/pm/swsmu/smu11/arcturus_ppt.c |  1 +
 .../gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c   | 25 +++++++++++++++++
 .../amd/pm/swsmu/smu11/sienna_cichlid_ppt.c   | 14 ++++++++++
 .../drm/amd/pm/swsmu/smu13/aldebaran_ppt.c    | 14 ++++++++++
 drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c        | 28 +++++++++++++++++++
 drivers/gpu/drm/amd/pm/swsmu/smu_cmn.h        |  3 ++
 9 files changed, 102 insertions(+), 27 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
index 809f4cb738f4..ab6f4059630c 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
@@ -2160,9 +2160,12 @@ static int psp_load_smu_fw(struct psp_context *psp)
 	if (!ucode->fw || amdgpu_sriov_vf(psp->adev))
 		return 0;
 
-
-	if (amdgpu_in_reset(adev) && ras && ras->supported &&
-		adev->asic_type == CHIP_ARCTURUS) {
+	if ((amdgpu_in_reset(adev) &&
+	     ras && ras->supported &&
+	     adev->asic_type == CHIP_ARCTURUS) ||
+	     (adev->in_runpm &&
+	      adev->asic_type >= CHIP_NAVI10 &&
+	      adev->asic_type <= CHIP_NAVI12)) {
 		ret = amdgpu_dpm_set_mp1_state(adev, PP_MP1_STATE_UNLOAD);
 		if (ret) {
 			DRM_WARN("Failed to set MP1 state prepare for reload\n"); diff --git a/drivers/gpu/drm/amd/pm/inc/amdgpu_smu.h b/drivers/gpu/drm/amd/pm/inc/amdgpu_smu.h
index 629a988b069d..21c3c149614c 100644
--- a/drivers/gpu/drm/amd/pm/inc/amdgpu_smu.h
+++ b/drivers/gpu/drm/amd/pm/inc/amdgpu_smu.h
@@ -836,6 +836,13 @@ struct pptable_funcs {
 	 */
 	int (*check_fw_status)(struct smu_context *smu);
 
+	/**
+	 * @set_mp1_state: put SMU into a correct state for comming
+	 *                 resume from runpm or gpu reset.
+	 */
+	int (*set_mp1_state)(struct smu_context *smu,
+			     enum pp_mp1_state mp1_state);
+
 	/**
 	 * @setup_pptable: Initialize the power play table and populate it with
 	 *                 default values.
diff --git a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
index bae9016fedea..470ca4e5d4d7 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
@@ -1927,36 +1927,16 @@ int smu_set_mp1_state(void *handle,
 		      enum pp_mp1_state mp1_state)
 {
 	struct smu_context *smu = handle;
-	uint16_t msg;
-	int ret;
+	int ret = 0;
 
 	if (!smu->pm_enabled)
 		return -EOPNOTSUPP;
 
 	mutex_lock(&smu->mutex);
 
-	switch (mp1_state) {
-	case PP_MP1_STATE_SHUTDOWN:
-		msg = SMU_MSG_PrepareMp1ForShutdown;
-		break;
-	case PP_MP1_STATE_UNLOAD:
-		msg = SMU_MSG_PrepareMp1ForUnload;
-		break;
-	case PP_MP1_STATE_RESET:
-		msg = SMU_MSG_PrepareMp1ForReset;
-		break;
-	case PP_MP1_STATE_NONE:
-	default:
-		mutex_unlock(&smu->mutex);
-		return 0;
-	}
-
-	ret = smu_send_smc_msg(smu, msg, NULL);
-	/* some asics may not support those messages */
-	if (ret == -EINVAL)
-		ret = 0;
-	if (ret)
-		dev_err(smu->adev->dev, "[PrepareMp1] Failed!\n");
+	if (smu->ppt_funcs &&
+	    smu->ppt_funcs->set_mp1_state)
+		ret = smu->ppt_funcs->set_mp1_state(smu, mp1_state);
 
 	mutex_unlock(&smu->mutex);
 
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/arcturus_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu11/arcturus_ppt.c
index 69aa60a2e8b7..e033aa6c7d9b 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu11/arcturus_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/arcturus_ppt.c
@@ -2367,6 +2367,7 @@ static const struct pptable_funcs arcturus_ppt_funcs = {
 	.get_fan_parameters = arcturus_get_fan_parameters,
 	.interrupt_work = smu_v11_0_interrupt_work,
 	.set_light_sbr = smu_v11_0_set_light_sbr,
+	.set_mp1_state = smu_cmn_set_mp1_state,
 };
 
 void arcturus_set_ppt_funcs(struct smu_context *smu) diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c
index 88634b44f8ff..bd95d41fe7a9 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c
@@ -431,6 +431,30 @@ static int navi10_store_powerplay_table(struct smu_context *smu)
 	return 0;
 }
 
+static int navi10_set_mp1_state(struct smu_context *smu,
+				enum pp_mp1_state mp1_state)
+{
+	struct amdgpu_device *adev = smu->adev;
+	uint32_t mp1_fw_flags;
+	int ret = 0;
+
+	ret = smu_cmn_set_mp1_state(smu, mp1_state);
+	if (ret)
+		return ret;
+
+	if (mp1_state == PP_MP1_STATE_UNLOAD) {
+		mp1_fw_flags = RREG32_PCIE(MP1_Public |
+					   (smnMP1_FIRMWARE_FLAGS & 0xffffffff));
+
+		mp1_fw_flags &= ~MP1_FIRMWARE_FLAGS__INTERRUPTS_ENABLED_MASK;
+
+		WREG32_PCIE(MP1_Public |
+			    (smnMP1_FIRMWARE_FLAGS & 0xffffffff), mp1_fw_flags);
+	}
+
+	return 0;
+}
+
 static int navi10_setup_pptable(struct smu_context *smu)  {
 	int ret = 0;
@@ -3036,6 +3060,7 @@ static const struct pptable_funcs navi10_ppt_funcs = {
 	.post_init = navi10_post_smu_init,
 	.interrupt_work = smu_v11_0_interrupt_work,
 	.get_gfx_off_status = smu_v11_0_get_gfxoff_status,
+	.set_mp1_state = navi10_set_mp1_state,
 };
 
 void navi10_set_ppt_funcs(struct smu_context *smu) diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
index 00575d452f08..5a5771785e10 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
@@ -3281,6 +3281,19 @@ static int sienna_cichlid_system_features_control(struct smu_context *smu,
 	return smu_v11_0_system_features_control(smu, en);  }
 
+static int sienna_cichlid_set_mp1_state(struct smu_context *smu,
+					enum pp_mp1_state mp1_state)
+{
+	switch (mp1_state) {
+	case PP_MP1_STATE_UNLOAD:
+		return smu_cmn_set_mp1_state(smu, mp1_state);
+	default:
+		return -EINVAL;
+	}
+
+	return 0;
[Guchun] return 0 looks uesless. Same as other similar functions.

+}
+
 static const struct pptable_funcs sienna_cichlid_ppt_funcs = {
 	.get_allowed_feature_mask = sienna_cichlid_get_allowed_feature_mask,
 	.set_default_dpm_table = sienna_cichlid_set_default_dpm_table,
@@ -3369,6 +3382,7 @@ static const struct pptable_funcs sienna_cichlid_ppt_funcs = {
 	.interrupt_work = smu_v11_0_interrupt_work,
 	.gpo_control = sienna_cichlid_gpo_control,
 	.get_gfx_off_status = smu_v11_0_get_gfxoff_status,
+	.set_mp1_state = sienna_cichlid_set_mp1_state,
 };
 
 void sienna_cichlid_set_ppt_funcs(struct smu_context *smu) diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/aldebaran_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/aldebaran_ppt.c
index 9813a86ca31a..7d38b92a78dc 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/aldebaran_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/aldebaran_ppt.c
@@ -1460,6 +1460,19 @@ static bool aldebaran_is_mode2_reset_supported(struct smu_context *smu)
 	return true;
 }
 
+static int aldebaran_set_mp1_state(struct smu_context *smu,
+				   enum pp_mp1_state mp1_state)
+{
+	switch (mp1_state) {
+	case PP_MP1_STATE_UNLOAD:
+		return smu_cmn_set_mp1_state(smu, mp1_state);
+	default:
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
 static const struct pptable_funcs aldebaran_ppt_funcs = {
 	/* init dpm */
 	.get_allowed_feature_mask = aldebaran_get_allowed_feature_mask,
@@ -1518,6 +1531,7 @@ static const struct pptable_funcs aldebaran_ppt_funcs = {
 	.mode2_reset_is_support = aldebaran_is_mode2_reset_supported,
 	.mode1_reset = smu_v13_0_mode1_reset,
 	.mode2_reset = smu_v13_0_mode2_reset,
+	.set_mp1_state = aldebaran_set_mp1_state,
 };
 
 void aldebaran_set_ppt_funcs(struct smu_context *smu) diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c b/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c
index 917f8afbcee0..d423315aa2b3 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c
@@ -782,3 +782,31 @@ void smu_cmn_init_soft_gpu_metrics(void *table, uint8_t frev, uint8_t crev)
 	header->structure_size = structure_size;
 
 }
+
+int smu_cmn_set_mp1_state(struct smu_context *smu,
+			  enum pp_mp1_state mp1_state)
+{
+	enum smu_message_type msg;
+	int ret;
+
+	switch (mp1_state) {
+	case PP_MP1_STATE_SHUTDOWN:
+		msg = SMU_MSG_PrepareMp1ForShutdown;
+		break;
+	case PP_MP1_STATE_UNLOAD:
+		msg = SMU_MSG_PrepareMp1ForUnload;
+		break;
+	case PP_MP1_STATE_RESET:
+		msg = SMU_MSG_PrepareMp1ForReset;
+		break;
+	case PP_MP1_STATE_NONE:
+	default:
+		return 0;
+	}
+
+	ret = smu_cmn_send_smc_msg(smu, msg, NULL);
+	if (ret)
+		dev_err(smu->adev->dev, "[PrepareMp1] Failed!\n");
+
+	return ret;
+}
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.h b/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.h
index c69250185575..155e2a68fa1c 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.h
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.h
@@ -99,5 +99,8 @@ int smu_cmn_get_metrics_table(struct smu_context *smu,
 
 void smu_cmn_init_soft_gpu_metrics(void *table, uint8_t frev, uint8_t crev);
 
+int smu_cmn_set_mp1_state(struct smu_context *smu,
+			  enum pp_mp1_state mp1_state);
+
 #endif
 #endif
--
2.29.0

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Flists.freedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;data=04%7C01%7Cguchun.chen%40amd.com%7C7f8ce8b8d80349f7986b08d8e9ef32bc%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637516560856742869%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C1000&amp;sdata=tmaW60V8%2F99wr54WCiIh%2FeYFho2DWzDnMbJCIgN3vME%3D&amp;reserved=0
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
