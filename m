Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3AB95CCFA00
	for <amd-gfx@archiver.kernel.org>; Fri, 31 Oct 2025 08:40:33 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CBDD910EACD;
	Fri, 31 Oct 2025 08:40:32 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="v90VGgr3";
	dkim-atps=neutral
Received: from MW6PR02CU001.outbound.protection.outlook.com
 (mail-westus2azon11012050.outbound.protection.outlook.com [52.101.48.50])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6B77F10EAD2
 for <amd-gfx@lists.freedesktop.org>; Fri, 31 Oct 2025 08:40:31 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=C47uz0+5dTB45xHFBtbwmDhUXx8D7hlhyuiGa007jlQr5z+zM0CYH1CSEiQj7SIDxfdx523+cYuVmOvLaLjDzoujveeJ/Vr/EMlfYvYevA1M60pd33cv+vVyZHUZC+ozgVIbBa39tMftPjnS/MHemFAEBFiE+T0U5R9Q8DshsNpQsni1gdkS0+dMlHTstbt3jpS84oQTls6QtAAobYeb7axB4qAuXVpWL9Y82DbJ13AqA3tjvraFsAPp4R8ZYOreBL6W+9/YALioaSe5mg1iQeRwYSIOUjD2lTY7wo8cMnJlzvi+/ahZErAgwypUTQfx2vGEc5+ZFI/eGDajxU1XdA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kG0AC/1/kPOoFZWsk++J3tOXJ/whaE7CI9BfG0rFOpM=;
 b=u9NAjxI2moGZP/lP3uXkTGzFxBA/B6I8JG9k8BcVtnKHizJvBL+AV3CCb4ridphrtaA8krjZ1KrWDJ18ED3KheQ64QKyHSDTA6RIPtaXe3x3gLLGJjMNsnfVtVpsfFEm97pmd+rUurSGi/tRuwQAlFlP30ybBsfOJ1UcNTt46g8He287rf20VBalrCRj2OjdGab60lq2DN/i17lk5a2oGFBjW3MWCtvp05ImrEjFxbMRQt0mRSjtTvPFjMqtUAC17X2Iu+gRfchP7Y9YhLwPaApLD3/9rjyu1oIroxYM2yOK6t+sJ8zUMtw5S7p6ZlOLBIarKgB27JkAaL4zm55FZg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kG0AC/1/kPOoFZWsk++J3tOXJ/whaE7CI9BfG0rFOpM=;
 b=v90VGgr3u2cRGODCoJ+TdjbMGQwZUnnnpCWRu3igJDYkGA6DHCwzwdoCbrdm1UKmF2ncIY/odf09PH0MGoVNFB4pOHOovhsd0XBoNiHVDJGUwuXrQB6BIZ+nHrT+KxOuKpFyK1WtDynC8iwQiwx1NtgyH8rM9e+jjUhempil3s0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by PH0PR12MB7078.namprd12.prod.outlook.com (2603:10b6:510:21d::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9275.15; Fri, 31 Oct
 2025 08:40:29 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5%4]) with mapi id 15.20.9275.013; Fri, 31 Oct 2025
 08:40:29 +0000
