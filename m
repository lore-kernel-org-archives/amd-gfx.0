Return-Path: <SRS0=z84W=H2=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9FCABC433DB
	for <amd-gfx@archiver.kernel.org>; Wed, 24 Feb 2021 22:22:52 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 45E3464EDB
	for <amd-gfx@archiver.kernel.org>; Wed, 24 Feb 2021 22:22:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 45E3464EDB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8084C6EBED;
	Wed, 24 Feb 2021 22:22:51 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2060.outbound.protection.outlook.com [40.107.94.60])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 69D8F6EB9F
 for <amd-gfx@lists.freedesktop.org>; Wed, 24 Feb 2021 22:22:41 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=V9JB0IhegY6qfTU8hM5+OnTpjuKKF9ydO+IMjyGxkET7IuAEZI+fg/WZ7UT3VuirL3esPSGRdrWjT04doZifFYjSrk0hFVFIGSUL8nvXELSUdnJuIg+AJfBRj8r5clfKqmqTlhPlJfZU3leyFdEULF1lnB6muL2/w8xBDH487G9HNKI7J65yMRadIqb/vRV0h2LE7YmohFnaw0uO0qX7i3Dz+tzNqWHCj3wvb/SXuBzd2BTS4qV3jCZ9ohtMB3ItUw38/dw/RsPcvUneUkigMUjH6P0tFcW0G2l3PVKt1E7skaHGH1ZiXPOzXgsGdS37C6OrshI8nxS9vP73JrLgNA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4I54zjZXWMeJ7ZblpGeS9O0RpBKRh+/4+LHzUWrQIyw=;
 b=oW5PDWF9bZc2BhLuC/pVo2pGSQYcjbpiHtmSe6k3QKdUi4EyNJ3D0KVrUFx/MpmBKj4UECz1MgwR4BvDm4mRc5LNVq1Cum7hfopSgE6I1RAXUbEm3M+H1Roa5Z/g+qZ73ghRGKEozyaFVdG9+YjNpMRd0J7YigAIhotD/cL5XCWS0NFcl3iD5uVibOSBBld0Iqye+dH+PY3slmfUK81Bidmk//RJaZH35/Pu3RCpL3LjbfwcIzemF0nHMb4uh+n+hQ3Zl0R61q9i74FnQoMHqfUnpA7ErLhQ67zwT3/1X7L5GcQxPw4JZYqm1d4dIOjOcCHp3K/M5uqUy+v8Vg7cIw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4I54zjZXWMeJ7ZblpGeS9O0RpBKRh+/4+LHzUWrQIyw=;
 b=08gFvtaa/cC5S9z+AFcU5Ki0Ekt5QWPpISjyDrIIe0forTl5d3mH/1ghSrjekVP2P+7aeUnRINm+7R6v+rBAzqKoQPlp54LovmUHI9LVa39wu5O5aZJtbqxFChzc/0uQTs0tWNdbrwkW3JOEGtvXaPLXX5TYd21aumcMTXY1Q8Y=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from MN2PR12MB4488.namprd12.prod.outlook.com (2603:10b6:208:24e::19)
 by BL0PR12MB4722.namprd12.prod.outlook.com (2603:10b6:208:8c::30)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3868.27; Wed, 24 Feb
 2021 22:22:40 +0000
Received: from MN2PR12MB4488.namprd12.prod.outlook.com
 ([fe80::b0c4:9a8b:4c4c:76af]) by MN2PR12MB4488.namprd12.prod.outlook.com
 ([fe80::b0c4:9a8b:4c4c:76af%7]) with mapi id 15.20.3868.033; Wed, 24 Feb 2021
 22:22:40 +0000
From: Alex Deucher <alexander.deucher@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 155/159] drm/amdgpu: Let KFD use more VMIDs on Aldebaran
Date: Wed, 24 Feb 2021 17:18:55 -0500
Message-Id: <20210224221859.3068810-148-alexander.deucher@amd.com>
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
 Transport; Wed, 24 Feb 2021 22:21:06 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 14c7e186-1367-4192-8c35-08d8d9127abf
