Return-Path: <SRS0=J5eG=D2=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 507ACC433DF
	for <amd-gfx@archiver.kernel.org>; Mon, 19 Oct 2020 14:02:41 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9AD96208B8
	for <amd-gfx@archiver.kernel.org>; Mon, 19 Oct 2020 14:02:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="UqwwROYb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9AD96208B8
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 26F846E9C8;
	Mon, 19 Oct 2020 14:02:40 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2075.outbound.protection.outlook.com [40.107.236.75])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0783F6E9C4
 for <amd-gfx@lists.freedesktop.org>; Mon, 19 Oct 2020 14:02:39 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oSsewJi7SyPCIVpDOB0QQS6B148wquY10PoEk1mMExhaECuAcCdMRW5I1Wmqx0Kz71iXq4jKsxdZHQlWfNQXtNTwN3eEekHpbZ87o8Lr4YySecmaaJdRPt2rPTw/y3xd5nxYe8jWiTo0L1PtZP/fjIhfAKTnGgM2BLKEl9OrHXe3M6yAlT8D8WA2LmNTJMvouAMqQ7pISo2ALcI7WfbnoN4mE1jjzRRFDm2wZBtYZaHBX66fCepPeXsyGu5O2ZW3m9G1WwNlQGM+cVZaovXyjHOT5xWMW7p6XrJa5eA0DZlcukQ68Su8YUL3nENa957eYo2OpD6RQXuQuwfKIzNAPA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Fqz5uEele4Sj8X/90t432AzrYcsld88P+ZrhlZ/ExEo=;
 b=cRsn6UXzIk8HSNSksW6sxdN5yjcNFas2XuB+p+I3pH+IZ2S2hNZ4tX9bLq8HZo6DndAeItL4IxvK9zVEe3c7Hwrz5fWFLzHWWipWcn1YgsJHIjkqgrtCfowYU6BXRbaf16sihty2h9RdRtwh46VH3P/6gdjJf7Z/vR8qvJP9ZRZVA3eaXl8FMU27EB4GblcVFCoJk8MTBysFD+FDkLAq1dq20dUSLosupJNV5lzJnMsj/S4QpokZ6i9tnl4q0KbZ3cgUR2qPjNB7oiljwp3goDRhfxdT6wrBa9GQxPu1azj2FgePCcDpPGwQJJn+okRB3qCzGJSMzmm+9d7wB42IrQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Fqz5uEele4Sj8X/90t432AzrYcsld88P+ZrhlZ/ExEo=;
 b=UqwwROYbEsPLFkh+wMMvXXzvoo5Xc9l0yUruS10VygHhowVbqTfDyg7mmJKLaSNdMMU9phTispYFAJB7alYnLz1uF3pZWYeW+vtYs8cRFggfcRy9zajlGpK/XW7lTgCjaXZNN3h9OZ25sWAqozd7ZdjJ7NC+TTLq27dTPy5ArNQ=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from SN6PR12MB2688.namprd12.prod.outlook.com (2603:10b6:805:6f::29)
 by SN6PR12MB4751.namprd12.prod.outlook.com (2603:10b6:805:df::33)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3477.20; Mon, 19 Oct
 2020 14:02:37 +0000
Received: from SN6PR12MB2688.namprd12.prod.outlook.com
 ([fe80::f013:7c04:babd:3591]) by SN6PR12MB2688.namprd12.prod.outlook.com
 ([fe80::f013:7c04:babd:3591%4]) with mapi id 15.20.3477.028; Mon, 19 Oct 2020
 14:02:37 +0000
From: Jay Cornwall <jay.cornwall@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH] drm/amdkfd: Use same SQ prefetch setting as amdgpu
Date: Mon, 19 Oct 2020 09:02:21 -0500
Message-Id: <20201019140221.5840-1-jay.cornwall@amd.com>
X-Mailer: git-send-email 2.17.1
X-Originating-IP: [165.204.77.1]
X-ClientProxiedBy: SA9PR10CA0029.namprd10.prod.outlook.com
 (2603:10b6:806:a7::34) To SN6PR12MB2688.namprd12.prod.outlook.com
 (2603:10b6:805:6f::29)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from jc-d.amd.com (165.204.77.1) by
 SA9PR10CA0029.namprd10.prod.outlook.com (2603:10b6:806:a7::34) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3477.22 via Frontend Transport; Mon, 19 Oct 2020 14:02:36 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: b197203f-f7a0-4562-db36-08d87437a245
