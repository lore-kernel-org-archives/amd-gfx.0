Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 327B7C4828F
	for <amd-gfx@archiver.kernel.org>; Thu,  1 Feb 2024 17:36:29 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7DFB610F2AF;
	Thu,  1 Feb 2024 17:36:28 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="vBzoIVQt";
	dkim-atps=neutral
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2054.outbound.protection.outlook.com [40.107.220.54])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4336C10F28E
 for <amd-gfx@lists.freedesktop.org>; Thu,  1 Feb 2024 17:36:23 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Gh741oZzBYvJi/5gFmesbkAtqGOIwUifQQBP5VUqfTx8Cc/JMH2EPydkrIz4aujRZy14NaSXd5S676gjJ5dTug5iCAxtPZcSbOIVV4vrT8ncDxwVIiNfkw6736NU8o/9dBzezwdsKD4OkIVLslv+VA+AZmya+B0Zd5t9ZuZS7Wh0NZdzXJER9Pu3WFtMw589ch+noxjmINSIISxW3o/sc13KHRM5X1VkgwF2ZGIDbYi4U2pKtR+sWqnl7tDCjnVxz2XKBNv1xP7DIbGQxFrKfWAPOwkTwwFdlHzrpqF0tX2Hy/zkjYCGCDmf3sIgWI0pPCgCwYvnGqDjByydn34IEw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=F9smBw1XL/ewizoRCsF5vADat0L6ShwEzbzodVH/Lc4=;
 b=AhxK+0FOPwLNO6DNaxTA6J8VhexQ+pYkNZJVzSkumTCqyOD9Q3OYZPuCDyZXwzA0YOZfNLsC6IGH6oEQyy5WDoppPMvxCxcRHXk+aefZ4T5adyqWhCm8Cz/Ia7guaN1HdYK7vGOJ80Z8vPiEeQ+hbRFrP/Uc8WCx5D798xueTezGphq/loCemS1//CizfFNThaUI228DmJw8E4Id4FDjS0zDmqFkP59pZj46djC8R8L+wYo+bUW3YbY9x3DeP3toYTVJ4PG/Stuhf+0o6phAN2vAx/fMYz2nDJvQDx4aXo3OW4z10H1qWgCMmy+BgwX4SmgaFGnZ9/PrWsmUmpxR0w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=F9smBw1XL/ewizoRCsF5vADat0L6ShwEzbzodVH/Lc4=;
 b=vBzoIVQtWdWlprreOlbXqu8W996BzAmZPbuL8JcuJWVq7j+CqMisdTyGnxc7nDutOarSkAjnHJ0sT2vi4t1QbtifNmBX5uuzSq3gyp3PWNYAUt2I64nrzQ/ySwOLYRWz/aN6HALW/G27lJgGiCzbNev0qTnR03jnYTENGQ7qUqY=
