Return-Path: <SRS0=ysjs=55=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F42FC2BBFD
	for <amd-gfx@archiver.kernel.org>; Mon, 13 Apr 2020 15:09:12 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8E97F2072D
	for <amd-gfx@archiver.kernel.org>; Mon, 13 Apr 2020 15:09:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="wq9PLA0f"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8E97F2072D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 57D2389E2C;
	Mon, 13 Apr 2020 15:09:11 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on20618.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7eaa::618])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1EDF089E2C
 for <amd-gfx@lists.freedesktop.org>; Mon, 13 Apr 2020 15:09:10 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=V7L6kWFGw8MESzKDFQer0JGBugdoykyHgEc3e7fALw00+tn5vM+FB/XFgQ1u6iLU3GO4Bil0UywoYO+p0S6wMAo+kiN9zWRiNUjODqohfMiuWrlFgPc8ygQlABGVqPGmPHooMor94GTXvAucs7+NLyEJa1cw8VLGJ5Xbo2tDHnzdt/D9W8GgBVCSI4mddEG35JO4XvfjQ7vMtixMnRKyCjFcRVPp+2/3dRyETufj9yT8zm+9N1XnfCEmN89b5VP9gSebyaH370OjT4Pzoj/z5a4TvmuAynWMsLS8bhwm0ucEatw8htL7eckSEnIWZ3OAUYkDK0X+AZ78Ue6dsAiz1Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jcjbyhyUboheDHp74jwRdsAZFqxwcLmnu/J1RMDmfKE=;
 b=cOSbq7CjExz9DYccG5gPsU55R1DWuA33p/nKCgGMrdXzU0toLNj1S3PLN8Wtu37lvEBC4iwmzIQ+RRSGMXoI5mr376KNzvu7+EBgE9ied2lcVhtk9cbiWB44Zx9vf316qUKM0D9abJJAivyyHrKGSoZPR5NoRoQ/Y7jFzNp/zBZ4i7/tVpdfsZjf+4jOo6K2NBTsFLDksV+3avcgAIZpO0ryF9w0G87vOkk5QA8kl/bh0yKhDsdvu7R72TBuGJ0wifQM4uI2KLWdCPc8eKnhWIRISaYN5MRQddXdespr2s7xfXqvlGBd5YymAOJoo/d5QNTPwU9SUIkGbmrWihbh2Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jcjbyhyUboheDHp74jwRdsAZFqxwcLmnu/J1RMDmfKE=;
 b=wq9PLA0fIC6zQjuk/HJAyPrO8QqX6g0nRsJXOsIJg5YaBvK1zlRuZa2KjkIlWvmb6iqyRZP3rSBHcX9EbG+uAgKYW+9t4YFTlYF+mQFqmkd+c9whvHz2wTGlQe+ogHzOLSmBTcl19UNlm61QV1HW2tgWx2vD31eYFds08n7a3Pc=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Prike.Liang@amd.com; 
Received: from BY5PR12MB4307.namprd12.prod.outlook.com (2603:10b6:a03:20c::16)
 by BY5PR12MB3844.namprd12.prod.outlook.com (2603:10b6:a03:1ad::24)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2900.26; Mon, 13 Apr
 2020 15:09:08 +0000
Received: from BY5PR12MB4307.namprd12.prod.outlook.com
 ([fe80::c8:8aec:d08e:8bca]) by BY5PR12MB4307.namprd12.prod.outlook.com
 ([fe80::c8:8aec:d08e:8bca%4]) with mapi id 15.20.2900.028; Mon, 13 Apr 2020
 15:09:08 +0000
From: Prike Liang <Prike.Liang@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH] drm/amdgpu: fix the hw hang during perform system reboot and
 reset
