Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D39A3C54791
	for <amd-gfx@archiver.kernel.org>; Mon, 11 Mar 2024 02:56:02 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3896210E0AD;
	Mon, 11 Mar 2024 02:56:02 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="xw+4GgMB";
	dkim-atps=neutral
Received: from NAM02-BN1-obe.outbound.protection.outlook.com
 (mail-bn1nam02on2058.outbound.protection.outlook.com [40.107.212.58])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 58C7810E0AD
 for <amd-gfx@lists.freedesktop.org>; Mon, 11 Mar 2024 02:56:01 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GXjm4rLvWJpBVOuoC7RvM2TOLA9hv3HoaSpcingI6Fn8w2R5qh9KNo7VHa4pWLyvYkSw25NJtoxv/7f3eicboSlv9fbPnrMyoR1VCtfMfFFymjMmJ9SDSFhOslCRIbyn5gX2BkHsdZ/MUeQ2d+39D2PfJAw1qNzWeYsmKapG8yYHL9lJtnTtrFvWIbiErWfKWcSnz4mx0EZ1uRhMROoGq3+TiafS5MySOM6GWNxZa7XwCpgxHGzjBrLI7mRnohxvhzB5LcFXbr+jRFavrFMgtyQ4T0e92JnpF4A4+qqeEEDnb84yN8XxM4alehj85IIGj3OpkkjYeTMeHEV85pGBAQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=i9syExFaGvRUpLhAMaMGYR5Y9IQoew7FQalbYBM4BH0=;
 b=jvg+WCQnzAi9edmnNTDgWpw3xGGBkF0uD3NPE2AcsLuZz6rrnr5/OFOtTjfQ43vZnqWMCFvkx+Xfcc6RQk9M9KBpsPj/6Rxm3qQ+9gfQLPv2/YooSs73yntR1O9SIpCEQh3t1niw2t90YVEvXo6YSGBhVT+Q5p4F9WrICtAsvKx6k9Lszd05u6rDAAdw/pHhZf5xRq8x1qbyoLe8s4Qjgh+7afC6YKSz2FXolTUSMxTLa+DfhAMeHxaa5ijj9g1Vhc945C/kN8q4DM40hSsP0+j9GT5T1LrHiU1ii/AqG0pZd1SIDd6Ep8ynsoa3+mVOJDIJ/sYL+CblKUX3youThQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=i9syExFaGvRUpLhAMaMGYR5Y9IQoew7FQalbYBM4BH0=;
 b=xw+4GgMBTG8Heee1zzhWEOYY1JfRbsV9p7hslTPHtQBUEnMiK3qk1oRwiI3Pr+VNNl5q/5CKf9o+nx/lbFEYYzxMqXxekiyd/6i5dAMpVGC9fHJAXvE818xTXeLbNdVYJDQyL0tmsVBtcz2qC99YmCCjrRR/aiV4F0Kv3+B25BA=
Received: from BN9PR12MB5257.namprd12.prod.outlook.com (2603:10b6:408:11e::16)
 by LV3PR12MB9094.namprd12.prod.outlook.com (2603:10b6:408:19e::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7362.35; Mon, 11 Mar
 2024 02:55:56 +0000
Received: from BN9PR12MB5257.namprd12.prod.outlook.com
 ([fe80::74e4:f50f:79af:c996]) by BN9PR12MB5257.namprd12.prod.outlook.com
 ([fe80::74e4:f50f:79af:c996%7]) with mapi id 15.20.7362.035; Mon, 11 Mar 2024
 02:55:56 +0000
From: "Zhang, Hawking" <Hawking.Zhang@amd.com>
To: "Zhou1, Tao" <Tao.Zhou1@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH 1/5] drm/amdgpu: add new bit definitions for GC 9.0
 PROTECTION_FAULT_STATUS
Thread-Topic: [PATCH 1/5] drm/amdgpu: add new bit definitions for GC 9.0
 PROTECTION_FAULT_STATUS
