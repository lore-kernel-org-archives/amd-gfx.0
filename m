Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D28A6C54EE9
	for <amd-gfx@archiver.kernel.org>; Wed,  7 Sep 2022 17:39:09 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 484FF10E803;
	Wed,  7 Sep 2022 17:39:08 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2061.outbound.protection.outlook.com [40.107.243.61])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F2AA510E803
 for <amd-gfx@lists.freedesktop.org>; Wed,  7 Sep 2022 17:39:05 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=f+ZUdpsTeNhXpus7kKpMYd/C1Au0yFnvbllMGWGriWwqDp/SdfbmSeOimg3Bs5C5n1pQjo7xlekDezSlQGJ3MwYsybnhLnUrNwWNWDBb0WvIJvBkPOsEyOK0qrrByNbhVam7he0n/y4nRZ9fnZb+y4uHTGXTtj2vQbChh19flD0nMoFp/9JhCgw/I5poAXnbIJ6k1eXvmPL6aC9cyq+Mkpu34aY73+/7msA/dhIcY4c2obVHE57R20BgVkoo2lZQl1eBLD9yzfHPB0TGtIeHUHXawTIl6jCFkrxLQ4q1v08r/gOTaf+qi45BJEze8mrRHry5Z/7LArI4tCg9eW/aYw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vl3M+Yg96EGsRdQaObbVFv+jK7bhvmL2kQUicl31QDA=;
 b=bLxUrLyfRDZHS2pMOl5/yYnpMZtLzRGOrs/l8xe4X9ryDXA0qad+r67b6z3H4+GTidHElZTzN5GAFyKc9xZDdetkDXJ7Qwuam+xJdlCULPuRxHJz0OzhzVyUOrxdrDu71YY9Y8Njeh7oaWwM8B7RT7nrSrS44oR4wI8sGwaavQvaukZrKmeIrWT0BsT4kwrezda1cRajSqijya+9tDOPJ8cw0uUCXu/bHSAFJgu2/kZmS3Qk6dHkesgkXxVclsFOf26rDShal/LFUs3d4hwVgxABx2ZIcO4Y3+rDYsiOCKj3xsZbBvX1qkDafx0ahMVB2/B/e1nN9HZvDezLWFfH7Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vl3M+Yg96EGsRdQaObbVFv+jK7bhvmL2kQUicl31QDA=;
 b=uz5wy6V+BTr0SU8v2Uz+M3gUm2OCEiNpyJ5bWNBEhFmNofHr+rimRZyRaPVtwhb/uPGo3haBaumVNM4k2UhbkZb0tY6CVJEhdf/d4CZl3WJHD9VC0yilGegwM2pGXAswBv2EqgyObZ0F9Z/NM4W3KezU2GTTUDD0/mKqzb3PAtY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CH0PR12MB5284.namprd12.prod.outlook.com (2603:10b6:610:d7::13)
 by MW4PR12MB6706.namprd12.prod.outlook.com (2603:10b6:303:1e2::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5588.16; Wed, 7 Sep
 2022 17:39:03 +0000
Received: from CH0PR12MB5284.namprd12.prod.outlook.com
 ([fe80::cd37:1141:7fec:389d]) by CH0PR12MB5284.namprd12.prod.outlook.com
 ([fe80::cd37:1141:7fec:389d%4]) with mapi id 15.20.5612.014; Wed, 7 Sep 2022
 17:39:03 +0000
Message-ID: <7a2c53d6-6bb5-7a5b-0d32-158088642f37@amd.com>
Date: Wed, 7 Sep 2022 13:39:00 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.0
Subject: Re: [PATCH 04/27] drm/amd/display: Revert "Fallback to SW cursor if
 SubVP + cursor too big"
To: Pavle Kotarac <pavle.kotarac@amd.com>, amd-gfx@lists.freedesktop.org
References: <20220907173232.11755-1-pavle.kotarac@amd.com>
 <20220907173232.11755-5-pavle.kotarac@amd.com>
Content-Language: en-US
From: Aurabindo Pillai <aurabindo.pillai@amd.com>
In-Reply-To: <20220907173232.11755-5-pavle.kotarac@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BL0PR02CA0106.namprd02.prod.outlook.com
 (2603:10b6:208:51::47) To CH0PR12MB5284.namprd12.prod.outlook.com
 (2603:10b6:610:d7::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH0PR12MB5284:EE_|MW4PR12MB6706:EE_
X-MS-Office365-Filtering-Correlation-Id: 81abb211-56b6-4526-c652-08da90f7da9f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: nGiQJn6CSTPr1I864aviRWNLfdYsfwijntkuxY6fWDs6EyRHNK/lOhx0st2BWl5pSXGfKU+Pyqon+qS0MfFY67w9G3aOj+O/l5F3O+u+Hggt3fgeUvzWMWOmyy+MGngdxMVV0QFcST79C9MSeXeP5UoWtmTeQNbUEfpqTg8kuu2R8fv6RnT+AUlntwkoS3vVtTCSSL1jN0iisNx+s/kZmytInju5Qgs5kgZU3Img8ml8WnTY7eCpYGeAkyskEB3lPgupTBcau44945srCNa5zIdABkNxFoUDdd0/qWdNLw1yfLQ69jjC+QUyoABoXUCNxFJxwuF6GhhFaQ+E8v2LHDtRwNn5x9W4m7WWh1XBMPji27+uIC02VTgQS2ZfcG//HAv3fo0IjEIZgGkx8etmtLLmDI3hEjgE2Wk+1TpgQCYAxmMshbgaheKwD59LQJ7aXBp8Yvuc34mNyzxLP3UyyZLGRvOXMDn/7NqZ5VjAl/He9eI8O4RafBrlDUPtvnHcO/idV3WBi+xtJzBKEyZGGzKzpwvAmd4qjG2RKHljO7CTDlxRFf3wwcocy0nVc+e50+ZY5VTOcXU0F+VAvp3xMRaEkDkPMUT+idRrkZuQRmu/ahhO94+8Q9xoGUnWA/nxBbYMFBpsTOh9T5fpw9po7mkUlUBTEkMDSsAtqod+MSVtdlWxNQKFKhmf4d5012A4IIsBpAaBeyuZxR3Rdt7OXKgjSMEhc89gJmGxkwVRdBrWqqLoLrXbI3rcGY6Wsi9k/cqeyJNFHGrugJvIXCsbgk72W0GMvkia4KlMTYl7I5E=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH0PR12MB5284.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230016)(4636009)(366004)(396003)(376002)(39860400002)(346002)(136003)(36756003)(26005)(316002)(6512007)(53546011)(83380400001)(6506007)(5660300002)(8936002)(44832011)(31696002)(2906002)(31686004)(86362001)(66556008)(66476007)(4326008)(66946007)(8676002)(478600001)(41300700001)(2616005)(186003)(6486002)(38100700002)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?N3M0Z2h5a1l6cW5DQ3MxdjlXTUtNRjZuZEFGRFU2cGpuQ2ZBWjRmUjBGUnl2?=
 =?utf-8?B?bDhKKzB2TmYveVBuMU5vb2pLYy81SzJjcGFuR1JuZVRLbDIyQUlHQjBCa1hj?=
 =?utf-8?B?VzZpWDlHMlJTQVJPQTNia1p6REI5dVdCSWlTYWtaSGpsbUNJK2ZCcmZpTGxL?=
 =?utf-8?B?OTZLWnNpeUtPQmpuMHQzZnpJMEpjU1hFZG9md2d1c1QzVFY3WEJGZlAxczB0?=
 =?utf-8?B?ZGsvMk4vd2pkQnJvdG9MS1lkaEFzRkxrV2RqMnFuQkxVYlJBVW1XMW5kRkpE?=
 =?utf-8?B?RHFZc01vV2ppeFI2RnJRdHpCM2FaV2YxZXR0MmUrVVBLSzdCMGpGVGdHZndV?=
 =?utf-8?B?Y1B6WUM2dHlLRGl5OHhwcUYyNW1MMGJrWVdyQnovS3BHUE44N2RJZG5XeWc1?=
 =?utf-8?B?YzNJVGlwSmNqUVU3ay9HZUZybmFUcXBSU3NVUTFPSlBoaGU1RGRuT3ZEWmNH?=
 =?utf-8?B?Mmg0YmdseG1NNXZjZUNRb1NUSHBaazlFbjlKN1pTLzZCWVlUdmtGVWxCS2h2?=
 =?utf-8?B?TVV3N1o2ZFhSRXFBQndIZGRYNWQ1cXdXb0ErVHk0cTZQMzFaeW1jSnlkekdU?=
 =?utf-8?B?NklxTTA0YjhqVGh4ekUrM0hpWG9Hdjl5TTJaYWNsR0Z3aEZHUnNJczRJSHZZ?=
 =?utf-8?B?REVRTy9pdGNqb1lzbUQ0VDlJN3FBaVdZMVZra3BySUxwV3lvUjNFMXhaWEMw?=
 =?utf-8?B?SG1sQ3o5Mk94WTh3YzVYTlBldDVSS3lLMzNDKytOWXowdVAwVGNSdXI1RjIx?=
 =?utf-8?B?TTV3d3JrS0F0NEhmOGtSeVJTUVFPb2RhUHRERVNNa0dlTDVDU210a1BWdE1p?=
 =?utf-8?B?bHdtQUNhYTZ1bnYvZUUxVTBveGVFZEYzYWhMRmw1MDdHNEdGdmZBUW9FZjFm?=
 =?utf-8?B?YlAvcE93QVBEWmtzcWpKN2tLcnN2WlpBWktwdkJjYy8walJ1cU1rdGdlenZJ?=
 =?utf-8?B?ZFFvREd1bFA5WktxY0s3QjhaSGJSek10STJReThYY2EwR2lNQXA0V0xlZlQ0?=
 =?utf-8?B?UVQvbUhXY290eURyWjZGNFdKT2dhaHB6WlhoTEdFQ0xDcU1XQnk5US9DUTVK?=
 =?utf-8?B?cENxaEFYci8wa2g5V2h1RU1JZm1PYVNTYnhhdEJoUTV6UDVMcC9hUkhTYVJs?=
 =?utf-8?B?QVFyUWZwRWRNZndZUm1rK0sySXVRakRIVWIyM3dOSmEyeFp1bEhFWFNsYm9q?=
 =?utf-8?B?TG9zVW5tMXR4TmVLYjcwZWdHMWVkUlR3L3NKdzRBUlNHSGk3Mk93UWV1b2Zn?=
 =?utf-8?B?SGdlS0czaDBpY3l2OG1uYkkvWXJiSFRSR2RweStoejVod04wZWx6WFdLK0M4?=
 =?utf-8?B?SUZWenhFUGt4Z3V6NmZudkxrL0NvUUwwb3lWVXh4Q2JjVlFkM2k0TkNYWmh5?=
 =?utf-8?B?MUR1QVo4QUcvRFpXa21ORTVtOUJjelVQNGIrNk1rMlNjdlRSNFpNR2J3TVZ4?=
 =?utf-8?B?UERxbE5iWndwQkU3RU9GM3RoekxuZ2hZQ0FHMlFTdk9SSW5SMXJvV0NHN1hQ?=
 =?utf-8?B?LzNkcjQ3Mjg4Vm9tR0t3bW9UamJUM3ZQMDlQRlhoOHJxajdhbEZJNWlRZCt1?=
 =?utf-8?B?djJCMmx3NlhJcHUzWmRkRFlxNm4zeU5MQkliMm0zbTBiN255dFdqZ0hMampv?=
 =?utf-8?B?WWhXUTlvcmVJTzZVWk1SeEpacVAwQTJtNjVBbzNnYkkwa0xpWEs0WWFwK3E0?=
 =?utf-8?B?TFlTSUJYS0VlL0JINFBMNTJzZ1haaWlGdklsVEU2em5HazRJTGRNTUpRVmFJ?=
 =?utf-8?B?bUVlQ1pxd0VXZ2pTQVFvK05nRWMxcDBPNDFBeU1ITWoreDQ2WXo5NGFidXc1?=
 =?utf-8?B?UG9QOHZHU0pEdVVoRk04L2JCUWVRbi8vTk9ZNW81b1Yyc2pWTmcyUDFBZEFB?=
 =?utf-8?B?RUdsaTRHNmN6M0ZqcWoxQWdOOXRoTXNoNUgwanNqMVUrY2hnQlZYYkN6aUxC?=
 =?utf-8?B?M1VaY2RPWUZLSDY2UC9IaURxUXBBWVNYUWU4ZHFwU3pHSmIvemtUVGJ4UnZG?=
 =?utf-8?B?UXkvYVFiS3ZFYyt4QktaUUtZR01VSG40ZHpuZjR6ZndlVGQ1dkZ0NWhBVGJU?=
 =?utf-8?B?WEp5aUw2MWV0ZXhaM09yOThZVmtnTVVDNnhSOFVaaWtiamkyUS8xVXdvY3g3?=
 =?utf-8?Q?tsxpdmHdPMPd28tqJzkvr0r+Q?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 81abb211-56b6-4526-c652-08da90f7da9f
X-MS-Exchange-CrossTenant-AuthSource: CH0PR12MB5284.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Sep 2022 17:39:03.0415 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: u0Fi7OsRc5t8kl4QJ30a9e2DcoKi8NyF/VzaudFF5zmmnPxyCPeD6hvh9NuynzzaD4IrWErr+lE7j2KRmhotrQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB6706
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
Cc: stylon.wang@amd.com, Sunpeng.Li@amd.com, Harry.Wentland@amd.com,
 qingqing.zhuo@amd.com, Rodrigo.Siqueira@amd.com, roman.li@amd.com,
 solomon.chiu@amd.com, Alvin Lee <Alvin.Lee2@amd.com>, wayne.lin@amd.com,
 Bhawanpreet.Lakha@amd.com, agustin.gutierrez@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>



On 2022-09-07 13:32, Pavle Kotarac wrote:
> From: Aurabindo Pillai <aurabindo.pillai@amd.com>
> 
> This reverts commit 8dbf225893cb07f98f8edc2d775b6a68fc1eab3b since

This commit doesnt exist on amd-staging-drm-next. Please fix the SHA 
before merging.

> returning false in case of SubVP results in no cursor being visible on
> desktop as there is no sw cursor fallback path on all platforms.
> 
> Reviewed-by: Alvin Lee <Alvin.Lee2@amd.com>
> Acked-by: Pavle Kotarac <Pavle.Kotarac@amd.com>
> Signed-off-by: Aurabindo Pillai <aurabindo.pillai@amd.com>
> ---
>   drivers/gpu/drm/amd/display/dc/core/dc_stream.c | 5 -----
>   1 file changed, 5 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_stream.c b/drivers/gpu/drm/amd/display/dc/core/dc_stream.c
> index f62d50901d92..6752ca44e6e0 100644
> --- a/drivers/gpu/drm/amd/display/dc/core/dc_stream.c
> +++ b/drivers/gpu/drm/amd/display/dc/core/dc_stream.c
> @@ -328,11 +328,6 @@ bool dc_stream_set_cursor_attributes(
>   	}
>   
>   	dc = stream->ctx->dc;
> -
> -	if (attributes->height * attributes->width * 4 > 16384)
> -		if (stream->mall_stream_config.type == SUBVP_MAIN)
> -			return false;
> -
>   	stream->cursor_attributes = *attributes;
>   
>   	dc_z10_restore(dc);
