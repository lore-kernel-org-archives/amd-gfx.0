Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8557CC25B74
	for <amd-gfx@archiver.kernel.org>; Tue, 21 May 2024 18:37:53 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C073410E164;
	Tue, 21 May 2024 18:37:52 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="XtJHHOdG";
	dkim-atps=neutral
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2068.outbound.protection.outlook.com [40.107.236.68])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3251510E164
 for <amd-gfx@lists.freedesktop.org>; Tue, 21 May 2024 18:37:49 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aLYz0mhxsI3IRosMGgk0Obp8t6V8i5JQkmYyA12zXLc8f3ptHgLMmxM4gACoyM970ehV95oZUwzW3nofMVaK/2w1DpA+MxYdIZIDkd9aowlR1F9YEUiz3v79fzg8v1lnrqgTZ19u2L5B3oh4N6S4agl3La9FNbvjAstg4FUHJxSbJhlp3ErMkzzR7jB1SQQCC/aXWzqxhE59FeV8OTX63lxDFvCTe1FTU08OYrKNg07xagNiNATmtNL1PCfjaZLNPddO47Q5M/KLcPthggUjG+08R++1pPv/Ou2pormSIdA+gM0ocXw7MIEU3zBrVRvtd9vflD6pqp37QbXLM05fgQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EB0sXmtni9l5bIOOzwLSsVO9YSAso5G6QQyrlrTWXSk=;
 b=GAZD8rqW7s/6RWFXWfvJPdOTy50oP5rpqadWyQtoZe3Bb84x6nmAaNUoJcWzn7TTc6MxJv06hoHoonjS2ZzkZibDFTebF7hhtNnYhROuXp8UoefPX6NenwyxyPnFgBDCTt0wPhCMeHcqj7dQEBw/h05BD9IYvYhmVhMNySqVYJrPUwC9nm9bzy0VGa3UhBabrUbfgZQVykz8tspWF7KJTLIo8C8oDSJCffOrh4s3T1tqdjuT7I8n+S/nWdjRolJ8P4IQPx2b9lGCdG5Y9kDVcl1yjGQ5NGI93LcMufYT/uo1r4lTFNiUl5/wD04ugWElhHj4mgcSgBdgRQH8oE14iw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EB0sXmtni9l5bIOOzwLSsVO9YSAso5G6QQyrlrTWXSk=;
 b=XtJHHOdGDFv9MRUZqvz2xgYD1VkrTKQTpm7fkXDOV7z1TZaYT0X/Nr6KQvdrlIQf54giO+zvFeuptqQLihLGCBjMyB80PHPG1Gc9TCalpajLvei5Nj4nBFYXBZ71mjHc4vDOT/12cw33WxEPgfROp3nMJwfuv2f38UV2hGnDiGE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by CY5PR12MB6528.namprd12.prod.outlook.com (2603:10b6:930:43::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7587.30; Tue, 21 May
 2024 18:37:44 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5%2]) with mapi id 15.20.7587.030; Tue, 21 May 2024
 18:37:44 +0000
Message-ID: <c872f8db-261e-4640-9527-9b8f88f295a5@amd.com>
Date: Tue, 21 May 2024 20:37:39 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amdgpu: Fix amdgpu_vm_is_bo_always_valid kerneldoc
To: Tvrtko Ursulin <tursulin@igalia.com>, amd-gfx@lists.freedesktop.org
Cc: kernel-dev@igalia.com, Tvrtko Ursulin <tvrtko.ursulin@igalia.com>,
 Stephen Rothwell <sfr@canb.auug.org.au>,
 Alex Deucher <alexander.deucher@amd.com>
