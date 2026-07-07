Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 39D84C43458
	for <amd-gfx@archiver.kernel.org>; Tue,  7 Jul 2026 15:42:23 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C9C0F10EE26;
	Tue,  7 Jul 2026 15:42:22 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="CtdEY6jE";
	dkim-atps=neutral
Received: from CY7PR03CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11010026.outbound.protection.outlook.com
 [40.93.198.26])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C1DB910EE1C
 for <amd-gfx@lists.freedesktop.org>; Tue,  7 Jul 2026 15:42:21 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=doYm3NQotaPuOU4hws2aB3VOxFtu8kGJXN4406IZo1GiIi9MB9BzrTqQy0+yNxb70OmLCXEQtRsk5dNS6B+VVQfcBb1ChDoAtmVYt73gNASSgLJTOFbbxGqt+L8eWW4fYDkUA1DnyrgQpvDzSoy32xcRxEN+bZwoS7eelPmuQP3KvRv94hbN6JVx7zBsHaFjj6IMyWdQ6ed7KuQxyoKDCjTA6lMwDgqzAuBkuobHjCkXF7VRZoK48E6oNIglPEOooL6SDHZzM6XM11ivWyI0tFYM8laXPzyErE/Iig4BpHmSo7mBXvvzwqps4IE3Eq04g80tcebrN6IGU9n9MhQ0Dw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xUAKVhpDS+Ks2o0bAqVSiJoNuj/9BVzvCXetxarbvrI=;
 b=nGQPQd+jGgL2jqK0AMiDHo3Gh5ueyYESRl3GLFP6zkIm6hRD4tASMKMm/KyUgnB2kaSAmCpC7uT38UrCFP7fZBFPeVKUFaQd4L3RSYk4IoIJGn4hVRKbd15oIPyAsYTSIwZ9KML5IDRI3nDUdovIbXLBdcO/8oD1HcgLzOOSLcIzMAToeKMjm0vUq3JlQ+dfHhXRRXn8HFRdYvoAYMRReU7R5TRK8sxjPHFybPvwCys72tsMPiu7EdMnVqGF0SmPkj+kptU0ZIs07SIvQpn8X98rqp3UQehOUhZtzWcCwg5Eg1uf0QcnDeCBRTVwPB7KBt1Iqe+HeheW0XOyWxBGtA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xUAKVhpDS+Ks2o0bAqVSiJoNuj/9BVzvCXetxarbvrI=;
 b=CtdEY6jEnPZLShg+IuoAxO3jpknkTtE7G6uGz1qMIoNsZr6ps3XnzGitimXmHHsIKGV6xALYGK9Jc/ZkgLxMCs9rGMJEKYItni9KWPn5mhttM1ibzWgIcszH91pBr639QUgoJUuyXe1WCLwHvXZHAZAeLuTGnU4BwcLsAgn6G0o=
Received: from BN8PR04CA0050.namprd04.prod.outlook.com (2603:10b6:408:d4::24)
 by PH7PR12MB5593.namprd12.prod.outlook.com (2603:10b6:510:133::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.10; Tue, 7 Jul
 2026 15:42:15 +0000
Received: from BL02EPF0001A106.namprd05.prod.outlook.com
 (2603:10b6:408:d4:cafe::20) by BN8PR04CA0050.outlook.office365.com
 (2603:10b6:408:d4::24) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.181.13 via Frontend Transport; Tue, 7
 Jul 2026 15:42:15 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BL02EPF0001A106.mail.protection.outlook.com (10.167.241.139) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.181.6 via Frontend Transport; Tue, 7 Jul 2026 15:42:15 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Tue, 7 Jul
 2026 10:42:13 -0500
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Tue, 7 Jul
 2026 10:42:13 -0500
Received: from p8.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.41 via Frontend
 Transport; Tue, 7 Jul 2026 10:42:12 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 01/30] drm/amdgpu: return an error instead of BUG() for CSA
 bo_va
