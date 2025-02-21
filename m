Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EAAADC021B3
	for <amd-gfx@archiver.kernel.org>; Fri, 21 Feb 2025 11:52:56 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9243410EA5D;
	Fri, 21 Feb 2025 11:52:56 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="mjzfBD50";
	dkim-atps=neutral
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2074.outbound.protection.outlook.com [40.107.244.74])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5113810EA5B
 for <amd-gfx@lists.freedesktop.org>; Fri, 21 Feb 2025 11:52:55 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wR9qGYzOW8YLA10PIYJFsRF0KFKleHbgB9ye7/2dGtN6DnIhHtNCU6QAPLmrtfjE4f6JSnbwKehQXygwqS8+pP0IHdmkFY11iygHh2PaonkTGOYvJ6aWAHY4r9pPL6fJXHdw93IYYMWz8si2acPHn8SKuglSxiyOKaIp6lNwm3yyE43kPRfxhF6Nsj81/vxEXIAIucGO/e+aFgf3TZiiYWFsxKR6SjMNpWvdmV4IAKlxo8Ci7MKMKDDdpfJF/+gSHvEVnwaXEP3uzv+ViXhw8OxufjfUImJ8U0ki2X2NbSqnSBucWICPEtMUShBdBsPpAzNm3G7YsFFOqDbdo/rkhA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oWKNqGJiSYQ+cHXOsUvsEdwV0Qxg4q/qutRRzMQ2bXA=;
 b=j1qEdyK+lRwdt/PRZPAvspuy4su8v9nGLB/7yxJyf3uxodRpM8HqlPJw1VKMfucvDduc3H60GvcENOdI1whZ+/Y+x0G7LyIAl2jQjePcfId3gX3bT6O67rbRNspt/UO+BdWUPuj+N4qhn0tam1V2qoSTCDoabrq2dsfg4HgsJ1Gl6LY8vcXQu0j/JwAVFOJ2jX37gcr3T88wwmtv2z7h1682y+Sa0+4Lg+s/cUlF5H/A8++uW5FW/HPbkYo0/orwjtxEOmAx2syJS4xrJAJ8KQ+c+0Ds24IRC1NwRzS+9nDxGMYQEMgvFbAavbk7ySvMoON8wwkJtVogvlZrgSNZ9w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oWKNqGJiSYQ+cHXOsUvsEdwV0Qxg4q/qutRRzMQ2bXA=;
 b=mjzfBD50FJz3GFYvxbxtGkuH/1k9Zl8+58Gbe37hmokBhZ5a9lH4aMOk2eG67mDoVHg6DvkXODQAakmjpSR8ZR3CSuDJa/kAwfDZkaMqwuTROeLPFKz5PYralWudSJj/nLhMoNyFUx5Xd3NxA658I8hHG94g5l7QRzMINCngYOQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS0PR12MB7804.namprd12.prod.outlook.com (2603:10b6:8:142::5) by
 DS7PR12MB5887.namprd12.prod.outlook.com (2603:10b6:8:7a::7) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8466.14; Fri, 21 Feb 2025 11:52:50 +0000
Received: from DS0PR12MB7804.namprd12.prod.outlook.com
 ([fe80::8327:d71a:ce21:a290]) by DS0PR12MB7804.namprd12.prod.outlook.com
 ([fe80::8327:d71a:ce21:a290%5]) with mapi id 15.20.8466.015; Fri, 21 Feb 2025
 11:52:50 +0000
Message-ID: <1f1db9eb-8d75-45f1-aeb9-3ba65211f22c@amd.com>
Date: Fri, 21 Feb 2025 17:22:43 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amdgpu: update SDMA reset mask in late_init
To: jesse.zhang@amd.com, amd-gfx@lists.freedesktop.org
Cc: Alexander.Deucher@amd.com, Jiadong Zhu <Jiadong.Zhu@amd.com>,
 tim.huang@amd.com, Jonathan Kim <Jonathan.Kim@amd.com>,
 Vitaly Prosyak <vitaly.prosyak@amd.com>
