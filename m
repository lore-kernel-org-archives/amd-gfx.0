Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B5953CA0EFA
	for <amd-gfx@archiver.kernel.org>; Mon, 25 Aug 2025 14:40:57 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5079510E4DA;
	Mon, 25 Aug 2025 14:40:57 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="QyiygQ1k";
	dkim-atps=neutral
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2074.outbound.protection.outlook.com [40.107.236.74])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0E87D10E4DA
 for <amd-gfx@lists.freedesktop.org>; Mon, 25 Aug 2025 14:40:56 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nnlJrcjfBQ0dMUKtpLgIx/5Uv83vTkNW/w3IWDLn+n0Sy9Ja/uqBQlhmDOexQj+cykFZWkHJ1AvDrpgqyiYe4R+X+PJK2YVcL4kOVsiA1S68wCya1H1SRzcUsPGqlw30D1EITEsKGcJ6NPS1Rn+HsZBtWO3+fzg4kZ6I0WNjY604j3iKrvHjRHJq+nVn+XySAn3coV1vlm6/rA6JYtZuqbVvOjaGOcuFTOC/lPYBuImSmaNkiTw/BIYY8uK57NHW0eYH8BkX4y8f8vixXPpcPDy+l8J0iPWJxRQUjv5ySVPLPRz0SaMn3nUvuWT2BZS6LQatNrpo4upqLAOPj1NUIg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pWOB1/6LtWIwtNEJX+h5UoRFi1Pjew8rsg4dmEemExc=;
 b=JjJ/cccyjKIkmUtKchLzQSggScslpZnG/z7lGebssfJqiSyleVR485diSj1zlfFVgncVYBdkEh97oZd6jwLIMIuhmysC2yBz0MvuSTQlAoyn94Lrtcz5RIEceHxjMUAMfcvZEQ8puOGFblLrnHWiauHEaMA1QP8yvdMn5slHBK9CYizxPXndxx5GiM5JG6ddH2r7VeyiSPZcObs/J3Q6DvLuxMEpQbjMRkKpX0gWb5JMZPqcQMQmC2LE9IO9+MVeqRseRiiHQMHI0Qi4pMya2DbQuIBlwZR5a4fzRIhUo1rXAYoUFcw/r+AdQ9qWZN8T0auxEUDu9YxBkv6kekDMfA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pWOB1/6LtWIwtNEJX+h5UoRFi1Pjew8rsg4dmEemExc=;
 b=QyiygQ1kH74ocWc5DZe0XFBNf9jnB84wXeKm5rQY4v4OXpZzwK+3CjKaTbN6WrNrzRgqFe3PfncGa2xXgmuviErGqx2DKCQNhzxLJnscuGIT0sj0J9/d133i8aLfswsotbpYSQBSHARa+0Hm2Wpc9ccVtSQ2vWeNPe3Z3JdRRQk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by DS0PR12MB8320.namprd12.prod.outlook.com (2603:10b6:8:f8::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.17; Mon, 25 Aug
 2025 14:40:52 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5%5]) with mapi id 15.20.9052.019; Mon, 25 Aug 2025
 14:40:52 +0000
Message-ID: <282f9f23-d972-440c-ae20-fc69cf67821c@amd.com>
Date: Mon, 25 Aug 2025 16:40:48 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 4/7] drm/amdgpu: Add mmio_remap fields to amdgpu_device
To: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>
Cc: amd-gfx@lists.freedesktop.org
References: <20250820113254.3864753-1-srinivasan.shanmugam@amd.com>
 <20250820113254.3864753-5-srinivasan.shanmugam@amd.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20250820113254.3864753-5-srinivasan.shanmugam@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MN2PR11CA0026.namprd11.prod.outlook.com
 (2603:10b6:208:23b::31) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|DS0PR12MB8320:EE_
