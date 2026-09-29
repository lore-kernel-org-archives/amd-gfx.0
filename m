Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 05A6BCA5FA5
	for <amd-gfx@archiver.kernel.org>; Tue, 29 Sep 2026 12:00:03 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 58D9110EE52;
	Tue, 29 Sep 2026 12:00:03 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="5nCQ3DHK";
	dkim-atps=neutral
Received: from BL0PR03CU003.outbound.protection.outlook.com
 (mail-eastusazon11012059.outbound.protection.outlook.com [52.101.53.59])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1092610E189
 for <amd-gfx@lists.freedesktop.org>; Tue, 29 Sep 2026 12:00:02 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Ymq569Koi/g830V4pMWk2PKqHTAZGPV6QDgr5qUelaVE3ABfA+s4/XeEdCmlYV16v9QW572EVZTxQaARQYBSJ/kzMBi3D5S2AIicIiVFHAk1TxOZ8MywtDKqKXct7/ZZJ+NS7aWU1/Aje2rM3/3xtgIaBIbYKcBmYNMYXfzyGp29ncUsQSefckMtnALxfQEGiX7gbcqnHJXpF4Wh3UFepclxGmc1pOKB5fBtMJUvVFmoCDrdUPr5zjlFIE/kTWcn1R6w+fQzXitwxocez8crMScI88UXyjhDIV9+VHjuBax32Ujm0H1ZGoYEGZpAs1DxWhlw6LdRFY4uhYCDe9QNLA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KUcxgqhrDVzk9t4sZQP4QuJ5RexmV1VJdJ0KnJhvEB4=;
 b=YPX3JHEbrwWc6xUJ+KRsnb4Jw6bx8tZsYARrdSFBz+1f7KbVn4TEJuFoYUo5M+0guAK7taKSGrFOT6HKf7WVt/0NjAkTM8ydX7/uBVN/3HWJwhftw5gjdH+lzQxPyrjGNyOoEuqCeAkWaAPVhRNVzd0SCWFjeUX1KlE1u4hf2DyJ4IWzcPtPwX5N+utKtmwdbsQyW5/1/4GSybfjuhGl+80SrASiOAtk4eum9tc3ARbhcjCCj2kPWMwyLJIkDjFZPI1wi8ql4C7Ed5AkLzM6qRFSE4UuykxKN2b6NAoawgJGZeIBTPeqa+BR1xyF2PvogLoCffbb9P7C8gb+YwA6fA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KUcxgqhrDVzk9t4sZQP4QuJ5RexmV1VJdJ0KnJhvEB4=;
 b=5nCQ3DHK+MRBBHoAlEKeTswZ0cD0gv3OCdmkJxGc1eVAy/n8nNuU2j+2Eo6LaYDdCTsIv3gfjIy/nwEleRG6PPmT2tMVSGXOzVUIOrW+Zo5utju/N6RZQ9c/SnjSGDJzB41OfpVZcecLV81ht8+5JkH8kmU8vvqZrsJ4oivMlxs=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by CY5PR12MB6084.namprd12.prod.outlook.com (2603:10b6:930:28::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.23; Tue, 29 Sep
 2026 11:59:58 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c%3]) with mapi id 15.21.0451.022; Tue, 29 Sep 2026
 11:59:58 +0000
Message-ID: <27e743ed-b3f0-43e2-8c40-6c8c7a7926d6@amd.com>
Date: Tue, 29 Sep 2026 13:59:54 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 3/9] drm/amdgpu: reserve SPM VMID on gfx7
To: Sunil Khatri <sunil.khatri@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>, Zhu James <James.Zhu@amd.com>,
 Felix Kuehling <felix.kuehling@amd.com>, Ma Bing <Bing.Ma@amd.com>
Cc: amd-gfx@lists.freedesktop.org
References: <20260928185756.2382322-1-sunil.khatri@amd.com>
 <20260928185756.2382322-3-sunil.khatri@amd.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20260928185756.2382322-3-sunil.khatri@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0202.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:e5::12) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|CY5PR12MB6084:EE_
