Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8456DC54E5D
	for <amd-gfx@archiver.kernel.org>; Sat, 16 Mar 2024 16:50:32 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0B4AC10F713;
	Sat, 16 Mar 2024 16:50:32 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="MFurRXMC";
	dkim-atps=neutral
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2050.outbound.protection.outlook.com [40.107.244.50])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1EE0310F711
 for <amd-gfx@lists.freedesktop.org>; Sat, 16 Mar 2024 16:50:30 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=P75lQ2tDesGKigDUgtobmMgzhJz6WTMsw3iR7aiuh4auj8r7z279y2ow8v1qjDmwEWHZgPWO6AL8oiQZ/60sKwVmUEMcZ8yu2ErpW87EAzS2HadtuMSKr7Ci1Y1RAz5h5YeA+3vozuzYATpXstBaU+BBMS0dYZc8XpBobVSEymqvrbFI910yu+cLl7yC7VErGO3kskvUWJGOPdv8IC1F40rLXsmcgl8/dChLWRXCmcf2ChXQSh8ue6Re1n9BUovofmqgvONj2cEGfC0pXRyvl5fozxk5sB0fsU7F/Oqs4cCL6HtK1cigB6PohBuv8IOkA0ki+/DEZdD8i6pVNQ0qVQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kQK2+lsMIobkNvIIP372dcYGWnS4kf+BbsokTX0e8gs=;
 b=PH7Ejy9VImqs3sTt7Fkn+Xd43dfMGS6zK/LiuMyVbwsvIfCNtQ1vA5wnDzqoP25gfpoI9qkG9Mhlb3Jk392U/A8Q5LKq94yrvseLxVWjrKcilktld053Pad+Mmnj+eOGzPFrPYOBTIE7+PIpnwGplDtvuLoduI9YLOHzPXLNMqMoHIWq36ja1RijhSmBWz2ZlPQAalnX1V3E5DMZB994ip7TfZMr8gqbAIbWFRyhlk3YO1aAl18Gi4R5DZ3tzSzVVBYAAupI8p+zbMksCddnszu1jJJrmP0k6FEKzWyBGOib5COFs2PqknehHIcXSqcoKRkXvMyW/x3eV2vMUs1nDg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kQK2+lsMIobkNvIIP372dcYGWnS4kf+BbsokTX0e8gs=;
 b=MFurRXMCAs4GqnQ0Zdh+DrzfuIB+KGHZlMsgq93LaSUNs7dwXLXQaOj5IfGvmB64a1NqC/9XAKG+THHu1ZBLI9KK3rP7A4MZMYOH3RPQNkNuCisbzZGfF7U4k6Zrs+IakMuMHtlYLoEF9gOUckr/PNtAfPcvb5t46W1B4WNd/qw=
