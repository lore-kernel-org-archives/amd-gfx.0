Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7CCC2C5AC7A
	for <amd-gfx@archiver.kernel.org>; Fri,  7 Aug 2026 15:18:02 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0104A10E425;
	Fri,  7 Aug 2026 15:18:02 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="TTmUH9OM";
	dkim-atps=neutral
Received: from DM5PR21CU001.outbound.protection.outlook.com
 (mail-centralusazon11011008.outbound.protection.outlook.com [52.101.62.8])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 389E510E425
 for <amd-gfx@lists.freedesktop.org>; Fri,  7 Aug 2026 15:18:00 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bTw1dRnL09c+RaumodUg3PAtH9TkM76XMR58MTCdbA5Cuo4UkBPrg83WZspM0N+5aJFyOIUjKdqpz2THJ6Z3dy7ustWcFxgPfnh5EgMVeKsO/iyrhcEwgTQiWq/M/lar7hgHo++sYXvEjMV25np8srTYQD0vmYxW+UpM1Ie82fqGROSvOhJnVr14MYrekcFErmfJEzfdBOTJlR4vJnt/g9Ln363iVNRJHYf8kB83h222OzhrOUIVjlyslywyKHeiBEvR+eBBsSwrdv/IXemxMi80LCr+vWfY3aYReDMZD3PLpsqDK6gSCl41ZaDK9dQRVuTtPsHYT4Wcq3jAyc5CJA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yMZmsBfyqV1ndVK689pMzAfkSPhOA7Q/LIJ0V6PDylE=;
 b=HVyDG7CLnHuHqYOP5UEczE9fUgIomvdypDGVDlrwjAcy//LGYqE6NEhR9/QFU1j5v2yDZt/B+5gD7Ig1aDVdJ1NQzrXXdOaI9omLbpVgDWXYrRQZc4g4d5DXses8PjeLdR82uPaxqTzrPt9WkovUet/vVBuCdbmp1ZN+RuyCHiOLF96otc+iKUP5niedalVzThzoWK61n52lhjySkOsBeCKPf3pHEIzOJDoT2yRyV2pZe3TxyE97k5Ol5pnw6wuILRiPnGspbCPWf/sBhJXH94WLSTCYBj3kUVdQHmfKxtSkZorNDTEr8eCGZBo0ZNprWiGwo9M7I8WvpsRkvIC6qw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=canonical.com smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yMZmsBfyqV1ndVK689pMzAfkSPhOA7Q/LIJ0V6PDylE=;
 b=TTmUH9OMqXPGkIqjhFTFHhqKBju8bsHn2N4yZY0pw/tVziwtBo6VmIYvCA5UKKul9iL2WOza99A/qyaoGFbRnomGeE+F0v3mA58Iwg0yVAoEKBlCo1Z5NKcRaPXNCFug1TzWwWfeSrIvo0XYX8K0YQtAONKqeMNlWPeg0Ar69hI=
Received: from DS7PR03CA0349.namprd03.prod.outlook.com (2603:10b6:8:55::24) by
 PH7PR12MB9066.namprd12.prod.outlook.com (2603:10b6:510:1f6::5) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.292.19; Fri, 7 Aug 2026 15:17:52 +0000
Received: from DS3PEPF0000C37E.namprd04.prod.outlook.com
 (2603:10b6:8:55:cafe::50) by DS7PR03CA0349.outlook.office365.com
 (2603:10b6:8:55::24) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.292.23 via Frontend Transport; Fri, 7
 Aug 2026 15:17:52 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 DS3PEPF0000C37E.mail.protection.outlook.com (10.167.23.8) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.315.6 via Frontend Transport; Fri, 7 Aug 2026 15:17:51 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Fri, 7 Aug
 2026 10:17:50 -0500
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb09.amd.com
 (10.181.42.218) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Fri, 7 Aug
 2026 08:17:50 -0700
Received: from [10.4.12.179] (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.41 via Frontend
 Transport; Fri, 7 Aug 2026 10:17:50 -0500
Message-ID: <ed48a0e9-d32f-417f-8066-c74aebc319c3@amd.com>
Date: Fri, 7 Aug 2026 11:17:45 -0400
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/1] drm/amdgpu: Do not enter PSR if multiple displays are
 active
To: Mitchell Augustin <mitchell.augustin@canonical.com>
CC: <amd-gfx@lists.freedesktop.org>
References: <20260806143408.979209-1-mitchell.augustin@canonical.com>
 <20260806143408.979209-2-mitchell.augustin@canonical.com>
 <30d3e377-cbf3-4ab2-b7a1-0557b6cdb690@amd.com>
 <CAHTA-ubuVAMn8wnrWpBvnvMd6gH-80cSygbmS5Sy-AhU+Oy0XQ@mail.gmail.com>
