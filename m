Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 431FDEE49A0
	for <amd-gfx@archiver.kernel.org>; Wed, 23 Aug 2023 15:51:33 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2F3C310E444;
	Wed, 23 Aug 2023 15:51:32 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2052.outbound.protection.outlook.com [40.107.244.52])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B99A110E43E
 for <amd-gfx@lists.freedesktop.org>; Wed, 23 Aug 2023 15:51:16 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VfpaS1gjhOkVgbzJDkgeDJckwtNLLcdLpgw++UdgXGhEjk+hr5u17ZKpN1izWrBDmEULlCvBwwzZg9lbDNjpavA4mLvQG7tWF3jotI3VLt/58eXt9Pe3da9wSUpJXkeRHaPJldA9JUmt2mk28+X4ev+E/IkydsptTa90GUD4afGGrezzHTY74ZOD0PGl5oK7L4jVzZkK4MkzWxzCfHTnbXmMImEhRPwAOrP6noYvAe3ltlHpeWNqhi9zYA5BObMOVxQ9NbDfjpnqV9dC9oJAsKPSTuSJGTsEt/dFrNxH2waEm8t9GPRy174XMwSVir4EVJ5MUkxZGePlg9yENefqFw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JkJqKbXuKfmE91Ow+L6B/BeEqBJJzXzsJpIpJoHOGh4=;
 b=akW/e8YtIKC4lmIoAl6qZ3ihu41Tamt31Xv36zubkVStUx7VUrH0angtmnE3adbUtAP2VmJz8EU9BF6DExgdlj8nfzPpTOb20+tykKFBm95Eb3afcKkL3BstLM0bo7OZpMenzRktP8bFNFVoBx96xkfjLa/XKfbRgf1AjFxTT72sBOwjI0H++RiM9LRQlyZ+m5VYMQSJzy8orYOK+LL2iYe3V2YPQJlLd1+aitYUbTT9Hc20Mup9i+FufkafmnEA9WE4wIve0CByoCwZO9GgD4yZ3+wBVVSMImnjl9bumwk1yQ87GNjUsqgR3f/rK9eePxmsCs1W/krfzWInUuz+SQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JkJqKbXuKfmE91Ow+L6B/BeEqBJJzXzsJpIpJoHOGh4=;
 b=rKyIrtLfkMHcMgUMSC0CpJPyE7HPJkur5CpSl9yjwK5FbZwo1tMy69ZS9ZkzTfLVBhjBfOl7PqGIo3UNUiyGYyZoUeXLVbTkYdQmUtnzb4aeahqtkmv0xPUv0u5qy6/94DWigcKmu8GavSEw+9vNJ3XdXI6M6/IBrsHTG4XpcEw=
