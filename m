Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9E8FCC5AC7A
	for <amd-gfx@archiver.kernel.org>; Fri,  7 Aug 2026 06:14:43 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 211A210E334;
	Fri,  7 Aug 2026 06:14:43 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="enPoa7Zg";
	dkim-atps=neutral
Received: from CY3PR05CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11013014.outbound.protection.outlook.com
 [40.93.201.14])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 37C3B10E334
 for <amd-gfx@lists.freedesktop.org>; Fri,  7 Aug 2026 06:14:42 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AiNMV26BL0G4uI50YuE17M1hVNCOtbZH2/x9JwHWBJm35O/pdWKJEVg1x/mFRP9Bhqaos1SZxb8iuiUM1Dx5N6GHZFMVpSNIHMJC68kdvLnxlrUepzhUg5haJHzTVqASzDWMl1DlzMaTkTP7WRawSTL+uwcZImPVJ2YP//i5j9igF8BGD8bOqDg+8/yQFtor9k75Gu6pYXVd5M4sidoAoCOGErIsvUqMzIzoXzy8WwpR0IXJvHGfpU4HDA0Rm5DtpJbdE9MsX3l+IQGjr8tdhdUTN8cg1C65KEsnvJY4fMIw5uMF7je8wOtGaDNXeLFiwVM19M3F3Ja8i33RH3apTQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bfoBTWfxDdYkZutQs4uLljQK//RuIi9P5d7sXjrJbq0=;
 b=SnbLjNBD05PzWZNdOPQUC3riTfpnhYf/b0C98VKucLhZcAcyoS26aMWYlZiyDN2ZIBSu+Rmo08Ob5BbIPdaFg5hKexFVad5javvciXIkw+2j6HOGrObzLc08aA5scVYWB/RMIlR3vcAzY/zcOqJVr3sw8qkDobHWtlraZ7EjTJ6raSW3Ty45IVdZvcJZCt1UuUJvpXCND+mH118xR6EQhjkJQrEnnnHWZo3X777yLbQK5A5vSiLarz9Xch9VBbINw023vM88sRTBPkYYfLUzKV45f9nox8ncIogIiO/7Mz+AlPo00FWpZQEPVmElnSsOvuAoBT/YHHXlh/YWCGMyiA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bfoBTWfxDdYkZutQs4uLljQK//RuIi9P5d7sXjrJbq0=;
 b=enPoa7ZgFtXUszFo/4rSkjMCSc1npy+q5zsLFLiY6s0d9fE+Kl+6p9FQRfOnXJVqJB7KiF9hREnQEQZwCwfii4rI3QEohk9POqw7h/o6oa86QHRsHnDSMY4BTirqy2IalNdanAkUfDbTnbXLE8wTbH+yByM//AMF11Ys0jTpRFs=
