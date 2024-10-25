Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 313E4D11704
	for <amd-gfx@archiver.kernel.org>; Fri, 25 Oct 2024 07:19:43 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B0E8810E2AC;
	Fri, 25 Oct 2024 07:19:42 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="ONC3c1j0";
	dkim-atps=neutral
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2062.outbound.protection.outlook.com [40.107.94.62])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C3A2A10E2AC
 for <amd-gfx@lists.freedesktop.org>; Fri, 25 Oct 2024 07:19:40 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=q/xU9fgKzLRKfPRW8LxrVPtbcDLKTHkPleG1e8XuRBz/A7QlHOzLGTN3B1wCTRDGnanHDozm3eGUIdU2FMrss7E1Yhd2dQ9P0nwZ4o78vPBi1IeaD76z+u29jcY6Ed4IElU78on0ioGBuecVqVWbTihtyGR9b5GlBKWbIIpBWDiUIhco7Uco6u8YAp4GasiQ0PRE02u1aIry+2kM3+6OfwkVdbXy6wJBfcP67xirmKszHb+B2eAq5qGjjzGLwIiYB+4ZtQtwt7jsZpATJLPepT7OvY3bZ3rkdd9jdVgSLBg6sVQdpp8d/Ak+zpz4lJGKfprSRV8SsLfBmDOaO0U49w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pe3US6nHk1VkDwpY5gjyND0Fa5NsabZwNY/2j5fzjCE=;
 b=j3it9B4MpAh+WU+fg92q84Q0agNQUbWYkTXliBXVdu+bds5nz5lc6SFx/XWh4NdNeUjEVFDHH8cIoOmQNrNh+EJQ+SYgGi9pzkajkaEOGPnWrBtNnF6E5ZJyftCNRkqYZjE5IJK8RWKzEkXjLq2jkzxuX38GUFrpsAbpIvGb/g8bD2YFcu6g0pK3o5a77SHr8VyO7ABTDrZvcOHsAlcT0OELbVHgmtlEA3K0nL/Ytdo4ZSitCFwP06CCpmmFMx1LR3Ow6HcYhsyudcsttih0ckf5X2BmmZbicF/1xXKSK2dQ63iWDVX7nZ3LulBB17Ydd49Z098wEPSI2uIiFGaFQw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pe3US6nHk1VkDwpY5gjyND0Fa5NsabZwNY/2j5fzjCE=;
 b=ONC3c1j0us4y2xFOR+Cr2Bvb/l67Bw6n3pILyEj0PG+7MUiWIG1A+eVFKvTDz1y2GSuI8LEj2bGYdGcHu4SPFhlz7DDF1xfx+7/eHuhendZ1Z31HLB3Y1gl6CgEQYqvbZ4zkIyWt3Qr8DI2SjObE6kF4nNo0/M0fS58sClmEL8k=
Received: from BY5PR04CA0006.namprd04.prod.outlook.com (2603:10b6:a03:1d0::16)
 by DS7PR12MB6118.namprd12.prod.outlook.com (2603:10b6:8:9a::5) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8093.18; Fri, 25 Oct 2024 07:19:35 +0000
