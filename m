Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4B9FDC4345F
	for <amd-gfx@archiver.kernel.org>; Mon, 22 Apr 2024 14:56:45 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C8C4F112BAC;
	Mon, 22 Apr 2024 14:56:44 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="qrw3k5ut";
	dkim-atps=neutral
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2078.outbound.protection.outlook.com [40.107.237.78])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 68AB6112BAC
 for <amd-gfx@lists.freedesktop.org>; Mon, 22 Apr 2024 14:56:43 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EHDM9J9QwVh3wiO/qSnQ2ZxhotKIX8fzI6Hocuz2mnIhlem8GQkulx0CG7sx4ikHKY0kgTbyMqdAzbvQYY4LjmRRVydxkAjLq2HFsQW2BqvLdMIjKu6RaJTsmuXcibKTJdu40pc8cugtl/WSnbr/ImST8wxNpEHa8DPPdAKHG1aWJtjUV7GPuY/oCrB7OWzwv4R0yEzG2vPcLrIG+EQYYkc+FA4b/TFTSj8ga4UpzKKJq06CyGvWuBJrxlKm9ccuASWUvhHrleidnfbke2saKd0Ygyb4NgA3qAXlmWFvYp2ztDcaXdg06sirC3JRObNvZHcy3kYapNxIjkMGKB5bkQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=i0dtRt6+KLHI3eiSmOqJXdYOFga75JFV2FMeOlnVz1E=;
 b=RQaP1TsgvZzBETHKuEjuGDA3Zw0RdT3HNuAqPI4pQWm7qc9nLLW6TgFqpuZyU8r/6hUDJHff2Jdkhb7NeIC6hVT2DMbflSt9avU3C7J9pFI8lbI/LvRlKykFsCoP5CwBZreAI444RdUalP8QjqwuQU8Rvq9fAvy+w7tngafTcIf3Uu7wBjZhv+AAGU4FEhidlXYniHFIM+a7nd7P/HvZPkqivi6iiaZfiHiK3b7LTt6RP+aSikmNFpn20kVd47gk3BQdi74fdpKDDuhZY/t0bSNdhMeaC4Ckdt4W9Lkipl9RsKDbTHaiJM9oQY2mSAHjjk13Qi0GhP+GBSq9sAdBBA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=i0dtRt6+KLHI3eiSmOqJXdYOFga75JFV2FMeOlnVz1E=;
 b=qrw3k5utChdDkCCnyHuBwsUEHjIrhxcrNk1i+52K3as9wwWeWqzV4JsFCsqzb/qlr+oMqArjR456qCvEQ9Tr4YOIeeEsPlYPVLtRzAtcmXabKYe6ZPf/AKcAITgwDGFvSpr1w5QDcPi2+NNROU4CPdwzenroA1qmTMcLH/dxars=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by IA0PR12MB7675.namprd12.prod.outlook.com (2603:10b6:208:433::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.44; Mon, 22 Apr
 2024 14:56:38 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::f2b6:1034:76e8:f15a]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::f2b6:1034:76e8:f15a%6]) with mapi id 15.20.7472.044; Mon, 22 Apr 2024
 14:56:37 +0000
Message-ID: <c8e4a839-7f39-4cd9-a519-ce3c164464b5@amd.com>
Date: Mon, 22 Apr 2024 16:56:32 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 6/7] drm/amdgpu: Skip dma map resource for null RDMA
 device
To: Philip Yang <Philip.Yang@amd.com>, amd-gfx@lists.freedesktop.org
Cc: Felix.Kuehling@amd.com, Arunpravin.PaneerSelvam@amd.com
References: <20240422135725.11898-1-Philip.Yang@amd.com>
 <20240422135725.11898-7-Philip.Yang@amd.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20240422135725.11898-7-Philip.Yang@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR0P281CA0081.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:1e::7) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|IA0PR12MB7675:EE_
