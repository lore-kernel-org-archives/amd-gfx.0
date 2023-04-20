Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B3384C77B76
	for <amd-gfx@archiver.kernel.org>; Thu, 20 Apr 2023 23:50:51 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2710510ED5F;
	Thu, 20 Apr 2023 23:50:51 +0000 (UTC)
Received: from NAM04-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam04on2054.outbound.protection.outlook.com [40.107.101.54])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EEEFD10ED57
 for <amd-gfx@lists.freedesktop.org>; Thu, 20 Apr 2023 23:50:48 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Y3i2L7kVZxdpvCGPVXuij/TkhDHjHALU194xYZ9aM+mjscmb6PtKyo9qCy2javsGqsMLEtF2DxlO7XhGSyGFq40m08Qz/4Iy1HA1jEtBYcsQlw8Xb2bX/Qj/LzcdLtVB+abGJhrvvtKzCDzpigoKklgy/lCB4GrfDmGDfxwgPkRLDQQ/5hnLTFoiuAtC4X92Pd5Tq58XMJmo0LUAGAqjbMN5FyVuzMAEMQ9PlRbP7Xfoao9KvDA9L0Mw9goAkhR6iZJhYE0v4kMFJ7tqY5Ntl5mGej3N/G7oogK32NcH2LNV2IdR7esTnYSSuiLYsditXe9e8WK9YC0lORZvFkE3SA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=y09aSorYOTNlSgVTtcrgSOHSVS8svR4k7fVdEX/f/4Q=;
 b=X+yEvMbGZzbaaH49U1BJye13uDpLkKmh7495SQqptJ1SUrfiavY7j4u6/dFH5mlAk25ex81hU2QP1mUefkcCZkdMk1P2XxSkTyfK17nZv7ZMj0D/jP64sy+K6ahEpGu20TVMdYGtPYKOJjRYYIaYgWIb52bYs5M/M8akOry8zgIa9yz9YZ/SElwbPenQxAQNqzmT96zaSk297v2QmkUZZWTAcTorH/KTMn2g4rqV7zX7qAD8RW5j/6alSn3GufRhgVfa2XGV+GPNmMEOofTJEj8gKiccelG6TEB5nwKzw+fzXsyg3/ikRF+Mcy7bhmOc7MVCN8QobXjrwRBnlW4icw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=y09aSorYOTNlSgVTtcrgSOHSVS8svR4k7fVdEX/f/4Q=;
 b=ufOvdcL3rXdtqErcdESemK1gBqWveIqoX15UijY2uYB7463Xxe1gfp+GHR4FFLq56EZPq6iV65Zcfzq4xHiJx5YLnVRTcu1jUzFN+Peouy5cForxYF9TnXxYMsWap+uGegg9Y7/bnTU94OhO4DDVN2lKeCJc6Rw+TNMTWlcNQeY=
