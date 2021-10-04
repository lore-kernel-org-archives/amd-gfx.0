Return-Path: <SRS0=otPk=OY=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04D45C433F5
	for <amd-gfx@archiver.kernel.org>; Mon,  4 Oct 2021 14:48:14 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C8CD2613A8
	for <amd-gfx@archiver.kernel.org>; Mon,  4 Oct 2021 14:48:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org C8CD2613A8
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7A2946E9D6;
	Mon,  4 Oct 2021 14:48:13 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2084.outbound.protection.outlook.com [40.107.94.84])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0B7DD6E9D6
 for <amd-gfx@lists.freedesktop.org>; Mon,  4 Oct 2021 14:48:12 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TpQKDXxFfqQ/jq0p7IZL8VJgM4Fb6gQ3720mv9hOSO+azrYbT7PqiliMkYjB0cLDGaRkuV5LZLsRCnLXrGWENRxUUFW9qtJoex+vzZBcMQJdOWBYu0MmKAE90fw2TWAAixT2TOHFEwBWdWbS+6oAynAJPSVu17sboydaGkkL8oduxrVJm0m76Qsz3mQfVpigwDDdn1NJbdBX4pJ/nEw+Tzgl5EJUMDA85AllfPnUYkUlqxTwQwCCgQ0XwH1wTMIqDcWD947B+QjdrfwRYtGURIykObHcJK34xmvv/2SPzQDGs0yUyMlTfVxaorajUKKpvlve0T/jZhMC6CgtAeK7iA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ETAj2Lqmfb8gsjsoVnMfTPmj/SHQ3jkhvrY0pwZgaPU=;
 b=gsZWNECRwFemxr1EhkBwsN8vwxjlLD0pP9WvIOjdF2NCiMPZqkBKyWZrkCmmxEBgoXNXoMpo7HMjbzLDBzguzZR9MzMpwwXvW4jdHvapa22/+50GTWt7cKsUIwEaBqAL3MqdqSkdCDNP4v4SdU0yzqXwSUUFVBPtYk9Ek/DtsDT854f8rCw7f3i/zFvEqzG18sudq14FLruT7NLlAlNrOayxgNqTBjdalBt1ZR82pBqXXkGTG6AJ9wVZRmhGMvsvPLAGqEudvpgLV7J18XLKpvx/gjr+87d6GyslZ/OLA2T2cIPNuO9t7GETtT8Ebm5wsX3zZ8r+bDEbaLqozLCFLQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ETAj2Lqmfb8gsjsoVnMfTPmj/SHQ3jkhvrY0pwZgaPU=;
 b=IRXq5EOKFkR8Hv8iNkn50zdHttFQSHqRkOrb7sYvS9c0bfMHnzmUPvnqxnebZIKheXl0l3v85F5W1oSTCy9IHM9eFJNZ7xdiCoZ6xM0m95bmK36ObGG0sUMZFtjeoSWJZqodaZibhcG51lebATNohwWImwfWC5pwrHvHYsZK65k=
Authentication-Results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
Received: from CO6PR12MB5427.namprd12.prod.outlook.com (2603:10b6:5:358::13)
 by CO6PR12MB5491.namprd12.prod.outlook.com (2603:10b6:303:13b::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4566.14; Mon, 4 Oct
 2021 14:48:10 +0000
Received: from CO6PR12MB5427.namprd12.prod.outlook.com
 ([fe80::d82f:e8c3:96ac:5465]) by CO6PR12MB5427.namprd12.prod.outlook.com
 ([fe80::d82f:e8c3:96ac:5465%8]) with mapi id 15.20.4566.022; Mon, 4 Oct 2021
 14:48:10 +0000
Message-ID: <51f9eff8-02d6-0be2-b7b1-8fc226020a6a@amd.com>
Date: Mon, 4 Oct 2021 10:48:05 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.1.1
Subject: Re: [PATCH 00/23] USB4 DP tunneling
Content-Language: en-US
To: Wayne Lin <Wayne.Lin@amd.com>, amd-gfx@lists.freedesktop.org
Cc: alexander.deucher@amd.com, nicholas.kazlauskas@amd.com,
 Rodrigo.Siqueira@amd.com, stylon.wang@amd.com, jude.shih@amd.com,
 jimmy.kizito@amd.com, meenakshikumar.somasundaram@amd.com
References: <20211004144050.3425351-1-Wayne.Lin@amd.com>
From: Harry Wentland <harry.wentland@amd.com>
In-Reply-To: <20211004144050.3425351-1-Wayne.Lin@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YQXPR0101CA0016.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c00:15::29) To CO6PR12MB5427.namprd12.prod.outlook.com
 (2603:10b6:5:358::13)
