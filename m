Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2B800C35274
	for <amd-gfx@archiver.kernel.org>; Mon, 18 Dec 2023 21:22:04 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id ADC9810E102;
	Mon, 18 Dec 2023 21:22:03 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2078.outbound.protection.outlook.com [40.107.94.78])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B150910E102
 for <amd-gfx@lists.freedesktop.org>; Mon, 18 Dec 2023 21:22:02 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PpBU+ABU/JK5UlPKjVqjNnOzafXDimkHPYPJYW/ojPBpyr6xkUlZl708ao6K96PjfZN9W0G1YOXxd2gfxNAM/xL6JcVQy2oSOjcT5DZnoARMtXCMkSxzRLzA6M8hKH8Smv7kmWRBp05TtrYYfZj2ZRV8hm1c1sIu3MN/mpohQRCsSQKfrfHMAkijlIZPzomhEVzoFuR8YiuJ1QCtdWvfLad1Bvz7DGjUCP9s4h7HwjKXw9ObRGKUm6pmQoX1kUUvTwHBg6NLFtbDrXpECbke+EygZAQRtukzK9bQKjxZUkEBKaifGmZXmLfpvx1JwfXfh2RWhEbkDqv0PwRgCt8CiQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CzfebLZNuV3Zr95HEiWpkwMXmeYnXdMl91Wh6PAe0sY=;
 b=nccIm6IHu90QJLkcHBdEZLvoUKU/V7N/1TBejosUNpXEOC1j6951Xt0+SwpRe9xo6rThw4bma286YGJYU0/n2A4mGrTxy049Cn/68cz3OIxk1B8yutYmP/nxXLyb5662rs3+Muec1QT+PamiCmO+9yzL0zb4JHmQYifYbMUKszx+ANg0piYl/vHJD0xpZlvbv+fz5Xj4kJ74y3kx/KHIg3hKyaQ6Rt9aXUwJBOVfnjnnD+klFtmHBiLZP+klv/Kts6NjBecVolK6zHCVyuZLucCuJWIrYZi8eYSLhSl2X832U7LWMFEmOqQSxM4OTwGL0F26vIWBb/VH/YXveiL0vg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CzfebLZNuV3Zr95HEiWpkwMXmeYnXdMl91Wh6PAe0sY=;
 b=Kk7QewjWHihwCbst+cbZqYBZxrLlhelg9b9lodAD9yuIdqGdWOBeX7idkgKkCnsS1wW/dPkRIkumCzOo+FNRp8I+puzfC+Be2aU8b+qF7z1lC61XCVOdRV4z+JUptw+kUHtjZVxJOwg2IZYnZ3XG5mMQzH1Kwl2u3CFTJo8oOxw=
Received: from CY5PR18CA0044.namprd18.prod.outlook.com (2603:10b6:930:13::13)
 by MW4PR12MB7309.namprd12.prod.outlook.com (2603:10b6:303:22f::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7091.38; Mon, 18 Dec
 2023 21:21:58 +0000
Received: from CY4PEPF0000E9CF.namprd03.prod.outlook.com
 (2603:10b6:930:13:cafe::40) by CY5PR18CA0044.outlook.office365.com
 (2603:10b6:930:13::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7091.37 via Frontend
 Transport; Mon, 18 Dec 2023 21:21:58 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000E9CF.mail.protection.outlook.com (10.167.241.142) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7113.14 via Frontend Transport; Mon, 18 Dec 2023 21:21:58 +0000
Received: from Harpoon.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Mon, 18 Dec
 2023 15:21:42 -0600
From: Felix Kuehling <Felix.Kuehling@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amdgpu: Let KFD sync with VM fences
Date: Mon, 18 Dec 2023 16:21:11 -0500
Message-ID: <20231218212111.565869-1-Felix.Kuehling@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9CF:EE_|MW4PR12MB7309:EE_
X-MS-Office365-Filtering-Correlation-Id: 3280aa35-f711-407b-2a69-08dc000f5e38
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: kBT4P91krbpQ2lAGwkEdgWOpJhwwdKTxnHB3IDcEk/bXACWdIjNjJA1yZyad9tcXC3qsNHhVgN/vqZb2Eu2cpt3TrQifnQz1asyWZ8CSLz1ypycP0QYeUy+BfNVf1YEBXaNnZI27WCt9WcC7lhxqPYRRZIdZEIV681vFxXvmFVUEm8JKSrOOmoXx8U5AL3wsrdwpavjh2CepcGZUGlRiZ7wAvSzX7YIm+aCPjXDidzSp7f0TlLQkMyKpLi5XBMnDUPyFc+0rGUyLqvETfuZJXBgbQuagG+IVq/ZPdrvOk3iHOUL2vgSKVi77M+NmTjDTi2f58gNdC8aEpLroPKo7+LdZdkpGoPMQaLscxQhi/NGyaSkC3Yn2Nxx25oPBId9FL5fhr1vB64ql1nLYPwsiwSz4m+Yq9uz2aNDFwMDDwwpRACYxMgqAl54yHqgXiD4jO3Cd6jXnplyPR3r/jQKCian6aBl57GjtXYhhLtRQSrA1OVMnxO0YAZXElRJHNL9WiisOt7VX7AY2QLQahs7oSHTeoXDvimN3GA+f097vRcE+/Xh/xanOAzLmNPaOPrMWUabze/ybXIvTNvdIRXLqEiB8XlB2oByzUMx9GmJturyjYAsVyDFQmLK9Nd3fMAtJjwaM5rl3cOezpVBOQ9+UpnD4p69RfCD8PVEmw+TMXCcLSRcDEB4/tEgWJhyJ4j9Lp+/htG05Tx0AH/ERc+gQ0U1mQoQjAx3zDikZ1nclh+E7NiPidbxsoIPFidT05ywueGbFbsk70FFPwHnEoOk6kQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(396003)(346002)(39860400002)(376002)(136003)(230922051799003)(64100799003)(82310400011)(186009)(1800799012)(451199024)(36840700001)(40470700004)(46966006)(40480700001)(1076003)(2616005)(426003)(336012)(16526019)(26005)(40460700003)(356005)(81166007)(82740400003)(36756003)(86362001)(47076005)(83380400001)(5660300002)(7696005)(6666004)(36860700001)(4326008)(8936002)(8676002)(70586007)(70206006)(316002)(6916009)(2906002)(41300700001)(478600001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Dec 2023 21:21:58.2360 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3280aa35-f711-407b-2a69-08dc000f5e38
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000E9CF.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB7309
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
Cc: christian.koenig@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Change the rules for amdgpu_sync_resv to let KFD synchronize with VM
fences on page table reservations. This fixes intermittent memory
corruption after evictions when using amdgpu_vm_handle_moved to update
page tables for VM mappings managed through render nodes.

Signed-off-by: Felix Kuehling <Felix.Kuehling@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_sync.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_sync.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_sync.c
index dcd8c066bc1f..1b013a44ca99 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_sync.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_sync.c
@@ -191,7 +191,8 @@ static bool amdgpu_sync_test_fence(struct amdgpu_device *adev,
 
 	/* Never sync to VM updates either. */
 	if (fence_owner == AMDGPU_FENCE_OWNER_VM &&
-	    owner != AMDGPU_FENCE_OWNER_UNDEFINED)
+	    owner != AMDGPU_FENCE_OWNER_UNDEFINED &&
+	    owner != AMDGPU_FENCE_OWNER_KFD)
 		return false;
 
 	/* Ignore fences depending on the sync mode */
-- 
2.34.1

