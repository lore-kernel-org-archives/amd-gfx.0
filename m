Return-Path: <SRS0=QzDn=C2=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E7F5C2BBD1
	for <amd-gfx@archiver.kernel.org>; Thu, 17 Sep 2020 08:54:44 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AB5E520872
	for <amd-gfx@archiver.kernel.org>; Thu, 17 Sep 2020 08:54:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="EruPD53i"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AB5E520872
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 10A996EB1C;
	Thu, 17 Sep 2020 08:54:43 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2052.outbound.protection.outlook.com [40.107.243.52])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 00A816EB1C
 for <amd-gfx@lists.freedesktop.org>; Thu, 17 Sep 2020 08:54:40 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=h/k6hi+qp7FnCdTHUhLVWioMjCocZLvlqAQJiUTor25O0GmRu+06iYXZIDiRcoB48oJIG6ZGAhc1PEQKEEt7aF/OJcTdc5566C8We33BFo6KeFPH/LUWEwVyiG9/KLkKBWsO1RUy8Z6xP00EFCCgG58QpqDklyjB8vQtiIQj1nofIVewA3XOWsyjskEIthcl9ysf5owj/UhXHJ0KHZI9MDBL+v9DtGsavw+nma4Ssl7TOpwmd6AZBGl+QkyUrAIAw3w+cnoDgXyVAaHSFILAj9OLMgXm56fJdyUkAmPs3bdE8R/U0tD7D9/wnrxMNwdLbp/OhqoGxhEkJImv9ULukA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VEUnULePYc+MNsNg4coVmFzwXWN5umq83tJ4t/eNYWM=;
 b=bGivVIcgP3QAXy4DFYjBN2sFUcWB6r9ktqsI6rRSjXvVqzQoY+ewiehmcdYeeSKxapRHFK+D/UJp1g4JeXQ/VXGCW7z8DNQAU31hS4ukAhaWv/saIbyXJA2mRCg9RU6PD70iJrkCDcrUL+l9txvcjFKI1nbQuVuLDft8wbbGci+MDNsVQBk8zxKYPrlEup9L3Vb5NIARaCC+qCNlXnK0q++Hd1dJt6uOTgAA3frgJ09tOjSWcE7KPJBjnqErtJuh0Eda+oEzFENmHOzKOKln956NRsqYZ+2VfcYWzXCXtx9m++qKjbgBm2YFgqTJj4rsFWWDjPwiT8QHwdSsUsWePA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VEUnULePYc+MNsNg4coVmFzwXWN5umq83tJ4t/eNYWM=;
 b=EruPD53iJA0Er8SbdXkf1F9C9w+84iNRwfl89IaZNnJBwWdlJAgvFfxU7qv6b3M+p/YLsp5S3EUopGfHK6UA0GnZlkSi1vwkm3O26BSAK3JJbwSUllt0rY1NsJ64HHPZIukd9qATB51D4iKJp2UaN0MzlzyWOXZCAMZqNgXJ88M=
