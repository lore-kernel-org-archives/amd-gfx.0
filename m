Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9EC04C87FD3
	for <amd-gfx@archiver.kernel.org>; Fri,  8 Aug 2025 06:59:13 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 265E910E4CD;
	Fri,  8 Aug 2025 06:59:13 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="PDh+m0So";
	dkim-atps=neutral
Received: from NAM02-SN1-obe.outbound.protection.outlook.com
 (mail-sn1nam02on2062.outbound.protection.outlook.com [40.107.96.62])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 61CD710E4CD
 for <amd-gfx@lists.freedesktop.org>; Fri,  8 Aug 2025 06:59:12 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=h5K6r+LSK+YnlSZEfYKiDEaloog/byKsSbhouA9kgwIYcpsqo3xLVmHFJk/L3sEJAhRT3FZyh7RlLLiKev9sn58ZKBAY6nd+pEJECaU/2Buu2pgz1sCnY5K8drMq3Rzds+90rcXh/K/Q6StBIKTXYtto5EhTJ7ZGxd8E47wS8eADe4ynqrRFWN/DUQ3fiutCurS40jWtxDRs91LBWr8OQPoF9DgGMZuYgtfyDV4t0q4+d0EWqRfbQ5F8Tp8xkXj7kHGBcE/xEzmAIrsn6uf6IjNoiwEWxMW0sphNzYUv0ZoljibXmIx7u0KpoFWBGKqi/yk78sfQ3+JTyTpclh/QVA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Al/mTnq7tnvrFYzf9xTKqkcbOJeVykv0a9mF5wRTuXo=;
 b=umRSpQDOtBF0KI/SX42CBc6H/9GbEuG7uN09T6C7K91uv1oSQJ0xNWtFrrP+8ZvGqPzPVNckkoAMOSByT8pDCSLzzMfhuyZOA8eX/veonyBMeYVR0DnYK8/AOD3JgYhRLtvHlxY4cSHOdqwCKtgxGiCPVC23sgRUwy5kXTCzpZpyXshe4o2MxV6IhU3wxIvEU9dG7RinBsvokPbqfohUVwfJ9Z3MFaKIXww1qPyJ3N1oG1Sd8VGUwlSBSGyakPt7+i6NnEfm0XX2R8kVXo3E7cQ0u8SEccHsuivDjqS9EoJpvFADPnIDCYhaKOVgVngjsPY+x1vL98KE5A+boPTaSw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Al/mTnq7tnvrFYzf9xTKqkcbOJeVykv0a9mF5wRTuXo=;
 b=PDh+m0SofmBzOxBlD3aYzLg9Fn0QcHLJ+6WXoWHXkB4B9p7ZzuQNh0jlCMpXzzKGT8dPOzYacb1lFNFkr8PZcxM7MtNUIYPm5JiUGHCv1G57jiLoa46Dd5uWS587yZH9VNw7H7zH2ZceD9aHCOve3br1k/DlAjsQMbrBZWIr6R8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB7820.namprd12.prod.outlook.com (2603:10b6:510:268::8)
 by SJ5PPFCD5E2E1DE.namprd12.prod.outlook.com
 (2603:10b6:a0f:fc02::9a2) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8964.23; Fri, 8 Aug
 2025 06:59:09 +0000
Received: from PH7PR12MB7820.namprd12.prod.outlook.com
 ([fe80::7606:59:8d0d:6d4c]) by PH7PR12MB7820.namprd12.prod.outlook.com
 ([fe80::7606:59:8d0d:6d4c%5]) with mapi id 15.20.8989.017; Fri, 8 Aug 2025
 06:59:09 +0000
