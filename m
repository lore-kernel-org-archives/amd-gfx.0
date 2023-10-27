Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BE9D5C25B48
	for <amd-gfx@archiver.kernel.org>; Fri, 27 Oct 2023 03:41:31 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4191010E90C;
	Fri, 27 Oct 2023 03:41:31 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2067.outbound.protection.outlook.com [40.107.93.67])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A582110E90C
 for <amd-gfx@lists.freedesktop.org>; Fri, 27 Oct 2023 03:41:28 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eG7nzo5rVadZjk/FiLJgoYYHm+Ai9SukqgictnAN1AECYdIWlSB/vmNCbfu/km3/+KM57nlrOF6Y9EbRUYNsmcvOPayjrlNPryNXBtQCU8olRxEzL152o35FWwKC3vf08e6VksJuso6BNq/UNdM9dJ2iZTix/S2Wm20lqBjqyjVzgiMTy2MFqCkWmLvu0zTA84x7Rdc7TrLTrY4jA9y+mkMJ/USIJI4xzFDeDfzSIk8fbT0nrIMCMu1GoR7qItXEzOLnCcgYndbyrpMEaLrQgNJzY/QPP/weFDFdIjHatExqSup6/bQ5JqMq2ymSPwvvsSr2NpS6EI2e8MTW628LgA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=d9NN+f8gl7UFpBXquJuMYurjKFVw+xpSz2J/mPpKKBU=;
 b=fgXVJE4RB+6GUIQhzslshzizDNva1qy69ENqjEAhpwTLKMjTKgJ3iB6OZhYfnILrQFb16QwiHVNp+aydH7M/LnMjxgsEFudqkXTDX8NQLPygOYdG6yrmGNGm/3WG7n/S909+E/Nro30kxVMqu7gR4E5NynJaVmXpb/OIMK0MxrhrwEX8GJMCh8ca3cO2wOEEwJE6RZ0Pk6Kvdjsa9ymhlkQxKCFVtcuHBcn7MYtAlXZrnSjzNirUmhddoh9nGccMpOoNDhpobI7kKNDKoDdkHoKEuvPMhjEdI/CwJxoV6WLXATTLv2cwcBwMTuRGNoRpDCZB2Wr5I7F/+Ju36lECXA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=d9NN+f8gl7UFpBXquJuMYurjKFVw+xpSz2J/mPpKKBU=;
 b=YNV71iv7AVS6vXTo/tiTjIU5OdtZ5w3tubNS8cA++sugiVLzWS9XGHR++6voyhfg7ToLs3PBSVLHwubpCEJBFLTxdoDND9EBD9YaOQQetq4t89WBsSQpO1YVIYZ8uZA5GHZdXqIpVhsvbPRWhTceikNzUhzWSPKxaxi+to7wVjg=
