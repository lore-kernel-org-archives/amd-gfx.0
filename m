Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 560E1C28B2F
	for <amd-gfx@archiver.kernel.org>; Tue, 18 Mar 2025 05:55:20 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BCCE010E1AC;
	Tue, 18 Mar 2025 05:55:19 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="TTsflnVl";
	dkim-atps=neutral
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2089.outbound.protection.outlook.com [40.107.237.89])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AB81010E1AC
 for <amd-gfx@lists.freedesktop.org>; Tue, 18 Mar 2025 05:55:08 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qGuXD+HetIBJaa1BunVFdxVyh/twGyGq+A0emEp3/pvSbdSLEpiWo0hoCuT/11XYXAueuGMpcUnQWC+LWOuOR6la07Rb2iaxh3QQFxy2OORWLi8b09s/t+VttAo9o8SqGYMNrBCUYQ0z4R/mY7XdXWFNWBFBL2fm3aBornTMDV6W0ZKk6IR2VsctfiSc/6+Zym23kAM/4l+hz9+W838+GtYij40vr9xq4eyaWaoK+rJ0bElBDvBEtDXJBFsTv17/NZFBsI32MUb5BZ80YxGnv55dMk7cq7OvurUwHwTQWOxOieTKrUcFCMKEMfHJL7DbMyRng4IiQ/qEJTzXV/C6yA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=R9h/xN8s7GDFcrOXslycQyxWbddTc2d4jCXP7d4rTWk=;
 b=a98FNR30zWNKXXCpPxA4rZ8r4UUdG0Qh+yGdtKDPS+S9jMyFzBH46/LOTdDB8FToqcM/r8hnfzgne7oCBgrHeWlhJHvb8tvi4p/O0KMEGEUh8QN4AMEMZew4SaUZTrT8KZefnlowanLL3zDZ+8tRNmEEI0R2R33c4gzZ/dUhv0E3jcP2pNON89FQGbLX2j4Q+Tdcbxfv9EILIy0d1je4I22lzGiRu9kUjXRNLn4MBfxcywRnTAwZi/awM9P42xY5X0X7YFACHV+/ej7Vb3mKQg6Lb59t13DTfXECKehREStSfOmh6QSAd7LL28hY/MaReDENSFkR8Y3xvMfk0E9lgQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=R9h/xN8s7GDFcrOXslycQyxWbddTc2d4jCXP7d4rTWk=;
 b=TTsflnVlvtBSw63hRhatqjhHjTEPFBFNYL2SPEAf9TwIEqKtmjpREZJ9CUPXGeplMMG8WoQlpCreusR+lqpj5e4ki1hOTkwn/O0qYRLAB+NrKOHK9gjYSluknCl+xhlvk+vgr7X0ipyoGJVwJ1hqKsqEcbnwPjIqLW7HlrY0d3c=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS0PR12MB7804.namprd12.prod.outlook.com (2603:10b6:8:142::5) by
 DS0PR12MB7875.namprd12.prod.outlook.com (2603:10b6:8:14d::7) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8534.33; Tue, 18 Mar 2025 05:39:25 +0000
Received: from DS0PR12MB7804.namprd12.prod.outlook.com
 ([fe80::8327:d71a:ce21:a290]) by DS0PR12MB7804.namprd12.prod.outlook.com
 ([fe80::8327:d71a:ce21:a290%5]) with mapi id 15.20.8534.031; Tue, 18 Mar 2025
 05:39:25 +0000
