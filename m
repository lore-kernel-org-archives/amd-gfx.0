Return-Path: <SRS0=z84W=H2=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DCA60C433E0
	for <amd-gfx@archiver.kernel.org>; Wed, 24 Feb 2021 02:22:56 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 61A1C64E09
	for <amd-gfx@archiver.kernel.org>; Wed, 24 Feb 2021 02:22:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 61A1C64E09
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EB5E089F6E;
	Wed, 24 Feb 2021 02:22:55 +0000 (UTC)
Received: from NAM02-SN1-obe.outbound.protection.outlook.com
 (mail-eopbgr770077.outbound.protection.outlook.com [40.107.77.77])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 84B2A89F6E
 for <amd-gfx@lists.freedesktop.org>; Wed, 24 Feb 2021 02:22:54 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MYGr6RYxTdhtUz5SOxTVSeZ8sJe01ROVWSRccUxbrybXB4XWuxpYKX4G9IDXf/+G1seebXxA0DEM0Xcsl0MbO+FkIwixIzPCycMZGJkSWkNAsslKwAeQruEM21OeO/i9hzCMvzEF6iUzdGUkF9yf4CT1wnUCTufF+J7Fs9i+HPz27Boi4nvyWGy+hSh2TMPc+FUe1dqvtt9fTCWyR8H5d5SvIK5hjicQn/sMYEfqzvEBIcBHPgW+sUIVTmb45CzAloUdilhmxc7dZozxlP5L/Ff07oDZfCxJ3i8L+ePsRV0KQaK2WoUjaWpbHp8lA2BG/7NhWYkFUPY8Rowx0qDnSA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6/RXw7Ym5UiQRiZ0UX0qKdIKZ1XjhaTXkF5mUodjaIQ=;
 b=a5KAFBumogFMtiT13kKtzF+TqSikjZ5OaH0L9G1wlF7a3Aye9d2Odg5lAbSpr4aPire06PHjmEodpBln77IJnklTVpn14u3RaduBXHTnsqFOUYOEjL/KfDEN0VK2JErpBf7k0E5xJk3KFG/mso3BB4+bp+4vMFDXqGLBmDAk7MQg9kmWdX94x8mx2FZbumeYGIfrGYSFcyDRvSCbgur4O/PmQbNtnDrC3xB3t4Nlzg5Y+KCcRoFfruF0pDoQ3QCQoybWQqDl/Zx7WBU6+pv0kvnvRlRi2dwKItNXa+a1TGIuvmzEQz5903kMnUmkzqzrICYZvkQaxV9vfjc8zQoDhQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6/RXw7Ym5UiQRiZ0UX0qKdIKZ1XjhaTXkF5mUodjaIQ=;
 b=DiqtQ8oktD9gIWSg2omSZya5tM3QfV6QcT6Ouy8mfGfMt4My8d7AiRlvYdRVjDAsLJ7ctBYwge1b3oNsRdXgHV+A8WotmMeEB9ylz/SJnYgrsYPKnIWP0r6u/SVksc9C4pgEmsrD/TWMdsWJPtb7oNmb92YgMxeM8dWdHkrjRcI=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB3835.namprd12.prod.outlook.com (2603:10b6:5:1c7::12)
 by DM6PR12MB3594.namprd12.prod.outlook.com (2603:10b6:5:11f::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3868.33; Wed, 24 Feb
 2021 02:22:53 +0000
Received: from DM6PR12MB3835.namprd12.prod.outlook.com
 ([fe80::102:2c9a:54ce:63e9]) by DM6PR12MB3835.namprd12.prod.outlook.com
 ([fe80::102:2c9a:54ce:63e9%6]) with mapi id 15.20.3846.046; Wed, 24 Feb 2021
 02:22:53 +0000
From: shaoyunl <shaoyun.liu@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 3/4] drm/amdgpu: Init the cp MQD if it's not be initialized
 before
Date: Tue, 23 Feb 2021 21:22:41 -0500
Message-Id: <20210224022241.23424-1-shaoyun.liu@amd.com>
X-Mailer: git-send-email 2.17.1
X-Originating-IP: [165.204.55.250]
X-ClientProxiedBy: YT1PR01CA0096.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:2d::35) To DM6PR12MB3835.namprd12.prod.outlook.com
 (2603:10b6:5:1c7::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from shaoyunl-dev1.amd.com (165.204.55.250) by
 YT1PR01CA0096.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:2d::35) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3846.38 via Frontend Transport; Wed, 24 Feb 2021 02:22:52 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: fe14be86-0617-42fb-afdb-08d8d86b16d3
