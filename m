Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A4F5EC02188
	for <amd-gfx@archiver.kernel.org>; Mon, 20 Jan 2025 09:04:43 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5674B10E378;
	Mon, 20 Jan 2025 09:04:43 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="02L2+82+";
	dkim-atps=neutral
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2045.outbound.protection.outlook.com [40.107.244.45])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 875B110E378
 for <amd-gfx@lists.freedesktop.org>; Mon, 20 Jan 2025 09:04:41 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vW2K5oqqPEqe+h4njWgDlTxHS6DYUuzSrfLQbF8jUKNYZRolFqJDffU1xocj+GEkgWa0OgDmHCtVrSNxgqmlDfgXC6H1DyG9XeUmI3H7Ge7iW1VmDqSsw2Lp8Aw2jncBy7W7Iy5FCbQb1V7x1uy8UuA1G5pZHmNJ62D7ACD/yUkYveiIvAKYISioOPzojoUKnfstSAAu/YmwAYoTZfTI298xXUoP+fThuHm3i3c84RF3cpWLkRRP9ASV/TjLMidCqyRD+45lVOlAO1aRBgCpVmTTaCOsd6/FnbvSPR5RZSaDHDm5CUVyN5xZHPjRiCdmx6YsZXyxlf23aX/msSVnzg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=n8eo+V1MYHFrS3PARjCGVI+mEwcN6f4U9ym+gUMg7CA=;
 b=PDsOwZ1VgfFO7+pRtQ5Ptw5FyVi0UwKsIE7tV4E3pJxLYJRkxYo32swA0xBsQBW06fI6jMArm9V91DECsppSERYsjQckIL2AG3N21qy4d/SOEUpRrY5dwchn/P+2bKMr36TV6hQRElVmPhvndvRRJu6ALQeFl5sWx9k0T2p0lf/Y7jR2cFpUAayrNm5Fc3ILNL9kkZHIfl8mm8ovnL1N0IZmXif0kx2LTLD0+mUy5jkoz35RiYd1IEmQgolqYyj1V6X0hMrI2f+n/KULwaAVDtoFTphDIqEOAJbtZfSBD5NhikwsS3BPJ9Cy6P2l8MnSBR4Rehyf1LOM9cj8Eg93XA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=n8eo+V1MYHFrS3PARjCGVI+mEwcN6f4U9ym+gUMg7CA=;
 b=02L2+82+e1Q0FHex+GuFfvVaEaCPU0Dl5sutEfAabKoZVhGTIboLqJBKDtR4CZlXd78JQpIFNSkAK9w6+GSdk8uUvc7VKwH1KdzPiGcMWQsSxrs08p/OZ6VoUjda0mFPuNIJq9VSIMNcOSccs9ufSpD+9z28MFf5R0kEaxOOzZ0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by BN5PR12MB9488.namprd12.prod.outlook.com (2603:10b6:408:2a9::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8356.21; Mon, 20 Jan
 2025 09:04:38 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5%5]) with mapi id 15.20.8356.014; Mon, 20 Jan 2025
 09:04:38 +0000
Message-ID: <5a5af585-cfa1-473f-a758-29e47b49ef50@amd.com>
Date: Mon, 20 Jan 2025 10:04:32 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [v5 5/5] drm/amdgpu: fix invalid memory access in
 amdgpu_fence_driver_sw_fini()
To: Jiang Liu <gerry@linux.alibaba.com>, alexander.deucher@amd.com,
 Xinhui.Pan@amd.com, airlied@gmail.com, simona@ffwll.ch,
 sunil.khatri@amd.com, lijo.lazar@amd.com, Hawking.Zhang@amd.com,
 mario.limonciello@amd.com, xiaogang.chen@amd.com, Kent.Russell@amd.com,
 shuox.liu@linux.alibaba.com, amd-gfx@lists.freedesktop.org
References: <cover.1737100293.git.gerry@linux.alibaba.com>
 <2e4357dd1daf3068b1b883be604a335cc2be8c3a.1737100293.git.gerry@linux.alibaba.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <2e4357dd1daf3068b1b883be604a335cc2be8c3a.1737100293.git.gerry@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR3P281CA0056.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:4b::6) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|BN5PR12MB9488:EE_
