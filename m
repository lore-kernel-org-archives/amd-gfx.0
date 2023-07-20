Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EB603C001DC
	for <amd-gfx@archiver.kernel.org>; Thu, 20 Jul 2023 19:20:30 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 942E810E17A;
	Thu, 20 Jul 2023 19:20:30 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on20626.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7eab::626])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8F14C10E17A
 for <amd-gfx@lists.freedesktop.org>; Thu, 20 Jul 2023 19:20:27 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Q06ULTMhPReH5Iyq/oveNy3GkKqVhVju6JNPCr+k7Iv4SIe/Y9iXQPHj3+FRPAFfYucQ/JQqNKuDzi0ZZpFzZYV6hHc/pOEilh6JfCdITPg8YGHp+ziMhCwUbyK646pA8TdyvXUEHHsq3VD5lWwK0hocJL4wLPMieO7VOjrX3opUMQUo3gcpAZjRQ0CW+R2BLcdbwNysUQ8yWbx0Is+eME47adMS5PDDyGUV7wwa+63u5zbGzNQ29WnUuTwAQLrfaM8JGc7gtOPkLoyI6pvK9aWoUzzX7h82F4yTofqq4uBCabXoLaZJr0okktFCWd7PyVa40EET8VtMIUq1HEwX2Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=f8dKELHMvfZj35vCU4Ur2oF38fen2E2CDyIruwlBFjE=;
 b=eVMyP/4XdkMXnxLXYD1TqNHn+4wTkMBajf4oW6V5V7jsjJPTfVHW+ocLBY6VL6IVhuTpRm5tu2LOrWEbVQkd1ysvUQ8A0g1/u2NVBg/5Z9JN6AR8dwnqZK3K5Ih7DboSs/TkzL6TDswOx/1g4rCQjTygjPGW1ImrmLXaxlNoLKmi5epMBDaOElg+fma6y1zLEFL3HtpVEM2wqW3rxpVNWxQqEbMF/VAeXxbPhTWAvQIVh69EdUxhAZb1lCkrNxzwPTe7NwvIZuSFhClllzWNFl+En0v+cwmXuT1btNu3ZS4zd3z5+6RJH8+L5zD6aZWA6d8N01bdfmGz4d/OPLmq6A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=f8dKELHMvfZj35vCU4Ur2oF38fen2E2CDyIruwlBFjE=;
 b=M0LljZIuBYsnZFDrsdSFQAbOSAf6M4OdlYCbFoNhnLV44dTEWbVCSflxNaBjCg5ImcIr5YpIrKevt5mD4bRfSPYxNmbWc6OvMuQil9+fiu0YZW0D5CWywIuA0O9KeAHXlFVO2aHKuR3B/afNj2Ku6C9wIJz6FJuIAh1prXRXMnY=
Received: from DM6PR03CA0065.namprd03.prod.outlook.com (2603:10b6:5:100::42)
 by DS7PR12MB5909.namprd12.prod.outlook.com (2603:10b6:8:7a::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6609.24; Thu, 20 Jul
 2023 19:20:25 +0000
Received: from DM6NAM11FT015.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:100:cafe::18) by DM6PR03CA0065.outlook.office365.com
 (2603:10b6:5:100::42) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6609.28 via Frontend
 Transport; Thu, 20 Jul 2023 19:20:25 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT015.mail.protection.outlook.com (10.13.172.133) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6609.28 via Frontend Transport; Thu, 20 Jul 2023 19:20:25 +0000
Received: from sdhume-SYS-7049GP-TRT.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Thu, 20 Jul 2023 14:20:24 -0500
From: Samir Dhume <samir.dhume@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 4/7] drm/amdgpu/vcn: mmsch_v3_0_4 requires doorbell on 32 byte
 boundary
