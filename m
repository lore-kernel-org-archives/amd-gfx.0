Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BF324C52D7C
	for <amd-gfx@archiver.kernel.org>; Fri, 23 Aug 2024 13:13:43 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7333E10E804;
	Fri, 23 Aug 2024 13:13:43 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="RDZpewUj";
	dkim-atps=neutral
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2057.outbound.protection.outlook.com [40.107.223.57])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B1E6010E804
 for <amd-gfx@lists.freedesktop.org>; Fri, 23 Aug 2024 13:13:42 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=O5BfpoPJa7uNXLxWeLfEAL0/0AwcbCqU2upp11DwBoP30Jgvs7vOgqIZtgrzjOBWnrTknZokzHHSvpYTeMOrxC9h5dE0DAyne6hCNcqYBOCHeba4a9XqnqUkFtYU3l4zlRAT3DEb8XgY6KgmtdhYZOH0Knrp8dFuZfKs+KrlKNZcV52XXlaXrW6wnSaUHnAmGgR/k14Yb7io2g5h4sBroa/LSf2XWMG35kt0ZR+VPP/4MaFRdzO0jrusiwesLNubb/y2TIYUmvCe5ueVBxe2Q1kiz1aR4rbzs6wh+7CODQ6Xz+a8ZP3hc5u+sgpC0Oq50maz62y42VO68yh09+l80w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DadMjfB+42Bs4zQAKA+EJX87m43Oc5Nw/T3LyaUJVIo=;
 b=W1E9JjQn1mjtYV1Fxpwur9RxKOd01gtr3FpK40+F/bERFk2CSWhSgSaSFjvEwOSpDlgJLHJvjE9JP3axcWRU8lWc7Xc+PtFdv9brN39PvLv8IMDSNOuZtsKOtibM/sNwRZMKWUZJyrWNTeNAY99tx9gL87fiNOb3OXnqSSECe2CZrzqhHpaGB0jfcz2vS+2MbAjJDWDRksh4l2S5//6GR3u/Aa7OHaCc2WlkEm+pOaIJ1WTQdlclXn1cwsIaGrCCFfkSN8v1/45jHExSw4BBO+yGM7KUgqSqwrhjGbB9QN5sT5lbbGdmgl0G6jr3cMOEWhPUmPjHIXe7FOgLeBbBmw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DadMjfB+42Bs4zQAKA+EJX87m43Oc5Nw/T3LyaUJVIo=;
 b=RDZpewUjVfuB17puUkjdgVes6vQqdpP/2Eo5HEBxOP+4AoYBClogJQWUxYbIAVyfF3SCoK3Zp7Qs1ZTh3SybCpeqHIH5ACa2sXZNJte4QTz4Jnahcs8SwQtsLIweUoSXUSp+Su7XZPCyYMzSuoA+KiXpm3RcQLi0tMimA0GcZLw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SN7PR12MB6839.namprd12.prod.outlook.com (2603:10b6:806:265::21)
 by DM4PR12MB6566.namprd12.prod.outlook.com (2603:10b6:8:8d::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7875.21; Fri, 23 Aug
 2024 13:13:40 +0000
Received: from SN7PR12MB6839.namprd12.prod.outlook.com
 ([fe80::eaf3:6d41:3ac0:b5f4]) by SN7PR12MB6839.namprd12.prod.outlook.com
 ([fe80::eaf3:6d41:3ac0:b5f4%6]) with mapi id 15.20.7875.023; Fri, 23 Aug 2024
 13:13:40 +0000
Message-ID: <da9d3521-f053-450a-a424-ebb5cbc61142@amd.com>
Date: Fri, 23 Aug 2024 09:13:37 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/1] drm/amdgpu/display: remove unecessary TODO
 spl_os_types.h
To: Zaeem Mohamed <zaeem.mohamed@amd.com>, amd-gfx@lists.freedesktop.org
Cc: Harry.Wentland@amd.com, Sunpeng.Li@amd.com, Rodrigo.Siqueira@amd.com,
 Aurabindo.Pillai@amd.com, roman.li@amd.com, wayne.lin@amd.com,
 agustin.gutierrez@amd.com, chiahsuan.chung@amd.com, jerry.zuo@amd.com
References: <20240823043543.1939766-1-zaeem.mohamed@amd.com>
 <20240823043543.1939766-2-zaeem.mohamed@amd.com>
