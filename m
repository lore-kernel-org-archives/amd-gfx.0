Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8B6B0C77B7F
	for <amd-gfx@archiver.kernel.org>; Fri, 27 Jun 2025 14:34:17 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5E4ED10E173;
	Fri, 27 Jun 2025 14:34:16 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Ad16itId";
	dkim-atps=neutral
Received: from NAM02-DM3-obe.outbound.protection.outlook.com
 (mail-dm3nam02on2073.outbound.protection.outlook.com [40.107.95.73])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6117210E327
 for <amd-gfx@lists.freedesktop.org>; Fri, 27 Jun 2025 14:34:12 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rTY68N74ZUnZxuZsQhciXp6Rd4ge167fPqRotUVhINJ46NkB9INHSkUSf9GdCwzh/CGMhh6HuA57H8fkhev/Gaf6v0YEyWGf6biulPB2jUnqSda6TFoMdukvJGxWqMTJWhLBl0jrdgn6b1f1lf7zMwrcS8U/01cB5Df90UC2Mi4rERus9Cs8pfnNHrIC+iGR9Q6E2HyyTzss6b/yU/SK4W5LgdsVtysS5NfJpbLEDbqgVF+rVmpfShajv/ZWwwKbg61F6sqPotd7/tVQCP+VLQb4gXik+S4HnyHIOSZnnfGbN3hbnb2Jmiw3s28ZJLvDFljeKiWiTtOKy7KLUJnxrA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=62eytYoAnKrRptCyDwW3fMy2urJQ6XIiT9KDmzF9N4k=;
 b=GDw7gDG8+Caf4sQOlHyBvCTRX0KWwpqK5koIcTG6ZOsQOg5Y82gEI/3molrQqzNaw/SzI2r/+fyGhDln55O5m+4eJuNe4t6NjICHsZ8k2ubENjhmcvw9N/6kuIb8KQIYU4zunUYzRio+97kEam1xeISE4+GLn6q7zExwz7wBuHOnqW4gsKpyqQ9o3DJZK1A++E2YLH9kHf0D6UNZEWPYPSiWAjvmbqJWS8VaEwY7cHlR+K/1FlkVoM/8JFDR6hRWcTPZXiY1l4G7oZpJOiD9bDc735YhfOELLR+85HZgPIRom1cX5DL+lzVjoGGZYypJT5ObHg6vojKuR28QXqlNRQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=62eytYoAnKrRptCyDwW3fMy2urJQ6XIiT9KDmzF9N4k=;
 b=Ad16itIdPJ4APwayHT/Ijwrf3vEd5Xba2mRMnOGgMZngF6kqkBGAgLQxWaGnj9Fx4fQXbNcdqmt/eE8Xkii63mbdMsew5ul2Gd8CNdzMuTRQAS6op/apHCrKY7Cq9H2PX4A2vHeroviX/HRzpFTjKiR68wvpsviuqMgHiW3mpVQ=
Received: from MW4PR04CA0167.namprd04.prod.outlook.com (2603:10b6:303:85::22)
 by PH7PR12MB9125.namprd12.prod.outlook.com (2603:10b6:510:2f4::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8880.17; Fri, 27 Jun
 2025 14:34:10 +0000
Received: from CO1PEPF000075EF.namprd03.prod.outlook.com
 (2603:10b6:303:85:cafe::39) by MW4PR04CA0167.outlook.office365.com
 (2603:10b6:303:85::22) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8880.21 via Frontend Transport; Fri,
 27 Jun 2025 14:34:10 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1PEPF000075EF.mail.protection.outlook.com (10.167.249.38) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8880.14 via Frontend Transport; Fri, 27 Jun 2025 14:34:09 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 27 Jun
 2025 09:34:08 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 5/6] drm/amdgpu: add support for cyan skillfish gpu_info
