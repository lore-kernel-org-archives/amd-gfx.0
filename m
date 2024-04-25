Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C060BC4345F
	for <amd-gfx@archiver.kernel.org>; Thu, 25 Apr 2024 08:18:27 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E847410FCF1;
	Thu, 25 Apr 2024 08:18:26 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="EuXcX851";
	dkim-atps=neutral
Received: from NAM02-BN1-obe.outbound.protection.outlook.com
 (mail-bn1nam02on2086.outbound.protection.outlook.com [40.107.212.86])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7D2A210FCF1
 for <amd-gfx@lists.freedesktop.org>; Thu, 25 Apr 2024 08:18:22 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hQvJpxWfqdO7DiZKM3v/iOrdARwbjKDV4zWezds/XbQdaeFJOzZ9hmpVjNQDJFtGZ+3Zn8A51ef6TRyWwldLb+6YRYlXFsbOylbm8m7AsfyTL4DBuh8kF4xtD0/1LHQzOh/z6DzkUmLGwxNuEOHgdhJuRwwu8jzBg2DGYHN6y+3FHqnCHpIG5Er5/Uyf2Yy4epaW3Q+GMIDyjvxbuE+CVTwbffpmMFn3NQkTEsyO8nvYmfm7lzwNm7xnCXIApNVe0GGhiRKsbE1dW+IgteHiyedWK7/8U4Cx/bVnSeED2vLdcNGPDqxVEcr5uAv3YNoZBIfPQwTWNWOxptRkKLuF2A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2zObIyzJBUUHeU3f8jj1ZNxEQTSRxr/Hu77R7D/KJbU=;
 b=gn2flBvpIOYAqwamki5XAitykkV/LCFhp+NpYQFv/zXwMifsPGip3mHiuRUuPAjwOHOauteveErJ0LlfUHKDAekcJExaslcrZ4iUcgm9JMwwHbLWgirAzoMr0//nwXNEdDcjJlVa796+VY/Hqjr1z1s5yQFi/nZyvi9fO+U9tbJO8SZ8wIkLeiZhfTPXVzrS557DVoFioX57ZHKx1HnZNDz0Ih9TPrDmI30Bsf3X3mNV6pPfFyKp3a/n/eGRtneymuIen+7sUyCS2J33uCjXOIqSnBqiUgRbmOWD7CEZhPeEh1BzgLTa2VLteRijTQJR2mkZcEey21xRQ2WaDDmisg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2zObIyzJBUUHeU3f8jj1ZNxEQTSRxr/Hu77R7D/KJbU=;
 b=EuXcX8515LJoMHuQSNLLvMIkvdkhGZCcfP1l/sGm/UQGwcuoOOY9tu1FNxaGINFVTe9rRfLOOtpOp+V9lQqv4FP8j3x6VmxlcclSjRz0MyqOxqoaQ+Ykhn6w2awvstTRUDu0k90lQVCMTOUe8eIWq5qNDStGk8cahOWYx5w6CbE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN2PR12MB4342.namprd12.prod.outlook.com (2603:10b6:208:264::7)
 by LV3PR12MB9095.namprd12.prod.outlook.com (2603:10b6:408:1a6::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.22; Thu, 25 Apr
 2024 08:18:20 +0000
Received: from MN2PR12MB4342.namprd12.prod.outlook.com
 ([fe80::c55f:19e:6896:cf3]) by MN2PR12MB4342.namprd12.prod.outlook.com
 ([fe80::c55f:19e:6896:cf3%5]) with mapi id 15.20.7472.044; Thu, 25 Apr 2024
 08:18:19 +0000
Message-ID: <e74d8e87-e052-4b34-916c-35e7777e0d06@amd.com>
Date: Thu, 25 Apr 2024 13:48:03 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] drm/amdgpu: Modify the contiguous flags behaviour
To: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 amd-gfx@lists.freedesktop.org
Cc: alexander.deucher@amd.com, felix.kuehling@amd.com, philip.yang@amd.com
References: <20240424071337.3206-1-Arunpravin.PaneerSelvam@amd.com>
 <ec22be89-32f1-45b4-89d7-7aeaa81558c5@amd.com>
