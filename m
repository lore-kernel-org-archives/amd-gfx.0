Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3E729C001B0
	for <amd-gfx@archiver.kernel.org>; Fri, 14 Jul 2023 11:06:03 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AE58610E09E;
	Fri, 14 Jul 2023 11:06:01 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2084.outbound.protection.outlook.com [40.107.94.84])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A44D410E7F8
 for <amd-gfx@lists.freedesktop.org>; Fri, 14 Jul 2023 11:05:58 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DC9rUUv3WQ/ohjjhEVSujL+WbJ2XWxnoPSYITK2mj+2zd8FI2upig3OVZqYuDuwODs5gh8Tv2vmWphpcFyno5BKHHQN3dHnc+nVlwZRn8LQMFA6P6c4zn6cmPL9bBjgnrp0PMrSmAW6wYs2F1bIihSVnvZPTe6IBW4e6bgYD3SdeD3sPT5VmBzSTJQUrEeG5eDYHo8i5PZEN4rDw+DZjHgG8yeaYFWIeX9AxcekpKXAnFGz8eViEgFKJg6bFqZDeE4f/tC7vkhlElFXR7xG3py2Sk5Ez/c60q3qLmLxhnnc4NTnLxPtYtzcri6/sy9DQl5JzN8XLZi42Q9hWxlVTvg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Npkq2a82wDKQvP4cAB2qXFfoRSkVALn3PkYUJH+eoyU=;
 b=A3bPNHQZWMtzDRkgWWUoGdxYPgbWT7+NnRaRoidMxpO6d1qfhXW7xbpNUhEJgBnF/qgyMVywkfPQsGgjHS7UYltffYQ2liLx1y3/LpcIpfj2ChJPD52Q6DcxMACP+KQFb9FjRmJEb64wv56gLFVGq6aVwWCYx0HTeICNCJxqmgACmP8eLaTI2BWX+h1ipb3Mz4Tx9T5Z0WuRBNAIxy2k2MUWR4rzrxz4Ksxd7Cx2OVBGuSukQ33HvARtRkAEWyg9r+4nBehlbz3UDE1W7veko8cSy6T0mggYCPobYkwCtPLCzkjl762v9aqJEva2jbEFx4XOc5wCBr3lJBgvaE71bg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Npkq2a82wDKQvP4cAB2qXFfoRSkVALn3PkYUJH+eoyU=;
 b=LylrTKDrg04bYQsHGXFhcUC9ckCXuPu3QidOAMjj/IGBdRTYp16rDrjKGLKrrwEDiMi158MUSLbMu2zRFScpPMj42M90tpmE+0kIsTAS9J1AM75OWmo53vULtpBuuEjTqbFmqVl7vjeIy8SG0EnhxPm1txTCX9lWYdN/KKN5yp8=
