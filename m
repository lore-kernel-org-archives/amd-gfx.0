Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E0822C87FCF
	for <amd-gfx@archiver.kernel.org>; Thu,  7 Aug 2025 14:57:01 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8857D10E877;
	Thu,  7 Aug 2025 14:57:01 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="jTFluEwO";
	dkim-atps=neutral
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2069.outbound.protection.outlook.com [40.107.223.69])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6EABC10E874
 for <amd-gfx@lists.freedesktop.org>; Thu,  7 Aug 2025 14:56:59 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oJiAExWaLYRDDPDrw2prv1M+ySM5uY0N1NaXqQRpN1NLWJ63QrY4PQbrE/NKe2osBhjUVs1HkLysuCFQE8Tr2FDVHwryvqZRCxDZ3g6jt8Z0eOuBLD30xF17jAPqq++U93LLER4yKv847pPZpojz5efz3FpqL1sT4Pxq+D2/9UDeWhjQ4iQe4oM6BztimKUADKpf5oHlk3ryRnDETcPiwmo6/jj2YrpiPNwTkn4PoGHe0CYm4cVp/9SiqrexpU34ShQlSH76Zcmsjl1wmXtmFIkiC8O+cqNQwwmU8fs1RHxvDcPt0WsLg4vBn8VcragAlyxoy47JwTD7ZkUDtmQTYA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ofQ7ktKmIc5MAPwiEAkNZpUp6Di5bMKFCbnKxHNSXJQ=;
 b=HoAZjWbPqzO6Z1oPmXa1wkrIUBGDKWcyv6LN5sElmOlBwTlmjM2CBaCYubH1EcVUyA8ovi2FnkruHBz+QD7rk3xIlkKmeLP82bewHHIBHaOxbrkq7Te8ca8DyWqANJlz39WVH5tbG0zgWSh2FWfsbj7VWOUvUBFXYk9mJfBFDsSSCBVnHRQQVxurqqUtqAdDof5XPzcwueC96chok4iw7Scrjp/F6G9FHneHGlRUNNmByKARqv4cJzf0K7noE/MS0zcUWibp4qN3plDXsCZFjF/W1A7cJy2Dpf02N1kGSBHbmPYXs5ZIkAWJODqxkt2nt+7aXAPKxr3La8RFSHuvNA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ofQ7ktKmIc5MAPwiEAkNZpUp6Di5bMKFCbnKxHNSXJQ=;
 b=jTFluEwOIV4QP7hXu+dkiKpZQE6+hHLpTZCISuP0kfw0Zkd4EzRXVG4yJT4IA+v1AlF5HLSFFqiWW5xvpyMkId6gDtc7kTVvs+A1wdy/O16F9j0KE74y8KjE+mTzw2O9SMxph7Rx0O5iWci9ywEl6vR6gQOLcy6He1G5uZ8e5W4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by IA0PR12MB7700.namprd12.prod.outlook.com (2603:10b6:208:430::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9009.16; Thu, 7 Aug
 2025 14:56:56 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5%5]) with mapi id 15.20.8989.018; Thu, 7 Aug 2025
 14:56:56 +0000
Message-ID: <8aa287c0-35ce-445e-9139-2c62c4a54c79@amd.com>
Date: Thu, 7 Aug 2025 16:56:50 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v10 2/3] drm/amdgpu: Add mapping info option for GEM_OP
 ioctl
To: David Francis <David.Francis@amd.com>, amd-gfx@lists.freedesktop.org
Cc: tvrtko.ursulin@igalia.com, Felix.Kuehling@amd.com, David.YatSin@amd.com,
 Chris.Freehill@amd.com, dcostantino@meta.com, sruffell@meta.com,
 mripard@kernel.org, tzimmermann@suse.de, Alexander.Deucher@amd.com
References: <20250807140051.2377470-1-David.Francis@amd.com>
 <20250807140051.2377470-3-David.Francis@amd.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20250807140051.2377470-3-David.Francis@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0375.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:f8::10) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|IA0PR12MB7700:EE_
