Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BA67ECDB482
	for <amd-gfx@archiver.kernel.org>; Wed, 18 Oct 2023 12:21:43 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 37C7610E3D3;
	Wed, 18 Oct 2023 12:21:43 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on20627.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7eab::627])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BB90610E3D3
 for <amd-gfx@lists.freedesktop.org>; Wed, 18 Oct 2023 12:21:41 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CfRnQgchTDzXbOIT02eootzH68MlFQIHrpPWtnTZIcbbdJP4EqlMjgopl2YHMfAQkhOkHsF4yiP8G6M7647PCXU7D/0P7PD4nL5cg8LzmQTO1Fo+KWB0AKKgBIgTJR+DKArtm2wN3FWfJqL7s2p2avgCE4GVurM4InttbRG1MJkoCM7bhO+IgjLiDQwC+EVlf6VfqMRpE7UE2fV3VJsLPkkW+5VW59g94zFoPSE/fBjwwIYBFt43dJzyDqucZFAHejuykQrAPVP0XejROlZQjWYwkMwwN+oedxsOFwNm9j0dzApiLbw54qs6Bw8crGaynOFiRp7DVT25oSSY5jAgTg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JNiCIDZpwwKBKRzkjFScmr++GxgNOQ065/d+18ZWA+8=;
 b=gc31pl4Q8+5KHe48pog66jig6u7/j4WbQZi3uCy97GRH3asFAwVLRXch+gA+1ZyG5oUMeiiVMQ0ctKxjrQKCsMWxnMwZmOL+q1L0Tt7eBHD3l2I2I2qLaC4n6pBMRw1HFebKrnb8VdYcm4TpxaPyo+03R9nENI+Osd5jQp0q1KmpWXaNG1xOohRM0RbZogreVcHNPoP1K6zRCPjIrHBnWzJySpT/BB0YN/ivV8MEu8x9Z9H67M2DQpSWfJmhP0C7m/4HxyulWNp/g5QJE9kjXXWqRHex2pLkK5Clu23wta8zw8DjMc+cOu0sUJY/vgVduePupkveeC/zzB9IBjhL4A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JNiCIDZpwwKBKRzkjFScmr++GxgNOQ065/d+18ZWA+8=;
 b=y/Q1c6Kqu8w4mOygqBwsYWmD1DJOaXPhPGtSXUywVAINO2MKZr1CcuWxTskewNa/M2t4BkbZU7tDdIu1Cj1BkKFe1Thzn0NGxeh5ZTBv0muPJKwzl8RmGSuIHUF2DSxbHNphTebYdISSh92bhOw3Ns6MQ2spPc85uUgWlexuGIc=
Received: from MW4P222CA0019.NAMP222.PROD.OUTLOOK.COM (2603:10b6:303:114::24)
 by PH0PR12MB5607.namprd12.prod.outlook.com (2603:10b6:510:142::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6886.35; Wed, 18 Oct
 2023 12:21:39 +0000
Received: from CO1PEPF000044FB.namprd21.prod.outlook.com
 (2603:10b6:303:114:cafe::fd) by MW4P222CA0019.outlook.office365.com
 (2603:10b6:303:114::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6886.35 via Frontend
 Transport; Wed, 18 Oct 2023 12:21:38 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1PEPF000044FB.mail.protection.outlook.com (10.167.241.201) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6933.6 via Frontend Transport; Wed, 18 Oct 2023 12:21:38 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Wed, 18 Oct
 2023 07:21:37 -0500
Received: from stanley-test.amd.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.27 via Frontend
 Transport; Wed, 18 Oct 2023 07:21:36 -0500
From: Stanley.Yang <Stanley.Yang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH Review 1/1] drm/amdgpu: Enable mca debug mode mode for apu
Date: Wed, 18 Oct 2023 20:21:34 +0800
Message-ID: <20231018122134.3280090-1-Stanley.Yang@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000044FB:EE_|PH0PR12MB5607:EE_
X-MS-Office365-Filtering-Correlation-Id: 0674c5c9-a7d3-41f4-11e8-08dbcfd4c72f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: dChXuYx6AHNkajmj3wXhGbytJrFcPx21oF8XCt9FgH72mB1+cDXcQeCIyf4X5uwArdD6nRXpCZKFSiLDn8w1bgsIBZJhsG/z78/Hy8aaGZXl39naTCUb+a5piZ/zV8qMFG6u/v5ljpp9y0FCvPa4m6yzETNTTdbuKOiPJ+D6kHb1v0bzyiZaKcJ7mwmiLC6i99jEFhh+om25FYCIcVnCgBprN7BO69AdBb6tjgEjH+Lb3BwmuzQBp3FWGXsM5huTdqAH7CN/76sWVH3CvQboVCVQxPJ7CuXUPPHIo3uQRoD0uYWCg6rYlWNbDXzAvStE40k4r5/Hf+0BiVAFBMgx2esGsitfFJbXGTpM4O143CW5rN0wY7qKBO4AsR+hKTTXUA/ImN4YiANGTpHI5EZHtprlyZ5aKGYSgCmZsgJ7E1+atBbbEQUenpWJC3hriDtXxVLoDvw5Mk5TOPvY7xypf7y1o34EeV8oYci7+FD77WHCA2F0pzgdfKmgcLNDgqMH1GehoqAqu6UUz6lPjCIk7dPhTI04TnLmxBRFsjLOjBomNJdp4rfS2hEpnKVgrybNZTBUjTjlMoOE7MQWw8tY4TlRbbnTcdzQSlfzpyfYUgTYEbxSmhCnUwhd+CyNbs05ftkkJSuDBHy+V4Bx3+HcVDjn/sREe8XGlatac+fTVbUgQW5q/fl0H1icQyfJCjq5VftWvZjqu13YVZysdt7fnDEG2qdKlh3gqo8ZSso2Yw78A0586eKw5v1eyssmFeygaXtqO2X7w2SBrB6aKEsfNA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(396003)(376002)(346002)(136003)(39860400002)(230922051799003)(451199024)(186009)(64100799003)(1800799009)(82310400011)(40470700004)(36840700001)(46966006)(40460700003)(26005)(2616005)(82740400003)(426003)(1076003)(336012)(8936002)(8676002)(4326008)(5660300002)(47076005)(83380400001)(40480700001)(356005)(81166007)(2906002)(478600001)(41300700001)(86362001)(4744005)(316002)(7696005)(36756003)(70586007)(70206006)(36860700001)(6916009)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Oct 2023 12:21:38.2949 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0674c5c9-a7d3-41f4-11e8-08dbcfd4c72f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000044FB.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB5607
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
Cc: "Stanley.Yang" <Stanley.Yang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Enable smu_v13_0_6 mca debug mode when GFX RAS feature is enabled
on APU.

Signed-off-by: Stanley.Yang <Stanley.Yang@amd.com>
---
 drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
index cab5a5569bc6..62589ba3c4a5 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
@@ -2298,7 +2298,8 @@ static int smu_v13_0_6_post_init(struct smu_context *smu)
 {
 	struct amdgpu_device *adev = smu->adev;
 
-	if (!amdgpu_sriov_vf(adev) && amdgpu_ras_is_supported(adev, AMDGPU_RAS_BLOCK__UMC))
+	if (!amdgpu_sriov_vf(adev) && (amdgpu_ras_is_supported(adev, AMDGPU_RAS_BLOCK__UMC) ||
+		(adev->is_app_apu && amdgpu_ras_is_supported(adev, AMDGPU_RAS_BLOCK__GFX))))
 		return smu_v13_0_6_mca_set_debug_mode(smu, true);
 
 	return 0;
-- 
2.25.1

