Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A9F56C77B7D
	for <amd-gfx@archiver.kernel.org>; Wed, 17 May 2023 16:18:35 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4602310E450;
	Wed, 17 May 2023 16:18:35 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2065.outbound.protection.outlook.com [40.107.223.65])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AC74C10E450
 for <amd-gfx@lists.freedesktop.org>; Wed, 17 May 2023 16:18:33 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UeeYe3zpDGDcAG+UeKcFpr8ZIyiDlu5fyUxNhy1n1/1LLukVsK4Gz2FYJWsx+JbMp/lqY8yV+N8G+8bfbgBS04lu3acj4/lEN7lVLvLjzCHcjbZ2LJmsW2C9/79nbc4Et+bVHXrsHXQFn+B96HUR7c/zn4roQofbXMBW3GBwTC2iEgqN+DrwadYZU2nyugRhXXzZRWxOS9WkUnqivRsk7ai3D+dx9xqOFzy67sPHbsiSIkeCBalEWRYdBryMLyD5o+wrWO+V1YTq1EngdxuBIUBiqtDq/venNOQ3t1+rT/JMMjGyLbXOZKCPlphywJVMLTUsDcj3ouzPrEuYC5N+bQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZkwCCj8IHyOY9HkuURrZfvFiGrfuhMm+w2IDGib1ks4=;
 b=PdWAL15Ur6MYI6GHHjtJLqCso8+o3N/wdNBrGvsQ9xGd39q0G4/0LRhwAFTE2xf9YP7F0ztR1aB318L6Gi7l/wpoHOSNymjIHRqLzZsdVd9lywU9ZNyABDNbRh1Gd9h7F9mgEZoPqU7okG6DxkYg/6QtXau2rAxHLexR5QoT+omaBnhZmNj1LPi3bLs+TkNfp9QvAz/TtsmFBcXGrOZgLkhu5VXBTptBanTQv130zpFC1RCHciBSNFkpJLUsSiu3dS+4rxUqx5nyaniQBNo9ajMJ8t+xKgxyCfEc/Tcjx1mn6PP3hd/7d/yvQAKOr7Drd9XOwnz1XxKBDCphSGaXig==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZkwCCj8IHyOY9HkuURrZfvFiGrfuhMm+w2IDGib1ks4=;
 b=NP3gkpY0B5xTKgT/PSU0AjIzURk6SG5PxUehH/hn2DU1whvKZYpHGGBOWUxR6ekbxcUzvv4548Y/whbkhGdfDGEJGlGjw9T2p0PHFK3ubD7NpcLMjIK5k1OKEyNe6Bd8PgwO/sk3s4zbZjaQGIAoOiNDpEEKpiI5rd6ec2ZnIkE=
Received: from BN9PR03CA0403.namprd03.prod.outlook.com (2603:10b6:408:111::18)
 by MN0PR12MB6054.namprd12.prod.outlook.com (2603:10b6:208:3ce::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6411.17; Wed, 17 May
 2023 16:18:31 +0000
Received: from BN8NAM11FT055.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:111:cafe::cd) by BN9PR03CA0403.outlook.office365.com
 (2603:10b6:408:111::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6411.17 via Frontend
 Transport; Wed, 17 May 2023 16:18:31 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT055.mail.protection.outlook.com (10.13.177.62) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6411.17 via Frontend Transport; Wed, 17 May 2023 16:18:31 +0000
Received: from mkgs-dev.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Wed, 17 May
 2023 11:18:29 -0500
From: Graham Sider <Graham.Sider@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amdkfd: Add new gfx_target_versions for GC 9.4.3
Date: Wed, 17 May 2023 12:17:48 -0400
Message-ID: <20230517161748.358768-1-Graham.Sider@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT055:EE_|MN0PR12MB6054:EE_
X-MS-Office365-Filtering-Correlation-Id: 463f1cfa-ffab-45ab-08fe-08db56f25b24
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 7/brKcOA2a5aO4sFn//UNOJkKk440mRuYnR6Pe47OCjQSDGV2dclQOj3+VZJSkqqgpRF1EuZ3h8atqPKF5m5k7mP7VtXq0JEQEV2hF3HNgILrUsi46ewbgYo+EKlkfFnuHhHeF0N0AR/oTyZQQqcEbu3rtH5HJzvjRJgRFtljProYZDPMKjwb8ZthUu+kkFbvf8ZNVDPJLdPp2DfCFn0F3tNme/XRXuY6gmDrf/59Es09vJecy1n2UU2CAgoQm5+jM5Vh2zv3lmyfHw0wHMSRywK6Xa5/9kfVyY5pXSnVYqutb4bQGV3rQ6wQT/ZLr47Oq2C/HjnpIh+UziH5o6MDW0xSOfpDn7W4FTXG5WfpB/CDRzqJEn2P0n4A2/iZoWLR/lvrDPtRo7MkXKWVk4DngdmYf9CH3Gt563DMwkVF/FHJObFMNLIxo9yWVayDl3LgNQYzHJYkn3s42AGtQOXyH46W3ZF5QZyqQx5mk76eh9LCb6y+M0t0Bv1c25BaJ7b4y9mCij1M41UYPtLzBf7eCOfm8calZPU2KxNfERXS5b0/km4Rr5YU2BAEkbQMdCFNZUA482DmTh2uV8sNfZE2DnEYAsV44tzn9JlZ+VvkdebaWWx6TsxZscBQpPJFiS/HA9hoeLvPAqVJtLcuyCGDjd0rwPptqX+/L5K9f5wcA4ewTtUsWm6uZtmCBininloxItMZ4h+qb0BTbNLx3WpqqglvZQR4ndoJX16wY+sv/I3/SLnE5fOagCFbRLSRA1hlm26QeOxn6NAS/k3Fb8Mpg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(39860400002)(136003)(376002)(396003)(346002)(451199021)(46966006)(36840700001)(40470700004)(36860700001)(40460700003)(81166007)(356005)(82740400003)(41300700001)(8676002)(2906002)(8936002)(4744005)(5660300002)(6916009)(36756003)(86362001)(316002)(4326008)(82310400005)(70206006)(70586007)(40480700001)(336012)(426003)(83380400001)(47076005)(16526019)(186003)(1076003)(26005)(7696005)(478600001)(2616005)(54906003)(6666004)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 May 2023 16:18:31.3751 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 463f1cfa-ffab-45ab-08fe-08db56f25b24
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT055.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB6054
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
Cc: Amber Lin <Amber.Lin@amd.com>, Graham Sider <Graham.Sider@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

For GC 9.4.3, set gfx_target_version to 90402 for rev 1 and later (APU
or dGPU), 90401 for rev 0 dGPU, and 90400 for rev 0 APU.

Signed-off-by: Graham Sider <Graham.Sider@amd.com>
Reviewed-by: Amber Lin <Amber.Lin@amd.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_device.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device.c b/drivers/gpu/drm/amd/amdkfd/kfd_device.c
index 01a970ca2c5d..8e52b04235ab 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_device.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_device.c
@@ -330,7 +330,9 @@ struct kfd_dev *kgd2kfd_probe(struct amdgpu_device *adev, bool vf)
 			f2g = &aldebaran_kfd2kgd;
 			break;
 		case IP_VERSION(9, 4, 3):
-			gfx_target_version = 90400;
+			gfx_target_version = adev->rev_id >= 1 ? 90402
+					   : adev->flags & AMD_IS_APU ? 90400
+					   : 90401;
 			f2g = &aqua_vanjaram_kfd2kgd;
 			break;
 		/* Navi10 */
-- 
2.25.1

