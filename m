Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 027E1E9A02C
	for <amd-gfx@archiver.kernel.org>; Wed, 18 Feb 2026 19:34:28 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5A07710E30B;
	Wed, 18 Feb 2026 19:34:28 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="LvpyUz1K";
	dkim-atps=neutral
Received: from CY3PR05CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11013032.outbound.protection.outlook.com
 [40.93.201.32])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 345E810E302
 for <amd-gfx@lists.freedesktop.org>; Wed, 18 Feb 2026 19:34:27 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Bp45AYe1c1b+FB9bdMnv6FjPOQwr5un5Q4aIRGhSIw7PgBpqGtgPmXEwuJpiM8aebWE+s/B5lJ7ii9ya8bVGrzJRJR8q7tr0WstXb6n8t/LXU6Kcc3emqetNiVmBFjyRXa3jPRDYFtE0x15yoKWj/YpZpQigbrA/JQKwgH6nmJjlr/XxVIVR5MWWkX9IAj4AQoRCyeoRWWoWhj2rRJlrz7zKCquFNkr8vN0i7siKSI+KQ2yekOunL83QcRtJG1nYg46Bx+GcdbDrdwMFeeci+/hkuX5U0G0fn53gpygaJPtw7KOAoAOzDrMvvHc13X8LyAUcK1fri40nRu2D6znkwg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rVTBhxTBmbeY7d6eYbKXWg7IRcgGG/awX2pJUZdvBkk=;
 b=xUB30xl5yEJk/vdPVIHm/idYDHWwIGxiwSg1/EDt2GvJ4JawvQ6+GIWYd0FSNe89otnJaVrTVT6IPmDJQ323V53q81MaLQV0zbeJxQZkfkkG3/dl8sLHXvJseG/07KSejrjbMaUulACAvEl824hg7+gp0e34xCLXN/PlDRNrD1gMC+IjZreF7ht0ZVCeVPALIIWWlgY9pI9Yj8QwDDRvMyLAd5+wspPx95c15fuZg6Ikv2zu5cxJAE60yJNVkP40IGLysPptBked+SAbpVdFRrmoU2owVvm9AVzYAhkNarbYDFk0Oi421sa6hkL/nYt5rX46bLeYxb5GOqgq8uoClQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rVTBhxTBmbeY7d6eYbKXWg7IRcgGG/awX2pJUZdvBkk=;
 b=LvpyUz1KLVjJEEsydJqwFJ6V2EgS1smTlA4VwfBXfsfrz3/h9LbzhAXp7FQsJkBlm/xqye0PCidGtFtDKylWMmriUX6BRqEfzzOfmUWgYQtJ2nyUFV2bX32yaXbhM4hffTu1fD5tu0j6u+HhjfR2zFW0uM6oUgnagra6DOo2IiU=
