Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D2554C4345F
	for <amd-gfx@archiver.kernel.org>; Mon, 22 Apr 2024 09:29:27 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 54381112926;
	Mon, 22 Apr 2024 09:29:27 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="n41QHI9w";
	dkim-atps=neutral
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2058.outbound.protection.outlook.com [40.107.243.58])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B90F4112928
 for <amd-gfx@lists.freedesktop.org>; Mon, 22 Apr 2024 09:29:25 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Vygclsq7WWNY+65hJX2G4xO4EqNWVPdbSASttKBuOugi1XkxJ2sw5kOYCGucwp1IPQbn61e2fOFmm4GsZW34VWyMYcihdX0n0jrO+4W+tB4mVgKXhknRGTx29OH80FuJDBVbINvKs0L3FHlwUsR9/Yc2T0K/Q2qolTr6Wc/6Qh00TUjK0qb82Jy8hJQoP6EnKpq9MRoHUL5r/P+CERzSe1yCbc6Llgmrd7/Hi+dAW12ftOj9QWHY//AjL5zzKvqosbtbJtfIuDpu6vmSzzdrQ7f9tvmo4t3F7CkYLxAG9BhYWqtQdyAordlcjk5627LC5UmuTUZGBCu7AyjqUe9SXA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IfTk0FG0aA6BD33VbOdLtaIHMUlw4TjU+dOqv+/kk6s=;
 b=e9PppRMW3N6HxTAxCRO85RNVLUMuQ5eNUsXzybQBerm7ZRp4MoK+Ax7kcetW9nctlCt8hMsVg+c6xnGcp38qkl2W9uhUg1dmQs4zWxJWtwxFKk9UrfFIyzy/+QJBWvKKCwRqrmiCgDcG1zd+WTmapRCguNShbVPrwYutxQTDTBbl20lPwQxmlJOxpXGUSXyRGYKu6os+xgveorK6CFSua2mI1UfOtS9qv1j/x8ZVVB9jjM17LXC+wKWzaNhxjRrf1WcbkUhKtUDAj1M33o+94bHu37JtiHCvHiVv/ehBGZeRns9k7I56qAmTT+BgeVISfaQhyw8oqUymcRW0qLt3MQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IfTk0FG0aA6BD33VbOdLtaIHMUlw4TjU+dOqv+/kk6s=;
 b=n41QHI9wAjWBw1kmWqLjC50cdJD9bxw/NjSkgbo+4Kw6dELwZB91qwRTwEh8c6GVHGwHjebq3jCg8KZISPO9ClzfwArUyxahDAhrqS7ma5SiY58wsvabOMC6edTHvOjalhhnePff57c8Ra+HAIbafzjzoslNLL1Kcj0n4PnXqLw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by DS7PR12MB8230.namprd12.prod.outlook.com (2603:10b6:8:ed::5) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7472.44; Mon, 22 Apr 2024 09:29:23 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::f2b6:1034:76e8:f15a]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::f2b6:1034:76e8:f15a%6]) with mapi id 15.20.7472.044; Mon, 22 Apr 2024
 09:29:23 +0000
Message-ID: <cd234b95-5ab9-4c39-a815-503161d4bad2@amd.com>
Date: Mon, 22 Apr 2024 11:29:17 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amdgpu: fix use-after-free issue
To: Jack Xiao <Jack.Xiao@amd.com>, amd-gfx@lists.freedesktop.org,
 Alexander.Deucher@amd.com, Hawking.Zhang@amd.com, lijo.lazar@amd.com
