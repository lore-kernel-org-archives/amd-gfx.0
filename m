Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 114A2E7B5ED
	for <amd-gfx@archiver.kernel.org>; Wed,  4 Oct 2023 09:24:24 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 95F1410E357;
	Wed,  4 Oct 2023 09:24:23 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on20629.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7e88::629])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 998DB10E355
 for <amd-gfx@lists.freedesktop.org>; Wed,  4 Oct 2023 09:24:20 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RlF05oRjuPmx3OXvoIL3mmsoRYZkuD2SD6gKU7F958WX+crDropGoGPbzy9+SvCQGbHntaowetww5+knPlCuG+ORKA+BdpojVBuczC2vdBbqcfC3aXDuSu+yM2htHFHkvyp7ryQqfLWeI7oTbrwx/ond07UgFvDNbLDNAK6raveN/JVmzecGFFMINMLjfCziZ98KuwDej1cTG9jWaLWumqz47Kb6Q8+nhVQR4ZwodDZCa1iZQSgbT5Jf1FS37Cl1Ewxp9rkhLfKZDaY9HZC26O/QFDrBJYlEPh70+8fGqCaGt0DEweKjUrQipQFbg0lTT2qj7UPkBjIswOG3/zQFFA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NJWj2c4vGMG+ZYm0QJjXZ9SHnuKue1saF76aqQZKNhU=;
 b=IsaoGGTtvmRwt6ZId9dRCMPXja089FCVQOUA7QbC2AHY4xILbPA8yY5ta6ra9R5I747009QCbu8N3bG6zmbCCgDCQ/UQEskiDBjmk7GvKTdNMk97/MOKESYH8AJtUadfrAV+YyIHaMVZmcQP5Yxu6dUA8NkLjj/ql7tU71keMGh0ZMI1DYNbYR7w0g/tW6PHG+ym0ixbbEHX7ji5YGWxhdjKk14Z+BicIoaUC2UGbx4weF5E3S+6FT3e3RF6sLlvzq1criJFOFqnF9m9dnbrw2PbIYFWqn1+NIRfHFCeSL5a/LxKYTFsjkHJ2Ex1Y7g3C8X3FIaa40hgGJdAGqWrQA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NJWj2c4vGMG+ZYm0QJjXZ9SHnuKue1saF76aqQZKNhU=;
 b=Ip9LBEflgIpuH/B/nou/Id8dGaXGSWHrqICZFHy7CrvqoghC3WCz18E/FVB6A21YjKLq7MaiYLD1oA7czakciVxKBYRLl7GQfVyU4vrNCI6TIDa5PGK3MqbW8dF8GY/R+NBW10ShwNBNFTYHEuohGtzj+NFOr5I1SVlKcWP/PAY=
