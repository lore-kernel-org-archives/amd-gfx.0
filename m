Return-Path: <SRS0=mx+S=6H=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E3E3C54FD0
	for <amd-gfx@archiver.kernel.org>; Thu, 23 Apr 2020 07:01:58 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 63775208E4
	for <amd-gfx@archiver.kernel.org>; Thu, 23 Apr 2020 07:01:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="j5dH1xlV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 63775208E4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 319E889DB9;
	Thu, 23 Apr 2020 07:01:58 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2066.outbound.protection.outlook.com [40.107.94.66])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CCEC089DB8
 for <amd-gfx@lists.freedesktop.org>; Thu, 23 Apr 2020 07:01:54 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DxEWLHohvzT0/ms1ADQnotVvgE+eekFH0CCqvQ2XK7MP7AIZnNS9e9rNhREyoNCx8CFfcrj6ProlLeOC7rArdxu8gezGm8GfAnGp7sBv2hATXUMlf87i+0CoNncSeEGhB+hwG0MkewUPl56B/1PTPvWptAsCF3/m5zWsgb3aiA16ngplW3w0KbpvuSlh5KA5yAhI9Z3JzKNwueDPT0wZ2RjHhi8ZDtSTV7UUG5L4c29Et3F36R5BTxtlCQE8f8kXzJm3WN+zUCcM6EmKOmJeeKvCuoWCymGnk3UsYcUOhMxWwQ5fVBKtfe7QZa31woWxxotIR+ehgdaz4qJvamzMgA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jfKVhlvQudxvVeeQH7N0Tf9YMz+9GIyes1wyU4x3HZs=;
 b=Pp2a5C/L5sEvS1zSSfum1nOj/OiqH/RPw7pjl1OBSeBwQsubqzjotbe8ozqqExHbkMvSaxmmORYy5VOnzHipzPYFq57lFgnbT/NS9DeIXMdfk4dmvxcFPjizpOIUqHIAALjAbyuHBbPbfR4E7bN6BTPE4kZeDQQQn59f+WEXGPj+5AAymkmdNX8RzpIqRiJjkBZERhn5TvX67bSRURhdK8zc7Y7tcLcRk+8t8x4swDLJkvdrkfZCPI/1SQAhkNgGbQiG5/yhzMslogb22Z3+HdjXq+//OytI9Xwo2zRmR2QvekL70gBeAvpD5qqbtpCyDOCBdM3cOdqekEcMoMZC+A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=permerror action=none header.from=amd.com; dkim=none (message not
 signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jfKVhlvQudxvVeeQH7N0Tf9YMz+9GIyes1wyU4x3HZs=;
 b=j5dH1xlVfqrI6WFeR3vOMrn9ay2ig8kRQbLYRhshWfVpd61AU3f9T5UFCtElKwKW6uGheJVGVrneRsn5tkhilQB1MBwgEHhbnWwu239ewd6xENAnmWIiWvMoLMAMmCWjitQ3AeioTZnb22qFT3xon31sgXL1yh6QT4YOq5NI4Lg=
