Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F36DAC27C4F
	for <amd-gfx@archiver.kernel.org>; Thu, 13 Jun 2024 11:25:31 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5B52010EA3A;
	Thu, 13 Jun 2024 11:25:31 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="NFdnsIRU";
	dkim-atps=neutral
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2044.outbound.protection.outlook.com [40.107.243.44])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8952710EA3A
 for <amd-gfx@lists.freedesktop.org>; Thu, 13 Jun 2024 11:25:27 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KRaE3lhOlrZTaaiWMSxxZeXnIEqcGfh/MnHTX4NGRRoHmZWpox8yGH27tbscfh6+e8aZbi2elK/twuGvCPs2lDBwpIltLAsAFyOiKBWd4XP9/jYq5+NmAJhCopvNFWiJQ5Ry4RHj0ZeLlq/YCoxDOoPX1xiOYWC/HbkeIq0ySxj4FK/qTxHpbGZfQEapXUE9P77Wqpiny3nnX53siTscd1pSdzJxxd7PtBI2eXLc4toFNmDPBthEhI5fKwp8wv0cbouuFV7u5xZTUKXQAEH1q7WF/ivKU21FxvJEbZSgEhkbNWtO3rmkc0ElY3aVf7SN3VJ0AOK+AQtvDshtV8Engg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MFSD0bgbQeuWtyg1Men2kRTh+2y0L4ukn07r80arifs=;
 b=SYTMxpUbOrQTlx/JVzlt66TOjcZc9uQ5ERrICDVHxgUSoxt99goQSQj1XFjbTp4dJNyoK7qowy4x6oKBWa/DAVRqpV5PzjK2qJb15CuS41Kf5KyLuysfsPmvWwZWIl+K1PGhkDLZWsxHoDpf5cCKFyf93rw4YqTTnsBXtcMJv8FHmIEsvN9h2sKqu5hmA5sFSnysHEIb876Jt9lXKoSelkUp8y7tsFAp5ThT0iiovUIUky71poFePVqxHDirFra1XLkJ4u+oddcK161eBkBlnobiT4sJLWlVxTTJYOGoHRNWrvMp/q3dl3oQq9hEXF6amJ783FxWluQ/REgAmm+9ZA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MFSD0bgbQeuWtyg1Men2kRTh+2y0L4ukn07r80arifs=;
 b=NFdnsIRUcvigs6o5ZXcXjl+qHQNwJN3VbyUKw+9jaL56XaXTXe3a8cdygoyC6TIK5CVvqy5Y6ysugzW2MdR4lwoB+MF8qUR7MxxrWIRkHRieHa3zWw/IrX0VME1QChQT4I6wpd+3inziNWzoohT1repP9FsximAezZzQ2MgTlUU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS0PR12MB7804.namprd12.prod.outlook.com (2603:10b6:8:142::5) by
 DS7PR12MB8202.namprd12.prod.outlook.com (2603:10b6:8:e1::13) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7677.25; Thu, 13 Jun 2024 11:25:22 +0000
Received: from DS0PR12MB7804.namprd12.prod.outlook.com
 ([fe80::8327:d71a:ce21:a290]) by DS0PR12MB7804.namprd12.prod.outlook.com
 ([fe80::8327:d71a:ce21:a290%5]) with mapi id 15.20.7677.021; Thu, 13 Jun 2024
 11:25:22 +0000
Message-ID: <d6822369-c2f0-4132-a746-03d2451b25ac@amd.com>
Date: Thu, 13 Jun 2024 16:55:12 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amdkfd: add ASIC version check for the reset
 selection of RAS poison
