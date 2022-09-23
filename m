Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3EC5AC6FA82
	for <amd-gfx@archiver.kernel.org>; Fri, 23 Sep 2022 10:12:53 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2998E10E80D;
	Fri, 23 Sep 2022 10:12:52 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2064.outbound.protection.outlook.com [40.107.92.64])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 01E5410E804
 for <amd-gfx@lists.freedesktop.org>; Fri, 23 Sep 2022 10:12:44 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fEs8G7DBWtpi8hBv680Mlqj2lzro1q6GpnExQO4UqYctcB9onBdoeH8AgTlhXCM7CgI0WpMPmtOB1T1uMOXRKIlZmyp/w1mw2+5Yzw1XksH2H9OBLQLGSP/VQ3eGFBytuRnlVcBNxL/f/4L64i9r820xX3Fa6+TNwkO+zkBl/JmwwOI9fYQpPbrt777Klt3KeXB0+eLjqJprE07Ygrkm3cQeSFhdQb5O4MnbLm+OggHpBKwZA+UpMP/evBlq8diWhJrZX0PMeKFCggY1hg1Myc41pPcfiP6c4TZyJNGBs+NSTH6LPgXbg890hzYwZ00zOtlhDilg/7myJYvMWjoWaQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hzlh6azeE2X2dWGNUauLAXkdbFF4t/oR1zcPXKf7CsE=;
 b=E/jdXh4YWk1vcNbdG9Gsr2vViWumAn8/bAFzmT3DmGpl3Y99FP1SrfVXsRv6uQAg1b/JcYasZYU1/Zd9+DUPGRPEpQj65zpdGFv0eTdgZymoEfcXMjXhCNJgZA7kGjYPYfpAqkIP8NuKHgOKJIdvAr7LIs+IDGSdauLRqoT2RtBfTtQpeR4667oTxVmAmRTLYX2NnNAQKs/cb0iuzVtcNKMOjS67qJzTNSXdyj92k4D9WLpiVjfqgcihhm1HDJ9ClTP+eJeBMBCFiWw28tiJadkXY/e+H9O3o8EP4ayvbdwfWj/nesxhBwA1h8WMjnJoee0iXEHARwXDbdpsN+2yxw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hzlh6azeE2X2dWGNUauLAXkdbFF4t/oR1zcPXKf7CsE=;
 b=a1BxTBe+0U60l1BfihdrA81/CVD5tXkibkoB9eD6yy7nnxfCDZV+jjLgQYH+8jKGBEWeviGZxwDMBEdD4F7q6bYBhNxCJeO/8+xdORGKCAo23QSCHMud4AmpKiSaoqBMzdo9zazfW0dp9E9wC/xjZuLBrbvX6NphVY/uoZmspug=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN8PR12MB3587.namprd12.prod.outlook.com (2603:10b6:408:43::13)
 by SA1PR12MB6773.namprd12.prod.outlook.com (2603:10b6:806:258::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5654.20; Fri, 23 Sep
 2022 10:12:40 +0000
Received: from BN8PR12MB3587.namprd12.prod.outlook.com
 ([fe80::653f:e59b:3f40:8fed]) by BN8PR12MB3587.namprd12.prod.outlook.com
 ([fe80::653f:e59b:3f40:8fed%6]) with mapi id 15.20.5654.020; Fri, 23 Sep 2022
 10:12:40 +0000
Message-ID: <af86b904-2966-5650-6bb2-ac3e0bd6bc31@amd.com>
Date: Fri, 23 Sep 2022 12:12:33 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH 4/5] drm/amdgpu: Implement OS triggered MCBP (v5)
Content-Language: en-US
To: "Zhu, Jiadong" <Jiadong.Zhu@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
References: <20220921094117.1071106-1-jiadong.zhu@amd.com>
 <20220921094117.1071106-4-jiadong.zhu@amd.com>
 <14ab09ae-0a80-1702-f446-4fc32681ff8c@amd.com>
 <DS7PR12MB63330816ABCBFBBF4A94C622F4519@DS7PR12MB6333.namprd12.prod.outlook.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
