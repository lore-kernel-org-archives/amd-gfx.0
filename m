Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A30BCE7717F
	for <amd-gfx@archiver.kernel.org>; Thu, 12 Dec 2024 09:28:53 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5B5BE10ED16;
	Thu, 12 Dec 2024 09:28:53 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="xQ2j8esf";
	dkim-atps=neutral
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2065.outbound.protection.outlook.com [40.107.223.65])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 991F910ED16
 for <amd-gfx@lists.freedesktop.org>; Thu, 12 Dec 2024 09:28:51 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uUNvGRkYBAIWbzmgPtv0tKjB2ptu65aXp33fprStAZ4NvImepfM9eGHLd1IBBDntxdRzPkgC/7el7zZRMayVAf5qmDXmW9abnyC5kqOPndtdKNZFoEamQlJy2AfxJdnlaQR+T5FKjSOLFJZ8w4doJCcHQc4nzxRdr/cJvBOpBQXZtNabXN+Xh198UR/Z2rnPf9ZssiOXY/oy4C4stAq40+1ErtXIJWGOfEP/NZE6MS6BNk3SlGijBW61jeLBXLOZgQTp6Ccc6wiQc8+pwMT/w9SwYGmKg3+HfSS1INVZePLQ5wp6Cjd6NYWqbBnTwzidJaTKLY3aALH0XN6qcDROUQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6AEVHS8gOTiaEq1i1lgIifu0M0bAUaZ5efdsWTVWOKw=;
 b=T5dFs1S21jl/VbXPATqPS1ImjDcy+oLQXw6V7REqiNEsIow9NGObpl8kv3kX44tHsveWHDm2Jxtpf13fT1wyv7g1uIXJ5Po0/AaOf8K/FTYYU47GISOuFIGkn95OTjRLCVQSkV1Hj1aKLI7Ao/DpX/DGj5X3UZKIZr6+4xPAeo9pnvJg7EHnMXjXNKlXMe38qgaCi6mtdRD/OJgc6n+HpGwoeqsPrz9LgW/2XgeM8X//EqWXdtH41sHRQPw3uayMzeufQX9O6/dziA/fKr0LOHjrK22Ty9NqdvpBwK002z8xBc3D8CRnieJcCKz2F6s+In1uaBo2ewnYFZPMKsAp2Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6AEVHS8gOTiaEq1i1lgIifu0M0bAUaZ5efdsWTVWOKw=;
 b=xQ2j8esfgHFOgR9GWJ6SpoBpvUyEDxZiojJekL5qCaj7Y4tPuEDT/xDAktL37kq87X5Qlk1B9d4PMuJhKVcC/miEd6iYofqf1Kp6jbvssznce8X7uc++bemmOun1UKIYvU/kMj7BuXRXShlnNegsJhp8c1UHYDm7ZvBWCSaKwZc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by DS0PR12MB8043.namprd12.prod.outlook.com (2603:10b6:8:14d::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8251.15; Thu, 12 Dec
 2024 09:28:49 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5%5]) with mapi id 15.20.8230.016; Thu, 12 Dec 2024
 09:28:49 +0000
Message-ID: <6084d74a-e565-46ba-97a5-e54120b808fb@amd.com>
Date: Thu, 12 Dec 2024 10:28:44 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/3] drm/amdgpu: don't access invalid sched
To: Pierre-Eric Pelloux-Prayer <pierre-eric.pelloux-prayer@amd.com>,
 alexander.deucher@amd.com, amd-gfx@lists.freedesktop.org
