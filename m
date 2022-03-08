Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B97A9C433F5
	for <amd-gfx@archiver.kernel.org>; Tue,  8 Mar 2022 16:55:37 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0D27710E52C;
	Tue,  8 Mar 2022 16:55:34 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2047.outbound.protection.outlook.com [40.107.92.47])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EC4BA10E716
 for <amd-gfx@lists.freedesktop.org>; Tue,  8 Mar 2022 16:55:32 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=b13FiJgEU0I5lX/14zP4mSnLGKngoUVP34aZNmmYf0NxBmJPkFCSL5Rljm0FJxMjUuRDflVhdEnziyR34++8NmV3O20Tf8ZLEoaSwfsVRayDsl1Qxj2MZjfcVBydTmb06iePV8qLySI7X641HKiolv8d8b0IB5IT434o9DP1uIc6gi4L9N9eTuaCithWzr2v6B+OXZDzdBiM9JvUtJKuHMK/bNBM7h1ubVgCChu0NQEOkYYranvlpDccuKg/ft8ad+wVjgvKGH/Sy4joZn37+XjtXDDUV7MvpXdNlNdZwiryYKbwqB8pXLWdgYpV30eVpkcy6nitIrLXeLMKm3EIDg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PTCtD0wnrIrc+xx9DoYA2Sek/cfnVn3r1ORS2z56vyg=;
 b=SHwAVd7Au5e5xKv0a6SgFMOPJSjOFw3B4yY6cYrNWCvpH0s2qM8L6kHEMXvSCBJWF3aK/RvgfVIJqGuws3ntIi3bxxxudR1hjEK9Fkk21D7WSMi0+RnoOj8VKGehmV9T8lpWFN4C7VFAPYXrjyJlJevmHeEVSBnQt9qMbE4qvXG84cxB9JiYGgQfLHjZFk68hvFIxdtA0WMnxeSRflb+jsLk0EEyQujO0R/Y0wllJGPbIoFPzdyb0EbqCqLLu9gzh6s/V9ImdHN6P2j0Ecm55kyvoBQAkUMo1/jWNtH/0d4qnJOVHLnh5rafegburPHmD2V0c6xA69vfCjyfJ1003w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PTCtD0wnrIrc+xx9DoYA2Sek/cfnVn3r1ORS2z56vyg=;
 b=F6okf1L2FweqbJD/064KmNczDYuGBYgi8wcva/lGs/1shc3bAC1GbkLwuEHuWNO5Aqco0jQSrXiFHQ+d+apgHIKVRcMzHhIm6WpMSTdpKknEM1/6PilRwZRS6Vo8dgD74myuy25dHZluNBSlIiK1bwpCu6JMQ1AU2N2ciFRu7V8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM5PR12MB1947.namprd12.prod.outlook.com (2603:10b6:3:111::23)
 by BN6PR12MB1665.namprd12.prod.outlook.com (2603:10b6:405:7::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5038.14; Tue, 8 Mar
 2022 16:55:30 +0000
Received: from DM5PR12MB1947.namprd12.prod.outlook.com
 ([fe80::90bd:5b12:918d:5703]) by DM5PR12MB1947.namprd12.prod.outlook.com
 ([fe80::90bd:5b12:918d:5703%5]) with mapi id 15.20.5038.027; Tue, 8 Mar 2022
 16:55:29 +0000
Message-ID: <975f7416-2f32-3207-c118-cdb56d2bae7c@amd.com>
Date: Tue, 8 Mar 2022 11:55:26 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH 1/2] drm: Add GPU reset sysfs event
Content-Language: en-US
To: "Sharma, Shashank" <shashank.sharma@amd.com>,
 "Lazar, Lijo" <Lijo.Lazar@amd.com>,
 Shashank Sharma <contactshashanksharma@gmail.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
References: <20220307162631.2496286-1-contactshashanksharma@gmail.com>
 <1eff0822-f410-fd1b-b9c7-6a54862de74a@amd.com>
 <BYAPR12MB461498EFB1E9A3A76A38735497099@BYAPR12MB4614.namprd12.prod.outlook.com>
 <5c32f2d0-e278-529c-be53-ffd5603cd472@amd.com>
 <b16fa66b-2712-633b-ee00-27916dbd32b3@amd.com>
From: Andrey Grodzovsky <andrey.grodzovsky@amd.com>
In-Reply-To: <b16fa66b-2712-633b-ee00-27916dbd32b3@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: YT3PR01CA0033.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:82::19) To DM5PR12MB1947.namprd12.prod.outlook.com
 (2603:10b6:3:111::23)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a293437e-ad10-4a48-7e09-08da01247387
