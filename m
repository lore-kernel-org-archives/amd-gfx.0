Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 788EFC7EE24
	for <amd-gfx@archiver.kernel.org>; Fri,  2 Jun 2023 15:22:23 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E20D910E0C0;
	Fri,  2 Jun 2023 15:22:22 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2080.outbound.protection.outlook.com [40.107.237.80])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A154B10E0C0
 for <amd-gfx@lists.freedesktop.org>; Fri,  2 Jun 2023 15:22:21 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BcrlQ0DwXY43CWDRUeOS9GTFD1kw/lRSYz7rzYjTYhdRT0Dblhpw3/VpUAro31mk25Y27C4G/a418qUMvrClabr1mNotTI4O0YEvSDk+aFPwabM2C7DL1yF+lbI7CghLlgIIiPikj1AwqsZElOCpBO3E+AQfOe7O/kRw02cbGiX71lFmv7gRHb3TtaiJ2NKiU4h5oWsV8VweTj3as9/rPrCt2716icQjFOkDdGpk1r3KgGVhx7U7LrNWiEV1tWN6IsPOR/mQtLSZ1W89wfTpGhsIBJ+wF25R9ayDvlaJSOHT3VeRN4nlKq1ZeBxHG1jUcLmPt2E6XGdfSf5jgGjunA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lZoRlM7KIw9aNC12sm4W+hs8RBlPwNUNZvCUVNGNLKU=;
 b=gNqWbTDfSN2vj95WQwN7s9e0LjNFRbtbraPHCZNuwK3WsTO90vKe9EOqWQopmhlcAHt87K2mxTNDy7/Ms1TvK4yGL4/si9W5uCbR4w13dkvdusfwgwNSpQq2DP5aMxByQ/hQ+erq4l9nAjAwdGpZKTkP9HwfhgjRvcYq+EgzK1JoFel3QZqSEKE1SPem9RQzzqS6cM4laxPcSQY9x2lGOTw88k9PZDN2SanOB/9pjh1HeMyiwVkbUObHXwAJ27pwKH+64gF1Y/iM9KEJz03+33WkS/ovkrddFb/ATSY+9EVWSuuilci8SqeMHD43zfs/fM+rWOnoa/2LGNWi/YYiBg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lZoRlM7KIw9aNC12sm4W+hs8RBlPwNUNZvCUVNGNLKU=;
 b=VgBBENj4/XXpzpAzpeZe2b8lsFACUE4ZNDdncfo10Sk6m4X7rt4vPhbGQvOxwXMYmyDQl+8AvRU7de1HG7CRcU5dbW8QNdW2HeRiaPgiQ/MDcBx52On2xsmFVE7Z8JGzetXSLNV1YhL6/QnYn3+PG/yRQMs1f5A7HqG6TAJilaQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN2PR12MB2941.namprd12.prod.outlook.com (2603:10b6:208:a9::12)
 by IA1PR12MB7496.namprd12.prod.outlook.com (2603:10b6:208:418::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6433.23; Fri, 2 Jun
 2023 15:22:18 +0000
Received: from MN2PR12MB2941.namprd12.prod.outlook.com
 ([fe80::8c06:c9e:c6c2:3b16]) by MN2PR12MB2941.namprd12.prod.outlook.com
 ([fe80::8c06:c9e:c6c2:3b16%4]) with mapi id 15.20.6455.024; Fri, 2 Jun 2023
 15:22:18 +0000
Message-ID: <b4a8ec3d-c943-7bd1-86e4-de94fa576c91@amd.com>
Date: Fri, 2 Jun 2023 09:22:15 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v2] drm/amd/display: Address kdoc warnings in dcn30_fpu.c
Content-Language: en-US
To: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>
References: <20230602151917.1674529-1-srinivasan.shanmugam@amd.com>
From: Rodrigo Siqueira Jordao <Rodrigo.Siqueira@amd.com>
In-Reply-To: <20230602151917.1674529-1-srinivasan.shanmugam@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BN1PR12CA0030.namprd12.prod.outlook.com
 (2603:10b6:408:e1::35) To MN2PR12MB2941.namprd12.prod.outlook.com
 (2603:10b6:208:a9::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN2PR12MB2941:EE_|IA1PR12MB7496:EE_
X-MS-Office365-Filtering-Correlation-Id: 6252f8fa-3158-4071-9c48-08db637d2763
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: y5JvkFbrWa9rEovjeiULSqv22aHgS93C0bMRUNlnqBqcLUiF1i8lIDUNB+pYtbfxN+2TuquhX6sKHNm2V+hpVmJJu/TL+DeGgmCY9877vzHCLhlLZubY7CnP6sk6ZzKrc6Pf/1JtvbDNGFW1wwszp1PYEJ4BalpzwvmAngCUCnP/nbfHHyQkvEf4Z4cqZWwU8fuSybwbGbz41BBMYAbr8qGNoBuqhIeIzVXz7lz8wk6tUvMCvUOrK66CAF2otWBLW5w87FJjotgWiSdHcMyBlVjGyOC5o97Yaj7np57cafdGM1j02ZC7Cw5IDpLgfNdccj1Kx/uEr2y7UzYbDNHcQGrvqiNMHENi8cNg0gsjY6G4Bd08nHFtuUqDaZr7ZpiD3L9nh4GzbDgz/YnKTEMrr0uf1MTMGL53MW+pCunvGkr8JghF+3RG8BsRRfoH83d9Bj2vaklq9Swbui490LL3l8xsngzz/dmmzofZpOub8teXLwa3occUL+qeKCpW+N+XuX0AcZmA8O3yMO6VmExbuomtjdNk9APA/T9PSegLn/Ajgl6gbR/MPg5zmQr1aUvEIKBxvjCFTbyGh8jfTTSFdNsmMZ5x+5QiASrS0uuaFbBeF9boOw9XcIwuXldmm6ImkIrbR/B08K3rqJYxLUstKw==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB2941.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(4636009)(136003)(39860400002)(376002)(346002)(396003)(366004)(451199021)(186003)(316002)(6506007)(6486002)(6512007)(53546011)(6666004)(2906002)(8676002)(5660300002)(36756003)(41300700001)(8936002)(38100700002)(31686004)(6636002)(86362001)(4326008)(110136005)(31696002)(2616005)(83380400001)(66946007)(478600001)(66556008)(66476007)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UHYvNlcyUHYwRXBZdXpPaDZwQjgxc3UyWHlXNW5sWUI0ckJQa3lrYzZYUVdN?=
 =?utf-8?B?TE16YVlybGJlbUREbUNDcmV1dmc2Um1mOFZYTFhaUEUxemNGMTZHd0pFWDJU?=
 =?utf-8?B?akRvRWgxODNGaDZLR3QvS0NlUng3aTJFUXlmN3VlUGpsQ1lIRjZrZ2ZmVzlL?=
 =?utf-8?B?UUs1VnNETGg1ZTBMRFdPbDFLR2RLVkpGSVJManpBeElNNEZZK1h0QWIzd3RR?=
 =?utf-8?B?L3YvekZmMnFEdzRaRVU1NWdPNndzU3hPditLNThDRVNnTTByZzROazEwdkl1?=
 =?utf-8?B?ZEJKZ01ocXM4ZnExRHJZQUZCaVRNZ3oxa09UYnJhZ21DTEEzbURDVDk1ZUVq?=
 =?utf-8?B?eVNWdy9oT0MwRzBwL3BRQVJ2bUVxekJ3UU9wOEx2T0hHUCtUQWtKemViYi9S?=
 =?utf-8?B?ZDR0RHE0YnBrQ01zb29QbVcyT2tzd2kxWm9Wakw3Mlhjb1FwTnJKY3llUW52?=
 =?utf-8?B?Szlqd1EwRDdaL0tSMGQrYUlWQldrTEEvMmFQb0JhaWxFdVpDRFBLRk5jVGVR?=
 =?utf-8?B?akg3Q0M5MXpxQjg1Vm1ET2E4V0dxeDV5dnJTWmFNbXQvaWN5Q3F0bVJ3NHdT?=
 =?utf-8?B?cVltY1FRdzNiOTlaSjY0RGZqUXJxUld1cDM1QS80VjlWdTB3SjBOTFdqTDQr?=
 =?utf-8?B?NHJTQ3A1YzNsa0RmdnBWQWhKZ0p6S0FpVzN1b0N2YXk2Vk5XNlpzVzhiZ1JR?=
 =?utf-8?B?UnVEbjRUZTlveG0xUUl2OFVvOTgrbzh4Y2hvU29PTHM3M1Z4aVFzQnB5Rklw?=
 =?utf-8?B?NDV3UVMrUEQrSS9nVHoxZkFKMFRaMTVQTmlQQ2tHdDQ0VjIxUHRTY05kS3A4?=
 =?utf-8?B?bFloVSt1MGhET2hlUGNpOUdXcEM4cjhYVmpMN1V1T2hCUWl0UjluNXFwZGxt?=
 =?utf-8?B?VmJVZ1o4dlpyZlJhQklnalRFQkNIYXZjTW1mSzJqc0xYdDh4eFE4aUNVWGZJ?=
 =?utf-8?B?SnpuZU9qelNPYTJoKzgyazMxZkZYMHRxMnByK3psWTVSb3NLVUdXcEMzdGc3?=
 =?utf-8?B?QW9FM1NZb2FYb01wYk1xZHhxTFhUUzAwcWMrVjBKbnF0eGREZzVQQmM5eUlV?=
 =?utf-8?B?OEZWWnAyd0x4eURUZjBlL3VkRjhoOHQrVkVkSVVQMDhWKzcybEJvRnNFUVdI?=
 =?utf-8?B?ekFwUXhBL2grUGJtL2I5Skxyeno4eUJNdm14MHROR2htU2MzMXVmSFRqZStm?=
 =?utf-8?B?MFB0V0orZEFyRExDR1d5R0xna0F5STFTNXpyMm9sRG55S1Y5Q0V6UzNZTmxX?=
 =?utf-8?B?R1RaQ1F5U3o0QlFzcmlsQThNZ2JtN21iNGpaUDdpcjlyTW5PeWwvNi9BZEhH?=
 =?utf-8?B?L3JBVE8yWnFaZjRtZE1qUDFaakxGSVRVZjVjdDl4THJBbnJjR3NuR3V0QXlZ?=
 =?utf-8?B?V0ErWkhVd1VaQlcvek5CMEJFYWM5TC8rQXo2bHlBbTg5S2hyNmtOeUN5ZGZ6?=
 =?utf-8?B?aXFoR0poN3JhMy9HakRaRDZvekdiUCsyWVg2d0o5NGxHYmdGUEFDcVl3UjV5?=
 =?utf-8?B?eW1RMjZvTEZmNWtubG5RdVpoZUl4UFpyelpoQkpzVlhiMmR4NlY4dVM1TGE2?=
 =?utf-8?B?eU9teFFiK3REZjF5SzM1UFFQZ3RST0R3UERUaWNJdnpPeUlLUU53NG9xSEFH?=
 =?utf-8?B?TGcvZ201Ti8vSWY3Q21sUDdoaXJwZTVJMXBrcU1EaXVCOFJXZ1IzRXhWVXFJ?=
 =?utf-8?B?RE93dXhMSXJFbVZWeklhR3d0Y3g0d2dmZG4wRDFzV0g3OTVKRUtRc28xU1Rz?=
 =?utf-8?B?RnVaN2NZT0w3aURFS3dva0U2d1ZoNGJIMG5BcjRUN2ViQTZTT0RuSXYxWGhF?=
 =?utf-8?B?Q01BK01FZUR5OUlYa0VGNjZUSm53QW5tTmNoWUQramVQYzA3QjZ1L0kwVGc0?=
 =?utf-8?B?WmlsNC9RWG9KdlVuTlV3ZFVNUVJYUlJoMFp3SVZjQWpPY1E5Ym9VRCsxdjdP?=
 =?utf-8?B?Umcxc2dET3FuNXFJY1hONVdyczFuNy9GV0UxY1NhSDZ3Y3BKTzdxdDNnNENU?=
 =?utf-8?B?Uk9HRjk0TFRhTWdTd2d2dVRQeVZmRjJMM3B4VlZMSGQxcjJ0SGRhbzc1VSth?=
 =?utf-8?B?a0ZCbUR4MGVPRjNISG8yUWt0RmJEVFlEUmltWU1YT1U5ZGpXNldSaXFuWXdh?=
 =?utf-8?B?NEVBTk1aa0lid3RxcGN1d3VENUZnRDFMVDIrcjh2UTZoYjZsMTNFUkpIS0V2?=
 =?utf-8?Q?TUElkySG49ujtZY7my4H/h7E2iqc2+BUwD1s4BDDKlMo?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6252f8fa-3158-4071-9c48-08db637d2763
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB2941.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jun 2023 15:22:18.7515 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Sd7WtpbuYhP5dls20+h7RP/DbXWJCCdiV9zdx1Un+3aXytoAsXAql4BO/UyBuxzX6uY4VuFW2IlAAwby1K/DQw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB7496
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
Cc: amd-gfx@lists.freedesktop.org
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>



On 6/2/23 09:19, Srinivasan Shanmugam wrote:
> Fixes the following gcc with W=1:
> 
> display/dc/dml/dcn30/dcn30_fpu.c:677: warning: This comment starts with '/**', but isn't a kernel-doc comment. Refer Documentation/doc-guide/kernel-doc.rst
>   * Finds dummy_latency_index when MCLK switching using firmware based
> display/dc/dml/dcn30/dcn30_fpu.c:688: warning: Function parameter or member 'dc' not described in 'dcn30_find_dummy_latency_index_for_fw_based_mclk_switch'
> display/dc/dml/dcn30/dcn30_fpu.c:688: warning: Function parameter or member 'context' not described in 'dcn30_find_dummy_latency_index_for_fw_based_mclk_switch'
> display/dc/dml/dcn30/dcn30_fpu.c:688: warning: Function parameter or member 'pipes' not described in 'dcn30_find_dummy_latency_index_for_fw_based_mclk_switch'
> display/dc/dml/dcn30/dcn30_fpu.c:688: warning: Function parameter or member 'pipe_cnt' not described in 'dcn30_find_dummy_latency_index_for_fw_based_mclk_switch'
> display/dc/dml/dcn30/dcn30_fpu.c:688: warning: Function parameter or member 'vlevel' not described in 'dcn30_find_dummy_latency_index_for_fw_based_mclk_switch'
> 
> Cc: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
> Cc: Aurabindo Pillai <aurabindo.pillai@amd.com>
> Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
> ---
> v2:
> 
>   - Change the commit title keyword 'Fix' to 'Address' (Rodrigo)
> 
>   .../gpu/drm/amd/display/dc/dml/dcn30/dcn30_fpu.c  | 15 ++++++++++++---
>   1 file changed, 12 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/display/dc/dml/dcn30/dcn30_fpu.c b/drivers/gpu/drm/amd/display/dc/dml/dcn30/dcn30_fpu.c
> index a352c703e258..ccb4ad78f667 100644
> --- a/drivers/gpu/drm/amd/display/dc/dml/dcn30/dcn30_fpu.c
> +++ b/drivers/gpu/drm/amd/display/dc/dml/dcn30/dcn30_fpu.c
> @@ -674,10 +674,19 @@ void dcn30_fpu_update_bw_bounding_box(struct dc *dc,
>   }
>   
>   /**
> - * Finds dummy_latency_index when MCLK switching using firmware based
> - * vblank stretch is enabled. This function will iterate through the
> - * table of dummy pstate latencies until the lowest value that allows
> + * dcn30_find_dummy_latency_index_for_fw_based_mclk_switch() - Finds
> + * dummy_latency_index when MCLK switching using firmware based vblank stretch
> + * is enabled. This function will iterate through the table of dummy pstate
> + * latencies until the lowest value that allows
>    * dm_allow_self_refresh_and_mclk_switch to happen is found
> + *
> + * @dc: Current DC state
> + * @context: new dc state
> + * @pipes: DML pipe params
> + * @pipe_cnt: number of DML pipes
> + * @vlevel: Voltage level calculated by DML
> + *
> + * Return: lowest dummy_latency_index value
>    */
>   int dcn30_find_dummy_latency_index_for_fw_based_mclk_switch(struct dc *dc,
>   							    struct dc_state *context,

Reviewed-by: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
