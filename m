Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 51C9AC07E8E
	for <amd-gfx@archiver.kernel.org>; Wed, 24 Apr 2024 08:32:12 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DBE79113901;
	Wed, 24 Apr 2024 08:32:11 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="0gD6A7UN";
	dkim-atps=neutral
Received: from NAM04-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam04on2051.outbound.protection.outlook.com [40.107.100.51])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C875E113901
 for <amd-gfx@lists.freedesktop.org>; Wed, 24 Apr 2024 08:32:10 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HqpPxnaHStToYsJd9uzgFaQzxlxHOElAEdI5FlA+NN0BH6xmkVf9yNuVnz3GFvH83Tw0XRbXAL35y6WhZSsQREuhRb6iasUl1GwDaxmx+u1/vaqs2cbBJoc2NsqFCb6T1y5QWPmK/iCZPaV8uE1caqs0GUdrw2xGpOLwILUgX4vL/vtaaftHFpgDrIZXhaGeZapXhrLwt27VDn0I7xTr196quFnOgkH47dceCvRz3KnLMu5sHvBvOduCny9nhDT5i3eVsKt/C3F/WthXBH/HPHGNFZOV1YzGBS0P+yvbFQ4zbL8saLsl6v5q0IEeJJIb4mTNR1olkVVtU1p7XE5xiw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kHhNR6RSCJbO8bnRrzc34bqlK7vGaK0cu/SF6Y0wyX8=;
 b=T6XMWjjFku8+5xguB1G/2TiZvmET9W3L3siAPTyrb25hBm86j7FbNyVI1CfhvarYGrbbWk/K5ErwmFcfOj8ik0Wsw0VwCUqUCc3X1Q2rzTUUPhWFyT7X3UCGKXG7U+Q/phRCnSq/gwbBVYp/CH9NGDJ2RQr4LfXZ07LSmR8Q9BlYXnJxkYP+mqhoww/KD+J+SPaNR7IKyhLrZaG+qtlgVY/0ucTqrVcuGK2oPxv9z0dVMGsxf+O6dVyXYEJ9epsHbW56HlNgZcanM2ZLLJks8l8+E6tORyA2yJ3OWFI/ZRT/3b1RaV99ZoQ/YmVEiDhyku5CDnycw6MQa6WpKDB/ig==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kHhNR6RSCJbO8bnRrzc34bqlK7vGaK0cu/SF6Y0wyX8=;
 b=0gD6A7UNKyvcTfCLV2+Yc518ZmumBRnYEZ2CiSRR6fdNH8AR/rMcvMOjABv6Db8wQw+bflPYbIvGFeF0WVGGCsCArHqr0NFfauJjayvflrjXzQTbPxnH0YiKUQVU3kGUkl1Sfm46AZvHllACLo2J0DEgcaK1/1ADbNe3P/2UKeg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by MN2PR12MB4078.namprd12.prod.outlook.com (2603:10b6:208:1de::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.22; Wed, 24 Apr
 2024 08:32:06 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::f2b6:1034:76e8:f15a]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::f2b6:1034:76e8:f15a%6]) with mapi id 15.20.7519.021; Wed, 24 Apr 2024
 08:32:06 +0000
Message-ID: <ec22be89-32f1-45b4-89d7-7aeaa81558c5@amd.com>
Date: Wed, 24 Apr 2024 10:32:01 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] drm/amdgpu: Modify the contiguous flags behaviour
To: Arunpravin Paneer Selvam <Arunpravin.PaneerSelvam@amd.com>,
 amd-gfx@lists.freedesktop.org
