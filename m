Return-Path: <SRS0=DKNW=LW=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74C51C49361
	for <amd-gfx@archiver.kernel.org>; Mon, 28 Jun 2021 17:26:10 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3CA6961C31
	for <amd-gfx@archiver.kernel.org>; Mon, 28 Jun 2021 17:26:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3CA6961C31
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4B0216E4F1;
	Mon, 28 Jun 2021 17:26:09 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2083.outbound.protection.outlook.com [40.107.220.83])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2DB316E4EA
 for <amd-gfx@lists.freedesktop.org>; Mon, 28 Jun 2021 17:26:05 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dGXjyy5HZGRKNsJFyHMl9bjTw6vaqGA1qX7y6PFzFjsJEsQpbkq9WW1rIw17A/1IVPqjX++xHjAhrBzEBmEaE1UdYFPXue7Sx2pC9E+rEfLmtvsSg7t9rO8QzT6y+GBRhQGsK+Za2dOgm3BOzODyZ0IF+fC+jW15dJs622UnyHkusi9YOypneoUbJ8lsaA5VPNtA/gDVBr1k8fHL08zdrw/UcHuAP8hYcIdtukB0ExTpTZZKjt/rM8m6Ska6Rqnuelikfk0WKFVRESqb8MPEYzsVYdrTmp2IT6lQ85KzKHjxWIUhItCBE9UrQzI/ZxaniADz/Upx9zbzXt+foCZfxA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G2bS+ZjLP1vyH+HWSkxxW/f3FoKMGdENhkStSUFlhwI=;
 b=EyqQiIgo1hY6ypAxdG4I3yXyS+2MyW2+6AJF98TN/EJdKf5yzzzIpMP3q6ffut487dYvbYSO4K/ppFy+I4j5eF3iEq+1sl3ICcehqORx+iGuYIkGUw29xh3JKTMzo4NmJc6+qddSExa3MFy57BLf9q13GtiMtkk+SKgmhsMWu32kzn8nVATjZTjPZpzR4YFF3BW+8fR1fi97gw635sJhGSQ/X4zABZW1MTUgPG2Odx+SV1nuD8gFxGMZEFWhOIaZlNmgUcpQtxGTFzNqD5F26Yk/GDjC9vOkE42RxIFeyLRvZ8E+YEkA/x5vGu3t9xrkbt1beay9d+9m0o/KJYOp8Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G2bS+ZjLP1vyH+HWSkxxW/f3FoKMGdENhkStSUFlhwI=;
 b=WirWpyXk8XHRy3M23tuJq6Y6an1Dgr2MBarxPkv1wkIsLE0g+gm72mtZ4loxaCRYwuqg8buJl+I80O34YiPLRHxOECKPeuIsKpa24/s+uzkMT3ul4kqnJHNotsSByZOdLPQjzpm/ALdo748FRa7fOhU6qCpNV8QwDhNji62QR/Q=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB3962.namprd12.prod.outlook.com (2603:10b6:5:1ce::21)
 by DM6PR12MB3963.namprd12.prod.outlook.com (2603:10b6:5:1cd::29) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4264.23; Mon, 28 Jun
 2021 17:26:02 +0000
Received: from DM6PR12MB3962.namprd12.prod.outlook.com
 ([fe80::6034:e3a9:274c:33a4]) by DM6PR12MB3962.namprd12.prod.outlook.com
 ([fe80::6034:e3a9:274c:33a4%5]) with mapi id 15.20.4264.026; Mon, 28 Jun 2021
 17:26:02 +0000
From: Luben Tuikov <luben.tuikov@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 2/3] drm/amd/pm: Fix I2C controller port setting of Arcturus
Date: Mon, 28 Jun 2021 13:25:45 -0400
Message-Id: <20210628172546.65492-2-luben.tuikov@amd.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210628172546.65492-1-luben.tuikov@amd.com>
References: <20210628172546.65492-1-luben.tuikov@amd.com>
X-Originating-IP: [165.204.84.11]
X-ClientProxiedBy: YT1PR01CA0083.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:2d::22) To DM6PR12MB3962.namprd12.prod.outlook.com
 (2603:10b6:5:1ce::21)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost.localdomain.amd.com (165.204.84.11) by
 YT1PR01CA0083.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:2d::22) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4264.18 via Frontend Transport; Mon, 28 Jun 2021 17:26:01 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ae7acd62-1bdb-42f3-d479-08d93a59cd98
