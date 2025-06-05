Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 34DF8C5AE59
	for <amd-gfx@archiver.kernel.org>; Thu,  5 Jun 2025 06:03:12 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C8D0E10E1BF;
	Thu,  5 Jun 2025 06:03:11 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="qOdsmQd6";
	dkim-atps=neutral
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2074.outbound.protection.outlook.com [40.107.220.74])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DEE2410E1BF
 for <amd-gfx@lists.freedesktop.org>; Thu,  5 Jun 2025 06:03:10 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IMbjRuqODVxPeiML5ddK8fGkEtJR7OfGRrku6D73dZjt5sp2OwmQhauB4ax8rT18376guPYeXbjFA9gi2ERuOQj6/IkJkrvhJF/6N4hL7I/szANynmcpLE/gjpddwkwCZF2uaSIZtfucWeqb/bvTF5wpJx+HiMZQYWd9RRkyyjlJM/kfMVQ//HXpc7mWaIrP4WvZAAl5/Jl/wK8HNhZBzSG2vqt39rpLjBB10IbAxghp++DoaLYrxG17X4oUfSBqOsOEVtWBftB7+jXXRNYCosGP9ZMgnOJ/HXjmkEGcgXaZaJCGpV5shZGuWFoidkS1KeCYh0/0MBLaHozRZAA0CA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JpV0BxyYT27NLX4jPNCpg5ovb2p6EVVO1TQJtyZer5s=;
 b=JN5WY5f34ICqhqxK5WeetUUjiJN9TuW2bJvEmfsKwvf/8Ko1tzwzI2Irn44mq5AhJUdssblpPNE8RxdCVY10haQf/Sf+A3K94IE8ZWHNnAaN7MaFEbd8vvLsYgwhNX2/QlyshxgvVO8cu8kFlP9Fe6FLgCEmJ+YmYv5zM46fZyVXUyFkpSnNeZHS2/vBSQUrilP/jD3Yq2Ag1kTnAvJUGEtaUio7Dwb0p4bEwwSj5AY/XAmpUwUW5KMamAkD5zx78medfElUDyTQVMzVooD7VXUbAHCWNgvZYi8upczgYk0HSduQqzYgCsItylRAWlnF5UpC2DWm2ILti5rhL3SguQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JpV0BxyYT27NLX4jPNCpg5ovb2p6EVVO1TQJtyZer5s=;
 b=qOdsmQd69lNLKNnSi84+gatwuQN68/hQiQzZmVd5O1p1XAgC2we0ASgImiwO01Vq9Gnk1Y6u4fu5rARyJaGiDIpZvDXOHCcfezVZSi5r4nG36Poe8uu/u7+U/J30DEfqFg+6UtWQV0rWAmwPHmrWCt0JilcbZ3E3Ha03GD2NBi4=
