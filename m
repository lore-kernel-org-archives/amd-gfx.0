Return-Path: <SRS0=g6Hj=N7=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1BFAC433FE
	for <amd-gfx@archiver.kernel.org>; Thu,  9 Sep 2021 08:37:12 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 925BB6109E
	for <amd-gfx@archiver.kernel.org>; Thu,  9 Sep 2021 08:37:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 925BB6109E
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3C3CB6E4A6;
	Thu,  9 Sep 2021 08:37:12 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2066.outbound.protection.outlook.com [40.107.220.66])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5F7BB6E4A6
 for <amd-gfx@lists.freedesktop.org>; Thu,  9 Sep 2021 08:37:11 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mBgG3kn4AhjH0KRZC6c+X/p+2GF/uwpzgIcmVRjcO0Qmj276/dy6uJGPiX4K66thtjGrxeaqcDd3zm9RYhxrUHiahP8mcS0XLOZEVN4f34JZLxud7yQYLklvfS3yZPGcf3rpI+7v1SleQkq3i+EjPxtI4/Or9P05En+wcyqAqD47X42kJSuLH3rkghgbAtKjQEaZ7dtbrHI9EdJ/U5Kgx1cFd+D5UwcfILNhawFnVhRR1spTbcPomLMEA1MeNXJGS81wWjrylkgDfOVbSODcIFP13P/Np+x6+ilGl0oIdntrWgJozkoUeU1xfOiezhuq1Fm57QlKL2p0zJSSByUmMw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version; 
 bh=XegBO1aMzsBX7J/hrUlIuxU3gZYqmoLLu30qPo699Jk=;
 b=L9bRTjQqN/Zh2KO9DJT/cWZwpy1porS+aivhxME93YCQlxNB3KZCGoZZY0/qRWNTMPL6VXTOy21aWckDpB5siXPVwQ8E3pnk5hqKODmxzqnlqZV3PYpdE10DqLZ6X9onCdvjSyrFUsp8z6E3yhh8zcd0OO1NSllSZPYDzGv0arS7igDueDXZ6tM9zX1SCmJLqVVpZ6PiqTpwfalgYuiwvqN5fST6VTS9LWZNxYicOg39EABdI2EsyvCajdjEAjYown5m841XIPGkiqnrvqqoq4IIYv8ZPc5j4EEk/JNSJfY81wv0DW1P0jYV7YaBDeKDax+ZowmvktHh30kv7+FofA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XegBO1aMzsBX7J/hrUlIuxU3gZYqmoLLu30qPo699Jk=;
 b=W5juBCO8QtyC27Lky+RzAJ9KOq4ErqWRrBZjsmO2+Tglw0ySf118mPEHERfRIBoRd0wcjntAHl8lVNDRc5TceW0LWn4aGc8tSdu6Mt70njR/+Xqr8zUsMWmNkCdTXEhMcRjxhuvwg/6coIgi+0O1hjPj75wLCBFCJNkGrynYFbM=
Authentication-Results: hisilicon.com; dkim=none (message not signed)
 header.d=none;hisilicon.com; dmarc=none action=none header.from=amd.com;
