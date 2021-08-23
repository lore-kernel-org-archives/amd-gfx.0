Return-Path: <SRS0=mBQi=NO=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-19.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D92FC4338F
	for <amd-gfx@archiver.kernel.org>; Mon, 23 Aug 2021 20:26:34 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 203D260E97
	for <amd-gfx@archiver.kernel.org>; Mon, 23 Aug 2021 20:26:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 203D260E97
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C1BDA89A44;
	Mon, 23 Aug 2021 20:26:33 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2046.outbound.protection.outlook.com [40.107.236.46])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5818389A44
 for <amd-gfx@lists.freedesktop.org>; Mon, 23 Aug 2021 20:26:32 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DywcH/nGgPKJHb5mUfS2G6Kkx1B4igBeHZ5IQ++ythEDBmhomaCkFfqeuqmDIr1vCDsXxQvyRKnBefqKbBJEUK4W3OcA+yAJ64QIX1t7MD9sKDTm2bsg+YcaK2Rp3H9KX49ySQBYV0HSouqH0NkO66t7Pgiphhuj9mtclFHSttGDpY1boHr7j0h/6HVb4WIuywQMpI/iUEED4ZJ7WwdFXFTniDrBuuf0UmlJb6Xjmx1yq9Y/P/CROMhEOy1i9JKilifVUMotJmF9/WMC3fI5CE1PYE8t3vD4A9EEROUnuuM39VaGLOQRQ69IqDw0dtFshSyD7UBwQbFTFEwehbVUtQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GcUhE8STDN1XnGQR+5QDQYWs+4C/IFDjYvUqAluaWRQ=;
 b=UgLCvH1CfeInzqWqfsWOtimShF+YOwq4g/S9SKGjoc68Hca3AJpKAZT/mM+rJl3pLGS2WDMW2kPvMslxE6jA29rbd5NrwqKdYO+UqUBp36VFHEr/yCwUbBtM8V0A/LsYEG+oo/0E4ivVmepZ4f/Cbdt2ELwx67cTbiIcBDyz+OjeATuDwBBl6T01sWFHULNa9DIIuUEXbumM73bPymRqizFlt9XV3UROX19eyC5CVFldN4VWal1l5nu+fEdTCfqWRaVCm/S0GBNk1KihHq2pkFrdOWXWfZSZNhwz50R9RDzqC0I9XcOLBJwKav4W5jlZHbRe+GeZsUApYoAnPGvkqg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GcUhE8STDN1XnGQR+5QDQYWs+4C/IFDjYvUqAluaWRQ=;
 b=S9JOjnp/XsTxsY36Vd0p0dgsWRwdhjJHPZlwSGm6jlEU9vUA8uHSCxhfJHXIPOwxotltx/yxdFxmJBryvUR40wdy+pl4EMH/6ZnMOQtyFpSzu4BP2whnAiLFAUzHMvMSfy2pvZQVkB/H4/bg5BJUOdLqQpkxOSMcOKjwWzUO1ZM=
Authentication-Results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
Received: from BN9PR12MB5129.namprd12.prod.outlook.com (2603:10b6:408:136::12)
 by BN9PR12MB5193.namprd12.prod.outlook.com (2603:10b6:408:11a::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4436.19; Mon, 23 Aug
 2021 18:53:27 +0000
Received: from BN9PR12MB5129.namprd12.prod.outlook.com
 ([fe80::b891:a906:28f0:fdb]) by BN9PR12MB5129.namprd12.prod.outlook.com
 ([fe80::b891:a906:28f0:fdb%3]) with mapi id 15.20.4436.024; Mon, 23 Aug 2021
 18:53:27 +0000
Subject: Re: [PATCH 05/18] drm/amdkfd: CRIU Implement KFD dumper ioctl
To: David Yat Sin <david.yatsin@amd.com>, amd-gfx@lists.freedesktop.org
Cc: rajneesh.bhardwaj@amd.com
References: <20210819133713.4168-1-david.yatsin@amd.com>
 <20210819133713.4168-6-david.yatsin@amd.com>
From: Felix Kuehling <felix.kuehling@amd.com>
Message-ID: <12e84b3a-cfbf-fda6-2596-43a762200e4b@amd.com>
Date: Mon, 23 Aug 2021 14:53:25 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
In-Reply-To: <20210819133713.4168-6-david.yatsin@amd.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-ClientProxiedBy: YT1PR01CA0007.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01::20)
 To BN9PR12MB5129.namprd12.prod.outlook.com
 (2603:10b6:408:136::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.2.100] (142.186.47.3) by
 YT1PR01CA0007.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01::20) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4436.19 via Frontend Transport; Mon, 23 Aug 2021 18:53:27 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e2c943b4-c392-4e7e-d9f8-08d966674ad5