Received: from MN2PR16CA0042.namprd16.prod.outlook.com (2603:10b6:208:234::11)
 by BN8PR12MB3601.namprd12.prod.outlook.com (2603:10b6:408:46::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2921.29; Thu, 23 Apr
 2020 07:01:52 +0000
Received: from BN8NAM11FT060.eop-nam11.prod.protection.outlook.com
 (2603:10b6:208:234:cafe::7e) by MN2PR16CA0042.outlook.office365.com
 (2603:10b6:208:234::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2937.13 via Frontend
 Transport; Thu, 23 Apr 2020 07:01:52 +0000
Authentication-Results: spf=none (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=permerror action=none
 header.from=amd.com;
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
Received: from SATLEXMB01.amd.com (165.204.84.17) by
 BN8NAM11FT060.mail.protection.outlook.com (10.13.177.211) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.2937.15 via Frontend Transport; Thu, 23 Apr 2020 07:01:52 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB01.amd.com
 (10.181.40.142) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5; Thu, 23 Apr
 2020 02:01:51 -0500
Received: from SATLEXMB01.amd.com (10.181.40.142) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5; Thu, 23 Apr
 2020 02:01:51 -0500
Received: from monk-build.amd.com (10.180.168.240) by SATLEXMB01.amd.com
 (10.181.40.142) with Microsoft SMTP Server id 15.1.1713.5 via Frontend
 Transport; Thu, 23 Apr 2020 02:01:50 -0500
From: Monk Liu <Monk.Liu@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 2/8] drm/amdgpu: skip cg/pg set for SRIOV
Date: Thu, 23 Apr 2020 15:01:40 +0800
Message-ID: <1587625306-20704-2-git-send-email-Monk.Liu@amd.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1587625306-20704-1-git-send-email-Monk.Liu@amd.com>
References: <1587625306-20704-1-git-send-email-Monk.Liu@amd.com>
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SATLEXMB01.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFTY:;
 SFS:(10009020)(4636009)(39860400002)(396003)(136003)(346002)(376002)(428003)(46966005)(82740400003)(47076004)(8676002)(2906002)(316002)(26005)(81156014)(4744005)(6666004)(336012)(82310400002)(4326008)(186003)(2616005)(70586007)(70206006)(6916009)(7696005)(8936002)(5660300002)(356005)(426003)(478600001)(36756003)(81166007)(86362001);
 DIR:OUT; SFP:1101; 
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 11a7940a-c920-46c8-5e70-08d7e7543365
X-MS-TrafficTypeDiagnostic: BN8PR12MB3601:
X-Microsoft-Antispam-PRVS: <BN8PR12MB36019DC8CD19500C2CF5CC8D84D30@BN8PR12MB3601.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:346;
X-Forefront-PRVS: 03827AF76E
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ybSDk78fAP/tV4f18pfw7EHFq+dj/ftBP/0xUqJiUpNKtJTaEwi3wcm5yEWXFZA7Bc+Ni2jsAM0htEOUQrZDuqRFe4oPW4immSYo8Tyfsnm3E8KzGHreZ+gXoHMVvLdkDfgDAS5QVf0lGlbWpjjW7RNR4lmeqJs0AfBJIFbbw/zI1hTNt7r5+bei1gPLFVzmU1Y7qwklVlaILWBtWdiVRpidpWZoNh2kLkFGnsvJA4oqSFotnCkO1thn2jPCX6LG/Uory5uv4LQvFFziH8yYov7+i/bAgCTC4lmHBmMcZdoTXswBoqI9Kyj/XQwdr+0Ak971zwSIsHc4mwoBqj6j/iHPMjQohR/RddddpOc4+TzEE0WAOM8m7Q3RMdidL/MUVknzVC4THA8m2u9kKMnrH2UgLO54DB2dPWe0m8n8g8vhs+H901LaUC7tAWNAgtDBCBXlHPmPAbcnoraRIgODRRI+ItFQaTnFhNbyPkf1a2IVbgTCkCIkors3+QIiQg1jhW0FyBff9EU11L5GpMMzxA==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Apr 2020 07:01:52.1325 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 11a7940a-c920-46c8-5e70-08d7e7543365
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB01.amd.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR12MB3601
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
Cc: Monk Liu <Monk.Liu@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Signed-off-by: Monk Liu <Monk.Liu@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
index 8a579ce..909ef08 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
@@ -7095,6 +7095,10 @@ static int gfx_v10_0_set_powergating_state(void *handle,
 {
 	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
 	bool enable = (state == AMD_PG_STATE_GATE);
+
+	if (amdgpu_sriov_vf(adev))
+		return 0;
+
 	switch (adev->asic_type) {
 	case CHIP_NAVI10:
 	case CHIP_NAVI14:
@@ -7115,6 +7119,9 @@ static int gfx_v10_0_set_clockgating_state(void *handle,
 {
 	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
 
+	if (amdgpu_sriov_vf(adev))
+		return 0;
+
 	switch (adev->asic_type) {
 	case CHIP_NAVI10:
 	case CHIP_NAVI14:
-- 
2.7.4

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