X-MS-Office365-Filtering-Correlation-Id: 54e977a2-fb59-4ce7-b6ef-08dd393177e5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|376014|921020|7053199007; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?eVFDaERUc2IyaldiUmdDNFJvVEFLNExHUFN1V2xTTkVlWlZjSVozZzJtbUFy?=
 =?utf-8?B?N29QVFgwZ050a3dHdDBWcjJSNkdYNTA5NG1mRVZoYi8wK0I0aFBXME4xeDdJ?=
 =?utf-8?B?VE5KZzl6TU5oS2cxcGZ4T3lDUjUxcm12bEMvQ0ROUU5rSHV5VzhRWkphdlFP?=
 =?utf-8?B?YlVaSXJyS1NjbGh0a1JDUkZuK1RTVUlOMmdKUi9iajNhaCtHbDVTT0xvTjJj?=
 =?utf-8?B?Wk5QR25YeHFvejlhbGZEUUQ3ME41UjBxM2NvS1ZuVDJHbWFFNGZqdUxpMXJD?=
 =?utf-8?B?QXc3T3pGTjZDSHdGYnpOTXRNU3R4ZHVsVUhFY1gxbmhkekNUMFFDV25BTElk?=
 =?utf-8?B?L1ZJZEdUa3JIKzlXaXlCV1NWWVF5VlROS3B4VjBrMUZnVmJpL3RVMHJNYUlk?=
 =?utf-8?B?WlF4b0hkVkpqMDhReUhjNUxxQm9icktHblplbVFJMnQ3THREQi9URU4zSG9I?=
 =?utf-8?B?QUlQTjA4MlBIaktnMnEwbVdqRVZkSWZYL3ZVUVo1NGJ4SExwSmFhU0JUZ1J5?=
 =?utf-8?B?QWszZFFjTFZsMHlBbUxzNmJTZHorNkRVbElXeUpqV25JM0IvaVhPYWtEZTdR?=
 =?utf-8?B?MlJleUdqQzdKWWovbSt3VEp0emx5WTZlcVgwRXlHdUI1eC9oM3JZTlowTWtC?=
 =?utf-8?B?QTk1RnBsak11bXV6cFhLdm1xUTAxaHlnTERPMFlFMWRLTkFQb1VsZFNVTSsv?=
 =?utf-8?B?RTROYzRxdS9SWDRLYWN3MkF4eW9ncW80K1JmWkFmaksvWlg5dXZSd0YyU3FW?=
 =?utf-8?B?bGxoa3Nnd1BiT0xaeG9LbWZIYnkyNHBDaGxxVTFzSXMxcTZCNC9SN2ZFQnNt?=
 =?utf-8?B?NHdpZ0pNLy9odm4rRGc3NVlpSXhQMkhlRzNsK01iMGxpTG1lZTgwek1PYmQ0?=
 =?utf-8?B?MVBCRDViYnlXQy9lVDYvV0VyZjdOcUdhWmVLbXB6SGxPaDNQTllON2NvVmdT?=
 =?utf-8?B?dFk0cGF3RjJwUG9sLzFodFJ3N0w4YytQdk9NSHJHQXJPMFdIN2NJTDh6TXg4?=
 =?utf-8?B?YVBac1RScmVVTWJVMGJ5L3hCeXkyZmxtbktNelVodXJJbXhJbitFbnlxYU1l?=
 =?utf-8?B?VjlzdTlMOS9aZXI1YjZ1bEpNNmpBRmJzUzZubTN6MWRGekRZamMwZSsra1A1?=
 =?utf-8?B?OVBpa3VzK2FpbVJwQ1lhcW96djVJN2VNSkltS1JoQ215SXhjNlNndE01aFdM?=
 =?utf-8?B?UnprWDUyNGE5WjF3Nlp3clZwM000bzk5T29PNk0wdXlSUXczMWRZQXd4RlJh?=
 =?utf-8?B?d1ovNWxaaXQ4WHBPejdVMmRnS1ZyeWRFS0lhVFRMTU9PQUdJT2VlVjlSWWc3?=
 =?utf-8?B?NFFuQzhRYzRENXZaczJYYTN2LzVZdStham5TbDY3dWFmRG9Mb2NDMlZsYmFo?=
 =?utf-8?B?M2JUUE9tWlhkR0MvREtZYkpBVkRreWoyVWtsUG5jTDdoSU5XUDhJOWQrcjlS?=
 =?utf-8?B?QlhPSk1rWURvdU0yVktUenNXYnNvRGRqaHJBQm9teEcvT0hTVkhpOVliTlRs?=
 =?utf-8?B?bXpwZWVIaDBMWjhZMVdXdUN0bm1GMUgxaFJEbkJnc2FiZGo2bFppdElMcmpU?=
 =?utf-8?B?U1l1cnFJTVplVDFsd2pVUkhHd3VHOGM4M2RvQk5XYmJNRDhPTmFkWEhYSzBK?=
 =?utf-8?B?TVBSbXAwdWdUcklxOVV1dkpsenp1eGxCT3ZQWTZjQkxBUUVpa1RjNldGSEY5?=
 =?utf-8?B?bDB1dmJjc29hQVM0enJ0MEFQZkMvMUUwYzV6OXZ4ajFHSEdEZ2xVOFdPVklo?=
 =?utf-8?B?ekNxZS9NcHgzdE55Zkp5eHFIT1hZMkJvL2JkU29rR2l0UXZ4U3hxWXVmdkIr?=
 =?utf-8?B?cDNuVzV6VGd2Z3M0dXYyM1ZLYURJQmlsTVRCcjJCVnd4SlFlM05ZWmtXbG4z?=
 =?utf-8?B?K0ltWXBjYUo4aWlpK2U5S1lycjRkNXlDUm1mYXgwZEJEelkrSmtCcHQ5MmdV?=
 =?utf-8?Q?gyQowX8mqto=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(921020)(7053199007); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?OU1mdm9TWkNLYWxoTEYzaWJBeUFvYkxpY3Jqa0VPSmFYUVFlOG81MVBuS21w?=
 =?utf-8?B?TUIvbmkrWFFmdGdqSDRnY0YydXVmWXZ3amlUM0ttNVVKTUZBSHBiZVcybGV2?=
 =?utf-8?B?YXBxTGkreHNaSDI0bUtwUlBXVnVyWFM3UUphLzlPVGVKcy9ySVp1aDlSWnBZ?=
 =?utf-8?B?K1dpYzhFTlRVbjNtSUMxclhDTXdyWW5rVFN2ZnFyaVZVbmE5NjIxVWk0RGdX?=
 =?utf-8?B?ZEV3SlVHQTc2NWRjaUNienBxdTN2MjhhY1hzU1l5cXFwcHN6SHhveE1PNlBz?=
 =?utf-8?B?MjVqZ3lhdXBnYWxaZnBBT1E5SEtXM3RnU2dZdjZvODBkK1hkRm5IS0Y2SFZh?=
 =?utf-8?B?YUtnUSszRlVYNFYyN1laZ3VRcm96bDJ3UzdPMFQ2dU9WdmJCQUhrY252TzBk?=
 =?utf-8?B?ZThmZVJ3TVlvVzhyWThpc1hrbG0zZ2g0KzNFNUFRY29OcUtuZHhoenBqMmFI?=
 =?utf-8?B?ZXBibFVwNHdDM1ZBL29DVkpPRi92TWFCMlZiZlFwWmZUaW1MNmJMUEtKMGFN?=
 =?utf-8?B?ZmVtaUlvUlh0RXBzQ25tMXFOYXRQT0xaWmFNdjh3SUEwQmhadndCejlYL0Vp?=
 =?utf-8?B?U0VMY1ByOWowcGE1L3RyVXZ6bEZlZnVvZXlTcWFaN1ZwOG5OZTNlVEJkd2RZ?=
 =?utf-8?B?bk8yRW1CTXh2QWRnZUp2Zk1yVXlOdjBLdDBOTEovUEgyUnVKNkJPdG4zSUJn?=
 =?utf-8?B?RC9oandNM1phZWxvZzZvRUJMWTFmMUV0S0J0VkJac25NbkRqaGtCVW1KMkhr?=
 =?utf-8?B?aHFlMEF4cjJ4aTlqQWhUU1NPeGZFOTlCeFQ1SVRLNDIyU2czaFVrbVRzZTF2?=
 =?utf-8?B?bVVZL3JlbFgwTmJGZGJtOGZFakN1aFU0cXdjZm8vMGRJZlk3OXFPc0dVaVBF?=
 =?utf-8?B?SEU3cDVwM1JGT09wWkpDK1N0M2d5UVBKL01aZXZva052RGhNeld3SElXSGd2?=
 =?utf-8?B?TzBVZlZvMklZL2ZFWFA5TTNoRGI3NFYzVkVEdlUwS2VTVnMvV2VjRXZRZkln?=
 =?utf-8?B?M3QwZkhhWEFHY0k2N3JCNHFKREVXdjk4YUFid3pQUkJ0MHkwK0ZzQXFteHZ3?=
 =?utf-8?B?bkNIK1BUZGVCVzNTMUZucVhFM00rVmhMNEJLVkVKQ0hPTDhtRlNVZDA4K1A3?=
 =?utf-8?B?Tld1TnBKblNKdGlCdmVhMCtidENhUE5oM0NPT1htK0ROS2k4bytZeS9hcGty?=
 =?utf-8?B?czBhTjYzYkJiSTJQRGE4S2tkcWlZeWVYRTF6U1EwWU5XSFRzMXl5WGVDNTJ0?=
 =?utf-8?B?QVVFMG8wa0MrOUR5TmhEV01PZ0RRRFBxa1hic2hUMDZuNzJyK3JIUkZzV0M4?=
 =?utf-8?B?OVRJSEhQOXBRcHZuRDZlZlZLcEVIQnZCcGh2QmM5aGNoR1dXTFBoYzZPWk9q?=
 =?utf-8?B?RG1oM1RuK0VOaWR4ZDdlTS91L3RyQVl1aUFyZUNhMCsxa25ST25leTFDVk00?=
 =?utf-8?B?ZHhhcGZMS01TNENCeVVHcWxYL29CeFB5ZUdXK1pVTERjNG1qM015UFBiSWJ4?=
 =?utf-8?B?UVVrV09FakZDbzV4cHRYaTcvYTVBRlBNZHFDdVc1VGpwWTNIVS9RM0tjVXFF?=
 =?utf-8?B?WTNDZDZQdVpBNDZWeGFzUnhBOGZuRjJYcG5SVDJSaVVmR251Zy8ycHJ1Q1Bs?=
 =?utf-8?B?M3J3b3FORTk5b1BzczdhQ2d4anBEMkhGdWRvSEIwR1h4OHJkMWpTeTh4Mkxh?=
 =?utf-8?B?elBrZ0xieHB3K1hUM1B2NS9DNVlDcHRwMFlPbSt0NG8zZFB5VTh6dnlPZTA5?=
 =?utf-8?B?bFAwK1loMFJkRHhLYWRKY2VUbU8zV0VwejlKaWVNU3ZMUkJCMktnaE5rVmNp?=
 =?utf-8?B?ZTBRUW1DWWFDYXdDWnQwcm9xSjRwUFlIM2gwU0FIVmhUOUx1dTRIMUNBTlhv?=
 =?utf-8?B?d2hVejNhMUJwcmhOZjRDSlRJemRMV1Z5c05NOXVhUk9BaUN2dGhlSStucm8v?=
 =?utf-8?B?ODFzcVF2V0VJbStJUzZnR0ZTa1lKZHBoMk9nRVAzQlJUd2J2YWRPQVZkYm11?=
 =?utf-8?B?WjdHcG0rOFFkMDRTb2pGSTZiNXZmbDZrb2FJb1orRnB2TmNBT1prcVVidURY?=
 =?utf-8?B?UHN4NW8ydlFJTTIvQnhWRWlJUVQ3OEZuWGY2WWZabG5VQzlKSzZ0dDRHRHRP?=
 =?utf-8?Q?U+bAIBpdEYybPIaJd/P0EOBrm?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 54e977a2-fb59-4ce7-b6ef-08dd393177e5
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jan 2025 09:04:38.5481 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JfblxbNAcE6Zad4Y4nff6qfkrNFg7pEvpchBnpqLmOVqWEMYlMMC4ubZWOvqhxI+
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN5PR12MB9488
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

