Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EE4C0CA1016
	for <amd-gfx@archiver.kernel.org>; Mon,  8 Sep 2025 18:02:12 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A05B210E59F;
	Mon,  8 Sep 2025 18:02:12 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="VnC9MN4V";
	dkim-atps=neutral
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2041.outbound.protection.outlook.com [40.107.243.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E6DD910E59F
 for <amd-gfx@lists.freedesktop.org>; Mon,  8 Sep 2025 18:02:10 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=X+0llq4yPo3EggrEI1EV4ORq/t1PDUzE9q+5cAlmwlp6m81nLgm2nZJXLcW/p6h+4oBIYmPeYuuMb5p1MuE1r2A+t7nobJcUNNhPXSHlc7TXshAYeFAmrtE6WoX8JFNBMGyQ6MRj/y5ixz8S1X5JuuzFzeNN8uHro0J76IknqfkxKZBRUQtKhVtr7lYJcWkWrovEgmyVvXPOKOnpGiF3YOuiynoE4l4iaM6beo0m7V+u3Me7roJCQzz9u9EDUeY2hrUyMZFLLuipg3xK1qLn8DHE+C2nhotqUwiq57mnwCHJBFmwaSl7nJtl8BMjmQn6/y7cxNI+EDqJi8MHYmaIWw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3BYvECpFwkZ96tUj6PEaQEzIxAKwggBsN8+B9Pyj5sA=;
 b=niHEUypzv+Urzms0NMKqX9zaseWisNNuiuEXpLNV8DRaBRAQ3iriw9PtwuUnq127UlofKtNR5ok7GDoA9NpXhmywZwUaRJ001ntLq272e+8oSXdqtaZooGRurdkb/2pAXBwHByWBIybQQOgYOMpIzfIIIdtLLkOxgcaazjNzcMJ3hbhNF7fs9h0pv6dTuu22xaUAUKMQwf5trTWk+MTrLwcTo2D5c642JJ+441Mp4cPjb+l7rQMF4Z1ye03F+j3vbE9FeY972pQp7V4WUOCwQs0Q8EeL5vU5wPgTj/96qG/5Kx8rzFxe/t1spCebsyrztkzjDkaSums3SUr1j78sVw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3BYvECpFwkZ96tUj6PEaQEzIxAKwggBsN8+B9Pyj5sA=;
 b=VnC9MN4V4w45487gYRbsP0pW4j1GYBw1n/hm5j/gHrmj4hIyBzq/kkXEfhpRyrRyW1RqDuEhiDnhdfeVA33i9Dt7njE6U5rXtxO8xKlZNWSekO0dbk+oxaNWxfFNRUYKL6l0NhbGoNN9NZWnI+BGs0kU/YIsUQvTjxVjljSbkoo=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB8476.namprd12.prod.outlook.com (2603:10b6:8:17e::15)
 by DM4PR12MB7623.namprd12.prod.outlook.com (2603:10b6:8:108::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.22; Mon, 8 Sep
 2025 18:02:07 +0000
Received: from DM4PR12MB8476.namprd12.prod.outlook.com
 ([fe80::2ed6:28e6:241e:7fc1]) by DM4PR12MB8476.namprd12.prod.outlook.com
 ([fe80::2ed6:28e6:241e:7fc1%6]) with mapi id 15.20.9094.021; Mon, 8 Sep 2025
 18:02:07 +0000
Message-ID: <7af4f869-ade9-4b33-a3bc-6ab565ae311b@amd.com>
Date: Mon, 8 Sep 2025 12:02:05 -0600
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amd/display: Fix DVI-D/HDMI adapters
To: =?UTF-8?Q?Timur_Krist=C3=B3f?= <timur.kristof@gmail.com>,
 Alex Deucher <alexdeucher@gmail.com>
Cc: amd-gfx@lists.freedesktop.org, alexander.deucher@amd.com,
 harry.wentland@amd.com
References: <20250825213333.612600-1-timur.kristof@gmail.com>
 <CADnq5_NwQCGgsgVZ1T3ofxrLJhDkq0FO3GKOViWtn8JhFC+vfw@mail.gmail.com>
 <32f1bfca9b0deb97084390be7e44a47bd8265f04.camel@gmail.com>
 <CADnq5_MnBztaCye3fEgT17u5A50ZVCKsm5T4qLy7KCF_s3gRwg@mail.gmail.com>
 <44b39851-9775-4bb8-9558-3cd4f298120c@amd.com>
 <29046ec704624b7a65cfa1bb4c0511472ba78912.camel@gmail.com>
Content-Language: en-US
From: Alex Hung <alex.hung@amd.com>
In-Reply-To: <29046ec704624b7a65cfa1bb4c0511472ba78912.camel@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MW2PR16CA0067.namprd16.prod.outlook.com
 (2603:10b6:907:1::44) To DM4PR12MB8476.namprd12.prod.outlook.com
 (2603:10b6:8:17e::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB8476:EE_|DM4PR12MB7623:EE_
X-MS-Office365-Filtering-Correlation-Id: 1b644526-8d0e-4396-431a-08ddef01d302
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?UXVtWXo2U0M3Nit5cWFSejduWUhOTXlpNTVrRllJWWJaclRPQVVoelNyMHFX?=
 =?utf-8?B?R1ZKam96WmFMdWhTQURZeTc4VXo5YlJGN0NVSDlOWGo5T2hCUWorWkl5MGRB?=
 =?utf-8?B?MldPcVNoWG91Z0tDclpEczljQ3k2b0NPdHl0T0tPOG80dFNyd2Zya0J3dFdw?=
 =?utf-8?B?VWRrcnMxdmppQTF0R1FyTkxvVmV5Y0hrSjBLbHlQMDQxdHEvUG5FdFBtNFV0?=
 =?utf-8?B?a2JaNTkxQ3VuakkzajRuVy9BRVh2NDRZVWlkVS9sZTlKVlFKVE1NK1o4Vkw2?=
 =?utf-8?B?TlNNVzVtajk2aUVrTzZQSFhSc1RwSTBIT0kyUnlyQk15eXNWRVA1OS9HTTJP?=
 =?utf-8?B?YkpvR1lDTW5RL2xQeEtraW1aSkZycVBXU3FoclBmQnRHUHVYa1ZQYUc2WkFi?=
 =?utf-8?B?Rys3aDVwRFdQbVFsaXo1LzYxVGFmU0plWU16WDh6YytlVGZTejI3dTdiQVBm?=
 =?utf-8?B?QzV6ZC9FbThJM3BSLzVYVS9oRmhKZG4xVGVHenZHSERIL2N2QlFoYzlhdnVH?=
 =?utf-8?B?djRnd0RML0hvRGlaZDQ2MU1RdUMvZEt0UmdLMXFqVitGeGtvSnZSYTUrK1R5?=
 =?utf-8?B?ODl2ZTEvTGJ2OERidGFhWkR1VU5xaVYzSTBGU0p1MlYyeGFsdkN6Wkd5Nlpy?=
 =?utf-8?B?QmtUZU1CN0FWMGR4ZG9WU05pNWRoaUJ5K3ZTei9VdFRvQkZ4RWIvYmxaSDFj?=
 =?utf-8?B?Ky82SmNISHVSRzQ2aGRXTzJXemxybGtsWUVjbmhyeGV1Y2xVcDZvNis5WHBB?=
 =?utf-8?B?c3BEZ05rYlhCa0Z3ZWFUYkJPWTU3dzJOWkhaMmQrUzZJR2NwVHQrcWZCQzkz?=
 =?utf-8?B?NzlSL0RIb21KSVVnYVZzWk91LzF4bVBrS0h2ZlUyVHJldlgwcDhzbmxSWFhz?=
 =?utf-8?B?R3F1dTFDNzFzaG90R0V4clhtcm5tMkx5Y0xSTnk0TEhUVUNFdG9TRUFzQTd0?=
 =?utf-8?B?QlFQemk4d01SaDFoc1lRQVVmSEIyaUo1cmVScE5KaDcrZ09VaFhmalBpZk1C?=
 =?utf-8?B?WndubWZyU2lFTGJsTlBrT2lmNklTVWhOczFaenN5ejgzMUYwZ0FsZ2NUS0Nq?=
 =?utf-8?B?MU5CNXRaZVRmTVFPUFFRTXE1Z2tJUmpEWUloQVpkTjhlYjZycDhVWFFwT1Rn?=
 =?utf-8?B?MUFFNTh0eFc1bzUzMGZadjZ2WFhwUkhMOTV1L3ZtSzBUcXF2dlcvVGlJeWZO?=
 =?utf-8?B?RDkzeTV5eFdKZXkraVlrVGZrUG1OTUdnZHo3UDlDODlVaG05MlJTQTRyWU9O?=
 =?utf-8?B?cktCRC93RWJuU0dKMFlVVExtVGs3QmtpcmdnR3I1VTBkRklIV0NaZzQyZElM?=
 =?utf-8?B?KzhFeGU5YTg3NVorbUFsMVo4bDJQSDJHQVVYb3p5eVBMNHMvcGQ1UjkzWENp?=
 =?utf-8?B?MUZkU1B1Q0VLSUQ1S09UT3M3OFBFbkFnY1hTMXhBU3BLTlg3THI3dExrRGdI?=
 =?utf-8?B?TERNRVZhZ2dkKzlnVU9vRDd4Q3RGdi9hTnFLNVJmaDk3bElidHFnZDFoZ2FX?=
 =?utf-8?B?UTgyZ0FVOG56dFJid1dRcWdaM0QvUVdsUUdTbjNXV01sRGpzSXN1a0xOYk1J?=
 =?utf-8?B?ZUl1L21RZGpIRXQyTWFNY3RqeXg5dnptRm1mMkhIZW1ZWWt1VmRwb05MZWxP?=
 =?utf-8?B?S0VodnNKcjJrazBrODE1R0tTK1d5NmJqSXh2V3B0WEZESThtZWwzSDFzSno4?=
 =?utf-8?B?dmg0NlcyY0ZQWm1qZmpSTFE5LytPTExyV1pWdVZKRVZyai9oQ1NaK3hyYkNv?=
 =?utf-8?B?SW5DMVcrMnE0Q3REQlkvTTd0OXh1MmQyQUg3em5pcUdQNEU0dXhtdzRNYWY3?=
 =?utf-8?B?aUpMcDRVcjlSWnhXUCt5MXJydnFza09wejRCREdlb2N3UUE2b3Z2SkZ1ak56?=
 =?utf-8?B?YVEyTUw3MDlyVlpFOC96am9EaVpxb3NsanNBNkJMSGtjM3c9PQ==?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB8476.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(7053199007); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cTJJZUtnelRZUDRrRC93aGIvS3VmT3hlZVh0dXowZE85K1dRYXUrV0ZWbnRP?=
 =?utf-8?B?Zlo0VytQS1UyNjFYc0MrdUpFL1o0R3YvWUhVQkFQZ1hyRFRiSFZjbng3Q0dE?=
 =?utf-8?B?U240WE1MZmpuUDBjUWdzR0o3UEtDMm9IM0FUeTdZUHdQYW9mY2h4RnAvVFVG?=
 =?utf-8?B?TzNuUW1jb1JYMkJlMWlBWi9jUmh1MzhZK1F3bEFkeGM1NGpNQ29EWG4wekVs?=
 =?utf-8?B?S0dCdkM2eDBDd3JxdmlWcGxIN2Q5OHNySTJVT0ZQR0ZKZWZtWC81aFdxRFNT?=
 =?utf-8?B?czQ1YXVVb3QySGN3OTN3bU1OSUxvQStoRGJKcW1hVGF4a1ZnNGk4U2g1UHJn?=
 =?utf-8?B?V2RaMno5Q1pxaWMxckNsb0FVcVRDTFdFcG9JZjhXLzFLZzFoNC8yaDE4aFli?=
 =?utf-8?B?UjZwc1pYTlJMQXg5dk8vRXhsQkcyR2FIVHZ5ald2RWQyeVNHRjB6S2tXOENY?=
 =?utf-8?B?TlFDV3dTclVHck5KbHdLY1hwRTVZeitxeXFPaHNlMFIxMWFOYytWRHM0NWxS?=
 =?utf-8?B?YXpZbGJPekhOVCtmamJjQUtRUEROcndQeHhDVEIyQUExeUtUaEo1SWJ6UHpW?=
 =?utf-8?B?R1kycC9BeTAvcDJJbnJ4WFZTRE56S0UyQWZ1R3JHSTIzaEt6NnVHSmdWTG0w?=
 =?utf-8?B?TWhFcGRKUm9zMXlnWWFaNVdXaHhVNTZuNGJ2ZndIYm1Mek5JbFp4SGxaYjd1?=
 =?utf-8?B?Q2VzSVQzL24zRGdER2lmbVcvRldjeFZ2blg1OW8zZGpyQ3gzaU5uL1paVWs5?=
 =?utf-8?B?ZVNGQ0dOOUE2ZHJ6OFJUUEdUR3FEMlpDUWhHaENySnl5bHU0TDZ5VGJZNmlW?=
 =?utf-8?B?UHZmOTMxdDFxR1piR3l3MmdXak1LQ0krRU9wNE9RdHBkaGFFckNHTDhmSEFz?=
 =?utf-8?B?UUpFVGVsS0JSalB6N0VBZm45bUMyRERVeHFTSUE5T0M3UjNnMnhyb296RFZ0?=
 =?utf-8?B?bVJzZGhJdm1GVjNlN2R6cFNRNWNsWllwYjhFTHlCelFxYUhCVUo3ZHIyaU5p?=
 =?utf-8?B?Qks3Mm5ORFI2SDljVGxYbyswZEJHdzhnaUxkMnNNamdKVDZGTG5paUhMQmc2?=
 =?utf-8?B?dXdGa1BWUkJlMDV4dmtQdDlwSjNXbWwycm1vTmg2U2haVzVyd2U5UGpBUXo3?=
 =?utf-8?B?WEt6L04vYTF2VHBhUFZwdGdmeW9oYUtydWZ0ZnNuK05kdk9TaWhveGVuOUVq?=
 =?utf-8?B?RmpKYXh1ekdUZkZXR3d1WDdvYmNrcXdLWHl6OTRJZnZmSllxNzFzRVFMQzNR?=
 =?utf-8?B?WXBoUXR2Wit1YWgyMlFUYTF1Q1dRVWV4S3VyUFVhdlZDbHhjQkJQNWxqSno3?=
 =?utf-8?B?bXBpeSt6ZEpRWjdSQVd2bGxqeTNMZUxPU2dDM3RmLzYwR2hEYms2UXVZbFNh?=
 =?utf-8?B?T1ZJcHVLTW5xVUFDRU1RSUxVTnJtQ0hWbGRObXo1TXJpWEhNOW5yUnVLVTlU?=
 =?utf-8?B?T1MweC9JQ2wxbHpyT0dDRzRzcExxU2hmT2xDdzQzSSt0clBZbDNqWEp0NDV6?=
 =?utf-8?B?VXZId0tNUEtnNnM3NVVmcTY3blUzKzcxZHVSYnFta2JnNnRuU1pvV3dkOUt3?=
 =?utf-8?B?bHUvaVhBYnEyeU9QYkFrNy9waHc1YjRSOWFpVk1PMnJhRUd0WERFV0FWUVNx?=
 =?utf-8?B?ZVV3VG5Jc1RrbE9EU3U4cFh3Qjczd1FhUHB2QUNudnpKcmdMUlB2eWFKOCt5?=
 =?utf-8?B?SVJOQ2ZZV1Q0TU95UFRCaGpxS0wrN2VnR2kyVXRCSzBwcFRxRTNjS0xNSnNP?=
 =?utf-8?B?T2JrSTRreWFTc3ZIZkQ2NEp4SkUra2ZTMkpLYks5Qm5qcTlZZzRPQzZicm1k?=
 =?utf-8?B?UW5RdWxja2Erelc0WE9ZcytZbWFzbEluWlNuUGxPeFlRUWhQWGxIeTNMMjdP?=
 =?utf-8?B?aW9HMHpyZTBnVDg4UWdZSjAyVy8zQzNhc1AvUWV5dngyRFBhaUpMSHljNEg1?=
 =?utf-8?B?Z0dUZ3ZkTmZPby9kTWVSendwYlRCbDV6bUYweXYrZ3oyZ0F1NnozZzFOK0Nr?=
 =?utf-8?B?cDIwUU43aVh3RHA1dHlwR2hldDUzUU45YmF1cG5PcHFsN0ZOU2l6RnpOQXNx?=
 =?utf-8?B?aU5Qd2tNd3c4MUlWVkU4ZXZHaTRMSm1yU1ZFWW9UUDk3MDZyWElPUmdJQk9J?=
 =?utf-8?Q?2u2MbLqVk5E2ov+cosjspw5vE?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1b644526-8d0e-4396-431a-08ddef01d302
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB8476.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Sep 2025 18:02:07.2369 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: sg+ctkrbC6l6ol78itww5I9FWIz9qcR5tv/KAyZzHSzDFq7/bRF47gV/lkybGZ2BdI5X9QjcUZ36UmIMzR37bg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB7623
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



On 9/8/25 11:45, Timur Kristóf wrote:
> On Mon, 2025-09-08 at 11:40 -0600, Alex Hung wrote:
>>
>>
>> On 9/8/25 11:36, Alex Deucher wrote:
>>> @alexhung@amd.com@Wentland, Harry
>>>    Were you planning to pick this up for this week's promotion or
>>> should
>>> I grab it?
>>
>> I will send them to weekly DC promotion.
>>
>> Thanks.
>>
>>>
>>> Thanks,
>>>
>>> Alex
>>>
>>> On Wed, Sep 3, 2025 at 11:27 AM Timur Kristóf
>>> <timur.kristof@gmail.com> wrote:
>>>>
>>>> On Tue, 2025-08-26 at 10:06 -0400, Alex Deucher wrote:
>>>>> On Mon, Aug 25, 2025 at 5:33 PM Timur Kristóf
>>>>> <timur.kristof@gmail.com> wrote:
>>>>>>
>>>>>> When the EDID has the HDMI bit, we should simply select
>>>>>> the HDMI signal type even on DVI ports.
>>>>>>
>>>>>> For reference see, the legacy amdgpu display code:
>>>>>> amdgpu_atombios_encoder_get_encoder_mode
>>>>>> which selects ATOM_ENCODER_MODE_HDMI for the same case.
>>>>>>
>>>>>> This commit fixes DVI connectors to work with DVI-D/HDMI
>>>>>> adapters so that they can now produce output over these
>>>>>> connectors for HDMI monitors with higher bandwidth modes.
>>>>>> With this change, even HDMI audio works through DVI.
>>>>>>
>>>>>> For testing, I used a CAA-DMDHFD3 DVI-D/HDMI adapter
>>>>>> with the following GPUs:
>>>>>>
>>>>>> Tahiti (DCE 6) - DC can now output 4K 30 Hz over DVI
>>>>>> Polaris 10 (DCE 11.2) - DC can now output 4K 60 Hz over DVI
>>>>>>
>>>>>> Signed-off-by: Timur Kristóf <timur.kristof@gmail.com>
>>>>>
>>>>> Makes sense to me, but would be good to get input from display
>>>>> team
>>>>> in
>>>>> case there is anything I'm missing.
>>>>> Acked-by: Alex Deucher <alexander.deucher@amd.com>
>>>>
>>>> @harry.wentland@amd.com or @alex.hung@amd.com Can you guys please
>>>> review this patch? Thank you!
>>>>
>>>>>
>>>>>> ---
>>>>>>    drivers/gpu/drm/amd/display/dc/link/link_detection.c | 4
>>>>>> ++++
>>>>>>    1 file changed, 4 insertions(+)
>>>>>>
>>>>>> diff --git
>>>>>> a/drivers/gpu/drm/amd/display/dc/link/link_detection.c
>>>>>> b/drivers/gpu/drm/amd/display/dc/link/link_detection.c
>>>>>> index 827b630daf49..42180e6aca91 100644
>>>>>> --- a/drivers/gpu/drm/amd/display/dc/link/link_detection.c
>>>>>> +++ b/drivers/gpu/drm/amd/display/dc/link/link_detection.c
>>>>>> @@ -1140,6 +1140,10 @@ static bool
>>>>>> detect_link_and_local_sink(struct dc_link *link,
>>>>>>                   if (sink->sink_signal ==
>>>>>> SIGNAL_TYPE_HDMI_TYPE_A &&
>>>>>>                       !sink->edid_caps.edid_hdmi)
>>>>>>                           sink->sink_signal =
>>>>>> SIGNAL_TYPE_DVI_SINGLE_LINK;
>>>>>> +               else if (dc_is_dvi_signal(sink->sink_signal)
>>>>>> &&
>>>>>> +                       aud_support->hdmi_audio_native &&
>>>>>> +                       sink->edid_caps.edid_hdmi)
>>
>> nitpick: probably need extra spaces to align with dc_is_dvi_signal,
> 
> Thank you for the comment!
> 
> The check patch script actually warns against using spaces and tabs on
> the same line, so I wanted to avoid doing that.
> 
> I couldn't find a clear guideline on how to format multiline
> conditions, so I just aligned them to the other conditions that were
> already here.

I did not see any warning as below, but this is a nitpick.

--- a/drivers/gpu/drm/amd/display/dc/link/link_detection.c
+++ b/drivers/gpu/drm/amd/display/dc/link/link_detection.c
@@ -1140,6 +1140,10 @@ static bool detect_link_and_local_sink(struct 
dc_link *link,
  		if (sink->sink_signal == SIGNAL_TYPE_HDMI_TYPE_A &&
  		    !sink->edid_caps.edid_hdmi)
  			sink->sink_signal = SIGNAL_TYPE_DVI_SINGLE_LINK;
+		else if (dc_is_dvi_signal(sink->sink_signal) &&
+			 aud_support->hdmi_audio_native &&
+			 sink->edid_caps.edid_hdmi)
+			sink->sink_signal = SIGNAL_TYPE_HDMI_TYPE_A;

  		if (link->local_sink && dc_is_dp_signal(sink_caps.signal))
  			dp_trace_init(link);
-- 
2.43.0

alexhung@ws:~/src/kernel/amdgpu(review)$ ./scripts/checkpatch.pl 
0001-drm-amd-display-Fix-DVI-D-HDMI-adapters.patch
total: 0 errors, 0 warnings, 10 lines checked

0001-drm-amd-display-Fix-DVI-D-HDMI-adapters.patch has no obvious style 
problems and is ready for submission.


> 
>> but
>> I can fix it manually after this patch passes promotion test.
>>
>>>>>> +                       sink->sink_signal =>>>>
>>>>>> SIGNAL_TYPE_HDMI_TYPE_A;
>>>>>>
>>>>>>                   if (link->local_sink &&
>>>>>> dc_is_dp_signal(sink_caps.signal))
>>>>>>                           dp_trace_init(link);
>>>>>> --
>>>>>> 2.50.1
>>>>>>

