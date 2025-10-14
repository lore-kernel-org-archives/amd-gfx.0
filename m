Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 131C8CCD184
	for <amd-gfx@archiver.kernel.org>; Tue, 14 Oct 2025 19:15:45 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id ABD0A10E140;
	Tue, 14 Oct 2025 19:15:44 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="lgzPZcFn";
	dkim-atps=neutral
Received: from BYAPR05CU005.outbound.protection.outlook.com
 (mail-westusazon11010009.outbound.protection.outlook.com [52.101.85.9])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F2F9F10E140
 for <amd-gfx@lists.freedesktop.org>; Tue, 14 Oct 2025 19:15:42 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nGJzE/JT8L61O2IIkfJX0TYVE8fJHAgEPMVY1oLE34fXk9s8QPXf5lHvTJm/6+fpmhOApAhH3e7Nnhhfj9xA1f9x+Tv5E8jUVy7utSOd7EC7L8REQQYPQmLvdQQzspEFrAGXZ7bi9bGp9JukButsdnxrNGK6lYPUkwTrI9msupk15Cl9bfJbNwsOeDc+P759Jjytqa/k3FEVPf3l7OQHSOgykg0mOn2C7wu1J8ura0E1nnX/9YSOXhFapLdZSiZG6DGkO4OOJdnR4Y6Acsy4cxNt3srVP4GvfN50efZCsoZMfruydSc/3ZCLKLQFT6poh3xcmUkwk6goLLinIO9XvA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=r9gwQgXQ0ePIXvy8WbPfBm2F9ARsgXBAFGtpTfWvNfA=;
 b=hCiukohvC4NdygC5kg7nExXmUQM4motCSb/uhJ0mKGdOKols+h3WXa1V3bb2WhPlnSvoqBGAkK9B/vt9BVx2oSbDD2SquWrgSSNAc4XMSpMF9+N+E//kThJgHRhumvtMNaaYpIl2m8ph2kEK9vdqqjsEPjAtVm1X4F/RCRX63ZxresGXd4p5y2nmeVQzuh0ZgoqXEUs8xc9qmK2IJivxOiUYqxsOTWIDJBLJU4BAUACVavP5pTogyLyyTRtZWr+l2aR2SzHIOPNpDrp76/7fnspHNxIJR6B25fa9yMZCOAkRXicuDM8Dg4FvmN6HUjEJWUGkj5xLXEUZPEjudlELCw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=r9gwQgXQ0ePIXvy8WbPfBm2F9ARsgXBAFGtpTfWvNfA=;
 b=lgzPZcFnKY6qbhfGdzfHH97PzOnIvAd3BDHTmHiwwiZaOZG2e8CPDhm4fOgUIipcvrIJCQ7rtupEcseLri/wkd+q9v6n+Clo+lK7ALLbT6q5K90VHmz/pqg+ByChNJF10mS+j7vIOFC+yRN2a4neuS04bqpkqZyTa0BVa4oOplk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
 by CH2PR12MB9517.namprd12.prod.outlook.com (2603:10b6:610:27f::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9203.13; Tue, 14 Oct
 2025 19:15:39 +0000
Received: from MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::37ee:a763:6d04:81ca]) by MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::37ee:a763:6d04:81ca%7]) with mapi id 15.20.9228.009; Tue, 14 Oct 2025
 19:15:39 +0000
Message-ID: <4739ad38-123c-4d6b-b409-5e6329d711d7@amd.com>
Date: Tue, 14 Oct 2025 14:15:36 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] drm/amd/display: Check if display HW is enabled in
 amdgpu_dm_atomic_check()
To: Harry Wentland <harry.wentland@amd.com>, amd-gfx@lists.freedesktop.org
References: <20251009205508.175269-1-mario.limonciello@amd.com>
 <20251009205508.175269-2-mario.limonciello@amd.com>
 <3904b1ba-7be1-429d-af90-47e2bdf14762@amd.com>
