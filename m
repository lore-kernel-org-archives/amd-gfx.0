Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 012E0C0219A
	for <amd-gfx@archiver.kernel.org>; Fri, 31 Jan 2025 16:58:28 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 78C6A10E3E3;
	Fri, 31 Jan 2025 16:58:28 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="LsBnIMtw";
	dkim-atps=neutral
Received: from NAM04-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam04on2046.outbound.protection.outlook.com [40.107.100.46])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0E5AD10E3DC
 for <amd-gfx@lists.freedesktop.org>; Fri, 31 Jan 2025 16:58:27 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WsjgNicgh5yiC6jyJ4qwZSqydFp4KACXgL18v+syV9VpocVpfzyyzLiaxKATRQoKvSsDBKXCm+sa3yLZYKdM2UGbfNFzcf/uf5TcicdAX6D/ZV/IzeWHzU3e0J/4esEvhJf+EZYKvj2fu0KsFRj/8X+jbTejjbA/eGkcB2d/ngNK9AevSXs/YHXW6COsm2/6q6eC1vYYvPOaNibAFnfnanBDE2x3ryo323ADjI9WYdnl+BvIafIaOwx4tal9+JoFRrBPn+20hGQ8kYvc01vfUEBrsBRAQ/zmFwBXcdv4YExUd0xABOzMDAGr0tg+DYuCC8wDc2gAosXs5wjlojEF0Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Dm5Fy7SBKY24DiBzx6dtukipu8qm8OanVQA1gkE9NLY=;
 b=XsQ9SGy8gbC+zBeIcW2dcNnUl3KdwR2RBKfwkGAONVuetq5vt9AAVmG6QkPqdHle7RbqOOlSJWy/YcnT/1GjZV3ND/JZxYJvBQ4t2qLNnjDXsQ/4IBM6+5T0/JOQUvZuBYyC+TbLnWyF3DRYeRn8+o+ON1pwcUX7y9geSMMKuU5V9cCI4ycvmk+2VNobCbmNKNO7JRIzs1Dj2oGRY5SUDmw5V9+AchejoHHkmftAWZNkOwM0Qsjas9iI2xKHb2U/1x4m4Z+cElCDybie8PZWsSY9suH4i6H1ZnfF6sMsxmC1ZzbME1BmU1hnnD+1U2X7FMURj5Y9+32OHveUWSnANw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Dm5Fy7SBKY24DiBzx6dtukipu8qm8OanVQA1gkE9NLY=;
 b=LsBnIMtwqx+GhJopTWyFOdlt2yN5cHP8crM/z/JBeAzn/Unm9HIQvneW10IL4en2n3vTHp+gIprAZ1csWbnuzXJVJ78UT6ki4BdOddTkkNulzSfkypTT1YP69VhaRTibAba3SRxaLTAhdBM5xOZJMOik/HCur8DQVQZxAmlr1jQ=