Thread-Index: AQHaZjGv0jr05iN670uSd44j5NjxBLEx778AgAAC4VA=
Date: Mon, 11 Mar 2024 02:55:56 +0000
Message-ID: <BN9PR12MB5257A57CA866F3BDC9AECD4DFC242@BN9PR12MB5257.namprd12.prod.outlook.com>
References: <20240223082352.323583-1-tao.zhou1@amd.com>
 <PH7PR12MB87967F9EAA8AE4B8EC76E212B0242@PH7PR12MB8796.namprd12.prod.outlook.com>
In-Reply-To: <PH7PR12MB87967F9EAA8AE4B8EC76E212B0242@PH7PR12MB8796.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=57bf6600-26c7-490a-8e7a-18551d7f8ede;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=0;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2024-03-11T02:44:24Z;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR12MB5257:EE_|LV3PR12MB9094:EE_
x-ms-office365-filtering-correlation-id: b959473b-1610-4069-3f11-08dc4176c631
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: fwpns2irDl6dHPJ2QYbkfWzK1vocipTevBdWTIUG9o/7DbGZDxhv3Fcsdvj4STVH93llPF1v7Kmdn0lPbKFEuD1TC2oFVBcDMx82Z2QXaaEGMDpnD3CZxaTDpfh2nK5tCVMSFkq4Lo9mnOPdblE4zqbT7wHyLeg0LuMDPVp4ZB0aYPLWomAhXNt7pcZKzLmLWMSXmWPygm/LVPqPascYfGdGaZ4rq+pScPSW4mvJXpMz9HxNVGqo2UrlXB6pYQqJhtfdOoX1ZJkg5tI6b+tAasFv1YfJ+J9KfsWn/VlOQvqzSGvzvSc/im8V70yLVULFl/4+XzubeSNe1QYIs72zryVTmbEJS8iTAcM2WHTlJZpL1OZG7F6FlA7myjOnMK/X1LFy3gzXi6I8LOqNphRNxbhFl9utcgv9jIWNfa7ckLuS7GS0LhgQ5NmhlW5vGN1LW1qrh3FH8afK62oR2BPzsGPDAR2nyDdujYwMLWQUYjs+Avn/uUqY2oGG3zWY7yVZnwHKDDS+lweFICx0p9/4EzH4lee1sCe+DQ2cK+ChkVsbLLkw2YbjAKb3A2ODYstrb1xLhpoyEHxOPaCrPQCYSUyaHLyI7+8eypA6pfoBbdOUJnTd1wze5ZEaebhWzdBf+QM7r34RsGH3q8HFc+VjDhWbmZW4QUZvRLF3uxEsdJpnlZNfEHf/EyNspJqgkiZwLUGoovTid7IYjd+Xe2CJaOMs3zoGW5BrKlGnTaR2HnI=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5257.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(376005)(1800799015)(38070700009); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?uFxkoH8sUkqAPfvknBjdHJkw5KLHKbl0E2qXuVykBfXF6G7GVS3uUAPP63TH?=
 =?us-ascii?Q?B50uttHerjxGPJv0hIfdVm5jmjtp654vIczKoYOuMIFXVHSuHsmpEWK0qvvW?=
 =?us-ascii?Q?00ultauVKc3FKJMg32G6ZjS3VvD44FwE1e+1TIs8Hu+Ikt4N2wHhV3Xl/x+K?=
 =?us-ascii?Q?5RcCTZn67H2b/xLfVP/ASch/uR0BURgY/DCOoA5I11jr8l2tluhEW7ackZNk?=
 =?us-ascii?Q?sM0zRNQvT6kZzNs306g2R9/fUFLIxQl2BpXX2qqeShMUYLeU0alUEgsfj+lK?=
 =?us-ascii?Q?oQGpLiidbOa+uTBjvFg/WRsNi4UidLhpOIP6OKnnkIS0TRlLAqrtHKTCXOUC?=
 =?us-ascii?Q?EumCT3PUi0t3T/dph6fTqE+D6RyZlmIC1R8glQqD21rwp9veDJgbzMOI1R77?=
 =?us-ascii?Q?GLuO3MIlSoHKUi14aAT3kqtGVGR3EWpluZvI0RZsr+N9Mi9Aq7QoxgaR+T/J?=
 =?us-ascii?Q?ajaRjnRYq4QraDTpBT24+SDgxNLUsL6noQPVXY4ViZfpE6AHNlU9sUA4clgq?=
 =?us-ascii?Q?7txlC8rXbCDkxFV8KG+5XISttcZNgoBIc/Md8SQd+45aRdymk9k1XBydxwh0?=
 =?us-ascii?Q?FAy+QUw+wgJCdW3f6w65/Q/2y6PzKbn89rBtKzJQlSS2UxxnHMgsyjnr8P9E?=
 =?us-ascii?Q?kW/kIofyGvslSH8ugnRlpt7jwU5/MOGfe3/zL46z0vqKxxacKF8gtukQ+moV?=
 =?us-ascii?Q?4kVqOwLfdZnQdQ7Be+3hcDbAcke/kH5nKegPwaEua+Ie4j701Rk0EdB3Z5dc?=
 =?us-ascii?Q?DShdSo0+5M1pXY7dRox7uJ37E2uZWjarp8heUckLEPg6B8KtJY0dzGYqhNkX?=
 =?us-ascii?Q?uy2nGHw7JzBV5f5doVJnTh5k9U63Y/X9ocg1O/MjrFuZjk35sNzQCJd4HHr1?=
 =?us-ascii?Q?j8lt67bYINOEX8/prxwsxNlWOwvHq9qsHf6zIoFvL+F5J2G99dFWN5pOlG9D?=
 =?us-ascii?Q?l992Kw0PvQtmqpKzAaC0QnIvpEfQ9VMdmR9qCQ17B6oSWHhoTKGdCRbdEXKM?=
 =?us-ascii?Q?4EB+WFlNjClrEhTIZEfCiau3OFfVS2lSPTS8GGw/Q3yvAQp+FZ93LGjz1IYl?=
 =?us-ascii?Q?jnZj5/qLMJThgRrd3x16d97bNaKGLxjeNzloZJaxGllhlM4HpYzGaCZYp/Po?=
 =?us-ascii?Q?G2O+9p04fee20AG86zo69lLndqi25NozY32DRhEtvVG9RTdQFFsKNZwvg1ly?=
 =?us-ascii?Q?pFPQpCRPqGZM6ylb4XT8T2mJOS5wYJFna5o+zWLoB+tc28JTaRqo0UVMtEfx?=
 =?us-ascii?Q?bpyMqa4CqfEX0/IJ+V7k3EvYydw/rNM2QwMFiwNG5fEU0wS02ZA1DW/poDFQ?=
 =?us-ascii?Q?Nlq/DTY4cm9yY94/OhMWgKYJKbag0qKheHQ8K1zAdZkJrXEsRRYPoRo8ssLY?=
 =?us-ascii?Q?+yQj20iAQ3xHRiiAxFjGfl+vDbIJuyPRGyHcA2aX4YHzBYqWSUfQv/nmfxUq?=
 =?us-ascii?Q?AYYOSTjtAOtM0+uvJtF4i9H403vULRKAEpGt9KsmxOg34GyauLdtywJ6WeEd?=
 =?us-ascii?Q?EXyJxY4+ufxXHiZ0VKwbNVRYTB49fT7ElZGuiJQIYXFVo1DF6/IY2TDFiwE2?=
 =?us-ascii?Q?EJdhKpGUq4g8mRmU5jE=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5257.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b959473b-1610-4069-3f11-08dc4176c631
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Mar 2024 02:55:56.6734 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: l/QiMCaopNiz/XuCMNrhHqk+07f7aG/ra8Xiwk1imn3m/X4PMM0LScLK4hiZ1tweo3F97yNH812OAKZpQsO4Gg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR12MB9094
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

