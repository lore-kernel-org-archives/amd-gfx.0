Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4A674C4332F
	for <amd-gfx@archiver.kernel.org>; Wed,  8 Nov 2023 19:12:48 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9ACC410E194;
	Wed,  8 Nov 2023 19:12:47 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2085.outbound.protection.outlook.com [40.107.244.85])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E9C9810E194
 for <amd-gfx@lists.freedesktop.org>; Wed,  8 Nov 2023 19:12:34 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dNHf88V76nE7TLqESt5ofwP16+G9DLYkykMON0rahoDVa1zu619YbXo79r3uB3wnW1Ia/unNPrUlGD2X71iI4nqtpnKfCisSE+a/V8mUOKVvYizpK/YqYea8aLJHMsqA0x7WhZBkHaXZKtZa5vL7JKE3uZalsfDM0lMfDdOOASjqJis+ef+CZ681WwaC/xW2ZMAcPkOdJH0D24BgJbZFJGByY9WFB0ULCPyaamswNDzNu8baxQ2ikaIfIh/SLKgIRDUT+elH63gLOzcq/049aZm8RBfDQHNhU+EImm5Qhg4gV96+qIpBijXXYOEEMbMGgcvaK5kMAn2xNFUmSPcAEQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zWiWFhQim9lzBfoel1hgySN+HjqX+QnUegrsv4gX/hY=;
 b=B5BL9vQChqgT5ShMM2LPJi3USdMxL0SIv42BjWthkEgemj5DndPbU9Kap+dKhRTdwRxJrbmQEXCyup/Zm2OrnI45pq1npuAWczOteYptpuo8lNyQx4jfj68cSY4hOHtV18jo8ZaAsjbWpNqvNoZ+pqi0lPT+rSlq7hfz2HvTUDr02lfQk3EP5k6dUhSLuGBXWvfc0n/mAlTsc0t8Dap/VHlNxD8Y0fFk5SGRkt8CGKbjJ3aYH4yGQwGM4cvUD/nKWPyJ5qMl1+6q4bT6fE+Z+HQDcmXraMLTETlrs+nSdncr/w57/odKKKM8xvnGodtJUiIyLb03EuLfG7waJ1m5kQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zWiWFhQim9lzBfoel1hgySN+HjqX+QnUegrsv4gX/hY=;
 b=xtO28cvTpyD7AliX3MRsZbIxxQnlhwqXDPk3vjckWtDJtPM3z1iNDp3KO397VpA85I0NohgIDBNofPaaQDSD6EpMXvichhzVkgvDCUbH/+JxhP3GXF9rlboxrGCDgIXBkqlg0a6i2USNvOLcMHU7VX+1AJimDLqz7vj8bV2V5SE=
