Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 101DE606A324
	for <amd-gfx@archiver.kernel.org>; Tue,  3 Nov 2026 06:35:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=0WCfCvYm
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 87C3A10E76D;
	Tue,  3 Nov 2026 06:35:43 +0000 (UTC)
Received: from PH0PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11011009.outbound.protection.outlook.com [40.107.208.9])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B6A6B10E76D
 for <amd-gfx@lists.freedesktop.org>; Tue,  3 Nov 2026 06:35:36 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sEE8y+tMHsIOSFeX3tBtwWap8RJAdmCAOVPExRa4v8097tNmHav3/BEzM6ECHLgRa2Lk4K8czY/ZC2O+UZNvMy2OKeCLT7ug2KTY/+zK/OmWaYKJTpdwhwbXbtbhh1tWktSPMlkUbigsnjhOkJvKDjhkvPPad9tdERVMD8mXoHuNSyq7OU3sPJnc2vW8KYZ46GhFd9vBPbm4HOyxCPqr0DrXOHNSdiL1zPgBYJOiIR/tAwzkAkJJPPBN6odA6tdt+Sw0i7Ed8ZbNeuFfVLsdaA0hWdSiAXFqad6y82SXK0xOpA+5v+5ulur77q7wg1Cyo/Uo1qoX09YHkuElsSP4Ag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bSuop6XO+N+RKapzz0p4NoI8GZFDAtrDLze5ku1Zw14=;
 b=U2YMu0zFYOWWy/ME7JRnOyFtbAPHFXR4DIsTrjkA+W5S55GjNslMUWUT6vH2abznLYnHERkPJVXuHV9bXe7pkPqSga31FhqnxhsqINK2gXKfZWW3rzYEVh7AmYAHDLrKyNU+UlqC9DG18jcBuvGmdLHq3hJrcXTHt5s4mkbhLquU5GP152soJaurhB0vVFSXE+/RIcd7+CC9tkVNd2wAHJrn5bD6XeW/gbfeJpe0/046qJ/YOx68vvhEnvQFDRLncAuIZMg4ZrvjS5dB9BdaSTV5+0cUmlAYksNGXrJuTonzQasS4bqGJfGpx4yOwYtgZNCmPmXGw0jGXmPjKfYrWQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bSuop6XO+N+RKapzz0p4NoI8GZFDAtrDLze5ku1Zw14=;
 b=0WCfCvYm/rfQqvTKJVWEK1xCilGvn8kX/dZcZyThVV5kuGQHOmvEk/MVZbOZeS4AYBozTLlXJ8sdTbk8U/Ka4VRQBrcK6qX4gUfz0uxBIj4Jk6XEQ0bVC4IWN/nJlu6/bsrRTfs5k2i+uc/8cMB+WCUb4AOfV2gGuoddhPxe1LA=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SA0PR12MB7091.namprd12.prod.outlook.com (2603:10b6:806:2d5::17)
 by IA1PR12MB9521.namprd12.prod.outlook.com (2603:10b6:208:593::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.569.12; Tue, 3 Nov
 2026 06:35:33 +0000
Received: from SA0PR12MB7091.namprd12.prod.outlook.com
 ([fe80::ec33:1213:cfd8:63bc]) by SA0PR12MB7091.namprd12.prod.outlook.com
 ([fe80::ec33:1213:cfd8:63bc%5]) with mapi id 15.21.0569.011; Tue, 3 Nov 2026
 06:35:33 +0000
Message-ID: <4a704ee7-01ef-40e0-8256-d0321914d27a@amd.com>
Date: Tue, 3 Nov 2026 12:05:27 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/2] drm/amdgpu: abort SPM VF init when the HBM
 aperture is missing
To: "Xie, Chenglei" <Chenglei.Xie@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Cc: "Skvortsov, Victor" <Victor.Skvortsov@amd.com>,
 "Luo, Zhigang" <Zhigang.Luo@amd.com>
