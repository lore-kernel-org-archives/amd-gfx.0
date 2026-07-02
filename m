Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B0513C43458
	for <amd-gfx@archiver.kernel.org>; Thu,  2 Jul 2026 10:16:11 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3BA0D10F278;
	Thu,  2 Jul 2026 10:16:11 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="pNNSI5vz";
	dkim-atps=neutral
Received: from CH1PR05CU001.outbound.protection.outlook.com
 (mail-northcentralusazon11010033.outbound.protection.outlook.com
 [52.101.193.33])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 77D5210E492
 for <amd-gfx@lists.freedesktop.org>; Thu,  2 Jul 2026 10:16:09 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ihp+7V8n8IrbQRB6QaHulEAAbhl5JPsE06qb416z5jhWMSo3YgMZQpd20Vkv6U9qIzZuWhoFOkKDyIMbQQmgmDD2XTLP8sLg+DZ9TjubjRsx3lQk/zAaQWhU/MzRkG/7pg/UherNh54AYj8zqS8g9dhS260yl+V1Beyc5drJIVgiqtOyb2vyCzqtb1kE+pkkf7H4+b8nZo4rfbRBeH5N8XOIMiErvWVlJ2cmMPyqqg2T95IbwU/TbvaApQXQHlJXnOz+FJBZp3TKBsFKVIJwm83dY5EqTpnq5TC0/I7aqptCzHvjlc6MDFAbxc78JjzI4Ai9kDYF52nXikgmM3rx+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ktW1Wj1h1GstX5e7xbbFlknfU93qo3FMuijBxIhR28Y=;
 b=XNvplNbtauHHIQE2DTpgHry8bOeQ3KQE+x9lrdzNYeo6joQCQpd1a2oexqqouhiqZ4J+Yo3aN7akZ8Mblk8bZpbk/iH00KOlxOD1dRYgm14Vt6zi8aHx1C6aNP5Tz45hqluGQibrJ/tK7U3TCJ4rmrLwCY0TCcNx6caPWVtO+9WvVHBBKZqFzxa9WdK7DtiFFuzW/Lolw87NioQCvjk4noe6fPghWzayBomcY4+CvnLkZKyhobN253W3DkAUMG3s5tJQhYvrGeNik0Nm8aRYtcLCDCUMvLLdz3keLo8hzzBdf0WdyMQqyj6bokG78JTzrDNv7pLrBEpzEn3IyLhfbg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ktW1Wj1h1GstX5e7xbbFlknfU93qo3FMuijBxIhR28Y=;
 b=pNNSI5vzrncAu7uY9e51BWNrQAnnZzDpwroJnNFo3r+Gcfn97eG1wt3/7a+Xjg2Qus7F+SlP+y31sL1ahohxZtH5Kcpo8+P6GNCrjayTf61YAooIelsiW5+T12fPKItZw7Eyr4ABK0U6hqMrpNuOrnhDRFV7WVuINxzz6gzzSCc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by DS0PR12MB7678.namprd12.prod.outlook.com (2603:10b6:8:135::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.10; Thu, 2 Jul
 2026 10:16:02 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c%5]) with mapi id 15.21.0181.008; Thu, 2 Jul 2026
 10:16:02 +0000
Message-ID: <07c11260-ab1b-4cd4-a784-8cbc69e6668e@amd.com>
Date: Thu, 2 Jul 2026 12:15:57 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 06/14] drm/amdgpu/ih7.0: Use IH_SW_RING_SIZE for soft IH
 ring instead of PAGE_SIZE
To: =?UTF-8?Q?Timur_Krist=C3=B3f?= <timur.kristof@gmail.com>,
 amd-gfx@lists.freedesktop.org, Alexander.Deucher@amd.com,
 Natalie Vock <natalie.vock@gmx.de>, Amir Shetaia <Amir.Shetaia@amd.com>,
 =?UTF-8?B?TWFyZWsgT2zFocOhaw==?= <maraeo@gmail.com>,
 Mario Limonciello <mario.limonciello@amd.com>,
 Tvrtko Ursulin <tursulin@ursulin.net>,
 Felix Kuehling <Felix.Kuehling@amd.com>, Lijo Lazar <lijo.lazar@amd.com>,
 Siwei He <siwei.he@amd.com>, Philip Yang <philip.yang@amd.com>,
 Mukul Joshi <mukul.joshi@amd.com>
