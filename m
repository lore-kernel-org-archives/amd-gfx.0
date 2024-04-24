Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 562FAC07E8E
	for <amd-gfx@archiver.kernel.org>; Wed, 24 Apr 2024 08:34:28 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E0EDB11390C;
	Wed, 24 Apr 2024 08:34:27 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="4lf4FPw5";
	dkim-atps=neutral
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2045.outbound.protection.outlook.com [40.107.93.45])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E99DA11390D
 for <amd-gfx@lists.freedesktop.org>; Wed, 24 Apr 2024 08:34:25 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dkcHPehvN82x3Jgsw9yJYhdz6OWDG9W8bSwluNXttXSkcwJWpHDLb3rmGp4QozFYubSDwR/3iK0r3993mP9cTH3S8tmYUG+0qn7ccJ47qI230b/5nyIwcczHDAmg1O0BkQ/grmLlB+wKhulV1efEzzffzaGfHUFOTCl0OnBY7x1uf4e4uiSnjl7YtMO20BrP/YwG5UzPX6FubO4uIbbP03byodj2JvG02uvbgvqgyUucW460jQH4s7s6XNNmsM2xix1nIluY9VAPMdbDJ6pQvyO0TkY1bHoqGfhUdmmqyGdo4beb1Tb7NoHjhZ6AkllJ7iSFfDnlqu5sCHta0Gc7+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9r6tH5vxFpN5/xkvEumu0vA5fm06b6EE+SZo/f2oXZU=;
 b=fOHUfWHRwI/Z+rRJ7xi/uDTQMPPLcgyz0v2IEXHISa72SM2ioY86uByFtkR7URxUGHeFlEHlcwo6LZ55AFGdn6oGHwhQFPr9vSq/kLHMoqbsQwoI6IW4TMEUcxqjqLbzrfrdlkwn4IFISgJLcBmlPChoIfW74xQVIVrCATmd/kSlFts6bQZWoiS8VLRwR8PlW6u2nEziLUZ5vQkwJgv2pr8IM4YBektq0I+bPOIQwm5TkYha9KzUJiJheD2JfjevTOfSyov5RLjKtEa1dyZyEcnEMkFcAb6heDj4pfJ1DG6pSk+VzEq750niKOGVXiKY9Nk9u2hQVHZA2StJskHb7Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9r6tH5vxFpN5/xkvEumu0vA5fm06b6EE+SZo/f2oXZU=;
 b=4lf4FPw5viQyVwvG5QFUKbYYyQumQgtddoQAoJ2AnXjKbjTijN+VKAdDqywuS/cuRbP5+3Cn+x6ZaiYQSQt9SD73E++fJzfp8D27OnQhrjul0hh3c9m2V4RX8WhVs9mzcwNCnV8fEwDE89OH1NpnV+yi81nN93AzJm7vJnWhLRg=
