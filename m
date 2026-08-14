Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6EB28C5CFC1
	for <amd-gfx@archiver.kernel.org>; Fri, 14 Aug 2026 21:03:39 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id ED01710F6E2;
	Fri, 14 Aug 2026 21:03:38 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="vGv5MA9/";
	dkim-atps=neutral
Received: from CH1PR05CU001.outbound.protection.outlook.com
 (mail-northcentralusazon11010053.outbound.protection.outlook.com
 [52.101.193.53])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1740D10F707
 for <amd-gfx@lists.freedesktop.org>; Fri, 14 Aug 2026 21:03:31 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=H0E6ofkcu20PT03ZUI7G9w/EVxnIJ0hD3BxupTtDZA6jkhqKR/ygYs7tTbe4ZhGKCS+MUJUBNs4RHKKkyoTB01/MbZgYlP45ZLZYGMQEPpaJBO9h9ha5jYqa+aipN0379xqPYqmq/4BFzRkTwZ77iHlHBlbN7SWsg3GhZ29vXoyUqpFN9B/HBuazR/881GcCQucG9SiqqhtyYRHnT5RR+CKfPNa40gyJMgSbAlGQlsDa4POTEHoRe2vWNV+Ep6XUZiUAfm1wFp47YD9lxb77LqcvtW6z1ffvW1pLY7TtdCzlHHQW0B+vWIu9JtOusbLdCdniqzul2uNAKEmdMdHJcg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lU3Y3iGXjcSPGmP6audhEFqY+1JrrPqJiMsx50JftlY=;
 b=LX0e5hCQGaflB6U15r7YgZkjdmBItJ2VeOiIsFYTU610IRVZ+rB5cdJTuL5bObqqqYKzj0C1xeZv8FknnWLhJ9zZFpJ5Q6rr/Bd0LCvGE1XZ8FbxGb7aW+uR0vcj/k5SCuOshGczfiTi4aCt1neQQNfkeolbcS4kYjvhG5zSx/KkPWZPb7dq23k/5aFLIjxrGsNlQ/kbX4C731S+q2AL9qXt34P0YLzBoz/0RrCAq5cL7yEyJ7VK3KgiSNsCa0AclXCaYn5WNZbhduN4fx9RrTwi5MbXbzwoyPLDbCiSr+M+1WJIVjNI31y8+Usgir2aVEsHQH3YFn41kxvg9RlR+w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lU3Y3iGXjcSPGmP6audhEFqY+1JrrPqJiMsx50JftlY=;
 b=vGv5MA9/degnJiY2ywGV3KFLvD0lY5v5yd4SK69Ca4NcN+3xusHz4QjIAU0qTqQnte4PT7Y11tywPZm3K+yK6xmFKlurFTXZzZluRbKIlXCwIPbnBYpjA9NmgkCK1/6XAFG1jpODXQ6NsYQig/EmPh7KWs3iJb8Gqex6DHaz6VU=
Received: from CH0P220CA0013.NAMP220.PROD.OUTLOOK.COM (2603:10b6:610:ef::9) by
 CY8PR12MB8300.namprd12.prod.outlook.com (2603:10b6:930:7d::16) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.315.15; Fri, 14 Aug 2026 21:02:58 +0000
Received: from CH3PEPF00000011.namprd21.prod.outlook.com
 (2603:10b6:610:ef:cafe::71) by CH0P220CA0013.outlook.office365.com
 (2603:10b6:610:ef::9) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.315.16 via Frontend Transport; Fri,
 14 Aug 2026 21:02:58 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CH3PEPF00000011.mail.protection.outlook.com (10.167.244.116) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.360.0 via Frontend Transport; Fri, 14 Aug 2026 21:02:58 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Fri, 14 Aug
 2026 16:02:57 -0500
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb09.amd.com
 (10.181.42.218) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Fri, 14 Aug
 2026 16:02:57 -0500
Received: from p8.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.45 via Frontend
 Transport; Fri, 14 Aug 2026 16:02:57 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: YiPeng Chai <YiPeng.Chai@amd.com>, Hawking Zhang <Hawking.Zhang@amd.com>, 
 Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 001/109] drm/amd/ras: Add ras notification event
