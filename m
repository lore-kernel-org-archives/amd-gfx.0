Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 50969ECAAD3
	for <amd-gfx@archiver.kernel.org>; Wed, 14 Sep 2022 15:11:31 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AF41F10E946;
	Wed, 14 Sep 2022 15:11:30 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2078.outbound.protection.outlook.com [40.107.244.78])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AD45C10E44A
 for <amd-gfx@lists.freedesktop.org>; Wed, 14 Sep 2022 15:11:25 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kjuGZS+RDJRwlUf25RkGHVGTc6QjB/WXvhx4uE4njfRSClHz5k3dvn3fOMoUPhl4RsWB8orWkvGE6HRsDk/PXIZQcYGGOOxExQmOsZr1b1pieuIWKDlDJ8dzVWDgllMxgP4UvNYbWxCzylzLjc3WV5gVehPv5/4lmYj8npiY1yJ+i90GxcW1v5t5DNhuHgmMEgoqF57i5TZwTKcERaXcyKM91Zoboqty9FCvCf6yrksfH0X90XItbLqXJ0eAyDXS2xdP/rJueXR+zVvUiQ0dsKHd+DTZ8TReMmDd8TMIdNjbrThzqAp8TlcwPTTZMKRvOyDFKfopmQ2e2YtePeKJHQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GfkjpMTDfjIDfL8MfFfOPzhOZGMmt6kmzDS32cGCZUk=;
 b=oNvxKdI4LvAOYFZd3son4hz1uE/ovXnAu1J882kTcltjXmc4VdPe7fibU7spIEYaMaQn/PKTxBJ8ELcUrDfiqGNRju8LYNezEPUfvHLE+Y7ECVpbpm2juW5hPPOBiYxXy1LzIoOSw4fWdeLZi6woEBeWJ16oq4sYRunjs8oSg19vjcn56dP4Gwo+JJ1tmRleBjXCrOL1egry76dY6cTPBcO2U8Yf3tzQY13nPbBvt6rJRmiEh+9Xs2L5NyBzCslifhbGz81A5mExXqru6Du1FmgktW2vUPcMhWC08wUvZZIfasQSQYhj6hoPFI3XZkfihAQNXsyuOFWfXQxSO/5osw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GfkjpMTDfjIDfL8MfFfOPzhOZGMmt6kmzDS32cGCZUk=;
 b=c1lT5OrgjMOIjapZ7d5P6QRoojVCuZJQZCqLL1gHGmfF3fsO1G2Vo6dIsc0xutYUG7LzlHK/aeIpAnn2xkeUxOfKF/9viXlHtFWDrwTMFZUJxH5XsoBfX+j1a9wIxHwjZbgQwnE4DBDVwv8j5MVb2dir6e5FMJMj7+HqAmmUvnA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN9PR12MB5115.namprd12.prod.outlook.com (2603:10b6:408:118::14)
 by DM6PR12MB4122.namprd12.prod.outlook.com (2603:10b6:5:214::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5612.19; Wed, 14 Sep
 2022 15:11:20 +0000
Received: from BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::3de4:456f:800d:e013]) by BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::3de4:456f:800d:e013%5]) with mapi id 15.20.5612.022; Wed, 14 Sep 2022
 15:11:20 +0000