Received: from BN9PR12MB5356.namprd12.prod.outlook.com (2603:10b6:408:105::23)
 by BN9PR12MB5367.namprd12.prod.outlook.com (2603:10b6:408:104::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4500.15; Thu, 9 Sep
 2021 08:37:09 +0000
Received: from BN9PR12MB5356.namprd12.prod.outlook.com
 ([fe80::4804:801b:71a:a8ed]) by BN9PR12MB5356.namprd12.prod.outlook.com
 ([fe80::4804:801b:71a:a8ed%9]) with mapi id 15.20.4415.022; Thu, 9 Sep 2021
 08:37:09 +0000
Subject: Re: [PATCH] drm/amdgpu: fix sysfs_emit/sysfs_emit_at warnings
To: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>,
 "Yu, Lang" <Lang.Yu@amd.com>, "Powell, Darren" <Darren.Powell@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>,
 "Huang, Ray" <Ray.Huang@amd.com>, Tian Tao <tiantao6@hisilicon.com>
References: <20210908055615.3781901-1-lang.yu@amd.com>
 <e8b39f62-ca0c-d4e0-92a9-52487fa0da81@gmail.com>
 <47ed143e-b9ab-a80e-dac0-cfa1ec39d033@amd.com>
 <DM6PR12MB425086A1FFE0D1609581DFBAFBD49@DM6PR12MB4250.namprd12.prod.outlook.com>
 <39d2443b-c90e-b5c6-85ee-b44bbfd818d3@amd.com>
 <DM6PR12MB4250831801024A782408C280FBD49@DM6PR12MB4250.namprd12.prod.outlook.com>
 <332d81e6-a518-a155-cdfc-008e0bdb324c@amd.com>
 <5edd4df2-c49c-3b87-90d4-8d8b822641f9@gmail.com>
 <1fa7224f-de58-6864-6cb2-16a7b8968f54@amd.com>
 <4e6c0a19-0476-d8ca-c233-6f143cca511c@gmail.com>
 <CH0PR12MB5387C11CD331985AB96F0DCEF0D49@CH0PR12MB5387.namprd12.prod.outlook.com>
 <DM6PR12MB4250EC35F696D19098E9642AFBD59@DM6PR12MB4250.namprd12.prod.outlook.com>
 <3c02e758-1d36-ce2a-11df-eedd82a30c33@amd.com>
 <58d5fbbc-dd57-85ff-f627-8479d7db8128@gmail.com>
From: "Lazar, Lijo" <lijo.lazar@amd.com>
Message-ID: <f94f20c4-b7f4-3cc5-f631-3160796bc31f@amd.com>
Date: Thu, 9 Sep 2021 14:06:57 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
In-Reply-To: <58d5fbbc-dd57-85ff-f627-8479d7db8128@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BMXPR01CA0085.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:b00:54::25) To BN9PR12MB5356.namprd12.prod.outlook.com
 (2603:10b6:408:105::23)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [172.31.157.114] (165.204.158.249) by
 BMXPR01CA0085.INDPRD01.PROD.OUTLOOK.COM (2603:1096:b00:54::25) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4500.14 via Frontend Transport; Thu, 9 Sep 2021 08:37:05 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 25774b12-640c-4cb1-89b8-08d9736d02bf
