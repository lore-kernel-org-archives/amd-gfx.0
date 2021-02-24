Return-Path: <SRS0=z84W=H2=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12574C433E9
	for <amd-gfx@archiver.kernel.org>; Wed, 24 Feb 2021 22:20:26 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D0C2364E05
	for <amd-gfx@archiver.kernel.org>; Wed, 24 Feb 2021 22:20:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D0C2364E05
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2781E6EB41;
	Wed, 24 Feb 2021 22:20:25 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2060.outbound.protection.outlook.com [40.107.94.60])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E3E966EB3C
 for <amd-gfx@lists.freedesktop.org>; Wed, 24 Feb 2021 22:20:22 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BdpYQDhrx+URMsW9C+GvLnDq7D99/YhfBTlCLvdGr3i1biwvZIE7IyDSh4wMg5MXpWMwbdtbASk0RCoexKGB0YnM7mW7eZU4xzDL+3K65ZiV80wIW9lDan8L2dKw7iA+xdLCHbh6k1/Go0AnGrB0AOvbsy2sYJVp9SmakdEfpzuyhHG1pLY3OdZVVTvuXMrrdFwwoDwBg9Ed++/QpeitU8gRsZ3cqCvln1dOXqyTB0uWrXcWoBUHyFMOSbO/GEyNiCYe3VIKKbHDisHtk9J6dFT/36kDYq1dBdKXqfV9Z4bMIBlNF5h2DvtVbjL7GyrO7TSEX91B9S3yUyWsCWbqiw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0N8DJN/KLTUr8/PI1x6dkEIcRnhYfCSF+ZSJKupT5Yo=;
 b=CtmQLg20Q1zRlt61CHP6ummkAOmOtz7TjzEoHxnEaK1Y5AXarwRiLASItkkrKEQQXHc41w7fVhDBQymNjFmxAOWj7tl14afGh5gYezvDfTsIUd9CqbXLmqUxKXODksF0hFxqSJNzq0X62I6xtlAVwJG22Rx33aeU95jUCh8ZuRG74zQGtdDv+QVUJRC//h5XqSKUVjWsvPv2lVp6yJqx9HTe2b6gOqM2XMGxdxPpzoUNp3Qzqs2Sfkix1wMJqdBmXOf8Qq89YWnCS6/2U+i0QQOaBBseIiOT0P8RXyRbUPNqN9p+0BF4Uf9ZZnUKrxSvWh9a8DxIDMNLVLTeVwd4mQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0N8DJN/KLTUr8/PI1x6dkEIcRnhYfCSF+ZSJKupT5Yo=;
 b=klDNQC4Xl8rktsonQR17le6HHzMeIfSc7nW+OmTbRRljmheoUC1dkxR3cmCmxJzx0ugfKObjV5gLLkwUWleSLswfsDKMYV1eTx2feCtMZt6N7xgXkAhos02msUzT/WhVO5Hrcr2D4zYrSLMnD5HIqIIigH7VchBbuG7dkRqPbjs=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from MN2PR12MB4488.namprd12.prod.outlook.com (2603:10b6:208:24e::19)
 by MN2PR12MB4175.namprd12.prod.outlook.com (2603:10b6:208:1d3::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3890.19; Wed, 24 Feb
 2021 22:20:22 +0000
Received: from MN2PR12MB4488.namprd12.prod.outlook.com
 ([fe80::b0c4:9a8b:4c4c:76af]) by MN2PR12MB4488.namprd12.prod.outlook.com
 ([fe80::b0c4:9a8b:4c4c:76af%7]) with mapi id 15.20.3868.033; Wed, 24 Feb 2021
 22:20:21 +0000
From: Alex Deucher <alexander.deucher@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 050/159] drm/amdgpu: set CPU mapping of vram as cached for A+A
 mode (v2)
Date: Wed, 24 Feb 2021 17:17:10 -0500
Message-Id: <20210224221859.3068810-43-alexander.deucher@amd.com>
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
 Transport; Wed, 24 Feb 2021 22:19:53 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 8cf3f821-78ad-4993-2edd-08d8d9124fa9
