Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0778CD2F7F3
	for <amd-gfx@archiver.kernel.org>; Thu, 17 Oct 2024 06:56:41 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A52C010E7A4;
	Thu, 17 Oct 2024 06:56:40 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="2SqSMEH6";
	dkim-atps=neutral
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2059.outbound.protection.outlook.com [40.107.244.59])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6BA2B10E7A4
 for <amd-gfx@lists.freedesktop.org>; Thu, 17 Oct 2024 06:56:39 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jLITB7YQrtUtQ4tg7WytOnbssQM+PiBLF6iR6SfrzNzN1wSthSdvNc4/xgfFQHyW9b/RTm4ANnAnVRfIjPlpQdemSAWZUYKMhG1LnioJkOIjiCFSyu6j6ayr9I1yKCt5ylnqtzvYsUBw39sSi7ArSajhj8F5ymFoijWFaKY+eSBm4jls6wUI6qPonq6n2QPKsv52b/sPTkazMML5EFkEf34lHdzFuV3+aT6J7NGdyOjyxKYm6aOjUyT01gyacalraHPZfZ7t6ohUY9HRkXWiX6xnZhrE4fyLfgad44JN1CHotT8jQNDTcyjGXv5Zjv6o7F/rAuHttt+EdcpiLmgFbA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZLvKr4Ib/uSeP4rwkyO2ylur46ATVmnoPIAUOUlE700=;
 b=bEosXjOOuFjTS+R9gpyMgBUHB9zmxvNTctqLyTuKOCldD1bv9fHOIyCKuG+ibWcXFdeqbM3e/m1oArNsrSp2zerm5PhGFwJefUbcm2Sm0czpCHs3dH3jv2MZf0M2XRFv7QH+VSDhdc4RHFOsBTV9r5VIjqmjdD6Jtb0FIqDA7Gu35xHcy1unlZk/kVN+Akm5RNzWyr6dMkk4iHvAJtBFRifeIup3KRCNmfoJAfRMsISdvdNSAOQt66oNpdn1VWYL3ZmDEX1eq1gX/cHN9kQ4f0CN0i8rgqXlZ3PPyC4bz/7IZwKwk15j8g7wjyffek7c4cgZ47JTbL4GGEO54SyWkA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZLvKr4Ib/uSeP4rwkyO2ylur46ATVmnoPIAUOUlE700=;
 b=2SqSMEH6I71Dut8i3CyQywkmt6IQJZ+FGYggyREBffhmBLLRle1g9NAtLEaCAxI9DFJJ6jr1K14wdZRwz4xVZUNOYhDm2htkqRNZOo0eWoF6BCG0CCPLQEEC30mFV2R2qcgMidsJ1y2YmoTXvl2zb2Gwdy0NAgdrlszAOnkMgpA=
