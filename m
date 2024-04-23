Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2B238C4345F
	for <amd-gfx@archiver.kernel.org>; Tue, 23 Apr 2024 05:50:54 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AE0FE1130FE;
	Tue, 23 Apr 2024 05:50:53 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="uw3mvIGC";
	dkim-atps=neutral
Received: from NAM04-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam04on2045.outbound.protection.outlook.com [40.107.101.45])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C5DB61130FE
 for <amd-gfx@lists.freedesktop.org>; Tue, 23 Apr 2024 05:50:52 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CXQS5i7DTb7ncyoMj6+BaKkPn/QRKpeoj9CRl8nlMsHDy+AgCjjzVrFfh24AUbDZ5MCqQUmRRK+xmbDzjras7M2/SGLWnBw087Kexb0z5XYDcdDYJGJ73AIDUWrEbBuQ4+5kkeq4lPuG7zl2JSDH+g+Q4H6zoj98Y3r7JdG7bfIbreu0aJPiTOESDPHZExIlR6sqtr8YBXwuU9PVUgrVJJRxFCSBnjAUv8PWcj/r1o1Ry0jyaWJtojeM1GzabAsBzKgbyM/89mVpfMNcqHWUXvbkgXEV33FfQQ+0QiaqiBnu+A+kdrSD06eRqkj3+mTWS7PSnel1/xTlZ7atDd55mQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qzHO1/SC4GHmOdx6Niw/4+XpfYOa9AtcEdbqSCny23I=;
 b=ld6QTGbKuswXJZknvTrzqE+gEO0/tPhB8E5O6RPoSI+SE7cugdusNXDhsjMHNRcSo4VqRnLd5ceNB6wdHYxm63L3teobeCo4hskPCUD2/KCcxbdLVwwjibfzIwChIKEBcy7rcWhAqiSQQsfwFcNrP5Lp1nVf+rPD1CDO9Wyfw+aVt95i1V7zDMddHgaWUT3Hd8BfzZ4ePrMsYwTc8wyyJoRkUnDU+u4JpJrD3biGfqsiJUTmQJfawqEUUx36RHgowaZvB5Sn3UwAa+oeZWib/GNxlW6B0ku1Cxdb8pz3cdISjBv5PPCs4b2ScXnKQQe5UoH/UI52q+XBvRnaDssrAQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qzHO1/SC4GHmOdx6Niw/4+XpfYOa9AtcEdbqSCny23I=;
 b=uw3mvIGCCAXbyrQEVCeXB2ncvltxf4sT/PMCAumsyokM6BFjXXc3ZJbz98kj6U5qPsOoLgqx9HyzjCFfbKh7mdvU8ZdlJELq8gVtXenjuo6mwxGp+CSspQO+qadDP2njDOcxBfBDajls5LlznvqrjSCh7esjSLMoGmUi4wbYmrY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by PH8PR12MB6724.namprd12.prod.outlook.com (2603:10b6:510:1cf::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.44; Tue, 23 Apr
 2024 05:50:50 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::f2b6:1034:76e8:f15a]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::f2b6:1034:76e8:f15a%6]) with mapi id 15.20.7472.044; Tue, 23 Apr 2024
 05:50:50 +0000
Message-ID: <572623ed-f353-46f2-809e-4678b152fa5e@amd.com>
Date: Tue, 23 Apr 2024 07:50:46 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amdgpu: Fix two reset triggered in a row
To: Yunxiang Li <Yunxiang.Li@amd.com>, amd-gfx@lists.freedesktop.org
Cc: Alexander.Deucher@amd.com
References: <20240422194550.26148-1-Yunxiang.Li@amd.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20240422194550.26148-1-Yunxiang.Li@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VI1PR07CA0284.eurprd07.prod.outlook.com
 (2603:10a6:800:130::12) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|PH8PR12MB6724:EE_
