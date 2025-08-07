Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 51EBBC87FCA
	for <amd-gfx@archiver.kernel.org>; Thu,  7 Aug 2025 14:51:37 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C856210E097;
	Thu,  7 Aug 2025 14:51:36 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="RMEVXUHX";
	dkim-atps=neutral
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2074.outbound.protection.outlook.com [40.107.223.74])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BE85D10E097
 for <amd-gfx@lists.freedesktop.org>; Thu,  7 Aug 2025 14:51:34 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SS2D6lviLl64LzLmR/KZ7iozgCDxR6poPZ41tIfOhg5SG51efIKMdwP+LJbWIrVpo70ICaL3e+1R9rkbQUK2v1VIX1IiXEZvT2dGgVyVnzl11j+qk8RrRZzzZy8oiPHXFp1cnIlCIBfsv7OHYRi+4F8aJuCCQkysjjIGKdP2kUql0wJ9CRR0+/0ntPJs4aTUgFvWt0NiItFE/lHpoHZZC873WXdiI5by5XloA7XSCtGwp1zI5a9ER4F4RNDZ0GaMwbhaSYGW7xbc9AwR/2pSdu2Dt+HZw0qT4gmvPXYw44yi/+XWHRnU6wontszFyuaHlYREg1fcHsOaPyXDjEUNgg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ah2q+rtNOsQ4Uba71v2a+m9dWTd6VuuTmZBZcLaM+Ko=;
 b=gHSAQnutI9GHuCZJaUVI95qa0yWFZ9vHg9x3IlQEP+leekfBAryGZBxs3URgLK8ATLuorLa1HgU2t2Qx9BZWmSxCz1XP9cKQ+qJW/5yVlEBQLhFeI0oR8/CDJpsN0v8HCuPNvyz2TCQxc/Lc0v5akmz+mu7PTjumEN0UE0GdYqiDJgvaDSVQ+rSf1Nd9IxwUXeszpoexmIoOQAWoKv3lucJtqEZxrlgazT+lKZLdY2X5PKBuC8g8qFRYxuvU3y91G8Du/99j1MLhH+M0qA/Qrk5X8zQEBdb9/AwsSYsC/u9qwYEYeGD5MesoUrQO8CyS3GdLpB0jwFPmim/3/8hFpA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ah2q+rtNOsQ4Uba71v2a+m9dWTd6VuuTmZBZcLaM+Ko=;
 b=RMEVXUHXWcEel1HN8JShVzARYvF3zm1/Duqd2zfM8xGrwB1vmox4WgfOmumT7XwKhNXiHIaQpjFCuytpo3QiRNWaeM3rOriuorUOr5eBBXud8tmd2PO/ktiDO393kkITxOauYdKBR44PmjVUKMXtjVDz8lsXaUnNXY+MoiTc9mo=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by IA1PR12MB8554.namprd12.prod.outlook.com (2603:10b6:208:450::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9009.17; Thu, 7 Aug
 2025 14:51:30 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5%5]) with mapi id 15.20.8989.018; Thu, 7 Aug 2025
 14:51:30 +0000
Message-ID: <39f0846d-9df8-47ca-a058-fbe44333262e@amd.com>
Date: Thu, 7 Aug 2025 16:51:24 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v10 1/3] drm/amdgpu: Add ioctl to get bo info
To: David Francis <David.Francis@amd.com>, amd-gfx@lists.freedesktop.org
Cc: tvrtko.ursulin@igalia.com, Felix.Kuehling@amd.com, David.YatSin@amd.com,
 Chris.Freehill@amd.com, dcostantino@meta.com, sruffell@meta.com,
 mripard@kernel.org, tzimmermann@suse.de, Alexander.Deucher@amd.com
References: <20250807140051.2377470-1-David.Francis@amd.com>
 <20250807140051.2377470-2-David.Francis@amd.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20250807140051.2377470-2-David.Francis@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0397.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:cf::13) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|IA1PR12MB8554:EE_
