Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2A82EEB64DD
	for <amd-gfx@archiver.kernel.org>; Tue, 18 Jul 2023 19:02:43 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1788910E046;
	Tue, 18 Jul 2023 19:02:42 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2078.outbound.protection.outlook.com [40.107.237.78])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 65E4710E046
 for <amd-gfx@lists.freedesktop.org>; Tue, 18 Jul 2023 19:02:40 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Q5KumQ2Hz3kW9EUu8dUsop6YqBH/EIpwTwtyNdARwbwE+XE+1NZv9rH3PEAGxuOIujrnqKtIxQ1Wg4l3nYowJALk0GwNq2RT9wPdkc6KFKylvMKt+8vWuZIQ78y1tgcHVpUf5HOFarUNcOKkDvpFLRrekSP+G9LjHna0ODN+IfzDP2uGo6Jvca97wWS0g4RuENWjDuPdOYLUCqfV9yBLWAinCpthBpPMOOphxpVQFWlB9eihsyaIvTxCc0R4TIruy2Ve946u7Yq4KhPhz43K/i2PO5idSgfaXoig4Y0tigRNVDA7u680JfdrK0RK03BaVIyVyMc23dINn94jlKO+tA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4Avxw1Q0m6tqoLQbgBD1MKov8KF77i45Xb4sd2AyfPQ=;
 b=JmUnWTRJfXuFfBHkOtnSplsG0a8nIp2oHR50rjfAkbalRFHuUc3CYswTd8lwVyE1llwdciKxXjGZ7J7lxNijSHihVshaWmxIhVRdCVF8WeZSYwgZlsWDMiMYfcEiSq0ybp6RcePcAdXyyv8Ou16gInbNEM6r/i4UvRGsKctYtLQkZrAiiUYO7UIlW8LyUiadgmiPaVGvPrkWlZr842vdszq/BJOzXM7BjePRF28yZWUuxQFfuutXdX5tsnV1f51QuZGVsFfrvQsTW0jhcQgA45xanC6xFsvcgEN7w/XotOtkNN4szjMXIkI/by3QjuZLUzjw3I93PoMvbSYurjIG8Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4Avxw1Q0m6tqoLQbgBD1MKov8KF77i45Xb4sd2AyfPQ=;
 b=KFoPm+ah/bLpG45YoH5Jxh6GcbawIdAdp5x9BhL4ok5D9ufvm66T4o+eR4g+uK5J5ICRoTXzGi+IGx/2cwLq7gE4zBYYSiy7fTmvcyStTxkAV3s+rxwaaCoM8KteuAFQW4qbV3/blYf3KZGQJhRR0e5mS96AMRnhhzPj53TkxfI=
