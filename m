Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AB838CA0FED
	for <amd-gfx@archiver.kernel.org>; Fri,  5 Sep 2025 15:35:59 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 50DBF10EBE2;
	Fri,  5 Sep 2025 15:35:59 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="HgCLUAV2";
	dkim-atps=neutral
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2055.outbound.protection.outlook.com [40.107.220.55])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D575C10EBE2
 for <amd-gfx@lists.freedesktop.org>; Fri,  5 Sep 2025 15:35:58 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=opjdmNjpMNpTljzubJ2Za5KiEjfd4/c1psJcIRoD3a0R98v94X91zuyFqGAakQVBoh2Nto1/Xa/5chsUinZlEQwO99UKHTRbrdsJRNoPhhAV+rCimrPZf8bGe8XdNHgCnecnGpo8WAQ4bzEfyYKMluoYTwx82a88abaYSKZ6yiq8uHiarcjZ4CMRcb4lc8I/kW2I0aOzvlG5Vw10TNFS+i21jl+tXPJvg8BTSvz+Qxa0hqf6C9ReTEgs4AIQOFGm4tMQ3RKOyr3qyVi9BK+P9I+RM5N2Cp1PO9cmx3OoJSU3WHpMlgPxte6BIdMQ/AfVbjXIxNdf5x+paUWAZ2AwKg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gIlTQHtSAGT6vwg2GfMFTcdHP6AbrMjQsa76gStICCQ=;
 b=hFUPQLsK8p3PpuElHUjTCmtcIlnazmEX/h6dc2s6GCOFBEcKuqon6hL28Ny0doY9gKWFVbERwF7JQGM8TZ1eqsbWOwjOWaiAzbVm9GoVSkG42EgPXEAnDpXoNxiOdcG9Dhirj+QasYhNGtbvkNl0I35ESuuvDCqQaA+Yx8wV76dvKv5JlbFqNKWK0p49pEmwDW2t2uhnr1uyDzToFMuwIQTKx3j0RdulUPQyUFoupz6QPSp21891Ieb9RcMz9qU2VXUXkOBl4OvIv14gpkx7XxymbHGXXICdbUFk3N8rVXUaFwYXjRqlf61PNkHwO2LTYBVrSWub76M2cUYry6kYZA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gIlTQHtSAGT6vwg2GfMFTcdHP6AbrMjQsa76gStICCQ=;
 b=HgCLUAV2aFEYN6ffbHCpKEhEG3Kn5xoG2rz0D8igjgE7qIfpoPoG6isn0VeQgR653sFfrbCVU44rRiu4krLkFgeKJk33sM90oVzWyKkGnTBRi9y+004Kw+W64HDotYVjuRB27jQtn5MkXNCeh72U5ag13BhNmprO4BEQ8qM/qg4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SJ0PR12MB6760.namprd12.prod.outlook.com (2603:10b6:a03:44c::18)
 by DS7PR12MB8292.namprd12.prod.outlook.com (2603:10b6:8:e2::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.17; Fri, 5 Sep
 2025 15:35:56 +0000
Received: from SJ0PR12MB6760.namprd12.prod.outlook.com
 ([fe80::25c8:f399:b2e8:1947]) by SJ0PR12MB6760.namprd12.prod.outlook.com
 ([fe80::25c8:f399:b2e8:1947%5]) with mapi id 15.20.9094.015; Fri, 5 Sep 2025
 15:35:56 +0000
Message-ID: <7834113f-5343-4dcf-ad88-657d107065d3@amd.com>
Date: Fri, 5 Sep 2025 11:35:53 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] Revert "drm/amdkfd: return migration pages from copy
 function"