References: <20261022153132.211631-1-Chenglei.Xie@amd.com>
 <20261029180652.213481-1-Chenglei.Xie@amd.com>
 <20261029180652.213481-2-Chenglei.Xie@amd.com>
 <3a518d91-c6ef-4fbf-8525-5a762d465ccb@amd.com>
 <SJ1PR12MB6121D39D1B80B22A317CD00B806A2@SJ1PR12MB6121.namprd12.prod.outlook.com>
Content-Language: en-US
From: "Lazar, Lijo" <lijo.lazar@amd.com>
In-Reply-To: <SJ1PR12MB6121D39D1B80B22A317CD00B806A2@SJ1PR12MB6121.namprd12.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MA5PR01CA0186.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:1ac::9) To SA0PR12MB7091.namprd12.prod.outlook.com
 (2603:10b6:806:2d5::17)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA0PR12MB7091:EE_|IA1PR12MB9521:EE_
X-MS-Office365-Filtering-Correlation-Id: 369a85c8-19be-44be-9369-08df3974a972
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|23010399003|6133799003|22082099003|56012099006|261102123227099003|10067099003|18002099003|261009223027099003|261021123027099003|261022105027099003|261021121427099003|261022075727099003|5023799004|11063799006|4143699003|261026121527099003|261028144727099003|261026140227099003;
X-Microsoft-Antispam-Message-Info: w42nbu0UkLf6vdsTw7YBT7+XI4k7lTjdUw/HNZ4OzwQP0RRgVFs6KBj1QaC2uikpSWe3BcjEI2ivLo1S7l0Bd6WNOlTJus1Q3VX/I50uF+HFbc8JePYo1t0FhIZiSsgvTo49LMO56D67jaP45e13uakrYPdXvhLOCLQXU+bdn6LlOvWOQfGYJge2jV+b1XA9fTb1k7vwvVTIZpNfaAGGPE+vSQ9c0vu6jOThxPvTBhs0xQ5h3r0bItLfkv2eRz4l9eFEbQx6JWGebhpAKgdnTn4/soWmF63/01bxvC6wW8H498S5dcOJARledcQVQx2/85i4SRCd+7KOm87LU9EFO1NoqXEkqYhCcUgPhoQKIAaMIsA+LTso/RDLs1KJTkMSQH96MBJ/tq/IMUglPVLs5lOKzP3lHmVy//r+qfQfVg8IAWfcLh02limvQS7F5NIGiinKDEznZXKidHxYd02fWEgefjl5gL6c2QtergHgY3kutMSiXuiA3lVDhd8avf6bdCpIjiGn1KwEXnUrltq7xDka2gJPuE1u/c+cohf75GGdkAE1NUgU2XUHhWR2diqtcNpiNXWDiatikU9+d87R3a67y08HfejrbMcX3Q18GifGbjTlGUNHOkQ72P1coGbZNt3fpVfO9lMAjczLGAt1Q5z3zamYfzGvGqEdnWkTrVo=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SA0PR12MB7091.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(23010399003)(6133799003)(22082099003)(56012099006)(261102123227099003)(10067099003)(18002099003)(261009223027099003)(261021123027099003)(261022105027099003)(261021121427099003)(261022075727099003)(5023799004)(11063799006)(4143699003)(261026121527099003)(261028144727099003)(261026140227099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Z2V3RGRjOWdCQjJPVzVmb1hZbDNNbWcwS2pxaHAxZzhONGNVK0hycnViazZF?=
 =?utf-8?B?UGUxSE1IRVV2TWJTemU4czBFSzFJMjJZOXpCOGcvQ3pRZ3dRMlZoQjc3ZDNE?=
 =?utf-8?B?dHNaSkw4K21wVU1CSDhiYlFHV2VsS1c4enhJNW9oY1htL2VsV3BUdWZuMzM2?=
 =?utf-8?B?dWNDMUozVExIY3ZkYkkwQ2R2VkNTMHltTm5HaVpnQ083M3JBZU9vS1VxOFdT?=
 =?utf-8?B?MGIwWWZMUjIveWNDTDFFakZwTXJOOFdHWlRzYVJBUFJmdVFHOE1uWGJ3SUhB?=
 =?utf-8?B?R3RLcWxpelU2SzVFRml6NjlIVCtNUEw4cVhWKzFkS3ZZR2xVeXVCeUpqVmxD?=
 =?utf-8?B?K3VpYXdpaVhmNkxNdUQ5MWZRbjNXazlXSUNJTzg5RDNnSko4cnU5QmdSYTdr?=
 =?utf-8?B?VCtLZFVQczkvTUVldDdzSC9BZlBOUFovQWpOM3hLeTlVc3FZd3o5SGxwNFZX?=
 =?utf-8?B?M3dBSlJZYldLRzZ3bmhlMm03Qk9CSHBNSkFXVXFRUTd4eGYwMWVTWExQN2dT?=
 =?utf-8?B?Y0xKY2VMWXp3VU8xNXNEaE1xM2R4TkFlUzg5eGR0ODMySGxteHlYT21HNnhz?=
 =?utf-8?B?MlVVYnFDODBOY3UyOFNNNmI1Y3VkNTBmOVQrWFBDTkgxYjdtT2tKMU84QnhU?=
 =?utf-8?B?YkVTZU1BUjlCQ3FHdUdiRzdYM1o5WCtpYldiSEZuSFlabTcyMWJDTEVqT2Uz?=
 =?utf-8?B?bng1Q2hPaUc1UE1kZE5NM1F3cDBOOGhLMDJCQU91STB0NUlxRWp5dVYvTGlI?=
 =?utf-8?B?STBNajlLTFlWUk9uTXd4OHhUa2oyYUhSVFVKT3FRWThtR2RTNWdLY0lGaWVX?=
 =?utf-8?B?WWRSUVlIYXBCWHkva25PajNidDBjaS9URHhZUWk5KzNodFRZVGthejVJditu?=
 =?utf-8?B?TlRFSjQvVy9qeUw5am50VVBPblR0bFZaN3VFOHVsdXk1M1FKKzZKUHNTU1JP?=
 =?utf-8?B?Ujg5UkZTdEVHQm9YeXdJWGMyVWVLTjVCTkN6NjF6anJHemFMNDFWU0F4QUt2?=
 =?utf-8?B?V05RTnBibW5xczFmTGNJTlRLcUt3amdQaktKMW9JU3FQcHBVQUhyVTZ1WjYz?=
 =?utf-8?B?bkM4N0tHcWJLT0czMUtac2hCeTNiSHpxYUhTakxjbGZSa2Qra1MrNU1iQ1NE?=
 =?utf-8?B?YWVXcGYyZWN6OEhIRGxaQndHT2FYL2YyZnhKcndnY1hXcVBtREd1WGpMNXdq?=
 =?utf-8?B?cnRMdGs1SW1WZDdHNUFRdHMreHNSMWxVNlRZRkRocjhqZFZiV3VPVFRaSHh1?=
 =?utf-8?B?ZURxYmFGK3RmUDBreHdETTJnUjYySFQ4eXEzVHFwZG5taEdvY2hBN2tJSnhO?=
 =?utf-8?B?S2hHOXhnbzY0dUhKZFhuaGRyekpmdjlrSjd2ajI4M0RFTXNvZTRZRTdncmtz?=
 =?utf-8?B?R09SaWdrbDBaOTIvajRqalBWNS9PRG50ejNqcExlcXNacHF5d0RidW1BV09u?=
 =?utf-8?B?T1FpK3NUOWszNHN1T1VUYXp0S2Mzck8xT1BsM2xTako0S0ZVSFpKZjNzS1p5?=
 =?utf-8?B?aG8vMS9hdytOVGtkb0ZzMjJrZ0dkM3N5S0x0T2tKdGFwWjdycXRDR3JkcTcy?=
 =?utf-8?B?TEF6cE05a0FPOUFBNGoxek1laGhOclNNUDk1MGIrSnpCWG55QXZtNjlyK1Fz?=
 =?utf-8?B?dFl4eVgwWE9SVUZ4K3dYWVBKNml2cmRiTEpXcHhFVHNkSUZzQTVTQXJxQm43?=
 =?utf-8?B?TzJCL1VmK212QUpRZlhzcmYvUWNCQzlNb0lJSklYVks3TUYybURoNDlrWk1T?=
 =?utf-8?B?SVVJZlFhQm9GWXdBdmM4Vi9vMVhWSTQ4OXdCTXpweGNjaW10UWdsTVJmUkFI?=
 =?utf-8?B?cGZvUkhVbkJuK1lEWWVJRlMyeWtyK05zT0NVMnVOWnRIcVNXdlNoOW51QVZp?=
 =?utf-8?B?NVBBZkZYTk54K2tXQjZvc25NcHhBMVhMY0VFakFNQzVqZzFCOWtnV3p3VUpz?=
 =?utf-8?B?TTdjTjVaWHlFYTJlQ1Fqd3k5dkN1c2NhVFplK2MwYmhPamhoL1RMZGk0VzNK?=
 =?utf-8?B?Z1o1OGR1TnliNlFsNVYwR0VIejErQWU3Y0crVzJtYlJTRkJVQnR6bFFnZDc3?=
 =?utf-8?B?d3JrRlBHdFRXdDA5b1ZoN3lKaENJUnZGcU91dmVGZ2syeDl1YjdwUHN6WVY2?=
 =?utf-8?B?TU8zbFpTY2RmelhDcURqaEFLY1VqWERGd3FGWWk2VFVHSDhoVjhXTDBsRDNJ?=
 =?utf-8?B?OElxSysyMmtyM2Fod25GbjVzN2VFd2lib3dTT3dSYW1EeGgyeTYwd3Q1WVFz?=
 =?utf-8?B?bXFoMEFpOGtXa3ZOQUMrVXBtcDdPb2poNXJNUlgzQlU2ZEpFZFNqdGdXQnhv?=
 =?utf-8?Q?DMT/9/Nnejn/JvPQh+?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 369a85c8-19be-44be-9369-08df3974a972