Received: from CH5P220CA0017.NAMP220.PROD.OUTLOOK.COM (2603:10b6:610:1ef::8)
 by PH7PR12MB5654.namprd12.prod.outlook.com (2603:10b6:510:137::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8398.20; Fri, 31 Jan
 2025 16:58:22 +0000
Received: from DS2PEPF0000343F.namprd02.prod.outlook.com
 (2603:10b6:610:1ef:cafe::e1) by CH5P220CA0017.outlook.office365.com
 (2603:10b6:610:1ef::8) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8398.20 via Frontend Transport; Fri,
 31 Jan 2025 16:58:21 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS2PEPF0000343F.mail.protection.outlook.com (10.167.18.42) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8398.14 via Frontend Transport; Fri, 31 Jan 2025 16:58:21 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 31 Jan
 2025 10:58:17 -0600
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 31/44] drm/amdgpu/vcn5.0.1: add set_pg_state callback
Date: Fri, 31 Jan 2025 11:57:27 -0500
Message-ID: <20250131165741.1798488-32-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250131165741.1798488-1-alexander.deucher@amd.com>
References: <20250131165741.1798488-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS2PEPF0000343F:EE_|PH7PR12MB5654:EE_
X-MS-Office365-Filtering-Correlation-Id: 4681dbee-60db-46ae-d183-08dd4218781a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|36860700013|82310400026|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?aPJ/lMLYMwXrfxUALBkkxKw0MTVDmw3pMqEDlmFRC+08qPS5G9Alo/3hgqYB?=
 =?us-ascii?Q?Y8XCEumRU+/YUU7izl+cTgIfZ7T8uxXpjMTsjHoYTo78uWEZ937ktJEMUbTf?=
 =?us-ascii?Q?FLCl8eqX9rOvJ7e5zklSUN+M6znL56pOiepzd18PCjl5aKbJG2EKflCpzLtv?=
 =?us-ascii?Q?37AY6LD7hMSMk7s6IqfdtZdXAVf6KxDoUwZOgatkzZ8Vl5XkEB1evg144Ula?=
 =?us-ascii?Q?R1DbOzRLC9LXYv4H+oLNifhqiNbuTTDvp1zD9n9oqNK5tnhPZeXxDCqOwvQp?=
 =?us-ascii?Q?CkhE2LLvN1nJlD3yt2ZCVROQwEtA6e3CpvIKM7DH6951EfKMeuO/piw/71jN?=
 =?us-ascii?Q?ANbH8zgBai7q+sY+nrhb0Qgou/KBgFb7X0yNOaVEQWmBLSqM17s5Bqz4Hs/z?=
 =?us-ascii?Q?5mr8BIKFBGj0+v8mDAD4oUDw2g77RTgT0IoJR7R+puyRCEuvBllbHqHXH4UD?=
 =?us-ascii?Q?V0nVTBSIYMU8AGZS6A8/BsgzzVG7OLee/gqPlU2tTdLfsV6h3oVNReJrPTNR?=
 =?us-ascii?Q?8bXsQ8juxY417iA4eHNE0zGzBjDgVtyjUN7KCfJt6deLSKznv0p4joKOY+S3?=
 =?us-ascii?Q?ggvm0+HMRddVCCnuvdhl4HZlyROpzYtnYVfl2CggeVmuyDmVN543/0kPeLqE?=
 =?us-ascii?Q?ZW6T5WhZ8D7tVAExfFnusgC/COXN9O7QB2un1JRFEGL/fqNXPBSCIDJ0Qeqm?=
 =?us-ascii?Q?M6XgAKgFr5oMkiFHZootywIgoe3kRfa/bLRAnPt93T5H+IDV0AoEReellBFz?=
 =?us-ascii?Q?532fW3QIw8GEuDDKqohK3NI2Pw00FuAFtu71EQp07nZwmptZ4TsU08P0tEFH?=
 =?us-ascii?Q?IJOt/h0S4rs+9Z4Plqik+bmAPWfPtnjyCMPYNAbjMRRn9tItVvv9d9QUcj9Q?=
 =?us-ascii?Q?itT0/eR6nEuHrGhhfy9XQeALR6nkWcyxoKg46C2ILELY6QwFh5+aAD7FisOj?=
 =?us-ascii?Q?PP9OY+PyrvtwclzoKWmmE4GfULDFv+cJosF6nOSB/4FhDCIdDRadA4ylIkYL?=
 =?us-ascii?Q?wwq+GLHffjHUpNVJhAqU2Za2qea/wGThROagKtXSBIu85DTboX6bZyKr45s6?=
 =?us-ascii?Q?Hc3/Yl17S37v4QKxI/cVUpx7ZydKnnBk50WWKo4fcV4/iYnh5KjqsVIIyQre?=
 =?us-ascii?Q?wAu6MRuHWL/jPCSBFHvso03+ozM1dZYK1jwTezXcVGSVV7jjFkFvBXGD40Sm?=
 =?us-ascii?Q?kpqA5ws5zJ7TAchPtZEEopAjj0q0hzrxc4MRQGoD+Bsan1sM/qCUB8WDo22/?=
 =?us-ascii?Q?OSZrTseF9rCyFpvI8DJdP367ItnTKMtpO83dFycHihu8NjrNJuS3ty/DMZ6g?=
 =?us-ascii?Q?z5Y3iGBeCNlHyD3HiMEIvb5Ge3FX1Fwbduz/71wbSoTUAW64fABVPXN3yrmH?=
 =?us-ascii?Q?5lrSBK+9Qv7IQhS04kXQ9iYTLEj51Sh5gmdkD5WK3gU7FCPlBRqZOGMSeOV9?=
 =?us-ascii?Q?0+tP/fsMK+ycI4wV3sCLI+Xtys0kU/4UK3P0cZfKxMwwFWfSQhVxAQ=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(36860700013)(82310400026)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Jan 2025 16:58:21.7056 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4681dbee-60db-46ae-d183-08dd4218781a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS2PEPF0000343F.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB5654
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

