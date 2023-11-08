Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D9CFDC4167D
	for <amd-gfx@archiver.kernel.org>; Wed,  8 Nov 2023 19:11:15 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2D48110E834;
	Wed,  8 Nov 2023 19:11:15 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on20608.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7eaa::608])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CF48110E86A
 for <amd-gfx@lists.freedesktop.org>; Wed,  8 Nov 2023 19:10:34 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=R9wi45l75OaDdq4NjtQ9Tv0R/cWyY1UlHgfFv7hicx5FXsnr+KCube5HeaHlztcIplfdmsa0tiWPH271HPR+LOwtaVUHO6uYtYaotklXy4mUash1ZviQFSL9AXXKewjuM0f/LrF2GLcRv2EZq3jWrAaaIWSKBiBjAItJra/+WLNZqWQkKpqSWXk5Zz+WTPy63evsSCoSiqoNiHqjIUC1eJXorarMCRYL3doIQ94Z8frsDvs1s0V1nY7XX/ptdm0gPFjmR380p2nG2cFXQk0+jiU5TX5/skEO+nDcrkUJuzjlVTzlanvebjZKgPDaoJJFTR9LsWPGhJSBShbv9ccIxg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=u9ehwIQQ7UNS7OfvRoNSaKJpNsnn/EAN8MnYlf/g8Sg=;
 b=U0KmzObV0pA6k/MQaqL1mZDGqovkLSO4XmMTnd4Tb3LKj1mc6N60EAtkE4oTUXELbhj9TOz+N+7KXt+FJrkpl4p50IMBWpgtaYWPuEXr1hjvgke4XY63RK1kms/ToX2s8Qv72oMA4a0UpTcAqo6NramF4PUBHV6OfdwdbNccoutEpszsFV6SJAALthBQOMPDxjidLuc8jD7zs96p6izuPCG99jEbgO5lx5vTOq7IwaDEXMTIRnVkNz5UEdQr1KDIG00yXQ2ViZvVkKcZ0VagMQkdrSRiLvnMWLMRLzgUF3Z44cm+n3pBtHtVZxypVL2neqyyLK/fzVKtb7mq6P5MMg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=u9ehwIQQ7UNS7OfvRoNSaKJpNsnn/EAN8MnYlf/g8Sg=;
 b=KhomcQNvRVFRMYTgY2U8EdUNXNKH/32L9P/vdYn0AXRC8UHnG0PgKcGRusGKwIxnlQ7ZYG91+vf0UApHxTG62DVFSbYCl/99HHOf4Wc/nbkex0sbhMUTEiq1cmUPtqAICz1WqndIXHgMTHPev5oWP+MunjGRnmooRELICLCtRls=
