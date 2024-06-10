Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 09CC8C27C55
	for <amd-gfx@archiver.kernel.org>; Mon, 10 Jun 2024 16:09:58 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 67F8D10E07D;
	Mon, 10 Jun 2024 16:09:58 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="lp9JRTe9";
	dkim-atps=neutral
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2065.outbound.protection.outlook.com [40.107.243.65])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 642CE10E07D
 for <amd-gfx@lists.freedesktop.org>; Mon, 10 Jun 2024 16:09:56 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hXWadC/nW2ETgL7kFwA9DYvVohCkYcCBMrueDYQ/EGhqBIaBjHKd02VO0U/DtfEdDwQowO94/v7JA/7MmJK2DQPn0m1FcwPR8azWc7sRXHZ+iOf/aSh4lrDfzt+WxlVh3H14y0fjC+KEKgFSzZ/QaFSZvghf5QnlWpNF8U0Fq+RSVIKES0Gn8COv/hgbK+5gjnm1vADZXhsW+Gw7QplMz7G+h8z2n/pxoNZJNqh5Ec+3J4LoWbDrINg/AGwLgbDTEhCdAkm4iL1Qio+k0FAdibjuBvzF1YoCk1TuTmeyYyNaDkNETs+R2DwyPjolo7sGBBUmgLeIuemHXGrGPjKwKw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SAntHeESkWumaZvE+GJXzgj5ZjQz9PTQyEiqbKpoFkY=;
 b=UHJJdJgMpzWYdb36zp/B5FV3m6zkGqAvyGvQ0dAuxty9LDfMbp4wdvZFO76RikPaJO41WxMk8SRpaFqkpZ5AZ4hF2ABxnARdyfHE3sHLJoQsCw9SWpk2lsS7bLMjM36UbhM3+vq2WgfgQgr2dUplDT35iIr7zcdMBMQyNYe3hbRhJXZQZlKgGhN9yAsMYn99WT6RYKA/v19o0Cl0FdP2Y3y6diTGppOPaKGnV9IbPcFUndBRulXi+op65Zg/qrKSZOR0SsZ6iOm6JLl6nTjw7JuZzAZ3pm18bW9kJCdHwG9PgPYfmfIKP1n/VDit88abXqAwB8gBgaTev4hmF3ZHzg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SAntHeESkWumaZvE+GJXzgj5ZjQz9PTQyEiqbKpoFkY=;
 b=lp9JRTe9BmE7nBHCnwDqprZcdrO6wV9dnqFWWMqiplNZckSSFsXaHDkB2CvHKid8BiVtyN1BUATUzUuHf17SDGIljqVKwmfszG32hrANSyz6h2fEHVB8nT9xdLJmqlBC8IaA21WanvsXj+c4Kro3xmMjDl4el28FwUh7iXcbOec=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
 by DM4PR12MB8475.namprd12.prod.outlook.com (2603:10b6:8:190::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.36; Mon, 10 Jun
 2024 16:09:53 +0000
Received: from MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::37ee:a763:6d04:81ca]) by MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::37ee:a763:6d04:81ca%4]) with mapi id 15.20.7633.036; Mon, 10 Jun 2024
 16:09:53 +0000
Message-ID: <ab748027-5e71-4de7-9b33-23b532b2c416@amd.com>
Date: Mon, 10 Jun 2024 11:09:51 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] drm/amd/display: Guard ACPI calls with CONFIG_ACPI
To: sunpeng.li@amd.com
Cc: amd-gfx@lists.freedesktop.org, Harry.Wentland@amd.com,
 Alexander.Deucher@amd.com
