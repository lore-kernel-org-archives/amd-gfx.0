Return-Path: <SRS0=oeKV=KJ=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1EB87C433B4
	for <amd-gfx@archiver.kernel.org>; Fri, 14 May 2021 08:20:18 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BB1B361451
	for <amd-gfx@archiver.kernel.org>; Fri, 14 May 2021 08:20:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BB1B361451
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 35A536E19C;
	Fri, 14 May 2021 08:20:17 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2082.outbound.protection.outlook.com [40.107.93.82])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E035F6E19C
 for <amd-gfx@lists.freedesktop.org>; Fri, 14 May 2021 08:20:15 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=biUiLQloFH+p0+hPxww2yf15PdHN3IqVkLadZ4zjVBR/Xy7pZFDmKMASZHNAzc3tzSvJ4t3O52t5eixDFBpkgNT0fmrfz8fpASI8lYj06+sIPbBS20O5xjrcWn5MZZwhHekxXfzkWCZkjp86H89Tf67qy8FRvzLTz42vD3ukUTlU3aQ1EL98NHoXQjGHwajaWO/UrcF+eJwqnW+3wsz9NdyyPT2qZ7aHHJcur5fGBzoMV7TCmpZa+WEpzRW1ofLtwWtp/2MhdQRSxeDBZ0EW0+lttvRyK04neMR0JYtmx4YPQe4QGmGMkcTpxLvlIYRmxK4L15+jvJh+hd33GefuUw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mrqjyVEvS72IHkjnkbfkWwDREZy456lp0c4QxNUuo4o=;
 b=E0JxeHU6p5Ycslam9NyBcgaw6P4FKHpYPPkBISRYz4rE+FYxTa7QBV2cuIaHm4AVlUkfHyV/qJqgW9roYIotutqva/TJKWU8RhiB1WAlRuWmJG5d1rmEkWa3AxSXghDrQjw5i70CumnpudA28I7ShYwHNe63sxaj2jw1nMUBCn0rk+km3PbEqwjEYvpsHZjRvYM8x8wmxBSHhYHuh1n+FfzOjlO0alj5RZFVyAmK/x7VH2mMvxKSUkmF6g4jJoZ7BV94C1VR1UHhKzphkIMX40fE/hPwaKe7HuW68atR2xgmzFR+peCXEfHanzW6uSDW6srYQEbf3bvyljGB4fU6BA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mrqjyVEvS72IHkjnkbfkWwDREZy456lp0c4QxNUuo4o=;
 b=q9/o8/aAfzHXiptKS0nldUkG6qq5MAEEH4qpuE+6g97ILl737dPqaMr9nOCumU9R2TRv5PMSuh0oqXVbsrtzc4Rf9iRBzwZ+72cjcZZXJ1b4TRMJJ5SaAhh9pkqmBpTzcUBpq+EoaeQADNCiLXYaUDmYO+B692us+eDXMSPGscU=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from SN6PR12MB4686.namprd12.prod.outlook.com (2603:10b6:805:d::29)
 by SN6PR12MB2608.namprd12.prod.outlook.com (2603:10b6:805:68::25) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4129.26; Fri, 14 May
 2021 08:20:14 +0000
Received: from SN6PR12MB4686.namprd12.prod.outlook.com
 ([fe80::9179:c74f:e091:ad56]) by SN6PR12MB4686.namprd12.prod.outlook.com
 ([fe80::9179:c74f:e091:ad56%4]) with mapi id 15.20.4108.032; Fri, 14 May 2021
 08:20:14 +0000
From: changfeng.zhu@amd.com
To: amd-gfx@lists.freedesktop.org,
	Ray.Huang@amd.com
Subject: [PATCH] drm/amdgpu: disable 3DCGCG on picasso/raven1 to avoid compute
 hang
