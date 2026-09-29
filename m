Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DC42EC9832A
	for <amd-gfx@archiver.kernel.org>; Tue, 29 Sep 2026 05:27:37 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6BF7E10E4BC;
	Tue, 29 Sep 2026 05:27:37 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="mFvY1mNN";
	dkim-atps=neutral
Received: from CH5PR02CU005.outbound.protection.outlook.com
 (mail-northcentralusazon11012005.outbound.protection.outlook.com
 [40.107.200.5])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DAC4A10E4BC
 for <amd-gfx@lists.freedesktop.org>; Tue, 29 Sep 2026 05:27:35 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LPbdXBoG1g2l8cBi5eoIyh16pg4h8iKloI1Kt/akogG3A9KSzyc75fNsMMkuLPZaMaI0gBK/oDT+nQn6fWFHC8/LJ3n1SaU2olS34fakTM/6RkikNMxaGWfhXC65xwIKnnUzpzmQryxMXLgzRfKPu2OELZVxe9DTAjPJsH96qGwQoitdAXU7jK1MUvGxqn+Q+xG5MkbVrwpvbAj2MM6g5Rc78cnc7Y/mo2z8SHSRQ6KmUj9rZ0gjGMBWwXjsamm9Dcv9FZS8mNA25xdS/VQaQhmTHQuOEqWDJWw8VVcc40YOWGRkARci9AzMhbNym7UM7KY6w1q7/2oNQXKiXyi2Zw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rS/bMwcua+EgxIRJSmH7lNuR5exhFgE6s5+u0E152QE=;
 b=w4wPx/8ucZJc6huv6DMDUiHf59Rbz230sNo7xKLafihAAo7FHtaCJLR9jwmAurPXDTtKxAR9ZlPqkZ4ahlKs0uk43iELPi9moXimOHoNu5s7S2hRCnICm000I1j5tpkbNewB95341N541CqD7YNj0ESCyAu60E4XQ8OYRUWyk77KRFFhaOzLVuXOh5dyUbvytC87dY7X2Z7+WfL8FQ4ODjUzy6vYXFXxEIAcax3+l+djAua4CIMCUH6U30UN000ENXwS2MgDzXKu5zKAOn/Yt+GxyZRCK0H2+9L0yxuuV01RTSOsQ+VADHiSanLzvX0h8i+qiZURDyV37GC31BeEPw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rS/bMwcua+EgxIRJSmH7lNuR5exhFgE6s5+u0E152QE=;
 b=mFvY1mNNqC345RdxZN8focTALkU2NeiXFouSdojTy5zc5cK85l7vAhbNHKZD3P+eBXK9W/3eGM9g+49YJKU98KiyP5LTaKgJm52ZlyPwReRlXzaxbcFABpJTw9WvYvRfZEeAlxgaJ2n7sr6WrMpzxUgXQsHCcp2SzaeQPq+FFTI=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SA0PR12MB7091.namprd12.prod.outlook.com (2603:10b6:806:2d5::17)
 by DS7PR12MB5744.namprd12.prod.outlook.com (2603:10b6:8:73::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.24; Tue, 29 Sep
 2026 05:27:32 +0000
Received: from SA0PR12MB7091.namprd12.prod.outlook.com
 ([fe80::ec33:1213:cfd8:63bc]) by SA0PR12MB7091.namprd12.prod.outlook.com
 ([fe80::ec33:1213:cfd8:63bc%6]) with mapi id 15.21.0451.022; Tue, 29 Sep 2026
 05:27:32 +0000
Message-ID: <7ba82d6d-8cb1-41ef-a097-ec208bcdeef0@amd.com>
Date: Tue, 29 Sep 2026 10:57:26 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amdgpu: add sriov microcode init for MP0 15.0.8
To: YuBiao Wang <YuBiao.Wang@amd.com>, amd-gfx@lists.freedesktop.org
Cc: Alexander.Deucher@amd.com, Hawking.Zhang@amd.com
References: <20260924070121.2150251-1-YuBiao.Wang@amd.com>
Content-Language: en-US
From: "Lazar, Lijo" <lijo.lazar@amd.com>
In-Reply-To: <20260924070121.2150251-1-YuBiao.Wang@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MA5PR01CA0146.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:1b9::10) To SA0PR12MB7091.namprd12.prod.outlook.com
 (2603:10b6:806:2d5::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA0PR12MB7091:EE_|DS7PR12MB5744:EE_
X-MS-Office365-Filtering-Correlation-Id: c5086ca0-7900-460f-e391-08df1dea5c59
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|376014|23010399003|11063799006|56012099006|10067099003|6133799003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: RmHXqMJqE1rh7xMSU3pqRC43UU8Nvn4y+s0YyYuu1naW0QiSid5RoMibajlkTUJdK4bDYHHJUPlXOG0SVO8HOjuDvgho1gLnkdPqBtehdhlJAHEYG+xHSJgExUqBzq8AWrWqpS0HleT2Qna7jm2M969ja9K02+3NBXmeCodTM7pgnjA+luISEP8JtuMZPz7zDn5wD05c9OMIlkPLhXoenO2zq5doDZqtIRWEzclWV0j6p9OHw5Oi94lvuovI909ZmmHC7ZxIq+kB55aZZYvExNwAet9GRJ1492lmF3b6fPsWWap8hLQDMl3AUjpj1LlfIUZB9SGqsN+WWvOrMsiMcOpnnsFSOf1TjhQI4lh7Ycb0IlGV6J62I3riNqUrpizbjhzrgIvLjrKV0qdfkwgsaB6iYbTSTmMMTzLs9MrjBRI6QdUY7V4W625V1O4/GvKs1KRuHMdCs48rR6AaOHVuZCuNW2bhad+8/Ykl4oeLGE/zhC8q+AitJJF7vZ386eVecVNdajR08cqLB4wzv3JVx4kjAusS1NnaKxlFE2NhvvP0K4SMRpwh/0H8v4A//oSUQCb6TKdXdrkkbdVEU1Mmsh5KifbssvWb0re2DXXN1eyCB1VZ5ukmQeiKJVFIpfFI0W7Q6vKRsYtGauf+cAMl0JcZB8vaGM4RwYnrq00Wza4=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SA0PR12MB7091.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(23010399003)(11063799006)(56012099006)(10067099003)(6133799003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NXZ5MmRXUEd6aHgrd1dXa0pyVlV0YkRHRE5ib0lhaHg0TUNZbHR6NUNWbkho?=
 =?utf-8?B?UXVkZ2lMc3Vsd0RwczczREQ0MnlTSFFvenU2NFhVN3c0YUQ5eHFOaHlid2Jl?=
 =?utf-8?B?VWhMVFIvanIrS2lwRHJ6VittY2tvdllpdVRpZUNVdlk2c0JMRy9OQkJhNVE1?=
 =?utf-8?B?b2g4cU1JQWdFdXhyakhLNTloRjhvNFgxTldadDF1eDRIWDdOancvSXkwTUF4?=
 =?utf-8?B?SitqWUUrNnpaUFVCeWVkY2x4OVdhSUNhWVdMWVgzUU9Fck8wU2RNMU5jY1pL?=
 =?utf-8?B?Y0tiVVJpeFVSV1BkdDFaTGFuZGx3b3AwaXJhVGZoTDU1cDhMdWN3QkdjTmd4?=
 =?utf-8?B?ZWsvNnBHMGZFVnhVZk9YWXNpMHBQY25hUzNlL0J0V3A2T0V3SWdFMEJCNGFJ?=
 =?utf-8?B?VDEvV3k3SWFYek9TZnhnb3RXbGhRUlJvemN3VmZQYmNMUzlVVldjOTdzdkZl?=
 =?utf-8?B?bjlrMDg0VGljSUFCeC92QnlLWm5jT1M0K3dqNThRaG4xelF1S28wTENSRjEr?=
 =?utf-8?B?RlAxWGZoaml4M0N2OThpcFo5NzZnN1BKM0tGTVJzOWFQcUFwL2NvK0lka2pJ?=
 =?utf-8?B?dkpkb1NJaFBkWTdjeVYrSHRSSnFxcDNaTnNqRzhHcEFXMG5XWmdDZkFNOW1n?=
 =?utf-8?B?TTgyWkFRbktYcXYrL3Q5d1krMkt5ay9xTHpIL3R1SkVhZGduRE9aQU1abDlC?=
 =?utf-8?B?ZE1RdnNHUUM1ZTd1TTlzUGQwYlMzU1dKaEtpNTF2QXBsZEZJZnZvTUkxcVdr?=
 =?utf-8?B?Y1hLdU1WU1NpeXRZVG51SnNrMkdTMjZMeHpDUXZsSnZTdktjUjUvVElFQ0ZE?=
 =?utf-8?B?ekc5UVlpM1hzVnpyL2N3bE43SCtEaGV6bXBvMFExUXFGZWhLc1pqWHNlVFNz?=
 =?utf-8?B?bzhvcGkrMDQ3a1htdXlWUnF2MzlSN3BGZFRYTks5Y3hOZFJOZjlwelZWOHBK?=
 =?utf-8?B?alJPZUUvQm43QU1ZYXU0QVNnUnRGbXh3VkRQYWg3QVFPSnJ1RWs0ZFhybVB1?=
 =?utf-8?B?T2tVV09pZ3JnN0wrTmxGZlZwUXVvUEw1cjFZeGJ0bitNUXVEbS9Ua1pTK2ow?=
 =?utf-8?B?Q2JVaVBNMVJURVMza2JDOURxTmRlb3lEM1JLRlZYK1IyOWpTQzNXN2dxejVq?=
 =?utf-8?B?ZFpqclBvOVNIaVRESm5Sc1NtcW5NLzVhYmdVZW1RZ2YrVHYxSXI0VTN2N3Np?=
 =?utf-8?B?NUF3eWRDRTNka25BMnkvT0h2VHhEbjJiTVc2b25ERXNnOGlOMHNrdm5KY3dk?=
 =?utf-8?B?eWJpL24yaFBkSndhZDRUTWU5eEZKVG5ERm1Xa0JQdDgzMVZTbWJFK3k5MWpn?=
 =?utf-8?B?d1NvK0N5WURDemYyOFZPQ3A1Z1dQWEtsaG80RmoxcWdZRVdQQ0FCQXdvWC81?=
 =?utf-8?B?QlVYNW1GWTJjd2ZEcXJ6cGJBKzVCVmYxWUoyY2wzc2lPcDhIbnkxL2RKWDVG?=
 =?utf-8?B?VEtjZUtsYzRhbVVuRGdkc0ZkdjdBQ0VKb1FhUnBMNnNwTkdEMmN3STQ2alNn?=
 =?utf-8?B?ZWswVmYyUEIwY2wxMHVRY1dwZGJNUy96ZVdkYWVhNU5QYzB3RVMwYjFrc2hN?=
 =?utf-8?B?dWVrVURmTzhROCtFby9GNnBqSThLZkpPdGZhaVRaSEtxR2RMRCt6YXJ2NCt2?=
 =?utf-8?B?L2crdkpRSGVuNUJhajJnQzFvRnhIbmVpdmdlaTFIZE4ycU1rQkt0S2gxSzRa?=
 =?utf-8?B?c2xNTzQrV3ZxbUFqRFJUVlJ2RS8zSXRhZkpNdVB0V085TEZUbjhiT1JsV0hl?=
 =?utf-8?B?ZTIvcER5SjVnN3NQUk1CbnhkVjBvd1RjbCtrOTRYdGRFSFlES3cvT3lUdHBP?=
 =?utf-8?B?djdDVHBONlRvWDFuNjB3MmtRRkpPRnFhaGZQUlJJZ09wSmcwUUJSK2lrMlFY?=
 =?utf-8?B?czZKNDAvcU5tRzZRbUNEejNDRHFsY3g3V2hGbzdadjBacVBjV1kweHFRK283?=
 =?utf-8?B?SnZOeEtWN2xBTk1UaXhBKzhaUmxRUDRKSHVmV0E1TktFMHN5dWErSDhtM1lL?=
 =?utf-8?B?enZ3RHMycGluUEUyZ2hFMTVLTkRnTGpiT3haYk53blhoc3pHUVFiZkZjemV3?=
 =?utf-8?B?WFQ1bGVoL2duNnQ1Qy9OODBhcGJObWJON2hmWjhGWTE3d0cyR25zNzdnZGdo?=
 =?utf-8?B?cStOWHdSUFV5VEJjd2poRHRmNFdyQW1OT0NqUzBwbFh6S1ptYzdEbVRoeVFV?=
 =?utf-8?B?cnVYQW5PQUpNNkxYUHRmQ05LVUEzNmNuUXRLbk0zMm5VVVBhUzZVVkV3RWRZ?=
 =?utf-8?B?bGlHUVBPSzFIQ1VMZW1jSTUzZlJ5NWJSNENXejlGRjVDbVFTc1RnUkFOOHcy?=
 =?utf-8?Q?04QgZ/LIggAqwNZazN?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c5086ca0-7900-460f-e391-08df1dea5c59
X-MS-Exchange-CrossTenant-AuthSource: SA0PR12MB7091.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Sep 2026 05:27:32.2450 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4PVdghuOyVC8XsNuUIDBGXrUNnXh9bOOfQVZrFdbzjW0obbYuy2M7II2A/m59EwP
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB5744
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



On 24-Sep-26 12:31 PM, YuBiao Wang wrote:
> psp_init_sriov_microcode() returns -EINVAL for an MP0 version it does not
> know about, so PSP init fails on a VF before any firmware is loaded.
> 
> Add the MP0 15.0.8 case. It needs neither cap nor ta microcode, only the
> autoload trigger: on a VF psp_load_non_psp_fw() starts RLC autoload once it
> has handed virt.autoload_ucode_id to PSP, and on this generation IMU comes
> from the IFWI and is skipped, which leaves MES1 DATA as the last firmware
> PSP receives.
> 
> Signed-off-by: YuBiao Wang <YuBiao.Wang@amd.com>

Reviewed-by: Lijo Lazar <lijo.lazar@amd.com>

Thanks,
Lijo

> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c | 3 +++
>   1 file changed, 3 insertions(+)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
> index 66eb2f34cc0d..453aef42556d 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
> @@ -173,6 +173,9 @@ static int psp_init_sriov_microcode(struct psp_context *psp)
>   	case IP_VERSION(13, 0, 12):
>   		ret = psp_init_ta_microcode(psp, ucode_prefix);
>   		break;
> +	case IP_VERSION(15, 0, 8):
> +		adev->virt.autoload_ucode_id = AMDGPU_UCODE_ID_CP_MES1_DATA;
> +		break;
>   	default:
>   		return -EINVAL;
>   	}

