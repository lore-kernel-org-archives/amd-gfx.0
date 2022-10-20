Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CE25AC4332F
	for <amd-gfx@archiver.kernel.org>; Thu, 20 Oct 2022 07:03:20 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 14B6D10E189;
	Thu, 20 Oct 2022 07:03:20 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2061.outbound.protection.outlook.com [40.107.237.61])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 732D310E189
 for <amd-gfx@lists.freedesktop.org>; Thu, 20 Oct 2022 07:03:16 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ltSgupMvmQU1m4hxCV7rv0icaqnI1870yjUQqqLCFgDhGCgatuowzTgefNUPOM8Nj4ZCSXyYvf2IyzWYU8c8y9Q+6Li1ngG1J3dkArmmKuQnCKxUZdJcqcwbOYQsC5g4DASOAhgOTianmt7PiqUoDJAJbSUqf2K1p76rUjZEDV4wK95KGytS0PjTiwO8LlyoJga5yUjh3nj54BuJs7m8SbpXHqIM43oYamHLqA8C80Fi1dRH3cymlSDuTQLfyPDVA7H7PUcgP0r+9Z+PFyuk8gtzLYKh8lQkBEJlTIJFjA7t5hsWAaJnWtqlzx89cmSYPhWkWnCduzvm/X4B7tdPVg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WiQ+y8KicdhK6tlYIIYsDKp/mly8NUdHr4EcmG5ZNwE=;
 b=BHzgmL0cHyfhlHspYxT0za6QirYo08aPNSh3t8Kt70/HUGTMwuMHK9QC/z18B0NHV92DRC+vwJ9xoJfI3k+A0A7Rt3GCnkS3NquycloPq6yJTVNsevUAKkNZImDoVzAdj8OH9bLvAkRO0ePk2pCM75nRIkgaJtEzZV/EDiBrHVy1rOzmJrf1LSmKPWptc2H8QT81sSff9U/NuRkmzNpx43huQZfRjDIdorsCnKcB5Cjgrv0e/Z3WehFx7T2RYp65GX+739GAcmTt4nfzLkNsiuA6PaVV4QM0B4qQeBw6VogW0RRbmeLA4YjhGabErLhLyAbIBEoRuMyLFTzZeLYutA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WiQ+y8KicdhK6tlYIIYsDKp/mly8NUdHr4EcmG5ZNwE=;
 b=L1otmPBAcrGXWgXAiUsBgVtymHjM76wYerr7W1zali0jRVlt4q05vkXGtVcJwq8qlozlelZgxZi132pu1kMkA4p5OmtzsOAOz+ncI5BUWSTrl9hlaSwZX/G7by8RIZcl3/buLI7KGOzuPgC4aRzZ4i38hjg7R8Z/krdMDMH5yE0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB3370.namprd12.prod.outlook.com (2603:10b6:5:38::25) by
 BY5PR12MB4870.namprd12.prod.outlook.com (2603:10b6:a03:1de::9) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5723.32; Thu, 20 Oct 2022 07:03:13 +0000
Received: from DM6PR12MB3370.namprd12.prod.outlook.com
 ([fe80::d309:77d2:93d8:2425]) by DM6PR12MB3370.namprd12.prod.outlook.com
 ([fe80::d309:77d2:93d8:2425%7]) with mapi id 15.20.5723.035; Thu, 20 Oct 2022
 07:03:13 +0000
Message-ID: <e9729251-329b-cf85-6bdf-8495f925662a@amd.com>
Date: Thu, 20 Oct 2022 03:03:10 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.3
Subject: Re: [PATCH] drm/amdgpu: skip mes self test for gc 11.0.3 in recover
Content-Language: en-CA
To: "Wang, YuBiao" <YuBiao.Wang@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>,
 "Zhang, Hawking" <Hawking.Zhang@amd.com>
References: <20221019034519.1558366-1-YuBiao.Wang@amd.com>
 <555e8453-d609-a78e-36a8-dd52b63332ac@amd.com>
 <DM6PR12MB30351752EF3AEFBF898B868AE52A9@DM6PR12MB3035.namprd12.prod.outlook.com>
From: Luben Tuikov <luben.tuikov@amd.com>
In-Reply-To: <DM6PR12MB30351752EF3AEFBF898B868AE52A9@DM6PR12MB3035.namprd12.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YT2PR01CA0024.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:38::29) To DM6PR12MB3370.namprd12.prod.outlook.com
 (2603:10b6:5:38::25)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB3370:EE_|BY5PR12MB4870:EE_