X-MS-Office365-Filtering-Correlation-Id: 276f160f-ab05-4025-4691-08dc62dc6934
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?N3YzbkhSOHZ5TTV6cno4SUdEMmVCejZZTEoyS3EyWS9mSi9oMitzT1NKbks1?=
 =?utf-8?B?cDRWOTNETS9odWZKTGNIY1k5NUJQbmJ1Zit3Vnd4a3hONnJFTktmZkZqb3hF?=
 =?utf-8?B?SFR4djBNRTEzVUxubzI4emY1UXpUdm5pRW1vUjlia1c5d3JhN1U0Mk9Rbmhn?=
 =?utf-8?B?RnduOWhlMTJCUG5heWdrSSsxc3g1YUJPckRYaWtSaHhaZW5HUjV5UXBMTmhS?=
 =?utf-8?B?dWo4ZDduZzZyNG1YeWhseWdTNmxocUtXV3FIVmtvMy81bjlxTHc0SEdQQ0g1?=
 =?utf-8?B?ZW5nckVGbk1nWVR2Ym9ucGNjam50VHFsRW1mMHcra3hGRFdwcm92UXNtMUpq?=
 =?utf-8?B?RGI3bWZLWmtHSVBXUXFoVXlSQVpXMVdINW5HTWF4UmVDUVNnaTY1dVAvRjZ0?=
 =?utf-8?B?aWZQZnQyYVBGRnVCbklvV3d4V2ZuUWxrMkxybnJVSkZsOVJyZzBUYXowcVUx?=
 =?utf-8?B?MENUQ0RFd1FLV3lHRkJ3dXMveFRxVVRtSTVEYjNBeFF2RS9HR01VcGk4ZFhP?=
 =?utf-8?B?S3B6TGhwVkc4Tk4zRU1JY3FWWU1xeXgwNHdoanMyR1FlUjM0c2wwcDNaMmxi?=
 =?utf-8?B?NFRmSzBhdDBtSHhobXJIS0d6c2FLbGJxSG4yV1htK2VnbCtibld4VTJRcFpX?=
 =?utf-8?B?c29mM1FPOG1XU2NtVDVwZzFSdmJOa0ZuVERaaGtkaU80MmtOVDdjUHp4MVdY?=
 =?utf-8?B?RHVTNWZWMC8ya1ZQQi9haUg4TzUyY1pwT0c4cHlVdHNRMTZjbjRkK25KZExV?=
 =?utf-8?B?ZXcyS2FSN2RqSnZXUVRLSXQwd3U1eUt6eGFrcUNrTnF6V1kxSWNKTUdFVWpM?=
 =?utf-8?B?NGFsVUZ1Y3ltQnZsQWdkeEpuUmR6WVcxaGtFL0RrY0dmT1JFQUJ5QWtJaUxY?=
 =?utf-8?B?MmY5QVQzSkFoREVTSEF3K2M5UVh4YzhsbzVsMEtjUEI0UnEzMFdIcmxDRTEz?=
 =?utf-8?B?aUwyQjYwU1A1TkF0bXlNd0M2Vi9GYWhFditQRFdjeTVCNHptbjhDZTdmSk0v?=
 =?utf-8?B?bjRCRVNmV0luamEvQ3piNWw1NEVYMWN2enh2WXNoeHJ3OU9HM1BndkF1RC92?=
 =?utf-8?B?aVBnQVB3TGltMlVEOU1xb3d4TlNGa0huUCs3dGk0aEllYmRHMDBabkJydTA1?=
 =?utf-8?B?VVU0Ym5KS1pFS3BObkNsQlRsMXlOSWtmN2l4NExOS3NraFY0R2M0elNqTCtY?=
 =?utf-8?B?MnZ4RVRycmJpcEtjbXZSQk9tbGxNbkNSbllqMGVPUWZmbUNwMUJoOUNQZ1JD?=
 =?utf-8?B?MG10MndpWEVYcFk1RXB0SzFraDR0aCtVYWRUNWlxSitoMWJPY21CREl6TXhZ?=
 =?utf-8?B?aHFxMlNaeXdvV3p3dnJxWnZ0Q3NHdGZtbmYrQ3p5cWJCWXRoVTZkOHFqWExZ?=
 =?utf-8?B?TTVFb3BTYXRTU0lKQzBadm1XdmUrdHVqanJEdGtZT1JMRjNENDZDdit1SDdp?=
 =?utf-8?B?c1Mxa2JsSjhWSHBWNXJBdEduRTJpUGJ3bmFCM1R4MG9hWlNPK2pMdTZWamlz?=
 =?utf-8?B?eDNSTG85c2tNSmZtcGIweTBuOTFyYzVGZ3B1VzRKQTdCRytCY1hMdmVpSWRP?=
 =?utf-8?B?emYzemM3eGV4dTV5U2pHRjhCcUdqQzR2UHJUNFdYR2hVbHc0clkvMCtJbjM2?=
 =?utf-8?B?Mzk1SitvQ21tbTYzT25wUkFGZnZ6a28wWm9VZGlzV1h0eFNRbkF1c0FyakNI?=
 =?utf-8?B?UWdOMkZSZ1hHMXNXSEpjTnVncEg2RkVaRy81OWR4bGovT0JtbmlWVGRRPT0=?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(366007)(376005)(1800799015); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Y2c1dHNVS3Y0dkF0MXNhNXBQQjJmLzFPTVJwMTduU1cxRVhPZHFHN21TMXhB?=
 =?utf-8?B?TTYwclhuNy9QRklWclRJM0l5cGxzNEEwaE9VSTBDVWgwblMrNm1jRHJhVWpQ?=
 =?utf-8?B?OWpQR3BxczFWUWNNeWJtS0hOM3JtSEsxUFBaRzg5VmtkUnZwRXNKcWxTR0tX?=
 =?utf-8?B?MTlUK01NaGd4VnMvOGlKZlZHMzIwWlAxN0J1MTBLREd3VWkwMjliSzJHNzBR?=
 =?utf-8?B?c2JwZVRtL2JKRkQxemQ5TFVlblBRTjcvNkhHUHJ4SXpoNmRmTnorbEoxTGFI?=
 =?utf-8?B?L0s2NERabS8zYlBVTzB4eEFSVWVsK2NjSmhMVllEYXIyaWRqd1FFelAzSGI0?=
 =?utf-8?B?aUd4WU5BclZTM0ozK0I3WlFIMGFCT2RWc2VuN25SY3c3aUxVaDdCbzY2OGhm?=
 =?utf-8?B?UFcwa21HYmoraytLWXBKU0poSmtKb05ySjRzMjFad2tDT3V3Y0VucjB5QU40?=
 =?utf-8?B?KzhiTXkxUVJQODRtalBhVVNrc0RYRFhzdnA0NzVBcEVMTEsyTi9NdHBYVWlh?=
 =?utf-8?B?UW5scTBBWDJ5MDBDZDRFYUM4M2lpckRCbWpBN1ZLZHNEbnZOMmFFb2ZIOFNh?=
 =?utf-8?B?c0MramczanBZbjg2c3dJL1FkWnc5WjhpZTk1Y2M0VVpJT1RRVTVLV29YVVl5?=
 =?utf-8?B?eVcwcUhNck42Mjh3WE5mK2dxRGw3WUxTaElxaE96OXliOFpXbjRvY0VLQkFF?=
 =?utf-8?B?Qm1FSDl0SVdScExuRTBGT25OMURnQWtLZUdaaWpOT21JTkk5SG84dC9UcE1D?=
 =?utf-8?B?MWxGOE9GR2ZpQVlhQzRsR0d2eTdPNUE3MVp5ZHFLMWJWR1RMcTQ2bGhhT3Jx?=
 =?utf-8?B?Y29UT2U2SVg3dGkvaksvb2tjVDBFNXA0czdjNkJSaGhqZEl0am9DSHhPNXk5?=
 =?utf-8?B?OGNteWtBUFdJaVJWNE14QkdRMjlFMFNUUDYzTkorOFpJWHRsK0svUVk0MHlH?=
 =?utf-8?B?UVlIUzZJeWxPcHg3V1QrMUxIZ29wNE5lRE16OUwwdVFIZTVNSDVFMVZSUEpO?=
 =?utf-8?B?R0E2K2Q2RUF0cjk1bjdOQW5FOVN4V3BvV01QcW9OTEJldUhUQnkwSmdrVjUw?=
 =?utf-8?B?aTJQYjRLMFJoMlhwcjZWcXhCUjNNaEVTTUI2SkpyQjM5ZzRhak9xdkhlSVl6?=
 =?utf-8?B?aHdWQjZLR09iZmZMeTVFTTErSlJrSTdreStPbXZUR0xMSlI2RFBkbCtTbENz?=
 =?utf-8?B?c1NaZG5NYnJYTWhHQjVsWE1WN0FxK09acG5HdzBENktUTEpLc0xLNzJ4aS9t?=
 =?utf-8?B?a0Q3Y1o0VGZwbXZldVZjSWRDeEd6SDE4a21pdHh0RGlleGszOWFMSVVpanY0?=
 =?utf-8?B?anhVR2dBQVp0VXBvaXUrQTIrZUpzcFlUd0MwbEx4Y0VRZVZoSHdPMW5CUTVv?=
 =?utf-8?B?U2NodlhDUlJ6WGdYK1IrZS93TExITWZUcE5kVVowOTlrdWNzOExJeGkxQ0RW?=
 =?utf-8?B?SUp0bWV1NE9ZK2ZlNEl4NWRuN2VscmRpY3RlK0V0OHRlZFk2OWdqREE2T0hG?=
 =?utf-8?B?MTZxS0lJTmdQdGN0VXB4bTFZL0VXQUYwakZqSTh1anRSRjNDTTRKVjJJeFRy?=
 =?utf-8?B?bVVKcFRaT2hIZWpLVnljK0ZEdnNIalBBZ0FaRmhtMUZRNUdrZE9weDVHYlp3?=
 =?utf-8?B?WnUzazlzUHo5T3dLSDFtK1JFT2pGUkoxSWdCSnNNRUllcFZQTDVwOVZxdEVQ?=
 =?utf-8?B?ZXdtZmt3Lzh5WHJBWVRLNytBT1g0ZUY3My9wNXZIRGNYTkdXRVgzenF2blEx?=
 =?utf-8?B?d3dZQ2FaREhSbjU4QXJVeUtZUkNKM3h1cm1XY2IwbE1JV3ZKbmNEeVcxRUEy?=
 =?utf-8?B?bWp5R0hPTUREbFMrUUxYc3JIOWJYeVJFd2FveEN4cG10bm1kazkydmtEUldo?=
 =?utf-8?B?RXlwZEM5OEJhRTBQaWl2bTAzZWRwVVV6S2g3YXkwMXhxSFlFMHlHZ1hld3hS?=
 =?utf-8?B?Ni9wLytROUF5SW9DUlI0K25DdG5yaTNQcnp1RlNhNHpubGdPVGM2MTJrNHJz?=
 =?utf-8?B?NUlBRi95MkZ3M3V4SlZMWHc3eWpQd0tnK0kwd3BUNGFCdDdCODE2NDlvekx0?=
 =?utf-8?B?ZkJHdWhVS0ROVjhsTXFJZUZHaWRIR3h2VmVWV2VNL2Vzb3Z6U1k3TmpjUDJK?=
 =?utf-8?Q?NASieBv+Z8+57i/XrtpfTAdZv?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 276f160f-ab05-4025-4691-08dc62dc6934
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Apr 2024 14:56:37.8207 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jQPF07wP3m5igJ87VDMaPamk3Q/+L/pvkq7hUwhGvVUXLE2diB53Z15xCtsDBNeg
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB7675
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