Received: from MN2PR06CA0003.namprd06.prod.outlook.com (2603:10b6:208:23d::8)
 by PH8PR12MB7351.namprd12.prod.outlook.com (2603:10b6:510:215::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.33; Wed, 4 Oct
 2023 09:24:16 +0000
Received: from BL6PEPF0001AB4E.namprd04.prod.outlook.com
 (2603:10b6:208:23d:cafe::1b) by MN2PR06CA0003.outlook.office365.com
 (2603:10b6:208:23d::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6863.25 via Frontend
 Transport; Wed, 4 Oct 2023 09:24:15 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 BL6PEPF0001AB4E.mail.protection.outlook.com (10.167.242.72) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6838.14 via Frontend Transport; Wed, 4 Oct 2023 09:24:15 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Wed, 4 Oct
 2023 04:24:15 -0500
Received: from tom-HP.amd.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.27 via Frontend
 Transport; Wed, 4 Oct 2023 04:24:09 -0500
From: Tom Chung <chiahsuan.chung@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 09/16] drm/amd/display: Don't use fsleep for PSR exit waits
Date: Wed, 4 Oct 2023 17:22:54 +0800
Message-ID: <20231004092301.2371458-10-chiahsuan.chung@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20231004092301.2371458-1-chiahsuan.chung@amd.com>
References: <20231004092301.2371458-1-chiahsuan.chung@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB4E:EE_|PH8PR12MB7351:EE_
X-MS-Office365-Filtering-Correlation-Id: af4944ad-e25b-4839-4832-08dbc4bbade4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: u2xt5v5AdrkYaYWCvE17UUAt8hCU64JyIRd1Upb0yPA38EFMPoLyzqs9H6WgEV6q3K37uCr/5FpddlzN/vXKozaU26WHrnmk+ZF3ZTheaSom56WAknRuTwJu02gnQa25R9zTweDznBlulTe4H9ZjknoCEit3fVaVx5mC3gUqauyCCfoOnSaN0zrpA/Ao/3TILK4XftUFkIDt1cQYva2TOYV58sbsjgTa1Wu8A63J6vwNj0GMS6fPfzvCU3rHEWSvYM4BIup7KK6gC1ARvjfadD1bQXLwbTopXJANv3PKP+LdYkPmxx6C4HpnEwuOCukLEXAifzRPW7i2N2CbcKY4zWAGzRSa7gdp4upYLaJB8Gk2f3IashsfFpN1EOXzftsZhlmYAg2TmtWsj7OPdteBkhTYWXqYC5iaiwyEd/5ZWLtUYQIGz0ksZZd2g02ihvv9kwkYaSviDOBleN3d+/Svu1byXUXg8p9ieaGr0Ru6374Vn5veAELrxBm+CpeBb3wgWZJKa65kLde+12mCfR6CmpjxQRM2igk2svvYLBD3uS1ICBfbYZH1uBtapS1INsBsPRGDPmGdjCWQW3IsEVT9KFwcpqYM5/XvZhSQrO9DZFD0kjkVN+tqCFU2uGiyNe6tnAESTuNara5xunNAIomAz/QA8F2Darb3/FT/2jREnHJACDteIZIO2NuVhFg9E7GIviojTNyu88k87PjBBMKhMyAHS5mg3s41vbIowyt2GKxxc5RXlIQofXy09RtuUMCri58f4JZJ/VZ9AL9IOXH+yQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(39860400002)(396003)(136003)(346002)(376002)(230922051799003)(186009)(1800799009)(451199024)(82310400011)(64100799003)(46966006)(40470700004)(36840700001)(81166007)(2616005)(82740400003)(6666004)(5660300002)(26005)(4326008)(8936002)(8676002)(478600001)(86362001)(47076005)(356005)(54906003)(70206006)(70586007)(40480700001)(1076003)(6916009)(36860700001)(316002)(426003)(7696005)(83380400001)(336012)(36756003)(40460700003)(2906002)(41300700001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Oct 2023 09:24:15.7935 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: af4944ad-e25b-4839-4832-08dbc4bbade4
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF0001AB4E.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB7351
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
Cc: stylon.wang@amd.com, Aric Cyr <aric.cyr@amd.com>, chiahsuan.chung@amd.com,
 Sunpeng.Li@amd.com, Harry.Wentland@amd.com, qingqing.zhuo@amd.com,
 Rodrigo.Siqueira@amd.com, roman.li@amd.com, solomon.chiu@amd.com,
 Aurabindo.Pillai@amd.com, wayne.lin@amd.com, Bhawanpreet.Lakha@amd.com,
 Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>, agustin.gutierrez@amd.com,
 pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>

[Why]
These functions can be called from high IRQ levels and the OS will hang
if it tries to use a usleep_highres or a msleep.

[How]
Replace the fsleep with a udelay.

Reviewed-by: Aric Cyr <aric.cyr@amd.com>
Acked-by: Tom Chung <chiahsuan.chung@amd.com>
Signed-off-by: Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dce/dce_dmcu.c | 3 ++-
 drivers/gpu/drm/amd/display/dc/dce/dmub_psr.c | 3 ++-
 2 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dce/dce_dmcu.c b/drivers/gpu/drm/amd/display/dc/dce/dce_dmcu.c
index b87bfecb7755..a8e79104b684 100644
--- a/drivers/gpu/drm/amd/display/dc/dce/dce_dmcu.c
+++ b/drivers/gpu/drm/amd/display/dc/dce/dce_dmcu.c
@@ -586,7 +586,8 @@ static void dcn10_dmcu_set_psr_enable(struct dmcu *dmcu, bool enable, bool wait)
 				if (state == PSR_STATE0)
 					break;
 			}
-			fsleep(500);
+			/* must *not* be fsleep - this can be called from high irq levels */
+			udelay(500);
 		}
 
 		/* assert if max retry hit */
diff --git a/drivers/gpu/drm/amd/display/dc/dce/dmub_psr.c b/drivers/gpu/drm/amd/display/dc/dce/dmub_psr.c
index f27cc8f9d0aa..9d4170a356a2 100644
--- a/drivers/gpu/drm/amd/display/dc/dce/dmub_psr.c
+++ b/drivers/gpu/drm/amd/display/dc/dce/dmub_psr.c
@@ -217,7 +217,8 @@ static void dmub_psr_enable(struct dmub_psr *dmub, bool enable, bool wait, uint8
 					break;
 			}
 
-			fsleep(500);
+			/* must *not* be fsleep - this can be called from high irq levels */
+			udelay(500);
 		}
 
 		/* assert if max retry hit */
-- 
2.25.1

