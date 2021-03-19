Return-Path: <SRS0=mZ+C=IR=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 712F4C433DB
	for <amd-gfx@archiver.kernel.org>; Fri, 19 Mar 2021 02:47:08 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2C29664E4D
	for <amd-gfx@archiver.kernel.org>; Fri, 19 Mar 2021 02:47:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2C29664E4D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C897B6E8AE;
	Fri, 19 Mar 2021 02:47:07 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2061.outbound.protection.outlook.com [40.107.92.61])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A3D086E8AE
 for <amd-gfx@lists.freedesktop.org>; Fri, 19 Mar 2021 02:47:06 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=b7XAVw+V4Bby1PnK1GpiAekp5T8Zz1EHJ7N3D5H2A7xZY3Kr7rBv5NAxP6Ac1Dstwt4eiVBW9NsS61k8z9H8dSqrtUTy4CHt8Gy2iDVZo1AQt8USkTRPabg7E2NEwFkO3I1AhcxkFAdjcNbd/ytlOXywEhwyvayUnTA5+WTalnLiP3y6kH47zKxJyo2wwinBnPLeG+GqPWHc0UuDpeBY94ReiD5LMbu5iSOqtp1to0e9aQMwEYSlVCnCurZb4xRCAJBL/BQImP3xPwMBH8H/ztr66vbvKi7Vg+dn24JlNvDd1HlXcOgf4b8KtLxAje47YHY4cVnRQ9FDQ7PLDDAhiA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UYzSGAqku9zgt97yrnOTNSj4j5BqK5yJNPBWAWYjzpM=;
 b=K4qU4Dm6po5hFlUx6tvZnnw7KW0vNaeZMmSlMnLl2jipaTEYEMP2TZ2EQlhPFk+sdNX3ci3R/UdtbUzC9dBV0aqJ3TZYB2L06M0ZBtT+MJHeVqRCWUldzxTVDE7vV8QiIHYFkISuTBRpbUIdXVg3TmnO7yBT3oZWoW79I/qkB9Hm5g2TBXDLy6xtKHFT5KSLintJt0cNjxK6hqSIdZydR01D25JKl2KO4KPb5HvLB6VrNyBElpJlD++mpmq8O+peoBAOXbmVb0jGm2rH0vShTsEQ10gvgVL5OWFh6cREqKd9CM0k93/ImVctkmyYbwOOf/nF8cZGJYVVkke3FqNo5w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UYzSGAqku9zgt97yrnOTNSj4j5BqK5yJNPBWAWYjzpM=;
 b=SJjkDgXFqYbvFCKm3IaPXuHtiJXwsWPP+ItJCwc0g9ZYxGOONeLekAwf73URggNoajKLqiZTtWef8YEO8P/G10n5Q+dHowb5YTg0UynYGnBEwnf8Mo59wj5c2b53Kgp4TN//py5yE2sCqGG3eoB4ZYSN31rXMII7NeJ0Jka0WlM=
Received: from DM6PR12MB2619.namprd12.prod.outlook.com (2603:10b6:5:45::18) by
 DM6PR12MB4385.namprd12.prod.outlook.com (2603:10b6:5:2a6::14) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3955.18; Fri, 19 Mar 2021 02:47:04 +0000
Received: from DM6PR12MB2619.namprd12.prod.outlook.com
 ([fe80::c05d:8592:f72:bfc8]) by DM6PR12MB2619.namprd12.prod.outlook.com
 ([fe80::c05d:8592:f72:bfc8%7]) with mapi id 15.20.3933.032; Fri, 19 Mar 2021
 02:47:04 +0000
From: "Quan, Evan" <Evan.Quan@amd.com>
To: "Chen, Jiansong (Simon)" <Jiansong.Chen@amd.com>, "Chen, Guchun"
 <Guchun.Chen@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amd/pm: fix Navi1x runtime resume failure V2