X-MS-Exchange-CrossTenant-AuthSource: SA0PR12MB7091.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Nov 2026 06:35:33.5567 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NGNkNdf7nQ79QsyBtOkB9mUDJbp1RKXCxORYTTE099t8eIHpqjNbD2MgguQKsjh+
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB9521
X-BeenThere: amd-gfx@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Discussion list for AMD gfx <amd-gfx.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/amd-gfx>
List-Post: <mailto:amd-gfx@lists.freedesktop.org>
List-Help: <mailto:amd-gfx-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/amd-gfx>,
 <mailto:amd-gfx-request@lists.freedesktop.org?subject=subscribe>
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-17.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1



On 02-Nov-26 11:11 PM, Xie, Chenglei wrote:
> AMD General
> 
>     +err_release_full_gpu:
>     + if (amdgpu_sriov_vf(adev)) {
>     + /*
>     + * Release the access the host is waiting on so it finishes the
>     + * handshake instead of timing out and FLR'ing the VF.
>     + /
>     + if (early_full_gpu_access)
>     + amdgpu_virt_release_full_gpu(adev, true);
>     +
>     + /*
>     + * Mark the VF inactive so the later fini path does not send a
>     + * request the host will never answer.
>     + /
>     + amdgpu_virt_deactivate(adev);
> 
>>Shouldn't this be called when amdgpu_virt_request_full_gpu fails for
>>early_full_gpu_access case also?
>>Thanks,
>>Lijo
> 
> No, it should not be called. If amdgpu_virt_request_full_gpu fails,
> the VF holds no access as the acquire handshake never completed.
> There is nothing to release and RUNTIME was never set,
> so the amdgpu_virt_deactivate() has nothing to clear.
> Jumping to err_release_full_gpu would send a release for access that is 
> never granted.
> 

In that case, this code needs to be changed to just return immediately.

 >        if (amdgpu_sriov_vf(adev) && !early_full_gpu_access) {
 >                r = amdgpu_virt_request_full_gpu(adev, true);
 >                if (r)
 > -                     return r;
 > +                     goto err_release_full_gpu;


Thanks,
Lijo

> Thanks,
> Chenglei
> 
> 
> ------------------------------------------------------------------------
> *From:* Lazar, Lijo <Lijo.Lazar@amd.com>
> *Sent:* Sunday, November 1, 2026 11:32 PM
> *To:* Xie, Chenglei <Chenglei.Xie@amd.com>; amd- 
> gfx@lists.freedesktop.org <amd-gfx@lists.freedesktop.org>
> *Cc:* Skvortsov, Victor <Victor.Skvortsov@amd.com>; Luo, Zhigang 
> <Zhigang.Luo@amd.com>
> *Subject:* Re: [PATCH v2 2/2] drm/amdgpu: abort SPM VF init when the HBM 
> aperture is missing
> 
> 
> On 29-Oct-26 11:36 PM, Chenglei Xie wrote:
>> An SPM backed VF has no FB BAR0 and gets its HBM aperture from the ACPI
>> SRAT. When that entry is missing, amdgpu_acpi_find_gpu_memory_in_srat()
>> returns -ENOENT, which the early init IP loop treats as the GMC block
>> being absent. Init keeps going and dies later with a confusing -ENOMEM
>> instead of the real cause.
>> 
>> Return -ENODEV from gmc_v12_0_early_init() so the probe aborts at the
>> point where the aperture is actually missing.
>> 
>> On a legacy host the VF already holds exclusive GPU access at this point,
>> and the early init error paths returned directly without releasing it, so
>> the host timed out and FLR'd the VF. Route these failures through a new
>> err_release_full_gpu label that releases the access the host is waiting on.
>> 
>> Add amdgpu_virt_deactivate() to clear AMDGPU_SRIOV_CAPS_RUNTIME and drop
>> adev->virt.ops, and call it from the same label, so the later fini path
>> does not send a REQ_GPU_FINI that the host will never answer.
>> 
>> Signed-off-by: Chenglei Xie <Chenglei.Xie@amd.com>
>> ---
>> v2: Move the runtime cap and virt ops clearing into a new
>>      amdgpu_virt_deactivate() helper and call it from the label. Drop the
>>      redundant SRAT error log already emitted by
>>      amdgpu_acpi_find_gpu_memory_in_srat().
>> 
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 49 ++++++++++++++++------
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c   | 12 ++++++
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h   |  1 +
>>   drivers/gpu/drm/amd/amdgpu/gmc_v12_0.c     |  7 +++-
>>   4 files changed, 55 insertions(+), 14 deletions(-)
>> 
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>> index 3ced5c18daaa..3b6a3d86348c 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>> @@ -1999,7 +1999,7 @@ static int amdgpu_device_ip_early_init(struct amdgpu_device *adev)
>>   
>>                r = amdgpu_virt_init_critical_region(adev);
>>                if (r)
>> -                     return r;
>> +                     goto err_release_full_gpu;
>>        }
>>   
>>        switch (adev->asic_type) {
>> @@ -2012,7 +2012,7 @@ static int amdgpu_device_ip_early_init(struct amdgpu_device *adev)
>>                adev->family = AMDGPU_FAMILY_SI;
>>                r = si_set_ip_blocks(adev);
>>                if (r)
>> -                     return r;
>> +                     goto err_release_full_gpu;
>>                break;
>>   #endif
>>   #ifdef CONFIG_DRM_AMDGPU_CIK
>> @@ -2028,7 +2028,7 @@ static int amdgpu_device_ip_early_init(struct amdgpu_device *adev)
>>   
>>                r = cik_set_ip_blocks(adev);
>>                if (r)
>> -                     return r;
>> +                     goto err_release_full_gpu;
>>                break;
>>   #endif
>>        case CHIP_TOPAZ:
>> @@ -2047,13 +2047,13 @@ static int amdgpu_device_ip_early_init(struct amdgpu_device *adev)
>>   
>>                r = vi_set_ip_blocks(adev);
>>                if (r)
>> -                     return r;
>> +                     goto err_release_full_gpu;
>>                break;
>>        default:
>>                r = amdgpu_discovery_set_ip_blocks(adev);
>>                if (r) {
>>                        adev->num_ip_blocks = 0;
>> -                     return r;
>> +                     goto err_release_full_gpu;
>>                }
>>                break;
>>        }
>> @@ -2062,7 +2062,8 @@ static int amdgpu_device_ip_early_init(struct amdgpu_device *adev)
>>        if (amdgpu_ip_version(adev, GC_HWIP, 0) == IP_VERSION(9, 4, 3) &&
>>            !amdgpu_device_get_rev_id(adev)) {
>>                dev_err(adev->dev, "Unsupported A0 hardware\n");
>> -             return -ENODEV; /* device unsupported - no device error */
>> +             r = -ENODEV;    /* device unsupported - no device error */
>> +             goto err_release_full_gpu;
>>        }
>>   
>>        if (amdgpu_has_atpx() &&
>> @@ -2123,7 +2124,7 @@ static int amdgpu_device_ip_early_init(struct amdgpu_device *adev)
>>                if (adev->ip_blocks[i].version->type == AMD_IP_BLOCK_TYPE_COMMON) {
>>                        r = amdgpu_device_parse_gpu_info_fw(adev);
>>                        if (r)
>> -                             return r;
>> +                             goto err_release_full_gpu;
>>   
>>                        bios_flags = amdgpu_device_get_vbios_flags(adev);
>>                        skip_bios = !!(bios_flags & AMDGPU_VBIOS_SKIP);
>> @@ -2131,8 +2132,10 @@ static int amdgpu_device_ip_early_init(struct amdgpu_device *adev)
>>                        if (!skip_bios) {
>>                                bool optional =
>>                                        !!(bios_flags & AMDGPU_VBIOS_OPTIONAL);
>> -                             if (!amdgpu_get_bios(adev) && !optional)
>> -                                     return -EINVAL;
>> +                             if (!amdgpu_get_bios(adev) && !optional) {
>> +                                     r = -EINVAL;
>> +                                     goto err_release_full_gpu;
>> +                             }
>>   
>>                                if (optional && !adev->bios)
>>                                        dev_info(
>> @@ -2148,7 +2151,7 @@ static int amdgpu_device_ip_early_init(struct amdgpu_device *adev)
>>                                                        adev,
>>                                                        AMDGIM_ERROR_VF_ATOMBIOS_INIT_FAIL,
>>                                                        0, 0);
>> -                                             return r;
>> +                                             goto err_release_full_gpu;
>>                                        }
>>                                }
>>                        }
>> @@ -2159,14 +2162,16 @@ static int amdgpu_device_ip_early_init(struct amdgpu_device *adev)
>>   
>>                }
>>        }
>> -     if (!total)
>> -             return -ENODEV;
>> +     if (!total) {
>> +             r = -ENODEV;
>> +             goto err_release_full_gpu;
>> +     }
>>   
>>        /* Request full GPU access only for the remaining SR-IOV init work. */
>>        if (amdgpu_sriov_vf(adev) && !early_full_gpu_access) {
>>                r = amdgpu_virt_request_full_gpu(adev, true);
>>                if (r)
>> -                     return r;
>> +                     goto err_release_full_gpu;
>>        }
>>   
>>        if (adev->gmc.xgmi.supported)
>> @@ -2184,6 +2189,24 @@ static int amdgpu_device_ip_early_init(struct amdgpu_device *adev)
>>        amdgpu_smu_early_init(adev);
>>   
>>        return 0;
>> +
>> +err_release_full_gpu:
>> +     if (amdgpu_sriov_vf(adev)) {
>> +             /*
>> +              * Release the access the host is waiting on so it finishes the
>> +              * handshake instead of timing out and FLR'ing the VF.
>> +              */
>> +             if (early_full_gpu_access)
>> +                     amdgpu_virt_release_full_gpu(adev, true);
>> +
>> +             /*
>> +              * Mark the VF inactive so the later fini path does not send a
>> +              * request the host will never answer.
>> +              */
>> +             amdgpu_virt_deactivate(adev);
> 
> Shouldn't this be called when amdgpu_virt_request_full_gpu fails for
> early_full_gpu_access case also?
> 
> Thanks,
> Lijo
>> +     }
>> +
>> +     return r;
>>   }
>>   
>>   static int amdgpu_device_ip_hw_init_phase1(struct amdgpu_device *adev)
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c
>> index 576a818db522..a4dd0299fe11 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c
>> @@ -135,6 +135,18 @@ int amdgpu_virt_release_full_gpu(struct amdgpu_device *adev, bool init)
>>        return 0;
>>   }
>>   
>> +/*
>> + * amdgpu_virt_deactivate - stop driving an SR-IOV VF after a failed init
>> + *
>> + * Clear the runtime capability and drop the virt ops so the teardown path
>> + * does not issue host handshakes the host will never answer.
>> + */
>> +void amdgpu_virt_deactivate(struct amdgpu_device *adev)
>> +{
>> +     adev->virt.caps &= ~AMDGPU_SRIOV_CAPS_RUNTIME;
>> +     adev->virt.ops = NULL;
>> +}
>> +
>>   /**
>>    * amdgpu_virt_reset_gpu() - reset gpu
>>    * @adev:   amdgpu device.
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h
>> index 3971bcc1ed11..3520af170278 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h
>> @@ -471,6 +471,7 @@ bool amdgpu_virt_mmio_blocked(struct amdgpu_device *adev);
>>   void amdgpu_virt_init_setting(struct amdgpu_device *adev);
>>   int amdgpu_virt_request_full_gpu(struct amdgpu_device *adev, bool init);
>>   int amdgpu_virt_release_full_gpu(struct amdgpu_device *adev, bool init);
>> +void amdgpu_virt_deactivate(struct amdgpu_device *adev);
>>   int amdgpu_virt_reset_gpu(struct amdgpu_device *adev);
>>   void amdgpu_virt_request_init_data(struct amdgpu_device *adev);
>>   int amdgpu_virt_ptl_request(struct amdgpu_device *adev, u32 req_code,
>> diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v12_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v12_0.c
>> index cd276a138e10..3bb13cfed92f 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/gmc_v12_0.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/gmc_v12_0.c
>> @@ -667,8 +667,13 @@ static int gmc_v12_0_early_init(struct amdgpu_ip_block *ip_block)
>>   
>>                r = amdgpu_acpi_find_gpu_memory_in_srat(adev, &aper_base,
>>                                                        &aper_size);
>> +             /*
>> +              * An SPM VF has no FB BAR0 and cannot init without the HBM
>> +              * aperture from the SRAT. Abort this GPU probe instead of
>> +              * limping on as if the GMC block were absent.
>> +              */
>>                if (r)
>> -                     return r;
>> +                     return -ENODEV;
>>   
>>                adev->gmc.aper_base = aper_base;
>>                adev->gmc.aper_size = aper_size;
> 

