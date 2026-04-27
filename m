Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A9D01FF886A
	for <amd-gfx@archiver.kernel.org>; Mon, 27 Apr 2026 16:00:05 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 19E6810E7FB;
	Mon, 27 Apr 2026 16:00:05 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="mZzpUWCe";
	dkim-atps=neutral
Received: from DM1PR04CU001.outbound.protection.outlook.com
 (mail-centralusazon11010045.outbound.protection.outlook.com [52.101.61.45])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6B3E210E7F9
 for <amd-gfx@lists.freedesktop.org>; Mon, 27 Apr 2026 16:00:03 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=J4nJDnFOVAnM8LCu4bC5/V1mIyK0tptwhntjjFazrY7UFJU/aXCaP9qsfrfXCHdorOc5j+R7h1C+y5jAfXsMV4Tv4IZ53l61GZU32lnaYGJElnl0SQB877HZZpmqHzMn8tLZGzz40EfBTL0I8/etYOfDQjJ9OmKp4QkxAP6vrilP/rVCo9leKEwoLVrUPIzDDH3PVyFVV7TPKWQj7wrCg352I/RmeqI5a9RFoPmr0PUJigIzf7jtiTZBMfc4HWYJYsf4WBhWufEVVRYnl66Ndkji+sPX9gzeIZCH7pgJvQxrPFjpAGl+3jXD67X/SJmyNzBVQMqiqyN+aIenLSp3iw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PTTswPnv2276JSFojg9ywCI1rGyFnxBLy+rXlFqQI/I=;
 b=E45rTpApC4sa2mSnTZTlHEdtH5kobaC4QNcvIQXK5r/2CIkjMSi0vnnKi1Es/cCjdnYwPMwYEBDzeU8Hf5h+lBgsveLYK3qTjnkwXBfyyz0vInuWIegwzqFzOo3R4TEwk7ekCM81rx4LylLII0rMG+S6RETUhWzX8UTNqwHEEPuwP7RbNK3cj+wLeLXx+ssxunr9O8mNudra3iuD7dDFzwt/6D5O+nizRvQknvqEyiKM8OjjY7ICsU1e8pxP1kYr9maMWAkmu0LtGFbU3m1tlf4ftKJ25NVGlXf+MyKAMha2W5HimOOihQx2JhJhsIOAEi1TN4ULQVK9L3gfg6vDvg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PTTswPnv2276JSFojg9ywCI1rGyFnxBLy+rXlFqQI/I=;
 b=mZzpUWCehtJk/dT8ViV3E12HXURjQr2jQBn9euMVSEu+5wDP/HlD9RjgiA1PgnP0qyI8zRWsBWyNP02zGqcO5xsxtI/z5iTTOpktS7cundvhKE426SaVwdJSXskv4gmPuxpTOtek8v1O6OpkHOoOALNWdeqhiR4CWiZfPEsT0G4=
