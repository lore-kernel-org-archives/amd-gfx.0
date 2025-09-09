Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 87BDDCAC583
	for <amd-gfx@archiver.kernel.org>; Tue,  9 Sep 2025 14:34:50 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 30DCA10E05F;
	Tue,  9 Sep 2025 14:34:50 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="f4afd9JU";
	dkim-atps=neutral
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2089.outbound.protection.outlook.com [40.107.223.89])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 638B010E05F
 for <amd-gfx@lists.freedesktop.org>; Tue,  9 Sep 2025 14:34:49 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=O5UXsf7zHssLZzlOT+M3LUVl6cqlAynSPT2meJ7BufZkNXF9xHlyAyAp4chqXxFCxD06dvkOrifgWi42LRop8tZEdgWAaGRtIlwA+o1VcN9T3vQe5Ye2KdM4Bmn6Ya9xIH4Go3dhOvrg8y93A0vcQmGKQCMR9X1LkOEO6P5NOcfKalJRSKs2R+1BYEPzYOd/3bQy35ztbZ8ZclaLi1JbCMROmRXgzsja4ELOeZ0RpJSzKpAHGBG3h73Z6cetfRXxd+4w82Udfnqz+JBcdrbYWHDjSZ8JCxTGmq53ArzNiTMqfFy1qFLfamyIB456qie8w0WyrN0UE+O2hwHbgYUKcQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2xLsNTfoA92uwDrm2MGJ1LVI+OZPGx2NGNf7/IRe4ls=;
 b=B98vB0S0U8IdkmqRqwEwotOgyzqASLV5yNovSqRSKLwHDKDoPNPqVyFmBm7igyIyWKMbL4t6VFaseCniT9X1s98lsUsWp+0k/ovrNxshFzsSrWPGMmeA4llwgUSCl1aFZBpa/xBHeOFHFJRy1gjp9swflqpEpWe22HBo8zAvpXtsB8sXq+W4OQE76erUVplvq7qa0YHl3JTufbJbXZ7SDzbBxo8jDyyNKEVP5OXda0Sg3CP5l+01I7YI5JvrjBPLklhEZ3XCkSaTI6Yica2x64e1Bxl5y/FOG6dD2NLZrY60fT6ntYh52pjv6qtnJrvwuwSO3KPPNVKHKIwMtkS+ug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2xLsNTfoA92uwDrm2MGJ1LVI+OZPGx2NGNf7/IRe4ls=;
 b=f4afd9JUYWKJ6ClvIfDSSV5LjVXp4DJk0mU3WJhZp8E4ZDM5VZ/rfeo9iPpRnJewTD5fJjZafK6yPmAVC9FW6RAjrMVhVjgTitljMy7VD0HmSfUcb2QwHiTfHDeOx/NSTcLJMX0p3WNtA0+RIZz/WTGEw8nJM3GrwjGbs5p46YM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB5149.namprd12.prod.outlook.com (2603:10b6:5:390::14)
 by CYYPR12MB8961.namprd12.prod.outlook.com (2603:10b6:930:bf::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.22; Tue, 9 Sep
 2025 14:34:44 +0000
Received: from DM4PR12MB5149.namprd12.prod.outlook.com
 ([fe80::36fa:deca:aaeb:75da]) by DM4PR12MB5149.namprd12.prod.outlook.com
 ([fe80::36fa:deca:aaeb:75da%4]) with mapi id 15.20.9094.021; Tue, 9 Sep 2025
 14:34:43 +0000
Message-ID: <e8239092-65aa-7add-e9ff-1426b7dcc18e@amd.com>
Date: Tue, 9 Sep 2025 10:34:41 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v2 1/3] Revert "drm/amdkfd: return migration pages from
 copy function"
Content-Language: en-US
To: James Zhu <James.Zhu@amd.com>, amd-gfx@lists.freedesktop.org
Cc: Felix.kuehling@amd.com, philip.yang@amd.com, chengjun.yao@amd.com,
 jamesz@amd.com
