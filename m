Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 48528D44C46
	for <amd-gfx@archiver.kernel.org>; Thu, 15 Jan 2026 13:58:37 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DC4F310E764;
	Thu, 15 Jan 2026 13:58:36 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="k5QC021l";
	dkim-atps=neutral
Received: from BL2PR02CU003.outbound.protection.outlook.com
 (mail-eastusazon11011039.outbound.protection.outlook.com [52.101.52.39])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1E67810E764
 for <amd-gfx@lists.freedesktop.org>; Thu, 15 Jan 2026 13:58:36 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=aIjcUS5KcdmqUe+q1vGSDfUM+XbYrNF/i0EAAmVJzkXqS6U7cce4SQ+KtutUP9TVx3DqtVscTE3erpXBCAJLRNX2o/PCC9yaP/abK0I81YRBn7c9kbXzUrUS4zsE8I8y/zFXUQanN/ZxS9t2Y7KzUceh/k9ZGMn8tSDbY+ld4lrMovT+fZn4ZtGzqtSKS54mZRCvqD91Ydbx2bDoa0j1Nnrn9bwuBTLasYIeXBx43dGa/Fh88gMVzkQyNrR63qm+tWjDvHdFy2p5WuIgAurcvk+B/dgdPDZDAF/5FpsMowjK0SB4pe/fZNtY1vpPZJcD7VA6MHRKwqEpKghNtIpXxA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Y4PopeTMJaRk8dpF/MVHL1SGCQgiFp74BzszsVQnggU=;
 b=VmKRp9y9/ntsYkU/QOY6NSGNP+zzy4saqbdmzL4wkInbHmh/i6HXGMfdi8tDe7pjKWXnecuOi0AzEFglaPsYQPNOX6jZLVC6LRMN9k/a2QQUsjL7s9hZuSOez9jwbrgq8sk3iBWFHgwmZ0X5qp0NIVdalceTwbZ6BpBgYBiY4/oFv6gQCJCm8oDCGoRAePpDx5z9Y1wRxY092RWPZyNhmfIUgHFegWzTwJLzarIhP9wI1RqEbOOS5EVDnKvX8ivIhfT/rU3GIJN04VjUiTmml+ZhhFtCB4UGRxDMue9XDSHFzeqlLThzBrOG9+7WMfvw0eZsRaQnSblhTLNcFiOuVw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Y4PopeTMJaRk8dpF/MVHL1SGCQgiFp74BzszsVQnggU=;
 b=k5QC021lX6ZM3q7mZLKaI+JHEdgi/oFtxhiKa4vyoPYnY+YdH1r12dGi1n1X0OCL/Su5IPZYXoictxdXI9alXn+0s2Lxq1xTtXR4CwRvJaQjxE+aZXwjLvP4CWM0Ltv7yvyV/PCezKFbPozRnhBDzanZcS6Lorw99ukbFjPPLaw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by DS0PR12MB6581.namprd12.prod.outlook.com (2603:10b6:8:d3::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9478.4; Thu, 15 Jan
 2026 13:58:27 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5%4]) with mapi id 15.20.9520.005; Thu, 15 Jan 2026
 13:58:26 +0000
Message-ID: <809efea0-66ac-4968-9a6d-75b96938a4df@amd.com>
Date: Thu, 15 Jan 2026 14:58:17 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/1] drm/amdgpu: free hw_vm_fence when fail in
 amdgpu_job_alloc
To: Amos Jianjun Kong <kongjianjun@gmail.com>,
 Jiqian Chen <Jiqian.Chen@amd.com>
Cc: Alex Deucher <alexander.deucher@amd.com>, amd-gfx@lists.freedesktop.org,
 Huang Rui <ray.huang@amd.com>
