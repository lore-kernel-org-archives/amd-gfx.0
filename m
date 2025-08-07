Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8D48BC87FCA
	for <amd-gfx@archiver.kernel.org>; Thu,  7 Aug 2025 09:58:46 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3822210E80E;
	Thu,  7 Aug 2025 09:58:46 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="dPK9msYF";
	dkim-atps=neutral
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2088.outbound.protection.outlook.com [40.107.237.88])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B899410E80E
 for <amd-gfx@lists.freedesktop.org>; Thu,  7 Aug 2025 09:58:45 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MOzSVDh8kc+y4jrKVPVdDuSgHuU2ZhV7zRrRnYQ+NThnfO56kq7xi+aM1by4QPCVPQdOvFXQRzKiMMooJs3fISN74yttonVDYH7mPzIwxjsOPjZtytEveBhbi0Oga0zDoEx+U0twZVwRK/7HphT6C+y5wG8RCuKl6I0YvSlkbEVVxmPfQuPmfd1q7WlN5zKQseDlXyrtFFVNIiPxtTz832nUtOBSCGxlZjORdyqii4DECtzH2ZdOzpjXI1uKQywQsh+fsYSDpKaBpOqOPYO8b025f2iMN+s0iXBj4DPpxK3bJdX6dSXE/zsT9oIK+oNejmxHcbY3K0LshPFn6RJycw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zltcy2f1c1DUh6K+kjevC8+nkxsv9VxqieYoB1UQsWg=;
 b=iPqCEKhXOJ71mPlf2cGUygnb3l3xH/s3WfL8pmSGbCNkek3U889V8v15uMFXfiT5dWevBuZGslB5g4IzqAQbSeZ8exwor/pJMQkXNp+P1cA5PHi4w2rO6r/zpCwPR+aAqQm+it5FcNQGrHSj1s8t/l/f/DyH3rE54nPPPev1oYhTPlDQiY6xU7cC934GMgdvQUU1HcwYKyekY+16pxWk1mF29nQVUgmvTk4ov6qD+K3Iy2EUSR5YFEwTSs844k4HH29vvXLYCPIxrMYNUIaoIUWCeiytvoemirtAWTHrd228GtclFiSusGlOEFgU7YLt5AGI28btxD2q3f3H9eKqgQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zltcy2f1c1DUh6K+kjevC8+nkxsv9VxqieYoB1UQsWg=;
 b=dPK9msYFNfZrQ4NSNnTSeX+Ru3NhNEX0aPlC3jw5KIaqcB6mEvpWCEc4yJThVkCsKtuGA8UO53OHNJYTQMp5F2byh2bkZkLoUR0GFf5Y29vBPELWHrL9W/V9PviJRM8gUZEriUo/TyfsL6OGKyGFaa/GIsyCY23Ri2DVoifytY4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by IA1PR12MB6484.namprd12.prod.outlook.com (2603:10b6:208:3a7::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8989.12; Thu, 7 Aug
 2025 09:58:42 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5%5]) with mapi id 15.20.8989.018; Thu, 7 Aug 2025
 09:58:42 +0000
Message-ID: <d056d1f0-224b-4666-af96-09d4da53871a@amd.com>
Date: Thu, 7 Aug 2025 11:58:38 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amdgpu: Fix race condition in amdgpu_vm_wait_idle
 during process kill