X-MS-TrafficTypeDiagnostic: BN6PR12MB1665:EE_
X-Microsoft-Antispam-PRVS: <BN6PR12MB1665A182F8F05B1FE440CF40EA099@BN6PR12MB1665.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 19jAK/YE9ewfkH9XWI9IbgK8vEpAo+v+vjAWnqs6G/qVwNB9T67354M82beHrQJ1QTIpvfIak23Epu/Cd/3E5uhSj96VdiS0iF5CkRqeNxHDsNJuMaKhCGvwHo88qeIgWo6TYndptVOpZ88oZBN7WzL1Jc3c4ae0hE8zGffqKS7Duf529kB4qE50+poW/Cuv0AGQOQ8Ozi46lHDg0f+CqPsdibFs4QCrfUdu4mZsVEwgKxsXUqXDAz3Agg/m1niL8bzdjRgbgrEp3QcMRmTj+FI35571VNlGhs/FxfFRaBAyymcYVwJDDKE3M9MXJkC8TIr2RkYTo3Ac4lc/DWR1bou7o+gRiNjqRs9iBSTfXYIMqgS2oFYFINNZ3Nv/RsEJAxHe05ahAH9V1s7et1ZcJGxpga1nJtHawfCJT/EvrlULM8E7fZO1Wk/jqfPf2x5wtQg2hY6c8ByR0GeA9AAx63G3js1ShyiQo+Wer4/93x+48U4ZuSjy+2bL4pFd6Iru3bcIexROt0hDrA/qI8Rlv2E7YLU8es2xMvaDOi5L+pI569EmIrX7ynfM2V8QoNMNVhx15GpX145ioqfIgonQZU7oFWq1KOsZjy0rathzo6acm9T0Z0er2FRlxOD0OM2ie0btWzh4XImuw+C0CR87bHjutATZn00uazMpd5PJpsmDYu/3ORREdxFzpb/UezXTeF8MRPYKq/pccJGucCpc8ErIUCs8IZrsiX0SuzT8ktu7/VZ5++7hJBdXeCMOkBOBxuBtjcqT31fWEGcYc1uPzCoHzHBB6Ms2JJev6uqdeJspIfa6xzq44wP4OQRe3ZjVWUvI7CbGgaokr1hf2I7WcFXRzR5KXZVHepI+4shY9+c=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM5PR12MB1947.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(4636009)(366004)(2906002)(44832011)(38100700002)(54906003)(45080400002)(508600001)(53546011)(5660300002)(2616005)(16799955002)(6512007)(36756003)(31686004)(316002)(110136005)(966005)(6486002)(6666004)(6506007)(66476007)(186003)(8676002)(66946007)(4326008)(66556008)(86362001)(83380400001)(8936002)(31696002)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RW95YnNUdWRtNkxmTGlpd1NSQVlmUjZ1T3p6WkdIb1h4ZGpnT3oxREdCMWZS?=
 =?utf-8?B?Q1ZYZ245bXZqOVBqREN0bXp0OUZTc0RRbzVzTVBtQmIwMUQvUFQrYit5SSti?=
 =?utf-8?B?NENwZXMwTUtTTHlJdnhQd1JwdUFRd29iUm9VeUhCVkI1NjZGbk0xd0hvQzg4?=
 =?utf-8?B?Q1d4NjlHd0VQUmFPdkFELzBxNC9mUHVtNTZBNFNIdjBXWnhaRVdvdk1wczZj?=
 =?utf-8?B?RWhuUzl0RFhiWTNRbERyaGtCTU5EN24xVmRoSjlXaVVkNjVMRE5xeFBlSnNl?=
 =?utf-8?B?N3phUmliRExpdXFtVWFjVGxaUkYvRXVCWHZGYk12V2Z4WWRaektKeTRzOHp1?=
 =?utf-8?B?QXBDcldVc2x6UlcwRkNLZWFtVmFEanFvbzMwdFBQWXZXV08zWmVJSk5VQUh4?=
 =?utf-8?B?YWVtSHlJQTdBTmJXTU1GYngwcWsxNnZXajI1WjB1bzZmSEd4UHRWTy9jVFI4?=
 =?utf-8?B?WGN3OW5PdEZhNHk0TC9ZV0FSQS9sWUhTOVAyblVLdHZkWXZGOVNXYVpRRkRX?=
 =?utf-8?B?OEkvT3R6R1dYbDduUU1KcTRWMWM4MXo4enNIRDk5SE9VR3J4STlPVXFDcHZR?=
 =?utf-8?B?OVN0L3QzdUM5dW14U2ZFMUtOWG1lZWZaVmg2OUduRlh6VVh2RjlydXJUNnBU?=
 =?utf-8?B?R2trNklvS0Y0bjEyNk5ZamdWTEsrSmdlcmRRa3VvM241bjhMdFI1akk2a2xi?=
 =?utf-8?B?SHpzb1J6ajR1QmZxT1F0cmx2L2k1VCttUGJwb0tCckFQTEtXcGtEMEVId1hF?=
 =?utf-8?B?c2R4TzE3RXovWUZ6clpFT05jWi82Szd2bHlYdWtuVFZBeEI3YzRXQzJLL0RE?=
 =?utf-8?B?UlEyMlQ2K25VN1ZKbW1YamVCSmE2STdHRDBwWHJZRHZBbnlBc3pOY2pvMTFn?=
 =?utf-8?B?VFNYNVc0TkpncEpqdnpuemNYelJCWksvcHhvUGdlZmhpVHFzdkFnKzlmVFI4?=
 =?utf-8?B?QjlxVlRoa1ZRbEt6RjhIRWpBQ0ZZWGF3NzI4TFFjMHdUcEh5Z0JVOTdtZTZM?=
 =?utf-8?B?Qzk4MVJ4a0ppSzVOcU1rNnp6WFAveVkyYWx1UDZWV2lHKytnWFkxbFYvWmsx?=
 =?utf-8?B?K0lhbE1icENUUDErSG0wN2NUbXY1SExsNXZPbzZqYVp5TjJHUFYyMlI3V2ho?=
 =?utf-8?B?S3FlVDhYYjlOdGpCVUkzTTFKYjJ6OU44ZjkvQUxBZW56WlZ1Rk5NU1l4a0VV?=
 =?utf-8?B?TTF0eVpWT3k2cmhoN2UyQlk3dTM0YWwxdXhSUW5mYzdmc0pVaDlJMFVGczdp?=
 =?utf-8?B?cUZSRDd1WHFwTlViUFB3Y3J4ZUoxUFpjcDloUHFQSllhUFV6dWFzNHZhU2ty?=
 =?utf-8?B?ZnRzZm0zWDBWTzlOSWR3NVlHaTcwTFhMYWlWNVVPZkI1cjZLc05JRml6WlRj?=
 =?utf-8?B?cUxabkNtdS8rSDBGcUhySzhld0JYUFVLN2VZdENLcHRLdzhqV08rLzQ2VnVP?=
 =?utf-8?B?eFU1OElnY3R0Wnh2SXU1ZnFJTEVyYUdyMkswMk56Z2h0S1FlMmZ6c3VwWlVJ?=
 =?utf-8?B?NnhUVXE0Y3BKSU50UGxUZXNBNHpDTVI0OE5JaEtqVjNQV0VPWDZaeGptMk5y?=
 =?utf-8?B?WUJ0NElJWEdJMDh5YXdKMTNXVy9UTnRHMkZyanQvS0w3U2prTm1TVG5xYVMw?=
 =?utf-8?B?bFhsQ1JNdDJqNFhiVDQxaE9VR0taLy9OWjlFTlBoUTlJZDBSVjFXVUtSd3dj?=
 =?utf-8?B?MHVWU2ZINGxzQmxzb2NjZUk2RFBiUG9kNjhGUnU1UzVzKzBUUG5wR1hmN1V3?=
 =?utf-8?B?NXVTY3czYWt0OFhvWnRSZ1BmNW1ualBmT1FCQ2J6S0NnTW1FUUtualJvc0F6?=
 =?utf-8?B?T1FYdElWNnBPaisxeXc0U1lIZ1RkV0FTQjdiR0h3UDIvd0JQelZTSlFTYm4r?=
 =?utf-8?B?RVBQSkEyUDlhN1BPdU1pVU81RU9hOFQ5TmM0eVd0ZXh0TDVWbEZjRUswZGk4?=
 =?utf-8?B?L1BUdUFjV3FQRW1yYlJoV3U1RTQ0ZlN1VHp0WkhRQXh0bzRzR1kzZzZVR3c4?=
 =?utf-8?B?T2lTWkJnWjI2UmVTcWo4WGlkdnZndU9WdTdXcldhbmpkVG1iZCt4eldMNExY?=
 =?utf-8?B?RlZ2dDBuZnhuT3VMaFRYazhBM3ZkbmozTWFZaWJTcEJBYWRsZW8vbm5tOGpJ?=
 =?utf-8?B?ZFlpMDRXNnU0Mk5KNGVDSFdXMWJMT0x3bnhtMXBRdGxlUlcyUWpmMForOHNZ?=
 =?utf-8?B?RUtJb0ljMit2aXp5MnM0cWlxbE05K0YxaFM4eFU1VFJ3TEdBa0Y0WlcvNlJR?=
 =?utf-8?Q?4tLv8TDF2gl1h4CH/kBMPCQzUHOFh+9FJvCW8BCWRo=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a293437e-ad10-4a48-7e09-08da01247387
