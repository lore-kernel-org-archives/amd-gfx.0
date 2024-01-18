Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DAB55C47DAF
	for <amd-gfx@archiver.kernel.org>; Thu, 18 Jan 2024 14:34:59 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E0EFF10E82E;
	Thu, 18 Jan 2024 14:34:58 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2074.outbound.protection.outlook.com [40.107.243.74])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C8E2810E81B
 for <amd-gfx@lists.freedesktop.org>; Thu, 18 Jan 2024 14:34:53 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jHCyzH2yY4/1z5Udd9VxvOMEsxjQtOGhDe2vh4EVISqjgNYH+PR9BSuVuh76Vs8HXpuGShc0zQUHrqw6oFAf7trBY1QYwZ/JlBhjfMXUqPhSNZJ1ScBx0Z+pBHjY1moVNkOhukAe1QBZUCrSeGaiNbIh4FEPDbFZUppREUZqAJjFi4GysHjR0k+zudtTTH+W52yb9QfnQi09icZTiXw8EKwQIpYN6AgHU8oe95iaOuImu1gSke4XC+yZ50F4RsNSqi/CC+aYwbdXPzo/1JF7vpJIbOljy0Epi+JiRsF1qhUR8YYOG+MTgBsCC5FBnRTnXS9BN+lQAebHvzTG5q8WLw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VhkY9SfDJnmoYO28nnSVDG4sV7uzOhwYqtEiQG8l20Y=;
 b=oKbfgmkQSbJnSThNk5q9kPQjSVCW50j9Q6tpnp9RqS39s2h7UIO6i3/OdgbwIckTz6fHxK3+1JN0vRcYv6T/M0Jr8D3gN9MZU2iBI2Ebv8jOKT0moDreOL3yuOySPOosKJPhOAjJ/dleFOiysWI9I2ODfY0lcNeoOV21iKZMTjS9YycfgGLQB6YqadKGsQ4QpoEGFxieCKHDQ9ksjYw0ueTwGjUGvt8W3zcV1V1LHcqAf9OAD1N7TuHXWp0+4mPnBrJL/J4eRp3qFIOu3q4BBOe5E2D+oybKpTmnQ8uIsPlwI8DWY0cfN18VwXdAeZSjuM0IGYS4yO3bB1sFgiG34g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VhkY9SfDJnmoYO28nnSVDG4sV7uzOhwYqtEiQG8l20Y=;
 b=QytDuRArygglx/K+YW2PXCgEiqjmbSDmO88q9yaTDy0J/pZNyHKDc96fpPBsF/F5GFBonQlQbPXZkDGihe+1SPnh6zG7iEUIHHBwufoA+ynUUIEAQwpw13lrxCTcNVRupsh1vZ5qediYTtM+CLci0TJC1A+sGHXoJZNhHIZYI4E=
