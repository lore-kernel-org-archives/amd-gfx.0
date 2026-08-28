Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 902E3C61DB9
	for <amd-gfx@archiver.kernel.org>; Fri, 28 Aug 2026 09:42:47 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DB56C10F316;
	Fri, 28 Aug 2026 09:42:46 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="xW7fBVbM";
	dkim-atps=neutral
Received: from CY3PR05CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11013038.outbound.protection.outlook.com
 [40.93.201.38])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4A7B510F316
 for <amd-gfx@lists.freedesktop.org>; Fri, 28 Aug 2026 09:42:46 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tbqlT937PQ4bPvz7gkVTMZImsNCMJAfxX3QXFR5xl6GqHBxQSHOnVnZM0JuZtzaefL+GkzaWB6e7VifcEFOnr6ikaRckJrf0Cc3yBxENba593568BAE1EypVqGc6ycrHlNz06w0ZAmiuiEWTkpuTFpoiMiQn5TmB8A4/mqQxQKuTq681ylDG3VefLgzToOYvGTq6PoGG7vvPqWu3SWt6w0b45pEG2sPwIFPtnTzQ5XK6WvrT9iS6HyfLKEiMFJmDmuZ0iwdf6qylU6qlUK9PT4HuQPmaOo3J7L26NDPC7+vVBVPdzd9+hw2o9xJW6ncJnHbprZvlp2kJwQTQ+MnHLQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8tflE23/ioiS7u4QdBaCjGh3k6Vbof+LxAraumQYV8o=;
 b=e1G/lIGA6Og+xn7r8IW4ngA5wL1oefTGELAsDOmW4L2E/K29NoMUa7O0jVLG7/PPjv6RWkaqPaKbCY/x1kyxDj6MvjXwRuGBZ5Sdz3pILXzxpg7bPBF6jh79DyPszgDCbSFLK2EAFJojn5yhdR7MDjxX0o/IOJ0q51qyuvD/nH6jjGnF6AadhMeabTeDnLfzbgk4abAKM7QUnGTH3Iay6/lxTB2a9eOVoiqgehB40nqAMkk1xdiJz1S4Vhm8CnttqJXhU6zNhZD352Jqs4KxQ8ujCXvon69+eaCvoDAWi/0/WIMmtOjSjvU4LtmBkgbIcykXNwp5GuN7LzETcqOTPw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8tflE23/ioiS7u4QdBaCjGh3k6Vbof+LxAraumQYV8o=;
 b=xW7fBVbMsulPGGDv06UeTf22PcxcEBNjTHKQkNb8qyg3yzk1rZ4UGzmakcdZAYslEFRUL2ZmTlu98F+vXdOS26ICeuZhd/X7yh42v22zDW8POKIFr9YgUOMf0WneHuRBjzSjt1CAXPkHT1z7SVIqdcXxUDewp6JmaPxE0khg604=