X-MS-TrafficTypeDiagnostic: DM6PR12MB3963:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR12MB3963E5338B321891C75624AD99039@DM6PR12MB3963.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:109;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: l6xFnEKKt+HWAsttLLJXnIGwDhQsQjYTziuyGG3DRdLyZEfEndiA7bFRwmzcxxbRb0EApxhWWz3R9RTte9TbHP0i1D9LhLhha9HEzJ/B+RSUzRgmkDGcJt/yY7KbpaseqqgPN5hgBlZ2AlZoK+SbTOCl0ykRC+BrWlUMsM529of3Wv82Xj4/I7Lpqd4LduABSPAeTiNFUJAw3jePVngh2CmwF7Elt2TDZD4wdlGG2I7jva6jwzZMmtpTt2TV0P9tXC74E0vxdrUmhFU24DHO6UXqpqB6Cd0y+uQdsAAKEs/v6vyOoXiMxDeIJp0JQeoJbUYw/59wywoqqZmYiAa7mvOpkfdTM7aO0qToJYfg0oikbvtq8Duwv+tI6477odxGkelyCgdxCvxAdY6Nq6HZJ2DYaFefFHQw5RiKy8AfxkhZ8h8JL4yy9bjaOi0IL3hhjzfkWmdKngO2/pgInm21t/urwrNp1axWgSXoe5Axk9KtMpXe1XlsDIZcgVPJf+5jfk4rEJrCbH/vyjUFvVsvyd42cxALOBM6z3DTz6dzZPG2hujGTFlL8OpzlvN7NsKwnlYN8BVZau6gMdwsr7oLK1AlqKxoUP0Pjz6WJHZuzRE584GiklvGXtIF8FsUOEPfJRcZwrxUB+DbJqqa/nG92XrCii3XL/Eb2W93d0rDS+EgYVyNIU91OZufBiZq8PkSLWrnOa2TISDnQGv6sIUcsw==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB3962.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(38100700002)(44832011)(52116002)(186003)(86362001)(4326008)(2616005)(8676002)(6916009)(4744005)(16526019)(54906003)(8936002)(6666004)(956004)(7696005)(38350700002)(66946007)(2906002)(5660300002)(36756003)(6486002)(1076003)(66556008)(66476007)(83380400001)(498600001)(26005);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?aYJjTLhRSXxdjudDPpywa6JF2h3OrTLaQtF3PqIV2z8zCb7EBmBPpy8m+FYK?=
 =?us-ascii?Q?+m9hn+1952v9WDfpidhMJCKEMDkUdiZdOiN2Vx7XEfQ64thFNquBjdyB/qOH?=
 =?us-ascii?Q?3vwYir4T7Gc7Gvk3nJFbeeM6/sxyQAMmXNSTnPTp5qlk9cxnaCZkZq8OeR6M?=
 =?us-ascii?Q?mjkZjpaqlxQ0KdmKxeAh5y3sudSy2UX34iV2Zm4krGbfqT531fkU4Y/jJ+PC?=
 =?us-ascii?Q?H1jSl/hhVHj/Bv1wUFtiNm2LDZXmmhynW8zlJgvEJKppdRTsIOGojVWkxkaA?=
 =?us-ascii?Q?ISKCMuTP81A6ixqr0t1MH5sr4sqDKdCg3Fs1Tm26iveycYo0dEqrWo1TJ9s8?=
 =?us-ascii?Q?1ya2k5Gzoz+TdS+LT6F3hD++SlaYmkt5LnnfTxH3VAb38g2tES38/Flc651B?=
 =?us-ascii?Q?Sx4zlCsRj51iyM7y9sY7mu265sV5fdoJZan+Jpfn1DDOQumATF2zibM/HiAN?=
 =?us-ascii?Q?VG+BVMBG9PmEbS8xB4vQKnDB4cLg8PpkgbrcVZrsSMHG6att41/sD2NDfbrp?=
 =?us-ascii?Q?dHNc3dZilxol8Nb8wrpQgijTLGOb4PnjkyQnLhEC4mI4ww95EMh0ynu0PPK0?=
 =?us-ascii?Q?BLdmrTFBZXesZQFkPY/VBfrYXqvK/qwwBt9130AVAEV7RmEAcQBCwmxjpC6j?=
 =?us-ascii?Q?2od0uMnXbiHhaB01xZmzlEPuwkkvrYAgrj5wyWlg0j2dE9bl+SsqKou79M6T?=
 =?us-ascii?Q?dK5iw3cGFfDJdkS/wpF5wfTx5vFlAgo2roQE8wP18tWQcBqcAKm7IKpjI/xT?=
 =?us-ascii?Q?frN+GUW1Xu4lKrh0jaH01PpMyjLNJtJ7AYtcJeZZMiqlFTxHTnhuCQ6oT5Cf?=
 =?us-ascii?Q?OIUl8AKo0q68G5KZ/Cdz8WLmHtqVZ5yQSLSuz+W6lnqXHy3VMcPdj1ipZkMB?=
 =?us-ascii?Q?aa+thNJLqh6nN/0eotcXgqF1HqRMyd13WD+AYxg1jnUCD3K192f19kSlTcRm?=
 =?us-ascii?Q?2kYcfJDPMTziAD0tAZhhU4SjfPJ61vHU6TyGRwVEyu0HQXpHgjAjTkVn/6j6?=
 =?us-ascii?Q?cCID17nNjI4AqcrZWXaNOF28d8xiUZnXaGSzaeS/M4ORk0fo8kfHErGCHhQN?=
 =?us-ascii?Q?1ZcSIOKI/s4OZ/PvCgz0P9UeeZvExrrEoa2WmLk7RglW27cnVEmDcRf41+Zq?=
 =?us-ascii?Q?KYX1mbg54K1xmEWxAvg5qISek0iu9bKEi/WagL+vvDZusJeEFbkBlLZOrtuJ?=
 =?us-ascii?Q?1uPvMn7bzIyy88P/NZC6iozIRLN/CcUrjzPqE+jfn8VmVV+ZpLiMOwlPSE0T?=
 =?us-ascii?Q?jDar5xb7vFtdTIpDghAl2XLv7OYBOvoLfRNvTQXBeLhxpoMN3W+YbIt8U2Dj?=
 =?us-ascii?Q?r+Ba+vr1gJOg6F5GieOY9/h9?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ae7acd62-1bdb-42f3-d479-08d93a59cd98
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3962.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jun 2021 17:26:02.7670 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LVVWH+fLm1xhDWanVuqOzC8eAv8X0ApFPSlqmWSqlf5cFHDAc16hv1odwzW6PZ7s
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3963
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
Cc: Alexander Deucher <Alexander.Deucher@amd.com>,
 Luben Tuikov <luben.tuikov@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Fix controller port setting of Arcturus from 1
(incorrect) to 0 (correct).

This fixes a previous rework commit which
introduced this typo.

Cc: Alexander Deucher <Alexander.Deucher@amd.com>
Signed-off-by: Luben Tuikov <luben.tuikov@amd.com>
---
 drivers/gpu/drm/amd/pm/swsmu/smu11/arcturus_ppt.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/arcturus_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu11/arcturus_ppt.c
index dc884b719717ad..b1adbe17b6c2d4 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu11/arcturus_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/arcturus_ppt.c
@@ -1950,7 +1950,7 @@ static int arcturus_i2c_xfer(struct i2c_adapter *i2c_adap,
 	if (!req)
 		return -ENOMEM;
 
-	req->I2CcontrollerPort = 1;
+	req->I2CcontrollerPort = 0;
 	req->I2CSpeed = I2C_SPEED_FAST_400K;
 	req->SlaveAddress = msg[0].addr << 1; /* wants an 8-bit address */
 	dir = msg[0].flags & I2C_M_RD;
-- 
2.32.0

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