Date: Fri, 14 May 2021 16:19:44 +0800
Message-Id: <20210514081944.16849-1-changfeng.zhu@amd.com>
X-Mailer: git-send-email 2.17.1
X-Originating-IP: [165.204.134.244]
X-ClientProxiedBy: HK2PR0401CA0022.apcprd04.prod.outlook.com
 (2603:1096:202:2::32) To SN6PR12MB4686.namprd12.prod.outlook.com
 (2603:10b6:805:d::29)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from changfeng-pc.amd.com (165.204.134.244) by
 HK2PR0401CA0022.apcprd04.prod.outlook.com (2603:1096:202:2::32) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4087.53 via Frontend
 Transport; Fri, 14 May 2021 08:20:12 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 6850f973-4ed3-4437-3fb2-08d916b1196e
X-MS-TrafficTypeDiagnostic: SN6PR12MB2608:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SN6PR12MB2608FDC26DB1FBFC9871029AFD509@SN6PR12MB2608.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3276;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: O62VELMn8Yv/COkcNYokmC0Nz6mn87bSHg1IFPWdp79nF8xprSzJardwgsOf/zpYWHv4gKy8x7CEmwhEWIyC/FSkbZtsqn2Dk/eg36aKXcw2Ous22Ti08EayET7c/5GpwlzAcfmbBvO58R31bd/DzltW0j94D2m2NAVuwtlT/NPSGm8QQwbYt4H+fj/Y/FwkzO8GgQvDP3odSzC9C4vBOWpbsjPJe77QElkb9OlSC9qcSx22NnoWM1ZGJH+6hvfhENbfIHJO8/alkmgl2HMMZaiLpWdWGE38ap+aJKXwk4VnTfTzJ2UuXKhqdJKDvvLkas7zP8Cbkw6O5RbzI5qhi4sMMmCMRefrgDyV7BTxSeBe502H37Gn8trT9Vog6087jxFkDNnR6OfZukuGTyNugP+1f98DTFFlaa7VOR3e0iQt4350Z4zbqI6+MuXJPvVf+7JIDbJq0HqMX5xNR04lGWzblMvbvM+e/A7KV/SLuvSzXVcLXu2nPw5uLTj0jRYQSZAFEaTn7Eoe+B5RCs7V5Fg9hxiDc4VCXImyKJ4p0m2wE3H3K/ujkRjTVMsyTghAvn8mPDIasX0NTYMO+SMf1T3am5J/kEDqxDyO1sAvRkmKWsSx6+nHHQszGhmYC4lhDMn7rtkPNcK7L83TqSSEWEDjySbAHEYDcc9YfunjbCsBPNJ0uKgZVtM+K4j3gVbD
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SN6PR12MB4686.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(136003)(39860400002)(396003)(346002)(366004)(376002)(16526019)(6486002)(26005)(478600001)(2616005)(956004)(5660300002)(186003)(316002)(7696005)(66476007)(4326008)(38100700002)(9686003)(38350700002)(1076003)(66946007)(6666004)(8936002)(83380400001)(2906002)(36756003)(52116002)(8676002)(86362001)(66556008)(16060500005);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?meO4vP5xg0vRpxb5G8Ght3PqanK3nlgJP72mBsbp9C9ICxQJR9RRnG7VJyJ4?=
 =?us-ascii?Q?ZT7J8IV6jNi0tTqYsi0V7ng+wG9K7L7iT2t8UAvlBRDE1/fYdJmDwX3bNkXT?=
 =?us-ascii?Q?guUE7I12odeNExmvodOdUvacMTVhpXqz871CqBU/QwFxqrKCUk8pN9PMLvsO?=
 =?us-ascii?Q?wxPfiNpYO9iuc8bKJbyyDI036OKCs1oM04tiP+02g2wczdVJiZGdytqAw12B?=
 =?us-ascii?Q?23X9B3/BLMrze0AOPQLRXNd5bZwfYtPc/AXTMZioLFLm5Pnadv59VqXOfjoq?=
 =?us-ascii?Q?qqZZvzHiosqoCdXP68U0IwGNDfWT1bVdx8utJHrseBfD7b+NLIy0Uzj3aO0p?=
 =?us-ascii?Q?PYw2/fOIe6nGveO6dyildsr9EGgaycpG+Z+OiyUWVLeb/EgFiLFhAVf4IcYl?=
 =?us-ascii?Q?Zx4fIg6Rk3ZIA/r5oEcyPI9amD98fo6RXOMaUtJqqU5mvRUkuGIYWYZYtMvz?=
 =?us-ascii?Q?vkSYpnWo5lsGjiB873U9XvaAHXyseR0wryO923pYNb/9QqbAvdPLObS9+B2j?=
 =?us-ascii?Q?qLFGsHZc618O6uWGLNRyQ93zrboLEOFxxkzEFhoNy1d6XUrr+1K7WRlsCN0I?=
 =?us-ascii?Q?QcMyFQNhjFz3Awac9/Dq2nAJbxaZ+Nr7bNvbm2meIF3NuTp9BQRX3JdzbaLC?=
 =?us-ascii?Q?oTDZdL4ga6Cd0//kVnaVk4XlMjdwxP6CUcHooIWD7m3euolpNuZ/wo3ECOPL?=
 =?us-ascii?Q?KH6RaoXZMHPr2auE2vxxwzqxa1B6sj7SiUHOtmewBw1l+oqtE0OWlfLTxx2g?=
 =?us-ascii?Q?LHyDn9S1lcTebhbLjvV0akVvEDhX/C8lwTy7pnFxAumqeF1+QIMl5Rja7G6s?=
 =?us-ascii?Q?3EqSPWjoufmC+7ciaqMQF9kOUd8jgqSYWZK0lTxkMehhMwU7b5DZtTaTTx90?=
 =?us-ascii?Q?g06/9h1LyxENmvP04bGgDVBJ/DJJ6Cf+pGNDv5mOZ3IM6W10ot0RdDz0Mmra?=
 =?us-ascii?Q?zFxRDUNjiCa9EMOzeH3dtsI+0sApe6A/EOZ+YwAqzrD/ZQXV3evoVFNXerg6?=
 =?us-ascii?Q?v5PIN4Mkv/tvFISXNDC1bWIhD9I+w3/snPHcdwOTmFyzyl9m8NdYYtXEBljt?=
 =?us-ascii?Q?SrWRBC8UiTahP3ixxNYdBJAn+zyFFxZ1FuHEsXESmxTlgnlh+M6k2NykxZIC?=
 =?us-ascii?Q?mKIxHjyEiUcLbant5xW0QhuEgVCVUln/lT6YNMpGqXBJwAE8DdXMo5h6b7MJ?=
 =?us-ascii?Q?GSOtf0yh1LD+kjVn/XfekfKNONhkfwcxiptirpluFUlgjz3Sroh7gVYhFuow?=
 =?us-ascii?Q?flT9uvYhAVv0MY1Zx2L8wVI6E08lrhhhzAMR4nGmlignSKJ5J8TY4fRJsxhl?=
 =?us-ascii?Q?CBIbOb8F7pPX48dgkjs4aO55?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6850f973-4ed3-4437-3fb2-08d916b1196e
