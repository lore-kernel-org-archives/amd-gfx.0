Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 69228CA6012
	for <amd-gfx@archiver.kernel.org>; Fri,  9 Oct 2026 09:08:41 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DA98710E02D;
	Fri,  9 Oct 2026 09:08:40 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="WLVf51zN";
	dkim-atps=neutral
Received: from CH4PR04CU002.outbound.protection.outlook.com
 (mail-northcentralusazon11013055.outbound.protection.outlook.com
 [40.107.201.55])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 41DA210E02D
 for <amd-gfx@lists.freedesktop.org>; Fri,  9 Oct 2026 09:08:39 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MyliQ3LkIN29nliDmyoQIETbp/K+hv2okJje3GYXYZqM+Xr7dtQu0CgKjDLZLhjdCiVIPTKW0BfIa9Pl2F7rrvzaO13VxCWN48HOq7mCRvWCdndJ5y5miH2ONFputp7Q22TBns8/y1f6fQBV4hbv/kVVwGrlWIJIn36p0GDsbM3NTmYVA6sUd/YrdUTr+oka0L9xBpZaS+fRUJD9iXJIOMN72beLGbCV/MWZx2Ax3Tc61+vukK+gvcDr7i0y4QnzVHh0I4KrtwNpGe/yTY60wO2wnyHCZ/F9TtHK8Rzl/LlBu5N18EAF3I6UwtJ/aJ99jP2Fo3QK6pGno1Pm0uvN9w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ja5PmQpx4VZH9rhVgxDRRUUbgk9oRa8/BX3qu1g78S8=;
 b=GOlHxR6VBDqfWQmam2Vgl7znWAlWzIYLOaDsyV4Vsp3isEv5tnob9+dy3uUEkNyzy0czCGQ8URtRdJNAOIUrMTJExWtb2uIAZ1+z6uwrHcodDSlU2pn64XqZC6IBLSqpOv7zyUueQ7/d77b9wnxx9dNRaRP/ROVexuYmxWEgVOcskV4fPDHmkZi4uOWQkz/WRyguuNQDDXNYYIYoQ+aA+D2WIX2k/CO2gyWGi0WS4dyqpmlw7fz0XvpwLu48/syiSeZUaqSFtxhSDU4nwMq4soC/MtlxJYCO9gr+abJBclGuSxKNHoDxDvc4X3Td5SofgtKG/oOGMXJurwYq5wvuTg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ja5PmQpx4VZH9rhVgxDRRUUbgk9oRa8/BX3qu1g78S8=;
 b=WLVf51zNVl31p1JfQW7Cn4D+tQTGwfr5xIzSv66Nxv1s1U8uYEZN51YeFMY7DPxdumbx+ImWajtiogebN7z6p+IKGwBKgJAUGPVCWc+prtlsh54C2JsUTviB7mzRHXttmHiyS9kRCPz52FyI1IiMMXcv2ZkFQinps2fxJN25ePo=
Received: from CH5PR04CA0012.namprd04.prod.outlook.com (2603:10b6:610:1f4::28)
 by SJ5PPFCB5E1B8F5.namprd12.prod.outlook.com
 (2603:10b6:a0f:fc02::9a1) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.496.17; Fri, 9 Oct
 2026 09:08:35 +0000
Received: from LV8PEPF0000005F.namprd02.prod.outlook.com
 (2603:10b6:610:1f4:cafe::71) by CH5PR04CA0012.outlook.office365.com
 (2603:10b6:610:1f4::28) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.472.20 via Frontend Transport; Fri, 9
 Oct 2026 09:08:35 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 LV8PEPF0000005F.mail.protection.outlook.com (10.167.245.137) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.522.6 via Frontend Transport; Fri, 9 Oct 2026 09:08:34 +0000
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Fri, 9 Oct
 2026 04:08:29 -0500
Received: from JesseDEV.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.49 via Frontend
 Transport; Fri, 9 Oct 2026 04:08:27 -0500
From: Jesse Zhang <Jesse.Zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, Christian Koenig <christian.koenig@amd.com>, 
 <prike.liang@amd.com>, <sukhatri@amd.com>,
 Jesse Zhang <Jesse.Zhang@amd.com>
Subject: [PATCH 3/3] drm/amdgpu: free the userptr ranges when a CS fails after
 parser_bos
