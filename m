Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CB529EB64DA
	for <amd-gfx@archiver.kernel.org>; Wed,  5 Jul 2023 19:58:08 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 42E5810E085;
	Wed,  5 Jul 2023 19:58:08 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2061f.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7e89::61f])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DB15D10E085
 for <amd-gfx@lists.freedesktop.org>; Wed,  5 Jul 2023 19:58:05 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OOJaHCoTB99IfXQ+wFj2/uizYP18UmJOxcajPTIaNIlXEJ8EnD7dMgvcS9ehomReFG5lJTaOpVmVDHbtKzBPaikaNpW1GrcVV6OhtDIKk3dg3xs47UCQKhbRxtqTXC0yod7nOyQsjb8SuFgGmeEltxC/QBLK3FpDCtu1OoHs5sksHhmlCi5iZrGtodamnAGs8aMlRJiiOQlXo+25miq3zdn5VMcDK2wvDMR8UAEY9xWciXWatP968RMkVcHLwLhvpbzj8CPCxT1Ya6EDo8Df3ZjwEBoMH37+siOsPTz8jKwYikGk1bEaEeicjwZ7BvXNDcbSlM7dYz9njn5IoaY2zg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=moff6cAtsOWbvgpc4GedvrlvaXNfz97aP0s+lQWjNsI=;
 b=lUsl8sd4d4z6YWJ+dAyrbKDyaLEKyrNdNq72BilvxesoMQsuSKYyycx+Rl+KQykwW0/1gMTmDygQw4FHKuOA4PHZptomshJOajVwmLUth0OEIpDJUgvPPPlpfjBJPrrvZ39vbvo1QQnZYMLdyE/0YOXv/Jm+ou3VJGBtlVQqOyySFNWV0E1XLjoSedkPtwz2Gcp7lGwGs347ZepEbNiUofuh1EpY3I0OYj6eniLb4F5ACYd0/KUwNSM9nznXmz71UUCGBSu10YYazp2iV4T83uEk8x+c2XkYU1drBeoOb2P1rtsaRnz+nEClWBnrSgkS0NA5pyynwgMjfsI8zZpVuw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=moff6cAtsOWbvgpc4GedvrlvaXNfz97aP0s+lQWjNsI=;
 b=xZio7plEXqx3ctScY2PoZz9n5pJmdP8cfbMkofbiwKBtTscP0KsUM1CtYXljc8H9lTmUiuBxh6bKNL8Tyx8e7zTVkag9lQXfaDXTzld88QJ9hvyaWj2s+OXmElCmwcbYLl7bH2Fe7gG3yOH3B8Oa4zDvB/7o103cKT4HvBHRgOY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM8PR12MB5399.namprd12.prod.outlook.com (2603:10b6:8:34::5) by
 PH8PR12MB6699.namprd12.prod.outlook.com (2603:10b6:510:1ce::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6565.17; Wed, 5 Jul
 2023 19:58:03 +0000
Received: from DM8PR12MB5399.namprd12.prod.outlook.com
 ([fe80::10e9:7f44:45ae:4f94]) by DM8PR12MB5399.namprd12.prod.outlook.com
 ([fe80::10e9:7f44:45ae:4f94%5]) with mapi id 15.20.6565.016; Wed, 5 Jul 2023
 19:58:03 +0000
Message-ID: <1fb0cf4f-3ea4-cd0a-64e9-9d6f22e968f3@amd.com>
Date: Wed, 5 Jul 2023 15:57:59 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH] drm/amdgpu: Clear VCN cache when hw_init
To: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>,
 Horace Chen <horace.chen@amd.com>, amd-gfx@lists.freedesktop.org
References: <20230620132950.1121406-1-horace.chen@amd.com>
 <9c19a828-15ed-c37a-2c07-acf29f489541@amd.com>
