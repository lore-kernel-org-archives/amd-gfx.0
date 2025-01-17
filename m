Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 15842C02183
	for <amd-gfx@archiver.kernel.org>; Fri, 17 Jan 2025 08:54:42 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9BB5E10E38D;
	Fri, 17 Jan 2025 08:54:42 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="O91gPYB6";
	dkim-atps=neutral
Received: from NAM04-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam04on20631.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2409::631])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 83A1510E38D
 for <amd-gfx@lists.freedesktop.org>; Fri, 17 Jan 2025 08:54:40 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=J3jR27w7U28Pkei7TxbQJVDpToRYcqmn8R9XmKSwVZcheWrsF4SaRu8gb4rGMaOBVT382JcAHOCXzk/oxaEbEmmb40yv8ezmmvYB7Kk6R1xr0OfN/VvwND6k9cY384wN6FlVXlXDrzM+RZaMR9dx3AtQvCDW5IXQ93/3Ik5xSjdk3OLVGt7fhBR2UbIPyTY3LwoA9BOgdGCyZy80UyQJOfPqCGBm516SDywFLaRVKLmZgT3j/qoHhhkfbjihZiJBPwahlcPceZqWLGJhV4kdxht6swyKLYKGK+BjZ3Shrdxbx7Bbigu257y3+iHtBAwwknRm/Kn0dmyZEOkp7yRWDw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/VAq2nKMQEuUhfNGM1uKA4M1/+VZbOxgHLTbicCSvJQ=;
 b=gdx1suxEe3TpVuCXEnbgCXptI8DOE/yyZeEG25LSjY4k3Q/g5ujDUIBUGZ6BY+7Pe70IEAh0RFOjil5LbLhzkXQJf8MC4AjH9ZKQl8dvuiCN/AB1dM+rQMa018NsPgnWEk3rlMwFwQdv8DfE8wqxUiLlvCTaM3k/eRlczQ7vw4o4pTyWlEJjuSD4EJ34CN8KWsMbdyxVeUWqd5rgLY4+EV5y+7buf1tV6uI3LYuI7V8/ONOt2ZKWR3CaC73M6WRqZ8mDVaZGooP9OVqAPKh743wIXXDJc7l5cozP2TYL+hMv8bP+51iAAahsXluV/6J/dM05w+/67EY/TBbTfZV/hw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/VAq2nKMQEuUhfNGM1uKA4M1/+VZbOxgHLTbicCSvJQ=;
 b=O91gPYB6IZEKk2H8X3TmJelBngzg+LSxeQVC4t5fNednHCHPOO+RYD3pGtAVR16D3aP/Vs2VeGZAmdx4dFEkEhmsrpagoW9clsVMGwusc9/wu3YfnssnQkAZwCFX7g5d/pitXyU1O3zy5sawSVk7NOSQh9Qv9S1EnfWQGVpdcVo=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS0PR12MB7804.namprd12.prod.outlook.com (2603:10b6:8:142::5) by
 PH7PR12MB7305.namprd12.prod.outlook.com (2603:10b6:510:209::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8356.13; Fri, 17 Jan
 2025 08:54:29 +0000
Received: from DS0PR12MB7804.namprd12.prod.outlook.com
 ([fe80::8327:d71a:ce21:a290]) by DS0PR12MB7804.namprd12.prod.outlook.com
 ([fe80::8327:d71a:ce21:a290%5]) with mapi id 15.20.8356.014; Fri, 17 Jan 2025
 08:54:29 +0000
Message-ID: <76494817-39dd-4900-9906-e4d13639be6b@amd.com>
Date: Fri, 17 Jan 2025 14:24:21 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC v2 10/15] drm/admgpu: make device state machine work in
 stack like way