To: James Zhu <James.Zhu@amd.com>, amd-gfx@lists.freedesktop.org
Cc: Felix.kuehling@amd.com, philip.yang@amd.com, chengjun.yao@amd.com
References: <20250822193801.292575-1-James.Zhu@amd.com>
Content-Language: en-US
From: James Zhu <jamesz@amd.com>
Organization: AMD RTG
In-Reply-To: <20250822193801.292575-1-James.Zhu@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YQZPR01CA0127.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:87::12) To SJ0PR12MB6760.namprd12.prod.outlook.com
 (2603:10b6:a03:44c::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR12MB6760:EE_|DS7PR12MB8292:EE_
X-MS-Office365-Filtering-Correlation-Id: b5db380a-539d-4f85-2d98-08ddec91e7ae
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?VUR4U2VlQlZxdkhLZE5JbTVyVEIwc00vakpMU0ZaWk5LRUVKWXd5S25aWjBm?=
 =?utf-8?B?VW1GNlBIS253anBGalFpNTQ2NDBmbTRtay9mTDhqMUwvN3NUYmtBSGNvOEJR?=
 =?utf-8?B?Zm54SG9ueXFZWENYbEhjZEVydGlmellsZlpnUzZ1cjlkcEVxNG9NdHZMY055?=
 =?utf-8?B?dTBFYno0bm95cm5rVlU5SmMrV1NGMXVnU0tRWFZCQm9DeGR4WmU4dTVLNE9D?=
 =?utf-8?B?WHRVR3NLbXhWdWc5bFAzNkhJMkw4aTFhTFVRRU9nM0lJdVhCTlEyWllTek5l?=
 =?utf-8?B?eFBNd2VHWW9ERjNBT3ordUExSjZxZ1E3UEZJdUJDYmpLcHFxU0tJZG1ibXZW?=
 =?utf-8?B?RUMzazJlWUJodFVEbnFkcFRLeVVxVEZyK25yRUtFSXRsOGovbWRwVVBEYk5F?=
 =?utf-8?B?K1hza0lTeVZBRGwzRU5ZaGplWlhWZmRRYk9tRFM0dDBmZXJKemZrdlNSejV0?=
 =?utf-8?B?VDZ3bjZnL2oweERtOEMvRWFLR1d6OHo5K0dFZjR3cERoYzd6eEdGM2hIRzR2?=
 =?utf-8?B?djFVaktycXNsR0dDTjJVNEZjNTdRZGVtUlhZdTFGUnEyMWppUjRBWHhqeW9n?=
 =?utf-8?B?UjNKVTM2dG1vc2VJUjZTOFlnbll4UXFuRVI4YUxZS21UblZTSnlzZjRmb3ND?=
 =?utf-8?B?QzEwcEpqUXhIejd3b0lxS01PME5mYURiWUFNVktwcWdkUkJwRlR1eEpZbEdy?=
 =?utf-8?B?Z0tGNFpiVDh3V3V0NXYyWEhWbHVFNzJOdDc5d0pkb0w1MFJMdFRrd1htb2hV?=
 =?utf-8?B?MGRub3BLOU40QUxST1ZvM21lTjI1Wm9yU0VnK09DRmVYWk53RG4zRzlHQmgw?=
 =?utf-8?B?enF2UDVSUFd6RG5jd3ZLNGVsbjVxdVlzU0RKMU1mOW9aTVRWcHlTRmMySWVS?=
 =?utf-8?B?ZFp0bFNDOTNwMXZJbGVjd1hyMlMwRnNhTlBPZFpGelA5QTJEZU9pVWNGNkJP?=
 =?utf-8?B?SmpsemhLRkhTbEFIdXJxSDAzcG5JVjRJdDMreUgwZ1d1TzVLL0FmODh4TEJ1?=
 =?utf-8?B?Rmh3WThvL09jRjZ6RFBRcHIvMk1xZ056N01zUDFlUGVVdjJjZWI3b3J5amQ3?=
 =?utf-8?B?TjhmVi9mYmtBMW5ZL2cxM3NhUHFzdGVFeG1FaklJcXZheUNvSHVjdGRiVTZv?=
 =?utf-8?B?V2ZCUG1IdXRjSnZ4Vkl5eFJzVWJ1YmpjUXJZUzVPT2E0T2VSZEF5OENjT2RU?=
 =?utf-8?B?aVVRdGN5bVBmK3M4NTgzaVJiMnZjOEFWM3Nkd1FGSEo4M3kyei9KSlBuc2FZ?=
 =?utf-8?B?ZmNybzZLTkhUNkxvY3VtQXljeklwRW1VT3FLMnVxdUdpVGVpMWpUcFp2ZlhR?=
 =?utf-8?B?dGVVd2hKWmx0eHp6MEZ1NTFpY25PUkxaa3FVRFVpQThEZTdtMUgvcTZWR2gv?=
 =?utf-8?B?ZUF1UWJycW5Uc2g2ckFSaytnWWRMVXlGdTVpUUZkMGhVTWpuUmhUWUR4SDRh?=
 =?utf-8?B?djBIOHFCUVRLQUQzelpLb0lWanRyVFJpMTZ6bGJSVWVRZEdtVFpBVlltVmhE?=
 =?utf-8?B?N2JsMUZNTDY0UHQyMm1pZGpWbHkweVZrUE5PTDg1WVZRaWYxakI5bGRtN3BO?=
 =?utf-8?B?U3hOM1VkU01IRlJ0TmlUbjBJdUZISnduR3NDZWg1c3ZnSERBZmlqUDFBWnhn?=
 =?utf-8?B?dVNQN2ZqZjcxdCtZb2VKcFFUN05oUDdyODQ0dXVTZHZTRXNYQytrWUMzbnA2?=
 =?utf-8?B?U1RYZXpVWndpT1Q0NkdaVWJTWk93UVFsdzJhRm5lYkIzSlZXR0QyOTM5ZmZS?=
 =?utf-8?B?SWE4eGMzSHZObkF1ckZDQmpDd3BaWXV0UHBrN1F1dnhDeStkU2QvUC9pYzZK?=
 =?utf-8?B?emsvbi8xNlptQ1cxbTc3Z3oycGZqQzRNbHR0bjUzZWE2YitBV0JEMXB6YzdH?=
 =?utf-8?B?dU81YXRRNzVac0xFcE1ObklZcE1hU09kWlByV2szTEt1R0hEVGZTbVJIUkRh?=
 =?utf-8?Q?PLBvPwV1E8k=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ0PR12MB6760.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?a1pSMjZIR1g5U2tFUXhsbTJ2bnp3UzY4N1dQZTg4YVB6MXNpWllKWFYzUnFS?=
 =?utf-8?B?dE5uVy9uK0t6SkVydHpOaDdiVHVCbmJVcVlJYkRzYTZtbGV4aC9hVmRSbUM4?=
 =?utf-8?B?aGFBUVRIdHhiREVBckJ2MC9FK0ZYbFhpaG9NSk9qOFpLT2pCc2xRem9ad2RE?=
 =?utf-8?B?TXBDWjBKTGp6MjE1Tm1TVFJKMHhaSUI3aHVadnUyaFJRd2ZyamROY3BZZUQ1?=
 =?utf-8?B?WktyRFhyelhkREYwb3lTcVpHcE1DTlpJQnpYSDlrRllSejZxNXVxVEkwSi9i?=
 =?utf-8?B?YTUrUmJtM2FjSTJrNnhpWENsV0Q4a1IyQ2ZyTDI1amN3UVNLQ1FBcGh0czN0?=
 =?utf-8?B?OXNITlpFWDZpQ0dNMUJ2R3FrTkN6QWt1TTBHazZVKzlMa1NNL1l4enJzc1pV?=
 =?utf-8?B?Q1JtZ1AwNUVBV1dJMmpuMzMxbXBueXJNSXgyUnFsOFZ4VCt6enpveTk1Nyt1?=
 =?utf-8?B?aXA0RURUYUl5TEVsSU55THd5bVdTY2dmLzNyS1paRXpNc3gvOTBxUEpzNm0y?=
 =?utf-8?B?aWEyR0xQMkZoekpkMDdLNjY0TFF4NExJNXVkZlQ0U3Y1YlEyYk9ZTXlNVEZi?=
 =?utf-8?B?S0w5VjFKVDZ6a0YxOGlqVEdsNmdGRzFBeG5UUXRoTjdleHRVdWM5RE5vVTZT?=
 =?utf-8?B?bWNzZjdQb2Z4T0I1dE5tcGREejZuRERFc2NiWTU0Wk5oSFVPVS9kNXBPNTFi?=
 =?utf-8?B?c2JWNXlWNjcwVEV3ZjFoRnRYKytRQjlzZjJrWE9JdXp3ejMzZklNT3ZxU25P?=
 =?utf-8?B?dlpLdHorNE5oOUt2ZHUrTlErWTVGMnVUR0libEVsOFIwN1ovK3ozS1BndUc3?=
 =?utf-8?B?R2FaOUIrVUR0NG1ZZWc2V2NuUzVHMmN6ZDNLSmpvZzk3UThoMXBBZCticXNT?=
 =?utf-8?B?L3NiK3h0QmEwb1ArSURxRlMvTjZLeE1SL2RncVI2cDNjMk0xTGFMS2UrM1pZ?=
 =?utf-8?B?Nm5QRXNvZWZERk81b1lXVkw3NUdGemI1cWg2UmZuOE5rZ1IyT1BwK3JhN3BS?=
 =?utf-8?B?VnE5b0h1T0FLMW1rUjFVRG12OE5UWUJ0Q3V5dWlhNGgvVk1FN09NWWw2OE9k?=
 =?utf-8?B?cTNHMjRuYWZUOGUwYVdPZ0JvUm1WSlphRVFKNVVaU0JqLzZOMnV0Z3FnUmQ0?=
 =?utf-8?B?VE1yYnZuUElqbnY2bXNxaXROZkptVVNaOEt0VzRILzA4RHZ0OFJHTm5jaVpn?=
 =?utf-8?B?T2dTbTU1UFJtc3lQdzFyNU85dk1wVW1LTS9WUVBRRkhGdjc5NXFBL1d2MzlY?=
 =?utf-8?B?MEc0SnZnZVErdDgraExqWnRpaUVqbmRxSGd0cUlwdi95UmhhakVtVy9CdTZJ?=
 =?utf-8?B?T1luU2d1TkhRVWQwNDVNcGZPRHcwRXNaZ25mMWNJVzN5Z2ZXNkVFeEJCMEtX?=
 =?utf-8?B?ME41anZ5Vlg5WHB3TE43YTJkTVNlNCtYZE5ZWTFPNWc3N3hsNW1OMXdIem8r?=
 =?utf-8?B?VGFPWnJvUHNvZW9WejlIYWpCZDBvU2lDUWliVXhQMFJDOER1S0U3OUxGdG4r?=
 =?utf-8?B?SUQxbUxYcjhJWG40MUFaWjdCM1ROZ1Ewc29IcFhsbEZxdkxxNDNjbDd0MkZB?=
 =?utf-8?B?ZUY5SVlLaGl4eCs1dVplUEZHY0x5STZqQ0VIdzMxWWp5QmtnWmpCTkV5OUd0?=
 =?utf-8?B?M2xIODBxdll1d0VtNmlSTlZWeTBjY0lyNmZVY3RMdkNKVWNwNjVBZi9MbVBZ?=
 =?utf-8?B?ODVWalFwWEhEVHFFVDJ1Q2JvRmo3cXBRN0VOcjJoYzdlVUxvYUhhakxJU3Y3?=
 =?utf-8?B?Nlc3Y2cveFZHVW9zRjVjSlBPaCtWZ2pGYmY3MHRhbTBXVzdRQzVORzJZbDVF?=
 =?utf-8?B?OUR6c253QnJBeVJSMitqZGdmaWJud09qeU9FSzJZcVBEUlhBYmlubGowZ2pF?=
 =?utf-8?B?WTdrRmdEWk9MWm5QWmxUOXR0cmtyVW1vMlc4d0pUTWgxY05BYkVjbWV2b3Fw?=
 =?utf-8?B?U2pYZ3BZYnFtUDJnK0VCc3RDaDVGR2xLK1l5bFRUdHk5Z1JhZHV3MG9MakRz?=
 =?utf-8?B?QzY3NzBuY2lFWkZkU2RwMnV1akxheXZVTzFmaGFTMHQ1Z2NiUjBGb05Pb2Za?=
 =?utf-8?B?TGlmdUZRL0dzS0dacXVud0drRm9DbHNiVy9VYk1hUDl2QXNaRERVd251MDlx?=
 =?utf-8?Q?HTvM/75IQAlVCt3JtOGUR58x7?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b5db380a-539d-4f85-2d98-08ddec91e7ae
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR12MB6760.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Sep 2025 15:35:56.0676 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8mEfx6smWE3qlPeE0CqoRfJ1D32br1ZBpw6rqyswb3rBSURkrb22hDXfEgev8UBv
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB8292
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

Ping ...

On 2025-08-22 15:38, James Zhu wrote:
> This reverts commit cab1cec78c8fd52e014546739875a81150f11080.
>
> migrate_vma_pages can fail if a CPU thread faults on the same page.
> However, the page table is locked and only one of the new pages will
> be inserted. The device driver will see that the MIGRATE_PFN_MIGRATE
> bit is cleared if it loses the race.
> ---
>   drivers/gpu/drm/amd/amdkfd/kfd_migrate.c | 72 ++++++++++++------------
>   1 file changed, 36 insertions(+), 36 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c b/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c
> index 5d7eb0234002..f0b690d4bb46 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c
> @@ -260,7 +260,20 @@ static void svm_migrate_put_sys_page(unsigned long addr)
>   	put_page(page);
>   }
>   
> -static long
> +static unsigned long svm_migrate_unsuccessful_pages(struct migrate_vma *migrate)
> +{
> +	unsigned long upages = 0;
> +	unsigned long i;
> +
> +	for (i = 0; i < migrate->npages; i++) {
> +		if (migrate->src[i] & MIGRATE_PFN_VALID &&
> +		    !(migrate->src[i] & MIGRATE_PFN_MIGRATE))
> +			upages++;
> +	}
> +	return upages;
> +}
> +
> +static int
>   svm_migrate_copy_to_vram(struct kfd_node *node, struct svm_range *prange,
>   			 struct migrate_vma *migrate, struct dma_fence **mfence,
>   			 dma_addr_t *scratch, uint64_t ttm_res_offset)
> @@ -269,7 +282,7 @@ svm_migrate_copy_to_vram(struct kfd_node *node, struct svm_range *prange,
>   	struct amdgpu_device *adev = node->adev;
>   	struct device *dev = adev->dev;
>   	struct amdgpu_res_cursor cursor;
> -	long mpages;
> +	uint64_t mpages = 0;
>   	dma_addr_t *src;
>   	uint64_t *dst;
>   	uint64_t i, j;
> @@ -283,7 +296,6 @@ svm_migrate_copy_to_vram(struct kfd_node *node, struct svm_range *prange,
>   
>   	amdgpu_res_first(prange->ttm_res, ttm_res_offset,
>   			 npages << PAGE_SHIFT, &cursor);
> -	mpages = 0;
>   	for (i = j = 0; (i < npages) && (mpages < migrate->cpages); i++) {
>   		struct page *spage;
>   
> @@ -344,14 +356,13 @@ svm_migrate_copy_to_vram(struct kfd_node *node, struct svm_range *prange,
>   out_free_vram_pages:
>   	if (r) {
>   		pr_debug("failed %d to copy memory to vram\n", r);
> -		while (i-- && mpages) {
> +		for (i = 0; i < npages && mpages; i++) {
>   			if (!dst[i])
>   				continue;
>   			svm_migrate_put_vram_page(adev, dst[i]);
>   			migrate->dst[i] = 0;
>   			mpages--;
>   		}
> -		mpages = r;
>   	}
>   
>   #ifdef DEBUG_FORCE_MIXED_DOMAINS
> @@ -369,7 +380,7 @@ svm_migrate_copy_to_vram(struct kfd_node *node, struct svm_range *prange,
>   	}
>   #endif
>   
> -	return mpages;
> +	return r;
>   }
>   
>   static long
> @@ -384,7 +395,7 @@ svm_migrate_vma_to_vram(struct kfd_node *node, struct svm_range *prange,
>   	struct dma_fence *mfence = NULL;
>   	struct migrate_vma migrate = { 0 };
>   	unsigned long cpages = 0;
> -	long mpages = 0;
> +	unsigned long mpages = 0;
>   	dma_addr_t *scratch;
>   	void *buf;
>   	int r = -ENOMEM;
> @@ -430,17 +441,15 @@ svm_migrate_vma_to_vram(struct kfd_node *node, struct svm_range *prange,
>   	else
>   		pr_debug("0x%lx pages collected\n", cpages);
>   
> -	mpages = svm_migrate_copy_to_vram(node, prange, &migrate, &mfence, scratch, ttm_res_offset);
> +	r = svm_migrate_copy_to_vram(node, prange, &migrate, &mfence, scratch, ttm_res_offset);
>   	migrate_vma_pages(&migrate);
>   
>   	svm_migrate_copy_done(adev, mfence);
>   	migrate_vma_finalize(&migrate);
>   
> -	if (mpages >= 0)
> -		pr_debug("migrated/collected/requested 0x%lx/0x%lx/0x%lx\n",
> +	mpages = cpages - svm_migrate_unsuccessful_pages(&migrate);
> +	pr_debug("successful/cpages/npages 0x%lx/0x%lx/0x%lx\n",
>   			 mpages, cpages, migrate.npages);
> -	else
> -		r = mpages;
>   
>   	svm_range_dma_unmap_dev(adev->dev, scratch, 0, npages);
>   
> @@ -450,13 +459,14 @@ svm_migrate_vma_to_vram(struct kfd_node *node, struct svm_range *prange,
>   				    start >> PAGE_SHIFT, end >> PAGE_SHIFT,
>   				    0, node->id, trigger, r);
>   out:
> -	if (!r && mpages > 0) {
> +	if (!r && mpages) {
>   		pdd = svm_range_get_pdd_by_node(prange, node);
>   		if (pdd)
>   			WRITE_ONCE(pdd->page_in, pdd->page_in + mpages);
> -	}
>   
> -	return r ? r : mpages;
> +		return mpages;
> +	}
> +	return r;
>   }
>   
>   /**
> @@ -567,7 +577,7 @@ static void svm_migrate_page_free(struct page *page)
>   	}
>   }
>   
> -static long
> +static int
>   svm_migrate_copy_to_ram(struct amdgpu_device *adev, struct svm_range *prange,
>   			struct migrate_vma *migrate, struct dma_fence **mfence,
>   			dma_addr_t *scratch, uint64_t npages)
> @@ -576,7 +586,6 @@ svm_migrate_copy_to_ram(struct amdgpu_device *adev, struct svm_range *prange,
>   	uint64_t *src;
>   	dma_addr_t *dst;
>   	struct page *dpage;
> -	long mpages;
>   	uint64_t i = 0, j;
>   	uint64_t addr;
>   	int r = 0;
> @@ -589,7 +598,6 @@ svm_migrate_copy_to_ram(struct amdgpu_device *adev, struct svm_range *prange,
>   	src = (uint64_t *)(scratch + npages);
>   	dst = scratch;
>   
> -	mpages = 0;
>   	for (i = 0, j = 0; i < npages; i++, addr += PAGE_SIZE) {
>   		struct page *spage;
>   
> @@ -638,7 +646,6 @@ svm_migrate_copy_to_ram(struct amdgpu_device *adev, struct svm_range *prange,
>   				     dst[i] >> PAGE_SHIFT, page_to_pfn(dpage));
>   
>   		migrate->dst[i] = migrate_pfn(page_to_pfn(dpage));
> -		mpages++;
>   		j++;
>   	}
>   
> @@ -648,17 +655,13 @@ svm_migrate_copy_to_ram(struct amdgpu_device *adev, struct svm_range *prange,
>   out_oom:
>   	if (r) {
>   		pr_debug("failed %d copy to ram\n", r);
> -		while (i-- && mpages) {
> -			if (!migrate->dst[i])
> -				continue;
> +		while (i--) {
>   			svm_migrate_put_sys_page(dst[i]);
>   			migrate->dst[i] = 0;
> -			mpages--;
>   		}
> -		mpages = r;
>   	}
>   
> -	return mpages;
> +	return r;
>   }
>   
>   /**
> @@ -685,8 +688,9 @@ svm_migrate_vma_to_ram(struct kfd_node *node, struct svm_range *prange,
>   {
>   	struct kfd_process *p = container_of(prange->svms, struct kfd_process, svms);
>   	uint64_t npages = (end - start) >> PAGE_SHIFT;
> +	unsigned long upages = npages;
>   	unsigned long cpages = 0;
> -	long mpages = 0;
> +	unsigned long mpages = 0;
>   	struct amdgpu_device *adev = node->adev;
>   	struct kfd_process_device *pdd;
>   	struct dma_fence *mfence = NULL;
> @@ -740,15 +744,13 @@ svm_migrate_vma_to_ram(struct kfd_node *node, struct svm_range *prange,
>   	else
>   		pr_debug("0x%lx pages collected\n", cpages);
>   
> -	mpages = svm_migrate_copy_to_ram(adev, prange, &migrate, &mfence,
> +	r = svm_migrate_copy_to_ram(adev, prange, &migrate, &mfence,
>   				    scratch, npages);
>   	migrate_vma_pages(&migrate);
>   
> -	if (mpages >= 0)
> -		pr_debug("migrated/collected/requested 0x%lx/0x%lx/0x%lx\n",
> -		 mpages, cpages, migrate.npages);
> -	else
> -		r = mpages;
> +	upages = svm_migrate_unsuccessful_pages(&migrate);
> +	pr_debug("unsuccessful/cpages/npages 0x%lx/0x%lx/0x%lx\n",
> +		 upages, cpages, migrate.npages);
>   
>   	svm_migrate_copy_done(adev, mfence);
>   	migrate_vma_finalize(&migrate);
> @@ -761,7 +763,8 @@ svm_migrate_vma_to_ram(struct kfd_node *node, struct svm_range *prange,
>   				    start >> PAGE_SHIFT, end >> PAGE_SHIFT,
>   				    node->id, 0, trigger, r);
>   out:
> -	if (!r && mpages > 0) {
> +	if (!r && cpages) {
> +		mpages = cpages - upages;
>   		pdd = svm_range_get_pdd_by_node(prange, node);
>   		if (pdd)
>   			WRITE_ONCE(pdd->page_out, pdd->page_out + mpages);
> @@ -844,9 +847,6 @@ int svm_migrate_vram_to_ram(struct svm_range *prange, struct mm_struct *mm,
>   	}
>   
>   	if (r >= 0) {
> -		WARN_ONCE(prange->vram_pages < mpages,
> -			"Recorded vram pages(0x%llx) should not be less than migration pages(0x%lx).",
> -			prange->vram_pages, mpages);
>   		prange->vram_pages -= mpages;
>   
>   		/* prange does not have vram page set its actual_loc to system