MIME-Version: 1.0
Received: from [192.168.50.4] (198.200.67.104) by
 YQXPR0101CA0016.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:c00:15::29) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4566.13 via Frontend
 Transport; Mon, 4 Oct 2021 14:48:08 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e894e55d-32e7-43bc-33ca-08d98745fbd4
X-MS-TrafficTypeDiagnostic: CO6PR12MB5491:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <CO6PR12MB5491E54288B0CC6DFA075BBE8CAE9@CO6PR12MB5491.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5236;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: n+YTmAC2HPHIyadT6JlSt3mEMtff8t7Hr6LK+RN65SwziAEl7bkQVKzaD2efOLKartx5b1NBYRf9j9bowSlXnfJjFLS8hnCtwtpE/9UZ488hHoVGr5o15yJ8Su4NoTg48KVb0xGKnjCpuVQi35pDBbh86HUO4Zlg7rccEZghE3vDWq0uVFG3iMe5zZX86QgLvFrbbvgt7c0PBCA9Nv7bONhivN7AKZ93QXH0BCz6J8Uq5TKPDItIO4678dUwrAZiXFGVjXESaJzCxqu1wV9D1Mggb18IJQV0O1963MSrVV0Lzd2LIdjCfeiBilRgC3RU+3OtylyQpkkk/xCHQ0F/2KsvhfdOPt1gchxxlK3TpwXxA9SyvPMjAWZjfMmb0CU1OmYCsEz7Bgmdcqb9chgjGeb4QlvlLOtRvKz9Ctsq/ZFPLRDtjnjsvRqxJ4vJ70e4cKZaN4F7v3IOff1fG/0+ereq1W5dzD64IZcyu3cuVIkGCJYI3YBN/DnPikW1HyGaslzXyDvsMx4rH0yxsnnrQByl/Kw4KeelBuQEAxmlA4KbzeDr2BN5K8uFunst97xv+tTZmYRVo5Dwmkgu/3nEZo6vlNFhaePo4nnkR1WUOhOwl3wWsk1KPfc542Y0W2OYS+YsVJusJYfp+Zw5Q5ZLyu6BWwD2RFosUDANiyoz11UPbDdAmPOPVqC7Hof/x+2zt4CL1bkLtgiKevobO9fdaabAUFxbYYaNde6+6yN9b3DpqyFCbnlA3pg1Pf5S6Eq6
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CO6PR12MB5427.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(8936002)(8676002)(508600001)(6666004)(26005)(2616005)(956004)(2906002)(31686004)(66476007)(66556008)(186003)(83380400001)(66946007)(4326008)(44832011)(316002)(86362001)(31696002)(6486002)(53546011)(16576012)(38100700002)(5660300002)(36756003)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UDF1OWFZSjNNSjFJVWhFZ1pQb0lMNEVJRUpZZFBsNGRadnlDRFJpSWQzWnJw?=
 =?utf-8?B?UndrQTFSTmk3azlOUW1KT2hqN3MvZkNYNVp6OStZTmp2bFVUNHFpOHJDbEg0?=
 =?utf-8?B?RnVmelg4ZVdNdTNpamd1dGFkNFhJTmFWaWZlS2lPUmN3Znowb2xDRXk4WjJk?=
 =?utf-8?B?Zlc5cGloSnExcVRXZXVtZSs3UEhUc1hwaWVCM0x3bVBEcTExLzBWY2lVWk1J?=
 =?utf-8?B?M1B2bFpqT3FIRGM5V1NrTE5qQ3FWbnJuaHdTakFmTUJIa1ZUd29GL254eVNM?=
 =?utf-8?B?dFdkQXdOMldEcW15bUk5alQ0UndNU2prSittTzVKRmVnQ2NUbS9aRXFwVUZs?=
 =?utf-8?B?SjgydG5OVHFJZ2xYWUgwSlkwdXlleXI5Unc5RVl3VTl1UGplaDg5a0dadVBy?=
 =?utf-8?B?V3VpN1o4UWY2TTFmUXlGUmhwRTM1b2k4YjBFaFg1K3hyWldaeElTRjBlK2FQ?=
 =?utf-8?B?YVZlYkR1YXY2dlVvY3VBbTU4QUtQNXphNHhDTkRoNWRGQ3A3L0NEQm5PZmtq?=
 =?utf-8?B?N0JLRDFEVnNTVFlRNXhmeldpOVdQSUl0M3BHVkJST1dTcUZGa2pPVkNqc1NL?=
 =?utf-8?B?VWp6aVl1a05jdVVJRktVQzh6cGJ2Ynl1UFJEQmQwUGpQVDNCR1ZyTGlobUFM?=
 =?utf-8?B?dEY4YUk4MjVvVjAwRTBKaTRkNzM1aGdvOFFjNGZLNGhIUlNlbnR5SEg1SGx3?=
 =?utf-8?B?bW9JL1J0SHBMNGtsYUtPYUJNVzNmblhCWDZOc1dwK0ViN0phcGRxZ3ZIU1hk?=
 =?utf-8?B?VStSU2RGcjQ3SkdpN0dRV3hhTGc3a3o3Z25pVDdYUlorSTZyZXNXWUxDc0lT?=
 =?utf-8?B?eXFYU0xVdVFFV0JVdExMaHBFSVBGWXFIak1xbTUvWUxWdjFKWGtzeVNneWcz?=
 =?utf-8?B?ZlAxdURHdjBMRk9pMWdlUzVUbEtkWE5WNkhoNmNQOUF3dWdaNElpSnU3c1pu?=
 =?utf-8?B?azV1RU1QZG44MDdhSSt1WnpRVDAxc0gyUE1VaEU1L0xaRlpGTjNheUJ0eml0?=
 =?utf-8?B?cmFndHo3VWFweWtTVVlYUmx1VklnOFEydjRlVzRmc0dHNVc4ZGcrd1JEaGVk?=
 =?utf-8?B?SE5SUlFvb0w2ZnE1TlV2dDd0VU1wd2VtblpWMFM2a0VDemlNUmoyYWlZVURn?=
 =?utf-8?B?RjQ0SDUwdmlRMmY5UGl5dFR6enpJMVYwT3ZwNGtPRU41S1NSQ0piWUpmajNw?=
 =?utf-8?B?aTJHdTRnOW9qS3JtTTBlRG5TSGMwaUdKMERyVi83ZFFIeU50WkRpQm9XOWVB?=
 =?utf-8?B?cnVYUlJ5ZkVERkRoT2ozWnNkNmhQV3dWYXNZVy9XNlhJNnRLUDR5ZjVRV3hw?=
 =?utf-8?B?cWpGMWlUL20rRUJ1RE1wZnh6eTRhQUxHdnNlU0hzL3A1S3d3cXpIZ0w0T3Ew?=
 =?utf-8?B?S1ZVMkt5YmFWRWJPL1J3UEg4Sk1uNHlDS25YVVJYRjUxaFZ0WkxqUjNJWndh?=
 =?utf-8?B?VkloR0dGR0hSSmFvUTR6eDk0Z0RHUUsySTBQRUJNYlVsQXYzeUNCbHZETWRW?=
 =?utf-8?B?YzFKc2dJLzkrYTk5T2VOZGJvdnBWcUgzUWZSTU9Ba3ErWXQ2OWxSV3QySEtp?=
 =?utf-8?B?cjNUTVFRWWFKMmdnWFVXalZUUjNteXZ3eUhKWVpLZWxqeHF4V29SdGlxNzlq?=
 =?utf-8?B?Rlp6TU9xMTJFTFZnK1JRZlB3eGZvSGY0RVZ0emdWaWIxMHdxL2tBL3NkdC96?=
 =?utf-8?B?NzhjZGY2ZXhnZXlqTUowQXFzYjdWT3ZxNlVPWWh5eFJKb2gvUVNJQ3hCb3lh?=
 =?utf-8?Q?U92WHu69oWx9BGFuov7FrQvWSN02azv95NQ1TOh?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e894e55d-32e7-43bc-33ca-08d98745fbd4
