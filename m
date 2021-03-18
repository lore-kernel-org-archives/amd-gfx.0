Return-Path: <SRS0=NRDG=IQ=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3F3FC433DB
	for <amd-gfx@archiver.kernel.org>; Thu, 18 Mar 2021 09:35:53 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7609C64F10
	for <amd-gfx@archiver.kernel.org>; Thu, 18 Mar 2021 09:35:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7609C64F10
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1E0CA6E8B9;
	Thu, 18 Mar 2021 09:35:53 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2059.outbound.protection.outlook.com [40.107.243.59])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 588896E8B9
 for <amd-gfx@lists.freedesktop.org>; Thu, 18 Mar 2021 09:35:51 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FIzJVNldyPxFdujWpcH2T72oiHSm84ict6Kw1YbRICHY9RAvuR3/co3YCYs7pVKymopoKeaohHF9RIQ+Mtd7DQ+Jtli2QwhC5zINP/lZGZAnY9DQqRJPpNOKVPrmwom3Zr22StEEj5nPrISoCfLVdJqTzVF+yWdzIl9Daz/ePNRlNx/U9d/YH1wOyAoDZA80zzP5VLr1c8m+jvn6gaFIrHf5Uh6W/9IZpI+HPLDFNrjAeONaf1C+mbcG7DYgtraGtcorCddQE1Dhg/V4CO9iIoNDjzOhJZDybNcp8f0/WjJtZQdelh0x0OxHBnQ8MgmCEfSoguQ4xvkEJdWlB3M3fQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hZDwp6gV90GPj6+Q71DYHPEU8ZX9d0UBskZqAH2geXg=;
 b=Xrdph/SNftpWvY5lpIOqglqlrBCUlk8FBzs6e7dJbkUoCeWmHiHHVXk5BfMs9NX68AiujyolvpcPyZCU8tQPd9UFrPS58lWLeWXvSe5aR4vpTLZS+Wv0z8OP2ctW3mFX/Z7EnABraFkgy8Ozc9y61Njh0ZIrCc+yxYzMHC3NW0hBQ+qORttIxs/oLPbAH3pWBIcI4jSCwp2bc17D/sEsi5F5zkT5Sv1fiwH8X79MD/r9J/mg4dSTrue60O0pzF39lWILDedPcEGVJKIpY8vr66pGXnixIG8GeExPPY/vpFbUlMCqQT9X/E1+wvzQO5vhX78p8UauF7KP1H268Y4geQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hZDwp6gV90GPj6+Q71DYHPEU8ZX9d0UBskZqAH2geXg=;
 b=FxyDVyNYxxcFH54Q8vlfd16WXFPYayaxGopedaw6QnrcIwdmAnlXrAJud4NrOL/7twUyAzxXH2sIo45SLGgyQs8yQofdUCCXE9Fa+nrNe7FbwHAx5Rfl58BlyDLMue5b9KZlhN1f/g7Z/KxEeFUhpSBRI4lisrjwD70Ple5OJeI=
