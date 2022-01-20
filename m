Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3183AC433F5
	for <amd-gfx@archiver.kernel.org>; Thu, 20 Jan 2022 03:19:31 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8374D10E2BC;
	Thu, 20 Jan 2022 03:19:30 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2055.outbound.protection.outlook.com [40.107.93.55])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D226E10E2DC
 for <amd-gfx@lists.freedesktop.org>; Thu, 20 Jan 2022 03:19:28 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Hk4EkHTfx0FSosZzLzHNW5V2HnH17+QK8n1E91MKdRgtI6YYtVj6oKVYUFsb4o3QD/fUrww6p4VAFl1n8KOC2Ozgc4WVKy4T/clohn7lFZr8fmhKYqZk487kUUDI4eYFfs5lAVsmOUHRhRGKm96lE9VMLOEe1qBTqbCEnu1WMmW4skbosh6Lx0ku0UYBcikxuoFWtSyRlUAWiqqasYJ373cven193T0q1E1Kd4NyWDVV+GFTvOfe97NAE7wq/XOhqjEPkCaFQd9M11gbPhIznX022z+cxtMR/kS0EANAlvchgs+vxie19S/VGPQgE9I5nG9y/XF3x7QlwdDw0L6ZEA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZkQuMGD8n9U2KShH89tiCvhLhBTusVUYbFNdMGjYElc=;
 b=jrNYrd8Fru4hDHr13gtK/BGxqqk8VcHzKdniHdcbs9eH/7NYGcjzxOU2SrzpHNXh+UMUu3PNe9zZ+he7mJcN6U6/MS3GQavOuSYKZGYtuGlam650o56VrDZMqQGWSaQcnkb0jbvtl4d4UNnZr4j5IEkiec2wmB4/tTR8G93sZGHzWxzWVvj3ghN7fkK8YCeF8wOqjmwcm3fbsw46NxLZaiP6uW5wCjB554BytsFxSS8aSfeaL/tZTiURD3jjKrMZwoYJOHI/FM4qIk23g2ACc0ZQSLvNIUcAWFK2Zhq640mNMLegj7bnPxylEYhsNZ+/4F9Bs/Bdq1JsjFSOc4Zzeg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZkQuMGD8n9U2KShH89tiCvhLhBTusVUYbFNdMGjYElc=;
 b=5EHa36XUJ9mY9ohgSarv1jOaZtLAVSFWR5svibWUCX7izxDQ3rxNhPnhwt9RTQdzLfXCwL952Z+eCbNwj/BPTSdZv5ersfmQWZJL/DopqPQs1ZJ+AmKWhF5Omzkbfuzqnj4sT7eNjVN4vqbQjXdmmhAkTGHG5BS/Dvy7ZurByrw=
Received: from CO2PR04CA0073.namprd04.prod.outlook.com (2603:10b6:102:1::41)
 by SA0PR12MB4445.namprd12.prod.outlook.com (2603:10b6:806:95::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4909.7; Thu, 20 Jan
 2022 03:19:26 +0000
Received: from CO1NAM11FT012.eop-nam11.prod.protection.outlook.com
 (2603:10b6:102:1:cafe::7) by CO2PR04CA0073.outlook.office365.com
 (2603:10b6:102:1::41) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4909.8 via Frontend
 Transport; Thu, 20 Jan 2022 03:19:26 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT012.mail.protection.outlook.com (10.13.175.192) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4909.7 via Frontend Transport; Thu, 20 Jan 2022 03:19:26 +0000
Received: from thomas-mlse-vm.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.18; Wed, 19 Jan
 2022 21:19:23 -0600
From: yipechai <YiPeng.Chai@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH V2 2/2] Revert "drm/amdgpu: No longer insert ras blocks into
 ras_list if it already exists in ras_list"
