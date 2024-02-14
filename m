Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C32BEC48BC3
	for <amd-gfx@archiver.kernel.org>; Wed, 14 Feb 2024 18:49:47 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7204610E81C;
	Wed, 14 Feb 2024 18:49:47 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="j3QvsSU2";
	dkim-atps=neutral
Received: from NAM02-SN1-obe.outbound.protection.outlook.com
 (mail-sn1nam02on2059.outbound.protection.outlook.com [40.107.96.59])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C737010E81C
 for <amd-gfx@lists.freedesktop.org>; Wed, 14 Feb 2024 18:49:45 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CjbGlW0vY8Sh0b/NiFvmtg01fxYOIFartUSwThzHHa9yQe65YTjzwG1cdXvW+NajzySsxGWzpQUKBHX4CQ+R88NCjBpJ6AfAiVaa8xrIlHQ/pCkqHo/Ry3fcTIQnoFHtma8TmACR0TgaT8F9DafqRhvplcp09T709F93XkNJULqSbL2l1zdXjffVFcoSvLi3PPX1hy1lKuKBCxst9eHS/POyPtBf5e9P6fZ91p81z3Fn9JLzGoEEd/mQ5+PDIn6AJv1yS2mMVvFSzmUG81xN4Jn/CCbh9ANxXjWeKLTmdF4TkDaZxPT9PgycJ9NnQRbsZL73frGtY1Or3FTAFHfQZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RR6dRG51zlGWBWkVszUX1Phf0GBmwW4D+mlgWvYNCak=;
 b=aNvpXYWN8J5y2RsQFiHRHw5oadiu8paUAhqQVMzhP/56Tt0oDJIZBZi9nzanYJmVlViIIpc4J3azTM8tDDyaUCK3OE/OdAhjWDF6cgznKRmp1qOwRNsZhPi0lClTqzRwRr42AMXhH34QLcAdANet7Jm+S1UgIwTToI62hikKZs0hKeUG/8kX3ldiEwvhlnWa+szGWQ+Gb2H3/8gjguLXPkMshHqZMDWhI2xW8rJjoRakpZs7C19gf+yZmc9uS4dgZQ4nQ7CNXIXJSmllsSZ8hiJ0t5K1mLGppDIbchS/HwBT+DgxqRuNskbrnD2FsWdeCFm9kcEfVDS1TVEIUSIxkQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RR6dRG51zlGWBWkVszUX1Phf0GBmwW4D+mlgWvYNCak=;
 b=j3QvsSU2L7C7ZShNNKNIIQdRN5ySrby9IbUuhgTMZnOX6ZhpaNxcsWwCHv3I2o0SptfwTsLooCbePLS4j/T7ob9yHZgp5HbZ9pyQ2GpsQqX4kiXmW2v+B8xsB9slFvzXbSTGl5fEpeED/Tiyxgdjve2RajZfwtcwsqaoSdOQ06c=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB6280.namprd12.prod.outlook.com (2603:10b6:8:a2::11) by
 DM8PR12MB5461.namprd12.prod.outlook.com (2603:10b6:8:3a::19) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7292.26; Wed, 14 Feb 2024 18:49:43 +0000
Received: from DM4PR12MB6280.namprd12.prod.outlook.com
 ([fe80::3301:dfb9:528a:1fa5]) by DM4PR12MB6280.namprd12.prod.outlook.com
 ([fe80::3301:dfb9:528a:1fa5%7]) with mapi id 15.20.7316.012; Wed, 14 Feb 2024
 18:49:43 +0000
Message-ID: <9589fa8c-35b8-4921-8501-b97ba1d9b956@amd.com>
Date: Wed, 14 Feb 2024 13:49:42 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 15/17] drm/amd/display: Drop unnecessary header
Content-Language: en-US
To: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>, amd-gfx@lists.freedesktop.org
Cc: Harry.Wentland@amd.com, Sunpeng.Li@amd.com, Aurabindo.Pillai@amd.com,
 roman.li@amd.com, wayne.lin@amd.com, agustin.gutierrez@amd.com,
 chiahsuan.chung@amd.com, hersenxs.wu@amd.com, jerry.zuo@amd.com
References: <20240214184006.1356137-1-Rodrigo.Siqueira@amd.com>
 <20240214184006.1356137-16-Rodrigo.Siqueira@amd.com>
From: Hamza Mahfooz <hamza.mahfooz@amd.com>
In-Reply-To: <20240214184006.1356137-16-Rodrigo.Siqueira@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YQZPR01CA0079.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:84::25) To DM4PR12MB6280.namprd12.prod.outlook.com
 (2603:10b6:8:a2::11)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB6280:EE_|DM8PR12MB5461:EE_
