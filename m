Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 54DAFC282EC
	for <amd-gfx@archiver.kernel.org>; Mon, 17 Mar 2025 04:31:11 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0A5EB10E05B;
	Mon, 17 Mar 2025 04:31:05 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="TGOEkUG6";
	dkim-atps=neutral
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2086.outbound.protection.outlook.com [40.107.243.86])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3625F10E05B
 for <amd-gfx@lists.freedesktop.org>; Mon, 17 Mar 2025 04:31:00 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TwZGjtBu4PY61ukFLUqjH+KxKxVofOl1lN/aq/GaZTTI3dVoWP9rxV3lY9N6YSLCLBAo4f/KuUtn3V+1NDCEMueLJCZ11/U/73U2sLhY+zUPIywrgDMrROxWmez2Gruu4Eo/lkrOMiKxhnB6IXXmd3jDyqa/TmpnYSckYkB1d/p+1fGDzed3PrGtRQB0lyjTa2b0H8Jga9etHY5gPTbNgxzqr0VtdY/+Etrin7+/ZK8gRBvbzjSor4IrCdE1IUjqOukwiQeeKye3JLrhX/6e5Ur/Dbr4GA4GiPq66e4okBNRUkTuEO2xJBrglpQjDpZaftilzq1yUjJmvMwbnZLhaw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0rX57bVbUJTCrtH6nBO038RkhtxCXxDGOadeVb9yhSI=;
 b=IV93ZjR30bTt2TkryL3FQel/oVQdZw83BjVc7UhXLMnVDtDL9+Epo/s/cDMbXkq6LcI1fA+YbWJoJeujTMGKrfWEBSxFJLT5mhX6sypALK82hlyDNZpUBTT4yJvA48iA3p6ff/Mw03VdbO4svkHrtN3oj56AMOEG5Vjy61qTyJwzo5x1PLKqxovsC+CyIxJS//g+9+ZJEg+u+A+tNA1OO3lapfSnloyUUUGn5f3nm4cepAzzXMUjQpHLMSt/UzeMGPxbR8McF7UBN/p5MmEF3Ezd2f48CixTEnrhihumnN4dL4RZ7sza0a9fHKmsWWqanquvrTIg3f4sPXp0FT7bwA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0rX57bVbUJTCrtH6nBO038RkhtxCXxDGOadeVb9yhSI=;
 b=TGOEkUG6rO6nR2pd73Kf6fo/6m0AlcwtZnN6zTglyBldfUI869Q9gIUr3s/yg1HDoGC/jmEynKv9ecFGKSqiTF75Cy/L3rnYpt2XXI6DjVWz0iFMbftNEQ9y082t0gllF6c8kKVDwerIk7ht2er6Rn32mmkyJnM3KXFcsyRDt5U=
