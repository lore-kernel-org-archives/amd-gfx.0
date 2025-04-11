Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A6CCEC36010
	for <amd-gfx@archiver.kernel.org>; Fri, 11 Apr 2025 16:30:21 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 368D410EC23;
	Fri, 11 Apr 2025 16:30:21 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="wQBLopcn";
	dkim-atps=neutral
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2081.outbound.protection.outlook.com [40.107.93.81])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 28FDE10EC28
 for <amd-gfx@lists.freedesktop.org>; Fri, 11 Apr 2025 16:30:20 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WiXbd2mTPXqtWxwnMUJoZ+Qqm+ANbo7k5Ly4Qr23LxBe7J9JdrLwjaRplhK64ANFf8U9App3HAySuVf/Cm/sIZQNtYvErwtyaox484b6iNHRjZPI8wpzwsMh7rh8OT2CKpwXjZXz6+jo8DUcJJxFcnAQcioPfGgWobVdzrwTgcENRVoA/+ZGBEMpaVRj+BPeJ6zID2z6yNXzKoTELyjEARLDxyYCUF3Z0hwTgSMLC5GUKR1JTle9pwj44/A3Fe0YPG6ROQqTQmuh9CTG2/b2JOxnvjiQPWegVnfUmDPFrd5KLShOijXXuCU5aCIyMJHBC1Wvh9mMWJJzz31XQYon+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5rkee/UhbyRFajR/c2IKIH6fysq4oy0GXvz5r4iUexY=;
 b=jeNjRshcTo075wsRA2A8pfZIxGZT59zGjqrZzpeQ9832ac/PCd49KhlHyYGvgilFIBYdN/3YrtFWTynDvetHWvKeE1Ll90CGOcHvXmH2pW2txhuoxjT630Lmg4vScZPFYxYSS6Fqic/Yw7p4AcWOxB0YUBvhrAh2kYR0jQMt7qGsEQr9vu2pAbJRJrtEWyQvZyHpO6Ckp2L9RTO/O8cZohwSZBLjKun1OGoMhAZbCFwUdpCWD6Zz5BYtHW1S8IESTnK4dQOL0DBkIue6CExQ9X1PGLWoEQtJWPypKZ1s7c1zARuvtnZXB8SZnIisDLIyBUCxnxKth1yJRJcFQY0wFg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5rkee/UhbyRFajR/c2IKIH6fysq4oy0GXvz5r4iUexY=;
 b=wQBLopcnZzKdCiVF6eVdscCmhOqtoV8usqE6nYf5aUAbK+7Gph0P2Os1v4kUxRMzBotq0UHulLWxFFbeVs3K0Wh7ShTXuTxcTpsP0aMjKM141XsOyMKs+NpVQtTLxLEDEpKUJHaCOuYXc08RWQk0p5errjSzo49FGQMQ0eln+Mg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BL1PR12MB5753.namprd12.prod.outlook.com (2603:10b6:208:390::15)
 by DM4PR12MB6110.namprd12.prod.outlook.com (2603:10b6:8:ad::7) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8632.27; Fri, 11 Apr 2025 16:30:17 +0000
Received: from BL1PR12MB5753.namprd12.prod.outlook.com
 ([fe80::2b0e:7fc3:1d21:5d2e]) by BL1PR12MB5753.namprd12.prod.outlook.com
 ([fe80::2b0e:7fc3:1d21:5d2e%3]) with mapi id 15.20.8632.021; Fri, 11 Apr 2025
 16:30:16 +0000
Message-ID: <83f7155a-7ca2-4feb-a6ca-b59be96fe644@amd.com>
Date: Fri, 11 Apr 2025 22:00:13 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 9/9] drm/amdgpu/userq: integrate with enforce isolation
To: Alex Deucher <alexander.deucher@amd.com>, amd-gfx@lists.freedesktop.org
References: <20250410181138.2287932-1-alexander.deucher@amd.com>
 <20250410181138.2287932-9-alexander.deucher@amd.com>