Content-Language: en-US
From: Hamza Mahfooz <hamza.mahfooz@amd.com>
In-Reply-To: <20240823043543.1939766-2-zaeem.mohamed@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: QB1P288CA0008.CANP288.PROD.OUTLOOK.COM
 (2603:10b6:c00:2d::21) To SN7PR12MB6839.namprd12.prod.outlook.com
 (2603:10b6:806:265::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN7PR12MB6839:EE_|DM4PR12MB6566:EE_
X-MS-Office365-Filtering-Correlation-Id: 50c00368-7e71-4a71-8758-08dcc37567d0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?dHBLNml0WGpUMlZHSk81TW5uUWdpS1NpN05SdTQ2NWdwUjR3M295b2RpOVhU?=
 =?utf-8?B?MEFhSTYrOU5heVVzRkp2akJzb0NVYVA0bEdvMHIwdG13ZnVFV1ZvWkFqakN2?=
 =?utf-8?B?MHArTnY2RGJhV05QdVFUZzM3bHhhRThGWThSS0VVV2wwRGtkcEpXcEFCTGwz?=
 =?utf-8?B?Sjlja1ZnVUFacmtuYmNnanNVSTJuZTdVV2J1NFk5REdmY3ZybE9rSUsvMkpP?=
 =?utf-8?B?VXVNN2sybDdRNUEvMjgxU0Z6a3hid1VXRGNsVDJ0bUNLcjJ4V1Z5RVh1MGdu?=
 =?utf-8?B?WWJEODFpeEhHanJqTTZueG5rc2J1c1VvQmo0NWVHZ21aMDNvSjhSeFhtelZK?=
 =?utf-8?B?U004aHk4WFc0RDFxZG5ZMXBaclp5dDhXWHZ1cnJRYWpweGZMdzV6RzljcG9J?=
 =?utf-8?B?ZENUS2h6dDBLZ2VLNkxiaEFOUzJTQXUrbk40Q3hMdzVUNlZKR0lMTlBwSVBJ?=
 =?utf-8?B?REFmMlZPMlJ3cDRZcHNsTnJmUmpaZXdEd2pVaHhWcjZ6S2UxdkVDa01RU212?=
 =?utf-8?B?Uy9mSkw2UERrYjVEOTJnYWEzeFB0WkU5TTZ4a21takdnWVJ2Rjk4ZjNxM244?=
 =?utf-8?B?UGdRbUVFL2YwaEQ5aWtmS0pOdEMvbVVPSHNlQjBrZEFNRjJoQjREdDEwMkVK?=
 =?utf-8?B?Wlo1RHdhUUw3bDUrRHgzMDFUQ3c4MUZRVCtaVU5ra2Z5cGpSVU9YMUloRDFa?=
 =?utf-8?B?Tzhvb1NtWGFUVnBSVGlDZlVpOWxZNGxhbmJCQWlYSGIxUWhhK0xMQW5IWEk3?=
 =?utf-8?B?MzhiTzVjQjRSOEttLzVvTWpZWVd1b0lCaHRKcjdaVXNiVVJibjV0V0pOZHp3?=
 =?utf-8?B?MkVnZnIrcmNiWU1Cb3pmelhab290QVp1SWFWVXNvejVYRkU0VE1WNHJENmRR?=
 =?utf-8?B?NkdPMU43TSt2czZGSU5xWUY3SkJNaEo1eTZpR1NucEhjb3ZnZmxSY0hpUExV?=
 =?utf-8?B?dEFnMGFUUDljR1JWcUhqWDJCN1JIRjJvOXlGUk5nWkQ0VjFjSExWQ3pKbUVs?=
 =?utf-8?B?NFY3UEZxZGszbC92UjY0MkI3YlB2UmRoeENlTTR2dXV3V3V1enkrQWVKUkJ2?=
 =?utf-8?B?NUltUHRnTHhBb3Y1T2FBcFhMWHZEQXBmT2JIS1BUV3pmT0VpY2ZhTW9OVzVR?=
 =?utf-8?B?cDFZRzFFbWh6K3VQTDVFSDR4aXRjL2UwZm5ZaEc0V1BYZGpEM1VqSDgxLzI0?=
 =?utf-8?B?UGQvTzNwS0h2V3RKR2x4ZU53TFkwQUFWL3NXSkFVMitZY1JRVkpIRVAyK3Vr?=
 =?utf-8?B?Z1gvSnllaHhuTk5JRk9LWVp1NVpNY1FUTCt3d2VEQW4vRk5FOGxyTTl1bGNP?=
 =?utf-8?B?dGNsaDhLNERGdTV6VEQrUmVnZ09hVXZnVjFSZkxsajl4RXFaRGNKTis1U202?=
 =?utf-8?B?cVRkemdmRG43N0tFclBDYU9ZTytVcUdzdUJPUzcxRlFFeEx1ZmZ2Ry91U0c1?=
 =?utf-8?B?UG95OVlwbFZMSy9BOWdFNEhDZHpoa29iT1dva1VqeGRINkU3Z2hGUmlhMXBO?=
 =?utf-8?B?VUovaXdUNUFXWGU3Z1I1eHV3MmZKdC9yZUF2WldGM3hRWDI4a0xyem1qSHlI?=
 =?utf-8?B?a3J1L0dYamdSbnBPVUh0dDM2VUhieERJU2tZb05yKzlSMlNCaUM0akx4NjVp?=
 =?utf-8?B?Sm5QMUh6WnNEc3pONlVmYnVkK2Fuc05oOVFBVHlDMFNSRStnNTExVFZQeFhJ?=
 =?utf-8?B?cWtZeThJN0xZdjdTUURScG4rRzg1WUJFRmxTSDQvSkVabWY0STUwbXdPM2FL?=
 =?utf-8?B?U3VybXduZG1PYmxTUkU4Q1Q3Z0xHZmtqditJYm1BTWoxVnRQdUNGRWxpWFps?=
 =?utf-8?B?bUdURFJ1MmNtZC9tSDdzZz09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SN7PR12MB6839.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZTU2cC96dzlGMVpsc1hOcWxibUg0amI3WFJxeUJkZTRrRlRXb0FHTlR1bEFY?=
 =?utf-8?B?akJvMGt0Nm02aEhWZTRqZlJsWDFWalpSblR4bi85ZlNSeWJrb2I1K3hYQ0Fv?=
 =?utf-8?B?Rm1hTHNjZ3RRNlFIZ3FwODA4L2ZBMmJvRytPNmJYWVcrWi9FekY1ZEpJM3Ew?=
 =?utf-8?B?QXJ5dXliZThpZ0tBa3d0bmMzdk1lTzRRSmZzMmVULzBhNHJjSGxxRk5ldWp5?=
 =?utf-8?B?NDBELzdHd0FhaHlVQnk3cHh5dWsycjBva0hLeEkwN2hQeHVtZFZMMWltVFQ5?=
 =?utf-8?B?SUtTdUhJU2d3UEFvMllvcVp3UDZ0Tkh0ZlpUSytZYkUrZEpaR2NacllQbGJi?=
 =?utf-8?B?cHZiL0dpR3BoM3RuQ3RGN25OanpOMmdxTSsrME5rTmJwNnlzUzJMT2cxLzZF?=
 =?utf-8?B?dzJtNnZUVnd6M1J2ZGIwUGoyL2tneWxVQUkxZ0d2c3hCVHZ6YTBWZlVIWFhF?=
 =?utf-8?B?VHprL1Z2ejl0OXJYUVZQOTNyUW40eStOU2Z2S3dSY3lzcjMwbFJWeERhVHZU?=
 =?utf-8?B?SnVzbGdwbTh3UmZFS05aOU5HaHlWRmZJOTNqZFp5Vml4M3pHU1FFT3BjWmV5?=
 =?utf-8?B?NjZaTE1aVzNFSmxpQkRlazlzUk0vb1RwalJITVFTZEJOQ2tGT1dSbXAvRXVC?=
 =?utf-8?B?eU9MOUEvb2VFcklJcjE4Wjg4SGRQUENhL2ZvMkNRM1JlbXdJWng1ZW1vSUZk?=
 =?utf-8?B?c0h0eW1TYmxaN3JSQ0ErQ1dwQXdaS1MwTFkwSkppemEzQ3R1QkFIQ3ZVOVRq?=
 =?utf-8?B?UGIxclhTb1ZlbTRucHMvY2FIbVVRTzZjY2tjakh0Q2JMTCtUaWVRU0EyTzdR?=
 =?utf-8?B?SFY1TkRVeFlidzJCT2dXUGVvRTZCbWpqcnJ4ZVRNeWN1dEhaQzV1a0d6MUZD?=
 =?utf-8?B?MURVbEpKd0tSVHJQeUp1U3RkNDAybGVTWFJGYTZLcitjdFhVbkFsREFldjRr?=
 =?utf-8?B?T1AvZzlLTjVXWFo0eHdncWFiKzRUMGVXNU9aVXR5Qno4OEhSZ0VqS2l4ZStZ?=
 =?utf-8?B?bC94bWhOL3FXL2NFOVp0TVBWUGxRL0JkcWhXMTh0THF4ckdKU0pEL1RDckdS?=
 =?utf-8?B?bFhyenMwWmVId1VyTzJNeDlFWDZLUHdSUVA2YW9qNm10OFNNdExUcVNjZTZN?=
 =?utf-8?B?NlFtUDY1VldwcDMwN3Q3a0dob0cyQVppaFhreTZGVjhlSHdNUVh4aWRIRjlE?=
 =?utf-8?B?aDZlYVJveDZKZlY1VTNMOWhPSWxub2pXWDQzTlBteXJVOE15a3RXelJvREwz?=
 =?utf-8?B?c3FZQTVpNzE2K0kybVVlSHhyVmJFVWcvT254N3FsVHBQTkNnNGlNU3JFVllm?=
 =?utf-8?B?Z051dThaakdlM3pGT0tWUjhNaUE3QmgyOUQ1V1JsMVgxSkthYVg1R2psRFNl?=
 =?utf-8?B?cjhqR1pmSnhIS0NQTlFaMC9VbmJzME1LQi93amNOMlpPMHFLZTNIaGw4S2hQ?=
 =?utf-8?B?amhPU0czWTh0d0Q2ZGZJUFB0RXdEUEk4VGhxMi95Ymd0K0tQQm5IUGtHYVdI?=
 =?utf-8?B?NGpCZXBncWk1MFRhU0NEbkppZWZ2Sk1ZclJyclJDQVE3aVlnbVRwMkRtTDJa?=
 =?utf-8?B?c3c0TTYyUmdLMjBpbUtVOHE4eWdZTTB0RmVSQXZMS09VdThDTUFMdXdxZ045?=
 =?utf-8?B?WUNlTDNaQU9zaXI4bGhGSm16MElyNEFob2w5VGRSYUNrS2h3YTR1WHpta1FC?=
 =?utf-8?B?VnpNNWY3RUNNTEJYU282V0ZjU095LzB2S2tNenpGM1dnQkxxZVY1N3N3TlBG?=
 =?utf-8?B?czlkdmlZNkZaOHphWFJLQW9qT0NiL0p5V0pBQzlvWEYwSUExNHY1c2p1VlQ2?=
 =?utf-8?B?R2FUOVJxVm9PTjh0MjJqR2NuanNOZVplaVlodC9JKzFtZzE0cUo3cVBiTEhm?=
 =?utf-8?B?WnRBOEJmRXk4T21Gb0haS3RjcXUwMkhteHNIeEN6SENiVXcwUmtsRVo5Rzlo?=
 =?utf-8?B?SkJKOGdBTWthZG1LV3RRN1Zrb1lNcVpIOXRyOGYwS1g1OWlRUENrYjVkM0Vp?=
 =?utf-8?B?ZE9qb3VRbFJtSEVnQ1NWb3F0L1ZKQkxPcFNTSWlWQzRJQ1g5YnZqQkV1UDdS?=
 =?utf-8?B?VjBiTER0Q09aNDY0RUVWMGRYOW1BeXhVNEg0bmppNm84eXFvVnBLbVcxL01P?=
 =?utf-8?Q?KuwlVal/xPcmKcQ8HhEfj5ClG?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 50c00368-7e71-4a71-8758-08dcc37567d0
X-MS-Exchange-CrossTenant-AuthSource: SN7PR12MB6839.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Aug 2024 13:13:40.1527 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tbol2cRVoSuwdcDq7Afm6/dwrY2AE6RPx/Tj/+nyhy+tEiZqcWM8rIfsBw7yLF9o7wTwXVSAEkh2VCmju0PtYw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6566
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

On 8/23/24 00:35, Zaeem Mohamed wrote:
> Remove TODO from spl_os_types.h
> 
> Signed-off-by: Zaeem Mohamed <zaeem.mohamed@amd.com>

s/unecessary TODO/unnecessary TODO in

With that addressed:
Reviewed-by: Hamza Mahfooz <hamza.mahfooz@amd.com>

> ---
>   drivers/gpu/drm/amd/display/dc/spl/spl_os_types.h | 1 -
>   1 file changed, 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/amd/display/dc/spl/spl_os_types.h b/drivers/gpu/drm/amd/display/dc/spl/spl_os_types.h
> index 058306bb41aa..709706ed4f2c 100644
> --- a/drivers/gpu/drm/amd/display/dc/spl/spl_os_types.h
> +++ b/drivers/gpu/drm/amd/display/dc/spl/spl_os_types.h
> @@ -18,7 +18,6 @@
>    * general debug capabilities
>    *
>    */
> -// TODO: need backport
>   #define SPL_BREAK_TO_DEBUGGER() ASSERT(0)
>   
>   static inline uint64_t spl_div_u64_rem(uint64_t dividend, uint32_t divisor, uint32_t *remainder)
-- 
Hamza

