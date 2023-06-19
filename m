Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2A103EB64D9
	for <amd-gfx@archiver.kernel.org>; Mon, 19 Jun 2023 19:09:17 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 85FA310E141;
	Mon, 19 Jun 2023 19:09:16 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2052.outbound.protection.outlook.com [40.107.92.52])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9829910E141
 for <amd-gfx@lists.freedesktop.org>; Mon, 19 Jun 2023 19:09:15 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nK9LfWxca1434p/CfxI+H3FCpAzX0OirviXfsTMTrc/JZLLb7fUfLjOeGN/WmM/o0OxAm9Hq3nJ/zRQRZoV53k3gt4sPMxIt5KzclV47BPKUKn8hZtFVuZvo3Gr1qwdsA+Mf9Ql/WHhFOCJ+NPawQyjouZ61M9DyMqBRsFKtXfgcUj/NN0kzSs28KvEp4QFHvkKydeOudPV2F1phpWdlJs0eRPbb5crI3KgnNvif36mrI9s2zq6b/A1ZIA6FAdZj2HPU8Bsan86cwASMeU4bp+vhFSEAJ5iwGUhPJdpYZGH72BLX37m0CzbAyZy+0oeE2LONPm89qxNZBxLcv6u1oQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xAEksHQITGGDSktJozPUNJLNPfnjis5/4Vvtepg7mUA=;
 b=N6VRJNd7Po2kzbBxniSHz+vMDOzFz9yF9gTBB5U9mtWrkrZsHEI03ZdtmZsfHej4lg3O9qBm+7kADNx4NkObVeD/tG0iQbsgc04FRYe/9W9fXy3lRbxF9LGBO8fy6f40Hm/Dhoz4rpM4ywllbJygoJ2lZtTx+fvMUeO0fc96kP3BC9/STFMl6HSTdlpI9vvWM4QOJJYGwNhEYkCS5lWEewmQ8AK2SQSVyP5PRA2UxkDp4nX4neCYBTAJzHmPr3ahiIrsbh7enEdbYbYKpLO1kGs8uIetXVgk0QIrY5ks+rfL+YPfKgLxCfFJ1dJ4Mf9I5V7oTxxHt3vIV1OJYt7yjw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xAEksHQITGGDSktJozPUNJLNPfnjis5/4Vvtepg7mUA=;
 b=JBrTl68YwMVQ460bAPplVzF4/B8uoWN0o7P+SX1ojW7u6g7Z4wk0hrbfASgb1MRoI3vsXGMSiIQNmC+nNbFqdXQmCfR5iX6ijuLBDW8B03n076Dri3fa7MvzKWeuNQo/S0AwRTTPgGogx5gZJXfyXhTc5sbqTFLc6vULEIeVCSc=
Received: from CY5P221CA0079.NAMP221.PROD.OUTLOOK.COM (2603:10b6:930:9::16) by
 BY5PR12MB4052.namprd12.prod.outlook.com (2603:10b6:a03:209::9) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6500.37; Mon, 19 Jun 2023 19:09:12 +0000
