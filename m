Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8D9C2C04A95
	for <amd-gfx@archiver.kernel.org>; Wed, 28 Sep 2022 17:30:17 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 036D710E50A;
	Wed, 28 Sep 2022 17:30:17 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2050.outbound.protection.outlook.com [40.107.237.50])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3006610E500
 for <amd-gfx@lists.freedesktop.org>; Wed, 28 Sep 2022 17:30:12 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=L9MN0Td1oQwkOuF4W3BBLjKzIaWoNi/r9ZVQs0f81+xh6tHaFboDJcVG0y3WlSHttLIREf2lCLM+BGT9hQLRIzIDXpGOFLPZDuk/aV6D+Ar7V6MTjmwVn/wvR+3FyzAEX810+zfuX5o9d22RufkWVEsmcx8mxigOYPXcabPLmUTUJw8VoViau7Uj6aytDxBQz87K28LcfDQ5msREeqtPoZMXfGLksplLhXuN7ASbLKxrFddzI1AymiXQ3EozuRUfhza8Z9cJufDEPWKJAaRAwunwBabO69tmqCBP0MnLT+hfrXBmOxNXl2EohZKa3NbfFjrAZH4K09iC6QePq4Go/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ju7ipzXULn3tbVysubry31TGNAWbv7Ux3k4HRPmQY2s=;
 b=gEo+VsMkk/PqRNZDCpREen2oAiSUN04pJKGr2DNYJ9u059xqjpCZLjM+FAQjYKy0JzwnNHbaKu/GjzgFyNlZ2SuQuX22it5pY/Gt0Y9c0/HuogfOj2viQCHCiaebNJ7zk7+YdCmToVnNApP8epDPvvkX9mC9Ks9KSZcltyTaMaZmVnt7JbVs+Da5KDeOwegC+CEOVaunOWNVG9zGSBSSpjbt/6De+BD22Vj2T11x9rEvfIrwALRddpsK6FMdIkr8+Vk7Ib/1xv7E4f51qaSCqA+Wnl3d1lvijzoawC9gkqCngUwSQXJzW8CFBpqmZ5e98Iu/ONcNGHjivjhWBcnloQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ju7ipzXULn3tbVysubry31TGNAWbv7Ux3k4HRPmQY2s=;
 b=ITs+ilcp0Pl1xjy4iOaJmxbVX4v5tBQzRqpwpeKo0qy3BPSSJOovTLQdiAhT1TOE2pVqoyWr1fE+NFaXhiZ1p0H97c3gX2C3T+BkkxwfZn6rwNMxag8OUv8AwYh2PCh5bvZEdqX8xcwOq443jIqo45PjhLGbb0Yc9xyw877vr88=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB5311.namprd12.prod.outlook.com (2603:10b6:5:39f::7) by
 MW6PR12MB7085.namprd12.prod.outlook.com (2603:10b6:303:238::9) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5654.26; Wed, 28 Sep 2022 17:30:08 +0000
Received: from DM4PR12MB5311.namprd12.prod.outlook.com
 ([fe80::fc54:e514:e096:b243]) by DM4PR12MB5311.namprd12.prod.outlook.com
 ([fe80::fc54:e514:e096:b243%3]) with mapi id 15.20.5676.017; Wed, 28 Sep 2022
 17:30:08 +0000
Message-ID: <d561ceca-dd96-9f7d-a843-68e0fd6f5ba4@amd.com>
Date: Wed, 28 Sep 2022 13:30:04 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.0
Subject: Re: [PATCH] drm/amdgpu: Fix mc_umc_status used uninitialized warning
Content-Language: en-US
To: Hamza Mahfooz <hamza.mahfooz@amd.com>, amd-gfx@lists.freedesktop.org
References: <20220928144951.89514-1-sunpeng.li@amd.com>
 <b410a60f-75bb-e0b5-a618-9cfff6601b75@amd.com>
