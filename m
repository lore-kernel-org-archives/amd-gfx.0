Return-Path: <SRS0=y+Th=FL=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A597C4167B
	for <amd-gfx@archiver.kernel.org>; Mon,  7 Dec 2020 16:05:54 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 13F2023741
	for <amd-gfx@archiver.kernel.org>; Mon,  7 Dec 2020 16:05:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 13F2023741
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 725276E889;
	Mon,  7 Dec 2020 16:05:53 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2082.outbound.protection.outlook.com [40.107.243.82])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3DA866E889
 for <amd-gfx@lists.freedesktop.org>; Mon,  7 Dec 2020 16:05:52 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UtlL6SC55KmSpBdTXoR/6kw1oavQvMYX/W7dzUVBP7cGgmcfZqd4ZFsCRkMoGnJcw4L6cEKEPUXi0BcYCL4IVlMhVaUQvRKFbnZYe9BxLw3nH3PaYm2D30r27Ht1VNb3yBHubHzLwr5RRYdGh3zMP3qlQDIvB0Ru+ZbpXkRHY+endLHfA9Ddzvfn3Qp3jqOnEBi4YHBJmSeIbrx1afnqv44y1ahEsAHwVGEH2i6HahiqzCZFQfxkkQOMJSbHuGl+ftxjONej/f1bEZvsCh2BJdM4jNypniIhLEBvCH5dg7SR5lI2Wfj98UqxOWdGk39C+ex2tQrMkgowDUjx8npiiQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Q1tFsV35kmw5Gr4jfkF5cyRKMo0mJM4y5KTyfv7QGII=;
 b=I+RLBxIei7g+u4/IHWB2OGsztgbjugity2qWwJNA+bSnmhxxtpau7BaX8tbDL+rzTlSzj1Y+QbAl/17ApFMd+fZJlHLJV420rsmXq3yLqnQehAiHLhYPhbgc4m1hjfst1CwTf0qY5NN0oAKJjl64ptdSeMzf3eSbo93xsfbEuViYIDm7wA5yGV59KPFyiO2CDG466kVOYxsNW7N5jvHgVwJjv6Y6QXfel+eXfeRHlTHELTzrjOehhjgwvkrAIIuvnqtsX12A1513h6uFaAWr5xbvwTtomtuhB4dlMWHeXXirrW/j3yXjg5kg0aNwKxfVNpRVvVVLd3dvsNI8N4Lzsg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Q1tFsV35kmw5Gr4jfkF5cyRKMo0mJM4y5KTyfv7QGII=;
 b=FRsaR+ruRMMD7U+wFGMAoQSLnw9QFycUDDBuqCPdTpGlTPNxvrlzfgKjScRQlkIyMpikgXps6A8Sg4v4xr5mpvcLhUfsexckMjCGMr00LzkCeRChl6WPPXKwIO3zv0og6pGDZqX+o7HTnLVnLKJjgl0VYwP2GyCjHConBzIUckU=
Authentication-Results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
Received: from MW3PR12MB4379.namprd12.prod.outlook.com (2603:10b6:303:5e::11)
 by MWHPR1201MB0061.namprd12.prod.outlook.com (2603:10b6:301:52::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3632.17; Mon, 7 Dec
 2020 16:05:50 +0000
Received: from MW3PR12MB4379.namprd12.prod.outlook.com
 ([fe80::95e:3860:8b43:1a35]) by MW3PR12MB4379.namprd12.prod.outlook.com
 ([fe80::95e:3860:8b43:1a35%5]) with mapi id 15.20.3632.021; Mon, 7 Dec 2020
 16:05:50 +0000
Subject: Re: [PATCH 00/17] DC Patches Dec 7, 2020
To: Eryk Brol <eryk.brol@amd.com>, amd-gfx@lists.freedesktop.org
References: <20201204212850.224596-1-eryk.brol@amd.com>
From: Harry Wentland <harry.wentland@amd.com>
Message-ID: <021a4635-b6ab-b095-2360-572525ef2e6e@amd.com>
Date: Mon, 7 Dec 2020 11:05:47 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.5.1
In-Reply-To: <20201204212850.224596-1-eryk.brol@amd.com>
Content-Language: en-US
X-Originating-IP: [198.200.67.155]
X-ClientProxiedBy: YT1PR01CA0113.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:2c::22) To MW3PR12MB4379.namprd12.prod.outlook.com
 (2603:10b6:303:5e::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.1.193] (198.200.67.155) by
 YT1PR01CA0113.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:2c::22) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3632.17 via Frontend Transport; Mon, 7 Dec 2020 16:05:48 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: db71e5a1-4818-46be-2ecf-08d89ac9f754
