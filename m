Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 04056C87FDA
	for <amd-gfx@archiver.kernel.org>; Fri,  8 Aug 2025 19:33:40 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9843910E974;
	Fri,  8 Aug 2025 19:33:40 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="5GjcQB+l";
	dkim-atps=neutral
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2081.outbound.protection.outlook.com [40.107.94.81])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CE96510E0BC
 for <amd-gfx@lists.freedesktop.org>; Fri,  8 Aug 2025 19:33:39 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BRJ0JQdOWVYmLHjlPEpiBPcrqvWwgyMgfhX/X9WM4B19H7nexTzfLfDx9SxEL89P1qZL7QE/bEd4BxYlSjU3cDR4J42VomUZvWaLaj2+hJKmPrk7dG7Jt+vSo1tokVEZdooUJEU10QuJcWYaJwywXHutkBLM+DrvH+CKY7t0RMNTYzoUJVhwwHaHhES+LOZ8W65UspQrSxPyu9iiiQdmX+IGVyYvshg/+UGEqouTwm9clNu7uF4+oyBrf897m4pMS8pmEmCPJExubkMIvJi2MYHQFs6T4Cxky6ooiiG+YZWFf9s+uKet0VCglnhNx17LCwS38AlMMpHPawclXLWQ5A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=m4pVySsji8Zm4xZNb11ad2PmdKPiPPuk0iHZTLFbJXo=;
 b=LXZ9yqyLg/f+sX1rC3f+cuuNnMbrGESs4PufwftZ53+aL1Wu2R6AneoQRre1Z0D8/35UXnn+1Mu5bHRdy5PMpKsdgYWQnvKxRkKRIMk/0GhNCPmexwP8T1bCibCwadXPuyUZaFreTZVQ+w8GKTsvJ27j68yKoewxRGydxVzvU/ydiVwtsknhDh9xVA7BxvowhwG/DTk3cGyh60bXSsg9XT53Q9hFlIqCeEObGl0Hz8T6+ah+D6VwXl6xm/pEAhkMdRUVHO0AOps6OdktS+guVm5VwQzM/7tx07bCluLFgJMfkCMIPEJncJixaasecjsDfcr2GNXjk5FSJ/45Hf6cMA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=m4pVySsji8Zm4xZNb11ad2PmdKPiPPuk0iHZTLFbJXo=;
 b=5GjcQB+l49UQ01cT49/fCjVLYcXQh4sb2mIj6hoLVF0pJDSDK5ScuUHsCvTjwqj5Wxlfu4tO8QSj0Qp5KagT6ZewnmUo75/wbM8GuGpenx1p92GMRjtQAzEMnupqJUS0VmwBXg7Bgl1SzFEGjkZg+UZX21gfEtbyCzH2fESn7YA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN9PR12MB5115.namprd12.prod.outlook.com (2603:10b6:408:118::14)
 by SJ2PR12MB7943.namprd12.prod.outlook.com (2603:10b6:a03:4c8::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9009.18; Fri, 8 Aug
 2025 19:33:36 +0000
Received: from BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::9269:317f:e85:cf81]) by BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::9269:317f:e85:cf81%4]) with mapi id 15.20.8989.020; Fri, 8 Aug 2025
 19:33:36 +0000