X-MS-Office365-Filtering-Correlation-Id: 1e12658c-a1d4-464f-bc11-08dde3e563c1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?SCs2NzQxL3BqQnh1SnIyb2RTcjAza2NPcDB2QmdCa01xRU0vcFkrZ3p2OWE5?=
 =?utf-8?B?dFJiUmgwYlAreDlEOUtFOGUzMFJGMHJyN3c1RUg0dXJMM05MY0I5RG1Sald2?=
 =?utf-8?B?Q2hld3F0MGhJdG9tdlJZNGJWeTdlTUVEMk1KVTNyaTNZQ1krSUZmd2xESE5a?=
 =?utf-8?B?NFB4MkVsdzNabUMrUTQ0RlhBUWJ1bWdHeHY3dXBrR3VmUGpJdzdZVlorVXhV?=
 =?utf-8?B?M3pUUCtsRndnUTh4bjhzbkEyT2E2OTRxVVVIZEFhQ3cyVm9ZcldtL21WY2Fh?=
 =?utf-8?B?WmxwT2dnL0dESXE1Y21GYlJ0d2M3bms0UURTanJQMy9nWDV3VmRTWjFuQmd1?=
 =?utf-8?B?RlgzbVlWU3dFZEQrc1ZIcXBsbkY4eXZScWJtbWtjZUxKVGhabHVCOW5ZVzEw?=
 =?utf-8?B?aVJQSElzbXlJWC82aWYvbnJ5UnNBRjZqQ3hGMVJMMjBmSjZYTVVMUGE1SVhN?=
 =?utf-8?B?MVJSMUtBbU9sblM1RGRxK2FWWEltNlZ1SlkwV09EZ3ZJQmpmNmpDUGhMZndl?=
 =?utf-8?B?NzI2QXdIV0t3djVrbGR1bWd2RDlOcnExUFp4STNNT0xjdXpmNGJsajRYa2t3?=
 =?utf-8?B?YytzNGNoRHpKMzV3b2FUakVET3UwVURhZ1p2MGZhNDF6UVFkQlR4YWh6Ny9z?=
 =?utf-8?B?VjUzdVJUWmZKTURQalJmYXFCV2N6dURPVllMVXczQ1pyQmhGNWFLM1RGaXRH?=
 =?utf-8?B?YVVuNkh2d0dvVDRIb2VJSWhSRGJnZC9mYkx0MUN4Y1ZUZmZMTlp5dGdLcEVx?=
 =?utf-8?B?VE5RYUFtdVQ4WCs2TzVKREg1MkdRWVhId0VyY2J1cE5TQlNERW9pQkgyTzlP?=
 =?utf-8?B?L1ErR0xtVTQzZVNjS2xlMzY0d2VPSTNobEgzMFBUc0NaNklCUlFIZDdyc05G?=
 =?utf-8?B?NmFITm4rZWVSZEUxcmRBV3Jzb2NhMXZLWlZnTUVGNTJwSm5Iek1lbEg5QVQv?=
 =?utf-8?B?TXdlMjhtOGllMzVIbHJIT0ppRUZCN3M1amRWUVBheXMzRko4UEhPQU0wd2px?=
 =?utf-8?B?SkNLQWNVVkhLdTNqRFpiSGJIdlkrb2hkZDloNUhsckU3WDd6WEtXZ1U3alhj?=
 =?utf-8?B?WW5sem9LMGUxL0VvWWVseE91azBMYVkrNm5MTkxxdEhmTlpyVlRnTXhDY2tS?=
 =?utf-8?B?dTM4N09JK2RvWkowZ3lZM05MLzBzVlBwM3JiSVJPSm53MjdmMTJWZlZVaFBM?=
 =?utf-8?B?UUN5bGRhS1R0cVdLTFFCTW1XSjVtbDJ2WE1nbmJwK29JV2oyelB5SUsxVHJz?=
 =?utf-8?B?NEdHM0x4bjhWeDljajlpdFZLSE5qQ09VckhNM2xlMmpWVDdtR051ODc0VzRE?=
 =?utf-8?B?Mk1uUTZJUTMwZE0ycFFrKzhCNEZFdE91SjZRU0x1VHJMdjFRQWl5aFZYbGZX?=
 =?utf-8?B?dytKN1JVZmJQVmlaQXltNzNRaTRBZ1VRanpickdqOUMzbGE3dmRNK3BIZUpZ?=
 =?utf-8?B?L3NmbWRWRll1Mkx2MWpVOTZpTlkyRkdZdXY1Z24xWXM1Uk5xTHZsYlZYTzBu?=
 =?utf-8?B?K3JVSE1UaTBqbVNCdVJGUjlLNTBHOHlvNG5yaTM5WE0ybVRneERmWklyWUNj?=
 =?utf-8?B?TzViV0tRYlYwajVMY0JsSDl6anpzYVBReDJMNlQwcjRpck1hYWU1d1JxV1pM?=
 =?utf-8?B?L0MreFdJNENvZ3RSd2ZJK0QyN3RvYmNSTzdCVVpHajZJaGdjaGludEV0U3hy?=
 =?utf-8?B?UzJ2K0VlZkRONi9zVFM2TEgwbnlBVTBTVWc2eW5DbXV2emJrcEdMSXFLS2xB?=
 =?utf-8?B?NnpiZ2dtUVhjVy9hRVU0bllnbkxFeWFyRFJYZkJZb1pycVlqSDQyd1JlcGZG?=
 =?utf-8?B?YklHMzEvdmsrMUFQNjV1VW8vdDYwNXE3dU9EQ1FEc3dHbUtZKzJnTWxSaUJI?=
 =?utf-8?B?V3JvRUtuYnhqc2JaSzY2c2Z5RnZVa2lXaUlTSkxTMGZySWc9PQ==?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UUVuQTBIQjF3SEdaV0FiQTREWXpXNE9WNmNCb0FnT0hQWXBOS2Q5b1Q5VXZW?=
 =?utf-8?B?UjJKcjhvVVdBNmxMZ08vZm1ORUl5S25WUEhOSmhGcWRWMVF4RHRlY1ZMeXQ5?=
 =?utf-8?B?eUFiMmcrZk5kRUpUZnIxeUk2UmtCQXY0ajhWTldTallDV0t5UDRZY1hKQ1Vs?=
 =?utf-8?B?UFY2RHZCbmJHVlNyaUpXV2JZM0N5a1R5NWNFSU5DNWJWNXp2WFVxVWRLbTNs?=
 =?utf-8?B?dm5Mdm56TkV6TEJrR09DTVo1eFpLeGl0ZHJTVHNZenpzalY5ZUtTaXJMM3Bp?=
 =?utf-8?B?SFBpTHR4Z2lYbSt2NzJhUVhIMTg0aExBa0sxK1U4RXhVYjcva0JMYzQwS25T?=
 =?utf-8?B?VmtmY2F5Ty95cmJCREN6dkhxc0xrZVlRSTZSYzFld1FlRUNEN0pFbEtHMUVN?=
 =?utf-8?B?MWFCNUlGcEsva015a1c1djJiNksrU1ZPMGFGSjJRbmsrL0ZBL3c4Y0d5ZmpZ?=
 =?utf-8?B?Q1hiVTJrV2dDS0s5L1hTWHJuVUYxc01jVHAzaEF2bk0ybXlqZHBFZnhUMG5J?=
 =?utf-8?B?S3ZrUmR2QTNwZGpVYkVDQ25pc1RWdk5HOXlSMUlZbWJVbmtxQVZQUWlYQ1Z6?=
 =?utf-8?B?cmZ6S2lhb3VCMWZ4Rm9vejZYbGxIL2ZuLzlLakpBQzA4NENucjliUGF0cG1V?=
 =?utf-8?B?WVJVQm93dWdKcDlheFFMMGMzOE9zMlQwKzFURVM4K0lza1E3anh2Um1Db2ly?=
 =?utf-8?B?RDlYZlVWM3JrZ2RQS2w1TGRFRlJ4RHZHdytCOG5EejBtWWZBV0F6L3ZBa0E1?=
 =?utf-8?B?UElZYUVQdnRDNXRpZ3BUMjRwUGk0TDE1WWlyQVNUbDRLbHFJdW1TdkpYS2Mv?=
 =?utf-8?B?ZkpwYzZmMFpJV2Y0Z085S0lDUDl4MlEvZGxIckxHRVo2VlV0bUhyYUJLZkdJ?=
 =?utf-8?B?MUVCejRnd0gxbjcwWjM1VitBRGJ5U0M0dHg1Z1BDWS8vRkRZaHFCWTdCTGdN?=
 =?utf-8?B?TzQ4aG9XS3pHY3EzaElOd2NOTmFmcXNRV0ljSzZLSDdJemx0dWVnamQ2RUtK?=
 =?utf-8?B?cVdySVNDdGtac05FNktraEFhUkVENTZtakpTVE9zeko2SFdkZm9LaUs5ZlQw?=
 =?utf-8?B?eDVIYlFjcXFZWGJuRXhBZVdvbGY0WUZYNVk3WW5BRmp4M2QzQVk3QU9yQXYz?=
 =?utf-8?B?d2VvN2p3eHorbXo0VXhqWUE4emJpdVdZd2NCUlJQWTdpWDhLeGRveGpZVjBE?=
 =?utf-8?B?RTBBakJ6TGx3R2NzWFVXV2N1MWxJbXlqZXVvN2pBWVZkdDFhYzZJdytBY052?=
 =?utf-8?B?SVRvZDQ1UWJaczIwS08zNnUzVFNJYTIvZlIvejhXNWZ5a3J2TkJabDNRekhZ?=
 =?utf-8?B?SDFzdGxJc1VPdEI3ejQ0cnRUWmtKb1h5TzBQRDVCMk9EVEd5NjkyWXhoSGdH?=
 =?utf-8?B?OUVBZ2tMRER4bnhzaFE3cjF1VGNJMWoxaUd4UXZkTnJuamUraE1Vai9kNEhX?=
 =?utf-8?B?S05NK1B6Ky94SnBTZzgrMmc1ampuSkRicC9pYWRhVU9FSityclQ2aEpMbnNJ?=
 =?utf-8?B?T2gybDJ3czVTa0hjQkIzRFQzSCt5Qk40VUR6RkJhZjlmOVB6R09KazQ1NERk?=
 =?utf-8?B?N0R4Wm5seUYwdkdESDZTcFp5dCtKTHRTNDNKMmRtalQrekV1aTFnb3ZWZ3h1?=
 =?utf-8?B?dHdyNVV1YW1JZ2FIOStwS1JGZXFCWHU1b1NPVVVuZFlYZVo0bGJyUldmTi8r?=
 =?utf-8?B?MVhXL2oySlVxSXZ6a1NvMXZqVm5JQmRzd09HcHlsWWV6dTQ0Ym1mNGxqZG1t?=
 =?utf-8?B?b2FjSENHb3NFOFNmOEJKYzhPSDZqd0JDOUFTUFg4QmtYV2Y2cmQ2RnFLd2Nq?=
 =?utf-8?B?WkpGMlFod0UxRjBCZzl2bjUzaWFXaitINEJkSDJSWUtiZHdYWHdXMnAzT3lM?=
 =?utf-8?B?Vm5BMmZVb2Y5c3UzdjlDUVgveFYxdTQ3MWhRT1Zhb1Jkbk9pbS94SVk4WFNM?=
 =?utf-8?B?aFhnaHlzVDNtdjZ1UW5GTDJEclBxT2hZRFpQVk9haDBtVDFneW4ra05heWxM?=
 =?utf-8?B?dHFLRkpWSmx6Q3o5WENMeGExaXppVmFURnNxZmQweEY2UVhac21Ha0xjTG1s?=
 =?utf-8?B?Mk43WnlnVEJiVFh3WWVDbVNNNnJxd25USGx4Y0lOc0J1QTcrRFlvSnlFNEp3?=
 =?utf-8?Q?iiR2knu90Xw8lD9CnQCY4fev+?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1e12658c-a1d4-464f-bc11-08dde3e563c1
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Aug 2025 14:40:52.0082 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KTI9PQQGCJP8xcXBNAhaorCPYUZcyybe0kjK9V3Eo3DyKUlWw4vLRX9rMVNB4Wsc
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8320
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

