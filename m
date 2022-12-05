Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 305BDC4321E
	for <amd-gfx@archiver.kernel.org>; Mon,  5 Dec 2022 10:42:55 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 46C8410E055;
	Mon,  5 Dec 2022 10:42:54 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on20600.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7e89::600])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F0E9910E055
 for <amd-gfx@lists.freedesktop.org>; Mon,  5 Dec 2022 10:42:50 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QnO/UvshSMNnFUa/sNn7W9AEYs1N0fsawibPmcg7qU+YPqRiQhWnOrZa6ASjESvsSmflM1Ug5fYm2kppqOL8v8JL3BQsnh0AaExtn6xzPbKC5Hoff6SPcBjAQD/0ECWddYkVF0iuhZvdqoSj/Jll/Bj0gDtrblC9qAHEbLH04JnuGU5Ymr8TCrC0ToeFjm0eUB4FtIiPHJV1zmcdOOf/q7nbZW1Ecj7q+mXJQ1J0xj1jecBTLu4CSJ5ibUVdQ8VOGqG6tWhhd/zWj/qsjhjV+Dw4cexsBVuT5ssdS/4ofYPAAzOM7jaZ5KAYYBg+3ossQNjM4y09rqtx99YBtaZm7A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0+nKq8ZtL+38y/RlKf01NZgUZyt2QB6cqJisfmvVyMY=;
 b=U25x++IYPw1BbrBGIlQvlZPuoGDs3SKTvWf93FSeZDEJ8dqJ5s0poN7HFJ9We1Gm4ZG5CxUecfzlX32ggGW0hrLuFzJ1J4mk+lkYGfDgaIZu9YHO7aPnDGoNmOZlcLTMWj2H9NXp7OyulZzXoYm68qxjBQhcBmtfU4exaX3rHn15HOV5NGiPnahZ91FnTCF0JNoLk29RLAkNtbzR+eFd+mBu+bRebI548+H3rhDMGaJFZTQ0zzKRRA117PA9K0053Ms3d7xf+W+nytlwr5l8NTpOJH/hrSGlMPC6bQi/yRcOvwF+pj7WKEv/CVRlGofcS47pSrVTcmkIKz3vE0GZWQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0+nKq8ZtL+38y/RlKf01NZgUZyt2QB6cqJisfmvVyMY=;
 b=G/reqJnphZZOdzURGhZ7xggWj13hc0BmPuKEP/HrjNLuXtuomf9FuHLggjVirpiRakk1eU9POCsMidW1jyGisJ6ZmUDoy6ScE9mWbHu/1UF1tGt8iJ1Bljja+0euFhqf8j18vMV75uOYAc50RO5r4XmW2yXAeUCt9DULHvGoenc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN8PR12MB3587.namprd12.prod.outlook.com (2603:10b6:408:43::13)
 by IA1PR12MB6579.namprd12.prod.outlook.com (2603:10b6:208:3a1::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5880.14; Mon, 5 Dec
 2022 10:42:49 +0000
Received: from BN8PR12MB3587.namprd12.prod.outlook.com
 ([fe80::7d43:3f30:4caf:7421]) by BN8PR12MB3587.namprd12.prod.outlook.com
 ([fe80::7d43:3f30:4caf:7421%7]) with mapi id 15.20.5880.014; Mon, 5 Dec 2022
 10:42:49 +0000
Message-ID: <c040ed58-c963-cc55-59a6-33fd2e12160c@amd.com>
Date: Mon, 5 Dec 2022 11:42:45 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH] drm/amdgpu: remove evict_resource for sriov when suspend.
Content-Language: en-US
To: Shikang Fan <shikang.fan@amd.com>, amd-gfx@lists.freedesktop.org
References: <20221205084736.22864-1-shikang.fan@amd.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
In-Reply-To: <20221205084736.22864-1-shikang.fan@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR2P281CA0092.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:9b::16) To BN8PR12MB3587.namprd12.prod.outlook.com
 (2603:10b6:408:43::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8PR12MB3587:EE_|IA1PR12MB6579:EE_
X-MS-Office365-Filtering-Correlation-Id: cbe8ed41-174b-4430-cad3-08dad6ad73fe
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: IM62aNWya8t4DWqU9rInU2kPqsjOk0I50Xt+5GPZmDszS9gt/0xDXnl9pdEu5oCD5eGcLXOvUjOiLq4/67iibUP8aH7tfO98KvuR6DQDbeaEWrKXcbgW+JxMORxs61DNZPBQmN0FuWk9+t7orvoealrTMWzp11CzMUBsKgbMXtdtoigBTGVkcZ3onRasQ1VGUDiL4Y7HLrBpRME9DIRHuW16MK0cI3FnexgyMFPBCj5F2XzJnkQ3jhktP9UliKLmlykQ0XLZMjAkXynqkqSD60UlztD5YJZL4RwUgV6b4MNA2PjbJgaQmSyCU8P2O5UN4abxr2+jsuquOypCGY2SzPZDFbYDMyX1ctV5O1HTT/GHo0kHbuWMBr4v10Suc+ady9VA3INUCKSyjQ99dxv/81+lFftyTPJ4kGv5epznpsbW2LoyHOmsnHr5o92Ra9bgd3sRUy18jhKnY27P5zoSLqNvfqGvLC13KcRuegwwH+7lvxBD1Xd2Zi9llvxUE7gFULWJHhrwI8+gK2SEtEwDujC3Gf8p0TMBxlzrRT6l/HYmJTFi8s5XovS/vNulpWR6+k4WDdwjd2GhbSOqQZi5/oeSrKTm+SNdb/3MWB23r0a6mJwo9ijiN7BWvF/sGkpoGc7Sp/IakvEi5/NV62h9YTj4wDO8s114cbenEQqHWnJVaP34S9Nu8wBS1j+WKdJMfVrvWVxZ2Y+YDT9i5yTuwPrt8GLX+/BwYNCFRXTfgvg=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN8PR12MB3587.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230022)(4636009)(39860400002)(366004)(396003)(346002)(136003)(376002)(451199015)(36756003)(31696002)(86362001)(6486002)(316002)(478600001)(5660300002)(15650500001)(2906002)(66946007)(66556008)(66476007)(8676002)(8936002)(41300700001)(83380400001)(38100700002)(6666004)(6506007)(6512007)(2616005)(186003)(31686004)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cmNxeU9kdzVFL3VCcTlaTU9PVEV0eTc1QjNJTjNmZjBsRGVyaThsQWp6dGJr?=
 =?utf-8?B?Q1RpUHBFM3FxM08wMkkwZDhlejZOb3orajc3L0RKVmg3SlB3YzArcDFZYW1m?=
 =?utf-8?B?VFIvbmRGdEw4eUpOMjJZYXdZWW1JQk1tNGhIb1FTUkxlYmxIcUVlay9SUEdJ?=
 =?utf-8?B?MTZUMmhxVkprVjgrdGlKOW0rdkFpMFFXby93MHJMZzRyR0dadlNwZWpRZ0NN?=
 =?utf-8?B?a05YRk00VDU2b1pzZHF2Ty9XTnN1T1JmcXM1ZlF1QzF6cDBZa3JTb2RLVng0?=
 =?utf-8?B?K0FUR3BaY0lXWno2TTF5NHdNY2Vyb2lWNVdib0hBSlcvc25vdWxiOWNkVGda?=
 =?utf-8?B?akpPczFJbXBJdVNuY0JGbDV0aTd5NVhyVzBtYnU0UGQwVHM1a2hDSWJ2SytP?=
 =?utf-8?B?Nys4K3dueUpjbzlBZHZPam5WbUk2NDZQQUtGeWZlR2ZLTWx3ZzJmZUZ4VzJn?=
 =?utf-8?B?UUtXK01XZzIrV2FMbWFiT0RBUVdud2c3UFp0UE50OXFRb3lCSzB4alBnaVln?=
 =?utf-8?B?RENWTmFkaDZHOHNZVTNqSWp0QW9KZUlNZ250ZVpGTjV1ejVxZSsySHowSXlw?=
 =?utf-8?B?YVVmdGF4bXFkbWxiRHJVTTJ1YS9DUWsxS1U1QlNpYW1QZEZKa3NuNHpRNUxk?=
 =?utf-8?B?RmN4SVJrTVloUlpvUGRiWjBjVStqSlJMWlp3aTBXY2MwMGlxUFh0QXlwcmdD?=
 =?utf-8?B?ZzZ2VExqWG5ObjRMb2huTW1MVGZ3L3hORzc0WUQ3VXVOOHc0dFQ0TWtLSmRU?=
 =?utf-8?B?ZU1xaE5adVBySmthRXVDMytVRFVBd0pOcllCUysybHdIRHl4bTRIbWdkandS?=
 =?utf-8?B?MXFGd1ZMYnB6R2Zuc1VPamorakFvNGdIQmNEektONVZLVW5EMkFYQTFZZm9n?=
 =?utf-8?B?Q1B6cUcyZWpMSy9CUVRFTU5SQ3dTS3cxMGZPWUlaWGNXdjd3WUdkZjNGT05V?=
 =?utf-8?B?dVZQWExteHltNzhIN3YrMjdVZGhweXl1djFNR1FxZFoxdUF0ZDdVSHFGbkl2?=
 =?utf-8?B?TndXTkhvK1pNWnI0b2F6UXBseWRITUtWQ2k4Vm1pVFFtVlR2RkhFRHNldTUv?=
 =?utf-8?B?TlJRZmZUdzBNdVJxT3JpN2MvVmwraWw3elB0YWVNUDErTlJRY0hiOHJXSmhI?=
 =?utf-8?B?RGhUcnZhM3NHYUZXNlcyeEFlTGZGck9uTkxMaGNlOGRxbWd4R0JFWGlOckJ4?=
 =?utf-8?B?aEdrQ2ZuZmg1akN1ck56MzJHcy94V1RGYVNxYXNJSFh4MzF1Zk4zRW5POXRD?=
 =?utf-8?B?RUxubzhrTjdHMk4vQVdWTy9iMVQ0QW01dlBuTW8xb25odVRGR0NGZ1NiVWxz?=
 =?utf-8?B?N1VYMHpZbjIxbEtZVkNoeWs3M3E0YVNWSk4yTFVnUmZZdGVHNmRCc3psbHdn?=
 =?utf-8?B?dXJ2TW9rc2ZLODhYYkIvRHVnTVhWTS9qeUdOOUMzN25pekhyZnpPTTV0ekNy?=
 =?utf-8?B?K2JwankyaU03c1lMeWs4SG1ydjhrbkk0RTR1QVpnVkNnT3J3ZWFHVE1RSGVX?=
 =?utf-8?B?M2FVdGxZZW5CcWRBQ1UyTll1M3pQcGZwenByNjJYVStJc09QSkRjOWp3emJC?=
 =?utf-8?B?a05SOWpCcUNuNFRienhxT1cwTkxKM0VULzZVQVp5S3l1blpQcVgxT2pXc0pt?=
 =?utf-8?B?SHhNYlgxeEJqWlJDcU0yNEJ2V2Fjem5lV2wvWXZ1cTM4TnQ0QTY1eGRsZU10?=
 =?utf-8?B?L1ExTHlCR2hTZm8xeW1IYWV6Vm5XVzRHSjJZMlZETjV6dmwyRHl5aFJMK2lX?=
 =?utf-8?B?T2J6WlhqRnVMK3VCT0xBbmJySmE1YTcxVkVnRktJbm81UldiWnJlc0RzVDMr?=
 =?utf-8?B?OWs5SHQyQVV4QnF5akRLNDB0NldrTlZFSFdwSHE5MWJKZWNyKzd6ZTdER0F0?=
 =?utf-8?B?SHpPOFM5Yy9WZzFmc2VYWnFFZ1NHaDdkbW0vTlNBaENrRVhZSGQ1cnc3NFp3?=
 =?utf-8?B?c3JGVUxHSzRtRFRVTlUwM0xucWpGVWlsYnBVQ1hhdnQwWHlHZE45RUtkT0tO?=
 =?utf-8?B?VGRJWWFOYmdUK1ZlWUNYd0I2Tldibm41OUNhMFBFUnZvRFNVcXVWdnlsRVcx?=
 =?utf-8?B?d3ZOTXJMOS9YUDdiaHNEcDlZbnpUZWNJNFI1eWt4eDBJRlZpZkE4Z3BoWElR?=
 =?utf-8?B?QktieHpqYU9QdWhpQlRVVDV0eEs1YlpyaW1mU3U4cFFYUDA4aXVaRDB2SnhQ?=
 =?utf-8?Q?7JFTTHieN3rLH67ziW6N6EJCvVgXLB6K9jLTRl3ug11D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cbe8ed41-174b-4430-cad3-08dad6ad73fe