Date: Fri, 27 Jun 2025 10:33:41 -0400
Message-ID: <20250627143342.23856-5-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.50.0
In-Reply-To: <20250627143342.23856-1-alexander.deucher@amd.com>
References: <20250627143342.23856-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000075EF:EE_|PH7PR12MB9125:EE_
X-MS-Office365-Filtering-Correlation-Id: 1a4a1fbf-1f4f-4d8c-6e18-08ddb587ade4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|376014|36860700013|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?Kf913NqQ6A06eTJ84kUsnP/OjiVKDpodXbsyMhqOZT+cK6lxGoRkjxTwEMJY?=
 =?us-ascii?Q?AyTglx38KVeCtOFS+4ux73mqDwkwGhcFjyLYCkhTR53rzC4v0vdOR8MEsyI/?=
 =?us-ascii?Q?S8jP4Ut0fkH9aRYp4gTC8mvJzWaFeIXtRyMsRMnyQKe7s/zDo64DMTm3FzV2?=
 =?us-ascii?Q?3BSrJw3QeLStCL80CIhcbBJHC5PmfiPNKtu/owsKOVc/68ccjOMD3S4XMytO?=
 =?us-ascii?Q?KfQIku9wAVpLsXJ86B7N7LyBOz/pnrLtFBMz/GJ3153GxUX81i8B5ukaTYAS?=
 =?us-ascii?Q?a2weysZ0OcvqwFyIAkjk/4IvJDQFNUC1UzGdw4sjJZFvEpgH87fAVEpmbx2z?=
 =?us-ascii?Q?qJq2FTwwTux6YRL0w5Qz8O5gQzakS7oD4V58kZsfN+S+XA6JKyTdZpFwei42?=
 =?us-ascii?Q?2ZdxaTF6PxDh25XvbfB+9cWohez1ptgJeEzmnFvkG5bmEMmd8EHlUUzUFhQs?=
 =?us-ascii?Q?dW4A5K/Sowu1wG40GDRk+A4xsXKJV5YaOCC1XUAq/mx2BqgPU9EobOeYraB4?=
 =?us-ascii?Q?7Q4VhyjBqGTEMle7p+QWO9xPLz8K4lbgb4xbti/6qkyIN8yw95da6+xYS8dg?=
 =?us-ascii?Q?BITCqVy4Z8IS5KP4AA5TdsP7sQh1Fuo7jx0/MUeTkCcP7kyR7KsqJtykA5IK?=
 =?us-ascii?Q?6Q2Bbk/D13NY7GwKgfteX1ph3PKqEk89kmNnSQd+dj9/XqmTaJY/CLMD9bBc?=
 =?us-ascii?Q?ezvMSG0cPwJ4256GlY3PIhL7De1HUdKWs6yNYc+n8IeWu8yrCdXZiQ4pYHge?=
 =?us-ascii?Q?zvsSZKe7BV7FN09/XNHzKBmxkEDqDsaHNkMVxiz3cLltCah/YNOjsymcbJ5U?=
 =?us-ascii?Q?SbRo8GkNU5nXvwB6ikiJN2pRKvWalrDirV8/eQeteyMptvF1Wo76fZ9Zmv/7?=
 =?us-ascii?Q?f73zX22ITbnF+4rhJHNQL0Pr0Nr7YGZLYAB4sS7mjNjME/sZeuscA9Xqt4rQ?=
 =?us-ascii?Q?6JYo1HiwXzTYNr3ltCizWXMURT7h4H6YtuNgQg1fqBEwNa5i5dv/uPqT5JrL?=
 =?us-ascii?Q?B8jYTUYq9IkJhc9mkU8HFZQizsI0UUV9rCNobRp2bhuzknESrNTf6tehzd/y?=
 =?us-ascii?Q?gYsZof0KCw/qJDvc2Grkb19yyMb8SaXlM+I9wv2jE2JZP//NyEk2Smi9ew0n?=
 =?us-ascii?Q?yo40cz8PXsSNCxTNpNnhSnJMbNof4Tki35x+X7Z46wlRQ4l3DPiGpB9yjlQT?=
 =?us-ascii?Q?Eu0gYNsahhkai+3h8ftbLWbJmCXZUQOvqef74FKvRoL3nYbXBktbnzzBGg4n?=
 =?us-ascii?Q?+HxyWkY+WDlPyqzGw2/s+GYcw4w72stEli7p1/UPCX7oKTDKY5roUYFZpMo1?=
 =?us-ascii?Q?3Zewlw0nE4DWdmFGFledJzxXml+1bu1JE33Uimwm9m4VW+NsHzwLI5zLkakJ?=
 =?us-ascii?Q?q7n2LEVcmNwI3vBj7n8eUMGYpFDj+Io7lK3Rni6XTZVI8Fe2Dnv44pVKf/IK?=
 =?us-ascii?Q?HcJY+mvROCh+GHBua94Vh2Al0kMrk5iASiceZLmQZHULlRCtq8N5QSgn9y/E?=
 =?us-ascii?Q?yPpwD7yeupmUtWVuHwkztXa7nIcFzDXgD0IG?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(376014)(36860700013)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jun 2025 14:34:09.7768 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1a4a1fbf-1f4f-4d8c-6e18-08ddb587ade4
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000075EF.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB9125
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

Some SOCs which are part of the cyan skillfish family
rely on an explicit firmware for IP discovery.  Add support
for the gpu_info firmware.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index d1b122090b3d8..758e51505b3c7 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -95,6 +95,7 @@ MODULE_FIRMWARE("amdgpu/picasso_gpu_info.bin");
 MODULE_FIRMWARE("amdgpu/raven2_gpu_info.bin");
 MODULE_FIRMWARE("amdgpu/arcturus_gpu_info.bin");
 MODULE_FIRMWARE("amdgpu/navi12_gpu_info.bin");
+MODULE_FIRMWARE("amdgpu/cyan_skillfish1_gpu_info.bin");
 
 #define AMDGPU_RESUME_MS		2000
 #define AMDGPU_MAX_RETRY_LIMIT		2
@@ -2603,6 +2604,9 @@ static int amdgpu_device_parse_gpu_info_fw(struct amdgpu_device *adev)
 	case CHIP_NAVI12:
 		chip_name = "navi12";
 		break;
+	case CHIP_CYAN_SKILLFISH:
+		chip_name = "cyan_skillfish1";
+		break;
 	}
 
 	err = amdgpu_ucode_request(adev, &adev->firmware.gpu_info_fw,
-- 
2.50.0

