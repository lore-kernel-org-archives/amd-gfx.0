Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D7036CD5BD1
	for <amd-gfx@archiver.kernel.org>; Mon,  1 Jun 2026 18:39:11 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 29AE2113749;
	Mon,  1 Jun 2026 18:39:11 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="wRSYPEEJ";
	dkim-atps=neutral
Received: from CY7PR03CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11010058.outbound.protection.outlook.com
 [40.93.198.58])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C3706113749
 for <amd-gfx@lists.freedesktop.org>; Mon,  1 Jun 2026 18:39:09 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NuaYF7Ps5/zoOsiOCS8jgRxpBjJzbW6uh5aZS53jSII/5l/cXwBzDIfhFgHq+66qLNQ5fOYfRP6ULd32OJicBrRFtxszfznj3rGwdMxtbw/NEDGVimrJI7pSnD1MNB+Lv9uY/VVr23xVPOPnaC3SFyRjDs744efHRALkb8NW2aDA/q3DLyZVZLBbIK5Qplv4GhvmR/a+fKphEfmPo3r1xKSdGvjtkjTmRfd0I4y5A5iJD51nQlYuAFi5RUN/hJwKvTyl+DAvWIg+2T9kAGz9sJXX81peEpHUxdOiTOv65q5JYV5nWaP9UQcipflVyGeoseVM2G23W/g2gHtdN/M4TA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hq+shxv4A+RpJyQ8xhjjEdYLjUP0sBWMj1/cRfWPqsA=;
 b=msq4+/cYQ0NfPLlu/wi5q8E0VKZ5oxm/LAimrGsSMKRSzLZlPeS1YySmW0AnYqkCpvNFLjraYKnhp8YVLB4xkZI+A5N90fO8ZLCPVArTkrgQytr+ZFNePI/r7oknbjRa+jU7trzCkK7AxYlh0mi+0yahaE14mxx/3jUHZR6Yfa+8ad7tNwTnVFD5U0P+jdHZxVd8uLxRlr8+KUkI6aqeWCUecBoDw0arflOSstP0szDbm3j8uO8dzFfymBehV06u7pTYr+m896LT7UnXFpUXBsf/xUmQNQGjBPyZW/KIGOCi4WYiozflud7Tp5Nmnz929Px8Cqn+a/9gWkK36aMmuA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=gmail.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hq+shxv4A+RpJyQ8xhjjEdYLjUP0sBWMj1/cRfWPqsA=;
 b=wRSYPEEJpCjIq0OhYgEzMCdUERgg9OntQpw2HQodS2ns72WD9nKTgR4xIDIYYpJsFNwfbEUOA3CUv2ISUZKEdFem+IrON0vcN7xQN+mrOw3RuWKjpfXa114C6uGVZq9aqO1qIMajrArD0PnRhYr1B2ElPhZq0JD9P/4qyglWiBo=
