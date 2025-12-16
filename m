Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 110A7D637B4
	for <amd-gfx@archiver.kernel.org>; Tue, 16 Dec 2025 21:04:14 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6A13810E88D;
	Tue, 16 Dec 2025 21:04:13 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="RiAgOLsW";
	dkim-atps=neutral
Received: from PH8PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11012002.outbound.protection.outlook.com [40.107.209.2])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A59B910E5C0
 for <amd-gfx@lists.freedesktop.org>; Tue, 16 Dec 2025 21:04:11 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=f5ThCnhG2uuZw9N3vYGND9NXPV/kPd3KD/JtbdMipKsrIn+7iWlVx7UvOf8b0V6Fchh5brgquSICBJPZb7k5tHplxMacjzOzVl56Gzel7vFVd5TGkJTTfBncMmvjLZOEqvLjBn9xngF7hpFS1xA7NI6+gq89TPCaFdVv+1+uEVjQmC6T/2RQRqyEFBYf9m1kyDFySlJSI6Su+QMDCv/o+aXvi57qsegpxnEZbg27vO822KluAhVZweSPM3/jBRxXWeZtIdObYymZdk7HAtYPw85f3coQLpraB6tZfRTTABXlH30OhQ9l/so9/iARVYZuZEmasQ/M7EMp49qUEKwJpA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Cfqc5hW3ONUGq2Evwe9A9ZJ59ks0ZCyTEg8DnHz+/wY=;
 b=kr20hJB3qKQ4lF23SkKPaOUuOxbOF7nVpR5s+Hp1h7lk4B6UyPQbZPzaiMRnewEbHueCH5yA3FTW6qPApCWmgmGkIueZcpYeM40LUAh9nqpNsge7OuFyo4JlF8T49T8bOvTNxhH569UXSY4/mQzisYjzQ/d6rJm1ETMKElsuF9F97QXB2+5W/CPt0gfkuSx93w6XByIDWnhSQxpPaKPkP4JZMyJPMqoWbUhmNQr4gZv4Vx7R2RywIcb45qz88r7cXCwQCAFtkihRsuts0Ya14NgtdJMgq5crMffmEYpvZxhbQW2eV+PbRlNZVV+QbKka45r1ARbBB3oKj1Wr6uotJQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Cfqc5hW3ONUGq2Evwe9A9ZJ59ks0ZCyTEg8DnHz+/wY=;
 b=RiAgOLsWDzeVRh3/hvSnaDlmeavh8kiSmZp9haQtf2pDZrJq1hqmFYZ+s8AK+0ZmuLBsm5R7MNTmxtlobbsTDICnuYUUuqT4v+FGTukapn06O1ItstxrWuML5Hpi2EUXXF7JnUkgou6kFO+AS0g3gu7En5X14wR45FaB4S29P5I=
