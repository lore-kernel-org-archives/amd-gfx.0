Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EBB29C25B76
	for <amd-gfx@archiver.kernel.org>; Mon,  3 Jun 2024 15:51:33 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5A28510E09D;
	Mon,  3 Jun 2024 15:51:33 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="qj7ncFDi";
	dkim-atps=neutral
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2087.outbound.protection.outlook.com [40.107.243.87])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8052410E09D
 for <amd-gfx@lists.freedesktop.org>; Mon,  3 Jun 2024 15:51:31 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gLZvy6l6EKbjD1I9Bl162V+vjO4i/9Cs4t6WQBro28ajLJpn24eJ07kEV1XdgK62dHOpUFRCSIihJlB8idVhb4qIpU+ASK33z2jrFRTZsV7d9HVvvxo82aBmk0XoWbGCIjcihDQOBDhwMvqCZ8uY+lokZpFq/3av+EdL6KyVY4sdVWLnAF25PPykMU7ZPmbt1DgFx8CK1dRklKkYTXkokRv+Sv4n0JXKyP3iVh7hPyRz/RpBwn+qkb+yOaF4MI+BST5PZmHTtSPIlobPINmZ6/L9DE5DgjPHGMW3O6BsVfkKYBMkjmCjlMQiFjxggqAXxR7BwF3SGqe5v8BM0imXlA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=A+PwAnxjfmcsDQHQtaL7E+ixzwp8pg08Bjp/17amm4w=;
 b=aVlWVvitbA/+8skCNfxtBYEl0v472wZ4v+HmGhtmkLh6YtpbiGXwAIekyDuT5xFDloUpK1g0E7ERde8qPU4uN0hPbXHtPzPPd7Gm4aqL8i5t3RZui1YESETC8GfWqogg9lS4K4/HR+EUNyRWofPpMm6+6v2EQshB6yVNPtek7EDau9inQmNkhPU5H+43UQKimpyhhPWYNPOSbx3cMie4Xle5kU6SXBXKy/4OPTmjoXWIaTMbRd0Nzji25l8rK9T5O51x+FoFunE2V/tCAfLpifA+sUbyIPx2Ey7w9KaxQBE1LKz2uE3kWiItLt93deUJKffnpEop9tx6UmVGE+VpRg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=A+PwAnxjfmcsDQHQtaL7E+ixzwp8pg08Bjp/17amm4w=;
 b=qj7ncFDiB/Usj9Y/8fwGX+Zal4aLpDKAAB6p3jjhFOyJfnW1KVcBta6ap/1CZEoMj4S/UD7WE9SSZg/Lybd123KYu4tHfEDznBIlf0M1kYK304siIbZrPEGh142F5k/2TbZAQL/kK1W6kXQyslFUr+F/YI5qgEeG46iHTeeurKM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BL1PR12MB5336.namprd12.prod.outlook.com (2603:10b6:208:314::8)
 by DS7PR12MB6238.namprd12.prod.outlook.com (2603:10b6:8:96::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.17; Mon, 3 Jun
 2024 15:51:23 +0000
Received: from BL1PR12MB5336.namprd12.prod.outlook.com
 ([fe80::a3de:b197:926d:e124]) by BL1PR12MB5336.namprd12.prod.outlook.com
 ([fe80::a3de:b197:926d:e124%6]) with mapi id 15.20.7633.021; Mon, 3 Jun 2024
 15:51:23 +0000
Message-ID: <f40c53bd-3eac-4c1b-8693-3b11aa9b8837@amd.com>
Date: Mon, 3 Jun 2024 11:51:20 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amdkfd: add reset cause in gpu pre-reset smi event
To: "Lazar, Lijo" <Lijo.Lazar@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Cc: "Kasiviswanathan, Harish" <Harish.Kasiviswanathan@amd.com>
References: <20240531150818.119896-1-jinhuieric.huang@amd.com>
 <DS0PR12MB78046739F480CF153C36FB6697FF2@DS0PR12MB7804.namprd12.prod.outlook.com>
Content-Language: en-US
From: Eric Huang <jinhuieric.huang@amd.com>
In-Reply-To: <DS0PR12MB78046739F480CF153C36FB6697FF2@DS0PR12MB7804.namprd12.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YT3PR01CA0128.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:83::6) To BL1PR12MB5336.namprd12.prod.outlook.com
 (2603:10b6:208:314::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL1PR12MB5336:EE_|DS7PR12MB6238:EE_
X-MS-Office365-Filtering-Correlation-Id: 565fede3-6902-44b2-b906-08dc83e504e9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|376005|1800799015|366007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?NUZZcmV4SGVSQTZ0ZWhvNElPS2h4c2xyNStMZEVZOTlLTk5HMlFXMXdJU093?=
 =?utf-8?B?S3VaeG1rdzJUa2k5YW9YYnlYWUJYZWh1cUR6NnNJSzcycjFqdUZxZk02N3R5?=
 =?utf-8?B?c3cwQW5nZEJNZGN2akFZR09XT216N3JtcUVDaHJidVRjRDlTNzZGWUsvMG5V?=
 =?utf-8?B?QzZ0dEcwMW1YS2pxVWlFZUhFeVVCZFB1YTVJQ1o4QkR0TXJGZGFEem5UUUNF?=
 =?utf-8?B?cHVrQlNHc1JFOWUzSHRXQ1drM2VHdm5hd1dXdFZPRlhHMThubHRzTndCMnJa?=
 =?utf-8?B?UkpFR2ErNzBFOXdrM2pkQlhPaVRkOWo4VjhMeFFUZ3VJSnBUU3F6QXdSbktK?=
 =?utf-8?B?NEdLd2hGdGlLRXovZ1VMVWF6Z25kb3lvN2lvdFhxeFIrSmlFeGhlSlltM0Qr?=
 =?utf-8?B?MzQvNDZXQnZEUnREb1BuL09laExOL0Q5d0xnSHpPaVVTejRiTFN5eCtHTjRP?=
 =?utf-8?B?akJHNk95Y3VuNWdVbGN2dHhrMDJpUUNOWFExdElWMWhRT05DQlN1T1FycTZV?=
 =?utf-8?B?ZkxKSWFZcnVQMU5HSTF5UGdKa1R5WWxFQk8yTkJIb3hMWW5WYnliLzNBeXp0?=
 =?utf-8?B?M2FQcHNmNmZaTVQwTENOWmZRNUVJR0I1WmhHUjhpUm4vbzBFeWVNRjdsOGZw?=
 =?utf-8?B?UUcxT0JvWUEzSHFPQzlYYktRNGxwRm92UHFyU3g2TEtGTmtEdEtoN2tHc2p4?=
 =?utf-8?B?b1RMSWJWTXJOWk9seHEyRko2emFQbWNTYTY4aDNXYStFalBybkRSaDUxcUYw?=
 =?utf-8?B?eFVjeWVjUkZkamdjeWFZdlNGMExxWERWbDQrdjdSUWJyWkpKekVHaTAyYnhH?=
 =?utf-8?B?TDBqSlBrRmFOK1IvZWJWN1RNMEZrWDgvNVZ4blpDMU1vczlOQStvUVhBbUpT?=
 =?utf-8?B?ckJLK0ZnTWx0L2kzUDdpVHRZZWUzNW0ydHljT25oZkRvT1pUcHIyK3d3MUJX?=
 =?utf-8?B?cjEwMmlWcEY1RXJPNWk3RW03d1hUNGtYMlV2R1FPNFExOC9ySm96VzdRQnE0?=
 =?utf-8?B?cmZpcldBcXJEKzEwUU9yTmpkM2YzYnp1UFF1ZFZKS1NFendVWG9rRkR6MlRu?=
 =?utf-8?B?Ti9jNEpVY2lqTVJiQkpVSHJpZXY5Skh5TnpMNWNXRktDRWtaMzlXREsveDU4?=
 =?utf-8?B?c1IyUmJZMExZWDM5V2VSSDdpcFQ2Q2dwZmkvdXhobnNOUERQMytRdHZ5Vk82?=
 =?utf-8?B?Z0tvMzcrZk5ieWlJdjRCZm5jckZLUFRraHY4UHlEWE5pTE9tNzlIMjMrUU1L?=
 =?utf-8?B?djVEd056RmE1NEtkb0c3QU0rcFBrb2VhSEFDT0dYc2NjMEh0M2xNQ3QzV0RP?=
 =?utf-8?B?Z1A1Z2o2bDJKVEdTUmZjNzZGVFNZQUdCYkE0Wlp3b1hFVzlxb3NqS2VTRkd4?=
 =?utf-8?B?aXQyZnVTczhURWhQUVB6L3JnRlZhSDgxZUFFcllhdU1qbUZHNFo5K0E1bEpR?=
 =?utf-8?B?UXZLTG9TK2NYTTE5QnBGY0RmMldiU0RFR3pwdi8zMWMzQXJjTUxsY0dPZk1T?=
 =?utf-8?B?T0dnRXhCR09uRU5GUU13NGlTRUhQRXp3TlF6V2xhSUZCQThmNWYwUGxOVjJr?=
 =?utf-8?B?TFF6ODRSdmdaSWpkT2VlZEI5S0VEais0azZDR2h1UG9NZzN4SlM2czFPWHBS?=
 =?utf-8?B?elYwckVVSWd0SG4vQklyMXJQREdjcGZVUjhvc2tpeU4vRHZ2dDdBQXJoNDZW?=
 =?utf-8?B?dXJ1VFBCdW8veCtaWHpyYXJuL1ExQ3V2ZG1QaTFmRVVSSG9uaWJRaXhnPT0=?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL1PR12MB5336.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(376005)(1800799015)(366007); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SU1WS2ZDUklOdG9wWnpHVW5PczA5NWNXWlpNa2xqTnRRYWpYN0c0OG5jZmtB?=
 =?utf-8?B?TTdLY1I3dW4zZTlCRGRpVHpFdGgwTTVjNzZmeExHWlpDdDZkYXhHSDh1ZVJz?=
 =?utf-8?B?amlZM1BoWlNHenRWTFVSdVkwdDdRWUh4V3ZCaWp2OWU3aFNVSFVDdHpZQWM3?=
 =?utf-8?B?VzluVjEzN05SOWpoOVRyeUFYQ1paU21FanFGTmRWaFZSMzEvRzRUbUNhcUI5?=
 =?utf-8?B?bEhuOHFvZjlnbXFhelZiMjZ1anlBRjhnbXM2YzRPQ090TGdHMnZjY2cxREJi?=
 =?utf-8?B?d0YwdXJDemp0ekZGTHBPbVZpRDhTVjl4cm4wSWNVZ1EvWUFoM1c3bCtJcEhU?=
 =?utf-8?B?Kys3K015UDQ4QlBQQVROcnRaYy9kNlhnbGw1bkUwSjkxMGtpRG5YZUo5Vk9C?=
 =?utf-8?B?K3NCT0FCWVpRYllPdkFxRm9rOEY0b1pnU0JIN0luaEpJdFQ1eUVKVy9RN3Ev?=
 =?utf-8?B?ZXN3NGRIZExpWU9CQVVVZjNaUDIyaVVJWE5zZVBzcmtrNEdhbWMzRGpKcktV?=
 =?utf-8?B?c3ArK0Z6d3UxaFBVcEY0RVRvYStMcm5vYzB0OEh1dkN3bHBIdGhUaElIS1VR?=
 =?utf-8?B?UmM1d0xOcHlpR2ZGS3VrV1FTUGlGMEo3blpJN1d0Q2FPbDBIV0llNVBWaXc4?=
 =?utf-8?B?WC9XTllsUnR1eEVrYWNiTmsrcTh3UlZBUzBLZmFiUXd6V2d5QXhwV2ZRZ3BM?=
 =?utf-8?B?aHhKSEZvTHJHWjkvcEFQWDg1TFBqVllSWUVyb3NBbXJVQzJ2bnk0b3YxWjFN?=
 =?utf-8?B?TGg5YXlCNFVSWkJoRU5MNlRKNFdXTVhJVnZkZ3VsNXkrcFhZR2lzbytvaEFh?=
 =?utf-8?B?OUFhMWVvbW1JR3pEaFh5ci9mcE94M2dvQkFQM3ZvK2dHcUt4NkdJdHNNVEYw?=
 =?utf-8?B?b3V1QUs3MWU1by9rWGwraTMyenpQU3R6bFBZL1ZKM3k4cnZTWEhYWWRqZ1ZL?=
 =?utf-8?B?MVp1R3hhVk5wVkdmUVp0SnZWMEVxNGg2Um9sWnp6TEtHRmswUGpWNk0rQWhJ?=
 =?utf-8?B?emJvdGNVK0svbnErenBqSStZN0xDUy9XRlNLcm5ZdHQ4bUUyTEdkbG5HbFRu?=
 =?utf-8?B?dW53NmhmSVJWU25PU0N2UWNIL2Q3U3BFRE1WZS9rc1FwM2JNQlU2aU1lUzZU?=
 =?utf-8?B?QmlmNmxvL1BJeG84bVQzSWlOeFM0eEk0RjlYbVFXUHVNUWk1OHJEL28rK0pW?=
 =?utf-8?B?UFZlV1NOQlFlVGMrdlF4ZWx2Ym4yOFJsYm1OaFUzVkdVRFVoVVB4ei9SZDlM?=
 =?utf-8?B?YXF3bndvOGxMUDltQ044dVg2QzIxc2p0YW05eUFjSGVveDI1dWRFV0NsVE1H?=
 =?utf-8?B?clJnaDdnMlNyU0dZcGYxMFBKN0lmVzIxMkJNb2cxNndyeXh1NzNjaWxKcjlu?=
 =?utf-8?B?OFBuZVE3MnFQMVp5cUptWFY1cmpwNGRONlNTaTEydndMVUpnWnNIeTB1UXRT?=
 =?utf-8?B?cWd1aG9QUnF2QmFwaUk0eXJzWER0cU8yYWd4V3FqVGpqMHh2NXZML2NMQmFS?=
 =?utf-8?B?dDJBRFJJNFlTSXB0aHR2VGNyNmU5MDhzZGlKYStKbE1pRnBBSFE5ZGRmOGww?=
 =?utf-8?B?OG9hZHlGM2VhYVVISWtGOUVlM3hzanpiYU5OUmNXUEgwNUFvdFRoSXJWd3Fy?=
 =?utf-8?B?MjRXdnZMTTBLbUEvU1E2d2plQmZ6NVRlYnE4YlRwdEpLQ09OOUFIYVp2NzVy?=
 =?utf-8?B?dVpnM0RWOVBrZ1NkUUN4YVF3VzRxOSt1MUIyUzQxbTN2RmtTNGNSc1FBcTlW?=
 =?utf-8?B?VDExMVFJMk9MYkdESXZ3OE1QbVRycFdZMWppS1BpUVVOTitLMFdGQW9maWZP?=
 =?utf-8?B?cktDK2ZDbDBjK0hwbFZ1UERJOWNQM05jbEp2a1lTNUJtZS9TeU5ZSkdOOW52?=
 =?utf-8?B?UTlvWGNUaTFyV3liUUNIU0lnd0pXNFc0ZmNHc2VLUHlSV0NDOE44akJzZjlV?=
 =?utf-8?B?VitvZy9KTmlLcmVmdzJKeWRNRU5GeG90Y2hNNDdjQmI4SWNIeUdzbGtIQXI2?=
 =?utf-8?B?Y1djeVNBVXNMd0lPMjVNRHN3ZTdsMlhqWlQwSjFKY3NDK0ZxNHNnb2M5M1lZ?=
 =?utf-8?B?S3JPVGgvaHZRcHFuWkt6Yjl3bVlDa3A5TTFkOUdyUVJHZ21SVFQyZkx1b3U1?=
 =?utf-8?Q?dQXc8FWJCXXs0uL01Mz/cBuP4?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 565fede3-6902-44b2-b906-08dc83e504e9
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5336.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jun 2024 15:51:23.4855 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fwwUBwmMyEZ0Lk0FfW61Jd9LLh/hLOjdkJdUGAa11QzS7t9xEdXqtU6snGOqiBNtoKZfLsPrbXBpXV1KlYVC/g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB6238
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

Thanks Lijo, I will send another patch with your suggestion.

Regards,
Eric

On 2024-06-03 04:03, Lazar, Lijo wrote:
> [AMD Official Use Only - AMD Internal Distribution Only]
>
> Hi Eric,
>
> To consider other reset cases also, you may have something like attached.
>
> Thanks,
> Lijo
> -----Original Message-----
> From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Eric Huang
> Sent: Friday, May 31, 2024 8:38 PM
> To: amd-gfx@lists.freedesktop.org
> Cc: Kasiviswanathan, Harish <Harish.Kasiviswanathan@amd.com>; Huang, JinHuiEric <JinHuiEric.Huang@amd.com>
> Subject: [PATCH] drm/amdkfd: add reset cause in gpu pre-reset smi event
>
> reset cause is requested by customer as additional info for gpu reset smi event.
>
> Signed-off-by: Eric Huang <jinhuieric.huang@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c    | 34 +++++----
>   drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h    | 17 +++--
>   drivers/gpu/drm/amd/amdgpu/amdgpu_device.c    |  9 ++-
>   drivers/gpu/drm/amd/amdgpu/amdgpu_reset.h     |  1 +
>   drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c      |  2 +-
>   drivers/gpu/drm/amd/amdkfd/kfd_device.c       |  7 +-
>   .../drm/amd/amdkfd/kfd_device_queue_manager.c | 71 +++++++++++++++++++
>   drivers/gpu/drm/amd/amdkfd/kfd_smi_events.c   | 13 +++-
>   drivers/gpu/drm/amd/amdkfd/kfd_smi_events.h   |  5 +-
>   9 files changed, 133 insertions(+), 26 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
> index e3738d417245..3588c912214a 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
> @@ -125,17 +125,26 @@ static void amdgpu_doorbell_get_kfd_info(struct amdgpu_device *adev,  static void amdgpu_amdkfd_reset_work(struct work_struct *work)  {
>          struct amdgpu_device *adev = container_of(work, struct amdgpu_device,
> -                                                 kfd.reset_work);
> -
> -       struct amdgpu_reset_context reset_context;
> +                                                 kfd.reset_work.work);
> +
> +       if (adev->kfd.reset_work.reset_context) {
> +               amdgpu_device_gpu_recover(
> +                               adev, NULL,
> +                               (struct amdgpu_reset_context *)
> +                               adev->kfd.reset_work.reset_context);
> +               kfree(adev->kfd.reset_work.reset_context);
> +               adev->kfd.reset_work.reset_context = NULL;
> +       } else {
> +               struct amdgpu_reset_context reset_context;
>
> -       memset(&reset_context, 0, sizeof(reset_context));
> +               memset(&reset_context, 0, sizeof(reset_context));
>
> -       reset_context.method = AMD_RESET_METHOD_NONE;
> -       reset_context.reset_req_dev = adev;
> -       clear_bit(AMDGPU_NEED_FULL_RESET, &reset_context.flags);
> +               reset_context.method = AMD_RESET_METHOD_NONE;
> +               reset_context.reset_req_dev = adev;
> +               clear_bit(AMDGPU_NEED_FULL_RESET, &reset_context.flags);
>
> -       amdgpu_device_gpu_recover(adev, NULL, &reset_context);
> +               amdgpu_device_gpu_recover(adev, NULL, &reset_context);
> +       }
>   }
>
>   static const struct drm_client_funcs kfd_client_funcs = { @@ -225,7 +234,7 @@ void amdgpu_amdkfd_device_init(struct amdgpu_device *adev)
>
>                  amdgpu_amdkfd_total_mem_size += adev->gmc.real_vram_size;
>
> -               INIT_WORK(&adev->kfd.reset_work, amdgpu_amdkfd_reset_work);
> +               INIT_WORK(&adev->kfd.reset_work.work, amdgpu_amdkfd_reset_work);
>          }
>   }
>
> @@ -261,12 +270,13 @@ int amdgpu_amdkfd_resume(struct amdgpu_device *adev, bool run_pm)
>          return r;
>   }
>
> -int amdgpu_amdkfd_pre_reset(struct amdgpu_device *adev)
> +int amdgpu_amdkfd_pre_reset(struct amdgpu_device *adev,
> +                           struct amdgpu_reset_context *reset_context)
>   {
>          int r = 0;
>
>          if (adev->kfd.dev)
> -               r = kgd2kfd_pre_reset(adev->kfd.dev);
> +               r = kgd2kfd_pre_reset(adev->kfd.dev, reset_context);
>
>          return r;
>   }
> @@ -285,7 +295,7 @@ void amdgpu_amdkfd_gpu_reset(struct amdgpu_device *adev)  {
>          if (amdgpu_device_should_recover_gpu(adev))
>                  amdgpu_reset_domain_schedule(adev->reset_domain,
> -                                            &adev->kfd.reset_work);
> +                                            &adev->kfd.reset_work.work);
>   }
>
>   int amdgpu_amdkfd_alloc_gtt_mem(struct amdgpu_device *adev, size_t size, diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
> index 1de021ebdd46..1fc9ed33a1c2 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
> @@ -47,6 +47,7 @@ enum TLB_FLUSH_TYPE {
>   };
>
>   struct amdgpu_device;
> +struct amdgpu_reset_context;
>
>   enum kfd_mem_attachment_type {
>          KFD_MEM_ATT_SHARED,     /* Share kgd_mem->bo or another attachment's */
> @@ -98,12 +99,17 @@ struct amdgpu_amdkfd_fence {
>          struct svm_range_bo *svm_bo;
>   };
>
> +struct kfd_reset_work {
> +       struct work_struct work;
> +       void *reset_context;
> +};
> +
>   struct amdgpu_kfd_dev {
>          struct kfd_dev *dev;
>          int64_t vram_used[MAX_XCP];
>          uint64_t vram_used_aligned[MAX_XCP];
>          bool init_complete;
> -       struct work_struct reset_work;
> +       struct kfd_reset_work reset_work;
>
>          /* HMM page migration MEMORY_DEVICE_PRIVATE mapping */
>          struct dev_pagemap pgmap;
> @@ -170,7 +176,8 @@ bool amdgpu_amdkfd_have_atomics_support(struct amdgpu_device *adev);
>
>   bool amdgpu_amdkfd_is_kfd_vmid(struct amdgpu_device *adev, u32 vmid);
>
> -int amdgpu_amdkfd_pre_reset(struct amdgpu_device *adev);
> +int amdgpu_amdkfd_pre_reset(struct amdgpu_device *adev,
> +                           struct amdgpu_reset_context *reset_context);
>
>   int amdgpu_amdkfd_post_reset(struct amdgpu_device *adev);
>
> @@ -416,7 +423,8 @@ bool kgd2kfd_device_init(struct kfd_dev *kfd,  void kgd2kfd_device_exit(struct kfd_dev *kfd);  void kgd2kfd_suspend(struct kfd_dev *kfd, bool run_pm);  int kgd2kfd_resume(struct kfd_dev *kfd, bool run_pm); -int kgd2kfd_pre_reset(struct kfd_dev *kfd);
> +int kgd2kfd_pre_reset(struct kfd_dev *kfd,
> +                     struct amdgpu_reset_context *reset_context);
>   int kgd2kfd_post_reset(struct kfd_dev *kfd);  void kgd2kfd_interrupt(struct kfd_dev *kfd, const void *ih_ring_entry);  void kgd2kfd_set_sram_ecc_flag(struct kfd_dev *kfd); @@ -459,7 +467,8 @@ static inline int kgd2kfd_resume(struct kfd_dev *kfd, bool run_pm)
>          return 0;
>   }
>
> -static inline int kgd2kfd_pre_reset(struct kfd_dev *kfd)
> +static inline int kgd2kfd_pre_reset(struct kfd_dev *kfd,
> +                               struct amdgpu_reset_context *reset_context)
>   {
>          return 0;
>   }
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> index 6711836054f9..a9fb9b181584 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> @@ -5642,8 +5642,11 @@ static inline void amdgpu_device_stop_pending_resets(struct amdgpu_device *adev)
>                  cancel_work(&adev->reset_work);
>   #endif
>
> -       if (adev->kfd.dev)
> -               cancel_work(&adev->kfd.reset_work);
> +       if (adev->kfd.dev) {
> +               kfree(adev->kfd.reset_work.reset_context);
> +               adev->kfd.reset_work.reset_context = NULL;
> +               cancel_work(&adev->kfd.reset_work.work);
> +       }
>
>          if (amdgpu_sriov_vf(adev))
>                  cancel_work(&adev->virt.flr_work);
> @@ -5775,7 +5778,7 @@ int amdgpu_device_gpu_recover(struct amdgpu_device *adev,
>
>                  cancel_delayed_work_sync(&tmp_adev->delayed_init_work);
>
> -               amdgpu_amdkfd_pre_reset(tmp_adev);
> +               amdgpu_amdkfd_pre_reset(tmp_adev, reset_context);
>
>                  /*
>                   * Mark these ASICs to be reseted as untracked first diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_reset.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_reset.h
> index 5a9cc043b858..7ef500992f30 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_reset.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_reset.h
> @@ -43,6 +43,7 @@ struct amdgpu_reset_context {
>          struct amdgpu_hive_info *hive;
>          struct list_head *reset_device_list;
>          unsigned long flags;
> +       char reset_cause[32];
>   };
>
>   struct amdgpu_reset_handler {
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c
> index a72683f83390..cf0908996765 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c
> @@ -602,7 +602,7 @@ static void amdgpu_virt_update_vf2pf_work_item(struct work_struct *work)
>                      amdgpu_sriov_runtime(adev)) {
>                          amdgpu_ras_set_fed(adev, true);
>                          if (amdgpu_reset_domain_schedule(adev->reset_domain,
> -                                                         &adev->kfd.reset_work))
> +                                                         &adev->kfd.reset_work.work))
>                                  return;
>                          else
>                                  dev_err(adev->dev, "Failed to queue work! at %s", __func__); diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device.c b/drivers/gpu/drm/amd/amdkfd/kfd_device.c
> index fba9b9a258a5..52be4e340fb1 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_device.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_device.c
> @@ -924,7 +924,8 @@ void kgd2kfd_device_exit(struct kfd_dev *kfd)
>          kfree(kfd);
>   }
>
> -int kgd2kfd_pre_reset(struct kfd_dev *kfd)
> +int kgd2kfd_pre_reset(struct kfd_dev *kfd,
> +                     struct amdgpu_reset_context *reset_context)
>   {
>          struct kfd_node *node;
>          int i;
> @@ -934,7 +935,7 @@ int kgd2kfd_pre_reset(struct kfd_dev *kfd)
>
>          for (i = 0; i < kfd->num_nodes; i++) {
>                  node = kfd->nodes[i];
> -               kfd_smi_event_update_gpu_reset(node, false);
> +               kfd_smi_event_update_gpu_reset(node, false, reset_context);
>                  node->dqm->ops.pre_reset(node->dqm);
>          }
>
> @@ -974,7 +975,7 @@ int kgd2kfd_post_reset(struct kfd_dev *kfd)
>          for (i = 0; i < kfd->num_nodes; i++) {
>                  node = kfd->nodes[i];
>                  atomic_set(&node->sram_ecc_flag, 0);
> -               kfd_smi_event_update_gpu_reset(node, true);
> +               kfd_smi_event_update_gpu_reset(node, true, NULL);
>          }
>
>          return 0;
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
> index 485e26abc619..b6473110514f 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
> @@ -37,6 +37,7 @@
>   #include "amdgpu_amdkfd.h"
>   #include "mes_v11_api_def.h"
>   #include "kfd_debug.h"
> +#include "amdgpu_reset.h"
>
>   /* Size of the per-pipe EOP queue */
>   #define CIK_HPD_EOP_BYTES_LOG2 11
> @@ -246,6 +247,23 @@ static int add_queue_mes(struct device_queue_manager *dqm, struct queue *q,
>          r = adev->mes.funcs->add_hw_queue(&adev->mes, &queue_input);
>          amdgpu_mes_unlock(&adev->mes);
>          if (r) {
> +               struct amdgpu_reset_context *reset_context =
> +                               kzalloc(sizeof(struct amdgpu_reset_context),
> +                                       GFP_KERNEL);
> +
> +               if (!reset_context) {
> +                       pr_err("No memory to allocate reset context!\n");
> +               } else {
> +                       reset_context->method = AMD_RESET_METHOD_NONE;
> +                       reset_context->reset_req_dev = dqm->dev->adev;
> +                       clear_bit(AMDGPU_NEED_FULL_RESET,
> +                                 &reset_context->flags);
> +                       strscpy(reset_context->reset_cause, "MES_hang",
> +                               sizeof(reset_context->reset_cause));
> +                       dqm->dev->adev->kfd.reset_work.reset_context =
> +                                       (void *)reset_context;
> +               }
> +
>                  dev_err(adev->dev, "failed to add hardware queue to MES, doorbell=0x%x\n",
>                          q->properties.doorbell_off);
>                  dev_err(adev->dev, "MES might be in unrecoverable state, issue a GPU reset\n"); @@ -274,6 +292,23 @@ static int remove_queue_mes(struct device_queue_manager *dqm, struct queue *q,
>          amdgpu_mes_unlock(&adev->mes);
>
>          if (r) {
> +               struct amdgpu_reset_context *reset_context =
> +                               kzalloc(sizeof(struct amdgpu_reset_context),
> +                                       GFP_KERNEL);
> +
> +               if (!reset_context) {
> +                       pr_err("No memory to allocate reset context!\n");
> +               } else {
> +                       reset_context->method = AMD_RESET_METHOD_NONE;
> +                       reset_context->reset_req_dev = dqm->dev->adev;
> +                       clear_bit(AMDGPU_NEED_FULL_RESET,
> +                                 &reset_context->flags);
> +                       strscpy(reset_context->reset_cause, "MES_hang",
> +                               sizeof(reset_context->reset_cause));
> +                       dqm->dev->adev->kfd.reset_work.reset_context =
> +                                       (void *)reset_context;
> +               }
> +
>                  dev_err(adev->dev, "failed to remove hardware queue from MES, doorbell=0x%x\n",
>                          q->properties.doorbell_off);
>                  dev_err(adev->dev, "MES might be in unrecoverable state, issue a GPU reset\n"); @@ -1983,6 +2018,23 @@ static int unmap_queues_cpsch(struct device_queue_manager *dqm,
>          retval = amdkfd_fence_wait_timeout(dqm, KFD_FENCE_COMPLETED,
>                                             queue_preemption_timeout_ms);
>          if (retval) {
> +               struct amdgpu_reset_context *reset_context =
> +                               kzalloc(sizeof(struct amdgpu_reset_context),
> +                                       GFP_KERNEL);
> +
> +               if (!reset_context) {
> +                       pr_err("No memory to allocate reset context!\n");
> +               } else {
> +                       reset_context->method = AMD_RESET_METHOD_NONE;
> +                       reset_context->reset_req_dev = dqm->dev->adev;
> +                       clear_bit(AMDGPU_NEED_FULL_RESET,
> +                                 &reset_context->flags);
> +                       strscpy(reset_context->reset_cause, "HWS_hang",
> +                               sizeof(reset_context->reset_cause));
> +                       dqm->dev->adev->kfd.reset_work.reset_context =
> +                                       (void *)reset_context;
> +               }
> +
>                  dev_err(dev, "The cp might be in an unrecoverable state due to an unsuccessful queues preemption\n");
>                  kfd_hws_hang(dqm);
>                  return retval;
> @@ -1998,8 +2050,27 @@ static int unmap_queues_cpsch(struct device_queue_manager *dqm,
>           */
>          mqd_mgr = dqm->mqd_mgrs[KFD_MQD_TYPE_HIQ];
>          if (mqd_mgr->check_preemption_failed(mqd_mgr, dqm->packet_mgr.priv_queue->queue->mqd)) {
> +               struct amdgpu_reset_context *reset_context;
> +
>                  while (halt_if_hws_hang)
>                          schedule();
> +
> +               reset_context = kzalloc(sizeof(struct amdgpu_reset_context),
> +                                       GFP_KERNEL);
> +
> +               if (!reset_context) {
> +                       pr_err("No memory to allocate reset context!\n");
> +               } else {
> +                       reset_context->method = AMD_RESET_METHOD_NONE;
> +                       reset_context->reset_req_dev = dqm->dev->adev;
> +                       clear_bit(AMDGPU_NEED_FULL_RESET,
> +                                 &reset_context->flags);
> +                       strscpy(reset_context->reset_cause, "HWS_hang",
> +                               sizeof(reset_context->reset_cause));
> +                       dqm->dev->adev->kfd.reset_work.reset_context =
> +                                       (void *)reset_context;
> +               }
> +
>                  kfd_hws_hang(dqm);
>                  return -ETIME;
>          }
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_smi_events.c b/drivers/gpu/drm/amd/amdkfd/kfd_smi_events.c
> index 06ac835190f9..569a17be8387 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_smi_events.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_smi_events.c
> @@ -29,6 +29,7 @@
>   #include "amdgpu_vm.h"
>   #include "kfd_priv.h"
>   #include "kfd_smi_events.h"
> +#include "amdgpu_reset.h"
>
>   struct kfd_smi_client {
>          struct list_head list;
> @@ -215,7 +216,8 @@ static void kfd_smi_event_add(pid_t pid, struct kfd_node *dev,
>          add_event_to_kfifo(pid, dev, event, fifo_in, len);  }
>
> -void kfd_smi_event_update_gpu_reset(struct kfd_node *dev, bool post_reset)
> +void kfd_smi_event_update_gpu_reset(struct kfd_node *dev, bool post_reset,
> +                                   struct amdgpu_reset_context *reset_context)
>   {
>          unsigned int event;
>
> @@ -225,7 +227,14 @@ void kfd_smi_event_update_gpu_reset(struct kfd_node *dev, bool post_reset)
>                  event = KFD_SMI_EVENT_GPU_PRE_RESET;
>                  ++(dev->reset_seq_num);
>          }
> -       kfd_smi_event_add(0, dev, event, "%x\n", dev->reset_seq_num);
> +
> +       if (reset_context)
> +               kfd_smi_event_add(0, dev, event, "%x %s\n",
> +                                 dev->reset_seq_num,
> +                                 reset_context->reset_cause);
> +       else
> +               kfd_smi_event_add(0, dev, event, "%x\n",
> +                                 dev->reset_seq_num);
>   }
>
>   void kfd_smi_event_update_thermal_throttling(struct kfd_node *dev, diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_smi_events.h b/drivers/gpu/drm/amd/amdkfd/kfd_smi_events.h
> index fa95c2dfd587..85010b8307f8 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_smi_events.h
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_smi_events.h
> @@ -24,11 +24,14 @@
>   #ifndef KFD_SMI_EVENTS_H_INCLUDED
>   #define KFD_SMI_EVENTS_H_INCLUDED
>
> +struct amdgpu_reset_context;
> +
>   int kfd_smi_event_open(struct kfd_node *dev, uint32_t *fd);  void kfd_smi_event_update_vmfault(struct kfd_node *dev, uint16_t pasid);  void kfd_smi_event_update_thermal_throttling(struct kfd_node *dev,
>                                               uint64_t throttle_bitmask);
> -void kfd_smi_event_update_gpu_reset(struct kfd_node *dev, bool post_reset);
> +void kfd_smi_event_update_gpu_reset(struct kfd_node *dev, bool post_reset,
> +                                   struct amdgpu_reset_context *reset_context);
>   void kfd_smi_event_page_fault_start(struct kfd_node *node, pid_t pid,
>                                      unsigned long address, bool write_fault,
>                                      ktime_t ts);
> --
> 2.34.1
>