Received: from SJ5PEPF000001D2.namprd05.prod.outlook.com
 (2603:10b6:a03:1d0:cafe::32) by BY5PR04CA0006.outlook.office365.com
 (2603:10b6:a03:1d0::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.20 via Frontend
 Transport; Fri, 25 Oct 2024 07:19:35 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ5PEPF000001D2.mail.protection.outlook.com (10.167.242.54) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8093.14 via Frontend Transport; Fri, 25 Oct 2024 07:19:34 +0000
Received: from kevin-mlse-vm.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 25 Oct
 2024 02:19:32 -0500
From: Yang Wang <kevinyang.wang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <hawking.zhang@amd.com>, <tao.zhou1@amd.com>
Subject: [PATCH] drm/amdgpu: optimize ACA log print
Date: Fri, 25 Oct 2024 15:19:22 +0800
Message-ID: <20241025071922.95979-1-kevinyang.wang@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001D2:EE_|DS7PR12MB6118:EE_
X-MS-Office365-Filtering-Correlation-Id: e860af56-83ff-4889-de99-08dcf4c56081
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|36860700013|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?re7eybUAjLOtbLbQPgfoTQ2+lE3PU8Ao3/Q9p39q7NyWBk5LUyEQeOWPPNf8?=
 =?us-ascii?Q?QOlhWw6FLkzY337o2XSaxpjGeERNJe5FFaUP8T1d0Ij8Igh06fKxTNGK0VGr?=
 =?us-ascii?Q?hD9wnRHO5MIYHNJdlqfTb76XESMSj1dUie+D7R62cPdpa7weyYMr5DFXIJ99?=
 =?us-ascii?Q?5y/GZkZ9ptHVonV5n6Xb2oLu3Ak/X0SCILWX/9kGhj/3zx4+DCBAE/1jTpUD?=
 =?us-ascii?Q?Ifp4oCJOhFZP4y9ck6DNqKYEmLF1R8d+qHpdrsidl80/PN50s7rbDqr1GGFn?=
 =?us-ascii?Q?duA+kcUnsYRaczCKzkAzuK8JS2NYl4OkBelxyfZ9Zz/zStUFIXmTGjOF8+hy?=
 =?us-ascii?Q?oF6D+OewUeSvrvCMn06fn94eiHpMRXCl7Rwr+/Bw/Kd8FyrnRh1qJ9ZbtwFH?=
 =?us-ascii?Q?4mP6Sdnv+b2gJUXPO18jf59Zl0m8PPXSV0DEbk5aSoA+uFFoOq9OXEKYObK+?=
 =?us-ascii?Q?w8Hm8dw9JRS+AzpGj+5nnFdgSwNyQmyIxtwnZ9/5vcJn3kip9Y1neH6ecfhH?=
 =?us-ascii?Q?CmkZ4xmu8+aK3aJnR/9o41vVyXkDiD9Ah1wFaIZ0m55Z6MXTtjPa5vsg9E/o?=
 =?us-ascii?Q?qd9wL/i2/uDduLUdZeiyyc7sTPL8S34MPTUgONJAOQKcOvlSHUsDFCYIjfRX?=
 =?us-ascii?Q?Hr6f2E8yQoEU7A7YkHzF4Qjh5abBjl1UpZ+nF/cv9R+62ufpmwCQvGxxrfUB?=
 =?us-ascii?Q?wLXI2kgHlrzZiunIOhbO0CHdTyjPN5KEupabsA5/2K2ZDuRviPzD+MKGtR2o?=
 =?us-ascii?Q?6I7VDFXGeu+T+CUjXJ3EXSpuYFWigzmB4086A66H6l5Ya3Dpnby9b/2qXvaw?=
 =?us-ascii?Q?t5pLepv3JkxvylMP4K5Rbb75f5PnxQc/PdFh2+RTnUtN+vLb9U9j2Da443bB?=
 =?us-ascii?Q?nxDMrj3n4WleYy2lk5zY4rDiXXCrOBraZka6lCoyzHrK3Esy6zPr2vjYZpOB?=
 =?us-ascii?Q?lW9S77YKFvRvJK8ub8vzlxtoBnsGWtrE+W4rq9ooBt6tisUj7GbajTtQIa9B?=
 =?us-ascii?Q?4fBdWb6+pPyl6k/N3knsmV7mD/XrDA77Tw4Rlo9x5Yv0bUaLd4TU2YTe2vkz?=
 =?us-ascii?Q?HVYtYuKr6WJTNHiemV7n7rz9lQyaq1+asdbCwQL32eglAWZYvuxeLA9IG1j3?=
 =?us-ascii?Q?RX94ct93NK95X25spvGXVXihEpiGjQehJwkDr9cWKmUqITRVIo9/ZDk8frxc?=
 =?us-ascii?Q?jLDOjtsTzjxOBe9On0HcIlWIaixrXzhh5bn04TMKWr+N8d+H02cMC6FSOyfF?=
 =?us-ascii?Q?e3Gx0WLO0Eck6gZKa9rXbmXUDfVgjAmRohgZrYSyG/XSRwfW4eNAuxaGG00D?=
 =?us-ascii?Q?+NDWHgrWg881PAuBFla6LEpyHc7b3RFFxAzx/HZ34HVn8/qf2/G/gnC71enj?=
 =?us-ascii?Q?/MeCYuw7JSuZsKaKJdSw+VU1DdxQMYtfx4LHqBrTKdcEuEeP4g=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(36860700013)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Oct 2024 07:19:34.3220 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e860af56-83ff-4889-de99-08dcf4c56081
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ5PEPF000001D2.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB6118
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

- skip to print CE ACA log.
- optimize ACA log print for MCA.

Signed-off-by: Yang Wang <kevinyang.wang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_mca.c | 21 ++++++++++++++++++++-
 1 file changed, 20 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_mca.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_mca.c
index 18ee60378727..3ca03b5e0f91 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_mca.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_mca.c
@@ -348,6 +348,24 @@ static bool amdgpu_mca_bank_should_update(struct amdgpu_device *adev, enum amdgp
 	return ret;
 }
 
+static bool amdgpu_mca_bank_should_dump(struct amdgpu_device *adev, enum amdgpu_mca_error_type type,
+					struct mca_bank_entry *entry)
+{
+	bool ret;
+
+	switch (type) {
+	case AMDGPU_MCA_ERROR_TYPE_CE:
+		ret = amdgpu_mca_is_deferred_error(adev, entry->regs[MCA_REG_IDX_STATUS]);
+		break;
+	case AMDGPU_MCA_ERROR_TYPE_UE:
+	default:
+		ret = true;
+		break;
+	}
+
+	return ret;
+}
+
 static int amdgpu_mca_smu_get_mca_set(struct amdgpu_device *adev, enum amdgpu_mca_error_type type, struct mca_bank_set *mca_set,
 				      struct ras_query_context *qctx)
 {
@@ -373,7 +391,8 @@ static int amdgpu_mca_smu_get_mca_set(struct amdgpu_device *adev, enum amdgpu_mc
 
 		amdgpu_mca_bank_set_add_entry(mca_set, &entry);
 
-		amdgpu_mca_smu_mca_bank_dump(adev, i, &entry, qctx);
+		if (amdgpu_mca_bank_should_dump(adev, type, &entry))
+			amdgpu_mca_smu_mca_bank_dump(adev, i, &entry, qctx);
 	}
 
 	return 0;
-- 
2.34.1

