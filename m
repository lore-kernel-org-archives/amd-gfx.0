Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 48D22E7716D
	for <amd-gfx@archiver.kernel.org>; Wed,  4 Dec 2024 16:18:43 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C454010E2AC;
	Wed,  4 Dec 2024 16:18:42 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="SG0wQgmS";
	dkim-atps=neutral
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2064.outbound.protection.outlook.com [40.107.236.64])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B7E9610E2AC
 for <amd-gfx@lists.freedesktop.org>; Wed,  4 Dec 2024 16:18:41 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cDNX0flUyofEeIE+a7lokvkU8GcNHYPc4XGTM2AwBs5SffwQklF2Hku2j8U2u3AEktKfiPrracYB4Ta+Da9BE/W6VR5BXRYywsMtVs2APTESkQ22+ewjDHNOIccyZvlpPbE9Iqy+xK8YU1q05CZTn5BLe/Rxmsv9kMBSR2ox2eAUQP18Ui5XcyOH18JYCYR3Et0ccHY2MaytBQK7eNGZYmKklIaAXAUO6Jkl2wlDhNjT5pT8igTsLmPLOFd80ilYdakpkkO7hEbAHjT7xlG6tlDGmn8Uz3Sl9+gOOTWWaJDvZ4fCuhw5V4e9In3dG5PkBqXXr8O8sj45n7WTvlfAkQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Q/Ma2DQbnkqMCVKy1pB8F2l7ELwzyIuCtxb6tTMH+Pw=;
 b=QFq6PD867LLe92JmiPCzKa4KMerw6+0BPExTq+BwO4f2PEiyDKIPOP94E4260BbpabOBElGFtchpARFc6nvAz6QAWtMwMYvn3WEKCXqHnO5zSOdT8/1a905dlA4w/hzweAAw8tUAKKlwvSjfQLVxLy7hYPVp1bqFrSaIkeEoy1iaDsvTwdwgvqzxEC/w4msQX1zT/aD0KUy0xfBGHKjtHWFn8sVsTj2tOYqePrlI9iQea8tbaFHx3+HdUnpwmOBDU31ID81VG7ch5/I/7qKDAQxVc8gH6c+i519IvjxcGCtVZe7t8P7N1oL7fRJWPaFRARcERYZ7tj51aSn8jcka0A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Q/Ma2DQbnkqMCVKy1pB8F2l7ELwzyIuCtxb6tTMH+Pw=;
 b=SG0wQgmSLDTCUGFXCs0yUnL5fFvW0/fd0YJeL6RIr7KFlu0BDJps8+6bztKFC5LUKrS3L6Oe0/kQta0OFE00NDT33xfEFTCRnIKg/DQ6rmNlRNylcU6k/RGVO2P7w8Q5/kjOl9iYU72jVhCEveuhulAUpNTjNHckbDSZAV4K6po=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS0PR12MB7804.namprd12.prod.outlook.com (2603:10b6:8:142::5) by
 CH2PR12MB4310.namprd12.prod.outlook.com (2603:10b6:610:a9::15) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8207.19; Wed, 4 Dec 2024 16:18:36 +0000
Received: from DS0PR12MB7804.namprd12.prod.outlook.com
 ([fe80::8327:d71a:ce21:a290]) by DS0PR12MB7804.namprd12.prod.outlook.com
 ([fe80::8327:d71a:ce21:a290%7]) with mapi id 15.20.8230.010; Wed, 4 Dec 2024
 16:18:34 +0000
Message-ID: <9f85de41-5574-4e83-b5ed-1640e45e90e9@amd.com>
Date: Wed, 4 Dec 2024 21:48:28 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amd: Add the capability to mark certain firmware as
 "required"
To: Alex Deucher <alexdeucher@gmail.com>
Cc: Mario Limonciello <mario.limonciello@amd.com>,
 amd-gfx@lists.freedesktop.org, Alex Deucher <alexander.deucher@amd.com>
