Return-Path: <SRS0=MTnY=7D=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65EB4C433DF
	for <amd-gfx@archiver.kernel.org>; Thu, 21 May 2020 19:53:24 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DA1A020738
	for <amd-gfx@archiver.kernel.org>; Thu, 21 May 2020 19:53:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="Tmemzokl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DA1A020738
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6FBEA6E051;
	Thu, 21 May 2020 19:53:23 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2072.outbound.protection.outlook.com [40.107.243.72])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 40AA96E051
 for <amd-gfx@lists.freedesktop.org>; Thu, 21 May 2020 19:53:22 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fyI1GIwmeB4ozXwukdyH96/7Bsgt/5DXLyj3Uz8sD1LZbWpF65STUPjdLCsHma77haNTLrGhMyhvUNkboS4ApzetXDjZxrwsOtt8cdpMDbHTxGVgUdytYorUFiuspx+vBd+fqlwFbqxyGYqxGQGfm2nav4KVDASjsKmN8tndDyzQoNQCHGr5OMSAI4Ynn7h0mXIW5vd4MzO5Hi30RNAKPSBSUjeT6JpoEt3g+rgrviIJhY5NFun82DXEbviwd6tDUhFIvC28PFaKOpSitETIP7sEIowCglDBAqMe3U8nXkbCMYmQ8pe30hfQFcNrfiRVU9xHJ9dFZ+KqPuwHq75S2A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bxumRR8hAo8qMDsLJeKM9CDTV6Rn/20pVtNZvVODEVA=;
 b=LGMh+kPUgOWK5aShDU4DjzlxvUHYRXIQhDKcALYX/6G8Zv7B2dvR0wlkD7IO9QyNSwnlyeqaUZ66uR/OOVC8TVzPw8Q8cezFqYr5I+fHk0e6zGpAYz2JqbacGv/UTh6maitu8EyyMzhIEBE0tchLUQlpNDF6S0QJzdldA17aY9BQZlP9Ux0K9jlt9ZPZOE1o1eQOHVjKbr6bZlkKVN7td+/sYlBcXHBhNkIgEV7kHGdW1EKUPpfwxJ1pv/cH/BeaKba1VHCXEQW3AZQ1Zg5qBDhcTLEfb8dVULuhpUK6Yd4PPifYskz+DhQRU1v/LM5h9GCb+NU6mYm/IkDWyMxVLg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bxumRR8hAo8qMDsLJeKM9CDTV6Rn/20pVtNZvVODEVA=;
 b=TmemzoklJ5kw8UsEMlHARxD8pnafIwja1wS2obnxFpaclpLhMK1afarKIKpiQNKTzuVJYKdYoi2JGDAZW8t1qAnJ966rSObjB+cRX+KSxHCAA7mC4VPt+iSZiI16AAwcc9Lid2tR445XREEd7Vf8Klz1W4aoh6jsrGKRfpsjjfA=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB4121.namprd12.prod.outlook.com (2603:10b6:5:220::14)
 by DM6PR12MB3244.namprd12.prod.outlook.com (2603:10b6:5:18c::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3000.20; Thu, 21 May
 2020 19:53:20 +0000
Received: from DM6PR12MB4121.namprd12.prod.outlook.com
 ([fe80::21db:6afc:4193:872c]) by DM6PR12MB4121.namprd12.prod.outlook.com
 ([fe80::21db:6afc:4193:872c%8]) with mapi id 15.20.3021.027; Thu, 21 May 2020
 19:53:20 +0000
From: Gavin Wan <Gavin.Wan@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH] drm/amd/amdgpu: Fix the CGCG setting is overwritten for SRIOV.
Date: Thu, 21 May 2020 19:53:06 +0000
Message-Id: <20200521195306.261777-1-Gavin.Wan@amd.com>
X-Mailer: git-send-email 2.25.1
X-ClientProxiedBy: YTBPR01CA0015.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:14::28) To DM6PR12MB4121.namprd12.prod.outlook.com
 (2603:10b6:5:220::14)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from Gavin-Ubuntu-00.amd.com (165.204.55.250) by
 YTBPR01CA0015.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:14::28) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3021.23 via Frontend Transport; Thu, 21 May 2020 19:53:20 +0000
