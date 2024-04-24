Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3571BC4345F
	for <amd-gfx@archiver.kernel.org>; Wed, 24 Apr 2024 13:41:43 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D3E5F113B67;
	Wed, 24 Apr 2024 13:41:42 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="aYL4ZdCL";
	dkim-atps=neutral
Received: from NAM04-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam04on2057.outbound.protection.outlook.com [40.107.100.57])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 43070113B67
 for <amd-gfx@lists.freedesktop.org>; Wed, 24 Apr 2024 13:41:41 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=H89XBpLpfiykWnXt9uwu8a4qwfRibfbQA1kbGRODGjKD15nQ++5hDk5obT+mnJ+H4kfd/DHweYPjIIs+zVXrG/Lfi+DRQgxNUQ7MsWrGtEnbJ6JYqZ+Hsn/owMe1FVZmdWZ0CgDFHRvsmCgpbTNjQr2ZeN4FRrlpEuGYTti15wPLcNNBF40wGfoRHxpPU47K5axvXQcigXlVeouj0Uyavb5ivnjr1njV6idGGkygWotQ0hrqdSR+X6YDxFLp5eiEkNABc6PxIPeyiaXwjlNvNgbcy+Vzh6l3xL+sJfGO1/CJvjpnt/4Gw3LLPskkgIIRCBQJAJkqeqDWv5+5W0H9NA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2EELHhwX1Bzm4hKKNc3Us9aRgCLobg6BP1EndbULhqI=;
 b=NrUyJQpna/Yx+wElvL4p7H4LGJxytuXG3vyxL3Lde5eDZlnsjqYwitx8auzV9p22mQhskcZ21AluSneIH85OgKEKx0e527iTp8oPXl1Th2/3zpCqCE5Y+UmsM/7BKEhdWjhds/nEHnee8ru1UbPDBziDgSJ7NhqRKcVeu2ENZtbaA9fMjwtzx8zHVcFwEaZYAprHxTiUZFPl+uBxhMzLqXvBxOeyXTQkDWF1USrRC5lAM3Xw+Y3FSQNUhwLtrLN7tDlz7dIAjD9+vnsckGr8l81Dn8xWSXfuTzn/YgsDXYYVka1Lu8OL1psbOQkkamLRwoulWElrTaJ2ZPVZT9IE1A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2EELHhwX1Bzm4hKKNc3Us9aRgCLobg6BP1EndbULhqI=;
 b=aYL4ZdCLSc49420GU/nIRlu3fUPk4+6qVVaVbbLIZ0DblS6I3Z7GapbK42Rv8cDom7k3rvthQHZE8TqV24v2M/tqIeIcGZbjtBfGNY3dBIc5gsgc7LGtXQq2ATexan5CvEf3t8S3+1bMxAPTXIuuYvpbcDpiYMDMJ1QXwTg7jAk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB5149.namprd12.prod.outlook.com (2603:10b6:5:390::14)
 by MW4PR12MB7191.namprd12.prod.outlook.com (2603:10b6:303:22d::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.44; Wed, 24 Apr
 2024 13:41:37 +0000
Received: from DM4PR12MB5149.namprd12.prod.outlook.com
 ([fe80::f3cf:148e:3827:8035]) by DM4PR12MB5149.namprd12.prod.outlook.com
 ([fe80::f3cf:148e:3827:8035%7]) with mapi id 15.20.7519.021; Wed, 24 Apr 2024
 13:41:36 +0000
Message-ID: <58f1bd9f-66db-c4de-4070-e430ed9ae33b@amd.com>
Date: Wed, 24 Apr 2024 09:41:35 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v5 4/6] drm/amdkfd: Evict BO itself for contiguous
 allocation
Content-Language: en-US
To: Felix Kuehling <felix.kuehling@amd.com>, Philip Yang
 <Philip.Yang@amd.com>, amd-gfx@lists.freedesktop.org
Cc: christian.koenig@amd.com, Arunpravin.PaneerSelvam@amd.com
References: <20240423152900.533-1-Philip.Yang@amd.com>
 <20240423152900.533-5-Philip.Yang@amd.com>
 <21046a73-459f-4dc0-90b3-adef3ef6319b@amd.com>
