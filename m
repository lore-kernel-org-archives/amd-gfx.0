Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B259EC46CD2
	for <amd-gfx@archiver.kernel.org>; Wed, 24 Jan 2024 07:04:42 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3F75510F659;
	Wed, 24 Jan 2024 07:04:42 +0000 (UTC)
Received: from NAM02-DM3-obe.outbound.protection.outlook.com
 (mail-dm3nam02on2074.outbound.protection.outlook.com [40.107.95.74])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5DD5710F659
 for <amd-gfx@lists.freedesktop.org>; Wed, 24 Jan 2024 07:04:41 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CblMEzb2ES4JgFy9BUMLOEBYYutUQd7L8q8KtKxHriVtaPYtKXWdMgDEza+5Ye6Wfd3MAtw+3L3scX9bk9alKyJ32z7dmJYpOiTVM13fvQlZicx8b5aByfD02a3M8B0yF19ObaAymhhZzIJDMeilZhJS7FE2t6n79RqmcqS22mCD/c2qQp4Z/NaG6InSi0RGIEDV4+n7f04oXT2FsoVWnhyUOKtmKiZSG7aIj2KirYo6uy7gJqYSM6k4tDE1VofbFTK57+Jatf8DwlgdVEjxD400Led8at/qab3BKBU+Pa4R+atHbVE3OYXKh5JU8xdubWH2ruo477xlYcJcY8Oj8w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QQtU5unxMRIbIzgRUFNqFlSTNPbxafpZKat2vafaHiU=;
 b=cjUnXat4mPCGtDSfKqLZ6Cp194wp2RpQztFXX+yBD/aHun+yBcFREnFT/X3JRL7snFdJxRDv0bGYW3oQU3uscDRaXgENuLSOtKMNP4qXc4eJ5Ya3qsAp4jvgLkz6+zf9ITvGoARoLie0HNvSB5UlkMWuczaL8kAGHW5xQGbsnanpYs4xAKt71fRnmqcwMflv1YWmBvgyxlSAf97kSnX+tWDQG9GrCxoQOYT+uQV1qk1+CA7ZUxFCDKoH2OcM5smRGUY25qAvPH4Nk9stWB9MbBcSYeAdfm75GVI+HO4oX34lBSvgURRuOhcaizNEcSH3S0h3kZL5JjuDTxB486jnjw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QQtU5unxMRIbIzgRUFNqFlSTNPbxafpZKat2vafaHiU=;
 b=eUjskljzBJkhcclakcBQCVqwznJtIOlIiT2iQNfEeQ5+GKQPkwV+7AqrWlQInE6sBtTZ3AovZkgPmO8C3zee2MuQJHdYJH4SCAXrP67YCbflkY8ebl80gksxc7VBnzeUIsclZPUP1TlkFBU6+RVzHvfv+te3MXwCqexo/dpSe+Y=