Message-ID: <5691514a-3300-4a61-ef5b-e64a57bf9ba4@amd.com>
Date: Wed, 14 Sep 2022 11:11:18 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH] drm/amdgpu: Update PTE flags with TF enabled
Content-Language: en-US
To: Mukul Joshi <mukul.joshi@amd.com>, amd-gfx@lists.freedesktop.org
References: <20220913221602.1308205-1-mukul.joshi@amd.com>
From: Felix Kuehling <felix.kuehling@amd.com>
In-Reply-To: <20220913221602.1308205-1-mukul.joshi@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YT3PR01CA0144.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:83::30) To BN9PR12MB5115.namprd12.prod.outlook.com
 (2603:10b6:408:118::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN9PR12MB5115:EE_|DM6PR12MB4122:EE_
X-MS-Office365-Filtering-Correlation-Id: 1bc56c36-28a8-477e-1e6a-08da96636136
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: tilSmRK7Wnc1u5PUUush2XGN8ZB51ZCfNUzXyt+qf2hGjgwZ6HLYwyW9quowKfbsJMr//EQtXsFMugcy1+Rmun2yUtCzY9VV1XiKcE140v+XUmefHKid0tFmsbLkorkaYJRJllcmUROBnTepBIiqzn+C3MFRtw+gAlWmNsvKqPvI6p0ltUan3Kut4edwu9ASzXF97OOpU4ZlS4YjYqYB7lcmJ1Eipo1UK6Y+Hh1I9vS9n7Y1eonYQhc444lX282KMnSmz/o0nLiB3vVmErVwLatgLs1B5INq2wga8MOsY6ie0aB5azWv9sp8/OP8T4PfMSEKWwkVFB85XBNAiB36BrpDWCddUnUoQhfOL77MeDnwigkAxtqtMQTQ9vVmenM1TXyL8wGqlgx4qPH77oZPm7Ursz1f0rGumxKZmwKyUBXTORlHCRst/3s6iEuja0TY7viCMpMmBkUTKykNLu6ws2wy/1C1i3uuSOwp3CJBLxc2pYGNQn+EnyeuB9Hss3ZDZQ0HaGcv/j1SymDbnwbXSKA0sEBdj01DSi9UWvUW9+KGaQEz9FHsF9ew7v/CBhnLmnG1RquzmSKsxbOAkmoi92zwswmST5nJDP+B6IgNW8Yt6uI26KxHA6eKZt3oxLRqxONvE0oLZgi5ZaMHO7REYVBcQ4h9eq00+Sf5FM4/nTrUrWZ10uAt9nA5rp9qOmdongLZr2157imm8yXV7F6j6nkad96AT6NrqN4gUViv3vFrxhG+i09DIYDFfszd/VfYgYrUwiUk45e//qCLiBTBZD+Rw6Pim4Ey1bnKteZhGC4=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5115.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230022)(4636009)(396003)(39860400002)(136003)(376002)(346002)(366004)(451199015)(4326008)(86362001)(2616005)(478600001)(6512007)(66556008)(8676002)(15650500001)(26005)(38100700002)(6506007)(6486002)(5660300002)(44832011)(41300700001)(316002)(2906002)(66946007)(83380400001)(31686004)(66476007)(8936002)(36756003)(31696002)(186003)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?K2JTNTZTbW9kenJTQTQ1QkRsY1hER1kwV2lqNjdOVVFCY1JkL05wbDBMYUxZ?=
 =?utf-8?B?VWMyenM3bXJ4WmZ3cHFwNWVrWE83UHZNY0cyTTdXaEZyNUd4S1UwRWRCcFNM?=
 =?utf-8?B?ZXJvY0VpSEMyazZaUWdnam5xcFRJdGVaWWxJeWwwekZEdTRIOHg1R05saDN3?=
 =?utf-8?B?T0FHcjZaQlU4QTgvb2EwRERGOHpkZmltNlJFZXlnc0dhNlJrdmowODk0R1Fv?=
 =?utf-8?B?SnAxOWtONm40Vi85WFh1dG5OVnJadWxFYWE3YVQxd2FhZDl5N0JnWTl3S2lw?=
 =?utf-8?B?YmM0SmVoNmJTYzJwNFFFQkFYWjdZN3d2ak91OUt1M3ZJdkYrYWZXdU1kcEF2?=
 =?utf-8?B?aWM4M05FSmVkemFGa1lZQkFsQ3JVdEdhbU1TNGdZbElpYXJpbmtVb0srbnpl?=
 =?utf-8?B?ZnF4OFhCQSt1dFhGTlJQMzdZZWR0VHE5Z3ZjRUx6Si9vaDBDOUVYd1hjaFpo?=
 =?utf-8?B?Y1FxdWNoSTBLa0tXVVpRWkJnK1NqMkpRRkwwOGw2Y0tTekZFNU03aGlNdjN1?=
 =?utf-8?B?WHhJakNodHBaY1VZR3l5RUV1cDJDaEFoY1RSOVV5MlpqN1BmdDlhR2xNUHN5?=
 =?utf-8?B?QU1ZS0NtMm4rVXo1YU9JUjNPYW1SNFBZdS82dk5idSs5WExQOWwzNUNCbWtz?=
 =?utf-8?B?bk90QmZ0aDZ1RDg1ZkJIWHZ3T1lPdFE4ZlZtVUY4eVdvUEUwbDZoMmNxblQy?=
 =?utf-8?B?Ukt0RVpwYld3ZzVWUzU2VkxGS2tJeDd3ZU55bzBrOTdZWUpSMEcwbUtLcjFH?=
 =?utf-8?B?aW1LcUNaSlZpUUtjSEtGR0ZycnRjS3AxWW16SmZNSCtyMEl3a3JFelRPWktL?=
 =?utf-8?B?Z3crUG0xcWZmT21UOU9pdXl0bFMzdkZuQ1ppdWNMNVpBYXRLYTdDSTgzdExN?=
 =?utf-8?B?eGpkSTMxZ0x3UVhSRlhKemg2dVlSZ0w3dzUxaTVFSkN2R3REQ1QvdTl4RGFR?=
 =?utf-8?B?aGZyd0hNdWczeHQ4M2xHYlhUcW1CSHNuMXhiMk01bGhQMEJ0VzhQa3I1R0xL?=
 =?utf-8?B?YzA3ekU5NzBaNmFHcmY2Z0w2emtyelNHSmhaNEcybTVaS0ZQWXovNDlzWG1k?=
 =?utf-8?B?WnVlaSs1azBZR0VEQjFOeSt2ZlI1TEFVK3R2ZDRNVTl3Lzk3b0xyYWxJeGNa?=
 =?utf-8?B?M0FYajY5M2lBZkwwSlc1bGthZUY5ZUl3SnpqajJsWkRYTkdmWVh0akNQZjk1?=
 =?utf-8?B?NnhjRGtJSWZYTllGZEN2dWx1YlRKaUdZVWQ2RFNvZU40YWRJRTRKZUN2WFVj?=
 =?utf-8?B?MWtwbU41d1BVditsUzliMUw4SzdudGtGOWJtQldqaUkxSEhqOWdQY0ppc3dI?=
 =?utf-8?B?aUFQdUdncEFIOGQ2YytlUFhRZCtERTh2aVREYU5nTTJxZnhvbkhoV09SZk0y?=
 =?utf-8?B?dVorNlhDbkVWNFpPZEVkQ05JKy8rbHlVN0pRR25KUHFaQ0ZkWVFzWkNPRlVB?=
 =?utf-8?B?YzY3UDlPdWtFcVRJUzVQNEpKZFZSUlhOTllqZ2ZSKzBwNkZkd0o1aDUzZ1lh?=
 =?utf-8?B?UXpXQk4wWTJTa2swb3M5Rklqdy9QV3FVSnhpK2l3cUtDMnRodEllcjVsUjlE?=
 =?utf-8?B?TDFteGIvd2hBZGZEWEpiTEZFaXlQcVJFM2pPOG9pLytGb0F5eHNUd1djN2NT?=
 =?utf-8?B?d0dDTUlOQTFYOVBuZkJuczV1SU9aVzA5OWc5ZTVKMkFlclF1QnIwcWJwSkJn?=
 =?utf-8?B?SHU5TGFqYlllcnFhVlgveVpicUQ2K1l2K0wxM3Y3QStQWmxneU9QeGo2OTlB?=
 =?utf-8?B?R3JWcDkwUm1jMXJrbTBJdjZpaHdYZWtwcGttaHduU1orOEs1RmZNb01IenJE?=
 =?utf-8?B?MG1OVWpIdU1ITUc4S2VjT3dlQW5aT21hMXk4ZVk2YlphQW9DNGpFUnRwcHBn?=
 =?utf-8?B?WllqcFJ6TFVaWWtjaW9qMnp0K00weXpKZHY5SkJqNmpDY21TTEdmVmxRU0wy?=
 =?utf-8?B?cTRQNmFhSldPbWlkRFIrS1dHSHAydkFJNWJoemthQWdyQkEyR0srTUI5RWpR?=
 =?utf-8?B?Wm9YZVNJdWwvNmhXNWJYOXNsWFNHNmp3Z1J4ZGR1eStDQWs0R2tJUWdsa3Vq?=
 =?utf-8?B?dDdFZklOOE1NR0FjcHAxQjlIdzBLQjArUDZPeGxCSzNQNTNIOXpCWCt0ZW9i?=
 =?utf-8?Q?Eh7z4G+OOpbys4S73BYER6/4D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1bc56c36-28a8-477e-1e6a-08da96636136
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5115.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Sep 2022 15:11:20.5255 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BV57K/z9+I70BzzsCvf93C4VSXk/+6qZOkNPaKrpqnUoEoRwIykUcY43U9XVXhOhB19ylrPnVorA7QZCyaQ0+g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4122
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
Cc: christian.koenig@amd.com, joseph.greathouse@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Am 2022-09-13 um 18:16 schrieb Mukul Joshi:
> This patch updates the PTE flags when translate further (TF) is
> enabled:
> - With translate_further enabled, invalid PTEs can be 0. Reading
>    consecutive invalid PTEs as 0 is considered a fault. To prevent
>    this, ensure invalid PTEs have at least 1 bit set.
> - The current invalid PTE flags settings to translate a retry fault
>    into a no-retry fault, doesn't work with TF enabled. As a result,
>    update invalid PTE flags settings which works for both TF enabled
>    and disabled case.
>
> Fixes: 2abf2573b1c69 ("drm/amdgpu: Enable translate_further to extend UTCL2 reach")
> Signed-off-by: Mukul Joshi <mukul.joshi@amd.com>

Reviewed-by: Felix Kuehling <Felix.Kuehling@amd.com>


> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c | 3 +--
>   drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c  | 7 +++++--
>   2 files changed, 6 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> index 59cac347baa3..690fd4f639f1 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> @@ -2484,8 +2484,7 @@ bool amdgpu_vm_handle_fault(struct amdgpu_device *adev, u32 pasid,
>   		/* Intentionally setting invalid PTE flag
>   		 * combination to force a no-retry-fault
>   		 */
> -		flags = AMDGPU_PTE_EXECUTABLE | AMDGPU_PDE_PTE |
> -			AMDGPU_PTE_TF;
> +		flags = AMDGPU_PTE_SNOOPED | AMDGPU_PTE_PRT;
>   		value = 0;
>   	} else if (amdgpu_vm_fault_stop == AMDGPU_VM_FAULT_STOP_NEVER) {
>   		/* Redirect the access to the dummy page */
> diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
> index 4603653916f5..67ca16a8027c 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
> @@ -1103,10 +1103,13 @@ static void gmc_v9_0_get_vm_pde(struct amdgpu_device *adev, int level,
>   			*flags |= AMDGPU_PDE_BFS(0x9);
>   
>   	} else if (level == AMDGPU_VM_PDB0) {
> -		if (*flags & AMDGPU_PDE_PTE)
> +		if (*flags & AMDGPU_PDE_PTE) {
>   			*flags &= ~AMDGPU_PDE_PTE;
> -		else
> +			if (!(*flags & AMDGPU_PTE_VALID))
> +				*addr |= 1 << PAGE_SHIFT;
> +		} else {
>   			*flags |= AMDGPU_PTE_TF;
> +		}
>   	}
>   }
>   
