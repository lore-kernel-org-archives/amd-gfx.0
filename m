Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6FBA8FF8860
	for <amd-gfx@archiver.kernel.org>; Mon, 27 Apr 2026 15:59:56 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0713C10E7ED;
	Mon, 27 Apr 2026 15:59:56 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="LhyMbq9A";
	dkim-atps=neutral
Received: from BN8PR05CU002.outbound.protection.outlook.com
 (mail-eastus2azon11011052.outbound.protection.outlook.com [52.101.57.52])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D0AFC10E7EC
 for <amd-gfx@lists.freedesktop.org>; Mon, 27 Apr 2026 15:59:53 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=zQn9lqt5FJFKwCgkwcdU0URgevoTCv1hbqkhupo/CW8GjzIoOpXLcbR7eEmkkJzBWcpdqkiHB+bkPsF6T5q98RCgGNc7VFec9UVkslU5oJ4coUP7Hv5ajUg9W/iFvXkf2eNtmS6ahxZwyVkY99cXU6IOezt9U+J5wHar/HXzGQyCjDHG65dMMj8yjImmUS5WiYuvIbqSmbHmRX1pIQQ2bBC8NcW7u4FjeiVMzlM6vxXoo/NUPxmNGxeijvOFCrV7N1S8IllJXIL0FZ3se4HSByUKgWdM0nhNl9yTQmY0tnCkXNLVEQFcZqnTN6uq4zsHWhWpxgmoT4zqiB/zYVZKVw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=B/rQwn4YSNw39Fkc6fetTCPWkVPVukhQkgADsXhbPwU=;
 b=p0EkC7CVNSuAbOWloMKVNroOGC8TEhG91SN8egYUWK91nxu1+cip5A1xjycwMVF4KGmMhRujOlNnhg5AQqEdxz8WnDbpUIRfqmw+n/E/GQxpVeO8hn/Kc+455vKbzVkHhpfZSsZolQlxS+Q/SjKe+rpYnDt/XWYRpD2YoZA6Hfsf2WfS/M5j1wlBM5dOYDp4KqoblJAC/opt2o2qOEnW0t9rueFJq0ck5cR4jx1JEeo5KYNQ2TC6C3z/rabAw71HuPO3fn2jti8ipozrnDtLwKM1wJHDfLlJ25dSSkOPaP13iHhEAC1soLPivJDEyHdXTxOetKRgvDwIWofRlHMhcQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=B/rQwn4YSNw39Fkc6fetTCPWkVPVukhQkgADsXhbPwU=;
 b=LhyMbq9AbtjeF1Y+0dQU0FuxBXZS7kgqLuEtsZa8iUNOzPJSoI5LBYv+XFRHsPtHOhxBx8hL+0JUXT35gO2YYUCdn4TxtMj7+uMKexxQbkAUYrfS+5ELEriii3LqNIfAbBpWGLUHuGY8YxYdxoXcrYT3ek2zBLTgKCXKttVvlAI=