X-MS-TrafficTypeDiagnostic: MWHPR1201MB0061:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MWHPR1201MB00615FECEEBA9399DD4F8E4B8CCE0@MWHPR1201MB0061.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7691;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: L47v6ZGopcMazFej7R6v0mzxfePGhfKUap9luFhkg6j0exaXlDohBG8i1Q4ZoUbHYnhs2vNiG7TNssuNqty3c7bBZgcgHf1GID3MIWC+QesNQUqVUugkg5Ujatogl69L/luKFN9BAEUHArk9uOcCVKhI3/hx2vkj8MgD6SzW7nShUCtb+pRWQuZ8P3xUB1vNzWHaGgf6b+KQhq5X7DR7sXAoNcWtmQ5VXwOb5eUgmVSCkxUGylkBfGlrN9QVyji88yn+VvHsuQeDqPSyYimv4pYDwAxe1Kwu2O+RxeXoiUeFopsE/RkO0ofyy+xwNP4p1o5UwWvZuoBO5mIDgdw6gjua7RdYFBeG+2ItZsNcf/PbbGpU2xOROHy/49Yj1F7I+UEI0aZnqgtHg4vuuEK9dmRDmNHunioH3BdimHprb/0=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MW3PR12MB4379.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(346002)(376002)(39860400002)(366004)(396003)(136003)(44832011)(36756003)(8676002)(66476007)(478600001)(26005)(66946007)(53546011)(16526019)(52116002)(186003)(66556008)(31696002)(4326008)(8936002)(2906002)(86362001)(5660300002)(6486002)(2616005)(83380400001)(956004)(16576012)(31686004)(316002)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?M3FoWVRyU2RmQW4rSHVsZW1mY2hDUlA1KzM3NHRNSVZXcVc1MmxyeUJXL29W?=
 =?utf-8?B?ejl2M1Z3ZkRiL3llenJwVTgyQVNSUGk2emdsczcwQk1paGNGOERKZnlIOElj?=
 =?utf-8?B?d01Kd1dFdjZkMWhqUlNYWDhOZ0I5T0FiT2h2TWxoKzNFdVNnZ0FoZTN0RkhM?=
 =?utf-8?B?NjBhc1JDTndxQnd5T1pLL3VqaUJzUytDRWpjZHBzVldyVDhTbE41ZTM3WjRu?=
 =?utf-8?B?eXZHRG0vWEMvM1R4ZExobXJxVnU4Z3FTNXZJUlVJVk9Pa043UXFFR0ZkSGNa?=
 =?utf-8?B?UnZ0YmkrV1hXUi9kSFJxZGRRVDAremZHWmI1cG5KZERsTWoyZ3UrZ2EzVjVR?=
 =?utf-8?B?NitxYVU4NjdSM2luMFJDWk5jRjFoc2ovYnNlSGptNEV5Y1BtWllMSVUzRmhN?=
 =?utf-8?B?UEw2ZFF2cWNMNmQrci9DUS92M3l5R3pLREJGQ1liOTh4UHF5ZHZBYnpWRjQr?=
 =?utf-8?B?M2lYaWlnblFDdnllNW5VaWVZd3k0d1VVZHJKdlYxN3BlR0VHZk12Tk0zY25I?=
 =?utf-8?B?RkM0MVNVei9JT2xsVDE2VnkxeUkwNTRkb1ZOMFZuQnZZaGhHSXZlMzYzWFpL?=
 =?utf-8?B?Sm9aN1kyeVJnYVVONE5YZ0p0QzB1WTQrV0cvT3cwY0pCVkt5RUR4eTQ3RmU2?=
 =?utf-8?B?Y3FMV1NnNWkxWnQ5eXNaNGtYY3F0N0V4eXg1d3c1T3Z1N1pXN2hhQkU1dDE1?=
 =?utf-8?B?UXQxdmNDakNQdllBNXBneDVxTHZFdFdyT1ZmL0JPSVdmbjFaQmpseXhHelpw?=
 =?utf-8?B?ZFpncXRzUTdCTVJHN3hwMmNrcmZaMUJ4RXhnOGFJTmZXV0xnUnpMMEx0ZUc4?=
 =?utf-8?B?eTFJcENwQ20wVkhoODQ2R3kyKzIxUWhmOEZGQXZUbVJ0cmN0MloxdTMwUTlv?=
 =?utf-8?B?bEtQMFZiT0tzVFpwekZ0QjdvbzFtVlJ0c2FRZ2wyaGVQREpxMnhBeGpyUzRz?=
 =?utf-8?B?U1FyRzJERG94L2h4WDkxRlA1QlhVK0doOVRBbWRWM09VSlU5R1Q1eUFObUJ4?=
 =?utf-8?B?MGphdWhuRUliTTArT3BKdjVDVC9VdWlHdVJBekhDZjgrcHdMWGpvZjJIMVda?=
 =?utf-8?B?Slc4Q21QSHFxZkFvaEJVaUVxME9EbldzV2hkUmVUVzQxMWI1cjdubXdITzdP?=
 =?utf-8?B?NUwwbW1FR2J4ZXp5ZWtSYWtQbzhHVkFqblRtSjhBckVvZHhZVWYxb3BUN28r?=
 =?utf-8?B?UEVXejNUaUxFYTh3aHE0MjVRM3ZWRFdmMWdVa0VqR1Z1c0RpTm1OSWxac2xl?=
 =?utf-8?B?enRKMDA2aVBTeHZyc0xoMC9oZ3ZIOFVVakZDSVRJd0dWK0hoWEY5MFVVZ0Zu?=
 =?utf-8?Q?BuqijtUx3vdQI7Ome9kUGaEfIwbq+Rbj85?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthSource: MW3PR12MB4379.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Dec 2020 16:05:49.9806 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-Network-Message-Id: db71e5a1-4818-46be-2ecf-08d89ac9f754
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: A1NgQOUGOcLbiuT4QfRoeQybUE4UZyy3aV8m4Lj1K09U/025sE96eUmk0GSOKZ1uoW5sG3zUHd3nnFWjsHAnig==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR1201MB0061
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
Cc: Sunpeng.Li@amd.com, Qingqing.Zhuo@amd.com, Rodrigo.Siqueira@amd.com,
 Aurabindo.Pillai@amd.com, Bhawanpreet.Lakha@amd.com, bindu.r@amd.com
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