References: <20241211171238.805137-1-pierre-eric.pelloux-prayer@amd.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20241211171238.805137-1-pierre-eric.pelloux-prayer@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR3P281CA0192.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a4::16) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|DS0PR12MB8043:EE_
X-MS-Office365-Filtering-Correlation-Id: 211eac42-bedf-4a8f-0984-08dd1a8f627e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?Q1lZb1dFeHkxampXTVNldEJYSlFhcVhiaE02dlp1YW9CTHVXNlRRSTZEWDI2?=
 =?utf-8?B?bEJMNUc3SjJoU21PbVVyQXo5WkxtWkRhdzh2M2p2Nlkrcnp2dkQvWnhPMXFV?=
 =?utf-8?B?WThsZzhhV0lSOVNPeUpYeDZFQ3dqVS9NaWFQMGx4dFhwMnl5NU0zRTJKS2xZ?=
 =?utf-8?B?SDlaZzRYZDZaeGpwS3F3WTBhZ0lFLzhEd2tGSkk1Z243OFNWZjhQRXQ3eHlU?=
 =?utf-8?B?UmxvaFBtbkZhSGFMa0F6OEVONzFDYy9Lc3IwYmlxSmp5eVoyRnFVdXVBZ3lY?=
 =?utf-8?B?K081bGlQTnZPeWc4RDRVT2lTZGV2SXZJb1o4NmVHQndCMWh1Z29CaHF6amg0?=
 =?utf-8?B?OWptdUk4RjU0TUoyeUpmaG51Tjc1SGVZVVpITDFLeXNpRGt1UzRuYXFhRzJm?=
 =?utf-8?B?TGxpWi9nVmI0UHVXTi9LT2U4M0xjS29GUkpVdnpYbkVGdElHbDhRcEMwV09F?=
 =?utf-8?B?dUJDaU9uMElsMGVuU0NiVVMzZE9ZWThicDgydHJTMldyTjA1MFpldElNNHJD?=
 =?utf-8?B?Ylc0RVI5akcyQ3pMWmNYbHZiZk9jM2lpTEtvaW1yVUNBOVdsaklWV3hJdFgx?=
 =?utf-8?B?NmZGUXI5VE1TM2hIYXMyVDNJZ2lzOFVZR0FBNFB3bEdka0poSTdaZjZHR2Jz?=
 =?utf-8?B?ZlZPUmh5SG5PamRlVmFBNVFaZjBsQU02RHZwdzEwQWZXSG81eDc3UUxBZnAz?=
 =?utf-8?B?K2ZueUZudWF4RlUxSjRuaHFKaXdlN2hRNjRuUkdmV1JNUzF3R2ltNXFDTExF?=
 =?utf-8?B?TEVtYm14TmxUZW5ZT3p3NFRWYklsNzE1N1NrOWdycE5kWTAwTnNqOTk3U3Uv?=
 =?utf-8?B?RUFFbkd6VmUrNnNEU3creWpNckU5NzZEOTRwdFVuZmRLdXRlYnNQdTd3eEdY?=
 =?utf-8?B?Ykt0SUI2WWwyT1NsTEJKVXhXUUQ3NG1uajVSYTNQZjNaSElXT09ld2RFbHRp?=
 =?utf-8?B?YU16ZzljVzZyeStXVXBRMmplck1Hb01GU0ZrY3NMZi82Vnp2ODlaUU1MVmtK?=
 =?utf-8?B?S2N5a0twanVUdDlqVmFPQktiM2s2WnlRVGo3QmxUMWhObFgyMHlpeTRUZ3E0?=
 =?utf-8?B?MXIrTElkcXRVRWE3RCtJTWpKTWJJSTZITHdKTlo4ZHNXTk1odW4zNHVmdnRw?=
 =?utf-8?B?R1BZa2ptQkJJU2J0bmhBbHBiYUlSRHBDYkN1RTF4eFFyOXdsWUY0SGcvMXdr?=
 =?utf-8?B?OTVhak92cFBLWlF5Wk05Wkx6K3ZHZXVZeWwraUVDb2tIVW9xQi9EUzdIS3N2?=
 =?utf-8?B?dnFGZ21hUnJaOGYvMEp2NkdQTFY5ckRaWFl5ZjlLd3Qzenk1T0c1K1U2MWZT?=
 =?utf-8?B?VHk5WmFGeFVWNmt4NXcyZVB0V09XaXVUQXZHS09neHhDT0FmYzRYMHRJdndK?=
 =?utf-8?B?cExENVV1dzR3dHppY1Q2V0l6VUYxN1RaNytidjQyTzBCbENwZ0NRVTRJKy9q?=
 =?utf-8?B?KzRkUG5PdnlaMU9uZGNzbVdhSUdJSXY5cFVpc2NCL1FrKytkMTVob1JrRjVt?=
 =?utf-8?B?N0JrSkovT3VPMk9HbURvMUlOLzNxbG1mUlQxM0NpR0U0OGlVWERrSEc3amZq?=
 =?utf-8?B?MUQyYlhpVlJzWStSZVdvUjBsMldqUmlJUEl3QzV5UmdrTGsvMjlVMk1VTkw5?=
 =?utf-8?B?Tld2Qnd1R0JZRzZIK3BCTnVhTHdqZHhhU2sxWHVod3JxNlVlZDZIV0hYWXlv?=
 =?utf-8?B?UXlFVERmMzd2YlNlblF2Z2w3a2Y4KzdHd0tpdkNHQzc4YVhqMGNpeEhpdXha?=
 =?utf-8?B?azBWRnlTSytpUWcvdEM0Y0lsa1ZxbzY2STZ0VXlrR1lSQVhCYmJSODZENERG?=
 =?utf-8?B?cXRQR29IcnZNS2pDL21pZz09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cXpvOEFvYlpTbUk2TXVMaEtraGxNL1BEQVFBMkFVSi94ZW81RlpOVDVPaVV6?=
 =?utf-8?B?V0NVbUVDZ2V1angrbmVjTHp6bm9FTVZVOXRKeGlza2c0dUgvZzNMYUpxaUVX?=
 =?utf-8?B?dlhmWTk4NXhNcTF4SjhJWXoxVWpKT3BUQm1sZmdLU2tUTjg2MVZBVXdHL1FJ?=
 =?utf-8?B?dmhwMTZtWWhpTkVxems0SHZIT05EQURoRVllbU8wK1VyNXo4VXluUFhvZHZ2?=
 =?utf-8?B?TlZJOGdSYUFpQW5FMWNEdmJObmx0NitjRklpV01oK0pDNG9SK3JUNzM5aDlz?=
 =?utf-8?B?ZHdoaTUzRENadmo2ajdlMmdiak1EU3dkdFNLeUREajQzaTV5TnI3L2FtbGtD?=
 =?utf-8?B?eVh2VndEZWJKWXp2cnkvd2x0d0NMNEFaUW53Z0NrUUlQY2RtN3lEVkJLbVpI?=
 =?utf-8?B?R01RVEN2MThGN3Q1dkxDOERsU05YOWY1NGIzZVRYVnIxTXN5T2dNRkVuYThB?=
 =?utf-8?B?cEU0WXNTMjFlbUcvY2lNaGFxcmlGRFJCdERmV0FBYWNkUlVLV0ZvSVFxWjFD?=
 =?utf-8?B?RzdQZTNtVGdBbm9STGpNRUl6ZzFYN1d2SzUxSzE3WUl1RkN3RGFtM3I3cmtQ?=
 =?utf-8?B?T2k3aG1ndjRhUG85cXN2YmFLMEhoKzZPQmxBdXE2Y25Nc0l0K2hyV0cxWXhR?=
 =?utf-8?B?ZFN2WGhHNTQwUlp5U0ZHYWxLY2ZhRWRBUTZxNGRkdEJFRk9Vd0NLNklMY2V6?=
 =?utf-8?B?S1FBU3pNSDRoM2duTWN3OTVOdDZmT3FlL3owb3lkTmVuaDNYWUdzS3pxdkc1?=
 =?utf-8?B?bGQ0Z0Z5WjY2eFFTSDdhYzMzOEdFVWNJakUzVEY4ckc4Q2FBbHEzNytUY1dM?=
 =?utf-8?B?WFRMWU1aNDFweWFJZ0tSeVdOTXpodVpBd3pXclBJbDY1VFUrYzJQUE9lNmZ6?=
 =?utf-8?B?eWdhcktvNFp2L1NNV1Z4a2dMZy80cE5xd3FZclpQMXJFLzdOclRFYjlMY1Zh?=
 =?utf-8?B?ZXZPazNmUHhscW80NFJOT01tN1lOT0E5NlBNRFpPS2NEbjFIaHVKVG5jUFg2?=
 =?utf-8?B?a3ZvRDkwNDA4TUpIQWoyNDJZZkM5V041UzBTS0hYMVpRZzVyT29va081VElO?=
 =?utf-8?B?R1pnbjNCN05PK0Y4K0hnRkJIODdHbXF2ekZrS2Y3V1BRQlVFbmpvaERoMXMx?=
 =?utf-8?B?ZlBzUFVxZStRemJqRXI5RTVmS2tGSjRlYXlNa1N5blp5N2VnZkY1WjFqcGg1?=
 =?utf-8?B?aXYrdVplMDhYNWRFbDc1Ym5scGhhMlE2d2FVdUJ6T0VWMEZJWFZaOGdVTklE?=
 =?utf-8?B?b3dhVmpmSC8rVStqekZ2RXVxV29hWUZUNFRMRm5aUmg1SnNsbVAveHE5Wkg4?=
 =?utf-8?B?Q3pKcGJIaDI2RFFxc1owMThXYkRXMFdCb0lrMHhueXdEODk2Q3VzUERWREl2?=
 =?utf-8?B?bU93ay9XSVZBTUpkUkRuSzVpTGhjUlNZMjRBMjB1RjFxUjNrL1daQlVBa3I0?=
 =?utf-8?B?eE4xNW4xRXhvUU1SdU5lZ3N1cTQ1K1lQUTMrUjRFSldVSXVrKzBvQjk2eUpG?=
 =?utf-8?B?d3BRbXNZOHhkcDhnNkNkMGYyNE40REJhVSsyQzFTOVNlL05NY0xJSFNjUC9w?=
 =?utf-8?B?NVFDNElzcFdTY0FBM1lxV2taZFYzYmFBckZqUGRlNFZOaDl6RW01Q2FNZ2U5?=
 =?utf-8?B?NU1JNUtWYmJ1Uk5iNEhoTUk4TmxnOGlyNTdSQU9YdFc4eEY3eVBicTU5SENy?=
 =?utf-8?B?K2h5b2M2MmF1MXpXM05ORHZZaEljaDQ3emhwenlSRnF3UWVLeldIY0M3MS9y?=
 =?utf-8?B?cWtEcVl2aVdoaHhwbmFjRjlxZGZhWWN1UlZRVlYwTzBMS2VNNHpZYkVQUEkz?=
 =?utf-8?B?MmEzUzlkcENRNk1YNHY5a2hIY0pGbGpBTllWYXc5aHRkRzh6SmE0TnlXUEd3?=
 =?utf-8?B?b1hMYzR5MXZiMzQ1YTA2dzJMYys1ZEwreWZTcWlpZlBuSGIva1V1UGVqazVl?=
 =?utf-8?B?cmJlK0F1ditFbC9GMmRlV0RhWU0zZ25VaTZhTnI3azFwTThxWWNzUEFmckRh?=
 =?utf-8?B?M2svNFFadzVXOVhSWW1LemhBeHdmMTBkYmFNMU5RT01rU0hlU3BJN1A3ZHVD?=
 =?utf-8?B?eXAwTDVEUitNWlUzSG5nSVdZdUZPdVFGNjZpbUN1S3AxdHZuM1VBYVZ0WE9B?=
 =?utf-8?Q?MWpD3HlsFkeX3xjApgIElZnPM?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 211eac42-bedf-4a8f-0984-08dd1a8f627e
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Dec 2024 09:28:49.2978 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GeNe7x/HdBLm3LnqVseDdTEHoBVFGZKdXJeVrsa7cqNux5783G3S+Yl3QTYu5h0I
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8043
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

