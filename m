Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2547010F9943
	for <amd-gfx@archiver.kernel.org>; Wed,  8 Apr 2026 14:18:42 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A367110E684;
	Wed,  8 Apr 2026 14:18:41 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Jh/kg1Dp";
	dkim-atps=neutral
Received: from CO1PR03CU002.outbound.protection.outlook.com
 (mail-westus2azon11010027.outbound.protection.outlook.com [52.101.46.27])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4002C10E684
 for <amd-gfx@lists.freedesktop.org>; Wed,  8 Apr 2026 14:18:40 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oK0Zt8oUxpNUaivbaffQhFxJkCZxS4L4WxULSNW0Uro+c/gP2U/kEIZ28wHr8t7G4bCfClH7Oo898pN4sb1hvNY6ajDlyQI0Sq1Elcwgjm0LCyeHlX7EkdXXwquL7NbQ5RUt9pwHysXgdnqq9XbEbPxux1SgFkJbT60kcCQBmMGYimOZO94nzkpygiQpF0AzmMEXqPov4d880PyU8YE0qmm+trTu4A24odZ2t913GqvoSD/fQG93JcmBal3PJjH/Buas4c0bSKdWoPJmRS4KmoAqzeukIzQ4/mI3FSTCmjghD4IVI31UFwVDz7qv8H88zAe105kpX8GZf7boTldclg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VdvLKVlkvqr6JF3wzw7Fpo2ZzvrzmjdeaBt3BK1zwQk=;
 b=ZLKv8X+3dqo3XkGWm5k/NYLIMjQg5TnShIRfnE1SslYWcobv2EtweK3MDKbqzx8A883nk4MtqCVMlik/omeI0QJkKCvPSucrPLOa7CeAMee3nXDz14xuP/PE89U2bFsPjix9JXvLIQ1C5DA4EA73WB6iTIoM8GwJGLz8Ol0TcLUf32R0XGkJZmw7MKQTLm8MNZHF38pygyfuzmvQccbbey5GurGWtMcrFnVOJuqpUiWLTbTOOX9HFTEdqwqFp7YDp0XsSk2T1Vq4pGNSoer2atM7oY7EiIYJ0sn5oCMHeYOT5A43c85bVAkiUdgfLf04i+Hy0xhcUITAK/HuHS3vnQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VdvLKVlkvqr6JF3wzw7Fpo2ZzvrzmjdeaBt3BK1zwQk=;
 b=Jh/kg1Dpzob2HYsQx0ap+T/tIumk3FxTRtqaaU2yMBLnHTs+rL1MIlcd8rWHBavlqOgnntaFsH3ld9iBiCB6KvQ2k5NJnSaXqJFjnr8zjb80oD7q1EUv+N20bTS/egFtZhfrGDQh4ijDMZseeKOCi+RnKx0++qxwwAkE297NXeU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by SA0PR12MB4352.namprd12.prod.outlook.com (2603:10b6:806:9c::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.17; Wed, 8 Apr
 2026 14:18:37 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c%5]) with mapi id 15.20.9769.016; Wed, 8 Apr 2026
 14:18:37 +0000
