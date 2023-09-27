Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E2643E82CAE
	for <amd-gfx@archiver.kernel.org>; Wed, 27 Sep 2023 16:39:20 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3C6B210E573;
	Wed, 27 Sep 2023 16:39:20 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2061d.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7e8a::61d])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BE88A10E573
 for <amd-gfx@lists.freedesktop.org>; Wed, 27 Sep 2023 16:39:16 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WYZNlVgKxnHExzb8LnVBwPOPd1hFoKKdYzy0v0cokOGgZA8q/LbNo/o8lXYZoiVfiqWibnAjXZ/ZOXIl4VT+CGIroRMHe6B24F+MyKkFb3fLkFePTAsfWAdtI3uCd1y77qz0zvVBELmSaIngM64GNvdHRZvHT4OAqmZpvUjvupQRlr62wTYgz5hkCPaORzBVsMl7G+iJQFnog6/hYS4oWXfn+BqzfNmbspLYmjfBlOlEfu/ZqlwNOUHVVhrzMTlWbKIUw5bIwesD+C6dZMdkSuBDGXwuRSIYyBq1XeurkiD47SnVv4EKrmlq/qe1fg376w4FkXEgK+nZ5rr/Ga3V5A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8HDpG2KL6KyITccADHMjPn5it4Q5DUoVoAZME8buzD4=;
 b=DzSyQGjlnklgqAMLCws3rCePhbdaNSYjEmVW2b2/4w45Hx+yPteOw/ovsVKnPhVvVw/1xjAOSGkZPqefFpRDw8H0MQ2880Oqy5ENMAvYoCR0v6Ju0UMBTqT626BzVKyjOLN020GbO9xj/X5QgMCVZOemtbTHlNEAbX3mCWmcuFoApUL9cWysvFF5Z3SYIZ+ssp/dAvyv4HGfxbT74koE7GKlQqP6/AM7T1MNuAXE/VbgfYXHzK2f4pD6AGzLsoWlVobDOTmshQ5P0shVzGmQyAgY2cKwiqCxjKY4c22E5I71aQ5LajWukvfw0MQ1/xblRt/xToQZoZmjqAY9BgIJMw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8HDpG2KL6KyITccADHMjPn5it4Q5DUoVoAZME8buzD4=;
 b=hawt3+/knp+Mkot603oSYj/y/TCtvnm95fm4ok0OxoC+cK4H0E6ry1DpBYapM/riIAdqQoydnt3f/hTE7c4vOUsjZJvHnWvPCkDWB4EAvdHW9bGDVFwxpZuRXEKG19tKUl0IaqZ5YMp2iA30QydsvdIdZEtU7oxxuktNuNdYVhc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN9PR12MB5115.namprd12.prod.outlook.com (2603:10b6:408:118::14)
 by IA0PR12MB7602.namprd12.prod.outlook.com (2603:10b6:208:43a::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.28; Wed, 27 Sep
 2023 16:39:10 +0000
Received: from BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::2e40:ffd7:e752:644f]) by BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::2e40:ffd7:e752:644f%6]) with mapi id 15.20.6838.016; Wed, 27 Sep 2023
 16:39:10 +0000
Message-ID: <1a84d6bd-0215-4a57-9d04-c101ad429c5d@amd.com>
Date: Wed, 27 Sep 2023 12:39:06 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] drm/amdkfd: drop struct kfd_cu_info
Content-Language: en-US
To: Arnd Bergmann <arnd@kernel.org>, Alex Deucher <Alexander.Deucher@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
References: <20230926163938.1013775-1-alexander.deucher@amd.com>
 <20230926163938.1013775-2-alexander.deucher@amd.com>
 <df3b7de0-972d-4df4-a52e-828015f062f6@app.fastmail.com>
 <BL1PR12MB514412C97B429FEF7218EFD2F7C3A@BL1PR12MB5144.namprd12.prod.outlook.com>
 <bee15872-1ed6-44b8-815e-c9480e931c98@app.fastmail.com>
