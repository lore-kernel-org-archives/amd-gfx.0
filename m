Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9F7DC10A62C0
	for <amd-gfx@archiver.kernel.org>; Thu, 26 Mar 2026 12:54:51 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 38B6510E165;
	Thu, 26 Mar 2026 12:54:51 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Qr8REaR6";
	dkim-atps=neutral
Received: from MW6PR02CU001.outbound.protection.outlook.com
 (mail-westus2azon11012038.outbound.protection.outlook.com [52.101.48.38])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 75E8F10E165
 for <amd-gfx@lists.freedesktop.org>; Thu, 26 Mar 2026 12:54:45 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VC1+4nnhnO5zFa13RGVu6mFYloy7nydUpe+8xEJs9sDEH+9mYVcE0G/P6+LPlZuaWTYHP8NyqDWzjWZZUZj9xC9Odf8E2FJ/gNXesXCJnt7zk5TlPTVYmo5c10rdA7iFZ8SBz/1GQcNn0tLGun5z6Ag7vyP6cK72ttjvddNGhmBmrOdRC7yhagg8UpTk9vw6ZbVP7LI50mwOF0MyIqIxd4sv9iusUrqgU+eNoB3pz4qba2WfUdvkQTvDIIxSsHAkvyonaZQ/w3Txnh21D5Oo6tg7Xpa1trXeK6TTywHtvtOGX4xBe2NReu8ablgvYoYv9HMO+ZjmGfIytolU8rk75A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hzF9VBBF7toU/nlQxZ7Bn823/iM2ZIqYSjXHE8JdYX0=;
 b=Z0eKQSv4ZZKN7XpXXu53ZXMk13+fcFcWmgwrtCiLipMt9ya3ewcspbuDpH+HKrIwTAA7HkUzqRjFvJ5OrcqnkfEl249L+TNgoxxP6ANskf9nSg0gi4nyDrulXR6s3QKmoYSn0nuzJTorJG1/fhdAZCdk20zak5KhbLKgYGTufddKE0+yxFVfbAJ2+8obSlv61jqid+NT0YQVTYi+BglnZAClAgi5DW6vyQ6NWBEdbZuu+lts8Dr1YAh1sr6/HragLxstDT+iszxo6khLrAJusIT4a+JQN2kbmVU/R6Zjda4/ZI1udBDYTjNCAem3X0DDiJpsp+Et/+vDU+SX/YgdvQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hzF9VBBF7toU/nlQxZ7Bn823/iM2ZIqYSjXHE8JdYX0=;
 b=Qr8REaR6JmLQ8833zPXYtrFuhqcl6f21Azb6lTe7GKF6UN7v6CtpgKZK7p84k9lnym2qzdNWYhhkz3NuKuad9YX5zsOQzkNwAbM/C7Mv9HZyTu3ZCMKc68vXPdiCn0ipbvXAqB1sxjRZmOHXYOvfTVCN1LmZI+ihXetFGaMv4xg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by PH8PR12MB7254.namprd12.prod.outlook.com (2603:10b6:510:225::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.20; Thu, 26 Mar
 2026 12:54:41 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c%5]) with mapi id 15.20.9769.006; Thu, 26 Mar 2026
 12:54:41 +0000
Message-ID: <3d933ac4-e1f2-4304-97d7-706b1f85c4df@amd.com>
Date: Thu, 26 Mar 2026 13:54:37 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/4] drm/amdgpu: Add bounds checking to
 ib_{get,set}_value
To: Benjamin Cheng <benjamin.cheng@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>, amd-gfx@lists.freedesktop.org
Cc: Leo Liu <leo.liu@amd.com>, Ruijing Dong <ruijing.dong@amd.com>,
 "David (Ming Qiang) Wu" <David.Wu3@amd.com>
