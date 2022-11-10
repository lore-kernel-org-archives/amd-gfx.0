Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 93E2EC4332F
	for <amd-gfx@archiver.kernel.org>; Thu, 10 Nov 2022 10:49:53 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E860C10E6C9;
	Thu, 10 Nov 2022 10:49:52 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2054.outbound.protection.outlook.com [40.107.243.54])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8EB8A10E6C9
 for <amd-gfx@lists.freedesktop.org>; Thu, 10 Nov 2022 10:49:50 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SZ1JoHXpJ8jEfoTl9Rh4rjseb8L5MsXcaQJJUG62WfwCPocn7fM+tpcoRgVk9svPD9Tb0shXyLcKZQNNrplsRqzF8S8Zic3koSnT5mrRig9cnKr4brlZ9doxi61iuqrRl0Iuw7DvN4Kd9md+In04rzO10VgjgNODTRG2b6/OsZXakiaFNWN11DVj6eTPpY5GJueP7kB7BNutGwdXOu4tDnM6xwBVcjUrE/nHheYb0z9FTGtgxlyWI+ZnGAbTPTvxKoWRrlFSXDxNyZS1xkbBrs1l17jORAqDnN0YVKs1bLEyF3bi/lSrPGpT0aplggM8dt6wLagXxw+eX64/23dR7w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=V0v3nDPh9g0j/1hB11lYYuZPTemXd9l14UrG/zx8gfg=;
 b=l1rlwX3RCChImoxm9Z/vTmpH+QkxjSGkwinpPbGdE1DQ8id+cFWgUyuQQNwhx8K975j3YBxfZZSsYAFX+Rk9AhLKZ8LN5XNzwZnJUyinWjMDsUOPMBi3jnJ/ibizG+94ehAGzwqRUrdLDMt/5vSCC+7htmrmHHUzuh/YZpYBe0tK/rv3CCafsC8Zvbs9zSrlgNc/R0yvD46aRi2/E0paXBw+jrsP0nY1jolYDKzaTBa6YvjUmo6MHmxYQARyxwoQUK7zjIBYBzlwTCjlSJjP7UgJEePEMwqj5KvC9a7Em8dyJxVKejdcdG1XevXFSPU4BXDBIEaVfE9gTayaa8qiFA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=V0v3nDPh9g0j/1hB11lYYuZPTemXd9l14UrG/zx8gfg=;
 b=yZoT4J5BEcOFgO6MqUwf3tvOieBXkVnhrx8zs+tPBTKlMQUUJDnxAp2d/+2lBYkhBo0jS6xC852r87F8qDSMVKW4k/ZQCwijvRm0XV+WqJii2a+UXLNpzymCizlcIn+BGFHP4PjCCOHrjQvaRXC16jcnQzsM992JWSCtkzJT4oU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN8PR12MB3587.namprd12.prod.outlook.com (2603:10b6:408:43::13)
 by SJ1PR12MB6100.namprd12.prod.outlook.com (2603:10b6:a03:45d::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5791.26; Thu, 10 Nov
 2022 10:49:47 +0000
Received: from BN8PR12MB3587.namprd12.prod.outlook.com
 ([fe80::7d43:3f30:4caf:7421]) by BN8PR12MB3587.namprd12.prod.outlook.com
 ([fe80::7d43:3f30:4caf:7421%7]) with mapi id 15.20.5791.026; Thu, 10 Nov 2022
 10:49:47 +0000
Message-ID: <35396c13-7b1d-cd22-e37b-435b49a329df@amd.com>
Date: Thu, 10 Nov 2022 11:49:38 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Subject: Re: [PATCH] drm/amdgpu: add vram reservation logic based on
 vram_usagebyfirmware_v2_2
Content-Language: en-US
To: "Liu01, Tong (Esther)" <Tong.Liu01@amd.com>,
 "Koenig, Christian" <Christian.Koenig@amd.com>,
 "Chang, HaiJun" <HaiJun.Chang@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>,
 "Zhang, Bokun" <Bokun.Zhang@amd.com>,
 "Deucher, Alexander" <Alexander.Deucher@amd.com>
References: <20221108103236.8777-1-Tong.Liu01@amd.com>
 <DM4PR12MB61343BF910630C9BA31F8916903F9@DM4PR12MB6134.namprd12.prod.outlook.com>
 <444456c6-b66b-615a-f340-a5867073a496@amd.com>
 <DM6PR12MB49587BC1D9F0C46AC8646073813F9@DM6PR12MB4958.namprd12.prod.outlook.com>
 <c8b8b0ad-96b6-9ce6-8391-26f0189c758f@amd.com>
 <DM4PR12MB61341AD581900D4861E8DA3190019@DM4PR12MB6134.namprd12.prod.outlook.com>
 <d7c99c50-c0a3-9c92-ec8c-2b3f5c8ec017@amd.com>
 <DM4PR12MB6134D1E356397E4F644EF0E290019@DM4PR12MB6134.namprd12.prod.outlook.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
In-Reply-To: <DM4PR12MB6134D1E356397E4F644EF0E290019@DM4PR12MB6134.namprd12.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: AM6P193CA0113.EURP193.PROD.OUTLOOK.COM
 (2603:10a6:209:85::18) To BN8PR12MB3587.namprd12.prod.outlook.com
 (2603:10b6:408:43::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8PR12MB3587:EE_|SJ1PR12MB6100:EE_
X-MS-Office365-Filtering-Correlation-Id: d4f197b3-b52b-4a20-1b69-08dac309489e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: NuswJE1nBuiyKUV/SCrhe9iEe3Z1m7/uiQ6SA5wlhuClWqvZrwDlUagBNiNZukroVdGH67C00mXnAdkc0HQqtJMmF0Y5qjrJWC8XJtHToXnLID+TQIlsXSqFt7ZfgRBAKRty7C7pna7aRC6lZZyyd449DSqNzvT5AS6tQYZvCJsmfNTtMOAa3HpXciJvoPWxSg7VZPGlqmAE2va9k+oSZnp5hZLjxOd+UYY2de2tETmWt39I8QqYQPv91L1Q3t5wkOojr7Xo5PNiAphYA792CjvyadVLYOy5reMqRqUGHMxyw+rOylMk4bB9542ot7141rRL7krJ9dh48by1lCtK4sOIhJJzCYmTIWaaIk1RKB9MQtnORXBx+epSGtii1+807+WeY0VA449JkQwspCMnnOXjBcIQypdcCZHPDtB6pG7gxHWt00LeCaNdG0K45B0rd6X9VXi8hms0eMp6MxyDlj+KNgV2A3mZA6p/kxx3tU1ngIv9ghpyzowEHjIKLqH1WZ7ix2dW7c1Kvx5IqnAjqrutZFcyn0/nuHnurNWqMZl6lqTeQLvdrx8tWs9pFHfdZVJUrA1aL73aZeqKahB6JQLScAFk1paB7cmiMJ+Qrc354iAwPrPJOE3jpqGjO2EzNve+Cg16IKNCWkhu0ynIbIGOJQHZc6ZF86CGId5fvULaSD0oNouO4+QGMgtEqVJTVD5eLocBgu7sPFr2zOMcD7fTz0PdIoEcw5MZo74Wfkz1Esta/M1xpqL03hG7l18CoUAo6eH/HZAXPF33qr+dItre+96lrJoOJ6LMF0TlyYNaDce0DeslM06wdVgv578r
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN8PR12MB3587.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230022)(4636009)(366004)(376002)(346002)(39860400002)(136003)(396003)(451199015)(38100700002)(316002)(31686004)(54906003)(6636002)(110136005)(36756003)(66946007)(4326008)(8676002)(66476007)(66556008)(921005)(83380400001)(478600001)(41300700001)(6486002)(6666004)(6512007)(186003)(8936002)(66574015)(5660300002)(26005)(2906002)(6506007)(30864003)(31696002)(2616005)(53546011)(86362001)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MjV0YXNxa0NVbTd6NWtvaXBOWkNVQ1dRZjl5RjkzeGdjZ2ZxeUkyR0JGUFJY?=
 =?utf-8?B?VzBkZTE1OVBXdG8zbzFiaUkwTGFlM1FEdmU5M09DeFhxblRCVXB5a2M0M2ZD?=
 =?utf-8?B?YkJRNkVCZVlaaWZUbHN3a3ViRWpOeTdyNVZicC9hVXJVNmtnNXBwNjdhdFJN?=
 =?utf-8?B?L1NlYWk0WEplbWZkSG1pL1ZxZ2JwcUhtT3k2Q2NOZWtMenFYUU1QQ3dJVUZY?=
 =?utf-8?B?TlZnM2w2Vk96cjBLaGxib2E0V2o5QzhxcDhOUDhEZCtuQi9UTGhzaElISVV0?=
 =?utf-8?B?T2xyelg1TlJhNk8yVGdCZkxlOWhtUU11b0FjMHpuNkZod01zaGF4bTY1SFRs?=
 =?utf-8?B?VVdnQW1KWmlyL1kwZVB4RkJKVnFRR3hmYldublkvQWJUdXJmZTFXMFNqL0ND?=
 =?utf-8?B?MkM2T0NCRGRsZG85NUtlK0h3ckM4SEdSL3RUVkFoRm5ObktISWRKcnFKeXlW?=
 =?utf-8?B?ZWZDY1BRR1ZURU9HeW1xZ1owa0xOVE8yNCtwMU9adm0vS2pMbFBxc2NGNlo2?=
 =?utf-8?B?d0N3aEdxTlA3aTluZGRpaFJ1YnBQYzVjQmROS2hRRUFvNzdnZXp5VDJncDZK?=
 =?utf-8?B?RFU2ejJxMjR0Z2MwdUw5dmNXZHhDL1drOUJQN0IzbUU3ZEFyMFhaYTBEV1RK?=
 =?utf-8?B?WUJ4MmIwYnJ3SkZ6YlBaWTBEeFJUQ0pIMVBkRFNqbCs2STM0bE9RcGlOZEVp?=
 =?utf-8?B?UEMzUHo0L0pESmRwamlDaFlMMjRiNFlEbVF4NFhUcXhLU2YxWk1Hc3VKTmlk?=
 =?utf-8?B?Qm1NcGJGZDJNZXBVRGw0WTQ2K2wvZUMwRWhFT3pUS2NjeEpuMEQzdmd1a09Y?=
 =?utf-8?B?STJsOXFlamdGdGRzQytMeFJMK29Vd3NDVnZLek83MzdGWHloMUFkNnh6LzVp?=
 =?utf-8?B?ZndoN2JqbEprN3ZYS2FZYUY3VFVnOU1qdkluTlp3VjdTN0doaVNXT3dGb1NG?=
 =?utf-8?B?ZU5EWXd6R2lkTlRmeGlDMGw0bmg2MWFSbDV5dmVzd25GSGhqYXRHRm5peEV2?=
 =?utf-8?B?Vkw0Y0NjekFsYk40UlpxcTRINFpsbEZQUFljbFhWR2hSNmpma3hTSzZPOVlk?=
 =?utf-8?B?bkxSTEtVbjV3NHhPYktaNnNTeWpqQ3RPeWZkL01GaVVtMURyTmpOLy9kWHRD?=
 =?utf-8?B?ZmFZS0Y4ZUM2RjE1V041TVpyUGRCaCtGd1l6bTlyekxITEFEQmVyWTRvZ0Zh?=
 =?utf-8?B?eTcwZHhSTXkyalROZE5VNVltZndZV3VWQTJZT3BrUmNSdk5ESDdiZlJFRVhX?=
 =?utf-8?B?NklLcFNhR3k0eHk4bUsyNUpqR1JFNWRrcEFNTFc4UFg1aTVyMVN6RGlITVFx?=
 =?utf-8?B?YTdYZlVPSmlldFBVMEUzYkx6VnBUTTI2RGM1RUI5VGs4dFkvZEJEczF3emRV?=
 =?utf-8?B?VUt3M20ySTczTzN5bTdLSHZXbDlHNXU5NStnU3pKTXozaDZJcGdBYTVEUEto?=
 =?utf-8?B?MGxiN203RTZrNVV0UWk4eUJJb0hGcjE4bStuWGFLOGd6SVI3YTVrSVBRQW1G?=
 =?utf-8?B?MUEvOEVGTVVzYVB6NnRDQXVwZEI4dXowTmo4M3NranUzVisyejRrOG00Y0NP?=
 =?utf-8?B?OXZJQ3Jjd2E4TExaeFVLZmNXM25NSWttaGQ1UHNpZlB6ZHZwaGtwejI5ZkUx?=
 =?utf-8?B?M1FCV2hHY3ZhK3ZDclNmdGt5VGhJbVo2S0IzZ1ZkbzBEY0Q2OXRxbHNyRFd1?=
 =?utf-8?B?VkkzSWdEZis1Q29UOE80R3A0WGpESUlvdllnZ0xDWVNFSDEzMmI3dUxzYlhl?=
 =?utf-8?B?ZWEwOW9rV0FWYTh0NTh6M1J1MWZiSXZLYUdaUmhsN3JMK01HWEduM2w3dlFj?=
 =?utf-8?B?eit3dFhCWU5FUHpXMjBTOGM1ZWZUcy92NDNFOEsyK3B2NDJnaEJMLzI3OUlX?=
 =?utf-8?B?SWF4UlVQZmZUWFFtYlhQM0sveFBVYXVZVWhQRmtJYXZsaytJb0YvODdYSkJy?=
 =?utf-8?B?bFhDVWpQZncva1RmLzJjUnlhS3dXSkVBRHpVWUZyelVmQnVOMEVsSy85d203?=
 =?utf-8?B?eTZsQ013aE9FZFBGWXI1YkF1TmxkOWtiMURJaHQ4ZnFoYVppLzVPR0RpdHZm?=
 =?utf-8?B?ekgxT01LK3g3WWd0N0JFdWRVRlYxMGNDZnh3ZCs1dC9XR0RqZnJSREIzNXJ1?=
 =?utf-8?Q?GYOmbvA+XUSdjGXQl6Nx2GF20?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d4f197b3-b52b-4a20-1b69-08dac309489e
X-MS-Exchange-CrossTenant-AuthSource: BN8PR12MB3587.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Nov 2022 10:49:47.0539 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DNkA9cIS84kpzTpHCWH+y+LsJgS4BweG52tvwCr483xB8hgsqDoILj2xThW2Bign
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR12MB6100
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
Cc: "Xiao, Jack" <Jack.Xiao@amd.com>, "Wang,
 Yang\(Kevin\)" <KevinYang.Wang@amd.com>, "Xu, Feifei" <Feifei.Xu@amd.com>,
 "Chen, Horace" <Horace.Chen@amd.com>, "Tuikov, Luben" <Luben.Tuikov@amd.com>,
 "Sohail, Rashid" <Rashid.Sohail@amd.com>, "Quan, Evan" <Evan.Quan@amd.com>,
 "Liu, Monk" <Monk.Liu@amd.com>, "Zhang, Hawking" <Hawking.Zhang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

My Acked-by should be sufficient as well.

For a Reviewed-by I would need to have more background on the atombios 
tables. Alex is the expert on that.

Regards,
Christian.

Am 10.11.22 um 11:47 schrieb Liu01, Tong (Esther):
> [AMD Official Use Only - General]
>
> Hi @Deucher, Alexander & @Koenig, Christian,
>
> Can you give me a Reviewed by:? Now the CI job must has Reviewed by then the patch can be passed. Patch is in the attachment. Thanks a lot.
>
> Kind regards,
> Esther
>
> -----Original Message-----
> From: Koenig, Christian <Christian.Koenig@amd.com>
> Sent: 2022年11月10日星期四 下午6:18
> To: Liu01, Tong (Esther) <Tong.Liu01@amd.com>; Chang, HaiJun <HaiJun.Chang@amd.com>; amd-gfx@lists.freedesktop.org; Zhang, Bokun <Bokun.Zhang@amd.com>
> Cc: Quan, Evan <Evan.Quan@amd.com>; Chen, Horace <Horace.Chen@amd.com>; Tuikov, Luben <Luben.Tuikov@amd.com>; Deucher, Alexander <Alexander.Deucher@amd.com>; Xiao, Jack <Jack.Xiao@amd.com>; Zhang, Hawking <Hawking.Zhang@amd.com>; Liu, Monk <Monk.Liu@amd.com>; Xu, Feifei <Feifei.Xu@amd.com>; Wang, Yang(Kevin) <KevinYang.Wang@amd.com>; Sohail, Rashid <Rashid.Sohail@amd.com>
> Subject: Re: [PATCH] drm/amdgpu: add vram reservation logic based on vram_usagebyfirmware_v2_2
>
> Feel free to add my Acked-by: Christian König <christian.koenig@amd.com> to the patch.
>
> Luben might have some additional comments, but in general I think the biggest problem here is the mail settings.
>
> Somehow either the mail client or the mail server are corrupting the patch.
>
> Regards,
> Christian.
>
> Am 10.11.22 um 11:14 schrieb Liu01, Tong (Esther):
>> [AMD Official Use Only - General]
>>
>> Hi Christian,
>>
>> Please find the attached patch, thanks!
>>
>> Kind regards,
>> Esther
>>
>> -----Original Message-----
>> From: Koenig, Christian <Christian.Koenig@amd.com>
>> Sent: 2022年11月8日星期二 下午10:04
>> To: Chang, HaiJun <HaiJun.Chang@amd.com>; Liu01, Tong (Esther)
>> <Tong.Liu01@amd.com>; amd-gfx@lists.freedesktop.org; Zhang, Bokun
>> <Bokun.Zhang@amd.com>
>> Cc: Quan, Evan <Evan.Quan@amd.com>; Chen, Horace
>> <Horace.Chen@amd.com>; Tuikov, Luben <Luben.Tuikov@amd.com>; Deucher,
>> Alexander <Alexander.Deucher@amd.com>; Xiao, Jack <Jack.Xiao@amd.com>;
>> Zhang, Hawking <Hawking.Zhang@amd.com>; Liu, Monk <Monk.Liu@amd.com>;
>> Xu, Feifei <Feifei.Xu@amd.com>; Wang, Yang(Kevin)
>> <KevinYang.Wang@amd.com>; Sohail, Rashid <Rashid.Sohail@amd.com>
>> Subject: Re: [PATCH] drm/amdgpu: add vram reservation logic based on
>> vram_usagebyfirmware_v2_2
>>
>> Yeah, I mean the code looks correct.
>>
>> It's just that style problems are usually pointed out by automated checkers, especially things like dos line endings.
>>
>> So get that fixed and we can push it immediately.
>>
>> Thanks,
>> Christian.
>>
>> Am 08.11.22 um 14:49 schrieb Chang, HaiJun:
>>> [AMD Official Use Only - General]
>>>
>>> + Bokun to help addressing the coding style problem in MKM side.
>>>
>>> -----Original Message-----
>>> From: Koenig, Christian <Christian.Koenig@amd.com>
>>> Sent: Tuesday, November 8, 2022 8:53 PM
>>> To: Liu01, Tong (Esther) <Tong.Liu01@amd.com>;
>>> amd-gfx@lists.freedesktop.org
>>> Cc: Quan, Evan <Evan.Quan@amd.com>; Chen, Horace
>>> <Horace.Chen@amd.com>; Tuikov, Luben <Luben.Tuikov@amd.com>; Deucher,
>>> Alexander <Alexander.Deucher@amd.com>; Xiao, Jack
>>> <Jack.Xiao@amd.com>; Zhang, Hawking <Hawking.Zhang@amd.com>; Liu,
>>> Monk <Monk.Liu@amd.com>; Xu, Feifei <Feifei.Xu@amd.com>; Wang,
>>> Yang(Kevin) <KevinYang.Wang@amd.com>; Chang, HaiJun
>>> <HaiJun.Chang@amd.com>; Sohail, Rashid <Rashid.Sohail@amd.com>
>>> Subject: Re: [PATCH] drm/amdgpu: add vram reservation logic based on
>>> vram_usagebyfirmware_v2_2
>>>
>>> Hi Esther
>>>
>>> well there are a couple of things which you need to address before getting this merged.
>>>
>>> First of all the patch you send out uses dos line endings instead of the unix line endings. Not sure how you manage to do that, but please use "git send-email" instead to avoid that.
>>>
>>> Then your patch contains a bunch of white spaces after code warning which checkpatch.pl complains about (after ignoring the dos line ending warnings). So this was clearly not properly checked with checkpatch.pl.
>>>
>>> Then the kernel coding style usually says that with a multi line "if ("
>>> the next lines should start after the opening "(". In other words intend with tabs and the whitespaces. I'm not sure what editor you are using, but there are standard settings available for basically all large editors which does stuff like that automatically. Please try to use one of those.
>>>
>>> Regarding the casing of the values it's a good argument that you only move the code around, but the general coding style is just extremely questionable. The defines should use the lowest necessary integer type.
>>> But it's correct that this should probably be part of another patch.
>>>
>>> Regards,
>>> Christian.
>>>
>>> Am 08.11.22 um 11:40 schrieb Liu01, Tong (Esther):
>>>> [AMD Official Use Only - General]
>>>>
>>>> Hi @Koenig, Christian,
>>>>
>>>> Refined as your comment. By the way:
>>>> if ((start_addr & ATOM_VRAM_OPERATION_FLAGS_MASK) ==
>>>> +             (uint32_t)(ATOM_VRAM_BLOCK_SRIOV_MSG_SHARE_RESERVATION <<
>>>> +             ATOM_VRAM_OPERATION_FLAGS_SHIFT))
>>>>
>>>> This part is the old code, I just move it out from the original function to shrink the function size as your comment before. And now I just removed the first uint32_t since if remove both will cause "warning: bitwise comparison always evaluates to false". And I tested the code after removing the first uint32_t, the code works well. Please review the new patch, thanks.
>>>>
>>>> Kind regards,
>>>> Esther
>>>>
>>>> -----Original Message-----
>>>> From: Tong Liu01 <Tong.Liu01@amd.com>
>>>> Sent: 2022年11月8日星期二 下午6:33
>>>> To: amd-gfx@lists.freedesktop.org
>>>> Cc: Quan, Evan <Evan.Quan@amd.com>; Chen, Horace
>>>> <Horace.Chen@amd.com>; Tuikov, Luben <Luben.Tuikov@amd.com>; Koenig,
>>>> Christian <Christian.Koenig@amd.com>; Deucher, Alexander
>>>> <Alexander.Deucher@amd.com>; Xiao, Jack <Jack.Xiao@amd.com>; Zhang,
>>>> Hawking <Hawking.Zhang@amd.com>; Liu, Monk <Monk.Liu@amd.com>; Xu,
>>>> Feifei <Feifei.Xu@amd.com>; Wang, Yang(Kevin)
>>>> <KevinYang.Wang@amd.com>; Liu01, Tong (Esther) <Tong.Liu01@amd.com>
>>>> Subject: [PATCH] drm/amdgpu: add vram reservation logic based on
>>>> vram_usagebyfirmware_v2_2
>>>>
>>>> Move TMR region from top of FB to 2MB for FFBM, so we need to
>>>> reserve TMR region firstly to make sure TMR can be allocated at 2MB
>>>>
>>>> Signed-off-by: Tong Liu01 <Tong.Liu01@amd.com>
>>>> ---
>>>>      .../gpu/drm/amd/amdgpu/amdgpu_atomfirmware.c  | 106 ++++++++++++++----
>>>>      drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c       |  50 +++++++++
>>>>      drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h       |   5 +
>>>>      drivers/gpu/drm/amd/include/atomfirmware.h    |  62 ++++++++--
>>>>      4 files changed, 192 insertions(+), 31 deletions(-)
>>>>
>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_atomfirmware.c
>>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_atomfirmware.c
>>>> index b81b77a9efa6..032dc2678d7c 100644
>>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_atomfirmware.c
>>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_atomfirmware.c
>>>> @@ -101,39 +101,99 @@ void amdgpu_atomfirmware_scratch_regs_init(struct amdgpu_device *adev)
>>>>          }
>>>>      }
>>>>
>>>> +static int amdgpu_atomfirmware_allocate_fb_v2_1(struct amdgpu_device *adev,
>>>> +             struct vram_usagebyfirmware_v2_1 *firmware_usage_v2_1,
>>>> +             int *usage_bytes)
>>>> +{
>>>> +     uint32_t start_addr, fw_size, drv_size;
>>>> +
>>>> +     start_addr = le32_to_cpu(firmware_usage_v2_1->start_address_in_kb);
>>>> +     fw_size = le16_to_cpu(firmware_usage_v2_1->used_by_firmware_in_kb);
>>>> +     drv_size =
>>>> + le16_to_cpu(firmware_usage_v2_1->used_by_driver_in_kb);
>>>> +
>>>> +     DRM_DEBUG("atom firmware v2_1 requested %08x %dkb fw %dkb drv\n",
>>>> +             start_addr,
>>>> +             fw_size,
>>>> +             drv_size);
>>>> +
>>>> +     if ((start_addr & ATOM_VRAM_OPERATION_FLAGS_MASK) ==
>>>> +             (uint32_t)(ATOM_VRAM_BLOCK_SRIOV_MSG_SHARE_RESERVATION <<
>>>> +             ATOM_VRAM_OPERATION_FLAGS_SHIFT)) {
>>>> +             /* Firmware request VRAM reservation for SR-IOV */
>>>> +             adev->mman.fw_vram_usage_start_offset = (start_addr &
>>>> +                     (~ATOM_VRAM_OPERATION_FLAGS_MASK)) << 10;
>>>> +             adev->mman.fw_vram_usage_size = fw_size << 10;
>>>> +             /* Use the default scratch size */
>>>> +             *usage_bytes = 0;
>>>> +     } else {
>>>> +             *usage_bytes = drv_size << 10;
>>>> +     }
>>>> +     return 0;
>>>> +}
>>>> +
>>>> +static int amdgpu_atomfirmware_allocate_fb_v2_2(struct amdgpu_device *adev,
>>>> +             struct vram_usagebyfirmware_v2_2 *firmware_usage_v2_2,
>>>> +             int *usage_bytes)
>>>> +{
>>>> +     uint32_t fw_start_addr, fw_size, drv_start_addr, drv_size;
>>>> +
>>>> +     fw_start_addr = le32_to_cpu(firmware_usage_v2_2->fw_region_start_address_in_kb);
>>>> +     fw_size =
>>>> + le16_to_cpu(firmware_usage_v2_2->used_by_firmware_in_kb);
>>>> +
>>>> +     drv_start_addr = le32_to_cpu(firmware_usage_v2_2->driver_region0_start_address_in_kb);
>>>> +     drv_size =
>>>> +le32_to_cpu(firmware_usage_v2_2->used_by_driver_region0_in_kb);
>>>> +
>>>> +     DRM_DEBUG("atom requested fw start at %08x %dkb and drv start at %08x %dkb\n",
>>>> +             fw_start_addr,
>>>> +             fw_size,
>>>> +             drv_start_addr,
>>>> +             drv_size);
>>>> +
>>>> +     if ((fw_start_addr & (ATOM_VRAM_BLOCK_NEEDS_NO_RESERVATION << 30)) == 0) {
>>>> +             /* Firmware request VRAM reservation for SR-IOV */
>>>> +             adev->mman.fw_vram_usage_start_offset = (fw_start_addr &
>>>> +                     (~ATOM_VRAM_OPERATION_FLAGS_MASK)) << 10;
>>>> +             adev->mman.fw_vram_usage_size = fw_size << 10;
>>>> +     }
>>>> +
>>>> +     if ((drv_start_addr & (ATOM_VRAM_BLOCK_NEEDS_NO_RESERVATION << 30)) == 0) {
>>>> +             /* driver request VRAM reservation for SR-IOV */
>>>> +             adev->mman.drv_vram_usage_start_offset = (drv_start_addr &
>>>> +                     (~ATOM_VRAM_OPERATION_FLAGS_MASK)) << 10;
>>>> +             adev->mman.drv_vram_usage_size = drv_size << 10;
>>>> +     }
>>>> +
>>>> +     *usage_bytes = 0;
>>>> +     return 0;
>>>> +}
>>>> +
>>>>      int amdgpu_atomfirmware_allocate_fb_scratch(struct amdgpu_device *adev)  {
>>>>          struct atom_context *ctx = adev->mode_info.atom_context;
>>>>          int index = get_index_into_master_table(atom_master_list_of_data_tables_v2_1,
>>>>                                                  vram_usagebyfirmware);
>>>> -     struct vram_usagebyfirmware_v2_1 *firmware_usage;
>>>> -     uint32_t start_addr, size;
>>>> +     struct vram_usagebyfirmware_v2_1 *firmware_usage_v2_1;
>>>> +     struct vram_usagebyfirmware_v2_2 *firmware_usage_v2_2;
>>>>          uint16_t data_offset;
>>>> +     uint8_t frev, crev;
>>>>          int usage_bytes = 0;
>>>>
>>>> -     if (amdgpu_atom_parse_data_header(ctx, index, NULL, NULL, NULL, &data_offset)) {
>>>> -             firmware_usage = (struct vram_usagebyfirmware_v2_1 *)(ctx->bios + data_offset);
>>>> -             DRM_DEBUG("atom firmware requested %08x %dkb fw %dkb drv\n",
>>>> -                       le32_to_cpu(firmware_usage->start_address_in_kb),
>>>> -                       le16_to_cpu(firmware_usage->used_by_firmware_in_kb),
>>>> -                       le16_to_cpu(firmware_usage->used_by_driver_in_kb));
>>>> -
>>>> -             start_addr = le32_to_cpu(firmware_usage->start_address_in_kb);
>>>> -             size = le16_to_cpu(firmware_usage->used_by_firmware_in_kb);
>>>> -
>>>> -             if ((uint32_t)(start_addr & ATOM_VRAM_OPERATION_FLAGS_MASK) ==
>>>> -                     (uint32_t)(ATOM_VRAM_BLOCK_SRIOV_MSG_SHARE_RESERVATION <<
>>>> -                     ATOM_VRAM_OPERATION_FLAGS_SHIFT)) {
>>>> -                     /* Firmware request VRAM reservation for SR-IOV */
>>>> -                     adev->mman.fw_vram_usage_start_offset = (start_addr &
>>>> -                             (~ATOM_VRAM_OPERATION_FLAGS_MASK)) << 10;
>>>> -                     adev->mman.fw_vram_usage_size = size << 10;
>>>> -                     /* Use the default scratch size */
>>>> -                     usage_bytes = 0;
>>>> -             } else {
>>>> -                     usage_bytes = le16_to_cpu(firmware_usage->used_by_driver_in_kb) << 10;
>>>> +     if (amdgpu_atom_parse_data_header(ctx, index, NULL, &frev, &crev, &data_offset)) {
>>>> +             if (frev == 2 && crev == 1) {
>>>> +                     firmware_usage_v2_1 =
>>>> +                             (struct vram_usagebyfirmware_v2_1 *)(ctx->bios + data_offset);
>>>> +                     amdgpu_atomfirmware_allocate_fb_v2_1(adev,
>>>> +                                     firmware_usage_v2_1,
>>>> +                                     &usage_bytes);
>>>> +             } else if (frev >= 2 && crev >= 2) {
>>>> +                     firmware_usage_v2_2 =
>>>> +                             (struct vram_usagebyfirmware_v2_2 *)(ctx->bios + data_offset);
>>>> +                     amdgpu_atomfirmware_allocate_fb_v2_2(adev,
>>>> +                                     firmware_usage_v2_2,
>>>> +                                     &usage_bytes);
>>>>                  }
>>>>          }
>>>> +
>>>>          ctx->scratch_size_bytes = 0;
>>>>          if (usage_bytes == 0)
>>>>                  usage_bytes = 20 * 1024; diff --git
>>>> a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
>>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
>>>> index 585460ab8dfd..4a73cb314086 100644
>>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
>>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
>>>> @@ -1578,6 +1578,22 @@ static void amdgpu_ttm_fw_reserve_vram_fini(struct amdgpu_device *adev)
>>>>                  NULL, &adev->mman.fw_vram_usage_va);
>>>>      }
>>>>
>>>> +/*
>>>> + * Driver Reservation functions
>>>> + */
>>>> +/**
>>>> + * amdgpu_ttm_drv_reserve_vram_fini - free drv reserved vram
>>>> + *
>>>> + * @adev: amdgpu_device pointer
>>>> + *
>>>> + * free drv reserved vram if it has been reserved.
>>>> + */
>>>> +static void amdgpu_ttm_drv_reserve_vram_fini(struct amdgpu_device
>>>> +*adev) {
>>>> +     amdgpu_bo_free_kernel(&adev->mman.drv_vram_usage_reserved_bo,
>>>> +             NULL, NULL);
>>>> +}
>>>> +
>>>>      /**
>>>>       * amdgpu_ttm_fw_reserve_vram_init - create bo vram reservation from fw
>>>>       *
>>>> @@ -1604,6 +1620,31 @@ static int amdgpu_ttm_fw_reserve_vram_init(struct amdgpu_device *adev)
>>>>                                            &adev->mman.fw_vram_usage_va);
>>>>      }
>>>>
>>>> +/**
>>>> + * amdgpu_ttm_drv_reserve_vram_init - create bo vram reservation
>>>> +from driver
>>>> + *
>>>> + * @adev: amdgpu_device pointer
>>>> + *
>>>> + * create bo vram reservation from drv.
>>>> + */
>>>> +static int amdgpu_ttm_drv_reserve_vram_init(struct amdgpu_device
>>>> +*adev) {
>>>> +     uint64_t vram_size = adev->gmc.visible_vram_size;
>>>> +
>>>> +     adev->mman.drv_vram_usage_reserved_bo = NULL;
>>>> +
>>>> +     if (adev->mman.drv_vram_usage_size == 0 ||
>>>> +         adev->mman.drv_vram_usage_size > vram_size)
>>>> +             return 0;
>>>> +
>>>> +     return amdgpu_bo_create_kernel_at(adev,
>>>> +                                       adev->mman.drv_vram_usage_start_offset,
>>>> +                                       adev->mman.drv_vram_usage_size,
>>>> +                                       AMDGPU_GEM_DOMAIN_VRAM,
>>>> +                                       &adev->mman.drv_vram_usage_reserved_bo,
>>>> +                                       NULL); }
>>>> +
>>>>      /*
>>>>       * Memoy training reservation functions
>>>>       */
>>>> @@ -1771,6 +1812,14 @@ int amdgpu_ttm_init(struct amdgpu_device *adev)
>>>>                  return r;
>>>>          }
>>>>
>>>> +     /*
>>>> +      *The reserved vram for driver must be pinned to the specified
>>>> +      *place on the VRAM, so reserve it early.
>>>> +      */
>>>> +     r = amdgpu_ttm_drv_reserve_vram_init(adev);
>>>> +     if (r)
>>>> +             return r;
>>>> +
>>>>          /*
>>>>           * only NAVI10 and onwards ASIC support for IP discovery.
>>>>           * If IP discovery enabled, a block of memory should be @@ -1896,6 +1945,7 @@ void amdgpu_ttm_fini(struct amdgpu_device *adev)
>>>>          amdgpu_bo_free_kernel(&adev->mman.sdma_access_bo, NULL,
>>>>                                          &adev->mman.sdma_access_ptr);
>>>>          amdgpu_ttm_fw_reserve_vram_fini(adev);
>>>> +     amdgpu_ttm_drv_reserve_vram_fini(adev);
>>>>
>>>>          if (drm_dev_enter(adev_to_drm(adev), &idx)) {
>>>>
>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h
>>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h
>>>> index 9120ae80ef52..339838675b11 100644
>>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h
>>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h
>>>> @@ -92,6 +92,11 @@ struct amdgpu_mman {
>>>>          struct amdgpu_bo        *fw_vram_usage_reserved_bo;
>>>>          void            *fw_vram_usage_va;
>>>>
>>>> +     /* driver VRAM reservation */
>>>> +     u64             drv_vram_usage_start_offset;
>>>> +     u64             drv_vram_usage_size;
>>>> +     struct amdgpu_bo        *drv_vram_usage_reserved_bo;
>>>> +
>>>>          /* PAGE_SIZE'd BO for process memory r/w over SDMA. */
>>>>          struct amdgpu_bo        *sdma_access_bo;
>>>>          void                    *sdma_access_ptr;
>>>> diff --git a/drivers/gpu/drm/amd/include/atomfirmware.h
>>>> b/drivers/gpu/drm/amd/include/atomfirmware.h
>>>> index ff855cb21d3f..c0f56ae653f0 100644
>>>> --- a/drivers/gpu/drm/amd/include/atomfirmware.h
>>>> +++ b/drivers/gpu/drm/amd/include/atomfirmware.h
>>>> @@ -705,20 +705,66 @@ struct atom_gpio_pin_lut_v2_1  };
>>>>
>>>>
>>>> -/*
>>>> -  ***************************************************************************
>>>> -    Data Table vram_usagebyfirmware  structure
>>>> -
>>>> ********************************************************************
>>>> *
>>>> *
>>>> *****
>>>> +/*
>>>> +  VBIOS/PRE-OS always reserve a FB region at the top of frame buffer. driver should not write access that region.
>>>> +  driver can allocate their own reservation region as long as it does not overlap firwmare's reservation region.
>>>> +  if( atom data table firmwareInfoTable version < 3.3) { //( pre-NV1X )
>>>> +    in this case, atom data table vram_usagebyfirmwareTable version always <= 2.1
>>>> +    if( VBIOS/UEFI GOP is posted ) {
>>>> +      VBIOS/UEFIGOP update used_by_firmware_in_kb = total reserved size by VBIOS
>>>> +      update start_address_in_kb = total_mem_size_in_kb - used_by_firmware_in_kb;  ( total_mem_size_in_kb = reg(CONFIG_MEMSIZE)<<10)
>>>> +      driver can allocate driver reservation region under firmware reservation,
>>>> +      used_by_driver_in_kb = driver reservation size
>>>> +      driver reservation start address =  (start_address_in_kb - used_by_driver_in_kb)
>>>> +    Comment1[hchan]: There is only one reservation at the beginning of the FB reserved by Host driver.
>>>> +    Host driver would overwrite the table with the following
>>>> +    used_by_firmware_in_kb = total reserved size for pf-vf info exchange and
>>>> +    set SRIOV_MSG_SHARE_RESERVATION mask start_address_in_kb = 0
>>>> +    } else {
>>>> +      there is no VBIOS reservation region
>>>> +      driver must allocate driver reservation region at top of FB.
>>>> +      driver set used_by_driver_in_kb = driver reservation size
>>>> +      driver reservation start address =  (total_mem_size_in_kb - used_by_driver_in_kb)
>>>> +      same as Comment1
>>>> +    }
>>>> +  } else { //( NV1X and after)
>>>> +    if( VBIOS/UEFI GOP is posted ) {
>>>> +      VBIOS/UEFIGOP update used_by_firmware_in_kb = atom_firmware_Info_v3_3.fw_reserved_size_in_kb;
>>>> +      update start_address_in_kb = total_mem_size_in_kb - used_by_firmware_in_kb;  ( total_mem_size_in_kb = reg(CONFIG_MEMSIZE)<<10  )
>>>> +    }
>>>> +    if( vram_usagebyfirmwareTable version <= 2.1 ) {
>>>> +      driver can allocate driver reservation region under firmware reservation,
>>>> +      driver set used_by_driver_in_kb = driver reservation size
>>>> +      driver reservation start address =  (start_address_in_kb - used_by_driver_in_kb)
>>>> +      same as Comment1
>>>> +    } else {
>>>> +      dirver can allocate it reservation any place as long as it does overlap pre-OS FW reservation area
>>>> +      driver set used_by_driver_region0_in_kb = driver reservation size
>>>> +      driver set driver_region0_start_address_in_kb =  driver reservation region start address
>>>> +      Comment2[hchan]: Host driver can set used_by_firmware_in_kb and start_address_in_kb to zero
>>>> +      as the reservation for VF as it doesn’t exist.  And Host driver should also
>>>> +      update atom_firmware_Info table to remove the same VBIOS reservation as well.
>>>> +    }
>>>> +  }
>>>>      */
>>>>
>>>>      struct vram_usagebyfirmware_v2_1
>>>>      {
>>>> -  struct  atom_common_table_header  table_header;
>>>> -  uint32_t  start_address_in_kb;
>>>> -  uint16_t  used_by_firmware_in_kb;
>>>> -  uint16_t  used_by_driver_in_kb;
>>>> +     struct  atom_common_table_header  table_header;
>>>> +     uint32_t  start_address_in_kb;
>>>> +     uint16_t  used_by_firmware_in_kb;
>>>> +     uint16_t  used_by_driver_in_kb;
>>>>      };
>>>>
>>>> +struct vram_usagebyfirmware_v2_2 {
>>>> +     struct  atom_common_table_header  table_header;
>>>> +     uint32_t  fw_region_start_address_in_kb;
>>>> +     uint16_t  used_by_firmware_in_kb;
>>>> +     uint16_t  reserved;
>>>> +     uint32_t  driver_region0_start_address_in_kb;
>>>> +     uint32_t  used_by_driver_region0_in_kb;
>>>> +     uint32_t  reserved32[7];
>>>> +};
>>>>
>>>>      /*
>>>>
>>>> ********************************************************************
>>>> *
>>>> *
>>>> *****
>>>> --
>>>> 2.25.1