From: Leo Li <sunpeng.li@amd.com>
In-Reply-To: <b410a60f-75bb-e0b5-a618-9cfff6601b75@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: CH2PR02CA0030.namprd02.prod.outlook.com
 (2603:10b6:610:4e::40) To DM4PR12MB5311.namprd12.prod.outlook.com
 (2603:10b6:5:39f::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB5311:EE_|MW6PR12MB7085:EE_
X-MS-Office365-Filtering-Correlation-Id: d87c64cb-a248-498a-be98-08daa17716d3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: JOkbCdSpr2PLg6n3+Zyy5YM8BlC45Nj//yFnGE0gz+XJEm4M2cQ8nVYvh/ldEUqFXEDYQQWVpahjSQtJCplXQ1IwJxNmnkVxAYUsc7/vhWA0pzQo6L8TVOkGq/ELyAMksgZegUwwIj3j8gXmuHnqxoXkcMiIrAjWUDVYWaK4aB7rUVPiRMI0dicBME80xr5VrylDt/z8N1g8VVeZ3CN06BS8+TbvG4wgIlAWfCA8Rumxor/lllFnhrsmLag4mw1wqslQwLR8GykNU2tr91fXCgDdr/87fXYiBuXvKPOUznjgOiBZsEHma9QW0Ze5Np8bDewkGmyglcbGzW9eCopQbHv0MwDcW27vtQh5HUbfsp+6zNfoDWX2xOO41mLPBqkMVArw7fDiFrr1kzRvEtQgUBe22VhSE+Fp4mHxEcd5mYkiSX9ijVFewmOvOf8f5OdJlVGqAlmEUVbCGcFLXVAognh7CDET+fNqv7QfbGVfGwXDn+OtgDAPKaKTNk610NGwG/VxAjL1OIxRv02RfoB08NTWLqiOJJyTKJL4qV8Lcm0j7+X3QfAPEZszMOKmNrzKedlDRvoRFCjbfgC/rzi8MAvEFaKnhH+SVSIL+lflvsnBOTGWezdx0nUCJQCcb12ddMi57pDmJc/pd8+HAkgBqp67GhhoW3SSDDi2YTIX0N5/ODhikiuVFywE+SZTjlJ3J75NgsvspHzj+m+7CQxSHuCOCF3PvNAz93mX5xTcwDVXTjWikdIukCGjASqBq26/WObD3B+2DJno+D5MZBWGLbEIrj7CtDK5ZteWl9f4RKI=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB5311.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230022)(4636009)(396003)(346002)(366004)(136003)(39860400002)(376002)(451199015)(36756003)(2906002)(26005)(8936002)(2616005)(41300700001)(6506007)(6666004)(38100700002)(6512007)(53546011)(31696002)(86362001)(186003)(83380400001)(5660300002)(8676002)(478600001)(316002)(31686004)(66946007)(66556008)(66476007)(4326008)(6486002)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VGhEZFppckFVUm1Eb2JQRFBmblJaUnN1K0VkSVQ1Uzk2anZHRlptWnQrWUgw?=
 =?utf-8?B?NkMxZS9HT1RQVzRBa3NqQ3pucHNMRmNRdEIwTUI5dEpFZlhBTWM1ejJOdHNz?=
 =?utf-8?B?M2lFblBEL2wvVlp5TDByN0wxS25OWUNWSDNhNW90aVF3QTZneG1sNElacE9u?=
 =?utf-8?B?c3B0T2ZkZG1nenNPQ1d5MjFpbC9xZStDN3daczRPbXhtTllPVlBGZ3pyMmN2?=
 =?utf-8?B?YXppV2hVZ3JXWkpUaDhaWWFld2pZTkg1WXJpc1IwRjRjR0kxOEN3Q3R1VXF1?=
 =?utf-8?B?eGtCa3FCT3dNeEJERitpNWZ3bTNQam0vVzNTcHg0dS9kYUhPc1JzQWhhR0xs?=
 =?utf-8?B?T0F2bURUZlpaZ2lPSWJ2bG9rdXV3UnQyNnMvKzNiZ1Q5UnZsUU4yV3dUZnN2?=
 =?utf-8?B?VXJ5Q2xlM29jMmFzWHJoYTVQa2Q4L1hOem1HT01lVHQvSnFzT09seGRKSEdo?=
 =?utf-8?B?UjNvRnhCRmplS29JcGJCZWlrSEh1UVNmbDcxbXBFUHlHYmJDcktyUEF2ZU56?=
 =?utf-8?B?NUFzZmI0UytxRWNkZU1GMktBQ1U2MEJRR0ZQQTBvZDJyUmpjNk9MWm1DREFV?=
 =?utf-8?B?SFNlYVZINWRNSndDUHBxU3NSVXVmcnBiODVsSnp2TllDRnhwTEZFV1RzcGxx?=
 =?utf-8?B?MGcxMmZ5TTREcWJiRERKMUpITDhYTHZlZ3ovWitrdTZjRUl3K1o3Q0pzVmtt?=
 =?utf-8?B?ay8zOXFGL2VoUHBIQ1RDYzBDdGpLRWswdHB0QTRhRmp3Q1NpUWYxbmV5U2tI?=
 =?utf-8?B?d2t1R3krNUFZZWUvQnF5QUU3aVRJTG56ZTNOdUYwRTBZOEdQUmYyWE52aHRu?=
 =?utf-8?B?ODlPRXZXWldKVVdDNnV6d0RzQUxoZ0RSN2ppbjl5bS9Uc1FjRG1UalR3V3BQ?=
 =?utf-8?B?aTA3OEhkUW1ZQXhtcUJ2V1hCeWFNMVJvVTdGSlBkdThsZGQxWk1FUk10S1Jr?=
 =?utf-8?B?UHdCdXlCZldiMlNidjNiUGxYcEliY3FCSGV6dDR0VTRMY0Vja2lsZXRPdlh2?=
 =?utf-8?B?cWtxdTdQaUVKZSs1a0xFdDRyd1kxOW9oZEpscHZ1d056TnFkRTN5QitORUJw?=
 =?utf-8?B?VFRZTS9iZmhWaXBKdThEZjlXTVd5ZThidW53UTdIcUFCV0FPSDIyaW14V1Qx?=
 =?utf-8?B?NmtGaEVNM2JYckorSGd4dTBPYTdJNkFDVVovM1NPNHVMNTV2RkpOcCszR0tu?=
 =?utf-8?B?ZHR1QVhhZUxtR3pkbXM5dGZpK0FwZlArM3V6U2ZUK3lQb2NXL2RML0dSTGZo?=
 =?utf-8?B?TEhXWi9wQThoY3grdUdxUHZ5VHFwalhrRWdWRlpNTUx6SXNwVHdXdnU0dXNB?=
 =?utf-8?B?VWV5ZUJTZ0t6UkJtMDZXaHpjeTdPeHRSbFJ1NkhoZTB6ZVdaM2N0d25WcGZC?=
 =?utf-8?B?TnJTZndsWXpOV3FWeVdkclkyVDFtR1ZGZ1c0V2gzUUJ2Um1UTmZ2M0hPTHV6?=
 =?utf-8?B?U0N5UUVRdTF5eDhKZkRPVVJKY0lidTZWNk9rYkxQaXVPYnJNdzB5cnZhdTFx?=
 =?utf-8?B?RXhxZ2pGa0JiVHM0VG5kcXc4TzBNZlpFalI2WHc1YmRZako5U2dhZ3NBcFRH?=
 =?utf-8?B?OXBPWGU0dmRDYTJyNkp5N1FxZEZPclZUZGRVd2JjK0VjaXNUVE9TSUMzbU40?=
 =?utf-8?B?ZHRSYXRueS9qVmQrWTB5OGIvZFBwVEtFMDJhOHhpZ1N2MHllUnlQRnl1MTFx?=
 =?utf-8?B?VVBnYldwOENHSStvT1JJUENPZ0NwMnlDQmdTSjZMb3MzcXNqdFZRaTVrUnBP?=
 =?utf-8?B?NkYyKzBQMFViRVFvZnFmakc0eitjbllmYkw3QUFwY0c4dGJuT1gwQ1V3dFhI?=
 =?utf-8?B?SitySHFRUVk5TXBrZEFJUEFEMEJ1Qmo3WmlOSkJlejBrUFRwMWhaNmo0a3lq?=
 =?utf-8?B?ZkFxY094eDhFck5zNDYxYmtOV0RuRm9vcTcxU3JFR3BnMXJQV0hmc2NsTHor?=
 =?utf-8?B?NFdXSEVLOXZUblZQVU9tdXR4eHQ0citLUE1LOWRrSVY5S25yNlYxS1Qvb2lT?=
 =?utf-8?B?d2traGgrWXVyOXF5SEhCVGY5RDJCektFNlNQaWZxSWd0RnRFOHQxQ3FGV0Nt?=
 =?utf-8?B?V1c1ZXJKdnFzYzF6eFBuN3RkVUVtNE5JSDg0NVVubGEwTlR4VEM4U2gzS1Bw?=
 =?utf-8?Q?w2wfGqOuwgOrYcoAGFhfmU2jS?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d87c64cb-a248-498a-be98-08daa17716d3
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5311.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Sep 2022 17:30:08.3908 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: B84uWXwSC2VxzIiNgkas9lEqfhAGMc4m4cfWJth8k/djwQv+C+OKNlJiDBEIZ9UK
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW6PR12MB7085
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
Cc: stanley.yang@amd.com, hawking.zhang@amd.com, tao.zhou1@amd.com,
 Rodrigo.Siqueira@amd.com, harry.wentland@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>



On 2022-09-28 10:53, Hamza Mahfooz wrote:
> On 2022-09-28 10:49, sunpeng.li@amd.com wrote:
>> From: Leo Li <sunpeng.li@amd.com>
>>
>> On ChromeOS clang build, the following warning is seen:
>>
>> /mnt/host/source/src/third_party/kernel/v5.15/drivers/gpu/drm/amd/amdgpu/umc_v6_7.c:463:6: error: variable 'mc_umc_status' is used uninitialized whenever 'if' condition is false [-Werror,-Wsometimes-uninitialized]
>>          if (mca_addr == UMC_INVALID_ADDR) {
>>              ^~~~~~~~~~~~~~~~~~~~~~~~~~~~
>> /mnt/host/source/src/third_party/kernel/v5.15/drivers/gpu/drm/amd/amdgpu/umc_v6_7.c:485:21: note: uninitialized use occurs here
>>          if ((REG_GET_FIELD(mc_umc_status, 
>> MCA_UMC_UMC0_MCUMC_STATUST0, Val) == 1 &&
>>                             ^~~~~~~~~~~~~
>> /mnt/host/source/src/third_party/kernel/v5.15/drivers/gpu/drm/amd/amdgpu/../amdgpu/amdgpu.h:1208:5: note: expanded from macro 'REG_GET_FIELD'
>>          (((value) & REG_FIELD_MASK(reg, field)) >> 
>> REG_FIELD_SHIFT(reg, field))
>>             ^~~~~
>> /mnt/host/source/src/third_party/kernel/v5.15/drivers/gpu/drm/amd/amdgpu/umc_v6_7.c:463:2: note: remove the 'if' if its condition is always true
>>          if (mca_addr == UMC_INVALID_ADDR) {
>>          ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>> /mnt/host/source/src/third_party/kernel/v5.15/drivers/gpu/drm/amd/amdgpu/umc_v6_7.c:460:24: note: initialize the variable 'mc_umc_status' to silence this warning
>>          uint64_t mc_umc_status, mc_umc_addrt0;
>>                                ^
>>                                 = 0
>> 1 error generated.
>> make[5]: *** 
>> [/mnt/host/source/src/third_party/kernel/v5.15/scripts/Makefile.build:289: drivers/gpu/drm/amd/amdgpu/umc_v6_7.o] Error 1
>>
>> Fix by initializing mc_umc_status = 0.
>>
>> Fixes: d8e19e32945e ("drm/amdgpu: support to convert dedicated umc mca 
>> address")
>> Signed-off-by: Leo Li <sunpeng.li@amd.com>
> 
> Reviewed-by: Hamza Mahfooz <hamza.mahfooz@amd.com>

Thanks! Will merge shortly.
Leo