X-MS-Office365-Filtering-Correlation-Id: 6c1cfd3d-89e7-4b98-f850-08df1e212efd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|23010399003|4143699003|56012099006|11063799006|10067099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: m3EwPKYVu2189+VIpx8Xt3tO4jjkqEfsCzvreIMcbuKatoipbKw/sHVm34/wwaebxz/Jml9ihrZJuDxVoSJZUW6/zL5CHnYWEPFej8ujm+gOsMfr+4iGVJrRtsjl8+ji1LE6yegw/f0pSsLdNXMRiZqHnX7Ofh/l+Ew6J9imcV95e2XOvU0GyfsCiBb9Ouas/YP8+CYXawBH/4rNzFIxRji53S6WhjQuyiGxL2OFw0wPT/wkjHYOjVd8D074IhUsJAlIThXqQDIaRXQs6jRoiMI8SmfSEQWw3w4EKKVj/mAR9ZqEt5M3nGjnThESHrfGUGNvSEMlHvZyhY0fDggFth6H9TGR//sA3ZA3XCSqL1cUBULwrRToUF1nrKpKPBvZExdogM57/QBEK1vo87+pgjGoMXF9rJfb3tLHY6VrPzrn9h3ipyrFHt+gKQoJDe/y1f145RNtWP8ecF5oaljs6w0qbRBvwMUAid1eSkr/lxHd168v+d4M/duxpne3ctuAMHOGOi9y84qgXCWRFBgT/kNEpoVlL1bq2Xjwn6kIAekla6w/fQsLZbD2rIxfoFi0C2UbNW/BMLLxaX88NIDj8D8w7iNIIGKnNYOsTKKGp0h7xUJ6ym2keJJJR263t8eBtU+gHvdYnvgb7/VjzTR3ST/uO/Byqnc7B0FVdSurKZA=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(23010399003)(4143699003)(56012099006)(11063799006)(10067099003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?V3dyMWwzWEUybndsMEJIQkpjM1AwemtaWkthaitNMVlTbzMwY21KZ1dZaS9G?=
 =?utf-8?B?RExkYTF4QXdjNDNGM1EvUlI4VWhUSlRONmphT1VUTVpVNzRuc2tEYnNjR0xw?=
 =?utf-8?B?SDNqRy91M2dUMTYxa1BUcFkrUXk4YWJpYjI0TTk1TlMxRU9nWHhaSFJtR0dB?=
 =?utf-8?B?eVdWeWxwZThGQ3NiNERwOGNsYlhwU05OdTlLV1NLbm1leXNMZmQ4WXp2Q1Nz?=
 =?utf-8?B?dkdCeWIxcWE4dzVtWWtaa05GQkl6UzBCQ0dNQU1KbkdzakFSQ0E1c2JrK3RC?=
 =?utf-8?B?ZUFNMVc1WUhNNWw2bDMvUG5VODFMb1JndThnL1ZZc2hmZzhXQ1l5S2dGclgx?=
 =?utf-8?B?bEl2eTRkRldiVXBBKytscFlpNnU5OVBGOWNzK3dvY3pzTlFCN3BwVTBndjJp?=
 =?utf-8?B?eXNoZ3kzRXRlejhqVGZjbkZSWEJCSGJwQUNQc1RxOUFnOW5mOTZkaFdaVUdF?=
 =?utf-8?B?YnVyd0l3SXZ4NnFBQ3N4VGxTallaZHBFZHBwejBKdzJ0WkV2cEJYWHIzSE1C?=
 =?utf-8?B?ZlpkY2ZidHZJQzdLMm1hMXpSdUVUMkgrS0RIZFJJQ3REWURjVCtDeUdTbjZq?=
 =?utf-8?B?SzFPeWpFUUV0Sk11Q21MbjJLRUp6ZnZnZFZGdUdDWWp2bFhOaE5oRUJWODli?=
 =?utf-8?B?T3FHRTRqOVI0VTdib3AwUFdhdU03NStUL1hjNlptQXFhMXBpZkZBNFN0YWpZ?=
 =?utf-8?B?ODQ5bjA4Vkg0YTNzdCt3UmRyMVc0TFpOM2ZnY0ZaV2pvOXprTVNSY2Evc3VL?=
 =?utf-8?B?VVh3SnVUT2lWcVRuVWRkY0xhOUhrSkdZTVUwZm1PdkkzdkJuM2FpaUZORUNS?=
 =?utf-8?B?RkRTZDYwTW1rK1pJclBsbXlGUk1wemxVOTVOckx1aW8zN2tjWU1RL1UyTUFZ?=
 =?utf-8?B?VzRLcFBYMW9waDJKb1dzN3lUNzlqU3ZQMUtwMnJyRWZDcWZjZXFSL2NhbXRY?=
 =?utf-8?B?R3pDNzRpeXg5TVQxbU5laFFoZ1ZWMzIrYzlqZmNJdWtyMW5DZDRwc2dwWDhV?=
 =?utf-8?B?ZnBHS20zQTZPSEdGRi9acGJKNGI4RDNML3VSdXpwRnc2L0lGYWwvV1hpLzlq?=
 =?utf-8?B?NDNNNW1jaE1xcEozWFR2aS9XVFU0OW9PU3VMa1VzMUt1bThhOTVTVEQvTGM5?=
 =?utf-8?B?MGJTMzhFYjhNVWFkdnE2YnZEb1VMMTI2STg3UVk0dkNaU1NiZDlzb0RRbjlh?=
 =?utf-8?B?UXUvN1lLdno3dFR6M3NvSElkdkNLTGMvNEowaDRYMkp3R0FKU0phaHpud2Na?=
 =?utf-8?B?bmp3aTZzUTZvSlkxR3FMNmRiOEV5b3hmY21WQTlBMGhiajlKcmxWaXRnL1RW?=
 =?utf-8?B?d1M5STZlb292WDJML3dCREY3TUJzMmR0MmJwN1ZRNG8rRC9BS2ZYNjdJb0R2?=
 =?utf-8?B?bks1VEhFRzJDd2xnaHp2WWJyNytNZEVObERYWnBFQlRWOEY3ajliNzRZeEh1?=
 =?utf-8?B?LzdEUDlHbitnektMMFRBZDl1bm5lM0pnUnFSa3Y1UjRCcHdPalJnL1NBdHZR?=
 =?utf-8?B?SksvMXNoNGdkTmhLdlA5T3BjRnEwWlVYSU1UNXFYeGwwL2haZ056SEtJMXRL?=
 =?utf-8?B?NU1nekRsakU1QjVBTHBiU25TbUVzU3JPSUg2OGY3OS9KZ0hBZXFNV0h1ZXl2?=
 =?utf-8?B?Q2pha3VhRHlSOHJjbUFjZEIxWHpoc1ZmZlJrdm5UWjlCbzExayttME1kRmhF?=
 =?utf-8?B?ajZzamVzZDF0Vm5uRThLZ1hTdm5sdVBuTDBwMmFsNWVaTjdDWDJUMEhVOGpX?=
 =?utf-8?B?RzlLbjF5WStHLzFabUdGbFZha1gxTXBpUEI0R2gveEFvOFRhTWlmandKVWsw?=
 =?utf-8?B?N3p3cC9HWEtwbGdyRi9SRHpacHI1cFJQclNYZXJ3a0E2a0VoV2EyUnpFUTQ1?=
 =?utf-8?B?bkc5cjZxeWNjV1FFeTBuYjFQejZVYzB5SUMwZDErVHprRjZ2ZXd1MytYcDlt?=
 =?utf-8?B?QlFJSm83ZHh1MlUraFh2RllXVnVmbWhpRlIxWThwODZDalNBRTJ3VDVLSUZj?=
 =?utf-8?B?c050NStHcm5OL1FhWW9IVmpYOXRrODRyRHFVK1VHVFM5eHhHZ0o3czRLVkg0?=
 =?utf-8?B?ZktLdmt1S1NMeldWSm5jNlNieGtWV21iaHFWc0d0elgyZkt5MnVlRmRPdWhr?=
 =?utf-8?B?ZVBTa2RqdzBUb2t2Sld6UXF6Q0o5Y04rRWNBN2xPSzE5R2I2RG1pYmd1Qnlz?=
 =?utf-8?B?TXdxSEdPVmViZU9JeTVhZ2JGS1l3VlBaRXJic2RCTWtEMlJJQmIxVDJlUUNh?=
 =?utf-8?B?RHJJWU1DUlQrc3BOaktRdjZhRmdLbm8rMkNvOWRnUGswNVNRdmY1VkUxNmlm?=
 =?utf-8?Q?rINbn+Fwj3Et8RQUc5?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6c1cfd3d-89e7-4b98-f850-08df1e212efd
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Sep 2026 11:59:58.4910 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0W9zdGcXknXxg+voHekbxgvebYQUJlMqPToNwVCg9rCxqSHPJwZQPhrWoV+wutJL
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6084
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