Date: Fri, 9 Oct 2026 17:07:40 +0800
Message-ID: <20261009090822.4095122-3-Jesse.Zhang@amd.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20261009090822.4095122-1-Jesse.Zhang@amd.com>
References: <20261009090822.4095122-1-Jesse.Zhang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PEPF0000005F:EE_|SJ5PPFCB5E1B8F5:EE_
X-MS-Office365-Filtering-Correlation-Id: e50c9050-b1dc-4f11-fd3b-08df25e4e596
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|1800799024|23010399003|82310400026|376014|5023799004|56012099006|11063799006|10067099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: QY1ZRcy1G9hQC1Ry1IFRV5JRHmsRB53iMN2eqOGg/0+p6RQa3JRn+Cjn7IAeorXABqfOomNOLRX/f69eHmfdg+iZDY1zgrPDZR8O/bmp9bxBDayXJLPNSnImUj31HoydfnOdyV9pGCwxb2jmNgXBgOKSObVTOdIMw+/HgXi+qR/GH1QqS5E/Zooq7fWtwVoGJj0J071CopUaDO5aIlCPWZG2cPFLVUDecgmblkCl04LtDHtQswxdttT+UyY+BeRokWbOzLskRFaP2eYgtYOO6S4wYdOtrkjcpTCAA3kgmeQUrTzFtr/dvj1ePyxtWbIPrz2QLDreY5f4vLa6L28gVJcQNHxikOWw6IOP6SU+JOov+qQ4QlH1cZ2Rn1df1AI3Bwgv0fewZssrG1fG6AYV9lp9DaO4eZ8Gopy0cJ5qMtnbAvokHdx84EGHWyWnoSjBTGghgkoV7rNYMO0bQhE8Zwu9ayFpJoZchccWq/NvF8z9qUlDTodlnPJXqKFBaxWEuisW1hD34mi+fgrd6tezkQiHR8QAnVA7K+Hx558iz7XaN3gexg590/wNJCzlodgk7SfOWFER8rPzPqmDYKqrY2XltGTYJM3TaPgZCTM7DrWj1Lykk3akncBBRQCKKHVu2ux1oP4X7KoQBywisEN9YhiuBxTdkHoALPNUXNaSdixULo2o/adLa7S9gBQf0uVcHOPYj4n9fzj7iDrhgXsEHQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(1800799024)(23010399003)(82310400026)(376014)(5023799004)(56012099006)(11063799006)(10067099003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 5kqZBXtHA/8i/93iillSYogbavJkssK6kO6kYd+pHFSv3L2OuoEPBqBxtU6g2tBkT80aT1ikVkQ1LxcEedQoiuXF+N8u39eyFPSaf5XFUJj8B2v3bObUGF/IqEuNKUvKqKdwf/Chvs3/K8NWTbcBUfEeznxdoufE+VnI0PEyrKuH56lFiRlbNh/4UmKj5Tb9YmNlnfN1hLEcIXxXCHiYWADhx9oOmAUPnYse5e0F4r178ohEmDxxCzn3FwMCT/hvKH7R7wMTRtJrPMbBoDR8N2RjG8G5/kFRMmDkKVp+9fwEoQl/x+6ypGSe7+OM8eYGH3sTnRy5wiBGGrQFrYviEg0IbtBUGpb0IxyWIxhXzOibxhzi7t+ltNFopqh09+ii0fgdXuosgWGg8BLmHEkGAiCH8VTj4nD6YZW9dZP/NoD8BPQJD84cy+RvRm3S7SFI
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Oct 2026 09:08:34.4116 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e50c9050-b1dc-4f11-fd3b-08df25e4e596
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: LV8PEPF0000005F.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ5PPFCB5E1B8F5
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

amdgpu_cs_parser_bos() allocates an HMM range for every userptr entry of
the BO list and looks up the user pages. Those ranges are only freed when
amdgpu_cs_parser_bos() itself fails or when amdgpu_cs_submit() checks
them under the notifier lock. If amdgpu_cs_patch_jobs(),
amdgpu_cs_vm_handling(), amdgpu_cs_sync_rings() or the early part of
amdgpu_cs_submit() fails, nothing frees them: neither
amdgpu_cs_parser_fini() nor amdgpu_bo_list_free() touch e->range.

Each such CS then leaks the range, its hmm_pfns array (8 bytes per page
of the userptr BO) and the BO reference the range holds. An IB on a ring
that patches the CS in place (e.g. VCN) with an unmapped va_start fails
in amdgpu_cs_patch_ibs() and takes this path.

Free the ranges on those error paths. Ranges amdgpu_cs_submit() already
dropped are NULL, so freeing them again is a no-op.

Fixes: fec8fdb54e8f ("drm/amdgpu: fix userptr HMM range handling v2")
Signed-off-by: Jesse Zhang <Jesse.Zhang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c | 15 +++++++++++----
 1 file changed, 11 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
index d059e0c92866..d3c1b4b9472f 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
@@ -1435,6 +1435,7 @@ static void amdgpu_cs_parser_fini(struct amdgpu_cs_parser *parser)
 int amdgpu_cs_ioctl(struct drm_device *dev, void *data, struct drm_file *filp)
 {
 	struct amdgpu_device *adev = drm_to_adev(dev);
+	struct amdgpu_bo_list_entry *e;
 	struct amdgpu_cs_parser parser;
 	int r;
 
@@ -1475,25 +1476,31 @@ int amdgpu_cs_ioctl(struct drm_device *dev, void *data, struct drm_file *filp)
 
 	r = amdgpu_cs_patch_jobs(&parser);
 	if (r)
-		goto error_fini;
+		goto error_free_user_pages;
 
 	r = amdgpu_cs_vm_handling(&parser);
 	if (r)
-		goto error_fini;
+		goto error_free_user_pages;
 
 	r = amdgpu_cs_sync_rings(&parser);
 	if (r)
-		goto error_fini;
+		goto error_free_user_pages;
 
 	trace_amdgpu_cs_ibs(&parser);
 
 	r = amdgpu_cs_submit(&parser, data);
 	if (r)
-		goto error_fini;
+		goto error_free_user_pages;
 
 	amdgpu_cs_parser_fini(&parser);
 	return 0;
 
+error_free_user_pages:
+	/* amdgpu_cs_submit() only drops the ranges once it got that far. */
+	amdgpu_bo_list_for_each_userptr_entry(e, parser.bo_list) {
+		amdgpu_hmm_range_free(e->range);
+		e->range = NULL;
+	}
 error_fini:
 	amdgpu_cs_parser_fini(&parser);
 	return r;
-- 
2.50.1