Received: from CH3P221CA0006.NAMP221.PROD.OUTLOOK.COM (2603:10b6:610:1e7::32)
 by SN7PR12MB7909.namprd12.prod.outlook.com (2603:10b6:806:340::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9632.14; Wed, 18 Feb
 2026 19:34:23 +0000
Received: from DM2PEPF00003FC3.namprd04.prod.outlook.com
 (2603:10b6:610:1e7:cafe::40) by CH3P221CA0006.outlook.office365.com
 (2603:10b6:610:1e7::32) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9632.15 via Frontend Transport; Wed,
 18 Feb 2026 19:34:23 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 DM2PEPF00003FC3.mail.protection.outlook.com (10.167.23.21) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9632.12 via Frontend Transport; Wed, 18 Feb 2026 19:34:23 +0000
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Wed, 18 Feb
 2026 13:34:22 -0600
Received: from p8.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Wed, 18 Feb 2026 13:34:22 -0600
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 1/6] drm/amdgpu/gfx7: align mqd settings with KFD
Date: Wed, 18 Feb 2026 14:34:11 -0500
Message-ID: <20260218193416.1474441-1-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.53.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM2PEPF00003FC3:EE_|SN7PR12MB7909:EE_
X-MS-Office365-Filtering-Correlation-Id: 9cd861b9-b3de-4f9a-e5ff-08de6f24b822
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|1800799024|36860700013|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?fUAHCBxmw6h41SIcwxMoxnJQ6oR0v9Q6nyXjWfBrOkZrGShd1Yes78X89cwV?=
 =?us-ascii?Q?NYLYg3wjFNYSAv4/fOF1o7PCBNXmCDlrrcmv1Usn8rPNVDSAOdrzRJOK6YoZ?=
 =?us-ascii?Q?ZgzYYbDdUTZf8iyIZ/wcghIBCwHXU/fIAGehI8vH9k5WtkfFAI69aYSeKgPW?=
 =?us-ascii?Q?03oThP8Fcj9o1vyhP7Aur4aBCXBgH8Pw4udOwaNOF1L8fk5cnstrDW/mE5ZZ?=
 =?us-ascii?Q?0rSxpRtlzOHWwwSlCryWcudGV1Vb5r8zjQ8PrxrO3xmJ0LQvhdnaxK/oQAmq?=
 =?us-ascii?Q?AvqUzG9QG+ZL3b6cLsVNIP5Gr06aGhlevRsM8P01193EwtW/NXZHpswOvXur?=
 =?us-ascii?Q?KHi5czxrVJESp9a3hhCEGWYuGbEf+oeViIQO8/xcUmqAkFPQflY7fd+FmPe7?=
 =?us-ascii?Q?cpYQ2gLM6/L3ylSwayLrjsVosS4Ejeok5flQmkDjqlk5x/6PbShoZnMp9tu9?=
 =?us-ascii?Q?TJLjeQa3eU/a3CT15LwcCLQMOecHgUVDWk1Xie9TtjLU2SZ0jDb5a7NRkR5V?=
 =?us-ascii?Q?JqkP0JxWD6EC2N3Lk6Duq0YRyTjFtTO+NPK+TWmuxPvCTBd26gZFF/oEE5tH?=
 =?us-ascii?Q?sQHC6qUR5mg44Tc9VAbjSnbYhznN1pxSp9f698Dci8Yhe2IbWVfxJoKSxv3h?=
 =?us-ascii?Q?UXvyFeNdHP0NyoYYkh0XAgOLuSDtXZZA0UW4JASD9sN7mZzW84xCUZkrFGb+?=
 =?us-ascii?Q?g/ce7ZOoRJKFUY6eKAtwZ2D3EEJk9nLHF/CdHhia0yI6+Ym5fS0Lok6X/Ved?=
 =?us-ascii?Q?F613qe1wQNAiVKOfYr6tRNwQI3sBVbCUWyVOzszXOBtUnKjWchCeJEtfNzcM?=
 =?us-ascii?Q?r7UJxgatZXxLh2aIOi+2NKNfWma6itJsu0Dh5S6D8JfBKSIHdl+0nmMIe6RS?=
 =?us-ascii?Q?5X1IIvGTo/EJxkwNlX5CMV8X4f0Opato+RCYWt1BLgnZPv13lQAIXBONhKpx?=
 =?us-ascii?Q?+pomOvSTDxBBZIQiO70Rnov4S1khBEHft8II+DMST21wwhR1gdkkFH/JnI8B?=
 =?us-ascii?Q?6G/Ye4+p9WA7YGW7NsfOwGQbA0O2oGBgQyXuqJfG+HL4NmSy8mnHeSZq6z0B?=
 =?us-ascii?Q?U6OO1BlHzR65UVpm/jkAQqY7UGXMGpiheChQpYqCw31gF9ViAfjRqu+8T1rC?=
 =?us-ascii?Q?fagrQoB1Sh8kX83TXf7z4e2cnMdBTImMnYjA4y9YC4+sWEQVe5rAvMImYek7?=
 =?us-ascii?Q?xnaRz8wqzvWhqiNP3T9rW38XebocWPXfAz1eeGX9QLxsUvNj1/9HXUqdcD00?=
 =?us-ascii?Q?J+1o7XmxvIS9++wjud2MvJi1rxszICgpR2UOy0Vd0ApRxPGzKIHz/3u4TV44?=
 =?us-ascii?Q?xiqvAY6Ot6AEoAbGqe6F/CEM/7Y+ZHzojJmfJ5mdndm+fPudTGXaIMPECIXQ?=
 =?us-ascii?Q?VCq6wWuDnB03yOuXI20OLXOVOwh6ADj7m+0FewOrzCVzDNVJg92Vrk8j/QP8?=
 =?us-ascii?Q?yGhfs5mTqD+aJ3Oxo1wZUaEmTMRjeX6NNXnvb0A/M9kU5YLBvXsjCwW73Xbf?=
 =?us-ascii?Q?sgsdvtJTLdRCAHfxoCHWsvzXE8LF2CRwzHSLzGgdVjgMjOXZ12Anh0jN9vO9?=
 =?us-ascii?Q?hqE55LKR5jQjIIUxwXO41aF9splTlbAmo8ETGbJeRNENFWnILTr2LXswkBdM?=
 =?us-ascii?Q?szhIF8aIqwVqmV/gJYXV3cC+odFgpKzWtxvCWzRL8R0hbBi6Hppz+QCsbTGl?=
 =?us-ascii?Q?thyZiw=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(1800799024)(36860700013)(376014); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 9cVGrKhmSKla0t1LuCVf4W//ZAXaVQEAY4w3EgslR3zQw7oYIwNtfFFY381faEsZSMFYekRJuzfyS9TVZkiceBpsp1Vg5jaOonOZ98Pebh5UGXLF2/UfTq9jtxHmSzI23muGAzCovsweD6mH2cEMTfwfW0OV0MjmynGFkf9xyJ9E6hxtVlccdNeSjkXv7vW/M+HYksekhNRJsTXQjAyHwE5HmixghRprTLnix/I8IAFwbhXT1dtdfHuSBKhay2P4VQUn0hayz93cJCxvJZWq3vdZu/EV+MWSj4MIg6CVDbZvAQuFNpjirEtTTsvSreNEeDK571XSPLnd9frgeuEsseKckPVDFLuPZmeXXno+RHHGS01ZmvMuPqzXyt24fmstyrg4yVdMGaeQPaYH8LOytQrMzADFHC2YTigiwq2BFinm7roS6fnEPQ76xJ11FSgG
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Feb 2026 19:34:23.1580 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9cd861b9-b3de-4f9a-e5ff-08de6f24b822
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM2PEPF00003FC3.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7909
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