X-MS-TrafficTypeDiagnostic: BL0PR12MB4722:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BL0PR12MB47225F12C5B540CF1A4CD607F79F9@BL0PR12MB4722.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3631;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 1Cju079ZXdOs9yu3SBJngmHO+iGaya7ZKVIZ9iAZFHrCHDZkfsJV1PQQKtXnGKwYrNMgJ47r1HMMHy0JiStbuUnt5YHws/pol6fpGHRptwfGHhCA5wEJAwyvyC+bItmegpIPHOynzoJF77gAuCFuAa9MsmnsqDDYlwK0g4nnJt207ssZzBfogj7xiy6NU9xWrQ4mkXDXaEJ+mqAg94Wyvzgg1I7uLSYCKgECSp6pZBTMQwRYpB7HyTTbLHn7g7Ro7aBtwOdJKzHY35RDzpIR4iAno+NlMpUBPXe5VOENf2M8QTckWG5y4XiPBKYW27H+vKLJnVboXDWj/0uGu7U8c4dyRgKYl9S1GkjVTGdkzC4qOunSPxdIXLRVxGqaJHQfBvP3yAssTC+/c6KcwOr+Hap0eS9hgIKdc3WV30cq8eT3/ur0C1cJgUIZ8X7JOK5arzfe4eJ1xJJ93l22DIbvL5KEfHfBk/iTC1xuyybe8+6WC/vAS+iSzminLq0jfnIt+/P9dJTBwrvtSLQpWsuKUl/ddsBxwIuD8X/bduZSQvMr4brszFL76ODb9KghfyLRS5mxJ9q5JL5430YlJq39UA==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB4488.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(396003)(346002)(376002)(39860400002)(366004)(136003)(8676002)(69590400012)(6916009)(4326008)(6506007)(8936002)(478600001)(66476007)(54906003)(6486002)(2906002)(6512007)(86362001)(52116002)(956004)(5660300002)(83380400001)(316002)(16526019)(1076003)(2616005)(36756003)(186003)(66946007)(66556008)(26005)(6666004);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?kGNn8fmIPIg4+mZAAXlUtVMVyq6vlRDmpy1V6S32UXz/H/bkRFNpiDkvbKzE?=
 =?us-ascii?Q?o1KnyHaPQsECUpckgVMftb483aSB6yZAuDEvo02LS+EtybpAOn5Z2Fd7A8uH?=
 =?us-ascii?Q?tudSzYKKm/nTj+jyNDgaw8k7ytiJvRB1MM7lATN8iI/TY4sPLZan4gMZXw7v?=
 =?us-ascii?Q?BJtSGtZD1xmP08JQDE8exeJYJ9neVDdo/GyexWnyewZaS+g1tBkkmU1F8o4/?=
 =?us-ascii?Q?rlbth7lqMxTsmSpl3bOp4ARAejahBUsOw2jLCLUnHmFYjcU5xgCnsrv0dMDd?=
 =?us-ascii?Q?JwbX23hJOmIeJejXFADYkUzZ9/eXX+X+qwSBCkEw9oPQQbIxEMmLHiB7+aDm?=
 =?us-ascii?Q?DmAQnxDJNf8b0tY1Oku/+I7TiWOIbz9ivMEDK54yiznm/dlAR2Ic8sxwtq0x?=
 =?us-ascii?Q?adNSWDlG46EKGEZYOHfiA/QTtbIN1nZZtAmNxI9Ns11/pXDW5bNjsHztSOCU?=
 =?us-ascii?Q?t28TrqinmqeKXz9/UaajkVEPHdi23P6X6gUGzP6mAGB7/QZKiAWbqcVwwWGG?=
 =?us-ascii?Q?W91dMv8PMoKIHm0cOtA+q2oadUPJEs5y03jcpipGQPrllbix3S7MM0VpfL9M?=
 =?us-ascii?Q?wYDP8oYfRhfziFLb7uommjZRuWVrSLm+UhLR0PAqGFss6UIsCz9Ja6PUbS1m?=
 =?us-ascii?Q?8dF3nIg8eHRXJEcSFWcBDz4rxZT2SHnIN5egMDF+MdBw29yGucf9MRHAqbGk?=
 =?us-ascii?Q?bjxxEswdZA/iyKBccDGgmvv219vEInXiaVBDzqKhfTUISa+bQuy9Z/vZIoRc?=
 =?us-ascii?Q?msxZ6yQAjj1m+WaDtzVaf5NPSvqw+qkjXAoplhC23F7TzL7PJSYWyntl2CP3?=
 =?us-ascii?Q?lmv3koDk6aN8EpRH4VF4dVtxnsW6nGc8QTmEW/Upv4cDfbZEVMkG0lvsPcWQ?=
 =?us-ascii?Q?vUjRvK3BJoW+KaTFAUZHj43RNTbywI+AR2565Gq/hahEscD+V6IUxPO4gVoW?=
 =?us-ascii?Q?rsqjdokj4vwsnEAYWL5m5+ilrsIB0/xm+YT6eUCY6pvqoVbd7/8rlQuM8X/D?=
 =?us-ascii?Q?0UAh6ZBA9cWIeOdYsOaBvMxZXs/sYsHpGPr8eT0URiOod6wSJ+dauG4jRASV?=
 =?us-ascii?Q?nJr3Jpu+Zfs/Z4pUsgnogxoHBVl5bL9eFgRUi2iYEjZOGquMGDwEQ3l0cAsu?=
 =?us-ascii?Q?gTsU4Vg9MZY/nb60RzkwyC70QzGQAoGyuIr4aZdxIJfo2wvU5U922O66DBpP?=
 =?us-ascii?Q?hWV2rn+gcy3c6+OqwlvOIGw4o5fRRRqlea8xf+XhvEwEBsuU4OxRLVpxvodp?=
 =?us-ascii?Q?MTCgZQPmRO1NzJrbL9QhRKxXd41uar5jQ+AcO6s1lPHvEMMtFgl4iDB4Hcw4?=
 =?us-ascii?Q?njj8lLwEZxcsexvL5Tl7EFXa?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 14c7e186-1367-4192-8c35-08d8d9127abf
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB4488.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Feb 2021 22:21:06.6948 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7mPn2zbSXMN35TrSTvEpV65FEY8hpNykGhJYyJ3ei5W6iSCAnnK7OzlzpzSvS1exrZMdaOc019b44osWY+hlCA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR12MB4722
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
 Felix Kuehling <Felix.Kuehling@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Felix Kuehling <Felix.Kuehling@amd.com>

When there is no graphics support, KFD can use more of the VMIDs. Graphics
VMIDs are only used for video decoding/encoding and post processing. With
two VCE engines, there is no reason to reserve more than 2 VMIDs for that.

Signed-off-by: Felix Kuehling <Felix.Kuehling@amd.com>
Reviewed-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
index 00c8ec80f19e..45ba3819bb8f 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
@@ -1559,7 +1559,8 @@ static int gmc_v9_0_sw_init(void *handle)
 	 * for video processing.
 	 */
 	adev->vm_manager.first_kfd_vmid =
-		adev->asic_type == CHIP_ARCTURUS ? 3 : 8;
+		(adev->asic_type == CHIP_ARCTURUS ||
+		 adev->asic_type == CHIP_ALDEBARAN) ? 3 : 8;
 
 	amdgpu_vm_manager_init(adev);
 
-- 
2.29.2

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
