Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2B833C04FFE
	for <amd-gfx@archiver.kernel.org>; Mon, 29 Apr 2024 09:10:36 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AF4AB10F3F4;
	Mon, 29 Apr 2024 09:10:35 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="tOqkFbCj";
	dkim-atps=neutral
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2053.outbound.protection.outlook.com [40.107.93.53])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DAA5810F3F4
 for <amd-gfx@lists.freedesktop.org>; Mon, 29 Apr 2024 09:10:33 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aOzcQhG8+dxNYadsitpkUKHGehWoO//y70DqhEnfzKxvXpiVi4fKkIW1KPplDiODmU/je2uXeEnPgU0GknMyVWBSPAmJe16weJ1FWnFg0XjMuRu4gNd7G20+YLKvupQ+gmKsiO2juMBBqkOqIgw4GiWcHi3+hWvbG6lmHFtN7FG5Ad0h4OxcjApO02nYY3CaEgdRT6v6YAnTJMIvjrh7ZxESkUWpX47QvGh5FWJAVUmDMqGLQ1+YvsMFj0e2ea96oqh8g4ZYx9vuHmZGqzfDfj3S6dVO55fCAg3qR4qaL31w2BqHG+BH8v3I+SLdPFBa/6DFH3MTCXfA55yanj+Eng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=b6d3nj7rJkxKNVI3h6X6E9iEbBeiIsEGJDE2F+YtzEs=;
 b=KM7Vg9Z07my6Eb6Ht/3GbyAUV5ii84Z3z1kiz3tmHyo4dkQQADI41lyOfNv0r0BrxX0jr/RBTVNtCqDqK1m57FImM666ps0H83MNXRo/GMMjDemw3DqO/UmUw8X6KjpLgGU1lP1MpYF69/Nbc5nQkRBjkBHqD4RWdn+lmNYnCqpoDR2jc8u+jvoRaMo5+y5vYKNfONlV8Yhy+qjIsr4mtMDGNwRJ/MgHm4iKeqhGg8xcjVkDBK1HwFeVUzLhZAC30AoM57D7GnXuWNDz4mDXvflAaOmGjX8zBQ6u0kBe8fOkJc4dYT6sLMHtgCwkl1u0mKIVMwK6Bei8qW4LLZPI4Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=b6d3nj7rJkxKNVI3h6X6E9iEbBeiIsEGJDE2F+YtzEs=;
 b=tOqkFbCjTbA1+QX+jjjj8oN+/34JjQ0L6YTbt/rjLe7u8a/RqYYIXahT5aP+B3rlDF9eCyG/ec1bP0jBvEFDi7a1DuvMmQmm/wfqq6xGjVAaU7wPf5OOrHgCTeutnEfLA8eMDuI7y09V/t1izgHidm32SOAOEe40ZgjKAHw+Owo=