X-MS-Office365-Filtering-Correlation-Id: ee61c413-823d-4f32-69fd-08dc2d8db53d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Dqc1hYyaGmH2QVfNA7RRsH+BYe8KJCnnBgNMGPrWj4M+MAiIvIp9HnpDTVnG5dFZFO3RiWXCpCKJnNgwXjzxozHjijs98jOmtOxnGB9eFGnWnAgjzguxRSPi+tDnAAHjqjGkepkNjd86GAoAh9EfUr5P7OEc/uGGFD68MvUXnpiihiBfQmoFGqU6r26eMA0L4fcU3PRLoLuXPVwuAw056fdvC1D9Gi3ypfJTytv0p3zrWKFKRdWZ5JYK59mDVQvY8RKlBz0Fw7o9T2h+NSeDw4WGS5wXfiQCy6WnF0C3z0dtmZQx5Xqb64ng+DKOuEYbxnDDrqPU7SF1eA49DBcoW9+yM8LgM94sYkMQggCCjTMhENpuuXP6aDkpiNyLEcOwHAvCSZNMUIXmP3khtDSDs4ywov/UJNqkgxFkoMhDEcaInp4za1tM1F2+UyP10me5p/HfRJXLFm48WNgDWXBjlBuoFHkVSwvOAl74u062YC3GMwTr3/AF2WyPBYlIsE7pWZ6aDFNk3BPkBTP1xL6T05QXM8vUQgBpx6IXzCeOGi/bKLqgfHO8oONF7jcQQxhw
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB6280.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(396003)(366004)(136003)(376002)(346002)(39860400002)(230922051799003)(451199024)(1800799012)(64100799003)(186009)(44832011)(8676002)(8936002)(4326008)(66556008)(66946007)(66476007)(2906002)(83380400001)(26005)(38100700002)(36756003)(86362001)(31696002)(316002)(5660300002)(2616005)(41300700001)(53546011)(478600001)(6512007)(6506007)(6486002)(31686004);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?d200N3BraVJaUjdobjQ5dlNZcEFiMVJmNEsyaloyNmZJWkNiZ0l6UUxaTElY?=
 =?utf-8?B?ZXlXQTJzbVhDbGQrZEZhQVZnbzJwZnpSMnhFdHMyblpVUUorY0RSK2hNYlZn?=
 =?utf-8?B?cGFZRFVaenU1SUtqVnI1MGMreFJUV1RySUU1YWJaQTFrRXBYTDFlUVp0c01o?=
 =?utf-8?B?Qjlqdm9CQUp1ekh3SjUvR1V6NlVjckRwSm9Jb0FZa21HWlNicUM3N3F4cE5p?=
 =?utf-8?B?cTNUbE8xaS9vL3hmMGJ2R3RHSXVuTDNjRFY0WFF3cFdFWXdYV2FIQ3NRS2RT?=
 =?utf-8?B?aGNrY1N5WWcxbjRaekhDMkc3L3gwRXUva2VaeDBDdngyd3YrZnlhV3g1b2JG?=
 =?utf-8?B?RXRFTFhLUFdBT28vWTRwM1ZONVc3UytOSkhzMTR3TDE0N2FOYVI2Qm1WWG0y?=
 =?utf-8?B?UVNuSUE0cG1sU1NpS2p2K1NEcXI5L3ZLU0xvUkh2VEdNSGc1emlTRE1UK2N0?=
 =?utf-8?B?bGNMUSt4OVpnTkNNeVk0NFZ5YU5tbkdnNkhua2ovem5DMEZGcEJqU3lwUFBi?=
 =?utf-8?B?Nk1rQjA3V1lhcFpjVFlVVjJ5SllVWGNmUk9wdHZndE9DQVhkcmwvVDJ6K0Vk?=
 =?utf-8?B?d2dkeDNFUjFGOU9pUnllc1VKcFl5MWFZTjlRVy9qMjQ5OU5vc211WjRtcks2?=
 =?utf-8?B?cTBHeWROV1VLN3ZmNEc3UFVUeDdRK1ZrQWJtM1JxL29DeEhxR09jZ3pIekVz?=
 =?utf-8?B?Umg5ZWRrd0o1WUkrZDdSMEhYYjNRamkxMEVST0tBVDZlZkczOEhBbG0wUm1k?=
 =?utf-8?B?cFhveU9BbEpQWit1dFphdEJ4NloxQ2JVMHhTeHNUVlQ4WWlOOGxPV3VOTHJa?=
 =?utf-8?B?MFhxL0hNTVRzeGNwS3Juc1RPazZvck5CeG5BVC9TZ0toS0Jxa09XbWdqZldk?=
 =?utf-8?B?NHJXRWRCNXBDVEQwRENTYzhYcGxsNU11QXFTdGswV3paMVNMNFl5NDFvT2Nx?=
 =?utf-8?B?VklyVlU4bDFUSGNvNzFoS1k4R2lOS1RsRlRLKzVIUHRqTnRncDE1MXNhY3JG?=
 =?utf-8?B?VWxocWJENzFHWHBOeXEvSFQvVERyUTFZUmFOeXE2cXBkZnpUNHYwWEhSNElZ?=
 =?utf-8?B?K1VOZmtBejNuVEs4RC8rVjFWUHQ0TVZSWFhOWjFXbFV1V3BLWFg0U1dtY0NR?=
 =?utf-8?B?UThWQ2Jkd1dJdkFsdzFwU1M4clBHVndYWVcyQmpwUEV2NWRtc2dlSFZRSUl5?=
 =?utf-8?B?cFcyaDVPRHlNQVZCMGFtcTRRTFlIVkxUR1Y1QXVMbiswelFvTWgwV1hIUyt3?=
 =?utf-8?B?NGhTN3RWTk5aMU0zOTBOVGk1bmdrOGlTamtNYTA2TUxsaTNyUFp1VnR3L1Zy?=
 =?utf-8?B?K2NuVy8vQkxrY3JKZklwVnVjRFQ3WVVlbXhPYTJjZEt0bnkyWjJrVFJBcGRr?=
 =?utf-8?B?UnZ5NEhBd0pLMkNlR1NROUVBSHVjMmwvVkI5Q0h0WEk3am9aSTR6MWtFbkc0?=
 =?utf-8?B?Zy81ZkFCbHlSeVhmSk8yZFhhMStjeFNzR3dHU2EyMURFYkg5MytFUWo5NHNE?=
 =?utf-8?B?VWZ0YnlaUnd2amxkNG5qK1hLYm05bUoya25sTSs3R280dXpVWlZ2bG1aSVB5?=
 =?utf-8?B?aEJQcVBxQmFucVhhZVV5L2RUR1A3eU1Ha0tldTY4V1JsUWFTTXlvSXVJTmNK?=
 =?utf-8?B?MHBKbGhVTE5NYnZkZGhqbzZ2WWZqQ3JGQ2Rnc0xWenFJQ0RHTS9zdFlFb2Yw?=
 =?utf-8?B?VG9WVzBCdytVZytybnpjeWUwS2NtaW5IK0d0clJMV25QZC9OUDV3ekVJclhp?=
 =?utf-8?B?cTZoejJuSUtaaFBKVUt6Z3RYTzhNQlF6MmNVUm5NVEo5ZlR6dlJ0WGI5QVBU?=
 =?utf-8?B?dXdBZ2ZKU3VpNUtyS1VZeUI5eDZFNFZqUHcyeHFYQVZCY2lzS3lKZHd3dy8r?=
 =?utf-8?B?bk05QjdMRlNPRk9Yd0wrd3YvWWZ1bk9ia3JXQXZLeXhnanRxY1UwWVh6eFhS?=
 =?utf-8?B?WkhmYWYrZDZXOTh1cnpzNFNWd1dCR0NqU3hPWDVOd0ZvRWZGK0JRRFdxTFhM?=
 =?utf-8?B?K3BmZ0x0TkNqSU5ycEVFTldNeTZ4STg0ZnFSOVNvWHVvUENTZDhRNUtBOTNo?=
 =?utf-8?B?NVN0VkFGMmM2NldWc1RJaUdVTTZDT1dZYTNiWDZKSDRLU0NjR2hxMW91TUJG?=
 =?utf-8?Q?pY6sK0plfW9kut4jpr+MQgy6b?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ee61c413-823d-4f32-69fd-08dc2d8db53d
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB6280.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Feb 2024 18:49:43.5321 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: IrBbggSy+KXNLS3g/8EBfjBAaicy9quz0KWKCr1znQ9bmy0nivQGlWDIVZ7VO+Yg5i2BboAEAsL9dr9EK9T81Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM8PR12MB5461
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