Date: Fri, 14 Aug 2026 17:00:58 -0400
Message-ID: <20260814210246.3067612-2-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260814210246.3067612-1-alexander.deucher@amd.com>
References: <20260814210246.3067612-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PEPF00000011:EE_|CY8PR12MB8300:EE_
X-MS-Office365-Filtering-Correlation-Id: d8956177-24fd-4e24-3414-08defa476b58
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|82310400026|36860700016|23010399003|376014|56012099006|10067099003|11063799006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: Npxqn2sINZnpjdVrMEZ9XKL1Tfyi6V+tYLdW8iBdKIWgDaTTxRji93rV9tUgQrnUfLkoZx1MR36+R/nd9zf4cFG/LANNqG6/fLHraHQYMNX6T4MZeIHwsSL9hDREVsqouxXBC+NqFLdC3cKoenwqEOsc7rr0PhZ8ro3W3/kOSsL+44Lo4ON821y4ezxxRAXn1GTBcWV+SoejbkQJ7YhnCgkoKhMz8Rb3pwzZxgbvL9+8O2rffoL0bQ20eKo0MAvdE6FoR2eEWR3mzCbYDodX9/Zh/zvqQnCvDeB7EIbPtMEL+nAQuhyI2iinJxTYL4ifsgZFR4VoH9EvjsBnh4/Iv7dKMYaqTvP59EUHAo7nDFse0DqgiRi3RYglR2Mx/lm582alagW2FQ5Mqn1HIsFVRMRCrud3Fx/ynZjbRI21FjGWT1C1hzYm7jpcT7tDGuSI+v7GJ/1TS5Wwn+r6yI224BxnnbHA4mgUsIdPaYM1sLtCjbrc2u9W6MNpKS8SMa1vO9sIxYjIIUhWZBjqeKYcQtPkUpk2vRswcPQxQdoKXCWODbvVtqLK8MSrcBHgmfO5suYjA7tPHlmFHLQT6dub6NOTEJI0mvMVAtAj4dU7emLC6PgqhcrhUclbnfdRT0eA3j4qucvOrOZg1wPb0WI5PIb8nV/4bAPQAJke1aHRkKw=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(82310400026)(36860700016)(23010399003)(376014)(56012099006)(10067099003)(11063799006)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: +oy1SO5vNKr8sNCxxm6nxh8PFUD8OjuKuZ8M76Kec2IZbZMvXIm7/TOLYRGFca9lRhnLIda8+kyySmFpxhLMK1kCsrNgtYl9glR0Gfk1zHiKWYMtt8zLcp+YyoJ8ocDoD2/HizQMlMFd/4m5WdcGr426UAtzbFELiFjcHUpHfhcjy8HsuHPfKVqNz8TlT7pf1w54JJumRcEISMm5ESv+AFyK2j74p67Mw+AH4iyZ1W0hS4v+B4OFgHQlZjNYyWm/RHB/u/Lq7QILbCHE6TMCXF/qoDiSSCY3gEjooPwj026GUFBExhx+VM3yW9TQxh3H/shc8JqTzwyhz4dcq6lAGLU/7gWZ3M2c9J96Nu5STwnJFh3CwJy8I/YrnfsMqurbGAOZFaObJ/TpQ5ZyGonHpBGn35SGmIdzhl3Qkb7GXf6QVeHE7pH59tvYPMcyIaS0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Aug 2026 21:02:58.3208 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d8956177-24fd-4e24-3414-08defa476b58
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH3PEPF00000011.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB8300
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

From: YiPeng Chai <YiPeng.Chai@amd.com>

Add ras notification event.

v2:
  Change event id name.

Signed-off-by: YiPeng Chai <YiPeng.Chai@amd.com>
Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/ras/core/aca.c               | 3 +++
 drivers/gpu/drm/amd/ras/core/ras.h               | 1 +
 drivers/gpu/drm/amd/ras/ras_mgr/amdgpu_ras_sys.c | 4 ++++
 3 files changed, 8 insertions(+)

diff --git a/drivers/gpu/drm/amd/ras/core/aca.c b/drivers/gpu/drm/amd/ras/core/aca.c
index fa7cb32775786..7c42a05b0207d 100644
--- a/drivers/gpu/drm/amd/ras/core/aca.c
+++ b/drivers/gpu/drm/amd/ras/core/aca.c
@@ -406,6 +406,9 @@ static int aca_banks_update(struct ras_core_context *ras_core,
 	}
 	ras_log_ring_destroy_batch_tag(ras_core, batch_tag);
 
+	if (!ret)
+		ras_core_event_notify(ras_core,
+			RAS_EVENT_ID__UPDATE_ACA_DATA, NULL);
 out:
 	mutex_unlock(&ras_core->ras_aca.bank_op_lock);
 	return ret;
diff --git a/drivers/gpu/drm/amd/ras/core/ras.h b/drivers/gpu/drm/amd/ras/core/ras.h
index b4e40d7cc0e05..ee1b19948830b 100644
--- a/drivers/gpu/drm/amd/ras/core/ras.h
+++ b/drivers/gpu/drm/amd/ras/core/ras.h
@@ -129,6 +129,7 @@ enum ras_notify_event {
 	RAS_EVENT_ID__RESET_VF,
 	RAS_EVENT_ID__RAS_EVENT_PROC_BEGIN,
 	RAS_EVENT_ID__RAS_EVENT_PROC_END,
+	RAS_EVENT_ID__UPDATE_ACA_DATA,
 };
 
 enum ras_gpu_status {
diff --git a/drivers/gpu/drm/amd/ras/ras_mgr/amdgpu_ras_sys.c b/drivers/gpu/drm/amd/ras/ras_mgr/amdgpu_ras_sys.c
index 0b36b689fcfc1..b9ecb7d966b41 100644
--- a/drivers/gpu/drm/amd/ras/ras_mgr/amdgpu_ras_sys.c
+++ b/drivers/gpu/drm/amd/ras/ras_mgr/amdgpu_ras_sys.c
@@ -149,6 +149,10 @@ static int amdgpu_ras_sys_event_notifier(struct ras_core_context *ras_core,
 	case RAS_EVENT_ID__RAS_EVENT_PROC_END:
 		ret = amdgpu_ras_process_end(ras_core->dev);
 		break;
+	case RAS_EVENT_ID__UPDATE_ACA_DATA:
+		/* TBD: ACA error detected */
+		ret = 0;
+		break;
 	default:
 		RAS_DEV_WARN(ras_core->dev, "Invalid ras notify event:%d\n", event_id);
 		break;
-- 
2.55.0