Message-ID: <fabb82b7-7674-479d-a18f-41b243f95e51@amd.com>
Date: Tue, 18 Mar 2025 11:09:19 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amdgpu/sdam: Skip SDMA queue reset for SRIOV
To: Ahmad Rehman <Ahmad.Rehman@amd.com>, amd-gfx@lists.freedesktop.org
Cc: Vignesh.Chander@amd.com
References: <20250318034933.115123-1-Ahmad.Rehman@amd.com>
Content-Language: en-US
From: "Lazar, Lijo" <lijo.lazar@amd.com>
In-Reply-To: <20250318034933.115123-1-Ahmad.Rehman@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN3PR01CA0038.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:98::6) To DS0PR12MB7804.namprd12.prod.outlook.com
 (2603:10b6:8:142::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB7804:EE_|DS0PR12MB7875:EE_
X-MS-Office365-Filtering-Correlation-Id: 5b1c3e22-5c88-4603-22ac-08dd65df3e54
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?elNRaC9xOWdERUZWRDNpK05pbjhjc3lMbkJ2dDBoME96ZWluUSs1OTd1eXpU?=
 =?utf-8?B?eTNMcUhXZWgraHBvUS8vZkRvTVBLRG4wVm9ncm9NN2w5L0hTNWs4Vjd2VFY0?=
 =?utf-8?B?TXFwOGdHTG0rZTNqUS80YmhjNE9qUFNjTXYrWlloRWtEb1BzYTRVc0FwejNL?=
 =?utf-8?B?dW1zc1Q3cTgyOGhTWUQ0Sktjc0VENVVOWXN0UnF1S1NKRmpFZ1lQNzV0Y0ZH?=
 =?utf-8?B?bE1vSU9vUUU3S0tYaHBMNU9JblJuOWtlWHV3VzkrdkV6QTNEVlduNS9zdE1k?=
 =?utf-8?B?OUV1bnI5UHlqVXloWkJSampmZksxZnNCU3NzK2YwZTYwVzcvYTNGV3BWVUNH?=
 =?utf-8?B?TVI2MEh1NGNkT3RqMVRtRGtCTVlsRE5UMDM0YVc2S05tamZ2WmxXWVJLOVMy?=
 =?utf-8?B?YnZxazNkS29NTnkyRnc3bGlIajdnTUdVU0xMNmRpZUdRUXdLRFgzMUdJQW84?=
 =?utf-8?B?RDJIeDZsREwyY1ZSMlZDUVFZQThiWjQxeE1JdmxiTW02ZUlLR1lvTGVtR1hZ?=
 =?utf-8?B?QW1jQTJVb1pqcmE0ZTRzdGhoRmJMbmptZkdWWmZXUGMxaDRNZ2RETytBMlA2?=
 =?utf-8?B?b1djUHpvRWNlS3MySStlTzg3UndlM01pVEZHT21MMEFMTHNwWjdkWHltamlE?=
 =?utf-8?B?Z1hVRTZoNnV2bHFMRWRsSUZWbmhaTXZYQ2RDeW5vRmdlNDNaMmZWNmJrbDJH?=
 =?utf-8?B?MG1hVDhHQ2Q4ZThDeUlkVU5BM1RKcFVoWFBURjdSYUhoajU3eVdVMlZLZzEz?=
 =?utf-8?B?bkcxTHBSTk5vcGFHVWsxOGFnNmN4N0tNeEJ2azBCbUdaYms3eTJ5UTZlcXRn?=
 =?utf-8?B?YkJXRzAvbkx6eWQ5VlU0WFpiRHBPZDNleEl5TVk2Z1FlY0gwOVFtZmhYYXBu?=
 =?utf-8?B?RFNvNkJmcTdZVTB0MGRjc3g1eHJjQnZ2cGF2d1JOM01TNnlOZWgxYS82NXlN?=
 =?utf-8?B?ZnZHRVpRUU9GbGVJNzNSdlAycjl0NDRRMUsxOVdkeVk2WW5SNTdlOE5GKzdl?=
 =?utf-8?B?dlNISlQ2c1FVR1dFK2FxVEozdjVtTFJVcDZjSU9YODZhU3orcHRmTUN5Y0dQ?=
 =?utf-8?B?Z0RlTEhuSVhMWElpM3M5eUZ5c2hlbHdHajdHS3ZiSnV2endzeXhPYlJkMU9H?=
 =?utf-8?B?ck1LV2V6TkRmZzhlS2hhWXZiTVNLQzJoMzA4U21qV2lMZldhQnZ1NUZOdzhx?=
 =?utf-8?B?N21xVENoVGZzMmVkR3BNUUpueVNOTzdwbDk5WkZXOEJBVHNmUk1Dalo2ZnQr?=
 =?utf-8?B?RDEwdzR4MG14bEtvZjhLcllOK1hTeWQyeHRqdzZ4eExCYms2VmF5dEh2R2Jn?=
 =?utf-8?B?QlBRV2pHMzVRL0cvVlQ0aVlFSDZNd0dKWTFsTFRxd0t0b0xGa0NMdjQ3Mm5R?=
 =?utf-8?B?VmVmczFiam5vY0FPaDVJc3JkWnFuRGJsQjVsTTlpNWV1UGpDZjB0czRRaGlw?=
 =?utf-8?B?SjdQVWNOakxpRHNIWjJ2M1BEWTVtWndhTjY2M2JONmdVb09tMzNLRlVaTXUx?=
 =?utf-8?B?N0hUTjNRRUgycEdnUGhSODdld1FZQ01UcmlQaHB3SlgzNUNLZFBXMlN4YmRR?=
 =?utf-8?B?UXpLVGtMOUhhdGFPQ2xteWFPbk0raGR3aFZKNFh1MTFIejNoaGw4TjdkRWY4?=
 =?utf-8?B?NVoxM21IbllEa25tOUJoVTlHWkN3dS9KbU5TYVEwUGg0T2tPUVd1WVgycElv?=
 =?utf-8?B?cmIyMVliL1VNL1Rmd1Bla1JpaGRJODErR3dpOUEzLzJrVEFZa1VWb21mMjFE?=
 =?utf-8?B?ZFNUMnI0cHRZYTVEQnJDYVhTSk1TMmg0dzlGWjhhYTYyWmdwNTI1ZFdycUdZ?=
 =?utf-8?B?QnpSUzRLaGwwRzdxbldPOS81T0xnSGllcC9Nd1pSQ0VRZklhRnJxRmpodXVC?=
 =?utf-8?Q?7w54uRLjFkOrk?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR12MB7804.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bHVWa1VXOUs1YXArTnpsNDFiZ2kvQXBWVTd4WDM0Sm1aN0ZUL2k2d0JrT1lL?=
 =?utf-8?B?Ry85SE40Y1VwVnlqWmlYU3UyMzJ3TFppU1V3MnFTaTNNcXM0Qm9YQVZ3dFZi?=
 =?utf-8?B?UE1kb3BuZXczTHJITnVaNURxc3d6eGcvL3VGRk02SWlpRlJSaU94Ri94akNt?=
 =?utf-8?B?MzdYdThGMnZMRlgxbU5TY1JFNVprRFdIWmI1TzFCUHFDK3BGQ29OR0Vubnh2?=
 =?utf-8?B?NXlaOWo5TEhZa1RpZnMrVnhSN2xIUnI5cmh1c3Q4b1ZYa2JlNk02UUxPYi9M?=
 =?utf-8?B?NnEreGlSMW1vOE5GNlpldkg2UWdmeEFEMEdaUWl6Y1ZvYm4xMlBJY2JOeUxh?=
 =?utf-8?B?Sm5SSXk5cFhCeGFTNk5LSXJrWmEwUVBOdENJTnVyUCt0ektjZ05MMTV4M0FC?=
 =?utf-8?B?WWVmWS9HOGdXM1ZkSW9VSzhYZDdJRXk1UEtSYittcThHYjJpNmVuN2xBMlU3?=
 =?utf-8?B?OEdYT200aFJlTEVVcWRrYWhBVmxEd084dytOb21WMTBsZ2tYYWVLRldPYzNs?=
 =?utf-8?B?ZHRqSGNDM2dsNkRTajhUdlZkQ1NsMytFVzQrT2N2ZDAzM0d0MkZ4NWI2cDVH?=
 =?utf-8?B?anJpSjFmZzI5c2Y4OE5tN2JuNFdrL2U0NkFjdWJkeVp1cXlXMFd5WTBQck54?=
 =?utf-8?B?Y3MzL2JVY2dwRXppS0hsU09SNTB5eG55YWVVRmFjR2lWRTNJckJjVGhvU3pL?=
 =?utf-8?B?QlNucmlmR3pMSFFvUmZrMmtDUHFZTmV5Q1YvRncwN3ArVFlsYzJUdVJhd0lj?=
 =?utf-8?B?S24yTk10dnRoLzN3TXZYYmlZMUdTV29KWGtOVWZndnBxZFQxVGY4eGFEMXRQ?=
 =?utf-8?B?QU1wMGhwV2NWeGRnZHpLT3M4RE5PdHdGZW5lRDRQd3R4WmZvd2ZTM05xajcx?=
 =?utf-8?B?Y09iSXVMNUFZanJyRDhUd0lLSUxoWVdldVkvUEFlei9yZHRNZDZzUytFc0dl?=
 =?utf-8?B?TjcyWnpqcjI1R0RyK0lpaG94RnZEK0F1Ung5V05Kd3VVa1Rzc2J1aFk2M0o5?=
 =?utf-8?B?ZC9NcC92VUNoR2x2TUxQVmZLUThZNWhkMkplL3JPY2RuQXdaZmdwaXFJOGw3?=
 =?utf-8?B?K2tTbjlFSk9qLzFFbnRKTkE1dERBS0U4Z0gzand1SzJ5OHVKdGRidFZIak9X?=
 =?utf-8?B?LzFiWU9sV2NoNFJobWJKODd5eTBhM1o5NUpJd2plYThvU1ZUazh6SnJveE1C?=
 =?utf-8?B?azhpbUgzUk9ZL3huMjlDdkszK1dTcmtOeC9xOXVvRXJxcnpVSU84aHQyQWFK?=
 =?utf-8?B?eGg0N1dmTnB3UXozLzF0TXg0MUovZWxtU0cxNjJpNFpKUlZSancrTmtXeWxR?=
 =?utf-8?B?YzlINis5WWEyUW4zL084QjV5Y0xweTBlVk1kZTJUUThoUHZhYi9BUld3aGND?=
 =?utf-8?B?YkloblRLUUN2N3JZYlBpNmlLdGdsbUNGN05SR1h5MlE5SzA5S0JRaHJGTEM4?=
 =?utf-8?B?em5TeklRR2Ftdnc2UFI4VE9oNm43czRYRTBPQjZ1Vy9TWVJXaS83Vm5kYytt?=
 =?utf-8?B?cnpQT0JXbzd6WnhmRklTb2VGN2d2QUVTMFc3QjQyNmRqMnlOa2NhcHc4dmdT?=
 =?utf-8?B?TFdQMGo1Rm1nUTYvYjlMQnRNczdySjdBSFRUUlh0S2VPNEJ3RmV0Vk0rbVp6?=
 =?utf-8?B?NE1CQmJab2xLaDd4MzJHeDhOTlpSVzUrSE4vSUlrWHJUcHVFcU14S0U2Nzkz?=
 =?utf-8?B?ak9QTUtZaWsyRjVnR2JwQWFXMS9KMHlRMnU2aUdVbEVXeFNhcUZHcVhtNXVm?=
 =?utf-8?B?K0xSTEsxVFBaV25XK2M1bmpDc2dDT1BBSHJKa0NnbzJqYkEzR0gzb0tOSHZ4?=
 =?utf-8?B?OThvRGZ0SFhKWEM3clFib1U4VHNlaTQrYzZSQW5WVmJOM2tEVjdCZWlvR0wx?=
 =?utf-8?B?L1psU29iT1pNTHZlS3hYS2hiS3pOalJvZ2xTV1Z1NThFWkZqclBEdEU3ZW4y?=
 =?utf-8?B?aVdQZ1hFeFArMStSVzhHd0xGakVmazBMNTd0OHpHYVZqRnJEK2IyZVJXZUti?=
 =?utf-8?B?dkhxUk44N0Rpc2czd1JaMjlid3JWbGpMMmFIMEduUDl3bGJFSnhobFNZV09P?=
 =?utf-8?B?Z2plZ2c3NjlWcndZNTNSK0JRS1k2eldFVjlXeGJwODg5clhkQ3Q0dTNod1U3?=
 =?utf-8?Q?ZClMxDUhWoLhxOsDB7aDlE9fO?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5b1c3e22-5c88-4603-22ac-08dd65df3e54
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB7804.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Mar 2025 05:39:25.5837 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gT+wFgNcaVSfCvs7cfJ57PfOJo+3tBVlDU2WtN4R8acCJXkApa9qcmGvHBClSZ9j
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7875
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



On 3/18/2025 9:19 AM, Ahmad Rehman wrote:
> For SRIOV, skip the SDMA queue reset and return
> error. The engine/queue reset failure will trigger
> FLR in the sequence.
> 
> Signed-off-by: Ahmad Rehman <Ahmad.Rehman@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c b/drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c
> index fd34dc138081..5b2d4ca92c17 100644
> --- a/drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c
> +++ b/drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c
> @@ -1666,6 +1666,11 @@ static int sdma_v4_4_2_reset_queue(struct amdgpu_ring *ring, unsigned int vmid)
>  {
>  	struct amdgpu_device *adev = ring->adev;
>  	u32 id = GET_INST(SDMA0, ring->me);
> +
> +	/* Return error for SRIOV will result in FLR */
> +	if (amdgpu_sriov_vf(adev))
> +		return -EINVAL;

Prefer something like below -

if (!(adev->sdma.supported_reset & AMDGPU_RESET_TYPE_PER_QUEUE))
	return -EOPNOTSUPP;

Then keep the supported_reset mask updated for VF in
sdma_v4_4_2_update_reset_mask() => if (amdgpu_sriov_vf(adev)) return; //
do nothing.

Thanks,
Lijo

> +
>  	return amdgpu_sdma_reset_engine(adev, id, true);
>  }
>  