Message-ID: <45bded3a-e3c7-421e-8cd9-ec268fca7db7@amd.com>
Date: Fri, 8 Aug 2025 12:29:04 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amdkfd: set uuid for each partition in topology
To: Eric Huang <jinhuieric.huang@amd.com>, amd-gfx@lists.freedesktop.org
References: <20250807204948.286132-1-jinhuieric.huang@amd.com>
Content-Language: en-US
From: "Lazar, Lijo" <lijo.lazar@amd.com>
In-Reply-To: <20250807204948.286132-1-jinhuieric.huang@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN3PR01CA0059.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:99::13) To PH7PR12MB7820.namprd12.prod.outlook.com
 (2603:10b6:510:268::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB7820:EE_|SJ5PPFCD5E2E1DE:EE_
X-MS-Office365-Filtering-Correlation-Id: 454d10ed-14fb-4f96-1e62-08ddd64912b7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?YTdLQ0p3Z0JSaUIwRmNicnN3WGdWcDVSTHQ5Y2FEUHM4R0djQk9wTVRFSG9p?=
 =?utf-8?B?QVNsb1pKVm9CNVFPNjdSOEdadUJ3dGdoYTBpR0NOQ0R4SXFCeldod09aVnps?=
 =?utf-8?B?a0VCVmZ1Y1FwREtNOVU1dVpSVWhUMkh5eXB6TGc2SVBIMitkMkhvVjgwRDZv?=
 =?utf-8?B?M2RzM0ZIaTNiaHYxTmhlNHlnV1RuTzMwZkVGd1VDOEJDK1VOelhlZ3QyUzFI?=
 =?utf-8?B?WnNaZnpXdzkxSXhURVhjdHhDTjVydmlDRitzT20zMnhEMGVXdHRobGxRdHlF?=
 =?utf-8?B?STY3SkYrdDY2TkZvVmZkUkV5SDJmRTFZYXZnT1llQ2lSRzV3NHRBREJMbkJS?=
 =?utf-8?B?WVNCdVhibllabUh1OFNPUWM1bCttb2oyd2tCZHdqS3ExSkJJbzNrbzFuK0Nh?=
 =?utf-8?B?VExkRnZiSGs0V1U2S3ZPcEtWVVZwKzBnbFJ0WTd3OStTaGpNL25GNVcrdndH?=
 =?utf-8?B?N1JRQllWSVRPeFYxSDF1Wit2bTRmR29PbVZWbFUxNmprN2FHVnRselhLekZT?=
 =?utf-8?B?bDFrMlVDSDA5R2JFUTQ5aVkzWUNldXhTUEpYckxpQ293VU9DMkVKMW1RSzZW?=
 =?utf-8?B?NlF6bGhNYU1weVZ5QVd1RzJqQXlkVndiMjJWUnlLOTBRVnZUemRHUzVZVWhx?=
 =?utf-8?B?R2ZpbTB1a0IzczN3Rk5RUGE1MjdrT1g1UzZtWWdhd2dsL2crdmliT0l5NDhX?=
 =?utf-8?B?ZnpvNDRrRzU5UXhCbnM1R2NNdlpmak5EaWZBQVFCM3ZubE52ZTlpR1UzL0pJ?=
 =?utf-8?B?Nm9OTWd2N3JlcTU4VmJKZm5EZ0prc3pNOUU5VjlQM2lhRklkQlRrV2ZpS3JR?=
 =?utf-8?B?TVlabzlSUFlFa0dlMjdNQnY5ZVgrVDBseXFnejl5KzlPUERpTDZ4ME5BeDFC?=
 =?utf-8?B?YVE5R1owZkxtUVBPdmljZE1qcmhUZWhTTGMvM3pjNzdscmRqb2Y4YThtdlR3?=
 =?utf-8?B?TnFNWkVaSjFXOElpSHhMMnh1aFdYckF4dTJsVUY1cXBFWlhxSEhLUjh4aDM3?=
 =?utf-8?B?NnE0STJKQW13bnhJclJlakdRS09nWEt0RmltZ0o1Ym9KQ1FNODNGNHR0U2RM?=
 =?utf-8?B?L2tDZ1ExRlYzbitpQ3RxRFA1Uis5Y3dzSm9qMHRKbjZDbk9UaWxpZUlid29x?=
 =?utf-8?B?RnNxc29RQ2tPYzhzWlBYTUM5UFRQNk1kM2lRYjkwbU9IeEk0KzJNK1IrZDJC?=
 =?utf-8?B?aU9mS0k5V3NzaWdhMXovWXlsVXcySWpoVVFha01GODYzUUdMb0E5dVdsZlRa?=
 =?utf-8?B?QkFzeGU0TEJ3MVl5a0xQOVVDVjd1Wng2OUFPN0VMeTZUYzM2Qk81dFVlRmFq?=
 =?utf-8?B?YldIQmhyNytvRFEvZXFidWJidFMyQkVPSDdzbWVwODY4QnZlUTZJRmxMNSt2?=
 =?utf-8?B?N0F5YktCSlhHanJnVmh5Z3pORVJTeks4eFdpNS9CZmtqaVl5YzEyejFXWDN2?=
 =?utf-8?B?SjRVaUd4Rk5nL3hKTzZrbmJ1ellJZzJtbEs2QVlUVEhVSzEzdTMyL0FOSm1x?=
 =?utf-8?B?YXdHc3VCVG5jVUpuMnVQcVRSL0RxT0NaSjR4V05uR1VVcjFobVBxMzR0NmUx?=
 =?utf-8?B?WkxIOURWRjAyWXRCdWhXQWhwTUhmTEp4ajFpcXUySG1vRzFLSHMwckUzM0N1?=
 =?utf-8?B?VFExWE5CcWtZVTllclQ4bXFnWkFqaUhIbDBYdHV1d0RrTWFEQ2F0N285TVRL?=
 =?utf-8?B?aWc5am1zL3NBTndpUXZpV2xVMEhhMnk1cTRUQWZrQmo4TlhnWFptSklxUldl?=
 =?utf-8?B?UXVMR0ZWaHNxZXhzWkoyQ252aUYrc1dBdEhZYTNjK3NYOTNSMzhOd0FINVhl?=
 =?utf-8?B?WDZaRlhzSFVmU01KTHVvL1dwL2w5RjIrbnNLRXAyaFV0bGhPKzZYR2NaYk8z?=
 =?utf-8?B?MXdtUFVLSHdGejQ5RjBmRUE0VVdzUVcwYUVxSkFYM0pMbDNNajNGUk0vVkta?=
 =?utf-8?Q?CPPxQTeHzpc=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB7820.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?U3BOWG84RSt0UXdIOEkzc2krMy9sWnJSRWc5SXpOV2JrVldZdysxVGZzRWhw?=
 =?utf-8?B?QndsZFhTVXV6VVk4Y1RqdUFGS2xwK2Q1NjkxRktHWW80c2FPdlZKKy8xTWZt?=
 =?utf-8?B?Z1hGN28rWEgvaXJwM1pWNEhhd2EyWmhhZm5mOE5zeW44MWVtM1NiaHdxandW?=
 =?utf-8?B?bHo2cVQ1Uko4MEZ6UFdrbzhhM2R3NW9GOXpVdVFPSTZrMDkwb2hJOUdnU2hM?=
 =?utf-8?B?NnJ2QW0rcS9ja29HbmYrdXRDOEZiTUZhQkEyUWJkQk1XS085UHZhOWVtN2xJ?=
 =?utf-8?B?U0UyR3RiYUlSc0VidERxUUpsWSsyMmFZWVBzd1dsN21HNWlCUEQ3VjdIUFEv?=
 =?utf-8?B?REVscjVPd3RQK2RZcngwMFd4ekRRZ0t1S0J0aHJ3NHZBbENId3doTFA3MkRo?=
 =?utf-8?B?a0NubzR4d0dVWnduTUxZQWwwN3pGOHozTlpLWEFaSEZLbXFHZTJFS1RubTA0?=
 =?utf-8?B?WlV0VGFLSkdicjgvVXhON3hzNnZWSjJSVjhNdTB6YjB2eCtvMER5YXR1V1RG?=
 =?utf-8?B?bm9ZUDhETlBvQ3lCSjVXVGRzdkFzZkhxUWczZW93UXhHd05HeTFJTW4wSkgw?=
 =?utf-8?B?QnkyNE1nODMrSEk0ZnB1YzMxSlAzQjczZU9pQmFLWkRPc3NMcE50cmNzeksy?=
 =?utf-8?B?UHhMZm55TStaZnJxaHVWQTMxU21vb1dkV2NDdDVRSE4ycndoaVRXQzBBOGh2?=
 =?utf-8?B?c2FTb1ZCWVJTdkpKQ2t5M3lnUnVIRTdKUk4vMjNZdVB3V3dKWUM0bDJZbjdU?=
 =?utf-8?B?enNtRS9JNFluVE9CakF2VnNxYXhBZGUzZmhBVEVGbHhERTR5bWNaay9ta1l5?=
 =?utf-8?B?WWlKOXArT1JLc1BxcFFPRnFXbDBsc0pDaXBtOTZBSmpEcFR0aE5NVmpZNTRD?=
 =?utf-8?B?WjRYYXY4THFsU2toWFMrWklaeDN5cHJIWFVwbk85MThlU1ZxL2dHQjZ5d3Mz?=
 =?utf-8?B?ZTlBL0NUSEFZcW05OGNzVmxkNER2UW8yQUp2SnNzOVYzd3JRQ3pUbi9pWUxj?=
 =?utf-8?B?bzN6VFpzVW9lSFhTS3c2Z0FlcDg0c0d3bHZzNmRPSmROQXM1WUJFMFJLaVoy?=
 =?utf-8?B?VWtVREQ0VHNLTFFFWlU4aXdFQ0J6QWxZbE5sRjhST1Njc0RMemdWOGcyR3NG?=
 =?utf-8?B?OE9WME8ycUl2WExRTllJTm5iZlgzb2NZWjBOS2hNNXZ1MVFuNTUwVExxZTk1?=
 =?utf-8?B?cWZoZ0xkU3Z6ZVJGZ3Vmd1BxNytSeHJkZG9sTTdOK0dQNkZLZHdQSkhsZS9p?=
 =?utf-8?B?bWJreFVYWWlmQWhIUVJOQkNYeXNTQVZvR0RYSnBXc25CWnQ3S2xGVWsyRkp5?=
 =?utf-8?B?cm9KcDhNNkUrZjVoQTJndHBmYy9GR0dyaTJ6RHRHaWFlc1J5cWNFTldhL3E3?=
 =?utf-8?B?VEtWQkxhNU9UaVFlV2Z1Sjc0R1hIOXVSdWQ3dzZTaEJSaUhKODFPUUhxM3RN?=
 =?utf-8?B?MjkxM2htYzFDcmpMTVlQWkpzS3RzSllqMmNqektlMVVMdUtIa1N4QzZaMXdp?=
 =?utf-8?B?RXgyLzVxT25LT0lHZTJ6NElYZGpQSXJ6VVMydzYzZ1ZiMkZhZUpydnpVclJs?=
 =?utf-8?B?L1pManh3elNvQUhGTnNkYkJmeGV4THdSQ3Q3WkthOTI1R2sxT1JRREF2eUFE?=
 =?utf-8?B?cnYxaDlGcUFJQjdPMFJOTmxMdTlLRVJjUEY4U3NKenFFdjhUWlZmUklPUkNG?=
 =?utf-8?B?TWp4R2NQR2czKzdja0VHQmJhTzRSa0t6d3ZKYm02cmJPL0ZLSGdnYzd6L01E?=
 =?utf-8?B?RlpwMVZmU3JmbU13ek8vbTBaaGtOWHpiZHBJVkpIb3Q3K01mWnpYUWd6MldV?=
 =?utf-8?B?WFIveG5OS3ozUm83UVM3SkN1a05UbE8yVm4wbHhYMVBFaTBRektRRHlhNW5m?=
 =?utf-8?B?SmRObFJacDBlWHNDWGpLWXNBeC80TVE5L00yb2RBZVFGb3hzdU9XaWx4NXBh?=
 =?utf-8?B?YUVBZlVYeEsvNkhaRlFZblIxZzhwSHVZZkh4WFlLMTNib1puaG9TWGxadVVn?=
 =?utf-8?B?WjFJd1J3aFBBajFmaWVuWXpuSmxSZ2tBS2dEcWZyRjlHaUpSZ1NhNEUxM1Ft?=
 =?utf-8?B?NHZpSUhIWDJ5emdRYjBhaGhQbFlUd045d2NoWC9aR1V4UnMzYUIwN0lZNkxW?=
 =?utf-8?Q?K7e0jhHo/3M1oARlzkgzBsK99?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 454d10ed-14fb-4f96-1e62-08ddd64912b7
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB7820.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Aug 2025 06:59:09.4894 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QHHI9TiTWIUnSeMRTrGxKJAsCSp+RMvDQQEvBsfmOsF1MV0PM8gWVNXdksXV7hD3
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ5PPFCD5E2E1DE
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



On 8/8/2025 2:19 AM, Eric Huang wrote:
> Currently each kfd compute partition/node is sharing
> the same uuid of AID, which doen't meet the CUDA spec
> for visible device, so corresponding XCD id for each
> partition in smu has been assigned to xcp, and exposed
> to kfd topology.
> 
> Signed-off-by: Eric Huang <jinhuieric.huang@amd.com>
> ---
>  drivers/gpu/drm/amd/amdkfd/kfd_topology.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_topology.c b/drivers/gpu/drm/amd/amdkfd/kfd_topology.c
> index 4ec73f33535e..14b5fa670727 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_topology.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_topology.c
> @@ -530,7 +530,7 @@ static ssize_t node_show(struct kobject *kobj, struct attribute *attr,
>  		sysfs_show_32bit_prop(buffer, offs, "sdma_fw_version",
>  				      dev->gpu->kfd->sdma_fw_version);
>  		sysfs_show_64bit_prop(buffer, offs, "unique_id",
> -				      dev->gpu->adev->unique_id);
> +				      dev->gpu->xcp->unique_id);

This needs a NULL check. If KFD has xcp, use its id; else show from the
device.

Thanks,
Lijo

>  		sysfs_show_32bit_prop(buffer, offs, "num_xcc",
>  				      NUM_XCC(dev->gpu->xcc_mask));
>  	}