Received: from BN9PR03CA0546.namprd03.prod.outlook.com (2603:10b6:408:138::11)
 by IA0PR12MB8839.namprd12.prod.outlook.com (2603:10b6:208:493::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.10; Fri, 28 Aug
 2026 09:42:38 +0000
Received: from LV8PEPF0000005D.namprd02.prod.outlook.com
 (2603:10b6:408:138:cafe::c) by BN9PR03CA0546.outlook.office365.com
 (2603:10b6:408:138::11) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.339.12 via Frontend Transport; Fri,
 28 Aug 2026 09:42:38 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 LV8PEPF0000005D.mail.protection.outlook.com (10.167.245.134) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.382.8 via Frontend Transport; Fri, 28 Aug 2026 09:42:38 +0000
Received: from amd-X570.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Fri, 28 Aug
 2026 04:42:36 -0500
From: Yogesh Mohan Marimuthu <yogesh.mohanmarimuthu@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <alexander.deucher@amd.com>, <christian.koenig@amd.com>,
 <sukhatri@amd.com>, <pierre-eric.pelloux-prayer@amd.com>, "Yogesh Mohan
 Marimuthu" <yogesh.mohanmarimuthu@amd.com>, <stable@vger.kernel.org>
Subject: [PATCH] drm/amdgpu/userq: fix struct drm_amdgpu_info_device padding
 for 32bit compile
Date: Fri, 28 Aug 2026 15:12:20 +0530
Message-ID: <20260828094220.36104-1-yogesh.mohanmarimuthu@amd.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PEPF0000005D:EE_|IA0PR12MB8839:EE_
X-MS-Office365-Filtering-Correlation-Id: ef78dba2-d957-4c4f-4a01-08df04e8b2b2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|376014|23010399003|82310400026|1800799024|10067099003|11063799006|56012099006|18002099003|3023799007;
X-Microsoft-Antispam-Message-Info: VGrD9r2JrHLcobxMzKhha9EykjGEDPwvOkMLf85kNoo2PuDhhP8Ks88Oc3dt3JG4MtLuny8Qlo8Pa3fZO79rhxz8MU9hT2oTeTe1RyV5EcA073Fy2OnOVKX7M9cIkv/wmdMB4WN9PLmhQ6POKfZwlqD55MU5qWDRd8Kg+8fr3XWIS80n/NfVhGRXDB8On7ieZOR77qur6sJ3NzqXaSLbcY3lqo2AwYFJljSZx8NgRRgQPYjHcRLEhvfkOxmDflS35jEz4V8cgSaPBToums1DzV/H4Y2XDWyE7tunoFyQ/9jQqUIIP2s0lzTlR4eVF+o4tObefc6IaTU9SEfsIUMrqXI+zOkvhMe4ZZVRqgr0ADAztXqaGJxJxqh9OyNsRXk50ek0KX0QxDYprsxnEXfvoW1xsDBz29WyUAXe2PFlj1KJkTdhUD+qUYZWu2UrkvA6CdIN3sbPsocJoUTdWQfKq6DvfVeln2uNjpDWdpAg5GZg+Dn0u/aSGK1pd1Hf9bjzDkhcDxzdmhjBCMozw1U+lpvjPypRMjS/rIwIyWm/Y/yzHWyhC+GAZDw1IlmNJwhrOv8u/SQv+fwdeS7PxWqTTF9cI053nZb3hhfWDavHmsnZo+1R+JzeMzBOFIbmLie+t/5uhKkx5xx8oEN49weSI8vlDZU5xXTfzdu556D1rFmqRi2NmBfyq41JVJraHXak9v9c4SJHkTU4B3YJPvJKaQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(376014)(23010399003)(82310400026)(1800799024)(10067099003)(11063799006)(56012099006)(18002099003)(3023799007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: wdH/Z+wcdmsMwg3z9SNG+rp+ZIFk8sUUXCbIwFDsjZed3mUi0SKd3Hv8b5knpRAybNqA+7YZWX8ZviaLMxviC5FtyslNYbt2M5VayLBMr80E0/1VwpPhEwKMSH465U13HH6lyuf96h7U8Z606xQ/frchxxdn7YfwPdYLgVGeKzjL1zz2komELnzPspgkvb+3DT79IydCFIMzcgQ51IO1QRhaS7hW6Nw1GYLzEVwciTwxYlO7FtMKagtgv67Wx0oLq7ovA/zooM5vz17ppESkVeJT4EGWbBMLUo1Wofkm720d8lgEaAZ/t5ATBaF6ktj39layDY79R4SKj9YUhUO3HXpdvxHda8NB9ywbXJRU1TbS7FPoFkN9qGmM/KvJpcom5zflgb2/D4m0a1P5sheYAbaaBZ2ZQMb/GxZK0F3mFKvBEMThrQzLfGPgEEBN6I6y
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Aug 2026 09:42:38.6424 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ef78dba2-d957-4c4f-4a01-08df04e8b2b2
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: LV8PEPF0000005D.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8839
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

need to pad before __u64 tcc_disabled_mask variable.

This patch fixes 64bit Kernel + 32 bit mesa combination. But at the same
time it will break 32bit Kernel(using this patch) + older 32bit mesa(not
using this patch).

This issue was discussd with alexander.deucher@amd.com,
christian.koenig@amd.com and pierre-eric.pelloux-prayer@amd.com.
Currently today 32 bit kernel + 32 bit userspace and 64 bit kernel and
64 bit userspace work.  Mixed 64 bit kernel and 32 bit userspace is
currently broken.  Since 32 bit kernel and userspace is probably pretty
rare these days and the data affected by this is not critical, Hence
we can go ahead with this patch.

Fixes: cf21e76a6005 ("drm/amdgpu: return tcc_disabled_mask to userspace")
Cc: stable@vger.kernel.org
Signed-off-by: Yogesh Mohan Marimuthu <yogesh.mohanmarimuthu@amd.com>
Reviewed-by: Christian König <christian.koenig@amd.com>
---
 include/uapi/drm/amdgpu_drm.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/uapi/drm/amdgpu_drm.h b/include/uapi/drm/amdgpu_drm.h
index 0a113529b..5beef3eaa 100644
--- a/include/uapi/drm/amdgpu_drm.h
+++ b/include/uapi/drm/amdgpu_drm.h
@@ -1517,6 +1517,7 @@ struct drm_amdgpu_info_device {
 	__u64 high_va_max;
 	/* gfx10 pa_sc_tile_steering_override */
 	__u32 pa_sc_tile_steering_override;
+	__u32 pad;
 	/* disabled TCCs */
 	__u64 tcc_disabled_mask;
 	__u64 min_engine_clock;
@@ -1541,7 +1542,6 @@ struct drm_amdgpu_info_device {
 	__u32 csa_alignment;
 	/* Userq IP mask (1 << AMDGPU_HW_IP_*) */
 	__u32 userq_ip_mask;
-	__u32 pad;
 };
 
 struct drm_amdgpu_info_hw_ip {
-- 
2.43.0

