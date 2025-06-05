Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3BE89C5B543
	for <amd-gfx@archiver.kernel.org>; Thu,  5 Jun 2025 12:11:18 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CEF4810E9B7;
	Thu,  5 Jun 2025 12:11:17 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="L7QdIRez";
	dkim-atps=neutral
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2060.outbound.protection.outlook.com [40.107.94.60])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A9EF110E8BD
 for <amd-gfx@lists.freedesktop.org>; Thu,  5 Jun 2025 12:11:16 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jNBaPEhGlTLuJ4DN3ZrR2vLeesq0J+7Nu+AbHM8On1uYcSrb7zhqO9RiodvUNqVnym5lZsA0TrVRde3fKH0OD+oZdayhvd86O5TPz41cWOhe7ptE0cKooCIe749XFYpwfNOHYM64ZLS5geHMDuPdnEx9qswZgCCYT9rp5O3kt+iQk9dbYHHPKy79gDQdO7jZvCpfVTnTDVZFveORv5OBbQ4xbdU6QPLMPlAf6UA1c3jGlXoQxMssmN6fCsqGcwG0jWrPyyKxB+MFBlEVN2/zEnuReizAdR8mi6kBWkhRDdOBhUnGa1nLodRxDKWMQdJCFcbv6UmG5LLBbXn17d7hNA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JQ3aTQm8K9h3XKpPriPlV0nbcEzFK1nmfW8/o8OUE08=;
 b=FICMx+1twBO7xjSD/PSTqiNviIeGgQ1RJRyYUiQpKNKm6AtaWVz76HnEsyr6/1mCwCYxJzfxMiveuqccWZPWAuhVSo1gBx83dfCzgBm9P4exHiWStzLnlhkcoR05HgObttveyDRcvYNRBAHsi6gMxyWwS4S+CBam4AvGkBHsWdPXC+cqZWStCps+Gw4Qce3fbpYr1jId0WBlu4HjS0rnc7EqHK+lpOlzz5Qi2qWHcO1GwNINJoQqpArv7SlEGLDmjSy4vvnnLtc27EzTQAcl06HsNSBZjq4OLV3D3WH5tfnkh4XmDj9Hoxat3fDtQdkfPvDJCkOHoPrC0jk+oSZEBw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JQ3aTQm8K9h3XKpPriPlV0nbcEzFK1nmfW8/o8OUE08=;
 b=L7QdIRezGOIL+ouYaycnY8ZkTXdHr4wKpewpYVMtu4PCZqH+/MqG/a2Xnnzs/HZKhGBFxcQkUJr/MIqNT4sMJxL8/Pqi+n4IuRe8UOIHPY6wO+k1oHIV3+3tNygoQiAxJfCpLTWQjzfgZ8EA3NHqvp0ygxGXVwsb4paS7G4bqZo=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by LV8PR12MB9155.namprd12.prod.outlook.com (2603:10b6:408:183::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8769.24; Thu, 5 Jun
 2025 12:11:12 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5%7]) with mapi id 15.20.8722.031; Thu, 5 Jun 2025
 12:11:12 +0000
Message-ID: <85f49273-1525-4504-9fc2-e06cefd96b98@amd.com>
Date: Thu, 5 Jun 2025 14:11:07 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 08/31] drm/amdgpu: track ring state associated with a job
To: Alex Deucher <alexander.deucher@amd.com>, amd-gfx@lists.freedesktop.org
References: <20250605014602.5915-1-alexander.deucher@amd.com>
 <20250605014602.5915-9-alexander.deucher@amd.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20250605014602.5915-9-alexander.deucher@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0307.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:f6::20) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|LV8PR12MB9155:EE_
