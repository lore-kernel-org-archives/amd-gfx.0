Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0BEE1C4345F
	for <amd-gfx@archiver.kernel.org>; Tue, 30 Apr 2024 19:09:47 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6427910F772;
	Tue, 30 Apr 2024 19:09:47 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="2Rf33pev";
	dkim-atps=neutral
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2072.outbound.protection.outlook.com [40.107.237.72])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5DE0710F772
 for <amd-gfx@lists.freedesktop.org>; Tue, 30 Apr 2024 19:09:46 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=e09s6+0K99B73fF/HKQXBHNgVbsTGN91RuWgxn1woPce5NuA35E7Guk6551FwaTiCRwyxjX/rzjlqq/tbnOR8JlEKiLh8AXHJEI1Fg2tskcRraK0pxyUTfTVlSoVcI7Svdoww1m1GuBTHC7yrcuJxty8q6ET0N7pYDX9Vqh1oldvebBWuiG6izJdHdLLWc99VxF0K+f8PC+j9a6eY1G57Ypx/HdGPqOdTpA4e6FzVIjyw8cHRtYWqNlbY9adOnfyxHbDMllsVRpVuOsCGM+jxAdD8zW4WXkgQjWI/8aJNfPXmhx6DyOA/QtPRjRRLB3E1IxefX6vux5LP4G01XhIVw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ve09BMilmHRO6fq26kPpX8iSRzTIdAheB/9FsTSBCCo=;
 b=IQqYgesQs4BAOy1msHq0oZ+5WE2FQ/KnM4DBGRaF6HA0xTXuzr9BgoRg/3XFu3veBdC2rvJET5NSu83X4hWjODq4yq1/hvuWxLGDXKHPMtpJ9aEWkZ+grJUDwJO2dxFmNUU5jlyVca3ulGeiq+JpwjkP0cVbouaQNJUUR6s4NYuac1ZWTCcV6rvAXfWWaRVTNH3BD3Bt2/6KuNm8qUFzvYu97U2z5rqP29XsCm4mJ96rn2E7U4pSihFZfx/foZOnnXhxjVSaAecUFnKMIuYuD+g3nCTfSdSzEU30X/1iiy1K2lQIUA3+z5O0FP4q8cj+n/VO63DAQjgdfsATILVo+Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ve09BMilmHRO6fq26kPpX8iSRzTIdAheB/9FsTSBCCo=;
 b=2Rf33pevVZtxP9n/jQ/OhiZh0ptYHAtyxaCx09eAoVOL12/hGaTN0Dhtzf3HsbF1Qdl5kogMq3q4rxunHbep5C9xKTlUwdiQc3zrOy0uarzPHUuJfjKFW+pg9zKNJyhgr+HFID4y+9qskCfxHEypJ+wIkNnALQBWsaORbBHDxbk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS0PR12MB7804.namprd12.prod.outlook.com (2603:10b6:8:142::5) by
 CH3PR12MB9194.namprd12.prod.outlook.com (2603:10b6:610:19f::7) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7519.34; Tue, 30 Apr 2024 19:09:43 +0000
Received: from DS0PR12MB7804.namprd12.prod.outlook.com
 ([fe80::8327:d71a:ce21:a290]) by DS0PR12MB7804.namprd12.prod.outlook.com
 ([fe80::8327:d71a:ce21:a290%5]) with mapi id 15.20.7544.023; Tue, 30 Apr 2024
 19:09:43 +0000
Message-ID: <9503daa0-9f42-4632-87d5-5e7cd16140a5@amd.com>
Date: Wed, 1 May 2024 00:39:34 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/4] drm/amdgpu: Fix two reset triggered in a row
To: Yunxiang Li <Yunxiang.Li@amd.com>, amd-gfx@lists.freedesktop.org
Cc: Alexander.Deucher@amd.com, christian.koenig@amd.com,
 felix.kuehling@amd.com, emily.deng@amd.com