Received: from CH0PR03CA0045.namprd03.prod.outlook.com (2603:10b6:610:b3::20)
 by PH7PR12MB7793.namprd12.prod.outlook.com (2603:10b6:510:270::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.35; Mon, 29 Apr
 2024 09:10:31 +0000
Received: from CH2PEPF0000014A.namprd02.prod.outlook.com
 (2603:10b6:610:b3:cafe::38) by CH0PR03CA0045.outlook.office365.com
 (2603:10b6:610:b3::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7292.49 via Frontend
 Transport; Mon, 29 Apr 2024 09:10:30 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CH2PEPF0000014A.mail.protection.outlook.com (10.167.244.107) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7544.18 via Frontend Transport; Mon, 29 Apr 2024 09:10:30 +0000
Received: from jackfedora30.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Mon, 29 Apr
 2024 04:10:27 -0500
From: Jack Xiao <Jack.Xiao@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <Alexander.Deucher@amd.com>,
 <Hawking.Zhang@amd.com>, <Likun.Gao@amd.com>, <yifan1.zhang@amd.com>,
 <xiaohuan@amd.com>
CC: Jack Xiao <Jack.Xiao@amd.com>
Subject: [PATCH] drm/amdgpu/mes11: increase waiting time for engine ready
Date: Mon, 29 Apr 2024 17:10:02 +0800
Message-ID: <20240429091002.928932-1-Jack.Xiao@amd.com>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PEPF0000014A:EE_|PH7PR12MB7793:EE_
X-MS-Office365-Filtering-Correlation-Id: 4914bb8c-521d-48a7-f4ab-08dc682c37e2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230031|82310400014|1800799015|376005|36860700004; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?6/hRfdU5aWAd4SR4rXOpp3kYwpUyFa3P7NJBX/TSZq3uMWieFgT5IoQFd2fD?=
 =?us-ascii?Q?CDnonTLzyT7trADZIRsdGCX+AlQTRjKzaQzdweRG8Mpx0WSmFGT9QaI6XMAk?=
 =?us-ascii?Q?K81D2gakYMXXPRH5TNT52+6eroeAx0rd5ChvvcfzAo+WjTQi2Q9HCd2tobXm?=
 =?us-ascii?Q?KT4KekzthAbLsOc9lidr0jQyYaaQm0GMXYRZJJWsA0dE4260dgfZfNkn9IcY?=
 =?us-ascii?Q?mdrLn66r4YqtfN2w1WAeicc+I+Fq9Ec/yupkFuRYtpTpcrSVg0Y2EPOMQJGQ?=
 =?us-ascii?Q?F5LQ82Jz7miLVGtyztVkQud037mEaWig+XI4QgKTRaFMaP/3jAPrGX/BE5+j?=
 =?us-ascii?Q?bsRbV5i7L5IsjGC2isnSwh9AzNKDMYLf4gdXX+U1psYkuoRjesCBvGD35dGN?=
 =?us-ascii?Q?rRZNrmtTATeXkFe7kS6f9oL6fnmrmASJTns+GIVDUUKihGTcFTCUgHTi6UOq?=
 =?us-ascii?Q?zpAPvN0uSQTT0eHcgcugBI48/BJd1/yr5tZ9zr/8zix8jG/CCR7mk8Tlu6mk?=
 =?us-ascii?Q?1JD93g++8b3DcQKg84qOljD6d/2VEgtUbNX7F3kyZBNX/grLOAmWY8nnjOyq?=
 =?us-ascii?Q?XfKXZfpjFnChFZe8XpR8nW5rbWnvkRf6IRrEZzQE6ETvbLwY5yasKAxfT7lU?=
 =?us-ascii?Q?+wBRBUnUxfi+JCELJnI6Qwv8eEsSArrBLarDE+tK4GfaY4fxHLH5fGxW4T85?=
 =?us-ascii?Q?CNmi74vBsnhnVoQOyoAElY7MlvZXUYAGoINDq9o5EFCC28ptAhg5MJl1GSAj?=
 =?us-ascii?Q?90UwiK4+2DfHoBN78wJTO6JIlyj5XnGweGQsi44z70q0jGU+bYrckuNioNbi?=
 =?us-ascii?Q?2iV7Oebs2b+kkiiGAoYv76S1MJag9nFb/HFbX8TZkbZZeaWfiCbSaztgx5S+?=
 =?us-ascii?Q?30irVHHdeLZHUf5jlEtEzRBnH5QFFD7RSAncHVh0iRIQtpbtEbZ99bcLsj2v?=
 =?us-ascii?Q?XtCjnNHl3kePb1WL8m7lVkTODn+YsJHbKc/QkbJSgAXANnb4p8vpQ4amfmNs?=
 =?us-ascii?Q?wWCB06btRHuOVG7lYm1vaXcjticBxmhH95iDAErTKBcpHr8FmxIoHAQU2VFK?=
 =?us-ascii?Q?RzJGgeukPOHGrN1Y3Gp4jwF4BosYUvOgXT7wzkIHXfSAJ9s+12Owk2bZ3s0f?=
 =?us-ascii?Q?LdeWbEr4ogO6k+WQiav+h75A3H7+1dnjUxlOhJjAn2OIo+6gqaMaHFvs5bFr?=
 =?us-ascii?Q?7fhNhbMKmwtSbodNuRpwWepvyUI/PkQhWG0hHLK5aq8HdDMStS7D8vBzkydO?=
 =?us-ascii?Q?EymXfjKvpn/XDaulipDVJNSbnq4aw7QY8nO/KD40AF+nWk5NxxncBVG6ybLJ?=
 =?us-ascii?Q?1606RdkTySSUMRRGPj0el3ZPpfOoAOErm0W+hj36wzlH+FzxeWxAFjJUwGHy?=
 =?us-ascii?Q?adf0p4h9TQd+0wMlTBWyqNOt6WUr?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(82310400014)(1800799015)(376005)(36860700004); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Apr 2024 09:10:30.4613 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4914bb8c-521d-48a7-f4ab-08dc682c37e2
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH2PEPF0000014A.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7793
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

mes schq engine require more waiting time for engine ready
before packet submission.

Signed-off-by: Jack Xiao <Jack.Xiao@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/mes_v11_0.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c b/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c
index 28a04f0f3541..d98f6d282ae7 100644
--- a/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c
@@ -696,7 +696,7 @@ static void mes_v11_0_enable(struct amdgpu_device *adev, bool enable)
 		if (amdgpu_emu_mode)
 			msleep(100);
 		else
-			udelay(50);
+			udelay(500);
 	} else {
 		data = RREG32_SOC15(GC, 0, regCP_MES_CNTL);
 		data = REG_SET_FIELD(data, CP_MES_CNTL, MES_PIPE0_ACTIVE, 0);
-- 
2.41.0

