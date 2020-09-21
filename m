Return-Path: <SRS0=OtMv=C6=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE44CC4346E
	for <amd-gfx@archiver.kernel.org>; Mon, 21 Sep 2020 19:18:35 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 37013216C4
	for <amd-gfx@archiver.kernel.org>; Mon, 21 Sep 2020 19:18:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="3ttek0j6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 37013216C4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6511B6E528;
	Mon, 21 Sep 2020 19:18:33 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2043.outbound.protection.outlook.com [40.107.92.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 97B836E528
 for <amd-gfx@lists.freedesktop.org>; Mon, 21 Sep 2020 19:18:31 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Yuxh6jSC+AqFGMuP+f3pnDgC3KFiNcwzRperLy0xRCkxB4tETkDkK7I9JTvMcJSo1TbCpJT1erODy49iMjmG+xSAdpMYfYP+m99iI4qTopUdDYjCYg/njQkALcamFTzDSNdWIxzCU1maToOS5o4FyiQdLOECb4C5QFthKq9gCCSNNgtjWZC3wgNsJFRRbPmAyz/1DLOdLw8ao70aI+HNCGb/1vRVDT0kCuPUJMDQ/AKepmXCy/Fi2gt7dYe9n4iSu8fbnuQ07kpvSZ5ml4KXTpA2awAei82602RfgM8o0A6S3hQ1X5r3g0zptwbpeh7dyCKfWrANL9UxWhWOKA3Qyg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1l0mbFNwoAsqUv6uhQg22FRR57bK805PAMK9jYoBV/U=;
 b=KmVQg5YKRNBh2WZHt9lM19kWS6jxaLE0WW248i1P4fpV3NvF8xw92PnW358uGUnPtSjlvAtuY6TbOyXCCmSFGnZ1y87oFQYMzwjv3VWwji1NrmUiSsVh6EkPQdT5XSrWMcDD9ddov1kOhGFt60ybkljaRu1scFYzFz7l444G5pg++nKvQWZW+akzgPw0Tqw5QKQ+9HL0pHYR3L60548yCDaHEeIqrSP8IJiO5DWfCc+HbhSP3bsdOfQ8rD58y+/XaV3YFZZfWfMDdARrgflf8RtVQnKnTSmxHNn+OBccwjiYn6Bl7nENMFedofLuRQqrcVKb7+sTvpVlW7MM73aWHg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1l0mbFNwoAsqUv6uhQg22FRR57bK805PAMK9jYoBV/U=;
 b=3ttek0j6+2oEh4CgypoYGt/TCktwlZt6lO/djhiFfHTLUzPbe4siNgzNU+LdHnxEgxaqTZvTKOIeBsgsfERirTLbYEiGnaYFWYRIE4rH7ROhRbUO7dfB1G3e4tGQQcQaLS7K5kgIMOP7LxCsudZDddVaGmc+Cxc7ldKDu5yxReE=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from BL0PR12MB2433.namprd12.prod.outlook.com (2603:10b6:207:4a::25)
 by MN2PR12MB4567.namprd12.prod.outlook.com (2603:10b6:208:263::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3391.15; Mon, 21 Sep
 2020 19:18:29 +0000
Received: from BL0PR12MB2433.namprd12.prod.outlook.com
 ([fe80::bd7a:2354:a2d4:97fe]) by BL0PR12MB2433.namprd12.prod.outlook.com
 ([fe80::bd7a:2354:a2d4:97fe%7]) with mapi id 15.20.3391.024; Mon, 21 Sep 2020
 19:18:29 +0000
From: Madhav Chauhan <madhav.chauhan@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH] drm/amdgpu: Add uid info to process BO list
Date: Tue, 22 Sep 2020 00:48:03 +0530
Message-Id: <20200921191803.18549-1-madhav.chauhan@amd.com>
X-Mailer: git-send-email 2.17.1
X-ClientProxiedBy: BMXPR01CA0065.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:b00:2c::29) To BL0PR12MB2433.namprd12.prod.outlook.com
 (2603:10b6:207:4a::25)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from atg-hyd-lnx01.amd.com (165.204.158.251) by
 BMXPR01CA0065.INDPRD01.PROD.OUTLOOK.COM (2603:1096:b00:2c::29) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3391.13 via Frontend Transport; Mon, 21 Sep 2020 19:18:26 +0000