X-MS-TrafficTypeDiagnostic: SN6PR12MB4751:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SN6PR12MB4751FD648FEC3F772F9C28FE871E0@SN6PR12MB4751.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6430;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: wrjiOz7vTYYA1rgE7uR7gXvbSJZsKIwjOAhFTJf1x3Ak+p2zkYSF1AaIL9uUj5VeDy5LmNdSJqnaetCznRrWdxR12SafUdtAoQU/+M+Cnv2G9//azwrlmkyWDgyk+rFwK81homObHM1bz4fUwr0mR6wnwi9CAek/biSs2iMTH/XeV+5wOQg/7F1Hd1bRO3g3q1cGYpcqIZf71R+pLApYP7R8hzP8e2c5FCVAS++ZP0k4tpjANG+gOM3YDNEasoWdVFChYQHGb5yP+0RgAwWDV9SdXx4mGzcH9Qf8NkzGpK0dZnFmSfaFHtyG7bCLzzD0oZlWXo0zdHm/EpbNQrsuVg==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SN6PR12MB2688.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(396003)(39860400002)(136003)(346002)(376002)(316002)(2906002)(4326008)(36756003)(66946007)(16526019)(8676002)(8936002)(186003)(83380400001)(86362001)(44832011)(6666004)(26005)(478600001)(6916009)(5660300002)(1076003)(7696005)(52116002)(66476007)(66556008)(2616005)(956004)(6486002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: j8DKPG2oxx5I+QTO1WE3ol3WVUi6A4pP1qCnqPRgGXVolfbQKqlCX0DTAAGcKer7W/sgN8PjxlRaGAHJ4XFz03PF9nrCQ541IMUTMFlGiTzvxoSvhYcJJJkMkyr5XQRO4SXPnax/MGstxnB7+Zmh62j3SUo3oTOX2jJdF74xxFGrSoTD6NH1RVef3qTGs8D5kf32A77AA1xwKan89+J/ZQby5YQ51AeUOjIwY3XKVQooFHUD1UjNWIKDTR9+SFv/DZSIGwqTYc7gbEDcJ59Q8yafx8fO+1ct+7bHLAR6fRd6F45abZ8uXnxE1T8TCwLy0a1DcPV8t1I9AyktP3sKKQzqRiKB8FyfaB9/Li9rowRMBnC8Z+3S06q6lW7qbCS0YH+gekW5cAoEe7m+yvE7IsLD2Iq8plJ8Pv9byIOTewTmRR9Ny0XoaWE6jQ8Tpcr69yhPAnS2LtjEAM/iRYzI58stij/nkR/NSQpyiNmHdAll3F5Nen8SmhIn8taPOPDie6HaLfE0h4tm5E6p+8CZXcEh0T+o+TI8rXjU1Ls0C2L7KPipv1ztHQt4vdviHD4YdB/QRw+AugXz+i0q225MXUvdQZsmbaaQNx877ugk+t0R2qU6TYveuf/t0cXZLH8Czb6NH9AMQBOzbTCTmp1qTg==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b197203f-f7a0-4562-db36-08d87437a245
X-MS-Exchange-CrossTenant-AuthSource: SN6PR12MB2688.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Oct 2020 14:02:37.0094 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JcrlE2xmcyGAHb4PAZ0y3XraOsAb0sPBuMu3ayuwFeiNZjng9XXtC2jCBLjCXZ8ftH60uR+ENuXNIr/AhcUIRw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR12MB4751
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
Cc: Jay Cornwall <jay.cornwall@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

0 causes instruction fetch stall at cache line boundary under some
conditions on Navi10. A non-zero prefetch is the preferred default
in any case.

Fixes soft hang in Luxmark.

Signed-off-by: Jay Cornwall <jay.cornwall@amd.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager_v10.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager_v10.c b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager_v10.c
index 72e4d61ac752..ad0593342333 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager_v10.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager_v10.c
@@ -58,8 +58,9 @@ static int update_qpd_v10(struct device_queue_manager *dqm,
 	/* check if sh_mem_config register already configured */
 	if (qpd->sh_mem_config == 0) {
 		qpd->sh_mem_config =
-				SH_MEM_ALIGNMENT_MODE_UNALIGNED <<
-					SH_MEM_CONFIG__ALIGNMENT_MODE__SHIFT;
+			(SH_MEM_ALIGNMENT_MODE_UNALIGNED <<
+				SH_MEM_CONFIG__ALIGNMENT_MODE__SHIFT) |
+			(3 << SH_MEM_CONFIG__INITIAL_INST_PREFETCH__SHIFT);
 #if 0
 		/* TODO:
 		 *    This shouldn't be an issue with Navi10.  Verify.
-- 
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