Am 17.01.25 um 08:55 schrieb Jiang Liu:
> Introduce amdgpu_device_fini_schedulers() to clean scheduler related
> resources, and avoid possible invalid memory access.
>
> Signed-off-by: Jiang Liu <gerry@linux.alibaba.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 35 +++++++++++++++++++---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c  |  9 ------
>   2 files changed, 31 insertions(+), 13 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> index ee695e70fb4f..dd94f87c1f7c 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> @@ -2821,6 +2821,26 @@ static int amdgpu_device_fw_loading(struct amdgpu_device *adev)
>   	return r;
>   }
>   
> +static void __amdgpu_device_fini_schedulers(struct amdgpu_device *adev,
> +					    int num_rings)
> +{
> +	int i;
> +
> +	for (i = 0; i < num_rings; ++i) {
> +		struct amdgpu_ring *ring = adev->rings[i];
> +
> +		if (!ring || ring->no_scheduler)
> +			continue;
> +
> +		drm_sched_fini(&ring->sched);
> +	}
> +}
> +
> +static void amdgpu_device_fini_schedulers(struct amdgpu_device *adev)
> +{
> +	__amdgpu_device_fini_schedulers(adev, AMDGPU_MAX_RINGS);
> +}
> +
>   static int amdgpu_device_init_schedulers(struct amdgpu_device *adev)
>   {
>   	long timeout;
> @@ -2857,27 +2877,32 @@ static int amdgpu_device_init_schedulers(struct amdgpu_device *adev)
>   		if (r) {
>   			DRM_ERROR("Failed to create scheduler on ring %s.\n",
>   				  ring->name);
> -			return r;
> +			goto out_err;
>   		}
>   		r = amdgpu_uvd_entity_init(adev, ring);
>   		if (r) {
>   			DRM_ERROR("Failed to create UVD scheduling entity on ring %s.\n",
>   				  ring->name);
> -			return r;
> +			goto out_sched_fini;
>   		}
>   		r = amdgpu_vce_entity_init(adev, ring);
>   		if (r) {
>   			DRM_ERROR("Failed to create VCE scheduling entity on ring %s.\n",
>   				  ring->name);
> -			return r;
> +			goto out_sched_fini;
>   		}
>   	}
>   
>   	amdgpu_xcp_update_partition_sched_list(adev);
>   
>   	return 0;
> -}
>   
> +out_sched_fini:
> +	drm_sched_fini(&adev->rings[i]->sched);
> +out_err:
> +	__amdgpu_device_fini_schedulers(adev, i);

