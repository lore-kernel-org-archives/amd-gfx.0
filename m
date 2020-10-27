Return-Path: <SRS0=SqeI=EC=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD08EC55178
	for <amd-gfx@archiver.kernel.org>; Tue, 27 Oct 2020 02:41:26 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 631A620872
	for <amd-gfx@archiver.kernel.org>; Tue, 27 Oct 2020 02:41:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="SlJ0mbSz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 631A620872
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E62D66EAB9;
	Tue, 27 Oct 2020 02:41:24 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2055.outbound.protection.outlook.com [40.107.94.55])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 60A4C6EAB9
 for <amd-gfx@lists.freedesktop.org>; Tue, 27 Oct 2020 02:41:24 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DQkZnv6OJzOrC/TJnkpOCKIFNX/H9KU2phG/FujXc6fpgX+M9C6ITLMb03x7kqPrDU3yNMbuXv4tH++FYowCeoiaw8ZBYe9rjB897K+roNo9aDSLJcs8grSw6jTD1KqM9t3AGIaWl3vQhiVf085JXrmSNhKuOrlmTrgqO/4ex2tn7+BLy338HaCsaFjbiuo7YnSI5VcAowwgyRFUayyXwbZfnkf7wwr6n27W3MCbDely6j72hVUYhQSLxQqPTNSVkc8LptyN9NtVsOpbOjL8WnUNmD+yx4WsO8cZfhxbjC2KuZOukf48DhY33yL3dkUHVqpsOoI807Z5DLt4gxMi9g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yxtNZTQZIU1zLqjHAUoF5lkSbMaf/rl0R9gZgRgY3QA=;
 b=UAx7b0Imy6Uz+e8azCUKjh6ux6+7EO9Oz/xdIV3y2n7CnNNESWXtJSajh0/dArcDESVXfliQNL+9pvH5aaAOoIYUuchGKtWr9kAJ6hbFauaxSO2vsYKmt4SAXdRg1Ms3P8rvZrDAh1u4kuDBqz3m2ZT1VB+y7BLc8KAN4WqPPYhnCrg1WY40dbqLhODZlwXqOY1LhOWHkm7XNUipn61YZP0Ch5iA+qzjB8GJmZV3PFAXNucgK/iy9KpwnjWN2NyZguAcu0CMa58q2ZxZ1hE7xYxXaNsnC5A0aulRMYmNkcdzUTvD3ZYl65SmI5gtdQw+oOLT9ZkdqI1G5+fQHAfWJQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yxtNZTQZIU1zLqjHAUoF5lkSbMaf/rl0R9gZgRgY3QA=;
 b=SlJ0mbSz05JX4VLXkIHt/WpRsZjb4BJ4T3sSaT26O/3nbAGBmph6eV0LT6N4zii26Q0BJhS0NnDCgAK0MNwDQllAabPXa783HBKLj3A+v6rM+u4sDRM4r+7KtA77Y+Nn9X3q3aGbEyvKLLN5p9HG4byVtyYDFU7L/uKC+4KuPBM=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB2619.namprd12.prod.outlook.com (2603:10b6:5:45::18) by
 DM6PR12MB2620.namprd12.prod.outlook.com (2603:10b6:5:42::33) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3477.24; Tue, 27 Oct 2020 02:40:49 +0000
Received: from DM6PR12MB2619.namprd12.prod.outlook.com
 ([fe80::bcb1:de80:f60c:8118]) by DM6PR12MB2619.namprd12.prod.outlook.com
 ([fe80::bcb1:de80:f60c:8118%5]) with mapi id 15.20.3477.028; Tue, 27 Oct 2020
 02:40:49 +0000
From: Evan Quan <evan.quan@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 2/2] drm/amd/pm: do not use ixFEATURE_STATUS for checking smc
 running
Date: Tue, 27 Oct 2020 10:40:25 +0800
Message-Id: <20201027024025.32269-2-evan.quan@amd.com>
X-Mailer: git-send-email 2.29.0
In-Reply-To: <20201027024025.32269-1-evan.quan@amd.com>
References: <20201027024025.32269-1-evan.quan@amd.com>
X-Originating-IP: [58.247.170.242]
X-ClientProxiedBy: HKAPR03CA0032.apcprd03.prod.outlook.com
 (2603:1096:203:c9::19) To DM6PR12MB2619.namprd12.prod.outlook.com
 (2603:10b6:5:45::18)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from equan-buildpc.amd.com (58.247.170.242) by
 HKAPR03CA0032.apcprd03.prod.outlook.com (2603:1096:203:c9::19) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3499.9 via Frontend Transport; Tue, 27 Oct 2020 02:40:47 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: cf05914d-1e44-48c3-46a5-08d87a21b6cc