Content-Language: en-US
From: Leo Liu <leo.liu@amd.com>
In-Reply-To: <9c19a828-15ed-c37a-2c07-acf29f489541@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: YT1PR01CA0151.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:2f::30) To DM8PR12MB5399.namprd12.prod.outlook.com
 (2603:10b6:8:34::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM8PR12MB5399:EE_|PH8PR12MB6699:EE_
X-MS-Office365-Filtering-Correlation-Id: b637d300-ada1-4962-45dd-08db7d922440
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ko4IcvB3qle9oU5Bd/028shnPrUXIWhvqQpf+ezntX1NUZSazKzHEsz1FaB4dKEHTFwg72LX+PzNcQvIogyFVXy1fUKHPrauNHRvrHD9liLozhjHY2tqgalxu46EP8IT5bZGLt1EzMWHnBh00oVKbDJdTsV9j2ej0qwlxcdHna7DXGBycUl+pwcabr8BkmIEY7x/8kLAcJmkCvyx1wVcbT40uI77DCMf/xoTbIWUvMP1i5JKUKSYjk09KYV1nM3jTwRk93iIJZEvPltbOXF9ioIpsDEbIFc2Qg5uzPHKfUW6FXOZC8hhriTiVemDPCaaJMT2Y+XSQDRtP1Mx+Z2Hr90V96zPhA8411lWS/aqrwY+TWZgm89FU5CfFsAOAG3xt1nFbvPbllGnFx+i8bamq0dlDvBV/mnLKrK8yDaUN64PQ7SYcVlC2BK8JUJBuU3onts8yAxoLAVNkt6ImINOem8gT2T+oThGCG0UZxENiAJTiW2fqTO3NqvZ90dA07VJZFSS8r6DFlxnJqvClLBCMajOYjyVmDwDBzlQuyb1JKla+2GyMXtUmhFECk7ntbwNtFZsJaach8DQ3LqfuB7bulecD1wBntBlKzaJK038+x4bD1V7yD+qFC7sEskcK1YImhDndjAJO5OVDzNemVp56Q==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM8PR12MB5399.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(4636009)(136003)(39860400002)(396003)(366004)(376002)(346002)(451199021)(36756003)(31686004)(31696002)(44832011)(86362001)(2906002)(5660300002)(6512007)(186003)(83380400001)(66574015)(6506007)(26005)(53546011)(6486002)(110136005)(54906003)(66556008)(4326008)(66476007)(2616005)(38100700002)(66946007)(316002)(8676002)(478600001)(6666004)(8936002)(41300700001)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SHRWdXIxK2k0VnpWYnFPYWQyUUU1NG1FMXhZdjZidFlNZ2YxVk9iaUtBdkp6?=
 =?utf-8?B?OEJ1Q2Q4NUo1UElyaUtoZUVwNTlvS1NENkE3T1Z1cjJtMStjU3NYdHRYc1c5?=
 =?utf-8?B?U2pHMTAwNkgxSGRUVTVmUEpscXp4N0NweWFaZUxYK21PSTl5NmIrV014bWxX?=
 =?utf-8?B?OFlaTERDZlFwK0oveVJJY3drVDU4WXNCWGdlMW5jY21DQnAybGlQRmNCUXNj?=
 =?utf-8?B?cGVyczVORUhmYjlkaWZleDJYTU93LzBVS2s2NFFFTlBMY1g1di9vTXZwZis2?=
 =?utf-8?B?S1RvWUV5VWlzNUdiSVBUQnJMS0pSNDYxdjdXWWdTbWJnNEdyVnVKeGxVU25J?=
 =?utf-8?B?R25WV2JGNVBqa3l3ZktnS3RobUdBNmxkTE5rY3BiRDFJY1JPdXVNV2RHa2J2?=
 =?utf-8?B?ejhKUERUMG9wRnZqb2o4d0prMGErTW5oc3RLUC9jOTViWnFSdEhCd3BsUnBn?=
 =?utf-8?B?VGd3Z0J1OUtnSXZlcDhKdmNOZ2J3YlRGLzh6dXpONGRZTVN4MWRkNjJRK2d4?=
 =?utf-8?B?UERodG9kbjhicWE4eW1tSU1FckdRNDNYdXFNT3laK1lCVzRkSWhQc2ZyMTYv?=
 =?utf-8?B?ZHh0dXAwS1htN1EyVzF6L090K1BMdVNqbTFUWVpWQzdjSTBLY2ROSGRmajZh?=
 =?utf-8?B?eW5YUWZRNkMrNjM4ZjRYTUlpMTdNNHJCM2NZZVJwYk5CNTZQTGExenBhQ1JE?=
 =?utf-8?B?N0N2ZFFJaDZadG9YNk1uTW9qOUV6MG14YlF4bFVRMEI4RDA0RzdvR2p4OU5E?=
 =?utf-8?B?eCtOZDA2NXBENXRkUEtYVDRVMFluaHF5RlZRenc0b090dENRUm1OQXlaMTNB?=
 =?utf-8?B?MFBWa0xCVlpncUVtanYyN2pnaHZxbXRwNEpXZE9kRnNhYjIrZVJzSVZIOXRJ?=
 =?utf-8?B?QWYvM0lRc1l1TEgxTDA2MlVueGQ5ZjhqSG9BeVlwZjEwN3lKL2tuR1hiRTVO?=
 =?utf-8?B?OUdlWm1Gc1NUMXJReURwV1JncHpITDUwa0JUZVp3NWs5MENmcXBUazNPK1l2?=
 =?utf-8?B?MjdxaXR2SHkyb3U3SVZ2dE1pcnA2bVFuK1NMWVhWY2pUVlNHRTVQRHV5NXNu?=
 =?utf-8?B?c0Rvd1VvT29ZMEFDeStNdWNxd2UwL1FtaWxaV1pudjZ6bllnOWMxa0dMQjZH?=
 =?utf-8?B?aVU1UFJNd0lnWHg4bTMxRDF2UXZZUUlBQWJiUmlKb2tWR3BxOEFOTWZwVDZv?=
 =?utf-8?B?RWVtTjlyN0p1cC9td2Ezc042MUNEd254Sm5vUk4rTnJZak10RzMrVTY3c0dU?=
 =?utf-8?B?c1B0VVFYaUQ2NjBQNkJyUDhPdS9URklTNzZ2T050eWw1TU5raFJZZEg3NU5V?=
 =?utf-8?B?WG5ocTVHb2x3WmpLUWowOHRHdElscVEzdnhQU2RoQVBZUnNPV2ZqdUg5TGp2?=
 =?utf-8?B?RGxLN0g4Y08xcVEwQk80bEtoT2QrSWEvbzZOVk0wTkEzTDNaUHArVEQyTDJH?=
 =?utf-8?B?RGFObnpxUzFRWTUvbEZ6U2NPZk9ydk1tZzhZZVNUVlQ0ZVhMK3dsMWFIQ0c5?=
 =?utf-8?B?MkdJWmtFTUJiZzc5T3c5aWg4bmF1K0hFR2o0aWtGcFhQSHcxVGtkblJVSG1F?=
 =?utf-8?B?RXNmemJ3SnQ1QVJQSDVpZXlKNDREVWNjaEFnSzlXY2t4dVROUjBpOXNDQVVK?=
 =?utf-8?B?Ly9ZaVhZQlA3T0RZL241MzNoU1lFcG1ZWDNrRm1ad083ay9JS0M2byt0ODNq?=
 =?utf-8?B?V1dsZ2hYU3U2aUE0KzJOQTlEOWowRmxOUHU2Ry9MRWNnTXh2SGRDMFYrdEls?=
 =?utf-8?B?VUdsUW90SWt6dHVVRE9kQ0V2cXlyRXFlL2VLdzl1dU9EelFqWlJHaHlIcU1Z?=
 =?utf-8?B?eGRhS0prSW9HUEhnNWhyM1dub0FPMXRPNmZOVWpZS1piczJPVWo4OHpYSktS?=
 =?utf-8?B?UEJ0SE9GS1RqZ01jMGVodVRVZ2tqeXNmNkhabzVzN2JPVmhFandZZG10Y1Qv?=
 =?utf-8?B?WDlXT0s5VzZkb0grUUdSTnBKanMzaDN5NUxDYlZEc0pxVHliOVAwRnMrM2Zq?=
 =?utf-8?B?R2RjRGZTUzJYenN1M2xYRXRkczJMODVNdlBEYk9WekRCdFJUdkV3aTNPbGgr?=
 =?utf-8?B?V28zcWRxcHNPZmVUYktGVHErcGl5SUY0dlRJMGJUR3NoSG1JQVJ4UHRjUHdh?=
 =?utf-8?Q?taaQ=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b637d300-ada1-4962-45dd-08db7d922440
X-MS-Exchange-CrossTenant-AuthSource: DM8PR12MB5399.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jul 2023 19:58:03.1715 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: psXVeyoPieRBJ7S9LDGfiw2XJEEGXgM/Bh7+6MhJYq5Q1vFJnfc8g3Y2viDfqf3X
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB6699
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
Cc: Jack Xiao <Jack.Xiao@amd.com>, Feifei Xu <Feifei.Xu@amd.com>,
 Haijun Chang <HaiJun.Chang@amd.com>,
 Deucher Alexander <Alexander.Deucher@amd.com>, Evan Quan <Evan.Quan@amd.com>,
 Monk Liu <Monk.Liu@amd.com>, Hawking Zhang <Hawking.Zhang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

What Christian says is correct, esp. during the playback or encode, when 
suspend/resume happens, it will save the FW context, and after resume, 
it will continue the job to where it left during the suspend. Will this 
apply to SRIOV case? Since the changes only within the SRIOV code, 
please make sure that also please specify the SRIOV from your patch 
subject and commit message.

Regards,

Leo


On 2023-06-30 07:38, Christian König wrote:
> Am 20.06.23 um 15:29 schrieb Horace Chen:
>> [Why]
>> VCN will use some framebuffer space as its cache. It needs to
>> be reset when reset happens, such as FLR. Otherwise some error
>> may be kept after the reset.
>
> Well this doesn't make sense at all.
>
> The full content of adev->vcn.inst[i].cpu_addr is saved and restored 
> during suspend/resume and IIRC GPU resets as well.
>
> See functions amdgpu_vcn_suspend() and amdgpu_vcn_resume().
>
> Please let Leo's team take a look at this and review the change before 
> it is committed.
>
> Regards,
> Christian.
>
>>
>> Signed-off-by: Horace Chen <horace.chen@amd.com>
>> ---
>>   drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c | 3 +++
>>   1 file changed, 3 insertions(+)
>>
>> diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c 
>> b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c
>> index b48bb5212488..2db73a964031 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c
>> @@ -1292,6 +1292,7 @@ static int vcn_v4_0_start_sriov(struct 
>> amdgpu_device *adev)
>>               cache_size);
>>             cache_addr = adev->vcn.inst[i].gpu_addr + offset;
>> +        memset(adev->vcn.inst[i].cpu_addr + offset, 0, 
>> AMDGPU_VCN_STACK_SIZE);
>>           MMSCH_V4_0_INSERT_DIRECT_WT(SOC15_REG_OFFSET(VCN, i,
>>               regUVD_LMI_VCPU_CACHE1_64BIT_BAR_LOW),
>>               lower_32_bits(cache_addr));
>> @@ -1307,6 +1308,8 @@ static int vcn_v4_0_start_sriov(struct 
>> amdgpu_device *adev)
>>             cache_addr = adev->vcn.inst[i].gpu_addr + offset +
>>               AMDGPU_VCN_STACK_SIZE;
>> +        memset(adev->vcn.inst[i].cpu_addr + offset + 
>> AMDGPU_VCN_STACK_SIZE, 0,
>> +            AMDGPU_VCN_STACK_SIZE);
>>           MMSCH_V4_0_INSERT_DIRECT_WT(SOC15_REG_OFFSET(VCN, i,
>>               regUVD_LMI_VCPU_CACHE2_64BIT_BAR_LOW),
>>               lower_32_bits(cache_addr));
>
