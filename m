Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5553AC77B73
	for <amd-gfx@archiver.kernel.org>; Mon,  1 May 2023 15:13:30 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D40F410E2F8;
	Mon,  1 May 2023 15:13:29 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2050.outbound.protection.outlook.com [40.107.220.50])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 134BA10E2F8
 for <amd-gfx@lists.freedesktop.org>; Mon,  1 May 2023 15:13:28 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WnJ6AkThSY4qy+6whNTqHS+6QkDcjhwgDYLdIOwTIHS/Y2mvHP1KVtqaVvhUsdPH3C4NTrRnOsul6EQbWxVCxptXm9imQV5HTL/0d93QKgzOu82yr/dbsUmLyVhW3nk+WCIVcspHcS8MIwlYlu81cTIkm8A5rpR8ca0d/FcJ6GmeqoIquZOkjgHgTRNaXafnJkdlq5RIytgPfy9J7UzgVEuqG/rs4QcEKO8X8R7/GDZyry+WdKhCR+S0bQSKQ8UqK+FafPJUfbrXgX/rgxs27MLSATk3LgALl1nsa1oiwbEcF9nm70fuKRNXzHCUVwx77PK77Bry1Lj5Z4ZByXTVkQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CmQotopyMbZdTMgRh5OkUigW5R31BBPj5BL7KFU/KD0=;
 b=j+eqYbTk8iJfRHKXLfUDCFXUixUMo2y0Pcz1K//lwhSGLPJf6bXuBWg4YgLgLfzBTycrF/+KZ3n8z48UShnE6NrW0nEvDSAJvOxC/N5UevtYuRV/U4b1zFF9rkQvcEhi2QJ4yphUlzaHKst8ZHyCfpA2EGAMiY3bUGNjeVxlvM+UhtegfYUm59/IVCMtaC+CkekC0jebRkF7KdbA0qUaf6QCCpCyfr1aymNb5PjhWzmJfhZz6H0AxMyC+UwYrh2qfH5GpItHSNs+Rcjbsi4VwkSZpBr3rrMx0I+VYQw7bFt4hMWTy/T29wwH2qUXAnDBvtnIAytvAjcAYoXPzmSSrw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CmQotopyMbZdTMgRh5OkUigW5R31BBPj5BL7KFU/KD0=;
 b=1qYaAmrzylLfKYoc+NO9rj6+D88Sy2p3Xzb5sBxXL6HOuHmrPiADDx9wuqgMmxzioeDUXeIb0oVfc3wWxTxs6SSw+/eW9pbPVayPtA8SFT6dTbMKM7hKlmi8Ga4fBxqAijGfk+4YEnQ+JGYi5Jc85Wv4CBrvp5T5IcZUCm6bi5Y=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN9PR12MB5115.namprd12.prod.outlook.com (2603:10b6:408:118::14)
 by PH7PR12MB6537.namprd12.prod.outlook.com (2603:10b6:510:1f2::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6340.30; Mon, 1 May
 2023 15:13:25 +0000
Received: from BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::f170:8d72:ca64:bb26]) by BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::f170:8d72:ca64:bb26%6]) with mapi id 15.20.6340.030; Mon, 1 May 2023
 15:13:25 +0000