Received: from SJ0PR13CA0131.namprd13.prod.outlook.com (2603:10b6:a03:2c6::16)
 by SN7PR12MB8004.namprd12.prod.outlook.com (2603:10b6:806:341::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8722.32; Thu, 5 Jun
 2025 06:03:05 +0000
Received: from SJ1PEPF0000231B.namprd03.prod.outlook.com
 (2603:10b6:a03:2c6:cafe::2c) by SJ0PR13CA0131.outlook.office365.com
 (2603:10b6:a03:2c6::16) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8835.9 via Frontend Transport; Thu, 5
 Jun 2025 06:03:05 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ1PEPF0000231B.mail.protection.outlook.com (10.167.242.232) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8792.29 via Frontend Transport; Thu, 5 Jun 2025 06:03:04 +0000
Received: from gangliang-mlse-vm.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Thu, 5 Jun 2025 01:03:02 -0500
From: ganglxie <ganglxie@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <tao.zhou1@amd.com>, ganglxie <ganglxie@amd.com>
Subject: [PATCH] drm/amdgpu: clear pa and mca record counter when resetting
 eeprom
Date: Thu, 5 Jun 2025 14:02:10 +0800
Message-ID: <20250605060210.158358-1-ganglxie@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF0000231B:EE_|SN7PR12MB8004:EE_
X-MS-Office365-Filtering-Correlation-Id: 07807c81-fd6b-4d7b-4caa-08dda3f6a2d7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|82310400026|1800799024|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?hbneX+8MfD2MjBCD2rBTeZIyo6tP4xoWHxK/mdtf/dy+d/4oDkznS+S4fMVI?=
 =?us-ascii?Q?spPer8QJVPskJpvW+sWBB2hxPtv5JbL+khxE1jih2YVoz/OfHbWGN0c9O9cO?=
 =?us-ascii?Q?1N3ID7Vp39iLYpor1LuT3Vtu/ALgx1jdrqnzf/AhwQ/xfTpRnJuse655t4kZ?=
 =?us-ascii?Q?/C5naIBKvaUjD61RLCdmga6O8xc8oVAW4Y/vdmP8wY1s5SI1aY/PcfaDjaUl?=
 =?us-ascii?Q?L904u1IJeS4j/LqY49iC6vdd/LahubXDAHXVFlCW7V4guP/TI68AadcpGmrp?=
 =?us-ascii?Q?/4vLtWaU1Tg8LKwPkGYF6NBeZC0R8TnWRP1Z+0TorZS89R4y1JakWx81yl0f?=
 =?us-ascii?Q?VWLuxnzuvpuunHa+cNFL42/hYrM70Xfqaze+zIl7Si4edtwhE91RMN6bJD7F?=
 =?us-ascii?Q?sPiM3WujfZvAIElp3bpMjdHZoyeaJz7oaPlI5dnhoHFYykJYRs0jtLzIs3nM?=
 =?us-ascii?Q?YhuNAXK/LcbzI2r5Xo36kCuI38Vl4IkYc2vBpMOFeTY99QWtcCkAwk3M5Dwk?=
 =?us-ascii?Q?AGjAn9XPVhwWh8x1hJ+nURaUVjgHCKnI6g8K5Owce8FnGyBqZqSq+ctLMSrc?=
 =?us-ascii?Q?LoPCQSoMoNTiB5v4WPHjDABOTwyXdvTfG9oVstqCjleBjgxNtZLQ6D6AoNpz?=
 =?us-ascii?Q?fcic6PLoEPRwpvMLZeoGr/fK7DlEsKlzri6A/IkKeRSs94VU+HkdB6GH/T8g?=
 =?us-ascii?Q?E7AR85ErLJLGm4AcohIkRxzV14Gw0GiBhWJjTWs1qeqV7NjZj+CT84/rJfH2?=
 =?us-ascii?Q?/4oO3ZQuA0FKfFIJwhEZ+k4h8gWZtAo0QRYhqXWmvCWzWj55JiXiaeoPy6US?=
 =?us-ascii?Q?fJfoCVcKvRP/Sp3HwJTXgpdV+nROwJ11p1aBn9oimX4d9Kl8j2xya4kEd+ue?=
 =?us-ascii?Q?Z+9Kyp103zWjzfTbb4cH9/++ze/pLUubrUPr2CicbWr1342BLlCfuQxzyXTo?=
 =?us-ascii?Q?28IjfFZ+vv7Ve6h09dZtHfg4W7esV9046/fdz+Cgy2kk0ZscqhqQskdAPhwl?=
 =?us-ascii?Q?Lmn39VMPEKeldAfcvKAm0YJyfjeX3TwwYSaneEBc451Wm16Y1K0rRm9psBRY?=
 =?us-ascii?Q?g//ISvld14vdJsCbpi09Bv0lCsNvXXdThjW2NJUXPIH5XgrX38d6bmvuk5j7?=
 =?us-ascii?Q?mGNkVNTbuG+GMbxW85yydwDRssDWN0GUm/3jGwS5rrvtXJPGU1D7u1dsaVjw?=
 =?us-ascii?Q?9iZuhIyho7+BkuPErBXU9iRT/gwR3OIzlkYj2UJ9f+XswvCXR6FLRcJlDWhX?=
 =?us-ascii?Q?uY9+iEWSQjSUSs/1yRxgJGRVOa/2zSIMC5dKXiu4AAsrg2GVu2DnSRzgVJqR?=
 =?us-ascii?Q?GqeUDEbsjV4qJajif5pYhIZj4Ev7uOjMpxil6lxfLmfEZAi5g9ZR24aNw26n?=
 =?us-ascii?Q?oyG9mu80hzLwbetEo75VGWMkd+qI1cHgKlhoN+923LJy3BJ12kKP3myuWRPf?=
 =?us-ascii?Q?mHD6eO+0iCQJ+2gBQw4yxr/c4E34tqUJRUxBJJxnz5/3TUhLCN2qRWX5cGM8?=
 =?us-ascii?Q?EGDmIl1Yco+pciYClwMeTasmp7uIefvLSGX7?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(82310400026)(1800799024)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jun 2025 06:03:04.4525 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 07807c81-fd6b-4d7b-4caa-08dda3f6a2d7
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF0000231B.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB8004
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

clear pa and mca record counter when resetting eeprom, so that
ras_num_bad_pages can be calculated correctly

Signed-off-by: ganglxie <ganglxie@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c
index 2c58e09e56f9..2ddedf476542 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c
@@ -476,6 +476,8 @@ int amdgpu_ras_eeprom_reset_table(struct amdgpu_ras_eeprom_control *control)
 
 	control->ras_num_recs = 0;
 	control->ras_num_bad_pages = 0;
+	control->ras_num_mca_recs = 0;
+	control->ras_num_pa_recs = 0;
 	control->ras_fri = 0;
 
 	amdgpu_dpm_send_hbm_bad_pages_num(adev, control->ras_num_bad_pages);
-- 
2.34.1

