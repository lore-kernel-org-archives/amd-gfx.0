Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8B968C43458
	for <amd-gfx@archiver.kernel.org>; Thu,  2 Jul 2026 08:12:35 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 28F8310F1FE;
	Thu,  2 Jul 2026 08:12:35 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="iPc22vq0";
	dkim-atps=neutral
Received: from CY3PR05CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11013038.outbound.protection.outlook.com
 [40.93.201.38])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 55BE010F1FE
 for <amd-gfx@lists.freedesktop.org>; Thu,  2 Jul 2026 08:12:34 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kZFg66SwS261Zi8Czb5chncM1pvqepBLN3eVqVP98aFvvF/CsE8CZAoHEx6NXBggbN0Dvav02G6nykAJp1e/AgyotlchGU6ByZcggGL0OrdU3DqBQIaLK+XTl17FvGiyQEWUFG/Ihbx7/KZXCMf2zelrWCIafJs1WdE1IH7Thk9JZp1EU9BeAYjHCY7y415BqE5xU91wECHjYZdQpDiLNB00zZ494EIUex2tFy3kA4A3bf5NMWUgYsPNkreqgwLUEbONezmtNYO9RpcxYW0DbxS76b67ICndV9v/INExe5ujGyPX4Q5uDuIwJ5MvgVTHdNxsWHn4+V0VUXspZzFS1A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=73532OQ5mUH3h9CpLoXNFvRgP0uH1WLF4EEyQv15f8o=;
 b=pEgT4o+RrXnh3Q+cJb9rEaC5lL/sA8jl+DaMlU+6NKW54k4+hl94syzYP3i831uxc86MXOoHeDJCaHYlyWxTSeP+jg+2V5R27nOzXOixjwDMRrQnPWBkA+RELfp8t+wMzYR2Fn95yMuaCjNr6u/zA4Vk/l4woXPaHdvIQL60p/zZH+GPHKYxRz5mYuyuDh9k9p+GWSLYufApkA45OHRlOfqNsy4qUEyjcO4gpM5yMhe+bw3a86ajHaQEdlWXNdFUae7NT6vPr4WfwRFac76n0ZelQXiwNWH9+aIZUCrvYPxo7/BIwYaS+Q7GzBId320BvoHnoUApLfZ+61Lk9LNXEg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=73532OQ5mUH3h9CpLoXNFvRgP0uH1WLF4EEyQv15f8o=;
 b=iPc22vq0B6oSeTmtDFkj4Zu3qcd/S8xhFJE4WE5G/FqYdUxunJqWDtAlncrmnxYBgkgqk7YBEFiYGkEtL6E1cphDIO0AVsI12fwIAlam3cvm6RcT3KrboGDjbHmKn9QHOEQccPuYqwBZ1zV896zmQBqKicPyHC2yd8pikWaljW0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by SJ0PR12MB8165.namprd12.prod.outlook.com (2603:10b6:a03:4e4::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.10; Thu, 2 Jul
 2026 08:12:31 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c%5]) with mapi id 15.21.0181.008; Thu, 2 Jul 2026
 08:12:31 +0000
Message-ID: <030a0e49-e2b5-4659-9252-02ce57b1a660@amd.com>
Date: Thu, 2 Jul 2026 10:12:25 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 04/14] drm/amdgpu/ih: Add retry_cam_ack IH function pointer
To: =?UTF-8?Q?Timur_Krist=C3=B3f?= <timur.kristof@gmail.com>,
 amd-gfx@lists.freedesktop.org, Alexander.Deucher@amd.com,
 Natalie Vock <natalie.vock@gmx.de>, Amir Shetaia <Amir.Shetaia@amd.com>,
 =?UTF-8?B?TWFyZWsgT2zFocOhaw==?= <maraeo@gmail.com>,
 Mario Limonciello <mario.limonciello@amd.com>,
 Tvrtko Ursulin <tursulin@ursulin.net>,
 Felix Kuehling <Felix.Kuehling@amd.com>, Lijo Lazar <lijo.lazar@amd.com>,
 Siwei He <siwei.he@amd.com>, Philip Yang <philip.yang@amd.com>,
 Mukul Joshi <mukul.joshi@amd.com>
