Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3A75DC25B74
	for <amd-gfx@archiver.kernel.org>; Tue, 21 May 2024 16:50:08 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 84F1B10E1F5;
	Tue, 21 May 2024 16:50:06 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Mx3JkjCb";
	dkim-atps=neutral
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2067.outbound.protection.outlook.com [40.107.223.67])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 26D3710E1F5
 for <amd-gfx@lists.freedesktop.org>; Tue, 21 May 2024 16:50:03 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aiYyLHUqnKdJrPUVaidBl2nv9JqzJ7Ypu2iujEhpNirzAB31/9zWLFLxlge3QKzGGkgUYykrbwvRXsj3ixVzaF32Wi0JF7KI5+zr9OD3DZcj9mOBoxv0+8/nCpni+mlKaxM5dak+IkXZwQH392mYcSF3N6XzcdxYHWVKbHYIr1vpDb/cJ8iOsaRBK0ecPxvgL1xH8VrNjt8mD12GGECgfucJphRYmNmqcXwO67xYLG4Prg25xj1OqGCIGNxlMpzy7VjTe+SyqcW01fAaSPMpcZayoQ5oLVScFH309rJCOrWCImVWOM/rLi7Q5PGzAb9j3wKyRlzxiVHq7ImmEpkirQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=09bUj6PcRuWTOrH5Y0dVJCnqBEBFNdfH06d1CawXqEo=;
 b=G1uGsgpaKozmw1rsE11l6BVsqCWGoBHJnie5jaaV6AwcYgmS9oC6wkHzXQ3kLS48I/61zoEp2kxmNZnihnvIqBkN5uLJAvWjoHecEmVrhMTIiZPLYzTrGxKGjUGSssPFr1FzTef7dxVElcMiZKzdAYpkC+mlZ3tLxI77Bs3Vh5qrlS0B2vbrqT8kFRpdqLFmepiUXLHYUVzYb5i2ChGE0nln5NcbqUsNO12IuUg49iQA2j0DFVQrNHLRMrx17H2SmXiTLzGeci8rzzFOBjStgkHFR1Q1FQiffeESHoXM+7al1Pxl72X8rva0UnHxxTYRgB22PMupDivTf+RdlJO5cw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=09bUj6PcRuWTOrH5Y0dVJCnqBEBFNdfH06d1CawXqEo=;
 b=Mx3JkjCbpcuQVIGKQ8BAuFUJNecp5detjg2kb7fAmaioGS0Q8NoG+pnKMQFky/pjyOhKdGuODLSEGZ7LX13QtWBd9ujOVFs901/jyApGbdAEgYpCLIYHX6HG6deMOidChGnqcfQawfs8VVKB+iX/8hV5lXsr5TnPlnKh6TvPQLQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
 by SJ0PR12MB6879.namprd12.prod.outlook.com (2603:10b6:a03:484::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7611.18; Tue, 21 May
 2024 16:50:00 +0000
Received: from MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::37ee:a763:6d04:81ca]) by MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::37ee:a763:6d04:81ca%7]) with mapi id 15.20.7587.035; Tue, 21 May 2024
 16:50:00 +0000
Message-ID: <8995a73d-00ae-4e1f-84cc-927afe35fb09@amd.com>
Date: Tue, 21 May 2024 11:49:57 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 0/3] Add support for ISP interrupts and disable prefetch
To: Pratap Nirujogi <pratap.nirujogi@amd.com>, amd-gfx@lists.freedesktop.org
Cc: alexander.deucher@amd.com, christian.koenig@amd.com, mlimonci@amd.com,
 benjamin.chan@amd.com, king.li@amd.com, bin.du@amd.com