Content-Language: en-US
From: Mario Limonciello <mario.limonciello@amd.com>
In-Reply-To: <3904b1ba-7be1-429d-af90-47e2bdf14762@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SA0PR11CA0113.namprd11.prod.outlook.com
 (2603:10b6:806:d1::28) To MN0PR12MB6101.namprd12.prod.outlook.com
 (2603:10b6:208:3cb::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR12MB6101:EE_|CH2PR12MB9517:EE_
X-MS-Office365-Filtering-Correlation-Id: 6386c369-5f46-40ec-cca5-08de0b560fde
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?U1dBRzRvN2I0bFQyQTlRUUpFV1ZqZkRxdk9ML25USVF1NjFPOEtmRlA3c2gv?=
 =?utf-8?B?OURwOUlZYnFCQllsdzQ1ZEoxRGEzSG0vS0lpVlh0anRRNGpLL1RXRjNkS1li?=
 =?utf-8?B?MWVkM2JzaG9HZHJSNm1LaG1CQVRqdUlVdzhyQjlDVU9MY3RjcHFEN21WR3Fo?=
 =?utf-8?B?dWRpdFRwMEZFclIxY21NSXdtUWxRUXJqeWVlclZtOGM0c0N2OHYybHR1OGUy?=
 =?utf-8?B?bmJnWjJlelNvVFdvcVJMWmlBaGV0M1FHSWUwOFBSMG5Ebmk2dVdkcjZrcHVw?=
 =?utf-8?B?ZitadTMzY254WnMxcDBOd1ErclAyanJSTjZSRVVoNXRjK2tQN1c5aVEvZVZm?=
 =?utf-8?B?aGpkU011NHpZZUlRQVhwdGtYWFJ1WUNFMHNCZjMvSUFPRXhxUHhiNEFPTTBG?=
 =?utf-8?B?WHQ5RXRhVURUK0tRZmhIQ3VvSWZqRDQvRXluaEFHMG5lTmhodTlGVzY1bTZs?=
 =?utf-8?B?MUNXbFk1YjRhRG51VThDSmg4Mit4aGt5ZWFyM2dvTks4TFIwQks1TFR5TWxk?=
 =?utf-8?B?amR4ZDFiakV2M2I5a25PN056RjRpOENEN1BJelFRM1Z5bXlhRUEyQnhBZ2tX?=
 =?utf-8?B?YVpzS1d0Q0tjeG5RVWRzU0RQUXBEUG1aWFZvdElEYzNFNDZVdC9lUm9GQVNp?=
 =?utf-8?B?T2sxaW54VXNraWZQM0RBYVVUd1UvN0FkaTMybXYwaEFhVE0rbEp5aHN1eWk0?=
 =?utf-8?B?N0lLSGZMbHdiTUpRU2FmbDlKcDQ0bEhpc2FCR0o4bkFhZ2hibzFxUitCcThZ?=
 =?utf-8?B?MU1GSDBQNlhsdjRkall1amlKMjVCTzVZSGFkYS9SR1lHTlJDcy9pSWtHNDAx?=
 =?utf-8?B?M3pkNzJaUUd4NElWYTEzN0JMRUFnU0hQZ1g4c3M5VGRnR0diZE4wVVNnb2xG?=
 =?utf-8?B?YXNFY3VPR1V1dngzam5nNlNFQ1EveUZteU0vaWNnSHpZbTFXcHkxN3hVNHhi?=
 =?utf-8?B?TmFYeDYrdnR2VnNjOTlvcGdEMDNDWDdVVHlxbFljc3BGY0pVb0FJNTR4bXh5?=
 =?utf-8?B?MjU2M09FdVZRSWk1UHJoT0E1MTJPSUR1NjBBUjN1SW5NQkNmS0ZrR2IyRTVX?=
 =?utf-8?B?OXZ1Z1NQUTdJWjNqZkRLYWFETGlYclBWa21MK2l4bnkxOEkrYkJ0OUN1Zi8y?=
 =?utf-8?B?Z1p1NWNwRlNjbXFrajVyQm55RzBvVHh3THJycUpBZTREbytSSWlZdUYzVVYy?=
 =?utf-8?B?aTFVd2FJSkhWaGJwLzVNMGYrM3ZLNFdVS3NLWFlJRlVVWWErZzRvUXNXeFcr?=
 =?utf-8?B?RWk2UjNoajVCbW1WVWI2MGhuRzlwSXV0MVQ1U2JHSERReHBNN3NNS0piTGYr?=
 =?utf-8?B?dHZ0R25OcWEvdmpPL0JPSzNsWFdyaDdWWTE4eUcrOHQ1Wnowa3o5aGM2WG9I?=
 =?utf-8?B?K1JuUDZLanBUd3BQRnVsdlJ1V21KV1phNkJNbE00VWtieVlGS3pncWpkUjNF?=
 =?utf-8?B?dUtyNGlPb3k3ak9saFUvTnRwaU52REdBWHJDVXRXeVRNeGpBb3dmUkNKeksr?=
 =?utf-8?B?eERDeFhuTzRRdGhmNUFrZkN1VlVKNklzVFpZUVptR2hFRlFVOUh4QlJxWjlH?=
 =?utf-8?B?QThsV0tzYUl5ek5TV3ZhaFBwN2tmOStBeEtIbndSeVBNL21LU1NvTFo0RUo0?=
 =?utf-8?B?WkFYbDNvVTBFWXFmNkYyaXB5TlVlcmdqTkVnYVpHNFVaazR1cWEyVjJEajE3?=
 =?utf-8?B?OCtheVgrMEhtMTJnMEliaW9JeEJMTDg1cE5wQTdwcldWbEpGS3pyVFFuZUw0?=
 =?utf-8?B?MzA5dENKTjh3QnlPOC9sWDJWME1pSGJoTDl3Uk1RSURLQVZHR1Q5UXVJZ212?=
 =?utf-8?B?aUlsejJMY29pbFFkMXF3OTM4ZjBBUmpGZjQ5UGtwS2IxOUF2dkd6Qzl6RElq?=
 =?utf-8?B?VmlmWkJ6NW9aZ29HWTU3NlV0WmlLMkk4Z3pVZEdtb1RqRVE9PQ==?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN0PR12MB6101.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dnJLbTVkVVhSalVQRlY3WFNTOXVOUXUzMlV1TmlUdGl1eVg2WUNXSk1lMHBE?=
 =?utf-8?B?dkFCamNsdVREU1piYVVSdzgxTThWQlFreU5uTUUxS2N4ZTA0TTh0ZHhUVWM1?=
 =?utf-8?B?THNxQUhEYktvQ2M5dHdxUUdMY2dsNnRaVXVPQUQ0ZzVuV2M4dmV2R0wyZGx4?=
 =?utf-8?B?amkwU0R5c3JTTTRoa0VXdWptRlVsQklPbStCV3BjUnpvVG5iQ3ArNEN5MmVG?=
 =?utf-8?B?bjRtdWNsaWpxQTVIemNsSUM4VHZBUlk1TFBXTEw4RXBLYlBQdndtZFNmWEw5?=
 =?utf-8?B?dnZVVlZUYW1UczlmN2t3V1NMM3N3Tzl4YTd1bWtxNFZGeXdhS1dwelNZWWkw?=
 =?utf-8?B?L0hhT3RYcUNXdXBtZ1JSZVN2KzM0Q3NZaWJkRmEzTHo4cWZKWDFocjBDbnlq?=
 =?utf-8?B?ZGcwYVhKOUtXZkhhNFJ5VG5mMVZWbG1tTW5nUnpDNU81Qkc3Q0Iyc09QdGtC?=
 =?utf-8?B?Wjl4R1JTb0VKRlBqa1BKNVpMN0JGUm1pWnlYQWxLMjZYMTZSRWMvSnZiMW84?=
 =?utf-8?B?RDM2MWdDM1lkcWJKdEdNMEdGbGV0ek1yMVhMLzFudU03bFpwNXREcnduUnNS?=
 =?utf-8?B?YVk3Z2ptbTBnb3FZUnZ6ckN0eFJWUmlDYW9KdnVwSHlkN1ptZDRlYjVabWJS?=
 =?utf-8?B?c1JheHlCL0ZJeExpZEhKaHpoNk5TRldMTDA0dGhxNGE5MFRUQk9BMkx1LzAx?=
 =?utf-8?B?NzNpYTFxOGFlOVJxeEV3RStSSkREY2dVU1ZBMzNYMHNROEs5ZXdSNkNoSGVK?=
 =?utf-8?B?QlZqSlR0aWRiTDBiYVFoMEtKaGxnSklwczRBLzZBU0dTUVBMampTZ01mMmxY?=
 =?utf-8?B?S0l5R3huT3FPQjNsQzVDa2trQU5TQnVtRTI5VS82d2g0YTg0NjcvcWpYdEQ4?=
 =?utf-8?B?VWpLZXpxSlpSbDdrQkFPQzNtdXU3NWJ3ZlhaRzluSTJnL2c5bWV2UXNIdHV2?=
 =?utf-8?B?OWliKzhxeEtoOGJsanJJWDAxcElZUDhhSEI5SDRXeExMTzZONmFCRUN3blF0?=
 =?utf-8?B?Ri84YnluUHZSdnFVNXpiV2greUpXQkpkMXJPcGZWRmYzNVI1SVlpUURvTUFR?=
 =?utf-8?B?T3RVZFpQeTJ2akEyWjRvdUVSYUtoUUwrWVRaOEtnMU9hS045bFNGQ21ueE1u?=
 =?utf-8?B?ZW8zUmxiWkpZOTlDZEJEU1htVTB4b1pseVRRT0RBOG9IRzJESTlVRmliRDVH?=
 =?utf-8?B?clV0dndnaHF0b2V5RFN3MlEvM0g1OUo5eGdTdHpEbFVuWEcrVHA4bkpiR1N3?=
 =?utf-8?B?L3FiSDZhYlBEckhocEZteXI3WE9HY1d2NFlVZ3FzSjl6OUtnZzl3cHNreHdB?=
 =?utf-8?B?VnZIeVFsZXgxVnFCK0VCWnFUS0FqK2RrcFJQbnJ1MUN4eEtFWDlLRkhqNzZz?=
 =?utf-8?B?OHJDTDVUeEkvVGhUUjBlb2FJNlNSVFFYNklwZlh1UkhXNzcxUGVBVUJCbHJT?=
 =?utf-8?B?TjhGZ3VKWC9kQVhWcTlWT3lBRTMxUWkwNUhRZ3UwSmcrbTY4clBCWUtEOSth?=
 =?utf-8?B?elZldDEycjJpbktpOWdISGVJZmtZcGdtN3I0WG83TlBiWnUxSWZpVlRBNHo4?=
 =?utf-8?B?NzJQbFcvbnltSHBpOU5SeERyODVsL3JlMXkzL09LTzBBOU9DY2lVOHZqSno3?=
 =?utf-8?B?Rklac0xPTXpxN1R6bUdIdmk1ajlPMjVpODFZNG4vWUQybDdtRGhpTkppalo2?=
 =?utf-8?B?NW95OXRHNlV3VzlHSlNBcFFWNExxS2paTDFNeU8rN1pjN014c2xJZTlSa0Vo?=
 =?utf-8?B?dS9JZHlCdnNtRXU1cEFkS2RreDNiSU50bkpSQ1FrZi9uV2R0bXI2M2RXSnlh?=
 =?utf-8?B?ekNJQTZicDlNV3BTcHhPdXNwdzlzT2EwcDhITEFlYll5bkUvbXZTUGRHWHhu?=
 =?utf-8?B?ckJwNHN1eWNDTEFKa2U3TUhZK3lOTFR6ZGxNTGdPZEluOE1GMTZYVHdkYzYw?=
 =?utf-8?B?VHlrZUVMM3BVZ1VWYnFPQjlHNHZCNEhmMEVuZ1A1b1pRdVRmSHdKa3VvKzd3?=
 =?utf-8?B?YkdhTXVPNnpSaXJkT1JWME5hSHRId0lQZUZrQS9lLzdKYnZBbGE3QkdKQVll?=
 =?utf-8?B?blN5SVYrL1gyN3R6Y3VCSjZzblRLK3RxNndwUml0eHpGUStxVlVFT0wrdEhB?=
 =?utf-8?Q?g/mWRrZo9LVve7xSTB/zguc/f?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6386c369-5f46-40ec-cca5-08de0b560fde
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Oct 2025 19:15:39.7447 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: i4dwLrLIEx8/fvMpIQEe/8Bz4dEKhKZviANNSfpIBJx/GmqCcSQ0+Ix8bToCtKUWiVPfPWFd70+LDwJ0fiAMgw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB9517
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



On 10/14/2025 1:20 PM, Harry Wentland wrote:
> On 2025-10-09 16:55, Mario Limonciello wrote:
>> [Why]
>> If userspace hasn't frozen user processes (like systemd does with
>> user.slice) then an aborted hibernate could give control back to
>> userspace before display hardware is resumed.  IoW an atomic commit could
>> be done while the hardware is in D3, which could hang a system.
>>
>> [How]
>> Add a check whether the IP block hardware is ready to the atomic check
>> handler and return a failure. Userspace shouldn't do an atomic commit if
>> the atomic check fails.
>>
>> Closes: https://gitlab.freedesktop.org/drm/amd/-/issues/4627
>> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
>> ---
>>   drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 5 +++++
>>   1 file changed, 5 insertions(+)
>>
>> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
>> index 6f5be090b744..5a189deac631 100644
>> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
>> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
>> @@ -12014,6 +12014,11 @@ static int amdgpu_dm_atomic_check(struct drm_device *dev,
>>   
>>   	trace_amdgpu_dm_atomic_check_begin(state);
>>   
>> +	if (WARN_ON(unlikely(!amdgpu_device_ip_is_hw(adev, AMD_IP_BLOCK_TYPE_DCE)))) {
>> +		ret = -ENXIO;
> 
> ENXIO means no such device or address. Wouldn't that
> potentially confuse userspace when they debug issues
> where we return ENXIO? My understanding is that this is
> a transient error, so maybe an -EBUSY might be better?
> 
> Harry
> 

Thanks, that makes a lot of sense.  I'll update and resend.

>> +		goto fail;
>> +	}
>> +
>>   	ret = drm_atomic_helper_check_modeset(dev, state);
>>   	if (ret) {
>>   		drm_dbg_atomic(dev, "drm_atomic_helper_check_modeset() failed\n");
> 