Make sure to set the quantum bits in the compute MQD
for better fairness across queues of the same priority.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v7_0.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v7_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v7_0.c
index 2b691452775bc..65b8497ad5f02 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v7_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v7_0.c
@@ -2819,6 +2819,7 @@ static void gfx_v7_0_mqd_init(struct amdgpu_device *adev,
 {
 	u64 hqd_gpu_addr;
 	u64 wb_gpu_addr;
+	u32 tmp;
 
 	/* init the mqd struct */
 	memset(mqd, 0, sizeof(struct cik_mqd));
@@ -2923,7 +2924,11 @@ static void gfx_v7_0_mqd_init(struct amdgpu_device *adev,
 	mqd->cp_hqd_atomic1_preop_lo = RREG32(mmCP_HQD_ATOMIC1_PREOP_LO);
 	mqd->cp_hqd_atomic1_preop_hi = RREG32(mmCP_HQD_ATOMIC1_PREOP_HI);
 	mqd->cp_hqd_pq_rptr = RREG32(mmCP_HQD_PQ_RPTR);
-	mqd->cp_hqd_quantum = RREG32(mmCP_HQD_QUANTUM);
+	tmp = RREG32(mmCP_HQD_QUANTUM);
+	tmp = REG_SET_FIELD(tmp, CP_HQD_QUANTUM, QUANTUM_EN, 1);
+	tmp = REG_SET_FIELD(tmp, CP_HQD_QUANTUM, QUANTUM_SCALE, 1);
+	tmp = REG_SET_FIELD(tmp, CP_HQD_QUANTUM, QUANTUM_DURATION, 10);
+	mqd->cp_hqd_quantum = tmp;
 	mqd->cp_hqd_pipe_priority = RREG32(mmCP_HQD_PIPE_PRIORITY);
 	mqd->cp_hqd_queue_priority = RREG32(mmCP_HQD_QUEUE_PRIORITY);
 	mqd->cp_hqd_iq_rptr = RREG32(mmCP_HQD_IQ_RPTR);
-- 
2.53.0

