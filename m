Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 777D3CD4F3C
	for <amd-gfx@archiver.kernel.org>; Fri, 15 May 2026 05:30:21 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F3D7410F3D8;
	Fri, 15 May 2026 05:30:20 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="X9CTnlnB";
	dkim-atps=neutral
Received: from CH4PR04CU002.outbound.protection.outlook.com
 (mail-northcentralusazon11013001.outbound.protection.outlook.com
 [40.107.201.1])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D954C10F3D8
 for <amd-gfx@lists.freedesktop.org>; Fri, 15 May 2026 05:30:18 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oeYhOd5RqSYJIxNdrHlPtnS4Uvr4me0fGLoe6HUKnGLcfHjNMPxWb6KFS/pEy5uos9Vlz3fDqP2DBS8ZOyHQDKrwFf9ezHM8zs0tRUlQ9Oz/vijRKGS55m1ekdd3f046CdRUrYGn04tcudDvg7xxFlAhRZntTOXT7yMGfleK5Dk7L09ARitk9F+kdBMn7apHLIuuurARXgnCCE00Ln7jO+nAiKBAMo01i7lUkHxvyxIg4mSToARoI3YZntFTWMOmxo0vMK/vQs63gKo9Gr7StnnvSF+I24enq4QMz3Ns1rBMlt6yKDyT/AKlZ7v0B7FYXeWh8ftZNTqWKsp3iCDb9w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gfo27aNZHMASfzTvyttQ+nJzCFpK2PetssBbEoBNhV4=;
 b=EpUU6BRS9ku3JTmWiCXzhTSodtNqw5hZ7vSJ/Ej2XBwdHKn+aARH5MtPsZUN2/NaYCy4ARUPhG5IoR1M1iSmCTGj3KDZHQBDUwQvyzmdvwBr1GYUBdhf1u3zB2hskflic8AWqHkX81T9lAiXFbEEBJ2TKljNpA3oFv1oYZ/3x0ida2nHhqwqB0a33PbXV+MVKn4kvbyaYrjInDmCP2FI6wKd1HLUlisezUFg32wUi6DDXfCKlUJokojivaln4KdpjY+fpiimHN+tQUbrrPyghvNJrg4/5+mZ5rKKR8BFAtVtmnV8f9KX6PA/iIP9G99msv7Zdc4OoW8OBAMgbRyxkw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gfo27aNZHMASfzTvyttQ+nJzCFpK2PetssBbEoBNhV4=;
 b=X9CTnlnBQv3rSWwuTKBGeV6g6zy2aal2faq3MRfkwG0brXzxfSbf8fOZyeVF2M8qA/37MvXltZ08Ic5bzC7NKC10hnXZSzBPF7WY6K+QGQSWGuuuxBVRDtTTqoNFyr+Gk/8/XwsI0CQ9nrbN4+lT6y6Vc0FpFycGwBSsWSyV/6w=
Received: from SJ0PR03CA0057.namprd03.prod.outlook.com (2603:10b6:a03:33e::32)
 by SA5PPFD8C5D7E64.namprd12.prod.outlook.com
 (2603:10b6:80f:fc04::8e3) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9913.11; Fri, 15 May
 2026 05:30:14 +0000
Received: from BY1PEPF0001AE16.namprd04.prod.outlook.com
 (2603:10b6:a03:33e:cafe::7f) by SJ0PR03CA0057.outlook.office365.com
 (2603:10b6:a03:33e::32) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9913.14 via Frontend Transport; Fri,
 15 May 2026 05:30:14 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BY1PEPF0001AE16.mail.protection.outlook.com (10.167.242.104) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.25.13 via Frontend Transport; Fri, 15 May 2026 05:30:13 +0000
Received: from jeevana-X570-AORUS-ELITE.amd.com (10.180.168.240) by
 satlexmb07.amd.com (10.181.42.216) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.41; Fri, 15 May 2026 00:30:11 -0500
From: Jeevana Muthyala <jmuthyal@amd.com>
To: <Alexander.Deucher@amd.com>, <amd-gfx@lists.freedesktop.org>
CC: Jeevana Muthyala <Jeevana.Muthyala2@amd.com>, Jeevana Muthyala
 <jmuthyal@amd.com>
