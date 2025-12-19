Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 82D1CD74961
	for <amd-gfx@archiver.kernel.org>; Fri, 19 Dec 2025 08:12:46 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2982910ECAF;
	Fri, 19 Dec 2025 08:12:46 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="cfElFLgv";
	dkim-atps=neutral
Received: from CY7PR03CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11010010.outbound.protection.outlook.com
 [40.93.198.10])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4A8E810ECAF
 for <amd-gfx@lists.freedesktop.org>; Fri, 19 Dec 2025 08:12:44 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QOrKXHikt5NodAZ/vjAsggTS0tTJyzsrfWCj/gGGNeCVA/7KLxUlS3SdgYMweBVIoo20M5dxXEDSMtYdRzCnNTkT49gi3sERCDm0chmH5Aq7s19QZDWhUqK/qASWouyBpsyIC+I2cqxOvgBldhzO4ctOMqpyaIzepgv8dffpomc5tMKWBd7SCynoS0vt6uqioWgXe7w8pN2w73pikVE9plGsAnnGCo88yoMMBCkHV6qNA24KC6mHPyS6PXl4+wja+UfH0G7kxzy3iGotvQfckMj7miUyRegWA+RVgajdDGPi9bn/3DKFNTJryaSNGHm9Mpi6O+Seq507NrBakoYh5g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7hJ/BGEg5LJ1+sSIxuxu20chB2ctYR7UluVmYCvwtSs=;
 b=wH1WJcwXFioAeLloyOLFjFNjStovXQzLLmNYJRlDIgglWggM83cQ6zoRqWEHdJvW+spghpYJE2FxvaHhYoPN6MfHkq9ZiZ1rO1kTR0sjDRkRbZRhvebXg75vPbu2VQ0DsIO3nbkBWl19FxIACz1aytEbMAmzJfD3DrAEZu4EpGOpzrYHsX+Fu7bQ2S9lT8r2hpsuX5nsLgzbETWD0407UqH9d4jxUo7DZfHGOjZtr++pu+IUOA9rKfN4dQeFfB4PCQ6x8/+20nwC0rdsLrIJLHFgkiVT6iXAQERahZtt5s6QjS2APUndl12lYhCy8MgHoZRJPc2SBp4hnZAp3iKzYw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7hJ/BGEg5LJ1+sSIxuxu20chB2ctYR7UluVmYCvwtSs=;
 b=cfElFLgv+pSGPs1FfePCss6+GJW3i+xXbfTNIp0DLEZHXiQ6BUl/ynhJIIwOvuhK9kirupJgX4IcTuJCRS8jPZIEqscHjdfk/U6nNvMOb5MkdkZg+IGTd8UY8Y/9Vn/VdekP1zBcewvlnfcjh0Pmdc8xs+5tIUwBgsKiJ/KVjpo=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by CH3PR12MB8210.namprd12.prod.outlook.com (2603:10b6:610:129::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9434.9; Fri, 19 Dec
 2025 08:12:39 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5%4]) with mapi id 15.20.9434.009; Fri, 19 Dec 2025
 08:12:39 +0000
Message-ID: <c0ab731a-c32c-49ea-b380-1dba8b20894f@amd.com>
Date: Fri, 19 Dec 2025 09:12:35 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC 2/5] drm/amdgpu: Remove output parameter in bo list handling
To: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>, amd-gfx@lists.freedesktop.org
Cc: kernel-dev@igalia.com, Alex Deucher <alexander.deucher@amd.com>
References: <20251218150405.80502-1-tvrtko.ursulin@igalia.com>
 <20251218150405.80502-3-tvrtko.ursulin@igalia.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20251218150405.80502-3-tvrtko.ursulin@igalia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YT3PR01CA0121.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:83::27) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|CH3PR12MB8210:EE_