Authentication-Results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
Received: from BY5PR12MB3778.namprd12.prod.outlook.com (2603:10b6:a03:1a6::11)
 by BYAPR12MB3063.namprd12.prod.outlook.com (2603:10b6:a03:d6::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3391.11; Thu, 17 Sep
 2020 08:54:39 +0000
Received: from BY5PR12MB3778.namprd12.prod.outlook.com
 ([fe80::8882:7436:2fd0:8dd7]) by BY5PR12MB3778.namprd12.prod.outlook.com
 ([fe80::8882:7436:2fd0:8dd7%6]) with mapi id 15.20.3370.019; Thu, 17 Sep 2020
 08:54:39 +0000
From: Shirish S <shirish.s@amd.com>
To: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH] drm/amd/display: fix crash/reboot while accessing sysfs files
Date: Thu, 17 Sep 2020 14:24:18 +0530
Message-Id: <20200917085418.64517-1-shirish.s@amd.com>
X-Mailer: git-send-email 2.17.1
X-ClientProxiedBy: MAXPR0101CA0018.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a00:c::28) To BY5PR12MB3778.namprd12.prod.outlook.com
 (2603:10b6:a03:1a6::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from amd-WhiteHaven.amd.com (165.204.156.251) by
 MAXPR0101CA0018.INDPRD01.PROD.OUTLOOK.COM (2603:1096:a00:c::28) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3391.11 via Frontend
 Transport; Thu, 17 Sep 2020 08:54:37 +0000
X-Mailer: git-send-email 2.17.1
X-Originating-IP: [165.204.156.251]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 49129da0-be0c-46f0-18fd-08d85ae74f5a
X-MS-TrafficTypeDiagnostic: BYAPR12MB3063:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BYAPR12MB3063FC8A5282FECE0AAE5D2AF23E0@BYAPR12MB3063.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1417;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: a9BK4miaeX5aDcQ1XNhwOaz3MQLRgpXlyC/VGUCjg1M74OL16kbnOAUN0yAK1jfaB/a+BitLDlOPJ9dEgtZBW0JEa6KTLYgThB74kAayNUjeRuxwuHDOAK703E6J9b31zmj37RnAn+TrcXL6eoMjTvWoj+6xdf8kluFnmNS6swiQLHLfZ6xk32et24VdwvWfom2irbeghYA4CXSqsD8bTnc6zFf6d5mpm5SvPRT42Zg1Z5i3Xzieo13J5BNPOUG1XwFa1Aa9NrOaB23arD+2Rx1ZceKVTSreGP1B0q1Sitn9e+Wtlb/T85QKQyHBJ87PxNhiuhq6w3AYIyrMgb8msQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BY5PR12MB3778.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(346002)(39860400002)(136003)(376002)(366004)(396003)(26005)(110136005)(66946007)(2616005)(956004)(66556008)(478600001)(4326008)(6486002)(66476007)(6636002)(8676002)(8936002)(52116002)(7696005)(86362001)(186003)(83380400001)(16526019)(316002)(6666004)(2906002)(1076003)(5660300002)(36756003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: DTQtWieovlvoG3yppWZv/F0fFSNGonN32gDgBdvJ01PDJ5q1h7RSfZ3OnXuGzznU+pzGrdOhVirm1uL6HxAEjP1BoxPDdtZmwuM03+zsEoZpwRIkw9UtHq070FFQQHfbLDzLTAb0wXR7ESVSHgZg4JZ3WDSPD0JtdPgTdAiCcV2RzsinmH+UJ1gra5pqFJEwIZia50XwaXNUFCkdrK/x83mCci9+Jjj/DuwYaY8CYfCnZjUxx1OR62qYrenFa5seExbuuywm/BF1VrOU4iqG7k7JQ8IiZkLEVfT2xjht0qOsBr4x+M2hEn5h8SHi7tmzqjnisOqv7gGJdnX2XjkO/gUw49Agx4T89G4nnWFV5XWX0qWnOX+u7w2/ujN3LkwgQssa4jHfBxk8jdY7R7gXIM2lZ9BWCy4TjCWzCkVBzXfc38eIv5g52D+QgaKzoEo/uhNhFJYdrByg5apEe10pWCF1h/or2PlDpHheJxwlIw5LHZw+UE3frjT0n6wiYEiNOwNUvOLxWd6A/QLHYwfg8vyZ/gnSdjFXa31adFVi+yLbYZMtGImPUWLYWqVhDBLMnow8AG+oZFwCDyQt17yiA2UP3NMfs4YkuznnFkoE/4hreJQyWkydz0C9GY+QTFbSo5fbfDnqKDqcmvyhnfc9kA==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 49129da0-be0c-46f0-18fd-08d85ae74f5a
X-MS-Exchange-CrossTenant-AuthSource: BY5PR12MB3778.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Sep 2020 08:54:39.2022 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GngSJmY5Yvc0NZZXh8NLY3RSbdf+1wQHcqDOYu8+AuiYMC+Tjmzmj2v7uwBrhWl5ARFaZ5OaQTLCqFZfNkO29A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB3063
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
Cc: amd-gfx@lists.freedesktop.org, Shirish S <shirish.s@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

read/writes to aux_dpcd_* sysfs entries leads to system
reboot or hang.
Hence fix the handling of input data and reporting of errors
appropriately to the user space.

Signed-off-by: Shirish S <shirish.s@amd.com>
---
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_debugfs.c  | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_debugfs.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_debugfs.c
index 004cd8d38214..8cd646eef096 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_debugfs.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_debugfs.c
@@ -908,7 +908,7 @@ static ssize_t dp_dpcd_address_write(struct file *f, const char __user *buf,
 	struct amdgpu_dm_connector *connector = file_inode(f)->i_private;
 
 	if (size < sizeof(connector->debugfs_dpcd_address))
-		return 0;
+		return -EINVAL;
 
 	r = copy_from_user(&connector->debugfs_dpcd_address,
 			buf, sizeof(connector->debugfs_dpcd_address));
@@ -923,7 +923,7 @@ static ssize_t dp_dpcd_size_write(struct file *f, const char __user *buf,
 	struct amdgpu_dm_connector *connector = file_inode(f)->i_private;
 
 	if (size < sizeof(connector->debugfs_dpcd_size))
-		return 0;
+		return -EINVAL;
 
 	r = copy_from_user(&connector->debugfs_dpcd_size,
 			buf, sizeof(connector->debugfs_dpcd_size));
@@ -943,8 +943,8 @@ static ssize_t dp_dpcd_data_write(struct file *f, const char __user *buf,
 	struct dc_link *link = connector->dc_link;
 	uint32_t write_size = connector->debugfs_dpcd_size;
 
-	if (size < write_size)
-		return 0;
+	if (!write_size || size < write_size)
+		return -EINVAL;
 
 	data = kzalloc(write_size, GFP_KERNEL);
 	if (!data)
@@ -967,7 +967,7 @@ static ssize_t dp_dpcd_data_read(struct file *f, char __user *buf,
 	struct dc_link *link = connector->dc_link;
 	uint32_t read_size = connector->debugfs_dpcd_size;
 
-	if (size < read_size)
+	if (!read_size || size < read_size)
 		return 0;
 
 	data = kzalloc(read_size, GFP_KERNEL);
-- 
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