In-Reply-To: <DS7PR12MB63330816ABCBFBBF4A94C622F4519@DS7PR12MB6333.namprd12.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AM6PR02CA0005.eurprd02.prod.outlook.com
 (2603:10a6:20b:6e::18) To BN8PR12MB3587.namprd12.prod.outlook.com
 (2603:10b6:408:43::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8PR12MB3587:EE_|SA1PR12MB6773:EE_
X-MS-Office365-Filtering-Correlation-Id: fdcbafb5-cdf5-4712-a329-08da9d4c24d3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: g9Kc0x/EugA1CVKCD7IDKDrfqka7o+Lty6ATJ3Z0nfhXU9x0NXVxPM/JwQ1kDhxVRLXkj/IyJPrQqCj3kWeKSlKKh9IjVT90GpwzOIBjH22UFgH3tkZlRQSNRtOUgg2Q5jGBb6a1jYwRSjnZsMEVZb5GbJhMk34fEhFSq8ZCwafFMBkd3CEAFkLB2reyIZgtWAi1yy0E2ke4D3/oSHnrpRa03QSKQYZtWZRJsMnfcNE5Dmn0kekYpG/QPi7EtDYUXj7pxacoQZWqXcKXlbZ6HVu5L4X702KDcxsztcebzV/k7BaUYRogeJGb9YCdgof3MfuVmlK7+YCtktc75VRpB+VcUIbFhf0ANiOJdOkdTlKBsITQT9sxRU5eNnhLTquFtz8nlu8YAWSiQBuIUFs3DMiYMS2AW5FZmmNn/JtYiAaSJUdnW5JLuauCmP8p3XPgxrcaImOUvslDRQO7ErSMXS/Owr7ugM6HhppHoe06vQZm0jnae/dbRerSkAbpaDqlm1ylxwmeHadRqyow3rAxN63U7N3aS3dz8OXv+HYBzUw6RVlK3sc0SyV6JGS+VrjmUI9gEtwNxBacCVnnYCB8KkLFmXQSkKdKX63EN93ZkrqqjVNfjHCpy0CbZBpzcXioxTPnYg33Oqm8EnY1ppY47Zh+pebBXGa5Hc9URcSqGja0gxj+Lx0CbRzPFxV7oraGlKERUWpPuj0W1GdtrJNPmHBLrtE4c18Iet8ulfQ8CJwKY0XwAjP3ENCT1JuSQztfQkC3QueRgYIp6+AiP4x6tXA7vqb6zSOYYePDIwnPGO0=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN8PR12MB3587.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230022)(4636009)(39860400002)(136003)(376002)(346002)(396003)(366004)(451199015)(4326008)(8676002)(66946007)(66899012)(41300700001)(66476007)(66556008)(6512007)(6666004)(8936002)(54906003)(38100700002)(5660300002)(110136005)(186003)(6506007)(478600001)(31696002)(6486002)(2906002)(36756003)(83380400001)(30864003)(2616005)(316002)(31686004)(86362001)(53546011)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?aklHNDFFRkJSSkpnSWVEK0Q4TnIrT2Exa1hEdDFXU3U1YTJWcXJQb0NSR2VT?=
 =?utf-8?B?TkxzeHBabVhMRjNWZWtmcDBhK3NkZTBJZHA3RWpOc29sMzlPU1I2aXozUkU1?=
 =?utf-8?B?dEo5Q3E5MEJIOFNYVlM5TG9Rdk9hbVVmOUt1WHk2UUxjd2RSUmE0ZVg3bXJU?=
 =?utf-8?B?QngzbkdDd2JkWnJhTTdrcHRHVzlZbTJER01SL1hjRUtOVFBTMGlGc00xVEt3?=
 =?utf-8?B?UzNRakNyVDZhV0JMaDF3L2plMGxWZlRpcXRLQ3RkV3UzbmFFSDk2TFpsc2Na?=
 =?utf-8?B?bWVlcUpHMzkwQVJuRG1rK3o4eXEzdzZ0dG5pUStKYk1VcWF5bE10VzMwdDZ1?=
 =?utf-8?B?N21SSlFVNkl2WXdreHFCbkoxeGpTcmtqSnhCNHJCcVU5T0R2QWkwcHNmUkZW?=
 =?utf-8?B?dloySkpFR2JoekdUdllVWnJ2TWtMeTdXRWN1UHJoOEYyU2NoRGVxMlc4bHZI?=
 =?utf-8?B?b1NkREdOOWVRZHpFY3hjTWVZcEh4ZXdRa1k4VUxqbmcyRXJKWHlmY1hqQXVZ?=
 =?utf-8?B?UWtMOWxqd1FaZEJFNjZ2M2E2dUdVUGxtWFhhaFRqc3RLemtlcHd5WHlRNGsy?=
 =?utf-8?B?c29idVVwZm4rUmd4UFpRRkVEbk5tYzNRT0ptdFg5R1djM28yTjBrK25qcEZl?=
 =?utf-8?B?NzI4bzIwUDQwemRYMHp1L0d1MGMyY0pHQmFsWmd6RkpnaS9pZ1JWck41Z3Jr?=
 =?utf-8?B?VlRvL0lzUVVDb2ZTbmxjT3JFSExobldMYzludHFqWVlDa1VEMjBqVUcyZnd5?=
 =?utf-8?B?SC84NnFRRnBUOFAwSkJIcTNTTDE3Y1Q0VmpuY3JaTjVGVExJN0VDVHozMyts?=
 =?utf-8?B?b0VhYU1rSW12amJOdExXQ0tISDdJYmxsK2tZOHRoMkk4dUwvSEN6Q2pZMjRh?=
 =?utf-8?B?UG95azFMY3k1S0xkKy9sd0hQZXZmR1VZVkgvUFoyR2t1MEZJTndTamFlSTVO?=
 =?utf-8?B?L2pRTEhjVG1rS0gyQWwzRnFkZGFWMzFiYUNFWHBtS0hJbzZTQ3RiTDJiMU1q?=
 =?utf-8?B?WlpYZ2xMZ3RNbEtjMktYS2o4ZFRrQ29wZ1RBUXB4NEwyRWFQb25XT2pLTnQ5?=
 =?utf-8?B?b3BiaTM2UllObXV4elFIaHVJR3JURHh1RklmQ0crYU9OSGIwOGp3VHVmSyts?=
 =?utf-8?B?R0tycjIwb0lhL2JyNU04dHc4Nm1jMEhvT1I0M1laaE9tQ2I0K2E4Ly9mUzdp?=
 =?utf-8?B?T2h4dUlsTG9ISnREdUVnaUJRSENoTDRwNjlXRFdPbDhHanJzcnFsSk8zQ2xY?=
 =?utf-8?B?bGRFUFJEWFEvTVlXT3RsS29PWUVuSzF1bzFaMW1RRzFuSjZjaTY0VUhzVlVU?=
 =?utf-8?B?VmZaNDNodTdoVk56ZHA2OHBCcXVUQitaRTBzaDlEV1YwZjl3T3F6ZG9SUWpL?=
 =?utf-8?B?TUhYWGoyV3o2TWJUQmtUUWdIazJrODVUdFpneE53WERZWVZ4eFBtMnJ5YU83?=
 =?utf-8?B?MTBPSTRGK2NCNkZoVCtnNUZtcHQ2SEkvWVhTc0cvM3FFS0oyRi9iTndoallu?=
 =?utf-8?B?aTZGMUZKNkFFWWFVeDFUUTVBeFpmQlRJNU1IVXowK1pOdXcxc3BlN1VQOFFN?=
 =?utf-8?B?a24vWXN6V1hoUEJ1cUpvaEU3SWNIMVIrUjFlTGRpcGlNWmgxbmhjUERpUGNz?=
 =?utf-8?B?SGtYS0c4OVJpZUVGU3NWemVnMHRXVUtrWlBkTEhYdVJ1K3FKSHlOQ0JINEs2?=
 =?utf-8?B?dURBZTJ4ZGJnNXFzdEVLTVhzZ1M1L0twcmpsbEcwendQclJlbmVKTWxvYjNU?=
 =?utf-8?B?eVBORFNKeGhBNHdBRWhvZUR4UTBWVE9ibzdRSC9LVFNqN3p5L2lFS0JHUE5i?=
 =?utf-8?B?eHJDK0gxWnAvelVMYUE1ZXJSbElrZ0UxYjB1N3RaRHY1VGx5L1NZT2Fod3lB?=
 =?utf-8?B?NEY1K0RpczVJaDBWODkvQUJGaFlrRm9jQjR1WDh5UWVId01MSWx1Vm81b1hY?=
 =?utf-8?B?YWNMK00zMHU1eDlwT01VT2gyZS9EQ3FjM01PcHR1ZUpyb1M2N3RPNVNJR3ZU?=
 =?utf-8?B?UDduNG8raUR4MlVSTE5UNGVRYmcvbjBzZThrQ1NRS2w1NHhTRWFkT1BNdHR5?=
 =?utf-8?B?aXVqdjVOVlQwVTg3cXNud3F0b0lVanFFMmgwYzZTT3pUY1BVWmcwMlpKRmp1?=
 =?utf-8?B?bGF6amxYTzZrcE90UkhXQzdyUUNSbGwwZ3I4UFFBUzI5TW5sZGdXeTdaWnhE?=
 =?utf-8?Q?DJ+055wdCG4IFatyWCRTB7Pt0vxgygHBf3o/eORdRYKZ?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fdcbafb5-cdf5-4712-a329-08da9d4c24d3