Received: from MN2PR11CA0009.namprd11.prod.outlook.com (2603:10b6:208:23b::14)
 by MN0PR12MB5785.namprd12.prod.outlook.com (2603:10b6:208:374::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.44; Wed, 24 Apr
 2024 08:34:23 +0000
Received: from BL02EPF0001A0FB.namprd03.prod.outlook.com
 (2603:10b6:208:23b:cafe::f6) by MN2PR11CA0009.outlook.office365.com
 (2603:10b6:208:23b::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7495.34 via Frontend
 Transport; Wed, 24 Apr 2024 08:34:23 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 BL02EPF0001A0FB.mail.protection.outlook.com (10.167.242.102) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7519.19 via Frontend Transport; Wed, 24 Apr 2024 08:34:22 +0000
Received: from SATLEXMB08.amd.com (10.181.40.132) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Wed, 24 Apr
 2024 03:34:21 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB08.amd.com
 (10.181.40.132) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Wed, 24 Apr
 2024 01:34:21 -0700
Received: from wayne-dev-lnx.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.35 via Frontend
 Transport; Wed, 24 Apr 2024 03:34:11 -0500
From: Wayne Lin <Wayne.Lin@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Harry.Wentland@amd.com>, <Sunpeng.Li@amd.com>,
 <Rodrigo.Siqueira@amd.com>, <Aurabindo.Pillai@amd.com>, <roman.li@amd.com>,
 <wayne.lin@amd.com>, <agustin.gutierrez@amd.com>, <chiahsuan.chung@amd.com>,
 <hersenxs.wu@amd.com>, <jerry.zuo@amd.com>, Alex Hung <alex.hung@amd.com>,
 Rodrigo Siqueira <rodrigo.siqueira@amd.com>
Subject: [PATCH 04/46] drm/amd/display: Check index msg_id before read or write
Date: Wed, 24 Apr 2024 16:31:20 +0800
Message-ID: <20240424083202.2647227-5-Wayne.Lin@amd.com>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20240424083202.2647227-1-Wayne.Lin@amd.com>
References: <20240424083202.2647227-1-Wayne.Lin@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF0001A0FB:EE_|MN0PR12MB5785:EE_
X-MS-Office365-Filtering-Correlation-Id: debf52e0-db1a-48ff-64ee-08dc643957c9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?HhovoIeMccnW/E64k0ZN8lUAIuQzeNoDBqcoOnuxiBzzGunkdvNEH7R5zxMt?=
 =?us-ascii?Q?Expj/VQ6/lVi9erxaGkWXpJvkfjYH1jo7wa9xpivsFDj2ceOQXb0a/5884KI?=
 =?us-ascii?Q?TJ8oG7meH6U33Sbv5+zTUdrY+fDod/gcGLlcRBjIqfdMv6VgA2RgUQIRn3ku?=
 =?us-ascii?Q?O+MhDmHV8gw79S3GLjNsoAWeWOesYAO9rfZb5quuMIu4dFiDuqbTVppEv98e?=
 =?us-ascii?Q?nhjwO0PkNLfd/sYI7u63Yu/u9/jdP/5ZHvxhdDF1+EtA1nAe1bORC+EBKc8E?=
 =?us-ascii?Q?o1y44Kuz0zTXtVmzihH+nHeI6NKk8twimsgjq5vwD/3iE6kbGUxHNwSuNh6x?=
 =?us-ascii?Q?484Vj7abKzk2GCM9K99TeI+9vrm1FoJj6B4JSgOdLvCdFCi760ESlrqzPpHP?=
 =?us-ascii?Q?obJ9AG+8oaBeiXjYzaQIzoBHHp2yjgpXy9ldD/t618EZnjwXSVSkHpDsLF49?=
 =?us-ascii?Q?PIqICdJkGiu+HXICSOU1oHaPg1QWXMCrKY/EuTY4tVwoFbs+qjOfdhn3WUIa?=
 =?us-ascii?Q?oKN4OMZP8kWMZ9LOqIpapOrr2n8OxBXg9zI62YcvnEQQB6R7BL2efu2t1j3J?=
 =?us-ascii?Q?xZGSy0zkrEvad8cYYC9bRLJ3Dpoj1IBFyF+YiIx6tOonvTKO/30FNovCXrgF?=
 =?us-ascii?Q?wxxDdwcQmmhYpTXSHFv8I1CqFqfdrE6ZiX+DNG11CUicoUoCRlpRL5vcwNEp?=
 =?us-ascii?Q?hKL6rcdW1ZGAdNH4MxUfRcuZyC87jZHDw+jpDkA6nZ7A38iEIjX5l18IU7rs?=
 =?us-ascii?Q?6TbL1+N/U1hyGtqNMekZPBdlKXgEUYaridyMaE+9737HYKuJqlw5N35fO085?=
 =?us-ascii?Q?er944DMg8/BGHbZm8vLAjhNP7Lq3eysfi3ugUF05soyIaEmJgXjnJAT9QWFO?=
 =?us-ascii?Q?wZnAj2RczMBNH9VNRofbuWZMJwMOsuY/sjUKahA5tJw3xXjJOzqwp1DZeAnK?=
 =?us-ascii?Q?8jGV/8P8nKPXyraQ17qkptqX1Hv42kap2kSwl+zD7tUH1dKJyqKKNo/mRRDE?=
 =?us-ascii?Q?awcugnnOe3RJycOtnt52mDH54XbX4hXt+hGGpkyVY53/GldyAk7tOodiD+Ck?=
 =?us-ascii?Q?+APPWtmZiXJiKNfaCcekNd8AG1BSBUss8Y/q+QtkJhNJkcvvhKbgaYqrKXnI?=
 =?us-ascii?Q?0q34HcuYKjbIVE5VHQK5ZKGYTbZi39hRR7BRXDmmBHJVN7byAe+1Sp3KHcng?=
 =?us-ascii?Q?i5T7JsGZ6qrtpYZYnBAWtsn+TXdV9VVvuMeRaCD85ZHQxrw4FHgxvWhrDkxE?=
 =?us-ascii?Q?1/MTUc6wH6mLj7fje/3BjhjcnXCdkzJoGEbmF+R08sS9M3+QVCxOrSDf3RLd?=
 =?us-ascii?Q?4yjtHvegwxGuAc4LSjh32jsvde7gfmRDSHSnOgHlUasK6CJ7Nz50hatnzEjW?=
 =?us-ascii?Q?8VyyJVV1F+x8i/jRM235hOlLa4nu?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(376005)(82310400014)(1800799015)(36860700004); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Apr 2024 08:34:22.8028 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: debf52e0-db1a-48ff-64ee-08dc643957c9
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF0001A0FB.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB5785
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
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Alex Hung <alex.hung@amd.com>

[WHAT]
msg_id is used as an array index and it cannot be a negative value, and
therefore cannot be equal to MOD_HDCP_MESSAGE_ID_INVALID (-1).

[HOW]
Check whether msg_id is valid before reading and setting.

This fixes 4 OVERRUN issues reported by Coverity.

Reviewed-by: Rodrigo Siqueira <rodrigo.siqueira@amd.com>
Acked-by: Wayne Lin <wayne.lin@amd.com>
Signed-off-by: Alex Hung <alex.hung@amd.com>
---
 drivers/gpu/drm/amd/display/modules/hdcp/hdcp_ddc.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/modules/hdcp/hdcp_ddc.c b/drivers/gpu/drm/amd/display/modules/hdcp/hdcp_ddc.c
index f7b5583ee609..8e9caae7c955 100644
--- a/drivers/gpu/drm/amd/display/modules/hdcp/hdcp_ddc.c
+++ b/drivers/gpu/drm/amd/display/modules/hdcp/hdcp_ddc.c
@@ -156,6 +156,10 @@ static enum mod_hdcp_status read(struct mod_hdcp *hdcp,
 	uint32_t cur_size = 0;
 	uint32_t data_offset = 0;
 
+	if (msg_id == MOD_HDCP_MESSAGE_ID_INVALID) {
+		return MOD_HDCP_STATUS_DDC_FAILURE;
+	}
+
 	if (is_dp_hdcp(hdcp)) {
 		while (buf_len > 0) {
 			cur_size = MIN(buf_len, HDCP_MAX_AUX_TRANSACTION_SIZE);
@@ -215,6 +219,10 @@ static enum mod_hdcp_status write(struct mod_hdcp *hdcp,
 	uint32_t cur_size = 0;
 	uint32_t data_offset = 0;
 
+	if (msg_id == MOD_HDCP_MESSAGE_ID_INVALID) {
+		return MOD_HDCP_STATUS_DDC_FAILURE;
+	}
+
 	if (is_dp_hdcp(hdcp)) {
 		while (buf_len > 0) {
 			cur_size = MIN(buf_len, HDCP_MAX_AUX_TRANSACTION_SIZE);
-- 
2.37.3

