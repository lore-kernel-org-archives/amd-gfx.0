Return-Path: <SRS0=m206=6N=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9F6DC83001
	for <amd-gfx@archiver.kernel.org>; Wed, 29 Apr 2020 02:39:21 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 70C4F20730
	for <amd-gfx@archiver.kernel.org>; Wed, 29 Apr 2020 02:39:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="JJ4Tuy9f"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 70C4F20730
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3D7D26E0D8;
	Wed, 29 Apr 2020 02:39:21 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2071.outbound.protection.outlook.com [40.107.93.71])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5A4C86E0D8
 for <amd-gfx@lists.freedesktop.org>; Wed, 29 Apr 2020 02:39:20 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PYrjYGkCuLVQJGJM/fOwaBAEGgcIu+KaMAO7jN5SzqPHizgoYG3aOWdXlybCAMQnHFunsttmSp66wQgWWx9C0mTw7irWhaPloSb9o5d0vu1wlWL33nh5UfrNdnVJ1+jEGz/654qHHhlWpvRFTGHHuXd8HGpdXaXuW5Xbt2qeFODX2ULKsRmPIr7343KnGa1+4WK+g2fLP0y57m5ks/lQ/ptMFKxbKoxPfpXxm8kLlRfTnFuB5e4rpmcXri/1e/oYhzTY+Jmw2wRhxka87dSx+NAr0c9I6nBSu2zBma+2WU3AChCzLDq+ZFtJPitu0+ogQK6tMeN42u0hChPjejrrdw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hYrb6BHQrVvS4Ji/V1OBzw+FgxzV3HzmuGLLC1cdMOw=;
 b=L9c78UzpmyasYRAu0NscugvT8LEw6rw5sEXF4Sls/N4QVDMgdKJ4SKreUv8Zz5c9IDiCetiQNf6W2/CnIvNGMmFWWVPrTAs/hfQPmd6EMflTE3jmCnCbVu8r0nzjSBgqys4+yJd3db7AK5HiZ8ni+UL6KChCsHBjieLeVNJaWP38NpsuIDrcbRGlC6+UJnfRvDolZaNRpFs3WDjQEo9q2+UIzF0ZcZZmmUWRfL984zOzCO27FW5xrKeTOHk4k+y4L4BFboLpOfMF57EJZt1BBl07Jb8EvpFGacJhjdm7AU6FPkykYExGNimAdfidDNI9tDu2l11F9eCK7nlsHjx+8g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hYrb6BHQrVvS4Ji/V1OBzw+FgxzV3HzmuGLLC1cdMOw=;
 b=JJ4Tuy9fu24+bpzBzzpDIaeVg2xaj3F0ZWGw5dQGCnG5ByyHs9VJdybD9q5bIr+JqqLcOSgvw1uikUfK4+Bm8wcDlxupQ9aNqXwyfZf9+oLNMGNCGbAdgSXEC07d+YOe38Epk2zs04e5EZbcwSI8uSWpEMvNalX8w/jeR3ATRbU=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB2619.namprd12.prod.outlook.com (2603:10b6:5:45::18) by
 DM6PR12MB2780.namprd12.prod.outlook.com (2603:10b6:5:4e::15) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2937.22; Wed, 29 Apr 2020 02:39:13 +0000
Received: from DM6PR12MB2619.namprd12.prod.outlook.com
 ([fe80::5c27:185c:be20:1fb6]) by DM6PR12MB2619.namprd12.prod.outlook.com
 ([fe80::5c27:185c:be20:1fb6%5]) with mapi id 15.20.2937.023; Wed, 29 Apr 2020
 02:39:13 +0000