Received: from SN7PR18CA0025.namprd18.prod.outlook.com (2603:10b6:806:f3::29)
 by SN7PR12MB7323.namprd12.prod.outlook.com (2603:10b6:806:29a::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.18; Thu, 17 Oct
 2024 06:56:37 +0000
Received: from SA2PEPF00001507.namprd04.prod.outlook.com
 (2603:10b6:806:f3:cafe::24) by SN7PR18CA0025.outlook.office365.com
 (2603:10b6:806:f3::29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.18 via Frontend
 Transport; Thu, 17 Oct 2024 06:56:37 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SA2PEPF00001507.mail.protection.outlook.com (10.167.242.39) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8069.17 via Frontend Transport; Thu, 17 Oct 2024 06:56:37 +0000
Received: from srishanm-Cloudripper.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Thu, 17 Oct 2024 01:56:28 -0500
From: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
To: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>, Aurabindo Pillai
 <aurabindo.pillai@amd.com>
CC: <amd-gfx@lists.freedesktop.org>, Srinivasan Shanmugam
 <srinivasan.shanmugam@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, Roman Li
 <roman.li@amd.com>, Alex Hung <alex.hung@amd.com>, Harry Wentland
 <harry.wentland@amd.com>, Hamza Mahfooz <hamza.mahfooz@amd.com>
Subject: [PATCH 3/3] drm/amd/display: Add hpd_source index check for dcn401
 link encoder setup
Date: Thu, 17 Oct 2024 12:26:14 +0530
Message-ID: <20241017065614.3502792-3-srinivasan.shanmugam@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241017065614.3502792-1-srinivasan.shanmugam@amd.com>
References: <20241017065614.3502792-1-srinivasan.shanmugam@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF00001507:EE_|SN7PR12MB7323:EE_
X-MS-Office365-Filtering-Correlation-Id: 1791f983-ae98-48e0-4cdb-08dcee78d845
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|376014|36860700013|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?TY5HmFX+kj33JkI0vTMM4OqUhJZx8H8Ji9ekpy+2iClWXZbRKCJp0Mruk0O4?=
 =?us-ascii?Q?VN7v2Fqam25Ri1XKH5ewtb/XCAJD5ie+kf8iE1fyyQTObBs4GFQvzou9aW7u?=
 =?us-ascii?Q?Ns9Bnz/xk74xirDudTQiA0hHmjV0mHYOdh+cp3aNiEGo6D+P6G4NvrkXRL+9?=
 =?us-ascii?Q?/us7JFiC0JtlmyZ45lfCk9Vv6OHm0QJ5DAZRLMtXdjXb1uC0FTzy82be5C/w?=
 =?us-ascii?Q?PsD2YnPymRA6X1k/Lkwq0+RhpbQo9RmIoTkEHpf83ToNtH2NoZ50KMBbxhkq?=
 =?us-ascii?Q?3H1PKvEQxYv6UPiELBGUE3iLcqHOD4qmkQljnH0r+jd+Youam5EQhHj0886E?=
 =?us-ascii?Q?Xo3Ej2OxURIo1UEqcNnlkysiIwW8L2sa2i6N/gx0xj2kLSQFtAa0gVDM5soa?=
 =?us-ascii?Q?Lay0c6h/S+YPPewVQasbMluqjQBGFIYN/aljhhZU3Pb4TbDHg1sTg5BQc5fx?=
 =?us-ascii?Q?y484mmnX/BXJXTWU0c7lTgnjKhKmzmw9V/7J7OHJZnXHgvyP5tG/IaBeg7iw?=
 =?us-ascii?Q?rFd0HWimt1BDd0ZYcUI24La2eUWZF5SD0gZMZ5d0BsFNHikezmbCej988rcs?=
 =?us-ascii?Q?Xe3byXlhDqL6ypggf5Ne4/ath2dWyETVheRZRQEDUWy6pr6GJwI+xZvUqex5?=
 =?us-ascii?Q?rOCH+ZcmI4A2ehfzGKdCm8wtpP24pjT41oUOviZd9Xl7sk5LHKF5t6u4C1O2?=
 =?us-ascii?Q?T+TPaeNbVkTI+Lsn+cSNQNBiwXtlWFpT31zjwf6FcKP9y8hzB/Iw7ueyXEt2?=
 =?us-ascii?Q?DwBpWwcavpEP/homHxsPmH7srnDNMi16fD1BirnOFdU/xCUPDSQsyOzKXESH?=
 =?us-ascii?Q?glmRZCNid8D8DPIkGjljgUc3Zn4nQhoQaYsaeHIgIsycEzFh0iGHMtuU1A1p?=
 =?us-ascii?Q?IoxzuzZSOvQYMxiMbv4hrD+WsOb0bPVzTONATugw4O4AwNltvpy/ABqeHXcV?=
 =?us-ascii?Q?pLh7k+/C9Peqk421NzbpVCrwn9ikANRaVMbh370GOcvx/gBD9NxIZ5FR6Xvq?=
 =?us-ascii?Q?aMPW7YIKmdpcCaC1n0lEeIwIMXHlXpMagmD4pMbFC71VsVQZH8j1ae+yaYNH?=
 =?us-ascii?Q?rZdDurxSa7fbucReylHfRFQhJGJmcNzo0u5Cx6U426Ahm72OjqGIZH62bZ4j?=
 =?us-ascii?Q?ntIRhUxv62d6j2bLg3ybYS04VPiQiLLFUZ8GeX8cMXtZlEIgf1qE4c8Ji98H?=
 =?us-ascii?Q?3HLlePN7+1UEtQSCs3Lp1/ekQ0eYZkyzuVx2yoPsSHMgQEmVAE6ek6S0NWOs?=
 =?us-ascii?Q?UpC5Tg7dFvp8XpybpwBx4fVb/YNccgZEHQAx1WbNeatjnWqA7AajuKJ4Pi4E?=
 =?us-ascii?Q?NGRsQJrLY5p65wvwo3tPLeMdfvbPfxyuDjSEr5bDdNePQB7M3yn5Jk9MmAns?=
 =?us-ascii?Q?r0fVJIdpWUfJU/kuJfb69G6pIPxlFAuO3M58BPt2ry6phQfRww=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(376014)(36860700013)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Oct 2024 06:56:37.0893 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1791f983-ae98-48e0-4cdb-08dcee78d845
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SA2PEPF00001507.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7323
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

This patch adds a boundary check for the hpd_source index during the
link encoder creation process for all dcn401 ip. The check ensures that the
index is within the valid range of the link_enc_hpd_regs array to
prevent out-of-bounds access.

Cc: Tom Chung <chiahsuan.chung@amd.com>
Cc: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
Cc: Roman Li <roman.li@amd.com>
Cc: Alex Hung <alex.hung@amd.com>
Cc: Aurabindo Pillai <aurabindo.pillai@amd.com>
Cc: Harry Wentland <harry.wentland@amd.com>
Cc: Hamza Mahfooz <hamza.mahfooz@amd.com>
Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
---
 .../gpu/drm/amd/display/dc/resource/dcn401/dcn401_resource.c    | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/resource/dcn401/dcn401_resource.c b/drivers/gpu/drm/amd/display/dc/resource/dcn401/dcn401_resource.c
index 46feff9348d9..b425b34dc7f5 100644
--- a/drivers/gpu/drm/amd/display/dc/resource/dcn401/dcn401_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/resource/dcn401/dcn401_resource.c
@@ -1032,7 +1032,7 @@ static struct link_encoder *dcn401_link_encoder_create(
 	struct dcn20_link_encoder *enc20 =
 		kzalloc(sizeof(struct dcn20_link_encoder), GFP_KERNEL);
 
-	if (!enc20)
+	if (!enc20 || enc_init_data->hpd_source >= ARRAY_SIZE(link_enc_hpd_regs))
 		return NULL;
 
 #undef REG_STRUCT
-- 
2.34.1

