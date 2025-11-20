Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CEB84CF8863
	for <amd-gfx@archiver.kernel.org>; Thu, 20 Nov 2025 14:27:39 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7169D10E2A5;
	Thu, 20 Nov 2025 14:27:39 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="IhTIB21P";
	dkim-atps=neutral
Received: from CH5PR02CU005.outbound.protection.outlook.com
 (mail-northcentralusazon11012038.outbound.protection.outlook.com
 [40.107.200.38])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CCC6010E2A5
 for <amd-gfx@lists.freedesktop.org>; Thu, 20 Nov 2025 14:27:38 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jYZL+Q4ea/hbSYW9TRb1aR7hE5iyEvJDk4nJyeDVpJlpRYlooaDCbs0+Xp2421IILyDgrQM/w1DXWgNLStlLpYiYShGh3hIiCRgpbZKESjQpMTTeheHFLYcfsNJ8OziSVrnWKFTqXpLFdi6nE6/HZ/2pCcbN0kqCqPDYggj5g8Qv8PkNuzmHg9zdx9gUO6aL+M30crakuNhgxYMq+Zk1Zssm+M9VZbI+3LAI4XohYV8TUKkHA7HDixvU95EWoYS1YvI6B1Xh2FDxldg49YKOaiC8eXtub46p68q4+Am7IGYOuCRsT/fz8r5L+jrDl8nxJ0jgZHxpMfSz5P7yrJggtg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=v56jQZxdUYkGElZloxDilOAI4K3PH1ASBQIH9XuLjiw=;
 b=KUofTrOprpJOXohlMpAQHkcGKTITwxzMNQ9goueVy8eYh1Ad+xY+dfrD7GionudYpXtzOIXZhSmeMkrYpBjn3Z4rbK28wfWFekvgn/tN8Al14YSBIqwYs1/VUr85fE9WRj6kv5MREJwKlxNFCyW1pFYGe6or56vC4wqiwfLKne0Wyiuarhd8TAv8JImCwECg6UrshTUbKsh4f9OTjS0mGvJLOa80dhyzQ2+eascdZlQFcSgUlzJhOQp1I184GJTEa2qpWAPJl1980ueYMvnJ5SWFsS+wD1rTgE9GCrpQ0fLNzOq0HpixUfEKfiPvWxX81jfMTg7Jn9oAPFZxB9lo7g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=v56jQZxdUYkGElZloxDilOAI4K3PH1ASBQIH9XuLjiw=;
 b=IhTIB21P36IMlxFIXEzGHX2VpH/kcJDDxye+ySnje8tmKnX1V34REue63S9y1rKsUtfrcUNqmh1NPvAssX5NXK3o/9cwCkw7lIBrdT4pww8MDZG1sdTPyR1L+iON8bXPkvzYEMEgsHx9QAoOy0x9nFFiwUJVHQyYwfYf9A0fl6k=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB6566.namprd12.prod.outlook.com (2603:10b6:8:8d::16) by
 SJ2PR12MB8651.namprd12.prod.outlook.com (2603:10b6:a03:541::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9343.10; Thu, 20 Nov
 2025 14:27:33 +0000
Received: from DM4PR12MB6566.namprd12.prod.outlook.com
 ([fe80::31b:5d31:8ba6:abd7]) by DM4PR12MB6566.namprd12.prod.outlook.com
 ([fe80::31b:5d31:8ba6:abd7%6]) with mapi id 15.20.9343.009; Thu, 20 Nov 2025
 14:27:32 +0000
Message-ID: <e041be4b-52eb-48e8-a210-65f088337a98@amd.com>
Date: Thu, 20 Nov 2025 08:27:31 -0600
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amdgpu: Don't send warning when close drm obj if drm
 device has been unplug
To: "Xiaogang.Chen" <xiaogang.chen@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
References: <20251117185257.1396940-1-xiaogang.chen@amd.com>
Content-Language: en-US
From: "Chen, Xiaogang" <xiaogang.chen@amd.com>
In-Reply-To: <20251117185257.1396940-1-xiaogang.chen@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SA0PR11CA0078.namprd11.prod.outlook.com
 (2603:10b6:806:d2::23) To DM4PR12MB6566.namprd12.prod.outlook.com
 (2603:10b6:8:8d::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB6566:EE_|SJ2PR12MB8651:EE_
X-MS-Office365-Filtering-Correlation-Id: 7eec8ece-4678-479c-445c-08de2840f172
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?M0lYRG14d2Nia055Yy9mM0JYTTY5bURuUzR3VURYL2NVenJMZ2psMSsxZGtu?=
 =?utf-8?B?M1Q0ZnI2aHZwaWhjdG5KaDcyTWd2dTUvVEJqWnd1aUpyeEZpYk1PRVFxdHJy?=
 =?utf-8?B?ejEyNG9NR1lqMGNrVTlCWGJwNEU0Z3JFR0pLZFhOVkU4dEVvLzFydHBxRjN1?=
 =?utf-8?B?cVRmUkcyNjg3b0g2eVRwUjZKei9JVkpBcVZDaXk2R3FWYjA2OWVOakw3RE9S?=
 =?utf-8?B?NndYNEdoQ0g0QW8wam95TngzaFd4NDB5QVBla1BVRm45NU83YTd5TmMrNHls?=
 =?utf-8?B?LzFtWmI4THU5Q2gzYVVsMUdMZEVlL3EyYjFlWDFrM2VlOGc2UEFwYmcvNU1Q?=
 =?utf-8?B?UU9vdHlQV0IrYnpxKzQ0aC9uS2RPVXZJYytoODZKdU1HM2JqYXVVemllSmJ6?=
 =?utf-8?B?U3VLVGwvSzlKL2xmakM1bTIvZU5kT1dUa1BTaUZpMzFQMEJtMjI3WDlCdVBS?=
 =?utf-8?B?a1pnZDJya2UrNE5xdHlERnpHU0N1a3pUdjZ5ZlRncnZDa04zVkxraGtoQnk3?=
 =?utf-8?B?T24xZEhQVmpVQmV0L05paTJsTUFmL2x0eXlGVTExYXdxWkprZ1RBdUphWXRw?=
 =?utf-8?B?K09jRVdnOXpqVGJIcHU2OVVwY1hraFBuYXc4aTRBNFhHRVlKTjB3dTRnZ01v?=
 =?utf-8?B?TEhPT3JXbk9BVUtsVTdlN1dRcTBKdHBCMjJaWktNeE1hNUlXbTg2ZlRXazBT?=
 =?utf-8?B?bllaa1lFbDdMK3RURzlrZExWU1dheHhidmRnaGZXSDRMM2U1cm4rZ0hUMmUx?=
 =?utf-8?B?ZWhuZTduOFFuaWlZYk9tdjZudE1MTUFDcWZ5WGVIR1k4R0RJb2x0ZWJ0TXdG?=
 =?utf-8?B?Z0k3WU5DK1hkY25kb1c1WTBFQ29zL3lVMWxUWXJzRUpiU082dllFeDU3VWJw?=
 =?utf-8?B?MVo0Ri9GMklJLytwN3hRMlpuU2I1RWxLbllTR0hucHZsZXV5WVpqNTQya1Jv?=
 =?utf-8?B?UkdZRm54L3ZuTWp2SVpJL1BQOU1zNmF0T25wOE1sNDFIanV3K3dKV3F4cExZ?=
 =?utf-8?B?V2MzV3k5WXVLa0VZRnNhSzZ3dm0rc0FkK0ZJWjBSUDMzaDloaVlOekFGYUs2?=
 =?utf-8?B?SkxlRHNLTzNjY05xMFhDVHYvWHJ3V3ppcklNMlJGS3JGYk1tbk5BTTAvN3pR?=
 =?utf-8?B?ZWZSSEd5QUdYOWhkMU5FcG9rVzg0a0l6bWtWVzJtSUtLamlwdTFnWWtWNE16?=
 =?utf-8?B?VXV1bDRJRnBQbzJEMzFEaDNsYzNDYmpPRzRMQllVQi9jbTU4MmpIZ3EwMlBM?=
 =?utf-8?B?bzN3cnlqWnh1SEdTWDk5N3NQQVRwMmEvQzZKMmM1bHkwbkVLY2N5QkN4dTZk?=
 =?utf-8?B?TDdKTGFTMFhsd2R3OHNNRm5FdkRSV29aNDgvMGpwbDU4WHlBK3hmdmFoUEdl?=
 =?utf-8?B?TU5ZSVdIc3BNZW9nckVIeS8zeXYyUGw4SlZ2MzlCNmloejhvUURHQ1dSQXQ1?=
 =?utf-8?B?NC9teEFkUVQ5RmRXZ096U3JKUVg3QlM0OXQzMGM2cEJNSWRJUGloVWJkTE9E?=
 =?utf-8?B?bkNoNVhIQ2dQUXJ0SEZsdzg0ako0MnBUdmorZmV4V2d1cFhEZ0R1N1EyaXhZ?=
 =?utf-8?B?NXMwUkp5WU1kaTQrTy8zM2JlaEhqQzdWSWRmR3dKTnh2MzdQRG13TmpzcU9K?=
 =?utf-8?B?TElpTENnMTc2bmFHZHFMRzJrM1MwNkpEekdKNGl1QXpPcTBuVFVQYXpSdVYz?=
 =?utf-8?B?aXpWcHlkU2NUdFlzdVMvdnNra1ZnYzRkYm1hWVdUSjRMUVYrZ2FPVGpHaGk4?=
 =?utf-8?B?bHNiRkdIK1FESTRoc0ZEcGFuZGVPRDBjVnpZZDRJa1ptTXI2UHJlNDlFekJQ?=
 =?utf-8?B?b2c2WEhsS0R6Y1RIZFYrTHk1UmRGK3hud2pRallKK2g1MU1TdDltcU9UZDNJ?=
 =?utf-8?B?WmRpQVJTcmVpU3laeXpnK1d2KysvUFJFR2cvaWlvYzNsazg1YjdnUXpHZjFa?=
 =?utf-8?Q?ifob1+eoqYxXZiaotWaFrOeYh710qUzz?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB6566.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SFFSb3pWQU9nUkIwNXZtb1NEMC9VRjVrZnFyZWZHSFFUam5wLzBJMitvcnJH?=
 =?utf-8?B?akh1Y0QxL1c5Y1VWWDZBN0hIZWJLSzl0bDc4dG1wYkxGR0lrYWpFSk5sdE93?=
 =?utf-8?B?Wk1LajZUVE9XR1kvQ1BmMWV5QkJIMVJFTjRraDkvd0hyWGR3UXNEMWlwMmN0?=
 =?utf-8?B?dnkrQlFaalE3bTVCTGcvcWVoRDVWTVJXWlNlNStHVFo2UHJNYisxd24zR2RX?=
 =?utf-8?B?SVVlb09DWXQ2cEVjczluT0tiemY3VTZhZlNkbFFRNzVrdE9qRjk5dEFST0Y4?=
 =?utf-8?B?R2RZMXNDTnY2aktKaEZFRzZ2R1orM2p6TWZFS0k0MUY4bitPZnNiV01mT2RE?=
 =?utf-8?B?UlNDWEdqYzNSOC82eTdWRUZrUDMwM2s5VVVHenVQVm1SSVFOUlI0TDcwVzcy?=
 =?utf-8?B?T3JLTDJFRy90c2d0cmd0U2FBdVBwbDlHU0hEZjVxTHgxZ05oaWY3c0IveE1y?=
 =?utf-8?B?eTdVM3JUdy9EaVpGcURLUm5DOERIQnV6VEN2bjZQRE4vMGVrTEppZXZQMlBP?=
 =?utf-8?B?cUE5RWQyWExRQ0RrejBocmFTM2hIUEY0c0pvNzRTMnowLy83RTlkTmNNTVlL?=
 =?utf-8?B?Rkd6aUxLQnUyM0VhTWFiTUJscmk5L1poS2daUk5UMVJ3a1Z0Y0lrOW45aTdq?=
 =?utf-8?B?cldEMlZLL0F6THh2RFo3UlhVSVFsd0xVd1R3Z09Qem12eTV5VmFrMFJJdlpG?=
 =?utf-8?B?clNNK0xwVEtjSVVxWm5OZFNWelNyd291eWh3NlBWK0s2UDdndTQ1ckZBek90?=
 =?utf-8?B?dzJHZWx3ZHYyMmFoRldXMUg0aVJNdGF1S2Jid2d3eVRNTXE2cG9RdmVtMWMx?=
 =?utf-8?B?dGhmaCtwU3N2eUx0U0hpSjl5a05SNG9waGFxYU9ZTk5wMmEvK1JxZ0lnajhU?=
 =?utf-8?B?NzUvMTBrMmlwYTdVYXJwa2ZIUklrT2lneGpOZXhBMnNZT2lNenJVNkFOMGZN?=
 =?utf-8?B?cDl6bjRrRWM4ZzZZSmhPaE13d3l3Vk9kWVdyR2lQUUlDQVdwV3pKR3dTUXl2?=
 =?utf-8?B?MVd3QWp5eTM0VklnUVdqV3UxWmZCc0xQLzFpa3RwWmxaV2NsT2xCT3g2ZWlY?=
 =?utf-8?B?aFhaaEw1WldENFN1YzJFNVMwMFZtOXBMK0JxN1ZwK1RJTm42NmhCTVBJQ1Ni?=
 =?utf-8?B?SkJoMndSc1Rjck9ScFY3UlduY3pneHo5UDdrYzdtcVN0bTVoZFp2QkVGVFc0?=
 =?utf-8?B?clVsaDFFWmdRc3h5UnhVaXNWOWowTVNCZk01MVFQKzZZSU80TTVOMm9rd3NI?=
 =?utf-8?B?MkVpdWdUSUVTZ0FvTTRFbzU1ZVF3OG1GTVl3UWR1OVhtd0F5MU4yWFI0Wi83?=
 =?utf-8?B?bFpaanJrajgxT1U0U0YyNzdMc0RNY2taNC9VVFg5SXVJVFA3ZCtNbU1UL29i?=
 =?utf-8?B?R2xFZUJETE9XYkNNcWZjVmZsdlRIb3lQUml2U3hUMTFmTnBGNWFCSmVpalhw?=
 =?utf-8?B?ZUpxRFg5QjIybVFGLzgwR0xyRlFCNzdCM0dibkdjUEYwUDAvNjBvTmhQZU1N?=
 =?utf-8?B?aE9TdGhxN3NYeXk0cmpZcWFEWEFNQlRPWkloeGQreElocGZkUzdTZXNHNWVu?=
 =?utf-8?B?aGhsMG9KcFlhU2FZRXE3bmVKMWxLclUyMW1oUUNuakRLY1FZbzU3UXJEcEE3?=
 =?utf-8?B?VnluU24xNjAxb0puM1p3RzNCc0NxQ3EzNFREQ3hHR3pDY0V2b1VJM0c2S2s5?=
 =?utf-8?B?KzlGUWFDMmFCcExWbXJDWlM4emVnazVUUldmM1UrQ0VtSlFOdkpDZkhPYTJp?=
 =?utf-8?B?SzNDY2RDMUN2ZjhDWDZydW5FekRJT3NwZGxuRmpGVjQxMjNLQlFOeXIwK3pJ?=
 =?utf-8?B?UmsyVnN3ME1MVjdkNWxsNGV3ZTFqWWdkSkRSYXVFTXBkdmxldk5iY0pYd2Fp?=
 =?utf-8?B?d1Z5U3V6eXZyZGMvbW0ybkZIMGhkQUVFTWwvL1ZOUWZicHI1bEl4UkNFUTVm?=
 =?utf-8?B?SGh5aEhGekliWG1RYlZZQ0xoVUxOc2cyTVpmeTVlMllaeFp3TGhxbXRYc3VC?=
 =?utf-8?B?THpPZ3JFUjVyWWplMnQ2c0tlQnFBcERteGNuWXNhSTlzcENwRUdoK1lKV25i?=
 =?utf-8?B?T0NBVUV5U1Z3OURhbFNtRExONWdjMzY2WDlkVkpueUhyUXdlTkJieElIODlT?=
 =?utf-8?Q?uBxw=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7eec8ece-4678-479c-445c-08de2840f172
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB6566.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Nov 2025 14:27:32.8882 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KI7kCm9kwjOkzOSHPQs62cILAMEQyPp/vND7ahzD8eSZZGmvWB/asSYpa5RmpFnP
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8651
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


ping

On 11/17/2025 12:52 PM, Xiaogang.Chen wrote:
> From: Xiaogang Chen <xiaogang.chen@amd.com>
>
> During amdgpu_gem_object_close amdgpu driver cleans vm mapping for the closing
> drm obj. If the correspondent adev has been unplug got error -ENODEV code. In
> this case do not need send warning message.
>
> Signed-off-by: Xiaogang Chen<xiaogang.chen@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
> index e3f65977eeee..1b9a6b15b29f 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
> @@ -377,7 +377,7 @@ static void amdgpu_gem_object_close(struct drm_gem_object *obj,
>   		goto out_unlock;
>   
>   	r = amdgpu_vm_clear_freed(adev, vm, &fence);
> -	if (unlikely(r < 0))
> +	if (unlikely(r < 0) && !drm_dev_is_unplugged(adev_to_drm(adev)))
>   		dev_err(adev->dev, "failed to clear page "
>   			"tables on GEM object close (%ld)\n", r);
>   	if (r || !fence)
> @@ -387,7 +387,7 @@ static void amdgpu_gem_object_close(struct drm_gem_object *obj,
>   	dma_fence_put(fence);
>   
>   out_unlock:
> -	if (r)
> +	if (r && !drm_dev_is_unplugged(adev_to_drm(adev)))
>   		dev_err(adev->dev, "leaking bo va (%ld)\n", r);
>   	drm_exec_fini(&exec);
>   }
