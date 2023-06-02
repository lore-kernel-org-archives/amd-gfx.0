Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8F273C7EE24
	for <amd-gfx@archiver.kernel.org>; Fri,  2 Jun 2023 15:14:51 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 242C510E02C;
	Fri,  2 Jun 2023 15:14:51 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2060a.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:fe5b::60a])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F2C9C10E02C
 for <amd-gfx@lists.freedesktop.org>; Fri,  2 Jun 2023 15:14:49 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=C2xwirQOIHfOhfynEJRs4YjoMuLhKxqmWgPe25/ZQrNpIe63xWSTPmt9ekpBUQZ8iWuzVNshT66JnruilAeLRmbK9byFt39kV/U2iTMntbTPTTPUP5wv9TbAt3eTz+XdPvutEYBVWbOIBTssCwzEA2cfKn/mcp3GeOa/C6FaUtGiY1Tbw2daTOfHF0ybL0MUDcOwLlCmCjQQN24fS1sYDcxwfJ4RRIVqDGLxftc1OFAdjPq07YNYg5i/LuPudK0dm+jFDUKdv1cvVMfh+scOwAApixVYE3fqgCIzOo3Y+vsR+C4ryA8o6IH+SGR8K3zXzyibfwc9PoqNLFixKk/8Uw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PY0xiWFQecgal2/ZWgSdcblOWnyVT/167g7KY8Tz2s8=;
 b=PrqSo4A8Jv9xwKkomqR8/TaHKxSB8NTe1ZXKZBara0X2Z4PGgo7Ni++Tq5YNUBgbUt4iEEWPGNx/DFbKYrmHEP5j5/QqgJJmwP2jkMm7mwj8ZcJB+zHl14P4K/jkRpzeWq7d2K9acyevn6b+4SUb510giUFACN72oq3lOg2b3LzExidGuGLe8rGQchHHB47KQ9M2CYToUn5p+GAVADYo0h0VU8fEwzkBVIEn3jnM0SE/U6wGO663WsWRMo7u6JssBplwxlhv4Gzw9pphNgK8ORYIGjzYcFLZouftc4JRmTRvD161oBuWraJHZOK8/++NkHp+GEcC5muKqFYsgsdPVg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PY0xiWFQecgal2/ZWgSdcblOWnyVT/167g7KY8Tz2s8=;
 b=rKVSQai6fzJjjIwt/3d+5dDRYqEJ86ZV7hET+neh1eK+bo50Xa+Bu5NMA0e/r2N6ZqD4qW0m0iM9IP/uGLoPYB7WV+6Ob70A1tD62LJ0Gk+BdGQAFsw9bg6czI5wR38p27JwCuJrWpxtJUNo6g3FTTa63OI0lEhA3wuEgB1ZhgY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN2PR12MB2941.namprd12.prod.outlook.com (2603:10b6:208:a9::12)
 by CYYPR12MB8991.namprd12.prod.outlook.com (2603:10b6:930:b9::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6433.26; Fri, 2 Jun
 2023 15:14:46 +0000
Received: from MN2PR12MB2941.namprd12.prod.outlook.com
 ([fe80::8c06:c9e:c6c2:3b16]) by MN2PR12MB2941.namprd12.prod.outlook.com
 ([fe80::8c06:c9e:c6c2:3b16%4]) with mapi id 15.20.6455.024; Fri, 2 Jun 2023
 15:14:46 +0000
Message-ID: <e10fe6c9-b13c-8046-1f9d-0044e670b0c7@amd.com>
Date: Fri, 2 Jun 2023 09:14:43 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v2] drm/amd/display: Avoid disabling GCC specific flag
 with clang for snprintf_count()
Content-Language: en-US
To: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>,
 Hamza Mahfooz <hamza.mahfooz@amd.com>,
 Harry Wentland <harry.wentland@amd.com>
