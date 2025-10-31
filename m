Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 690BDCCF9FE
	for <amd-gfx@archiver.kernel.org>; Fri, 31 Oct 2025 12:58:23 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0ADB810E072;
	Fri, 31 Oct 2025 12:58:23 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="zg8fVcZ7";
	dkim-atps=neutral
Received: from PH7PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11010063.outbound.protection.outlook.com [52.101.201.63])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 49E8F10E072
 for <amd-gfx@lists.freedesktop.org>; Fri, 31 Oct 2025 12:58:22 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MAvQnx5JDMKmiczDpu2m/GzMdBrGRhtuf9oRN6FwsfaTYHAx1CK/ntk3alt5EOw6oCC8JDmhEXVXJyxEdUvQYcXmFg5IQdNfOwvsMFAn4ZCcowi96ePwOMAPePpYKkFdb3whgkzn8fzx57HmUs1vQ9QHICSLd8gTc3tg/nl6dBkis5Jy3fgKIZfrYFd1m2J8J/JWKMHaPr5qy8ejh1TROBQ75NYPnnNjAarpmLSf8zjnRGbYqDiAesJ8HKb5BVUo4FpfohtBHupqjE/dfjJSbd9mNidp1zr0rKcRyfGQueaR5iQA0owCsSrCziP3E1TNHp8jaVCdRBHKFWLPYL72/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=N4Ez2koZzMgCynErKt/SxVntaIVnKH1a1AYLxbC9Wf4=;
 b=GwKUNFCArkpcIi5KCNrjZ1nr8v1ixI/slivA5qD6BMabsKtZWgcsCGkYRMelHV3+SReYiRnpC1g7MNhsS9rsH2PK/rkSvU7CtR2SFqLEv1HJRShsMxDkA6TSNhHJK0JIkZQZQtZj341wSioeuC60AO3d67CwRrcR4rI7oNp7XhGVmmBHoo622V2dOfWLYggFCplnzjPc/tA/gs6IrQQZvEAcuHTizTtjcCa8GgSWdrNtFphO8TiOMHpfwwMRnoGch7wf1QrdrSckTPIWi3W5110L0lDqrVvb0iM/fxZ8MhgLpztgdlPEY8j0ebZjJ4+RMtlJnlZLP/X3N4Gasklr6Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=N4Ez2koZzMgCynErKt/SxVntaIVnKH1a1AYLxbC9Wf4=;
 b=zg8fVcZ73EaBm0usaqPuGL8pKMDHhKIxfpnrc5RbWwo/8OeZTSD6AGUN1PFILjyCA3k18pJPNB2lUvh/81h0LxFaCeW/BoeJk+9H+bIYG+DlYmBUfDE2VQ6z+xPQITyh48J1qwMCbqsTv/xx22ntp1Tx2MziTx4aFoh5J2ngY8s=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
 by DS7PR12MB6286.namprd12.prod.outlook.com (2603:10b6:8:95::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9275.14; Fri, 31 Oct
 2025 12:58:17 +0000
Received: from MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::37ee:a763:6d04:81ca]) by MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::37ee:a763:6d04:81ca%7]) with mapi id 15.20.9275.013; Fri, 31 Oct 2025
 12:58:16 +0000
Message-ID: <00764a25-cde9-4ba0-a950-5b546de51807@amd.com>
Date: Fri, 31 Oct 2025 07:58:15 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] drm/amdgpu/smu: Handle S0ix for vangogh
To: Antheas Kapenekakis <lkml@antheas.dev>,
 Alex Deucher <alexander.deucher@amd.com>
Cc: amd-gfx@lists.freedesktop.org, bob.beckett@collabora.com
References: <20251024170811.57760-1-alexander.deucher@amd.com>
 <20251024170811.57760-2-alexander.deucher@amd.com>
 <CAGwozwH0A83OEDJ04Oq7UDQRszXejfhTioTau3Q4LB39yRqJpg@mail.gmail.com>
