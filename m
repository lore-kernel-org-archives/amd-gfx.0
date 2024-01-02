Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2A70FC47073
	for <amd-gfx@archiver.kernel.org>; Tue,  2 Jan 2024 17:30:38 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A34D410E0DE;
	Tue,  2 Jan 2024 17:30:37 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2081.outbound.protection.outlook.com [40.107.237.81])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 04D7110E224
 for <amd-gfx@lists.freedesktop.org>; Tue,  2 Jan 2024 17:30:36 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PpYAQWIm5fEBN3KkrSMlI6XuDx2o8H+Is5y8kBAC50GUkCIINjbgPOkJAo+r9IJEM2vXiTgTaN8+yS2Q1hjDaHoRbc0+4QizQcwhBq79KApt+DdyKO5MPwfyu9TSUmy6IpwLc4newqR1gssB/MhwlXBQF6mAdg+Ou2vWM71I5XhP1XQiT+iDieiMuzLDLQRJZDVjX6pJgAwyFlIK2Bwj0VIiWhl70fsoaKfXMdpbL/QXIou7y5K9k7tvqpsuJKzY8HBlAX1FriHkON59xjAlAMAael2xtAafakCAC2GwXdu9Z2CApfdLW/NrJ3le0p/sKGh+OqD7GYRPkmZS1HUCSw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jD/zPFO6xwWPHr2AMLtYk1VZWmIw+xLOzymM3p0WuPQ=;
 b=S0HdfK6dPlzFhU4BpoHzyVG9jQ/SVCCm6ppNL/7FZkDqmD4lHTJ/brXEKytkrwRHVw4gVp9PWGQa8xK5SmkgXlughLLu0FlxWYLrPa/uCO0okdFkpSRMwQAIJFOg+C4TU/BOEFkph+U+Z7LOs4hsb1mB7bW51yRUVGRG1VxY78byDLPFrejVOwrpEUj9nd0YmR9EmYc+yIv3eWXuNb2ExXHhIZmbpAbyCI0hGJQ2qF5/MfiOFvFwILWIzGe3/57SATtBSbuBnbSLks3wYDUvwxOy7gE9kCsnpMU5DDHp+ejFRNSurbY6kuuscSr2tNVklyun7r94WxZExYG/qIflbw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jD/zPFO6xwWPHr2AMLtYk1VZWmIw+xLOzymM3p0WuPQ=;
 b=sHQr4eY8imDNXks76XDszg5DvMJJ9uL/OLtxQFCevoH6xU3EF9AQ6sZhrgiZdyaScItaEH62g1fDT+DlFcY9u+iXtJ7UvwkvTfRSecp4zLU7C6GDnPe1UqOM+bWhdklnTyh/yjpOQDfZAFh8wi9IpzVOPGVV0NQ02p5umN6PVXM=
