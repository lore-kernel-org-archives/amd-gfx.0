Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E54A4606A326
	for <amd-gfx@archiver.kernel.org>; Thu,  5 Nov 2026 03:07:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=2UvO9O7/
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7D88F10F6F3;
	Thu,  5 Nov 2026 03:06:56 +0000 (UTC)
Received: from BYAPR05CU005.outbound.protection.outlook.com
 (mail-westusazon11010036.outbound.protection.outlook.com [52.101.85.36])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 54B7E10F6F3
 for <amd-gfx@lists.freedesktop.org>; Thu,  5 Nov 2026 03:06:50 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Fa+bB32T57wU1h+trhEKMlQu6JJMxGpRuFQcbiinfPdfXzy+GNOd0WS3fy4/AzC6f1KzP6tz7yBYLZ3Zn4qS6KfuiJQPmHGZ1962qeXRe+ef+TCGxU32lijaQ+2de90av9Wskqp91cXzK/n8K7UYHrb5V4tLqjHY0T6ftotiwsfDTheibSywaheUhACpIrwqlRfTb1ZO0Ei3Hhr5TAzfZqFpeda+50Re6rJ5d9nxNjGPjkQXkIh4dUyKEjL615eVY2H5UtxMW16HK09c2lRJ1JpNG37ADivYpyt3Eh3kHUx32cmKFTzEaHuCeii0b4BFX1OplodHCPUWBCuswM121w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=voWGuSfkd4QhU6//1aI5syyCaGHjx5t6ICXziuNPk4Y=;
 b=onkmsE9/TUcmiRjRmHGipJ5xH1icUJFNLO1mGUk8KRELsZYK4Bu+kcFDd1b3LKMOQo46/iKHyI7LSSQiH60AdzOTPu19lWbl5PbAQ3Tnns19ILZ1B0nI0FffhHx8geytkgh3SP+lM+zPtIDvYx10qTj2yhKO/nZrMJ8DRZCgZHoRyiWViWpUx7S9crMvaE4NufsiJoEiSPd6u0wHR/uCyOWkTUUOWWCLJmVV5Jb3eaMeNkT0lYDKDk3pLncxx9xKIuoTYWkNmaJI4LqgPSG1E7uf6tc9ii+MBEMIIXrKaqcEPGe9BNFcFQJUMRoYBm2dGuOPzHm2Je/NimtwKTu/lQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=voWGuSfkd4QhU6//1aI5syyCaGHjx5t6ICXziuNPk4Y=;
 b=2UvO9O7/1RudIho+fs5ULAxV1ZCU+E/n3LTqZuPSYZn00pfJyCJr99ArTvJCA+8LUoLmef0CubB7w5BMaGSM0rdZZJBfEpLMoC4Zy7DEQM9dARThgoqfxC5RmmR2nJJs4oyuH+lR7jL00/L6kQKAG7o8dbLuKVxWL0KOjSgXklc=
