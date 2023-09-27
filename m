Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E1D22E82CA5
	for <amd-gfx@archiver.kernel.org>; Wed, 27 Sep 2023 15:10:14 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 59E6510E06C;
	Wed, 27 Sep 2023 15:10:14 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on20614.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:fe5b::614])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6E6FF10E06C
 for <amd-gfx@lists.freedesktop.org>; Wed, 27 Sep 2023 15:10:11 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=b6kXY2y2HyhR1FeAfWKriXG2G0sgcmoSJwWYSGSQT8qFbWR6x6eYdh3CzLG5cHN5g1JSzi1iq5o1WF/lmDq5AMJAWVEaaLdBpiHC6RVkjAifQ7f+0oLE/tN4EsvIYpP+TtF5WsnLYHkKZ4n3pNTNbFRdzD7vNw1+DwI/yFYXdvIlJ2DarGCSGIzLUwNGwUqCNiJGDEsO7CwpxSg18pwBcojcdj1oczcMTbwtetjJ/r8Md5dcqFeV4tyOHm12KHC7zL4BlNqIARFM5Y9sXPdDXFJhotYvCujMTpTEs+lRE39FuF+C8MQ3nmQqslJXuHLbePy3+zCnOdhFfsDpXGy66A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=e1NFZs/bgIr+QE/eeQtdCL53FIaJe0MR3oV4Ti5ibBQ=;
 b=XsOPVV5lQMaQw+LXjSkvkEZLKOSGYNpmnmd3L48VR1Dmxy57lj/AJZ51uODdbyZRE6YoQ+I40hzPH9smu4HYANvQmx90TCc7QSjjcWV1c94960Tds1ot3iDAJBwObiXey6gpJI67+dZMwORwEVdqh5hJ1WJJ6fd6uWs0BkXf3Xekw/HlysdOTHiof2holJ0jxGxjLxobVXg/W4Bpmq4kh29CFzeLG8kx3Nxrlx4bgHJ6goaE/zaz1xwxOa36ZziWASv2j2pe4sCGBHEn8SN4Ui1DQ1/nh9f6wxFZ8++cmZpg57w595dMM6jPWNxc9rucCnr2mDmSdFnpyL4IZ1xjCw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=e1NFZs/bgIr+QE/eeQtdCL53FIaJe0MR3oV4Ti5ibBQ=;
 b=n7J+eE27DCSKO/OspiEuQfmpONYThgXLuX+tMuPGK05hFWMW3Khfis5SqAVkBkkxSqXdMeXt++7VYIN04OzmAkKW+uqoJ/Y5m5nxRObt4OBS8t/JvcGfNk1g/ln2VgbbvC8imcL1bqjYlEkkWSBVn388HKWjGDOVUr/NQ0mCq6E=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB2602.namprd12.prod.outlook.com (2603:10b6:5:4a::11) by
 IA0PR12MB7650.namprd12.prod.outlook.com (2603:10b6:208:436::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6768.33; Wed, 27 Sep
 2023 15:10:08 +0000
Received: from DM6PR12MB2602.namprd12.prod.outlook.com
 ([fe80::6c31:d0a6:fd35:a88f]) by DM6PR12MB2602.namprd12.prod.outlook.com
 ([fe80::6c31:d0a6:fd35:a88f%7]) with mapi id 15.20.6838.016; Wed, 27 Sep 2023
 15:10:07 +0000
Message-ID: <ebfb955d-3060-adaa-d526-b2bcb7fe5686@amd.com>
Date: Wed, 27 Sep 2023 10:10:04 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH] drm/amdkfd: Fix a race condition of vram buffer unref in
 svm code
Content-Language: en-US
To: Eric Huang <jinhuieric.huang@amd.com>, amd-gfx@lists.freedesktop.org
References: <20230927030008.278066-1-xiaogang.chen@amd.com>
 <101279ab-0c40-e169-e1b8-3a171d20bbb7@amd.com>
From: "Chen, Xiaogang" <xiaogang.chen@amd.com>
In-Reply-To: <101279ab-0c40-e169-e1b8-3a171d20bbb7@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BN6PR17CA0031.namprd17.prod.outlook.com
 (2603:10b6:405:75::20) To DM6PR12MB2602.namprd12.prod.outlook.com
 (2603:10b6:5:4a::11)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB2602:EE_|IA0PR12MB7650:EE_
