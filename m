Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 998DDCA9EBD
	for <amd-gfx@archiver.kernel.org>; Sat, 10 Oct 2026 02:51:15 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 24F0410EB63;
	Sat, 10 Oct 2026 02:51:15 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="wR8cK5du";
	dkim-atps=neutral
Received: from DM1PR04CU001.outbound.protection.outlook.com
 (mail-centralusazon11010064.outbound.protection.outlook.com [52.101.61.64])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E028B10EB63
 for <amd-gfx@lists.freedesktop.org>; Sat, 10 Oct 2026 02:51:13 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mJGWFXWx1T6rg0TwMlOiOKw+L5ogkRBqtKecfx45jnpTM/ANqobLsCe1LcBlwwpnwSUkpAGKfnN3XrwRxcdpiOdfvaVZwClgDrToM42U16wFSb0QFhTkuzmFShIIipGdPfdicxs83exMxq5rPV/SpaIQZrCZ1OL183JrSCKxEqUnAlbCxErOQROEROv2F8IyawG8bml7awBHUuuxudBawsxAPhd2TetKjVxJHYXpK4g2qxVNbRCwGNuw6lG1Asr20l+QshsqtBXZBcRXrwrIUwr0fHDWkgLTL9USXXJTcOurPzke8v6jBhxUk0p903sYkDxRqCooBOATjAYHVrzi+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=l6fWpAUwRao+aeEhFu3CQ/GczreXQW609lh22jcFz+w=;
 b=RpDPUJn3gz6Bkh618T6JmWKbi5cUiExbCF8cE+KRCMbJ5SSMnb4kPxeIMGGkmWcod22rSbWX/VA0TZhyjUq/mZkSnOWknBQCZvsihz9vObNywO7IBepQeLW0mDYw8JZrKqM880vm6zPSM3+p6QsVfniPS9blfCh93aB0RY/TYOeT6FlRz0GS+0XQr3B4c95JAnsBB61Uhu3Ox+KKceHTPMT4ZrxRzAu/dXaD2+BeNJtlICXA2qeXnaGyJcCEy5pUcBd89dId/4T7GpAi7uEzFXxLbgiq+ZlXXYhJpnOfHB7rxnNDJuICEwP3vMZIFotJY3SC7ayF3zBOJf5knAwQJQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=l6fWpAUwRao+aeEhFu3CQ/GczreXQW609lh22jcFz+w=;
 b=wR8cK5du87acaPIXsFfDKCzKbUESwulYZyhF1KCNXepDVfoWpIbVufDb/ukTqbyLg8qmDWbjIkpoK35Lf/gQZshBoxz29/KqruqehsyMSf9d7sKxwcQRfQW1058ab5bLHI+HiWZwKLa08vw2Nrehj+bUie+C2oVjr/Q4mQ9dHnY=