Received: from MW4PR04CA0315.namprd04.prod.outlook.com (2603:10b6:303:82::20)
 by MW4PR12MB7167.namprd12.prod.outlook.com (2603:10b6:303:225::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6609.23; Tue, 18 Jul
 2023 19:02:36 +0000
Received: from CO1NAM11FT052.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:82:cafe::93) by MW4PR04CA0315.outlook.office365.com
 (2603:10b6:303:82::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6588.33 via Frontend
 Transport; Tue, 18 Jul 2023 19:02:36 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT052.mail.protection.outlook.com (10.13.174.225) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6588.34 via Frontend Transport; Tue, 18 Jul 2023 19:02:36 +0000
Received: from ubuntu22.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.23; Tue, 18 Jul
 2023 14:02:34 -0500
From: Victor Lu <victorchengchi.lu@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amdgpu: Fix infinite loop in gfxhub_v1_2_xcc_gart_enable
Date: Tue, 18 Jul 2023 15:02:19 -0400
Message-ID: <20230718190219.320278-1-victorchengchi.lu@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT052:EE_|MW4PR12MB7167:EE_
X-MS-Office365-Filtering-Correlation-Id: 36ea2c68-812b-4d09-4376-08db87c18cd3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: uiyj8vVZ86szK5NA6eGxGt/rFgqRXOwGY7j7/oG9oUTpgut+QpLLbMeJfYZKEUpLUjvugrZH3AIdPo8HjetLw/UiQ2pQ0O4A1U/vVBs0Fr4DzKf0aMx7wzUzefyE4dn5abW/Uc9ajxAsTeUJdIUigvG9omIvDtT2FVv4PBoJR527Uo281gNXY3ymcuedGWWXpbjycqP4FeYLiqkfGBbHtG/fB8tgUHKLEVSTZ6PT7BzkeVsrbnDFzvXOe8rsyCriHaK5Hnehu3Wa/pPkiJH/a/3mzBbdox1MckoF5+i8TSN+moHf4FUzAgq1rHm1H7Lj2ayrlNPKKmcKEP52m+w5ZxOPkiOKBURFasA84IkQq6VpnROiS6R009zrLZoIJKJKb70Ux/AFKmBtATq9aEL8sQ0kjena7R2d/gPpezH+fzvrmms5VJ6NAWDt1P5TSHFjeV/HKQrbZ2EVXKxjtUWw/6qU8A/2QLo4dvqOLcS9eKBY9oBG/VSsMkfB+/sn72lCihwDj0hUHc6pTfWW3kTiDOgeADGNh7UtnuM3U0G0MP6XSxSjuN+kc4PMbk8zQES0J/jwcO/l9yo0UR9px9gm3di53OuhhLdIh8LVWzWPNCmMBEo0ugyeMQLW28iZmJKSMiPr4ZLxA7TnIVW1el8P+YDt5r0gDIRuZ0W/vxxIWwRRvrLWjieBbspRJzf7s+iuRJGXCXyIsrvkjO4SDDRFZcTZbTT4+7xweXjZX4c4ArX/qcfyxkOHt23Ua0u75WRzT5eaGXogA0b4EYZCV+hbpg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(39860400002)(396003)(376002)(346002)(136003)(82310400008)(451199021)(40470700004)(36840700001)(46966006)(2906002)(4744005)(8936002)(8676002)(6916009)(4326008)(316002)(41300700001)(5660300002)(26005)(336012)(1076003)(36756003)(7696005)(186003)(70586007)(70206006)(478600001)(6666004)(16526019)(40460700003)(54906003)(83380400001)(47076005)(2616005)(426003)(36860700001)(82740400003)(81166007)(356005)(40480700001)(86362001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jul 2023 19:02:36.2588 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 36ea2c68-812b-4d09-4376-08db87c18cd3
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT052.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB7167
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
Cc: lijo.lazar@amd.com, victor.skvortsov@amd.com, victorchengchi.lu@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

An instance of for_each_inst() was not changed to match its new
behaviour and is causing a loop.

Fixes: 50c1d81d6365 ("drm/amdgpu: Modify for_each_inst macro")
Signed-off-by: Victor Lu <victorchengchi.lu@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gfxhub_v1_2.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfxhub_v1_2.c b/drivers/gpu/drm/amd/amdgpu/gfxhub_v1_2.c
index 47f95ec218a3..b74df0e9fb08 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfxhub_v1_2.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfxhub_v1_2.c
@@ -413,7 +413,6 @@ static int gfxhub_v1_2_xcc_gart_enable(struct amdgpu_device *adev,
 	 */
 	if (amdgpu_sriov_vf(adev)) {
 		for_each_inst(i, tmp_mask) {
-			i = ffs(tmp_mask) - 1;
 			WREG32_SOC15_RLC(GC, GET_INST(GC, i), regMC_VM_FB_LOCATION_BASE,
 				     adev->gmc.vram_start >> 24);
 			WREG32_SOC15_RLC(GC, GET_INST(GC, i), regMC_VM_FB_LOCATION_TOP,
-- 
2.34.1

