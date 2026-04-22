Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B96C8F94CC1
	for <amd-gfx@archiver.kernel.org>; Wed, 22 Apr 2026 21:52:23 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 59BE510EAA6;
	Wed, 22 Apr 2026 21:52:23 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="IW57vWGh";
	dkim-atps=neutral
Received: from MW6PR02CU001.outbound.protection.outlook.com
 (mail-westus2azon11012011.outbound.protection.outlook.com [52.101.48.11])
 by gabe.freedesktop.org (Postfix) with ESMTPS id ABD4C10E040
 for <amd-gfx@lists.freedesktop.org>; Wed, 22 Apr 2026 21:52:21 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=poFewtq8wycUii0fbUHSYydk3cbfRM2Xg0p8vWh8dE2BmbRyU6FcOFwXQJnbal35YbfcPzcp+oi7VmN4afARYaHQZpR99wGAKV/rtNp5Fnw20X9qFu+MUlaA/eIfT2RDD16xkiyo+idjWogCQ/sst5H2TovIB7hIZf/SULyFU/LQxEaRjqAoryqWZcwHtySJ7xRlvzdH93jDojk8EwcbEskxhTg9NTqWQP5QIxMVrmAiifAW2alRd42TjK4wirsN3seZlhdk5Ev4ox1fjUfnT8UvM3I6MYJHYy/v+OjndIQ585jfxxJQou8lPTA/xJ0i3UxgSstazhbTuRFVuWWapw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oZDfeJDYm8+dbYHIFOaZ82m1pypV9gU+hCEh5uehzaA=;
 b=oGwXrbx6v/fdKgg/4AdgL4tMLDv5XUS9QfTJ4tGYImPuMFVUz/psGDk+tIcjCuOj+b73SZHXuW3outEP4KefTybFBLOl8PNVgXaJpa03cQj62GuEiB6dSIzVpKBNqYE4z47AU4xZbYdCj+9HtwwXpXIAr14PAM19R1RBFTYdVTEOD0/ferynPJqc9LkeDSGcr/C29mG+LkK5keEzqFktm1/GR0TJxkyi56j3xBNiEzmFbAtQWQbApONnU9M3lv1FZhL98p+/DR3QIK/yDaMk+4GYOTAS5fAqGzJI/YfnTq0rLbqJn9SdSAHXSNTlyPUW67ALcsEGGD11YmTZ+y7Q3w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oZDfeJDYm8+dbYHIFOaZ82m1pypV9gU+hCEh5uehzaA=;
 b=IW57vWGhR2R1f1h2qkBj1VkEDmWDYSmk2iasIqFaQyC7F626o3jUOrxmY3ai8VhW5/gtrrtneAuc4zYdPfXqEFsX4x3tFNo2ILLNuEjnwfAY8OOSRCbZdRXKblDXYkQQAe0pgYdxZNWG2Oeeu3q9GcGsHM3RvC/OMaNLBeGG4/o=
