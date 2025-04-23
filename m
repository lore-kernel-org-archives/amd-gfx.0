Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BBFB3C369CB
	for <amd-gfx@archiver.kernel.org>; Wed, 23 Apr 2025 10:49:05 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4186A10E21A;
	Wed, 23 Apr 2025 10:49:01 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="hkggQ3OH";
	dkim-atps=neutral
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2061.outbound.protection.outlook.com [40.107.92.61])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CEC7D10E21A
 for <amd-gfx@lists.freedesktop.org>; Wed, 23 Apr 2025 10:48:59 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=giSKpgkcRQRMq6WCYZ0FS3tOPx86CzBNGEqtmfyLFC3oLgVCKFbZYUz1leN2UwyAVPZz0yKlSoBzpSaA+GWHHBEi04oLuG4G3JlRCHI3BlQimCVKQm0ZETMX+okPvt5GEmpuJ74h3PpT8LWu6FNw577aeMBUGf9CS+wIgk+zExE+8K9omZMp8OlkO03gpqtRcqWy6qp2jzXWI1oaW+PbfpK/fVY+Fr4WIpctACcrarHReSXlXhESLjlfRvCwz9h+t+SYWoVjZbrQXfs1i5wxZsfsNa14JwXNRWX9/3XFOEM5bOZsSgfYVXVemb6X4F1WbwVkFSE3ik5bkXWlPA64Kw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=U/jOhkxzFeGIU0Ig8GYrdOUXw9EE06lNleAxjGqR2BY=;
 b=DKjf08e2lYWcXvwoH29UF/CTaosC3WCHyHOTZcFxoXop4QQWz6JoUQBNjfjNfSHBGi/iUYfi6pBCq+l6ahwHySBjWO53OGuT+Xwx48NwmfJ6r9/LDOuHremkUHikIobONmffvkyPOEHQInytNiBCdYiXVHSS7Jw7W1hOAR/bFTekVRShBfxwrbhiM+3nzujJD9gMoLBoRs7BCgI1DK0p9MtcFAnLGdAaD9accC3vXAL1lLVt5knlgiox2OOMBGs17ZNHk3vmpLkW1HxLGtSl8Ak4I8vXAommqpfqa4AmfXqu0hSqtkfMIC29N3v6tV/FrP9Sj7/l3z3PKlt6TNvREw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=U/jOhkxzFeGIU0Ig8GYrdOUXw9EE06lNleAxjGqR2BY=;
 b=hkggQ3OHJ1KedncXIv8ujmW8mFlB8CunmEYtta3SEo2ShdGLbQD9kFhs1r5h6swIww+c5DTxxXIRWg6QzCm9JBdQeZ0CvNkFCUNoJKGmiUzY3bNFlCpr5x6uLfFXu976xN7R8TjKfIahi8hCJ5dmMKcLUyIRXRr0/Wnx0HK+K/M=