Cc: alexander.deucher@amd.com, felix.kuehling@amd.com, philip.yang@amd.com
References: <20240424071337.3206-1-Arunpravin.PaneerSelvam@amd.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20240424071337.3206-1-Arunpravin.PaneerSelvam@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR4P281CA0340.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:ea::19) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|MN2PR12MB4078:EE_
X-MS-Office365-Filtering-Correlation-Id: c280943e-2740-4c73-379d-08dc64390654
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|366007|376005|1800799015;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?cG5MVlovZHdrWVJwb2toN1NSbW1OOVUvUFJQVHdFZ1dmL3pZT1pUd2xCOTBG?=
 =?utf-8?B?U2luM3Z6SFVTdzd0YlN3ZGVYQkIxQkR1c0Z6SWd3anFoNDNOckZnYnV6aEJK?=
 =?utf-8?B?U3FROWx2U3RURGZOZEEzaGQraHBsdDkzTDhPZXoyK3JMeCs4YjhWcUZOclB6?=
 =?utf-8?B?RGJSMjQwMzY4NEJHb1ZPV3U4a2lLRVBXWkxTVTU0ckZUM1F6SWlRY1pBT1NH?=
 =?utf-8?B?VlVEUkdXSDA1VnUxUTZvcW5aTVh3NGF0Szh2alVaT3ZWenpBQStTd2dacDhH?=
 =?utf-8?B?Q0FSNENwSWhDMks0R0FJcFR0WEpkV0JLWjRKcDQ4aUhHeEJqRkJINmRobExn?=
 =?utf-8?B?Y0NNbkRadTRvaDk3NmkrajNYZ0FubDlNZE1ibXJDYUNQaWNacDlxMmMzUDRt?=
 =?utf-8?B?N2JqbEhhT3VPdHVBamUzU01NN21HUlZyWVQ0R0l2d0ZwNE1uNndPREdFZmtL?=
 =?utf-8?B?c1BhdVhVZG13NDNScFVSZElXVVV0K2NhZ1QrdGdzY0hBaXo2NDg3Q3NNbmc2?=
 =?utf-8?B?TytodDlTU1VXeHdwUHc0R09zOHNtaFdpMGtsZHltVUUybU9pUm9YWUZ6cVEz?=
 =?utf-8?B?QTRMSlM0Tm5jaUZudHBmWlZHcEVueExPZURIMGFpL1Z6L1BlL3Z3SEpwZnlX?=
 =?utf-8?B?ZzhENTBycVBoUkppQU1qak1qVEY0cEFiRUZvWkd3YlVxb1BoSnBzY2RTZ2JG?=
 =?utf-8?B?R1BGSzVzR3gwZE1tV3ozSXRJdE9xSDYrbW5hNVliZ2o4YzlTRFNiQUNUTzkx?=
 =?utf-8?B?RUhFWUROMThPbmFDTlNDSDYyOERKaXlVZkdYeHpkRlNoU0FVSmx0V0c0SEtM?=
 =?utf-8?B?MmxRMTBqTXZTbldlekoweVRoVTZuTDEyRGpFR1hZODBZMnl2NTV0WUx5RkVs?=
 =?utf-8?B?K1VLREpCWUN6OVU1QmNKVVJlT3hUTHNrQmJ4QnBFVTg5YWhHdWxUVVlZblRO?=
 =?utf-8?B?UGRtY2h2eHpmWnR1bm1YbzhMTTdIbE0xenNYUjJlRm9aQkpwbFBZb0l6d0Fr?=
 =?utf-8?B?S05kcWVlVmNGUDErZDlBZ2pZYXNlWHBENDBvVldONmtvVVNVU0FScnNna1RS?=
 =?utf-8?B?YmpUMkVqcGRQdlBtQndYZkh0QmMwQ2R0WVE5RStPRlRWSlIxT1Y2ZFM3WHk2?=
 =?utf-8?B?eCtYNFUwYW4xMldka2FtVE1VdlVIOWM0YTJ1cEFZREhxU3pKYkJJZXRtRGNI?=
 =?utf-8?B?cjBLY2JiZW1TcW51RG1GWm1FMkJ0ai92Zjd2Z0dOdllVdjJNcFZvNGtOS250?=
 =?utf-8?B?bDN3NkF6OENqVkpmb3JFbnB1RkJPMnBDdXV4bTZSWlAvZmpiRjlUUk9pT3Jh?=
 =?utf-8?B?ekpqVmFjaEJyQjZwVHZuMis4QXJQN3NBcXJDY1FrdmZWM1U4amtkVU93OGNu?=
 =?utf-8?B?eFJ5ZkVWTXBCWVV6dW1IOC91ZVY4dXFhM2N5VVhNVWp5R1hCdmlRSlBKc3NH?=
 =?utf-8?B?Y2xNWWN2YzBhbkFiMlN1d05UeU1NTDA4OUFjaGFmNFArTGc1b1pMMzJ3NjNh?=
 =?utf-8?B?VHJrTWFkenh2YjVTdVFaTWpYNlZKYVkwYURtNy96clYxckFFKzNua2tPWUY3?=
 =?utf-8?B?dG5MWVZoRHZOZWVKRW1NL2QvMkE2NDI0OHFSWFRlR1FQRVhqdkI5ZWlNWkRw?=
 =?utf-8?B?OU13YmVRWGdkenAwVFNSS1lyWURYL1d5UlhwQnE4cE8zRFU4OW5LVFNSZTRE?=
 =?utf-8?B?dXVrZ0Mvd3F0SkdFQmY1ZjlVbmJuWXAyOVo1QXhmYnJ2UWhTbjBuRVVnPT0=?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(366007)(376005)(1800799015); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VmNVeFQ3M2djNWtjZDhUUXZOQ1Z6NGZWSVhHbC81MWpHNGM0SGRVT1U3T2ZM?=
 =?utf-8?B?ZnUyRExTc0NKcHhMbmlaN1JsRVB2Uk1Ya3R2SHJzQzVyTVZWZlloQk9Fc0c5?=
 =?utf-8?B?emF2R216MHZiNEY3SGZianJoa2dPUE5Kd2VKYTRuVWpkcGYyWWRzSk5HK2tW?=
 =?utf-8?B?dWZnSVc1ajNNdm1wK2NuYVNua3BvdFZsMi9QazUxVjkrdEpTVDIwM0VlRmRW?=
 =?utf-8?B?MHE4VDhYTkNwSXpzNTNSVVJNSVl3bG43c2kzUDFqTWVxZTl5RkZaa1Z4aUlJ?=
 =?utf-8?B?QkxqRnhFVGIwdnI5UnhsVHF1YlFMckVXMWszVnZoem9EWGJka3lMTDQwVmJm?=
 =?utf-8?B?ZXFqTllWcEFHSk1HZ2RqK0lkbC9vVWYzSzVMeWxyN1ZrN2JaUXl2ZDR3YjBz?=
 =?utf-8?B?N2VtaXgxZktuVVh2U1FQaUI0VTd3bmpTR3c2bXlRZ3hCUUxzaHFhcFZlTUhE?=
 =?utf-8?B?UGRuT2lIdmNYU2YrMG93bnRPZ3BqY2dZbVlGOEhhZmJFZXBEK1N3NVI3WEZw?=
 =?utf-8?B?ZWN1Zi9ROHB3Nk5vT3pSSUlucTYvM09IaWtsTmNDTTU4SXpNMmpRR2R0cUNW?=
 =?utf-8?B?b0xQV3RKUlpGbHRXaTBKZUpnWmJJSXJ4eldobUVycjZXbktTVk5qUnZWYzVB?=
 =?utf-8?B?b3RQdmptVU5WNFlzc0lxaVBhemFRWmpMTHMvMVFTRW9ZM0VPUDhmRGhGdDZz?=
 =?utf-8?B?MDVIS0xCQnQ4N2ptbHRndy92L0FrRnk3WFNCNjdPZlB4SUkyZFRCaGxNUzFU?=
 =?utf-8?B?UUIybTBhZE4vclF4dS9xT1M3Wk1JL3ZIbFRLampXR1FrVkVnTGNCZUdxeERO?=
 =?utf-8?B?bVdNejgyZFFudkhvQ09LVStUTXNTWnp5OHo1NjBCMGZoc04vYmRROHp1MGtC?=
 =?utf-8?B?YkJZYWYxOHdJSUxDb013REJiNllhYVFQVTJITjNkSkw0WnVKTmF0R2hiOFd2?=
 =?utf-8?B?MDQ1clJmMUd2ZXg4VlNFZU9xZ2Nsc1JqNzFVZXlSTHlqNTY5dXA4MDZuSGl5?=
 =?utf-8?B?M1FWZXdOZmpnYWhHdExhZThGS1hKazRwN1FnQzlMandQOERxaTEyY1o2c2lr?=
 =?utf-8?B?bHJQZm5mb0YwcFIzbTgvdDEvVTRFTFRzTWpqTHVMZGMvQTZvUTVmQXp2Sk1V?=
 =?utf-8?B?bDB6WXErb0NDSCtaMkVEVk91a2wwOXV1Ynd0R1JoSEt4dkJBZEZ0aFZWckNE?=
 =?utf-8?B?VXFrR2JSTnltQmZXK21uZHpSOEU2azlheEZCcTNkWlhjSDVNWjJuN0xwRUtV?=
 =?utf-8?B?VVFiL3R6N3NlUERoMm93UW90Y0phaWtRQ2NGSktwQnNiaTZuUlU1M2lOL1VX?=
 =?utf-8?B?cFhCaVY4cUVvNHhCbUtxZkpKd0pTNnc4cm9GZ2pPOGNXT1FQYlQ5MmdnUkZY?=
 =?utf-8?B?LzBxTEFERmtONHRoblRmTHBkSzViWEdhZHcvb0tuWlltVk80TmhUQURtRXdO?=
 =?utf-8?B?YWN2ZCtwSHY0UktpeVNQVnNPeU1ObnhCZHZPOVd3N0VtU1ozdFV6NjdtbHVO?=
 =?utf-8?B?MFQ2QWlTUUNJOG0yN2E3QXprSkdVSFBRWkUyQ2VxMVdIRnB1VkdWaW5sbElB?=
 =?utf-8?B?QzlYd3dDbjBUYXlsaFdmc0xXYW14Y2hKdE1ORWJ4aTBSbEwrLzkyVmFZT2pP?=
 =?utf-8?B?ajJhakJ0eFZ4S1M2L0YzcXI1WG8xWDZzMzIwMTBuRnhyZVJuOVVhd2Z1YWta?=
 =?utf-8?B?cnhaRWcwUjFoeEZKZExuM3JGaHNWdEE4Y0dBMm9xV25pMjd4c3c1Q01TeENh?=
 =?utf-8?B?TE93N1d0UXhmNStOcFp6Y2d2ejdvbnM3cjNTcXVFUGg3TFRidVJFZlVDa28z?=
 =?utf-8?B?dUd0MStuVkZWaTdxZ1o4Zlk4Mk9DaTdDSFltQzdDbk5rSjgzMTBHU1lLOE94?=
 =?utf-8?B?N3B4MjRRTERjbk5xaGZzQ3FIMkpnV3BvY0xMYU1QSXM4NEtjaUF3aWRjRWw4?=
 =?utf-8?B?bnNSLzBFNWlPQ2xpOVAxZVF5YUxUZk8rcXVHdHNUNnVpL0Y1WmREYUw4WkFl?=
 =?utf-8?B?VUJkZTBsVDFxZWV6VFUzQXYxN0hyRU1tbStaZSsxencyL0pwUkROTjA4TVFH?=
 =?utf-8?B?WStzdXFvTWdmVWFHMTZwUzZtbTI5aExuRDVxbDlNekZtV28vQ1FQOHlvdDRr?=
 =?utf-8?Q?I1g0Gi84bWTV413glico53ZeC?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c280943e-2740-4c73-379d-08dc64390654
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Apr 2024 08:32:06.3046 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2vYsMRR8zRScaYpjYWv3DFFzP9sqOzz68MzM8CIBVoQcSmO0Sevg3WxWzia84uH1
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4078
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

