Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F2646FF8868
	for <amd-gfx@archiver.kernel.org>; Mon, 27 Apr 2026 16:00:07 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 846D110E7F5;
	Mon, 27 Apr 2026 16:00:07 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="xh9SnuM+";
	dkim-atps=neutral
Received: from PH7PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11010023.outbound.protection.outlook.com [52.101.201.23])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A6E8810E7FC
 for <amd-gfx@lists.freedesktop.org>; Mon, 27 Apr 2026 16:00:05 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ApJ/sw2VHkQ/731+8SNZW8sudeBk3NPVKAQy/B6b2GkDyvsRRxyJC4pvPKQ+sPdnp8YWs6b0CGs6niY+us3Ebm1wh7o0UUTtBv/fAi2XM8ZdkRsVzpBUuJAuqLG8u+CVLnbOcKnJG6JMDx6779m9/a6Aq4D6EzXAc2skQW+VgcoglMYOA9yhkwXX57DPAUrM8TE2FwQLzqn0noapu6SNWWxxKON1+aa4izVQvsV5vVz14ukuo3djea+8YpwgLawGrXFjrTeATQ/gUeNxkYrA27P7N6dBZGlO4rs+bSw+f7eDvwE3m1EyjKiWnmsN8OQEN84IYhqGzEQrAQ04C3F7oQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iwv7o5VnM/Lr0bc799QNt0ouQjJoP2twJMhyDPtvWY0=;
 b=GXlB+yE+ipMYjqtuYwETt49lKJs4P8bki78hYd2C5MPfPg39ylLTAyk2ifJVmuaYhyRH8kUcEjLS5uP/kMY9baGJpH5LZHdccPqd3WXuM+iKnKNv6EOn2KqkW1z2h5W60sjUhG6guoT4xUf3jTiJLh6UTvwLNwYrBg3SXBPgXtCnj4F5RSpkahnwuo6atwFmzzJS7to1dUdnzwLUa7P8SfRjvn2frW1qb+40nuKnWCxlDN6GySDIevuUCsFqEmCWJiE0sjbY8u03VukD2sNZblKJU0+wqlAcXigO+PbzrNQIPOMhsca3h7zNnF0ejmm1mNv0OSdYVdm7WDMYU3pxLA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iwv7o5VnM/Lr0bc799QNt0ouQjJoP2twJMhyDPtvWY0=;
 b=xh9SnuM+O2gNn/fUTrxokKaT8F65BYDns0nnxPEc92CAXgIRBnaIMgC1+rYuVM3ZRy+Gn8KwyvSLyiKsA5bgFXtCnoSLIxlEvYrcPajK8Nbk64qP5/nVMOzi7BPqYYJF5MmOkcgAZ4zC7dmMMAEkM1LrXQVPdzgHfdBq4cZWD+w=