Received: from CY8PR19CA0027.namprd19.prod.outlook.com (2603:10b6:930:6::12)
 by DM4PR12MB6039.namprd12.prod.outlook.com (2603:10b6:8:aa::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7228.34; Thu, 1 Feb
 2024 17:36:17 +0000
Received: from CY4PEPF0000EE3E.namprd03.prod.outlook.com
 (2603:10b6:930:6:cafe::bf) by CY8PR19CA0027.outlook.office365.com
 (2603:10b6:930:6::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7249.29 via Frontend
 Transport; Thu, 1 Feb 2024 17:36:17 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000EE3E.mail.protection.outlook.com (10.167.242.18) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7228.16 via Frontend Transport; Thu, 1 Feb 2024 17:36:17 +0000
Received: from srishanm-Cloudripper.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Thu, 1 Feb 2024 11:36:15 -0600
From: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
To: Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>
CC: <amd-gfx@lists.freedesktop.org>, Srinivasan Shanmugam
 <srinivasan.shanmugam@amd.com>
Subject: [PATCH] drm/amdgpu: Fix potential out-of-bounds access in
 'amdgpu_discovery_reg_base_init()'
Date: Thu, 1 Feb 2024 23:05:55 +0530
Message-ID: <20240201173555.1289398-1-srinivasan.shanmugam@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE3E:EE_|DM4PR12MB6039:EE_
X-MS-Office365-Filtering-Correlation-Id: 5ac50a9f-c509-46ed-4ddd-08dc234c4bc5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: wjFHUYXQ4vSZQHOGdODmyEvzJX+VIonbkWlF7AQWcOEouFwJviuh0AyY1yR8MVkViXFvvDJzEwVck+i2+ebenbeByAppXGy3lmPfNegTPou4n/wjQVUEo5tnF/xYdTifXP2dht9fbBNOpZtNcqCWk1G7dIhMdG8HHwYabj3nXhxYQ7wTtuxV5sueOIMqgH5itPhllRr2APEkjl3Rt/OZj1KxvW6fyZkwJZuHPOngjKXfQvSqTrTKm/zPKz2vBfUZ/lmHfVq+d58cu2yOzLxUpYAYJf1W74YAnf0aMe4juKdWY30X+3ZTCmoABF5VFZoOQGIwOQm/mwPqI+Qz8S6aMjNE11WZSAjIbonxYfuxIYvfvw4K8s6acp5aPh9T6xrpczBXk9dlxevgAMvT4Pik1YI7IhMl8nZAkzzuPg5Ny9IY4u09N2WX/F2hXsUvT0uHCgc4aGfeBLs9pwJCw2nE5E2pMczhG4f/u9lO79QM3KpJnegLx+9mDYAYCkxZROhXoJEsAjlWFzbvwsRaDEbnyVXOl3dI+Jaq/YtB9xhdNuBhqhmnVOATi57Xj01Tg/J79gJhPi9/eaR/NNFOwdbx0heAp4HAOxen8ONLy5WZ0B8DVJmcb9njbH+0drFAcRdQsW1VwHrZj295hW+1pGcRlkFNkb7HWzYIHbM2sOr4StqumB3NszpeWykuQmAUyc07eJMcLL4rkHGBvT6mZvQf8VtmETvBwVALhqpf++d+/3THvyuAK7yvX7ya6lDjXtSUn3/ine+e9bsbRzPEHVADpw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(376002)(346002)(39860400002)(396003)(136003)(230922051799003)(186009)(1800799012)(64100799003)(82310400011)(451199024)(36840700001)(40470700004)(46966006)(83380400001)(40480700001)(40460700003)(86362001)(36756003)(66574015)(81166007)(356005)(36860700001)(82740400003)(70586007)(26005)(47076005)(41300700001)(1076003)(2616005)(7696005)(426003)(16526019)(336012)(5660300002)(6666004)(110136005)(316002)(54906003)(2906002)(8936002)(70206006)(4326008)(44832011)(6636002)(8676002)(478600001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Feb 2024 17:36:17.4382 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5ac50a9f-c509-46ed-4ddd-08dc234c4bc5
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000EE3E.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6039
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

The issue arises when the array 'adev->vcn.vcn_config' is accessed
before checking if the index 'adev->vcn.num_vcn_inst' is within the
bounds of the array.

The fix involves moving the bounds check before the array access. This
ensures that 'adev->vcn.num_vcn_inst' is within the bounds of the array
before it is used as an index.

Fixes the below:
drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c:1289 amdgpu_discovery_reg_base_init() error: testing array offset 'adev->vcn.num_vcn_inst' after use.

Cc: Christian König <christian.koenig@amd.com>
Cc: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
index ef800590c1ab..83da46d73f70 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
@@ -1282,11 +1282,11 @@ static int amdgpu_discovery_reg_base_init(struct amdgpu_device *adev)
 				 *     0b10 : encode is disabled
 				 *     0b01 : decode is disabled
 				 */
-				adev->vcn.vcn_config[adev->vcn.num_vcn_inst] =
-					ip->revision & 0xc0;
-				ip->revision &= ~0xc0;
 				if (adev->vcn.num_vcn_inst <
 				    AMDGPU_MAX_VCN_INSTANCES) {
+					adev->vcn.vcn_config[adev->vcn.num_vcn_inst] =
+						ip->revision & 0xc0;
+					ip->revision &= ~0xc0;
 					adev->vcn.num_vcn_inst++;
 					adev->vcn.inst_mask |=
 						(1U << ip->instance_number);
-- 
2.34.1

