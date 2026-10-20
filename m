Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9398760A380D
	for <amd-gfx@archiver.kernel.org>; Tue, 20 Oct 2026 08:38:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=1DOzeGNR
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 23E0210EB7C;
	Tue, 20 Oct 2026 08:38:29 +0000 (UTC)
Received: from CH1PR05CU001.outbound.protection.outlook.com
 (mail-northcentralusazon11010009.outbound.protection.outlook.com
 [52.101.193.9])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C236710EB91
 for <amd-gfx@lists.freedesktop.org>; Tue, 20 Oct 2026 08:38:20 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vcBMfWuV/eGPSRyXyEuoGe+cXMFE+S0ysrDE2x02wJNFysITEMGDg+yhzQVWipiN3pI+mjbk459Z0eH0LAIo+aITzpG4Ou4viM3GAm/wxnNGsMiVHYOmH2awTo4RqkiDQkSVvtPazYcytY5xzRmkMpN40r6D0DuJPXL2W7GtzzC/7vadFlict8IOvrXedhnH++/STBjsDixWwQ4Iq+yZJSRjENuStuokxtFFONRX/gAxtF2alj+An5bYdfLVQ4Ao05By/Cmt3xWAYL4+ECcr6wVsnVEpdiyc+/VQbLAFlPIN/KZz3yO+XUUJyav5kb9EEk4otYZko9zUb+slvMMGQQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JojZpbhMUcXd9J606GQ1YPmz9Z6vQeFSjF2rgUPkKwQ=;
 b=KmWYscy4jVWtyNvgXRdJpHgSuzErc3UiwjsRoTkNfJLewQeXVw1EWdbPSJnenzQBjuKPhQX8ZDDuca1QhZp0liJ4PWxzda3Z6+QRdTWXNYUoPk72c1EwWMI1ZwMiMEIhLGPdIi6GL04cmrg9Ywy45BgUpkV3GNxq1MdhbMZ+OJuqrPsxA8dn4BLGkFQHgK1waNUeivN3zXhAyKyUCOgE/54fsu1q0z1sd2tixrd7l2Ot+PxpDduR7CiyayhDDHTkvrzr2nSG0dF30q+jEdLaDAceOat0iLX+XulkfypdkHOxum+oBn4/3FCvyZKknaZ+YqG+ufmf9J/Mot4Wxvfszg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JojZpbhMUcXd9J606GQ1YPmz9Z6vQeFSjF2rgUPkKwQ=;
 b=1DOzeGNRghfM2RBZQ9AxJoAdg7YRVfpyDPMkQfcYKsj9W+J18yA/XieFwP4IOGaPM8x3T4CfWBOsd45DPftQt+N1M1JIKeoJiG6bYUYypgHohhbGcCrFDHz4bdddTBQ+5YftubIXUWhAgaqy8bIi7A3OYmhsoepBHpYbYVUCrS8=