Message-ID: <20b7418c-c091-4e4f-aa40-556dd68605ee@amd.com>
Date: Fri, 31 Oct 2025 09:40:24 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amdgpu: fix possible fence leaks from job structure
To: Alex Deucher <alexander.deucher@amd.com>, amd-gfx@lists.freedesktop.org
Cc: Jesse Zhang <Jesse.Zhang@amd.com>
References: <20251027220255.507105-1-alexander.deucher@amd.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20251027220255.507105-1-alexander.deucher@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0246.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:f5::15) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|PH0PR12MB7078:EE_
X-MS-Office365-Filtering-Correlation-Id: b9fd2454-749e-4093-fdc1-08de1859252c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?RXMyTUx3K2FZek12VzJwZkU3K0d1OEdvWmJpanNCTVE0bHpFbHdncm14ZXBl?=
 =?utf-8?B?T3grT2lxbTB1QU1sOC9SMHNsT3dQWG9wU1hxK29PK1dXbXZtYVFlTWFhcFVq?=
 =?utf-8?B?Z01CbVdNNXdBOGVPdlpyeVBsV0ZDTDNYRC82ZVhKT3hza2hUalU0L2k5NXl1?=
 =?utf-8?B?Um5ERTliL2FwNGtnTmhNeWVudGxoWmt1NzRxRC9ZWFRPQ0FWTE5vMnJZQ1FN?=
 =?utf-8?B?OUVMOE12UGI4Qk1pd01SSWdlWk5tSjgzUm1oTi93SDJMR2lINU03V2NHWnM0?=
 =?utf-8?B?ZEI0akt1NnhMazdqL2tFM29FaHpNRHpWK3lLYWFRZGIvUlNmcmtDV2g0SlF5?=
 =?utf-8?B?Ky9aa3JUNFU5YmM0Z2Zja3IzWkUzSnVpYytDWDR5ei9sMHljeWdoOC9NWWxF?=
 =?utf-8?B?cFlsSmdYRWpKb014eFpkY1NHdktDYXhZVFRKYWFwOHpGdEk3Q2htOEw4WFhw?=
 =?utf-8?B?ZHNlV1ZOMkc5K3JtNDZaNUhpdGpaQ2xBMHoybWhyUG1Za1laTGRGa2JQR2Z5?=
 =?utf-8?B?RStHN1N1REhVZytGTVBseGZGQjdITGY0VHNndWVxdC9DUmpMVGNKVTB1V1hO?=
 =?utf-8?B?SEl2d011eUJGKy9QbXgvaGlqZkVwZWRZYU5LdXAzOFU2ZHNHUG85MGw2ZSty?=
 =?utf-8?B?dEF5VkdHSUZQZlVNZ0tyZ3I3em1wcXdqVTluYmhNbkh0N1FPMVJWU1gvakJB?=
 =?utf-8?B?akJRYkMyZElKaHRodEZiRHRnMkpmTjRDSlZZT09wRUtYelh3LzhlckNjM3VD?=
 =?utf-8?B?Nzk3Z2FsbjV1amlkMnV4UlpJRnlRL1NGbkl3MERHeDVJcm5IQUhlM2pwU3hk?=
 =?utf-8?B?YnVqT0tmMVI4T01JbVhMTnZqM0VhcEc1VVFvVXN4dENkNUVudFQxTCt3WFQx?=
 =?utf-8?B?bmhZdXdsWFRKMWJqcndyRE52eGE3RmRlWFE1d213WE5JUU0rVlNIWWMvWjNB?=
 =?utf-8?B?YSthZ3Z0TkZ6VTAwZTFpY1FnNHJmRFIvWjR4V05rWWJBUzJvS1VnNWgycTNN?=
 =?utf-8?B?cTNGYTNqUXlma3VyNDl1NTdHYngzc2lNWkx4M2hFT0RkTlZVc3l2NDBqU3l1?=
 =?utf-8?B?WkRKT3RnckxyVTNJdzhNanY1N1B3VE01OS9ZUWRqTDBYYUp6MWMvVnN6UXlw?=
 =?utf-8?B?N2p2TXFDaEZXT1RwL0wwQklxZ21laC8rL20wSy8wWTNqNmRqOUExT0p0KzF4?=
 =?utf-8?B?NERIMFJvK29SR2dsMEtXME9iUS90NDJJeTd5Rk9qVWJJcWg3d2lVbXNOU204?=
 =?utf-8?B?OFFEVFdVODlPVUNUR0NMd2FmSzNyRk93Ry9RaDd0N3B2eVY1MExLMjJZTlVP?=
 =?utf-8?B?cHdyWVhiVVY4ZCsxdWtDcEdpcUsyOGIrU0dhMXpDcURYd1lJRzFSYklqWTBp?=
 =?utf-8?B?eFRZWUMvcEgzRFVNWENoK09qMnRVQU50d3BOQ2xVUUFRMFRsQXRJcGh5WU9r?=
 =?utf-8?B?MzNQZ3ZFTzJaU3lpeTRueXJESnU0MklQc3ROSFBramtrZTRTUWhYKzdWWSti?=
 =?utf-8?B?S2grR243ZGZSNDA0MXJrSE5OSEdUV0hvQ003MVQxK1VwQTBPem9OdmVRclBK?=
 =?utf-8?B?cWNXL1VnUVpUeGFmMmVoWlhHVE1UME55Wm5aV2dkazlGaU8wdk50VGpacUZE?=
 =?utf-8?B?aW9vTWZaemVMVkw0ZklYOUxzMERXdzVrTEdUd1c2RHMrdnVKcnhleUVpbCtO?=
 =?utf-8?B?aDM4NWhzRVU2bDRwT3R0TGNxeEEvbmdmK2NCMzlBMVU1TWx6ejJmTkI1ejI2?=
 =?utf-8?B?R3RnZm9iSWZjRE5iaUEybjdVcVR4N0FsbjcxaUJjVzduVlFVTUQ5RHdiQlVB?=
 =?utf-8?B?Ti9FdWxRcWNLVnpuZGRoNXJkcjB5dzAvYWwyQXZKWE5qYnMxUmtHdHVsU1BI?=
 =?utf-8?B?alRVSW94THMydjRGaVZSZmdyK3crcHhGY2RmQUJrUVhTWURFNnE5YjNJOVlM?=
 =?utf-8?Q?dNYlSQzMbTVCYa3VyGVttIP8W+RuuVoX?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?V0k3K2F0bkNrUUg1OWZzNEJFcDVXdFplMGpNSEJ1RUdLREx5bU96NDBUaVRw?=
 =?utf-8?B?blRoTjh6WCswZm1MeldvSlNhUU53b3NVcENtQWxhR0VCYXN2R29TbWllUlNm?=
 =?utf-8?B?b3FGclpxRGZrZHZRTkRlQzg3eDJnVFRucmhwUEt1RmtDS3NRTmw3U3RzeURF?=
 =?utf-8?B?Nkc0RVJnbExaZ1NDa3hCMzFocEpNQTVxRmNpa25FWkh2b1dVdkhUdnhrVDNy?=
 =?utf-8?B?REJZWkE3T1V0RWE2MHlCK0NqMDNHQ0xmNGZxVUV1ckVhNFp5R09yc0ljMHZS?=
 =?utf-8?B?U0xYdE8xQ2V5SXRTUUdrbm80S2M0MUVkcngzeGJQYTlyUjVyNDVBY0pOYmNk?=
 =?utf-8?B?ckZCV0lGRTF2RDNtWlY1WDV2eFNXVnFuRTU2NWpUQXYvMU1Qc0JTSU9vcFlG?=
 =?utf-8?B?MnoyNUIwVnRmL1dnUVhzRElxSnNwN1Z4d243UFBWTFZrL1hiazdxQkR4cmJs?=
 =?utf-8?B?NEVYRUpHNllNbHZDb0pBNkhHcmlVRlc1UVhWTURGcy9LenhZQXBwend5VmdR?=
 =?utf-8?B?NTBxKy9NMnBEUXhPVldkb21DQ24rYVJsSGtKZ3ZTYWc5SEswdFNad3N0Tlo4?=
 =?utf-8?B?V2k1OG5tbWhQbXJaWkZ1UDFDRC9JZ2haVTRzaXIxd0N0cTB4Y1ZkOUNDQlky?=
 =?utf-8?B?dWtoeFg0bGxTZjBNZ04vWThKZGNQNGJpYjh5aVRYUFFyRnJtc3FlZGM3SzUx?=
 =?utf-8?B?YVczc01heEU2d2U4UmpzbUxJSTh0dmpwSDhpcFUvYXFJdW9ablBFRGpMUzMw?=
 =?utf-8?B?NnZ4N2VYY25ZWDZjTnVwczl6a3hWeVFES3N0M2o2b2I4eld5Mks4MGZBSXBT?=
 =?utf-8?B?RDgyc1U0TElyVDVkWTJBVzZUTGltVjFKQStaMFNOaVY0VjJDSXBLQ3UvK2Er?=
 =?utf-8?B?clFEb1pEMDk4UEVicWNPNy94QVdqeitRVWo3TU1GbmxtQWJtaDhWUDVJYnlK?=
 =?utf-8?B?ZTk5L1diWXdTRTk4OUdJUTl5eTJoSzJmYmx5Rlk5eDAzUUdocnZEcUc5RWlD?=
 =?utf-8?B?WGVRQytOZXIyTm8wUnpqQWEveTAydVExdDdxM21uVk9ERkNTTTVLcDVNQkxB?=
 =?utf-8?B?YU5rUXF4U3Q0cXE0QVhUdDQ4TGM2dW1XTVlzd09ncUNnYllFd0hud0o1U3g0?=
 =?utf-8?B?ZHh6QUQrb2taa3d6azB2Wm1aaThlMFhPa1hRTDM3ZVVBSnJJd3BpcHhVS0kx?=
 =?utf-8?B?eHVDakxBVXhvc2JLTDRsV1UrUXFua2w5MTRkTncvL2xoQkwraG01YytzbTA5?=
 =?utf-8?B?TnhUYkZGdzdzUDNCK1RITHFiSWEzbnNmT2FKUWliWkRoNVVOSUdmM2puV3g5?=
 =?utf-8?B?clNIa01wd0NGUkJ5QWM5K2dIRGgxN0ZPVUljN3ZRd1llWm9IUTN3TE16VDN1?=
 =?utf-8?B?TlVOUjdsbUtKbi8yV1FWeVlvQWtjQjdnTk9oYkZMT2pGbjdSeHZha1dSeHBI?=
 =?utf-8?B?TmpTMDhLNUVBUEVsdjYva0t0Z0pUakY3cmExUmJ2MHo1ZGhSbjBWK2ZXaC9m?=
 =?utf-8?B?dFUvUEkvc0dKakkyaVNRa1lJWFlONE5XUkVBTDRDcUthd1gwK1UwQjJEMlNJ?=
 =?utf-8?B?dmMxZWpOWGljRVFZU3RlZkgzTy9wMDY4MFM2MDZJaW5CRURxdmF6bVVBL014?=
 =?utf-8?B?QitJUGtHYVlDdVlZb05acURTeGRqVVI1YVNic1ZEdUlyZXBaajBlUXFVQTZZ?=
 =?utf-8?B?b0tTNUVrUjNoQW5kWXdkUXBIZ2xqbXI5U29PSzVFa1pCa0VFaWhhUGI5bG52?=
 =?utf-8?B?ZEJ4enA4ekY3a0xTbE0wZjBtVHNpMHVOdi9EQnAyNTJjby8zamdXR29GUkhh?=
 =?utf-8?B?NlBtVzh2Sk55V05HMVNOZ2ZXVE9jcjFZSk55ZnkzK0hzNzlqa0U5bkt4T0d2?=
 =?utf-8?B?b2VxM3JHdk0rT1I5UVYxTml3OGFyQUtpM0FwWVlySG5VQmFyaDVjZ2JzTi9D?=
 =?utf-8?B?UHhGSFlUVkRZOE5CMTJ5R29qWWU0UmRmNTUwK3V3SFMzQzhSQzRjRitGS0xK?=
 =?utf-8?B?TVkwemJIOXF5NmRGNHBVbmVBb1NZVEM5UUVvQWJkaWk4Q3AvN0pCYlVCME5E?=
 =?utf-8?B?bE9mNmhTc1l0YXVoN2huTHhFdWphN0ZLZHdxdTF5SE8yYnZ5cXlUZk1EZ0Nv?=
 =?utf-8?Q?7mb9ol22EbK4zFq3wWqEJRAeA?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b9fd2454-749e-4093-fdc1-08de1859252c
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Oct 2025 08:40:29.0227 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: eUoThiUv6EzOsjCKmPNRMjDHseemgNc8YuxjOTgFbr6yRQwyXfG+qqNTWXjAi/Kj
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB7078
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

