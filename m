Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 313DCC5DF72
	for <amd-gfx@archiver.kernel.org>; Fri, 14 Aug 2026 21:18:33 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F0E8710F757;
	Fri, 14 Aug 2026 21:18:30 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="hJDacUlh";
	dkim-atps=neutral
Received: from CH5PR02CU005.outbound.protection.outlook.com
 (mail-northcentralusazon11012040.outbound.protection.outlook.com
 [40.107.200.40])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 89FE810F759
 for <amd-gfx@lists.freedesktop.org>; Fri, 14 Aug 2026 21:18:29 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FV7lgfg7vHRP7KBqxJN2pVyvic03faIRWIecYzFydBwE+XjfCqG+7Ac1UBLYpOJHKemCury/uZlt8hMqQLXhtVexZkaF8vlVQRH3Ryi3SGcyxQDKS0n0nT2ZQmIlks3tuRXh8ySAuulJZwLMgr649DfzrdBt4MBv8hZ0jV8d/rG7eSbTMNl65bfW/YHjp0DVkB2ZZmPdjtuzlaX8uhaZAf/l2BDs9t7lxMjgIHpYw1Mf0RFrSt6f8kPb/MhN9Mg0//Q6fNo018BdbCaYdjB+qutg5Ex/4eWp9xUFefNqkN7ah49s+cCnsbfMQH6yaiUh/mVb86ra/64las40Yg+3uA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rXd0hubjox+xwjD6d+9QK3zOEWJLpwqgB38jSvnpBfw=;
 b=jv+Gcqmx/sAPwb9uvAGGVoW3a8ioudZFFPMTZUXjfzSTVjMjUYN4rTplf05TwukYTle72RkdIrdTrufCdhGReskdOSnpekWcVyKGV7ZLr6gABCspCyP6PEZuFFH6pGNrJoM/4QivklabP+R8Pg6nNYQKM5Tm/oc5SG0lmn5/kvr9Ppq/akUpy63C5IgQqZHulEIG3NzIWWDdVP0dufN/QinPEyEruAejuvQ1+Fpy3rXjwQE7i3h5Ejdqz4JivVqCBXfnz5OvWeadlvDJq9LuAzHEsW846lCihPsQap0AfyKLPqAOLM1Rkpedb84CmEtY08ctSjTmPmIpE4Y25pf9kg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rXd0hubjox+xwjD6d+9QK3zOEWJLpwqgB38jSvnpBfw=;
 b=hJDacUlhffUghJaemyYoyWSFmv0/CEznD4cqz5x5G807Ny/44kfFMVYVaciV68q0Nei7IDNgWhov2wmF0jflpL1mV43/s7YyprEL4E5tFflXaYvgCMyeL4zIpCcuyHCvc7iBsbwkzwxU1jblHW6rpcWXLsaKmmk/ko46yTwY7f0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS5PPF78FC67EBA.namprd12.prod.outlook.com
 (2603:10b6:f:fc00::655) by CH2PR12MB4213.namprd12.prod.outlook.com
 (2603:10b6:610:a4::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.315.16; Fri, 14 Aug
 2026 21:18:26 +0000
Received: from DS5PPF78FC67EBA.namprd12.prod.outlook.com
 ([fe80::7111:7e5c:8508:7852]) by DS5PPF78FC67EBA.namprd12.prod.outlook.com
 ([fe80::7111:7e5c:8508:7852%8]) with mapi id 15.21.0315.014; Fri, 14 Aug 2026
 21:18:26 +0000
Message-ID: <773c64e1-ec6d-44b6-b3a1-f7c71e36607c@amd.com>
Date: Fri, 14 Aug 2026 17:18:24 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] amdkfd: let profile_lock_device return an int other than
 uint32
To: Zhu Lingshan <lingshan.zhu@amd.com>, Alexander.Deucher@amd.com,
 Christian.Koenig@amd.com
Cc: Ray.Huang@amd.com, amd-gfx@lists.freedesktop.org
References: <20260814065333.88615-1-lingshan.zhu@amd.com>
Content-Language: en-US
From: "Kuehling, Felix" <felix.kuehling@amd.com>
In-Reply-To: <20260814065333.88615-1-lingshan.zhu@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BLAPR03CA0014.namprd03.prod.outlook.com
 (2603:10b6:208:32b::19) To DS5PPF78FC67EBA.namprd12.prod.outlook.com
 (2603:10b6:f:fc00::655)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS5PPF78FC67EBA:EE_|CH2PR12MB4213:EE_