X-MS-TrafficTypeDiagnostic: BN9PR12MB5193:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BN9PR12MB5193C9C777A299FD7155C02292C49@BN9PR12MB5193.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2399;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: afogDrRGgBhS7JfJOCTQ9iPdHJb2R0FAS9T2PqS2C0Q/zAnY7osxmxteOBw9xABnndztS5X80ddz3dT0d40pIX5iQ1t9H7mzcz+2ptVZVRjb3r9oxm2HyaWbR/3Kjc/qK8NtaJZE46EBscapGROoLJe+6rxzCf5R9WdCANmanyz2U+mEveDuxwgd2vSgA7n2R6jpBgC/kKi+o91KqWay0OGe2ClwustMrO+WQ4xNBoSLJz/ysYikOuuY8pUJxotWkPY1SLNY6p0qL146xHdCe4VrPpdrOz61VoHUedSNGg+rxhJuSqmCK3z49scIGzSzQskTcmaVoNg5w3Qq64g1/ad443NWtNkeDKF4Qt8P2d+PndAKucKzts6ohfv6st2R2Zxc721NFBKYIwuYx3rz5ErOl7rB4ym04aIiwkZ2jvu4pimeBjIu1KOwGPxEkOzQlmB9QPoAWNNGaEFL9jLX1UpZOyuNk0SBLfzNRdDS4l+A8R/YSzkOHzc3OMGN3IezjgfKxzCf8PIXXmSYKjIgHnb40McAYWaJHm+MwcqH4K0f5L092tRsjXSeAEBNXauQ5mhE22gdrnBPsnnYZQ0a4dXgMdwfP3z8oxnjYyNBnaFuoQJconP0Rtq1TLbrHLmMhxd7MeFzllijqtn4Y/UGSTPVPBqHdF6l04HbrKETPxZI/mtoNmSpPpx02c36XfksSrNzVDH3UCjOylNeFGDisNCAP/h6z5VRIR2oRGBDLAA=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5129.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(346002)(396003)(376002)(366004)(136003)(39860400002)(38100700002)(2906002)(8936002)(26005)(44832011)(31696002)(2616005)(956004)(86362001)(83380400001)(66946007)(6486002)(66556008)(66476007)(8676002)(16576012)(31686004)(36756003)(316002)(478600001)(4326008)(5660300002)(186003)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WlExREpPRUw3dzlxVFlqQllIMEQxQTFURmcwVU9BbzBlZGFVYkFYaUEyKzBW?=
 =?utf-8?B?OHI4WHZhelNBSFpmUDdyT3NVN0Ywd256dnFtWk51b25TTERaWjFobU9xWmp2?=
 =?utf-8?B?UVNKUG8xL2xaSkkvVDFHTmdtL0RWSHozSDZxcG94L09GWGNoaG50U2sydm1m?=
 =?utf-8?B?cHdYUFd5bU1TQlhoNWpUY3Z5ZnNUakpHYkFPVUJmYXZUYm10czVJR1ozbWRY?=
 =?utf-8?B?SVpnd2loNWpka2o3VjZIOVJWR3FjR2lveStxcjA0b05USmJxdURkdkZDZ1or?=
 =?utf-8?B?YWQ5T3dTaGs2dCs5TkQ2aXpaOUxJOEs4YU1vQmlMT0ZVdWt5NHZCdU0zWk9j?=
 =?utf-8?B?Yk5rMU82ckVDSDZ1aVNCNjROUWlIalJoSS8rN2VOT3BvSGdPOGtHU243U0lz?=
 =?utf-8?B?d21UZXEvV1pqeGl0Zk9jNkFHbk9FZEhzWlFDZ3l2WFNoSldWR0wvaTB4cG56?=
 =?utf-8?B?RGpXOGc2MzZicFJPcmJFZ0NHY0IxbXZPckRheXFOSWdVZ01YdndNSkpYMCtk?=
 =?utf-8?B?M0U1ajQzNE5mdlNrbU9mTEJYUDBEMmFxNi9BSDZLcWlyTXgvY3JDMVRSUHVn?=
 =?utf-8?B?ZDdxVzV4ZXpCOTNVcGJ3Ny9FZ3FoWVhOWW4vQlBBVm1xamRCbkw2dEtCQXZk?=
 =?utf-8?B?WEY4T3c1UUZHZldqK1lZck40ODEzZm5ScW9veUwySnIyQldETHhpbFE0U21T?=
 =?utf-8?B?Y3NJWk9KQ3hhVmVUUzRmSndPZkxoSE40aExEUDlKMGpNVEN2OVhscHM4cTNP?=
 =?utf-8?B?ZUF0emlTUmlwZDNmLzUrME1PK2FLR2t1Z05JZVhDNEpueHdOd0RFSGFMdFFh?=
 =?utf-8?B?d0tBbmkvQmZZVDZNbm9RRllMeWR5VnpZUFF5NWtVWnpjZDZERWJHakRMdHpt?=
 =?utf-8?B?N0xEUzZUOWQ3UGFwaTZ2RWx5VWorLy9MWWJuZjRLV3hiRUhxSGxzdm9qSkQ5?=
 =?utf-8?B?YnBlbTNUT1VIWG5KNmtqblVwR1hFZ3YvVjhTaG1veVhtZzlUb2FtV2NNWFRo?=
 =?utf-8?B?Uk1iQ216VFBLZE9QbHNvV2RUWnNYSUN3ekYyQmhJVVdBVG83ZWJEQkxxRHox?=
 =?utf-8?B?V3Bzd0N0bHUrd2hVOFhueDF1Y2hjcWNZNUI2YTV0NDZQU2M5ZjFnaDBHRStw?=
 =?utf-8?B?N09ncFV2QmtKL0RwTm1ENHI4bnVvdlVZTUFZbkRieWxoL0pBZzVJRDZ0OGkv?=
 =?utf-8?B?LzE1bXhTdVBEd2RUd2VIeE85Q094MTBWWklmdU9HcUx6RzFQb0N2R2hUb1M3?=
 =?utf-8?B?aHVaTkt2TmJ2WW4rbG5jcFVxYU9kalJqYTlNY0RvWWZFYmhPcWVYblByZVZO?=
 =?utf-8?B?SGZoR3FaMlM3VFlwODk3Q09UT1NrQkMvUHZ6OHdMa2JncVV2Z2xaeXRlZGRO?=
 =?utf-8?B?c050dDBDc1dvSnNYZ01HZXMrdFNqNEpzNm1BNWFVc1ZGR3pGMjJSZzVCdFpQ?=
 =?utf-8?B?VWgzM0hVS2lJUzAzNDUrNWNvMVd4RTMvbWc2djBTdFVvVy9iNytmZ3ZaZnVu?=
 =?utf-8?B?TGl1NlU1WlM0dmNNNGJ5SXh3cENXL09GdjhwYTAxNitjaVUyU2xLMUdjMWgw?=
 =?utf-8?B?RWg0ajB5bThDaVRQTTc2MXMwQWI3WFVnSUowSlZHMXRDYllWdDBXb1QwQjZj?=
 =?utf-8?B?ZVUvNWRLZVBqSWtpSVE4UzNKR3hSM0lpRk00aUpzS08rWUd0NVJlZGUycFRw?=
 =?utf-8?B?RXA1RkNyY2NHLysxZVB2ZENxODV2VjlOUXNvb3JxeDVseHY3UWRURXpsNVlL?=
 =?utf-8?Q?UVxWSdNslX2Ax/wWmRLMjEh0BUWmnoLfZo4OhMC?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e2c943b4-c392-4e7e-d9f8-08d966674ad5
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5129.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Aug 2021 18:53:27.4133 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: imXXEzV/v9Dj3Z505xj7PRFEDZlWDQRdqrTWAonLnEUppEgIl39oGD7S9N3OSMonU3St/HGuE433v2CU2GbsWw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR12MB5193
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