Content-Language: en-US
From: Leo Li <sunpeng.li@amd.com>
In-Reply-To: <CAHTA-ubuVAMn8wnrWpBvnvMd6gH-80cSygbmS5Sy-AhU+Oy0XQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS3PEPF0000C37E:EE_|PH7PR12MB9066:EE_
X-MS-Office365-Filtering-Correlation-Id: b0a9ae45-c6f9-4ab6-da83-08def4970c66
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|1800799024|376014|36860700016|42112799006|23010399003|18002099003|22082099003|11063799006|4143699003|10067099003|56012099006;
X-Microsoft-Antispam-Message-Info: jezG/holpC90bETg8CK9wYS0UVEZBznd5PwKo8jfHi0WjtiEd7SSE9SHmWs8nVUk/uGzLIpzZXJxXsfpBhAQ1ktPS0Bh42bToi+JSXHJ/esrwPn2/us2csHoorx5KDlDcZU0bngqR5sD69GIbSNKrAi0IZV7d+My6wq99xy3COSlUcnKniYt0GvkeqOaupB+MuTHHSq47nJzfjrAC2gfRnUyh1EBxCIZuHXD6dIzkMm+eMIOV7j1IYejMQHBB8HJTxzOS1s1MkWma45eE16+7z/mzXC9oo/iFyCxf7P6nwlSopShXOlD8HuxS+pzzKd7mITztF3INsRNIANh4D+Jg2OFs1IVV3giihyjUojLvuHjDMUd6esZRRbLyfNrvdpiHfJ6xDerEcyOhul0EFCuFrZEVRCY+orWcr8WPrYaJ7eYoHnLANxFBC63phAzUuIwAKJAd6qN9bh1zS1gL1UY+Vr6g6hhw52YXkT9t+weGvTXmd6V62QE6/g2/qQQD7Gl8/6Dg692kyuj3aDF7I+IuuEn79+b14zrLytKqOxbti00oo9St5Ncnb/cbyZQIhvZcd+N8Z8y5HFZ5L+odGXaG/P60HwAyBrvPpXmaGmIWubQquILa5BFfsM8X/70lt+Jz/kbgouqW7xmhgvBScHUM/Y1VYn/tEXggXG5x21Gt/MXTP1m7gZH3/y4jPnhSlC82xnio++fSL73adyId3mikQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(1800799024)(376014)(36860700016)(42112799006)(23010399003)(18002099003)(22082099003)(11063799006)(4143699003)(10067099003)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: QBrHMcCtJ4BoKPEjbfZ3PNnlAM06l/yP4g8F4F74rSrrCA+lNJMVgMuP6MlwlS1bpGE4tdIZj518PsCgWkt9GHPG2BUp+rXKrStkUWAHNsTNrYT38T38ZLvOU8mScRCSsKQf1dmRyF0PlBYT8U+baybMFFfP3nnXFSrnxW0L3FxLjIwE30ivGGVdRhR6jbwsi56vaTq56yOq3jhcnu/IyP2tMqekpDEjUGBZOgTzGp9rvRdD0d3cWEiPEPOWIN4csVC99jnFp8bMErNkWJauBzWvMn10pQ+jbkqqRlUVHgrlsZ/25yuzClgl8hrPVHf0SPhHYay7dqC/a9BI8yt2Iy7SlmuZdgKSeVSGxrcef44tvZqBrPYBTwmyzk/dsxNRk1NrbAM/u1VR6PakBxfQh65wkkqnkMhVwNDzg8814UbLhBOQoQqX7tTEhQWVjUMR
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Aug 2026 15:17:51.7679 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b0a9ae45-c6f9-4ab6-da83-08def4970c66
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS3PEPF0000C37E.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB9066
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



On 2026-08-07 11:06, Mitchell Augustin wrote:
> [You don't often get email from mitchell.augustin@canonical.com. Learn why this is important at https://aka.ms/LearnAboutSenderIdentification ]
> 
> Hi Leo,
> 
> I am not sure - I have only personally tested the latest
> Ubuntu kernel based on 7.0.0 (7.0.0-27.27). Could you link me to the
> relevant commits / mailing list entries? I can read through them and
> will try to give it a test soon if I have time.

I created a 7.0.y based branch with all the fixes here, see the top 5 commits:
https://gitlab.freedesktop.org/leoli/linux-asdn/-/commits/lileo%2Fflip_done_timeout_corruption_fixes-7.0.y/?ref_type=heads

- Leo



> 
> -Mitchell Augustin

