Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 57032FCC9B8
	for <amd-gfx@archiver.kernel.org>; Tue, 10 Mar 2026 05:13:05 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C120510E1F3;
	Tue, 10 Mar 2026 05:13:04 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="wrYLklor";
	dkim-atps=neutral
Received: from MW6PR02CU001.outbound.protection.outlook.com
 (mail-westus2azon11012043.outbound.protection.outlook.com [52.101.48.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BC46310E1F3
 for <amd-gfx@lists.freedesktop.org>; Tue, 10 Mar 2026 05:13:03 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BvlhQAgcsMwvG/9PJTdeGI9l4RRhzD3jkKlgee74Ba4napR1VV2lMsANg6swap5Q4WOC8vmbo99Qfr08dgxyaHnjCGtzUJ+mS2fPdRv5l++WZhG2wjn57C5xsoo1URB+Ky9+P0efIVZ44phjmc0tu6h0djVgfLfoXZD/WFDrfIPF2rpue/38XDMPLKgVlghRaMjyUFel+r1NJHTxaEIHrnclejKV318Pn3xY9bRNMOecjvLqrfm271iOTd7pSH8Rm7pE+sUjCUMX5ftKl53tEEBpoKCZcWbtGmCd1GNpCHtZ07cK7SOKiuYHm73LClE926/Dq4fyZa0GecBLBbn9kQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=E24nYLu1G0sip4zPANzBQOOU3bcQ/U9E7srkQrL4FmY=;
 b=uEyernuR7uLLZ08+bXnZb5XRqVeckN67XiHjhIs+SopEdfKoOFjQQ6TYDOhWvEN/yV/mwOETQk2p95fKnC38/uhU4boi8X7IZbMZw+QbuP2oiFYg9ShMc9PoFL6s3agDBVrf9Wv9TUDqSgaEnoKeOde+GfWbl8YgvjqvmhUuMAOaK+RdGrUax+FLv3rrm0efhUUGRmbg/wOswCvLoqpk/Jcut2Wa1BY45asEwWkhyazZjTNjs/MuVWyRwMIAB1MqT1r4YV41mxLvVXQSYf2B3JendXh1Lh2xnrvQujP3YeMtVPPZOZQM0VQfnGt5e5NqtmQxz/7gyw0Xpac2a4OZbA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=E24nYLu1G0sip4zPANzBQOOU3bcQ/U9E7srkQrL4FmY=;
 b=wrYLklor2i/FNa837U2EcOE67M8CG624NywrBa767/tlbc+WdPS7XOUlUMA4UIQsirSgUtmPAqXBVXsdPUkPgwoWo+bs/attP9/Opiuna7+nY9K7K15geqfJqZlPQPEdtE1+6d1S1j6+sLH0uVuvjGH4EyC0LNq710zhjCDupTM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SA0PR12MB7091.namprd12.prod.outlook.com (2603:10b6:806:2d5::17)
 by CY8PR12MB7147.namprd12.prod.outlook.com (2603:10b6:930:5d::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9700.11; Tue, 10 Mar
 2026 05:13:01 +0000
Received: from SA0PR12MB7091.namprd12.prod.outlook.com
 ([fe80::ec33:1213:cfd8:63bc]) by SA0PR12MB7091.namprd12.prod.outlook.com
 ([fe80::ec33:1213:cfd8:63bc%6]) with mapi id 15.20.9700.010; Tue, 10 Mar 2026
 05:13:01 +0000
Message-ID: <490e342a-a528-47f2-b9fb-d779e6fe89bb@amd.com>
Date: Tue, 10 Mar 2026 10:42:56 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] drm/amd: Set num IP blocks to 0 if discovery fails
To: Mario Limonciello <mario.limonciello@amd.com>,
 amd-gfx@lists.freedesktop.org
References: <20260310022231.2838680-1-mario.limonciello@amd.com>
Content-Language: en-US
From: "Lazar, Lijo" <lijo.lazar@amd.com>
In-Reply-To: <20260310022231.2838680-1-mario.limonciello@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MA5P287CA0072.INDP287.PROD.OUTLOOK.COM
 (2603:1096:a01:1b3::12) To SA0PR12MB7091.namprd12.prod.outlook.com
 (2603:10b6:806:2d5::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA0PR12MB7091:EE_|CY8PR12MB7147:EE_
X-MS-Office365-Filtering-Correlation-Id: 195a3a5b-3b7d-4dfb-2cb4-08de7e63b39f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info: odyOn3L9P3eoBx3QAaEaXu9U3pP4uiMNBtMsipKfieuIwYGfamd6mlhvd+wz9pNgL9rcg/3FH+sfMSEUP8mG/+A5bFom568PkEx/VCCLY/+35+FM8UWq7JVuked8O89HITJb7fGbHVN3pg1qzNb8ta7FRJRCebKcivCGTt3QhipgsTc8sr/fM3gIZV/deA3wqlSJ6TmuhfKBlJKIIa227rcpBOSzDObxuKz/H6RaY9Jpm4MloeiZeFoIhAX3nJSNixC6C41D+oWoet2VUgklkjbh4peChqJgFnshb9JEv8xMhMpt/Nqm8WS3bYvdgZ2LdYYgnzJgLxuAWUaroi4x1nUrE1q9J94T/R5UBbRcPpiG946v44h7RmV8T/1xw2KRlmVVGPgATw55dM9Wl851longI1gb1m2OEH+wpBV+L3YmFudXHocRoHIlLhYqtemej0lMSlOfv2W9AOnLF5vaTRmZBZxkuwTJPItg1SzkBdFlnR0Y66CheteUpmPEoKXMpAvuSWDIgftASJyEbg2hn4qdrNO8ZwlYJ6adfs72Z9PBlzjqGPO0n0eVvCt0kd8UdeYcTTf6GeYQ0A0WWq5uymq1Xr4Fhwua46F9hvqVz6+sYUAep6cyUglDWOvgl/XmWn6rfOOTjjFSpPoHV6IKnMbFfkiPX5rN6uUao+AuojOdYo8BYJsTlUjliRgjUWFKKfXIdnavEvSD29Ngf0SSNYDTqkj9fImQI9HCktP8S2o=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SA0PR12MB7091.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NXhSN2IxalhxRCtkUHV0ZndxS0tpL0NsU0I0L3JYcHBmb3RRc1grcm1NTXFQ?=
 =?utf-8?B?WXE5QVlsM2h3bEJMclRsSHI4eXI4VkRnOW9zdytsRS9BbzEvWGZ2ZXJmNDVX?=
 =?utf-8?B?dEp3Ujd5aFVBaFRJZWEyMWQxb3JyN0JOYUcvcUZ6bnRUd1A4YnBqaEM2QmFi?=
 =?utf-8?B?M3c5NXVWVjZHTEJpeXlxNzF1NStOSzdhcG9nRFMxSVlpcHF3TXZUb0ZoNEpn?=
 =?utf-8?B?SEpjTmNWbzNHeWtaYTVtUlc1RFNuZlovVFlKWXNqcTdmVHRTcW13WmlFamM4?=
 =?utf-8?B?T243NlorcFRrRSsvS0JCeWtEOXFWaExUVHhWbWhMOVQ1SXJmbTlPczFxdnpV?=
 =?utf-8?B?UU9BOVo4Z1dPOVFTU25tMVlFdkp0amN6NTUybWZLcXRzMDhNa1BXV3g4a0pn?=
 =?utf-8?B?TUY4YVdralFlYm9YdGdzd0pSVWhmMnRVbWQ5Mlh2VVlWK1ZOejlFYys3OGF5?=
 =?utf-8?B?WDB2VXl3ako5cnZzTHBhbnU4OEgvVHVtL09jUWFIcU9vRTFyRk9EdkJPdHRM?=
 =?utf-8?B?YytpL25SYjZBV3liRFVDRkQrd3NPWGUyM093bUhLR3ZKczEwWjdMNEhRNzhx?=
 =?utf-8?B?YTNFWUNlZ2t1VEpJZHp1V1FTNVdaYkFyaVJ6ZS9mSXk0R1RrWFFiWUFVWUVF?=
 =?utf-8?B?NStPY3R2RjdOMUNDN05uUDdoU1IxM2NweDhtemZEN1MwbWdHRStsS3M4YVNj?=
 =?utf-8?B?SGVLcXBveU1Pb0t3TWNpM2JvQlV2amNQRmoxZEI3T2JqR0RuOTQ1cXlrNkQ3?=
 =?utf-8?B?UDZSYkY4TUh5K1A4aTVyU3V4TXk0b1JNeFlOTXNvMzJYV3hLdXpiYTZOdis4?=
 =?utf-8?B?NERLNDc2ekZnaVdZRkdwaU8xWUNTOWo5TitEdHZqN013bUZkS1dHN1JlU0t0?=
 =?utf-8?B?ZVprYjUzbUJ3NWFhckVkeXhHN1JqeWtTaGNtRHJBbFNCSWxyNE1lOXp5M3h6?=
 =?utf-8?B?RHZEUWZCZ09DdVRsMWlYRHo2TlZnRXhBSUNvczk1N1AzZmIycU8xc1hEb2E0?=
 =?utf-8?B?Z2tJbHVjbnMrb1A0c2Q5WDRmQ0dYRlIzSkVNWjFrOFZkRXRuZDREK2dlemdr?=
 =?utf-8?B?RWJUTVlIdms4MWlIbHZERjIzYm9KdWxGdGJoYXZsdThKalIzY1A0dmkyTjB3?=
 =?utf-8?B?NHkzS05MMDg3c212R2dLUVI4ckhkWWZ3anJhc1RWSEM2S1lMMXlWN0szZ2tU?=
 =?utf-8?B?YjZmWSt2YWc3V3NrMWFTek1FNHZHSElLQkk5ajRTaHhLendmVk43VkJPYU4v?=
 =?utf-8?B?TjBYWC81MEFBdzN3RDlqN3V5QUlWSzlWc3lSTnBtY0d1d1hMdWNOWFlwUWhG?=
 =?utf-8?B?d2p3ZDNuNGE0RGozVWZ6Sm5CaFp3UkNhcVlNcnVqNVVQemtTV0U1Wjk4V2F2?=
 =?utf-8?B?UlZ1b2dYV3BuYWJTdE9tbFpGVE9hT1h1TkQ2OXRabC9LT1l4L3pPdDFLenFr?=
 =?utf-8?B?V0ZaZUhNc0lYZmVzdzVrdVBJOXc3ZkdTeSszUVdweldYeENZYXUzOWQ0SkZE?=
 =?utf-8?B?aXk3YVBXQlgwMWhwT3pzSldlZURDeWFuanBDNjY3OWNYbE9HMzZJSG4xOE1j?=
 =?utf-8?B?VGdKbE1tTWNMLzlKWjMwUlhhOFZpN0hBQnJ0SHhNRXpsMzV3aTFjWHBZL1h2?=
 =?utf-8?B?Qkw4aDA5ejVUb1dkYXdjcC9mQ2ZMbnlhN2dUMFpCaHZuQUtqZ2N3Q2hLSDJ1?=
 =?utf-8?B?Umlid2cxT1h6Tm1uVE5DTVZMd2F1czMvajVuZFJLbkV1OWFxV0FjWTdPc2da?=
 =?utf-8?B?ZEFHcXcrUWRGaUEzdURZZ2p1LzVQTDU4K2ZFWEVoUXI3UGxZNXFFK3NGd2tV?=
 =?utf-8?B?aTFMM0J6VVJ0NFB2dUtIM2JZN1BjcDhwMlpoOXZ3Sk5iVk5wRlVLaG1GMGh6?=
 =?utf-8?B?K0lDN1VzbWFrR3ViR0FNbk5TanorWHhoc1pjNS81Y3diT2padWE1SnVsb3BD?=
 =?utf-8?B?MTdqU3psdjRuTlpzTDNPS2tDTHJGTW5vRVQzN1l4empIME1vS2dTUVpOdHdE?=
 =?utf-8?B?OFVocHlsMkhnQmppN1pkQ2N3dEhXYU0rRG1sb01JMFpmanZGd3NCQkJQV0FR?=
 =?utf-8?B?b245bENMUkQ3M29EakpaRmRHVWFSZXFCWWV3RHhIMXNwMkpVKzdQM1hvRDVG?=
 =?utf-8?B?M3ozYU9OYnFSY0lXODcrYUxEVkR1clJSMHRua1hkeHJlUisxMHg1YXREdEg2?=
 =?utf-8?B?N3NjSitxbzdqckVFVjFlOTNMUnJTVStFZUExRUc4bGx3dnZMZk84OWMwTUpa?=
 =?utf-8?B?MmNvUUd4aUk3dVlxL2tjOGY2M1NoczV3RFJGdVdSakJ4S3A1WEVsd1pXVm9I?=
 =?utf-8?B?VzRBcnJqUlZweDNDN3d0YytWUHlsUGhrZHYxVXNSMlJxV3djeXAxUT09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 195a3a5b-3b7d-4dfb-2cb4-08de7e63b39f
X-MS-Exchange-CrossTenant-AuthSource: SA0PR12MB7091.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Mar 2026 05:13:01.7231 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7StRQtx8SBSiDTL/zs1Dgu3C+WK1/i3LpJq/28LMuyyXGSV9zZHrewMOEcs1doKf
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7147
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



On 10-Mar-26 7:52 AM, Mario Limonciello wrote:
> If discovery has failed for any reason (such as no support for a block)
> then there is no need to unwind all the IP blocks in fini. In this
> condition there can actually be failures during the unwind too.
> 
> Reset num_ip_blocks to zero during failure path.
> 
> Suggested-by: Lijo Lazar <lijo.lazar@amd.com>
> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>

This will do specifically for the ip block checks.

Wondering whether amdgpu_driver_unload_kms() also should be modified. 
For ex: calling amdgpu_unregister_gpu_instance and 
amdgpu_device_fini_hw() don't seem to be relevant if discovery fails.

Thanks,
Lijo

> ---
> v2:
>   * Stop chasing NULL pointers (Lijo)
>   drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 4 +++-
>   1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> index bc6f714e8763a..042f24a0e10fb 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> @@ -2701,8 +2701,10 @@ static int amdgpu_device_ip_early_init(struct amdgpu_device *adev)
>   		break;
>   	default:
>   		r = amdgpu_discovery_set_ip_blocks(adev);
> -		if (r)
> +		if (r) {
> +			adev->num_ip_blocks = 0;
>   			return r;
> +		}
>   		break;
>   	}
>   