Cc: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
References: <20260701161721.85681-1-timur.kristof@gmail.com>
 <20260701161721.85681-7-timur.kristof@gmail.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20260701161721.85681-7-timur.kristof@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR4P281CA0016.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:c9::6) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|DS0PR12MB7678:EE_
X-MS-Office365-Filtering-Correlation-Id: 5efd2f16-e7c6-4677-fc67-08ded822eb56
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|376014|23010399003|18002099003|22082099003|4143699003|56012099006|11063799006|921020;
X-Microsoft-Antispam-Message-Info: yl3BcjuTTJg5uVmpV+dJCzC3NTaTb2V54qntbREAYdD+ul6JT21XVDeeeYbAwsXlDoXEcM9TpDnssZ8E3UpzjJGnuQAbGlYkQOca32rVIBlQv/Vsk9peROACDm28kVBUb9BTKBwrLG4zFeaTKNi08H3CroJmUW8qWFrowKgLSoQIzsT+Js27bzYTPeABSrshc3ROVOnLPvRxySTraWXEGS7sD6tKZYTKpwImXbH1a08kGxxOuN5E2ffLyaYC4R2WUcNUbWPNc8eVNwbjzIItDpnJDYNd9Nk9DfYw/r189+5SA656kfikvDHlDi4NoZ/ypYX9byTRPIZ/mRcHUOGgkG8/KAqc4wpon7wF4duCdHEzttWFA5UYCCSq0Lfv+YhqkNHUkMyrmnX8wt1VUjRUlhih/o54sTEVN8lLEjjQPn3aM2TBzMRGPf5MyE84bQmsJ1895gzZUU1FEzIIHWPlT+Bfn9IGDExN+EkipW1zMwfdSGfAams6By6+GooeMZhcoxrCszGG8j7MnFEljemtSbeEyMBomyzLxVbolkqnXMDcWbiD1ZJj8DahWyoq1uyW749meIjMQEM5jstIxAicTJCsLpggfO6AgYzh4yeeaK9/OkRHbI1jZ2CCoZoWgdEOXoFZ9IzRA7P8NzSKIDmD5g5JfL2wVmiUBmnI6ruP8LD19DCEacihKdMuDRSivprcXHw/VNuBGGuNQxW6tRutEw==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(23010399003)(18002099003)(22082099003)(4143699003)(56012099006)(11063799006)(921020);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NjZuWmhhUDZJM2M1RDBPUVhuYXlpUzkyZFlCNUVuREZqbmwvaVFaRTlLUG5I?=
 =?utf-8?B?S0Fpb3B0ZTQ3QjdrYStFSzZldnlRcmw3eDhVanhXM0VTMWRjZDdxTmVtQ3E2?=
 =?utf-8?B?ek5hNFhKWCtlRmJUVnZhSFpBVENPUkJqdEJZZ0VaaHloUURUWlpNUFFYdDhn?=
 =?utf-8?B?YnVrT1FoN1RHelJtZFpzV21LMnRJQjROWTV5akRIbVdXdUxKYkk0d0VBTTZn?=
 =?utf-8?B?c2plaFJmV1ZJVWgwL1E1c1hRTG1MSGlBYUl0aHl3Q0VyWkVFRWlub0ZCWDlV?=
 =?utf-8?B?bUsxNlBQSEVRSEcyWW0ya2M0K3N1NXd6akJPSjJIV29CU3VyVWFoNVdDL0Rt?=
 =?utf-8?B?OUxaUjRXbE42MnRzTjdQdjE3MjVIRUZzTUwrb2Zqei9NaWNXRU5jYUJ6Um5C?=
 =?utf-8?B?akFxWTRLTG1RdEUwcnBVU1k2SFF3eXQ5TGdIVlFnZ3I1bnk2aWRnT0JkRWYy?=
 =?utf-8?B?MGVkSURrR3hOWUZrUHlPVlcrK2QvOHpoQnJFall1NnkzaDEvOTRVWE9LK0ZH?=
 =?utf-8?B?eG9yOGUxNlZWQytwZ2NzSHcxQXRwcHNCakhWRlhmenYwTHFrb0s3RnBiM0Zw?=
 =?utf-8?B?VjdlZDNPRTBKU0V5c2N4Z0dRK2M2S1BaREQ2VkIzQnFnbHpDRzMySFFZOS9x?=
 =?utf-8?B?eVRHRHR3ZFFXc0RNVlpMTVZkL2NPMDI0MXQ1MWVUOXFFSlYrQzdwSXRsNWdp?=
 =?utf-8?B?OGhPQkpFOTdvZ3c3M1pJaEdFRktCZHg0TGtHZUFOK0MwdGJjcmlhT2VjMnRF?=
 =?utf-8?B?U1NidG1ZNDlza2lncHdOZmI5bkNOdEpqWXBUSU42eHRZakF3cVh0VE5hYm1Z?=
 =?utf-8?B?RlFmQmVLUU9MRVN4bUpVK21iaEtKWm1lelBqRlpaSUQxSnpyb1lXeXM2VlZC?=
 =?utf-8?B?RDVRZm5tRndJOG82RldiQ1VXRE96TlVwdittRFBxNnFNT0Y0RW9QWGY2bHFs?=
 =?utf-8?B?Zm9nNE43UW5OaEhZWlN5UHJvZEk3em4zbHBma212R2p1ajFXSlRYU1FRengr?=
 =?utf-8?B?NExtSHh0eVVlZmxKV0dBcnpaekIwbnk4MTZhdzREV2FZY095VFlkUE03MDJS?=
 =?utf-8?B?SFlsU0RLbFFFZ0k0eUZKaWU4cllXZm5EM3F6U2N0Vm1tQnZ3clZaZU9za1I5?=
 =?utf-8?B?VTkwK2pteEtwRGFSK0pjTXVqTWk5QUUwUlBOWjBuVkVIWTdCRlgrWGx2cFBx?=
 =?utf-8?B?Ym9JN1E4NzRVVy9yZkpvRk8rM0U2U0xjSUhTcFlHRnB3V3p5R0tXWnhBSllz?=
 =?utf-8?B?SmFjb1M1ZFVMZCtSWmw5V0x3Tlc2MWVYbVd4Y3RxOWNXRkRDbHE0TUdlNVB3?=
 =?utf-8?B?WWxGRGlKRmZRMldFWUkvb2FHVTFQdVkwY25yaDh5Y0hId2Y0SStWQi83L2JK?=
 =?utf-8?B?Nk1PWkR0cWc2bngvYUZNUmExVkZYekNHc1h5cCtSazd1NXRTWUdWTWlPWWZW?=
 =?utf-8?B?ejdPb0w4UXRWeDgrUG1SOHhBK0s4dDB2cCtPN3dhZDU2LzZEbmliUlc3dElv?=
 =?utf-8?B?YlBDcTh6WVVseVFVOWFrcmhjSDhSTDhHWkpvK0luZWRXSVFscEVKa1dNUVZV?=
 =?utf-8?B?amtNSEJkay9GejJub1pMSmROMTlPS3FNSEhSaGhlMEJ1d0VPdTRWVm5ISFhy?=
 =?utf-8?B?VnFFeWFNWG1xNitQZmhTaUI1WjJpVVRGZlpwSTFNREFHY1lhT1k1UFVqajEv?=
 =?utf-8?B?UG1DMGwra2dWU3NieWg1Wnh5VUxucXc3bUxJdUk2cFY2c2lXaHZ5OVk4WjFU?=
 =?utf-8?B?TE44TnAxc3YzcmQ0NHZvajFwYXVZT3YzdW1Fbmp3Q0huMkxTMUZFY0VxU3lr?=
 =?utf-8?B?YlBZTitEV2doVHNZNG1mMzFwczNzbjlwZXJVZEhycGo3MzR4dGYzOHJZdHVs?=
 =?utf-8?B?NEtIY20vcE5GOFlocC9Nd2d0dUI0VnJjdmhzY0ZmMURMb3BOcnhVNkMzektJ?=
 =?utf-8?B?aVIrOG0rZEtVQVJLdjNhemVSU1JtWVZvOERkNGFLWm1ZQlI5L0swaU8zbEVz?=
 =?utf-8?B?d0RaZms0WHVFMEdlYnV5bVZPN0prbnNZVllQbFBwRWJsUmdtVVpmaU45YXhw?=
 =?utf-8?B?a0tlN3JUbG1lZ0pxeTJVS1dIeTdOaVVzeVBKaUV5RGh3d2NDeW5EUG5pL284?=
 =?utf-8?B?cGZyV0k4ckFHa2Vmb3VvKzEwVFV3NWtHNzZJV0xxVjlHZytvby9MVWJDUWdi?=
 =?utf-8?B?K3lyOFA5UVc2cE5iUHJHdTVSVkY4bUl4VVVqL3pQZmI5cmVoM2JZUFJJa0tQ?=
 =?utf-8?B?bm9DYTFGdmF4Ym01b1hMTyt6YWdXM285d0dxZUhpMHFBTHlGdUZMQVNkdHZa?=
 =?utf-8?Q?UWT/xGw6CMyIllBDr8?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5efd2f16-e7c6-4677-fc67-08ded822eb56
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jul 2026 10:16:02.4871 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pXzgpKdXWIxPN5qt6+ArqXg/T2rPMBcCijPlmon32l2wHeqUdLnGvkZ02pOSUL4n
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7678
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

