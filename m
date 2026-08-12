Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 74908C5B572
	for <amd-gfx@archiver.kernel.org>; Wed, 12 Aug 2026 16:27:36 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0330C88735;
	Wed, 12 Aug 2026 16:27:36 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="hd2YCgci";
	dkim-atps=neutral
Received: from BYAPR05CU005.outbound.protection.outlook.com
 (mail-westusazon11010020.outbound.protection.outlook.com [52.101.85.20])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DC05C88735
 for <amd-gfx@lists.freedesktop.org>; Wed, 12 Aug 2026 16:27:34 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pMJ4SgEg3FZUC3unclYlYNPEIGkeKDEcdUj/QS/GoTPgwUIhQG99GgsRKrJh1kA2I1L0IvLSVieAeDjYY1kD3B6wMqsh0qy8o2jxlyjVKaacP9aq72oxmf4XB/OZJumE8uGqK+fiaYAHFLRGq2LmsL6AcV0FO+X2YHOhSv+fOejby7CK2puvQcyeER/CcCnHJENrBzkPFbxfMTqg2cnPsfNIlWStA1wHsSESWzHiiOJONrPcrakrytufcJmv3K56sAuiIBWTEE7PZNK9mEhbuhFanZOBJLtr7kEJzfQxARAvH4HFrnJSmpgporSM3BtIqCGjPjdMGnufo16QGCpmFw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=twdvz5MFXwHdZ0nXdTsP3KS1efNDa1nMpcy25YWnF0Y=;
 b=sZsBFQt9YEvBG4SeXj0pJJ26211sfWJrsEnEqIflFmjAFoS4eCgOOmBNBsDW6WT00nuC/Z57Ci3285Z1mbHfsN0QjrkB+TYSXUSmhty6NGq7dEPyYyP/M01h/sYRKZxczzILpc6cqoS5/dynhj/6yj2jKpcd9W852Kzsr3cS4NlGEphZgjlhN1Qmw7tn5Ji3APbDxaQErqoa6+y+VbJUgxOnV5FQr6JH6TIRlu3m4FSyGu5mJGVdhF74bgWo94VssQmSSfu/cdxu+lKU0FIWqOyKclpYaImGnpFlEpY3PDo/EgjChrwErxPM+xaSPQ74qZcxnK1V7oPWP8rqgCs05A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=twdvz5MFXwHdZ0nXdTsP3KS1efNDa1nMpcy25YWnF0Y=;
 b=hd2YCgciBK41DY1I0vRAl/gdH8684MjmP09NgeWMkLmuixxtPOrSZCyMJ/2BfI8iQ/PIuQSOlxGaZyr4sYXpD3xBngrbajtRhR8ZEpb5t1YnexoeTnpBOPkkoNGopyoc1YsMO29fXHomujVQ+UJoXDnPpFeGyfondTI4VsVX/FE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SA5PPF8ECEC29A9.namprd12.prod.outlook.com
 (2603:10b6:80f:fc04::8d5) by DS7PR12MB8231.namprd12.prod.outlook.com
 (2603:10b6:8:db::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.315.11; Wed, 12 Aug
 2026 16:27:30 +0000
Received: from SA5PPF8ECEC29A9.namprd12.prod.outlook.com
 ([fe80::54ad:b7e2:f8c2:dd51]) by SA5PPF8ECEC29A9.namprd12.prod.outlook.com
 ([fe80::54ad:b7e2:f8c2:dd51%3]) with mapi id 15.21.0315.011; Wed, 12 Aug 2026
 16:27:30 +0000
Message-ID: <3f62daa5-7c4c-476b-b692-0cb544e3d2a3@amd.com>
Date: Wed, 12 Aug 2026 12:27:27 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] amdkfd: allow profiler process reenter
To: "Zhu, Lingshan" <Lingshan.Zhu@amd.com>,
 "Deucher, Alexander" <Alexander.Deucher@amd.com>,
 "Koenig, Christian" <Christian.Koenig@amd.com>
Cc: "Huang, Ray" <Ray.Huang@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
References: <20260806084312.79422-1-lingshan.zhu@amd.com>
 <CH2PR12MB94573C6D5DD3480E33E6463F8CDC2@CH2PR12MB9457.namprd12.prod.outlook.com>
