Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 13F60CCF2F6
	for <amd-gfx@archiver.kernel.org>; Mon, 19 Jan 2026 12:32:10 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A683B10E42C;
	Mon, 19 Jan 2026 12:32:09 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="yn4FQ5/x";
	dkim-atps=neutral
Received: from PH0PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11011066.outbound.protection.outlook.com [40.107.208.66])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D21CB10E423
 for <amd-gfx@lists.freedesktop.org>; Mon, 19 Jan 2026 12:32:07 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=aosXvdBnEv7Hfx9ghcXIviJOtAXsYEnIVLKuq+gCB6DGNhT9zdIkHet3lNvc80NavcfywD54Vtdzz2KFl2TQCmLKaH4VqrFHFAZT0uFIxE+sPCaDZQn2DykQooNtXjHF/US+TGj3crn8V2UJxkPy+FVLje22j+7B0rPQ5JnXRBH5GqXFt5Wwu4HVQ93dK81JPVV4ZNaf+ID7WZNmiVTYXLa41ijwqMAPua60AHOmuGb+Vh0WRpqpcUBcOInR8k2/rw8LK+06H+j6uSYl4ajGjsLAVI6hXCvEoiEx2D2yIxlbOWMBfwyl5ItFeHIKSoQSIBfD/M8O6Srx0hc7bqqc3g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bDmLDC0WbpBJ5hUP6yEnaW9pXCDO44fjygTFlCkI3qs=;
 b=Nr5QCacEuUcFKe+L7wRbykN8bNLqLKb6o2MyvhRApgV3sb3iDlGER1c5N0PnU9cv9RHZ/N1azOtNFyNKmBt3dNO++saXRvQJaTb405xX9q2y6qtorrq1LHW2aULmbiE95m+lSq0iDuf3Fiot73T1x7rw6A1vYj6Y564b3uR5I+jhkFPu/Gj2DgR4P3j9QtEk+4dO9vM5C2vhNjQ8jbJqVuLF8GAh+3S5ugHbB4TvEvjjy/402z3STt1Tc7qJfGrJyFp6AH5kd4YNiRfMlN3Kf1lypebbEbWiiGjxPmxhGkRTSbpmJOi7EUJ5JD7lR3tNjjcThZRiaSyw37BZUSukyQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bDmLDC0WbpBJ5hUP6yEnaW9pXCDO44fjygTFlCkI3qs=;
 b=yn4FQ5/xRrSyUMy7P/PqcIRxN3GCrOPJTblN2D4Zu0Pb46yGE7QSZ3qix8j80mwpWju93t4s2Du1GBZqEmbDhyuul51S9qpWVLKKI+hGzwQoJ2Rvaf+et/LtrTda1+7f4LhygKV5cAbSfEeOFk2kImhUtgzkbLE1jfymhhcWuBU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by CH3PR12MB8212.namprd12.prod.outlook.com (2603:10b6:610:120::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9520.12; Mon, 19 Jan
 2026 12:32:04 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5%4]) with mapi id 15.20.9520.011; Mon, 19 Jan 2026
 12:32:04 +0000
Message-ID: <0169654b-404a-4c4c-94be-9796b4ea6357@amd.com>
Date: Mon, 19 Jan 2026 13:31:58 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 04/10] drm/amdgpu: switch all IPs to using job for IBs
To: Alex Deucher <alexander.deucher@amd.com>, amd-gfx@lists.freedesktop.org
References: <20260116162027.21550-1-alexander.deucher@amd.com>
 <20260116162027.21550-5-alexander.deucher@amd.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20260116162027.21550-5-alexander.deucher@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BN1PR14CA0006.namprd14.prod.outlook.com
 (2603:10b6:408:e3::11) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|CH3PR12MB8212:EE_
X-MS-Office365-Filtering-Correlation-Id: f86b5ca1-7027-4e58-ec9e-08de5756c030
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?ZFEvMUVmRmE3aERoRzBmUFEzQnBVNFZwc241VXM4R2R4bEd3YXIvOUtFZkVp?=
 =?utf-8?B?N05lMi9BUjFpNDlIMEQ4UGF6R0lqRUZsRXFXOHV0TmNlREhPbG9Ia1I5c2pa?=
 =?utf-8?B?NXdNVEZXNXJiNjlKZmltdWN3dERHSEI2eUZMZnJvbGpaaml1MjlYNDVJUmZJ?=
 =?utf-8?B?OVJtL0xUS0pRb3VDS1M4d0R1RStjWENra2JOU3ptekVIczNRTHBwWTBjT1Mv?=
 =?utf-8?B?bVlIME9ucTNOdWlETkI2UkkwOURXb2ptZXFKb0t3dlp1SzRJeVl6b0NnTDIw?=
 =?utf-8?B?eE04TGY1THgwdnV4RmI0Mm5PTUhlZ1FWUXc5allWOHYvalhvN0pnd1EyZzBj?=
 =?utf-8?B?dUpyQmVHOHFzbXBnQ0x6ZXduVmJ4RklMRzJrRlBUWHU2cmtzVlhwWWVIYUJs?=
 =?utf-8?B?MWMwMEJlc0l5eEJaQVhIU1NsS1Q4M1EwMldhdXZONmJDaTZqaDJINjVSYkp6?=
 =?utf-8?B?ZllKVjFWRWptUk9uWDBtSy92NzZ6UFJZellnVTBCYXRIR0wyaFFIMEJNL00z?=
 =?utf-8?B?dVp3QXVkazl0OTZDUzN6NzdIWWl6djluY2MzWVFhcS82S0RjTWljZmxBQkRW?=
 =?utf-8?B?NmU2VWc3Qk5lZTNod29kYi9SV0F2QUhJckQ3anRDYXhxYnJtTmFoL0tOMW1D?=
 =?utf-8?B?NUJZb3R0WEFNYnRJUFJibFhFbEttQWRGOHJOYnQzUDNPcmxXcGRRTEM4aW52?=
 =?utf-8?B?cUY0bnpyTG1vSFk0WGdyRTNYUXJGYU1zcUJELzAvQ1NCVTNIQ3hJd2ZRYTVM?=
 =?utf-8?B?aVhUTmFoUUNaQThxSWNaUFVGR29nUi9ueEhkaGVGT25EdjZIMzNTVlM0enBw?=
 =?utf-8?B?ZjI1c21EdDJidDlRVUN1QVRYN2lVMTJGazNKTDZVY2VzVHJuZm9FNGc3UW1k?=
 =?utf-8?B?cURFVytvUWxOQVlsVXdaM3p2d2ZrZ3YyMkVCcFhONVVmY0NYM1YyQzg2WThy?=
 =?utf-8?B?ejV0WitRYnJQdzhoM2VjOGYxMk1EU3Y3Z0lCTmkvNHJFUmFLWXVtMTlxOHpV?=
 =?utf-8?B?UE9kc1d1a3NCY1ZXbjMwMHNjaGlNa0xieFlNRVJEUFZtajRkeC90aGJ4dHI3?=
 =?utf-8?B?RDlORi8zVE9mTlJnMTViU3plbW41UWJPelFWRlgvaStOVm8yc3h3V3RNWG55?=
 =?utf-8?B?VEQ5UnVxbjFqTXZzUDBvTzNUMTVTL3dwY3pWUkNmeGxBQ2V1N2VCdWtQK3BF?=
 =?utf-8?B?aUY4QXZTMkNRTDhxbkM4dUpkQWR2N0Z5S1lCRUd2SDVwRVZ0Ukc3SHZDd2RT?=
 =?utf-8?B?M3JVZm9BMWN6anRuak45YUJxeHlYS2l0TkI4Yzk4eTdGMm1CR2hUZmdIbjRN?=
 =?utf-8?B?a3FUWUxNbHg1dFZ6Ym5iRGY2NU8yeGFOTmZreGFmeXFCV0VlQklxQ2tMNnRh?=
 =?utf-8?B?cEZoNVpzZkVWYUcyODVsQzRyNXowamhNaWdYMVVwajRCcHpHZmNJSjNzOE5z?=
 =?utf-8?B?N0FZMlhYQVM1WWtXK1Jra1NNYUhJa2RmUTJMVitIa0RVSTByZ0U4T2F0MHJo?=
 =?utf-8?B?VFk0bk1IUE9Md0FwQkZwZjFLejBwL0ZkQjNlMlUydXZiVFo1K0IwWFE3Q0R5?=
 =?utf-8?B?ZFJzdkdObHBJaGQzWERRTkpkSXVNYjQ2RS9iUzFCT3dmWjFRVzlWYklsSExY?=
 =?utf-8?B?MVV3MXhNdzdvR0NqQ1pFRzZTYjdWWlRKMDM2ZitIV0lURk45aEVnQjJVVEdT?=
 =?utf-8?B?aXZUMUxZbE9CaEpNUzhGOHozcHpKY1prazV3cTYrREZaVU5HODYvWGIvQ3kw?=
 =?utf-8?B?dzlLT2hKTFlxQ2pzait2TVVOaFU3L3RXV1BwVTRtNW5tWU00MkgrdTF1aHZT?=
 =?utf-8?B?MG5HUjBOUiszTzZoaFlFVW9wSVh4U293VzJrVjJ6anNPTTU4bEplL1h1VE53?=
 =?utf-8?B?cUpLd3oxekk5YWVxeHltTTIwUnBQcXJDQ0x4bFBWOUh6Y0E2YklSOEdMNitB?=
 =?utf-8?B?SXdLZjVXeDNQcllJR1lYZHZWYjBnNEZNb3Y1Ym9UUkxPQ0RpZ3hoSkEvUExt?=
 =?utf-8?B?Qm1pQ0tua2Z4WUVzWnFoYWRFbmU2TXZYQ1pZRE5ERU8zWDNYeTJscFFtL2Zs?=
 =?utf-8?B?RGQwS3ZOYi9iL1c2djJIdVZzSFFBQ3pvelhKWERkSnVNaXMwQnVHamp1d0w1?=
 =?utf-8?Q?6uB0=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cktlak8xVWc2c01xN0ZQTG5jTHdZQ25lN1I1S1pBUy9NWXhCNDVQQmhMY3Rn?=
 =?utf-8?B?K3RPcVhGY2Z6eVNzRkQ2YVpFbC9MVlpmS1FoNGFNY0RkQi9PZFZROVpCWlpj?=
 =?utf-8?B?d2JHSXFVLzFZV3V4WTRTR3krOFgwSkt1anRBOHh2amlhTGgwRUdDVnRFeksv?=
 =?utf-8?B?YUUySEdvcVZvSkU4bENwdG9EL2RySENJanZRVVlnTmRoZGRBclR4OE5KQVg0?=
 =?utf-8?B?REQwd1g2RUh1ekFzN1dTdEVsTmFEcjgxbng3UVZXaUVCVUJvVmVDNnJHVUxk?=
 =?utf-8?B?aTFvdmpWK3kzdlkvNUVNQzBTWWJlR3BYdzJOUFJQL0ZxOHZhUUhnUXpsZ25C?=
 =?utf-8?B?RjJOdmEvQnZFMHZ6bXhwaERkUWRUMUJCcnJJWW9VT2xVU0Nzek0wTkYxWTFF?=
 =?utf-8?B?TEhoMHBZM2N0MzNpTlZQMW5uSHJqZTAwUE5yVGxGck14TjByejZzWUp3R3hM?=
 =?utf-8?B?d3FJNVlHS2did2Uxdnk0Q1pEZ2lqU0V5dzVxeHRDU3gyZGJodld1SEZLVnFa?=
 =?utf-8?B?YVpTYXA0U2xWYWluTnhXYk4rR01SMjQxTlZzNDNPd0hIQkVuY2FSVkJwMEFB?=
 =?utf-8?B?TVZOckhZcGhnQm5NZkhsM1kxMkErY1Bna2FPYUNTc2JvTWg1UHJ1S3laYys5?=
 =?utf-8?B?UXNNT2Y1d3Vja1AySEs5L09NRjZRREM5R01UQ1JsTEp5T2p2TmRhZTBlZ2pM?=
 =?utf-8?B?eDZoQmcwRjlyNXlib1NPQk1PUDFXWFpPZEZkWU45U2RzNllTd084RXNFcm54?=
 =?utf-8?B?bHJmNlVabXB5b0xsYWRRaDN3WFVYMEtJaHZ6Mi85L3Bud1FWRDBmUmszMEhW?=
 =?utf-8?B?SG1KU1JaYkdUQmlnckN1REZKWHVWcFdRTVZMVVJDVXoxeG1rYVhNWk9uVXFn?=
 =?utf-8?B?NkJvYnRsZDdBNzhrZmdTalVjMzFSYkNEQ3RKK3JRMUtZbVcyekZ0cXRQTldK?=
 =?utf-8?B?VzltYmRzVmFLOWZyT2ZHejRrWXlzbTB3cGYxSHZzcld5UURHbGRPKzBwOGZT?=
 =?utf-8?B?MVQ5bnJIODVCQldTa2VFTjF1akYwTEF2b2ZmYVhuYWEwNmVldWcvdGpTUndH?=
 =?utf-8?B?d3BvUEtGL20xRlR1THdKVE1ka1k4VmEyUDU5TXpHTHNQVXdhcENIajQvM3Rs?=
 =?utf-8?B?aUVHTDZBRDBZUnFFYUcxWVZhdHJNaDMrVmRIN2ROeXNNa2kwQjZrQmxiSlpt?=
 =?utf-8?B?WjFQTVJrRFIyUW5tRmpveXN4NDdKNmh2U0VQQWp3MmtFbUZYOFhVeU52akRz?=
 =?utf-8?B?WElvN2dWMTZ0RWU3S09LdXpDZEpMaUFySm9kVHpFZ1lmKzZ1VXlHWlFOOXhK?=
 =?utf-8?B?SXpyalora3ZjOVpYMU5IRm1oa2tXNmEyeU5rTHFDZndzNTB4RkgweXFIeHFP?=
 =?utf-8?B?WnE0L3dwM29hTWFqMHJDUm9hbHpWcFdHcFg0bXRVTEt0alNPVytyTGV3OWR1?=
 =?utf-8?B?ODZVdkNVTXdaYVBCcmVMNm5DWWRqWTI0N3FTUnZwVVlNckNOV0N5VTBudi9t?=
 =?utf-8?B?em9LZWxsTFRFVnVoTFczUWUyUWZzNDEwcXYyUUVHNFkwaG5uTGpKRk11cEVK?=
 =?utf-8?B?MEt0eUFtZm8vTWFLQmNkM0tJQU1wS2tNd3hkTUhMeEJsWWpwSFo4alNPZnI1?=
 =?utf-8?B?bzBiYUYzTlhmVkh2VitLOFphT2w4QTJNQUZmTU1nZW9EL3NIdDdDOEpMZU9q?=
 =?utf-8?B?ZG1laG1PM0JnVDJyNlFFRGt0SDNqc1V4Q1dHS2g0VW10TTJGQ0hoczQ3UG0r?=
 =?utf-8?B?VW1FTGpSVVpiU2U2Z3RjOE5nb3Fud3FXbmxxNFljSVpqbW1BdEx2eGVGRHhv?=
 =?utf-8?B?NUFQbU1KWGtvaGUyWWZleEFtM2tTVWpzb1g3ZkVJS0FWVVNlQmhHL3RpZFp6?=
 =?utf-8?B?UXJad0NFNXdFRnJUK1Y3WU83dVgzcndVNHVtY1R4UldrNXdqWTFpeTlucFRs?=
 =?utf-8?B?OTRyY00zcWN0VXlNWmF2cExXTWhHQTROelN2NGpLZTFjcXI2SUwySWxZdTZs?=
 =?utf-8?B?QkpLM2V1WG1ML2hpWElWZmx4a0xXUmxTa01TRzNHRGlDUGQ2U09KMU80ZEVv?=
 =?utf-8?B?T2pSaktZcjBQUVpTN0doN1ZETCtMbnVxMmszb3V0bExRMWxHRFE2SjdEMGx4?=
 =?utf-8?B?d1ZMWWVhTkVtczR1YTZFRHZjSUw1VWk3aVQ4czlodlU0UjZBUVJWUlBtVHk0?=
 =?utf-8?B?TTlyai9idHJmL2hmWjBWemVNS2Raa1ZFM0RaY0FRbWw4Mk1kNDkwYzdyc0Jy?=
 =?utf-8?B?N1kxTXRyNHF2bkpaZThxTHJtczMzV21pbjdKa3ByRUxNeGI0emE5bStKVm5q?=
 =?utf-8?Q?LIL6I3RliSG/l6cnar?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f86b5ca1-7027-4e58-ec9e-08de5756c030
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jan 2026 12:32:04.1000 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4URfuZWv7uLziy22+BHyfJZ+uZmT/YlySqahARifRehd0ocOKhMsRKJoVQXq+1VL
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8212
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

