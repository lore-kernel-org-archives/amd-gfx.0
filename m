Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C515EECAAD8
	for <amd-gfx@archiver.kernel.org>; Fri, 16 Sep 2022 15:05:45 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 07E6510ED73;
	Fri, 16 Sep 2022 15:05:44 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2070.outbound.protection.outlook.com [40.107.223.70])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8302A10ED70
 for <amd-gfx@lists.freedesktop.org>; Fri, 16 Sep 2022 15:05:30 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=e+LDFfC4OVuvs8I3BVbWqqi+gbDIQO2J3erHfdYgeDo13bIiqen4kCyeIm82yt3zFAO+bZTkSpu0Vmw57hmkyYHCOW2Y67iAK9P+iubo7Xm2dykpzYByAdZEol2eNDu2lWcYgNJ3SHAE/cQjvEiunTGJJ2A3q6j60sqf/J0ep/j57Nh761KjYjjp8gN3ZnKPrJYDieumMMBTfBT0D9EVseBW4SGQI3S5bjzry0q6QDhRU99NvLBww1v2vXq3YQhxPzsYfOnZ+rJqJSe6iYQHXMgy2ckd1DO0LOntuku+oTMtMpE962oGRG919/4MbxO4s0j1OBPZnPZbPCEY+MpHtQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Q4Ns4vAaqtsUFFKbcPIc2UUkUdeF1VwOgCAX1KMMtD8=;
 b=mgQ0QP0sW1zEubLeU6sugNQ65NILR3s/61bBT7fA3imGPA/gMTnMecMx7KCPfxwggc3z33XPVx2CiAVw1237HFvJ2rMd+pMxFpL4g6C4f5Xx0wC8WHEyeHmYgFGfP3U3rchu/ESpUL1I+o6XHPY/CggVglNkN0ejmevXbeK8Qvr+lN4owEqw2USoEdGACSu06+5hnqNxa/58wT+n4Pk3lca3mB9sT6JM01Ed0gTYHjoMfkEJ6jkG5czjVvvhoNipqrUBD430oEBowXFLSard58VFhwcOL0zZxQk2oKm/DP5apdLTe2TK4YAROb8o5hzW0obvVVGD/RjM+yyC9jHRLQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Q4Ns4vAaqtsUFFKbcPIc2UUkUdeF1VwOgCAX1KMMtD8=;
 b=ONJj+zURBvBnu3+vaOegIxgcgMK915BNj9rtl3/lLBWZd7xHCpElyu40S0SKtLIFbMf5oAfqLKTIBRcsTqy6rxHweW5DELqt8Ed6ULMoS9Cb8H2+h2IFFyWom60+qjZelbr8+NNDhowMpDi6+/9Snb7/vV4cmWfnLnGguBTTNJ0=
Received: from BN9PR03CA0094.namprd03.prod.outlook.com (2603:10b6:408:fd::9)
 by PH7PR12MB6717.namprd12.prod.outlook.com (2603:10b6:510:1b0::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5588.10; Fri, 16 Sep
 2022 15:05:27 +0000
Received: from BN8NAM11FT074.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:fd:cafe::f0) by BN9PR03CA0094.outlook.office365.com
 (2603:10b6:408:fd::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5632.17 via Frontend
 Transport; Fri, 16 Sep 2022 15:05:27 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT074.mail.protection.outlook.com (10.13.176.154) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5632.12 via Frontend Transport; Fri, 16 Sep 2022 15:05:27 +0000
Received: from Philip-Dev.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Fri, 16 Sep
 2022 10:05:25 -0500
From: Philip Yang <Philip.Yang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 6/7] drm/amdgpu: Use vm status_lock to protect pt free
Date: Fri, 16 Sep 2022 11:05:09 -0400
Message-ID: <20220916150510.31321-7-Philip.Yang@amd.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220916150510.31321-1-Philip.Yang@amd.com>
References: <20220916150510.31321-1-Philip.Yang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT074:EE_|PH7PR12MB6717:EE_
X-MS-Office365-Filtering-Correlation-Id: 4e5db83f-1b7a-4ec6-270e-08da97f4e3a5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: nhIzCi0Ri0IDrl3FWcZQ5+9WMM7KmBirVgHN9RWeG/FmdCZc5tWSdTZkkZvbU1yXRHN47bCdyleANc2QQKtR416CtkkIG9i2iAT+8CjLkJpNezFulaXSA7MqVkuhDGRnUmVTO9YhZzKoPEoJVw/Ci5AXtEWHOFF94NauA6ROGbg3Vp7mb+ZYQxlfseW5NukId/85gXOzDJ+K+4mTog9E0n+OIjGFtwmfsHCK100su3jzqCaNsH0+TLLqg4QgvP9VFYiwOPRN5/hTPKZfulzr1s+3L+vNQi8CeUb4cDRFKuj1q0N2Oc3Zh0Rhfi+sUcazuxcsM8TOzVfJsnTjWHUaMf1ip0a+ZA/XClbh6dkA7ylZISispIxUiXEDlXJALMgMH5CceuPG2TYcqhwrzJOJ8qzA+w19OFlJnKvlOzrrTAO4HCKuq2obbYOyg9gCngYW8Nc7YI1dEeAUZ2Ye8rN3Q74JID/3gjhYZaUpx7jIx4TsW4iy58LPIXLAN9EwNtLXztRdrI5N9YlO29/kIo5jBHcWKOLWEfoQj8bqrR2cudpJMIf34vvoNEyvSzxBf2/PxEbRR5VwnypyJ4h3SYcaOGDoxPXemeGQZTmtKjW8WGAgiOfvW/PZIGtt/WWp71orX5HZ6p2AzKDTkNmC6IktXkzFgU4ii3lvDKf1ZzJjRF9PCgQ5AE5ZKqZorNrXlQQyOP6eGAHaIQJ9E6TZPTVc9WvYMOBZHZ1pWLhlGo69R6aJkJxCM7lGR6Hz1duXsAXZL+q4rBCOJUGQwlhftKuKBJn4YbXW3DzbEHQd2B4jtLSmwpqUPHyrCewqsMv/4PKf
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230022)(4636009)(346002)(39860400002)(396003)(376002)(136003)(451199015)(46966006)(40470700004)(36840700001)(2616005)(336012)(5660300002)(7696005)(40460700003)(86362001)(41300700001)(356005)(186003)(47076005)(16526019)(36756003)(4744005)(81166007)(6666004)(82310400005)(316002)(83380400001)(26005)(36860700001)(8676002)(6916009)(478600001)(40480700001)(8936002)(2906002)(426003)(4326008)(54906003)(70586007)(82740400003)(1076003)(70206006)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Sep 2022 15:05:27.2318 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4e5db83f-1b7a-4ec6-270e-08da97f4e3a5
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT074.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6717
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
Cc: Philip Yang <Philip.Yang@amd.com>, felix.kuehling@amd.com,
 christian.koenig@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Signed-off-by: Philip Yang <Philip.Yang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c
index 88de9f0d4728..61a4b7182d44 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c
@@ -637,7 +637,10 @@ static void amdgpu_vm_pt_free(struct amdgpu_vm_bo_base *entry)
 	}
 	ttm_bo_set_bulk_move(&entry->bo->tbo, NULL);
 	entry->bo->vm_bo = NULL;
+
+	spin_lock(&entry->vm->status_lock);
 	list_del(&entry->vm_status);
+	spin_unlock(&entry->vm->status_lock);
 	amdgpu_bo_unref(&entry->bo);
 }
 
-- 
2.35.1