Message-ID: <d7b97fd3-59fd-d162-5c8c-3e02c0772fe5@amd.com>
Date: Mon, 1 May 2023 11:13:24 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH] drm/amdgpu: improve wait logic at fence polling
Content-Language: en-US
To: Alex Sierra <alex.sierra@amd.com>, amd-gfx@lists.freedesktop.org
References: <20230426161519.7840-1-alex.sierra@amd.com>
From: Felix Kuehling <felix.kuehling@amd.com>
In-Reply-To: <20230426161519.7840-1-alex.sierra@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YT4PR01CA0477.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:d6::25) To BN9PR12MB5115.namprd12.prod.outlook.com
 (2603:10b6:408:118::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN9PR12MB5115:EE_|PH7PR12MB6537:EE_
X-MS-Office365-Filtering-Correlation-Id: efab1d1d-9427-4dad-d5f0-08db4a569c61
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: R6BNRfFQZho1e/7icZO3cOXIia8XGg2iewjBF1v5AIziiRWXSIjcBX5yJLNzfB0r/bIBDvZ8R3TCor/pJME0uQVGasIIaV2ETCOkB0Z7WN0VlXsjFodOdtXcT6fzdokkLTXyO/R7EKTgw7WuUBCo5PmXvkDnD2+3ZW8EFWaXDJKWTADlK+SUHrNTssUA8Xj4UwbmIHd0PIcPeEe+PBs5+emqYu6jH0oLnvEb2SA9sHm7Nc/BpWn7Kr/SyHrcgdeHo1FMtx3ywmWZdInK/4nHdQVfCwNAqyt5sghJpd0DaPe5E2gOhFssTiZjnD9jWv5vLTgvPosV8eNAuB/1FEGgN7M7GR+VzNc+0nXxW3hunXF4LRGaNin+3yAxqTN6YiPQYzu5Pr/chc5SmhbJO6LoWcrELdwsU7eVj5sXC+z5ldh7ZXiC+Lgog3irhIcVe+bE2FGCJ+9Wyq+WMnrcrFLrDfFYAHboK78LWGjjweY+13/XRhDi2+kdMslOFaHZej581L3lkpxXzR6nnn7kw6bnZAL7MpL/5gpHNpKG55BNbMSpAE71OBgr9PPocTNKbDM7IfuNMuRR+ntf05Y5caTF+Io0Y6Dm4k0mil+eM5C6s/c72UwDETW4AvEH5dOiRflOxTSaeeDAIWrCHM8adfLCBA==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5115.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(4636009)(39860400002)(376002)(136003)(396003)(346002)(366004)(451199021)(36756003)(478600001)(66946007)(66476007)(66556008)(316002)(26005)(6512007)(2616005)(6486002)(6506007)(186003)(2906002)(8676002)(8936002)(44832011)(5660300002)(41300700001)(86362001)(38100700002)(31696002)(31686004)(83380400001)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WTMzSEJzMVVMQWhwR0NZdnpIdDlBV2pHS1JyQkJTTUpQZlEvN2Nac2dJQVA3?=
 =?utf-8?B?Qytqc29GbWNQK0NsN1JzU1d2S1lyV0JzdXZHaWhQUXBvQnB2Tmt4UE9HcXRu?=
 =?utf-8?B?UWp0Zi9GOXhrTjdZaTNNL3IxNEY2YWx6Z0JiSDZsSnkycVg0Y05TVWtrQlZI?=
 =?utf-8?B?ZVlEUDNuVVlkcVd4TXhadmRuY1FmdzBTL3Y4d3gxZ2QvUmUrQkMza0FLakl0?=
 =?utf-8?B?WlE1cThKbVluVTVPdDVYcDRNOUpjMTNMS1lkdU1pY2NvNUN0elNGSkYyN05u?=
 =?utf-8?B?V3ltYUhqQmh3Wk5Fb3F1QURabnArbzczbXFDMjJLdkxheXlSc1RVbGdzemxZ?=
 =?utf-8?B?YStIVkJMUWRacVdUZSttZlNGd29WZzNHZnB3dlNMWm1ucmg1aEJVcVpEazVK?=
 =?utf-8?B?bDBpUjRKR1FESnlOSWtucElJZmJvaXhkVCtGNE15RUJnN3hkZkNpNkV4ZlRz?=
 =?utf-8?B?T0owRGxMOTFlTUNKZG1lbGdJUHVyaU9wckc4Q0IzanhnMm95QmMyNm9PaG1t?=
 =?utf-8?B?VjVEaXpQTS9ZVEdTdmx4WEx6WmR4bENJVEtZMHFEVE90UmY3SitNOUZpMGZK?=
 =?utf-8?B?cXhVNU9JUktuUjhQYTRubHlGK1dNWnZ6OHZNZHhJZnJEbzloNjRTRmpzK3VM?=
 =?utf-8?B?eDNKYXBtbkZDWHZoUWNtR29PdVNIWVc1cnA2WlRRS1ZwbDBsaTdKZTVwOEpq?=
 =?utf-8?B?V09vK0E4L0xyNmhSREIrdm5zWkxjUHkvYjJaajBlYVNVeTVSeGxIcWV1UUtT?=
 =?utf-8?B?S2RJSlBKNW54ZzErSkVSdEx4WlNVb1VXWDZ0NEUrTE9RckZydjdROFVXdHpH?=
 =?utf-8?B?VmNDeXF0OWpvOUR0NlprdlRHTjgyUmlDWUpqTjhjTXIxQzJwRGNlc09RZGdY?=
 =?utf-8?B?MkkvdXNsVVRpdGZPRzdrTEYrU3VDcFVIYmZHbk1YeE5MdVAzd2J0eFFUN0c2?=
 =?utf-8?B?czR4cWE0MU1INHUrUEZHRDRyRUFJaXo5U1ZKekZCZjR5WlluTlp6WkJqRE9N?=
 =?utf-8?B?eC9XSlN5TDBmMUxvbE5UbWVjNWJJL3RWTzIvR0c2UVVqZW84VkEvMVFUWCtQ?=
 =?utf-8?B?d3VZMXBiSzNUYkY3K2xnZTFaUzRva25BeEZLRTNyZnZjOVl6ckUzM0NUNFBh?=
 =?utf-8?B?STlvTXZJU1JpQ0pDeTBrZUtwZDZUaUpUdk92MUFudUJaYnVTZGY3RVQ2dHdL?=
 =?utf-8?B?QUR2VnFXckJ2K1JVMzBiaG5NbnFPZE9BZDd6TjRwZkkvaExGVDdBVGsvalZG?=
 =?utf-8?B?N1VtaWVrc1BJZDB4SDd6RnVTcnY2R2ZDeVZFdGZuN0Q2NkNpM3pacGN0L3NQ?=
 =?utf-8?B?dFF3VUE1amZPK1FnZFpZWWxORGlKaW92TENCZTVHQXg1VGxQTEJnYWpscjFC?=
 =?utf-8?B?MEhKcjNaRzg5dlltdTJDM0pVOGhDeitjdjFiY3JjQWp3czdzaEMrNkZOQzRo?=
 =?utf-8?B?SGN2VUtHN3RpSithT2hNQzBWN04xTmZUSU5wcDdpVWl4WnNGU2ZWMlV1N1RF?=
 =?utf-8?B?N2puc3BFN2twVEpIVFp1S0NGV3VtN3F4TG41RUxrRzh5NnhLek5WVWkyS3RN?=
 =?utf-8?B?ck0yMU9haDV2emZyaXRKVGZpNGVKY0ZCeERBZE5xVGsrK3NlaWFSVjhjTExD?=
 =?utf-8?B?RU51ZnprSytJc1p6eXVmMDRwVStaQkJUMnozY0xxaTduY2NEVHBpenE1Wlp0?=
 =?utf-8?B?cjVKVVRISS96dlVFbUwrZTJsZlJ1TERWMXF1UUNLNmEwNDhrdlhvRVpVRUtF?=
 =?utf-8?B?WW9MSi9tSjQzeU9OYUErSjFoSjV3NlBuZkdpZGthVENDSXJ0dUprRVEySVJT?=
 =?utf-8?B?TlNKU24zbURJaFd2NkErMDE0Z2p3NDg2RVh0QzBvZ1ZEalJRR0xHa2lZQlV6?=
 =?utf-8?B?NGZRNkhYdFhnTDVrQ0dyRGUvUzMxdlpBSzk2aURNUHB0YWJKejlqNHJQMXNZ?=
 =?utf-8?B?cTc3bXh1bGd4K1FjU0FHVlFLelp2Z0YrbndCNnlERXVBOEEzSmhMTnlzTXEx?=
 =?utf-8?B?OUhzcytWSnF0Zmp3VExtV2NDQ1laU3JlSDBuUWRNcElYWFZuVC9na1J4V0FF?=
 =?utf-8?B?QU5XTnJYWWhLckI4MnMzdlRyajFldnBNazBWS0FGUlVVVUNXV2JPNXRIZnpv?=
 =?utf-8?Q?YwzY1tHQnCcLhhzcLbf9UbPDt?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: efab1d1d-9427-4dad-d5f0-08db4a569c61
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5115.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 May 2023 15:13:25.6277 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Knz+noIqnDXE0dnT7CoKoN8frdaZFpRA/7dD1zJEiXCjjn7p4UVHXM6qqncQTeXjJNl2cJj1mTJ5hPdzVqwCOQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6537
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

Am 2023-04-26 um 12:15 schrieb Alex Sierra:
> Accomplish this by reading the seq number right away instead of sleep
> for 5us. There are certain cases where the fence is ready almost
> immediately. Sleep number granularity was also reduced as the majority
> of the kiq tlb flush takes between 2us to 6us.
>
> Signed-off-by: Alex Sierra <alex.sierra@amd.com>

I'm not sure I have authority to give an R-b for this. But the change 
and the explanation sound reasonable to me. Doing the first check before 
waiting is a no-brainer. Reducing the delay can increase CPU usage or 
bus traffic and may be more controversial.

FWIW, this patch is

Acked-by: Felix Kuehling <Felix.Kuehling@amd.com>


> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c | 11 ++++-------
>   1 file changed, 4 insertions(+), 7 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c
> index a7627cc0118d..9192896239e9 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c
> @@ -377,14 +377,11 @@ signed long amdgpu_fence_wait_polling(struct amdgpu_ring *ring,
>   				      uint32_t wait_seq,
>   				      signed long timeout)
>   {
> -	uint32_t seq;
> -
> -	do {
> -		seq = amdgpu_fence_read(ring);
> -		udelay(5);
> -		timeout -= 5;
> -	} while ((int32_t)(wait_seq - seq) > 0 && timeout > 0);
>   
> +	while ((int32_t)(wait_seq - amdgpu_fence_read(ring)) > 0 && timeout > 0) {
> +		udelay(2);
> +		timeout -= 2;
> +	}
>   	return timeout > 0 ? timeout : 0;
>   }
>   /**