Am 24.04.24 um 09:13 schrieb Arunpravin Paneer Selvam:
> Now we have two flags for contiguous VRAM buffer allocation.
> If the application request for AMDGPU_GEM_CREATE_VRAM_CONTIGUOUS,
> it would set the ttm place TTM_PL_FLAG_CONTIGUOUS flag in the
> buffer's placement function.
>
> This patch will change the default behaviour of the two flags.
>
> When we set AMDGPU_GEM_CREATE_VRAM_CONTIGUOUS
> - This means contiguous is not mandatory.
> - we will try to allocate the contiguous buffer. Say if the
>    allocation fails, we fallback to allocate the individual pages.
>
> When we setTTM_PL_FLAG_CONTIGUOUS
> - This means contiguous allocation is mandatory.
> - we are setting this in amdgpu_bo_pin_restricted() before bo validation
>    and check this flag in the vram manager file.
> - if this is set, we should allocate the buffer pages contiguously.
>    the allocation fails, we return -ENOSPC.
>
> v2:
>    - keep the mem_flags and bo->flags check as is(Christian)
>    - place the TTM_PL_FLAG_CONTIGUOUS flag setting into the
>      amdgpu_bo_pin_restricted function placement range iteration
>      loop(Christian)
>    - rename find_pages with amdgpu_vram_mgr_calculate_pages_per_block
>      (Christian)
>    - Keep the kernel BO allocation as is(Christain)
>    - If BO pin vram allocation failed, we need to return -ENOSPC as
>      RDMA cannot work with scattered VRAM pages(Philip)
>
> v3(Christian):
>    - keep contiguous flag handling outside of pages_per_block
>      calculation
>    - remove the hacky implementation in contiguous flag error
>      handling code
>
> Signed-off-by: Arunpravin Paneer Selvam <Arunpravin.PaneerSelvam@amd.com>
> Suggested-by: Christian König <christian.koenig@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_object.c   |  8 +-
>   drivers/gpu/drm/amd/amdgpu/amdgpu_vram_mgr.c | 83 ++++++++++++++------
>   2 files changed, 65 insertions(+), 26 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
> index 492aebc44e51..c594d2a5978e 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
> @@ -154,8 +154,10 @@ void amdgpu_bo_placement_from_domain(struct amdgpu_bo *abo, u32 domain)
>   		else
>   			places[c].flags |= TTM_PL_FLAG_TOPDOWN;
>   
> -		if (flags & AMDGPU_GEM_CREATE_VRAM_CONTIGUOUS)
> +		if (abo->tbo.type == ttm_bo_type_kernel &&
> +		    flags & AMDGPU_GEM_CREATE_VRAM_CONTIGUOUS)
>   			places[c].flags |= TTM_PL_FLAG_CONTIGUOUS;
> +
>   		c++;
>   	}
>   
> @@ -965,6 +967,10 @@ int amdgpu_bo_pin_restricted(struct amdgpu_bo *bo, u32 domain,
>   		if (!bo->placements[i].lpfn ||
>   		    (lpfn && lpfn < bo->placements[i].lpfn))
>   			bo->placements[i].lpfn = lpfn;
> +
> +		if (bo->flags & AMDGPU_GEM_CREATE_VRAM_CONTIGUOUS &&
> +		    bo->placements[i].mem_type == TTM_PL_VRAM)
> +			bo->placements[i].flags |= TTM_PL_FLAG_CONTIGUOUS;
>   	}
>   
>   	r = ttm_bo_validate(&bo->tbo, &bo->placement, &ctx);
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vram_mgr.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vram_mgr.c
> index e494f5bf136a..17c5d9ce9927 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vram_mgr.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vram_mgr.c
> @@ -88,6 +88,23 @@ static inline u64 amdgpu_vram_mgr_blocks_size(struct list_head *head)
>   	return size;
>   }
>   
> +static inline void amdgpu_vram_mgr_limit_min_block_size(unsigned long pages_per_block,
> +							u64 size,
> +							u64 *min_block_size,
> +							bool contiguous_enabled)
> +{
> +	if (contiguous_enabled)
> +		return;
> +
> +	/*
> +	 * if size >= 2MiB, limit the min_block_size to 2MiB
> +	 * for better TLB usage.
> +	 */
> +	if ((size >= (u64)pages_per_block << PAGE_SHIFT) &&
> +	    !(size & (((u64)pages_per_block << PAGE_SHIFT) - 1)))
> +		*min_block_size = (u64)pages_per_block << PAGE_SHIFT;
> +}
> +
>   /**
>    * DOC: mem_info_vram_total
>    *
> @@ -452,11 +469,12 @@ static int amdgpu_vram_mgr_new(struct ttm_resource_manager *man,
>   	struct amdgpu_device *adev = to_amdgpu_device(mgr);
>   	struct amdgpu_bo *bo = ttm_to_amdgpu_bo(tbo);
>   	u64 vis_usage = 0, max_bytes, min_block_size;
> +	struct amdgpu_bo *bo = ttm_to_amdgpu_bo(tbo);
>   	struct amdgpu_vram_mgr_resource *vres;
>   	u64 size, remaining_size, lpfn, fpfn;
>   	struct drm_buddy *mm = &mgr->mm;
> -	struct drm_buddy_block *block;
>   	unsigned long pages_per_block;
> +	struct drm_buddy_block *block;
>   	int r;
>   
>   	lpfn = (u64)place->lpfn << PAGE_SHIFT;
> @@ -469,18 +487,14 @@ static int amdgpu_vram_mgr_new(struct ttm_resource_manager *man,
>   	if (tbo->type != ttm_bo_type_kernel)
>   		max_bytes -= AMDGPU_VM_RESERVED_VRAM;
>   
> -	if (place->flags & TTM_PL_FLAG_CONTIGUOUS) {
> -		pages_per_block = ~0ul;
> -	} else {
> -#ifdef CONFIG_TRANSPARENT_HUGEPAGE
> +	if (IS_ENABLED(CONFIG_TRANSPARENT_HUGEPAGE))
>   		pages_per_block = HPAGE_PMD_NR;

That won't work like this.

HPAGE_PMD_NR is only guaranteed to be defined when 
CONFIG_TRANSPARENT_HUGEPAGE is enabled.

So you will run into some compile errors on platforms where that isn't 
available.

> -#else
> -		/* default to 2MB */
> +	else
> +		/* default to 2MiB */
>   		pages_per_block = 2UL << (20UL - PAGE_SHIFT);
> -#endif
> -		pages_per_block = max_t(uint32_t, pages_per_block,
> -					tbo->page_alignment);
> -	}
> +
> +	pages_per_block = max_t(uint32_t, pages_per_block,
> +				tbo->page_alignment);
>   
>   	vres = kzalloc(sizeof(*vres), GFP_KERNEL);
>   	if (!vres)
> @@ -499,7 +513,7 @@ static int amdgpu_vram_mgr_new(struct ttm_resource_manager *man,
>   	if (place->flags & TTM_PL_FLAG_TOPDOWN)
>   		vres->flags |= DRM_BUDDY_TOPDOWN_ALLOCATION;
>   
> -	if (place->flags & TTM_PL_FLAG_CONTIGUOUS)
> +	if (bo->flags & AMDGPU_GEM_CREATE_VRAM_CONTIGUOUS)
>   		vres->flags |= DRM_BUDDY_CONTIGUOUS_ALLOCATION;
>   
>   	if (bo->flags & AMDGPU_GEM_CREATE_VRAM_CLEARED)
> @@ -509,23 +523,23 @@ static int amdgpu_vram_mgr_new(struct ttm_resource_manager *man,
>   		/* Allocate blocks in desired range */
>   		vres->flags |= DRM_BUDDY_RANGE_ALLOCATION;
>   
> +	if (tbo->page_alignment)
> +		min_block_size = (u64)tbo->page_alignment << PAGE_SHIFT;
> +	else
> +		min_block_size = mgr->default_page_size;
> +
>   	remaining_size = (u64)vres->base.size;
>   
>   	mutex_lock(&mgr->lock);
>   	while (remaining_size) {
> -		if (tbo->page_alignment)
> -			min_block_size = (u64)tbo->page_alignment << PAGE_SHIFT;
> -		else
> -			min_block_size = mgr->default_page_size;
> -
> -		BUG_ON(min_block_size < mm->chunk_size);
> -
>   		/* Limit maximum size to 2GiB due to SG table limitations */
>   		size = min(remaining_size, 2ULL << 30);
> -
> -		if ((size >= (u64)pages_per_block << PAGE_SHIFT) &&
> -				!(size & (((u64)pages_per_block << PAGE_SHIFT) - 1)))
> -			min_block_size = (u64)pages_per_block << PAGE_SHIFT;
> +		amdgpu_vram_mgr_limit_min_block_size(pages_per_block,
> +						     size,
> +						     &min_block_size,
> +						     bo->flags &
> +						     AMDGPU_GEM_CREATE_VRAM_CONTIGUOUS);
> +		BUG_ON(min_block_size < mm->chunk_size);
>   
>   		r = drm_buddy_alloc_blocks(mm, fpfn,
>   					   lpfn,
> @@ -533,8 +547,27 @@ static int amdgpu_vram_mgr_new(struct ttm_resource_manager *man,
>   					   min_block_size,
>   					   &vres->blocks,
>   					   vres->flags);
> -		if (unlikely(r))
> -			goto error_free_blocks;
> +		if (unlikely(r)) {
> +			if (bo->flags & AMDGPU_GEM_CREATE_VRAM_CONTIGUOUS &&
> +			    !(place->flags & TTM_PL_FLAG_CONTIGUOUS)) {

Better check for the variable you modify, in this case min_block_size 
and then restart the loop.

And check for the explicit return value.

In other words something like this

if (unlikely(r == -ENOSPC) && min_block_size >= ... &&
     !(place->flags & TTM_PL_FLAG_CONTIGUOUS))
         min_block_size = ...;
         continue;
}
if (unlikely(r))
     goto error_free_blocks;

Regards,
Christian.

> +				/* Fallback to non-contiguous allocation */
> +				amdgpu_vram_mgr_limit_min_block_size(pages_per_block,
> +								     size,
> +								     &min_block_size,
> +								     !(bo->flags &
> +								     AMDGPU_GEM_CREATE_VRAM_CONTIGUOUS));
> +				r = drm_buddy_alloc_blocks(mm, fpfn,
> +							   lpfn,
> +							   size,
> +							   min_block_size,
> +							   &vres->blocks,
> +							   vres->flags);
> +				if (unlikely(r))
> +					goto error_free_blocks;
> +			} else {
> +				goto error_free_blocks;
> +			}
> +		}
>   
>   		if (size > remaining_size)
>   			remaining_size = 0;

