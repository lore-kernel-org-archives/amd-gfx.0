Return-Path: <SRS0=i1uT=OE=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-19.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9CD4EC433EF
	for <amd-gfx@archiver.kernel.org>; Tue, 14 Sep 2021 15:07:20 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5EE8960FD7
	for <amd-gfx@archiver.kernel.org>; Tue, 14 Sep 2021 15:07:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 5EE8960FD7
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E87126E4F3;
	Tue, 14 Sep 2021 15:07:19 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2079.outbound.protection.outlook.com [40.107.236.79])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 04ED66E4F3
 for <amd-gfx@lists.freedesktop.org>; Tue, 14 Sep 2021 15:07:18 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IL9fmLYHOdnDX1CIAlYuxrXDVtLABq5bkVxSt2PriK08qRWnsLXbBolTua9tbm6A76mS/YwMv+4XKH5i0C80zLpE34ygjIubktOwIrJK6Rx35XOWM82vQawGMrt+K1YU0Y8ysEYPWL6upCAx+KdyxNsB8sy9fyLyHxIeIAuLdzoMgk0LL29rrsmL/79FxPtdgRB+p2yUGPhPreW2Hv/8zMB76wAdoyhrFlF89qWJxm8r+u0pOmwyQMUm632FyQ7PfuKnBhx7qRvtOMA6QY5joeKPTVepf1axhkbRm4STGicfJEWSUyuMkvORfRHzEULCmeNFZZNcSuI38dph5c2ZqA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version; 
 bh=uoQvdStRvSMaf/tOlgqzTPfhKhlmsjGBKmnymZeH6rU=;
 b=azpXdmKUUogZ0VdvAMx6MXaLXblXqHxMllI4lReIzq5deYc+7szX9DGyrTv/W1+jlD6czdhV/bl0oltypZbBeoHp5gpibhJsInr8WaGAOWk+wnuFHEahBxIZfS7Rtx1zabYfOjWWzynZU/F8sISyn1ffaSXT5yIiig3qxIeNiv58MRK64rZ95riAb38q2QwBP3/G3MMGKIE4TdG7EsU4P4iru4ATJ6NTn3lb1NohpOYs6qIOtAAc4syGW09FqKx8QfzWl8X0jZMYGVLnzUfSjFNh32f5K/tmTLdM206oSmpko0+unN6wK5ckcHiBw+SdSf7hzuo53IV5W9zFGsX3Mg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uoQvdStRvSMaf/tOlgqzTPfhKhlmsjGBKmnymZeH6rU=;
 b=uUzlLBUjygIsbfCJg/lWHZNh7BFIaSL1gOIMov5fw8mXM9yALzhWpwtf9k9XOnE8CVQefMxf81fKT7vuFs5sKSlsno4ClILeiPXC3fV4peSovxsxgrb9kUVJEK24A80/OnSf+POQ6EbGmCMg5brOJ4a/Xn4xr+3z69Dh3yN2Wx4=
Authentication-Results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
Received: from SJ0PR12MB5438.namprd12.prod.outlook.com (2603:10b6:a03:3ba::23)
 by SJ0PR12MB5454.namprd12.prod.outlook.com (2603:10b6:a03:304::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4500.15; Tue, 14 Sep
 2021 15:07:17 +0000
Received: from SJ0PR12MB5438.namprd12.prod.outlook.com
 ([fe80::384a:ae5d:717:8ba0]) by SJ0PR12MB5438.namprd12.prod.outlook.com
 ([fe80::384a:ae5d:717:8ba0%8]) with mapi id 15.20.4523.014; Tue, 14 Sep 2021
 15:07:17 +0000
Message-ID: <ed06bc8a-53c2-5acd-609d-b8d5960c8765@amd.com>
Date: Tue, 14 Sep 2021 11:07:13 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.1.0
Subject: Re: [PATCH 2/2] drm/amdgpu/display: add a proper license to
 dc_link_dp.c
Content-Language: en-US
To: Alex Deucher <alexander.deucher@amd.com>, amd-gfx@lists.freedesktop.org
References: <20210914145912.1569716-1-alexander.deucher@amd.com>
 <20210914145912.1569716-2-alexander.deucher@amd.com>
From: Harry Wentland <harry.wentland@amd.com>
In-Reply-To: <20210914145912.1569716-2-alexander.deucher@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YQBPR01CA0076.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:3::12) To SJ0PR12MB5438.namprd12.prod.outlook.com
 (2603:10b6:a03:3ba::23)
