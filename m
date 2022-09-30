Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DD5B1C433F5
	for <amd-gfx@archiver.kernel.org>; Fri, 30 Sep 2022 04:46:57 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E4D2210EB44;
	Fri, 30 Sep 2022 04:46:56 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2059.outbound.protection.outlook.com [40.107.220.59])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A276010EB44
 for <amd-gfx@lists.freedesktop.org>; Fri, 30 Sep 2022 04:46:51 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IcscRn8KvHRysR0kbRg5zQJ9p0jKntqdy6H7lwq9qwH5S1VUQFHQHGlsaLOkDZzzmdy82WwFNio2wmamau/dyNDLNNlJ/xIhqN6FaRFV9gysKiCo2JsycwvhLyDb+s1oTLIn/HfxzKeJtmGyfTRoiduEKmZehk7ebpdL6c5bpoEVaAKK97He433r4EUrRZVAH9PbRRmdtVPerAR1++Re7hVDNDJvJJzoH8j2iPIswtnrlQsO5SyNJQHW0b11i6AB8z5wlexrvT9q5rPtgPeszfZK+PJk0hkgml/8q6jPUgVRupons0opwzfKrfPwwCe72YvYcDIaqO8BxNWPb+iVuA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4hm/WqwGztMXSn/Bc5fD0hnmTl3g/30klngun74Eskg=;
 b=PbH7v7BC2rkTH5hSDD4PfHF/B8g7uiyuPLUAsyFuKX8mLJntSzsaM9HThsT5G+CCT3AdgP8lvutTA1rtvoZClt2OVyyI1EJEM/WZhL/I8kWVPuwK253pkQi3FyFwRCYo9q7cQvMGCXMV7A41SjT3ozACmQb4cPBc9PL3oUtuTDWuYdk5w7YFTpeNbMXitla3IJmM2boUiywcNIDDzGz+pBpKVlbHp3Z0oaOfT1OKLxvthqYDvt3kRP5/RAeq7i4banwsz2RmEKAdlZdmtUU/qE0UG9ARBPvVoADPnAp8q8uiqDeu37Cj/SyiuhDiK+yDEGPfCM6zH5h+2a4jE2e9kg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4hm/WqwGztMXSn/Bc5fD0hnmTl3g/30klngun74Eskg=;
 b=N7jWREHKIxY5m1NHQ57EG6e6FYZUJjVAi5A4RZqAj5OzfgxJP66hD5J4v9XuMiCKsBKj9VJptLwdjfEpYNi7d6aOHuh+3uXxkrta/7syDfsAXd8QkXLwyVLvCVG0INq0FOINvsXBFzjT+ZCwM+4ptcY2nBblBZnl8AKq3+9cbWU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BYAPR12MB4614.namprd12.prod.outlook.com (2603:10b6:a03:a6::22)
 by PH8PR12MB7208.namprd12.prod.outlook.com (2603:10b6:510:224::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5676.17; Fri, 30 Sep
 2022 04:46:49 +0000
Received: from BYAPR12MB4614.namprd12.prod.outlook.com
 ([fe80::1f2e:c1d1:efd4:f918]) by BYAPR12MB4614.namprd12.prod.outlook.com
 ([fe80::1f2e:c1d1:efd4:f918%4]) with mapi id 15.20.5676.020; Fri, 30 Sep 2022
 04:46:49 +0000
Message-ID: <4631213b-88bc-02cc-0cda-01678a75433b@amd.com>
Date: Fri, 30 Sep 2022 10:16:37 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.2
Subject: Re: [PATCH v3 5/5] drm/amdgpu: switch workload context to/from compute
Content-Language: en-US
To: Felix Kuehling <felix.kuehling@amd.com>,
 "Sharma, Shashank" <shashank.sharma@amd.com>,
 Alex Deucher <alexdeucher@gmail.com>
References: <20220926214014.5450-1-shashank.sharma@amd.com>
 <20220926214014.5450-6-shashank.sharma@amd.com>
 <6a0d7dea-8c5e-701d-9231-d6f76df76706@amd.com>
 <aa663a5a-3bc4-393e-ff4b-73e3247e79fa@amd.com>
 <6d8dd85d-5d6f-8364-b710-9483944a2090@amd.com>
 <d4037915-2281-b12b-e38b-2e947fb34c75@amd.com>
 <72aa5f24-8f66-2a8b-3338-a082541dd4aa@amd.com>
 <CADnq5_PavsH-=7hQjWn7aBSCVs30AYdNa_ixDUn7o-BRLh=78A@mail.gmail.com>
 <546cc67c-f17b-de76-afa1-2823f09120e8@amd.com>
 <CADnq5_Mg7GFW=s6W5xeGa5vG7_GmedsP6uQG_dpZKkzp1CDJqg@mail.gmail.com>
 <5bf6d05a-58e4-0057-1445-9369b20b1a67@amd.com>
 <369b2225-87a3-b976-bbd1-6f73f190b44a@amd.com>
 <be0e9a44-a285-49b4-7b2f-afd68930e812@amd.com>
From: "Lazar, Lijo" <lijo.lazar@amd.com>
In-Reply-To: <be0e9a44-a285-49b4-7b2f-afd68930e812@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PN3PR01CA0075.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:9a::15) To BYAPR12MB4614.namprd12.prod.outlook.com
 (2603:10b6:a03:a6::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR12MB4614:EE_|PH8PR12MB7208:EE_
X-MS-Office365-Filtering-Correlation-Id: a4d70710-bf99-48c3-efba-08daa29ec933
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 7Tzjc3ELr5j/U6Odq4dUVBx5+EKaQ5gRGBaJnKVdSvQNa8gxlRnOpXsl62h/Ro0h0ZsShtCzcxZJd0aGzz7eiySCkEYNlzAQkkfrg7cmA+5TQ5WZGR5gb92hDuBlZtPDoDJga1u9XzJWBhk7USz8OkqT84Gz1EKQW+fUb6xKsxyd2tmmspHLbb5UvbpshI6xqz8+hke6SUQYEZCB2RTu2XiMpdVZIqX9bAggVzhwSCzeBKHkLw4BkO784lmyCpl2LiHAnzKATLyLZqtMNX3NfKkmEgoH4mZTxx4CnJk1ByZHPMnT5tjFTntcNqCbDBwI68ckNfoVDVmQiJn3oWPrFIDYdTBPzLOsxNak8sS0hRF7QQH6lF8bvKLa56xqEOz5UTjyJMsyoYJPVdeKRdoN1ZZO9x5rems+Z8pVzkEEtm3M31zBoG4nDe+0MHb6YitUoZQH221uc/W2gTiXT32KvvP5TNiT7fnnVa6Q/KGEM8pbIE8Y7QCpLeNCLWp+PVhhXgGsTxHB3mZTHfbYgqFSk2Qhep9djfwL9MwyJys2Pt19Bk2BbjmSsGQlFYgbiI78vEIvOfvbDbz2lh16K9o03GdcAI6ORNb16YXgU514zObRU3I8l0JGcUclCI1F3aSGcMw3dv6X3NPKELlroFgW+nzZlqFX1+IyGRFIeJjFP28KJU3uQX3KwBm2Vcvo09dyrOutS9j170XszGoMY86+3STYDQk+9vvKsyeETpaJE2iUjIwg8h3OHzKoZ2Kxz8Utcmz34RYPIP/8Clp1N6k10JYUc8R6j6281p/lk6BM+QVCL3YP+f5xJzl1BWbOCRNULh6K/J9TwRAkpQAK5C2zOpTVTI+XRlYidbtPmJJMnofHe3gnH6KEmkpKdaJHnQe+
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR12MB4614.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230022)(4636009)(396003)(376002)(366004)(136003)(346002)(39860400002)(451199015)(66556008)(5660300002)(4326008)(8936002)(966005)(41300700001)(8676002)(66476007)(6486002)(66946007)(66574015)(83380400001)(186003)(110136005)(478600001)(316002)(6666004)(53546011)(6506007)(30864003)(26005)(36756003)(2616005)(2906002)(6512007)(86362001)(31696002)(38100700002)(31686004)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZFdmMGF4T0tQcVd0VE1xdjlXK3YwVkpuNlJtbzNpeFBPUE41enlWbHI2MG80?=
 =?utf-8?B?TlF2azlnMVNzRld3dXE0YVFXZHJmb0p5Z2dmNSsrRjkyblhlZ3JJZDFmWFFq?=
 =?utf-8?B?Z3VuOGZmdjQwenFLOXpiWFoxWVRZN1VSMFJUc0pIVDBHcU9id2VMekVBWWVN?=
 =?utf-8?B?dmYvWDBLNTNJNnk0M3AxSkhKbDU1MG93TkxhMCttekgxOTBoUEN2YXA2QXkx?=
 =?utf-8?B?aUg2NmNsSlVqcGZSYmdQZG5wRjcxK3lNZ2srT3N3SHd2eXJ2WlNvWnM5TWhB?=
 =?utf-8?B?RWl3QVdXdWw0MUdERHVrdnZYZ0p1TWxlRm9KdTdtSHVKWlY4WnNBVjhvRGg5?=
 =?utf-8?B?bjg1ZXlyNS9TOEhocVl2UVZGQXdwZU9DUURUT2FhZzUwWXNNUVVQcXRIQXBk?=
 =?utf-8?B?SS9NemQyLzE0NWZ2NFIzQ3dlL241cmxhelFYbk96Nkgrb0lEak9xdVgxanM0?=
 =?utf-8?B?UW1xTzIxbzI2eFVSRjRjSitVcnFRS0swand3QzZRbzRDTG1LMVpRelJ5WlEy?=
 =?utf-8?B?YS9QV0dQWjRtY3dNNGlsZVlGeVZ0S1lBL1JwbnNpTUJYcU56VHZkOFNncVRi?=
 =?utf-8?B?bUMzTUF0dzB0MldhallvRDZrS2RnQVd2YzlRc1dBb3Jqcm1jNkg2SWhzVFlK?=
 =?utf-8?B?bU9FUXRLRFRLeXIyWGxGNjJuUWJDdXVaeHVoMVFPSUpqRG9ML0NRK0twUlRP?=
 =?utf-8?B?aStObjJ3dnNjWXBaMFgwQzNhME51Z283aHVFblNUVFN4NDY2UVgrWjhaZWxa?=
 =?utf-8?B?Ulh5elhPeDZ2ZFJQNDdiRTd6VXBZNmZzdEJWODZETzlLUitIUEE1bDRVRXJW?=
 =?utf-8?B?QXZhOTdMUStOV2FVRGF1b2k2RjFQOFJFNG1hSlV3Z1pPNEpPYmxPYVVZK1dq?=
 =?utf-8?B?dmMvSEtySEtMaGZ6UDByOGh0VEhqUndXRU9mbWVRZFFaYS9oTngxRGRFUk1z?=
 =?utf-8?B?c0lZY1hRdklsd001Zy9SRmFKRmhPVFhRdmdnelJseGtPanh3WHN6L2ViNC96?=
 =?utf-8?B?eTdKRERBdUJSYUJURUZla2g2TXFUWXVBYmtYbEl5YWRLS21kRTloajlZQi8w?=
 =?utf-8?B?bFJnSUQ3OWpjN3c3bHBibFVoSXYwbU5WNFpPTkVnM0RURG1OUHpTNW5vZXdF?=
 =?utf-8?B?R2w2QUlHY0lwZDNNeEhZR0czQnhNTUFsYW9VWVJiWTRGYnFPZVhBNVBidzcv?=
 =?utf-8?B?ZXhaeXVKeWQ4Ry90V0thSjVVb1ZMUi9pTzNvU1Z4VDc1TWp6UkR4QnpMSUJi?=
 =?utf-8?B?WGVtUHFZaHdBNnp0S2c3M1l5U3JsaU5lbWpRdzBiWmQ5Wm5qTC85S2NxUlVE?=
 =?utf-8?B?UG9lYmFDclVMRU1PazkxUnZvT3lNcGwzSWhZMnNndzErQ292OFNuQ3VGVFVP?=
 =?utf-8?B?Q2hZeFNhbjJPdnY4SzQ2N3RKK0R5TENkejdaTjlDSEFuSG16S3dUdU9uWjNT?=
 =?utf-8?B?Ynd6Z1RvMm1RZmZPWS9KT1A0Z3BLZ0tBWHBmNmw5R01xYVZyVDdVeUduZklm?=
 =?utf-8?B?VE1CdDRySjg1ODBCbjRzeWpkdFEydzRFWG1ZNkVua0ZhZU5GcGc4SE9WbFFY?=
 =?utf-8?B?MEYrU3I2Q3pSMHovRVFuc1JCbU9GbjRyR2ZhcEd0QUlaUkl3VzJYcndTL01O?=
 =?utf-8?B?STRtd3FDR2xnMWw2UDIwaGMwMzFLMDBoamhwcVhHcEhBYVRyTGx4VDkyMlFB?=
 =?utf-8?B?ZDB3OXlyMm9QWFI1bkJGRTgzRTlWeHpkbDBOem9meERURFpKejFVelZ2YXBJ?=
 =?utf-8?B?bVBuTjBIb0tmU1JoTlZsNjZWc0hoenFNMEU4bHRhQ01LNGJyWHlZdDI0UDFG?=
 =?utf-8?B?VEpSb3hMZndLNDFOMnJiUGtrcWMyKzN5dGhaVVVybjJqU1VCS25SS2lyMnRQ?=
 =?utf-8?B?QVRITGI0WDB1czg1eVcreVkrbGtiaHE5dTgxWUI2VklzdWhLYlJ3YUovb0w3?=
 =?utf-8?B?V1NEck5nbHNTWE02Y2crTHplUGVtRkJnY0JQZU1HOGdHazRiOEp2c0ZveDQ4?=
 =?utf-8?B?bXNoZkVXN1ZDL0JTb0hLWnVLc1pEK2tUZXNjNjFSQUowdzVtVmhRQ1BmbTg1?=
 =?utf-8?B?TE5BUjlZYytuQUdmVTZsa1lGRFhBeGYrM0hGbnp4WkVmMmNKeGtRL2IzM3Bp?=
 =?utf-8?Q?u/JH3UDvhD1zOHZufOuWTb8Xy?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a4d70710-bf99-48c3-efba-08daa29ec933
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB4614.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Sep 2022 04:46:49.4096 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MKbZ1zmJTVh7PnPURw9lXZ4F6RN81yFEknqRFJSUpO9Lp+6NlLjlSEFIGrqM0oek
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB7208
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
Cc: alexander.deucher@amd.com, amaranath.somalapuram@amd.com,
 =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>,
 amd-gfx@lists.freedesktop.org
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>