Am 11.12.24 um 18:10 schrieb Pierre-Eric Pelloux-Prayer:
> Since 2320c9e6a768 ("drm/sched: memset() 'job' in drm_sched_job_init()")
> accessing job->base.sched can produce unexpected results as the initialisation
> of (*job)->base.sched done in amdgpu_job_alloc is overwritten by the
> memset.
>
> This commit fixes an issue when a CS would fail validation and would
> be rejected after job->num_ibs is incremented. In this case,
> amdgpu_ib_free(ring->adev, ...) will be called, which would crash the
> machine because the ring value is bogus.
>
> To fix this, pass a NULL pointer to amdgpu_ib_free(): we can do this
> because the device is actually not used in this function.
>
> The next commit will remove the ring argument completely.
>
> Signed-off-by: Pierre-Eric Pelloux-Prayer <pierre-eric.pelloux-prayer@amd.com>

I would squash patch #1 and #2 together, but that isn't a must have.

We should look out for potential issues with patch #3, but I still hope 
that we cleaned up all users of this pointer.

Series is Reviewed-by: Christian König <christian.koenig@amd.com>

Regards,
Christian.

> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_job.c | 3 +--
>   1 file changed, 1 insertion(+), 2 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c
> index 9b322569255e..9ec8d5a8e48c 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c
> @@ -256,7 +256,6 @@ void amdgpu_job_set_resources(struct amdgpu_job *job, struct amdgpu_bo *gds,
>   
>   void amdgpu_job_free_resources(struct amdgpu_job *job)
>   {
> -	struct amdgpu_ring *ring = to_amdgpu_ring(job->base.sched);
>   	struct dma_fence *f;
>   	unsigned i;
>   
> @@ -269,7 +268,7 @@ void amdgpu_job_free_resources(struct amdgpu_job *job)
>   		f = NULL;
>   
>   	for (i = 0; i < job->num_ibs; ++i)
> -		amdgpu_ib_free(ring->adev, &job->ibs[i], f);
> +		amdgpu_ib_free(NULL, &job->ibs[i], f);
>   }
>   
>   static void amdgpu_job_free_cb(struct drm_sched_job *s_job)

