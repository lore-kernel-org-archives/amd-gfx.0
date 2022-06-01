Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7E994C433EF
	for <amd-gfx@archiver.kernel.org>; Wed,  1 Jun 2022 23:13:19 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E3C091125B6;
	Wed,  1 Jun 2022 23:13:18 +0000 (UTC)
Received: from NAM02-SN1-obe.outbound.protection.outlook.com
 (mail-sn1anam02on2043.outbound.protection.outlook.com [40.107.96.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 732D511266A
 for <amd-gfx@lists.freedesktop.org>; Wed,  1 Jun 2022 23:13:17 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IayVqoIdtijt7uQsFGnc0Rp3ZuJKU83NsKQlZ1thy/+qq41ZhCYbK6GRbJWqdvoLC+7V3eIhWZB30Xdn3Wln54h4nsV+M+DxO1OoGm5V31JLlO9MaCwFfGISVIj6j1XN5as52SDxrnzZ5WZnzDv1TOv/xs426hFBwpXAsAlT7/LcpFvkmunCVa5Yqy0zI0oxtZQHocjZZeHso9bsuYAk8x18VroFHIRFkmMDbufvzEdFGQIIU++cgryD5PlV/NT/lIl09aWTEil52tBpuYU0b+PzaKrQQTW4WljOnf7GN22Ldg2KfaaTSS6B+yt+kvrWb3WAe/SVR3GaVXGQ4MJbrg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eZE7R7bkdMmpYOGN4YYm5S9F0s6WTvG7Gihy7wNqOjo=;
 b=F3NI0iEZFDzosDBI7FzaPRaJcUMuEbbgpDh7Sy6SFtn04ViW6gpgD+ltFZ5+/p3MRKtCr49d3OdjocoFb0PFlmcXjlsMsl08kk3M2GKpSYhpnXQNxNQbYXAfde87bQjDwklNaBcGjsp9pO/jPSIZm94wz4d7XE2BEOHkpH884GqzWSVR5r0MPihVwamsRtfeNN46BmFwqsNDh+xnu5d4+dQG7DDeRz3RkFseDvS9mLSpcCvGGaAlmoLYRLRwvlz+ViQ9D/A0cVT92FaqecOfATDQHBqoev9SSVDussTGTCBYljneRaha3pxKYwK7828ms7ZHo2Hn08uIUXB8IvXbIg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eZE7R7bkdMmpYOGN4YYm5S9F0s6WTvG7Gihy7wNqOjo=;
 b=fUQdynV3fzOCJLXkS8iViQJtiiqIRUCz8+UB+f5OQc27dzORSfkoshPY5P0aO3uCRN+pPhQJw4e44ZriVidIFY9pqG/75tPY9f1c2D8tHfULsw+no8NYgDak/oY81cuDtjgPU0kuotOAjwF5eKA8EYKX9HNr/pqhDNtQJ5JAYZw=
Received: from DM5PR04CA0040.namprd04.prod.outlook.com (2603:10b6:3:12b::26)
 by DM4PR12MB5327.namprd12.prod.outlook.com (2603:10b6:5:39e::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5293.13; Wed, 1 Jun
 2022 23:13:15 +0000
Received: from DM6NAM11FT010.eop-nam11.prod.protection.outlook.com
 (2603:10b6:3:12b:cafe::2a) by DM5PR04CA0040.outlook.office365.com
 (2603:10b6:3:12b::26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5314.12 via Frontend
 Transport; Wed, 1 Jun 2022 23:13:15 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT010.mail.protection.outlook.com (10.13.172.222) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5314.12 via Frontend Transport; Wed, 1 Jun 2022 23:13:15 +0000
Received: from Philip-Dev.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Wed, 1 Jun
 2022 18:13:12 -0500
From: Philip Yang <Philip.Yang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 1/1] drm/amdgpu: Update PDEs flush TLB if PDEs is moved
Date: Wed, 1 Jun 2022 19:12:46 -0400
Message-ID: <20220601231246.28716-1-Philip.Yang@amd.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a3c7c7d3-1b5a-4808-aa4d-08da44244eda
X-MS-TrafficTypeDiagnostic: DM4PR12MB5327:EE_
X-Microsoft-Antispam-PRVS: <DM4PR12MB5327CE1AE12B253BBF6C375FE6DF9@DM4PR12MB5327.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ubiqvHe/rT5/9SwrWsV62Z1uf7PnmdZ9L2xFusEWYnwvX7k+XPvtG/7ngyj1YmXhVS//6oN+kjjmoDWyP9BPGNnW2hjjcxoT1j1y9/Ilp8iPK/sTzXKv47TETihREajR7qrV39JNtyxCBT3siAbhlnLrtoWuWlmqyJ+G7rWpiC9Kvt0fnIANB3NE1f23Hf6Cvx+sH6Oh67eD/OEna0De1sHrHh9lOIBVPUXJ49y1vFNKPTJl2jvms35p5MsK3D7pFWx2EXVF5Sezl4FixwZIDYSbexZhSckPeMNTMjEEKs7Ljnpl4I52tnbvIrX+PJNMTalneGFJWf3AedEHphQCD9Eu5bXGPQf2XPHCuLA/hSCJZNO1hVLbnw9GClqp0lshrhqWaiehiNKNn4KHUWXFvQkLYVFoE9rJg2v+hY/Ya+WRzda7wBA4IHBkXB9BHzgwJBxnQNu4DC9wOV/Ey7ulWW/JeimuUi2nVh6lqSn8uW1IJkkttnCZdyfKA01zh43/InU70p2rtPm2pCN7qGfLYHkzIfKNNq/rahVaGBHN7pYONrHcse9hBQMr1TRYrCy2wZvh/wunRp8hdBskVqY1XLKkar7g7CJGA4O7yJpeebgnYun5mKuhaqPCFYXMbph9nBtGBPBftj3uc+1R6xO7EQncUYTiZnAob2BDs6s5Vhb/prqCTby7KjsnhUpMu039sMyo490vMKhUoNfcWnYlEQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(46966006)(36840700001)(40470700004)(426003)(186003)(16526019)(40460700003)(83380400001)(336012)(70206006)(81166007)(47076005)(66574015)(356005)(36860700001)(1076003)(6666004)(7696005)(54906003)(6916009)(316002)(508600001)(70586007)(86362001)(36756003)(15650500001)(2906002)(2616005)(4326008)(8676002)(26005)(5660300002)(8936002)(82310400005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Jun 2022 23:13:15.7405 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a3c7c7d3-1b5a-4808-aa4d-08da44244eda
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT010.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5327
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
Cc: Philip Yang <Philip.Yang@amd.com>, christian.koenig@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Update PDEs, PTEs don't need flush TLB after updating mapping, this will
remove the unnecessary TLB flush to reduce map to GPUs time.

Suggested-by: Christian König <christian.koenig@amd.com>
Signed-off-by: Philip Yang <Philip.Yang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
index 9596c22fded6..8cdfd09fd70d 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
@@ -755,6 +755,10 @@ int amdgpu_vm_update_pdes(struct amdgpu_device *adev,
 		goto error;
 
 	list_for_each_entry(entry, &vm->relocated, vm_status) {
+		/* vm_flush_needed after updating moved PDEs */
+		if (entry->moved)
+			atomic64_inc(&vm->tlb_seq);
+
 		r = amdgpu_vm_pde_update(&params, entry);
 		if (r)
 			goto error;
@@ -764,9 +768,6 @@ int amdgpu_vm_update_pdes(struct amdgpu_device *adev,
 	if (r)
 		goto error;
 
-	/* vm_flush_needed after updating PDEs */
-	atomic64_inc(&vm->tlb_seq);
-
 	while (!list_empty(&vm->relocated)) {
 		entry = list_first_entry(&vm->relocated,
 					 struct amdgpu_vm_bo_base,
-- 
2.35.1