X-MS-Exchange-CrossTenant-AuthSource: BN8PR12MB3587.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Dec 2022 10:42:49.3079 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: a/5csUbLcTFn6W81rywbPimpQ1PZF9H8FAU9HibDWSwYL/hG6Qh2xmymTF6OtOBm
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6579
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

Am 05.12.22 um 09:47 schrieb Shikang Fan:
> - There is no need to evict resources from vram to sram for sriov
>    because GPU is still powered on. And evicet is taking too much time
>    that would cause full access mode timedout in multi-vf mode.

Well big NAK to this!

The suspend is usually done to migrating the virtual machine to a 
different hw instance. Because of this the content of VRAM is usually 
destroyed.

Regards,
Christian.

>
> Signed-off-by: Shikang Fan <shikang.fan@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 8 +++++---
>   1 file changed, 5 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> index 818fa72c670d..55fe425fbe6d 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> @@ -4135,9 +4135,11 @@ int amdgpu_device_suspend(struct drm_device *dev, bool fbcon)
>   	if (!adev->in_s0ix)
>   		amdgpu_amdkfd_suspend(adev, adev->in_runpm);
>   
> -	r = amdgpu_device_evict_resources(adev);
> -	if (r)
> -		return r;
> +	if (!amdgpu_sriov_vf(adev)) {
> +		r = amdgpu_device_evict_resources(adev);
> +		if (r)
> +			return r;
> +	}
>   
>   	amdgpu_fence_driver_hw_fini(adev);
>   

