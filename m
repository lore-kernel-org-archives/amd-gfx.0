Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EBB23EB8FAF
	for <amd-gfx@archiver.kernel.org>; Wed,  6 Sep 2023 03:57:30 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 54F1710E178;
	Wed,  6 Sep 2023 03:57:30 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2040.outbound.protection.outlook.com [40.107.236.40])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AEDA610E178
 for <amd-gfx@lists.freedesktop.org>; Wed,  6 Sep 2023 03:57:28 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=h0izdnQyCeg9Ghe+z4147BbUIR6KUx21YgxWN9adSiaqzRgg+bFwSyqKqhZGtp4HEMPinpfgo0Bxe03dH2N2btQ9usyiXvyLUQbhe57leqEeFMr4Kg9AFiw7IcMAgXKA9PSOUA4CK1wQb8aJpTbwp6Krw+ajNRp+VHcBjWygYNxeR6Jyep2JKCQiNk+BjN9z77zM+tGfW1eDFaEeN7h+QvqLGQyFNgLRi4WDna2YQk26xal2CNkmYqHjeKRox6Sj+iZ8q+LkbLmFDvhCX5fQCpRU8D7Ow8BBlKMuZ5uHChUS5M4U+z0v1NmYoD40x8Wgs/3bSbJHrMd7hAdGfcKvGg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CFhmKxNjVFa44vTZy+UvgAsXkQaaefIcVo23/HFCFm8=;
 b=Ut9+iJOgJZve+Y5Wsxk/UglxAWhwoMvctHz5wNamIr6AneM+Lwu4DCjPwJhJW4kqbItwcIWV2Qxn0q1yT81uZ49C8OokA2dB4kGkcRb7g132aVeb2DxQBYQe9kE91rKwvJjpBkGF2u2DjyZy31HERvEZFFMRnb0q26S7e0pwGxEPM31X2qlvcKiJ117aD2l9GRPIS3VCaxBsUk97ydK+3ZibfMqMcHOfhG3ImFMigFxwDzcoVwaO8485nR6BFHCgm0yPAXrYTw6BYR+EiLBkLmy1quvNBLigtZM17QmSos86hWGbzrU1gmuPcpeO3UELB1jQj0pZEvrmYcV75MDL3Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CFhmKxNjVFa44vTZy+UvgAsXkQaaefIcVo23/HFCFm8=;
 b=lfB0TFH6KPLMjUnMQE4FbmxjC7etJaJ6y/lcuRi/Mt5n+cnkhfAOeCd+PbHgV5BpWoqXOAiKua/axv5jaCDRijpzXnRQwMYL9qhraxcCzo52SY9konyMg52vOG02Hs01CiVehj0yv069xRCKKzynZJ5TXZFr5iKilvdToZpyjx0=