Received: from CY4PEPF0000EE35.namprd05.prod.outlook.com
 (2603:10b6:930:9:cafe::a) by CY5P221CA0079.outlook.office365.com
 (2603:10b6:930:9::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6500.37 via Frontend
 Transport; Mon, 19 Jun 2023 19:09:11 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 CY4PEPF0000EE35.mail.protection.outlook.com (10.167.242.41) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6521.17 via Frontend Transport; Mon, 19 Jun 2023 19:09:12 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.23; Mon, 19 Jun
 2023 14:09:11 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.23; Mon, 19 Jun
 2023 14:09:11 -0500
Received: from Xiaogang-ROCM-Dev.attlocal.net (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.23
 via Frontend Transport; Mon, 19 Jun 2023 14:09:06 -0500
From: Xiaogang.Chen <xiaogang.chen@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amdgpu: remove vm sanity check from amdgpu_vm_make_compute
Date: Mon, 19 Jun 2023 14:06:51 -0500
Message-ID: <20230619190651.23982-1-xiaogang.chen@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE35:EE_|BY5PR12MB4052:EE_
X-MS-Office365-Filtering-Correlation-Id: 40e253bb-b89b-49e3-bfc7-08db70f8aac8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: iZBdFKlJTH94sVLhd4B0mmXTaHYPJKLi5JcLFjlyQ6ckGRfXWI4KAdhQPfRxI1BabSTmpaGNVZDeDrudhTvj5MM1CCfu7s7XarxjNPlSkJcnLPQ1NeCMbH7pXzesSsjNHoSZjROv1IA2ok/zOT6JI0utDRL2qthO8Fw1UGJ8xDKsvQqSx4Z2e/DoO92rLAGu5V+EsJOH7VBNJizvd1N4FzICdF7L1+PtGOi/N+V/Um8ZPSrw6ah/x2oTk/cA3kdSUV91liB+likVJzpBhmBRHDshzVHAbzx8Q9CUBkYwHAPMu/88K3vrXbbAQpY37+9JPZNsRLkdxNc9qS4dvYyt/cV5lTFJ78pS+giaUPXSaeFCgC/X0FtpioTYGtWMn6W25X4NRjRqJi9qrjw3NLXdxGFroWPSUtK4dIBlnoKxz8/Fp3UztxG4VbBncHucjprjs74YyWh50dXEQatOrvxWAHbWBSedrtuvBDhM1AtwKFZ1MZIA/bSSJTaA3WoNoBnpzbuvsY0wlYUvP91iBYYd5q+yzjHxucCusM1cw0X4wbF5QGcOlPRHQsTY8DrWiWzI+2t9fE0iOFwZ++PTIF0bgBopd4JQ+2Uw0b1OJb5FQftEfUp9xqrHq0OjPykCW9i8BgzLGo/bBr6TCJkGlOUpOAGQPSrT4bMloXt0QZ9FRBjRFwn3KwbV2zsmSIeMk3izeqZu/iV3Pxe3B3vj2TpkzRuQnWiDbtRsFgv+FRIBAobHHVqgp0oEd6fbJ1dDjL428ih2uVGyof69HZcGl7QJMg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(346002)(136003)(396003)(376002)(39860400002)(451199021)(46966006)(40470700004)(36840700001)(186003)(40460700003)(26005)(1076003)(82740400003)(36860700001)(47076005)(2616005)(40480700001)(356005)(81166007)(336012)(426003)(83380400001)(82310400005)(478600001)(6666004)(4326008)(41300700001)(6916009)(70206006)(70586007)(36756003)(8676002)(316002)(54906003)(8936002)(4744005)(86362001)(2906002)(5660300002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jun 2023 19:09:12.1446 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 40e253bb-b89b-49e3-bfc7-08db70f8aac8
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000EE35.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4052
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
Cc: Xiaogang
 Chen <Xiaogang.Chen@amd.com>, felix.kuehling@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Xiaogang Chen <xiaogang.chen@amd.com>

Since we allow kfd and graphic operate on same GPU VM to have interoperation
between them GPU VM may have been used by graphic vm operations before kfd turn
a GFX VM into a compute VM. Remove vm clean checking at amdgpu_vm_make_compute.

Signed-off-by: Xiaogang Chen<Xiaogang.Chen@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
index eff73c428b12..33f05297ab7e 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
@@ -2246,7 +2246,7 @@ int amdgpu_vm_make_compute(struct amdgpu_device *adev, struct amdgpu_vm *vm)
 		return r;
 
 	/* Sanity checks */
-	if (!amdgpu_vm_pt_is_root_clean(adev, vm)) {
+	if (pte_support_ats && !amdgpu_vm_pt_is_root_clean(adev, vm)) {
 		r = -EINVAL;
 		goto unreserve_bo;
 	}
-- 
2.25.1

