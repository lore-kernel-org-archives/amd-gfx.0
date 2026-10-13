Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2DF9BCA9EC5
	for <amd-gfx@archiver.kernel.org>; Tue, 13 Oct 2026 01:34:16 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9379E10E701;
	Tue, 13 Oct 2026 01:34:10 +0000 (UTC)
Received: from PH7PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11010056.outbound.protection.outlook.com [52.101.201.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4A72610E6FE
 for <amd-gfx@lists.freedesktop.org>; Tue, 13 Oct 2026 01:34:03 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UCXBNZAgvl8RuM8PSomMtowFNkqFiOoP5LxR2X6sZw2hRJ2A+z9FjdlKwccnYSb6hu5YBLAu145gG32V+LPXuejR+yWFvBbDDgwMxxq9fll2U2vnscEmon7rSCZwb66aBUbwV88BEuvx6gDXsM9r6c5rly3QKQsx62OgEodhVtsb15wF1wqopU46tmcZL9WC8bxjRHJitqz/70TmtDNCRWrXUqJ5vEeFbjeA9J6q21W9UzYtjxdpOkPKxunl0dHrEX6zskbkMua+gKwSVi4t7Jm2fEan/sVkIP+5DyDjWnaJZOqtMWHy/6bT564TQMbVNktgzfSZQEnX6KRqdt0hdA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=STg5Y0x4QyvKNHcAIT59tuqQvG8bEdoZOsKEaSzIl0Q=;
 b=XXtlTDSdwN7q8m0XRnc0tHArVWJqtzFjJ4qHD5gWHdMgAaew9dP5XvsMoHkBvVx006kQ1NivPuBye/3deWQSkYyJpb5tzo4aBqJeLGUIkRX/Qq0rOlQlJ2NaMhAQI5EqQm5A5Uvu7r2kJcKfgyCftsJPLU27xYpz9NmimZDDxjcEraQVokhASOy91MZJ192MCSovOrcFJiFt06KeeH+N2/Xbje88FU25uWSRwyNXQOwdXg9d6Ol1PgHTEOz2ka1i3ksb4cVZKAHAS5NZodVevnkfGFLPOymNsQVntYGA8rhNUbQK4P0WfFEuJufODPd8DIhXdu7BBK0OyixlPCwTTw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=STg5Y0x4QyvKNHcAIT59tuqQvG8bEdoZOsKEaSzIl0Q=;
 b=YNan6r7oXj9tjbW8JmEeG0xvyldWm7B2TvaqYuUgQ0HR86C88JyBWbRV8amHW+iWiU/AUHL1VvfjQcuWDJ6N7pBpaniEkGxWA7ItXYbkwZjUNDZnqEfDlwgxcayrJqXk2jgSSc2Q+Of4UtBMTYeeRHNl6nI/vryIFI5/RkPWM4k=
Received: from BY5PR04CA0028.namprd04.prod.outlook.com (2603:10b6:a03:1d0::38)
 by DM6PR12MB4139.namprd12.prod.outlook.com (2603:10b6:5:214::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.496.19; Tue, 13 Oct
 2026 01:33:57 +0000
Received: from SJ5PEPF000001F7.namprd05.prod.outlook.com
 (2603:10b6:a03:1d0:cafe::a9) by BY5PR04CA0028.outlook.office365.com
 (2603:10b6:a03:1d0::38) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.472.20 via Frontend Transport; Tue,
 13 Oct 2026 01:33:57 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ5PEPF000001F7.mail.protection.outlook.com (10.167.242.75) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.522.6 via Frontend Transport; Tue, 13 Oct 2026 01:33:57 +0000
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Mon, 12 Oct
 2026 20:33:51 -0500
Received: from JesseDEV.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.53 via Frontend
 Transport; Mon, 12 Oct 2026 20:33:49 -0500
From: Jesse Zhang <Jesse.Zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, Christian Koenig <christian.koenig@amd.com>, 
 <prike.liang@amd.com>, <sukhatri@amd.com>,
 Jesse Zhang <Jesse.Zhang@amd.com>
Subject: [PATCH v2 2/4] drm/amdgpu: report the BO alignment in bytes in
 GEM_LIST_HANDLES
Date: Tue, 13 Oct 2026 09:33:36 +0800
Message-ID: <20261013013347.2015715-2-Jesse.Zhang@amd.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20261013013347.2015715-1-Jesse.Zhang@amd.com>
References: <20261013013347.2015715-1-Jesse.Zhang@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001F7:EE_|DM6PR12MB4139:EE_
X-MS-Office365-Filtering-Correlation-Id: ed5ad307-3804-4efc-804f-08df28ca0cdf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|82310400026|1800799024|36860700016|23010399003|11063799006|56012099006|22082099003|18002099003|261009223027099003|10067099003;
X-Microsoft-Antispam-Message-Info: BdYNEo3SWzFtn6iQOpXXLakpnBd36bMDVmpUkFhweqedJzJCLzVCi+uhlOOYK7nBaAsHvnQGJns+R2XEM1lbbB5rfJKHG/dmLr+kkbtd/Hi/hmk672Do9vLHh2DLr1iuwQPrPhm2S1XfZ4zEUIUugViIwIY0SB5QbjPFg1yZQ7EvTtmkAE4n2M58C0Q5eBuyq1Q8LNPnjRcAv9N3RVKnDeSSF8E04vFjrGNQQGYvs0fv7wit98OC9Vf4jlywV9h1TFqfUuZPvdgELy5tUH1jLs5X094vVke1qMzbL/TPBdHMkW1SULh7lQ9R3rwI3Yg/HA7SnYZpsLg3VHy6jLSFcJjw6cCPntEPIYRvFLIXD5SyCUN+LvkwCuu9bDbRAoVbU8u+XWEmbObmFOtDsmPuZLgtaBrMg1peofTgMPTgMFNDFNH3Y2hRiVYAh4oP28/526qeMkSREyn75Xc4A47c7zrUCWogce0EYwBd36U0swG3Da/BwdlQdKYCf/FAZK6HTkSemIjvEcAp09/8culzCgJ5efVrWVw8GOWm0yTwUubnu9u8xRIvylDetvlg0jzHkHrCBDOCUGCkiaHG08mwLw2kPkdtdo5IXTEjUXhBOvCur7O+OXosxrYkhTf+VsHwze/Vkx/JPMnsWskF6A0XbOJo6dIWKFSrvLPHGsX5jm/mGFaYS+36xctq3Uf8Yq8v0Pi6ajRdbjoKeyimoSie2w==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(82310400026)(1800799024)(36860700016)(23010399003)(11063799006)(56012099006)(22082099003)(18002099003)(261009223027099003)(10067099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: zO2zKADZN3xsQKnPMWl0b+SGk1rUn3IbVLbhz/Oq8vsat5pyhxzSJwRLD22DZZordoMKUixuik/OMQZkMbyMCLmSpECG5VjAdANyXlGGvRyMyMqPMhSEGIzv4kQZRNXBv1IpgSbTIH00IzGLpg1IXYs6FqwZX7fcZHDb6r9IhtNjUgSJ+BRO+DmHF5m0M9NEkgH24VdDjN1/+XpBSN8QZ76eogAk4rRjlfxhomu++03IKzE0aftMFBpbqMM8S3+SzK2qFkxgVeyobIeoje3C9KRFlLHjZH8XkRx3HgjGO70yH6d76S7aTe9uSsLO8DbgTiHAzSvdVAbt3rywj/gsj6p0Dy55oSZVxWUd7eujC4VU3MlA0h+OmuTfUhH5o2Jmpq8p9/cJtjaMot146cQU/nXJZUyaM+B4ZxoRjp0p02AKUDwuP91Plyu3zvQtVXeE
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Oct 2026 01:33:57.3356 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ed5ad307-3804-4efc-804f-08df28ca0cdf
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ5PEPF000001F7.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4139
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

The uapi documents drm_amdgpu_gem_list_handles_entry.alignment as
"physical start_addr alignment in bytes", and GEM_OP
GET_GEM_CREATE_INFO returns the same value in bytes, but
GEM_LIST_HANDLES returns tbo.page_alignment, which is in pages. For a BO
created with a 64 KiB alignment on navi31:

  GET_GEM_CREATE_INFO: alignment=65536
  GEM_LIST_HANDLES:    alignment=16

so a user such as CRIU that recreates BOs from this list uses the wrong
alignment. Convert it to bytes.

Fixes: f9db1fc52ceb ("drm/amdgpu: Add ioctl to get all gem handles for a process")
Signed-off-by: Jesse Zhang <Jesse.Zhang@amd.com>
Reviewed-by: Christian König <christian.koenig@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
index e791d066fd47..8dbd7bb77305 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
@@ -1281,7 +1281,7 @@ int amdgpu_gem_list_handles_ioctl(struct drm_device *dev, void *data,
 		bo_entry->alloc_flags = bo->flags & AMDGPU_GEM_CREATE_SETTABLE_MASK;
 		bo_entry->preferred_domains = bo->preferred_domains;
 		bo_entry->gem_handle = id;
-		bo_entry->alignment = bo->tbo.page_alignment;
+		bo_entry->alignment = (u64)bo->tbo.page_alignment << PAGE_SHIFT;
 
 		if (bo->tbo.base.import_attach)
 			bo_entry->flags |= AMDGPU_GEM_LIST_HANDLES_FLAG_IS_IMPORT;
-- 
2.50.1