Received: from BLAP220CA0026.NAMP220.PROD.OUTLOOK.COM (2603:10b6:208:32c::31)
 by MN0PR12MB5977.namprd12.prod.outlook.com (2603:10b6:208:37c::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6977.19; Wed, 8 Nov
 2023 19:10:32 +0000
Received: from BL02EPF0001A0FC.namprd03.prod.outlook.com
 (2603:10b6:208:32c:cafe::a7) by BLAP220CA0026.outlook.office365.com
 (2603:10b6:208:32c::31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6977.18 via Frontend
 Transport; Wed, 8 Nov 2023 19:10:32 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL02EPF0001A0FC.mail.protection.outlook.com (10.167.242.103) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6977.16 via Frontend Transport; Wed, 8 Nov 2023 19:10:30 +0000
Received: from dev.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.32; Wed, 8 Nov
 2023 13:10:27 -0600
From: Alex Hung <alex.hung@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 17/20] drm/amd/display: Send PQ bit in AMD VSIF
Date: Wed, 8 Nov 2023 11:44:32 -0700
Message-ID: <20231108185501.45359-18-alex.hung@amd.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231108185501.45359-1-alex.hung@amd.com>
References: <20231108185501.45359-1-alex.hung@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF0001A0FC:EE_|MN0PR12MB5977:EE_
X-MS-Office365-Filtering-Correlation-Id: 21afb2bd-f41b-4308-ac05-08dbe08e6044
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: TJJ4hcM6U+6en0T4c5ROEG6XIhBmqG+vAVqX/yzr6+HLiBcj3VpY9RezHUbLcoy+U1q1E7uE1XsWxwTuIvlmwGa9xlygyVMbQtGMK+YUP9T+ZDLyYzIr6bFB4R9JMl0lo+6DgZu2zGoZeTNIpI+SV3QIMx/YcKbvN1ZKvmA5Jw3V82ARcKJnFIEPwQjdNp+p6Dk2m9MbrqxBX+opSLNVqpG227dmp/MqiftANBuZn9nZwCgMKHK6o4xhqPfQ+09wppi57dV5BcT+1AL6qjx/v/BmfEViacTKylfqenJwW5ethLY7qDf1kDsU7uPGsD4UC5uGL5fEPjmBFNfvggpiPc0CQYn0JhNODPOMf0P/BVUSxcCcZrWt5C2MQWYqmkldamymoEjb7ec4v7u4xFOk4b7M/juZN+fTmVFdDqrGEZDwEUtdD5mYFz47shqQjjvK0T6dl8JBj/2oOGcQyZLxpnYgRy0cL4jO5WcnwatjUK4HerhISqJD3k9k0T99mqJ8Cl3CsV2yU8Lo3TkM/+ZPhh3/nrjbDgg7DTBxVRqxwMHzsiiFx7LDy6D8DyJeLa5b00LXqzkpT6GjMvN9uDtlt27YmP2ue13mC11bCE5cNCJdEsxir7wEW0RHpFRNkxDxmb2/qbq2onbvOh1Hcgsv72LU3uAKu87N6+v+ZQ4KR7xHot+7j0vKHT3z1zpgqIsecWJAESbiZc5vaQxMgTASc+1+hxzSjKmx4NdIHCc8am+RU1higyk+XiOB+B7Ow53BfaS5S4l9VyBW7StOjKK9tw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:ErrorRetry; CAT:NONE;
 SFS:(13230031)(4636009)(396003)(136003)(39860400002)(346002)(376002)(230922051799003)(1800799009)(186009)(451199024)(64100799003)(82310400011)(36840700001)(40470700004)(46966006)(40460700003)(4326008)(26005)(8676002)(16526019)(8936002)(2616005)(1076003)(336012)(426003)(54906003)(83380400001)(70586007)(70206006)(316002)(6916009)(7696005)(36860700001)(5660300002)(478600001)(2906002)(86362001)(41300700001)(81166007)(6666004)(356005)(82740400003)(36756003)(44832011)(40480700001)(47076005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Nov 2023 19:10:30.7679 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 21afb2bd-f41b-4308-ac05-08dbe08e6044
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF0001A0FC.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB5977
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
Cc: stylon.wang@amd.com, Aric Cyr <aric.cyr@amd.com>,
 Krunoslav Kovac <krunoslav.kovac@amd.com>, chiahsuan.chung@amd.com,
 Sunpeng.Li@amd.com, Rodrigo.Siqueira@amd.com, roman.li@amd.com, Alex
 Hung <alex.hung@amd.com>, jerry.zuo@amd.com, Aurabindo.Pillai@amd.com,
 hersenxs.wu@amd.com, wayne.lin@amd.com, Harry.Wentland@amd.com,
 agustin.gutierrez@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Krunoslav Kovac <krunoslav.kovac@amd.com>

[WHY & HOW]
PB9 bit 5 was added to signal PQ EOTF in AMD vendor specific infoframe.
This change sets it when appropriate.

Reviewed-by: Aric Cyr <aric.cyr@amd.com>
Acked-by: Alex Hung <alex.hung@amd.com>
Signed-off-by: Krunoslav Kovac <krunoslav.kovac@amd.com>
---
 drivers/gpu/drm/amd/display/modules/freesync/freesync.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/modules/freesync/freesync.c b/drivers/gpu/drm/amd/display/modules/freesync/freesync.c
index ccecddafeb05..47296d155c3a 100644
--- a/drivers/gpu/drm/amd/display/modules/freesync/freesync.c
+++ b/drivers/gpu/drm/amd/display/modules/freesync/freesync.c
@@ -693,10 +693,12 @@ static void build_vrr_infopacket_fs2_data(enum color_transfer_func app_tf,
 	if (app_tf != TRANSFER_FUNC_UNKNOWN) {
 		infopacket->valid = true;
 
-		if (app_tf != TRANSFER_FUNC_PQ2084) {
+		if (app_tf == TRANSFER_FUNC_PQ2084)
+			infopacket->sb[9] |= 0x20; // PB9 = [Bit 5 = PQ EOTF Active]
+		else {
 			infopacket->sb[6] |= 0x08;  // PB6 = [Bit 3 = Native Color Active]
 			if (app_tf == TRANSFER_FUNC_GAMMA_22)
-				infopacket->sb[9] |= 0x04;  // PB6 = [Bit 2 = Gamma 2.2 EOTF Active]
+				infopacket->sb[9] |= 0x04;  // PB9 = [Bit 2 = Gamma 2.2 EOTF Active]
 		}
 	}
 }
-- 
2.42.0

