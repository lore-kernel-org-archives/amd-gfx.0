Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B55BCC433EF
	for <amd-gfx@archiver.kernel.org>; Tue,  8 Mar 2022 18:08:58 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EFA2C10E348;
	Tue,  8 Mar 2022 18:08:57 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2046.outbound.protection.outlook.com [40.107.223.46])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E040B10E31A
 for <amd-gfx@lists.freedesktop.org>; Tue,  8 Mar 2022 18:08:56 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GAoF3yBcxvJYNJ2ajF08imdqszt+g8+9ZV2akyQidagkbAi8broOPIEzjWSGx+r5zR9Mr/iKf9e+AnfjCJ9URFFFpDC4oRec4jyGkOFwhZdxb3MzAUEyAS0l7Wz6mON+4qHJTbN0VRMZ5Fz2NUdJt19QmN1fAp7kB/PBjtmMutwg4T9NvMyOnw41+pA64QR2uuytaeJNFY63LtZGn/RuXNBGzZwXjauGJ67XBgUKS8qJdZl/8B3EG03DA7q3cEcyXJtHJqVgY0PqRXgkf9WJxBn4eE9Uub+Sh0txpJqwqKOj9+OvswqOcr2o227K6wKEZhmPeGZNxHwLjjlWv7XChA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jEL8KIwGzBdusGAXxBYdQLd+Fxo4KjWvrc6atFlZxL8=;
 b=HxkoTQxB2kpIn8+ungLRWn8tVQVehhs/HzJh5+X3cw/prnsdoLJe5CTRoOrZ2r3NDtoCUwhjduUQt8cNDT2uDPKPDKmtjtRVZoqry/brVDIpM+1YL1GJJrBpdBeXAHwpzUH3j+6MxfgBq2rvSGV8fdSppR624cVL3iH5MsL9AZu/6pD+hUww4z7KjqIyP/XwQt2pUdhh3eQWY0lTUcgtVYQypAiuz1Vqgh5DEzDAXbG84NvRHBA/1gf8YcWCPqplE5K/n4ySb92oxBCYSRpPXWjHwH0MQ9Vf2KlunAMTyFkLO+RXsSh6Xj2D3QL3h6nZfiEFeDPOmUXLU0Fo7ZzAYA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jEL8KIwGzBdusGAXxBYdQLd+Fxo4KjWvrc6atFlZxL8=;
 b=VFIWODJ0mwmTqcVwb/hlkMJ8Qf+beCkJfd6eZjPrEPJOfDtkWv7XylfeSoDIp1/cupU/m0yJ50cyLNu69iJaLgrQZ2/s9hg9J9rDD/gp3nwwyFtXIRIgIN4hiP1d2ZdNtyhqKs8iySSvrpjn7J1B+wx3XR5gIqrANox0/WcJN8Q=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB5040.namprd12.prod.outlook.com (2603:10b6:5:38b::19)
 by DS7PR12MB5744.namprd12.prod.outlook.com (2603:10b6:8:73::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5038.19; Tue, 8 Mar
 2022 18:08:55 +0000
Received: from DM4PR12MB5040.namprd12.prod.outlook.com
 ([fe80::f037:e2a1:f108:125a]) by DM4PR12MB5040.namprd12.prod.outlook.com
 ([fe80::f037:e2a1:f108:125a%8]) with mapi id 15.20.5038.027; Tue, 8 Mar 2022
 18:08:55 +0000
Message-ID: <163a02be-834d-2813-78dc-9533e37c230f@amd.com>
Date: Tue, 8 Mar 2022 19:08:48 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.1
Subject: Re: [PATCH 1/2] drm: Add GPU reset sysfs event
Content-Language: en-US
To: "Limonciello, Mario" <mario.limonciello@amd.com>,
 Andrey Grodzovsky <andrey.grodzovsky@amd.com>,
 "Lazar, Lijo" <Lijo.Lazar@amd.com>,
 Shashank Sharma <contactshashanksharma@gmail.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>,
 Shyam-sundar S-k <Shyam-sundar.S-k@amd.com>,
 Sanket Goswami <Sanket.Goswami@amd.com>
References: <20220307162631.2496286-1-contactshashanksharma@gmail.com>
 <1eff0822-f410-fd1b-b9c7-6a54862de74a@amd.com>
 <BYAPR12MB461498EFB1E9A3A76A38735497099@BYAPR12MB4614.namprd12.prod.outlook.com>
 <5c32f2d0-e278-529c-be53-ffd5603cd472@amd.com>
 <b16fa66b-2712-633b-ee00-27916dbd32b3@amd.com>
 <975f7416-2f32-3207-c118-cdb56d2bae7c@amd.com>
 <11183b53-bd53-7afc-2fdf-f46183044dd2@amd.com>
 <c7c3ec4c-5345-b8b9-486f-e3d15e19c452@amd.com>
From: "Sharma, Shashank" <shashank.sharma@amd.com>
In-Reply-To: <c7c3ec4c-5345-b8b9-486f-e3d15e19c452@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: AS9PR06CA0046.eurprd06.prod.outlook.com
 (2603:10a6:20b:463::29) To DM4PR12MB5040.namprd12.prod.outlook.com
 (2603:10b6:5:38b::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 463d3736-5cca-4278-82b0-08da012eb554
X-MS-TrafficTypeDiagnostic: DS7PR12MB5744:EE_
X-Microsoft-Antispam-PRVS: <DS7PR12MB57448068ED497E71D6FDA93AF2099@DS7PR12MB5744.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: oux+1I4b2bBp7PXH64VGIbB2AZrzZsRkIyiJQpkfwNbUGFk8SoyAbzWnwXG68e5sZgD3kTJ/eERbCIglqLSRXdkKtnhV2pyOWYZOJmCL9QzZ7wKUHpyBIb1ZSxBLnH6qN7vYFC6RL26J330H115stKPmGOtnEEdsDzm7rj8vNSfs9ohaDnGkxTrJPA3q5SoyLpVHp4GRKNkjujqexB9AwGYAsZjJb9AFX8jCpZa89iSZ0ru2yl1a/8kOkQty/in/aCG7T0zL3WuqBjF7m8tnrluw3IeeG5s3zZQ8o/+VrcIKozSGLGW11ugVpZLw8QB8pu13MCsmfwssGytr9CeuUCYYjPQGce8lJp65dhOozAMO5+jcOWAuN81lftscDusp1AOsbH/5/3yWUYqMzUsFuxEWOSAHqKaampzkr0PJmAxs3mK/FFOl2KLULIR5kRyMLUz4i5fwG6VYkVyakhY5kUC9D7uxvvNhYhNcumib8ATgqQoeUXNGn2g4t5QZJblTH9LVv18PNI6UZZq05WemhH3swedYLkIJ5Tvhabjld7WWCJW10cTmtJBcakr2ex13VXUvWY8zKiTpBJWvHPla2Yy/e1Abq5WelYsyEpNiBECBbr0D9nlw3XmYjllfX8BVKmX9SxeZFjStG7MExhbIjVO+Tn1UsCOfzjirTMXXM5PLzoia6IfAYYz5XAgGEmXKifmV+n9fniWaJgzBwUXcteBio77JRPJDTtyYEXoQ0BIlz+DTJyfEBZJ5oHhPTrypjZIsZ7Hi1rdCc4OTlM6XplpmjxvTVZGzaqGRfhJDbb7ElmEsWecu8C7bDYQu7PxfRKT73bM0rgoL11eExXzGKQcE1UEdG7AhWYbTXlPXP1+6O8UNlt0hFsr+MNUmiuSe
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB5040.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(4636009)(366004)(26005)(186003)(2616005)(86362001)(966005)(6486002)(31696002)(38100700002)(83380400001)(66476007)(16799955002)(66556008)(8676002)(36756003)(66946007)(54906003)(6636002)(2906002)(4326008)(316002)(31686004)(110136005)(8936002)(5660300002)(45080400002)(508600001)(53546011)(6666004)(6512007)(6506007)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dHZkZjYxcTNjanNHejRXNEExTkZFamprV3JhY3EvQ2Yzay9LWGcxM0FMZm5L?=
 =?utf-8?B?K0hjS3VPenppdVorUkZPTFJ3YnQvTlBLQUQ5OS9RUFBBeTZSOVVENnJqRUZ1?=
 =?utf-8?B?QzFlSzdrUmIyRU9Zak0wSEZ4UllBZzM5a1V5R1N6VUs3aTN4dE9QQ0NZWlBa?=
 =?utf-8?B?VEhUaHRHYXQ4bVBZN3N1bEdnbzFOL3Q3M1NncWcrMFE5bzBoRnNrbFJWSEZT?=
 =?utf-8?B?UHV2MDJlcTRkaTZYODR6VWpDOTBoY1lKUjFlbEFFeGtDYWE0NTcwcm8ySDYx?=
 =?utf-8?B?Myt1TS9JbTRQNkZMR0Facjk5VHNhT2pQQUhya3VHN1JmMjZYN0ZTQStQM3ZV?=
 =?utf-8?B?WUJYSyt2b2p4VVNGOVhmT1o5NXQ3bElLTjlXU1kzU3c2RnZFVWZNQndUSjlz?=
 =?utf-8?B?OXEvM2ZUclZHaW41ZHh6KythUnRwTXdrVy9BM0tJYlZPNjVxYkdvQzBCdGE0?=
 =?utf-8?B?Q1RvZmp6Wm5YSExtZXVFUmo0KzJsSkpiUDZlTVNzR0xlMk0wcUZzZTZYNmVw?=
 =?utf-8?B?bWxMVXczV2puL0pML2JvaExFWmw0b0FMVEdVT3A5NU15VUVaTjBoQnBzdHhY?=
 =?utf-8?B?cktJRjlVVGp0RG5UdEo3cDRVUlBqY2JqTEJ2cjZQME85WVZ5dlpvdkRHSXRP?=
 =?utf-8?B?NmY1b1FRaXBtUk5PYkQ2YlVxWXlKWjdOanlFcCtaSDNvaVNzd3hZa0t2eGsx?=
 =?utf-8?B?MzZVemJ1RTZXVnh5T09wZXVZcVorWHVCNHpXeGpJVG9wZDR2NnRydmhFdy96?=
 =?utf-8?B?QVROdHZqNUFkV2RrZnNmWDA2T0svdlJIZzZHRnBpZ3VkZkhNandHUmJ5WEVL?=
 =?utf-8?B?ZGVQSGpGMUFzNERHaWdaL283Q2pyTVAyRXFRaWhKU1orWHRKdmszcDVFeVkx?=
 =?utf-8?B?WE5mNWZpeGpYcEo3ZE8wN2gvNEhLU0FVbG1LZWx4Zk93SDhUdDhGWUdsV1V4?=
 =?utf-8?B?VWN0WG4ybmVpUkNZTjlqSjd2UEVJc1NTSDdGMUpaSEZsdXBXVnlqaEIxU1RI?=
 =?utf-8?B?RHVIcER2dTRZREdYUmVMWWZVczdnM05LSDF1MlZybDJBcG1NTVhLa0hPQ3Qv?=
 =?utf-8?B?WTE0c2JBSTllN2dDODZVa1RMakQ1S1k0UnlZQk04REE2aUoxdWVyUlkzcmhZ?=
 =?utf-8?B?SG9qcGRlRnhtUDhha3dMYXplc0VPUTRmSFhzTTNnamlYNnNxL0x2cVpmNlhM?=
 =?utf-8?B?MGJNQnVIZkI3WUxLdWswcTNlVnhVWStKWXA3aTRNRGNBT0ZmdnhqMnIwc0dH?=
 =?utf-8?B?aXhBNk9TSlF5S2pZTVRMWWc0Z1dHZm9SZjJOcjN1TzdCbnB3MVhqdFRFcjNv?=
 =?utf-8?B?allaRGxZL2FaeU5rMHgzaUdGTDVQc0cvZEsyNVFSSmx1N0FRZ0V1Y05qZ3ph?=
 =?utf-8?B?S3pXRzZIMURBUEtjWnQwbnZSK0l3ekNiQUNBOENkNHhuNFZQbW1IMDBkVEo2?=
 =?utf-8?B?V0JUVTI4MnpEdlBnSVFvQmNrZStUVThydE4yZjJ3VXZYbWFIZWpiV1hDQTdF?=
 =?utf-8?B?c1FuQ3BXRlhCOGJLbkt6Y09kamwrOUw1bUkzZmJHSHBITldhNzgzblpTcHhZ?=
 =?utf-8?B?WmZFQW5MeE43ckVzRFdDaFVBNElCMTh2Z2c0bUVDcnFtNlBsZ3ZFUXhjcWky?=
 =?utf-8?B?NGR4aTNCaHFuRnUza29hcm16T3NkTmwwK05VZEhJdFh2b1NqMXB6WFBKWWZj?=
 =?utf-8?B?U0NmdWh3QVlsSTh2UUdwL1paRDU2NytNMVpoREpxMTNiOHNRMlVmWllReTM5?=
 =?utf-8?B?RTF6UGpvOW5Bd2QyaFI5ZUtPVG93eHIvQ0c5V05GUFBReUNzZEltdlB1L09p?=
 =?utf-8?B?WnEzWEUzU0ttMWVSMU11akhtU3JIcWNETitvU3JoYnFQaUI1djFjVTBXSmRt?=
 =?utf-8?B?cjdQQm9tNjJGazB4Y2dScW50UzROaW5Ja2k4TU5NZDBGcWVaZ2xEaWRvdHc2?=
 =?utf-8?B?WWY0TG5iZzV3VWUyMmZIbzQ1U0I0TmhqY3BTR25BMkJ2S0h3MTZqQlkrZzZC?=
 =?utf-8?B?Mzg3R2NuV3VQbzVta3dMTXhpTGxPS3dSa0MyZktZQzU3RTZCWkNjc3RMR28w?=
 =?utf-8?B?UGtXRkpFbmVHTEFWOTlJdE5qZ085RVd1ZmJIMmFEMUJBUktYaXJuMUFnRVdL?=
 =?utf-8?B?bjNDa3g5MHZqdUMyczFjamJKVUw2ckFFZm1odjlHMWJTVUF3eUZKT09GOHpY?=
 =?utf-8?Q?M9lh0x6DKrD1N+Hm+CMmUmI=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 463d3736-5cca-4278-82b0-08da012eb554
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5040.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Mar 2022 18:08:55.0871 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kyzWcRTZYfXMIBzOlMYSgVtHwE3BPUzM++vGBXsG6zVwJrvOaaF8jARNdWaken/BfyZjS8aqnDjYrt97N9IX+w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB5744
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
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Somalapuram,
 Amaranath" <Amaranath.Somalapuram@amd.com>, "Koenig,
 Christian" <Christian.Koenig@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Hey Mario,

On 3/8/2022 6:27 PM, Limonciello, Mario wrote:
> On 3/8/2022 10:57, Sharma, Shashank wrote:
>>
>>
>> On 3/8/2022 5:55 PM, Andrey Grodzovsky wrote:
>>> You can read on their side here - 
>>> https://www.phoronix.com/scan.php?page=news_item&px=AMD-STB-Linux-5.17 and 
>>> see their patch. THey don't have as clean
>>> interface as we do to retrieve the buffer and currently it's 
>>> hard-coded for debugfs dump but it looks like pretty straight forward 
>>> to expose their buffer to external
>>> client like amdgpu.

>>
>> Noted, thanks for the pointer.
>> - Shashank
> 
> Yeah I think this is a great idea for APU, but need to keep in mind 
> amd-pmc is only activated if APU is configured for s0i3.  So in the 
> IS_APU check you will need to test for set for s0i3 and return an error 
> code if not set.
> 
> For APU it's currently fetched on demand from debugfs.  If you can 
> "easily" export a symbol I say go for it and include a patch in your 
> series.  

Yep, if the info is available via debugfs, I don't see a reason why 
can't we fetch that directly from its lower layers. May I know the name 
of this debugfs entry ?

- Shashank

If not my suggestion is to stub this out and let Shyam and
> Sanket fill in the stub after they can sort out the exporting it to 
> another driver.
> 
>>>
>>> Andrey
>>>
>>> On 2022-03-08 11:46, Sharma, Shashank wrote:
>>>> I have a very limited understanding of PMC driver and its 
>>>> interfaces, so I would just go ahead and rely on Andrey's 
>>>> judgement/recommendation on this :)
>>>>
>>>> - Shashank
>>>>
>>>> On 3/8/2022 5:39 PM, Andrey Grodzovsky wrote:
>>>>> As long as PMC driver provides clear interface to retrieve the info 
>>>>> there should be no issue to call either amdgpu interface or PMC 
>>>>> interface using IS_APU (or something alike in the code)
>>>>> We probably should add a wrapper function around this logic in amdgpu.
>>>>>
>>>>> Andrey
>>>>>
>>>>> On 2022-03-08 11:36, Lazar, Lijo wrote:
>>>>>>
>>>>>> [AMD Official Use Only]
>>>>>>
>>>>>>
>>>>>> +Mario
>>>>>>
>>>>>> I guess that means the functionality needs to be present in amdgpu 
>>>>>> for APUs also. Presently, this is taken care by PMC driver for APUs.
>>>>>>
>>>>>> Thanks,
>>>>>> Lijo
>>>>>> ------------------------------------------------------------------------ 
>>>>>>
>>>>>> *From:* amd-gfx <amd-gfx-bounces@lists.freedesktop.org> on behalf 
>>>>>> of Andrey Grodzovsky <andrey.grodzovsky@amd.com>
>>>>>> *Sent:* Tuesday, March 8, 2022 9:55:03 PM
>>>>>> *To:* Shashank Sharma <contactshashanksharma@gmail.com>; 
>>>>>> amd-gfx@lists.freedesktop.org <amd-gfx@lists.freedesktop.org>
>>>>>> *Cc:* Deucher, Alexander <Alexander.Deucher@amd.com>; Somalapuram, 
>>>>>> Amaranath <Amaranath.Somalapuram@amd.com>; Koenig, Christian 
>>>>>> <Christian.Koenig@amd.com>; Sharma, Shashank 
>>>>>> <Shashank.Sharma@amd.com>
>>>>>> *Subject:* Re: [PATCH 1/2] drm: Add GPU reset sysfs event
>>>>>>
>>>>>> On 2022-03-07 11:26, Shashank Sharma wrote:
>>>>>> > From: Shashank Sharma <shashank.sharma@amd.com>
>>>>>> >
>>>>>> > This patch adds a new sysfs event, which will indicate
>>>>>> > the userland about a GPU reset, and can also provide
>>>>>> > some information like:
>>>>>> > - which PID was involved in the GPU reset
>>>>>> > - what was the GPU status (using flags)
>>>>>> >
>>>>>> > This patch also introduces the first flag of the flags
>>>>>> > bitmap, which can be appended as and when required.
>>>>>>
>>>>>>
>>>>>> I am reminding again about another important piece of info which 
>>>>>> you can add
>>>>>> here and that is Smart Trace Buffer dump [1]. The buffer size is HW
>>>>>> specific but
>>>>>> from what I see there is no problem to just amend it as part of 
>>>>>> envp[]
>>>>>> initialization.
>>>>>> bellow.
>>>>>>
>>>>>> The interface to get the buffer is smu_stb_collect_info and usage 
>>>>>> can be
>>>>>> seen from
>>>>>> frebugfs interface in smu_stb_debugfs_open
>>>>>>
>>>>>> [1] - 
>>>>>> https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Fwww.spinics.net%2Flists%2Famd-gfx%2Fmsg70751.html&amp;data=04%7C01%7Clijo.lazar%40amd.com%7C80bc3f07e2d0441d44a108da012036dc%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637823535167679490%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C3000&amp;sdata=53l7KlTf%2BICKkZkLVwFh6nRTjkAh%2FDpOat5DRoyKIx0%3D&amp;reserved=0 
>>>>>> <https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Fwww.spinics.net%2Flists%2Famd-gfx%2Fmsg70751.html&amp;data=04%7C01%7Clijo.lazar%40amd.com%7C80bc3f07e2d0441d44a108da012036dc%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637823535167679490%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C3000&amp;sdata=53l7KlTf%2BICKkZkLVwFh6nRTjkAh%2FDpOat5DRoyKIx0%3D&amp;reserved=0> 
>>>>>>
>>>>>>
>>>>>> Andrey
>>>>>>
>>>>>>
>>>>>> >
>>>>>> > Cc: Alexandar Deucher <alexander.deucher@amd.com>
>>>>>> > Cc: Christian Koenig <christian.koenig@amd.com>
>>>>>> > Signed-off-by: Shashank Sharma <shashank.sharma@amd.com>
>>>>>> > ---
>>>>>> >   drivers/gpu/drm/drm_sysfs.c | 24 ++++++++++++++++++++++++
>>>>>> >   include/drm/drm_sysfs.h     |  3 +++
>>>>>> >   2 files changed, 27 insertions(+)
>>>>>> >
>>>>>> > diff --git a/drivers/gpu/drm/drm_sysfs.c 
>>>>>> b/drivers/gpu/drm/drm_sysfs.c
>>>>>> > index 430e00b16eec..52a015161431 100644
>>>>>> > --- a/drivers/gpu/drm/drm_sysfs.c
>>>>>> > +++ b/drivers/gpu/drm/drm_sysfs.c
>>>>>> > @@ -409,6 +409,30 @@ void drm_sysfs_hotplug_event(struct 
>>>>>> drm_device *dev)
>>>>>> >   }
>>>>>> >   EXPORT_SYMBOL(drm_sysfs_hotplug_event);
>>>>>> >
>>>>>> > +/**
>>>>>> > + * drm_sysfs_reset_event - generate a DRM uevent to indicate 
>>>>>> GPU reset
>>>>>> > + * @dev: DRM device
>>>>>> > + * @pid: The process ID involve with the reset
>>>>>> > + * @flags: Any other information about the GPU status
>>>>>> > + *
>>>>>> > + * Send a uevent for the DRM device specified by @dev. This 
>>>>>> indicates
>>>>>> > + * user that a GPU reset has occurred, so that the interested 
>>>>>> client
>>>>>> > + * can take any recovery or profiling measure, when required.
>>>>>> > + */
>>>>>> > +void drm_sysfs_reset_event(struct drm_device *dev, uint64_t 
>>>>>> pid, uint32_t flags)
>>>>>> > +{
>>>>>> > +     unsigned char pid_str[21], flags_str[15];
>>>>>> > +     unsigned char reset_str[] = "RESET=1";
>>>>>> > +     char *envp[] = { reset_str, pid_str, flags_str, NULL };
>>>>>> > +
>>>>>> > +     DRM_DEBUG("generating reset event\n");
>>>>>> > +
>>>>>> > +     snprintf(pid_str, ARRAY_SIZE(pid_str), "PID=%lu", pid);
>>>>>> > +     snprintf(flags_str, ARRAY_SIZE(flags_str), "FLAGS=%u", 
>>>>>> flags);
>>>>>> > + kobject_uevent_env(&dev->primary->kdev->kobj, KOBJ_CHANGE, envp);
>>>>>> > +}
>>>>>> > +EXPORT_SYMBOL(drm_sysfs_reset_event);
>>>>>> > +
>>>>>> >   /**
>>>>>> >    * drm_sysfs_connector_hotplug_event - generate a DRM uevent 
>>>>>> for any connector
>>>>>> >    * change
>>>>>> > diff --git a/include/drm/drm_sysfs.h b/include/drm/drm_sysfs.h
>>>>>> > index 6273cac44e47..63f00fe8054c 100644
>>>>>> > --- a/include/drm/drm_sysfs.h
>>>>>> > +++ b/include/drm/drm_sysfs.h
>>>>>> > @@ -2,6 +2,8 @@
>>>>>> >   #ifndef _DRM_SYSFS_H_
>>>>>> >   #define _DRM_SYSFS_H_
>>>>>> >
>>>>>> > +#define DRM_GPU_RESET_FLAG_VRAM_VALID (1 << 0)
>>>>>> > +
>>>>>> >   struct drm_device;
>>>>>> >   struct device;
>>>>>> >   struct drm_connector;
>>>>>> > @@ -11,6 +13,7 @@ int drm_class_device_register(struct device 
>>>>>> *dev);
>>>>>> >   void drm_class_device_unregister(struct device *dev);
>>>>>> >
>>>>>> >   void drm_sysfs_hotplug_event(struct drm_device *dev);
>>>>>> > +void drm_sysfs_reset_event(struct drm_device *dev, uint64_t 
>>>>>> pid, uint32_t reset_flags);
>>>>>> >   void drm_sysfs_connector_hotplug_event(struct drm_connector 
>>>>>> *connector);
>>>>>> >   void drm_sysfs_connector_status_event(struct drm_connector 
>>>>>> *connector,
>>>>>> >                                      struct drm_property 
>>>>>> *property);
> 