References: <20260326122918.3486416-2-benjamin.cheng@amd.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20260326122918.3486416-2-benjamin.cheng@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR4P281CA0248.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:f5::14) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|PH8PR12MB7254:EE_
X-MS-Office365-Filtering-Correlation-Id: 8b86c668-b023-4e54-a7e2-08de8b36d874
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|376014|1800799024|56012099003|22082099003|18002099003; 
X-Microsoft-Antispam-Message-Info: /24knhQpdwla6rkj27PELAi9F7LUJX9jh7TpwCP+McvoZ3opVSv4+zq/TxhD9AZ7dQJpHEyUg9p7KwXY8VqN7X5idL0W1ubpJtesAHGRsx3bzGqzBxt3d+BRTPCuirfFOxSn8UbpfwGUUDcumCAZPWg8GnHgDLo0BCMnj36qI60AxjeGEtfY2W+oEm15gEUTqbdRMVnleQkX84aR3/rNi1tH8nGgCkMBqJM1kOA7IYnl7vDacywLNKHUaGsJ1FUM+jLTP7zAZ35bJIhtJmT5grZsXr8kbwIDeLSwjW5YhKdwt9hDzfrhwrvjk/vUs+AyIia3JeMFAVR0Zj+5GWzutkP0jYx9mX8RyFESMRSvDzClmSmBYzTTzi53wa6FBwFcDKiXutR28njJNq4+AZt2SMHvRX9DkoFzLuk+dOjGS0Mwk9b7do8pc3KdxfJJNHH64W5vAbAfcsW9R0yqL4j88IHnpa/dla3bb9CgkEqnjXJy3TI55wKTTof8L4OuZ3fnSh3W6C+x9RZ28KEF2wyJdx01wKZlcwoWdnS5ERu1OFwMAvn7hwibXwvTz8Yrq9pFJHjP4ysUg5B1sAlcgmKhg7aJIPQYrnm2cDB8FHeT5c/DwLznySfZUlHSomr0iZj9FO8Otu+eqlZvDoqpCWiLffsyQ5WgU0Bt+etVdEMXR0uXDlIwtazPVyLBr7mC6nPisYn0RFnZmUduzG7Q5v3AG67GwWRDd0hMNJSmkuc9t/s=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(56012099003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZWs5K05XMmdLVk1abEZsY0FFckhINnU3bTNyS05RalBCckF4eUlRNUhrNkRY?=
 =?utf-8?B?bDJZd0wwb0I3MEtRZEg2TS8vcDVMMUJqczRDRlRJV1BwWGIyMTA5TUpCK2lS?=
 =?utf-8?B?bjNJdVdrdEt0bmpUSEp6TkRlN1R1OHBmTWgrcWNBb0h6TTZGTzU3UmhjYnJD?=
 =?utf-8?B?b0gwS0NVanVrQWMxajY3Zms4QTU0cDhEb0pFWTkyZjZyZVNUVGZSM21qejV4?=
 =?utf-8?B?WlBtZEx0VEJ1TlVkaHZqZ3Q4S2VDMGhqVm1kWVdGV3pZeTh5aXI2UWUrNjg2?=
 =?utf-8?B?UVh1ZUYvSHRuS0ZibWNNUTZGRzJrZ3hLWW8wdWdsYmRKZWhrWU5XVTExaU1Z?=
 =?utf-8?B?NHpmK2I1b0JvMksvdDlJOEozWVUwS3I5b3lpUWRyYm5YZk82QWZncWNncm5J?=
 =?utf-8?B?VVZ5YnRwaUVGV1ZnWVRIQWJKTXdNVi9Za1ZsMHlaV0I0dlJybWcwN1lPdmp6?=
 =?utf-8?B?N1UrVkUxZWl6NDc4bHFEbWJhUm5CU1FDNXo1c1lVLzk3RVlyeENkYmZJSkZm?=
 =?utf-8?B?UTJMbkJHRXJXdjNsdEVxQytvMEhpNFlUMlR3RkJEQng4NFNtc3B5UHBDVkpN?=
 =?utf-8?B?Sk1lMnZnWW15TFQxZ3lDdjdmU3JwTHE5c0tyMVpQejdKWVo0eldFNXhhNGZ3?=
 =?utf-8?B?NEtrNk9lN3BwWm5ONzE5WFoxK1B4dmhuanhmTElTL1RicDNuUzJ2WXdHaC9T?=
 =?utf-8?B?ZDNUdURxbENsaTI4bnhyUFplVm5LL1NBRzErc29PV2NaSUJxSEhBWHJ2cEFL?=
 =?utf-8?B?Wm80dTRFbDUwYUErdmp6NkJTOHdwcWZZUzFSSjFsRjdwcEN2RGVXc3o1NE1y?=
 =?utf-8?B?RS9PdUx1T29mRUhobWo0ME9ZVlZIb3F1TklOZVhKQytFancrTC9uWUhsbG8v?=
 =?utf-8?B?Y3piNmMralU1TnIrREZmMCtsK2hBQzBTQnNDNVEvdjNDemJlNlBHV24ybG1L?=
 =?utf-8?B?MXJlb3A0T0NKcnhiRk90MHFGamltemV4MzFjMjYwVnpTanA4VmFheWlQZ2U2?=
 =?utf-8?B?WmdzcmhERkVLZUtEZEZxL0JPd3NOc1JzUDlEN2hNNVFiL0xlMjdtRm91N3Uy?=
 =?utf-8?B?ZmxWaU9WM2VpWEo1YllkTTBEMmlzOG5IWURQRE1QR3pScWFXMGVUVFhOMzNZ?=
 =?utf-8?B?TzJ4Q0d0cyt5QUd4WE1Kdi81OTh6U0p5NWpmRDdaWGkvWXJpMVZDY2kvaCtu?=
 =?utf-8?B?WWpOelViN3pOUk1FVW9QMG5wb0MzTlpSMUhuZGVoYUgwMVJuSGhxUkdHOWEx?=
 =?utf-8?B?NUdyWXFIOExOQ2J0cFNKRTY3b2RiTSs2OGxEdFpiZGthNFZvaytad3RabEZD?=
 =?utf-8?B?dmJEakJtY1huZTZNbHBhSHZaOXhSTXZxd0FVZzdXQ2tSYWx6QlBFTVFnOWh2?=
 =?utf-8?B?dXJQeThNK0F4azdIRmh0Y0ptNFg2WUhjc0NHbVdhbGUwaHlNd05wUkU2Qm1q?=
 =?utf-8?B?OHY4dXhHYjV6UE1nMTZ2UDJoMHBGTXZNUlBVZWZ2WFhNMDNtSVI2YUpJNVAx?=
 =?utf-8?B?QzZtSWlpMzB5Nmh2TWY1TDAxc0NoKzZkZ1JLMk44dk4vQkUyc3lDMUEzRk9n?=
 =?utf-8?B?NFczb012SklidEpyVm15Qk1vd0JuZkZYQTJORHJmbDloT0trRE12SEptUXAv?=
 =?utf-8?B?bUd3Z1N2RFhBbVIrUE5zK1hQRW5PUVNDZjlqRUwyUDR3dkZxYWdnRUFBdGtC?=
 =?utf-8?B?NWxLeVhlbjhzdXBPdS9DSjBEb2dUZlZEdVA5NjhNMUpkVGVhVkJSUG9DNllO?=
 =?utf-8?B?dUVmV0pzRm1BM3hiZ2dKNTlvR3UzOFVmelpyWTA0enA2QWhINlJNNmoyMHNS?=
 =?utf-8?B?RFNlVk85UTZqVzdXdWN5L3VGQTBvcUtqRGVIUVNyTUNpUkNaWUxaaTJIZS9l?=
 =?utf-8?B?R21vSFpSK1N5VXhnUjFIMmkzOCt0NW9LcXJHT3IzLzRwd2UvZzVSMjdDUGgx?=
 =?utf-8?B?ZmZPYkVNZEhCaUVKek56SlJPS0l4Ym05REZsMGJsTWlCQ0t4c3BnT0xLbG9P?=
 =?utf-8?B?bjVUclBtK0dFVEZNRXZZZHBJd1U5ZzRoaXprN0Y3bStFcXNkM3dWNzZqZGJw?=
 =?utf-8?B?OW9PVWxjcFlLYTN0YkR3cTUvaUhJYkZBQ2JmUEVObW8wZjdhQVU3SGRIaUhr?=
 =?utf-8?B?Z0dYQ216UGNSblRJTVFZaE9sdll0SUUyaGo3NUVUd0wzd3R3S0dmOHl3K0Nl?=
 =?utf-8?B?b2ZBZmhEcGtMZXJ2aXBMR2phdks1SSs3K25wK0VVTkxjS2dXbzhsS0c5bTZD?=
 =?utf-8?B?RHlqSnRGdzJUd3p5QXNDNStlcGVpQjh6RUxacURZRnFUdzVwV2RYMEc0aVV5?=
 =?utf-8?Q?BxVB2auuygYE0MeCLZ?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8b86c668-b023-4e54-a7e2-08de8b36d874
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Mar 2026 12:54:41.0483 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: k51TaY6HB9mWEDCLfP5MlL/qT4P3/Jy/TIDbZaa2e2HvzVuQHz7+4j6oiJ+e6lEB
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB7254
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

On 3/26/26 13:29, Benjamin Cheng wrote:
> The uvd/vce/vcn code accesses the IB at predefined offsets without
> checking that the IB is large enough. Check the bounds here. The caller
> is responsible for making sure it can handle arbitrary return values.
> 
> Also make the idx a uint32_t to prevent overflows causing the condition
> to fail.
> 
> Signed-off-by: Benjamin Cheng <benjamin.cheng@amd.com>

Patches #1-#3 are Reviewed-by: Christian König <christian.koenig@amd.com>

Patch #4 is Acked-by: Christian König <christian.koenig@amd.com>

> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h | 11 +++++++----
>  1 file changed, 7 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
> index ce5af137ee40..715c9e43e13a 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
> @@ -559,15 +559,18 @@ void amdgpu_debugfs_ring_init(struct amdgpu_device *adev,
>  
>  int amdgpu_ring_init_mqd(struct amdgpu_ring *ring);
>  
> -static inline u32 amdgpu_ib_get_value(struct amdgpu_ib *ib, int idx)
> +static inline u32 amdgpu_ib_get_value(struct amdgpu_ib *ib, uint32_t idx)
>  {
> -	return ib->ptr[idx];
> +	if (idx < ib->length_dw)
> +		return ib->ptr[idx];
> +	return 0;
>  }
>  
> -static inline void amdgpu_ib_set_value(struct amdgpu_ib *ib, int idx,
> +static inline void amdgpu_ib_set_value(struct amdgpu_ib *ib, uint32_t idx,
>  				       uint32_t value)
>  {
> -	ib->ptr[idx] = value;
> +	if (idx < ib->length_dw)
> +		ib->ptr[idx] = value;
>  }
>  
>  int amdgpu_ib_get(struct amdgpu_device *adev, struct amdgpu_vm *vm,

