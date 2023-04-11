Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E045BC7619A
	for <amd-gfx@archiver.kernel.org>; Tue, 11 Apr 2023 08:06:02 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4D5BC10E4D6;
	Tue, 11 Apr 2023 08:06:02 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2050.outbound.protection.outlook.com [40.107.237.50])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C198410E4D6
 for <amd-gfx@lists.freedesktop.org>; Tue, 11 Apr 2023 08:05:59 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mKaAqlifSAwK2LqiuV6vquqxsEff0p1qIHZV3QUsJkLjrnPWQpIo6UHMUUFEUelzY4ZJMiiMhvCwhqetR1SjRzv27BpdfDJbuhIBq2+Otqq1tCkWWlQVyexv5yaYeTobBx8j+tbZRZdvxV+dVESx1VpXsvy/hi/3OnDUqj1RhO739fXxL0zMLDiHLHSGcsDUgsglpqtXSkGcEj25RDSek1iHnRmWTK19UHUhZzoB6qhlUwtiasFuZBc1Zq7aa5PWVkqOjzkiFVR5bj5GArWs3hS3B0k6XtS3HH8c5tqdPnJzcyVwlna6wzNjxZvc62GfJugnXBs35tFFoIj476bwTw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vPA0bkns9XDaY52PEQfqQasi1QskFGHWOCPxxH0cKzI=;
 b=AgzA9aFaFzj03xC8Ez4tsPj6iEmdA8q2lK1bExzMbz4Qiz/nhk+xayyIBI3E9e1L/zJHQEejTrfx7avCOXRR1fJ5o5jNg2l+EPyJWwOXRygcyciwBQtegu/3qoSyOP2ZyNSb/87AeV2ab14lbs/cnCCDalGaQaXSKIlj5O6EjDH1lxDsq4ylLi0CBMVm0vGg1FRTT4t327PuU98sDSfQFBfRj/p2LkXd6TxXhSeaxDfAHHrhRec72f3I0Zaqf1Catesm6GwYxi0OLn6mJ3CQjD4EkI57/6Pd4j/G2P80W3agZ3zFMnF/y05uBGWLI0ecM/jqhxd7vvWwQJ2KytO7TQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vPA0bkns9XDaY52PEQfqQasi1QskFGHWOCPxxH0cKzI=;
 b=46q0Fa8oryv+pjtnafFriO1VHiny4bMxd3M6VnVFCEo9kV/d8UolEsTJL/ecEX6TEpl2qNSacqCmAJwZVJDirLGehFdVE7IGCXPKcNIHqUH5kedHvv4wHwmWNKeXldskHSH6Ao6jUu4hmg+D61Tx3u03I2LVPWn1MDuIdTaQBks=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN8PR12MB3587.namprd12.prod.outlook.com (2603:10b6:408:43::13)
 by DS7PR12MB8229.namprd12.prod.outlook.com (2603:10b6:8:ea::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6277.38; Tue, 11 Apr
 2023 08:05:55 +0000
Received: from BN8PR12MB3587.namprd12.prod.outlook.com
 ([fe80::4624:dc39:943e:6ae]) by BN8PR12MB3587.namprd12.prod.outlook.com
 ([fe80::4624:dc39:943e:6ae%5]) with mapi id 15.20.6277.036; Tue, 11 Apr 2023
 08:05:55 +0000
Message-ID: <a71557b1-312e-ad61-fee4-dcf2f7e97e68@amd.com>
Date: Tue, 11 Apr 2023 10:05:50 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH v2 2/3] drm/amdgpu: Simplify amdgpu_hw_ip_info.
Content-Language: en-US
To: Bas Nieuwenhuizen <bas@basnieuwenhuizen.nl>, amd-gfx@lists.freedesktop.org
References: <20230409185956.725016-1-bas@basnieuwenhuizen.nl>
 <20230409185956.725016-2-bas@basnieuwenhuizen.nl>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
