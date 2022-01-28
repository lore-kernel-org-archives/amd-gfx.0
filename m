Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 22AEBC433F5
	for <amd-gfx@archiver.kernel.org>; Fri, 28 Jan 2022 13:39:04 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 815CB10E6BA;
	Fri, 28 Jan 2022 13:39:03 +0000 (UTC)
Received: from NAM02-SN1-obe.outbound.protection.outlook.com
 (mail-sn1anam02on2064.outbound.protection.outlook.com [40.107.96.64])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 424E510E17D
 for <amd-gfx@lists.freedesktop.org>; Fri, 28 Jan 2022 11:24:56 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MlTWQjPbiRYnxOM7jK9wCIfjOtT8odU4RAgwlo+CgrgwBvPev2ZW5vcJXUP8WIgWLRiygmY2i1PdqM0nORhalbCFnJIVf3gUjjxPkEmlg2IDsdOpqJ0nMMa8tfmFlDo+Jxi2vuZU06GE/nsxkvipNOtpMc0Gvqyx+tHzHieaPk1bnkJ8RQAu4TRQm1IcsrqjL7HbZYJpWTgq8Uqf+CNAQ1+xWewZhk/rc8XQI8Zuc4Siryhr6yr+u6fKvFULcAiLEOfOg2OIERby5793g42DW+CyBi8fU7uqzVTRZeGRokfZWPuVLNJp0rd0YNaQzhlIq+NEbLEiqT/9obdm+dsLQw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=737aIJfJTE6qeUcwYKz8utTHujdowyNxJ9wFEQI590g=;
 b=bwvU7S8+CnlYUDoTw7Y7GVLMvYY2u3jibtVfNScDWp8HzvAPs/Jxf9EMUuqX2dR+DdQdfqY3Jc7hpmq61lTFggWVwvxU3EQQmdtXaRPVviSevf/q1+FdCxWizZi8FgSzUtEPArDlJqceR8SffwwLjDTjvJQiKVJ1r9RpP3QNlYuYSijs/PPcFqCUK7Zv+2FupK74UmrkntsvYaXJVoqi1fXkXNZZfQlxL7l6SlmcyP+zQe5IbtWTz5P50Jda7TnnMHNQxIT8Bv/EBBBLATXqEPwUCBh7Mmuk4IEekqFI5tWkc3IfMaVEHQ9DOqJXP3OlSrvaY/V1gqS6zPQrL2xd3g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=737aIJfJTE6qeUcwYKz8utTHujdowyNxJ9wFEQI590g=;
 b=wqmMmXEokcb2Y1Wwfib4VfErhEWvSLjYy9Bbu0qosw3TB/eMoc/wF75VyAomsXG9gq0EV/T+OUS7o1zQSoSvJwevivAOfftiylNIZVrOW/QyVWDAsnenLt2yBw10TuRrCQanuPcWpEzgHI/rAHszbv5GIzBUDi3oA5pEmEXMPFM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN6PR12MB1620.namprd12.prod.outlook.com (2603:10b6:405:10::23)
 by DM6PR12MB4880.namprd12.prod.outlook.com (2603:10b6:5:1bc::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4930.17; Fri, 28 Jan
 2022 11:24:50 +0000
Received: from BN6PR12MB1620.namprd12.prod.outlook.com
 ([fe80::6499:5a88:7dff:9978]) by BN6PR12MB1620.namprd12.prod.outlook.com
 ([fe80::6499:5a88:7dff:9978%9]) with mapi id 15.20.4909.019; Fri, 28 Jan 2022
 11:24:50 +0000
Message-ID: <39f5276c-deec-82f3-ffb6-135a84a6fcb3@amd.com>
Date: Fri, 28 Jan 2022 19:24:41 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.1
Subject: Re: [PATCH RESEND] drm/amdgpu: Remove the vega10 from ras support list
Content-Language: en-US
To: "Chen, Guchun" <Guchun.Chen@amd.com>, "Ma, Jun" <Jun.Ma2@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>,
 brahma_sw_dev <brahma_sw_dev@amd.com>
References: <20220127114718.836592-1-majun@amd.com>
 <DM5PR12MB2469CE0861450AA73623FA1DF1219@DM5PR12MB2469.namprd12.prod.outlook.com>
From: "Ma, Jun" <majun@amd.com>
In-Reply-To: <DM5PR12MB2469CE0861450AA73623FA1DF1219@DM5PR12MB2469.namprd12.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: HK2PR02CA0187.apcprd02.prod.outlook.com
 (2603:1096:201:21::23) To BN6PR12MB1620.namprd12.prod.outlook.com
 (2603:10b6:405:10::23)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 8373efc3-38a8-4dae-0be2-08d9e250cbec
X-MS-TrafficTypeDiagnostic: DM6PR12MB4880:EE_
X-LD-Processed: 3dd8961f-e488-4e60-8e11-a82d994e183d,ExtAddr
X-Microsoft-Antispam-PRVS: <DM6PR12MB4880E76C41A561BDDCA250FEBC229@DM6PR12MB4880.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: t+H0a7rrFKBwgESOlr03nUWBoxyUjBsqzsW1A7F50JGj9mp9upxqEREwOcRAVOoMJCQCtXQwaQBaJPMxcyGWqltSoYK3yFKeeI68uaBK3/Q5bfF9mK9muOfYXYrIX9Gh9aQp8Pce4TcAR/K9yN8QJU3pFhJqzVt5r+7RNqQg9JOXu6jDL27JH9IiY621W5MMI3mIzPORvQgD3zzqIAHKzOME83/8IGPFtrAiNqC2LhkSqHTScgbokJafpoLJ76TiMrI5dTD4UQ6zV59hCYO0b1IIG8F2dK8BnggSknBSxxC5RiKALJz8M+m4h1svcnjRzLOOlVBYOAoPQjCXma2/k1AdSqhGE4NUUwxUlhZR7gOLf1o/+6wd3v8LyBT+5OiDQ026gFc2E4ppETj6DcIv8OT2sVf5+H0M05DwMl1UUp3gMUsz8RMObwEoobAbk85AgmwHrP3fkvuuAGnEJbxaVVwbK8rkPaA0MXi3oOz+iKsFf17SXVkdf9lDNFlLGw1I8LXmk25Ioi3ILzjTiXtE9kRxSbfjIFomliBCdEMJqSt1fWi2elwSO+zlzdllDC8qi0uPfP3vWZ2vZDcsTx/dXcEeUbhnHEvCbZJbWXhuCuJxeXHj3AX22oujIjHwpVTmruhh9qbMPPnISM/S9XOnDjCXJBef3ux6mIfblZo3+U81Vj5+wciGiML1c3ZWp8mukunOTZLjAA5EyB/0OEpCMVW5lPKv9vtM6kn52kb7ppo=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN6PR12MB1620.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(4636009)(366004)(6506007)(110136005)(6636002)(6666004)(508600001)(54906003)(31696002)(6486002)(2616005)(66946007)(53546011)(83380400001)(26005)(8936002)(316002)(36756003)(66556008)(38100700002)(31686004)(2906002)(186003)(6512007)(4326008)(8676002)(5660300002)(66476007)(45980500001)(43740500002)(20210929001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?THdmTE5yd0tRTDlZSXZ6SFdBcDNlS2RKQkxjUUV4L1JVa1g5bmNuUk1HdUxv?=
 =?utf-8?B?VnVhdnNIdHlJNVM4S20xRGlnWTNGRTR3VExaWUM0RDhyd3NRK0RhbEZheDJa?=
 =?utf-8?B?dGh6MFpNRHBHdll4cjZRUVRHQklUaVZZdkdLM01hblZ1REhkMjlRWGl4dTBR?=
 =?utf-8?B?Z2RBWlVVMXRMRjFoZHdkMEg1c2JmcnVFZ1FacUt0UmU3MC9vMUFWMDYvcTJD?=
 =?utf-8?B?dTVEU1J6ZStmbFFNdFpBU2ZIUXQxY3pmelFqcEt4eVArSjJCNmdmWWF6RU0r?=
 =?utf-8?B?VGwydEJ6RGhDdmI0UHZhUUdiNzQxK0paekljenZPckZJY3V0NGRXbDM4eWo3?=
 =?utf-8?B?NXBVWkF5ZzVUODArQ1gydVRUSzdoNXdHU3hCRkxkVTdqZ2xwaTY1Rm5RV01J?=
 =?utf-8?B?R1FrZU1LUUtkN0tGOGIwbzNmTlB6dFB1YS8va3huRldaRFRMbkhuT05RRDRv?=
 =?utf-8?B?anVyRkZQeFlDOGpOQVNSN2V0cmpmVitIZTR6YkF1TVIvcUlaK2oyYndPMzAr?=
 =?utf-8?B?UnhRM1BOTDlkeXNtclVRcitvNUFEK0VubzJrUXZvSUcwL3hHTy9RMW5CSmh0?=
 =?utf-8?B?U3FhT2FOSXNCMEJERU1TbmNxR1BOYmdXb21FbGRwdFRsQThmVjhBS3A3cXBx?=
 =?utf-8?B?aFY4Lzk2UERlTXlZa1preG9tSXdMWVZ1MlV4TjdXbHdmT09KeldYSHFCSEU1?=
 =?utf-8?B?ckpyMy8vVmh4Z3MyQzZvcFN2VThJQ0ttVitkR1FRSldCVEhPUDVYQWw1bHZt?=
 =?utf-8?B?d1F2TlNLUnNvR0hiaFkxTDhyNVl0cnA4eWMwUFZOVmRGbDZhVzdvL2doamg2?=
 =?utf-8?B?bGZydzlBYVNoZW1qeFppcGU5Z3VGR3FFMkpEQnNoMExCVjNtc2wyWTdIaGhQ?=
 =?utf-8?B?YS9oZmhNR3NEeUxRdkxZMXdkSytyeDZJTUdncDdIR0hHS3paNC9KRmVuVEhD?=
 =?utf-8?B?ait6ZUE5dEhMS2dDdC9Hc01TVFdFTnpnRHh3YzBzd3lCTkVkaURBZXRnVkRj?=
 =?utf-8?B?dnp1N21XbWhTOHJiRGd0bWNCQy80YlNHM0dTUVkvajFqaVZhMENuYjQ3S1ZO?=
 =?utf-8?B?THFLcGxRN1lnbkhUeWlPeDI0Q1REQTF2QzcyZG52WjRwS21ISVo1Q1BVaVVx?=
 =?utf-8?B?Qi9MUUM3RHVMTk02R085bDNJWnJkUzRHV1pGcjYzMVBPU3phQURZNlRTU2c3?=
 =?utf-8?B?YUlCTmk4ZHB2eVFMd0d0YlNTSWpQRWxXMW9XT3VseG1CYmlQYk1aV2kxcHBZ?=
 =?utf-8?B?ZmRObS9UZGoyL2ZUanhlZGlYcUo5RzZ0T3JLV2wxZ2w5NGx4OVhBSHZoQXBJ?=
 =?utf-8?B?aUdKVTlkMnIvYVI2bDd4VW9iWU1hZEhOMSt3YUhhSGNFY0p6RDI4ejZZOTBa?=
 =?utf-8?B?L2FaSGZqbkdlNzQwQ2sxY3gyb0cyNkFURTFHNS9GejNDUnczZ3ROa2ZRUkpQ?=
 =?utf-8?B?ZzRZQTNvTEpBTndncVhrYklkcFhCeG8rQnlWd1NqMjYyS0p1dldodzVVTDVk?=
 =?utf-8?B?U2NPVkdHL2w0UC9TOU5oNnVTVHJLa0VRbjF3RVcrMlg2ejh3b3kzQk02QWZN?=
 =?utf-8?B?SVJYb2gzNWxLakFGaU1WdkZIQnMvSXBxNFc3Q2pzYUVhY09mTS84NzJiT2xK?=
 =?utf-8?B?dEZGYXlmQlBMT2U1R2dyN3kyM1IxL09ZNktDblJrVnhicHNINWhZN3pzdjEv?=
 =?utf-8?B?RUNnakpleVdUbXlDd09IQWQ1NnNGKzYzQlhxR0wxaXpSRktVeG9QUWZPL1JX?=
 =?utf-8?B?eFcwY2VSTGdkTHl2K3BnMlIvTlZPRnE4a0NWQnRFSE5wNmxhQzdjeUkyWnRm?=
 =?utf-8?B?Mjd3Z2ZxQ1NpK0VMK0xwQkFnWWVlcTJOd3B3bjIxMHMxRVI0S0FITTlLNzJy?=
 =?utf-8?B?Mk1ZeXlpUWN3Si9MRmhiNzc2ZGlzendpWmE0QkVUa1ZvekNtUWs5Q3ltOEpV?=
 =?utf-8?B?WXJ3NlVVem9PK1hpVUdMZlQ1d0JQNk9kLzBKblQrSHNwKzd5L2RKNzlnOVhJ?=
 =?utf-8?B?REZOSkFXLzUxQmNnb2l6RUVGZmhnVTRhSkVVb0t6Nmhpc0RzTU43VVRMZVBI?=
 =?utf-8?B?aFlEdHA5YU50ODNwOGFZNDRBazJwYU1sdnM3TGErODlHWmpJeHlUNGdxUmdJ?=
 =?utf-8?Q?fjXA=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8373efc3-38a8-4dae-0be2-08d9e250cbec
X-MS-Exchange-CrossTenant-AuthSource: BN6PR12MB1620.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jan 2022 11:24:50.0360 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kbB7ehtq89cRpd2OgkJGxPZsUVNhvZa726PgzHx3PYZ5Q906UKTpI4G7vjdB2Dhf
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4880
X-Mailman-Approved-At: Fri, 28 Jan 2022 13:39:02 +0000
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
Cc: "Zhou1, Tao" <Tao.Zhou1@amd.com>, "Zhang, Hawking" <Hawking.Zhang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>


On 1/27/2022 10:36 PM, Chen, Guchun wrote:
> [AMD Official Use Only]
> 
> Hi Jun,
> 
> In RAS code, we have this special handling for Vega10. Can you elaborate it please? Any problem you have observed?

Ok, thanks for review. I'll confirm this.

> 
> Regards,
> Guchun
> 
> -----Original Message-----
> From: Ma, Jun <Jun.Ma2@amd.com> 
> Sent: Thursday, January 27, 2022 7:47 PM
> To: amd-gfx@lists.freedesktop.org; brahma_sw_dev <brahma_sw_dev@amd.com>
> Cc: Zhang, Hawking <Hawking.Zhang@amd.com>; Zhou1, Tao <Tao.Zhou1@amd.com>; Ma, Jun <Jun.Ma2@amd.com>
> Subject: [PATCH RESEND] drm/amdgpu: Remove the vega10 from ras support list
> 
> Remove vega10 from the ras support check function.
> Base on this change, the ras initial function is optimized.
> 
> Signed-off-by: majun <majun@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c | 38 +++++++++++++------------
>  1 file changed, 20 insertions(+), 18 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
> index 37e9b7e82993..aa1de974e07e 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
> @@ -2129,8 +2129,7 @@ static int amdgpu_ras_recovery_fini(struct amdgpu_device *adev)
>  
>  static bool amdgpu_ras_asic_supported(struct amdgpu_device *adev)  {
> -	return adev->asic_type == CHIP_VEGA10 ||
> -		adev->asic_type == CHIP_VEGA20 ||
> +	return adev->asic_type == CHIP_VEGA20 ||
>  		adev->asic_type == CHIP_ARCTURUS ||
>  		adev->asic_type == CHIP_ALDEBARAN ||
>  		adev->asic_type == CHIP_SIENNA_CICHLID; @@ -2164,13 +2163,13 @@ static void amdgpu_ras_get_quirks(struct amdgpu_device *adev)
>   * we have to initialize ras as normal. but need check if operation is
>   * allowed or not in each function.
>   */
> -static void amdgpu_ras_check_supported(struct amdgpu_device *adev)
> +static bool amdgpu_ras_check_supported(struct amdgpu_device *adev)
>  {
>  	adev->ras_hw_enabled = adev->ras_enabled = 0;
>  
>  	if (amdgpu_sriov_vf(adev) || !adev->is_atom_fw ||
>  	    !amdgpu_ras_asic_supported(adev))
> -		return;
> +		return false;
>  
>  	if (!adev->gmc.xgmi.connected_to_cpu) {
>  		if (amdgpu_atomfirmware_mem_ecc_supported(adev)) { @@ -2203,6 +2202,8 @@ static void amdgpu_ras_check_supported(struct amdgpu_device *adev)
>  
>  	adev->ras_enabled = amdgpu_ras_enable == 0 ? 0 :
>  		adev->ras_hw_enabled & amdgpu_ras_mask;
> +
> +	return true;
>  }
>  
>  static void amdgpu_ras_counte_dw(struct work_struct *work) @@ -2236,6 +2237,9 @@ int amdgpu_ras_init(struct amdgpu_device *adev)
>  	int r;
>  	bool df_poison, umc_poison;
>  
> +	if (!amdgpu_ras_check_supported(adev))
> +		return -EINVAL;
> +
>  	if (con)
>  		return 0;
>  
> @@ -2250,28 +2254,24 @@ int amdgpu_ras_init(struct amdgpu_device *adev)
>  	INIT_DELAYED_WORK(&con->ras_counte_delay_work, amdgpu_ras_counte_dw);
>  	atomic_set(&con->ras_ce_count, 0);
>  	atomic_set(&con->ras_ue_count, 0);
> -
>  	con->objs = (struct ras_manager *)(con + 1);
> +	con->features = 0;
>  
>  	amdgpu_ras_set_context(adev, con);
>  
> -	amdgpu_ras_check_supported(adev);
> -
> -	if (!adev->ras_enabled || adev->asic_type == CHIP_VEGA10) {
> -		/* set gfx block ras context feature for VEGA20 Gaming
> -		 * send ras disable cmd to ras ta during ras late init.
> -		 */
> -		if (!adev->ras_enabled && adev->asic_type == CHIP_VEGA20) {
> +	if (!adev->ras_enabled) {
> +	/* set gfx block ras context feature for VEGA20 Gaming
> +	 * send ras disable cmd to ras ta during ras late init.
> +	 */
> +		if (adev->asic_type == CHIP_VEGA20) {
>  			con->features |= BIT(AMDGPU_RAS_BLOCK__GFX);
> -
>  			return 0;
> +		} else {
> +			r = 0;
> +			goto release_con;
>  		}
> -
> -		r = 0;
> -		goto release_con;
>  	}
>  
> -	con->features = 0;
>  	INIT_LIST_HEAD(&con->head);
>  	/* Might need get this flag from vbios. */
>  	con->flags = RAS_DEFAULT_FLAGS;
> @@ -2545,7 +2545,9 @@ int amdgpu_ras_fini(struct amdgpu_device *adev)
>  
>  void amdgpu_ras_global_ras_isr(struct amdgpu_device *adev)  {
> -	amdgpu_ras_check_supported(adev);
> +	if (!amdgpu_ras_check_supported(adev))
> +		return;
> +
>  	if (!adev->ras_hw_enabled)
>  		return;
>  
> --
> 2.25.1