X-MS-Office365-Filtering-Correlation-Id: f6f231d4-35e1-44a4-246e-08dab26927aa
X-LD-Processed: 3dd8961f-e488-4e60-8e11-a82d994e183d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: U4LkPTilFsHQ0LbxAn6caT3tvoZTrqvFSdw777+xF302yjZ21X9Sl42kMo7s17k+9uVkm2HrCNUCcaAqDjDet/ViN6k959gpwZtweUT4mmq3LrSLo0jYD6CbQByLJIRbjZw5WmX58iR4jP6nDw3XGunOVZu6sFH73t62CJvIloTto4BzWvjQciKXAVhhhDFFL/TEPPG6S3PH4LO78jfhrSCVI/VG/mSHLav/VV+vDoKw4DDoZggYl8GTD1BySOIEaB0Mi+DpuruPBo25PxyTxMFIOBAqwL8VsF3a8sqyUkqrV6L45JHsRgoEOvFKVWH3cOruPcIgdA/rX/eO78dXxdKNcw100g73QYLyU8lSHjCsuOaS/5w+p+jalXrZwyy+81vFW8jmfBbxD1gTBXEWg+51lquxm6yq8mgwuce1tLdcwcO0t5N1Ur/G71kPzoyDK1iGJGqpunlYTndsvjQH7etc4jH32dabGgA+/UG8EvIKKY7XxZJxaD7iC0gtRV4HJPtNX9Arrzjll8eXoD58zS3d6Tkaw+oNhnByn+qHH+a+3edQmBvtHQT0JXZ2mlHOADkKWECj/RenzStphQufn4Dl13sY0P7WORQ3VSWND+63XUYEBC2Dc9d4byZXNSUjm635W74KzR9530Jy05wFhw5a/IrrSuIayFoIeR02ZvNxH/lmdCqic+hmQsQocugq/jECBG9FFEmMVNxn7gEX89vFNJijDYeVGvi/8oQZN1acDeqHfa5imUytZ0r3E16Wk4uuyKRFDnf4cg6sGbZxee0LCWmOy5beF+C4/vrV5rM=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB3370.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230022)(4636009)(376002)(346002)(136003)(39860400002)(396003)(366004)(451199015)(38100700002)(6486002)(31686004)(478600001)(316002)(2616005)(186003)(6506007)(66556008)(66946007)(66476007)(4326008)(6636002)(110136005)(8676002)(54906003)(53546011)(36756003)(26005)(41300700001)(6512007)(8936002)(4001150100001)(44832011)(2906002)(5660300002)(86362001)(83380400001)(31696002)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NWtXdHhVOHphSWViY2t4K1IxdTAwVUxldEM4TU5uTkZHQXJFL2hueEZtQWVw?=
 =?utf-8?B?NU1oSTArQ3Z5UEowMzhKTWl6MjZ0a3FTZ3NxUXRyRE5vVE9WcU1kS0hkclpL?=
 =?utf-8?B?VDQyZlVCZ3NJSklkY0ovRnB3U3h2Zm5VbFNaUjR5U0U5RW01eXpyY0N5Mnhj?=
 =?utf-8?B?U0RxNE9vTmtxUUFvaXVHbzFJNit3M1YvTWVhWlF4QkdtbnI0UnhFRXBZTEd6?=
 =?utf-8?B?OHc3Ri9LZHNSby9tSHNad3M0M0hRRU4wdlZMVFc1R3VvZnZqVFBHdVBHMGFa?=
 =?utf-8?B?T2o1eEFNQUZkSnF3WndaWUJrL0ZrNWMvd1FrK0hKOUlBdXhqaTZxTXl2cTZB?=
 =?utf-8?B?Q2dwNFE2R3lwSk1zU3M5UGUrNXg1cW5XcHp0Q21qdnNTUVh2VllibVFDSXBR?=
 =?utf-8?B?dEhMZEloVVlEbkU1TVRQTTNDZE1KS09EMzNtQnpHVHJjWnVzcFkxV1M5NU91?=
 =?utf-8?B?enBlYklGYy9SaHhPSGx1VGpUWko5Qnd3WGxzdStEaHB2Ukx6VERKNExJSDVZ?=
 =?utf-8?B?aWZOYlR5LzAveElvOXFMQ0xqd2FVYStMaWp0MDBLOUhKM0VsQzFKemhWQWF4?=
 =?utf-8?B?bzlxWGMyZE9HbVphTVpWUDllRlI1RVdsZTY1RVZiYzdOUHAvQ3pFaThpbEpn?=
 =?utf-8?B?MHgvSFR4N2hPbjc0MlI4ZXNESDhkZ2FFMVBsNUFidzg2dHdKQTVzWDd1aWUv?=
 =?utf-8?B?SEl2NUpDaU1WbFNwMXZOb2NlNkNDMGVsM3RlZURaa2NuVS9GZTJxa1ZjckxL?=
 =?utf-8?B?cVQyVlZOY0tZa1BmLzBaSFNGdmUxeVhhQTFaaE5pVEpqNWZDZDIxcVQycGdJ?=
 =?utf-8?B?dFNjNFZpYkRSRm1UY1F6ZlZMZm5mczRhL3dLMkVYanVHV01wT09sMDNBelQy?=
 =?utf-8?B?ZTNtSUIrTlQzdTF5MUNwVVdpaG96VTI2d2IwWFl1cHA2Z2JiNFArc3NiZG15?=
 =?utf-8?B?YVQxZ0NmMWtCcm1KVXcwbEdPU1BsR0ROVjRuVWJtcGlqSTNBT2M0ZjB1SENP?=
 =?utf-8?B?OExmNzA1MnlXMkx6MkU3R0JYeGNObFV5Q1h6MFoxNHFIbFpkOVh4ZzdVS2px?=
 =?utf-8?B?c1BRQkJaSzJlUEV6MFBxVHFsQkJsQTlwbjhKNVFtY2xEejNRMHR4UlpqUWlu?=
 =?utf-8?B?cUZhQjRPZDlkYWQ2U1ZrSXFoYmM4NnFLNFp6aS9kdkw5Wlo0QzBha0E4OE1N?=
 =?utf-8?B?Z3VSZWU4OGdpWjJEU0RiVy9CanNDdXJnMENQMXQwQUlhd0RSdGQyWmttTy9u?=
 =?utf-8?B?WEhOUkJ6R29CSjRJZGM5aFlNSjZFWGo5OTBuVkdEM1hGMjRvakRxZmIwNE5w?=
 =?utf-8?B?RlJBb2VOdncyb1NwK2cwL09DdW5TUE94RlloenovVWg0RVMxLzlwbk0rdllN?=
 =?utf-8?B?ek85aVZDU2ZBUmpHTTZabHVSYmwyaS9KaUttbmREN3IvWXhhRGRZeGxPZnRX?=
 =?utf-8?B?MDBPTEFIQ2RPZElSejloNmduQUNaVkFkTXc0VFJqVktUcTF4OC9wenU5L2xE?=
 =?utf-8?B?RlJVWWF0UEZCMjhWd2hoVnlPTS84ZTJMK3g1VUczMnZzejJ6V2VOS2FiYnhN?=
 =?utf-8?B?em9BMFlBZTZKbDZIU3dLT3huSzltYWJMVUN6U0d4ZWpiWVlHWUEwUG9xMkVV?=
 =?utf-8?B?UERwZkdwbTB0OVBYcVdwNEc5aGdJWXY1dFdRR2dIQXkrNGZFU3JRU0VZKzE5?=
 =?utf-8?B?bm5oS2l4MjQwOE0vcjh4TmZDVmI2YlR2VGl6TUJVVHJPaGszMllSeHhZdkNv?=
 =?utf-8?B?eDZmdDY0R1NqWlY1a3BjWENRa3RSWFlwT28xdzhpTU5jNkRZbXIwRTdyaStU?=
 =?utf-8?B?d3ZOb0NhQzB4cXlJWE9CVzdNb2MvR2tYcnNOOVYwMVcwcWNud0lIZnh4L3JV?=
 =?utf-8?B?bVZoblp6T2hrRS9ENjFWd0tsVndaaS9jRW1NWEhYcDVEY0FoTUhLK21XQ2JD?=
 =?utf-8?B?S2d4TGQxOVhmNmUvQlc1WWUvUm43SWxXYXdxV2FsSzF1ZkRTVWU0U3FEMm9M?=
 =?utf-8?B?TXR6dFBCNStSQ3QzVk9MUUh1U2I0cjNrTDU4T3BtQkFSek0yRTFTcGoxdWNv?=
 =?utf-8?B?ZU1SYTBidGpOZXk1eFhKVlRuMjRoNldCcTRTc2t3REhOUjRYWlk4dk00dzdK?=
 =?utf-8?Q?i3ZOliMpnRVxSVuoW3FKz3h8e?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f6f231d4-35e1-44a4-246e-08dab26927aa
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3370.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Oct 2022 07:03:13.4680 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HO1ys2adLtPvKC/DEZCJQpV83gNcQcYGXN6UnZM2rhwPbYfLRjXx8lXWArNZaMAq
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4870
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
Cc: "Grodzovsky, Andrey" <Andrey.Grodzovsky@amd.com>, "Xiao,
 Jack" <Jack.Xiao@amd.com>, "Wang, Yang\(Kevin\)" <KevinYang.Wang@amd.com>, "Xu,
 Feifei" <Feifei.Xu@amd.com>, "Chen, Horace" <Horace.Chen@amd.com>, "Deucher,
 Alexander" <Alexander.Deucher@amd.com>, "Quan, Evan" <Evan.Quan@amd.com>,
 "Koenig, Christian" <Christian.Koenig@amd.com>, "Liu, Monk" <Monk.Liu@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Hi YuBiao,

