Return-Path: <SRS0=OtMv=C6=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF429C43463
	for <amd-gfx@archiver.kernel.org>; Mon, 21 Sep 2020 02:50:31 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4CB3C20665
	for <amd-gfx@archiver.kernel.org>; Mon, 21 Sep 2020 02:50:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="BA666k+N"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4CB3C20665
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 760D589C55;
	Mon, 21 Sep 2020 02:50:30 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2050.outbound.protection.outlook.com [40.107.237.50])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9D81289C55
 for <amd-gfx@lists.freedesktop.org>; Mon, 21 Sep 2020 02:50:23 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DRrrclSWcpOBjwqXiH+MQfrUuX15vQ1nH/MJ6RP2ez5fsfvxSjH7jqe39SSRCRH02++UVEF6hkSS4B3yoq84SB7OXLbSBLNIYtsk7S7qf5Z/Av2PLyqnVFBweJ1gKfkmyz0UvjwwYArE7SqdLOXpIOpjqd0SEHiufFL4CI6g8gsHp1YsnucJMXmVmFTqoEwys2be0QjlJwy+3A1xItSXvPUIwo9v3eYeWAxVbw9sRqggPCQquARkugz4lkL7HRzgvXaZbeOQUlbpu9BGzGEWcrMmIxdUjWyAammULOZSrBetmoWB51YEivNrtITfs/zHTPYD7YFDIt3FV8Ubnua36Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+KMUCJyrU6nNbM0GyTRNC0NDZY6nt1oVi0Ql4ckETZQ=;
 b=S0biXyF1zuHee8iIKD9kNVNzBiDsxX9W9YYetr+zBzc1FmYn+rT09mAvhCT26hzYy1hWQy+TFdG3V1bVrC95Fe5qCDEfHU99HpGvyQQakMZUk40gdcoICDbsz+7X4uDtjrW5tlPgPnmuJw2a82Ek0Dc51RY4prljWJjif3Q7KGQSC+hvczrJQEQRwets5UeIvzhFV+D4H3iJ1wL9PmjmOo1o0qO6iAfjGJknNiS20VVyUVU6Btb/omyNUMZzsdTF+iqQEz5NdG/bQnEi/qgkl1jYwyv1IdlsD0hyiCBo4mRMA92zPWEvDAa1f7jsRvEr4eDi4T5neugSM8tkcigGnw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+KMUCJyrU6nNbM0GyTRNC0NDZY6nt1oVi0Ql4ckETZQ=;
 b=BA666k+NZyZUiXHsPWMGy8sG6l8RmRgb8zeOyX/i+5wKe+2SRxtIj6xmWf4Tm+mBFuaNE5MBaVUYqhs07mUc5yMXlw53ru1LgKB5DzzIiJv0H2U1dMLfBqNCxG9Ads3L2g9J/c9yL8D1+AX63l8XD/zw5eRS7oF4VnDbjH5QSR8=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB2619.namprd12.prod.outlook.com (2603:10b6:5:45::18) by
 DM6PR12MB3084.namprd12.prod.outlook.com (2603:10b6:5:117::25) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3391.11; Mon, 21 Sep 2020 02:50:17 +0000
Received: from DM6PR12MB2619.namprd12.prod.outlook.com
 ([fe80::bcb1:de80:f60c:8118]) by DM6PR12MB2619.namprd12.prod.outlook.com
 ([fe80::bcb1:de80:f60c:8118%5]) with mapi id 15.20.3391.024; Mon, 21 Sep 2020
 02:50:17 +0000
From: Evan Quan <evan.quan@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 2/2] drm/amd/pm: drop redundant watermarks bitmap setting
Date: Mon, 21 Sep 2020 10:49:48 +0800
Message-Id: <20200921024948.15164-2-evan.quan@amd.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200921024948.15164-1-evan.quan@amd.com>
References: <20200921024948.15164-1-evan.quan@amd.com>
X-ClientProxiedBy: HKAPR04CA0009.apcprd04.prod.outlook.com
 (2603:1096:203:d0::19) To DM6PR12MB2619.namprd12.prod.outlook.com
 (2603:10b6:5:45::18)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from equan-buildpc.amd.com (58.247.170.242) by
 HKAPR04CA0009.apcprd04.prod.outlook.com (2603:1096:203:d0::19) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3391.13 via Frontend Transport; Mon, 21 Sep 2020 02:50:15 +0000