Received: from BN9PR03CA0773.namprd03.prod.outlook.com (2603:10b6:408:13a::28)
 by MW4PR12MB7032.namprd12.prod.outlook.com (2603:10b6:303:1e9::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.15; Mon, 27 Apr
 2026 15:59:58 +0000
Received: from BN3PEPF0000B06B.namprd21.prod.outlook.com
 (2603:10b6:408:13a:cafe::a8) by BN9PR03CA0773.outlook.office365.com
 (2603:10b6:408:13a::28) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9846.26 via Frontend Transport; Mon,
 27 Apr 2026 15:59:57 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN3PEPF0000B06B.mail.protection.outlook.com (10.167.243.70) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9891.0 via Frontend Transport; Mon, 27 Apr 2026 15:59:57 +0000
Received: from yinjiyao-dev24.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Mon, 27 Apr
 2026 10:59:54 -0500
From: Yinjie Yao <yinjie.yao@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <christian.koenig@amd.com>, <alexander.deucher@amd.com>,
 <leo.liu@amd.com>, <ruijing.dong@amd.com>, Yinjie Yao <yinjie.yao@amd.com>
Subject: [PATCH v2 12/19] drm/amdgpu/jpeg: set no_user_fence for JPEG v3.0 ring
Date: Mon, 27 Apr 2026 11:58:50 -0400
Message-ID: <20260427155857.1370151-12-yinjie.yao@amd.com>
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
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B06B:EE_|MW4PR12MB7032:EE_
X-MS-Office365-Filtering-Correlation-Id: f820d9c3-5ed6-43f1-9258-08dea47607b0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|82310400026|36860700016|22082099003|56012099003|18002099003;
X-Microsoft-Antispam-Message-Info: P1otHBR5c5uiwTbgVY25UHm6UCP6BSd8xF2e6vOyN8NTX8mlEoFY8wcHDLDah1Ui1ohJtrqG2rE3uSAJannecVSBHE9o9794M2r5w7ZOObU20dx54I6ZturCTaUZZTTkB8GLaqArPA8yazdMsh+wpSFiBy8msQZeFqe404z4oxA/jnhYWo+3Kj95qpVyP1BW9svRzZpz2JInWazVB4fMKEnAR4WeJivHH56ffIlm7bqWRgMRGan7VzW8t7GMCr3inbtZklbUJ01FNkFlpGrYPN1C7R+ZRFAYiGiPblVsv9/5yvEsNpzureGnCJsQ9mtY7+VqudWDuaZYib7WvE2+E0MH8iCmKwUjKzw5uv2EXNazJCeNzSm/dXzQ+DSJC3aG4UrcjwMox8k7qbz8ZDULzclcn/i941tLA7XdCGGG3BleBHa1t1gmUSiTPUiyauC3YTnR+bneCcVBvkBo/k0bjVFUIbrVv1MwslsWvCbvHuDEgSEtRUHa+FT1EnxeNNeLyhKYitLwqYWY8O4+tDL15BGUs4A+GlG6aBlmlsRR/z8GF1Tasgj6Yp+Xl6VOMEs1XjNMPDvOVJTANfWMVhBsjGaDtcaT5OaYwf/xONIj6ZCwqH9CDWLROwJEL82H2MBnzv+dy0u4RJDxndFE6cf6r3rgG71G5fJB8yYjp6VQ8lEgQC5QsW3A2RJeR+LWK6XvXJPrR2vziAMXLtKZOCN23T+eWk3gz2qcpAWd2y6GYOpZtN3tT03qJLnnjq0JR2SJqAEhXaNtP2HW8NrBsECSrQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(82310400026)(36860700016)(22082099003)(56012099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: nqVyRMlBCuuWXJfzJ//ACj/A/lRDo9k+qsEsj2J9/3QSlUk8J0d5pYLX2LQIRfZpUWL5btUPzRxWMcsSs0SvjNGa2x4x2vRs1VobucSq0xwAl2UAYppce3uQUF32Jg6eQJXAdME6/vmP+MhYaX1mfWe8Fm5ktYlQqmSGQ+Sklakh6J9Fgsct8paO4x/pP6ro9DLSOXcJjOSTeyT4I4tdpomUIhe0Nf7Wlv1sDpax4V6wSUtooE2YqAhBMfcrsMxQRJTBVR7LkfPfie3pbmHmOoGho2REnOGLdSRpvSZFVxbLJJgylPV27vCrb00dFy9R2RT6wDo/50U3R21hVRIji1BvteEZC2/UqllJWeXqDjp+NRL4JxzIk5eepbVnJo0RsEdKUPVP2THTYlioqvZYAZlLclZQxgQvbq71g9dfoDKybVw5z3UG7V+xlgcxfY7O
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Apr 2026 15:59:57.4837 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f820d9c3-5ed6-43f1-9258-08dea47607b0
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN3PEPF0000B06B.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB7032
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

Fixes: dfd57dbf44dd ("drm/amdgpu: add JPEG3.0 support for Sienna_Cichlid")
Reviewed-by: Christian König <christian.koenig@amd.com>
Reviewed-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Yinjie Yao <yinjie.yao@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/jpeg_v3_0.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/jpeg_v3_0.c b/drivers/gpu/drm/amd/amdgpu/jpeg_v3_0.c
index 98f5e0622bc5..d0445df39d2c 100644
--- a/drivers/gpu/drm/amd/amdgpu/jpeg_v3_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/jpeg_v3_0.c
@@ -594,6 +594,7 @@ static const struct amd_ip_funcs jpeg_v3_0_ip_funcs = {
 static const struct amdgpu_ring_funcs jpeg_v3_0_dec_ring_vm_funcs = {
 	.type = AMDGPU_RING_TYPE_VCN_JPEG,
 	.align_mask = 0xf,
+	.no_user_fence = true,
 	.get_rptr = jpeg_v3_0_dec_ring_get_rptr,
 	.get_wptr = jpeg_v3_0_dec_ring_get_wptr,
 	.set_wptr = jpeg_v3_0_dec_ring_set_wptr,
-- 
2.43.0