Received: from DS7PR05CA0002.namprd05.prod.outlook.com (2603:10b6:5:3b9::7) by
 IA0PR12MB7773.namprd12.prod.outlook.com (2603:10b6:208:431::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6588.27; Fri, 14 Jul
 2023 11:05:56 +0000
Received: from DM6NAM11FT026.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:3b9:cafe::49) by DS7PR05CA0002.outlook.office365.com
 (2603:10b6:5:3b9::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6609.15 via Frontend
 Transport; Fri, 14 Jul 2023 11:05:56 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT026.mail.protection.outlook.com (10.13.172.161) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6588.26 via Frontend Transport; Fri, 14 Jul 2023 11:05:56 +0000
Received: from guchchen-System-Product-Name.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Fri, 14 Jul 2023 06:05:53 -0500
From: Guchun Chen <guchun.chen@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <alexander.deucher@amd.com>,
 <hawking.zhang@amd.com>, <christian.koenig@amd.com>, <Philip.Yang@amd.com>,
 <Felix.Kuehling@amd.com>
Subject: [PATCH 2/2] drm/amdgpu/vm: use the same xcp_id from root PD
Date: Fri, 14 Jul 2023 19:05:10 +0800
Message-ID: <20230714110510.3690246-2-guchun.chen@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230714110510.3690246-1-guchun.chen@amd.com>
References: <20230714110510.3690246-1-guchun.chen@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT026:EE_|IA0PR12MB7773:EE_
X-MS-Office365-Filtering-Correlation-Id: 24296b19-944e-49b7-c314-08db845a4c2d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 2pCBAQ5tPXfyolU+0ceAdaGkZF4OjcI1qPZzhJVVi2EVXusVADTfamPHOjiROC7OpcVSjbmB33s8NtLjc3CYi/JmZ+2Lfy8CK57m82eViHYB6APEtr+N22slGf97HTWpzpyGANWZ3LJLOSXXZ6EjcR0bNNxuXgzC+ub8OaSacXZjGYYkn5FlP5DJzV4gqEYNAfJxs+hFLb+OZlHAcM6v6g3G3lAFzUgNJg2DNjvqYE2rlGaA1plmMTp6kUBnMPRw9NBC0s7UI3m63DYvwRaBLGE9ZVe+nkfxh9gwan1LcqmOKyRD22HUr/F/34P2Hv937npszJ1E27emK5pqtvPchs3w+9ASzl1Y1Kb1Hv7bHxL9N1qjYURr8eapsEQbMbWr/a29bR3gmHhAJFBagY01VGBHkh0RRO4Y1/gMZkyU0ni4bTFDvaydAU0eQQfQg6PtcyCUd++/KAm6kQae0fy+UwsBBAl5D6ub9uwQuJHfcxrqcxp9LccxR0+2sFxsyLzbTfj+t1G1NOuDFgSlvlv1fJhAQUlISjxk09QmkWMAXvHNgAz1aF62h62okKt9pbEF9qW7mdz6bbGA14UeuDt5E1IYix6ctW+4xY8W2y3JQgJ+1g2Nct2XacMnyQ1YP0UaXOZvcw55mCtFzndu6ixylHe+ehwXbhoiCx7kMtuRJha7r+3oADyAZvO/8GoDpdVhOyzK35sw9blM5JLAtbjX3Rc+pP4faUCcnEvn2dtRgA4msk+QMLJJoWKWYGXizqqZcESjiwS2mXNvR1EHJZH486rnj+XzBN66hpMGfQzpeNA=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(376002)(346002)(136003)(39860400002)(396003)(451199021)(40470700004)(36840700001)(46966006)(110136005)(41300700001)(40480700001)(44832011)(70206006)(4326008)(6636002)(70586007)(478600001)(4744005)(5660300002)(2906002)(8936002)(8676002)(316002)(6666004)(7696005)(40460700003)(356005)(82740400003)(26005)(1076003)(86362001)(16526019)(186003)(336012)(83380400001)(47076005)(36860700001)(82310400005)(36756003)(2616005)(426003)(66574015)(81166007)(36900700001)(2101003);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jul 2023 11:05:56.2266 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 24296b19-944e-49b7-c314-08db845a4c2d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT026.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB7773
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
Cc: Guchun Chen <guchun.chen@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Other PDs/PTs allocation should just use the same xcp_id as that
stored in root PD.

Suggested-by: Christian König <christian.koenig@amd.com>
Signed-off-by: Guchun Chen <guchun.chen@amd.com>
Reviewed-by: Christian König <christian.koenig@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c
index eb52dfe64948..83e1923f6775 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c
@@ -607,7 +607,8 @@ static int amdgpu_vm_pt_alloc(struct amdgpu_device *adev,
 		return 0;
 
 	amdgpu_vm_eviction_unlock(vm);
-	r = amdgpu_vm_pt_create(adev, vm, cursor->level, immediate, &pt, 0);
+	r = amdgpu_vm_pt_create(adev, vm, cursor->level, immediate, &pt,
+				vm->root.bo->xcp_id);
 	amdgpu_vm_eviction_lock(vm);
 	if (r)
 		return r;
-- 
2.25.1

