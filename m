Return-Path: <SRS0=BBbY=NX=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16469C432BE
	for <amd-gfx@archiver.kernel.org>; Wed,  1 Sep 2021 02:41:39 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C754360F11
	for <amd-gfx@archiver.kernel.org>; Wed,  1 Sep 2021 02:41:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org C754360F11
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6FA378989F;
	Wed,  1 Sep 2021 02:41:38 +0000 (UTC)
Received: from NAM04-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam08on2081.outbound.protection.outlook.com [40.107.100.81])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9B3F68989F
 for <amd-gfx@lists.freedesktop.org>; Wed,  1 Sep 2021 02:41:36 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Odi6PB3Iq9Bv+dAibXtYnQoCCAF+edYjis9R3MFvZT/+FKimM2OkazbC0ndGQ9C9DGEW+t9oPLos4c5XRAn4M2gMbRTqksy1QRvVTl3xrNDNgU/+DSunlPfq5IG+FCXKnbwtaNKskIFr7gs0rScPLDDHjI3h1GOMmrba8U9qKgIw7VUC///qBepL/l0wnj51DDNsb0Q+MAVhIphCVWbCAy64RTLo6OnK7g68MudATXwVQzWAi/dAWVx4EsoQ8DtAIcwKyu573D9b2Z/AevkcZDEVlwxbyoFL0VQGvR7c8FBdgYj0ts7EBrMsOR3kO+CZs3oHeCL2p2Gkxn5jUMHHww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version; 
 bh=AnPsUFOA003aesxb3A+7OFSD8g8Z+WT22C1TcU7N9rU=;
 b=QH/GzSzjqt5YKFSdFcNFLmauQAWieETIvvEf1AKn6DW0Hdw40VoMKgsJIKvdDXjmEOAJU7HgkVh3Jkhssic1/k1YQ7smIR9Y1O3AvMgHk0tUlPWX+Ucv6O4PbrctBCQQrnriaVSLqoef+6Laon+rP6K7Txi8ybjN1qNLvJp/VZrXuPqYfhUt13FKDXDKgWkFzhVJSg01joY4FRgZpcqRIvxZ38DJjdsTY6fFJZUnKZgkE2QCnfDYuGT39nnFVdcR/zIFMvdDS57JrRA0Oi7faTyT+G9hfuNK4BJ5z33KCJr8exo42m11dV/3adkvvCY0a4anPHaEY+tg7Ha2vXjEbA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AnPsUFOA003aesxb3A+7OFSD8g8Z+WT22C1TcU7N9rU=;
 b=Dup/8LyaZfDfZx//mQzVLNyWO3tC7JJ7mgBHHeYjca9ymymlTiasVm33G8mxjI51ywCbxS40hLfn0gEjOgwPPsBq1VsM5zAaZks5I11mFkv6aaIoF4L5APjPDLiURSHitJLVTWhmscxPL6OeNt+gw6YYh28qYt8Irl4h+qLDZL0=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from SA0PR12MB4430.namprd12.prod.outlook.com (2603:10b6:806:70::20)
 by SN1PR12MB2510.namprd12.prod.outlook.com (2603:10b6:802:28::26)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4478.17; Wed, 1 Sep
 2021 02:41:34 +0000
Received: from SA0PR12MB4430.namprd12.prod.outlook.com
 ([fe80::855b:1f8c:c5d1:331f]) by SA0PR12MB4430.namprd12.prod.outlook.com
 ([fe80::855b:1f8c:c5d1:331f%7]) with mapi id 15.20.4457.021; Wed, 1 Sep 2021
 02:41:34 +0000