Received: from BLAPR03CA0076.namprd03.prod.outlook.com (2603:10b6:208:329::21)
 by BL1PR12MB5253.namprd12.prod.outlook.com (2603:10b6:208:30b::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6977.18; Wed, 8 Nov
 2023 19:12:32 +0000
Received: from BL02EPF0001A0FC.namprd03.prod.outlook.com
 (2603:10b6:208:329:cafe::70) by BLAPR03CA0076.outlook.office365.com
 (2603:10b6:208:329::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6977.18 via Frontend
 Transport; Wed, 8 Nov 2023 19:12:32 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL02EPF0001A0FC.mail.protection.outlook.com (10.167.242.103) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6977.16 via Frontend Transport; Wed, 8 Nov 2023 19:12:32 +0000
Received: from dev.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.32; Wed, 8 Nov
 2023 13:12:03 -0600
From: Alex Hung <alex.hung@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 19/20] drm/amd/display: Add missing chips for HDCP
Date: Wed, 8 Nov 2023 11:44:34 -0700
Message-ID: <20231108185501.45359-20-alex.hung@amd.com>
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
X-MS-TrafficTypeDiagnostic: BL02EPF0001A0FC:EE_|BL1PR12MB5253:EE_
X-MS-Office365-Filtering-Correlation-Id: 9be14d00-0259-4197-9e66-08dbe08ea88c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: LSymdB0CVvWpMEop8mOA/z7Yze3dZKi5TuqVDbZH/mSkh/IHdrwRdrypE3uCOnJtrDlfhBrJb8sKzoyzzjAiEwSC4jcb/plk1a+FnYjYyvFEgKkhKATsnMy1Jh+nppVIiEa2NoKAkeUQVIVHkTTVTxXLWbmpwJI/JnEsA8fLJUXnxPoJtms3RHyfmYLfZRO5kuzeH6Z+MAEhc+/ppsHOApuj4SGd7CzomzrWM12QQ38xb+gV9qdCywmnnJG0crzCuPZ5MV898bRue73p5hd5nXtwGztq+8v7VyKDHzB5x3meLKLDu+sFFLJrzjaIV3RJ9gOoIlFluvnyzM/HNbo2PXgsXLWKM6L2BdFz8h4SL19b8ljC3A0Wo4b9uuMC7JvbDXefKnyz4BOzAH62KFZXe0Z8OzYMLZqtD4c9kldQZ/3sc8mOBNPKBoyZs6AQtabtxIqCEe5fhagRFiTfVW3FFtmWBdqqTCZiyTkoTcuJuoFWzMNR0cvr8c1nWX8LZySi1yxAgK9G+CLD1bCCZ+zooSjhat+XGUJgWvPoiYTXISAyGxhDNpQswGgmRvKwKd9BQd0cSKGeTxxC4J6cx4I197j8s1fuwD47+uXoQ4tgJSE504KsUUcfoN5in9+m2ufJ+2iAaDBqwZ6snojLfe8Td/86pVuvO4oAUMyHVlhSSn7eCENn103fBoLnVLbAtUkdSZLtvLvaArch4LMOk8s/XLXFkiz8o4gTwCRGdoFWz3+0i7U9nVECNfEnYCvx7UKqPmtl/4SR/yD5syODz3lYMQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(396003)(346002)(136003)(39860400002)(376002)(230922051799003)(82310400011)(451199024)(1800799009)(186009)(64100799003)(36840700001)(46966006)(40470700004)(2906002)(426003)(336012)(5660300002)(40480700001)(2616005)(1076003)(40460700003)(16526019)(26005)(36860700001)(47076005)(81166007)(36756003)(86362001)(356005)(82740400003)(83380400001)(4326008)(8676002)(8936002)(54906003)(316002)(478600001)(4744005)(70206006)(6666004)(70586007)(6916009)(41300700001)(44832011)(7696005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Nov 2023 19:12:32.0354 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9be14d00-0259-4197-9e66-08dbe08ea88c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF0001A0FC.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5253
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
Cc: stylon.wang@amd.com, chiahsuan.chung@amd.com, Sunpeng.Li@amd.com,
 Rodrigo.Siqueira@amd.com, roman.li@amd.com, Alex
 Hung <alex.hung@amd.com>, jerry.zuo@amd.com, Aurabindo.Pillai@amd.com,
 hersenxs.wu@amd.com, wayne.lin@amd.com, Harry.Wentland@amd.com,
 agustin.gutierrez@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>

[WHAT]
Add missing HDCP ID in the message id enum.

Acked-by: Alex Hung <alex.hung@amd.com>
Signed-off-by: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
---
 drivers/gpu/drm/amd/display/include/hdcp_msg_types.h | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/include/hdcp_msg_types.h b/drivers/gpu/drm/amd/display/include/hdcp_msg_types.h
index 42229b4effdc..eced9ad91f1d 100644
--- a/drivers/gpu/drm/amd/display/include/hdcp_msg_types.h
+++ b/drivers/gpu/drm/amd/display/include/hdcp_msg_types.h
@@ -69,6 +69,11 @@ enum hdcp_message_id {
 	HDCP_MESSAGE_ID_READ_RXSTATUS,
 	HDCP_MESSAGE_ID_WRITE_CONTENT_STREAM_TYPE,
 
+	/* PS175 chip */
+
+	HDCP_MESSAGE_ID_WRITE_PS175_CMD,
+	HDCP_MESSAGE_ID_READ_PS175_RSP,
+
 	HDCP_MESSAGE_ID_MAX
 };
 
-- 
2.42.0