Received: from BN9P220CA0019.NAMP220.PROD.OUTLOOK.COM (2603:10b6:408:13e::24)
 by SJ2PR12MB9116.namprd12.prod.outlook.com (2603:10b6:a03:557::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9846.21; Mon, 27 Apr
 2026 15:59:45 +0000
Received: from BN3PEPF0000B06C.namprd21.prod.outlook.com
 (2603:10b6:408:13e:cafe::2e) by BN9P220CA0019.outlook.office365.com
 (2603:10b6:408:13e::24) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9846.26 via Frontend Transport; Mon,
 27 Apr 2026 15:59:45 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN3PEPF0000B06C.mail.protection.outlook.com (10.167.243.71) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9891.0 via Frontend Transport; Mon, 27 Apr 2026 15:59:45 +0000
Received: from yinjiyao-dev24.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Mon, 27 Apr
 2026 10:59:44 -0500
From: Yinjie Yao <yinjie.yao@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <christian.koenig@amd.com>, <alexander.deucher@amd.com>,
 <leo.liu@amd.com>, <ruijing.dong@amd.com>, Yinjie Yao <yinjie.yao@amd.com>
Subject: [PATCH v2 05/19] drm/amdgpu/vcn: set no_user_fence for VCN v4.0.3 enc
 ring
Date: Mon, 27 Apr 2026 11:58:43 -0400
Message-ID: <20260427155857.1370151-5-yinjie.yao@amd.com>
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
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B06C:EE_|SJ2PR12MB9116:EE_
X-MS-Office365-Filtering-Correlation-Id: 3f06cf8e-73c1-4027-b4e7-08dea476005e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|36860700016|82310400026|22082099003|56012099003|18002099003;
X-Microsoft-Antispam-Message-Info: v21fshppaYi+YuJRM90pcRVQGpY0rKOzfkJJYC6eJTYNxyHNhefMDQqsAAHYIsSSrb2vsanCgeEbYM+q/D4J9ARv9giqrBJ8NOYyUfWBmK+IdLpx0MXMH46oD3P4YxvgaCe+ztB0dCraHbKlksl21QXH+gH9U0rkBzOPf1awGCAs5tEC1zzsVdCpmFbhDubpy9q/XRhdmgJnElSn/Z7oRM3IvVxM30DT02yfBuKhSdY3cT7CahLuLoOxZ1rTcPOzuUQFF0Mcx202jRGRg7v3Dk9NYDDAZZa8e0SsaezzeoiuKnLrrKhcbULrwZshS3e36wJe3nZfRQHO9sRPhHfXRb6GJXGQcdYpxcS5qCzMDKCO7AXU/laRqvRB64kiGvdV8zaM4CEu9kCMlL2D3tuy2UO9KsQQtMDL1nyTcYX3lTq2kEiU9c2XkvTb4ilDWk+nU1GOttISPZaUyCCZmGv1nafMPNFQA9OXJPG/JHaBaZWub3YRFgaEI3mB/KVX+rlkq0Gkhwps2/atRGBqvdHTqueEkKbJZGk6+BrEPBrkLvjuBF1H35n3JUv/0pz0SYApMoqVM+OYhMgIzSJBAXAK6miRO9BDxYec3BwatChGpLPYtRvoBcFxS9BEdglF/GntIRvevgMaG/x/GFjMcZsK6wXOEoo2k+YNl9wDWnaarkwQzIvC81BYtIxehrtMrzKOEBASp165Vj/Jgp4+m44GqwUKDg3mc5WFCeIabmS2N4AHIMRdwRHC44LFDXeZeA07LvLGIaGrJIa5K7+4+Csqdw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(36860700016)(82310400026)(22082099003)(56012099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: /1E4aD/toWofTuirEoOgmW/IOB8zjFGaQ1z/lAjPpjB2OjHzh8vBNWCeyGSMcBcgi+YZE+jDSdYkYiLlw4chIDIFEqyXzt2y6+c3K5x2ugmPUJO5waLYmimMsA8PzUqxBZKTGzoIgfkRMN+w5aCjyPBg1VAsyvHbyyHD+hRi5QUXoM0+3iTSleLylcPSKp2+APoaPskavtTkV6/uF5ghD68CY9HP+R+2wFkjTytig9X3gWzIHkdj2WEbHW0m3TS3Z1Lu8wO7YfB8/qPkb9WIYy6DCfoQPqVJwErzY59rmNBELU/1kKbxgz3liCJV5Q5+Icm7m7gWgACQDcGO+i6FHAB3c7Wk5LA1ZymRUYbtMW95k0Brvv7LmRsDRTA3C4xM70sEbKrmAs95m8CEdlfHi7IOHwJ1+pt63Ji+Ro1zLHe+jmq87PML12dg00a+P06n
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Apr 2026 15:59:45.2068 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3f06cf8e-73c1-4027-b4e7-08dea476005e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN3PEPF0000B06C.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB9116
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

VCN encoder and decoder rings do not support 64-bit user fence writes,
reject CS submissions with user fences.

Fixes: b889ef4ac988 ("drm/amdgpu/vcn: add vcn support for VCN4_0_3")
Reviewed-by: Christian König <christian.koenig@amd.com>
Reviewed-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Yinjie Yao <yinjie.yao@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c
index ff3013b97abd..10e8fc2821f3 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c
@@ -1775,6 +1775,7 @@ static const struct amdgpu_ring_funcs vcn_v4_0_3_unified_ring_vm_funcs = {
 	.type = AMDGPU_RING_TYPE_VCN_ENC,
 	.align_mask = 0x3f,
 	.nop = VCN_ENC_CMD_NO_OP,
+	.no_user_fence = true,
 	.get_rptr = vcn_v4_0_3_unified_ring_get_rptr,
 	.get_wptr = vcn_v4_0_3_unified_ring_get_wptr,
 	.set_wptr = vcn_v4_0_3_unified_ring_set_wptr,
-- 
2.43.0