Received: from DM6PR02CA0108.namprd02.prod.outlook.com (2603:10b6:5:1f4::49)
 by CYXPR12MB9444.namprd12.prod.outlook.com (2603:10b6:930:d6::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7135.25; Tue, 2 Jan
 2024 17:30:33 +0000
Received: from DS1PEPF00017090.namprd03.prod.outlook.com
 (2603:10b6:5:1f4:cafe::29) by DM6PR02CA0108.outlook.office365.com
 (2603:10b6:5:1f4::49) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7135.20 via Frontend
 Transport; Tue, 2 Jan 2024 17:30:32 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS1PEPF00017090.mail.protection.outlook.com (10.167.17.132) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7159.9 via Frontend Transport; Tue, 2 Jan 2024 17:30:32 +0000
Received: from ubuntu22.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Tue, 2 Jan
 2024 11:30:32 -0600
From: Victor Lu <victorchengchi.lu@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 2/4] drm/amdgpu: Do not program SQ_TIMEOUT_CONFIG in SRIOV
Date: Tue, 2 Jan 2024 12:30:11 -0500
Message-ID: <20240102173013.5543-2-victorchengchi.lu@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240102173013.5543-1-victorchengchi.lu@amd.com>
References: <20240102173013.5543-1-victorchengchi.lu@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS1PEPF00017090:EE_|CYXPR12MB9444:EE_
X-MS-Office365-Filtering-Correlation-Id: 62173b25-cd79-4855-4797-08dc0bb885ff
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 7OEWCQljoq+wjXOy8tz7uYXJCi8/hfQ6BEgmup85wPjahdHE0PH/E7xjWFX/OusFzIfLFvQnLZ+r+za3hwmWXP1fiEyYhdmL+wNWGDQuzotL61ssxu0pKRWaxLsYGLNHihwQJRwyGXHWSCIOCb4VEqn0UMod900hdKAWDD9Pg9RcySq5iRBE9GcSVqf+3F4zyFRMbNIxRBAPc+Dz/PbyMrce5SVs36iAJ+weBXsfWMywje1/YK5IFZOyKL/Wxjs5NbhgkjhLnFSViV+r1hVWVKzTW/E/c3M5b6jqI6cl4vEyRBo60Tu0bufBLMBaQrQXZynME7OtHpGih9+jmbSxnIN9nn2Yy9pOHKR/nf+jWO78WbV99gW8TqOI0CajHy+ksxrcnwCtjooO+nIb5xPbwPoIrsYFkWWqGYFb8v7IwK6mTV6TcVZqrCpV8yQqvL/VcDaT4CQUFfirrOlP4E3Qgw9rwcLd9pPDXWLwf+K6GfR3PmF80Xsp9iXiXv8aI5WTXf00bcXRG2vZXtILYsRG7KbGLN4SlZ5aMTNnRmvqG6ukXtWFQTp73nsKaJSU77gp8L23BaSwGPF6YFAKGtYtpVZqDjLU/cRG/V6H3VpbQ1lPkD6+gp3E9tEqsGdkvP2nd9CqBbnajriXXV11GgutEYwW2DKnVtACrV+4dS8ZscIu4MgPoatXSuoVH95Z2BDUk+YpAro+AQi6L3UTLS2VQ9uv2lCDnuzBPiAkqUXgA9Co5ByFkr7wOnIWKvrUz0GhboRCFz3jp4m9lATXImhX2A==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(376002)(136003)(346002)(396003)(39860400002)(230922051799003)(186009)(1800799012)(64100799003)(82310400011)(451199024)(40470700004)(46966006)(36840700001)(36860700001)(478600001)(40460700003)(41300700001)(82740400003)(356005)(6916009)(36756003)(4326008)(81166007)(54906003)(316002)(70586007)(70206006)(86362001)(16526019)(47076005)(6666004)(7696005)(336012)(26005)(1076003)(426003)(40480700001)(8936002)(8676002)(2616005)(4744005)(2906002)(5660300002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jan 2024 17:30:32.8818 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 62173b25-cd79-4855-4797-08dc0bb885ff
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS1PEPF00017090.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYXPR12MB9444
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
Cc: Vignesh.Chander@amd.com, Victor Lu <victorchengchi.lu@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

VF should not program this register.

Signed-off-by: Victor Lu <victorchengchi.lu@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c b/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
index 00b21ece081f..30cc155f20d4 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
@@ -3888,6 +3888,9 @@ static void gfx_v9_4_3_inst_enable_watchdog_timer(struct amdgpu_device *adev,
 	uint32_t i;
 	uint32_t data;
 
+	if (amdgpu_sriov_vf(adev))
+		return;
+
 	data = RREG32_SOC15(GC, GET_INST(GC, 0), regSQ_TIMEOUT_CONFIG);
 	data = REG_SET_FIELD(data, SQ_TIMEOUT_CONFIG, TIMEOUT_FATAL_DISABLE,
 			     amdgpu_watchdog_timer.timeout_fatal_disable ? 1 : 0);
-- 
2.34.1

