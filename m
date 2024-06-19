Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E5AC5C27C53
	for <amd-gfx@archiver.kernel.org>; Wed, 19 Jun 2024 09:31:11 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 413F110E246;
	Wed, 19 Jun 2024 09:31:11 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="mIOmOSmo";
	dkim-atps=neutral
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2066.outbound.protection.outlook.com [40.107.93.66])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8867410E246
 for <amd-gfx@lists.freedesktop.org>; Wed, 19 Jun 2024 09:31:10 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NS7q+IHKZV2B/imw2Y3e/G9EqAiDKZRXiMYM9+7CWxwNh6NGsoG/4NauvfaU6dXRAAo+lJ6Hl9qzZU5UD0ILbjXTxOTWBA2t6A9XaPO3YW5/wlzUla86WAL/EQ2KsUOZe1zSaJvAiNOkShgK56B1RJsp+3wgVqvVcBZNbRHBcxVxFx4MyR8bp4q+na1tZjd4w0UWI71bfu1tcBEJMCOYHlFGunvObXFA9lqXDr4r3VQlRXpcRpRyCetxzH470eeri+HOnAjzb9AkiAYzBj2Egh25tBsNiJ9WB7hdpD2F/W29SDJp11kDQJP04s7ANnFWFrCrqeUvfZp4uvAo3xDV3g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=al0Zg6IUOLRc85p1aMdX6VbUp1gnQizecoSTvdD/6E4=;
 b=TeRPI6U4qL6wUI35rYP5GWKSbPfr8IPtsPGlEaFgiuJCoa2EGmZB8u6fjGdjszTh27AXyyVoNpX9K98l0hVC4CjClSldUbAQmf2euKSKfad3dNNREbNHGRsxPwt/gS6vG9nNVC3y8WfVIgNBIJZ4H+CjVv5Kr+RDst8K+LJXfYgz+jqBrBT/IGzbRdkFO74Wv2dIMyJ5OauR4PyTPKmiiPGEFzFuSD62JT0FStcb7BnMWpoNFhAeqbGHPzgAtv4Hoh1m+jmQ1SDK5WdCebpQ7ZmbRqkICSzykKfvWsiNjiVszoaivvKi0nTIDBlhUSkR+1GZqih+pQC5EjVyz5P7vA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=al0Zg6IUOLRc85p1aMdX6VbUp1gnQizecoSTvdD/6E4=;
 b=mIOmOSmoRoChkKO06a/MM9rDnlvN+7Djbpv5ftwodGCqoq1GyWrdcUw5dypLNXNMZRqZlGV5j3lye2qZINFOIoZ4b+ypW0UiQKlDNPwKgJ9gvzymowwL2JtSCl3360A7iKtxxt+Djux4YdR7cNtSoX/2R/UkE5q8epN75uRRHlg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by PH7PR12MB6934.namprd12.prod.outlook.com (2603:10b6:510:1b8::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7698.19; Wed, 19 Jun
 2024 09:31:05 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5%5]) with mapi id 15.20.7698.017; Wed, 19 Jun 2024
 09:31:05 +0000
Message-ID: <bbe4d387-ca6a-44a5-a143-dae794d23312@amd.com>
Date: Wed, 19 Jun 2024 11:31:01 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/6] drm/amdgpu: add AMDGPU_INFO_GB_ADDR_CONFIG query
To: =?UTF-8?B?TWFyZWsgT2zFocOhaw==?= <maraeo@gmail.com>,
 Pierre-Eric Pelloux-Prayer <pierre-eric.pelloux-prayer@amd.com>
Cc: amd-gfx@lists.freedesktop.org, alexander.deucher@amd.com
References: <20240618153003.146168-1-pierre-eric.pelloux-prayer@amd.com>
 <20240618153003.146168-5-pierre-eric.pelloux-prayer@amd.com>
 <CAAxE2A6sQrU94uisM00kZs=P2pguTcQJjEtUX_Gum_vPjZ2J+g@mail.gmail.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <CAAxE2A6sQrU94uisM00kZs=P2pguTcQJjEtUX_Gum_vPjZ2J+g@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR3P281CA0187.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a4::15) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|PH7PR12MB6934:EE_
