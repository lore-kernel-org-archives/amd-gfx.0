Return-Path: <SRS0=hzAD=H7=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2DC9C433E0
	for <amd-gfx@archiver.kernel.org>; Mon,  1 Mar 2021 02:52:10 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 82B2F60C3D
	for <amd-gfx@archiver.kernel.org>; Mon,  1 Mar 2021 02:52:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 82B2F60C3D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 03A5389D53;
	Mon,  1 Mar 2021 02:52:10 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2066.outbound.protection.outlook.com [40.107.220.66])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 36CDE89B67
 for <amd-gfx@lists.freedesktop.org>; Mon,  1 Mar 2021 02:52:09 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bqTRzmBJ2wFJ+UGE30cAuJnP6t0SzNn/J+utWHlzmDBzTygS0lM1nDSk7ohQE5SODrwVTQJP+0iwVlN8pDltXNlrTYDeNJyRlIMY2p3+Nfc1SRc3WLpg320RPSiPL1UR9lPWYxAwAe2yqyc8V6f9SyNr5M2fcAkgMEx8lBnVivnV0bN0S8lMbXnGLQwrIr7171xrgALrt2NY0LDs8L3vNMmztK1GpXdJ2ceMQp8fvQGSG9uD4c6KmZljuG+xm1NZgB99WOVq771UwYpdMaPJnzEctSo5phdw5QSynO199vHvIYdq2+h8osm9ZiyGVzGOHp2d+FOA71viL226SQYVuQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xDQqcgvoodIhkw3R03MIufCI8Ysbj/UiG1WLIAzbDmw=;
 b=T1qbgy7xBHuBUdfF1r8+9IbaEeoLSRFEg6zQfkCYXNPOQII6Su+fPXuS9ATZHmCyPKL6KHgoa0a7OJKe+2Jt7T2d5ex1wQZdRljO+aeNNttm5MT5o9pUOtLI1Y4g7U2nI2HKnpV1ZQ5jF7RtclJ9oKLcZDzt7YAsOaa3z5zT7Pyi5Rj4kH2OHTZ1FI1GyhJGOLJWL+UpHYVGojiELOseQGY/fFokOnXbbbKxbIrmn4YGTFi8m51iDgvPGD6jSfZId0V/bHwMGwUAyyPjPm/CSDDGZFP9R+o7116gLR6tnpuAgh0rUsiRjX2CLQ6zyj1hPdS8tnRVkp+UtKoRXfL72A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xDQqcgvoodIhkw3R03MIufCI8Ysbj/UiG1WLIAzbDmw=;
 b=nR4CgI/IcPk1AW68cH5+YsIdwhMysKSr8UqFZ/EKsrWR5wTBOMku8qbnsyJ6bOEyGtS3PTeZNhILB6dIdduPE5L8J3ISnxHLEEvpoAxhVbzUtplUWswo//0BcLxBTqMleLEJCDFfvE2VU/7Xq7RUl9C2+3Cm1cet/Q0izo4u9uE=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from MN2PR12MB3022.namprd12.prod.outlook.com (2603:10b6:208:ce::32)
 by MN2PR12MB3503.namprd12.prod.outlook.com (2603:10b6:208:cf::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3890.19; Mon, 1 Mar
 2021 02:52:06 +0000
Received: from MN2PR12MB3022.namprd12.prod.outlook.com
 ([fe80::49f7:4979:3a0a:4554]) by MN2PR12MB3022.namprd12.prod.outlook.com
 ([fe80::49f7:4979:3a0a:4554%6]) with mapi id 15.20.3890.028; Mon, 1 Mar 2021
 02:52:05 +0000
From: Kevin Wang <kevin1.wang@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH] drm/amdgpu: correct TA RAP firmware information print error
Date: Mon,  1 Mar 2021 10:51:30 +0800
Message-Id: <20210301025130.17402-1-kevin1.wang@amd.com>
X-Mailer: git-send-email 2.17.1
X-Originating-IP: [58.247.170.245]
X-ClientProxiedBy: HK2PR02CA0214.apcprd02.prod.outlook.com
 (2603:1096:201:20::26) To MN2PR12MB3022.namprd12.prod.outlook.com
 (2603:10b6:208:ce::32)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from kevin-ws.amd.com (58.247.170.245) by
 HK2PR02CA0214.apcprd02.prod.outlook.com (2603:1096:201:20::26) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3890.20 via Frontend Transport; Mon, 1 Mar 2021 02:52:04 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 32344a91-5a81-471f-16aa-08d8dc5cff79