Received: from DM6PR05CA0064.namprd05.prod.outlook.com (2603:10b6:5:335::33)
 by CH0PR12MB8507.namprd12.prod.outlook.com (2603:10b6:610:189::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6745.33; Wed, 6 Sep
 2023 03:57:25 +0000
Received: from DS3PEPF000099DE.namprd04.prod.outlook.com
 (2603:10b6:5:335:cafe::6f) by DM6PR05CA0064.outlook.office365.com
 (2603:10b6:5:335::33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6768.26 via Frontend
 Transport; Wed, 6 Sep 2023 03:57:25 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS3PEPF000099DE.mail.protection.outlook.com (10.167.17.200) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6768.25 via Frontend Transport; Wed, 6 Sep 2023 03:57:24 +0000
Received: from mlse-blrlinux-ll.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Tue, 5 Sep
 2023 22:57:22 -0500
From: Lijo Lazar <lijo.lazar@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amdgpu: Fix refclk reporting for SMU v13.0.6
Date: Wed, 6 Sep 2023 09:26:47 +0530
Message-ID: <20230906035647.952389-1-lijo.lazar@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS3PEPF000099DE:EE_|CH0PR12MB8507:EE_
X-MS-Office365-Filtering-Correlation-Id: 4925ce53-d672-444a-1d53-08dbae8d6158
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 9a6g/1iISOdCNiH7KrVme2L+R2BmPDkDUuezP6ZBFEZOU8wkGEG4B4Ja0pvFygZFEFmHMEkYRTfwHZnxcvTm38jMFIawX0XjEUa1/K/+/oZtGhs4w97q3WYSdLELccGcl+NYNu0TI5/YTUBosXgyOFeWj6op42b/TkW256c5hU7XEjoxHaxhIvY66B/UPyfPdkYLy+6lqQHluSVmGs2EuxPKLahten9X3nN+hs2t9VLVUGSoHQMd1cMQ/c108dypasKHgvge8cvQzZCVnvk56SfcxqptOg6EYntMhRxFNISk/UoZWh+v3GmBFS+pBwVCLN2ufPjs5E7HA16KnL5Cj02GKreJYcbkrwkmdt9urLzfkwF7K0eXQ/OXZM/4bTuMxeawvyfAskvQxrwQ3sVd15cjPT1y7wz43GGzGh1PWuSOn2hkr/y4IjOSd07lXkQe7sme5II/HlA631o1v53KxmbYajgyLTI9bQ85H0WMhspOmU9AV1/ilwOa4zE8V20oBcF7WdwBnh8x+CwDk3qZUJ2BXFukOvhWS7lV+TOCpcjoAk6A/NQllaFQpjECjaYmSbj9TX2o+KdksvoIs8b+PhjXBph0gj2ijB/fA3HjIm/9lGJjwUVbECPwxlp31VWDOiaaTf43eQ9VIdaQuxYLknt28UblUo2vt4ng1kOH9Po5f4LU2aEQ1NKdO8jp3Exyh4jf1nwvXCCgpixEgFW7h+dJDZsITYo4xqbyUmGMjf3buVGOvmsOj2dbn0AlDRi3gij5iEW2gFvsxJqU39f7RQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(376002)(396003)(136003)(39860400002)(346002)(186009)(1800799009)(82310400011)(451199024)(36840700001)(46966006)(40470700004)(40460700003)(41300700001)(6666004)(7696005)(356005)(478600001)(82740400003)(81166007)(336012)(83380400001)(2616005)(16526019)(47076005)(36860700001)(26005)(1076003)(426003)(4744005)(70206006)(40480700001)(2906002)(36756003)(54906003)(6916009)(70586007)(316002)(86362001)(8936002)(5660300002)(44832011)(8676002)(4326008)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Sep 2023 03:57:24.8906 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4925ce53-d672-444a-1d53-08dbae8d6158
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS3PEPF000099DE.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR12MB8507
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
Cc: Alexander.Deucher@amd.com, Hawking.Zhang@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

SMU v13.0.6 SOCs have 100MHz reference clock.

Signed-off-by: Lijo Lazar <lijo.lazar@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/soc15.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/soc15.c b/drivers/gpu/drm/amd/amdgpu/soc15.c
index f5be40d7ba36..28094cd7d9c2 100644
--- a/drivers/gpu/drm/amd/amdgpu/soc15.c
+++ b/drivers/gpu/drm/amd/amdgpu/soc15.c
@@ -325,7 +325,8 @@ static u32 soc15_get_xclk(struct amdgpu_device *adev)
 	u32 reference_clock = adev->clock.spll.reference_freq;
 
 	if (adev->ip_versions[MP1_HWIP][0] == IP_VERSION(12, 0, 0) ||
-	    adev->ip_versions[MP1_HWIP][0] == IP_VERSION(12, 0, 1))
+	    adev->ip_versions[MP1_HWIP][0] == IP_VERSION(12, 0, 1) ||
+	    adev->ip_versions[MP1_HWIP][0] == IP_VERSION(13, 0, 6))
 		return 10000;
 	if (adev->ip_versions[MP1_HWIP][0] == IP_VERSION(10, 0, 0) ||
 	    adev->ip_versions[MP1_HWIP][0] == IP_VERSION(10, 0, 1))
-- 
2.25.1