X-Mailer: git-send-email 2.28.0
X-Originating-IP: [58.247.170.242]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: f4e8a080-adad-4c51-c60b-08d85dd91249
X-MS-TrafficTypeDiagnostic: DM6PR12MB3084:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR12MB308458ADB2673352F0C4D5F9E43A0@DM6PR12MB3084.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3513;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: vUop/h77pLo2dKpzmejDRT9WkR21R28HtvYzJUdRoU4R+zslxwy7TrK2AY4dSL4GMO4r0YDM7ofBC9RUWqPLia1Vyl6kcCYDqw8EV9dMx9EJsTJyalapmo0/6k6cwH2eTX9txHvRiTCcvbsCNGRgY5EvQNKEFWWEgMymxtm97Mhrq0jpIpqIDTPy+Pl5I9YmhCM1qL0sQ2C9AE7wzM4Syvu4l8ijMtc0CgrxNLiSWNDTrJR1zcmpfi/8MjJdGhSp7Im9+syenGd4ie9UrdA84bz2vdzaUa3oimJZbJ1Hs2WGgyNPCg4mRhxY0Hu8E+by
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB2619.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(39860400002)(376002)(136003)(396003)(366004)(346002)(66556008)(6486002)(956004)(2616005)(6666004)(4326008)(44832011)(66946007)(8676002)(8936002)(66476007)(186003)(16526019)(7696005)(1076003)(4744005)(36756003)(316002)(86362001)(6916009)(83380400001)(478600001)(5660300002)(2906002)(26005)(52116002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: tce2lMJTL4U8i7+f/W/mrvYpRWYIzBF8aOgISLuV4yUAyaRbf20ye5aIOJWx9o3lW51Z8BXtQnuIbIs6iSvf0wKyXdbDbfoaJvH86N0N46YnraYbgmgCmZ/bN36Xwu8iY7TXnlFdT1ax4Tjk8fUr6jsCJ/CrML21Cg9gc1SzxIflPb1VcGRIf7gAFRZ2EZ1k1Aubgx0JEvDQbCv6z18i/JFqUXgomUd3iKAbbruLehX5m+6xW0DmdqaiCk3ajQK7eXGUr9YjwHWfzDkEaEkxPaJ3VzK3BF1Nz/uMrCPNBwk+RmuT9NH2M+fJR228HQtcoNPbNloQWdgbig7v4fNd9uF3ZMFIakrAKseX6Cxe0raepxOvZ+wWX2VDZys0WB1rlHZGtNNPGYvn7doslxvvCpnETr3fUceO3dZvXhjKYkyLeQJqFoC+JbmiiFncKjEvEDYxClYdeZ0wPpptWvOYRH64LJZhOa1xOsLu9+zJ3g5KfZ3QeyayINCJSPXyL0VwRppLr/8QmTnDBLjVQedCGD6qr+vP/XPlz6Xd2tUJ8HH7/F9lUin+hSATRxw9WWXQGLdI3I/ggm6acSPTtWF8+pLKQSVrtVzggZXn9XNgqEP62x4nZ4rphkTPaPD8jDumc6FsRKJc+Isrs2HMZN9rXg==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f4e8a080-adad-4c51-c60b-08d85dd91249
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB2619.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Sep 2020 02:50:17.2784 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wq0yj+QCAc/9LabXCSiw6bDjpt8Yf7x/+Oajt2nndcdNm62lTf6aFvhKd5GeCIlI
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3084
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
Cc: alexander.deucher@amd.com, Evan Quan <evan.quan@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

As this is already set inside the implementation of
smu_set_watermarks_table().

Change-Id: I4d4d40855f0aad43f6d21d471b64f1c7e696f0e7
Signed-off-by: Evan Quan <evan.quan@amd.com>
---
 drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
index 002bae81b856..ef10be599d37 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
@@ -1838,11 +1838,6 @@ int smu_set_watermarks_for_clock_ranges(struct smu_context *smu,
 
 	ret = smu_set_watermarks_table(smu, clock_ranges);
 
-	if (!(smu->watermarks_bitmap & WATERMARKS_EXIST)) {
-		smu->watermarks_bitmap |= WATERMARKS_EXIST;
-		smu->watermarks_bitmap &= ~WATERMARKS_LOADED;
-	}
-
 	mutex_unlock(&smu->mutex);
 
 	return ret;
-- 
2.28.0

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
