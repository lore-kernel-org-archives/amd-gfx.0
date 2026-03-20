Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C16731093168
	for <amd-gfx@archiver.kernel.org>; Fri, 20 Mar 2026 00:52:56 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4F4ED10EA61;
	Fri, 20 Mar 2026 00:52:56 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="LP9jMyXo";
	dkim-atps=neutral
Received: from SJ2PR03CU001.outbound.protection.outlook.com
 (mail-westusazon11012000.outbound.protection.outlook.com [52.101.43.0])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D215110EA61
 for <amd-gfx@lists.freedesktop.org>; Fri, 20 Mar 2026 00:52:54 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IvG3q4VkImCHfxrz4B77GzL6vMRk9F8GofDYPgPy+xjMq0GR8cplSsDN/0YP3XEUfeQ6sK6mtSMYe2SL0DqRtOd35A15bEV6ZT3RoAUBmSqVNzcDBWqm7Iz/AykqbFpXeN72MojGhzuHgLlwemX808qTNqoxqRxEVkTjAHj2u2U2Hav6m8HknuovFQ6pR39IZclWzACSyLxUQWvYQmAGw7MFXQwTDzWMmMjfOiJntYFnwbdbXaOjid0+zCQYym5xXj+1lhExClgzRtgPzkIAW9IAyKLli4E1PPn2yrs6F2R3F6xflt52IKLvlTJIpHDVt81oFilBsnmCfUiRBB8C7A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dzYSVXBuyTBI5dKXN4hybVVsU/iPUACDzC6BHJiFako=;
 b=TCng9vlS2Xz5qiEUculr6oeHNebrNWLQJ75ZGemCeaHRpQbtB+/58CR55ZoQWQaFcmTec1/cAGDNeYwoOtVFJNkrbhQGGwHvzZfHeNYoP9pLdRuNyvJcdGDucZ9gdn7ui4nniZsuNYsLfewrNU/9rILaO8ULbv+/Wv10cn9oJ2GK8/+K2yUQqkZwX4Zf3yWYThJ56Kpv9ziV7MyFgByDKwm9+kC9cAvXeo6nPXzRenddWY39qAl+pTHDLbzbhFS6oaJqNEBA3+GHUZeUaR2aMZt0DeIMhx9tHUEg+BdiZn7GzGWhNlndrA436K1EM7/3JE99PBs6IRuY0C9DxQzmiQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=m1k.cloud smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dzYSVXBuyTBI5dKXN4hybVVsU/iPUACDzC6BHJiFako=;
 b=LP9jMyXoVzMOnFyOSR8XRwqs6kQCy5eWfLo9g53GZulcmaD/6FKOPF2neVA4GGmZ462cY2bOUlcle3rzUitk4x3q6a9GVGIVlATqgT6yoJ5pDk0vQuAqDT9IA0mA2vNuVao9i0JIw1ZMhtjBWIWbYCdpdIshPiPWFDvKg5RYxos=