On 20.08.25 13:32, Srinivasan Shanmugam wrote:
> Add bookkeeping for the remap page to struct amdgpu_device:
> 
> * mmio_remap_bo (singleton BO)
> * mmio_remap_base, mmio_remap_barsz (register BAR base/size)
> * mmio_remap_offset (BAR-relative offset of the remap page)
> * mmio_remap_size (PAGE_SIZE)
> 
> Cc: Christian König <christian.koenig@amd.com>
> Cc: Alex Deucher <alexander.deucher@amd.com>
> Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu.h | 7 +++++++
>  1 file changed, 7 insertions(+)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> index ddd472e56f69..6c477596617b 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> @@ -1038,6 +1038,13 @@ struct amdgpu_device {
>  	amdgpu_block_wreg_t		audio_endpt_wreg;
>  	struct amdgpu_doorbell		doorbell;
>  
> +	/* ===== MMIO remap (HDP flush) bookkeeping ===== */

Please don't use === for comments. Rather make that proper kerneldoc.

> +	struct amdgpu_bo		*mmio_remap_bo;   /* singleton BO */
> +	resource_size_t 		 mmio_remap_base;  /* REG BAR bus base */
> +	resource_size_t 		 mmio_remap_barsz; /* REG BAR size */
> +	resource_size_t 		 mmio_remap_offset;/* BAR-relative offset of remap page */
> +	resource_size_t 		 mmio_remap_size;  /* always PAGE_SIZE */

And no comment after members please, see kerneldoc for proper style.

Thanks,
Christian.

> +
>  	/* clock/pll info */
>  	struct amdgpu_clock            clock;
>  

