Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 37BC2C5B552
	for <amd-gfx@archiver.kernel.org>; Tue, 10 Jun 2025 08:24:45 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C98EE10E49A;
	Tue, 10 Jun 2025 08:24:44 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="jsswhm4N";
	dkim-atps=neutral
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2048.outbound.protection.outlook.com [40.107.223.48])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3441410E49A
 for <amd-gfx@lists.freedesktop.org>; Tue, 10 Jun 2025 08:24:43 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Ajotm0EL4guAojxFXWytylVDrtpqvb9ho1K+CpFBc6CZ6sryR/rLHbWlo9Bs39b/QONUvkzKYPzbBsWpauKoE96Eoiv8deh8Vj7A2Gdq8nO+nBV+TRTCd7GzCq4C/CRlvJiyOqoUHfPW4AnTWOa61Trt3FA3TlzeKMmc7Q/2TPrKywEFvBAn2QDmB969CacARx7LoIRZ1qCuGKOB4TE+OSl9ULU2cuU6QZK3ZXbyVUbuRRV6fY8oqggtYgigwAbjFec1RfZjuexdWNavZgXz95n1Ib/5BtFYM0RGaE8elSMnnnawglqXLq8XYCwepzK6V0wwb5qT6FvKgCDgBZkGEQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dqOZG32Od1/0SCPUvHzvpoIICZMVmgEf6dtcMaajf0s=;
 b=W8IzmFs2DCRS3+hg1LlhfqUxyYlcRYVLUPHbVzI5oI2gffd/XSZyhkCdWiNHyFi9ZCf8LdhALYBHjrQhlgyhNZ6CW8b/nS0uZR3H1hcyNTAhwX6V6J6RnGfD41aB11qkcaPOJEPyrJ4eXHqLsBuJM8WYOQDn75jfn4XnQAmAKummgLNbI3KM0mxZ9ZUiGNbf1I9S0w9VMvHoWQ+dofc9e8JLNlZya6nYJriCzeahOYl7d5r2qtFGi0EJLsk0B9goa5CQ/Uk1M1FtqaTj0SvdhjnyX5AtjwtCeOxdhK+c/A/xkiOHRqnETQ1Iuztq/FrCIsoPyqtssjEmD7ZcDiSBew==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dqOZG32Od1/0SCPUvHzvpoIICZMVmgEf6dtcMaajf0s=;
 b=jsswhm4NkRotVEn1hAck4RW600l3/p0AovV+rRhDBbI/Zu9emHoi0m25HA1uJ3Q+6NDOPBw5K7zxJ/83P0boCM8dhLhOzEgXuV0eWS29pMDN+zDLlRCtdJ1Bw2AvcGsqXGl/8NGEpWdnQxVJFVCwf4Ahlikk2HYw1pVARijqj9A=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by SN7PR12MB7884.namprd12.prod.outlook.com (2603:10b6:806:343::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8792.34; Tue, 10 Jun
 2025 08:24:38 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5%7]) with mapi id 15.20.8722.031; Tue, 10 Jun 2025
 08:24:38 +0000
Message-ID: <c2ea0f45-5962-472e-bd05-547f8bbb71eb@amd.com>
Date: Tue, 10 Jun 2025 10:24:35 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 06/29] drm/amdgpu: update ring reset function signature
To: Alex Deucher <alexdeucher@gmail.com>
Cc: Alex Deucher <alexander.deucher@amd.com>, amd-gfx@lists.freedesktop.org
References: <20250606064354.5858-1-alexander.deucher@amd.com>
 <20250606064354.5858-7-alexander.deucher@amd.com>
 <62a1601e-990a-498e-a64b-d96bfa5567e6@amd.com>
 <CADnq5_NVyLr6O71si=svVJr-Ev6TOGtLs4W32T6fayQPDyfr8Q@mail.gmail.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <CADnq5_NVyLr6O71si=svVJr-Ev6TOGtLs4W32T6fayQPDyfr8Q@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR2P281CA0131.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:9e::14) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|SN7PR12MB7884:EE_
