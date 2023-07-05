Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3D863EB64DA
	for <amd-gfx@archiver.kernel.org>; Wed,  5 Jul 2023 22:59:03 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5615510E3CB;
	Wed,  5 Jul 2023 22:59:02 +0000 (UTC)
Received: from NAM04-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam04on2045.outbound.protection.outlook.com [40.107.100.45])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C5A0410E3CA
 for <amd-gfx@lists.freedesktop.org>; Wed,  5 Jul 2023 22:58:59 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hUKAQRk4DDwZ/SqFvmMORBrDX1B56CQTo8DcNHnYSbbxR535VjquxzXeRL627cttdci9bZFVViXoRDnLlVbq81T7Ro0leBXSWhxda/DgnSJG5IrWlkaVps8KX7HgjHkjKGioj0UkDdLpSahg26b/iS4It+tMEMIZh39521EbBLuB2els0y0bQ4JO7Qzcrl8kjAc0n6hloLsY4DRrS4uXaQOAcoJg+5tX17mddnOU0mZ5wbiSw4VmJQPdJdLwQ1p0dX0Zc//luCMc1RaWwEqBbvpXx+Nf5+6T6XPnj3NHF1U+aMZM094KpIziHQfi70vofYx+qtSvX7s8SHZs4PeBzA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ky5MOL4pP1dYDE63zXEuXoJ1A6JCEWqWFbqG5lKb3lI=;
 b=BNWhiOQ+mAhkMEfN4/gvlE3re7FA1ZAKreTF06dd8xn1klEPVGtaI9f1FM7kRMQDN1h9ZpF/hkWxlHjMCm6TgHYurwd2F5QxadDcymThOW4xhSpht5x+Ghvo5X019HK0AnaEiZ8fiqiVq6H7L155aKaeRln7mVWwvmWkYt24aRSPu0JSFe0cJVBa3fnzBWTGoXNB4xu5o/85oaTwfElhEZN+CxexN6rQfWehqJMn7KCo+KNe95+KppHxpIBGdxTqXs0CiSIGclAAjjSxRjhu/aEbLlw/SeqZb36uKMJyzAGQeiZGQC+DmnxO/ewnYoSTsG9TiEdPEHloT+4UK8QoTg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ky5MOL4pP1dYDE63zXEuXoJ1A6JCEWqWFbqG5lKb3lI=;
 b=OVtS6uTenV9IFiJQXQFIPEYjSmRLYV0RltgVGp6dndsUsLAZu1P0Li+RD25cQBxX6PjILFdQ1mPhHV6x6/oGP0ECm6rRpuorzTuAw2uK740Ob2y4rokyn9dQC2cwB+wGU6l6F3C1tO6FFJY51U66+bejx9nSdJEVOY6H9RfcIo8=
Received: from MW3PR05CA0010.namprd05.prod.outlook.com (2603:10b6:303:2b::15)
 by PH7PR12MB7018.namprd12.prod.outlook.com (2603:10b6:510:1b8::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6565.17; Wed, 5 Jul
 2023 22:58:56 +0000
Received: from CO1NAM11FT109.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:2b:cafe::50) by MW3PR05CA0010.outlook.office365.com
 (2603:10b6:303:2b::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6565.23 via Frontend
 Transport; Wed, 5 Jul 2023 22:58:56 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT109.mail.protection.outlook.com (10.13.174.176) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6500.47 via Frontend Transport; Wed, 5 Jul 2023 22:58:55 +0000
Received: from eric-hp-elitebook-845-g7.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Wed, 5 Jul 2023 17:58:53 -0500
From: Eric Huang <jinhuieric.huang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 2/5] drm/amdkfd: restore debugger additional info for gfx
 v9_4_3
