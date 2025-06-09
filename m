Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 454D4C5B552
	for <amd-gfx@archiver.kernel.org>; Mon,  9 Jun 2025 12:43:43 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E1AC410E1A4;
	Mon,  9 Jun 2025 12:43:42 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="3nkxPIkO";
	dkim-atps=neutral
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2050.outbound.protection.outlook.com [40.107.220.50])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EDC6510E1A4
 for <amd-gfx@lists.freedesktop.org>; Mon,  9 Jun 2025 12:43:40 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kIPvi6OPWBii7Je7gxYSKI80l46AB5WUsRaz6oUAUd4gzsrRiXgmJfVM46cZ+dcYvEO394+QMD/F410D4YCHsWCZ/LR8cOGINRIs+x/80SM8MOJBiQh6qUPuyD0oMs3mbbRxSCobsLEEh/emR4JIWOAc3E4l1tGdSRsN6pF9HNCS1WdXYgDZduK55k1Kg01CQe2UAFXgTaWekvSoibnxw1Vqv578iKAlWYS/+5jnHh5HSrJxxZqm4MdsS1k5Mb2jJj6JmDZThdeJVShmdFDetNiAOmcpwfpbXmm7Z06phhBuSslPxyP9fzAvCZ0/R4L7svPSwpptDscSI1k8y/kirg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yuhl2v21EZL1yoo6C7LlqRQzpQvPjBigYA0AMZljtGE=;
 b=X+VG8DJBQOOZBS720cZA9lG7XuKxxM8qx6tbAIUtF6/8GD04N/Zhq0u/dfZ9s9HdeRLW+hl1+o0pWhL6VDM9pS+P79/fUTzKmTtjlwvZisq/3KxVG3WD6hbFbMtT2Z+26CThLWJZvo0Yn5FyGQ1dnqQrMBz+vZuh7Pqvk1NvkKj5vXcam0EpYG4kAHaT4JrTj9cufCES+haiIGT8+D5BGWdahCKdHFoosJxFAiHSxO/q8xgHOPmhMYm7xT2NjIQxr5P4hDu+rRUn8N3EU/Jnp2EQvIJoPXyT4MGj+9raGVcYZVPGQqGKV8bSktmkecNRfkIbE3o9S5CoyXbsaKdVhg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yuhl2v21EZL1yoo6C7LlqRQzpQvPjBigYA0AMZljtGE=;
 b=3nkxPIkOAejT06Qx396KWDgP1ImFCJZerMnmDcBtyaBkgR6bJ4VRVUh3jbn1YdfH2J04YLbnxcIxxf/Qvd2HJy4/nq7RSkejMmG0jIY/DDb5YnbzD3HWk0TOHsFKyYWJHFX68wFYnXv+MXtuDWFNNr+WqRu+NPx4TSHnt670hyA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN0PR12MB6293.namprd12.prod.outlook.com (2603:10b6:208:3c2::22)
 by IA1PR12MB7640.namprd12.prod.outlook.com (2603:10b6:208:424::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8792.33; Mon, 9 Jun
 2025 12:43:38 +0000
Received: from MN0PR12MB6293.namprd12.prod.outlook.com
 ([fe80::49ac:e84e:ea32:d743]) by MN0PR12MB6293.namprd12.prod.outlook.com
 ([fe80::49ac:e84e:ea32:d743%7]) with mapi id 15.20.8792.040; Mon, 9 Jun 2025
 12:43:38 +0000
Message-ID: <d7144d43-adf5-4f2f-b524-b918273ae85e@amd.com>
Date: Mon, 9 Jun 2025 18:13:33 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 06/29] drm/amdgpu: update ring reset function signature
To: Alex Deucher <alexdeucher@gmail.com>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
Cc: Alex Deucher <alexander.deucher@amd.com>, amd-gfx@lists.freedesktop.org
References: <20250606064354.5858-1-alexander.deucher@amd.com>
 <20250606064354.5858-7-alexander.deucher@amd.com>
 <62a1601e-990a-498e-a64b-d96bfa5567e6@amd.com>
 <CADnq5_NVyLr6O71si=svVJr-Ev6TOGtLs4W32T6fayQPDyfr8Q@mail.gmail.com>