Content-Language: en-US
From: "Paneer Selvam, Arunpravin" <arunpravin.paneerselvam@amd.com>
In-Reply-To: <ec22be89-32f1-45b4-89d7-7aeaa81558c5@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BM1P287CA0012.INDP287.PROD.OUTLOOK.COM
 (2603:1096:b00:40::35) To MN2PR12MB4342.namprd12.prod.outlook.com
 (2603:10b6:208:264::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN2PR12MB4342:EE_|LV3PR12MB9095:EE_
X-MS-Office365-Filtering-Correlation-Id: 90c88112-cc13-4843-e444-08dc6500441f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|376005|366007|1800799015;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?U0xqTTBqOGxPT2QvVk5KY044TkJMOTlUN092bWFXTVNCekZ4SklBNXkvdElC?=
 =?utf-8?B?UkZXRzJTVTVkUGVxeVNCSVN6S09nZWkyNHpReEJzby95Zlc2Mm9VenBsZ0Er?=
 =?utf-8?B?MncxTmtqTUJsU0lHWFhENnF6dUpoTkdBbnE4dWVvMWNqMzVUN0RYcXpScEJ6?=
 =?utf-8?B?UEFPTG02WDJqZ3Q5L1VUazRtUzZoYWovc0hpVkV2SjJkZThsU2NXbjd3SkNr?=
 =?utf-8?B?RTE5Sk9vRWNnMG1kUUNvUmlpN0Q1RW90Q3RKZTZkTmlUanArQ2MwVTZvZTRN?=
 =?utf-8?B?OFIvYzRZSFNWRjRVY3JWa2tyWXdzQ3RBaTUzOHQ4eERnOTVIMmtHMW1vcG5T?=
 =?utf-8?B?a0k5U3lUb3lNelQrQmtOa2ViRHdZei93Q2ZSMjQ1Y0FlV1NmK2k2MnFCc3FV?=
 =?utf-8?B?WTA5Z0drdmFNcm1EMTZkOUJ5Q3k3czZnRndVbStMODFGYXBuK0lxUXhsMllC?=
 =?utf-8?B?UUdnOUlhZUlSeFUyTnpJdGNaVkZZVEowR0sxVVZKRlpjWkhJR2FwYVJIcFFh?=
 =?utf-8?B?WVFaeXlZdVo2QS84WXlDYlorM2lrSUdoU0R2T0RNMHVFVmg1SlVTdDYxUlh2?=
 =?utf-8?B?djFTUUQvT0R6WFYra1IyOHc4dm5NS0lmTGZNaDlLRmhuYkRxa3YzOGdndmxW?=
 =?utf-8?B?S2Q2OTVDMjlNU05ScUtiQlh4NnpSWGNVUUpDeHRVM3lpYVZpdi85aUQ0R0R1?=
 =?utf-8?B?WVowbi91Zk1McUhXNXJVSTJacG9oUmorZktpcGRzVnA1amJqa1Nmb2pUQ1FL?=
 =?utf-8?B?bHUxbTRzYXNvK1dqdkU1R2ZGZ0EvbXlnL2xFN0JBNHJ6WXdvZHIzcC92dnRT?=
 =?utf-8?B?NksvaU1JWFhmL0dmWW0rdkxmZ2c3NStzakJITk9uTVFRak96ajNDd3FvS3lw?=
 =?utf-8?B?UWRWQXRvZXlUMjltK1NxVjdYT0lQWTJMTExEdmVhM2NzMkFhZy8vL040cmtu?=
 =?utf-8?B?UEQxcXdCOWY4M1AxSlZVaFdiR2w2OHF0bTVVL3puVEFPVlU2TnpJSnBFbzBB?=
 =?utf-8?B?NVdYeTlqQmw0SWpoV3A4SklKWERHRmUxT2NOdTJIMVMvdmVncG5DcmpFeDli?=
 =?utf-8?B?VklhUXhXUzNseUZIdWNRTWh1elJkdHVlSzdlNy9xQmNvMTB5bEVKZnY5N2lw?=
 =?utf-8?B?WG1vbjNTbmh5K1VRU0xOV3FGWm02bHl3NkhWcHBLbVlPeTlLb3JFdDBpempN?=
 =?utf-8?B?MXJvL24rTFU5eGJQY1RVRGhaZk56SFJFcTdiOGMyUzVDeURvYTRMN3huQVpN?=
 =?utf-8?B?dGkyMlc0S2ZOU1QxRVdsak0rQkhwVDJtemZmMjdYSjc0aEVFNzc4M0NFL0lK?=
 =?utf-8?B?TmR5WlF2TkxWTXV6T0cxZy94RzNXeEhlVml5b2cxTWdFK3JFMzZjbkQ4T1d6?=
 =?utf-8?B?ZjlMUC9Kak9zUXd4dmtJb09VaE93MmI5aVJQbHlETWU3RXJRekthNUZ2aFN1?=
 =?utf-8?B?R2FVTkVGVXBBUEFod3hPNVJodzByUHY3d3hjNHE4cElUVVVvOVZzT3BGME9Y?=
 =?utf-8?B?YjB6UFBOanZpR3FZWXdSN25hZkJZNHQvMmpLWVN2Z3MzSU5tYUJzZ253b0Vu?=
 =?utf-8?B?VjA2RHowZ0JobEdmSFl4VXliSjJXNFlEYnlhcUc1ZzZHd1ZjNGpXVXFFNkd5?=
 =?utf-8?B?TVppZ0JHbkhvRnAxSXVSSzViVGtlRENYTUdIMmtLZ3o5a25pRm4vUzRZRGFO?=
 =?utf-8?B?S1Fpbm5ZazhkUU1kSXo2VEVHVFpqS3NPK3ZPYVluS0FTc3VoNjN1SVVnPT0=?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB4342.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(376005)(366007)(1800799015); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NUZYcUhoUVpQTTVoSE1DZEFxRXB4YnV5RmNhSjlJNE5rZ0hVL3A2R2YyNVNP?=
 =?utf-8?B?dldjWVRQeStBejVWTEJCTXBKbGxScXBJVHkxUDJUZzgwSlF1OWJ5cFJMMWtY?=
 =?utf-8?B?alA3TEtsUXhCcUtBS3dhMkU4UjNSajVjZiszdDdETllXQUFzb1UvMkZoMitH?=
 =?utf-8?B?ZkY2UGlyaXJYTnJCS0xRL1RDV1UxODR2QURFaHNERzRvbWdzNDdPN08wd2Fk?=
 =?utf-8?B?ZWFPem54a1ljdTNvS2dSUlF2QUdpcGx1cGE5UHh0MmVDZFVJTjYxdmZmNG5k?=
 =?utf-8?B?bkVhQjgzd2tjMjgvSlI1djdJYk13bHA2Q1ZzaHhJNkdOcEhDQmVJY2k1a29i?=
 =?utf-8?B?aEtJM2FWWDZZVFdvRkVia0FiWWg5Q1lTUkJZSGpsaDNPQ01Qd1NxUHZaTzAy?=
 =?utf-8?B?QmdmYVZhdU1VVm5KdkhaNDRrMlloRHBvZXFhaVhYNmFwWjNKak8zY1k0cmRn?=
 =?utf-8?B?ZU90Skx3eVo5aUdJZzdrUFdZWURSYklLbGZzQjZMVmIzdHBlOHVFMUZ6c29M?=
 =?utf-8?B?TGdIcjd1S0VEa09LR0dzcVluMHhRUDB0dXVLNzdldnVFWlFtamxrNUNMdHRF?=
 =?utf-8?B?MlAxK2VxZGR1TnRVb0V1WDJSbXU0THRqMG5TMTFkcVBDcWk1WHFDZmg5V1lI?=
 =?utf-8?B?cHcvQmZNeG4xTHRkVTltNDN0bVYrVCtsWFZ4ZEVlcGdqeGFxTzVWaFlNN0dK?=
 =?utf-8?B?VTJzckJuY2ZLcW9qSGhRZ0VOV2p3Z0p2cmNpc081MEpTbG9XTkcrVmpJY1NI?=
 =?utf-8?B?dHBjbWc4S2MzOXJtTExVU1ZQcEJ6ZVNFZUdtR3k3NHJvY1VnYTBBZlF4NEdS?=
 =?utf-8?B?V21FYW1laG9wVUVTTEhyditNbDUyTnQxM1MvdlhJUEZvSENSL2NxRDhQVStW?=
 =?utf-8?B?eW1xREw3N1crazVhbUtGVFJncDZmYUJnWjVoWWxKOHhaTk15WmFlM1JqUVVD?=
 =?utf-8?B?ankyOUhCdE5QdTNscExvSHlNYXZiUVBxRDd1SkpJT0xNMkc0SXZTNDlNWFlZ?=
 =?utf-8?B?Vis1Q3RkUXkvY0pDMVVoL2FxU3BJc3g2djhzbWVaa2krTTE2ZmZEeUJBZU9y?=
 =?utf-8?B?TUUxdlkrcDBVcjVpY1Q5L2NkaUNGenlnOWZTeTkwVWZDVUp4VU5MOFRkZGxu?=
 =?utf-8?B?RU5SYzJPMmZ4cVhLY1oycytWQzAvQnAxY0pKY2UzN2N2a3VQT25GbE5VTDhN?=
 =?utf-8?B?bUtZb0ozMSs3K1AvaWUza3JyTFVuZ0wxdEdVeXdEbzFYcXgxeDlXcDErV3M5?=
 =?utf-8?B?anQyWDIrdzZjOHM4RkZwS0tnSlZpcnIvSzgrZHJZbnpXKzdvMEhCU0xSUTdW?=
 =?utf-8?B?NzBwVUdHaFFhek1yakRUMnlCMUFJMXpzUlBPaHpESHNSQlBpa1huZjFzenVN?=
 =?utf-8?B?V0JJYzFMYWgrVjJLaks3RGhzVjJ2UDVDQy9pMThjTytYN3RMTDVQVnE5K3kz?=
 =?utf-8?B?Ymtyalh1T2dSVy9FbVlkNU9RK0tCWTBuZnVXTXFIbW9BWVBwQ1VtdDFVRitH?=
 =?utf-8?B?cFF2RmJvSWtFMm9INUE5S013R21Zclk5dmdjbDBYcFY0UHl5VTRPYTJhUStz?=
 =?utf-8?B?Z0hKSXc4Y0IxTE9TYVpiVXFIbGF6YmpyMm81d3BCMzRJR1o0Q0l3cVNYRUV5?=
 =?utf-8?B?SHFudVFaU1kyNGx1dGxnelNhYU5hUENueGFQSDRxckZJRk5ENEFOU00vZHVx?=
 =?utf-8?B?eW9UK2pHZ0ltVjcvYkZUREFFekV1MUdkR3FDb29ORitOVnphbXl1NTQ5RHVV?=
 =?utf-8?B?V3JiVldIbHV0aXovYmlIQWF3emJmS3JTN3RIWnB0dlRXSXBrZndBTjJIcmRy?=
 =?utf-8?B?QWxwaDhpaTBxZUlwZzdRK1ppSG5EVUUzc2M5US9Vb3dKa0RjbzlDSENGcGhK?=
 =?utf-8?B?aWlPaHZwWndKcUoxeVlFdHc4REZZKzV0L2RGSGRMK3gwOXI5Ym9BLzRZaldM?=
 =?utf-8?B?aFpib0FtUkY2RHV5aGNLcFhWQ1VjRU9WcS8xcjhubDlLeFkwTmxCZkJiTGNV?=
 =?utf-8?B?NDdHNFJNTkpFOEtjckpEWTlEMHBaSkRRcVlJVGl4a1MyY0FSK1FiM2JILy9D?=
 =?utf-8?B?aVZFbHVaekhqUk9nWGJrUDMva1MzRWdBYys1bEJoT2tyQ3piQXl1REtKZHZ2?=
 =?utf-8?Q?O1xbjPJCrJg/J/cuJ8e2aWTfL?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 90c88112-cc13-4843-e444-08dc6500441f
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB4342.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Apr 2024 08:18:19.8610 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4YgK+RDer2yzc/Y660kjhBDV4QQZvR7y3Vz+bMK0BBwJO9xDF0wD9TAmfrSFChpilkhKwZyLor0gPqJnL+BY/Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR12MB9095
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

Hi Christian,

On 4/24/2024 2:02 PM, Christian König wrote:
> Am 24.04.24 um 09:13 schrieb Arunpravin Paneer Selvam:
>> Now we have two flags for contiguous VRAM buffer allocation.
>> If the application request for AMDGPU_GEM_CREATE_VRAM_CONTIGUOUS,
>> it would set the ttm place TTM_PL_FLAG_CONTIGUOUS flag in the
>> buffer's placement function.
>>
>> This patch will change the default behaviour of the two flags.
>>
>> When we set AMDGPU_GEM_CREATE_VRAM_CONTIGUOUS
>> - This means contiguous is not mandatory.
>> - we will try to allocate the contiguous buffer. Say if the
>>    allocation fails, we fallback to allocate the individual pages.
>>
>> When we setTTM_PL_FLAG_CONTIGUOUS
>> - This means contiguous allocation is mandatory.
>> - we are setting this in amdgpu_bo_pin_restricted() before bo validation
>>    and check this flag in the vram manager file.
>> - if this is set, we should allocate the buffer pages contiguously.
>>    the allocation fails, we return -ENOSPC.
>>
>> v2:
>>    - keep the mem_flags and bo->flags check as is(Christian)
>>    - place the TTM_PL_FLAG_CONTIGUOUS flag setting into the
>>      amdgpu_bo_pin_restricted function placement range iteration
>>      loop(Christian)
>>    - rename find_pages with amdgpu_vram_mgr_calculate_pages_per_block
>>      (Christian)
>>    - Keep the kernel BO allocation as is(Christain)
>>    - If BO pin vram allocation failed, we need to return -ENOSPC as
>>      RDMA cannot work with scattered VRAM pages(Philip)
>>
>> v3(Christian):
>>    - keep contiguous flag handling outside of pages_per_block
>>      calculation
>>    - remove the hacky implementation in contiguous flag error
>>      handling code
>>
>> Signed-off-by: Arunpravin Paneer Selvam 
>> <Arunpravin.PaneerSelvam@amd.com>
>> Suggested-by: Christian König <christian.koenig@amd.com>
>> ---
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_object.c   |  8 +-
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_vram_mgr.c | 83 ++++++++++++++------
>>   2 files changed, 65 insertions(+), 26 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c 
>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
>> index 492aebc44e51..c594d2a5978e 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
>> @@ -154,8 +154,10 @@ void amdgpu_bo_placement_from_domain(struct 
>> amdgpu_bo *abo, u32 domain)
>>           else
>>               places[c].flags |= TTM_PL_FLAG_TOPDOWN;
>>   -        if (flags & AMDGPU_GEM_CREATE_VRAM_CONTIGUOUS)
>> +        if (abo->tbo.type == ttm_bo_type_kernel &&
>> +            flags & AMDGPU_GEM_CREATE_VRAM_CONTIGUOUS)
>>               places[c].flags |= TTM_PL_FLAG_CONTIGUOUS;
>> +
>>           c++;
>>       }
>>   @@ -965,6 +967,10 @@ int amdgpu_bo_pin_restricted(struct amdgpu_bo 
>> *bo, u32 domain,
>>           if (!bo->placements[i].lpfn ||
>>               (lpfn && lpfn < bo->placements[i].lpfn))
>>               bo->placements[i].lpfn = lpfn;
>> +
>> +        if (bo->flags & AMDGPU_GEM_CREATE_VRAM_CONTIGUOUS &&
>> +            bo->placements[i].mem_type == TTM_PL_VRAM)
>> +            bo->placements[i].flags |= TTM_PL_FLAG_CONTIGUOUS;
>>       }
>>         r = ttm_bo_validate(&bo->tbo, &bo->placement, &ctx);
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vram_mgr.c 
>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_vram_mgr.c
>> index e494f5bf136a..17c5d9ce9927 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vram_mgr.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vram_mgr.c
>> @@ -88,6 +88,23 @@ static inline u64 
>> amdgpu_vram_mgr_blocks_size(struct list_head *head)
>>       return size;
>>   }
>>   +static inline void amdgpu_vram_mgr_limit_min_block_size(unsigned 
>> long pages_per_block,
>> +                            u64 size,
>> +                            u64 *min_block_size,
>> +                            bool contiguous_enabled)
>> +{
>> +    if (contiguous_enabled)
>> +        return;
>> +
>> +    /*
>> +     * if size >= 2MiB, limit the min_block_size to 2MiB
>> +     * for better TLB usage.
>> +     */
>> +    if ((size >= (u64)pages_per_block << PAGE_SHIFT) &&
>> +        !(size & (((u64)pages_per_block << PAGE_SHIFT) - 1)))
>> +        *min_block_size = (u64)pages_per_block << PAGE_SHIFT;
>> +}
>> +
>>   /**
>>    * DOC: mem_info_vram_total
>>    *
>> @@ -452,11 +469,12 @@ static int amdgpu_vram_mgr_new(struct 
>> ttm_resource_manager *man,
>>       struct amdgpu_device *adev = to_amdgpu_device(mgr);
>>       struct amdgpu_bo *bo = ttm_to_amdgpu_bo(tbo);
>>       u64 vis_usage = 0, max_bytes, min_block_size;
>> +    struct amdgpu_bo *bo = ttm_to_amdgpu_bo(tbo);
>>       struct amdgpu_vram_mgr_resource *vres;
>>       u64 size, remaining_size, lpfn, fpfn;
>>       struct drm_buddy *mm = &mgr->mm;
>> -    struct drm_buddy_block *block;
>>       unsigned long pages_per_block;
>> +    struct drm_buddy_block *block;
>>       int r;
>>         lpfn = (u64)place->lpfn << PAGE_SHIFT;
>> @@ -469,18 +487,14 @@ static int amdgpu_vram_mgr_new(struct 
>> ttm_resource_manager *man,
>>       if (tbo->type != ttm_bo_type_kernel)
>>           max_bytes -= AMDGPU_VM_RESERVED_VRAM;
>>   -    if (place->flags & TTM_PL_FLAG_CONTIGUOUS) {
>> -        pages_per_block = ~0ul;
>> -    } else {
>> -#ifdef CONFIG_TRANSPARENT_HUGEPAGE
>> +    if (IS_ENABLED(CONFIG_TRANSPARENT_HUGEPAGE))
>>           pages_per_block = HPAGE_PMD_NR;
>
> That won't work like this.
>
> HPAGE_PMD_NR is only guaranteed to be defined when 
> CONFIG_TRANSPARENT_HUGEPAGE is enabled.
>
> So you will run into some compile errors on platforms where that isn't 
> available.
>
>> -#else
>> -        /* default to 2MB */
>> +    else
>> +        /* default to 2MiB */
>>           pages_per_block = 2UL << (20UL - PAGE_SHIFT);
>> -#endif
>> -        pages_per_block = max_t(uint32_t, pages_per_block,
>> -                    tbo->page_alignment);
>> -    }
>> +
>> +    pages_per_block = max_t(uint32_t, pages_per_block,
>> +                tbo->page_alignment);
>>         vres = kzalloc(sizeof(*vres), GFP_KERNEL);
>>       if (!vres)
>> @@ -499,7 +513,7 @@ static int amdgpu_vram_mgr_new(struct 
>> ttm_resource_manager *man,
>>       if (place->flags & TTM_PL_FLAG_TOPDOWN)
>>           vres->flags |= DRM_BUDDY_TOPDOWN_ALLOCATION;
>>   -    if (place->flags & TTM_PL_FLAG_CONTIGUOUS)
>> +    if (bo->flags & AMDGPU_GEM_CREATE_VRAM_CONTIGUOUS)
>>           vres->flags |= DRM_BUDDY_CONTIGUOUS_ALLOCATION;
>>         if (bo->flags & AMDGPU_GEM_CREATE_VRAM_CLEARED)
>> @@ -509,23 +523,23 @@ static int amdgpu_vram_mgr_new(struct 
>> ttm_resource_manager *man,
>>           /* Allocate blocks in desired range */
>>           vres->flags |= DRM_BUDDY_RANGE_ALLOCATION;
>>   +    if (tbo->page_alignment)
>> +        min_block_size = (u64)tbo->page_alignment << PAGE_SHIFT;
>> +    else
>> +        min_block_size = mgr->default_page_size;
>> +
>>       remaining_size = (u64)vres->base.size;
>>         mutex_lock(&mgr->lock);
>>       while (remaining_size) {
>> -        if (tbo->page_alignment)
>> -            min_block_size = (u64)tbo->page_alignment << PAGE_SHIFT;
>> -        else
>> -            min_block_size = mgr->default_page_size;
>> -
>> -        BUG_ON(min_block_size < mm->chunk_size);
>> -
>>           /* Limit maximum size to 2GiB due to SG table limitations */
>>           size = min(remaining_size, 2ULL << 30);
>> -
>> -        if ((size >= (u64)pages_per_block << PAGE_SHIFT) &&
>> -                !(size & (((u64)pages_per_block << PAGE_SHIFT) - 1)))
>> -            min_block_size = (u64)pages_per_block << PAGE_SHIFT;
>> +        amdgpu_vram_mgr_limit_min_block_size(pages_per_block,
>> +                             size,
>> +                             &min_block_size,
>> +                             bo->flags &
>> + AMDGPU_GEM_CREATE_VRAM_CONTIGUOUS);
>> +        BUG_ON(min_block_size < mm->chunk_size);
>>             r = drm_buddy_alloc_blocks(mm, fpfn,
>>                          lpfn,
>> @@ -533,8 +547,27 @@ static int amdgpu_vram_mgr_new(struct 
>> ttm_resource_manager *man,
>>                          min_block_size,
>>                          &vres->blocks,
>>                          vres->flags);
>> -        if (unlikely(r))
>> -            goto error_free_blocks;
>> +        if (unlikely(r)) {
>> +            if (bo->flags & AMDGPU_GEM_CREATE_VRAM_CONTIGUOUS &&
>> +                !(place->flags & TTM_PL_FLAG_CONTIGUOUS)) {
>
> Better check for the variable you modify, in this case min_block_size 
> and then restart the loop.
>
> And check for the explicit return value.
>
> In other words something like this
>
> if (unlikely(r == -ENOSPC) && min_block_size >= ... &&
>     !(place->flags & TTM_PL_FLAG_CONTIGUOUS))
>         min_block_size = ...;
>         continue;
> }
> if (unlikely(r))
>     goto error_free_blocks;
We are not setting value to min_block_size for contiguous allocation, I 
have used pages_per_block
along with the return value for this if check.

Thanks,
Arun.
>
> Regards,
> Christian.
>
>> +                /* Fallback to non-contiguous allocation */
>> + amdgpu_vram_mgr_limit_min_block_size(pages_per_block,
>> +                                     size,
>> +                                     &min_block_size,
>> +                                     !(bo->flags &
>> + AMDGPU_GEM_CREATE_VRAM_CONTIGUOUS));
>> +                r = drm_buddy_alloc_blocks(mm, fpfn,
>> +                               lpfn,
>> +                               size,
>> +                               min_block_size,
>> +                               &vres->blocks,
>> +                               vres->flags);
>> +                if (unlikely(r))
>> +                    goto error_free_blocks;
>> +            } else {
>> +                goto error_free_blocks;
>> +            }
>> +        }
>>             if (size > remaining_size)
>>               remaining_size = 0;
>