From: Philip Yang <yangp@amd.com>
In-Reply-To: <21046a73-459f-4dc0-90b3-adef3ef6319b@amd.com>
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: YT4PR01CA0118.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:d7::10) To DM4PR12MB5149.namprd12.prod.outlook.com
 (2603:10b6:5:390::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB5149:EE_|MW4PR12MB7191:EE_
X-MS-Office365-Filtering-Correlation-Id: 67209bad-7deb-4bc6-cc58-08dc64644330
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?c2E1QytySDltOSs1Q1hDMFNFVEdnQ0E4bXNJQUdCNW9xcTZSRmdKVlFzYmtq?=
 =?utf-8?B?R1d3eW5tUXZCcHRFUllPV3hCbzNpbUh2RkVoV2ZMYUlrbUkyV2pkQS91ajNn?=
 =?utf-8?B?RlpWc1VwVUV6OGYxL3QzWDNvMHBJb0hOZ2FOUlAzc0ZhNkxTc1F0VHhDU3dp?=
 =?utf-8?B?QmtITUxhMkdwQ1g2Z3FRd3N4Q2NQSzBtbzVQSkRiZ3dncXZkVHpHd1ZpYmtT?=
 =?utf-8?B?cUpaT0VtcFBsWjNEL1NGSFBucjIydHZ6Z1hEWmx4VkpRQTUrWk5LNTdaa05J?=
 =?utf-8?B?RWV0Ym5IT0hidU9KYk4xMURVSnAzNDlzS1A2aDl5eHdVNjZKd3ZtRUxPdExt?=
 =?utf-8?B?bmkxQ3JLQ2p5OEtGNklHcFZSSFE0WHY5UHR5VGNWNnpjQldnWkQ4Sy9Ua21w?=
 =?utf-8?B?L3VXRVhzclNkQzVWMW1ZcWhpWDFWbW9MOWNSRjNTZWR5dVZEUDU2MklKWWVH?=
 =?utf-8?B?cHZqb1ZCbGdHRnVGRVc3UXpBbEYvZjNES2pxUldZb2xWM1RhMlRramM2L00x?=
 =?utf-8?B?YWFHZTBneVRyWGd5clZ2QjZhblpEbTBOVlBrSlNXM2VtN053M211cEtkSEtN?=
 =?utf-8?B?WHM0M1NRMmhsWEhuWlM4eisxTmlEZEd0NzBpV3J1UXRZMERxUDBNYVlwOU9r?=
 =?utf-8?B?Y1ZleXZhN1NJK285S2Z4dXdIZWdCaTJsTm5INHVjSzEwSUtvRlIxQUxYMHdx?=
 =?utf-8?B?aDdTMXZNeVBwcWg3TUJGeTJmSEY4OGVadUR0ZVUrYU8xeiswdmttYU1EU0dz?=
 =?utf-8?B?NlByWEFiN09ucEZGZHNpVHU2UFFHZURXVzMvM0hyOUxQeGVDenFGbmt1cnda?=
 =?utf-8?B?dnVsRm9IdnVWMm1ya1hkaHdiZ1ExUTdaSUROUmVYbHdtZ0ZYZXJsckFhZEFI?=
 =?utf-8?B?SkRHMmxxM083cTdYbzNvY2VKOGd2OVR2VUtyUjV6anRUNXY0YWFERWQxUVpq?=
 =?utf-8?B?SThEVjJlbFdIaVRHakdtNVlVVmFNZ3VtUnkzSUFNbWdCRkE0S0FEYmRoNk5P?=
 =?utf-8?B?N2VEeWNhQjdoMHlyYjl4N0hVbTRzSVpTclNxT0NJaldEb1R6QXJ0aVNtcitr?=
 =?utf-8?B?b1pXbXYyNFh5QitTWEhZcW0xeElobkdrYTQvVDFQNjdDeWxWOWJPUDhUak1Z?=
 =?utf-8?B?U0ZzUGM5bXVoRmthZEVQMmtpby9tR3lhcGFQVmZzNzJ5K0laUGlGbldBbmxU?=
 =?utf-8?B?dTJQVkFENmgyY3pXc1FJc0NnL1hwMVdHVU5uVXJiUGg2OENQMkVlZWdLekh3?=
 =?utf-8?B?RDdaR0xlL3JoWEtEYkgrTGFKMHhBT3ArdEtlV2ZNSGhUdjZ5bis1dnhZa3Zv?=
 =?utf-8?B?SVlNb0szWGpuMjVTaG9IaFoyenhLa1U3NnI5dk13TlcyNXBhV1dTWDZ3NndT?=
 =?utf-8?B?NlhoeEg1UXl5dG5yVk1POE4vY2tzenE2dTRaS0cydGNzNG1ITU9Ua3dTUjQy?=
 =?utf-8?B?QldtWGZmOVhBYzFFY2FGZURGUklUNDBJV2YvQWxCVXJGSXNpcU5SL1VEZ0xD?=
 =?utf-8?B?UWMzRG5MbVZFb0p5UXFrSklMWVQ5QUt3MG11OUFVeUxYSklwbkZ1bnZPdXVD?=
 =?utf-8?B?RmZlZzA0bVpOQTNiODRiK0paUWozSmZXZjRidm9sM1dNZHFIbUUybzZWTjZ6?=
 =?utf-8?B?RXlwVmREK0hHMEZNN2VJRXoyZjlQTzFNOVZ6YmljRmRDZ3p1NGFhVGYvWEdC?=
 =?utf-8?B?OTRIZW9uaU9zdURNNzJMdkVyekJtV1VNZXRQb3lPQjNUazdPdUowK2xnPT0=?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB5149.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(366007)(376005)(1800799015); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NTZEMTRCQ3B6WnlCcndENWJzdHROMC9Rb09ZNG9PUGhBTUV5MU5lSlZOME14?=
 =?utf-8?B?eVJSck1qS0toMFNVRUlFZjdFMXRUMENMOG5VTEZXQVZRbkNnRjE0UDJjUGxM?=
 =?utf-8?B?aEVVbU1JV1BYYnZLMHNJekVOOS9rZy9KR1JsRWhWWkdJZWQwQ0xFTURsTFZO?=
 =?utf-8?B?ekszWVdSTWNSNEpHK1JFSkpXTnJqN0thOUhpN1g2NGhPcEYzWUx4ZG5BUTdR?=
 =?utf-8?B?RkJtdVp3WnpvTCtrNzRTditWekZOM05abkFXa0VyNlJHSTA2bHA5eDJiem9w?=
 =?utf-8?B?dm5OcUFxQW0xN3llbERUdzMrdllqVFVWZ3hDTnIxTE00bGx0VDVYQmozWW94?=
 =?utf-8?B?UnBqZ0d0RlA2bm5Md2pjUEJZbWJ0RU9URXhieFB3aldnWHdpRG5iMklCSEto?=
 =?utf-8?B?SWhOOTNpL3ZleDkxdlhvd29sRjZZRUdwdmVWNmM3WUErRXBIK01hS3h3bUVH?=
 =?utf-8?B?ZGhCWElwRVo5SUI5OUtRMyswT2xySmlWKzRqSTVLNEQxNkdlMXo0dHBEeSs2?=
 =?utf-8?B?U1c3SlFDV01DWWt0WlA3OXNTRGhtRy9WTS9iZnV1UHVoYndSMmRFUVd5VE5v?=
 =?utf-8?B?cTFJKytLdkNGbUdqTy9uZXlvSllRb3Z4eWFYQ284RDlPdXBBdUswZDVQVGl2?=
 =?utf-8?B?TVo0QnNaZWpJNytCc1JhWW1jN2daNk5hWkpMbGxFeTkzZUcyWDZxZzhYQkdq?=
 =?utf-8?B?MTVHeHhSc0lkSzV3SnpycDc3cVVaVmZ5dzJrendRYjNRdHU4bjh1QythKzh1?=
 =?utf-8?B?RTZub3pPOXdzRk1zRm9DTjh6OFE3QVNXeHhZaUdqakZZbnhDbmFLZnN0Q0ZX?=
 =?utf-8?B?Wm1sbEp3MmM4c0d0WkdpdWVJcUpBSlVxaWtjVytoa1l1d01DanVBQlFKZnpy?=
 =?utf-8?B?RVZhWHNiNm5RcURzS01QUVFpS0s5WWVINnJBNzgvckxqQWNHUy92STNvb083?=
 =?utf-8?B?aUtnSThtcTg0aVpSTFpYV2RRQlJ3bGptMGt4UkUrUkdGY3g2bDh1S0tWdmpC?=
 =?utf-8?B?WEE0Rms1bTNuT0lBOXhYN2dvalBIcEhtYlFkWkdTWmpBV0pBZEZRUXF0Tnd5?=
 =?utf-8?B?Z3UrL0NXQ0hFZzhPZjZNa01jQkhYN0s1RXNSdHBvZlkxUXlmS3RGL0svVWZL?=
 =?utf-8?B?UEdWNktVUGlIYWh1MDI1azZtd1BuNUovZ2FqeUg3THo5bEdrNnlkcTZHV1pJ?=
 =?utf-8?B?TXlXczE5aXE2SisxbWZDVmhLKzJ2NWlqWTlzbkJzS0lmeXQ3K3B4d2lsNnhU?=
 =?utf-8?B?TEVsWVFOQWRWWE52ZzBjMWlldG01MDVRRWdjWHozRWhnZno3dGVWNTNMb1VD?=
 =?utf-8?B?bkdxY1BkWFZITXZPSW5tVjNLTlFuc3krdloxQktEa2R2WEQzYUM3QUR3blpV?=
 =?utf-8?B?WWgzcFVEVkpnWENlMDRuNlQ3anpIQ2tRMElXVXpGY3FHZmh3Q3dZZCtTQ0Jr?=
 =?utf-8?B?N3ZjbU15blU3OEFiMllrNUlUUFAvUXh5UlVXNUJ1VnFFS0tiblc5a2xoSmhL?=
 =?utf-8?B?Z3NrY0oyOVN1WTRKRmNGWEgzUnUxMEF3SkR1dkpFdzZnK1VQNHFzZzEycndm?=
 =?utf-8?B?bklVNmFyb2F1dzJ3a0NFT0hKRllLUW9kcVBIMGZ3cWhNRm13UnpnTnUweml4?=
 =?utf-8?B?UUM4RFhKRHc0UkU2R0RNUGwzeWhYajRVL2lGbkxhKzVoMTdkVlhjcEg3V2x2?=
 =?utf-8?B?VW8yOFRQZVFCTHR2dm0xSkFDS0pQdXJtMG9PRXl3MmF4VFBiVkdWTFZSaFZS?=
 =?utf-8?B?WXhXQkx1R2JNZjNRc1NPMEd5dXFwWlNuYWhTYWVZM3hCeE9aM1A4MXpjclph?=
 =?utf-8?B?UXdjQ3lJOGhqSkZLUGxQajB5NUV5RFY0L1kvbS94djIyWXJlTXFjNmhYQ3ln?=
 =?utf-8?B?VE1hTnI4bmtMMWNReGk4NlVqaG1jQ1hDNlJxN2MwTUVMdFJ4VFJOQTExakVq?=
 =?utf-8?B?RmhpdXdRcEFYSzdaODVFVjBheERsVWtGL1dKL1dqRjliOUhOUDFlZ3Z1d1c5?=
 =?utf-8?B?cVNTeThucEdWVkFMUzdSK1VtQXQ5WWtmSGNBWnJZQzFkY2JUTnQzR29KUUlt?=
 =?utf-8?B?bTFrOWdoOVV5T3gvbHZOY3JtaU84UjJIajlNZzlqRnNmcmxyVDZ4SlJqdFlZ?=
 =?utf-8?Q?chW0=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 67209bad-7deb-4bc6-cc58-08dc64644330
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5149.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Apr 2024 13:41:36.7655 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: aNvWL5zJuKZCoGNTAwQB+0HfMRmbiE66RjuuAkALNDAkGEcrQVskMCLckPrhVpvE
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB7191
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

<html><head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
  </head>
  <body>
    <p><br>
    </p>
    <div class="moz-cite-prefix">On 2024-04-23 18:15, Felix Kuehling
      wrote:<br>
    </div>
    <blockquote type="cite" cite="mid:21046a73-459f-4dc0-90b3-adef3ef6319b@amd.com">On
      2024-04-23 11:28, Philip Yang wrote:
      <br>
      <blockquote type="cite">If the BO pages pinned for RDMA is not
        contiguous on VRAM, evict it to
        <br>
        system memory first to free the VRAM space, then allocate
        contiguous
        <br>
        VRAM space, and then move it from system memory back to VRAM.
        <br>
        <br>
        Signed-off-by: Philip Yang <a class="moz-txt-link-rfc2396E" href="mailto:Philip.Yang@amd.com">&lt;Philip.Yang@amd.com&gt;</a>
        <br>
        ---
        <br>
        &nbsp; drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c | 16
        +++++++++++++++-
        <br>
        &nbsp; 1 file changed, 15 insertions(+), 1 deletion(-)
        <br>
        <br>
        diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
        b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
        <br>
        index ef9154043757..5d118e5580ce 100644
        <br>
        --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
        <br>
        +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
        <br>
        @@ -1470,13 +1470,27 @@ static int
        amdgpu_amdkfd_gpuvm_pin_bo(struct amdgpu_bo *bo, u32 domain)
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (unlikely(ret))
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return ret;
        <br>
        &nbsp; +&nbsp;&nbsp;&nbsp; if (bo-&gt;flags &amp; AMDGPU_GEM_CREATE_VRAM_CONTIGUOUS)
        {
        <br>
        +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /*
        <br>
        +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * If bo is not contiguous on VRAM, move to system
        memory first to ensure
        <br>
        +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * we can get contiguous VRAM space after evicting
        other BOs.
        <br>
        +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; */
        <br>
        +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!(bo-&gt;tbo.resource-&gt;placement &amp;
        TTM_PL_FLAG_CONTIGUOUS)) {
        <br>
        +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ret = amdgpu_amdkfd_bo_validate(bo,
        AMDGPU_GEM_DOMAIN_GTT, false);
        <br>
      </blockquote>
      <br>
      amdgpu_amdkfd_bo_validate is meant for use in kernel threads. It
      always runs uninterruptible. I believe pin_bo runs in the context
      of ioctls from user mode. So it should be interruptible.
      <br>
    </blockquote>
    <p>yes, pin_bo is in the context of user mode, from KFD alloc memory
      or from rdma driver get pages, should use interruptible wait.</p>
    <p>amdgpu_amdkfd_bo_validate is currently used by kernel threads and
      ioctl amdgpu_amdkfd_add_gws_to_process (this seems bug), does it
      make sense to add parameter interruptible, then we can remove many
      duplicate code amdgpu_bo_placement_from_domain + ttm_bo_validate
      or I can fix it here and leave the cleanup and bug fix in the
      future?</p>
    <p>Regards,</p>
    <p>Philip<br>
    </p>
    <blockquote type="cite" cite="mid:21046a73-459f-4dc0-90b3-adef3ef6319b@amd.com">
      <br>
      Regards,
      <br>
      &nbsp; Felix
      <br>
      <br>
      <br>
      <blockquote type="cite">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (unlikely(ret)) {
        <br>
        +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; pr_debug(&quot;validate bo 0x%p to GTT failed %d\n&quot;,
        &amp;bo-&gt;tbo, ret);
        <br>
        +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; goto out;
        <br>
        +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }
        <br>
        +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }
        <br>
        +&nbsp;&nbsp;&nbsp; }
        <br>
        +
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ret = amdgpu_bo_pin_restricted(bo, domain, 0, 0);
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (ret)
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; pr_err(&quot;Error in Pinning BO to domain: %d\n&quot;, domain);
        <br>
        &nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_bo_sync_wait(bo, AMDGPU_FENCE_OWNER_KFD, false);
        <br>
        +out:
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_bo_unreserve(bo);
        <br>
        -
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return ret;
        <br>
        &nbsp; }
        <br>
        &nbsp; </blockquote>
    </blockquote>
  </body>
</html>