On 1/16/26 17:20, Alex Deucher wrote:
> Switch to using a job structure for IBs.
> 
> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>

Acked-by: Christian König <christian.koenig@amd.com>

> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_vpe.c  |  37 +++---
>  drivers/gpu/drm/amd/amdgpu/cik_sdma.c    |  31 ++---
>  drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c   |  29 ++---
>  drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c   |  29 ++---
>  drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c   |  29 ++---
>  drivers/gpu/drm/amd/amdgpu/gfx_v12_1.c   |  29 ++---
>  drivers/gpu/drm/amd/amdgpu/gfx_v6_0.c    |  24 ++--
>  drivers/gpu/drm/amd/amdgpu/gfx_v7_0.c    |  25 ++--
>  drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c    | 139 ++++++++++++-----------
>  drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c    | 138 +++++++++++-----------
>  drivers/gpu/drm/amd/amdgpu/gfx_v9_4_2.c  |  26 ++---
>  drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c  |  29 ++---
>  drivers/gpu/drm/amd/amdgpu/sdma_v2_4.c   |  38 ++++---
>  drivers/gpu/drm/amd/amdgpu/sdma_v3_0.c   |  38 ++++---
>  drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c   |  38 ++++---
>  drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c |  38 ++++---
>  drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c   |  37 +++---
>  drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c   |  36 +++---
>  drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c   |  36 +++---
>  drivers/gpu/drm/amd/amdgpu/sdma_v7_0.c   |  36 +++---
>  drivers/gpu/drm/amd/amdgpu/sdma_v7_1.c   |  36 +++---
>  drivers/gpu/drm/amd/amdgpu/si_dma.c      |  29 +++--
>  22 files changed, 500 insertions(+), 427 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vpe.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vpe.c
> index fd881388d6125..9fb1946be1ba2 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vpe.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vpe.c
> @@ -817,7 +817,8 @@ static int vpe_ring_test_ib(struct amdgpu_ring *ring, long timeout)
>  {
>  	struct amdgpu_device *adev = ring->adev;
>  	const uint32_t test_pattern = 0xdeadbeef;
> -	struct amdgpu_ib ib = {};
> +	struct amdgpu_job *job;
> +	struct amdgpu_ib *ib;
>  	struct dma_fence *f = NULL;
>  	uint32_t index;
>  	uint64_t wb_addr;
> @@ -832,23 +833,28 @@ static int vpe_ring_test_ib(struct amdgpu_ring *ring, long timeout)
>  	adev->wb.wb[index] = 0;
>  	wb_addr = adev->wb.gpu_addr + (index * 4);
>  
> -	ret = amdgpu_ib_get(adev, NULL, 256, AMDGPU_IB_POOL_DIRECT, &ib);
> +	ret = amdgpu_job_alloc_with_ib(ring->adev, NULL, NULL, 256,
> +				       AMDGPU_IB_POOL_DIRECT, &job,
> +				       AMDGPU_KERNEL_JOB_ID_VPE_RING_TEST);
>  	if (ret)
>  		goto err0;
> -
> -	ib.ptr[0] = VPE_CMD_HEADER(VPE_CMD_OPCODE_FENCE, 0);
> -	ib.ptr[1] = lower_32_bits(wb_addr);
> -	ib.ptr[2] = upper_32_bits(wb_addr);
> -	ib.ptr[3] = test_pattern;
> -	ib.ptr[4] = VPE_CMD_HEADER(VPE_CMD_OPCODE_NOP, 0);
> -	ib.ptr[5] = VPE_CMD_HEADER(VPE_CMD_OPCODE_NOP, 0);
> -	ib.ptr[6] = VPE_CMD_HEADER(VPE_CMD_OPCODE_NOP, 0);
> -	ib.ptr[7] = VPE_CMD_HEADER(VPE_CMD_OPCODE_NOP, 0);
> -	ib.length_dw = 8;
> -
> -	ret = amdgpu_ib_schedule(ring, 1, &ib, NULL, &f);
> -	if (ret)
> +	ib = &job->ibs[0];
> +
> +	ib->ptr[0] = VPE_CMD_HEADER(VPE_CMD_OPCODE_FENCE, 0);
> +	ib->ptr[1] = lower_32_bits(wb_addr);
> +	ib->ptr[2] = upper_32_bits(wb_addr);
> +	ib->ptr[3] = test_pattern;
> +	ib->ptr[4] = VPE_CMD_HEADER(VPE_CMD_OPCODE_NOP, 0);
> +	ib->ptr[5] = VPE_CMD_HEADER(VPE_CMD_OPCODE_NOP, 0);
> +	ib->ptr[6] = VPE_CMD_HEADER(VPE_CMD_OPCODE_NOP, 0);
> +	ib->ptr[7] = VPE_CMD_HEADER(VPE_CMD_OPCODE_NOP, 0);
> +	ib->length_dw = 8;
> +
> +	ret = amdgpu_job_submit_direct(job, ring, &f);
> +	if (ret) {
> +		amdgpu_job_free(job);
>  		goto err1;
> +	}
>  
>  	ret = dma_fence_wait_timeout(f, false, timeout);
>  	if (ret <= 0) {
> @@ -859,7 +865,6 @@ static int vpe_ring_test_ib(struct amdgpu_ring *ring, long timeout)
>  	ret = (le32_to_cpu(adev->wb.wb[index]) == test_pattern) ? 0 : -EINVAL;
>  
>  err1:
> -	amdgpu_ib_free(&ib, NULL);
>  	dma_fence_put(f);
>  err0:
>  	amdgpu_device_wb_free(adev, index);
> diff --git a/drivers/gpu/drm/amd/amdgpu/cik_sdma.c b/drivers/gpu/drm/amd/amdgpu/cik_sdma.c
> index 9e8715b4739da..e2ca96f5a7cfb 100644
> --- a/drivers/gpu/drm/amd/amdgpu/cik_sdma.c
> +++ b/drivers/gpu/drm/amd/amdgpu/cik_sdma.c
> @@ -652,7 +652,8 @@ static int cik_sdma_ring_test_ring(struct amdgpu_ring *ring)
>  static int cik_sdma_ring_test_ib(struct amdgpu_ring *ring, long timeout)
>  {
>  	struct amdgpu_device *adev = ring->adev;
> -	struct amdgpu_ib ib;
> +	struct amdgpu_job *job;
> +	struct amdgpu_ib *ib;
>  	struct dma_fence *f = NULL;
>  	unsigned index;
>  	u32 tmp = 0;
> @@ -666,22 +667,27 @@ static int cik_sdma_ring_test_ib(struct amdgpu_ring *ring, long timeout)
>  	gpu_addr = adev->wb.gpu_addr + (index * 4);
>  	tmp = 0xCAFEDEAD;
>  	adev->wb.wb[index] = cpu_to_le32(tmp);
> -	memset(&ib, 0, sizeof(ib));
> -	r = amdgpu_ib_get(adev, NULL, 256,
> -					AMDGPU_IB_POOL_DIRECT, &ib);
> +
> +	r = amdgpu_job_alloc_with_ib(ring->adev, NULL, NULL, 256,
> +				     AMDGPU_IB_POOL_DIRECT, &job,
> +				     AMDGPU_KERNEL_JOB_ID_SDMA_RING_TEST);
>  	if (r)
>  		goto err0;
> +	ib = &job->ibs[0];
>  
> -	ib.ptr[0] = SDMA_PACKET(SDMA_OPCODE_WRITE,
> +	ib->ptr[0] = SDMA_PACKET(SDMA_OPCODE_WRITE,
>  				SDMA_WRITE_SUB_OPCODE_LINEAR, 0);
> -	ib.ptr[1] = lower_32_bits(gpu_addr);
> -	ib.ptr[2] = upper_32_bits(gpu_addr);
> -	ib.ptr[3] = 1;
> -	ib.ptr[4] = 0xDEADBEEF;
> -	ib.length_dw = 5;
> -	r = amdgpu_ib_schedule(ring, 1, &ib, NULL, &f);
> -	if (r)
> +	ib->ptr[1] = lower_32_bits(gpu_addr);
> +	ib->ptr[2] = upper_32_bits(gpu_addr);
> +	ib->ptr[3] = 1;
> +	ib->ptr[4] = 0xDEADBEEF;
> +	ib->length_dw = 5;
> +
> +	r = amdgpu_job_submit_direct(job, ring, &f);
> +	if (r) {
> +		amdgpu_job_free(job);
>  		goto err1;
> +	}
>  
>  	r = dma_fence_wait_timeout(f, false, timeout);
>  	if (r == 0) {
> @@ -697,7 +703,6 @@ static int cik_sdma_ring_test_ib(struct amdgpu_ring *ring, long timeout)
>  		r = -EINVAL;
>  
>  err1:
> -	amdgpu_ib_free(&ib, NULL);
>  	dma_fence_put(f);
>  err0:
>  	amdgpu_device_wb_free(adev, index);
> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
> index 41bbedb8e157e..496121bdc1de1 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
> @@ -4071,15 +4071,14 @@ static int gfx_v10_0_ring_test_ring(struct amdgpu_ring *ring)
>  static int gfx_v10_0_ring_test_ib(struct amdgpu_ring *ring, long timeout)
>  {
>  	struct amdgpu_device *adev = ring->adev;
> -	struct amdgpu_ib ib;
> +	struct amdgpu_job *job;
> +	struct amdgpu_ib *ib;
>  	struct dma_fence *f = NULL;
>  	unsigned int index;
>  	uint64_t gpu_addr;
>  	uint32_t *cpu_ptr;
>  	long r;
>  
> -	memset(&ib, 0, sizeof(ib));
> -
>  	r = amdgpu_device_wb_get(adev, &index);
>  	if (r)
>  		return r;
> @@ -4088,22 +4087,27 @@ static int gfx_v10_0_ring_test_ib(struct amdgpu_ring *ring, long timeout)
>  	adev->wb.wb[index] = cpu_to_le32(0xCAFEDEAD);
>  	cpu_ptr = &adev->wb.wb[index];
>  
> -	r = amdgpu_ib_get(adev, NULL, 20, AMDGPU_IB_POOL_DIRECT, &ib);
> +	r = amdgpu_job_alloc_with_ib(ring->adev, NULL, NULL, 20,
> +				     AMDGPU_IB_POOL_DIRECT, &job,
> +				     AMDGPU_KERNEL_JOB_ID_GFX_RING_TEST);
>  	if (r) {
>  		drm_err(adev_to_drm(adev), "failed to get ib (%ld).\n", r);
>  		goto err1;
>  	}
> +	ib = &job->ibs[0];
>  
> -	ib.ptr[0] = PACKET3(PACKET3_WRITE_DATA, 3);
> -	ib.ptr[1] = WRITE_DATA_DST_SEL(5) | WR_CONFIRM;
> -	ib.ptr[2] = lower_32_bits(gpu_addr);
> -	ib.ptr[3] = upper_32_bits(gpu_addr);
> -	ib.ptr[4] = 0xDEADBEEF;
> -	ib.length_dw = 5;
> +	ib->ptr[0] = PACKET3(PACKET3_WRITE_DATA, 3);
> +	ib->ptr[1] = WRITE_DATA_DST_SEL(5) | WR_CONFIRM;
> +	ib->ptr[2] = lower_32_bits(gpu_addr);
> +	ib->ptr[3] = upper_32_bits(gpu_addr);
> +	ib->ptr[4] = 0xDEADBEEF;
> +	ib->length_dw = 5;
>  
> -	r = amdgpu_ib_schedule(ring, 1, &ib, NULL, &f);
> -	if (r)
> +	r = amdgpu_job_submit_direct(job, ring, &f);
> +	if (r) {
> +		amdgpu_job_free(job);
>  		goto err2;
> +	}
>  
>  	r = dma_fence_wait_timeout(f, false, timeout);
>  	if (r == 0) {
> @@ -4118,7 +4122,6 @@ static int gfx_v10_0_ring_test_ib(struct amdgpu_ring *ring, long timeout)
>  	else
>  		r = -EINVAL;
>  err2:
> -	amdgpu_ib_free(&ib, NULL);
>  	dma_fence_put(f);
>  err1:
>  	amdgpu_device_wb_free(adev, index);
> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
> index 3a4ca104b1612..5ad2516a60240 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
> @@ -604,7 +604,8 @@ static int gfx_v11_0_ring_test_ring(struct amdgpu_ring *ring)
>  static int gfx_v11_0_ring_test_ib(struct amdgpu_ring *ring, long timeout)
>  {
>  	struct amdgpu_device *adev = ring->adev;
> -	struct amdgpu_ib ib;
> +	struct amdgpu_job *job;
> +	struct amdgpu_ib *ib;
>  	struct dma_fence *f = NULL;
>  	unsigned index;
>  	uint64_t gpu_addr;
> @@ -616,8 +617,6 @@ static int gfx_v11_0_ring_test_ib(struct amdgpu_ring *ring, long timeout)
>  	    ring->funcs->type == AMDGPU_RING_TYPE_KIQ)
>  		return 0;
>  
> -	memset(&ib, 0, sizeof(ib));
> -
>  	r = amdgpu_device_wb_get(adev, &index);
>  	if (r)
>  		return r;
> @@ -626,22 +625,27 @@ static int gfx_v11_0_ring_test_ib(struct amdgpu_ring *ring, long timeout)
>  	adev->wb.wb[index] = cpu_to_le32(0xCAFEDEAD);
>  	cpu_ptr = &adev->wb.wb[index];
>  
> -	r = amdgpu_ib_get(adev, NULL, 20, AMDGPU_IB_POOL_DIRECT, &ib);
> +	r = amdgpu_job_alloc_with_ib(ring->adev, NULL, NULL, 20,
> +				     AMDGPU_IB_POOL_DIRECT, &job,
> +				     AMDGPU_KERNEL_JOB_ID_GFX_RING_TEST);
>  	if (r) {
>  		drm_err(adev_to_drm(adev), "failed to get ib (%ld).\n", r);
>  		goto err1;
>  	}
> +	ib = &job->ibs[0];
>  
> -	ib.ptr[0] = PACKET3(PACKET3_WRITE_DATA, 3);
> -	ib.ptr[1] = WRITE_DATA_DST_SEL(5) | WR_CONFIRM;
> -	ib.ptr[2] = lower_32_bits(gpu_addr);
> -	ib.ptr[3] = upper_32_bits(gpu_addr);
> -	ib.ptr[4] = 0xDEADBEEF;
> -	ib.length_dw = 5;
> +	ib->ptr[0] = PACKET3(PACKET3_WRITE_DATA, 3);
> +	ib->ptr[1] = WRITE_DATA_DST_SEL(5) | WR_CONFIRM;
> +	ib->ptr[2] = lower_32_bits(gpu_addr);
> +	ib->ptr[3] = upper_32_bits(gpu_addr);
> +	ib->ptr[4] = 0xDEADBEEF;
> +	ib->length_dw = 5;
>  
> -	r = amdgpu_ib_schedule(ring, 1, &ib, NULL, &f);
> -	if (r)
> +	r = amdgpu_job_submit_direct(job, ring, &f);
> +	if (r) {
> +		amdgpu_job_free(job);
>  		goto err2;
> +	}
>  
>  	r = dma_fence_wait_timeout(f, false, timeout);
>  	if (r == 0) {
> @@ -656,7 +660,6 @@ static int gfx_v11_0_ring_test_ib(struct amdgpu_ring *ring, long timeout)
>  	else
>  		r = -EINVAL;
>  err2:
> -	amdgpu_ib_free(&ib, NULL);
>  	dma_fence_put(f);
>  err1:
>  	amdgpu_device_wb_free(adev, index);
> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
> index 40660b05f9794..4d5c6bdd8cad7 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
> @@ -493,7 +493,8 @@ static int gfx_v12_0_ring_test_ring(struct amdgpu_ring *ring)
>  static int gfx_v12_0_ring_test_ib(struct amdgpu_ring *ring, long timeout)
>  {
>  	struct amdgpu_device *adev = ring->adev;
> -	struct amdgpu_ib ib;
> +	struct amdgpu_job *job;
> +	struct amdgpu_ib *ib;
>  	struct dma_fence *f = NULL;
>  	unsigned index;
>  	uint64_t gpu_addr;
> @@ -505,8 +506,6 @@ static int gfx_v12_0_ring_test_ib(struct amdgpu_ring *ring, long timeout)
>  	    ring->funcs->type == AMDGPU_RING_TYPE_KIQ)
>  		return 0;
>  
> -	memset(&ib, 0, sizeof(ib));
> -
>  	r = amdgpu_device_wb_get(adev, &index);
>  	if (r)
>  		return r;
> @@ -515,22 +514,27 @@ static int gfx_v12_0_ring_test_ib(struct amdgpu_ring *ring, long timeout)
>  	adev->wb.wb[index] = cpu_to_le32(0xCAFEDEAD);
>  	cpu_ptr = &adev->wb.wb[index];
>  
> -	r = amdgpu_ib_get(adev, NULL, 16, AMDGPU_IB_POOL_DIRECT, &ib);
> +	r = amdgpu_job_alloc_with_ib(ring->adev, NULL, NULL, 16,
> +				     AMDGPU_IB_POOL_DIRECT, &job,
> +				     AMDGPU_KERNEL_JOB_ID_GFX_RING_TEST);
>  	if (r) {
>  		drm_err(adev_to_drm(adev), "failed to get ib (%ld).\n", r);
>  		goto err1;
>  	}
> +	ib = &job->ibs[0];
>  
> -	ib.ptr[0] = PACKET3(PACKET3_WRITE_DATA, 3);
> -	ib.ptr[1] = WRITE_DATA_DST_SEL(5) | WR_CONFIRM;
> -	ib.ptr[2] = lower_32_bits(gpu_addr);
> -	ib.ptr[3] = upper_32_bits(gpu_addr);
> -	ib.ptr[4] = 0xDEADBEEF;
> -	ib.length_dw = 5;
> +	ib->ptr[0] = PACKET3(PACKET3_WRITE_DATA, 3);
> +	ib->ptr[1] = WRITE_DATA_DST_SEL(5) | WR_CONFIRM;
> +	ib->ptr[2] = lower_32_bits(gpu_addr);
> +	ib->ptr[3] = upper_32_bits(gpu_addr);
> +	ib->ptr[4] = 0xDEADBEEF;
> +	ib->length_dw = 5;
>  
> -	r = amdgpu_ib_schedule(ring, 1, &ib, NULL, &f);
> -	if (r)
> +	r = amdgpu_job_submit_direct(job, ring, &f);
> +	if (r) {
> +		amdgpu_job_free(job);
>  		goto err2;
> +	}
>  
>  	r = dma_fence_wait_timeout(f, false, timeout);
>  	if (r == 0) {
> @@ -545,7 +549,6 @@ static int gfx_v12_0_ring_test_ib(struct amdgpu_ring *ring, long timeout)
>  	else
>  		r = -EINVAL;
>  err2:
> -	amdgpu_ib_free(&ib, NULL);
>  	dma_fence_put(f);
>  err1:
>  	amdgpu_device_wb_free(adev, index);
> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v12_1.c b/drivers/gpu/drm/amd/amdgpu/gfx_v12_1.c
> index 86cc90a662965..7d02569cd4738 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v12_1.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v12_1.c
> @@ -306,7 +306,8 @@ static int gfx_v12_1_ring_test_ring(struct amdgpu_ring *ring)
>  static int gfx_v12_1_ring_test_ib(struct amdgpu_ring *ring, long timeout)
>  {
>  	struct amdgpu_device *adev = ring->adev;
> -	struct amdgpu_ib ib;
> +	struct amdgpu_job *job;
> +	struct amdgpu_ib *ib;
>  	struct dma_fence *f = NULL;
>  	unsigned index;
>  	uint64_t gpu_addr;
> @@ -318,8 +319,6 @@ static int gfx_v12_1_ring_test_ib(struct amdgpu_ring *ring, long timeout)
>  	    ring->funcs->type == AMDGPU_RING_TYPE_KIQ)
>  		return 0;
>  
> -	memset(&ib, 0, sizeof(ib));
> -
>  	r = amdgpu_device_wb_get(adev, &index);
>  	if (r)
>  		return r;
> @@ -328,22 +327,27 @@ static int gfx_v12_1_ring_test_ib(struct amdgpu_ring *ring, long timeout)
>  	adev->wb.wb[index] = cpu_to_le32(0xCAFEDEAD);
>  	cpu_ptr = &adev->wb.wb[index];
>  
> -	r = amdgpu_ib_get(adev, NULL, 16, AMDGPU_IB_POOL_DIRECT, &ib);
> +	r = amdgpu_job_alloc_with_ib(ring->adev, NULL, NULL, 16,
> +				     AMDGPU_IB_POOL_DIRECT, &job,
> +				     AMDGPU_KERNEL_JOB_ID_GFX_RING_TEST);
>  	if (r) {
>  		dev_err(adev->dev, "amdgpu: failed to get ib (%ld).\n", r);
>  		goto err1;
>  	}
> +	ib = &job->ibs[0];
>  
> -	ib.ptr[0] = PACKET3(PACKET3_WRITE_DATA, 3);
> -	ib.ptr[1] = WRITE_DATA_DST_SEL(5) | WR_CONFIRM;
> -	ib.ptr[2] = lower_32_bits(gpu_addr);
> -	ib.ptr[3] = upper_32_bits(gpu_addr);
> -	ib.ptr[4] = 0xDEADBEEF;
> -	ib.length_dw = 5;
> +	ib->ptr[0] = PACKET3(PACKET3_WRITE_DATA, 3);
> +	ib->ptr[1] = WRITE_DATA_DST_SEL(5) | WR_CONFIRM;
> +	ib->ptr[2] = lower_32_bits(gpu_addr);
> +	ib->ptr[3] = upper_32_bits(gpu_addr);
> +	ib->ptr[4] = 0xDEADBEEF;
> +	ib->length_dw = 5;
>  
> -	r = amdgpu_ib_schedule(ring, 1, &ib, NULL, &f);
> -	if (r)
> +	r = amdgpu_job_submit_direct(job, ring, &f);
> +	if (r) {
> +		amdgpu_job_free(job);
>  		goto err2;
> +	}
>  
>  	r = dma_fence_wait_timeout(f, false, timeout);
>  	if (r == 0) {
> @@ -358,7 +362,6 @@ static int gfx_v12_1_ring_test_ib(struct amdgpu_ring *ring, long timeout)
>  	else
>  		r = -EINVAL;
>  err2:
> -	amdgpu_ib_free(&ib, NULL);
>  	dma_fence_put(f);
>  err1:
>  	amdgpu_device_wb_free(adev, index);
> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v6_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v6_0.c
> index 73223d97a87f5..2f8aa99f17480 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v6_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v6_0.c
> @@ -1895,24 +1895,29 @@ static int gfx_v6_0_ring_test_ib(struct amdgpu_ring *ring, long timeout)
>  {
>  	struct amdgpu_device *adev = ring->adev;
>  	struct dma_fence *f = NULL;
> -	struct amdgpu_ib ib;
> +	struct amdgpu_job *job;
> +	struct amdgpu_ib *ib;
>  	uint32_t tmp = 0;
>  	long r;
>  
>  	WREG32(mmSCRATCH_REG0, 0xCAFEDEAD);
> -	memset(&ib, 0, sizeof(ib));
> -	r = amdgpu_ib_get(adev, NULL, 256, AMDGPU_IB_POOL_DIRECT, &ib);
> +	r = amdgpu_job_alloc_with_ib(ring->adev, NULL, NULL, 256,
> +				     AMDGPU_IB_POOL_DIRECT, &job,
> +				     AMDGPU_KERNEL_JOB_ID_GFX_RING_TEST);
>  	if (r)
>  		return r;
>  
> -	ib.ptr[0] = PACKET3(PACKET3_SET_CONFIG_REG, 1);
> -	ib.ptr[1] = mmSCRATCH_REG0 - PACKET3_SET_CONFIG_REG_START;
> -	ib.ptr[2] = 0xDEADBEEF;
> -	ib.length_dw = 3;
> +	ib = &job->ibs[0];
> +	ib->ptr[0] = PACKET3(PACKET3_SET_CONFIG_REG, 1);
> +	ib->ptr[1] = mmSCRATCH_REG0 - PACKET3_SET_CONFIG_REG_START;
> +	ib->ptr[2] = 0xDEADBEEF;
> +	ib->length_dw = 3;
>  
> -	r = amdgpu_ib_schedule(ring, 1, &ib, NULL, &f);
> -	if (r)
> +	r = amdgpu_job_submit_direct(job, ring, &f);
> +	if (r) {
> +		amdgpu_job_free(job);
>  		goto error;
> +	}
>  
>  	r = dma_fence_wait_timeout(f, false, timeout);
>  	if (r == 0) {
> @@ -1928,7 +1933,6 @@ static int gfx_v6_0_ring_test_ib(struct amdgpu_ring *ring, long timeout)
>  		r = -EINVAL;
>  
>  error:
> -	amdgpu_ib_free(&ib, NULL);
>  	dma_fence_put(f);
>  	return r;
>  }
> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v7_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v7_0.c
> index 2b691452775bc..fa235b981c2e9 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v7_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v7_0.c
> @@ -2291,25 +2291,31 @@ static void gfx_v7_ring_emit_cntxcntl(struct amdgpu_ring *ring, uint32_t flags)
>  static int gfx_v7_0_ring_test_ib(struct amdgpu_ring *ring, long timeout)
>  {
>  	struct amdgpu_device *adev = ring->adev;
> -	struct amdgpu_ib ib;
> +	struct amdgpu_job *job;
> +	struct amdgpu_ib *ib;
>  	struct dma_fence *f = NULL;
>  	uint32_t tmp = 0;
>  	long r;
>  
>  	WREG32(mmSCRATCH_REG0, 0xCAFEDEAD);
> -	memset(&ib, 0, sizeof(ib));
> -	r = amdgpu_ib_get(adev, NULL, 256, AMDGPU_IB_POOL_DIRECT, &ib);
> +
> +	r = amdgpu_job_alloc_with_ib(ring->adev, NULL, NULL, 256,
> +				     AMDGPU_IB_POOL_DIRECT, &job,
> +				     AMDGPU_KERNEL_JOB_ID_GFX_RING_TEST);
>  	if (r)
>  		return r;
>  
> -	ib.ptr[0] = PACKET3(PACKET3_SET_UCONFIG_REG, 1);
> -	ib.ptr[1] = mmSCRATCH_REG0 - PACKET3_SET_UCONFIG_REG_START;
> -	ib.ptr[2] = 0xDEADBEEF;
> -	ib.length_dw = 3;
> +	ib = &job->ibs[0];
> +	ib->ptr[0] = PACKET3(PACKET3_SET_UCONFIG_REG, 1);
> +	ib->ptr[1] = mmSCRATCH_REG0 - PACKET3_SET_UCONFIG_REG_START;
> +	ib->ptr[2] = 0xDEADBEEF;
> +	ib->length_dw = 3;
>  
> -	r = amdgpu_ib_schedule(ring, 1, &ib, NULL, &f);
> -	if (r)
> +	r = amdgpu_job_submit_direct(job, ring, &f);
> +	if (r) {
> +		amdgpu_job_free(job);
>  		goto error;
> +	}
>  
>  	r = dma_fence_wait_timeout(f, false, timeout);
>  	if (r == 0) {
> @@ -2325,7 +2331,6 @@ static int gfx_v7_0_ring_test_ib(struct amdgpu_ring *ring, long timeout)
>  		r = -EINVAL;
>  
>  error:
> -	amdgpu_ib_free(&ib, NULL);
>  	dma_fence_put(f);
>  	return r;
>  }
> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c
> index a6b4c8f41dc11..4736216cd0211 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c
> @@ -868,9 +868,9 @@ static int gfx_v8_0_ring_test_ring(struct amdgpu_ring *ring)
>  static int gfx_v8_0_ring_test_ib(struct amdgpu_ring *ring, long timeout)
>  {
>  	struct amdgpu_device *adev = ring->adev;
> -	struct amdgpu_ib ib;
> +	struct amdgpu_job *job;
> +	struct amdgpu_ib *ib;
>  	struct dma_fence *f = NULL;
> -
>  	unsigned int index;
>  	uint64_t gpu_addr;
>  	uint32_t tmp;
> @@ -882,22 +882,26 @@ static int gfx_v8_0_ring_test_ib(struct amdgpu_ring *ring, long timeout)
>  
>  	gpu_addr = adev->wb.gpu_addr + (index * 4);
>  	adev->wb.wb[index] = cpu_to_le32(0xCAFEDEAD);
> -	memset(&ib, 0, sizeof(ib));
>  
> -	r = amdgpu_ib_get(adev, NULL, 20, AMDGPU_IB_POOL_DIRECT, &ib);
> +	r = amdgpu_job_alloc_with_ib(ring->adev, NULL, NULL, 20,
> +				     AMDGPU_IB_POOL_DIRECT, &job,
> +				     AMDGPU_KERNEL_JOB_ID_GFX_RING_TEST);
>  	if (r)
>  		goto err1;
>  
> -	ib.ptr[0] = PACKET3(PACKET3_WRITE_DATA, 3);
> -	ib.ptr[1] = WRITE_DATA_DST_SEL(5) | WR_CONFIRM;
> -	ib.ptr[2] = lower_32_bits(gpu_addr);
> -	ib.ptr[3] = upper_32_bits(gpu_addr);
> -	ib.ptr[4] = 0xDEADBEEF;
> -	ib.length_dw = 5;
> +	ib = &job->ibs[0];
> +	ib->ptr[0] = PACKET3(PACKET3_WRITE_DATA, 3);
> +	ib->ptr[1] = WRITE_DATA_DST_SEL(5) | WR_CONFIRM;
> +	ib->ptr[2] = lower_32_bits(gpu_addr);
> +	ib->ptr[3] = upper_32_bits(gpu_addr);
> +	ib->ptr[4] = 0xDEADBEEF;
> +	ib->length_dw = 5;
>  
> -	r = amdgpu_ib_schedule(ring, 1, &ib, NULL, &f);
> -	if (r)
> +	r = amdgpu_job_submit_direct(job, ring, &f);
> +	if (r) {
> +		amdgpu_job_free(job);
>  		goto err2;
> +	}
>  
>  	r = dma_fence_wait_timeout(f, false, timeout);
>  	if (r == 0) {
> @@ -914,7 +918,6 @@ static int gfx_v8_0_ring_test_ib(struct amdgpu_ring *ring, long timeout)
>  		r = -EINVAL;
>  
>  err2:
> -	amdgpu_ib_free(&ib, NULL);
>  	dma_fence_put(f);
>  err1:
>  	amdgpu_device_wb_free(adev, index);
> @@ -1474,7 +1477,8 @@ static const u32 sec_ded_counter_registers[] =
>  static int gfx_v8_0_do_edc_gpr_workarounds(struct amdgpu_device *adev)
>  {
>  	struct amdgpu_ring *ring = &adev->gfx.compute_ring[0];
> -	struct amdgpu_ib ib;
> +	struct amdgpu_job *job;
> +	struct amdgpu_ib *ib;
>  	struct dma_fence *f = NULL;
>  	int r, i;
>  	u32 tmp;
> @@ -1505,106 +1509,108 @@ static int gfx_v8_0_do_edc_gpr_workarounds(struct amdgpu_device *adev)
>  	total_size += sizeof(sgpr_init_compute_shader);
>  
>  	/* allocate an indirect buffer to put the commands in */
> -	memset(&ib, 0, sizeof(ib));
> -	r = amdgpu_ib_get(adev, NULL, total_size,
> -					AMDGPU_IB_POOL_DIRECT, &ib);
> +	r = amdgpu_job_alloc_with_ib(ring->adev, NULL, NULL, total_size,
> +				     AMDGPU_IB_POOL_DIRECT, &job,
> +				     AMDGPU_KERNEL_JOB_ID_RUN_SHADER);
>  	if (r) {
>  		drm_err(adev_to_drm(adev), "failed to get ib (%d).\n", r);
>  		return r;
>  	}
> +	ib = &job->ibs[0];
>  
>  	/* load the compute shaders */
>  	for (i = 0; i < ARRAY_SIZE(vgpr_init_compute_shader); i++)
> -		ib.ptr[i + (vgpr_offset / 4)] = vgpr_init_compute_shader[i];
> +		ib->ptr[i + (vgpr_offset / 4)] = vgpr_init_compute_shader[i];
>  
>  	for (i = 0; i < ARRAY_SIZE(sgpr_init_compute_shader); i++)
> -		ib.ptr[i + (sgpr_offset / 4)] = sgpr_init_compute_shader[i];
> +		ib->ptr[i + (sgpr_offset / 4)] = sgpr_init_compute_shader[i];
>  
>  	/* init the ib length to 0 */
> -	ib.length_dw = 0;
> +	ib->length_dw = 0;
>  
>  	/* VGPR */
>  	/* write the register state for the compute dispatch */
>  	for (i = 0; i < ARRAY_SIZE(vgpr_init_regs); i += 2) {
> -		ib.ptr[ib.length_dw++] = PACKET3(PACKET3_SET_SH_REG, 1);
> -		ib.ptr[ib.length_dw++] = vgpr_init_regs[i] - PACKET3_SET_SH_REG_START;
> -		ib.ptr[ib.length_dw++] = vgpr_init_regs[i + 1];
> +		ib->ptr[ib->length_dw++] = PACKET3(PACKET3_SET_SH_REG, 1);
> +		ib->ptr[ib->length_dw++] = vgpr_init_regs[i] - PACKET3_SET_SH_REG_START;
> +		ib->ptr[ib->length_dw++] = vgpr_init_regs[i + 1];
>  	}
>  	/* write the shader start address: mmCOMPUTE_PGM_LO, mmCOMPUTE_PGM_HI */
> -	gpu_addr = (ib.gpu_addr + (u64)vgpr_offset) >> 8;
> -	ib.ptr[ib.length_dw++] = PACKET3(PACKET3_SET_SH_REG, 2);
> -	ib.ptr[ib.length_dw++] = mmCOMPUTE_PGM_LO - PACKET3_SET_SH_REG_START;
> -	ib.ptr[ib.length_dw++] = lower_32_bits(gpu_addr);
> -	ib.ptr[ib.length_dw++] = upper_32_bits(gpu_addr);
> +	gpu_addr = (ib->gpu_addr + (u64)vgpr_offset) >> 8;
> +	ib->ptr[ib->length_dw++] = PACKET3(PACKET3_SET_SH_REG, 2);
> +	ib->ptr[ib->length_dw++] = mmCOMPUTE_PGM_LO - PACKET3_SET_SH_REG_START;
> +	ib->ptr[ib->length_dw++] = lower_32_bits(gpu_addr);
> +	ib->ptr[ib->length_dw++] = upper_32_bits(gpu_addr);
>  
>  	/* write dispatch packet */
> -	ib.ptr[ib.length_dw++] = PACKET3(PACKET3_DISPATCH_DIRECT, 3);
> -	ib.ptr[ib.length_dw++] = 8; /* x */
> -	ib.ptr[ib.length_dw++] = 1; /* y */
> -	ib.ptr[ib.length_dw++] = 1; /* z */
> -	ib.ptr[ib.length_dw++] =
> +	ib->ptr[ib->length_dw++] = PACKET3(PACKET3_DISPATCH_DIRECT, 3);
> +	ib->ptr[ib->length_dw++] = 8; /* x */
> +	ib->ptr[ib->length_dw++] = 1; /* y */
> +	ib->ptr[ib->length_dw++] = 1; /* z */
> +	ib->ptr[ib->length_dw++] =
>  		REG_SET_FIELD(0, COMPUTE_DISPATCH_INITIATOR, COMPUTE_SHADER_EN, 1);
>  
>  	/* write CS partial flush packet */
> -	ib.ptr[ib.length_dw++] = PACKET3(PACKET3_EVENT_WRITE, 0);
> -	ib.ptr[ib.length_dw++] = EVENT_TYPE(7) | EVENT_INDEX(4);
> +	ib->ptr[ib->length_dw++] = PACKET3(PACKET3_EVENT_WRITE, 0);
> +	ib->ptr[ib->length_dw++] = EVENT_TYPE(7) | EVENT_INDEX(4);
>  
>  	/* SGPR1 */
>  	/* write the register state for the compute dispatch */
>  	for (i = 0; i < ARRAY_SIZE(sgpr1_init_regs); i += 2) {
> -		ib.ptr[ib.length_dw++] = PACKET3(PACKET3_SET_SH_REG, 1);
> -		ib.ptr[ib.length_dw++] = sgpr1_init_regs[i] - PACKET3_SET_SH_REG_START;
> -		ib.ptr[ib.length_dw++] = sgpr1_init_regs[i + 1];
> +		ib->ptr[ib->length_dw++] = PACKET3(PACKET3_SET_SH_REG, 1);
> +		ib->ptr[ib->length_dw++] = sgpr1_init_regs[i] - PACKET3_SET_SH_REG_START;
> +		ib->ptr[ib->length_dw++] = sgpr1_init_regs[i + 1];
>  	}
>  	/* write the shader start address: mmCOMPUTE_PGM_LO, mmCOMPUTE_PGM_HI */
> -	gpu_addr = (ib.gpu_addr + (u64)sgpr_offset) >> 8;
> -	ib.ptr[ib.length_dw++] = PACKET3(PACKET3_SET_SH_REG, 2);
> -	ib.ptr[ib.length_dw++] = mmCOMPUTE_PGM_LO - PACKET3_SET_SH_REG_START;
> -	ib.ptr[ib.length_dw++] = lower_32_bits(gpu_addr);
> -	ib.ptr[ib.length_dw++] = upper_32_bits(gpu_addr);
> +	gpu_addr = (ib->gpu_addr + (u64)sgpr_offset) >> 8;
> +	ib->ptr[ib->length_dw++] = PACKET3(PACKET3_SET_SH_REG, 2);
> +	ib->ptr[ib->length_dw++] = mmCOMPUTE_PGM_LO - PACKET3_SET_SH_REG_START;
> +	ib->ptr[ib->length_dw++] = lower_32_bits(gpu_addr);
> +	ib->ptr[ib->length_dw++] = upper_32_bits(gpu_addr);
>  
>  	/* write dispatch packet */
> -	ib.ptr[ib.length_dw++] = PACKET3(PACKET3_DISPATCH_DIRECT, 3);
> -	ib.ptr[ib.length_dw++] = 8; /* x */
> -	ib.ptr[ib.length_dw++] = 1; /* y */
> -	ib.ptr[ib.length_dw++] = 1; /* z */
> -	ib.ptr[ib.length_dw++] =
> +	ib->ptr[ib->length_dw++] = PACKET3(PACKET3_DISPATCH_DIRECT, 3);
> +	ib->ptr[ib->length_dw++] = 8; /* x */
> +	ib->ptr[ib->length_dw++] = 1; /* y */
> +	ib->ptr[ib->length_dw++] = 1; /* z */
> +	ib->ptr[ib->length_dw++] =
>  		REG_SET_FIELD(0, COMPUTE_DISPATCH_INITIATOR, COMPUTE_SHADER_EN, 1);
>  
>  	/* write CS partial flush packet */
> -	ib.ptr[ib.length_dw++] = PACKET3(PACKET3_EVENT_WRITE, 0);
> -	ib.ptr[ib.length_dw++] = EVENT_TYPE(7) | EVENT_INDEX(4);
> +	ib->ptr[ib->length_dw++] = PACKET3(PACKET3_EVENT_WRITE, 0);
> +	ib->ptr[ib->length_dw++] = EVENT_TYPE(7) | EVENT_INDEX(4);
>  
>  	/* SGPR2 */
>  	/* write the register state for the compute dispatch */
>  	for (i = 0; i < ARRAY_SIZE(sgpr2_init_regs); i += 2) {
> -		ib.ptr[ib.length_dw++] = PACKET3(PACKET3_SET_SH_REG, 1);
> -		ib.ptr[ib.length_dw++] = sgpr2_init_regs[i] - PACKET3_SET_SH_REG_START;
> -		ib.ptr[ib.length_dw++] = sgpr2_init_regs[i + 1];
> +		ib->ptr[ib->length_dw++] = PACKET3(PACKET3_SET_SH_REG, 1);
> +		ib->ptr[ib->length_dw++] = sgpr2_init_regs[i] - PACKET3_SET_SH_REG_START;
> +		ib->ptr[ib->length_dw++] = sgpr2_init_regs[i + 1];
>  	}
>  	/* write the shader start address: mmCOMPUTE_PGM_LO, mmCOMPUTE_PGM_HI */
> -	gpu_addr = (ib.gpu_addr + (u64)sgpr_offset) >> 8;
> -	ib.ptr[ib.length_dw++] = PACKET3(PACKET3_SET_SH_REG, 2);
> -	ib.ptr[ib.length_dw++] = mmCOMPUTE_PGM_LO - PACKET3_SET_SH_REG_START;
> -	ib.ptr[ib.length_dw++] = lower_32_bits(gpu_addr);
> -	ib.ptr[ib.length_dw++] = upper_32_bits(gpu_addr);
> +	gpu_addr = (ib->gpu_addr + (u64)sgpr_offset) >> 8;
> +	ib->ptr[ib->length_dw++] = PACKET3(PACKET3_SET_SH_REG, 2);
> +	ib->ptr[ib->length_dw++] = mmCOMPUTE_PGM_LO - PACKET3_SET_SH_REG_START;
> +	ib->ptr[ib->length_dw++] = lower_32_bits(gpu_addr);
> +	ib->ptr[ib->length_dw++] = upper_32_bits(gpu_addr);
>  
>  	/* write dispatch packet */
> -	ib.ptr[ib.length_dw++] = PACKET3(PACKET3_DISPATCH_DIRECT, 3);
> -	ib.ptr[ib.length_dw++] = 8; /* x */
> -	ib.ptr[ib.length_dw++] = 1; /* y */
> -	ib.ptr[ib.length_dw++] = 1; /* z */
> -	ib.ptr[ib.length_dw++] =
> +	ib->ptr[ib->length_dw++] = PACKET3(PACKET3_DISPATCH_DIRECT, 3);
> +	ib->ptr[ib->length_dw++] = 8; /* x */
> +	ib->ptr[ib->length_dw++] = 1; /* y */
> +	ib->ptr[ib->length_dw++] = 1; /* z */
> +	ib->ptr[ib->length_dw++] =
>  		REG_SET_FIELD(0, COMPUTE_DISPATCH_INITIATOR, COMPUTE_SHADER_EN, 1);
>  
>  	/* write CS partial flush packet */
> -	ib.ptr[ib.length_dw++] = PACKET3(PACKET3_EVENT_WRITE, 0);
> -	ib.ptr[ib.length_dw++] = EVENT_TYPE(7) | EVENT_INDEX(4);
> +	ib->ptr[ib->length_dw++] = PACKET3(PACKET3_EVENT_WRITE, 0);
> +	ib->ptr[ib->length_dw++] = EVENT_TYPE(7) | EVENT_INDEX(4);
>  
>  	/* shedule the ib on the ring */
> -	r = amdgpu_ib_schedule(ring, 1, &ib, NULL, &f);
> +	r = amdgpu_job_submit_direct(job, ring, &f);
>  	if (r) {
>  		drm_err(adev_to_drm(adev), "ib submit failed (%d).\n", r);
> +		amdgpu_job_free(job);
>  		goto fail;
>  	}
>  
> @@ -1629,7 +1635,6 @@ static int gfx_v8_0_do_edc_gpr_workarounds(struct amdgpu_device *adev)
>  		RREG32(sec_ded_counter_registers[i]);
>  
>  fail:
> -	amdgpu_ib_free(&ib, NULL);
>  	dma_fence_put(f);
>  
>  	return r;
> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
> index 7e9d753f4a808..36f0300a21bfa 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
> @@ -1224,9 +1224,9 @@ static int gfx_v9_0_ring_test_ring(struct amdgpu_ring *ring)
>  static int gfx_v9_0_ring_test_ib(struct amdgpu_ring *ring, long timeout)
>  {
>  	struct amdgpu_device *adev = ring->adev;
> -	struct amdgpu_ib ib;
> +	struct amdgpu_job *job;
> +	struct amdgpu_ib *ib;
>  	struct dma_fence *f = NULL;
> -
>  	unsigned index;
>  	uint64_t gpu_addr;
>  	uint32_t tmp;
> @@ -1238,22 +1238,26 @@ static int gfx_v9_0_ring_test_ib(struct amdgpu_ring *ring, long timeout)
>  
>  	gpu_addr = adev->wb.gpu_addr + (index * 4);
>  	adev->wb.wb[index] = cpu_to_le32(0xCAFEDEAD);
> -	memset(&ib, 0, sizeof(ib));
>  
> -	r = amdgpu_ib_get(adev, NULL, 20, AMDGPU_IB_POOL_DIRECT, &ib);
> +	r = amdgpu_job_alloc_with_ib(ring->adev, NULL, NULL, 20,
> +				     AMDGPU_IB_POOL_DIRECT, &job,
> +				     AMDGPU_KERNEL_JOB_ID_GFX_RING_TEST);
>  	if (r)
>  		goto err1;
>  
> -	ib.ptr[0] = PACKET3(PACKET3_WRITE_DATA, 3);
> -	ib.ptr[1] = WRITE_DATA_DST_SEL(5) | WR_CONFIRM;
> -	ib.ptr[2] = lower_32_bits(gpu_addr);
> -	ib.ptr[3] = upper_32_bits(gpu_addr);
> -	ib.ptr[4] = 0xDEADBEEF;
> -	ib.length_dw = 5;
> +	ib = &job->ibs[0];
> +	ib->ptr[0] = PACKET3(PACKET3_WRITE_DATA, 3);
> +	ib->ptr[1] = WRITE_DATA_DST_SEL(5) | WR_CONFIRM;
> +	ib->ptr[2] = lower_32_bits(gpu_addr);
> +	ib->ptr[3] = upper_32_bits(gpu_addr);
> +	ib->ptr[4] = 0xDEADBEEF;
> +	ib->length_dw = 5;
>  
> -	r = amdgpu_ib_schedule(ring, 1, &ib, NULL, &f);
> -	if (r)
> +	r = amdgpu_job_submit_direct(job, ring, &f);
> +	if (r) {
> +		amdgpu_job_free(job);
>  		goto err2;
> +	}
>  
>  	r = dma_fence_wait_timeout(f, false, timeout);
>  	if (r == 0) {
> @@ -1270,7 +1274,6 @@ static int gfx_v9_0_ring_test_ib(struct amdgpu_ring *ring, long timeout)
>  		r = -EINVAL;
>  
>  err2:
> -	amdgpu_ib_free(&ib, NULL);
>  	dma_fence_put(f);
>  err1:
>  	amdgpu_device_wb_free(adev, index);
> @@ -4624,7 +4627,8 @@ static int gfx_v9_0_do_edc_gds_workarounds(struct amdgpu_device *adev)
>  static int gfx_v9_0_do_edc_gpr_workarounds(struct amdgpu_device *adev)
>  {
>  	struct amdgpu_ring *ring = &adev->gfx.compute_ring[0];
> -	struct amdgpu_ib ib;
> +	struct amdgpu_job *job;
> +	struct amdgpu_ib *ib;
>  	struct dma_fence *f = NULL;
>  	int r, i;
>  	unsigned total_size, vgpr_offset, sgpr_offset;
> @@ -4670,9 +4674,9 @@ static int gfx_v9_0_do_edc_gpr_workarounds(struct amdgpu_device *adev)
>  	total_size += sizeof(sgpr_init_compute_shader);
>  
>  	/* allocate an indirect buffer to put the commands in */
> -	memset(&ib, 0, sizeof(ib));
> -	r = amdgpu_ib_get(adev, NULL, total_size,
> -					AMDGPU_IB_POOL_DIRECT, &ib);
> +	r = amdgpu_job_alloc_with_ib(ring->adev, NULL, NULL, total_size,
> +				     AMDGPU_IB_POOL_DIRECT, &job,
> +				     AMDGPU_KERNEL_JOB_ID_RUN_SHADER);
>  	if (r) {
>  		drm_err(adev_to_drm(adev), "failed to get ib (%d).\n", r);
>  		return r;
> @@ -4680,102 +4684,103 @@ static int gfx_v9_0_do_edc_gpr_workarounds(struct amdgpu_device *adev)
>  
>  	/* load the compute shaders */
>  	for (i = 0; i < vgpr_init_shader_size/sizeof(u32); i++)
> -		ib.ptr[i + (vgpr_offset / 4)] = vgpr_init_shader_ptr[i];
> +		ib->ptr[i + (vgpr_offset / 4)] = vgpr_init_shader_ptr[i];
>  
>  	for (i = 0; i < ARRAY_SIZE(sgpr_init_compute_shader); i++)
> -		ib.ptr[i + (sgpr_offset / 4)] = sgpr_init_compute_shader[i];
> +		ib->ptr[i + (sgpr_offset / 4)] = sgpr_init_compute_shader[i];
>  
>  	/* init the ib length to 0 */
> -	ib.length_dw = 0;
> +	ib->length_dw = 0;
>  
>  	/* VGPR */
>  	/* write the register state for the compute dispatch */
>  	for (i = 0; i < gpr_reg_size; i++) {
> -		ib.ptr[ib.length_dw++] = PACKET3(PACKET3_SET_SH_REG, 1);
> -		ib.ptr[ib.length_dw++] = SOC15_REG_ENTRY_OFFSET(vgpr_init_regs_ptr[i])
> +		ib->ptr[ib->length_dw++] = PACKET3(PACKET3_SET_SH_REG, 1);
> +		ib->ptr[ib->length_dw++] = SOC15_REG_ENTRY_OFFSET(vgpr_init_regs_ptr[i])
>  								- PACKET3_SET_SH_REG_START;
> -		ib.ptr[ib.length_dw++] = vgpr_init_regs_ptr[i].reg_value;
> +		ib->ptr[ib->length_dw++] = vgpr_init_regs_ptr[i].reg_value;
>  	}
>  	/* write the shader start address: mmCOMPUTE_PGM_LO, mmCOMPUTE_PGM_HI */
> -	gpu_addr = (ib.gpu_addr + (u64)vgpr_offset) >> 8;
> -	ib.ptr[ib.length_dw++] = PACKET3(PACKET3_SET_SH_REG, 2);
> -	ib.ptr[ib.length_dw++] = SOC15_REG_OFFSET(GC, 0, mmCOMPUTE_PGM_LO)
> +	gpu_addr = (ib->gpu_addr + (u64)vgpr_offset) >> 8;
> +	ib->ptr[ib->length_dw++] = PACKET3(PACKET3_SET_SH_REG, 2);
> +	ib->ptr[ib->length_dw++] = SOC15_REG_OFFSET(GC, 0, mmCOMPUTE_PGM_LO)
>  							- PACKET3_SET_SH_REG_START;
> -	ib.ptr[ib.length_dw++] = lower_32_bits(gpu_addr);
> -	ib.ptr[ib.length_dw++] = upper_32_bits(gpu_addr);
> +	ib->ptr[ib->length_dw++] = lower_32_bits(gpu_addr);
> +	ib->ptr[ib->length_dw++] = upper_32_bits(gpu_addr);
>  
>  	/* write dispatch packet */
> -	ib.ptr[ib.length_dw++] = PACKET3(PACKET3_DISPATCH_DIRECT, 3);
> -	ib.ptr[ib.length_dw++] = compute_dim_x * 2; /* x */
> -	ib.ptr[ib.length_dw++] = 1; /* y */
> -	ib.ptr[ib.length_dw++] = 1; /* z */
> -	ib.ptr[ib.length_dw++] =
> +	ib->ptr[ib->length_dw++] = PACKET3(PACKET3_DISPATCH_DIRECT, 3);
> +	ib->ptr[ib->length_dw++] = compute_dim_x * 2; /* x */
> +	ib->ptr[ib->length_dw++] = 1; /* y */
> +	ib->ptr[ib->length_dw++] = 1; /* z */
> +	ib->ptr[ib->length_dw++] =
>  		REG_SET_FIELD(0, COMPUTE_DISPATCH_INITIATOR, COMPUTE_SHADER_EN, 1);
>  
>  	/* write CS partial flush packet */
> -	ib.ptr[ib.length_dw++] = PACKET3(PACKET3_EVENT_WRITE, 0);
> -	ib.ptr[ib.length_dw++] = EVENT_TYPE(7) | EVENT_INDEX(4);
> +	ib->ptr[ib->length_dw++] = PACKET3(PACKET3_EVENT_WRITE, 0);
> +	ib->ptr[ib->length_dw++] = EVENT_TYPE(7) | EVENT_INDEX(4);
>  
>  	/* SGPR1 */
>  	/* write the register state for the compute dispatch */
>  	for (i = 0; i < gpr_reg_size; i++) {
> -		ib.ptr[ib.length_dw++] = PACKET3(PACKET3_SET_SH_REG, 1);
> -		ib.ptr[ib.length_dw++] = SOC15_REG_ENTRY_OFFSET(sgpr1_init_regs[i])
> +		ib->ptr[ib->length_dw++] = PACKET3(PACKET3_SET_SH_REG, 1);
> +		ib->ptr[ib->length_dw++] = SOC15_REG_ENTRY_OFFSET(sgpr1_init_regs[i])
>  								- PACKET3_SET_SH_REG_START;
> -		ib.ptr[ib.length_dw++] = sgpr1_init_regs[i].reg_value;
> +		ib->ptr[ib->length_dw++] = sgpr1_init_regs[i].reg_value;
>  	}
>  	/* write the shader start address: mmCOMPUTE_PGM_LO, mmCOMPUTE_PGM_HI */
> -	gpu_addr = (ib.gpu_addr + (u64)sgpr_offset) >> 8;
> -	ib.ptr[ib.length_dw++] = PACKET3(PACKET3_SET_SH_REG, 2);
> -	ib.ptr[ib.length_dw++] = SOC15_REG_OFFSET(GC, 0, mmCOMPUTE_PGM_LO)
> +	gpu_addr = (ib->gpu_addr + (u64)sgpr_offset) >> 8;
> +	ib->ptr[ib->length_dw++] = PACKET3(PACKET3_SET_SH_REG, 2);
> +	ib->ptr[ib->length_dw++] = SOC15_REG_OFFSET(GC, 0, mmCOMPUTE_PGM_LO)
>  							- PACKET3_SET_SH_REG_START;
> -	ib.ptr[ib.length_dw++] = lower_32_bits(gpu_addr);
> -	ib.ptr[ib.length_dw++] = upper_32_bits(gpu_addr);
> +	ib->ptr[ib->length_dw++] = lower_32_bits(gpu_addr);
> +	ib->ptr[ib->length_dw++] = upper_32_bits(gpu_addr);
>  
>  	/* write dispatch packet */
> -	ib.ptr[ib.length_dw++] = PACKET3(PACKET3_DISPATCH_DIRECT, 3);
> -	ib.ptr[ib.length_dw++] = compute_dim_x / 2 * sgpr_work_group_size; /* x */
> -	ib.ptr[ib.length_dw++] = 1; /* y */
> -	ib.ptr[ib.length_dw++] = 1; /* z */
> -	ib.ptr[ib.length_dw++] =
> +	ib->ptr[ib->length_dw++] = PACKET3(PACKET3_DISPATCH_DIRECT, 3);
> +	ib->ptr[ib->length_dw++] = compute_dim_x / 2 * sgpr_work_group_size; /* x */
> +	ib->ptr[ib->length_dw++] = 1; /* y */
> +	ib->ptr[ib->length_dw++] = 1; /* z */
> +	ib->ptr[ib->length_dw++] =
>  		REG_SET_FIELD(0, COMPUTE_DISPATCH_INITIATOR, COMPUTE_SHADER_EN, 1);
>  
>  	/* write CS partial flush packet */
> -	ib.ptr[ib.length_dw++] = PACKET3(PACKET3_EVENT_WRITE, 0);
> -	ib.ptr[ib.length_dw++] = EVENT_TYPE(7) | EVENT_INDEX(4);
> +	ib->ptr[ib->length_dw++] = PACKET3(PACKET3_EVENT_WRITE, 0);
> +	ib->ptr[ib->length_dw++] = EVENT_TYPE(7) | EVENT_INDEX(4);
>  
>  	/* SGPR2 */
>  	/* write the register state for the compute dispatch */
>  	for (i = 0; i < gpr_reg_size; i++) {
> -		ib.ptr[ib.length_dw++] = PACKET3(PACKET3_SET_SH_REG, 1);
> -		ib.ptr[ib.length_dw++] = SOC15_REG_ENTRY_OFFSET(sgpr2_init_regs[i])
> +		ib->ptr[ib->length_dw++] = PACKET3(PACKET3_SET_SH_REG, 1);
> +		ib->ptr[ib->length_dw++] = SOC15_REG_ENTRY_OFFSET(sgpr2_init_regs[i])
>  								- PACKET3_SET_SH_REG_START;
> -		ib.ptr[ib.length_dw++] = sgpr2_init_regs[i].reg_value;
> +		ib->ptr[ib->length_dw++] = sgpr2_init_regs[i].reg_value;
>  	}
>  	/* write the shader start address: mmCOMPUTE_PGM_LO, mmCOMPUTE_PGM_HI */
> -	gpu_addr = (ib.gpu_addr + (u64)sgpr_offset) >> 8;
> -	ib.ptr[ib.length_dw++] = PACKET3(PACKET3_SET_SH_REG, 2);
> -	ib.ptr[ib.length_dw++] = SOC15_REG_OFFSET(GC, 0, mmCOMPUTE_PGM_LO)
> +	gpu_addr = (ib->gpu_addr + (u64)sgpr_offset) >> 8;
> +	ib->ptr[ib->length_dw++] = PACKET3(PACKET3_SET_SH_REG, 2);
> +	ib->ptr[ib->length_dw++] = SOC15_REG_OFFSET(GC, 0, mmCOMPUTE_PGM_LO)
>  							- PACKET3_SET_SH_REG_START;
> -	ib.ptr[ib.length_dw++] = lower_32_bits(gpu_addr);
> -	ib.ptr[ib.length_dw++] = upper_32_bits(gpu_addr);
> +	ib->ptr[ib->length_dw++] = lower_32_bits(gpu_addr);
> +	ib->ptr[ib->length_dw++] = upper_32_bits(gpu_addr);
>  
>  	/* write dispatch packet */
> -	ib.ptr[ib.length_dw++] = PACKET3(PACKET3_DISPATCH_DIRECT, 3);
> -	ib.ptr[ib.length_dw++] = compute_dim_x / 2 * sgpr_work_group_size; /* x */
> -	ib.ptr[ib.length_dw++] = 1; /* y */
> -	ib.ptr[ib.length_dw++] = 1; /* z */
> -	ib.ptr[ib.length_dw++] =
> +	ib->ptr[ib->length_dw++] = PACKET3(PACKET3_DISPATCH_DIRECT, 3);
> +	ib->ptr[ib->length_dw++] = compute_dim_x / 2 * sgpr_work_group_size; /* x */
> +	ib->ptr[ib->length_dw++] = 1; /* y */
> +	ib->ptr[ib->length_dw++] = 1; /* z */
> +	ib->ptr[ib->length_dw++] =
>  		REG_SET_FIELD(0, COMPUTE_DISPATCH_INITIATOR, COMPUTE_SHADER_EN, 1);
>  
>  	/* write CS partial flush packet */
> -	ib.ptr[ib.length_dw++] = PACKET3(PACKET3_EVENT_WRITE, 0);
> -	ib.ptr[ib.length_dw++] = EVENT_TYPE(7) | EVENT_INDEX(4);
> +	ib->ptr[ib->length_dw++] = PACKET3(PACKET3_EVENT_WRITE, 0);
> +	ib->ptr[ib->length_dw++] = EVENT_TYPE(7) | EVENT_INDEX(4);
>  
>  	/* shedule the ib on the ring */
> -	r = amdgpu_ib_schedule(ring, 1, &ib, NULL, &f);
> +	r = amdgpu_job_submit_direct(job, ring, &f);
>  	if (r) {
>  		drm_err(adev_to_drm(adev), "ib schedule failed (%d).\n", r);
> +		amdgpu_job_free(job);
>  		goto fail;
>  	}
>  
> @@ -4787,7 +4792,6 @@ static int gfx_v9_0_do_edc_gpr_workarounds(struct amdgpu_device *adev)
>  	}
>  
>  fail:
> -	amdgpu_ib_free(&ib, NULL);
>  	dma_fence_put(f);
>  
>  	return r;
> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_2.c b/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_2.c
> index 8058ea91ecafd..424b05b84ea74 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_2.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_2.c
> @@ -345,12 +345,13 @@ const struct soc15_reg_entry sgpr64_init_regs_aldebaran[] = {
>  
>  static int gfx_v9_4_2_run_shader(struct amdgpu_device *adev,
>  				 struct amdgpu_ring *ring,
> -				 struct amdgpu_ib *ib,
>  				 const u32 *shader_ptr, u32 shader_size,
>  				 const struct soc15_reg_entry *init_regs, u32 regs_size,
>  				 u32 compute_dim_x, u64 wb_gpu_addr, u32 pattern,
>  				 struct dma_fence **fence_ptr)
>  {
> +	struct amdgpu_job *job;
> +	struct amdgpu_ib *ib;
>  	int r, i;
>  	uint32_t total_size, shader_offset;
>  	u64 gpu_addr;
> @@ -360,10 +361,9 @@ static int gfx_v9_4_2_run_shader(struct amdgpu_device *adev,
>  	shader_offset = total_size;
>  	total_size += ALIGN(shader_size, 256);
>  
> -	/* allocate an indirect buffer to put the commands in */
> -	memset(ib, 0, sizeof(*ib));
> -	r = amdgpu_ib_get(adev, NULL, total_size,
> -					AMDGPU_IB_POOL_DIRECT, ib);
> +	r = amdgpu_job_alloc_with_ib(ring->adev, NULL, NULL, total_size,
> +				     AMDGPU_IB_POOL_DIRECT, &job,
> +				     AMDGPU_KERNEL_JOB_ID_RUN_SHADER);
>  	if (r) {
>  		dev_err(adev->dev, "failed to get ib (%d).\n", r);
>  		return r;
> @@ -408,11 +408,11 @@ static int gfx_v9_4_2_run_shader(struct amdgpu_device *adev,
>  	ib->ptr[ib->length_dw++] =
>  		REG_SET_FIELD(0, COMPUTE_DISPATCH_INITIATOR, COMPUTE_SHADER_EN, 1);
>  
> -	/* shedule the ib on the ring */
> -	r = amdgpu_ib_schedule(ring, 1, ib, NULL, fence_ptr);
> +	/* schedule the ib on the ring */
> +	r = amdgpu_job_submit_direct(job, ring, fence_ptr);
>  	if (r) {
>  		dev_err(adev->dev, "ib submit failed (%d).\n", r);
> -		amdgpu_ib_free(ib, NULL);
> +		amdgpu_job_free(job);
>  	}
>  	return r;
>  }
> @@ -493,7 +493,6 @@ static int gfx_v9_4_2_do_sgprs_init(struct amdgpu_device *adev)
>  	int wb_size = adev->gfx.config.max_shader_engines *
>  			 CU_ID_MAX * SIMD_ID_MAX * WAVE_ID_MAX;
>  	struct amdgpu_ib wb_ib;
> -	struct amdgpu_ib disp_ibs[3];
>  	struct dma_fence *fences[3];
>  	u32 pattern[3] = { 0x1, 0x5, 0xa };
>  
> @@ -514,7 +513,6 @@ static int gfx_v9_4_2_do_sgprs_init(struct amdgpu_device *adev)
>  
>  	r = gfx_v9_4_2_run_shader(adev,
>  			&adev->gfx.compute_ring[0],
> -			&disp_ibs[0],
>  			sgpr112_init_compute_shader_aldebaran,
>  			sizeof(sgpr112_init_compute_shader_aldebaran),
>  			sgpr112_init_regs_aldebaran,
> @@ -539,7 +537,6 @@ static int gfx_v9_4_2_do_sgprs_init(struct amdgpu_device *adev)
>  
>  	r = gfx_v9_4_2_run_shader(adev,
>  			&adev->gfx.compute_ring[1],
> -			&disp_ibs[1],
>  			sgpr96_init_compute_shader_aldebaran,
>  			sizeof(sgpr96_init_compute_shader_aldebaran),
>  			sgpr96_init_regs_aldebaran,
> @@ -579,7 +576,6 @@ static int gfx_v9_4_2_do_sgprs_init(struct amdgpu_device *adev)
>  	memset(wb_ib.ptr, 0, (1 + wb_size) * sizeof(uint32_t));
>  	r = gfx_v9_4_2_run_shader(adev,
>  			&adev->gfx.compute_ring[0],
> -			&disp_ibs[2],
>  			sgpr64_init_compute_shader_aldebaran,
>  			sizeof(sgpr64_init_compute_shader_aldebaran),
>  			sgpr64_init_regs_aldebaran,
> @@ -611,13 +607,10 @@ static int gfx_v9_4_2_do_sgprs_init(struct amdgpu_device *adev)
>  	}
>  
>  disp2_failed:
> -	amdgpu_ib_free(&disp_ibs[2], NULL);
>  	dma_fence_put(fences[2]);
>  disp1_failed:
> -	amdgpu_ib_free(&disp_ibs[1], NULL);
>  	dma_fence_put(fences[1]);
>  disp0_failed:
> -	amdgpu_ib_free(&disp_ibs[0], NULL);
>  	dma_fence_put(fences[0]);
>  pro_end:
>  	amdgpu_ib_free(&wb_ib, NULL);
> @@ -637,7 +630,6 @@ static int gfx_v9_4_2_do_vgprs_init(struct amdgpu_device *adev)
>  	int wb_size = adev->gfx.config.max_shader_engines *
>  			 CU_ID_MAX * SIMD_ID_MAX * WAVE_ID_MAX;
>  	struct amdgpu_ib wb_ib;
> -	struct amdgpu_ib disp_ib;
>  	struct dma_fence *fence;
>  	u32 pattern = 0xa;
>  
> @@ -657,7 +649,6 @@ static int gfx_v9_4_2_do_vgprs_init(struct amdgpu_device *adev)
>  
>  	r = gfx_v9_4_2_run_shader(adev,
>  			&adev->gfx.compute_ring[0],
> -			&disp_ib,
>  			vgpr_init_compute_shader_aldebaran,
>  			sizeof(vgpr_init_compute_shader_aldebaran),
>  			vgpr_init_regs_aldebaran,
> @@ -687,7 +678,6 @@ static int gfx_v9_4_2_do_vgprs_init(struct amdgpu_device *adev)
>  	}
>  
>  disp_failed:
> -	amdgpu_ib_free(&disp_ib, NULL);
>  	dma_fence_put(fence);
>  pro_end:
>  	amdgpu_ib_free(&wb_ib, NULL);
> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c b/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
> index ad4d442e7345e..d78b2c2ae13a3 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
> @@ -451,9 +451,9 @@ static int gfx_v9_4_3_ring_test_ring(struct amdgpu_ring *ring)
>  static int gfx_v9_4_3_ring_test_ib(struct amdgpu_ring *ring, long timeout)
>  {
>  	struct amdgpu_device *adev = ring->adev;
> -	struct amdgpu_ib ib;
> +	struct amdgpu_job *job;
> +	struct amdgpu_ib *ib;
>  	struct dma_fence *f = NULL;
> -
>  	unsigned index;
>  	uint64_t gpu_addr;
>  	uint32_t tmp;
> @@ -465,22 +465,26 @@ static int gfx_v9_4_3_ring_test_ib(struct amdgpu_ring *ring, long timeout)
>  
>  	gpu_addr = adev->wb.gpu_addr + (index * 4);
>  	adev->wb.wb[index] = cpu_to_le32(0xCAFEDEAD);
> -	memset(&ib, 0, sizeof(ib));
>  
> -	r = amdgpu_ib_get(adev, NULL, 20, AMDGPU_IB_POOL_DIRECT, &ib);
> +	r = amdgpu_job_alloc_with_ib(ring->adev, NULL, NULL, 20,
> +				     AMDGPU_IB_POOL_DIRECT, &job,
> +				     AMDGPU_KERNEL_JOB_ID_GFX_RING_TEST);
>  	if (r)
>  		goto err1;
>  
> -	ib.ptr[0] = PACKET3(PACKET3_WRITE_DATA, 3);
> -	ib.ptr[1] = WRITE_DATA_DST_SEL(5) | WR_CONFIRM;
> -	ib.ptr[2] = lower_32_bits(gpu_addr);
> -	ib.ptr[3] = upper_32_bits(gpu_addr);
> -	ib.ptr[4] = 0xDEADBEEF;
> -	ib.length_dw = 5;
> +	ib = &job->ibs[0];
> +	ib->ptr[0] = PACKET3(PACKET3_WRITE_DATA, 3);
> +	ib->ptr[1] = WRITE_DATA_DST_SEL(5) | WR_CONFIRM;
> +	ib->ptr[2] = lower_32_bits(gpu_addr);
> +	ib->ptr[3] = upper_32_bits(gpu_addr);
> +	ib->ptr[4] = 0xDEADBEEF;
> +	ib->length_dw = 5;
>  
> -	r = amdgpu_ib_schedule(ring, 1, &ib, NULL, &f);
> -	if (r)
> +	r = amdgpu_job_submit_direct(job, ring, &f);
> +	if (r) {
> +		amdgpu_job_free(job);
>  		goto err2;
> +	}
>  
>  	r = dma_fence_wait_timeout(f, false, timeout);
>  	if (r == 0) {
> @@ -497,7 +501,6 @@ static int gfx_v9_4_3_ring_test_ib(struct amdgpu_ring *ring, long timeout)
>  		r = -EINVAL;
>  
>  err2:
> -	amdgpu_ib_free(&ib, NULL);
>  	dma_fence_put(f);
>  err1:
>  	amdgpu_device_wb_free(adev, index);
> diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v2_4.c b/drivers/gpu/drm/amd/amdgpu/sdma_v2_4.c
> index 92ce580647cdc..46263d50cc9ef 100644
> --- a/drivers/gpu/drm/amd/amdgpu/sdma_v2_4.c
> +++ b/drivers/gpu/drm/amd/amdgpu/sdma_v2_4.c
> @@ -584,7 +584,8 @@ static int sdma_v2_4_ring_test_ring(struct amdgpu_ring *ring)
>  static int sdma_v2_4_ring_test_ib(struct amdgpu_ring *ring, long timeout)
>  {
>  	struct amdgpu_device *adev = ring->adev;
> -	struct amdgpu_ib ib;
> +	struct amdgpu_job *job;
> +	struct amdgpu_ib *ib;
>  	struct dma_fence *f = NULL;
>  	unsigned index;
>  	u32 tmp = 0;
> @@ -598,26 +599,30 @@ static int sdma_v2_4_ring_test_ib(struct amdgpu_ring *ring, long timeout)
>  	gpu_addr = adev->wb.gpu_addr + (index * 4);
>  	tmp = 0xCAFEDEAD;
>  	adev->wb.wb[index] = cpu_to_le32(tmp);
> -	memset(&ib, 0, sizeof(ib));
> -	r = amdgpu_ib_get(adev, NULL, 256,
> -					AMDGPU_IB_POOL_DIRECT, &ib);
> +
> +	r = amdgpu_job_alloc_with_ib(ring->adev, NULL, NULL, 256,
> +				     AMDGPU_IB_POOL_DIRECT, &job,
> +				     AMDGPU_KERNEL_JOB_ID_SDMA_RING_TEST);
>  	if (r)
>  		goto err0;
>  
> -	ib.ptr[0] = SDMA_PKT_HEADER_OP(SDMA_OP_WRITE) |
> +	ib = &job->ibs[0];
> +	ib->ptr[0] = SDMA_PKT_HEADER_OP(SDMA_OP_WRITE) |
>  		SDMA_PKT_HEADER_SUB_OP(SDMA_SUBOP_WRITE_LINEAR);
> -	ib.ptr[1] = lower_32_bits(gpu_addr);
> -	ib.ptr[2] = upper_32_bits(gpu_addr);
> -	ib.ptr[3] = SDMA_PKT_WRITE_UNTILED_DW_3_COUNT(1);
> -	ib.ptr[4] = 0xDEADBEEF;
> -	ib.ptr[5] = SDMA_PKT_HEADER_OP(SDMA_OP_NOP);
> -	ib.ptr[6] = SDMA_PKT_HEADER_OP(SDMA_OP_NOP);
> -	ib.ptr[7] = SDMA_PKT_HEADER_OP(SDMA_OP_NOP);
> -	ib.length_dw = 8;
> -
> -	r = amdgpu_ib_schedule(ring, 1, &ib, NULL, &f);
> -	if (r)
> +	ib->ptr[1] = lower_32_bits(gpu_addr);
> +	ib->ptr[2] = upper_32_bits(gpu_addr);
> +	ib->ptr[3] = SDMA_PKT_WRITE_UNTILED_DW_3_COUNT(1);
> +	ib->ptr[4] = 0xDEADBEEF;
> +	ib->ptr[5] = SDMA_PKT_HEADER_OP(SDMA_OP_NOP);
> +	ib->ptr[6] = SDMA_PKT_HEADER_OP(SDMA_OP_NOP);
> +	ib->ptr[7] = SDMA_PKT_HEADER_OP(SDMA_OP_NOP);
> +	ib->length_dw = 8;
> +
> +	r = amdgpu_job_submit_direct(job, ring, &f);
> +	if (r) {
> +		amdgpu_job_free(job);
>  		goto err1;
> +	}
>  
>  	r = dma_fence_wait_timeout(f, false, timeout);
>  	if (r == 0) {
> @@ -633,7 +638,6 @@ static int sdma_v2_4_ring_test_ib(struct amdgpu_ring *ring, long timeout)
>  		r = -EINVAL;
>  
>  err1:
> -	amdgpu_ib_free(&ib, NULL);
>  	dma_fence_put(f);
>  err0:
>  	amdgpu_device_wb_free(adev, index);
> diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v3_0.c b/drivers/gpu/drm/amd/amdgpu/sdma_v3_0.c
> index 1c076bd1cf73e..f9f05768072ad 100644
> --- a/drivers/gpu/drm/amd/amdgpu/sdma_v3_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/sdma_v3_0.c
> @@ -858,7 +858,8 @@ static int sdma_v3_0_ring_test_ring(struct amdgpu_ring *ring)
>  static int sdma_v3_0_ring_test_ib(struct amdgpu_ring *ring, long timeout)
>  {
>  	struct amdgpu_device *adev = ring->adev;
> -	struct amdgpu_ib ib;
> +	struct amdgpu_job *job;
> +	struct amdgpu_ib *ib;
>  	struct dma_fence *f = NULL;
>  	unsigned index;
>  	u32 tmp = 0;
> @@ -872,26 +873,30 @@ static int sdma_v3_0_ring_test_ib(struct amdgpu_ring *ring, long timeout)
>  	gpu_addr = adev->wb.gpu_addr + (index * 4);
>  	tmp = 0xCAFEDEAD;
>  	adev->wb.wb[index] = cpu_to_le32(tmp);
> -	memset(&ib, 0, sizeof(ib));
> -	r = amdgpu_ib_get(adev, NULL, 256,
> -					AMDGPU_IB_POOL_DIRECT, &ib);
> +
> +	r = amdgpu_job_alloc_with_ib(ring->adev, NULL, NULL, 256,
> +				     AMDGPU_IB_POOL_DIRECT, &job,
> +				     AMDGPU_KERNEL_JOB_ID_SDMA_RING_TEST);
>  	if (r)
>  		goto err0;
>  
> -	ib.ptr[0] = SDMA_PKT_HEADER_OP(SDMA_OP_WRITE) |
> +	ib = &job->ibs[0];
> +	ib->ptr[0] = SDMA_PKT_HEADER_OP(SDMA_OP_WRITE) |
>  		SDMA_PKT_HEADER_SUB_OP(SDMA_SUBOP_WRITE_LINEAR);
> -	ib.ptr[1] = lower_32_bits(gpu_addr);
> -	ib.ptr[2] = upper_32_bits(gpu_addr);
> -	ib.ptr[3] = SDMA_PKT_WRITE_UNTILED_DW_3_COUNT(1);
> -	ib.ptr[4] = 0xDEADBEEF;
> -	ib.ptr[5] = SDMA_PKT_NOP_HEADER_OP(SDMA_OP_NOP);
> -	ib.ptr[6] = SDMA_PKT_NOP_HEADER_OP(SDMA_OP_NOP);
> -	ib.ptr[7] = SDMA_PKT_NOP_HEADER_OP(SDMA_OP_NOP);
> -	ib.length_dw = 8;
> -
> -	r = amdgpu_ib_schedule(ring, 1, &ib, NULL, &f);
> -	if (r)
> +	ib->ptr[1] = lower_32_bits(gpu_addr);
> +	ib->ptr[2] = upper_32_bits(gpu_addr);
> +	ib->ptr[3] = SDMA_PKT_WRITE_UNTILED_DW_3_COUNT(1);
> +	ib->ptr[4] = 0xDEADBEEF;
> +	ib->ptr[5] = SDMA_PKT_NOP_HEADER_OP(SDMA_OP_NOP);
> +	ib->ptr[6] = SDMA_PKT_NOP_HEADER_OP(SDMA_OP_NOP);
> +	ib->ptr[7] = SDMA_PKT_NOP_HEADER_OP(SDMA_OP_NOP);
> +	ib->length_dw = 8;
> +
> +	r = amdgpu_job_submit_direct(job, ring, &f);
> +	if (r) {
> +		amdgpu_job_free(job);
>  		goto err1;
> +	}
>  
>  	r = dma_fence_wait_timeout(f, false, timeout);
>  	if (r == 0) {
> @@ -906,7 +911,6 @@ static int sdma_v3_0_ring_test_ib(struct amdgpu_ring *ring, long timeout)
>  	else
>  		r = -EINVAL;
>  err1:
> -	amdgpu_ib_free(&ib, NULL);
>  	dma_fence_put(f);
>  err0:
>  	amdgpu_device_wb_free(adev, index);
> diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c b/drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c
> index f38004e6064e5..56d2832ccba2d 100644
> --- a/drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c
> @@ -1516,7 +1516,8 @@ static int sdma_v4_0_ring_test_ring(struct amdgpu_ring *ring)
>  static int sdma_v4_0_ring_test_ib(struct amdgpu_ring *ring, long timeout)
>  {
>  	struct amdgpu_device *adev = ring->adev;
> -	struct amdgpu_ib ib;
> +	struct amdgpu_job *job;
> +	struct amdgpu_ib *ib;
>  	struct dma_fence *f = NULL;
>  	unsigned index;
>  	long r;
> @@ -1530,26 +1531,30 @@ static int sdma_v4_0_ring_test_ib(struct amdgpu_ring *ring, long timeout)
>  	gpu_addr = adev->wb.gpu_addr + (index * 4);
>  	tmp = 0xCAFEDEAD;
>  	adev->wb.wb[index] = cpu_to_le32(tmp);
> -	memset(&ib, 0, sizeof(ib));
> -	r = amdgpu_ib_get(adev, NULL, 256,
> -					AMDGPU_IB_POOL_DIRECT, &ib);
> +
> +	r = amdgpu_job_alloc_with_ib(ring->adev, NULL, NULL, 256,
> +				     AMDGPU_IB_POOL_DIRECT, &job,
> +				     AMDGPU_KERNEL_JOB_ID_SDMA_RING_TEST);
>  	if (r)
>  		goto err0;
>  
> -	ib.ptr[0] = SDMA_PKT_HEADER_OP(SDMA_OP_WRITE) |
> +	ib = &job->ibs[0];
> +	ib->ptr[0] = SDMA_PKT_HEADER_OP(SDMA_OP_WRITE) |
>  		SDMA_PKT_HEADER_SUB_OP(SDMA_SUBOP_WRITE_LINEAR);
> -	ib.ptr[1] = lower_32_bits(gpu_addr);
> -	ib.ptr[2] = upper_32_bits(gpu_addr);
> -	ib.ptr[3] = SDMA_PKT_WRITE_UNTILED_DW_3_COUNT(0);
> -	ib.ptr[4] = 0xDEADBEEF;
> -	ib.ptr[5] = SDMA_PKT_NOP_HEADER_OP(SDMA_OP_NOP);
> -	ib.ptr[6] = SDMA_PKT_NOP_HEADER_OP(SDMA_OP_NOP);
> -	ib.ptr[7] = SDMA_PKT_NOP_HEADER_OP(SDMA_OP_NOP);
> -	ib.length_dw = 8;
> -
> -	r = amdgpu_ib_schedule(ring, 1, &ib, NULL, &f);
> -	if (r)
> +	ib->ptr[1] = lower_32_bits(gpu_addr);
> +	ib->ptr[2] = upper_32_bits(gpu_addr);
> +	ib->ptr[3] = SDMA_PKT_WRITE_UNTILED_DW_3_COUNT(0);
> +	ib->ptr[4] = 0xDEADBEEF;
> +	ib->ptr[5] = SDMA_PKT_NOP_HEADER_OP(SDMA_OP_NOP);
> +	ib->ptr[6] = SDMA_PKT_NOP_HEADER_OP(SDMA_OP_NOP);
> +	ib->ptr[7] = SDMA_PKT_NOP_HEADER_OP(SDMA_OP_NOP);
> +	ib->length_dw = 8;
> +
> +	r = amdgpu_job_submit_direct(job, ring, &f);
> +	if (r) {
> +		amdgpu_job_free(job);
>  		goto err1;
> +	}
>  
>  	r = dma_fence_wait_timeout(f, false, timeout);
>  	if (r == 0) {
> @@ -1565,7 +1570,6 @@ static int sdma_v4_0_ring_test_ib(struct amdgpu_ring *ring, long timeout)
>  		r = -EINVAL;
>  
>  err1:
> -	amdgpu_ib_free(&ib, NULL);
>  	dma_fence_put(f);
>  err0:
>  	amdgpu_device_wb_free(adev, index);
> diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c b/drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c
> index a1443990d5c60..dd8d6a572710d 100644
> --- a/drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c
> +++ b/drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c
> @@ -1112,7 +1112,8 @@ static int sdma_v4_4_2_ring_test_ring(struct amdgpu_ring *ring)
>  static int sdma_v4_4_2_ring_test_ib(struct amdgpu_ring *ring, long timeout)
>  {
>  	struct amdgpu_device *adev = ring->adev;
> -	struct amdgpu_ib ib;
> +	struct amdgpu_job *job;
> +	struct amdgpu_ib *ib;
>  	struct dma_fence *f = NULL;
>  	unsigned index;
>  	long r;
> @@ -1126,26 +1127,30 @@ static int sdma_v4_4_2_ring_test_ib(struct amdgpu_ring *ring, long timeout)
>  	gpu_addr = adev->wb.gpu_addr + (index * 4);
>  	tmp = 0xCAFEDEAD;
>  	adev->wb.wb[index] = cpu_to_le32(tmp);
> -	memset(&ib, 0, sizeof(ib));
> -	r = amdgpu_ib_get(adev, NULL, 256,
> -					AMDGPU_IB_POOL_DIRECT, &ib);
> +
> +	r = amdgpu_job_alloc_with_ib(ring->adev, NULL, NULL, 256,
> +				     AMDGPU_IB_POOL_DIRECT, &job,
> +				     AMDGPU_KERNEL_JOB_ID_SDMA_RING_TEST);
>  	if (r)
>  		goto err0;
>  
> -	ib.ptr[0] = SDMA_PKT_HEADER_OP(SDMA_OP_WRITE) |
> +	ib = &job->ibs[0];
> +	ib->ptr[0] = SDMA_PKT_HEADER_OP(SDMA_OP_WRITE) |
>  		SDMA_PKT_HEADER_SUB_OP(SDMA_SUBOP_WRITE_LINEAR);
> -	ib.ptr[1] = lower_32_bits(gpu_addr);
> -	ib.ptr[2] = upper_32_bits(gpu_addr);
> -	ib.ptr[3] = SDMA_PKT_WRITE_UNTILED_DW_3_COUNT(0);
> -	ib.ptr[4] = 0xDEADBEEF;
> -	ib.ptr[5] = SDMA_PKT_NOP_HEADER_OP(SDMA_OP_NOP);
> -	ib.ptr[6] = SDMA_PKT_NOP_HEADER_OP(SDMA_OP_NOP);
> -	ib.ptr[7] = SDMA_PKT_NOP_HEADER_OP(SDMA_OP_NOP);
> -	ib.length_dw = 8;
> -
> -	r = amdgpu_ib_schedule(ring, 1, &ib, NULL, &f);
> -	if (r)
> +	ib->ptr[1] = lower_32_bits(gpu_addr);
> +	ib->ptr[2] = upper_32_bits(gpu_addr);
> +	ib->ptr[3] = SDMA_PKT_WRITE_UNTILED_DW_3_COUNT(0);
> +	ib->ptr[4] = 0xDEADBEEF;
> +	ib->ptr[5] = SDMA_PKT_NOP_HEADER_OP(SDMA_OP_NOP);
> +	ib->ptr[6] = SDMA_PKT_NOP_HEADER_OP(SDMA_OP_NOP);
> +	ib->ptr[7] = SDMA_PKT_NOP_HEADER_OP(SDMA_OP_NOP);
> +	ib->length_dw = 8;
> +
> +	r = amdgpu_job_submit_direct(job, ring, &f);
> +	if (r) {
> +		amdgpu_job_free(job);
>  		goto err1;
> +	}
>  
>  	r = dma_fence_wait_timeout(f, false, timeout);
>  	if (r == 0) {
> @@ -1161,7 +1166,6 @@ static int sdma_v4_4_2_ring_test_ib(struct amdgpu_ring *ring, long timeout)
>  		r = -EINVAL;
>  
>  err1:
> -	amdgpu_ib_free(&ib, NULL);
>  	dma_fence_put(f);
>  err0:
>  	amdgpu_device_wb_free(adev, index);
> diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c b/drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c
> index 7811cbb1f7ba3..786f1776fa30d 100644
> --- a/drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c
> @@ -1074,7 +1074,8 @@ static int sdma_v5_0_ring_test_ring(struct amdgpu_ring *ring)
>  static int sdma_v5_0_ring_test_ib(struct amdgpu_ring *ring, long timeout)
>  {
>  	struct amdgpu_device *adev = ring->adev;
> -	struct amdgpu_ib ib;
> +	struct amdgpu_job *job;
> +	struct amdgpu_ib *ib;
>  	struct dma_fence *f = NULL;
>  	unsigned index;
>  	long r;
> @@ -1082,7 +1083,6 @@ static int sdma_v5_0_ring_test_ib(struct amdgpu_ring *ring, long timeout)
>  	u64 gpu_addr;
>  
>  	tmp = 0xCAFEDEAD;
> -	memset(&ib, 0, sizeof(ib));
>  
>  	r = amdgpu_device_wb_get(adev, &index);
>  	if (r) {
> @@ -1093,27 +1093,31 @@ static int sdma_v5_0_ring_test_ib(struct amdgpu_ring *ring, long timeout)
>  	gpu_addr = adev->wb.gpu_addr + (index * 4);
>  	adev->wb.wb[index] = cpu_to_le32(tmp);
>  
> -	r = amdgpu_ib_get(adev, NULL, 256,
> -			  AMDGPU_IB_POOL_DIRECT, &ib);
> +	r = amdgpu_job_alloc_with_ib(ring->adev, NULL, NULL, 256,
> +				     AMDGPU_IB_POOL_DIRECT, &job,
> +				     AMDGPU_KERNEL_JOB_ID_SDMA_RING_TEST);
>  	if (r) {
>  		drm_err(adev_to_drm(adev), "failed to get ib (%ld).\n", r);
>  		goto err0;
>  	}
>  
> -	ib.ptr[0] = SDMA_PKT_HEADER_OP(SDMA_OP_WRITE) |
> +	ib = &job->ibs[0];
> +	ib->ptr[0] = SDMA_PKT_HEADER_OP(SDMA_OP_WRITE) |
>  		SDMA_PKT_HEADER_SUB_OP(SDMA_SUBOP_WRITE_LINEAR);
> -	ib.ptr[1] = lower_32_bits(gpu_addr);
> -	ib.ptr[2] = upper_32_bits(gpu_addr);
> -	ib.ptr[3] = SDMA_PKT_WRITE_UNTILED_DW_3_COUNT(0);
> -	ib.ptr[4] = 0xDEADBEEF;
> -	ib.ptr[5] = SDMA_PKT_NOP_HEADER_OP(SDMA_OP_NOP);
> -	ib.ptr[6] = SDMA_PKT_NOP_HEADER_OP(SDMA_OP_NOP);
> -	ib.ptr[7] = SDMA_PKT_NOP_HEADER_OP(SDMA_OP_NOP);
> -	ib.length_dw = 8;
> -
> -	r = amdgpu_ib_schedule(ring, 1, &ib, NULL, &f);
> -	if (r)
> +	ib->ptr[1] = lower_32_bits(gpu_addr);
> +	ib->ptr[2] = upper_32_bits(gpu_addr);
> +	ib->ptr[3] = SDMA_PKT_WRITE_UNTILED_DW_3_COUNT(0);
> +	ib->ptr[4] = 0xDEADBEEF;
> +	ib->ptr[5] = SDMA_PKT_NOP_HEADER_OP(SDMA_OP_NOP);
> +	ib->ptr[6] = SDMA_PKT_NOP_HEADER_OP(SDMA_OP_NOP);
> +	ib->ptr[7] = SDMA_PKT_NOP_HEADER_OP(SDMA_OP_NOP);
> +	ib->length_dw = 8;
> +
> +	r = amdgpu_job_submit_direct(job, ring, &f);
> +	if (r) {
> +		amdgpu_job_free(job);
>  		goto err1;
> +	}
>  
>  	r = dma_fence_wait_timeout(f, false, timeout);
>  	if (r == 0) {
> @@ -1133,7 +1137,6 @@ static int sdma_v5_0_ring_test_ib(struct amdgpu_ring *ring, long timeout)
>  		r = -EINVAL;
>  
>  err1:
> -	amdgpu_ib_free(&ib, NULL);
>  	dma_fence_put(f);
>  err0:
>  	amdgpu_device_wb_free(adev, index);
> diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c b/drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c
> index dbe5b8f109f6a..49005b96aa3f2 100644
> --- a/drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c
> +++ b/drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c
> @@ -974,7 +974,8 @@ static int sdma_v5_2_ring_test_ring(struct amdgpu_ring *ring)
>  static int sdma_v5_2_ring_test_ib(struct amdgpu_ring *ring, long timeout)
>  {
>  	struct amdgpu_device *adev = ring->adev;
> -	struct amdgpu_ib ib;
> +	struct amdgpu_job *job;
> +	struct amdgpu_ib *ib;
>  	struct dma_fence *f = NULL;
>  	unsigned index;
>  	long r;
> @@ -982,7 +983,6 @@ static int sdma_v5_2_ring_test_ib(struct amdgpu_ring *ring, long timeout)
>  	u64 gpu_addr;
>  
>  	tmp = 0xCAFEDEAD;
> -	memset(&ib, 0, sizeof(ib));
>  
>  	r = amdgpu_device_wb_get(adev, &index);
>  	if (r) {
> @@ -993,26 +993,31 @@ static int sdma_v5_2_ring_test_ib(struct amdgpu_ring *ring, long timeout)
>  	gpu_addr = adev->wb.gpu_addr + (index * 4);
>  	adev->wb.wb[index] = cpu_to_le32(tmp);
>  
> -	r = amdgpu_ib_get(adev, NULL, 256, AMDGPU_IB_POOL_DIRECT, &ib);
> +	r = amdgpu_job_alloc_with_ib(ring->adev, NULL, NULL, 256,
> +				     AMDGPU_IB_POOL_DIRECT, &job,
> +				     AMDGPU_KERNEL_JOB_ID_SDMA_RING_TEST);
>  	if (r) {
>  		drm_err(adev_to_drm(adev), "failed to get ib (%ld).\n", r);
>  		goto err0;
>  	}
>  
> -	ib.ptr[0] = SDMA_PKT_HEADER_OP(SDMA_OP_WRITE) |
> +	ib = &job->ibs[0];
> +	ib->ptr[0] = SDMA_PKT_HEADER_OP(SDMA_OP_WRITE) |
>  		SDMA_PKT_HEADER_SUB_OP(SDMA_SUBOP_WRITE_LINEAR);
> -	ib.ptr[1] = lower_32_bits(gpu_addr);
> -	ib.ptr[2] = upper_32_bits(gpu_addr);
> -	ib.ptr[3] = SDMA_PKT_WRITE_UNTILED_DW_3_COUNT(0);
> -	ib.ptr[4] = 0xDEADBEEF;
> -	ib.ptr[5] = SDMA_PKT_NOP_HEADER_OP(SDMA_OP_NOP);
> -	ib.ptr[6] = SDMA_PKT_NOP_HEADER_OP(SDMA_OP_NOP);
> -	ib.ptr[7] = SDMA_PKT_NOP_HEADER_OP(SDMA_OP_NOP);
> -	ib.length_dw = 8;
> -
> -	r = amdgpu_ib_schedule(ring, 1, &ib, NULL, &f);
> -	if (r)
> +	ib->ptr[1] = lower_32_bits(gpu_addr);
> +	ib->ptr[2] = upper_32_bits(gpu_addr);
> +	ib->ptr[3] = SDMA_PKT_WRITE_UNTILED_DW_3_COUNT(0);
> +	ib->ptr[4] = 0xDEADBEEF;
> +	ib->ptr[5] = SDMA_PKT_NOP_HEADER_OP(SDMA_OP_NOP);
> +	ib->ptr[6] = SDMA_PKT_NOP_HEADER_OP(SDMA_OP_NOP);
> +	ib->ptr[7] = SDMA_PKT_NOP_HEADER_OP(SDMA_OP_NOP);
> +	ib->length_dw = 8;
> +
> +	r = amdgpu_job_submit_direct(job, ring, &f);
> +	if (r) {
> +		amdgpu_job_free(job);
>  		goto err1;
> +	}
>  
>  	r = dma_fence_wait_timeout(f, false, timeout);
>  	if (r == 0) {
> @@ -1032,7 +1037,6 @@ static int sdma_v5_2_ring_test_ib(struct amdgpu_ring *ring, long timeout)
>  		r = -EINVAL;
>  
>  err1:
> -	amdgpu_ib_free(&ib, NULL);
>  	dma_fence_put(f);
>  err0:
>  	amdgpu_device_wb_free(adev, index);
> diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c b/drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c
> index eec659194718d..210ea6ba6212f 100644
> --- a/drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c
> @@ -981,7 +981,8 @@ static int sdma_v6_0_ring_test_ring(struct amdgpu_ring *ring)
>  static int sdma_v6_0_ring_test_ib(struct amdgpu_ring *ring, long timeout)
>  {
>  	struct amdgpu_device *adev = ring->adev;
> -	struct amdgpu_ib ib;
> +	struct amdgpu_job *job;
> +	struct amdgpu_ib *ib;
>  	struct dma_fence *f = NULL;
>  	unsigned index;
>  	long r;
> @@ -989,7 +990,6 @@ static int sdma_v6_0_ring_test_ib(struct amdgpu_ring *ring, long timeout)
>  	u64 gpu_addr;
>  
>  	tmp = 0xCAFEDEAD;
> -	memset(&ib, 0, sizeof(ib));
>  
>  	r = amdgpu_device_wb_get(adev, &index);
>  	if (r) {
> @@ -1000,26 +1000,31 @@ static int sdma_v6_0_ring_test_ib(struct amdgpu_ring *ring, long timeout)
>  	gpu_addr = adev->wb.gpu_addr + (index * 4);
>  	adev->wb.wb[index] = cpu_to_le32(tmp);
>  
> -	r = amdgpu_ib_get(adev, NULL, 256, AMDGPU_IB_POOL_DIRECT, &ib);
> +	r = amdgpu_job_alloc_with_ib(ring->adev, NULL, NULL, 256,
> +				     AMDGPU_IB_POOL_DIRECT, &job,
> +				     AMDGPU_KERNEL_JOB_ID_SDMA_RING_TEST);
>  	if (r) {
>  		drm_err(adev_to_drm(adev), "failed to get ib (%ld).\n", r);
>  		goto err0;
>  	}
>  
> -	ib.ptr[0] = SDMA_PKT_COPY_LINEAR_HEADER_OP(SDMA_OP_WRITE) |
> +	ib = &job->ibs[0];
> +	ib->ptr[0] = SDMA_PKT_COPY_LINEAR_HEADER_OP(SDMA_OP_WRITE) |
>  		SDMA_PKT_COPY_LINEAR_HEADER_SUB_OP(SDMA_SUBOP_WRITE_LINEAR);
> -	ib.ptr[1] = lower_32_bits(gpu_addr);
> -	ib.ptr[2] = upper_32_bits(gpu_addr);
> -	ib.ptr[3] = SDMA_PKT_WRITE_UNTILED_DW_3_COUNT(0);
> -	ib.ptr[4] = 0xDEADBEEF;
> -	ib.ptr[5] = SDMA_PKT_NOP_HEADER_OP(SDMA_OP_NOP);
> -	ib.ptr[6] = SDMA_PKT_NOP_HEADER_OP(SDMA_OP_NOP);
> -	ib.ptr[7] = SDMA_PKT_NOP_HEADER_OP(SDMA_OP_NOP);
> -	ib.length_dw = 8;
> -
> -	r = amdgpu_ib_schedule(ring, 1, &ib, NULL, &f);
> -	if (r)
> +	ib->ptr[1] = lower_32_bits(gpu_addr);
> +	ib->ptr[2] = upper_32_bits(gpu_addr);
> +	ib->ptr[3] = SDMA_PKT_WRITE_UNTILED_DW_3_COUNT(0);
> +	ib->ptr[4] = 0xDEADBEEF;
> +	ib->ptr[5] = SDMA_PKT_NOP_HEADER_OP(SDMA_OP_NOP);
> +	ib->ptr[6] = SDMA_PKT_NOP_HEADER_OP(SDMA_OP_NOP);
> +	ib->ptr[7] = SDMA_PKT_NOP_HEADER_OP(SDMA_OP_NOP);
> +	ib->length_dw = 8;
> +
> +	r = amdgpu_job_submit_direct(job, ring, &f);
> +	if (r) {
> +		amdgpu_job_free(job);
>  		goto err1;
> +	}
>  
>  	r = dma_fence_wait_timeout(f, false, timeout);
>  	if (r == 0) {
> @@ -1039,7 +1044,6 @@ static int sdma_v6_0_ring_test_ib(struct amdgpu_ring *ring, long timeout)
>  		r = -EINVAL;
>  
>  err1:
> -	amdgpu_ib_free(&ib, NULL);
>  	dma_fence_put(f);
>  err0:
>  	amdgpu_device_wb_free(adev, index);
> diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v7_0.c b/drivers/gpu/drm/amd/amdgpu/sdma_v7_0.c
> index 8d16ef257bcb9..3b4417d19212e 100644
> --- a/drivers/gpu/drm/amd/amdgpu/sdma_v7_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/sdma_v7_0.c
> @@ -997,7 +997,8 @@ static int sdma_v7_0_ring_test_ring(struct amdgpu_ring *ring)
>  static int sdma_v7_0_ring_test_ib(struct amdgpu_ring *ring, long timeout)
>  {
>  	struct amdgpu_device *adev = ring->adev;
> -	struct amdgpu_ib ib;
> +	struct amdgpu_job *job;
> +	struct amdgpu_ib *ib;
>  	struct dma_fence *f = NULL;
>  	unsigned index;
>  	long r;
> @@ -1005,7 +1006,6 @@ static int sdma_v7_0_ring_test_ib(struct amdgpu_ring *ring, long timeout)
>  	u64 gpu_addr;
>  
>  	tmp = 0xCAFEDEAD;
> -	memset(&ib, 0, sizeof(ib));
>  
>  	r = amdgpu_device_wb_get(adev, &index);
>  	if (r) {
> @@ -1016,26 +1016,31 @@ static int sdma_v7_0_ring_test_ib(struct amdgpu_ring *ring, long timeout)
>  	gpu_addr = adev->wb.gpu_addr + (index * 4);
>  	adev->wb.wb[index] = cpu_to_le32(tmp);
>  
> -	r = amdgpu_ib_get(adev, NULL, 256, AMDGPU_IB_POOL_DIRECT, &ib);
> +	r = amdgpu_job_alloc_with_ib(ring->adev, NULL, NULL, 256,
> +				     AMDGPU_IB_POOL_DIRECT, &job,
> +				     AMDGPU_KERNEL_JOB_ID_SDMA_RING_TEST);
>  	if (r) {
>  		drm_err(adev_to_drm(adev), "failed to get ib (%ld).\n", r);
>  		goto err0;
>  	}
>  
> -	ib.ptr[0] = SDMA_PKT_COPY_LINEAR_HEADER_OP(SDMA_OP_WRITE) |
> +	ib = &job->ibs[0];
> +	ib->ptr[0] = SDMA_PKT_COPY_LINEAR_HEADER_OP(SDMA_OP_WRITE) |
>  		SDMA_PKT_COPY_LINEAR_HEADER_SUB_OP(SDMA_SUBOP_WRITE_LINEAR);
> -	ib.ptr[1] = lower_32_bits(gpu_addr);
> -	ib.ptr[2] = upper_32_bits(gpu_addr);
> -	ib.ptr[3] = SDMA_PKT_WRITE_UNTILED_DW_3_COUNT(0);
> -	ib.ptr[4] = 0xDEADBEEF;
> -	ib.ptr[5] = SDMA_PKT_NOP_HEADER_OP(SDMA_OP_NOP);
> -	ib.ptr[6] = SDMA_PKT_NOP_HEADER_OP(SDMA_OP_NOP);
> -	ib.ptr[7] = SDMA_PKT_NOP_HEADER_OP(SDMA_OP_NOP);
> -	ib.length_dw = 8;
> -
> -	r = amdgpu_ib_schedule(ring, 1, &ib, NULL, &f);
> -	if (r)
> +	ib->ptr[1] = lower_32_bits(gpu_addr);
> +	ib->ptr[2] = upper_32_bits(gpu_addr);
> +	ib->ptr[3] = SDMA_PKT_WRITE_UNTILED_DW_3_COUNT(0);
> +	ib->ptr[4] = 0xDEADBEEF;
> +	ib->ptr[5] = SDMA_PKT_NOP_HEADER_OP(SDMA_OP_NOP);
> +	ib->ptr[6] = SDMA_PKT_NOP_HEADER_OP(SDMA_OP_NOP);
> +	ib->ptr[7] = SDMA_PKT_NOP_HEADER_OP(SDMA_OP_NOP);
> +	ib->length_dw = 8;
> +
> +	r = amdgpu_job_submit_direct(job, ring, &f);
> +	if (r) {
> +		amdgpu_job_free(job);
>  		goto err1;
> +	}
>  
>  	r = dma_fence_wait_timeout(f, false, timeout);
>  	if (r == 0) {
> @@ -1055,7 +1060,6 @@ static int sdma_v7_0_ring_test_ib(struct amdgpu_ring *ring, long timeout)
>  		r = -EINVAL;
>  
>  err1:
> -	amdgpu_ib_free(&ib, NULL);
>  	dma_fence_put(f);
>  err0:
>  	amdgpu_device_wb_free(adev, index);
> diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v7_1.c b/drivers/gpu/drm/amd/amdgpu/sdma_v7_1.c
> index 5bc45c3e00d18..d71a546bdde61 100644
> --- a/drivers/gpu/drm/amd/amdgpu/sdma_v7_1.c
> +++ b/drivers/gpu/drm/amd/amdgpu/sdma_v7_1.c
> @@ -987,7 +987,8 @@ static int sdma_v7_1_ring_test_ring(struct amdgpu_ring *ring)
>  static int sdma_v7_1_ring_test_ib(struct amdgpu_ring *ring, long timeout)
>  {
>  	struct amdgpu_device *adev = ring->adev;
> -	struct amdgpu_ib ib;
> +	struct amdgpu_job *job;
> +	struct amdgpu_ib *ib;
>  	struct dma_fence *f = NULL;
>  	unsigned index;
>  	long r;
> @@ -995,7 +996,6 @@ static int sdma_v7_1_ring_test_ib(struct amdgpu_ring *ring, long timeout)
>  	u64 gpu_addr;
>  
>  	tmp = 0xCAFEDEAD;
> -	memset(&ib, 0, sizeof(ib));
>  
>  	r = amdgpu_device_wb_get(adev, &index);
>  	if (r) {
> @@ -1006,26 +1006,31 @@ static int sdma_v7_1_ring_test_ib(struct amdgpu_ring *ring, long timeout)
>  	gpu_addr = adev->wb.gpu_addr + (index * 4);
>  	adev->wb.wb[index] = cpu_to_le32(tmp);
>  
> -	r = amdgpu_ib_get(adev, NULL, 256, AMDGPU_IB_POOL_DIRECT, &ib);
> +	r = amdgpu_job_alloc_with_ib(ring->adev, NULL, NULL, 256,
> +				     AMDGPU_IB_POOL_DIRECT, &job,
> +				     AMDGPU_KERNEL_JOB_ID_SDMA_RING_TEST);
>  	if (r) {
>  		DRM_ERROR("amdgpu: failed to get ib (%ld).\n", r);
>  		goto err0;
>  	}
>  
> -	ib.ptr[0] = SDMA_PKT_COPY_LINEAR_HEADER_OP(SDMA_OP_WRITE) |
> +	ib = &job->ibs[0];
> +	ib->ptr[0] = SDMA_PKT_COPY_LINEAR_HEADER_OP(SDMA_OP_WRITE) |
>  		SDMA_PKT_COPY_LINEAR_HEADER_SUB_OP(SDMA_SUBOP_WRITE_LINEAR);
> -	ib.ptr[1] = lower_32_bits(gpu_addr);
> -	ib.ptr[2] = upper_32_bits(gpu_addr);
> -	ib.ptr[3] = SDMA_PKT_WRITE_UNTILED_DW_3_COUNT(0);
> -	ib.ptr[4] = 0xDEADBEEF;
> -	ib.ptr[5] = SDMA_PKT_NOP_HEADER_OP(SDMA_OP_NOP);
> -	ib.ptr[6] = SDMA_PKT_NOP_HEADER_OP(SDMA_OP_NOP);
> -	ib.ptr[7] = SDMA_PKT_NOP_HEADER_OP(SDMA_OP_NOP);
> -	ib.length_dw = 8;
> -
> -	r = amdgpu_ib_schedule(ring, 1, &ib, NULL, &f);
> -	if (r)
> +	ib->ptr[1] = lower_32_bits(gpu_addr);
> +	ib->ptr[2] = upper_32_bits(gpu_addr);
> +	ib->ptr[3] = SDMA_PKT_WRITE_UNTILED_DW_3_COUNT(0);
> +	ib->ptr[4] = 0xDEADBEEF;
> +	ib->ptr[5] = SDMA_PKT_NOP_HEADER_OP(SDMA_OP_NOP);
> +	ib->ptr[6] = SDMA_PKT_NOP_HEADER_OP(SDMA_OP_NOP);
> +	ib->ptr[7] = SDMA_PKT_NOP_HEADER_OP(SDMA_OP_NOP);
> +	ib->length_dw = 8;
> +
> +	r = amdgpu_job_submit_direct(job, ring, &f);
> +	if (r) {
> +		amdgpu_job_free(job);
>  		goto err1;
> +	}
>  
>  	r = dma_fence_wait_timeout(f, false, timeout);
>  	if (r == 0) {
> @@ -1045,7 +1050,6 @@ static int sdma_v7_1_ring_test_ib(struct amdgpu_ring *ring, long timeout)
>  		r = -EINVAL;
>  
>  err1:
> -	amdgpu_ib_free(&ib, NULL);
>  	dma_fence_put(f);
>  err0:
>  	amdgpu_device_wb_free(adev, index);
> diff --git a/drivers/gpu/drm/amd/amdgpu/si_dma.c b/drivers/gpu/drm/amd/amdgpu/si_dma.c
> index 74fcaa340d9b1..b67bd343f795f 100644
> --- a/drivers/gpu/drm/amd/amdgpu/si_dma.c
> +++ b/drivers/gpu/drm/amd/amdgpu/si_dma.c
> @@ -259,7 +259,8 @@ static int si_dma_ring_test_ring(struct amdgpu_ring *ring)
>  static int si_dma_ring_test_ib(struct amdgpu_ring *ring, long timeout)
>  {
>  	struct amdgpu_device *adev = ring->adev;
> -	struct amdgpu_ib ib;
> +	struct amdgpu_job *job;
> +	struct amdgpu_ib *ib;
>  	struct dma_fence *f = NULL;
>  	unsigned index;
>  	u32 tmp = 0;
> @@ -273,20 +274,25 @@ static int si_dma_ring_test_ib(struct amdgpu_ring *ring, long timeout)
>  	gpu_addr = adev->wb.gpu_addr + (index * 4);
>  	tmp = 0xCAFEDEAD;
>  	adev->wb.wb[index] = cpu_to_le32(tmp);
> -	memset(&ib, 0, sizeof(ib));
> -	r = amdgpu_ib_get(adev, NULL, 256,
> -					AMDGPU_IB_POOL_DIRECT, &ib);
> +
> +	r = amdgpu_job_alloc_with_ib(ring->adev, NULL, NULL, 256,
> +				     AMDGPU_IB_POOL_DIRECT, &job,
> +				     AMDGPU_KERNEL_JOB_ID_SDMA_RING_TEST);
>  	if (r)
>  		goto err0;
>  
> -	ib.ptr[0] = DMA_PACKET(DMA_PACKET_WRITE, 0, 0, 0, 1);
> -	ib.ptr[1] = lower_32_bits(gpu_addr);
> -	ib.ptr[2] = upper_32_bits(gpu_addr) & 0xff;
> -	ib.ptr[3] = 0xDEADBEEF;
> -	ib.length_dw = 4;
> -	r = amdgpu_ib_schedule(ring, 1, &ib, NULL, &f);
> -	if (r)
> +	ib = &job->ibs[0];
> +	ib->ptr[0] = DMA_PACKET(DMA_PACKET_WRITE, 0, 0, 0, 1);
> +	ib->ptr[1] = lower_32_bits(gpu_addr);
> +	ib->ptr[2] = upper_32_bits(gpu_addr) & 0xff;
> +	ib->ptr[3] = 0xDEADBEEF;
> +	ib->length_dw = 4;
> +
> +	r = amdgpu_job_submit_direct(job, ring, &f);
> +	if (r) {
> +		amdgpu_job_free(job);
>  		goto err1;
> +	}
>  
>  	r = dma_fence_wait_timeout(f, false, timeout);
>  	if (r == 0) {
> @@ -302,7 +308,6 @@ static int si_dma_ring_test_ib(struct amdgpu_ring *ring, long timeout)
>  		r = -EINVAL;
>  
>  err1:
> -	amdgpu_ib_free(&ib, NULL);
>  	dma_fence_put(f);
>  err0:
>  	amdgpu_device_wb_free(adev, index);

