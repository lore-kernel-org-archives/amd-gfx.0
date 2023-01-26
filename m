Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6368AC27C76
	for <amd-gfx@archiver.kernel.org>; Thu, 26 Jan 2023 00:37:11 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EAE4110E8CC;
	Thu, 26 Jan 2023 00:37:10 +0000 (UTC)
Received: from NAM02-DM3-obe.outbound.protection.outlook.com
 (mail-dm3nam02on2060.outbound.protection.outlook.com [40.107.95.60])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BF41A10E8CC
 for <amd-gfx@lists.freedesktop.org>; Thu, 26 Jan 2023 00:37:08 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Rw8GZULD4R62DDiUTERe0lyKPE6dkGVGLjqnK7Mv50ctbJVb6dokAUl87djXT0RyuVFxXHgz32OUz59+pGFJNvcDClurewGqJVFvLkn8VtGfaebYt7mei71idvJNlfVxBPRnJmdEm1c1RzMB0GEL7aflfWxgGECljuPbryrEjEz4qg046vqJGFZO+v3+KAERBfqEYxR+5lGZp/bf2TOwCFEf3aNuxwcUGgQHPiVLwN4ciUrHciPkMo+nbW7BuxCMbBOs/6n5qCWbMTANmpMraoPqGhJiKrTT/HVYwYwXrw332UAC53VAOs2A8DUIjA1e8zLf4xl9Hx+zAsEx3yUsBg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wjDkmh/5XM/G3JYk1vX3/QCPYLNx1xrLweUQmPJGyRw=;
 b=Fac24zXkTtMtucMKoWiZn7WXHO+VBZ8DCLkcQXU+FOGsTaPX0q6lpmLkUOju8J/TftxRoUhxcbUOUiLBJxXjf28sB6zstOt5acyMMJOE99yMGkzclClA1ZMG37/87/KaF8iMHpCwsz6WCrjqR3V72I//EsKXwfSP2s6PUktuny7pdZtK/ST2f3qvqBQZTMnAeY+fAfBjaNLeO3XQ0UZPlgbOW+PgTpIaekrPEz6QSTSI/eYv4KgLhYuvVMlwaV+DI1GZA4jP5TTmh2LDQTeXA/R0wBfZ5IKZhL9GxcxhMlQXBH2NrS5+MlHECQUF9qBr8C3SLUv6yt2ATtEwQtGw7w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wjDkmh/5XM/G3JYk1vX3/QCPYLNx1xrLweUQmPJGyRw=;
 b=2FSFXYb+axqpLdFPPfM9TJlSSCB+BTk2/VZVh9NI6uKgX6MKrq9IY5dEzca/9IbQP1+jsSwha0w95vrObKY6TWh62Ui5oZt9r7n2wuYDwAxVGTFr5wI3YB7tEQR0/PkVDho1MOt+NWEVSilHvAUDOReybGSdOzz+wA+ivYJY5cw=
