Return-Path: <SRS0=kdbD=HM=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F94AC433DB
	for <amd-gfx@archiver.kernel.org>; Wed, 10 Feb 2021 17:21:48 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AFB6D64DE3
	for <amd-gfx@archiver.kernel.org>; Wed, 10 Feb 2021 17:21:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AFB6D64DE3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 42EAC6EBA4;
	Wed, 10 Feb 2021 17:21:47 +0000 (UTC)
Received: from NAM04-SN1-obe.outbound.protection.outlook.com
 (mail-eopbgr700070.outbound.protection.outlook.com [40.107.70.70])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CA0FA6EBA4
 for <amd-gfx@lists.freedesktop.org>; Wed, 10 Feb 2021 17:21:45 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YBwhtyWZpp+XZJUmCdwK5iIfv3NbyO7UvidkPgxAwOMBYqQ6MRuS4P0jPKvPGC5PCq+YYUwbsWU4bbo6OfB9L1OkeiwzkYUfiK74qK6lPGQI8BaJLj21h4Nv0pXkfAbqzzCvSq4+GJpRrxc50jsBcSi5CPvvB2iqziVfN/uArle41YCAQDuPd/hRFgyB4UUMlFO9dUrsI/kq9SmBM/ZWs3w3gQYLeZVLxvFrTmTWbjroErQZN6C7DKgcsdT2brXpGB6X5H5m3DuyinslM1wsLe/lkValtCx5Z3+gGDntq3VzpIFchrjbkaN7yxsx5Rgkrej44rWH1KU8ZDspw0oAzw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VHbcZLALFmtP0cDB6GLYEOpBFLXatBpbjYy4xqvJTJo=;
 b=iigxNyWmeipKM49SSvq9YIHfkhjEhRRkj5/dvGqQbZzX7jv3d3fyAtztjjmcl07a+XhuhLpnWhVPlXX81FlmuIdXp14g/iFuiOF1lN1bxpLul3v2Iw8401dLgFvfxWD31fBZpCMhL4/kXSTnzysEKqa5Ht0HqB7Agh86ucNRoJApzn+kfnRyZE3stquMl4FomMjWQfqJPFk/62n1/DlokKwx8vdt2ScDX3gfDt/GfL3IiPagcW+3zk+/x/qaGKU4+ZsnWBAS7eD2CiQVNGPugCDfCk7RwWeaHWIASO+OvxMUDZDfYT1EfZJ7DqrqoubEkrvxYD/NIQdCX88K+vAfwA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VHbcZLALFmtP0cDB6GLYEOpBFLXatBpbjYy4xqvJTJo=;
 b=0MHniFQ8L9045f8Ei+F9F/OJ6EgFbrNeDrm+VU6OjJKKF1HbhMURdWQNESAbtu8oiT+JGw9TB9fSvUCZFmVqeeHNfJp7RnsJuYP8KaRDoSJUHJ19zVS6Jds1bvlGJGekjvBMR12oO+agFRlgZ6JHMUgT+2o4AqbJbxs1X5a46RI=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB3916.namprd12.prod.outlook.com (2603:10b6:5:1ca::21)
 by DM6PR12MB4877.namprd12.prod.outlook.com (2603:10b6:5:1bb::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3846.25; Wed, 10 Feb
 2021 17:21:44 +0000
Received: from DM6PR12MB3916.namprd12.prod.outlook.com
 ([fe80::452c:77af:fea7:a633]) by DM6PR12MB3916.namprd12.prod.outlook.com
 ([fe80::452c:77af:fea7:a633%6]) with mapi id 15.20.3846.027; Wed, 10 Feb 2021
 17:21:44 +0000
From: Nirmoy Das <nirmoy.das@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 1/1] drm/amdgpu/display: remove hdcp_srm sysfs
Date: Wed, 10 Feb 2021 18:21:34 +0100
Message-Id: <20210210172134.121327-1-nirmoy.das@amd.com>
X-Mailer: git-send-email 2.30.0
X-Originating-IP: [217.86.120.56]
X-ClientProxiedBy: AM9P193CA0017.EURP193.PROD.OUTLOOK.COM
 (2603:10a6:20b:21e::22) To DM6PR12MB3916.namprd12.prod.outlook.com
 (2603:10b6:5:1ca::21)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from brihaspati.fritz.box (217.86.120.56) by
 AM9P193CA0017.EURP193.PROD.OUTLOOK.COM (2603:10a6:20b:21e::22) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3846.27 via Frontend Transport; Wed, 10 Feb 2021 17:21:43 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: f3f29ea7-726d-494e-c8e2-08d8cde85682
