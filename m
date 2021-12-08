Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2274EC433EF
	for <amd-gfx@archiver.kernel.org>; Wed,  8 Dec 2021 15:13:54 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 95EFC737BD;
	Wed,  8 Dec 2021 15:13:53 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2051.outbound.protection.outlook.com [40.107.244.51])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4D019737BD
 for <amd-gfx@lists.freedesktop.org>; Wed,  8 Dec 2021 15:13:52 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QK8fWC4ASxexlHWsjY2Vf9i2QDhIf6nd7N1abbDDvB8KuCbeM7wni8oVF8lBxE+Q+bK4U/CDFUozeABm2NxsN3EFRoLhwCaRTKChevKOqoqrnu1Sw94+vAh8a4u4e/fNRPdn8XLJr1357/zg9YzqhyrLRb2JUISzox5YdSLle6M3AIdZLfKSaF4yRqRhJNdAAaZdAnMZHj1pXJTH5XROij2pgCRk5478Bw7G84T4QtUY/NTmjAVN6QKvaPBP9b1K34rs/cjeI7qLp0b4PDMYf9I+3uhTdYaHOCIRO3x+45tnjqpFMelO3ex1cDja3wBjA5nWW9/5UstfXVAaKRHMiw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4jqgFK3l9q3A9yIkFjOozgrb0iZG3jq+8cYpThFxPXo=;
 b=OZmEVVSxYFpis5cno/iAqTU54ggVSSeDi5BErhh/nNoPvwP4GGTuI3Yjcw01r1GaWpUA5a9waKGeWEbe3eMB3b0opuNk3xj1rfScWBDADXb8jvU1Pz5xy+dscIf7BDpMv4cbnjAW/rPAzxf7P4w2p6qpdvLOJXfZ+S2ccgg33Mg5oiHvBn6mdoSP6yrx3WAGeuaBshYGKftqLiciZc81Gn9N0IPBEU5kI8mwDghRJ1ngdYOujDalRfZMF/oxshJLQDz1eTjekmObExT4bLxgmrWBUo6OmW/ZHCfoBH/ipqakYLdXfEEoT+bqhAPJyWViG+d0n7nbWKy48FOGfHw1GA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4jqgFK3l9q3A9yIkFjOozgrb0iZG3jq+8cYpThFxPXo=;
 b=O50uEcUXSQbBzc6cUDklMusnySvlHeD/qxh0Cdg3FaqGnEoiPa2YTdFKDRX8n+3tRoVeeknr/ukFgbpR9bKSC+eGHKRfjrp6ofXN649sN/l+uxkfMtyIbccz5kOK3sLFJdpk3mxaz15+VX/4LzzRmFuVf2W7rkBxLHFVJLSF73A=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN2PR12MB2896.namprd12.prod.outlook.com (2603:10b6:208:ab::22)
 by MN2PR12MB3261.namprd12.prod.outlook.com (2603:10b6:208:108::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4755.16; Wed, 8 Dec
 2021 15:13:50 +0000
Received: from MN2PR12MB2896.namprd12.prod.outlook.com
 ([fe80::44f7:66fe:4419:d8d3]) by MN2PR12MB2896.namprd12.prod.outlook.com
 ([fe80::44f7:66fe:4419:d8d3%7]) with mapi id 15.20.4778.011; Wed, 8 Dec 2021
 15:13:50 +0000
Subject: Re: [PATCH 00/10] drm/amd: fix various compilation warnings
To: Isabella Basso <isabbasso@riseup.net>, alexander.deucher@amd.com,
 christian.koenig@amd.com, daniel@ffwll.ch, harry.wentland@amd.com,
 Rodrigo.Siqueira@amd.com, Felix.Kuehling@amd.com
References: <20211208012529.372478-1-isabbasso@riseup.net>
From: Rodrigo Siqueira Jordao <rjordrigo@amd.com>
Message-ID: <a67fd89c-6619-19ae-223b-3c027fc0e325@amd.com>
Date: Wed, 8 Dec 2021 10:13:48 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
In-Reply-To: <20211208012529.372478-1-isabbasso@riseup.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BLAPR03CA0005.namprd03.prod.outlook.com
 (2603:10b6:208:32b::10) To MN2PR12MB2896.namprd12.prod.outlook.com
 (2603:10b6:208:ab::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 4f15b917-0216-4012-810a-08d9ba5d56f5
X-MS-TrafficTypeDiagnostic: MN2PR12MB3261:EE_
X-Microsoft-Antispam-PRVS: <MN2PR12MB326129D55635EFA883DEB4F8986F9@MN2PR12MB3261.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: TcbwO7AUOr3tj/XBHfq9YqXTifOwYDqMA83nQcznV1NYeZpIIjvJjaOZPnyUE0/XsCoBFOtpOVKUhks4GuQStRwuVIicV9hmOOoeQGIPCY+sNhVkoJyzT6Q4CDcoVRcQburQiOtvDKPZh0O+yBV0xKjSb6vQI2WMRE25amYN3l08cmAo86YXJd7KFujWZnb7T5hMfRT7TgTKUN9RyCK803C/sAh5HUBDNq9RdOlJQHlbt7xq2EIxwf6XYTZUrjmyAhgO0Ib7JfM9WFm82XPypUAlcEDMWRhumLFdwBkqcd5xR6OMEZXmuNVgNOrw110mq54fLX247OE1TDfdZktDQUhq2mWalZfiYCPstrU3t50cDBtFy0vzx+WINuZ32AWW+lj+9zdntkyTuCebriV4o2O+NXMP1j3uQeaI66Hzd+Kfmi9I/1WHUMi8s6o8Oyr+0xRnb5YqiewIvOIK+ZK2H4XyoD1PtYivcOQBgPrn9pHH+tG8tpWeNtSHTpLFvLW340JrS5Qdi8wdrHwrGEKda6xLIDVQEZEyK1sRTYK3xQkw3ZvafjYAl76VbWldLhpYFe1p50wS0pM7gpQOxOCY7o2oOWb+37LT3pxq7iEoxMgqaLIywNxdYRNWipZAf7gXCbBvuG0Uha25jiUC5wOMoW4Be/jai556Vq+SZNDHVVZ3wUknGSXPHnAqd+V9r1/gZsjlbxf7pQFXzzu+RP8Bl4h+8ksic1rJOfmfWuakdHOSDzYFFK4a585POyWC1I4Mr1WFPT4plWyYwa7hhHslRWv7A3+MtvaNdB97izvgp8160fO7sDHoLiHXDvS2JWYC
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB2896.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(36756003)(31686004)(316002)(2616005)(8676002)(31696002)(2906002)(66476007)(83380400001)(66556008)(8936002)(6512007)(66946007)(38100700002)(4326008)(508600001)(186003)(6506007)(53546011)(6486002)(5660300002)(966005)(6636002)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MEhOTWNoZStlY1pOdlBRRGZPT1JmdmQrbDgxZVlRbXpzYytKUVQ0aitJRVBL?=
 =?utf-8?B?MDFsZmtYUXZXRkpXZnJmYmdDSE01YU5XN1ZGVlJyRmRub3kwcnBudHBLMkFr?=
 =?utf-8?B?cFpyTzIzRUlHaVBjejJYM0h4SUJEb25QRWVzcjcyNi9pWkhqeFlYbi8zM1J0?=
 =?utf-8?B?SkJqV21ndVVsZDY0OGhGWkVkUnpxcnNrQnZaQllJUjJQWEdIeVNLL3h5NytK?=
 =?utf-8?B?TUZjNTVvZWYwSUtJQTBCOHUwNllHRFBEWWlIVEJLdmdRVEJZcVIwaGdJK3Rx?=
 =?utf-8?B?WDc1R2lKWEpWRkF2MUNFMS9oYzA5U1RXRkwvV2JyWlhXanVZV1pEV21WSWZz?=
 =?utf-8?B?ZnIvbUxiMEx5UWNiNkxZVnhBN2dyYklMYXpYNmZSV3Z2TDB5WUo1R3M2aEV1?=
 =?utf-8?B?RW85bVdHdCtOd1M0SUQwOFNxUTJrQzN2TFk4ZVJzOUNxR0ZJUmJZcVNZeGhi?=
 =?utf-8?B?SHZEclVWZFRnK3lCMVhsMERWVTJDVHYva1hvMGRablFFbVFDcnFJSnZKZy9O?=
 =?utf-8?B?Ti9pbGZ1Z3dFZmNvMllva2NBVTJzVjNkbmE0SHM4OVJ6ZVh4Q3J6NlZ5ZmZ3?=
 =?utf-8?B?MGR4Z3JmalkxOGdOdjNxYWFBTGlzdHk2SHF4R05RZ0taRkNQVE93UGpHMnho?=
 =?utf-8?B?L1paajIxdldPczJzUy9WVVUrdkFwUDN4RExkNkVwRVhMQW1lTkc4K2prdXJY?=
 =?utf-8?B?Z3c3UDlDdHVJVU1zRG9MSFRpNjdSQjJPUmVGdEdRSUVRamtMMnBkTnVHSmpO?=
 =?utf-8?B?UWRWZFJ5NmxtV1RjMndlWTVCcU9kemd4czJkelE3cHdqNUllVHR0Q2MvSjZV?=
 =?utf-8?B?bEMrYzUyajg1d3ZSeG9hSFhyVmJOcXE3aHAyckwyMDVGWDgyT3ZUUWVRakdr?=
 =?utf-8?B?bXphZ2xUSjZZdEl5emtnMnYrdDBFejFEYlNuTENNQXMxMnRBOXV6SmhoL0pN?=
 =?utf-8?B?cm1iT3ZUK1VDdEFWcHdtaUg1TERBRitXWWVVb09mb0pGRjA4cXZLYmdxb0FN?=
 =?utf-8?B?T3ZSOGQvSUhNYzJFU1pFVFB6V1ZkUlJiWTZvRDRRQWhpZFpOQjRjZStmVWF4?=
 =?utf-8?B?bEtqUHpOOUt0bGtKcFphV2FDM1ZpcVhScDdxdXdoQVR6MEUrb1RRQmJqbEpR?=
 =?utf-8?B?K05TQjd0OFBlV29GeStNYnlmSjdKR29mY1lwdktoMjRVcm5XUnQwOW8zY0NF?=
 =?utf-8?B?L0lvckRmTGJoUVF1bHUyNmNtSndyQ2pDQVV4YmRtT2ljdEsyQ2syMTRpK2xy?=
 =?utf-8?B?K3B5THk0VENQZi9zTEl2MzhTcW1PaHNBZHEzQkU3UmltTHRmd0Qwcm1kWUpL?=
 =?utf-8?B?VEtxbXZYK1JOZGlmZENrZXJ1bGZVYVV4M1N6akpjWXdUeTN1UTAyU3VMZkYv?=
 =?utf-8?B?YWx2Z3RqVnNJbFhJNzBoN0VoZ1dMNmUvSXlERTRrOXMvanpFNTBFMGtrV1Er?=
 =?utf-8?B?ZmY2eUpUTUliTXlQeXhoLy85V25UMEFEWW9GdHpFZHN6TURUQ3oxVXJGOEsr?=
 =?utf-8?B?cVQwZ0ROOXBIM1pPZm1lcStHbkNDZ3QvdXNtbmtRZm5mTHZaYmFCVC9HalA5?=
 =?utf-8?B?YjJnaVkyVXFWcFpiU2xPQWRXWngwallTZG1PVUUxcEJ1WDFUMklNNW04ZTlu?=
 =?utf-8?B?b3hibkVFYmFQbmhJQThmYzlFRE50TWlXNnlVYkRJTXJ0c3o0YlM1UWtaSUlv?=
 =?utf-8?B?Njc1Y3BZd0Y5NXo5R2E1eFJUTmkvWEU0bVFHbjdXT3QvNVBRRDRpVk5OZWlW?=
 =?utf-8?B?ck44d2owSGljOGMxQ3pKRzM1TFpvd1drbFJBMDhweUthMlhBRW1Peng1Smht?=
 =?utf-8?B?RzBucEluVU9mMmVIVThoYzZ6aXd5VE01elNtaTVsZitoL1d0c25SV2puZSti?=
 =?utf-8?B?MFFhVS9WM1F5UklhbW1qMUNKTFgxRE0xR0liL1lDSVI3NWVFZGx6VGw4bTJD?=
 =?utf-8?B?czJ0eU9KZFFBc3VlZGgyYjJDVnZuWnNqelFqVFNrNWlEQkQ4U05QM0Y1VWtn?=
 =?utf-8?B?clQwK2YxOUN0cXRLTU9WOCtqdStHWmUyYW00Ym82V0huaWpPU1djN3BlZnZO?=
 =?utf-8?B?c2xtUDNxYjl0bWlCbkdKV25kVkFsZUZ5dVJUMzNleUJZUGJTaWNHTHRRYkFh?=
 =?utf-8?B?c0tkWjdlOHZtUll0K3JjaTdydVUvNnJBZzBQSEZtcHJMdVR4N0hhcC84TWVx?=
 =?utf-8?B?bnFhVkFFR3J0QXBaUWFnbmJYSW9kUXZuTW5GUjdUbW9nWlhhUnhSWVB0b3p3?=
 =?utf-8?Q?W4YGWcjE593096L5WypzamCkKoNh6rdy4T0p8sr9yQ=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4f15b917-0216-4012-810a-08d9ba5d56f5
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB2896.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Dec 2021 15:13:50.4619 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CQxvg6jky9ovSLmlMxzHPswZIPXmvvzIFFUYlekguG5FiD0P3Svgxgtez0HFW00NoeZGIPXOa/laDBzu6L+Wsw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3261
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
Cc: ~lkcamp/patches@lists.sr.ht, amd-gfx@lists.freedesktop.org
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Hi Isabella,

Thanks a lot for all of these improvements.

I reviewed all patches related to the display code.

Best Regards
Siqueira

On 2021-12-07 8:25 p.m., Isabella Basso wrote:
> This patchset aims at fixing various compilation warnings in the AMD GPU
> driver. All warnings were generated using gcc and the W=1 flag. I
> decided to deal with them in the same order as the issues were presented
> in the log, with the exception of those that were about the lack of
> protypes, which were gathered by a script [1].
> 
> [1] - https://pad.riseup.net/p/ZMkzoeO89Kt7R_IC4iAo-keep>> 
> Isabella Basso (10):
>    drm/amd: Mark IP_BASE definition as __maybe_unused
>    drm/amd: fix improper docstring syntax
>    drm/amdgpu: add missing function prototype for
>      amdgpu_ras_mca_query_error_status
>    drm/amdgpu: fix function scopes
>    drm/amdkfd: fix function scopes
>    drm/amd/display: fix function scopes
>    drm/amd: append missing includes
>    drm/amdgpu: fix location of prototype for amdgpu_kms_compat_ioctl
>    drm/amdgpu: remove unnecessary variables
>    drm/amdgpu: re-format file header comments
> 
>   drivers/gpu/drm/amd/amdgpu/amdgpu.h           |  2 -
>   .../gpu/drm/amd/amdgpu/amdgpu_atomfirmware.c  |  4 +-
>   .../gpu/drm/amd/amdgpu/amdgpu_atpx_handler.c  |  3 +-
>   drivers/gpu/drm/amd/amdgpu/amdgpu_device.c    |  4 +-
>   drivers/gpu/drm/amd/amdgpu/amdgpu_drv.h       |  3 +
>   drivers/gpu/drm/amd/amdgpu/amdgpu_ioc32.c     | 16 +++---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_irq.c       |  2 +-
>   drivers/gpu/drm/amd/amdgpu/amdgpu_pll.c       |  2 +
>   .../gpu/drm/amd/amdgpu/amdgpu_preempt_mgr.c   |  4 +-
>   drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c       |  6 +-
>   drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h       |  4 ++
>   drivers/gpu/drm/amd/amdgpu/amdgpu_vce.c       |  1 -
>   drivers/gpu/drm/amd/amdgpu/amdgpu_vkms.c      |  4 +-
>   drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c        |  2 -
>   drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c        |  2 -
>   drivers/gpu/drm/amd/amdkfd/kfd_migrate.c      |  4 +-
>   .../drm/amd/amdkfd/kfd_packet_manager_vi.c    |  4 +-
>   drivers/gpu/drm/amd/amdkfd/kfd_process.c      |  5 +-
>   drivers/gpu/drm/amd/amdkfd/kfd_svm.c          | 10 +++-
>   .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 19 +++++--
>   .../amd/display/amdgpu_dm/amdgpu_dm_color.c   |  4 ++
>   .../gpu/drm/amd/display/dc/calcs/dcn_calcs.c  |  4 +-
>   .../display/dc/clk_mgr/dcn10/rv1_clk_mgr.c    |  2 +-
>   .../dc/clk_mgr/dcn10/rv1_clk_mgr_vbios_smu.c  |  2 +
>   .../display/dc/clk_mgr/dcn20/dcn20_clk_mgr.c  |  2 +-
>   .../dc/clk_mgr/dcn201/dcn201_clk_mgr.c        |  9 +--
>   .../amd/display/dc/clk_mgr/dcn21/rn_clk_mgr.c | 14 ++---
>   .../dc/clk_mgr/dcn21/rn_clk_mgr_vbios_smu.c   |  6 +-
>   .../display/dc/clk_mgr/dcn301/dcn301_smu.c    |  6 +-
>   .../display/dc/clk_mgr/dcn301/vg_clk_mgr.c    | 10 ++--
>   .../display/dc/clk_mgr/dcn31/dcn31_clk_mgr.c  |  9 +--
>   .../amd/display/dc/clk_mgr/dcn31/dcn31_smu.c  |  6 +-
>   drivers/gpu/drm/amd/display/dc/core/dc_link.c |  3 +-
>   .../display/dc/dce110/dce110_hw_sequencer.c   |  2 +
>   .../gpu/drm/amd/display/dc/dcn10/dcn10_dpp.c  |  2 +-
>   .../drm/amd/display/dc/dcn10/dcn10_dpp_dscl.c |  5 +-
>   .../amd/display/dc/dcn10/dcn10_hw_sequencer.c | 16 +++---
>   .../gpu/drm/amd/display/dc/dcn10/dcn10_opp.c  |  5 +-
>   .../gpu/drm/amd/display/dc/dcn10/dcn10_optc.c |  8 +--
>   .../drm/amd/display/dc/dcn10/dcn10_resource.c | 21 ++++---
>   .../gpu/drm/amd/display/dc/dcn20/dcn20_dpp.c  |  5 +-
>   .../drm/amd/display/dc/dcn20/dcn20_dwb_scl.c  |  4 +-
>   .../gpu/drm/amd/display/dc/dcn20/dcn20_hubp.c |  7 +--
>   .../drm/amd/display/dc/dcn20/dcn20_hwseq.c    |  6 +-
>   .../gpu/drm/amd/display/dc/dcn20/dcn20_init.c |  2 +
>   .../gpu/drm/amd/display/dc/dcn20/dcn20_mpc.c  |  8 +--
>   .../gpu/drm/amd/display/dc/dcn20/dcn20_optc.c | 21 ++++---
>   .../drm/amd/display/dc/dcn201/dcn201_dccg.c   |  3 +-
>   .../drm/amd/display/dc/dcn201/dcn201_hubp.c   |  7 +--
>   .../display/dc/dcn201/dcn201_link_encoder.c   |  7 ++-
>   .../amd/display/dc/dcn201/dcn201_resource.c   | 19 +++----
>   .../drm/amd/display/dc/dcn21/dcn21_hubbub.c   |  2 +-
>   .../gpu/drm/amd/display/dc/dcn21/dcn21_hubp.c | 16 +++---
>   .../gpu/drm/amd/display/dc/dcn21/dcn21_init.c |  2 +
>   .../amd/display/dc/dcn21/dcn21_link_encoder.c |  9 ++-
>   .../drm/amd/display/dc/dcn21/dcn21_resource.c | 34 +++++------
>   .../dc/dcn30/dcn30_dio_stream_encoder.c       |  8 +--
>   .../gpu/drm/amd/display/dc/dcn30/dcn30_dpp.c  | 27 ++++-----
>   .../gpu/drm/amd/display/dc/dcn30/dcn30_init.c |  2 +
>   .../drm/amd/display/dc/dcn30/dcn30_mmhubbub.c |  2 +-
>   .../gpu/drm/amd/display/dc/dcn30/dcn30_mpc.c  |  2 +-
>   .../drm/amd/display/dc/dcn30/dcn30_resource.c | 13 ++---
>   .../drm/amd/display/dc/dcn301/dcn301_init.c   |  2 +
>   .../amd/display/dc/dcn301/dcn301_panel_cntl.c | 10 ++--
>   .../amd/display/dc/dcn301/dcn301_resource.c   | 56 +++++++++----------
>   .../drm/amd/display/dc/dcn302/dcn302_init.c   |  2 +
>   .../drm/amd/display/dc/dcn303/dcn303_init.c   |  2 +
>   .../gpu/drm/amd/display/dc/dcn31/dcn31_dccg.c |  2 +-
>   .../display/dc/dcn31/dcn31_dio_link_encoder.c |  2 +-
>   .../gpu/drm/amd/display/dc/dcn31/dcn31_init.c |  2 +
>   .../amd/display/dc/dcn31/dcn31_panel_cntl.c   | 10 ++--
>   .../drm/amd/display/dc/dcn31/dcn31_resource.c |  4 +-
>   .../dc/dml/dcn21/display_rq_dlg_calc_21.c     |  3 +-
>   .../display/dc/irq/dcn10/irq_service_dcn10.c  |  7 +--
>   .../dc/irq/dcn201/irq_service_dcn201.c        |  7 +--
>   .../display/dc/irq/dcn21/irq_service_dcn21.c  |  7 +--
>   .../display/dc/irq/dcn31/irq_service_dcn31.c  |  7 +--
>   .../amd/include/cyan_skillfish_ip_offset.h    | 10 ++--
>   .../gpu/drm/amd/include/yellow_carp_offset.h  |  4 +-
>   drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c        |  2 +-
>   80 files changed, 303 insertions(+), 279 deletions(-)
> 

