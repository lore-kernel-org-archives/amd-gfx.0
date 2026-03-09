Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8D409F417EE
	for <amd-gfx@archiver.kernel.org>; Mon,  9 Mar 2026 14:56:58 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 27A1D10E51C;
	Mon,  9 Mar 2026 14:56:58 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="aBaRLJ55";
	dkim-atps=neutral
Received: from CO1PR03CU002.outbound.protection.outlook.com
 (mail-westus2azon11010012.outbound.protection.outlook.com [52.101.46.12])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 34A5410E514
 for <amd-gfx@lists.freedesktop.org>; Mon,  9 Mar 2026 14:56:52 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HLYF5XmdQ3YkTfcMdEmqTJuWpZE96iarZosV1+vIp6E4MSae98H+cvix6OOqWRKNlieV6uc8ciCqyYtu7XU/Ww+bEDHkvc7CNWqIneiyz1PYttiINggf2FKVPxij5OiR3FPMbxC45iDfhfHIozAR73yp2D2dVgh7OSO0Fr40YtxBfgWw2rW/nBT1XQ1CP+OHSsf9GNXR5cC/ogml3UJT6XBW3gdOfdbm/2lXagbHGqSBeVcuqoWoZwfgzZAYvgijGecyKS6aEaJod0DmyQRa0PvNqGZldXkyZMkJpvl4aM1erAxAdk0GKFLfT8DtbXYo4SlDuR3klG4JfGTQvIY7PQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tsytQZt+HNTOx2MysOR3S2bctfaY3gyS9lRQTLBYSSo=;
 b=q6UDk/QV7v62fIb3VyWtkXgO9ydYKsfsD3vT1YuNuyEV1VvkQM6eS8M00WplIA0897KZEyMqzlBCXb5Xp+x7pewRQuHVk1j4xtMCC0nioiTsZ0+zJOF0BFhb0k7Rep57UD4Dx+jA4LyMhx2A7Su4/M+eYdSzAayiXDKPfy/YSOhs1EgsKblVrnnwvJ2nmB6O4V9qlCQOvvCe9JQ4+VUmvK9807T4A4Q8+lFjRHFmYKcUF8bzA9jv6XujPAZ8qwDwpfJiWMs3j82i4MMM0EiI2vcdE0WZO9K0JV5qDyl3A0HA8F0PWLUySYeZIPrkcphxvLAVcGttsEuIGfMtNn8Ahg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tsytQZt+HNTOx2MysOR3S2bctfaY3gyS9lRQTLBYSSo=;
 b=aBaRLJ55iMCtOo0m7kMNcVo8vjR8CNIn5r3DFY2eYZzG0mL/9EIgmFQohZeqqnqNiRG+SBAKYjNb4rV9OOfzwB1BENiXu2P8xTQUgEqJ8CWf/+8oc+UB0ilMTPgR5a0oequN70WbwqZZJOGFRzExPrgiCM0KEVMLNYpLzOTs3uI=