> AMD\ramini (1):
>    drm/amd/display: Set FixRate bit in VSIF V3

Please ask Reza to configure his git with his real name.

Harry


On 2020-12-04 4:28 p.m., Eryk Brol wrote:
> This DC patchset brings improvements in multiple areas.
> In summary, we highlight:
>
> * Fixes in MST, Compliance, HDCP, audio;
> * Enhancements in VSIF;
> * Improvements in seamless boot, DPG;
>
> ----------------------------
>
> AMD\ramini (1):
>    drm/amd/display: Set FixRate bit in VSIF V3
>
> Anthony Koo (1):
>    drm/amd/display: [FW Promotion] Release 0.0.45
>
> Aric Cyr (1):
>    drm/amd/display: 3.2.115
>
> Charlene Liu (1):
>    drm/amd/display: Enable gpu_vm_support for dcn3.01
>
> Chris Park (1):
>    drm/amd/display: Prevent bandwidth overflow
>
> Dmytro Laktyushkin (1):
>    drm/amd/display: Expose clk_mgr functions for reuse
>
> Jing Zhou (1):
>    drm/amd/display: Set default bits per channel
>
> John Wu (1):
>    drm/amd/display: Don't check seamless boot in power down HW by timeout
>
> Judy Cai (1):
>    drm/amd/display: Change to IMMEDIATE mode from FRAME mode
>
> Michael Strauss (1):
>    drm/amd/display: Revert DCN2.1 dram_clock_change_latency update
>
> Qingqing Zhuo (2):
>    drm/amd/display: NULL pointer error during compliance test
>    drm/amd/display: Only one display lights up while using MST hub
>
> Reza Amini (1):
>    drm/amd/display: Implement VSIF V3 extended refresh rate feature
>
> Roy Chan (1):
>    drm/amd/display: Fixed the audio noise during mode switching with HDCP
>      mode on
>
> Sung Lee (1):
>    drm/amd/display: Add wm table for Renoir
>
> Wesley Chalmers (1):
>    drm/amd/display: Use provided offset for DPG generation
>
> Wyatt Wood (1):
>    drm/amd/display: Add support for runtime feature detection command
>
>   .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c |  37 +++++--
>   .../amd/display/dc/clk_mgr/dcn21/rn_clk_mgr.c |  93 +++++++++++++++-
>   .../display/dc/clk_mgr/dcn30/dcn30_clk_mgr.c  |   2 +-
>   .../display/dc/clk_mgr/dcn301/vg_clk_mgr.c    |   8 +-
>   .../display/dc/clk_mgr/dcn301/vg_clk_mgr.h    |  10 ++
>   drivers/gpu/drm/amd/display/dc/core/dc_link.c |  18 ++-
>   .../gpu/drm/amd/display/dc/core/dc_link_dp.c  |  17 ++-
>   drivers/gpu/drm/amd/display/dc/dc.h           |   2 +-
>   drivers/gpu/drm/amd/display/dc/dc_link.h      |   4 +
>   .../amd/display/dc/dcn10/dcn10_hw_sequencer.c |   5 +-
>   .../drm/amd/display/dc/dcn21/dcn21_resource.c |   2 +-
>   .../drm/amd/display/dc/dcn30/dcn30_hwseq.c    |   2 +-
>   .../gpu/drm/amd/display/dc/dcn30/dcn30_vpg.c  |  62 +++++------
>   .../gpu/drm/amd/display/dc/dcn30/dcn30_vpg.h  |  38 ++++++-
>   drivers/gpu/drm/amd/display/dmub/dmub_srv.h   |   6 +
>   .../gpu/drm/amd/display/dmub/inc/dmub_cmd.h   |  17 ++-
>   .../gpu/drm/amd/display/dmub/src/dmub_srv.c   |  29 +++++
>   .../amd/display/modules/freesync/freesync.c   | 104 +++++++++++++++---
>   18 files changed, 367 insertions(+), 89 deletions(-)
>

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
