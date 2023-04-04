Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3F198C6FD1D
	for <amd-gfx@archiver.kernel.org>; Tue,  4 Apr 2023 16:05:34 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DB41B10E6ED;
	Tue,  4 Apr 2023 16:05:33 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2051.outbound.protection.outlook.com [40.107.92.51])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6BE3710E6ED
 for <amd-gfx@lists.freedesktop.org>; Tue,  4 Apr 2023 16:05:31 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jNeD7yvOf/LIp+XrDQG+PJWniPYrXk+kmF0DLMoDhsV2Yx3qOVbIAlUMfbdrJ4dKwluCsZwppi/tMlyZqZjlSAvI8Gu3tdAbIsb/equiF1mVSNRYcMiLtxmFXm73PaQANZCdyHdbOhIQZJiBaaBTwm/yYQSC5yvjgt/mU2R38luW5vsdT7xZrP93wEtox0/4IVhBs0JY9+Vun6otw9MRr5ZJ99D4ex8VKfwUY4j9Iy+ZPAKEtj8zz1JwdU/ph3TOwm3XM2sNK/q0A3rDclnRYZ+3jiZUwa7Wldx8rG6tZuryTspJ80DkJpOZzxAYszABOQLCofkQy3cSEhLoU8n/6A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6jiKy9P+ZpLwVk7Xcf7/sWGrNGKCeb6gxt7a8D0dnt8=;
 b=HGe4rhqSmZQnKlWPsdGGhJs52DtScaDCFzNxQf95H3vB0jfY6nSIE0ZC0IEUz8Ssk6tEBL5T0c3SQmEE55WlPVJKSMgB4vOQNUtq1xRT7OeddMDI/Kq0S6cgsQCr1vHuSbo/iw1D9esbrfDS5WOXgdAjp9NZ+iNroFB6+W/70Bxtlrcuh8p9TGSBhocpGfH3UcDpaih/6wOybZmPM5t8u689fST4pXdCTY5u05YeWCCMrDy6Sfw3CRVgv6S+bYonwyLbPFjNiXxGugU3sP3biSG9TuMoUINrfjLP3OpB77QIjbBgHEuGf4UwWHdIopL7b9892Bs4lwetGiQArbH25Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6jiKy9P+ZpLwVk7Xcf7/sWGrNGKCeb6gxt7a8D0dnt8=;
 b=puhfXy9b5pitdOxpVePa9rLDJcL2k+31OaER29b+/DbMM6rxngyQ8i6ds0nbgS6OMWFt+NxNaMDxh2XaqSwBb6BlEPthUpF7Yg0FEe2nu9cCkd0lLfvbAx3L3aHz9Tug0X6valTgLb04Sol7uTCeLXMuBFFuNLAc+puvoKFJeig=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB3370.namprd12.prod.outlook.com (2603:10b6:5:38::25) by
 SN7PR12MB8604.namprd12.prod.outlook.com (2603:10b6:806:273::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6254.35; Tue, 4 Apr
 2023 16:05:28 +0000
Received: from DM6PR12MB3370.namprd12.prod.outlook.com
 ([fe80::8299:158a:c296:de80]) by DM6PR12MB3370.namprd12.prod.outlook.com
 ([fe80::8299:158a:c296:de80%6]) with mapi id 15.20.6254.033; Tue, 4 Apr 2023
 16:05:28 +0000
Message-ID: <e6accaab-de50-0cd4-10d8-0272fa93484b@amd.com>
Date: Tue, 4 Apr 2023 12:05:25 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
To: Shashank Sharma <shashank.sharma@amd.com>, amd-gfx@lists.freedesktop.org
References: <20230329160445.1300-1-shashank.sharma@amd.com>
 <20230329160445.1300-3-shashank.sharma@amd.com>
Content-Language: en-CA
From: Luben Tuikov <luben.tuikov@amd.com>
Subject: Re: [PATCH v3 2/9] drm/amdgpu: add usermode queue base code
In-Reply-To: <20230329160445.1300-3-shashank.sharma@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YT2PR01CA0024.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:38::29) To DM6PR12MB3370.namprd12.prod.outlook.com
 (2603:10b6:5:38::25)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB3370:EE_|SN7PR12MB8604:EE_