To: Jiang Liu <gerry@linux.alibaba.com>, alexander.deucher@amd.com,
 christian.koenig@amd.com, Xinhui.Pan@amd.com, airlied@gmail.com,
 simona@ffwll.ch, sunil.khatri@amd.com, Hawking.Zhang@amd.com,
 mario.limonciello@amd.com, xiaogang.chen@amd.com, Kent.Russell@amd.com,
 shuox.liu@linux.alibaba.com, amd-gfx@lists.freedesktop.org
References: <cover.1736732062.git.gerry@linux.alibaba.com>
 <f9816814dd71316bf371c01c5f4d71ca85954ade.1736732062.git.gerry@linux.alibaba.com>
Content-Language: en-US
From: "Lazar, Lijo" <lijo.lazar@amd.com>
In-Reply-To: <f9816814dd71316bf371c01c5f4d71ca85954ade.1736732062.git.gerry@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN2PR01CA0185.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:e8::12) To DS0PR12MB7804.namprd12.prod.outlook.com
 (2603:10b6:8:142::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB7804:EE_|PH7PR12MB7305:EE_
X-MS-Office365-Filtering-Correlation-Id: 150cc568-98f8-413d-dca7-08dd36d48d99
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|921020;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?T3MybW9qSGlJdVQxMEZNcGZpL2xlNTc2TzI4M0NTN3ZDMzhqSlNMQTV3TlNH?=
 =?utf-8?B?VDJOaDV6cTFuYi8xRnFNc2lCY3NnZjJyM2c3b2ZFbm9jd1UxTytobDF6NUE2?=
 =?utf-8?B?UDVqVldRNTZXeVYzSFdVTTE2bVZUV1VxaE1FNlI4b09kczI2SkQ1SHk2eE9u?=
 =?utf-8?B?MjVpaTd1c3ExVnFreFNKbytYVmxQem5TRFNERVR1emFRblgybFZUaDJSS3FW?=
 =?utf-8?B?QlpVckJVV3Q4OVR2WHcvQzk5V3dpckVMbklKMUJrMGh1UG1RREpVV1NRYzhj?=
 =?utf-8?B?L1IvdWh5WXh0MTBqTUw3TVYxeHRCVkZia0xPN2JxZVd5RGJyTUovSTRPOGpO?=
 =?utf-8?B?MXM3L1pnNlVHd3JUNm9uYWhtQmZCbUdqR3JJZDFzNGczZ0J2NnVZZEtsUFlz?=
 =?utf-8?B?Q3FPVjN3dGR4MnhIMXNzV3F6L3BzaGVMZk9JNWpSUGp3V0hDcEllY1dmVW9S?=
 =?utf-8?B?YXFYa1haQVlucXVlK0RTOUFheS9la3FBVVpDU0pndWxIZzM2Um5ITVFPQWN3?=
 =?utf-8?B?eTlOMDRUd1RUUXJNWTBwdU1ab28vUXVuUG0yZ2VCeEh2M0hiSnlzdHozMkxp?=
 =?utf-8?B?NzA5eEp3Wm9mQ1pZa3JiRjRxWS96YlRjSkhBUXhyRkU4RlJtb3FxV0tNVksw?=
 =?utf-8?B?UmtPL0gxOVlWNXg1QkdYZGo5Rk5FczhtTng4b25rdnpoSTRwV3Q0NFU5eHpm?=
 =?utf-8?B?SXlaakJIMnA1ZmpBRnV6azlmeE93ZzV5UVNYL3kxNVphWnZmelBYVVlMaTF2?=
 =?utf-8?B?WHZhRUJhQ0xqZzNqOFBwS3g2L2Z3Q2RHU0pQZmRzM0JxZkdtS3VBRWJPNEM1?=
 =?utf-8?B?MmljeDg2M0xkU3JybVkvN0FLdmZOcmFwem4xWlZUUVdBYmdraXpuaHBoSE9n?=
 =?utf-8?B?aUFRcmExK2UrUUFNVk53UW9lSmQwME5oYlBVaGFqT1JiRUtMMVpVSkxLTW1V?=
 =?utf-8?B?T28xVGQ5VmhZd3dLck50VHJocVJiMkt4WEpBUkxrTmVyWDNCcWZKV0FkMjdk?=
 =?utf-8?B?d2orRHd3TDNNSnRnamsvcHlXOVRNT0lLSTMrUWVLZWlTb3Z0a3pIb0cyYjZO?=
 =?utf-8?B?VnpLTXdkY3FwWlRXU1FhVW13aThYc3Q2M0RkdmRyRkVVRmNTaEc0Q1NaZTZk?=
 =?utf-8?B?SzZjWTRRNEcrcjVLMjJpaTcwVTN2YjRrS2hoTGtMUERpVkZoeUo5bjllYWp0?=
 =?utf-8?B?STJ0TEZVdXlCVGQrem14N0VTV2tEbzBScmh0RU03MDJyWjVGbkprQWd1emt2?=
 =?utf-8?B?bzFCSFlyazhZaUlEVndtRC9oSFNhb2tyMW5BT0E0TVdOdGQ1bDkrbnpDRmNG?=
 =?utf-8?B?cFk4UW16N0E5TW1EVks4TEZ6RG9Xdks5bllYOUcyU1RhWVAzTWpWd2lwVVRi?=
 =?utf-8?B?Q0hOMkRKVUx6c2E4QmU1eHhseVJsc0I1M3NubUgyMUxXWmh5ckJTSldtdFc4?=
 =?utf-8?B?MG4rNEdtaWI3RVY3SUJLek1ZQ2FXZ3Rob1NWSEVRVmZGS0tpaThiZk5HMm9j?=
 =?utf-8?B?T3hCQ0xoNVVZL0NIZlJHcnB6ZUU5R1NCT1VldjFRYUVWcGdqcEhjNm9CS05i?=
 =?utf-8?B?VUFsRDVOU1pRQk11cnpJNFNUelFBWnV5bStld2R6STFSbmNCOGFacXZmUjBY?=
 =?utf-8?B?OWR6UzhHd01Ba2Y1bG80Z3RMd2lheXRSOThuclRmd1lrWGY0NHBYbGJkZjNW?=
 =?utf-8?B?WUkvV01MaFJmeVRmd3RrTzFSdGVQMjJkaEdJbmpLUjh4a1Z5UG9wcmsvNk51?=
 =?utf-8?B?VGMyVWhxbmhaQ2ZVQWNFTUxlVmJCWWtsNi96NXhzNWFUZFd4TnhDb21ER0lp?=
 =?utf-8?B?eHpyRFlEUW9zYy9VTEd2eTZDY2ljWFZzTFdqWmxmWkZKK2djKy95SzBJRUVL?=
 =?utf-8?B?bm9LUzAvSU9DMzBrNU96U1N6alJSY1FQQUF6NlZOMHI0R3loR0RZOUJ4RDYy?=
 =?utf-8?Q?1wS2EYuNDZM=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR12MB7804.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(921020); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?YzFoVEFCMDlpTjZBVCt0SnF6TkVLRFRaamZPTjZzdEMzMEVEek9MUG1XVWZt?=
 =?utf-8?B?SDc0WEVYeDB1VmYvUEhrZDVGcFNtOVZ5U0dPbGdnMzFJTDlYMkpFMlVGQXE5?=
 =?utf-8?B?Rmx4TU1HYjVKS2VLQmRFNjVlbDJsbmx5OGJTQUpFN2J0UHBVK2xPM0hxV1Ji?=
 =?utf-8?B?bmhuL0tXNzVCQ1RjTlhJK0IrWDVRak9rT0x5Tml2bHJ4QVFVemdQb3lFQS9E?=
 =?utf-8?B?T3dDMkZYMExacTJWN2JvQk5EY1BYOVdia1M3TjNUbEVOSGpMcHMvNC9yRm0w?=
 =?utf-8?B?MDdPUDVmS2FQRVBXbElIcFRzbUdqODhSdU1EZWxMekZ3QVN3OXlBb05DVTU2?=
 =?utf-8?B?S1A3b2lXZWV4SERqbzhiMjd1N1pBckpSTXlYc2FvRmg2TXVSamRLS3VSOEJl?=
 =?utf-8?B?UkxiWDVCNHBFNFBQamwyTkNyMEFEMmU0WGZ2d3JGSHZWWmRHVndxM3pGYUdB?=
 =?utf-8?B?R2xJRHhJd253Q3VaY3o2M3Rhb1Z6TXJyRklERTFlY3duWlV0dm1nMXBydVZ6?=
 =?utf-8?B?dEo3TGcya01uREhHNmhvZklaSUd0djMvL24ybWVIeEtCV2RNaDBpUFRpUXMw?=
 =?utf-8?B?MVFkVDFZbklXeEhXaHk1eU15eTB1enhtUUVPSkxLMWxnTC92TWJIZ0lMbDNU?=
 =?utf-8?B?dTA0SitadXVOSFZEZlZKbkVIRG1nL1RZNFo4OXFWb09mUmlrVytlUndTTnF2?=
 =?utf-8?B?WFIzV0xWSUdmbGZiNzVHT1NOdG1Xc1RiU3YxdDNJUG9FMFNTQm9NMnQwNG9m?=
 =?utf-8?B?YjhkWXM4ai85N1NzRW9zaENPZnVMTTNuTVM3S2hTT2k1cEkvREYrNXpOalpD?=
 =?utf-8?B?TUM2eWUraUpSak9hZjNBSmthUFRja3cwUFRzMkxsdmtGN25oeFVyOTA2a0ZY?=
 =?utf-8?B?aGZCdjNpS2tiQkY2T1FmYTl1WWlTeGk2Um0yY3RMalJXS0VONTNHb3BScXNa?=
 =?utf-8?B?ckNZbml5anVzdkRIaTdYRDQzWUVEVGY0WlFYayt5V2tLL2pOVFRrekFGUmxU?=
 =?utf-8?B?VWFDOERSZnVKT3VaWHhsWUhRcGIzUE8vOGppTkFRSDlSbTg0VVdyVmxMei9D?=
 =?utf-8?B?ejZPaUJhSytSUUtRTHkvL2xyWmQwVEV0SnV3MzFWZ2RmWEQ0Sk5uS2pJTHRS?=
 =?utf-8?B?MGg0eUVRNjh6WEFEQk16dXZyTStCQWZ0UXFNaWRXdEkwYXZ4bG5nS2pWYmJS?=
 =?utf-8?B?UEZ6NjhJWkJTZTdKSmdTa0xobEk4MUlEREcwMEtDVS9KeVNudUh0MUwzdDA1?=
 =?utf-8?B?UGg5OHZ3ZFpkY2thYkFLTHlMZVRRVzJNcWFacGhCVmxZbWRGS3FrcGdCTFFB?=
 =?utf-8?B?MFQxUER4bEZhdCt5M2plK1NiNGVUMHdEZi9wb3hBZWU2VzJmMGNNTXBSSDY4?=
 =?utf-8?B?SEFmdStwVlZ6N1cvZzVmWnd3RWROMVYrMzA1aWNvUDFJY2N3aVpEQWZoRUpC?=
 =?utf-8?B?Z0FoZ2k1QklIaEhOc09qd2tLMkllZUpUSXdKVjJuZmJURmFpMUJjZXMxT0VJ?=
 =?utf-8?B?cEVYd25qN3lOd3NTZ2VZTFhYUTIyTEFjVnlCaGFtVVlQVEVjRmRQN0FxQ1Ez?=
 =?utf-8?B?UEVUODF6a3JvTVVycDZEd1YybW5WQ1F5Qnh6UExjZ2l5SXQ1UkcyaDJtTjFW?=
 =?utf-8?B?MHY3d2xGVEhwZUR6TjVkVHJlWTh1c1djTk4wQ2dRUEtUYW9xNXJVRW9Ndkl3?=
 =?utf-8?B?eEZKdFZvaW12TTdkam0welVHTFRPU1ptbjVYSTBFNDgvY3YrK1dvSnNkVFJy?=
 =?utf-8?B?ZUpBYnVQMzdTdDR1NjBOUTRrRmI5TVE2UHVDK2I5ZHh5T2xJYnJVdVd6ZXEy?=
 =?utf-8?B?aU12djdXMnJWRUpMWHJNWGQ5cjFVZXpSSWxtRDMyOXBCbTNNVDZLQ2lrZjhR?=
 =?utf-8?B?UGZWR3NwU1pSRWloOVBqNzhPU2NEOWVzWmJxRXBCbjZkM2RvOTZlalBnOXll?=
 =?utf-8?B?WWVxcDBFY3FZUHJ5ZERSM043Rmp3VXgxakF3dFRHNXpsVHZTN05QVEw2WGFl?=
 =?utf-8?B?U3llbUJlSkEzVDlraTJkSHB3NVZnZk50YUh1dkxuVHVsTGJkeVR3aEZnV1Fq?=
 =?utf-8?B?YW9vdGVaT0pvcVcwdFU0RjQvMmVEaHh2MnpJS3JUd0VwTEo5MVF2dTZVUGlE?=
 =?utf-8?Q?JwfuTEOjIkRvGGJm4g3l4wySh?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 150cc568-98f8-413d-dca7-08dd36d48d99
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB7804.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jan 2025 08:54:29.6840 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Qdoq/hIDaA7jvjooCsWqp7CeZJapYLLCSb6tgvs7FWjPu0o6deEJ/TIj4nX1jEWc
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7305
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



On 1/13/2025 7:12 AM, Jiang Liu wrote:
> Make the device state machine work in stack like way to better support
> suspend/resume by following changes:
> 
> 1. amdgpu_driver_load_kms()
> 	amdgpu_device_init()
> 		amdgpu_device_ip_early_init()
> 			ip_blocks[i].early_init()
> 			ip_blocks[i].status.valid = true
> 		amdgpu_device_ip_init()
> 			amdgpu_ras_init()
> 			ip_blocks[i].sw_init()
> 			ip_blocks[i].status.sw = true
> 			ip_blocks[i].hw_init()
> 			ip_blocks[i].status.hw = true
> 		amdgpu_device_ip_late_init()
> 			ip_blocks[i].late_init()
> 			ip_blocks[i].status.late_initialized = true
> 			amdgpu_ras_late_init()
> 				ras_blocks[i].ras_late_init()
> 					amdgpu_ras_feature_enable_on_boot()
> 
> 2. amdgpu_pmops_suspend()/amdgpu_pmops_freeze()/amdgpu_pmops_poweroff()
> 	amdgpu_device_suspend()
> 		amdgpu_ras_early_fini()
> 			ras_blocks[i].ras_early_fini()
> 				amdgpu_ras_feature_disable()
> 		amdgpu_ras_suspend()
> 			amdgpu_ras_disable_all_features()
> +++		ip_blocks[i].early_fini()
> +++		ip_blocks[i].status.late_initialized = false

As said in the previous patch, please don't add confusion. You could
maintain a state machine like early fini done/late fini done etc, but
please don't introduce this kind of confusing things.

Thanks,
Lijo

> 		ip_blocks[i].suspend()
> 
> 3. amdgpu_pmops_resume()/amdgpu_pmops_thaw()/amdgpu_pmops_restore()
> 	amdgpu_device_resume()
> 		amdgpu_device_ip_resume()
> 			ip_blocks[i].resume()
> 		amdgpu_device_ip_late_init()
> 			ip_blocks[i].late_init()
> 			ip_blocks[i].status.late_initialized = true
> 			amdgpu_ras_late_init()
> 				ras_blocks[i].ras_late_init()
> 					amdgpu_ras_feature_enable_on_boot()
> 		amdgpu_ras_resume()
> 			amdgpu_ras_enable_all_features()
> 
> 4. amdgpu_driver_unload_kms()
> 	amdgpu_device_fini_hw()
> 		amdgpu_ras_early_fini()
> 			ras_blocks[i].ras_early_fini()
> +++		ip_blocks[i].early_fini()
> +++		ip_blocks[i].status.late_initialized = false
> 		ip_blocks[i].hw_fini()
> 		ip_blocks[i].status.hw = false
> 
> 5. amdgpu_driver_release_kms()
> 	amdgpu_device_fini_sw()
> 		amdgpu_device_ip_fini()
> 			ip_blocks[i].sw_fini()
> 			ip_blocks[i].status.sw = false
> ---			ip_blocks[i].status.valid = false
> +++			amdgpu_ras_fini()
> 			ip_blocks[i].late_fini()
> +++			ip_blocks[i].status.valid = false
> ---			ip_blocks[i].status.late_initialized = false
> ---			amdgpu_ras_fini()
> 
> The main changes include:
> 1) invoke ip_blocks[i].early_fini in amdgpu_pmops_suspend().
> 2) set ip_blocks[i].status.late_initialized to false after calling
>    callback `early_fini`. We have auditted all usages of the
>    late_initialized flag and no functional changes found.
> 3) only set ip_blocks[i].status.valid = false after calling the
>    `late_fini` callback.
> 4) call amdgpu_ras_fini() before invoking ip_blocks[i].late_fini.
> 
> There's one more task left to analyze GPU reset related state machine
> transitions.
> 
> Signed-off-by: Jiang Liu <gerry@linux.alibaba.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 22 ++++++++++++++++++++--
>  1 file changed, 20 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> index 6b503fb7e366..c2e4057ecd82 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> @@ -3449,6 +3449,8 @@ static int amdgpu_device_ip_fini(struct amdgpu_device *adev)
>  		adev->ip_blocks[i].status.sw = false;
>  	}
>  
> +	amdgpu_ras_fini(adev);
> +
>  	for (i = adev->num_ip_blocks - 1; i >= 0; i--) {
>  		if (!adev->ip_blocks[i].status.valid)
>  			continue;
> @@ -3457,8 +3459,6 @@ static int amdgpu_device_ip_fini(struct amdgpu_device *adev)
>  		adev->ip_blocks[i].status.valid = false;
>  	}
>  
> -	amdgpu_ras_fini(adev);
> -
>  	return 0;
>  }
>  
> @@ -3516,6 +3516,24 @@ static int amdgpu_device_ip_suspend_phase1(struct amdgpu_device *adev)
>  	if (amdgpu_dpm_set_df_cstate(adev, DF_CSTATE_DISALLOW))
>  		dev_warn(adev->dev, "Failed to disallow df cstate");
>  
> +	for (i = adev->num_ip_blocks - 1; i >= 0; i--) {
> +		if (!adev->ip_blocks[i].status.valid)
> +			continue;
> +		if (!adev->ip_blocks[i].status.late_initialized)
> +			continue;
> +
> +		if (adev->ip_blocks[i].version->funcs->early_fini) {
> +			r = adev->ip_blocks[i].version->funcs->early_fini(&adev->ip_blocks[i]);
> +			if (r) {
> +				DRM_ERROR(" of IP block <%s> failed %d\n",
> +					  adev->ip_blocks[i].version->funcs->name, r);
> +				return r;
> +			}
> +		}
> +
> +		adev->ip_blocks[i].status.late_initialized = false;
> +	}
> +
>  	for (i = adev->num_ip_blocks - 1; i >= 0; i--) {
>  		if (!adev->ip_blocks[i].status.valid)
>  			continue;

