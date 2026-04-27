Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 228F4FF8860
	for <amd-gfx@archiver.kernel.org>; Mon, 27 Apr 2026 16:00:21 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B8DA510E7FE;
	Mon, 27 Apr 2026 16:00:20 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="fMClyyZz";
	dkim-atps=neutral
Received: from CY7PR03CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11010045.outbound.protection.outlook.com
 [40.93.198.45])
 by gabe.freedesktop.org (Postfix) with ESMTPS id ABD2A10E805
 for <amd-gfx@lists.freedesktop.org>; Mon, 27 Apr 2026 16:00:19 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nQnD1DPLyjTaq1rv1W3O3h+K1xzooAIx0GIFZlZgB5bwxMLAvdqLfJ2ST3iz7H0ippbBSJhFqaedTpiU0j8pGBcxsIbA+JICuAHS/V3uqsOYp+BLWPjgp9z+CD8IRue8NnjMrzDeqi3ODLhZdOWfllqq8kDyph0QA6kph5tqanS3z6BWR6UwFtwCdJhSixlBzfOwm+hrSfaJ5OxfsKyYMxNa1hKvTOsowFKlnPmTHdfaHzlwQwDZyUsgWUMdAlfSBV9vFcT8+RuISFod+4vNL2dQLctRSfr38nDRECkK/V2VinpzQ1A+yvv++vT9I96oGfBzUI2JDVOm8URwqWSHeA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+d9uz+RkOpTVqodC+aHgZKci9aXovV+MJe7peGtZpcY=;
 b=OuO6sug5kC9pse+pxESAnssMQiZEZFn/KZPylWHRWCs8ysgLniMKX+735e6F6e1DvS7HeJFFs8YVYPHfSeSdUXC6w84KZp0lRbWtiNNxwHh0/znOpBlI4H+FwJbGuXelTYFqOFjoIkQX8c4sPv0eLWgtakexFslEQofzmQ4VSVASYEYW8U9Hr4+iPj3GQnm1CjwtKkaTdqqd7cugF0ZT+nK9wnK2a2pYIfqZsxz4EUQl8Z9T4Nz92JG2clfkuD9Opf7xRZRR1c3Q2LdeGskGwx1fn9f0fqBE5Bot+pJHLXPFimBjD2Xnsu2E/HKUtI9YZe5XblPWxtMQoPvUkXMEmQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+d9uz+RkOpTVqodC+aHgZKci9aXovV+MJe7peGtZpcY=;
 b=fMClyyZzaBlqnwghRBS7bLV3Brc20+bjdcKZWHdBrVwvXS7AjlDh4+qq5aToYJt+j039xtdV7l0hZ/S17Y3BD+MGdbR26l7C/ztMxrqL82V+khcOFg7+s34iIMFr14STnWo6IgUq1xD157NbAvAEx10w7igwBaIk4RqCPAq2GDc=