To: Liu01 Tong <Tong.Liu01@amd.com>, amd-gfx@lists.freedesktop.org
Cc: gang.ba@amd.com, zhenguo.yin@amd.com
References: <20250807084655.1597669-1-Tong.Liu01@amd.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20250807084655.1597669-1-Tong.Liu01@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0247.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:f5::10) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|IA1PR12MB6484:EE_
X-MS-Office365-Filtering-Correlation-Id: 83241532-fdb2-4dca-f00f-08ddd598fd9a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?emV1NXBodlIrWk13T253Nlh3VXNFL3dOczJBRVRrVGJYQ1dZTzg5cFpTaDIr?=
 =?utf-8?B?WjlHZFQ5ekRKc3lQc3ZOOVNDaUV2SHRxNEVIdVNoakhzM1BWOG5lSExERzlH?=
 =?utf-8?B?dkxNR2RlMWtmbDdmTVJJY0tjTDJZaDNpRTVIc21zOXpUSENPZCsvOFEvM0lk?=
 =?utf-8?B?aVJTSlpDL1gzWm5GQUREYjBaOFVQZlpnbXI1Sy9lN0VkZHduN2Nqc2JxSmdF?=
 =?utf-8?B?Nm92azdkRFhwNDZLNHRHWmwxam5vMDR5MHpNR3RwU0RNZyt4WDd4SXJKZE5R?=
 =?utf-8?B?em5kS3BpSlR6WlZOUk14ZitSY1g5emZDKzdjRkFUUFBweng5WjJVOXJKOTZN?=
 =?utf-8?B?RUd2TjIvcHo2Z05BTE5iaGhqUWNlOFVpVllIRDM4NVAremFSdVY5bVAweks1?=
 =?utf-8?B?RVQ3UlEzVW1HaUpoamdBSW9lZVF6VGtjT2JDWVMrM1VtQnlZWGZvTVBCTTVq?=
 =?utf-8?B?QklzNWdZQkVsRUFtS3pQcmNpN3htVmVxdmttNmZETDZFV0Ixb0UxSDV3REZU?=
 =?utf-8?B?OXFURlVTZStJbWNRNVdPSUlpN0NlRTV5eFc0UnRLVkg0cURPeUxuUzFCT0Ro?=
 =?utf-8?B?MDdqbU5FUUR3bGpKQitOQkJzbnZ5dFBuNmE2QmJXY091MWJNL3dsb0tBeXNV?=
 =?utf-8?B?UGhtQmRjWmRIMW54RXZLZHBwSXNic040K2pZbDF2RUVHWTl4Z0FCOU5hTXQ3?=
 =?utf-8?B?Rk5HeEovbXYxMTlYYUIrVmlRN2JsbmNLSmo3a2VnN3FDcUNia3RpNzNEUmZy?=
 =?utf-8?B?eHFnZjRBeDRwOHNncC90VG5aNkxJR3I4dkNOL1VyOEJwOW1sWE9MakgwLzl3?=
 =?utf-8?B?ZmNCT2p3WkpBL21WRDFvb1phdThHTmFvYXptMS92M2lFM2lTdkZOOGVOd3pU?=
 =?utf-8?B?UGdEaUpKUnhGZVd0dmNtVk1qYmlCNmZnT1kyUExqZlRTbUg0TjhvYzhnVTdX?=
 =?utf-8?B?UVpUM0hoNGJ2SkloTlJuSVozVDhmaXgyYnRTbXlwRGwwRFVVMDZHTmMzbEtH?=
 =?utf-8?B?SHJpQlA0WFIweFBwd2ZNVVEzTU1hRGh3T2c2QTYwMXlwY0xqTXNCeGM5M3M4?=
 =?utf-8?B?SDlqdXB2WlB2SUtDNlJGejRpOEprMncwczhvb0FiWWNLdjRlQkhTbi9od1RN?=
 =?utf-8?B?SGh0RGEwai90RE9tM3daNHY3ak14blQrSk96TTBRQ3lOcjdFc3JIWCtLTHUx?=
 =?utf-8?B?UnZYdkVqRVJ0TkJlbHBWQnNQSFV2clBkaDZERGRXQzM2Q0E4R3QzOUtMV2Y1?=
 =?utf-8?B?b0EzWXhKdFFJQzJ3WElLeURORjNMZTE5WUU2ZmNpK0U5WUxBdnYraThmZXQz?=
 =?utf-8?B?TVFiWU02dmF2ZXB5NE9VNUVFSHVsdnNldzRSaG5ocGUwVGtWa0NWVHdyZmNT?=
 =?utf-8?B?SWJ5a1ZhOGdsbWt5ZkJGZmgvaW1vUDZQcU05ZURKTTIySUlyRVdTN3hTNk5E?=
 =?utf-8?B?dmFOME9ySjRXRldDZzJCOVJBamRtUk9IZ1dRWXpnQ2VnSkozaFVnVGJzWEZz?=
 =?utf-8?B?NHpIS1V5dkI5Q2FlUmdtQXdrM3ZaNzZ4Y3ozaWxLU0d3L2IxN3VtckxtQWx5?=
 =?utf-8?B?UHlHMWUxRDkxV3NlemRrUDlFN1VsRVpwZGdtN0xmbno1T28xenRZUGR3UEVm?=
 =?utf-8?B?a2M2Qnk1UHNaalF2Vmd2V202MDNZdm5oWDFGUys4KzAxeWJYRisvbTdvM3BL?=
 =?utf-8?B?TXFCaUJiQXZCaldoUTE2Nm81ZU1aWkVOSEdwR2lFbHpvTFlmZGxWazBpMStT?=
 =?utf-8?B?OVo1bGFmeWIrNllPaXgyYmdyMm1ITzltSVVxU3duajA3LzA0RG15c2Urc05o?=
 =?utf-8?B?bmZEYjVQMHBxMXRpUGRYbGsxblhwc2pGazk4VmxtTWJMTUVwUkcwZm93aVpu?=
 =?utf-8?B?VSt1ZDEvbEFFWHZnSXhNT2hsM09IUmdVS0hYdE1CZ1pIQkJUblJSUnZHSmtP?=
 =?utf-8?Q?VKAGFrv3Qwo=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?d0xxbXRJZUxMVTlvVk9iVXJyVDRsMHpjZWtvclBiR09acTBiQUt5b3luU3lj?=
 =?utf-8?B?SDd0c1VoYnJxTHlQc0g5VlR0WkZqTDk5aWhoODhsUldPcU52RzVqak1SRXZp?=
 =?utf-8?B?TW1ubGdpNHJnR1FTOCtwZHEwMC9QYkFsWk1KR0RscmJIWHRMN0drcXA2MXN1?=
 =?utf-8?B?dTEreDdhcXdOc3F6RCs0Y1c5d0wyUUxiRVphMS9MazBIY0JqbVJBczkrSmNp?=
 =?utf-8?B?T0ppd2xUbUsxSmF2T2pjcXoxY2VNRkFiS0VOdkoxR25iMDhIZm9OSVBRNHJ2?=
 =?utf-8?B?cHJlSStPRkhjYVltL3Q1aGl2Zlc0bWxEVHZOMGllQ1Fmd1B4WTJENlI3c0Na?=
 =?utf-8?B?ZXZBTDhPdWltNWdBYTM5THdVYWpKQXB4ZU1MbXh4U1ZwU1RwYmxhMGprbHpR?=
 =?utf-8?B?cXBReUNCcis2ZUJCOGRMcUt6Z01JMm5xenFHT2pZT01sMEJrK2hnelJYTi9L?=
 =?utf-8?B?VlVDNXZIRmluS2owaU5udUtlS1Q2bGZZV2NiS1lTSG1hMkVFUkZXdVY5Tmsw?=
 =?utf-8?B?ckxxVkcyNU1Na3ZibWhVZ1AzS2FRdWFTeENrb0tMd0EwdGJSbm04anE4RnJr?=
 =?utf-8?B?anU2bUlmMCtVTlhpRDhhRkg4Qm5iOVhCeFgrdmlyQUwvNVN5c0c2TGlJOEZJ?=
 =?utf-8?B?SU1JU1VCeXJJSEQ3OFEwcjBBclArWk5hOVlVTjhLK3cxdjBEOWM3cXZDdnBo?=
 =?utf-8?B?QmhJdkZ6VEc0UmlJbXFpanFSS00vbFhEK0tKcXFGODBxcFBnTzdOUFNwSXN2?=
 =?utf-8?B?bDdSSERiWmxEZTU0TmdyZVJ5RTJQOHVTYWVXYWNsSFlTVi8wR0FaUVdtNFZP?=
 =?utf-8?B?RmphQ1AwODZ6endKcUZqcFptR01DTktYWEdVNFdDNjhEOGVHN3FRN1czOWR6?=
 =?utf-8?B?dXBHenYwdTU0Qm84RnpRMmphS2xDOVk5K0ZsUDNMckp5QVI0NExYaFZ6LzVT?=
 =?utf-8?B?NHA4bUlmWE41QjBEY1VVZTBkTFFnVG5IdnJoSWxnZEgxeElkNkFmc3hwazhz?=
 =?utf-8?B?TXpJUFArcEpDMnU4YzBPaEFlcFY5UEdOUDFza0NUNnhVa0J5M0N5STNCZEJC?=
 =?utf-8?B?NmhBM0hiSGVwUDRQQ1FXd2lLQVRQZGpxeVZzeFduRlJ1Szd0eEY3a1pRTzJ1?=
 =?utf-8?B?SkZwYU1reWNvUTEyVmlrdHZBWitwYXc5ZGd6cVpKWUVPMjNiVmErRkJ6ekFy?=
 =?utf-8?B?K2laZEFzQzZmTzI3ZTJ2V085cmt0Z3N1WTJLVTQ0VUVJRWF6KzVVRnZJU0Z4?=
 =?utf-8?B?eGpGVVhEYzlQM2NpVDdPT043dHB1TXMvTmdPMXhTU1lsUlpMOEFKclpvYklB?=
 =?utf-8?B?MTNsL1hSa1o0bDNUeWpzSU1qV2p1REpncGNKRjkyc1h0T0taMHdSbXk4TnNH?=
 =?utf-8?B?K1RCYWViWmdLbXIrdDdUbHFKdVhZTmV1SWJKVkM3dnR0UGxuaXdVdGJXTDdl?=
 =?utf-8?B?aUpaYUF0VTBhRnlaS3FPZUprVHJBQXVUbFI5clc4TTk5QkxvaWVOa1hmakor?=
 =?utf-8?B?cTJGOUZmekRPaGNEYWhubHhPOHYzd2RObUl4Nk5XL3lHaXE3ZHVsWU44VWhY?=
 =?utf-8?B?UUFGVVc0UndrV3ZUVTBUbVc5V2NkYjNnb25sZ2xic0JUWGdTcjArYmlKTzFX?=
 =?utf-8?B?NXRIU2s1NmZ3MDhqWGpYUHIvZ2paejZXeXlvRWtzS3pLTmFtTmpHUGhTVDA3?=
 =?utf-8?B?ZFRNbHhOek02TmVPVHJiZFB3Rmd0T29vZFBEWG5kek1VeHk2M2M0dld2MVor?=
 =?utf-8?B?R0RUVzlZUGRyTll3R1ZpQVdnMGo3UmZXcGM1dkg5d3B2aklBZG9XdlowM0Qy?=
 =?utf-8?B?Z3NTaTZmZThGYkpTYmkvUHB5TlZCaXN3RHJ6ekdzZDl5WmxobStibjJlSkdC?=
 =?utf-8?B?d3JpRFB1MnRvMGdpSTY1UjBtdy92VWIvTkF6SFAwTU5sYm8yQ20vRTR3RUFK?=
 =?utf-8?B?b1NQd1VmY2JMZVpBVHFvK2pLbjJ3V2J6S0dESDhSZEVGU3Jua1ZVZUNNdGsy?=
 =?utf-8?B?MTUwV3ZBUFFURHBTcnRMZ0crZHY0K2VtbDdSV2FYTks5djQ3aks4Zlo4M3Vw?=
 =?utf-8?B?S1h4NmY4ZzB1UE5FQ0tCZk9BZXBPaFdDNVhEUEhIamNESU0yRmVUVXFISVBN?=
 =?utf-8?Q?K+z715qZQcOaDlJ7SlceJg9pS?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 83241532-fdb2-4dca-f00f-08ddd598fd9a
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Aug 2025 09:58:42.5777 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5cZfk/7GJ7c0f1hpOuGqp+N05qFovFfNfIv5n+zf5686RI1IR0O/5Fh5WfMZyn7J
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6484
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

