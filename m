Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B2C1BC433FE
	for <amd-gfx@archiver.kernel.org>; Tue, 17 May 2022 02:06:57 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A409410E283;
	Tue, 17 May 2022 02:06:55 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2073.outbound.protection.outlook.com [40.107.243.73])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7C31710E108
 for <amd-gfx@lists.freedesktop.org>; Tue, 17 May 2022 02:06:50 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Cz9HaORNTyMB4JmwKbh4B2DLxKC1sd6Rc85h13H4jfyXOOq8bl5cN5PkgLtsaYvRYrf5cMpjiDb+imGypeAGAswSj12Hwfl9Ym5Ngj36ify1EaK684p0FgJdSYWDtCWrYkiOMYYbhsJpttxohc5LsfEVL28jqQMiLqCtN9G8RhoWqCoxis6xmtS2hI1WisjgYNXOYPHECS7YqwK677/OYupm4hrTRoC/16wonJg/R/eLrJmV+SJWOYIRrjUySYzEFbg5iCDnavDXFyIEmcg4ShWi2J79/ku9grx7k/jCITO7dw9hF7h6Rk+E/yPenDkMg+kgBbqDO2NUbEoeHZvG6w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=osQ+TjjLnTF/SAixKVoFKVg7qOgXH6VYZzffprSiu90=;
 b=LiYSEuDtITTIGw7fj14BGyruDqqvHiERsov1E+5YL2p5OeV2DpDwRFzoORSAcE3Zx6LLopGjGjx2hyvYeWfB8dNBupVjn/pQ27k5lLA66SqdrqxPqBzosiCJQZX6LkKkz1fkS4PdnmS1i9vOV2H3LsD+v8/m+atNHYxJ/e+7KSvffxx97XE+yH4TaNDqsrCuwLNb3WFXb4SRvpYqh0piOJZgwcTe4rAmuDWFjToUGSsT9DikT6L/D6wxbBPCjxBQHD4st/BgGN6T6st6zMSNajtmsLFM/eHQtu+i9/FXZn0Ji1T3xS3KvpR5eNEKTDhb4RerNTvV/0s8/z4dUVzfUw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=osQ+TjjLnTF/SAixKVoFKVg7qOgXH6VYZzffprSiu90=;
 b=WaASzEhlD7zLRiJ4LCCCYqR9R5iirUjb2X8qE7Ftmqao2NG5tXdSGxUxiF7voPEjwRnxlqbEDXkyNE4lLu+t8M6s+xE5DypvBVG6KWXej4DTf4xVUZOXInfINqQxVO+YVauImFKdeoK/cB24cFHLpjTyRMiymXQhfiSBPvSs0mw=
Received: from MW4P221CA0015.NAMP221.PROD.OUTLOOK.COM (2603:10b6:303:8b::20)
 by BY5PR12MB3794.namprd12.prod.outlook.com (2603:10b6:a03:1aa::28) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5250.18; Tue, 17 May
 2022 02:06:48 +0000
Received: from CO1NAM11FT024.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:8b:cafe::72) by MW4P221CA0015.outlook.office365.com
 (2603:10b6:303:8b::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5250.14 via Frontend
 Transport; Tue, 17 May 2022 02:06:48 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT024.mail.protection.outlook.com (10.13.174.162) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5250.13 via Frontend Transport; Tue, 17 May 2022 02:06:47 +0000
Received: from equan-buildpc.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Mon, 16 May
 2022 21:06:45 -0500
From: Evan Quan <evan.quan@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 2/6] drm/amd/pm: skip dpm disablement on suspend for SMU 13.0.0
Date: Tue, 17 May 2022 10:05:58 +0800
Message-ID: <20220517020602.160108-2-evan.quan@amd.com>
X-Mailer: git-send-email 2.29.0
In-Reply-To: <20220517020602.160108-1-evan.quan@amd.com>
References: <20220517020602.160108-1-evan.quan@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 98675bfa-8f61-46b7-71c3-08da37a9e631
X-MS-TrafficTypeDiagnostic: BY5PR12MB3794:EE_
X-Microsoft-Antispam-PRVS: <BY5PR12MB3794B31A9F86179E00BD0F58E4CE9@BY5PR12MB3794.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: lFxkZkqFpz3m1X+IZWhWuFbfLFUMNU0VFhx8VkZN2TfPp+/3O39sdugbcLx1oVj/50j4bwSokExppXI9tGeoLhRaMkQldeJrJGt2iA4KCa9c3ecJixZoJoXAxIFgSnoWAEBfYFbdwZmy/GlG1Mp6FuIrufanfxkfKWAPdxSEsyBerrUpS+IxfI20L47JnGPSm/DMDUFKLLjBuHpwVe5oe+gUs+ll9sekQh3AFHlpdxMX81tRs8ONLieXBlx6zrDSRo8kCu04HKlngnN/EW6iq4SeFVFeWIUxuczDLO+EF2x9R1NwATxOWtnVvza4u8VaidlUCTzZAZh/Yd13adDoqLjorcO0MTeZu1GwLTQRt4vuiebEQFXXi6k7glYQWNLUoWiuJWsdi2gcX4ilYJ0173fzzojjrJkvmhpmFHv3KYJXmY1qVkn9UlZwj3v0QRciIFYqesQPv9eGHQvqm97qgecEHd45g9XXXvKsZb+4TnYBg97cJ26ZzeLAEtCUPMndsAqNgQwqq1FqgjPwHRmtG2dLYQ0VmIDI9ugpKdrd6fRzG7zp7DrEUke/t0JiRygXLwd4822wmcdwx1YcMgGrnYe3flZR92koUOE6ftLQoP06ZismH2BW+nANcnRZxiKC2MruJukXU4VQB5D4JoFyP5FSYsDpTwGGrXZkVVIQ0oKWPHliDR7aHxTlkGPNNYT4+jp8jbde2NhfEJklMpmewg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(36840700001)(46966006)(40470700004)(186003)(16526019)(356005)(2616005)(47076005)(1076003)(336012)(426003)(26005)(4326008)(40460700003)(5660300002)(2906002)(44832011)(4744005)(82310400005)(8936002)(6666004)(36756003)(54906003)(86362001)(6916009)(7696005)(8676002)(36860700001)(81166007)(70206006)(70586007)(316002)(508600001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 May 2022 02:06:47.4534 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 98675bfa-8f61-46b7-71c3-08da37a9e631
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT024.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB3794
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
Cc: Alexander.Deucher@amd.com, Evan Quan <evan.quan@amd.com>,
 Hawking Zhang <Hawking.Zhang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Since PMFW will handle this properly. Driver involvement is
unnecessary.

Signed-off-by: Evan Quan <evan.quan@amd.com>
Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>
Change-Id: I19be26eed090d57040553f5cdff9534072f08106
---
 drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
index 6016b325b6b5..a601024ba4de 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
@@ -1436,6 +1436,7 @@ static int smu_disable_dpms(struct smu_context *smu)
 		case IP_VERSION(11, 0, 0):
 		case IP_VERSION(11, 0, 5):
 		case IP_VERSION(11, 0, 9):
+		case IP_VERSION(13, 0, 0):
 			return 0;
 		default:
 			break;
-- 
2.29.0

