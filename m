Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CAC64C624A4
	for <amd-gfx@archiver.kernel.org>; Mon, 31 Aug 2026 05:25:32 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 330FA10E5DD;
	Mon, 31 Aug 2026 05:25:32 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="yLHtG+m2";
	dkim-atps=neutral
Received: from SN4PR2101CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11012057.outbound.protection.outlook.com
 [40.93.195.57])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 25E5F10E5DC
 for <amd-gfx@lists.freedesktop.org>; Mon, 31 Aug 2026 05:25:29 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=X24I6lg+8W2cwT4uGq7DcPaJFYd4+FIA2t4cuAJ7OUhEwd8WKSJiPuApJsj7YWJiXJrquG5ZLaBgJoaMRH6FzpD1CilVJtSMs/6SuURYvq7/8TgsMN3exq50OvI/PFW5w+aArxOcGWm7j7jGhK+ozshFr+ObrXR+UKgj+Ahyoi5Ji0PHxUF47ExhWDoTqj6Po/KRVyHeF0JQyM82bG3wCowRdyaFB2WLzvJBZJSEqrgSCJdoxATxtyg28izyW/nNfeZgaRWACCnMM5hmwOH2eKmtFQXYbbyVujlvnHTgzPoDSKbOMp5AdC+5d4IB7ewERzbJoI8xDNQdD257vUFA4Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nDGq1NOG2OfXkLu4aLV8myw9xxWH12227CjTUtQuU0A=;
 b=PwR6ul4DX9/D4FFTXljsEn4qHS4eL4OEDzgUQPWTSGcWskElS/Osfp5hD85tUL4zENVoWdzIpHt24Byg5+fSeQicZk360b49rI9J72d/A2HHsG/sdZt2srBkzdQfLNpilPz7oMzXrJ1BqTJIY2qKtym3yTB2kfc1xUVDxVA87sAw3COnqZmbYp6Gx9zCteErP7qTOqCz2Dx52cqFQem/lNIFenNHdpkciSNW49sQhkRwxFpoQDLNidLbzBQjayJeAguHFRYL/HfEgFaHuCZ3sBq88jcnwfbs+nSgJsnRWaAsEa3j/jHSrogzAGVBTZukU38/V/umjRpIqTzdBMzAVw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nDGq1NOG2OfXkLu4aLV8myw9xxWH12227CjTUtQuU0A=;
 b=yLHtG+m2Kn43iW/J43x95F0fmtp2WYttVtfbQx7qCdznhCKi44uaPPcFBisId7cNR+4Ve5Qtssbwoq1BIntvLOXuVGy5HV7QsS7b7ujaTQX8M/JYcC6oCke39P62jB+ESjNgP9MM4cEIJtJjior+yvrx9RyKcaGlKoNJ+60/C8c=
Received: from BN9PR03CA0503.namprd03.prod.outlook.com (2603:10b6:408:130::28)
 by DS0PR12MB6584.namprd12.prod.outlook.com (2603:10b6:8:d0::6) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.360.13; Mon, 31 Aug 2026 05:25:25 +0000
Received: from BN2PEPF0000A890.namprd04.prod.outlook.com
 (2603:10b6:408:130:cafe::6f) by BN9PR03CA0503.outlook.office365.com
 (2603:10b6:408:130::28) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.360.13 via Frontend Transport; Mon,
 31 Aug 2026 05:25:24 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN2PEPF0000A890.mail.protection.outlook.com (10.167.248.182) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.382.8 via Frontend Transport; Mon, 31 Aug 2026 05:25:24 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.46; Mon, 31 Aug
 2026 00:25:24 -0500
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.46; Mon, 31 Aug
 2026 00:25:23 -0500
Received: from JesseDEV.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.46 via Frontend
 Transport; Mon, 31 Aug 2026 00:25:22 -0500
From: Jesse Zhang <Jesse.Zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, Christian Koenig <christian.koenig@amd.com>, 
 Jesse Zhang <Jesse.Zhang@amd.com>
Subject: [PATCH V3 06/10] drm/amdgpu/sdma7: honor mqd_prop modify flag in
 init_mqd