X-MS-TrafficTypeDiagnostic: MN2PR12MB4175:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MN2PR12MB4175D6FD8D64ABADEBE04D52F79F9@MN2PR12MB4175.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3513;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: UC0A2xXMsDl3XuaGXTj+XvG+iJa9ZY002Gq+5y1cwWQ04d+x/CbJsUb/J7RbWgNTPfjB5rZos3bk2twJMxUqT/nyz6dXIIrR6aTbCAl0DGxpm0ovjfy/p8xwUSumbHJ47tCsO71nfVNzSDOKc1BkNTFAXGaDajrERrHb59hQzLlb+EFkr1WwFTr9I9lf3TheSYhlRdbD1/lPpt8M4RpG9kwLjBNwGids5sITiD2X9fbus3R5NldBEVg0ddYSrWszS1G7iClCHifT9atQBDRSDua5qBHKSEBeUb03Vmn8TjLm7PYBNyDGhviHDjYluZ1aISMSAOAnaoWL8R4sLMtinvvAX58l6W26GTRfeqJWc5iDv5UweLJYJXPIaVVDyz8PK4G9vamSgan91qoFpQ0DDXoqnqckr1z3VpelkhJZtyaHTr7JNd9qgg5vLrrRqiP3eKftgmoYAokNZH+uM0572ocIqo1dZJi81PvT8zPswZqnoRZbuCA1nYCg342tLrylKt16k1pPX0GuzwNSQ3faBDSSHFQIFoz9q3iTXaOa1vmcmbpx99cTr/Irhj6Av8LFOdqur/1jKCCBbU66jx2mMQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB4488.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(136003)(39860400002)(346002)(396003)(376002)(66946007)(5660300002)(4326008)(6512007)(66476007)(6916009)(26005)(36756003)(66556008)(2616005)(186003)(956004)(16526019)(478600001)(8936002)(6506007)(2906002)(69590400012)(86362001)(1076003)(54906003)(6666004)(83380400001)(52116002)(8676002)(6486002)(316002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?BmqZ7a/JV+XMZIQtJ8pfumeDkYEzBsj8GMpUb3UtvLKRMLQhmY9eYkDLqhPP?=
 =?us-ascii?Q?T4rtV+ANOG8shB3g0jZAK0Hx096HO/zMDYu0GSwG9e0sCDpdiVtAdpb9Ai/F?=
 =?us-ascii?Q?MvyVak3JnI1+mWsCWzJYxkPRNsuwRmeWmCdVXfn3Q0JBI3goNABEUjJhSgxJ?=
 =?us-ascii?Q?UxzzI2FNrox2QWML3ejmHhL/iNtOQPGSmWjKVHgpOWWLSHgFeO9ZQ8k1B8+S?=
 =?us-ascii?Q?5csDKXcETAe27ktOmxREhyLufip3qfXxQOw4Lt4rVkGCEqIMeC56/jUEIwgu?=
 =?us-ascii?Q?rZPKQL/HojDeh6BVpGySL+e1SSNMDdD5uaJRryyhzRU0Q4ScdCbZDJQrdk/R?=
 =?us-ascii?Q?KHjmHRr/SovpXsJinUNHBWGyJueiqXaC8/+bcFsiX3dC0N6RSabtAOjRhQ4p?=
 =?us-ascii?Q?vTJphz/yLMZ9TjVN3y0PKyKojGNDZdi6fb8tOHdZMz2rJIpFiMNgzIbv8uzM?=
 =?us-ascii?Q?8uun5nEdMG6czr6EwQrFicMa2Gpj6WrnanTTF0G3K9fcweSCcVqbHaLS0Dvn?=
 =?us-ascii?Q?7NziDc6lxSNr5Zon9a+xTXQtaQipbeGVYByyMm3MtRt41nKUtL63GZ+AXPbS?=
 =?us-ascii?Q?g77gDxtRqVz7H62vpX0Xg0mI1W/9w1LKtt6UQQQwI9gtp2jd6FSlb/ZOl5hZ?=
 =?us-ascii?Q?dbIXdyv81GfP2oxvPezfqUfC1J+GDLqDRzz38UrDrocEKz9FFWtaGFoxgoq+?=
 =?us-ascii?Q?zBeelrTPvQOv4mbmv87mNQJmBREV/PQKhX7gwUhSI9SjfQkC41Vd618jxu2a?=
 =?us-ascii?Q?Shd/TRXgzS59uS/fFtG1hkbNy9vnCDpMAqGFUd2llt1p38f2i3N0TAsp1seG?=
 =?us-ascii?Q?ilfSY0hXb2YxauW5T1uG33ym3wPBZDVlYDOAvRAuU7B2fQIb4TIDEAvxhnCb?=
 =?us-ascii?Q?CXUeeGoVZfj+3oj9rZqyg6s+2jZHXQ3Or59Ogzu9kqf8mpi/GUbJTkc42+rn?=
 =?us-ascii?Q?S0WQll9IE/R3tqGlChi7TZLn2NS8nlHESiEjLXRJ5ZiRppS34VYekyk9DUcf?=
 =?us-ascii?Q?WCQwaido2Cr5oXfn6t84IgEdmiSPKIre8R99s1TjEO4aS0LkDMq4H4B6jHTx?=
 =?us-ascii?Q?a/OehZTZnAyJxLZMoTX7xPDbKK0eKapfXIdKiMga7LC2GrcTVxjReaYrPuOw?=
 =?us-ascii?Q?i/Ov/lT9re6KEPYHtN8Me2FN52/9DSJcBBE75Iv6f4SRFSDq7OY7uL0hbtUV?=
 =?us-ascii?Q?XFW+GQ5l74vOKuDIqR7xF7061pi+WHhjFwkE/Q8EYzij//z0sJoxLdxa8UbH?=
 =?us-ascii?Q?KfpsM3bY6/3ujj/2IMTJsbhyjQzGXrfRyXpIf0/aWJSqKjlDrqZ52EsW/O0r?=
 =?us-ascii?Q?+ut9Fmny7SGpxYUKL4VdDmdk?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8cf3f821-78ad-4993-2edd-08d8d9124fa9
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB4488.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Feb 2021 22:19:54.4699 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kd7GgXjlilM9F5Yz6ViMgi7cw9DTf928FjwKC43iKQbC1RTnULb/N18pthGLJFTd1qIU+zWmhdH3HhGQJVt/7g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4175
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
Cc: Eric Huang <jinhuieric.huang@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>, Oak Zeng <Oak.Zeng@amd.com>,
 Hawking Zhang <Hawking.Zhang@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Eric Huang <jinhuieric.huang@amd.com>

v1: new A+A HW supports cached vram mapped to cpu (Eric)
v2: switch to range manager init functions for xgmi
connected host case (Hawking)

Signed-off-by: Eric Huang <jinhuieric.huang@amd.com>
Reviewed-by: Oak Zeng <Oak.Zeng@amd.com>
Singed-off-by: Hawking Zhang <Hawking.Zhang@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_object.c |  7 +++++--
 drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c    | 13 ++++++++++++-
 2 files changed, 17 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
index 0bd22ed1dacf..c02e28c0683d 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
@@ -136,8 +136,11 @@ void amdgpu_bo_placement_from_domain(struct amdgpu_bo *abo, u32 domain)
 
 		places[c].fpfn = 0;
 		places[c].lpfn = 0;
-		places[c].flags = TTM_PL_FLAG_WC | TTM_PL_FLAG_UNCACHED |
-			TTM_PL_FLAG_VRAM;
+		places[c].flags = TTM_PL_FLAG_VRAM;
+		if (adev->gmc.xgmi.connected_to_cpu)
+			places[c].flags |= TTM_PL_FLAG_CACHED;
+		else
+			places[c].flags |= TTM_PL_FLAG_WC | TTM_PL_FLAG_UNCACHED;
 
 		if (flags & AMDGPU_GEM_CREATE_CPU_ACCESS_REQUIRED)
 			places[c].lpfn = visible_pfn;
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
index 7b2db779f313..441799f0da05 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
@@ -66,8 +66,19 @@ static int amdgpu_ttm_init_on_chip(struct amdgpu_device *adev,
 				    unsigned int type,
 				    uint64_t size_in_page)
 {
+	uint32_t available_caching;
+	uint32_t default_caching;
+
+	if (adev->gmc.xgmi.connected_to_cpu) {
+		available_caching = TTM_PL_FLAG_CACHED;
+		default_caching = TTM_PL_FLAG_CACHED;
+	} else {
+		available_caching = TTM_PL_FLAG_UNCACHED;
+		default_caching = TTM_PL_FLAG_UNCACHED;
+	}
+
 	return ttm_range_man_init(&adev->mman.bdev, type,
-				  TTM_PL_FLAG_UNCACHED, TTM_PL_FLAG_UNCACHED,
+				  available_caching, default_caching,
 				  false, size_in_page);
 }
 
-- 
2.29.2

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