X-MS-Office365-Filtering-Correlation-Id: dc9e2b14-dafd-47d7-b43f-08de3ed66041
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?cDN3cHVYczlwV3M4ajFMYzJDa1JKNkhtZGZWS2Vpc0c5SzJXa21idFBQbzk4?=
 =?utf-8?B?ZEJEeHVlYTVISTZiNmxqVmx3bjF4MWlSU2tURGR4UExWY3pLYy93cVk5UWRy?=
 =?utf-8?B?RFJMMkFtNERSN2JIUVpxVVBHa3lmcUJ3QXk5ZTZac0lsamRTSXNFR1o0NGlE?=
 =?utf-8?B?SnBpRlk4NXpkRTBaY3VDR2dhTXpDUHUxYVlkUHUvM0VGaFBMKzV0MHFIc3hD?=
 =?utf-8?B?RkMwRm5YWWJ6U05qVlFLdkxJUU5nMHF4eCtnTUpIK1VsOUJ5WGs2ZlFQRzQw?=
 =?utf-8?B?Q1R2eFlkWUVHb1A4bzVGdnNBZ2YxU09jb2taVHRhY1lxcmFqQVBkS01IUnJB?=
 =?utf-8?B?TW8vNG4wY2szR0R2YUVoQld1ZnFZVFRBTjVZSHZtS0plMmlhVStrand5Y1Vs?=
 =?utf-8?B?dWVPQUczais5TXNLaGFYajN5S0h6NnlrMFcxM1plRzZhaG14QWgxdFRIUXNR?=
 =?utf-8?B?c3ErWjBtdVVXcE1oWHB2STNRQzhBaW9iTUJ2d2VxNWlJQ0R1SGFuVERjbmZ1?=
 =?utf-8?B?WUsxRWZ5RGNHdFR6amluaXlkUlJlQzQ5NnRwdFd2NFdGam9HWUZCR0ZBeGFU?=
 =?utf-8?B?VUMzdnA1RWIvcWV1VFFKdVdQZW0xT1l4OHdneFAwdzR0cWhKcGt3QmxMMWRi?=
 =?utf-8?B?NXY1TkJVZE5OeEwzNklURDlPL05saUk2UTVwZUFydW91YkFsbG9XMTA1elRh?=
 =?utf-8?B?RU5KRzlJUW1wWHRpOGU3VmREdENVWGdPMUhyQ3NLamg4RUloWm1mTWdjRSt3?=
 =?utf-8?B?eWNXbjJucUZNRlpLR2JnSnRUVExlR2JQam1SajVTZTRjSVNwS21HT05wdGNW?=
 =?utf-8?B?U0dpT3ErWGw5THgzeWVPS0VnRndXaDJhSmhyaCttY2h4MGRQN0JTS3lYVUNi?=
 =?utf-8?B?TjlSZERsYi9IcjFUSGFPYldMaURwbG8zQjRmdWhvMU9hMmo1c0tMLzV2a3lk?=
 =?utf-8?B?eEkxZzQ4d3pPQjBnbFA0M0s0NzlzV2FPTERGcXl4cnhVTXBoZkg3REJnTncz?=
 =?utf-8?B?alF1MGpoOGk4T0lxNDlFRVJtV0QrUUNscENIMGkyS1NRUFR6MmxsTUQxZ2w0?=
 =?utf-8?B?NEVqd3Rmam4vWEpxeVpVMGpBTVJDWE9oMVhJc3NaVDlKcEw5NkpPU0pFZG56?=
 =?utf-8?B?VTA3RldvWmdaWTU2eUpzZGxyanAxZXdPOGN6RmRjZkd0bThLR1ROc0gyZlg0?=
 =?utf-8?B?Vll2R3RoNjNOMlFIVGNUNTN1U1ZIKzNRUVlUQ1U1NGRrdUdNOUljY0VjL0Zn?=
 =?utf-8?B?Z0JmbUx5MVA0QlFsSWxVRmFnVDY4M3lSZ3lYTDNxNCtncVN1TStDaTVXSFFE?=
 =?utf-8?B?ZXFsVkZXOXFSSkFET1hxZGNrOU5zeTQrSWJObnFlZEJpak9PcWlCeFUrbFdm?=
 =?utf-8?B?UEhlT2d4RVVNM2ZSNUNscDZZaWJpTWpTSXRrMmFZSkpEeDN4SWFoaWFUMjR3?=
 =?utf-8?B?VkJtenZnRU8xMytTaXd2WUpNc2d6ZmczaGFuSWY5ZlZlMit0bXNVaUxMSzhx?=
 =?utf-8?B?Nk80dFNpR1ZWZU5pWmNNMU5ycjZjNFFuU3ZVL2VHbHZtL1NsV2RrbWc4MndO?=
 =?utf-8?B?blQ4SFllbXduNTlzZm1EWjBCNWxvNVlVVGlzZmVpZzhsc24xZENMSVRrUWJj?=
 =?utf-8?B?YzhJdDVFekhpOTJqb3d6NGZ5M3c2T2NsMHVaMy9nTlZJTXlta2NHVWdrOFVa?=
 =?utf-8?B?UU1HaTEwbnNlcU9wcUZTeWhYVVlLQzB1NFRYY21mWExaalRYa1pRYW83TUgy?=
 =?utf-8?B?OU01YUo4dU45RDk2SjRYOVRTZkU5OHI0TEczSDJGbkVHZEErVzc0UnFySVdz?=
 =?utf-8?B?V2JLNUFPN1E0NXkzZmI1OFBYSmJjOVBtdXgzNzBvYnJBYnN6UFFsNGJuMlhk?=
 =?utf-8?B?MlhVY2hIRWRsU3doUVNRQVoreEg2dUZtenh2bmZMMk5EWDRrN05vazBrL3dQ?=
 =?utf-8?Q?iI3C6x1DTy+nhjUm0FWazirJRLvhaXC8?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(7053199007); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?eTRadjl2M1FJUUx1SFJqbHBsQkE0Z2tRaGM4MFRLVFQ2amxpY292eHQ5UmZV?=
 =?utf-8?B?Y1laTzZERCtibkdxUFR6MWtqb1dTd3V4cGtzRmtDYUxVTVY2OTRmTWJueEEz?=
 =?utf-8?B?MENNYjliL21CU0RNWldLRGE1NlJ6YUdpN0RUZzhoY3N2ajFpSmJwdWdydkhG?=
 =?utf-8?B?RVFIWGlWellIREVmcjFha3M0MXNaVlRHek5MTkxCWlROSHgzbitrS2xqNHJn?=
 =?utf-8?B?T0g2OFFUOS9oQ2hKQUZReXpzaUF2VDQ0TFJnNURjWjBvd20vOXZrZTlzS3p6?=
 =?utf-8?B?RmdMaWwzY3Z2d1BjV3JWc1piVVAvbWFpNWRUVEdZKzh1YUY3VlJ4eVRLeXJI?=
 =?utf-8?B?Y2N0S0RPK04vTjBERDBjaitOZHpla0h0TVRwT3RoTGQ3YktwMm43cFU1eWRL?=
 =?utf-8?B?dy9VVzZLQVkyc0kyd1dVcFFvcFBlNmV3UEt5cEl5MS9HMnBPSGQwRFVUcU40?=
 =?utf-8?B?czJYcXBqcVBXQUlHeExYRWZ2UFE0YXJoOGtVWjdRclJHZ1BXRDJVU0pGVWNI?=
 =?utf-8?B?czFEeDhONGlJQlRWRm9Iam5wS3Jsb20vbmVmaUlEeGdaaVp2MVF2eWlDZHlX?=
 =?utf-8?B?U0cxNFRCOWtkcDJMZjVDZWE3eUk1VncvOHpHR08rb3ZmKzZhT0FzZ0JBOGJ1?=
 =?utf-8?B?ZklleVhxZG54b3VYNWxlbHBGeXBBelROb0RBK09zTXk4WW96M1FBQ3BOTmxY?=
 =?utf-8?B?WU4vdzd0U0dRaU1xcnFXVWh2OXFReGxQdHFFSElUUUkrcnBGcVhUVm5PTURR?=
 =?utf-8?B?MWc4Tno1T1NZRVBZdUxJU2RxRHhjTEk1OUtsMjJUMktlUkN6MmJRNys2a09T?=
 =?utf-8?B?VzN6S2krVExiM1hwYnlrZGJJNlNOYVM2MkJMNHdzaFJOZTZJb3U5aHJhTXBN?=
 =?utf-8?B?WmJ3VEdWRTdGWEFMSUtOeWNzZEFYdXk3UGQ2MFRwT1phWDQzcEtldjdzbFF1?=
 =?utf-8?B?OXJQeTVFVTRIVkVTQTlURFRibjRMTmxHZ3h5c3BFVWYwR3dCdWV1eHZvRkEx?=
 =?utf-8?B?dldQUjZ4WE9mNUlYd0tlVCtJT2NvNndkUm1aK1ljSVUwcXRnSVFTa2JGdkdT?=
 =?utf-8?B?dTAxOE94QWRZVUNsaUJaU3dyTHp6ZnNwSXJ6alllUDhtVWplRVMwaWJQaERs?=
 =?utf-8?B?K3k1MWxRNkRPTGF3WWZpT0xHYisweTJRT1VNLytnTkgvcDQ4anpkQ1NBSHhT?=
 =?utf-8?B?ZCtqUml4Zm1pR2N1QTR2dHZDa1F4aERnVExZUDl6SnBNWU5vcTFMNzlXRkJo?=
 =?utf-8?B?aiswaTJ0N1JBeWxLR2JRR04vbE50Rk9qVEprVDFvNlZNVk1xWVpwOWlPQ3NX?=
 =?utf-8?B?bERIci85U2RyZ3NwUEUwMEFVczg1NnlZQ1BxaEJMN0R6aWRTYXU1YU1kMHdO?=
 =?utf-8?B?NzJFdmo2KzdTZjF6K1ZxeG1SczBWTHp1Yi9HWi9jOUdYbVczTm9XbWxVOGJw?=
 =?utf-8?B?WDAzWEdYckVjZWlhVDdSSlRKTGova0FGbWF0aFZkOFpHRFRpTG5GVW5PTXgx?=
 =?utf-8?B?dFphV3I0TmNDRjBCMWJObjFieXlQWWtjVGdYN0NZVjZ0THRweXM0aTlSM2pq?=
 =?utf-8?B?TG56UFpYS2RQMmVDWWJEK0k2ZDFIaFhZRW1GVTBNZ2ZjcGJDWHF2YTJOQ1NI?=
 =?utf-8?B?Y0R5Y014aHJoV2lRd2xibHRQVXd1Q2NtQWVGNFYrWURyV3lNbVB5MURFZm5i?=
 =?utf-8?B?aHVIYjJTR0Y0MXhsdWlGNjFheTZLUDBHcGpEVUNDTDBwMVVjNmsrdDFaL1dZ?=
 =?utf-8?B?THZrVVRpckFmVXkvd3JxZHVQcnNkV2RER2xpTXU3TWprZ2VSMTIxa1A2clNB?=
 =?utf-8?B?RW5hbnJUWHJEeCtWcFF6MUJMR3pkZXJvaHUzdEQ0TzF1dm1ZdSswMnFzWk1a?=
 =?utf-8?B?L3lHK3Vhd3pWTWZiQ0xzTWJJTWp0b3Rtd3NzYlRTUjBzR083YVNIZnBHSy9i?=
 =?utf-8?B?TDZOdWJTVHNQSXp4NFU4czloNTdOWXpxcGtabUVtSWFrSjNrRjArU3R0VE5u?=
 =?utf-8?B?Qm45cXZZN1lvT2ZKZnJLUklhM3VmTTJKa3JFZFY3YjVONVZEUHI4bWlvSjV3?=
 =?utf-8?B?OGhZcUN5b2Q0Z3FRNm1DanpCcTE0TzE3VUY4YzV6VXJWT1M3N2FBRlBUeEZh?=
 =?utf-8?Q?FYlk37PaYm3+PgWt+1hnMJ0Jx?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dc9e2b14-dafd-47d7-b43f-08de3ed66041
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Dec 2025 08:12:39.3410 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0Hy3yrnls8TlIsaC/7Mc6iigyzN9FEyR/ydHP9KOTMW/P5mC05rU5CyqFjIrNb+Y
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8210
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