Ah, okay, there's a precedent for such a change then.

Acked-by: Luben Tuikov <luben.tuikov@amd.com>

Regards,
Luben

On 2022-10-19 22:44, Wang, YuBiao wrote:
> Hi Luben,
> 
>>> Is this "temporary" as in "we'll revert this commit later", or is it "temporary" as in the code execution itself?
>>> Is this just for this version of the IP or this and any newer versions?
> 
> I suppose that it is meant to be reverted later. There is a similar patch in commit c25a7a8bf19a98578ad27aaaa78082276ea1557c which also temporarily skip mes self test only for gc_11.0.3 during mes late init, which was reviewed by @Zhang, Hawking. My patch is to also skip mes self test during gpu recover since self test will also cause failure during reset.
> 
> Best Regards,
> Yubiao Wang
> 
> -----Original Message-----
> From: Tuikov, Luben <Luben.Tuikov@amd.com> 
> Sent: Wednesday, October 19, 2022 11:53 AM
> To: Wang, YuBiao <YuBiao.Wang@amd.com>; amd-gfx@lists.freedesktop.org
> Cc: Grodzovsky, Andrey <Andrey.Grodzovsky@amd.com>; Quan, Evan <Evan.Quan@amd.com>; Chen, Horace <Horace.Chen@amd.com>; Koenig, Christian <Christian.Koenig@amd.com>; Deucher, Alexander <Alexander.Deucher@amd.com>; Xiao, Jack <Jack.Xiao@amd.com>; Zhang, Hawking <Hawking.Zhang@amd.com>; Liu, Monk <Monk.Liu@amd.com>; Xu, Feifei <Feifei.Xu@amd.com>; Wang, Yang(Kevin) <KevinYang.Wang@amd.com>
> Subject: Re: [PATCH] drm/amdgpu: skip mes self test for gc 11.0.3 in recover
> 
> On 2022-10-18 23:45, YuBiao Wang wrote:
>> Temporary disable mes self teset for gc 11.0.3 during gpu_recovery.
>>
> 
> Is this "temporary" as in "we'll revert this commit later", or is it "temporary" as in the code execution itself?
> 
>> Signed-off-by: YuBiao Wang <YuBiao.Wang@amd.com>
>> ---
>>  drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c 
>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>> index e0445e8cc342..5b8362727226 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>> @@ -5381,7 +5381,7 @@ int amdgpu_device_gpu_recover(struct amdgpu_device *adev,
>>  			drm_sched_start(&ring->sched, !tmp_adev->asic_reset_res);
>>  		}
>>  
>> -		if (adev->enable_mes)
>> +		if (adev->enable_mes && adev->ip_versions[GC_HWIP][0] != 
>> +IP_VERSION(11, 0, 3))
>>  			amdgpu_mes_self_test(tmp_adev);
> 
> Is this just for this version of the IP or this and any newer versions?
> 
> Regards,
> Luben
> 
>>  
>>  		if (!drm_drv_uses_atomic_modeset(adev_to_drm(tmp_adev)) && 
>> !job_signaled) {