X-MS-TrafficTypeDiagnostic: BN9PR12MB5367:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BN9PR12MB53679094A2AEEA81E42014DF97D59@BN9PR12MB5367.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: OhhfVe5vt7gVLCjh23pdZKhdw3qYE3FXdypcRXERp38S2ir4iH+R72ONVjKcWgnb73UBDJEYc98z9L+VDZGDqsikL/U2ckbdqZA+hPxCkEhun5dYoRlx+UgDURQv2pTkHwoUDExibQxwypCx5lJOhBYGnZsayADQQ8FG1nnIdK2tsavvqhIxuUb4oq2umz62QFIjxzCHSKocO+9m/6WfQnAzJB5DKogmgO22Seu5D9W5bKi5GOCIssOM15DV6oPk0acO6m+QS55+UPA0q/LzmfrSP33K7ol5Itt7yF8U/g4l9F+cdn4SZXBXAYeu85sEP8mm2eIvAt3lC86FDv1LDaVs10Fo/ubNLAmBrequ9zAMhJ5NNHs+7w6dn4MGTqr52pBiel5Ubq4psoVYWsXSbdzWORnXzzXzyA7cYH+sE2MZKcwMFbEL1NJ4nbWv9aCRzRXwDm0qycNboGtvIPrLRmw+nRAIH8mxwVYIi5SuJGTH1EQISPSlBdYvMDFk5R2ACxjJiyyJApNzBtGG5m+lmdTOzNWt0IOW6qSL4yJPok4UgHEFc4hhgEWvt71h0ToedNkZKefpzReNjqCnPiR1IVLSmIki+cGsXIykx+NmQSMplpr61/erU9Ynj9fbTRKLllwuNvl8qjwRBVG5D8F/Ro8TL2XUPTU6DlHU8pxj9iG3Sw+OPRZWQomPdGcll7vcO/fLUQNsii/20M6ZChFeAH6lDC9/CiNnWM10EgHg7Io=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5356.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(346002)(366004)(136003)(376002)(39860400002)(396003)(31686004)(38100700002)(186003)(5660300002)(478600001)(36756003)(110136005)(8676002)(53546011)(316002)(26005)(66946007)(2906002)(16576012)(66574015)(6666004)(8936002)(54906003)(956004)(2616005)(31696002)(66476007)(6486002)(66556008)(83380400001)(86362001)(30864003)(4326008)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TmxWTGR6ZzY5aTdlYklkWWQ3d29Tc2g1Z2dZaFo3dThTOXBrMkRCYWNFZDNC?=
 =?utf-8?B?a1RLeS9QbTA1cmVaaHVDM2ErNUpaTk9hbzNVWEFFd0VMNUNkQmJad2RlUmZr?=
 =?utf-8?B?RnRZZzhrc0VIMkNhRlhBczJtK1IvNGhrdVg1OWtDSlo4cS9IY0luZWp3R0g3?=
 =?utf-8?B?YlBjMm9kL2thbjBDcjVIckdZV292K0tLRXliWDU0UFBuYm1wWW1KTm5RYWJO?=
 =?utf-8?B?d3lXY08wbDA5Q3E2cE5aT1N3VHN6UHpaRmE2eHhwa05PN3V1SVlNWXFhUUsy?=
 =?utf-8?B?b0NwMWFtUU9QNmdTcDJNWC9GVWFZeTJyeHlqcHhVUmRHRUZuRm91b2dUNjRj?=
 =?utf-8?B?UDhNaU12YW1TeWJUR3dHK3ExVnhxbHdYVmdZVERLZVU5V09XelhKYjdYQVpN?=
 =?utf-8?B?RE5JQ2pQM2ZSdXk0alVSL2NDMUdZQ2ZZTjNPc3R5d3hvdnJyKzZKMmJCL0ts?=
 =?utf-8?B?TzA1enRHUjdWTWV5K2d3ZGkyRDZTKzFzYXRiTkRhZ3dLamRBUDdpT0VDVDdB?=
 =?utf-8?B?OWszS1FzWXRsK3VQajZ5V2s4SnRIZzBYY3VMSVV1SE1YY0NZVzdIWStncE44?=
 =?utf-8?B?YjhoMjcrU0o4dTN4UWdCcHhWRGJONjhod2VOdG1YUHcvdEJkdDV5NkthdDY0?=
 =?utf-8?B?bklFY2hHTXVYeEljN21RZlFDMFgweXY1eURjUmN4M0dFMHRyTW84eXhjNHcy?=
 =?utf-8?B?dWFzcEw1cnNNd1pqSFZCclBFMFhPbmg1NDFRUGtwTitqTmYrakpEWTFFNjFi?=
 =?utf-8?B?RzFIMVhwYjFtT3FyMk9JMmFkY2FzbVZkUm9Sbk00Y1BrKzE2TEplWDFnOWZ6?=
 =?utf-8?B?VDZ0S0c2OFpqRFkyUWM0SndnWGxEZjRvR0hvemZaZEltenhZNEwrWTB2L3pK?=
 =?utf-8?B?V1I1SnVTRkJlOGFTRXR5NVhKbU53dDhmOEdKNHhaZXVOSTFJNGxLUzl4S2Mr?=
 =?utf-8?B?dGsxM1J5dEFJWThNTCtnWmxkU2hNMkczeVJnM2h2RjdUMENCeFZ3dFZBYm9y?=
 =?utf-8?B?WGMzTkZWNmJGS0FQdDZjaFZMVjhzYVA4bzNldlJNME9DY1NGNjhIUFcrUW4y?=
 =?utf-8?B?NlNzT3FmV2FmTXJCQkQ3czJvMnd2NnZuQWlBOXVkaVlxRElZQlhlL3NsOXZ6?=
 =?utf-8?B?OExDSkZjNmVyOVpPaVZabFpiWVlCbEsvVzlGcUp0UVdGUUtwVWdKRStUQWxX?=
 =?utf-8?B?OGM3UW9BUEowcXlPYjhpNmZmUlZvMmVMN3d3dDgrOGpkRVJGV2xTaVlTNnFq?=
 =?utf-8?B?anprdXh2ZytCcEtFb0NxZ1BjdzdudUdyV2VMbEJrdXRDZVpYRUljRDVxTHRy?=
 =?utf-8?B?Q1J3UWFtMXNrcXZOUVhBazJsMSsyOU1LbFArU0VseXF4SEFmb2h3R0pMdmRz?=
 =?utf-8?B?eWJkS3A3bHA1VC9CRE5VNE9ZdHZGZ24yRjZ5akEwbWU3U0pzY0xxa1ZDSkxP?=
 =?utf-8?B?M3RucWdkSDJmL3ZnL29PMHFXd2F6Z2tjOFVlRVRKK0d2NVJJN3NlZTlnaFhm?=
 =?utf-8?B?WEZFVkRSZXdNR2VTTnFVSU9KeC9NN3pnTUs2cVlTKzRzQm1tVVBHbzNlL3U0?=
 =?utf-8?B?MitGeGJtejgzYUU4Sk5OMUMzY0JVQllERzRpOUVLaklxZDlPYTlaSVJNV1di?=
 =?utf-8?B?ZjNKK05RTG01L01MYkRiUjZ4RSs0UDZ6citnaHM4Y2ozVllTclBBbUs2QmY5?=
 =?utf-8?B?dWhKd3JnbUZ3SVpLOEkycDVFd1dQNkliTDZWRzhoai9keGxmVVZqMURhNGY0?=
 =?utf-8?Q?VoDrc+hKo+8gPcsKWaHfKpQMqtvk2uIFOGngITQ?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 25774b12-640c-4cb1-89b8-08d9736d02bf
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5356.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Sep 2021 08:37:08.7767 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: U49Vy1lMwWAcM2Ti6oqa7HVS6myLVYKasIDFXG+hDMJ2KZBoh5d+4KEI3iVRHEgr
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR12MB5367
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



