Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B566EC25B7A
	for <amd-gfx@archiver.kernel.org>; Mon, 20 May 2024 12:01:59 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8438910E5E0;
	Mon, 20 May 2024 12:01:58 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="ORi+CA1V";
	dkim-atps=neutral
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2053.outbound.protection.outlook.com [40.107.223.53])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CAF9210E5E0
 for <amd-gfx@lists.freedesktop.org>; Mon, 20 May 2024 12:01:56 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=S7VLoM+av/QPLyxq48k2ly6WUW17R83E3KEG/PocnxOEPlQbxPI8xWNNGjqEl9DpMQRxTr8AD+4n8TkWP4epwWJvEzggyyxPLvBBWbOptU8S8Qjlzbs4X+997nrS+cpCRMZBoOcWLOJ+zWM9SMkDMcCoYcqM7aS4yQN64yKWIyh4LgyPuRYoMS+4aqdjwYTp5HFBsdJyiduVOFGpHyVh5wHBk61U+bnWg+rWd5yz7hWtGZfUhwK2BiUCAo/6ZzaANekD8xZCKJdIxobVOZgqocQp65NHtyXlz5Sma7xI9ItD+l+OT1N2JVro+W7ZpogVhhxTk33SXoKoTwMTyLyblw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ymytuI346ZsH8i9in88XYRgQun0V+C5PfESLELTcTS8=;
 b=T914BmQDtEpMgzNEaMazmzrYISmWQOJGHeNjJCi0HzgMYXT3CXTaRjtDoqqbyAdFV/6rgfKjcNRuWoKXr5NlEuT0YC9fnrRtcoMVmRu2CJs0s935Oy8MZdYdwHh5OXE3RmuttwLiS07WkKPNMd2FhkIjUvkPM5iHcICVTChazQA1KZrH7ACHpxzUBIXUlHn5CJSpBDr3VddlTq9eN25NOKXhySMQs3GYfd6BmOuALuHZQ9vZw/3Zn/dD2UaIwUxNXHJ60wlW6QJL5YCy8vWY3KunrLzKCP6y1R4c6WCVj/tx4N5Xck/j/jnRUgQ8m5FxLyB+670Ra/82BaPy/yITIw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ymytuI346ZsH8i9in88XYRgQun0V+C5PfESLELTcTS8=;
 b=ORi+CA1Vt5mqB2drkRFc1XFQ+KUoXVQajYB1TKa5P67xePDRGMVAIr6pOWoEYYKsUTvex0RsOYMan8NT+J0HggkB4z3wQ2NISkz/wjadIB1KA8ApsEVddCx8JZ/WiXXT1M4EO/YYmDHDznejuetgqTr2Ipw6z0mbJ4NEbiSIw1A=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS0PR12MB7804.namprd12.prod.outlook.com (2603:10b6:8:142::5) by
 IA1PR12MB8312.namprd12.prod.outlook.com (2603:10b6:208:3fc::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7587.35; Mon, 20 May
 2024 12:01:53 +0000
Received: from DS0PR12MB7804.namprd12.prod.outlook.com
 ([fe80::8327:d71a:ce21:a290]) by DS0PR12MB7804.namprd12.prod.outlook.com
 ([fe80::8327:d71a:ce21:a290%4]) with mapi id 15.20.7587.030; Mon, 20 May 2024
 12:01:53 +0000
Message-ID: <8219bfba-b562-4f4c-89e2-321331f8b12c@amd.com>
Date: Mon, 20 May 2024 17:31:46 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amd/amdgpu: fix the inst passed to reg read write
 under sriov
To: Victor Zhao <Victor.Zhao@amd.com>, amd-gfx@lists.freedesktop.org
References: <20240520111413.2070726-1-Victor.Zhao@amd.com>
Content-Language: en-US
From: "Lazar, Lijo" <lijo.lazar@amd.com>
In-Reply-To: <20240520111413.2070726-1-Victor.Zhao@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MA0PR01CA0122.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:11d::16) To DS0PR12MB7804.namprd12.prod.outlook.com
 (2603:10b6:8:142::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB7804:EE_|IA1PR12MB8312:EE_
X-MS-Office365-Filtering-Correlation-Id: 2900a103-cbd6-49ba-da9e-08dc78c4a3a1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|1800799015|376005|366007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?ckdINDA2L0ZrSlczdXRoODBxUlR4WmJCMFNjb1pZcDNobEZPeGMwNGgrTjFi?=
 =?utf-8?B?RURCVVpHaXdIMGU5YXZzZ3hNcUdRT1dtcGY0UzNuNnB4T1JhRHh4cnM0eWFR?=
 =?utf-8?B?MnRZNkVVYmF5YWF2V1hHdG5Qa2ZoZE9WVWU2OWErSmg0aVRYTEsvb1ZoUXB4?=
 =?utf-8?B?OGxaOFJ6WG1JZ2h6SGFMc1N6YWVYMTZmRTBkWDRXcnRHZ0FlRCtTQkRCdURJ?=
 =?utf-8?B?amQ3TkRqcnIwb21tejI5VDdSUm9Vdjh6SmZTSzZ5aERwOTZ1UTROSFdZdzkx?=
 =?utf-8?B?T25MaFpOcGU3NnA4ZEkrS2JhOFM5L2MyUEVHU1czOWJmN3NCK2xFeHdyT2Qz?=
 =?utf-8?B?RGc1L2ZXVXdTRk1UOHlrU3JsSUVRMERkTk5seUVGWmhPUTRVaTRjZjFuSkF0?=
 =?utf-8?B?RTVMcGp6RHErYk9QenZxWVJzeUxiazQzZFdOZVFONndnd0NIV1RwMVZvak44?=
 =?utf-8?B?c0k3WVNMTVE4Yms0WktycHNrQWFXRWV1VXlvVzhqc3RUUUVKZENXMEQ3QVVj?=
 =?utf-8?B?THF4Tkp2bnBJck50Znc5dDlyOFlvaGt0N3ZYMEJWUE9MV1VYem1BRkZHNUlZ?=
 =?utf-8?B?TFhrNDZlQkdRVG52NGRoRHo1YzQzRmxoZXh2NVRtcGZFMWxEVXdRZnBnbmR2?=
 =?utf-8?B?ODRrSVQvV1lGTzVKajhIQ3A1R2ZWOVNBVllxVW9BaFlPaExKTmpZelpmYVM5?=
 =?utf-8?B?M2EyRHJBcXFwV1NsbnNRU2FVNGdMVVNMOGk5Y1JuY0tVV2RDcDBobUpvUXNk?=
 =?utf-8?B?QVZBM0NHa2NtVFc2K1N6WmNqRE5Eay9OZW9GeityUDAwYTFQNUp5MnBnYUtm?=
 =?utf-8?B?d2dtSlVSRmEwRGtKQ0d1czRlcTlHVTcvNU44enhWb2dHVWZ5VUxDSTJtVzhw?=
 =?utf-8?B?TERjK1Nlc0RncmdEUFVnY2RLSTF2ZlpRaFo3Z1NQM1RxWnpyS0NQMDh4NEtM?=
 =?utf-8?B?Nm1VanhHREQwWG5Zd0VpeENpcFdTSytpWUlXQjRyc2NiWFNxZFRUTER3S1NC?=
 =?utf-8?B?Rit2WjFOajFERGxCNjRYRkFPTWE4RkdERXp6ci9UVDhDVUpGMEgwMXVKUzRZ?=
 =?utf-8?B?VjhQdm9ZUkdoK1V0OWhWSnliR09WL2tFYTJOU2c1dGxGeGJINUpMOElKdXB0?=
 =?utf-8?B?eHRkVTZBcUYvd3NkemhOZTZLL2xnYk9kaVIwcWU3bnV4RWVyT1NCRlFrVENw?=
 =?utf-8?B?OVk1aXB5bUwway9ybnRRdS9qSGxkeGVoR2pHMWh3dXgwYXM2dUxqV0dpTGo0?=
 =?utf-8?B?M3hKT1ZGS2VGK2JsaUdHcmlTc0ZvYlZXWnp0YTRzQTJrakhVRTljcndrQzlj?=
 =?utf-8?B?YWF6VTQ0ejdJNDZqNUFvQzRlbnpJUWdtUlN5OUxuNkFJOXBKRVdXS0t3M1R2?=
 =?utf-8?B?WU1xeWY1TERvN3BHVUpUMklDNmFSZDY3Mk1QeGRTM0FFU200NmVVNi9mM3JH?=
 =?utf-8?B?VUZjYzhFS1pndFBwbmUySzRHL3IwNk5WUlhXM0RsaXJkd08xS3NMUEFqTCtr?=
 =?utf-8?B?VXNnNUlpZXo3SXJTVm9KTmM0TGZOYzJtb0pyaXUwbGh3M0U1bHJtbkhzUEZL?=
 =?utf-8?B?cFoyc0I2cjRTa0lBajRsY3RIcFphd09NemJWTnVKQURPa1VvdmJJZTVYdmh5?=
 =?utf-8?B?VkhzQzNqaUFzcU1adHhQUTFTWENTQjZDSlpNaXV5YnJ2YWhDQm81MXB0L1RR?=
 =?utf-8?B?UVd1SUZ0YXNwSnhTY2R6bmpLTXF1SDVpOGo2OVZYcktkbTZtVDd6Z3ZBPT0=?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR12MB7804.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(1800799015)(376005)(366007); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VklhaitFU1ZMOGJtWEtXT1J6NTVtTGM2L3g2UUVvNEkxYXB1Y2VJZFRGZ3FH?=
 =?utf-8?B?OXQ3bnJyR3VuZ1d0MlYyK3NkSFl3OVdIYjFDUERja05rd3lCV2ptNXBlcnN5?=
 =?utf-8?B?VloyQ2swK29abm9nbDhtTGlnS1llUzhwaFhNbSszSXRFUzBNcDZwQUZ0cFBY?=
 =?utf-8?B?T1Z1V0R4eGsxVG0wR1kvNXVMLzdnVVBrZUh5M2M2Zk96cmJteWZ1SDU2bUZn?=
 =?utf-8?B?TmorTDgxUTRLNFZ4bGxmZ2dIZkI5UUF5dDVXbldkT2d2VzkrNzBqRHoxNjl3?=
 =?utf-8?B?dWhWQzB5RklRR2daYStRT2ZJeEFCS21mUWE0cVN2V2k1Zy9Bbm9NdzVXVEcv?=
 =?utf-8?B?QmRsZTJ5NUpDdEVscEppWVkveWhqL2hVYjlZRGM5SlovU3NqUjNtTnB4dDdh?=
 =?utf-8?B?Ym9vKzJRL1R2eDdocWFKeGd0djhsSjhYTk5Nd2V2eW1ldEY2Z3lpTERkcXVJ?=
 =?utf-8?B?TGZSTW9pZHFFeEltNThJczBwYWVvTSt0YlFPVnNKYVF0Sk9WY0wxNlB1a2c3?=
 =?utf-8?B?eFA3UjZRcEE1aTRDOENzZmh3NVYzK1B6d3E0aGZ2YW5BZjBmOVgvN2FiOHkr?=
 =?utf-8?B?bXlHVVNrS0tKcTNOTVg4UjJCLzMxM0xkcnBHVFdscW9DVzd2ajdqbE5rKzV1?=
 =?utf-8?B?KzIyTkVMV3BBTGo4eVkyZi9CcUE3NldNUXpjQlZ2OERjelczV2VJb3Q3WSta?=
 =?utf-8?B?ZmEvY3lyQW1CNWVMRFF5OG1LUWZzSWlPcDloU3A1Qm1mdGZ2d0gzOTZVOHBu?=
 =?utf-8?B?d245R2Rmei9DMHdMNFBzaGJvTjZvZGJUcWg3Wk5VWXA0YWNqazluQWdEc1Fz?=
 =?utf-8?B?ZDN0MHh6UVZla2NXZ3RXdGxMNEMzNzBWaCtRU1J5MEtYbWJwODZZQ1VNWFBF?=
 =?utf-8?B?ZkZUY3UwTm5iSEVKLys3WVhtSG9sMlNxOGlVbTJselhERTVXWko2QnRQWE9a?=
 =?utf-8?B?djlJYWdSSnpvZm95aUIycVpoamtxdExFdnFlR1NhUW5nZGhpMUpaSkZhRkts?=
 =?utf-8?B?c21pcDhLcmZVNVFoWkc0Y3RwK2JpTmhlR09DYlBIMkRSbEI1bE1YNklYUmV2?=
 =?utf-8?B?RWI0Nkc4Y1FUZEl2TnJTbUllam9hU3ZFTHhscmNFb0tTc2d5Y21Lc1dPZDBs?=
 =?utf-8?B?MUFyTTJHNFAzMGdzWmZjV0xFL2djajNpYURtMVhTQTAxalhmTmRJM295VmhT?=
 =?utf-8?B?OUg5bEJtRUhmZnNPaHJjRThNdFU5dngvM2tDNEJBTDZuMzBKTFo1ZUR4NjJ3?=
 =?utf-8?B?dUIxeE9DM2MrUk9mVXBxbG9RT2VpV1N5ZDJoOTJ3Rmx4UXFidzBpNHFsMDVE?=
 =?utf-8?B?WWlUQzR2Q0dkMThyNC9FZ1JUaDI0bHR5MC9MMEdPa2ZZTlF4c21VSE9sYjhi?=
 =?utf-8?B?Q2UwVlp5R0l1OFNLQktpamFPTksvWmtzbUtlSllMQ21mQmFLRFpLUEtWNjdx?=
 =?utf-8?B?dTA1M09CZUNZWlBFKzcvcEtoS25QNWhzS0dBa280dU84RVBTdWp3Y3UrODRz?=
 =?utf-8?B?SlRTTFduS0xXaFNLVFlGa0c2Sy9DZ09nU2NqdXVKM3pCaFVhMnRlL21vcE83?=
 =?utf-8?B?V3F2VDlQRWZFbjUvMHlkdU5NTXJzdnJTbTR4TCttOWZzV0FsNUp6RERaSmZI?=
 =?utf-8?B?RndudHh1MXFXMmFnQXIwaXpGd2RpT05BZStzT3NXNWtPMlRlZkRIUnhjQ2lQ?=
 =?utf-8?B?VGVQdURPNDYyQzdsazIxUkdwT2hDOVJUT00ra3BuUXMvZUVIRDR0cjd1VStI?=
 =?utf-8?B?RzRQRzdPME44M3gxK3RveVMwb3gwdjJFcFppcm02cG11emlFeTZnV1g4eXE2?=
 =?utf-8?B?Uk96TWFseFFUeWFFd3VhbmY0aHF3dHQyOE1QempoYmVvcndqcWFJN013UEpO?=
 =?utf-8?B?R3Y4S0s1Qll2WjcrVVhsV0plOHNTWU8wOHVaSVVaV3RNTGh1OGRncUIzbTNQ?=
 =?utf-8?B?RFFjYURXSEFpVk9sRUNtOEZ2VkZFTi8xNUNCYWZpbWN2SlJ0YWh1Z1JKOWZ4?=
 =?utf-8?B?SU5ONGJ3R3B1K1Vnb0JWc0ZudlIwT3o0ZGZFTy9pTndWdXBSMXBYdWxoVFBI?=
 =?utf-8?B?SWUvbUpnZlp2U09RWlJCTE9oL2QxSkJTRmg0YlU2anNVN1VrMEtLUG1saU5v?=
 =?utf-8?Q?8Qw6HrUe5B00IMVje0lrTeI5H?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2900a103-cbd6-49ba-da9e-08dc78c4a3a1
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB7804.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 May 2024 12:01:53.7333 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: IU+KaATsTykzZ0LGOOC4eTOZtL8bz9EXAYHoRMgG49DbSyXM9lySC/MScjvb+A7d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB8312
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



On 5/20/2024 4:44 PM, Victor Zhao wrote:
> the inst passed to reg read/write should be physical instance.
> Fix the miss matched code.
> 
> Signed-off-by: Victor Zhao <Victor.Zhao@amd.com>
> ---
>  .../drm/amd/amdgpu/amdgpu_amdkfd_gc_9_4_3.c   |  6 ++---
>  .../gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v9.c |  2 +-
>  drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c       |  8 +++---
>  drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c         | 26 +++++++++----------
>  4 files changed, 21 insertions(+), 21 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gc_9_4_3.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gc_9_4_3.c
> index a5c7259cf2a3..319e6793053a 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gc_9_4_3.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gc_9_4_3.c
> @@ -300,7 +300,7 @@ static int kgd_gfx_v9_4_3_hqd_load(struct amdgpu_device *adev, void *mqd,
>  	hqd_end = SOC15_REG_OFFSET(GC, GET_INST(GC, inst), regCP_HQD_AQL_DISPATCH_ID_HI);
>  
>  	for (reg = hqd_base; reg <= hqd_end; reg++)
> -		WREG32_XCC(reg, mqd_hqd[reg - hqd_base], inst);
> +		WREG32_XCC(reg, mqd_hqd[reg - hqd_base], GET_INST(GC, inst));

Why this needs to be done? Isn't the expectation that it goes to the
right KIQ/RLCG as those are also indexed by logical XCC ids?

Thanks,
Lijo

>  
>  
>  	/* Activate doorbell logic before triggering WPTR poll. */
> @@ -493,12 +493,12 @@ static uint32_t kgd_gfx_v9_4_3_set_address_watch(
>  	WREG32_XCC((SOC15_REG_OFFSET(GC, GET_INST(GC, inst),
>  			regTCP_WATCH0_ADDR_H) +
>  			(watch_id * TCP_WATCH_STRIDE)),
> -			watch_address_high, inst);
> +			watch_address_high, GET_INST(GC, inst));
>  
>  	WREG32_XCC((SOC15_REG_OFFSET(GC, GET_INST(GC, inst),
>  			regTCP_WATCH0_ADDR_L) +
>  			(watch_id * TCP_WATCH_STRIDE)),
> -			watch_address_low, inst);
> +			watch_address_low, GET_INST(GC, inst));
>  
>  	return watch_address_cntl;
>  }
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v9.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v9.c
> index 5a35a8ca8922..76be23dcea31 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v9.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v9.c
> @@ -239,7 +239,7 @@ int kgd_gfx_v9_hqd_load(struct amdgpu_device *adev, void *mqd,
>  
>  	for (reg = hqd_base;
>  	     reg <= SOC15_REG_OFFSET(GC, GET_INST(GC, inst), mmCP_HQD_PQ_WPTR_HI); reg++)
> -		WREG32_XCC(reg, mqd_hqd[reg - hqd_base], inst);
> +		WREG32_XCC(reg, mqd_hqd[reg - hqd_base], GET_INST(GC, inst));
>  
>  
>  	/* Activate doorbell logic before triggering WPTR poll. */
> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c b/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
> index 07b299ec7169..349ece5a27ee 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
> @@ -2812,16 +2812,16 @@ static void gfx_v9_4_3_xcc_set_compute_eop_interrupt_state(
>  
>  	switch (state) {
>  	case AMDGPU_IRQ_STATE_DISABLE:
> -		mec_int_cntl = RREG32_XCC(mec_int_cntl_reg, xcc_id);
> +		mec_int_cntl = RREG32_XCC(mec_int_cntl_reg, GET_INST(GC, xcc_id));
>  		mec_int_cntl = REG_SET_FIELD(mec_int_cntl, CP_ME1_PIPE0_INT_CNTL,
>  					     TIME_STAMP_INT_ENABLE, 0);
> -		WREG32_XCC(mec_int_cntl_reg, mec_int_cntl, xcc_id);
> +		WREG32_XCC(mec_int_cntl_reg, mec_int_cntl, GET_INST(GC, xcc_id));
>  		break;
>  	case AMDGPU_IRQ_STATE_ENABLE:
> -		mec_int_cntl = RREG32_XCC(mec_int_cntl_reg, xcc_id);
> +		mec_int_cntl = RREG32_XCC(mec_int_cntl_reg, GET_INST(GC, xcc_id));
>  		mec_int_cntl = REG_SET_FIELD(mec_int_cntl, CP_ME1_PIPE0_INT_CNTL,
>  					     TIME_STAMP_INT_ENABLE, 1);
> -		WREG32_XCC(mec_int_cntl_reg, mec_int_cntl, xcc_id);
> +		WREG32_XCC(mec_int_cntl_reg, mec_int_cntl, GET_INST(GC, xcc_id));
>  		break;
>  	default:
>  		break;
> diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
> index 094c08cb98e7..aca842668c56 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
> @@ -496,14 +496,14 @@ static int gmc_v9_0_vm_fault_interrupt_state(struct amdgpu_device *adev,
>  				if (j >= AMDGPU_MMHUB0(0))
>  					tmp = RREG32_SOC15_IP(MMHUB, reg);
>  				else
> -					tmp = RREG32_XCC(reg, j);
> +					tmp = RREG32_XCC(reg, GET_INST(GC, j));
>  
>  				tmp &= ~bits;
>  
>  				if (j >= AMDGPU_MMHUB0(0))
>  					WREG32_SOC15_IP(MMHUB, reg, tmp);
>  				else
> -					WREG32_XCC(reg, tmp, j);
> +					WREG32_XCC(reg, tmp, GET_INST(GC, j));
>  			}
>  		}
>  		break;
> @@ -524,14 +524,14 @@ static int gmc_v9_0_vm_fault_interrupt_state(struct amdgpu_device *adev,
>  				if (j >= AMDGPU_MMHUB0(0))
>  					tmp = RREG32_SOC15_IP(MMHUB, reg);
>  				else
> -					tmp = RREG32_XCC(reg, j);
> +					tmp = RREG32_XCC(reg, GET_INST(GC, j));
>  
>  				tmp |= bits;
>  
>  				if (j >= AMDGPU_MMHUB0(0))
>  					WREG32_SOC15_IP(MMHUB, reg, tmp);
>  				else
> -					WREG32_XCC(reg, tmp, j);
> +					WREG32_XCC(reg, tmp, GET_INST(GC, j));
>  			}
>  		}
>  		break;
> @@ -844,7 +844,7 @@ static void gmc_v9_0_flush_gpu_tlb(struct amdgpu_device *adev, uint32_t vmid,
>  	ack = hub->vm_inv_eng0_ack + hub->eng_distance * eng;
>  
>  	if (vmhub >= AMDGPU_MMHUB0(0))
> -		inst = GET_INST(GC, 0);
> +		inst = 0;
>  	else
>  		inst = vmhub;
>  
> @@ -876,9 +876,9 @@ static void gmc_v9_0_flush_gpu_tlb(struct amdgpu_device *adev, uint32_t vmid,
>  		for (j = 0; j < adev->usec_timeout; j++) {
>  			/* a read return value of 1 means semaphore acquire */
>  			if (vmhub >= AMDGPU_MMHUB0(0))
> -				tmp = RREG32_SOC15_IP_NO_KIQ(MMHUB, sem, inst);
> +				tmp = RREG32_SOC15_IP_NO_KIQ(MMHUB, sem, GET_INST(GC, inst));
>  			else
> -				tmp = RREG32_SOC15_IP_NO_KIQ(GC, sem, inst);
> +				tmp = RREG32_SOC15_IP_NO_KIQ(GC, sem, GET_INST(GC, inst));
>  			if (tmp & 0x1)
>  				break;
>  			udelay(1);
> @@ -889,9 +889,9 @@ static void gmc_v9_0_flush_gpu_tlb(struct amdgpu_device *adev, uint32_t vmid,
>  	}
>  
>  	if (vmhub >= AMDGPU_MMHUB0(0))
> -		WREG32_SOC15_IP_NO_KIQ(MMHUB, req, inv_req, inst);
> +		WREG32_SOC15_IP_NO_KIQ(MMHUB, req, inv_req, GET_INST(GC, inst));
>  	else
> -		WREG32_SOC15_IP_NO_KIQ(GC, req, inv_req, inst);
> +		WREG32_SOC15_IP_NO_KIQ(GC, req, inv_req, GET_INST(GC, inst));
>  
>  	/*
>  	 * Issue a dummy read to wait for the ACK register to
> @@ -904,9 +904,9 @@ static void gmc_v9_0_flush_gpu_tlb(struct amdgpu_device *adev, uint32_t vmid,
>  
>  	for (j = 0; j < adev->usec_timeout; j++) {
>  		if (vmhub >= AMDGPU_MMHUB0(0))
> -			tmp = RREG32_SOC15_IP_NO_KIQ(MMHUB, ack, inst);
> +			tmp = RREG32_SOC15_IP_NO_KIQ(MMHUB, ack, GET_INST(GC, inst));
>  		else
> -			tmp = RREG32_SOC15_IP_NO_KIQ(GC, ack, inst);
> +			tmp = RREG32_SOC15_IP_NO_KIQ(GC, ack, GET_INST(GC, inst));
>  		if (tmp & (1 << vmid))
>  			break;
>  		udelay(1);
> @@ -919,9 +919,9 @@ static void gmc_v9_0_flush_gpu_tlb(struct amdgpu_device *adev, uint32_t vmid,
>  		 * write with 0 means semaphore release
>  		 */
>  		if (vmhub >= AMDGPU_MMHUB0(0))
> -			WREG32_SOC15_IP_NO_KIQ(MMHUB, sem, 0, inst);
> +			WREG32_SOC15_IP_NO_KIQ(MMHUB, sem, 0, GET_INST(GC, inst));
>  		else
> -			WREG32_SOC15_IP_NO_KIQ(GC, sem, 0, inst);
> +			WREG32_SOC15_IP_NO_KIQ(GC, sem, 0, GET_INST(GC, inst));
>  	}
>  
>  	spin_unlock(&adev->gmc.invalidate_lock);