X-MS-TrafficTypeDiagnostic: DM6PR12MB4877:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR12MB48772BECB677BDECDD681DD18B8D9@DM6PR12MB4877.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:64;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 2qYUb8SfdhGUdPKZGGPVT4U8dPtboRv2DRi3W3Zs91GHDWZCWDreyK0IfWfZdtTaWRFKYRUX7m983z3Z6SKc8rOMi7fHCkq5YF0xcgVGpnaqyeYIwT1SLCcjpO1dUwTCMO17oizPtt6O/x5cfL4e01R5WsZ1kbfI6yVHPkwQ/U4vz2EUCp86v9IiLE4iB3KvavVcDY+uTmiwmJV659zM6q4jw+8wKUfvzBqyUDLGv7jKmX9hKh8329dvz6HKhU8OLuF/F5YrAI9Y9uS0SMLSxHJS0f1jMCAzqhULlXgK9SukYmb+R6DiQvSNvr5yTFK9djonIBPEbW9kOm7GQtvFm5aPPFf/Up/z9eMWdY+8+UvV0VnGaUAGL/N09xvXXh8OHFB/yI70xgGOxhqb4Mwxe89TE5RU1AZC0WemQkj1RG3cchp5RWW+JwfTb+Ly42fnVFBeR6h0DN+vDbc/qQTkvx893sZP6aWz065eiqil+NX8BM6biXRBR5CgTqfAnLKBUwWyQZzS5NQIb0Y7QTpQRA==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB3916.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(396003)(39860400002)(376002)(136003)(346002)(366004)(52116002)(5660300002)(2906002)(1076003)(478600001)(66556008)(66476007)(66946007)(8936002)(26005)(44832011)(36756003)(2616005)(186003)(6916009)(6506007)(956004)(16526019)(86362001)(6666004)(6486002)(6512007)(316002)(4326008)(83380400001)(8676002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?MwYMpksbNtBaFO5nmh90gbWYM8EJmA3ak4oE9JF1eacVtf3BGhoqxkNqNcS3?=
 =?us-ascii?Q?rzDkszaFYEkE2IPvwWBzj3+jit7HQ5QHj6frJx5vDlSlFKkfXxgIxb8PjiKi?=
 =?us-ascii?Q?mq1hUuWSguxjHWpOtqcnJLdqG87Y3DlkcNIcEBfvmviFMkB/0NKiBpcqm1VJ?=
 =?us-ascii?Q?inrQZkNL1rZyxtLYKyJfX7oPMpLETeIhtMNgC6TcHDLkhC6ZwZnpwK88HtaA?=
 =?us-ascii?Q?UpN27QpJ+D5mXrksA3c+kSH6V+HnCsT+eYyO2V/rgT8DM1RX67be0uZ2wqBA?=
 =?us-ascii?Q?Ze5ndB6WWKY52U4u/LgsKOxgzQeIco/PuDWmKSuhvXtMGdx6msfBoFLR4kyg?=
 =?us-ascii?Q?FOwmo1XHQukmJapswPO0AyMxe7x1//30zXdsUvYy/7A2EzG3GolXjAsG8xB0?=
 =?us-ascii?Q?faFVD0qb1nElds6p1KUFjBaZYV7hgh5xfC9KviyKci5WABqhMS1GNsHh5Q/n?=
 =?us-ascii?Q?Wb1UoeO85+hUj9589jMolN21dZSItVB7Hg2KXDxFhZcyTjpnVMVUNZleohBQ?=
 =?us-ascii?Q?/Mgs7s8j5zwhGrwxM7uBgTEzq+LXvhNUsfRwvkNA0Ke4PDZ0OVsHYyPl3bdU?=
 =?us-ascii?Q?C7RnyqT8SECyKJdb4kQj/5MfsJ28B/ZaocudZ4nHq6bVmboQ1w7FWWg8NnAC?=
 =?us-ascii?Q?1Bp43WVMh2ZPPjWqGKmOw6fArV4qs+cvU0Sdcle49ZuDiiGXiookWuVgCL4u?=
 =?us-ascii?Q?zMhQUpPzCxsQBoLpSde86Rne4oU1AwRdRvlohlD/Yc8LNm8k/zj7qRq0g7Tn?=
 =?us-ascii?Q?0Y4hTDqfv7Isps8k+nQQ9Eh20I8igTHfzV1Wg6XzI7V6FLuDG1+Msm+f3GU3?=
 =?us-ascii?Q?Y+K/W+uU8j0FcYiI4dLGVkMJr0FB+kCxFAYFm+vDiT+DetzlOqCmhmPDgGHX?=
 =?us-ascii?Q?nAxPUaVDpXv8Vrni0dmtrSNWTAh+q7e+Ic6+0gMx1SU7m32xx1Nv6c5ng1Kw?=
 =?us-ascii?Q?Of/SM4VF/wcQV8JZH+qVUgpJzpgOZsJRLfNuHEVcKGLGVf7wJtOvG1DVHoGC?=
 =?us-ascii?Q?6l18xlE7uSJYIFAV5Pf3av3NrTJDRlkEYQi0DJOejNKldxpCW79XQBmTaUsu?=
 =?us-ascii?Q?JDbzhOva3Fuj4zahmQ9n2P3TKu5PIwfHfbp+HGms221RqTJuoLow1KQi0OMB?=
 =?us-ascii?Q?brAprYMbMH8tM6atGxpncw/7o+SBfagANh+ezst88NvPUFOw6I2YXtnyCr8b?=
 =?us-ascii?Q?dKE3E1P378bpQD2eLaGQWdBZ9AL79CYESmNmvU+U/TzML/USObiQswL/zLc7?=
 =?us-ascii?Q?bxJJSt8V61hO9iGXU8zYx/R/xN1wjHc91uytPGR13KJ0BZaD4JNtqUHi2hfj?=
 =?us-ascii?Q?eADpIT4dV7giENW/OhU9Txq0?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f3f29ea7-726d-494e-c8e2-08d8cde85682
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3916.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Feb 2021 17:21:44.2552 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Kh3O2qiY8rPSHPrvPpMxmFrU7BhMSbIriI5HN9Z6BGtg9Tsn4ii9+jNVkovlljvZr6bjcdyjdY3HvYAAQQ3Txg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4877
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
Cc: Nirmoy Das <nirmoy.das@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Fixes: 9037246bb2da5 ("drm/amd/display: Add sysfs interface for set/get srm")

Signed-off-by: Nirmoy Das <nirmoy.das@amd.com>
---
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c      | 2 +-
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_hdcp.c | 3 ++-
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_hdcp.h | 2 +-
 3 files changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index 626a8cc92d65..083d75b747c2 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -1128,7 +1128,7 @@ static void amdgpu_dm_fini(struct amdgpu_device *adev)
 
 #ifdef CONFIG_DRM_AMD_DC_HDCP
 	if (adev->dm.hdcp_workqueue) {
-		hdcp_destroy(adev->dm.hdcp_workqueue);
+		hdcp_destroy(&adev->dev->kobj, adev->dm.hdcp_workqueue);
 		adev->dm.hdcp_workqueue = NULL;
 	}
 
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_hdcp.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_hdcp.c
index b297ddc24d3a..0cdbfcd475ec 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_hdcp.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_hdcp.c
@@ -376,7 +376,7 @@ static void event_cpirq(struct work_struct *work)
 }
 
 