On 9/29/2022 11:37 PM, Felix Kuehling wrote:
> On 2022-09-29 07:10, Lazar, Lijo wrote:
>>
>>
>> On 9/29/2022 2:18 PM, Sharma, Shashank wrote:
>>>
>>>
>>> On 9/28/2022 11:51 PM, Alex Deucher wrote:
>>>> On Wed, Sep 28, 2022 at 4:57 AM Sharma, Shashank
>>>> <shashank.sharma@amd.com> wrote:
>>>>>
>>>>>
>>>>>
>>>>> On 9/27/2022 10:40 PM, Alex Deucher wrote:
>>>>>> On Tue, Sep 27, 2022 at 11:38 AM Sharma, Shashank
>>>>>> <shashank.sharma@amd.com> wrote:
>>>>>>>
>>>>>>>
>>>>>>>
>>>>>>> On 9/27/2022 5:23 PM, Felix Kuehling wrote:
>>>>>>>> Am 2022-09-27 um 10:58 schrieb Sharma, Shashank:
>>>>>>>>> Hello Felix,
>>>>>>>>>
>>>>>>>>> Thank for the review comments.
>>>>>>>>>
>>>>>>>>> On 9/27/2022 4:48 PM, Felix Kuehling wrote:
>>>>>>>>>> Am 2022-09-27 um 02:12 schrieb Christian König:
>>>>>>>>>>> Am 26.09.22 um 23:40 schrieb Shashank Sharma:
>>>>>>>>>>>> This patch switches the GPU workload mode to/from
>>>>>>>>>>>> compute mode, while submitting compute workload.
>>>>>>>>>>>>
>>>>>>>>>>>> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
>>>>>>>>>>>> Signed-off-by: Shashank Sharma <shashank.sharma@amd.com>
>>>>>>>>>>>
>>>>>>>>>>> Feel free to add my acked-by, but Felix should probably take 
>>>>>>>>>>> a look
>>>>>>>>>>> as well.
>>>>>>>>>>
>>>>>>>>>> This look OK purely from a compute perspective. But I'm concerned
>>>>>>>>>> about the interaction of compute with graphics or multiple 
>>>>>>>>>> graphics
>>>>>>>>>> contexts submitting work concurrently. They would constantly 
>>>>>>>>>> override
>>>>>>>>>> or disable each other's workload hints.
>>>>>>>>>>
>>>>>>>>>> For example, you have an amdgpu_ctx with
>>>>>>>>>> AMDGPU_CTX_WORKLOAD_HINT_COMPUTE (maybe Vulkan compute) and a KFD
>>>>>>>>>> process that also wants the compute profile. Those could be 
>>>>>>>>>> different
>>>>>>>>>> processes belonging to different users. Say, KFD enables the 
>>>>>>>>>> compute
>>>>>>>>>> profile first. Then the graphics context submits a job. At the 
>>>>>>>>>> start
>>>>>>>>>> of the job, the compute profile is enabled. That's a no-op 
>>>>>>>>>> because
>>>>>>>>>> KFD already enabled the compute profile. When the job 
>>>>>>>>>> finishes, it
>>>>>>>>>> disables the compute profile for everyone, including KFD. That's
>>>>>>>>>> unexpected.
>>>>>>>>>>
>>>>>>>>>
>>>>>>>>> In this case, it will not disable the compute profile, as the
>>>>>>>>> reference counter will not be zero. The reset_profile() will 
>>>>>>>>> only act
>>>>>>>>> if the reference counter is 0.
>>>>>>>>
>>>>>>>> OK, I missed the reference counter.
>>>>>>>>
>>>>>>>>
>>>>>>>>>
>>>>>>>>> But I would be happy to get any inputs about a policy which can be
>>>>>>>>> more sustainable and gets better outputs, for example:
>>>>>>>>> - should we not allow a profile change, if a PP mode is already
>>>>>>>>> applied and keep it Early bird basis ?
>>>>>>>>>
>>>>>>>>> For example: Policy A
>>>>>>>>> - Job A sets the profile to compute
>>>>>>>>> - Job B tries to set profile to 3D, but we do not allow it as 
>>>>>>>>> job A is
>>>>>>>>> not finished it yet.
>>>>>>>>>
>>>>>>>>> Or Policy B: Current one
>>>>>>>>> - Job A sets the profile to compute
>>>>>>>>> - Job B tries to set profile to 3D, and we allow it. Job A also 
>>>>>>>>> runs
>>>>>>>>> in PP 3D
>>>>>>>>> - Job B finishes, but does not reset PP as reference count is 
>>>>>>>>> not zero
>>>>>>>>> due to compute
>>>>>>>>> - Job  A finishes, profile reset to NONE
>>>>>>>>
>>>>>>>> I think this won't work. As I understand it, the
>>>>>>>> amdgpu_dpm_switch_power_profile enables and disables individual
>>>>>>>> profiles. Disabling the 3D profile doesn't disable the compute 
>>>>>>>> profile
>>>>>>>> at the same time. I think you'll need one refcount per profile.
>>>>>>>>
>>>>>>>> Regards,
>>>>>>>>      Felix
>>>>>>>
>>>>>>> Thanks, This is exactly what I was looking for, I think Alex's 
>>>>>>> initial
>>>>>>> idea was around it, but I was under the assumption that there is 
>>>>>>> only
>>>>>>> one HW profile in SMU which keeps on getting overwritten. This 
>>>>>>> can solve
>>>>>>> our problems, as I can create an array of reference counters, and 
>>>>>>> will
>>>>>>> disable only the profile whose reference counter goes 0.
>>>>>>
>>>>>> It's been a while since I paged any of this code into my head, but I
>>>>>> believe the actual workload message in the SMU is a mask where you 
>>>>>> can
>>>>>> specify multiple workload types at the same time and the SMU will
>>>>>> arbitrate between them internally.  E.g., the most aggressive one 
>>>>>> will
>>>>>> be selected out of the ones specified.  I think in the driver we just
>>>>>> set one bit at a time using the current interface.  It might be 
>>>>>> better
>>>>>> to change the interface and just ref count the hint types and then
>>>>>> when we call the set function look at the ref counts for each hint
>>>>>> type and set the mask as appropriate.
>>>>>>
>>>>>> Alex
>>>>>>
>>>>>
>>>>> Hey Alex,
>>>>> Thanks for your comment, if that is the case, this current patch 
>>>>> series
>>>>> works straight forward, and no changes would be required. Please 
>>>>> let me
>>>>> know if my understanding is correct:
>>>>>
>>>>> Assumption: Order of aggression: 3D > Media > Compute
>>>>>
>>>>> - Job 1: Requests mode compute: PP changed to compute, ref count 1
>>>>> - Job 2: Requests mode media: PP changed to media, ref count 2
>>>>> - Job 3: requests mode 3D: PP changed to 3D, ref count 3
>>>>> - Job 1 finishes, downs ref count to 2, doesn't reset the PP as ref 
>>>>> > 0,
>>>>> PP still 3D
>>>>> - Job 3 finishes, downs ref count to 1, doesn't reset the PP as ref 
>>>>> > 0,
>>>>> PP still 3D
>>>>> - Job 2 finishes, downs ref count to 0, PP changed to NONE,
>>>>>
>>>>> In this way, every job will be operating in the Power profile of 
>>>>> desired
>>>>> aggression or higher, and this API guarantees the execution 
>>>>> at-least in
>>>>> the desired power profile.
>>>>
>>>> I'm not entirely sure on the relative levels of aggression, but I
>>>> believe the SMU priorities them by index.  E.g.
>>>> #define WORKLOAD_PPLIB_DEFAULT_BIT        0
>>>> #define WORKLOAD_PPLIB_FULL_SCREEN_3D_BIT 1
>>>> #define WORKLOAD_PPLIB_POWER_SAVING_BIT   2
>>>> #define WORKLOAD_PPLIB_VIDEO_BIT          3
>>>> #define WORKLOAD_PPLIB_VR_BIT             4
>>>> #define WORKLOAD_PPLIB_COMPUTE_BIT        5
>>>> #define WORKLOAD_PPLIB_CUSTOM_BIT         6
>>>>
>>>> 3D < video < VR < compute < custom
>>>>
>>>> VR and compute are the most aggressive.  Custom takes preference
>>>> because it's user customizable.
>>>>
>>>> Alex
>>>>
>>>
>>> Thanks, so this UAPI will guarantee the execution of the job in 
>>> atleast the requested power profile, or a more aggressive one.
>>>
>>
>> Hi Shashank,
>>
>> This is not how the API works in the driver PM subsystem. In the final 
>> interface with PMFW, driver sets only one profile bit and doesn't set 
>> any mask. So it doesn't work the way as Felix explained.
> 
> I was not looking at the implementation but at the API:
> 
> int amdgpu_dpm_switch_power_profile(struct amdgpu_device *adev,
>                                      enum PP_SMC_POWER_PROFILE type,
>                                      bool en)
> 
> This API suggests, that we can enable and disable individual profiles. 
> E.g. disabling PP_SMC_POWER_PROFILE_VIDEO should not change whether 
> PP_SMC_POWER_PROFILE_COMPUTE is enabled. What we actually send to the HW 
> when multiple profiles are enabled through this API is a different 
> question. We have to choose one profile or the other. This can happen in 
> the driver or the firmware. I don't care.
> 
> But if disabling PP_SMC_POWER_PROFILE_VIDEO makes us forget that we ever 
> enabled PP_SMC_POWER_PROFILE_COMPUTE then this API is broken and useless 
> as an abstraction.
> 

