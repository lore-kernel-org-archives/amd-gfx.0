Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC3FE606A32C
	for <amd-gfx@archiver.kernel.org>; Wed,  4 Nov 2026 16:10:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=nyEVBy3l
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 358EC10E603;
	Wed,  4 Nov 2026 16:10:18 +0000 (UTC)
Received: from CH4PR04CU002.outbound.protection.outlook.com
 (mail-northcentralusazon11013027.outbound.protection.outlook.com
 [40.107.201.27])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6E44810FD1D
 for <amd-gfx@lists.freedesktop.org>; Wed,  4 Nov 2026 16:10:11 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Z6Sv2Dxhy/LJ5CNGF1gh4bZGQzDPckCHXXi+ikklyo82KtuzJQQEpMrpaF4x4Lz22t+5hCjrU+xTB8KXZkIP437TVQVUr8540CU/U1edk2EAL9jdN03AuagHbvyi7H9Wi+47zFYqq66rwx/jyJ3clhjJQuZpDJhFomcSveheBYm027hfESFhlBD3PvfSi/mb/cvy03w7Ir6QHzhcFL55wQcS0rx0Rzg7y5QvhIsbCXa+5A6/nYsx3qa2doPAEeooeS+xRBmylCyc+1dIclMzitY9pE22hJe5zJCeWOPwhzKv18SLAjwN4UVP7KvH5v8b04ExVyn+7b3+rIzSrUx8aw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rj6wnmXLsjfvqfa/XB6b6m8WIUywRePUGG0hD3zTNBU=;
 b=kWg6i7uJ7Zczoc8Zy5tPlYxpLPeoBxrHgiHHN1RpmaHOdYrASPSeXooJOnLXMOGJ+Uo6GVxsoYDPdVieFQpv9Nhc7uh7+I8E8gCj9kwZmSttHPQ6nzalEgUprNXOjHEhFRnJKdUkRdQqJwzmBqbldkYX3/FxZ95T1VcCwvoh0uv3hCUWpsq4UY9AuSy/TCTPI11w4CVnZjxmy6KshqNlLjzUm/92sKy6SxsUVmcNCyPnuV5UgI0tGvYme6GvKsDqoXZNbYpQKVZLSY2e0zTxAeTFoW3H+3G0IDxhQnmkAHWH8hDYIWbBUxOvVZb755a8DGsvR6ZC7S5FIiqMXhAXdg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rj6wnmXLsjfvqfa/XB6b6m8WIUywRePUGG0hD3zTNBU=;
 b=nyEVBy3lKQic6EEktT2Zv8CxRokaM4JFnXk1HYENTPp1eDPIrIeGORbZUMzlIs++gFuERo0L91V83KpGU2adlLCBltxtkGVdmEcqB1cNERqcBsd/jZ9VMNRQcv1HUwRh0x0KoOSRFvh0QZB0W77SEsN1EcTMcN42bRp+M6KxZyc=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB5167.namprd12.prod.outlook.com (2603:10b6:5:396::10)
 by SA1PR12MB8920.namprd12.prod.outlook.com (2603:10b6:806:38e::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.8; Wed, 4 Nov 2026
 16:10:07 +0000
Received: from DM4PR12MB5167.namprd12.prod.outlook.com
 ([fe80::4588:54c1:bc29:2c7c]) by DM4PR12MB5167.namprd12.prod.outlook.com
 ([fe80::4588:54c1:bc29:2c7c%3]) with mapi id 15.21.0592.007; Wed, 4 Nov 2026
 16:10:05 +0000
Content-Type: multipart/alternative;
 boundary="------------Vbq7GxDahkDpL8JLBkgXP9r0"
Message-ID: <8cfbb96b-4e87-4744-a56c-3007679e2bc7@amd.com>
Date: Wed, 4 Nov 2026 11:10:03 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCHv3 3/8] drm/amdgpu: Emulate exporter->importer UALink
 messages in loopback
