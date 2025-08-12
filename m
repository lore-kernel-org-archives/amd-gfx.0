Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 18B7BCA0EC4
	for <amd-gfx@archiver.kernel.org>; Tue, 12 Aug 2025 05:38:42 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 77A1410E325;
	Tue, 12 Aug 2025 05:38:41 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="sWBCOL7n";
	dkim-atps=neutral
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2084.outbound.protection.outlook.com [40.107.94.84])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CE66D10E325
 for <amd-gfx@lists.freedesktop.org>; Tue, 12 Aug 2025 05:38:39 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sqXhvgcTK9n3R15N2Bz7KhXqynSL8qH+NAabXNd7G5Z15j1NGqw5DZKI2rgkX2sd0K8IMOLMPqfIcJonKI/yulEY7NpdRBhTx/fS1ejuh+AxXTEOz5lgoYDZhsMrpsah3i1RUwlmu1K7Y+XWl7mI2uOFYFaB0Vm8kGP+SoXewq1DDKryB7m61zcMSV30JnD6DX3mMYptJE9Gm2MWg05vV0ytE8azJDXBA5k900Q666vj2VZdIVsL+APo0I/xWnylqDkoshOaqeoMh0L3V5kfoLlcr6Cj19cnrJW82Oz9JMlk0CfQgW3COwKDj2pvs6vLsNDbyYAfmHgcOEBvdC75tA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=z7jY4pyboCEKFh+7YE1P729fJt2LWtHer8bY2p7A+GE=;
 b=LXjh+s7z72XEwPEvAqTeGhfLPycWuggGkwvysAdh9Cv0O3oXH6B7C1wGu5Ks0um2IKOQ7x3C8QaITSfUQZwWZpTmlyn6SSVm9yy58dus6zPXmtUEoEQ2lO6/27zfpWbYptEf+IAUTL83t0ytSHpRyWxSNvJ9KMU86JVNmb9LyGoY+LhbiLT9vJGfIVAyyKzMphbUMrGjJZanfc00vDd+lTQM2J3mbKYDxaQn60K1z2QgDLRtLWFLJRG0Q1RgSa0mQhs58alEIsa/IwMu17mTbUCWLpi3OU0Xuil+vBh0zpOnZYEI6P2dN2tAAXgAYym1VXLnYOYoc4YhtjrdIugLpw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=z7jY4pyboCEKFh+7YE1P729fJt2LWtHer8bY2p7A+GE=;
 b=sWBCOL7nBpFq/9YIVTkRqn+f4i4RsvUP1pfZjYX8hnvA45LoKP97tuyLHsA4XIsJktUiwXDpQmfeiAMNStSsTjnp8EI6a90o/fKEfmO5IDBQskqhN46VqSMNcAiaHekauDsHcDBQZ449GGglNh7rDlA6O0Zi0p/cQETqiNmiCzU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS0PR12MB7804.namprd12.prod.outlook.com (2603:10b6:8:142::5) by
 PH7PR12MB8121.namprd12.prod.outlook.com (2603:10b6:510:2b5::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9031.13; Tue, 12 Aug
 2025 05:38:36 +0000
Received: from DS0PR12MB7804.namprd12.prod.outlook.com
 ([fe80::8327:d71a:ce21:a290]) by DS0PR12MB7804.namprd12.prod.outlook.com
 ([fe80::8327:d71a:ce21:a290%4]) with mapi id 15.20.9009.017; Tue, 12 Aug 2025
 05:38:35 +0000
Message-ID: <80fc509b-be10-4080-8501-8e210587b774@amd.com>
Date: Tue, 12 Aug 2025 11:08:29 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [v3 1/2] drm/amd/pm: Add VCN reset support detection for SMU
 v13.0.6
To: "Jesse.Zhang" <Jesse.Zhang@amd.com>, amd-gfx@lists.freedesktop.org
Cc: Alexander.Deucher@amd.com, Christian Koenig <christian.koenig@amd.com>,
 Ruili Ji <ruiliji2@amd.com>
References: <20250812010345.2261810-1-Jesse.Zhang@amd.com>
Content-Language: en-US
From: "Lazar, Lijo" <lijo.lazar@amd.com>
In-Reply-To: <20250812010345.2261810-1-Jesse.Zhang@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN4P287CA0106.INDP287.PROD.OUTLOOK.COM
 (2603:1096:c01:276::6) To DS0PR12MB7804.namprd12.prod.outlook.com
 (2603:10b6:8:142::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB7804:EE_|PH7PR12MB8121:EE_
X-MS-Office365-Filtering-Correlation-Id: 64d01f29-8476-4238-a954-08ddd9627b08
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?MSsyakpWRG8rLzJoRWlvRU9od2NSSmFlWW9obVNLRzdkcmx5Zk1jL2lzbU41?=
 =?utf-8?B?R1lLTzEvcVRsRldFZlVIVTFkUFFTeFZKcGQ3MEkyLzJDN1hhSzduZmErMUo0?=
 =?utf-8?B?dVBOb0wzK3MyRmRjbFJya21ra291K2c1K3FrbVRpalE1QVRmZENQMGV6YUFD?=
 =?utf-8?B?NUpsTUVxaHo5NmNESi9YcEgwank0WDhtVVJxYVQ2a2MxYUxIR2o5MHpzcWJO?=
 =?utf-8?B?Y0pMcTVlODJySlBKQnZIdWVIbUx2c1VPVlJrYVIyeUNiVFdVU2UwMU1zbHda?=
 =?utf-8?B?RXEzQkMxVHk2aWwyWlBFZWJSS1owdk9sbkRhWWVxL0ZNYlZHTyt3S2lBTlYy?=
 =?utf-8?B?T09zaEdGQTVKdm5qakJmQUZzbndDWHoyT0kvSWxHZlZiKzJBV3dLbVVNRVVK?=
 =?utf-8?B?MElYcklUSUZYTmw2bkRDVTF5TWowRXRPQ1lLSGE4NjM1LytBamdPTlEwdElU?=
 =?utf-8?B?UW9NYmkybkhMckpLOGFkeG9ucnR4Tm9UbWZXTTM2dlNLZUhvWTkzUjlQWGJM?=
 =?utf-8?B?MDI4U0pkWTdsWjBVMm94Y25scnM3QW0wSGIwODN4cVJGTmhtTldUQ3l6RnVk?=
 =?utf-8?B?eGNZby9CZ09lckFyM093OXVHcnFBTUtHcXZITUV1ZUxyVWFMMkY3cStKNDNS?=
 =?utf-8?B?YXdEV0JUaWJoN3d5YkJzMENQNlVrd0VJOGovTGxDR29FbVI5OTdKZEVQR3dW?=
 =?utf-8?B?QWdndlpPWnhDK21SWHBVZC8yeFZseUN4VVdTYkZGY0Z4MjNHVjM4M1BuWTJn?=
 =?utf-8?B?dDNsV1ZkOW1BYVlEZ0RVMyt1bXdxcGxPZ21oNXJHTGZ5Ti9pRHBkZGFOY2w2?=
 =?utf-8?B?ZExvZHZpQ2poZHlZU1cxZEh6L2lhTnFUNzdkT3VlaU1UeEgxbjI3VGd3Y0NL?=
 =?utf-8?B?T1JFWlUrRldac3lRaitBenEyeUFWZ09PTkkvQ00wQzZSbWZYcXVTZWx5bVRU?=
 =?utf-8?B?K2xKTC9vTkdLL2RSOE5ERk4rdTRnVGp4bzBxSm9KL01TS3VscWRPdkV6eFJv?=
 =?utf-8?B?cmtBL3JGZU8wNmd5SUpXeXRIN2cxN05ERDJVclVhSlNNK2lSVFZ2eDlZWGZt?=
 =?utf-8?B?cW1GdVhvVEJnSC9SWkJkNjliR2lhWXRxWlhGMHdjOFhmQzU0UitSZlVKWGhP?=
 =?utf-8?B?eW1kL2FVbVNyOTV5ejdMNHZrQk9FczRKc0REcjZyRk04c0w3NHZpeHppc0xO?=
 =?utf-8?B?dStjNFEyR2VucTlwREJOQ2hFc3JtUU1PT1RlZWdVUjh5TnVxUkZFY1Q0UGYr?=
 =?utf-8?B?MmJNVi95NVY0d1hLNWlwWW40bmIrOXZaRjdyYmRyaVgyZW5rdGRwcU16ZjBQ?=
 =?utf-8?B?cWUxWTVBcGUyTkV0S1NBNlpzZEpIK0ZEUWpObmI1ajR4TlhrNmdxc1FGaVVP?=
 =?utf-8?B?VFpzdERxWWZndFZNODBoUS9tb2NtcmpwZEtwRGNvTkVYcmpCMnFHRXNIMjlu?=
 =?utf-8?B?TEhNdzYyQlhjaUZRRG1rQ0c5RzJ4c1hqaXFWMFNZTkh0S0lIa2ZPa0wxaTg4?=
 =?utf-8?B?YUZma2RVNDg5RlM1RVdRdGY2OG9ZV3BmcTErM29EQ2tiaEJ5bElENDM5QWZD?=
 =?utf-8?B?cXBJMkVoNEdOd3MrN2lmd2VWQ1ZXVU5VeWRPVG10OS9Zb29vT2k0SjFLdHRO?=
 =?utf-8?B?N1BSY0RLazBIRm5JSWpGR3IwMUFuL2xuSW1jV2ZUeEg5QzROVW5MZ0IyT2I4?=
 =?utf-8?B?TUNTTytYMjRGTWF5akZISGxxQ2xXTUo5d2NmcUtpY1BFOTZJcmxiVUFza1Aw?=
 =?utf-8?B?YmJOeGVSYmZYVUY3QkVyQjdhSWw1Ry9iOCtmTUNwZlZIZmNOenhMeFlkYWFC?=
 =?utf-8?B?UjZuaklkZHJsampDUkw3bXhKMVdGRTMxMXAzSDcwME1GUnRWQklRTE5pT2Nl?=
 =?utf-8?B?OHA0M21vcHRRNlUrVmF2VnY2S0hoQUREU1FlOGJ0djNnMFZLb0pneFdrSncx?=
 =?utf-8?Q?m+WE4417BW4=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR12MB7804.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TFFlTVJmWFA5SUVTUy9GRnNtNUljK1lra0V1cm1EU3RhUnluSDJpV042dzR0?=
 =?utf-8?B?Vk5VdVpLWXl3R2RUL3BNdmNnR3JXTmdvejZRY3Erd2wvV3NiVkVhM2tkNGJT?=
 =?utf-8?B?NFRVNXJVQ2N0YlpHeU15VDgxTWxscE9hTndmbnB2QWJZb2Nib2Vqc3hPYWZ0?=
 =?utf-8?B?RXZIbEVRYUZidVQvNkFHYkJ3ckt3cklQU0s1WUE1VVdsSUp2eTJWVXFpdzR5?=
 =?utf-8?B?OWdrcTJoR3VUT3V0VXlQQ1pVMnFPNXNLS1RsSU5xVHJTQnVoTkcraDBRSmVw?=
 =?utf-8?B?eERXdzErR0dPYVBaSE90YkY4TmY0cEQrdnVUZ1c1Y2RtN1ZJRXRHVmdYWVI3?=
 =?utf-8?B?NmhmNzA3RFI0eVpvWHBkbGEwOEgyVUovL0F1ck9pVS91eTByVGgvTCtYT0ty?=
 =?utf-8?B?dHo4anV4L3IxNExDSHdJZjFKdkhNYmoxajh2MzN6RUVqQWZ2TnlWOUE0cXVD?=
 =?utf-8?B?NjRSNC80ZWo2ZFIxNmFLeVdweDI0RnRXMGdvZktCOU5WbVBzdGtxQUpZdGt1?=
 =?utf-8?B?bUsxRElrRitrelVkT2NRTEErcVIwSEUrbzVwQThLbmE5Uk9iZHQyTk9HbVFq?=
 =?utf-8?B?R2ExWE5hYzR6RTVYbmhHMDhWMFJZOEZ4cnIzbGNPVHhDZXZ2MnFtZzFJZmM4?=
 =?utf-8?B?QUsyVWZReDZlVmxUcVhMSyt1aHA1Q0xEVi9icUxUWVkzOFJjZTBPUUlXc2lC?=
 =?utf-8?B?WENMOFVXNjQxZzAxU2pZd2V3RlRhRDV3dk5lbWNrWDNZcFczSjY4dzR4bzR0?=
 =?utf-8?B?enl5YlBCNUNXTUNwcUxnZXVkd3p6L01HaGk5MWVvZ3NOSy9nbzBuMlRVM1Zx?=
 =?utf-8?B?UWZXdjdaZXREcWI2SXdKTElMRjFiZG03MVgyakRjVWt6RG9jZXR6cVdVYUVs?=
 =?utf-8?B?Zm0zb3VyM0o0WldWQml1YzB5dFI1V01naytrQkNGb1FzYWxoODVpMHRLU2hu?=
 =?utf-8?B?R2h4M05iMFRzaTdrNHZ3bUhYOEpWV2JObEgzUFYwZDdXUzN1TXVKNlRIWFZW?=
 =?utf-8?B?TUdPK3hmNHpHUGpVeTNFYTZRMys4ajY1djJxWDljeVZQQnB1dUJrUVNDbysr?=
 =?utf-8?B?U3prbWxFelQ4dVNUOTVWc294VW5VcjZ1VVd0a25idlFWK3pnWDhFeHNZWFRT?=
 =?utf-8?B?VGt5TmJDUzdzT0pLVXAzTTM5KzBpekpRcU1kd2l2NCtNbGVVbzRkbUM1OWdM?=
 =?utf-8?B?bHJiWGNWbnJNa2FNMXBqRTluaU8yNVd0OURPSGZPdElaaDY0VWVrNS92dDJH?=
 =?utf-8?B?S0JaYm9Ja0FvTW5BaStOWXF2NDFZR0t1Y2F2dzZoYnJvaTd0Mi8rbWpzbzl2?=
 =?utf-8?B?QUVROHJqdXVtYkZ4eUxXdnRrRjdoRFZlRnlHbHMvTnZRUVJtNmJ4U3h4SEVq?=
 =?utf-8?B?b0dKVWNiVnRVYjdodHlCTUZxTlZ4Vlk2THhUaVM0MEoxdk5zeS92UFBETnRY?=
 =?utf-8?B?SHluQityK2dkR3pOait2RGgxM2RaNlM1R21YNmlVVzdwQ3B5ZDZqODNmRXVW?=
 =?utf-8?B?NGxBY25xLytDU09IdkFGZGFYQm10UDdBeVlqdW0vWXdVWXQ2VGRZbStJeFVu?=
 =?utf-8?B?WVpBVi90S3BaS0pMMzdvWTFjdFU5VVA2dnMxclFUdnoxZGQxeER5bnJjblFL?=
 =?utf-8?B?elJUa3JnZE16NU00dVh6NnJ0THFyYWZpVlhBUUxZSkVkRnVKT3oyMW0wbFJG?=
 =?utf-8?B?WGRqVVN6WnZ4NVREK2VuKytEWitqSS9mNHQ4enNFK3VxNHZEZ3dGbzdWalFS?=
 =?utf-8?B?NWZOeGZwWm5KelJGUkdKZWpwU043bHRhS3NhaWloWkxoZEsyc1RnN0x6dUN0?=
 =?utf-8?B?ZHpzOVJKbEJ2RE4wRVhXR1VERlBkaUk1R0tqOUp4ZlJnMFZEa2NtV0lNSjdz?=
 =?utf-8?B?YXlIK0hUaFB5NEtIakxCTWRWRExTN2ZXdmdCNlVGcitweHp1QkJ6ZXY2NnM2?=
 =?utf-8?B?SFhlOWtjV25McVJ1WTdHc3RsQ1dzaE0vd1h2UitqeGJ4Nis2UUFHaVk1dHdQ?=
 =?utf-8?B?MUxmeWxTTllCVGhWZG9QOTBia0t5ZE14b242N0d0YlIvekNnRkJRbDd2NUFZ?=
 =?utf-8?B?bTNuWlhsb0NSdjdQNlhqM2ZxT1RlenhrUlZJWU5zNWxOcDFwL2NndnF6UnZw?=
 =?utf-8?Q?g/rCMrqxCsGKKq9dC1jusib/b?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 64d01f29-8476-4238-a954-08ddd9627b08
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB7804.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Aug 2025 05:38:35.6496 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: piBw3S2eLhctUpCe5CLfUmKETKSch4ynVwEQ1nmBWf9Oe8rE0O1v/KzLcYXzgkrG
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB8121
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



On 8/12/2025 6:33 AM, Jesse.Zhang wrote:
> This commit introduces support for detecting VCN reset capability through
> the SMU interface. Key changes include:
> 
> 1. Added amdgpu_dpm_reset_vcn_is_supported() interface to check VCN reset support
> 2. Implemented SMU backend functions for VCN reset capability detection
> 3. Added SMU_CAP(VCN_RESET) capability flag for SMU v13.0.6
> 4. Updated PPSMC message definitions to accommodate VCN reset functionality
> 5. Added version checks for VCN reset support (fw_ver >= 0x04557100)
> 
> The changes maintain backward compatibility while enabling proper detection
> of VCN reset capabilities when supported by the firmware.
> 
> v2: clean up debug info and adjust this message to be more meaningful (Alex)
> 
> Suggested-by: Alex Deucher <alexander.deucher@amd.com>
> Signed-off-by: Ruili Ji <ruiliji2@amd.com>
> Signed-off-by: Jesse Zhang <Jesse.Zhang@amd.com>
> ---
>  drivers/gpu/drm/amd/pm/amdgpu_dpm.c             | 15 +++++++++++++++
>  drivers/gpu/drm/amd/pm/inc/amdgpu_dpm.h         |  1 +
>  drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c       | 10 ++++++++++
>  drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h   |  5 +++++
>  .../pm/swsmu/inc/pmfw_if/smu_v13_0_6_ppsmc.h    |  4 ++--
>  .../drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c    | 17 +++++++++++++++++
>  .../drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.h    |  1 +
>  7 files changed, 51 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/pm/amdgpu_dpm.c b/drivers/gpu/drm/amd/pm/amdgpu_dpm.c
> index 6e0d711820ea..518d07afc7df 100644
> --- a/drivers/gpu/drm/amd/pm/amdgpu_dpm.c
> +++ b/drivers/gpu/drm/amd/pm/amdgpu_dpm.c
> @@ -820,6 +820,21 @@ int amdgpu_dpm_reset_vcn(struct amdgpu_device *adev, uint32_t inst_mask)
>  	return ret;
>  }
>  
> +bool amdgpu_dpm_reset_vcn_is_supported(struct amdgpu_device *adev)
> +{
> +	struct smu_context *smu = adev->powerplay.pp_handle;
> +	bool ret;
> +
> +	if (!is_support_sw_smu(adev))
> +		return false;
> +
> +	mutex_lock(&adev->pm.mutex);
> +	ret = smu_reset_vcn_is_supported(smu);
> +	mutex_unlock(&adev->pm.mutex);
> +
> +	return ret;
> +}
> +
>  int amdgpu_dpm_get_dpm_freq_range(struct amdgpu_device *adev,
>  				  enum pp_clock_type type,
>  				  uint32_t *min,
> diff --git a/drivers/gpu/drm/amd/pm/inc/amdgpu_dpm.h b/drivers/gpu/drm/amd/pm/inc/amdgpu_dpm.h
> index 09962db988d6..9748744133d9 100644
> --- a/drivers/gpu/drm/amd/pm/inc/amdgpu_dpm.h
> +++ b/drivers/gpu/drm/amd/pm/inc/amdgpu_dpm.h
> @@ -615,6 +615,7 @@ ssize_t amdgpu_dpm_get_pm_policy_info(struct amdgpu_device *adev,
>  int amdgpu_dpm_reset_sdma(struct amdgpu_device *adev, uint32_t inst_mask);
>  bool amdgpu_dpm_reset_sdma_is_supported(struct amdgpu_device *adev);
>  int amdgpu_dpm_reset_vcn(struct amdgpu_device *adev, uint32_t inst_mask);
> +bool amdgpu_dpm_reset_vcn_is_supported(struct amdgpu_device *adev);
>  bool amdgpu_dpm_is_temp_metrics_supported(struct amdgpu_device *adev,
>  					  enum smu_temp_metric_type type);
>  
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
> index dc48a1dd8be4..f9a350a82764 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
> +++ b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
> @@ -4106,6 +4106,16 @@ int smu_reset_sdma(struct smu_context *smu, uint32_t inst_mask)
>  	return ret;
>  }
>  
> +bool smu_reset_vcn_is_supported(struct smu_context *smu)
> +{
> +	bool ret = false;
> +
> +	if (smu->ppt_funcs && smu->ppt_funcs->reset_vcn_is_supported)
> +		ret = smu->ppt_funcs->reset_vcn_is_supported(smu);
> +
> +	return ret;
> +}
> +
>  int smu_reset_vcn(struct smu_context *smu, uint32_t inst_mask)
>  {
>  	if (smu->ppt_funcs && smu->ppt_funcs->dpm_reset_vcn)
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h b/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h
> index 611b381b9147..7990771151be 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h
> +++ b/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h
> @@ -1426,6 +1426,10 @@ struct pptable_funcs {
>  	 * @reset_vcn: message SMU to soft reset vcn instance.
>  	 */
>  	int (*dpm_reset_vcn)(struct smu_context *smu, uint32_t inst_mask);
> +	/**
> +	 * @reset_vcn_is_supported: Check if support resets vcn.
> +	 */
> +	bool (*reset_vcn_is_supported)(struct smu_context *smu);
>  
>  	/**
>  	 * @get_ecc_table:  message SMU to get ECC INFO table.
> @@ -1702,6 +1706,7 @@ int smu_send_rma_reason(struct smu_context *smu);
>  int smu_reset_sdma(struct smu_context *smu, uint32_t inst_mask);
>  bool smu_reset_sdma_is_supported(struct smu_context *smu);
>  int smu_reset_vcn(struct smu_context *smu, uint32_t inst_mask);
> +bool smu_reset_vcn_is_supported(struct smu_context *smu);
>  int smu_set_pm_policy(struct smu_context *smu, enum pp_pm_policy p_type,
>  		      int level);
>  ssize_t smu_get_pm_policy_info(struct smu_context *smu,

It's better to split smu v13.0.6 changes to a separate patch.

> diff --git a/drivers/gpu/drm/amd/pm/swsmu/inc/pmfw_if/smu_v13_0_6_ppsmc.h b/drivers/gpu/drm/amd/pm/swsmu/inc/pmfw_if/smu_v13_0_6_ppsmc.h
> index 41f268313613..63a088ef7169 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/inc/pmfw_if/smu_v13_0_6_ppsmc.h
> +++ b/drivers/gpu/drm/amd/pm/swsmu/inc/pmfw_if/smu_v13_0_6_ppsmc.h
> @@ -94,9 +94,9 @@
>  #define PPSMC_MSG_RmaDueToBadPageThreshold          0x43
>  #define PPSMC_MSG_SetThrottlingPolicy               0x44
>  #define PPSMC_MSG_ResetSDMA                         0x4D
> -#define PPSMC_MSG_ResetVCN                          0x4E
>  #define PPSMC_MSG_GetStaticMetricsTable             0x59
> -#define PPSMC_Message_Count                         0x5A
> +#define PPSMC_MSG_ResetVCN                          0x5B
> +#define PPSMC_Message_Count                         0x5C
>  
>  //PPSMC Reset Types for driver msg argument
>  #define PPSMC_RESET_TYPE_DRIVER_MODE_1_RESET        0x1
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
> index 90e66c8f2f82..60aaf0e2ce8f 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
> +++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
> @@ -434,6 +434,9 @@ static void smu_v13_0_6_init_caps(struct smu_context *smu)
>  	    ((pgm == 0) && (fw_ver >= 0x00557900)) ||
>  	    ((pgm == 4) && (fw_ver >= 0x4557000)))
>  		smu_v13_0_6_cap_set(smu, SMU_CAP(SDMA_RESET));
> +
> +	if ((pgm == 4) && (fw_ver >= 0x04557100))
> +		smu_v13_0_6_cap_set(smu, SMU_CAP(VCN_RESET));
>  }
>  
>  static void smu_v13_0_x_init_caps(struct smu_context *smu)
> @@ -3171,6 +3174,19 @@ static int smu_v13_0_6_reset_sdma(struct smu_context *smu, uint32_t inst_mask)
>  	return ret;
>  }
>  
> +static bool smu_v13_0_6_reset_vcn_is_supported(struct smu_context *smu)
> +{
> +	bool ret = true;
> +
> +	if (!smu_v13_0_6_cap_supported(smu, SMU_CAP(VCN_RESET))) {
> +		dev_info(smu->adev->dev,
> +			"SMU VCN reset not supported.  Please update SMU firmware.\n");

This will come for every reset attempt for programs other than 4. Better
restrict this to once, or not to keep it as it requires IFWI update.

Thanks,
Lijo

> +		ret = false;
> +	}
> +
> +	return ret;
> +}
> +
>  static int smu_v13_0_6_reset_vcn(struct smu_context *smu, uint32_t inst_mask)
>  {
>  	int ret = 0;
> @@ -3859,6 +3875,7 @@ static const struct pptable_funcs smu_v13_0_6_ppt_funcs = {
>  	.reset_sdma = smu_v13_0_6_reset_sdma,
>  	.reset_sdma_is_supported = smu_v13_0_6_reset_sdma_is_supported,
>  	.dpm_reset_vcn = smu_v13_0_6_reset_vcn,
> +	.reset_vcn_is_supported = smu_v13_0_6_reset_vcn_is_supported,
>  };
>  
>  void smu_v13_0_6_set_ppt_funcs(struct smu_context *smu)
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.h b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.h
> index ece04ad724fb..7c98f77c429d 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.h
> +++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.h
> @@ -64,6 +64,7 @@ enum smu_v13_0_6_caps {
>  	SMU_CAP(RMA_MSG),
>  	SMU_CAP(ACA_SYND),
>  	SMU_CAP(SDMA_RESET),
> +	SMU_CAP(VCN_RESET),
>  	SMU_CAP(STATIC_METRICS),
>  	SMU_CAP(HST_LIMIT_METRICS),
>  	SMU_CAP(BOARD_VOLTAGE),