Received: from DS1PR02CA0023.namprd02.prod.outlook.com (2603:10b6:8:44a::19)
 by CY3PR12MB9577.namprd12.prod.outlook.com (2603:10b6:930:109::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.14; Tue, 20 Oct
 2026 08:38:17 +0000
Received: from CH01EPF000BE946.namprd02.prod.outlook.com
 (2603:10b6:8:44a:cafe::aa) by DS1PR02CA0023.outlook.office365.com
 (2603:10b6:8:44a::19) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.522.4 via Frontend Transport; Tue, 20
 Oct 2026 08:38:17 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 CH01EPF000BE946.mail.protection.outlook.com (10.167.244.138) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.522.6 via Frontend Transport; Tue, 20 Oct 2026 08:38:16 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Tue, 20 Oct
 2026 03:38:15 -0500
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb09.amd.com
 (10.181.42.218) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Tue, 20 Oct
 2026 03:38:15 -0500
Received: from JesseDEV.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.53 via Frontend
 Transport; Tue, 20 Oct 2026 03:38:14 -0500
From: Jesse Zhang <Jesse.Zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, Christian Koenig <christian.koenig@amd.com>, 
 Prike Liang <prike.liang@amd.com>, Sunil Khatri <sunil.khatri@amd.com>,
 Jesse Zhang <Jesse.Zhang@amd.com>
Subject: [PATCH 3/3] drm/amdgpu: reject CS chunks too large for kvmalloc()
Date: Tue, 20 Oct 2026 16:37:10 +0800
Message-ID: <20261020083804.2777099-3-Jesse.Zhang@amd.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20261020083804.2777099-1-Jesse.Zhang@amd.com>
References: <20261020083804.2777099-1-Jesse.Zhang@amd.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH01EPF000BE946:EE_|CY3PR12MB9577:EE_
X-MS-Office365-Filtering-Correlation-Id: ed8fea5d-8a53-4255-d925-08df2e857c56
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|23010399003|1800799024|82310400026|36860700016|56012099006|11063799006|261009223027099003|10067099003|22082099003|18002099003|6133799003;
X-Microsoft-Antispam-Message-Info: otM2TVAqEHKBi5s9Eyz1LJfm9whWZp3vFsLyRE04OiNVIHGhQmsaNTnfH9BTPcVWW3E3ZH2NhnqkNaMj/cxv86SoYd6QpJeN0vl6HnSW7+rdbLCsFIuY0Egd9mM3lXk1WEs5JcC8eQCavgoFkehy+yHFXvaB3vsOqwNozAx6Y483w2etPSrd0TdxVYKzRhy/G5e5ns6MSiNnFUoPBIZ4JYMTFEt/dvoDuepCu8K5JmJPMk/ciHfH5OtnYszeVELmij8kwTtwA+o8SnQZoatMjuYIkalUOfeTlxy8GewjzJH0F6a1yy3Ot+1RJBnJxyjIL0FPFvz+q4noWviMZbRccavX2NwPeke2O79rxlU5I26KAsuYWWMDUBlWtYyr7nvJnzelPt0RxpS5lGLDGt0hOM9FGJHqNrAHhHwzmkki7M5hxrAniFTpC9w4pGcRr3hMIRD/jxaItvoWkmnZayJdCXoaZw2iBc47qkODOSQSV23KGUXrgADYA8CHtgGsZaBl2xwXtraQco2esJnMzKrqEa7xL1O6h3IqxF4KdaWRfwXZGUL+5E/z4AlXwIRQ8fceB222M6m+wyn3C2brE+mU7PkCj+RrZEPjW5reI4ORd8E+XofE4Qa7lv7eZBs+45cjxntjC3J+RmH9wglD88T6AfbJu5CCxWMpU1NKokf1cIjpT7lbned7nJWaG7zLBJHbocbxOIGmlEH0mBs4fNTejQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(23010399003)(1800799024)(82310400026)(36860700016)(56012099006)(11063799006)(261009223027099003)(10067099003)(22082099003)(18002099003)(6133799003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: ooTMhM8NIGrisVe//SNdi9v7GiN1fL69mRoH3q/uJzCmGK0N7FcEIp4rtgN8XIbVgk5ne29zB46R2NMthqof1JI7+Vg3mgumUGp0pCI+C5bq3Jmvc9QDiQF+VBvlO4GFJBkZswLKOQoa91QxEVJedmvsiUieSaQpvdpQi4haJOXYQnY8udmjIr6vVl0l3NnrwLqQT2m/d926mmWV/24dqKKwlXcXN2TtHSah9AsaL97ocBIZUrAdMaZdrN7VyytDyCnAldqQKY80qlb3L4VHVneH76naohAjjExL4xyOsRBPAsH0Sm4JQaSvzpqLZtbaL5IEBA5s9Irt6Obt04d0MoYZ0UhUlPTQJChq/rT7dnnvoaznL4EMWYcLMIvgtOrqLpXY0L6dBfEoVvS/BIFb28YCUn5Buo+9SDSzFPsqRiyvaW/HOSXzgiAY081y1loK
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Oct 2026 08:38:16.0951 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ed8fea5d-8a53-4255-d925-08df2e857c56
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH01EPF000BE946.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY3PR12MB9577
X-BeenThere: amd-gfx@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Discussion list for AMD gfx <amd-gfx.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/amd-gfx>
List-Post: <mailto:amd-gfx@lists.freedesktop.org>
List-Help: <mailto:amd-gfx-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/amd-gfx>,
 <mailto:amd-gfx-request@lists.freedesktop.org?subject=subscribe>
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-19.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

The CS ioctl copies every chunk with vmemdup_array_user() before it
looks at it, for whatever length_dw userspace gives. kvmalloc() warns
about allocations above INT_MAX when called without __GFP_NOWARN, so any
process with the render node can trigger a warning. On navi31, a CS with
a chunk of length_dw 0x20000000 returns -ENOMEM after:

  WARNING: mm/slub.c:6841 at __kvmalloc_node_noprof+0x5a5/0x7d0

Reject such chunks with -EINVAL before trying to copy them.

Fixes: 2098105ec65c ("drm: drop drm_[cm]alloc* helpers")
Signed-off-by: Jesse Zhang <Jesse.Zhang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
index 62758866378e..649bf0947e68 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
@@ -221,6 +221,13 @@ static int amdgpu_cs_pass1(struct amdgpu_cs_parser *p,
 
 		size = p->chunks[i].length_dw;
 
+		if (size > INT_MAX / sizeof(uint32_t)) {
+			ret = -EINVAL;
+			i--;
+			goto free_partial_kdata;
+		}
+
 		p->chunks[i].kdata = vmemdup_array_user(u64_to_user_ptr(user_chunk.chunk_data),
 							size,
 							sizeof(uint32_t));
-- 
2.50.1