X-MS-Exchange-CrossTenant-AuthSource: BN8PR12MB3587.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Sep 2022 10:12:39.9301 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SI2jGdVzR7RNpHARgIk803/69HGgd3FbLbkL8dO9CvYaQ+OKB5m8JIErcvhMYXe/
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB6773
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
Cc: "Grodzovsky, Andrey" <Andrey.Grodzovsky@amd.com>, "Tuikov,
 Luben" <Luben.Tuikov@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Am 23.09.22 um 11:24 schrieb Zhu, Jiadong:
> [AMD Official Use Only - General]
>
> Inlined.
>
> Thanks,
> Jiadong
>
> -----Original Message-----
> From: Koenig, Christian <Christian.Koenig@amd.com>
> Sent: Wednesday, September 21, 2022 9:01 PM
> To: Zhu, Jiadong <Jiadong.Zhu@amd.com>; amd-gfx@lists.freedesktop.org
> Cc: Tuikov, Luben <Luben.Tuikov@amd.com>; Grodzovsky, Andrey <Andrey.Grodzovsky@amd.com>
> Subject: Re: [PATCH 4/5] drm/amdgpu: Implement OS triggered MCBP (v5)
>
> Am 21.09.22 um 11:41 schrieb jiadong.zhu@amd.com:
>> From: "Jiadong.Zhu" <Jiadong.Zhu@amd.com>
>>
>> Trigger Mid-Command Buffer Preemption according to the priority of the
>> software rings and the hw fence signalling condition.
>>
>> The muxer saves the locations of the indirect buffer frames from the
>> software ring together with the fence sequence number in its fifo
>> queue, and pops out those records when the fences are signalled. The
>> locations are used to resubmit packages in preemption scenarios by coping the chunks from the software ring.
> Maybe change the subject a bit. The MCBP is not really triggered by the core Linux kernel.
>
> Maybe write instead "MCBP based on DRM scheduler".
>
>> v2: Update comment style.
>> v3: Fix conflict caused by previous modifications.
>> v4: Remove unnecessary prints.
>> v5: Fix corner cases for resubmission cases.
>>
>> Cc: Christian Koenig <Christian.Koenig@amd.com>
>> Cc: Luben Tuikov <Luben.Tuikov@amd.com>
>> Cc: Andrey Grodzovsky <Andrey.Grodzovsky@amd.com>
>> Acked-by: Luben Tuikov <luben.tuikov@amd.com>
>> Signed-off-by: Jiadong.Zhu <Jiadong.Zhu@amd.com>
>> ---
>>    drivers/gpu/drm/amd/amdgpu/Makefile          |   2 +-
>>    drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c       |   2 +
>>    drivers/gpu/drm/amd/amdgpu/amdgpu_mcbp.c     |  91 +++++++++
>>    drivers/gpu/drm/amd/amdgpu/amdgpu_mcbp.h     |  29 +++
>>    drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c     |  12 ++
>>    drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h     |   3 +
>>    drivers/gpu/drm/amd/amdgpu/amdgpu_ring_mux.c | 186 ++++++++++++++++++-
>>    drivers/gpu/drm/amd/amdgpu/amdgpu_ring_mux.h |  24 +++
>>    drivers/gpu/drm/amd/amdgpu/amdgpu_sw_ring.c  |  27 +++
>>    drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c       |   2 +
>>    10 files changed, 372 insertions(+), 6 deletions(-)
>>    create mode 100644 drivers/gpu/drm/amd/amdgpu/amdgpu_mcbp.c
>>    create mode 100644 drivers/gpu/drm/amd/amdgpu/amdgpu_mcbp.h
>>
>> diff --git a/drivers/gpu/drm/amd/amdgpu/Makefile
>> b/drivers/gpu/drm/amd/amdgpu/Makefile
>> index 85224bc81ce5..24c5aa19bbf2 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/Makefile
>> +++ b/drivers/gpu/drm/amd/amdgpu/Makefile
>> @@ -59,7 +59,7 @@ amdgpu-y += amdgpu_device.o amdgpu_kms.o \
>>        amdgpu_umc.o smu_v11_0_i2c.o amdgpu_fru_eeprom.o amdgpu_rap.o \
>>        amdgpu_fw_attestation.o amdgpu_securedisplay.o \
>>        amdgpu_eeprom.o amdgpu_mca.o amdgpu_psp_ta.o amdgpu_lsdma.o \
>> -     amdgpu_sw_ring.o amdgpu_ring_mux.o
>> +     amdgpu_sw_ring.o amdgpu_ring_mux.o amdgpu_mcbp.o
> This functionality is spread over to many files. Probably better to move this into the amdgpu_ring_mux.c as well.
>
>>    amdgpu-$(CONFIG_PROC_FS) += amdgpu_fdinfo.o
>>
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c
>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c
>> index 258cffe3c06a..af86d87e2f3b 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c
>> @@ -211,6 +211,7 @@ int amdgpu_ib_schedule(struct amdgpu_ring *ring, unsigned num_ibs,
>>                }
>>        }
>>
>> +     amdgpu_ring_ib_begin(ring);
>>        if (job && ring->funcs->init_cond_exec)
>>                patch_offset = amdgpu_ring_init_cond_exec(ring);
>>
>> @@ -285,6 +286,7 @@ int amdgpu_ib_schedule(struct amdgpu_ring *ring, unsigned num_ibs,
>>            ring->hw_prio == AMDGPU_GFX_PIPE_PRIO_HIGH)
>>                ring->funcs->emit_wave_limit(ring, false);
>>
>> +     amdgpu_ring_ib_end(ring);
>>        amdgpu_ring_commit(ring);
>>        return 0;
>>    }
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_mcbp.c
>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_mcbp.c
>> new file mode 100644
>> index 000000000000..121b1a4e0f04
>> --- /dev/null
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_mcbp.c
>> @@ -0,0 +1,91 @@
>> +/*
>> + * Copyright 2022 Advanced Micro Devices, Inc.
>> + *
>> + * Permission is hereby granted, free of charge, to any person
>> +obtaining a
>> + * copy of this software and associated documentation files (the
>> +"Software"),
>> + * to deal in the Software without restriction, including without
>> +limitation
>> + * the rights to use, copy, modify, merge, publish, distribute,
>> +sublicense,
>> + * and/or sell copies of the Software, and to permit persons to whom
>> +the
>> + * Software is furnished to do so, subject to the following conditions:
>> + *
>> + * The above copyright notice and this permission notice shall be
>> +included in
>> + * all copies or substantial portions of the Software.
>> + *
>> + * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
>> +EXPRESS OR
>> + * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
>> +MERCHANTABILITY,
>> + * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.  IN NO EVENT
>> +SHALL
>> + * THE COPYRIGHT HOLDER(S) OR AUTHOR(S) BE LIABLE FOR ANY CLAIM,
>> +DAMAGES OR
>> + * OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR
>> +OTHERWISE,
>> + * ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE
>> +OR
>> + * OTHER DEALINGS IN THE SOFTWARE.
>> + *
>> + */
>> +
>> +#include <linux/delay.h>
>> +#include <linux/kernel.h>
>> +#include <linux/firmware.h>
>> +#include <linux/module.h>
>> +#include <linux/pci.h>
>> +#include <drm/gpu_scheduler.h>
>> +
>> +#include "amdgpu.h"
>> +#include "amdgpu_mcbp.h"
>> +#include "amdgpu_ring.h"
>> +
>> +/* Trigger Mid-Command Buffer Preemption (MCBP) and find if we need
>> +to resubmit. */ int amdgpu_mcbp_trigger_preempt(struct
>> +amdgpu_ring_mux *mux) {
>> +     struct amdgpu_mux_entry *e;
>> +     struct amdgpu_ring *ring = NULL;
>> +     int i;
>> +
>> +     spin_lock(&mux->lock);
>> +
>> +     amdgpu_ring_preempt_ib(mux->real_ring);
>> +
>> +     for (i = 0; i < mux->num_ring_entries; i++) {
>> +             e = &mux->ring_entry[i];
>> +             if (e->ring->hw_prio <= AMDGPU_RING_PRIO_DEFAULT) {
>> +                     ring = e->ring;
>> +                     break;
>> +             }
>> +     }
>> +
>> +     if (!ring) {
>> +             DRM_ERROR("cannot find low priority ring\n");
>> +             spin_unlock(&mux->lock);
>> +             return -ENOENT;
>> +     }
>> +
>> +     amdgpu_fence_process(ring);
>> That's usually and extremely bad idea since fence processing should only be kicked of from the interrupt handler.
>> Otherwise you have interrupt handler and this thread here racing to signaling fences.
> We have to block low priority ibs copied to the real ring and check the seq no signaled here.
> I will refactor to use the trailing fence irq to handle this.
>
>> +
>> +     if (atomic_read(&ring->fence_drv.last_seq) !=
>> +         ring->fence_drv.sync_seq) {
>> +             mux->s_resubmit = true;
>> +             mux->seq_no_resubmit = ring->fence_drv.sync_seq;
>> Don't touch any fence handling internals here. If you need to know which fences are signaled and which aren't look into amdgpu_fence.c
> I would use amdgpu_fence_count_emitted in irq hander to meet this.
>
>
>> +             amdgpu_ring_mux_schedule_resubmit(mux);
>> +     }
>> +
>> +     spin_unlock(&mux->lock);
>> +     return 0;
>> +}
>> +
>> +/*scan on low prio rings to have unsignaled fence and high ring has
>> +no fence.*/
> What exactly should that comment mean?
>
>> +int amdgpu_mcbp_scan(struct amdgpu_ring_mux *mux) {
>> +     struct amdgpu_ring *ring;
>> +     uint32_t seq, last_seq;
>> +     int i, need_preempt;
>> +
>> +     need_preempt = 0;
>> +     for (i = 0; i < mux->num_ring_entries; i++) {
>> +             ring = mux->ring_entry[i].ring;
>> +             last_seq = atomic_read(&ring->fence_drv.last_seq);
>> +             seq = READ_ONCE(ring->fence_drv.sync_seq);
>> +             if (ring->hw_prio > AMDGPU_RING_PRIO_DEFAULT && last_seq < seq)
>> +                     return 0;
>> +             if (ring->hw_prio <= AMDGPU_RING_PRIO_DEFAULT && last_seq < seq)
>> +                     need_preempt = 1;
>> +     }
>> +     return need_preempt && !mux->s_resubmit;
>> Well what exactly are you trying to do here? Finding if a lower priority ring has unsignaled fences?
> Yes, we are peeking the fence_drv data at the time high priority ibs are going to emit. The result is not necessarily accurate because we would check the fence after preemption complete.

Please use amdgpu_fence_count_emitted() for this instead.

Also what is the check of s_resubmit state good for here?

Regards,
Christian.

>
> Regards,
> Christian.
>
>> +}
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_mcbp.h
>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_mcbp.h
>> new file mode 100644
>> index 000000000000..0033bcba8d03
>> --- /dev/null
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_mcbp.h
>> @@ -0,0 +1,29 @@
>> +/*
>> + * Copyright 2022 Advanced Micro Devices, Inc.
>> + *
>> + * Permission is hereby granted, free of charge, to any person
>> +obtaining a
>> + * copy of this software and associated documentation files (the
>> +"Software"),
>> + * to deal in the Software without restriction, including without
>> +limitation
>> + * the rights to use, copy, modify, merge, publish, distribute,
>> +sublicense,
>> + * and/or sell copies of the Software, and to permit persons to whom
>> +the
>> + * Software is furnished to do so, subject to the following conditions:
>> + *
>> + * The above copyright notice and this permission notice shall be
>> +included in
>> + * all copies or substantial portions of the Software.
>> + *
>> + * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
>> +EXPRESS OR
>> + * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
>> +MERCHANTABILITY,
>> + * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.  IN NO EVENT
>> +SHALL
>> + * THE COPYRIGHT HOLDER(S) OR AUTHOR(S) BE LIABLE FOR ANY CLAIM,
>> +DAMAGES OR
>> + * OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR
>> +OTHERWISE,
>> + * ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE
>> +OR
>> + * OTHER DEALINGS IN THE SOFTWARE.
>> + *
>> + */
>> +
>> +#ifndef __AMDGPU_MCBP_H__
>> +#define __AMDGPU_MCBP_H__
>> +
>> +int amdgpu_mcbp_trigger_preempt(struct amdgpu_ring_mux *mux); int
>> +amdgpu_mcbp_scan(struct amdgpu_ring_mux *mux); #endif
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c
>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c
>> index 4eaf3bd332f7..94362c39b73e 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c
>> @@ -574,3 +574,15 @@ int amdgpu_ring_init_mqd(struct amdgpu_ring
>> *ring)
>>
>>        return mqd_mgr->init_mqd(adev, ring->mqd_ptr, &prop);
>>    }
>> +
>> +void amdgpu_ring_ib_begin(struct amdgpu_ring *ring) {
>> +     if (ring->is_sw_ring)
>> +             amdgpu_sw_ring_ib_begin(ring);
>> +}
>> +
>> +void amdgpu_ring_ib_end(struct amdgpu_ring *ring) {
>> +     if (ring->is_sw_ring)
>> +             amdgpu_sw_ring_ib_end(ring);
>> +}
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
>> index aeb48cc3666c..36726c28a806 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
>> @@ -312,6 +312,9 @@ struct amdgpu_ring {
>>    #define amdgpu_ring_preempt_ib(r) (r)->funcs->preempt_ib(r)
>>
>>    int amdgpu_ring_alloc(struct amdgpu_ring *ring, unsigned ndw);
>> +void amdgpu_ring_ib_begin(struct amdgpu_ring *ring); void
>> +amdgpu_ring_ib_end(struct amdgpu_ring *ring);
>> +
>>    void amdgpu_ring_insert_nop(struct amdgpu_ring *ring, uint32_t count);
>>    void amdgpu_ring_generic_pad_ib(struct amdgpu_ring *ring, struct amdgpu_ib *ib);
>>    void amdgpu_ring_commit(struct amdgpu_ring *ring); diff --git
>> a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring_mux.c
>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring_mux.c
>> index d6b30db27104..70dd725432d4 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring_mux.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring_mux.c
>> @@ -24,30 +24,59 @@
>>    #include <drm/drm_print.h>
>>
>>    #include "amdgpu_ring_mux.h"
>> +#include "amdgpu_mcbp.h"
>>    #include "amdgpu_ring.h"
>>
>>    #define AMDGPU_MUX_RESUBMIT_JIFFIES_TIMEOUT (HZ / 2)
>>
>> +static struct kmem_cache *amdgpu_mux_chunk_slab;
>> +
>>    static void copy_pkt_from_sw_ring(struct amdgpu_ring_mux *mux, struct amdgpu_ring *ring,
>>                                  u64 s_start, u64 s_end);
>> +static void amdgpu_mux_resubmit_chunks(struct amdgpu_ring_mux *mux,
>> +bool is_fallback); static void amdgpu_mux_resubmit_fallback(struct
>> +timer_list *t);
>>
>>    int amdgpu_ring_mux_init(struct amdgpu_ring_mux *mux, struct amdgpu_ring *ring,
>>                         unsigned int entry_size)
>>    {
>>        mux->real_ring = ring;
>>        mux->num_ring_entries = 0;
>> +
>>        mux->ring_entry = kcalloc(entry_size, sizeof(struct amdgpu_mux_entry), GFP_KERNEL);
>>        if (!mux->ring_entry)
>>                return -ENOMEM;
>>
>>        mux->ring_entry_size = entry_size;
>> +     mux->s_resubmit = false;
>> +
>> +     amdgpu_mux_chunk_slab = kmem_cache_create("amdgpu_mux_chunk",
>> +                                               sizeof(struct amdgpu_mux_chunk), 0,
>> +                                               SLAB_HWCACHE_ALIGN, NULL);
>> +     if (!amdgpu_mux_chunk_slab) {
>> +             DRM_ERROR("create amdgpu_mux_chunk cache failed\n");
>> +             return -ENOMEM;
>> +     }
>> +
>>        spin_lock_init(&mux->lock);
>> +     timer_setup(&mux->resubmit_timer, amdgpu_mux_resubmit_fallback, 0);
>>
>>        return 0;
>>    }
>>
>>    void amdgpu_ring_mux_fini(struct amdgpu_ring_mux *mux)
>>    {
>> +     struct amdgpu_mux_entry *e;
>> +     struct amdgpu_mux_chunk *chunk, *chunk2;
>> +     int i;
>> +
>> +     for (i = 0; i < mux->num_ring_entries; i++) {
>> +             e = &mux->ring_entry[i];
>> +             list_for_each_entry_safe(chunk, chunk2, &e->list, entry) {
>> +                     list_del(&chunk->entry);
>> +                     kmem_cache_free(amdgpu_mux_chunk_slab, chunk);
>> +             }
>> +     }
>> +     kmem_cache_destroy(amdgpu_mux_chunk_slab);
>>        kfree(mux->ring_entry);
>>        mux->ring_entry = NULL;
>>        mux->num_ring_entries = 0;
>> @@ -67,6 +96,7 @@ int amdgpu_ring_mux_add_sw_ring(struct amdgpu_ring_mux *mux, struct amdgpu_ring
>>        ring->entry_index = mux->num_ring_entries;
>>        e->ring = ring;
>>
>> +     INIT_LIST_HEAD(&e->list);
>>        mux->num_ring_entries += 1;
>>        return 0;
>>    }
>> @@ -82,6 +112,9 @@ void amdgpu_ring_set_wptr_to_mux(struct amdgpu_ring_mux *mux, struct amdgpu_ring
>>    {
>>        struct amdgpu_mux_entry *e;
>>
>> +     if (ring->hw_prio <= AMDGPU_RING_PRIO_DEFAULT)
>> +             amdgpu_mux_resubmit_chunks(mux, false);
>> +
>>        e = amdgpu_get_sw_entry(mux, ring);
>>        if (!e) {
>>                DRM_ERROR("cannot find entry for sw ring\n"); @@ -90,13 +123,19 @@
>> void amdgpu_ring_set_wptr_to_mux(struct amdgpu_ring_mux *mux, struct
>> amdgpu_ring
>>
>>        spin_lock(&mux->lock);
>>        e->sw_cptr = e->sw_wptr;
>> +     if (ring->hw_prio <= AMDGPU_RING_PRIO_DEFAULT && e->sw_cptr < mux->wptr_resubmit)
>> +             e->sw_cptr = mux->wptr_resubmit;
>>        e->sw_wptr = wptr;
>>        e->start_ptr_in_hw_ring = mux->real_ring->wptr;
>>
>> -     copy_pkt_from_sw_ring(mux, ring, e->sw_cptr, wptr);
>> -     e->end_ptr_in_hw_ring = mux->real_ring->wptr;
>> -     amdgpu_ring_commit(mux->real_ring);
>> -
>> +     /* donnot copy the ibs which have been resubmitted*/
>> +     if (ring->hw_prio > AMDGPU_RING_PRIO_DEFAULT || mux->wptr_resubmit < wptr) {
>> +             copy_pkt_from_sw_ring(mux, ring, e->sw_cptr, wptr);
>> +             e->end_ptr_in_hw_ring = mux->real_ring->wptr;
>> +             amdgpu_ring_commit(mux->real_ring);
>> +     } else {
>> +             e->end_ptr_in_hw_ring = mux->real_ring->wptr;
>> +     }
>>        spin_unlock(&mux->lock);
>>    }
>>
>> @@ -159,7 +198,7 @@ u64 amdgpu_ring_get_rptr_from_mux(struct amdgpu_ring_mux *mux, struct amdgpu_rin
>>        return e->sw_rptr;
>>    }
>>
>> -/* copy packages on sw ring range[begin, end) */
>> +/* copy packages on sw ring range[start, end) */
>>    static void copy_pkt_from_sw_ring(struct amdgpu_ring_mux *mux, struct amdgpu_ring *ring,
>>                                  u64 s_start, u64 s_end)
>>    {
>> @@ -183,3 +222,140 @@ static void copy_pkt_from_sw_ring(struct amdgpu_ring_mux *mux, struct amdgpu_rin
>>                amdgpu_ring_write_multiple(real_ring, (void *)&ring->ring[start], end - start);
>>        }
>>    }
>> +
>> +void amdgpu_ring_mux_schedule_resubmit(struct amdgpu_ring_mux *mux) {
>> +     mod_timer(&mux->resubmit_timer, jiffies +
>> +AMDGPU_MUX_RESUBMIT_JIFFIES_TIMEOUT);
>> +}
>> +
>> +void amdgpu_ring_mux_start_ib(struct amdgpu_ring_mux *mux, struct
>> +amdgpu_ring *ring) {
>> +     struct amdgpu_mux_entry *e;
>> +     struct amdgpu_mux_chunk *chunk;
>> +
>> +     amdgpu_mux_resubmit_chunks(mux, false);
>> +
>> +     e = amdgpu_get_sw_entry(mux, ring);
>> +     if (!e) {
>> +             DRM_ERROR("cannot find entry!\n");
>> +             return;
>> +     }
>> +
>> +     chunk = kmem_cache_alloc(amdgpu_mux_chunk_slab, GFP_KERNEL);
>> +     if (!chunk) {
>> +             DRM_ERROR("alloc amdgpu_mux_chunk_slab failed\n");
>> +             return;
>> +     }
>> +
>> +     chunk->start = ring->wptr;
>> +     list_add_tail(&chunk->entry, &e->list); }
>> +
>> +static void scan_and_remove_signaled_chunk(struct amdgpu_ring_mux
>> +*mux, struct amdgpu_ring *ring) {
>> +     uint32_t last_seq, size = 0;
>> +     struct amdgpu_mux_entry *e;
>> +     struct amdgpu_mux_chunk *chunk, *tmp;
>> +
>> +     e = amdgpu_get_sw_entry(mux, ring);
>> +     if (!e) {
>> +             DRM_ERROR("cannot find entry!\n");
>> +             return;
>> +     }
>> +
>> +     last_seq = atomic_read(&ring->fence_drv.last_seq);
>> +
>> +     list_for_each_entry_safe(chunk, tmp, &e->list, entry) {
>> +             if (chunk->sync_seq <= last_seq) {
>> +                     list_del(&chunk->entry);
>> +                     kmem_cache_free(amdgpu_mux_chunk_slab, chunk);
>> +             } else {
>> +                     size++;
>> +             }
>> +     }
>> +}
>> +
>> +void amdgpu_ring_mux_end_ib(struct amdgpu_ring_mux *mux, struct
>> +amdgpu_ring *ring) {
>> +     struct amdgpu_mux_entry *e;
>> +     struct amdgpu_mux_chunk *chunk;
>> +
>> +     e = amdgpu_get_sw_entry(mux, ring);
>> +     if (!e) {
>> +             DRM_ERROR("cannot find entry!\n");
>> +             return;
>> +     }
>> +
>> +     chunk = list_last_entry(&e->list, struct amdgpu_mux_chunk, entry);
>> +     if (!chunk) {
>> +             DRM_ERROR("cannot find chunk!\n");
>> +             return;
>> +     }
>> +
>> +     chunk->end = ring->wptr;
>> +     chunk->sync_seq = READ_ONCE(ring->fence_drv.sync_seq);
>> +
>> +     scan_and_remove_signaled_chunk(mux, ring); }
>> +
>> +static void amdgpu_mux_resubmit_chunks(struct amdgpu_ring_mux *mux,
>> +bool is_fallback) {
>> +     struct amdgpu_mux_entry *e = NULL;
>> +     struct amdgpu_mux_chunk *chunk;
>> +     uint32_t seq, last_seq;
>> +     int i;
>> +
>> +     if (is_fallback) {
>> +             if (!spin_trylock(&mux->lock)) {
>> +                     amdgpu_ring_mux_schedule_resubmit(mux);
>> +                     DRM_ERROR("reschedule resubmit\n");
>> +                     return;
>> +             }
>> +     } else {
>> +             spin_lock(&mux->lock);
>> +     }
>> +
>> +     /*find low priority entries:*/
>> +     if (!mux->s_resubmit) {
>> +             spin_unlock(&mux->lock);
>> +             return;
>> +     }
>> +
>> +     for (i = 0; i < mux->num_ring_entries; i++) {
>> +             if (mux->ring_entry[i].ring->hw_prio <= AMDGPU_RING_PRIO_DEFAULT) {
>> +                     e = &mux->ring_entry[i];
>> +                     break;
>> +             }
>> +     }
>> +
>> +     if (!e) {
>> +             DRM_ERROR("%s no low priority ring found\n", __func__);
>> +             spin_unlock(&mux->lock);
>> +             return;
>> +     }
>> +
>> +     last_seq = atomic_read(&e->ring->fence_drv.last_seq);
>> +     seq = mux->seq_no_resubmit;
>> +     if (last_seq < seq) {
>> +             /*resubmit all the fences between (last_seq, seq]*/
>> +             list_for_each_entry(chunk, &e->list, entry) {
>> +                     if (chunk->sync_seq > last_seq && chunk->sync_seq <= seq) {
>> +                             copy_pkt_from_sw_ring(mux, e->ring, chunk->start, chunk->end);
>> +                             mux->wptr_resubmit = chunk->end;
>> +                             amdgpu_ring_commit(mux->real_ring);
>> +                     }
>> +             }
>> +     }
>> +
>> +     del_timer(&mux->resubmit_timer);
>> +     mux->s_resubmit = false;
>> +     spin_unlock(&mux->lock);
>> +}
>> +
>> +static void amdgpu_mux_resubmit_fallback(struct timer_list *t) {
>> +     struct amdgpu_ring_mux *mux = from_timer(mux, t, resubmit_timer);
>> +
>> +     DRM_INFO("calling %s\n", __func__);
>> +     amdgpu_mux_resubmit_chunks(mux, true); }
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring_mux.h
>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring_mux.h
>> index e8ee34e6b9a5..f6fc0afa3cc7 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring_mux.h
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring_mux.h
>> @@ -35,6 +35,7 @@ struct amdgpu_ring;
>>     * sw_cptr -- the position of the copy pointer in the sw ring
>>     * sw_rptr -- the read pointer in software ring
>>     * sw_wptr -- the write pointer in software ring
>> + * list -- list head for amdgpu_mux_chunk
>>     */
>>    struct amdgpu_mux_entry {
>>        struct                  amdgpu_ring *ring;
>> @@ -43,6 +44,7 @@ struct amdgpu_mux_entry {
>>        u64                     sw_cptr;
>>        u64                     sw_rptr;
>>        u64                     sw_wptr;
>> +     struct list_head        list;
>>    };
>>
>>    struct amdgpu_ring_mux {
>> @@ -53,6 +55,24 @@ struct amdgpu_ring_mux {
>>        unsigned int            ring_entry_size;
>>        /*the lock for copy data from different software rings*/
>>        spinlock_t              lock;
>> +     bool                    s_resubmit;
>> +     uint32_t                seq_no_resubmit;
>> +     u64                     wptr_resubmit;
>> +     struct timer_list       resubmit_timer;
>> +};
>> +
>> +/*
>> + * amdgpu_munx_chunk -- save the location of indirect buffer's
>> +package on softare rings
>> + * entry -- the list entry.
>> + * sync_seq -- the fence seqno related with the saved IB.
>> + * start -- start location on the software ring.
>> + * end -- end location on the software ring.
>> + */
>> +struct amdgpu_mux_chunk {
>> +     struct list_head        entry;
>> +     uint32_t                sync_seq;
>> +     u64                     start;
>> +     u64                     end;
>>    };
>>
>>    int amdgpu_ring_mux_init(struct amdgpu_ring_mux *mux, struct
>> amdgpu_ring *ring, @@ -63,4 +83,8 @@ void amdgpu_ring_set_wptr_to_mux(struct amdgpu_ring_mux *mux, struct amdgpu_ring
>>    u64 amdgpu_ring_get_wptr_from_mux(struct amdgpu_ring_mux *mux, struct amdgpu_ring *ring);
>>    u64 amdgpu_ring_get_rptr_from_mux(struct amdgpu_ring_mux *mux,
>> struct amdgpu_ring *ring);
>>
>> +void amdgpu_ring_mux_start_ib(struct amdgpu_ring_mux *mux, struct
>> +amdgpu_ring *ring); void amdgpu_ring_mux_end_ib(struct
>> +amdgpu_ring_mux *mux, struct amdgpu_ring *ring); void
>> +amdgpu_ring_mux_schedule_resubmit(struct amdgpu_ring_mux *mux);
>> +
>>    #endif
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_sw_ring.c
>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_sw_ring.c
>> index ec50793aa54d..4809ecf76180 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_sw_ring.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_sw_ring.c
>> @@ -26,6 +26,7 @@
>>
>>    #include "amdgpu_sw_ring.h"
>>    #include "amdgpu_ring_mux.h"
>> +#include "amdgpu_mcbp.h"
>>
>>    u64 amdgpu_sw_ring_get_rptr_gfx(struct amdgpu_ring *ring)
>>    {
>> @@ -58,3 +59,29 @@ void amdgpu_sw_ring_commit(struct amdgpu_ring *ring)
>>        WARN_ON(!ring->is_sw_ring);
>>        amdgpu_ring_set_wptr_to_mux(mux, ring, ring->wptr);
>>    }
>> +
>> +void amdgpu_sw_ring_ib_begin(struct amdgpu_ring *ring) {
>> +     struct amdgpu_device *adev = ring->adev;
>> +     struct amdgpu_ring_mux *mux = &adev->gfx.muxer;
>> +
>> +     WARN_ON(!ring->is_sw_ring);
>> +     if (ring->hw_prio > AMDGPU_RING_PRIO_DEFAULT) {
>> +             if (amdgpu_mcbp_scan(mux) > 0)
>> +                     amdgpu_mcbp_trigger_preempt(mux);
>> +             return;
>> +     }
>> +
>> +     amdgpu_ring_mux_start_ib(mux, ring); }
>> +
>> +void amdgpu_sw_ring_ib_end(struct amdgpu_ring *ring) {
>> +     struct amdgpu_device *adev = ring->adev;
>> +     struct amdgpu_ring_mux *mux = &adev->gfx.muxer;
>> +
>> +     WARN_ON(!ring->is_sw_ring);
>> +     if (ring->hw_prio > AMDGPU_RING_PRIO_DEFAULT)
>> +             return;
>> +     amdgpu_ring_mux_end_ib(mux, ring);
>> +}
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
>> index 9596c22fded6..b7e94553f4fb 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
>> @@ -601,6 +601,7 @@ int amdgpu_vm_flush(struct amdgpu_ring *ring, struct amdgpu_job *job,
>>        if (!vm_flush_needed && !gds_switch_needed && !need_pipe_sync)
>>                return 0;
>>
>> +     amdgpu_ring_ib_begin(ring);
>>        if (ring->funcs->init_cond_exec)
>>                patch_offset = amdgpu_ring_init_cond_exec(ring);
>>
>> @@ -661,6 +662,7 @@ int amdgpu_vm_flush(struct amdgpu_ring *ring, struct amdgpu_job *job,
>>                amdgpu_ring_emit_switch_buffer(ring);
>>                amdgpu_ring_emit_switch_buffer(ring);
>>        }
>> +     amdgpu_ring_ib_end(ring);
>>        return 0;
>>    }
>>