On 2/14/24 13:38, Rodrigo Siqueira wrote:
> A long time ago, the slab header was added to multiple files in DC. We
> also included it in the os_types.h, which is included in many of those
> DC files. At this point, there is no need to insert the slab.h header in
> multiple files, so this commit drops those includes.
> 
> Signed-off-by: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>

Reviewed-by: Hamza Mahfooz <hamza.mahfooz@amd.com>

> ---
>   drivers/gpu/drm/amd/display/dc/basics/dce_calcs.c              | 2 --
>   drivers/gpu/drm/amd/display/dc/clk_mgr/clk_mgr.c               | 2 --
>   drivers/gpu/drm/amd/display/dc/clk_mgr/dcn10/rv1_clk_mgr.c     | 2 --
>   drivers/gpu/drm/amd/display/dc/hdcp/hdcp_msg.c                 | 2 --
>   drivers/gpu/drm/amd/display/dc/irq/dcn20/irq_service_dcn20.c   | 2 --
>   drivers/gpu/drm/amd/display/dc/irq/dcn21/irq_service_dcn21.c   | 2 --
>   drivers/gpu/drm/amd/display/dc/resource/dcn20/dcn20_resource.c | 2 --
>   7 files changed, 14 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/display/dc/basics/dce_calcs.c b/drivers/gpu/drm/amd/display/dc/basics/dce_calcs.c
> index 39530b2ea495..b30c2cdc1a61 100644
> --- a/drivers/gpu/drm/amd/display/dc/basics/dce_calcs.c
> +++ b/drivers/gpu/drm/amd/display/dc/basics/dce_calcs.c
> @@ -23,8 +23,6 @@
>    *
>    */
>   
> -#include <linux/slab.h>
> -
>   #include "resource.h"
>   #include "dm_services.h"
>   #include "dce_calcs.h"
> diff --git a/drivers/gpu/drm/amd/display/dc/clk_mgr/clk_mgr.c b/drivers/gpu/drm/amd/display/dc/clk_mgr/clk_mgr.c
> index 86ee4fe4f5e3..9f0f25aee426 100644
> --- a/drivers/gpu/drm/amd/display/dc/clk_mgr/clk_mgr.c
> +++ b/drivers/gpu/drm/amd/display/dc/clk_mgr/clk_mgr.c
> @@ -23,8 +23,6 @@
>    *
>    */
>   
> -#include <linux/slab.h>
> -
>   #include "dal_asic_id.h"
>   #include "dc_types.h"
>   #include "dccg.h"
> diff --git a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn10/rv1_clk_mgr.c b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn10/rv1_clk_mgr.c
> index 60761ff3cbf1..2a74e2d74909 100644
> --- a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn10/rv1_clk_mgr.c
> +++ b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn10/rv1_clk_mgr.c
> @@ -23,8 +23,6 @@
>    *
>    */
>   
> -#include <linux/slab.h>
> -
>   #include "reg_helper.h"
>   #include "core_types.h"
>   #include "clk_mgr_internal.h"
> diff --git a/drivers/gpu/drm/amd/display/dc/hdcp/hdcp_msg.c b/drivers/gpu/drm/amd/display/dc/hdcp/hdcp_msg.c
> index 25ffc052d53b..99e17c164ce7 100644
> --- a/drivers/gpu/drm/amd/display/dc/hdcp/hdcp_msg.c
> +++ b/drivers/gpu/drm/amd/display/dc/hdcp/hdcp_msg.c
> @@ -23,8 +23,6 @@
>    *
>    */
>   
> -#include <linux/slab.h>
> -
>   #include "dm_services.h"
>   #include "dm_helpers.h"
>   #include "include/hdcp_msg_types.h"
> diff --git a/drivers/gpu/drm/amd/display/dc/irq/dcn20/irq_service_dcn20.c b/drivers/gpu/drm/amd/display/dc/irq/dcn20/irq_service_dcn20.c
> index e8baafa02443..916f0c974637 100644
> --- a/drivers/gpu/drm/amd/display/dc/irq/dcn20/irq_service_dcn20.c
> +++ b/drivers/gpu/drm/amd/display/dc/irq/dcn20/irq_service_dcn20.c
> @@ -23,8 +23,6 @@
>    *
>    */
>   
> -#include <linux/slab.h>
> -
>   #include "dm_services.h"
>   
>   #include "include/logger_interface.h"
> diff --git a/drivers/gpu/drm/amd/display/dc/irq/dcn21/irq_service_dcn21.c b/drivers/gpu/drm/amd/display/dc/irq/dcn21/irq_service_dcn21.c
> index 03c5e8ff8cbd..42cdfe6c3538 100644
> --- a/drivers/gpu/drm/amd/display/dc/irq/dcn21/irq_service_dcn21.c
> +++ b/drivers/gpu/drm/amd/display/dc/irq/dcn21/irq_service_dcn21.c
> @@ -23,8 +23,6 @@
>    *
>    */
>   
> -#include <linux/slab.h>
> -
>   #include "dm_services.h"
>   
>   #include "include/logger_interface.h"
> diff --git a/drivers/gpu/drm/amd/display/dc/resource/dcn20/dcn20_resource.c b/drivers/gpu/drm/amd/display/dc/resource/dcn20/dcn20_resource.c
> index f9c5bc624be3..a2387cea1af9 100644
> --- a/drivers/gpu/drm/amd/display/dc/resource/dcn20/dcn20_resource.c
> +++ b/drivers/gpu/drm/amd/display/dc/resource/dcn20/dcn20_resource.c
> @@ -24,8 +24,6 @@
>    *
>    */
>   
> -#include <linux/slab.h>
> -
>   #include "dm_services.h"
>   #include "dc.h"
>   
-- 
Hamza