Content-Language: en-US
From: Mario Limonciello <mario.limonciello@amd.com>
In-Reply-To: <CAGwozwH0A83OEDJ04Oq7UDQRszXejfhTioTau3Q4LB39yRqJpg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SA1P222CA0155.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:806:3c3::25) To MN0PR12MB6101.namprd12.prod.outlook.com
 (2603:10b6:208:3cb::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR12MB6101:EE_|DS7PR12MB6286:EE_
X-MS-Office365-Filtering-Correlation-Id: da6236e1-bfbc-4fb8-7355-08de187d28ab
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?alRXVjIzU251NnYvY1lUSXZqbmtWQnRibGJhSjZ2eVNJT3hTWDVJaXZaVklt?=
 =?utf-8?B?WkVKeFUrSVRXV28yY0hGajVqZ0dnWUE3OVc4eUxkb0dLbFZ5YUc2ck01STBL?=
 =?utf-8?B?S2JtOHFobWVHSEc2REhtUVRGRlZoZWUwbW1aNmd0ZGRKNkdVYmRYWWtMTWtw?=
 =?utf-8?B?emMwdzVlUlVWVHpTajFZaWtVK0NaQ1Q4U1FoK2RJcnUwTzNFcXdJSmREQS9r?=
 =?utf-8?B?bFQ4MXowT0pTWk5ucHNkQnlRVzEvQUJETW5Ca3pqT0NTVXdudTNFc25UUkln?=
 =?utf-8?B?MnZPUHpWVThrbVlEbW9pbm00bmxDYzdOVXdOSEc0NFl4bnQzbnJ0NkhZUnJW?=
 =?utf-8?B?NjFnUVQvMTJGeVd3Q04vZUt2QS9GZVhEV0c4MWlyNU9MMkx1ZlVZbElBOVU4?=
 =?utf-8?B?VncxYXFtUldIbTJNakthSzV5NW9nUjZFSmxBYmR0TTdHNTBLZmFwenFtUnlP?=
 =?utf-8?B?NGhEOGtoMjQ4UUttTzFXS085WGxRbS9ZRUcyb3FpVzRBQUk3L1JaOXo1WWww?=
 =?utf-8?B?VE5ac0Z3bytPbXJacndkVjhIY3EzZXdpVUZzWkN6K2xRSU5HTExGNHRwR3kx?=
 =?utf-8?B?bjRIT1VEbnBEYWlaRUZ3a0xaTzNuVTYzaHN1dXBHNkpyWE1OQUptVTZTSFdB?=
 =?utf-8?B?YlpOTFNpSDJrS1gvSnova21scTdaLzVscndFTHFXVGR1Mmh2NlRHaDgwK1Jz?=
 =?utf-8?B?Z09WOXU4d01TbFZjOEZwY2lsckxxNW9CemF3eXFXM29IdW0zc25mdjd0ODZo?=
 =?utf-8?B?K0VqK0dWWVA1VGxZZGVYWVFPdUptRW5WcTZrMnVPTk9VVi9oV0hQeU1ORzJJ?=
 =?utf-8?B?ei9RVm5RQVJHK3lBb2k3TEhRa0lCQXFZRW1YQ2tOblZSTmR5VWpOTWdDUUZT?=
 =?utf-8?B?bEg5anBHQVllS3djOWdtWTFNcEkyK1VKQlBUZ2M5aXl3MjJFY29OYkdldXE5?=
 =?utf-8?B?T3JaVGJkemRGdHFwTHlUMlRHeWpOd0xBR1UxODNmYVEzN1oyRVBtb3l3U1VB?=
 =?utf-8?B?SWxFejBzWWdwQndmNXpmTzNWRWdhN2NFU1hoN0tZMWZBdWl2ZEEvRmNNSWx0?=
 =?utf-8?B?NXdKV2FCaVNsaytIM01HTGtVOGMzQXFhU0l1bUEwQlhxSFIvaXRSUnVlN0x2?=
 =?utf-8?B?Vy8xQjQrcWpVdmd2cmNyUk5OUTZIRFNqaVlGb250T1JkdGtyeGFzcWoxNkZW?=
 =?utf-8?B?ZHl2RVBDMU4ySkhOemhTbDBVbm9FVzBOdEl3VVVLUElIaHdmM3psUFQxUlFs?=
 =?utf-8?B?Qm4yRS9VVXFmbjRJT0N4aDEzaytJbHBQeUNFUDlvbDJQaFZwN3dIejlEd0Fw?=
 =?utf-8?B?MkFEaElzNXJOVjVDcU9reXluWXd0L1V2aWNkNWZpdFpYWWMyM3ZVRlY1VlBV?=
 =?utf-8?B?Uk9ZRWdWL0tNcmpyTzdSY20wL0RQQnJZTURZTVFqU2twU0tKRE1pc0h5dVZH?=
 =?utf-8?B?d3NJZHhSVDMrNUtBTlIrOWFmNnl5T2RNdnN2YXZEL1JRUVRQRzBHb0x1dGhJ?=
 =?utf-8?B?aUdFcmNHZTlsSGNDbnhHVTVVSGhRWnF3dTNFQkIvSlJlSERCYy9CbDdjTmdX?=
 =?utf-8?B?RkNzUHdqMS9wS203ZTN4QVp1TG52NVEvWURkZTBiR1VaRzRWNkFsdHNEdnVz?=
 =?utf-8?B?QlE4VjYvRmlRMXZCbnFkSTJJR2Y5Q1lza21CU29wN0ducVFiN3VjMHlnQUR4?=
 =?utf-8?B?ZlRaNlNPUUFNbkJ6b2JKeWUxZjhJR1VmRTFlZyt0YzJTRkczbERkRVN3dyty?=
 =?utf-8?B?bG1PTlFXcit2YmNTd1RaM29WRnFzbnBBUFRrNUZBUWZyZkptdDRKM3kvR1Rw?=
 =?utf-8?B?RU1mWE1VNERKNGtaU0lwMnhQRWZhTWYzb3psUi9KejhFM3BCa0wvcVRtaW00?=
 =?utf-8?B?KzBXaExuSmxYb2g5bGZQZ0c3MmxEdlVKdmhFOTdFTUVmZGc9PQ==?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN0PR12MB6101.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(7053199007); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?V2krRFIxNXpQbmdScyt2S3ZCQ3JxZUlsOWM0TVdyU2UweVRDL1lJRi96VDRH?=
 =?utf-8?B?eVJKeDFkc0Z3MVFkL2tRRXFpaFlHMkdOL0g5RzBwTUw2VDdtVncxSkF5Smxh?=
 =?utf-8?B?dVIyMFVlRWUxaU5vN0loMnV2SDR4bkNwM0dzbmZGaUIzL0h0UlUxYnJONEpr?=
 =?utf-8?B?MGdxUm9GeitYSFZuUEQ2Y05ISjlsZnBZeVJWdXUyS0NmdUR6WDVPdmp2UDNx?=
 =?utf-8?B?QlE5VnByNklIWTY3SWNuOENBTW5ZWWdjdVV0WmlGZ3dwYkZmdVBsalFHZ2hT?=
 =?utf-8?B?R2lzU1N6OWI1azlsNEdpYjc0NFFlNHhrT2VNK3c3RklQdmNiYUpVeGRIQnpt?=
 =?utf-8?B?SDVIYXFacDNXQWlZaU5BWjdpdmNkekZGd1lqTk4rWWxSMFJrK01BMHUwVEFv?=
 =?utf-8?B?UU9qNWFzVk5YY1d3cmlkNU84Vm1iS3pHSWpFOUEzcHpEQ3BTOVd5SFB5RGhT?=
 =?utf-8?B?eEkzSmJxeVhsaEdxODRPYjBTeUNEeGlxYlEzZjRMRDFKT01LeElFUm8xOTJj?=
 =?utf-8?B?aU5JUXdIcHVTNlQ5bS9zUjdSeDY0M2hBTloyY1dYak5nc2czWlJ3RGdLN1kw?=
 =?utf-8?B?VjBiOG02SzFIaE03L0ovNytUOXdxd3U1alE2MUo5UjFXeUwrM0FrMDFzNXFv?=
 =?utf-8?B?dndFNlBlRUZKVGhPbzZnUFBMZVR0Zklva01BMkdYRGcyaStQcWIyTVdlVmVY?=
 =?utf-8?B?ZnNNVUFVZXhhbXQ2TjFqSDlCU2FwL0xBR0oxV2dsMEtyZmdHaG9QMWJMNHgy?=
 =?utf-8?B?Vm53NkhMY1ZWTVNhRHhpQmYybmxrQzJyNE40MHBsUC95ODJpUnUydUdxQ3gx?=
 =?utf-8?B?bmNBdU90dGUxM1NHb0o2Qk5lWGwyQzlkM0loNTFtMFNaU1grR1gxN0FuYllh?=
 =?utf-8?B?RkltMHlkWCtBUFpWbnc4N2hMeDhPRGpjK3lSZkRnM0hjdncyZkFLWlJabURG?=
 =?utf-8?B?cUUyWkEzUTltNGlNd0V4TWFJbmo2TS9OdUNQU1FWNFVHTG9KK21MMGp5L2o1?=
 =?utf-8?B?eEhFTUhrMG1STENaanFXVzZLUWUxdFhKMTVGNGlOMGpEdXFra25keUdWbHNv?=
 =?utf-8?B?Z1lQT3lXUE5EVlo5WTN6NUVISEFkN2FRRkQvb29idWhJSzVQcnJKdllsWFpP?=
 =?utf-8?B?Y01HSFBSTjZEZU1Iemhyb2RtelV1VXdMZFN2K2tKVU5WejRBaEIvUTdCcmdL?=
 =?utf-8?B?eG53WGtKbjcrMjh2R1ArZnpmR3laYWlkTHBBN2lzMVY4T25MbFdsTzEvaVc3?=
 =?utf-8?B?dEdjYkswZHRaY1pTQnVUUEdGYVRVY2ZqcG4wYTNwaG9qT3lpZ3hXOUJVTm96?=
 =?utf-8?B?VUlNclAvZGFTeFIxWGVUdDlMbEpkZEpHZk9XbTlpdGw3WWl3QWdoeWxZNWdL?=
 =?utf-8?B?WUtkQVRZUGw3QnVKZnNsdjdHNXBrTlVNd2dhRGgrRXhsdVBrN1RUYzZUdmpS?=
 =?utf-8?B?bXFCaHVQQWJ0YXZpU3p6Q0FYVGJGaDZYaERLTmwvQVhZUnFiY0lJMDVNWHBE?=
 =?utf-8?B?clNtTlFSbklXT3RhYXh0QlB6QjZzUUNXZ0hFV1Z4L041UmRrV0xXb29MZ0hs?=
 =?utf-8?B?U0VobjRZVGN5K28wQzRqNU02WkpNZXlWbURPbTBHRWpLdlZBSVduU0lsR3p5?=
 =?utf-8?B?TWRKRkNjZXo3dk51VUw3RVZkbnlxeEg3dHdPbUcrWUtRNUJNZXhTYnFEQnV0?=
 =?utf-8?B?M0hwSTVFRWxsTG10aGZnajlrS0t0Mk9DSkpkLzBNZG4xSzd4a0hOMUhpL2Jt?=
 =?utf-8?B?dVZNay8zWHBvSG56WE1PUzBIa0RtaFEvbjMxVlBCVkdUWUNNQUNwS1FxUmJl?=
 =?utf-8?B?UjJFeDlOdzloL2pwZFcxQlF5S1JqdVFDL0dVM3dQRk81bUZCeTRHZGg1ZDU5?=
 =?utf-8?B?NUxCYy9Vck1keEo0aXZ4K251cWFSL0o4YjJuaWJIVjYyVHlXOXlNd2tlM2p5?=
 =?utf-8?B?bjJhOG42M0lNV1dQS2ZOZEZ4MGRYVUZCTjkxM1pTbmR6Y1lOQ1VCQnBIMnI5?=
 =?utf-8?B?RTB2VklXMCtmOE1YSHRvVnpDcGVtbjlFY0VHNXdQRGh4ZTlPVTJVeE1QR096?=
 =?utf-8?B?RW12Q0pKZTBvYlJ5WGtwV0dlN0hGTnNQRmZ6REM3OU5TZXRLL0kwb2hpV29M?=
 =?utf-8?Q?5zthq545jb5rI6VGNcL3ntvOL?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: da6236e1-bfbc-4fb8-7355-08de187d28ab
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Oct 2025 12:58:16.7757 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: n9LlCpIbCZAQnVw7Q9Fc71+OwaLstEHB0tXHAOWr9OGJOaoJ7VkkHsEmcdw1RjMto1hyYJ1OkAjWCQK0pUs7dA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB6286
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



On 10/31/2025 6:58 AM, Antheas Kapenekakis wrote:
> Just for this patch:
> 
> Reported-by: Antheas Kapenekakis <lkml@antheas.dev>
> Tested-by: Antheas Kapenekakis <lkml@antheas.dev>
> 
> Tested on a Steam Deck OLED and Xbox Ally.

Thanks.  I'll get this applied to amd-staging-drm-next.

> 
> On Fri, 24 Oct 2025 at 19:08, Alex Deucher <alexander.deucher@amd.com> wrote:
>>
>> Fix the flows for S0ix.  There is no need to stop
>> rlc or reintialize PMFW in S0ix.
>>
>> Closes: https://gitlab.freedesktop.org/drm/amd/-/issues/4659
>> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
>> ---
>>   drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c        | 6 ++++++
>>   drivers/gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c | 3 +++
>>   2 files changed, 9 insertions(+)
>>
>> diff --git a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
>> index 10d42267085b0..5bee02f0ba867 100644
>> --- a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
>> +++ b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
>> @@ -2054,6 +2054,12 @@ static int smu_disable_dpms(struct smu_context *smu)
>>              smu->is_apu && (amdgpu_in_reset(adev) || adev->in_s0ix))
>>                  return 0;
>>
>> +       /* vangogh s0ix */
>> +       if ((amdgpu_ip_version(adev, MP1_HWIP, 0) == IP_VERSION(11, 5, 0) ||
>> +            amdgpu_ip_version(adev, MP1_HWIP, 0) == IP_VERSION(11, 5, 2)) &&
>> +           adev->in_s0ix)
>> +               return 0;
>> +
>>          /*
>>           * For gpu reset, runpm and hibernation through BACO,
>>           * BACO feature has to be kept enabled.
>> diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c
>> index 53579208cffb4..9626da2dba584 100644
>> --- a/drivers/gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c
>> +++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c
>> @@ -2219,6 +2219,9 @@ static int vangogh_post_smu_init(struct smu_context *smu)
>>          uint32_t total_cu = adev->gfx.config.max_cu_per_sh *
>>                  adev->gfx.config.max_sh_per_se * adev->gfx.config.max_shader_engines;
>>
>> +       if (adev->in_s0ix)
>> +               return 0;
>> +
>>          /* allow message will be sent after enable message on Vangogh*/
>>          if (smu_cmn_feature_is_enabled(smu, SMU_FEATURE_DPM_GFXCLK_BIT) &&
>>                          (adev->pg_flags & AMD_PG_SUPPORT_GFX_PG)) {
>> --
>> 2.51.0
>>
>>
> 

