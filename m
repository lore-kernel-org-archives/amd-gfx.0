Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7859FC282EC
	for <amd-gfx@archiver.kernel.org>; Fri, 14 Mar 2025 15:03:16 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 063AC10EA09;
	Fri, 14 Mar 2025 15:03:16 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="NNK0oZkb";
	dkim-atps=neutral
Received: from NAM04-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam04on2065.outbound.protection.outlook.com [40.107.101.65])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BC2D110EA09
 for <amd-gfx@lists.freedesktop.org>; Fri, 14 Mar 2025 15:03:14 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oBl+feGP9sl6SzKFoUgj9EQwpNjUnJOnOEV6kQSMZ4pfqG+28DlmQEUjidiyrmQrtpbzE3xDnY4QrELsLv19biGWHH645QmUSZgfulHNce3GcbXZmyKTpWCtDj8+CbwaFF8eAwT7Grk4BY/GC33VB2290pHX5rCZoMF81xPAgg7tCAv85Moutt2ztF6yN2AYzK2yqIrAPRt+4TlU6bS4PNFIB9b4lWCdON8Q3aaPhCbPwEVWeTzfDcLXL8YFZas0hTL2BpPZdcClIO8TRjwCtiW96TLV9VmK1ds3vtkFivowrTT0DHKcVPodarcq/xRVfFdAN7OkRqEufThY4F+vBQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=q/Vqhf4VvA+KWXmOqgh7uUR0IlE4PbUmYQntHSr7/hE=;
 b=sBR+/ji/76f56pMsZ/Yj3773rV5iL00fjJC8essRV6Cy+8g9QPl8kHRU/HY50/U3iHYH2a0mB2euOn6X+Qh104h08+YRuVLMvrjnFh4f7zWWOVTsjF12OWAp+JNFuTkGbSeVjgEnXVyVlEMmdIg9WTW44zaACr1K7oEmojUWlBblyHLZoTGLV/Thyj/nYK7ZtyD7VZp7D+FUq/Wr2K8nuFEfgcxaSaZlQKEPRnNDtNZcBoK6eXUrsEpYH4cE+xcENn5dmJzXJRje0vb2laVhxggUjNeSBzlaAD0irvNtzuWbHCmlon+n+9+9FVhhizLTx1auLDNETCHFhGZCDKFjUg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=q/Vqhf4VvA+KWXmOqgh7uUR0IlE4PbUmYQntHSr7/hE=;
 b=NNK0oZkbcXhzJRvzF5N/It81EXsYIhVMsh4T50HKdVM7B67P03yazesTx3vuXSfcbNZeGHeFgqvzZn32F2wB+91XJyOVSJLL0+qRc4JINjSZxnaegk2HGYnhvTSjyfdAjH/fn0ueSnuYdWzyZCPV/Yn2WB/3ouMAkzmvTBFsNYw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS0PR12MB7804.namprd12.prod.outlook.com (2603:10b6:8:142::5) by
 PH7PR12MB7937.namprd12.prod.outlook.com (2603:10b6:510:270::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.27; Fri, 14 Mar
 2025 15:03:12 +0000
Received: from DS0PR12MB7804.namprd12.prod.outlook.com
 ([fe80::8327:d71a:ce21:a290]) by DS0PR12MB7804.namprd12.prod.outlook.com
 ([fe80::8327:d71a:ce21:a290%5]) with mapi id 15.20.8511.026; Fri, 14 Mar 2025
 15:03:12 +0000
Message-ID: <b4efdae2-cd02-459f-b54f-8ec03f099f9e@amd.com>
Date: Fri, 14 Mar 2025 20:33:05 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] drm/amdgpu/gfx: adjust workload profile handling
To: Alex Deucher <alexdeucher@gmail.com>
Cc: Alex Deucher <alexander.deucher@amd.com>, amd-gfx@lists.freedesktop.org
References: <20250314134707.3012124-1-alexander.deucher@amd.com>
 <bc45f314-3720-49c3-a836-b409f8b89595@amd.com>
 <CADnq5_PA5KnsBN5vJeq+K22bKwYSut13e6sdy2s_f5=yS78ygA@mail.gmail.com>