Received: from DM6PR18CA0018.namprd18.prod.outlook.com (2603:10b6:5:15b::31)
 by DS0PR12MB8070.namprd12.prod.outlook.com (2603:10b6:8:dc::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6319.22; Thu, 20 Apr
 2023 23:50:46 +0000
Received: from DM6NAM11FT017.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:15b:cafe::f8) by DM6PR18CA0018.outlook.office365.com
 (2603:10b6:5:15b::31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6319.25 via Frontend
 Transport; Thu, 20 Apr 2023 23:50:46 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT017.mail.protection.outlook.com (10.13.172.145) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6319.25 via Frontend Transport; Thu, 20 Apr 2023 23:50:46 +0000
Received: from smtp.xilinx.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Thu, 20 Apr
 2023 18:50:44 -0500
From: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 21/21] drm/amd/display: 3.2.233
Date: Thu, 20 Apr 2023 17:49:51 -0600
Message-ID: <20230420234951.1772270-22-Rodrigo.Siqueira@amd.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230420234951.1772270-1-Rodrigo.Siqueira@amd.com>
References: <20230420234951.1772270-1-Rodrigo.Siqueira@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT017:EE_|DS0PR12MB8070:EE_
X-MS-Office365-Filtering-Correlation-Id: 3051bbcd-a162-4340-1bda-08db41fa0fe2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Ex/vun/BNe3EC+fnQviY7cZIby+DwVWk+CXFeVaXSGd4ecCpuDt86noWiNzVfhw/LFuc9nvgT3pl1fVDG6x84iaG408K1YjRBGwoFPv94ybALopLZTy3orFCjvhOmeO1AZ3lWBD9xbaoCy/ORBumLdTe1dtTaUPm8k2VaLy5a07Q4uoRYfAETC3lq/j1PVfT+610ZFDmfTye0XOmyD3w7yub5g6LzMM5K8XRpGvEIKMvAIHG0ZH9mv9eUUq2qfUMnjWCwIrJ0KUX8qNTenG2HuOjIaB37fuQqclVUnMSntQusoV/zAobjrsMkje328AFSV/8BIrFf/y0oC5LoRSfkhn45Y9LZUMFFzqSUcWMEoYZBw2ZGRHAo+PFWWU/CbyUyJxlesWSqfe3ibPBjE9vpxZrQoO1KYosLi+RWrfcwZUOvl+xwTLpCnJ8uGT9Q8vHXm+GwE0iVIs1yQ3QmLZUr7QpDWhztIE9SS28TaUtQGvqIm8r7gv79VHpy4vsSTWP9pZN8nhPTcrQB/Cgd/kgTbllNAKrUPiXNIqBqJ1WFZcWtiWJm9iiIE5nRTOHeQmEbWTy5NGCTTgGBmD66urhoNCdA+dERYWmO3NVACm9OYGt0HEHKZkbg+syMpr65ZlwE+CbMMBb1Tx5fhzKvmuAE8IKGB2uKPoiBI/Ny6vRrAXBOt+xhUsuJpbrfwjDWex6fkMmf5RQrq8XGYZemNn5Q5gaQs4BIxKAN3mkcokiAzY=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(346002)(376002)(136003)(39860400002)(396003)(451199021)(46966006)(36840700001)(40470700004)(86362001)(82310400005)(356005)(81166007)(82740400003)(47076005)(36860700001)(2906002)(83380400001)(4744005)(426003)(336012)(8936002)(8676002)(5660300002)(2616005)(316002)(4326008)(6916009)(41300700001)(186003)(26005)(1076003)(36756003)(40460700003)(70206006)(70586007)(6666004)(40480700001)(478600001)(16526019)(54906003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Apr 2023 23:50:46.5756 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3051bbcd-a162-4340-1bda-08db41fa0fe2
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT017.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8070
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
Cc: stylon.wang@amd.com, Aric Cyr <aric.cyr@amd.com>, Sunpeng.Li@amd.com,
 Harry.Wentland@amd.com, qingqing.zhuo@amd.com, Rodrigo.Siqueira@amd.com,
 roman.li@amd.com, solomon.chiu@amd.com, Aurabindo.Pillai@amd.com,
 wayne.lin@amd.com, Bhawanpreet.Lakha@amd.com, agustin.gutierrez@amd.com,
 pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Aric Cyr <aric.cyr@amd.com>

This DC version brings along:
- Improvements in the SubVP feature
- Keep disable aux-i delay as 0
- Add p-state debugging and improvements
- Fix in secure display context creation
- add option to use custom backlight caps
- Lowering min Z8 residency time
- Restore rptr/wptr for DMCUB as workaround
- Update FW feature caps struct

Acked-by: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
Signed-off-by: Aric Cyr <aric.cyr@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dc.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dc.h b/drivers/gpu/drm/amd/display/dc/dc.h
index f52ab717ac7d..4424e7abb801 100644
--- a/drivers/gpu/drm/amd/display/dc/dc.h
+++ b/drivers/gpu/drm/amd/display/dc/dc.h
@@ -45,7 +45,7 @@ struct aux_payload;
 struct set_config_cmd_payload;
 struct dmub_notification;
 
-#define DC_VER "3.2.232"
+#define DC_VER "3.2.233"
 
 #define MAX_SURFACES 3
 #define MAX_PLANES 6
-- 
2.39.2