Received: from BN0PR04CA0175.namprd04.prod.outlook.com (2603:10b6:408:eb::30)
 by SA3PR12MB8048.namprd12.prod.outlook.com (2603:10b6:806:31e::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9846.20; Wed, 22 Apr
 2026 21:52:17 +0000
Received: from BN3PEPF0000B074.namprd04.prod.outlook.com
 (2603:10b6:408:eb:cafe::ca) by BN0PR04CA0175.outlook.office365.com
 (2603:10b6:408:eb::30) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9791.48 via Frontend Transport; Wed,
 22 Apr 2026 21:52:16 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN3PEPF0000B074.mail.protection.outlook.com (10.167.243.119) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9846.18 via Frontend Transport; Wed, 22 Apr 2026 21:52:16 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Wed, 22 Apr
 2026 16:52:14 -0500
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb09.amd.com
 (10.181.42.218) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Wed, 22 Apr
 2026 14:52:14 -0700
Received: from p8.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Wed, 22 Apr 2026 16:52:13 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harish Kasiviswanathan <Harish.Kasiviswanathan@amd.com>, Philip.Yang
 <Philip.Yang@amd.com>, Felix Kuehling <felix.kuehling@amd.com>, Alex Deucher
 <alexander.deucher@amd.com>
Subject: [PATCH 3/3] drm/amdkfd: Limit per-process xnack support for GFX12.1
Date: Wed, 22 Apr 2026 17:51:59 -0400
Message-ID: <20260422215159.2242821-3-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260422215159.2242821-1-alexander.deucher@amd.com>
References: <20260422215159.2242821-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B074:EE_|SA3PR12MB8048:EE_
X-MS-Office365-Filtering-Correlation-Id: 2173f2f0-647f-4efb-dbdf-08dea0b96b36
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|376014|1800799024|36860700016|56012099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: 51kx+P76y2U6O3iOLexWoQUHjVQWttmxDcPKTHIR0OpTC/SEguUIGDSiLrzRiUTjzLCQ/NVnclpD7nU09iOykw2BRSO/LjZ9Fcwh9cJiJTcFYL5AG6kzBRIK1RRHRCc7SOA8yn6K/5Gm3yGbC3qtNDNvzHNfk2So7wZnL3Um9wLLIfcdxRD8wWYbP/UjGWP00iRiq8t+PF8Ky2Htq/dv7kuhupIEwB+F/QfjRPsrE379TJ1wPNOmLjXdjbIcjS6JHkdyNvcn+nqXX/1KZwAYfg4lB+w6JGUdgFAn1ukcWavGslWRAhL5g8BeLiyLXxhNFjMMmMJGycrxN0iWa3TAFB8iYOCZsyLU1G4/3PNCE1RjSXN3GcgG9HGVAtlqORxlHc4OMKIAq47tUVRXu63ggOUH4WSunmlcbtq20i18V/rEY2ZA9qVaEZHXl57RYavqjQDm4hth3dfV4jFC23pPYuQ+qc/xJ7q6R8wbyfmrCT+tLGYHb7d4JX1MHdh7uxJyp8E4COZgbYHV+Bg3Ew85ivA6gCjGWVMdwPqVcrCA+C6AeWf7MptsECKuxlDqx7PdLJy7YCqKqbxhduMms9hOOByyLsARV7dw31yGjt5M/HIIgwT78PhR4VcOv8f0XTNKOuE3ToH6I665rQ3Etf4UkSSH0Q3bjKQNc0hqWyGiIeRVW3MucQ9NAP2kIEzNHFVLPhteBINj/NHS2aFwhqTQVyTzKwJBZwnl9xVehFuKUJcTwdd69VGWIo6mNKGwzcs4SN0pfSM6JnQ9dRTFQ5boHg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(376014)(1800799024)(36860700016)(56012099003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: lmNq05DsgsO5fwQBPR06CGuVk4FwnCNNGYxoEGbgtDzCqcYgYYx0tsL4Aym3CiH4A3qQWzxQKfXzTq4aq5QUkyduQmEEo4l5Eo4Z4cURPzU+QLGu2JINLbJTME52962UeKfu2tMlu3GzPsUHE1tVfDkdoCv02ozzXvv55Enyco2WfamdzvtDP3uIYZtyWWQvYgYZJN+U7cL4Ysg+SOxP1VLA7M5eTQesDltDGJ87lvNGKZEoyhLAEyegWCGZop57ksNsbYUG4hMZoBqIPLkQSwVon3VAb7YMvthemYuIBol37m1TT23NtujiMf6Wf6lHKrj4bQjG9YrDAqGBIMWLOkCbR7GljNqvXznnq86Wm5UThQwjd4gyKlwzytV2hPl4NDy+CzFtVWhdp0gKGYOyfjneX+7rDag63SXN1v17p2QpFcGtERLGZ/h5E3EnPPcP
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Apr 2026 21:52:16.0917 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2173f2f0-647f-4efb-dbdf-08dea0b96b36
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN3PEPF0000B074.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB8048
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

From: Harish Kasiviswanathan <Harish.Kasiviswanathan@amd.com>

GFX12.1 doesn't support different processes with different xnack
setting. Hence, xnack changes from its default setting needs driver
reload with noretry module parameter.

However, if driver boots-up with xnack on and process sets xnack off,
this condition is supported. In this case, only driver takes xnack off
path whereas hardware / firmware considers xnack is on.

Signed-off-by: Harish Kasiviswanathan <Harish.Kasiviswanathan@amd.com>
Reviewed-by: Philip.Yang <Philip.Yang@amd.com>
Reviewed-by: Felix Kuehling <felix.kuehling@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 .../amdkfd/kfd_device_queue_manager_v12_1.c   | 19 +++++++++++--------
 drivers/gpu/drm/amd/amdkfd/kfd_priv.h         |  3 +--
 2 files changed, 12 insertions(+), 10 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager_v12_1.c b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager_v12_1.c
index 9e70a5f8a50b0..5259893713782 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager_v12_1.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager_v12_1.c
@@ -54,6 +54,7 @@ static int update_qpd_v12_1(struct device_queue_manager *dqm,
 	struct kfd_process_device *pdd;
 	struct amdgpu_device *adev = dqm->dev->adev;
 	struct amdgpu_vmhub *hub = &adev->vmhub[AMDGPU_GFXHUB(0)];
+	bool xnack_enabled;
 
 	pdd = qpd_to_pdd(qpd);
 	qpd->vm_cntx_cntl = hub->vm_cntx_cntl;
@@ -71,16 +72,18 @@ static int update_qpd_v12_1(struct device_queue_manager *dqm,
 		qpd->sh_mem_ape1_base = 0;
 	}
 
-	if (KFD_SUPPORT_XNACK_PER_PROCESS(dqm->dev)) {
-		if (!pdd->process->xnack_enabled) {
-			qpd->sh_mem_config |= 1 << SH_MEM_CONFIG__RETRY_DISABLE__SHIFT;
-			qpd->vm_cntx_cntl &=
+	xnack_enabled = KFD_SUPPORT_XNACK_PER_PROCESS(dqm->dev) ?
+			pdd->process->xnack_enabled :
+			!pdd->dev->kfd->noretry;
+
+	if (!xnack_enabled) {
+		qpd->sh_mem_config |= 1 << SH_MEM_CONFIG__RETRY_DISABLE__SHIFT;
+		qpd->vm_cntx_cntl &=
 			~(1 << GCVM_CONTEXT0_CNTL__RETRY_PERMISSION_OR_INVALID_PAGE_FAULT__SHIFT);
-		} else {
-			qpd->sh_mem_config &= ~(1 << SH_MEM_CONFIG__RETRY_DISABLE__SHIFT);
-			qpd->vm_cntx_cntl |=
+	} else {
+		qpd->sh_mem_config &= ~(1 << SH_MEM_CONFIG__RETRY_DISABLE__SHIFT);
+		qpd->vm_cntx_cntl |=
 			(1 << GCVM_CONTEXT0_CNTL__RETRY_PERMISSION_OR_INVALID_PAGE_FAULT__SHIFT);
-		}
 	}
 
 	qpd->sh_mem_bases = compute_sh_mem_bases_64bit(pdd);
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
index 4f13af63874a8..2ba53d485cfcc 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
@@ -215,8 +215,7 @@ enum cache_policy {
 	((KFD_GC_VERSION(dev) == IP_VERSION(9, 4, 2)) ||	\
 	 (KFD_GC_VERSION(dev) == IP_VERSION(9, 4, 3)) ||	\
 	 (KFD_GC_VERSION(dev) == IP_VERSION(9, 4, 4)) ||	\
-	 (KFD_GC_VERSION(dev) == IP_VERSION(9, 5, 0)) ||	\
-	 (KFD_GC_VERSION(dev) == IP_VERSION(12, 1, 0)))
+	 (KFD_GC_VERSION(dev) == IP_VERSION(9, 5, 0)))
 
 struct kfd_node;
 
-- 
2.53.0