X-MS-Office365-Filtering-Correlation-Id: df7aeec8-15cd-42d3-25ee-08ddd5c2a706
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?K0FZSDVVZE9pN1VCODRuUHoxTlVYeDFzM0lDTENKci9VbHVzSS9BZzVvazEw?=
 =?utf-8?B?cllHdzlmK1FuZ1J0YjBtU1FuZkZjRllvOGtNUU9yY0RtRmgzYUlEM3YzNWhE?=
 =?utf-8?B?RUQ2cTR3bkFjOVJRamVMeVRzTjkybTJHdXllQ0RiVXRUSWxVdU1nelBEQkJF?=
 =?utf-8?B?VmQ3OWVLWW43YlBSMmo2K05IZitGUmR1TzFZMjVXbG9NNG1iWndlSkl6NjVt?=
 =?utf-8?B?UURxUTk4bm5mM1dyYkt5eG0rMWJWRVZCVEVha1hnOUhIWjJabi8zTzVqS0pZ?=
 =?utf-8?B?Z3dKUnlHQzJuckF6M0hQUUNFd2hIazRZVFY5dVRvS3l4NGF5QlJ6MU4yajYw?=
 =?utf-8?B?REh4TTZNTDJXY0llOEM3YlJUNTYreUlmN0xuMklVLzBVeWh4LzkrQVpmQnE5?=
 =?utf-8?B?dG05VVJkVGpYTG8wcGZXVGdCWHJRbDdwcjB1LzZCajI5aCtXZGkwSG84cE5z?=
 =?utf-8?B?ckF0ZjNEOEV3ZUpQTThoMWsyamNJZ1EraGMyQ3FSb2oxTWJvUGdVVlV4NFlZ?=
 =?utf-8?B?WnkydnJyZGhjZFhML2JMaEpnUU9lZ0ROVkd5YmV3cXplZ3RPUXB3NkVabjdR?=
 =?utf-8?B?M1VlV1gvTDkzOGdia3ZMY2RjMVBVUEd3Q3E1RENIcDZQZlJlODhNbU5mV0l2?=
 =?utf-8?B?bFR6RzEwSVNob2JnSlBnbHhJd2hpZU44UGtnQ213c3hoMmVPRlVQMXhsb3la?=
 =?utf-8?B?eVJHNGhoRTNudXRQY1ZHUC94TVlSck5TMFpCM2JrZUp2ODQ3RTZ1SjdmMTQr?=
 =?utf-8?B?cFJyNWkrL1V1ZEx3WHh6WWZNRkZtSVBMaXdrMVpqTmZnWjFvblBnc0FqZHFo?=
 =?utf-8?B?ZE83RUpaUG52UldFS050bWlVYit1YXk3OUtrTTVoVmRpS0Uyc1BOaXJHS1Bl?=
 =?utf-8?B?ZHBZZnVsWFZJU1JJWlhTQ1haOGp5U0RiaVkyT3dPN0FPcERjOFJ5RjliU1dF?=
 =?utf-8?B?VzBieEs2RUFIdzRFVkZjZ0tqMmhiUGYwUDB3M29DcGdOMlpwekZDbFh3NlY1?=
 =?utf-8?B?TVYvb3p6ZnRlbldweFdxcWhqWWVGMEdhT09HWXZOcUQzUzQ0Y2thS0RCaDRK?=
 =?utf-8?B?Y2JOamZvaGRua3dZam1na2VCWTVwOUpYVSsrMWQ4Uk9iS0pFS3c3U2FSQklW?=
 =?utf-8?B?dVlvOGNzNjdwaFVrTEg1V0N0c1lSeVNqdFllQmt6NFRmY2lacVNYVW44SjlT?=
 =?utf-8?B?dENMb05xdnZLVFZJNlpDaTd0NEw3d1pPNjkzejBkTnJtdkdqUkdZalBSRXhr?=
 =?utf-8?B?QitDemxjcjlpVW5UaWw4eDNjN1JNTmJCaU9CbE5RSDNab1NzYUxwYmtKOTFJ?=
 =?utf-8?B?anNrNnovUkFKMTJzWmVKMEJLNzh2V3V3dSt6ekQ5a0UySEVGYndBMGx4WnR5?=
 =?utf-8?B?MXhxcEg4K2QrVisyamd3WjZjVDNSWU05T2tiTldUWi9kZkdzNFh5YTB1Y0c5?=
 =?utf-8?B?NXBLdHdKRE42cHh0Z3k0dml6QXFIZkJYMHpvY05LYWpGQXBsSEZLc3JoeUpr?=
 =?utf-8?B?Sy84a1hvQklQTlBtQlczTUFCVWprSk5EODlsdmVJSm9tU09wMWk0YjkxVHN2?=
 =?utf-8?B?Q2w4WHpwYm9oUDBYTGxvbFJ6OVI1OXNtbXBpenNVbkdmRDZBWmtMVmUwTFpx?=
 =?utf-8?B?OXlPRGFYV2crK3V4SGxsN3pYVW1uZnlqLzdaVjFKUS9Dc0lrZFd5ekZkMGtP?=
 =?utf-8?B?SWdmZkJBVExJTDUwSUx3ZC8zZWpFTTNNQUF1NVRMdmlUSldhRVVtd2xnekQ4?=
 =?utf-8?B?b0N0aHdVQWJFclQxT3BEMUFERm1aTXM5Zkt4c1NSUFU2YW1kTFRkZEo0L0pN?=
 =?utf-8?B?Uit6emh6c0tpcHNaNTB1Tjd6N2IvOHFxN3Y4M3MxQUFZK2NpN01PaHkwTXFx?=
 =?utf-8?B?YWwzRVN2VDZvOGNBeHFyK0Y4OVY4d093M1grQVo2Tms5VHhpeENiZnhES0Zh?=
 =?utf-8?Q?ZiXx3qzgY2A=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RDArclZibWNhNVhHVE5RbkQ2c1VnNC9oaEFCZE5wUHlVT2NxNy8wNElZU0RM?=
 =?utf-8?B?Zm5DSEtFbjFjT2VmalJuTFd3dS8yZWlXM25iMkNmZGpaejBvYlRzTmRvZU4r?=
 =?utf-8?B?ZGVhYmd4MzdHZk9laHNiUTZ5a2s3YkRjbEpOclBYWU9yRnZZdGJrUWlBaWlp?=
 =?utf-8?B?YVRLSndqVXFoNkhrYThsb25mVEFOUVFTSzJxT0RaNkZkRktuTElnaTU1VzFC?=
 =?utf-8?B?M1dBenhUa3ArVHFxRDhFd2VydklJUFBzQkJDRmhJMzJTUWRPKzhhY0Y3YWFR?=
 =?utf-8?B?NDBWYzRGQ3lLbXdxeFppb0NwOVJMMk9YVFBCNGl0S09SYTZDQ1M1SldyMVBr?=
 =?utf-8?B?WVdvR0tDUlpoSStsM2RBbjh2RDRjVUliTEk1OTB6MVQvcUdVZlJmY0NMQ1hu?=
 =?utf-8?B?cFJpQk9yOE4vSndDUlErY2NWeXhhNTlHZVQ5Q0VGUnFqcUQwRW0vU3hIUjh2?=
 =?utf-8?B?YVczaGZWT1lkd0JZZXJSUnhWRXNkOHN5aHV1VEdLUytHdFl1UGI2bEl4ck1Q?=
 =?utf-8?B?UFZWRldYRCtwb1lzcEFocmFhajdWekJMYWcxUHY0NTF2QkZSeDRKNkltNXZS?=
 =?utf-8?B?ZHIrbDBXOEZteHhGQkxKRTdWQXFTKzRhR1pZTURPVENmU0I5emFHQ0lIMVlk?=
 =?utf-8?B?ZC9zc1F6aDR1SVpOMCtBeWpOK0xJL3FocVZ4dXdmVEpqYzFqNUdSL3NtZjFN?=
 =?utf-8?B?SGt3WlhKVXZiV3NweDVDV0FLL3UrTi9rV1NHRnFpR24vbmdFSUl6K0JGV2ZO?=
 =?utf-8?B?QXJyRkNFYTJ2cjB5ZTdZRUVMZ1pKdnFMdm1BcWpRYjFsL3l2dWc3Ti9MOWRn?=
 =?utf-8?B?RDg0cVQ3MXVuOWhKNkJDN2NmMXg1bXVmMm91dUtCZytUWFhJOVZ1ZG43WTFQ?=
 =?utf-8?B?ZkQ4VTZTcWY0N3ZIQnMrSWtZQ0FHT3hSWE1ITURUWUdHeENiaCsvQk9CTjF4?=
 =?utf-8?B?eWM4azZyOWhMVzZuL2ZaL1dYU2N5emVRUzZBT1FDOHY3MWcrRXo4UVdrYUxE?=
 =?utf-8?B?L0FZMnZtWEkrbFF2QnNVWXZzOGYyaUI1b0ZmSnBnQ3o1d2Nsa0dnNDRrUnNI?=
 =?utf-8?B?R3JtRkdBbDNmbFN6M2dJcDFBcnc3V3pEZmRiWUs5eUJOTWcxVGtEaWtDakhx?=
 =?utf-8?B?TngvOFdCamo2cjBocHN6M1ZMVG9pOEd2aEMyMldYMVJ2OWpNM3E0aGkvL3JJ?=
 =?utf-8?B?SDBtVVBHK1hYYThmRnNTaXcydXpCTTNhOG5jZURTNnVHQkhXOUowcHZzcHMz?=
 =?utf-8?B?dFVxYzRFUndiV0s2NmhRY21EN0hSM1ZwL1JBQTVHRTVkbzUraG9qaXdJaUtP?=
 =?utf-8?B?SEFneVd3UzRtZUZ6ZDczZ05LSSs3cU5ES1l3V0NGcTU0RkFkQ1pZcGN1QTRL?=
 =?utf-8?B?S2ZZdENSZFNMRE9jY0UyU2RtRndpT1Y3WS9WT1Z0Wlc2Vk1HL0UvQWN3bFlW?=
 =?utf-8?B?TytaczJYdmZHRzFQdHRPNERndm5jZm5ESiszcUVsNXpjUXJyY2R3c01keVFH?=
 =?utf-8?B?dDNORXJ3Z2JvSHdteHBJYlZzbjBsUi9qaUd1c2RtQ1FBbENZMEd1ZDBsRjls?=
 =?utf-8?B?a2RFMGxTSkkxMmJlU1FkRERFYzQxYVc0dXpWbENpc284aGVyVnc1MklHdUVX?=
 =?utf-8?B?N2hQbjc3blNsNHlDMkJEMkJMWFVFUXlSanZ2Q2t1bjVLbkphREJDTXRVeTV1?=
 =?utf-8?B?UkppVTR6N21WTnk3RkVIWjRjK0prVURONWY3S2dXc3Q1dG1mRDFseEptQVhR?=
 =?utf-8?B?UWI3bldiTUJ6RXFYVnBvc3REU2JKYzdiVjVrU3hBdjB6NVBoNy9sU2pHRndp?=
 =?utf-8?B?Y21SUWtMR0poM1YrNC9RdGJiVHA5d1Q0cyszT2RkQ29SWDJNbXBBMlFVaWoz?=
 =?utf-8?B?UG5xMVFTMDB5OXI3alYySFpMbDZ0R3l5Tm5KbTRmY0l5ajhPVDd6Z3RzdHFk?=
 =?utf-8?B?czE4SEZwREFWbEprMzhwd2NPTEVSUC9jVWN3K0J4WmN5Zm5JOXVhcUZ3VllT?=
 =?utf-8?B?SWVpb1lqKzZTOFd1MGFET3FqUkNlVXIvelhrTi9OV0x5d3djS0p4NVFvL1hR?=
 =?utf-8?B?dU5CUGZ3dEF5d1ZPM0YvZ1NheE9ZdWc5ZHgveUVqczd2Y2g3UzVMY1NWU3hy?=
 =?utf-8?Q?zE9RkZhkgeFNkKSVaHZJWsodX?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: df7aeec8-15cd-42d3-25ee-08ddd5c2a706
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Aug 2025 14:56:56.1915 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TchhxwbxVtlIGpGHvt3gHhp38ZnJw+qJ1bohJyfrUggNc3Ds18//cam7nib2dLGv
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB7700
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



