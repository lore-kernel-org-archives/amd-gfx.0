Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5EFDFC54E67
	for <amd-gfx@archiver.kernel.org>; Fri, 15 Mar 2024 12:23:32 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0D68B112209;
	Fri, 15 Mar 2024 12:23:32 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="nrpvlxPT";
	dkim-atps=neutral
Received: from NAM02-DM3-obe.outbound.protection.outlook.com
 (mail-dm3nam02on2060.outbound.protection.outlook.com [40.107.95.60])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DF74811220E
 for <amd-gfx@lists.freedesktop.org>; Fri, 15 Mar 2024 12:23:30 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mYjrGntTefql5Ur4pO00Fif6TvLQ0ysWi+sErjl2r1//5DoKiz+g54GROd3Sc/3MtrOIxrU51NKrCav1I3lBFg1MhDEQVzkAlG6zIeNQxf3q6jOrwT3hG6RCFOptnnWhip7OkraviZXj5HZS/1U6QbnRvk/Y002qL7+gkQNZa/wEmUUOysTyvTnIfWETQYYYT1kgtBYhYlK/KZhIe52zqBeDpL/W/ek4bWQY85oQB9VgBv9m3/SJbX3gcX7t34wAxORVBxl2bzHjSUK06PQ0pRi1pGbmqDAO/L8mMYSDBUX2H7aCSvTlMULi/bPywel02nHpjV0QcNhx0esxkbo0iA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+AdXUppuGeUizoIfM0As0OFwfelLUnO6XDC4O8p5VyY=;
 b=iTA+JbDmNz5iAxlMsC4n3mpxnEQkyGYxmmqEfa22BexWFBXMGZFWkpsAoE7mZdJ0SxtIkfkJsMSTsJ+oZvgCfVncCI+7PsmvNRHHBMtbQ8hPruA27XaJ87vg4tXnZc6A7RfB2WlGGR00YzaswTvDF6AVgTQ59ibyoIOe/GZzQEUlHeHuYKiBH2hnXrS6F+aTbW2CvDPlixhmGXCfJT4uhh8S94zRGa11dBZnafSkio/Z6f2afsbYA8BYb8isW3GtFwD4Tt4hBhCc6MTCUXQ5dOIYCzk2qsYx6cJhNZlDAUnxQH/Z3nH6KJ3EN/rtkvz/kmEpVJQ6VHh/OqJ89EvfDA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+AdXUppuGeUizoIfM0As0OFwfelLUnO6XDC4O8p5VyY=;
 b=nrpvlxPTG5McRZTfxxwzDzuWtf6C6aX4sKSo7bmIh/p8JklI9jLa6yGPBfeLYsPxq6l/E1KvDUbnUosidf8V2MzWCRiOfkLdd/1XDAsqq+MteuK6GFSz2j7wtcCpWaKRqJCa3zG3FIG9c+EGrzvY5BBYMunm6dap0TSOfrlhQnM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS0PR12MB7804.namprd12.prod.outlook.com (2603:10b6:8:142::5) by
 SJ2PR12MB8691.namprd12.prod.outlook.com (2603:10b6:a03:541::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7386.22; Fri, 15 Mar
 2024 12:23:25 +0000
Received: from DS0PR12MB7804.namprd12.prod.outlook.com
 ([fe80::f349:addf:ae3e:814]) by DS0PR12MB7804.namprd12.prod.outlook.com
 ([fe80::f349:addf:ae3e:814%5]) with mapi id 15.20.7386.017; Fri, 15 Mar 2024
 12:23:24 +0000
Message-ID: <7190d590-dc75-4b27-965a-2cd2ea465836@amd.com>
Date: Fri, 15 Mar 2024 17:53:16 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/1] drm/amdgpu: drop setting buffer funcs in sdma442
Content-Language: en-US
To: "Ma, Le" <Le.Ma@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Cc: "Zhang, Hawking" <Hawking.Zhang@amd.com>, "Song, Asher"
 <Asher.Song@amd.com>, "Deucher, Alexander" <Alexander.Deucher@amd.com>
References: <20240315091607.1070927-1-le.ma@amd.com>
 <9b808afd-8daa-40e2-a4c9-365ef4bd63cd@amd.com>
 <CO6PR12MB53951B5DDF728C963913FB86F6282@CO6PR12MB5395.namprd12.prod.outlook.com>