Received: from BN9PR03CA0406.namprd03.prod.outlook.com (2603:10b6:408:111::21)
 by BY5PR12MB4081.namprd12.prod.outlook.com (2603:10b6:a03:20e::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.25.24; Mon, 1 Jun 2026
 18:39:00 +0000
Received: from BN2PEPF000044AA.namprd04.prod.outlook.com
 (2603:10b6:408:111:cafe::3b) by BN9PR03CA0406.outlook.office365.com
 (2603:10b6:408:111::21) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.71.17 via Frontend Transport; Mon, 1
 Jun 2026 18:39:00 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN2PEPF000044AA.mail.protection.outlook.com (10.167.243.105) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.92.5 via Frontend Transport; Mon, 1 Jun 2026 18:39:00 +0000
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Mon, 1 Jun
 2026 13:39:00 -0500
Received: from [10.4.12.116] (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.41 via Frontend
 Transport; Mon, 1 Jun 2026 13:38:59 -0500
Message-ID: <29bf4401-4390-4247-9eaf-9da96c36797b@amd.com>
Date: Mon, 1 Jun 2026 14:38:59 -0400
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/5] drm/amd/display: Retry link detection when it fails
To: Harry Wentland <harry.wentland@amd.com>, =?UTF-8?Q?Timur_Krist=C3=B3f?=
 <timur.kristof@gmail.com>, <amd-gfx@lists.freedesktop.org>,
 <Alexander.Deucher@amd.com>, Ivan Lipski <ivan.lipski@amd.com>, Alex Hung
 <alex.hung@amd.com>, Ray Wu <Ray.Wu@amd.com>, Wenjing Liu
 <wenjing.liu@amd.com>, Roman Li <roman.li@amd.com>, Dan Wheeler
 <daniel.wheeler@amd.com>
References: <20260531105744.28717-1-timur.kristof@gmail.com>
 <4810ae14-8580-438f-ad3d-d7c7d8e7d6a3@amd.com>
Content-Language: en-US
From: Aurabindo Pillai <aurabindo.pillai@amd.com>
In-Reply-To: <4810ae14-8580-438f-ad3d-d7c7d8e7d6a3@amd.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF000044AA:EE_|BY5PR12MB4081:EE_
X-MS-Office365-Filtering-Correlation-Id: 2701916f-2ef1-4deb-012a-08dec00d0c0c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|376014|36860700016|1800799024|921020|4143699003|11063799006|22082099003|56012099006|18002099003;
X-Microsoft-Antispam-Message-Info: L1cyTLcOd5eQb7oBChmWcAQPrfkTpW8UhNqU+YnZ6e5+d2TQv49ufgdqK6JRRlTK2C+o3jQ0A23Mnq6wTEttqgMGXsA1Q95RtIfOHTdxxxPIBOPwIooxN+ntCCV+JBQk2zM6n+4+f4RbkIKoR0DxExDVEyKwW1RcXczkTIIyz1xibZxBULDX5AkqNLDLcd+DJgzEHJ0x892ZudW3inTvojBGrgM0nFXsGuMIgLvUdJmrtZLHvBFZxiNhUBYJgXW1uJyLdW2u4Q7iqYzbeBGoEfTu8Yn4yRHymDZgn2JrlwzO0Dn8uAUvFGUDSowsvGjBO7Kx+nML9Eb/iERSy9iJE/RsAY5zGD2k7/bO+dbxXaz0owu5d2a1rW1y+wACfMI0g20lsjaK43Iwl/2sh3878ibC2TuCoUBneUz/6rIueb2+gKH7CMGxvpbUNpBh7fq0xyUjIuIsJkD7GmpL4s9TgDUCT8uvivL1b0aiu7orRbh7/QxNp0MnypSZGw9uvVlhnYT7PI71HGZ0DKfweImJjmRosU/VoDoZPu9yeditXowIyEmEA+d437+ets4I30Pi8YrZx3RvP8NiT1ALBIlcRnWz+ZFQ1NaAmcBd2ozwFiDwHtlLWkBiiY4SJKdYe+quHeosa9L076sE62q7OfS2TzP5TDt9c48128HlGr4iGxAqOJvDFhkMMuPbYAPRLxwmedSKHsedLNXHrj8F4jxN5XqyH0SmFOfY/4h0vgl5K5WTE6tpsCt60pq3umivDYIhKxFGAAxmoArkaQjsKnmvNQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(376014)(36860700016)(1800799024)(921020)(4143699003)(11063799006)(22082099003)(56012099006)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: yakCtOStTcpph6RaINXzOiV30tY4ER8LjVNp6TxWEnuLP62xUbjSYeDYHW+QqjmMKfnpeyk5WRZwytFspP5OU2L3Pfzr9wNXYf0SYhGAA9vo/mh2znFd+85INyWUghbnUQjcNzEJSqPk/MFXm48QtHicf3WBUQUTsmO35jwDO7XOYrI5AWMHaXzo8hWp4AgKwc06ErkoO9NDotxAt1vAwwZUQr60/rgY4+SXo9kim4x2qjfFGmvLlef5yE/lszk8wWCtpJHtfgxMqMX7rwBWa68U1DixivtjNTg8gCRWA18V/4+zaUUSbpgQzUG5RxcVcoyVQfvCpvumzXyyWvZuf527M3831pblZlWrsxY5cllCCcs0o1cwZQy3XyeuihMOVwi95ybK1YaBtX1aRk7WxHfiUTDExS6xq3nHpuooPBEkW9dFItR9bOKABE12zw1H
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Jun 2026 18:39:00.2001 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2701916f-2ef1-4deb-012a-08dec00d0c0c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN2PEPF000044AA.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4081
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



On 5/31/26 8:57 AM, Harry Wentland wrote:
> 
> 
> On 2026-05-31 06:57, Timur Kristóf wrote:
>> When dc_link_detect_connection_type thinks that a display is
>> connected, but dc_link_detect failed, enqueue delayed work to
>> retry the link detection again.
>>
>> Useful when eg. HPD pin is high but the display isn't ready and
>> didn't respond to DDC. Typically this may happen when the HPD
>> pins make contact before the DDC pins, or when the display
>> is "slow to wake up" and doesn't respond on DDC.
>>
>> The first few patches are just a slight refactor to
>> de-duplicate some code and do some cleanup necessary
>> for the retry. This is to avoid adding even more duplicated
>> code.
> 
> Series is
> Reviewed-by: Harry Wentland <harry.wentland@amd.com>
> 
> Dan, can we queue this for testing in the next promotion cycle before 
> merging?
> 
> Harry
> 

I will add it to this week's candidate.

>>
>> Timur Kristóf (5):
>>    drm/amd/display: Add detect reason to handle_hpd_irq_helper
>>    drm/amd/display: Use handle_hpd_irq_helper for HPD RX
>>    drm/amd/display: Always create delayed HPD work queue
>>    drm/amd/display: Retry link detection on hotplug
>>    drm/amd/display: Retry link detection on resume and boot
>>
>>   .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 216 +++++++++++++-----
>>   .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h |  16 ++
>>   2 files changed, 179 insertions(+), 53 deletions(-)
>>
> 