Content-Language: en-US
From: "Kuehling, Felix" <felix.kuehling@amd.com>
In-Reply-To: <CH2PR12MB94573C6D5DD3480E33E6463F8CDC2@CH2PR12MB9457.namprd12.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: YT4PR01CA0033.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:fe::12) To SA5PPF8ECEC29A9.namprd12.prod.outlook.com
 (2603:10b6:80f:fc04::8d5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA5PPF8ECEC29A9:EE_|DS7PR12MB8231:EE_
X-MS-Office365-Filtering-Correlation-Id: 2662995c-d1fd-4e54-d069-08def88e9b12
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|366016|23010399003|10067099003|56012099006|11063799006|4143699003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: tKiV7kBoDqScHCuwv9x1puS0aS0NSWhEnO0LzFnTD5FX6zDYH5QSa8ohWERLblIBc+l3FbYWRYDC5zMYgHrU8PBB47lSZU30muDOgm3/wVrbGq1i8Hrc+8LFAVoTqJbVIG+jHZmLLOilcmWNLoLWCQLWhchZ6x/0j8tjELyn/oHdxb/g7MIBXHyCVc99qeuiSrq3q/k4JdLYZPY6/cdiRIYRaSCP+u1UqcsR3g5qEyNWCqNLK4v8oCv8k+DIx3UqREdjQZ8P378ZQ5ESPrSZY4Iwuf8UVkPpLecoVrMCMTLS6C4rc3ldKh7YaJWmle3i6evKgPa8uYOisGIaQhEJpiOm4xcLiuwZK2tzA9iUQheLClld1A/5HAdihAbfHDf+6eoh1sfiIfafO5AIAC1zXVUBVv4q16tpxX5yxWoRbFqfjCl4Zl+ov28+0aYY8rIXugbgA7EB1OZpiEJXq4EQzux3naXhcMWgJuzX6RZZQWhpstl+6/6ntCJ8ZBnhHPzg09579igm2umqLeLrotHQ0aNLC1DrjGd6UWeDXtH8Z7IfGwTZXof6AcMawL7xaeHVO87o+ph2T9oy8QsotKVGCNbMDD6E70OJEXqPc53xyVVHgW/Sd/aztlstQGWWpEeVsufHbTXosZod9WpgycS2VxU4Rkc5g2Eqk/tPDWxfCZE=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SA5PPF8ECEC29A9.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(23010399003)(10067099003)(56012099006)(11063799006)(4143699003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SG1XVWhmaWQ3MFRxd2pQZGo0dkFjWWp5ZEJnalYzUUxKZHNhY3l5THNranZk?=
 =?utf-8?B?b2l2dWJ1UjZmME1qcnYrMk9jZ1dvSW1HbHpqdWxITWtSSUFsQmlLeG81d0VZ?=
 =?utf-8?B?STRQelIySUpSMjRkZG50eXNES1k3MXIyb2xMT1dpOHRSOGFHZUl0NmlSUVpq?=
 =?utf-8?B?d0VxYmJlWWVQUEJhWVR6U0NzdTRYN2tSU25SSWsrcG5oZ3BIRDFCMDZ1b1hY?=
 =?utf-8?B?RXJrZStmWlQ4YXU0SUZaczR6RzFRMExSLzJQcW85U1NvSzNCVXJ0ei9BLzNr?=
 =?utf-8?B?ZmphZGt3OVlFNFcyMlBFOTYweUN6L1kzOEpGd3lNbW8rYlZNNEE3WTdybDlQ?=
 =?utf-8?B?OUg4c1F6dGhoY0k1TWFkZjJTNkRrcWFERzB0TGMxMityYXlEN2pzbk9XZjR6?=
 =?utf-8?B?bVdta3JkakRwbmh5TDJTRldzNm5HM1hjck9FY2t6S1lSTnlpTlVrZkUxb09o?=
 =?utf-8?B?RHRuc1ZsamQ1TFA5Q2o1YzZ4WGoyMzQ3VHE2eVl5ZTl3VVc2VUV0YWhTUnJt?=
 =?utf-8?B?ZCtrNEZsN1lYN2dXMlBvY3VRdzBQK01zUkVHUVdCdGlUY0htVkJ5dmZEMDBq?=
 =?utf-8?B?bjdVcUpkMHUvNTgwRmp0bjZpMDNrLzRYTDBGMUc3aElQVEM0QXAxeGxVejNh?=
 =?utf-8?B?aTM3Y2N6MmRFdmtDRWs0NFMwcTdaS2FoOXZnVHlySmdTZ09QNVd6V1JvcnY4?=
 =?utf-8?B?OTNQZ0JRZU5RWmsvaUdJTFQxeFRWczIrSjdtQmE0Z1hUR3VOUFY4d1JYZU53?=
 =?utf-8?B?NjRPMlo4Um0vRTBqQm4zeGRPRlNBY0RqVzFiQU0wM1h1bkIvSE1ZYVF2T2N0?=
 =?utf-8?B?WFoxVEJubm1MYWhvODQxL3p6YTVWUkg0cmNPTm9xZGg5dDN2NGpzdXNCMEpS?=
 =?utf-8?B?Z0k2SU1qamxsSGsreE9ZTktwSk5rWUVtczlJL01MSFNUUklFQ0QzT3lEVVhS?=
 =?utf-8?B?VjQzRUNvYVZVQ05GRnBvS0FWeUFQTXdRUXFZSlNkQ1FMTWlWOEJrT2poam5n?=
 =?utf-8?B?cWZtNlkyOHZLVXNwUjNQOUxMVXE4TmJKcStKWkxYWXdZUFFPZnY5L3ZsSVUw?=
 =?utf-8?B?Rk8zMEhheTVVYm9iMzkyNlhFMlBMNDFTQ3dHRWg3cXY2RkNKaFQvZEZzZXZW?=
 =?utf-8?B?K1dXUWVnaHZUT0VLZ0xCOTNoRUtMRkFpNmJwcXNRdnExd3NDT3hKOGtJV1Nz?=
 =?utf-8?B?R2VLRTBPTjlmYjVqaFgvUUg0TXJCeXBRL2tkd1doTWNmSFFXN24yMzdlR1h6?=
 =?utf-8?B?aDYxUkQrVWpoVzk5Sld4Q3dXZGlQTlhQODR0dUdNcitlZUd2U2g1TlNoMjJP?=
 =?utf-8?B?MHdLMmRodkpiNzdnb2JvdldBa1k5TlR1RlJiaDE0ZUVmdmpuMDZ5eHlobmsr?=
 =?utf-8?B?WXZZQTVkVjJqTkV3R21OV0p1YmJoYmVGY1NveEtiQjBjWnVJbExDTUthTWZt?=
 =?utf-8?B?Qm1ZZGlmK29aYm9xTUxQVWZNTktoNi9DUjhCODljekxsb1o1Y0w1cDJFNjN1?=
 =?utf-8?B?OW12MVVvb0NXVHliRkpjSUJ1aDFQZEIySGFKb1Z6dWhRbnlXY1JvL1MwUHRs?=
 =?utf-8?B?d3B3bFYyNUR5VDhpWmgwTmxoaiszcVNEUmtmQ2grZzg3OTN0RE03VEw1NzFU?=
 =?utf-8?B?Y09iNjFkTDN5WkMrRGJMRWZObnNEQUlXT3FwbDhNM1F6VG5Nc3BLVTZ4TlBG?=
 =?utf-8?B?VmJ5S0h5YWZhTEpmOTljcWlsemZLSGFLcnErVUUrb204NVpSWHUyTVJjcG1R?=
 =?utf-8?B?SW1qZ1JwMHRiTjJ3M0FnMzJMR0NhTkZKZzNsSGNnTEVMWC80WkZOaXBGZHZJ?=
 =?utf-8?B?cnB5TExkLzRHQ1FXYkdLM2NCZlBmK29JKzVxazVLT2JLOERCZ012QVdwZ2xz?=
 =?utf-8?B?U0NxVUYwUW9MSUhzYUxEUHZObXMwY2ZvK3U4N3lJbEl5N2FydzBsaUNWdzdq?=
 =?utf-8?B?L05ZMHNFcDZjL2J1MjFYTWtmZ01FTjFmN2xvcTFzV01EK0wzM0NhS0VndFdM?=
 =?utf-8?B?ZFRmWWdBUDZYYkhMZVdLclJoeDV3U1NxbmVJUlNkTTNtdUN3RFhramlNSmVy?=
 =?utf-8?B?NDlma3FtYjdOQW1Ta0dYSGdCUWlKWmtlRit3NVNpb0dZdWk3Mitrek5ySUtN?=
 =?utf-8?B?WnZrVEFiY3J1UE00VUVNRTFxQytxMkJqOVNQRzNMeTQzYkY1RXp3cTl4Ym0r?=
 =?utf-8?B?WnZJQk9TZG94ZXM5d2tSbVl6cmJHc01NMnp5RkdGZXcvUXVIOGNaaldWelhG?=
 =?utf-8?B?bnBXbTdPN3BTRkoxK1IvOEgxOXl6N2dlV0JyNUUweFRLQmRPYysxZUxRRTgy?=
 =?utf-8?B?YXBabEQ2Z3FkTTR1eVh0RTNOV2YyVFhwb0hZeUI1VndZSjdQRjN0dz09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2662995c-d1fd-4e54-d069-08def88e9b12
X-MS-Exchange-CrossTenant-AuthSource: SA5PPF8ECEC29A9.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Aug 2026 16:27:30.5225 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3rlfQslhWVOmfaDA2A8u42og4svM1PGh8gXcp6OBO1s7qpMk+pulFjdlRCmsa5jsC+BAo7oRhg3Vk6XHlmK0Ow==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB8231
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

I suspect this won't work correctly. If the profiler locks the device 
multiple times, it probably also unlocks it multiple times. But I see no 
reference counting being done, so this may result in a situation where 
user mode locks twice, and unlocks once. Now it's lost the lock but it 
was still expecting to have it from the first lock operation.

I suspect that this is a user mode bug, and KFD is working as expected.

Regards,
   Felix

On 2026-08-12 03:14, Zhu, Lingshan wrote:
> AMD General
>
> Gentle Ping.
>
> Thanks
> Lingshan
>
> -----Original Message-----
> From: Zhu, Lingshan <Lingshan.Zhu@amd.com>
> Sent: Thursday, August 6, 2026 4:43 PM
> To: Deucher, Alexander <Alexander.Deucher@amd.com>; Koenig, Christian <Christian.Koenig@amd.com>; Kuehling, Felix <Felix.Kuehling@amd.com>
> Cc: Huang, Ray <Ray.Huang@amd.com>; amd-gfx@lists.freedesktop.org; Zhu, Lingshan <Lingshan.Zhu@amd.com>
> Subject: [PATCH] amdkfd: allow profiler process reenter
>
> profile_lock_device() currently returns -EALREADY when the current profiler process requests to lock the device again. However any negtive values here are treated as failure, so this causes rejecting a profiler operation even though the caller still owns the device locking.
>
> This commit fixes this problem by returning 0 when the current profiler process locking the device again.
>
> This commit also changes profile_lock_device() to return an int value other than uint32_t, because it returns negative number when fail.
>
> Signed-off-by: Zhu Lingshan <lingshan.zhu@amd.com>
> ---
>   drivers/gpu/drm/amd/amdkfd/kfd_chardev.c | 6 +++---
>   1 file changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
> index 309510e23315..9acd5c91e51c 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
> @@ -3329,8 +3329,8 @@ static int kfd_ioctl_create_process(struct file *filep, struct kfd_process *p, v
>          return 0;
>   }
>
> -static inline uint32_t profile_lock_device(struct kfd_process *p,
> -                                          uint32_t gpu_id, uint32_t op)
> +static inline int profile_lock_device(struct kfd_process *p,
> +                                     uint32_t gpu_id, uint32_t op)
>   {
>          struct kfd_process_device *pdd;
>          struct kfd_dev *kfd;
> @@ -3365,7 +3365,7 @@ static inline uint32_t profile_lock_device(struct kfd_process *p,
>                          }
>                          return status;
>                  } else if (kfd->profiler_process == p) {
> -                       status = -EALREADY;
> +                       status = 0;
>                  } else {
>                          status = -EBUSY;
>                  }
> --
> 2.53.0
>
