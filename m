Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3A9D5E7717D
	for <amd-gfx@archiver.kernel.org>; Fri, 13 Dec 2024 10:10:35 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E087A10EF90;
	Fri, 13 Dec 2024 10:10:34 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="bEbRLmD+";
	dkim-atps=neutral
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on20623.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2414::623])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D27AF10EF90
 for <amd-gfx@lists.freedesktop.org>; Fri, 13 Dec 2024 10:10:32 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OkSzxmwND0sWBqfbqQIjlEem+uJj0DbL0pZb9zJ6Pu9bN7QZI8G/IKys5IBoxwFQGudOSzjqrZm4Ctec8jGk2YYqMwT4Wz09DhxMZxWlQ/I/tFiaigjhw8UfAYr9Wnwx37NB0e35VN6ASnNEMCPE7Wk/xMmDmr4GxFT3eQkiwdxK61AIVAJep7Fs7uYJ/7WUzsuDhzmreT+wEg3u0I3pGdb3Kh7mBJ33R2xL32ROZgJFfpHSaP1XtXSqhc+/b7Ft0xbuaQbePVwv2PmjHoc/gDA6hmWrOeObABvD8NqgWHIC0FGMFGZ+qEyX4TLcDl8NV23BKXQVn9wUii45AVyQqQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EaHvVAP4iVjmW1KAjjfIvv1RowfoWtBUdGETSQ56tMA=;
 b=JoR6L7tY0mqPZZcco9yRz+9mDX1NAj35m3YAgS94VHKs18MP/Gwyl1s7CYZo5TDYvJKAl85Vu+uwO7O2+B2ncxs8+UiMOeBe9yegzEWpm/suntpCsP7Nqya96KGo+dOJ5wQ0BL31iYXRq8NLl9Y4vMIm9qDs3JjmTLmkG3qgS8J6AP4vCeUqasaMr6tpeSmWS7j5m0yKWsLPPQQN7SijKQDFZkm0uzpdSTqQ++x5H20t3IX4JFdPHAgK0CGLWlQ+quf564VhxN72rwiWHGT2wlu043Fx2owvqV61NUOngHHoOS5igOxyK1CHa+R2Scd10xxH7fQ6nlNTw6CqpBv/Ig==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EaHvVAP4iVjmW1KAjjfIvv1RowfoWtBUdGETSQ56tMA=;
 b=bEbRLmD+HQuHk+9m/kyBi654vC4PSp6CVO6VEBpP250IV70Lwqli0NVk1iM0LcpPFxH+19akZwtV4pUy6rosoHjrJmeZB7j6iEjY+lBp/V0JBp/0KOuoZ63amPfN84IR3SfM+1Cf4luUyPLVGe7t/7OtH1dYeFkittkGLiiJyXo=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by IA0PR12MB8715.namprd12.prod.outlook.com (2603:10b6:208:487::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8251.18; Fri, 13 Dec
 2024 10:10:30 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5%5]) with mapi id 15.20.8251.015; Fri, 13 Dec 2024
 10:10:29 +0000
Message-ID: <6488f07a-81b6-402b-a775-b626add5acb9@amd.com>
Date: Fri, 13 Dec 2024 11:10:24 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/7] drm/amdgpu: Fix NULL ptr dereference issue for non
 userq fences
To: Arunpravin Paneer Selvam <Arunpravin.PaneerSelvam@amd.com>,
 amd-gfx@lists.freedesktop.org
Cc: alexander.deucher@amd.com
References: <20241212142533.2164946-1-Arunpravin.PaneerSelvam@amd.com>
 <20241212142533.2164946-2-Arunpravin.PaneerSelvam@amd.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20241212142533.2164946-2-Arunpravin.PaneerSelvam@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR3P281CA0080.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:1f::15) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|IA0PR12MB8715:EE_
