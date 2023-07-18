Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 90A44EB64DD
	for <amd-gfx@archiver.kernel.org>; Tue, 18 Jul 2023 14:19:24 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 14C5010E34C;
	Tue, 18 Jul 2023 14:19:24 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2052.outbound.protection.outlook.com [40.107.223.52])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 63F1710E0E4
 for <amd-gfx@lists.freedesktop.org>; Tue, 18 Jul 2023 14:19:22 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JbrGVuftHf/vNzl4JccYHKVmBT2HA81NYPFaeRAaoOjda2xgBPCo31ryIFf/q7HZeQzvAbuCq9JtT/LX0K0KcR3ahsbiYBP4vkd5wTH+kkQLgvRFM0+/OVOF2JA1bXYLsFqnAp+2DZS3pqM1+x8qtROiTtz9Ud5sAg1OSks90w8wNFkcmdWSfTfkIDDuGhg+pPrY2NtxGgKEoG4HVZnb+n9lTs2nzo2ThJLz58UQqNAZKp1fA7Y5rNm7MbSthG+9ENmLLunO/D0ZTFtSur5W07NDD1WjiNW/oh/dT9SGUgdN1BufbcBZL16C/o2FDZQGAgtcMqMoz4nXLWQKOIXJXA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=W6yVE/a4jVdGlYkcYHwvxkmPWTjzan39STrUgiVQkTY=;
 b=J8AHy9z/lUpuPFD91mVHfuwybkY9D5CUS9WEpVfTcrtme++u8JjN0H28Yjc/D1BoUJ2kdQ6KipFay+NjbMEjnqymYKJGLZW/hqw0vXvaoD5yCxJUiPRQ3NaHcG+uM1jMIWUyCHRdtw0lUmfXNfp0+3yVIr4D4Uc+LLnW3awe7SSicJQfHKbg/tL2w/YrJuKnSGeGFa0HmrSUNAM8N9wx1GVx9aJ/cEuDgC+neEbXrAh0q4yC/1MEqx/lL4Mhsal6qqXIA9QbM/BWM13AclXF7sZsJoQFBnqB701Hqsq73uJa0NMFo8oDuk/u/GmVuTjoXlwplsg7Beq5VSMky0Cq1Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=W6yVE/a4jVdGlYkcYHwvxkmPWTjzan39STrUgiVQkTY=;
 b=BSXvWIflXo1e2kMVENIn/IiZqbyCNy6KehMecl6SivLYvS1p1tDODtWspIQj8YhH4OKi76ppIi9j8dAkjWBeIGg5ROsDsSRV18ZgrQcAddGPBAg2zRgk4Y57PzRt+QjHg+ukR5otuQRwDyc8HWGtr6fBhYUEV6JQ3N/epHGemhg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BYAPR12MB4614.namprd12.prod.outlook.com (2603:10b6:a03:a6::22)
 by LV2PR12MB5917.namprd12.prod.outlook.com (2603:10b6:408:175::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6565.30; Tue, 18 Jul
 2023 14:19:19 +0000
Received: from BYAPR12MB4614.namprd12.prod.outlook.com
 ([fe80::e30e:689d:405b:b3c2]) by BYAPR12MB4614.namprd12.prod.outlook.com
 ([fe80::e30e:689d:405b:b3c2%4]) with mapi id 15.20.6588.031; Tue, 18 Jul 2023
 14:19:18 +0000
Message-ID: <c4ea8242-ff13-f395-2eb4-b15633253dcd@amd.com>
Date: Tue, 18 Jul 2023 19:49:07 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.1
Subject: Re: [PATCH] drm/amdgpu: Update ring scheduler info as needed
Content-Language: en-US
To: James Zhu <jamesz@amd.com>, amd-gfx@lists.freedesktop.org
References: <20230718122120.2938177-1-lijo.lazar@amd.com>
 <843196d3-fc53-77f3-26c5-8df479539f7e@amd.com>
From: "Lazar, Lijo" <lijo.lazar@amd.com>
In-Reply-To: <843196d3-fc53-77f3-26c5-8df479539f7e@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PN2PR01CA0006.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:25::11) To BYAPR12MB4614.namprd12.prod.outlook.com
 (2603:10b6:a03:a6::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR12MB4614:EE_|LV2PR12MB5917:EE_
X-MS-Office365-Filtering-Correlation-Id: 269759ec-2522-4625-390e-08db8799f916
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 4XWS2SBvoprukNQ/QxEMJbMNErDuFip4LfcyYqKn0xIvwykA7YhRhh5wyT8tZitUuhXte1qh90NZt1KFYm1tZvUC+BUdOddV7xIzlUrJvkfjuFIodQ2xcmwzLvhAbcpFWkDVDddRMFSu97m+jNbL95j2OqINLz79fvcdJ+Rp9G8VQDrfA9Ff5GG9QhaOs6JplXFS4uipc99fhqnrCwV1cUWjuWszmckJ45DiUuDxrpPSuv1ur172OgotBqko0Eli4Ezh2TpC0bwNwSv4bcC3mHQNn0A+4VxIiN+KGZoiPrsozX+2Ydc3Am6E7M470bN2R9P8Jnsqvm3MKY9L0neX0mq/G58zLFxb6JWBVAm9ZBxZOaGV53DjRVR+QK08L2ndpLug7/ospXTyNskhqaEyQZQQgTEf09ofUitnMt3hYCT//C1tnkeV51/t4H2SRGHFcF+wjeRRo1iyQ0DZLyc02KD0+cjtRcIZ9xTwp7UJYKEP6XGLYbXpj5SOhxgz2agRquMShkgG/vH0neW49p1/PmQLWgsEzo4djjeaSHiNQjgdXNxAUfHe79sYXmoPKu/0CjOcqjkDoFgrnMGihRcGxn2F+BuTnm0RcnLu1q9xnAPWwQI7ToPD3IN2/e9tay4/3OqwU9m4GZMu9fr6DJAaAw==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR12MB4614.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(4636009)(346002)(376002)(39860400002)(136003)(366004)(396003)(451199021)(31686004)(478600001)(6486002)(6666004)(83380400001)(31696002)(86362001)(2616005)(15650500001)(53546011)(6506007)(186003)(6512007)(2906002)(38100700002)(66556008)(26005)(66946007)(66476007)(41300700001)(36756003)(8936002)(4326008)(8676002)(316002)(5660300002)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?T0JLMkpMd0huQlJVU04zMzN4b3ZSc2k4TUFRVk1MWSsyL2s4R2lVdkVlOUU5?=
 =?utf-8?B?Z2cxZ2tobHhlb0J6UWQwNkdIemc4ditRdW9UY09WWXBCdW95MENIS1prNHdM?=
 =?utf-8?B?dHR0bDBMRW51bDhFSkxVWERlK092Rk40VzliZ2c2dGhyMmpEWjM2T1BHQmln?=
 =?utf-8?B?WEhSWktSRlVDR1YvVU0yaUl4Z0dmSTVxWjNOemF3anYzaisxbU1sbFBSdHNK?=
 =?utf-8?B?cW5iT3B6STE3WUJGbmZBVWhXRmRFbDVreVg3M1gyQ2I3Q0JqU3FoWHMzUEVS?=
 =?utf-8?B?WEROWXNKaDQvR25NblBmRzVIOEpyTmlJUGF3aWJaUjVWaTVSczJzRnc2TVpn?=
 =?utf-8?B?dHBSaGxIK3ByK3V2V2xSWE1NeEpOcGVPRHdQQldqeUFZUExTRWp1dFhvRXRz?=
 =?utf-8?B?QkkzenVydkpWZVRtaXF3am5TeHNGaDBwZnJuWFpzbU9KNmhyTW9TOXZMakQ2?=
 =?utf-8?B?WVBpWEcwOTF5YWFQRlo5T2VsZTNRNnh5eWNTWEVPL3dQanBQRFlScE5aOG14?=
 =?utf-8?B?NGFpWnRDUEh4TDlhWGh0SXZETmdtM3ZENkI4dXQzNG9FWUZCZmxFYyt5SjFQ?=
 =?utf-8?B?ODBFMGkyUmg3bWlPRWlMNmkrWnVoWUlPM1NVU0Z4Q2c2emlYOGZweHAxUFRM?=
 =?utf-8?B?bDU3OWk4NXE3d1lsRDYvdno3ZXVHVkZXTEdnWU1PdEtWZXlZSVJLQzR1TmEy?=
 =?utf-8?B?YUw4UktUK2JNZDZ1djBVaC9TWW43VnlIY25UeUdDdS91UlVKdzRjankxeWlh?=
 =?utf-8?B?L1RrR2g1YzdSbWJoTHgzMXRQQStveVlmWG4xNjZNVS9ra3RiRjdkV21xV3c4?=
 =?utf-8?B?eEZxaG4rYzVMMDZiUXJ1OHA5RFI1T0gyTGRMcTNqUVFWcGdCaFQxazFCaTds?=
 =?utf-8?B?eUsyUlJ1emRHNVhtUjlRUFpoRjYwS3d2RXJuTzVJSFozWjJ1NFVwcG5uY0M5?=
 =?utf-8?B?SkdOdGR2djNaQWtmaEIyUUlzMlpjeS9rWDRURG8zaWkvTWdqTXFGR1lNR2U2?=
 =?utf-8?B?S3d1elFTMFg3N0lTK2pQQWRldDBXTGUxaFEzSnN0SXVSNHZHNVJYYjJScys4?=
 =?utf-8?B?d3dxZzR4R0hjamdkR0lHZWJ5Y1ZNZmhoQjhaL21RY1oxa1h2bldzNytBTEx0?=
 =?utf-8?B?cXZJTmxKTmJNR1ZQRThGOXI4UUt4aU9uZ1RIeXp5bGZ2WGhwVk5wNWYwUEFr?=
 =?utf-8?B?anVnSmdRZHJ2SE9Jb0ZYemI3bk1ZZ0xjaHkrZXhLMENXejNHait1cFFtZWQ1?=
 =?utf-8?B?WkZMRU4xTEtaZk9UNVdJaXNZMWgyVzVVVU9HNEtZR3lPWm4rOU9LMlRLT1hZ?=
 =?utf-8?B?USt4QUhLcVBNd2czK2ZwSFhUMWpIdUx1UUMwYUNHQ0cyTHlCM2c5Q1JydlhT?=
 =?utf-8?B?YTh4NnlrbUM5VTYrU056d3dhcXFkVm1yUHU5TGU5RW1XdUVNM2FTNWRSUHBx?=
 =?utf-8?B?ZkJ5T1draWlUYXNKd2xPb05meFl4MUk0a25pZjNwNzRJRXBlejNNMU9BaC90?=
 =?utf-8?B?Y0U0ekRQWmNkKy9FZU03WnNIUmtvSWRiOG1HMnRHWGNvaHJNOEoyUHdaQVc4?=
 =?utf-8?B?ZmczQnpPeEoyNVdZMUdGWlc5OVp1WE9MQlFqaDNJQ3h1VzdoOWdLemcxUUM1?=
 =?utf-8?B?UWtubEhsa3dqajBpd0Y3RHgvLzZsQXg5NWFWZDVRRjEwby90d01OUyt0a05Y?=
 =?utf-8?B?Zm1vTVlVZEs0MXJtMmdOQzRKRERDdERGZ0srakQ4dGJ4M1crQ1ViQzJHdmNF?=
 =?utf-8?B?ZWNlSmpmSk01bFZ6djRuZVFzcUpmUzhMTUJjQkFYT1haYTFZYnlKUE5PUVdG?=
 =?utf-8?B?YWFuYkVwNExWNTd4MExiVHo5MXRUdlBDcnhGWERMNWNHQVpmZ1Y0dEFiSHJ5?=
 =?utf-8?B?TW8vMXFhLzJWWWc4MTFpMk9BRTlKZ1gxSHJ0b09VK1k3T2lrTlg0NjZCdnlu?=
 =?utf-8?B?RWE3aHFFcTdveHl1d1dHb3A0dkFWV1g4WWozRGl2WXp5RTNoV0o5YjdCS3R4?=
 =?utf-8?B?NHp2L3pzUFZVWUJuTkoyYWJDWk5lRDRaYmVXUThBd2phM0lCYVNGVlFzYTVO?=
 =?utf-8?B?eUFGUjlTMCtod1lvb2h5bEZPS0laMHRnL242YStoMFdLYUJJQzdPV3ZxYllQ?=
 =?utf-8?Q?SMMENMcgjGtCtqG9rbjdRz77t?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 269759ec-2522-4625-390e-08db8799f916
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB4614.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jul 2023 14:19:18.5800 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: A2HKYmXVoA8RZfSLjvFi1rHVpmvKptsEqrATohgmoUE6Uov6hzLvipc3APlQmqnQ
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR12MB5917
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
Cc: Alexander.Deucher@amd.com, James.Zhu@amd.com, Asad.Kamal@amd.com,
 Hawking.Zhang@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>



On 7/18/2023 7:30 PM, James Zhu wrote:
> 
> On 2023-07-18 08:21, Lijo Lazar wrote:
>> Not all rings have scheduler associated. Only update scheduler data for
>> rings with scheduler. It could result in out of bound access as total
>> rings are more than those associated with particular IPs.
>>
>> Signed-off-by: Lijo Lazar <lijo.lazar@amd.com>
>> ---
>>   drivers/gpu/drm/amd/amdgpu/aqua_vanjaram.c | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/drivers/gpu/drm/amd/amdgpu/aqua_vanjaram.c 
>> b/drivers/gpu/drm/amd/amdgpu/aqua_vanjaram.c
>> index 72b629a78c62..d0fc62784e82 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/aqua_vanjaram.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/aqua_vanjaram.c
>> @@ -134,7 +134,7 @@ static int aqua_vanjaram_xcp_sched_list_update(
>>       for (i = 0; i < AMDGPU_MAX_RINGS; i++) {
>>           ring = adev->rings[i];
>> -        if (!ring || !ring->sched.ready)
>> +        if (!ring || !ring->sched.ready || ring->no_scheduler)
> [JZ] any case for ring->no_scheduler = true, but ring->sched.ready = true?

amdgpu_gfx_kiq_init_ring sets no_scheduler flag true for kiq rings. 
amdgpu_device_init_schedulers inits schedulers only for rings which 
doesn't have no_scheduler. However in gfx_v9_4_3_xcc_kiq_resume, the 
ring is marked with ring->sched.ready = true;

I'm not sure why it's done this way, but this is the case even for gfxv9.

Thanks,
Lijo

>>               continue;
>>           aqua_vanjaram_xcp_gpu_sched_update(adev, ring, ring->xcp_id);
