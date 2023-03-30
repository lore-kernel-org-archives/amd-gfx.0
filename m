Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 74A69C7619A
	for <amd-gfx@archiver.kernel.org>; Thu, 30 Mar 2023 19:51:05 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0F1FB10F010;
	Thu, 30 Mar 2023 19:51:05 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2050.outbound.protection.outlook.com [40.107.92.50])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F39DD10F010
 for <amd-gfx@lists.freedesktop.org>; Thu, 30 Mar 2023 19:51:02 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ABJQ+h04QXc1hpeV8nfN+CFZDSn8Hr239+mtUzojWkwWp82PrVVmxTtygzRTa3mn/uZXihpnSU6BXu3GboTvH8f2cpWdAO0L7J4zaYwjTCJ8fbphs03uNNJiPY9DOHQ4kANRHyFBorFpKbi58pZxU1PR0tmzsI8GuOBBapYIMBvTaksYxdxl9uXCKLCyGzThtKcSCTvm0HpafbpYg0g6GHExQQFB+u0bTO3QqIN6P3/6FP8gJYR1/cOz5CdEztqSmfmMlWtZ4/BRbkqkD4B8I2TNH2AbH2MvPSIFoZq8IWYvc9wjaOZlOPIkb9TgcCoRgGYWuqjXysiY0UuNK1NCQQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dOiJ/PDHsHCuYnk2Y4Ie47uSmKUICatO/H0MTrth3UA=;
 b=U1kB6l0GRdkZm4k5LeQbGPssDUXNtxRQREAHIjAyneypXH8aXuHACyM5WLLEIqeA/5zfojqrTcyptMdjqU8xVm9aMxl9RZ+EBzD4zr6jZNPs/S3gsfdINFdfGkp5NN1vH3PYQIDAU+Qo9DYW6jg1q7UoFB8Pk8prtQslpmkkj8OOhxVvsu3qpaHQpkFo1miq5/XuOl2mfMdC7yJsypuvX9OxX512WY1kxgQe0UApK/RAOJKtoQ/jcIfogzG8vOtfppC0w8Xo6jjksH8mjst4WT0EppQhWGhhJqOiaE6eGXyh3bx1dELcskB93ICF6h3a/B3xV/We+exzU4F63yLAlg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dOiJ/PDHsHCuYnk2Y4Ie47uSmKUICatO/H0MTrth3UA=;
 b=EH3mAHgDYh1LNYJCqerGgFpGN0WBv5UfSvrgxNerGy6bFC8qJKqhFAhkdbcxu/0jr0pIFS3Powm5RccLTxVZaeaR/STTZFKV+ePjrhlcJqD/T82q0Ap/CScrqTR1Y50wbebNcsTE9+2p1r/KqNpGVjnIpm8ihUr1C1+vO1jCJCY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN9PR12MB5115.namprd12.prod.outlook.com (2603:10b6:408:118::14)
 by IA0PR12MB7650.namprd12.prod.outlook.com (2603:10b6:208:436::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6222.31; Thu, 30 Mar
 2023 19:51:00 +0000
Received: from BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::f170:8d72:ca64:bb26]) by BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::f170:8d72:ca64:bb26%5]) with mapi id 15.20.6254.022; Thu, 30 Mar 2023
 19:51:00 +0000
Message-ID: <5c51e60f-e362-afcc-5f3b-a9aea06c1261@amd.com>
Date: Thu, 30 Mar 2023 15:50:57 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH 03/23] drm/amdkfd: Workaround MEC mmhub flush issue
Content-Language: en-US
To: Alex Deucher <alexander.deucher@amd.com>, amd-gfx@lists.freedesktop.org
References: <20230330194234.1135527-1-alexander.deucher@amd.com>
 <20230330194234.1135527-3-alexander.deucher@amd.com>