X-MS-TrafficTypeDiagnostic: MN2PR12MB3503:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MN2PR12MB35032F393A0555131CB9FC8BA29A9@MN2PR12MB3503.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4502;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: SYWymEYvBkpzGCV5qooFZ456vLXGCqSzVo6pnYUq4tsdvCkzycx+L9FyBf1NFASWpzlyDBUTwyT+dLX36pqvHOWkrg7Hl0OOZE2+rZqdKw1pqVEMDGJQbeg46dAU8NtVBQ2FPbuQA9Uf+mRUYZx6qSeLwBi8ZsMbjMSYKtH5GgiQUreM74Gwk2O9a8bVtv/wxfVtHPsaoP4BgRLdo42rfKq3oJVZlZGXTjvTxSwmGm7i7t9srjTa28FOQV4jEX09XnZPgPtPD9RD6n3ssBJG/6en+we72gGKdUWKXLGoBvQE2OIaDf19TY6FI6jYbFYmlmKCQAIT32SH0oa6eOBY2vfoVp4tzk81f4xO3OGx8hUp9A3OF+jchfymps/lEy1hA22Jt6j++OQFIpLe3WpC8hO15ZfM5HS2wqwOKEc5hYi2ogkXmN4z3mucezHaWofagmoAjCbyY/jTtvWJZAmPQ8LpZEPqRxCZIWIPFe6JKxyu9n3hpneE1lJWukFs3whtOSI7FQ+9OT5wjmD8+NfEOw==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB3022.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(39860400002)(346002)(376002)(396003)(366004)(136003)(1076003)(16526019)(4326008)(2616005)(956004)(86362001)(2906002)(8936002)(478600001)(26005)(186003)(36756003)(6666004)(83380400001)(66476007)(316002)(4744005)(6486002)(66946007)(6916009)(5660300002)(66556008)(8676002)(52116002)(7696005);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?Np76GLIk/7hwyGDCoq92ijZYyxYorVedp4RpJAf4rC5cUpv2XsXyBXtJcURy?=
 =?us-ascii?Q?PRYQxkgtYI1T3+opEgEfH2TkakJL7Yznc9n8IJdgdYX9VTpqbdwRhSYy5PFj?=
 =?us-ascii?Q?5AXYgSKKBqcbUT5q+VeUaCbXxKi8LR1lIaXkIZDq9w76CXRCyXy9bpQUwdpD?=
 =?us-ascii?Q?TuFL9tR0YCqccdlD7Jo9RqQ+ivG1HkMeKPb3sQs3p7G8S/5Npv6V3JIfYV8s?=
 =?us-ascii?Q?h82wYUN6FKKor2bBPoT/s/6vomacqMB74k9vwEBwXkCal+cPaEUcOs+R6RB0?=
 =?us-ascii?Q?jyLkpbNJOUWruXMRKmR3JZqXfF/MaE4934iHz6TbuY2D5401idB4V5eLevJi?=
 =?us-ascii?Q?GfqVCEGAIuoP5vY1T+mGM6IF/GtvEtEvUF69ebmjptoN/UtLxY3FfvTtYMOc?=
 =?us-ascii?Q?qoK0V/rcX0RWZL340G9xRduNzPSDm4BoNhTP5ZF1Ja0UcXwOleYSLCc1SFhg?=
 =?us-ascii?Q?7rYzQiQumiSwAH0UdfxZZqC23rkNxpoyW+yZKb5h8TwcgQ6KSjVzo5FnLhpb?=
 =?us-ascii?Q?YBWwhTisllKQhPETP3rf6GfqPXEBT9SRKa2RyAjMRwcdxaaqNoz1lnuMmz4p?=
 =?us-ascii?Q?s326lvo5hoNrSfZjAp7HYSVyhDKJc+f6iw7wZ9AUySfjc3SxM9KyQu4Wd8rE?=
 =?us-ascii?Q?QfZbvlGLVk3I4RgX+ed8/ZHSGsaJGKxbOxGmZqR/YtYbL9bL/N2kDn4uyApC?=
 =?us-ascii?Q?3BL2nhvl3UxFDFYLSzdClbAoMTjK/5lyjD19IdFBcTmpz91vQsA4HhNVZqdP?=
 =?us-ascii?Q?bo+JkCjBk2BfvcDfQT4P8tfSWzZMEtxfDjpyGomm8Mp8omnt+5mqveOvXIDb?=
 =?us-ascii?Q?OSa3Qq4+LNlHnyFPGta5IQ//uthH+T45W8gskSMLY3DDgeoj381OX/3W/f6H?=
 =?us-ascii?Q?4qLaC6Il6ZMMCiHPpOfeemhn7XuafR7Hfuv7mjOF2QBuZtwigSwQS/I5Z07N?=
 =?us-ascii?Q?lG5DaO42Dal3NC4A1VQ6Qxnu92OxRV98ZVzHLsjUHJuBfiAu2uT+dvraHXx4?=
 =?us-ascii?Q?ZI5BhQRbRdWzFBWfvWljfe+qeYmGvldas5JM6RaHuqAzUI+voP7iLCgpY6/v?=
 =?us-ascii?Q?f5RxCILIyOe5JKFMYJhkEqytncRn2PlipLXnvUmmlpNbG6A5X5FmqUPu0aFI?=
 =?us-ascii?Q?gk1n8HBKblfM9LHM3pVz5U2UEMFvZEMGxrpjlkW73vloCV+djZiPRMIBmSAS?=
 =?us-ascii?Q?rRwo1DIg53d0ucOJETgZfEOT6FWMSlaUuzyEJuI1JC8vAZVFbHvSL+6hJqXX?=
 =?us-ascii?Q?vwqmoZUQfHTQYKq2/e9pHUWXGlqJXtxQ6jLRztwQ5n+3nTxJa9um7ERoqu5c?=
 =?us-ascii?Q?zuEqvFwZLFtGoSp7GDv0HpVG?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 32344a91-5a81-471f-16aa-08d8dc5cff79
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB3022.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Mar 2021 02:52:05.8050 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bld/wNad30GqvXp4SHvaz6CUAsOgpJxSWqpyJRi9+mmNuEr/rD/RBOFpZEfgBhiu
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3503
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
Cc: candice.li@amd.com, Kevin Wang <kevin1.wang@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

miss RAP TA in loop ( when i == 4)

Fix:
drm/amdgpu: add RAP TA version print in amdgpu_firmware_info

Signed-off-by: Kevin Wang <kevin1.wang@amd.com>
Reported-by: Candice Li <candice.li@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
index a5ed9530f542..6c8ea9d26320 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
@@ -1472,7 +1472,7 @@ static int amdgpu_debugfs_firmware_info_show(struct seq_file *m, void *unused)
 		   fw_info.feature, fw_info.ver);
 
 	query_fw.fw_type = AMDGPU_INFO_FW_TA;
-	for (i = 0; i < 4; i++) {
+	for (i = 0; i < 5; i++) {
 		query_fw.index = i;
 		ret = amdgpu_firmware_info(&fw_info, &query_fw, adev);
 		if (ret)
-- 
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