References: <20260115025548.621264-1-Jiqian.Chen@amd.com>
 <CAFeW=paBoemhGFkra+qf7CwrmoQSEXKwsLJ1rzS+CL91_3=x1w@mail.gmail.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <CAFeW=paBoemhGFkra+qf7CwrmoQSEXKwsLJ1rzS+CL91_3=x1w@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BN9PR03CA0198.namprd03.prod.outlook.com
 (2603:10b6:408:f9::23) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|DS0PR12MB6581:EE_
X-MS-Office365-Filtering-Correlation-Id: b5490ea4-6dcc-4768-18c1-08de543e27dd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?SVhlM3RFbjhuTmV2SkNMTmZJY0p5aXR2VUxJVnBFRjdXVEJXbVBQdzFwY00r?=
 =?utf-8?B?RkJuSVE5TllwUlhiTDFkT096NWo2bCtBajFocy9aQURmditJcjJIY1pEbXpQ?=
 =?utf-8?B?bHNIdTVEZzFZZUZzSWFGT3NnVVNGMHE4Qk9OcTJEazdSemZGUHRHdy9KV1do?=
 =?utf-8?B?Rk1lS0xWSHNKOHJqck14eVRKcXRHSlBweWRsdnBQQmdSMlBkU0VYSnJ5MXRL?=
 =?utf-8?B?VlpjZFpQVmJZZ0pvRDJNNFp2NFBVcXRPUWVFclowcDJLT2EyTEJoUmxWMU9B?=
 =?utf-8?B?dVVPVFZPOE9jNkZEMDVuNk5icUYzNDdyTWlYaStoWkJVVk1sVnY4ajBjM3My?=
 =?utf-8?B?dko2RldzU2pnUlc0OHk4WVlYLy8vV3FmK0VoN2tVNmlkR0k1MDBBTCtBVjIy?=
 =?utf-8?B?QzQrWGtTU0dwU05FQUFpblZrOVhLOXVmclVDOC9nbXB4Um5XbzJyVnhkUm00?=
 =?utf-8?B?WnZWNU15SnJRYk9pYnRyR2tmeTJJcXFGMkhINFFqZUszOWloUExmMmJvVU0y?=
 =?utf-8?B?akRjTlkzNUFVMFZsYU1OVHdLNk1uZk8wWmRQRzlScFZ4dXo4TjZPZDJWa1Bm?=
 =?utf-8?B?aWlXajdHVTkzYlBLSVZMc1ZkR2R1cHowekY1akYvL3lLMGMyaHFNZDMwVUJR?=
 =?utf-8?B?UUFDQm16NWl4bWVLK3FNVEhDaVZkeFBBM1I5ZXJFWm1NaUpTT3ppV1ROcUtQ?=
 =?utf-8?B?ZlZFNG9yN0kwQlF1WGlMN3RyOEhqNnhYZU9UdnFQRXlZQXRrNE53R21tOXJ1?=
 =?utf-8?B?R0IrUmtlSzdpQmNUTzNnM2Z0MjR5Z2taR1N6UTZibGVLVnE4Y0NaaVl2NUEv?=
 =?utf-8?B?NkdXYUM1QSt0VER1SEdmL3hJbERXbEkzVDQvaGxidlpJcnJOLzhPaFY0aFd2?=
 =?utf-8?B?U1pHeUV5Ry9UNk9CNG1kcm5kRnkzWDFRbzEvTUtxcFk5a3pmcUU2c1ZnZ0lx?=
 =?utf-8?B?M1hwR1JsUE56RzJNUS9aV3h0RElLY3QvSTdrSDMvc2s3eVpaaWpoczU0eVBQ?=
 =?utf-8?B?d0xCZVNSbjBvVTFiOU90MVByZFNtenlQUFZZakhHdDM3L3ZCZC9HblcxNXVa?=
 =?utf-8?B?ZUNBbGZzRVEzU0FoYktVbDRiaTExaEhKRkhDdmFuaCtUL3g3MFhIRnZZRi9p?=
 =?utf-8?B?NGdIVzVaWTk4T2pTMmFXYlZsTVZ4bTlzblYzRHlBSng3amw5N3dsOE1yWURQ?=
 =?utf-8?B?L0s5VllVS3BBZzdWV2Z5aGE4bGcyWGtDaDB1WjA5ZGVqbmdZNkhpaTJoN3dR?=
 =?utf-8?B?WHBaZnZXYlNQbktjUEN4SkY3NVBmUUNpbmJSRVQrRVhjTnVmT3Q4OTRKbVdk?=
 =?utf-8?B?Zjg5ejFFb0c5NTMzQkxuTWptRXl6SlZ3U3J2Qm14VCtHSm8xdGpCZ056NmFl?=
 =?utf-8?B?MUtRUEpycW9iVy82YWhxUnoyMHFvMEo3TFE4WkFPVWFycmJoYStUTEUwZlFm?=
 =?utf-8?B?WXhyM2Vpa1FlVXB4RHEwZ3FBNEJzV3F4UG5rSWlqaUVMTXc4cFZlZk9vOVlV?=
 =?utf-8?B?VjVTZTFkV2czZnN4dnJiRlNKbzNVUDRtSG51VWdidlRDYWZEaFNvNXQ2TFpq?=
 =?utf-8?B?Q3ZXOEVESFArNTRWY3FVUGdJNll1bk9kdUREM1lIVU9Od1g5K1AvMEg2SlBJ?=
 =?utf-8?B?WlE3NzZJY0x1Z0sybUxIbUlia0ttT0xhMFlGUHZ4amxId20wNHBwOW82TDQ0?=
 =?utf-8?B?NVhHbEllYTlqOUtVYTFNejcxQVA5aDMzY1B6eld0dnpMdHkwbk9kQ2pzRm4v?=
 =?utf-8?B?eWo3eVV1eWRjcFVqdGpXd1BvWVN6OHo4NUcyVGRFVTRxa21OQzZNcWRaSUpv?=
 =?utf-8?B?d0NjRTJuR1hIWGc2TDVQZGdmTnMyVlg5d1NSQjUwdnBCdzR1Mk9KTjNudWoz?=
 =?utf-8?B?akpmM1dhdVUyS0ZMTGpvV21kZlEvcmxhRmFZUE1uZzl5N3dpSGNnMjBRQnBn?=
 =?utf-8?B?ZlowWlRWVmxlcmF1TU93R1laWDdPVGU0eUdBRjJldjBycVVQdnJyeUt5TFY3?=
 =?utf-8?B?OTBIbmFacVBNWjFGY05jbVJZOUkyL3R1MnB2UUVPcVBjTU9haHkzUlZrR3pC?=
 =?utf-8?B?ZXJjazBYcDFYY01HMkkyQXQzUC9EMDJQS29CdTd2OTB4cDFOWUYwWHpjY1VJ?=
 =?utf-8?Q?YKOA=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(7053199007); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZWxIL0s4NFdiUGQrc25yMVJ4dSt6dGRyL1c3Wk5kbWVSUWFOcjcxcTFWbmVD?=
 =?utf-8?B?N1JZb0dVemNMYXlnYzFpdFQzd0N3SGJHNDlpMTJteTZvUEEzcm45SWpGU09y?=
 =?utf-8?B?UklyWXFBTnAyYzM4c2tpRmY3Y2grWnZiV0hlYy92OVBlcjQzQm10VXZLM211?=
 =?utf-8?B?d0cxWXJqU3VPMWw4Ui8zSndSNzI0N0h4UVlmMDl0aWJFNkpYWWJPK1J4dkpC?=
 =?utf-8?B?U0dCbWJ5MmpTREEyeXBDc2MySStNMno2TVVjNWpmU09UWityUzFhUjNXWk1C?=
 =?utf-8?B?VGlNbEF3Z3B1SUJwRXQzSis4MHZwR0M4K1poZWVwakVWdE9ReHQxNlBOeklu?=
 =?utf-8?B?c1R2TnRIRWxLdkxFTXpueGg2YnhQcEpTYW9vMncxbURZSTEweERBVXV1L1Fa?=
 =?utf-8?B?dDhKRFJ5eFR0VmJ3OFRtZ3RIQ1llK0JrVjRHWDRjblNaTXlWb3JTUUcrNzZZ?=
 =?utf-8?B?T2V3MWoxSE9rdkhCYkZseW9paXZlVWpsM0xkWnEzeVJZc1RSNldCSlprdm81?=
 =?utf-8?B?bGswQU1tTU91NlBGa1FQOWdobVR1ZWpQWVVaOGxrSkJFUU5tTjJwZUMzcFRR?=
 =?utf-8?B?K3d5MkpDaFJJNnpHTzdUbnNvUTZWbS83ZERoSU1KdlhYZ3FHVVJ0RjBsRG9J?=
 =?utf-8?B?TFl4TFVLR29oZU1aRzNha0c4YVpuS2JyUGFtcUNaNGJwVjNZZDcxZjVjN1FD?=
 =?utf-8?B?NjlJaVhXaW1ZekNOMHJSbjZIQ1pPZkxDcFEyaEtGOUNHc1NNd0c3MVFFa1BX?=
 =?utf-8?B?em4wdHJxaTZzcGtISmo3b0Y4YUxPU0VwclZicVNSNmRQbGZWUjZmRkF5UVVJ?=
 =?utf-8?B?SUJGbjVrcnBLS2l1UHpBZGRiekMxRzBPZFl6elp3endyUnQ4VjRMYk1yNlVL?=
 =?utf-8?B?SzlvZE9DckJxaFVyY2EzV0Z6Ny9QQkdSeExhUHVvaExZYkZqNko3d2d5Vkhk?=
 =?utf-8?B?WFdhdUV2eThQVVppWEZueE8zYXVDempteU5RQit0ZVE1blltd0xPZS9GQ3M4?=
 =?utf-8?B?YXd5MTc4RUhpWjE2SnBzY3RRMm5YdExuV1N2YWp1NGhpdkRnU25XUFZrQXAz?=
 =?utf-8?B?bHgzNnQ3azJyc1oya1F2UVBqNHljMUhFM0dFdWNZQTRWSk9SZXdYeHhuWFpu?=
 =?utf-8?B?clA3MkxWQTJVV21tTTE4MjlWRkRnSkxKUUtXUndldkgwUXJoc0hGK2xMbkVm?=
 =?utf-8?B?QVFIeDh0bDQ2eWdOc29QT1hqa05lZ0FoNHExZE1xL0JBMDA2VkF1UkdaWVA3?=
 =?utf-8?B?Rjc3dTVNalZyQXBFOGxSVFNoZkZtZVZ0amlKOEVZdXp5aWtwM290THRaYmdl?=
 =?utf-8?B?dWhabFQzMEtRcVBRRHNPSTRwSlhoNnZxaURaTWRIMkdnQUQ2RU9uMUdRQXY1?=
 =?utf-8?B?Nk90QThrQzFtTGx5YXdodDg5TnpEbGFXYVAxVldsQ0RSSkd5RjQ4cy84RmQy?=
 =?utf-8?B?VjlsNzB4YnJtWm4ydG0wdTNHNUlmT2d2UlhzWDl1YVVXWkpYYmZjd3VEWG1U?=
 =?utf-8?B?ZE9FNld4czNab1VvcUJzYnRGMDIrSUt4TmZPWTFzMkpJczlVb0dIRlc1U3Jl?=
 =?utf-8?B?U3BPdUNQbzRGKzRsQmQ2NHZtYWtvb1dqbWV4VG1qSFVSU2grNnY0ZE5DYm1r?=
 =?utf-8?B?bGJjNE9pNmkwNWxSbEd3enQrbWRGRWxkcnBWUE9vYUZsYWpRaVFLdERtaXlQ?=
 =?utf-8?B?eWJPTG5IZ2F4bFljQzZuaFM0VkJjWUtoNXZPSlZlMEVzR0FxbGd5UjNBSXlv?=
 =?utf-8?B?Y09BYnJwSGJYYXY5bzR1cjd4TXVWZlI5QUpxYmZ6TFJ2Z2VLMExJc1JpZHZ3?=
 =?utf-8?B?ZEdaVXFpQmdnYlZKRDMzaS9qbnZHbkVEQ052L3ducWVlazZTM0twWFh3cFhM?=
 =?utf-8?B?Yk42TXdsSnBrcm9ZajhpL1Y3eFhKQzNPK2NGdngxbWpHaHFIeExMK3pDVzR3?=
 =?utf-8?B?dlRyZkdFc2JvbGtVTUgxRENIb2dDNVNBWnE3K1N5cVpjVDloUDl4RTZBcEV6?=
 =?utf-8?B?eEtZSFVWZnh6Tk5IMGtCaFN4dms1cGJDN2Q4RjNFcm45NGM4WVZUWG5zaEUr?=
 =?utf-8?B?Yk04amRXSHFkUjRsNFZia0ZzRG9qTWdTaXIyTkkrUElkOExQNUhKUEVGcVUv?=
 =?utf-8?B?NCtDeFZYWmN2MCt4Y25YdUdvdHBuUTA1VlFoeEF5R0x2bEtuUVgxOFZIQ1E2?=
 =?utf-8?B?OHdDWGt0UHdBaXFjZlZsZ2MxQ21YOWkwaTh5cVZySXBveWJzZVZwcUcwcTNn?=
 =?utf-8?B?Smxha252czA2NDJxMXNienk5Z1NZeHpxMTRrZG1DallFSzVDNUZGdHZrTndS?=
 =?utf-8?Q?uMCt72jr4Lb8BRUdWJ?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b5490ea4-6dcc-4768-18c1-08de543e27dd
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jan 2026 13:58:26.8380 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PjbIae3Q9BR6/80Et64rZmyNKkiO9CL5KPyw2SkcCAQMD+avXvSOvx3Vv24N0HAB
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB6581
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