On 07.08.25 16:00, David Francis wrote:
> Add new GEM_OP_IOCTL option GET_MAPPING_INFO, which
> returns a list of mappings associated with a given bo, along with
> their positions and offsets.
> 
> Signed-off-by: David Francis <David.Francis@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c | 97 +++++++++++++++++++++++++
>  drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h  |  5 ++
>  include/uapi/drm/amdgpu_drm.h           | 18 +++++
>  3 files changed, 120 insertions(+)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
> index ec80b751e697..8bdb346f1761 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
> @@ -956,6 +956,100 @@ int amdgpu_gem_va_ioctl(struct drm_device *dev, void *data,
>  	return r;
>  }
>  
> +/**
> + * amdgpu_criu_mapping_info_ioctl - get information about a buffer's mappings

The function name was updated.

> + *
> + * @gobj: gem object
> + * @args: gem_op arguments
> + * @fpriv: drm file pointer
> + *
> + * num_entries is set as an input to the size of the user-allocated array of
> + * drm_amdgpu_gem_vm_bucket stored at args->value.
> + * num_entries is sent back as output as the number of mappings the bo has.
> + * If that number is larger than the size of the array, the ioctl must
> + * be retried.
> + *
> + * Returns:
> + * 0 for success, -errno for errors.
> + */
> +static int amdgpu_gem_list_mappings(struct drm_gem_object *gobj, struct amdgpu_fpriv *fpriv,
> +					  struct drm_amdgpu_gem_op *args)
> +{
> +	struct amdgpu_vm *avm = &fpriv->vm;
> +	struct amdgpu_bo *bo = gem_to_amdgpu_bo(gobj);
> +	struct amdgpu_bo_va *bo_va = amdgpu_vm_bo_find(avm, bo);
> +	struct drm_amdgpu_gem_vm_bucket *vm_buckets;
> +	struct amdgpu_bo_va_mapping *mapping;
> +	struct drm_exec exec;
> +	int num_mappings = 0;
> +	int ret;
> +
> +	vm_buckets = kvcalloc(args->num_entries, sizeof(*vm_buckets), GFP_KERNEL);
> +	if (!vm_buckets) {
> +		ret = -ENOMEM;
> +		goto free_vms;
> +	}
> +
> +	drm_exec_init(&exec, DRM_EXEC_INTERRUPTIBLE_WAIT |
> +			  DRM_EXEC_IGNORE_DUPLICATES, 0);
> +	drm_exec_until_all_locked(&exec) {
> +		if (gobj) {
> +			ret = drm_exec_lock_obj(&exec, gobj);
> +			drm_exec_retry_on_contention(&exec);
> +			if (ret)
> +				goto unlock_exec;
> +		}
> +
> +		ret = amdgpu_vm_lock_pd(&fpriv->vm, &exec, 2);
> +		drm_exec_retry_on_contention(&exec);
> +		if (ret)
> +			goto unlock_exec;
> +	}
> +
> +	amdgpu_vm_bo_va_for_each_valid_mapping(bo_va, mapping) {
> +		if (num_mappings < args->num_entries) {
> +			vm_buckets[num_mappings].start = mapping->start;
> +			vm_buckets[num_mappings].last = mapping->last;
> +			vm_buckets[num_mappings].offset = mapping->offset;
> +			vm_buckets[num_mappings].flags = mapping->flags;
> +		}
> +		num_mappings += 1;
> +	}
> +
> +	amdgpu_vm_bo_va_for_each_invalid_mapping(bo_va, mapping) {
> +		if (num_mappings < args->num_entries) {
> +			vm_buckets[num_mappings].start = mapping->start;
> +			vm_buckets[num_mappings].last = mapping->last;
> +			vm_buckets[num_mappings].offset = mapping->offset;
> +			vm_buckets[num_mappings].flags = mapping->flags;
> +		}
> +		num_mappings += 1;
> +	}
> +
> +	drm_exec_fini(&exec);
> +
> +	if (num_mappings > 0) {
> +		if (num_mappings <= args->num_entries) {

That can be combined to just one if.

Apart from that looks good to me,
Christian.

> +			ret = copy_to_user((void __user *)args->value, vm_buckets, num_mappings * sizeof(*vm_buckets));
> +			if (ret) {
> +				pr_debug("Failed to copy BO information to user\n");
> +				ret = -EFAULT;
> +			}
> +		}
> +	}
> +	args->num_entries = num_mappings;
> +
> +	kvfree(vm_buckets);
> +
> +	return ret;
> +unlock_exec:
> +	drm_exec_fini(&exec);
> +free_vms:
> +	kvfree(vm_buckets);
> +
> +	return ret;
> +}
> +
>  int amdgpu_gem_op_ioctl(struct drm_device *dev, void *data,
>  			struct drm_file *filp)
>  {
> @@ -1022,6 +1116,9 @@ int amdgpu_gem_op_ioctl(struct drm_device *dev, void *data,
>  
>  		amdgpu_bo_unreserve(robj);
>  		break;
> +	case AMDGPU_GEM_OP_GET_MAPPING_INFO:
> +		r = amdgpu_gem_list_mappings(gobj, filp->driver_priv, args);
> +		break;
>  	default:
>  		amdgpu_bo_unreserve(robj);
>  		r = -EINVAL;
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
> index f9549f6b3d1f..5a63ae490b0e 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
> @@ -668,4 +668,9 @@ void amdgpu_vm_tlb_fence_create(struct amdgpu_device *adev,
>  				 struct amdgpu_vm *vm,
>  				 struct dma_fence **fence);
>  
> +#define amdgpu_vm_bo_va_for_each_valid_mapping(bo_va, mapping) \
> +		list_for_each_entry(mapping, &bo_va->valids, list)
> +#define amdgpu_vm_bo_va_for_each_invalid_mapping(bo_va, mapping) \
> +		list_for_each_entry(mapping, &bo_va->invalids, list)
> +
>  #endif
> diff --git a/include/uapi/drm/amdgpu_drm.h b/include/uapi/drm/amdgpu_drm.h
> index 1b3d2ba2f556..079e780dc20d 100644
> --- a/include/uapi/drm/amdgpu_drm.h
> +++ b/include/uapi/drm/amdgpu_drm.h
> @@ -802,6 +802,21 @@ union drm_amdgpu_wait_fences {
>  
>  #define AMDGPU_GEM_OP_GET_GEM_CREATE_INFO	0
>  #define AMDGPU_GEM_OP_SET_PLACEMENT		1
> +#define AMDGPU_GEM_OP_GET_MAPPING_INFO		2
> +
> +struct drm_amdgpu_gem_vm_bucket {
> +	/* Start of mapping (in number of pages) */
> +	__u64 start;
> +
> +	/* End of mapping (in number of pages) */
> +	__u64 last;
> +
> +	/* Mapping offset */
> +	__u64 offset;
> +
> +	/* flags needed to recreate mapping */
> +	__u64 flags;
> +};
>  
>  /* Sets or returns a value associated with a buffer. */
>  struct drm_amdgpu_gem_op {
> @@ -811,6 +826,9 @@ struct drm_amdgpu_gem_op {
>  	__u32	op;
>  	/** Input or return value */
>  	__u64	value;
> +	/** For MAPPING_INFO op: number of mappings (in/out) */
> +	__u32	num_entries;
> +	__u32	padding;
>  };
>  
>  #define AMDGPU_GEM_BO_INFO_FLAG_IS_IMPORT	(1 << 0)

