Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 832BCC87FCB
	for <amd-gfx@archiver.kernel.org>; Fri,  8 Aug 2025 20:57:46 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 068D510E98A;
	Fri,  8 Aug 2025 20:57:46 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="1eFTu3XM";
	dkim-atps=neutral
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2047.outbound.protection.outlook.com [40.107.93.47])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1A62810E98A
 for <amd-gfx@lists.freedesktop.org>; Fri,  8 Aug 2025 20:57:45 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qNu1HAY6DX/8ySYRHmDywB7VnYN8S7Eiz/K9mPdmh1kO845QCzVUceMCoLl++zu1Oq7cneBywb8hsfp85f3XTMJTo5Verpqojz3maF4UxuIaolSnAl4d7BVqeVjj8vGFG06t4g7BgmvXuZ7s/gLbuw/I7lRZEPxPLJkEykzDvuxOvyzjiyDuv1OdaJLI2oBdcUXeNnWd1HwtmXWuHrR2cumkD4AIPuWLeqx0pvHNXm8tp1EDWmtPIiWntThxfne9aHmJZl0umAbqlrLapPdU3+ufHPmj43vCGn/vCl8jCnBopzyY2JxspxejedbiNuGE0NZtS2yiolc1cMxL4BAR1A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zO1dllf6O+6o93oXYZpYIyK8iJq+0VvvfV8e5lTw7yc=;
 b=K6h+JRUB+dMRRtfQ6vBdFp9tFxgMOuQizjQQjmgFn3aSiCmbXIA0n0HPL7vLsHMK5pMlQ6h/cx+CyGkX9l6StRYtn+RfWjwkJFPYVXutXF40vEudPtCz/WHSEBqsM4RgVR4/wMD541QehgzjSuv7dQpkGslCDCiqRFT6ZQUlaFnbpdA8bySX/aPVbVqDNOFG81PemwEDZpCuB9ZpKPd0LvmJ6YcEuSDAzEOy92QGuOz3kh4z8N1fUMbsFDT8FSO6zkdfDoqYxE0z/TkrYP37b+lOmzUSQEMkWGvw6EjSQnyNkLDIh/MqxN5sk2qggwS8SAN8ZvpQn0ae41mq6NeJ2w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zO1dllf6O+6o93oXYZpYIyK8iJq+0VvvfV8e5lTw7yc=;
 b=1eFTu3XMn5FR/y0ZHzO9Z/jqYGpErQXpJI4ScO4xuPuXgkCiHFxq3vP90AnyVGm0lImtlJiUZm9ot/ivCLMDujmzOZhe/EyBEg/nQDFVgRcvr19Qo00HMcFji2zKUHl+Fybuk2ocefr4cXLOR4Wlx1TDQPOKaLPtBd7iqmgewFw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN9PR12MB5115.namprd12.prod.outlook.com (2603:10b6:408:118::14)
 by CY5PR12MB6647.namprd12.prod.outlook.com (2603:10b6:930:40::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9009.18; Fri, 8 Aug
 2025 20:57:41 +0000
Received: from BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::9269:317f:e85:cf81]) by BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::9269:317f:e85:cf81%4]) with mapi id 15.20.8989.020; Fri, 8 Aug 2025
 20:57:41 +0000