On 07.08.25 10:46, Liu01 Tong wrote:
> The early commit b8adc31cc0ca ("drm/amdgpu: Avoid extra evict-restore
> process.") changed amdgpu_vm_wait_idle to use drm_sched_entity_flush
> instead of dma_resv_wait_timeout to avoid KFD eviction fence signaling.
> But this introduce a race condition when processes are killed.
> 
> During process kill, drm_sched_entity_flush() will kill the vm entities.
> Concurrent job submissions of this process will fail.

Clear NAK to that. This is essentially why we call drm_sched_entity_flush() here in the first place.

Regards,
Christian.

> 
> Fix by skipping vm entity flushing when the process is being killed.
> 
> Signed-off-by: Liu01 Tong <Tong.Liu01@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c | 7 +++++++
>  1 file changed, 7 insertions(+)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> index 283dd44f04b0..ae43a378f866 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> @@ -2415,6 +2415,13 @@ void amdgpu_vm_adjust_size(struct amdgpu_device *adev, uint32_t min_vm_size,
>   */
>  long amdgpu_vm_wait_idle(struct amdgpu_vm *vm, long timeout)
>  {
> +	/* If the process is being killed, skip flush VM entities
> +	 * as entities of concurrent job submission of this process
> +	 * might be in an inconsistent state
> +	 */
> +	if (current->flags & PF_EXITING)
> +		return timeout;
> +
>  	timeout = drm_sched_entity_flush(&vm->immediate, timeout);
>  	if (timeout <= 0)
>  		return timeout;