X-Mailer: git-send-email 2.25.1
X-Originating-IP: [165.204.55.250]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: ce33fdf0-de62-4d09-f569-08d7fdc09d03
X-MS-TrafficTypeDiagnostic: DM6PR12MB3244:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR12MB3244D40B737A3463D5010259FCB70@DM6PR12MB3244.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5236;
X-Forefront-PRVS: 041032FF37
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: b6DQM+5KpA8LBlCuupgD5UqEh7WpOCbtXBfqO4hbbECNrsPhnPi7zuu4KyX4b8A5suoDy3ogoliuZfFlgAIvmZtO+Y/9w8sKXvSeqmFpUgpSLkQbO68FwsIkyJd0iaxm2cUbCjLxIELu5Wxgt2fno+FBfqPiW+aVOcjJz5osmSXuzBZn4qY3fAptf7/y0kOMYCwbB6EXYZc/V6GxqlwTZzHXQy0b0TKl+pGC/+QnxuYRvk0p3BzIaQOmjpEYki5rowj8GpI47+/zrMsAMpXaQsRPFbrxaoYsemF20h3S0kgnZdFiTEMeeFxBJMkIK3A9Ggyvn7vqBV8dZtoc2cvrCcLj3OjVWdFb46qgkpiMB/w39dymKpJBC0QCUGlKMTVU5lmR0GVN/iGGwovEdJ3+NimpTc+sHFtDvIW7kefr7IV7EsFXs66nJDGikT2/gHgZ
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB4121.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(346002)(39860400002)(136003)(366004)(396003)(376002)(66946007)(16526019)(66476007)(4326008)(8936002)(316002)(956004)(1076003)(52116002)(2906002)(36756003)(186003)(7696005)(8676002)(478600001)(5660300002)(66556008)(6916009)(26005)(86362001)(6486002)(6666004)(2616005);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: 27VcdoAIzZnj8C16fb0v1fIWVNgL8gQ9dF9QNLu++TFscjt7L0dGo+M5bO3MVzg8XngodbZS2LTFlH3eTXEWGFWYKIcnXn2gF3VCbIYvSbHtpGN8ja+jphnZJ6mfIzaBaYPHxZ1Y4t1938FugMQQ5/VNjq2CI7fpigPmqE0c2jZMfuuv4koERVQWX/wcK7vo9VeqQqcdEZ7sSLMZyZu/Xep4AVS2fIcItoThizZoVxzkSDCdJemNXKusAWrR5k6du+FIZ0lwXu2ycZwk133h8vjyt9cCKbYnPx7V8dux5k7aJKhr4HqzOhD3EzdClLhdz48SWq6yEss+s+TOQjj1QhGXWxHvGddognGZK7wEtwv/94foaLKFJWsDOLYGmXtlQDFQBmWq6ZY9RjdBSiQ+MsIYaZlKUDONoVMytidvpMK2/6rQMaGzh7kj1ML2uCeR2LnvnrJ7OE5CZ1D9NwcNVmwfSHe0W1y4X274wKbw8AAbpWKZ1g8juxVq6M1zOY3D
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ce33fdf0-de62-4d09-f569-08d7fdc09d03
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 May 2020 19:53:20.7608 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Szr9fb5diYchWL9DbvpZgcDX+EySvdwBTPQLSib71Ocn8odMwNmHubgEyapUMeR4
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3244
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
Cc: Gavin Wan <Gavin.Wan@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

For SRIOV, since the CGCG is set on host side. The Guest should
not program CGCG again.

The patch ignores setting CGCG for SRIOV.

Change-Id: Ic336fab3b23b8371c9e9e192182a3ba14a8db8e1
Signed-off-by: Gavin Wan <Gavin.Wan@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
index bd5dd4f64311..52b6e4759cf3 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
@@ -4558,6 +4558,9 @@ static void gfx_v10_0_constants_init(struct amdgpu_device *adev)
 static void gfx_v10_0_enable_gui_idle_interrupt(struct amdgpu_device *adev,
 					       bool enable)
 {
+	if (amdgpu_sriov_vf(adev))
+		return;
+
 	u32 tmp = RREG32_SOC15(GC, 0, mmCP_INT_CNTL_RING0);
 
 	tmp = REG_SET_FIELD(tmp, CP_INT_CNTL_RING0, CNTX_BUSY_INT_ENABLE,
@@ -6842,6 +6845,9 @@ static void gfx_v10_0_update_medium_grain_clock_gating(struct amdgpu_device *ade
 {
 	uint32_t data, def;
 
+	if (amdgpu_sriov_vf(adev))
+		return;
+
 	/* It is disabled by HW by default */
 	if (enable && (adev->cg_flags & AMD_CG_SUPPORT_GFX_MGCG)) {
 		/* 0 - Disable some blocks' MGCG */
@@ -6911,6 +6917,9 @@ static void gfx_v10_0_update_3d_clock_gating(struct amdgpu_device *adev,
 {
 	uint32_t data, def;
 
+	if (amdgpu_sriov_vf(adev))
+		return;
+
 	/* Enable 3D CGCG/CGLS */
 	if (enable && (adev->cg_flags & AMD_CG_SUPPORT_GFX_3D_CGCG)) {
 		/* write cmd to clear cgcg/cgls ov */
@@ -6953,6 +6962,9 @@ static void gfx_v10_0_update_coarse_grain_clock_gating(struct amdgpu_device *ade
 {
 	uint32_t def, data;
 
+	if (amdgpu_sriov_vf(adev))
+		return;
+
 	if (enable && (adev->cg_flags & AMD_CG_SUPPORT_GFX_CGCG)) {
 		def = data = RREG32_SOC15(GC, 0, mmRLC_CGTT_MGCG_OVERRIDE);
 		/* unset CGCG override */
@@ -6994,6 +7006,9 @@ static void gfx_v10_0_update_coarse_grain_clock_gating(struct amdgpu_device *ade
 static int gfx_v10_0_update_gfx_clock_gating(struct amdgpu_device *adev,
 					    bool enable)
 {
+	if (amdgpu_sriov_vf(adev))
+		return;
+
 	amdgpu_gfx_rlc_enter_safe_mode(adev);
 
 	if (enable) {
-- 
2.25.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