To: Tao Zhou <tao.zhou1@amd.com>, amd-gfx@lists.freedesktop.org
References: <20240613111358.31261-1-tao.zhou1@amd.com>
Content-Language: en-US
From: "Lazar, Lijo" <lijo.lazar@amd.com>
In-Reply-To: <20240613111358.31261-1-tao.zhou1@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN2PR01CA0221.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:ea::17) To DS0PR12MB7804.namprd12.prod.outlook.com
 (2603:10b6:8:142::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB7804:EE_|DS7PR12MB8202:EE_
X-MS-Office365-Filtering-Correlation-Id: 0dcb14d6-d920-4125-f3bb-08dc8b9b8344
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230034|376008|1800799018|366010;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?amJTWU1ZdXlwYm8zenpMTUJLZGNUR2htY2M0LytKRXYxRlFSaVhvMHcrNkZU?=
 =?utf-8?B?TUdydnNzUlJIMHlzalNTMVQ3TFh2UnhYYU1OQUpzU0x0d28rWFVtTldpWXBq?=
 =?utf-8?B?d2daeG83Z1Z0NmMxTmY2RXpBM3ZJcVVxL25SNkFYOEpoWVlhenQ3Z3BSbnFL?=
 =?utf-8?B?SkwySzBBb0VjY3ZvVExIZ0RjNkxFWlBiMTF2YVJBOEVEVUdYZm5QdWl3R0Mw?=
 =?utf-8?B?OFRSM05ZZjhvYjJUM2JXdm1rS2NMeWlpNEFnZDBXTVBTTVlFNzRJcjZSZU5F?=
 =?utf-8?B?NnZMK2pBd05uNGYzMWtHQWVBOGRPTFkvaFVkZW1WcGVGMVV4enhFMzBjMDB1?=
 =?utf-8?B?ZzBUb0xRZzkzRkVBb2ZxQ05hZzhEa0JNTDkxc1RLSDdTa3RxTGtyVEZUK1N4?=
 =?utf-8?B?ZGlPOWVYSzEwaU9UWWd2QkppTUpMS3Y1bVN3V1IyRm9adGRuQkdjN3dUNmJF?=
 =?utf-8?B?NmR6Y2NQYWRObEJ4dU9BOERqUG9wRmFKNmloL1FIWTZzZlFiNnZaMnNMb3dH?=
 =?utf-8?B?OVNmdnNqOXBLc2JzVHlJOXV3ekRrVkdhTzFoZ09qTExtRXZONFZiSGN6bi9I?=
 =?utf-8?B?NHplcWFlOGt0T2syazJTSkE4Vyt0OTNBeTdLT2JRaUJRTndUT0hEYjhuMzlo?=
 =?utf-8?B?MWVsR01CZUFFK0E5aUgyR21HcW1yeFdHVkduaGpXMmc0aWJ0cGRSSGM4U0xM?=
 =?utf-8?B?MVBubnBlYmFkTXJOY1o3TUNXOGFvcmhYQWUwMlkwcUZacEhtWEhrTnBVejB5?=
 =?utf-8?B?cGU1SG5oNXp2Q0p1TW1LVmdJZnhOL2d6ZHFIWXErYzdTTklIOU1sUUkvNG52?=
 =?utf-8?B?RXhINTY1RHBLNGtuUkVQVy9UbFF6WXRZOHF1VjdSNXhFVUhWYmhsaENsWmlo?=
 =?utf-8?B?OCsxTXdKM1FtNlBra1Rmazh3VjZDamU2czBMMmRMbHhRWlAwRGp2U0tMNHB2?=
 =?utf-8?B?VzY1cEFWQzloa1l1OU5oeFY4bEVlRUFyMUJoNFdXdW9sY1FTYmNVZ0V0Z0JP?=
 =?utf-8?B?aU9Rb3hUellHMGxoTERxYTllRk1hUUV5WXo1VkRTemd0ZUVsUWZhamw4OEgv?=
 =?utf-8?B?T21lMDJzcEJKd1hVRXhrWnhSbGU0dUdNU0F6dk45VHpWOFNNam1CN0pTalZq?=
 =?utf-8?B?dVowOVpUR0VxQTJwanE5bnR2QkQzS3g0bFFWb28yaHdiUk1DU0Q0dllMU3Rk?=
 =?utf-8?B?Yk9makp1dDZCa2tWcWVzN2t3M1djZ29WZVNMWFlTOUVNOE5BYWdUR3JUaXhO?=
 =?utf-8?B?RDZnTkY2TzdsWTl4T3dPUjhFMzIvSzJjQjl5aW9HRmt2MTVVRm1KanVrc1V2?=
 =?utf-8?B?WlYyVUVDZ25tVzJrRXlvOUNGeG1VMkZaM25SY0hyYWI5UFVWQmk1N240dW4x?=
 =?utf-8?B?Q0FkL1libDlSQVRQb0hiRTZ5L1h3cllvb0NoWUlBMzlSdnArZlVVVGIxdUdk?=
 =?utf-8?B?QXFPVjFONUMrYmVvdXl5Z1JJN0dZRzZXamdqQ2l5NGZQSGVpK3VjQU9kak1n?=
 =?utf-8?B?ejg3c0RkK1VTcGQzNFFNK09UQSs0bkphd29hQzlHT2d2QlVXSXFwZFB3eEF6?=
 =?utf-8?B?b3JwUkg3TEtLY0ZrWDVtZkJyczFnNTlyMWhuNFZrNTRwZkFTdzI2V3M5UnI3?=
 =?utf-8?B?UDNWaXUrbUIwR1JZNXVtUnl3dkxLSEF0cU83dkVsZEtTTjk2VzNXSDg1aEh6?=
 =?utf-8?B?VHZQeDVSSjZ2OE9IR3MrOWxBUGV3R2hIR1BTbnZEcGlmYXZTREFiYjArcTlJ?=
 =?utf-8?Q?JL34kz9uGc4bYb2dHodZGE3daYmGURJvivYLEzR?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR12MB7804.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230034)(376008)(1800799018)(366010); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Unk4T2xwaW5keE4vSkttRFdGS2lSY1B4QzhqTXZ2eXpkeTgraGowQ1hsT3Z3?=
 =?utf-8?B?UXdQNUV2K1V2aFNnZWs1MlhwVFAzcllsMW5tOUlSMzgyOVVIOXh1ZHVubmdx?=
 =?utf-8?B?NUcxSEhrYlBZR1pkM1owOHlyWXpvMGR2blZvNk01Y01uZHpBUkFySTZFQUMw?=
 =?utf-8?B?bTBweGhqb1djVXRGTmgwd1RsN3I0SkRWVjZBa05CUHFGRmM3VmlOb1dBams3?=
 =?utf-8?B?ckVFcU1rK3hoZm41WlJNQmRqSnUxZGVsWi9TU09XeWgxd21nUW4vc0xvNE5i?=
 =?utf-8?B?NXhMRUZIZU1WamxJdVBDcU5yWjlNUFRQSnpUWkFyRVBoYkNvTzJDYnV5WDRX?=
 =?utf-8?B?NmQ4ZXZzTTJ2cG1xYTYvZ1JsSEx5VFR5d1BBdUo0eWFmMU44MnZ6RXkyc2h0?=
 =?utf-8?B?d2tHdFUrZGJVbDk2RHNDYUc3TkY0cFIvNys5YWRvdTFwWUNHN0NxbnA5SnZk?=
 =?utf-8?B?SEQ3YW1CNVRoSFc2MjBmWFo5dVdNMncySnp3RTJFNjh0ZHQzN2RIUkhlTldt?=
 =?utf-8?B?cTg5dm8wVVV4c2dibk1ETUlWNHJ5V1AzOGpjVHlEd2JwMllpUllkMjltTEhl?=
 =?utf-8?B?YVloc1Z6alNsU3c4VURVcnFGTHJXc1pVZFYvNUFPc1Z4RWxTM09Vc3VzN3BJ?=
 =?utf-8?B?b3o2ais2elF4MVBvMXRQL2VBOVhTMXR6MTl6TGdDTCtqWmxrd2dHSmRueTVn?=
 =?utf-8?B?cm4vM1FOY0FDd2dwS3VLaTJ6cTlKenRyaStWUzZVc21GbTMwY1Zvc3JMSmlv?=
 =?utf-8?B?dmp1enNkV3U2cm1jY2M4alB6bElaQ1JtVG9IbG9RcExOSkVSVk9mVUFzU0hy?=
 =?utf-8?B?M2ptcVV2Z3U2R0Jwa0tQVWpuQm55QjBRR0tEWW5BMzcxR2xrQlBOYXk3NkpX?=
 =?utf-8?B?Tjluajh2QjA1SVFKSTNvbi9nTE84TUhBdE5IclIzdTQxRWJDUjJRSWRVSGdh?=
 =?utf-8?B?U3l5MENtei9SSy9sNjVqYlhybTJWdEZWNG9RUmN1emZJWUQwRGQwckpJRkhM?=
 =?utf-8?B?NDd2ZUZXMFdsMWJWNlVWWHNROHR4eUNvYU1mcDNySGFNbytwamVZTWVWcnNU?=
 =?utf-8?B?ekkva1ZPSWZyWkloU3RNN2NmTkEwZElLWG4zN0VsQ2s0S3kxeWFkMmJKeVBk?=
 =?utf-8?B?OEg5bzdUM0U5TzNYbUp3MDg5OVBiRnVKejNxRXhOUS9VdXVPRjE1MUp0cU0y?=
 =?utf-8?B?MktkVDRWbFJEejZsSFBuWVVzNjhUeVh3MXlUWGxQV1NJSW5naktPOWVhRDRn?=
 =?utf-8?B?K1pNVFk3TE5pZkI2TUg3ZTNYaWl2OTdqc3pEV3ZGSHJBK3lnc0NsSkhSS0h1?=
 =?utf-8?B?TzRYMVhHV0RWUXBXQ3hrc2p5NG9oMkJZS2xEcUxHYlBYNldxVGFDYmR2eS90?=
 =?utf-8?B?b0FVNXVGeDVTNWN1Q21ZTXlYeEJ0L0VyMmNENGVHNjE3cHIzeTFLMVVaRFZY?=
 =?utf-8?B?WFBNaGhIQytRd2lmSTByTndaMlBVODUzRnZRdVk0NVU5QXVhVjZ6TWFYeGt1?=
 =?utf-8?B?cG5oZ2laRmlraU9DRTdIWE1INWlDTmRCQmEwcENZRlN2M2hsdzFWdTkvL3Jh?=
 =?utf-8?B?bGpUcnd5NHNUVzBXQ0xXUUc4OVJVVmROMXhQanJ4UU51cUFHQ1JCZkZzcjcv?=
 =?utf-8?B?SVp3QmRSaC90eVUzQmVvV0dOTWVPTjg0cHlhNnQ4TkZvZWJvZ1l0b01EZmIw?=
 =?utf-8?B?T3FCNXNCTi9TQ0RkUmcrclJBMVpveTFsSlg3NTJGL2ZrSzdHOFVTQUVLUkgv?=
 =?utf-8?B?Mnd5dEw0eXFSdk5ZY0MySVBDMWFBUHhuaEZuY0lKVUQ2S01nZjU3OGtyazhO?=
 =?utf-8?B?SlVvSUhHUjBjNVhreVc4WExvSnp0b09rd1lNZFI3R3lESnNQUkxoS3Z2MFZR?=
 =?utf-8?B?NDd4cEZ1VDJXdjVTUVFmeDZJdHFvU1phMHh3cU1LK2piSUFxQm9ZcXV3bG50?=
 =?utf-8?B?Tk01eFNCZW4yRk5abWhid25PUXo0YlNUeVFsK2FPaVU3RnIvY3J6SWlrMWVX?=
 =?utf-8?B?WUUyUXNLTEkxdnFlanZwUHZyTktER3lMU2toSDBieTA1VjlTdU5RcDA3Qisr?=
 =?utf-8?B?c1NuV0xrQ1RXbGNEZmVUamJ6M1NpWGhiNFpFOURpcHp5cGI3eDVYWkVMNVM5?=
 =?utf-8?Q?nc+yfwl6cUbt6VO0aGVaRfVMJ?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0dcb14d6-d920-4125-f3bb-08dc8b9b8344
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB7804.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jun 2024 11:25:22.1779 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lbP85TDdXuFo3AYnwjYdXXAV/26tvDZ1K+JqK05unAlsoG+VHs+6D6C+RINXqk/A
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB8202
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