Rework the code as a vcn instance callback.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/vcn_v5_0_1.c | 25 +++++++++++++------------
 1 file changed, 13 insertions(+), 12 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_1.c b/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_1.c
index 8eccb45b04d2c..5ef267fde190c 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_1.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_1.c
@@ -40,9 +40,8 @@
 
 static void vcn_v5_0_1_set_unified_ring_funcs(struct amdgpu_device *adev);
 static void vcn_v5_0_1_set_irq_funcs(struct amdgpu_device *adev);
-static int vcn_v5_0_1_set_powergating_state_inst(struct amdgpu_ip_block *ip_block,
-						 enum amd_powergating_state state,
-						 int i);
+static int vcn_v5_0_1_set_pg_state(struct amdgpu_vcn_inst *vinst,
+				   enum amd_powergating_state state);
 static int vcn_v5_0_1_set_powergating_state(struct amdgpu_ip_block *ip_block,
 					    enum amd_powergating_state state);
 static void vcn_v5_0_1_unified_ring_set_wptr(struct amdgpu_ring *ring);
@@ -68,6 +67,8 @@ static int vcn_v5_0_1_early_init(struct amdgpu_ip_block *ip_block)
 	vcn_v5_0_1_set_irq_funcs(adev);
 
 	for (i = 0; i < adev->vcn.num_vcn_inst; ++i) {
+		adev->vcn.inst[i].set_pg_state = vcn_v5_0_1_set_pg_state;
+
 		r = amdgpu_vcn_early_init(adev, i);
 		if (r)
 			return r;
@@ -1027,15 +1028,12 @@ static int vcn_v5_0_1_set_clockgating_state(struct amdgpu_ip_block *ip_block,
 	return 0;
 }
 
-static int vcn_v5_0_1_set_powergating_state_inst(struct amdgpu_ip_block *ip_block,
-						 enum amd_powergating_state state,
-						 int i)
+static int vcn_v5_0_1_set_pg_state(struct amdgpu_vcn_inst *vinst,
+				   enum amd_powergating_state state)
 {
-	struct amdgpu_device *adev = ip_block->adev;
-	struct amdgpu_vcn_inst *vinst = &adev->vcn.inst[i];
 	int ret = 0;
 
-	if (state == adev->vcn.inst[i].cur_state)
+	if (state == vinst->cur_state)
 		return 0;
 
 	if (state == AMD_PG_STATE_GATE)
@@ -1044,7 +1042,7 @@ static int vcn_v5_0_1_set_powergating_state_inst(struct amdgpu_ip_block *ip_bloc
 		ret = vcn_v5_0_1_start(vinst);
 
 	if (!ret)
-		adev->vcn.inst[i].cur_state = state;
+		vinst->cur_state = state;
 
 	return ret;
 }
@@ -1063,8 +1061,11 @@ static int vcn_v5_0_1_set_powergating_state(struct amdgpu_ip_block *ip_block,
 	struct amdgpu_device *adev = ip_block->adev;
 	int ret = 0, i;
 
-	for (i = 0; i < adev->vcn.num_vcn_inst; ++i)
-		vcn_v5_0_1_set_powergating_state_inst(ip_block, state, i);
+	for (i = 0; i < adev->vcn.num_vcn_inst; ++i) {
+		struct amdgpu_vcn_inst *vinst = &adev->vcn.inst[i];
+
+		ret |= vinst->set_pg_state(vinst, state);
+	}
 
 	return ret;
 }
-- 
2.48.1

