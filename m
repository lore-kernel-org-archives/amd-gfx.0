Return-Path: <SRS0=k5/X=43=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D608C10F27
	for <amd-gfx@archiver.kernel.org>; Tue, 10 Mar 2020 12:53:25 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 41D8D24693
	for <amd-gfx@archiver.kernel.org>; Tue, 10 Mar 2020 12:53:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="E0xlIl/r"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 41D8D24693
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F21CB6E2D1;
	Tue, 10 Mar 2020 12:53:24 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on20607.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7eae::607])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4D00B6E2D1
 for <amd-gfx@lists.freedesktop.org>; Tue, 10 Mar 2020 12:53:24 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LdGILa7b53Mufy0raffsi46oH+mxoWrm4eky3f7saL6omIVqdXPhLjnTrpwnL/55O6m7wN1cfFCd53TzcwcvD7YEQnfZUeI9hn0G8vCnWFKr2Bw69FW3i7HMJKm23go1/A65ovNozsw+KAPCzbLqQ9k2+td4AUAVu1qm72NyWeKqwlxDrD2AbXM8PE4VkfUsEaZg1LGG+SAjYBwTdcNBlvPEkTlhhFDUffFpq57uWms0u8W4T1ZFpHFk33luh2VftppMKdTF4xKvPrIRMrCIFRiXygZsckjW7F4PfSgeA7n71hEwyfSfyKrw0Te87c10Avnx1phZQknVpPZqhoGuqw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XdpAmO+SpYv/SwLYADhybg2KpIOWc/u7EVdx2mmXwUo=;
 b=KvVy24njtc4LfJ3f9jIC/3fwlnM/i+BKnxhnIIe2ZX5np9tCO2FabaXq2uhYjNn10edH7pTA6VB54q9qy1VowxGISuENL6jEerkdugIqyffSZuOPBl4a2RKJAbQPG/7DqpP1M9H9rJ9FuE4ANL51iP68SqPgXYeBodvny2CNMZY8EQ+ph/z86/6pf2E8BCH/+UWVllmdDWvOxMV0zyZUZl31jVrePRlKFSDDrcGJ2mAtvE1UxpeC3pl/PtEd3LPeyCVN3PGv8mqwS+yx3rG0PQy6UjbEFTraNWv6PQ6xEh77Bz/GFb48me8TTGWOtCDsDeksM2kPO7DuI0k5gFZA2A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XdpAmO+SpYv/SwLYADhybg2KpIOWc/u7EVdx2mmXwUo=;
 b=E0xlIl/r94FKm0SIv/0SVMs9dq6tFYU5uHqKCeKJoiJ9XRneW+QtnUao7OYL8zjo+p1yCVFsg+AvQc3FagJyeDYa9B68vwBVxzRBKbs3mpvIWHkFJduZp1r0us+RDr1PZCZKDorpttChGTxj5FBHjGDw5I1HJzq/Tngr7HMOSdk=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Tom.StDenis@amd.com; 
Received: from MN2PR12MB3935.namprd12.prod.outlook.com (2603:10b6:208:168::31)
 by MN2PR12MB3808.namprd12.prod.outlook.com (2603:10b6:208:165::25)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2793.17; Tue, 10 Mar
 2020 12:53:22 +0000
Received: from MN2PR12MB3935.namprd12.prod.outlook.com
 ([fe80::a984:d7ea:2dc8:387c]) by MN2PR12MB3935.namprd12.prod.outlook.com
 ([fe80::a984:d7ea:2dc8:387c%5]) with mapi id 15.20.2793.018; Tue, 10 Mar 2020
 12:53:22 +0000
From: Tom St Denis <tom.stdenis@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH] drm/amd/amdgpu: Fix GPR read from debugfs
Date: Tue, 10 Mar 2020 08:53:14 -0400
Message-Id: <20200310125314.83981-1-tom.stdenis@amd.com>
X-Mailer: git-send-email 2.24.1
X-ClientProxiedBy: BN6PR12CA0034.namprd12.prod.outlook.com
 (2603:10b6:405:70::20) To MN2PR12MB3935.namprd12.prod.outlook.com
 (2603:10b6:208:168::31)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost.localdomain.amd.com (165.204.84.11) by
 BN6PR12CA0034.namprd12.prod.outlook.com (2603:10b6:405:70::20) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2793.15 via Frontend Transport; Tue, 10 Mar 2020 12:53:22 +0000
