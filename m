Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 029DFC433EF
	for <amd-gfx@archiver.kernel.org>; Mon, 14 Feb 2022 21:55:54 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7AC0810E30E;
	Mon, 14 Feb 2022 21:55:54 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2075.outbound.protection.outlook.com [40.107.93.75])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 212DD10E30E
 for <amd-gfx@lists.freedesktop.org>; Mon, 14 Feb 2022 21:55:53 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MYF2vBEq3iOTkKiq0cxH+JQJKduIpuP6n+KKHgxzLmgXr032ZWo2cCksJ+zZBB/TzIL7RBgEg+i+I2011XV6VhLIL+qxtLSDn/IRaB9nC1LkopIl78nMn5SVMu7bETS8yq8BsHPoWznuZ1tBYx6liR3l8ZsK28RfJ0zQN/98/VM5O4UvJA9d7TKo2zB2TiSp3uphmqvis1k/Co/R4UWdbaHqINxrh3jb5iJtbwi0gx1yZaPeb+Q5VUyyzgymmEMBk5Qy0eaKRp7njvhv/lkIl4X3eVdqf0SiQzJaJ22qZ/lIwahE6fJE/uYX7fZUI/YNBVa9JhoVRfCDQ+eFTEiH6g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mIffZh5kftsdpP7xNqSoL4kLJftg5wktYn1ArofVgeM=;
 b=JoGCJiyLcrOW30jBQGkwrQYDjAtN1ugKu3sE84T2KrtIsYvmLbfZbOANShSsaeSwAgT8lrlnRyRizDLYJDRE90CNg1CWoDJJjwFa9VHOyvx9uckr/LYXveB9ITQFPzAGBz0XfcYvcvfrIDqXgWzUqK0H//lvc2eooHFNeaVTTZFj4DlLMiivinWS6zltogZZy0cYrr05rEww0whnMSnh0Pki2932aGzftwiRgcr03Bi5u9rGJDftOFrzE0pfjRMCqDp6XYyyj0KI43R0EqSVyVujz9sAt9Ujc7/Aq0FD2YETeOk/rcLsoshS9lfx6Vrlakjtz+ryGQR34CWBOzHKcg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mIffZh5kftsdpP7xNqSoL4kLJftg5wktYn1ArofVgeM=;
 b=MO4yLgMLtj9eJTkPWJerDPmbW1zFBPYsLaIO0mLebHJZvVXlYjrSAOQwxGtLivW5ZuHHik3HfdHfe/LF1AngPr74JEvLhaxWILfFqjze2kho+L89WeU66faEzlvX1lZOEgclhVYoY4rvBrkrhXvWp/aNEQg7vlqokBhgz/S8qtY=
Received: from DM6PR02CA0134.namprd02.prod.outlook.com (2603:10b6:5:1b4::36)
 by BN9PR12MB5098.namprd12.prod.outlook.com (2603:10b6:408:137::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4975.11; Mon, 14 Feb
 2022 21:55:51 +0000
Received: from DM6NAM11FT012.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:1b4:cafe::8e) by DM6PR02CA0134.outlook.office365.com
 (2603:10b6:5:1b4::36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4975.11 via Frontend
 Transport; Mon, 14 Feb 2022 21:55:50 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT012.mail.protection.outlook.com (10.13.173.109) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4975.11 via Frontend Transport; Mon, 14 Feb 2022 21:55:50 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.18; Mon, 14 Feb
 2022 15:55:49 -0600
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amdgpu/discovery: Add 13.0.9 SMUIO block
Date: Mon, 14 Feb 2022 16:55:37 -0500
Message-ID: <20220214215537.2116690-1-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a3775280-5379-4cb8-bbcd-08d9f004c3e5
X-MS-TrafficTypeDiagnostic: BN9PR12MB5098:EE_
X-Microsoft-Antispam-PRVS: <BN9PR12MB5098669007315C5510CFE71EF7339@BN9PR12MB5098.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1751;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: OkYQ4h+iYoW94cyOEjp2OdKDMd6f3vou8hgsVx8e8ENKxjU36TJKq+hPdp1V3cJrHj8lKeb/9R76Q4DkMnLFu3s6ULfJerP2Xm+k80nxChbcKId9lqBHZOe1ojbFLmFRV0+2lhPhBqoGnbSjLldDGHJu2N69zT4M5bqLUCghhUAVWQ9+htsYiYkqPgr3+oXOTU9rdPQTe5hWJpt8nLHYp0DPiYJZJBCuED9LgGEjD59O5rEZCY9aEu8IyA5wH2AsTcrqhLsmMFSgJ9l1c2i6b1ejalG9yuvOsMOlrwItDOEtPPz76WC1iNIcOfQKWQSHLykLbQAPq+tHmFwbpn4i1KTiYFIitHbsCVFLLJZEfgEauZVewzDW+nWasuEpq276GHSyk1gp1xLo5juNJ3QtuoK9x0t5rZ0RiAW/tTy60md+DSb/L5V5PsTWYyZetfg4ydQwMOzzKI4wIJWV+91WeR/e7XKPYdPkaKpt9pRSlTftlUB3DLy4eaHTccCj6ZXIL27ifBz+zqPL1t8p8cPFV/Srm1q9jUqLREzzg44ihIaKmwfJuCobXQnbMGC1yCE6e6ZVoNzt0vJRZMI7lDHv/wZxQiiCcmhyYNlakDYyuwVIb2Q4Xh1wx3Fcl0NG9vd4JbqjxIJdyQsiK7ZyfToLipUFUZP6xqxBo9Glyldj2NJRWBdLxSYvSP4/1WefMQss2gcGPoriGJX2+V0c0m3dtg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(46966006)(40470700004)(36840700001)(356005)(81166007)(82310400004)(86362001)(36860700001)(40460700003)(70206006)(8676002)(70586007)(4326008)(47076005)(54906003)(6916009)(316002)(4744005)(8936002)(5660300002)(2906002)(336012)(426003)(2616005)(186003)(1076003)(26005)(16526019)(83380400001)(508600001)(6666004)(7696005)(36756003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Feb 2022 21:55:50.6003 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a3775280-5379-4cb8-bbcd-08d9f004c3e5
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT012.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR12MB5098
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
Cc: Alex Deucher <alexander.deucher@amd.com>, Prike Liang <Prike.Liang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Prike Liang <Prike.Liang@amd.com>

Add SMUIO sw function for the new SMUIO block.

Signed-off-by: Prike Liang <Prike.Liang@amd.com>
Reviewed-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
index 7b4f8e89a1a2..a7789bfbe458 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
@@ -1881,6 +1881,7 @@ int amdgpu_discovery_set_ip_blocks(struct amdgpu_device *adev)
 	case IP_VERSION(11, 0, 11):
 	case IP_VERSION(11, 5, 0):
 	case IP_VERSION(13, 0, 1):
+	case IP_VERSION(13, 0, 9):
 		adev->smuio.funcs = &smuio_v11_0_6_funcs;
 		break;
 	case IP_VERSION(13, 0, 2):
-- 
2.34.1