Am 22.04.24 um 15:57 schrieb Philip Yang:
> To test RDMA using dummy driver on the system without NIC/RDMA
> device, the get/put dma pages pass in null device pointer, skip the
> dma map/unmap resource and sg table to avoid null pointer access.

Well that is completely illegal and would break IOMMU.

Why does the RDMA driver does that in the first place?

Regards,
Christian.

>
> Signed-off-by: Philip Yang <Philip.Yang@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_vram_mgr.c | 33 +++++++++++---------
>   1 file changed, 19 insertions(+), 14 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vram_mgr.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vram_mgr.c
> index 9fe56a21ef88..0caf2c89ef1d 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vram_mgr.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vram_mgr.c
> @@ -705,12 +705,15 @@ int amdgpu_vram_mgr_alloc_sgt(struct amdgpu_device *adev,
>   		unsigned long size = min(cursor.size, MAX_SG_SEGMENT_SIZE);
>   		dma_addr_t addr;
>   
> -		addr = dma_map_resource(dev, phys, size, dir,
> -					DMA_ATTR_SKIP_CPU_SYNC);
> -		r = dma_mapping_error(dev, addr);
> -		if (r)
> -			goto error_unmap;
> -
> +		if (dev) {
> +			addr = dma_map_resource(dev, phys, size, dir,
> +						DMA_ATTR_SKIP_CPU_SYNC);
> +			r = dma_mapping_error(dev, addr);
> +			if (r)
> +				goto error_unmap;
> +		} else {
> +			addr = phys;
> +		}
>   		sg_set_page(sg, NULL, size, 0);
>   		sg_dma_address(sg) = addr;
>   		sg_dma_len(sg) = size;
> @@ -724,10 +727,10 @@ int amdgpu_vram_mgr_alloc_sgt(struct amdgpu_device *adev,
>   	for_each_sgtable_sg((*sgt), sg, i) {
>   		if (!sg->length)
>   			continue;
> -
> -		dma_unmap_resource(dev, sg->dma_address,
> -				   sg->length, dir,
> -				   DMA_ATTR_SKIP_CPU_SYNC);
> +		if (dev)
> +			dma_unmap_resource(dev, sg->dma_address,
> +					   sg->length, dir,
> +					   DMA_ATTR_SKIP_CPU_SYNC);
>   	}
>   	sg_free_table(*sgt);
>   
> @@ -752,10 +755,12 @@ void amdgpu_vram_mgr_free_sgt(struct device *dev,
>   	struct scatterlist *sg;
>   	int i;
>   
> -	for_each_sgtable_sg(sgt, sg, i)
> -		dma_unmap_resource(dev, sg->dma_address,
> -				   sg->length, dir,
> -				   DMA_ATTR_SKIP_CPU_SYNC);
> +	if (dev) {
> +		for_each_sgtable_sg(sgt, sg, i)
> +			dma_unmap_resource(dev, sg->dma_address,
> +					   sg->length, dir,
> +					   DMA_ATTR_SKIP_CPU_SYNC);
> +	}
>   	sg_free_table(sgt);
>   	kfree(sgt);
>   }