From: "Lazar, Lijo" <lijo.lazar@amd.com>
In-Reply-To: <CO6PR12MB53951B5DDF728C963913FB86F6282@CO6PR12MB5395.namprd12.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PN3PR01CA0065.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:99::16) To DS0PR12MB7804.namprd12.prod.outlook.com
 (2603:10b6:8:142::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB7804:EE_|SJ2PR12MB8691:EE_
X-MS-Office365-Filtering-Correlation-Id: e43da467-9f6c-4d2c-cef8-08dc44eab5eb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 7l+e2WJ5uPoOVwTxS6e9+Ktw1Gnd+JkgL/Aq3mUD2tPXrTAAejbV40CwTYws2lcx5WwVjApUwov24uWi8JxbxD+oviia54xBFSyMnhNX+H5soyxirc4sEDphq1+hH9o77RKGwo8J/Neac+m5t7VTO0EhPVKPAywalidrRZGO0jVjjGUh9VDnbom3SAFXKA7izT/KhA2Cshj1k6EVTjmghXfgNUuNhJOUtgdILPYo2VJDcIUPs5iDbe+cPYOjE20AyFibcPLDRCMBAfHFT03nw1ocm8Rs1Fs5X/7wtzNzEQl2JwdrDYCDbPPFi5H4SpEOPjJtQan7X8+fyHVjMAk76CviLro48fWPD7E4vuZgccR1EurK5ooC4JcOVkk4K05dlTHxMRd9HsfNA5lMSIbZ3eEm5I1JFhGAA21Cs402d66XiToGHBtghJgkJ/CrIO+vwIqxsc4itTgbMa+Ppm8v9u4QT3SqRbUcC2p4YolfUI+ndj4qLRy4vXRAmCL4ucSG++s5qSzjkqahpe/qIMDf6X/5KfLDXLa9aKZaxWWC68+HygSRhTabj4+m2pOIHOQuZcdvdd3Rg/whQnykNkKZPQek9HEAZRf45J9jsGYX2FY3ygEAWD4pw1O7cbAIG88jWMGnxWMbi5quBhHLfbp9zp8ZuXOm+VjrgBscpRM5eXw=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR12MB7804.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(366007)(1800799015)(376005); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?K2w2c0ZlTlJYZlFKOE9hbjRscTNxWGRrYTcxN1NIZlRWR0lUa3g5d2JNY2Zm?=
 =?utf-8?B?OEhpOEwyM3piKzlhU2xlRzNpSlVHbGRSS1VBWFNyQkxMTHdPU1BXZW9rYm9l?=
 =?utf-8?B?NTkxbzdHMGJhbThGRmE1a01HRE92K2hweFEzOEFXaFprVHhoVC9RckQ5TE5P?=
 =?utf-8?B?VWZYRUg0K0E2MmpzNERpcHdwMzBvY1pOQUVBMXhPZ2xvSlBYcXRaQzhnN1Rv?=
 =?utf-8?B?SWZ1MldIRjFibndKd0U5VjY0aEQ4L2JBMlNLQ3dhcGJPb3c5V0lROVBXRUpn?=
 =?utf-8?B?TDc5Zi9nRFYzR1lGcXo2QTBtQkdMQjN0Q1VCMG5Vbk1rdHBBc3BMT0cwR0Nl?=
 =?utf-8?B?RW9Jdktqd0pId1ZrSTNZQ2tVb0x5U0lTUVpqU2h6ZnR1L3pZcTJwa09YclYv?=
 =?utf-8?B?YmgwQlQvdTBFRERLTWREdm5Pc2NldUpJQjVxWUtxYkV4N3RLUDl5U2lSSXVJ?=
 =?utf-8?B?R1ZmU3NzbWVteTIvYi8zVmMxVGsvQ215b0tURVo2OEY3WjBXV2FiWHoxYmk0?=
 =?utf-8?B?V25zeXdZeVU0UVhkUm9zcEp1anVtWnJLcjlpRTJCRW5HWU1xUzNWS0hyYVpS?=
 =?utf-8?B?R1NQSnlLeEo1WDVDdHlnUXhEVXlFQmJHNzBKSmZHN0NFYjBsMDNaWHpOK2xQ?=
 =?utf-8?B?bkY2bzhFeEVsVEhjdTFYMG5mdkNDUk1nenVmaG5TOTFEU1dEUDJBV3gxTThO?=
 =?utf-8?B?MFp0d1M0bmpReU16am9QVUorWjlaKzFUZFN2ZFpWaXE3V1VOcFlvT3RIWjZR?=
 =?utf-8?B?YldMZ3R0ZmxVUmhzczVrYzZMZUNGZVcvK0VET3orTmdzSE1COFZuTEoxaEIx?=
 =?utf-8?B?NUpxYWVVeFc0OHdMZ2hveGFoMzFqUXJ6T1hLYkRaVExWcG9nMUVvWkRmcjN6?=
 =?utf-8?B?d1QxQU1BUDdsMGs2OXlHaVJkR05KTUprT255RzV1NVgrUjZuc0l6a0gyOGhj?=
 =?utf-8?B?eitVWDZ5elJyWU81Q2kxRHZRTStxSEZTd3EvVUdUcXQxM2xiR2NBWThqMjN3?=
 =?utf-8?B?TFF1TVRzRC9ZNGJHUEJwRW80SXhkYyt1bTFGYUkxdWhyK3lTZ1JDUm5LMDZv?=
 =?utf-8?B?LzZWQ3duM1pHaEM3L0pVUzA5bWU5UXdJZGlVbWZublRTeURKRDlIaW51MFlq?=
 =?utf-8?B?NHN3bGpIUGVkWFBFRDVBR0dOTHBVVDl2UC9VbHp4SjFBNGJPWlBkVkFDNzYy?=
 =?utf-8?B?U0xPZ2ZIRndRWk5UZ1lsSVRCNkx3aXFJU1p6WUdlTi9ZNGMwSk9IYm5qbUth?=
 =?utf-8?B?K1Q3WmhGU08rVm1qTU5ld1NTTW5uTk94aU1JNTRwQW9sVkRRS2g5NHJZYm5n?=
 =?utf-8?B?cFplRndXaFBuYWFicXBGbzdXYmlqNE1OSmw3c3JSRTFKQUthWjRmczg1dXZJ?=
 =?utf-8?B?ckcxNzcyaHF6WFptYURFeFZMNy9VUlZnMGlZengzU0JPT21tamplNndLaE1n?=
 =?utf-8?B?RVY1VmFicm1FT080Mm41bFZmMENUQ25KT2kzWHRNOWNPNlpoWGNVU3ZGU1NV?=
 =?utf-8?B?VWYwT1JXdUtYYWhJT0lvUVVnbjd3cUZ0dVluVFk4K0Y1TDRHcEU3M2paS2Ur?=
 =?utf-8?B?U3A0U2RkOUdUV2Y0Vi80SEJrUGxubEQyUy9qczJ5dWRtcFZYaXN5ejRaU3R6?=
 =?utf-8?B?OHBCaCtLci9QdkEvOFN6S0pWTEM3NDEwQkw0SnZCRldoUEN5WjVmRnVIVTNL?=
 =?utf-8?B?VThDN21hNU41YTNOR2VHYnIyL2VDeWxBWVhvOFMwRTlKajJCYTVJVlZ3KzBm?=
 =?utf-8?B?dTBWRjlWUEZ1QlV4Ymw1RDd0aVpmOGE5UVZlVWdub2V4ZVVIWnJsWnV6L0Fs?=
 =?utf-8?B?b1g2MWh4TG1kcXVKK0ZodWxSSWZSUzduTVNJR2NCdy84L0RXZVYySzF4cEZG?=
 =?utf-8?B?N0pLZjkrMGN1aGNUV3VhYkgrb2ZVK0RjNGpXUkhVcE1hK2MrOWV4NGZUMDl5?=
 =?utf-8?B?MXBUTGhpZHU0VDFOZmg3ZUxKM0NRSFJnUUpaU0RTOWo5WTF4RFQ5aWx3d1lt?=
 =?utf-8?B?bVZ3a0VMd2VsSXRSdTluQ3AzMXF5SThGSG9lWSt5WDMvU2pZd1R0Nk5ITFR0?=
 =?utf-8?B?azl3OUlLSGgzSXRHazN4VEdoWHVYRnhPeEIzNEd2cXg0VGw2aGFZeDYxRmE2?=
 =?utf-8?Q?Geu6uVEDWOmqxYE/WlwM+9LAZ?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e43da467-9f6c-4d2c-cef8-08dc44eab5eb
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB7804.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Mar 2024 12:23:24.8674 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: v41P9CuBZszDP8bP9RDMVs//XCmPdwLJTfTLpDROHYLIbmWWfFtIY6bmE76628Zg
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8691
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



On 3/15/2024 5:45 PM, Ma, Le wrote:
> [AMD Official Use Only - General]
> 
>  
>  
>> -----Original Message-----
>> From: Lazar, Lijo <_Lijo.Lazar@amd.com_ <mailto:Lijo.Lazar@amd.com>>
>> Sent: Friday, March 15, 2024 6:14 PM
>> To: Ma, Le <_Le.Ma@amd.com_ <mailto:Le.Ma@amd.com>>; _amd-gfx@lists.freedesktop.org_
> <mailto:amd-gfx@lists.freedesktop.org>
>> Cc: Zhang, Hawking <_Hawking.Zhang@amd.com_ <mailto:Hawking.Zhang@amd.com>>; Song, Asher
>> <_Asher.Song@amd.com_ <mailto:Asher.Song@amd.com>>; Deucher, Alexander
> <_Alexander.Deucher@amd.com_ <mailto:Alexander.Deucher@amd.com>>
>> Subject: Re: [PATCH 1/1] drm/amdgpu: drop setting buffer funcs in sdma442
>> 
>> 
>> 
>> On 3/15/2024 2:46 PM, Le Ma wrote:
>> > To fix the entity rq NULL issue. This setting has been moved to upper level.
>> >
>> 
>> Need to call amdgpu_ttm_set_buffer_funcs_status(adev, true/false) in
>> mode-2 reset handlers as well.
>  
> Thanks for pointing out this. I think we can make another separated
> patch to handle it for mode2 since this patch is for alignment purpose.
> Actually, the set_buffer_funcs will not be unset/set in reset case as
> the conditions below:
>  
> void amdgpu_ttm_set_buffer_funcs_status(struct amdgpu_device *adev, bool
> enable)
> {
>         struct ttm_resource_manager *man =
> ttm_manager_type(&adev->mman.bdev, TTM_PL_VRAM);
>         uint64_t size;
>         int r;
>  
>         if (!adev->mman.initialized || amdgpu_in_reset(adev) ||
>             adev->mman.buffer_funcs_enabled == enable ||
> adev->gmc.is_app_apu)
>                 return;
>  
>  

Thanks for clarifying.

In this case, we don't require that since reset() condition is set. I
saw amdgpu_ttm_set_buffer_funcs_status(tmp_adev, true) getting called in
amdgpu_do_asic_reset(), thought it was affected by reset.

Thanks,
Lijo

>> 
>> Thanks,
>> Lijo
>> 
>> > Fixes b70438004a14 ("drm/amdgpu: move buffer funcs setting up a
>> > level")
>> >
>> > Signed-off-by: Le Ma <_le.ma@amd.com_ <mailto:le.ma@amd.com>>
>> > ---
>> >  drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c | 20 +-------------------
>> >  1 file changed, 1 insertion(+), 19 deletions(-)
>> >
>> > diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c
>> > b/drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c
>> > index eaa4f5f49949..589a734982a7 100644
>> > --- a/drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c
>> > +++ b/drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c
>> > @@ -431,16 +431,11 @@ static void sdma_v4_4_2_inst_gfx_stop(struct
>> amdgpu_device *adev,
>> >      struct amdgpu_ring *sdma[AMDGPU_MAX_SDMA_INSTANCES];
>> >      u32 doorbell_offset, doorbell;
>> >      u32 rb_cntl, ib_cntl;
>> > -   int i, unset = 0;
>> > +   int i;
>> >
>> >      for_each_inst(i, inst_mask) {
>> >              sdma[i] = &adev->sdma.instance[i].ring;
>> >
>> > -           if ((adev->mman.buffer_funcs_ring == sdma[i]) && unset != 1) {
>> > -                   amdgpu_ttm_set_buffer_funcs_status(adev, false);
>> > -                   unset = 1;
>> > -           }
>> > -
>> >              rb_cntl = RREG32_SDMA(i, regSDMA_GFX_RB_CNTL);
>> >              rb_cntl = REG_SET_FIELD(rb_cntl, SDMA_GFX_RB_CNTL,
>> RB_ENABLE, 0);
>> >              WREG32_SDMA(i, regSDMA_GFX_RB_CNTL, rb_cntl); @@ -
>> 490,17 +485,10 @@
>> > static void sdma_v4_4_2_inst_page_stop(struct amdgpu_device *adev,
>> >      struct amdgpu_ring *sdma[AMDGPU_MAX_SDMA_INSTANCES];
>> >      u32 rb_cntl, ib_cntl;
>> >      int i;
>> > -   bool unset = false;
>> >
>> >      for_each_inst(i, inst_mask) {
>> >              sdma[i] = &adev->sdma.instance[i].page;
>> >
>> > -           if ((adev->mman.buffer_funcs_ring == sdma[i]) &&
>> > -                   (!unset)) {
>> > -                   amdgpu_ttm_set_buffer_funcs_status(adev, false);
>> > -                   unset = true;
>> > -           }
>> > -
>> >              rb_cntl = RREG32_SDMA(i, regSDMA_PAGE_RB_CNTL);
>> >              rb_cntl = REG_SET_FIELD(rb_cntl, SDMA_PAGE_RB_CNTL,
>> >                                      RB_ENABLE, 0);
>> > @@ -950,13 +938,7 @@ static int sdma_v4_4_2_inst_start(struct
>> amdgpu_device *adev,
>> >                      r = amdgpu_ring_test_helper(page);
>> >                      if (r)
>> >                              return r;
>> > -
>> > -                   if (adev->mman.buffer_funcs_ring == page)
>> > -                           amdgpu_ttm_set_buffer_funcs_status(adev,
>> true);
>> >              }
>> > -
>> > -           if (adev->mman.buffer_funcs_ring == ring)
>> > -                   amdgpu_ttm_set_buffer_funcs_status(adev, true);
>> >      }
>> >
>> >      return r;
