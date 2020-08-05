Return-Path: <SRS0=KaZi=BP=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11E82C433E0
	for <amd-gfx@archiver.kernel.org>; Wed,  5 Aug 2020 20:37:06 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AA668206D4
	for <amd-gfx@archiver.kernel.org>; Wed,  5 Aug 2020 20:37:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="HvIqd//K"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AA668206D4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5F68089C84;
	Wed,  5 Aug 2020 20:37:05 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2055.outbound.protection.outlook.com [40.107.220.55])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5D3EE89C84
 for <amd-gfx@lists.freedesktop.org>; Wed,  5 Aug 2020 20:37:04 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MNG2jen1lovuIHq0s+lItfcpHDunGd25auOkGlUniFJkSmKwUazCTzb8P2Fa8qAGAF2dIyEpkYfyKz3EpdeiggtzQdcktr0QKMSSfnjMmYFUa/SSiTNllxTIaNtjIvPsPfud4R1ovvB5zX5yhBFGZIM9LaumISBLplqvwI1Qk6m2oM1bXp/VxEYmvTeI/HvHeysa6S2gH/NBlngMQl08Z4HsNJ5YiucOuT+R5syGqbVN06R+IyRW3rELptvfigA9mcbPaknLtlp9IJAR+LGdRq1Y9zs2CiLQFv4SezYAsn1o1XEJBm4woZnwLpeQVYRdKUAfO7zlkZ0ENfcmC9qF8Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uBL3fXo5Edg1qZLLa+C1YPIkGqRyZg1iTuzgQVMwqUQ=;
 b=UbfT6KrBonOKZ2py5kv0IF20utuOtWoovquije3L+jtt2BIpFmTjW9akiQe77hc4KMGq6LmvgCGCdTRxbNSAAwgGQZQX9foNGvTeHzCOKH597mau27yz2UMxCLgjnThRF8WMKCjFikUxWosyzwxN1WRHO0wT0p/oThTgV9M64f7CAbpDxzQl5JJY/mZ8EqA/Um0QqVAY3LQB9wbx13Vl+mBRExxbOT70k1hFVVnSL4I9Kkf/a+xYvkmnr2BkWrfZ7Cfj+xnJse0URVBygfGVKa1+g+QvTItplCP0PK87Z4DI7FGYyO2O8S4ej01ilLdjWIuTqjWDOI4TnKMMNFsGBQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uBL3fXo5Edg1qZLLa+C1YPIkGqRyZg1iTuzgQVMwqUQ=;
 b=HvIqd//KZLemkRWKZluA+X7Bg+Xy+VJaXyiadoyqyUBrm0MbFbaaOouonhpa7NrFaG8xeIqW4xnLFqxqHdk6ooCijJVNHZkPN89f0ikM/cF7JDDCUsPRXKZ0sSioh/RZDLYV1BRHZLgLkUVCcDSdsEe6GhbKHgAHdCszHSb3PxM=
Authentication-Results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB3962.namprd12.prod.outlook.com (2603:10b6:5:1ce::21)
 by DM6PR12MB2889.namprd12.prod.outlook.com (2603:10b6:5:18a::26) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3239.20; Wed, 5 Aug
 2020 20:37:02 +0000
Received: from DM6PR12MB3962.namprd12.prod.outlook.com
 ([fe80::3452:6d8f:e0ef:b45e]) by DM6PR12MB3962.namprd12.prod.outlook.com
 ([fe80::3452:6d8f:e0ef:b45e%6]) with mapi id 15.20.3239.022; Wed, 5 Aug 2020
 20:37:01 +0000
Subject: Re: [PATCH] drm/amdgpu: unlock mutex on error
To: Dennis Li <Dennis.Li@amd.com>, amd-gfx@lists.freedesktop.org,
 Alexander.Deucher@amd.com, Tao.Zhou1@amd.com, Hawking.Zhang@amd.com,
 Guchun.Chen@amd.com
References: <20200805084146.25788-1-Dennis.Li@amd.com>
From: Luben Tuikov <luben.tuikov@amd.com>
Message-ID: <294c9e68-7188-d16d-c19d-6e23012de919@amd.com>
Date: Wed, 5 Aug 2020 16:36:59 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.1.0
In-Reply-To: <20200805084146.25788-1-Dennis.Li@amd.com>
Content-Language: en-CA
X-ClientProxiedBy: YTXPR0101CA0050.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b00:1::27) To DM6PR12MB3962.namprd12.prod.outlook.com
 (2603:10b6:5:1ce::21)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost.localdomain (165.204.55.250) by
 YTXPR0101CA0050.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b00:1::27) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3239.16 via Frontend
 Transport; Wed, 5 Aug 2020 20:37:01 +0000