X-MS-TrafficTypeDiagnostic: DM6PR12MB3594:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR12MB35949A61FF4A81B1BBF5FC76F49F9@DM6PR12MB3594.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: tRnBtXFSBc5dSWJSRUNQ/lfP47QBlNxWw26cESrVHldB4emLpzR936X8Zypa13e0wE8+vJEVuU/JbAHRfpmKKXnvgy7w8TOF5PE1k6q1PMnMsIgXJozhwbCi345g/+QriOri9OgzuXHtKzv9I+wgT1rXwi6Garrl5uTScQmZ/088zcpmVVWeCtbMncbXA2dAic3hIg2iy0VFCdrx6OPpV34z4CIesSD3eePXeBHZ6mCTrw2aB7K2Oah+0asfpbizKpnUK/aQpbRZkb/cA7qGJolu1hPqpt5mDdzB2iHd2pULxDFLY5nXnIDl8xHYMrC/3TQqBeTTE25irr0PuNidwbhMbJP/n96R02CasfLhK5cFyq+x6vDLyLZW4z31ezJQQhzBLC+/etCEt4PIIlPN8QLMuPKljgNhSUEauyloO5afd95eThvjWrI57XtsEWQpM/8w9RrBv5MJQncgxkH454x7Q0zj6PMIw6hcI8HxAapzQeBGKCpXc66BiAbHyijdnbvjM6Wur+hfWgS1bNlaIzrAvMGhMYbNMID+OfsB5G4eic11iN9hr2RLl88GOh/C
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB3835.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(346002)(366004)(39850400004)(136003)(376002)(396003)(316002)(6486002)(16526019)(956004)(86362001)(8936002)(66476007)(66946007)(186003)(8676002)(83380400001)(2906002)(2616005)(1076003)(6666004)(4326008)(66556008)(6916009)(26005)(7696005)(478600001)(36756003)(52116002)(5660300002)(43062004);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?NN0d7xfwGKrwwdE1lJxKxVkJv5OIjzYsx8XhjxjNKH8yIInxObx+SJY1l4f+?=
 =?us-ascii?Q?EVLRiJgeU6N0/6fEkbgbP5Xn1bwJ3NTcI6qyxmJ68qPikYcuVfxMFeCg6i90?=
 =?us-ascii?Q?XM6337DLEqhvZIoIwD45iG+cDMFHnecSftRjYNvxhjoXPFPmQeMKBr48jGHy?=
 =?us-ascii?Q?E0+sCMuvdsa/+Dlnx0ptZyJjdzB5vnz0wRe23UrlpC6DJjoMvwvdSdChZuKn?=
 =?us-ascii?Q?XrkzhTMfgkJl7plthKImymeRKpl2cIheyV0sbX7Jh9i2aF7+sWRjj5p2UCwv?=
 =?us-ascii?Q?ihhHWZgFZN3FZFHRlrM49/H6Fvsqzno3baG3g2W5pwhr9rb/eXMlcXGz6qil?=
 =?us-ascii?Q?9vwYruhLXExt/zpJAxzFjFlMaqLa2d6yLFADYR5T5brrT3g1bmf8Kr5OKlRp?=
 =?us-ascii?Q?asHur6SYM7z0VSxE3K2A1KT0KwY50Nb3ObClvLLkRTy/vsdOKt6LwQeEVvsJ?=
 =?us-ascii?Q?yFhaJreCQlfPZzF1qj+I6hUJcOJVejTAJOEazN14CGGA3bIEqcghKcsvWp+z?=
 =?us-ascii?Q?H7hP7Qnep0tuNLqroTAYixUH7YckPWrsR3ozPKQk1Fu+7ukdYuPWeHNQX5g7?=
 =?us-ascii?Q?0FheOMsMFVPVsA7ba7wSV8Xr6LlZi4AEks84FaL/rt3zx9YF2UAxLuV4pzpd?=
 =?us-ascii?Q?3eqiT1xiMZr0PhMkZGQ452K/NsX70DUEkAleEDkE40ibvfXVBRQvolgeDl9a?=
 =?us-ascii?Q?8wS+YVLVwRclp5VuOn6kZjgFIFSxllUatz5dMJwZxrCXNeh8+a27hGQhmcW3?=
 =?us-ascii?Q?/2VAoNGH/wJScOhpjwIHblbJCVaBjtA3TSOCPQWHdQ37H6apTabr2Em3zx42?=
 =?us-ascii?Q?Jr2/GCeMM8kjC7DSP/3a5WYxDkE/Zk/VsQdBPmLbmoMf4r6sXk95RsFXEmJd?=
 =?us-ascii?Q?wTpK3E+f3rjsSUaca3J794nZkALa+JQ8V9xa177WkiTkxQr4Tz49HOHYDhhq?=
 =?us-ascii?Q?O1ihTAcf5sY4e5zblAEyhrxtqrJlYNBWDd//rvRq/kzHqhtrFB1r/Y1l67s1?=
 =?us-ascii?Q?z+WvP7jF78Jpiiwd332QfA+2bBzAJMcI3mmlOfLee8QPtQZvyhXZ7f4Z/VVF?=
 =?us-ascii?Q?Acxa/WUnmYuM4/aO4BbXm3jOtvf9Xot8E1CL/FEtmHAdvmrzokUayMhmXJlK?=
 =?us-ascii?Q?eg63eiKfSn+3bUK6X4I+N1lopQMl9w1zRuxl22imjZmHZDFkgGrwgl7x+sPr?=
 =?us-ascii?Q?7QXAjlT536xL/7qD32IsiZ95bEFxssMe3i+AmuxmgcQFCrh9RzACAP97kSYj?=
 =?us-ascii?Q?TjxQ9T461UpDYymkOYhRdoouKS9pnlcqjISXDDsKHXha9dq3G/kS7wYn4M0q?=
 =?us-ascii?Q?zEelJ4kNIaGa0Rleub9VlUZl?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fe14be86-0617-42fb-afdb-08d8d86b16d3
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3835.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Feb 2021 02:22:53.0756 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gyfoz/MOKBvC+AnvaAoBhSNzPUbg5g6iM/c6EQQIYfH8WP084rAyXpXNoq2DwAqfJB8SOGoa+d5BtwN0BE6fXg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3594
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
Cc: shaoyunl <shaoyun.liu@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