MIME-Version: 1.0
Received: from [192.168.50.3] (198.200.67.104) by
 YQBPR01CA0076.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:c01:3::12) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4523.14 via Frontend Transport; Tue, 14 Sep 2021 15:07:16 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 2f132e78-aa1d-4927-b9ff-08d977915742
X-MS-TrafficTypeDiagnostic: SJ0PR12MB5454:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SJ0PR12MB54541EDC8CA4EBDA8126EA5E8CDA9@SJ0PR12MB5454.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: F64ziAVco3PxIjCHP1M/J3rMuyPlldk+DEptcwYOB3Ix0ngw5SneR8B8i0tjIKTJuaEzdVzRhGP9zy2snA+uoMbnmWrk0EhSbKdXgSo+q2Y2VlnBkyfQGWFHc0Y/DIP2ECn+uY6dfjrfDp1xIdpO70FLeyKmX5P5qti8lTmuSMNrZ+269YcEQwoFapdZ3JPdhuQxf8et6VLzOFl9pq9159ZGJjc4WHOlDGvmYDUR/8MQdLY2Nil0/PfeNU5m/GMR0XCDvjfDyTAQiKHLeLbB6FtF8xtIh8TaiwA4LIWwqPexfb65D7t8YYC2MbkXFN8PY7MwT9ioapJnxU64cF+8imGRbJkUOZbNSim7MnsvJS50TekCUB1Q03ZQ0hDiqFjXDiKcrwn+HlvoamnKFd6y88tRccQrInimi+PY80dtkY/Grra34elr4n4OuDpC1Hjs/JicSaaRTLEV1+e0mFQRS2ulD8CS2jbbDPxbXKOzXwebI/5SJKIrQ5u9HHjbq1Nhv/lAj8WqHChorzO6Q33aVq2lqOQgQmWYYsb8uMcNctkVW6jXJuR1iR15JLCZozQzcxYD00npobmkJmVlraEOS2miDL3vFYVzeB+W67fNQo1vmQpTB/M5EYjMfxls229CyQU6midPGJdLA58hwMUgChNy3UKD2WyXXOCtc1tiyNYy0mAwUC3q7aggFgWcnPGbeW4Wm1i8l1hyaSEL3/ImttKqakYLUcckl1Qz0WjeBltZBrDZ/0vzFo9G7qpS0OZ6
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ0PR12MB5438.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(346002)(136003)(39860400002)(396003)(366004)(376002)(316002)(31686004)(6666004)(44832011)(16576012)(478600001)(86362001)(36756003)(2906002)(66556008)(956004)(83380400001)(2616005)(8676002)(8936002)(31696002)(6486002)(26005)(5660300002)(38100700002)(66476007)(186003)(66946007)(53546011)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZmZBMTZpQjhLMG1mRG5hampLWUF2Zmszb0w1OWxhV2JhVWxLT04rSXlQdHZi?=
 =?utf-8?B?dGY4bFYxczd6QXlLVElHZW9qa0hEZnRCcUdCUmM5S2gyUXpHck4vZUdqVVl3?=
 =?utf-8?B?cGNVOXg5YmJGY0tJVHhaNHlHcGdQQ2FHQW5QMFFmLy9ZK25xeXROSUd3Sk1w?=
 =?utf-8?B?clNlL0tCQmxPb1ROT2p0RHBiTWUzbEd0RU90WjRXZitRb0JDdnBndG9wcTlu?=
 =?utf-8?B?NUVkZFA1eFozWFpaL0ZZWWl2akIrUUpoSklrZDNCbGIrR0oxZlpEc1pDS1A2?=
 =?utf-8?B?ay9PWCt4dittMU9Bc3l3VWlRcE94NzBDNTRIQUN6UTBBckhNcWZKbEdtTHlO?=
 =?utf-8?B?REtubk5GaHNmVGxhdjZ3K2lyMGRDTjNIRE9acGdlbnA0WkRrM2s0MWhKQ2Yr?=
 =?utf-8?B?TTZyNkFTS2dGWElFOVUwNUVxZDZ4bitoYXZBbGI3cVlaU1R1V08rU2c0Qldo?=
 =?utf-8?B?UmIxbEFIOHpsRjRyZVJTeHlkRE44Zi8zWUdITmFJam14dUJkc3ozRWNQTDgr?=
 =?utf-8?B?MUFyQWVlTXdoWTd5TytudmxVbWQ5bWFKN1dFTWxkNE5sWDllRmVQQkNuRjJx?=
 =?utf-8?B?TGJKSFJBR05VcmRvMVhlUnIzVVZ2NXhSdG8xSUw4eVo0TEtOOEtINSt5K0g3?=
 =?utf-8?B?WHJhc2E5V01pRTdtUm9ybWRsZCtTd2E4NlZjb3ZadXg2Nmw4WTM2WGpwRHJQ?=
 =?utf-8?B?bzlGQzA5U01lNkwrV1drVVZUL3pmQy9haXRJYkJRWXE4ejhubXNib2RGeExn?=
 =?utf-8?B?V2dsSmZTb2ZkZnNwU21lWjBpaXlsSk16YjhwaWxvYm9jZzRqeGxSWkFVbEcy?=
 =?utf-8?B?cWdROG81K3BrQTNWd294M3lBV3gvY3M4akhaWTZMRklneC9aQ2JmaHE4NlBx?=
 =?utf-8?B?QXp6UUZNdU9KODlnWmpJZTFmN1pKb1E5VjhYYTRld3djV3J6anpUVUNUREx6?=
 =?utf-8?B?SDBaUktWc09ZYU5teDRZakJLY2dzVlExb01YTERWdlhXUDZTNkl0V0lxamsv?=
 =?utf-8?B?dTJxYmtSY0pTbENsR2VCWnp2eXVSczhIYUpkTy8xUWwxdVhHRFR5a3dDdHJl?=
 =?utf-8?B?R01hTjNuS1RQL2JKc0llZndaU1JheVdsYXJsUEE5Zy9jV3JFKzR1TnpCcGEw?=
 =?utf-8?B?Ui9EMCsrU2pCUHExalYwM25lRVhNU29XV2tQbHB1aWNST0QyLzlzUWlmTkhU?=
 =?utf-8?B?bWZrZ2c3VTRteFJkQjllditkZWdTT3JwR2o5ckU4b2liVHloN0pxTGI1VkpW?=
 =?utf-8?B?d1VlWDczQW1Zd1V6aUY4eWNrcHNNSUo4M0s3a1U0MENrL3R1cHRhUUtoNXV2?=
 =?utf-8?B?SHhEcUhCN0ppV0NJYnNqdnMzRFEwNkRaUDBHYTUvS3dZQkFlYUtUNllRMkZ5?=
 =?utf-8?B?MXUweFcyUGVFRFNDVXdDcDQzRHlrYTByVVBaU2NNc2N3SC82Tk1leE5JTEJq?=
 =?utf-8?B?eTAvUG1Va1Q4eTJIS1BxYWVqQVppcTZNbVZ3N1ZJODdDb2ljRnMwM28vV1lM?=
 =?utf-8?B?bFhWMW1sYytqbGQ4eThDYmllVW5VM2xNZjIrckpkNlB0N0xQOEhieDNOajkx?=
 =?utf-8?B?SlBESHZoOWRWSzVCYzNlSHA0SlVPTGk0WStZNUpaekl0THJtUXM0NmZyMmRK?=
 =?utf-8?B?NFVVVmtwem1tZEkreWc2T0tPdC9wWWVKVHFFdU42TndOWGtYZU5CbVgrUmUv?=
 =?utf-8?B?SUhGYW5vc3BpL2pLVUR3UzhTSzVHZDhlRkoxcGtoSXlvRjZOOTFzdGE4Z2xC?=
 =?utf-8?Q?X4RFcjpHeMKUMumH2TPPxWmaHFn04Ar+rY6gzYt?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2f132e78-aa1d-4927-b9ff-08d977915742
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR12MB5438.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Sep 2021 15:07:16.9830 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QjrNwsCrjcP/AO+K9OGH2zJhLn6o4tfoY+r19To9+QKRUwj2ux5r5ODkewHKuLoIqgI4Zsw4oHfUb9xoVdXwnw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB5454
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

On 2021-09-14 10:59, Alex Deucher wrote:
> Was missing.
> 
> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>

Reviewed-by: Harry Wentland <harry.wentland@amd.com>

Harry

> ---
>  .../gpu/drm/amd/display/dc/core/dc_link_dp.c  | 24 ++++++++++++++++++-
>  1 file changed, 23 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c b/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c
> index 6663cfc4eb71..7ea505109340 100644
> --- a/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c
> +++ b/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c
> @@ -1,4 +1,26 @@
> -/* Copyright 2015 Advanced Micro Devices, Inc. */
> +/*
> + * Copyright 2015 Advanced Micro Devices, Inc.
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
> + * Authors: AMD
> + */
>  #include "dm_services.h"
>  #include "dc.h"
>  #include "dc_link_dp.h"
> 