X-MS-Office365-Filtering-Correlation-Id: cfdc7ecf-cb89-4306-9434-08db35266871
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: x9/rwMDMl+VO7KYFe1I/MVaADJr4seYbF5njFYhRi16ItQJ/3/Ff1WUgV+bpuNBYt+8Ic2V/fFZqaxzKrbA/vuLUuiVBq5UYrE93kBf+xmdpvezmajWiFagUoImb0Qxko6X9YKmqfuGS1/XMj9hMSl5vdV39JYQXvGWEQXXsEUIHSzTpsLkg3jqeR1WjKcSgUmHmleHBxZEOtfVId/QHuDbF+GP/GOSJBYPdTB+KrJFU0e7NdYa+BqsqQZLym8Guf8BD976dlZAtdPTSkaiv8xRaQJc8A2nsCyy00K+k32m5FdSNpo2w1nLzDO77JA39WcPf1L0FVvh6eJF3nFs2nZz512IUkOwbRTpW572IN6TAAN7PEFWvyj0IyViADFjbRLPITN/1yfHlTzY3f8WE5DYjSWBslU7PX7nUGF8KYEjN7FX+wT8v226GA8CgBe2q1JFr9XgxgD4T2aeHOLJUq8iSsQ1z/ZFkHezI+kSb+KjeQIrlYmAX9u9v0TUN9iboJDGlzNKhHN+8Z4kd/IFvwmNqlqb22IXJq0KWWGGi+sYT5XDXmYz8KNGb94ZTc0HqUOdiYB6nrE3cfi0wRiTTK/Zz1SESUA5/F5TOVWuo80g=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB3370.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(4636009)(39860400002)(396003)(366004)(376002)(346002)(136003)(451199021)(186003)(26005)(6666004)(55236004)(53546011)(83380400001)(6512007)(6506007)(41300700001)(2616005)(54906003)(66946007)(478600001)(316002)(4326008)(66476007)(66556008)(6486002)(38100700002)(8676002)(36756003)(31696002)(86362001)(8936002)(2906002)(5660300002)(44832011)(31686004)(66899021)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?YUZmMmJWa3Y3aWQ2bXhJQVlVN2FSSittRnRuYzBkeTJMaVNVN3lVOTQvb1RT?=
 =?utf-8?B?elowekcwcEZBTTJPUENaTWxRek9VRDhaMmkwRjdrSERRL1BJUXB0YmRtdFBN?=
 =?utf-8?B?ZGpJb2FZb0EzWGFCb20yT1EyMDJ0VzBKUWtxT2pMVHpCUVYzbVZBS0x4UnR2?=
 =?utf-8?B?TkFSUzlsNXhFNEpQZEtxTEdCUVZYYmpWQ0tmMWFGWXo2WnNkeTZuc0VKazNz?=
 =?utf-8?B?OTgwcml1b0pGUFRmMkdrQ3UrNjlNQjlJdTJVWitnUThySjRDcVZZSTRyTHdn?=
 =?utf-8?B?dFhnUjVHbW5DM0VSSGx4YWJjUFNFNFN5OGhlZ2t6YU1BSG9YMmcvdmZDbXlK?=
 =?utf-8?B?Q1JBUmxWcHBROXNDbnhDb2QwRU5Lb01QK0RNSncreTJ3ZEwzQi9jaDRKZ2RM?=
 =?utf-8?B?c2l4TXU3aHJUelVuSmFUaHJYQk8wOXFqeTRBNURMdTN5KzZlSmdaR2dVSTFz?=
 =?utf-8?B?U1FtME9tREUwNG0xZ0JmRkFVQ3MrY1Z5eWdDZzMxTUdCNlVubjVmWTdOMjhD?=
 =?utf-8?B?bnRkY1hObjVHYXdhRnM3dU9Mam80WUlTY0Jmb0ExR1c0b1hOS0xFWTRwUDhU?=
 =?utf-8?B?RVpFZUh5dndSaHc4alIzaXNEQmpjUTZqWGdUNGNqMUl4Qk91WDA1eXhRVHZp?=
 =?utf-8?B?SFI4S1AzRG52cCtXY3BWSjRiVkp6ZnRpaWVGQTBLVjgzeXF3VG1UalpDTElB?=
 =?utf-8?B?Q3N2eWRxbjRKc3dsdUZhMnNNVW1XREtQY0F6V3FuY0RjbzNIRDRaeFJDa2FJ?=
 =?utf-8?B?am0vUDNPTHNBOUhSbEJ6NjNTT2d0V1pWblVKODNjQjlmZ3pST3pxT3l1NWlX?=
 =?utf-8?B?QjlKbFJ2RmdyYWdxREpaV1VJSlVMT0RiQnRscG1EN2lDODZEQ3ZVbllaYXBX?=
 =?utf-8?B?UmFobHMxQVdBbW8vK0xzZ3dOQnFrRFdKL0xTV1Q3Vkg1a0UvTlNjby9NQnl1?=
 =?utf-8?B?WlRtMkZha0FpQXFKazhPOGZ2ZjZQRGZTSkdLSHBHSkFpWit4V3FFd2dESGRw?=
 =?utf-8?B?Ti9VeTBmSGVWMUVpM0VQRCtZVkM4SU5LbW1tUnRXdlpLN2VwU1Fod2NWZHlM?=
 =?utf-8?B?ODhSYk5yK09nRkFnbVVZYWl0eFpCeW9rTkVENHVjM2hPaU5UamZGS2NlV24r?=
 =?utf-8?B?emVDVHoxOHR6TTJFcTBEMDVBZ0daQ1Bmd21EREh3T2ZKRkFqZzNqVk1EWHV0?=
 =?utf-8?B?SUhhMHpFVnhER1ZUdFdiSTkvZFAxMk10M014UDBHTlBCbWJwZnQzYlpsd2hh?=
 =?utf-8?B?R2ZXZ2d1VUdIbHk5bzQ0V3Z6RCtlOEtqN1hIOXIxN0duNk1Oa3RqeU5oVzdu?=
 =?utf-8?B?NExIUktFTEhwOEJ6dG5SN0NUNEIrNU01VXYwOSt2Y21CdVVkN2hOdk9xTGtQ?=
 =?utf-8?B?TENHTWtGVVNJUG9BY3Q0dHdWYzVLamtJTDRJRnozcVZmTHUwdXgxUFNYODBy?=
 =?utf-8?B?NStLZm1iUTI4RUhGVE1DQ2Q3Y0ZXR05DZ2w1cDBwZDVoNDdtamZkaDBhZkVo?=
 =?utf-8?B?aUdUSUlSM1BqbkFubU5jU2NQR2ZzSFljVjMreHdZNWNSMHZnQlRvZ1dYK1Ix?=
 =?utf-8?B?RTlQMnlKaFFuQXpkaWZ0bUpuTmNkOHBRbW5xUE5BOXM4Q3p0Z2cwV29ZRW9h?=
 =?utf-8?B?QVY5Q09XbUhQODRWcDl1emJqM1MwWmUxekFJMnlqNmNFb1crV3J5ZlI4eE83?=
 =?utf-8?B?RE1SZkdrR2M3eDhNVWgzR1dmZ2pBUENJQm53Ym56VXM0TXJEL2U5QkFwREZt?=
 =?utf-8?B?YVlMeVZPdlhlYWdONkEvcFNrUk1mV2dscXQxd01qNnZURU5OR1lEWW55NDJ4?=
 =?utf-8?B?VHoraHFGemluU0kwL09vcWo3QSttWXhqbDhlTFVGdnZHTG1IeHhNLzBMNi9o?=
 =?utf-8?B?eHQ3a08zZHNmZUVzdWxSTGlTTmM0ZGh2SzdRRm13MXBNeld5YzNWeHY3MnE0?=
 =?utf-8?B?b1czaXh1ZVc2blRHSjJRQ2dyTG9JazBBNDRyL3FlbnpBdEo1T2N3VWFWUzRQ?=
 =?utf-8?B?OWl2aERRenVCZmVrQWx2M1lIdGRzeVpPVmlqSXJsQXJCT1U0MW44VGVFYkRB?=
 =?utf-8?B?YWxuTk9aa1M2dlRxalRSUFlIUmJVbnFGWnhuZU1pbU93elVpTXh5amV0b3Vi?=
 =?utf-8?Q?aY7Ptds+TxgBc4V52UyxGTr2a?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cfdc7ecf-cb89-4306-9434-08db35266871
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3370.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Apr 2023 16:05:28.2244 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vPCwO7KEzeqa4NE8ITJOPGJqMKqzQY3CVwE2P+1yMtto9H2r7xSWjLEt2wtvZEJj
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB8604
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
Cc: Alex Deucher <alexander.deucher@amd.com>,
 Felix Kuehling <felix.kuehling@amd.com>,
 Shashank Sharma <contactshashanksharma@gmail.com>,
 Christian Koenig <christian.koenig@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On 2023-03-29 12:04, Shashank Sharma wrote:
> From: Shashank Sharma <contactshashanksharma@gmail.com>
> 
> This patch adds skeleton code for amdgpu usermode queue. It contains:
> - A new files with init functions of usermode queues.
> - A queue context manager in driver private data.
> 
> V1: Worked on design review comments from RFC patch series:
> (https://patchwork.freedesktop.org/series/112214/)
> - Alex: Keep a list of queues, instead of single queue per process.
> - Christian: Use the queue manager instead of global ptrs,
>            Don't keep the queue structure in amdgpu_ctx
> 
> V2:
>  - Reformatted code, split the big patch into two
> 
> V3:
> - Integration with doorbell manager
> 
> Cc: Alex Deucher <alexander.deucher@amd.com>
> Cc: Christian Koenig <christian.koenig@amd.com>
> Signed-off-by: Shashank Sharma <contactshashanksharma@gmail.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/Makefile           |  2 +
>  drivers/gpu/drm/amd/amdgpu/amdgpu.h           | 10 +++-
>  drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c       |  1 +
>  drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c       |  6 +++
>  drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.c | 39 +++++++++++++++
>  .../gpu/drm/amd/include/amdgpu_userqueue.h    | 49 +++++++++++++++++++
>  6 files changed, 106 insertions(+), 1 deletion(-)
>  create mode 100644 drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.c
>  create mode 100644 drivers/gpu/drm/amd/include/amdgpu_userqueue.h
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/Makefile b/drivers/gpu/drm/amd/amdgpu/Makefile
> index 204665f20319..2d90ba618e5d 100644
> --- a/drivers/gpu/drm/amd/amdgpu/Makefile
> +++ b/drivers/gpu/drm/amd/amdgpu/Makefile
> @@ -210,6 +210,8 @@ amdgpu-y += \
>  # add amdkfd interfaces
>  amdgpu-y += amdgpu_amdkfd.o
>  
> +# add usermode queue
> +amdgpu-y += amdgpu_userqueue.o
>  
>  ifneq ($(CONFIG_HSA_AMD),)
>  AMDKFD_PATH := ../amdkfd
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> index 6b74df446694..c5f9af0e74ee 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> @@ -438,6 +438,14 @@ struct amdgpu_sa_manager {
>  	uint32_t		align;
>  };
>  
> +/* Gfx usermode queues */
> +struct amdgpu_userq_mgr {
> +	struct idr userq_idr;
> +	struct mutex userq_mutex;
> +	struct amdgpu_device *adev;
> +	const struct amdgpu_userq_funcs *userq_funcs[AMDGPU_HW_IP_NUM];
> +};
> +

Could you align the member names to the largest member's column,
as opposed to having only a single space in between?

It makes it so much more readable.

>  /* sub-allocation buffer */
>  struct amdgpu_sa_bo {
>  	struct list_head		olist;
> @@ -470,7 +478,6 @@ struct amdgpu_flip_work {
>  	bool				async;
>  };
>  
> -
>  /*
>   * file private structure
>   */
> @@ -482,6 +489,7 @@ struct amdgpu_fpriv {
>  	struct mutex		bo_list_lock;
>  	struct idr		bo_list_handles;
>  	struct amdgpu_ctx_mgr	ctx_mgr;
> +	struct amdgpu_userq_mgr	userq_mgr;
>  };

Like here, and pretty much the rest of the kernel code.

>  
>  int amdgpu_file_to_fpriv(struct file *filp, struct amdgpu_fpriv **fpriv);
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> index b4f2d61ea0d5..2d6bcfd727c8 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> @@ -52,6 +52,7 @@
>  #include "amdgpu_ras.h"
>  #include "amdgpu_xgmi.h"
>  #include "amdgpu_reset.h"
> +#include "amdgpu_userqueue.h"
>  
>  /*
>   * KMS wrapper.
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
> index 7aa7e52ca784..b16b8155a157 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
> @@ -43,6 +43,7 @@
>  #include "amdgpu_gem.h"
>  #include "amdgpu_display.h"
>  #include "amdgpu_ras.h"
> +#include "amdgpu_userqueue.h"
>  
>  void amdgpu_unregister_gpu_instance(struct amdgpu_device *adev)
>  {
> @@ -1187,6 +1188,10 @@ int amdgpu_driver_open_kms(struct drm_device *dev, struct drm_file *file_priv)
>  
>  	amdgpu_ctx_mgr_init(&fpriv->ctx_mgr, adev);
>  
> +	r = amdgpu_userq_mgr_init(&fpriv->userq_mgr, adev);
> +	if (r)
> +		DRM_WARN("Can't setup usermode queues, only legacy workload submission will work\n");
> +
>  	file_priv->driver_priv = fpriv;
>  	goto out_suspend;
>  
> @@ -1254,6 +1259,7 @@ void amdgpu_driver_postclose_kms(struct drm_device *dev,
>  
>  	amdgpu_ctx_mgr_fini(&fpriv->ctx_mgr);
>  	amdgpu_vm_fini(adev, &fpriv->vm);
> +	amdgpu_userq_mgr_fini(&fpriv->userq_mgr);
>  
>  	if (pasid)
>  		amdgpu_pasid_free_delayed(pd->tbo.base.resv, pasid);
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.c
> new file mode 100644
> index 000000000000..13e1eebc1cb6
> --- /dev/null
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.c
> @@ -0,0 +1,39 @@
> +/*
> + * Copyright 2022 Advanced Micro Devices, Inc.
> + *
> + * Permission is hereby granted, free of charge, to any person obtaining a
> + * copy of this software and associated documentation files (the "Software"),
> + * to deal in the Software without restriction, including without limitation
> + * the rights to use, copy, modify, merge, publish, distribute, sublicense,
> + * and/or sell copies of the Software, and to permit persons to whom the
> + * Software is furnished to do so, subject to the following conditions:
> + *
> + * The above copyright notice and this permission notice shall be included in
> + * all copies or substantial portions of the Software.
> + *
> + * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
> + * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
> + * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.  IN NO EVENT SHALL
> + * THE COPYRIGHT HOLDER(S) OR AUTHOR(S) BE LIABLE FOR ANY CLAIM, DAMAGES OR
> + * OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE,
> + * ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
> + * OTHER DEALINGS IN THE SOFTWARE.
> + *
> + */
> +
> +#include "amdgpu.h"
> +
> +int amdgpu_userq_mgr_init(struct amdgpu_userq_mgr *userq_mgr, struct amdgpu_device *adev)
> +{
> +    mutex_init(&userq_mgr->userq_mutex);
> +    idr_init_base(&userq_mgr->userq_idr, 1);
> +    userq_mgr->adev = adev;
> +
> +    return 0;
> +}
> +
> +void amdgpu_userq_mgr_fini(struct amdgpu_userq_mgr *userq_mgr)
> +{
> +    idr_destroy(&userq_mgr->userq_idr);
> +    mutex_destroy(&userq_mgr->userq_mutex);
> +}
> diff --git a/drivers/gpu/drm/amd/include/amdgpu_userqueue.h b/drivers/gpu/drm/amd/include/amdgpu_userqueue.h
> new file mode 100644
> index 000000000000..7eeb8c9e6575
> --- /dev/null
> +++ b/drivers/gpu/drm/amd/include/amdgpu_userqueue.h
> @@ -0,0 +1,49 @@
> +/*
> + * Copyright 2022 Advanced Micro Devices, Inc.
> + *
> + * Permission is hereby granted, free of charge, to any person obtaining a
> + * copy of this software and associated documentation files (the "Software"),
> + * to deal in the Software without restriction, including without limitation
> + * the rights to use, copy, modify, merge, publish, distribute, sublicense,
> + * and/or sell copies of the Software, and to permit persons to whom the
> + * Software is furnished to do so, subject to the following conditions:
> + *
> + * The above copyright notice and this permission notice shall be included in
> + * all copies or substantial portions of the Software.
> + *
> + * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
> + * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
> + * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.  IN NO EVENT SHALL
> + * THE COPYRIGHT HOLDER(S) OR AUTHOR(S) BE LIABLE FOR ANY CLAIM, DAMAGES OR
> + * OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE,
> + * ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
> + * OTHER DEALINGS IN THE SOFTWARE.
> + *
> + */
> +
> +#ifndef AMDGPU_USERQUEUE_H_
> +#define AMDGPU_USERQUEUE_H_
> +
> +#include "amdgpu.h"
> +#define AMDGPU_MAX_USERQ 512
> +
> +struct amdgpu_usermode_queue {
> +	int queue_id;
> +	int queue_type;
> +	uint64_t flags;
> +	uint64_t doorbell_handle;
> +	struct amdgpu_vm *vm;
> +	struct amdgpu_userq_mgr *userq_mgr;
> +	struct amdgpu_mqd_prop userq_prop;
> +};

Could you align the member names to the largest member's column,
as opposed to having only a single space in between?

It makes it so much more readable.

> +
> +struct amdgpu_userq_funcs {
> +	int (*mqd_create)(struct amdgpu_userq_mgr *, struct amdgpu_usermode_queue *);
> +	void (*mqd_destroy)(struct amdgpu_userq_mgr *, struct amdgpu_usermode_queue *);
> +};

Here too, align to the largest column.

Regards,
Luben

> +
> +int amdgpu_userq_mgr_init(struct amdgpu_userq_mgr *userq_mgr, struct amdgpu_device *adev);
> +
> +void amdgpu_userq_mgr_fini(struct amdgpu_userq_mgr *userq_mgr);
> +
> +#endif

