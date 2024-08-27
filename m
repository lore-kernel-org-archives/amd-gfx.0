Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A86E0C5320E
	for <amd-gfx@archiver.kernel.org>; Tue, 27 Aug 2024 08:02:08 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3DA8F10E045;
	Tue, 27 Aug 2024 08:02:08 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Qw3GsqRu";
	dkim-atps=neutral
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2076.outbound.protection.outlook.com [40.107.236.76])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 487E910E045
 for <amd-gfx@lists.freedesktop.org>; Tue, 27 Aug 2024 08:02:06 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LV2QvvoKMJjIrTDBLZCAJqBvt45teHFdcdlLsKC6zhKljw9P8R0UGgJm1idGczKTmPkVYXHphj9D0OBWvQuQpp8BLmLGlX+P7jQ3PajZZ22xPCHKS+Lbd+qa/Ju97Ok//5A9R8+7o4O1GWs/JI1W8ej4888dTwT3onAZVFM+pPco0vkOhHrHxSKE5imrpzm9CvVZeD8+nxvg30Ry9v7g7p1azvhGdTOdhWMZtFfOV4MizqDbju76LCggE6nckRHVPmJGfrq2r3lcehh1725l8dsh4TjcTro96p/ZNEm56clbgEmY7gjrX9vGn9BWo6abOEDNCvJpyagPnLZvoEiheA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MOlSvX6YdtIF9ICXnMjYAaHG4mzRfYkX/cj4Qz/HwCo=;
 b=RBi+Pa+MK1FPJ4zXB9vAxIsQEmc4SE0xNQ6zCSe9AW1chip44eCH7AzES80w0TpDMVkFGbVZN7IuJb8oqMB/ByndXudAM3XJQBrUsvAQSTAg5zbVCJ3+lZOVKeHpXfsBWv4ZoRNusoa8hvnPR0Huxdd/EfwcNQ/Kzl7irtYFSYVp8SnKYuQxgbRHyrSzt2TR/n0/qIFazV3rvtxHI2aKoR8CinV9O9qLS84pvHPUW2i8QVHcyEqpr38E6urTdC2MWe9fqqnbxphKPUwDy7pS8VjOjalNoAzdTUhFS1BYzUFR4D8YVU7qGkaLv4vhFOgEjy+EUJrt3xVROQ7LXJO8Kw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MOlSvX6YdtIF9ICXnMjYAaHG4mzRfYkX/cj4Qz/HwCo=;
 b=Qw3GsqRu8I13f1peh8QFhzhAuCC1YBrk1FUctEvM7mXgDKyFN765dTDT9o967z6vVfJEUUP4sDr8RcDRNiWOzpl8j1m8RHiNQ4Yn0ryAYTM3vjVdeJPYvIONgnw2hHE/G1tmVNUaWpfrrijqQcZd9Pr8SXZqXYH7yUzGHMgxHL0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS0PR12MB7804.namprd12.prod.outlook.com (2603:10b6:8:142::5) by
 CH3PR12MB8258.namprd12.prod.outlook.com (2603:10b6:610:128::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.25; Tue, 27 Aug
 2024 08:02:03 +0000
Received: from DS0PR12MB7804.namprd12.prod.outlook.com
 ([fe80::8327:d71a:ce21:a290]) by DS0PR12MB7804.namprd12.prod.outlook.com
 ([fe80::8327:d71a:ce21:a290%2]) with mapi id 15.20.7897.021; Tue, 27 Aug 2024
 08:02:02 +0000
Message-ID: <88c6d10b-fc2a-4e63-900a-c9ff00972028@amd.com>
Date: Tue, 27 Aug 2024 13:31:54 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] drm/amdgpu/gfx9.4.3: Implement compute pipe reset
To: Prike Liang <Prike.Liang@amd.com>, amd-gfx@lists.freedesktop.org
Cc: Alexander.Deucher@amd.com, Le.Ma@amd.com
References: <20240822093821.2846207-1-Prike.Liang@amd.com>
Content-Language: en-US
From: "Lazar, Lijo" <lijo.lazar@amd.com>
In-Reply-To: <20240822093821.2846207-1-Prike.Liang@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN2PR01CA0180.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:26::35) To DS0PR12MB7804.namprd12.prod.outlook.com
 (2603:10b6:8:142::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB7804:EE_|CH3PR12MB8258:EE_
X-MS-Office365-Filtering-Correlation-Id: 7d7b22b3-0e55-44e2-308a-08dcc66e88ca
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?S2FxUkttYnlBc2w5Z3BUNEhTdkhlNWhMZDQvTHM1L0lFeEZuakJhUWdJbEY2?=
 =?utf-8?B?anpGVmgvOHZncVVHUG9BVTdtMTV3UWhFcHdHcjVHT1JMOTBlOGJ1b2VvNk1w?=
 =?utf-8?B?OGhwVVZvUVBCQnRYcTJSVXp2YkFaZ0RWZ1JLSkFaUzl5andQeE9VOUlxUXQy?=
 =?utf-8?B?aEZYU2ROcUlUa24zbTk0eGR5ZlA3djY4MWtHb3g0Q1pyWUhKREgydFFxUVRV?=
 =?utf-8?B?QngweEpmdFpWMTBadnd0WFBONGlMWTlTRk1VTThJb05ocUloZzlPeENjTmUr?=
 =?utf-8?B?RzFtZVhVTXpBKzRnWU9waFFOazVrWHd6TklNaGV1ZWpmZGZhaVdic1FrVnkw?=
 =?utf-8?B?TkgwUFlFditTQkF1YWRCUmN0d0dlUEFNRjBxY1gycm1QTllxYzkzSVdyaVNk?=
 =?utf-8?B?K0R3czBWMjRoRnRacll4NkFTRnlkNHlPdktEbjVXRmFQL0p6Y05nbTFYU0h4?=
 =?utf-8?B?WUtRNlMvL3lVRklNYmRtVjdsK1BrbW4zNWM1SWxJVHFmNDZ1eDVYMEh4Qitz?=
 =?utf-8?B?OEdaZmJNaVJpazRGR2pMNVF2clJ6SUhEVEFhWlVKQnJYV2NkbURiaWpRYjJo?=
 =?utf-8?B?NXE2SDl1SEE3eS9OR1pXTGN1RXdKSHBpZ0srV2srQkZITDRJOWRNSDBiRUk2?=
 =?utf-8?B?NngxbmVTRzc4SWxJTkI1RUlxcmZDZEtIaW16RVMwM210YjZHYzZqT0VicDdJ?=
 =?utf-8?B?RFZkVG5VdDNmL1hlY2F0ZEJWeEswNWJMTGhHcTFhbEEyTGprbERnRjQyN2VG?=
 =?utf-8?B?cElOM2t4dWhEVnA3cjNNUnE1S0VXbEFqeVNNTnMwM2M5T3FrSk5mQUdMcG41?=
 =?utf-8?B?Q1FoeGJVaHUxdDEwTXZhMFYrbHUvaE9qblVtL2xJaUFjNXdubkFtdTNLVnFV?=
 =?utf-8?B?Zjd5c0txRlVsYzhQbzNpR2tYMFU5ejlEMXdtR3cyR1NLVzR2VTA5Q3N3ZURR?=
 =?utf-8?B?cW96enJST2d2a3hLejJlcG1hdkNXQ1NJczlzbE0xNFJLVHlzZ3lqNUc0RTNO?=
 =?utf-8?B?RXhneXhYZjZQVjVFdnJHVGVwbDF3Z2ExWVFXVnp3ei82ODREbnh2MEd5cENi?=
 =?utf-8?B?dlhFTVEvRVFhdEpYRE9VWnZSNjVxaWZpVk1saU5UUXpTT1J3aXE3M1JTNWFE?=
 =?utf-8?B?SERQalBGMHdCV2xDRXR1VXJNa2NGTCtxekJJWjdRMllUNzJKcGRIR3p4bnRh?=
 =?utf-8?B?bnc3Um1ZcmQ0WlU5R0YxaTRoenlNVVpYc2FVcnlKY1VmYXlRK1FhV2lQWDRw?=
 =?utf-8?B?TEc4NC9VODI5UTNmNk1yWXFxMVA0Ym1LeE5FWnhTbU9TbVoxcDA4UzA1U0NQ?=
 =?utf-8?B?bllRcDNEV0c5ay9WSjRRem9UNCtod1VQNkNnazJVd2IrZDZhekx0WFY1a2g3?=
 =?utf-8?B?WVc0WVl5ZVRmVGxzVGFjRXBLbEFvek9qdUtReG96dUxmdThPeStFUTd3TGNk?=
 =?utf-8?B?SW50WjFWMUV0TUNLQTNnQXZwR1Fnc3BqVWppMmhLSUduSFl6d2lkTDloZFBH?=
 =?utf-8?B?SzRkN0poUWRmcDBPcDAxOWN2SW1CS1NPR2VRczYwUWhrYzBKeGlkVHRUSjVD?=
 =?utf-8?B?eXoyUyt1U0t1b3orb0gzR1BRV09icEdEQUpZVk5GSkV1czU0c3FWanJLZGNT?=
 =?utf-8?B?L012UGVTdllZVjlaQWFFZEtLRTZzd3JGOXhacXhMU29kMWFpVU04M28wRnRa?=
 =?utf-8?B?V2tmckEzZnkyVnJYK3JqTzh6QkdzdS92WldBaHp1OGJEaWx5amVmdVlsN1VR?=
 =?utf-8?B?UXAvT25VTkMyS0NxSUplUExoVDEvV0lmUmtDVmRWY0RxSHAxSHBOelppVytT?=
 =?utf-8?B?RkRvaHFmTHV2UkJIck45UT09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR12MB7804.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VE9SZlQzNVBtK2JLZVorRnU3WHpCQWgvU1Bha2U0T0lCL210dC93NW0zT3g5?=
 =?utf-8?B?TWYwc044SW1BRjRlSEMzZ0plTGFSWmNsUzhQcHRISVRwcjliRW4xU3lJb08x?=
 =?utf-8?B?WmZJNDA0MEpiSncrbGJGRm5XUUgvb2I5MHhnVUE2S09aN2lISkNnSHlvZmlk?=
 =?utf-8?B?UDRNUFd4UXJ0ZTVlWjFxNmIwUHlFMlVYWmRNZlhtYjZkWnFjbDh1WXhPcGcr?=
 =?utf-8?B?U0pYZXh6QWt6ZmtpZmZxYmx4VjNXV0h0QklTWjc2NEQ0aVZXcithdUlITjV6?=
 =?utf-8?B?L0s2Q00ra3VVbGV5VlFQRXZ6KzdLejNZUmZta3pyNGxJNllaWExxODZIekx3?=
 =?utf-8?B?SElGNnNHZlhUSWZraVVFNHMzZGRvMk5xc3Z6dzFueU9ONzVrd3Z5ZEtQT0VE?=
 =?utf-8?B?SlRSeGVxeWlwQVZEbjhzdU5GTG8rZ2N0YUVLenhabWZvcDdGeGo5UnNaakNy?=
 =?utf-8?B?Wmc0MTFub2RCdGlIbXZtMTAxUGNOZ2NKYmpRTCtaR3RtRHM0aXNkS1BBS0Ni?=
 =?utf-8?B?T1JhQ21QbG5aN1UweUU0NGRROXRTL2MwUHhJZ2JBYk53QzZra054UDJxTlZl?=
 =?utf-8?B?TDYwdm9pNmt3dm9SOUtWS1JsTy9nU0JSbm1qblB1VWNxbUYxZlZtOThJNkcr?=
 =?utf-8?B?ejNyT2c2RVVSMWszclc5cXk0VXlpK2xHR2hWa0F4eWZRYnhVa0NsUHpXY0JP?=
 =?utf-8?B?enFBWHdhYzM4RXdnbGFaOVdWNFdNNGNFRkJHcTJWcjdNaG9Ua0FaakZ1djNi?=
 =?utf-8?B?WU5YSGJ4c0hVREJsVGhZWU9idDVyMXNwcE94a2xvRHowNDMvR3dzb0FJczB5?=
 =?utf-8?B?SkJ4YlkvWkVHYkVJTnlYOFp5MFZjNTY3Si95NWRJUVJXK2J0OVU0OWdCUjVy?=
 =?utf-8?B?SnVFbWx6cTd1elY3dWFUK1JBVkZuQjRnSUFNbENBMENzTDE5UmlncDBlejVp?=
 =?utf-8?B?WENrRUw2bVJOdU1pRGlFRVM1cTNXOVVpL01xdWhJbzB4Q1A1dkg4LzZVTy92?=
 =?utf-8?B?Y1dUeUUwK0hDcUVBcG9UVVBIOHNwb3VnQU1CZno4bTIwSEZ4Q2VqWFRuSkdW?=
 =?utf-8?B?SExYcGttSldGN3lBVTgvcFdRZnF3WEN6MS9tTFFOcGx1NFE1SXQ4YllBMzdV?=
 =?utf-8?B?STV0OC9hM1Rmb1JKWnBXOFNjZTR1RldHNFNZRkhvRS9BazBoa1R4NmNhdDlI?=
 =?utf-8?B?U2ZQTncya0FrOEpDbktYZUxlVWdoL1RKZCtraklvQkVSUW0xVDZ4K3B5aGI3?=
 =?utf-8?B?WmpZcE9tdUxBNWhIbi95cStsQWFyMzZtZFYzemYrTytnNkJWdmZpSzhPK25P?=
 =?utf-8?B?MUp2SC9lSGN0MDlyOXhpVUtmWmQ2RytBL0lGaEhOcmlMaDJEYXg4R1pnc0wx?=
 =?utf-8?B?RmthSnJBKzcxczBoa1EvamRTa1IzNktFWHhuV2xmZWROVHFEWU0rWUhYY1Ft?=
 =?utf-8?B?V1AvbDN5VEhKN0N6OWVMNWlOcVhiTE1UeGUzV0U3UmNJU01TcERzQlJTNXkz?=
 =?utf-8?B?Ty83OVVwaTRFU2ppN1JocGFLeHBlRW9ybnczTkVrZHkwQXJhVmcxN3Q4NEdt?=
 =?utf-8?B?N0Rnd2dwTS9MNEhGZGdxQSs2d0lsYjhsdy9TNmUwMnVqWUFzT0psa0xyc2VQ?=
 =?utf-8?B?d3FzUWtvQTAxMjd6VDF1Zkk2UjJHekk2ekRRbmVTWTUxc0dZT1pwT2dBTVJ1?=
 =?utf-8?B?T2hWTWZ3cHFPM3dwN3dNcnp0ZE81R2xOZ2ZHbjFIU3hjZm1iaE5CSDJva2lP?=
 =?utf-8?B?U0pFbE1jT2tqWEJLTXZVR3NRd001a2MrN1R3dm1RRTZDWElLUkwyWGsrM09E?=
 =?utf-8?B?dHZOdExKSFQ4SGJnQ3RnS0UzYUoxWG1kL2tmekExY2ppNnU5aGRRMytwMzV2?=
 =?utf-8?B?cFdnbS9BSHFWaWp4SXZEdTRUOUUwME9mdTh4RVkwc0tpWHhVaS93NGxGWkRK?=
 =?utf-8?B?bHRFcWhGZURXbisraVJKbzI1WnhLS0FhS2l6RlhMa21JWEpvci9qNGx2a2pY?=
 =?utf-8?B?SEtGV2xQZnVlYTBJTWFNQnQ1SWJqRFBoKzFkektvLzJxWkRucmxVb0JQQWh2?=
 =?utf-8?B?ZTg2UnlhZWxZM3MzYWZXZXZjeXNiVmpMeGMrTTVTelhZZHNzaDM0dG1JODIr?=
 =?utf-8?Q?ANAR2tR6sD2VkeGcsij8J2Utw?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7d7b22b3-0e55-44e2-308a-08dcc66e88ca
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB7804.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Aug 2024 08:02:02.7279 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: V9JfHNNblNdOpwfIzjPMKWoR9Ndvyi301tNIRrft/6cCexJcWRCF1trapx4jSKKR
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8258
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



On 8/22/2024 3:08 PM, Prike Liang wrote:
> Implement the compute pipe reset and driver will
> fallback to pipe reset when queue reset failed.
> 
> Signed-off-by: Prike Liang <Prike.Liang@amd.com>
> ---
> v3: Use the dev log and filer out the gfx9.4.4 pipe reset support.
> v2: Convert the GC logic instance to physical instance in the
>     register accessing process and use the dev_* print to specify
>     the failed device.
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h |   5 +
>  drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c | 154 +++++++++++++++++++++---
>  2 files changed, 139 insertions(+), 20 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h
> index e28c1ebfa98f..d4d74ba2bc27 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h
> @@ -143,6 +143,11 @@ struct kiq_pm4_funcs {
>  				   uint32_t queue_type, uint32_t me_id,
>  				   uint32_t pipe_id, uint32_t queue_id,
>  				   uint32_t xcc_id, uint32_t vmid);
> +	int (*kiq_reset_hw_pipe)(struct amdgpu_ring *kiq_ring,
> +				   uint32_t queue_type, uint32_t me,
> +				   uint32_t pipe, uint32_t queue,
> +				   uint32_t xcc_id);
> +
>  	/* Packet sizes */
>  	int set_resources_size;
>  	int map_queues_size;
> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c b/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
> index 2067f26d3a9d..aa0c76eed452 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
> @@ -166,6 +166,10 @@ static int gfx_v9_4_3_get_cu_info(struct amdgpu_device *adev,
>  				struct amdgpu_cu_info *cu_info);
>  static void gfx_v9_4_3_xcc_set_safe_mode(struct amdgpu_device *adev, int xcc_id);
>  static void gfx_v9_4_3_xcc_unset_safe_mode(struct amdgpu_device *adev, int xcc_id);
> +static int gfx_v9_4_3_kiq_reset_hw_pipe(struct amdgpu_ring *kiq_ring,
> +					uint32_t queue_type, uint32_t me,
> +					uint32_t pipe, uint32_t queue,
> +					uint32_t xcc_id);
>  
>  static void gfx_v9_4_3_kiq_set_resources(struct amdgpu_ring *kiq_ring,
>  				uint64_t queue_mask)
> @@ -323,6 +327,7 @@ static const struct kiq_pm4_funcs gfx_v9_4_3_kiq_pm4_funcs = {
>  	.kiq_query_status = gfx_v9_4_3_kiq_query_status,
>  	.kiq_invalidate_tlbs = gfx_v9_4_3_kiq_invalidate_tlbs,
>  	.kiq_reset_hw_queue = gfx_v9_4_3_kiq_reset_hw_queue,
> +	.kiq_reset_hw_pipe = gfx_v9_4_3_kiq_reset_hw_pipe,
>  	.set_resources_size = 8,
>  	.map_queues_size = 7,
>  	.unmap_queues_size = 6,
> @@ -3466,6 +3471,116 @@ static void gfx_v9_4_3_emit_wave_limit(struct amdgpu_ring *ring, bool enable)
>  	}
>  }
>  
> +static int gfx_v9_4_3_unmap_done(struct amdgpu_device *adev, uint32_t me,
> +				uint32_t pipe, uint32_t queue,
> +				uint32_t xcc_id)
> +{
> +	int i, r;
> +	/* make sure dequeue is complete*/
> +	gfx_v9_4_3_xcc_set_safe_mode(adev, xcc_id);
> +	mutex_lock(&adev->srbm_mutex);
> +	soc15_grbm_select(adev, me, pipe, queue, 0, GET_INST(GC, xcc_id));
> +	for (i = 0; i < adev->usec_timeout; i++) {
> +		if (!(RREG32_SOC15(GC, GET_INST(GC, xcc_id), regCP_HQD_ACTIVE) & 1))
> +			break;
> +		udelay(1);
> +	}
> +	if (i >= adev->usec_timeout)
> +		r = -ETIMEDOUT;
> +	else
> +		r = 0;
> +	soc15_grbm_select(adev, 0, 0, 0, 0, GET_INST(GC, xcc_id));
> +	mutex_unlock(&adev->srbm_mutex);
> +	gfx_v9_4_3_xcc_unset_safe_mode(adev, xcc_id);
> +
> +	return r;
> +
> +}
> +
> +static bool gfx_v9_4_3_pipe_reset_support(struct amdgpu_device *adev)
> +{
> +	/*TODO: Need check gfx9.4.4 mec fw whether supports pipe reset as well.*/
> +	if (amdgpu_ip_version(adev, GC_HWIP, 0) == IP_VERSION(9, 4, 3) &&
> +			adev->gfx.mec_fw_version >= 0x0000009b)
> +		return true;
> +	else
> +		dev_warn_once(adev->dev, "Please use the latest MEC version to see whether support pipe reset\n");
> +
> +	return false;
> +}
> +
> +static int gfx_v9_4_3_kiq_reset_hw_pipe(struct amdgpu_ring *kiq_ring,
> +					uint32_t queue_type, uint32_t me,
> +					uint32_t pipe, uint32_t queue,
> +					uint32_t xcc_id)
> +{
> +	struct amdgpu_device *adev = kiq_ring->adev;
> +	uint32_t reset_pipe, clean_pipe;
> +	int r;
> +
> +	if (!gfx_v9_4_3_pipe_reset_support(adev))
> +		return -EINVAL;
> +
> +	gfx_v9_4_3_xcc_set_safe_mode(adev, xcc_id);
> +	mutex_lock(&adev->srbm_mutex);
> +	soc15_grbm_select(adev, me, pipe, queue, 0, GET_INST(GC, xcc_id));

MEC_CNTL is not a per-queue register. So not sure if selecting this
makes sense here. The mutex may be taken so that resets for other queues
in the same XCC don't run in parallel.

> +
> +	reset_pipe = RREG32_SOC15(GC, GET_INST(GC, xcc_id), regCP_MEC_CNTL);
> +	clean_pipe = reset_pipe;

I think the saved value could be written back (skipping the SET_FIELD
steps below) as the only change that's done here is to set the
PIPEx_RESET field.

Apart from those, looks fine.

Thanks,
Lijo

> +
> +	if (me == 1) {
> +		switch (pipe) {
> +		case 0:
> +			reset_pipe = REG_SET_FIELD(reset_pipe, CP_MEC_CNTL,
> +						   MEC_ME1_PIPE0_RESET, 1);
> +			clean_pipe = REG_SET_FIELD(clean_pipe, CP_MEC_CNTL,
> +						   MEC_ME1_PIPE0_RESET, 0);
> +			break;
> +		case 1:
> +			reset_pipe = REG_SET_FIELD(reset_pipe, CP_MEC_CNTL,
> +						   MEC_ME1_PIPE1_RESET, 1);
> +			clean_pipe = REG_SET_FIELD(clean_pipe, CP_MEC_CNTL,
> +						   MEC_ME1_PIPE1_RESET, 0);
> +			break;
> +		case 2:
> +			reset_pipe = REG_SET_FIELD(reset_pipe, CP_MEC_CNTL,
> +						   MEC_ME1_PIPE2_RESET, 1);
> +			clean_pipe = REG_SET_FIELD(clean_pipe, CP_MEC_CNTL,
> +						   MEC_ME1_PIPE2_RESET, 0);
> +			break;
> +		case 3:
> +			reset_pipe = REG_SET_FIELD(reset_pipe, CP_MEC_CNTL,
> +						   MEC_ME1_PIPE3_RESET, 1);
> +			clean_pipe = REG_SET_FIELD(clean_pipe, CP_MEC_CNTL,
> +						   MEC_ME1_PIPE3_RESET, 0);
> +			break;
> +		default:
> +			break;
> +		}
> +	} else {
> +		if (pipe) {
> +			reset_pipe = REG_SET_FIELD(reset_pipe, CP_MEC_CNTL,
> +						   MEC_ME2_PIPE1_RESET, 1);
> +			clean_pipe = REG_SET_FIELD(clean_pipe, CP_MEC_CNTL,
> +						   MEC_ME2_PIPE1_RESET, 0);
> +		} else {
> +			reset_pipe = REG_SET_FIELD(reset_pipe, CP_MEC_CNTL,
> +						   MEC_ME2_PIPE0_RESET, 1);
> +			clean_pipe = REG_SET_FIELD(clean_pipe, CP_MEC_CNTL,
> +						   MEC_ME2_PIPE0_RESET, 0);
> +		}
> +	}
> +
> +	WREG32_SOC15(GC, GET_INST(GC, xcc_id), regCP_MEC_CNTL, reset_pipe);
> +	WREG32_SOC15(GC, GET_INST(GC, xcc_id), regCP_MEC_CNTL, clean_pipe);
> +	soc15_grbm_select(adev, 0, 0, 0, 0, GET_INST(GC, xcc_id));
> +	mutex_unlock(&adev->srbm_mutex);
> +	gfx_v9_4_3_xcc_unset_safe_mode(adev, xcc_id);
> +
> +	r = gfx_v9_4_3_unmap_done(adev, me, pipe, queue, xcc_id);
> +	return r;
> +}
> +
>  static int gfx_v9_4_3_reset_kcq(struct amdgpu_ring *ring,
>  				unsigned int vmid)
>  {
> @@ -3473,7 +3588,7 @@ static int gfx_v9_4_3_reset_kcq(struct amdgpu_ring *ring,
>  	struct amdgpu_kiq *kiq = &adev->gfx.kiq[ring->xcc_id];
>  	struct amdgpu_ring *kiq_ring = &kiq->ring;
>  	unsigned long flags;
> -	int r, i;
> +	int r;
>  
>  	if (amdgpu_sriov_vf(adev))
>  		return -EINVAL;
> @@ -3495,26 +3610,25 @@ static int gfx_v9_4_3_reset_kcq(struct amdgpu_ring *ring,
>  	spin_unlock_irqrestore(&kiq->ring_lock, flags);
>  
>  	r = amdgpu_ring_test_ring(kiq_ring);
> -	if (r)
> -		return r;
> -
> -	/* make sure dequeue is complete*/
> -	amdgpu_gfx_rlc_enter_safe_mode(adev, ring->xcc_id);
> -	mutex_lock(&adev->srbm_mutex);
> -	soc15_grbm_select(adev, ring->me, ring->pipe, ring->queue, 0, GET_INST(GC, ring->xcc_id));
> -	for (i = 0; i < adev->usec_timeout; i++) {
> -		if (!(RREG32_SOC15(GC, 0, regCP_HQD_ACTIVE) & 1))
> -			break;
> -		udelay(1);
> -	}
> -	if (i >= adev->usec_timeout)
> -		r = -ETIMEDOUT;
> -	soc15_grbm_select(adev, 0, 0, 0, 0, GET_INST(GC, ring->xcc_id));
> -	mutex_unlock(&adev->srbm_mutex);
> -	amdgpu_gfx_rlc_exit_safe_mode(adev, ring->xcc_id);
>  	if (r) {
> -		dev_err(adev->dev, "fail to wait on hqd deactive\n");
> -		return r;
> +		dev_err(adev->dev, "kiq ring test failed after ring: %s queue reset\n",
> +				ring->name);
> +		goto pipe_reset;
> +	}
> +
> +	r = gfx_v9_4_3_unmap_done(adev, ring->me, ring->pipe, ring->queue, ring->xcc_id);
> +	if (r)
> +		dev_err(adev->dev, "fail to wait on hqd deactive and will try pipe reset\n");
> +
> +pipe_reset:
> +	if(r) {
> +		r = gfx_v9_4_3_kiq_reset_hw_pipe(kiq_ring, ring->funcs->type,
> +						ring->me, ring->pipe,
> +						ring->queue, ring->xcc_id);
> +		dev_info(adev->dev, "ring: %s pipe reset :%s\n", ring->name,
> +				r ? "failed" : "successfully");
> +		if (r)
> +			return r;
>  	}
>  
>  	r = amdgpu_bo_reserve(ring->mqd_obj, false);