In-Reply-To: <20230409185956.725016-2-bas@basnieuwenhuizen.nl>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR2P281CA0067.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:9a::7) To BN8PR12MB3587.namprd12.prod.outlook.com
 (2603:10b6:408:43::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8PR12MB3587:EE_|DS7PR12MB8229:EE_
X-MS-Office365-Filtering-Correlation-Id: f115fa07-38f6-4088-bb33-08db3a63933b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 1FxyNd91NTyDWZSZ1YVFSU3bgV47v6Zxt3vQHJzcIVgDpLxd4LORxKeYWLBQDUcjq8+b7xrNG3AwDBHo/Wm9xH27Y9+evHaqau+BP7q/Y3rdsvfxh/d1YWaB4qhg6TqUHweryT+/hmfKe5HOL2A/Plb8T2djnVj19Duw6k7OXruqJ+9cgaULUgoQb/W7BdxBCQyRQuOEdHIR+vLZJb91YtA6/CT5V+1JFBcei2cfEXW3qyCWuEOVD9hRpLhI7Dpmey9mU1GzlgDntayVq1BwB/67zUZdCTaIcI3C31dBgzW+UjFOzmzAR5/EogoXBnPDGirhcbMyHUFWhtkEMRWdinQ0ybzi7TgGEgNUj/pYgpggISDBFhs0acDm6OQ4EKUkKJrZuSqknR7DtDxi2o6eSGOHVCV6od5MVi3kq4gXKZdRntxF1lvSDUBlIwIwWoVAuI5ugdchhBFYfA8rBFVEV5cdbFcEiCN8xwt3FeCxclkSWSvUybkzyDzKJcwL69B3AkkQwIseUUnSOu4W4a3LGZdKrZEcG2kzKRJW7YDpjwsYyxuChaWSZn4BlaXm83kUHmkhijBK5a+ZaqTdRBPEzGoiGrTYbAygFP9xQZ4ZjpPIqNQerAXUbObIbIb40gNZVXdK8XKU5zfcTAIhGJ+IUA==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN8PR12MB3587.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(4636009)(39860400002)(136003)(396003)(366004)(346002)(376002)(451199021)(31686004)(478600001)(6666004)(86362001)(31696002)(83380400001)(36756003)(38100700002)(2616005)(2906002)(6486002)(26005)(316002)(186003)(6506007)(6512007)(5660300002)(41300700001)(8676002)(8936002)(4326008)(66476007)(66556008)(66946007)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZkErNlMyY2EvS3NPbW94Qnc4K3B2T3pSUy9iR3JsMGdITDNjdC82aThCYWU1?=
 =?utf-8?B?TzV5ZklVNXlqN2k4MlpZWHFRSDBpU2JiVFB0YnZWQ05UTEorWUNXQm5yUXdO?=
 =?utf-8?B?WTJuQ3k5VHlWbThtV2VEZ0dNVzg2NjkzR3JsRi9OUVlhNmNwamlOVWR2a3ZS?=
 =?utf-8?B?SXBrbzZxNWFkVG1rcU85Mm9OT3ptZ3BLT3JXQ0xNSS9xeDk0YUF3RFBaZ2or?=
 =?utf-8?B?SFV1cHp2R0RqSGRWL0Z6MDhxTHNHMDVuS0swcytDSVpRaEthbGJtVUoyRnN1?=
 =?utf-8?B?bm5jRS9nR09GOWZXa1ZyUWQ4YmZYQTRCaDhJVVNRWVlaRlVqT01WdFI3SlBS?=
 =?utf-8?B?Q3cvYmxmL2xtZWlwQmg5aDdJNWg4WlVaSC8yNmc2dXZVRnVubFZmNVErZy9U?=
 =?utf-8?B?eXFXcGM2ZlNQVTkxU3NPemRJVmdhNm40M0c1VUszdSs0SFdrcm5NUnVkRGNo?=
 =?utf-8?B?SmhMZ25JQXNPY21lSVRIRURaQVhFaFhGNWhCNVVtWHloNUJ2cTloaVM4aFlv?=
 =?utf-8?B?NmpVL2pDZm1SYkdiZWhrU24zSlJZQllhWVg2WHdTTVhpcmxNVHhPc0JqdExk?=
 =?utf-8?B?QTBuU0lGYnYxQk85QTArNW9TQ1diN2JpcnNIeldDc3lqTjFRU2M1bWUwRnc1?=
 =?utf-8?B?OFl6UG1JNVd3QnFIV0hoRWNZTzlaRlBPNno0Zk5XVnBsMkE3L0g1ZVl3c3FN?=
 =?utf-8?B?ZVowbnA5VnV6d3hrS0RlRkFXMi9FVnQ2eUQzRFFkQ0JQdjhXck5RZ0FVcGZt?=
 =?utf-8?B?aUgrNVBTaENCSzZMT1ZoSERCSGQ4clpWL0tSeXVFNEZpdVZsaHZCNEJBYTUw?=
 =?utf-8?B?R3FCSmxDcFBWUDV3aUJoZVJWNjZ0T2p6cTZqUCtyM0pMcndJL3E4WE03b1NI?=
 =?utf-8?B?WWNxakg5c1p0UE0ya1h4blRUNWJVWFpDeVNEQkgybmpKbHYrd0ZpclRmWWdJ?=
 =?utf-8?B?a3h5R2xQbWRJT2dOS2oyUWhSK1kzS2IwNVFIeWI3K2RRMTRwS21LRFphUTB4?=
 =?utf-8?B?K2FxUkU5MFFNRlpYQURKSW1IRyszQ2RxcGd5QkJ6dUZnRDVxeWp3SFkrTzBN?=
 =?utf-8?B?QUc4TVRaRFdOVEFVSnBtZVUxdmxXOThwdHR6TVF0TTljZUVmL2FHWkFCS3Qv?=
 =?utf-8?B?UVFBY2VORFo5WjJmRG9HYXRRRkZzaGZGQ3ZmcDlPa3J1U3BhQUo0eVlKVWFh?=
 =?utf-8?B?T3YxeDA3NEVERXhOZHNwVEFRdjNjVi9Ub0tkUER2b1lqdkMrMVZ4REgxbVBH?=
 =?utf-8?B?TXRXa3A0Vk1hMmcyOHE5enovc1ZGQTZOTElha3R6M3RrZ2ZqT0ExK0Zock1H?=
 =?utf-8?B?RGdjNHloYlplVmhyZHowcG1CRk1hRXRlRWR2VHRORnRWWjZhZWplbnV4YjNT?=
 =?utf-8?B?cE9vVnBlODlGRytIMVdEbnpVUGwxZlhUcWdKcitReEFTODdBbm1qUjVaeXFn?=
 =?utf-8?B?cDJaa1BITlRnZDhZd2ZxMFI2V0NLaEZOcVFmYzQ4ek96K1Y1MnRuSWl1SW9R?=
 =?utf-8?B?Tk05QmorYUpJREIxUnUxNEZpUmcrUmpRa3QrYmhmRk1DZlVxbjA2TUQ3TkN4?=
 =?utf-8?B?RnhPbU8vVnREb29UdzlYMGw5RWtlZXcxNGFzTmJEcVRxZkFmc0R4SmYwdE9J?=
 =?utf-8?B?dVJiNXpWUlB2Y2YwWE9KZTg0YnZJVGNjMkp4MGlrK2t0M3BhQWtBNGRwUmZK?=
 =?utf-8?B?RE1rOUZFMGsrNXhlTWcvbnB4cG5GcGs3czBYZDVWM2t2ODRtSTJBcThDVnJ1?=
 =?utf-8?B?bFBvSHFBWnNqaGtPYlZoQ004aURtVVQzL2lvNW5TQnVKQ0wyYjV2cmFQb1pL?=
 =?utf-8?B?bzE4MFZibm1NVXd6NVNEbXErTTE4bnZlWklxRWdzQU15bTJDVEFVRU1Ia3Rz?=
 =?utf-8?B?a2FHSFJhc0E1dE01SWpmVk5zNlVRVllHT1BFMm1aZU1GMUQrR1hjaFg0U1ZZ?=
 =?utf-8?B?ZFVSMXB1OUVrRGsrYW81aDViam9tM0dkSTNYQjIxTkVaRkdOU2tURUF4bjFZ?=
 =?utf-8?B?SzI1WXEvNkE2a1NuS2FscVQ2eTFwVFhYYmFpL2M4b0FaNDl3eURVckM3WWtZ?=
 =?utf-8?B?MHhoODhKWWRNNGl0V213U1NkVWZSdlY0bDNreU9NVzdJTm5VRW9CR2ozRWdt?=
 =?utf-8?Q?hdRE=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f115fa07-38f6-4088-bb33-08db3a63933b
X-MS-Exchange-CrossTenant-AuthSource: BN8PR12MB3587.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Apr 2023 08:05:55.1992 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: whA0qtYh7POxUE7iW85sLehkD8FgWRj48dHhBMMR9KjLG0a3EEc2qZX05FgeW8Mh
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB8229
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
Cc: alexander.deucher@amd.com, maraeo@gmail.com, timur.kristof@gmail.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Am 09.04.23 um 20:59 schrieb Bas Nieuwenhuizen:
> We have a list of all rings, so no sense writing the same loop N
> times. With how often this gets called and how small the ring list
> is the performance of this shouldn't matter.
>
> Note that some of the loops included some checking wrt harvesting.
> That is redundant now, as those rings never get initialized and
> hence never added to the adev->rings array.

We intentionally removed that because we wanted to get rid of adev->ring 
in the long term. Please don't bring it back.

Christian.

>
> Signed-off-by: Bas Nieuwenhuizen <bas@basnieuwenhuizen.nl>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c | 61 ++++++-------------------
>   1 file changed, 15 insertions(+), 46 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
> index 0efb38539d70..89689b940493 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
> @@ -366,7 +366,7 @@ static int amdgpu_hw_ip_info(struct amdgpu_device *adev,
>   	uint32_t ib_size_alignment = 0;
>   	enum amd_ip_block_type type;
>   	unsigned int num_rings = 0;
> -	unsigned int i, j;
> +	unsigned int i;
>   
>   	if (info->query_hw_ip.ip_instance >= AMDGPU_HW_IP_INSTANCE_MAX_COUNT)
>   		return -EINVAL;
> @@ -374,83 +374,49 @@ static int amdgpu_hw_ip_info(struct amdgpu_device *adev,
>   	switch (info->query_hw_ip.type) {
>   	case AMDGPU_HW_IP_GFX:
>   		type = AMD_IP_BLOCK_TYPE_GFX;
> -		for (i = 0; i < adev->gfx.num_gfx_rings; i++)
> -			if (adev->gfx.gfx_ring[i].sched.ready)
> -				++num_rings;
> +
>   		ib_start_alignment = 32;
>   		ib_size_alignment = 32;
>   		break;
>   	case AMDGPU_HW_IP_COMPUTE:
>   		type = AMD_IP_BLOCK_TYPE_GFX;
> -		for (i = 0; i < adev->gfx.num_compute_rings; i++)
> -			if (adev->gfx.compute_ring[i].sched.ready)
> -				++num_rings;
> +
>   		ib_start_alignment = 32;
>   		ib_size_alignment = 32;
>   		break;
>   	case AMDGPU_HW_IP_DMA:
>   		type = AMD_IP_BLOCK_TYPE_SDMA;
> -		for (i = 0; i < adev->sdma.num_instances; i++)
> -			if (adev->sdma.instance[i].ring.sched.ready)
> -				++num_rings;
> +
>   		ib_start_alignment = 256;
>   		ib_size_alignment = 4;
>   		break;
>   	case AMDGPU_HW_IP_UVD:
>   		type = AMD_IP_BLOCK_TYPE_UVD;
> -		for (i = 0; i < adev->uvd.num_uvd_inst; i++) {
> -			if (adev->uvd.harvest_config & (1 << i))
> -				continue;
>   
> -			if (adev->uvd.inst[i].ring.sched.ready)
> -				++num_rings;
> -		}
>   		ib_start_alignment = 64;
>   		ib_size_alignment = 64;
>   		break;
>   	case AMDGPU_HW_IP_VCE:
>   		type = AMD_IP_BLOCK_TYPE_VCE;
> -		for (i = 0; i < adev->vce.num_rings; i++)
> -			if (adev->vce.ring[i].sched.ready)
> -				++num_rings;
> +
>   		ib_start_alignment = 4;
>   		ib_size_alignment = 1;
>   		break;
>   	case AMDGPU_HW_IP_UVD_ENC:
>   		type = AMD_IP_BLOCK_TYPE_UVD;
> -		for (i = 0; i < adev->uvd.num_uvd_inst; i++) {
> -			if (adev->uvd.harvest_config & (1 << i))
> -				continue;
>   
> -			for (j = 0; j < adev->uvd.num_enc_rings; j++)
> -				if (adev->uvd.inst[i].ring_enc[j].sched.ready)
> -					++num_rings;
> -		}
>   		ib_start_alignment = 64;
>   		ib_size_alignment = 64;
>   		break;
>   	case AMDGPU_HW_IP_VCN_DEC:
>   		type = AMD_IP_BLOCK_TYPE_VCN;
> -		for (i = 0; i < adev->vcn.num_vcn_inst; i++) {
> -			if (adev->vcn.harvest_config & (1 << i))
> -				continue;
>   
> -			if (adev->vcn.inst[i].ring_dec.sched.ready)
> -				++num_rings;
> -		}
>   		ib_start_alignment = 16;
>   		ib_size_alignment = 16;
>   		break;
>   	case AMDGPU_HW_IP_VCN_ENC:
>   		type = AMD_IP_BLOCK_TYPE_VCN;
> -		for (i = 0; i < adev->vcn.num_vcn_inst; i++) {
> -			if (adev->vcn.harvest_config & (1 << i))
> -				continue;
>   
> -			for (j = 0; j < adev->vcn.num_enc_rings; j++)
> -				if (adev->vcn.inst[i].ring_enc[j].sched.ready)
> -					++num_rings;
> -		}
>   		ib_start_alignment = 64;
>   		ib_size_alignment = 1;
>   		break;
> @@ -458,13 +424,6 @@ static int amdgpu_hw_ip_info(struct amdgpu_device *adev,
>   		type = (amdgpu_device_ip_get_ip_block(adev, AMD_IP_BLOCK_TYPE_JPEG)) ?
>   			AMD_IP_BLOCK_TYPE_JPEG : AMD_IP_BLOCK_TYPE_VCN;
>   
> -		for (i = 0; i < adev->jpeg.num_jpeg_inst; i++) {
> -			if (adev->jpeg.harvest_config & (1 << i))
> -				continue;
> -
> -			if (adev->jpeg.inst[i].ring_dec.sched.ready)
> -				++num_rings;
> -		}
>   		ib_start_alignment = 16;
>   		ib_size_alignment = 16;
>   		break;
> @@ -472,6 +431,16 @@ static int amdgpu_hw_ip_info(struct amdgpu_device *adev,
>   		return -EINVAL;
>   	}
>   
> +	for (i = 0; i < adev->num_rings; ++i) {
> +		/* Note that this uses that ring types alias the equivalent
> +		 * HW IP exposes to userspace.
> +		 */
> +		if (adev->rings[i]->funcs->type == info->query_hw_ip.type &&
> +		    adev->rings[i]->sched.ready) {
> +			++num_rings;
> +		}
> +	}
> +
>   	for (i = 0; i < adev->num_ip_blocks; i++)
>   		if (adev->ip_blocks[i].version->type == type &&
>   		    adev->ip_blocks[i].status.valid)