On 7/1/26 18:17, Timur Kristóf wrote:
> When there are a lot of retry faults happening, the soft IH ring
> can fill up really quickly and possibly overflow. PAGE_SIZE was
> too small, use IH_SW_RING_SIZE to match what other GPU generations
> are doing.
> 
> Signed-off-by: Timur Kristóf <timur.kristof@gmail.com>
> Reviewed-by: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>

Reviewed-by: Christian König <christian.koenig@amd.com>

> ---
>  drivers/gpu/drm/amd/amdgpu/ih_v7_0.c | 5 +----
>  1 file changed, 1 insertion(+), 4 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/ih_v7_0.c b/drivers/gpu/drm/amd/amdgpu/ih_v7_0.c
> index 24be9d726428..f1de6450a31d 100644
> --- a/drivers/gpu/drm/amd/amdgpu/ih_v7_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/ih_v7_0.c
> @@ -601,7 +601,6 @@ static int ih_v7_0_sw_init(struct amdgpu_ip_block *ip_block)
>  	int r;
>  	struct amdgpu_device *adev = ip_block->adev;
>  	bool use_bus_addr;
> -	unsigned int sw_ring_size;
>  
>  	r = amdgpu_irq_add_id(adev, SOC21_IH_CLIENTID_IH, 0,
>  			      &adev->irq.self_irq);
> @@ -633,9 +632,7 @@ static int ih_v7_0_sw_init(struct amdgpu_ip_block *ip_block)
>  	/* initialize ih control register offset */
>  	ih_v7_0_init_register_offset(adev);
>  
> -	sw_ring_size = (amdgpu_ip_version(adev, OSSSYS_HWIP, 0) == IP_VERSION(7, 1, 0)) ?
> -			IH_SW_RING_SIZE : PAGE_SIZE;
> -	r = amdgpu_ih_ring_init(adev, &adev->irq.ih_soft, sw_ring_size, true);
> +	r = amdgpu_ih_ring_init(adev, &adev->irq.ih_soft, IH_SW_RING_SIZE, true);
>  	if (r)
>  		return r;
>  

