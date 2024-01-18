Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2114EC4707B
	for <amd-gfx@archiver.kernel.org>; Thu, 18 Jan 2024 05:13:35 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 55C1A10E12E;
	Thu, 18 Jan 2024 05:13:28 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2041.outbound.protection.outlook.com [40.107.236.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7738610E08B
 for <amd-gfx@lists.freedesktop.org>; Thu, 18 Jan 2024 05:13:27 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KrCEAxpF48hFuo9tsWk4dBxdHxeJwy10YpZRzEjTJpSrHP0WXGvEDlxB3g+mqdz3xZ1Cn4bGOHANkW4zKf2oGrrT5KdkgesdY3qYHV94XhCiViUzkdfV7YR2CDw5rqvWYqigHuHRKNUkgO44B6m87JOwyjz8F6ewque3iidF7AA0E4FTzBTnd6yJITDPGvRILdj1/Zf7GQAGElwvw+ozUgl2rXE9z6VsQ9iMRVfX7Ezd3ep3rX9IC5gd07wz0SLcTvxcgUd3dvet94Au0EolO0+peULdl38rZNE8l6p5FyFK3BxUCbrdWln8JE070abMdX5WSUqZjxICvf+BhXzH1A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=p+19YqWoJ1T7wfDX3oWSQZrfkFml1+u/RprWCnH4gm4=;
 b=NxrLKldN7OEkginLgAQXocXhfBpnWTgkgVETA61UqTogG1SI6JyHVRMK24b3E8wHZX3+LwyECHfD8i+/B5Z6NWyPCaudLEr27UUs41jTwIwhAHhwBaFuU7bZM6pdQ7NKEwp4Y1MklwAvM3ynSdMv+RSNi0/i1Pc4c4M6hloMspJ18azfiS/nh2BcnsYC0xeveElsBJRM4+dt5rlbNBGUFwyGzMbY3Th8YgUZrP2WhMYWGvPhSA16mIWzObsDzmpGCHFHDjI98eMNUc1eJRq8z5E1fj+rAFDsG2c53KBpImC8m5dv8RN7eKSKZNWMK8kVGtil7IeJh4YD5nK+D+wDFg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=p+19YqWoJ1T7wfDX3oWSQZrfkFml1+u/RprWCnH4gm4=;
 b=GOEUjlJThKidF2dNF6qmN5S2V2RNz+fM58eFhoMxTgEBfRtGwH8rPOQ+mlEoCeM5V6kNZ77eE0PwmSjqrwtEpcM0Ebc6vgRUZi6n+4p4LKm5kYed1cP2wmj7MJMPh18mrLjfMfxSxohUcqFGKpKGeb4ryHhkg7lWr3RzIZc/YUQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB7820.namprd12.prod.outlook.com (2603:10b6:510:268::8)
 by PH0PR12MB5607.namprd12.prod.outlook.com (2603:10b6:510:142::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7202.23; Thu, 18 Jan
 2024 05:13:24 +0000
Received: from PH7PR12MB7820.namprd12.prod.outlook.com
 ([fe80::5b3b:867e:c8bd:8bf8]) by PH7PR12MB7820.namprd12.prod.outlook.com
 ([fe80::5b3b:867e:c8bd:8bf8%6]) with mapi id 15.20.7181.018; Thu, 18 Jan 2024
 05:13:24 +0000
Message-ID: <869ce8c6-cf1a-4747-be92-89b9c14832f0@amd.com>
Date: Thu, 18 Jan 2024 10:43:16 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amd/pm: enable amdgpu smu send message log
Content-Language: en-US
To: Yang Wang <kevinyang.wang@amd.com>, amd-gfx@lists.freedesktop.org
References: <20240118032654.1950540-1-kevinyang.wang@amd.com>
From: "Lazar, Lijo" <lijo.lazar@amd.com>
In-Reply-To: <20240118032654.1950540-1-kevinyang.wang@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN3PR01CA0188.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:be::20) To PH7PR12MB7820.namprd12.prod.outlook.com
 (2603:10b6:510:268::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB7820:EE_|PH0PR12MB5607:EE_
X-MS-Office365-Filtering-Correlation-Id: 51381753-4cf7-4cc1-bf3c-08dc17e4320b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: f3kLG+fOoxJuPzYUfW9xqiAuXYSxHyvcRm1Lo7UNcfwO8m7A0/p5suNUd9B2Tl8qDSoip4vDlk8p9AhuBDMuzxAik7ARpXnpU03eeFkLaNsjPASi/FiZrLHjY5YoiS5/KgOXsav7Jkpdb+4xWaVcR5rj2x5pvlBV5h8RXioxMEwqToMu0rRLACtvUQUlOnjJSaPozGET9H52/wqIFZlzWRSbG64Z6MiTEtlvLj0xR8DuQtxKFNgyiC4QzCIiUf+4XmwxBANEtY0qyGRFZr32QiOMTc+7hFw1PHdviko6Pouq9pgzS19/fyXr7Vm6zY/Nj5sdWYdI3DAKvDPM1qsMemtCGVHtyX7YddKOXHMviP23sjQsPbpiCyMgRNhHDuV3ss+VKdm23FS9wX8mn49nOVd4yE2RnDV6fWQG6dzzPfud1MwS5Sl2Qww8B4K3L4SX3WcBHR/T/gdHO/3UgV+iUrk5bqnUkdImUW0nMmVFgL2R3HZ/tisJbMuq9Q9KYY3ElTZhNZ1bn0bvv+6WgK6wWanMJEoXY3wFueJ7TksOV+4LkSpQNol8+IZP+dHMm8E9AbE+kmA5HZYSZeYXG4c89y3Qnv5Vkg5dedJOwZLsQWoqgw9xppge7S340Feq8i9CCWa1Rc6NdVQ5Y3E4ooax0A==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB7820.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(346002)(376002)(136003)(39860400002)(396003)(366004)(230922051799003)(451199024)(186009)(64100799003)(1800799012)(41300700001)(38100700002)(83380400001)(36756003)(86362001)(31696002)(66556008)(66946007)(66476007)(2906002)(15650500001)(8936002)(8676002)(4326008)(5660300002)(26005)(2616005)(316002)(6512007)(53546011)(6486002)(478600001)(6506007)(6666004)(31686004)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?YXJobVFHNzJTZ3g0NVBzK0szTkJuY2RxWnBQRUUxZndHUXFSQTg4Q3p0WlpC?=
 =?utf-8?B?MWYveGs1VzJsQWJkVFZDSkZsMnVMWk9MRXNXYnpsS20zZHd5dUJVV0p4Smo1?=
 =?utf-8?B?V2tPK0YxU01tbHovUEZIUFhGaG9vVThmYkg2aXM3WVZQeUNFZWFhMFhJMU9l?=
 =?utf-8?B?QTI2bUFNWDhsOG1kMDQxdnJNcC9jRGlOQ01QSURIVTAyWXdndnhsQ1V0SktP?=
 =?utf-8?B?ZnB6ajVRYUN5aCtIaHE2OWhNa0M5U2VpYjF1NnNWeGhLekllNm9MTVYzVlFG?=
 =?utf-8?B?VmFQRVRuS3poZ1ZxSUFvWlZYMHVvMUZrd2l3REduTGFsWTNDczBvN3dXaC96?=
 =?utf-8?B?dXh4cHVjc3NrOEF0MENORjdkRDVtOGs0ZFRScEswK0FPc1ZQYUhWTXRlcC9w?=
 =?utf-8?B?Q3hMeVpvUXFUeEltU1llUDBWeGd1ZXBWaVlTV3ZrZ2tyQXlUUThTMkRRNDR3?=
 =?utf-8?B?YTE4UnNjdHZDdWNpUWtBdHZERk4yZlVFcy9QM29qQXFFUEtQdzFYdmtwOVU4?=
 =?utf-8?B?cGp3dTVHODNjd1RxVVpTQU50azZ2M2MrUDI3NkVyV3lHNUM3cVdOVFRRQnov?=
 =?utf-8?B?QVBxN05tVXNVa2d6WVk5WkgwaW5HTzVSdGZRemh3dTdQUUhINmxESHM4VFpO?=
 =?utf-8?B?azk0MHB1MG05OVJTUytoa29QT0t6SnU4WGJFcEtlSXF5Sm4rcEJJNmpubGE1?=
 =?utf-8?B?MmJ3SVhpeGxqbmFmTXQ4bXIvZ3JzdTQ0U0hwUyswME9TcHFJSXg0T2ZZVlh5?=
 =?utf-8?B?Q1ZZRCszWHNNVjI5bXlrZUdPR2pVS1FWUnRiRlR4WVdZdGpzWkppTisvZEYx?=
 =?utf-8?B?MTlVdEJzQ2hEQzdXTXYvWjdDQi91Y2I1Y29PVThQaGtSQkMvUC9LSTNPVzhH?=
 =?utf-8?B?OFZFaTlCdVRycXZrZFU4YlZlUGYzcmEwT3pTWDJWSjU3eXU3cll1U2pxaTgy?=
 =?utf-8?B?UmhDOUNkSGptRURMeC8zcDE2VmZoTW1DcWlLUTl4WWdlYUZRVGtjZ2RBWGlG?=
 =?utf-8?B?QzdXVENlRkFNdUZwYmNOVmRKUk9Gbk1EcFBNaWJRZVdnWnI2Mi9CbXBwS2tP?=
 =?utf-8?B?MlRhay9BeXdCS2tMUUN0d282Und2cFBVQkFlUFQ2ZVJTOFhhUWhoeG4vMC9G?=
 =?utf-8?B?RXJiU0NOMGlsWHd6T2JCM3lGUEI4WStuU0U5eWx4cVh0UW1zcXk3b1BQKzZW?=
 =?utf-8?B?M2tMMmxpOHZtZFRrWldKYXVNVGZ4d0pQajZYNm5zNFpQc0krOEM0WXQyT1Zy?=
 =?utf-8?B?KytGR0RMbit4MGtUNUFvOGxGZzYzSkZ5bWh6YWxxUU9LTTkzdmk2dnkzcXNO?=
 =?utf-8?B?TUVRbHpKOTF3SU5sY1dnZkRxNmt3Wjh1RlU4V0dhMXpVZ0N5NldyMnJJemNY?=
 =?utf-8?B?OGhXb1J1cnB0dDZlVHdmK1V0RmtEUDFiSlRYUFB2UXpmZWg1ZDBnYnI2T0Fw?=
 =?utf-8?B?dnV1QTNSaUF4eGs4YkhmOGFxU1VXL1p4TzltZXd4ZTEveHJRWHhZcG1ZamtW?=
 =?utf-8?B?blBDajhRb0hsMnlDUkVTUEdiTjJSTGpmN08wUTlsMllDK1dWUkRKQzBBSWFE?=
 =?utf-8?B?cVRRb04wb2srZ3c4dU0vVkc1YkNQMEJYNEEvdzcrK1g5QzdBT3paQ1FiWCsv?=
 =?utf-8?B?V2VRNHYzbVk3NVBiQkxTbDYydXI3bmhCeHhOZlRCdE9DV2ZoWC9qNTR2WkdP?=
 =?utf-8?B?RE8xY3lsbXJBbStoT3o2QThISDZPbms1bmV5UmF4aUczV3hUNHZTZVowSTJI?=
 =?utf-8?B?Qk91emxJTzlhTUJKNXU2SjQ4Z0dsMG1LKzc5TzU5ZDNQa0NUY2tOS1I5ZzN0?=
 =?utf-8?B?VGlWN3llbVpQUnZUb3dSZmtOR0hPUFAwL3U2a09BM1pycHZsU3FMOUhjaTB2?=
 =?utf-8?B?RVYrSFJRZzdyLzB6RVRRSFFhZmZvYTNnbjBoaThwUTJMN0dOTU9pc2ZXVkhQ?=
 =?utf-8?B?Qm45TTdNelg1UU9Mb25SempwUm5pRHZUcnFTSHlXdWpCUTZPUUkxb0x2OTU1?=
 =?utf-8?B?WXJ6UjQ1d3NpbGRXUHppclgxZWJkaVJxQTNOajBORENYRlk0UVlZTVVkYTN6?=
 =?utf-8?B?OVZZVXdVTmcxRnQxeFZqUEZSMkF5OEtrUVVzRFlUSzlscmt0T09GbCtiUmcw?=
 =?utf-8?Q?1KS7gxgHB74LoH0J/r18pyKTS?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 51381753-4cf7-4cc1-bf3c-08dc17e4320b
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB7820.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jan 2024 05:13:24.2931 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FZYzPqXAEfKcPedTKaGvdQAWPtDFcFfLCKBdbMeE/I0Y8AvhCUnIPT7gBKH0hPtc
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB5607
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
Cc: Kenneth.Feng@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On 1/18/2024 8:56 AM, Yang Wang wrote:
> From: Yang Wang <KevinYang.Wang@amd.com>
> 
> enable amdgpu smu driver message log.
> 
> Signed-off-by: Yang Wang <KevinYang.Wang@amd.com>
> ---
>   drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c | 8 +++++++-
>   1 file changed, 7 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c b/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c
> index 00cd615bbcdc..b9a24ff02a12 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c
> +++ b/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c
> @@ -378,8 +378,14 @@ int smu_cmn_send_smc_msg_with_param(struct smu_context *smu,
>   	res = __smu_cmn_reg2errno(smu, reg);
>   	if (res != 0)
>   		__smu_cmn_reg_print_error(smu, reg, index, param, msg);
> -	if (read_arg)
> +	if (read_arg) {
>   		smu_cmn_read_arg(smu, read_arg);
> +		dev_dbg(adev->dev, "smu send message: %s(%d) param: 0x%08x, readval: 0x%08x\n",
> +			smu_get_message_name(smu, msg), index, param, *read_arg);
> +	} else {
> +		dev_dbg(adev->dev, "smu send message: %s(%d) param: 0x%08x\n",
> +			smu_get_message_name(smu, msg), index, param);
> +	}

Better to add the exact response reg value (reg = 
__smu_cmn_poll_stat(smu)) also to this.

Thanks,
Lijo

>   Out:
>   	if (unlikely(adev->pm.smu_debug_mask & SMU_DEBUG_HALT_ON_ERROR) && res) {
>   		amdgpu_device_halt(adev);