X-MS-Office365-Filtering-Correlation-Id: 6d1ea1f4-55f1-411f-03c4-08dc635954a6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?U1VBSG9VSGtMWXk1MGgrMGw5YzAwaFZONmdseG9KUXJzODBjajN6QmtnTjdO?=
 =?utf-8?B?YnBvb09nRWdac2JwMTd5ZWYxeXNOUC83WjF4ejVmR1pRN2NBZmZyR2ljU1g5?=
 =?utf-8?B?OUt0ZytSOVNBTTZhcE9OMUJ1NThKN1NHNWZuN3J0VWE5MDJoQWRpSkw4ajJ1?=
 =?utf-8?B?VEt3bE5BOGZQZ0wzdTdTSGRsbGEzZysyd2NaZ3VxME1kaHJsSU9jU2dNcE03?=
 =?utf-8?B?aEZId0R1WmdvTFVvdm1KOFJpaUw4alErVVpSMEE1RWdmekRraVZnNFhCays4?=
 =?utf-8?B?ckpuSUM2K2oySnNseFNZYTVOUDdST1VRaU9hd2VNdUU2QXFVbjJxQjBWMUFj?=
 =?utf-8?B?T00yZTNwQldtWXJFZ2pSOVhPd2k4anJjK2hSWWYwbVNyWFpUREZ2N3hXbnpF?=
 =?utf-8?B?dFVrWUVDTTg5VUdVTFJCeGJsTzhnR29UN3pJMFIrZkxxNkZTWFRkZkpxK1Aw?=
 =?utf-8?B?YjJPenVaNStrckg5VmVQVjdvNGIwaDVYV0xTeW53VTNSQm04OENsQmQzUkN4?=
 =?utf-8?B?TkJPMy9vbEJJNXhFeG5UMXE4WmxyTTNQMmdLazZyOVRHRUNkQy93S2V0ODJT?=
 =?utf-8?B?S281TUhUYW0xYXNyOWY0c2dwRFA3REc3aUJ1V2J3aXo0VzlGN2tEY210ZDZS?=
 =?utf-8?B?MUl1T2tkQmtIRXFXMU5FT2xHc3Q2MyttMk03TUNCVDgvdUtQeE1qaHBEeWZN?=
 =?utf-8?B?WktHZm82V3pLbDdxV0M1MTRoZllnai9zUjJhMU5JVzVmdWQrODRYWTRmeC8y?=
 =?utf-8?B?NGRoemg1dU05cUlVM09WQjBEZkFEZGZsek1zdDEyVWlDQk9MdnBKYkRFQ0xi?=
 =?utf-8?B?ZHlIdHBad0pMSlRrajZrb2lvbjcvZjNwMThZWFVqTWdlbGF1cjMzN1VqS3pS?=
 =?utf-8?B?WHk5UC8xek1pOWtKbFBQN1JZSkI1VjgzVXcwWDVEd2dlRkZsck9KTjFnY1Vz?=
 =?utf-8?B?dXphU2hxa2paUGR2QjdNZE5oa200V3h4aG9IUE1LT2Z6b2p3dERkb0UvK2c5?=
 =?utf-8?B?Y3o3Y1JJWGloczVWTjZyWUcrdnQ4ZWJoUFgzWWhTaXJ2Q01ZNUt2NXlzNENy?=
 =?utf-8?B?N0piVmRoZGVqUk96bHNGVzJZVUpiNkVQSU5JUmpIeHFCNkhlUmNBZDQ4UTlS?=
 =?utf-8?B?aWx2RTRZaFBTOHQxTk14QXFsMVVPOExMbDBzM2xsYkZRaHpwcEtFRXhRTEFF?=
 =?utf-8?B?bzB6K3VsMVIwVXpCWlNWNlRTQ2RVanJOcE8vYnlESzc4UTlQL1BOYjJMbm1q?=
 =?utf-8?B?M0JqbTZXVlU0K0JLVVBTdE9sRjdpOHQ3MC9NWkRBdTEvUjltRk1pVlpXUVM1?=
 =?utf-8?B?VVpGS0lqRVdUQVkzM0ZKT1FKQ3FySkdxVkR6L2N0MTB4Wi9aTE9VeVRPZHpM?=
 =?utf-8?B?SXNnZjNUaXJzTy9lK2E3ejAxbGlSdVRzam1GVEY4LzRyK3ZjOHBlT3hqUWpB?=
 =?utf-8?B?c0xsZ1FhU252MllMVmlvNUxmeWZuM252TjBWSkdHcEJ2R0JKSHlQY2ZpRU51?=
 =?utf-8?B?dE9kR2o0UG5yY0hLZDlsQWluWllWOVlqanc1SWp6Qm9YWUN2NFQvaFhXT3po?=
 =?utf-8?B?NDZxNjc4TkFpUGU0QjErakFETmRtTEc2ajVJUFBXRi9IaFVuMjlncnM3QllF?=
 =?utf-8?B?YXZYdCtvZzZBR1ErU3FUcHNOM2crSEVaeE40Mll5eTBkbGNrUTlHVnY3TUox?=
 =?utf-8?B?RVd6VitCWEkrTGZxUGdiUVlabHhrMXFhK3lVbmdGUGRpSkNTRnBCb3JRPT0=?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(366007)(376005)(1800799015); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?V2FpTDdtQmxiQzE4ZFFFakZmZnpZaW1Sa2xsYjUzbEhKODhNZno0VFlpMW5j?=
 =?utf-8?B?bkNCY2RIMVAvUy9ia1hMdGV1enpaYjBiZitWcm56NWhubWwrcmNJMnVNVUhm?=
 =?utf-8?B?bytSZis4UGdIbHJzMkZkd3dzcUV6WTlRRmFteWRiUlhTR2hsWTVSYnErVERw?=
 =?utf-8?B?QUs3SUkyN01idk9LWU12RnRTVmgyZzA5cnZvRGxNU2xPd1hpNlpaTlN2bG55?=
 =?utf-8?B?dC9ZdW85Qjl0MkV6TTVrYjhIVVNkRDJRRFYwTjRFQklQaURzVEJQTGZsT3pN?=
 =?utf-8?B?RGtwMCsyWGVBdUhKVDEydjhUSHNCRTFHMENEeVlKbXBzcC9mUWw3UnhoTVlw?=
 =?utf-8?B?ODk0ZXB0MlZySUlzTysydkhvMWFvRW9oYTg2Q25nOFNaV3J0TzIwS1dWY2RR?=
 =?utf-8?B?eFZmbHdicTU2S2xvcWM3V2U2Q1VjK2F6RFp0R2llRFd0blBvMG4rRHluN09w?=
 =?utf-8?B?dTd0UzhUOTJvUDVGQ3lQYlBwL1cyOXdOem12a2pmZXhMMzVmMXQ4Wk9Qb012?=
 =?utf-8?B?RFN2UXlDVzkrU2FrWkdiT1c5NXp1WmFxYklHdG5ZSGFZRzNBQXMrTVpzdlZF?=
 =?utf-8?B?MXo3TW9iWUxyWlUrZDdFeHlPVlZkTSt5dUdrTENkZ2dnU2F2NnQwbnV4dHlK?=
 =?utf-8?B?TDBmNWpneWpVVk5iZzcrNVhvWUs3dGk0STNyUndlY3pYb1YzYm1nSGZsbmtj?=
 =?utf-8?B?cGhaYkhiY1BYaXhzMzdGUFZiS09Md0U1Z0lUZEVqcHQ1aGFQMTg4ZGg3L0Jw?=
 =?utf-8?B?RUtOMzlwenk2dzRXMHJhZzJCbVpIZTNMTHo3ZFR3UzFETnM5NmhXb1ViclFq?=
 =?utf-8?B?NzNUZ2xUVGl3TUFFSWpEWWZWN0NPaDlqZ3JhUmpjSUp6NXBaM3BJajNQK1pC?=
 =?utf-8?B?TG5GQlpCR0Jjb3BhVXpUcXp1QmhrQVFhNGpTRm1YTlp6VVVPcEk4QlpYelll?=
 =?utf-8?B?ZFRxYTdZMnVuMm5iNklvY2tUMWFMODViVVZXaTB4SFlNQ0NWcmpzVmVmbUJm?=
 =?utf-8?B?UVVUUzk3Ly9qMWxZK1M0dlZ1R21Nc3M2eVpGMERnWkxINU9Rb2FhMEF2YTJZ?=
 =?utf-8?B?a1FMZGphZ0F2SVV1U2p0cTJVbS9IdTloK0QwQTI0TmFaZWo1cXhNbTdjS2M1?=
 =?utf-8?B?UTRycVpkZWNyYzVzaWV5STR5eStSN094MFNJbnVPTkQ1UFZpWHcvRkJYaXN2?=
 =?utf-8?B?RDRDeVFGSEppeVgwY2k2a0JJUFgzMHN0aE5icUV1NmNKL2lQZllyR1NYaDZw?=
 =?utf-8?B?UGQvcHdwL0d0WHhkakhvaTJ0OXkzbVhtMGxWSFlJcWdEUWhLUGFNd1d0djNQ?=
 =?utf-8?B?R29IMGE5MkZGQitPNlBTeXpwaTlEYTR6MWxLRStBT2FJeTlNUVV1L1dYeitV?=
 =?utf-8?B?UUpldk1JdjVmd2J4QnV2OFNxM3N6SnRnNHBabXlVTVJ3L0NBL2RSd1J1RDRy?=
 =?utf-8?B?NDBRUDlDU2FvTElJdjdwSnhSajN5MFZiL1dRT082SGplNDVGSHBvMU1ic1d6?=
 =?utf-8?B?ZlQ2cUNBdld4dGdobXBSQUdqU2NiWGhDZnpFdzlEQm83cW1vbEJHNWtrbnBV?=
 =?utf-8?B?Ky9hQXFoTE1FaTlMdi83KzRnMjlTRjhLcStEeHlpWENYRWZkbGx1OVFlM1Q1?=
 =?utf-8?B?NHY4bXFVSExmU3VSTDRKK2Z1UEgzUmxvaStUdENpNjU1T0VtanVqSWh3clN3?=
 =?utf-8?B?WTBTNEgwTGU0RTNUV25zWndhQURISmxHbmVkTUh1cUJYeXdPUk5oeFV3dlNF?=
 =?utf-8?B?Z3k2WjBSZlZ3OWV6anRrdi9zK2JQQTZHVlQ0SWpGTWtqSUNpWWRaK0V3dXEw?=
 =?utf-8?B?LzVGM1pMQi9MenptWGw0NHdscGl5NmpMYmUzMCtDcTI4U1JTa21PcE5mVFJT?=
 =?utf-8?B?NXhsbXdwZ3pSWjZzNk1NYko4dk5JY3Z0TzVSV1BXc21SMVdTdXdpdFIwUEhL?=
 =?utf-8?B?ZE50dTZpeFFqeTdzdGxoVkYvSGE1SGIrZ2RpWkt0SnEwWkxIQWZlaEp2QlV6?=
 =?utf-8?B?YWJNb0tqYVBId04wQVo0U3ZsK1hhYlZWZHkzNTRVNjkxSVprOWMyTEp4K1Bs?=
 =?utf-8?B?U1VCWUJrc2V5emxLdGcxazJZVDVhN0l4WWZaVHZjaGJONlk5TFpWaWdFdkQ2?=
 =?utf-8?Q?dgxMf5zTiVzeJvQcsZDyb9Z5q?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6d1ea1f4-55f1-411f-03c4-08dc635954a6
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Apr 2024 05:50:50.5820 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RIsIfZpIS0x/9Fz6hi2LHcpq+kzSucasAjW3p1E16gCGW3ybhSeQF7THZv9cwJSO
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB6724
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

