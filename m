Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 26BD0CCF9E0
	for <amd-gfx@archiver.kernel.org>; Fri, 24 Oct 2025 16:55:15 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6895910E21A;
	Fri, 24 Oct 2025 16:55:13 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="uAG7J6pq";
	dkim-atps=neutral
Received: from PH7PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11010046.outbound.protection.outlook.com [52.101.201.46])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 041C810E21A
 for <amd-gfx@lists.freedesktop.org>; Fri, 24 Oct 2025 16:55:11 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=V50c7tDizyccim3J7cdH/6Rohn/lcx+Av8lrmTdAhgAoq43lJtNY23BuFg4TinlcVsOz2WgpH8ssvwmD88v/3TvaxPU7G8kBgSA/Dyha3Mk0AiiqC9JK4umFEylPyvHkOW+WzmyNWLv14QvRBMnomVLE6EyYQGkik7wS7rQ34KTmTPVj09U8yRf0rZ/TRdjyP2TclJ3SMW4/O2OWdiRQ0fjMyhI42gxbzh/pjfDgTup8iZotdREVgypA8Wz0Pjw4J9kKxDA5CApUJrKR9SvcBQIOWMwk/cqB3wjRf7ryxf263ElGUcaIPpqrfiSakto2hF6hj62i+w1hxG6p/bxlUg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MdjEdy6o5n5OL0OUmEKEP1JKwgsB3iskpYoLhrSF1Ko=;
 b=BA7DS1uR+iIaAYNF6Q3zxAYdXtACVkC5+l+YIS7u7z+iB5jc3m12wI8pHaL74IHZrHDRVX5tSZANz/FNA5eoEeai3RdbvIS3V8fw7zewE99B18fUJXalb9jmCZ35Ex0JkMDTJGT2e9u8KlG8gn6r7/TjHpQLhFKa3ugjcxZ4Ao+zrfdtkf+4D5V4wPJbyHTLKa/LZOXXyd7F2q1k5IgxIn7hYliK+sKbD8kE6didbUTJJ90xHsqyei410kYVcTJ09zmpaX2dU4sdP4d9zo51EjvfV0TUSJgren2WXbnmTxK5IsShJ4nw/pRqLsd7cNaAyC72j+VuQOme0jhrVn2o0w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MdjEdy6o5n5OL0OUmEKEP1JKwgsB3iskpYoLhrSF1Ko=;
 b=uAG7J6pq4/UXw81umuPt7QjDF5SglE3NMKY13xG4snChDw9cdodZLsK1CFQ0/aW2GwGwctFhBFNnVM0zQsZyJ3W3nAuAf58NOqjehduWHHMKOeXtStlkp10m/e6K5IGTr/N51bv1xUFEaXvyzx7NtEgZ3e0zgaDjs3p3AlJHMb4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BL1PR12MB5753.namprd12.prod.outlook.com (2603:10b6:208:390::15)
 by SJ2PR12MB9212.namprd12.prod.outlook.com (2603:10b6:a03:563::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9253.13; Fri, 24 Oct
 2025 16:55:08 +0000
Received: from BL1PR12MB5753.namprd12.prod.outlook.com
 ([fe80::81e6:908a:a59b:87e2]) by BL1PR12MB5753.namprd12.prod.outlook.com
 ([fe80::81e6:908a:a59b:87e2%6]) with mapi id 15.20.9253.011; Fri, 24 Oct 2025
 16:55:08 +0000
Message-ID: <84127e94-064b-41cf-9be9-ef4aa32fbf10@amd.com>
Date: Fri, 24 Oct 2025 22:25:02 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [Patch v2] drm/amdkfd: add missing return value check for range
To: Philip Yang <yangp@amd.com>, Sunil Khatri <sunil.khatri@amd.com>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 Felix Kuehling <felix.kuehling@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>,
 Arunpravin Paneer Selvam <Arunpravin.PaneerSelvam@amd.com>,
 Philip Yang <Philip.Yang@amd.com>, amd-gfx@lists.freedesktop.org,
 Shirish.S@amd.com
References: <20251024111602.2128436-1-sunil.khatri@amd.com>
 <9e35463a-777e-4b6b-ad31-47cd7f07fe30@amd.com>
 <859ab89b-833d-fbf6-bc5e-1c4786b4a2c6@amd.com>
Content-Language: en-US
From: "Khatri, Sunil" <sukhatri@amd.com>
In-Reply-To: <859ab89b-833d-fbf6-bc5e-1c4786b4a2c6@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BMXPR01CA0082.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:b00:54::22) To BL1PR12MB5753.namprd12.prod.outlook.com
 (2603:10b6:208:390::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL1PR12MB5753:EE_|SJ2PR12MB9212:EE_
X-MS-Office365-Filtering-Correlation-Id: f5168365-41af-48c4-dc95-08de131e1691
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?Mi9VbkJWY0ZZeGdyVmY2cWlLb1RhOFlHTGx5UVVkOWtHU3JWOE92Y2wraUIr?=
 =?utf-8?B?TnpVS2gzc3hjcVBRK1FDdVlNcHNCN0dIMGV0alRvVFZ5OFNwWDFlaWdpemND?=
 =?utf-8?B?aEZoMFJFZjRLelE4bXRIM05ocVJvY2M4cjJTMXhBL08zcytwRlNOelJrRHFR?=
 =?utf-8?B?VU1wZ1JDSGljclFlSlZHQUFDU2dZNGQ5N3duUThFL1hQeVZFZTJERWZRQzZh?=
 =?utf-8?B?VFJVa05OZklsL2phREJodHVFNzZaK1BZdzVTeEZ1K3ZHYVJpOWdjRnF2cXJC?=
 =?utf-8?B?aXZiM2VhMEo4ckhNT0dGanFkS0t3S0NNOHZ1NXhzZk9FdzZEVm56R1lSVzFK?=
 =?utf-8?B?d2I4VzhVR1ltUVQyTk9oZ2V0UkprWXZTcGpUTU5zM3VDdElTenAvNmtPdita?=
 =?utf-8?B?cHlGS1UwVW1neEJEQVYwUWJMbXc1T29EZVNOVnVUSE8rT3dzRG1NeEQvMUVI?=
 =?utf-8?B?N2hFQ0VFQ3RHRXJxdGx6bUFoQjBDWlc4Q1JpZjNXOEdDdGVmZnZ1NDFQQVdl?=
 =?utf-8?B?dUdINWwrOXFSb0JjMzJZbUd3UW5zTXhWZlp5cVRrVEdCMVRKcU5ZVUcydjlD?=
 =?utf-8?B?cmpsRk4zSThjajdMNDR2SlI4S3ZaalNvUFlxbHBPTnpuanMyYUw0TjVFcmM5?=
 =?utf-8?B?MnpEUHBFZjE5dzBsSytwYndyckRmblB4eGVRdWtxYmlNekZaSjNpMmNUQ3Fq?=
 =?utf-8?B?OU44R1poMGhZWk4zVTFMZHRFd1FpcFVrRHpiSkM0c29ZWTNabW9UMkhXYTho?=
 =?utf-8?B?aTVmQUJPRXpyUFNJbnVpMUkyMngvRWpQSTYzSmxpMjMvd1V4MDBhRnZieU9W?=
 =?utf-8?B?UThxc3V2KzM4cDEwWElkVVd2WnFsVVo4SFFaVGpLM1ZnWTBLQ1hNc0pkWFZN?=
 =?utf-8?B?OHlKR0NnOGphUnZRUGJGQ2VMMjhsQUVtanVMYXM3SldUSlk4eUF2elkrMEwx?=
 =?utf-8?B?NllYdlp3R2RzNUpSaHFSVmNDaC8zUDVWRUZjbU1GZldoc0VvMkVlM3hQd3ZS?=
 =?utf-8?B?RWpNTkNvVVZUdWdVRWo5S1hGKzZDK1NOVHVPRlhWcTRGLy8rS0dFOGk0Mlps?=
 =?utf-8?B?Z1ZPN084Z3dBYWZYYXRIYXdlUExzcEQxVlZCNUpCWThJcitSa0VERUt1WGVK?=
 =?utf-8?B?cnJ3eXRCc2lsc2NrcXI1ZEVDOTMxOEppc3k0K3BveHRGa1MzYXBFYlBKL200?=
 =?utf-8?B?c2pmb1NRaW9yN2NIems2dmh0RkhGVGRLVDlWQlpwVkZQS1dXemxnZ3FuQ3Fi?=
 =?utf-8?B?TjZkNTErMmRQVGZ5MmliWkhDRnRkMElZeEdhM3dySUxhNlpZaEFhTHFWRllR?=
 =?utf-8?B?bnFabkM3Y3hXeUtOODBSM3hrRTMweHNUencySU5tVm56SDFjcUdMamxiWGZR?=
 =?utf-8?B?YjQ0MmJBWFArMHdtS3Q0RFNQWnY4NXo0RW1xdUxqN21ZWXcrak9heU9QRERw?=
 =?utf-8?B?MmtsM3VqTm9IVjBnOW0zdzJEZEN3VWRrNDUxWXRtYWNzSzRMbTBwQ2NWVUYv?=
 =?utf-8?B?dzlaSEh0QkUycG1Md0JyZDdqeE9wOGowdE5qN24vcUZTNXQyZEVBb3R5Z2RW?=
 =?utf-8?B?OTI3RGlMM1JTdXJwVlY1MUVhNlBGTGxvNi9zcVc0c3RvU1MxMlZNT0ZyaHJL?=
 =?utf-8?B?b2wza2tsTXlTSjJwcHYvd2E3T01FOFF0cWptcWFPY0N3cmdUbHBLejV6akdL?=
 =?utf-8?B?akJMSzV3VDJiNDQrbGhzczFrdW5mMVM0d2YrbnpRVEpiN0RjNVRmVXBJaFM4?=
 =?utf-8?B?K2RUdUJuSTFRb0NYMC9pYlI5cXArQWttcW9WM0xMNzdpcW9MOWtXUkdWdExM?=
 =?utf-8?B?S3QxUmcxTGVMM1VkOE8rYW1YblpPcStrdGFyUjd6N3ZnRU90ek5ZUkxldm93?=
 =?utf-8?B?YmkrQ001dFYwZ1BGbFhtaHBKSlVteFFBSUF1SW5mM0tuTk5JeHBqUnppRXk2?=
 =?utf-8?Q?uMKfiqUOHzSX7TWOoJKr5GZrPoWxXEw+?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL1PR12MB5753.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RkEwZDhTSCtSUld6VHRTa1p2RUNsdkZhRytJdzcvMDF0UERiV2x4UjRxaVdw?=
 =?utf-8?B?WHNXVy9VeENSTSswSVdDRGN3bDlpUURkV2d3WVdXanZ2cWFxYmlHdUc3b24x?=
 =?utf-8?B?NHlnZkFMaFpjbUZueG9KYnNWaHpRdHNodzZiV0VRaEZlOHlQUVN2dTE3bG80?=
 =?utf-8?B?RXhDTTNIQ0IvTW41bnRpcEdLV2FvdGJZdU1XM2Fpb0cxWkFwT00wc21kUFV4?=
 =?utf-8?B?Y3EzbTdJUEh3RVI3TG9RTXJUSWhBSVJkUjZzTyttcGJ0Q3ZhVmNRWE1VTW1k?=
 =?utf-8?B?aXFhcTdhTk0yUWNVMU1aSjdGSWVJUmJXc0FlbVhqSEMyb3JFU1BDU2p1OXkr?=
 =?utf-8?B?cEIwNWp2Qm5YbTF3NGU5MTNxd1paVG5CUFp1NDFqeXRLRm1JaXRpYy94VXQ0?=
 =?utf-8?B?ZlAwOEU1TVJQa1F6aTVEOXJQREpXTDk5WnZ2bkdDTXBPbGZMcFlFa2VRQmpR?=
 =?utf-8?B?dURxWXJLSCtwN0k1U1p6V2ZrZWNyRk1Ycy85dXhIa0hwTXlic01XRlJFQVla?=
 =?utf-8?B?WUlnUEkyTzJpVkhLMThCN3F0UkttaERVd1RZQ3VxbVJrT3hOU0dyUXA2V0U3?=
 =?utf-8?B?Nys3b0c4WXgvdGhrRGNNSE5KcjBaazJFZEtweU9NNVFkV3cxdUI2RjFKWFBZ?=
 =?utf-8?B?MVR1QTJHc1R0YVBoTWhKd2x6M2QwS0UxQVYzdDdJV3huYVYvaU5UZUw3U09J?=
 =?utf-8?B?OTJHZnNQeHVvQ2pOR2h6TlEvMmtldktMNkdFTW1OZkFab0ZwMlF0NjBnekZh?=
 =?utf-8?B?SGxja2xVemd1cnVjSDFqL0NDZHBiSDN2WEdDQUlvdm5IMkRVZFpEbXB3UVNn?=
 =?utf-8?B?MjEzT29RTUJjQUNKeXdHdzZoUUROdFVXTXFCSDFock9OUjAyTE10eEJLQkxH?=
 =?utf-8?B?UXVueTYycWJadnV3WlpPWlBFaHJLRkxIY1dOYjBhdDVTTytCK1pCMnVPblpL?=
 =?utf-8?B?MXZSdjN0Zmt3N2djdlhaUTNtUjdiMGZvQXBnYks5ZGNtQ1dTRXpEOEFqNmNv?=
 =?utf-8?B?ZVYzcEc1Y2NzcUFDTEVyY1p0elJJUTB6NlpwQzVLb2ZsNXdXUG9HQURSOU9L?=
 =?utf-8?B?RUxib3FmODllQkNERWpHRUNGaXFOeHJRRmJQYjNHUHBxNHFFUEN4QXdBUGZ6?=
 =?utf-8?B?Rzg5TFZHSjFHeVpuektSZlU2ODQ4TjFuSlhkNUFTNTBSS2FKNFdxMzRHbVZa?=
 =?utf-8?B?UkM2TFlrZXplckN0Mk8wYzl0T3RVeWpBdHlmZUJkSFFyaTBORWg1eFBiVnd1?=
 =?utf-8?B?NlBsQ09FMm81LzZHUXh2ZVBPYTRTb3I0emhNY3RhNFdoL2d0ZU1zRWhmVmJY?=
 =?utf-8?B?RGViRGVaMmJjK3BWcGRDTmpEbXBKMVZaWGY1VDNDa0JJNTNoMGdFdGhKRHRx?=
 =?utf-8?B?Q1JMZzF5clJOczBrTDNIMUJKdEpDUzl0S2kvWElQUHNqcm02L2lZSXVPUzJ2?=
 =?utf-8?B?NktHMXZnK0VQWk95WXB6RDRrQU1NMFR1N2dNTnNueGRmVDNmdnhPMllGTVkw?=
 =?utf-8?B?bTRHM002KzhoR0I4RmgvN0djT1pxUGxlcU1VZWlCWG9XcnBDVUZGOWdDMFFj?=
 =?utf-8?B?UENicndRbjlLWlNvWTBlTDZJOWN0T1B6cWd4VERoRW9JMUxxbFlSZVYreFlo?=
 =?utf-8?B?aDBpVk9uQzJiL1RDbWZ4bk9mbVRyNHZCVTQxSGhjRkpzcTZtL2lWTGxieHUr?=
 =?utf-8?B?eHMzS2hlMVhVNHhLVDRaejltS2ZtSHNtWklkb3RrYlVobHZPNFhEL0JNODhD?=
 =?utf-8?B?T3NxcFREa2hwQm9vQitXQ1dkcmR0RHl2VVhTSWZ5ZG8wTjBmU0NlbWhnSmhB?=
 =?utf-8?B?SmhSUGkzVXlHNnlnei9UN1FYMWk1cmJGdnloTnhkcEV1MUt0VjU2OEVZUkg4?=
 =?utf-8?B?TDloWXp5d1B6eStqRkJ1bm5RVFpkS0ZrS1pXZnRaK3prU2c3NngyRDRabVls?=
 =?utf-8?B?bUZLUGhKYk1RVUdOWkZYT3kxMkFNSWdKZlBrZytyKzFZTVVpVnYzK0kzamVa?=
 =?utf-8?B?VlRSc0dWbnErclgrK2RGT3pUc2N1ZHErTVhNR0hJeW56L21KZGc2cFUrcldS?=
 =?utf-8?B?MVdZaUQyNE8wZUVTb0V6RmxlQXhSdDkvRDZCY1VwZEl2UVlPUGQvSWhJYWFT?=
 =?utf-8?Q?k/eHLQ2dk/blrXJoEvuIxfYj6?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f5168365-41af-48c4-dc95-08de131e1691
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5753.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Oct 2025 16:55:08.7427 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jKhe1hAav/1d3m/4yKv8K2if04ndH7uPp8vd8CoMRROljhfSsgN/QomnhJuEoFomWvpTlQVPD//DssrVh/iOPw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB9212
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


On 24-10-2025 08:41 pm, Philip Yang wrote:
>
> On 2025-10-24 07:45, Khatri, Sunil wrote:
>> +shirish
>>
>> On 24-10-2025 04:46 pm, Sunil Khatri wrote:
>>> amdgpu_hmm_range_alloc could fails in case of low
>>> memory condition and hence we should have a check
>>> for the return value.
>>>
>>> Signed-off-by: Sunil Khatri <sunil.khatri@amd.com>
>>> ---
>>>   drivers/gpu/drm/amd/amdkfd/kfd_svm.c | 5 +++++
>>>   1 file changed, 5 insertions(+)
>>>
>>> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c 
>>> b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
>>> index f041643308ca..7f0ab73e2396 100644
>>> --- a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
>>> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
>>> @@ -1738,6 +1738,11 @@ static int svm_range_validate_and_map(struct 
>>> mm_struct *mm,
>>>                 WRITE_ONCE(p->svms.faulting_task, current);
>>>               range = amdgpu_hmm_range_alloc(NULL);
>>> +            if (unlikely(!range)) {
>>> +                r = -ENOMEM;
>>> +                goto free_ctx;
>
> Can not goto end from here,  this skips the svm_range_unreserve_bos. 
> Just set r = -ENOMEM, and the loop will exit and cleanup accordingly.

That patch has already been merged now and i have to send another patch 
for review. While at it, cannot just set ENOMEM and leave as it will 
crash in next step where it access range which is NULL.

This is what i am thinking
range = amdgpu_hmm_range_alloc(NULL);
if (unlikely(!range)) {
                 r = -ENOMEM;
                 svm_range_unreserve_bos(ctx);
                 goto free_ctx;
}

If that is fine i will send a new patch for this ?

Regards
Sunil Khatri

>
> Regards,
>
> Philip
>
>>> +            }
>>> +
>>>               r = amdgpu_hmm_range_get_pages(&prange->notifier, 
>>> addr, npages,
>>>                                  readonly, owner,
>>>                                  range);