On 6/13/2024 4:43 PM, Tao Zhou wrote:
> GFX v9.4.3 uses mode1 reset, other ASICs choose mode2.
> 
> Signed-off-by: Tao Zhou <tao.zhou1@amd.com>

Acked-by: Lijo Lazar <lijo.lazar@amd.com>

Thanks,
Lijo

> ---
>  drivers/gpu/drm/amd/amdkfd/kfd_int_process_v9.c | 10 ++++++++--
>  1 file changed, 8 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_int_process_v9.c b/drivers/gpu/drm/amd/amdkfd/kfd_int_process_v9.c
> index 78dde62fb04a..816800555f7f 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_int_process_v9.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_int_process_v9.c
> @@ -164,7 +164,10 @@ static void event_interrupt_poison_consumption_v9(struct kfd_node *dev,
>  	case SOC15_IH_CLIENTID_SE3SH:
>  	case SOC15_IH_CLIENTID_UTCL2:
>  		block = AMDGPU_RAS_BLOCK__GFX;
> -		reset = AMDGPU_RAS_GPU_RESET_MODE1_RESET;
> +		if (amdgpu_ip_version(dev->adev, GC_HWIP, 0) == IP_VERSION(9, 4, 3))
> +			reset = AMDGPU_RAS_GPU_RESET_MODE1_RESET;
> +		else
> +			reset = AMDGPU_RAS_GPU_RESET_MODE2_RESET;
>  		break;
>  	case SOC15_IH_CLIENTID_VMC:
>  	case SOC15_IH_CLIENTID_VMC1:
> @@ -177,7 +180,10 @@ static void event_interrupt_poison_consumption_v9(struct kfd_node *dev,
>  	case SOC15_IH_CLIENTID_SDMA3:
>  	case SOC15_IH_CLIENTID_SDMA4:
>  		block = AMDGPU_RAS_BLOCK__SDMA;
> -		reset = AMDGPU_RAS_GPU_RESET_MODE1_RESET;
> +		if (amdgpu_ip_version(dev->adev, GC_HWIP, 0) == IP_VERSION(9, 4, 3))
> +			reset = AMDGPU_RAS_GPU_RESET_MODE1_RESET;
> +		else
> +			reset = AMDGPU_RAS_GPU_RESET_MODE2_RESET;
>  		break;
>  	default:
>  		dev_warn(dev->adev->dev,