Received: from BL0PR05CA0004.namprd05.prod.outlook.com (2603:10b6:208:91::14)
 by DM6PR12MB4418.namprd12.prod.outlook.com (2603:10b6:5:28e::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.15; Mon, 27 Apr
 2026 16:00:10 +0000
Received: from BN3PEPF0000B06D.namprd21.prod.outlook.com
 (2603:10b6:208:91:cafe::82) by BL0PR05CA0004.outlook.office365.com
 (2603:10b6:208:91::14) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9846.26 via Frontend Transport; Mon,
 27 Apr 2026 16:00:10 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN3PEPF0000B06D.mail.protection.outlook.com (10.167.243.72) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9891.0 via Frontend Transport; Mon, 27 Apr 2026 16:00:10 +0000
Received: from yinjiyao-dev24.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Mon, 27 Apr
 2026 11:00:03 -0500
From: Yinjie Yao <yinjie.yao@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <christian.koenig@amd.com>, <alexander.deucher@amd.com>,
 <leo.liu@amd.com>, <ruijing.dong@amd.com>, Yinjie Yao <yinjie.yao@amd.com>
Subject: [PATCH v2 17/19] drm/amdgpu/jpeg: set no_user_fence for JPEG v5.0.1
 ring
Date: Mon, 27 Apr 2026 11:58:55 -0400
Message-ID: <20260427155857.1370151-17-yinjie.yao@amd.com>
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
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B06D:EE_|DM6PR12MB4418:EE_
X-MS-Office365-Filtering-Correlation-Id: 7a8bf7b1-3442-4171-1623-08dea4760f3c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|82310400026|376014|1800799024|56012099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: XdOnnkJC1En5mpDsRTGN7b/wv82KfSSpVwBgBP2/v9Y9rm7lYD8LuUcpeZOWScE2t2hh6SCMFxplXWemgDJTHH0hhezbUIzs3LZs2TnDsoqZshI972rU1K+ZgbjlC4KmMZtQcpWtykEP9rE4CbMrn1vH7uWAlCXY5F5lSYqQG277/T17o21EiNXJt0N9htWTUfdhvxmKeMjE8niQQ3Rucqacj10rPL72SR2ajWtfhUbasDhGzf92r/KaD4UsSoIwMJYzDUpyB1zNB7WchYWUl5s9PVjvCr7cwUFUCF2/NL225xTdfi7Q2g/VVuAgQ2vov84KD+tDEb7MhTSp5TrqhVKSFU9wrxZtunGoQ/ClySNNEWVpNc/lpoo5knoSYC2SNaey6EM8Zz+FLCp9bKxExtYa4ODP9/TuPV37F70pq4JkfmqyQK7APNy+zUYMThOrtaA9CtCyCHS3YL42G7qQixyYEpIlb/LIJ7Ss/9qEfkFfNIACXc/rD/le88zTUiJEMmqruESL0PgPcXEzwzWNI0HosKtMUnXBQtcbn99z3LhD22jcjlhZKtPN0LfcPwqVFFHMh4Ow6fI89wqNZIfdikHEBjQavr20uMTRcu51g5JbI7qNF8gzn3HKmQY1hqb3oOnpiNn2DW4U7Ns36ZRN036Ds1lNoX3I/HhHOiDJ51winWPH0/E/BZST7+HQofK5yP8rIVwgB6uhmqR+5stvRz1rpXDsVXtZw7zRPNaPjWz+x1+HBkQ0hArY6aVrtxq/pDu8hlbR0ALyfSJ4Bj50Fg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(82310400026)(376014)(1800799024)(56012099003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: RbkGm/2AmOV0XE6B4IcljbZotyI3E/Tp4FQoSkIIkZV//gWXlcxz4BAzyyPsUOQShElylK7NOVJVmgdtDWEAKuZ0KitZZQDB108Fq/mHWj9zLp2G3+wATeVP2Zalr+7Yo5ulippzKU6dUvF8KZlWMZA+Zpo6hoUKNpDJa+K78MxS2L7qCbqycyf9GtdOXTgDD1oIg5qFzDUimF6x6aJ0Y9ClBWXUUUvx90t+0vXZr/FNBuG9KpTvq1bcRUb4ZpgjkXjw5nWtiHl9UbdmBa3DTFg39UOfsjI3euhbZbf0h7ZZ/PLpoFEk8rmvqYNPgo7PzxOKFr6TLWswj93ebQuyGXvdkklMGatW/fAbsM9FVvhzSY5T5Mlyj/yJOKoPpc2FbhF6U29aGmQlPz21U4RlrB4kQLTKk6Ex00XnYX0O5POfYE4y90p7cEC+rkMIT+CF
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Apr 2026 16:00:10.1455 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7a8bf7b1-3442-4171-1623-08dea4760f3c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN3PEPF0000B06D.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4418
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

Fixes: b8f57b69942b ("drm/amdgpu: Add JPEG5_0_1 support")
Reviewed-by: Christian König <christian.koenig@amd.com>
Reviewed-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Yinjie Yao <yinjie.yao@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_1.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_1.c b/drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_1.c
index edecbfe66c79..250316704dfa 100644
--- a/drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_1.c
+++ b/drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_1.c
@@ -884,6 +884,7 @@ static const struct amd_ip_funcs jpeg_v5_0_1_ip_funcs = {
 static const struct amdgpu_ring_funcs jpeg_v5_0_1_dec_ring_vm_funcs = {
 	.type = AMDGPU_RING_TYPE_VCN_JPEG,
 	.align_mask = 0xf,
+	.no_user_fence = true,
 	.get_rptr = jpeg_v5_0_1_dec_ring_get_rptr,
 	.get_wptr = jpeg_v5_0_1_dec_ring_get_wptr,
 	.set_wptr = jpeg_v5_0_1_dec_ring_set_wptr,
-- 
2.43.0

