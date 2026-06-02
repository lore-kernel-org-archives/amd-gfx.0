Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2EAB5CD6E68
	for <amd-gfx@archiver.kernel.org>; Tue,  2 Jun 2026 12:58:19 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AA80C10F096;
	Tue,  2 Jun 2026 12:58:18 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="XMYRsk9A";
	dkim-atps=neutral
Received: from SJ2PR03CU001.outbound.protection.outlook.com
 (mail-westusazon11012025.outbound.protection.outlook.com [52.101.43.25])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 15D2410F096
 for <amd-gfx@lists.freedesktop.org>; Tue,  2 Jun 2026 12:58:18 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=D0jZjjjsc1yay13qaqvDrTSkPRXJPd85vzQFed0hvPowdRNq9FV4+dlyJpjZrAa8HwVJAqk6UptKA+sWktQ+39UHAkTf3jLDorj4NigXUKRlPjs6eyKoLMpLkl2FgjRFreLjTNqC5vaPpdu7ySN6+faCy4qIdQCVK8Z9zRJZi07gez0mAmKETQWZcgwozgqq76xpExngNYGLy8YO+bg5y7ONb8BI4gQ8VMatcioxNrggbn2CCpLULyVIzhneUj013PN4cp1f7nwJzV1a3OQN4XNsWBmRlyICl6VRz3QFC+jDegkqiqaenWJcs5AVC+qtEMsNgWOKG4n6MVTkYDv24A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AVYRH4rNgP/4WXG7jZyxOhQOjXJOX7iAsYGKinir3lc=;
 b=O8WVtSAiwJuITyCc5ANnwIZyDzSmbyLh7z2Pg9aPHzFBk+CJ/bJu3Qn2QhAGFCfX6wpzR4t0t+6G9EIQWP0e3ik0wZS5QoURqTvbGRCNlb1lyfwBJ9bHghQbdCP/QJ+TYiCjBImcvi7A/czlX/I7TpC7jJm6Jxp61DjF6LDY+64Ml1vVMS/KR7qAjqE6w1H2+hE7n7LMEpYQ2l3ejdIFZiY/Y89gpp6jQh0hiZ7RCARUtXstvCFiCK11WW2LaMhmSeM9zi6f+Q4pnQqEpeoPyuIiDZNx9vhqO5JWZisWJwiJhtgO3YOZviw+8zaRtxf7rvXY1SfOx+V3aS5I3xPUWw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AVYRH4rNgP/4WXG7jZyxOhQOjXJOX7iAsYGKinir3lc=;
 b=XMYRsk9Ad+0hemav8WLcBJ8m/hKvSkzsLOHrbzRxwQ12wzTExlhmhsrsmNEsQfqSrle7JtIYgZLvUMMhf02yt0pGUIo1AYsOmQ+kRi3PfeyCPzJD8Uf94ZQHg6J0zheFdSp62A6Uu5ZIMo5g6Ep/1wIphWVh6N3d2Vt2tMyi3/k=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SA0PR12MB7091.namprd12.prod.outlook.com (2603:10b6:806:2d5::17)
 by PH7PR12MB5593.namprd12.prod.outlook.com (2603:10b6:510:133::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.7; Tue, 2 Jun 2026
 12:58:14 +0000
Received: from SA0PR12MB7091.namprd12.prod.outlook.com
 ([fe80::ec33:1213:cfd8:63bc]) by SA0PR12MB7091.namprd12.prod.outlook.com
 ([fe80::ec33:1213:cfd8:63bc%3]) with mapi id 15.21.0092.006; Tue, 2 Jun 2026
 12:58:13 +0000
Message-ID: <6ce48a7e-40c5-429e-8053-c592208de31f@amd.com>
Date: Tue, 2 Jun 2026 18:28:06 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amd/pm: Validate OD DPM triples before mutating tables
To: Asad Kamal <asad.kamal@amd.com>, amd-gfx@lists.freedesktop.org
Cc: hawking.zhang@amd.com, le.ma@amd.com, shiwu.zhang@amd.com,
 alexander.deucher@amd.com, kevinyang.wang@amd.com
References: <20260529061710.356706-1-asad.kamal@amd.com>
Content-Language: en-US
From: "Lazar, Lijo" <lijo.lazar@amd.com>
In-Reply-To: <20260529061710.356706-1-asad.kamal@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MA5P287CA0139.INDP287.PROD.OUTLOOK.COM
 (2603:1096:a01:1d2::9) To SA0PR12MB7091.namprd12.prod.outlook.com
 (2603:10b6:806:2d5::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA0PR12MB7091:EE_|PH7PR12MB5593:EE_
X-MS-Office365-Filtering-Correlation-Id: cdd64d3c-c070-4499-9da0-08dec0a69b55
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|376014|1800799024|18002099003|22082099003|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info: ML2OqF1qlJDtEAKbK8b2z7sFVx0rNXjZWNuIzCO+fWjp2liscwpcLJ/J4+hgy+0IfOrWSSbKy2aFC1f/ZX8W6e6+ly/cMcciobs5TvCp98V77DijYrvCzLQuKQNfKWigPc4ryJFnNWl+d6gVR1qUFHUm1Xw6SJArRvFkc+DQuhGdLKOma6tvUrfMP+Eo+aUYuBoA3NXEtyKHSHD1NCmjN8KC8qivUYDsgv3NDnWaMgztLWW7/w/bfLCAnxkirhwF5aD3RXwp6MkOOtXCwJ3ZXxA+Qrf4YMT7L8K1SGjOYMR9bS0tdo+UxvSRMC37HGWCkRk+VNwcr0FuuxW2AXVPW6sSq72mOwjrZxBVoJCsBRSTJCXnx03WZZhK1E4ZSI8H6ro5BYgZLediY/MHaUfXkmY1vuW3zpLh2p3sNpPl0yy2V9HJa4GB9jVmTPHAlH694TpK06PDsrcnRG2TNefQ6c+sR4K2ZWASlw5i9Ipb02rnNAq8MGn1twssmTM4qBD3USm8Dav6NNb0J4ilmVoEa5+l8SrD3juqF8T9llBDbZKNu9pQbLZCucv3X+CujA87BtubZ6rQ746fZvBmjHKFbChH6yanHLD7pLR9Rg3zEMgcOlh4zMVOcm5IOQckFs4AkiCqOk/3t7RGtJdBxxN/zhnNg8a4sD5s/CrH5LsE9wZiMwCrW72KFFegjzxgFHUt
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SA0PR12MB7091.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(18002099003)(22082099003)(56012099006)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TjloZlNVYjhjTE9wa0lma0RpYm9DbGZnOVQvK3BldmZNYUZ6Tk0wbXFVek1L?=
 =?utf-8?B?VVpIWHZZWm9TZ3ZUaDdyQ2tZL3lxR3BZa0x4THl1TzdvcW5RdjhZRWZzZHkv?=
 =?utf-8?B?Q3RTa1FBVGg5Vi8vWTE4NUErdmxGb2liaGQrVkNjOXJROElGWDAwK1lhbmYy?=
 =?utf-8?B?cXowOU1PSEVGNy8yMHdMUFFjMTdXRUVTRC9ONDh4Kzk2RDZYRlMxQ3JPWG9U?=
 =?utf-8?B?MWw1aUVLV2gyaEk3UmNlNm5SemFsMFF4TTNKa0swTVo3cWxReExTdDV3dkpX?=
 =?utf-8?B?K2FpbDVqenQ2Z3VSRkd5LzlwSTlQdi9oUlVSbVROdXFLNmluMUJia1lyK1B0?=
 =?utf-8?B?S1NoWElNb1FxcmRtM3NtMzlPdFdZamFQcldqN3dtTDBTTVJ0RWNBZElMckZr?=
 =?utf-8?B?eURVa1RkYVFnUVFaQWl1MEZGUkF0NThkdWwyMml0QStmeUtkaDBPbXBXanY2?=
 =?utf-8?B?VHJBdEp0NmxMRjU2d0NUeVRveXJiZTlRTEZXeHZUODZ3TlBzNzY2REh2cGVz?=
 =?utf-8?B?YTRodXVUa3RrZ3cwVE1PZFlTZjlMWWhHUDlUTzFqY3MyazZqbFVQWmhBVEtl?=
 =?utf-8?B?Z3IvU2MyVDlWcU1rTkVPcHIza3BuOGFUb2VURGo5R1hkUis0VmxodUNaeG1y?=
 =?utf-8?B?NEc5eDJISDZQcFVjeUpGZWNob1ZHaU9tdE1aSmdMZ0h3UVQzTWZXR3hhQlFa?=
 =?utf-8?B?SVFFQk5ncnRseGdUT0NXNkR3dzdyNEZaT0NVN2o0VWZhSVJabno0RFBJSjRz?=
 =?utf-8?B?K1FrTHR1ZjdkOTlON1NublhZMTNRZ3lxTCtaQzRKdjVUNDMwelJaSi93V3lP?=
 =?utf-8?B?WUpXQ3Y4SmhabkRFSTZlaXBUTGhUeWNUODFubklTNHdBSE1ZamZ5VjF3T09R?=
 =?utf-8?B?Si9lVW05VWFlS3pWejhiMEVVeTVtRVlDTk1jZmpQQ29wcE9Udzhkb1JNeVJo?=
 =?utf-8?B?Z2NDMk82L1ZqdDBhNkJIaHprQWNBRTZMSHhkWHBTYXRMMzExcnB4RmtxMzNz?=
 =?utf-8?B?cFJuUDM0czhTUWNIWFdkVHVuTThxZkMrR3kxNjgxSTZpZWlLTEdZWjhUaDVw?=
 =?utf-8?B?NmxwclpPQjRFV3ZqeDFWdllSWXh1cUR5LzlPQVhxZ050VkJWNHJKbUZXem42?=
 =?utf-8?B?NlpHZk1Wd2xTb0tBZVdiYllCZkxJdDlVUHVBYWp4R0s4ZjgwVGNZUUFoNU1z?=
 =?utf-8?B?QzZxNFdpSjM5aWh6dyt4SG5XWXN5ZlpVUGNLejFoSlFnZzBjdzhRWlFuOTY1?=
 =?utf-8?B?c2ZDUENaNVVtL1o1MFI3aW5Yc1c1Q0p0ZWNrYnJwWklnWWtuaDVSNW5ua1Fi?=
 =?utf-8?B?TmZnbXU4VW9jYWR0aDFyWkc4VWtwUHJseEpSeEZCdUlIamlzQk9yaXBXV2VS?=
 =?utf-8?B?MG1FWjdOVllra0dDR28xemxGWTUxY0RxRWZSeERkdzBodmdCNUJtOTZJZkht?=
 =?utf-8?B?dkU5Qzh0Sm9xdTlJYmpNTGVKWFkvUFRDa1RPV2JMZ3I0QnlRdGE3QzYwU3U1?=
 =?utf-8?B?MlpzKzkwWTRObzUwdHdFcHlid3I2ZGZvK25OZHNZemp2RWxJUFYyTWxCcFM0?=
 =?utf-8?B?dUZkQXBzc0lpUndQRDByc0ZjS2lkOURTc2dkK0pCak5zb3VvL0F0R3lSRHZt?=
 =?utf-8?B?VHcyalZxUUJEUTErb2pwRml0ZDIzN3QwTFIzYnVOLzFDbWtlbFBuSFN1SDVN?=
 =?utf-8?B?OGgxOEdyaUtpQi9DZGRrejFkblk4bG9xM0orZUpqTFdrbldzZnBKU1FXZ0hp?=
 =?utf-8?B?M1F2MEhQQWdjR1FNL1lxa0c1ekNIVU4xNEp1V3pYWkJKV1QvQlRocThIVXk0?=
 =?utf-8?B?dzNwWHFGRnIxOW11bnpqdWpjcVRJQkF0UVFWNU9abWZVcGp5dHRWa2RCU002?=
 =?utf-8?B?cE5DRkcxVmU1d0ZCZjNSYzF5aHFGekI3ZHNSVFJldW81azNJMlo3azRZUktH?=
 =?utf-8?B?dkRJdklBZ0ltL3BMVmZyWlNHNi9nSjlBQTdxMHJkMXlrbS9qRlhDY0RUTFpj?=
 =?utf-8?B?eXZHa1Z6RzhIK2xVazU4dHM0ZThFWXdwdnVKZVQweWpJOWY5b2NsbVNrMGxS?=
 =?utf-8?B?NDZPeXNaNWRrL3llK2s4NDU4V2xJVVZ3WWRmcmpCNTk1dkRiUlptd1RLUG1C?=
 =?utf-8?B?QlZmTmVsUnNCanZnbWJUY0tWYjRzb0Vma3lqeUxPMFNDOUtzS2JML0xpQ21Y?=
 =?utf-8?B?Y29yeXlMVGVMcUtaVFlZVW9Kc1BwSWhiVDZUVVlvNis5VmVSZ1UvNzg2UG9O?=
 =?utf-8?B?VXJHVHZlK2JDN2s1WksxTVVybUxTQTJVMW5WSktmMDUvc0JaRFgvUmN5Vkha?=
 =?utf-8?B?cjhsb0ZybFllK2xOaC80OExkMmtDSnY5TzNIKzlzSlMyd2hNRW4zdz09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cdd64d3c-c070-4499-9da0-08dec0a69b55
X-MS-Exchange-CrossTenant-AuthSource: SA0PR12MB7091.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jun 2026 12:58:13.8765 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: O+SjOwCcMENj15LxTIoY+G7KCn6QLSXU8n4bSMqawtT+JnMeWHmAPVmv/DkbADYx
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB5593
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



On 29-May-26 11:47 AM, Asad Kamal wrote:
> vega10_odn_edit_dpm_table() and smu7_odn_edit_dpm_table() could mutate
> the live ODN table for valid triples, then return 0 after detecting a
> truncated buffer or out-of-range index. Validate all (index, clock,
> voltage) triples first and return -EINVAL on any failure, only then
> apply updates.
> 
> Signed-off-by: Asad Kamal <asad.kamal@amd.com>
> ---
>   .../drm/amd/pm/powerplay/hwmgr/smu7_hwmgr.c   | 33 +++++++++++--------
>   .../drm/amd/pm/powerplay/hwmgr/vega10_hwmgr.c | 27 +++++++++------
>   2 files changed, 37 insertions(+), 23 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu7_hwmgr.c b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu7_hwmgr.c
> index 416b9380a70e..0a74e4f98496 100644
> --- a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu7_hwmgr.c
> +++ b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu7_hwmgr.c
> @@ -5648,23 +5648,30 @@ static int smu7_odn_edit_dpm_table(struct pp_hwmgr *hwmgr,
>   	}
>   
>   	for (i = 0; i < size; i += 3) {
> -		if (i + 3 > size || input[i] >= podn_dpm_table_in_backend->num_of_pl) {

Seeing the same error print for both cases. May retain the check

> +		if (i + 3 > size) {
>   			pr_info("invalid clock voltage input \n");

Or, change message to 'truncated clock/voltage input'.
> -			return 0;
> +			return -EINVAL;
>   		}
> -		input_level = input[i];
> -		input_clk = input[i+1] * 100;
> -		input_vol = input[i+2];
> -
> -		if (smu7_check_clk_voltage_valid(hwmgr, type, input_clk, input_vol)) {
> -			podn_dpm_table_in_backend->entries[input_level].clock = input_clk;
> -			podn_vdd_dep_in_backend->entries[input_level].clk = input_clk;
> -			podn_dpm_table_in_backend->entries[input_level].vddc = input_vol;
> -			podn_vdd_dep_in_backend->entries[input_level].vddc = input_vol;
> -			podn_vdd_dep_in_backend->entries[input_level].vddgfx = input_vol;
> -		} else {
> +		if (input[i] >= podn_dpm_table_in_backend->num_of_pl) {
> +			pr_info("invalid clock voltage input\n");

An this one to  'invalid clock/voltage level'.

>   			return -EINVAL;
>   		}
> +		input_level = input[i];

Looks like 'input_level' is not used within this loop.

Thanks,
Lijo

> +		input_clk = input[i + 1] * 100;
> +		input_vol = input[i + 2];
> +		if (!smu7_check_clk_voltage_valid(hwmgr, type, input_clk, input_vol))
> +			return -EINVAL;
> +	}
> +
> +	for (i = 0; i < size; i += 3) {
> +		input_level = input[i];
> +		input_clk = input[i + 1] * 100;
> +		input_vol = input[i + 2];
> +		podn_dpm_table_in_backend->entries[input_level].clock = input_clk;
> +		podn_vdd_dep_in_backend->entries[input_level].clk = input_clk;
> +		podn_dpm_table_in_backend->entries[input_level].vddc = input_vol;
> +		podn_vdd_dep_in_backend->entries[input_level].vddc = input_vol;
> +		podn_vdd_dep_in_backend->entries[input_level].vddgfx = input_vol;
>   	}
>   
>   	return 0;
> diff --git a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega10_hwmgr.c b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega10_hwmgr.c
> index 8b8c4e899878..ad06a2f26d91 100644
> --- a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega10_hwmgr.c
> +++ b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega10_hwmgr.c
> @@ -5477,21 +5477,28 @@ static int vega10_odn_edit_dpm_table(struct pp_hwmgr *hwmgr,
>   	}
>   
>   	for (i = 0; i < size; i += 3) {
> -		if (i + 3 > size || input[i] >= podn_vdd_dep_table->count) {
> +		if (i + 3 > size) {
>   			pr_info("invalid clock voltage input\n");
> -			return 0;
> +			return -EINVAL;
>   		}
>   		input_level = input[i];
> -		input_clk = input[i+1] * 100;
> -		input_vol = input[i+2];
> -
> -		if (vega10_check_clk_voltage_valid(hwmgr, type, input_clk, input_vol)) {
> -			dpm_table->dpm_levels[input_level].value = input_clk;
> -			podn_vdd_dep_table->entries[input_level].clk = input_clk;
> -			podn_vdd_dep_table->entries[input_level].vddc = input_vol;
> -		} else {
> +		if (input_level >= podn_vdd_dep_table->count) {
> +			pr_info("invalid clock voltage input\n");
>   			return -EINVAL;
>   		}
> +		input_clk = input[i + 1] * 100;
> +		input_vol = input[i + 2];
> +		if (!vega10_check_clk_voltage_valid(hwmgr, type, input_clk, input_vol))
> +			return -EINVAL;
> +	}
> +
> +	for (i = 0; i < size; i += 3) {
> +		input_level = input[i];
> +		input_clk = input[i + 1] * 100;
> +		input_vol = input[i + 2];
> +		dpm_table->dpm_levels[input_level].value = input_clk;
> +		podn_vdd_dep_table->entries[input_level].clk = input_clk;
> +		podn_vdd_dep_table->entries[input_level].vddc = input_vol;
>   	}
>   	vega10_odn_update_soc_table(hwmgr, type);
>   	return 0;