-void hdcp_destroy(struct hdcp_workqueue *hdcp_work)
+void hdcp_destroy(struct kobject *kobj, struct hdcp_workqueue *hdcp_work)
 {
 	int i = 0;
 
@@ -385,6 +385,7 @@ void hdcp_destroy(struct hdcp_workqueue *hdcp_work)
 		cancel_delayed_work_sync(&hdcp_work[i].watchdog_timer_dwork);
 	}
 
+	sysfs_remove_bin_file(kobj, &hdcp_work[0].attr);
 	kfree(hdcp_work->srm);
 	kfree(hdcp_work->srm_temp);
 	kfree(hdcp_work);
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_hdcp.h b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_hdcp.h
index 5159b3a5e5b0..09294ff122fe 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_hdcp.h
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_hdcp.h
@@ -69,7 +69,7 @@ void hdcp_update_display(struct hdcp_workqueue *hdcp_work,
 
 void hdcp_reset_display(struct hdcp_workqueue *work, unsigned int link_index);
 void hdcp_handle_cpirq(struct hdcp_workqueue *work, unsigned int link_index);
-void hdcp_destroy(struct hdcp_workqueue *work);
+void hdcp_destroy(struct kobject *kobj, struct hdcp_workqueue *work);
 
 struct hdcp_workqueue *hdcp_create_workqueue(struct amdgpu_device *adev, struct cp_psp *cp_psp, struct dc *dc);
 
-- 
2.30.0

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
