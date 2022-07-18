Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C00BCCCA47F
	for <amd-gfx@archiver.kernel.org>; Mon, 18 Jul 2022 12:09:32 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3E188B0B17;
	Mon, 18 Jul 2022 12:09:32 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2082.outbound.protection.outlook.com [40.107.92.82])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 58257B0B15
 for <amd-gfx@lists.freedesktop.org>; Mon, 18 Jul 2022 12:09:30 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gjwXdZx++SoulhudKIH1mvF5BF+lr28bRUf7LpnU8rG3rPWFziffR5XRO5C+sDQmPiJ2bJs466gHoa9XZIX1xZt7cK4GrDaMlVo5EeWeEF4jsVIJFaUyrCpV/Bv5CFWZ9HmLBMTKcBYFry7+KLf+hWdFPvjIALm1Q1GlY7m5GG5I49Ib6q8yqxS5nYvtkyeBDCVcsyCKpa/+1YIjL85h9bIUh4ljz0yOAl1GCesAVqaZdS21VAF2h8gSvv0If6oL+PRkB5ZdflfyFPXViMQWu+lx5j2+w5kGeQ7HILYfq6xVAl+b08Mc0ESQHlbEfByOsyUXqWO8OET98SzwsQEeOg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kdj6d4d80Tx8+9VOMbLkvEC7IvIAe96at/2pXEakYrk=;
 b=OlkSPR/Ygwo2fLk3T+hysmkI7bJmgTrNnOUdpShmAYIbtruMAsvmNrrgoS/bqVhj87F9T5Kpu2q8JgBFIVuxEyJmcHam0DqPfVNERdlBCrvu/J4fQG7Pz++HZ88cMriVWEiXvKmbQJqPfv+7IESA3+8VO/yARw1DPctvOTmOHjlw5jBhN14xsWJJ6A+zA6+U2OcVcD1AkjlgbRIyLVeiW/JGIyuVUgHOVdZ9H1f291F9aJMImQ3+uNdk8pd77pC67AIGcMPbvbd9fVRv+p9D/xqWD/zO5j4+LU4ZoE7lR5EjHog9etA3zpv3dfPiQ+P5bzbtNwtBL+3SZe+oJB6htQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kdj6d4d80Tx8+9VOMbLkvEC7IvIAe96at/2pXEakYrk=;
 b=zfsE6OZ1S2WNmlOK+LQV3FJ+v8Q7maDqWR/fTp1XjqnQ8ycNUQx99fu06fvGBTHkaElem6dsRguGif0nVoflCmiE8JXQrQgjniGoYh6hZW47fc2grPL3EiK9cToa35WV+6KO5RjFPKXNggUhl4e8mKhIft5RtlAe+CdrLQ9Ew0I=
Received: from MW4PR03CA0202.namprd03.prod.outlook.com (2603:10b6:303:b8::27)
 by DM6PR12MB3612.namprd12.prod.outlook.com (2603:10b6:5:11b::32) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5438.21; Mon, 18 Jul
 2022 12:09:28 +0000
Received: from CO1NAM11FT050.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:b8:cafe::47) by MW4PR03CA0202.outlook.office365.com
 (2603:10b6:303:b8::27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5438.17 via Frontend
 Transport; Mon, 18 Jul 2022 12:09:27 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 CO1NAM11FT050.mail.protection.outlook.com (10.13.174.79) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5438.12 via Frontend Transport; Mon, 18 Jul 2022 12:09:27 +0000
Received: from SATLEXMB08.amd.com (10.181.40.132) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Mon, 18 Jul
 2022 07:09:20 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB08.amd.com
 (10.181.40.132) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Mon, 18 Jul
 2022 05:08:55 -0700
Received: from roy-X10DRi.amd.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2375.28 via Frontend
 Transport; Mon, 18 Jul 2022 07:08:54 -0500
From: yehonsun <yehonsun@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amdgpu: Fix the incomplete product number
Date: Mon, 18 Jul 2022 20:08:47 +0800
Message-ID: <20220718120847.9719-1-yehonsun@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 4eb9a2bc-bb1e-4cc8-f2e0-08da68b65ce4
X-MS-TrafficTypeDiagnostic: DM6PR12MB3612:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Szw1PjIHa2jz0JT2dtDjVGY0FJlhjmlCaVxegNH57RgJPrxBmov/PnJ06B8MuNnZ69pEYFAQfij6boOUOx0VwOTgKt+80n5P7CO7H3gogPtC3ZC4TaT4LBB2h8l1Bz7e2S9tDsdnE+DSBPOc3mZKQe11sbXV0dssYPTowVLDy4ASr/xKte1Bs4dylSo/NwPBU/Uan0c6zRK+CO94RF2ti9m6gBX3PjNjU17lZt4ZlU5hI1H9e+vh05l7Y9UYtdssVLe6nhY/2vSwrlw8ebAtJYOlLfy2/5se+QOZkrxpBgk9OnciBaAhcsO0hyF2+xHvnYkDejIefzfTgHD7Tup6TRC7glHpMLfPtCy7KjjFFedKDmEGaou+A2nyTt6KVvwtxqVx1XqYNkt3eVCv4SoIcDHMWtJhYZk6pRFevmQjXZFP0DaQRRbfk4sbg48e/YZUFOlwAWVd2HMgUd88szrnNSCFNwsKSjfOnqKfQpwaE34iNW4bXwREz1Imp0ePt0KUYDJGB0/9jXff5TJAN8RQ2+hxlT+1oU36jlyXmAGf4h2I6i3fLEu9k7tHSqTfVtNnLBa3pr0hiPao/MnAUgIzRb9uxbkItaj05OtAuduZFQeTSNWF7EJrMny/QknaWrC7eADEwIMnV+KzcoooF+n6AJLsLgbFoFhfAibGfU+X8vDrUzAJCu0FLWQaybQvdBKylH8tXnk4d/KtCs5liQPL6ENf+Jb79AgsVH1LeVxmkKIvIeD+dCw9l1sD/W7/mf1jDR+3nCPpg1qeN/xMJ5nZbzx0LVmtBHHOQbRkZ/E2+cAQzQf6XAdEC2F7Ln88DBx7HSte4vfRBGYLyfjkWfR9iCSa7XkjNXWtV8Tz7wpuUGc=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230016)(4636009)(39860400002)(396003)(346002)(136003)(376002)(46966006)(40470700004)(36840700001)(356005)(81166007)(36756003)(82740400003)(478600001)(4744005)(426003)(47076005)(2616005)(26005)(1076003)(7696005)(6666004)(41300700001)(336012)(186003)(8676002)(70206006)(316002)(70586007)(40460700003)(40480700001)(8936002)(82310400005)(5660300002)(6916009)(4326008)(36860700001)(2906002)(83380400001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jul 2022 12:09:27.6160 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4eb9a2bc-bb1e-4cc8-f2e0-08da68b65ce4
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT050.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3612
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
Cc: yehonsun <yehonsun@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

The comments say that the product number is a 16-digit HEX string so the
buffer needs to be at least 17 characters to hold the NUL terminator.

The comments say that the product number is a 16-digit HEX string so the
buffer needs to be at least 17 characters to hold the NUL terminator.

Signed-off-by: yehonsun <yehonsun@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
index 9f729a648005..187e3dae3965 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
@@ -1019,7 +1019,7 @@ struct amdgpu_device {
 	bool                            psp_sysfs_en;
 
 	/* Chip product information */
-	char				product_number[16];
+	char				product_number[20];
 	char				product_name[AMDGPU_PRODUCT_NAME_LEN];
 	char				serial[20];
 
-- 
2.34.1

