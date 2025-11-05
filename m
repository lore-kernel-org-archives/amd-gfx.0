Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B4A65CCFA04
	for <amd-gfx@archiver.kernel.org>; Wed,  5 Nov 2025 02:05:20 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 54CC110E69E;
	Wed,  5 Nov 2025 02:05:20 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Syq8Ofe2";
	dkim-atps=neutral
Received: from BN1PR04CU002.outbound.protection.outlook.com
 (mail-eastus2azon11010012.outbound.protection.outlook.com [52.101.56.12])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3C90610E69E
 for <amd-gfx@lists.freedesktop.org>; Wed,  5 Nov 2025 02:05:19 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VIZC6VoOtBcBfif8qHgkgzIzi+p4H3eLYh7Z+We1MFKIx+TIg5pcCGzixaWhvHqspOw1x8Dt6zkSwvUAEXtNH6qrxDu0etPy0fYu3corgPbbr3bIocUH6XZ6VLUxcVXrp76QRRHg0XUb1OztOcKWCHCeNqLEKxbMMf8i58ZpcwhzyHY12VZjRjrLgKIpfgQs2iDNU7DGPyjsl6eJ8RQCq0k7sGqHrYYbvmar5VdXEmZUXXb4nUTjfIKFEiUCHAProfxUg2qDD4EZR+Q6TvqmMwcdY79CAcpRIDMWzGNh943Qnju3uxeA0P7HoCdxR+htmRQr5/kbKNAahfK4dlxTsg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qEb4pPljbIcBfCodnFrDRqsDQFxmUKZ6qksijGnjleo=;
 b=oP+zcFYKIcHD8MyBdB7S/ISxvjNyc3x8BolKxGqrElLf+zEWKB6NGx2NTGpVlZkUv9mxq51xi8QeaiVNpTTIZAg/kr0TK95hu5jhQuXO28s50URklICvT1wpcdLLxEUhTf7NukHpKGHB1otsBEsYWwQbcQVTd2P1anO3/wcyhlA4BwNpuo+a6Ta1HjpnlrxAnXJhV3sC8uP1UuQwM0JhuoLZnLjiPM12u20xW3DmpB/nthG5yJyQvu4CQobhC2R8y1KGvSjs89bPHb/zYwKRKcWZGs7tB65cXfXQF2VlugK3C4756Rh3LLpUug4yE6ZbtVIg/QysurO4W9OGQUvyOw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qEb4pPljbIcBfCodnFrDRqsDQFxmUKZ6qksijGnjleo=;
 b=Syq8Ofe2H+/u3X5xZ6f2Lihf75F45WoscHsFMk+OpXehuN2GFug/vE7wtiH59YSTOmX1pyeuv9GsAwKwoC+eIe0VcB9d1Vcs53LVkYhvahbsoYtMOdt/NpcdFbhAa2MpDB83dIdsJ1M5+r7NG5IASiped6ccDGARcK0xNF3yGoY=