X-MS-Exchange-CrossTenant-AuthSource: SN6PR12MB4686.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 May 2021 08:20:14.2213 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: k3CzOi8zsJJTh536tDgj8KQLilBHimGpxs8e0Z4VNbEvYW1+vzot5yvlWqrbvWjOdrApZVJzG5jj9MvRT0wUgQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR12MB2608
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
Cc: changzhu <Changfeng.Zhu@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: changzhu <Changfeng.Zhu@amd.com>

From: Changfeng <Changfeng.Zhu@amd.com>

There is problem with 3DCGCG firmware and it will cause compute test
hang on picasso/raven1. It needs to disable 3DCGCG in driver to avoid
compute hang.

Change-Id: Ic7d3c7922b2b32f7ac5193d6a4869cbc5b3baa87
Signed-off-by: Changfeng <Changfeng.Zhu@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c | 10 +++++++---
 drivers/gpu/drm/amd/amdgpu/soc15.c    |  2 --
 2 files changed, 7 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
index 22608c45f07c..feaa5e4a5538 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
@@ -4947,7 +4947,7 @@ static void gfx_v9_0_update_3d_clock_gating(struct amdgpu_device *adev,
 	amdgpu_gfx_rlc_enter_safe_mode(adev);
 
 	/* Enable 3D CGCG/CGLS */
-	if (enable && (adev->cg_flags & AMD_CG_SUPPORT_GFX_3D_CGCG)) {
+	if (enable) {
 		/* write cmd to clear cgcg/cgls ov */
 		def = data = RREG32_SOC15(GC, 0, mmRLC_CGTT_MGCG_OVERRIDE);
 		/* unset CGCG override */
@@ -4959,8 +4959,12 @@ static void gfx_v9_0_update_3d_clock_gating(struct amdgpu_device *adev,
 		/* enable 3Dcgcg FSM(0x0000363f) */
 		def = RREG32_SOC15(GC, 0, mmRLC_CGCG_CGLS_CTRL_3D);
 
-		data = (0x36 << RLC_CGCG_CGLS_CTRL_3D__CGCG_GFX_IDLE_THRESHOLD__SHIFT) |
-			RLC_CGCG_CGLS_CTRL_3D__CGCG_EN_MASK;
+		if (adev->cg_flags & AMD_CG_SUPPORT_GFX_3D_CGCG)
+			data = (0x36 << RLC_CGCG_CGLS_CTRL_3D__CGCG_GFX_IDLE_THRESHOLD__SHIFT) |
+				RLC_CGCG_CGLS_CTRL_3D__CGCG_EN_MASK;
+		else
+			data = 0x0 << RLC_CGCG_CGLS_CTRL_3D__CGCG_GFX_IDLE_THRESHOLD__SHIFT;
+
 		if (adev->cg_flags & AMD_CG_SUPPORT_GFX_3D_CGLS)
 			data |= (0x000F << RLC_CGCG_CGLS_CTRL_3D__CGLS_REP_COMPANSAT_DELAY__SHIFT) |
 				RLC_CGCG_CGLS_CTRL_3D__CGLS_EN_MASK;
diff --git a/drivers/gpu/drm/amd/amdgpu/soc15.c b/drivers/gpu/drm/amd/amdgpu/soc15.c
index 4b660b2d1c22..080e715799d4 100644
--- a/drivers/gpu/drm/amd/amdgpu/soc15.c
+++ b/drivers/gpu/drm/amd/amdgpu/soc15.c
@@ -1393,7 +1393,6 @@ static int soc15_common_early_init(void *handle)
 			adev->cg_flags = AMD_CG_SUPPORT_GFX_MGCG |
 				AMD_CG_SUPPORT_GFX_MGLS |
 				AMD_CG_SUPPORT_GFX_CP_LS |
-				AMD_CG_SUPPORT_GFX_3D_CGCG |
 				AMD_CG_SUPPORT_GFX_3D_CGLS |
 				AMD_CG_SUPPORT_GFX_CGCG |
 				AMD_CG_SUPPORT_GFX_CGLS |
@@ -1413,7 +1412,6 @@ static int soc15_common_early_init(void *handle)
 				AMD_CG_SUPPORT_GFX_MGLS |
 				AMD_CG_SUPPORT_GFX_RLC_LS |
 				AMD_CG_SUPPORT_GFX_CP_LS |
-				AMD_CG_SUPPORT_GFX_3D_CGCG |
 				AMD_CG_SUPPORT_GFX_3D_CGLS |
 				AMD_CG_SUPPORT_GFX_CGCG |
 				AMD_CG_SUPPORT_GFX_CGLS |
-- 
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