Date: Wed, 5 Jul 2023 18:56:52 -0400
Message-ID: <20230705225655.299335-3-jinhuieric.huang@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230705225655.299335-1-jinhuieric.huang@amd.com>
References: <20230705225655.299335-1-jinhuieric.huang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT109:EE_|PH7PR12MB7018:EE_
X-MS-Office365-Filtering-Correlation-Id: cdbc57e5-1da7-42ec-8fac-08db7dab6931
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: /PXyYwoV25V9M1H0qjuF17ueCFzrf7CzuD9EKBu6Uk2u8PFqKFwdjaI8I3S/3nhR4EQR3zhwdhg0RVtmwEeJ0IcASdPubiLv7ZsFPBp2o2HlFMP3Jq8IKUWkqEyi8V3vzunpVMph/zoCbyY7/4DU8XLka2H2xm4xKeVZIRQdkm9DY9LJ7w1Xxa4sO/iXbwADIpzlVFvKMpg8E9esXxp54gb54+LYOMJYSvLhw1VEf2lRmB0l2JIglSAoTa/8jWvZ8rEwVsofu46rculEznONRxNhqxz6AcIf4dMhfx7qBRE/47f8hZYXbPYEzcp5FJoDzswVLFIKyktKs4vClk/FrowHxfVb5QF+0Wb2Mn8pfh8Dge6XOvQ5py5Qudch731Xvv0qkbCbNH+Ec2r6PCLcnPwhII6BAvuK3/LufDzdqGFA5r1iGf5GtL9ofR2MDcqzHAXEtg5Sq8F0kO85wOa40GEcM8DLdizYPlYZAFn28JAqAw0YhCvLLOuVucwcAT2jB6p/d5ke8/mejPXVM9bmDaxwc1UaHmoOHbJCVaDIyqmRb4NUvlsHf0EpEcJC3UfkEpa1QRV1iplviC1R9c1ZfV7iN3WG1SGIAViQjkGgPZKThZUixmdYaPrprjtRs0na2gtaeB1fxxHQDolaauGXPeg3Am8MJxcOm9OqeQ7MJq/ezFl08fxvSihcRv/ML2oTQSrNxl3lesy3UDw7XShMUwfBVquIGGXKM8NP+FVj7bTXQsIN2iNafGEKe2fbLQBa9JoBiXJ4y1cX7XkT5pQB+g==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(376002)(346002)(136003)(396003)(39860400002)(451199021)(46966006)(40470700004)(36840700001)(41300700001)(2906002)(5660300002)(40460700003)(8676002)(8936002)(82310400005)(36756003)(40480700001)(86362001)(2616005)(426003)(478600001)(336012)(16526019)(186003)(1076003)(26005)(82740400003)(7696005)(70586007)(6916009)(4326008)(70206006)(36860700001)(83380400001)(356005)(316002)(54906003)(47076005)(81166007)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jul 2023 22:58:55.9386 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: cdbc57e5-1da7-42ec-8fac-08db7dab6931
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT109.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7018
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
Cc: Amber Lin <amber.lin@amd.com>, Eric Huang <jinhuieric.huang@amd.com>,
 Jonathan Kim <jonathan.kim@amd.com>, Harish
 Kasiviswanathan <Harish.Kasiviswanathan@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Jonathan Kim <jonathan.kim@amd.com>

The additional information that the KFD reports to the debugger was
destroyed when the following commit was merged:
"drm/amdkfd: convert switches to IP version checking"

Signed-off-by: Jonathan Kim <jonathan.kim@amd.com>
Reviewed-by: Harish Kasiviswanathan <Harish.Kasiviswanathan@amd.com>
Signed-off-by: Jonathan Kim <jonathan.kim@amd.com>
Acked-by: Amber Lin <amber.lin@amd.com>
Signed-off-by: Eric Huang <jinhuieric.huang@amd.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_topology.c | 10 ++++++++--
 drivers/gpu/drm/amd/amdkfd/kfd_topology.h |  3 +++
 2 files changed, 11 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_topology.c b/drivers/gpu/drm/amd/amdkfd/kfd_topology.c
index 61fc62f3e003..1a4cdee86759 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_topology.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_topology.c
@@ -1932,8 +1932,14 @@ static void kfd_topology_set_capabilities(struct kfd_topology_device *dev)
 			HSA_CAP_TRAP_DEBUG_WAVE_LAUNCH_MODE_SUPPORTED;
 
 	if (KFD_GC_VERSION(dev->gpu) < IP_VERSION(10, 0, 0)) {
-		dev->node_props.debug_prop |= HSA_DBG_WATCH_ADDR_MASK_LO_BIT_GFX9 |
-						HSA_DBG_WATCH_ADDR_MASK_HI_BIT;
+		if (KFD_GC_VERSION(dev->gpu) == IP_VERSION(9, 4, 3))
+			dev->node_props.debug_prop |=
+				HSA_DBG_WATCH_ADDR_MASK_LO_BIT_GFX9_4_3 |
+				HSA_DBG_WATCH_ADDR_MASK_HI_BIT_GFX9_4_3;
+		else
+			dev->node_props.debug_prop |=
+				HSA_DBG_WATCH_ADDR_MASK_LO_BIT_GFX9 |
+				HSA_DBG_WATCH_ADDR_MASK_HI_BIT;
 
 		if (KFD_GC_VERSION(dev->gpu) < IP_VERSION(9, 4, 2))
 			dev->node_props.debug_prop |=
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_topology.h b/drivers/gpu/drm/amd/amdkfd/kfd_topology.h
index cba2cd5ed9d1..dea32a9e5506 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_topology.h
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_topology.h
@@ -32,9 +32,12 @@
 #define KFD_TOPOLOGY_PUBLIC_NAME_SIZE 32
 
 #define HSA_DBG_WATCH_ADDR_MASK_LO_BIT_GFX9	6
+#define HSA_DBG_WATCH_ADDR_MASK_LO_BIT_GFX9_4_3 7
 #define HSA_DBG_WATCH_ADDR_MASK_LO_BIT_GFX10	7
 #define HSA_DBG_WATCH_ADDR_MASK_HI_BIT  \
 			(29 << HSA_DBG_WATCH_ADDR_MASK_HI_BIT_SHIFT)
+#define HSA_DBG_WATCH_ADDR_MASK_HI_BIT_GFX9_4_3 \
+			(30 << HSA_DBG_WATCH_ADDR_MASK_HI_BIT_SHIFT)
 
 struct kfd_node_properties {
 	uint64_t hive_id;
-- 
2.34.1

