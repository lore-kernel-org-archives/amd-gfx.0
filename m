Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0290FCA9ED1
	for <amd-gfx@archiver.kernel.org>; Mon, 12 Oct 2026 14:08:07 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8ADE110E5A7;
	Mon, 12 Oct 2026 14:08:01 +0000 (UTC)
Received: from SA9PR02CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11013000.outbound.protection.outlook.com
 [40.93.196.0])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DF00410E593
 for <amd-gfx@lists.freedesktop.org>; Mon, 12 Oct 2026 14:07:54 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NUiAslVlKhZIwRjwp9x5mRjgL2+BuNQlgei2DlPEizFiqVjrJou4Rp/1dEvpBzpO5/xRkxdOzJ4owjugPVvpdyYWeG724umHywgduUtB2vnai8Y4A43jHxAYOMmugVeTDSneLFEveZMbMqFmRO3kS/7AjRwz1XURxURJF60f7w9pse3nWOOeq8WIXP73++4QjrZaPVGZfC/eH86JjP041nLbEchoHsuvEenY8fg2y/+I/4n548U0+iEVpCGYVqexqjOCxaGe6IWwPhzUBrMSPmFS/a9cLzhIdBcVqa8Z+9ZU3r6eH9duHP87ckm+b4RYWAPQKX+XR++QuOhi/eXZWg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Od9Rwnr36kY+yntykwJy06RWsQdaWQBC1MfgtZMymw4=;
 b=OD41TaX2oelyKxPWoIUlPQNz1aY/T0MeQXWK4SKEW88+3dnU0NldMCv/F8dBlAQPrf8kT5C4Cp7xoq5TcjNV/8fBtJcgPVP0V8gES4ZUSqafjXlwEQZYwUVIU9gRG6tB5jodDli4wq6L2AXU8dkwa0lDPCfFlhMTzn6jZYE9ijSWD8Qtyt8uM9WRCQz8r92avjRmm8ijttnbPQLceYXtcBc/yNNNBiEOO9fQgIpIS+TwVrB12adxH8EbYBmjx1RuecaAJZ8G+s4smXb7KeEVtAlMbloqUronDIllh236GIJg0BHMkIwcsvsWfvaa61ba2KArcmZhDI9qRhIb4wZ7VA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Od9Rwnr36kY+yntykwJy06RWsQdaWQBC1MfgtZMymw4=;
 b=X9QkGoYbi8kCDd6OGkJtuN/EuXAwF8u+mMVbKKVSOzf/djksn8wBMLAZH0mK+6HqJYpmfDWuy4d8SULVPCKKc3oWr6bhfPWZJw2PTIf6P0EYXM/x2Uda/guhgtcpRaouUQheBh08Qi00gSnOFMr0Y/6v7EyJFQmpxjhsTQL3RW4=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by IA0PPF9A76BB3A6.namprd12.prod.outlook.com
 (2603:10b6:20f:fc04::bdc) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.496.21; Mon, 12 Oct
 2026 14:07:50 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c%3]) with mapi id 15.21.0496.020; Mon, 12 Oct 2026
 14:07:50 +0000
Message-ID: <d6cc0c25-bbee-48b4-9a84-3a79fa82dff5@amd.com>
Date: Mon, 12 Oct 2026 16:07:46 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/7] drm/amdgpu: Add second-level trap handler
 infrastructure
To: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>
Cc: amd-gfx@lists.freedesktop.org, Lijo Lazar <lijo.lazar@amd.com>,
 Felix Kuehling <felix.kuehling@amd.com>, Lancelot Six
 <lancelot.six@amd.com>, James Zhu <james.zhu@amd.com>,
 Samuel Pitoiset <hakzsam@gmail.com>, Natalie Vock <natalie.vock@gmx.de>,
 =?UTF-8?Q?Timur_Krist=C3=B3f?= <timur.kristof@gmail.com>,
 Pierre-Eric Pelloux-Prayer <pierre-eric.pelloux-prayer@amd.com>
References: <20261008070542.1111149-1-srinivasan.shanmugam@amd.com>
 <20261008070542.1111149-5-srinivasan.shanmugam@amd.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20261008070542.1111149-5-srinivasan.shanmugam@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR4P281CA0175.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:b7::12) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|IA0PPF9A76BB3A6:EE_