I would just open code that as:

while (i--)
     if (adev->rings[i] && !adev->rings[i]->no_scheduler)
         drm_sched_fini(adev->rings[i]);

instead of delegating that to the __amdgpu_device_fini_schedulers() 
function.

That makes code maintenance easier should anything more need to be added 
to the amdgpu_device_fini_schedulers() function in the future.

Regards,
Christian.

> +	return r;
> +}
>   
>   /**
>    * amdgpu_device_ip_init - run init for hardware IPs
> @@ -3424,6 +3449,8 @@ static int amdgpu_device_ip_fini(struct amdgpu_device *adev)
>   
>   	amdgpu_amdkfd_device_fini_sw(adev);
>   
> +	amdgpu_device_fini_schedulers(adev);
> +
>   	for (i = adev->num_ip_blocks - 1; i >= 0; i--) {
>   		if (!adev->ip_blocks[i].status.sw)
>   			continue;
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c
> index 2f24a6aa13bf..c95895a7b888 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c
> @@ -650,15 +650,6 @@ void amdgpu_fence_driver_sw_fini(struct amdgpu_device *adev)
>   		if (!ring || !ring->fence_drv.initialized)
>   			continue;
>   
> -		/*
> -		 * Notice we check for sched.ops since there's some
> -		 * override on the meaning of sched.ready by amdgpu.
> -		 * The natural check would be sched.ready, which is
> -		 * set as drm_sched_init() finishes...
> -		 */
> -		if (ring->sched.ops)
> -			drm_sched_fini(&ring->sched);
> -
>   		for (j = 0; j <= ring->fence_drv.num_fences_mask; ++j)
>   			dma_fence_put(ring->fence_drv.fences[j]);
>   		kfree(ring->fence_drv.fences);