Received: from BN9PR03CA0755.namprd03.prod.outlook.com (2603:10b6:408:13a::10)
 by DS7PR12MB9552.namprd12.prod.outlook.com (2603:10b6:8:24f::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.15; Mon, 27 Apr
 2026 16:00:01 +0000
Received: from BN3PEPF0000B06B.namprd21.prod.outlook.com
 (2603:10b6:408:13a:cafe::1e) by BN9PR03CA0755.outlook.office365.com
 (2603:10b6:408:13a::10) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9846.26 via Frontend Transport; Mon,
 27 Apr 2026 15:59:59 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN3PEPF0000B06B.mail.protection.outlook.com (10.167.243.70) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9891.0 via Frontend Transport; Mon, 27 Apr 2026 15:59:59 +0000
Received: from yinjiyao-dev24.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Mon, 27 Apr
 2026 10:59:56 -0500
From: Yinjie Yao <yinjie.yao@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <christian.koenig@amd.com>, <alexander.deucher@amd.com>,
 <leo.liu@amd.com>, <ruijing.dong@amd.com>, Yinjie Yao <yinjie.yao@amd.com>
Subject: [PATCH v2 13/19] drm/amdgpu/jpeg: set no_user_fence for JPEG v4.0 ring
Date: Mon, 27 Apr 2026 11:58:51 -0400
Message-ID: <20260427155857.1370151-13-yinjie.yao@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260427155857.1370151-1-yinjie.yao@amd.com>
References: <CADnq5_MPJG=S+B4kg6v64xD+8pDEbG5z1Q7j-2A+CfStmuejTg@mail.gmail.com>
 <20260427155857.1370151-1-yinjie.yao@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B06B:EE_|DS7PR12MB9552:EE_
X-MS-Office365-Filtering-Correlation-Id: 7818f542-4572-4a9f-4697-08dea4760925
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|82310400026|36860700016|22082099003|56012099003|18002099003;
X-Microsoft-Antispam-Message-Info: CFe4BtgmkuXQ8585RiEJyJND1F2vvSKRi5NU1aiSLCPRptAUT4tTiwPMuYUZA43TVTDTCHD/PeOu1c0MIHY6ctdpRL07ifQzPNGYMOhUMUqFIvn2v9LttQL9kMG9HGt+lRwgHMpvbjvTntMkI320Q9z1xeJaKvE/FnNTyeMrjl6jnW9wh8mXUpqxa2MqT51YpAiHyopfoKoUQBjsglqww6QbiMHHDX/03GU3yeSlPDIxc74P20nMqhB5XfZLhsW87kSVj2mHPVCKag+Y/2KmWHxRJ3j/aCcZXq4pokK2pljBqTQ1TVY/UtB4e871xMWx7ubbrkVJhqhLH60P8tL0PbZyPgiEi8o8OhzU7wyZ/CikVnCkd90omRONR8E9uTBrTe1au2fxPGNQOxBRXunT97vmNv6WXPWsRPj+akgk918+w1WVK9PxZysRuCMi+R0lf0euvx9RNGpHmLUC4FzySO5msB62gH5MDEJRALDFl4bWRWkbeP7fZ1DVesnyTWL8nnkfPPMcDB/FyTXSz3tUEBqvHHTO+zTb0qTu+67EXlk2e0Skh8o5YRMxv38PyHZOlOTO/2e8oGMpfnib0ChYizZfGEX/Q3Az0GCX4jVc5pkh6n+aB9ylzMFMGTuW8nOnqk9dsySs90sWPteQ197FYE+gwhG9SnctZu3MSKY2BBvdYAiH+tFa61JlPsIs85na49ivYJjYwLivRESVX4n7AGoHcg0qcv/pp9+N9EnXxkhnZmJ1dwPYeEkvXI1Ixm3eQ6PYYPIt66X761BTvZ+sbA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(82310400026)(36860700016)(22082099003)(56012099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: Ud5fmx93dsQFqPNAU3lgL8eL4PqyQ24lcDccAdbFgS85r0Vay6axZeIojJ/YLcatJaZByWGyVt5u/jDNh9Bkju7CeKGRQCp7OWeqoWEjwXvVQhsxQ//7WAcE1XL/2RCypY4HT1+md5kJry5/yupoTjnT9DabHLNP0IvRH0gUtnnl3vifH3vCGObmjqvCK+shq+NqG092WsRyG2oOUsLgn0NXLQVkNkousidWh74qMAStNxV0cpiyFbsX+JoqGR1BI5eHLjeadFtj2nMwh5AspRimot/RBGRJPFWJ4DUh72F2Rr6Ekj9u+u/h9yTfdDZPWOCa5LaKiqHJBl+b8Rhxa3HnYjGfgDic9z+Il6xvnHlMd3mVrtFucklbs1wvjgGXJg/eJlt7NDlu1Q7hduu2nM+cz+lYnMcdKz2jxh3DSvb4Py05pf4n7hqarSs5O3CO
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Apr 2026 15:59:59.9261 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7818f542-4572-4a9f-4697-08dea4760925
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN3PEPF0000B06B.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB9552
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

JPEG rings do not support 64-bit user fence writes, reject CS
submissions with user fences.

Fixes: b13111de32a9 ("drm/amdgpu/jpeg: add jpeg support for VCN4_0_0")
Reviewed-by: Christian König <christian.koenig@amd.com>
Reviewed-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Yinjie Yao <yinjie.yao@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/jpeg_v4_0.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0.c b/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0.c
index 0bd83820dd20..6fd4238a8471 100644
--- a/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0.c
@@ -759,6 +759,7 @@ static const struct amd_ip_funcs jpeg_v4_0_ip_funcs = {
 static const struct amdgpu_ring_funcs jpeg_v4_0_dec_ring_vm_funcs = {
 	.type = AMDGPU_RING_TYPE_VCN_JPEG,
 	.align_mask = 0xf,
+	.no_user_fence = true,
 	.get_rptr = jpeg_v4_0_dec_ring_get_rptr,
 	.get_wptr = jpeg_v4_0_dec_ring_get_wptr,
 	.set_wptr = jpeg_v4_0_dec_ring_set_wptr,
-- 
2.43.0

