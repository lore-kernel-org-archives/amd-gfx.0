Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1B4F8C282EC
	for <amd-gfx@archiver.kernel.org>; Mon, 17 Mar 2025 03:54:42 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F011610E2C3;
	Mon, 17 Mar 2025 03:54:32 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="UP4TlSKi";
	dkim-atps=neutral
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2069.outbound.protection.outlook.com [40.107.93.69])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E5F3E10E2C3
 for <amd-gfx@lists.freedesktop.org>; Mon, 17 Mar 2025 03:54:29 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TPK6nBjY7GjBEg8jMfGGDaI0YXlJLnMCg+IK/ufD6cQqADhW/XL3PTudkzDj83jrsfuZeQVRRqLzXDA5M/LpJAVLiKaCjDeEb+lqMYLkebSm9ERQbdYCYadZ1YoJXqC41KsbKM4fJftuz92LK6WMN6p0e0DFkuC2hntx5dbPzGZAnuGGXkXkeMWylm8y0yCvDNMYRNnZhAEATY3DF3nRLNIrbpW7rL+AiCpeop+1x/Mfvc3POHGN9Q9yg1Mk22fq6+upR1vBEisVKgbqxhyBjcgovamxdBky0fY4pUb612msTiyVSqzBxqUjwfJgVTMfzERc58TtVmaJ9SWjhzGQkg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AFvlikFr50BFi5mNWeGBE62rZYJVcMP8UnWbcDz7V00=;
 b=N/+P2j9a3RN0rZfm1geUXntqLi1H1KqLl+Ay87qbwRHqpzUVfzQWVDa3XbIks8NeQW842CmNC4Rp+2iyeaCOfcyxVRewCTUC1XoX/VrqihirPJoihyXjN52gIN8Q3+5N0+LVskPUlswu0EFJyMmiQ6jIVbkfL+9JCDo/woDNxk3imaMlGp+z4utw1XNaStxIZ3blPM/73Vm//rOyuCJ1qTNLPqSZL64LWxIpFHlWbjGFPZizrgNcsyO7gwBfl1M6fs5Hv/vHt/trv02o9B9W1SBpECtl2eGPYXDS1sMUJsq9zJod8y0G0/r4swA/j/zmY3WyINMJXu+C810MTLXeVQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AFvlikFr50BFi5mNWeGBE62rZYJVcMP8UnWbcDz7V00=;
 b=UP4TlSKiTaZJF3UIxi0hLcKvW3wIIBzZuIx45p3tOQxidWAClzxFo3dhJ+iGzQkThkn2kH3N9/ImwmY97e+4xDM+uUnfHIbXwOPJrWAisOv/pLhMvvirQVVuB2eBk/QMNn6oqvE26zb6J7a9Lkx/V1K+oe5g9MJ0vo4GGLdU/5g=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS0PR12MB7804.namprd12.prod.outlook.com (2603:10b6:8:142::5) by
 SN7PR12MB7202.namprd12.prod.outlook.com (2603:10b6:806:2a9::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.33; Mon, 17 Mar
 2025 03:54:15 +0000
Received: from DS0PR12MB7804.namprd12.prod.outlook.com
 ([fe80::8327:d71a:ce21:a290]) by DS0PR12MB7804.namprd12.prod.outlook.com
 ([fe80::8327:d71a:ce21:a290%5]) with mapi id 15.20.8534.031; Mon, 17 Mar 2025
 03:54:14 +0000
Message-ID: <2d850109-cd8d-45ed-97eb-44858a84209b@amd.com>
Date: Mon, 17 Mar 2025 09:24:08 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amdgpu: release xcp_mgr on exit
To: Flora Cui <flora.cui@amd.com>, amd-gfx@lists.freedesktop.org
References: <20250317023325.99537-1-flora.cui@amd.com>
Content-Language: en-US
From: "Lazar, Lijo" <lijo.lazar@amd.com>
In-Reply-To: <20250317023325.99537-1-flora.cui@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN2PR01CA0234.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:eb::6) To DS0PR12MB7804.namprd12.prod.outlook.com
 (2603:10b6:8:142::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB7804:EE_|SN7PR12MB7202:EE_
X-MS-Office365-Filtering-Correlation-Id: be314a6e-a8a1-4470-9735-08dd65076213
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?dytPWlRsaElLQnJwdFJjVVZVNVI3bmVqNzN4b3ZHN1J6c2pYZDVxaEttVjRT?=
 =?utf-8?B?ZUthd2lJRVE1bVFBMjhkVDdVcCs1aGZuYXpFdkk1RU1oSEZlQTRHNWh3UUdh?=
 =?utf-8?B?UnlxWm42VXFraFJQZGR5UldvYm5HT0pIRjExOTdvdkpSNjlRRXZUUTJLbnpi?=
 =?utf-8?B?ZFdMZEQxaXNSQTlQMWlmYWM4b2ZxYXNIb0R4M0MwekN3T0p4eitRUnNUNHBU?=
 =?utf-8?B?S0NXRjU0VWFtZ0FsQnJKYUdWMGkyblNzZ1NHZHFQc3p6c0tJN0VhQU9BSmIz?=
 =?utf-8?B?ZjNHNlhhRmJ2YnRLYTB4QWg4TlFrUHRjaGlHeFFuQ2ZhNkk3eldLV0F0b0FT?=
 =?utf-8?B?cDVpZWw1T2V3UW5MR3BrOThaZzRYaGRvUEl6dTVBYnFvTjc4UVc2Y2pPUGVz?=
 =?utf-8?B?MGhqY1pmQ0NacktYT1lBdlBYaHViSkIyVGZCcXUwS094R2U0UXBoWnNQSjRs?=
 =?utf-8?B?NlBLaXhyTTkzS1FnNEloU0VoMzVJemFvNVpQdDRGYWNCV3JYZEtGQ0ZDTU85?=
 =?utf-8?B?SFFLd2NBd3FrZm5KaURkVGd1aE40MkdGUEUxa0VDSFFuZ0JsbWpyckZKZXpv?=
 =?utf-8?B?NG9TSkkzQ2JMbk9yWjVKaU9WQmhmNGNrc2dPRzNkTGFQNWorZGk2cFhnZ2tU?=
 =?utf-8?B?SzJqN0NHRE1qVlduVkN5RFRlc2sxU3hYWHJMTEdhaDl0aS9Lb0JoRk5MWGtT?=
 =?utf-8?B?Y3J6MTdhRnluZUk4TXowdjFHMVFWeGJuOHpEQ3BzbllTb3hneUtxSGFIL0Js?=
 =?utf-8?B?TUVpdUh0WUNwUFhpMGRaMGl4NHV1YXVPaGttbW5rTDdKcnNLeTBObGJ3Q3Bt?=
 =?utf-8?B?U2RaNUt5V0V6WVo0SzkzMmYrYVgzeWlJQW4vb1lQZnFUY0k0ZkkvekFEcmV6?=
 =?utf-8?B?NHlOQ2hsTXhWU1RXUGJrZ0wwR09VcU53OXVZTWw1RHRPUmtDZUxoZlhVNlFG?=
 =?utf-8?B?c1dqWCs0dFR0OE1HREpzUkp0VVlCY0hiMGsyTVJCUHFveFA3YUZ6U3o2TGdi?=
 =?utf-8?B?dTB0c082RFFZenZRME1qYUU3SmtmRnlOSHFzdGVudXAydWUzS0o1bDhBNEdw?=
 =?utf-8?B?U1lLRnUzdjhDd21STThBcVJUM096TkNsZko0aW9JM1BCRHY2d1ZaWHhoSThu?=
 =?utf-8?B?SWp0bjVUVTFReXAvVVhQb2l3ZTRod0xHbkE3TGZKU1FvRmhVK3l6SVFTZGpa?=
 =?utf-8?B?Y0wzVzhoaVZjY2hJWGlodlYxLzdhUk8xRFRHV2lIMG1PRWxqMnpmQlpGM0l0?=
 =?utf-8?B?OXp0ZU1FbWdYdlplbHRONFIwQkswUU81K1ovZzh0STVKUTdWY3R6dE9xZ2pW?=
 =?utf-8?B?c2I5a20xSWU4UzFsWnlRVjZGVUMySS9DenJkU010M2dVKy9ITEQ1MHVDdklU?=
 =?utf-8?B?WVNpK2RROU1qWW9XcHhQVHBOT3pnVXhSUStoRnFmUGJRWU1vRlQ4aURTaTFi?=
 =?utf-8?B?RTBqTEVzT2FlR3pqSk5ZSlFrL1NaVnNQWmdwaDZ0V2JWRE01TmFLWkhtbG1s?=
 =?utf-8?B?aGZ2QkxlNnZmSjZRWk81NlNGK3NZeU5EOXJiZ29DcVUwaCtKRUhBSDJjTGJK?=
 =?utf-8?B?dHhxWjc2enFGOUdVaVE4TC9OZCtjbkFDZHQ5K2ZTSjZnQkNJKzJpSjNRbEl3?=
 =?utf-8?B?NytQVEl2UUNNdU1vU1RRQUhYMU55NTFZZ2Z6eUhxRHpBdVBMOVJ0SCtIN0RB?=
 =?utf-8?B?RHpoMkhIeDdSQ3R2NVFva3BOdEZqQjdyWDZieVVrUnczRngxaEkvRDhVK3FO?=
 =?utf-8?B?QTUzRDFiSURsUkEvSGxWMWFwSVJDei9sWmpMVVVoVytFajVTK3h0UmtGUmZ4?=
 =?utf-8?B?c3B5T2RwVGF4SmhuR3RWRmgwMVh1NnUxelRWZmZVek9vblN0M2pxamFBWVJh?=
 =?utf-8?Q?j/tSn0O95sb0t?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR12MB7804.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NkEyZU9HdkdoRGFaa3IzczRsK2FZbGxmNUVKditkSEo5VWtJVVRydHFPdkJB?=
 =?utf-8?B?UU1MekJGZytvaEdiaS9DS3JUQUIxSHEwaFMrTXk5b29tV1h4ZDZ2Z2NEKy82?=
 =?utf-8?B?c29KenE3UDVMMjFoL0lqMS90MlhSSWVrS09lN0MzNWRqOEdsSStjbUs5MEd5?=
 =?utf-8?B?ZTBHRmJWamJJVWErYlJqTnFhQWtEcmZ5dklZQjJzVDZUdUJkZ29lVldMUnow?=
 =?utf-8?B?aDZnYTFGZzBtcUdwbHY4QnNLanlwMjNGTmxQRGpnYjJMTWdxeklLZzVYQlR6?=
 =?utf-8?B?NUVnTjVKdUxRd3dmTGVHU1BPVi9RRjJBY1RnR24rYWlaeHhmaHhDb1o2OHZz?=
 =?utf-8?B?SlkxYnZCRUVrL1l5UFZ3cWsyclJKY3ZLOUJuYkYwVThEelQ5Zmd5SzQzbG1S?=
 =?utf-8?B?Tk80cW1PVVpsN09tOUxTMkwvejFLZHRwbjJUZEZkMi9nSVorRU9remRONVhG?=
 =?utf-8?B?V3ZNcXhKL04vL3lMSFNqZVpCU2laTTk5dzIyeVRiT0VGaDZGUTMwZ1plV2da?=
 =?utf-8?B?RVQ2LzhVRkRRSy92UyttRlRSYUNGd0NGV0tvZFc3dmVhOWpnZGpWa0VmRG5i?=
 =?utf-8?B?SG5seXBIUUVYeGJkSGZBMVVpWk9LZ2FpWE1Zc1h4S25zVitTUGx6aXlaejkz?=
 =?utf-8?B?REhBZVJBNTlZUnpiRVZkT1prVklIV1VUb0N3OE1LS1ZzTG9VVmJUeDB0cG9k?=
 =?utf-8?B?dXB4L1IrWVBsTEdIL2JETjBndjN6aG5IMUdldkdGYVFseEU1UnQ1RTVpK1cr?=
 =?utf-8?B?M3FnaHBoa3BCSU1acVEzdWJ4TVZHeUhBd3J5N0VoNzZUZzBrMC9ra0xFRUc2?=
 =?utf-8?B?ZE5IQzIrOGFITllZRzZtN2hBYmV0cFhtU01jMUVlcDh3NWRXeUxmUUdwbHd6?=
 =?utf-8?B?VklzSE43RUdSVWFtMERJcWtkOXo4aWZjZDVpalQxUzJXWFB2S25VMFFlL2gr?=
 =?utf-8?B?dU5vVWNSbDgzcmJwaklyWFV3V25qejFFeHhCVXIvRThiS0VRbExQSWZ1UWNv?=
 =?utf-8?B?bzllQ2tkZGtIZ3pZUWN0TER0VHZJVWJxTU5hZzAxNVJUdFRHNk5HZThyRjdK?=
 =?utf-8?B?WTF5Wm5UZGwyVnM2aTdPMHppa09KWjJnOUI1ZWl5TlNna2FVU1pqMWc2b0tm?=
 =?utf-8?B?NnJyeDVQY1JndVlkYzJvcE4vWGpIR2RuOXBmUEFValdVMTBvUVNSUTN2QzJu?=
 =?utf-8?B?MFl6c0dBWjJBRHY4cXNWQjFYNVoxNFlHRlRnR2NZU0lVKzlSdkJjSHNWRkZz?=
 =?utf-8?B?Yi9XUStqLzNVU290bU93cTJ5OFp1czlFbEdNd0YvRWtKVTB3UDJjUnN6MEpE?=
 =?utf-8?B?TzNIVDBZZ0NuaDF4VUwxeUt5a08yb0JDSUl4cnQrUzRvZkhsZVVXY0ZwK1Zv?=
 =?utf-8?B?N0wvNTFqWGhzMm1xMjdGZUxsTVgxTm5GSWxNazJJUDdaVWdRNDRqSWxQUnIx?=
 =?utf-8?B?N0prT3RtbzN1bHNZSUd0TC9oeFAyM1Q5MGs4MTRsZ3hEVUcwUTBlL09oaDBX?=
 =?utf-8?B?a3hERFM4Nm1HOU1Mc3NUbk1vaGlqUjdESXVaa3orb2E0K05ySXZWaUI2TVl0?=
 =?utf-8?B?eDFodEJjWklWYzVzNlAzMjJNR29GTGQzRkcyMjFYQWVRcCs4RDFXT05tU1ND?=
 =?utf-8?B?YVBHQ0NCQ0xCNG1Demg3MDQvVHkxdVBOOSt2UU41cWZwSHlmM2I4eVFleE14?=
 =?utf-8?B?REV1MXZVeE9ObnZxN2x5SEQzQVFLZVIyU1kvdmpMdUIvTytQTXMxQVRpck1I?=
 =?utf-8?B?TkF6T1JIV2ZobmhkT1RPODh0WXpUcTl5aG5oN3RCZCtTMmRNbThFbmVjdHE5?=
 =?utf-8?B?OXpNMWEzZDRENDJxRHNjNmM4ZWFHYm5YcDR5U0x5V2YrODNuN2hwZk5TdXdT?=
 =?utf-8?B?TzNOa3QyUmJGRnRuSFc0ZnUwSTAxYmRTWWx1ZFNQNVdHd3dJYmlXLzRGZExs?=
 =?utf-8?B?d1FhendPSkcyRU1mRWdOWHZwdTlPRHZLazVyakZta0NjYnlqOVNKT0ZIeklR?=
 =?utf-8?B?UXh0eEE5ZkpyeXdaWmF0VUgyQXJxK0hpdkozVm9rcER3NkFTaGlBNG93ZWxN?=
 =?utf-8?B?ZTZ3RldsZmdOZnhtZ0M1eWliNWpPWjQwVmJqVUdTU1FPQ1RvMTBxc3dXTlNV?=
 =?utf-8?Q?loWhBv6guArTRbOHF2lmJF6ws?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: be314a6e-a8a1-4470-9735-08dd65076213
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB7804.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Mar 2025 03:54:14.5151 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: crSlXBob/IyFdpKYIunsCrHxxAuJaIK1VCKKW9lsAC5XUUVrujzR8a+Ecz8BG5ZP
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7202
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



On 3/17/2025 8:03 AM, Flora Cui wrote:
> Signed-off-by: Flora Cui <flora.cui@amd.com>

Reviewed-by: Lijo Lazar <lijo.lazar@amd.com>

Thanks,
Lijo

> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> index 7ca2ebdd3c95..ca556fd84bca 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> @@ -4796,6 +4796,9 @@ void amdgpu_device_fini_sw(struct amdgpu_device *adev)
>  	kfree(adev->fru_info);
>  	adev->fru_info = NULL;
>  
> +	kfree(adev->xcp_mgr);
> +	adev->xcp_mgr = NULL;
> +
>  	px = amdgpu_device_supports_px(adev_to_drm(adev));
>  
>  	if (px || (!dev_is_removable(&adev->pdev->dev) &&

