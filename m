Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C37F8C001B0
	for <amd-gfx@archiver.kernel.org>; Thu,  6 Jul 2023 11:22:06 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3D9C710E4F5;
	Thu,  6 Jul 2023 11:22:06 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2052.outbound.protection.outlook.com [40.107.220.52])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9F57B10E4E6
 for <amd-gfx@lists.freedesktop.org>; Thu,  6 Jul 2023 11:22:03 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kbZKa9KH1lrnEWkqCrCEihpuAWjl0Wez80MDUcnR4sIeVStMwUrcyDeHlqOjov2wPh3ahqTfMs1uaCPRalGHIVCaL17xm5x3i08RX/qJwRylQf2KQX/qnw1brqV0X2D9E8tY3OfXwgd79U3C/zI+xTxYHxgmlAdEDT9OpsBvJlPIO4Y08wngH/PHBU1Hq2lvxhkYPYtcyIx02LELpynPO/vU1MGaaK7DyG5mEy9CxjU5KBjnxpUwDNYdiUadoX/TbA8FMH0t7vQ3c9FsQZmh4W3ns/o3CtPstlKTJLCf04EqqBQTu8EYATwyLn7vCqA21ZIcTQA2DhbCCZ0SuWB9OA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YgYJvxuGLMdssaBb1aeE96qHIGCugcyjbemW45VK/GY=;
 b=SodtO7yU2LHCbFiZXbdYSH8KTPw3ciORAnrRN0GpgcPF9JyBz/ylQ6wIE/csLL+5u/ch540HJi/qvUMlMa1300cxlc1pap2HFK4MLHydodIdhD2wnlqr5FJEjau52d/sy/GoIqBAmiskJt0EdhbVIkMVaH3+ch++9gkNfzMXOx+dyUBwWS54oapV00/XeGOhr6gSev9rqN2+Ouc/kXLzMQATdqaGY1+yFMaSOtqoBPWa3JeYMJ9XrGTVwXyP1mOLfPpyD5XGUP0IgpX+t+nQsuOdX2FzNcvnFJZCINFdhi7yn/VY4Ggo4W9F7cO8Dx+V6EdNzcJ1rIokJjn4lcXwKw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YgYJvxuGLMdssaBb1aeE96qHIGCugcyjbemW45VK/GY=;
 b=kLIwVsWOu9fBbHycL2gvQDEl9WzHaXyUhreSR7wBbS/VplPnHJOS3ldOnJghuZSsWstWNCA9mbWHLI0cDAIknGwsFcl0o4l6i7lypKmxC8/OzHz5XWRm46O7dc2IuWfGDPYtk83CDy8JNtMJGgqBIaF/qAkfgaJeQe0oUhAqOjE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN8PR12MB3587.namprd12.prod.outlook.com (2603:10b6:408:43::13)
 by DM4PR12MB6447.namprd12.prod.outlook.com (2603:10b6:8:bf::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6565.17; Thu, 6 Jul
 2023 11:22:00 +0000
Received: from BN8PR12MB3587.namprd12.prod.outlook.com
 ([fe80::384a:95a4:8819:ee84]) by BN8PR12MB3587.namprd12.prod.outlook.com
 ([fe80::384a:95a4:8819:ee84%7]) with mapi id 15.20.6565.016; Thu, 6 Jul 2023
 11:22:00 +0000
Message-ID: <1d5ab02f-c1bf-1e7e-f541-fda2545fca3d@amd.com>
Date: Thu, 6 Jul 2023 13:21:54 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH] drm/amdgpu/vkms: drop redundant set of
 fb_modifiers_not_supported
Content-Language: en-US
To: Guchun Chen <guchun.chen@amd.com>, amd-gfx@lists.freedesktop.org,
 alexander.deucher@amd.com, hawking.zhang@amd.com, flora.cui@amd.com