On 9/28/26 20:57, Sunil Khatri wrote:
> Set vm_manager.spm_vmid to the top GFXHUB VMID so the SPM reservation
> path hands out a fixed, isolated VMID on gfx7 instead of borrowing
> one from the graphics pool. The reserved VMID is excluded from the MES
> user-queue mask and the KFD compute pool by the shared reserved-VMID
> infrastructure.
> 
> Signed-off-by: Sunil Khatri <sunil.khatri@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/gmc_v7_0.c | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v7_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v7_0.c
> index c95e097241bf8..89e7d19203183 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gmc_v7_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gmc_v7_0.c
> @@ -1007,6 +1007,10 @@ static int gmc_v7_0_sw_init(struct amdgpu_ip_block *ip_block)
>  	 * amdkfd will use VMIDs 8-15
>  	 */
>  	adev->vm_manager.first_kfd_vmid = 8;
> +
> +	/* Reserve the last VMID for SPM */
> +	adev->vm_manager.spm_vmid = AMDGPU_NUM_VMID - 1;
> +

Instead of this mess we should nuke first_kfd_vmid and let amdgpu_vmid_mgr_set_vmid_mask set masks for both kernel queues and user queues.

Regards,
Christian.

>  	amdgpu_vmid_mgr_set_vmid_mask(adev,
>  				      GENMASK(adev->vm_manager.first_kfd_vmid - 1, 1),
>  				      false);