Received: from SJ0PR05CA0166.namprd05.prod.outlook.com (2603:10b6:a03:339::21)
 by CY5PR12MB6321.namprd12.prod.outlook.com (2603:10b6:930:22::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.496.16; Sat, 10 Oct
 2026 02:50:40 +0000
Received: from SJ1PEPF000037AD.namprd03.prod.outlook.com
 (2603:10b6:a03:339:cafe::3b) by SJ0PR05CA0166.outlook.office365.com
 (2603:10b6:a03:339::21) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.428.6 via Frontend Transport; Sat, 10
 Oct 2026 02:50:40 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ1PEPF000037AD.mail.protection.outlook.com (10.167.244.180) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.522.6 via Frontend Transport; Sat, 10 Oct 2026 02:50:40 +0000
Received: from prike-code-pc.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Fri, 9 Oct
 2026 21:50:33 -0500
From: Prike Liang <Prike.Liang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, <Christian.Koenig@amd.com>,
 <Pierre-eric.Pelloux-prayer@amd.com>, Prike Liang <Prike.Liang@amd.com>
Subject: [PATCH v4 3/4] drm/amdgpu/userq: report invalid VA through the broken
 status flag
Date: Sat, 10 Oct 2026 10:50:23 +0800
Message-ID: <20261010025024.2453900-3-Prike.Liang@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261010025024.2453900-1-Prike.Liang@amd.com>
References: <20261010025024.2453900-1-Prike.Liang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF000037AD:EE_|CY5PR12MB6321:EE_
X-MS-Office365-Filtering-Correlation-Id: b44feba3-eb3a-42bf-f4bc-08df2679456e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|36860700016|376014|82310400026|23010399003|261009223027099003|56012099006|10067099003|11063799006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: AJpWeCOzsYw1+Dy63G6qnwI+Qxa3ALPHWCYhNXwvK0cqedvateHZLOwBeOJLItUlCzBNtWj8jArYlXor39jgQQMqFFlzRBtrev0ufSBQJQYmg2kXiYXQdlAEyBvg5IXXTdxvCvXO+O/4ZPLJPFENLR30+5TWXIjCYc1dnJuysQMmuRd5P5nFlbwvxmPJHdwlx2bh7M8vgaOwOvUFqxKMl3XVwP3uhZeAqe1elnyaeNYCOY5VY9SRXXbdsfUV7eG0dn8xkq537K8Srj/Cv4DcokW2X6B07c001rrPbeaX1Ljc2uXaVzS520rZob6dInEabsFAt6A5IxVSiegdsrUS4Y0Al+0Ffm/Z75hVu6mDU4MNKsDMRmEUPpH7Y3+mKFYTfhxIIOs3ILCr0Oiw8LiTHYFJ4CUpH/vNIOmhWLRjbBu0kCYB80tOV9bmKlAtF9V8Yf4wP8yJzo42MC7/LiODqYH8/l5IfM5RoTySbAiFlsVaWaCFyLAYBxKVWFQYW6/eKtnVWlxN3RqmZQq6RzD7Aan0363panGjdXsrnePZA3z5MhaZytO+MzrSLFEUdR7bJ3Wh503CbQf3QvKejs/N0j3HRnttsM5zBf/P9TwtRTLO3UF2Uwujphpif+OwinKOwWk0OZsa/av/9gsl6QI/d5e00b2DFHcaYdw22nQGgPkO0RKZfnrikmMObm67LAjtfVKc8zGuWUtXpPfuwAucpg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(36860700016)(376014)(82310400026)(23010399003)(261009223027099003)(56012099006)(10067099003)(11063799006)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 1EZwLdqgJ0rWbq8APhaPaRj9Y8km9N7/A7dA0OZrjeKxYtXxo+bVg23MHpQLntx8RNpZVzK3dAJC4YkQ2po4gKH6SPsJge00oPRuydKP36M5m5TaX0nXr0fEe8WBHGIxcWZMCEZwfgqqcTLLqC841sO44XwnnNTJIyZYi7ucyaYgPN/8EbqjTpDCESTvFv00OriC/GeFH4vDa6aLXDc1hRUBeD1R6vTJiXWjBrBa9Urj/+Gum15Z1XWmBOvCMZMzvvTAZvBJYewDy5NTQCil3xe1v2zwhpTQ8Lv38FCqg2SD7RZ5a3wh0+B4jgFXdQr9zBYq2fgN3Dfyt6wbF8G/IVdgS6P37ZHP0pdTl+4pk5f7iRUcaVpyg4M8y7xj99j4UZPbrptZlHx+d0m/YbAv9OBNVgMYKFYa3n+SZ91UWYHbqpBzneLAv5o9azmTv9MG
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Oct 2026 02:50:40.6437 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b44feba3-eb3a-42bf-f4bc-08df2679456e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF000037AD.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6321
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

Report a queue with an invalid virtual address as BROKEN, alongside hung
queues and queues whose VRAM has been lost. Use the existing BROKEN flag
instead of exposing a separate INVALID_VA status flag.

Signed-off-by: Prike Liang <Prike.Liang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c | 1 +
 include/uapi/drm/amdgpu_drm.h             | 2 +-
 2 files changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
index b99fd7acdc1b..6340e647a67d 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
@@ -832,6 +832,7 @@ amdgpu_userq_query_status(struct drm_file *filp, union drm_amdgpu_userq *args)
 
 	args->out_qs.flags = 0;
 	if (queue->state == AMDGPU_USERQ_STATE_HUNG ||
+	    queue->state == AMDGPU_USERQ_STATE_INVALID_VA ||
 	    queue->generation != amdgpu_vm_generation(adev, &fpriv->vm))
 		args->out_qs.flags |= AMDGPU_USERQ_QUERY_STATUS_FLAGS_BROKEN;
 	amdgpu_userq_put(queue);
diff --git a/include/uapi/drm/amdgpu_drm.h b/include/uapi/drm/amdgpu_drm.h
index 71936418b0db..98c3fa8a4a72 100644
--- a/include/uapi/drm/amdgpu_drm.h
+++ b/include/uapi/drm/amdgpu_drm.h
@@ -353,7 +353,7 @@ union drm_amdgpu_ctx {
 /* for queues that need access to protected content */
 #define AMDGPU_USERQ_CREATE_FLAGS_QUEUE_SECURE  (1 << 2)
 
-/* the queue is broken because it is hung or VRAM was lost */
+/* the queue is broken because it is hung, has an invalid VA, or VRAM was lost */
 #define AMDGPU_USERQ_QUERY_STATUS_FLAGS_BROKEN  (1 << 0)
 
 /*
-- 
2.34.1

