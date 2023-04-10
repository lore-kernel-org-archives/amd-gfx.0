Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 39F1AC76196
	for <amd-gfx@archiver.kernel.org>; Mon, 10 Apr 2023 14:26:33 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 943C110E0B1;
	Mon, 10 Apr 2023 14:26:32 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2063.outbound.protection.outlook.com [40.107.93.63])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B61D310E0B1
 for <amd-gfx@lists.freedesktop.org>; Mon, 10 Apr 2023 14:26:30 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nUC4QrqX058tRW7H/D17ODLmvheQfyzUnmKxdQj4QbwYfvL9oJubtD6HQlF/BTgOIT7ArnASw2pBs/rANGHhTLlaM7kvHRtSIo7yFZOmjUQQoCRpneYSJQzL55nVTlyXJsppoe5FGstQs4CmUfe+LMeYrVGAPFVjSHJlmmyQYoVj3s4C7aixh4B7QdMeSHSOF+CorE6VayE6zwbL89ec6E4ntheW29I8AN0B5MLCaVBj4slpg0He70t7u54TEGhovQBeLjkDS9tMblINSUHBDVXWwNm+ieUEl/6XgbjfQ5cNGHBF8t9ucXD/Rt6jf6Y1XCkSauzJDXpl8KXdxel7MQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=w9cxIjzfW/V70sw78+0uFwkDLtaqH5oIzMRbhbdIhgw=;
 b=gKe9IHMcg2Np3LPIpxJskawVicalul6Klyu+kxO3Dffhl8xTmJP15HhGsWtG8B7DROBFrlsrI+2Q0OUw8WnJ9Afz636deNPv10Ab1cWbpBlBmykgD+/7KoF8+qJG7hVyl83EOPCzQsKLR5m2aUQMNARupl5pex/86nUq8/P9HNCKLF5OOzkFUhpLazhrJGtu/747HUvcmiBJQO+JLKi8aFF1IidP251mKV/dKBIEeIXqm3U9Tj6835nu1Hlg3j3qYVTdWkjIEKz3e4jb8tYdYEAOYbGaNxq7cs9r1MzBJAWTHpYMWRX0ja+RkDY2ZP0YS4iH/GpE49AS7+h/I8xBLg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=w9cxIjzfW/V70sw78+0uFwkDLtaqH5oIzMRbhbdIhgw=;
 b=h7b9tQQYUH2awilqk3CfR9DdH7AsEgTT4QiCWKf1V8LU95989PUYOCrNAqTrGEQ6FzQUEAwIcfGad+ziTsWxkR6aFC+Cg1VpzhDdjCIr/o1MUZaGI/K6mRrepzNrEkeOYblMVzmorO/asa+TD+dIzDFe27dPuxNpNusbkI45UG0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MW4PR12MB5667.namprd12.prod.outlook.com (2603:10b6:303:18a::10)
 by SJ0PR12MB8090.namprd12.prod.outlook.com (2603:10b6:a03:4ea::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6277.35; Mon, 10 Apr
 2023 14:26:26 +0000
Received: from MW4PR12MB5667.namprd12.prod.outlook.com
 ([fe80::755d:fed:c4a:bf05]) by MW4PR12MB5667.namprd12.prod.outlook.com
 ([fe80::755d:fed:c4a:bf05%4]) with mapi id 15.20.6277.036; Mon, 10 Apr 2023
 14:26:25 +0000
Message-ID: <bc5752cd-fe72-a72d-4f35-92bcfdbe289c@amd.com>
Date: Mon, 10 Apr 2023 16:26:16 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH v3 0/9] AMDGPU Usermode queues
Content-Language: en-US
To: Bas Nieuwenhuizen <bas@basnieuwenhuizen.nl>
References: <20230329160445.1300-1-shashank.sharma@amd.com>
 <CAP+8YyFgbru=1HkLo1Kfm1jKPrk5sXenUmmkzzysWbSh05q2tg@mail.gmail.com>
 <MW4PR12MB5667D4837CFDEE7230F5423DF2959@MW4PR12MB5667.namprd12.prod.outlook.com>
 <CAP+8YyGthhzm6291=jiydsNgK3suGdi4cMM7GMhTW_j3mdgCgQ@mail.gmail.com>
 <MW4PR12MB5667EC2D2E57FDDE93EE546FF2959@MW4PR12MB5667.namprd12.prod.outlook.com>
 <CAP+8YyH9GsyiUPvyeHfgG=TOOywxA42vubsYPWB9mPiexHBG_A@mail.gmail.com>
 <07322367-bbf1-cf82-0a21-15d453fe4dae@amd.com>
 <CAP+8YyEDW7JNQ1C9j0NZqXuLAnXPduSAye7esSOOwPpLNT9yYA@mail.gmail.com>