References: <20260701161721.85681-1-timur.kristof@gmail.com>
 <20260701161721.85681-5-timur.kristof@gmail.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20260701161721.85681-5-timur.kristof@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR2P281CA0007.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a::17) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|SJ0PR12MB8165:EE_
X-MS-Office365-Filtering-Correlation-Id: dc24bf0e-3cb2-42e3-9f13-08ded811a9eb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|376014|1800799024|23010399003|4143699003|18002099003|56012099006|11063799006|22082099003|921020;
X-Microsoft-Antispam-Message-Info: XlPhlKiFsSGYe5hQnvNX5leevVCr6jCZEuFA8VQnp3IhDgwKPRz77qZF09pkBLB6G8pwErIlEsl88wLr/kL4Q1qA0Vere58K/BJzaLY1nyJyYUKFZPZJE851eHwtghbiyzxuyJKFYQ9VVO73hIlxK5fWvVhsQcc/QBOWg1e42v53ZqIcVvqKRldKrltQ147pJHIKWG214lc8/lrOJQNee62TRqTIRilF/Uton67U3gxCG0In5w/86MYjbkvLz7ZvUB3NzTo8dARcKQ5pdmVjuYNwwbxmTerP+NWSycxVgIMgP9SkJKDHUJaxFEKEbalvOIEdiXbx6xD3z4ze9MfTpJP0QoLA2BgKbqccunA8VvYvWDl//qu3bB1Cjn7xH7GDo8d/mcIW8hBcbtBRL3i6ImhB98U6MfeWpicZEPkWA4eFMtvXSINpoFuR90kqjlkHH/n3EyYBeqHWyJYeze868j9DPx/rrLEyk3dmYaTJuM2dVQ9Lw0Ltr16dAiHKgAaK92zK1Y2q9QFdJp//Vn4BIQoXgh6OdYohv/QWPJVZzW+DFyDqFJsyb4SVnuyRX7kVEdC63nQyZz20aG5HaOuzb4J+/WcAJIpCJYQWyZT+7FcYW2RgvZ4FFiG4HPBipufNtH4AwWqLZPNllEINCO9x/IUw+KAkNco8eM4/CrRz2pg7mmjViRJv3wWGQwJ6bL31kPsDnF2Rn3RZ7htPjbDIgw==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(23010399003)(4143699003)(18002099003)(56012099006)(11063799006)(22082099003)(921020);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?emZQU3J5YUl2U1VIb3cyTnVJbEczS3JWRzI5c2poZHJrcUFHeGg4dEc5WVdt?=
 =?utf-8?B?QkZwU2lXTUo5d2pyVEFmbFhVWWIyaFRSUGVyU2pISXV6NXlvZmtiZlVMNklz?=
 =?utf-8?B?M1B1U1NoWmRRMjhRek5wdDVzSE5neVZnclBZanRieEptTHIrVkxjN0tVMFQz?=
 =?utf-8?B?dHA2S1h4YTRhUEE3UUFnUVdxUWg0UG1TdUNGaTV4NXc1T3dBSUVLMGl1UHlE?=
 =?utf-8?B?MEp3VWFWQ0N5ajE4VnlET1hmTGlZSFJuRVdjR292L1k4d0IwY1NuN0RMc1I1?=
 =?utf-8?B?VWZmSTRFTGFINmRmc28wS1ovcG4rWkczejB1a3B4bzBZRzBCRHpJYmt3QWVO?=
 =?utf-8?B?cURZazM4WFFzL28yYmdRL1BWd0kzZkNac1A4TVhFL3RwZ00xeWcvc3gwcHZY?=
 =?utf-8?B?K3M0R2p1Zk96WDh1dDFybEF1MGd0N1BURXNJK0VmSmN6VWhxLzdLWjNmbXBR?=
 =?utf-8?B?V2ZvQmNESEpXWVByeFp3bjl4aUFCS1R0R2RrUTVMWWJ2eStHY2cvaVBWbEFz?=
 =?utf-8?B?bW0zMHRSOHZMQWJGcld4cko2cWUvUVZQRU1oWTByZEp6MVZJT2FvdUE3V3Jx?=
 =?utf-8?B?SE9ZeUcvd3l1dHpXcFNWK1VBaVZXbG5QRjc3NktsaFJmaytyQ3lsb2xITC9P?=
 =?utf-8?B?RGdCdVluTGNieWZ5NjNMcFV2SnNCMFNSQTJoR25oV2RiR3lnMjYyRU4vdkVw?=
 =?utf-8?B?ME1RaXNRSU05OVNaVStYMzhPUjhmQkFSRFhEUEwyRVVTWHAzb2RxQ09ZN0hp?=
 =?utf-8?B?eEZOejNnWWJaYXBKcUNjWWxWdkVzQzlWdmNrWlpSZ3JKcjNIRC84MkhIM0o0?=
 =?utf-8?B?MnNWa1RJUGVBaVNzYlAwV3c2dW9pNURoSzhVNUFCSEZkSURvcFJqSGhqZzNK?=
 =?utf-8?B?UVFoNU9OSzlRczNpWU5MVDVsaWgvSVZYZUJjOUR1TUdET1hCdVBDcENPcDZx?=
 =?utf-8?B?WkM5aXJvbjh2QjN1MjRucjIrQVA0VmVyUm1oekxVRXZtYlpiNm1HS204alNQ?=
 =?utf-8?B?OEw4T1N3bkxEdUFaMGdKWmJCanZQREJ4Y0JoQUVkcGlWNkRNdWg2NUREenJ5?=
 =?utf-8?B?TXZRSWFiMkw2a0p4TStpWm10V3hjbWkwYmwrS2FFclQ4R3o0LytlMTl3d1N4?=
 =?utf-8?B?QWpOWGFVcGdtT1NKT2lRUndhTTNUWVk5KytseFVJOGt2dHZyUTV5VEE3SzRR?=
 =?utf-8?B?aTNhQ2Rwc2JxaG14Z3hUVEVXWU5Fdnc1R0ZLUVpTY1NMMmJwdG42QlFhUmJ1?=
 =?utf-8?B?TUVKVmQ1Sk9YTnoram9Mc0YySTA3MkpEbE8rbHU0bGFiUjRZQ1NLbm03S2Ja?=
 =?utf-8?B?ZWdMdzRVdXZMaGI3dTVLOUc0Q1dsUk0zUnplNUIxcDFscE1KOUFGUnAzN0Zo?=
 =?utf-8?B?QTRLRnkzRTFJM2V3NTQwZ1cvWGoybGxYdi9NNjRXbjMvZU5ic05kNkxsQ2w5?=
 =?utf-8?B?UUZ4dEZVTTEvNzB5MmJnOG53ZExlSkROZ1o4QUlWQUF1ZmxJemhWY2ZVaVZE?=
 =?utf-8?B?cElpUmdPQTl0OXRTcWtDakFVTklHYTNqbGIxOVJFMjBOblYvaHpWdVVQdEh6?=
 =?utf-8?B?MG8xdEQzWUtMV2krQnhxWTlXNnJTR2xuc0xENGV2QlZVN2FwZnZHQUcrK1N1?=
 =?utf-8?B?Zy9xa2NWT0haT3E1RTVsMm5Kc21VNnExVHNGc0g3b2xlelg1Mk1lQ241a3Zv?=
 =?utf-8?B?TEl4SzJ2NXYrSzA4WnpWOFZGOW42Vjk1dzhEZjFUcWl6aGZWZ0FnZ0xRNktV?=
 =?utf-8?B?WFFzYldhcHBQR3JteElFL3FocmhZYUlGanJVSHQrZmFVbkpDVU1lZmRFT21l?=
 =?utf-8?B?Z01FaFRsaDVVN0RlRmpic1pIYkZiUzVzVXUybWliWVBaUGYreTQ3ZUZaa3dP?=
 =?utf-8?B?T1JkTkZkcit4T0hTZ2tqckJ2Y0R2ODFOMklmdmg5cndiMGovUW14TTBLK3Z6?=
 =?utf-8?B?ak0vZytpZXZ6MElYMjh5YWVNL2xaZ2dXMEUyY0hSZjQ2V2xMRTVJSGNZRkgy?=
 =?utf-8?B?MkhGcU9BbG84bktYSGgwT2hPTXB3OUpPN25OaDZBdWJ3cFJuWlhNY2IweFBI?=
 =?utf-8?B?REFPR0VsYzlKdVpHMTBrWElQN3JSWVlzTldxMmVpSmZxaTUxZlVuZkJmcUxx?=
 =?utf-8?B?emZ1OHBqV3Y0Skhsb0NucThUNlY0RGtGVkJQWXdxcU5ISGNlRWZhcmZhQzlH?=
 =?utf-8?B?WUZidmhlTUxBMnRIUXNCcnpQWURnaXB3ZytYclhGVEVsWVZnc2IxZit0bW43?=
 =?utf-8?B?U1d6VDhPWUFYWFdESVA4MmxpNVVobGZXbEJoSU9JYVlsUFI3enBIcy9hcThD?=
 =?utf-8?Q?NJ1HoSwOAf8eQw1Xhm?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dc24bf0e-3cb2-42e3-9f13-08ded811a9eb
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jul 2026 08:12:31.1623 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1ImbItkhRrMkPKnZezn+b5JC/IGTSq4J4dP9WRTyjj9kpVMntGeu9A8A//fsZVnP
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB8165
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