References: <20240520081814.8363-1-tursulin@igalia.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20240520081814.8363-1-tursulin@igalia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR4P281CA0042.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:c7::12) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|CY5PR12MB6528:EE_
X-MS-Office365-Filtering-Correlation-Id: 56f8b358-0d99-469d-067b-08dc79c51a79
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|366007|1800799015|376005;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?U1YzeWwxNlk5VVhWR2U2QjluUHByMnp6alJ5ZTgyUW45NHRtS2xRcllOelVr?=
 =?utf-8?B?YzhGRklGbEhjeUs3bStrTXdiUFpVOTFlaC9SeEZzd09ZVTNvNUJRZll3RWdT?=
 =?utf-8?B?RHZ2S3pGc1NlWU1jQzBEZzJ6dThNK0NpeGU1Q01nT1hRUnBTdGR3aGtrai94?=
 =?utf-8?B?NWowR0VkMmpMbG5ZNmpNMDdmTjlQUXBiTHBKbktucGNXZTZ3cVpqY2h0N09T?=
 =?utf-8?B?U1NTSVpCRGNxWlBjMGk4My9EaHduTXdaS21PaUFZMFU4MjhzM29MS2FlaUNh?=
 =?utf-8?B?eXk3VnJSSjVTRHhMdkx4clRuV2ZOMy90anhidFAvaXdxc2dDVlNzTldTUDhI?=
 =?utf-8?B?ckdZOUVmdERmM0ZsN0xEUG9xUFZqQ0c4Ky9UUFRSVjluV3BOOVpEOU42bG83?=
 =?utf-8?B?dUhhdzAwN1kyaGNFR3BxZ1laSUlWMWd0dzl1cWc1aHNOMFd1eVBIaHdtZXcz?=
 =?utf-8?B?VVZ2TCtoS0QyQXBhbURmMEx4N2xpQnl5OFFId1B1YXhNcm5mVyttQlpTUkto?=
 =?utf-8?B?V3dPS3BlQ0tNYWlWVGpReDdCQ0x3VSs0ZEFla1kwenVpVUhSWEJONnpXbXpv?=
 =?utf-8?B?ak5ZQjhUU2ppQWNWTVR6SVFFUlpjV1hhVWFydS93TU9teWhEZEE0VHBzWm1Q?=
 =?utf-8?B?bURiZXNFTWdyUFAyUzFnRlNNbDQ4MUhqT0RubmdUZnpCUGZ6Q2pjeEtDalVL?=
 =?utf-8?B?ZXBTNUxvS3h3L0NNOFlPcnoxQ3ZlZ1lGMDkwbkNMK1lTcjJtZFVhSzdsUjls?=
 =?utf-8?B?UUoxR3dlUFJ6dnpURklDck43aHBMYXcxNVNFRjl0VEI0dVlmYk84eUFFQ1kv?=
 =?utf-8?B?RlJmVGRRdjhubFA2RUNUbjNHdGtXalUyQS95QTVDeG9PZE4rQm01eEJMZDRk?=
 =?utf-8?B?L2QvOE5GTGFNWDVOQ2pVOGpLdWEweXJRd241dWxlaS9BN0FtV0Nidm1tbllj?=
 =?utf-8?B?RXB2azJnZnRGV1FFbXJzZFU4RzZQTU9xUXllR3lSdHJNOWtyb3lIQ0R0YmY2?=
 =?utf-8?B?cldkMUxzWUFHdGpuWHBBM1V3QTl3WW1MaW5HREZNM2VaaWVjdzhqOUsrelVB?=
 =?utf-8?B?SzVCcWhTbWhvcm9EWVMzRXd6TW0yRk5hUzMzaE5zNzVoc2VCejdwTE9HVmdQ?=
 =?utf-8?B?UE9XYTNLdDhVU3puT1NuRW50dUZJQnpyMnZzNTRFdGVyTmtBUEExY3ZzSXlj?=
 =?utf-8?B?YThjQU1aK1FTaDJBWnFpVHpSQ0JwbnptdnVBeXF6K2VVWVBlQ2o5Tmh3cDg5?=
 =?utf-8?B?ZE1YdU9kNWlEU0o1eTIzNk5EMXBBYnc3UTZBTUt6MlBpSmdub1JpMHdwYXRS?=
 =?utf-8?B?NTAzdEo4c0tjZnNJOWtxeDYvLzlvY0Nldk1lY2JGSDQ2MHc0dE9FeWkwaHdW?=
 =?utf-8?B?eUJ2cGlPZzUyZnJ3Z3Y0NU42UnduT21XY3BvdGpJRzRaSmNGblVyMjcrdlIv?=
 =?utf-8?B?ZGhOV0pyM2JNS1FaT2ZvL1E0OUd0bHhXTFd2ZDUwRnR1QXJ1YUdoMWFPKzRw?=
 =?utf-8?B?S3l6QlNSbHo3QmVBOTVUMkEyd2R4bXpiNEQ4SUdjbXNjNExYbFo5SUtyR0xR?=
 =?utf-8?B?RStSdERQZTVXM0NSWm9DUHJFaHdzZ3Y5aXVBK1VBUEdZaHNmMUdVYXM0UnEx?=
 =?utf-8?B?bEhDckZqR3lJRnhqZ2FmaTF2RnZNRElhZUxralh0ZjNHYzMvSXEwaXdpbE4x?=
 =?utf-8?B?SDFZeEZ4WGdvVjdOeTNad3NJbHNZVlVBL2VZRHNva2NsRmRINGRBYUF3PT0=?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(366007)(1800799015)(376005); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?eWs3TEh3VFFLeHIra283TW9NRmw0aENySXlEMjI3MXZqS2FMMCsvM3JjZWF1?=
 =?utf-8?B?UmkyQTRVZmJyMGpLay9qK1RqeTVxZTVZVnV3Tmg4VWFRaVhUbWordjMyUHJG?=
 =?utf-8?B?VVM0NDRkbXFFWm83dzRscEtjT2VCNUpWL29IZ1Q1TnZpWW1lb2FyWCs3aTBR?=
 =?utf-8?B?SHNYT21CUXpKdWFSSzdxa0FRTlhhcm1UY09YRUtPT05YcVR1L3p1OHZBdEds?=
 =?utf-8?B?bEpDS08yWVRRMGxqWDFkMDd2c0E0VWwwaVM1cE1hRHlrRmF3RVlISzkvY29P?=
 =?utf-8?B?WFRsaGRlczFXUzkya3NlZnNaY0RKTE1yK3VTa29WTjd5dUZFd09jOUdPZ2Zz?=
 =?utf-8?B?WXQ1d2p4TElZVGUzUkw0OHkxZm52RjB5ZFkwODZoOVgwUXNVci9OQVRaWGM3?=
 =?utf-8?B?cG12eWpabW5uZDU5Qk80aWFOditXcVZnSkdlTHppanE0bGFiYzlSN21rM1h6?=
 =?utf-8?B?RDJkcWVka29GZk9pWGNvNUE1YUFNUTJIYzZuM2hIZGFjaWVBVmx6Y1J5QzQz?=
 =?utf-8?B?by81Z0dGMkNzWExGQU5FVDdWL1lUNHFlR3hkWjVvNWQ2MW5GaFZXZEpsQS9P?=
 =?utf-8?B?K3k0OUNEY1huYVo1cUNibVVCdTZpWVBZQWM5MkMxK3MzdERtdTd1UHJnbU4y?=
 =?utf-8?B?YkV2ejZTTTlvM1pPeVdjT1hoZ21RcDBvSHhtOU5kbDJNU3NXMXRUMzlhYzdp?=
 =?utf-8?B?QmZBcVJVdEFuNm5vUUdQSTU0VDZveWtVNmZwVXpXTFMxRjRjM2ZickRqclBJ?=
 =?utf-8?B?MU12OHJSRnRqRU9YWlhzUGRFb0lYMi8rK3kzbi9Ea2FpUkVzd1daOWQ4SmJG?=
 =?utf-8?B?c1RObjVKdEtaSlh6QXZMVk02UHY2UlNQcERFK1Fxay80dzVwczc3SGNaejZ4?=
 =?utf-8?B?eWMwUWRqUDBzRlNWSGVOMWl0VDdycUlBUHZ2a3ZDcXU1K3lnRFFZRUtiWVA1?=
 =?utf-8?B?SkdJMm9TRG1VT2V6UG53ZkRwRFljV1JNRkJmWjh4ZkFUT1VFK3N5Q1A4V3NH?=
 =?utf-8?B?QjJBQi9KZEtqTklqNVc1S2p0UmxoMUNnV3ZvZ2IyeVJWczVxSVBmTUl5emlV?=
 =?utf-8?B?aGFKQ2N1Z25QL1ZFZHZkbENqdW9RdVVUc0NCa0xRbU1iUmhiRW9tRXMvUFM3?=
 =?utf-8?B?ejdMMDFnVjhESllHQ2xnQ1hiQlhjQVVUUVRJOEVWS3d2Skp0MkI0TFQ5SWpa?=
 =?utf-8?B?bTA4aXRmaG9CWmFkTUNicTFrcUdQK2k4UzdJdW5objBaOUJVU1JkYXZhSE03?=
 =?utf-8?B?VW5IeitVN3hvNGsyUi9oQkNDRkx4REltZTBkQzZCcEdmcXdGWnBuTWZoUDF0?=
 =?utf-8?B?Wm1yeXdFWlVZOGpUR2JUQi91M0FBTGNyTEFweEFMOW1JTk5kRWovZEhmTkhj?=
 =?utf-8?B?RUpNWDBESkJETGw4N2JPR0ZPUVhzQzZxZkFzeHFBdEZ0SG1OVXpBQjlYbVpu?=
 =?utf-8?B?eHdYQW5sV2NFRytoTnZhUnF1NVptOXNtYUVtWnpjb1c2REFQcHlkQUtyYXVs?=
 =?utf-8?B?Wks0MEZYaDNZdEF4M1c3TzgxZ1NGalo1dG9BcHdyZllFaUhxRWlUNFZqd2RT?=
 =?utf-8?B?Um5TcXBDeWk4aFBhMUw2dllGSTZzczVJZnBBVTN4ZWF2aTl6bFlOYUxUUUJF?=
 =?utf-8?B?Q2VWQ2gycHNZakovVG5ZMjdRTkczQ0t1cENRTk9OSnBvTDc2SnFQbjRzSzM1?=
 =?utf-8?B?VXlUVk8rRTJUL2xJdFpFc1J5MVA0NEI0UzRqQXF3SnlpL3laWVZXR1pSUGZx?=
 =?utf-8?B?cU10ZkhZOGRnbitiTlRVb2NqN0VNeHVQT1dNODByR1RnaitnclpsUFNGTmI0?=
 =?utf-8?B?V05lUFBTZGN1WG5pb2JCNHFBem1SQUpYNTJKNm1xbkIvcmg4eVAvMFI1MXpk?=
 =?utf-8?B?S1dDN0VzMzJjaEY3ejgydVlWN0gyRkxCcGlUZ3AzZUs3VWhtZEpKaDFic1RQ?=
 =?utf-8?B?bVVBUHgyMU1Eb0ZBVFVIaTJuTXBtaUxScUxDR2ZrS3RZZ2dYVit2amp2OXZl?=
 =?utf-8?B?L2RtSEhOMW1YNEdlNjJvQUo5ZW9kVERxT2tOdDlOQWQzb1lpTXRqZkVVdTBB?=
 =?utf-8?B?c1ZpU0w2a3ZtUHVkVklkQ1lLQmpTSktvaEtWSXg3di9TNVFLRkt4NXJ1QkZr?=
 =?utf-8?Q?6Lp1XzbQEsS58OwKlNV8idvZ/?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 56f8b358-0d99-469d-067b-08dc79c51a79
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 May 2024 18:37:44.2012 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 63BKhsGxRDU5QDn9MK3cJpVJyz7IwPv1H+YJ6BVoBIRlh7TCYdoUQlj0WN8y27aD
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6528
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

Am 20.05.24 um 10:18 schrieb Tvrtko Ursulin:
> From: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
>
> Align kerneldoc with the function argument name.
>
> Signed-off-by: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
> Reported-by: Stephen Rothwell <sfr@canb.auug.org.au>
> Fixes: 26e20235ce00 ("drm/amdgpu: Add amdgpu_bo_is_vm_bo helper")
> Cc: Christian König <christian.koenig@amd.com>
> Cc: Alex Deucher <alexander.deucher@amd.com>

Reviewed-by: Christian König <christian.koenig@amd.com>

> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> index b9cca51356b1..3abfa66d72a2 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> @@ -3008,7 +3008,7 @@ void amdgpu_vm_update_fault_cache(struct amdgpu_device *adev,
>    * amdgpu_vm_is_bo_always_valid - check if the BO is VM always valid
>    *
>    * @vm: VM to test against.
> - * @abo: BO to be tested.
> + * @bo: BO to be tested.
>    *
>    * Returns true if the BO shares the dma_resv object with the root PD and is
>    * always guaranteed to be valid inside the VM.