References: <20240422084707.3803306-1-Jack.Xiao@amd.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20240422084707.3803306-1-Jack.Xiao@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR2P281CA0183.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:9f::19) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|DS7PR12MB8230:EE_
X-MS-Office365-Filtering-Correlation-Id: abaff746-ff14-4683-ebb4-08dc62aeb227
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?bEpqRVNqZ00rU1JDSmdKY3VnQUl4aEI5ZDBOdGFUaGZhY1RqWE5icWFScnFZ?=
 =?utf-8?B?K1YzMmI0eFIrL2V3RWtIQmxKRjVESEl0cWJ1UXJIYWwzSWV1ZlBlNStKOGJ5?=
 =?utf-8?B?eVZlSGw3dkt3b1pIZnlUUGIwVytuc3ZnclFudlRjY2pqaU1XUmxtTTBzODNW?=
 =?utf-8?B?N3FiVGdpcDZTYTd3TDd1TjFQanJ3RVVtT2RZNFUrL2FSeHVmMyt1U0xvZHpZ?=
 =?utf-8?B?dXpVYzQvazVBU0xRc3VtUFNXZEMwVFBzUmRhNitlYnAwdTZzT3YvQjVqUkJv?=
 =?utf-8?B?SUpGOGZPMm9qR2Z1eU12OGZlWHFqTlZpcHhmem40VXBLT1cwMlJLOE5BSUlF?=
 =?utf-8?B?Zm5PTnRHK0paNjBMd0YwR0VkdXJnMDl0eXFsYmEydWVhNDEvRTJZSFdpQjM0?=
 =?utf-8?B?anRKYldMRTlGQkFDdWVvcUJrcHBmMklWWlJ1bGgrNmFlY2lCNXVwQXdubm1N?=
 =?utf-8?B?dGZYMGhrSXhxaTF3cC9mMnM3NGhvMWtOM0xMbXIrZTIrbFh6R2xIUlIxb0Fx?=
 =?utf-8?B?T251OUh2Uk9aYWNCY0Uzc3VlQXJES3BWWGZpVHJON1BuWkYrOElsZ2dJaWpp?=
 =?utf-8?B?Z3FWb0Z1OG9OL05leTNRTXU1MWVLTzRvVHRtWUhIR1VsRW5TSGhNdjNjaDhv?=
 =?utf-8?B?aE5qYXZWSFJIKzFHcEVEVUZPeFdIWmt3WGl4WHRCMk8zQlBrQXMvTktmcERo?=
 =?utf-8?B?OTFpY3BmN2pJazd6STdWTWkycFlTeDV0VFhVUlh5YTlhMy9yTXIybTAyYzg4?=
 =?utf-8?B?aW9FYnpsUlltQ2NEWnNyMGV6ZlZsTWE0WjlxSTE1YnArZDZWWlVWNjJUQnBo?=
 =?utf-8?B?VFdLckJaNXdRS25pSE1SM21tSnhNL3VNMTl2c3dGQ1BQU2x0WC9lWE8xUFFD?=
 =?utf-8?B?eDdLcytENk10WTdDb1NoYzNwS3F5ODRrQmVNVVN3MjFOdkttc3ZpemdZM1Rm?=
 =?utf-8?B?MFhTbUsyNXp0dFc0aUVRMzBXWmRkZ0RzQXE3cTR4UWgxZmlKMFNvRFNhOHA0?=
 =?utf-8?B?VE4rT1ZFdWRxV2k1dWk3RGtSZUtlbU0vNnM1RGdlczU3ZEdQcGdPT05WNy90?=
 =?utf-8?B?UmVOWE8vR3ZRZFNYSmJudjdhaCs2VDJLdENEak9iNnFGeUdBN2ErYlpKa2dx?=
 =?utf-8?B?bVNKQzlwb3hhN0cxdnFCMm4wd1VFR2pNUFN1b0pydXl1NzlaMUE3YUNuV09m?=
 =?utf-8?B?eXlEd1RKTm52Zm1aUkZhMUdLZEV4Y0JlZ2pyeEt6S1BOeTRnZ1pabituTFhq?=
 =?utf-8?B?WWJpdzdWdkRqaHhKQ254UUFIZmdvZk4zNCtyUmsvTFdFN3Q2L3duRXNZVUpZ?=
 =?utf-8?B?WERMbTJXOWRnbUJsVzdHbUVRbC9uT3lmVlVGaWRzQ043M25JMEVBbldITjRN?=
 =?utf-8?B?YVpoUnlGZGZJUGxEdWR3Nm42Mit2WkxtdzNtYlRuUk5wNS80TjhZc2pVSG5I?=
 =?utf-8?B?SjQwTXlZSU9za1ZtZDIxVWxnazYwaW1xWDBndlE4RC9hMU1TeStPdW0rWmUw?=
 =?utf-8?B?NXpoYVNBVFh0MXlyKzRoRHJ1NUszdGhkQVk5VmtRU09yWklQajhzN3MvZXcz?=
 =?utf-8?B?UjlYK3VvaTVTWlh1UDJSQkZPcm9FTllzbWp5MDFiNmw3em9CVll4T0VCcEVv?=
 =?utf-8?B?VkZjYTFydU5LcS80L1ZQK1FTZVphN3NzbE5tWXF3MmRTUkVacG5SWHovT3Vu?=
 =?utf-8?B?dUdqNHZ4WHl0SE5FK1Eva0tVQUViSFZ2SXBla2FsZ1hiT0NUcXJRb0NnPT0=?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(366007)(1800799015)(376005); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MUc0VzRIRjRNczhoU3hpSWM4R0FwQXlPd2xacTA0Y1pkMVE0WjNaMVhlaS9q?=
 =?utf-8?B?dWdxbURsOVFBQUc4RVRHdlFPazE0Z0Z2bUF5eUFiZ01uNFFJM1hpMzVUZFFp?=
 =?utf-8?B?UGR0Qm1oQUNOMTJKVzZsQTJQMFVVeDkzbVFYM25zR2lCUFQ1L09XeldxY1k5?=
 =?utf-8?B?ellaSDk0RDNvSVFTM2lJdnltNFRnbEdZaFJhdTRQcldzek12SFZvSWxjeEtM?=
 =?utf-8?B?TEoyVlJ2cHR2S0RnY1JjRzRacHlaMks5c2Jlay9QQk5WZEozWDVmQUFYRW10?=
 =?utf-8?B?dnVzdTVUeExpRk5OM08yeG0zS3MybUQyM29sMXlIbytTTlMwbzM5ODFrSFpx?=
 =?utf-8?B?aUdFMXJUbnU1QUxaL1VXOC9lN3M3d1NiNmxsV3VsZHFWQVFXTXFHLzBzcWti?=
 =?utf-8?B?K1U5RjQ3NFJtTkZvdUNvZ2lQY1FYcjhndGt6cnJ5QXBSMUM3VW5OYm1ML1FP?=
 =?utf-8?B?Q2hmeU1WT3ZxU3lodFJnbjFsZjFDcGphNHVyNy95Z21VWHdVUjhJV2lFNURp?=
 =?utf-8?B?eGJaUGJzMlkvNUZQTytxQWcvSEZaQlNYUzNhOTgyNGZKQ052bHU4SGNPNjI4?=
 =?utf-8?B?MStoci85d0VDNWhtT3Fib2tkb3FzWEFRM2M5S0h0eEo4K0FXdDRJVnlreE9w?=
 =?utf-8?B?eDBFWDZ0d0U4Sm1ORHd2c1o4MjhUTkZDek0wY1NxRUU4Z2hTMFFhR2I3YzZp?=
 =?utf-8?B?Q2NsK0VSQ2pVY2JvMGVVRnZFTDk5VmtlQ29ETUVPQ0pvWGRHbFQvdnJ6cWM2?=
 =?utf-8?B?L2VvdkxOcVcxRHVOcFRSdmhlNzVyd2dtSHVtM284VmxYc2V1b3dPV1lsbUh2?=
 =?utf-8?B?cUp3b2pZRzRabWtLa1EwajArNzFLOW5nT0tRY1UvQUdiUnIveGEvQWdHVTJw?=
 =?utf-8?B?VWJtTnNPWmNYcU1Cbi9BMzZKVEtUTy90TTdNOGVJRzlhRDlkVHFXRGpWQm03?=
 =?utf-8?B?WGVhaTRWeU1rQjU3ZDNpSmpqQ1FGWGdicm1wSnVWaHdzZEorZnN0SGNXanFG?=
 =?utf-8?B?TGMyU0NnYmZrZ2tNVmgvcDIzS29OZkl0aG80ZElNQ2VuZ25UWExZNW1OUG1R?=
 =?utf-8?B?dHFCZ2NrR1grM1dOdVRCZG9nWFVDYXlIZnJoYWpXNzVzNGR3V28yKzVWVGwr?=
 =?utf-8?B?SWJmbExGejUwNUlWbThMM05Yd2hxenRLeXZrQWJmekJCUUVvSzdqejYxTGpq?=
 =?utf-8?B?ejdvT3NBQ3VYVUFGUHZHcWJ2Y3piVk0xbWgrN0tUWnhLaU8yN2JuRmlaWGo1?=
 =?utf-8?B?YmppeTNuVFpCZEZBQXFJRk9HR2hBYmpVWlNaNGsxQTFLcllzWnBYaDV0QmN2?=
 =?utf-8?B?RUFXQU1MWDVVakQxZTFwQUMvbVAyNnN0eHc1ZG5QVVQzWktYYnkvTG9yRElF?=
 =?utf-8?B?Nk15Tzk0cHNyeUxOaXV2UUNDVHNIVm5wL0RQdmtnQ1NvV1RFLy9aVzk5SXIx?=
 =?utf-8?B?RUk0Q1hZQTZsUGxDVngxNGtIQWpCbjZFVzZxRm5pT3hVRGg3NzU2KzFLakdm?=
 =?utf-8?B?OXNubTk2Y0w3ZnQ4ZHUzUFFmcFBkUWJtcVh1S1hGMFV0TkM2Ris4UEtSOEs4?=
 =?utf-8?B?MzIwTG9Wb3VxMWhCMHhVUWt4TVJBZkpOY01TbnlCRStFRm1pZnVMWC92SEtl?=
 =?utf-8?B?OW1DazlmaTJ2MHNiVVh6T2V2NUtzbGc1czc4dzNyRlQxYTRueE1oT3JjNFYw?=
 =?utf-8?B?dzg5NEJpSkZTZDVTU1RHRW5JKzRaMEZYMS9DQXRRVXN5Z0RyK1ZmYU5INGpZ?=
 =?utf-8?B?K3FSbzUxbDVvSEtqaXNidXhLTkN1TUYrQjl4ZzlaRVdSK2JMcGhicWp5enhS?=
 =?utf-8?B?UXdaNUttTW9Ld1ZUMnlxOTExd214Z2lkWFBpR0tGdWRFRnZuVlUra0VKOGxj?=
 =?utf-8?B?S1VOR1AxcHphOVNVdmdkZk9pTXUvN05McytKckluQkR3NEZFL1RpOTdZNE1E?=
 =?utf-8?B?MkNkQ201OWtZb2ttcHlnSHdESHp2THN2aVVaVHV4UXI2dUxoVVVJdWc0T0gr?=
 =?utf-8?B?dU5WRk9DdXV1cDF2dWtXMEN5VDV0TTNrZDBCRjFZaGxKWU9ncGZXSVpxK1Ri?=
 =?utf-8?B?TlZoNEtSeGQ4RklkcFNNdTNUZlVxUzcvT1VXb0ZoV3FLSVBqWUNkZ0VCa2Rm?=
 =?utf-8?Q?AIho=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: abaff746-ff14-4683-ebb4-08dc62aeb227
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Apr 2024 09:29:23.4494 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: k66c+i0u7Uoz3bvrhseJPJXEVzsjy8I7gWhXaKDoTIZaa0d7cokx59lR1ZYB1jJW
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB8230
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

Am 22.04.24 um 10:47 schrieb Jack Xiao:
> Delete fence fallback timer to fix the ramdom
> use-after-free issue.

That's already done in amdgpu_fence_driver_hw_fini() and absolutely 
shouldn't be in amdgpu_ring_fini().

And the kfree(ring->fence_drv.fences); shouldn't be there either since 
that is done in amdgpu_fence_driver_sw_fini().

Regards,
Christian.

>
> Signed-off-by: Jack Xiao <Jack.Xiao@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c | 1 +
>   1 file changed, 1 insertion(+)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c
> index 06f0a6534a94..93ab9faa2d72 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c
> @@ -390,6 +390,7 @@ void amdgpu_ring_fini(struct amdgpu_ring *ring)
>   				      &ring->gpu_addr,
>   				      (void **)&ring->ring);
>   	} else {
> +		del_timer_sync(&ring->fence_drv.fallback_timer);
>   		kfree(ring->fence_drv.fences);
>   	}
>   