Subject: [PATCH] drm/amdgpu/vcn5.0.0: enable secure submission on unified ring
Date: Fri, 15 May 2026 11:00:02 +0530
Message-ID: <20260515053002.1167167-1-jmuthyal@amd.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY1PEPF0001AE16:EE_|SA5PPFD8C5D7E64:EE_
X-MS-Office365-Filtering-Correlation-Id: 517e0b73-e4b2-49cc-d438-08deb2430a63
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|82310400026|36860700016|1800799024|18002099003|11063799003|56012099003;
X-Microsoft-Antispam-Message-Info: HgBSbGOCTYqu1ktdVOTNjpq8s1GS+v7Sj1PULWikLpbK6LOpveh62WqyCsRDJjSFWBTvDP+InEJMqEkD61x/vt6ryx++Swa4XWWwbf7zyQ+u9U4Y8qbgkXaH0TQ5KrSrBjSaJ92rsf2fsOteW269+5g3RP6J1j5KCuVKJDIbjc3ENdUxOZQnhyXW+/CKa1KYV+1jk2IB90etXJt6MDYg9ERWmFLX+IQQjIy40y/CBXUdeTFAv52IshXHQsTMB7JfgHqvSOH9Qmo5QjPSN1KB3buvPCk2l94PG4FCcOVdw5GSdB3ZfqyfIrq+CNcRQooquvXljCDcAn1PcDLxhh3+mQfFcx+1d/DzO0U4Kx4yIwSjVU0t5T6KdiBgWrrtfulL4z+4yia9ettWTBMY6UtPjjzOdGnp5Roln+2O7guhmaRu+qUX0YPhe5BD+QyshpQa29rjf26VnYYkZdJVuJnrCZ+OTFamF5QAy8IcPxRrlXENnfn9ey5OmD13/0JD3N1dzcaXTR9xWuKgicbIV0FVXH9KlvfQPFJK8AVnKfUfW4OdHUFaqm+G3YUM5M3IvYSWBpkTZlpwfxqV9L9oAbtd+AHNc3+s2Aa/nx2gSTB5+etSDn5e5Mei7w9hhojDoYUSmDVS95/tl2efKy6qoy5DUO3/4NLzz9s8sbrpfvVO3yu+tXpIInv87Axk5mRczGNa3X1WPUig2QoLM2X96gZgO6pUSWhEYoQkpwL1w2PsNGU=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(82310400026)(36860700016)(1800799024)(18002099003)(11063799003)(56012099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: eUyLg5cNdl/cfZuIkqWOxAAm++BdPqCGkRRsX5aaF0z2hFSGD9uBCFkNHz7YyCH/f/F5HjL337ZbSP62gTf1AgGltcr2kgxIGZncXjAzB42SEBIZFerffvl/zInPEV0KJac9SKmtjI4eiS6gv/BTwk9AJf7op1ZmcxsDmcxcquOoNs1F6omxsIj+NwDMH+8BcVP+UfP+nhlxgewXp95WngzVitgjBOkF87dYEpbaph2Xwkv0zLMXixYqL6nbl6QJaWGbMIyuGwHqqRQNfB6bPVW4rKoJw2RKkS43Ccy6rYiJ9WWLtEh/vCHSNPVN4HdiiSjH2DuJcn1e+/Zvosd/E9YqAICUVc8mIid2uvrggyhxxLA/inYwOsEo00VXpxR9mfwqLhKAh1QtJbyBFSIE/rh14EsjRhv/udaXAvMGyXaK8HFY4TS3XYrTl9POEIzq
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 May 2026 05:30:13.9230 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 517e0b73-e4b2-49cc-d438-08deb2430a63
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BY1PEPF0001AE16.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA5PPFD8C5D7E64
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

From: Jeevana Muthyala <Jeevana.Muthyala2@amd.com>

Signed-off-by: Jeevana Muthyala <jmuthyal@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/vcn_v5_0_0.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_0.c b/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_0.c
index d5f49fa33bee..f875dbcd4f6d 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_0.c
@@ -1207,6 +1207,7 @@ static const struct amdgpu_ring_funcs vcn_v5_0_0_unified_ring_vm_funcs = {
 	.type = AMDGPU_RING_TYPE_VCN_ENC,
 	.align_mask = 0x3f,
 	.nop = VCN_ENC_CMD_NO_OP,
+	.secure_submission_supported = true,
 	.no_user_fence = true,
 	.get_rptr = vcn_v5_0_0_unified_ring_get_rptr,
 	.get_wptr = vcn_v5_0_0_unified_ring_get_wptr,
-- 
2.43.0