Received: from SJ0PR03CA0201.namprd03.prod.outlook.com (2603:10b6:a03:2ef::26)
 by SJ0PR12MB6736.namprd12.prod.outlook.com (2603:10b6:a03:47a::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.292.19; Fri, 7 Aug
 2026 06:14:36 +0000
Received: from SJ5PEPF000001CF.namprd05.prod.outlook.com
 (2603:10b6:a03:2ef:cafe::11) by SJ0PR03CA0201.outlook.office365.com
 (2603:10b6:a03:2ef::26) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.292.23 via Frontend Transport; Fri, 7
 Aug 2026 06:14:36 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ5PEPF000001CF.mail.protection.outlook.com (10.167.242.43) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.315.6 via Frontend Transport; Fri, 7 Aug 2026 06:14:36 +0000
Received: from prike-code-pc.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Fri, 7 Aug
 2026 01:14:34 -0500
From: Prike Liang <Prike.Liang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, <Christian.Koenig@amd.com>, Prike Liang
 <Prike.Liang@amd.com>
Subject: [PATCH] drm/amdgpu/userq: fix lock missing for userq fence error set
Date: Fri, 7 Aug 2026 14:14:22 +0800
Message-ID: <20260807061422.365929-1-Prike.Liang@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001CF:EE_|SJ0PR12MB6736:EE_
X-MS-Office365-Filtering-Correlation-Id: 784824ed-16b8-4dff-3da0-08def44b27f8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|36860700016|82310400026|23010399003|1800799024|56012099006|10067099003|11063799006|18002099003;
X-Microsoft-Antispam-Message-Info: vnoEE1uvOgcdle3zB44F6Ly8vn+lZZuBKYTFDMUJyuCDk1AKOISqbZitcIYmy7Wedz/EHEm+ZXRIstpon6dFDIb7z5Eh3WkcATekcbTnQbbqceiNY1uC1pBfsrVXahB+OI79lGHlBuqFM0YItVw91PMBogC9hYwdZxq5cHxuuEjl9lbFbQEN0bFWmMZs97AxY1+j3EztDlC8Bt+mEVrmEMOlh/ZUsddTHlm2orn/u5zg3Oj+rE5t7yTWxSpR5oPRJLDNdvHWE3LEj3qn7ALowlmQdTrggKGj1f3mpwylWLroxbJPr1775oerdKnuloNdMRJisaHnUjPykj9f92X+vpwSYw5Stx1Xsz7bp5vmIyN+ofH1kGxTdYWMnVTe101oatO00/8Oi2wJExhLkQeVe3WN7Fi4Id1nypMVeYlqy5SwY0BYbK7s88QTUk4YTmDNFOtLCxWgC46SRhriWBJpvpJ9G0EiDN0KxUVssTNCHgnWFDSdhc9+tyim9DTHuQNQrHG3cVosnpTN/FkOplGXjTONi4sjf2tG7lwiXL5w7I8BHf7yrf0Ra/zqW94iYqDKWtTS3ObNa2HR7LcTPTILa2tRQdgZRyfxXv0nNQb0Lkd485bTEpGOexFCOkvLllASSrKk4siA7Dc+0Y9Kbl7H3zOUaOAEhPIMtYg7qVdqJUCkt4vsaKZY5e9C4COn091PgpaO51IPkZqTqFbCdRn+9g==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(36860700016)(82310400026)(23010399003)(1800799024)(56012099006)(10067099003)(11063799006)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: M17u6uCA8yc62/EheEi1GkdRz5846WBP9KoOn1jRyA9uhD6jMgKnvRN6O2MeTNpuGHTxCOEpEebskc44W7nuDE7fBjY6DGlMVQKr0DJ0rbcmKO0Ur0jINejKmfnuOyDT6Roi4i7sfwnP4I+TqZfFcjaEDUW2gyrKtreYkY4sY1UGwjPC6YkyEkv50KFemuEn8aLFhh7lN11uAlhzcKd15xk67a1CCcM8gi2mh/T/H8ILG7N8+veU7SarQDMsXSQI+AX0j/6nsqjetq0HE5O0HLoB76JVgH779ep6emX6wfzszu3WU/VAVZojUXzkoR4T8jLaCB8wJiUes638dHBeI2PE420mQwxtxtXIezFD1O4TVMf+H7im0GM5V3P4a0BCtHJYRczcpIxDvvPxsDpPTkcOBxUq5tX3QkDgmCJDxHxomCYsHZNaY8AP4q1C9M/V
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Aug 2026 06:14:36.2222 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 784824ed-16b8-4dff-3da0-08def44b27f8
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ5PEPF000001CF.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB6736
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

amdgpu_userq_fence_driver() and amdgpu_userq_fence_driver_destroy()
don't acquire the dma_fence spinlock, so locking the dma_fence lock
before test the signaled state and set error state.

Signed-off-by: Prike Liang <Prike.Liang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c | 15 ++++++++++-----
 1 file changed, 10 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c
index e8de64f8357d..db5bfd79ec1f 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c
@@ -193,12 +193,12 @@ void amdgpu_userq_fence_driver_destroy(struct kref *ref)
 	spin_lock_irqsave(&fence_drv->fence_list_lock, flags);
 	list_for_each_entry_safe(fence, tmp, &fence_drv->fences, link) {
 		f = &fence->base;
-
-		if (!dma_fence_is_signaled(f)) {
+		spin_lock(dma_fence_spinlock(f));
+		if (!dma_fence_is_signaled_locked(f)) {
 			dma_fence_set_error(f, -ECANCELED);
 			dma_fence_signal(f);
 		}
-
+		spin_unlock(dma_fence_spinlock(f));
 		list_del(&fence->link);
 		dma_fence_put(f);
 	}
@@ -428,8 +428,13 @@ amdgpu_userq_fence_driver_set_error(struct amdgpu_userq_fence *fence,
 
 	f = rcu_dereference_protected(&fence->base,
 				      lockdep_is_held(&fence_drv->fence_list_lock));
-	if (f && !dma_fence_is_signaled_locked(f))
-		dma_fence_set_error(f, error);
+	if (f) {
+		/* nest f->lock inside fence_list_lock */
+		spin_lock(dma_fence_spinlock(f));
+		if (!dma_fence_is_signaled_locked(f))
+			dma_fence_set_error(f, error);
+		spin_unlock(dma_fence_spinlock(f));
+	}
 	spin_unlock_irqrestore(&fence_drv->fence_list_lock, flags);
 }
 
-- 
2.34.1