References: <20250221104542.3994301-1-jesse.zhang@amd.com>
Content-Language: en-US
From: "Lazar, Lijo" <lijo.lazar@amd.com>
In-Reply-To: <20250221104542.3994301-1-jesse.zhang@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN2PR01CA0072.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:23::17) To DS0PR12MB7804.namprd12.prod.outlook.com
 (2603:10b6:8:142::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB7804:EE_|DS7PR12MB5887:EE_
X-MS-Office365-Filtering-Correlation-Id: 331a542d-bed8-40fd-3166-08dd526e4456
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?Z0tLN3Z0bDFLSXNQMkRtVHRtekQ1WUdqTkJOTkNUUWNVcG1lZVFuelNiRnFv?=
 =?utf-8?B?VjhhU0oxdXlRUlhQWDducHpLTks1WCtuZWRPT3N0YWRkemhRNmpic3ZhUit0?=
 =?utf-8?B?U2pPRjRJZkZKTEIxWEVOVWpZaFhGS1lvWDJVay9lRXJqdDM5Y01RbVp3dHFI?=
 =?utf-8?B?U2didnBndnJCWDNTeWxWeE56VGFaN0F0dGwzY0VOQS92cXQraVZrdjlGUEc4?=
 =?utf-8?B?bm9ycUF3Y3RUdFpVSjVMZEdPOW9QaEh6N3pRZVBKR3J6TE5OYjRpZVhlWXZI?=
 =?utf-8?B?a20wZCt4VDdWdUFZQkx1eUZBYVg3Z1FDYzl2ZHlHNEtUSDE3czlGeFdIcmpJ?=
 =?utf-8?B?YlViVjJBazhZSWpBMXhtQkRRMnBISDIwTlR0V3NwTVdZTHB3Y055UHg5TE1F?=
 =?utf-8?B?M2ord28ycEJ2cFB0MGY0MmJZaFJ0b0tVUGxORWxWN0dvRnpCZzc4Q242Ukpp?=
 =?utf-8?B?S2E5WkFzc1B2MkM4RnlKM3AxVk1ETVlDK0tWU2JrRmVwRzd6SGMyS0xkMUxX?=
 =?utf-8?B?ZmNodTNJRDdtOXRUNFJST291ZEJJbytORnlKTGpzNHZ4V2o3dnpKbHJmYXln?=
 =?utf-8?B?R2FLSFBMMXJmcVdpVm52VnRPWjJvaWgxUE1JeE0yY0l2TWU5amxYRE40WDNr?=
 =?utf-8?B?QjZxRDlSK1dGU0hXSmxONUNiMXNPYzFiT1cxR0puVjVxVjhJckZVc0s0cVhZ?=
 =?utf-8?B?eGRzNGZ4S3R5dDVwbHF4aDJQdXJkRW9FZDBkWkRyNjlLNjBYODl6NEw5eDBx?=
 =?utf-8?B?Wld5ckIveGhTSEpJenFvRldKZjMzUHFJUGpZdS9EZXBiRXUvb2N6MStxMjVT?=
 =?utf-8?B?amtLZ3JWZSsxUUZvazFVV2pUS3ZLSFhoSlM0MEJXVkJlTTdhdzAxd1JJaTdj?=
 =?utf-8?B?NnNxeHMwMGcvU2R3cTgvajRQTVFDZlFKNUNHZVRsMVFOLzhBU0hZWXl6OHpK?=
 =?utf-8?B?MWhVck9DM3Q0NFd3UW5VV2FRc0ErdGxUQ2hBaDlNcUMzT3RVSHV1Ry84eDJX?=
 =?utf-8?B?U0xUaXpYd0k5Qms3NnNtc1pVdHJHWHhpODljK3cxVWRoMkY0bjQzbTZ6aDZV?=
 =?utf-8?B?TURtTUx0MjRpeEpPdFFYMTM4RlgwR3lrd2g2Q2R0YUpmVFJlVW1velVuaUky?=
 =?utf-8?B?R29XeHh6Q2E2Q3JiQjVkbStMVStxZEU3QkVzUU5RMERrK2ErNFNvYmF5L0g0?=
 =?utf-8?B?QlBTa0dWN2N6Sy94RWJKbHBjSFpJd1F6Y1cyR1UrZGJ6SFh4Mm5tcmRJQ1JY?=
 =?utf-8?B?MlFQSTYyVWFDQUdZb1VIbC83VHkwNytlRFlMV3FLTEJCZkNiRjkxSy9McjU1?=
 =?utf-8?B?RWRtbzlhSS81WWErQjhYZXhSK04rNTVRaTJQbWtLaElwY3BoTGJVNHJrcVhQ?=
 =?utf-8?B?RXBLNkNBRmpQU3JvRFNVc01kUnl1bGZ4SExUWUlQNmE2ZU5lYzZJZXRvcDh4?=
 =?utf-8?B?M25QWlhaMUwyWWp3ZXFxMXN0WjZKTVQ5WlEwOFJrNVFXWTNkK3ZGbXdjL3o4?=
 =?utf-8?B?cXBUL2xUd3NlNXN6QnNoSlZuckNpR2VOU0Y0NGh0bWtXM2pZTDNvekMySXN4?=
 =?utf-8?B?Qm5lUVFhVlBWM1JRQkJSZEdtam50dWlLNjBOc1dJcnVoN2srMkNpSDY0b3hs?=
 =?utf-8?B?cEtGSFIvcU13aUVuVmd0Q0QvejUwZHc1RHJDYjhLWjJDWXo1YXNOZC9panJn?=
 =?utf-8?B?ZWpObjB2eExUZ0RKQzQ2K2pGMWthVnVZdkFwOTZROCtZRWVvRk1UNlBSZ1dj?=
 =?utf-8?B?R0tqUTJTNVVtbi91cjVEektuejNHWEVjYjFuaU15SmpHamQ0ZGVia2xCWGRo?=
 =?utf-8?B?UHd1bk15L1JPWmVhenl2T040M0pXOERBRjIyZTl6L1d0YWk2ZHNMd2lXdFhw?=
 =?utf-8?Q?lvz+jsKLhBSxU?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR12MB7804.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NzhLclhWR2x5USt6WjBvVHFEMnpSVXdhMFA4SVB4Q3JlZnJvYURDcHFGZGp0?=
 =?utf-8?B?MHNicGlUMHM2TEdNMExacFdIMWc2cjZpdmlnRk4wWE1lM3N4bXZEMGRNbkY5?=
 =?utf-8?B?VWRmVEZwZEg3S2k3QTFzUVhJSTkxZ3dVUjI4YzVZYzVWc1g1VFdjT3Zyd3Np?=
 =?utf-8?B?bDBTRXFobEJOKzN1dWd1dU9MV0Zzd1ZHZDQvVlNOYjFMWHA4bnRDcVg5M0pR?=
 =?utf-8?B?U1pZeTlGVnY5allTTWM3dmZIbkIxc3BHUi9PN3hkeGFOTzdpOHdWb0pscmxk?=
 =?utf-8?B?TjJNLzY1eGZaeHZiaWJEZUI0OVhNTm1aK3B0UEZXalk0Z25GSTJ0NUhoWG5F?=
 =?utf-8?B?MTdLSnBoRUJDY1ltcHorK2hpUGxRbHppWExYSEl2MHdlZ3UzM3AxaExyTENJ?=
 =?utf-8?B?NXRLaVNRalJyVmlZV0syVE1SV2ZZM1NvU0dveHBTZUlrek5LeUhQSHhuRFBL?=
 =?utf-8?B?RW5CTnphZHZaN0c3SllCS0hBZzJ5MFo2TkN1N2x1aTNQUDM3Y1l3bmhhd0RN?=
 =?utf-8?B?QVJock4xTkM3SFVQYmFEOTNjVG10U2xHV1h0Q0xnYVA1ZGI5Vm9WM1FiVlkw?=
 =?utf-8?B?TUMzMUtOTmEycWdGL3VLbExObFlFWUZZaS9lbjNzeDQzWldsN3Uvckd5WWlK?=
 =?utf-8?B?OHpHOXVTdmdCNzN5TkNmMkxTZm80b2UzbTBEZzl4RU8vWGZLSXdUOWN5c1Q5?=
 =?utf-8?B?VC9sUEZSUTJGOG9nMUZ3cE1vYkJPMFo5NnZPYktxekp3blAxUUgzZGw1VmF6?=
 =?utf-8?B?dytRdUs2Zks3KzAybDZLTDdpQktDS2o3KzlYTEQrVnlFRUFINHVTLzFqMTJ5?=
 =?utf-8?B?NGNtc0grbVB5ZitGbThLb3BCU0thdE5BZjZILzNHVEttbURsdkVKS2xqQjZx?=
 =?utf-8?B?aGNXNXU3RUVpMm9GSnJ4WkVDamM4NUtSR0hhUlg1RnQ0VnA4K2JNZkZ4UHdT?=
 =?utf-8?B?dnp1M3ZqWHNoMUUvb0lEaTgxUkpuMmxaWXVwU2ZHWFJxUFJreVllcWRnNWRL?=
 =?utf-8?B?WU1UUHRwMUE4RWtncDJFZkFZS3kycDRMSnh4VGVhdllac0lUdjFubmJWVHVL?=
 =?utf-8?B?OXNvVmZYaWxnWWxUZUhEQ0lLZGRhOHk2SkJRYzIydjM2TExkeGFFbWM4NjhY?=
 =?utf-8?B?c2xVdjhGdlEzT1VSTHRyOEpwdUtFbWlnbjZ5QXBkREJEVlA4ZXZQdTErUHBi?=
 =?utf-8?B?ajYrVk5DT0dPMEFRTFA5WGp6MkFuVk52ckJSUFZtd1NtNFYrWGhwRUoxVlly?=
 =?utf-8?B?WExmdmplU1ZwRVVUT0d3UU9jMVNTU0tSNHpTV21nVUpUSmZ5YUR5NzRCOWpI?=
 =?utf-8?B?RmNFZGxuTlZscTZvdHhrV0xjT2pzV1EyNGNVK2oxbWVYNWxMZnhkT1g0M3FH?=
 =?utf-8?B?L3lnQTR2Z3ZhbzR2U0hhNjQ4MWpCbkJqVkZzRlNTUGN5ak5pWkxCWjk0QVBN?=
 =?utf-8?B?UStRWEVYTmQ2V2xhUXIrTy9CSlZDNnpiNjRXd2ppUzFmOGVaMnJJQStPQ21W?=
 =?utf-8?B?S3h6NUJ5SXVLbGRHbVplTlpCV0EzWGVUNk9iMVVXL1cwbDRPZW1JcXJXekl1?=
 =?utf-8?B?MU5CQnRuY2hTOTNqVStaTmkwbG5DVE9laTRSSTRyeDd1WWppcjUyN2VZTnNY?=
 =?utf-8?B?OWV1L1RUY2RJTWVMSTA4RkdzZDNQYmdYWExldm14alN4WUhJWjR4ZlVyZ0VB?=
 =?utf-8?B?bnJmaitSK01wTWlHMm5jeFJrNnB1RlpGUEJmd3IxWGRpbjQxQ21EbUpPSTBw?=
 =?utf-8?B?amlKNmJoWkoydGgxNmxwdmZWN0I1L1lmVG14OVVvenNzdy9seUVUa1NQNm4y?=
 =?utf-8?B?TWIxR21qMVRhYmdnbTgxTXRsdjVMcGcyMDdiL21nNGxXdUpZK1luU0N2NHlQ?=
 =?utf-8?B?NFp5OUtaR05oR1BXTGFlMmpTQktwQUlEd1p5UTdCUWRFMVdEMGVxMjJRV1g3?=
 =?utf-8?B?aHJwbS9ReHZJY2RWNWZ4RGg0NzBHS3FIUWgzRGp1eTZtb0ZyRUFBa0k4VUlV?=
 =?utf-8?B?NUZaM3IybHlOSjFUd3Z4RWJVN0duRWk3c05kTktZcG42UHQ0elFDRU1DQlU2?=
 =?utf-8?B?UEkwQXlRdWdqTUJFRWRUSXpmak90VjNXS2NnUE9oZHIwL2ZyMTRXVGgyNlFo?=
 =?utf-8?Q?quSASKrKrd1k9QTDdiKNbcFYs?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 331a542d-bed8-40fd-3166-08dd526e4456
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB7804.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Feb 2025 11:52:50.6334 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cLD+zEwl6I37K+IpwbmNEYDNR0Ifj93xiVi+mdcefN7GgD61jBATnOTkjsghOGQJ
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB5887
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



On 2/21/2025 4:15 PM, jesse.zhang@amd.com wrote:
> From: "Jesse.zhang@amd.com" <jesse.zhang@amd.com>
> 
> - Added `sdma_v4_4_2_update_reset_mask` function to update the reset mask.
> - update the sysfs reset mask to the `late_init` stage to ensure that the SMU  initialization
>      and capability setup are completed before checking the SDMA reset capability.
> - For IP versions 9.4.3 and 9.4.4, enable per-queue reset if the MEC firmware version is at least 0xb0 and PMFW supports queue reset.
> - Add a TODO comment for future support of per-queue reset for IP version 9.4.5.
> 
> This change ensures that per-queue reset is only enabled when the MEC and PMFW support it.
> 
> Suggested-by: Jonathan Kim <Jonathan.Kim@amd.com>
> Signed-off-by: Vitaly Prosyak <vitaly.prosyak@amd.com>
> Signed-off-by: Jesse Zhang <jesse.zhang@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c | 37 +++++++++++++++++++++++-
>  1 file changed, 36 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c b/drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c
> index 4fa688e00f5e..17e7e36f4477 100644
> --- a/drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c
> +++ b/drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c
> @@ -107,6 +107,7 @@ static void sdma_v4_4_2_set_vm_pte_funcs(struct amdgpu_device *adev);
>  static void sdma_v4_4_2_set_irq_funcs(struct amdgpu_device *adev);
>  static void sdma_v4_4_2_set_ras_funcs(struct amdgpu_device *adev);
>  static void sdma_v4_4_2_set_engine_reset_funcs(struct amdgpu_device *adev);
> +static void sdma_v4_4_2_update_reset_mask(struct amdgpu_device *adev);
>  
>  static u32 sdma_v4_4_2_get_reg_offset(struct amdgpu_device *adev,
>  		u32 instance, u32 offset)
> @@ -1374,6 +1375,12 @@ static int sdma_v4_4_2_late_init(struct amdgpu_ip_block *ip_block)
>  	if (!amdgpu_persistent_edc_harvesting_supported(adev))
>  		amdgpu_ras_reset_error_count(adev, AMDGPU_RAS_BLOCK__SDMA);
>  
> +	/* The initialization is done in the late_init stage to ensure that the SMU
> +	 * initialization and capability setup are completed before we check the SDMA
> +	 * reset capability
> +	 */
> +	sdma_v4_4_2_update_reset_mask(adev);
> +
>  	return 0;
>  }
>  
> @@ -1481,7 +1488,6 @@ static int sdma_v4_4_2_sw_init(struct amdgpu_ip_block *ip_block)
>  		}
>  	}
>  
> -	/* TODO: Add queue reset mask when FW fully supports it */
>  	adev->sdma.supported_reset =
>  		amdgpu_get_soft_full_reset_mask(&adev->sdma.instance[0].ring);
>  
> @@ -2328,6 +2334,35 @@ static void sdma_v4_4_2_set_vm_pte_funcs(struct amdgpu_device *adev)
>  	adev->vm_manager.vm_pte_num_scheds = adev->sdma.num_instances;
>  }
>  
> +/**
> + * sdma_v4_4_2_update_reset_mask - update  reset mask for SDMA
> + * @adev: Pointer to the AMDGPU device structure
> + *
> + * This function update reset mask for SDMA and sets the supported
> + * reset types based on the IP version and firmware versions.
> + *
> + */
> +static void sdma_v4_4_2_update_reset_mask(struct amdgpu_device *adev)
> +{
> +
> +	/*
> +	 * the user queue relies on MEC fw and pmfw when the sdma queue do reset.
> +	 * it needs to check both of them at here to skip old mec and pmfw.
> +	 */
> +	switch (amdgpu_ip_version(adev, GC_HWIP, 0)) {
> +	case IP_VERSION(9, 4, 3):
> +	case IP_VERSION(9, 4, 4):
> +		if ((adev->gfx.mec_fw_version >= 0xb0) && amdgpu_dpm_reset_sdma_is_supported(adev))
> +			adev->sdma.supported_reset |= AMDGPU_RESET_TYPE_PER_QUEUE;
> +		break;
> +	case IP_VERSION(9, 4, 5):

Did you mean v9.5.0?

Thanks,
Lijo

> +		/*TODO: enable the queue reset flag until fw supported */
> +	default:
> +		break;
> +	}
> +
> +}
> +
>  const struct amdgpu_ip_block_version sdma_v4_4_2_ip_block = {
>  	.type = AMD_IP_BLOCK_TYPE_SDMA,
>  	.major = 4,