From: Felix Kuehling <felix.kuehling@amd.com>
In-Reply-To: <bee15872-1ed6-44b8-815e-c9480e931c98@app.fastmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: YQBPR0101CA0224.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:66::23) To BN9PR12MB5115.namprd12.prod.outlook.com
 (2603:10b6:408:118::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN9PR12MB5115:EE_|IA0PR12MB7602:EE_
X-MS-Office365-Filtering-Correlation-Id: f00164f0-78da-453f-3fde-08dbbf78465a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: YF2Bx4jbgps31NRYvc2LcxW/pm57Iswh9t9hS1sx2AiEUExIJEiDVpJrjCgiBYaGlMKCRAWcVLs2rqvPKPThVhgsudsgZnnt0kRcyu+J3kLHfNCXuvRABi5oqZk3T+Yyzx1KnQnEMJtxpz4Vn63AIGHN6yaT9B3zGDs1mZZVQF7Hfeygw5wjbulYkRfce89DszNrSqiR2qL9XanhQVIB0sPvnu9xb/nvo1f292/pOu2TnwAkExPTznveA5Ymlc6Z6TvMCsakeruvOFlypReuHohw1dXgSQKaumIzOy57jocdK/haG3nUqp2UK+yHs+VIIKgp6mpDPxPIwLzKmaMjT2ksfbY0V6wDA9BPeozzVypcY9WCLXFxNTxIAtBaJ8veVZojXhl2j+i0RbbvYm7hf6w2FR9athmon9qeKmqIBzlWv++f9u6jmQDI6795GP2PjPCpUxNe+4zmWjDQGTziViIdZcpIJk45uRIFI8lHaKdnfNeMfVN9Ww8byK1LQKpo1aeyDUq4xGlxoK33ruhkbGYYWTxnqWxd6uTUXWWa2cLHu0KB0lmP9ubUP2/PbRea2U/39aA/92e0pNOHoy6FTRcQUVOsI8VhlX9q01bHbJNmjGjJxq8bWdDeykU7K0zxaLkEFlJ2hfNcTDRAJB18GA==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5115.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(39860400002)(376002)(366004)(396003)(136003)(346002)(230922051799003)(1800799009)(451199024)(186009)(31686004)(53546011)(478600001)(6506007)(6666004)(36756003)(6486002)(83380400001)(38100700002)(86362001)(2616005)(31696002)(2906002)(26005)(6512007)(8936002)(8676002)(110136005)(66946007)(66476007)(44832011)(66556008)(5660300002)(41300700001)(316002)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?QzBKL1B5czEzaVJBRlZFRlk3dGo3US9WQkdoeEhCdElXeHhRRUFiNHM2ckxX?=
 =?utf-8?B?NWpORnBHOTdSck4zTHBUdWR4bmhORTJESW12Z1NrYng5enNHOGttcGlQK0Ft?=
 =?utf-8?B?bE8zaXBrVlJxY3N2WmpUOU9lTytERWVXeWE3WVFOajJhZ2VUNGdDWVpNVTJ5?=
 =?utf-8?B?eWxSeXBYOFA0RnZTTStOR2N1YldYN1B3WGhRdGJxUElWWnUrbHpURmNuQ05r?=
 =?utf-8?B?dnZmRWljYUpCRHZDOE9odkl0b1BHU296MDY2N1VnR2ZDb1QrU1RVck1lUzZ1?=
 =?utf-8?B?bDRYQ0wwYlRRNTZmUEIzdm9OSGMxNHVaMVdGRW9Uejh4QTZYWVcwa2NSNkt6?=
 =?utf-8?B?aVVjc1BzbC90UmgwS3lMK3NwMURBbGt6SlRmM0tYUm1WTEgrOEJQaW9oT1la?=
 =?utf-8?B?ZnJldUxhYUdCVUtFL0dPcDQ1dm12emttcm11K0lQSVNNK1ZIRHpldlVCYUZy?=
 =?utf-8?B?dkszOU1HUU55c2hodWJUbm1leVVHYWJLbEV3RHNqclVRZlJ4U1dRT0NxVnNp?=
 =?utf-8?B?cVhRcHYwcFQ3YkFUQ3N4Mjh2c1loN1RvZ0x5TlRsMWRMVjBPOXpwSHVjeWtC?=
 =?utf-8?B?eUtVSVdwbnVKVmREVEZJZFhYalRGcDB3KzVabWthMTRhb1NDcWU0dUFiaXVl?=
 =?utf-8?B?SFRBMk9hVzZkS1owbHZHeXJpb3R3R2tSdUVxbHZQUjU3bytOK053SlZMc2M4?=
 =?utf-8?B?SE5lUjNJeGtTbUw5aTRZWStVUzh0V1ptMmtMMzdlWkFRbnlUNGlraVNrZzhx?=
 =?utf-8?B?NytjZUh6NXg5Q0p6NVE5QTJvQ0xOanlVUVdtS3JZMFJObW42ZHBhQURHeXRl?=
 =?utf-8?B?MUtBSVI2OTRzdUd3UEdxVFhxeVFUaDhtanYzNnRGZ0ZYSDhVSFRDaTcwSXNC?=
 =?utf-8?B?dVZEenZKTmQ0MHdGdFU1NlMwNDIzREd5VS9sV0RKN3RhK0Mrbm1ML2FLK2VS?=
 =?utf-8?B?eGtKWStrc0VndUxSMEcxd1V0VnpGSEZDM2ZIbVhpNk1jSU5kaHplZnBtN2p2?=
 =?utf-8?B?cklPb3EycTh4REJwc2QrcUxiVGtINUE0VmM3eHhaNmptdmZsRjNrRkUyRVhk?=
 =?utf-8?B?TUxQZHZoeEE2STZYYmFEeVJSb2VOOHBjeGozWmJKOUYyWDlFWndJWURMMTJw?=
 =?utf-8?B?Yy9GekNvNUg5NUNON3ptdW91Sy9NbDczY2EzeExRNjVEbFlGRWFBRmQwL2xC?=
 =?utf-8?B?Vi9qQlRkUW4wenYvWHRkd1BjYU5zT0NGY1M5UlBIZVRNY1IzbkhlN053SmJm?=
 =?utf-8?B?ZEN0SjNqWjNWUjR4UTN3OEl4RE5GVkNab2ovb0R4aExkNG5KZkoreHhuM2hI?=
 =?utf-8?B?VVRMRVl4dDVobWVHeEhDcU1kVllmRjkvTHh5OE9yeUxNY0ZHS1E4M1BjeVRY?=
 =?utf-8?B?V0VIY3dtYVpWWE5XU09WbmE1M016KzczNW11ZG82ajN2bVpMSnowV3JRVjkz?=
 =?utf-8?B?amFONXE4NUlZMkk0cW5KNTRhbWE1UHVhVGtyME00RDErRE5JRGNVQUxvRGlR?=
 =?utf-8?B?ZkhVYXVSSEFXZ3FHazdETk1DQTQweGlQc1ZjdmNNZFNINGRFUVdIVlhPc1hP?=
 =?utf-8?B?Sk42dDlCMjRDMi9sRWJmdDl2bVZONnVEdWlHK25VNVhCUXVsN29NejNWNThz?=
 =?utf-8?B?cEVqY2VrSHY1Q25HN3A4K1V5UXhQMDhpZWVhTFNWcVJ5R25tTzZ6dVBTWGs4?=
 =?utf-8?B?cjFEQkNvbC9MSTRQeDhXM0VxK2RIai9hSWRlN21Mb1BMYUZRN0t2OS9mRTdp?=
 =?utf-8?B?QmQxcUNBWHNDaWc0NmEvK24yOXVIQXp3cXpnUHlYaWdvWmFxVXVPYVVPNEFl?=
 =?utf-8?B?UElPSk1mZVRYSGRFZHNFZTUrS1hpNkROTDBXU282dlNvR0VBZkl4STFHTmsv?=
 =?utf-8?B?Qis0bzM4WU0xN0JweG8zOTF3R3luQVVDdTRjSWdITnJ4NmV5QUJhL0pwRXFW?=
 =?utf-8?B?WTFKdUdpRmQvZExJZjhscG81aFNXZ2lTZWMrcTFTVVBORFBTOFlHN3BzT1RQ?=
 =?utf-8?B?TGppYmxGeTRxMHJKV0hCQTMrZ2VFbzJQOUI5TjQzRmYvbHIwaXJXM3o0c0px?=
 =?utf-8?B?OEViOXF6RnZ6eVlrUWwySloxTkxYQUFGVGtHc0drYUgybTdOc1JtOSs2WU5x?=
 =?utf-8?Q?KwZDtM6Nfb9t+8ii6/azafkY9?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f00164f0-78da-453f-3fde-08dbbf78465a
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5115.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Sep 2023 16:39:10.1953 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0Hq8TKgvpn0NBV4RNrua/wnFKMQyaXon35ZFNx1XOqPLezzJjad566Qdw2zYucoUWi9/LhfUMSozTNKKgohp8g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB7602
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

On 2023-09-26 15:29, Arnd Bergmann wrote:
> On Tue, Sep 26, 2023, at 20:47, Deucher, Alexander wrote:
>>> From: Arnd Bergmann <arnd@kernel.org>
>>> Subject: Re: [PATCH 2/2] drm/amdkfd: drop struct kfd_cu_info
>>>
>>> On Tue, Sep 26, 2023, at 18:39, Alex Deucher wrote:
>>>> I think this was an abstraction back from when kfd supported both
>>>> radeon and amdgpu.  Since we just support amdgpu now, there is no more
>>>> need for this and we can use the amdgpu structures directly.
>>>>
>>>> This also avoids having the kfd_cu_info structures on the stack when
>>>> inlining which can blow up the stack.
>>>>
>>>> Cc: Arnd Bergmann <arnd@kernel.org>
>>>> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
>>> Nice cleanup!
>>>
>>> Acked-by: Arnd Bergmann <arnd@arndb.de>
>>>
>>> I guess you could fold patch 1/2 into this as it removes all the added code from
>>> that anyway.
>> I left it as a separate patch as I didn't get a chance to see when the
>> stack warning appeared and figured it might be a good way to mitigate
>> that on stable kernels if necessary without pulling in the whole
>> rework, but if not, I can just squash it into the second patch.
> Makes sense. FWIW, I had never seen the warning before updating
> to linux-next this week from an older snapshot from last month.
>
> My guess is that one of the recent changes made gcc take
> different inlining decisions so we end up with two copies
> of the cu_info in the same stack frame, even though the
> fundamental problem was there already.

I've seen this type of problem before because our data structures keep 
growing. When we need to support more GPUs, or bigger GPUs with more 
CUs, the arrays in those structures grow, and start blowing up the stack 
in functions that didn't have a problem before.

Regards,
   Felix


>
>      Arnd