X-MS-Office365-Filtering-Correlation-Id: f1b3fa0a-85e7-4a31-ce56-08dbbf6bd5e0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: J/gV8cDqoyjdR1PRapHoNPpE9EJaKpQWfTv/XdvyZRYUFPkkrIDv5ouAeFyEAplUZhieZQ3x+DLrr2zD6yl8lg93mgFamBLHc2Whb6bRWvx/D/njj4yOklclSvA/GTuU+YGx4ngkqN4I94ni8DfoWKhnK32otDvzxtWopMLdVfuKJtXPQgUFolhavS+jy+YXL/2Mj47DfE1zz1MAKrQZ1XbE8Rg53G+WBLCbevTIBNQMFpPD9zZPW//HkIspOaO0B9M77lNG2Nf1DxFYB/4DgtlYfehSn3mn7oYzf/6bF9ECE405m6401W5kUviKdrBLR2tUUoTxx0x/wdY9eyLSKr9uFnz4U5D34RnlZMFYJWNgvFgAHB0yoD8YtoJ70LLUxqj3RA61EcejhyZ+ad+EoC3jxXJJ+9hOSt3ugBYIjaVEYzVU93jI47Wd3c4Fo5y1Z28cZvBFVHWjshMqE6TfMBHwDEsPRWsi1EwyQi4ErjeC8er6J2IEGiyZqeNVYLP6TZBPj69rPLAkWiWHHw3At8ehf44H3XPgrqaL3RtvGfK9BbXffiq3UbWIoIoM00OCEy2eW/weOlQ6QtNhd0LjJwPNaOYTzP3cSN7ziakZT7iogwn0YwV5qnIQ9z91heLvmwaPKKeYcX/k3JafEapE9A==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB2602.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(39860400002)(136003)(396003)(346002)(366004)(376002)(230922051799003)(451199024)(1800799009)(186009)(83380400001)(31686004)(6506007)(6666004)(53546011)(478600001)(2616005)(6486002)(26005)(38100700002)(66946007)(6512007)(5660300002)(31696002)(41300700001)(36756003)(316002)(86362001)(8936002)(2906002)(66476007)(8676002)(66556008)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Zk1DNVVFcHFQalA1bDNEZ2M5K3NOYlpualdvNG9WYnY3QVFZUkkrYm9ZOGZ6?=
 =?utf-8?B?M1RDRHhkMzEzbWtBWGUwTkNoVFI5QmpscE0raDVCQ3dJQ0QvaWpLWDhNMzBh?=
 =?utf-8?B?ZVhFMmlIY00vbWVBWjliMWxWeVNFU1JkbnRQbGV3OVVXOUFyZXNGblhkQXRs?=
 =?utf-8?B?YTRVTjgzZDhrWHNwWDg2a2NYdG5zbDU1cVpMaHgvS1g5S3A0NmFHS0MzVWdj?=
 =?utf-8?B?c3JMaHJyek12T210bDE2Z2VHakg2WFdZYk01V1VWQ1lvSXU0eFcrNHhEU2lq?=
 =?utf-8?B?VWdxdjJSOEJZNUtBVVZnQVVJZ0dkbDN5NmJWbnJVSFJZY1d3Rjl2Nmd6LzF3?=
 =?utf-8?B?SWhBUTgxTlNNMllFZUxaVmhPNmJHc2JtSG1XcjAzTUx4WFZyeXNGTmtDMklN?=
 =?utf-8?B?ZmovVXpra3lObU1neEl0bkJXUmE0VURwL2VZWmV1M0ZaRHN3TjgzYjRtRlRP?=
 =?utf-8?B?TUZUWkh0ZHNNYUN3am5xRWdZdnFvQXc2TWs5MnZoT0hHT2NwZUpFb3A0cmVD?=
 =?utf-8?B?K2R4U00zYkFFa25rU2F2amFpOHMrenVMcW4yaTE1V3NCMEFNWE5adlF3c2lj?=
 =?utf-8?B?VTlwVFZSUDcrU3YwOFQ2eDlpS2R2bWQxWDJ4M1htZHFtVEFxNXpJL3VWUkRw?=
 =?utf-8?B?ZnhadEV6Y3ZSQUVoekpSbjEzRUs0K2RBRVFpc1B1VXF3Vm1TRXd2eDlkRnR1?=
 =?utf-8?B?aUFsZ2JLdFUrRWdTNzFUem5mY2xBOXlLRkZvM000RG1mbWhQS1ZianJacldm?=
 =?utf-8?B?aHNVSDVJMEVDM0tZQjUwVER4YUlGVDRLWVd3MU5mYklzSHFWdWY4WU9nVU9v?=
 =?utf-8?B?ZGNENjFIblprNk41Yi9BenBOSW5GUCtFNzY5K2xacVZIL0NCb2JrZEhGd01p?=
 =?utf-8?B?anYwQzRBVC9SNWIxdVFjbTVHdEYxVCs4YmZEREpJbndUdFFlRmhkazczSDF4?=
 =?utf-8?B?YVBVeENaNHVqbUJjd3ZCcDhmSEFPdGVMSWVUazhlOEJGK0ZudzFXZXRZTms4?=
 =?utf-8?B?UU9JcUk2RWhpYlZlL1BqS3c4Z0x5M0RzcjI0QVRGYjZGenorV0RHaVdUT1dw?=
 =?utf-8?B?SkRtUTZ0Vm8zNmNLbzY3UENHdHFPb3ZSQkYvSEM1TkFacFlmYlhUb2FOY01R?=
 =?utf-8?B?bElGeTlkako5bzFsanNzN1pkdldhTERhSTBONnEwVm9VYmVudVpPVExVeTVk?=
 =?utf-8?B?cXZZTFdBeGUydGN0YXY5UllHWWZNNXVGR0pYQ2V0cDdTeXFIdERueTMrZlR5?=
 =?utf-8?B?UEtQRDRzRWFrdjVqeXlncnVRb2t3R0Fucm1nNzFpZUxWZ2ZKQmNRdWhOMUlZ?=
 =?utf-8?B?Q3hrdyszTnl3dXBFVFhpQ2ZDM0tCZFY4eDhsdFN3aU1JNXRIVkZiOEt5M05C?=
 =?utf-8?B?d0FLSlJYdHFtdFNmVk1uMGFwU1hnbEZtY1pKU0FUNWJPdk5ORFc4cEtmWnRO?=
 =?utf-8?B?a1J3U0MrdkorbUlURE9qUnhBY1hBenZyVVQxaitpTkN3TmppSTJLV2x3Tytq?=
 =?utf-8?B?TjVnVlVpT0dZRFhxY1NLeHJ4ck1ySEU0QkRjZTdMMGNrRXdEY0R1Rk00UzdC?=
 =?utf-8?B?RmFTTUFxeFRXRlZyaUlQRkU2eVp4ZENOMHFuSmhCdy85MXkwQ2dRWTRHWElI?=
 =?utf-8?B?dHltVVFDL3krTmN2UmFjV1h1bk9PT1k3YlFlTUhVWjUxQkRGaEpSZGRJdExl?=
 =?utf-8?B?REZaV3FhVjZ2TkkwTWJHSVphTkhvbDE1aHJ5MEZFUWwzSTQyeStaR01OOUdJ?=
 =?utf-8?B?SldNSGsvbWV4eUNHeEcyRWE2dlN0OXNZYmxKdVgxdjVyd1FNN3hvNWI3Z2J0?=
 =?utf-8?B?a3IwQjdwTmlMK2lSeUFjY3dEZVNpRkNLM09kQjJQRjcrcTI4VE1BaExrb3FW?=
 =?utf-8?B?VmdWSGJ5S1ppK0JjZ0w3UWJYOVRlSnM1anZRU1dvNEMvYmhGRDhSSmhHOGJ5?=
 =?utf-8?B?NWlSSXNSbG1aWnhjY0lvdFUyRzhBeGkrREV0T3pCeklrZUwzTHlLQUxDT3Nm?=
 =?utf-8?B?QkptdUJFMkxnNWVGdExnWFd4TXpwTWZLUzI2VHlzYmVyZFdhR1IyRWpXZGxN?=
 =?utf-8?B?Sm40bTJhejhFYnRld3d5TGpYZm9JUFlEWjZYNG1yaDhHSXlDSERhOVRuTWs5?=
 =?utf-8?Q?zZnE=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f1b3fa0a-85e7-4a31-ce56-08dbbf6bd5e0
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB2602.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Sep 2023 15:10:07.7568 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: EadAvhhpq2TOvOSmSa7+IIv2x1bMxkSichVoxJmNjy9+YteHEYyOgGV2lg6zV5ZI
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
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>