Date: Mon, 13 Apr 2020 23:08:50 +0800
Message-Id: <1586790530-19464-1-git-send-email-Prike.Liang@amd.com>
X-Mailer: git-send-email 2.7.4
X-ClientProxiedBy: HK2PR02CA0194.apcprd02.prod.outlook.com
 (2603:1096:201:21::30) To BY5PR12MB4307.namprd12.prod.outlook.com
 (2603:10b6:a03:20c::16)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from prike.amd.com (180.167.199.189) by
 HK2PR02CA0194.apcprd02.prod.outlook.com (2603:1096:201:21::30) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id
 15.20.2900.17 via Frontend Transport; Mon, 13 Apr 2020 15:09:06 +0000
X-Mailer: git-send-email 2.7.4
X-Originating-IP: [180.167.199.189]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: be0ea07c-f2db-4d82-e775-08d7dfbc9d2f
X-MS-TrafficTypeDiagnostic: BY5PR12MB3844:|BY5PR12MB3844:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BY5PR12MB3844A2CF5B2D1DA29625E86CFBDD0@BY5PR12MB3844.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1122;
X-Forefront-PRVS: 037291602B
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BY5PR12MB4307.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(10009020)(4636009)(346002)(396003)(376002)(136003)(366004)(39860400002)(478600001)(26005)(52116002)(6666004)(36756003)(4744005)(16526019)(2906002)(6916009)(7696005)(186003)(4326008)(8676002)(66476007)(5660300002)(316002)(8936002)(66946007)(66556008)(81156014)(956004)(6486002)(2616005)(86362001);
 DIR:OUT; SFP:1101; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: zugssXD+r4PjmT9huA4T2+v3AB78UrVTA9bqiRR1ABjMywhjd5XQFIs0F1+mTTp5QpMqt1gwG1h9r+tYLLIjbHC5U3/bPJBh6qNGQfi04Sn9un8SNggxFNh06jV1RgubbTCBeME5M+YLwFTn/vPJma1r3JnJ5HyKdf+I6t7RmAtSrQXE7WEOMuiCofwzbrZTXKrHdN9YmSkacq3sZNacR4oxiVnDfFhzfiKMINFlfR8AyCAOCy9zvS5WzdALqxxLqyU2ebZsOUaNnlIv20yGuGTPQx0Xb8AZI4drsqYhwhHh9jKeAvbzujFj265eNLenxG6gWkeg2NBTYeTFSN/nnvXF0v7rj92vKbIV+xYMotvFBjGZbOFj+vw8QVP0oWKgqcHJddyATTxsnOG+Tfiit51Llsi1gvDvERLLapJ5qTcTPRNl/NFBzZx2Zn9AbC93
X-MS-Exchange-AntiSpam-MessageData: qNdDxiHL9CQs8zbpVteorgwtGMFkE9Vj2rbnspTxnenrE7787uUy8xi5AWfwQIGXMVOxVsQwZ1nff//leBxPi7EAlLgP9mNL04GU2Ar2m2hKrvIU5H+e9ufw7rriJFtseXkm4CAV6ObusyDdgJ+avg==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: be0ea07c-f2db-4d82-e775-08d7dfbc9d2f
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Apr 2020 15:09:08.3995 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: w4qx09w/vpGuO46FCHxlVkxPJVEagwUDB+7QZ/4VtsblQw8vN71KNSI277nd38j5
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB3844
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
Cc: Xinhui.Pan@amd.com, Rahul.Kumar1@amd.com, ray.huang@amd.com,
 Prike Liang <Prike.Liang@amd.com>, johannes.hirte@datenkhaos.de
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Unify set device CGPG to ungate state before enter poweroff or reset.

Signed-off-by: Prike Liang <Prike.Liang@amd.com>
Tested-by: Mengbing Wang <Mengbing.Wang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index 87f7c12..bbe090a 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -2413,6 +2413,8 @@ static int amdgpu_device_ip_suspend_phase1(struct amdgpu_device *adev)
 {
 	int i, r;
 
+	amdgpu_device_set_pg_state(adev, AMD_PG_STATE_UNGATE);
+	amdgpu_device_set_cg_state(adev, AMD_CG_STATE_UNGATE);
 
 	for (i = adev->num_ip_blocks - 1; i >= 0; i--) {
 		if (!adev->ip_blocks[i].status.valid)
-- 
2.7.4

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