Content-Language: en-US
From: "Sundararaju, Sathishkumar" <sasundar@amd.com>
In-Reply-To: <CADnq5_NVyLr6O71si=svVJr-Ev6TOGtLs4W32T6fayQPDyfr8Q@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PN4PR01CA0092.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:2af::6) To MN0PR12MB6293.namprd12.prod.outlook.com
 (2603:10b6:208:3c2::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR12MB6293:EE_|IA1PR12MB7640:EE_
X-MS-Office365-Filtering-Correlation-Id: c52e01ad-db53-4ffc-cd87-08dda753417d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?alZxbWhiajgyYS9IWHNIT1RicHU1aUJ1bytDTUcwQmVTVm14ZDZyYTVGbGZn?=
 =?utf-8?B?MWwxZjZUc2xrQUtzNVVsbVNQTmU4R2dYUElObU95RS8yQk1XRE1ubHUvWFNs?=
 =?utf-8?B?WFRkU0RQV00raDRUK3RDL1J3T1VTZHdiWW5ucHhsc3NSVjYrWnpuZzhId1FJ?=
 =?utf-8?B?VVBCY2F3VmFYUnFtOGk0WFZuK2txbXhZTmhZaDNLbFZjWVVlRzA0c0c0Umx2?=
 =?utf-8?B?bmpYKzhqK284WHVDUTM3SXNwWEVHSk04dEtGZTFkVGJuSWJzRitYaVdMN0ZG?=
 =?utf-8?B?SVJGN3graW9rMzliRHFHYUZhejlPWEF2c0NlUUd2SjVWMFh2R05aYTVHNlho?=
 =?utf-8?B?RWtSRVQ5T3dVRXV3Rm9Xem5EU0lmcXBNaWpUSTVGOVMwU1BxVmI4MUJTRFhk?=
 =?utf-8?B?ZkY2RjlsS3VvMVhoQ0oxRTN1SmplUGhGUjdmVHVmQ1dhMys2enUzNzVLMUw3?=
 =?utf-8?B?Ym9yMnE1SXlvSWU5NExPWjFhVWhaVVU2K0NQUUxoR29vSFpuV2kzS1k0K1FH?=
 =?utf-8?B?ZTJpY1ZIREFNZ0VXcE9oRXhqVWNmSkZMeVdsM29ySlo0UEhCTjk4RUZOS2ZS?=
 =?utf-8?B?Qm45Q1lCRFhIamh5WnhXRDhxQXFDanowcjVuYVQ0SkdiR1lXd3dZWmVVcEJa?=
 =?utf-8?B?b1NWYitUR0FrcDY3TjZ3bFRWcmNZVDZ4L3BGSzVJMTQxRVVySmNEb1hjNkxN?=
 =?utf-8?B?UG9GVnJzM25SK0ZWMU5FMGE4QWhyNVJEdGFiVCtkcHFpVlc5TEJzYUxTVDlk?=
 =?utf-8?B?T1Q5czdKK1dGUEFIU0ZCZTBqWmovYnRtb3VQUjUrRi94UVBENzFIbTFpUmJW?=
 =?utf-8?B?M0c4clZFSVQ2SDh6Q09XTVNMS0ZhQmp0RkpCeUJHV2VlKzdqMEhJTFdDMmxU?=
 =?utf-8?B?WjJIMjJZcmJDdEJoWnBuUFltMldoYWc3eldHZk5yZGpvNjJTaWpTekVaZTcy?=
 =?utf-8?B?OXNTWW9YNDVNMUdkVk5QVWNWZkVrWTFlcmFqTTVmVTdQVDYwMkt0ZnpkbTg2?=
 =?utf-8?B?ZFdCV1EyVUlZZzN3aTRlaHdZN29ncTQ1UDd2ZnVUSmNpZzUvNTdyQUJTYjF5?=
 =?utf-8?B?elZ4ZWk0T0Z2K21JQys1aHMyVENqMi9CeVg2NUFzZkNKWHB3eTRVYWkxSzJW?=
 =?utf-8?B?SFAwTXFYaGFhNWR6L1VvQ0ZTYnlSQ0w4M0RwKy9CenhtOWpwZG5MbWFqWHZJ?=
 =?utf-8?B?YUZpZEsrWjBlRDFOM2gyc0VKelVmMlZoUmNyN2kwUjBNQStycHpnKzBET0Vs?=
 =?utf-8?B?RGhIMG1lVE1xUWRFKzExVGQ4ZmNMYkVKTndZbjhSUVlLMWdHOHUyK3hNYTM0?=
 =?utf-8?B?N2JMV1JlUTdacCt3dEJyZ2toRFNwNmJ2R1ZPT3A5aXVnRWNpTEE3WW9sM0NS?=
 =?utf-8?B?T213WTJrYWJaMzNNOFZmdGswR1RvYmJhUEhWajlra1ovbGQvcUxoQXVHN0RE?=
 =?utf-8?B?Y09jcUFyaWNIV0FlaHdOZVB3NE5qRWxDVys0MVQ5bXlvWGhVTjV0RHdselYx?=
 =?utf-8?B?eGhNQWgvQ2ptc0hidEd3VU9HeDl3NmJxSzFTTXJob21LZXhtazZZVzRXbW5t?=
 =?utf-8?B?R0pNeDZQVXJ6eHErTkNCWTdSTnovMXVWMzZMRUhwOVlyT2J6akVuREJ2eUVT?=
 =?utf-8?B?WWdHb2hYWUgyMDFMdDVnT0Zkd1V6MFVoTXFEQmd3WFFoNXZvN2w1cFRleWxR?=
 =?utf-8?B?R3JSS0pYZ0Jvcjcybm1WVXNJSlRxN1pUNkNOV3BJbjRmd1FqMUUxTTVQUnVY?=
 =?utf-8?B?MUI0R0J1cE1qMkg4WEJkN2hKNnB6R0VOZmhDUUdTSWZLb2tUa29aSWNPV3Vu?=
 =?utf-8?B?aTNHLzJ6Mm5JMjhCLytaNkE3ZTFGNTBXdHk2cUU4SjhYVTZKK21SMG9udXpn?=
 =?utf-8?B?QUlSZnIyVW9lTUlKb3hsTkVFcldhQmo0dWhabWVQM0cyNlE9PQ==?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN0PR12MB6293.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TTY4MU8wMkRMa3hrVzR1YXNHc3VwdmlPRkQwMCs4bjJIbkxKTms4ZUNyWFVU?=
 =?utf-8?B?MVVlUjF6L3JFeHZvLzNmMGVWUmFRZENVaDE5NDY0K1VTQVBSUFFoZzZjbExU?=
 =?utf-8?B?elM1czJPMUplM05FL1hBU2h1QWlBbDN1OU90a3ZjV3F5OERZMnVVTW05OUNu?=
 =?utf-8?B?cm5JTmR0VTVWKzlxYmlXaU5US1VZR3ZJYW1POHBRZmNhb20ydWw4dkVMTWJo?=
 =?utf-8?B?Z3FNMlZZdERhSHdWZDdZOXFIVGp2bnZSK25XZEFaNVp5ajBvVUFlQTBLTkth?=
 =?utf-8?B?N0JXSjVaVE5aUGhrUVU5ZktnYVhnTWVuQlNyUXdiUUNJOVRGOGtLSC9NeXps?=
 =?utf-8?B?d0V6aDNUQkF3VEdIMllEM21kb3prQWFvWTQ1OXk5Y3MwS2JIaWdIN2ZwTlhE?=
 =?utf-8?B?WVg0azlmZStsUlRlMWZpcnhWcFhwVlY2RFd4ZkFpcDV5bjRJZGR1Wm1lTVdu?=
 =?utf-8?B?aEZYV2FVT1pwTGZZclpOcTBoWW1GVkJXN0REK2dCN1B4aDRFZ1lpaVRDcE0w?=
 =?utf-8?B?SnA1eXphNWF5WmlWcGc1Yjk4RElyRFhRWXlxcUtlMldsY3pveVNPVmNGK2VI?=
 =?utf-8?B?enYwbTZmczNIUVBkZ00vd0FiKzdwcW5BTFd2V29LeEhHRnhlRkxCY3NXYmdI?=
 =?utf-8?B?djBOOExCSXp4Tkd4VHp4Z1J0UUxzdG5GMXVMd3JHUzdaVGUyd0ZzZWpWQ3Ro?=
 =?utf-8?B?cXA0QTJyZGRkdkZxVUM1bzJzcmFhRzVLaW1WM20raitjemlqTnZ4c0ZhVnBo?=
 =?utf-8?B?bDZoejlPWUd6WGVXNEI0aXBybzUydFc1V0NaWGtpS1lIZGVNdjZ0VTVTVEhK?=
 =?utf-8?B?STU2NVVnZHBxSTE3WFQwdW9kdy9SQzFUMm1HZ3JHMGw1SW0wZklwblZRQW5w?=
 =?utf-8?B?RUV1QTBtR0VmUHVVU05OOEQ4TlF3MU1pb3F4U1VtdldpTWRVcXA3ZldwNWZR?=
 =?utf-8?B?Y1ljdTRDZjlhdDBySDFOZXVKdXcvY3hEWGNnTjNpSmFoWklSd0ZJMGEzUnk5?=
 =?utf-8?B?NFBCS0EzcmFhb3g3NmllejFvUFlteWwxSjRhYUVPNVBXMnNjamNaRlRkd0Y5?=
 =?utf-8?B?S0pzZkZWQS96SlM4YXlzVzA4N0tPellMc1JZcWRJNDYxM2pQTkJvVDNhZEJD?=
 =?utf-8?B?R3Fmcm5tcHEzT2wxMERxQkR5YzlnN1VlSjJpOWJCa1FnWGFPRTRlV1huSEdL?=
 =?utf-8?B?THJneVRBNDhQeW92MXpjenlqVHhHaDdETDhLTzdwSk0zdnhOazhXbnd2dGww?=
 =?utf-8?B?cWVmQXh0OVBweEk3ZStGSnV2YVluRzBZZk1FWk1aSkRUQUd1WW45Y29Jd0c1?=
 =?utf-8?B?NmxXMXhOTXYwY3JRZzZBRURuZWk0bWxnM0x3ZktkMTdybXVaNDhGSDcyVk5n?=
 =?utf-8?B?bmNkRFk0VFlEN1VyZ1pCdHhCN2hnTEdpVS9rMlpqTE9JeC9Kc1lhMlJRd2dm?=
 =?utf-8?B?WE5YWW9HL0JSSHc2NDNkVkxRaGI2SUJJWUNIV3FsV1VqVzAwY3hQNFRab28y?=
 =?utf-8?B?N2hUS1pRK3RwOEdWSTFtdmFtTnZGODdzQnB0cnV4M0YxSjczK1dNVlBMY3J3?=
 =?utf-8?B?dy9FZkNqanN1ZWE4Z2NISDVvanNVcTNTdEd0WVVYSFVvUTM4N2JiREJLeEZQ?=
 =?utf-8?B?b1B1TVQ3alQzeXBnMyt0NWNXSVh5TUh4Z0QvTEYwRDQ2Z2pLN3dKNWlaS005?=
 =?utf-8?B?L2UvM292RCt4cHhscWRJaVVRRkQ0RnJpcG1TenUwakxNcDdOK2ZDL0JyY28v?=
 =?utf-8?B?L1VoZjNqRHFDOXFsdkQ0djZZVXpGdXVsaTJYQXZIRHowTW9KdjhaVHNaTzRK?=
 =?utf-8?B?ODUyMWhjWlBMd3NLNFJ1R0FCUERySytQT2xBenBnek9Jcm1LbmxzQW5KMVFr?=
 =?utf-8?B?Umx0WTErUGFhVm81ZTlxWjJkNFY0WWNIc0EwUXhpYjI3dGVnMDlWU3pUSXlo?=
 =?utf-8?B?WkkvUkZueENyNi8rL08yMU9NbWxveEVjUU9JUU9hYTMwWHVKbVNYV0tqWXB3?=
 =?utf-8?B?S2tCVlNuWnEveUhOdFVDaUlkLzgrbnlDMWpYdXd0Sm8vQzk4VTB5Qm15cXpy?=
 =?utf-8?B?Y2swOGlrbUUxOTNrOE1pVS81b1VVNVhVeVZXMHJVUHBkak5OUjR2MCtiMGFQ?=
 =?utf-8?Q?44IGzOfyVKFnGLkpTsIVWdMEP?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c52e01ad-db53-4ffc-cd87-08dda753417d
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6293.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jun 2025 12:43:38.2795 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZX/5a8MR8lBk7B+jhwfLBLrQh4yLx739v9yb0Uflo7IR3tCneRRgQ7c3CJ7n59Dn0uVp6a3orjpPr+2WO9HhYQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB7640
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



On 6/6/2025 9:30 PM, Alex Deucher wrote:
> On Fri, Jun 6, 2025 at 7:41 AM Christian König <christian.koenig@amd.com> wrote:
>> On 6/6/25 08:43, Alex Deucher wrote:
>>> Going forward, we'll need more than just the vmid.  Everything
>>> we need in currently in the amdgpu job structure, so just
>>> pass that in.
>> Please don't the job is just a container for the submission, it should not be part of any reset handling.
>>
>> What information is actually needed here?
> We need job->vmid, job->base.s_fence->finished, job->hw_fence.
There's more/full ip specific reset control possible with job passed to 
reset callback and fence/guilty handling moved here.
Wondering, if I can also try to enable reset on vcn non unified queues, 
this patch series has relevant examples and makes it
possible to handle it all in the reset callback itself, can try it atop 
these changes.

Regards,
Sathish
>
> Alex
>
>> Regards,
>> Christian.
>>
>>
>>> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
>>> ---
>>>   drivers/gpu/drm/amd/amdgpu/amdgpu_job.c  |  2 +-
>>>   drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h |  4 ++--
>>>   drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c   |  7 ++++---
>>>   drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c   | 10 ++++++----
>>>   drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c   | 10 ++++++----
>>>   drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c    |  2 +-
>>>   drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c  |  2 +-
>>>   drivers/gpu/drm/amd/amdgpu/jpeg_v2_0.c   |  3 ++-
>>>   drivers/gpu/drm/amd/amdgpu/jpeg_v2_5.c   |  3 ++-
>>>   drivers/gpu/drm/amd/amdgpu/jpeg_v3_0.c   |  3 ++-
>>>   drivers/gpu/drm/amd/amdgpu/jpeg_v4_0.c   |  3 ++-
>>>   drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_3.c |  3 ++-
>>>   drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_1.c |  3 ++-
>>>   drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c |  3 ++-
>>>   drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c   |  3 ++-
>>>   drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c   |  3 ++-
>>>   drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c   |  5 +++--
>>>   drivers/gpu/drm/amd/amdgpu/sdma_v7_0.c   |  5 +++--
>>>   drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c    |  3 ++-
>>>   drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c  |  3 ++-
>>>   drivers/gpu/drm/amd/amdgpu/vcn_v4_0_5.c  |  3 ++-
>>>   drivers/gpu/drm/amd/amdgpu/vcn_v5_0_0.c  |  3 ++-
>>>   22 files changed, 53 insertions(+), 33 deletions(-)
>>>
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c
>>> index ddb9d3269357c..80d4dfebde24f 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c
>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c
>>> @@ -155,7 +155,7 @@ static enum drm_gpu_sched_stat amdgpu_job_timedout(struct drm_sched_job *s_job)
>>>                if (is_guilty)
>>>                        dma_fence_set_error(&s_job->s_fence->finished, -ETIME);
>>>
>>> -             r = amdgpu_ring_reset(ring, job->vmid);
>>> +             r = amdgpu_ring_reset(ring, job);
>>>                if (!r) {
>>>                        if (amdgpu_ring_sched_ready(ring))
>>>                                drm_sched_stop(&ring->sched, s_job);
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
>>> index e1f25218943a4..ab5402d7ce9c8 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
>>> @@ -268,7 +268,7 @@ struct amdgpu_ring_funcs {
>>>        void (*patch_cntl)(struct amdgpu_ring *ring, unsigned offset);
>>>        void (*patch_ce)(struct amdgpu_ring *ring, unsigned offset);
>>>        void (*patch_de)(struct amdgpu_ring *ring, unsigned offset);
>>> -     int (*reset)(struct amdgpu_ring *ring, unsigned int vmid);
>>> +     int (*reset)(struct amdgpu_ring *ring, struct amdgpu_job *job);
>>>        void (*emit_cleaner_shader)(struct amdgpu_ring *ring);
>>>        bool (*is_guilty)(struct amdgpu_ring *ring);
>>>   };
>>> @@ -425,7 +425,7 @@ struct amdgpu_ring {
>>>   #define amdgpu_ring_patch_cntl(r, o) ((r)->funcs->patch_cntl((r), (o)))
>>>   #define amdgpu_ring_patch_ce(r, o) ((r)->funcs->patch_ce((r), (o)))
>>>   #define amdgpu_ring_patch_de(r, o) ((r)->funcs->patch_de((r), (o)))
>>> -#define amdgpu_ring_reset(r, v) (r)->funcs->reset((r), (v))
>>> +#define amdgpu_ring_reset(r, j) (r)->funcs->reset((r), (j))
>>>
>>>   unsigned int amdgpu_ring_max_ibs(enum amdgpu_ring_type type);
>>>   int amdgpu_ring_alloc(struct amdgpu_ring *ring, unsigned ndw);
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
>>> index 75ea071744eb5..c58e7040c732a 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
>>> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
>>> @@ -9522,7 +9522,8 @@ static void gfx_v10_ring_insert_nop(struct amdgpu_ring *ring, uint32_t num_nop)
>>>        amdgpu_ring_insert_nop(ring, num_nop - 1);
>>>   }
>>>
>>> -static int gfx_v10_0_reset_kgq(struct amdgpu_ring *ring, unsigned int vmid)
>>> +static int gfx_v10_0_reset_kgq(struct amdgpu_ring *ring,
>>> +                            struct amdgpu_job *job)
>>>   {
>>>        struct amdgpu_device *adev = ring->adev;
>>>        struct amdgpu_kiq *kiq = &adev->gfx.kiq[0];
>>> @@ -9547,7 +9548,7 @@ static int gfx_v10_0_reset_kgq(struct amdgpu_ring *ring, unsigned int vmid)
>>>
>>>        addr = amdgpu_bo_gpu_offset(ring->mqd_obj) +
>>>                offsetof(struct v10_gfx_mqd, cp_gfx_hqd_active);
>>> -     tmp = REG_SET_FIELD(0, CP_VMID_RESET, RESET_REQUEST, 1 << vmid);
>>> +     tmp = REG_SET_FIELD(0, CP_VMID_RESET, RESET_REQUEST, 1 << job->vmid);
>>>        if (ring->pipe == 0)
>>>                tmp = REG_SET_FIELD(tmp, CP_VMID_RESET, PIPE0_QUEUES, 1 << ring->queue);
>>>        else
>>> @@ -9579,7 +9580,7 @@ static int gfx_v10_0_reset_kgq(struct amdgpu_ring *ring, unsigned int vmid)
>>>   }
>>>
>>>   static int gfx_v10_0_reset_kcq(struct amdgpu_ring *ring,
>>> -                            unsigned int vmid)
>>> +                            struct amdgpu_job *job)
>>>   {
>>>        struct amdgpu_device *adev = ring->adev;
>>>        struct amdgpu_kiq *kiq = &adev->gfx.kiq[0];
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
>>> index afd6d59164bfa..0ee7bdd509741 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
>>> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
>>> @@ -6806,7 +6806,8 @@ static int gfx_v11_reset_gfx_pipe(struct amdgpu_ring *ring)
>>>        return 0;
>>>   }
>>>
>>> -static int gfx_v11_0_reset_kgq(struct amdgpu_ring *ring, unsigned int vmid)
>>> +static int gfx_v11_0_reset_kgq(struct amdgpu_ring *ring,
>>> +                            struct amdgpu_job *job)
>>>   {
>>>        struct amdgpu_device *adev = ring->adev;
>>>        int r;
>>> @@ -6814,7 +6815,7 @@ static int gfx_v11_0_reset_kgq(struct amdgpu_ring *ring, unsigned int vmid)
>>>        if (amdgpu_sriov_vf(adev))
>>>                return -EINVAL;
>>>
>>> -     r = amdgpu_mes_reset_legacy_queue(ring->adev, ring, vmid, false);
>>> +     r = amdgpu_mes_reset_legacy_queue(ring->adev, ring, job->vmid, false);
>>>        if (r) {
>>>
>>>                dev_warn(adev->dev, "reset via MES failed and try pipe reset %d\n", r);
>>> @@ -6968,7 +6969,8 @@ static int gfx_v11_0_reset_compute_pipe(struct amdgpu_ring *ring)
>>>        return 0;
>>>   }
>>>
>>> -static int gfx_v11_0_reset_kcq(struct amdgpu_ring *ring, unsigned int vmid)
>>> +static int gfx_v11_0_reset_kcq(struct amdgpu_ring *ring,
>>> +                            struct amdgpu_job *job)
>>>   {
>>>        struct amdgpu_device *adev = ring->adev;
>>>        int r = 0;
>>> @@ -6976,7 +6978,7 @@ static int gfx_v11_0_reset_kcq(struct amdgpu_ring *ring, unsigned int vmid)
>>>        if (amdgpu_sriov_vf(adev))
>>>                return -EINVAL;
>>>
>>> -     r = amdgpu_mes_reset_legacy_queue(ring->adev, ring, vmid, true);
>>> +     r = amdgpu_mes_reset_legacy_queue(ring->adev, ring, job->vmid, true);
>>>        if (r) {
>>>                dev_warn(adev->dev, "fail(%d) to reset kcq and try pipe reset\n", r);
>>>                r = gfx_v11_0_reset_compute_pipe(ring);
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
>>> index 1234c8d64e20d..a26417d53411b 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
>>> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
>>> @@ -5307,7 +5307,8 @@ static int gfx_v12_reset_gfx_pipe(struct amdgpu_ring *ring)
>>>        return 0;
>>>   }
>>>
>>> -static int gfx_v12_0_reset_kgq(struct amdgpu_ring *ring, unsigned int vmid)
>>> +static int gfx_v12_0_reset_kgq(struct amdgpu_ring *ring,
>>> +                            struct amdgpu_job *job)
>>>   {
>>>        struct amdgpu_device *adev = ring->adev;
>>>        int r;
>>> @@ -5315,7 +5316,7 @@ static int gfx_v12_0_reset_kgq(struct amdgpu_ring *ring, unsigned int vmid)
>>>        if (amdgpu_sriov_vf(adev))
>>>                return -EINVAL;
>>>
>>> -     r = amdgpu_mes_reset_legacy_queue(ring->adev, ring, vmid, false);
>>> +     r = amdgpu_mes_reset_legacy_queue(ring->adev, ring, job->vmid, false);
>>>        if (r) {
>>>                dev_warn(adev->dev, "reset via MES failed and try pipe reset %d\n", r);
>>>                r = gfx_v12_reset_gfx_pipe(ring);
>>> @@ -5421,7 +5422,8 @@ static int gfx_v12_0_reset_compute_pipe(struct amdgpu_ring *ring)
>>>        return 0;
>>>   }
>>>
>>> -static int gfx_v12_0_reset_kcq(struct amdgpu_ring *ring, unsigned int vmid)
>>> +static int gfx_v12_0_reset_kcq(struct amdgpu_ring *ring,
>>> +                            struct amdgpu_job *job)
>>>   {
>>>        struct amdgpu_device *adev = ring->adev;
>>>        int r;
>>> @@ -5429,7 +5431,7 @@ static int gfx_v12_0_reset_kcq(struct amdgpu_ring *ring, unsigned int vmid)
>>>        if (amdgpu_sriov_vf(adev))
>>>                return -EINVAL;
>>>
>>> -     r = amdgpu_mes_reset_legacy_queue(ring->adev, ring, vmid, true);
>>> +     r = amdgpu_mes_reset_legacy_queue(ring->adev, ring, job->vmid, true);
>>>        if (r) {
>>>                dev_warn(adev->dev, "fail(%d) to reset kcq  and try pipe reset\n", r);
>>>                r = gfx_v12_0_reset_compute_pipe(ring);
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
>>> index d50e125fd3e0d..5e650cc5fcb26 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
>>> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
>>> @@ -7153,7 +7153,7 @@ static void gfx_v9_ring_insert_nop(struct amdgpu_ring *ring, uint32_t num_nop)
>>>   }
>>>
>>>   static int gfx_v9_0_reset_kcq(struct amdgpu_ring *ring,
>>> -                           unsigned int vmid)
>>> +                           struct amdgpu_job *job)
>>>   {
>>>        struct amdgpu_device *adev = ring->adev;
>>>        struct amdgpu_kiq *kiq = &adev->gfx.kiq[0];
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c b/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
>>> index c233edf605694..a7dadff3dca31 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
>>> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
>>> @@ -3552,7 +3552,7 @@ static int gfx_v9_4_3_reset_hw_pipe(struct amdgpu_ring *ring)
>>>   }
>>>
>>>   static int gfx_v9_4_3_reset_kcq(struct amdgpu_ring *ring,
>>> -                             unsigned int vmid)
>>> +                             struct amdgpu_job *job)
>>>   {
>>>        struct amdgpu_device *adev = ring->adev;
>>>        struct amdgpu_kiq *kiq = &adev->gfx.kiq[ring->xcc_id];
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/jpeg_v2_0.c b/drivers/gpu/drm/amd/amdgpu/jpeg_v2_0.c
>>> index 4cde8a8bcc837..6cd3fbe00d6b9 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/jpeg_v2_0.c
>>> +++ b/drivers/gpu/drm/amd/amdgpu/jpeg_v2_0.c
>>> @@ -764,7 +764,8 @@ static int jpeg_v2_0_process_interrupt(struct amdgpu_device *adev,
>>>        return 0;
>>>   }
>>>
>>> -static int jpeg_v2_0_ring_reset(struct amdgpu_ring *ring, unsigned int vmid)
>>> +static int jpeg_v2_0_ring_reset(struct amdgpu_ring *ring,
>>> +                             struct amdgpu_job *job)
>>>   {
>>>        jpeg_v2_0_stop(ring->adev);
>>>        jpeg_v2_0_start(ring->adev);
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/jpeg_v2_5.c b/drivers/gpu/drm/amd/amdgpu/jpeg_v2_5.c
>>> index 8b39e114f3be1..8ed41868f6c32 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/jpeg_v2_5.c
>>> +++ b/drivers/gpu/drm/amd/amdgpu/jpeg_v2_5.c
>>> @@ -643,7 +643,8 @@ static int jpeg_v2_5_process_interrupt(struct amdgpu_device *adev,
>>>        return 0;
>>>   }
>>>
>>> -static int jpeg_v2_5_ring_reset(struct amdgpu_ring *ring, unsigned int vmid)
>>> +static int jpeg_v2_5_ring_reset(struct amdgpu_ring *ring,
>>> +                             struct amdgpu_job *job)
>>>   {
>>>        jpeg_v2_5_stop_inst(ring->adev, ring->me);
>>>        jpeg_v2_5_start_inst(ring->adev, ring->me);
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/jpeg_v3_0.c b/drivers/gpu/drm/amd/amdgpu/jpeg_v3_0.c
>>> index 2f8510c2986b9..3512fbb543301 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/jpeg_v3_0.c
>>> +++ b/drivers/gpu/drm/amd/amdgpu/jpeg_v3_0.c
>>> @@ -555,7 +555,8 @@ static int jpeg_v3_0_process_interrupt(struct amdgpu_device *adev,
>>>        return 0;
>>>   }
>>>
>>> -static int jpeg_v3_0_ring_reset(struct amdgpu_ring *ring, unsigned int vmid)
>>> +static int jpeg_v3_0_ring_reset(struct amdgpu_ring *ring,
>>> +                             struct amdgpu_job *job)
>>>   {
>>>        jpeg_v3_0_stop(ring->adev);
>>>        jpeg_v3_0_start(ring->adev);
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0.c b/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0.c
>>> index f17ec5414fd69..c8efeaf0a2a69 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0.c
>>> +++ b/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0.c
>>> @@ -720,7 +720,8 @@ static int jpeg_v4_0_process_interrupt(struct amdgpu_device *adev,
>>>        return 0;
>>>   }
>>>
>>> -static int jpeg_v4_0_ring_reset(struct amdgpu_ring *ring, unsigned int vmid)
>>> +static int jpeg_v4_0_ring_reset(struct amdgpu_ring *ring,
>>> +                             struct amdgpu_job *job)
>>>   {
>>>        if (amdgpu_sriov_vf(ring->adev))
>>>                return -EINVAL;
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_3.c b/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_3.c
>>> index 79e342d5ab28d..8b07c3651c579 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_3.c
>>> +++ b/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_3.c
>>> @@ -1143,7 +1143,8 @@ static void jpeg_v4_0_3_core_stall_reset(struct amdgpu_ring *ring)
>>>        WREG32_SOC15(JPEG, jpeg_inst, regJPEG_CORE_RST_CTRL, 0x00);
>>>   }
>>>
>>> -static int jpeg_v4_0_3_ring_reset(struct amdgpu_ring *ring, unsigned int vmid)
>>> +static int jpeg_v4_0_3_ring_reset(struct amdgpu_ring *ring,
>>> +                               struct amdgpu_job *job)
>>>   {
>>>        if (amdgpu_sriov_vf(ring->adev))
>>>                return -EOPNOTSUPP;
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_1.c b/drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_1.c
>>> index 3b6f65a256464..0a21a13e19360 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_1.c
>>> +++ b/drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_1.c
>>> @@ -834,7 +834,8 @@ static void jpeg_v5_0_1_core_stall_reset(struct amdgpu_ring *ring)
>>>        WREG32_SOC15(JPEG, jpeg_inst, regJPEG_CORE_RST_CTRL, 0x00);
>>>   }
>>>
>>> -static int jpeg_v5_0_1_ring_reset(struct amdgpu_ring *ring, unsigned int vmid)
>>> +static int jpeg_v5_0_1_ring_reset(struct amdgpu_ring *ring,
>>> +                               struct amdgpu_job *job)
>>>   {
>>>        if (amdgpu_sriov_vf(ring->adev))
>>>                return -EOPNOTSUPP;
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c b/drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c
>>> index 9c169112a5e7b..ffd67d51b335f 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c
>>> +++ b/drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c
>>> @@ -1667,7 +1667,8 @@ static bool sdma_v4_4_2_page_ring_is_guilty(struct amdgpu_ring *ring)
>>>        return sdma_v4_4_2_is_queue_selected(adev, instance_id, true);
>>>   }
>>>
>>> -static int sdma_v4_4_2_reset_queue(struct amdgpu_ring *ring, unsigned int vmid)
>>> +static int sdma_v4_4_2_reset_queue(struct amdgpu_ring *ring,
>>> +                                struct amdgpu_job *job)
>>>   {
>>>        struct amdgpu_device *adev = ring->adev;
>>>        u32 id = GET_INST(SDMA0, ring->me);
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c b/drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c
>>> index 9505ae96fbecc..46affee1c2da0 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c
>>> +++ b/drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c
>>> @@ -1538,7 +1538,8 @@ static int sdma_v5_0_soft_reset(struct amdgpu_ip_block *ip_block)
>>>        return 0;
>>>   }
>>>
>>> -static int sdma_v5_0_reset_queue(struct amdgpu_ring *ring, unsigned int vmid)
>>> +static int sdma_v5_0_reset_queue(struct amdgpu_ring *ring,
>>> +                              struct amdgpu_job *job)
>>>   {
>>>        struct amdgpu_device *adev = ring->adev;
>>>        u32 inst_id = ring->me;
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c b/drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c
>>> index a6e612b4a8928..581e75b7d01a8 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c
>>> +++ b/drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c
>>> @@ -1451,7 +1451,8 @@ static int sdma_v5_2_wait_for_idle(struct amdgpu_ip_block *ip_block)
>>>        return -ETIMEDOUT;
>>>   }
>>>
>>> -static int sdma_v5_2_reset_queue(struct amdgpu_ring *ring, unsigned int vmid)
>>> +static int sdma_v5_2_reset_queue(struct amdgpu_ring *ring,
>>> +                              struct amdgpu_job *job)
>>>   {
>>>        struct amdgpu_device *adev = ring->adev;
>>>        u32 inst_id = ring->me;
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c b/drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c
>>> index 5a70ae17be04e..d9866009edbfc 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c
>>> +++ b/drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c
>>> @@ -1537,7 +1537,8 @@ static int sdma_v6_0_ring_preempt_ib(struct amdgpu_ring *ring)
>>>        return r;
>>>   }
>>>
>>> -static int sdma_v6_0_reset_queue(struct amdgpu_ring *ring, unsigned int vmid)
>>> +static int sdma_v6_0_reset_queue(struct amdgpu_ring *ring,
>>> +                              struct amdgpu_job *job)
>>>   {
>>>        struct amdgpu_device *adev = ring->adev;
>>>        int i, r;
>>> @@ -1555,7 +1556,7 @@ static int sdma_v6_0_reset_queue(struct amdgpu_ring *ring, unsigned int vmid)
>>>                return -EINVAL;
>>>        }
>>>
>>> -     r = amdgpu_mes_reset_legacy_queue(adev, ring, vmid, true);
>>> +     r = amdgpu_mes_reset_legacy_queue(adev, ring, job->vmid, true);
>>>        if (r)
>>>                return r;
>>>
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v7_0.c b/drivers/gpu/drm/amd/amdgpu/sdma_v7_0.c
>>> index ad47d0bdf7775..c546e73642296 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/sdma_v7_0.c
>>> +++ b/drivers/gpu/drm/amd/amdgpu/sdma_v7_0.c
>>> @@ -802,7 +802,8 @@ static bool sdma_v7_0_check_soft_reset(struct amdgpu_ip_block *ip_block)
>>>        return false;
>>>   }
>>>
>>> -static int sdma_v7_0_reset_queue(struct amdgpu_ring *ring, unsigned int vmid)
>>> +static int sdma_v7_0_reset_queue(struct amdgpu_ring *ring,
>>> +                              struct amdgpu_job *job)
>>>   {
>>>        struct amdgpu_device *adev = ring->adev;
>>>        int i, r;
>>> @@ -820,7 +821,7 @@ static int sdma_v7_0_reset_queue(struct amdgpu_ring *ring, unsigned int vmid)
>>>                return -EINVAL;
>>>        }
>>>
>>> -     r = amdgpu_mes_reset_legacy_queue(adev, ring, vmid, true);
>>> +     r = amdgpu_mes_reset_legacy_queue(adev, ring, job->vmid, true);
>>>        if (r)
>>>                return r;
>>>
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c
>>> index b5071f77f78d2..47a0deceff433 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c
>>> +++ b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c
>>> @@ -1967,7 +1967,8 @@ static int vcn_v4_0_ring_patch_cs_in_place(struct amdgpu_cs_parser *p,
>>>        return 0;
>>>   }
>>>
>>> -static int vcn_v4_0_ring_reset(struct amdgpu_ring *ring, unsigned int vmid)
>>> +static int vcn_v4_0_ring_reset(struct amdgpu_ring *ring,
>>> +                            struct amdgpu_job *job)
>>>   {
>>>        struct amdgpu_device *adev = ring->adev;
>>>        struct amdgpu_vcn_inst *vinst = &adev->vcn.inst[ring->me];
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c
>>> index 5a33140f57235..d961a824d2098 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c
>>> +++ b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c
>>> @@ -1594,7 +1594,8 @@ static void vcn_v4_0_3_unified_ring_set_wptr(struct amdgpu_ring *ring)
>>>        }
>>>   }
>>>
>>> -static int vcn_v4_0_3_ring_reset(struct amdgpu_ring *ring, unsigned int vmid)
>>> +static int vcn_v4_0_3_ring_reset(struct amdgpu_ring *ring,
>>> +                              struct amdgpu_job *job)
>>>   {
>>>        int r = 0;
>>>        int vcn_inst;
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_5.c b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_5.c
>>> index 16ade84facc78..10bd714592278 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_5.c
>>> +++ b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_5.c
>>> @@ -1465,7 +1465,8 @@ static void vcn_v4_0_5_unified_ring_set_wptr(struct amdgpu_ring *ring)
>>>        }
>>>   }
>>>
>>> -static int vcn_v4_0_5_ring_reset(struct amdgpu_ring *ring, unsigned int vmid)
>>> +static int vcn_v4_0_5_ring_reset(struct amdgpu_ring *ring,
>>> +                              struct amdgpu_job *job)
>>>   {
>>>        struct amdgpu_device *adev = ring->adev;
>>>        struct amdgpu_vcn_inst *vinst = &adev->vcn.inst[ring->me];
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_0.c b/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_0.c
>>> index f8e3f0b882da5..7e6a7ead9a086 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_0.c
>>> +++ b/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_0.c
>>> @@ -1192,7 +1192,8 @@ static void vcn_v5_0_0_unified_ring_set_wptr(struct amdgpu_ring *ring)
>>>        }
>>>   }
>>>
>>> -static int vcn_v5_0_0_ring_reset(struct amdgpu_ring *ring, unsigned int vmid)
>>> +static int vcn_v5_0_0_ring_reset(struct amdgpu_ring *ring,
>>> +                              struct amdgpu_job *job)
>>>   {
>>>        struct amdgpu_device *adev = ring->adev;
>>>        struct amdgpu_vcn_inst *vinst = &adev->vcn.inst[ring->me];