Received: from MW4PR04CA0105.namprd04.prod.outlook.com (2603:10b6:303:83::20)
 by DM4PR12MB9069.namprd12.prod.outlook.com (2603:10b6:8:b8::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7202.34; Wed, 24 Jan
 2024 07:04:38 +0000
Received: from CO1PEPF000044FD.namprd21.prod.outlook.com
 (2603:10b6:303:83:cafe::4d) by MW4PR04CA0105.outlook.office365.com
 (2603:10b6:303:83::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7228.22 via Frontend
 Transport; Wed, 24 Jan 2024 07:04:38 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1PEPF000044FD.mail.protection.outlook.com (10.167.241.203) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7228.0 via Frontend Transport; Wed, 24 Jan 2024 07:04:38 +0000
Received: from SATLEXMB08.amd.com (10.181.40.132) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Wed, 24 Jan
 2024 01:04:34 -0600
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB08.amd.com
 (10.181.40.132) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.32; Tue, 23 Jan
 2024 23:03:59 -0800
Received: from tom-HP.amd.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.34 via Frontend
 Transport; Wed, 24 Jan 2024 01:03:56 -0600
From: Tom Chung <chiahsuan.chung@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 22/22] drm/amd/display: 3.2.270
Date: Wed, 24 Jan 2024 15:01:59 +0800
Message-ID: <20240124070159.1900622-23-chiahsuan.chung@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240124070159.1900622-1-chiahsuan.chung@amd.com>
References: <20240124070159.1900622-1-chiahsuan.chung@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000044FD:EE_|DM4PR12MB9069:EE_
X-MS-Office365-Filtering-Correlation-Id: 9ddcac6b-d426-41f0-2227-08dc1caabad9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: PLv4j0AHoWFIE5jYFpCVXR7VM5FsTfkHo9AUTsWF9bs89uiFIwhmI4E91HcZE7VouO+TuvCFP67a7Drgc3grU/pY+WK9+5srUprP00yuxU8TbfMHdrhHFlzVOXNd54FdXUFWhAfjXFobIOEE0blZpDFWu/oAApCPXZWDpTtIu5hKZVsivY1FoJVNg59H1zW/1TfKHTQps/QDys3Io+KfYtmpUcKQWJSn1jKf2etx8oL9bB5AuAtut06niWPe8rcG9Qogcn356LWo28AeK/CLFIKMkVwDuV0rLMQJkiXn7mTkMYmjRsm5fus4eqcGVkd9PkfDEg7nGAW1BhP7UznSVCIGqnjXBff6vVaOFK4IwJgmv8aYKl29htGQe08jP/+X7ySaMrcAXKu54RjyBzwsOUDy94mlHxVoo9rauRCeHDijeVI3EgQecIQ6kl+EDbWJgH+OFWAvxcYsKk1iiz7myjw7N17QpqvuG23nxSmCP8JCFSrQ9bT7xTzA0lypqz8EkZzmIg0FJwGGJ/9BinNiHRcvOTJ5ljz20GKSIS3rrMY8JXe0MABkDQXcpESQ1EFnb6pEfPyOeSe+LSeQDgxT2c69FLE2aJIvoMGqfKTefQzogprJGhgsKoSfL9cwM5E9tVjuSaSdq8r5JplSd1MiTwNyYiow+apmqAVKmiysC0IFjvLYa6gW0OA4f96VSJU4+Yk8NSTh372PMmH5LOWbO6lQQh/eKvH5SaDhClJMyikFLkkP73S894evwbk0iMeDhy3P6mxC/WiLkPBu7fjk7w==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(346002)(39860400002)(396003)(376002)(136003)(230922051799003)(64100799003)(186009)(451199024)(1800799012)(82310400011)(46966006)(36840700001)(40470700004)(40460700003)(40480700001)(7696005)(336012)(26005)(1076003)(2616005)(426003)(82740400003)(86362001)(356005)(81166007)(36756003)(8936002)(4326008)(83380400001)(5660300002)(47076005)(2906002)(41300700001)(8676002)(54906003)(36860700001)(316002)(70586007)(6916009)(70206006)(478600001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jan 2024 07:04:38.3171 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9ddcac6b-d426-41f0-2227-08dc1caabad9
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000044FD.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB9069
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
Cc: Aric Cyr <aric.cyr@amd.com>, chiahsuan.chung@amd.com, Sunpeng.Li@amd.com,
 Rodrigo.Siqueira@amd.com, roman.li@amd.com, jerry.zuo@amd.com,
 Aurabindo.Pillai@amd.com, hersenxs.wu@amd.com, wayne.lin@amd.com,
 Harry.Wentland@amd.com, agustin.gutierrez@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Aric Cyr <aric.cyr@amd.com>

- Add control flag for IPS residency profiling
- Populate invalid split index to be 0xF
- Fix dcn35 8k30 Underflow/Corruption Issue
- Fix DP audio settings
- Use correct phantom pipe when populating subvp pipe info
- Fix incorrect mpc_combine array size
- Fix DPSTREAM CLK on and off sequence
- Fix USB-C flag update after enc10 feature init
- Add debugfs disallow edp psr
- Unify optimize_required flags and VRR adjustments
- Increased min_dcfclk_mhz and min_fclk_mhz
- Fix static screen event mask definition change

Reviewed-by: Tom Chung <chiahsuan.chung@amd.com>
Acked-by: Tom Chung <chiahsuan.chung@amd.com>
Signed-off-by: Aric Cyr <aric.cyr@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dc.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dc.h b/drivers/gpu/drm/amd/display/dc/dc.h
index ee561d941f53..5d95b1e9dafb 100644
--- a/drivers/gpu/drm/amd/display/dc/dc.h
+++ b/drivers/gpu/drm/amd/display/dc/dc.h
@@ -51,7 +51,7 @@ struct aux_payload;
 struct set_config_cmd_payload;
 struct dmub_notification;
 
-#define DC_VER "3.2.269"
+#define DC_VER "3.2.270"
 
 #define MAX_SURFACES 3
 #define MAX_PLANES 6
-- 
2.34.1