Received: from BY5PR12MB4885.namprd12.prod.outlook.com (2603:10b6:a03:1de::20)
 by BY5PR12MB4935.namprd12.prod.outlook.com (2603:10b6:a03:1d9::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3955.18; Thu, 18 Mar
 2021 09:35:48 +0000
Received: from BY5PR12MB4885.namprd12.prod.outlook.com
 ([fe80::7c8b:b3e8:be0d:e84a]) by BY5PR12MB4885.namprd12.prod.outlook.com
 ([fe80::7c8b:b3e8:be0d:e84a%8]) with mapi id 15.20.3955.018; Thu, 18 Mar 2021
 09:35:48 +0000
From: "Chen, Jiansong (Simon)" <Jiansong.Chen@amd.com>
To: "Chen, Guchun" <Guchun.Chen@amd.com>, "Quan, Evan" <Evan.Quan@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amd/pm: fix Navi1x runtime resume failure V2
Thread-Topic: [PATCH] drm/amd/pm: fix Navi1x runtime resume failure V2
Thread-Index: AQHXG9gRJKwTKv1oaEumY+EauU5wmaqJejYAgAABtxA=
Date: Thu, 18 Mar 2021 09:35:48 +0000
Message-ID: <BY5PR12MB48857C411EC8DE39137744CDEA699@BY5PR12MB4885.namprd12.prod.outlook.com>
References: <20210318092055.437406-1-evan.quan@amd.com>
 <CY4PR12MB1287D25EBCB9DC7DE4D1B45AF1699@CY4PR12MB1287.namprd12.prod.outlook.com>
In-Reply-To: <CY4PR12MB1287D25EBCB9DC7DE4D1B45AF1699@CY4PR12MB1287.namprd12.prod.outlook.com>
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
x-ms-office365-filtering-correlation-id: 9b02bce4-efe7-4b09-cf50-08d8e9f13698
x-ms-traffictypediagnostic: BY5PR12MB4935:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BY5PR12MB49355B6FB8F2A7EBCAB33156EA699@BY5PR12MB4935.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 39iivwhJ+eiDxpNNXnZvkVcXD+ldBG00cSwsHaj1YW2LALPMO6lQwtOemOQVyrctx8zoFN/eTf1miU8yK2qHKyScVbbkm3IDtu4ixU6hI0NZw9m65981u1vbKyWvFtsAxOD5/4ymWsavmWAyMl8uGm5fpp92CeAgufkDoK0DSOosM0gypAL/nvKC4zSaC9I1uXo4X1Z0XJ3f2twFg+ouvJqZAALp4wdaxWggHBSeSWE7YyXY1ntBotHJOVrtA++3I06o3LFr79dp0tF/QODTqxstaPyGRXIc80N/xkPhlNhzoLfIgC8+slSOP8Hw/49D3RXqM05+XakIIo3yW6WWoz+r+P8/yeVzw6ToZhXwG0pkdDrOxKdyced7AJAFj7n3LyYGkKXtg0RS+8/mji4mNbYOSk1Mft2+0WIiUqq1BbkJLQcFxW+RQLvHP5FHSyukKMWTF+oIMzbDXVsN3yoYpYVDW4tlV4U0P2GuktJgWKh9aQuufgvYGqH+0hSjQBDZX3RzJ8j2YW0G5YbzYYAfyDQrEFjnpaYxuDoxI4f5qpXCFtpwVBvZ5g1hyXWcUmGn8J5ElUy7ZCpKK3Qyvqn2w1dA9iEXaCu1XmvV/V1tXzWT+8DdEtS5ot431IjJu2vaaLRYqdboNZ7MDukmwl7GN6jiwkFGycH2eWxWyh9FjF+oBPa1TRJ8x+6U16fivkh1
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BY5PR12MB4885.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(136003)(346002)(366004)(39860400002)(396003)(376002)(30864003)(8676002)(66946007)(478600001)(71200400001)(83380400001)(966005)(4326008)(7696005)(55016002)(6506007)(76116006)(38100700001)(66476007)(52536014)(53546011)(54906003)(64756008)(66556008)(9686003)(33656002)(8936002)(26005)(66446008)(86362001)(2906002)(5660300002)(186003)(45080400002)(110136005)(316002)(32563001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?u89+dnhFGL/UlRks8AvlTfrF99D5sA/JkxLFu1Vtx23w9zcO/7E52YnLrOJy?=
 =?us-ascii?Q?Ra3bSVGHfhLecoQHIkxT3gbpeIzyffsL/MqzZy9mQGEDVhziFUxKfd362ZVU?=
 =?us-ascii?Q?MR13ME7qhDF/7wiuT7vYa9yNfE1alD21p7RjJlrmGvAVPsuKObyetdqlmZjE?=
 =?us-ascii?Q?gjgGjCrWSH06QEiE73x95hPcC6cVE+4mZcRqAn9kmmuqKH1mlg19VE3czr+T?=
 =?us-ascii?Q?o0swvOkRGs1D0hIEszh/3o6CXjb+6TavUGupoWIurIwX9pQTfOeflzxP5uUa?=
 =?us-ascii?Q?iHlgGoLvpf6ma4oEMehg33dqM3Ggml7ALx9Y7I8bvM7TzE47JB6rH1LsA49O?=
 =?us-ascii?Q?bYyV8EN0uK8DQQHS6Lvo/MdOTTY0DrF5rMaJwdfSSzUgWOha8tCh45nXa/ps?=
 =?us-ascii?Q?mZNC7MEAw729pBgA3sR2Yr2VydvvCPbSeF7imqbF9qupZ0UoddB5lamUXAwf?=
 =?us-ascii?Q?NWrBGumlprdfnuSjdDKpqFxQZKniddXtmtWM3S1dpNgN4cmB60nDzEqGkWTa?=
 =?us-ascii?Q?CZmZoag3myqec8uPRLriLUIkvo8XjneUkmOf3zbWaTIWm5mCrZQy1rv1SZo8?=
 =?us-ascii?Q?ErVWkq7dJt5Rk5J210QyxUID9xqwf7rPrp7R2AYoTO7ILp4W4Dw+94bt8pp0?=
 =?us-ascii?Q?A+KsEpmlM/qroDSLtHHlChP5heUs7h2LOQ0FS7z0gFbwzJqE3nZJW4qSNUQj?=
 =?us-ascii?Q?lC1ey5wGYGJYl/2LxhmJ7JvjB7C4Ey9qrVypQx2CTbmxaSfo/5+A7okKoJ8d?=
 =?us-ascii?Q?ouxqDnbrfylqSU1Fzy7yzpr3q1HS3eZEnTx1/uYJbAP23HI8kM/fKysf9Jek?=
 =?us-ascii?Q?bPC1LO/hIFNvcou9WzK+H2RW71w98/PGAmyLHfrL6FhC+UXlZccGQ+/U7tOk?=
 =?us-ascii?Q?n7zmnmWEGglvhQEbNokXbf8tSew+WljXYfS6zd/jK0mtNS8VU2scwdQQBEab?=
 =?us-ascii?Q?B3ev5VfVC6E4rR3DXfZ7pZftAv4VBpP6Syvh/WGh1pBWk7ZQuQ38BsKMR7ah?=
 =?us-ascii?Q?HdkuI2Jn50xEQR6ST3h7qjJvBtO5otekK0+lpujt29tJ/pe2Gdkgfzd5rsoq?=
 =?us-ascii?Q?P75g9mFpX70R8ogcAeXMJGEAMDi4lrJwhgh8bbJ+Jnniqkrgbq35JgKMb9JJ?=
 =?us-ascii?Q?DnGKER0EhTOf89SoY/fsdJ+PEL/whmC3VNSSkUgbtg+jlskrEamKLSDtcS1y?=
 =?us-ascii?Q?3VVifKSRsNGSjGmzFRU2KQT9efRS2JUiR7lUC5a3u+uu4X/ThFJksYMEgamW?=
 =?us-ascii?Q?bKoLwnABl747IqjAoLvYGdANDKrQzSEu2igbX/GTZU9IZ7ph2dwiXtNRKCwM?=
 =?us-ascii?Q?7QqOyOyKtXj4/2zpqCUDzZsr?=
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BY5PR12MB4885.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9b02bce4-efe7-4b09-cf50-08d8e9f13698
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Mar 2021 09:35:48.4672 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: cZfwlFPaife8IX5ujw+SkiEuWfN9JH8nHv7NHTL6vPwLcEABgxGtgaLX86SlYrxiYGYnXqz0TiFxwui8tHWsCw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4935
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

We still need reserve "return 0", otherwise may trigger warning "not all control paths return a value".

Regards,
Jiansong
-----Original Message-----
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Chen, Guchun
Sent: Thursday, March 18, 2021 5:28 PM
To: Quan, Evan <Evan.Quan@amd.com>; amd-gfx@lists.freedesktop.org
Cc: Lazar, Lijo <Lijo.Lazar@amd.com>; Quan, Evan <Evan.Quan@amd.com>
Subject: RE: [PATCH] drm/amd/pm: fix Navi1x runtime resume failure V2

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
https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Flists.freedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;data=04%7C01%7CJiansong.Chen%40amd.com%7Ceed70d2cf21147324beb08d8e9f01a90%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637516564768126914%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C1000&amp;sdata=%2B9aXu324Wqr%2FE%2B4FUk57g%2FtTY%2F%2F9EzGKvSJ3vezKEl0%3D&amp;reserved=0
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Flists.freedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;data=04%7C01%7CJiansong.Chen%40amd.com%7Ceed70d2cf21147324beb08d8e9f01a90%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637516564768126914%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C1000&amp;sdata=%2B9aXu324Wqr%2FE%2B4FUk57g%2FtTY%2F%2F9EzGKvSJ3vezKEl0%3D&amp;reserved=0
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