X-MS-Office365-Filtering-Correlation-Id: 886eb6a5-cbc2-4e77-b852-08dda42a1032
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?QzNXV2h4VUFITXU1LzVucUpyTDVsSTRtZW5keCtyUE0xUlNySGMyOTlRMW5Q?=
 =?utf-8?B?Q1dTenVLMGZ0UVorNXBLYUJwOUR0b21UbEVXd2M5V2VsaVFzbGVVNm44d01U?=
 =?utf-8?B?TFlDTEcxTFJ2Z1oxdElhZ01Rc0lpTzdPWFZHOEdrWk9LV0ZtYUIzdk5sUjR0?=
 =?utf-8?B?dVJacXJWVG1NY0Y1VG84M1NweUovV1krOTBCNnZHUFFpK3N0c0xURmtwK29L?=
 =?utf-8?B?TlNKWk84K0ZnbTZmb3hRRDRRVDA0MDRLQXhrMWt5UVFJWVRlcVRkR3ZDSXMy?=
 =?utf-8?B?dmV1TEtTaVFSeEpnQktvMVpCMmcrY3Q5MzZoT3M2T1pzNUl6MjRDa3ppQy9P?=
 =?utf-8?B?WDh0ajlKUGhORHNRQ2ZhNnFwTXJ4S0pwZ3krL0hOQ1AwMUcvS0R4cit5cUty?=
 =?utf-8?B?NVU5MVczblN1Z0JwOWNsVVZkdFRlRllqWTBSMi9aQzhrcXljemMvVm5XZ2xp?=
 =?utf-8?B?VHQ0eEVjZEh2RDNHdFNwSmJGK1VMU2tjVXBWTUNPTUhXME1TK0tNUkRtZWo0?=
 =?utf-8?B?VTA1ZVN4bUoyNW12ZUxvQlM5c0poTnNuMnBHeGgxMFo4cXZ2cHhiUk4rSEhZ?=
 =?utf-8?B?V2E0bzJ5WGtQRmw3bFBNVitGYUh2QU1KMndqM0VaakhJYklWcVRNSEQ5SzhH?=
 =?utf-8?B?NlVxSit2STVJUmd2WDc2VmZ4aThpQy9zUmdCSjlOdk9TL0EyZDBZWnRiVzRY?=
 =?utf-8?B?NUcvcC9xaEtJWkFxd1F4RGFld3V1MWRleGIxei83QlhYb2dGZ28ySkxkMWhB?=
 =?utf-8?B?WWNBOXdoZU5kdlU3T2pHSitOeUtzL3hwWFViU3BXK0p5K3Y1ZDFSdE9qNFhJ?=
 =?utf-8?B?b0JZd2FKZzVxekNoSUlETHZJb2xGRk9zMHVoQ3JZQitlclV3cVJOVnB5ZUVk?=
 =?utf-8?B?OXZPeW5VazhpNHF6ajAvMkhwMlB4TjBRcWJLR0twYkp3cjVCOGw3UDRBRVV3?=
 =?utf-8?B?cUs5UG1aNnEvSWhITlFpQ2x6UzFtcWNqLzlxSERLT1ppUmdrMmxUM1JsSjJj?=
 =?utf-8?B?MG5ucE5hcEVBRjlVRm0xK09Mc1ZsTkF3S3ZmUHdHcjU4ZHo2MWF6dVAxNko1?=
 =?utf-8?B?MnJiOUEwSUtLaWRjSkVVWkZTbXhmeTdPQWlEcUZjNUhVblUzYnFVYVRPTzFB?=
 =?utf-8?B?bXMvTGo5SmpsTXBoSTJKa1JMWTJ0dlBlN0h0eURCbTVYKzBTaXJoTW80VEVx?=
 =?utf-8?B?M0ZUb1EwRU5yeUliVkV0SmxHV0NPUkRzWWc4Q2ViRTZLdFg3aWtuYzV4OWcw?=
 =?utf-8?B?RWZKV0VYd05NNyszVER0K2UwMDBPVmp5ZFRsU0w3aEo2d2VIaUdDdE82Unpj?=
 =?utf-8?B?dmlsOUhWUnUwTFVjVHkzaStaRTBUaXBaWkVFaWlPZEdnRDRNangybGNXR1FP?=
 =?utf-8?B?dEh1Qi9EUDNyREJZVHJrKytnd0RKeDFPQzcwa2hYYlNaUWJtWTM5RHJNZjdE?=
 =?utf-8?B?NWFBTXAzRUJ0eUQrdy9TZnJxMXM1T21KY0hjM0IycFJYd2JrdDF4S1JrRS93?=
 =?utf-8?B?V3FiRHNIbVFjY05XSjJrRHRDVUxYYkFhODBwQWZXejhnY2dvSkh5bEJLOG1G?=
 =?utf-8?B?d1FJV0JaTlZNOGc5NUQzS0J3MWR1ajlaa2lIZkdVbUhWQU5xSVF1NzhJS284?=
 =?utf-8?B?YUhxSDV0aklQQTUwOTJ5MERyYkxSOEx3dTJ4U2NYQnZuTDBlZG54dHhPUjRH?=
 =?utf-8?B?ZnVjaFQ0NVZZeGJwemp6UEFVSDdNNTZvYzg0ZnFBTTA0cmVDQ2dvbEplYmZT?=
 =?utf-8?B?VU9MWDlXdGJ3WS81bjlrRmhIbHM1SlVIdGFWeTVVOUJxZ25qMFlaM0xUeVFS?=
 =?utf-8?B?WVJFSWNOWFQwaEw1NmY5ZDBVZHZKZm9OdEY3TWkzRjJNOGVUMHUvOXJrSTlW?=
 =?utf-8?B?NEtvMXl3Qi9ZVklBczlJeUJHKzQ5VGZ6TzM0NENkQ2dIb3RwM1ZqcDNJWWZ4?=
 =?utf-8?Q?dmsg/NJ00sc=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?L0Y0ckx5NGI0MHVDWHp6OXBhNlVOcGJGN0d0NFVOV2pGNGtRNmdVTFlpZEth?=
 =?utf-8?B?c20wS1VPZlZycFh3S3BId1N0U2FQTzdvZEVGdkJkb2l4QlFMMFBrMUdPWno3?=
 =?utf-8?B?YzBsS2tsbHZwclhDTEt0ZjNucnBHMnlGdkVUMUdSVFBpQUJiWmU0am5CQkc5?=
 =?utf-8?B?cWhOT3hWcXp2RWt5M3pwalJNSTkzVmJXTjM0OEZwTkNXQytjZGFZaDNYSmU2?=
 =?utf-8?B?TEg0NnlGMHRJZDdYVlI0MWtENGR1SENGZ1llbG5zVjBBZ1g2cFZYSnpiLzhU?=
 =?utf-8?B?WEpzZVo4UFQwaW43b3M4V3FycXdBaWJtcHRJQmZocGs1Y05lOSsrdks3SzZC?=
 =?utf-8?B?Q1puTmdRbDYveWROWVdiSU9QNVFEM2hyWUp5eFNZekxDUHdENHB4VHV2eGtY?=
 =?utf-8?B?Vk8zeFBUclFYZ0NFZ0tCTkNhaDlNdFlVK2kyVExJMW1kTlRsTEI1YmhXbXlv?=
 =?utf-8?B?cVdRZDRLdGRZd0s2Tmhaa1N2RnoybTJEaUFyZWJsK216N0lwZnFmYVBYWFky?=
 =?utf-8?B?RlpIOG5lTW1aalJvLzlwMTRCWmJuN0ZkLzJMQjRjNStBbWU1bEYwdElyZmFS?=
 =?utf-8?B?VEJrZGRlN01pVVRPZm5KUm4rRytoQnVRTDJVdHgvem1jejlHaS8vV1lYKytz?=
 =?utf-8?B?VitVQ1RsZk5FaFVDVzJ2aFhCUnQ5MFB4UUpzSkFBcmZPTzRoNDl1YUNUeUlO?=
 =?utf-8?B?N1V1Q2RyMVlFSXY4TEFmWEhKQ0V2Vnd4MUtBR3VYOXlINlg0U1BzWFNRMFZj?=
 =?utf-8?B?UnpzOUMwS2pWc0Q0V2xlY1ZaVnhaZzNxMXUxK3lUbTltajBOZjRXTmRSUXQ5?=
 =?utf-8?B?eVY5bDFGUzZhaWZYMlpPbGttdDdHQjVZdjdrSDJzZlhTOXN6Vm9JcllyWm9Y?=
 =?utf-8?B?TWxBcDdxS1ZYRm1pVjY4aEp5UGdxTlByeU5vT2k0NDRHR2srMU1wa2ZhRmcx?=
 =?utf-8?B?czNpa1c5RVlHQWllNEtmRHROU1BQTFB3RDJpTDhvcTFKQThGTmhpMjE3dE5q?=
 =?utf-8?B?bVY5NHdwcnlQUWZ3blhPVEY5bFBuQmxCSEpoUUhXNVF4bkU1K2EyM3BCNitq?=
 =?utf-8?B?eEdQYTNsMjBGZzIwcFlsOEMvUWZhVDU2SWx1em9BdDFZREJLd3V3c013WUNv?=
 =?utf-8?B?Vi91am10YXpzSkpIYjNONUYyNG50N2FyQzZaL0xKbkJjWWJsSW9MMmFnZHN0?=
 =?utf-8?B?UjN5UjcwSWZTbGVudGFwNG9selVSOTJsdHlwckJqbHdDOGhlcnl4K21MbmVu?=
 =?utf-8?B?dmljanorakoxZW5ZUVNiZXRlZG4xZlVSMEltM3duWVNsaXk0TlVISEcwZHRG?=
 =?utf-8?B?OEIzLzBUc0I0dDVCOXBzYnR4aTBvdnVBS2JOWHEvd1oyci83RnJDbm1YNWJa?=
 =?utf-8?B?YlY0QWJBQzB2alplTDl1SHRVTXhmek1JdGhubmk1bms4NHFiSzNoUFBlTU8x?=
 =?utf-8?B?UzNUdllMSU1vQUorSVlBSUs1ME9jbzVEUllmNUFpT2Nua0ZZK2MzdzYrdE1W?=
 =?utf-8?B?QlJpR1VnWUE3MGxwb3NTdkNaS1A2MGlFczlGUTFaSFFTQlY2Nk4rN0VqZFpO?=
 =?utf-8?B?a3ozeXg2bE5rOXBYR09qMk9UUWR4dm5MMDczOWl1bEhFbEJZMmROTjRyVTBI?=
 =?utf-8?B?eGVybTJoYmc2SkIzZk10RTlNdTZjbGY0cDIybDA0My96MWVJZjNaSVRoaUky?=
 =?utf-8?B?aVNHQ0VIdFYvRitXZ3hyRW8vSWhkVE9sOUZrbENsMFk5NmxYeEJEaEhQUm9Q?=
 =?utf-8?B?T0tEZWpndWNDb2hxOGhhZVRSSHV0VnVXYzJhdnl5bzZjdVcrVjFmMXhZRjd3?=
 =?utf-8?B?OTF6Q3hUWXdNQWx6OEtGSWQ4MS81ZWNTRlhhSWVSV1hOczgxVm1qMWNVaSsv?=
 =?utf-8?B?K1NPbkF4dDFjUHVJcnN5UlRUNnFvY1h4QWlpbncvelZHM1dVZHA1dXQ2VU45?=
 =?utf-8?B?VmdoTWN1L1NNMDRnSkoxbFZTNXNJaEZlM1g3L1lFZ0ZMczJTdk04aitBMmgy?=
 =?utf-8?B?OTlXeDIwTG9KemY4YXRHTUs2elc2cVRXczRGLzlkNWVIcGFISEpsRC9PM1Rw?=
 =?utf-8?B?MUZNS2VpWEJPVC83NFF0d1BPK0RFQ2VUd3hnLzZKbGgyUTJ2RmtMcjQvdk0x?=
 =?utf-8?Q?oxQU=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 886eb6a5-cbc2-4e77-b852-08dda42a1032
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jun 2025 12:11:12.5306 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VFYeqC13uZeBfv+K3Q8WhPTGIodCMGK/4zOGiLFTgGfJPqyZR1AiakCT2T6XMRnj
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR12MB9155
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