Content-Language: en-US
From: "Lazar, Lijo" <lijo.lazar@amd.com>
In-Reply-To: <CADnq5_PA5KnsBN5vJeq+K22bKwYSut13e6sdy2s_f5=yS78ygA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PN2PR01CA0117.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:27::32) To DS0PR12MB7804.namprd12.prod.outlook.com
 (2603:10b6:8:142::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB7804:EE_|PH7PR12MB7937:EE_
X-MS-Office365-Filtering-Correlation-Id: cf3bf30d-98da-4564-03a7-08dd630956fd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?VThIT05EY1lITmRGdk0xeHhRaUVpaVQxajN2TUs0Z3FHVzRkR2N6OG5HRGhq?=
 =?utf-8?B?bzVJVWpObyswN1ZSbWErRkZoS0wyT0RFOEpwZUgwSGlWWmdCbjVMbitaa2NL?=
 =?utf-8?B?REoxQkJSbWF5R0xxQ1dGcDl4QXVOeDZNVXlQOG9aMm9CMFUyMnNheHRNTjc4?=
 =?utf-8?B?aFkycGhDcTVZZlNxcjdjNnl2ZWk1c1VrUWVObGRKWjlIMjlDSEdyQW93bWVX?=
 =?utf-8?B?ejUwQmVTMVBES0QvSzIwWHRZUE5IbHVMMlJmYjB0OWU0YSttY0N0Y0FYV1BY?=
 =?utf-8?B?U0ZmK1ZVYmhqVnlxdkRLNXFrTG5oVUNMNEVoYzVYTWxWM3hvZHUvK0U2S2pM?=
 =?utf-8?B?akJFa2sxUU9tK3E2cTR5RHJaRGVWa1pvNU5uYUg0SUxUUk9oOEkrZzhkNUpG?=
 =?utf-8?B?Z2xjQkNVUW82bEM1MkZ0czZTbnFkaTVFMGNoL2Nibm1XL01PdGlLT3owUW1z?=
 =?utf-8?B?Q2lkcTFjWTkreVE3aUlGYVlZK29oMW5nRFQ2YVc0bWtiMEQzQkdLVzJIeGhP?=
 =?utf-8?B?R0o1R0lOQjRHSHA1QXVySGNwQlU2TFRYakU1K1pHcVkvLzRVemZVNlpUNVhF?=
 =?utf-8?B?bEJOcW9FOFlIK1pRNXB6bExtekRVa0dKL1FxWTJHZlJSRjdxRkVoZm1RcENa?=
 =?utf-8?B?bUlsVUF3cVlVRHdIWjhCaGRYNFFJSzFaWU5pZXlWY2pFWlZjU0lHNW0weVdG?=
 =?utf-8?B?ZFFxNUlSMkdLd2xGQnUxSHJ1YVJzY3B1L3dQQld0ZEZ3VGc2aTJHdmozMHJ3?=
 =?utf-8?B?UEJvd21yR3BSN1I2RHF2SmV3d2ZaMDY1M0ZTQnovUDJ1TkJQcWxiK1FzUTVY?=
 =?utf-8?B?YS94eHJOQUgwcmV4TnJwNTJ6MlFiN1NPM2R3ejltREUxZ1RZSVQwNUpHbmlz?=
 =?utf-8?B?U2RPNlFXTjZWc3JHTDBxc0VrTjVCVEdFcXZtaWRjMTYwNEViMVRidDh5em9C?=
 =?utf-8?B?MC9GdGRydWpuZjcxdmpOLzBGOW0yV3J0ODBTZzM1Z0IyN1pmZHI5Unl1S3FT?=
 =?utf-8?B?a2JRUTNYOU9Famg4U1pKQXUxSmY1Q0JkOFhjMWFXN0M2QXd1aEVsOWIzeUg2?=
 =?utf-8?B?TEMwNDc3RFgrUVJ0Q09OQ2QyRWdtMnZzTGRMUng0clRreHBoOWdvZG5Lb3Y4?=
 =?utf-8?B?dlNpNnBmQmtCclZJNW1TTXAyQjJzUXc0TitxQUxUWURkVXpHcFNDc3Nzbzgz?=
 =?utf-8?B?d3diQS9PcU45cWt3UWFDR3lQeHcrcjl0QnpodElhbDF6WU5MUHB4bjRtV0Qw?=
 =?utf-8?B?dVBLQ3NJckxxVXlvQ2JrT0hJY25MUFJ2eFN1NjFzalNZdTdEZkZhQmVzdGZi?=
 =?utf-8?B?RHkyZk9SUkMxUDM5Ym44SWJjSnl0K05LT3M2dTNNbjFpbXk4RWlFd0tRdVFx?=
 =?utf-8?B?ZkJXMUpaN0tBMDZHbUtoOXBHYlVydjNiSEdMYms0QkhHYStNcG1uZXArcnd2?=
 =?utf-8?B?S3dxMCtheFd3WC9SRHgzUHg3K2dqU1FpZVpGQkJxRitQUFNtMHRzS2w1OG9E?=
 =?utf-8?B?R2JGRmRWZy9wQ21QOS9qRUNEYWVObklSOXZxU3kyZWJLa21HM25RTldlSEJk?=
 =?utf-8?B?NTdUMDJMOTVsQkxkSWdtdEQzVk5rK2Z3Mm43Rjl4dFdoY1JtVEVpSGJxc0dX?=
 =?utf-8?B?NUlVQ2F4VXhxTkZzRXdkaks0RUNTcndtclVPQm5pZHBhS0ZSM29ZZkU2aHor?=
 =?utf-8?B?bS9HOEdqekljenh3bTYwQzlhc2NwdUJZUjgvZ2tOQkEvK1pCekFkR1hiUkdQ?=
 =?utf-8?B?VkV4UWNYZHJDZVRjNndmSkQ0K1ZqaFpwVWpyTHEzZktkMWlubUxLck53STVu?=
 =?utf-8?B?NUw5N0V2bnIrMHI4SXVDSUUrSVNjeU8yL2IvRmxHbjZDMXNNOTZjYnprNEs2?=
 =?utf-8?Q?1Ipx17b/7DiNM?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR12MB7804.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?eEY5R1NWRlhxcmVPanl6NjU0aDZnRGtrUkJHM1dwR25TaS9WdDR0Q1NzdWNl?=
 =?utf-8?B?Sk9Rc3hPQllLN1lFUjl0a1hGTDh1c0FJcTZUMC9kZ2xCRS9uSXFmNmh3RVRq?=
 =?utf-8?B?bzhuNGdtQzRSS3NaRXpsczM0eE9vUWF4dVh5SmM2cDFUTkprUmdET04zbC8w?=
 =?utf-8?B?WWxyVGdoYUwwV2xFV0JlY1pReGtnZ0dDUUFxOHl6dFF4UU9kamJEaklzUjJk?=
 =?utf-8?B?T1VYemFwcE1kUE11OGM3OXErbFhHazd3ZEhQWnJzbDFHa3R3L1hSaFo5cTZ2?=
 =?utf-8?B?blNhQ0ZHbkJEZjYwMktGKzNUemhZd054azRqU3d0SVdVd3YxNG9NM0ZVMC9I?=
 =?utf-8?B?RCswSzZWbU81blcySTQ1QXJCeE9UMXBsaUZkczJsVHBHYzRpbEsrdjVmbzF5?=
 =?utf-8?B?dmpvOUNCbDBFT0Q1K0pFV2hEalB3LzdLU1lEc1BndDJUMVlRK3ZUTjNPSFBl?=
 =?utf-8?B?RUl3aXo0aG1CZ2J5ZEsyR0FJNjFhUVhoYVZrY3RsODZubGMyY2NTa1NZZGY2?=
 =?utf-8?B?TUI4Ny90OXZ1em1kalAyc1o1eTdlaWY4NFpvNlIzZXh4bk5lYWI2Q3VtSkV2?=
 =?utf-8?B?S1lTb0I2dE9hbjJGTkdKVkdHZlB3ZFZVMmlUazY4VDhMdVJCVlIvK3NtRmpN?=
 =?utf-8?B?SUtId21kTEpOSDQ3VTg3Uk1KOEMrNzVRaDRBMEpOb3RoZXZKaHZ5YmxuS0Nn?=
 =?utf-8?B?dXA2V0pNZGRueGhIVmc3VXNraTJDWmwrTUE2Q0ZRMXRYcGNuellrZE9Kajh1?=
 =?utf-8?B?UnJma0ZiQ1JMRVQwYTlJTHZUYXNGZ1FmT2FuRGREYjlmM0UyM1MvU0lVaDBK?=
 =?utf-8?B?UGhEM0wrSzhRaWVxN0NsSDNBbWg3Zzg5Vm1vQmNETjQ0OUM0Z3d1Qks5ZEN2?=
 =?utf-8?B?ZlN2N2hxb1MwUFhQK245dnhjcytiaGdWeVlFMTBUNkZWcXpvUVprMWNGc0hW?=
 =?utf-8?B?WG1uT2dWTGtRU0t0TitpTUdaOVhrMEJGTko4OWZ6MFdTbmh6S2hBdTg3cy9K?=
 =?utf-8?B?OVhtV0NJV0lVWGRBMmZKRjlmbTcwb2ZFakp2WWlsREdERS93WjBXYWZ2a3Ax?=
 =?utf-8?B?bkpnN1NxYmZmV3g3SXRnMUd2d3VBYWttVS9IVWdMaVFlTXYvbjJSdEcwQXh3?=
 =?utf-8?B?VXdUc2hCRVBYTGFKWllTUmxrTVhQdnljckkzdXloYkpzY2xERFZjOSs1NjNF?=
 =?utf-8?B?WUdmU1dKUjIzZmJCYnRweGJ3MGFnTksvbXZiWW1PTzE4d0dPc0daYTJ6K1c0?=
 =?utf-8?B?Rng4VVdXVmgwUDRLY2twNEEvLzNBMGl1UGxKQlR0VlEzdWxWQzdVakx0VFFy?=
 =?utf-8?B?OWhjbUVtdlBCeU9nL0tDaXEzRlBoY0pFNnBHWXhpTU10aDNGTXVaK0hpbkZY?=
 =?utf-8?B?UndFM1hiVlZUSm56YXVCWTBMVkxVRjZXSlUwYVQ3bDgxM1VNLzdHR2ZzemVB?=
 =?utf-8?B?eGU5QVRBQlBZbFJ4Nnd0RWM0eWRZMnNmMENvVlVNd1JQelhKSTZFYklPbGln?=
 =?utf-8?B?clpWN3BkSjJHVGMvZkhIS2xkeXFvb3cxUlliYTZKZS9uaDc5dy9yMEFEME1a?=
 =?utf-8?B?bzkxcTAzWUxhSkNMZGxBY2JydlJpNEJqYlRrS1NZYXFPVVpOYjdFRTJoSUhU?=
 =?utf-8?B?UmxjWFJUcUhGZzFuaDlEL2RrRTdUMDQxU0dMZUJFSUhrNk5FVkt0emVXS1Rp?=
 =?utf-8?B?S3ZQcUcrK0o2cERXTi8xTEZEOU5qSW0xbWt3bWRGMDRScHVsMGc5ejFHSlVt?=
 =?utf-8?B?d2dReWV2NzJ4TkIyM3BLaldOcTJHZnJPNkpsb2NQZHU3cFpxZ0JtYXRYckpN?=
 =?utf-8?B?Z2M2NU5WakVidHBzQTNRWmdLT1N5aVA4MmxKYTA5Ly9EWk5KY2FCV29vSGow?=
 =?utf-8?B?OVNRWVc1SmRZazlsak1aa3htSGZuNWZVQ3FsSVJ5R0RaZWF6ZlZUNEc5c1pK?=
 =?utf-8?B?TGllQmw3QjF5MGZVYXdlRTA3OFdkcEV5WmlCamV2UHArVHRKN21Sa0RDRGNH?=
 =?utf-8?B?V29iZnBlemoxMkdCT3J5V2xZYjVSbWRoVXZTcGExaE9vVmFFSnNCRU1PZG1p?=
 =?utf-8?B?U0RuZ3kwdzI1L2NWa2h6eDFadWVxVHV2M2VVczEwbU9zWHVLSXRoWTZSOW1u?=
 =?utf-8?Q?NzbnQwSW1W9Z+e5Dn8KIET6t1?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cf3bf30d-98da-4564-03a7-08dd630956fd
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB7804.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Mar 2025 15:03:12.3631 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6HszzNMxg8aqJNmQoBo4Mosy/iCzSh2KE/+gO4EWBQ3g2P3uYqwDvTXQ9sUK+FL5
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7937
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



On 3/14/2025 8:28 PM, Alex Deucher wrote:
> On Fri, Mar 14, 2025 at 10:53 AM Lazar, Lijo <lijo.lazar@amd.com> wrote:
>>
>>
>>
>> On 3/14/2025 7:17 PM, Alex Deucher wrote:
>>> No need to make the workload profile setup dependent
>>> on the results of cancelling the delayed work thread.
>>> We have all of the necessary checking in place for the
>>> workload profile reference counting, so separate the
>>> two.  As it is now, we can theoretically end up with
>>> the call from begin_use happening while the worker
>>> thread is executing which would result in the profile
>>> not getting set for that submission.  It should not
>>> affect the reference counting.
>>>
>>> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
>>> ---
>>>  drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c | 22 +++++++++++-----------
>>>  1 file changed, 11 insertions(+), 11 deletions(-)
>>>
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
>>> index 099329d15b9ff..20424f8c4925f 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
>>> @@ -2188,18 +2188,18 @@ void amdgpu_gfx_profile_ring_begin_use(struct amdgpu_ring *ring)
>>>
>>>       atomic_inc(&adev->gfx.total_submission_cnt);
>>>
>>> -     if (!cancel_delayed_work_sync(&adev->gfx.idle_work)) {
>>> -             mutex_lock(&adev->gfx.workload_profile_mutex);
>>> -             if (!adev->gfx.workload_profile_active) {
>>> -                     r = amdgpu_dpm_switch_power_profile(adev, profile, true);
>>> -                     if (r)
>>> -                             dev_warn(adev->dev, "(%d) failed to disable %s power profile mode\n", r,
>>> -                                      profile == PP_SMC_POWER_PROFILE_FULLSCREEN3D ?
>>> -                                      "fullscreen 3D" : "compute");
>>> -                     adev->gfx.workload_profile_active = true;
>>> -             }
>>> -             mutex_unlock(&adev->gfx.workload_profile_mutex);
>>> +     cancel_delayed_work_sync(&adev->gfx.idle_work);
>>> +
>>
>> To avoid locking/unlocking mutex for each begin_use, I think here we
>> could do like
>>
>> if (adev->gfx.workload_profile_active)
>>         return;
> 
> But that is what the mutex is protecting.
> 

I think once we cancelled the work, there is no one to turn it to false.
We don't mind if somebody else changed to true already.

Thanks,
Lijo

> Alex
> 
>>
>> Thanks,
>> Lijo
>>
>>> +     mutex_lock(&adev->gfx.workload_profile_mutex);
>>> +     if (!adev->gfx.workload_profile_active) {
>>> +             r = amdgpu_dpm_switch_power_profile(adev, profile, true);
>>> +             if (r)
>>> +                     dev_warn(adev->dev, "(%d) failed to disable %s power profile mode\n", r,
>>> +                              profile == PP_SMC_POWER_PROFILE_FULLSCREEN3D ?
>>> +                              "fullscreen 3D" : "compute");
>>> +             adev->gfx.workload_profile_active = true;
>>>       }
>>> +     mutex_unlock(&adev->gfx.workload_profile_mutex);
>>>  }
>>>
>>>  void amdgpu_gfx_profile_ring_end_use(struct amdgpu_ring *ring)
>>

