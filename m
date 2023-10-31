Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B2953C4332F
	for <amd-gfx@archiver.kernel.org>; Tue, 31 Oct 2023 02:12:54 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 60A5F10E3D6;
	Tue, 31 Oct 2023 02:12:54 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2043.outbound.protection.outlook.com [40.107.223.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B011C10E3D6
 for <amd-gfx@lists.freedesktop.org>; Tue, 31 Oct 2023 02:12:52 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VAZnC+FDmbYRi8fYRPsE4SO8BnZa7/LQBrza65mkhAfW7sGrpgSp5z7+CHCcSt1tCDgFC+aR2LniBri83iKui04VsomEnvY4DCTClnBtDn8tecBK9bbFznopkMISppDQmkuiAXrPwhLA2DfoVP8ncBNX5UoS1NnwD0H8nXJ1b4+UGf1z3d5gFVdOnNGoeM3SsZXcggpPj3hFvy7Jp+826H++6kdu5/+SGGNeuecg/nwHMNQWfufATLn0VCZUoHgLbr0zepi3WrmBz0U8pilKxlMlLBZt1zNzg/bwT+z522YuBFHNPKi5JabKVattP0EG1cBWvt0unGuyKakOSLb1lQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UjFI0iN5I2WYegoaKSxZtuyXFxFKMcZz1SsxD3FOXNU=;
 b=WSf85DKGbTp1uVZm6nUIjy2EGzNklUaXNgGWfKaztr0CKH/riXHSqukXD0bJcU4gmt4cqPO1WkPQxTihSjDONaBvCVu51gbmLY6rXjD8g/QtqEcKJayzFLyXtHJF96JRl4xBEgBUkWNxQfQkz8LF4cP4fstD3E9bmVDyMjpujXhpdZfSqCb7lwduzV8z120iMJRXA59F091BNghY7UJqcsgnsw2QQakn/Cj7ndk60gm0Vur5XLe7yOxgwG5eISvkVnvQ/mvoLG3CnuTliFJnmAhOZPIkVup1RbCCtgic87eslfIyQ8gxyEXzYLr+fZLNfaGGpPbo9t9Vh8Aqp3vFyQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UjFI0iN5I2WYegoaKSxZtuyXFxFKMcZz1SsxD3FOXNU=;
 b=IjWnGVT3xcxg9CrJC2C/V9ss8HqVbI6JblnlyBNo6zPFnv7jXSYqXIVa6qnhR00jx19roo04lrffPtOxYni0wog1PRi9OyckT58I6KY9nU6DzqNEB4OqBkDXXBB8yyZizFJjhra6g5Y1G/yoD7ErEhFsSRZvJXJMwLNURY7Arqw=
Received: from DS7PR03CA0248.namprd03.prod.outlook.com (2603:10b6:5:3b3::13)
 by SN7PR12MB6816.namprd12.prod.outlook.com (2603:10b6:806:264::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6933.29; Tue, 31 Oct
 2023 02:12:50 +0000
Received: from DS1PEPF0001709B.namprd05.prod.outlook.com
 (2603:10b6:5:3b3:cafe::7d) by DS7PR03CA0248.outlook.office365.com
 (2603:10b6:5:3b3::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6933.29 via Frontend
 Transport; Tue, 31 Oct 2023 02:12:50 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS1PEPF0001709B.mail.protection.outlook.com (10.167.18.105) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6933.18 via Frontend Transport; Tue, 31 Oct 2023 02:12:50 +0000
Received: from kevin-mlse-vm.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.32; Mon, 30 Oct
 2023 21:12:49 -0500
From: Yang Wang <kevinyang.wang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amdgpu: remove unused macro HW_REV
Date: Tue, 31 Oct 2023 10:12:36 +0800
Message-ID: <20231031021236.2682661-1-kevinyang.wang@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS1PEPF0001709B:EE_|SN7PR12MB6816:EE_
X-MS-Office365-Filtering-Correlation-Id: 63125e49-e136-4c9c-4cd0-08dbd9b6e223
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: a2SXkxS1XbztMON5kzIzMPMOSv4Xf92serZ5Hckk9i/OzSHGjaYdZWBRdD2CX7WJT4MmKD2aDKVZjJNi+zzSduqhSeUig8g1CSPCs5CISzENftFgfwYyR0UjD4l55Dfq8IeOMhek1qBDymZ4ZpJQKZy+yuU6osdXm/JhPqmCZDJ/ca9jiblz8gc3jVWXFPk3r1oKHwt9oOESdiLRlkVNJPh1t4Uz+hhBH+ywltWIKpwAUkzxAkHjufb5nG/+ok00oho9voPa+e7xs7S+US/SYv+A46CCh6SeBIWbBukL9bhZZuUGnPhYPaDXP1AHH+XWeNiMYpxVicWhESGwSzTqtBf9gZiRrBSmn8T8gpuN9Oh7K44WveWG1aBqiEpb67fkZKFaFbXyANawDW7ErkFaFKAnunTjlg2+SM5kkSrk9ToNCtWflONgo4xuQ9FfLP98yAWECVZypiTH+sT1T3fr4LX6e7LqkYADW59rJdcG3wS/QltpHUSs94gY4juJTq6CD3CG/DgF0gIEN1qX/dU3g0pUU2n/RXa6ntcT/IIVwrg2zqZ1TwpyKPt2MJlsRHEBGvwFYw1PRpmFc8w9MvE2VtpLjOk1CQkzLxS/hC+7b6GKVzAIEtn51rxOh9OhoqLUyCrTkM+zom4F3L7vRa/1nMosd3GKYt1qOTjFNY4aAwAK57tp2hRRMzvFl6AAnRSpiWRXTUNUQNiX/V1Y8pTEt5wp7TVxUj1nxzp45wJwGkiAQLb7YPMIy7LtdxRCHOSCIP1PLfRvsq1hDeBZTTtRWw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(376002)(346002)(39860400002)(136003)(396003)(230922051799003)(82310400011)(451199024)(186009)(1800799009)(64100799003)(46966006)(40470700004)(36840700001)(36860700001)(83380400001)(47076005)(7696005)(6666004)(82740400003)(26005)(426003)(2616005)(1076003)(336012)(16526019)(86362001)(36756003)(81166007)(356005)(8676002)(4326008)(40460700003)(316002)(8936002)(40480700001)(6916009)(41300700001)(5660300002)(2906002)(4744005)(478600001)(70586007)(70206006)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Oct 2023 02:12:50.3515 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 63125e49-e136-4c9c-4cd0-08dbd9b6e223
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS1PEPF0001709B.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB6816
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
Cc: Yang Wang <kevinyang.wang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

remove unused macro HW_REV

Signed-off-by: Yang Wang <kevinyang.wang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu.h | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
index a2e8c2b60857..969d8ba8b8dc 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
@@ -365,9 +365,6 @@ struct amdgpu_ip_block_version {
 	const struct amd_ip_funcs *funcs;
 };
 
-#define HW_REV(_Major, _Minor, _Rev) \
-	((((uint32_t) (_Major)) << 16) | ((uint32_t) (_Minor) << 8) | ((uint32_t) (_Rev)))
-
 struct amdgpu_ip_block {
 	struct amdgpu_ip_block_status status;
 	const struct amdgpu_ip_block_version *version;
-- 
2.34.1