X-Originating-IP: [165.204.55.250]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 573fafba-0e9d-4850-d0b0-08d8397f4ea7
X-MS-TrafficTypeDiagnostic: DM6PR12MB2889:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR12MB288927DD203F7C07AD7EDE7B994B0@DM6PR12MB2889.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5516;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: o/1ZbeSpmVogriTiscw0ElDYOxw3GgSAYttqPqbTNeFpJr2vL1La1ARC7/muOG6lv3pP2E+FT0+VGYtzYpSF/ZgCf9ILXr6UgrT+r0PLiE9nFO72OsO8tEzMpT4O+Q7ER3ZIod1CNlYsG9UQJUPHQN3nA8gmKcZE4rjJDxROOnAT/qfrd5EL7nfyi3FSTeizZPS+d35AkFHjfzq+/d0TPtl/Gsgl4FCNdCjd7RJCshk405hEEOFeDffxcuYOAHzi2NvL6MhyjO9DEKaDkd40yux6jpFpwrM1dbxvqqnU/3Hh4pmofEfYmPgPFVu05PSJTn0pI1O+ps+UWUoPw7Bz1QEAWmBwHnZfbcXI/QzE8eVPkWBeTbv3lurpj3ykbn5n
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB3962.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(366004)(396003)(376002)(136003)(346002)(39860400002)(44832011)(2616005)(956004)(26005)(52116002)(53546011)(6506007)(6636002)(6512007)(83380400001)(31686004)(86362001)(8676002)(2906002)(5660300002)(31696002)(478600001)(6486002)(186003)(16526019)(36756003)(66556008)(66476007)(316002)(66946007)(8936002)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: 309a43IeFkH215x/JaO0wx40b0jzRJrvW6s6BhrekWh6U0UCOJE0z3OFhxVpJMEbxQ5/l4cem4Qi8ylXOHero+IvUNGyvQRkQX2OXa3fLbMtOspGcOP/+F4xFKW5I/ICTBYO5FjUOVqjXS+o8nnsPo3ffXIh48fmW9oeC2tG2dm/WeoWEpueSRssUSVjG/vmwB91cbFlETxV3Ab0AbDeoH7alVfVbLgxcY78Mxlw0jy1yCpDLVF13Cc9hhKoazGMRMGTPZYEB+JwvPp2rRGJXYKy1JNmOZu2wyVe8HltYK+2gnxgE0eSfSQoMRiXK4BT6GZjM6fWZKOIZPhBaHR5D2VKXfxCXXg3XnWCTl9aQxveVYwCMaUnhBWIHQuV9XSZo/panvhmedE2fiQ8+iEFwlN2Cw5twNkpNDFCRP0jjM4j22qfHK9meSXv3qFYllLWSSXIn0ntXqffnddVxr1nggK86IGeggzghZPtYlkXnewMhQRH6JUMiYAOv+XgFwYUCiFAxjctFrvNr6dHML+v2tMX0B+uPMHSXX/4b5kRlRSs65/T9ifZ75RXEprzohME1Pn6WWo0FsObdZ6joJdEeTead5NILlcx3JJIYULOmCSFKVGdvjgrFMqQ7jSHTvTD15WCWyl2fwTZy5mAM/i6aw==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 573fafba-0e9d-4850-d0b0-08d8397f4ea7
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3962.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Aug 2020 20:37:01.7585 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3sZUB8WoxS6CU/jmpkzOWWnp5QN8JoVipeRgbr6nz5Gm2VoOFXZi102PA7FiOS3M
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB2889
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On 2020-08-05 4:41 a.m., Dennis Li wrote:
> Make sure unlock the mutex when error happen
...........^(to).............................(.)

Regards,
Luben

> 
> Signed-off-by: Dennis Li <Dennis.Li@amd.com>
> Change-Id: I6c36a193df5fe70516282d8136b4eadf32d20915
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
> index a0ea663ecdbc..5e5369abc6fa 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
> @@ -632,13 +632,14 @@ int amdgpu_amdkfd_submit_ib(struct kgd_dev *kgd, enum kgd_engine_type engine,
>  	}
>  
>  	ret = amdgpu_ib_schedule(ring, 1, ib, job, &f);
> +
> +	up_read(&adev->reset_sem);
> +
>  	if (ret) {
>  		DRM_ERROR("amdgpu: failed to schedule IB.\n");
>  		goto err_ib_sched;
>  	}
>  
> -	up_read(&adev->reset_sem);
> -
>  	ret = dma_fence_wait(f, false);
>  
>  err_ib_sched:
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c
> index 4e017f379eb6..67a756f4337b 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c
> @@ -545,7 +545,7 @@ int amdgpu_xgmi_add_device(struct amdgpu_device *adev)
>  			}
>  			ret = amdgpu_xgmi_update_topology(hive, tmp_adev);
>  			if (ret)
> -				goto exit;
> +				goto exit_unlock;
>  		}
>  
>  		/* get latest topology info for each device from psp */
> @@ -558,7 +558,7 @@ int amdgpu_xgmi_add_device(struct amdgpu_device *adev)
>  					tmp_adev->gmc.xgmi.node_id,
>  					tmp_adev->gmc.xgmi.hive_id, ret);
>  				/* To do : continue with some node failed or disable the whole hive */
> -				goto exit;
> +				goto exit_unlock;
>  			}
>  		}
>  	}
> @@ -566,7 +566,7 @@ int amdgpu_xgmi_add_device(struct amdgpu_device *adev)
>  	if (!ret)
>  		ret = amdgpu_xgmi_sysfs_add_dev_info(adev, hive);
>  
> -
> +exit_unlock:
>  	mutex_unlock(&hive->hive_lock);
>  exit:
>  	if (!ret)
> 

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