References: <20230602041444.1432649-1-srinivasan.shanmugam@amd.com>
From: Rodrigo Siqueira Jordao <Rodrigo.Siqueira@amd.com>
In-Reply-To: <20230602041444.1432649-1-srinivasan.shanmugam@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BN9PR03CA0337.namprd03.prod.outlook.com
 (2603:10b6:408:f6::12) To MN2PR12MB2941.namprd12.prod.outlook.com
 (2603:10b6:208:a9::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN2PR12MB2941:EE_|CYYPR12MB8991:EE_
X-MS-Office365-Filtering-Correlation-Id: 714a9b83-d3de-4ea8-f3d3-08db637c19cd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: mcv/vy4XFKKxur78GSLzUK9I/eo/malZBtnNCFi1k1NI1YdxVm7YGv2NwQt/I+ghaMA/ov7cViGzxYFJJCF5xS+dkf7PqrNHLZPDJ0UkPFQeMyKVaYI/yZGMF+nwcmZ4wHQYV4pFw9jDGdQ27aaqw2g7Yvljm7a/lVrrDL2IbYUO0QejDBbHq3XEfoBvenc7lrEyjaxbj/h9t8HVnU6t3LcHtg+LaUeeA42larAFy5jaOX3sLAiuXCB93LTD6459Ai1CYURDDbAAUUVBtqlA8uLEAFcB+hPMebFNu6CHevmktUhFjFzojVzC5pSwvSvzqR4LuM/odLU8afQO1k0glk7LiZ8/8QZSHG8++5WywbtHvLF7c7VPBU+uIcflmheHtQBYR/cpeOLM4Dn3SRyKgrHVpUB95NmsdeLrOlCqQ5g2hJIBbQf3lIxT69WKcfFQcRtq4iA5SrY2oWOCiP4mM1i2xmECLUqtPB1ly/38DPNMMS8gpyuK0u7QpyQ5AozpCms8x5bL5qeayB2ACWl3p5eno8SPSc8Xx150Bd4OYzSonkJVbSCLZgNYkPTJjJRqfnmZ+oyFpmQrzMd+Fyg4hwO+vEgp425itqpdwESSX8Y=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB2941.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(4636009)(366004)(39860400002)(136003)(376002)(396003)(346002)(451199021)(5660300002)(31696002)(41300700001)(8936002)(316002)(31686004)(6636002)(86362001)(4326008)(110136005)(66476007)(66556008)(2906002)(66946007)(8676002)(478600001)(38100700002)(36756003)(6666004)(6486002)(186003)(966005)(2616005)(83380400001)(6512007)(6506007)(53546011)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bEMvN0xaaVUzZGxTZDFqZkw5bkJ6VXIxV2txc292REhsa0p5WUErS0lIZ1VK?=
 =?utf-8?B?Y294dVQyUTJIc3BPdTdSN3p6WnNQMVVzakV5TmZXLzRFRjdVWUxZSVd0S2l3?=
 =?utf-8?B?NGVxaXVXOFZDTGRJZTd1ZVVpY2hVaVYrc1k2MlNaWkhialBIZkVoWGRKN0w4?=
 =?utf-8?B?WUozQnlUZGN6UGlYSTE5bEUyNS9hdWQ4Rnpxek5oV3ZYbng0N2lGZ0VOdFEy?=
 =?utf-8?B?VHZOZy8zT0NHUjdwSEZIUlAzSE9aOGFaVHgvUnlVbzdacGtTQ3diQzRMM3d0?=
 =?utf-8?B?cjdoeE14WHNaT1Rxdk1GUVVzcVV0bTVFSnROMU9PN2MyMW5hbDg5YlkyQ2dn?=
 =?utf-8?B?VUZEemtDcGJHZ0FEK2RpN3kwVkV0L21vcGUxQUJKWStJdFUwVVdSbXhPSDdV?=
 =?utf-8?B?dGg5T2NaTkFJbmxhREdTSUZEcHNaVTFNVXZqYXBrc2s5ZFVGaHJveUVRRW9L?=
 =?utf-8?B?czlVbjBQQ2F3NGhJMHlNanBKNzVxWmEvQkVWam9UM2tPUldQQVFZNk5wTXdX?=
 =?utf-8?B?bFF5RlJNTU0xVmNqMzhuNk91UDJ6NG53bDF1NTZNZ2F6UDBnL2RCQ0FWVkkw?=
 =?utf-8?B?eGdIOGhIK2hmT3JLaFdMMGF0Z2d4TWpGR0U2bjZlNWcyR0VHSDJkdXd2eEhL?=
 =?utf-8?B?TUtGYjVyQkdhRXh4WW1ZV2NrL3ljNWsyUlozcHlyNHkwS3QwUlVDTjNvRWdu?=
 =?utf-8?B?YzBOQkRzSHFmZ2JiQlYzSmJjZXp2eEJVQW9Qb0tVRTBWYThSRXUwMjVtcDdk?=
 =?utf-8?B?a2srbDkyMGlOZmdzRXpCcVEyT3ZoZmNIb1lhUDM0RUwxazFhWjhXalorYU9C?=
 =?utf-8?B?bHJSZ0VxTWN6OWxVdFdTandyd3ZhUHZZUlhVRW1ubUVDb1VBTGRNNHRxaEpo?=
 =?utf-8?B?Tm5oNTR0bTYwMzRYY21EL2lhOFFFbStZTFhJY2t3YWg3Zk93M2pEWmE3dVlI?=
 =?utf-8?B?VUFkczNxcDB5eXBxRlRCWXBKcmVSaVk0bTllMHcrck1iWGw5ZkloUDFxTVVz?=
 =?utf-8?B?L3FmeDduN0ZGRUlvVC9NSlZDclJQeEpnUWpMZ1h1MndyRlVPYUpZeEZrOHdW?=
 =?utf-8?B?RzF6S3l2cFJoRDRBTWl0Y1NIWWxhejc1SW9tU2VRTC8vSHBRdENNM3lhTlFN?=
 =?utf-8?B?a2laTHJhbFN1cFI3ZTNMQU92NGM2M0kxSDlXbU9NU0hYNTlyYnlFVEFlaisv?=
 =?utf-8?B?MnBKLzRCSDVsMEYzNkdyVmZZcWZnZmRjTjg1VUkvUm5oOUtoYVZxZVlBRFp2?=
 =?utf-8?B?cnluWXdpM05EeUhCWS9uVGxWL1RRUkE1Z0xiOTFVQXR1MjFIS2JIVjJORE1Y?=
 =?utf-8?B?Rkg4bmVqMS9PNEp2bXA2aHBaSjllRm5GNnZLemU2K3Q4YnBqNlN5RERnVURG?=
 =?utf-8?B?OW1mQzhxeDdkb3I1Snhxa3kyQXNvRWRRTGMxMEw0TE9YdmE2N0piUDdSOWtV?=
 =?utf-8?B?VkpvSSt6V001cTJFcXBuemhNM3hFNUhwQzRubE9YRXk5a1NteTNVdnc4d0RU?=
 =?utf-8?B?VTY0VG9qbzk5NmJkTWtmM29TblZ0dkRKVE1FYWhFVHNPMldrZFoxbVJaUTdK?=
 =?utf-8?B?S28wRkFORmpMSzJReUgwMlFqRmp1aVFidkczWVIzUEdVby9GVyt3cEw3WS9t?=
 =?utf-8?B?bTgxdFFlU2dxM2NiaGRjbVNIaEdBWUhiNnF1RjVlclNtd0N3c0s2Sjk2SXho?=
 =?utf-8?B?enVDeDRRN2pIQ3RlVUdXdXNSWG9JQWcrYU9qRVhaazI3ci9jQ0V3L0pOYUNP?=
 =?utf-8?B?YTV1UnFFZXZWSzMwOEE2UFBPaXlUUXBtOUxJQXA2RXhlMGt2d2xNSlgyOEkx?=
 =?utf-8?B?Wm15bit1dDdEQXEzTkgyZWFBNXpuTGZUV3hNYkxSdVpRL2RaVy9lOTc4c0xJ?=
 =?utf-8?B?dGxSa2dxc3h0Z2VmbzhyT2FxNDRKOVkyM28yMERYbW1SUXNkZDE5QVZjM05t?=
 =?utf-8?B?V3JXUzRHRjNsZDR3bmhPMktTUkFmSkE1bHFwQmhsZTBuUXRDK3BkTnp6eXRG?=
 =?utf-8?B?Z0FUSnpEWmxEM0Jpem9TTE0yWk1IN3E2RjFhUEs4bzg5VUx5Q1lIa2tZSHhZ?=
 =?utf-8?B?d05laE9ZYkphLzBEcDdwUUhNT0ZBK1JxZkJYM1VHZG84WTk4T1lHaGpGTjJx?=
 =?utf-8?B?NjBuSi9RcUNONTlXNWJTSGFuMlhCeTF6MG1XaFRXRUgyeDZueERoclZyZno2?=
 =?utf-8?Q?tAFcE1jDlFDE2KVlJwcRi8dQBbU4gdyCfRamSvVVxQ2V?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 714a9b83-d3de-4ea8-f3d3-08db637c19cd
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB2941.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jun 2023 15:14:46.5960 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cXARUNjbfXIebhQesc0Em3HGlOHr+DrqV4me+6OafT++ZnssBwGRFm0KSFEIBxkPkBItmPddXC3ujb8s0XecJw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYYPR12MB8991
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

Hi,

Imho, it makes more sense to use:

https://patchwork.freedesktop.org/patch/540285

Thanks
Siqueira

On 6/1/23 22:14, Srinivasan Shanmugam wrote:
> These warning can cause build failure:
> 
> display/dc/dcn10/dcn10_hw_sequencer_debug.c: In function ‘snprintf_count’:
> display/dc/dcn10/dcn10_hw_sequencer_debug.c:56:2: warning: function ‘snprintf_count’ might be a candidate for ‘gnu_printf’ format attribute [-Wsuggest-attribute=format]
> 
> The warning being disabled by this pragma is GCC specific. Guard its use
> with CONFIG_CC_IS_GCC so that it is not used with clang to clear up the
> error.
> 
> Cc: Hamza Mahfooz <hamza.mahfooz@amd.com>
> Cc: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
> Cc: Harry Wentland <harry.wentland@amd.com>
> Cc: Aurabindo Pillai <aurabindo.pillai@amd.com>
> Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
> ---
> 
> v2:
>   - Alternate Solution 2: for proposed
>     https://patchwork.freedesktop.org/patch/540285/8, suspect that
>     code is in DC, to see if it compiles even on windows also.
> 
>   .../gpu/drm/amd/display/dc/dcn10/dcn10_hw_sequencer_debug.c   | 4 ++++
>   1 file changed, 4 insertions(+)
> 
> diff --git a/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hw_sequencer_debug.c b/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hw_sequencer_debug.c
> index a0f8e31d2adc..e14b6747bbcc 100644
> --- a/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hw_sequencer_debug.c
> +++ b/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hw_sequencer_debug.c
> @@ -45,6 +45,10 @@
>   #include "dcn10_cm_common.h"
>   #include "clk_mgr.h"
>   
> +#ifdef CONFIG_CC_IS_GCC
> +#pragma GCC diagnostic ignored "-Wsuggest-attribute=format"
> +#endif
> +
>   unsigned int snprintf_count(char *pBuf, unsigned int bufSize, char *fmt, ...)
>   {
>   	int ret_vsnprintf;