X-MS-Office365-Filtering-Correlation-Id: 5d4c20fe-5d8e-43f9-8e3a-08ddd5c1e465
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?L3cwNUFVazNpd1pvMjVGbGVEenNjNHM5eEcyMlM0Q3U1REVqcWwxV1NIVUlr?=
 =?utf-8?B?amVLTUw4ZDBBS1REYmlWV2VvWEFKZ3lENXA3alpnYWQ0Nm5rR1FaeGNOSVBT?=
 =?utf-8?B?d1ArbDROaUI4VXRvUEFnUTdiK1NySkpRNWpNb3U3NUdjYzQwaEdlb2haMU9Y?=
 =?utf-8?B?UEVlSGcrVHpNWDJyY3lwL1I2VWNKamZsNzZBbFhWTEZYS2xLY3MyVDdUcVYv?=
 =?utf-8?B?UEJsdWFEdFZaSHduNW01NTRML1U1Smc2cS9LcWVVdXo2aGh0Yy9HeHNVUHhx?=
 =?utf-8?B?aHRzaW9rUVNkL0tVSWd0ZzFEdGlvekhUNGx1ME1ZQzZYWFc2N2VwSForM1Vw?=
 =?utf-8?B?M3czVC9yMzFhK1V3cWZnR3V2SFlKdEVNb0dwNGhWREVVcWdIRllscjZmMU1z?=
 =?utf-8?B?a2dKQkp3NzJ3WnJ6eVFEUU9pcEhOUzFMV2xpK2FIcm0yd01pVzlzTGprc3dL?=
 =?utf-8?B?UmhVQWQrSkhjRkFNQ1dkSmZOMEVkUHhvTmRRMWRkTDBhSnlvRWhJZEoxRm00?=
 =?utf-8?B?YmhEa1FCdnFsUDdVTGF6ajRGVUc5TjlhZ1ltYjlGVHM3N0NpU2o4NzdKc0Vr?=
 =?utf-8?B?dWZEM3V3WWdYcGtoclhmVVdiaU9pWm90ZlBGVFlaTTU5N1V4bDl0MC91OEVz?=
 =?utf-8?B?MWJRSzlvV3VmYTNqdnlBTjZDd3lKbVlXVW4wTHM3OFVldXdxaWxHMW5LSElI?=
 =?utf-8?B?NEVNeis2Nm1qNldUbFpnb3E1YzIxNVhudFFZY1ZtU1RMdXBMK2V5SkRyVHVm?=
 =?utf-8?B?TjJxVGlCN2E1ZVg3OWRqVlIwRzZQcU5uUmZFa2IzYWxHUXMzM1kyY3pxR1Fn?=
 =?utf-8?B?U2xlbXhNOVdBaER0UFFET1FHMXI4NXRpSjd4T2lEb0dTeitZbllOVVlaMTJ3?=
 =?utf-8?B?S0oycG9HWVVhWDBBbFJadmhuYTg1Y1VHOTY5bGxwK3hsc01kaGtDVVp3Z1hu?=
 =?utf-8?B?WWF0MFFOb3U3Tzl2Y3BFczVxTWFNR3VjbE5EZGlyLzBmVHNVTU1ya1REMk0x?=
 =?utf-8?B?SFpnWTRqYmVyV2JqVlRXTmQ2d0thWFFtTzdzRzFaeXFwOVF5amRkU210UGl4?=
 =?utf-8?B?bi94ejBCMGpZemxMYTU1UTlFSDdrNjY3WHVuU2NzRmNjbFZOTmVtTVZ5U1p4?=
 =?utf-8?B?V0VlUXUvbkpKa3NHeGVYK0hIN2xPUDNHelhZYVVyOUFpUUFWT3lobVE1Wm9C?=
 =?utf-8?B?NlppZVN2dXRRbGFFa1JUYTJ4dFRBY0RobmJscEE0R1d4KzNnYUdTSWtBWGRG?=
 =?utf-8?B?Y0Ixc1YwdmRqSXEzZnZNM1hOUmZxU2hjanpJekRCNGhac1JjR2dDaTN6dkRH?=
 =?utf-8?B?U3Z6Q3BDVDEwTnloYWlieG5CendzR2FwQk9mNXhIL3I2RWpRaVpHWEVOU0c2?=
 =?utf-8?B?R3I2UVFJa2FnWE1STGlPRmtlTXRNb2U3MXZoZzZueEduSGhYbU9QMmI4OFNL?=
 =?utf-8?B?QVFTZjkvQVVXczhtazExU0gwNFQ4a1p6Y01nZXE0VjcxMUY2ditScS9xZXd0?=
 =?utf-8?B?R2FaS1haUkc1YktrQTFwMWQzL1ZrK1QxWG5TSDNscDJpRkVGYzIwYmFTcFBG?=
 =?utf-8?B?MGVsMG9hN3ZOaWd0MEZWZm5adVhTZ0pqUjJtUUdKd0ZuZ3NjcVgrM0hza1V1?=
 =?utf-8?B?Zi9mazRnYkkyekZqTmxKZU41cGFIbFJIVGlKN00zdVNaUm8zZU1DS2svcVc1?=
 =?utf-8?B?T1JhVU0xbFcwNlB2ZlpScXNKM2w4Rzl3by9KbEZ6RVZRTlg0RVVFbEZyWmNL?=
 =?utf-8?B?TEpiTWJGUE1DSkt3WXJiemk4dHQxVVJoUWJhZ2ozaEFRZzQyMHppYWFCbE03?=
 =?utf-8?B?MTk5MzVXODFFbUhzKzJ1cVJkREI0U3VGV1pzendDMGgzVFFBVjhHNy9TVVZ1?=
 =?utf-8?B?b0Q3ZDZXNGMzU3p4TjB1ZmJTdGdwYlBWSmRlNUplMEQyVUE9PQ==?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dVhJZVZjT3Z3UEx4aVdpc3hwVnR2eHpqUE0rRWs0azJjK1FDbjB0SndQK2Yr?=
 =?utf-8?B?NzM2Zll3S2g5MVJrUUpxblNZa1JXZUgrRjlYNDlWSkZtVEo5RFB2ckNyY0ti?=
 =?utf-8?B?S29VeWt5Q09WSlBvWVhnTElRUHU2VDVlZ3oxd3RiSzJzNUtwNVIvVTdiOUw0?=
 =?utf-8?B?NnN1YUZKYy83R3ErL2Q3d1ZicUZTWHdIQ2ZqdXFQWmc5MUlzN0RvNy80Y1FL?=
 =?utf-8?B?MG93SDlyZUhFZURwNU4vSjJuUWFPVCsrZTRoRHBJaHlwQUVJeWwzblVjS0c3?=
 =?utf-8?B?b3JBMmh0T2pXMTcvcnFXdHFONDM1UFZOQ1VUaVRkTGpsTlZJU0xaQnF0cTAx?=
 =?utf-8?B?QUpIYkxLT2ZCQUlFU1lPUmRkR3FkRlQwQXpreU9tbzdhRmd5R21Ea29sUHFj?=
 =?utf-8?B?WkZ0VVZxeUNJa2p4cmxNRUZFUjRYaXdPM1FvU21zejQ0WDZjZG4xbW1tRWUy?=
 =?utf-8?B?M1BGRThMY3BZc0VpQUZ5alBtVlZkdjQ0dnVzaThCZ3B1UCtBL3dMV0wxcHd1?=
 =?utf-8?B?NGRqdExmd21IbEkwWTNpRmFrelN4VzhhY0I4TzcwdEc5K1hRajhlRERwak1p?=
 =?utf-8?B?Nm9hSmhnK2dybzBPcWorMkIxZGpRQ1R3QTg3ZG0xZlZEYTFlYjlRZG1IdHB2?=
 =?utf-8?B?eDRpYitGZjNRdVFqdVZHaWJNdUVTREZSdDdKQTNKbTFBWDlPTENOU3NjZWpF?=
 =?utf-8?B?aVlkRlRDR2ora3lQYXNpZnNoZkhhczFNNDVzZkU1dW5QcEU0VXRLQnpIOXcv?=
 =?utf-8?B?blFGM2VqUTVlQmgydU8wNDkyc2cwaU4yTDcyZ1VhaWlYcUJnOTI4Y2Y5NFdq?=
 =?utf-8?B?ejZLOW11UlVHdDkycHhQVnNXMndjb1pQUENBaFBoQzZ0Y3FVaDUvYkc0OWRM?=
 =?utf-8?B?cUd3dURSSTg0dDY4dG1uRFF3bGpJTUh1NW9LZTZTSlBFWkt1N0VaVU1qZTN5?=
 =?utf-8?B?dm1Wc3JWZ3Q1cCtlVTlyNmdvMDhWaGduRG5UNTNONHNBaGJpNFJjQnVBc0E0?=
 =?utf-8?B?KzRTL3RqU3JNV09VUXFaVjkzeUNBQk5Fb0JSandETFZiS0w5a2paUFhvbU9L?=
 =?utf-8?B?K3dEK01XanBpTmZEWTdyOE16aVBrKzYwUTF6UnFjSHFaTHI1ZVh2eGprMUtz?=
 =?utf-8?B?dFlqUFN3MlZMcGZEMWtDVTdzWHM4RlRET09oWW1pY3NRcnNDZTFPVXJpK1ZO?=
 =?utf-8?B?WFZJSkF3YTAxRVhOMDVWckZ4YzdLQnZIVER5QU4wcTJZdi9KMlByYUszTXNY?=
 =?utf-8?B?bHVnYzJZY0NqNWNKcldueFFpbGFvckpMMmRKQWZXQVBZRU1CQ25xSEZ2ak9R?=
 =?utf-8?B?NUlzcERxSzlpdmVTcWl1ZjZJdW9ndlFJcHNUQ2NjNTBOa3A5NkM4cC93b3RZ?=
 =?utf-8?B?TU5tN2d3TThaQXRFMXJaUlVmMzV5OEx1T2xLV0pocnVoc3AwTkxPeWpRdXMz?=
 =?utf-8?B?d2owSDRKbjNOTHNWQU5ORGlqNjhlcVBlL2s0eUVFeFgyMjY1b2pyTmxmeGFj?=
 =?utf-8?B?QWZ5KzdNanBmN0hUNytHbk9keFJrdXRUL3FkSytONjdjNnRFR3pCSXdpeS8z?=
 =?utf-8?B?VGc0SEtOeDZOdHRNbitiU2RsbC9IZ2hKM0QzNjdxY1FtZjYvOXhhbFQ1ci9z?=
 =?utf-8?B?SENmUnNXQitGbUxueGR2RDc0WG9BMEFjWFRTbnJPRjQxU3g1bFZFSmpROXhi?=
 =?utf-8?B?TGh1Szc5Y2F5WjFoam1KOWREVC93SU1hcVZ3K2VKeXV1RVNheGd1dEJ2WFVB?=
 =?utf-8?B?WVE4dG05cG43cE5kenBpYnF2VElZdXZhVmNzUTZTRXpzQnN2ZnJCcjlzSkpS?=
 =?utf-8?B?Nm1BckF3bWw4NER5cERXQStLMitCdWxRa1o1bHlvVFg4R1p3NVZJMVNXbkV3?=
 =?utf-8?B?LzlObFpjaEZQL3NUNXNRYUc2T2kvazBpYllWZlFSYjJJTld6UWVVZVpTMFBw?=
 =?utf-8?B?NDF6NlMyNVFvZk5VLzRMSFdtYXBBcDFXSCtkNnNGeHhnNHhmR3NDNmw2US9G?=
 =?utf-8?B?bnJLZmNpVy9na09uVk12Y2xucFN6Mk54V0JnZWg2enBOSDRWV1lNd0NnVnZt?=
 =?utf-8?B?VUZyQXdzSTVnWUpFNEdIU2dHZGw2NitsTWNpQTJzTWdyNGRLc0ljQUNZY2pr?=
 =?utf-8?Q?WrPjd0I2dOJf8T7uubaSKWJZF?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5d4c20fe-5d8e-43f9-8e3a-08ddd5c1e465
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Aug 2025 14:51:29.9991 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: J++lM1KraFS1QahiuJF8ZsVKpvwCUWFDte0zbdFSUkoHybPPdpERyDYdy3RyIjsu
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB8554
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
> Add new ioctl DRM_IOCTL_AMDGPU_GEM_BO_INFO.
> 
> This ioctl returns a list of bos with their handles, sizes,
> and flags and domains.
> 
> This ioctl is meant to be used during CRIU checkpoint and
> provide information needed to reconstruct the bos
> in CRIU restore.
> 
> Signed-off-by: David Francis <David.Francis@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c |  1 +
>  drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c | 73 +++++++++++++++++++++++++
>  drivers/gpu/drm/amd/amdgpu/amdgpu_gem.h |  2 +
>  include/uapi/drm/amdgpu_drm.h           | 33 +++++++++++
>  4 files changed, 109 insertions(+)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> index 4ff3a2eaaf55..9ee4644b508d 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> @@ -3031,6 +3031,7 @@ const struct drm_ioctl_desc amdgpu_ioctls_kms[] = {
>  	DRM_IOCTL_DEF_DRV(AMDGPU_USERQ, amdgpu_userq_ioctl, DRM_AUTH|DRM_RENDER_ALLOW),
>  	DRM_IOCTL_DEF_DRV(AMDGPU_USERQ_SIGNAL, amdgpu_userq_signal_ioctl, DRM_AUTH|DRM_RENDER_ALLOW),
>  	DRM_IOCTL_DEF_DRV(AMDGPU_USERQ_WAIT, amdgpu_userq_wait_ioctl, DRM_AUTH|DRM_RENDER_ALLOW),
> +	DRM_IOCTL_DEF_DRV(AMDGPU_GEM_BO_INFO, amdgpu_gem_bo_info_ioctl, DRM_AUTH|DRM_RENDER_ALLOW),
>  };
>  
>  static const struct drm_driver amdgpu_kms_driver = {
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
> index e3f65977eeee..ec80b751e697 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
> @@ -1032,6 +1032,79 @@ int amdgpu_gem_op_ioctl(struct drm_device *dev, void *data,
>  	return r;
>  }
>  
> +/**
> + * drm_amdgpu_gem_bo_info_ioctl - get information about a process' buffer objects
> + *
> + * @dev: drm device pointer
> + * @data: drm_amdgpu_criu_bo_info_args
> + * @filp: drm file pointer
> + *
> + * num_bos is set as an input to the size of the bo_buckets array.
> + * num_bos is sent back as output as the number of bos in the process.
> + * If that number is larger than the size of the array, the ioctl must
> + * be retried.
> + *
> + * Returns:
> + * 0 for success, -errno for errors.
> + */
> +int amdgpu_gem_bo_info_ioctl(struct drm_device *dev, void *data,
> +			      struct drm_file *filp)
> +{
> +	struct drm_amdgpu_gem_bo_info *args = data;
> +	struct drm_amdgpu_gem_bo_info_bucket *bo_buckets;
> +	struct drm_gem_object *gobj;
> +	int id, ret = 0;
> +	int bo_index = 0;
> +	int num_bos = 0;
> +
> +	spin_lock(&filp->table_lock);
> +	idr_for_each_entry(&filp->object_idr, gobj, id)
> +		num_bos += 1;
> +	spin_unlock(&filp->table_lock);

Yeah that won't work likes this.

> +
> +	if (args->num_bos < num_bos) {
> +		args->num_bos = num_bos;
> +		return 0;
> +	}
> +	args->num_bos = num_bos;
> +	if (num_bos == 0)
> +		return 0;
> +
> +	bo_buckets = kvcalloc(num_bos, sizeof(*bo_buckets), GFP_KERNEL);
> +	if (!bo_buckets)
> +		return -ENOMEM;
> +
> +	spin_lock(&filp->table_lock);
> +	idr_for_each_entry(&filp->object_idr, gobj, id) {
> +		struct amdgpu_bo *bo = gem_to_amdgpu_bo(gobj);
> +		struct drm_amdgpu_gem_bo_info_bucket *bo_bucket;
> +
> +		bo_bucket = &bo_buckets[bo_index];

You are relying on that the table won't change after dropping the spinlock, but that's not guaranteed.

You need some extra check here to not write over the end of the buffer or otherwise you create a really nice API to hijack the kernel.

> +
> +		bo_bucket->size = amdgpu_bo_size(bo);
> +		bo_bucket->alloc_flags = bo->flags & (~AMDGPU_GEM_CREATE_VRAM_WIPE_ON_RELEASE);
> +		bo_bucket->preferred_domains = bo->preferred_domains;
> +		bo_bucket->gem_handle = id;
> +
> +		if (bo->tbo.base.import_attach)
> +			bo_bucket->flags |= AMDGPU_GEM_BO_INFO_FLAG_IS_IMPORT;
> +
> +		bo_index += 1;
> +	}
> +	spin_unlock(&filp->table_lock);
> +
> +	ret = copy_to_user((void __user *)args->bo_buckets, bo_buckets, num_bos * sizeof(*bo_buckets));
> +	if (ret) {
> +		pr_debug("Failed to copy BO information to user\n");
> +		ret = -EFAULT;
> +	}
> +
> +	kvfree(bo_buckets);
> +
> +	return ret;
> +}
> +
> +
>  static int amdgpu_gem_align_pitch(struct amdgpu_device *adev,
>  				  int width,
>  				  int cpp,
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.h
> index b51e8f95ee86..d33b19fd1488 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.h
> @@ -67,6 +67,8 @@ int amdgpu_gem_va_ioctl(struct drm_device *dev, void *data,
>  			  struct drm_file *filp);
>  int amdgpu_gem_op_ioctl(struct drm_device *dev, void *data,
>  			struct drm_file *filp);
> +int amdgpu_gem_bo_info_ioctl(struct drm_device *dev, void *data,
> +			      struct drm_file *filp);
>  
>  int amdgpu_gem_metadata_ioctl(struct drm_device *dev, void *data,
>  				struct drm_file *filp);
> diff --git a/include/uapi/drm/amdgpu_drm.h b/include/uapi/drm/amdgpu_drm.h
> index bdedbaccf776..1b3d2ba2f556 100644
> --- a/include/uapi/drm/amdgpu_drm.h
> +++ b/include/uapi/drm/amdgpu_drm.h
> @@ -57,6 +57,7 @@ extern "C" {
>  #define DRM_AMDGPU_USERQ		0x16
>  #define DRM_AMDGPU_USERQ_SIGNAL		0x17
>  #define DRM_AMDGPU_USERQ_WAIT		0x18
> +#define DRM_AMDGPU_GEM_BO_INFO		0x19

BO_INFO is a bit misleading, maybe name that DRM_AMDGPU_GEM_HANDLES.

>  
>  #define DRM_IOCTL_AMDGPU_GEM_CREATE	DRM_IOWR(DRM_COMMAND_BASE + DRM_AMDGPU_GEM_CREATE, union drm_amdgpu_gem_create)
>  #define DRM_IOCTL_AMDGPU_GEM_MMAP	DRM_IOWR(DRM_COMMAND_BASE + DRM_AMDGPU_GEM_MMAP, union drm_amdgpu_gem_mmap)
> @@ -77,6 +78,7 @@ extern "C" {
>  #define DRM_IOCTL_AMDGPU_USERQ		DRM_IOWR(DRM_COMMAND_BASE + DRM_AMDGPU_USERQ, union drm_amdgpu_userq)
>  #define DRM_IOCTL_AMDGPU_USERQ_SIGNAL	DRM_IOWR(DRM_COMMAND_BASE + DRM_AMDGPU_USERQ_SIGNAL, struct drm_amdgpu_userq_signal)
>  #define DRM_IOCTL_AMDGPU_USERQ_WAIT	DRM_IOWR(DRM_COMMAND_BASE + DRM_AMDGPU_USERQ_WAIT, struct drm_amdgpu_userq_wait)
> +#define DRM_IOCTL_AMDGPU_GEM_BO_INFO	DRM_IOWR(DRM_COMMAND_BASE + DRM_AMDGPU_GEM_BO_INFO, struct drm_amdgpu_gem_bo_info)
>  
>  /**
>   * DOC: memory domains
> @@ -811,6 +813,37 @@ struct drm_amdgpu_gem_op {
>  	__u64	value;
>  };
>  
> +#define AMDGPU_GEM_BO_INFO_FLAG_IS_IMPORT	(1 << 0)
> +
> +struct drm_amdgpu_gem_bo_info {
> +	/* User pointer to array of drm_amdgpu_criu_bo_bucket */

That structure was renamed.

> +	__u64   bo_buckets;
> +
> +	/* IN: Size of bo_buckets buffer. OUT: Number of bos in process (if larger than size of buffer, must retry) */
> +	__u32   num_bos;
> +
> +	__u32 padding;
> +};
> +
> +struct drm_amdgpu_gem_bo_info_bucket {

Why bucket? Maybe "entry" instead?

> +	/* Size of bo */
> +	__u64 size;
> +
> +	/* GEM_CREATE flags for re-creation of buffer */
> +	__u64 alloc_flags;
> +
> +	/* Pending how to handle this; provides information needed to remake the buffer on restore */
> +	__u32 preferred_domains;
> +
> +	/* Currently just one flag: IS_IMPORT */
> +	__u32 flags;
> +
> +	/* gem handle of buffer object */
> +	__u32 gem_handle;

Make that the first member, it's basically the whole reason we have that here.

Regards,
Christian.

> +
> +	__u32 padding;
> +};
> +
>  #define AMDGPU_VA_OP_MAP			1
>  #define AMDGPU_VA_OP_UNMAP			2
>  #define AMDGPU_VA_OP_CLEAR			3