Am 22.04.24 um 21:45 schrieb Yunxiang Li:
> Reset request from KFD is missing a check for if a reset is already in
> progress, this causes a second reset to be triggered right after the
> previous one finishes. Add the check to align with the other reset sources.

NAK, that isn't how this should be handled.

Instead all reset source which are handled by a previous reset should be 
canceled.

In other words there should be a cancel_work(&adev->kfd.reset_work); 
somewhere in the KFD code. When this doesn't work correctly then that is 
somehow missing.

If you see the use of amdgpu_in_reset() outside of the low level 
functions than that is clearly a bug.

Regards,
Christian.

>
> Signed-off-by: Yunxiang Li <Yunxiang.Li@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
> index 3b4591f554f1..ce3dbb1cc2da 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
> @@ -283,7 +283,7 @@ int amdgpu_amdkfd_post_reset(struct amdgpu_device *adev)
>   
>   void amdgpu_amdkfd_gpu_reset(struct amdgpu_device *adev)
>   {
> -	if (amdgpu_device_should_recover_gpu(adev))
> +	if (amdgpu_device_should_recover_gpu(adev) && !amdgpu_in_reset(adev))
>   		amdgpu_reset_domain_schedule(adev->reset_domain,
>   					     &adev->kfd.reset_work);
>   }