X-MS-Office365-Filtering-Correlation-Id: fbee9f63-6939-4efc-92be-08dda7f83d66
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?bnUwTG4wYUx5VVkvWEp4SDhKdUZFaVB5MlpuSVc3RDVtYk5OYlVpMFdMS2s0?=
 =?utf-8?B?LzJzbWsyOTYxRzBudEFaRnl4VVVJZnZtKzBJZFZxaFI4blc2a3Z4M0hoQzFs?=
 =?utf-8?B?Qno3RC9MZlc5UHdmRktHYzQyMHRySTVBcFBtQzNNYlAxd3RSVS9xRktWUVd1?=
 =?utf-8?B?Y0dWL1cwVjAyMGlYQnJPc0s4UVJrTlBCRERCSkhYbm5BU2x1OGJjbDI0UTVU?=
 =?utf-8?B?RndZK1Q1ZmF4c1dUSVR3OTZkSDFpTzRiL3hhRlZzQXpEWDBnbmpuNC95ck1Y?=
 =?utf-8?B?SlNqeG1iVjRQUzl3dXcwVm1QaGZVNFoyN3RKZWhHcm41OXpicWxSTm1tTDJW?=
 =?utf-8?B?VlhmOWhGTnprWWh0ODA2dmxqanV2cVZoR1pWc3RGR2hTaW91WTlvb0FWMC9m?=
 =?utf-8?B?cklYeTB5dDRyaGt5bHFYTldIV3kxVEhYRkNNSGIwUXplVzQ4T1ZONWxuNmJM?=
 =?utf-8?B?Nzc2NUJ6YjVaY2k5RkxRWDFlM3JaYlM2bHU1bWNHTDlKUkVHZTZWU0Nua0Rx?=
 =?utf-8?B?WDduaDNQVUcvMFZGeHhPTWNYdUQxQjVhK1Z6aEV2aDRpYXRkUFhiL2htaW1i?=
 =?utf-8?B?dmxMNjgrdmc5Z1QrNXp4SHhPRzZaUXVpRlhuSVpINytIY1BreDB6bE9YOG8w?=
 =?utf-8?B?SG5EeTZyMkk5VkxHdWhwN2ZkeDBRV280endpN05KamVEWHUyaHM0eFhmckUy?=
 =?utf-8?B?VlpaR3hqOVlOSEYwMnNyZndKZDlHRWNHR1Q5ZFBFYTRPZGQ4c3E4MEJkUk5w?=
 =?utf-8?B?UDhtVDdza2FkOXh2ajJGam85TjNuL1E4ZC9ad1hMZTZHRHIrWjF4NERQdTJ2?=
 =?utf-8?B?WDFRNkhQNlJYdzVhN0pOd2YrbzMwUUNIQjNlUVgvbTJacWI5YndLTjdZa2sx?=
 =?utf-8?B?V2EzbEFvZG1KYVcyK0x2NmZlSlArQko3Ujl4ZVpUY3R6UjF6ZVJwcWxaNTZo?=
 =?utf-8?B?d3ExbXU4Uy8wOFNRQU55OVlmdkFKODNiRWcrbGxnODhPLzZleTBhT3FId3JL?=
 =?utf-8?B?Z2k5UmhEcVR2NTNYaDB3dmY0MzdrM3pJNFBrMjQwOWZNUEZmWm5ERXprNXhB?=
 =?utf-8?B?a1FSVzBxK3ZGV3NQNDNkelhqQ01RZlB3VjJvSmlORHowNmxKY1MvM054bkty?=
 =?utf-8?B?b1R0SEhBUVdIV1BWdUtIQnUwc2FnRk5aUVJkbFVPT0FXbWIvWE4zbFN6S213?=
 =?utf-8?B?b3RJNXZjNEh3WXZSZzlqNG9LNE5kVjNjM3pBSmZnY0NsNDY5QzVTVTZPclRq?=
 =?utf-8?B?SndVUFIvd3ZMWWd3UG5rZUNML2g1SStrMEo2NUxFVGYxQ3FOUUlpb2Fza1pF?=
 =?utf-8?B?VEwvOWxSNHJIRVVRVGk1SUtZUTVpRWxhZkRtQ0VxL0ExeWFMbHpLbEN0UjV0?=
 =?utf-8?B?S2xFMWR4b1lnS3F3THZldVRzZTB2cUJRTkYvckxpYis1aGo0dlZYMG56YXhJ?=
 =?utf-8?B?TVYzanM1VGdUNGlSMkNXejUrQS9YNFZQNlJpWnpaUEFaTHRzS0hlalRTUUpD?=
 =?utf-8?B?TEpBN0VxKytyQ0wrTVoyOUcxNnJEQUV6TkN6RVNjM2tWR0ZYL0F0bGdrMUVl?=
 =?utf-8?B?TFZZK1ZlYVZzWlQ0S3JWd3VhWTdyMCtqV3A5dk4zaWZzUks0b3VDSElFVzJx?=
 =?utf-8?B?RDAvOVZQQXArSm11L0h4VUNmOThRdFcraWtsa3lGQVpsbXhPNWRURTdGcjYx?=
 =?utf-8?B?WEd6UEFKWHluUVd6UkVHUHg1RlNnS2psbWszNVFUaGp2YkZGZWZtb3pmMDZ1?=
 =?utf-8?B?aHJMZTNVZE5kTUZkQlpKR2YzN2hNUmFzdDFiNXVGWXNQK2p3UUw2R2lIWkww?=
 =?utf-8?B?RlhpUFhyWHVjTFZiRU9lVnVHQkpDc2lidzM3Y2NydmlNYkMzUmEvazlUbi9l?=
 =?utf-8?B?djNZZFNtL2o2cDI5VVR3MmZGV3hHNTJSVkw0VnFodWNPYWc9PQ==?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?d05LTlNRUDV6QnNhOUZFd1NwTytPeXVUMUxHS0laY1lYdThGc0tiTEF6UHhU?=
 =?utf-8?B?Wm5yTjJiMnVrR0QydjR6bUdNQ1Rabnk0dkFPbG5GVTZtN1phK1BINm5uVHhF?=
 =?utf-8?B?QnFHQUcyS0FqWHNvaWRkY0JmV1Q1QldUa2dGazNFQXh6RTNzZ3hRc3Bmb3hi?=
 =?utf-8?B?ZDByU281aitYNHVqVENiT2Q2Y2lHZGwzMUkvbnFKdWxjY2ltdjlTMzErQmlO?=
 =?utf-8?B?bEhoT0lwTm43Y09WK0p6ZlhBRndTZGRXd2xkVmJTTmsrSHEzWmdJT29WdFlx?=
 =?utf-8?B?eWdyQkppb1hvamxTS2lpZ2lLaEx3azhxeFd5TzVkTFUzT1BoVEdEeW04T01z?=
 =?utf-8?B?MEl6d3BlWVpVVFZMa3ppUGthY00vblpwQm1uZTluVWNuNXFudnRTcHJmMVVa?=
 =?utf-8?B?a1luakY1dDd5VVNYUFZQZmxpbWxjUTN1MC9tM3Ewc2NTRmxIR3NoSnljNUVJ?=
 =?utf-8?B?OEZxTWlCY1UrTUx3RU92SDJTMWQ0cFA2RFUzWVpWaDhCSDF6TFFLdTNJcGxu?=
 =?utf-8?B?YkhINnFxWERSNitlQ3pPRzd1WUlVVWtBWVF3VWU0ZEZZQ0ROSUsxdGtmYm9K?=
 =?utf-8?B?MHYzamQycGQvUDZYazlXajNReWkzUi91S0NoTk9QL3Q3SHhtWkFKT1ZtbjFM?=
 =?utf-8?B?bU9TWFM2MnN5Sk1UcFRjaGIrQlZzUWRUVkQ0em5EaS9LbDA1cU96UUxHNENN?=
 =?utf-8?B?Y1ZacXgza1YzazBVWG45MlFXQWtmbnRDZzVKeHBtb1BpaURPR1F0aUJTazJ6?=
 =?utf-8?B?UGlyVC9GNjhibERBQ2prRkpWRUFPYlphaXZzY0RCbDg5eEp1cEtsd29RMkNx?=
 =?utf-8?B?NWJQRC81aWc4UC9tQkt3L2tpMHM4TkJmZmJZKzFLbURmRGlWTEJHWUhSTGw3?=
 =?utf-8?B?dE05cTJvblVXZld0dHhQNkhWNmFlUHIwVnh4bVR6aWRFQ0hqRGx4SmcxREpS?=
 =?utf-8?B?cWtPR0QrU0MwNXY1eHg3YUE0ZlNSTmNac0tySFVuTC9FdDFzUHZRNUNSbHJs?=
 =?utf-8?B?Rlp6MHFCc05hNmVUdmxZUWJnM2JoaW54SXZMVzFCd1B6RzFIY1pZdEwzMmEr?=
 =?utf-8?B?anlET0h6SVY5VUFiVEhiaVVpU2IvZCtZTXlRVGpWTzRudGsyTU9tMjV5Zk5z?=
 =?utf-8?B?WFVYN2lXZ2NzUjBjMVJ1K3ArS0RSck56OGxMZHhjUHh2c1FDUGt1WFpVOVIx?=
 =?utf-8?B?T2RpL2VrY1BLRkVMeEdKTWJHRjF3YnpXcC8rNU5zUGFka1A2ZDk1TkNsWTFO?=
 =?utf-8?B?bDdTRCtONFJjMEo0Mm0zdTg4OUVTbG5OeithS2U5c0RNamV3b3JheVNWdm8w?=
 =?utf-8?B?M21JTFFRS1N6YTVWT2UvMnhzWWYrYWNoZEtHZVhtTU5UWVdVR244ZHJ2ekNR?=
 =?utf-8?B?bmxQU25iN21PRmV2NHlySmJ5MGNDdG9Od1Y3Zk54c2JxR3MybE0yS0RvbGFV?=
 =?utf-8?B?cVBwTWFkZVkwWTNFR1NzTEVQYWhwekM2UW1hNU1sell6TEZzUTN1QmFTWDAy?=
 =?utf-8?B?dGNSekxZVzU3SWFTV09mampVQnVsd0hwTFhseDRRdDREMll0eXF3UFdKb2ht?=
 =?utf-8?B?S1JXM2NJdmZVV0Z1Tmw1MDBCeEpjcTJsRkxpVXc3VEdKVFEwMUtmWjBRWCts?=
 =?utf-8?B?Ti8vRXNQRTF1aU1mRzMwNW9wd0Z1ZTNwdmxtVkhHdDhmWEk4TWs2RFVxM09J?=
 =?utf-8?B?aUNLTWcxYlZVWHArdE82TUExV3IvaThXcVBvNGpWY3NpaGhVb0ZKMGRzYVV1?=
 =?utf-8?B?NGlHaWF6eUo4a1MzV1NBM21SZmhhS3dNK1JnVmczbS83czRSaFhkM0l2NnJ5?=
 =?utf-8?B?MFBWeVl2QmlMWTF3aXJBanJ6NmRwazZvNFhJV2creVZDcHlmY0RLV3RjcWVk?=
 =?utf-8?B?cm4xZTNTa05nN0pPVHpIODhjZFUzMkN5MHE3OEt2UVZ5bWN1Sjl5WTlPcmlV?=
 =?utf-8?B?YURjN25FWWZBQzhkb0s3NzRuaHVPRDVkY1dyZWFRa00wQ2R6TjRRNjZHOUc3?=
 =?utf-8?B?NHFrK21MQ3J5Tk1paGM3SGUrcTh5RWlzVjhqU09YMEJrQUxSUHlxWllWaWVV?=
 =?utf-8?B?VUJZMTZzYWRTblNRUFpBWGR1dHJDWm1ZdFZLbzlNRGN3U1hvOHJ6dksxK05D?=
 =?utf-8?Q?HtGU=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fbee9f63-6939-4efc-92be-08dda7f83d66
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jun 2025 08:24:38.3693 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: IracIuowvMOEgtq2XE9ZMeZEXPYqIo7mPS+J0G3TuKhrXZcg7fi0q+YB5JTqFM9C
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7884
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

