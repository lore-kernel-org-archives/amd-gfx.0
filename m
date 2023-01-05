Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ECBCBC46467
	for <amd-gfx@archiver.kernel.org>; Thu,  5 Jan 2023 03:23:31 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7C25310E62C;
	Thu,  5 Jan 2023 03:23:28 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2045.outbound.protection.outlook.com [40.107.93.45])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F125510E628
 for <amd-gfx@lists.freedesktop.org>; Thu,  5 Jan 2023 03:23:25 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Fa8I3Bs1NpdoeIevr1OXWD5gY0/JazYrPRb2ntiQiIrQyuA/u6iOmqGB740WfnhhNbsU8ublYhlvINQWGc8C3jpDFJp25J4h30eFmmkeucx5oNHVFKpZ9ZJ2DbJ8FLqKcC9cUmPDGmZx2PKUvNJXqSC9GN6x/u8oNyEJNLlTbjAPj2TL7ID3eXzbxaau9wYfE3VkREynlIaWgK2N9OQaDN9hQcRYAAzdB9pAV4hx+Z0tAupXsQldYPuKe5QmfZOJHvdV/v2pMBWMyrgh/XlqWKfIDF4Dyj5SVA+bJX/lwebdanM6qJq0MIFO3/pJn/o4/WqzVPciwdmx5LZxzifHmg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Vebdeudv/RI9hXSGypmcpzDY7J4hOs7slzF+XMgW968=;
 b=E6Cd0nAzW96Nf7S4kCHvOnZOK94RAIlRdsAeId0zEKaDlE16T39TyCir/QFoIOtUaxBemPUVGw+TpinnNK9J/R3GLqjWKVodnkNon0dXsEhTRlehKejPQXtWIH+kx8odhI+qkHv3piHaVSGo3UOS9UrvW+tmt3kCx71IJemNYIfhojYxolknTYg5qDku8odd0YnohsN/aSiRxLBi/9dV6WIbwMH6bs4ycYpBTdDvBwGNQpooqgPi35ASQlsd9Etm1qSMoDIQvICG/M+6EMI8R6Je1/R5awFOPUU3SEYiA04d+zSKDr/7STsXVtL+5WEsUFcGP6nheZ5hFU0MELfTDg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Vebdeudv/RI9hXSGypmcpzDY7J4hOs7slzF+XMgW968=;
 b=E/NlS74EziCulOsJN0tLInma6bz+XfqvOulBAyUEmgaBmKjhUIecDpKdfg8elvLya0oLwLfMaZdCOODSe+i3aXYwoTrpTiSx03izq1EiB2k7q0CGzcDooFVL1vZ6AruofeQigZ3h+QMbSIPDhIc/n/coOJ6rkjNQfpDwJ3KxHBs=
Received: from BN9PR03CA0428.namprd03.prod.outlook.com (2603:10b6:408:113::13)
 by DM4PR12MB6279.namprd12.prod.outlook.com (2603:10b6:8:a3::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5944.19; Thu, 5 Jan
 2023 03:23:24 +0000
Received: from BN8NAM11FT012.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:113:cafe::bd) by BN9PR03CA0428.outlook.office365.com
 (2603:10b6:408:113::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5986.14 via Frontend
 Transport; Thu, 5 Jan 2023 03:23:24 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT012.mail.protection.outlook.com (10.13.177.55) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5944.17 via Frontend Transport; Thu, 5 Jan 2023 03:23:23 +0000
Received: from equan-buildpc.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Wed, 4 Jan
 2023 21:23:22 -0600
From: Evan Quan <evan.quan@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 4/8] drm/amd/pm: drop the support for legacy sysfs interfaces
 on SMU13.0.7