Received: from BN9PR03CA0113.namprd03.prod.outlook.com (2603:10b6:408:fd::28)
 by PH8PR12MB7447.namprd12.prod.outlook.com (2603:10b6:510:215::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6002.33; Thu, 26 Jan
 2023 00:37:06 +0000
Received: from BN8NAM11FT086.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:fd:cafe::59) by BN9PR03CA0113.outlook.office365.com
 (2603:10b6:408:fd::28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6043.20 via Frontend
 Transport; Thu, 26 Jan 2023 00:37:06 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT086.mail.protection.outlook.com (10.13.176.220) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6043.17 via Frontend Transport; Thu, 26 Jan 2023 00:37:05 +0000
Received: from dev.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Wed, 25 Jan
 2023 18:37:03 -0600
From: Alex Hung <alex.hung@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 16/16] drm/amd/display: 3.2.221
Date: Wed, 25 Jan 2023 17:32:30 -0700
Message-ID: <20230126003230.4178466-17-alex.hung@amd.com>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230126003230.4178466-1-alex.hung@amd.com>
References: <20230126003230.4178466-1-alex.hung@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT086:EE_|PH8PR12MB7447:EE_
X-MS-Office365-Filtering-Correlation-Id: f1449ca8-10e5-4ea8-c83b-08daff357309
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: CZmg0Vxco3UH2+BBFhOvMI6pjqCMvJi+d//0/GiBqsZevOLSr8/OWHVNLIEI8tHawWlVbEsMZ5BYyb6YTAMaLv0ZFGwT7DXqKYK+T4mvwYIkU6jhQkvhEple+L/cfat6iD1oE+E40lN+Uj8wfs065avvq5n2N3gF2wxOFmgG4TBLvOa3HstSwpke93animswmFlk9bHOKRCJLyon3mKyBLINi4y9XDL98ORG5GhcdrkEp7TW2WMSWh5swcD3ouK4f3bW2onQYiNg3alrE18RNy/A5GAgXBX3nStmanio2qYj9MBzmNshaiQOlevP3+aETh2pPQblacFsqlZqxodry3rCHNGKzn7g0xAmC1/Ko0YeorEz60f7YkJVJ+NRb4Lvq1NnosiNFuhI6AlVu6vFWRq1toYM31fzxBNSa2IHmLta6ooQn/wXT/2nAUh/qT2iS27j5bhoj9Cjh+Nm8+RQgmaUx+t1hjj+3/8Nf85AMOZX5a3v328Jh+LPauIRuCq5EdnlrYP0QWho4N1h4jRvLtCOzkhyWyvM1lRP6ki03dwCt7xifV6vahuNx5JojsR8kFCY/n0NQvgPdhk85qoFOtrj57mKfgPvgwWfUrpgMLHGO5LX89Pz1VcAVe8MdaU+zlO/270jMXZX2lMEkX4K8urvJWMiVmXE8oy2RMdME0yggvtBVRN+J/VI5ChL+PIzKqHI15cvFuV4TzCNBtvyIeohueyavrfcZTIB30SMCqg=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230025)(4636009)(136003)(346002)(396003)(39860400002)(376002)(451199018)(40470700004)(36840700001)(46966006)(5660300002)(47076005)(70206006)(426003)(4326008)(70586007)(6916009)(36756003)(8676002)(1076003)(336012)(316002)(2616005)(54906003)(86362001)(82740400003)(36860700001)(8936002)(40480700001)(40460700003)(82310400005)(83380400001)(6666004)(41300700001)(81166007)(26005)(478600001)(44832011)(186003)(356005)(16526019)(7696005)(2906002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jan 2023 00:37:05.4248 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f1449ca8-10e5-4ea8-c83b-08daff357309
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT086.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB7447
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
Cc: stylon.wang@amd.com, Aric Cyr <aric.cyr@amd.com>, Sunpeng.Li@amd.com,
 Harry.Wentland@amd.com, qingqing.zhuo@amd.com, Rodrigo.Siqueira@amd.com,
 roman.li@amd.com, solomon.chiu@amd.com, Aurabindo.Pillai@amd.com,
 Alex Hung <alex.hung@amd.com>, wayne.lin@amd.com, Bhawanpreet.Lakha@amd.com,
 agustin.gutierrez@amd.com, pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Aric Cyr <aric.cyr@amd.com>

This version brings along following fixes:
- fix linux dp link lost handled only one time
- Reset DMUB mailbox SW state after HW reset
- Unassign does_plane_fit_in_mall function from dcn3.2
- Add Function delaration in dc_link
- Fix crash when connecting 2 displays with video playback
- Adjust downscaling limits for dcn314
- fix FCLK pstate change underflow
- Fix only one ABM pipe enabled under ODM combined case
- Add missing brackets in calculation
- Correct bw_params population
- Fix Z8 support configurations
- Add Debug Log for MST and PCON
- fix MALL size hardcoded for DCN321
- add rc_params_override option in dc_dsc_config
- Enable Freesync over PCon

Acked-by: Alex Hung <alex.hung@amd.com>
Signed-off-by: Aric Cyr <aric.cyr@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dc.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dc.h b/drivers/gpu/drm/amd/display/dc/dc.h
index 42ce45306483..2e23fd8b4e9f 100644
--- a/drivers/gpu/drm/amd/display/dc/dc.h
+++ b/drivers/gpu/drm/amd/display/dc/dc.h
@@ -47,7 +47,7 @@ struct aux_payload;
 struct set_config_cmd_payload;
 struct dmub_notification;
 
-#define DC_VER "3.2.220"
+#define DC_VER "3.2.221"
 
 #define MAX_SURFACES 3
 #define MAX_PLANES 6
-- 
2.39.1