Date: Mon, 31 Aug 2026 13:24:18 +0800
Message-ID: <20260831052513.1518180-6-Jesse.Zhang@amd.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20260831052513.1518180-1-Jesse.Zhang@amd.com>
References: <20260831052513.1518180-1-Jesse.Zhang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF0000A890:EE_|DS0PR12MB6584:EE_
X-MS-Office365-Filtering-Correlation-Id: 02fcea31-9b48-4cfb-818e-08df0720426d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|82310400026|36860700016|1800799024|23010399003|10067099003|6133799003|18002099003|22082099003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info: 287ngbhzJdxq/Ln929AxD3m5h04iNHPXRm6dNU+lnGI35YQr4C8IVg/oKmwqOhd668iRi3jzpusrDdzfpx0P8+CkOuJzymsTreic2wt31L1WcpYJFK843HgCJNxwr5dmx2EQAigWKd1HOGgcj1vm0TzSqaVg0JanFWt40p31wHVwe24+GtuhrW3U8lNN4N8Kz8rsjnGbxJIFnIICpZ0r0o23e99lqkqBDF8Dq7/xW7n8lLCfNmtfQuw6CaEqhceBCTAMTc6j2VJSE4IHxA0YFHqFCDYiVAcQYzUFmuQwSJMvM0BMs989a8OHvBX9teAKMB71F72r64Qadr1rDRcv7Vpvk6ai/t369spu1wXtyTvt+RsX8gQo7pQTJxr4RccoqHU+cuz3zrQteAYox0YGE/ZRSt1nU/q1Vkd+SrKVpz6AtaKKW8TL454BLKppE8fjpLgSgI5VHzdIVV20xb2lxNfg8F2LpKvluDZNSG1Bte6cCY2Jsxkx5NkolSo40U0P8VALeet9LhbBLSB8IPrfxa+GkCgrihJEZ/Y2G0uq9Dmq43eyCHKMVK5Tnz6MqUBBtIorFqG4ps0oEGQaiExr7XA8JP9LHt49on4t6rHEz/TWSicFloJGFkhwSekZdXxnM2bJQLIKRePrDXTZGouhdf9qhLMsigj6P4EJpM4Ti590fMA2fm/Rf1FDhBp+guKi2Bxm/pdNNcKNZY6H8vZBSg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(82310400026)(36860700016)(1800799024)(23010399003)(10067099003)(6133799003)(18002099003)(22082099003)(11063799006)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: vkKnSKBNc+i9uhfszdgndrgXBlIflxgRtR3rkbvK65AAsb/MoczjzCxGGKqi0bOss8id70SVDHh0Pjo9kwNmStaEuOug4EBfv2gHXGKDcKDE/oDhurt7/DrM9NuCcHVkASpmMeN+hTafku8EOUeW8rZDrz6a5gemcaXtS2wJebMmREYvjhgq631MsmExxlpkx15ZIxbveyLWCofamxdNPxJq4gvXTE70ccvAelsWRVynvkYaIuy6HI//ABAIJkd9/ionzos/awAU7EhbmPoNLUYb+5bRx9GLM6bwzgmzVus72bF8XtCilPsU/LCVzmnmcbbs6WR6K8SH2MwslSQ4ER22CkS2PaMoMBeHxJIYc3wa3eOALYCUaamEEbM/sEPOgw3lnIJv4hI0QpcfKqVwPQnpyhxDkbeu8Hg4Pi1jcdkD+ZcTIYyFZ9BA4/vcsDmX
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Aug 2026 05:25:24.4305 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 02fcea31-9b48-4cfb-818e-08df0720426d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN2PEPF0000A890.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB6584
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

On a queue MODIFY (prop->modify) sdma7 init_mqd keeps the context-saved
rptr and uses prop->user_wptr as the wptr, so a re-enabled queue resumes
at the first un-consumed packet. It also forces IB_ENABLE back on, since
ib_cntl reads back IB_ENABLE=0 on a stopped queue.

v3: consume the mqd_prop modify flag inside init_mqd instead of adding a
    separate sdma7 update_mqd callback, per review.

Signed-off-by: Jesse Zhang <Jesse.Zhang@amd.com>
Suggested-by: Alexander Deucher <Alexander.Deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/sdma_v7_0.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v7_0.c b/drivers/gpu/drm/amd/amdgpu/sdma_v7_0.c
index 2068e2e6e3d6..843318158ddc 100644
--- a/drivers/gpu/drm/amd/amdgpu/sdma_v7_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/sdma_v7_0.c
@@ -902,6 +902,15 @@ static int sdma_v7_0_mqd_init(struct amdgpu_device *adev, void *mqd,
 	m->sdmax_rlcx_mcu_dbg0 = lower_32_bits(prop->fence_address);
 	m->sdmax_rlcx_mcu_dbg1 = upper_32_bits(prop->fence_address);
 
+	if (prop->modify) {
+		/* MODIFY: keep the context-saved rptr, use the live user wptr */
+		m->sdmax_rlcx_rb_wptr = lower_32_bits(prop->user_wptr);
+		m->sdmax_rlcx_rb_wptr_hi = upper_32_bits(prop->user_wptr);
+
+		/* ib_cntl read back IB_ENABLE=0 on the stopped queue; force it on */
+		m->sdmax_rlcx_ib_cntl |= SDMA0_QUEUE0_IB_CNTL__IB_ENABLE_MASK;
+	}
+
 	return 0;
 }
 
-- 
2.49.0