On 6/5/25 03:45, Alex Deucher wrote:
> We need to know the wptr and sequence number associated
> with a job so that we can re-emit the unprocessed state
> after a ring reset.  Pre-allocate storage space for
> the ring buffer contents and add a helper to save off
> the unprocessed state so that it can be re-emitted
> after the queue is reset.
> 
> Add a helper that ring reset callbacks can use to verify
> that the ring has reset successfully and to reemit any
> unprocessed ring contents from subsequent jobs.
> 
> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c | 15 ++++
>  drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c    | 13 +++-
>  drivers/gpu/drm/amd/amdgpu/amdgpu_job.c   | 11 ++-
>  drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c  | 92 +++++++++++++++++++++++
>  drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h  | 15 ++++
>  5 files changed, 143 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c
> index 569e0e5373927..25a664273bf0d 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c
> @@ -141,6 +141,9 @@ int amdgpu_fence_emit(struct amdgpu_ring *ring, struct dma_fence **f, struct amd
>  	}
>  	fence = &am_fence->base;
>  	am_fence->ring = ring;
> +	am_fence->start_ring_wptr = 0;
> +	am_fence->end_ring_wptr = 0;

Why do we need the start here? I would just keep the end around and then jump from fence to fence while re-submitting them.

> +	am_fence->context = 0;
>  
>  	seq = ++ring->fence_drv.sync_seq;
>  	if (job && job->job_run_counter) {
> @@ -748,6 +751,18 @@ void amdgpu_fence_driver_force_completion(struct amdgpu_ring *ring)
>  	amdgpu_fence_process(ring);
>  }
>  
> +/**
> + * amdgpu_fence_driver_seq_force_completion - force signal of specified sequence
> + *
> + * @ring: fence of the ring to signal
> + *
> + */
> +void amdgpu_fence_driver_seq_force_completion(struct amdgpu_ring *ring, u32 seq)