On 7/1/26 18:17, Timur Kristóf wrote:
> No functional changes.
> 
> This is a refactor to allow different filter CAM implementation
> in subsequent commits. The actual new implementations are
> going to be in subsequent commits.
> 
> Instead of writing the doorbell in amdgpu_gmc_handle_retry_fault()
> directly, add an IH function pointer which can be defined in
> a different way for different IH versions.
> 
> Signed-off-by: Timur Kristóf <timur.kristof@gmail.com>

Reviewed-by: Christian König <christian.koenig@amd.com>

> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c | 7 ++++++-
>  drivers/gpu/drm/amd/amdgpu/amdgpu_ih.h  | 1 +
>  drivers/gpu/drm/amd/amdgpu/ih_v7_0.c    | 6 ++++++
>  drivers/gpu/drm/amd/amdgpu/vega20_ih.c  | 8 +++++++-
>  4 files changed, 20 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
> index 3f0b1b7a557b..bb278a61dc9e 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
> @@ -552,6 +552,11 @@ int amdgpu_gmc_handle_retry_fault(struct amdgpu_device *adev,
>  	int ret;
>  
>  	if (adev->irq.retry_cam_enabled) {
> +		if (!adev->irq.ih_funcs->retry_cam_ack) {
> +			dev_warn(adev->dev, "retry CAM is enabled, but retry_cam_ack is NULL\n");
> +			return -EOPNOTSUPP;
> +		}
> +
>  		/* Delegate it to a different ring if the hardware hasn't
>  		 * already done it.
>  		 */
> @@ -562,7 +567,7 @@ int amdgpu_gmc_handle_retry_fault(struct amdgpu_device *adev,
>  
>  		ret = amdgpu_vm_handle_fault(adev, entry->pasid, entry->vmid, node_id,
>  					     addr, entry->timestamp, write_fault);
> -		WDOORBELL32(adev->irq.retry_cam_doorbell_index, cam_index);
> +		adev->irq.ih_funcs->retry_cam_ack(adev, cam_index);
>  		if (ret)
>  			return 1;
>  	} else {
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ih.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_ih.h
> index 444437c30088..e6e34f6e86f4 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ih.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ih.h
> @@ -97,6 +97,7 @@ struct amdgpu_ih_funcs {
>  	const char *(*node_id_to_die_name)(struct amdgpu_device *adev,
>  					   unsigned int node_id,
>  					   char *buf, size_t size);
> +	void (*retry_cam_ack)(struct amdgpu_device *adev, u32 cam_index);
>  };
>  
>  #define amdgpu_ih_get_wptr(adev, ih) (adev)->irq.ih_funcs->get_wptr((adev), (ih))
> diff --git a/drivers/gpu/drm/amd/amdgpu/ih_v7_0.c b/drivers/gpu/drm/amd/amdgpu/ih_v7_0.c
> index bd332e8cc5bf..24be9d726428 100644
> --- a/drivers/gpu/drm/amd/amdgpu/ih_v7_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/ih_v7_0.c
> @@ -289,6 +289,11 @@ static uint32_t ih_v7_0_setup_retry_doorbell(u32 doorbell_index)
>  	return val;
>  }
>  
> +static void ih_v7_0_retry_cam_ack(struct amdgpu_device *adev, u32 cam_index)
> +{
> +	WDOORBELL32(adev->irq.retry_cam_doorbell_index, cam_index);
> +}
> +
>  #define regIH_RING1_CLIENT_CFG_INDEX_V7_1             0x122
>  #define regIH_RING1_CLIENT_CFG_INDEX_V7_1_BASE_IDX    0
>  #define regIH_RING1_CLIENT_CFG_DATA_V7_1              0x123
> @@ -865,6 +870,7 @@ static const struct amdgpu_ih_funcs ih_v7_0_funcs = {
>  	.decode_iv_ts = amdgpu_ih_decode_iv_ts_helper,
>  	.set_rptr = ih_v7_0_set_rptr,
>  	.node_id_to_die_name = ih_v7_0_node_id_to_die_name,
> +	.retry_cam_ack = ih_v7_0_retry_cam_ack,
>  };
>  
>  static void ih_v7_0_set_interrupt_funcs(struct amdgpu_device *adev)
> diff --git a/drivers/gpu/drm/amd/amdgpu/vega20_ih.c b/drivers/gpu/drm/amd/amdgpu/vega20_ih.c
> index 85846fd08ce4..30a82fff3ff7 100644
> --- a/drivers/gpu/drm/amd/amdgpu/vega20_ih.c
> +++ b/drivers/gpu/drm/amd/amdgpu/vega20_ih.c
> @@ -293,6 +293,11 @@ static uint32_t vega20_setup_retry_doorbell(u32 doorbell_index)
>  	return val;
>  }
>  
> +static void vega20_retry_cam_ack(struct amdgpu_device *adev, u32 cam_index)
> +{
> +	WDOORBELL32(adev->irq.retry_cam_doorbell_index, cam_index);
> +}
> +
>  /**
>   * vega20_ih_irq_init - init and enable the interrupt ring
>   *
> @@ -738,7 +743,8 @@ static const struct amdgpu_ih_funcs vega20_ih_funcs = {
>  	.get_wptr = vega20_ih_get_wptr,
>  	.decode_iv = amdgpu_ih_decode_iv_helper,
>  	.decode_iv_ts = amdgpu_ih_decode_iv_ts_helper,
> -	.set_rptr = vega20_ih_set_rptr
> +	.set_rptr = vega20_ih_set_rptr,
> +	.retry_cam_ack = vega20_retry_cam_ack,
>  };
>  
>  static void vega20_ih_set_interrupt_funcs(struct amdgpu_device *adev)