To: Mukul Joshi <mukul.joshi@amd.com>, amd-gfx@lists.freedesktop.org
Cc: Felix.Kuehling@amd.com, Harish.Kasiviswanathan@amd.com, philip.yang@amd.com
References: <20261102160125.2743750-1-mukul.joshi@amd.com>
 <20261102160125.2743750-4-mukul.joshi@amd.com>
Content-Language: en-US
From: Philip Yang <yangp@amd.com>
In-Reply-To: <20261102160125.2743750-4-mukul.joshi@amd.com>
X-ClientProxiedBy: YQBP288CA0001.CANP288.PROD.OUTLOOK.COM
 (2603:10b6:c01:6a::14) To DM4PR12MB5167.namprd12.prod.outlook.com
 (2603:10b6:5:396::10)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB5167:EE_|SA1PR12MB8920:EE_
X-MS-Office365-Filtering-Correlation-Id: 8b9f2d2e-d2d7-454e-6ec9-08df3a8e16ee
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|23010399003|1800799024|366016|261021123027099003|261022075727099003|261028144727099003|4143699003|56012099006|11063799006|261026121527099003|261102123227099003|261022105027099003|261021121427099003|261009223027099003|261102130727099003|261026140227099003|10067099003|22082099003|18002099003|8096899003;
X-Microsoft-Antispam-Message-Info: skBVCNFtZ7zZWPCkEreRkdjA8YLEyQV1W31QawNu3tvWxd9mMKjt6TlfDro9l6ld5RUUy9k1KCAmxFV/rXZU3LbC6mj1bIY2dTyfX/uF0yvE7Eojd+4ZVMG2uFQ5i6yhzwBzSBGIK1/HX9ovSS3X/YFhLj5BmKpCzOnzPCsu6EAJsCcH6nbrSNvGGF1m9ZIEF17rqCyc7ipSOYhn5WnbGHrCJiuEoPER/sk6ndN4aAHOpp098qkcwP1Gxdmp+cb3Ys5qWsb1Q/da2+XPcu07QHynwAvr1z+rGrwMjo3G57W/H11XAWsrNG2E5TuAdAGNS61JNOkEANzDPrBdoM7lgLEvy2glwKEr7cuNZZbxIRs3zvpuVnbp+x5HwWqfVQMncsZ0QvrH27/Vno2X5hEe8Tgi64aDpTnhGsKT6guBXZxQboGs76v+1j0oeb9vxom/B7vV5qtY/lmXwxxWxWHyddJ5EIbyk3wBzmtf6l2OactDN6f22SQkiR660NfHaDWfqxmc2c88U3IDbaGjB9wsOwyrbRqYWpYKObB8NMW6qIPLzZs1AFq8CroP6oJrjEMoUX9wHmDykIDBf/ElTYSFJuwBANZyHEsx1mUT1v5cMFZNtkoPoDU5ACh7pKrWG90vYEhUUpgYi35SopVGlSPnFT3vtUM0NidqNttzeZ639UY=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB5167.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(23010399003)(1800799024)(366016)(261021123027099003)(261022075727099003)(261028144727099003)(4143699003)(56012099006)(11063799006)(261026121527099003)(261102123227099003)(261022105027099003)(261021121427099003)(261009223027099003)(261102130727099003)(261026140227099003)(10067099003)(22082099003)(18002099003)(8096899003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MTZHZzIybHk3NEJrN1FEdmg5MmtnTW8zNXpPcllqa0kvYU1ZT3BhaTZGNVJk?=
 =?utf-8?B?VG03RDRXNUtCNVFOejh5R0w5dVVkWFBmWDNPVytmNEFzTlc3bUNUczcwYjJ5?=
 =?utf-8?B?MzdMWk15Y2tSbnVJaHE5VGdSNE1zblhXOGlCYzFUMGkxTUVKaENvSFNRbzFv?=
 =?utf-8?B?YjVaajU0NUNoNkJocXdnd0UxNjlkcjFRNDRnMmZiL3pMT3B1TmxvUlc4anpF?=
 =?utf-8?B?c0hlbmFWZzBDZDdwTWM4aXhQdW4zOURRUWt6Tk5pV3hhTlFKZmdMS1Z5ajFU?=
 =?utf-8?B?d2pVOVRudjNSUVpOREppT2xOS1Fzb0ozZTBoUHBaOGI5cHk5RHFPUjA1Skx5?=
 =?utf-8?B?QWNVMGM1VWtYbUY3OTJrWUk3blducEZQYXRuMFFiU2NsN01RVS9lTUZObVh4?=
 =?utf-8?B?VGpNMFhabHZKRkhtR3JOMU1USlNwZEV1YWR5SVhhT3hNTDNadENRdTVFNW5j?=
 =?utf-8?B?elBhV3Rhc0xPdzk3NFhlWGV0UWh5VUFweUlrRXFCVjJqT1hjbkhhcUMxVHoz?=
 =?utf-8?B?TU9RTys5SDVEczB1dk5NM2FRNHZwMXNRVU1aZS9GUjZYME1IS1Y3K0swODk3?=
 =?utf-8?B?TEE4VzNFcmFuSXBDNmdEQnZKd21sa0NNd2NoUjZ0U3VyTW9XbUl6TzA0QS9L?=
 =?utf-8?B?T1JsNTAxWjd0THhjdElZWmlxNTBFQnpoNmlTYU5lMk9zREIyMXYyK054R21R?=
 =?utf-8?B?Y1U1dVhmK2ZjZlR4NDZlWnFLUkkyM3cxclhnVkM5cXVvQ25aNSt1V1J3YkR1?=
 =?utf-8?B?SGRqamVJS1JFREtZS1BkbUZZMjN1d3d3eVRja1JsZk1OVDYvR0dvaGs1dGZm?=
 =?utf-8?B?ckFxby9nVGdRd0lXTE9qYXRuOFFLZ3RiMnV4andMTjJFTjF3d1FWY2dldW9H?=
 =?utf-8?B?ZVhqYjFWNXMzbmtmMVhmZUcvcXBiaUlyWFFvMTBjQXM2S1hJWlM1VVdKUTNC?=
 =?utf-8?B?VmtaUHVreW5iSnRXWHcxWmJGb2paYkw2MHA3NVFSSDUxNnpaa05LdHljRVlW?=
 =?utf-8?B?a2p3MmNsc3JTREo5Uis0ODR1bFJFZ05OMFJUOUZ5NjRaWVJ2NmhQTS9rVi9J?=
 =?utf-8?B?UW0wNlJ4QnpjaXp4aGlFdzNLcDd6dkZKeVp5K0FwdTFIZ1JjYWNJeER6eU4v?=
 =?utf-8?B?TkFTUklUZDhjQkNka2djdXNLYktxTWljTzd2SXc0Z3N0dmhyQkRtV2IvcEpx?=
 =?utf-8?B?SVhTaEF2RXdSTTNCRk9ydVlKUHdrOUIyRUFIU1psVW90VndBWk94WTdqVU9W?=
 =?utf-8?B?MnNaeHhPWEpvODVteE16UVdLU0RQeTRpUXY5Ny9CclFBcTE0MTNWS3A3ZG1H?=
 =?utf-8?B?MnRZc2M0Rm5IUy9DV0xPQk5RQWErOWdmbW5VeENLN2ZuOHdDUUZYSm4xdGVB?=
 =?utf-8?B?eDRTdko0V04wMENybXdIc2hUVk9aSVpFMEIrblBSc2U2Tm5wdlFxRE1NT3pF?=
 =?utf-8?B?S2x1Z3ozQkFNeld3VldWSmF4dlpYd2xSbmt3YURuVEdhWWduQ0xRaHhtNkZ3?=
 =?utf-8?B?ZWxNZXRralpnMzBPSVhFeUZHdWpic0luWDNoRTBGcXBJQnNaSit0SUNYOE1y?=
 =?utf-8?B?UkFjcGYwc093WmJ0dmszdGt5d3I4VnJYUmtER2JBMThmTlp5cDZxQ3BtNFcy?=
 =?utf-8?B?UFJ3ZTVpdjgwaitLRGgwbTMxaXh6R0FxRkIrRTluRjVZT1JtZk53elh6blU0?=
 =?utf-8?B?NDZkQm5mQlpnUEV2Nml1WUxWeVpSZkpXZjRKR3dPR2luMmxWV3g5SW0yTENM?=
 =?utf-8?B?S3J0OFlJZzhSYitHSTNndkFtUFJIUWJHVVNsUnRnL0VHWEZpdWtRclhXOHU4?=
 =?utf-8?B?ekJTVGdHNHJNeDhkN2dHSGRhbzN1b1VkYys3NUk5VTFqcDBBZnJxRENFcFdU?=
 =?utf-8?B?TnBncEFCZEZDOGlXRFlCREFRK2o3OTduRnVDbVVMZmdOOTdDZlF1TVZ4N1dZ?=
 =?utf-8?B?K2RVajhiQnc3UmZPelErU3IxS0VVRSs0cEJVRzJDakI3RHAvWjcvQk9HMDg4?=
 =?utf-8?B?R0pmYnBRVjIwNTM5c1ppS2p1d0Y2VXlxakI1Y0p4bW45bXJnQ0tGdy85bFE5?=
 =?utf-8?B?S0FYSWc4M1lEWjJ3TzFrNmFaZER4cmdOQzk2Tnk0Z0hkSVBwNnN3SCt5L3Vo?=
 =?utf-8?B?V0d4ZzZCVmYyeGx1YnRCajJxVE0vTGZZaEpSU3grR1NuSkN3Wk0yam5RRHg1?=
 =?utf-8?B?cTJXVGZsSUdvOGFOWENHNm5mSUhmT0JrOUpOaHlHVEZuMENLaHN3OS8zcnVi?=
 =?utf-8?B?aTRPNlFXb0RLeVZUOEI0S0VXOTduMEs5MFBCYm4yWnZvVS9WUU9uY2RLK2xh?=
 =?utf-8?Q?qtkYMTBrdSsWLZ3WrU?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8b9f2d2e-d2d7-454e-6ec9-08df3a8e16ee
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5167.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Nov 2026 16:10:05.6812 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qe3DDxmfZEteuh829x8EnYnvq4UPCVTBzJEH0diZ4J8xE0HPDTyv2i+oqJYoPwZA
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB8920
X-BeenThere: amd-gfx@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Discussion list for AMD gfx <amd-gfx.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/amd-gfx>
List-Post: <mailto:amd-gfx@lists.freedesktop.org>
List-Help: <mailto:amd-gfx-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/amd-gfx>,
 <mailto:amd-gfx-request@lists.freedesktop.org?subject=subscribe>
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-14.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	HTML_MESSAGE,INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--------------Vbq7GxDahkDpL8JLBkgXP9r0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 2026-11-02 10:47, Mukul Joshi wrote:
> In UALink loopback mode a single GPU acts as both the exporter and the
> importer. The exporter is the one physical station, so the only path
> the HW serves is importer -> exporter. A message the exporter sends to
> the importer cannot be delivered by the MP nHT.
>
> Emulate that direction in SW: when loopback is enabled and a remote
> interrupt is addressed to the importer, queue it on the loopback
> ordered workqueue, which feeds it back into amdgpu_ualink_process_irq()
> as if the exporter had sent it. The ordered workqueue keeps successive
> messages in order and runs the (possibly sleeping) handlers outside
> the sender's context.
>
> Signed-off-by: Mukul Joshi<mukul.joshi@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.c | 82 ++++++++++++++++++++++
>   1 file changed, 82 insertions(+)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.c
> index 29a787979af2..ef133c60bb9a 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.c
> @@ -60,6 +60,9 @@ static void amdgpu_ualink_reset_peer_rings(struct amdgpu_device *adev,
>   					   u32 remote_accel_id);
>   static int amdgpu_ualink_ring_resync_ptrs(struct amdgpu_device *adev,
>   					  u32 remote_accel_id);
> +static int amdgpu_ualink_loopback_self_interrupt(struct amdgpu_device *adev,
> +						 u32 sender_accel_id, u32 dw0,
> +						 u32 dw1, u32 dw2, u32 dw3);
>   
>   #define STRIP_NPA(addr)						\
>   	(((u64)(addr) & ~AMDGPU_UALINK_NPA_ADDR_GPUID_MASK))
> @@ -6220,6 +6223,17 @@ static int amdgpu_ualink_remote_interrupt(struct amdgpu_device *adev,
>   	struct amdgpu_ualink_ring *ring;
>   	int r;
>   
> +	/* UALink loopback: the single MP nHT can only deliver messages addressed
> +	 * to the exporter accelerator. Messages addressed to the importer
> +	 * (exporter->importer direction) cannot be delivered by HW, so emulate
> +	 * them by feeding the message back into our own IRQ handler.
> +	 */
> +	if (adev->ualink.loopback.enabled &&
> +	    remote_accel_id == ualink_imp_accel_id(adev))
> +		return amdgpu_ualink_loopback_self_interrupt(adev,
> +				ualink_exp_accel_id(adev),
> +				dw0, dw1, dw2, dw3);
> +
>   	peer = &remote->peer[remote_accel_id];
>   	ring = &peer->interrupt;
>   
> @@ -6649,6 +6663,74 @@ static int amdgpu_ualink_process_irq(struct amdgpu_device *adev,
>   	return handled;
>   }
>   
> +/* Work item used to emulate an exporter->importer UALink interrupt in
> + * loopback mode (see amdgpu_ualink_loopback_self_interrupt()).
> + */
> +struct amdgpu_ualink_self_irq_work {
> +	struct work_struct work;
> +	struct amdgpu_device *adev;
> +	u32 sender_accel_id;
> +	u32 dw[4];
> +};
> +
> +static void amdgpu_ualink_self_irq_worker(struct work_struct *w)
> +{
> +	struct amdgpu_ualink_self_irq_work *job =
> +		container_of(w, struct amdgpu_ualink_self_irq_work, work);
> +	struct amdgpu_device *adev = job->adev;
> +	struct amdgpu_iv_entry entry = { };
> +
> +	/* Build an IH entry as if the message had been delivered by the MP nHT
> +	 * from the exporter accelerator. amdgpu_ualink_process_irq() consumes
> +	 * the sender accel_id from entry->pasid and the four context dwords
> +	 * from entry->src_data[]. entry->ih must differ from adev->irq.ih so
> +	 * the message is processed here instead of being delegated to the
> +	 * UALink soft ring.
> +	 */
> +	entry.ih = NULL;
Looking at this again, it seems we could use adev->irq.ih here to 
simulate the message arriving from the real hardware interrupt ring. It 
would then be delegated to the UALink soft ring and handled in the 
interrupt worker, which would let us drop the job structure and 
amdgpu_ualink_self_irq_worker entirely.

The current approach works fine, but that would be simpler and avoid 
introducing another job and work item.

Regards,
Philip
> +	entry.pasid = job->sender_accel_id;
> +	entry.src_data[0] = job->dw[0];
> +	entry.src_data[1] = job->dw[1];
> +	entry.src_data[2] = job->dw[2];
> +	entry.src_data[3] = job->dw[3];
> +
> +	amdgpu_ualink_process_irq(adev, &adev->ualink.irq, &entry);
> +	kfree(job);
> +}
> +
> +/*
> + * amdgpu_ualink_loopback_self_interrupt - deliver a UALink message to ourselves
> + *
> + * Used in loopback mode for the exporter->importer direction, where there is
> + * no HW path. The message is processed asynchronously on an ordered workqueue
> + * so ordering between successive messages is preserved and the (potentially
> + * sleeping) message handlers do not run from the caller's context.
> + */
> +static int amdgpu_ualink_loopback_self_interrupt(struct amdgpu_device *adev,
> +						 u32 sender_accel_id, u32 dw0,
> +						 u32 dw1, u32 dw2, u32 dw3)
> +{
> +	struct amdgpu_ualink_self_irq_work *job;
> +
> +	if (!adev->ualink.loopback.wq)
> +		return -ENODEV;
> +
> +	job = kzalloc(sizeof(*job), GFP_KERNEL);
> +	if (!job)
> +		return -ENOMEM;
> +
> +	job->adev = adev;
> +	job->sender_accel_id = sender_accel_id;
> +	job->dw[0] = dw0;
> +	job->dw[1] = dw1;
> +	job->dw[2] = dw2;
> +	job->dw[3] = dw3;
> +	INIT_WORK(&job->work, amdgpu_ualink_self_irq_worker);
> +	queue_work(adev->ualink.loopback.wq, &job->work);
> +
> +	return 0;
> +}
> +
>   static int amdgpu_ualink_set_irq_state(struct amdgpu_device *adev,
>   					struct amdgpu_irq_src *source,
>   					u32 type,

--------------Vbq7GxDahkDpL8JLBkgXP9r0
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: 7bit

<!DOCTYPE html><html><head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
  </head>
  <body text="#000000" bgcolor="#FFFFFF">
    <br>
    <br>
    <div class="moz-cite-prefix">On 2026-11-02 10:47, Mukul Joshi wrote:<br>
    </div>
    <blockquote type="cite" cite="mid:20261102160125.2743750-4-mukul.joshi@amd.com">
      <pre wrap="" class="moz-quote-pre">In UALink loopback mode a single GPU acts as both the exporter and the
importer. The exporter is the one physical station, so the only path
the HW serves is importer -&gt; exporter. A message the exporter sends to
the importer cannot be delivered by the MP nHT.

Emulate that direction in SW: when loopback is enabled and a remote
interrupt is addressed to the importer, queue it on the loopback
ordered workqueue, which feeds it back into amdgpu_ualink_process_irq()
as if the exporter had sent it. The ordered workqueue keeps successive
messages in order and runs the (possibly sleeping) handlers outside
the sender's context.

Signed-off-by: Mukul Joshi <a class="moz-txt-link-rfc2396E" href="mailto:mukul.joshi@amd.com">&lt;mukul.joshi@amd.com&gt;</a>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.c | 82 ++++++++++++++++++++++
 1 file changed, 82 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.c
index 29a787979af2..ef133c60bb9a 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.c
@@ -60,6 +60,9 @@ static void amdgpu_ualink_reset_peer_rings(struct amdgpu_device *adev,
 					   u32 remote_accel_id);
 static int amdgpu_ualink_ring_resync_ptrs(struct amdgpu_device *adev,
 					  u32 remote_accel_id);
+static int amdgpu_ualink_loopback_self_interrupt(struct amdgpu_device *adev,
+						 u32 sender_accel_id, u32 dw0,
+						 u32 dw1, u32 dw2, u32 dw3);
 
 #define STRIP_NPA(addr)						\
 	(((u64)(addr) &amp; ~AMDGPU_UALINK_NPA_ADDR_GPUID_MASK))
@@ -6220,6 +6223,17 @@ static int amdgpu_ualink_remote_interrupt(struct amdgpu_device *adev,
 	struct amdgpu_ualink_ring *ring;
 	int r;
 
+	/* UALink loopback: the single MP nHT can only deliver messages addressed
+	 * to the exporter accelerator. Messages addressed to the importer
+	 * (exporter-&gt;importer direction) cannot be delivered by HW, so emulate
+	 * them by feeding the message back into our own IRQ handler.
+	 */
+	if (adev-&gt;ualink.loopback.enabled &amp;&amp;
+	    remote_accel_id == ualink_imp_accel_id(adev))
+		return amdgpu_ualink_loopback_self_interrupt(adev,
+				ualink_exp_accel_id(adev),
+				dw0, dw1, dw2, dw3);
+
 	peer = &amp;remote-&gt;peer[remote_accel_id];
 	ring = &amp;peer-&gt;interrupt;
 
@@ -6649,6 +6663,74 @@ static int amdgpu_ualink_process_irq(struct amdgpu_device *adev,
 	return handled;
 }
 
+/* Work item used to emulate an exporter-&gt;importer UALink interrupt in
+ * loopback mode (see amdgpu_ualink_loopback_self_interrupt()).
+ */
+struct amdgpu_ualink_self_irq_work {
+	struct work_struct work;
+	struct amdgpu_device *adev;
+	u32 sender_accel_id;
+	u32 dw[4];
+};
+
+static void amdgpu_ualink_self_irq_worker(struct work_struct *w)
+{
+	struct amdgpu_ualink_self_irq_work *job =
+		container_of(w, struct amdgpu_ualink_self_irq_work, work);
+	struct amdgpu_device *adev = job-&gt;adev;
+	struct amdgpu_iv_entry entry = { };
+
+	/* Build an IH entry as if the message had been delivered by the MP nHT
+	 * from the exporter accelerator. amdgpu_ualink_process_irq() consumes
+	 * the sender accel_id from entry-&gt;pasid and the four context dwords
+	 * from entry-&gt;src_data[]. entry-&gt;ih must differ from adev-&gt;irq.ih so
+	 * the message is processed here instead of being delegated to the
+	 * UALink soft ring.
+	 */
+	entry.ih = NULL;</pre>
    </blockquote>
    Looking at this again, it seems we could use adev-&gt;irq.ih here to
    simulate the message arriving from the real hardware interrupt ring.
    It would then be delegated to the UALink soft ring and handled in
    the interrupt worker, which would let us drop the job structure and
    amdgpu_ualink_self_irq_worker entirely.<br>
    <br>
    The current approach works fine, but that would be simpler and avoid
    introducing another job and work item.<br>
    <br>
    Regards,<br>
    Philip
    <blockquote type="cite" cite="mid:20261102160125.2743750-4-mukul.joshi@amd.com">
      <pre wrap="" class="moz-quote-pre">
+	entry.pasid = job-&gt;sender_accel_id;
+	entry.src_data[0] = job-&gt;dw[0];
+	entry.src_data[1] = job-&gt;dw[1];
+	entry.src_data[2] = job-&gt;dw[2];
+	entry.src_data[3] = job-&gt;dw[3];
+
+	amdgpu_ualink_process_irq(adev, &amp;adev-&gt;ualink.irq, &amp;entry);
+	kfree(job);
+}
+
+/*
+ * amdgpu_ualink_loopback_self_interrupt - deliver a UALink message to ourselves
+ *
+ * Used in loopback mode for the exporter-&gt;importer direction, where there is
+ * no HW path. The message is processed asynchronously on an ordered workqueue
+ * so ordering between successive messages is preserved and the (potentially
+ * sleeping) message handlers do not run from the caller's context.
+ */
+static int amdgpu_ualink_loopback_self_interrupt(struct amdgpu_device *adev,
+						 u32 sender_accel_id, u32 dw0,
+						 u32 dw1, u32 dw2, u32 dw3)
+{
+	struct amdgpu_ualink_self_irq_work *job;
+
+	if (!adev-&gt;ualink.loopback.wq)
+		return -ENODEV;
+
+	job = kzalloc(sizeof(*job), GFP_KERNEL);
+	if (!job)
+		return -ENOMEM;
+
+	job-&gt;adev = adev;
+	job-&gt;sender_accel_id = sender_accel_id;
+	job-&gt;dw[0] = dw0;
+	job-&gt;dw[1] = dw1;
+	job-&gt;dw[2] = dw2;
+	job-&gt;dw[3] = dw3;
+	INIT_WORK(&amp;job-&gt;work, amdgpu_ualink_self_irq_worker);
+	queue_work(adev-&gt;ualink.loopback.wq, &amp;job-&gt;work);
+
+	return 0;
+}
+
 static int amdgpu_ualink_set_irq_state(struct amdgpu_device *adev,
 					struct amdgpu_irq_src *source,
 					u32 type,
</pre>
    </blockquote>
    <br>
  </body>
</html>

--------------Vbq7GxDahkDpL8JLBkgXP9r0--