X-Mailer: git-send-email 2.17.1
X-Originating-IP: [165.204.158.251]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 8ca8d5f8-710b-4c89-16d8-08d85e631ec8
X-MS-TrafficTypeDiagnostic: MN2PR12MB4567:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MN2PR12MB4567CFDC10033BC8209EF6FD9C3A0@MN2PR12MB4567.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:81;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: pHz/riWBWG5DklF3dohrEF1TfRCnKSBRbdOFJa6SrGiWmB8OlWEO4nAyJFM/LdNvKc6jdku70GeRyzmyMubwAtHW4gopgBF3GhfA3X+HY/rIbym+rfE+W4L5ZY9q3TOhdooOr4gklmqZ2x3eCk/xiNI6xIh3cL9I+BczOzT6IwuT4lzuK/fO73ZZ8e5TZAqbAt0anyOt9gVpj+ezfs0w1Lqz7VC74zIkCjUH9t3g9wJT0vWwEqZqgkzXVKjkmCAdqj+n8VgjqOtFzsneiSNFVzC7hjgOG7yygnnaf969SWtsrcnUdiY3VbsVdRkPca8Phgvj2xgM7vABLoK/AGiTkA==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL0PR12MB2433.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(39860400002)(366004)(376002)(136003)(396003)(346002)(4326008)(2906002)(6916009)(66476007)(956004)(2616005)(66556008)(1076003)(8676002)(8936002)(66946007)(7696005)(52116002)(6666004)(44832011)(478600001)(316002)(83380400001)(6486002)(86362001)(5660300002)(186003)(26005)(16526019)(36756003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: Pr6WMnLljGPU2RuJblQYXngIbFxQa2VFQ1gXarH9ydXcE9YtUXw2UU81z39Cs51WEZUQAikQPrDgorFO6rfIixJbCMUIO7HRugi/2daeGATjP1rjqx+oYHFTmSPBFTNLGK6Z4MDa+/S9DveA5vvyzsr5j9iTIVSGPgtgdsL+BCAIMhhe4KLoSOLyeHoFPYoD9llSEjazQ8v0NhdcwJOfwSu4j5Pl/tAbPuT3+ETNMnNEf6YreVma+Zspc3369T5yCm2HNzPeUqsf6vCLo4EtPxqnSpP5Kr4sWfZXFPaaU94b2W11x1TRydcgVxEMCw3Yaf14Y5JZIgrLIQRtFMx8nqnoY+5iTpZuLet9xZXkleMls1ga2+ziCkFU3pL5d/Q4otnAaDmAi1G/LPgVGdxOR3+MZcWD5izW/iBxEGUt7cD9eLQLH4EN6BYvc623pvtwquxw0uCCmC3CZFPfqqd/1SepnlQHg7Ie1wm462Rz1J7RoHe1a0mSFFpz2hSL+PU0acqbhBpop+yk5Kvf7swY9aUT+tKG4N1zw0ff+7+1YX4v2nXtol7BU40JZUtuf67FCBJUUG22mgOCl5S1Vj1p08kA8CFu6FUTzW47RGg944HMW2TVJ74j8gqADdANANUL+wwjvsyDgjAgPgEWRxNRyw==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8ca8d5f8-710b-4c89-16d8-08d85e631ec8
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB2433.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Sep 2020 19:18:29.2273 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ka0Zu+D+FfAKGIq6FheEAwj6mIzNwJXoOpP8XVHtWg5F2EmM8qXh1DUcxJedryPuqSeG0mYege6MR1J9fhxHKA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4567
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
Cc: kishore.surampalli@amd.com, mihir.patel@amd.com, shashank.sharma@amd.com,
 Madhav Chauhan <madhav.chauhan@amd.com>, alexander.deucher@amd.com,
 athar.saleem@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

UID is helpful while doing analysis of BO allocated
by a process.

Signed-off-by: Madhav Chauhan <madhav.chauhan@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
index f4c2e2e75b8f..c1982349ec7b 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
@@ -892,6 +892,7 @@ static int amdgpu_debugfs_gem_info(struct seq_file *m, void *data)
 	struct drm_info_node *node = (struct drm_info_node *)m->private;
 	struct drm_device *dev = node->minor->dev;
 	struct drm_file *file;
+	kuid_t uid;
 	int r;
 
 	r = mutex_lock_interruptible(&dev->filelist_mutex);
@@ -909,7 +910,10 @@ static int amdgpu_debugfs_gem_info(struct seq_file *m, void *data)
 		 */
 		rcu_read_lock();
 		task = pid_task(file->pid, PIDTYPE_PID);
-		seq_printf(m, "pid %8d command %s:\n", pid_nr(file->pid),
+		uid = task ? __task_cred(task)->euid : GLOBAL_ROOT_UID;
+		seq_printf(m, "pid %8d uid %5d command %s:\n",
+			   pid_nr(file->pid),
+			   from_kuid_munged(seq_user_ns(m), uid),
 			   task ? task->comm : "<unknown>");
 		rcu_read_unlock();
 
-- 
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
