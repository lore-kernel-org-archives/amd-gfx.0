Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F14D6C54E58
	for <amd-gfx@archiver.kernel.org>; Fri, 15 Mar 2024 10:19:48 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 66A491120FF;
	Fri, 15 Mar 2024 10:19:48 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="TjSWFs5U";
	dkim-atps=neutral
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2046.outbound.protection.outlook.com [40.107.244.46])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D0E2C1120FC
 for <amd-gfx@lists.freedesktop.org>; Fri, 15 Mar 2024 10:19:46 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oZVivfOpevHuwJFPgkxlP1SKE1+c9MF0XX1H6022e18SGp4pyjmnz7/WejW/lvvNKTpm0w9m83G5zBHRVEBu1G8XbLKzT1D7x9mwCmdfUdwKzMU8iNrgOfJ+qD/flsL1flf4/OEec6yP7KPR8V5eyuSt6PucLvHjhSigoVh9CNWwcZOdj6tfHd5AOdh6ZSUMSkpYRwMLOybgizT9gokz/TyjPYE9sX7+vCI/zXFHSOKi2IBtduFWwciEVa1ztNrIbV+CJsqfe1eHPfEVbnnKXJbWKWj/hSmBas3jAJZ9zuh5jGIWMS6VdgWNIY+POA0TbIhAs6imAYcI5HUgpciApQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7kR3XWGRlkZ+w7CiCFTKqNBhsTLOa6vBeTv8GEkKius=;
 b=eOoCZg9s6V2eBDYKbH0l5xjgfKsDqsHrQEARaqQ1AEyFV8Xi5YRHl/60IxrKoyHW3L6wCcKlg6arvkE152KMl5dj1Ca56tbVuEt0PMcYcYyTHOdMnJS8n30j6XwT6KwZpd4JlbXUcMi5H/byhKFIExdR7aKqO5V/lE1U8PimsWWJPbTx6oQ8/2PyoZ3OLR3ohqfJuUeLfxBmzW+zgAxgRlqQrlxwhOcvkaEMTk1+fz5o9hkOH9ZLIj8lM3B9QIbfVJP0trbqV5k1lXlL7L9sELbqXCaaweUWEjACowsA0wpV9f6ga7wkusom8MzNYIGhWaf9c/7MUsMl0ye1a5ZqOg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7kR3XWGRlkZ+w7CiCFTKqNBhsTLOa6vBeTv8GEkKius=;
 b=TjSWFs5Uy2DG/yrFkeZQXv7gWe/AhZXCwAjhnNw+fE98cZoBJYGDRGYw+uDILkvaFJok+FkSp+nx+w6b6H2hztF2qLiAglZp1r2DP07XgJFRKM3eNKwGIyMiLQxiq8WAZZrUfS1ra3d6oo66OWO5SxbrjWuu+RIm+7b6h4enKG8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS0PR12MB7804.namprd12.prod.outlook.com (2603:10b6:8:142::5) by
 SN7PR12MB6957.namprd12.prod.outlook.com (2603:10b6:806:263::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7386.20; Fri, 15 Mar
 2024 10:19:40 +0000
Received: from DS0PR12MB7804.namprd12.prod.outlook.com
 ([fe80::f349:addf:ae3e:814]) by DS0PR12MB7804.namprd12.prod.outlook.com
 ([fe80::f349:addf:ae3e:814%5]) with mapi id 15.20.7386.017; Fri, 15 Mar 2024
 10:19:40 +0000
Message-ID: <e51b0612-e5e3-48e6-a600-983b45c7ba19@amd.com>
Date: Fri, 15 Mar 2024 15:49:32 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/1] drm/amdgpu: drop setting buffer funcs in sdma442
Content-Language: en-US
From: "Lazar, Lijo" <lijo.lazar@amd.com>
To: Le Ma <le.ma@amd.com>, amd-gfx@lists.freedesktop.org
Cc: hawking.zhang@amd.com, Asher.Song@amd.com, alexander.deucher@amd.com
References: <20240315091607.1070927-1-le.ma@amd.com>
 <9b808afd-8daa-40e2-a4c9-365ef4bd63cd@amd.com>
