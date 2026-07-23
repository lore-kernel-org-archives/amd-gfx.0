Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 68469C4452B
	for <amd-gfx@archiver.kernel.org>; Thu, 23 Jul 2026 11:17:45 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E288E10E56E;
	Thu, 23 Jul 2026 11:17:44 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="nIS9if+a";
	dkim-atps=neutral
Received: from CY3PR05CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11013059.outbound.protection.outlook.com
 [40.93.201.59])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0F93310E56E
 for <amd-gfx@lists.freedesktop.org>; Thu, 23 Jul 2026 11:17:44 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Z/Zb5iCP1gY4yk5QCaUaZgUk2HLenuHSdQEF4MZ89TyfdD1s680JxCi7rWd9s7YIXGpfQvwbGZqF5rCN2WN3DqvaW7bqlSdnV9rGUI6AEZmS9uJ3ELk7FP+l0toso1AqtzM2yMVVJsraZEKMJKzt2KDD+F5XW1x+uBCxF99J2IOYYk39uZ8kfNDIARAxVH/IAa5vJQV+Eiuj23VKA0HwWbg95v6Xlgfuy15wrCvdrVrutUeZFa8MkIpFOl2+1YezaTwf4WXtGjU/FMLV7CY66Xtv1SOBezJtpX8VBCTtv4ln7RhmIp5iK3wvJPOLtPzbGXkrKGQcoO1FCwitFnUqqA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aBcrRLpesaT+op3wfnOhMAwanXfY639c2ripSd0Gxn0=;
 b=AoAHFqnOhpp01gHZVuaZJtMDIfi6+/Ww/cVQ5f17hKf8IYgveHWrw+vh20JyTU6J8Jl5Qb1Tz1jxsO2om8In3A/wiJ/j7j+jchrOTG8j4eXNatz+1O3W80qqV+o9ocGt9gJ1y0XjwS2qGm9T30OZHue7FLbUAmgFUvzg02hrehvXH/05HZo+ugMGI1dgiC5yp7YAqSuqImheoTY9ciQHEgsDTisrWaUL9hHdkcwfwLHM+7428ne0XwJuASDwv1wom3Qi79GohAxU8O4fs+MQ7M2MDtmG1pIJ6/0v6lev94LOiQ0EmBP+ZD/wcxVlscqgnGb8iuS7jIg9/sLqIdEvYA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aBcrRLpesaT+op3wfnOhMAwanXfY639c2ripSd0Gxn0=;
 b=nIS9if+a595t5QuDgxCa/YeQj7lDfo7glcdTShPu49gYXjkyJtO3l3UqsyYdkWWQtML2l1SIV98L5PMdejPidKVloHoZk793HdjVAS+VxKFw9hptqrjRL3LaXCNldlSp4psOPpyd3QOXewZTUUnInvUqB0jeEFAkIrwEepRv94o=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB7794.namprd12.prod.outlook.com (2603:10b6:510:276::15)
 by DS0PR12MB999290.namprd12.prod.outlook.com (2603:10b6:8:424::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.245.11; Thu, 23 Jul
 2026 11:17:41 +0000
Received: from PH7PR12MB7794.namprd12.prod.outlook.com
 ([fe80::e0be:f851:96ea:cf85]) by PH7PR12MB7794.namprd12.prod.outlook.com
 ([fe80::e0be:f851:96ea:cf85%6]) with mapi id 15.21.0245.009; Thu, 23 Jul 2026
 11:17:41 +0000
Message-ID: <c2a5fb47-d8b8-44c3-ab16-3538e7925fc8@amd.com>
Date: Thu, 23 Jul 2026 16:47:35 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amdgpu: ensure all userq VAs mapped before restore
To: Zhu Lingshan <lingshan.zhu@amd.com>, Alexander.Deucher@amd.com,
 Christian.Koenig@amd.com
Cc: Ray.Huang@amd.com, amd-gfx@lists.freedesktop.org
References: <20260723082334.606456-1-lingshan.zhu@amd.com>
Content-Language: en-US
From: "Khatri, Sunil" <sukhatri@amd.com>
In-Reply-To: <20260723082334.606456-1-lingshan.zhu@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MA5P287CA0089.INDP287.PROD.OUTLOOK.COM
 (2603:1096:a01:1d4::9) To PH7PR12MB7794.namprd12.prod.outlook.com
 (2603:10b6:510:276::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB7794:EE_|DS0PR12MB999290:EE_
X-MS-Office365-Filtering-Correlation-Id: cc86ffd2-acb4-4757-60ab-08dee8ac0291
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|1800799024|376014|366016|11063799006|56012099006|10067099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: 93HjQ/lREOcclsg5uYjGX5AQnj56+JbDExZuwlHLoOdUne4sdybYCqdx5DsH8pRrVy9DTXHZ8YzHLSFAC45g8RRsDDjQ9oLkZneTQCA4tUCNMvksXW0qm91526glTrXEoE6eBhWmkhLDEc2uSn/0yOFBuIVTJBcETEWm7HJutEWlM5q/ASw2KYobb9YmY33TcrEnSOQ3xXuDXuCe4w7TAudFP3odGtbbeHdfH7QKMGCafQ1ZY3Il/GgRK2AWFDolWfY23z9NrGDWKO+/krEhA1FmToq8i1rHeEjcgtK4C/pjXv9DAfGeatHUIbQZ+Vum2aMw6g4uxONLz48l58KUtgc4zG8trLB4NTC08+hGRhFc0TzpiFWr7KvYONTNV3H0RkTVov3x+sclmF2WW2ubt9dLQeZrz6V7mfMthVa0n53LRDoQp5oOvBV0bzLkgnbxdUTaGt501YrBwly9Az3HcqzzRrGI0N0SwPzNF8AXC4X/wD9mVoDIYTifpalD3qSmYLP6CNrCCuoq77oACMLgP97Qrbw/dmFba6y7xzAItMZHWNXzT55h7RK8oZEyCH5hq46G+/0+X7sdzwPSd5AbmOSLAlKqBGYtkcr3CS3pnQaeX6FktD+8CE+KEvSeh0tlwgZ2ush2rubfd21gSKRdEqHqJ43rxigbnUh2akotH/A=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB7794.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(1800799024)(376014)(366016)(11063799006)(56012099006)(10067099003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dWpSN3FTbnhGQm9WaDZnQ0ZraGJpbjgxZmpLTWwyejF1eTBuaDVuck4zRWJW?=
 =?utf-8?B?bnR1L1pDaThHWUtIRVR5V3JhUG05T3c2QlJ5TTJEYjRPTnlWb3E5eVpRZ0x0?=
 =?utf-8?B?OXhKdUpiR1NSMnpBdDNDMXRXUjRGVGhnTmJYanc5YTF4VEhOUnR6aHpZWXFO?=
 =?utf-8?B?L1hGM2N5YW85V3o4c3h1Tmk5SkEyWTYyZ0ZGZE93YmdBbWhUaXJCZExtRlEy?=
 =?utf-8?B?QU5yeE1heVBDQ1JsbnNRS0w4VHVmVWZQc0xaOG5xeDNHUGNkOXFsbHZKa2ha?=
 =?utf-8?B?c1Blekl1VXg1a0RlcENLVG5Wb2svYlF3NDdJdzhaYjBOUno3ajAyUFhYOHhT?=
 =?utf-8?B?bDIwSS9LL2s0OWFJaUp2REVWcEJpM1o4WmRvbk5aamtkeFQ0T3o4N2ZKT05s?=
 =?utf-8?B?QzVqVE9mbUI2WHd1VUdQNVl6WlBVT01KOTBUTjc3c1ZvaVZtcXNVNmVlaHBo?=
 =?utf-8?B?OFNtaTA1bjJqSWdqMnA2VVFYdTF4VE1FQTZXREJMaVltaGdrNFJVRjZ5NEpn?=
 =?utf-8?B?UGFYUlZTenNPZkFQLzBpSmJhd1hTOVk3dDNGSzFOMDRFZk4ralVhQjkzOVdo?=
 =?utf-8?B?OFo5VEFGTitwYnJtVFBqUG5sMW41eDVFazBMOEFkdWo0NS9lR2VNSk1Wb0Rp?=
 =?utf-8?B?UGtEWTJDRjF1bHFuT1E2VFhKSGZJNDduSUNlWU8wbGVwV09EeGdKOElPUDdv?=
 =?utf-8?B?ZXlLMlhMOStKUlI3cmhoUWNFM0VxMDM5U1oyOERlbnRKajJiZjNYb1ZFYUlu?=
 =?utf-8?B?Yk9RSlp2bzUzeTc2dVZFdm5xTHV6QmtlMVhMTTNmaE1mTUV4MjJSRFpSZFpJ?=
 =?utf-8?B?MVZ5dmVoa3FOTDY3YTV5UEd2YTlSenRzNzVBMFVhdlVVWHpldDlyU25QazlV?=
 =?utf-8?B?a1hmWVJTWmpJUzBUVFAvZjE0NUdOK0ZSejhJdW5pb2F4ekRaYmpGaE9mc3Jv?=
 =?utf-8?B?V1BhNGRQMUs2MUlSWVVabzFrN01LbjBJcEV2TkcxdVYzSWc5MTFyQk5CbkR0?=
 =?utf-8?B?bjZERVhzMCtiOUx6bEFCTW1ETEU4MHJzNmlZTFpsK0d4SXRBem1GY1FVRXZp?=
 =?utf-8?B?WEdFN2hsbUtYb1dMamF5QmR4eVJ5cEdoNzMzMW9RTVEwY2xtTkJQQ041a1py?=
 =?utf-8?B?bG1DdzZlTHNzWW8vMzc3WUxRTmMwbWtFVFNuNjVvamxSdThIajQwUk81Ujk4?=
 =?utf-8?B?L3RSK0JjTGxiYXV6N2FlYVFDTHZJSHlZN1ZyejJMQkVRc2dENjY2YzFRMS8w?=
 =?utf-8?B?TUJ3aFluWlRwN1hJT1NPQ3BYL0grd1VtTkxjMzNZckYzakdSMHBLQXp0Z3NO?=
 =?utf-8?B?b3oyK3oyTWpYdTk2QXhJTEkyMTRNL21TUkNmaWRFQm9vRVZqUkVmZklEU0hv?=
 =?utf-8?B?N2I2Z3g2a3BtYUphWS9sbU00aCtneVFlam83ME9ONkdXTWZlTnh1bWY0WnRM?=
 =?utf-8?B?ak51N2pQMjgrUTlXVDJ3bUs2eXFxKy8zQUhXdVZHNEc3YUEyZDRYNis5VlEr?=
 =?utf-8?B?SklHcm1YbkgwS1Q0aGdGdmxXaTUwUi84WDRVeU1nQmpmZzM3Z0NqaGYrMFlV?=
 =?utf-8?B?ZlZ3Smdqc2JVZXV1Wjk1VTJxNHdGdU9CdHh2YXY2VXBrNWhnZ3ZHY05Tcngz?=
 =?utf-8?B?MmlDOHk3OVRtSUJNQUdjZVEwMUFCK1JWVThvUXNnYzJYN09pUCtqdU5EcGhS?=
 =?utf-8?B?MHRIUmtEZGlzVnE5UUpEUGxVaHdMRldYYXlNZDM2aTV0UWlVMkJDTi9JU1V0?=
 =?utf-8?B?TFRTV1FoYkg4QWMvZTIveEd3dkM4ZXVJQzdEUkFYYkFNeCthRzZQYXZlNHUz?=
 =?utf-8?B?NzJxWVVUZVRVUmVpVjZRTlRhQStpMnpSelBORkNlZEE0RW9QYnVXY20rVU1n?=
 =?utf-8?B?c0VkNXpqdkp1VmpONjYvb3FSbXlJdnV4MmsrTi9RZDVDUHpQT1BOcjEvKzdn?=
 =?utf-8?B?ZU9seDBzVHhQMXlWZzY2Z0REbGpKd0lUUzlLRGsrOTR1NnBGUEFJREdjRXBK?=
 =?utf-8?B?WDBEZS9KRFpQSkJ0MU9ySmRaODl6MFdYbk5XQjVkSVBTa2lYRjRNVC9hOGRn?=
 =?utf-8?B?UGh3cGJCcklKK1dXRmM0RGlHczRZSzFsK3FpcjVRR2M1QWNSTVk3aUdQb2Js?=
 =?utf-8?B?Y2hHRFpqQStIRW1zZE5JalAyZ014R2RSNlhGVnc2VEMrSDZTNStreUN0bm90?=
 =?utf-8?B?VURDQlBMMTl5WTFoZXd6NjhBZXBLYjNyWCtkamNCUUZMcGJiLzQ5UVJ4MjJo?=
 =?utf-8?B?WWZLeUlZYm9BbWVVaDBoZWxKNm5qWWV3V1BsNU1ib2hWdGtVWUtwdTh3Y29v?=
 =?utf-8?B?UHFHR2FkdUptZ29ZUEtsdUpWREpwaFUwUTEzRmQyZVpXeFlHRjl6Zz09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cc86ffd2-acb4-4757-60ab-08dee8ac0291
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB7794.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jul 2026 11:17:41.3848 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: avCuuOtR4q6CLCrjh7h1h58xU5mhgNHsOptQNNtp1BoAREaGZiKY3TMlmeKtUzM+5LxcbRMfV7rGzhNKPsx+mQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB999290
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

Reviewed-by: Sunil Khatri <sunil.khatri@amd.com>

On 23-07-2026 01:53 pm, Zhu Lingshan wrote:
> amdgpu_userq_buffer_vas_mapped() checks whether all VAs
> of a queue are mapped before restoring it.
> So that HW won't access any invalid addresses.
>
> Currently, this function assumes all VAs are mapped if
> any VA of a queue has been mapped, which is wrong.
>
> This commit fixes this problem by examining all VAs of
> a queue and reporting false if any of them is not mapped.
>
> Signed-off-by: Zhu Lingshan <lingshan.zhu@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c | 16 +++++++++-------
>   1 file changed, 9 insertions(+), 7 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
> index 3fe10d6af757..2b3cb4ec4835 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
> @@ -280,22 +280,24 @@ static bool amdgpu_userq_buffer_va_mapped(struct amdgpu_vm *vm, u64 addr)
>   
>   static bool amdgpu_userq_buffer_vas_mapped(struct amdgpu_usermode_queue *queue)
>   {
> -	int i, r = 0;
> +	int i;
> +	bool mapped;
>   
>   	for (i = 0; i < ARRAY_SIZE(queue->userq_vas.va_array); i++) {
>   		if (!queue->userq_vas.va_array[i])
>   			continue;
> -		r += amdgpu_userq_buffer_va_mapped(queue->vm,
> +
> +		mapped = amdgpu_userq_buffer_va_mapped(queue->vm,
>   						   queue->userq_vas.va_array[i]);
>   		dev_dbg(queue->userq_mgr->adev->dev,
>   			"validate the userq mapping:%p va:%llx r:%d\n",
> -			queue, queue->userq_vas.va_array[i], r);
> -	}
> +			queue, queue->userq_vas.va_array[i], mapped);
>   
> -	if (r != 0)
> -		return true;
> +		if (!mapped)
> +			return false;
> +	}
>   
> -	return false;
> +	return true;
>   }
>   
>   