X-Mailer: git-send-email 2.24.1
X-Originating-IP: [165.204.84.11]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 677e60e0-9368-43e5-a2ce-08d7c4f203f5
X-MS-TrafficTypeDiagnostic: MN2PR12MB3808:|MN2PR12MB3808:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MN2PR12MB38081121E80AA0ABC140621AF7FF0@MN2PR12MB3808.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7219;
X-Forefront-PRVS: 033857D0BD
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10009020)(4636009)(376002)(396003)(366004)(346002)(136003)(39860400002)(189003)(199004)(316002)(66946007)(52116002)(6916009)(4326008)(2906002)(1076003)(36756003)(478600001)(66556008)(2616005)(6486002)(956004)(26005)(66476007)(6666004)(8936002)(86362001)(7696005)(81166006)(81156014)(16526019)(8676002)(5660300002)(186003);
 DIR:OUT; SFP:1101; SCL:1; SRVR:MN2PR12MB3808;
 H:MN2PR12MB3935.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: fpfhs0ltXhwt8JeTaubX1QaN1CVV8UTcZ9El2r06Hz3u8kj8PiD0TYWb18dHXoj6tVKcHCidnzyRVFH7rHZl4nBZexBbRuHyCgkHFPNmYXoSUHxl65r7FQySrJVRi+24nGATKqUr1UhXZrlryGMg/uPDCUsUL6e2WIDk8HUmt/orBKXurOshUQDQMw0xtD7WAVCeqnDu51g5GovUQvurap4iTUzF8Rih+gvSZdMxQEJtyoK/08suIry1/7b+qBN3G0TwqdSyN8NQM5JvtF2I4zvykwKEFQBLcU1tuzHv1CVAoIVlQJIwinaWXUzSORPOc8+I+qQRbTvI/+0p7n4TcLbVgfTg/+BvzdKiJU2FErWVS82qOdq+IdVecQUN2J94E38hJxIG6SwA/c7CDk5Efx3GadEt0gbvFttrfCiYvPGo2I7YX6NMk9AgqU65LWGl
X-MS-Exchange-AntiSpam-MessageData: Bs7nYm++iVKIR9diAAg4uEDLhCZARNghz8exRAwjgzhvYo77gY62rIHtAHNf8F/DFEmcsgeH7Y79gNwbyUV+eD/6KuGawjwV9O+C5/DUgji5l/1V/YvecXZtDZzsuTCnBvrnEL8jP0whmIx9KVU67A==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 677e60e0-9368-43e5-a2ce-08d7c4f203f5
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Mar 2020 12:53:22.6682 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BM9/xZ87fYmflres0PYruhlsIi9ZzlUGT9MJ5pXGEOoLBLgrL43QA+YL0Mre6AUUashC0Agga7YR9r3d58Slkw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3808
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
Cc: Tom St Denis <tom.stdenis@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

The offset into the array was specified in bytes but should
be in terms of 32-bit words.  Also prevent large reads that
would also cause a buffer overread.

Signed-off-by: Tom St Denis <tom.stdenis@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
index c573edf02afc..e0f4ccd91fd4 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
@@ -783,11 +783,11 @@ static ssize_t amdgpu_debugfs_gpr_read(struct file *f, char __user *buf,
 	ssize_t result = 0;
 	uint32_t offset, se, sh, cu, wave, simd, thread, bank, *data;
 
-	if (size & 3 || *pos & 3)
+	if (size > 4096 || size & 3 || *pos & 3)
 		return -EINVAL;
 
 	/* decode offset */
-	offset = *pos & GENMASK_ULL(11, 0);
+	offset = (*pos & GENMASK_ULL(11, 0)) / 4;
 	se = (*pos & GENMASK_ULL(19, 12)) >> 12;
 	sh = (*pos & GENMASK_ULL(27, 20)) >> 20;
 	cu = (*pos & GENMASK_ULL(35, 28)) >> 28;
-- 
2.24.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