X-MS-Office365-Filtering-Correlation-Id: 6497da47-81b0-40e7-acde-08dc90428b17
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230037|366013|376011|1800799021;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?eTV0SFJHM0w3RnYxeHVsdVI3SERqaTZDNFJqcG15S203ZmZsZzRZZDNiU0xX?=
 =?utf-8?B?ZUpEaTVLZ2E2S1ZOaWpYdUVadC9lY1lWb3N2c3NZbDJ1TVlhQm85azg1WE90?=
 =?utf-8?B?Rno5OUMrNFBPRGl6Z3R2VnJSekJENExUd2J3T3pLcGlYTVhHblNMRS9oeVY4?=
 =?utf-8?B?Z2dFSGZscW5mVFhEQjNkOVQxU01sQkZ1ejdPWlo5eGxXM3laR1prSHU2Njdj?=
 =?utf-8?B?anNyYmN4WEJRUVEwa0VTREhHR1pzRVpYQkN5UXpJczhRZVNJSitEWkJrN0pL?=
 =?utf-8?B?bXF5b1I0eC92L0I4Y1kwYTN0dFVTUE5lWUpTa3hxRkZWM2M0OUVnWU1pb2NQ?=
 =?utf-8?B?TUxFeFBZVVY0d1VIelRUZzFYeWRob25MQ2NFSUtLUnYyZWxPTEU4MGFBS0kw?=
 =?utf-8?B?TkNKdVJoc01SZjlzakFvT1IrLzZkOTlvU20yaGRMbFRJZ0F4YUdGTS9OclRz?=
 =?utf-8?B?Vi8rd2p5cWZ4bVBJWkUxTmlUaDRzV3JnSEFRUXJpL1p0YTJSRDFaNGFML2xD?=
 =?utf-8?B?QU14amJDNDYwd1NFYlQ0bHY5Z3VKVWxqVm4yWXQvVEpLWCtOaGZUNXVra0U2?=
 =?utf-8?B?WDNPVlBuZXRyOWlFTW1LREtTTGhhMnFJOFMvTk93TzdUMm9RYjJYWHRpZU5q?=
 =?utf-8?B?Sk5Tb0ZIWFZyaGw0bm1pRFQzZmFDYitDM2RJQ2VSTHpidU5UTnd0aGhtZE1L?=
 =?utf-8?B?QXp0SkFZaGw1WWZrTVQzWGhFQkZqNUZ2MFp2c3M0UlNvZEZGazZ3UkVJSDhn?=
 =?utf-8?B?OXhnL3I5NjI3b3REcE9Lc0Yvc09nYm1DN0lsZkg5dmRRNHFoT0puRGV3d1or?=
 =?utf-8?B?WTdhdWtpOGh2WUNhZGhNTEx1UDVNMEdndXYwZHRKRGo0Qk53MElXSFowNE96?=
 =?utf-8?B?aXhnbTJMR2NsWWFyMTB2WlBFOHl5bFk2MzVpWnBxMVNPeWU0cy84NzA5Mkdq?=
 =?utf-8?B?cFNMYTdraURQem41RzFnNnFxYk93OTFLWnBQa1B3QmxZaFJxLzhBOGV1Y2dU?=
 =?utf-8?B?bUVNNHdqSkpRbUdjOERGUzFKVjJ1NnlHbzdVK0M1ODFubDYvL2kzNldWSmUz?=
 =?utf-8?B?Yjl3MUZnajdxSC90L3o2eEJUazFWeC9VRTRoeDNCUk5rQXV5TkFFcC9NUjht?=
 =?utf-8?B?SkV5R1hSdnZEeDNuVmhETFZ5TkcvTm1RcTBiM1l4VXgxeTlRYWpjazh4dXdh?=
 =?utf-8?B?VkhrUzlZeUx0R3k2TUJpODBmeTJLQXlvMDJXZ0ZhMmtEczhjOGRRWG04VkUw?=
 =?utf-8?B?ZCtJekhtb0JGTjdKNENtL0xrdHErcGJSWC85T3BxOFJpeWduY0hmT3FVY3li?=
 =?utf-8?B?b2lGcUZ3c1FDSGtaajg4VFJDbm9ULzFPSWVVTlExMWhseW5RYy80OU1nWFEz?=
 =?utf-8?B?Nk5FOVZnMEIzenRGeC9ZV2pPQWM4RmtMb2hlZTlTUHBIZllicUFacERYWWxo?=
 =?utf-8?B?MTNHellza1JzNWFkR0htVFhOTm1uZFpVaG1IWkx0OER4YitMeHVCa2plRFZp?=
 =?utf-8?B?NGllSXB2UEJPL0k3b1lNb0hKOGpmcFBudFFnOVZhbEZBMTN3ZHdOREk4dFBt?=
 =?utf-8?B?eTN6TEZuTXY4a1FGeXBqNER4SE5TWGovLzlqd1U4NVdzMVI2WjFlb09NZTBk?=
 =?utf-8?B?dEVGanYrOU1BQzd2YWxMMjJLazJzUlllR0FwSFI3VE12NTcyTmJKTmtDclFn?=
 =?utf-8?Q?sOjU8ygk241dyPsoSrBp?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230037)(366013)(376011)(1800799021); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?K1dlbVdwMEZUYXlHZjdXRUpLZGpRc2FydFFHVTRGUnBYN1ZCRGV2K1NqUVlq?=
 =?utf-8?B?dWVEdTZrY3psenB2MldEUFpnVUhXWXZEY21DeVlCOWFrV2JmVlpWaS80b2pS?=
 =?utf-8?B?YndkQWNZaW0zdHRaRUwxYkpYaDZJVzNVZmZLbUZPaTZNL1BjZEl2eXpFcStp?=
 =?utf-8?B?MVFnYXg5SXlWRmQ2eUJxd1p3Z1FmdTB2TEh0MzMreEd4aXhPM1ZRWUhNU0Fq?=
 =?utf-8?B?NmdLL0lxVHduYVJnK1MyeWN2RWF2U2M1RkFxSGNUYWJOcTAwQzcwN1JVeVhJ?=
 =?utf-8?B?d0xlYk5DZERyM1IyNDNrczQyQkw3Mk9DSlhKTHcvY1dRanpMM0V1anF6c1JZ?=
 =?utf-8?B?SzlhN2hpd1pzRnllSSt6SWtlUkFTeEhLNjhmT0cwQmtPQlpOZjRoM0dvcEpQ?=
 =?utf-8?B?SVVDNE9uSUVucFRZWHl6RFBLOTZybVV2SkU3ejhybTVqTmRCMDVjQVpXbVk5?=
 =?utf-8?B?aFd4U3pjQlNyZTRINTlvN0xmR20yTThSYmZ3SFFDcTdWUElMVHh1RGlTWDh0?=
 =?utf-8?B?MktkbGt4T2FGZ3BTZDNwNEcyZnpiQW51ME9WWjJCZmpUSk5BczU1SVJRcWdE?=
 =?utf-8?B?a3VSU2NKdVU4YjN5Y0pNZnk0SWNyamI3TTJzcVcyQzMzOUxic3IxbjhianJo?=
 =?utf-8?B?YWRWcndrSGs1T3g4NDcyOU5nZU91eDVqOHIzMUUxQkJoUWhoWnluTm4xbWtv?=
 =?utf-8?B?c3ZQbzlZa2E0SllKL1oyRDNOS01wa0sxU21pUTJ4VlgyNlVSaFBhVGM2QzhH?=
 =?utf-8?B?d1FzbXF4eURyRFhjelVOTzBnNzYySjJ3Y3hyUFhneit3YitXYkVZVERUV1F1?=
 =?utf-8?B?ZUFCR1l0dFdSaUhXM2VQWGthbjdCTVdvRkJaN1dHMjRvUmNYcFVvMlhyRmw4?=
 =?utf-8?B?STJNaDlaYjBFRFVuSi94TGkzblFPbFpZblM2VERKbUNBWWdqaHN3KzFkbEQ5?=
 =?utf-8?B?TUhLTkFEWmFoSVVvb2VpSGtCbHh4bWNqM3piS2lpSVZHQmV2VmVTdHN1Q0JX?=
 =?utf-8?B?THhEemxuM3N5a2tFTnFpY3owZXRnb2FpK2dUOWhNTzBJTjBZNVMxMnN2NjFQ?=
 =?utf-8?B?RXJscGNVNHJYK01XN1pNL3VBbkQyaFZObHZKRTZzOTZQQUVFcGhGYm5RQkdU?=
 =?utf-8?B?MzBvYUF0ZGx2NWcxSEtUOG56SHBTc0k5RHBlMUxJSVVKTDdhakR2K2xhT0VL?=
 =?utf-8?B?TEJreTMvekc2emhXOUlBNHFZVXhIMWFvS2ZxVHNNa05wbWNMWUI0QkZQS3J4?=
 =?utf-8?B?RHZvYmZHMGNXaWo5TERhNUllRkRpQWpvMkdyZjRMbE1iSWlha2U0ckI0Z3I1?=
 =?utf-8?B?UGJPd2hSK25tdVJyME9IK0F2THd1M0F4cHNWcXZlY0tVbkszVzVnM3NUOVB0?=
 =?utf-8?B?Y1BUcnNvZEFnOTVERVFXU1pua0JOR0x6RGJnMDE0aHE1YnQzU01TaTJuVW1L?=
 =?utf-8?B?UlhDTDlhM1VQdGlhWTFGY0Fwa3k3RUd0SkFkMU8wUE1nanAvRm5nUmdyeURU?=
 =?utf-8?B?aVcySGUrRmdMTEpTUzhFcjJGdzJ0emZVckl5MUpneW9DTEEwK1JoWU5NTHdD?=
 =?utf-8?B?WENOMWdVK2ZUVE5Gd3JmZkFNd2JoN0ExWEhWVG5DbUxJT0JsK21razV0ZVdI?=
 =?utf-8?B?cEpnVFF1M0lSMjAzcVZlZ2xwcW1DMURXc3BkMUdzMkZhV1FJdG1ETmxHcHhC?=
 =?utf-8?B?alpRZFBEM2lTSkNiQTNmbWNBcDlEbkRwME9HSGtYZkt5WXU5T2EwWklJMXNO?=
 =?utf-8?B?N2FaV0pJcTZaYi9VODA2QVMrUWVGSmUvaVFQaGVxckh5ME9hVE0rcVdOMzU3?=
 =?utf-8?B?WUZjNXFuRHloSW43cEl4b2ZJUWozR1VRUXpnOWwwMS9iYUNSUFN0ZXYrM1JS?=
 =?utf-8?B?TmRyVmhiNFBrM3BFaVljNVhUTVBHVkpKTTJEZk40QUowK3kwMDUrbStJTjVD?=
 =?utf-8?B?TlZNaFhpRHVYNHpLRU5vZTlwSnpVTEtNekY5c3dQYWNHaG92aGNQRFoveWhY?=
 =?utf-8?B?cys2OW9IcHEvdXFTNlhLSlpIam81WnhqbmN0cmh2N3JzZm9JR1RrZnlDNUUw?=
 =?utf-8?B?L1ltcENBOGRXOWs3dk1iTDc3Umw0aHRIMlI3OVlKRTJuU2ROb2ZVMzQ1R096?=
 =?utf-8?Q?nF2dVxKgQZRbk3ED7t4YM865n?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6497da47-81b0-40e7-acde-08dc90428b17
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jun 2024 09:31:05.8256 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SlAe2t+Eloh8lcXrI8D0xixm+HKrCaHWz7hs8eg6mbIlv9BDAI8XRAF3/1Y3jUJC
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6934
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