You haven't implemented objects_index_start yet. I think this is only
important later on for dumping BOs with dmabuf handles to avoid
exhausting the file-descriptor limit. For now, there should at least be
a check for objects_index_start == 0. We can fail if it's not 0 and
implement that support later. But allowing non-0 values now without
implementing them could lead to ABI breakages later on.

Regards,
  Felix


Am 2021-08-19 um 9:37 a.m. schrieb David Yat Sin:
> From: Rajneesh Bhardwaj <rajneesh.bhardwaj@amd.com>
>
> This adds support to discover the  buffer objects that belong to a
> process being checkpointed. The data corresponding to these buffer
> objects is returned to user space plugin running under criu master
> context which then stores this info to recreate these buffer objects
> during a restore operation.
>
> Signed-off-by: David Yat Sin <david.yatsin@amd.com>
> Signed-off-by: Rajneesh Bhardwaj <rajneesh.bhardwaj@amd.com>
> (cherry picked from commit 1f114a541bd21873de905db64bb9efa673274d4b)
> (cherry picked from commit 20c435fad57d3201e5402e38ae778f1f0f84a09d)
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c  |  20 +++
>  drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h  |   2 +
>  drivers/gpu/drm/amd/amdkfd/kfd_chardev.c | 182 ++++++++++++++++++++++-
>  drivers/gpu/drm/amd/amdkfd/kfd_priv.h    |   3 +-
>  4 files changed, 204 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
> index 7e7d8330d64b..99ea29fd12bd 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
> @@ -1181,6 +1181,26 @@ static void amdgpu_ttm_tt_unpopulate(struct ttm_device *bdev,
>  	return ttm_pool_free(&adev->mman.bdev.pool, ttm);
>  }
>  
> +/**
> + * amdgpu_ttm_tt_get_userptr - Return the userptr GTT ttm_tt for the current
> + * task
> + *
> + * @tbo: The ttm_buffer_object that contains the userptr
> + * @user_addr:  The returned value
> + */
> +int amdgpu_ttm_tt_get_userptr(const struct ttm_buffer_object *tbo,
> +			      uint64_t *user_addr)
> +{
> +	struct amdgpu_ttm_tt *gtt;
> +
> +	if (!tbo->ttm)
> +		return -EINVAL;
> +
> +	gtt = (void *)tbo->ttm;
> +	*user_addr = gtt->userptr;
> +	return 0;
> +}
> +
>  /**
>   * amdgpu_ttm_tt_set_userptr - Initialize userptr GTT ttm_tt for the current
>   * task
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h
> index 9e38475e0f8d..dddd76f7a92e 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h
> @@ -168,6 +168,8 @@ static inline bool amdgpu_ttm_tt_get_user_pages_done(struct ttm_tt *ttm)
>  #endif
>  
>  void amdgpu_ttm_tt_set_user_pages(struct ttm_tt *ttm, struct page **pages);
> +int amdgpu_ttm_tt_get_userptr(const struct ttm_buffer_object *tbo,
> +			      uint64_t *user_addr);
>  int amdgpu_ttm_tt_set_userptr(struct ttm_buffer_object *bo,
>  			      uint64_t addr, uint32_t flags);
>  bool amdgpu_ttm_tt_has_userptr(struct ttm_tt *ttm);
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
> index 09e2d30515e2..d548e6691d69 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
> @@ -42,6 +42,7 @@
>  #include "kfd_svm.h"
>  #include "amdgpu_amdkfd.h"
>  #include "kfd_smi_events.h"
> +#include "amdgpu_object.h"
>  
>  static long kfd_ioctl(struct file *, unsigned int, unsigned long);
>  static int kfd_open(struct inode *, struct file *);
> @@ -1804,6 +1805,44 @@ static int kfd_ioctl_svm(struct file *filep, struct kfd_process *p, void *data)
>  }
>  #endif
>  
> +static int criu_dump_process(struct kfd_process *p, struct kfd_ioctl_criu_dumper_args *args)
> +{
> +	int ret;
> +	struct kfd_criu_process_bucket *process_bucket;
> +	struct kfd_criu_process_priv_data *process_priv;
> +
> +	if (args->num_objects != 1) {
> +		pr_err("Only 1 process supported\n");
> +		return -EINVAL;
> +	}
> +
> +	if (args->objects_size != sizeof(*process_bucket) + sizeof(*process_priv)) {
> +		pr_err("Invalid objects size for process\n");
> +		return -EINVAL;
> +	}
> +
> +	process_bucket = kzalloc(args->objects_size, GFP_KERNEL);
> +	if (!process_bucket)
> +		return -ENOMEM;
> +
> +	/* Private data starts after process bucket */
> +	process_priv = (void *)(process_bucket + 1);
> +
> +	process_priv->version = KFD_CRIU_PRIV_VERSION;
> +
> +	process_bucket->priv_data_offset = 0;
> +	process_bucket->priv_data_size = sizeof(*process_priv);
> +
> +	ret = copy_to_user((void __user *)args->objects, process_bucket, args->objects_size);
> +	if (ret) {
> +		pr_err("Failed to copy process information to user\n");
> +		ret = -EFAULT;
> +	}
> +
> +	kfree(process_bucket);
> +	return ret;
> +}
> +
>  uint64_t get_process_num_bos(struct kfd_process *p)
>  {
>  	uint64_t num_of_bos = 0, i;
> @@ -1824,12 +1863,151 @@ uint64_t get_process_num_bos(struct kfd_process *p)
>  	return num_of_bos;
>  }
>  
> +static int criu_dump_bos(struct kfd_process *p, struct kfd_ioctl_criu_dumper_args *args)
> +{
> +	struct kfd_criu_bo_bucket *bo_buckets;
> +	struct kfd_criu_bo_priv_data *bo_privs;
> +	uint64_t num_bos;
> +
> +	int ret = 0, pdd_index, bo_index = 0, id;
> +	void *mem;
> +
> +	num_bos = get_process_num_bos(p);
> +
> +	if (args->num_objects != num_bos) {
> +		pr_err("Mismatch with number of BOs (current:%lld user:%lld)\n",
> +				num_bos, args->num_objects);
> +		return -EINVAL;
> +	}
> +
> +	if (args->objects_size != args->num_objects * (sizeof(*bo_buckets) + sizeof(*bo_privs))) {
> +		pr_err("Invalid objects size for BOs\n");
> +		return -EINVAL;
> +	}
> +
> +	bo_buckets = kvzalloc(args->objects_size, GFP_KERNEL);
> +	if (!bo_buckets)
> +		return -ENOMEM;
> +
> +	/* Private data for first BO starts after all bo_buckets */
> +	bo_privs = (void *)(bo_buckets + args->num_objects);
> +
> +	for (pdd_index = 0; pdd_index < p->n_pdds; pdd_index++) {
> +		struct kfd_process_device *pdd = p->pdds[pdd_index];
> +		struct amdgpu_bo *dumper_bo;
> +		struct kgd_mem *kgd_mem;
> +
> +		idr_for_each_entry(&pdd->alloc_idr, mem, id) {
> +			struct kfd_criu_bo_bucket *bo_bucket;
> +			struct kfd_criu_bo_priv_data *bo_priv;
> +
> +			if (!mem) {
> +				ret = -ENOMEM;
> +				goto exit;
> +			}
> +
> +			kgd_mem = (struct kgd_mem *)mem;
> +			dumper_bo = kgd_mem->bo;
> +
> +			if ((uint64_t)kgd_mem->va <= pdd->gpuvm_base)
> +				continue;
> +
> +			bo_bucket = &bo_buckets[bo_index];
> +			bo_priv = &bo_privs[bo_index];
> +
> +			bo_bucket->addr = (uint64_t)kgd_mem->va;
> +			bo_bucket->size = amdgpu_bo_size(dumper_bo);
> +			bo_bucket->gpu_id = pdd->dev->id;
> +			bo_bucket->alloc_flags = (uint32_t)kgd_mem->alloc_flags;
> +
> +			bo_bucket->priv_data_offset = bo_index * sizeof(*bo_priv);
> +			bo_bucket->priv_data_size = sizeof(*bo_priv);
> +
> +			bo_priv->idr_handle = id;
> +			if (bo_bucket->alloc_flags & KFD_IOC_ALLOC_MEM_FLAGS_USERPTR) {
> +				ret = amdgpu_ttm_tt_get_userptr(&dumper_bo->tbo,
> +								&bo_priv->user_addr);
> +				if (ret) {
> +					pr_err("Failed to obtain user address for user-pointer bo\n");
> +					goto exit;
> +				}
> +			}
> +			if (bo_bucket->alloc_flags & KFD_IOC_ALLOC_MEM_FLAGS_DOORBELL)
> +				bo_bucket->offset = KFD_MMAP_TYPE_DOORBELL |
> +					KFD_MMAP_GPU_ID(pdd->dev->id);
> +			else if (bo_bucket->alloc_flags &
> +				KFD_IOC_ALLOC_MEM_FLAGS_MMIO_REMAP)
> +				bo_bucket->offset = KFD_MMAP_TYPE_MMIO |
> +					KFD_MMAP_GPU_ID(pdd->dev->id);
> +			else
> +				bo_bucket->offset = amdgpu_bo_mmap_offset(dumper_bo);
> +
> +			pr_debug("bo_size = 0x%llx, bo_addr = 0x%llx bo_offset = 0x%llx\n"
> +					"gpu_id = 0x%x alloc_flags = 0x%x idr_handle = 0x%x",
> +					bo_bucket->size,
> +					bo_bucket->addr,
> +					bo_bucket->offset,
> +					bo_bucket->gpu_id,
> +					bo_bucket->alloc_flags,
> +					bo_priv->idr_handle);
> +			bo_index++;
> +		}
> +	}
> +
> +	ret = copy_to_user((void __user *)args->objects, bo_buckets, args->objects_size);
> +	if (ret) {
> +		pr_err("Failed to copy bo information to user\n");
> +		ret = -EFAULT;
> +	}
> +
> +exit:
> +	kvfree(bo_buckets);
> +	return ret;
> +}
> +
>  static int kfd_ioctl_criu_dumper(struct file *filep,
>  				struct kfd_process *p, void *data)
>  {
> -	pr_debug("Inside %s\n", __func__);
> +	struct kfd_ioctl_criu_dumper_args *args = data;
> +	int ret;
>  
> -	return 0;
> +	pr_debug("CRIU dump type:%d\n", args->type);
> +
> +	if (!args->objects || !args->objects_size)
> +		return -EINVAL;
> +
> +	mutex_lock(&p->mutex);
> +
> +	if (!kfd_has_process_device_data(p)) {
> +		pr_err("No pdd for given process\n");
> +		ret = -ENODEV;
> +		goto err_unlock;
> +	}
> +
> +	switch (args->type) {
> +	case KFD_CRIU_OBJECT_TYPE_PROCESS:
> +		ret = criu_dump_process(p, args);
> +		break;
> +	case KFD_CRIU_OBJECT_TYPE_BO:
> +		ret = criu_dump_bos(p, args);
> +		break;
> +	case KFD_CRIU_OBJECT_TYPE_QUEUE:
> +	case KFD_CRIU_OBJECT_TYPE_EVENT:
> +	case KFD_CRIU_OBJECT_TYPE_DEVICE:
> +	case KFD_CRIU_OBJECT_TYPE_SVM_RANGE:
> +	default:
> +		pr_err("Unsupported object type:%d\n", args->type);
> +		ret = -EINVAL;
> +	}
> +
> +err_unlock:
> +	mutex_unlock(&p->mutex);
> +	if (ret)
> +		pr_err("Failed to dump CRIU type:%d ret:%d\n", args->type, ret);
> +	else
> +		pr_debug("CRIU dump type:%d ret:%d\n", args->type, ret);
> +
> +	return ret;
>  }
>  
>  static int kfd_ioctl_criu_restorer(struct file *filep,
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
> index 4e390006b4b6..8c9f2b3ac85d 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
> @@ -1031,7 +1031,8 @@ struct kfd_criu_device_priv_data {
>  };
>  
>  struct kfd_criu_bo_priv_data {
> -	uint64_t reserved;
> +	uint64_t user_addr;
> +	uint32_t idr_handle;
>  };
>  
>  struct kfd_criu_svm_range_priv_data {