From: Shashank Sharma <shashank.sharma@amd.com>
In-Reply-To: <CAP+8YyEDW7JNQ1C9j0NZqXuLAnXPduSAye7esSOOwPpLNT9yYA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR2P281CA0120.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:9d::13) To MW4PR12MB5667.namprd12.prod.outlook.com
 (2603:10b6:303:18a::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW4PR12MB5667:EE_|SJ0PR12MB8090:EE_
X-MS-Office365-Filtering-Correlation-Id: 77efaf7a-6304-44e0-dddc-08db39cf90ee
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 0AZb+/nEfXBZ0RgVvax8Kv8u9Y0+dP9tXpQSQ8CeuRnWL6V/1ZL0eSDMNI1mcDJg4eOm5nwVChKKnLkgAsbpekjfHNNqfkL07F437H2asO5ZMR2v0cndoS+IGFSS/r0TQSVibZUXZveAkPM/8B4nWrrCANlyc7KQMYbiu6gbhxHV9vz4Uri2HbCmSCHk0z7AKhGNUaQsezVIY+meXDNXqeDHH8Gd8lwOu7+27U5Z/aYXcs/E+tuMrawKDhXx48vGnZJeWJJvUHbaLMabXL4asEmq8yMt7O6Y2brpUGM9S9wcsVZoJDvYK7E/4Gv7ia19fAhq4nIT/Gcos5WIynfTOLO44di319c55zYPKqfHoCN/NlhWYnZrMC1XuqGQY0wz4gL4oH19EQp575shrqA4wNmEQ4fK4aHD6bI23cht/FTYiQ4MDDQ8WUaWSle8GU2kV321tHv/hMtvOIe3ijNNxtVOJDhzvDsa/xNqO+HuhfWFVnNpTf7V+llgGuVlgr15gNaF9TfyScesJBNUN72y+xuTbvez6zu2QL9zt+TasXtyofSQnyrLtfC/6VXHrJgTpXp8Kf8ZTBSpmDdI+XtpyOz0PWbZ6J12/8VqRyXxw2hAQpiWMIA+puYO8Rlnr3kj
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MW4PR12MB5667.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(4636009)(366004)(376002)(39860400002)(346002)(396003)(136003)(451199021)(31696002)(86362001)(6506007)(26005)(6512007)(31686004)(2616005)(83380400001)(186003)(2906002)(53546011)(36756003)(44832011)(5660300002)(6486002)(966005)(38100700002)(8676002)(8936002)(478600001)(6666004)(54906003)(41300700001)(316002)(66946007)(66476007)(6916009)(4326008)(66556008)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dkF3S1YvTG5UK3VNc2lXdkludm0ybkd4L3hyVjR3c2pURjkxWHpkeFBReDdJ?=
 =?utf-8?B?NlYrMzJ5alQ5d1d0MUQrTlNlK1g4TWRiYklycGRlbmI4bmJKZVBra2prYjkz?=
 =?utf-8?B?QUNIemJNa3NYVGQ0QzU0SVlXRWJpVUdoaDgreWJZSWdDMHhTODhReTRpek1y?=
 =?utf-8?B?ekU2aTFRcWVnTDRieDNTaXcxRVZNTmpadzZ4ZlhmWWVHVllGS2E5cDZzVkpJ?=
 =?utf-8?B?a2NubWhQVmRjdThFb2xIQnZaYThvcnc5RG9XRStEUUF6OWRBOVpiVGxCb1k4?=
 =?utf-8?B?bFZBR0ZXZkZuVXlRM01MVFpNWkRVdTcvZ3BRUTZ5YnVrdXZzZnVEdTlzZE01?=
 =?utf-8?B?b3hzV0h6cVNrSTJFb0s5NVdNWFl2QitGdytOcnRESmdlT0Q1eWZkNUZwQThE?=
 =?utf-8?B?S0kwUmVpVTdKUTlkNG5jSTBrQTlzN1cxSWJTN0h1cUdwSjRIenZaTnY4S0pQ?=
 =?utf-8?B?R3Q4ajY2ajQvcjZkdTlUVllTRExJVlVXeTVTRVJ1aUtNdUVOTE9aU3hCMU9L?=
 =?utf-8?B?K3AwMlJoRmNHRUpDWUpVNW54QWFzU3lJcEN3bHRYMjJIVXY4cGl1OHlJZXpB?=
 =?utf-8?B?VGl6U2VYK0VkWDV3TGlPZFovL2R4QWE1WjVzdGxYUFhJcHBmY3N0Qnkxcitx?=
 =?utf-8?B?SnNhR1pSd0NMYlN6dmZtbURrbmZOV2JaaEpKeWFxcVpZWWZCWXVBckZNamt2?=
 =?utf-8?B?aFlaR0pObDdvQVlob1ZaU2FKQmlYTUxuYWNnS1RQd3J0b3U1U2JGZkJIOGgr?=
 =?utf-8?B?aFdrTmhLSlp5RmJhU25OQ2hrUmwzb0pCcW5SUUJJTS8wOTVpRlorUnZDZlFF?=
 =?utf-8?B?cTB4R1crK2RwUWo5WHkvcGJrRnFSNHovZXZUS2x1d1lBYVR2ejlFM2pHaTBW?=
 =?utf-8?B?TVJhNisvU0NnTzkxaGNUc1FFNWpSUlA2MGZ0ZzdPbFNlUlJyZnhCZmRTSzFM?=
 =?utf-8?B?eWRBR0UvVW9pbmd2N3RzVnNtSXM3SWpBa3FaUG92eCtNV0FZR3c5c25ydmI5?=
 =?utf-8?B?dVNxSFh3QlNJSmtPdGhNbkRYQ3lMWkpOZkpmaFVURFRSU2xUdTF6RUtMS21S?=
 =?utf-8?B?MUNaUUhjRXNUdHg5YUdBb0NYdUxzQWwzcTZMNld0T2gydVJpdE81OUVPMUZJ?=
 =?utf-8?B?NzFwNFZtcjZMLzkxOTIwOHNyenF6aEdvU25zOXllczVNK0Q3eDFtWGJDdlhW?=
 =?utf-8?B?YW1pajZVYm1oaHVJT29nR2NESnRjL0Vla0tNdlJjS3dVMkV6czZJdDRxMGFp?=
 =?utf-8?B?QldKWjI2RkMxRWw1VFBxYjdWRVhQSUd1UktNQ1REcDBncWhEd20zQ0MzWjdN?=
 =?utf-8?B?aEtvcU5DQUdvWVNCT2czWGRnMkdiV05PSjBrSE9EajN3Ty9kOFV2Z1g1RkFu?=
 =?utf-8?B?VDBJT2s4MEorVzZuamFRQ3k5OVVoUTk2RHJSSWFia2hrRk9ObzZiVUZIUitY?=
 =?utf-8?B?SzNxME9oT2VJOElFREFJL2Rzc1NtOVA3THpDeUc2NThDaVBzMzNxTDVBd0ts?=
 =?utf-8?B?K3hnSngzVzdwK0FsYTlsTURsUWpRK3p5QnE2dmZkUUo1WWtNNUF3R0tDZERP?=
 =?utf-8?B?ZXNYUHdzSU9PR0FBUldjWDRCaGRVVEFqRE1OdDN4ZVJGelFxeS9RWXg4bFRD?=
 =?utf-8?B?TFQzb3lzRVFRQzJpanBSQnpRUW1pd3NuNnpXL0k5MGdjdnVnMUtlYXBMSWRZ?=
 =?utf-8?B?M1djQzhmWk5rRExhY2ZRcW1wTExld2d6WW5SR01DZ1l1S3NJQi9KRndnampU?=
 =?utf-8?B?Q2dPUnBPUGxxUkg1SENRWXFrdmo2YmZZRVZGSXZXN283WkNYcUpEU240eko5?=
 =?utf-8?B?aEdoSXgyQ3hEOXNHMllyejV4QnV2NFNBK2FNVlZkTCtxeUg0OXhaVGpYNVpY?=
 =?utf-8?B?aEpRTjFXeER0RFpjcVlCT2dMSWlPSng1UXpYSXo3RXloQm1ILzdpMlZRTjNZ?=
 =?utf-8?B?R2d5TlpzR1ZtZUZaZitiZ1ZBRFVnVW9EZ3ZBVjI1TTIxK2JiNjJ4NkRVcFNR?=
 =?utf-8?B?SUt3WWd0NkplT091RUZWMmN1WmZxUlowTEdOZFNkUnQ2QnNRWGpVb1h4MFZa?=
 =?utf-8?B?N0dwaHg2TTd0bmhNclNoSlovNUlmNjJnU2dTUDlXMHRPa1F4S2thYnZJY0V1?=
 =?utf-8?Q?2HZA0tSVTn7UZjMcaIS08R1nr?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 77efaf7a-6304-44e0-dddc-08db39cf90ee
X-MS-Exchange-CrossTenant-AuthSource: MW4PR12MB5667.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Apr 2023 14:26:25.8223 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dxLkdAR5eCMf2cGCybx0eAG+I/6+Gzykz0LTDoUSKZBXIE0zWtUSRETJq4Cp65Uh0iNqLTJcpthArYnD98lYGw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB8090
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
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Kuehling,
 Felix" <Felix.Kuehling@amd.com>, "Yadav, Arvind" <Arvind.Yadav@amd.com>,
 "Koenig, Christian" <Christian.Koenig@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>


On 10/04/2023 16:04, Bas Nieuwenhuizen wrote:
> On Mon, Apr 10, 2023 at 4:01 PM Shashank Sharma <shashank.sharma@amd.com> wrote:
>>
>> On 10/04/2023 15:46, Bas Nieuwenhuizen wrote:
>>> On Mon, Apr 10, 2023 at 3:40 PM Sharma, Shashank
>>> <Shashank.Sharma@amd.com> wrote:
>>>> [AMD Official Use Only - General]
>>>>
>>>> Hello Bas,
>>>>
>>>> This is not the correct interpretation of the code, the USERQ_IOCTL has both the OPs (create and destroy), but th euser has to exclusively call  it.
>>>>
>>>> Please see the sample test program in the existing libDRM series (userq_test.c, it specifically calls amdgpu_free_userq, which does the destroy_OP
>>>>
>>>> for the IOCTL.
>>> In the presence of crashes the kernel should always be able to clean
>>> this up no? Otherwise there is a resource leak?
>> The crash handling is the same as any of the existing GPU resource which
>> are allocated and freed with IOCTL_OPs.
> Most of those are handled in the when the DRM fd gets closed (i.e.
> when the process exits):
>
> - buffers through drm_gem_release()
> - mappings in amdgpu_vm_fini
> - contexts in amdgpu_ctx_mgr_fini
>
> etc.
>
> Why would we do things differently for userspace queues? It doesn't
> look complicated looking at the above patch (which does seem to work).

As the code is in initial stage, I have not given much thoughts about 
handling resource leak due to app crash, but this seems like a good 
suggestion.

I am taking a note and will try to accommodate this in an upcoming 
version of the series.

- Shashank

>> To be honest a crash handling can be very elaborated and complex one,
>> and hence only can be done at the driver unload IMO, which doesn't help
>> at that stage,
>>
>> coz anyways driver will re-allocate the resources on next load.
>>
>> - Shashank
>>
>>>> - Shashank
>>>>
>>>> -----Original Message-----
>>>> From: Bas Nieuwenhuizen <bas@basnieuwenhuizen.nl>
>>>> Sent: 10 April 2023 11:26
>>>> To: Sharma, Shashank <Shashank.Sharma@amd.com>
>>>> Cc: amd-gfx@lists.freedesktop.org; Deucher, Alexander <Alexander.Deucher@amd.com>; Kuehling, Felix <Felix.Kuehling@amd.com>; Koenig, Christian <Christian.Koenig@amd.com>; Yadav, Arvind <Arvind.Yadav@amd.com>
>>>> Subject: Re: [PATCH v3 0/9] AMDGPU Usermode queues
>>>>
>>>> Hi Shashank,
>>>>
>>>> I think I found the issue: I wasn't destroying the user queue in my program and the kernel doesn't clean up any remaining user queues in the postclose hook. I think we need something like
>>>> https://github.com/BNieuwenhuizen/linux/commit/e90c8d1185da7353c12837973ceddf55ccc85d29
>>>> ?
>>>>
>>>> While running things multiple times now works, I still have problems doing multiple submissions from the same queue. Looking forward to the updated test/sample
>>>>
>>>> Thanks,
>>>> Bas
>>>>
>>>> On Mon, Apr 10, 2023 at 9:32 AM Sharma, Shashank <Shashank.Sharma@amd.com> wrote:
>>>>> [AMD Official Use Only - General]
>>>>>
>>>>> Hello Bas,
>>>>> Thanks for trying this out.
>>>>>
>>>>> This could be due to the doorbell as you mentioned, Usermode queue uses doorbell manager internally.
>>>>> This week, we are planning to publis the latest libDRM sample code which uses a doorbell object (instead of the doorbell hack IOCTL), adapting to that should fix your problem in my opinion.
>>>>> We have tested this full stack (libDRM test + Usermode queue + doorbell manager) for 500+ consecutive runs, and it worked well for us.
>>>>>
>>>>> You can use this integrated kernel stack (1+2) from my gitlab to build
>>>>> your kernel:
>>>>> https://gitlab.freedesktop.org/contactshashanksharma/userq-amdgpu/-/tr
>>>>> ee/integrated-db-and-uq-v3 Please stay tuned for updated libDRM
>>>>> changes with doorbell objects.
>>>>>
>>>>> Regards
>>>>> Shashank
>>>>> -----Original Message-----
>>>>> From: Bas Nieuwenhuizen <bas@basnieuwenhuizen.nl>
>>>>> Sent: 10 April 2023 02:37
>>>>> To: Sharma, Shashank <Shashank.Sharma@amd.com>
>>>>> Cc: amd-gfx@lists.freedesktop.org; Deucher, Alexander
>>>>> <Alexander.Deucher@amd.com>; Kuehling, Felix <Felix.Kuehling@amd.com>;
>>>>> Koenig, Christian <Christian.Koenig@amd.com>
>>>>> Subject: Re: [PATCH v3 0/9] AMDGPU Usermode queues
>>>>>
>>>>> Hi Shashank,
>>>>>
>>>>> I tried writing a program to experiment with usermode queues and I found some weird behavior: The first run of the program works as expected, while subsequent runs don't seem to do anything (and I allocate everything in GTT, so it should be zero initialized consistently). Is this a known issue?
>>>>>
>>>>> The linked libdrm code for the uapi still does a doorbell ioctl so it could very well be that I do the doorbell wrong (especially since the ioctl implementation was never shared AFAICT?), but it seems like the kernel submissions (i.e. write wptr in dwords to the wptr va and to the doorbell). Is it possible to update the test in libdrm?
>>>>>
>>>>> Code: https://gitlab.freedesktop.org/bnieuwenhuizen/usermode-queue
>>>>>
>>>>> Thanks,
>>>>> Bas
>>>>>
>>>>> On Wed, Mar 29, 2023 at 6:05 PM Shashank Sharma <shashank.sharma@amd.com> wrote:
>>>>>> This patch series introduces AMDGPU usermode queues for gfx workloads.
>>>>>> Usermode queues is a method of GPU workload submission into the
>>>>>> graphics hardware without any interaction with kernel/DRM schedulers.
>>>>>> In this method, a userspace graphics application can create its own
>>>>>> workqueue and submit it directly in the GPU HW.
>>>>>>
>>>>>> The general idea of how this is supposed to work:
>>>>>> - The application creates the following GPU objetcs:
>>>>>>     - A queue object to hold the workload packets.
>>>>>>     - A read pointer object.
>>>>>>     - A write pointer object.
>>>>>>     - A doorbell page.
>>>>>> - The application picks a 32-bit offset in the doorbell page for this queue.
>>>>>> - The application uses the usermode_queue_create IOCTL introduced in
>>>>>>     this patch, by passing the the GPU addresses of these objects (read
>>>>>>     ptr, write ptr, queue base address and 32-bit doorbell offset from
>>>>>>     the doorbell page)
>>>>>> - The kernel creates the queue and maps it in the HW.
>>>>>> - The application can start submitting the data in the queue as soon as
>>>>>>     the kernel IOCTL returns.
>>>>>> - After filling the workload data in the queue, the app must write the
>>>>>>     number of dwords added in the queue into the doorbell offset, and the
>>>>>>     GPU will start fetching the data.
>>>>>>
>>>>>> libDRM changes for this series and a sample DRM test program can be
>>>>>> found in the MESA merge request here:
>>>>>> https://gitlab.freedesktop.org/mesa/drm/-/merge_requests/287
>>>>>>
>>>>>> This patch series depends on the doorbell-manager changes, which are
>>>>>> being reviewed here:
>>>>>> https://patchwork.freedesktop.org/series/115802/
>>>>>>
>>>>>> Alex Deucher (1):
>>>>>>     drm/amdgpu: UAPI for user queue management
>>>>>>
>>>>>> Arvind Yadav (2):
>>>>>>     drm/amdgpu: add new parameters in v11_struct
>>>>>>     drm/amdgpu: map wptr BO into GART
>>>>>>
>>>>>> Shashank Sharma (6):
>>>>>>     drm/amdgpu: add usermode queue base code
>>>>>>     drm/amdgpu: add new IOCTL for usermode queue
>>>>>>     drm/amdgpu: create GFX-gen11 MQD for userqueue
>>>>>>     drm/amdgpu: create context space for usermode queue
>>>>>>     drm/amdgpu: map usermode queue into MES
>>>>>>     drm/amdgpu: generate doorbell index for userqueue
>>>>>>
>>>>>>    drivers/gpu/drm/amd/amdgpu/Makefile           |   3 +
>>>>>>    drivers/gpu/drm/amd/amdgpu/amdgpu.h           |  10 +-
>>>>>>    drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c       |   2 +
>>>>>>    drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c       |   6 +
>>>>>>    drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.c | 298
>>>>>> ++++++++++++++++++  .../drm/amd/amdgpu/amdgpu_userqueue_gfx_v11.c |
>>>>>> ++++++++++++++++++ 230 ++++++++++++++
>>>>>>    .../gpu/drm/amd/include/amdgpu_userqueue.h    |  66 ++++
>>>>>>    drivers/gpu/drm/amd/include/v11_structs.h     |  16 +-
>>>>>>    include/uapi/drm/amdgpu_drm.h                 |  55 ++++
>>>>>>    9 files changed, 677 insertions(+), 9 deletions(-)  create mode
>>>>>> 100644 drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.c
>>>>>>    create mode 100644
>>>>>> drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue_gfx_v11.c
>>>>>>    create mode 100644 drivers/gpu/drm/amd/include/amdgpu_userqueue.h
>>>>>>
>>>>>> --
>>>>>> 2.40.0
>>>>>>