Received: from SJ0PR05CA0145.namprd05.prod.outlook.com (2603:10b6:a03:33d::30)
 by MN0PR12MB6126.namprd12.prod.outlook.com (2603:10b6:208:3c6::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9275.16; Wed, 5 Nov
 2025 02:05:11 +0000
Received: from SJ5PEPF00000209.namprd05.prod.outlook.com
 (2603:10b6:a03:33d:cafe::18) by SJ0PR05CA0145.outlook.office365.com
 (2603:10b6:a03:33d::30) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9298.7 via Frontend Transport; Wed, 5
 Nov 2025 02:05:08 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ5PEPF00000209.mail.protection.outlook.com (10.167.244.42) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9298.6 via Frontend Transport; Wed, 5 Nov 2025 02:05:11 +0000
Received: from tao-mlse-vm.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Tue, 4 Nov
 2025 18:05:02 -0800
From: Tao Zhou <tao.zhou1@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Tao Zhou <tao.zhou1@amd.com>
Subject: [PATCH 7/8] drm/amdgpu: try for more times if RAS bad page number is
 not updated
Date: Wed, 5 Nov 2025 10:04:44 +0800
Message-ID: <20251105020445.1423034-7-tao.zhou1@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251105020445.1423034-1-tao.zhou1@amd.com>
References: <20251105020445.1423034-1-tao.zhou1@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF00000209:EE_|MN0PR12MB6126:EE_
X-MS-Office365-Filtering-Correlation-Id: 31fbfd6a-4415-4fb3-e61e-08de1c0fc0a0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|376014|36860700013|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?jKx37bHjKV+dIU95+TkQfvEC2z39yEPMXhOTgahcy2WvoMv5Ewjvg4PPnWb1?=
 =?us-ascii?Q?G4Q1X65IgMfjwmFTatwAiJlO0KhG7h6QlPlXaGemHf3Isw+Ac+lJfOSc5+VR?=
 =?us-ascii?Q?XJQhNb1ETVQmPY8XDilpWvfOaex61Rbf4l4H/KS50TU1Bqw6nZQZAxEslb04?=
 =?us-ascii?Q?44Mcs1Zc1kZ6ZYQ+jPqEMrKQA1fDLbzKbiHF4mifNBHI8Eb2T+zkgNWS7FLX?=
 =?us-ascii?Q?ax7uFG0qtJAgrkomIDpuMhL7TVESgT8eGjSIYH8oaatyj9QZY+0bJFe2H6tx?=
 =?us-ascii?Q?vk6Q2fdZ08MtVXj3MVAmef8Uzb/iQCrVUA8lX2p2hMjq7ZV2oCa6h/p5AP4K?=
 =?us-ascii?Q?95FTKKyGhEJy1dgs+in0b2xZVuANo5d49HjQp7EpHq94dzPGnCB+pkYmX3Dv?=
 =?us-ascii?Q?ZfrtTDat+S6a9sYsSkoGtz71crAMVb3oYFvvLe0dPKq0NlbOWPjK11C5qEV5?=
 =?us-ascii?Q?XdC0tIIH25bbiZ4a80Vf1Q4mmPAKuAc6Ut+YySi0fvRYVP/ekHmIM6IYIILv?=
 =?us-ascii?Q?rTbLPbxTjF5YpY6Ql9+zZx0Fnhy6hXm/twQ7zdR/eVCEQ2inSaqTmf0c2tL4?=
 =?us-ascii?Q?uBwbHnNZzozB+h8aqxosgublKPzbL0jAfB4FuzGy5pw7iNGlHDSOFVHhOH+5?=
 =?us-ascii?Q?2GTzugiGwX9sSwfbZdrhT1wEBlYSXL4s+FclhE9G/amMsIoq8CxDjqO7HeR/?=
 =?us-ascii?Q?cSCqAYWfQyTkC21Vw7lfBhTOqlK6wyW4etef1cJtNHVUb4Wgmjg1uAE4LmzU?=
 =?us-ascii?Q?rf7usjyfyta4YRcUMmP8Rryg9esRPAomeeyX3Hb7b+GoNMGz4HjI77J5gIkE?=
 =?us-ascii?Q?Ecq/NWB8vAl1OYubDX37rGKeUZ6U3W4a9KDx5I+J7rofUz796zQQRGO5VqLb?=
 =?us-ascii?Q?wEWj6fbIrJngeWxA0rKBmWynS5Fa/tfF/YfmlEa3hbNxSZW39P0Ls9b4EBRN?=
 =?us-ascii?Q?weP/zNaFqsvmxptM/bDAtPVe31ye8ejneETfIq2yVL3GGnyKNc2vKdizqRl5?=
 =?us-ascii?Q?s+zpzjMEzlfRYNju3ZObLXaG04U1BYKVje8nyBxrmm3Mliwz6O2spnib7ynS?=
 =?us-ascii?Q?EwHiOv/VYiDMIQMFg7C5gD3tTESNVHhgzqVSJncL9KeXX0QGI2Cgr0WQ5uJu?=
 =?us-ascii?Q?YN3t026hq7idR2zge2ZpVll6JwH118JN9oINw9Ij8tkRy7/PxuxgnF2Q5srm?=
 =?us-ascii?Q?hg7WR0T15Ion4JdKTTbV5Zp4bPAWjJtOK0uAZ9MPCXu4qx1HVohE19q+yIFY?=
 =?us-ascii?Q?mBpBn/EahH0C7Ntc1HNu8XJesaT8AQj3MLBkKNLHS3zEShpoXdF8PaiyNaFr?=
 =?us-ascii?Q?+Ceh1R7OP90uDutEaZAFieYedkrGK8emN/rm9g3kZcPeNiRAk42l3HOd4v14?=
 =?us-ascii?Q?rhkRaJDi4fNCHMONMnlC7GXDVQI4Y/Am1M4JXKl9KYYEedtAXKNwNCBxRa0S?=
 =?us-ascii?Q?BHzun9oVY7XoZynPyaHlNoFplINT30UIEFSk1zPzGq+ywGtsdoXOgxeVYzOE?=
 =?us-ascii?Q?zNik4Rn/55ajAGQLk7nlDMhL4ABp8kv6rq0pHxMD6RQ6fz9bjl2PC++DfYVv?=
 =?us-ascii?Q?zJsw/3YsofPyiBhf/3I=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(376014)(36860700013)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Nov 2025 02:05:11.3704 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 31fbfd6a-4415-4fb3-e61e-08de1c0fc0a0
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ5PEPF00000209.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB6126
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

RAS info update in PMFW is time cost, wait for it.

Signed-off-by: Tao Zhou <tao.zhou1@amd.com>
---
 .../gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c    | 22 ++++++++++++++++++-
 1 file changed, 21 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c
index 425aa44446cc..beb504cb4bfc 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c
@@ -874,13 +874,33 @@ amdgpu_ras_eeprom_update_header(struct amdgpu_ras_eeprom_control *control)
 int amdgpu_ras_eeprom_update_record_num(struct amdgpu_ras_eeprom_control *control)
 {
 	struct amdgpu_device *adev = to_amdgpu_device(control);
+	int ret, timeout = 1000;
 
 	if (!amdgpu_ras_smu_eeprom_supported(adev))
 		return 0;
 
 	control->ras_num_recs_old = control->ras_num_recs;
-	return amdgpu_ras_smu_get_badpage_count(adev,
+
+	do {
+		ret = amdgpu_ras_smu_get_badpage_count(adev,
 			&(control->ras_num_recs), 12);
+		if (!ret &&
+		    (control->ras_num_recs_old == control->ras_num_recs)) {
+			/* record number update in PMFW needs some time */
+			msleep(50);
+			timeout -= 50;
+		} else {
+			break;
+		}
+	} while (timeout);
+
+	/* no update of record number is not a real failure,
+	 * don't print warning here
+	 */
+	if (!ret && (control->ras_num_recs_old == control->ras_num_recs))
+		ret = -EINVAL;
+
+	return ret;
 }
 
 /**
-- 
2.34.1