Received: from BL1P223CA0001.NAMP223.PROD.OUTLOOK.COM (2603:10b6:208:2c4::6)
 by PH7PR12MB8426.namprd12.prod.outlook.com (2603:10b6:510:241::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9412.13; Tue, 16 Dec
 2025 21:04:07 +0000
Received: from BL6PEPF00020E61.namprd04.prod.outlook.com
 (2603:10b6:208:2c4:cafe::f0) by BL1P223CA0001.outlook.office365.com
 (2603:10b6:208:2c4::6) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9412.13 via Frontend Transport; Tue,
 16 Dec 2025 21:04:06 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BL6PEPF00020E61.mail.protection.outlook.com (10.167.249.22) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9434.6 via Frontend Transport; Tue, 16 Dec 2025 21:04:06 +0000
Received: from tr4.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Tue, 16 Dec
 2025 15:04:04 -0600
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Likun Gao <Likun.Gao@amd.com>, Hawking Zhang <Hawking.Zhang@amd.com>,
 "Alex Deucher" <alexander.deucher@amd.com>
Subject: [PATCH] drm/amdgpu: skip gfxhub tlb flush if gfx is power off
Date: Tue, 16 Dec 2025 16:03:32 -0500
Message-ID: <20251216210349.1963466-6-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20251216210349.1963466-1-alexander.deucher@amd.com>
References: <20251216210349.1963466-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF00020E61:EE_|PH7PR12MB8426:EE_
X-MS-Office365-Filtering-Correlation-Id: 7028d3a0-efd3-4796-2e63-08de3ce6a6a5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|82310400026|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?c7NpDztWuCH2eokYKRMiFcPSkML0GNuooiudgKUcBhbgJUKZUecbGZAvPtBt?=
 =?us-ascii?Q?sNDrwK3TKMEFEu4YUcbj/BU0FVFH3JejNkkdQfF87dMF77isSGcrVcTbEaZy?=
 =?us-ascii?Q?hDeReCbnpewIkyvq05fOA+YaMnzhW7FR1XGWQAt+zQPTTQV6oS3K3sU5YDfa?=
 =?us-ascii?Q?ZZYcn3+BfSP9QK4eGxwmEtf+xiph8XoOd8m70SSTOyzAfbgF8uY3vLXBQrBC?=
 =?us-ascii?Q?YEuMQbaBCBexQKJyMJq76dJRQ881yhATZfk8S0XVk5jYpuspPwVaYEa8/HA5?=
 =?us-ascii?Q?evCLM/z02UFPei1X5+TxtFEW1hYxb5XADefM2llWFcAuPXRkp62bZ6zlIXxo?=
 =?us-ascii?Q?TaKZWzGSReKMpgpRbN2ElyR7kNNgbWYB8E9/oZnr7Ee7MnyasmaRXtmFOXn8?=
 =?us-ascii?Q?uuPSuQ3E0wN4Gf/9bTs08aVZbjgpX5NjMR74OH6Ze0wmwLntNDV6uvrnlOzp?=
 =?us-ascii?Q?zEMa8f6EJe6PhJ4/EtUTHu2o3MoNfDCwiR9fwGI28b1oqpGYRmSkMe9eiUCn?=
 =?us-ascii?Q?zZDTzR+YyoH9MFpSPbq6BORe0Dqx+hiBL4NySIVwpHHO1okxdQTSoYaqcCeO?=
 =?us-ascii?Q?AFIbGMOPwkMFQdsIdYhiNHent0NkJzt4Dgu25zTeIjfZcQYrMiPeH92RC6tJ?=
 =?us-ascii?Q?2mYpIWv1UDXKt+QRgtLi9FrO6XKtVFw4YOcdERAGeVQ75vpbfNURqgdOFUas?=
 =?us-ascii?Q?whfQS30TM9T4CxeiSRqIiwKsC2k9hL/DlmpQZjm/mIhfp2VcW7OkvYoyJFP3?=
 =?us-ascii?Q?6ae4ABJwGzRRACHWnTf2hf8hCK1+g3ENw85cVlwE41jAdOtTAe73B6GRt37s?=
 =?us-ascii?Q?W5INdpFDWf6Fo0MDOlJFYlZ0OfIQwrOSTuLWeWPNqmnkvESs/5XgnJgMkEHh?=
 =?us-ascii?Q?lgcOvfoNI0YUhgqZxa4Wu8pZy6CQNBNgyGACwa8y3377htFUxC6GLUgcefWG?=
 =?us-ascii?Q?U6EdaFVH/cv5XtQc4uTGncfP24J21Aix7lDX0qZDccwaycj6qthv48QtF20H?=
 =?us-ascii?Q?IOYxauj0SBSVMaKT4XH9VxERseqHVEpkC6nj5yZLJ9YKi6JSMZ6128PvInad?=
 =?us-ascii?Q?XEGUojjT66S3SD85CQd5P9b8WnamrCS9fF2wP23pcI7OvQtiCyvH8m41L5NF?=
 =?us-ascii?Q?3c6aOoS8oG6mDxynfLwxv50uKs60FNDYOtdoaHGdOUwVY9mlZtBRSfehT8dv?=
 =?us-ascii?Q?VmZSnmHUBmmI3bJXJQihQtzeury34fCA4366cjOImdJH31SUY48gk2a/QZHv?=
 =?us-ascii?Q?p0BeDmbCJX2h3zywU4I9KQO9MqRakB/daIHBwaCUWoJAn5jm0aPlhAyjilqL?=
 =?us-ascii?Q?7C7Pu6cBocw2XIgmgemab2l9xikbONxrauLmU8D/kVBV3KoSTDaEVeFYnWbo?=
 =?us-ascii?Q?Gj1wCqV0VVbgSNbrFPp+rIAi847N56EUmf2uVjSMeUOsIIuiyu8DDZK+kjsT?=
 =?us-ascii?Q?CkSS6WhJwPS2Y3r16SkzVwYj+Ohx8PbttQATy8f+JvAqARuxzSxUwggsFWTX?=
 =?us-ascii?Q?VYA6hVWV9/d37RSu1sOlqL7I6d95rkJfaUmOqfC3K92tvCzdd1/rHpLvaOi6?=
 =?us-ascii?Q?r31upuzuXERnGIzMYTk=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(82310400026)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Dec 2025 21:04:06.8751 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7028d3a0-efd3-4796-2e63-08de3ce6a6a5
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF00020E61.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB8426
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

From: Likun Gao <Likun.Gao@amd.com>

Skip for gfxhub tlb flush for gc v12_1 if gfx is not poweron.

Signed-off-by: Likun Gao <Likun.Gao@amd.com>
Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gmc_v12_1.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v12_1.c b/drivers/gpu/drm/amd/amdgpu/gmc_v12_1.c
index bef28aedfb93b..3c6b6c6f0cfc6 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v12_1.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v12_1.c
@@ -319,6 +319,10 @@ static void gmc_v12_1_flush_gpu_tlb(struct amdgpu_device *adev, uint32_t vmid,
 {
 	u32 inst;
 
+	if (AMDGPU_IS_GFXHUB(vmhub) &&
+	    !adev->gfx.is_poweron)
+		return;
+
 	if (vmhub >= AMDGPU_MMHUB0(0))
 		inst = 0;
 	else
-- 
2.52.0