References: <20240426035742.90560-1-Yunxiang.Li@amd.com>
Content-Language: en-US
From: "Lazar, Lijo" <lijo.lazar@amd.com>
In-Reply-To: <20240426035742.90560-1-Yunxiang.Li@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN3PR01CA0169.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:de::13) To DS0PR12MB7804.namprd12.prod.outlook.com
 (2603:10b6:8:142::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB7804:EE_|CH3PR12MB9194:EE_
X-MS-Office365-Filtering-Correlation-Id: 2e3a9c5c-6eae-4731-20fc-08dc69491773
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|376005|1800799015|366007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?aytWS3BBeGNySmIxRy82dTI4dENxTmIvczZHOUZGczVNS2crZWNpZGlqOWtH?=
 =?utf-8?B?bUhlMGhZQTBOUGdtOGlZT2NEWFlXWUNOV3VvUWlWRkhWRjU0ZXY3UUlRWElz?=
 =?utf-8?B?bXVCL3JpTUxzNDZGU1JPZENzYXNQdkxId1V6WkFqb1RoY0tTTE43RVo0NWFk?=
 =?utf-8?B?U29EbVgwQ2hCZDNtZjBJaGg3bWk4TCtSc3ZFMWFLMWN1eDloWWRydzA1Ulo2?=
 =?utf-8?B?SitKVFhTd3NNYXVHUEJsWHhaVFFZT2Y5dGZ5RUtHQXlneFNKOEQ3VENGbmxT?=
 =?utf-8?B?akpBOU1GbmxaUkYzT1RGWjVrRExpZXNUT3R2VDFaLzJ1U2cxL2NPRWs1TUxo?=
 =?utf-8?B?QmpaY1lRWUFGMERDNy9VcHZxYzhsMUEwR00wQ3NEMXc5V1EvNTFvblY4eWZ2?=
 =?utf-8?B?THdFaGUySTZSTzg0L1hQb0kvNXVVLzNsc1pFYkxoZ0k0bTlHbTJ1eTZtYmF0?=
 =?utf-8?B?Nks4V1ZZcEI5YlFRRFErbENHOUhnendDbkFqa05SS0dzMlJGWlhZaHBPd3Y3?=
 =?utf-8?B?U1hkY0xmMGJYK1E5d1NOUExyNXU0Umw0QVRROUFxR1UvSHJ4T1pKV1lNZHFG?=
 =?utf-8?B?azdBMjZkUkswZFArQUJyNXAzK0ZsSFhBL2lrM2NBaiswbHhqbm1pMVJOWm1V?=
 =?utf-8?B?SXVWSjhUWGQxbHdFYnVaRDlvSzh0YmI5Z0prbWVBVzU0c1J3bTBQVUt0TFZI?=
 =?utf-8?B?QVhCVXphb0NzeTNnWkMrN294VGtNQS9VMHdZYWczZVRuWWxjMXZURFd4SzFw?=
 =?utf-8?B?SFhwaTI0eGNTODNPcm4rT0pub09ieEtTbERqQll0YnZQYUlzQ0tMRWh6SC9J?=
 =?utf-8?B?WENEcEgyWXdTMVFkNXIzNE01ak5ZaUNnTFFEMXl3ZHZSS1UvMzE1emR5TTYx?=
 =?utf-8?B?UnNuelozQjBUVXo4K3JaRVFNTThicHBWci9tZ3Q1WVQ3QU5tS1FJTzRONVZ6?=
 =?utf-8?B?ckV5Vk5oKzJuY3R3ZUljVnhrVzhyRUtHdnFjZCtlYjNsWDMvbDEyOTRXTXBV?=
 =?utf-8?B?U3E5WmpTZUJ4YnFMNzNXSS84ckE0VVJiUStvbE8xVFVER2lEWVM4TkdjM1Ex?=
 =?utf-8?B?bkttMTRzbGVPVEJpUzR1N25walZMZDcrbXpjSERGVElNRUhZSGdHM2Z4UWZw?=
 =?utf-8?B?REhRTXk4RnozWjZJRDhoN0lCdmZKN3lEOGFoZ0R0Z2pMbGVUdVBXaE5HbU1K?=
 =?utf-8?B?eGxDT29BcnFvM0Z5dURPQ1BiQnlXUHZJY0VrQTZ3d0h0VXpnbURNR2hJWW9T?=
 =?utf-8?B?Ni9USHJ1SkQrUis0WGcyOGpOYTJVRlAwSXAvQVRKWUpjZUZvSmlEMk5QKy83?=
 =?utf-8?B?VDFHYmExY0xxVnhIRnlHdUNJb1BXOHJjQVNVTHlVY0wzQWFkUXNEMjZoWE1X?=
 =?utf-8?B?ZnBSdzRYS09PejhWQTl2SGRaSEZLdXJJbUxRb3dEazVoUU5XemQwSlBGdHl3?=
 =?utf-8?B?eXA3TzNhamlLcU9SUkJUaGtUWU9XdVRaMnFVSWlCeXh1dm9BVlZuTFcwSVdS?=
 =?utf-8?B?cHJXK2hLVjFRV2h4bEMwdU5UcUFWR0hlS2ZTV0F1T3NTaWVoeEhtYmR5bGFN?=
 =?utf-8?B?Zy9relVmUzdIVnVJWHJLVWVzUW9QdUZKTTkyc2ZESXBoejBhaHRCVU9YUlo4?=
 =?utf-8?B?eXhGVGkrbm1uK1U0VjBvd1p2OHM1Y0VONWllc002R254M2YwTVBBTkVqRW5O?=
 =?utf-8?B?UGVGd1I4RThtNTg2Vm01Skw0VkVPd2plSnIvZ0JSeDhzdkZENGxubWJRPT0=?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR12MB7804.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(376005)(1800799015)(366007); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Z3g5bEswSEdpdUlJWlhwUVMxajhHWHdxRGdGSEJrUmMwUUV1THhnV01XK0Fw?=
 =?utf-8?B?UFVJYzFsS01mOFBaSFFlbjZtWHVkVFRjSkd0YkFCVkljc3RZK290WFpXZmYz?=
 =?utf-8?B?SmxvYy9hR1BTelFhL3JsQlF2YTVqU093MjRmNWFmbWRCT0xOWVBwU2tXNDFi?=
 =?utf-8?B?VndwQXlJRytsYmRIaXlRanNoN01tU0VQdHNTL3dBUFd0RnV2T0tCcnpONWNI?=
 =?utf-8?B?ZS9wMUdhakUzbnIxWUlZNmJFNU02c2NscGFlZEFGMXRMS3Z0c3lnUnV2MlJN?=
 =?utf-8?B?SlpVMFVHQUJuRDQwQTMyeXp4Vk9vdEV1RUgwbXVJYXNhR3N1dTlpVS9ZUnQy?=
 =?utf-8?B?MElWS1NXTkFRZXg2QkJvT0FkR3AwREU2T2tiSmh4T000dVVscnNCY0pXQ2ts?=
 =?utf-8?B?Qlo4eVF4d3dOVWw4dXFlR2w4NXl3anUwd1BIeGdKOWFSeU5RNGpLbWI2dlJ5?=
 =?utf-8?B?TkxSV1JMUkRZdWtieDhpTE9EQjZ1YUpyeFhZaWRGUTVDRk5OKzU5Vm9tWEZr?=
 =?utf-8?B?bmExcWt2d0RjVVd4clZyWmluUTdGcmV4L1dQSit3S0ZwalNXTmlGYTVLVjZn?=
 =?utf-8?B?OEsyTnFpQ013VkxiYytNWTduay9ySllLUDhGM1kxRisreFdlMzlUUXI1d0pH?=
 =?utf-8?B?NlZ3QWk3d21qQ2psaEtXSW5rZW1MVDMwVGpYQXRldHdna2t4NHFkdGJuOU9W?=
 =?utf-8?B?TU9lTTd1V1l2dTZMVG4wN2k2OERhblplby84b3lpdlF4NlFRc0krL2NUbTZk?=
 =?utf-8?B?WXhXcXJFOEJPazg0dFpXOW9RREpLOTZkZ0dQMUFUYVlZYmZaS2Z2b2JjcXRz?=
 =?utf-8?B?M01lWUFIcWdKSHNJMmQ0dDd4TnBFZDZ0d3ZOMDVNekJ3THFkREo2cTVWcGhv?=
 =?utf-8?B?MVVJWDZxdzJHUGg3ZW8zNGRSWDJ1akZHdVNIcnB1d2tFOTBwSHdCOTJBS3Ir?=
 =?utf-8?B?Ni9tQ0JwRXdKa1RmK2xTVTZ4bmJKKzExUVZHMFRNbEg2d2ZUV1E1cXRVQ0JH?=
 =?utf-8?B?R1NveWFoMS96NW15RFhaVWIzMVluMzdId004WU01UEJXK0Vwa2M3MCs2RVd1?=
 =?utf-8?B?Sk5oSkNPeWRHUXRzN2JxcHBKSXB3SjdGYm5laitmZWtsb0dCelYvN0JRV0F4?=
 =?utf-8?B?NGVodk1lUUUxM3l1RkNMUmJpWEVSd1ZEcWMxMHAwUVJBeGJYZm9YV0JmZ0hw?=
 =?utf-8?B?dHZzR1Y3L1dwUTV1OUo0Rm54UFV1Y3F6YktiQzNadHozUFZucmpjWHJqUUFP?=
 =?utf-8?B?RmZ5QUd3RGJldG84NWQxRjY3TDRJTTJ5S0FicmUzRjY3ZXdZU2o0NGlObDRz?=
 =?utf-8?B?UEZxZksyS2lKbkRtVGU3NkRJSDhDeUxnbk5iV2lXSHlhaUFGY0NCeW1VVkMy?=
 =?utf-8?B?aUVRWFl5SllxVHR4YUtnTW9zVUVGYVI4Nzh4WHlheTR0WkY3QjBDeVNFTCs5?=
 =?utf-8?B?TVBPdnBlZk94VFZnNEpOM0tDWmVmbXg4S0h4OTNYSEYzV21tRmtOS1c0Zng1?=
 =?utf-8?B?ZGlZbm9LdnFJbFNWdEQvRklFNm1EcU1PK3VVYTNtNHd6cFhGN2ZBVmdYaHZK?=
 =?utf-8?B?R2k2N2E0NDlpTjJ2OVQrUldTL2R5VkZScTFwczhDWFNqVmhFdW84aGVyY1pu?=
 =?utf-8?B?bzREZGgwdFBpd1FmQ0ttZUYzNWN0L096YzBKRVJoTWxpSU90OE91RGl3SDRr?=
 =?utf-8?B?SjZMSGl6RzRyREhhb25aUm1mamZFaVhvVCthWkNoOStYeHBtZytaNFBtMUlz?=
 =?utf-8?B?b0ZnN2hCYm9iT2h3VU1LZ1p4dkVWTDNqYkJqR3Bvb2p0VzBNNWV4NTlvZk1W?=
 =?utf-8?B?UUdydFNLMk1XQlpQY0pDRDBvcllJcXZ6UGFFS1lEd1Mvb1dpNXlrYVhHM3Vl?=
 =?utf-8?B?bGVzeFVYd25UaUp4OVlKV3ozMGpxdUUrajk2ZlJUZll0OVpIRy9qd2tIQ1RX?=
 =?utf-8?B?Vy9KcEtUbkRnUUJ0YnNZT1JaSkVSaHJNQ1lFZHJvR0dDdmVYTU5xQnBaZHVX?=
 =?utf-8?B?bUpzVGRUaWhQTkRhWjM1dFBZUHVacG5GUW1CTXFISlN5ZHdrbGFQdlAzcXBM?=
 =?utf-8?B?bnVtOVN2bGlaUG5makVJSGRBQlpLY3FpYm93NzFzcmZmbEZWQTJETzhQRUV3?=
 =?utf-8?Q?uNNWDwyicQ6h8pCSJ6hok9UPo?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2e3a9c5c-6eae-4731-20fc-08dc69491773
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB7804.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Apr 2024 19:09:43.0349 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: C7uyYIkMm7UMBhSqHMwjdFwDrvC5toh+ewRmZWUk/iyLHsuAvTM7KXRR+GwuzA+2
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB9194
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



On 4/26/2024 9:27 AM, Yunxiang Li wrote:
> Some times a hang GPU causes multiple reset sources to schedule resets.
> The second source will be able to trigger an unnecessary reset if they
> schedule after we call amdgpu_device_stop_pending_resets.
> 
> Move amdgpu_device_stop_pending_resets to after the reset is done. Since
> at this point the GPU is supposedly in a good state, any reset scheduled
> after this point would be a legitimate reset.
> 
> Remove unnecessary and incorrect checks for amdgpu_in_reset that was
> kinda serving this purpose.
> 
> Signed-off-by: Yunxiang Li <Yunxiang.Li@amd.com>

Reviewed-by: Lijo Lazar <lijo.lazar@amd.com>

Thanks,
Lijo
> ---
> v2: instead of adding amdgpu_in_reset check, move when we cancel pending
> resets
> v3: no changes from v2, collect all the patches in one series for easier review
> 
>  drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 19 ++++++++++---------
>  drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c   |  2 +-
>  drivers/gpu/drm/amd/amdgpu/mxgpu_ai.c      |  2 +-
>  drivers/gpu/drm/amd/amdgpu/mxgpu_nv.c      |  2 +-
>  drivers/gpu/drm/amd/amdgpu/mxgpu_vi.c      |  2 +-
>  5 files changed, 14 insertions(+), 13 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> index 861ccff78af9..8befd10bf007 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> @@ -5070,8 +5070,6 @@ static int amdgpu_device_reset_sriov(struct amdgpu_device *adev,
>  retry:
>  	amdgpu_amdkfd_pre_reset(adev);
>  
> -	amdgpu_device_stop_pending_resets(adev);
> -
>  	if (from_hypervisor)
>  		r = amdgpu_virt_request_full_gpu(adev, true);
>  	else
> @@ -5823,13 +5821,6 @@ int amdgpu_device_gpu_recover(struct amdgpu_device *adev,
>  				  r, adev_to_drm(tmp_adev)->unique);
>  			tmp_adev->asic_reset_res = r;
>  		}
> -
> -		if (!amdgpu_sriov_vf(tmp_adev))
> -			/*
> -			* Drop all pending non scheduler resets. Scheduler resets
> -			* were already dropped during drm_sched_stop
> -			*/
> -			amdgpu_device_stop_pending_resets(tmp_adev);
>  	}
>  
>  	/* Actual ASIC resets if needed.*/
> @@ -5851,6 +5842,16 @@ int amdgpu_device_gpu_recover(struct amdgpu_device *adev,
>  			goto retry;
>  	}
>  
> +	list_for_each_entry(tmp_adev, device_list_handle, reset_list) {
> +		/*
> +		 * Drop any pending non scheduler resets queued before reset is done.
> +		 * Any reset scheduled after this point would be valid. Scheduler resets
> +		 * were already dropped during drm_sched_stop and no new ones can come
> +		 * in before drm_sched_start.
> +		 */
> +		amdgpu_device_stop_pending_resets(tmp_adev);
> +	}
> +
>  skip_hw_reset:
>  
>  	/* Post ASIC reset for all devs .*/
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c
> index 54ab51a4ada7..c2385178d6b3 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c
> @@ -597,7 +597,7 @@ static void amdgpu_virt_update_vf2pf_work_item(struct work_struct *work)
>  	if (ret) {
>  		adev->virt.vf2pf_update_retry_cnt++;
>  		if ((adev->virt.vf2pf_update_retry_cnt >= AMDGPU_VF2PF_UPDATE_MAX_RETRY_LIMIT) &&
> -		    amdgpu_sriov_runtime(adev) && !amdgpu_in_reset(adev)) {
> +		    amdgpu_sriov_runtime(adev)) {
>  			amdgpu_ras_set_fed(adev, true);
>  			if (amdgpu_reset_domain_schedule(adev->reset_domain,
>  							  &adev->virt.flr_work))
> diff --git a/drivers/gpu/drm/amd/amdgpu/mxgpu_ai.c b/drivers/gpu/drm/amd/amdgpu/mxgpu_ai.c
> index 0c7275bca8f7..c5ba9c4757a8 100644
> --- a/drivers/gpu/drm/amd/amdgpu/mxgpu_ai.c
> +++ b/drivers/gpu/drm/amd/amdgpu/mxgpu_ai.c
> @@ -319,7 +319,7 @@ static int xgpu_ai_mailbox_rcv_irq(struct amdgpu_device *adev,
>  
>  	switch (event) {
>  		case IDH_FLR_NOTIFICATION:
> -		if (amdgpu_sriov_runtime(adev) && !amdgpu_in_reset(adev))
> +		if (amdgpu_sriov_runtime(adev))
>  			WARN_ONCE(!amdgpu_reset_domain_schedule(adev->reset_domain,
>  								&adev->virt.flr_work),
>  				  "Failed to queue work! at %s",
> diff --git a/drivers/gpu/drm/amd/amdgpu/mxgpu_nv.c b/drivers/gpu/drm/amd/amdgpu/mxgpu_nv.c
> index aba00d961627..fa9d1b02f391 100644
> --- a/drivers/gpu/drm/amd/amdgpu/mxgpu_nv.c
> +++ b/drivers/gpu/drm/amd/amdgpu/mxgpu_nv.c
> @@ -358,7 +358,7 @@ static int xgpu_nv_mailbox_rcv_irq(struct amdgpu_device *adev,
>  
>  	switch (event) {
>  	case IDH_FLR_NOTIFICATION:
> -		if (amdgpu_sriov_runtime(adev) && !amdgpu_in_reset(adev))
> +		if (amdgpu_sriov_runtime(adev))
>  			WARN_ONCE(!amdgpu_reset_domain_schedule(adev->reset_domain,
>  				   &adev->virt.flr_work),
>  				  "Failed to queue work! at %s",
> diff --git a/drivers/gpu/drm/amd/amdgpu/mxgpu_vi.c b/drivers/gpu/drm/amd/amdgpu/mxgpu_vi.c
> index 59f53c743362..14a065516ae4 100644
> --- a/drivers/gpu/drm/amd/amdgpu/mxgpu_vi.c
> +++ b/drivers/gpu/drm/amd/amdgpu/mxgpu_vi.c
> @@ -560,7 +560,7 @@ static int xgpu_vi_mailbox_rcv_irq(struct amdgpu_device *adev,
>  		r = xgpu_vi_mailbox_rcv_msg(adev, IDH_FLR_NOTIFICATION);
>  
>  		/* only handle FLR_NOTIFY now */
> -		if (!r && !amdgpu_in_reset(adev))
> +		if (!r)
>  			WARN_ONCE(!amdgpu_reset_domain_schedule(adev->reset_domain,
>  								&adev->virt.flr_work),
>  				  "Failed to queue work! at %s",
