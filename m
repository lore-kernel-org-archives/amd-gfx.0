Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6B9F2C47258
	for <amd-gfx@archiver.kernel.org>; Mon, 15 Jan 2024 22:58:05 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E875D10E3A9;
	Mon, 15 Jan 2024 22:58:04 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2041.outbound.protection.outlook.com [40.107.236.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 37E6110E3A9
 for <amd-gfx@lists.freedesktop.org>; Mon, 15 Jan 2024 22:58:03 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Jm17oh5dgACr6//c+WdWa+tgczxLn/zAw6nEzk0zG061qGzU6YdbjnUdgwpn7nLeyyo5p4ave/bQIFNzn3aZJ7KeCZVuaWpRUvVq3Jy/8r8LIpC4K0KUhluRZKne19W+8thNUt7Ac214QlgO8rqWLkrRvkblc6HedU1uOGniydplHtSVNhR6NmC+4Y4+HRf68Nl32KbWvUCyJHD4RhO5hNmZOp7JawXKtJWyXZV9SYfKu6JBNcH4xG1VSKsH29GhbWVzkzdEnWHfveLMgpGPvPj5FHYxVNcTiTeGs1P7Yso/aFT2HjCFh+Hq/6n9sX1HCfY08qsrj7DVIy7xPFcnFQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1I+9GChd8T9B3x0N1so08skJo3PDgd8uTDjmXex7R7s=;
 b=mP/qbhqL54y0Yp82+T2yof7FZKApXYW7L9+lucp/oxxF6VcZvLkvTVwUvhy58qNSnUV52DdcqmZ0C1599/HI0v79tdBHz+7Dw7PPQBNvnXRtK+IHHSoN+RT1GvuVlVuAyezN4yFHH682IpMmJO9ONZc4AvJuE67llStJsF2wmtwx1zoTr+fS+5HrID3eFxTBNzF5Ihhi51024MP07PFkB/HLPpclD2aQk10CUJb3XF5Mr+v8AMZDQxfxtLBICciiO2ATXfUUwWX1Dng9OuMAgrDZLG3FobzYSfODXQMxl3EEhjwzCt4DA216aTz7tVkInrhjdgb2WJ3gmGcTktV7ew==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1I+9GChd8T9B3x0N1so08skJo3PDgd8uTDjmXex7R7s=;
 b=QvN2G/RcWOQHKo0LqbVBfZvyzBRjaKdIhImBqNSlA6csuDiO9oxquDwgeiIemnH0O1HPdkUam+RJqcALYlGmlweIqPCICNyqLQL8a8M0cZmrOe7Bj8RTl3pXuODxYEWlrSRhp9RkwA5ByisjW/+FIe1bGfIdd4QvqDryb5k9kH8=
Received: from BYAPR07CA0016.namprd07.prod.outlook.com (2603:10b6:a02:bc::29)
 by BY5PR12MB5000.namprd12.prod.outlook.com (2603:10b6:a03:1d7::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7181.23; Mon, 15 Jan
 2024 22:57:45 +0000
Received: from CO1PEPF000044EF.namprd05.prod.outlook.com
 (2603:10b6:a02:bc:cafe::bd) by BYAPR07CA0016.outlook.office365.com
 (2603:10b6:a02:bc::29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7181.23 via Frontend
 Transport; Mon, 15 Jan 2024 22:57:45 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1PEPF000044EF.mail.protection.outlook.com (10.167.241.69) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7202.16 via Frontend Transport; Mon, 15 Jan 2024 22:57:44 +0000
Received: from Harpoon.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Mon, 15 Jan
 2024 16:57:44 -0600
From: Felix Kuehling <felix.kuehling@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amdgpu: Remove unnecessary NULL check
Date: Mon, 15 Jan 2024 17:57:27 -0500
Message-ID: <20240115225727.1287832-1-felix.kuehling@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000044EF:EE_|BY5PR12MB5000:EE_
X-MS-Office365-Filtering-Correlation-Id: 52f5b561-2eb6-4379-5759-08dc161d6300
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: dDwtvr1D9lyG8ffB1cfD9NDq0G73cHMIUvpXxgIkrdfILoFotqBUf3JsEy801JYxEwKJj+AzKCelZomGiM1WkPUKeUsy3kfpe0WRduqI7WDHg0CgULjY1reaAjTn2dunA5NxUr9f7LB4ffZ3esfw/Lu6FRYb8lcdHMryFw8hpGtCsu2HSSy4tAnSZLDgb/ZZKThmkT+8qqpA+Pw6OcglNYofwrwUr9imJ4eppBDemQ/ALIf0OYwtIubzshDwEljLGio6++sATlPaz78Y7ZZp1/YC1eav8EG29Q8Yb4cWW9iOcS14u7o+eMxgguR/ocrL99HCvOCIzsilaK3cwlOhA+BG5FleSzK2+HiWb4CSpP6FoYYpbobRFHdvDpL0bEZ9yinIXytY4iI/7RL0A/LTc4unbWAik8f5fUaEBaSVbcvc2J5G0GXuL1qR9LnzAzgX62mLlQnq/KCrMCVF7TRx1MJ1Ws46sclQ3ZqidyuXK8HtV/OEfTklBmzIh0KpzGSfPsZbHVk7QluIIrsAadyKkHGNOyT4/joR/p44ifpbjpLiEz3rQwSaVSGTC5ztAek+DVQ8qIweLHUpgbcjCXYPO9AaU7iV4FRj6nf8QjOdmWzEgnoWdj1O8UmE2Gc/u8d4tMLfzSQYKkNvhWc97O8cLEywbxjMSU0vIEgd8yKuSlZaRG7DZZlFQMfiGWjOjBABfZ9H1nTL1tOB/4yf10RHgxL8Nmn2qR/quTVT1m2qS++tG+i65E71pyx+P2146DF1LgUMb7ugYztFJE1spmNYrw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(376002)(136003)(346002)(39860400002)(396003)(230922051799003)(186009)(82310400011)(451199024)(1800799012)(64100799003)(46966006)(40470700004)(36840700001)(8936002)(478600001)(7696005)(6916009)(6666004)(70586007)(8676002)(316002)(83380400001)(16526019)(36860700001)(426003)(336012)(1076003)(26005)(47076005)(70206006)(4326008)(2906002)(5660300002)(41300700001)(44832011)(36756003)(81166007)(356005)(82740400003)(86362001)(2616005)(40480700001)(40460700003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jan 2024 22:57:44.9034 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 52f5b561-2eb6-4379-5759-08dc161d6300
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000044EF.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB5000
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
Cc: Dan Carpenter <dan.carpenter@linaro.org>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

A static checker pointed out, that bo_va->base.bo was already derefenced
earlier in the same scope. Therefore this check is unnecessary here.

Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
Fixes: 79e7fdec71f2 ("drm/amdgpu: Auto-validate DMABuf imports in compute VMs")
Signed-off-by: Felix Kuehling <felix.kuehling@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
index 77d015ebb201..b7f07cc52b1b 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
@@ -1477,7 +1477,7 @@ int amdgpu_vm_handle_moved(struct amdgpu_device *adev,
 		/* Remember evicted DMABuf imports in compute VMs for later
 		 * validation
 		 */
-		if (vm->is_compute_context && bo_va->base.bo &&
+		if (vm->is_compute_context &&
 		    bo_va->base.bo->tbo.base.import_attach &&
 		    (!bo_va->base.bo->tbo.resource ||
 		     bo_va->base.bo->tbo.resource->mem_type == TTM_PL_SYSTEM))
-- 
2.34.1