Received: from SJ0PR03CA0223.namprd03.prod.outlook.com (2603:10b6:a03:39f::18)
 by DS0PR12MB8317.namprd12.prod.outlook.com (2603:10b6:8:f4::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9700.11; Mon, 9 Mar
 2026 14:56:47 +0000
Received: from CO1PEPF000066E8.namprd05.prod.outlook.com
 (2603:10b6:a03:39f:cafe::34) by SJ0PR03CA0223.outlook.office365.com
 (2603:10b6:a03:39f::18) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9678.24 via Frontend Transport; Mon,
 9 Mar 2026 14:56:29 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CO1PEPF000066E8.mail.protection.outlook.com (10.167.249.6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9678.18 via Frontend Transport; Mon, 9 Mar 2026 14:56:47 +0000
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Mon, 9 Mar
 2026 09:56:43 -0500
Received: from p8.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Mon, 9 Mar 2026 09:56:43 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Hawking Zhang <Hawking.Zhang@amd.com>, Le Ma <le.ma@amd.com>, Feifei Xu
 <Feifei.Xu@amd.com>, Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH] drm/amdgpu/gmc12: Set up pdb0 for vmid0 page table
Date: Mon, 9 Mar 2026 10:56:16 -0400
Message-ID: <20260309145629.2844495-6-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260309145629.2844495-1-alexander.deucher@amd.com>
References: <20260309145629.2844495-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000066E8:EE_|DS0PR12MB8317:EE_
X-MS-Office365-Filtering-Correlation-Id: 06bd6da9-c344-4de2-c948-08de7dec1658
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|82310400026|36860700016|1800799024; 
X-Microsoft-Antispam-Message-Info: b2scptTsW5ncFHU6Y+9yqOPp6iz2hVxfC41o0rG5laW5hCYqijg3JWqDn+kTCOVCu+ipwdMIStFVSNezlTwTiQwZR4C6n+cSOVa9uj56mG+aDoheYb4Ry3ohbu3AqiPhFvu+3u6gr06fbfrlwqqBpseytZ/+h5PjZmjLknXK61REjdBCJp3BSLuznN9vKfOqBgMS4eU4OX756L17lJq8bnUuoSTRXLMR2V+P2T6q/HqpFXIlcoMzNOpENJ/cC+iSxfn9MQ8e0RTBw2OahywDQokirRChwpvz4kiZrJTAfUUnElmIfU2l/yn4TwAof+jhU9jTLU83+EnTctgCxIJcPlx4kyhH3+tzGwa8vid3P++tN0RIrmaHxs64DIAAMa9fL1X0Ne54OaEUqp6jmn2ao5oa79ADKbV+U3KSV9VI++KcbgyIapOrApC3nCZ/rZAl/lmi8gexSQiUDi8xlYL1i6EIK8z9mDgUpRUlPzmyDgmRg/uJv0XmANyvBR+sKJZ2KVM03GevIe5Rdcppcw0SbpdkwK6zKsMEaj53nKRs8baHllodyyrIYs3K7WqPm77HrODTrJudSpZ0D2zcWoWgeQF+F1eQ9OJY3bndmD1StYaoaAsK/guHe+qw3LGF50fHMcqSFRM+noicnMGzx1XNLVz76K0NrWVUIKcZSpWL9Nzm4dUkpV3hsViJ35q0s8XQG9NkJpR0yF5YcwjvVvQwHar4sCWPr54xi/F2IAUy5nuNpJNanmclrRu9GcsXyxum/PosMnATNe9L3yhl5igbKw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(82310400026)(36860700016)(1800799024); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: EiIelReTySfLzVUn39oqCfTGYgjh0BYm6KsIzsPccHV/KCSXD+SMtSHnOtxVcYVWW0vrHuO9oHAjo8QD7sSHTjzIr2YwU3u+9mxwaq/GMb7iLuOIC9VQHU8uGTj9oxkdD35VQ7bHThsuuGucTRyixXIzbr8g6SsUfM0hk8cTKfl9bcmfP3ohnPPTNKD5cOeSu5mLbeMc9MrpsUXuWVB2V/KRnsu9IwlscIpcxdHeLkEbfNNJ/18RnZM5nyYlJdqlxevo/xXwz0al1cW/0CPwzKKRt178TQ1eK41HBLV04xuNjoT7Nqv0GMglU4GKq9mW1gszuafjtGuVDgTXPY2tnaMZFOd0aGgCkCQJzUA4DcLmYiKhH+jcws20dmRx95inLaF/t/DZRNm7YqG9okx9S2dSM2lx6HBG41DeXl2JDA9IgBzkYW2/ow/lo2YJC/43
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Mar 2026 14:56:47.2524 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 06bd6da9-c344-4de2-c948-08de7dec1658
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000066E8.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8317
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

From: Hawking Zhang <Hawking.Zhang@amd.com>

Alloc, Init and free pdb0 for vmid0 page table that
is used for fb translation on A + A platform

Signed-off-by: Hawking Zhang <Hawking.Zhang@amd.com>
Reviewed-by: Le Ma <le.ma@amd.com>
Reviewed-by: Feifei Xu <Feifei.Xu@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gmc_v12_0.c | 14 +++++++++++++-
 1 file changed, 13 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v12_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v12_0.c
index f5a328bb421db..654c1c7adfae4 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v12_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v12_0.c
@@ -783,7 +783,14 @@ static int gmc_v12_0_gart_init(struct amdgpu_device *adev)
 				    AMDGPU_PTE_EXECUTABLE |
 				    AMDGPU_PTE_IS_PTE;
 
-	return amdgpu_gart_table_vram_alloc(adev);
+	r = amdgpu_gart_table_vram_alloc(adev);
+	if (r)
+		return r;
+
+	if (amdgpu_gmc_is_pdb0_enabled(adev))
+		r = amdgpu_gmc_pdb0_alloc(adev);
+
+	return r;
 }
 
 static int gmc_v12_0_sw_init(struct amdgpu_ip_block *ip_block)
@@ -955,6 +962,7 @@ static int gmc_v12_0_sw_fini(struct amdgpu_ip_block *ip_block)
 	amdgpu_vm_manager_fini(adev);
 	gmc_v12_0_gart_fini(adev);
 	amdgpu_gem_force_release(adev);
+	amdgpu_bo_free_kernel(&adev->gmc.pdb0_bo, NULL, &adev->gmc.ptr_pdb0);
 	amdgpu_bo_fini(adev);
 
 	return 0;
@@ -974,6 +982,9 @@ static int gmc_v12_0_gart_enable(struct amdgpu_device *adev)
 	int r;
 	bool value;
 
+	if (adev->gmc.xgmi.connected_to_cpu)
+		amdgpu_gmc_init_pdb0(adev);
+
 	if (adev->gart.bo == NULL) {
 		dev_err(adev->dev, "No VRAM object for PCIE GART.\n");
 		return -EINVAL;
@@ -995,6 +1006,7 @@ static int gmc_v12_0_gart_enable(struct amdgpu_device *adev)
 
 	drm_info(adev_to_drm(adev), "PCIE GART of %uM enabled (table at 0x%016llX).\n",
 		 (unsigned)(adev->gmc.gart_size >> 20),
+		 (adev->gmc.pdb0_bo) ? (unsigned long long)amdgpu_bo_gpu_offset(adev->gmc.pdb0_bo) :
 		 (unsigned long long)amdgpu_bo_gpu_offset(adev->gart.bo));
 
 	return 0;
-- 
2.53.0

