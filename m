Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EAD3FC433EF
	for <amd-gfx@archiver.kernel.org>; Wed, 20 Apr 2022 04:33:28 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3748A10E37D;
	Wed, 20 Apr 2022 04:33:28 +0000 (UTC)
Received: from NAM04-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam08on2059.outbound.protection.outlook.com [40.107.101.59])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4192F10E37D
 for <amd-gfx@lists.freedesktop.org>; Wed, 20 Apr 2022 04:33:26 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jpC/BmfzE2+F4JBZ4fAzb1/ayMGAPPngN3areRcpX8SoJgNLsKd3sXTTEITeN/Jyh99RJNRPvCaw1NBeCFE6CHEyb/ICRK7fEVkPdqyFE6/8L9hJZpL8vWMix0FoY0OHeegJB+KLPBNSXnwVBj0Mve/pefmI5EIWa+1pdcGAJx6MTd8JZj2E4vO+ikHwuWEJVhT7EoxLA66I0PMSNSTO8Jk3HSE02iKIfn2kzNRscQVh5uVnYGVPr7g533Xu8PhtCOMadxwDz+P+J1inKLulw+ZMqWrVoIVssOYdbHI+ZjdNmShSUKUdEf2y9sh5uEfxc5GH4GvOqFrkPeHSfg63Dw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=baRaarVj5mdUncjxxmoj4o7hW/lIR1ywLYZdhED9BgI=;
 b=GSutHKKowtkUqgdWAUjgDBFAUOgJ0KXK+31KnaQ1HrQnNCNc84JxcxRjeUlFxUcmdEIsGYwvymeFsn/twq0TU9Zw2uRUdb7Faw/AvhYUu2QQ+qmotKatBfQYRUlY8RvNrkymIffaV17fm+WtNp8LVWV0L+dElNBg94IDxg17mPmJ/qod2LSaPnZFAfM+NOk8hfZhnjuUKer+gAoDPzrzJGJeNZr8BLeI40cZNV63DCwDUrAGVct3sojO9PDyAfObrLeEy5O8jfp8VdyCADelSbDZx85gLk/TIAYV1oIW8dZcqj1Voe8RnKG2IZm3Pp7M92/U2cUwjVbUhpMApk4HJw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=baRaarVj5mdUncjxxmoj4o7hW/lIR1ywLYZdhED9BgI=;
 b=FkalcqTOe9xva1sID89EbhYcY1Hl6Xcsn64ACj5Kybh8P4IioFIKfke+NKCveMpY9h3x2NQhWhSwFfORCfDxsziGkjw5LH1Vr3Ah1QmmaKyYufKuIE52yHP5kPxYc4icp/YHhpoe2ANZ7VwGi0I8q0ttRhvHGqxYgCRQN6OuXXQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BYAPR12MB4614.namprd12.prod.outlook.com (2603:10b6:a03:a6::22)
 by BN9PR12MB5195.namprd12.prod.outlook.com (2603:10b6:408:11c::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5164.20; Wed, 20 Apr
 2022 04:33:24 +0000
Received: from BYAPR12MB4614.namprd12.prod.outlook.com
 ([fe80::88f5:b843:e848:fcf]) by BYAPR12MB4614.namprd12.prod.outlook.com
 ([fe80::88f5:b843:e848:fcf%3]) with mapi id 15.20.5186.013; Wed, 20 Apr 2022
 04:33:24 +0000
Message-ID: <5f79e645-316a-0afe-c91d-33e57fdf9ca7@amd.com>
Date: Wed, 20 Apr 2022 10:03:14 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.2
Subject: Re: [PATCH 2/3] drm/amdgpu: add RAS poison consumption handler
Content-Language: en-US
To: Tao Zhou <tao.zhou1@amd.com>, amd-gfx@lists.freedesktop.org,
 hawking.zhang@amd.com, stanley.yang@amd.com, Mohammadzafar.Ziya@amd.com,
 YiPeng.Chai@amd.com
References: <20220420035317.4008-1-tao.zhou1@amd.com>
 <20220420035317.4008-2-tao.zhou1@amd.com>
From: "Lazar, Lijo" <lijo.lazar@amd.com>
In-Reply-To: <20220420035317.4008-2-tao.zhou1@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN2PR01CA0074.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:23::19) To BYAPR12MB4614.namprd12.prod.outlook.com
 (2603:10b6:a03:a6::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 420c7ab5-c9d8-434e-b59d-08da2286e80c
X-MS-TrafficTypeDiagnostic: BN9PR12MB5195:EE_
X-Microsoft-Antispam-PRVS: <BN9PR12MB519518C7D354EC47583A676997F59@BN9PR12MB5195.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: iMI5HVeRY/BW9FhuPWUYtyh0bm6ejsb6Pv76ZLOSI4sv5jueDN4BVkw7sMlKHEeNXsMATRBEbWXcBy3fooim0z4ErKZRM3qVuI5NU5UuqEISJ00yghsMyH2kaRUa/JNleVTpfvEOuFk5Hj0u5Tf4/uS2glXmteEHIlyaZl0pDhCJ3gX7zPOyCChxu6Y1kyBEm0hPk4E6N3vAwgwGvNR9ptzBqgzyI0v8lIhdp3vgq27hwx539SO69c1m08yYAtd3PcxE6gl10Eck4F1MdxRikXdzclW+v940N9gF0VYmHDQw2NH+LCpWW9tv0TALvmrpHGvI9BZZp5fk/yMcwK46ReOauWKrxg+frFG159fxN6luHSE5uqhBS9sQfOUP3qQz1AapER2rgzPCX78CdvupbJdPjlryDcQpNw5NklyL9KxzseNiwmPlSNWt3OmsfWtPjfXrs9l8aYDBKZUBZiQ3lnVBtj4LT2QVQVisXYu59tz4WuTAbpjDkS4K1cTQVV3vzEauhOC8B+fyNSQNAiSK7N4QcJdyCg6Cl5tunuDNiMK1Y+KSJeY3kGBfFqq6Ie18W6jixLu90aQEfO7w6P5bNcuQXv0EzV2Dtaf0GWZALV2N3Wql38Wyew1yjnFFOXy2sQcLrjdmGNoKfYKPo+i6Bw8HtJyIA+OiDZEluwADvMU8enhRxrRJtIfEdEx/BlLxDBC05kT6NgQ4+NZA8InkPyP67YhYy+8H2kIRWxtCJ5f33DHF+3FPF9PR7JRSWwqxP7kA/6OqBft2PdMltMchag==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR12MB4614.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(4636009)(366004)(6486002)(186003)(38100700002)(83380400001)(26005)(6636002)(2616005)(508600001)(6666004)(6506007)(6512007)(8936002)(5660300002)(66946007)(316002)(53546011)(8676002)(66556008)(66476007)(31686004)(86362001)(2906002)(36756003)(31696002)(45980500001)(43740500002)(309714004);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TjVzNEJNYXpORGhDVGdtc3F4K3VkYjlTNDNCSndKOEl1VDFEQW9uYlFsOThO?=
 =?utf-8?B?eUJxT09PMUF2bnhMb21LK2FnQmdKVUhUMHpqZ1JKMjk4VTEwb25qcjIzdXd2?=
 =?utf-8?B?VSt3UWJRK2ZoVHBBZnRFUk4xZlhYRENYU3JBbmxtODQ3OVBqT2kvSGZDWGgy?=
 =?utf-8?B?cVBZTGpBZjhDTm52Zk1uRG5DWEN1TktISjVOQjR5K1pjMWdSTklJS0FkWEor?=
 =?utf-8?B?UUZRQUtacGhOZlRpRHNjbHRYa2JtYmNEKzVFekN2QzlaWENkY2pmMU5DL1l4?=
 =?utf-8?B?Vmgxc3pYbzlIUzJQYnpuNnYrL1dKSjNvb2luVW9FRVB3RXhOMkZzSnlUS1l2?=
 =?utf-8?B?WEtyMUlRenJaR2JnYm43TVhTVU9mOXpMWGhuQWM5OGVvMVJaaU5nWFRvemZh?=
 =?utf-8?B?VCtyZWV4QlhaWmNqVGp1T2Z1TzNIZHNFRWR4cktPTE4rWWRxdUlrcVBhZWNP?=
 =?utf-8?B?dlk5dWFOMXo5NFZ3UkY4RGpuYTRnT0hSZjA1T3BaUktjUHZ0Wks2djdVL2x5?=
 =?utf-8?B?UkNmTVlWa0xVQUx3eFV0ZnY0c2k4cTJRVmlKbEhBUEcwUFdsbkovRUNLZEw2?=
 =?utf-8?B?aUNXVkx1blVSbmwrU3BHU1Y1MXVkYWxIYnVmWFBIL2lOUkY4RmFhRUExSzFS?=
 =?utf-8?B?RHA3SDU0bHJ4M3c1ek9vZW9uQkN3dVJvOXZ6UXlQZjB4Wkt1SnpDSkRld25u?=
 =?utf-8?B?aU03OVl0RHdtcjFGWUh4LzlkOVVCV29jRzhuQVBIaG5ZR0lQZU5NeE9FRlYr?=
 =?utf-8?B?WnhHQnZPYmh3ZU43QmRkUzhhWjUyVkNrTkdYdnEyZEhrM05zd1lmWSsydVFo?=
 =?utf-8?B?U3hwdGtCd1Exc0RNbURyeG1qd3ZWRFkvNkI5TlRCWGhTTFpITzRHT1h5V0k1?=
 =?utf-8?B?UTVVUGlyRVo1cmdheEVEZHBYTkZCTTN5M3BNdnRFUVBZcFdjdTJmYWtkNCtO?=
 =?utf-8?B?bTV2NmNaMEU3THlWUVhLT1VzODlHOSs2Z2FWUEVlN1M5bU1wUzRJcFB2b0lY?=
 =?utf-8?B?eWM4amR4bndGeW45M21OODUwNkFoREJzTGZ6WHVhUzhsOHdZSUJQZi9RZ0Vz?=
 =?utf-8?B?ZFlvTFpzMHNxTHB1bWUwNUJOT0ZCNUtjdm04ek5kS1BhZDl4bGZNL2VQZktO?=
 =?utf-8?B?TlhNWDNVWUs2REt6QVd2Y0paV011WWdkWU52bWhLN1BQS05KT2MzaTZBQUp0?=
 =?utf-8?B?ZkJML0t6bk9DaUszbDk2UDNhMm42dCszczFZdVZScjUvQys0bW81aDcvaVpv?=
 =?utf-8?B?Z1hxSnNPSzA3QTBUZ0JmU3dPQXdXY0RWWmw5TlU0aDBLOUs1NEwwUXBRVXRU?=
 =?utf-8?B?eTRoRmx2V0kwVWNBQ3FhbjZBLzJlOGtnM2RCSEd5NTR1enMxRVpqd21mWThL?=
 =?utf-8?B?MVgwVENUQkhaUjBRUFRwUlBFdkhCZ1BvaHBhQ2JBaE9waitmdkNpZjNkS3dH?=
 =?utf-8?B?TEk3QUI4TWdxeksyWll2R2VjMEtBa2Zwdzc4YkhrWjkyZDJLSTF5TUFRMnJG?=
 =?utf-8?B?WCt4Z2JiRUxIdDgyTkV2Y3Ayc1R2K1hEaWJuWkdveFBRWmNDdWNkZ1Arc3Vj?=
 =?utf-8?B?WjZRVTJOSFZMRWhTbE5mWnZlSmFNNXhDRFZaUWZIbFN4UWNDZkV6dytOU0ZL?=
 =?utf-8?B?OStwazNDcS9LTzk2ZHE5Y1N5TWYzbjBDRU1RbWVEL0I3YUdVcHR2MnJKZENi?=
 =?utf-8?B?cHFXQjkwNjNETGkwV1hQSVE2Qnc3dGVwZ1IwSDR3Z1dmTkZVczhlcEpGS3Zi?=
 =?utf-8?B?VzNoalNYZjZNNG9TaWlFZGxLSHcxTTVaSVJ1bVhPWThiYXU2Vk9mVjdIL2RF?=
 =?utf-8?B?OURJWUI5TmFKUnFyWWp1LzIyMGdUQ2hQT2xqMGh6Vmo4TTFwMDU5dGdnOTli?=
 =?utf-8?B?TE11YjdmWDQrYmJpRHhZY2pQWDlnMlozTkFZanJYMzgyZHdPMUN5TEJlTjFa?=
 =?utf-8?B?aFZDRm1uZmZpQ0lDNytDYWV6ek5Jd1lIem9OV1NSYXM1T1dqdS9tQmhaVUVm?=
 =?utf-8?B?bWMyUUhwM05CNGFMSzZzV2RsbHI0amhVcVl2ME5nc0diWFdDcEhFZkowUThm?=
 =?utf-8?B?dG1BT0huMzJOVHQ4RUN5Q1EyUWJ4VU4xd1BRMlQ0bCtmaVl6K3I2WHM4cm43?=
 =?utf-8?B?cXF5dm05REJnTU95VUZHVlBXZWE1UU1EdEVtMkdIVXlxMWk0TVBPZjJFMjR4?=
 =?utf-8?B?N0R4MmM0MTR4ZDVnd3dXVGo5cWRaenlXYUhOR0Z1SUZlZ3JVUXV1b2N6dUxN?=
 =?utf-8?B?OEpVS21ZcWFhMFhOcWpvNGVCTU9tbVQxV3Z4RC9wNE04TkVHOEMzNHoxWnVM?=
 =?utf-8?B?d1NLeUJ2V0YyVXR0ZExMb2lRK3k2ZVkwbVJkalo3NWtzWGxTMkM1QT09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 420c7ab5-c9d8-434e-b59d-08da2286e80c
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB4614.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Apr 2022 04:33:24.4049 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nWFMmzHLm1ccFazGfX5YnjvFGjT324QkEaP1uP3qRrp+Tlrv82tzT63DqY6bq/AN
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR12MB5195
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



On 4/20/2022 9:23 AM, Tao Zhou wrote:
> Add support for general RAS poison consumption handler.
> 
> Signed-off-by: Tao Zhou <tao.zhou1@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c | 43 ++++++++++++++++++++++++-
>   drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h |  1 +
>   2 files changed, 43 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
> index 2d066cff70ea..4bd3c25be809 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
> @@ -1515,6 +1515,44 @@ static int amdgpu_ras_fs_fini(struct amdgpu_device *adev)
>   /* ras fs end */
>   
>   /* ih begin */
> +static void ras_interrupt_poison_consumption_handler(struct ras_manager *obj,
> +				struct amdgpu_iv_entry *entry)
> +{
> +	bool poison_stat = true, need_reset = true;
> +	struct amdgpu_device *adev = obj->adev;
> +	struct ras_err_data err_data = {0, 0, 0, NULL};
> +	struct ras_ih_data *data = &obj->ih_data;
> +	struct amdgpu_ras_block_object *block_obj =
> +		amdgpu_ras_get_ras_block(adev, obj->head.block, 0);
> +
> +	if (!adev->gmc.xgmi.connected_to_cpu)
> +		amdgpu_umc_poison_handler(adev, &err_data, false);
> +
> +	/* Two ways for RAS block's poison consumption implementation:
> +	 * 1. define IH callback, or
> +	 * 2. implement query and consumption interfaces.
> +	 */

This doesn't look appropriate. Better to have one standard way. What if 
an IP has call back implemented to handle errors in non-poison mode?

> +	if (data->cb) {
> +		need_reset = !!data->cb(obj->adev, &err_data, entry);
> +	} else if (block_obj && block_obj->hw_ops) {
> +		if (block_obj->hw_ops->query_poison_status) {
> +			poison_stat = block_obj->hw_ops->query_poison_status(adev);
> +			if (!poison_stat)
> +				dev_info(adev->dev, "No RAS poison status in %s poison IH.\n",
> +						block_obj->ras_comm.name);
> +		}
> +
> +		if (poison_stat && block_obj->hw_ops->handle_poison_consumption) {
> +			poison_stat = block_obj->hw_ops->handle_poison_consumption(adev);
> +			need_reset = poison_stat;
> +		}
> +	}
> +
> +	/* gpu reset is fallback for all failed cases */
> +	if (need_reset)
> +		amdgpu_ras_reset_gpu(adev);
> +}
> +
>   static void ras_interrupt_poison_creation_handler(struct ras_manager *obj,
>   				struct amdgpu_iv_entry *entry)
>   {
> @@ -1563,7 +1601,10 @@ static void amdgpu_ras_interrupt_handler(struct ras_manager *obj)
>   		data->rptr = (data->aligned_element_size +
>   				data->rptr) % data->ring_size;
>   
> -		ras_interrupt_poison_creation_handler(obj, &entry);
> +		if (obj->head.block == AMDGPU_RAS_BLOCK__UMC)
> +			ras_interrupt_poison_creation_handler(obj, &entry);
> +		else
> +			ras_interrupt_poison_consumption_handler(obj, &entry);

Same problem - poison mode is implicitly assumed. Poison consumption is 
relevant only in poison mode.

Thanks,
Lijo

>   	}
>   }
>   
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h
> index 606df8869b89..c4b61785ab5c 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h
> @@ -509,6 +509,7 @@ struct amdgpu_ras_block_hw_ops {
>   	void (*reset_ras_error_count)(struct amdgpu_device *adev);
>   	void (*reset_ras_error_status)(struct amdgpu_device *adev);
>   	bool (*query_poison_status)(struct amdgpu_device *adev);
> +	bool (*handle_poison_consumption)(struct amdgpu_device *adev);
>   };
>   
>   /* work flow
> 