Received: from MN2PR11CA0028.namprd11.prod.outlook.com (2603:10b6:208:23b::33)
 by DM6PR12MB4074.namprd12.prod.outlook.com (2603:10b6:5:218::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.569.10; Thu, 5 Nov
 2026 03:06:46 +0000
Received: from BN2PEPF000044A5.namprd04.prod.outlook.com
 (2603:10b6:208:23b:cafe::73) by MN2PR11CA0028.outlook.office365.com
 (2603:10b6:208:23b::33) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.592.10 via Frontend Transport; Thu, 5
 Nov 2026 03:06:46 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN2PEPF000044A5.mail.protection.outlook.com (10.167.243.104) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.592.5 via Frontend Transport; Thu, 5 Nov 2026 03:06:46 +0000
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Wed, 4 Nov
 2026 21:06:46 -0600
Received: from JesseDEV.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.53 via Frontend
 Transport; Wed, 4 Nov 2026 21:06:43 -0600
From: Jesse Zhang <Jesse.Zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, Christian Koenig <christian.koenig@amd.com>, 
 <Lijo.Lazar@amd.com>, <timur.kristof@gmail.com>, <Mario.Novales@amd.com>, 
 <Manu.Rastogi@amd.com>, <Jiongyu.Zhu@amd.com>, Jesse Zhang
 <Jesse.Zhang@amd.com>
Subject: [PATCH v4 13/13] drm/amdgpu/gfx11: enable the gfx engine soft reset
Date: Thu, 5 Nov 2026 11:05:55 +0800
Message-ID: <20261105030612.726542-13-Jesse.Zhang@amd.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20261105030612.726542-1-Jesse.Zhang@amd.com>
References: <20261105030612.726542-1-Jesse.Zhang@amd.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF000044A5:EE_|DM6PR12MB4074:EE_
X-MS-Office365-Filtering-Correlation-Id: 9728d741-137d-41a3-2b98-08df3ae9d3d2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|1800799024|376014|36860700016|23010399003|261022105027099003|261026140227099003|261022075727099003|261009223027099003|261028144727099003|261022113327099003|10067099003|56012099006|261026121527099003|261021121427099003|261102123227099003|11063799006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: qf4VVaLJX3x37c8zHxOZ6R0DyN5PJU8oZ0p3PvCZbMA1LHOtLQNGEXg+LTJJekUQCThvAdwm3Qq4jHf0b0KXZHw0XipqOp64T4vXTuFrnrN99o9w1Dw4pKHKfshEFP8ZLYMJlgfhmGFgT+PRea3DrykpnBfme7xvwTCx9i0JKFSu+lG1UYQCjhJAd72Rhh+mL0G1rt8gGCnFcGDsXYrBlwFG5mNxKUSLRahfyPutGovY3ys6WHo7LNYsjkDcbcGylbHYo7PTfM2k2/hqEG8mbU5WAZZ3WTptCFp3QLAq208G3RIBy55T4ce5K6K+SywMxIYkxsDL5MIifBu81V0eX+hfP1fwxoLmTHDqOtWEy6yoNcq1RrRS4+vdGWXsHNQCQx+Gc7QZZ1qJYbVvt+P0lkGbFpfGRi+nsuE86ZsVulgf/IJrMg0USz+x/MesaXyYBWmzj4WhkjtwA2gfH6WnHGb0kYHi9Ix7aT27n5xVxFQIldrOVXE9PUbUo6k9xAhzRkRuWjUEVJC/9s9aclVUL9A/PpIWhEfBf9PncibCJzr31rAYHQjpGKy+T8OQFUOtH+ldsCWjfufhgVe6JcWKnVUJo84NjBdO8KWIigPEcYH/Y0wqeKOqqeYSKkT0AzZg7SowqRqVN87CwA1X7Cmk7UPf6nabZMyKG3i3sQY7P6JRJoLXQO0fTu34r3/jnle/bOC6Fyl/t9IQlUclOs/oRg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(1800799024)(376014)(36860700016)(23010399003)(261022105027099003)(261026140227099003)(261022075727099003)(261009223027099003)(261028144727099003)(261022113327099003)(10067099003)(56012099006)(261026121527099003)(261021121427099003)(261102123227099003)(11063799006)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: F8zv/qoQWnf0tYTsVEj99pPp/J6rQrYHOM8qz0KP6B+tv/uF3C5+wHHmFl284x3lfSOyq0drZiK1W8D/25GJpUa8xGBawkvbrNQP6qeP5+nidfRADT+LbbigKBsAipWxFULevuMnKQMd863VwbkBHIvU+trJJd7jhjRaEjx0G4LQOYuAp+Mx9H5luZfALhcT2OSzAlDA0ngzZ1awRvdvXYU4ytXiNywd+iSOZe7WY+SRhAhS1406z3S7X9wtzi5KUG5qXqfmeiG2fb0IAXtjcBe5J5Op3pN+PcdCIVTk1nTJOjtF3v+Ec/ay06yzHHGZCfnW9gCBML4vnyYwHGpJPUmjWGRZrhY6Q8UXSw2BaY8RcQwXkqhq+n4ohgVI5Okj3jfaIa9kw8jyZY4mIhfELYkjA8Phd+m6/UUp/XE3NZ7/Z/tE+/6+09KS2mvqck5Y
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Nov 2026 03:06:46.5014 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9728d741-137d-41a3-2b98-08df3ae9d3d2
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN2PEPF000044A5.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4074
X-BeenThere: amd-gfx@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Discussion list for AMD gfx <amd-gfx.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/amd-gfx>
List-Post: <mailto:amd-gfx@lists.freedesktop.org>
List-Help: <mailto:amd-gfx-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/amd-gfx>,
 <mailto:amd-gfx-request@lists.freedesktop.org?subject=subscribe>
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Report AMDGPU_RESET_TYPE_IP_BLOCK_SOFT_RESET for the gfx rings with MES,
which the reset uses to map the kernel gfx queue again. Not on SR-IOV
VFs.

The kernel gfx queue and gfx user queue resets then fall back to a soft
reset of the gfx engine before a full reset. The IP block soft reset of
gfx11 only resets the gfx engine then; the whole IP block soft_reset()
isn't used.

v4: Not limited to the RS64 firmware anymore, the reset restarts the F32
    PFP and ME of the APUs too (Timur). The soft_reset_engine() callback
    is set by the patch that adds it. No async gfx ring check: they are
    always used now.

Signed-off-by: Jesse Zhang <Jesse.Zhang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
index 80b91459f5b0..396fe3f6678a 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
@@ -1941,6 +1941,11 @@ static int gfx_v11_0_sw_init(struct amdgpu_ip_block *ip_block)
 		break;
 	}
 
+	/* The reset remaps the kernel gfx queue through MES. */
+	if (!amdgpu_sriov_vf(adev) && adev->enable_mes &&
+	    !adev->debug_disable_ip_block_soft_reset)
+		adev->gfx.gfx_supported_reset |= AMDGPU_RESET_TYPE_IP_BLOCK_SOFT_RESET;
+
 	if (!adev->enable_mes_kiq) {
 		r = amdgpu_gfx_kiq_init(adev, GFX11_MEC_HPD_SIZE, 0);
 		if (r) {
-- 
2.50.1