Message-ID: <0910cbc4-e186-4983-a6f8-a7b76a08be5e@amd.com>
Date: Wed, 8 Apr 2026 16:18:32 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amdgpu: remove old amdgpu_vm_debug declaration
To: Erik Kurzinger <ekurzing@amd.com>, amd-gfx@lists.freedesktop.org
Cc: alexander.deucher@amd.com
References: <20260408141720.1845-1-ekurzing@amd.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20260408141720.1845-1-ekurzing@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR4P281CA0237.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:e9::12) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|SA0PR12MB4352:EE_
X-MS-Office365-Filtering-Correlation-Id: 375ff6dc-cdee-4a0d-0de8-08de9579b9db
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|56012099003|22082099003|18002099003; 
X-Microsoft-Antispam-Message-Info: 4MXuzUycFHzfYpZ2Wj3csQzh/hcbmece+0K4JGsD2nyUTGxpNRX5Two3pMxIsEqsu9aCromM0HQK3FbAELo2pC/8bCKiOJJKECLVh6PkkI1eEEGNwFMq+PsQkg/F+ZHXBiabC3XUec7e3Y2C3bCjlvFFi2FQX/XGi6O709XNr2p/oH9Cmd/WhP7RxDs/bDY9PCYhg7/wj8JnSsFZbWOmuGI7Dyw4E5KMOo2o0pdDwM3uv2Y0iOJnh6+Q+RBCSRvO40JablTUJX827SEArryZ3JgbiMTLHwTxsRGD1QwYSUomoF24lBZUodOcqgdIM+iRAQ2LA7O9cLityhjzMR4E5TGSGSQ9GE4qShTtT4Knz4xsyAy0fddKc9SHg8M1Md0mMXOkbbJpspFYSiA0J6obpFwSskUPm2YldRI/p5H3eKzvN4hUMGcsvTk3eT2UnxDGxVNfpJ4vMn17T7Fj2lkLVBcMdWTOs9hZiqF+PL7UwE3GWQQA0yWEc2plt+EdhJqw3os5Y6/qjNc9S0ohYkCFSs2Gev0neP9LHuoZKnuw4URPh7bRSexJhnxiJM/XIoFtGBIclQixlb7izuLpCGQgEiOE/Xog33SfhJcdltcm2btdBNIEbjRshoR6MNo+wLyJmNyC5kTdF9LYKgxKxvwl+xdjeoKGKHvWu9cfy4aifScIR6JA7P/lWVQWQwcHBDo4PC5n0g4sLJvcCOrRMtrBMY3haOWPYYwH87NMl1AiFms=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(56012099003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UURKS2duL3FnU0Q4SjFPUmhOenpxemZHMHM0QkhGYjNLY2NvVStaanA0cExS?=
 =?utf-8?B?eG1QWUpWRllWdERqL1Nod1FNZ3lOY3ZpYWEwTWllSnphK09nOXQwVlltRU9i?=
 =?utf-8?B?YW1mUEJjdmY4c0JVbU5WYkpvb05Fb25Sa1c0SUZCSFhNQlNCMXNUVHcwdXlx?=
 =?utf-8?B?QU1mMHJKMWRYOUs0N2ZSK0R2ZU1PV0kxT2xVeFptVHp0UmtWUkluWE12dHpq?=
 =?utf-8?B?N0tWQVQwVFJYMFVFUXdheHBYL2pXeFkwUjJCQ2lubUErdzMzWkRheUhjem90?=
 =?utf-8?B?SFVycXVlSHo5dVoyV0NGR1ZYWlhIWTlNWWNyOU90MTRhU2dad3NQZkF5QlZT?=
 =?utf-8?B?ZGpZUlRWSVQyRUFHR25QeW9HVnYvR3M4YkREdDFZbHRpa1Btc1BBanZPenQ2?=
 =?utf-8?B?VjRwSlhGdlFySVJ3NjlTYi9MYnBIWmZReUNYdm9rSDJydHF6aU8ycGN3clhJ?=
 =?utf-8?B?d08zVlNIazRDenNqY0J6M3NUNlFnQjg0TXNhODhKdlhDMXRDNTlQcTk2VGMv?=
 =?utf-8?B?VGw1UDBLc0NxbS9Wd0JuZzVvMVJHeGVRTzc4d000MDNsY0JqZjZPejVrWGFi?=
 =?utf-8?B?NEJzTXFEMzFPRUJXa2U5bTZaVC80Y2owb205R0c3NFVmK1NIOXNHaEdNTGxR?=
 =?utf-8?B?NHJCSUtaL2F0anF2aW1DSHgyNCsyOUYyVU5oanpDM1loSnJoOUZzSi9MaW5M?=
 =?utf-8?B?QytkNHNGMm1mU3RGL0YxMENEODY3OWRkOGVtVkN5YVR4dEV3TTl5OW5acHJP?=
 =?utf-8?B?dGdmQzlyanRSS05QVlg3N3VwVk9lWWNXOVpibksxZ0EzNTBnL2NBcDk0SWdi?=
 =?utf-8?B?VE5QM2g1bzV3d3RMSURYa1k2K3Vmbyt2dDJDRDhTbFJ6WDR3SkoxV00zYmNr?=
 =?utf-8?B?QlRualRQVDVTNEl2VHZlTDFBRGhQeERGUUhHV0ZBMUk2RVM3OTM1UnR4ZHlV?=
 =?utf-8?B?VklzWjRUazhwKzdSY0JLcjNPUDVoSStMbkxHdnFtR3NTNTd4Y2tOODB5Rm80?=
 =?utf-8?B?TEVRb28yZDNaNGVnQVgrVExGMzFvYms1UGN2bGdRUFAwYnp0ZjNPT3RsOUJB?=
 =?utf-8?B?WXlMMXFsSW0xcHlwamJlL0U5ZmdtaXNsYnBoQ2FlZkN3NHlGZ2xFL1pvV2dP?=
 =?utf-8?B?b0ZJTE1UUGFjK24rZjYySk43N1BGV091RUVFdm5wYUFwN2ZXNXY0M291aWVV?=
 =?utf-8?B?TlRCTXF4OGtqZ0hLV1hSYUkzK2lxemZnbFBHdHBHQktUZ3lPWXl4Si9uVlNt?=
 =?utf-8?B?dHo4MmYzODhkQURaaEFreGppUVhlQ3ZoMkRKYlVsTHU1TmhTdW1hNForVEtZ?=
 =?utf-8?B?NXAzdm4rMkYyVUttNHBPNU1xalRoT3hMYnNCbjh6b0lkdUgwUFFoK2UzeGsy?=
 =?utf-8?B?M0l2NXhMZ2FCaGFPTGw0dC9tZDVCbmRwa3AyOEx6MzhDTUpybkx3NnJaRXpD?=
 =?utf-8?B?T2VlTytNOVFEblVGOTAvQkZFY3drUHNKZ3cvai9XTDFmUGNZdjNGZWJGT1Ra?=
 =?utf-8?B?a3d6WVQyRnAwbUFLVkk3Vm41MForZk14NFNObDJGcEdac0t2a2JHdElMY24z?=
 =?utf-8?B?L2JEVExRZVFEYVFIVDRVZWNyVnM3QTdPVkEwSjJQR3Y4YkFuTmxDeTFPMTU3?=
 =?utf-8?B?SjVJSE5YMEFFUEFmNmNaNUxSTytzSlJnL1IzYnZPdVh3UXFtcFBrZnU1MWwv?=
 =?utf-8?B?YW1JY1RlcFY2Q3lJblRvbXBhdWYwYTJvVTFyT0k5RzFBMW5DMk5BZlRxYWo1?=
 =?utf-8?B?QjBYQU5CY3VNU0lWVnVaRHhVdGFrQWdhUXpPWGlXNWUxMzNLdUtCSUN0TEdx?=
 =?utf-8?B?MURrNzRUVThnb3lrSFJxVi9oTkUzMkdQdWZ1TDNpbExPRVBNbnZZZ0EzeCtK?=
 =?utf-8?B?RURONjhhUHA5ZCsraTUrRnZJYjQxaFo4aFA2UTFIK3RCdlZrRURKbFlIeG5J?=
 =?utf-8?B?RE1MUHNxWi9SZTc1Vld4WDN5bHdEVHcxaDVFa3lPN05VamZiSHkrNWhNUGp0?=
 =?utf-8?B?U1NadlZ6QXJHWHpiSklBM3pVSVo4RHJBemNpa0VFUGN1dVpLbW5yY3ZreXND?=
 =?utf-8?B?TTIzVldINFpwVXJIblpueDJWMCtlN1dCS0dIZkhCKzZjaGlhWkpaZDNRS0Z1?=
 =?utf-8?B?aGlFYUtrMDREZUV0YmhaUVg5bDIycTVST1FvSFhJbEVtZk54SC85WkgrckJG?=
 =?utf-8?B?L0dhZ3RPMnIrMEJ2dVprMDBxNW9XOWUrNjQ3a0UyNEpwNjRGRlVaTzM5bThS?=
 =?utf-8?B?UGY5Q01HdjhtVzZadjZ4TmNVSll0YWIzMjRhb1RJaFJobkNBNVVFU0xpYjEv?=
 =?utf-8?Q?K5xN4M5BYNpHt0s2E/?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 375ff6dc-cdee-4a0d-0de8-08de9579b9db
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Apr 2026 14:18:37.6030 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OxXqo5clEns7JKU6Oig4nvcWyrs08Lm4v6LEwAHx70uRQ5PMz/MUhgK3K4ctJmD8
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4352
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

On 4/8/26 16:17, Erik Kurzinger wrote:
> Commit 887db1e49a73 ("drm/amdgpu: Merge debug module parameters") merged
> the old vm_debug option into debug_mask but left a stray declaration.
> This change removes it.
> 
> Signed-off-by: Erik Kurzinger <ekurzing@amd.com>

Reviewed-by: Christian König <christian.koenig@amd.com>

> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu.h | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> index 49e7881750fa..727e0a95bc86 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> @@ -181,7 +181,6 @@ extern int amdgpu_vm_size;
>  extern int amdgpu_vm_block_size;
>  extern int amdgpu_vm_fragment_size;
>  extern int amdgpu_vm_fault_stop;
> -extern int amdgpu_vm_debug;
>  extern int amdgpu_vm_update_mode;
>  extern int amdgpu_exp_hw_support;
>  extern int amdgpu_dc;