X-MS-Exchange-CrossTenant-AuthSource: DM5PR12MB1947.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Mar 2022 16:55:29.6462 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6gysVXnW4swpiku62+xiBQQNE/bspK/lCZsFsqihCcl8Ir9RILxqQCHblNJQ7Bzmxcfd/aSz4DSQI7dvKMGFww==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR12MB1665
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
 Christian" <Christian.Koenig@amd.com>, "Limonciello,
 Mario" <Mario.Limonciello@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

You can read on their side here - 
https://www.phoronix.com/scan.php?page=news_item&px=AMD-STB-Linux-5.17 
and see their patch. THey don't have as clean
interface as we do to retrieve the buffer and currently it's hard-coded 
for debugfs dump but it looks like pretty straight forward to expose 
their buffer to external
client like amdgpu.

Andrey

On 2022-03-08 11:46, Sharma, Shashank wrote:
> I have a very limited understanding of PMC driver and its interfaces, 
> so I would just go ahead and rely on Andrey's judgement/recommendation 
> on this :)
>
> - Shashank
>
> On 3/8/2022 5:39 PM, Andrey Grodzovsky wrote:
>> As long as PMC driver provides clear interface to retrieve the info 
>> there should be no issue to call either amdgpu interface or PMC 
>> interface using IS_APU (or something alike in the code)
>> We probably should add a wrapper function around this logic in amdgpu.
>>
>> Andrey
>>
>> On 2022-03-08 11:36, Lazar, Lijo wrote:
>>>
>>> [AMD Official Use Only]
>>>
>>>
>>> +Mario
>>>
>>> I guess that means the functionality needs to be present in amdgpu 
>>> for APUs also. Presently, this is taken care by PMC driver for APUs.
>>>
>>> Thanks,
>>> Lijo
>>> ------------------------------------------------------------------------ 
>>>
>>> *From:* amd-gfx <amd-gfx-bounces@lists.freedesktop.org> on behalf of 
>>> Andrey Grodzovsky <andrey.grodzovsky@amd.com>
>>> *Sent:* Tuesday, March 8, 2022 9:55:03 PM
>>> *To:* Shashank Sharma <contactshashanksharma@gmail.com>; 
>>> amd-gfx@lists.freedesktop.org <amd-gfx@lists.freedesktop.org>
>>> *Cc:* Deucher, Alexander <Alexander.Deucher@amd.com>; Somalapuram, 
>>> Amaranath <Amaranath.Somalapuram@amd.com>; Koenig, Christian 
>>> <Christian.Koenig@amd.com>; Sharma, Shashank <Shashank.Sharma@amd.com>
>>> *Subject:* Re: [PATCH 1/2] drm: Add GPU reset sysfs event
>>>
>>> On 2022-03-07 11:26, Shashank Sharma wrote:
>>> > From: Shashank Sharma <shashank.sharma@amd.com>
>>> >
>>> > This patch adds a new sysfs event, which will indicate
>>> > the userland about a GPU reset, and can also provide
>>> > some information like:
>>> > - which PID was involved in the GPU reset
>>> > - what was the GPU status (using flags)
>>> >
>>> > This patch also introduces the first flag of the flags
>>> > bitmap, which can be appended as and when required.
>>>
>>>
>>> I am reminding again about another important piece of info which you 
>>> can add
>>> here and that is Smart Trace Buffer dump [1]. The buffer size is HW
>>> specific but
>>> from what I see there is no problem to just amend it as part of envp[]
>>> initialization.
>>> bellow.
>>>
>>> The interface to get the buffer is smu_stb_collect_info and usage 
>>> can be
>>> seen from
>>> frebugfs interface in smu_stb_debugfs_open
>>>
>>> [1] - 
>>> https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Fwww.spinics.net%2Flists%2Famd-gfx%2Fmsg70751.html&amp;data=04%7C01%7Clijo.lazar%40amd.com%7C80bc3f07e2d0441d44a108da012036dc%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637823535167679490%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C3000&amp;sdata=53l7KlTf%2BICKkZkLVwFh6nRTjkAh%2FDpOat5DRoyKIx0%3D&amp;reserved=0 
>>> <https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Fwww.spinics.net%2Flists%2Famd-gfx%2Fmsg70751.html&amp;data=04%7C01%7Clijo.lazar%40amd.com%7C80bc3f07e2d0441d44a108da012036dc%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637823535167679490%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C3000&amp;sdata=53l7KlTf%2BICKkZkLVwFh6nRTjkAh%2FDpOat5DRoyKIx0%3D&amp;reserved=0> 
>>>
>>>
>>> Andrey
>>>
>>>
>>> >
>>> > Cc: Alexandar Deucher <alexander.deucher@amd.com>
>>> > Cc: Christian Koenig <christian.koenig@amd.com>
>>> > Signed-off-by: Shashank Sharma <shashank.sharma@amd.com>
>>> > ---
>>> >   drivers/gpu/drm/drm_sysfs.c | 24 ++++++++++++++++++++++++
>>> >   include/drm/drm_sysfs.h     |  3 +++
>>> >   2 files changed, 27 insertions(+)
>>> >
>>> > diff --git a/drivers/gpu/drm/drm_sysfs.c 
>>> b/drivers/gpu/drm/drm_sysfs.c
>>> > index 430e00b16eec..52a015161431 100644
>>> > --- a/drivers/gpu/drm/drm_sysfs.c
>>> > +++ b/drivers/gpu/drm/drm_sysfs.c
>>> > @@ -409,6 +409,30 @@ void drm_sysfs_hotplug_event(struct 
>>> drm_device *dev)
>>> >   }
>>> >   EXPORT_SYMBOL(drm_sysfs_hotplug_event);
>>> >
>>> > +/**
>>> > + * drm_sysfs_reset_event - generate a DRM uevent to indicate GPU 
>>> reset
>>> > + * @dev: DRM device
>>> > + * @pid: The process ID involve with the reset
>>> > + * @flags: Any other information about the GPU status
>>> > + *
>>> > + * Send a uevent for the DRM device specified by @dev. This 
>>> indicates
>>> > + * user that a GPU reset has occurred, so that the interested client
>>> > + * can take any recovery or profiling measure, when required.
>>> > + */
>>> > +void drm_sysfs_reset_event(struct drm_device *dev, uint64_t pid, 
>>> uint32_t flags)
>>> > +{
>>> > +     unsigned char pid_str[21], flags_str[15];
>>> > +     unsigned char reset_str[] = "RESET=1";
>>> > +     char *envp[] = { reset_str, pid_str, flags_str, NULL };
>>> > +
>>> > +     DRM_DEBUG("generating reset event\n");
>>> > +
>>> > +     snprintf(pid_str, ARRAY_SIZE(pid_str), "PID=%lu", pid);
>>> > +     snprintf(flags_str, ARRAY_SIZE(flags_str), "FLAGS=%u", flags);
>>> > + kobject_uevent_env(&dev->primary->kdev->kobj, KOBJ_CHANGE, envp);
>>> > +}
>>> > +EXPORT_SYMBOL(drm_sysfs_reset_event);
>>> > +
>>> >   /**
>>> >    * drm_sysfs_connector_hotplug_event - generate a DRM uevent for 
>>> any connector
>>> >    * change
>>> > diff --git a/include/drm/drm_sysfs.h b/include/drm/drm_sysfs.h
>>> > index 6273cac44e47..63f00fe8054c 100644
>>> > --- a/include/drm/drm_sysfs.h
>>> > +++ b/include/drm/drm_sysfs.h
>>> > @@ -2,6 +2,8 @@
>>> >   #ifndef _DRM_SYSFS_H_
>>> >   #define _DRM_SYSFS_H_
>>> >
>>> > +#define DRM_GPU_RESET_FLAG_VRAM_VALID (1 << 0)
>>> > +
>>> >   struct drm_device;
>>> >   struct device;
>>> >   struct drm_connector;
>>> > @@ -11,6 +13,7 @@ int drm_class_device_register(struct device *dev);
>>> >   void drm_class_device_unregister(struct device *dev);
>>> >
>>> >   void drm_sysfs_hotplug_event(struct drm_device *dev);
>>> > +void drm_sysfs_reset_event(struct drm_device *dev, uint64_t pid, 
>>> uint32_t reset_flags);
>>> >   void drm_sysfs_connector_hotplug_event(struct drm_connector 
>>> *connector);
>>> >   void drm_sysfs_connector_status_event(struct drm_connector 
>>> *connector,
>>> >                                      struct drm_property *property);