References: <20241203181403.23515-1-mario.limonciello@amd.com>
 <e8ae8d63-44d5-4e77-818f-67cf69d0c8b7@amd.com>
 <c5a7f27c-c676-4e10-83ba-393a4df06ada@amd.com>
 <20d00e76-7ce4-42d0-a968-d7adae616984@amd.com>
 <CADnq5_MPEZA2CYfFnG3u--bDeD3eQyZO6igCQQqHEp-BJNwy-g@mail.gmail.com>
 <2062652c-16f6-4e06-b3d7-73ef6a684aaa@amd.com>
 <CADnq5_MD0wexpOc+mGoXkHMHDv5BxybR+tyowedwxg7vvp6mQg@mail.gmail.com>
Content-Language: en-US
From: "Lazar, Lijo" <lijo.lazar@amd.com>
In-Reply-To: <CADnq5_MD0wexpOc+mGoXkHMHDv5BxybR+tyowedwxg7vvp6mQg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PN0PR01CA0042.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:49::13) To DS0PR12MB7804.namprd12.prod.outlook.com
 (2603:10b6:8:142::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB7804:EE_|CH2PR12MB4310:EE_
X-MS-Office365-Filtering-Correlation-Id: 71300532-9786-4f64-3ffa-08dd147f4d22
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?RHBIckxObndMOFRKSG1hRW9ObHhLdXJLcVZ4c3ptUHRIeGpUU0V1UnhTcDV3?=
 =?utf-8?B?K0VLM2hpUjBmSGFCbERIWm10ZXBVMHEvaThYZTRFTlFjMmFHWTlVOU9aN1VO?=
 =?utf-8?B?cXJidGJuaTdibTNNdklOOFd5UXZjNWo1RUgvdWVCRnZHQnd3TG1vYmluaTFL?=
 =?utf-8?B?cnFvaWF5S3AxdVdKYUsrWnBZVG9KUU5TaDNFUEl5WFZ4bjR3Q3dCSUlWT3hh?=
 =?utf-8?B?QU1ROEIyYnFGNXd4VU9qSkUydzVadTI4dW80RjJDRFI4c3dWOUNDWi85am1v?=
 =?utf-8?B?VW0rbm5xYjNDblFCVk9jUm9YSmlwMWZyYlZyOHdqdjMwWkJlWUxka2NLN0t0?=
 =?utf-8?B?TUNMWGJxUktNc1JBc25pSDdIb3M2QWlMcmZHV0JDNVpEeEk3WjBQV1ZzUUln?=
 =?utf-8?B?UWQyL3IvTnVTQU1LSmg5L3NMTlYwb3Z5VFdRMWh6bnAyeklUTGdGbTM0Rzdi?=
 =?utf-8?B?Y3lZNmhUZVlOaGVLd1RybE0zekx5aGRWVHBMc2tTUFJzWVhwOEM0T3k1cmdU?=
 =?utf-8?B?QUtkNXBBVEltdDgvWEtKRDM5cWJWcWl1NlFDbWdFL1BBK21tY1J5WHh5TDdP?=
 =?utf-8?B?YlI0RkxKem5MQzcySVdvUEhscllYYjJrVmFjaDdlSXMwWXI5ZXVrL2pOakpE?=
 =?utf-8?B?Z0ZyeEVibHJjRjZjZGVuNkF1QjFadEtFTGRTdlA3eWNBTm1UY1h3Y0ZXeGsw?=
 =?utf-8?B?VUhSd05ZZnNXV3NleDlWV2l6VXRsd05nN3orbXYzQVEvK293Z2tIZ3g1MXQ2?=
 =?utf-8?B?ZCs3VjljZnpseE5sU2lHMlY0V0N4RVNaaXdtMzFBbEd2UGJBeWJIMWMxRmJD?=
 =?utf-8?B?a0xjbXdFZmJUTmdHcjlOaXZxbTFlaWR2VzkxLzZCNXY2b3FEZ1FwRjlwU2NL?=
 =?utf-8?B?RmZNUW8zSTVMWnNGcFh3UzFxWmNpVTk1bEUyUlJ5MVF3VTBiNE5GMmdQNWt3?=
 =?utf-8?B?eFNZaFd1b1M0RGVTWThXUEFacVlJeTN6dVZrL1A2eGFBTWgzRXptcWpnT2o5?=
 =?utf-8?B?MlNnSDRtajU2OUIvUHpxR1dOUDhxbFpqSVZBRSs3OG5TMXIzanBOeWxOWEJY?=
 =?utf-8?B?NE5XeUswUDBTMUprNExhUStQbmFrVjB1QzZTTUVUSlhhWWVNTFd0bXZ0Tnlk?=
 =?utf-8?B?dUphSVFrOEVuTVl5OVpxaE1FaHhsUm1hZ2xpVE1Jb1JVbytOb0I0eVoyUUR6?=
 =?utf-8?B?MnRWZk54WkRrK2tiNlhCeFFNaXpKRS82RmIyU0ZIM2txc3hGanFJQWRhWkF0?=
 =?utf-8?B?a2tVS3lVWjZJS0EvN1Z5QU5CaXhTOWwvc25SZmpFaFJYWTBEUVFRd3Bjd25L?=
 =?utf-8?B?UDloUHdCR3VTYmNwcHBlUktOODVRelMxUGpUaHBsVEZzOFhRV0tDUzRvcVZv?=
 =?utf-8?B?MEQ1N3pGaDF5NEo1K0VOZmVKaHg3anRrVmhZQTdCSHdHM1pnYzZzOURtclZC?=
 =?utf-8?B?MnhCeGF2WFRSVzlUQ212ZHNSQktvNmdCbGRHNjRTcTZVdDNReU9rNjVEcUpm?=
 =?utf-8?B?amdjS2Jvc2szVC9xR0liZ1BYUnFuR1BIR1BVZUsvcmwvaEhoZlJnREtVN1Qw?=
 =?utf-8?B?cFIzbFgyUE5neDZLa2lJZDZNQnprOHNPTkIvWXM3K0V5WWtLQWZXT0F5a0U0?=
 =?utf-8?B?N0hqcmlSR0NTQ21keElVa2R4Zmt6ZEtKTmN5T0J1WDBKWncxM3Q4QTRpVTBT?=
 =?utf-8?B?djJ0VGRrTHBXMnZ1a3FYMGN0Mm1lOXFGeXlucEtpdTJHM3ZCdDJPSzNPdWFS?=
 =?utf-8?B?Y216b2xzRGxRUkFXQXVaL0hnVGZ6Um5nWDV2Sk9sWkFCcWtrN3ZId1Y2MWpw?=
 =?utf-8?B?NXZhTlBsL0tWNkovMnFZUT09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR12MB7804.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WW40bUFPZElVaWxpY2R4a1VuZnlTTGJwOHRiQnpwcEI2YkZwZm15OW85SE91?=
 =?utf-8?B?NW5wcE0yMGtDZHF1Mm9nY1RWaWVidjJTWlpwVldxU21zUjFYaFRQa0wyWDdP?=
 =?utf-8?B?M3d4Rlo4RXd2azMvdGNIbVh4MkliQnliWCthdjVscWZ6MDdNVTBocUsvTkhh?=
 =?utf-8?B?WXpiUDR4eUF0c2ttSzF6U2krNnNqNUhGR0ZHMGxBaFdCSjR0NjQ1dDFXQjZV?=
 =?utf-8?B?TlVGTW03dkMwZTRPRXRiQ0R3VTBMemJadU45eTh3MnB2NGh3NGJzSExSNGpx?=
 =?utf-8?B?QzhaQmVIWm44R0lhS282QlVFczRScy9hd21YNmY4bVRNZDZTZWFhWitidEhG?=
 =?utf-8?B?WmN4UEtKMU12ZldXZ1o1TzhESXpOQ21XaXF0Zld1Y1lEaUYzYXZVSkh6Mnpv?=
 =?utf-8?B?cCtmR3A1TWRua2VlQzM0TExwQytEWFcyQXJWeXp2a0dickhTcGpoQlNjakpq?=
 =?utf-8?B?M1VvbkFYVTVnTkNqbzduZkxvYldvbHc5UUlneGZCQnY0bE9BZWNVb05EUU4y?=
 =?utf-8?B?WWVjQ2VTVlNlUmxsS3VNVVd4TEt0SDVtejB4R1U3OVNjK09jOEphbmJkeDhj?=
 =?utf-8?B?VFNUWEtJRmJjVnZyS2Z6TDN1NmJtTHBBTDN5YjhIckQrVGY0WDNNSEo4L0dD?=
 =?utf-8?B?WC9paC9xT2kzZnZ3ZlU0elh2SWp4L1pQQkF3eG5PaXJpUnBZQVpENndkMlJT?=
 =?utf-8?B?Yk1kaU5HbzA1RVoySG9wUmxLOVF5SXcyZlJPZ0xRNGs3OGlwVFhwd3BRa1la?=
 =?utf-8?B?dG5KeGtoQ3pUT2FDTk9DYUgyMzBpTFgvd0txUjJQdzE5TUdjYXFSaFp4MGEz?=
 =?utf-8?B?VW1xc2lLN0NpbStiMkpxREp0NFA2Q1Jtb3kzUnVHVmJMNXdCblFRTTErbW00?=
 =?utf-8?B?bzNIUSszdUYrTmlkMDFUdjRJS2szRXJDY1ZXcmRsNHhVZzRsSDhHS2dNQWlE?=
 =?utf-8?B?RFVNdVJDeCtuR25ITEpRK2taL01tMTlRR1hmZ0NkbmJrYXBpY1JTWkJ4TUxM?=
 =?utf-8?B?Vy8vcWZLOUVyb2h5K0p5VGlpdTV4MW1Ud1dtVmdkVHJweC93ZmhLbU1QNWVD?=
 =?utf-8?B?TWJsSVJJL0hXVTMrMXF1OE5vSFJRNGlwNXBrMEdCQ3VhZUMzdnd4U3VsaDNh?=
 =?utf-8?B?Q0ZJOEpYa2tNZERLZ1IwbHZXRE0zOFdMallDWktlaXZnZXB0dno4eVlFOExY?=
 =?utf-8?B?czNWMzBJd05uTjlkU3hZMnZadGtKSzdaSUMvb09KbXRxWElhamF0dlFmUk9z?=
 =?utf-8?B?OG1NNVJVdkFhdlRRZzhUSEk2ZFdMQlprZWwzWXMxSzRuYkZJc1NsS2NoRHJH?=
 =?utf-8?B?MmFQY3d3MDJpMm0xYzFBaFljOThXdHV1U214WGprS05GcEZtdGNEeVNqazdq?=
 =?utf-8?B?N1NMZXp1dFdBZUJpdXp1Vm9LL0J5TWlKNWlCbkZkb1dCNzc0LzdxakZ1d0JZ?=
 =?utf-8?B?VGdiWFJSek5EVTVFcXN5Zy9ZRW9rTVRtM1UrOHpWSDdWWkwzU1YvK044cWNz?=
 =?utf-8?B?WHAwaVBQOFVVMHdvVHd0em1WRVhPVDFiWEhYeTR5UjA1cGNYOWUyZFRqN2N0?=
 =?utf-8?B?NlBwQUdHb21Hd3AvN1RwRjBGbXByL1dWQ1VjcUczVlJnaHhpUTAzS05JRVRF?=
 =?utf-8?B?L3hrbll0Q1hhcGZaaW5HNjRHTmE4cEZoanp0b3EwOGJiTlJBQVRaNEtLY2Uw?=
 =?utf-8?B?MlY0UHlXVXlFalBENkkwMjVXMnI1VWxHUzhDeHk4RmxmT1hHdHJSSzdJb3Nj?=
 =?utf-8?B?Ni9kdk1mNnRML0FjQWhuWEVzRnZpR1h3Ym94Wlk4YXZIRUU4L3FwYmlwVkZk?=
 =?utf-8?B?U2NhWVJDeS9XakdSZmZ6b05NNWFhVGd0dC90NG9uclVacWxnTUREVDFSNWU2?=
 =?utf-8?B?NGNHVXJLZVY4aExJMmkzMkFHblhOY2ZDS0tCRmphbjZHeUhZWWdHMEprTCtY?=
 =?utf-8?B?QzExVlZjR2FpQ0V6dnhmRU1NaGhZOVFmVkwxbldHZDR6RmlWRW9nbW94aGtT?=
 =?utf-8?B?c1ZXSGNZeHlLKzI5TWxSa3doWWVFaWJQdTZtVFFuZnhkaUYvMWNQOFZiSGJj?=
 =?utf-8?B?RUo0Mm13Zjg4OWhpdXZ2d0M5bE1OL3FDYmJMcStKTTdqMllwc0szME95UGFR?=
 =?utf-8?Q?18QvIseTnNyyxwjLmQoJ87MNn?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 71300532-9786-4f64-3ffa-08dd147f4d22
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB7804.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Dec 2024 16:18:34.7515 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hayeZhvKmF92nejLahBOMWkueLKtYuknJsyH/tKo/72fj0h5UC0ThEYdFKKVPgcz
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4310
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



On 12/4/2024 9:30 PM, Alex Deucher wrote:
> On Wed, Dec 4, 2024 at 10:56 AM Lazar, Lijo <lijo.lazar@amd.com> wrote:
>>
>>
>>
>> On 12/4/2024 7:51 PM, Alex Deucher wrote:
>>> On Wed, Dec 4, 2024 at 12:47 AM Lazar, Lijo <lijo.lazar@amd.com> wrote:
>>>>
>>>>
>>>>
>>>> On 12/4/2024 10:44 AM, Mario Limonciello wrote:
>>>>>
>>>>>>> +enum amdgpu_ucode_required {
>>>>>>> +    AMDGPU_UCODE_NOT_REQUIRED,
>>>>>>> +    AMDGPU_UCODE_REQUIRED,
>>>>>>
>>>>>> Couldn't this be handled in another API instead of having to flag every
>>>>>> load? By default, every ucode is required and if optional may be skipped
>>>>>> with amdgpu_ucode_request_optional() API?
>>>>>>
>>>>>
>>>>> I guess this would be a smaller patch, but 6 eggs one hand, half dozen
>>>>> in the other?
>>>>>
>>>>
>>>> I thought only ISP and gpu_info (no longer there for newer SOCs) fall
>>>> into the optional ones so far. The usage is rare, similar to the
>>>> nowarn() API usage.
>>>>
>>>> Also, as far as I know, the cap microcode is a must whenever used. That
>>>> is not optional.
>>>>
>>>
>>> The cap firmware is definitely optional.  Some customers use it, some don't.
>>>
>>
>> I thought optional is something that can be ignored even if FW is not
>> found and then driver load proceeds.
>>
>> What is the expected driver action if we classify cap firmware as
>> optional and then it fails on a customer system that expects it?
> 
> I guess if the customer expects it, they can make sure it's there.

I don't think customer really can do that without any diagnostic message
from the driver. Driver has to show the right message. If it passes that
silently and fails at some other point, it could be a totally different
signature.

> I'm not sure how you can have both without it being optional.  For
> customers that don't use it, requiring it would break them if it
> wasn't present.
> 

It's working so far. Having all is better as long as loading that is
harmless.

Thanks,
Lijo

> Alex
> 
>>
>> Thanks,
>> Lijo
>>
>>
>>> Alex
>>>
>>>
>>>> Thanks,
>>>> Lijo
>>>>
>>>>> Alex - what's your take?
>>>>
>>