On 6/6/25 18:00, Alex Deucher wrote:
> On Fri, Jun 6, 2025 at 7:41 AM Christian König <christian.koenig@amd.com> wrote:
>>
>> On 6/6/25 08:43, Alex Deucher wrote:
>>> Going forward, we'll need more than just the vmid.  Everything
>>> we need in currently in the amdgpu job structure, so just
>>> pass that in.
>>
>> Please don't the job is just a container for the submission, it should not be part of any reset handling.
>>
>> What information is actually needed here?
> 
> We need job->vmid, job->base.s_fence->finished, job->hw_fence.

VMID and HW fence make sense, but why is the finished fence needed?

Christian.


> 
> Alex
> 
>>
>> Regards,
>> Christian.
>>
>>
>>>
>>> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
>>> ---
>>>  drivers/gpu/drm/amd/amdgpu/amdgpu_job.c  |  2 +-
>>>  drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h |  4 ++--
>>>  drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c   |  7 ++++---
>>>  drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c   | 10 ++++++----
>>>  drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c   | 10 ++++++----
>>>  drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c    |  2 +-
>>>  drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c  |  2 +-
>>>  drivers/gpu/drm/amd/amdgpu/jpeg_v2_0.c   |  3 ++-
>>>  drivers/gpu/drm/amd/amdgpu/jpeg_v2_5.c   |  3 ++-
>>>  drivers/gpu/drm/amd/amdgpu/jpeg_v3_0.c   |  3 ++-
>>>  drivers/gpu/drm/amd/amdgpu/jpeg_v4_0.c   |  3 ++-
>>>  drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_3.c |  3 ++-
>>>  drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_1.c |  3 ++-
>>>  drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c |  3 ++-
>>>  drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c   |  3 ++-
>>>  drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c   |  3 ++-
>>>  drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c   |  5 +++--
>>>  drivers/gpu/drm/amd/amdgpu/sdma_v7_0.c   |  5 +++--
>>>  drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c    |  3 ++-
>>>  drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c  |  3 ++-
>>>  drivers/gpu/drm/amd/amdgpu/vcn_v4_0_5.c  |  3 ++-
>>>  drivers/gpu/drm/amd/amdgpu/vcn_v5_0_0.c  |  3 ++-
>>>  22 files changed, 53 insertions(+), 33 deletions(-)
>>>
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c
>>> index ddb9d3269357c..80d4dfebde24f 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c
>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c
>>> @@ -155,7 +155,7 @@ static enum drm_gpu_sched_stat amdgpu_job_timedout(struct drm_sched_job *s_job)
>>>               if (is_guilty)
>>>                       dma_fence_set_error(&s_job->s_fence->finished, -ETIME);
>>>
>>> -             r = amdgpu_ring_reset(ring, job->vmid);
>>> +             r = amdgpu_ring_reset(ring, job);
>>>               if (!r) {
>>>                       if (amdgpu_ring_sched_ready(ring))
>>>                               drm_sched_stop(&ring->sched, s_job);
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
>>> index e1f25218943a4..ab5402d7ce9c8 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
>>> @@ -268,7 +268,7 @@ struct amdgpu_ring_funcs {
>>>       void (*patch_cntl)(struct amdgpu_ring *ring, unsigned offset);
>>>       void (*patch_ce)(struct amdgpu_ring *ring, unsigned offset);
>>>       void (*patch_de)(struct amdgpu_ring *ring, unsigned offset);
>>> -     int (*reset)(struct amdgpu_ring *ring, unsigned int vmid);
>>> +     int (*reset)(struct amdgpu_ring *ring, struct amdgpu_job *job);
>>>       void (*emit_cleaner_shader)(struct amdgpu_ring *ring);
>>>       bool (*is_guilty)(struct amdgpu_ring *ring);
>>>  };
>>> @@ -425,7 +425,7 @@ struct amdgpu_ring {
>>>  #define amdgpu_ring_patch_cntl(r, o) ((r)->funcs->patch_cntl((r), (o)))
>>>  #define amdgpu_ring_patch_ce(r, o) ((r)->funcs->patch_ce((r), (o)))
>>>  #define amdgpu_ring_patch_de(r, o) ((r)->funcs->patch_de((r), (o)))
>>> -#define amdgpu_ring_reset(r, v) (r)->funcs->reset((r), (v))
>>> +#define amdgpu_ring_reset(r, j) (r)->funcs->reset((r), (j))
>>>
>>>  unsigned int amdgpu_ring_max_ibs(enum amdgpu_ring_type type);
>>>  int amdgpu_ring_alloc(struct amdgpu_ring *ring, unsigned ndw);
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
>>> index 75ea071744eb5..c58e7040c732a 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
>>> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
>>> @@ -9522,7 +9522,8 @@ static void gfx_v10_ring_insert_nop(struct amdgpu_ring *ring, uint32_t num_nop)
>>>       amdgpu_ring_insert_nop(ring, num_nop - 1);
>>>  }
>>>
>>> -static int gfx_v10_0_reset_kgq(struct amdgpu_ring *ring, unsigned int vmid)
>>> +static int gfx_v10_0_reset_kgq(struct amdgpu_ring *ring,
>>> +                            struct amdgpu_job *job)
>>>  {
>>>       struct amdgpu_device *adev = ring->adev;
>>>       struct amdgpu_kiq *kiq = &adev->gfx.kiq[0];
>>> @@ -9547,7 +9548,7 @@ static int gfx_v10_0_reset_kgq(struct amdgpu_ring *ring, unsigned int vmid)
>>>
>>>       addr = amdgpu_bo_gpu_offset(ring->mqd_obj) +
>>>               offsetof(struct v10_gfx_mqd, cp_gfx_hqd_active);
>>> -     tmp = REG_SET_FIELD(0, CP_VMID_RESET, RESET_REQUEST, 1 << vmid);
>>> +     tmp = REG_SET_FIELD(0, CP_VMID_RESET, RESET_REQUEST, 1 << job->vmid);
>>>       if (ring->pipe == 0)
>>>               tmp = REG_SET_FIELD(tmp, CP_VMID_RESET, PIPE0_QUEUES, 1 << ring->queue);
>>>       else
>>> @@ -9579,7 +9580,7 @@ static int gfx_v10_0_reset_kgq(struct amdgpu_ring *ring, unsigned int vmid)
>>>  }
>>>
>>>  static int gfx_v10_0_reset_kcq(struct amdgpu_ring *ring,
>>> -                            unsigned int vmid)
>>> +                            struct amdgpu_job *job)
>>>  {
>>>       struct amdgpu_device *adev = ring->adev;
>>>       struct amdgpu_kiq *kiq = &adev->gfx.kiq[0];
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
>>> index afd6d59164bfa..0ee7bdd509741 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
>>> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
>>> @@ -6806,7 +6806,8 @@ static int gfx_v11_reset_gfx_pipe(struct amdgpu_ring *ring)
>>>       return 0;
>>>  }
>>>
>>> -static int gfx_v11_0_reset_kgq(struct amdgpu_ring *ring, unsigned int vmid)
>>> +static int gfx_v11_0_reset_kgq(struct amdgpu_ring *ring,
>>> +                            struct amdgpu_job *job)
>>>  {
>>>       struct amdgpu_device *adev = ring->adev;
>>>       int r;
>>> @@ -6814,7 +6815,7 @@ static int gfx_v11_0_reset_kgq(struct amdgpu_ring *ring, unsigned int vmid)
>>>       if (amdgpu_sriov_vf(adev))
>>>               return -EINVAL;
>>>
>>> -     r = amdgpu_mes_reset_legacy_queue(ring->adev, ring, vmid, false);
>>> +     r = amdgpu_mes_reset_legacy_queue(ring->adev, ring, job->vmid, false);
>>>       if (r) {
>>>
>>>               dev_warn(adev->dev, "reset via MES failed and try pipe reset %d\n", r);
>>> @@ -6968,7 +6969,8 @@ static int gfx_v11_0_reset_compute_pipe(struct amdgpu_ring *ring)
>>>       return 0;
>>>  }
>>>
>>> -static int gfx_v11_0_reset_kcq(struct amdgpu_ring *ring, unsigned int vmid)
>>> +static int gfx_v11_0_reset_kcq(struct amdgpu_ring *ring,
>>> +                            struct amdgpu_job *job)
>>>  {
>>>       struct amdgpu_device *adev = ring->adev;
>>>       int r = 0;
>>> @@ -6976,7 +6978,7 @@ static int gfx_v11_0_reset_kcq(struct amdgpu_ring *ring, unsigned int vmid)
>>>       if (amdgpu_sriov_vf(adev))
>>>               return -EINVAL;
>>>
>>> -     r = amdgpu_mes_reset_legacy_queue(ring->adev, ring, vmid, true);
>>> +     r = amdgpu_mes_reset_legacy_queue(ring->adev, ring, job->vmid, true);
>>>       if (r) {
>>>               dev_warn(adev->dev, "fail(%d) to reset kcq and try pipe reset\n", r);
>>>               r = gfx_v11_0_reset_compute_pipe(ring);
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
>>> index 1234c8d64e20d..a26417d53411b 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
>>> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
>>> @@ -5307,7 +5307,8 @@ static int gfx_v12_reset_gfx_pipe(struct amdgpu_ring *ring)
>>>       return 0;
>>>  }
>>>
>>> -static int gfx_v12_0_reset_kgq(struct amdgpu_ring *ring, unsigned int vmid)
>>> +static int gfx_v12_0_reset_kgq(struct amdgpu_ring *ring,
>>> +                            struct amdgpu_job *job)
>>>  {
>>>       struct amdgpu_device *adev = ring->adev;
>>>       int r;
>>> @@ -5315,7 +5316,7 @@ static int gfx_v12_0_reset_kgq(struct amdgpu_ring *ring, unsigned int vmid)
>>>       if (amdgpu_sriov_vf(adev))
>>>               return -EINVAL;
>>>
>>> -     r = amdgpu_mes_reset_legacy_queue(ring->adev, ring, vmid, false);
>>> +     r = amdgpu_mes_reset_legacy_queue(ring->adev, ring, job->vmid, false);
>>>       if (r) {
>>>               dev_warn(adev->dev, "reset via MES failed and try pipe reset %d\n", r);
>>>               r = gfx_v12_reset_gfx_pipe(ring);
>>> @@ -5421,7 +5422,8 @@ static int gfx_v12_0_reset_compute_pipe(struct amdgpu_ring *ring)
>>>       return 0;
>>>  }
>>>
>>> -static int gfx_v12_0_reset_kcq(struct amdgpu_ring *ring, unsigned int vmid)
>>> +static int gfx_v12_0_reset_kcq(struct amdgpu_ring *ring,
>>> +                            struct amdgpu_job *job)
>>>  {
>>>       struct amdgpu_device *adev = ring->adev;
>>>       int r;
>>> @@ -5429,7 +5431,7 @@ static int gfx_v12_0_reset_kcq(struct amdgpu_ring *ring, unsigned int vmid)
>>>       if (amdgpu_sriov_vf(adev))
>>>               return -EINVAL;
>>>
>>> -     r = amdgpu_mes_reset_legacy_queue(ring->adev, ring, vmid, true);
>>> +     r = amdgpu_mes_reset_legacy_queue(ring->adev, ring, job->vmid, true);
>>>       if (r) {
>>>               dev_warn(adev->dev, "fail(%d) to reset kcq  and try pipe reset\n", r);
>>>               r = gfx_v12_0_reset_compute_pipe(ring);
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
>>> index d50e125fd3e0d..5e650cc5fcb26 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
>>> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
>>> @@ -7153,7 +7153,7 @@ static void gfx_v9_ring_insert_nop(struct amdgpu_ring *ring, uint32_t num_nop)
>>>  }
>>>
>>>  static int gfx_v9_0_reset_kcq(struct amdgpu_ring *ring,
>>> -                           unsigned int vmid)
>>> +                           struct amdgpu_job *job)
>>>  {
>>>       struct amdgpu_device *adev = ring->adev;
>>>       struct amdgpu_kiq *kiq = &adev->gfx.kiq[0];
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c b/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
>>> index c233edf605694..a7dadff3dca31 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
>>> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
>>> @@ -3552,7 +3552,7 @@ static int gfx_v9_4_3_reset_hw_pipe(struct amdgpu_ring *ring)
>>>  }
>>>
>>>  static int gfx_v9_4_3_reset_kcq(struct amdgpu_ring *ring,
>>> -                             unsigned int vmid)
>>> +                             struct amdgpu_job *job)
>>>  {
>>>       struct amdgpu_device *adev = ring->adev;
>>>       struct amdgpu_kiq *kiq = &adev->gfx.kiq[ring->xcc_id];
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/jpeg_v2_0.c b/drivers/gpu/drm/amd/amdgpu/jpeg_v2_0.c
>>> index 4cde8a8bcc837..6cd3fbe00d6b9 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/jpeg_v2_0.c
>>> +++ b/drivers/gpu/drm/amd/amdgpu/jpeg_v2_0.c
>>> @@ -764,7 +764,8 @@ static int jpeg_v2_0_process_interrupt(struct amdgpu_device *adev,
>>>       return 0;
>>>  }
>>>
>>> -static int jpeg_v2_0_ring_reset(struct amdgpu_ring *ring, unsigned int vmid)
>>> +static int jpeg_v2_0_ring_reset(struct amdgpu_ring *ring,
>>> +                             struct amdgpu_job *job)
>>>  {
>>>       jpeg_v2_0_stop(ring->adev);
>>>       jpeg_v2_0_start(ring->adev);
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/jpeg_v2_5.c b/drivers/gpu/drm/amd/amdgpu/jpeg_v2_5.c
>>> index 8b39e114f3be1..8ed41868f6c32 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/jpeg_v2_5.c
>>> +++ b/drivers/gpu/drm/amd/amdgpu/jpeg_v2_5.c
>>> @@ -643,7 +643,8 @@ static int jpeg_v2_5_process_interrupt(struct amdgpu_device *adev,
>>>       return 0;
>>>  }
>>>
>>> -static int jpeg_v2_5_ring_reset(struct amdgpu_ring *ring, unsigned int vmid)
>>> +static int jpeg_v2_5_ring_reset(struct amdgpu_ring *ring,
>>> +                             struct amdgpu_job *job)
>>>  {
>>>       jpeg_v2_5_stop_inst(ring->adev, ring->me);
>>>       jpeg_v2_5_start_inst(ring->adev, ring->me);
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/jpeg_v3_0.c b/drivers/gpu/drm/amd/amdgpu/jpeg_v3_0.c
>>> index 2f8510c2986b9..3512fbb543301 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/jpeg_v3_0.c
>>> +++ b/drivers/gpu/drm/amd/amdgpu/jpeg_v3_0.c
>>> @@ -555,7 +555,8 @@ static int jpeg_v3_0_process_interrupt(struct amdgpu_device *adev,
>>>       return 0;
>>>  }
>>>
>>> -static int jpeg_v3_0_ring_reset(struct amdgpu_ring *ring, unsigned int vmid)
>>> +static int jpeg_v3_0_ring_reset(struct amdgpu_ring *ring,
>>> +                             struct amdgpu_job *job)
>>>  {
>>>       jpeg_v3_0_stop(ring->adev);
>>>       jpeg_v3_0_start(ring->adev);
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0.c b/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0.c
>>> index f17ec5414fd69..c8efeaf0a2a69 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0.c
>>> +++ b/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0.c
>>> @@ -720,7 +720,8 @@ static int jpeg_v4_0_process_interrupt(struct amdgpu_device *adev,
>>>       return 0;
>>>  }
>>>
>>> -static int jpeg_v4_0_ring_reset(struct amdgpu_ring *ring, unsigned int vmid)
>>> +static int jpeg_v4_0_ring_reset(struct amdgpu_ring *ring,
>>> +                             struct amdgpu_job *job)
>>>  {
>>>       if (amdgpu_sriov_vf(ring->adev))
>>>               return -EINVAL;
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_3.c b/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_3.c
>>> index 79e342d5ab28d..8b07c3651c579 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_3.c
>>> +++ b/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_3.c
>>> @@ -1143,7 +1143,8 @@ static void jpeg_v4_0_3_core_stall_reset(struct amdgpu_ring *ring)
>>>       WREG32_SOC15(JPEG, jpeg_inst, regJPEG_CORE_RST_CTRL, 0x00);
>>>  }
>>>
>>> -static int jpeg_v4_0_3_ring_reset(struct amdgpu_ring *ring, unsigned int vmid)
>>> +static int jpeg_v4_0_3_ring_reset(struct amdgpu_ring *ring,
>>> +                               struct amdgpu_job *job)
>>>  {
>>>       if (amdgpu_sriov_vf(ring->adev))
>>>               return -EOPNOTSUPP;
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_1.c b/drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_1.c
>>> index 3b6f65a256464..0a21a13e19360 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_1.c
>>> +++ b/drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_1.c
>>> @@ -834,7 +834,8 @@ static void jpeg_v5_0_1_core_stall_reset(struct amdgpu_ring *ring)
>>>       WREG32_SOC15(JPEG, jpeg_inst, regJPEG_CORE_RST_CTRL, 0x00);
>>>  }
>>>
>>> -static int jpeg_v5_0_1_ring_reset(struct amdgpu_ring *ring, unsigned int vmid)
>>> +static int jpeg_v5_0_1_ring_reset(struct amdgpu_ring *ring,
>>> +                               struct amdgpu_job *job)
>>>  {
>>>       if (amdgpu_sriov_vf(ring->adev))
>>>               return -EOPNOTSUPP;
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c b/drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c
>>> index 9c169112a5e7b..ffd67d51b335f 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c
>>> +++ b/drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c
>>> @@ -1667,7 +1667,8 @@ static bool sdma_v4_4_2_page_ring_is_guilty(struct amdgpu_ring *ring)
>>>       return sdma_v4_4_2_is_queue_selected(adev, instance_id, true);
>>>  }
>>>
>>> -static int sdma_v4_4_2_reset_queue(struct amdgpu_ring *ring, unsigned int vmid)
>>> +static int sdma_v4_4_2_reset_queue(struct amdgpu_ring *ring,
>>> +                                struct amdgpu_job *job)
>>>  {
>>>       struct amdgpu_device *adev = ring->adev;
>>>       u32 id = GET_INST(SDMA0, ring->me);
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c b/drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c
>>> index 9505ae96fbecc..46affee1c2da0 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c
>>> +++ b/drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c
>>> @@ -1538,7 +1538,8 @@ static int sdma_v5_0_soft_reset(struct amdgpu_ip_block *ip_block)
>>>       return 0;
>>>  }
>>>
>>> -static int sdma_v5_0_reset_queue(struct amdgpu_ring *ring, unsigned int vmid)
>>> +static int sdma_v5_0_reset_queue(struct amdgpu_ring *ring,
>>> +                              struct amdgpu_job *job)
>>>  {
>>>       struct amdgpu_device *adev = ring->adev;
>>>       u32 inst_id = ring->me;
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c b/drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c
>>> index a6e612b4a8928..581e75b7d01a8 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c
>>> +++ b/drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c
>>> @@ -1451,7 +1451,8 @@ static int sdma_v5_2_wait_for_idle(struct amdgpu_ip_block *ip_block)
>>>       return -ETIMEDOUT;
>>>  }
>>>
>>> -static int sdma_v5_2_reset_queue(struct amdgpu_ring *ring, unsigned int vmid)
>>> +static int sdma_v5_2_reset_queue(struct amdgpu_ring *ring,
>>> +                              struct amdgpu_job *job)
>>>  {
>>>       struct amdgpu_device *adev = ring->adev;
>>>       u32 inst_id = ring->me;
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c b/drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c
>>> index 5a70ae17be04e..d9866009edbfc 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c
>>> +++ b/drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c
>>> @@ -1537,7 +1537,8 @@ static int sdma_v6_0_ring_preempt_ib(struct amdgpu_ring *ring)
>>>       return r;
>>>  }
>>>
>>> -static int sdma_v6_0_reset_queue(struct amdgpu_ring *ring, unsigned int vmid)
>>> +static int sdma_v6_0_reset_queue(struct amdgpu_ring *ring,
>>> +                              struct amdgpu_job *job)
>>>  {
>>>       struct amdgpu_device *adev = ring->adev;
>>>       int i, r;
>>> @@ -1555,7 +1556,7 @@ static int sdma_v6_0_reset_queue(struct amdgpu_ring *ring, unsigned int vmid)
>>>               return -EINVAL;
>>>       }
>>>
>>> -     r = amdgpu_mes_reset_legacy_queue(adev, ring, vmid, true);
>>> +     r = amdgpu_mes_reset_legacy_queue(adev, ring, job->vmid, true);
>>>       if (r)
>>>               return r;
>>>
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v7_0.c b/drivers/gpu/drm/amd/amdgpu/sdma_v7_0.c
>>> index ad47d0bdf7775..c546e73642296 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/sdma_v7_0.c
>>> +++ b/drivers/gpu/drm/amd/amdgpu/sdma_v7_0.c
>>> @@ -802,7 +802,8 @@ static bool sdma_v7_0_check_soft_reset(struct amdgpu_ip_block *ip_block)
>>>       return false;
>>>  }
>>>
>>> -static int sdma_v7_0_reset_queue(struct amdgpu_ring *ring, unsigned int vmid)
>>> +static int sdma_v7_0_reset_queue(struct amdgpu_ring *ring,
>>> +                              struct amdgpu_job *job)
>>>  {
>>>       struct amdgpu_device *adev = ring->adev;
>>>       int i, r;
>>> @@ -820,7 +821,7 @@ static int sdma_v7_0_reset_queue(struct amdgpu_ring *ring, unsigned int vmid)
>>>               return -EINVAL;
>>>       }
>>>
>>> -     r = amdgpu_mes_reset_legacy_queue(adev, ring, vmid, true);
>>> +     r = amdgpu_mes_reset_legacy_queue(adev, ring, job->vmid, true);
>>>       if (r)
>>>               return r;
>>>
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c
>>> index b5071f77f78d2..47a0deceff433 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c
>>> +++ b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c
>>> @@ -1967,7 +1967,8 @@ static int vcn_v4_0_ring_patch_cs_in_place(struct amdgpu_cs_parser *p,
>>>       return 0;
>>>  }
>>>
>>> -static int vcn_v4_0_ring_reset(struct amdgpu_ring *ring, unsigned int vmid)
>>> +static int vcn_v4_0_ring_reset(struct amdgpu_ring *ring,
>>> +                            struct amdgpu_job *job)
>>>  {
>>>       struct amdgpu_device *adev = ring->adev;
>>>       struct amdgpu_vcn_inst *vinst = &adev->vcn.inst[ring->me];
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c
>>> index 5a33140f57235..d961a824d2098 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c
>>> +++ b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c
>>> @@ -1594,7 +1594,8 @@ static void vcn_v4_0_3_unified_ring_set_wptr(struct amdgpu_ring *ring)
>>>       }
>>>  }
>>>
>>> -static int vcn_v4_0_3_ring_reset(struct amdgpu_ring *ring, unsigned int vmid)
>>> +static int vcn_v4_0_3_ring_reset(struct amdgpu_ring *ring,
>>> +                              struct amdgpu_job *job)
>>>  {
>>>       int r = 0;
>>>       int vcn_inst;
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_5.c b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_5.c
>>> index 16ade84facc78..10bd714592278 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_5.c
>>> +++ b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_5.c
>>> @@ -1465,7 +1465,8 @@ static void vcn_v4_0_5_unified_ring_set_wptr(struct amdgpu_ring *ring)
>>>       }
>>>  }
>>>
>>> -static int vcn_v4_0_5_ring_reset(struct amdgpu_ring *ring, unsigned int vmid)
>>> +static int vcn_v4_0_5_ring_reset(struct amdgpu_ring *ring,
>>> +                              struct amdgpu_job *job)
>>>  {
>>>       struct amdgpu_device *adev = ring->adev;
>>>       struct amdgpu_vcn_inst *vinst = &adev->vcn.inst[ring->me];
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_0.c b/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_0.c
>>> index f8e3f0b882da5..7e6a7ead9a086 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_0.c
>>> +++ b/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_0.c
>>> @@ -1192,7 +1192,8 @@ static void vcn_v5_0_0_unified_ring_set_wptr(struct amdgpu_ring *ring)
>>>       }
>>>  }
>>>
>>> -static int vcn_v5_0_0_ring_reset(struct amdgpu_ring *ring, unsigned int vmid)
>>> +static int vcn_v5_0_0_ring_reset(struct amdgpu_ring *ring,
>>> +                              struct amdgpu_job *job)
>>>  {
>>>       struct amdgpu_device *adev = ring->adev;
>>>       struct amdgpu_vcn_inst *vinst = &adev->vcn.inst[ring->me];
>>