Received: from MW4PR03CA0015.namprd03.prod.outlook.com (2603:10b6:303:8f::20)
 by DM4PR12MB5770.namprd12.prod.outlook.com (2603:10b6:8:61::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.33; Mon, 17 Mar
 2025 04:30:50 +0000
Received: from CO1PEPF000066E9.namprd05.prod.outlook.com
 (2603:10b6:303:8f:cafe::42) by MW4PR03CA0015.outlook.office365.com
 (2603:10b6:303:8f::20) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8534.32 via Frontend Transport; Mon,
 17 Mar 2025 04:30:50 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1PEPF000066E9.mail.protection.outlook.com (10.167.249.11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8534.20 via Frontend Transport; Mon, 17 Mar 2025 04:30:49 +0000
Received: from asrock-1e715-b03-3.mkm.dcgpu (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Sun, 16 Mar 2025 23:30:48 -0500
From: Ahmad Rehman <ahrehman@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Ahmad Rehman <ahrehman@amd.com>
Subject: [PATCH] drm/amdgpu: Add support to load PSP TA v13.0.12 for SRIOV
Date: Mon, 17 Mar 2025 00:30:37 -0400
Message-ID: <20250317043037.1131095-1-ahrehman@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000066E9:EE_|DM4PR12MB5770:EE_
X-MS-Office365-Filtering-Correlation-Id: d4cac0f3-8f0f-43a5-2251-08dd650c7ec7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|82310400026|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?trqPNI5KFIUGSi1uBYsBe4B2EjaoPFh91LbpMinoM7aBZPSxg89hPm7xJ20T?=
 =?us-ascii?Q?+PdTSScO/+jg9YJFI/XV/nZU0RWMQNOFuejXJEOygC06Sma1WhVN9OY3HnoN?=
 =?us-ascii?Q?6uVB+dbAvViVw9VYjCvInIVjRyY7a/Utd8BFGSfHuLoacwdDHwQ3VntHBzj6?=
 =?us-ascii?Q?MMD6yU7UsZsndrw/1eoGh5d8CQEgnwcumJfxx8vhrFz0robb+IqQff8nQfYq?=
 =?us-ascii?Q?18XfFsjGDbGjrL3ctL61PwIKjjAohDYAPH2B+XHd+Pp/lXI/N8bvOkYmoRmq?=
 =?us-ascii?Q?5DIJpPoQbJYK01DSkWLuN7XnWxRLbWGZdevCoiqyCvufrPEwjycOnAQd5ELR?=
 =?us-ascii?Q?tY98xGGSjcXxRnrT+N2JrnFT/faRHmINmUnKcskjq65oLV0wZz0pQxVbxu/0?=
 =?us-ascii?Q?HGqjAfPds9cekOn8b/j2dL5KOO5beElkOI3fhIHDS/ZnNRdznc2YpvrjCIIO?=
 =?us-ascii?Q?x25Ph3JNxThfTT1hiF5j+AbBS7nt4N8zjv9Rx3dD1LMBXsRNZ4+59NmEHLnA?=
 =?us-ascii?Q?php0wLmskDdBMSocO+pfliV8wTBb4cKlf7vitSnz3x0p+3OAT9t2/2pxyIwO?=
 =?us-ascii?Q?kC8gjHRQb2HecE9ZJlPFzzNUodLCzKiPDoupNvFimf8QnSNsxAWB/Zg7v+KC?=
 =?us-ascii?Q?X83tC/5RFoMENPUsrqYY+OJyiJhs/JJ0mVj41w0yOm8MaudHE5inYQzDPjBu?=
 =?us-ascii?Q?OKMu1pgdjRnSY/6VUn+75TxS02hxt1i134hcQX7j2OI8cKVBwq7NWpuXkJrI?=
 =?us-ascii?Q?dlJQo6u8UjClJQRDCQAIQH0Lrkd26Q5JJHYaJ/vCRO+uhkA8hUcCzkyG0eg/?=
 =?us-ascii?Q?YVkXLiA4MPd/bMq7VOfio64WDDx4pnA2Z/Mim2qky3KhOF3TEAFm8fct/jrv?=
 =?us-ascii?Q?vt1N7s8mkolkOqjWbwn0SHyeU7HNsbgSJqGFdBOOvzW+Z7yd26NG0ERWl8nV?=
 =?us-ascii?Q?5geTW0jFlasSvQ5wqhKMRnedbJAIaslHmnhpMgDsFvzMfiaynmOW4Qzx2MgV?=
 =?us-ascii?Q?9Elk8/g6uVisxD3rHwkyDTu3buA5nB8P1bIY/pLNGrc6flqML57ObfggNXYO?=
 =?us-ascii?Q?39LOEUrzEzJM0ptQ30vT6gwOv+fMNfk+/exm0pPNf1lIg8Zh4mkJhAIBmlby?=
 =?us-ascii?Q?06Vgp+JBzO04NOoqJlEyvBkBw/+luAj4zR0SuuB275pQGnG8OSc+WQqukqYK?=
 =?us-ascii?Q?rBYS8AFTgbL18SXOltpskGWIawTtJnWCotNG/sE+mQE+sWxf331rgwdJccxP?=
 =?us-ascii?Q?RLMH4a8Rur9913v1ECP5V3IncysejbyfCv6aPtpJoJMbk1oEE4qOqi3gk/k6?=
 =?us-ascii?Q?zKwxklI7ExCrorz4evsCDKYt1uMCqfwHYheWYEXuCVVuiZpu0TeJtb6/fNcm?=
 =?us-ascii?Q?Vo8Kfm59C8c4Nyz0L9icLzJBgDeJuNyXaJ65Ni1iAtxJdctYiX6pBSmPYUtU?=
 =?us-ascii?Q?UrQPcXqR0vtgunQ1/ADtuGy7QNNQ+l9MCcD2/9U8bZ9UT8RMQK5pcYuc89U0?=
 =?us-ascii?Q?M5UiWFIqlt3sx6s=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(82310400026)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Mar 2025 04:30:49.5908 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d4cac0f3-8f0f-43a5-2251-08dd650c7ec7
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000066E9.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5770
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

Signed-off-by: Ahmad Rehman <ahrehman@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
index 79dad75bd0e7..04a186d0c236 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
@@ -153,6 +153,9 @@ static int psp_init_sriov_microcode(struct psp_context *psp)
 		adev->virt.autoload_ucode_id = AMDGPU_UCODE_ID_CP_MES1_DATA;
 		ret = psp_init_cap_microcode(psp, ucode_prefix);
 		break;
+	case IP_VERSION(13, 0, 12):
+		ret = psp_init_ta_microcode(psp, ucode_prefix);
+		break;
 	default:
 		return -EINVAL;
 	}
-- 
2.34.1