Content-Language: en-US
From: "Khatri, Sunil" <sukhatri@amd.com>
In-Reply-To: <20250410181138.2287932-9-alexander.deucher@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN3PR01CA0054.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:98::20) To BL1PR12MB5753.namprd12.prod.outlook.com
 (2603:10b6:208:390::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL1PR12MB5753:EE_|DM4PR12MB6110:EE_
X-MS-Office365-Filtering-Correlation-Id: feb7c033-a8f1-4db5-42bf-08dd79162436
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?WGQwMmFqaGlYVUJmRm05Wm9JRkFLZHk1V05VYUQ0bzBQNEtWbTJ1c3RHSWxL?=
 =?utf-8?B?NFdzN1Q5WWdpaHV5WjVyUHduVFNsT0NnOU5FMUVRL3o1UjlkL3oxNldpa1cz?=
 =?utf-8?B?dENCRSs4cnNoRm9PNk9oQndXWlBKYkUwanArTXVkRWlzRHhnME5UR1gydmc4?=
 =?utf-8?B?b2FZMmdqQWU1UmVTaFlHNXhZT0pYVlFaMFViRnkrMzBDZC9pSUZGTjRzb2ZC?=
 =?utf-8?B?a2lMc1lpMDBkWDVxSUFLK21ibVpENEs0VlM4MWF5cWJuYjBVaUVQa2M3YTBI?=
 =?utf-8?B?ZlBZbXdsa3BweThQZGpoL2VwV2VFc0p5OU9INVpQVmtZNWJXOVp2MVNIN2Fh?=
 =?utf-8?B?UmJHNThhTWlQaWk4dnZyZXFZbUFZUkVyZ1ZQVExTMjZBNE9OLzRmcWhuRUU1?=
 =?utf-8?B?OWxwUDljWVZDdW9qd29aWTBUWktKa1FMdnVtb0txRk1hdU9EMWJMQTdDQmtU?=
 =?utf-8?B?Y2EwUG5YZ2F2R2w0SUlSeFJVUmtoWlFDdzNUZURYUHkyUlRlblhPdHNBOHR6?=
 =?utf-8?B?VHpyNzhGcHhoVCt1VmEycWh2dGp0eEMzWmhlaTcySm11OVFYOFVBNnFTOEVU?=
 =?utf-8?B?dytrYWNWSndtYjV1V2tGR044aitlQ1lCZEo0NWpLRUlwSVEyWFE5MFU5MVFN?=
 =?utf-8?B?aWlzUUhLdXpqN1BFdFRFdk5GbGs0cXp2QXpqRGY0ZkcvZmIzbkN3OTFaL3Ez?=
 =?utf-8?B?RlVRNldjYlpUeEJIWW5RTUZreWNVZlVVc04rYWxzRTJGTGwvR0V1K3gvalFH?=
 =?utf-8?B?ejRpZnNZV1RnSGxlOEdwRUVNcmxkVVlZQ0Z5UTVIbVA1TElBYVVkYkdxRE1w?=
 =?utf-8?B?NllGdm1GTzNEQUVyYWh5aEpMdjNpbDdzOUFURHZtL1hmTW1pT3QrMisrdDh4?=
 =?utf-8?B?eDF3WlNDdVlibUJSbkNsbWI4aGhXdy8yVitUcFZzdXp5YVNvQUpKNkVBdTlD?=
 =?utf-8?B?cURiTzIrbnZnR3YzOFl4TDlySXh4bDg2MEpza1BhVitvOC9jWGhvRU5ZeVRN?=
 =?utf-8?B?RXJ3S1dDWHA3Q1k0aU1KN09SUXZLYVBadFZRbVRyVC9TbGw5c2RmY1BBMlEz?=
 =?utf-8?B?bVIxQjcxMkpiN3RIYVd1d1hPVlFqWW15eUxsWmw5RjcrMFhtcGV6V0s2NFow?=
 =?utf-8?B?MFNTZnRzbVVrYjBpTkJ5K3BNSW4zM0ZyZXBaTGplbmZiaVJoZjdJQUdsTU5s?=
 =?utf-8?B?a0NUTnJyOEtrU1lsaWVNZm5SbGF6QUUrd09MRjBPdk1IY29aSloxMGgzU1FI?=
 =?utf-8?B?dUxMUHAvMWtZSnhucEtVUjlwc1VGM0tGa0RMMmF4T0dyMURYazNDanN1dkZt?=
 =?utf-8?B?STZwZTdiTWROdm1CM2d2M2xibFVKVzM0dGZXQXRiaCtkM3J4RW1DcUZjYUFn?=
 =?utf-8?B?ek50UVRYRkd2bXhhVUVEL0VBQ29RZTlhRlVIcThaRWpjQVZWMXlLNDVyUU5Q?=
 =?utf-8?B?Y3lMdzkxL2hIS0QwWXNlWlFOQXhRMUVPZmx1a29xM3dXdEVtZUxyUHZKZlFi?=
 =?utf-8?B?ZFNwNTI5SFlIMHMwS0FMc1dMY08yUDBQcDFFZS9JenphVXZMWFpYcFRjaTFY?=
 =?utf-8?B?SE4rSDFzUzQ3eFIrYkd3bktrU2VMcFROOS9iVnBSZFp0VlZUL2g4N28zZTVP?=
 =?utf-8?B?MmJzK2s4NExXbjNxYkh4T1Y5cytISTNzUXdaVkt5TE1NS216N2FzN2tJclhv?=
 =?utf-8?B?RjN2K1dHVGEzeVVpdHJEQTdjbFRNTVVZdjJlVjlZWWZlKzE0UHo0NTcrNVZX?=
 =?utf-8?B?dlE2OFM1eWhheWdtS2F0Q2ZZQkJkK0lDbk50SVZJOGRTMldoYllET1JISm5R?=
 =?utf-8?B?QnBBK1BIcXdhQkhrN3J5NkxGZXo5QlJkRFhRVUhNUEhvWU42Sm1Ybmt4MWZw?=
 =?utf-8?B?RTd0SEhFMzJvWkhMMkhxOUhoZ1JHdGw0bDJLeXk3ZExzR1E9PQ==?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL1PR12MB5753.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZStGd3JLREhMdEsxNVo2V0h2RmdCK1lLWEJ4c1pWbWRQOVFmcElNUG5td2RJ?=
 =?utf-8?B?Y29sMWZKY0tEbUc5YzJvRGxTSjVqMGhWN0dKTG42S3JZMjQ1UlFRVW9jdFc2?=
 =?utf-8?B?TnBOZ2swZEdEUE1yS0VRNDZqZkg0ZnJBZzA5N1FIQkhRZzNQWXg5NFNOWkI3?=
 =?utf-8?B?cllFeE05NFloUXZYcU45eW1QUzlDL2psWnRhR3ZvaDlPcWpQRzh6aHh5MGFx?=
 =?utf-8?B?dlBwS216QWs5VERiK05pMUtnOElCNkRpSE16dDI2YkZmL3Z0OG9nNlpKV0FV?=
 =?utf-8?B?QmVOTktRdlVJQ0lIdERWZXFWVkFwZW5hc1kwY2tha0svdSt3MzR2UVB1WnN3?=
 =?utf-8?B?cmV4ZTBQVU9vNzFzc0JranVsSHBNWlMvWkZqb0JsTE0zUmRTY05QdVJlUkJD?=
 =?utf-8?B?UHRJWGZmdUJyemRjaGc5eEdKa1hTR3orTnUzZHFGdDZySytZSXQ5Ti9HTTNW?=
 =?utf-8?B?aExWSGZaWk04Vm5wRXVySysxcjhFYkJ6ZFlNenpVa29MYWhaR2VtY0ZWM0t0?=
 =?utf-8?B?Uk95a0hRL3hVNHVPWDlEbnFQSHJkTFRKOS9NZHRDNmZMbXJIaGFiR0sxckht?=
 =?utf-8?B?eUlUS0tTajBZV2YxbytYNlU2L0c5TnhhZW1ZOXlxbUg1a1YyNVAxb1RIMVlT?=
 =?utf-8?B?anFzVW5BQkgxMWJFUnUrY2l3S0RJOWlmSTJJbEtwNkNVTUxjalFmNDd4SjU5?=
 =?utf-8?B?K3k0VDJlU3R0NDg5UkF5bDRIcHBBcVdRWC8rOSswQnFrVmNyTm40cnI0d2Vs?=
 =?utf-8?B?RFliSlZ2SllYT0lYZ2JIeWNwK01Bb25mZUxvOHFEZ1ZFZXRwUU4yMjduMnVY?=
 =?utf-8?B?SU5hSlJlSWVTdFFxejBVSXVSV2djUW5YbmE1Qm9PNmZVTlROS3ltYTEvVTZj?=
 =?utf-8?B?c2JTdDNVWVFIRVJVZWlSQTB6VU1WQU8rUjZIZDY5MHlweWhQb3VFeXoyT2NB?=
 =?utf-8?B?ckx6YnJYdTBCdGhGenllODJHVTN1L3BWcVlHb3cwT3BoU1BHQU1tUXIrV1U0?=
 =?utf-8?B?Tm1YT2h1aFpiclZ5T0VTZkxwUHN0dURCV0p6Wmt3enNjUjgzTE1aWGJiSytI?=
 =?utf-8?B?VXhtMFdhN1FJb1lPT0ZuSFFtdGpIYmNIemJTSXF0THZHb3hscXl4ZHJXNE9y?=
 =?utf-8?B?VFBaaUlneVF5MER5R2s0NWdCeTZBZU1aVXZvcm9sa1dvYVdEeUw5Q1RuZHR6?=
 =?utf-8?B?bW9ja0Y2dUdqV1pZNDlkNUlFTnJpN2xOdHVVWUlWWHpKL3FDNnBPNEUyOGk3?=
 =?utf-8?B?dUtuNzJ2UnpXWkpXTi83Q2QyUVdFVklkM2phY1I2VEN1SVFSRVNmKzEyU3ln?=
 =?utf-8?B?UGRESUZRNlFYTHpjZ0lZaEtoU0JCZ2RYSmxzNGlBdTBzNnV1WlNhSGd2blZl?=
 =?utf-8?B?MFNnMUlBUWRRV2ZXWFJ4U3BJYjNuSWhLZUZNM2U5d0RXNXBvc0YwV2hZQUE2?=
 =?utf-8?B?TEk4YUoyVml0TmRFOE1tWS9TU2VZQllvRjFzcGFpU1RvU3BINjV3dWovd3U0?=
 =?utf-8?B?ZUExMDVnYTZUY2FHZzdEMXNUTkpGRlNkUjNudjFoYlc5S2lZSnd6QTlUalhw?=
 =?utf-8?B?RjAwdUd2ek9EME0xM2FBRVgzcGh0SkhkVUd3VHdJWjdKUURabGtORUhlU3FN?=
 =?utf-8?B?cUg1YmNUWm5CeGZsTnpFQVAzcTNEamIyaUlQNmkyeExEbXlQT2hqMS9MWmpr?=
 =?utf-8?B?MDg1YUtvak82anJZWVVqZWtTbFFrVzVaamVIcEZ0REFRZkhoOWJ4NnRxWUYw?=
 =?utf-8?B?aXBlQ2l0Ulp4enNKVHhqNE9zNEJHU2h4SnRDbWdTTUNwemEzcEM4NW02Tjcz?=
 =?utf-8?B?VzFFYTNod1FFdE9kMkZLelVFbVNxbml4QkNOZ2xiRHRlVjJ2ckFyTkFaQ0lZ?=
 =?utf-8?B?ZzdUa01pbUFtejVFR2pDUzZTcjMzaXhONlNseEw2WGNjRFhFRUpjZlZuMnhM?=
 =?utf-8?B?V3Z6MWRIUlY1clpYaDVnOWltK0U2clZCaGhzSDhVcitDb0d4OGU4Smgzdi9w?=
 =?utf-8?B?Qjd6bytReGIyRW5pZ1JkenRJRzJsZWM0eERnT2IrR1lyeEdRa0ZCbDVYMFVK?=
 =?utf-8?B?VTVOaHRsdHZWaUdKZFhIYlR4Uk1tVWFZZDdqenlnNmsyak9OcWs4cy8ySXIr?=
 =?utf-8?Q?bkmdKp0TIs5Y6DmXw4mViZwac?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: feb7c033-a8f1-4db5-42bf-08dd79162436
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5753.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Apr 2025 16:30:16.3595 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: IkSJGKstnqrr0dkAM7205Xk/81KDVo9MDZn4zKNGE1OMw93cPH8pKOhZXPdTIhro1Q4abJqbNFUaPH6sN2nHlQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6110
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

Are we replacing the kfx user queue with KGD userqueue names here?
Also this looks like KFD user queue and KGD userqueue are both treated 
at par ?

Looks good in general if the above understanding is correct. Some one 
with better understanding of isolation should review.
Acked-by: Sunil Khatri <sunil.khatri@amd.com>

On 4/10/2025 11:41 PM, Alex Deucher wrote:
> Enforce isolation serializes access to the GFX IP.  User
> queues are isolated in the MES scheduler, but we still
> need to serialize between kernel queues and user queues.
> For enforce isolation, group KGD user queues with KFD user
> queues.
>
> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_device.c |  2 +-
>   drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c    | 34 ++++++++++++----------
>   drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h    |  6 ++--
>   3 files changed, 22 insertions(+), 20 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> index 4e1c97a919cec..3c6679fce7c20 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> @@ -4344,7 +4344,7 @@ int amdgpu_device_init(struct amdgpu_device *adev,
>   		amdgpu_sync_create(&adev->isolation[i].active);
>   		amdgpu_sync_create(&adev->isolation[i].prev);
>   	}
> -	mutex_init(&adev->gfx.kfd_sch_mutex);
> +	mutex_init(&adev->gfx.userq_sch_mutex);
>   	mutex_init(&adev->gfx.workload_profile_mutex);
>   	mutex_init(&adev->vcn.workload_profile_mutex);
>   	mutex_init(&adev->userq_mutex);
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
> index a42ac1060fa92..e08323f601535 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
> @@ -1928,39 +1928,41 @@ void amdgpu_gfx_cleaner_shader_init(struct amdgpu_device *adev,
>   static void amdgpu_gfx_kfd_sch_ctrl(struct amdgpu_device *adev, u32 idx,
>   				    bool enable)
>   {
> -	mutex_lock(&adev->gfx.kfd_sch_mutex);
> +	mutex_lock(&adev->gfx.userq_sch_mutex);
>   
>   	if (enable) {
>   		/* If the count is already 0, it means there's an imbalance bug somewhere.
>   		 * Note that the bug may be in a different caller than the one which triggers the
>   		 * WARN_ON_ONCE.
>   		 */
> -		if (WARN_ON_ONCE(adev->gfx.kfd_sch_req_count[idx] == 0)) {
> +		if (WARN_ON_ONCE(adev->gfx.userq_sch_req_count[idx] == 0)) {
>   			dev_err(adev->dev, "Attempted to enable KFD scheduler when reference count is already zero\n");
>   			goto unlock;
>   		}
>   
> -		adev->gfx.kfd_sch_req_count[idx]--;
> +		adev->gfx.userq_sch_req_count[idx]--;
>   
> -		if (adev->gfx.kfd_sch_req_count[idx] == 0 &&
> -		    adev->gfx.kfd_sch_inactive[idx]) {
> +		if (adev->gfx.userq_sch_req_count[idx] == 0 &&
> +		    adev->gfx.userq_sch_inactive[idx]) {
>   			schedule_delayed_work(&adev->gfx.enforce_isolation[idx].work,
>   					      msecs_to_jiffies(adev->gfx.enforce_isolation_time[idx]));
>   		}
>   	} else {
> -		if (adev->gfx.kfd_sch_req_count[idx] == 0) {
> +		if (adev->gfx.userq_sch_req_count[idx] == 0) {
>   			cancel_delayed_work_sync(&adev->gfx.enforce_isolation[idx].work);
> -			if (!adev->gfx.kfd_sch_inactive[idx]) {
> -				amdgpu_amdkfd_stop_sched(adev, idx);
> -				adev->gfx.kfd_sch_inactive[idx] = true;
> +			if (!adev->gfx.userq_sch_inactive[idx]) {
> +				amdgpu_userq_stop_sched(adev, idx);
> +				if (adev->kfd.init_complete)
> +					amdgpu_amdkfd_stop_sched(adev, idx);
> +				adev->gfx.userq_sch_inactive[idx] = true;
>   			}
>   		}
>   
> -		adev->gfx.kfd_sch_req_count[idx]++;
> +		adev->gfx.userq_sch_req_count[idx]++;
>   	}
>   
>   unlock:
> -	mutex_unlock(&adev->gfx.kfd_sch_mutex);
> +	mutex_unlock(&adev->gfx.userq_sch_mutex);
>   }
>   
>   /**
> @@ -2005,12 +2007,12 @@ void amdgpu_gfx_enforce_isolation_handler(struct work_struct *work)
>   				      msecs_to_jiffies(1));
>   	} else {
>   		/* Tell KFD to resume the runqueue */
> -		if (adev->kfd.init_complete) {
> -			WARN_ON_ONCE(!adev->gfx.kfd_sch_inactive[idx]);
> -			WARN_ON_ONCE(adev->gfx.kfd_sch_req_count[idx]);
> +		WARN_ON_ONCE(!adev->gfx.userq_sch_inactive[idx]);
> +		WARN_ON_ONCE(adev->gfx.userq_sch_req_count[idx]);
> +		amdgpu_userq_start_sched(adev, idx);
> +		if (adev->kfd.init_complete)
>   			amdgpu_amdkfd_start_sched(adev, idx);
> -			adev->gfx.kfd_sch_inactive[idx] = false;
> -		}
> +		adev->gfx.userq_sch_inactive[idx] = false;
>   	}
>   	mutex_unlock(&adev->enforce_isolation_mutex);
>   }
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h
> index caaddab31023f..70b64bb1847c9 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h
> @@ -475,9 +475,9 @@ struct amdgpu_gfx {
>   	bool				enable_cleaner_shader;
>   	struct amdgpu_isolation_work	enforce_isolation[MAX_XCP];
>   	/* Mutex for synchronizing KFD scheduler operations */
> -	struct mutex                    kfd_sch_mutex;
> -	u64				kfd_sch_req_count[MAX_XCP];
> -	bool				kfd_sch_inactive[MAX_XCP];
> +	struct mutex                    userq_sch_mutex;
> +	u64				userq_sch_req_count[MAX_XCP];
> +	bool				userq_sch_inactive[MAX_XCP];
>   	unsigned long			enforce_isolation_jiffies[MAX_XCP];
>   	unsigned long			enforce_isolation_time[MAX_XCP];
>   