On 9/9/2021 1:31 PM, Christian König wrote:
> Am 09.09.21 um 05:28 schrieb Lazar, Lijo:
>> On 9/9/2021 8:13 AM, Yu, Lang wrote:
>>> [AMD Official Use Only]
>>>
>>> So the final decision is rollback to scnprintf().
>>>
>>> If we can define our own helper functions like sysfs_emit/sysfs_emit_at
>>>
>>> but without page boundary aligned limitation to make life easier?
>>>
>>
>> No, we do want to make it clear that this function is used for sysfs 
>> files and make use of the extra checks provided by the sysfs_emit* 
>> functions. Looking at the origins of sysf_emit_at() specifically, 
>> there are indeed some cases of printing more than one values per file 
>> and multi-line usage.
> 
> Correct, but those are rather limited and well documented special cases. 
> E.g. for example if you need to grab a lock to get multiple values which 
> are supposed to be coherent to each other.
> 
> I think that's the case here, so printing multiple values is probably ok 
> in general. But we still need to get the implementation straight.
> 
>> So I'm fine with your original patch. Maybe, you can make the 
>> intention explicit by keeping the offset and buf start calculations in 
>> a separate inline function.
>>     smu_get_sysfs_buf()
> 
> Exactly that is what is not ok. So once more the intended use case of 
> those functions is:
> 
> offs = sysfs_emit(page, ...);
> offs += sysfs_emit_at(page, offs, ....);
> offs += sysfs_emit_at(page, offs, ....);
> ...
> 
> Another possible alternative which I think should be allowed is:
> 
> offs = 0;
> for_each_clock_in_my_device(..) {
>      offs += sysfs_emit_at(page, offs, ....);
> }
> 
> But when you are calculating the initial offset manually then there is 
> certainly something wrong here and that is not the intended usage pattern.
> 

Actually, the issue is not within one function invocation. The issue is 
at the caller side with multiple invocations -

                  size = amdgpu_dpm_print_clock_levels(adev, OD_SCLK, buf);
                  size += amdgpu_dpm_print_clock_levels(adev, OD_MCLK,
buf+size);

Having amdgpu_dpm_print_clock_levels() helped to consolidate sysfs calls 
in single function for different parameters and used for different 
nodes. However in this case, different parameters are presented as a 
single "logical entity" in a sysfs node and the function is called 
multiple times for different parameters (questionable as per sysfs 
guidelines, Alex needs to come back on this).