From: Felix Kuehling <felix.kuehling@amd.com>
In-Reply-To: <20230330194234.1135527-3-alexander.deucher@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: YQXPR0101CA0010.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c00:15::23) To BN9PR12MB5115.namprd12.prod.outlook.com
 (2603:10b6:408:118::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN9PR12MB5115:EE_|IA0PR12MB7650:EE_
X-MS-Office365-Filtering-Correlation-Id: d660a102-c117-4145-68b3-08db3158164e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: pPs70DZnL1W+KEAdNyQ3uUaqCDXLzeiGVdvfHkq1ZkUF41zMVf8OMykAtHoSlW9iGRQK1BslujENdp63X38wrEWBZfMQMBLNG24VClrxLzc1ZuNkeyFi/PatR3/sHcyN/q7wwXk04b54qoq2N5DWib/xDGv4RJxEgZEYtDtjsyN9RKoh83z0wkx3XCP2qhngx5gIXDpjUnV2lMCMZgumWGP1m7zEPkmkBURyXKMhQcVCZBMul075A1kE1N/lPuV2MHEvO+dOA3+umkqThPUjVGPl1fUEJ7K5ilp5npPuaLVDTBE7w6IrvH91Jk8coNhDrely0NsKD8kDBAUIbjU77tnhSYQShul5Bs23C2fcjMdG0U9fHfg4R6z/sas9EGXptitiFcHSLMeaoDMLTu6K1ZzZXmwJAVaP1tsZ9p9VGRBX4FWjmZGZpvdwcAIjmKaco4cpYEx3DVFi8qGORQ7D4dBx8M/1uIqJ5XZN8tA3ZhuGHIiTIlBzi7Zdm+Ttf6UgVearzl38RvUFZWXF1PzqY3KBts3HIDX2978GMyyJCZczznK5aYC7T1PPg3ibtmgRyk8b+b2E1v9nKp4VwPVdq/cSnVMOGHozhhgNpx0QH+cMmZZMWssAUgameNFTUXXdgZ2E5Al3+nVp9W6q/BvC+g==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5115.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(4636009)(136003)(376002)(396003)(366004)(39860400002)(346002)(451199021)(2906002)(31696002)(36756003)(86362001)(38100700002)(31686004)(478600001)(5660300002)(6666004)(6486002)(83380400001)(2616005)(8676002)(6512007)(6506007)(4326008)(44832011)(316002)(66476007)(66556008)(66946007)(54906003)(186003)(8936002)(26005)(41300700001)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZUxnalp6MkJTN25weThBUjBXZGNYbEo2VUJ2UU5yT2xWdkJRcm5MeUdud3J5?=
 =?utf-8?B?VHRhT2VxV3AvOVdLU0N4eHlXMzh4V3B1M1BCSEVqb0ZWdE1qV0Y0ZUVNSzRP?=
 =?utf-8?B?K0dJUmRRdlJZQ0w5cTZGb0Jtb3dBdHJrU25DTGdyWmJnWFpjcEtmN0ZydURx?=
 =?utf-8?B?aXVwcFkrUnZweWJCY1o2TUlNNmJYYXVGeEo2OExZZXdHb3BTd0xEai9jTlhm?=
 =?utf-8?B?WWRPN3phRVFoM052djY5SDlhSEtMSVV2RE00VUJjNng2aDIwWkxhMW9VS2pJ?=
 =?utf-8?B?a2dMSFJ1dlhmK2o5TXFDSmpOY21Pd2wyN0x6NEhxQ3o2ZXdwLy9aWFByNkZE?=
 =?utf-8?B?alZMZXdHaUovWXl5MzVkOGdjd2xjd090djMyTnorMHMxT2JOUyttWlRCVjgz?=
 =?utf-8?B?WWQ5K1grMnNsVTE0K1J5VWZZS1NXOFAyclVwWFJtODVqV0RjRWJnWWEvRUND?=
 =?utf-8?B?YmxlWnRsekl6N1hiTEphaTZTSlhPVkhYRVVaNUQ0Mk9ORnRDa2wvdXEwSUpz?=
 =?utf-8?B?Vm91YVZYU0VzenI4NzRFMkdrdm1EV2N3cFBjSUxORFVsbE52QUhsVmNoNE91?=
 =?utf-8?B?emxpQzhxWEx1MXc3eitHeXl1RUVPVllYU2F0akRoaUczdjJ4MUlHeEEvdEow?=
 =?utf-8?B?OWszWU8zZTdUVTdJK0Q5eUJ4elB2V3lvSEliMEpOTGtDbzFqSGFwTHI4bzlE?=
 =?utf-8?B?TXl2VUxjbm50d2JLeks3WTJuUi9BSUJ2QW1hWDNOOFJ2dk9NVjBZYWlDdmcv?=
 =?utf-8?B?dVNVaVFiZFNDOEhZcnlkdENTUU5FRzN3RFNJZGp1Mk9veHloSUFKaEhOUFpV?=
 =?utf-8?B?TStHOWpnMVlSUFJidDRXeVA3ZURyRzdhd1dxbFZnbVl2SGRsaEJLSzkvY2ZH?=
 =?utf-8?B?RHlqNkYyRjRLdEZTSkZhYjZQeWN4U3dhTHlzMnI5b1hsOXl6WkJkbVU0WVBa?=
 =?utf-8?B?OFlTUWNTMkNyUC9xL1dDcDdZWWptOTAzV3ZVYVowWDBObFhFOWFNZGwrcGVJ?=
 =?utf-8?B?QkpYWHNrUmFtS3hrY1JCQTd2UllCOGlwaTRuQlBaUUZZM1ZBRE9UVEprOThF?=
 =?utf-8?B?VWxvbjBXVkhtaVlUelZxNlNuZGxwRkpHVnlYMmdHZFNXR0IxbVdOV2VsMHUy?=
 =?utf-8?B?aDZ5dkZwZFkwTGc3dThVeXBlZkRjTi90OUxLcFFhVGx3cDNTdGJHU1NlWE9W?=
 =?utf-8?B?cU9ZMGNyTEltSXBRZndnVGNwZ0x2U0VsdGFmN0ZCUmpTa2V4RlV3dzcrczY0?=
 =?utf-8?B?ZTl5QklqcHlUS1lXc212WFY3bVA1SitwMENkRC9PMWdtQVF3STFjVCtBRzho?=
 =?utf-8?B?VmhnZG93L1hQQ0JuT2x1b0NkNko5U0lqM2FNdWNKcTRTWHl6RVB1MG8wREI5?=
 =?utf-8?B?TzBKNEZhbklhcHRMQms2ZllTTDIwUmZreC95cElVOFFEdnFERXU0Z3JKOVZ3?=
 =?utf-8?B?eTlTcE5rdEY1SFNlLzl6LzdNSjRDQnk3cTRXZTdkRTVFS0hVV01LVWNSTGl4?=
 =?utf-8?B?bDAxdTlnMUluNnI2TE9BaFpRTE1BVlVRYmUyTGhYMkJFK1RTNHNjSUlsQ1N0?=
 =?utf-8?B?c3Nja2h0ZCs1NkdFakV6WXNjeFVRL095VTd1bHdVSkN0OHM4NXUvY3VqZnhB?=
 =?utf-8?B?Ymw2MWVzQktuQVU2MllaQjNtdDk5ZXI3REREUTB4NEVVRHdtbHpFNk9ieFRh?=
 =?utf-8?B?UWlmQ0ZBbEFudVFBWkVPS04xdXVLTjVzVVBRTUxTYTgrVUdYYSt1bC8zN1hK?=
 =?utf-8?B?QVJEbU5ud2JocU9JRDFrYllLN3g4MjUzSnV1T3JvTFdBazlqNjVzSVY4dGR1?=
 =?utf-8?B?WEZ3VURnSVZVVGFxcXlGTWRWTDdESXVxNG52STBaMTRsSEpUOWdaNjNpcnRG?=
 =?utf-8?B?dlF2eXU2UXhpaVhLelJDUWdUTS9PaHZtMEIvZXZQeUh0NFlIeTlvc1Rkbkla?=
 =?utf-8?B?aUh3OUU2OGkyQjgrOW1haHRzOFZwVkorNHBBanRzOFptT25JYjgvR0trTVMv?=
 =?utf-8?B?WklUbGFIWGxJZHhmUTZJN29YYm83Q1p1MFVIdXNDRC9IQ3NDTHQ1MC9MSzhE?=
 =?utf-8?B?N3E4alBpWEFEbnhCV0pLOEhYLzFGM1BHM3l6MXhRVm1YYVp1V3c0VENPZyt0?=
 =?utf-8?Q?A64Ct7N46Mh4BbWrBRiqcJetC?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d660a102-c117-4145-68b3-08db3158164e
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5115.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Mar 2023 19:51:00.5881 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +OT3tnViu0JNXy091COfl1hwG7y75m2VTnVW5na54JyHxTcvaJcHUNm6BGsoYW04U4+Np1FRuhWKafDnESzpgA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB7650
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
Cc: Philip Yang <Philip.Yang@amd.com>, David Francis <David.Francis@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

I think this workaround was reverted later after a firmware fix.

Regards,
   Felix


Am 2023-03-30 um 15:42 schrieb Alex Deucher:
> From: Philip Yang <Philip.Yang@amd.com>
>
> MEC FW should flush TLB and cache when unmapping user queues, this
> is not working correctly in master FW via HIQ, it affects SDMA queues
> which use mmhub on AID, cause several KFDTest failure.
>
> Workaround this in KFD for now. Will revert this patch to verify FW fix
> later.
>
> Signed-off-by: Philip Yang <Philip.Yang@amd.com>
> Tested-by: David Francis <David.Francis@amd.com>
> Reviewed-by: Felix Kuehling <felix.kuehling@amd.com>
> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> ---
>   drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c | 9 +++++++++
>   1 file changed, 9 insertions(+)
>
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
> index ab91a0e211c8..1d53cbc55253 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
> @@ -1038,6 +1038,15 @@ static int evict_process_queues_cpsch(struct device_queue_manager *dqm,
>   					      KFD_UNMAP_QUEUES_FILTER_ALL_QUEUES :
>   					      KFD_UNMAP_QUEUES_FILTER_DYNAMIC_QUEUES, 0);
>   
> +	/* Workaround MEC mmhub flush issue
> +	 * explicit heavyweight TLB flush after all unmap_queues calls
> +	 *
> +	 * It would not help if the firmware is unmapping queues itself when the
> +	 * runlist is oversubscribed.
> +	 */
> +	atomic64_set(&pdd->tlb_seq, 0);
> +	kfd_flush_tlb(pdd, TLB_FLUSH_HEAVYWEIGHT);
> +
>   out:
>   	dqm_unlock(dqm);
>   	return retval;