Date: Thu, 5 Jan 2023 11:22:55 +0800
Message-ID: <20230105032259.2032789-4-evan.quan@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230105032259.2032789-1-evan.quan@amd.com>
References: <20230105032259.2032789-1-evan.quan@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT012:EE_|DM4PR12MB6279:EE_
X-MS-Office365-Filtering-Correlation-Id: 8d2948a7-9173-47cc-bb90-08daeecc33f4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: jATrubKbaF6V6oJY9uTQQTvRXCTevPwIevFexjfSQ/PiaYyKboJ9H4TsgyjQhEyKNN7tIxLC4eFvl/2AFcGasrl+N26QZfjzJUusROhvUt/FEI6yIxUlMvEUYNCB2wZe5zsL8rBTgkn8D50fjYFxjyQeXqIzKisK3RU63tO/UPw97QNPPJj87HS1szYYyP9Pq+XLpVyyu/m4qXmoUt40cXkXhMljmdRKP2fcnlgddze1RusJaH0nNmM0EhstJDa5NKfx1QOn4/FhvZcqWoLrPmEBBNMGhalPDUyNn76fQSrvKRsv4WIwockoHNgmVnEmHZ2SqTv42aZ8pM7zUtWL2pbr9BHNlaUmRU/+ljhpY66QH0NK/+/DEncJF+iOJTeTzs0pk3gcHzOmv4dgFJ3/R2H/pw66gxiSZQKXY2Dlk30KariMzjB8p84qr/dnK+oyS+19RHBL6lBwSdTa3T10fzEUuwaRoDbZx5/jhx6M1YXNfsu2lq4UbQHU+9Z8sM23eZf6Y6un7AZuVmoEw68vGNWSMyjJSkgWYsWKzgT/bfT2hfxheEn6sDvhSR/skSTPfjEKBsUMTx2QOb8YlNdNrDDTFNWnv4szKcO5qAJ4+c9e9dV1rbB0NUVASg9l2B9osUlulWg1JeEf0WdP6W8Zvrv6VeXCakKvYbfncfAzyiEp8YSanF9fdf2G6XTkEsRl7NJs6hlTXUOHPUCx8qCHjjGvhNANRiMDnEmYlWbit5k=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230022)(4636009)(396003)(39860400002)(376002)(346002)(136003)(451199015)(46966006)(36840700001)(40470700004)(316002)(70586007)(41300700001)(8936002)(70206006)(5660300002)(8676002)(54906003)(2906002)(6916009)(4326008)(7696005)(6666004)(478600001)(47076005)(336012)(86362001)(186003)(26005)(16526019)(44832011)(426003)(83380400001)(2616005)(36756003)(82740400003)(81166007)(40480700001)(356005)(36860700001)(1076003)(40460700003)(82310400005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jan 2023 03:23:23.8449 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8d2948a7-9173-47cc-bb90-08daeecc33f4
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT012.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6279
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
Cc: Alexander.Deucher@amd.com, Evan Quan <evan.quan@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Those legacy sysfs interfaces are actually not supported. Their
outputs are confusing.

Signed-off-by: Evan Quan <evan.quan@amd.com>
Change-Id: Iba89f12ae3e79b856d6c0904b371590b6fd0d327
---
 drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c
index e87db7e02e8a..3608540f2034 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c
@@ -1727,4 +1727,13 @@ void smu_v13_0_7_set_ppt_funcs(struct smu_context *smu)
 	smu->pwr_src_map = smu_v13_0_7_pwr_src_map;
 	smu->workload_map = smu_v13_0_7_workload_map;
 	smu_v13_0_set_smu_mailbox_registers(smu);
+	/* Unset those legacy interfaces which are not supported */
+	smu->adev->pm.sysfs_if_supported &= ~(BIT_ULL(AMD_SYSFS_IF_POWER_DPM_STATE_BIT) |
+					      BIT_ULL(AMD_SYSFS_IF_PP_NUM_STATES_BIT) |
+					      BIT_ULL(AMD_SYSFS_IF_PP_CUR_STATE_BIT) |
+					      BIT_ULL(AMD_SYSFS_IF_PP_FORCE_STATE_BIT) |
+					      BIT_ULL(AMD_SYSFS_IF_PP_TABLE_BIT) |
+					      BIT_ULL(AMD_SYSFS_IF_PP_DPM_DCEFCLK_BIT) |
+					      BIT_ULL(AMD_SYSFS_IF_PP_SCLK_OD_BIT) |
+					      BIT_ULL(AMD_SYSFS_IF_PP_MCLK_OD_BIT));
 }
-- 
2.34.1