Received: from BY3PR05CA0031.namprd05.prod.outlook.com (2603:10b6:a03:39b::6)
 by SN7PR12MB7299.namprd12.prod.outlook.com (2603:10b6:806:2af::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8678.23; Wed, 23 Apr
 2025 10:48:55 +0000
Received: from SJ5PEPF000001F7.namprd05.prod.outlook.com
 (2603:10b6:a03:39b:cafe::75) by BY3PR05CA0031.outlook.office365.com
 (2603:10b6:a03:39b::6) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8678.13 via Frontend Transport; Wed,
 23 Apr 2025 10:48:55 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ5PEPF000001F7.mail.protection.outlook.com (10.167.242.75) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8655.12 via Frontend Transport; Wed, 23 Apr 2025 10:48:54 +0000
Received: from rtg-System-Product-Name.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Wed, 23 Apr 2025 05:48:51 -0500
From: Arvind Yadav <Arvind.Yadav@amd.com>
To: <Christian.Koenig@amd.com>, <alexander.deucher@amd.com>,
 <sunil.khatri@amd.com>, <Arunpravin.PaneerSelvam@amd.com>
CC: <amd-gfx@lists.freedesktop.org>, Arvind Yadav <Arvind.Yadav@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>, Arvind Yadav
 <arvind.yadav@amd.com>
Subject: [PATCH v2] drm/amdgpu: only keep most recent fence for each context
Date: Wed, 23 Apr 2025 16:18:24 +0530
Message-ID: <20250423104824.7014-1-Arvind.Yadav@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001F7:EE_|SN7PR12MB7299:EE_
X-MS-Office365-Filtering-Correlation-Id: 40c58f8d-9a7d-4d70-7c22-08dd8254717e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|376014|82310400026|1800799024; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?bU81NGNMWmFxbDBKRjEyY2dmb1ZkcVByMWdYc0FodW02V0pFSGt3bXJHK05I?=
 =?utf-8?B?QXJkTmtRaEhsb3Bkd2xMOWh1V20vbHErTXR4MGZnVDJLVyt3SDM1a2txK3JQ?=
 =?utf-8?B?ZEQwY01YSzg0bFNqVmxHQWN1eUlqYjVZNnhKUGdSTzc4QjRudEw4bENJWW9p?=
 =?utf-8?B?T2V0V0VaSDI4L3dLalRQNFhXT1poLy84UitpOXc5cjVtVWFpNzNGVWltVk0v?=
 =?utf-8?B?ODRPRW1QU0RJUDBxNFozeFVPWmlXQU52ZG54MzNiaDJqd0N6Q2hzM1lyYTRR?=
 =?utf-8?B?eE1kb095cXJFeEV4UUxEUC82WllhZ1FUVFlqWTdzYkRHelhaVnBrMHRaMWd0?=
 =?utf-8?B?RGtuRHUxZlp6MzhiSVFxK3c0M2ZFc0xSekRVazdWR2ZIdVJrbDlnNGozQXRz?=
 =?utf-8?B?bHB4Q0tUY0lacjJyMHdBeWhhWTcyUDVRcVQxNld1NkhNbjQxM1YxbTdHQ1Vi?=
 =?utf-8?B?WkFocXBqbDdabkt4ZFQrQjcveGtLMXVYUkwxRHE2QzBMQTNhSEdqck9OM091?=
 =?utf-8?B?MzBhUEd2L2FaS2Rwa09nYlUraVpyRkZPUkdmanFadEh0Z0w0V2RZVVNNdUZt?=
 =?utf-8?B?bTVLNDlDaGJNd0VOTUxxcWpYSkdnTDdCVmpBSzVENHo2eXhxelM1MmlPblBt?=
 =?utf-8?B?SnNYRzMwdkNjWnpIekxoZ1FzcHU0dmVMTGw3M1MxS1lkSFlwK3F4d3Z0Q3Va?=
 =?utf-8?B?aGVzODJuYTY1U3h6eEhrcy9QSFFLQnROaXcxc3dvSVhWRlJCby8rRktmWjFN?=
 =?utf-8?B?aXY1SlJtY0g3L3hvbk40dWV2a2ZkSGxhVHNxbmc0NVM3UFBTTEk0Wjc5dVJq?=
 =?utf-8?B?eW1KT0lYeUxIQUZxdUZYb0s4dDJWYU1tUGhsU21GM1JVOTNvdDc0eFB5cGxH?=
 =?utf-8?B?SThLTHVhcEh1Yk5YMmhkRjdKdkp5eUFtTkN5d1lLYUpqSmYzbzVJNWgyQ0Fx?=
 =?utf-8?B?SFJNQzEzOHBxc2dDQ1VvdjFMTkZMQjh3SHgzanNGUDlVK3BzelI0K2Fsemo4?=
 =?utf-8?B?aGUrTUszN2NIUmNnaHNoUVl5dEhCQUxIZ1J5MHpvaXRiMzVMb0Zma1pTYmQx?=
 =?utf-8?B?SElBUDA2OWF3OUR4TjdHaFdiLzRxeGRzNWpZZ3N5VUkyeHN4M0NXZ1FEMk9x?=
 =?utf-8?B?c2xaZzN2V0tYZExRa3pBa2o5ZjZPcWtxc0Rjb3RCZEF2N2VESVdFZ3ZzdWVt?=
 =?utf-8?B?QWZ5Z1Zvd0FKWEFUQmR6M213RGhQTEgwU201azF3KzBaOG1MYjFHNG1yWlRN?=
 =?utf-8?B?TG83cm15RU9WbnpJTnFuU09vVS9yR2ora1l0OTZyUnZmdVkzVkk3OEJmNUFI?=
 =?utf-8?B?TnpBUXR0OVdmQ2psTjZIT1IxY08xOUViNE1LQmhwZ0lrbE5FNUQ2WVlrOEhS?=
 =?utf-8?B?ZU9jeDRKYlI1QUNDOGI3Njh3Umd0MWE4Wk5RczJYTC81SFh0dWFxcmtRVkhY?=
 =?utf-8?B?YUVIc1RDREloaXFyUXNDZlB4NkF2WGk3L1dWZUtCT3FueHMwK1FhTHhFdDhv?=
 =?utf-8?B?YmVFcTVPV1dEaVU3aXNyMEp6cTIrblFYb1dyT3hLTE9KcDNsTXdaL1Z6aEhW?=
 =?utf-8?B?MjRseFBIK3g0R0k5TDZKMVErUVdtL2RHN1oxVHIvalhRdVFWV01obG50RkFw?=
 =?utf-8?B?WW5VSXAxdUwzeDlrdStYcWZxUWlWMkh2UUpCT01xb3Zvamg2K2ZWMDdlZ3Vm?=
 =?utf-8?B?SGpPbkVndERLeGloWDZOOG85NlJ0aWNEUWV4Y2Y3V1RwQlVnOVpCK3Bta0Q4?=
 =?utf-8?B?WnhBVFhxaTF3bURpZWRyOEQvKzVVRzFTSWw3bExuejRJQkVqWWtwcWs2N2JO?=
 =?utf-8?B?N0hUMGhpVVRVb2oyUEJ0UERwVml6ak1xSi82N2dQb2FFdTd4ZUJFYVFBc0pi?=
 =?utf-8?B?TTZoSGFUN1k3bEcxekxnZmIzczFQNSt1c3JQWVM3cmh3NDNEUnpuUEtYckhE?=
 =?utf-8?B?eXo4ZFpUVEM3UkJzVFl0aWx1dVFyS1ZTbytTOFRreCtzRGFXRjRsdzg4MS9i?=
 =?utf-8?B?Z3RuaEtaUi9sckpuNzdmcCtsVlVqejAxYjhNTktyV1pLWXFuTy9EUjhZZk1o?=
 =?utf-8?Q?szyYBD?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(376014)(82310400026)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Apr 2025 10:48:54.8050 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 40c58f8d-9a7d-4d70-7c22-08dd8254717e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ5PEPF000001F7.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7299
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

Mesa passes shared bo, fence syncobj to userq_ioctl.
There can be duplicates here or some fences that are old.
This patch is remove duplicates fence and only keep
the most recent fence for each context.

v2: Export this code from dma-fence-unwrap.c(by Christian).

Cc: Alex Deucher <alexander.deucher@amd.com>
Cc: Christian König <christian.koenig@amd.com>
Cc: Sunil Khatri <sunil.khatri@amd.com>
Cc: Arunpravin Paneer Selvam <Arunpravin.PaneerSelvam@amd.com>
Signed-off-by: Arvind Yadav <arvind.yadav@amd.com>
---
 drivers/dma-buf/dma-fence-unwrap.c            | 29 +++++++++++++++++++
 .../gpu/drm/amd/amdgpu/amdgpu_userq_fence.c   |  2 ++
 include/linux/dma-fence-unwrap.h              |  3 ++
 3 files changed, 34 insertions(+)

diff --git a/drivers/dma-buf/dma-fence-unwrap.c b/drivers/dma-buf/dma-fence-unwrap.c
index 2a059ac0ed27..18874eedf091 100644
--- a/drivers/dma-buf/dma-fence-unwrap.c
+++ b/drivers/dma-buf/dma-fence-unwrap.c
@@ -179,3 +179,32 @@ struct dma_fence *__dma_fence_unwrap_merge(unsigned int num_fences,
 	return tmp;
 }
 EXPORT_SYMBOL_GPL(__dma_fence_unwrap_merge);
+
+/**
+ * dma_fence_shrink_array - return the shrink fences from fence containers
+ * @fences: array of fence
+ * @num_fences: number of fence in fence array @fences
+ *
+ * only keep most recent fence for each context. It will remove duplicate
+ * and old fence of same context.
+ */
+unsigned short dma_fence_shrink_array(struct dma_fence **fences,
+				      unsigned short num_fences)
+{
+	unsigned short count = 0;
+
+	if (num_fences <= 1)
+		return num_fences;
+
+	sort(fences, num_fences, sizeof(*fences), fence_cmp, NULL);
+
+	for (int i = 1; i < num_fences; i++) {
+		if (fences[i]->context == fences[count]->context)
+			dma_fence_put(fences[i]);
+		else
+			fences[++count] = fences[i];
+	}
+
+	return ++count;
+}
+EXPORT_SYMBOL_GPL(dma_fence_shrink_array);
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c
index 3288c2ff692e..cc74bb0ed06f 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c
@@ -851,6 +851,8 @@ int amdgpu_userq_wait_ioctl(struct drm_device *dev, void *data,
 			fences[num_fences++] = fence;
 		}
 
+		num_fences = dma_fence_shrink_array(fences, num_fences);
+
 		waitq = idr_find(&userq_mgr->userq_idr, wait_info->waitq_id);
 		if (!waitq)
 			goto free_fences;
diff --git a/include/linux/dma-fence-unwrap.h b/include/linux/dma-fence-unwrap.h
index 66b1e56fbb81..94801feeee4b 100644
--- a/include/linux/dma-fence-unwrap.h
+++ b/include/linux/dma-fence-unwrap.h
@@ -72,4 +72,7 @@ struct dma_fence *__dma_fence_unwrap_merge(unsigned int num_fences,
 		__dma_fence_unwrap_merge(ARRAY_SIZE(__f), __f, __c);	\
 	})
 
+
+unsigned short dma_fence_shrink_array(struct dma_fence **fences,
+				      unsigned short num_fences);
 #endif
-- 
2.34.1

