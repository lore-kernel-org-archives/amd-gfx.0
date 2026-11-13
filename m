Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E50CC606A321
	for <amd-gfx@archiver.kernel.org>; Fri, 13 Nov 2026 03:26:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=zHVCZazn
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8142A10E4F8;
	Fri, 13 Nov 2026 03:26:09 +0000 (UTC)
Received: from PH7PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11010002.outbound.protection.outlook.com [52.101.201.2])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F09F210E0E0
 for <amd-gfx@lists.freedesktop.org>; Fri, 13 Nov 2026 03:26:02 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pvaps9gsFEjcCnxekPKVkHwcu6NbNzGAi1K2wEEliLQ1f9sxk3LxBL+rPLqp2ZP8Oe3NwZ3YlIAMtl46k9aU0gY4UE7kNbx1DJ4ckOKorbYlyTxyAjsfN8TcFe8r2k41FHaGOS0u8/Em/f1ToyKpwng2T/dbR0TlAJ+NVaSdqZe/nI/BsGMxW8T4e9zK8gm7D9uwTGnXWry5swQ/C22NLMdOUjTAl6hVpZhEG74D+G3ykHYUYmQy0MeRVw34zJVxDspJ8fhl979JC4vlNwaHlqpUXj+Y1LRXt6LQpiwsfSmI0S7qslrV+3a5aPdEskX2VFvDvdoalUs6rTZxmBzadw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=b7CJbxkt4dx3trewGGGMKgiAzf3DzwtA4QsS3SME5sQ=;
 b=FRwN+HdSzmbrSWdnfnyLzwsUJvGUVmQHK179O+uR8IDPpMQ9+/5OLsMDg3HspgyiIQpfccr4Po9GTASI4mgmp7BfZ8xAIIuCWnwZlNiD4f/Kijq0kTWQg5/UBPxOCmQzND/fM4W8l52X+Xb5AoHOr1rRHZ3Y7IHQUgyR+vfUXvYZSzJgH/7euDPXQST2+INnnvp8zqh5x/+EaTHlel6eq9djuLHDLBmQBiX+vuUm72e5sBlZ2oHSW1myOlL778KFrQabGJDQha0MmKhw6b36HLrI/ldCCS6P3f/WuPOEWy/wdmzcNBuDz/7Y7agyBOKcnUkMoRDUV/dOjW/3RzIhkQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none
 action=none header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=b7CJbxkt4dx3trewGGGMKgiAzf3DzwtA4QsS3SME5sQ=;
 b=zHVCZaznNiCsC4ahrf93pJ4Gd8QbAKbbqku6+Fgst9qHZZU2VbVRZ0aCd44kotu90sb7BZIgQoJAGu+F1wzcCqaXoD9b9+Lm8FbfSjGD7DK90yrN6+V7diD6GdvOURy36njsS6LMwDxZnWXFYo1T16ikUGbVFV+tDIXH+2tkD94=
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; dkim=none (message
 not signed) header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MW4PR02CA0011.namprd02.prod.outlook.com (2603:10b6:303:16d::28)
 by IA1PR12MB8496.namprd12.prod.outlook.com (2603:10b6:208:446::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.10; Fri, 13 Nov
 2026 03:25:56 +0000
Received: from DM3PEPF000265C1.namprd03.prod.outlook.com
 (2603:10b6:303:16d:cafe::5b) by MW4PR02CA0011.outlook.office365.com
 (2603:10b6:303:16d::28) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.615.8 via Frontend Transport; Fri, 13
 Nov 2026 03:25:53 +0000
Received: from satlexmb07.amd.com (165.204.84.17) by
 DM3PEPF000265C1.mail.protection.outlook.com (10.167.23.182) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.615.4 via Frontend Transport; Fri, 13 Nov 2026 03:25:18 +0000
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Thu, 12 Nov
 2026 21:18:43 -0600
Received: from wayne-dev-lnx.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.53 via Frontend
 Transport; Thu, 12 Nov 2026 21:18:40 -0600
From: Wayne Lin <Wayne.Lin@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: =?UTF-8?q?Eren=20=C3=96zen?= <erenozen@protonmail.com>, Harry Wentland
 <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>, Aurabindo Pillai
 <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>, Wayne Lin
 <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, Fangzhi Zuo
 <jerry.zuo@amd.com>, Dan Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Ivan Lipski <ivan.lipski@amd.com>, Alex Hung
 <alex.hung@amd.com>, James Lin <PingLei.Lin@amd.com>, Chenyu Chen
 <Chen-Yu.Chen@amd.com>
Subject: Re: [PATCH 10/74] drm/amd/display: Stop HDMI FRL status polling on
 fini
Date: Fri, 13 Nov 2026 11:19:34 +0800
Message-ID: <20261113031935.53510-1-Wayne.Lin@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <rED2-IFmIfQnXszGhNHKi2hc_jxsJsEU-yuty77Fgml9pj38uzJmMp_PpCio0M493lCALIVVCLydqQuwmECVTuHZYOcTewJBotrH4nxAfc0=@protonmail.com>
References: <20261111014100.3596072-11-Wayne.Lin@amd.com>
 <rED2-IFmIfQnXszGhNHKi2hc_jxsJsEU-yuty77Fgml9pj38uzJmMp_PpCio0M493lCALIVVCLydqQuwmECVTuHZYOcTewJBotrH4nxAfc0=@protonmail.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM3PEPF000265C1:EE_|IA1PR12MB8496:EE_
X-MS-Office365-Filtering-Correlation-Id: a3888fbc-9539-44c5-f600-08df4135bda9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|1800799024|376014|36860700016|23010399003|22082099003|18002099003|4143699003|11063799006|261026140227099003|261028144727099003|261022105027099003|56012099006|10067099003;
X-Microsoft-Antispam-Message-Info: LQqO95YJ3wTjLX9OYYTWio0QbpsD8poFwdc3rtiM7cXGYUhn32TjhQeHrI+O/HLh1bHsgGwptngy2FolnUWxsF7RSRU8WYr3PQ0U9sachuFbRzjQtynVfU7CTfAwRZu/KzjXu5vR05D/LrxfV6+dZCN9wPAyRL4SRzsYkFHpSA9sIwCTfOx9wBwjWSAgD3vvUA+g8VGoHZZyTgFS8tWC2oZRHQMkPss8DiZNJlXvA4nvpDRWE5UkLrqd4cwFi/Qd0RLErT/ecRxz20rSaergRQGZNQxQufUHmoRW7k9TkPEV1AdbtBmcsnYtGJNNNJ0XRiVtXw/RtmCKn9/yeAOJ3RYU+YdFRKHYi1HJWz0eh4kVuhfwzltjKTc7qbPjmFD75JzvdgcFOc7nKJGXHkTeAChzHQb8kQUILz8ofrhvYJl9In5R6Z50moN1a/7BFWJ5O6xtrJxjmeA1Fqa+hCGcu5jIANxXaJDmmMh8uwqsHCi/QbKjZxhTPhMrmqVm0ArpsC5PW1QWNaPxFEZjELCnu/MnLEHZxmIH122MBb/itl+mKDaGDrFRQzn0orMaoltfU/OOJF7o4+CCF/o1ngDEzW0oxzOrP0QGYvh5Z9Qkev7NirPD9CnjTvLfJ8UlhgTxa2li+ZATZZMrfKxc9YqG34K9ZhA6EXFT0ri7BuMehZc=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:; CAT:NONE;
 SFS:(13230040)(82310400026)(1800799024)(376014)(36860700016)(23010399003)(22082099003)(18002099003)(4143699003)(11063799006)(261026140227099003)(261028144727099003)(261022105027099003)(56012099006)(10067099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: IguwSPfi181ixLTJcR/6QbkLcOPM+pBtm3+bKcTuiehoXpd1IzlNX+bM/BABYoORv0htBm4987clsofml106zj9QdQCGC2QANCaXujOceEYoKHN+8vTNP0t2wsvVuOCZdxvNNDysB3ZzvkS13m5BNSHVcPvb+1VD92ANPvxMu2DVKEZxRCqplLem28HnLGHsr/ou8tNrCUp3EBZjEnmE2xXxXxPkEaDr9EydTvwUhH/WreQmOHgXHHbegWeqz7GOTLTji3Oq6nSUMO1MD62SZEfvXf2E7uNbQcg6/wPgj7IbeFJuwla0rohe0+yRr9kvE3uxrxfKMMaJQ/ZuAp8K936QgxnsJT6PlzSifXxBpPaPQLtQly89X6SxPh0bmqIQqeyEECmmWN4841svbAoD78NdH1hUstRF6JrwxxpAzi8vzbSoaivHKs6bAoJfio0Y
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Nov 2026 03:25:18.0177 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a3888fbc-9539-44c5-f600-08df4135bda9
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM3PEPF000265C1.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB8496
X-BeenThere: amd-gfx@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Discussion list for AMD gfx <amd-gfx.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/amd-gfx>
List-Post: <mailto:amd-gfx@lists.freedesktop.org>
List-Help: <mailto:amd-gfx-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/amd-gfx>,
 <mailto:amd-gfx-request@lists.freedesktop.org?subject=subscribe>
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Thu, 12 Nov 2026 at 08:51, Eren Özen wrote:
> If this patch is applied, I'll rebase 1/3 and 3/3 on top of it and drop
> 2/3 in v2. Should I wait for this batch to land, or send v2 against
> amd-staging-drm-next now?
>
> One small request: my series was on the list the day before this batch.
> Would you consider taking my 2/3 in place of this patch, or, if you'd
> rather keep this version, adding a Reported-by: and a Link: to my
> posting? This is my first kernel series, so the credit would mean a lot
> to me.

Hi,

Thanks for your patch! This change came in through our promotion flow, so
we missed that the same fix was already on the list.

We would like this patch to go in first. Please send v2 for the parts
that are not in this batch, and drop the patch that matches this one.

This batch is about to land on amd-staging-drm-next. Please rebase v2
on top of it and then send.

We will add a Reported-by and a Link to your posting on this commit.

Thanks!

Regards,
Wayne Lin
