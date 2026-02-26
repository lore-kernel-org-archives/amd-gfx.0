Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A1C71FC590C
	for <amd-gfx@archiver.kernel.org>; Thu, 26 Feb 2026 08:13:07 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C5AA810E153;
	Thu, 26 Feb 2026 08:13:06 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="3POZYSCy";
	dkim-atps=neutral
Received: from PH8PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11012010.outbound.protection.outlook.com [40.107.209.10])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 15C3E10E153
 for <amd-gfx@lists.freedesktop.org>; Thu, 26 Feb 2026 08:13:06 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lvqIQqRWIH2GBMfzwCwMlgRCZA0giz5uF7lzUoc+r8IM9aNs9N2fCnbgty/GzspfzonpuAn+EFc1U7DrUZDVKjQWfDP7hu43bHnD0Ofi4xI6dhR5BSWdeVIFgxkssYnZxb5z/9hfnhzWqEDOsiuSsC5OB3FFFdjF5sPObPZyYZcJv6LJD/WvJO921bmFstACcCdbvkr+5pRxpgF3jvB7mu4GJyS+IICxI28yHJs6GuE/a6/cQ7KdgUjxzCavgVlbkRLfeaB3q4MRdEoY/oqmzr5Tp5FZk2+hkcV38WmVktCAs1lRkbzM0t2otwrNzyr/XiziaG6fmDGz629WS+ACrw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0macxYbbhGwRoz8HomO8/Z80fmf+4m17/14WO7wCQI4=;
 b=KCP0/ATU4vAuVRKi2J8QqB57tBttYX/KMH9EDZ7O396L9J1aXDFOxXkHJgMX1UaFMLgZ2AANKgYifliRjZ0bi0JtTtlN54MYwJTOrUI4xZaur0f2OF2hyW24FUr5EKQOAec39BNI0ZZtvvalLMdTOKhWFTekySgLX7z8uJztpyU/ssmskazQal0mJsW7AgCNkAI8va01PSegeE5+MDkpR83Sg+qzNA7JQ4riDhsfrt+8QzZtmElL0jzNItchnbtrXjxGCg3vhk99U9tJtG/oshAogaxf5mqbO8rjXUbdeGRJbzuHWg/YkJGZ8S+UpZJpQZTL5S1XG2RrIsMmdZjFFg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0macxYbbhGwRoz8HomO8/Z80fmf+4m17/14WO7wCQI4=;
 b=3POZYSCyy6wfhSGcyTBGqHB8p2aa8itdkpDQRiybiiaq604uClLkAkJdCztGOM1PuFQB015godHv9A2bHvzkYKADWh25+qF8I3Z7W1lb2jEP44/qZIaJ+a/ujH50uFODlUw6DZaMveP47//JgjdpHwDBJkmZkdw46cj8eon12e8=