Date: Tue, 7 Jul 2026 11:41:34 -0400
Message-ID: <20260707154203.2603209-1-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.55.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF0001A106:EE_|PH7PR12MB5593:EE_
X-MS-Office365-Filtering-Correlation-Id: 4e6bd8c1-e382-4c8d-c53e-08dedc3e520f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|36860700016|376014|1800799024|82310400026|18002099003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info: A6mA/iz+j1Xavy0uLZmz29uP/Ohx6DDY0Fj97i/dVwKTmvwj3qPf3iTAVAqwYqd7MR49g7Ju58e4kUYqMyAyBxq0PPL/UNbkqU/Hps4suexqMbpjERvQaJUtxT1f9Lv3YnW3ZAtfMlrR/VchnW6l8/m1AKcAW4qsRW2bTO+7cEK2yMrExxm/RtUB6HEGmb3LfCbUJ65NcqPVCTdi/bjC5z/SkbIH4BEpq/+PwxlaPZLYmOsuSDccrb5eWqdZUGPHfOpoECMcD38wEeyaU9fA9Rl5h0clgd5nKFPQPbptSg90mIpcfHM0INihrb6oDapn+3lYCYyEDbugKq5Zr5C3gEOTUIaR2vmH9h5Oa1OIhlS5TrAtF8vWjoXZASLbY57evy5SSixunnhLFAlWVCfpnFmkJm4NQNkDkAXnIrla+oJZxfL34WHLZLeA6IG8GJAhtQA72B/z6nPhs5xt/1FP0F2tbRKU5nEwmpLrejB79+IP+3JGtEu2kPBiVcX2/2FPHXoYp72X0wFzQNCJBTSLjl8r4iYGZzNbLD6jKKYFvs58J1DDCjtTHSKR1k7VnrhkiMpp8cB4Bh/C1/7UM00CmiI/eWMd0ORjnnQUsUgu6iNu/fm8Xt9N1UCzcrswnh9DSPezxKTijqsKgrDAtB6RelAn5XFf0E+m2gNuPzVzirkEToOmK+j1OWwCye9r2VAr8cZd9pMXw5VK9siFv80WaQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(23010399003)(36860700016)(376014)(1800799024)(82310400026)(18002099003)(11063799006)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: BdWM/gytdALypAelqlYsC6zK0Wq9NGZ8rjWH7q1kqLyseHNqEVxqMxkgQyT+hDcEy4lQiEIC+rinp08aU0Zw13r4OseT1GrNSUB9Obo22Hlt21fUJ7OUwfXfy/CfKDg1vUd9hUQfe/rrJLFbiz2wLIoOI/OFj76giqAo04SDEry2bCKZ2b68KvF4fOJJaeJcdMUSTXuWYtDCahMZ6YdD9NJUMJV4xQjIbBcRd8gpOJ1qgyEkKcCeV34ye/UXutm4S66JhLDeQLgF2DJq9FlXm6Vi+RhGoRNoOWfSR08c11YJzaNN3b1oTlM/TgtkWxPwPmyu/uMwLvw9qdfcpcNElyhhomJl+djbMLQKZPWjAw8/iybj9d+A7KjjGx9VrIDwy+e/6THbpjDr9yDJBJPiWC7ynLL1A75k1Wku8ntFQUZK7+lfQxTKQxZss7nwIDuE
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jul 2026 15:42:15.5612 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4e6bd8c1-e382-4c8d-c53e-08dedc3e520f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF0001A106.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB5593
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

If the bo_va is not present, return an error rather than
crashing the kernel.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
index a0ca6ab358c55..dc263553e216b 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
@@ -1121,7 +1121,8 @@ static int amdgpu_cs_vm_handling(struct amdgpu_cs_parser *p)
 
 	if (fpriv->csa_va) {
 		bo_va = fpriv->csa_va;
-		BUG_ON(!bo_va);
+		if (!bo_va)
+			return -ENOMEM;
 		r = amdgpu_vm_bo_update(adev, bo_va, false);
 		if (r)
 			return r;
-- 
2.55.0