References: <20250908161526.99413-1-James.Zhu@amd.com>
From: Philip Yang <yangp@amd.com>
In-Reply-To: <20250908161526.99413-1-James.Zhu@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YQBPR0101CA0352.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:6b::21) To DM4PR12MB5149.namprd12.prod.outlook.com
 (2603:10b6:5:390::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB5149:EE_|CYYPR12MB8961:EE_
X-MS-Office365-Filtering-Correlation-Id: 4579137b-2b88-45d4-b662-08ddefae0454
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?ak15TkdPNzBoemxFOC9QMjlDZEJmK0xTVGhJclRISThLcjUvTytvQXVXa3Fm?=
 =?utf-8?B?QmxRQkVaMTdFUjh4WlhMazhCNVMySjdkbGNkUjc5dDdIS2k2OXVJNlptR0lp?=
 =?utf-8?B?dDI2di9hYkhUL1l3VGc5VkpaVjY2NE93RUZUNjhicmgwZ0JQQm5HdEhyNmhT?=
 =?utf-8?B?Zk9GcDV0ZkpHbkdwWXQycXRsNGllRHY5b3lYR3hqS294eUd1dnowRXpiTHpv?=
 =?utf-8?B?NC82dkk4Q3BLWUhFOWtYcE1DK2lFd2U0QXFmanhYYmxmQlRwTTIvUnRhK0hN?=
 =?utf-8?B?NHhtN1hVRm5kd3pzVy8ybzJ2ZFJ6djRmMUtaMlE1aUlqNzVWY2lReDVoZjBB?=
 =?utf-8?B?UEFNN3hKcXRLYWEzTmNWS0pHenFhTkhpWnlpOGtWMEliQTZhVUZzN20xM1FE?=
 =?utf-8?B?dEFyR0ErYlkxYmNTR2p5aTJVS0xtaXhFR3JVNTAvN05HbDNPaGhyNmZuQWVZ?=
 =?utf-8?B?Z3pQSjJ2K2gvNHcrSlovN1pRVFdtbGlnellCb0NpNmFRa05UcDhqbG1lNW5a?=
 =?utf-8?B?TTdScVdFQWdhdXRQU1R1ZE80dFNPbElqcDFHMk43ZFVsQkZRQ2QrOEo5dkJE?=
 =?utf-8?B?MmFHVFlhdnZwOXFSMmlVQjcrcHZqOUdIR3FUbFRvVm9NUDhiZTV5SHE1MXpC?=
 =?utf-8?B?N3pkMStwTlB0WnQ4WnpMNTFsdmI1MmlSelBucWltcWwzUktVbTFucVpyYitI?=
 =?utf-8?B?NXdIaG5QVnBSd0V3UVcxWmRlK3ludjJMMmpHUjFUbDhMTUNKNzYzalF3dnNN?=
 =?utf-8?B?azVEQzdmT2ZBNFJLVFRhVXZJS0FvRG9PTEhuTXgzcSt5ayt4K2tzTnpqMURk?=
 =?utf-8?B?VHlrbHJETVVEb3RTdXRqZGJGaTNETStvaDlxb0w4QVIvRk9CZG9nbkUxVmd4?=
 =?utf-8?B?VUFzUURZbzRNVjV6bUZoUTcwTGxDL09FeVF5Y00va1RtakdXYmpUeVN1OEJa?=
 =?utf-8?B?SDB5VFNVaGQ0TGYxUGRSOThMQXAxekxWdnFqdVNVUnFibWIyVFZQZ3d1ck42?=
 =?utf-8?B?aSsyU21mQW1kQmVxcm0zRlpHZTZyL212UWpIYWV3TVV4MUd3SHVzbVZYUHRZ?=
 =?utf-8?B?UlJEdkRsRHpCY0xYRTdqbndpdEdqSkJ4S1NndVY3bjV0eWh0SVFyR0xVREZ1?=
 =?utf-8?B?SmdKL2Z6bTk0NlpLaHhnS2xTemJ2Z25vT0wrSEw3NXpIeTBGcnR0MXJIY1ky?=
 =?utf-8?B?L2hOcHhGa1BRVDgreitURGJ2NHoveTRLWG94ZDZWcjJPRFhaaWcrQVFBL21z?=
 =?utf-8?B?WUNXK1FseGNpV1NiWlQyT1NPTVZpVEkzc3lQOWplZUVaNStXcXF0MHRXYk1j?=
 =?utf-8?B?cFdxRkxNRGhKMVNkTjJUc2tQWCt6RU10d3ZKSlBhcitFdnlDQUNISzh3V3A4?=
 =?utf-8?B?cDZaR3Z5VlBHT3NLTFZBYXp0ekFIL05VSEx0UmlNeTJSWlJHQWE4OUpzdkRn?=
 =?utf-8?B?WmtMSjlLZVJGbmJPU09iakx1U2VIb3JJN1hoY1UrbTBHZFhGU2xCR2R3SDBx?=
 =?utf-8?B?ZFgybGw0Zi8rTll5TkxPVXRaOVM3bkI5eWFsQ0ordlFyVGpBR3I3U1BucTdq?=
 =?utf-8?B?MFdsYVZOcDJKb3F2cWJPMWwxUnlVRElmMGU4eHNxRkpqNE51b29iT01mZjls?=
 =?utf-8?B?RzJIN1V2eW9rdG9iUWZwZ1YrWHNsVTdSRUNxQVVLYUNRTXZ4SGZzZkt4T1Qr?=
 =?utf-8?B?bzVmM3NTbTQ3QnlCcEhuYnRNM2xZWGkxUjRiNEtEZHhldU5HVC8xWmQ2aUFW?=
 =?utf-8?B?bUFXQk9KckRJUTY1SUFkUWNXd3kzMWM1RVNKSy9jMFJndDl5ZDQzOFVEVHA0?=
 =?utf-8?B?VmdwZ0FaY1lLK0VUcG4yZkMwREJvZXZhQStoSDdNR21BSFlZaVR2dDVTY1dE?=
 =?utf-8?B?ZWNQNFVJQzZ0WFNzcFl6bUt3cU1ZTUJNRE1WV1c1VDNDVzlLOVYrNmtkMUxY?=
 =?utf-8?Q?bqmuO16TRwg=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB5149.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?K1UybU8rY2MxOFhQTUhhbGJ3dVBLeTRBM0M4VzIyR1dQQVoyTHJLQTc0UlNW?=
 =?utf-8?B?K2Q1aDNTTXh5cGJSeVRSMGZzYURBZ093WEx1R1p4Lyt4aXZVdE96WjdadHdJ?=
 =?utf-8?B?SE5FaXhVNSt6Yll2bDhTY1hMOFprMm43cWNDaUl1bjArclRnOHkvNFFVSDRt?=
 =?utf-8?B?MWoxYi9tMnFSUFE3Rk4vdzFIbSsvU3RuVlVndldHd2xtQmROa0JGU0w2cjFX?=
 =?utf-8?B?Tk8zOEc1aGVCZDJNT3Uzc1hWeG1XY3QyMnRDUUpxbytoZU5XYmQ1UzVWVFBr?=
 =?utf-8?B?Y0s4dWlwMkswS1RMQXJYTVgwa1JtOUwzQTN4SllETkl5VjZRcndVTk1GQjds?=
 =?utf-8?B?U0xVN294RVA2MzNOaDJVZ1lCNEtWc3h5MS9TeWRiRmxKVjNMaDhsSDZWTVBP?=
 =?utf-8?B?alFnODBXRE1jUTlwMmNkQnhPdlA0T2ViNHFMYkRnemF5aE1KaTBDMkYzeG5x?=
 =?utf-8?B?bmtUNlVTMll3dzM0aTdmdWJpSGFwbmxYbVBYQXRyYUdCeU9aaDNWZGwvbVEx?=
 =?utf-8?B?MmREMVh4MkhUcTBpb2VWdU85dXc1TlBUMExXTUpHRUJGc3BvL3M2eDdRT0Qy?=
 =?utf-8?B?bHdQV1VmOWdUZ3FESURwREp2c1BTYjA5OTBhdExoMDVIbXc2WFBjdlM3MTdO?=
 =?utf-8?B?Z3FUOWJBdHpoWFB6Zm1YQVZVUE1YWkh4eWR6VjVBMG83NE5HSTJtMi9TUFdY?=
 =?utf-8?B?Z2xyc3dwTXUxOElFNEpmcTZ1YmRaKzFlWHZsZW4zTTdDV21PSGFrVTNpUVcv?=
 =?utf-8?B?M25CcytydjVBdVBJUnRndDBrUVBNcUpVQlkvTzduU3ZpazdGZ2UyS2RqUHpi?=
 =?utf-8?B?bXFMcnlqVW03Yzh1NTYyeVlDMlVTUGlMdWlNSS9XSzNkZnpIUmoyMG5ZUWdy?=
 =?utf-8?B?ZU5WOWhodHl2d3VydHpQWklNMGtyVWhCNkFWeEZCbFJoRGh4Nmh5bEYxTndY?=
 =?utf-8?B?QWhNNkw0ZzRGQWM1YStIWnBvWHliZkxHYURWNTIvTlQvcFBZTHluSlZKY1Na?=
 =?utf-8?B?eXZIMnk3cFJWZXZPWmZUSHZOazhEbG50NTVLUTg2NkVKNFEzbFNBREpxNWFM?=
 =?utf-8?B?MDE2Ym9EUU1sMGFEZXRrYUpIT0tTMTNRa0NZa3cxaEpLZEgvRUs1bUlwVWFB?=
 =?utf-8?B?bE9NNFZFbWNXbW5odzI0bzhOdjZzT1h1dUc2UDd0aHVPdnRxQUthdkc1cmpu?=
 =?utf-8?B?OXlEenVUblRYY2dhRXgxRmpYSVZsMENhWFdLa1dQY1lSRWc2NFh4OVhiNDVO?=
 =?utf-8?B?U0U0RW9oQmx1bW5WcTlub0tuRXUxRk8xa2lZNFJnblc2ckQ2UW54UGJqQ0FL?=
 =?utf-8?B?WkFyWENVUStYZVNRdFZmR1dLK0ZSa3J1WG9uQTVCTk0wOEJNb2h4QWYycVp1?=
 =?utf-8?B?KytBV1VOc3lyOXc1YkdwaEZvUFp4ZnZ4QVBSQkJGYXNFSUx3THhoZFpSclRO?=
 =?utf-8?B?R21JNUJBVFZRMVVxT2l0T0QwTlN1RGtnaEdOMktvSSs3bjY0WlhmcW8xcitN?=
 =?utf-8?B?aVpMTUt4VzZOZHFTSDBwb2lKd1dBWGxyZStyUGdXWUNZR0cwUDI5WWNwZFIx?=
 =?utf-8?B?WXdGYzlJRTl0eElCNG5OcHN5UDRmanBCZ2Q3ODJ6M3RRdHJxSS9BaWhPd0VF?=
 =?utf-8?B?TW00WmNKZXdiQUh4bEd3bFdybllCQUhxOW5wVTFlNGtuNnd4UDE2Zmh3TDVm?=
 =?utf-8?B?L2ZxNk1VUmJwT0NPanhDTFZPWFZONnR0QW5mQU5HWHJGYW5RZWFXQkVGem14?=
 =?utf-8?B?enJOR2JwYk82MmpycGZzakM1YU1PS1g4YUlqRGxVWWdHRGNHakpQRU05NzBZ?=
 =?utf-8?B?eFgrb3p6TDN4UGF1N29HZHRwWFhjeFllNTluZGdYSTNveksvU3ZwNEN1SGIz?=
 =?utf-8?B?OHA0SjJBWWx4dXVQTklDS253RlhNTy9MNytURklUVFdBcjBBNnN4KzczZERW?=
 =?utf-8?B?YlNkajF0dXgvVUhTZFRuTVpOU1FrVnNVaUhNRzZXREJ3YkExbkdiczVRc2Rq?=
 =?utf-8?B?WElGRWhJWVpLem5nK20xMmFsZ3FzZnZnQ091V0FlZzIyNlFUbllPbWg0RTlk?=
 =?utf-8?B?cW5QWlhVdk5YNUgzNFM2TGlFaDV5MFAyb1B3allhbHZxSmFiOGlmb2pBN3VU?=
 =?utf-8?Q?GXpo=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4579137b-2b88-45d4-b662-08ddefae0454
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5149.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Sep 2025 14:34:43.7114 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3U/KPwWRVV9yKY6xXw1/PSmSjRe1WaAUsBHUwRK4cOWqTMWr3AwDDrJWL4UEq8pD
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYYPR12MB8961
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


On 2025-09-08 12:15, James Zhu wrote:
> This reverts commit cab1cec78c8fd52e014546739875a81150f11080.
>
> migrate_vma_pages can fail if a CPU thread faults on the same page.
> However, the page table is locked and only one of the new pages will
> be inserted. The device driver will see that the MIGRATE_PFN_MIGRATE
> bit is cleared if it loses the race.

Missing Signed-off-by tag, with tag added, this patch is

Reviewed-by: Philip Yang <Philip.Yang@amd.com>

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