On 9/27/2023 9:19 AM, Eric Huang wrote:
> Caution: This message originated from an External Source. Use proper 
> caution when opening attachments, clicking links, or responding.
>
>
> On 2023-09-26 23:00, Xiaogang.Chen wrote:
>> From: Xiaogang Chen <xiaogang.chen@amd.com>
>>
>> prange->svm_bo unref can happen in both mmu callback and a callback 
>> after
>> migrate to system ram. Both are async call in different tasks. Sync 
>> svm_bo
>> unref operation to avoid random "use-after-free".
>>
>> Signed-off-by: Xiaogang.Chen <Xiaogang.Chen@amd.com>
>> ---
>>   drivers/gpu/drm/amd/amdkfd/kfd_svm.c | 9 +++++++++
>>   1 file changed, 9 insertions(+)
>>
>> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c 
>> b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
>> index 70aa882636ab..8e246e848018 100644
>> --- a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
>> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
>> @@ -637,6 +637,15 @@ void svm_range_vram_node_free(struct svm_range 
>> *prange)
>>   {
>>       svm_range_bo_unref(prange->svm_bo);
>>       prange->ttm_res = NULL;
> Are above two lines not removed?

you are right, It was caused by copy-paste when edit. I tested it 
without these two lines. I will remove these two lines when send to gerrit.

Thanks

Xiaogang

>
> Regards,
> Eric
>> +     /* serialize prange->svm_bo unref */
>> +     mutex_lock(&prange->lock);
>> +     /* prange->svm_bo has not been unref */
>> +     if (prange->ttm_res) {
>> +             prange->ttm_res = NULL;
>> +             mutex_unlock(&prange->lock);
>> +             svm_range_bo_unref(prange->svm_bo);
>> +     } else
>> +             mutex_unlock(&prange->lock);
>>   }
>>
>>   struct kfd_node *
>