Checked again. Here driver decides the priority instead of FW. So the 
API works as you mentioned (except that there is no refcount done). 
Sorry for the confusion.

Thanks,
Lijo

> Regards,
>    Felix
> 
> 
>> If there is more than one profile bit set, PMFW looks at the mask and 
>> picks the one with the highest priority. Note that for each update of 
>> workload mask, PMFW should get a message.
>>
>> Driver currently sets only bit as Alex explained earlier. For our 
>> current driver implementation, you can check this as example -
>>
>> https://elixir.bootlin.com/linux/latest/source/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c#L1753 
>>
>>
>> Also, PM layer already stores the current workload profile for a *get* 
>> API (which also means a new pm workload variable is not needed). But, 
>> that API works as long as driver sets only one profile bit, that way 
>> driver is sure of the current profile mode -
>>
>> https://elixir.bootlin.com/linux/latest/source/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c#L1628 
>>
>>
>> When there is more than one, driver is not sure of the internal 
>> priority of PMFW though we can follow the bit order which Alex 
>> suggested (but sometimes FW carry some workarounds inside which means 
>> it doesn't necessarily follow the same order).
>>
>> There is an existing interface through sysfs through which allow to 
>> change the profile mode and add custom settings. In summary, any 
>> handling of change from single bit to mask needs to be done at the 
>> lower layer.
>>
>> The problem is this behavior has been there throughout all legacy 
>> ASICs. Not sure how much of effort it takes and what all needs to be 
>> modified.
>>
>> Thanks,
>> Lijo
>>
>>> I will do the one change required and send the updated one.
>>>
>>> - Shashank
>>>
>>>>
>>>>
>>>>
>>>>>
>>>>> - Shashank
>>>>>
>>>>>>
>>>>>>>
>>>>>>> - Shashank
>>>>>>>
>>>>>>>>
>>>>>>>>
>>>>>>>>>
>>>>>>>>>
>>>>>>>>> Or anything else ?
>>>>>>>>>
>>>>>>>>> REgards
>>>>>>>>> Shashank
>>>>>>>>>
>>>>>>>>>
>>>>>>>>>> Or you have multiple VCN contexts. When context1 finishes a 
>>>>>>>>>> job, it
>>>>>>>>>> disables the VIDEO profile. But context2 still has a job on 
>>>>>>>>>> the other
>>>>>>>>>> VCN engine and wants the VIDEO profile to still be enabled.
>>>>>>>>>>
>>>>>>>>>> Regards,
>>>>>>>>>>      Felix
>>>>>>>>>>
>>>>>>>>>>
>>>>>>>>>>>
>>>>>>>>>>> Christian.
>>>>>>>>>>>
>>>>>>>>>>>> ---
>>>>>>>>>>>>     drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c | 14 
>>>>>>>>>>>> +++++++++++---
>>>>>>>>>>>>     1 file changed, 11 insertions(+), 3 deletions(-)
>>>>>>>>>>>>
>>>>>>>>>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
>>>>>>>>>>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
>>>>>>>>>>>> index 5e53a5293935..1caed319a448 100644
>>>>>>>>>>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
>>>>>>>>>>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
>>>>>>>>>>>> @@ -34,6 +34,7 @@
>>>>>>>>>>>>     #include "amdgpu_ras.h"
>>>>>>>>>>>>     #include "amdgpu_umc.h"
>>>>>>>>>>>>     #include "amdgpu_reset.h"
>>>>>>>>>>>> +#include "amdgpu_ctx_workload.h"
>>>>>>>>>>>>       /* Total memory size in system memory and all GPU 
>>>>>>>>>>>> VRAM. Used to
>>>>>>>>>>>>      * estimate worst case amount of memory to reserve for 
>>>>>>>>>>>> page tables
>>>>>>>>>>>> @@ -703,9 +704,16 @@ int amdgpu_amdkfd_submit_ib(struct
>>>>>>>>>>>> amdgpu_device *adev,
>>>>>>>>>>>>       void amdgpu_amdkfd_set_compute_idle(struct 
>>>>>>>>>>>> amdgpu_device *adev,
>>>>>>>>>>>> bool idle)
>>>>>>>>>>>>     {
>>>>>>>>>>>> -    amdgpu_dpm_switch_power_profile(adev,
>>>>>>>>>>>> - PP_SMC_POWER_PROFILE_COMPUTE,
>>>>>>>>>>>> -                    !idle);
>>>>>>>>>>>> +    int ret;
>>>>>>>>>>>> +
>>>>>>>>>>>> +    if (idle)
>>>>>>>>>>>> +        ret = amdgpu_clear_workload_profile(adev,
>>>>>>>>>>>> AMDGPU_CTX_WORKLOAD_HINT_COMPUTE);
>>>>>>>>>>>> +    else
>>>>>>>>>>>> +        ret = amdgpu_set_workload_profile(adev,
>>>>>>>>>>>> AMDGPU_CTX_WORKLOAD_HINT_COMPUTE);
>>>>>>>>>>>> +
>>>>>>>>>>>> +    if (ret)
>>>>>>>>>>>> +        drm_warn(&adev->ddev, "Failed to %s power profile to
>>>>>>>>>>>> compute mode\n",
>>>>>>>>>>>> +             idle ? "reset" : "set");
>>>>>>>>>>>>     }
>>>>>>>>>>>>       bool amdgpu_amdkfd_is_kfd_vmid(struct amdgpu_device 
>>>>>>>>>>>> *adev, u32
>>>>>>>>>>>> vmid)
>>>>>>>>>>>