Received: from SJ0PR05CA0125.namprd05.prod.outlook.com (2603:10b6:a03:33d::10)
 by IA0PR12MB7700.namprd12.prod.outlook.com (2603:10b6:208:430::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.19; Fri, 20 Mar
 2026 00:52:50 +0000
Received: from CO1PEPF000075F3.namprd03.prod.outlook.com
 (2603:10b6:a03:33d:cafe::67) by SJ0PR05CA0125.outlook.office365.com
 (2603:10b6:a03:33d::10) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9723.19 via Frontend Transport; Fri,
 20 Mar 2026 00:52:31 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CO1PEPF000075F3.mail.protection.outlook.com (10.167.249.42) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9723.19 via Frontend Transport; Fri, 20 Mar 2026 00:52:49 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.2562.17; Thu, 19 Mar
 2026 19:52:49 -0500
Received: from satlexmb07.amd.com (10.181.42.216) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 19 Mar
 2026 19:52:48 -0500
Received: from [10.254.92.47] (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Thu, 19 Mar 2026 19:52:48 -0500
Message-ID: <4e48ec7b-ac73-4637-9e42-9c328067ed72@amd.com>
Date: Thu, 19 Mar 2026 20:52:42 -0400
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/1] drm/amd/display: complete cursor vblank events
 immediately
To: Michele Palazzi <sysdadmin@m1k.cloud>
CC: <amd-gfx@lists.freedesktop.org>, <harry.wentland@amd.com>,
 <alexander.deucher@amd.com>, <christian.koenig@amd.com>,
 <siqueira@igalia.com>, =?UTF-8?Q?Michel_D=C3=A4nzer?=
 <michel.daenzer@mailbox.org>, Shengyu Qu <wiagn233@outlook.com>
References: <20260217191632.1243826-1-sysdadmin@m1k.cloud>
 <84316e45-f596-49c4-b3e7-cdfc7a19a519@m1k.cloud>
 <bc9b30d6-3ca9-44f0-825f-82b1142c8b48@m1k.cloud>
 <2be6dc58-e2dc-4733-aa25-26329cd1d2d3@amd.com>
 <TY4PR01MB14432450DA5BDEFA272476A2F987FA@TY4PR01MB14432.jpnprd01.prod.outlook.com>
 <49434297-d6e8-4eaf-b4c7-ce14134d7869@amd.com>
 <96f4df42-2675-4bda-b0f2-753b09f7a80d@m1k.cloud>
 <ca869a77-4bdc-47b7-a8f3-788224be48be@amd.com>
 <fdb2d4ad-10e5-43ca-92db-f1dad48b7890@amd.com>
 <c4cae811-e3a4-4aae-8501-6de0977566a5@m1k.cloud>
 <6e1f5a30-82c3-4872-add3-7d46a266c37c@m1k.cloud>
 <6ac9fc7f-0493-446f-97e8-760a54e209d8@amd.com>
 <7fdc3c4f-c321-48f5-93f9-17a1a8ded9f8@m1k.cloud>
 <1356e93b-af76-47f3-afc5-29535a9518bb@amd.com>
 <aa3891fb-ed89-48e6-bfb8-86e704447a2e@m1k.cloud>
 <51219a7b-eeec-43f2-a335-06710809415c@m1k.cloud>
 <7a148774-3364-4ce2-9f55-2e77889bfb53@amd.com>
 <a8a3d8d1-ee55-4fc0-ac98-45d70ad0bd6a@amd.com>
 <deb792f8-70a5-41f9-bcf8-1425994aad14@m1k.cloud>
Content-Language: en-US
From: Leo Li <sunpeng.li@amd.com>
In-Reply-To: <deb792f8-70a5-41f9-bcf8-1425994aad14@m1k.cloud>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
Received-SPF: None (SATLEXMB04.amd.com: sunpeng.li@amd.com does not designate
 permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000075F3:EE_|IA0PR12MB7700:EE_
X-MS-Office365-Filtering-Correlation-Id: 981f0817-6baa-48a1-d314-08de861b026f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|36860700016|376014|42112799006|82310400026|32650700020|13003099007|56012099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: Ds681E421dE3UwO6cJCio7gD7JC4/VNzaGVqWK1AHnzd9hrIOS+1Iw2baJCnKzdB1WJPk2gAATqSsK6Zb+n/Q5Hz1WycMutzGDvaLnwpYd73GO1tidkd2uQYKSYkgRlVPdD6FFncmzjlqhG5gnNzyYlLhU5NHStjhx5mOKrnsu9SUOTao51pW1LGvzx4nAYCabV0Pdsqf9NwHc6a61uYKt4iBNEWoIED54acE5ZCQJDmqcrw1mPuqezSajlG0l4g/hj8gVSAwqfqTW5Km9IBS7Mr9Ce2IhSv+7RdFhQvTFhMmQuiJxSZuVB5IBv5cRlj6TjlR3Dvmui/PgiLZcd85azYb2QBD6O+BpIrgacBKAukzih1z93wfeiNbAptyq74i+B0SRVKWhyDLw6KZm8AfaYIJO7okKxC/nkmLvaIP/3P+HLt4JRq7m3F4+2XoIwKJ+tQlF1qLsZtmC0aJjv+NeqD+fslmSw3Q+1xx+Mb6kttL/wWLhrmH62T5nrkUn74Ycawz+g8Gd7pq8XX4HBGitguB4cQ7T4I29uKweU3TIbw9MCnySrie96IlayddlOa0erFCJRta678FtjaQ8wXrtVe6n4TIn8+PIW7b1WzuM29NlkvD/2C/4CmIPVRZWYzNJyT41KmKgztQdCSJRaSK+URA4fOcd3GyfVlnZ1VNXtjzOasn2DoiuPfuEpNlR1iSlp1V3LmuBSx73h8XJPWlBeIFVN3F8BRoUbYyD8CUFA=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(36860700016)(376014)(42112799006)(82310400026)(32650700020)(13003099007)(56012099003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 0ClZy/d9GcNJPSHV9QwDAUESSFv6j+jhFIDljkb9I+d4hej5qx3T4ZhmH3eLILqzxd6UvLlbPZuR+laHfkciU1ywe248Jl7M8dYMSDaugCqM4YTN2OJlbDQAf3mX4B2nPLIJfg0Cp0xHZnWFuUtCokNmfgXxb83HDQwlNa+kpdsALay8kgs8/NN2uOVSw/9/o1UapyC9+XNfB2wxI4C6N1WEUW6y+8mApBRLJDDFAB+tdEEfXeLi0O7TuWVViHSUO27evuHHUQ14yJNlIqn7sk1phpNpKCVNaIA/C+zqnCLYCY1xLsdADUieBk7uR2ogS+EORFak6OJQZp3e3uB35M7OFO+br4mjshDEXM+RLcLAirgFIfkEYJ+FkWvxwic+ATyCrfpSW+bR4UPe4ukvc6zOZh/OKrdXahJiicxbNEqigmEPTHpq8PJMsODu15S0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Mar 2026 00:52:49.5481 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 981f0817-6baa-48a1-d314-08de861b026f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000075F3.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB7700
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



On 2026-03-18 07:36, Michele Palazzi wrote:
> Ok i managed to do exactly that, before the timeout sent your umr command, frozen display did not recover (recovered only after unplugging/replugging the DP cable as always)
> 
> UMR output before/after force enable
> https://pastebin.com/hhapxBev

Hmm, is the "before" captured after the display hangs, but before the flip_done timeout error in dmesg?
And the "after" is captured after writing VSTARTUP_INT_EN=1, but also before flip_done timeout error in dmesg?

If so, it seems my previous idea that interrupts got disabled is wrong, since OTG0 has VSTARTUP enabled in "before".

Did you happen to try disabling some idle optimization features mentioned in a previous reply?
https://lore.kernel.org/amd-gfx/1356e93b-af76-47f3-afc5-29535a9518bb@amd.com/

Thanks,
Leo