Better give the full fence structure here.

> +{
> +	amdgpu_fence_write(ring, seq);
> +	amdgpu_fence_process(ring);
> +}
> +
>  /*
>   * Common fence implementation
>   */
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c
> index 802743efa3b39..636941697a740 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c
> @@ -126,7 +126,9 @@ int amdgpu_ib_schedule(struct amdgpu_ring *ring, unsigned int num_ibs,
>  		       struct dma_fence **f)
>  {
>  	struct amdgpu_device *adev = ring->adev;
> +	u64 start_ring_wptr, end_ring_wptr;
>  	struct amdgpu_ib *ib = &ibs[0];
> +	struct amdgpu_fence *am_fence;
>  	struct dma_fence *tmp = NULL;
>  	bool need_ctx_switch;
>  	struct amdgpu_vm *vm;
> @@ -138,7 +140,6 @@ int amdgpu_ib_schedule(struct amdgpu_ring *ring, unsigned int num_ibs,
>  	int vmid = AMDGPU_JOB_GET_VMID(job);
>  	bool need_pipe_sync = false;
>  	unsigned int cond_exec;
> -
>  	unsigned int i;
>  	int r = 0;
>  
> @@ -187,6 +188,7 @@ int amdgpu_ib_schedule(struct amdgpu_ring *ring, unsigned int num_ibs,
>  		dev_err(adev->dev, "scheduling IB failed (%d).\n", r);
>  		return r;
>  	}
> +	start_ring_wptr = ring->wptr;
>  
>  	need_ctx_switch = ring->current_ctx != fence_ctx;
>  	if (ring->funcs->emit_pipeline_sync && job &&
> @@ -306,6 +308,15 @@ int amdgpu_ib_schedule(struct amdgpu_ring *ring, unsigned int num_ibs,
>  
>  	amdgpu_ring_ib_end(ring);
>  	amdgpu_ring_commit(ring);
> +	/* This must be last for resets to work properly
> +	 * as we need to save the wptr associated with this
> +	 * fence.
> +	 */
> +	end_ring_wptr = ring->wptr;
> +	am_fence = container_of(*f, struct amdgpu_fence, base);
> +	am_fence->start_ring_wptr = start_ring_wptr;
> +	am_fence->end_ring_wptr = end_ring_wptr;

The end_ring_wptr variable is superflous and I would put assigning that into a helper in amdgpu_fence.c

> +
>  	return 0;
>  }
>  
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c
> index 23b6a0fc0c691..73c26e2e01647 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c
> @@ -89,8 +89,9 @@ static enum drm_gpu_sched_stat amdgpu_job_timedout(struct drm_sched_job *s_job)
>  {
>  	struct amdgpu_ring *ring = to_amdgpu_ring(s_job->sched);
>  	struct amdgpu_job *job = to_amdgpu_job(s_job);
> -	struct amdgpu_task_info *ti;
> +	struct amdgpu_fence *am_fence = &job->hw_fence;
>  	struct amdgpu_device *adev = ring->adev;
> +	struct amdgpu_task_info *ti;
>  	bool set_error = false;
>  	int idx, r;
>  
> @@ -154,7 +155,8 @@ static enum drm_gpu_sched_stat amdgpu_job_timedout(struct drm_sched_job *s_job)
>  		else
>  			is_guilty = true;
>  
> -		if (is_guilty)
> +		amdgpu_ring_backup_unprocessed_jobs(ring, is_guilty, am_fence);
> +		if (is_guilty) {
>  			dma_fence_set_error(&s_job->s_fence->finished, -ETIME);
>  			set_error = true;
>  		}
> @@ -409,6 +411,7 @@ static struct dma_fence *amdgpu_job_run(struct drm_sched_job *sched_job)
>  	struct amdgpu_ring *ring = to_amdgpu_ring(sched_job->sched);
>  	struct amdgpu_device *adev = ring->adev;
>  	struct dma_fence *fence = NULL, *finished;
> +	struct amdgpu_fence *am_fence;
>  	struct amdgpu_job *job;
>  	int r = 0;
>  
> @@ -433,6 +436,10 @@ static struct dma_fence *amdgpu_job_run(struct drm_sched_job *sched_job)
>  				"Error scheduling IBs (%d) in ring(%s)", r,
>  				ring->name);
>  	}
> +	if (fence && finished) {
> +		am_fence = container_of(fence, struct amdgpu_fence, base);
> +		am_fence->context = finished->context;
> +	}

Better put that into amdgpu_fence_emit().

>  
>  	job->job_run_counter++;
>  	amdgpu_job_free_resources(job);
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c
> index 426834806fbf2..3a0e0883bd8e7 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c
> @@ -333,6 +333,12 @@ int amdgpu_ring_init(struct amdgpu_device *adev, struct amdgpu_ring *ring,
>  	/*  Initialize cached_rptr to 0 */
>  	ring->cached_rptr = 0;
>  
> +	if (!ring->ring_backup) {
> +		ring->ring_backup = kvzalloc(ring->ring_size, GFP_KERNEL);
> +		if (!ring->ring_backup)
> +			return -ENOMEM;
> +	}
> +
>  	/* Allocate ring buffer */
>  	if (ring->ring_obj == NULL) {
>  		r = amdgpu_bo_create_kernel(adev, ring->ring_size + ring->funcs->extra_dw, PAGE_SIZE,
> @@ -342,6 +348,7 @@ int amdgpu_ring_init(struct amdgpu_device *adev, struct amdgpu_ring *ring,
>  					    (void **)&ring->ring);
>  		if (r) {
>  			dev_err(adev->dev, "(%d) ring create failed\n", r);
> +			kvfree(ring->ring_backup);
>  			return r;
>  		}
>  		amdgpu_ring_clear_ring(ring);
> @@ -385,6 +392,8 @@ void amdgpu_ring_fini(struct amdgpu_ring *ring)
>  	amdgpu_bo_free_kernel(&ring->ring_obj,
>  			      &ring->gpu_addr,
>  			      (void **)&ring->ring);
> +	kvfree(ring->ring_backup);
> +	ring->ring_backup = NULL;
>  
>  	dma_fence_put(ring->vmid_wait);
>  	ring->vmid_wait = NULL;
> @@ -753,3 +762,86 @@ bool amdgpu_ring_sched_ready(struct amdgpu_ring *ring)
>  
>  	return true;
>  }
> +
> +static void amdgpu_ring_backup_unprocessed_job(struct amdgpu_ring *ring,
> +					       unsigned int idx,
> +					       u64 start_wptr, u32 end_wptr)

Drop the job from all function names.

We are really re-emitting unprocessed commands.

> +{
> +	unsigned int first_idx = start_wptr & ring->buf_mask;
> +	unsigned int last_idx = end_wptr & ring->buf_mask;
> +	unsigned int i, j, entries_to_copy;
> +
> +	if (last_idx < first_idx) {
> +		entries_to_copy = ring->buf_mask + 1 - first_idx;
> +		for (i = 0; i < entries_to_copy; i++)
> +			ring->ring_backup[idx + i] = ring->ring[first_idx + i];
> +		ring->ring_backup_entries_to_copy += entries_to_copy;
> +		entries_to_copy = last_idx;
> +		for (j = 0; j < entries_to_copy; j++)
> +			ring->ring_backup[idx + i + j] = ring->ring[j];
> +		ring->ring_backup_entries_to_copy += entries_to_copy;
> +	} else {
> +		entries_to_copy = last_idx - first_idx;
> +		for (i = 0; i < entries_to_copy; i++)
> +			ring->ring_backup[idx + i] = ring->ring[first_idx + i];
> +		ring->ring_backup_entries_to_copy += entries_to_copy;
> +	}
> +}
> +
> +void amdgpu_ring_backup_unprocessed_jobs(struct amdgpu_ring *ring,
> +					 bool is_guilty,
> +					 struct amdgpu_fence *bad_fence)
> +{
> +	struct amdgpu_fence *fence;
> +	struct dma_fence *old, **ptr;
> +	int i;
> +
> +	ring->ring_backup_entries_to_copy = 0;
> +	for (i = 0; i <= ring->fence_drv.num_fences_mask; i++) {

That is the wrong order for the fences, you need to start/end at the last submitted one.

I strongly suggest to implement that in amdgpu_fence.c

Regards,
Christian.

> +		ptr = &ring->fence_drv.fences[i];
> +		rcu_read_lock();
> +		old = rcu_dereference(*ptr);
> +
> +		if (old && !dma_fence_is_signaled(old)) {
> +			fence = container_of(old, struct amdgpu_fence, base);
> +			/* save everything if the ring is not guilty, otherwise
> +			 * just save the content from other contexts.
> +			 */
> +			if (!is_guilty || (fence->context != bad_fence->context))
> +				amdgpu_ring_backup_unprocessed_job(ring,
> +								   ring->ring_backup_entries_to_copy,
> +								   fence->start_ring_wptr,
> +								   fence->end_ring_wptr);
> +		}
> +		rcu_read_unlock();
> +	}
> +
> +	ring->ring_bad_seq = bad_fence->base.seqno;
> +}
> +
> +int amdgpu_ring_reemit_unprocessed_jobs(struct amdgpu_ring *ring)
> +{
> +	unsigned int i;
> +	int r;
> +
> +	/* verify that the ring is functional */
> +	r = amdgpu_ring_test_ring(ring);
> +	if (r)
> +		return r;
> +	/* re-emit the unprocessed ring contents */
> +	if (ring->ring_backup_entries_to_copy) {
> +		r = amdgpu_ring_alloc(ring, ring->ring_backup_entries_to_copy);
> +		if (r)
> +			return r;
> +		/* signal the fence of the bad job */
> +		amdgpu_fence_driver_seq_force_completion(ring, ring->ring_bad_seq);
> +		for (i = 0; i < ring->ring_backup_entries_to_copy; i++)
> +			amdgpu_ring_write(ring, ring->ring_backup[i]);
> +		amdgpu_ring_commit(ring);
> +	} else {
> +		/* signal the fence of the bad job */
> +		amdgpu_fence_driver_seq_force_completion(ring, ring->ring_bad_seq);
> +	}
> +
> +	return 0;
> +}
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
> index e1f25218943a4..69b71401adb7a 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
> @@ -141,6 +141,12 @@ struct amdgpu_fence {
>  	/* RB, DMA, etc. */
>  	struct amdgpu_ring		*ring;
>  	ktime_t				start_timestamp;
> +
> +	/* wptrs for the fence for resets */
> +	u64				start_ring_wptr;
> +	u64				end_ring_wptr;
> +	/* fence context for resets */
> +	u64				context;
>  };
>  
>  extern const struct drm_sched_backend_ops amdgpu_sched_ops;
> @@ -148,6 +154,8 @@ extern const struct drm_sched_backend_ops amdgpu_sched_ops;
>  void amdgpu_fence_driver_clear_job_fences(struct amdgpu_ring *ring);
>  void amdgpu_fence_driver_set_error(struct amdgpu_ring *ring, int error);
>  void amdgpu_fence_driver_force_completion(struct amdgpu_ring *ring);
> +void amdgpu_fence_driver_seq_force_completion(struct amdgpu_ring *ring,
> +					      u32 seq);
>  
>  int amdgpu_fence_driver_init_ring(struct amdgpu_ring *ring);
>  int amdgpu_fence_driver_start_ring(struct amdgpu_ring *ring,
> @@ -284,6 +292,9 @@ struct amdgpu_ring {
>  
>  	struct amdgpu_bo	*ring_obj;
>  	uint32_t		*ring;
> +	uint32_t		*ring_backup;
> +	unsigned int		ring_backup_entries_to_copy;
> +	uint64_t		ring_bad_seq;
>  	unsigned		rptr_offs;
>  	u64			rptr_gpu_addr;
>  	volatile u32		*rptr_cpu_addr;
> @@ -550,4 +561,8 @@ int amdgpu_ib_pool_init(struct amdgpu_device *adev);
>  void amdgpu_ib_pool_fini(struct amdgpu_device *adev);
>  int amdgpu_ib_ring_tests(struct amdgpu_device *adev);
>  bool amdgpu_ring_sched_ready(struct amdgpu_ring *ring);
> +void amdgpu_ring_backup_unprocessed_jobs(struct amdgpu_ring *ring,
> +					 bool is_guilty,
> +					 struct amdgpu_fence *bad_fence);
> +int amdgpu_ring_reemit_unprocessed_jobs(struct amdgpu_ring *ring);
>  #endif