X-MS-Exchange-CrossTenant-AuthSource: CO6PR12MB5427.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Oct 2021 14:48:09.9586 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: l7SePi/qqFSmCqItll7rodu8FLgjyE21pTCt/SS+J7KSjntMVC7NnaXpoHf9WSQ0o4hNe18zgtsvACK9HerQqg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO6PR12MB5491
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



On 2021-10-04 10:40, Wayne Lin wrote:
> These series patches are for supporting USB4 DP tunneling feature.
> 

Can you provide a description (with or without diagrams) of what
DP4 tunneling is and some of the key parts of how it works?

Does this patchset have dependencies on patches in the USB
subsystem?

Harry

> ---
> 
> Jimmy Kizito (14):
>   drm/amd/display: Update link encoder object creation.
>   drm/amd/display: Support USB4 dynamic link encoder selection.
>   drm/amd/display: Support USB4 for display endpoint control path.
>   drm/amd/display: Support DP tunneling when DPRX detection
>   drm/amd/display: Update training parameters for DPIA links
>   drm/amd/display: Support USB4 when DP link training.
>   drm/amd/display: Implement DPIA training loop
>   drm/amd/display: Implement DPIA link configuration
>   drm/amd/display: Implement DPIA clock recovery phase
>   drm/amd/display: Implement DPIA equalisation phase
>   drm/amd/display: Implement end of training for hop in DPIA display
>     path
>   drm/amd/display: Read USB4 DP tunneling data from DPCD.
>   drm/amd/display: Fix DIG_HPD_SELECT for USB4 display endpoints.
>   drm/amd/display: Add debug flags for USB4 DP link training.
> 
> Jude Shih (4):
>   drm/amd/display: Support for SET_CONFIG processing with DMUB
>   drm/amd/display: Deadlock/HPD Status/Crash Bug Fix
>   drm/amd/display: Fix USB4 Aux via DMUB terminate unexpectedly
>   drm/amd/display: USB4 bring up set correct address
> 
> Meenakshikumar Somasundaram (5):
>   drm/amd/display: USB4 DPIA enumeration and AUX Tunneling
>   drm/amd/display: Support for DMUB HPD and HPD RX interrupt handling
>   drm/amd/display: Support for SET_CONFIG processing with DMUB
>   drm/amd/display: Add dpia debug options
>   drm/amd/display: Fix for access for ddc pin and aux engine.
> 
>  .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 106 +-
>  .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h |  12 +-
>  .../amd/display/amdgpu_dm/amdgpu_dm_helpers.c |  17 +-
>  drivers/gpu/drm/amd/display/dc/Makefile       |   2 +-
>  drivers/gpu/drm/amd/display/dc/core/dc.c      | 179 +++-
>  drivers/gpu/drm/amd/display/dc/core/dc_link.c |  81 +-
>  .../gpu/drm/amd/display/dc/core/dc_link_ddc.c |   9 +-
>  .../gpu/drm/amd/display/dc/core/dc_link_dp.c  |  36 +-
>  .../drm/amd/display/dc/core/dc_link_dpia.c    | 945 ++++++++++++++++++
>  drivers/gpu/drm/amd/display/dc/core/dc_stat.c |   8 +
>  drivers/gpu/drm/amd/display/dc/dc.h           |  22 +
>  drivers/gpu/drm/amd/display/dc/dc_dp_types.h  |  31 +
>  drivers/gpu/drm/amd/display/dc/dc_types.h     |   1 +
>  drivers/gpu/drm/amd/display/dc/dce/dce_aux.c  |   3 +
>  .../display/dc/dcn31/dcn31_dio_link_encoder.c | 126 ++-
>  .../drm/amd/display/dc/dcn31/dcn31_hwseq.c    |   6 +
>  .../drm/amd/display/dc/dcn31/dcn31_resource.c |   7 +
>  drivers/gpu/drm/amd/display/dc/dm_helpers.h   |   5 +
>  .../gpu/drm/amd/display/dc/inc/core_types.h   |   3 +
>  .../gpu/drm/amd/display/dc/inc/dc_link_ddc.h  |   1 +
>  .../gpu/drm/amd/display/dc/inc/dc_link_dpia.h |  98 ++
>  drivers/gpu/drm/amd/display/dc/inc/resource.h |   1 +
>  drivers/gpu/drm/amd/display/dc/os_types.h     |   1 +
>  drivers/gpu/drm/amd/display/dmub/dmub_srv.h   |   3 +
>  .../gpu/drm/amd/display/dmub/inc/dmub_cmd.h   | 113 ++-
>  .../gpu/drm/amd/display/dmub/src/dmub_dcn31.c |   1 +
>  .../drm/amd/display/dmub/src/dmub_srv_stat.c  |  16 +
>  .../gpu/drm/amd/display/include/dal_asic_id.h |   2 +-
>  28 files changed, 1793 insertions(+), 42 deletions(-)
>  create mode 100644 drivers/gpu/drm/amd/display/dc/core/dc_link_dpia.c
>  create mode 100644 drivers/gpu/drm/amd/display/dc/inc/dc_link_dpia.h
> 