I would try to avoid that.

Putting everything into amdgpu_info_device was a mistake only done 
because people assumed that IOCTLs on Linux are to expensive to query 
all information separately.

We should rather have distinct IOCTLs for each value because that is way 
more flexible and we won't find later that we have to deprecate fields 
and work around issues because of legacy hw.

Regards,
Christian.

Am 19.06.24 um 02:34 schrieb Marek Olšák:
> I would put this into drm_amdgpu_info_device. That structure can grow in size.
>
> Marek
>
> On Tue, Jun 18, 2024 at 11:30 AM Pierre-Eric Pelloux-Prayer
> <pierre-eric.pelloux-prayer@amd.com> wrote:
>> libdrm_amdgpu uses AMDGPU_INFO_READ_MMR_REG to fill the dev->info.gb_addr_cfg
>> value.
>> Since this value is already known by the kernel, this commit implements a new
>> query to return it.
>>
>> The libdrm MR to use this query is:
>>     https://gitlab.freedesktop.org/mesa/drm/-/merge_requests/368
>>
>> Signed-off-by: Pierre-Eric Pelloux-Prayer <pierre-eric.pelloux-prayer@amd.com>
>> ---
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c | 3 ++-
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c | 5 +++++
>>   include/uapi/drm/amdgpu_drm.h           | 2 ++
>>   3 files changed, 9 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
>> index f51f121d804e..403add7f05af 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
>> @@ -117,9 +117,10 @@
>>    * - 3.56.0 - Update IB start address and size alignment for decode and encode
>>    * - 3.57.0 - Compute tunneling on GFX10+
>>    * - 3.58.0 - Add AMDGPU_IDS_FLAGS_MODE_PF, AMDGPU_IDS_FLAGS_MODE_VF & AMDGPU_IDS_FLAGS_MODE_PT
>> + * - 3.59.0 - Add AMDGPU_INFO_GB_ADDR_CONFIG support
>>    */
>>   #define KMS_DRIVER_MAJOR       3
>> -#define KMS_DRIVER_MINOR       58
>> +#define KMS_DRIVER_MINOR       59
>>   #define KMS_DRIVER_PATCHLEVEL  0
>>
>>   /*
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
>> index b32ff6e1baaf..dbb05d51682b 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
>> @@ -1256,6 +1256,10 @@ static int amdgpu_info(struct drm_device *dev, void *data, struct drm_file *filp
>>                  return copy_to_user(out, &gpuvm_fault,
>>                                      min((size_t)size, sizeof(gpuvm_fault))) ? -EFAULT : 0;
>>          }
>> +       case AMDGPU_INFO_GB_ADDR_CONFIG: {
>> +               ui32 = adev->gfx.config.gb_addr_config;
>> +               return copy_to_user(out, &ui32, min(size, 4u)) ? -EFAULT : 0;
>> +       }
>>          default:
>>                  DRM_DEBUG_KMS("Invalid request %d\n", info->query);
>>                  return -EINVAL;
>> @@ -1310,6 +1314,7 @@ int amdgpu_info_ioctl(struct drm_device *dev, void *data, struct drm_file *filp)
>>          case AMDGPU_INFO_VIDEO_CAPS:
>>          case AMDGPU_INFO_MAX_IBS:
>>          case AMDGPU_INFO_GPUVM_FAULT:
>> +       case AMDGPU_INFO_GB_ADDR_CONFIG:
>>                  need_runtime_pm = false;
>>                  break;
>>
>> diff --git a/include/uapi/drm/amdgpu_drm.h b/include/uapi/drm/amdgpu_drm.h
>> index 3e488b0119eb..680492cd73d8 100644
>> --- a/include/uapi/drm/amdgpu_drm.h
>> +++ b/include/uapi/drm/amdgpu_drm.h
>> @@ -933,6 +933,8 @@ struct drm_amdgpu_cs_chunk_cp_gfx_shadow {
>>   #define AMDGPU_INFO_MAX_IBS                    0x22
>>   /* query last page fault info */
>>   #define AMDGPU_INFO_GPUVM_FAULT                        0x23
>> +/* Query GB_ADDR_CONFIG */
>> +#define AMDGPU_INFO_GB_ADDR_CONFIG             0x24
>>
>>   #define AMDGPU_INFO_MMR_SE_INDEX_SHIFT 0
>>   #define AMDGPU_INFO_MMR_SE_INDEX_MASK  0xff
>> --
>> 2.40.1
>>