X-MS-Office365-Filtering-Correlation-Id: ff71aa9f-8b0b-4fd4-4742-08defa499437
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|366016|376014|1800799024|56012099006|10067099003|11063799006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: qCXdDqe3DhCH8zhDawMuLkBXysPF/RUxOUmQciS5VvFcFCXeMWSBWqgIupX4zoQ6YMc8QhbLGrKmwthJtkoSmj4l0bxB/Al1eqzEAHOvDflo6N7r9nHLu0+CKZph1E+rvWra4xCR3EJbI1cIfgjPzlOPQz2sjigGixSUKYtdoO2dhJR0Ps5lC1t6ZYUmjdMhG8xRbLp3Z1AhmMvdfUNGWvOeCjFUh7/xkKG3VINZTAmApqM6TgiipEZikHuDG9JoBTFIlu6oz6lEiLdJe2eGfsrVIfzNqFRywdmcKN2gOAeEPKlt3+iM/BgkxazBtgf8RwjdsShcU+0HA/AKUg/FwhKl4Tqz3NRWOMD7F/9dJC6z4h4YcGSX4hNvzYyYdzhBuKhW5G23/wV/H5lp9wSslLaSopEGEU+r31nBS/V/eQOBgYIeLhjHvGJPl0Bsew8TG7BaG+jqof71/x9z+9SZtn7mpsqvApBl7bucwv+Xz93Q2P9jjx75JyqLVDQUkCu4qIx5aKMFhIujzcYjTbmKXAuZHxrJIyJx8N3/vKNUUgOSyl9A6FBuW7AdRFJGSA+gQQX4YrgwKQa1Hf9oOdH/gJ+jWuMJb45Bu7j4R0Qm3A2W11kE5LS/ZBDYAPcWLVA2YHLdiNK+aBc0Gkt8KFP7edDSXBbvUaEYlKeOpoTWrBI=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS5PPF78FC67EBA.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(366016)(376014)(1800799024)(56012099006)(10067099003)(11063799006)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UEtiaDViQkREc0k3ZjhId1FlaGJDcGVrbEd0bUo5TWx2d3l1aksrWXp1RzJw?=
 =?utf-8?B?THJxcUlxdWp1MFJWNEthUGo0cHVrTXFHZzBrL1RGRFRHdUFMUm51ZndaY2hz?=
 =?utf-8?B?K2ErcU5GWXVXamhGWkQ5Z3ZPNmsrUnFhampySHpsTTY0Tk5CYVlsa0xsazNh?=
 =?utf-8?B?VXVxQWhGelNpZnV3OU1yQ3B3L210b2VEZWxyN1RBM01lTWR1Mm45REFlT2JX?=
 =?utf-8?B?RFdiWHJTeW54aXRSTStTbTZVMlpaNll2Sjk3TFlKVkxnQVkxdXdJMEd5djlP?=
 =?utf-8?B?VVpJZVBTVDJUd0tNMjlsMkE4dzVtWVdtK3prSkkrWkVTelBJRWZYRk84amp4?=
 =?utf-8?B?VlZSZmRFSkJwSllQUFJxMTFDTHFZOFFXL3h5YmxCNWZtNlBQZWwzZ0ZTUktQ?=
 =?utf-8?B?cGNmRndYL09sZjFHZVVaWUV2ZHlCdmZXWVFjbHQreUtmM3dXMDdHK0V4a05I?=
 =?utf-8?B?SUd2NzZDajlBbmxVWUNwNmNTODBUL1ZLdWx6aHBvdS9OMDdrVzA0UHIySnh2?=
 =?utf-8?B?U21lOUo1UWlKSEtBTU81eFI3Wi90dFI1b0huaHROUVFFeHpaME1FT3pRQTNK?=
 =?utf-8?B?YVUrTWh2VDgrYlVVdkF2SFVaaUVKOUpZN2ZVRCtnc1NtQTlaNVNJVnBZd2tV?=
 =?utf-8?B?aWw5SUxXYzJHUnJJbmZCRElHc1ZQNjBtYXRyY1A1K0hVSVloMUF0emdzWHhk?=
 =?utf-8?B?a2E0bXFGNHFwaGNCK0wrN0w2TjJEZDMycXI5UTJkYlhvUWJnQm1jckZvTHI3?=
 =?utf-8?B?QmtWdlB5c2Zld0dLR0s0QkxvNDVBRHJKTE9aUzZUQlFkaFhOTWlPR1VlY1dM?=
 =?utf-8?B?cEhYSEJSRXJrdFc3UGIremhZSVB6d0VLY0VObzlWMTFTZCtyMGNzNTN5Z2Vv?=
 =?utf-8?B?K3ZxVVJsSFhUOEFDcDQwNFNjMTloNXdrazFUYVVjR1hGbVlFcnNXWmZGblVa?=
 =?utf-8?B?YmVZU0tQYlRoOEhkZkl3L1BrNURBbzArTmd2enU1dWYvZG5sRVlCNzJxdUQy?=
 =?utf-8?B?aWRNZjduZEZhc3pGcnpBTDllMCt1WTUxblQzQXorQ0p0bUJKVnh1WEs3ZGlU?=
 =?utf-8?B?RnJsYUtvZHRnbmJ0ZjdNWXdwYnZkV08wdmg4NzUrdmF4U3RUY2VjVThDNW1D?=
 =?utf-8?B?WUJXbHJLZWxVb21FQ1dJRnFEbVZxaVhTYkV4UmsxK292dUdCTU4xeVppcm9E?=
 =?utf-8?B?bHE3RkdiZlJ6U29Lb0RjMU9oK2UyZWhaTG1EU2JmdFJ3UUxvT21HZ1Fuc2ln?=
 =?utf-8?B?RnZEQ2pqV0llQXRYR0FwS3pMQVFVNXVYQW1uQWd1OW9peXhYRXlWcEpZNVVQ?=
 =?utf-8?B?WGQvdURMOWZXK2JVK0FTS0JrZXNtOWxCV3RUMVdFRzQxSzFybE9lY3NaaDB3?=
 =?utf-8?B?Y0g1UnhPb05icDU3U0lpZ3ltWFJwYXZ1MlV6R0tMYTJRanFLb0JWQVlIVEdu?=
 =?utf-8?B?ZlJ2cVpqSFBrVE9kUldLOWZDRklheTQyZEZuSFJvekxRa1FRWVh5SkdWZEUz?=
 =?utf-8?B?cFQ4a2RBWWVBZ3hPM2RYbEo2R0sxT0RaNElYdkNJMzdmdHdVN2VCYnFmMFdh?=
 =?utf-8?B?T3FpQ044cmlsRnFXd1YyZ2N0c0QvSEoyd2N4UzB5S3FkNHA2THlINWhIcmxi?=
 =?utf-8?B?TWR0VUVrdnR6clc1R1RGQkNoZU83NUhuUUxPSHNTVFdiTTNaMUtqOWVYczZN?=
 =?utf-8?B?OTdnSmR0dlBQazdwaEpDWXY2MVNvRXp4NXEwTHd6ZjdDN0RYUVdWSnpyVyt3?=
 =?utf-8?B?dENnV2p2dGNBaDlnWFlMc0w4djE2eFErblpPV2dBUWc2M1I2aW95QndGZ0hw?=
 =?utf-8?B?bldJWWFHV0thZHU4VW5adkhyNDhrZzZUV2I1ekc1QUFrQjBEZXhyODBRN1Q4?=
 =?utf-8?B?S3dic0Z6RmdMSVlJRXJ2RkYwSXhwcldGU1JVa3pXbnVyelJrdkxucUlXaEkr?=
 =?utf-8?B?RVBkdGR6RnVkT0dqR3VmL2o1Sk5KNjI3eTdtM0VGSnRvODRDVSthWXFGOEVR?=
 =?utf-8?B?YlluOXY5WTBrRXJPNC9CLzdSOTIxdkZIdzlCVnVacFFEVnVpZEF0N3NxcitN?=
 =?utf-8?B?YkN3STdEUlQ2N2VuU1Y4eVFROHlyU2J3NHdMOFJ6UW9rbVBublJDN1hqcTAr?=
 =?utf-8?B?ak5Lck9adVVTUUJyMUJoSHZLSTFjVWo0dzAvVDQzd3FocHZWQ2NTdnhCalVH?=
 =?utf-8?B?S3AvVVVuNVVkdW10RHBmVmxPOHVKUW1lSE92eEcwc1lKNXFtN0doc0RWdHQ0?=
 =?utf-8?B?aW5Bc1EzNG1SRW5DSUZ0eWdYU1VYRHY2UmlmN3UreDhUaGFla2p1Z2FzSjZz?=
 =?utf-8?B?ZU5CTnE1OFV2Umo5WHJGenFXQXViL3NUbTMrVUpJUG1DU0dCTWxkQT09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ff71aa9f-8b0b-4fd4-4742-08defa499437
X-MS-Exchange-CrossTenant-AuthSource: DS5PPF78FC67EBA.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Aug 2026 21:18:26.0952 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xUJUuazBVbQnSSJtEY5hjjuxWbRYI8JC4rsERqphR53tbMK+Mb5IYOPY+Xz9aSukCbUIiNgt6F6veYSSTPlviA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4213
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

On 2026-08-14 02:53, Zhu Lingshan wrote:
> profile_lock_device() may return negive error code,
> so the type of the return value should be int,
> not uint32
>
> Signed-off-by: Zhu Lingshan <lingshan.zhu@amd.com>

Reviewed-by: Felix Kuehling <felix.kuehling@amd.com>


> ---
>   drivers/gpu/drm/amd/amdkfd/kfd_chardev.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
> index 309510e23315..6fd18488d5cf 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
> @@ -3329,7 +3329,7 @@ static int kfd_ioctl_create_process(struct file *filep, struct kfd_process *p, v
>   	return 0;
>   }
>   
> -static inline uint32_t profile_lock_device(struct kfd_process *p,
> +static inline int profile_lock_device(struct kfd_process *p,
>   					   uint32_t gpu_id, uint32_t op)
>   {
>   	struct kfd_process_device *pdd;
