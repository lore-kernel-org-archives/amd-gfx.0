Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1E7A5C678D4
	for <amd-gfx@archiver.kernel.org>; Wed,  1 Mar 2023 23:46:31 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 83FF210E34B;
	Wed,  1 Mar 2023 23:46:30 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2067.outbound.protection.outlook.com [40.107.244.67])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D07BF10E34B
 for <amd-gfx@lists.freedesktop.org>; Wed,  1 Mar 2023 23:46:28 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZI9E5OpVezxuM2tuKxc4hPQxhAWLPJdwyNaKPahz6kq1vOjd63f5J5FPXUiYiDi38CBRYYu25HJQYlRGEwKJ/o1OTd6fk/uABNGgKQ9YzFkJQMl23UN+x1anMr/X63XOUNvj/jttS4rVh0+7GloMi60NqBmptLjUV63ZHeDNMB/PQvHfX60OfxHtxaB3nnrDyeWVO/YgN+BipdfRk7CCsW5HdEnt2BPyUpNPfzxSREvIBuvSej/96BpNoLJ9Zxy1PIo8Vr0BdxhN/1GexBOHHHfqp4oqV77fvL7wHwEBU5X7aJxUCRiH3lFkJaPJIRSDzw4pNax7vD7o5swPFUenjg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=usFUxSsWj3dDL+L974hVKHVbzIpBxPWSgFHDv5ZkeoI=;
 b=HGf+QFzP+Lwg2cBHKpQKttfeaNZa7Tiog/mAuolSPH0g+G0T1H4kQAOsDdxBcQ3/RUF3gE5VLdgOnNfh/0Z93XER7vkW3o8dAmXyCeE5rR3iRRqGU4Mk1OYY2ZzWDX0dcuS8Bj156iv6KZ9lhWx95pkfeN1mhFIy7uYCEVlAVOwKGDRmCu25QlAlCKZ5U6UqmZNPlfJIcJ7T1h4Q0nnTtQTclEnc9CMl8WpgI6/Hy20+jQRovNvM5m/bL/Ks+Ffstkq0bCVgSDDnceTs38sDeWjLr4xPH62y+lU4zsDxzw27IkeZ6McKDVz/bbKzpbCtieEjajZ1qkJDbJZ5gPb9yQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=usFUxSsWj3dDL+L974hVKHVbzIpBxPWSgFHDv5ZkeoI=;
 b=qUXakHbvQIzastfZMGJ8zoR7nWJa4I009FKKPUFivxUwLrMdsQVxpHVkVVrU6tUN6dYF3ny/hEQU1insdJC1bn4xdo07pgVTPJ28P2ucHXsxUZUyFgikRUZ8kytRNYaVWzJv+Z0/L9bSXr+tljsfTUEOB6W7Lf1UAqvx5G7tr8Q=
Received: from DM6PR03CA0036.namprd03.prod.outlook.com (2603:10b6:5:40::49) by
 DS0PR12MB8217.namprd12.prod.outlook.com (2603:10b6:8:f1::15) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6134.30; Wed, 1 Mar 2023 23:46:27 +0000
Received: from DM6NAM11FT055.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:40:cafe::96) by DM6PR03CA0036.outlook.office365.com
 (2603:10b6:5:40::49) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6134.30 via Frontend
 Transport; Wed, 1 Mar 2023 23:46:27 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT055.mail.protection.outlook.com (10.13.173.103) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6156.18 via Frontend Transport; Wed, 1 Mar 2023 23:46:26 +0000
Received: from magnus.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Wed, 1 Mar
 2023 17:46:24 -0600
From: Daniel Phillips <daniel.phillips@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 1/1] amdkfd: Memory availability can never be negative
Date: Wed, 1 Mar 2023 15:46:02 -0800
Message-ID: <20230301234602.17113-1-daniel.phillips@amd.com>
X-Mailer: git-send-email 2.39.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT055:EE_|DS0PR12MB8217:EE_
X-MS-Office365-Filtering-Correlation-Id: 83236026-2879-4ab9-3975-08db1aaf2c19
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: fk4CkJ6rIuilbxTpSG0WqyB05WsqELXvNVHBEYjRqon5UnaGte+Ek2oZO5SmpoB8Qk8s6DuywgOJuHeoLuEDxJb7+UgHC0VNDs5+dbTr3PNVtzzrIICtMaz/xjrkqhQ+CpjzceJ6wt558AY3Pz+0/igVsBswyncNaGM+3+bD3GgrFg1qtyvvRo3e40TkmMukr7ObMjx29Nsy38KlQla4J3/r+vHnQbj4e1XgY35E5DQjnpsfQ2bEMSCvhAcO5ALuewUlx5Ef639SPUwKzKH7t+5RmoQUz0Hm/2MgDJE4geZmROJ3RN7s7AkbEbutALnTxaWawEt5y8xFAle9gHzYXNBoBvdIhxau08IFu8dAIKpKwbkDIX3du3RKNrVAqwyJiRe34iKfbYu96pBhibK29SXc2Io6rLV16eUZYJDR8P9ZXUgTv4evwLXqNy/nKrMjOXtIsMWZ+pVM9219bxnxDeYSJvtSB0djvr1D6ikUyUH02bbxTUGGdVr1MLs4H6kR/cOV50H6ql8k2CEtGfKEkZ/cO1aYfd3FXNtLat6smcRcF1vkOsMMTjiKeP4GXfJlcyYX9mF4tU/RPwyxSE0eErs7y/08MzyV9/lFmn67y0wZi8yUzNzj3L6yFhrfZjgbSeF++rtteCsh33I8fgdJrXrlOvG0uB1Twl6ax2FYOYO/9kUfXy8kJZslLofD+aCZiEHoA3vpOpOKyPm3aA6vaTbdmc5bx2QmB8pTZ0NXXYQ=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230025)(4636009)(376002)(39860400002)(396003)(136003)(346002)(451199018)(46966006)(40470700004)(36840700001)(36756003)(86362001)(5660300002)(40480700001)(70206006)(6916009)(8676002)(8936002)(4326008)(41300700001)(44832011)(4744005)(2906002)(356005)(82740400003)(36860700001)(81166007)(6666004)(316002)(478600001)(54906003)(7696005)(70586007)(82310400005)(26005)(83380400001)(47076005)(426003)(16526019)(186003)(40460700003)(336012)(1076003)(2616005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Mar 2023 23:46:26.3881 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 83236026-2879-4ab9-3975-08db1aaf2c19
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT055.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8217
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
Cc: Daniel Phillips <daniel.phillips@amd.com>, felix.kuehling@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Our assumptions about how much KFD memory is currently available for
allocation may be violated by various complexities so we define the
reported value as advisory, however we should never report negative
availability.

Signed-off-by: Daniel Phillips <daniel.phillips@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
index 6f236ded5f12..293f9b2292fa 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
@@ -1583,6 +1583,9 @@ size_t amdgpu_amdkfd_get_available_memory(struct amdgpu_device *adev)
 		- reserved_for_pt;
 	spin_unlock(&kfd_mem_limit.mem_limit_lock);
 
+	if ((int64_t)available < 0)
+		available = 0;
+
 	return ALIGN_DOWN(available, VRAM_AVAILABLITY_ALIGN);
 }
 
-- 
2.39.0