Thread-Topic: [PATCH] drm/amd/pm: fix Navi1x runtime resume failure V2
Thread-Index: AQHXG9gLX4Kx0Ti8+UWfYihpqXGiC6qJejYAgAACQQCAAR+vYA==
Date: Fri, 19 Mar 2021 02:47:04 +0000
Message-ID: <DM6PR12MB2619C77F28912058482DEA7CE4689@DM6PR12MB2619.namprd12.prod.outlook.com>
References: <20210318092055.437406-1-evan.quan@amd.com>
 <CY4PR12MB1287D25EBCB9DC7DE4D1B45AF1699@CY4PR12MB1287.namprd12.prod.outlook.com>
 <BY5PR12MB48857C411EC8DE39137744CDEA699@BY5PR12MB4885.namprd12.prod.outlook.com>
In-Reply-To: <BY5PR12MB48857C411EC8DE39137744CDEA699@BY5PR12MB4885.namprd12.prod.outlook.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Enabled=true;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_SetDate=2021-03-19T02:47:01Z; 
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
x-ms-office365-filtering-correlation-id: a9aba70b-05b1-40ea-cfa8-08d8ea8147ba
x-ms-traffictypediagnostic: DM6PR12MB4385:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM6PR12MB4385494357B42100A13F831FE4689@DM6PR12MB4385.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: NYDJQdMvVxwCwLXZxfVpD0drVwoYYEPBJii/fHbvYmChjclz5avH2v8S6L08BxqRUUeCchPp4CzWoJev0h7D0s8gtKmDyWS/Mj7gWx0+uJAbzlgheE/ogUkCxHmk19BMB1GVSBNlXh/yHbId4kyt7+LvNL/4dvL9tH/i646QjWkrVUHMKgNNSXk6udQKDKSlKEkQJ+GbgKeScFOSyKb4z7qkjwH+mDtld72pV3qgpBIcXnAXlIczRZEmiyM2cfsc35tA9Sdp39Tkp46Af7a/STg7ZeacdcLiFuWOIKyKNhWrEqiV6+ch50qWhcN+mX3UNhMALqmCo1I7+FgXbjtCcHW+p+/flstgk1G1H/KW/1ryW4quU5OS2vANIYxKe40DRbBVz8HPaNF2BtExl7a61NZT8GPoZwy5CTwQaaronbE2CHEx8d3BH1wGzvKrtnWNcpNQcBurIxKFe3ZXCHxqGby29l7Q6lmtbNTZqah2apJRsUQG9oPzHkiQJiB/M0Tt5vfNPe9ch8vcdInF53VmA+Y7eFAAM85grghK+YdFKyXGCxEYwRLuitJI+7BBaWq9i1Rcg1gt+I/ykrNdQF29X9Yp3eKLtUlZ8U33Zz66TsDMNJa88gNuE7axNUkAz+F/WYGtRLF8W4t0Ffng3XwhYdmmzwPdr5t79mB01mfUAc5fx2qYZY6d/+RJsgSviGP08AqLN7Gdn2ZcRpriGv3k41rvZK5WiQDSYbAMbPZ3tCI=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB2619.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(136003)(346002)(366004)(39860400002)(396003)(376002)(5660300002)(45080400002)(316002)(7696005)(55016002)(83380400001)(66446008)(38100700001)(110136005)(66556008)(71200400001)(52536014)(4326008)(2906002)(33656002)(30864003)(26005)(8936002)(186003)(66946007)(76116006)(6506007)(64756008)(8676002)(53546011)(66476007)(478600001)(9686003)(966005)(86362001)(32563001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?4zzTaCjhHzfy+HZBIeA6NMW5DJpiy+SAx3ZQBFOOCHqdkQms+xQ+ih2Zc7SQ?=
 =?us-ascii?Q?qnbq39u7X3xzsFXYjcARRGZxW7qUARQ309MMlKMD8XoM1Ez12g4f1QuX/qbT?=
 =?us-ascii?Q?nQ+HJF5VCNF++zKL6qq8iB5aBuKmRkJEk9Xm7Z/9PwjMKdXfGLGq6AxFBgMB?=
 =?us-ascii?Q?6N3DzN6cfQwUnPWau3dP9rJCCswwqs0DV2I/IoQdG33EwB3w4jFlxh/9QGQ0?=
 =?us-ascii?Q?iLMFZqrTdQWEYAemm+ghqh2yQNisSkLZW1KnYkTMvnRkFsH/0nZi9l1aGlnp?=
 =?us-ascii?Q?+nV/aZVh8YNGedEsMZUkuPc+6DyJTRwSvPkKqUPhADlMOsdH16u54cc86oMl?=
 =?us-ascii?Q?vhS+RqJcdN11EIRgynaqry7EAoG0XTx81T5vtwFAxOcwt6gYYo+3rC0qlCt2?=
 =?us-ascii?Q?YRouY7aaVdvZiIcyIRdkYElJwqgtFTQQOzBPyvpd2I6xFLpghCM3v3l8inv8?=
 =?us-ascii?Q?ORwZ1JXbFILgoUcTe7YtlnF9QY+gvdbP/8K8z7ZZYWWKK7dWnGfHbLPUtbYI?=
 =?us-ascii?Q?j77Al4/M9gD7Hk0VbGV6Cyi3wYn74OF8IF5tJ4Gsd1xA9oYByUzxUIGfULVV?=
 =?us-ascii?Q?y2EiEwUICGZ0FTVT78aJBaryKBK5JjI7ajodZtIjzPZWOe0dz60bwFAKL+qD?=
 =?us-ascii?Q?Ls/hwwWnPTJwEWNVShgkJ2nTq11HKsc59MmZ0muQbbTj/Q4THoCQILMj+jDY?=
 =?us-ascii?Q?XkcMpfY87qbiUe+SBrwPO0pBDPHiDSg8CSLPr7ccIdPxrorn448d5HHJSpnq?=
 =?us-ascii?Q?sS6BQHwCtxauR9Vu+OdCMwOYKZmGsdqpFuVWZgasTZM/6HSQiBKzcRxe75pm?=
 =?us-ascii?Q?B1hQKa4NktlgeEBwA3K5aIwSoFRVv+B/PMVfKx7vwx1nHohbOoit6QO4iLYF?=
 =?us-ascii?Q?EVRLMcRmo1CMJu0lAtf8blaKAt6OuxfEsTPsWGRqeGjft5/p8xq/WpmqEFsS?=
 =?us-ascii?Q?gOShVwa2HFC+1LHuBXSHgyJvypHxogRzxQpx8J1Jyp1fnaaHgq87uDJIvVHs?=
 =?us-ascii?Q?WqerkSz9Vw/+YoRpOMGp9ibnmgYyvP01tO+eQ6xz8i+2JaEIZFmt4VK65srK?=
 =?us-ascii?Q?uic02VxPQEkaRQx/Yaq74qKC3egHDSupPv9iW2C0hLIXvewJBhRBnJvTi59E?=
 =?us-ascii?Q?bntcFgC3IwofFWijp1ZJXsZx5jBTA2+otoKJeNEajj1oy4kZuVtKdR4Ygy0J?=
 =?us-ascii?Q?D4ZpeXicvDO/mqN8LT13++rC49bGDWwPsS9w4HtH2QC1vco6uIkU3iFM3jis?=
 =?us-ascii?Q?VTiShHUwJ0YOP2SoE/eHHUnFx29uCYuTmTpq4cfILdnzsV+rGmP1VRx6aRm0?=
 =?us-ascii?Q?huLeEqpnB6i4T/5+u1Yocr9y?=
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB2619.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a9aba70b-05b1-40ea-cfa8-08d8ea8147ba
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Mar 2021 02:47:04.6402 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: QyOA7NZCb+6zGUIk5D99c5gfi7lYYzn7ETAffqKuqLGymHymdP8aAoOwwt/Qxf5V
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
Cc: "Lazar, Lijo" <Lijo.Lazar@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Public Use]

Thanks Guchun & Jiansong. Yes, I had same concern as Jiansong.

BR
Evan
-----Original Message-----
From: Chen, Jiansong (Simon) <Jiansong.Chen@amd.com> 
Sent: Thursday, March 18, 2021 5:36 PM
To: Chen, Guchun <Guchun.Chen@amd.com>; Quan, Evan <Evan.Quan@amd.com>; amd-gfx@lists.freedesktop.org
Cc: Lazar, Lijo <Lijo.Lazar@amd.com>; Quan, Evan <Evan.Quan@amd.com>
Subject: RE: [PATCH] drm/amd/pm: fix Navi1x runtime resume failure V2

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