References: <20230706092306.1050029-1-guchun.chen@amd.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
In-Reply-To: <20230706092306.1050029-1-guchun.chen@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR0P281CA0222.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:ac::18) To BN8PR12MB3587.namprd12.prod.outlook.com
 (2603:10b6:408:43::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8PR12MB3587:EE_|DM4PR12MB6447:EE_
X-MS-Office365-Filtering-Correlation-Id: 3bf2f8ce-6a2e-4b3a-cf14-08db7e1336c5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: EJjppTQFf1L39MKGle+VYpGxW/IYHrcsIdtOuB9JYw8FxRkfD4h3Cn4AM/sL3KQOI7bMw5jNHwIaouH7gd4bROFES3BqqeDn0Bh1NX7eCyjW3QBQdOtZIo/31vDrm/jb579Bky0HrRhnF4dheuRZSk96riAauJf9Ga9M3XElOkHaQzKprjtPILSqBLICJYjKsC1U86VtElKPRoCOrhI554xFILTSB7N6C9mlmf6mVvrIaBbQiXojXaJNmqtLIuP4KCjxTxgINsRLiqIrvK0ber1lWDMgBs19z+fa/e1fQPQP7DXCqpGSiXzJ+obfLYq4HBEB/E3gg1g3G9FQicaLtS++rKdvYHr5YkWNFKemsL/4rWO1Us+KTDwvUC6m52t2lKGhXHHZlONysxp60lW6AsW9daCjuJ5ILbuMps+85VE+67dOYB/EH6PYTRjTq7DZbDFY0zguSOX6IJ7Xqi08OXHc3WUk1mQzlJwk3C0ETMcfjRiC+Zx1eCl/FcjOF6QHotZTZjlFDhVBbZd4aDbcw6GxYqvRWWmRoRPUHMzyOqjJrmVrjg88ezqDYlGtwB3jp/1uOVp4yXYqVnVGDOqZaJzJqAYFd1kfIIwHsGY79enIshCENTCnYNl9xViuvp2BzfcP2G9QBDMIWPjjaj04vQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN8PR12MB3587.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(4636009)(366004)(376002)(346002)(136003)(396003)(39860400002)(451199021)(6486002)(478600001)(6666004)(186003)(6506007)(4744005)(6512007)(66946007)(2906002)(66476007)(6636002)(8936002)(66556008)(316002)(41300700001)(5660300002)(38100700002)(8676002)(36756003)(86362001)(2616005)(83380400001)(31696002)(31686004)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Rko4QTdnUWRRY1QreUxwZmljNndqR3hLM3ZacVhRZlFsZnA0Qk5zOUxVUGNq?=
 =?utf-8?B?a2xJczNmVG9wL2N1QnJrSG5DRENEQngzY0JMN0NoY0hoS25uMVZFSlRnRCs2?=
 =?utf-8?B?RlhoUlJNVkdCc3c0YW5WMnNzbEZPOVFQbU5MZ04wUThsRXFOeTZxZm4zdDd2?=
 =?utf-8?B?cVJQK1dzR1lobTJXYjNVQUkzTU9tb0l1a1RjVG0rdWRMcDA4UitHT3IyMTBS?=
 =?utf-8?B?OFBwVWlMeHFXbXgyYXllcUtFdHZlcW51TUhac0MvbWNncFA1QmJFN3VtMFla?=
 =?utf-8?B?RkpQQXA3V2VjeXczRHJjYUxjbkdiUE5yclVkaFlZOUh5VlJOS1JoNHI3ZFRz?=
 =?utf-8?B?bWpYVEQ2TFRoSElnME9VK09vT3VGek9IMFdvUUlaa05YeFV2L2t3cnlyalJU?=
 =?utf-8?B?Y0VoaGJMOWZkSlYyblFtMkpOV0JZNVZ6QmpYRUY3cTErOVFpMVVBeXFBQ3lO?=
 =?utf-8?B?RFZ2TWRoYlltQmcyYlp6Z0NnNmRMWFNOeEdabHhmUGhHc28vM1phOWpwMXBP?=
 =?utf-8?B?cFhIaWlIZkozMGY1U1pXV1B1WlVlakZ1Qyt6cEFzSjBveGZlNHdVTUVqMUtn?=
 =?utf-8?B?MStKeFMvemU1ZVBwc09wTXBZcjU4YzJ4R05qSGVuWFczam1xSEcwWU5uSGRM?=
 =?utf-8?B?Ui9lVi9iU1FxeWtaaDFFWXkvNUJSRHh6UjBBVGcvbmY1cTJqYkNpZUZ5N3hJ?=
 =?utf-8?B?ZlUxREhHWFBPOFFuQUxLRTBaNC9OU2phanVONTVxZXI3ZWJuWThJNzdWcms2?=
 =?utf-8?B?cFhLZFhDUURPTzRDN3Ywejl4ZFRIQ0xVMUh0QkFjZGdja0RjMDBXNDRKZ0FH?=
 =?utf-8?B?dXNkTnhWRDk0Wm5ackdIQ01Gb0R6WXprVzRXNm84RGo2SEMxOXpXeFVHL1NK?=
 =?utf-8?B?Mm1WUVhicjZBbnF2VTRQTkNoWTZZaSt0Q0x3dzNOb0ZORzR3RmdsWmlQaDdK?=
 =?utf-8?B?VGtIWG0xaG5wWG1zamI4alZFYTQxa25uTUNtWU1BUTR0YXdYT3N4ZFhmdy9q?=
 =?utf-8?B?MGRWOWtmRm05RlNjNVJBNk83QkJRUjA0bkdmcC9Wa2NZS0FzaHovdFdxRXlF?=
 =?utf-8?B?ZDUrMVpZbm51S0dlVWxPYWdWcVdKb1I2RjJtTXVUM1psbjI0UWIwU3drZ1pl?=
 =?utf-8?B?M2V5UWJMNGJTUUlMWHpPQ0M3Y2p6cUgreTc2dUt0VlNKZXgwNEVYWGVHUjN1?=
 =?utf-8?B?NFZtUTBRa2F1Nk5YNzRISlpVKzJralpoY3phQXVBc0htbXBLL0VxUXBsRmhm?=
 =?utf-8?B?RVNrOTdWYUFRd0xXN1pRWTRUbVp1OXpOUTgxUzM4SStjMTdJUFBpL0RQU3Rq?=
 =?utf-8?B?YlVNT1ZtUzVvOUdWQ3hYSkFpaTFzSUQxZ0U2TnhkamhvNWlmRnkwZmhNL084?=
 =?utf-8?B?bWtmQUllVkVHOWtDdEt2RCtYV2EwTjlacXBwRC83ZlhzTFVxRVpndlZaaUth?=
 =?utf-8?B?UU1JcC9DSzlOdGd4Nkx0UXV4WnlRMmh3MWp0aDdJRW9QMDR6ZVF4bWRFMTVP?=
 =?utf-8?B?RXVSNDRhaDE0Q1pQOFdkaFMxSlE4YmphdmtBL29GNmVFRHZkYTBOc0JITldN?=
 =?utf-8?B?QVExVml6cVFzWXprRGxyTVBmUExobithYWp3MVZXdVUycXA1R01ycCsyaCs4?=
 =?utf-8?B?ZE9lRmdyN09KbzM1aTZ0SzhJNk4zbERSOVRTODdTRlN3dFhBK3AxYVN3L0hM?=
 =?utf-8?B?Z2UwZlJzd3o2dmhXTm04MUNIdW8xZGJzRWpjU21hTzhTaHkxelp5ZUFxNm9a?=
 =?utf-8?B?VXpsZ1JHc01TRzBwalRZa0VNMHByZjJKMFQyZU4rcklubDdpWVY1ZXdyWHla?=
 =?utf-8?B?T0dBUkQ2bnBxdzF6aTIzYXpTZXo5UWNhWWY1eHA3bVk1R0J2WW9SNElzS043?=
 =?utf-8?B?ZFdQUEpFaWw1T0p4emR3RnMvMkY1Y3dDbWZldE4vSVY2SHY4b0xaalpoSXpR?=
 =?utf-8?B?eStDUXZwc0FiZHpyYVd0eXdTb1ZaSmFSbXhiYklycGVKRUdkYnZEUnAwVGdy?=
 =?utf-8?B?UHlHWjN2K2lxQjNCaks0RThUQkI5MjFkR3UreCtWQTFaK2luRmNvMkJveFE5?=
 =?utf-8?B?U3M1d29jTlNpUWdrNlRvOHZUNW1SWWdUaFdaWGdkZU5vUXVIY1Vsb1FBRkE0?=
 =?utf-8?B?aGhXRmYxdHFoTGUveHBmYldMWXludlFadzJKcUFpQmk5VEwzdHNsSUlXUnl2?=
 =?utf-8?Q?KTpxGfRlYC5XiUleEi828gTKtSP/lwDLRtdzF98JVDaf?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3bf2f8ce-6a2e-4b3a-cf14-08db7e1336c5
X-MS-Exchange-CrossTenant-AuthSource: BN8PR12MB3587.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jul 2023 11:21:59.4714 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zZyRSs7Aam3pglhtwlXtYZXPJ4uvQD7yqaPYZRnB3bCkkmF2TqcwIZ6tq66f+0eQ
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6447
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

Am 06.07.23 um 11:23 schrieb Guchun Chen:
> Due to a coding typo.
>
> Signed-off-by: Guchun Chen <guchun.chen@amd.com>

Reviewed-by: Christian König <christian.koenig@amd.com>

> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_vkms.c | 2 --
>   1 file changed, 2 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vkms.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vkms.c
> index 70fb0df039e3..2a318c6d2cdf 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vkms.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vkms.c
> @@ -500,8 +500,6 @@ static int amdgpu_vkms_sw_init(void *handle)
>   
>   	adev_to_drm(adev)->mode_config.fb_modifiers_not_supported = true;
>   
> -	adev_to_drm(adev)->mode_config.fb_modifiers_not_supported = true;
> -
>   	r = amdgpu_display_modeset_create_props(adev);
>   	if (r)
>   		return r;