Date: Thu, 20 Jul 2023 15:19:37 -0400
Message-ID: <20230720191940.780187-4-samir.dhume@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230720191940.780187-1-samir.dhume@amd.com>
References: <20230720191940.780187-1-samir.dhume@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT015:EE_|DS7PR12MB5909:EE_
X-MS-Office365-Filtering-Correlation-Id: 9b4de878-b0dd-4f92-bddb-08db89565ed4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: mVu+EwNtO6uHR5WzLq2/n7X4f1djMhKcyS8nSdwcnj/65Wi458i5OpWbJGw8CfgH7LsY5XOAalj9JGb9ubGJtCrApcPVibUaEfpUtERJyT75RefjnjpN4Ls86Y+UMDITcUZwQgvYntWfqbotHqOQCwTXJUcj9/DZzgNKN3c416g39xV1TKoJDqWZ0L0oRiCwGQ0+2TNLXOs0EHvKLsGT8VIQibYvq2Bgyn0dORR0ztNCZt923sNnqbWZ/npKiNl359U5ZFjtaTTBSytkrLwJ4pNnUMkF99aGegN92xWmULqkzVGI7yoiEwQwlxnWIBAGsKgxVN6DXCZRlUKJvWxFTIyOkOO471z2diW5Oanor/1UoRxTtSIPfsazHq5WpRfRZtYkcrhHErc7J4I3E90Jw7ugjs/6kCNgIHtOyeBzwAzK3aHYNBs5GtZJZxBiMPSI3tUTwSlape1oUmXa+uKe89wrrSrx7um1zseGY1cF/SG7K7/v/p099eW/EzJ6GiGh3Ph1JVVsKFFF1/a4xidTMMXFJJatcobCvAYZ+MJ5R5ckxuhLbS4g6/RuzSLXYF7wQr/r6EWjVBJ3XCMAEKJy4DtFRQE7zJsKqUPdKQ1e4JdBRefobZTUi7CfkFlesllQkPfJT/xKDfOsrEGtgH/HUlB7KRoG9nZTT5PYCpkAA0P/5UwuuMNFw8LYx0DVMemwELCVw01xYVax/oTBVVCBsqU5rSxjOlHWJk7Jkw4WxUAXwcYrxl81VewYmWtEIiFVA0zqQOC8PVyzaQFs16KCAw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(376002)(346002)(396003)(136003)(39860400002)(82310400008)(451199021)(40470700004)(46966006)(36840700001)(1076003)(186003)(336012)(26005)(478600001)(316002)(70206006)(4326008)(70586007)(16526019)(41300700001)(6916009)(6666004)(86362001)(7696005)(8936002)(8676002)(44832011)(54906003)(5660300002)(36756003)(2616005)(426003)(2906002)(40460700003)(36860700001)(83380400001)(47076005)(40480700001)(82740400003)(356005)(81166007)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jul 2023 19:20:25.3469 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9b4de878-b0dd-4f92-bddb-08db89565ed4
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT015.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB5909
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
Cc: zhigang.luo@amd.com, guchun.chen@amd.com, gavin.wan@amd.com,
 lijo.lazar@amd.com, Samir Dhume <samir.dhume@amd.com>, hawking.zhang@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Signed-off-by: Samir Dhume <samir.dhume@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c | 13 ++++++++++---
 1 file changed, 10 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c
index 8650e3c6288d..09b3fa707af6 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c
@@ -113,9 +113,16 @@ static int vcn_v4_0_3_sw_init(void *handle)
 
 		ring = &adev->vcn.inst[i].ring_enc[0];
 		ring->use_doorbell = true;
-		ring->doorbell_index =
-			(adev->doorbell_index.vcn.vcn_ring0_1 << 1) +
-			9 * vcn_inst;
+
+		if (!amdgpu_sriov_vf(adev))
+			ring->doorbell_index =
+				(adev->doorbell_index.vcn.vcn_ring0_1 << 1) +
+				9 * vcn_inst;
+		else
+			ring->doorbell_index =
+				(adev->doorbell_index.vcn.vcn_ring0_1 << 1) +
+				32 * vcn_inst;
+
 		ring->vm_hub = AMDGPU_MMHUB0(adev->vcn.inst[i].aid_id);
 		sprintf(ring->name, "vcn_unified_%d", adev->vcn.inst[i].aid_id);
 		r = amdgpu_ring_init(adev, ring, 512, &adev->vcn.inst->irq, 0,
-- 
2.34.1