Date: Thu, 20 Jan 2022 11:18:50 +0800
Message-ID: <20220120031850.350206-2-YiPeng.Chai@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220120031850.350206-1-YiPeng.Chai@amd.com>
References: <20220120031850.350206-1-YiPeng.Chai@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 221e5ef8-b465-4c19-9df1-08d9dbc3a9c2
X-MS-TrafficTypeDiagnostic: SA0PR12MB4445:EE_
X-Microsoft-Antispam-PRVS: <SA0PR12MB44456A3FC1137032768F2229FC5A9@SA0PR12MB4445.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:421;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: cxzNCL2KKzsFifkZfv70b0nTcpqSZdkOCCR2RJaaRjwqnR7Z94Usdd5fqGn0+HS0gs40cXYak5Koq7IB6HERPOyboiQEQ9h0DdE8bk7C+SWlusTkKzJ9nckYug1MuxWU0+xm089IZ0VQBq/q3X3DHj0c9bf6VuaL0KBVeBO6a3r7p0xsgxvpfu3GaInK+8TkAnCoGon23Bej+OPVInJxpUOlM8GSebULJd2og6oipaX0e/3bXa/L93x1yNpng4fOG44Fg4f0ufjOSqVv6u8NC/An8IVPOwNYub1u66akpaCm/UfIwWphzC99VYFR6s/JcHwIFIH8X8uWVWBCnqou7FIox/tGrrW8n+7lPFovPKxLgGAZHli98lcZnO9Xq+pCtHwdFJ/zVtDmXaGBikm+Avz4aQVH6NbUM15u7flDNgz0ZtqhWC3gmrGxlZfd9s1Z2YKBxQs/QR31sAL76a/SViNoUgr93CI8Jx0Gm3DbqpmaAdZ9DRW3RG94dHRgq9N6hDbZA7IX5syYXqyQ0Ogc2se3CCaempwn4qgemMXElkd9x/5fJtI0R+rzIGdZ9lUly50RRXA/WSSuQRY5tBXEolg6kD76ux4SNpTj3cKiJnfPnkdjTRhbNe2kLrXjLySnikdKMJnb5S7pKT2KmmkT0Lt3p61clLH7QygOAONlOr0uVrUnQAXyPYr+LBtbg8gW9jVjRTwCIELUiunvhb98iJeGi7TfwmGfvSbQdW/L3hbaVbewceiy17Tg6qTGd8oK57FhD/+WaVYjC2hTVNLnAY0ErB30777L2PiL2MaMzGuxNfn+61gIC5BFuXiMOorZoqXUi4KyhhK9S7zWqJ6OuQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(40470700002)(36840700001)(46966006)(81166007)(356005)(40460700001)(186003)(5660300002)(8936002)(86362001)(1076003)(316002)(54906003)(6916009)(83380400001)(26005)(8676002)(36756003)(7696005)(70206006)(2616005)(2906002)(70586007)(508600001)(426003)(336012)(82310400004)(16526019)(4326008)(36860700001)(6666004)(47076005)(43062005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jan 2022 03:19:26.1282 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 221e5ef8-b465-4c19-9df1-08d9dbc3a9c2
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT012.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4445
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
Cc: Tao.Zhou1@amd.com, Hawking.Zhang@amd.com, John.Clements@amd.com,
 yipechai <YiPeng.Chai@amd.com>, yipechai@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

This reverts commit 48e175f7476c6deb7ccf1f10d081322d52830a17.

Xgmi ras initialization had been moved from .late_init to early_init,
the defect of repeated calling amdgpu_ras_register_ras_block had been
fixed, so revert this patch.

Signed-off-by: yipechai <YiPeng.Chai@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c | 7 -------
 1 file changed, 7 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
index 7a1d2bac698e..c92383fe7834 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
@@ -2765,19 +2765,12 @@ int amdgpu_ras_reset_gpu(struct amdgpu_device *adev)
 int amdgpu_ras_register_ras_block(struct amdgpu_device *adev,
 		struct amdgpu_ras_block_object *ras_block_obj)
 {
-	struct amdgpu_ras_block_object *obj, *tmp;
 	if (!adev || !ras_block_obj)
 		return -EINVAL;
 
 	if (!amdgpu_ras_asic_supported(adev))
 		return 0;
 
-	/* If the ras object is in ras_list, don't add it again */
-	list_for_each_entry_safe(obj, tmp, &adev->ras_list, node) {
-		if (obj == ras_block_obj)
-			return 0;
-	}
-
 	INIT_LIST_HEAD(&ras_block_obj->node);
 	list_add_tail(&ras_block_obj->node, &adev->ras_list);
 
-- 
2.25.1