Received: from PH0PR07CA0066.namprd07.prod.outlook.com (2603:10b6:510:f::11)
 by PH8PR12MB8430.namprd12.prod.outlook.com (2603:10b6:510:259::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9632.22; Thu, 26 Feb
 2026 08:13:01 +0000
Received: from SJ1PEPF000023D4.namprd21.prod.outlook.com
 (2603:10b6:510:f:cafe::70) by PH0PR07CA0066.outlook.office365.com
 (2603:10b6:510:f::11) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9632.25 via Frontend Transport; Thu,
 26 Feb 2026 08:12:53 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ1PEPF000023D4.mail.protection.outlook.com (10.167.244.69) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9654.0 via Frontend Transport; Thu, 26 Feb 2026 08:13:01 +0000
Received: from tao-mlse-vm.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Thu, 26 Feb
 2026 02:12:56 -0600
From: Tao Zhou <tao.zhou1@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Tao Zhou <tao.zhou1@amd.com>
Subject: [PATCH 2/2] drm/amdgpu: clear related counter after RAS eeprom reset
Date: Thu, 26 Feb 2026 16:12:46 +0800
Message-ID: <20260226081246.465526-2-tao.zhou1@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260226081246.465526-1-tao.zhou1@amd.com>
References: <20260226081246.465526-1-tao.zhou1@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF000023D4:EE_|PH8PR12MB8430:EE_
X-MS-Office365-Filtering-Correlation-Id: 584078ac-f23d-44a4-2b7a-08de750edc2a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|82310400026|36860700013; 
X-Microsoft-Antispam-Message-Info: AWHpWxxfuTqp6CbfvvEDNIMFzdFeFHXa7rxBwLZpY9UGBd5kYSkqyKnBc6gIIX1Xu2O4wamLLl0TqEz6/daRSM4ffjaBUge3I71F21SDabR9HiT+pVyShzpJwYHGOOfttASbB07wt0sT3N4TRAOeXuYeFjzLmaPaYV6NLRQ30IwkUfvyEiuBbR+WIZwp5SCielX7pchGB6byjt5dBTsPmo6cYLNMMdGIw4Euo09ZoBWGT2UxEFW7Md+QmGTlQK3Q20k9GKIgS6AhCB48hPr2Yawz7RDgMh/XglPiQ5RCT29nm8B8oqg8RgiT5u7giPX/rI6F0wqYg1wdulCexxB3MLz3RRYFRrC0JMKUcCHa0RK2y0yEKQ/QnGsS3yqwL3BhCrsFARA2KE2mlYe6eiyFhhqCdaBPlXR8mAJk+KKzUWnz2VBMpFF+N9w4OSleHz3Gq/aAKxmXTPV2o+4u4Gf5xeyu7vQ40rktT+goQTHnDTwpI85gApJE/jfqjTLPZsn3BtdCeVz4iEywmkavPd3PCZJ8oVl9OFkMja2Zf5rSdw81g2YVj+y6hbbrfch5sE2PRTlYo+W5RDQ2nopgq+jHsGiJO1/C8psjDPqZ7DPf5Ct/AObjbVC+mpgBXBv9Miqa0Iadrjv2PtZAKNnwbftvqoTIMUCiroSZ8U9s/BORgDfEBr7iXcPQ2KlJ6d/QezyMTyEmtXvkzAvFZhIJm3hM4p9hniPzDnR3sDMrz1ktyWtHG0o2vwZQPGte1aI5RMF3VjLRW+65SbrgwjZc47ENQa3oL4ueSKlxGo3iWVZtbvoiejFHzstVhxgxeJf+1zE5KPWo/zFmq9I/3SmezFvkjA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(82310400026)(36860700013); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: QJ0Y0FH1O7dR7zsB+TUKMVtR4RwncwRD+BF06x9wGNr0F4GL1zOrgL/+q79VyK8UWZL1LQ6cls3UzrXeCUvAyKWvsP1IPS4IthcrYPvCsBpvcK1evLYmiZMQatTin9SasXDEL75jZxCCcBpuzZzt+fF6H1VFZC8MjQgJJyDhPQmxZL+2WsuD/0G82D+7zEwxrokJCtnZegz+QIesiEYqVbGnLIYaqLBmRjMvn70NCq0vcI8PhwPxSSJBStcbjUt2kqoplgQtfl78FHteUPE/X6Objxh6vhOhd0VxdVqN6cVwG0DdVF2VWIHvzlGyL8bQ+325qWGZ6L1s9XM+juz/lp8+dHMr1kt9/EPrvJXS+OHZtU1t66VdapfpHxLqzNvdrY0vZFnZ/9RScn9ERWYImIUBqGKyhVgMckThMkvRDhi3K/69mieEzw1M7QWqCr+V
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Feb 2026 08:13:01.5580 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 584078ac-f23d-44a4-2b7a-08de750edc2a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF000023D4.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB8430
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

Make eeprom data and its counter consistent.

Signed-off-by: Tao Zhou <tao.zhou1@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c
index 6fba9d5b29ea..44fba4b6aa92 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c
@@ -508,6 +508,9 @@ int amdgpu_ras_eeprom_reset_table(struct amdgpu_ras_eeprom_control *control)
 	control->bad_channel_bitmap = 0;
 	amdgpu_dpm_send_hbm_bad_channel_flag(adev, control->bad_channel_bitmap);
 	con->update_channel_flag = false;
+	/* there is no record on eeprom now, clear the counter */
+	if (con->eh_data)
+		con->eh_data->count_saved = 0;
 
 	amdgpu_ras_debugfs_set_ret_size(control);
 
-- 
2.34.1