Received: from DM6PR21CA0018.namprd21.prod.outlook.com (2603:10b6:5:174::28)
 by DS0PR12MB9057.namprd12.prod.outlook.com (2603:10b6:8:c7::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.24; Wed, 23 Aug
 2023 15:51:15 +0000
Received: from CY4PEPF0000EE37.namprd05.prod.outlook.com
 (2603:10b6:5:174:cafe::4a) by DM6PR21CA0018.outlook.office365.com
 (2603:10b6:5:174::28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.10 via Frontend
 Transport; Wed, 23 Aug 2023 15:51:15 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000EE37.mail.protection.outlook.com (10.167.242.43) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6699.15 via Frontend Transport; Wed, 23 Aug 2023 15:51:14 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Wed, 23 Aug
 2023 10:51:11 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 13/35] drm/amd/display: Add DCN35 GPIO
Date: Wed, 23 Aug 2023 11:50:26 -0400
Message-ID: <20230823155048.2526343-13-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230823155048.2526343-1-alexander.deucher@amd.com>
References: <20230823155048.2526343-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE37:EE_|DS0PR12MB9057:EE_
X-MS-Office365-Filtering-Correlation-Id: 5af3107e-83e9-46c9-03a9-08dba3f0c84e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: taBmtpfxZlc9eieCG5zaVNXu+9tzW8n4hjLcLxizz/gm9CZm3xGGLexP8oCOee7ecPC32VvUzreA2rxN+rv3H29S+Y5TyJwmxGRfK1l0bAQURnRMU8AfJzxrq/Yea1XfeWHl5Rwhc30wcYYtXind10bA+oZ8G5hmDJS0HpHCdT/TpRuGfb0KvfPASY5zGN0IcWU9qmMZ5YVum3E2RcMfQx+4+V4Oha9QKdIGFQBENZwPiJP9CE2Mzy+FrRQrM4W9WV4h0ZMzcs8p+12vXo8Iu+756Bif1IdBxDmoB+snfmstm49oDo3zPAyWjrxHAGaJeGzkz50AFGrGi/D2d05oYVb6O/Km58GmrxEEmaziGCiI/EAWrEBNOb3XXYLbncJOGqNZ1IqrwQ57sOfmj08JdCG45UW2MhBtGAvl4dPkrjbT8HL/64LFanCFCXYtQVxFis7yMpInOuohTunDd2JGIgKjTYViZeNBnzlLY0SeSxRzEeRE80Bh9qyAZE83ghP7k/g0tI2ZViKbuNiwKIW8R8drZQchkJTDXzBxByDMc2zxd6y/NmaKyWnEFMqE6934LCHAUjsBYiTOTAMD5q7NGewFx57tUwL1k0M7W11f2zwkEROjrQW/EneUqt/P7RidwjZ/TzHFX6Fx84cgelt+T+wj9CD8B3K1EbfhEPdD9jVENm3RorcxREp72S+MOBG4ZsqTjVw/rm0o1p6/BkTzja77ZqVUsX4+1iuLU+zWP7DXxuqyVtLmdMArJAzfcMPO56112XvuXsRyfQgcXdLH2g==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(346002)(376002)(136003)(39860400002)(396003)(451199024)(186009)(82310400011)(1800799009)(46966006)(40470700004)(36840700001)(36756003)(86362001)(478600001)(40460700003)(40480700001)(2616005)(47076005)(8936002)(8676002)(36860700001)(16526019)(426003)(2906002)(4326008)(1076003)(336012)(26005)(5660300002)(70586007)(6666004)(316002)(356005)(82740400003)(54906003)(70206006)(6916009)(81166007)(41300700001)(7696005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Aug 2023 15:51:14.9997 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5af3107e-83e9-46c9-03a9-08dba3f0c84e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000EE37.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB9057
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
Cc: Alex Deucher <alexander.deucher@amd.com>,
 Qingqing Zhuo <Qingqing.Zhuo@amd.com>, Harry Wentland <Harry.Wentland@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Qingqing Zhuo <Qingqing.Zhuo@amd.com>

[Why & How]
Add DCN35 support in GPIO.

Signed-off-by: Qingqing Zhuo <Qingqing.Zhuo@amd.com>
Acked-by: Harry Wentland <Harry.Wentland@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/display/dc/gpio/hw_factory.c   | 1 +
 drivers/gpu/drm/amd/display/dc/gpio/hw_translate.c | 1 +
 2 files changed, 2 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/dc/gpio/hw_factory.c b/drivers/gpu/drm/amd/display/dc/gpio/hw_factory.c
index 0ceba8f57d57..279020535af7 100644
--- a/drivers/gpu/drm/amd/display/dc/gpio/hw_factory.c
+++ b/drivers/gpu/drm/amd/display/dc/gpio/hw_factory.c
@@ -109,6 +109,7 @@ bool dal_hw_factory_init(
 		return true;
 	case DCN_VERSION_3_2:
 	case DCN_VERSION_3_21:
+	case DCN_VERSION_3_5:
 		dal_hw_factory_dcn32_init(factory);
 		return true;
 	default:
diff --git a/drivers/gpu/drm/amd/display/dc/gpio/hw_translate.c b/drivers/gpu/drm/amd/display/dc/gpio/hw_translate.c
index 23b7ddefda11..d6b0a1af7d3e 100644
--- a/drivers/gpu/drm/amd/display/dc/gpio/hw_translate.c
+++ b/drivers/gpu/drm/amd/display/dc/gpio/hw_translate.c
@@ -110,6 +110,7 @@ bool dal_hw_translate_init(
 		return true;
 	case DCN_VERSION_3_2:
 	case DCN_VERSION_3_21:
+	case DCN_VERSION_3_5:
 		dal_hw_translate_dcn32_init(translate);
 		return true;
 	default:
-- 
2.41.0

