Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8DD4EF532E5
	for <amd-gfx@archiver.kernel.org>; Tue, 24 Mar 2026 06:12:11 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 29F3010E338;
	Tue, 24 Mar 2026 06:12:11 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="YyjoDPxu";
	dkim-atps=neutral
Received: from CH4PR04CU002.outbound.protection.outlook.com
 (mail-northcentralusazon11013031.outbound.protection.outlook.com
 [40.107.201.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0EF1910E0C4
 for <amd-gfx@lists.freedesktop.org>; Tue, 24 Mar 2026 06:12:10 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RpD3NHcFAfLYybYcqofvHRcmn6uI+tiDrySv0yvphhQ1kwnC+111AwSdBy/63ocRuU8DRZsbNsff3/oHyNzDHIjasq2xg6Dn7iR/dn9u6WQarYgu45vunq8Z6Xly/MES5YEye0pU87Lq+SaibuHzMH/W7zrN3a/7RDV4IQRqpibTaIHnqLz7jGkQ6CcyTEci7xXSCofXsA5IJvjXf0W81Tn98aMZOYsyQbVRuxjd2YYzZpLS4miQv5tCzLvXGxhbVndf3XZENc/G6+Szr0u/sT2fLpl4RMf45FJoNIBllKXg8IBaoIXIKxUfZwPRFNaWvPnRiXX7M36VQat41Kseag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=de2a6qnrqjSRgSdL6G0mfL0PtN77y1unFbUOxm9tD6o=;
 b=FP702rwLNoH+x5IUtQkbM9RsNdvrbv/7EXx7iIQOng4d40pi/ljiQvBbLuiZfrYu4XGZWnoE8tl5hxWb/WjLd4MoCBdov/0xUTbHoMs8P4d7RDFm0FPyYA8ow0UZ2D8jr1QQvpG8yejjiZLZSi1muTCf3RiiLZs4zXm0WfxvkjrGnVuyGNZIKuVOdaUsn4WMlcsspKfjxX5bWKlQX/dU532RDrS4Ay/4nWbe8qkGmYWzaxyfKl5ZtT+uv7L+2VqFsnNXHRDTlloYEyZfuA7cd4S7EtHTuQvILiWRwhZkEOoxu3/zdWBTNhVsgW/kwTOPhZG5SkUgQlTIV1b5P5DRIg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=de2a6qnrqjSRgSdL6G0mfL0PtN77y1unFbUOxm9tD6o=;
 b=YyjoDPxuA++rGz6za51sOrcFXRvFmv3Vwsaj3COuOXENhLY8KX8WiDUrdJ2p7Fu+oFE/fXnvE6aGtKRNImt2StvLX5uuxSi/SAHJ4PGHM55Xqpkg5f5/LdZWJvsJHLKzMx/Vu3JfXqL+DbvmvCyq0M+/yjlW/3VYwxWxmVCkSy0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SA0PR12MB7091.namprd12.prod.outlook.com (2603:10b6:806:2d5::17)
 by CH2PR12MB4184.namprd12.prod.outlook.com (2603:10b6:610:a7::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.20; Tue, 24 Mar
 2026 06:12:00 +0000
Received: from SA0PR12MB7091.namprd12.prod.outlook.com
 ([fe80::ec33:1213:cfd8:63bc]) by SA0PR12MB7091.namprd12.prod.outlook.com
 ([fe80::ec33:1213:cfd8:63bc%6]) with mapi id 15.20.9745.019; Tue, 24 Mar 2026
 06:12:00 +0000
Message-ID: <ec7369d6-8f6d-4c2b-bbd8-b43fe11a41e1@amd.com>
Date: Tue, 24 Mar 2026 11:41:53 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/4] drm/amd/pm: add variant func smu_cmn_send_msg() to
 unify msg sending logic
To: Yang Wang <kevinyang.wang@amd.com>, amd-gfx@lists.freedesktop.org
Cc: alexander.deucher@amd.com, hawking.zhang@amd.com, kenneth.feng@amd.com
References: <20260323231206.722067-1-kevinyang.wang@amd.com>
Content-Language: en-US
From: "Lazar, Lijo" <lijo.lazar@amd.com>
In-Reply-To: <20260323231206.722067-1-kevinyang.wang@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN4P287CA0105.INDP287.PROD.OUTLOOK.COM
 (2603:1096:c01:276::8) To SA0PR12MB7091.namprd12.prod.outlook.com
 (2603:10b6:806:2d5::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA0PR12MB7091:EE_|CH2PR12MB4184:EE_
X-MS-Office365-Filtering-Correlation-Id: 3926baca-a22e-4ebb-f028-08de896c4295
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|18002099003|22082099003|56012099003; 
X-Microsoft-Antispam-Message-Info: eGXq46KARDMTLctyUTLKelNo4/mIxhxDYhb3HD0cFFFErvJ8YlBu6fPYfaW5VuNCo1QBHFIsdISwFC6gaieccGZ4ocnVFJDlM2IwwvuBnEUSTg1vh99nYim0vZgYunr707ygJo3OkhHqtvbACyogkOYwiqIOLnj6bSQScxBDDo/tTGJRo+HBD9iZhWpZ6JPQn9nkIBunPbYswndiHOcTl0HIZw6zXzgULroNxDdBPxY+h1s+/lzVnxIBJcEWl03Klkh1roEOon2ygShUSnzaXJv3Fdkz48O3d2AeROw2TJ73phlvVIKeVvLsM88fxfN1CqPtbg2vbZIVoBBjljPQk3ifbxGyeUlgQQnkCI/vwyNDlDXsoRaZz6LkWz1U0lVvukFndqIhRQpN/+maefTu0CQ0rFf4S8464h5GijCbYzR0UqEciHS97vqvjZ/PUZ+i+wZYuElK0uzUjhvNQzm3vU49WjsTSbWQglKwBLVVZqWW+6hF+W42v1sywV5c6rfCO+alkbWP1Is81MH5Yr/t2ufQnW/LcaGpBG6wedBCYDkgdaII+7JL7FzT+23Ji6yGJ2KRoyPRbOJd63qECGPKumr2WE4NXgsjtuFpOQ5bXV/0YYFgvLU6DfZSD5JA6TT8IBHTA2WNe7bT74+xnLG5PNVf9SSmvmyzLOHHuxRBr2Y+ej3IOPCyb5q06LWYHm/V
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SA0PR12MB7091.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(18002099003)(22082099003)(56012099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?alRQM0pweTFGaUpTTmROQUhpeFY1S05iWmx5TFdWOUVVY0dBaWszS2xTcGl1?=
 =?utf-8?B?d3FoWlR6cXltUWZlVE4vWWJlNU5BTzJsQnk2RUo2TmUvWGo4Q0VKTjN4SFFB?=
 =?utf-8?B?bWlodHYrSUJmT3lub1J3VDNSaGlvRjBCY2hMTGQxMi9NUFg1VTk5QUxpMzlo?=
 =?utf-8?B?bXBlRHFFbGl2YTNIZmg1UVAwbmpVV2JKb2taMENSSTRlWCtOcndxV3kxZGFt?=
 =?utf-8?B?TnQ2RHdzeDVFNWcyQVZneTU1ZWxvUGVIWitwLzJEdU8vVFBSUUFlRnV4RnRn?=
 =?utf-8?B?YUhQNjBlNUxaTEczSnRVc1ZnTTBWOEp0OGNpT0MzNnJOaExEWFlQenZZekVZ?=
 =?utf-8?B?ZWpqODNTMHZqSUVmQTVoSFloeHZvM1JiRFNyZG5QWU9rQk5kT0IrL0E2MVMz?=
 =?utf-8?B?UWVITmpmOXhpWEFJd3Jhem9MU25uSWo1dFNKQjlxOStZWGNNQkxYNEVMM0E5?=
 =?utf-8?B?RjhHU1k1a3hEazhsRUxFSjZqSmZDL0RVZ01zRlZ2elNublRDK3Bwb1hNejcy?=
 =?utf-8?B?UlUwWjBZMlhqUzQ2b3p1disvWDJpd1Fhd014T0ZYeFN2Zm4reE5CbVBPazU2?=
 =?utf-8?B?aXRjbnc4K0VtQW5ieWJKTEJETkExUjcvT3pFUU1zZTJwa3RHaFZlb1p5V01x?=
 =?utf-8?B?NHhwWjRqSlBtb25NelUwQWoyTU01U254UnVGNE5GcmZNajhyUnNBSmhDL2Zl?=
 =?utf-8?B?clF2THFaSzVGckFNNUgwTFdkMHp1VWZNcTVMTGtncjhqSjI5SnZmVnJVTlZy?=
 =?utf-8?B?TTh3d2E1YlYzbXlzTFRhSStPVnpiTlFmSzlqVmtNWDlybzRIMHM4YjI1a0tZ?=
 =?utf-8?B?d2VYTk1kUVZKbmx0REVDbGMyeFFvemFBd056eUswWDJUSWYwVXh4bklsZ216?=
 =?utf-8?B?dUdtTTV0NU1MbGY2ZXl1ZjJhdlY5WllmTnhnWHJNRkp3a0VwNnBwR2d2c0Zi?=
 =?utf-8?B?Und4KzErUzhzK0xsZXlvR1FSWUpFdVRkbENoaEhkZTFXOFF5RkQvYzA4RGNt?=
 =?utf-8?B?ZlRPVUFjVkdCM2h3MWhrcE9GUGFEMURNWjZ0UFZMSm9WUnh4T05tWDhoSHln?=
 =?utf-8?B?TjRzOGFQcENlRkVYT1JTVlp3TC9FY1NTcjlYY3RzNGlRcExaQnV0c202UlhK?=
 =?utf-8?B?aVZ2SWxoRHhIMjMyQXRHdEpxdVNuLy9mR2Y4bVJWbklZcFgyWkRDZTFUTmRD?=
 =?utf-8?B?WWdkaGZ6ZDI3eHF2UStGODVaMm9JSjZqRDhKK3kwQW1td1NkWno0dnYwUzV2?=
 =?utf-8?B?bHJIZjdxWXhmNnVONm9UTkh1SnhoQ05SdjV5QldLTDFHRGJIdFNKU2JxdXNy?=
 =?utf-8?B?YkJjS3MzdXJ5TW42U1grc0dSSDB0S3B6NStkVDdGQTEybXFFb1ZyVjRzaElr?=
 =?utf-8?B?dDdMTEh3dXFxS3ZaajJ6dHRVZWNIVmpJbURhK3MxM0VCMUZ2cVZ3QW9Fc1NC?=
 =?utf-8?B?dC9FR1lKaUplWnVUaDlsOTRraW5JQUlZTmRnQm9DeGNnZ3hyRlJsd2xtSExh?=
 =?utf-8?B?dEZnTzUyUkFxdDhHMFlpZlk5ajU3VkNGcHpkN1BraEtIOTBwbEhPc21lQ1dy?=
 =?utf-8?B?ZnVPVENzbnh3Z3pXRmdXcXZvc2VSbU9jbGpYZ0ZjRVZxaW5nOTcrZTg1anNZ?=
 =?utf-8?B?S3loclFWZ0FlWFVFelhpR0ZEaTJ0Q2dQcVZYR2FHQTZDUkFYb3gyNWpCZGY5?=
 =?utf-8?B?Nk9RMFkwM0xKOW5PTWgzRHgwNm5tYzZEbHY1c2tqSGZITE1nWm5xYzd1WXZj?=
 =?utf-8?B?VWg1WG92S0IwZXFTUGpSZ1U2VnI4Snc1VVZDZDBUT0p3aUM3bmpzYkhLQVdi?=
 =?utf-8?B?UDZhYkoxM1NpbEpoV2JZcnhsRzlKMmVIVlVJZWxiQldmTXlRTm9rdlJkc2JK?=
 =?utf-8?B?OVJLRTliV2ZFU2xHWCtpcWdrMkhLb3I2MG03c2RubXBEdEZVc2ppUGlsTlli?=
 =?utf-8?B?T0g1Z3p3VlAxRjFiL095dHk2ZXFBU1p6U0psZVNkWXErVU9lWjY4Ny9Pelhp?=
 =?utf-8?B?KzFTcHlZWEo4cFhUN2hlZEhYUzQxbk5RNGV3K09MbEN5cUdBd2kxOHB6TzFI?=
 =?utf-8?B?a2Z5ajhoZ0pvelZsUmNVWE5hT25lY2FRemk3MDM4ZWY5VGdwVlAyL0xoRlB1?=
 =?utf-8?B?dng0YUIybFFSVXlZT1RUM2xPdHpRT3pyNjUvTkVzT1NHQ2hkeGpuMjBsSXlI?=
 =?utf-8?B?VlFSZzBWUXI4SUdyaFV3d2h0TzZxdUlBZ0puZXpjWEV2VWtDWEQ2Ymg5Mkg1?=
 =?utf-8?B?VFNHQmN3K25pOWpYSmhlZENGSGoxK0tCT1pZblp4RnM5bDFXajJBOGd2Tmdx?=
 =?utf-8?B?dzZ2K04zOHZ3WmFKVTBkb2xaL0l3cU5HdDlidHVmd00vRnkwNUVEZz09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3926baca-a22e-4ebb-f028-08de896c4295
X-MS-Exchange-CrossTenant-AuthSource: SA0PR12MB7091.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Mar 2026 06:12:00.3547 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CgsD81/LPp02Io2bpakOBNJVidaXmAIBuNa+fNDv7bXIWzEXccMUHxysL5ZAm0Tw
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4184
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



On 24-Mar-26 4:42 AM, Yang Wang wrote:
> add variant func smu_cmn_send_msg() to unify smu message sending logic,
> and enabling support for newer ASIC interfaces such as SMU v15 and upcoming devices.
> (support multi-param/multi-response, standardize code across all smu code layers)
> 
> The smu_cmn_send_msg() API will expand to the following prototypes based on the number of input parameters.
> e.g:
> 1. r = smu_cmn_send_msg(smu, msg_id);
> 2. r = smu_cmn_send_msg(smu, msg_id, &read_arg);
> 3. r = smu_cmn_send_msg(smu, msg_id, param, &read_arg);
> 4. r = smu_cmn_send_msg(smu, msg_id,
> 			num_param, [param0, param1, ...],
> 			num_response, [arg0, arg1, ...]

As mentioned earlier, I don't think this helps with readability of the 
code. This commit message has to be referred always regarding usage. For 
ex: if I want to send a message which has only one output argument and 
no input argument, it takes a while to figure out which form to use.

Instead, it's better to expose args structure directly to user. I don't 
think it's so complicated to use like this.

https://gitlab.freedesktop.org/agd5f/linux/-/blob/drm-next/drivers/gpu/drm/amd/pm/swsmu/smu15/smu_v15_0.c#L627

Maybe I've a biased view, I feel like it's easier to read this way about 
what is being done.

Thanks,
Lijo


> 
> Signed-off-by: Yang Wang <kevinyang.wang@amd.com>
> ---
>   drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c | 79 ++++++++++++++++++++++++++
>   drivers/gpu/drm/amd/pm/swsmu/smu_cmn.h | 22 +++++++
>   2 files changed, 101 insertions(+)
> 
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c b/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c
> index 7bd8c435466a..480d91d88957 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c
> +++ b/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c
> @@ -193,6 +193,85 @@ int smu_cmn_send_smc_msg(struct smu_context *smu,
>   					       read_arg);
>   }
>   
> +static inline int smu_cmn_send_msg_internal(struct smu_context *smu, enum smu_message_type msg,
> +					    int num_in_args, u32 *in_args,
> +					    int num_out_args, u32 *out_args)
> +{
> +	struct smu_msg_ctl *ctl = &smu->msg_ctl;
> +	struct smu_msg_args args = { 0 };
> +	int ret;
> +
> +	if (msg >= SMU_MSG_MAX_COUNT)
> +		return -EINVAL;
> +
> +	if ((num_in_args >= ARRAY_SIZE(args.args) || num_in_args < 0) ||
> +	    (num_out_args >= ARRAY_SIZE(args.out_args) || num_out_args < 0))
> +		return -EINVAL;
> +
> +	if ((num_in_args > 0 && !in_args) || (num_out_args > 0 && !out_args))
> +		return -EINVAL;
> +
> +	if (!ctl->ops || !ctl->ops->send_msg)
> +		return -EOPNOTSUPP;
> +
> +	args.msg = msg;
> +	args.num_args = num_in_args;
> +	args.num_out_args = num_out_args;
> +	args.flags = 0;
> +	args.timeout = 0;
> +
> +	if (num_in_args)
> +		memcpy(&args.args[0], in_args, num_in_args * sizeof(u32));
> +
> +	ret = ctl->ops->send_msg(ctl, &args);
> +	if (ret)
> +		return ret;
> +
> +	if (num_out_args)
> +		memcpy(out_args, &args.out_args[0], num_out_args * sizeof(u32));
> +
> +	return ret;
> +}
> +
> +/*
> + * NOTE: To ensure compatibility with the behavioral logic of the legacy API,
> + * it is required to explicitly set the parameter "param" to 0 when invoking
> + * the msg_0 and msg_1 functions.
> + * */
> +
> +int __smu_cmn_send_msg_0(struct smu_context *smu, enum smu_message_type msg)
> +{
> +	return __smu_cmn_send_msg_2(smu, msg, 0, NULL);
> +}
> +
> +int __smu_cmn_send_msg_1(struct smu_context *smu, enum smu_message_type msg,
> +			 u32 *read_arg)
> +{
> +	return __smu_cmn_send_msg_2(smu, msg, 0, read_arg);
> +}
> +
> +int __smu_cmn_send_msg_2(struct smu_context *smu, enum smu_message_type msg,
> +			 u32 param, u32 *read_arg)
> +{
> +	int ret;
> +
> +	if (read_arg)
> +		ret = smu_cmn_send_msg_internal(smu, msg, 1, &param, 1, read_arg);
> +	else
> +		ret = smu_cmn_send_msg_internal(smu, msg, 1, &param, 0, NULL);
> +
> +	return ret;
> +}
> +
> +int __smu_cmn_send_msg_4(struct smu_context *smu, enum smu_message_type msg,
> +			 int num_in_args, u32 *in_args,
> +			 int num_out_args, u32 *out_args)
> +{
> +	return smu_cmn_send_msg_internal(smu, msg,
> +					 num_in_args, in_args,
> +					 num_out_args, out_args);
> +}
> +
>   int smu_cmn_send_debug_smc_msg(struct smu_context *smu,
>   			 uint32_t msg)
>   {
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.h b/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.h
> index b76e86df5da7..5c14ed9ed9b4 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.h
> +++ b/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.h
> @@ -210,6 +210,28 @@ int smu_cmn_dpm_pcie_gen_idx(int gen);
>   int smu_cmn_dpm_pcie_width_idx(int width);
>   int smu_cmn_check_fw_version(struct smu_context *smu);
>   
> +int __smu_cmn_send_msg_0(struct smu_context *smu, enum smu_message_type msg);
> +int __smu_cmn_send_msg_1(struct smu_context *smu, enum smu_message_type msg,
> +			 u32 *read_arg);
> +int __smu_cmn_send_msg_2(struct smu_context *smu, enum smu_message_type msg,
> +			 u32 param, u32 *read_arg);
> +int __smu_cmn_send_msg_4(struct smu_context *smu, enum smu_message_type msg,
> +			 int num_in_args, u32 *in_args,
> +			 int num_out_args, u32 *out_args);
> +
> +/*
> +* The smu_cmn_send_msg() API will expand to the following prototypes based on the number of input parameters.
> +* e.g:
> +* 1. r = smu_cmn_send_msg(smu, msg_id);
> +* 2. r = smu_cmn_send_msg(smu, msg_id, &read_arg);
> +* 3. r = smu_cmn_send_msg(smu, msg_id, param, &read_arg);
> +* 4. r = smu_cmn_send_msg(smu, msg_id,
> +*			  num_param, [param0, param1, ...],
> +*			  num_response, [arg0, arg1, ...]
> +*/
> +#define smu_cmn_send_msg(smu, msg, ...) \
> +	CONCATENATE(__smu_cmn_send_msg_, COUNT_ARGS(__VA_ARGS__))(smu, msg, ##__VA_ARGS__)
> +
>   /*SMU gpu metrics */
>   
>   /* Attribute ID mapping */

