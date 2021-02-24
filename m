Return-Path: <SRS0=z84W=H2=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F01E9C433E0
	for <amd-gfx@archiver.kernel.org>; Wed, 24 Feb 2021 22:22:29 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A4B9C64EDB
	for <amd-gfx@archiver.kernel.org>; Wed, 24 Feb 2021 22:22:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A4B9C64EDB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 51BBB6EB94;
	Wed, 24 Feb 2021 22:22:29 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2052.outbound.protection.outlook.com [40.107.94.52])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D63CC6EB91
 for <amd-gfx@lists.freedesktop.org>; Wed, 24 Feb 2021 22:22:27 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RnUrx/YjNrBvVgRZC6fj7OXQ394rMah0KMAdQl6L4uMFgoFwWzC+bf3//NLhgtDkMK+N8WX/zwwZr1nNOICet2V38VBNcDiGFK5i3xuLhaxk1lUsIg4lwfAcry4JRJ+l2Y46TzmyiMb2sn5iSzYG/NFKtu4GmsnOXyKu9V5haAYWHoPOanuWPbUyRkO1SitCYZQTF5utvoFAjWrVQqS+vQRoWiGtaK7JTgDbAG3q+TX4cgZ2oa3j2rW8okaqgE3z12Tmmq0H53tO9Jbj6WJqZaSzT7oBk7nbGNikrpCT5HfNwYrHmZpGi54LWDVvpGEH0JGQ6RzEuN0tO/2jTpM44w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9aKMDFUJY0Gv6qXUYqw2x4glGvE/Rj9YSr2L36/kEYY=;
 b=fsiA/sCwuNxCqeeh+RUp4W9mYeKt7Xg2Kz+FT1LuX6YoVPaQAOPl9a9AhxJSU094Mg1rXI18jtB3nVfHjrBKylj20TrBS34JF1Eq1K41kMP8nIhn8IELcvcPTOsEowB4MsDnbkNDGVJmmznNKdWEN4fQB3xlmUtVmOyf/Hw0kocEaUm7BOFZUC2UnbSy001zU3lt1d3FStPy7vfKMpjd+l459jRubZSZ/Y7VoMdgmd9Mo0a22Wl7ULI9wMJOxFMmeOlCf2IWCWR2zR5QvZKXaO32Elsa/O3g+ARhHJ7xzXtQZh85pNlDmsrnBADe4YOaIXBx6gjRsmbdjovgJbz/rg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9aKMDFUJY0Gv6qXUYqw2x4glGvE/Rj9YSr2L36/kEYY=;
 b=fvzVxnMisQ7376AtxkxqzbAtBVgm+YwpkJBEbKCAdi0nGlvH0vfWhiBHQPIt2LzfThWzs9DOVauahXi7rr0Ads44hd500NTK4GhVumpV8SpIR1DWCsyn5p42N7mEvyj2xbdnKiKgujaGWEy94rykzjOtIGBIImfeCF1uo2iRj2g=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from MN2PR12MB4488.namprd12.prod.outlook.com (2603:10b6:208:24e::19)
 by MN2PR12MB4503.namprd12.prod.outlook.com (2603:10b6:208:264::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3868.30; Wed, 24 Feb
 2021 22:22:25 +0000
Received: from MN2PR12MB4488.namprd12.prod.outlook.com
 ([fe80::b0c4:9a8b:4c4c:76af]) by MN2PR12MB4488.namprd12.prod.outlook.com
 ([fe80::b0c4:9a8b:4c4c:76af%7]) with mapi id 15.20.3868.033; Wed, 24 Feb 2021
 22:22:25 +0000
From: Alex Deucher <alexander.deucher@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 129/159] drm/amdgpu: Modify comments of vram_start/end
Date: Wed, 24 Feb 2021 17:18:29 -0500
Message-Id: <20210224221859.3068810-122-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210224221859.3068810-1-alexander.deucher@amd.com>
References: <20210224221859.3068810-1-alexander.deucher@amd.com>
X-Originating-IP: [192.161.79.246]
X-ClientProxiedBy: BLAPR03CA0027.namprd03.prod.outlook.com
 (2603:10b6:208:32b::32) To MN2PR12MB4488.namprd12.prod.outlook.com
 (2603:10b6:208:24e::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost.localdomain (192.161.79.246) by
 BLAPR03CA0027.namprd03.prod.outlook.com (2603:10b6:208:32b::32) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3890.19 via Frontend
 Transport; Wed, 24 Feb 2021 22:20:50 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 514d8942-abd8-4996-fe54-08d8d912714a
X-MS-TrafficTypeDiagnostic: MN2PR12MB4503:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MN2PR12MB450375B3D5F9DE6A291F5C62F79F9@MN2PR12MB4503.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7219;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: i8f36brYGn6SOW3/SSfmQU7qusoXsd+qOUOOs1hFcOm8gpA5929sRR64lHbrbtyLRtUVZwSiorkMr0+C3n+FXKBsYNuPgnjuHPtWLrBe+yLvJuRUO0eS4u9Bl7Icy7/jiUFm2K/9WHWpxJ5Yl2GKdlO13D/VJ7ZzFB4PISd0Cc0jfgwiNushb/oOC8NaVWUGJYyidtAQhCAgHS/v/bGGV0kbm2laqzG2+ET+V0fvWDDpGVLphxMCFx+JPiJJRyz7xwg8oE5lcdniTtswX/nDPEZlhN4XEe1CwTasOIMpidb2SI8XVa92wr+0VbhL4Sj0oLktQ8nTSlE9bZhRpW2Q3nGb+SZCUNEBIQNGOmq+hrPA2+woNpAoFnYmzNZ5Pym5IaGee9fXCPMvMW+A7MhRJyu+0+Q76x9cYUs6iB+sQlYuqLW66U6qc4CeI6/wCV8YMoOivujyDE55qmQIbUvgtP+eaw29HmRzbm+Jr0cnCgEoaXm/XCkAI0NXMiquKJ2VlYZz/78AdkyQ6Jt3+pLoRtXpcWMI4kjOEDOaWdaUf/6uY7Hs7D7Q2CTS6WSjNAGyHnPUAIUgHW9TY1TU/cGkng==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB4488.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(136003)(376002)(39860400002)(396003)(346002)(6916009)(52116002)(478600001)(5660300002)(1076003)(4326008)(36756003)(54906003)(6506007)(6486002)(6512007)(66556008)(6666004)(83380400001)(186003)(26005)(66476007)(8676002)(8936002)(2616005)(316002)(956004)(2906002)(86362001)(66946007)(69590400012)(16526019);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?ZBPe8UWPAHGqCxsaTu1pd6o5Cms2na6nq8BVFRKImUfdofDWt7u1OlwTOzMh?=
 =?us-ascii?Q?F6Em5TbEsXh2osKYpsQEd5cPAHYuTyD3D/d+16vJ5xUBzWbgfM3w8Z2l5AO8?=
 =?us-ascii?Q?Z8NKhfqp5qJbCjcnxwqUEJ+XgrxeG/Swh5nhFLE1LUaLwIH5ibOWHNtKiDpq?=
 =?us-ascii?Q?/ZqkIdR7smahbXCpDn3gJ28pbmxcvnG3LMgBIscu4omzwx9djFFEaQaovKoM?=
 =?us-ascii?Q?YIP+V2CJMdk9HloqXq69BXwa/Pd/S8pfkB+q6O4HVzt51Q5bZGyf7uHOYrbs?=
 =?us-ascii?Q?G6Yt99Txc117vL4RuQG55bZUbXQb3ZwevxEp+PPN9+jqW2oQGZ8b6wyNrwi0?=
 =?us-ascii?Q?x2lSYXeDawoqFgvPDIIy5ngUuLLB9HVaGMMFkPZF/KwUYQFYbhcgXSzSibBj?=
 =?us-ascii?Q?Y1UaC3auOWSTscCPipSmnoLOreA56Wrlbuthnd/7tvoU4WFprm9VvW50XiGo?=
 =?us-ascii?Q?/zXWcp09nqOMaTSoKB9F2gkTK0i9a6iS7+SzYxHNpDPMHrxwSxNtNKG2QR5M?=
 =?us-ascii?Q?HOjhdtqRmKnoXOmmNDClJXGamgukNBmUoTuhOHpOrQ/UwMIET/x0q4QeW6zT?=
 =?us-ascii?Q?f/IPUmwVMP8Y1qqb6brdRsIcj/HRhMyfEvF+Vv2ZfcU6bMDydg7UzzEovAHf?=
 =?us-ascii?Q?27ZPmZalvjJ5aA/fhH/sv40NxjtFMy7y/1xpSjqla2yPTLF4iSbob+n63JYh?=
 =?us-ascii?Q?ev3Y+h5ma++ehhHzJgYdPbM3nVj/+GroQOxOPDk0yrB2mHt6uKpXlL8uirX+?=
 =?us-ascii?Q?gB29mbMQmzvxNUgLZHP0qC4wwwC4wCeHodAtnSRdSY0Ewz3/mdww87MtUmCM?=
 =?us-ascii?Q?yiEpto1QXEUPvXz+vNpA4kcVqn/nBYzy4uIpqwuCJYtwpCrNhfvQoF5yznA7?=
 =?us-ascii?Q?anB5FRIgEhDmCTkPr+nFua0j1WvjrffOHyuI2JQXvsSKVpWH28xKAhvl3pgq?=
 =?us-ascii?Q?/O929Wqd+a5aFh7XpfUjeFK5w1HeG2dEA5lkKOv2gx/6gPHhJletKp8vDyA6?=
 =?us-ascii?Q?IBaLTl+OHbHOHrgp1AjaG5A1whiDltpY/DkFCfiZ0eCuPBndvdsnI2xCmNO+?=
 =?us-ascii?Q?8Ora3rxsPPhJOZ2kfLxPA/pnpRI+mdu9rLJcZhDCify7M2/AuK++aSEr4Bqx?=
 =?us-ascii?Q?+NcxFF/Ji54kxA1MnPHNfoSAQPCov2te1jq462XfytRo97gaazISd2e/Tcoa?=
 =?us-ascii?Q?23w0nTs4cmVzChLk7HGhdSFZApYKfAinrBSvSuxS0Ew9Hba2ZH8wkjZGrMWO?=
 =?us-ascii?Q?TralqHStaE1fh79/6ohBWgYsdCfKXC658y4xHO9fMP950bz0A14QONrJ1MTO?=
 =?us-ascii?Q?DADZOtkA7KQ/HzFLb4+hdwgI?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 514d8942-abd8-4996-fe54-08d8d912714a
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB4488.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Feb 2021 22:20:50.8394 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ItGMI5/pZRH7dsnsuzKsa41VTklGBPQ0IodQ3TfTSyaNgxDXLT2ZM9xCYe4zqEmPZ8ZT3A4Stx37WIFsB8tqUw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4503
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
Cc: Alex Deucher <alexander.deucher@amd.com>,
 Felix Kuehling <felix.kuehling@amd.com>, Oak Zeng <Oak.Zeng@amd.com>,
 Christian Konig <christian.koenig@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Oak Zeng <Oak.Zeng@amd.com>

Modify the comment to reflect the fact that, if
use GART for vram address translation for vmid0,
[vram_start, vram_end] will be placed inside SYSVM
aperture, together with GART.

Signed-off-by: Oak Zeng <Oak.Zeng@amd.com>
Reviewed-by: Christian Konig <christian.koenig@amd.com>
Reviewed-by: Felix Kuehling <felix.kuehling@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h
index 11c6977c0b35..f1a21e110610 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h
@@ -190,10 +190,13 @@ struct amdgpu_gmc {
 	u64			gart_end;
 	/* Frame buffer aperture of this GPU device. Different from
 	 * fb_start (see below), this only covers the local GPU device.
-	 * Driver get fb_start from MC_VM_FB_LOCATION_BASE (set by vbios)
-	 * and calculate vram_start of this local device by adding an
-	 * offset inside the XGMI hive.
-	 * Under VMID0, logical address == MC address
+	 * If use FB aperture to access FB, driver get fb_start from
+	 * MC_VM_FB_LOCATION_BASE (set by vbios) and calculate vram_start
+	 * of this local device by adding an offset inside the XGMI hive.
+	 * If use GART table for VMID0 FB access, driver finds a hole in
+	 * VMID0's virtual address space to place the SYSVM aperture inside
+	 * which the first part is vram and the second part is gart (covering
+	 * sram)
 	 */
 	u64			vram_start;
 	u64			vram_end;
-- 
2.29.2

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