The MQD might not be initialized duirng first init period if the device need to be reset
druing probe. Driver need to proper init them in gpu recovery period

Signed-off-by: shaoyunl <shaoyun.liu@amd.com>
Acked-by: Alex Deucher <alexander.deucher@amd.com>
Change-Id: Iad58a050939af2afa46d1c74a90866c47ba9efd2
---
 drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c | 20 +++++++++++++++++---
 1 file changed, 17 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
index 65db88bb6cbc..bfe1aaa0418f 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
@@ -3696,11 +3696,18 @@ static int gfx_v9_0_kiq_init_queue(struct amdgpu_ring *ring)
 	struct amdgpu_device *adev = ring->adev;
 	struct v9_mqd *mqd = ring->mqd_ptr;
 	int mqd_idx = AMDGPU_MAX_COMPUTE_RINGS;
+	struct v9_mqd *tmp_mqd;
 
 	gfx_v9_0_kiq_setting(ring);
 
-	if (amdgpu_in_reset(adev)) { /* for GPU_RESET case */
-		/* reset MQD to a clean status */
+	/* GPU could be in bad state during probe, driver trigger the reset
+	 * after load the SMU, in this case , the mqd is not be initialized.
+	 * driver need to re-init the mqd.
+	 * check mqd->cp_hqd_pq_control since this value should not be 0
+	 */
+	tmp_mqd = (struct v9_mqd *)adev->gfx.mec.mqd_backup[mqd_idx];
+	if (amdgpu_in_reset(adev) && tmp_mqd->cp_hqd_pq_control){
+		/* for GPU_RESET case , reset MQD to a clean status */
 		if (adev->gfx.mec.mqd_backup[mqd_idx])
 			memcpy(mqd, adev->gfx.mec.mqd_backup[mqd_idx], sizeof(struct v9_mqd_allocation));
 
@@ -3736,8 +3743,15 @@ static int gfx_v9_0_kcq_init_queue(struct amdgpu_ring *ring)
 	struct amdgpu_device *adev = ring->adev;
 	struct v9_mqd *mqd = ring->mqd_ptr;
 	int mqd_idx = ring - &adev->gfx.compute_ring[0];
+	struct v9_mqd *tmp_mqd;
 
-	if (!amdgpu_in_reset(adev) && !adev->in_suspend) {
+	/* Same as above kiq init, driver need to re-init the mqd if mqd->cp_hqd_pq_control
+	 * is not be initialized before
+	 */
+	tmp_mqd = (struct v9_mqd *)adev->gfx.mec.mqd_backup[mqd_idx];
+
+	if (!tmp_mqd->cp_hqd_pq_control ||
+	    (!amdgpu_in_reset(adev) && !adev->in_suspend)) {
 		memset((void *)mqd, 0, sizeof(struct v9_mqd_allocation));
 		((struct v9_mqd_allocation *)mqd)->dynamic_cu_mask = 0xFFFFFFFF;
 		((struct v9_mqd_allocation *)mqd)->dynamic_rb_mask = 0xFFFFFFFF;
-- 
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