On 12/18/25 16:04, Tvrtko Ursulin wrote:
> Removing the output parameter from a few functions should result in more
> readable code and also enables us to save some lines.

Oh, yes please.

That was just because somebody had a personal preference for this coding style and it resulted in at least one CVE entry for amdgpu a couple of years ago.

I should have pushed back on this harder when I've seen it initially.

> 
> Signed-off-by: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_bo_list.c | 86 ++++++++++-----------
>  drivers/gpu/drm/amd/amdgpu/amdgpu_bo_list.h | 17 ++--
>  drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c      | 58 +++++++-------
>  3 files changed, 75 insertions(+), 86 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_bo_list.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_bo_list.c
> index 628d32fd2fae..0ab307317145 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_bo_list.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_bo_list.c
> @@ -67,9 +67,9 @@ static int amdgpu_bo_list_entry_cmp(const void *_a, const void *_b)
>  	return 0;
>  }
>  
> -int amdgpu_bo_list_create(struct amdgpu_device *adev, struct drm_file *filp,
> -			  struct drm_amdgpu_bo_list_entry *info,
> -			  size_t num_entries, struct amdgpu_bo_list **result)
> +struct amdgpu_bo_list *
> +amdgpu_bo_list_create(struct amdgpu_device *adev, struct drm_file *filp,
> +		      struct drm_amdgpu_bo_list_entry *info, size_t num_entries)
>  {
>  	unsigned last_entry = 0, first_userptr = num_entries;
>  	struct amdgpu_bo_list_entry *array;
> @@ -80,7 +80,7 @@ int amdgpu_bo_list_create(struct amdgpu_device *adev, struct drm_file *filp,
>  
>  	list = kvzalloc(struct_size(list, entries, num_entries), GFP_KERNEL);
>  	if (!list)
> -		return -ENOMEM;
> +		return ERR_PTR(-ENOMEM);
>  
>  	kref_init(&list->refcount);
>  
> @@ -136,8 +136,7 @@ int amdgpu_bo_list_create(struct amdgpu_device *adev, struct drm_file *filp,
>  	trace_amdgpu_cs_bo_status(list->num_entries, total_size);
>  
>  	mutex_init(&list->bo_list_mutex);
> -	*result = list;
> -	return 0;
> +	return list;
>  
>  error_free:
>  	for (i = 0; i < last_entry; ++i)
> @@ -145,24 +144,21 @@ int amdgpu_bo_list_create(struct amdgpu_device *adev, struct drm_file *filp,
>  	for (i = first_userptr; i < num_entries; ++i)
>  		amdgpu_bo_unref(&array[i].bo);
>  	kvfree(list);
> -	return r;
> +	return ERR_PTR(r);
>  
>  }
>  
> -int amdgpu_bo_list_get(struct amdgpu_fpriv *fpriv, u32 id,
> -		       struct amdgpu_bo_list **result)
> +struct amdgpu_bo_list *amdgpu_bo_list_get(struct amdgpu_fpriv *fpriv, u32 id)
>  {
>  	struct amdgpu_bo_list *list;
>  
>  	xa_lock(&fpriv->bo_list_handles);
>  	list = xa_load(&fpriv->bo_list_handles, id);
> -	if (list && !kref_get_unless_zero(&list->refcount))
> -		list = NULL;
> +	if (!list || !kref_get_unless_zero(&list->refcount))
> +		list = ERR_PTR(-ENOENT);
>  	xa_unlock(&fpriv->bo_list_handles);
>  
> -	*result = list;
> -
> -	return list ? 0 : -ENOENT;
> +	return list;
>  }
>  
>  void amdgpu_bo_list_put(struct amdgpu_bo_list *list)
> @@ -170,8 +166,8 @@ void amdgpu_bo_list_put(struct amdgpu_bo_list *list)
>  	kref_put(&list->refcount, amdgpu_bo_list_free);
>  }
>  
> -int amdgpu_bo_create_list_entry_array(struct drm_amdgpu_bo_list_in *in,
> -				      struct drm_amdgpu_bo_list_entry **info_param)
> +struct drm_amdgpu_bo_list_entry *
> +amdgpu_bo_create_list_entry_array(struct drm_amdgpu_bo_list_in *in)
>  {
>  	const uint32_t info_size = sizeof(struct drm_amdgpu_bo_list_entry);
>  	const void __user *uptr = u64_to_user_ptr(in->bo_info_ptr);
> @@ -182,27 +178,24 @@ int amdgpu_bo_create_list_entry_array(struct drm_amdgpu_bo_list_in *in,
>  	/* copy the handle array from userspace to a kernel buffer */
>  	if (likely(info_size == bo_info_size)) {
>  		info = vmemdup_array_user(uptr, bo_number, info_size);
> -		if (IS_ERR(info))
> -			return PTR_ERR(info);
>  	} else {
>  		const uint32_t bytes = min(bo_info_size, info_size);
>  		unsigned i;
>  
>  		info = kvmalloc_array(bo_number, info_size, GFP_KERNEL);
>  		if (!info)
> -			return -ENOMEM;
> +			return ERR_PTR(-ENOMEM);
>  
>  		memset(info, 0, bo_number * info_size);
>  		for (i = 0; i < bo_number; ++i, uptr += bo_info_size) {
>  			if (copy_from_user(&info[i], uptr, bytes)) {
>  				kvfree(info);
> -				return -EFAULT;
> +				return ERR_PTR(-EFAULT);
>  			}
>  		}
>  	}
>  
> -	*info_param = info;
> -	return 0;
> +	return info;
>  }
>  
>  int amdgpu_bo_list_ioctl(struct drm_device *dev, void *data,
> @@ -210,27 +203,24 @@ int amdgpu_bo_list_ioctl(struct drm_device *dev, void *data,
>  {
>  	struct amdgpu_fpriv *fpriv = filp->driver_priv;
>  	struct amdgpu_device *adev = drm_to_adev(dev);
> -	struct drm_amdgpu_bo_list_entry *info = NULL;
>  	struct amdgpu_bo_list *list, *prev, *curr;
> -	uint32_t handle = args->in.list_handle;
>  	union drm_amdgpu_bo_list *args = data;
> +	uint32_t handle = args->in.list_handle;
> +	struct drm_amdgpu_bo_list_entry *info;
>  	int r;
>  
> -	r = amdgpu_bo_create_list_entry_array(&args->in, &info);
> -	if (r)
> -		return r;
> -
>  	switch (args->in.operation) {
>  	case AMDGPU_BO_LIST_OP_CREATE:
> -		r = amdgpu_bo_list_create(adev, filp, info, args->in.bo_number,
> -					  &list);
> -		if (r)
> -			goto error_free;
> +	case AMDGPU_BO_LIST_OP_UPDATE:
> +		info = amdgpu_bo_create_list_entry_array(&args->in);
> +		if (IS_ERR(info))
> +			return PTR_ERR(info);
>  
> -		r = xa_alloc(&fpriv->bo_list_handles, &handle, list,
> -			     xa_limit_32b, GFP_KERNEL);
> -		if (r)
> -			goto error_put_list;
> +		list = amdgpu_bo_list_create(adev, filp, info,
> +					     args->in.bo_number);
> +		kvfree(info);
> +		if (IS_ERR(list))
> +			return PTR_ERR(list);
>  
>  		break;
>  
> @@ -242,12 +232,20 @@ int amdgpu_bo_list_ioctl(struct drm_device *dev, void *data,
>  
>  		break;
>  
> -	case AMDGPU_BO_LIST_OP_UPDATE:
> -		r = amdgpu_bo_list_create(adev, filp, info, args->in.bo_number,
> -					  &list);
> +	default:
> +		return -EINVAL;
> +	};
> +
> +	switch (args->in.operation) {
> +	case AMDGPU_BO_LIST_OP_CREATE:
> +		r = xa_alloc(&fpriv->bo_list_handles, &handle, list,
> +			     xa_limit_32b, GFP_KERNEL);
>  		if (r)
> -			goto error_free;
> +			goto error_put_list;
>  
> +		break;
> +
> +	case AMDGPU_BO_LIST_OP_UPDATE:
>  		curr = xa_load(&fpriv->bo_list_handles, handle);
>  		if (!curr) {
>  			r = -ENOENT;
> @@ -267,21 +265,17 @@ int amdgpu_bo_list_ioctl(struct drm_device *dev, void *data,
>  		amdgpu_bo_list_put(curr);
>  		break;
>  
> +	case AMDGPU_BO_LIST_OP_DESTROY:
>  	default:
> -		r = -EINVAL;
> -		goto error_free;
> +		/* Handled above. */

I think I prefer to keep that a single switch statement. This looks a bit mixed up to me.

>  	}
>  
>  	memset(args, 0, sizeof(*args));
>  	args->out.list_handle = handle;
> -	kvfree(info);
>  
>  	return 0;
>  
>  error_put_list:
>  	amdgpu_bo_list_put(list);
> -
> -error_free:
> -	kvfree(info);
>  	return r;
>  }
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_bo_list.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_bo_list.h
> index 0989f1090c63..085ca94f97a2 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_bo_list.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_bo_list.h
> @@ -58,17 +58,16 @@ struct amdgpu_bo_list {
>  	struct amdgpu_bo_list_entry entries[] __counted_by(num_entries);
>  };
>  
> -int amdgpu_bo_list_get(struct amdgpu_fpriv *fpriv, u32 id,
> -		       struct amdgpu_bo_list **result);
> +struct amdgpu_bo_list *amdgpu_bo_list_get(struct amdgpu_fpriv *fpriv, u32 id);
>  void amdgpu_bo_list_put(struct amdgpu_bo_list *list);
> -int amdgpu_bo_create_list_entry_array(struct drm_amdgpu_bo_list_in *in,
> -				      struct drm_amdgpu_bo_list_entry **info_param);
> +struct drm_amdgpu_bo_list_entry *
> +amdgpu_bo_create_list_entry_array(struct drm_amdgpu_bo_list_in *in);
>  
> -int amdgpu_bo_list_create(struct amdgpu_device *adev,
> -				 struct drm_file *filp,
> -				 struct drm_amdgpu_bo_list_entry *info,
> -				 size_t num_entries,
> -				 struct amdgpu_bo_list **list);
> +struct amdgpu_bo_list *
> +amdgpu_bo_list_create(struct amdgpu_device *adev,
> +		      struct drm_file *filp,
> +		      struct drm_amdgpu_bo_list_entry *info,
> +		      size_t num_entries);
>  
>  #define amdgpu_bo_list_for_each_entry(e, list) \
>  	for (e = list->entries; \
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
> index 203223fd0b54..a4cdaebaefe5 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
> @@ -152,24 +152,19 @@ static int amdgpu_cs_p1_bo_handles(struct amdgpu_cs_parser *p,
>  				   struct drm_amdgpu_bo_list_in *data)
>  {
>  	struct drm_amdgpu_bo_list_entry *info;
> -	int r;
> +	struct amdgpu_bo_list *list;
>  
> -	r = amdgpu_bo_create_list_entry_array(data, &info);
> -	if (r)
> -		return r;
> -
> -	r = amdgpu_bo_list_create(p->adev, p->filp, info, data->bo_number,
> -				  &p->bo_list);
> -	if (r)
> -		goto error_free;
> +	info = amdgpu_bo_create_list_entry_array(data);
> +	if (IS_ERR(info))
> +		return PTR_ERR(info);
>  
> +	list = amdgpu_bo_list_create(p->adev, p->filp, info, data->bo_number);
>  	kvfree(info);
> +	if (IS_ERR(list))
> +		return PTR_ERR(list);
> +
> +	p->bo_list = list;
>  	return 0;
> -
> -error_free:
> -	kvfree(info);
> -
> -	return r;
>  }
>  
>  /* Copy the data from userspace and go over it the first time */
> @@ -857,6 +852,7 @@ static int amdgpu_cs_parser_bos(struct amdgpu_cs_parser *p,
>  {
>  	struct amdgpu_fpriv *fpriv = p->filp->driver_priv;
>  	struct ttm_operation_ctx ctx = { true, false };
> +	struct amdgpu_bo_list *list = NULL;
>  	struct amdgpu_vm *vm = &fpriv->vm;
>  	struct amdgpu_bo_list_entry *e;
>  	struct drm_gem_object *obj;
> @@ -869,25 +865,26 @@ static int amdgpu_cs_parser_bos(struct amdgpu_cs_parser *p,
>  		if (p->bo_list)
>  			return -EINVAL;
>  
> -		r = amdgpu_bo_list_get(fpriv, cs->in.bo_list_handle,
> -				       &p->bo_list);
> -		if (r)
> -			return r;
> +		list = amdgpu_bo_list_get(fpriv, cs->in.bo_list_handle);
>  	} else if (!p->bo_list) {
>  		/* Create a empty bo_list when no handle is provided */

I think we can drop this handling.

This was just a broken fallback for the closed source driver which the OpenGL stack never used, need to double check with the RADV guys but I don't think they ever used this as well.

Looks good to me otherwise,
Christian.

> -		r = amdgpu_bo_list_create(p->adev, p->filp, NULL, 0,
> -					  &p->bo_list);
> -		if (r)
> -			return r;
> +		list = amdgpu_bo_list_create(p->adev, p->filp, NULL, 0);
>  	}
>  
> -	mutex_lock(&p->bo_list->bo_list_mutex);
> +	if (IS_ERR(list))
> +		return PTR_ERR(list);
> +	else if (list)
> +		p->bo_list = list;
> +	else
> +		list = p->bo_list;
> +
> +	mutex_lock(&list->bo_list_mutex);
>  
>  	/* Get userptr backing pages. If pages are updated after registered
>  	 * in amdgpu_gem_userptr_ioctl(), amdgpu_cs_list_validate() will do
>  	 * amdgpu_ttm_backend_bind() to flush and invalidate new pages
>  	 */
> -	amdgpu_bo_list_for_each_userptr_entry(e, p->bo_list) {
> +	amdgpu_bo_list_for_each_userptr_entry(e, list) {
>  		bool userpage_invalidated = false;
>  		struct amdgpu_bo *bo = e->bo;
>  
> @@ -915,7 +912,7 @@ static int amdgpu_cs_parser_bos(struct amdgpu_cs_parser *p,
>  		if (unlikely(r))
>  			goto out_free_user_pages;
>  
> -		amdgpu_bo_list_for_each_entry(e, p->bo_list) {
> +		amdgpu_bo_list_for_each_entry(e, list) {
>  			/* One fence for TTM and one for each CS job */
>  			r = drm_exec_prepare_obj(&p->exec, &e->bo->tbo.base,
>  						 1 + p->gang_size);
> @@ -935,7 +932,7 @@ static int amdgpu_cs_parser_bos(struct amdgpu_cs_parser *p,
>  		}
>  	}
>  
> -	amdgpu_bo_list_for_each_userptr_entry(e, p->bo_list) {
> +	amdgpu_bo_list_for_each_userptr_entry(e, list) {
>  		struct mm_struct *usermm;
>  
>  		usermm = amdgpu_ttm_tt_get_usermm(e->bo->tbo.ttm);
> @@ -988,17 +985,16 @@ static int amdgpu_cs_parser_bos(struct amdgpu_cs_parser *p,
>  				     p->bytes_moved_vis);
>  
>  	for (i = 0; i < p->gang_size; ++i)
> -		amdgpu_job_set_resources(p->jobs[i], p->bo_list->gds_obj,
> -					 p->bo_list->gws_obj,
> -					 p->bo_list->oa_obj);
> +		amdgpu_job_set_resources(p->jobs[i], list->gds_obj,
> +					 list->gws_obj, list->oa_obj);
>  	return 0;
>  
>  out_free_user_pages:
> -	amdgpu_bo_list_for_each_userptr_entry(e, p->bo_list) {
> +	amdgpu_bo_list_for_each_userptr_entry(e, list) {
>  		amdgpu_hmm_range_free(e->range);
>  		e->range = NULL;
>  	}
> -	mutex_unlock(&p->bo_list->bo_list_mutex);
> +	mutex_unlock(&list->bo_list_mutex);
>  	return r;
>  }
>  