Received: from BY3PR04CA0020.namprd04.prod.outlook.com (2603:10b6:a03:217::25)
 by PH7PR12MB8037.namprd12.prod.outlook.com (2603:10b6:510:27d::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7386.23; Sat, 16 Mar
 2024 16:50:26 +0000
Received: from SJ1PEPF00001CE3.namprd05.prod.outlook.com
 (2603:10b6:a03:217:cafe::2e) by BY3PR04CA0020.outlook.office365.com
 (2603:10b6:a03:217::25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7386.23 via Frontend
 Transport; Sat, 16 Mar 2024 16:50:26 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ1PEPF00001CE3.mail.protection.outlook.com (10.167.242.11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7386.12 via Frontend Transport; Sat, 16 Mar 2024 16:50:26 +0000
Received: from srishanm-Cloudripper.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Sat, 16 Mar 2024 11:50:23 -0500
From: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
To: =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>, "Alex
 Deucher" <alexander.deucher@amd.com>
CC: <amd-gfx@lists.freedesktop.org>, Srinivasan Shanmugam
 <srinivasan.shanmugam@amd.com>, Lijo Lazar <lijo.lazar@amd.com>
Subject: [PATCH] drm/amdgpu: Fix truncation issues in smu_v13_0_init_microcode
Date: Sat, 16 Mar 2024 22:20:10 +0530
Message-ID: <20240316165010.1378112-1-srinivasan.shanmugam@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF00001CE3:EE_|PH7PR12MB8037:EE_
X-MS-Office365-Filtering-Correlation-Id: 007c38e9-9a74-4bb3-7bed-08dc45d92e07
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: djw9kYqdRNDc3WXFsLBMQAg+18Ukqcz8uXZFYow5SeomBawRxjZvZgj2N+1vXDFlIfZ3+DgIfoZiZPszJ7EjbspHuA3cb1+gr43UmsypVUCtTr3jFzS1YLAwUkVIdvDcppDyGQGal9HU8i9KdR3jHY8heSnBZSZIdlsacMUeErqBcMZDm0mvBfMazScPixrpvgX0ewBOpRnhO7xHpSUf+va7UymvATMJ7AA5devmAoWvk7ncG7eImElbNCb6ebC9mAccSQ62Lw6TP8UMzGfRqVnkP8/Ok/Wiu+JM8kZlDLKRkS1FvIdiCQ5K48BOiMXlCLkWJeeFFchjAr0W83MJ8WZhH5pe/dUAhMozkKRc6TeaVsaHq2ODqCsV8PGItskf6iX6AGhCAmHl8HsY7gpHHpiB8t+si/OMtSRYhSAN93FTq/kmYj6refg/53k8SPBdFwc8gXuAT+udnQz+iFq+rEtxxf5G9MyBZ/yxYNQJe+npq2xFVFn9fOnNBMLnPs9X9FVLI7Au08bdxaXTdnWsXC0l+AeZSQopYgLz188WVJMwGJRaHiDiTx/Lzw81AoYrpvezTyUbfguh1qHFqoCyaqB7ifVJ4L7pqg7PQOD6q3iYbNiBK+4JFl6PWkdldQyPthBqWWNyAL77KnpJMlTwcz77TRM0O9PKJ5k7pffgDMkF1IY422gTrO+jagX4GeRlNXLPYXLGH0Rd5tphK5JDTzvDDwykuZ/WAA1pCAeqMIb6WIbdzmqhGpZEEdnukLAO
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(82310400014)(376005)(36860700004)(1800799015); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Mar 2024 16:50:26.0979 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 007c38e9-9a74-4bb3-7bed-08dc45d92e07
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF00001CE3.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB8037
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

Fixes the below with gcc W=1:
drivers/gpu/drm/amd/amdgpu/../pm/swsmu/smu13/smu_v13_0.c: In function ‘smu_v13_0_init_microcode’:
drivers/gpu/drm/amd/amdgpu/../pm/swsmu/smu13/smu_v13_0.c:108:52: warning: ‘%s’ directive output may be truncated writing up to 29 bytes into a region of size 23 [-Wformat-truncation=]
  108 |         snprintf(fw_name, sizeof(fw_name), "amdgpu/%s.bin", ucode_prefix);
      |                                                    ^~       ~~~~~~~~~~~~
drivers/gpu/drm/amd/amdgpu/../pm/swsmu/smu13/smu_v13_0.c:108:9: note: ‘snprintf’ output between 12 and 41 bytes into a destination of size 30
  108 |         snprintf(fw_name, sizeof(fw_name), "amdgpu/%s.bin", ucode_prefix);
      |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Cc: Alex Deucher <alexander.deucher@amd.com>
Cc: Christian König <christian.koenig@amd.com>
Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
Suggested-by: Lijo Lazar <lijo.lazar@amd.com>
---
 drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c
index 48170bb5112e..ce16f2a08a47 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c
@@ -93,7 +93,7 @@ int smu_v13_0_init_microcode(struct smu_context *smu)
 {
 	struct amdgpu_device *adev = smu->adev;
 	char fw_name[30];
-	char ucode_prefix[30];
+	char ucode_prefix[15];
 	int err = 0;
 	const struct smc_firmware_header_v1_0 *hdr;
 	const struct common_firmware_header *header;
-- 
2.34.1