Message-ID: <6ab3cd99-7317-4811-a1c4-a51e186c4289@amd.com>
Date: Fri, 8 Aug 2025 16:57:38 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amdkfd: Handle lack of READ permissions in SVM mapping
To: Kent Russell <kent.russell@amd.com>, amd-gfx@lists.freedesktop.org
References: <20250808202820.187372-1-kent.russell@amd.com>
Content-Language: en-US
From: Felix Kuehling <felix.kuehling@amd.com>
Organization: AMD Inc.
In-Reply-To: <20250808202820.187372-1-kent.russell@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: QB1P288CA0027.CANP288.PROD.OUTLOOK.COM
 (2603:10b6:c00:2d::40) To BN9PR12MB5115.namprd12.prod.outlook.com
 (2603:10b6:408:118::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN9PR12MB5115:EE_|CY5PR12MB6647:EE_
X-MS-Office365-Filtering-Correlation-Id: e44900b4-dcdd-4c86-bbdd-08ddd6be3726
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?aC81OUdHR1NKS0g5NHk0Y3lySjlQWEdSa0hkTkJpaG15MUcxdXNSSEdJbzNJ?=
 =?utf-8?B?Uml2T0JXQkRDUmxJcWtrYTB1MitpRjZQaW9WOVJRQXEzeTFOY3JWanJ1N1Fj?=
 =?utf-8?B?Y25QYmtFWHArZ0JidjZkWVdpb1JUbFR5WGhXeE1XL0tyUWpHaEJVcHgxYk9N?=
 =?utf-8?B?SkIxZG96SlgyaDNXY3hBaUh6dzJKUmdkanNoUTlGNk9RcWlxNHlFSXdGZ0lU?=
 =?utf-8?B?L2NvNlRMYnJJdVczbTBsL0FWL2Rpa0ZPOFhFb05kRWZCd1hUY0tLSVM3L285?=
 =?utf-8?B?T1Uza3JGbjB3cHVrT0dVUmlCQ3ZKS21BVVNhbGZFNllZU2ROS29ad1o4UzJK?=
 =?utf-8?B?TStKN3pQekJ6R2gvV3AyNEsyY0hPWEgyOXhGMThKTVI0SG1kQkJWL1JHZWxM?=
 =?utf-8?B?QnY5RWt0NEFXVlV2UHNBbmVaV0ZSZEFWUUlKWGhXSEw1RnRKK09OcTNHbTdw?=
 =?utf-8?B?d2V2bkVIb3NQNnFXQThCSnlCZVRYdkJJOU5Wd2hlMEs4YXdrMm9PY2p1R2Iw?=
 =?utf-8?B?ZUVjU1BabjJtL25HQjVoUXQrUjVsalVkR1FtdTRvZnhqZGVDRHc3eWcrOHdM?=
 =?utf-8?B?dmN3MUVsNzBvZnNjZU5hSUlVVHNuUEtDb0xRc2RiWTJ6bHhXZ1AzZU1jT3dM?=
 =?utf-8?B?MnhIWitjOGpqVnFLaFB3TmFocUp3Q3FtSTRhOFFMdXF6RFFYQXBteEdXTFdj?=
 =?utf-8?B?ZnVhUEthcGlqdURZbHVHS1VDZ2d5cHdjZk9seW5PWTE1eS91bEtIa25EOUJU?=
 =?utf-8?B?YXFqU29wblRpbjFtWE9sUmVIbEJ6THdqM1BiT1Q4V01mV3BFeE5lY2RJc2F1?=
 =?utf-8?B?RHBNRC8zcEZUTXJkbGhUb1UxRk5tNFk4UjVNUUxXQXlMMzhwS3JKblc1cDFC?=
 =?utf-8?B?VXQ0VUxXQlE5Q0NEMVRoNXU3SERHdGkrMzZPbXZzV3NVQmJQUXIyQzhrRWFh?=
 =?utf-8?B?cXQ3dlBmY3pITGp2UmlaSjNNOHljNlZlRG1QVzByR09RQXRnSXhsMmprZ0RR?=
 =?utf-8?B?Qm9aek8zYkJheEk4Y3ltQWxzcTRVcFNHUExXVWprcUFRR1RsMFc1VTRhaEFI?=
 =?utf-8?B?ZWVsSU1MZW50Sm90dUUzNitpWkd2TTJnalBYQnRsOWE5SWRYb0EvWkNLZG13?=
 =?utf-8?B?M0hmSExCdjlJV0dFd2tTblBnbEtiNEEvY0RUTVRxOERIU1dWalBJcUh5UEVy?=
 =?utf-8?B?QTFNZVl3bG1tSFZ0QkVkREhub0RtVVA4RkFUbmZLcGxTYUVDd1dUc0hjMWVZ?=
 =?utf-8?B?MHF5UXZGUDkwZEZuV1dZOUdxUGJLQWpCRm5id1dyM0NFdlVpYVNwb0lwQkNl?=
 =?utf-8?B?aDc5dThWajI5dXFqd09PYVJtY0ttSys3cEFnNTh1eTlTcmIyNWRuQXRtNXZU?=
 =?utf-8?B?OHBEMEVCVm9IeEJScktmWTV6Z3d2MDNTcU9MNmJhbEZ2N2NIYTBRcGVJakdz?=
 =?utf-8?B?S0tJTENCSFJLeVJCVWE3d1BSV043K1JSa1F5b2tBTnl1dVFIblpVQzNZSWJT?=
 =?utf-8?B?RDJWcjFDK2ZtR3NiS1k3MUFtS0lrWURlamRaTE5FQUhVUFRsMnFDM1R6aW1t?=
 =?utf-8?B?ZGxqTENkOG5kN3VYSkdVNXM1V1BjNXB1cDVKM2lFdWdaczRlNEdGU0diUGZG?=
 =?utf-8?B?c2JrL1VReUY3UzJoT283WkVZWFVxdHVuanBTZWdsMktLeU9EOEZ1UW56dG55?=
 =?utf-8?B?RXZ1bHk2Um5LUm91bmJhNzJLSjdpZHlqdDNwZzh2bEx4OEtYRHl0N2h1TGxP?=
 =?utf-8?B?dE51UGN2b1luWGZabXlta0lLTW56UkxKTkhzc2gza01nN1VZVlBXR1pFRXdT?=
 =?utf-8?B?bWtpL3dwczRaMlNBSExPU0NJTVp3RGZIMVZrcHhjTzY1cjY1eldlQk55UU81?=
 =?utf-8?B?Ri9Ick0wemo2Uk94NEJIMDVpN0FsdUljc2U4YjAwNUJ2VXMxb2NlMnhlQlFp?=
 =?utf-8?Q?FS+CiQR49PA=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5115.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?b29PM2hINjNDb2NHSzlHSThmS1Z6MDJBK3NsbTl2RVlGeVZueHBzdzBNbVBi?=
 =?utf-8?B?OW5kZHRJY1VSbFVLM1A3M2gybzh4eFZva1FiaHh1N2Y3V0RDS1Y2TlpsblRM?=
 =?utf-8?B?VVNaTW1GRnA5amZ1Nnl3VkpVaERsN3o5cElMSCtxaVNQZXg5bkx2QzMyMlgv?=
 =?utf-8?B?U2JPQnYxdlkzRkxPYXRneE96N2xoWXUwQkFxK0N1UzdvcCtLVThSVVdEOG9s?=
 =?utf-8?B?TkFlL0RUQlpWeXJ5K3J3VFU2bHVXVldaUzNldll6WjlPK3dpLzJybzNWNUxM?=
 =?utf-8?B?akV4K1E3bHB1R2VwbmdXRWJ0MWczdTdNTG9NWmp1a1BkK1hWeEJ1SEdGTDlj?=
 =?utf-8?B?MkYxTmZVSVhlZWNBRG1lc0Y2d0g4Nm1SbENCaDYxVm1qZ3VESEhScDJQQmJa?=
 =?utf-8?B?YmdKc0MyZUZFTFpCVGxQMDUzTUEra1RFaHlHVFZjK3kyeGkzZXVYQUx6RTRQ?=
 =?utf-8?B?Qmw0bWxtelQranhLZFNLL0o0anBTanF5MVIvT2haeHV4RkU0T295NFVBcDhr?=
 =?utf-8?B?T0ljK0syMzMzRmt0bGMrekRCK2NId08vL2gyTlc3Yk1IbVlOMTJ0L1N0eGlm?=
 =?utf-8?B?OFR1VlQxaDdsOTdOYzg2L1RpR0ZyK3F3aVlMY0tKNitZYm5ZaDVzUGZselBx?=
 =?utf-8?B?akVGMGJleXBvNEJqT1FBYXRqUGs1RUF2dE44ejA2bkowY3VXZzI3UnY4WmUr?=
 =?utf-8?B?SU1kUEs1eGhxeEUzZ2RLUFhJeGU2YjhLMXE0ZzlJbGl2a0hrMThCWml3anF2?=
 =?utf-8?B?b2FpWjdvaVZTaDhTU1pPSWlSSnZUQW02cU9IbnVEQ3lzZjBhYjJYTmxoK1RZ?=
 =?utf-8?B?eFFYOU1oVi9ENFUxVUN1WXJEMWNjQkFic0pqNW10ekhyMTY4bkMwUk1mZGdK?=
 =?utf-8?B?OU5XNEtsenFhSFFzR2JhTS9SaFFKZEhNRTFteFpGeW9nR2x3OFJIM1l3NDZP?=
 =?utf-8?B?ZUMrS01QcDN4MUcyUkp3RGpJZndsTEErTTlFRzRXMzVpTFRHOG9vSHdockxl?=
 =?utf-8?B?WEFhZHFqR2lscUdLYWI2SG50YjFGbHc5UFZQSDZLL3hjK01lQTA2YkhKUFpE?=
 =?utf-8?B?dDljVUJCK0lrdkFEcnpRUGdHMEd5Qi81N2ZJNDNnRjR3L1Z5dy9UZXQ1L0ps?=
 =?utf-8?B?WERhMDdJYytJRDF0WU55YldZRGVJSUk3OGUxRWx4cDBUS2xGbDFoS0dCc0hB?=
 =?utf-8?B?OVhTemNoQkNCNzVOZUd5cXFsWjFJQlZ1YjgwbDkvSkFPRDlQeE9yU245clZF?=
 =?utf-8?B?L2dNLytuRXcyVy9kOFp5U1BMN00xZzYydUhVbStJWFpiU21VT29lRzRCNEFy?=
 =?utf-8?B?em5QdzhmWkZqSnB5YlpPNUtBTnZMUTBTS1FjK2RzQWFUUGZ5TCtodXc2eWs0?=
 =?utf-8?B?VU42bjlQTDFFNDl5V0h3OVIzRmlnMXEwNDJWc3RpbktjT2NWNFg5MHNPM1ZW?=
 =?utf-8?B?K0ZMa1FCSklXaXQ5dGVadkVoK0RoR0R2NEtXUzZWYmxINHRsZjdpTEtsQURy?=
 =?utf-8?B?RENNSkhBci9ETWdXczI5SkJvNFZmRTEydVVjNlBIbnQ3WDhROGxzaW1Manlw?=
 =?utf-8?B?OUxMcHJHL0VlVFRTVmxKV2V3djY0eHBJanpHSmVRUmF4TldQTlVlS3NUOXp3?=
 =?utf-8?B?ckdjbmovZldWTjdiQkh3WTl0TWdDdVlXczFsOHVLT3M5OHBoUXRmMTlYL21h?=
 =?utf-8?B?UXVhNWp1Nmg2bUpSL3lVSjRuNXQ1VExPSTdRbzA4Z01ISEs2clJZMFZDYjNz?=
 =?utf-8?B?MnVMWnljZENxVzFLenN5WDJjTVhuRlBXbmxXWHBQd0FYaEc3UWlwd1k5dVow?=
 =?utf-8?B?c1E2WE9ibjYwWVdiUjlLQW5TN2ZQTzdwNGNGYkpFQ2pjcjRoL3pYdVNRVXZE?=
 =?utf-8?B?bzhPVkIzWk9pQ0ZMbWw3dm9JRjI1RnVYTDZzY2tZdEw4Q0thd3NOMmNMRllF?=
 =?utf-8?B?MlAwU3k3S3VEZGFDMzNFeWdaT1QyZUFZMHkrVXVSY1Bzdk03RnJwdnVnV0xT?=
 =?utf-8?B?TStvS1RLdktmZTZBWnlFNVB5R29mMTJ2dVVTVnh5SytaSVpKZVlmZ3R3QWRw?=
 =?utf-8?B?Nk4vaVlFdk1RSUFtRUNrcmJHcXp3N29lWkpNcDBNbE1mcUsvWlRVOGY5dzg4?=
 =?utf-8?Q?bn7ALREJcegH/AIxdF3JAJ4CM?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e44900b4-dcdd-4c86-bbdd-08ddd6be3726
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5115.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Aug 2025 20:57:41.5226 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yfkq3bG67Xx2qSxuBfvVN1i5dxy0PIYTBT2snbmmcV4ylVI/DDQrSYYTvRBuVSb2Uq1ommavnbjfUKLlrRgaGg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6647
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

On 2025-08-08 16:28, Kent Russell wrote:
> HMM assumes that pages have READ permissions by default. Inside
> svm_range_validate_and_map, we add READ permissions then add WRITE
> permissions if the VMA isn't read-only. This will conflict with regions
> that only have PROT_WRITE or have PROT_NONE. When that happens,
> svm_range_restore_work will continue to retry, silently, giving the
> impression of a hang if pr_debug isn't enabled to show the retries..
>
> If pages don't have READ permissions, simply unmap them and continue. If
> they weren't mapped in the first place, this would be a no-op. Since x86
> doesn't support write-only, and PROT_NONE doesn't allow reads or writes
> anyways, this will allow the svm range validation to continue without
> getting stuck in a loop forever on mappings we can't use with HMM.
>
> Signed-off-by: Kent Russell <kent.russell@amd.com>

Reviewed-by: Felix Kuehling <felix.kuehling@amd.com>


> ---
>   drivers/gpu/drm/amd/amdkfd/kfd_svm.c | 23 +++++++++++++++++++++++
>   1 file changed, 23 insertions(+)
>
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
> index e23b5a0f31f2..521c14c7a789 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
> @@ -1713,6 +1713,29 @@ static int svm_range_validate_and_map(struct mm_struct *mm,
>   
>   			next = min(vma->vm_end, end);
>   			npages = (next - addr) >> PAGE_SHIFT;
> +			/* HMM requires at least READ permissions. If provided with PROT_NONE,
> +			 * unmap the memory. If it's not already mapped, this is a no-op
> +			 * If PROT_WRITE is provided without READ, warn first then unmap
> +			 */
> +			if (!(vma->vm_flags & VM_READ)) {
> +				unsigned long e, s;
> +
> +				svm_range_lock(prange);
> +				if (vma->vm_flags & VM_WRITE)
> +					pr_debug("VM_WRITE without VM_READ is not supported");
> +				s = max(start, prange->start);
> +				e = min(end, prange->last);
> +				if (e >= s)
> +					r = svm_range_unmap_from_gpus(prange, s, e,
> +						       KFD_SVM_UNMAP_TRIGGER_UNMAP_FROM_CPU);
> +				svm_range_unlock(prange);
> +				/* If unmap returns non-zero, we'll bail on the next for loop
> +				 * iteration, so just leave r and continue
> +				 */
> +				addr = next;
> +				continue;
> +			}
> +
>   			WRITE_ONCE(p->svms.faulting_task, current);
>   			r = amdgpu_hmm_range_get_pages(&prange->notifier, addr, npages,
>   						       readonly, owner, NULL,