From: Alex Sierra <alex.sierra@amd.com>
To: amd-gfx@lists.freedesktop.org
Cc: Alex Sierra <alex.sierra@amd.com>
Subject: [PATCH] drm/amdkfd: drop process ref count when xnack disable
Date: Tue, 31 Aug 2021 21:41:21 -0500
Message-Id: <20210901024121.23964-1-alex.sierra@amd.com>
X-Mailer: git-send-email 2.32.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SN4PR0401CA0027.namprd04.prod.outlook.com
 (2603:10b6:803:2a::13) To SA0PR12MB4430.namprd12.prod.outlook.com
 (2603:10b6:806:70::20)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from alex-MS-7B09.amd.com (165.204.78.1) by
 SN4PR0401CA0027.namprd04.prod.outlook.com (2603:10b6:803:2a::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4478.17 via Frontend
 Transport; Wed, 1 Sep 2021 02:41:34 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ed3ef3e9-30aa-4b53-b711-08d96cf20367
X-MS-TrafficTypeDiagnostic: SN1PR12MB2510:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SN1PR12MB2510091DAC7C80BD57FB098FFDCD9@SN1PR12MB2510.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3826;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: YqN9ms4rndtuoGPK7zUcroUgTQKJsDGkXxi8Eeb7+AsovlP5xbn2Mj7+IfK7ZUFnis0swsiiC1mHAeRcOQxbqkTzP+xJmykiZrY/NFKu5VHCgcKGasUfXZu3WVAovWytXqU5Yj9quori2c5XK6myplSoyxIyhT1Ju007xmnbUt1BSL9ACA/FH5h6UPfICVnP/URaOo/4fQaf4NRRSqOMw6+CUCOULa57EZEkWGsliWsVgLoIsxequkYVJu8v5+Mqk3Kc7gJBk3jrA+Ld6IawZ4N+hmkvWUCsAmyqQOJzWDRc46kTyQrptgUsZqfI29C5FXJdht5bWNF1F4/ZIEEWOn8VnAouyXMYJzE4oM3PYt3Rdr76ccwd1Kc1jMxPqYY61xe02CdpyhPDNVy+BesSzwjbeDbK0XHingVdHcaJCm+INQrM3Xk4c5CDSZ8enOvkY03GDwFZqdsSIJTcbxhPm/30nQ9TmuaCxnt+DAGaqwxQYsYYP6i9w/ZLMIZtNWyRMITjH0pU2yi2tyjuvif2SK/6UVNUJmpYBmayyLqNE7jrGYkFc5r2PNPGv7pqRT9xAxrqaj2ErfAclJ8430SgBIcVR2y/ijHelQqbRlTJYNNGjkfPM+W2GypXVJepSPe8o0j8/h6T9DO3ayufa0vehkjy47Kpn35Ff8nW8BEBK6h5vofl1ROrTZMu2jQXMNouCDwHV/zRgLdhD8kJ3sRFgA==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SA0PR12MB4430.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(8676002)(44832011)(38350700002)(36756003)(316002)(8936002)(86362001)(38100700002)(956004)(2906002)(186003)(508600001)(83380400001)(2616005)(26005)(1076003)(6666004)(7696005)(52116002)(66476007)(66946007)(6916009)(6486002)(66556008)(4744005)(4326008)(5660300002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?yfYFPzbfrtN6FX+gpUcVLHcOqhMKGdvoQxnpIOZiXTBQ7JWK9HnWjLXNpSCc?=
 =?us-ascii?Q?7RN6+TuBJUBq3U345vv/U02mY9Lrnrmqz990AMhDordF8PU71MlkCYIRsHvn?=
 =?us-ascii?Q?Rn/CZTlNQgyBH1r7GCX54zMonXPYNAcR9t8edmze08jyLA4UVe66spkVVnbK?=
 =?us-ascii?Q?fSPu994KJFL8ArHpJTj5yl+D6JGuR42HfKYPb6q/xu1dcdbbG0xRzlxLx65G?=
 =?us-ascii?Q?iGSUOyNCU6PzaxZuFFbW2Q6WFG4SZKVExdCGQU9JH+c1ko1njWEizWlAI1WA?=
 =?us-ascii?Q?qbdoSUDJTp4WobDf4ya5NJlaFbtn9a6cqsQoyYZctlZGLxs5z+8eeNzJYbKD?=
 =?us-ascii?Q?yrr4s8KQm90ZXJiXNHi4m7JNvCagWpAppk9DKTswp4Rzpsh4YCk+DqYKQ3HA?=
 =?us-ascii?Q?X7EeJMca2/DcJn0iWFx2+IxSEiAiDzDBYYKa+n6zHGm+ds8e1jGlHGnF8b8z?=
 =?us-ascii?Q?DTSh3Yx3itxDXPRoIlU+Pbd226frf4T6ZIyVYHvEV8qB1pEZPWA6Bsa03wyt?=
 =?us-ascii?Q?2XjaNGLJNDrTDD+KIV1JZMV9mGWLUKXXp07UaH7QLA3Vee0UfFxjcQh+JxsS?=
 =?us-ascii?Q?NaNEMigcMrAN6wpG0SUhOyuzVnlnLN/9zlu0W6BJO49oEN6I8inoJ9FuPQfG?=
 =?us-ascii?Q?MOv57OQ3qen67TTcURiwhvsXh+7Y2T8H8O37IT39+Pn7JwY3la8umo7QMxtf?=
 =?us-ascii?Q?KAH2MS0LGYFLzlc3VO2PIzB0D3yFl+D1ZFESJccxE8kDU7tlrs0Vj+AwLafa?=
 =?us-ascii?Q?eDbsDaaBKYBgh/tyRQKzPdrrckGklaSxY8ydQ0pCK1ceFIZH6YguYvHN4Q8M?=
 =?us-ascii?Q?XrBAx7CtYxlU8uIX4x98FtWxWJwhnNQ/Xu3CNtH8Eal/htrRa3QYcDHlpJOz?=
 =?us-ascii?Q?4NgdwfWPDaxDGbg62mABzUiC8bSWIo3T9hdZGQq5BMo+cbFntGH7mqkWp3yX?=
 =?us-ascii?Q?V3cqOss9JWhpRu7+J2gyoqXUPOnTFRQNYqTZxp4Yi89kKBKlOg4jKMlc/duC?=
 =?us-ascii?Q?qQlvA/Yduaa2wkbQcN0Y4eJnGIGtL2CLym56lEkMX/BSDcZlRx/Pb83NJjFq?=
 =?us-ascii?Q?JJWw/XIt0TfRIRJojJXWhbljbHU6gY6Y4asTeDI0XQSvcugEjIp6+PSPbw0w?=
 =?us-ascii?Q?Erua15lZ//8ViICCPJUDHyG4Pcz4RZrAQ2uusGgzBEaiWNrenNs4ByGApYhc?=
 =?us-ascii?Q?fjEGB4xfygQaKeObBYXPZM8qDnuMZwHYKwobDtRS0sYh9uha/YO8TMy3bONd?=
 =?us-ascii?Q?jst2BQ7JshTudmXXlPbRsKr+oVu8XRpEg06sSavifR0U+h8stRuI7WJeD5XZ?=
 =?us-ascii?Q?H+CAaStw0TahiArVZAdd6/ff?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ed3ef3e9-30aa-4b53-b711-08d96cf20367
X-MS-Exchange-CrossTenant-AuthSource: SA0PR12MB4430.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Sep 2021 02:41:34.5884 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5XinEgv4UtcoQOhGTPK+cEN9qJaFt8a1kSpMUE5v2cC2L+oJtESyREy0VYHwZw4l0M7HfyGIVLFkHgmFZ2Jrpw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN1PR12MB2510
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
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

During svm restore pages interrupt handler, kfd_process ref count was
never dropped when xnack was disabled. Therefore, the object was never
released.

Signed-off-by: Alex Sierra <alex.sierra@amd.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_svm.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
index 8f9b5b53dab5..110c46cd7fac 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
@@ -2484,7 +2484,8 @@ svm_range_restore_pages(struct amdgpu_device *adev, unsigned int pasid,
 	}
 	if (!p->xnack_enabled) {
 		pr_debug("XNACK not enabled for pasid 0x%x\n", pasid);
-		return -EFAULT;
+		r = -EFAULT;
+		goto out;
 	}
 	svms = &p->svms;
 
-- 
2.32.0