X-MS-Office365-Filtering-Correlation-Id: 0b5d17bf-2365-4a8e-dcde-08df286a334e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|366016|1800799024|23010399003|56012099006|11063799006|4143699003|261009223027099003|10067099003|18002099003|22082099003|6133799003|3023799007;
X-Microsoft-Antispam-Message-Info: NB/9V7V8MQz69GBZ/D3l64YcHst0iLVCpRcHaTf9YJNYvAH2kNtXz8Qj6RwIOLNyhm4MEWtya/oui47hQ3ZQcpQJLEbL94/dxFEz3YbDkTW1aO6z/DeVCOchslLWQYzrA23cZwf4nplupqeyYoykyUZzjxzgtjtaeDDVrxkjHSmESTw55EYBVU1hLR9dZrwKzrFiytw8MYSSH9OHuTlpN0mkOLXWcV6f+3OBJ/xVsYptPC3FEgJvCv2tLvV/MTk8EmETCSAfYL8THIA5zXiKWprKZEZYMmhw0gOvE/RQHjxJ3tDYA83fpY3Bh+sZfrZWGh6ZnWJxqMaL7m/+dGkTxSBIN1500KPt0HzWtSiyo19HoY6pZyXQVOw/kzwaD82qUmsRw6JYBBI13Di8hbcBJpiwjHaW7KXfYxOrgDfV2E5OmcwFnXxhRBwXagMHaU+rupSAvPzzE/cxgryz2JhgQJA0PNBjQTL7pYpJRahXpwxgKYKnumskqjhdYR933nrFTXIzxh8MEQbK3afYau6WBNWDXLLeCTakXFrEuXThrYFZxBDeVmyFbzKDrgaAG1+kW8gCkp02N0borzgxQfiMMpZwDfRalHFmtcO7lNiEegsAD8TlCSf5GcMxA+G68hocx0x+uWwRV3KkjlZU6WNBTIc3vTzGJQrIi6b1EN9g6dc=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(23010399003)(56012099006)(11063799006)(4143699003)(261009223027099003)(10067099003)(18002099003)(22082099003)(6133799003)(3023799007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?K2xsUWNJM2wwV3hXSGdLcm9zOUtkMHZxMWt4TDlGREc4YnUyZVRFb0FaVEZs?=
 =?utf-8?B?ZmJYbGNyajZLak1ESUk3NXVGRXV3cDVTT1hRUGR5YVNzZlBZU2lCcklaNXQ4?=
 =?utf-8?B?eE9Gd2F6ZUdFVTB4blExcjVTTVZBeUxOUGxSM2RZam8zQUVNYXJXMytPN21P?=
 =?utf-8?B?OW5iWENZRlVWRzNVYWIyWnVvYkNnUzNSMUEwdVAvQ0xHY0ViUDNxbUVmaEhy?=
 =?utf-8?B?d3dIRHFMQ3E4bXJ5aGw4Z0hpUjJvTUxESjJLcDFsbzdHSUJXQjJSUGNXcW5t?=
 =?utf-8?B?blhEVTBVWHBnZ0ZCY1hEM2plNW1CTWNST0J1OGpWYzlPVWt6ek44NG1zQVZ0?=
 =?utf-8?B?RG1FUGt6Zi9kK1JtNThkTDUxaXpWMHIrbjFmaGJRcTM3blR2bjB2blE1OUQ4?=
 =?utf-8?B?ZldxNVIxNGNuTzdZSHdHV0FzZ3orY3ltVTBzSmFCRkVMaGs4NkV1VW5CcVJo?=
 =?utf-8?B?Mk5tR1liV3YrbUNxMGNTcDR0RWFiRkdrSHZxcVdrZzlTWitTSDBuaDVSMzJl?=
 =?utf-8?B?YWlkVC9YWDhkUkpCd29lLzNrbmhsMDM5ZmJkY0RQSlg2V1pTSTJHMHBETFh1?=
 =?utf-8?B?UW10RWhTbTdFZVREcFBWeHRpR3ppTUJPNjJyZktsZ1lwM1BkQUxsbWRTRkRh?=
 =?utf-8?B?bnUvMlZWbm9aK3Awbk5DMjdBczZzS3lvWmdFb1JaWFpKUHpGQTBYQjUvNXMw?=
 =?utf-8?B?bHBEeFJxT0ZMM1pzNE92d2FKQlk1S25oMVM2c0lLemVubFJXSkR1eGF0cUZQ?=
 =?utf-8?B?SjFwTGQ5cXdOVWtoc014TlJOYmI4YThvZVRqbEJETEl6L0JFQXZlaFNNVVd6?=
 =?utf-8?B?UUtiNTE2bEg5V2hrT1dyN0oxb3hLMW1aaE80N2VoYlpHZDR4eVdSdXpxbmR2?=
 =?utf-8?B?MTFrOVN4S1NlU28zUzZPOU5kYzI4RzN5VFdlZ3puMVJraUlzY293Qkc0eFVY?=
 =?utf-8?B?MHBiSGVBYnJJdEhvcDFTU3dmamJXWjNzbW14T1FvODdBdDIyUzRCMEk0WnZZ?=
 =?utf-8?B?MFRmSFNGZjIrUDlUYlBob3ZqQWtHUm5vb1ExSno4TmVIZzNINnFUM2tNdnlV?=
 =?utf-8?B?VFMxRTFUV3YzOFdVaUxEb3FaU29KT01UNWQ3ZXJudnZTajlxamhHc2VKMnhq?=
 =?utf-8?B?R0h4d1VWWk1CaGcxTHdYcHBSdHJPRTVaZWJLNGpDSVAwRGJjTWZsQmtCWmZ5?=
 =?utf-8?B?Wk1VQnQ3RGtySVdKdEN5ei9iSDNPVUZrUkFESDVQakNIdzVqSXhGUjNzcnU3?=
 =?utf-8?B?K3YwZnhPNUFXK2dkK1o5L3E1V0REbXlUSU5oQU9ickN0anFmRld2YXdXNTRn?=
 =?utf-8?B?ZlVoeVBQOGptZE9pOXdubHp4T2ltcTJsbHY4dXdaaUhPT003cDI0MVlOUGRy?=
 =?utf-8?B?UzBpT3pyK1ZaUDQySUxhR3crcnNVUno5WHk1T29tbFFTSjRUMDIrVWh5NENO?=
 =?utf-8?B?Y0hCUkVWYW84QW5zQnU0Qk9YcXJIU1F4dG1WT3ozZUlvZEdmN2w5a0w0OEVV?=
 =?utf-8?B?ajFlSmNFTFAzdzdsUVc1aHV5bWJvVHBQZlVraEZ6K0QwY1A3cGptY1JIYTk5?=
 =?utf-8?B?bDkxZUU4NTVTSDVUSVBJeFNROFJKVG5RWlhEcUFrMEI4YXRCOXM1S3l3M2hw?=
 =?utf-8?B?cVVEN0xFQ2R4bzVXc2R0WUk4YTd4VlhnbmZuQUh0UDJGRTl4NUNrNWhiQTNR?=
 =?utf-8?B?Y3N5K3BDWWVySEgyT2srbEx4Zk5QVk9aRmZNdW9DcjBhTnhNa2pFY3BLVHZk?=
 =?utf-8?B?Wmo4VVlnbHI0a0xLSENuQkh1R0RnRXAwT0VjTG1wbDJ2UzJUYkptdDA4ZkVD?=
 =?utf-8?B?Mm1FNHNKNUo2WTNSNlRQNmtaOGFQRkZNWkE0YTZZaUd0Z1Z4QmFXajVDK3NU?=
 =?utf-8?B?QTNtbWhvT29SNFJoSzFLcjFtV2Zkd09TOG5TdXAyREYrK0xQSjVLMkhJS3hy?=
 =?utf-8?B?UllGYXNiS0NvbmxYdlpFK1BKUjNLVk1jUGg0RzBQZFdNTWhtRGdaSXlNd0N3?=
 =?utf-8?B?WmpNcUZSUDJETWNjcTVPOEJMM09OS1Q3bmhxRk1ObzBGb1J5V2xtVEdiblB6?=
 =?utf-8?B?OFQvZ3lQbjhLWlBuM3h1azFTMDFYT1B3Q2oxcjM5TFBkb00rMERmVXh2Y3pt?=
 =?utf-8?B?eXd3N05oTC9tWktkMzBuSE93TG5yQkYwZ3dSRlJaVFpTTU42TSt3S3BJOGJF?=
 =?utf-8?B?OG5mTyttZHF5QXhWdm1STTduU0pzSzFBWFV1V3VHZTA4Y0ptRHZXWU0vdlJP?=
 =?utf-8?B?aTZENTk4QzNtQzNnL3ZLMzVkdTMyQUJnUjdmZkNQNXFxWU4zMmlFMDc5OE05?=
 =?utf-8?Q?qfFD5zB/loN0dSfRV2?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0b5d17bf-2365-4a8e-dcde-08df286a334e
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Oct 2026 14:07:50.6435 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RshiWxl4Hi81XNBKSzoHQdiUMHD3W2TbwTWv4cTRrKkvbjgmO5I7Xun405e2Agcd
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PPF9A76BB3A6
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

On 10/8/26 09:05, Srinivasan Shanmugam wrote:
> From: Lijo Lazar <lijo.lazar@amd.com>
> 
> Expand the CWSR infrastructure to support second-level userspace trap
> handlers and rename it to reflect the broader trap handler scope.
> 
> Rename the CWSR files and common interfaces to amdgpu_trap while keeping
> CWSR-specific naming for the context save/restore functionality.
> 
> Add the basic support needed for a userspace second-level trap handler.
> Store the second-level TBA and TMA addresses in the first-level TMA and
> provide helpers to set and clear them for a GPUVM.
> 
> The first-level TMA buffer can move in memory, so do not keep it
> permanently mapped on the CPU. Map it only while accessing its contents
> and unmap it afterwards.
> 
> Check that the second-level TBA and TMA address ranges are mapped in the
> GPUVM before using them. Wait for GPUVM work to stop before changing the
> addresses and keep the VM locked while checking and updating them.
> 
> Add support for updating the debugger trap flag in the first-level TMA.
> 
> Do not expose a standalone TRAP ioctl. The second-level trap handler is
> controlled through SET_L2_TRAP and CLEAR_L2_TRAP operations on the VM
> ioctl added later in the series.
> 
> Suggested-by: Christian König <christian.koenig@amd.com>
> Suggested-by: Alex Deucher <alexander.deucher@amd.com>
> Cc: Felix Kuehling <felix.kuehling@amd.com>
> Cc: Lancelot Six <lancelot.six@amd.com>
> Cc: James Zhu <james.zhu@amd.com>
> Cc: Lijo Lazar <lijo.lazar@amd.com>
> Cc: Samuel Pitoiset <hakzsam@gmail.com>
> Cc: Natalie Vock <natalie.vock@gmx.de>
> Cc: Timur Kristóf <timur.kristof@gmail.com>
> Cc: Pierre-Eric Pelloux-Prayer <pierre-eric.pelloux-prayer@amd.com>
> Signed-off-by: Lijo Lazar <lijo.lazar@amd.com>
> Co-developed-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
> Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>

Reviewed-by: Christian König <christian.koenig@amd.com>

> ---
>  drivers/gpu/drm/amd/amdgpu/Makefile        |   2 +-
>  drivers/gpu/drm/amd/amdgpu/amdgpu.h        |   8 +-
>  drivers/gpu/drm/amd/amdgpu/amdgpu_cwsr.c   | 534 ---------------
>  drivers/gpu/drm/amd/amdgpu/amdgpu_cwsr.h   |  87 ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_device.c |   6 +-
>  drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c    |   1 +
>  drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c    |  18 +-
>  drivers/gpu/drm/amd/amdgpu/amdgpu_trap.c   | 753 +++++++++++++++++++++
>  drivers/gpu/drm/amd/amdgpu/amdgpu_trap.h   | 143 ++++
>  drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c  |  13 +-
>  drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h  |   7 +-
>  drivers/gpu/drm/amd/amdgpu/mes_userqueue.c |  24 +-
>  12 files changed, 935 insertions(+), 661 deletions(-)
>  delete mode 100644 drivers/gpu/drm/amd/amdgpu/amdgpu_cwsr.c
>  delete mode 100644 drivers/gpu/drm/amd/amdgpu/amdgpu_cwsr.h
>  create mode 100644 drivers/gpu/drm/amd/amdgpu/amdgpu_trap.c
>  create mode 100644 drivers/gpu/drm/amd/amdgpu/amdgpu_trap.h
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/Makefile b/drivers/gpu/drm/amd/amdgpu/Makefile
> index 5086a482daf1..28bd81f0f720 100644
> --- a/drivers/gpu/drm/amd/amdgpu/Makefile
> +++ b/drivers/gpu/drm/amd/amdgpu/Makefile
> @@ -72,7 +72,7 @@ amdgpu-y += amdgpu_device.o amdgpu_reg_access.o amdgpu_doorbell_mgr.o amdgpu_kms
>  	amdgpu_eeprom.o amdgpu_mca.o amdgpu_psp_ta.o amdgpu_lsdma.o amdgpu_lockdep.o \
>  	amdgpu_ring_mux.o amdgpu_xcp.o amdgpu_seq64.o amdgpu_dev_coredump.o \
>  	amdgpu_cper.o amdgpu_userq_fence.o amdgpu_eviction_fence.o amdgpu_ip.o \
> -	amdgpu_wb.o amdgpu_cwsr.o
> +	amdgpu_wb.o amdgpu_trap.o
>  
>  amdgpu-$(CONFIG_PROC_FS) += amdgpu_fdinfo.o
>  
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> index bdd55ac5b06e..e55496f5ecdd 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> @@ -332,8 +332,8 @@ struct amdgpu_reset_context;
>  struct amdgpu_reset_control;
>  struct amdgpu_coredump_info;
>  struct amdgpu_video_codecs;
> -struct amdgpu_cwsr_isa;
> -struct amdgpu_cwsr_trap_obj;
> +struct amdgpu_trap_isa;
> +struct amdgpu_trap_obj;
>  
>  enum amdgpu_cp_irq {
>  	AMDGPU_CP_IRQ_GFX_ME0_PIPE0_EOP = 0,
> @@ -422,7 +422,7 @@ struct amdgpu_fpriv {
>  	struct xarray		bo_list_handles;
>  	struct amdgpu_ctx_mgr	ctx_mgr;
>  	struct amdgpu_userq_mgr	userq_mgr;
> -	struct amdgpu_cwsr_trap_obj *cwsr_trap;
> +	struct amdgpu_trap_obj *trap_obj;
>  
>  	/* Eviction fence infra */
>  	struct amdgpu_eviction_fence_mgr evf_mgr;
> @@ -978,7 +978,7 @@ struct amdgpu_device {
>  	 */
>  	struct amdgpu_kfd_dev		kfd;
>  
> -	struct amdgpu_cwsr_info *cwsr_info;
> +	struct amdgpu_trap_info *trap_info;
>  };
>  
>  static inline uint32_t amdgpu_ip_version(const struct amdgpu_device *adev,
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_cwsr.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_cwsr.c
> deleted file mode 100644
> index 6b6c11bb5fd7..000000000000
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_cwsr.c
> +++ /dev/null
> @@ -1,534 +0,0 @@
> -/*
> - * Copyright 2025 Advanced Micro Devices, Inc.
> - *
> - * Permission is hereby granted, free of charge, to any person obtaining a
> - * copy of this software and associated documentation files (the "Software"),
> - * to deal in the Software without restriction, including without limitation
> - * the rights to use, copy, modify, merge, publish, distribute, sublicense,
> - * and/or sell copies of the Software, and to permit persons to whom the
> - * Software is furnished to do so, subject to the following conditions:
> - *
> - * The above copyright notice and this permission notice shall be included in
> - * all copies or substantial portions of the Software.
> - *
> - * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
> - * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
> - * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.  IN NO EVENT SHALL
> - * THE COPYRIGHT HOLDER(S) OR AUTHOR(S) BE LIABLE FOR ANY CLAIM, DAMAGES OR
> - * OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE,
> - * ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
> - * OTHER DEALINGS IN THE SOFTWARE.
> - */
> -
> -#include <drm/drm_exec.h>
> -
> -#include "amdgpu.h"
> -#include "cwsr_trap_handler.h"
> -#include "amdgpu_cwsr.h"
> -
> -extern int cwsr_enable;
> -
> -#define AMDGPU_CWSR_TBA_MAX_SIZE (2 * AMDGPU_GPU_PAGE_SIZE)
> -#define AMDGPU_CWSR_TMA_MAX_SIZE (AMDGPU_GPU_PAGE_SIZE)
> -#define AMDGPU_CWSR_TMA_OFFSET (AMDGPU_CWSR_TBA_MAX_SIZE)
> -
> -#define SGPR_SIZE_PER_CU 0x4000
> -#define LDS_SIZE_PER_CU 0x10000
> -#define HWREG_SIZE_PER_CU 0x1000
> -#define DEBUGGER_BYTES_ALIGN 64
> -#define DEBUGGER_BYTES_PER_WAVE 32
> -#define SIZEOF_HSA_USER_CONTEXT_SAVE_AREA_HEADER 40
> -
> -enum amdgpu_cwsr_region {
> -	AMDGPU_CWSR_TBA,
> -	AMDGPU_CWSR_TMA,
> -};
> -
> -static inline uint64_t amdgpu_cwsr_tba_vaddr(struct amdgpu_device *adev)
> -{
> -	uint64_t addr = AMDGPU_VA_RESERVED_TRAP_UQ_START(adev);
> -
> -	addr = amdgpu_gmc_sign_extend(addr);
> -
> -	return addr;
> -}
> -
> -static inline bool amdgpu_cwsr_is_supported(struct amdgpu_device *adev)
> -{
> -	uint32_t gc_ver = amdgpu_ip_version(adev, GC_HWIP, 0);
> -
> -	if (!cwsr_enable || adev->gfx.disable_uq ||
> -	    gc_ver < IP_VERSION(9, 0, 1))
> -		return false;
> -
> -	return true;
> -}
> -
> -uint32_t amdgpu_cwsr_size_needed(struct amdgpu_device *adev, int num_xcc)
> -{
> -	if (!amdgpu_cwsr_is_enabled(adev))
> -		return 0;
> -
> -	return num_xcc *
> -	       (adev->cwsr_info->xcc_cwsr_sz + adev->cwsr_info->xcc_dbg_mem_sz);
> -}
> -
> -static void amdgpu_cwsr_init_isa_details(struct amdgpu_device *adev,
> -					 struct amdgpu_cwsr_info *cwsr_info)
> -{
> -	uint32_t gc_ver = amdgpu_ip_version(adev, GC_HWIP, 0);
> -
> -	if (gc_ver < IP_VERSION(9, 0, 1)) {
> -		BUILD_BUG_ON(sizeof(cwsr_trap_gfx8_hex) >
> -			     AMDGPU_CWSR_TBA_MAX_SIZE);
> -		cwsr_info->isa_buf = cwsr_trap_gfx8_hex;
> -		cwsr_info->isa_sz = sizeof(cwsr_trap_gfx8_hex);
> -	} else if (gc_ver == IP_VERSION(9, 4, 1)) {
> -		BUILD_BUG_ON(sizeof(cwsr_trap_arcturus_hex) >
> -			     AMDGPU_CWSR_TBA_MAX_SIZE);
> -		cwsr_info->isa_buf = cwsr_trap_arcturus_hex;
> -		cwsr_info->isa_sz = sizeof(cwsr_trap_arcturus_hex);
> -	} else if (gc_ver == IP_VERSION(9, 4, 2)) {
> -		BUILD_BUG_ON(sizeof(cwsr_trap_aldebaran_hex) >
> -			     AMDGPU_CWSR_TBA_MAX_SIZE);
> -		cwsr_info->isa_buf = cwsr_trap_aldebaran_hex;
> -		cwsr_info->isa_sz = sizeof(cwsr_trap_aldebaran_hex);
> -	} else if (gc_ver == IP_VERSION(9, 4, 3) ||
> -		   gc_ver == IP_VERSION(9, 4, 4)) {
> -		BUILD_BUG_ON(sizeof(cwsr_trap_gfx9_4_3_hex) >
> -			     AMDGPU_CWSR_TBA_MAX_SIZE);
> -		cwsr_info->isa_buf = cwsr_trap_gfx9_4_3_hex;
> -		cwsr_info->isa_sz = sizeof(cwsr_trap_gfx9_4_3_hex);
> -	} else if (gc_ver == IP_VERSION(9, 5, 0)) {
> -		BUILD_BUG_ON(sizeof(cwsr_trap_gfx9_5_0_hex) > PAGE_SIZE);
> -		cwsr_info->isa_buf = cwsr_trap_gfx9_5_0_hex;
> -		cwsr_info->isa_sz = sizeof(cwsr_trap_gfx9_5_0_hex);
> -	} else if (gc_ver < IP_VERSION(10, 1, 1)) {
> -		BUILD_BUG_ON(sizeof(cwsr_trap_gfx9_hex) >
> -			     AMDGPU_CWSR_TBA_MAX_SIZE);
> -		cwsr_info->isa_buf = cwsr_trap_gfx9_hex;
> -		cwsr_info->isa_sz = sizeof(cwsr_trap_gfx9_hex);
> -	} else if (gc_ver < IP_VERSION(10, 3, 0)) {
> -		BUILD_BUG_ON(sizeof(cwsr_trap_nv1x_hex) >
> -			     AMDGPU_CWSR_TBA_MAX_SIZE);
> -		cwsr_info->isa_buf = cwsr_trap_nv1x_hex;
> -		cwsr_info->isa_sz = sizeof(cwsr_trap_nv1x_hex);
> -	} else if (gc_ver < IP_VERSION(11, 0, 0)) {
> -		BUILD_BUG_ON(sizeof(cwsr_trap_gfx10_hex) >
> -			     AMDGPU_CWSR_TBA_MAX_SIZE);
> -		cwsr_info->isa_buf = cwsr_trap_gfx10_hex;
> -		cwsr_info->isa_sz = sizeof(cwsr_trap_gfx10_hex);
> -	} else if (gc_ver < IP_VERSION(12, 0, 0)) {
> -		/* The gfx11 cwsr trap handler must fit inside a single
> -			   page. */
> -		BUILD_BUG_ON(sizeof(cwsr_trap_gfx11_hex) > PAGE_SIZE);
> -		cwsr_info->isa_buf = cwsr_trap_gfx11_hex;
> -		cwsr_info->isa_sz = sizeof(cwsr_trap_gfx11_hex);
> -	} else if (gc_ver < IP_VERSION(12, 1, 0)) {
> -		BUILD_BUG_ON(sizeof(cwsr_trap_gfx12_hex) >
> -			     AMDGPU_CWSR_TBA_MAX_SIZE);
> -		cwsr_info->isa_buf = cwsr_trap_gfx12_hex;
> -		cwsr_info->isa_sz = sizeof(cwsr_trap_gfx12_hex);
> -	} else {
> -		BUILD_BUG_ON(sizeof(cwsr_trap_gfx12_1_0_hex) >
> -			     AMDGPU_CWSR_TBA_MAX_SIZE);
> -		cwsr_info->isa_buf = cwsr_trap_gfx12_1_0_hex;
> -		cwsr_info->isa_sz = sizeof(cwsr_trap_gfx12_1_0_hex);
> -	}
> -}
> -
> -static uint32_t amdgpu_cwsr_get_vgpr_size_per_cu(struct amdgpu_device *adev)
> -{
> -	uint32_t gc_ver = amdgpu_ip_version(adev, GC_HWIP, 0);
> -	uint32_t vgpr_size;
> -
> -	switch (gc_ver) {
> -	case IP_VERSION(9, 4, 1): /* GFX_VERSION_ARCTURUS */
> -	case IP_VERSION(9, 4, 2): /* GFX_VERSION_ALDEBARAN */
> -	case IP_VERSION(9, 4, 3): /* GFX_VERSION_AQUA_VANJARAM */
> -	case IP_VERSION(9, 4, 4): /* GFX_VERSION_AQUA_VANJARAM */
> -	case IP_VERSION(9, 5, 0):
> -		vgpr_size = 0x80000;
> -		break;
> -	case IP_VERSION(11, 0, 0):
> -	case IP_VERSION(11, 0, 2):
> -	case IP_VERSION(11, 0, 3):
> -	case IP_VERSION(12, 0, 0):
> -	case IP_VERSION(12, 0, 1):
> -		vgpr_size = 0x60000;
> -		break;
> -	default:
> -		vgpr_size = 0x40000;
> -		break;
> -	}
> -
> -	return vgpr_size;
> -}
> -
> -static uint32_t amdgpu_cwsr_get_wg_ctxt_size_per_cu(struct amdgpu_device *adev)
> -{
> -	uint32_t lds_sz_per_cu;
> -
> -	lds_sz_per_cu =
> -		(amdgpu_ip_version(adev, GC_HWIP, 0) == IP_VERSION(9, 5, 0)) ?
> -			(adev->gfx.cu_info.lds_size << 10) :
> -			LDS_SIZE_PER_CU;
> -
> -	return amdgpu_cwsr_get_vgpr_size_per_cu(adev) + SGPR_SIZE_PER_CU +
> -	       lds_sz_per_cu + HWREG_SIZE_PER_CU;
> -}
> -
> -static uint32_t amdgpu_cwsr_ctl_stack_bytes_per_wave(struct amdgpu_device *adev)
> -{
> -	uint32_t sz;
> -
> -	if (amdgpu_ip_version(adev, GC_HWIP, 0) >= IP_VERSION(10, 1, 0))
> -		sz = 12;
> -	else
> -		sz = 8;
> -	return sz;
> -}
> -
> -static void amdgpu_cwsr_init_save_area_info(struct amdgpu_device *adev,
> -					    struct amdgpu_cwsr_info *cwsr_info)
> -{
> -	struct amdgpu_gfx_config *gfx_info = &adev->gfx.config;
> -	uint32_t gc_ver = amdgpu_ip_version(adev, GC_HWIP, 0);
> -	uint32_t ctl_stack_size, wg_data_size, dbg_mem_size;
> -	uint32_t array_count;
> -	uint32_t wave_num;
> -	uint32_t cu_num;
> -
> -	if (gc_ver < IP_VERSION(9, 0, 1))
> -		return;
> -
> -	array_count = gfx_info->max_shader_engines * gfx_info->max_sh_per_se;
> -
> -	cu_num = adev->gfx.cu_info.number / NUM_XCC(adev->gfx.xcc_mask);
> -	wave_num = (gc_ver < IP_VERSION(10, 1, 0)) ? /* GFX_VERSION_NAVI10 */
> -			   min(cu_num * 40,
> -			       array_count / gfx_info->max_sh_per_se * 512) :
> -			   cu_num * 32;
> -
> -	wg_data_size = ALIGN(cu_num * amdgpu_cwsr_get_wg_ctxt_size_per_cu(adev),
> -			     PAGE_SIZE);
> -	ctl_stack_size =
> -		wave_num * amdgpu_cwsr_ctl_stack_bytes_per_wave(adev) + 8;
> -	ctl_stack_size =
> -		ALIGN(SIZEOF_HSA_USER_CONTEXT_SAVE_AREA_HEADER + ctl_stack_size,
> -		      PAGE_SIZE);
> -	dbg_mem_size =
> -		ALIGN(wave_num * DEBUGGER_BYTES_PER_WAVE, DEBUGGER_BYTES_ALIGN);
> -	/*
> -	* HW design limits control stack size to 0x7000.
> -	* This is insufficient for theoretical PM4 cases
> -	* but sufficient for AQL, limited by SPI events.
> -	*/
> -	if (IP_VERSION_MAJ(gc_ver) == 10)
> -		ctl_stack_size = min(ctl_stack_size, 0x7000);
> -
> -	cwsr_info->xcc_ctl_stack_sz = ctl_stack_size;
> -	cwsr_info->xcc_cwsr_sz = ctl_stack_size + wg_data_size;
> -	cwsr_info->xcc_dbg_mem_sz = dbg_mem_size;
> -}
> -
> -int amdgpu_cwsr_init(struct amdgpu_device *adev)
> -{
> -	struct amdgpu_cwsr_info *cwsr_info __free(kfree) =
> -		kzalloc(sizeof(*cwsr_info), GFP_KERNEL);
> -	void *ptr;
> -	int r;
> -
> -	if (!amdgpu_cwsr_is_supported(adev))
> -		return -EOPNOTSUPP;
> -
> -	if (!cwsr_info)
> -		return -ENOMEM;
> -	amdgpu_cwsr_init_isa_details(adev, cwsr_info);
> -
> -	if (!cwsr_info->isa_sz)
> -		return -EOPNOTSUPP;
> -
> -	r = amdgpu_bo_create_kernel(adev, AMDGPU_CWSR_TBA_MAX_SIZE, PAGE_SIZE,
> -				    AMDGPU_GEM_DOMAIN_GTT, &cwsr_info->isa_bo,
> -				    NULL, &ptr);
> -	if (r)
> -		return r;
> -
> -	memcpy(ptr, cwsr_info->isa_buf, cwsr_info->isa_sz);
> -
> -	amdgpu_cwsr_init_save_area_info(adev, cwsr_info);
> -	adev->cwsr_info = no_free_ptr(cwsr_info);
> -
> -	return 0;
> -}
> -
> -void amdgpu_cwsr_fini(struct amdgpu_device *adev)
> -{
> -	if (!amdgpu_cwsr_is_enabled(adev))
> -		return;
> -
> -	amdgpu_bo_free_kernel(&adev->cwsr_info->isa_bo, NULL, NULL);
> -	kfree(adev->cwsr_info);
> -	adev->cwsr_info = NULL;
> -}
> -
> -/*
> - * amdgpu_map_cwsr_trap_handler should be called during amdgpu_vm_init
> - * it maps virtual address amdgpu_cwsr_trap_handler_vaddr() to this VM, and each
> - * compute queue can use this virtual address for wave save/restore
> - * operations to support compute preemption.
> - */
> -static int amdgpu_cwsr_map_region(struct amdgpu_device *adev,
> -				  struct amdgpu_vm *vm,
> -				  struct amdgpu_cwsr_trap_obj *cwsr,
> -				  enum amdgpu_cwsr_region region)
> -{
> -	uint64_t cwsr_addr, va_flags, va;
> -	struct amdgpu_bo_va **bo_va;
> -	struct amdgpu_bo *bo;
> -	uint32_t size;
> -	int r;
> -
> -	if (!cwsr || !vm)
> -		return -EINVAL;
> -
> -	cwsr_addr = amdgpu_cwsr_tba_vaddr(adev);
> -
> -	if (region == AMDGPU_CWSR_TBA) {
> -		size = AMDGPU_CWSR_TBA_MAX_SIZE;
> -		bo_va = &cwsr->tba_va;
> -		bo = adev->cwsr_info->isa_bo;
> -		va = cwsr_addr;
> -		va_flags = (AMDGPU_VM_PAGE_READABLE | AMDGPU_VM_PAGE_WRITEABLE |
> -			    AMDGPU_VM_PAGE_EXECUTABLE);
> -	} else {
> -		size = AMDGPU_CWSR_TMA_MAX_SIZE;
> -		bo_va = &cwsr->tma_va;
> -		bo = cwsr->tma_bo;
> -		va = cwsr_addr + AMDGPU_CWSR_TMA_OFFSET;
> -		va_flags = (AMDGPU_VM_PAGE_READABLE | AMDGPU_VM_PAGE_WRITEABLE);
> -	}
> -
> -	*bo_va = amdgpu_vm_bo_add(adev, vm, bo);
> -	if (!*bo_va)
> -		return -ENOMEM;
> -
> -	va &= AMDGPU_GMC_HOLE_MASK;
> -	r = amdgpu_vm_bo_map(adev, *bo_va, va, 0, size, va_flags);
> -	if (r) {
> -		dev_err(adev->dev, "failed to do bo map of %s region, err=%d\n",
> -			(region == AMDGPU_CWSR_TBA ? "tba" : "tma"), r);
> -		amdgpu_vm_bo_del(adev, *bo_va);
> -		*bo_va = NULL;
> -		return r;
> -	}
> -
> -	r = amdgpu_vm_bo_update(adev, *bo_va, false);
> -	if (r) {
> -		dev_err(adev->dev,
> -			"failed to do page table update of %s region, err=%d\n",
> -			(region == AMDGPU_CWSR_TBA ? "tba" : "tma"), r);
> -		amdgpu_vm_bo_del(adev, *bo_va);
> -		*bo_va = NULL;
> -		return r;
> -	}
> -
> -	if (region == AMDGPU_CWSR_TBA)
> -		cwsr->tba_gpu_va_addr = va;
> -	else
> -		cwsr->tma_gpu_va_addr = va;
> -
> -	return 0;
> -}
> -
> -static int amdgpu_cwsr_unmap_region(struct amdgpu_device *adev,
> -				    struct amdgpu_cwsr_trap_obj *cwsr,
> -				    enum amdgpu_cwsr_region region)
> -{
> -	struct amdgpu_bo_va **bo_va;
> -	uint64_t va;
> -	int r;
> -
> -	if (!cwsr)
> -		return -EINVAL;
> -
> -	if (region == AMDGPU_CWSR_TBA) {
> -		bo_va = &cwsr->tba_va;
> -		va = cwsr->tba_gpu_va_addr;
> -	} else {
> -		bo_va = &cwsr->tma_va;
> -		va = cwsr->tma_gpu_va_addr;
> -	}
> -
> -	r = amdgpu_vm_bo_unmap(adev, *bo_va, va);
> -	if (r) {
> -		dev_err(adev->dev,
> -			"failed to do bo_unmap on CWSR trap handler, err=%d\n",
> -			r);
> -		return r;
> -	}
> -
> -	amdgpu_vm_bo_del(adev, *bo_va);
> -	*bo_va = NULL;
> -
> -	return r;
> -}
> -
> -int amdgpu_cwsr_alloc(struct amdgpu_device *adev, struct amdgpu_vm *vm,
> -		      struct amdgpu_cwsr_trap_obj **trap_obj)
> -{
> -	struct amdgpu_bo_param bp;
> -	struct amdgpu_cwsr_trap_obj *cwsr;
> -	struct amdgpu_bo *bo;
> -	struct drm_exec exec;
> -	int r;
> -
> -	if (!amdgpu_cwsr_is_enabled(adev))
> -		return -EOPNOTSUPP;
> -	if (!vm || !trap_obj)
> -		return -EINVAL;
> -
> -	cwsr = kzalloc(sizeof(*cwsr), GFP_KERNEL);
> -	if (!cwsr)
> -		return -ENOMEM;
> -
> -	bo = adev->cwsr_info->isa_bo;
> -	drm_exec_init(&exec, DRM_EXEC_INTERRUPTIBLE_WAIT, 0);
> -	drm_exec_until_all_locked(&exec) {
> -		r = amdgpu_vm_lock_pd(vm, &exec, 0);
> -		if (likely(!r))
> -			r = drm_exec_lock_obj(&exec, &bo->tbo.base);
> -		drm_exec_retry_on_contention(&exec);
> -		if (unlikely(r)) {
> -			dev_err(adev->dev,
> -				"failed to reserve for CWSR allocs: err=%d\n",
> -				r);
> -			goto err_exec;
> -		}
> -	}
> -
> -	/*
> -	 * Create TMA BO using the VM's already-locked resv so no new
> -	 * reservation_ww_class_mutex acquisition is needed, avoiding the
> -	 * recursive ww_mutex deadlock. Unpinned; eviction is handled via
> -	 * amdgpu_vm_bo_add() inside amdgpu_cwsr_map_region().
> -	 */
> -	memset(&bp, 0, sizeof(bp));
> -	bp.size = AMDGPU_CWSR_TMA_MAX_SIZE;
> -	bp.byte_align = PAGE_SIZE;
> -	bp.domain = AMDGPU_GEM_DOMAIN_GTT;
> -	bp.flags = AMDGPU_GEM_CREATE_CPU_GTT_USWC |
> -		   AMDGPU_GEM_CREATE_CPU_ACCESS_REQUIRED;
> -	bp.type = ttm_bo_type_kernel;
> -	bp.bo_ptr_size = sizeof(struct amdgpu_bo);
> -	bp.resv = vm->root.bo->tbo.base.resv;
> -
> -	r = amdgpu_bo_create(adev, &bp, &cwsr->tma_bo);
> -	if (r)
> -		goto err_exec;
> -
> -	/* VM resv already held, kmap directly, no separate reserve needed. */
> -	r = amdgpu_bo_kmap(cwsr->tma_bo, &cwsr->tma_cpu_addr);
> -	if (r)
> -		goto err_tma;
> -
> -	memset(cwsr->tma_cpu_addr, 0, AMDGPU_CWSR_TMA_MAX_SIZE);
> -
> -	r = amdgpu_cwsr_map_region(adev, vm, cwsr, AMDGPU_CWSR_TMA);
> -	if (r)
> -		goto err_kmap;
> -
> -	r = amdgpu_cwsr_map_region(adev, vm, cwsr, AMDGPU_CWSR_TBA);
> -	if (r) {
> -		amdgpu_cwsr_unmap_region(adev, cwsr, AMDGPU_CWSR_TMA);
> -		goto err_kmap;
> -	}
> -
> -	drm_exec_fini(&exec);
> -	*trap_obj = cwsr;
> -	return 0;
> -
> -err_kmap:
> -	amdgpu_bo_kunmap(cwsr->tma_bo);
> -err_tma:
> -	amdgpu_bo_unref(&cwsr->tma_bo);
> -err_exec:
> -	drm_exec_fini(&exec);
> -	kfree(cwsr);
> -	*trap_obj = NULL;
> -	return r;
> -}
> -
> -int amdgpu_cwsr_validate_params(struct amdgpu_device *adev,
> -				struct amdgpu_cwsr_params *cwsr_params,
> -				int num_xcc)
> -{
> -	uint32_t min_size, max_size;
> -
> -	if (!amdgpu_cwsr_is_enabled(adev))
> -		return -EOPNOTSUPP;
> -
> -	if (!cwsr_params)
> -		return -EINVAL;
> -
> -	min_size = amdgpu_cwsr_size_needed(adev, num_xcc);
> -	max_size = 2 * min_size;
> -	/*
> -	 * Only save area size details checked. Address validation needs to be
> -	 * carried out separately. User is expected to pass a cwsr buffer area
> -	 * with size >= ctl stack size + wg data size + debug memory size
> -	 */
> -	if (cwsr_params->cwsr_sz < min_size ||
> -	    cwsr_params->cwsr_sz > max_size) {
> -		dev_dbg(adev->dev,
> -			"queue cwsr size 0x%x should be within min %u : max %u\n",
> -			cwsr_params->cwsr_sz, min_size, max_size);
> -		return -EINVAL;
> -	}
> -
> -	return 0;
> -}
> -
> -void amdgpu_cwsr_free(struct amdgpu_device *adev, struct amdgpu_vm *vm,
> -		      struct amdgpu_cwsr_trap_obj **trap_obj)
> -{
> -	struct amdgpu_bo *tba_bo;
> -	struct amdgpu_bo *tma_bo;
> -	struct drm_exec exec;
> -	int r;
> -
> -	if (!trap_obj || !*trap_obj || !(*trap_obj)->tma_bo)
> -		return;
> -
> -	tba_bo = adev->cwsr_info->isa_bo;
> -	tma_bo = (*trap_obj)->tma_bo;
> -
> -	if (!tba_bo || !tma_bo)
> -		return;
> -
> -	drm_exec_init(&exec, 0, 0);
> -	drm_exec_until_all_locked(&exec) {
> -		r = amdgpu_vm_lock_pd(vm, &exec, 0);
> -		if (likely(!r))
> -			r = drm_exec_lock_obj(&exec, &tba_bo->tbo.base);
> -		drm_exec_retry_on_contention(&exec);
> -		if (unlikely(r)) {
> -			dev_err(adev->dev,
> -				"failed to reserve CWSR BOs: err=%d\n", r);
> -			goto err;
> -		}
> -	}
> -
> -	amdgpu_cwsr_unmap_region(adev, *trap_obj, AMDGPU_CWSR_TBA);
> -	amdgpu_cwsr_unmap_region(adev, *trap_obj, AMDGPU_CWSR_TMA);
> -
> -err:
> -	drm_exec_fini(&exec);
> -
> -	/* TMA BO not pinned, release CPU mapping and free. */
> -	amdgpu_bo_kunmap((*trap_obj)->tma_bo);
> -	amdgpu_bo_unref(&(*trap_obj)->tma_bo);
> -	kfree(*trap_obj);
> -	*trap_obj = NULL;
> -}
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_cwsr.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_cwsr.h
> deleted file mode 100644
> index 5717e1d662fc..000000000000
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_cwsr.h
> +++ /dev/null
> @@ -1,87 +0,0 @@
> -/*
> - * Copyright 2025 Advanced Micro Devices, Inc.
> - *
> - * Permission is hereby granted, free of charge, to any person obtaining a
> - * copy of this software and associated documentation files (the "Software"),
> - * to deal in the Software without restriction, including without limitation
> - * the rights to use, copy, modify, merge, publish, distribute, sublicense,
> - * and/or sell copies of the Software, and to permit persons to whom the
> - * Software is furnished to do so, subject to the following conditions:
> - *
> - * The above copyright notice and this permission notice shall be included in
> - * all copies or substantial portions of the Software.
> - *
> - * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
> - * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
> - * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.  IN NO EVENT SHALL
> - * THE COPYRIGHT HOLDER(S) OR AUTHOR(S) BE LIABLE FOR ANY CLAIM, DAMAGES OR
> - * OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE,
> - * ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
> - * OTHER DEALINGS IN THE SOFTWARE.
> - */
> -
> -#ifndef AMDGPU_CWSR_H
> -#define AMDGPU_CWSR_H
> -
> -#include <linux/types.h>
> -
> -struct amdgpu_bo;
> -struct amdgpu_bo_va;
> -struct amdgpu_device;
> -struct amdgpu_vm;
> -
> -/**
> - * struct amdgpu_cwsr_obj - CWSR (Compute Wave Save Restore) buffer tracking
> - * @bo: Buffer object for CWSR area
> - * @bo_va: Buffer object virtual address mapping
> - */
> -struct amdgpu_cwsr_trap_obj {
> -	uint64_t tma_gpu_va_addr;
> -	uint64_t tba_gpu_va_addr;
> -
> -	struct amdgpu_bo *tma_bo;
> -	struct amdgpu_bo_va *tba_va;
> -	struct amdgpu_bo_va *tma_va;
> -	void *tma_cpu_addr;
> -};
> -
> -struct amdgpu_cwsr_info {
> -	/* cwsr isa */
> -	struct amdgpu_bo *isa_bo;
> -	const void *isa_buf;
> -	uint32_t isa_sz;
> -	/* cwsr size info per XCC*/
> -	uint32_t xcc_ctl_stack_sz;
> -	uint32_t xcc_dbg_mem_sz;
> -	uint32_t xcc_cwsr_sz;
> -};
> -
> -struct amdgpu_cwsr_params {
> -	uint64_t ctx_save_area_address;
> -	/* cwsr size info */
> -	uint32_t cwsr_sz;
> -};
> -
> -int amdgpu_cwsr_init(struct amdgpu_device *adev);
> -void amdgpu_cwsr_fini(struct amdgpu_device *adev);
> -
> -int amdgpu_cwsr_alloc(struct amdgpu_device *adev, struct amdgpu_vm *vm,
> -		      struct amdgpu_cwsr_trap_obj **cwsr_obj);
> -void amdgpu_cwsr_free(struct amdgpu_device *adev, struct amdgpu_vm *vm,
> -		      struct amdgpu_cwsr_trap_obj **cwsr_obj);
> -static inline bool amdgpu_cwsr_is_enabled(struct amdgpu_device *adev)
> -{
> -	return adev->cwsr_info != NULL;
> -}
> -
> -uint32_t amdgpu_cwsr_size_needed(struct amdgpu_device *adev, int num_xcc);
> -int amdgpu_cwsr_validate_params(struct amdgpu_device *adev,
> -				struct amdgpu_cwsr_params *cwsr_params,
> -				int num_xcc);
> -static inline bool amdgpu_cwsr_has_dbg_wa(struct amdgpu_device *adev)
> -{
> -	uint32_t gc_ver = amdgpu_ip_version(adev, GC_HWIP, 0);
> -
> -	return gc_ver >= IP_VERSION(11, 0, 0) && gc_ver <= IP_VERSION(11, 0, 3);
> -}
> -#endif
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> index 5a7f111763bf..6bac724fc73f 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> @@ -81,7 +81,7 @@
>  #include "amdgpu_reset.h"
>  #include "amdgpu_virt.h"
>  #include "amdgpu_dev_coredump.h"
> -#include "amdgpu_cwsr.h"
> +#include "amdgpu_trap.h"
>  
>  #include <linux/suspend.h>
>  #include <drm/task_barrier.h>
> @@ -2551,7 +2551,7 @@ static int amdgpu_device_ip_init(struct amdgpu_device *adev)
>  	r = amdgpu_cper_init(adev);
>  
>  	if (!r) {
> -		r = amdgpu_cwsr_init(adev);
> +		r = amdgpu_trap_init(adev);
>  		if (r == -EOPNOTSUPP)
>  			r = 0;
>  	}
> @@ -2953,7 +2953,7 @@ static int amdgpu_device_ip_fini(struct amdgpu_device *adev)
>  {
>  	int i, r;
>  
> -	amdgpu_cwsr_fini(adev);
> +	amdgpu_trap_fini(adev);
>  	amdgpu_cper_fini(adev);
>  
>  	if (amdgpu_sriov_vf(adev) && adev->virt.ras_init_done)
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> index b2a8a8b37006..77675c895585 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> @@ -52,6 +52,7 @@
>  #include "amdgpu_sched.h"
>  #include "amdgpu_xgmi.h"
>  #include "amdgpu_userq.h"
> +#include "amdgpu_trap.h"
>  #include "amdgpu_userq_fence.h"
>  #include "../amdxcp/amdgpu_xcp_drv.h"
>  #include "amdgpu_ualink.h"
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
> index 147c0bd02731..6839d92b9730 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
> @@ -50,7 +50,7 @@
>  #include "amdgpu_video_codecs.h"
>  #include "amdgpu_ras_mgr.h"
>  #include "amdgpu_vm.h"
> -#include "amdgpu_cwsr.h"
> +#include "amdgpu_trap.h"
>  
>  void amdgpu_unregister_gpu_instance(struct amdgpu_device *adev)
>  {
> @@ -1434,15 +1434,15 @@ int amdgpu_info_ioctl(struct drm_device *dev, void *data, struct drm_file *filp)
>  		int num_xcc, r;
>  
>  		fpriv = (struct amdgpu_fpriv *)filp->driver_priv;
> -		if (!amdgpu_cwsr_is_enabled(adev) || !fpriv->cwsr_trap)
> +		if (!amdgpu_trap_is_enabled(adev) || !fpriv->trap_obj)
>  			return -EOPNOTSUPP;
>  		num_xcc = amdgpu_xcp_get_num_xcc(adev->xcp_mgr, fpriv->xcp_id);
>  		cwsr_info.ctl_stack_size =
> -			adev->cwsr_info->xcc_ctl_stack_sz * num_xcc;
> +			adev->trap_info->cwsr.xcc_ctl_stack_sz * num_xcc;
>  		cwsr_info.dbg_mem_size =
> -			adev->cwsr_info->xcc_dbg_mem_sz * num_xcc;
> +			adev->trap_info->cwsr.xcc_dbg_mem_sz * num_xcc;
>  		cwsr_info.min_save_area_size =
> -			amdgpu_cwsr_size_needed(adev, num_xcc);
> +			amdgpu_trap_size_needed(adev, num_xcc);
>  		r = copy_to_user(out, &cwsr_info,
>  				 min((size_t)size, sizeof(cwsr_info))) ?
>  			    -EFAULT :
> @@ -1576,10 +1576,10 @@ int amdgpu_driver_open_kms(struct drm_device *dev, struct drm_file *file_priv)
>  
>  	amdgpu_evf_mgr_init(&fpriv->evf_mgr);
>  
> -	if (amdgpu_cwsr_is_enabled(adev)) {
> -		r = amdgpu_cwsr_alloc(adev, &fpriv->vm, &fpriv->cwsr_trap);
> +	if (amdgpu_trap_is_enabled(adev)) {
> +		r = amdgpu_trap_alloc(adev, &fpriv->vm, &fpriv->trap_obj);
>  		if (r)
> -			dev_dbg(adev->dev, "cwsr trap not enabled");
> +			dev_dbg(adev->dev, "trap handler not enabled");
>  	}
>  
>  	amdgpu_ctx_mgr_init(&fpriv->ctx_mgr, adev);
> @@ -1651,7 +1651,7 @@ void amdgpu_driver_postclose_kms(struct drm_device *dev,
>  	}
>  
>  	amdgpu_ctx_mgr_fini(&fpriv->ctx_mgr);
> -	amdgpu_cwsr_free(adev, &fpriv->vm, &fpriv->cwsr_trap);
> +	amdgpu_trap_free(adev, &fpriv->vm, &fpriv->trap_obj);
>  
>  	if (pasid)
>  		amdgpu_pasid_free_delayed(pd->tbo.base.resv, pasid);
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_trap.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_trap.c
> new file mode 100644
> index 000000000000..12e37d0467f9
> --- /dev/null
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_trap.c
> @@ -0,0 +1,753 @@
> +/*
> + * Copyright 2025 Advanced Micro Devices, Inc.
> + *
> + * Permission is hereby granted, free of charge, to any person obtaining a
> + * copy of this software and associated documentation files (the "Software"),
> + * to deal in the Software without restriction, including without limitation
> + * the rights to use, copy, modify, merge, publish, distribute, sublicense,
> + * and/or sell copies of the Software, and to permit persons to whom the
> + * Software is furnished to do so, subject to the following conditions:
> + *
> + * The above copyright notice and this permission notice shall be included in
> + * all copies or substantial portions of the Software.
> + *
> + * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
> + * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
> + * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.  IN NO EVENT SHALL
> + * THE COPYRIGHT HOLDER(S) OR AUTHOR(S) BE LIABLE FOR ANY CLAIM, DAMAGES OR
> + * OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE,
> + * ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
> + * OTHER DEALINGS IN THE SOFTWARE.
> + */
> +#include <linux/iosys-map.h>
> +
> +#include <drm/ttm/ttm_bo.h>
> +#include <drm/drm_exec.h>
> +
> +#include "amdgpu.h"
> +#include "cwsr_trap_handler.h"
> +#include "amdgpu_trap.h"
> +
> +/*
> + * First-level TMA layout used by the second-level trap-handler ABI.
> + * The trap-handler ISA reads L2 TBA at offset 0 and L2 TMA at offset 8.
> + */
> +#define AMDGPU_TRAP_L2_TBA_INDEX	0
> +#define AMDGPU_TRAP_L2_TMA_INDEX	1
> +#define AMDGPU_TRAP_DEBUG_FLAG_INDEX	2
> +
> +extern int cwsr_enable;
> +
> +#define AMDGPU_TRAP_TBA_MAX_SIZE (2 * AMDGPU_GPU_PAGE_SIZE)
> +#define AMDGPU_TRAP_TMA_MAX_SIZE (AMDGPU_GPU_PAGE_SIZE)
> +#define AMDGPU_TRAP_TMA_OFFSET (AMDGPU_TRAP_TBA_MAX_SIZE)
> +
> +#define SGPR_SIZE_PER_CU 0x4000
> +#define LDS_SIZE_PER_CU 0x10000
> +#define HWREG_SIZE_PER_CU 0x1000
> +#define DEBUGGER_BYTES_ALIGN 64
> +#define DEBUGGER_BYTES_PER_WAVE 32
> +#define SIZEOF_HSA_USER_CONTEXT_SAVE_AREA_HEADER 40
> +
> +enum amdgpu_trap_region {
> +	AMDGPU_TRAP_TBA,
> +	AMDGPU_TRAP_TMA,
> +};
> +
> +static inline uint64_t amdgpu_trap_tba_vaddr(struct amdgpu_device *adev)
> +{
> +	u64 addr = AMDGPU_VA_RESERVED_TRAP_UQ_START(adev);
> +
> +	addr = amdgpu_gmc_sign_extend(addr);
> +
> +	return addr;
> +}
> +
> +static inline bool amdgpu_trap_is_supported(struct amdgpu_device *adev)
> +{
> +	u32 gc_ver = amdgpu_ip_version(adev, GC_HWIP, 0);
> +
> +	if (!cwsr_enable || gc_ver < IP_VERSION(9, 0, 1))
> +		return false;
> +
> +	return true;
> +}
> +
> +uint32_t amdgpu_trap_size_needed(struct amdgpu_device *adev, int num_xcc)
> +{
> +	if (!amdgpu_trap_is_enabled(adev))
> +		return 0;
> +
> +	return num_xcc *
> +	       (adev->trap_info->cwsr.xcc_cwsr_sz + adev->trap_info->cwsr.xcc_dbg_mem_sz);
> +}
> +
> +static void amdgpu_trap_cwsr_init_isa_details(struct amdgpu_device *adev,
> +					      struct amdgpu_trap_info *trap_info)
> +{
> +	u32 gc_ver = amdgpu_ip_version(adev, GC_HWIP, 0);
> +
> +	if (gc_ver < IP_VERSION(9, 0, 1)) {
> +		BUILD_BUG_ON(sizeof(cwsr_trap_gfx8_hex) >
> +			     AMDGPU_TRAP_TBA_MAX_SIZE);
> +		trap_info->isa_buf = cwsr_trap_gfx8_hex;
> +		trap_info->isa_sz = sizeof(cwsr_trap_gfx8_hex);
> +	} else if (gc_ver == IP_VERSION(9, 4, 1)) {
> +		BUILD_BUG_ON(sizeof(cwsr_trap_arcturus_hex) >
> +			     AMDGPU_TRAP_TBA_MAX_SIZE);
> +		trap_info->isa_buf = cwsr_trap_arcturus_hex;
> +		trap_info->isa_sz = sizeof(cwsr_trap_arcturus_hex);
> +	} else if (gc_ver == IP_VERSION(9, 4, 2)) {
> +		BUILD_BUG_ON(sizeof(cwsr_trap_aldebaran_hex) >
> +			     AMDGPU_TRAP_TBA_MAX_SIZE);
> +		trap_info->isa_buf = cwsr_trap_aldebaran_hex;
> +		trap_info->isa_sz = sizeof(cwsr_trap_aldebaran_hex);
> +	} else if (gc_ver == IP_VERSION(9, 4, 3) ||
> +		   gc_ver == IP_VERSION(9, 4, 4)) {
> +		BUILD_BUG_ON(sizeof(cwsr_trap_gfx9_4_3_hex) >
> +			     AMDGPU_TRAP_TBA_MAX_SIZE);
> +		trap_info->isa_buf = cwsr_trap_gfx9_4_3_hex;
> +		trap_info->isa_sz = sizeof(cwsr_trap_gfx9_4_3_hex);
> +	} else if (gc_ver == IP_VERSION(9, 5, 0)) {
> +		BUILD_BUG_ON(sizeof(cwsr_trap_gfx9_5_0_hex) > PAGE_SIZE);
> +		trap_info->isa_buf = cwsr_trap_gfx9_5_0_hex;
> +		trap_info->isa_sz = sizeof(cwsr_trap_gfx9_5_0_hex);
> +	} else if (gc_ver < IP_VERSION(10, 1, 1)) {
> +		BUILD_BUG_ON(sizeof(cwsr_trap_gfx9_hex) >
> +			     AMDGPU_TRAP_TBA_MAX_SIZE);
> +		trap_info->isa_buf = cwsr_trap_gfx9_hex;
> +		trap_info->isa_sz = sizeof(cwsr_trap_gfx9_hex);
> +	} else if (gc_ver < IP_VERSION(10, 3, 0)) {
> +		BUILD_BUG_ON(sizeof(cwsr_trap_nv1x_hex) >
> +			     AMDGPU_TRAP_TBA_MAX_SIZE);
> +		trap_info->isa_buf = cwsr_trap_nv1x_hex;
> +		trap_info->isa_sz = sizeof(cwsr_trap_nv1x_hex);
> +	} else if (gc_ver < IP_VERSION(11, 0, 0)) {
> +		BUILD_BUG_ON(sizeof(cwsr_trap_gfx10_hex) >
> +			     AMDGPU_TRAP_TBA_MAX_SIZE);
> +		trap_info->isa_buf = cwsr_trap_gfx10_hex;
> +		trap_info->isa_sz = sizeof(cwsr_trap_gfx10_hex);
> +	} else if (gc_ver < IP_VERSION(12, 0, 0)) {
> +		/* The gfx11 cwsr trap handler must fit inside a single
> +			   page. */
> +		BUILD_BUG_ON(sizeof(cwsr_trap_gfx11_hex) > PAGE_SIZE);
> +		trap_info->isa_buf = cwsr_trap_gfx11_hex;
> +		trap_info->isa_sz = sizeof(cwsr_trap_gfx11_hex);
> +	} else if (gc_ver < IP_VERSION(12, 1, 0)) {
> +		BUILD_BUG_ON(sizeof(cwsr_trap_gfx12_hex) >
> +			     AMDGPU_TRAP_TBA_MAX_SIZE);
> +		trap_info->isa_buf = cwsr_trap_gfx12_hex;
> +		trap_info->isa_sz = sizeof(cwsr_trap_gfx12_hex);
> +	} else {
> +		BUILD_BUG_ON(sizeof(cwsr_trap_gfx12_1_0_hex) >
> +			     AMDGPU_TRAP_TBA_MAX_SIZE);
> +		trap_info->isa_buf = cwsr_trap_gfx12_1_0_hex;
> +		trap_info->isa_sz = sizeof(cwsr_trap_gfx12_1_0_hex);
> +	}
> +}
> +
> +static uint32_t amdgpu_trap_cwsr_get_vgpr_size_per_cu(struct amdgpu_device *adev)
> +{
> +	u32 gc_ver = amdgpu_ip_version(adev, GC_HWIP, 0);
> +	u32 vgpr_size;
> +
> +	switch (gc_ver) {
> +	case IP_VERSION(9, 4, 1): /* GFX_VERSION_ARCTURUS */
> +	case IP_VERSION(9, 4, 2): /* GFX_VERSION_ALDEBARAN */
> +	case IP_VERSION(9, 4, 3): /* GFX_VERSION_AQUA_VANJARAM */
> +	case IP_VERSION(9, 4, 4): /* GFX_VERSION_AQUA_VANJARAM */
> +	case IP_VERSION(9, 5, 0):
> +		vgpr_size = 0x80000;
> +		break;
> +	case IP_VERSION(11, 0, 0):
> +	case IP_VERSION(11, 0, 2):
> +	case IP_VERSION(11, 0, 3):
> +	case IP_VERSION(12, 0, 0):
> +	case IP_VERSION(12, 0, 1):
> +		vgpr_size = 0x60000;
> +		break;
> +	default:
> +		vgpr_size = 0x40000;
> +		break;
> +	}
> +
> +	return vgpr_size;
> +}
> +
> +static uint32_t amdgpu_trap_cwsr_get_wg_ctxt_size_per_cu(struct amdgpu_device *adev)
> +{
> +	u32 lds_sz_per_cu;
> +
> +	lds_sz_per_cu =
> +		(amdgpu_ip_version(adev, GC_HWIP, 0) == IP_VERSION(9, 5, 0)) ?
> +			(adev->gfx.cu_info.lds_size << 10) :
> +			LDS_SIZE_PER_CU;
> +
> +	return amdgpu_trap_cwsr_get_vgpr_size_per_cu(adev) + SGPR_SIZE_PER_CU +
> +	       lds_sz_per_cu + HWREG_SIZE_PER_CU;
> +}
> +
> +static uint32_t amdgpu_trap_cwsr_ctl_stack_bytes_per_wave(struct amdgpu_device *adev)
> +{
> +	u32 sz;
> +
> +	if (amdgpu_ip_version(adev, GC_HWIP, 0) >= IP_VERSION(10, 1, 0))
> +		sz = 12;
> +	else
> +		sz = 8;
> +	return sz;
> +}
> +
> +static void amdgpu_trap_cwsr_init_save_area_info(struct amdgpu_device *adev,
> +						 struct amdgpu_trap_info *trap_info)
> +{
> +	struct amdgpu_gfx_config *gfx_info = &adev->gfx.config;
> +	u32 gc_ver = amdgpu_ip_version(adev, GC_HWIP, 0);
> +	u32 ctl_stack_size, wg_data_size, dbg_mem_size;
> +	u32 array_count;
> +	u32 wave_num;
> +	u32 cu_num;
> +
> +	if (gc_ver < IP_VERSION(9, 0, 1))
> +		return;
> +
> +	array_count = gfx_info->max_shader_engines * gfx_info->max_sh_per_se;
> +
> +	cu_num = adev->gfx.cu_info.number / NUM_XCC(adev->gfx.xcc_mask);
> +	wave_num = (gc_ver < IP_VERSION(10, 1, 0)) ? /* GFX_VERSION_NAVI10 */
> +			   min(cu_num * 40,
> +			       array_count / gfx_info->max_sh_per_se * 512) :
> +			   cu_num * 32;
> +
> +	wg_data_size = ALIGN(cu_num * amdgpu_trap_cwsr_get_wg_ctxt_size_per_cu(adev),
> +			     PAGE_SIZE);
> +	ctl_stack_size =
> +		wave_num * amdgpu_trap_cwsr_ctl_stack_bytes_per_wave(adev) + 8;
> +	ctl_stack_size =
> +		ALIGN(SIZEOF_HSA_USER_CONTEXT_SAVE_AREA_HEADER + ctl_stack_size,
> +		      PAGE_SIZE);
> +	dbg_mem_size =
> +		ALIGN(wave_num * DEBUGGER_BYTES_PER_WAVE, DEBUGGER_BYTES_ALIGN);
> +	/*
> +	* HW design limits control stack size to 0x7000.
> +	* This is insufficient for theoretical PM4 cases
> +	* but sufficient for AQL, limited by SPI events.
> +	*/
> +	if (IP_VERSION_MAJ(gc_ver) == 10)
> +		ctl_stack_size = min(ctl_stack_size, 0x7000);
> +
> +	trap_info->cwsr.xcc_ctl_stack_sz = ctl_stack_size;
> +	trap_info->cwsr.xcc_cwsr_sz = ctl_stack_size + wg_data_size;
> +	trap_info->cwsr.xcc_dbg_mem_sz = dbg_mem_size;
> +}
> +
> +int amdgpu_trap_init(struct amdgpu_device *adev)
> +{
> +	struct amdgpu_trap_info *trap_info __free(kfree) =
> +		kzalloc(sizeof(*trap_info), GFP_KERNEL);
> +	void *ptr;
> +	int r;
> +
> +	if (!amdgpu_trap_is_supported(adev))
> +		return -EOPNOTSUPP;
> +
> +	if (!trap_info)
> +		return -ENOMEM;
> +	amdgpu_trap_cwsr_init_isa_details(adev, trap_info);
> +
> +	if (!trap_info->isa_sz)
> +		return -EOPNOTSUPP;
> +
> +	r = amdgpu_bo_create_kernel(adev, AMDGPU_TRAP_TBA_MAX_SIZE, PAGE_SIZE,
> +				    AMDGPU_GEM_DOMAIN_GTT, &trap_info->isa_bo,
> +				    NULL, &ptr);
> +	if (r)
> +		return r;
> +
> +	memcpy(ptr, trap_info->isa_buf, trap_info->isa_sz);
> +
> +	amdgpu_trap_cwsr_init_save_area_info(adev, trap_info);
> +	adev->trap_info = no_free_ptr(trap_info);
> +
> +	return 0;
> +}
> +
> +void amdgpu_trap_fini(struct amdgpu_device *adev)
> +{
> +	if (!amdgpu_trap_is_enabled(adev))
> +		return;
> +
> +	amdgpu_bo_free_kernel(&adev->trap_info->isa_bo, NULL, NULL);
> +	kfree(adev->trap_info);
> +	adev->trap_info = NULL;
> +}
> +
> +/*
> + * amdgpu_map_cwsr_trap_handler should be called during amdgpu_vm_init
> + * it maps virtual address amdgpu_trap_tba_vaddr() to this VM, and each
> + * compute queue can use this virtual address for wave save/restore
> + * operations to support compute preemption.
> + */
> +static int amdgpu_trap_map_region(struct amdgpu_device *adev,
> +				  struct amdgpu_vm *vm,
> +				  struct amdgpu_trap_obj *cwsr,
> +				  enum amdgpu_trap_region region)
> +{
> +	u64 cwsr_addr, va_flags, va;
> +	struct amdgpu_bo_va **bo_va;
> +	struct amdgpu_bo *bo;
> +	u32 size;
> +	int r;
> +
> +	if (!cwsr || !vm)
> +		return -EINVAL;
> +
> +	cwsr_addr = amdgpu_trap_tba_vaddr(adev);
> +
> +	if (region == AMDGPU_TRAP_TBA) {
> +		size = AMDGPU_TRAP_TBA_MAX_SIZE;
> +		bo_va = &cwsr->tba_va;
> +		bo = adev->trap_info->isa_bo;
> +		va = cwsr_addr;
> +		va_flags = (AMDGPU_VM_PAGE_READABLE | AMDGPU_VM_PAGE_WRITEABLE |
> +			    AMDGPU_VM_PAGE_EXECUTABLE);
> +	} else {
> +		size = AMDGPU_TRAP_TMA_MAX_SIZE;
> +		bo_va = &cwsr->tma_va;
> +		bo = cwsr->tma_bo;
> +		va = cwsr_addr + AMDGPU_TRAP_TMA_OFFSET;
> +		va_flags = (AMDGPU_VM_PAGE_READABLE | AMDGPU_VM_PAGE_WRITEABLE);
> +	}
> +
> +	*bo_va = amdgpu_vm_bo_add(adev, vm, bo);
> +	if (!*bo_va)
> +		return -ENOMEM;
> +
> +	va &= AMDGPU_GMC_HOLE_MASK;
> +	r = amdgpu_vm_bo_map(adev, *bo_va, va, 0, size, va_flags);
> +	if (r) {
> +		dev_err(adev->dev, "failed to do bo map of %s region, err=%d\n",
> +			(region == AMDGPU_TRAP_TBA ? "tba" : "tma"), r);
> +		amdgpu_vm_bo_del(adev, *bo_va);
> +		*bo_va = NULL;
> +		return r;
> +	}
> +
> +	r = amdgpu_vm_bo_update(adev, *bo_va, false);
> +	if (r) {
> +		dev_err(adev->dev,
> +			"failed to do page table update of %s region, err=%d\n",
> +			(region == AMDGPU_TRAP_TBA ? "tba" : "tma"), r);
> +		amdgpu_vm_bo_del(adev, *bo_va);
> +		*bo_va = NULL;
> +		return r;
> +	}
> +
> +	if (region == AMDGPU_TRAP_TBA)
> +		cwsr->tba_gpu_va_addr = va;
> +	else
> +		cwsr->tma_gpu_va_addr = va;
> +
> +	return 0;
> +}
> +
> +static int amdgpu_trap_unmap_region(struct amdgpu_device *adev,
> +				    struct amdgpu_trap_obj *cwsr,
> +				    enum amdgpu_trap_region region)
> +{
> +	struct amdgpu_bo_va **bo_va;
> +	u64 va;
> +	int r;
> +
> +	if (!cwsr)
> +		return -EINVAL;
> +
> +	if (region == AMDGPU_TRAP_TBA) {
> +		bo_va = &cwsr->tba_va;
> +		va = cwsr->tba_gpu_va_addr;
> +	} else {
> +		bo_va = &cwsr->tma_va;
> +		va = cwsr->tma_gpu_va_addr;
> +	}
> +
> +	r = amdgpu_vm_bo_unmap(adev, *bo_va, va);
> +	if (r) {
> +		dev_err(adev->dev,
> +			"failed to do bo_unmap on CWSR trap handler, err=%d\n",
> +			r);
> +		return r;
> +	}
> +
> +	amdgpu_vm_bo_del(adev, *bo_va);
> +	*bo_va = NULL;
> +
> +	return r;
> +}
> +
> +int amdgpu_trap_alloc(struct amdgpu_device *adev, struct amdgpu_vm *vm,
> +		      struct amdgpu_trap_obj **trap_obj)
> +{
> +	struct amdgpu_bo_param bp;
> +	struct iosys_map map;
> +	struct amdgpu_trap_obj *cwsr;
> +	struct amdgpu_bo *bo;
> +	struct drm_exec exec;
> +	int r;
> +
> +	if (!amdgpu_trap_is_enabled(adev))
> +		return -EOPNOTSUPP;
> +
> +	if (!vm || !trap_obj)
> +		return -EINVAL;
> +
> +	cwsr = kzalloc_obj(*cwsr, GFP_KERNEL);
> +	if (!cwsr)
> +		return -ENOMEM;
> +
> +	bo = adev->trap_info->isa_bo;
> +
> +	drm_exec_init(&exec, DRM_EXEC_INTERRUPTIBLE_WAIT, 0);
> +	drm_exec_until_all_locked(&exec) {
> +		r = amdgpu_vm_lock_pd(vm, &exec, 0);
> +		drm_exec_retry_on_contention(&exec);
> +		if (unlikely(r))
> +			goto err_exec;
> +
> +		r = drm_exec_lock_obj(&exec, &bo->tbo.base);
> +		drm_exec_retry_on_contention(&exec);
> +		if (unlikely(r))
> +			goto err_exec;
> +	}
> +
> +	/*
> +	 * Create the TMA BO with the VM root reservation. The reservation is
> +	 * already held by drm_exec, so creating the BO doesn't recursively
> +	 * acquire another reservation_ww_class_mutex. The TMA remains
> +	 * unpinned and is covered by the VM root reservation.
> +	 */
> +	memset(&bp, 0, sizeof(bp));
> +	bp.size = AMDGPU_TRAP_TMA_MAX_SIZE;
> +	bp.byte_align = PAGE_SIZE;
> +	bp.domain = AMDGPU_GEM_DOMAIN_GTT;
> +	bp.flags = AMDGPU_GEM_CREATE_CPU_GTT_USWC |
> +		   AMDGPU_GEM_CREATE_CPU_ACCESS_REQUIRED;
> +	bp.type = ttm_bo_type_kernel;
> +	bp.bo_ptr_size = sizeof(struct amdgpu_bo);
> +	bp.resv = vm->root.bo->tbo.base.resv;
> +
> +	r = amdgpu_bo_create(adev, &bp, &cwsr->tma_bo);
> +	if (r)
> +		goto err_exec;
> +
> +	/*
> +	 * The TMA BO is unpinned and movable. Map it only while accessing
> +	 * its contents so that no CPU mapping can become stale across BO
> +	 * migration. ttm_bo_vmap() and ttm_bo_vunmap() require the BO
> +	 * reservation, which is the already held VM root reservation.
> +	 */
> +	r = ttm_bo_vmap(&cwsr->tma_bo->tbo, &map);
> +	if (r)
> +		goto err_tma;
> +
> +	/*
> +	 * Finish initialization with a DMA write barrier before allowing
> +	 * the GPU to observe the contents.
> +	 */
> +	iosys_map_memset(&map, 0, 0, AMDGPU_TRAP_TMA_MAX_SIZE);
> +	dma_wmb();
> +
> +	ttm_bo_vunmap(&cwsr->tma_bo->tbo, &map);
> +
> +	r = amdgpu_trap_map_region(adev, vm, cwsr, AMDGPU_TRAP_TMA);
> +	if (r)
> +		goto err_tma;
> +
> +	r = amdgpu_trap_map_region(adev, vm, cwsr, AMDGPU_TRAP_TBA);
> +	if (r) {
> +		amdgpu_trap_unmap_region(adev, cwsr, AMDGPU_TRAP_TMA);
> +		goto err_tma;
> +	}
> +
> +	drm_exec_fini(&exec);
> +
> +	*trap_obj = cwsr;
> +
> +	return 0;
> +
> +err_tma:
> +	amdgpu_bo_unref(&cwsr->tma_bo);
> +
> +err_exec:
> +	drm_exec_fini(&exec);
> +	kfree(cwsr);
> +	*trap_obj = NULL;
> +
> +	return r;
> +}
> +
> +static int amdgpu_trap_update_l2_handler(struct amdgpu_trap_obj *trap_obj,
> +					 u64 tba, u64 tma)
> +{
> +	struct iosys_map map;
> +	int r;
> +
> +	if (!trap_obj || !trap_obj->tma_bo)
> +		return -EINVAL;
> +
> +	dma_resv_assert_held(trap_obj->tma_bo->tbo.base.resv);
> +
> +	r = ttm_bo_vmap(&trap_obj->tma_bo->tbo, &map);
> +	if (r)
> +		return r;
> +
> +	/*
> +	 * Publish both descriptor fields before allowing the GPU to observe
> +	 * the updated second-level trap handler.
> +	 */
> +	iosys_map_wr(&map, AMDGPU_TRAP_L2_TBA_INDEX * sizeof(u64),
> +		     u64, tba);
> +	iosys_map_wr(&map, AMDGPU_TRAP_L2_TMA_INDEX * sizeof(u64),
> +		     u64, tma);
> +	dma_wmb();
> +
> +	ttm_bo_vunmap(&trap_obj->tma_bo->tbo, &map);
> +
> +	return 0;
> +}
> +
> +static int amdgpu_trap_clear_l2_handler(struct amdgpu_vm *vm,
> +					struct amdgpu_trap_obj *trap_obj)
> +{
> +	if (!trap_obj || !trap_obj->tma_bo)
> +		return -EINVAL;
> +
> +	dma_resv_assert_held(vm->root.bo->tbo.base.resv);
> +
> +	return amdgpu_trap_update_l2_handler(trap_obj, 0, 0);
> +}
> +
> +int amdgpu_trap_validate_params(struct amdgpu_device *adev,
> +				struct amdgpu_trap_params *trap_params,
> +				int num_xcc)
> +{
> +	u32 min_size, max_size;
> +
> +	if (!amdgpu_trap_is_enabled(adev))
> +		return -EOPNOTSUPP;
> +
> +	if (!trap_params)
> +		return -EINVAL;
> +
> +	min_size = amdgpu_trap_size_needed(adev, num_xcc);
> +	max_size = 2 * min_size;
> +	/*
> +	 * Only save area size details checked. Address validation needs to be
> +	 * carried out separately. User is expected to pass a cwsr buffer area
> +	 * with size >= ctl stack size + wg data size + debug memory size
> +	 */
> +	if (trap_params->cwsr_sz < min_size ||
> +	    trap_params->cwsr_sz > max_size) {
> +		dev_dbg(adev->dev,
> +			"queue cwsr size 0x%x should be within min %u : max %u\n",
> +			trap_params->cwsr_sz, min_size, max_size);
> +		return -EINVAL;
> +	}
> +
> +	return 0;
> +}
> +
> +void amdgpu_trap_free(struct amdgpu_device *adev, struct amdgpu_vm *vm,
> +		      struct amdgpu_trap_obj **trap_obj)
> +{
> +	struct amdgpu_bo *tba_bo;
> +	struct drm_exec exec;
> +	int r;
> +
> +	if (!trap_obj || !*trap_obj)
> +		return;
> +
> +	tba_bo = adev->trap_info->isa_bo;
> +
> +	drm_exec_init(&exec, 0, 0);
> +	drm_exec_until_all_locked(&exec) {
> +		r = amdgpu_vm_lock_pd(vm, &exec, 0);
> +		drm_exec_retry_on_contention(&exec);
> +		if (unlikely(r))
> +			goto out_exec;
> +
> +		if (tba_bo) {
> +			r = drm_exec_lock_obj(&exec, &tba_bo->tbo.base);
> +			drm_exec_retry_on_contention(&exec);
> +			if (unlikely(r))
> +				goto out_exec;
> +		}
> +	}
> +
> +	if ((*trap_obj)->tba_va) {
> +		amdgpu_vm_bo_del(adev, (*trap_obj)->tba_va);
> +		(*trap_obj)->tba_va = NULL;
> +	}
> +
> +	if ((*trap_obj)->tma_va) {
> +		amdgpu_vm_bo_del(adev, (*trap_obj)->tma_va);
> +		(*trap_obj)->tma_va = NULL;
> +	}
> +
> +	drm_exec_fini(&exec);
> +	amdgpu_bo_unref(&(*trap_obj)->tma_bo);
> +	kfree(*trap_obj);
> +	*trap_obj = NULL;
> +
> +	return;
> +
> +out_exec:
> +	drm_exec_fini(&exec);
> +}
> +
> +static int amdgpu_trap_validate_user_addr(struct amdgpu_device *adev,
> +					  struct amdgpu_vm *vm,
> +					 struct amdgpu_trap_usr_addr *usr_addr)
> +{
> +	struct amdgpu_bo_va_mapping *va_map;
> +	u64 start, end, addr, last;
> +
> +	if (!usr_addr || !usr_addr->size)
> +		return -EINVAL;
> +
> +	dma_resv_assert_held(vm->root.bo->tbo.base.resv);
> +
> +	start = usr_addr->addr & AMDGPU_GMC_HOLE_MASK;
> +
> +	if (check_add_overflow(start, (u64)usr_addr->size - 1, &end))
> +		return -EINVAL;
> +
> +	addr = start >> AMDGPU_GPU_PAGE_SHIFT;
> +	last = end >> AMDGPU_GPU_PAGE_SHIFT;
> +
> +	va_map = amdgpu_vm_bo_lookup_mapping(vm, addr);
> +	if (!va_map)
> +		return -EINVAL;
> +
> +	if (addr < va_map->start || last > va_map->last)
> +		return -EINVAL;
> +
> +	return 0;
> +}
> +
> +int amdgpu_trap_vm_set_l2_trap(struct amdgpu_device *adev,
> +			       struct amdgpu_vm *vm,
> +			       struct amdgpu_trap_obj *trap_obj,
> +			       u64 tba_va, uint32_t tba_sz,
> +			       u64 tma_va, uint32_t tma_sz)
> +{
> +	struct amdgpu_trap_usr_addr tba = {
> +		.addr = tba_va,
> +		.size = tba_sz,
> +	};
> +	struct amdgpu_trap_usr_addr tma = {
> +		.addr = tma_va,
> +		.size = tma_sz,
> +	};
> +	long timeout;
> +	int r;
> +
> +	if (!amdgpu_trap_is_enabled(adev))
> +		return -EOPNOTSUPP;
> +
> +	if (!vm || !trap_obj || !trap_obj->tma_bo)
> +		return -EINVAL;
> +
> +	r = amdgpu_bo_reserve(vm->root.bo, false);
> +	if (r)
> +		return r;
> +
> +	timeout = dma_resv_wait_timeout(vm->root.bo->tbo.base.resv,
> +					DMA_RESV_USAGE_BOOKKEEP,
> +					true, MAX_SCHEDULE_TIMEOUT);
> +	if (timeout <= 0) {
> +		r = timeout < 0 ? timeout : -ETIMEDOUT;
> +		goto out_unreserve;
> +	}
> +
> +	r = amdgpu_trap_validate_user_addr(adev, vm, &tba);
> +	if (r)
> +		goto out_unreserve;
> +
> +	r = amdgpu_trap_validate_user_addr(adev, vm, &tma);
> +	if (r)
> +		goto out_unreserve;
> +
> +	r = amdgpu_trap_update_l2_handler(trap_obj, tba_va, tma_va);
> +
> +out_unreserve:
> +	amdgpu_bo_unreserve(vm->root.bo);
> +
> +	return r;
> +}
> +
> +int amdgpu_trap_vm_clear_l2_trap(struct amdgpu_device *adev,
> +				 struct amdgpu_vm *vm,
> +				 struct amdgpu_trap_obj *trap_obj)
> +{
> +	long timeout;
> +	int r;
> +
> +	if (!amdgpu_trap_is_enabled(adev))
> +		return -EOPNOTSUPP;
> +
> +	if (!vm || !trap_obj || !trap_obj->tma_bo)
> +		return -EINVAL;
> +
> +	r = amdgpu_bo_reserve(vm->root.bo, false);
> +	if (r)
> +		return r;
> +
> +	timeout = dma_resv_wait_timeout(vm->root.bo->tbo.base.resv,
> +					DMA_RESV_USAGE_BOOKKEEP,
> +					true, MAX_SCHEDULE_TIMEOUT);
> +	if (timeout <= 0) {
> +		r = timeout < 0 ? timeout : -ETIMEDOUT;
> +		goto out_unreserve;
> +	}
> +
> +	r = amdgpu_trap_clear_l2_handler(vm, trap_obj);
> +
> +out_unreserve:
> +	amdgpu_bo_unreserve(vm->root.bo);
> +
> +	return r;
> +}
> +
> +int amdgpu_trap_set_trap_debug_flag(struct amdgpu_device *adev,
> +				    struct amdgpu_vm *vm,
> +				    struct amdgpu_trap_obj *trap_obj,
> +				    bool enabled)
> +{
> +	struct iosys_map map;
> +	int r;
> +
> +	if (!amdgpu_trap_is_enabled(adev))
> +		return -EOPNOTSUPP;
> +
> +	if (!vm || !trap_obj || !trap_obj->tma_bo)
> +		return -EINVAL;
> +
> +	r = amdgpu_bo_reserve(vm->root.bo, false);
> +	if (r)
> +		return r;
> +
> +	r = ttm_bo_vmap(&trap_obj->tma_bo->tbo, &map);
> +	if (r)
> +		goto out_unreserve;
> +
> +	iosys_map_wr(&map, AMDGPU_TRAP_DEBUG_FLAG_INDEX * sizeof(u64),
> +		     u64, (u64)enabled);
> +	dma_wmb();
> +
> +	ttm_bo_vunmap(&trap_obj->tma_bo->tbo, &map);
> +
> +out_unreserve:
> +	amdgpu_bo_unreserve(vm->root.bo);
> +
> +	return r;
> +}
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_trap.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_trap.h
> new file mode 100644
> index 000000000000..c78c60e3d18d
> --- /dev/null
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_trap.h
> @@ -0,0 +1,143 @@
> +/*
> + * Copyright 2025 Advanced Micro Devices, Inc.
> + *
> + * Permission is hereby granted, free of charge, to any person obtaining a
> + * copy of this software and associated documentation files (the "Software"),
> + * to deal in the Software without restriction, including without limitation
> + * the rights to use, copy, modify, merge, publish, distribute, sublicense,
> + * and/or sell copies of the Software, and to permit persons to whom the
> + * Software is furnished to do so, subject to the following conditions:
> + *
> + * The above copyright notice and this permission notice shall be included in
> + * all copies or substantial portions of the Software.
> + *
> + * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
> + * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
> + * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.  IN NO EVENT SHALL
> + * THE COPYRIGHT HOLDER(S) OR AUTHOR(S) BE LIABLE FOR ANY CLAIM, DAMAGES OR
> + * OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE,
> + * ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
> + * OTHER DEALINGS IN THE SOFTWARE.
> + */
> +
> +#ifndef AMDGPU_TRAP_H
> +#define AMDGPU_TRAP_H
> +
> +#include <linux/types.h>
> +
> +struct amdgpu_bo;
> +struct amdgpu_bo_va;
> +struct amdgpu_device;
> +struct amdgpu_vm;
> +
> +/**
> + * struct amdgpu_trap_obj - per-GPUVM CWSR trap-handler state
> + * @tma_gpu_va_addr: GPU virtual address of the first-level TMA
> + * @tba_gpu_va_addr: GPU virtual address of the first-level TBA
> + * @tma_bo: buffer object backing the first-level TMA
> + * @tba_va: VM mapping of the first-level TBA
> + * @tma_va: VM mapping of the first-level TMA
> + */
> +struct amdgpu_trap_obj {
> +	u64 tma_gpu_va_addr;
> +	u64 tba_gpu_va_addr;
> +
> +	struct amdgpu_bo *tma_bo;
> +	struct amdgpu_bo_va *tba_va;
> +	struct amdgpu_bo_va *tma_va;
> +};
> +
> +struct amdgpu_trap_info {
> +	/* cwsr isa */
> +	struct amdgpu_bo *isa_bo;
> +	const void *isa_buf;
> +	u32 isa_sz;
> +
> +	/* cwsr size info per XCC */
> +	struct {
> +		u32 xcc_ctl_stack_sz;
> +		u32 xcc_dbg_mem_sz;
> +		u32 xcc_cwsr_sz;
> +	} cwsr;
> +};
> +
> +struct amdgpu_trap_params {
> +	u64 ctx_save_area_address;
> +
> +	/* cwsr size info */
> +	u32 cwsr_sz;
> +};
> +
> +struct amdgpu_trap_usr_addr {
> +	u64 addr;
> +	u32 size;
> +};
> +
> +int amdgpu_trap_init(struct amdgpu_device *adev);
> +void amdgpu_trap_fini(struct amdgpu_device *adev);
> +
> +int amdgpu_trap_alloc(struct amdgpu_device *adev, struct amdgpu_vm *vm,
> +		      struct amdgpu_trap_obj **trap_obj);
> +
> +void amdgpu_trap_free(struct amdgpu_device *adev,
> +		      struct amdgpu_vm *vm,
> +		      struct amdgpu_trap_obj **trap_obj);
> +
> +static inline bool amdgpu_trap_is_enabled(struct amdgpu_device *adev)
> +{
> +	return adev->trap_info;
> +}
> +
> +uint32_t amdgpu_trap_size_needed(struct amdgpu_device *adev, int num_xcc);
> +
> +int amdgpu_trap_validate_params(struct amdgpu_device *adev,
> +				struct amdgpu_trap_params *trap_params,
> +				int num_xcc);
> +
> +static inline bool amdgpu_trap_has_dbg_wa(struct amdgpu_device *adev)
> +{
> +	u32 gc_ver = amdgpu_ip_version(adev, GC_HWIP, 0);
> +
> +	return gc_ver >= IP_VERSION(11, 0, 0) &&
> +	       gc_ver <= IP_VERSION(11, 0, 3);
> +}
> +
> +/**
> + * amdgpu_trap_vm_set_l2_trap - install the second-level trap handler
> + * @adev: AMDGPU device
> + * @vm: GPUVM owning the first-level trap state
> + * @trap_obj: first-level trap object
> + * @tba_va: GPU virtual address of the second-level TBA
> + * @tba_sz: size of the second-level TBA
> + * @tma_va: GPU virtual address of the second-level TMA
> + * @tma_sz: size of the second-level TMA
> + *
> + * The second-level trap handler is configured per GPUVM. The descriptor is
> + * stored in the per-GPUVM first-level TMA.
> + *
> + * Return: 0 on success or a negative error code on failure.
> + */
> +int amdgpu_trap_vm_set_l2_trap(struct amdgpu_device *adev,
> +			       struct amdgpu_vm *vm,
> +			       struct amdgpu_trap_obj *trap_obj,
> +			       u64 tba_va, uint32_t tba_sz,
> +			       u64 tma_va, uint32_t tma_sz);
> +
> +/**
> + * amdgpu_trap_vm_clear_l2_trap - clear the second-level trap handler
> + * @adev: AMDGPU device
> + * @vm: GPUVM owning the first-level trap state
> + * @trap_obj: first-level trap object
> + *
> + * Return: 0 on success or a negative error code on failure.
> + */
> +int amdgpu_trap_vm_clear_l2_trap(struct amdgpu_device *adev,
> +				 struct amdgpu_vm *vm,
> +				 struct amdgpu_trap_obj *trap_obj);
> +
> +int amdgpu_trap_set_trap_debug_flag(struct amdgpu_device *adev,
> +				    struct amdgpu_vm *vm,
> +				    struct amdgpu_trap_obj *trap_obj,
> +				    bool enabled);
> +
> +#endif
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
> index 6eea0ca40556..b4c91e8cd37e 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
> @@ -35,7 +35,7 @@
>  #include "amdgpu_hmm.h"
>  #include "amdgpu_userq_fence.h"
>  #include "amdgpu_trace.h"
> -#include "amdgpu_cwsr.h"
> +#include "amdgpu_trap.h"
>  
>  u32 amdgpu_userq_get_supported_ip_mask(struct amdgpu_device *adev)
>  {
> @@ -267,9 +267,8 @@ int amdgpu_userq_input_va_validate(struct amdgpu_device *adev,
>  	return -EINVAL;
>  }
>  
> -int amdgpu_userq_input_cwsr_params_validate(
> -	struct amdgpu_usermode_queue *queue,
> -	struct amdgpu_cwsr_params *cwsr_params)
> +int amdgpu_userq_input_trap_params_validate(struct amdgpu_usermode_queue *queue,
> +					    struct amdgpu_trap_params *trap_params)
>  {
>  	struct amdgpu_fpriv *fpriv = uq_mgr_to_fpriv(queue->userq_mgr);
>  	struct amdgpu_device *adev = queue->userq_mgr->adev;
> @@ -278,16 +277,16 @@ int amdgpu_userq_input_cwsr_params_validate(
>  	int r;
>  
>  	num_xcc = amdgpu_xcp_get_num_xcc(adev->xcp_mgr, fpriv->xcp_id);
> -	r = amdgpu_cwsr_validate_params(queue->userq_mgr->adev, cwsr_params,
> +	r = amdgpu_trap_validate_params(queue->userq_mgr->adev, trap_params,
>  					num_xcc);
>  	if (r)
>  		return r;
> -	cwsr_size = amdgpu_cwsr_size_needed(queue->userq_mgr->adev, num_xcc);
> +	cwsr_size = amdgpu_trap_size_needed(queue->userq_mgr->adev, num_xcc);
>  	if (!cwsr_size)
>  		return -EOPNOTSUPP;
>  
>  	return amdgpu_userq_input_va_validate(
> -		adev, queue, cwsr_params->ctx_save_area_address, cwsr_size,
> +		adev, queue, trap_params->ctx_save_area_address, cwsr_size,
>  		&queue->userq_vas.va.cwsr);
>  }
>  
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h
> index 727f60c40bbf..5eb0f3ee9b4e 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h
> @@ -41,7 +41,7 @@ enum amdgpu_userq_state {
>  };
>  
>  struct amdgpu_mqd_prop;
> -struct amdgpu_cwsr_params;
> +struct amdgpu_trap_params;
>  
>  struct amdgpu_userq_obj {
>  	void		 *cpu_ptr;
> @@ -202,8 +202,7 @@ int amdgpu_userq_input_va_validate(struct amdgpu_device *adev,
>  
>  void amdgpu_userq_gem_va_unmap_validate(struct amdgpu_device *adev,
>  					struct amdgpu_bo_va_mapping *mapping);
> -int amdgpu_userq_input_cwsr_params_validate(
> -	struct amdgpu_usermode_queue *queue,
> -	struct amdgpu_cwsr_params *cwsr_params);
> +int amdgpu_userq_input_trap_params_validate(struct amdgpu_usermode_queue *queue,
> +					    struct amdgpu_trap_params *trap_params);
>  
>  #endif
> diff --git a/drivers/gpu/drm/amd/amdgpu/mes_userqueue.c b/drivers/gpu/drm/amd/amdgpu/mes_userqueue.c
> index 5311e1ad0201..07b653909943 100644
> --- a/drivers/gpu/drm/amd/amdgpu/mes_userqueue.c
> +++ b/drivers/gpu/drm/amd/amdgpu/mes_userqueue.c
> @@ -27,7 +27,7 @@
>  #include "mes_userqueue.h"
>  #include "amdgpu_userq_fence.h"
>  #include "amdgpu_trace.h"
> -#include "amdgpu_cwsr.h"
> +#include "amdgpu_trap.h"
>  
>  #define AMDGPU_USERQ_PROC_CTX_SZ PAGE_SIZE
>  #define AMDGPU_USERQ_GANG_CTX_SZ PAGE_SIZE
> @@ -148,10 +148,10 @@ static int mes_userq_map(struct amdgpu_usermode_queue *queue)
>  	queue_input.page_table_base_addr = amdgpu_gmc_pd_addr(queue->vm->root.bo);
>  	queue_input.wptr_mc_addr = queue->wptr_obj.gpu_addr;
>  
> -	if (fpriv->cwsr_trap) {
> -		queue_input.tba_addr = fpriv->cwsr_trap->tba_gpu_va_addr;
> -		queue_input.tma_addr = fpriv->cwsr_trap->tma_gpu_va_addr;
> -		queue_input.trap_en = !amdgpu_cwsr_has_dbg_wa(adev);
> +	if (fpriv->trap_obj) {
> +		queue_input.tba_addr = fpriv->trap_obj->tba_gpu_va_addr;
> +		queue_input.tma_addr = fpriv->trap_obj->tma_gpu_va_addr;
> +		queue_input.trap_en = !amdgpu_trap_has_dbg_wa(adev);
>  	}
>  
>  	if (mes->use_rs64mem) {
> @@ -415,7 +415,7 @@ static int mes_userq_mqd_create(struct amdgpu_usermode_queue *queue,
>  
>  	if (queue->queue_type == AMDGPU_HW_IP_COMPUTE) {
>  		struct drm_amdgpu_userq_mqd_compute_gfx11 *compute_mqd;
> -		struct amdgpu_cwsr_params cwsr_params;
> +		struct amdgpu_trap_params trap_params;
>  
>  		if (mqd_user->mqd_size != sizeof(*compute_mqd)) {
>  			DRM_ERROR("Invalid compute IP MQD size\n");
> @@ -453,16 +453,16 @@ static int mes_userq_mqd_create(struct amdgpu_usermode_queue *queue,
>  		userq_props->tmz_queue =
>  			mqd_user->flags & AMDGPU_USERQ_CREATE_FLAGS_QUEUE_SECURE;
>  
> -		if (amdgpu_cwsr_is_enabled(adev)) {
> +		if (amdgpu_trap_is_enabled(adev)) {
>  			struct amdgpu_fpriv *fpriv =
>  				uq_mgr_to_fpriv(queue->userq_mgr);
>  			int num_xcc;
>  
>  			num_xcc = amdgpu_xcp_get_num_xcc(adev->xcp_mgr,
>  							 fpriv->xcp_id);
> -			cwsr_params.ctx_save_area_address =
> +			trap_params.ctx_save_area_address =
>  				compute_mqd->ctx_save_area_va;
> -			cwsr_params.cwsr_sz =
> +			trap_params.cwsr_sz =
>  				compute_mqd->ctx_save_area_size;
>  
>  			r = amdgpu_bo_reserve(queue->vm->root.bo, false);
> @@ -471,8 +471,8 @@ static int mes_userq_mqd_create(struct amdgpu_usermode_queue *queue,
>  				goto free_mqd;
>  			}
>  
> -			r = amdgpu_userq_input_cwsr_params_validate(
> -				queue, &cwsr_params);
> +			r = amdgpu_userq_input_trap_params_validate(
> +				queue, &trap_params);
>  			amdgpu_bo_unreserve(queue->vm->root.bo);
>  			if (r) {
>  				kfree(compute_mqd);
> @@ -484,7 +484,7 @@ static int mes_userq_mqd_create(struct amdgpu_usermode_queue *queue,
>  			userq_props->ctx_save_area_size =
>  				compute_mqd->ctx_save_area_size;
>  			userq_props->ctl_stack_size =
> -				adev->cwsr_info->xcc_ctl_stack_sz * num_xcc;
> +				adev->trap_info->cwsr.xcc_ctl_stack_sz * num_xcc;
>  		}
>  
>  		kfree(compute_mqd);