From: Evan Quan <evan.quan@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH] drm/amdgpu: address the static checker warnings V2
Date: Wed, 29 Apr 2020 10:38:47 +0800
Message-Id: <20200429023847.1321-1-evan.quan@amd.com>
X-Mailer: git-send-email 2.26.2
X-ClientProxiedBy: HK0PR01CA0058.apcprd01.prod.exchangelabs.com
 (2603:1096:203:a6::22) To DM6PR12MB2619.namprd12.prod.outlook.com
 (2603:10b6:5:45::18)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from equan-buildpc.amd.com (58.247.170.242) by
 HK0PR01CA0058.apcprd01.prod.exchangelabs.com (2603:1096:203:a6::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2958.19 via Frontend
 Transport; Wed, 29 Apr 2020 02:39:11 +0000
X-Mailer: git-send-email 2.26.2
X-Originating-IP: [58.247.170.242]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: d9979abb-a078-4a9e-227e-08d7ebe680cd
X-MS-TrafficTypeDiagnostic: DM6PR12MB2780:|DM6PR12MB2780:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR12MB27807D1837B3AC5C8DB5EEDFE4AD0@DM6PR12MB2780.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-Forefront-PRVS: 03883BD916
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB2619.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(396003)(136003)(346002)(376002)(39860400002)(366004)(7696005)(52116002)(66556008)(66946007)(66476007)(316002)(2906002)(1076003)(16526019)(2616005)(956004)(36756003)(6666004)(8936002)(8676002)(478600001)(5660300002)(186003)(4326008)(44832011)(86362001)(6486002)(26005)(6916009);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 0/+TygtVN6AjOEWe00FD8rT8GehktyK1UnpuGVvjE0KpgKRmm2tUbRNewxmLKr8GnrQqaKf3Jhy3KUpw1RVHOyC8XFTnkhgXbBmCsP5Ne75W04j1MGpQTlFXNzVoBLsaDUO6bVmzZKRBzSpovwZTZMidnWOJ2ptTImgy/WtI+qcID5mGLSHNFmRFRVw5i9O19Ownal1eEb/v1ZTMlD4btUnEXtuQoaVmBB3PjXE8ZmhIdIX1waM0pwjdxXcXCw59yIBgnT3mrUolu5Jz/XZHdPWcOa2XZNEx2egfB5NsI8FRpKEM1IKRUOtx05FeSsbOtaEspy4rRCM00lc1K/a4uIxiw7A8jFVZiXgV5A9fP6im/8uKjD+px3uIjrCIIgsHYx08iXEwNXqbH9y/YzonCv/D1/nxqo6zdPosFt5GmgG3ibE9R/bUrWq7WfsHZJnH
X-MS-Exchange-AntiSpam-MessageData: X403KcEH0weXiiFuXMatVZMiF6IHoPuZ6yuTa+fppIul2n9L63sQ4m558pf1EU4jtl/OXIhQqadOhxzF7i7+qN7CLPxtDfY7Xz6xa4W3fPAZ56deCGfwoMDGVSgnuC0/GR9hRtk4TnwBhFCiVi5sdD+y79IFjOArmRx/nPZ3homQX4nt35IwssVa/E4PCA7GwwHRBb3HSh5sZV5tqfiGRVoPTbra+LYTaZ7pPF3O4Ln5sPd+EixWiLW5XqUIe74A58M3tiJZEC7N6yZT0f8L0OO+v0Az+pG4ZrDdKzP72inpOCTmWjmaBiCnn00DlInPFxcr5iLgbIzwqImpj8dgKKFqB4HZwmuCFMRSf8c3+cKuSKWj44N6RnmGmHp96FNuYLOkvj3Sbna1S010UIt30UKd1BTKEmzs6wscwBpsqdkGnipD8mgLjTzoXoisC3DR54K/LHjV/m99ei7IVEp9SUxcupRYTEVYdc5QLnRXcrmA9Z/Za0R4+bU3y+wlIRXrzZ+h/58aOpoS35KQqlcay51vo5B9mquMAcWiGs2IOEkAYi/dFVHQCrIHTOH94vpkzPzpphaXOS1DCBHWTwStMb2sQleO1WwIiJMRMRVEWz8msxs6zDq7i+aZNoRzBTTvuJBWItdVs2i2sKKrMraYgjJayTBEuVKaNyjP/xkljw6b1d82cbsl9gf1OOZ+KhKssrzDpOqxz/iict0KjUi7tMmoyJPv2y4ZLZjE4lKD/2u4Rh27/koXS5wzdEY/1yaa9pya62cmMbvN467id8tL+YCtYhUZj+4F4zeB6CsAFis=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d9979abb-a078-4a9e-227e-08d7ebe680cd
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Apr 2020 02:39:13.8116 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XiAAuq3ddBboXsGMaNJRQrPwsZq3Q04YZ35cPjJJYHnPCJGh1V0w6tGWHStUyuU7
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB2780
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
Cc: Alexander.Deucher@amd.com, Evan Quan <evan.quan@amd.com>,
 dan.carpenter@oracle.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

drivers/gpu/drm/amd/amdgpu/amdgpu_device.c:4199 amdgpu_device_gpu_recover()
error: we previously assumed 'hive' could be null (see line 4196)

This is introduced by "drm/amdgpu: optimize the gpu reset for XGMI setup V2".

V2: drop this mutex release needed for XGMI since XGMI never fails on
    this

Change-Id: I9c22b57abc9f512114112f93fb035f1fecf26beb
Signed-off-by: Evan Quan <evan.quan@amd.com>
Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index 71278942f9f0..900c636c64be 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -4274,7 +4274,6 @@ int amdgpu_device_gpu_recover(struct amdgpu_device *adev,
 		if (!amdgpu_device_lock_adev(tmp_adev, !hive)) {
 			DRM_INFO("Bailing on TDR for s_job:%llx, as another already in progress",
 				  job ? job->base.id : -1);
-			mutex_unlock(&hive->hive_lock);
 			return 0;
 		}
 
-- 
2.26.2

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