X-MS-TrafficTypeDiagnostic: DM6PR12MB2620:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR12MB2620D0269FCF2ACB57B4A7C9E4160@DM6PR12MB2620.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:328;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: sk+7aQJ0GWr6UmEahf7mdBYZrtx5e5Ia1+eyGB+L79pkV5GCdYoFKcQ14abhHKHN937td4VkFP4bvBnRhT5XDkJPUL+wwcvtjD9Yq0d7/GvIwRVMKwn9ONriCChhiYGlWWa88haVd8eLUP0ZlAJg0g6t3Dbo91g6Tq2V8Uf6lGeOGRxerVO+YUaz2pgq69vgCtmlR5oM4vrqDp5DmVeLqOgPNzeXyFWOZJJFHRAmP8hvff+jrk5bhJYw33gs88peJcJp458L3GfIOjfI3Pnppg6TowkGNpyHFKA9+Nmn2ZMJMJW9a3L3jMHY/3fJysqQz/JlHmBsCSJMh1glW0rPzA==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB2619.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(396003)(366004)(376002)(136003)(346002)(39860400002)(2616005)(8936002)(2906002)(956004)(83380400001)(6486002)(316002)(86362001)(1076003)(8676002)(478600001)(26005)(16526019)(5660300002)(6916009)(36756003)(6666004)(66556008)(66946007)(44832011)(4326008)(66476007)(186003)(52116002)(7696005);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: FjZgOkzdpbw6Wg+SjIW4vLGmMZiQOY4Gm9oeX2fkz1u6uzlPoCvPrTyCQBFRYIh3KcqkDnzvGKATn6oo4W3cAYEMzYhY08kSFGN1OhTcy1DTvzsaIBWV94QedPbT+djxelthpPdYNFN0Wd/Wq5fXFlGpGfBvymGuQHeErqb2BSNmHMSliuwv2audFg/ZlzFKQofNxj1Oxri4GYDctDrdXDb4qMrUCz5DBtDFuOx8NmOwmxe5eW4SHXjOMEwotZ7nRvsj/fhSP1IXvV7/fzIhahEqCNq7huFCMIuUhNVd5bBKZZGgQ4W6DQoZzzsXBIz2AX8BC5ZuPYJUf5N7Bej1lYfK/7ywjLClcqt4Kjwr/LPeB+G8tVzbYEOoBYgkQ899VQ1zVkpF4k9QKJ8QHHlaTBtCXWj5ohHc+MOWzSnupGCQyNborXW8j2UHG4GrQaV6x6OVSz+JRGS2Nf7gqXFPl/nPgZk8b8lv5xsoXHS8Ao085QFv1Ffg8TOgwqqvjfnKzn2Ib3LoBkR36u4W30owrxhm8+5iq9HMG7FIsypKAMwF40CYuZ102cQ63HFhKQZkJjVeJMTLwXGvYn5F1lPl3VxK1VtGRizJ6tCKu4pw8+gmP+5ScXcb7iKYtyk0wQ49Q9DSAjCaMpJYUabIfqKUNw==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cf05914d-1e44-48c3-46a5-08d87a21b6cc
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB2619.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Oct 2020 02:40:49.6682 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Mr8boSNqVcd4TqzE0TsBS08zg6dJbuEa4mGt75yZBoa1B8qLRY0c4TaBagTHljDk
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB2620
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
Cc: Alexander.Deucher@amd.com, sandy.8925@gmail.com,
 Evan Quan <evan.quan@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

This reverts commit f87812284172a9809820d10143b573d833cd3f75 "drm/amdgpu:
Fix bug where DPM is not enabled after hibernate and resume".
It was intended to fix Hawaii S4(hibernation) issue but break S3. As
ixFEATURE_STATUS is filled with garbage data on resume which can be
only cleared by reloading smc firmware(but that will involve many
changes). So, we will revert this S4 fix and seek a new way.

Change-Id: If9eed2f5a9c1168fb20be92057b583d854ad779e
Signed-off-by: Evan Quan <evan.quan@amd.com>
---
 drivers/gpu/drm/amd/pm/powerplay/smumgr/ci_smumgr.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/powerplay/smumgr/ci_smumgr.c b/drivers/gpu/drm/amd/pm/powerplay/smumgr/ci_smumgr.c
index e4d1f3d66ef4..e772e2dc98cc 100644
--- a/drivers/gpu/drm/amd/pm/powerplay/smumgr/ci_smumgr.c
+++ b/drivers/gpu/drm/amd/pm/powerplay/smumgr/ci_smumgr.c
@@ -2726,10 +2726,7 @@ static int ci_initialize_mc_reg_table(struct pp_hwmgr *hwmgr)
 
 static bool ci_is_dpm_running(struct pp_hwmgr *hwmgr)
 {
-	return (1 == PHM_READ_INDIRECT_FIELD(hwmgr->device,
-					     CGS_IND_REG__SMC, FEATURE_STATUS,
-					     VOLTAGE_CONTROLLER_ON))
-		? true : false;
+	return ci_is_smc_ram_running(hwmgr);
 }
 
 static int ci_smu_init(struct pp_hwmgr *hwmgr)
-- 
2.29.0

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