[AMD Official Use Only - General]

Series is

Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>

Regards,
Hawking
-----Original Message-----
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Zhou1, T=
ao
Sent: Monday, March 11, 2024 10:45
To: amd-gfx@lists.freedesktop.org
Subject: RE: [PATCH 1/5] drm/amdgpu: add new bit definitions for GC 9.0 PRO=
TECTION_FAULT_STATUS

[AMD Official Use Only - General]

[AMD Official Use Only - General]

Ping for the series...

> -----Original Message-----
> From: Zhou1, Tao <Tao.Zhou1@amd.com>
> Sent: Friday, February 23, 2024 4:24 PM
> To: amd-gfx@lists.freedesktop.org
> Cc: Zhou1, Tao <Tao.Zhou1@amd.com>
> Subject: [PATCH 1/5] drm/amdgpu: add new bit definitions for GC 9.0
> PROTECTION_FAULT_STATUS
>
> Add UCE and FED bit definitions.
>
> Signed-off-by: Tao Zhou <tao.zhou1@amd.com>
> ---
>  drivers/gpu/drm/amd/include/asic_reg/gc/gc_9_0_sh_mask.h | 4 ++++
>  1 file changed, 4 insertions(+)
>
> diff --git a/drivers/gpu/drm/amd/include/asic_reg/gc/gc_9_0_sh_mask.h
> b/drivers/gpu/drm/amd/include/asic_reg/gc/gc_9_0_sh_mask.h
> index efc16ddf274a..2dfa0e5b1aa3 100644
> --- a/drivers/gpu/drm/amd/include/asic_reg/gc/gc_9_0_sh_mask.h
> +++ b/drivers/gpu/drm/amd/include/asic_reg/gc/gc_9_0_sh_mask.h
> @@ -6822,6 +6822,8 @@
>  #define VM_L2_PROTECTION_FAULT_STATUS__VMID__SHIFT
> 0x14
>  #define VM_L2_PROTECTION_FAULT_STATUS__VF__SHIFT
> 0x18
>  #define VM_L2_PROTECTION_FAULT_STATUS__VFID__SHIFT
> 0x19
> +#define VM_L2_PROTECTION_FAULT_STATUS__UCE__SHIFT
> 0x1d
> +#define VM_L2_PROTECTION_FAULT_STATUS__FED__SHIFT
> 0x1e
>  #define VM_L2_PROTECTION_FAULT_STATUS__MORE_FAULTS_MASK
> 0x00000001L
>  #define VM_L2_PROTECTION_FAULT_STATUS__WALKER_ERROR_MASK
> 0x0000000EL
>  #define VM_L2_PROTECTION_FAULT_STATUS__PERMISSION_FAULTS_MASK
> 0x000000F0L
> @@ -6832,6 +6834,8 @@
>  #define VM_L2_PROTECTION_FAULT_STATUS__VMID_MASK
> 0x00F00000L
>  #define VM_L2_PROTECTION_FAULT_STATUS__VF_MASK
> 0x01000000L
>  #define VM_L2_PROTECTION_FAULT_STATUS__VFID_MASK
> 0x1E000000L
> +#define VM_L2_PROTECTION_FAULT_STATUS__UCE_MASK
> 0x20000000L
> +#define VM_L2_PROTECTION_FAULT_STATUS__FED_MASK
> 0x40000000L
>  //VM_L2_PROTECTION_FAULT_ADDR_LO32
>  #define
> VM_L2_PROTECTION_FAULT_ADDR_LO32__LOGICAL_PAGE_ADDR_LO32__SHIF
> T                                       0x0
>  #define
> VM_L2_PROTECTION_FAULT_ADDR_LO32__LOGICAL_PAGE_ADDR_LO32_MASK
> 0xFFFFFFFFL
> --
> 2.34.1