Message-ID: <83fc2476-de21-4869-abc9-54ebd9aef146@amd.com>
Date: Fri, 8 Aug 2025 15:33:34 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amdkfd: Handle lack of READ permissions in SVM mapping
To: Kent Russell <kent.russell@amd.com>, amd-gfx@lists.freedesktop.org
References: <20250805145743.104650-1-kent.russell@amd.com>
Content-Language: en-US
From: Felix Kuehling <felix.kuehling@amd.com>
Organization: AMD Inc.
In-Reply-To: <20250805145743.104650-1-kent.russell@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: YQBPR0101CA0081.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:4::14) To BN9PR12MB5115.namprd12.prod.outlook.com
 (2603:10b6:408:118::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN9PR12MB5115:EE_|SJ2PR12MB7943:EE_
X-MS-Office365-Filtering-Correlation-Id: 5998ef3b-9e80-4819-31d1-08ddd6b27815
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?ZklMZm9LbWo5OVdTSVd3OENDME5RYmYxT2YzU2xSWUU0alB1akdPT2wvSVFO?=
 =?utf-8?B?WkZJVXhVWGk2S3Q5TnJwa2ljWDhTQkI2WHhidFVoV1NvenRzb2t5L2Q5bVFm?=
 =?utf-8?B?WlRrdHN1cEkwNzhQMXhvZUJMV3NNdGd3WkJRYnFCdC90ZkI0Tzh0TnFQVGJl?=
 =?utf-8?B?S1g0ZGtMU3F2Y2ZkUldyS0dWWEhGWHp0TmN5ZW1aczVZUDVaRlZOMXpBS04x?=
 =?utf-8?B?amlQU2dSNis2dlJCaUNraHN6WlpxK0tza0pRU3NrMHZVVXJXS1pqZ1JTUVNh?=
 =?utf-8?B?WmVyWi8rY2czcys3OVpVdm5iYVhqSU1JN1kwcWR5QnNhUUVRZVBveTdMNk9Y?=
 =?utf-8?B?ZytROWttNXAydFYzV0FISllBRS9wOUQ1ZEl4ajY5cDY0YXk0cXdGdk4rU3Fm?=
 =?utf-8?B?bXRuUjhnZHR0a09tWHRCNmEzKyt2SjZqUStLMXA5dGRreEhzYVJiNTBhUjRL?=
 =?utf-8?B?anV0TU85eS9EaXdWazNBS2RxamVZazVINUhNWjR1bHdIOWtYZ3JkZU1RRjJl?=
 =?utf-8?B?TlEvRGNpaGc4M0ZVZlpmVXhXODlSSkY3OFVBM2VxSTBReUl1MlRmVC9GQThI?=
 =?utf-8?B?OWhnZm9zN2RPdFBHdy9HVkZGQWFkMDlvRHZtU2hOazhZZFQ5NjZ5UFJDam9k?=
 =?utf-8?B?UmJWdThBMlFYMnRRNXdHRU5qb2NIaEZBTXNEQWppK2R2YTE2V21DMlc2cXZE?=
 =?utf-8?B?bC9mVzBRQlRqNEdtTUxkdUZ6YndteVpjbUE2azU4VU9ZaTNNL2wyK3FZdGZR?=
 =?utf-8?B?ZStuaWh2b0ZKK0dqeGJ0M2pucThzWHd1aGpZWFB0dXdJaTlQS3NhNjFKUTlR?=
 =?utf-8?B?WDZEZVp3VUQwcUNFaWJkYk9DbjVMa3N2MWsxQkRWSjV2NkFmRUc1clNqOExS?=
 =?utf-8?B?Q3owaTlEa29JYlpaZHY3azVVZlovZXRCZ29XWXk3REgzUk10azNoOFVBa1lv?=
 =?utf-8?B?eVcxcndOWUo3Y3dtS2RlYk1jaHlnYS9MRThsQXUxTlFvYUdnaHd3MkF4Q3VY?=
 =?utf-8?B?ajI1UzY1NzZiZU51eHBMMjY1bkxwZklhaFgxLzJ4R2NDNGhSNnIzNk9VbnYz?=
 =?utf-8?B?YlN6MEJCSVpKdS9FMXN0VXc0bDlBZWw2bTdrNWpGcjFsZmd3dW1zTjFGM0li?=
 =?utf-8?B?aEpUcVFxWG8vRFdEVGJza3daTTZZTmk3VkNNeGpEZGFoSEZXR2picUlJTkdW?=
 =?utf-8?B?Zlp3U3hVc2ZmcVlmaG9MOFBNWHludGdScEowRTFQbGhzWnJ4UFhvS3UrMFN5?=
 =?utf-8?B?bWNIT28vem9xeXdjQ0RLM1A1SFVRaGRoL0dLaXVhTTVpZitNRkdCeHpET2l5?=
 =?utf-8?B?Yk0xYjRhNlZWSHZTWlduaXhJZDRvVmFxUmZkdWNDSTY0SkN2SUw0YWFzb2pZ?=
 =?utf-8?B?WjlyTFNDTGk4RnY5YlpKVW8xVG1tamdBY2pDUUtub1h6V0RpbFI4NWhWdUhX?=
 =?utf-8?B?UXpubThlWUc3V3dJcFdCVWtId1ZwcEZDWUdDYkZic2k3THJOVGtsZnRFaS9y?=
 =?utf-8?B?bXFLd1pWL3JFZ0JaMThFWEUvVXlvR05DdGdCN0REcUc5aDVhQkFVZXV5VnlQ?=
 =?utf-8?B?NkNYM3NiNmtsWktPbThBRm02S3p0czRWN3JuRy8zbi9NNDdLNVZLalVGODVW?=
 =?utf-8?B?R21hT1R5ajhCc2JJUnBPLzNwakFPUFp4YW5MWm5YZlVSdndndmhIdW9ZUTMy?=
 =?utf-8?B?ZE5BVmZzdTJISzI5VE9NYno0dmtpQTBzcjR4SEIzeVkrdDdPYjJwKytOOU5y?=
 =?utf-8?B?TXN1V3BJZTcwaEFzTjkyL3FKcmp4bWw5b0dzbjBFNjlsd3RXVnNtOUVDa3Nk?=
 =?utf-8?B?Q09KaUYzbUZsU2ptYU5YZTlDVnNoVnc4V1dtRG0reEsxb01NQ01vN29qWDhp?=
 =?utf-8?B?SEVNdVpxdnU2eHZLaUE0cCt6K2NCS0ZoMzgwVGo4V1h3UUFRTHhjZVJMZmVv?=
 =?utf-8?Q?rcmxFmKGd84=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5115.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NzY2czJ6aGRtdkwyK1BRM1FOM2k2MlRTc3NmRDVFa2tNOXhET0dnTFpNRDZs?=
 =?utf-8?B?NE5qaUVQZDNBV2dZd2E1WmFSUDhOTWIvcXRMR0NuTU4wN1V2dHMyTXBlTFVr?=
 =?utf-8?B?cXVKVG55blRoU2pzVHRIUjJJMXNnRTZDM3AydHNxbnFJSzB2SHpJaFdVeDVR?=
 =?utf-8?B?RHppamdVOGxTNmRsdnhnMVVMMU9oSHJrQVlHZlBZMlBkc044WU1nUWplbHRi?=
 =?utf-8?B?VDNRdjF3MXRwOHRxblNHWThXdG0vbDNEVFJYUldQWWdobWdQM1lvNXZ5SGpK?=
 =?utf-8?B?bFV6R2g1cVVSNkY2akxBbURyL0kzTnJiTFJmTHg4ZVdqN1puWUZMd0lCOWls?=
 =?utf-8?B?NFpLV1cwRldpbThJajZzTm94NlNSc0xYQ0YrcWxHOVZMRG9oRS81L1ZlVXNj?=
 =?utf-8?B?MHJBTjduejdNdFF1ZXZVYnN5QStrMW9jTWtGQ2x2Q0FLNW9IQTFST0ZWblRh?=
 =?utf-8?B?K0EzNEV0bmg0c1MvMHpkZmxwSHNrNklVQzBVRTRjYjUrS0ZmOFAxM0tOSE9V?=
 =?utf-8?B?RVV3TXhLOWkyVVlvb0JPYVZXSW9aUm9ibnN4YTV1bU5YRWtvZjJDV3ZIMlF1?=
 =?utf-8?B?UVpKUEtySVFWZzlWRTB0UVB2RFVBMXJtdEl6Q2VvN050NER6T1BkU0xNSGJl?=
 =?utf-8?B?b2loQnRzZldIMmMvQTFRSEs3eUp3aWVCYnlHVCtTU3BJWGJrS2NoNmJYdmVL?=
 =?utf-8?B?S0s0Q2l1UHNmbG9ETktsMXJ5ZVhOVDY1dUVyeGxDWU9aSlVKcitIaCtZMjF2?=
 =?utf-8?B?ZnIyTUlCc2kydlpZcnhyMStCWjNuUk1qcGFHS0VlRkNqOWVOd3VQTkFvcllD?=
 =?utf-8?B?NWFiWHlhWUN4MXV0d3VNWCswaHdjTmlJUDV1d2tEQmpyRTNxNHJ1dEw3TDdS?=
 =?utf-8?B?c29rNFk3bSs3dUJCc1ZBc25NUnhFQXBCU3RxWEJ6YXgwaDBuUDJMRExON1Bx?=
 =?utf-8?B?dlNxQ0ZqS2pVWkI0aHV1Y1I4Wnh4d2tJU2JBN3lmb0FwQnpaSnFWMkl6M0lK?=
 =?utf-8?B?c21iWlpNRXRFSmc1VXZPRkhDZ0VXSE10em90bmRCcEtybGcxUUVLNzFMUW9U?=
 =?utf-8?B?ZnZCRHdwanpRa2hWQXRSdGtzQmNUSTV4UXBWNFhSR3hhdUdLblF1eEIwRFJV?=
 =?utf-8?B?Y1ZOZ2hvMFNqUU9BdjFaN3VveGFyY3RkTkU0M1lmOHdBK3FDL2QzMDVEUHha?=
 =?utf-8?B?UHFyNW91a1dUdjB4S01lUUMrU2VIK0hYYndWeHlzQTRnQkNVbUVkaWhFUm4v?=
 =?utf-8?B?VkErNDRvT1pGRmx2OGxINlk5R0FEVXI4NVR1ckNaRWR4cFRpRXo3NWhWZHVy?=
 =?utf-8?B?MEpXZURaVGJtaXNlM09ZMGg4dGo4a2RJQTQvZXhZYnlJREJ6THBsaU16Rk1X?=
 =?utf-8?B?SUp6RTNJMmttQnZLNGk2Tm40WUFMaUluUXB1Y3RjU0g5aEREeU42RWNMdjdU?=
 =?utf-8?B?V3JIQ0pGdURhVVpvRDNZdnM5RGh6bnMzVms2bjZnTFZLZFBaZVRmOGhJcisz?=
 =?utf-8?B?MWxaSlBqdVRjY1VDbHVHbXFFbitma1RZWFZGRDV6WHVCS2Q2RWE4eTZnVzZq?=
 =?utf-8?B?WW12SzlYLzVNMWRyMEZrbXNVUGtNSHdxNG5oc1BZcXJlZ2IyS1J2TFJOVzk4?=
 =?utf-8?B?bGd1ZytmN2w2RDZtTGFRNUJyTHhwOHlUa1VleXZZVnlsOEdqQnNaQ2xob0U3?=
 =?utf-8?B?YWdoSHMxeFRhcHZNQ3R5aFF1RXlSeE5Rd3Y3NUMzSklra2lxUjdwTHVmRHpy?=
 =?utf-8?B?RmhvTnk3ZjNqem4wQmw3dmg1ZTByK3g3VHJBQWN1ZWYwRWlhOEdWM3ZPUktQ?=
 =?utf-8?B?UWQ3QWV6ZkZxbnZDMmpLM3UrWk9DUVJ2Ui9GWVE2S3RCcS9Wck1vZnJyb2Ix?=
 =?utf-8?B?cWNjWmlzOSt0NExUMlB0S3RUOURrcm5OY21hL0EvK1ZlbE9iVkZKR053NFg3?=
 =?utf-8?B?QlVPY1dwNU00QUxrcE9ITWZPTDJaMm8wblVuYWJiVW1lRTJvNFJRUFlNbDlJ?=
 =?utf-8?B?YnFaZXhpNzd6QXlNaUk5Y0U4YlQ5T2VRaUY4QXRlZk1ra0xXelRCVXR3UDFr?=
 =?utf-8?B?QUFZcTR4K3dZaDJMdGJ0bUxHREZwS1BnRWNGTThubU1zUkcySlNmdG96Q0ZC?=
 =?utf-8?Q?LAjDb+SBISjEJeKBuWs2l+Boi?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5998ef3b-9e80-4819-31d1-08ddd6b27815
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5115.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Aug 2025 19:33:36.5898 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qJ8zIt5sgtf+fp0yE8IS0ATX7QaiXxiHnEtD/vfDeKWHcnVOmZRwGhz/AwegE0tY/AKCVtb5Nm9yfOlynbwa4A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB7943
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

On 2025-08-05 10:57, Kent Russell wrote:
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
> ---
>   drivers/gpu/drm/amd/amdkfd/kfd_svm.c | 22 ++++++++++++++++++++++
>   1 file changed, 22 insertions(+)
>
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
> index e23b5a0f31f2..449595aab433 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
> @@ -1713,6 +1713,28 @@ static int svm_range_validate_and_map(struct mm_struct *mm,
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
> +				addr = next;

Maybe move this as the last statement before continue below.


> +				svm_range_unlock(prange);
> +				if (r)
> +					return r;

This will skip some cleanup, including svm_range_unreserve_bos and 
kfree(ctx). I think you can just continue in any case. If r != 0 the 
loop will terminate.

Regards,
   Felix


> +				continue;
> +			}
> +
>   			WRITE_ONCE(p->svms.faulting_task, current);
>   			r = amdgpu_hmm_range_get_pages(&prange->notifier, addr, npages,
>   						       readonly, owner, NULL,
