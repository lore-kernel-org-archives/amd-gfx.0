Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CB072ECAAD8
	for <amd-gfx@archiver.kernel.org>; Wed, 14 Sep 2022 07:37:44 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F1D3510E518;
	Wed, 14 Sep 2022 07:37:43 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2069.outbound.protection.outlook.com [40.107.237.69])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6112810E8B7
 for <amd-gfx@lists.freedesktop.org>; Wed, 14 Sep 2022 07:37:40 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MhLIRNWbb1qGbjs5DBxtv9yvSzkD3uNGAABNmoZOy3VUSgNg7Qsq8A3ngXXMDABXQS+lLE27Y5HAjWiW3A+yZv+12BBm6wL+il6f4VwoT0j1A6DZzs0s1WDgwZh6ebm4ucoqze99UyDxZZOCeQNEuyoQYIrs/UHJHd0gpBu1E79rJSu4qdBEeTMtMFsN9n2HSIlWq99XENp18n9hCncZdlX1e04Ih3T4yIK98h/bKtWT4gDAIXNaWiGDGRfcos5ttg+OFEKQbzbBNdwcfvSdSeLHX78n2fdk0o84L1A3XXaRpD6346dkj1bYmqY8xczo/VVbwOxsZyg/UVxR6xUsRw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SibPXKzvS7ytiE1K1b8J9SfWdRGJVpJMvnlGRKgSD/s=;
 b=a8mnhLhIx3W6IB2FrZWOOxIqoX8bYmijxBS97s3IKz7YH6HCL9fyrK7pr1NFZ8O7diJvd189VaALgsBYMSz514raAaECymUxrgN4UYzCdDuS/hp5HXC8J5pFed3DmUlIsY6DG2iGL1DO+6QT/cfDZP7KlIuvMXfxH5iNgO2bQEzya8jvAcmVrkZK0DZK8Kp12GFPbyh9vjwAkqrXhDWvBtSY2ImPdR/E28+onJ7SwCfh+81I98EnNbxhJ151SpM7y9DS+1AXCypN9p2IEm6juYo7/0JXpqopVsrLbYkl5ZitcFCyeQhuVp29UIT87tkvmDPVPK0boS79kAa3ARgOYA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SibPXKzvS7ytiE1K1b8J9SfWdRGJVpJMvnlGRKgSD/s=;
 b=dEvtUkc/yc3lO7nnbpT7xQsdmOHtOVduzyPPcBsknU9AhAfKkq5OkGb0FfHTTHJqCxhN6/YGCZOZEy9PGfwoIFZ5vL2YwvS9Nm1V8S3xTIfgSFXKkLWuobS4oOalqq0kaKH416TohhfhGfqnPDxYDQEAFoz+I/ynamI0NAylbe4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN8PR12MB3587.namprd12.prod.outlook.com (2603:10b6:408:43::13)
 by MW3PR12MB4379.namprd12.prod.outlook.com (2603:10b6:303:5e::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5612.20; Wed, 14 Sep
 2022 07:37:38 +0000
Received: from BN8PR12MB3587.namprd12.prod.outlook.com
 ([fe80::653f:e59b:3f40:8fed]) by BN8PR12MB3587.namprd12.prod.outlook.com
 ([fe80::653f:e59b:3f40:8fed%6]) with mapi id 15.20.5612.022; Wed, 14 Sep 2022
 07:37:38 +0000
Message-ID: <4b54e857-23c8-e095-d9e2-beeebf9bbc8e@amd.com>
Date: Wed, 14 Sep 2022 09:37:33 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH] drm/amdgpu: Update PTE flags with TF enabled
Content-Language: en-US
To: Mukul Joshi <mukul.joshi@amd.com>, amd-gfx@lists.freedesktop.org
References: <20220913221602.1308205-1-mukul.joshi@amd.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
In-Reply-To: <20220913221602.1308205-1-mukul.joshi@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR3P281CA0057.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:4b::8) To BN8PR12MB3587.namprd12.prod.outlook.com
 (2603:10b6:408:43::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8PR12MB3587:EE_|MW3PR12MB4379:EE_
X-MS-Office365-Filtering-Correlation-Id: 4cdcf88e-b16f-45ad-dd7f-08da9623ff4d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: V4bOD4qq8hxQ5T05hcbUPWgtAB5zRCJM8AP1o3AbBkl4hAuEKOoRyaMmnKGwceKgNmd7MzqPCbL4RXewwGQ7VJ0aJBA2rRTy2HdD84ufTkV1hH+1rVV3DU/j/JZaI+M4UDvuhWd+jgchT8k2wQ6o02+3ArRIJ86k9v/tkHHomKp5HuoeWxTgIgPXJ+jHRQlMrvUYiMSKt1MXSj/1Clthx/ZUG3hcdUomYWuUEvZUOJxJR35NIXo+6NfESRNV4jYk5z1/2BZZuwZH3jUCU4Dc9BZH6/CJbJPztL595D4koxwF6KZJDYT48z+FijrUThmU3NWZ0WgJBZ1ZVQ8jGWIN28/6WPGBohaXx3mmtmauUrKvvctDvit+C1BUl0nKFnVJv4YhdBosYmXGg5a8FUsUgTVb2fwPovAdZpq5qrOSbC9m9p2SjP8VBQrRz/0FdSajy9ho6n/pDMwAlub1gU7L15/ovCqR0PK63uceoQv0wXzo3wUxj5yBOGgKmZ+sAxkBPk9pG2J4aL/nchu/lJ/MXsCyoSR9npp40H8zwAjIm0XnigRomWDhR+ebtYM9180SqpN7vZC2cw1EDiACessCMCn58ptSddL9ZSymxXZ0bzssOXsy1pg3GQyl9t75QZjSmLQDGdqo1QFS8i6CcusVNmbuuEvy3GRqnVTlL1/v7qPrV/RQmYZ1ZcVn77ATa7Q+g2/FrK9sHaYR04wi4r/sFDp/QBiPBzyOGljzlKeYAYZZtLirmiuFKjtcDQMbdnNwRPSYYSTZZGCtrqoerLoSQ6di990bPVVCaemUBbfpCLk=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN8PR12MB3587.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230022)(4636009)(136003)(366004)(39860400002)(376002)(346002)(396003)(451199015)(86362001)(66574015)(8936002)(31686004)(6512007)(8676002)(6506007)(36756003)(83380400001)(478600001)(5660300002)(15650500001)(4326008)(2616005)(66946007)(41300700001)(38100700002)(316002)(186003)(2906002)(66476007)(66556008)(6666004)(31696002)(6486002)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?V3dhUUNKQVdtMWRXL2RnYm5UMlFhN1RocUVBeTUrcWJ1ODd0SVpkVlJsd3pr?=
 =?utf-8?B?T0U4NzJXZDd2YXhBazM0Vkg2NUU3YVBiOG80U1d1MG53Q2ZTZXhaZGpLS2hR?=
 =?utf-8?B?U2Q1KzJ3WDdVLzQvSmtaK0l3R3dIOFJxZFYzQ1ZGV093OUdwR2p3UmZVSUR1?=
 =?utf-8?B?RnZPdkhTNXE0enN0a1QrQXBsblhCQ1hqaXlwQnFUZGJiZkVlVXB5ZGM3QXpZ?=
 =?utf-8?B?RklERUFjZGdMWWh2QityeWVuaXVpUTA1YVliejg2QXpsMlpGOXdpWXljS3Q3?=
 =?utf-8?B?bG80Nk1ldnk0YXpuMGpZTXlIblp3Sm1GeUdzVEZob21jQWt2VUZ3T1JZcml5?=
 =?utf-8?B?dTNydUxjaThiYlh1MWh6U3RyN0E2cERCdUlCZElSY2RhU2RlMDBZcnhYK25X?=
 =?utf-8?B?MERDZ0JRSTE3VTlFMlVmcFlqQzNwaHdaRnlvOVB3STFqL3NPZm5QQnpOTFBI?=
 =?utf-8?B?MVNDZnVTNWV5SlVWejVJNnZ0VVN3dFpqV1g3KzVuU1ByRWgwUDFZek93UHg2?=
 =?utf-8?B?M2dsaUJTSmNORWlKM3psRUFUUFY1VndpdEdHTTJaSHlhOVBwb2h2eVBqV09T?=
 =?utf-8?B?RGFsS1d4TUwzYjYxVnhlUVBORE1tbk1JRDBZYWFaQWI3MzM0eWo1QVNoQndD?=
 =?utf-8?B?Z25NTHBNNjFZUzE5Z2JKVE05UGI1K05aTG1RUW96cWVZRTBLMGNTRUlxZjRY?=
 =?utf-8?B?Ni9haTc4TTh2ZmdnSGptZk8raGtTSVVFdG5wQmx4N2QxQk9jakZFb3ZhZlNt?=
 =?utf-8?B?MXFudWQxcEpIemRraDMxQWI2dTQ4NWhxS00yRXZPTlkrSE0zVVBucUkyMHhp?=
 =?utf-8?B?cndlMVJGSjhEWTVYT0UwYjFHYVE4U2xmbEVaZk9oaEJ5dHd2d1NpQXdBK2pD?=
 =?utf-8?B?NEFjOGJ2L052RDZJODZ6dU5JNFEveDBJd3Bhb2lINFFHcGQ0emRPRW03Qmx5?=
 =?utf-8?B?QmhHTGlRVWF4YXUzeWZOQjFoREpXSGUzK29XQUlKa1lNK1Z5RjFXZitodVZT?=
 =?utf-8?B?aDhPWTVKWWhndC80TmlkSUZaMlRUcEsxSDE0MFFWbzN6VzRQZDFYTDFFTndK?=
 =?utf-8?B?MkJDbXA4azQwMDRXYmJIK0xKMU1tL2FwQkM5d21FQ01nVnFISFltUXZHVnZ2?=
 =?utf-8?B?dWZHYm1VS1c4RHY2aVlUdXNJdnFvVDQxekdQcmhFSmJHN3grcVJ3TjdrVFZX?=
 =?utf-8?B?VzVvSzcxaVZ3Qm5TWmEzdTZvdE1jRzBnUkhWcStIekpyM041MlExTVVyQzZw?=
 =?utf-8?B?eUJFZEg5elBzUmY3bGxDQVNuS1NLZUxJVGZ1YkUramJHS2JiOVY4dXpQQWhv?=
 =?utf-8?B?MmsrNnhuVUgybTI3WHVHcGphNWZSbVJBdDdjUTlBRGdHVTltZzJnM1kxTEM3?=
 =?utf-8?B?L3p4Z2ZnWXVpS0txYmVCek1MbnJ5WDRTdVorc0xuYkxUdENIVy95N3E3Uldr?=
 =?utf-8?B?Y1RNdmMvcW5CRUYxNWwrVmJBRkxmclFXSXoyeDdUZVljTlVueXdjUkZlMjZ0?=
 =?utf-8?B?d2tTbzk0UllDVExPQ1UybFZBdm9hSFdDVGR4SUZwdytkeXoxUEpDT2pwNkZG?=
 =?utf-8?B?YWdYUE55bkp3dkVqbWRZdTZoT0lzSHpoU3VnQnNNMC80bWpodXpIcW5uWHps?=
 =?utf-8?B?YzVMM2l6MkpGNHVWK1FIQnN4c1FRQWJ3cFcwaFJFZDFKdWJYeGRBS2M0c0tk?=
 =?utf-8?B?Qm0zNXpLV3pRcnVmRW1VUnVsSnFhT2NPMkgyekNJSDRvS25kUkRmRXRVTjlF?=
 =?utf-8?B?Si90cXdtMG1vaDk1Z2lvdXUySVVEZDU1bHZyTzhiNGxYbWdUbzZXRUZicnhV?=
 =?utf-8?B?Smhnd2ozTHBDWjBHNFMzZlNKRWsyUmNIU1pUdUxLZDhoY0JjNlc1dm9pdk1J?=
 =?utf-8?B?QVFXNHpMN1c5WVpDcEloT0xkVldJUHdoSTQrU21semVXbVp2eGV0VXJFcmxl?=
 =?utf-8?B?a0diUnA5dC9EK21uano1TFNqeTZ1SjNJeklrQ1RqektXaTlHSDM1WVhDajN4?=
 =?utf-8?B?WWJvL1VJM3g0aG5LZmx6aG1BQUNYcEhwMUVMYS9iV2ZCN05kV0pneEdQcUZh?=
 =?utf-8?B?Q0c0KzAxUjNlQjk4cE5xOE9vamZNenNLSkt0R0ZXVXpSZnliamxEcTRYbnVM?=
 =?utf-8?B?TTRSYkZQdlRjbWsycWdybEt5a285TERGYUJLS1JYUDQyTzF1U2d1TTA2N1BW?=
 =?utf-8?Q?XdXrHHxQDYs2KF9+5vmfR2QpJiQIdIKbxHXElacq1eib?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4cdcf88e-b16f-45ad-dd7f-08da9623ff4d
X-MS-Exchange-CrossTenant-AuthSource: BN8PR12MB3587.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Sep 2022 07:37:38.0161 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NP0uvbgbKuEtpmc2I9Zb6dokMqdJJO+gzDKRwPVHc3Fpt2POgtTCqvjquJmYQgoQ
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR12MB4379
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
Cc: Felix.Kuehling@amd.com, joseph.greathouse@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Am 14.09.22 um 00:16 schrieb Mukul Joshi:
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

Reviewed-by: Christian König <christian.koenig@amd.com>

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