On 1/15/26 05:15, Amos Jianjun Kong wrote:
> On Thu, Jan 15, 2026 at 11:02 AM Jiqian Chen <Jiqian.Chen@amd.com> wrote:
>>
>> If drm_sched_job_init fails, hw_vm_fence is not freed currently,
>> then cause memory leak.
>>
>> Signed-off-by: Jiqian Chen <Jiqian.Chen@amd.com>
>> ---
>> v1->v2 changes:
>> * assign the return code of drm_sched_job_init and check that instead.
>> ---
>>  drivers/gpu/drm/amd/amdgpu/amdgpu_job.c | 7 +++++--
>>  1 file changed, 5 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c
>> index 7f5d01164897..1daa9145b217 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c
>> @@ -219,8 +219,11 @@ int amdgpu_job_alloc(struct amdgpu_device *adev, struct amdgpu_vm *vm,
>>         if (!entity)
>>                 return 0;
> 
> I have a question that may not be related to the PATCH.
> 
> Why not check 'entity' at the beginning of function amdgpu_job_alloc()?
> Currently if the 'entity' is invalid, the allocated 3 structs won't be released.

That you don't have an entity is not an error but normal condition.

It just means that the job is pushed directly to the HW without going through the scheduler.

Regards,
Christian.

> 
> 
>> -       return drm_sched_job_init(&(*job)->base, entity, 1, owner,
>> -                                 drm_client_id);
>> +       r = drm_sched_job_init(&(*job)->base, entity, 1, owner, drm_client_id);
>> +       if (!r)
>> +               return 0;
>> +
>> +       kfree((*job)->hw_vm_fence);
> 
> The V2 looks good, it's already addressed the problem mentioned by Christian.
> 
> Reviewed-by: Amos Kong <kongjianjun@gmail.com>
> 
>>  err_fence:
>>         kfree((*job)->hw_fence);
>> --
>> 2.34.1
>>