X-MS-Office365-Filtering-Correlation-Id: 300bdb01-8b71-47f6-abcc-08dd1b5e5f40
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?dE40RkFBbHRlZ25XRXdGc0hXRE9heUpEUFRsSkdxVlhRQVFEd25HRmJOVUhM?=
 =?utf-8?B?cjkycWVxWFFqcmdzSDBEWU91VGRzYU9LdEp1MlZFNHlWU3czYXJmWXlleVBD?=
 =?utf-8?B?LzN1MVVvSEpSOXZRT3VGaXNtMVJTREgrcnhSYWQySUQ1N1JERXplTkxCcFVu?=
 =?utf-8?B?clRtQVJSWk10dUZWUGM0RUVpMWRNWThPMzllT20rTkZqT1BSVXo5bGxwcE10?=
 =?utf-8?B?RFA0aFV0VlczY1lmL2hVTktoRGNNdHdWQTRNUGhnTVlVaXg4WVB1Y0VZb2dP?=
 =?utf-8?B?OHgreVZSZVRMdFhheDZWUzVIVWlPbUo5N3BEbjVnRDJlYU9ZeVVHZkhEOHBK?=
 =?utf-8?B?UXlzZ2tLUGpES3lVS0VReW9OelppQmNLNGw4eDY1ZU5UcmVRVENzSVd0N1lG?=
 =?utf-8?B?YTZoZFF3OXc1NDdOZ3JhSmJwUVA0c0dqZGtJc1FSZTd1WUcrQnFwUDF3OWhT?=
 =?utf-8?B?Q05nb3l6Mzc1NFU4eVJvd3BmajVvN3FKU0Q2L3pwZURtSVBqK0FEVHMwckZk?=
 =?utf-8?B?R2pRR3FrdzlTSUdyelJVQnRVSnpoRTNWK3JJUVN2eHRjUkFxQXNWSnZHTDJL?=
 =?utf-8?B?Mlg3UHR5VW50NDhSc3VpK1FLLzd0Mm44c0w4eFByNCtobU51aUt6N2NMODBX?=
 =?utf-8?B?enZmcXVvRHk3eUZwUXc1YnNPanZpS1JyaU9KaW96MDdOMHAvUnFDd1p2azFs?=
 =?utf-8?B?b2tWd3E2cy84NWhiQ2JwYmpreXRvUFRjcC9hUUtDb1paM0IyeDNac3hLVDEr?=
 =?utf-8?B?U2tUSUx6VEwycDNvbkM0OXp2MUFIZ0QxRzdoUmZvY1pTTHBENSs1eHRBREky?=
 =?utf-8?B?Qlo3UmlaUzJwMWhvSEYzNlowZmhPVGtWQnpseUNRc3JUaXpTZG5lcytqREQ3?=
 =?utf-8?B?KzlQV0ZHUXMyYUVXT0t6MUJsbDllajBNbW9MVGtpcXFFVytDU2oxNHdKZ2xG?=
 =?utf-8?B?am5vejBLN1k1TkhzK3ZCcUNZOXdlYm4vWnc1UmpkTFFDU3RhaUI3SFZneDRU?=
 =?utf-8?B?Z3dXaTNEc2Yzd0kwVHdaZW9Tb3U0Vi9TcER6dlBQc0JyeU9uZDBKaUtNMGRl?=
 =?utf-8?B?R3l0UXB1anA5bk1CYnBhRkhUMzB0blNWWjBPMXBKb0VsRlI0ckJndWM3empw?=
 =?utf-8?B?bkRsVUJURThRK3dNUmtPT1h5b2Jvdjg4cmgyalNJb1p3UjRhUkx6VWRDUllI?=
 =?utf-8?B?ZkZLK3pXVUhJU0UyOGx3T1gyRTJUYWNqYWZoWGpDUjZHWWFMNzBWK01FNGRY?=
 =?utf-8?B?L0Fva1JRL0JJUElJWDZ4SEtGYi9CenFVMS83MjBnM0d2TUwyelFnMW1yL1Fk?=
 =?utf-8?B?dmZJcGx5ZFplb1BVa25QWkgyRnFacFg3U28xOEZhWWRwWnF4T2QrcnNWR0Fa?=
 =?utf-8?B?MFpWT0JvWDRWa2tjUFRneVpxYjVjMGtVYzAzUGM5dHJDNVRkelNMcUlaTnpX?=
 =?utf-8?B?WEVDa1MvMG9CNEg5dnQ0bkxjMjRYeE01b2NGaU1ZWms2eGhTK1RNZVhlVzNp?=
 =?utf-8?B?cWtOZVFvZ1VWRUdxTDZ6ZTZobVdQTUpPZ0k4ZDVlTUtQRUthOVA0YWFBelB2?=
 =?utf-8?B?VlhRVFJLeHoraXRGaStBQnh6bWg5dUl5MVp6a04zdktYQjhHa3JlZzl5L3NQ?=
 =?utf-8?B?OWR0VHVYcnFubkNKUDhIUnR4RmtyYTVGcDVoQ1dWR1NRNXJJUitjallYVnZ4?=
 =?utf-8?B?RlhrY04vRHF0SloweFcxTjcybnFPeXlhNFlYSjkwUy81WXJWMzJ0UjlJdmpS?=
 =?utf-8?B?cnAyQjlYMUVLeXpHZ3lhbVRlYW5oY1dFOS9rMmlvaEh4VThZMVc1Q3haZmF2?=
 =?utf-8?Q?RXwRAdyEjcLrXbMa8u1g0VRhoW1zVYYeVKoF0=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NzRYZzhkWml5NDRwb1BnTVRxMVQ1Z0tjOGxUZFJLSWh4Zy9GbTVHTUoycExF?=
 =?utf-8?B?QUNYTUFWVEtEOTJBSitZV3JGVEhYbHlSMlMvYVNOSi9nQ0s5bnJUZk9JSTcx?=
 =?utf-8?B?WDc0bzB4NjN5eVBWcURreTlySi9UVFR3dU5wM3I3ZU5nQkNjYXIvWkk5Qkx0?=
 =?utf-8?B?ZDRjNUdHS09uRm1xSGd1Ylo2YzB3cVFiUEVSOTBhbEQvYUFwR2o4NGxtSk1B?=
 =?utf-8?B?bkdETlhMcFluWlRleWppRUl4SC9zOTFnYzh1bHFaZWl5bThaeXRkci9ZRGIx?=
 =?utf-8?B?aDJqNUxVeXduLzM5WEZaZm51QmExaGloc25VQWhRTUFsRVlLQUEyaWdMRm5U?=
 =?utf-8?B?RVJQQWp6L3VocSszUFFxeXdBdjF1QXgzQnFaNjFPMHRFTzNnMHI0dWxaYzk1?=
 =?utf-8?B?ajA1Q01BKytnSUgxSllQYWc2a2VXeGlGZUkvRnpYWkpxTWt6Ulg3TjdXSHl3?=
 =?utf-8?B?UUZXdHRsMlJKY1ZqbTc2N1h1R2lma0E5ZUFZWjFlWlFpS1JmNDZMMmhaTzAz?=
 =?utf-8?B?TXVIWjcya1laQ0NRUSswRVRtbS9GN3VFempDMFowZEx2TWJueFB1VGkwVEFv?=
 =?utf-8?B?NTdkRXZLM3dBYmxmRVdzd21hWGFVcXdTdm51UlRiQmJaSTZac2pnZm5ZQTUv?=
 =?utf-8?B?bXoxY1NRT3E0OVVNa1ZZRVM2blQ0YWVoSDVSQWJBSlIyZVVONTJORHZaQnBE?=
 =?utf-8?B?cHdQMGdIcGx4NDlqT3R3T3lPR0FyUkZKbGh0bFM3Z3k3SjhSZEJwWjhLZE9R?=
 =?utf-8?B?aHFtNncvR0EyOEJwSmQvVTlzM1F1ajUwU0kwWlVSR3hlMWFaeDUyM0VRTUhx?=
 =?utf-8?B?OGI4bkRJNmozcm0veDVJTUhESVlsdEZYWlFwTVNseHBJcFgyb282dGxDeW8r?=
 =?utf-8?B?SU9KMUFib3IvMWRjdTJyOVgzek5sYkxQOTZmbXMzYVhXS2ZMTG5jdFpLTWN1?=
 =?utf-8?B?QVlhczBUeUF1dld2dE14dURvZlBDWDRibENjVWRjTk1rY0pIQzRnTUdIb2lM?=
 =?utf-8?B?bEQ0YkJVUnFxcXdUZGcxaTJPQVZjY240Nzd6TExHd1gxQ2VxNnNXVmx5WWdi?=
 =?utf-8?B?ZTV6OVAweW10Y0VWbTRnR3NkOUowd2JIcThML3FiRG9BekExTDNmMXVRQlA1?=
 =?utf-8?B?a1V0QXZmUERCVEFreEtKSGFjWEk2WTNPd01rM1p6V3NuSVNBRGt2OTFmZUV6?=
 =?utf-8?B?bFNhTlI4MmZESTc0RGtSTFJmYmtCOW1wak1RbUhEQkloWnhQdzRiaVE5ZWg0?=
 =?utf-8?B?Z1VJLzJJYzVpcnFCV2F3TGE2RjNXNWJsT0VXanJnaVNpaWRGSFNWdFVyQ1VX?=
 =?utf-8?B?cmQvdWVyOGhkdTRoVDlEa3JSUUpQYnFQWFZCYzJDMHEzbVg0eVFKYmhvekpB?=
 =?utf-8?B?SWRnK3RNVGI4R3dnVTc1YTBBS1R0UFUvT3lENGFWVDhnQVZlWFN2cGtwNy9P?=
 =?utf-8?B?eGhkSzdyQy94QnllSjhibVlRaWNyeG92TVdvektJRzZKQTcxdnIya0FqZmlG?=
 =?utf-8?B?clh3dGp0aDdYZmxGNVo4bnZWaE1Memt0UFFucnJ0OEo1L2xZa0wwVklXTW9i?=
 =?utf-8?B?cEZadVhvVk9lY1diUDlieGs1QVJMMmtxemRIYzRIVEM2RHk2akRMby9yeC8y?=
 =?utf-8?B?TXJVNFphaUFxcS9iL2g4N1I4VHRtek9qVytTYU9VbElsRjdONXkrTFB6czhv?=
 =?utf-8?B?ZUsvZGplMndWU3Y0QXhEMzZVTk1ybzdXYXdCTDRYMXp1SkE4OC92ZVZCSW5P?=
 =?utf-8?B?T09Xck5tRStuRTArMTRZcjRrZkZUdStxZFhpQ3ZtZ1lRV24ydVpUM3dNRS9h?=
 =?utf-8?B?OVZCU0x3bGVKRzd0VDE2NzNJSVgwMWdCU0h2R091Y3kvYWtLOGZ3L1IweFVw?=
 =?utf-8?B?Wm9EL3RTRk5Idmg3NnZ4TUl0K2pVOXRKVUJjMGd5NU82TWdpUUowcmI1TSsr?=
 =?utf-8?B?QUdudDI2WFRLeUxrV1JVYVdDaVR5Q0J0eVRsNUE2elFlNGJsWWRwd2lUVlFP?=
 =?utf-8?B?Mmo2amJGSUw5Z0d0WGZwTktFUDU3VUl5RnRlKytpb2hSZzNBNlZ2QVZUWnFD?=
 =?utf-8?B?S0J1WWdYRUJTbnpMenVLNDBRWTM3VzJVSzJoTW1CRE1wbHlyWnZFUEZtZmFR?=
 =?utf-8?Q?Vx413xlwTZgoSiIfKhFLZ2Qm9?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 300bdb01-8b71-47f6-abcc-08dd1b5e5f40
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Dec 2024 10:10:29.8400 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: R7G+q2SN1Jzh4SpS2td8rrNu+TkFy3l08M6mhEw5VS4eEcpvWjQwZLbqzby+mwxV
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8715
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

Am 12.12.24 um 15:25 schrieb Arunpravin Paneer Selvam:
> Add the correct fences count variable [num_fences] in the fences
> array iteration to handle the userq / non-userq fences.
>
> v2:(Christian)
>    - All fences in the array either come from some reservation object
>      or drm_syncobj. If any of those are NULL then there is a bug
>      somewhere else.
>
> Signed-off-by: Arunpravin Paneer Selvam <Arunpravin.PaneerSelvam@amd.com>

Reviewed-by: Christian König <christian.koenig@amd.com>

> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c
> index 877cb17a14e9..3a88f754a395 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c
> @@ -825,7 +825,7 @@ int amdgpu_userq_wait_ioctl(struct drm_device *dev, void *data,
>   			fences[num_fences++] = fence;
>   		}
>   
> -		for (i = 0, cnt = 0; i < wait_info->num_fences; i++) {
> +		for (i = 0, cnt = 0; i < num_fences; i++) {
>   			struct amdgpu_userq_fence_driver *fence_drv;
>   			struct amdgpu_userq_fence *userq_fence;
>   			u32 index;