Received: from PH0PR07CA0107.namprd07.prod.outlook.com (2603:10b6:510:4::22)
 by PH8PR12MB7422.namprd12.prod.outlook.com (2603:10b6:510:22a::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7202.23; Thu, 18 Jan
 2024 14:34:49 +0000
Received: from SN1PEPF0002529F.namprd05.prod.outlook.com
 (2603:10b6:510:4:cafe::a8) by PH0PR07CA0107.outlook.office365.com
 (2603:10b6:510:4::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7202.24 via Frontend
 Transport; Thu, 18 Jan 2024 14:34:49 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 SN1PEPF0002529F.mail.protection.outlook.com (10.167.242.6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7202.16 via Frontend Transport; Thu, 18 Jan 2024 14:34:49 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Thu, 18 Jan
 2024 08:34:45 -0600
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Thu, 18 Jan
 2024 08:34:45 -0600
Received: from roman-vdev.amd.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.34 via Frontend
 Transport; Thu, 18 Jan 2024 08:34:44 -0600
From: <Roman.Li@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 11/12] drm/amd/display: [FW Promotion] Release 0.0.201.0
Date: Thu, 18 Jan 2024 09:33:59 -0500
Message-ID: <20240118143400.1001088-12-Roman.Li@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240118143400.1001088-1-Roman.Li@amd.com>
References: <20240118143400.1001088-1-Roman.Li@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF0002529F:EE_|PH8PR12MB7422:EE_
X-MS-Office365-Filtering-Correlation-Id: 6719123e-bfad-4294-cfce-08dc1832a047
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: iy3Zl7dXMfdJ213rPLKvwcdq2iXconMOhejqifhgF1r6JNgFFHgVRaIKrfo2TV4aYltPW0QZoj7rhH6ccbKMAOef6f/dYgPWk3BXbGwR/7qrJRXe6kuEBBSF+GLdnlkUDjPA7Clh2YvGgvo2a8bWzXg/31n1u7FOiC79M0XlOl3oRzVdxAd2YPFhFOLjxyee7kIr91cuXgmVZ6ZRmNU95FPNXeelVbs1lDNbLkVnn5LHSJUdrexdsUeQRjqnaNqZaASZkTPbFRtxl+BeESb9Om5R0cOdpxzH+z8xWPEsNkQdmaMpP9oXOX5+QMIrYvSgtaRbd13ka1KPPgjponBCP9chNhyd5G/LtzX3nWEbUn6vSRK/e9eWpjGo6CPPlIWc4FT2LPfNaEcprRsIZu+y6oV2l5rdcgdo7N0DdfDxt7vvivl8rrXQcuPr592BLqADnb4NS0Y+vlMTWYkCrITnOKkBHWOvbhtExPM+l8UBo9O7slux7cmzA2t48sgzkB9gwCUgow7OBdnyAPyZfA1VYReByLlmYDjPxa8sJ4G2rHnTBvZrOoTksh/KmoiEXMSq0YJ46+jXW91A5xkRx0m6iaM+0ZjgNeXsuI0Pgo8wiL4Kg80OCNI1K3P66BcauWgDbW6RP9VbiVDJiwUb2bKM7V3AWfhmu5u4y+826R+heEK0d9f0374aJD1wVpgZsBaREMtRG52nMKLLDs86qtYSmjI5jSsoCHQP7bGVwt05BES20wr4Zh38y6c8tACst/Yd+MochvTuPk090eyzYptGAg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(376002)(346002)(136003)(39860400002)(396003)(230922051799003)(451199024)(82310400011)(64100799003)(1800799012)(186009)(40470700004)(36840700001)(46966006)(83380400001)(1076003)(2616005)(40480700001)(40460700003)(26005)(478600001)(5660300002)(336012)(426003)(86362001)(54906003)(6916009)(316002)(6666004)(70206006)(70586007)(7696005)(8936002)(8676002)(4326008)(47076005)(36860700001)(82740400003)(36756003)(81166007)(356005)(2876002)(41300700001)(2906002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jan 2024 14:34:49.5635 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6719123e-bfad-4294-cfce-08dc1832a047
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF0002529F.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB7422
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
Cc: chiahsuan.chung@amd.com, Sunpeng.Li@amd.com,
 Anthony Koo <anthony.koo@amd.com>, Rodrigo.Siqueira@amd.com, roman.li@amd.com,
 jerry.zuo@amd.com, Aurabindo.Pillai@amd.com, hersenxs.wu@amd.com,
 wayne.lin@amd.com, Harry.Wentland@amd.com, agustin.gutierrez@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Anthony Koo <anthony.koo@amd.com>

 - Add debug flag for Replay IPS visual confirm
 - Remove unused debug flags that should not
   be controlled inside Replay FSM

Acked-by: Roman Li <roman.li@amd.com>
Signed-off-by: Anthony Koo <anthony.koo@amd.com>
---
 drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h | 13 ++++---------
 1 file changed, 4 insertions(+), 9 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h b/drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h
index e699731ee68e..89717076933e 100644
--- a/drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h
+++ b/drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h
@@ -403,17 +403,12 @@ union replay_debug_flags {
 
 		/**
 		 * 0x400 (bit 10)
-		 * @force_disable_ips1: Force disable IPS1 state
+		 * @enable_ips_visual_confirm: Enable IPS visual confirm when entering IPS
+		 * If we enter IPS2, the Visual confirm bar will change to yellow
 		 */
-		uint32_t force_disable_ips1 : 1;
+		uint32_t enable_ips_visual_confirm : 1;
 
-		/**
-		 * 0x800 (bit 11)
-		 * @force_disable_ips2: Force disable IPS2 state
-		 */
-		uint32_t force_disable_ips2 : 1;
-
-		uint32_t reserved : 20;
+		uint32_t reserved : 21;
 	} bitfields;
 
 	uint32_t u32All;
-- 
2.34.1

