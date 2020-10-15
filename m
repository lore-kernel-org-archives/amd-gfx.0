Return-Path: <SRS0=r20P=DW=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C200C433DF
	for <amd-gfx@archiver.kernel.org>; Thu, 15 Oct 2020 19:41:07 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8A072206D9
	for <amd-gfx@archiver.kernel.org>; Thu, 15 Oct 2020 19:41:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="zhAjOZ+H"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8A072206D9
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D97EC6E0CA;
	Thu, 15 Oct 2020 19:41:05 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2054.outbound.protection.outlook.com [40.107.236.54])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1DC276E0CA;
 Thu, 15 Oct 2020 19:41:05 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YiA7eSNS7N0BcrynL5U9xRsWvawNta6oh48Vuh33esE03cLtfDkwGKsSpYFMBd52c4IuFxVZYR/tRfTmXSX4dfV+XO1V2ORpO4Hp4BQb1GhKF+Rq1gH7bfMPlLcApw6OzsFIW5TkfPWJwlVsvRpoW2A4PeL5TEnLk+Kz1BUaQtGZzD7ySrrD4I6mZWSAO9GNeO1tQK4JeTTdb022hXanbYQagXa03HGXDlQuK+AvCliIv2+d3hWT9bMsW08jEJpMsSIezmFK0u9q2mE8HdqJfwhebkFrNRRRPN2z2/YDR4NavOy61vE3YP5IZ4xkvNrfIrYP31iMyYRDGrkLKtaRHw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uKLaG/EMDhN+6lG/MeWFvJq0Lxc/bHzxmVeZjKUK+TY=;
 b=YviWcF28BDfex9ojBIPp4PS5dpG0AeHS33O7lAHK32lYaMmK5FPRjIfLA6MKHwr1pb9YZoCw9bbjDqyMFnXDR/eIyUc2pMb1bgZ6STMzwxIarkNIyAFKFhtYAALEUCTzbWZkpO2l83CmbNTYpNL5wcCowttDSSW8nQ7xPsQRn3k/0F9nsAow63X+G/YUGtKCY4249iS+BK9W8yNWjXdbzkxWQqwLfymZUrSt6bq0vYCtRFcquJZDsZ+KFX639nynwTmYk+7qsObkPCy1nJ1bbJF29OX7p8Shc5VnFAPUpHkVY1Kpvt1J/TbluuuXWle+pzWeNofplPyKl2rNLsJYvA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=none action=none header.from=amd.com; dkim=none (message not signed);
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uKLaG/EMDhN+6lG/MeWFvJq0Lxc/bHzxmVeZjKUK+TY=;
 b=zhAjOZ+HCNHlKVYvb4RxeR0w1/yz5Ab2qMfkBbQFDXf+/ordzyOAq3M1nYWQsdacBrRdXCqh0TkN3wOdkluL34leKo9Y+r1AvJg42HAn3peSQVf/50khuLciwlOxeFrv+FaID7wrIRlrZsJmv1OG8wXivNISbw06h6PHsEAcU34=
Received: from DM3PR08CA0020.namprd08.prod.outlook.com (2603:10b6:0:52::30) by
 MWHPR12MB1248.namprd12.prod.outlook.com (2603:10b6:300:12::21) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3477.21; Thu, 15 Oct 2020 19:41:01 +0000
Received: from DM6NAM11FT014.eop-nam11.prod.protection.outlook.com
 (2603:10b6:0:52:cafe::fe) by DM3PR08CA0020.outlook.office365.com
 (2603:10b6:0:52::30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3477.20 via Frontend
 Transport; Thu, 15 Oct 2020 19:41:00 +0000
X-MS-Exchange-Authentication-Results: spf=none (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=none action=none
 header.from=amd.com;
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
Received: from SATLEXMB01.amd.com (165.204.84.17) by
 DM6NAM11FT014.mail.protection.outlook.com (10.13.173.132) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.3477.21 via Frontend Transport; Thu, 15 Oct 2020 19:41:00 +0000
Received: from SATLEXMB01.amd.com (10.181.40.142) by SATLEXMB01.amd.com
 (10.181.40.142) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1979.3; Thu, 15 Oct
 2020 14:41:00 -0500
Received: from localhost.localdomain (10.180.168.240) by SATLEXMB01.amd.com
 (10.181.40.142) with Microsoft SMTP Server id 15.1.1979.3 via Frontend
 Transport; Thu, 15 Oct 2020 14:40:59 -0500
From: Eryk Brol <eryk.brol@amd.com>
To: <dri-devel@lists.freedesktop.org>, <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amd/display: Fix incorrect dsc force enable logic
Date: Thu, 15 Oct 2020 15:40:53 -0400
Message-ID: <20201015194053.355335-1-eryk.brol@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 5c44b5f3-5b47-4e3a-ac65-08d871423ec7
X-MS-TrafficTypeDiagnostic: MWHPR12MB1248:
X-Microsoft-Antispam-PRVS: <MWHPR12MB1248B207A71F977BB03D6F58E5020@MWHPR12MB1248.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2582;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: rExIAy149ZNuALtvCbIq5pnlqyHPSyMmKaAP0JpvBOBtBXXhRW2D+c7eANRzS1TLJdvC3mCrIVRkJs2WUOuUkFdFA40u0Xl7YWUiT5QlUE/eVA6ABqt82UMspPBO3WnDz14mAQCiiuG82Bna03gOfxVz9oOU1ce+KWhqUt13ED+RRj5WqKiLFj4WE4Kcy74344arW+IMibDPomKl9Bi+VSq2Fp3TJnntRuGtsylKMS46PlUEpjR/EVncPlZ6DKyq/Glulla0mHbnNik43RtmwqHbFJi17u5BAQsklF+vUELtQDZEXZCOfSaT6zEPK0HrnhGCsx+iEJr7xMQhj5CBTYRxJYXF1ourY+u0CwYNluYfEH9J5JQOlBgsKAiW7clBjFszAh8uzXE7OJm8AMQ+uQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SATLEXMB01.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(39860400002)(136003)(376002)(346002)(396003)(46966005)(478600001)(83380400001)(316002)(70206006)(36756003)(70586007)(5660300002)(6666004)(426003)(2616005)(54906003)(186003)(44832011)(336012)(2906002)(81166007)(4326008)(110136005)(8676002)(356005)(86362001)(1076003)(82310400003)(8936002)(26005)(47076004)(82740400003);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Oct 2020 19:41:00.7039 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5c44b5f3-5b47-4e3a-ac65-08d871423ec7
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB01.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT014.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR12MB1248
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
Cc: alexdeucher@gmail.com, torvalds@linux-foundation.org, eryk.brol@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[Why]
Missed removing a '!' which results in incorrect behavior

[How]
Remove the offending '!'

Signed-off-by: Eryk Brol <eryk.brol@amd.com>
---
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.c
index 98b4d5e2e336..fc87b9faec92 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.c
@@ -644,7 +644,7 @@ static void try_disable_dsc(struct drm_atomic_state *state,
 	for (i = 0; i < count; i++) {
 		if (vars[i].dsc_enabled
 				&& vars[i].bpp_x16 == params[i].bw_range.max_target_bpp_x16
-				&& !params[i].clock_force_enable == DSC_CLK_FORCE_DEFAULT) {
+				&& params[i].clock_force_enable == DSC_CLK_FORCE_DEFAULT) {
 			kbps_increase[i] = params[i].bw_range.stream_kbps - params[i].bw_range.max_kbps;
 			tried[i] = false;
 			remaining_to_try += 1;
-- 
2.25.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