On 10/27/25 23:02, Alex Deucher wrote:
> If we don't end up initializing the fences, free them when
> we free the job.
> 
> v2: take a reference to the fences if we emit them
> 
> Fixes: db36632ea51e ("drm/amdgpu: clean up and unify hw fence handling")
> Reviewed-by: Jesse Zhang <Jesse.Zhang@amd.com> (v1)
> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c  |  2 ++
>  drivers/gpu/drm/amd/amdgpu/amdgpu_job.c | 18 ++++++++++++++++++
>  drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c  |  2 ++
>  3 files changed, 22 insertions(+)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c
> index 39229ece83f83..0596114377600 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c
> @@ -302,6 +302,8 @@ int amdgpu_ib_schedule(struct amdgpu_ring *ring, unsigned int num_ibs,
>  		return r;
>  	}
>  	*f = &af->base;
> +	/* get a ref for the job */
> +	dma_fence_get(*f);

I think it would be better to set the fence inside the job to NULL as soon as it is consumed/initialized.

>  
>  	if (ring->funcs->insert_end)
>  		ring->funcs->insert_end(ring);
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c
> index 55c7e104d5ca0..dc970f5fe601b 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c
> @@ -295,6 +295,15 @@ static void amdgpu_job_free_cb(struct drm_sched_job *s_job)
>  
>  	amdgpu_sync_free(&job->explicit_sync);
>  
> +	if (job->hw_fence->base.ops)
> +		dma_fence_put(&job->hw_fence->base);
> +	else
> +		kfree(job->hw_fence);
> +	if (job->hw_vm_fence->base.ops)
> +		dma_fence_put(&job->hw_vm_fence->base);
> +	else
> +		kfree(job->hw_vm_fence);
> +

This way that here can just be a kfree(..).

Regards,
Christian.

>  	kfree(job);
>  }
>  
> @@ -324,6 +333,15 @@ void amdgpu_job_free(struct amdgpu_job *job)
>  	if (job->gang_submit != &job->base.s_fence->scheduled)
>  		dma_fence_put(job->gang_submit);
>  
> +	if (job->hw_fence->base.ops)
> +		dma_fence_put(&job->hw_fence->base);
> +	else
> +		kfree(job->hw_fence);
> +	if (job->hw_vm_fence->base.ops)
> +		dma_fence_put(&job->hw_vm_fence->base);
> +	else
> +		kfree(job->hw_vm_fence);
> +
>  	kfree(job);
>  }
>  
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> index db66b4232de02..f8c67840f446f 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> @@ -845,6 +845,8 @@ int amdgpu_vm_flush(struct amdgpu_ring *ring, struct amdgpu_job *job,
>  		if (r)
>  			return r;
>  		fence = &job->hw_vm_fence->base;
> +		/* get a ref for the job */
> +		dma_fence_get(fence);
>  	}
>  
>  	if (vm_flush_needed) {