In-Reply-To: <9b808afd-8daa-40e2-a4c9-365ef4bd63cd@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN3PR01CA0152.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:c8::16) To DS0PR12MB7804.namprd12.prod.outlook.com
 (2603:10b6:8:142::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB7804:EE_|SN7PR12MB6957:EE_
X-MS-Office365-Filtering-Correlation-Id: a00403c2-7d7c-41fd-2271-08dc44d96ca4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: nUSCVbYIHYeKvln2httyXn2kM3LnFJyzySEbVdQ7B2sEZJOT/yA5C8SJ/wRK87ny871bQiNxrcEeuZJU6kg012o3Jnx214Z+DuVApm3ymRBsU6QCWSZp8dVK9jmx8P1d3Ed5Y73Pbe7VStMFVSa9332iX8UdLfLz9ESMaU3cdV3UTd1A946apvaE6q6uk4UNkaUei40qglrDlYdqdV5xFAj455l97lxF1bm/21i85JAIEvkC2IPxwSezhw+3MRlJ4wjn6Q1/9pv6Mhjb9g137SPEuO0lbbF0UtxCWApwH/jSfOnAQReIcek+KHQ26Wqm+cLmDziqX+52prUufz65oFyeB74VIHgR4TEeJn3ur0w8DJOqRwDvnp1yS1C9SMHVufZRk6F0RJTGHs+nL0Mct97QID7kUPoPNQQdHgTxunETXOYXntmOOx0pOQaUeIZu0lq1nGz4fIXuhMjZNCmYdv7vu394n7yQEmLfYouTCODidlGz6pgmeS+fzDnD0IF9g8Mf3jYSAgVkKlNeg/t/tW6sZgbabIw09WovImEK2wqbJWjQMiI9p1FHvWSSyNuPAuAlBjHA91UOTaLFFYRiGFOBW7fnE1DRRJsopVjgfzPAtiqM1hEk1HO6HHP2pt+1CuKeQxxUkRSDuwQ07PfbGk4oXyrB4hEXrpckPBX9kx4=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR12MB7804.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(376005)(366007)(1800799015); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?OWJEYm1uNnN4ZUU1d2NqSDByQ2w1Q29tbDdIQ2hTQXhlbER3azBTZDRJaSsy?=
 =?utf-8?B?SnJpbGdNOUp1MG5NU3p5aFBSQ2w5WkFUc2FnZ0E1ZEhDQ1BaVjRlSHd6MExl?=
 =?utf-8?B?cHlCUTFRL0pKQ3V3OWRNNGFSVlZrcmJGcmptQkswK0M1ZllucFhaWWxhNTFp?=
 =?utf-8?B?aTRySmM1Z2pZVktaNVpjL1hTbVpHZkdzRWtpVm9DNEpndjNiRjBRTVVtd0Y5?=
 =?utf-8?B?UWthaTBSVkR1U0JsNXBQeXlLNGZmTHgrL1dRYWd2bnZyNGZORVpaRWFlQjVt?=
 =?utf-8?B?WElTWURCNi9XL29QMEpsalpFQXlQaUNYN1VIaDhSOTNtSlkrbUdZRC9weUFt?=
 =?utf-8?B?Rm8rQnNwR0RzcDBSTm81NEVqRUo0cnl3WmY3bk9hdHRUODlHRDUxWmlLbGlo?=
 =?utf-8?B?NU1OUW5PMi9TQ0JiMk11VVp6YmZvWUVnaDkzOWNST0NTN3Fzby9jQjQ4L3BI?=
 =?utf-8?B?ZDZBMWVkenFLNzlpYm9qSnZhN1B5MlNyQkhwb2VsVXJnLzhPQWtMV2pnT0hk?=
 =?utf-8?B?Z2lLU2s4dnpiVERKc29EamxVM1FtTm1SaWM0ZWsxdFBGWUI4Sk5nQ0Z1d0hK?=
 =?utf-8?B?YXI0TjhVY0psVVJjeTF4WWNCZ3d5SlVGekRuRkJEZ29tOGtSSmhOUHhMT1cy?=
 =?utf-8?B?T0tMY05pTmpGdU4wS1NTMjlWSWpQWjFPR2t5cXQwY0poNGdleU5IdDlGcDBu?=
 =?utf-8?B?L3JuRUFtYmc0ZnB1UngzNWVZWW9qTXRMNlhYRWZvZjU4dTFRbDdnV0RqVGhE?=
 =?utf-8?B?N0VNL3oyK3NIQ0h0c3JkYk9KR2p2bDQxVG5vMVJtWkdWYWdEd0EvNHR2YWd0?=
 =?utf-8?B?T0Rpc3V3UnZnOHozbTdwaklHY0VSNTNCd2IwaG56OUh4bUI3cERCVUY4TGtI?=
 =?utf-8?B?VVZLYkhaeWxXYzFGbzVJTEdoUWI4TTZPYkRFTUpkN1plandhZ2EzS2pjYkYw?=
 =?utf-8?B?Nk1jUFhzVnhQYUZXS3lsa2ovSTkzTndrOHROL2tjT2FCWW1jS1A4TVR1RnU2?=
 =?utf-8?B?c1RsY0QrK2kwaVJlZEV6TlF4aDNDZE9uOXFTRGg0QmppOW5hblpLYUVQUGFT?=
 =?utf-8?B?S1lnYjVrcEdiZnBGdWtWczE0M01pVm1Rckxob1FEZk9MQzhjOWNaRVJvRlR6?=
 =?utf-8?B?T1RFYlJ4UDV2dmNrVk8vR1VOSG1LNVpjUjhWY2E5di9RVFY0WjJMQWtBOVdS?=
 =?utf-8?B?bVBBTjhhcStVakl4R09KTk9wYytPb0tHOVU1ME1WMHg3S1lzUHVSSW14N3RU?=
 =?utf-8?B?ODRmR2xaQjMzSURMdGc5cnQ3cDdHK0hNNm9jamdpelphank1Ujc2ZHpqb0Va?=
 =?utf-8?B?NlFvb3h0QzZQSVVlNHBlVlhITnVzM2RZSzVNOFdLRHZkV3Z5U2RheFVUUWhl?=
 =?utf-8?B?VDlud2hXQnFxYStUOVdCSDJvbUN4VjdMVS9nbXVoVlRwbGlJcjlYeXZjOXFm?=
 =?utf-8?B?ZExTSExWRlMyV2NRVEdyOXFrV3dSWEVsaXNralhabmcrVUN3TzRtL09uNFZn?=
 =?utf-8?B?cU00MGswd1JHejNKZkhyWFJ3Q2VHbEZ2NlQ5enM2SlMwWGlRZHc0aExkU2tL?=
 =?utf-8?B?ME1DL0htakJ2VjRsdWh4eGpFSlg1TlQwSXFpdm9CbWo5ZkFTcGt1cUhwU2Vr?=
 =?utf-8?B?TVlldnR6bldjQUpOaEpZZUtpajNhMldVaEsrQXR2WFNSMkYrOUdBSjhZQnZ0?=
 =?utf-8?B?OUIrb0lONFF0RGtHSmU5UGNheCs2MWpxWWhvMWRQQThOMU0zSFBYYmZ4dEI5?=
 =?utf-8?B?KzZaWUhoRHlSTjFvT2JpNFZta2JtWHBhTitXaGVTaHY0MHRUMGFTMXdzVE5H?=
 =?utf-8?B?Qlg3Zk5ZaFlNZmxYQlNyYXA2VWRVYmhEaFEzWnBzNXh2TS94N1EvejA3NElS?=
 =?utf-8?B?Qy9zbW4yWU5iWnAwV3VIYk42Ulc5U2Vwd0VOL1NwQ21Yb2dqcFV0QStTZEhS?=
 =?utf-8?B?c2FwVSt3WWR2d2dIajFqdTRDWlNobmIyVjBvbVBkNm90WWlSM2w4bVNpRHlG?=
 =?utf-8?B?RXpFdklHbmRkWDlVeGx3KzlRSVdxaDRocXBvNnN5aG5DTTc4N1VhclVHa3RX?=
 =?utf-8?B?RWFsV3hKR1dhOFlBZ3ZLZllub2ROUTNYTmtPZTdjZUIxdXZiNUFCVm9ORzBC?=
 =?utf-8?Q?2fbRl+5hXkjsjS05nK6UIqV4G?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a00403c2-7d7c-41fd-2271-08dc44d96ca4
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB7804.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Mar 2024 10:19:40.4508 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VggjdybTDp5XBzzVCsijfyAiaN4fhk1+1PK8Ii0TeuulBEJ8VswWemXz0N9MLGLR
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB6957
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



On 3/15/2024 3:43 PM, Lazar, Lijo wrote:
> 
> 
> On 3/15/2024 2:46 PM, Le Ma wrote:
>> To fix the entity rq NULL issue. This setting has been moved to upper level.
>>
> 
> Need to call amdgpu_ttm_set_buffer_funcs_status(adev, true/false) in
> mode-2 reset handlers as well.
> 

Please also check if it's required here as well -
amdgpu_device_ip_reinit_late_sriov()

Thanks,
Lijo

> Thanks,
> Lijo
> 
>> Fixes b70438004a14 ("drm/amdgpu: move buffer funcs setting up a level")
>>
>> Signed-off-by: Le Ma <le.ma@amd.com>
>> ---
>>  drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c | 20 +-------------------
>>  1 file changed, 1 insertion(+), 19 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c b/drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c
>> index eaa4f5f49949..589a734982a7 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c
>> @@ -431,16 +431,11 @@ static void sdma_v4_4_2_inst_gfx_stop(struct amdgpu_device *adev,
>>  	struct amdgpu_ring *sdma[AMDGPU_MAX_SDMA_INSTANCES];
>>  	u32 doorbell_offset, doorbell;
>>  	u32 rb_cntl, ib_cntl;
>> -	int i, unset = 0;
>> +	int i;
>>  
>>  	for_each_inst(i, inst_mask) {
>>  		sdma[i] = &adev->sdma.instance[i].ring;
>>  
>> -		if ((adev->mman.buffer_funcs_ring == sdma[i]) && unset != 1) {
>> -			amdgpu_ttm_set_buffer_funcs_status(adev, false);
>> -			unset = 1;
>> -		}
>> -
>>  		rb_cntl = RREG32_SDMA(i, regSDMA_GFX_RB_CNTL);
>>  		rb_cntl = REG_SET_FIELD(rb_cntl, SDMA_GFX_RB_CNTL, RB_ENABLE, 0);
>>  		WREG32_SDMA(i, regSDMA_GFX_RB_CNTL, rb_cntl);
>> @@ -490,17 +485,10 @@ static void sdma_v4_4_2_inst_page_stop(struct amdgpu_device *adev,
>>  	struct amdgpu_ring *sdma[AMDGPU_MAX_SDMA_INSTANCES];
>>  	u32 rb_cntl, ib_cntl;
>>  	int i;
>> -	bool unset = false;
>>  
>>  	for_each_inst(i, inst_mask) {
>>  		sdma[i] = &adev->sdma.instance[i].page;
>>  
>> -		if ((adev->mman.buffer_funcs_ring == sdma[i]) &&
>> -			(!unset)) {
>> -			amdgpu_ttm_set_buffer_funcs_status(adev, false);
>> -			unset = true;
>> -		}
>> -
>>  		rb_cntl = RREG32_SDMA(i, regSDMA_PAGE_RB_CNTL);
>>  		rb_cntl = REG_SET_FIELD(rb_cntl, SDMA_PAGE_RB_CNTL,
>>  					RB_ENABLE, 0);
>> @@ -950,13 +938,7 @@ static int sdma_v4_4_2_inst_start(struct amdgpu_device *adev,
>>  			r = amdgpu_ring_test_helper(page);
>>  			if (r)
>>  				return r;
>> -
>> -			if (adev->mman.buffer_funcs_ring == page)
>> -				amdgpu_ttm_set_buffer_funcs_status(adev, true);
>>  		}
>> -
>> -		if (adev->mman.buffer_funcs_ring == ring)
>> -			amdgpu_ttm_set_buffer_funcs_status(adev, true);
>>  	}
>>  
>>  	return r;