References: <20240610155812.133865-1-sunpeng.li@amd.com>
Content-Language: en-US
From: Mario Limonciello <mario.limonciello@amd.com>
In-Reply-To: <20240610155812.133865-1-sunpeng.li@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SN4PR0501CA0037.namprd05.prod.outlook.com
 (2603:10b6:803:41::14) To MN0PR12MB6101.namprd12.prod.outlook.com
 (2603:10b6:208:3cb::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR12MB6101:EE_|DM4PR12MB8475:EE_
X-MS-Office365-Filtering-Correlation-Id: efecf451-e82c-4714-4338-08dc8967c321
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|1800799015|376005|366007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?NmVKWHZBeStZbU1hRTBKenJmbHFkb3UwOFlIWEw0aytqemFGYStZdW9OTmo0?=
 =?utf-8?B?TityZEdESWh0Sy9ZZ2hSVGV5K0dpanBDTzNkQXFCSE56MjdhTmFZdlh2MEs4?=
 =?utf-8?B?TmVyd2VXbisvb1g4U1VKcUlEbmpaMVVJRFJyeERxMFJrdUt2cGlKQ3BhbGkx?=
 =?utf-8?B?SW5aa0ljNWQ5TWZVWm84WEZ1TmJUOWxkL0dsb3lGc0tWck5FbzJ6ZTg2N0o2?=
 =?utf-8?B?ck9XOFArZHV1U3hzdzJXUU53Z1ZkRmNEMDhNVGhlUURnbHR3ZEFRRG55cjV2?=
 =?utf-8?B?Tm5CVXhXSG1zcWRodGVnNHVvbWsveVl1SjlsQkpjVk1xa1Z4SkVBMHJXMUpT?=
 =?utf-8?B?SCtYMHkyLzRzYzA0YlJBaVA3WXhOeklLTWVYL3VxQk5MOGM5TDFWMWRHaHdC?=
 =?utf-8?B?ZTQzNHVrRHZPbDlsclVHU2MrelZ5YmFwZ1QxZDRsczNFTjJsdzNIcGNyWHBs?=
 =?utf-8?B?OXpFOEJCdktDQXV2VTFqeFBIOHdxL2RRWEQwUytDZzdlK1hrUnIyVUQvTXdO?=
 =?utf-8?B?dmJiZW9lOFdhRXp5M2VXQmJhZjZvR0NPbmJEQ0JUZVdHa1dHNUpwTGo5Z1FJ?=
 =?utf-8?B?SXQ3MTJXc0ZVaG5HWkJUeGtaUTBwb1FMMEp6Y0R3RVNjcHpzYXdYUkl0NFFL?=
 =?utf-8?B?eDhhQ2ZlRzZsZUJVUXNncmMwVlVIajJPREJkQUszZDNSWSs5Z3JaTEs0N0J0?=
 =?utf-8?B?aFlqSGgvR3RkbHlCdndydGkwUUk0bXZwc21TMjhlK1ErK3BIVnRITllSdCtJ?=
 =?utf-8?B?ZXpMSzFSNWdRTTdqK0FBZUV5eFArNlBqTmt0anhQTjg5WHczWDJ3d2U5cHhN?=
 =?utf-8?B?aGNjZ05sTmVVa21VUVhBZElGUXRPdEIxcDBiUzVLU00yNm94ZkhLbkx6VXln?=
 =?utf-8?B?ZEl6RGlJUHlSTmphck1PeTU0aDZHQk43U0JudUg3NU1CU2o2OW81SjloK1Q1?=
 =?utf-8?B?ak1aL00ydHdlZmw1OTlBQ1MySGEwVFJ6TkNTRkxveDRuTG5yejUwYUtaelEx?=
 =?utf-8?B?SXVRMGQzU2RZMGYrM1kwMTNyT1piSERpYVJ4UnhybHFORVpEbmh5eEh5Mk1a?=
 =?utf-8?B?Y0tyeE9DUER0aTIyMFJqWnlsZTc1RmpvZ3VQZGdVNG9seS9PZHRpRjZHdTJq?=
 =?utf-8?B?K0Jtc2pEZXlUU0YvS1dUTTBpMnRwQ2Vad2VaT1JGSmdxNFNLSTdCUU5jMDBG?=
 =?utf-8?B?TjdGUUE5V3B6amFJTDFDMGJYaUN4RXVtSE9qV0FpaVNIa2loSUw0SjJuRmhM?=
 =?utf-8?B?NGdaWHNodzZQRStEd2xGSWovbnhBUmR3U24zK0htZmZjWXFrMjFYU3pzdHJu?=
 =?utf-8?B?b0xqYk45L2xnWERTcjVOckZ6bWllRFlHUEk2bnorRzc2R08yNWtBRGo0UHdh?=
 =?utf-8?B?L2NLSFRSbEhONnQ4WnJSUFJIUmYrZWZuc1MydWNERXlYUEs5cHhUQzNVak1H?=
 =?utf-8?B?WDBFdUxWUVVIVHAyYmxXdmJUSnB3di82MERhQ20rdkh6Z3pzWlJ6MHFDRVVm?=
 =?utf-8?B?Wm5pQm1waGpRMy9LeVVoZmVyQmlMYTUwRXB2RkZRZldhSjdLMGhMSENOU2pN?=
 =?utf-8?B?a1VsMnNqS3BydTNRMDhRKzFveXIybk94eFd6NzNSV3IvdE5oaEFRQnB2dTR5?=
 =?utf-8?B?cjlrNHR4ZEs3UmFtM0J0U3hhdjNkUHpyZFdjNk1ibDZvSmx4eE9wTXJhRnV4?=
 =?utf-8?B?TzU0VGY3K1NBcVlYdjFXbDg0Z3NRZmwwSURtTW5FTmhIRHRsWVBXV204OE5K?=
 =?utf-8?Q?IEF+OgOfzjmwaUF7TzRIpkXTrPUfhGilDVyYxm7?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN0PR12MB6101.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(1800799015)(376005)(366007); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZzFURnJ0UkJrYXFEemtISHNNUEMzU2V1NEdJTWJQNWYwU1pvWTJEOExRcGJ6?=
 =?utf-8?B?MXdUMW53QmhOVUdVenN3MG9CZ21nTUFBZlVWRUVsLzRaUk83YVdnM1BBVnl4?=
 =?utf-8?B?QjIxQWRxRjVVN0prMFlSMmNmUnpBTytzSHdUb1VQR0Rmc1pLbk9mT0J1N1BN?=
 =?utf-8?B?aTIyODZpTEt6UlluaG4wMHlQZWxhcEMzdC9GWTlmV2RUWHVER3A3M3ZxL3M4?=
 =?utf-8?B?cnFjb2V6a2YyQW4zUWUzOElKN01xMU1CcWRqRGh3L0w3eVRDcnZKWlhRM0RM?=
 =?utf-8?B?bU94K2gxeTdsRkVqYm9rRjFiSXVxVGNsMnF3MWhzVWwxQkU2b1dNam9NNVNz?=
 =?utf-8?B?bVAyVVRJajBjMVhwZElWSlhyQnN3SDJCak9GSW55NjBYaHBiNmV4U3hrY2Mx?=
 =?utf-8?B?NWlURytpNEIrRjFPV0l0UHZsbWllNWR1cGZYV3VkdGRkb1ZsYVJNUE1KeUxa?=
 =?utf-8?B?T3FXWlR3MUp2VUFKYnJMcGNCMHpYT3g3ZWwzNVdQdE9zZ0NsQms0djk4K0dT?=
 =?utf-8?B?eGQvYnlna1N2ZVlRd3VjNzhPZmsrODV1VndSVWJ2NVgwanY4U3VNU2paeEFy?=
 =?utf-8?B?dW5VNGE4anI5SFFWQ2l6aXFlaUNvdEdOeEJ1U3J5YWdGVWhPWUxuQ0gyeFFa?=
 =?utf-8?B?VUxlQ0tlSG9qVG9iOU1BZktFUk1tME9ZMFc5UGkydE5zcURYb3o3NDN1V3B2?=
 =?utf-8?B?TnNiSEt4bmZET0lQc1M0aEhqTVZORjNkUjBjOHpnbk5WMzF1bGtzMzluRkJo?=
 =?utf-8?B?R1BHbjRuVUdqanl5YUZlRlAzNFphM1VpN1FjRFF4djQwaUZiRDdueVVwaTJ6?=
 =?utf-8?B?NnUyaHUyMjROa2IwVWNVOFhuOElQQ2ZNV3M2VGxFRkIremdNd0V4NWt2bEJW?=
 =?utf-8?B?SlF3elpvQWMrU3BicHVrM01FL2YwNE9uK0o4MlJJQ0x2SzZvamVZTTlsZmtD?=
 =?utf-8?B?bE5jeGF0ZlpLOGwwVkdFaGZBR1hrczcxekxkVm5pWjZKMUprQmQ1ZHpYTTd5?=
 =?utf-8?B?a1BMM3drMXNFdkZwdFA5NFRyRERZZHZPRGQ4aytuN09Xc1NBL3haVmNaNUhD?=
 =?utf-8?B?eDBuOGthb2J6L01jVFV6bFM5eFVRT2tzcGUyK2wrdFJGbkZrR3VQeFQ2anlM?=
 =?utf-8?B?RnhEdW9jd0JKOC9CZ3ZIWkJCZ0RzMzhHT3ZmdEo5QU1sMEliQmZ0Zng1N0JU?=
 =?utf-8?B?UVhtc3E4SmhZbE5INElaWWt3ZFl3cVlHMDZFdDhxY2d6WmhDZ3FuSjg2UGtX?=
 =?utf-8?B?djFqUjBtTnZPaWpIUHgyUTQ5bFpDbTNJT2NHLzFVUElxY3gyanM1dUlrNnUz?=
 =?utf-8?B?NGlaemlDOXI2bHlDWE40ZnlsMXlXL2JxTlpmZjVuR3oyRDBtR3JHcGE3bkxU?=
 =?utf-8?B?Sk9mdGQwdkYyL256U1RBdUl2bEw5SWtBL1JFczhrK0JKcW0rWHcvWGhhYkVw?=
 =?utf-8?B?MHNIOGs2eXRXeUd5T1lhdHJXUk9DQTBPajdhZThnY0pnS08ydDVwSjNLb0Y2?=
 =?utf-8?B?L3l1OVA3cjFIeUpoelpyb09BTThjWFVQVVlCVTl2VE9ocmxLWEhvTThwa0NF?=
 =?utf-8?B?WW9YSU1TWGdoYllvZHVkL1E1ODFXY04yM2wrbkVReCtJRmZ4Q3Vyc1Q5bHRz?=
 =?utf-8?B?aE9jdHF3bjJJNUhFOGMvMVBPR01wa1pCSEpwMUNSUTJjeDBoWm91WHFNYjlu?=
 =?utf-8?B?anFhdHpINFpQenVtUjdDR3hJUlRJZDdEQUV3aG83Y3FCY0lyd1RRQXY2M1A1?=
 =?utf-8?B?Tll6bndrMWl0ODYzbTZYU3BVQmZ0REc4RlVScngvbnFSazBkbEpMdHIzbjd1?=
 =?utf-8?B?RGhWK0tlZlpYTWZScTdHbWN3Zk9tUzJ0MG5TRlJycUJBelAzTHg2ZW5BU0pY?=
 =?utf-8?B?dmNnVFBJbkRoSGFqNWc3Z3B4d21RajJqOXBiVzVrSjFJQWwxcVBzMjg2VWUv?=
 =?utf-8?B?b3RwTjZqWEhTTWFLcjdHY1BxWmVEL1prU1lFTGF4TXhnTHFLK1NQZkV3SHl3?=
 =?utf-8?B?S2IySDhDK0F0NkpBNk9uaU81OW5hREoxSUN6MTkwbFk4Ry9rbnlnS25TR3pP?=
 =?utf-8?B?c3VZRnZhOXNXTWtqSnRrUTN4d0svUGM2NXZKaElYdjZwSFFSSVJIb2s0dzJt?=
 =?utf-8?Q?RnsmS07PVAHf0JLovvUD6jkRc?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: efecf451-e82c-4714-4338-08dc8967c321
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jun 2024 16:09:52.9749 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dRKTrxkzhAtxxS9C+PFWsORej+uqWVaX6yW2MqhM0iwDpEjTM38JXCSSSnFOYK4qdY1iz1dyxxfW+fM/gXrNAg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB8475
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

On 6/10/2024 10:58, sunpeng.li@amd.com wrote:
> From: Leo Li <sunpeng.li@amd.com>
> 
> To fix CONFIG_ACPI disabled build error.
> 
> v2: Instead of ifdef-ing inside function, define a no-op stub for
> amdgpu_acpi_get_backlight_caps when CONFIG_ACPI=n
> 
> Fixes: ec6f30c776ad ("drm/amd/display: Set default brightness according to ACPI")
> Signed-off-by: Leo Li <sunpeng.li@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu.h | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> index 1f71c7b98d77..083f353cff6e 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> @@ -1576,6 +1576,7 @@ static inline int amdgpu_acpi_power_shift_control(struct amdgpu_device *adev,
>   						  u8 dev_state, bool drv_state) { return 0; }
>   static inline int amdgpu_acpi_smart_shift_update(struct drm_device *dev,
>   						 enum amdgpu_ss ss_state) { return 0; }
> +static inline void amdgpu_acpi_get_backlight_caps(struct amdgpu_dm_backlight_caps *caps) { }
>   #endif
>   
>   #if defined(CONFIG_ACPI) && defined(CONFIG_SUSPEND)

Reviewed-by: Mario Limonciello <mario.limonciello@amd.com>