Within one invocation of amdgpu_dpm_print_clock_levels(), the APIs are 
used correctly. For the second call, it needs to pass the page aligned 
buf pointer correctly to sysfs_emit* calls.

Presently, amdgpu_dpm_print_clock_levels() takes only buff pointer as 
argument and probably it is that way since the function existed before 
sysfs_emit* patches got added and was originally using sprintfs.

Now, two possible options are -

1) Make a pre-requisite that this function is always going to print to 
sysfs files. For that use sysfs_emit*. Also, as with a sysfs buffer 
calculate the page aligned start address of buf and offset for use with 
sysfs_emit* in the beginning. At least for now, this assumption is 
inline with the buffer start address requirement in sysfs_emit* patches. 
This is what the original patch does. That said, if the buffer 
properties change in future this will not hold good.

2) Pass the offset along with the buff in API. That will be extensive 
since it affects older powerplay based HWs also.

There may be other ways, but those could be even more extensive than 2).

Thanks,
Lijo

> Regards,
> Christian.
> 
>>
>> Thanks,
>> Lijo
>>
>>> Regards,
>>>
>>> Lang
>>>
>>> *From:* Powell, Darren <Darren.Powell@amd.com>
>>> *Sent:* Thursday, September 9, 2021 6:18 AM
>>> *To:* Christian König <ckoenig.leichtzumerken@gmail.com>; Lazar, Lijo 
>>> <Lijo.Lazar@amd.com>; Yu, Lang <Lang.Yu@amd.com>; 
>>> amd-gfx@lists.freedesktop.org
>>> *Cc:* Deucher, Alexander <Alexander.Deucher@amd.com>; Huang, Ray 
>>> <Ray.Huang@amd.com>; Tian Tao <tiantao6@hisilicon.com>
>>> *Subject:* Re: [PATCH] drm/amdgpu: fix sysfs_emit/sysfs_emit_at warnings
>>>
>>> [AMD Official Use Only]
>>>
>>> ------------------------------------------------------------------------
>>>
>>> *From:*Christian König <ckoenig.leichtzumerken@gmail.com 
>>> <mailto:ckoenig.leichtzumerken@gmail.com>>
>>> *Sent:* Wednesday, September 8, 2021 8:43 AM
>>> *To:* Lazar, Lijo <Lijo.Lazar@amd.com <mailto:Lijo.Lazar@amd.com>>; 
>>> Yu, Lang <Lang.Yu@amd.com <mailto:Lang.Yu@amd.com>>; 
>>> amd-gfx@lists.freedesktop.org <mailto:amd-gfx@lists.freedesktop.org> 
>>> <amd-gfx@lists.freedesktop.org <mailto:amd-gfx@lists.freedesktop.org>>
>>> *Cc:* Deucher, Alexander <Alexander.Deucher@amd.com 
>>> <mailto:Alexander.Deucher@amd.com>>; Huang, Ray <Ray.Huang@amd.com 
>>> <mailto:Ray.Huang@amd.com>>; Tian Tao <tiantao6@hisilicon.com 
>>> <mailto:tiantao6@hisilicon.com>>; Powell, Darren 
>>> <Darren.Powell@amd.com <mailto:Darren.Powell@amd.com>>
>>> *Subject:* Re: [PATCH] drm/amdgpu: fix sysfs_emit/sysfs_emit_at warnings
>>>
>>> Am 08.09.21 um 12:22 schrieb Lazar, Lijo:
>>>  > On 9/8/2021 3:08 PM, Christian König wrote:
>>>  >> Am 08.09.21 um 11:29 schrieb Lazar, Lijo:
>>>  >>> On 9/8/2021 2:32 PM, Yu, Lang wrote:
>>>  >>>> [AMD Official Use Only]
>>>  >>>>> -----Original Message-----
>>>  >>>>> From: Lazar, Lijo <Lijo.Lazar@amd.com 
>>> <mailto:Lijo.Lazar@amd.com>>
>>>  >>>>> Sent: Wednesday, September 8, 2021 4:55 PM
>>>  >>>>> To: Yu, Lang <Lang.Yu@amd.com <mailto:Lang.Yu@amd.com>>; 
>>> Christian König
>>>  >>>>> <ckoenig.leichtzumerken@gmail.com 
>>> <mailto:ckoenig.leichtzumerken@gmail.com>>; 
>>> amd-gfx@lists.freedesktop.org <mailto:amd-gfx@lists.freedesktop.org>
>>>  >>>>> Cc: Deucher, Alexander <Alexander.Deucher@amd.com 
>>> <mailto:Alexander.Deucher@amd.com>>; Huang, Ray
>>>  >>>>> <Ray.Huang@amd.com <mailto:Ray.Huang@amd.com>>; Tian Tao 
>>> <tiantao6@hisilicon.com <mailto:tiantao6@hisilicon.com>>
>>>  >>>>> Subject: Re: [PATCH] drm/amdgpu: fix sysfs_emit/sysfs_emit_at
>>>  >>>>> warnings
>>>  >>>>>
>>>  >>>>>
>>>  >>>>>
>>>  >>>>> On 9/8/2021 1:14 PM, Yu, Lang wrote:
>>>  >>>>>> [AMD Official Use Only]
>>>  >>>>>>
>>>  >>>>>>
>>>  >>>>>>
>>>  >>>>>>> -----Original Message-----
>>>  >>>>>>> From: Lazar, Lijo <Lijo.Lazar@amd.com 
>>> <mailto:Lijo.Lazar@amd.com>>
>>>  >>>>>>> Sent: Wednesday, September 8, 2021 3:36 PM
>>>  >>>>>>> To: Christian König <ckoenig.leichtzumerken@gmail.com 
>>> <mailto:ckoenig.leichtzumerken@gmail.com>>; Yu, Lang
>>>  >>>>>>> <Lang.Yu@amd.com <mailto:Lang.Yu@amd.com>>; 
>>> amd-gfx@lists.freedesktop.org <mailto:amd-gfx@lists.freedesktop.org>
>>>  >>>>>>> Cc: Deucher, Alexander <Alexander.Deucher@amd.com 
>>> <mailto:Alexander.Deucher@amd.com>>; Huang, Ray
>>>  >>>>>>> <Ray.Huang@amd.com <mailto:Ray.Huang@amd.com>>; Tian Tao 
>>> <tiantao6@hisilicon.com <mailto:tiantao6@hisilicon.com>>
>>>  >>>>>>> Subject: Re: [PATCH] drm/amdgpu: fix sysfs_emit/sysfs_emit_at
>>>  >>>>>>> warnings
>>>  >>>>>>>
>>>  >>>>>>>
>>>  >>>>>>>
>>>  >>>>>>> On 9/8/2021 12:07 PM, Christian König wrote:
>>>  >>>>>>>> Am 08.09.21 um 07:56 schrieb Lang Yu:
>>>  >>>>>>>>> sysfs_emit and sysfs_emit_at requrie a page boundary 
>>> aligned buf
>>>  >>>>>>>>> address. Make them happy!
>>>  >>>>>>>>>
>>>  >>>>>>>>> Warning Log:
>>>  >>>>>>>>> [  492.545174] invalid sysfs_emit_at: buf:00000000f19bdfde 
>>> at:0 [
>>>  >>>>>>>>> 492.546416] WARNING: CPU: 7 PID: 1304 at fs/sysfs/file.c:765
>>>  >>>>>>>>> sysfs_emit_at+0x4a/0xa0
>>>  >>>>>>>>> [  492.654805] Call Trace:
>>>  >>>>>>>>> [  492.655353]  ? smu_cmn_get_metrics_table+0x40/0x50 
>>> [amdgpu] [
>>>  >>>>>>>>> 492.656780] vangogh_print_clk_levels+0x369/0x410 [amdgpu] [
>>>  >>>>>>>>> 492.658245] vangogh_common_print_clk_levels+0x77/0x80 
>>> [amdgpu] [
>>>  >>>>>>>>> 492.659733]  ? preempt_schedule_common+0x18/0x30 [ 
>>> 492.660713]
>>>  >>>>>>>>> smu_print_ppclk_levels+0x65/0x90 [amdgpu] [ 492.662107]
>>>  >>>>>>>>> amdgpu_get_pp_od_clk_voltage+0x13d/0x190 [amdgpu] [ 
>>> 492.663620]
>>>  >>>>>>>>> dev_attr_show+0x1d/0x40
>>>  >>>>>>>>
>>>  >>>>>>>> Mhm, that at least partially doesn't looks like the right
>>>  >>>>>>>> approach to me.
>>>  >>>>>>>>
>>>  >>>>>>>> Why do we have string printing and sysfs code in the hardware
>>>  >>>>>>>> version specific backend in the first place?
>>>  >>>>>>>>
>>>  >>>>>>>
>>>  >>>>>>> This is a callback meant for printing ASIC specific 
>>> information to
>>>  >>>>>>> sysfs node. The buffer passed in sysfs read is passed as it is
>>>  >>>>>>> to the callback API.
>>>  >>>>>>>
>>>  >>>>>>>> That stuff needs to be implemented for each hardware 
>>> generation
>>>  >>>>>>>> and
>>>  >>>>>>>> is now cluttered with sysfs buffer offset calculations.
>>>  >>>>>>>>
>>>  >>>>>>>
>>>  >>>>>>> Looks like the warning happened because of this usage.
>>>  >>>>>>>
>>>  >>>>>>>                   size = amdgpu_dpm_print_clock_levels(adev,
>>>  >>>>>>> OD_SCLK, buf);
>>>  >>>>>>>                   size += amdgpu_dpm_print_clock_levels(adev,
>>>  >>>>>>> OD_MCLK,
>>>  >>>>>>> buf+size);
>>>  >>>>>>>                   size += amdgpu_dpm_print_clock_levels(adev,
>>>  >>>>>>> OD_VDDC_CURVE, buf+size);
>>>  >>>>>>>                   size += amdgpu_dpm_print_clock_levels(adev,
>>>  >>>>>>> OD_VDDGFX_OFFSET, buf+size);
>>>  >>>>>>>                   size += amdgpu_dpm_print_clock_levels(adev,
>>>  >>>>>>> OD_RANGE,
>>>  >>>>>>> buf+size);
>>>  >>>>>>>                   size += amdgpu_dpm_print_clock_levels(adev,
>>>  >>>>>>> OD_CCLK,
>>>  >>>>>>> buf+size);
>>>  >>>>>>>
>>>  >>>>>>>
>>>  >>>>>> [Yu, Lang]
>>>  >>>>>> Yes. So it is fine we just fix the caller
>>>  >>>>>> amdgpu_get_pp_od_clk_voltage like
>>>  >>>>> following:
>>>  >>>>>>
>>>  >>>>>> static ssize_t amdgpu_get_pp_od_clk_voltage(struct device *dev,
>>>  >>>>>>         struct device_attribute *attr,
>>>  >>>>>>         char *buf)
>>>  >>>>>> {
>>>  >>>>>>     struct drm_device *ddev = dev_get_drvdata(dev);
>>>  >>>>>>     struct amdgpu_device *adev = drm_to_adev(ddev);
>>>  >>>>>>     ssize_t size, offset;
>>>  >>>>>>     int ret, i;
>>>  >>>>>>     char temp_buf[512];
>>>  >>>>>>     char clock_type[] = {OD_SCLK, OD_MCLK, OD_VDDC_CURVE,
>>>  >>>>>> OD_VDDGFX_OFFSET, OD_RANGE, OD_CCLK};
>>>  >>>>>>
>>>  >>>>>>     if (amdgpu_in_reset(adev))
>>>  >>>>>>         return -EPERM;
>>>  >>>>>>     if (adev->in_suspend && !adev->in_runpm)
>>>  >>>>>>         return -EPERM;
>>>  >>>>>>
>>>  >>>>>>     ret = pm_runtime_get_sync(ddev->dev);
>>>  >>>>>>     if (ret < 0) {
>>>  >>>>>> pm_runtime_put_autosuspend(ddev->dev);
>>>  >>>>>>         return ret;
>>>  >>>>>>     }
>>>  >>>>>>
>>>  >>>>>>     offset = 0;
>>>  >>>>>>
>>>  >>>>>>     if (adev->powerplay.pp_funcs->print_clock_levels) {
>>>  >>>>>>         for (i = 0; i < ARRAY_SIZE(clock_type); i++) {
>>>  >>>>>>             size = amdgpu_dpm_print_clock_levels(adev,
>>>  >>>>> clock_type[i], buf);
>>>  >>>>>>             if (offset + size > PAGE_SIZE)
>>>  >>>>>>                 break;
>>>  >>>>>>             memcpy(temp_buf + offset, buf, size);
>>>  >>>>>>             offset += size;
>>>  >>>>>>         }
>>>  >>>>>>         memcpy(buf, temp_buf, offset);
>>>  >>>>>>         size = offset;
>>>  >>>>>>     } else {
>>>  >>>>>>         size = sysfs_emit(buf, "\n");
>>>  >>>>>>     }
>>>  >>>>>>     pm_runtime_mark_last_busy(ddev->dev);
>>>  >>>>>>     pm_runtime_put_autosuspend(ddev->dev);
>>>  >>>>>>
>>>  >>>>>>     return size;
>>>  >>>>>> }
>>>  >>>>>>
>>>  >>>>> Prefer to avoid any extra stack or heap usage for buffer. Maybe
>>>  >>>>> another arg to
>>>  >>>>> pass offset along with buf?
>>>  >>>>>
>>>  >>>> [Yu, Lang]
>>>  >>>> Actually, the buf address contains the 
>>> offset(offset_in_page(buf)) .
>>>  >>>
>>>  >>> Though it's not a problem based on codeflow, static analysis tools
>>>  >>> might complain.
>>>  >>>
>>>  >>>> Or we just rollback to sprintf/snprintf.
>>>  >>>>
>>>  >>>
>>>  >>> snprintf with (PAGE_SIZE-size) may be simpler. I think Darren took
>>>  >>> the effort to convert these, he may have some other ideas.
>>> The changes I made were intended to simply replace snprintf with 
>>> sysfs_emit as per
>>>
>>> linux/Documentation/filesystems/sysfs.rst:246,247
>>>
>>>   -  show() should only use sysfs_emit() or sysfs_emit_at() when 
>>> formatting
>>>
>>>      the value to be returned to user space.
>>>
>>> I specifically tried not to change the design, but only as I didn't have
>>>
>>> background in Power Management.
>>>
>>>  >>
>>>  >> This is not what I meant. See from the design point of view the
>>>  >> print_clock_levels() callback is the bad idea to begin with.
>>>  >>
>>>  >> What we should have instead is a callback which returns the clock as
>>>  >> a value which is then printed in the amdgpu_get_pp_od_clk_voltage()
>>>  >> function.
>>>  >>
>>>  >> This avoids passing around the buffer and remaining size everywhere
>>>  >> and also guarantees that the sysfs have unified printing over all
>>>  >> hardware generations.
>>>  >>
>>>  >
>>>  > The scenario is one node used for multiple parameters - OD_SCLK,
>>>  > OD_CCLK, OD_VDDGFX_OFFSET etc.(mostly to avoid cluttering sysfs with
>>>  > lots of nodes). On top of it, the parameters supported (for ex: CCLK
>>>  > is not valid on dGPUs),  the number of levels supported etc. vary
>>>  > across ASICs. There has to be multiple calls or the call needs to
>>>  > return multiple values for a single parameter (for ex: up to 4, 8 or
>>>  > 16 levels of GFXCLK depending on ASIC).
>>>
>>> Well exactly that is questionable design for sysfs.
>>>
>>> See the sysfs_emit() and sysfs_emit_at() functions are designed the way
>>> they are because you should have only one value per file, which is then
>>> printed at exactly one location.
>>>
>>> Take a look at the documentation for sysfs for more details.
>>>
>>>  > I don't know the history of the callback, mostly it was considered
>>>  > more efficient to print it directly rather than fetch and print.
>>>  > Alex/Evan may know the details.
>>>
>>> Yeah, somebody with a bit more background in power management needs to
>>> take a closer look at this here. Just keep me looped in.
>>>
>>> Regards,
>>> Christian.
>>>
>>>  >
>>>  > Thanks,
>>>  > Lijo
>>>  >
>>>  >> Regards,
>>>  >> Christian.
>>>  >>
>>>
> 