Received: from BL1PR13CA0445.namprd13.prod.outlook.com (2603:10b6:208:2c3::30)
 by CH3PR12MB9145.namprd12.prod.outlook.com (2603:10b6:610:19b::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6933.22; Fri, 27 Oct
 2023 03:41:26 +0000
Received: from MN1PEPF0000ECD5.namprd02.prod.outlook.com
 (2603:10b6:208:2c3:cafe::55) by BL1PR13CA0445.outlook.office365.com
 (2603:10b6:208:2c3::30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6954.8 via Frontend
 Transport; Fri, 27 Oct 2023 03:41:26 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 MN1PEPF0000ECD5.mail.protection.outlook.com (10.167.242.133) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6933.15 via Frontend Transport; Fri, 27 Oct 2023 03:41:26 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.32; Thu, 26 Oct
 2023 22:41:25 -0500
Received: from amd-SYS-7048GR-TR.amd.com (10.180.168.240) by
 SATLEXMB03.amd.com (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.32
 via Frontend Transport; Thu, 26 Oct 2023 22:41:14 -0500
From: Tong Liu01 <Tong.Liu01@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amdgpu: add unmap latency when gfx11 set kiq resources
Date: Fri, 27 Oct 2023 11:41:11 +0800
Message-ID: <20231027034111.319751-1-Tong.Liu01@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN1PEPF0000ECD5:EE_|CH3PR12MB9145:EE_
X-MS-Office365-Filtering-Correlation-Id: 281a7ac0-9a9e-41cf-4c51-08dbd69e9912
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: GrL3j5OEkMZTq0qgsUU6VkAGB+TdAd4NYX72vk02Is+bfLrQGnOXWVfvtbvrR2t/cPFCw+B9JoxXk6aTtVECsQEihjbHpB7Pxg2EN+/DA0m3MejCiJbZZrk5A7+mVhAFKgCTa1lb/aRYPgLmH/PH14XzlHdAFr5f1SxLeDvUKHZQT/o8mF2FJzl7ud/lTj2OLWw/ODUMNqWwzH9MkEEqOZLuLghLUb+/dfFwvuc+BlcU/iVmryrzKu57mC3OQvhJ+JMgcLl4i3PHJGIwTp8o81BVEAeNGpaYlgI89utBM619VwbA4CAison1LBb3dSFdPIBTk4vCaeKFjfi6kYUoR8znO7Q43FRG7PN0zABr8bR3w0f1QVO6sYClBFEhfNKTh8PjlZetTWe0JPPXPbGYAH7JDL8pw8bYFjUhuq7MAENxIlWQMDWZQM904ar1XXI5eE3CThrFqmPuUPpdkiCaxCxEk6bNRniBS7INHPomDgHmjQmWNy7PYLOZaLYnl7lTGrRflEfH7vPAKCZ6mjA9dhRif93Xx8sz+bE3fwBuOilfsKoLbgiUtCn0KAGtNE3cSjDpullrRBQiY9MWLHD5ZAB4mMX9c44XTbV6Nc7x6tnPa/IFO+TgnuGPnABeU0obBFBAWMk8RT1xHyxjgww2ZGcihyinX8LIDP4IcGLonCZYkbeuHx5I0NrKma7DGXOGAdUKKe/wOnlJGU05NViWAXm7GtSmIR1NsOOq4UQRTQarVM6apVYCuumJgdZ1+TG2DfVqHovoS+/hQK5QAPK5hg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(376002)(346002)(136003)(39860400002)(396003)(230922051799003)(82310400011)(1800799009)(451199024)(64100799003)(186009)(40470700004)(36840700001)(46966006)(82740400003)(2616005)(41300700001)(426003)(336012)(81166007)(356005)(5660300002)(1076003)(40480700001)(4326008)(26005)(8676002)(8936002)(478600001)(54906003)(6916009)(316002)(70206006)(36756003)(70586007)(7696005)(6666004)(40460700003)(86362001)(2906002)(36860700001)(47076005)(83380400001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Oct 2023 03:41:26.3878 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 281a7ac0-9a9e-41cf-4c51-08dbd69e9912
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MN1PEPF0000ECD5.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB9145
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
Cc: Jack Xiao <Jack.Xiao@amd.com>, Feifei Xu <Feifei.Xu@amd.com>,
 horace.chen@amd.com, Tong Liu01 <Tong.Liu01@amd.com>, haijun.chang@amd.com,
 Tuikov Luben <Luben.Tuikov@amd.com>,
 Deucher Alexander <Alexander.Deucher@amd.com>, Evan Quan <Evan.Quan@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>, Monk
 Liu <Monk.Liu@amd.com>, Hawking Zhang <Hawking.Zhang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[why]
If driver does not set unmap latency for KIQ, the default value of KIQ
unmap latency is zero. When do unmap queue, KIQ will return that almost
immediately after receiving unmap command. So, the queue status will be
saved to MQD incorrectly or lost in some chance.

[how]
Set unmap latency when do kiq set resources. The unmap latency is set to
be 1 second that is synchronized with Windows driver.

Signed-off-by: Tong Liu01 <Tong.Liu01@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
index fd22943685f7..7aef7a3a340f 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
@@ -155,6 +155,7 @@ static void gfx11_kiq_set_resources(struct amdgpu_ring *kiq_ring, uint64_t queue
 {
 	amdgpu_ring_write(kiq_ring, PACKET3(PACKET3_SET_RESOURCES, 6));
 	amdgpu_ring_write(kiq_ring, PACKET3_SET_RESOURCES_VMID_MASK(0) |
+			  PACKET3_SET_RESOURCES_UNMAP_LATENTY(0xa) | /* unmap_latency: 0xa (~ 1s) */
 			  PACKET3_SET_RESOURCES_QUEUE_TYPE(0));	/* vmid_mask:0 queue_type:0 (KIQ) */
 	amdgpu_ring_write(kiq_ring, lower_32_bits(queue_mask));	/* queue mask lo */
 	amdgpu_ring_write(kiq_ring, upper_32_bits(queue_mask));	/* queue mask hi */
-- 
2.34.1