References: <20240521164841.36101-1-pratap.nirujogi@amd.com>
Content-Language: en-US
From: Mario Limonciello <mario.limonciello@amd.com>
In-Reply-To: <20240521164841.36101-1-pratap.nirujogi@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SN1PR12CA0088.namprd12.prod.outlook.com
 (2603:10b6:802:21::23) To MN0PR12MB6101.namprd12.prod.outlook.com
 (2603:10b6:208:3cb::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR12MB6101:EE_|SJ0PR12MB6879:EE_
X-MS-Office365-Filtering-Correlation-Id: d1a85d65-d994-412c-ed4e-08dc79b60dd6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|366007|1800799015|376005;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?OUdhWjVhOVFzSlkzVFRtYzBlRjBDbllIZHJUNFNDR3RiK0lXNWVFcU1uK2xa?=
 =?utf-8?B?c0pPcDNQcGM0UUpQSHZJZHVWUzAxdVFYRGY5R3FwakVYZmRtb2E5aVoycVpO?=
 =?utf-8?B?NVVxQ2xTcEJ6MmJocjhLZEQ3cm9GN2FsM2EzcW9sQUJvRlliUXhuQnJsU0hx?=
 =?utf-8?B?Mk1YNTVhcm5Vclh1dUk3KzFiZjVHZ2JxRUNyY1Y0NnNrcmxhV0RLWXByUU5S?=
 =?utf-8?B?YVFRYWJJV1ovVFVyWTh5QW1ORUFSYmlESkp6RC9xTU1KUmdoRE1KVjZ2QWc5?=
 =?utf-8?B?STFhQjJrREk3emJubGQwci9pTU83dmtrbVZhUCtLUnRXcndjSVNqY0xyTmhL?=
 =?utf-8?B?a2RaNzRsSEwyaHFFN1ROenRIdFpCMC9FTXpmL0FEZTRXV3FhdTBmSEJ4Rlho?=
 =?utf-8?B?WGM5SkFXeDFnTkVFdHRXeGR5V1dNSGRYL1o4MldaSHRZVVd5L3FMT3dweXI2?=
 =?utf-8?B?TGtlcGNCUGhPblZJSlFHejY5ak90cjBkeVNYemNkc3NyTkNzZVhhODdmSm5t?=
 =?utf-8?B?VU4xLzNNd3BtTXZIemFGS2d6VHJya0w0d1BONW1xckZhbkkyTDdTYldpeXV1?=
 =?utf-8?B?dHRycnpUQ2Q0Z0ZlYVB3bzA0Wkd6aGRCbFBQOHAvLytWaGJuMGVpUmVNdmU5?=
 =?utf-8?B?S1FOdkZNUEwxYW1YZndVVERLc0RER1hzY0Y1eXVTekxka01kQ3Q0VHNNWWRY?=
 =?utf-8?B?NzArWUF0eHh3a3pNM0dSVW9WN2tneXlVUzNrN2xWbE43eFpITFloQzdxUWt4?=
 =?utf-8?B?NG13Yk1LRllMZ0xDNDFxSmd3TkJHd1o2L0tzV2VFWUkzb3I1dUVWcWZpSFJn?=
 =?utf-8?B?U0U3VmJtK0xCTFV0Z2prTHhCRnBvNk5Pa1hDME1wL01zMm1ESTlMR2o2ZTgr?=
 =?utf-8?B?b0RQdllxSGY2NmpNUVN1QTFxT3J5LzEvVk9oN01ST3pNZmpVRUlTV2lXcytB?=
 =?utf-8?B?aEhkb04zREpXTUcreS9xSTIzQ2F6ckxqMXhrVWcyWjFFamNJV3R4UFBUN2hX?=
 =?utf-8?B?ZW5hOGJyMUJ1YTlFMDhRVTcyZEZXVi9SSHB1RVFCRlAweStsTkRWUWtCZVBH?=
 =?utf-8?B?MUJPMkFZMkVyNEd1emIweERCRkl1UGxGMmNTMGFCbjgzR3NRRTcwbTlUbGk0?=
 =?utf-8?B?VVo3TGVRRGxwM1NuUlBYYUR0WEdENnBJVnQwL1lxVlJmMnk4czl2QlRJT0Vj?=
 =?utf-8?B?NkwxSmtnT1J4ZXhNUkNNRWpJeGE2blhpVkJ2T0NrZFZscnR6cjgxS0pORlZy?=
 =?utf-8?B?Mlp3WXp2emt2cGZWb2dFVnlESThYSTZIbENiOVJ5SnRjSUZQR1FVTVNNV1RL?=
 =?utf-8?B?VDBuQlZCT0xmQmc3ZksvQ3U1Q3kxTUZjUWcvb1VTWm8wS09CMDBPQ3dwdlgv?=
 =?utf-8?B?TVF2eHY5V08zWVZ6K2F6OHc2eFFkL0Y5Ly9BK3R3anlGb1Qyd3k1VGpzNk1p?=
 =?utf-8?B?TzF3THVEV1NqMlZnS0VOcnhiR0xuYzZlUFRQbDZIRHFRN0xrbzN4aXRiQ0ls?=
 =?utf-8?B?MTNKL0c1WVJobkVwZ1didEIyRllOaFdqUHBLVjh1clVta0hBV1VWc2JuV3VQ?=
 =?utf-8?B?RG1xL2Z3YzdMa0JmeGs5R2ZMVndYeUVzN3AzNG5WdUZSTnppVnErK1NyNXY2?=
 =?utf-8?B?WkxyWTArSkJGSDVyVkdtMFlVUFp1Ym96QUo5R3lnNS9tZ0NNSEdwdWw3SUZo?=
 =?utf-8?B?QWozaU5PRy9hWjVvYmsxYnQxRXJPSlJIRlMrNFVpdkZSNC9CQ2JBYUhRPT0=?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN0PR12MB6101.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(366007)(1800799015)(376005); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bzA0M2RlYVh6QVNHalM2ZTVUQjd6WE9Dd1QvUWZZa2wvRW9Pcmc4ZkJKbUxC?=
 =?utf-8?B?azNLWE82UHBVMXNzcDl0eC9rK2ZKbTAyekxncTFBaHh1Q1Yra2FtbWJ1U0hq?=
 =?utf-8?B?MlRQZmxYVU1XKytGQitqeXN3TDFNVUVoZVc2cG9rQjB2Q0ticDZTRkFkWUF0?=
 =?utf-8?B?Yzg5YlBpZzRUL25mZnNzbENBNXBUMDdZMlNMWGQrZHovL0QvR25uTUtHODFo?=
 =?utf-8?B?SWd3N1VqakYrWktqaDFZdHE4VDF6UzNETzY1T0REai9MQUdsSk5uWldSRTJp?=
 =?utf-8?B?bTJRR2xhMVZheU9zZDFvb2g2bzZmYmprSjczWXlUb1R2dEpVck54SW1uU0hU?=
 =?utf-8?B?eUJYYU5SbEFmbVlxaWdHamRzOHVGRUFkQkluRW9sOEFwYVoxV2Z4aTIvaVhk?=
 =?utf-8?B?alBnM3ZYa2FNWjlSWEprTXQzZy9Sd01pVmx6VjJWSDhSVkpVMGZVa2FNMTJz?=
 =?utf-8?B?YUlROTVSRnVPYUk0aXorM3pwU1lQNVpLM3RWdjVTTGF3eDFOczRxSFpydi9q?=
 =?utf-8?B?WVZ1US9rYTBzYzdmem1tQUxWcUxHdWdJcVN2NjlkbUhBS1B2WUt2QnlTMFlo?=
 =?utf-8?B?bk9CNUo5dDJKOUlLQmlKa1A1cm1Pc3ZGckhKQzVodUo1WHd4V29CakVKSmZp?=
 =?utf-8?B?K1lyeHgrWENGNnVmVmY3NGQ5Qy91aEJPQ2tXbkNoWStLQUZNZGtvSWtVRXZn?=
 =?utf-8?B?OWlsc1F6QklVRlArMGFSVXpYM2p1UGZWUndZWFYwK2xZN3VuWVhMQWc0OG94?=
 =?utf-8?B?cHVrNkRDMmZlTlFWUnQ0M1pueU1YMFVVZGpUdE9KVUNwYXNEQmFvQXBHQmMv?=
 =?utf-8?B?RHl1SGVsREZPdHNjRHhNMFI2OXRaT3o1K3luK1Z2L2ZlZmM1d1hYM09Ua3FS?=
 =?utf-8?B?THFFRGErU01UUG9TSHdyUUhtb0MwU1dEcWhRd2JQR0xDaEljcTlnWDUwemtF?=
 =?utf-8?B?STYwbVJ1cEJaN0dpRlZTakRXakRIMEx3K1pzQTBSRFVrTDdnSmNxK2kzQVhh?=
 =?utf-8?B?OVlsbXJJUEtKbHZXNGtNck45V3lkakFUWGtBdDdJVVZLNGN3Ym1iWHBEVnFw?=
 =?utf-8?B?ZGU1NEhXcUg4b1pqYStoOUwyZ1RFR0JSTldtVUlTa1FSQlhpQzIvaTlEcnNO?=
 =?utf-8?B?MXRrTGtTTWRKK3NpZ3llQTdDMXRvZjUwbU01all1cXJOanA2dWpERThRNmtw?=
 =?utf-8?B?bHRHa2ZaUUVxWHBaUFB0QUM2YVlIVzgwRHZVQ1JDdkZCbTVXZDZRY0gvWTB2?=
 =?utf-8?B?Nm5naS9pQUFKbE1abVpKWWptV25MRC82S0VwMjVTbkg0ZE81ZUhIQVFvaUt4?=
 =?utf-8?B?ZHd1ajBBQlhZbkJ6a0ZNeTRuL1dMc0s4Q1ZORmhiMDYwa2xwQmNWYTdBdmIv?=
 =?utf-8?B?TFhtdktRK092cFVYVDBWdnpodnk4Qzk3Sms5MTc4WFVld2FiaUxmQWk2K0hP?=
 =?utf-8?B?YWZHL2d1bnMrejdwMU1BTnlZaEloMTFMWDNvUStWYksrMjJ4V1UxQzhLcjFs?=
 =?utf-8?B?WkROWGcyRnRtVDhrVFRET3llRnFGOXFVR3hwdUhFVFJPNDJsZ3R0SkxvYm9Q?=
 =?utf-8?B?amQvZmp0dU9MeGpQY2RhSFNndWU5S1FwR0dZV0VYMDVXdVZOZ0prT2M3YzEw?=
 =?utf-8?B?TisydGhFd3BGam4xbllsU05ZS3IxZmFqOWRxZWFQRG5aOHhIYVZuaVpDcjQw?=
 =?utf-8?B?eDM5dnl5TURNdDQvWTE2dWo5MFg3VzFoVmtlcjFxZXFlZDRIcEVIV1c3WWp5?=
 =?utf-8?B?Wm5CMWFNOHlKNzBVTVdidDlRZ0l5YU5TNWU5cXNWbmtucnZjNVp2TnhCZlJG?=
 =?utf-8?B?akZtVzBMVHpKV3VKQzlaUEtSTTRFcXRsdTFLT3cyUDBheU95VG8vQWlwU1BF?=
 =?utf-8?B?ZlZXbEJjUGxXbHlxV1BZTUVmSlIxWEQyT3RYT1hpdHVyZEEyalp1ci9ZQ0ZC?=
 =?utf-8?B?TG92Mng4OTZraUQ2V3E4WTN0RkN2alhBYUtCeWluREVYQlZBUUNVSmxNVE5J?=
 =?utf-8?B?bUhUa2NFOFhDQWdFeGZVQ0QwcHUzT0MvVXlSV1ZidlNnQ0J6OHR0SkhyTUFo?=
 =?utf-8?B?dU9RSUZVSkJuMW1lMmtRTUVPYi80QjNqRWREdVFJS2hFZ08zbGQ2aEhCVWJa?=
 =?utf-8?Q?PM8L5LGqwY/gLsOOX6o16xELB?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d1a85d65-d994-412c-ed4e-08dc79b60dd6
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 May 2024 16:50:00.4929 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RImxJMloHwcNFq7rqV0pc53LJNuqLoK7D6Sy1m8t0dDEzb0QznZMPOwlsXsxTgG4FtZQ/LSodJovJxzdEfdbww==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB6879
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

On 5/21/2024 11:48, Pratap Nirujogi wrote:
> Add support for ISP interrupts and disable MMHUB prefetch for ISP v4.1.1
> 
> Pratap Nirujogi (3):
>    drm/amd/amdgpu: Map ISP interrupts as generic IRQs
>    drm/amd/amdgpu: Add ISP4.1.0 and ISP4.1.1 modules
>    drm/amd/amdgpu: Disable MMHUB prefetch for ISP v4.1.1
> 
>   drivers/gpu/drm/amd/amdgpu/Makefile           |   5 +-
>   drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c |   4 +-
>   drivers/gpu/drm/amd/amdgpu/amdgpu_irq.c       |   3 +-
>   drivers/gpu/drm/amd/amdgpu/amdgpu_isp.c       | 144 +++++------------
>   drivers/gpu/drm/amd/amdgpu/amdgpu_isp.h       |  13 +-
>   drivers/gpu/drm/amd/amdgpu/ih_v6_1.c          |   6 +
>   drivers/gpu/drm/amd/amdgpu/isp_v4_1_0.c       | 149 ++++++++++++++++++
>   drivers/gpu/drm/amd/amdgpu/isp_v4_1_0.h       |  46 ++++++
>   drivers/gpu/drm/amd/amdgpu/isp_v4_1_1.c       | 149 ++++++++++++++++++
>   drivers/gpu/drm/amd/amdgpu/isp_v4_1_1.h       |  46 ++++++
>   .../amd/include/ivsrcid/isp/irqsrcs_isp_4_1.h |  62 ++++++++
>   11 files changed, 517 insertions(+), 110 deletions(-)
>   create mode 100644 drivers/gpu/drm/amd/amdgpu/isp_v4_1_0.c
>   create mode 100644 drivers/gpu/drm/amd/amdgpu/isp_v4_1_0.h
>   create mode 100644 drivers/gpu/drm/amd/amdgpu/isp_v4_1_1.c
>   create mode 100644 drivers/gpu/drm/amd/amdgpu/isp_v4_1_1.h
>   create mode 100644 drivers/gpu/drm/amd/include/ivsrcid/isp/irqsrcs_isp_4_1.h
> 
Reviewed-by: Mario Limonciello <mario.limonciello@amd.com>
