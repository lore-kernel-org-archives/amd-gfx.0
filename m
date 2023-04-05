Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0A0DEC77B6C
	for <amd-gfx@archiver.kernel.org>; Wed,  5 Apr 2023 22:06:02 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8B1BC10EA3E;
	Wed,  5 Apr 2023 22:06:01 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2055.outbound.protection.outlook.com [40.107.220.55])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 68E8A10E4BB
 for <amd-gfx@lists.freedesktop.org>; Wed,  5 Apr 2023 22:05:59 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bGg1OLa3LxH+KHfuGHwQcXnLOFljKzoF7DvtehmcrjLDhoPcAmTfSWD+ToHUFSFWXza/75FafXgMUnjzDQl09db/0IEIXJKCTP6ebcNOQFT+RefdKsNJelrfQXJ2ZO+TDqq5+Gdslho9VdfxrD8mTgVeZP03NRIfcolWG1LBdOkvs1KMJPEjzbhUH6/D2wpFO125/vY+e2ZuynSAttXfKn/zMclkWnn/6uv62ytDQTL3wcLfeqqpwAenmQdEJTXu01RCNX71SzZ/+4+C795NvOk8tkY75i6jWUgr10YDpX06xQqhpJAtlOt42qpvRDsCwhYDO29sNfxU2MAVkmwWaQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7ebedvii5Yowo8cYOpHmBI2rRYmHQHm9yHhA2cgniKM=;
 b=Mc519fP/Yl/RD0QClEoS1QcINcOISMbH9LJmKhL39JxJhRaOmAnWtZ6HQwAm0/r/hXspdDGX4LPxntMOG2ZxtqURSR1k2fmaAvAr7497Hbad4Sf40r3KHiS/pblroQp+HptVZp2CrDDK/L1q8gDv7GFkM1G382eira2DBvmquMBJJs2xvnjGkKG/UTusOntFEKMDeyWtgO6T9VuYjnVuheS56BM+fNG1CKYDX04iZxjhqCWbKfTluL8KxIcM0Fzu6VFzAt7thyz5/i7Z3EVW3G372A3jetDaY5KVsaCZkDlWWXKriqQUoDb3sPBL1nCh+5Ph/j6Zh+zOPZjQAbQfLA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7ebedvii5Yowo8cYOpHmBI2rRYmHQHm9yHhA2cgniKM=;
 b=Nz/jpDMxcfHE+YranHNNMII8uhduZtYPnmOZXgekWdK97XsWYM2NzqfQ0H8DhQmzov1LMmp54fyACiaPcjA2t58jK9ymKWjZCZ7rrtrSKhctIIX4kDJnlR6ui7pM9uky6UFbPnpKjoEYY16j+vDC7dfsWmIO0MTP5fJPB+FD0VQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
 by DS7PR12MB5720.namprd12.prod.outlook.com (2603:10b6:8:73::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6254.35; Wed, 5 Apr
 2023 22:05:56 +0000
Received: from MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::f4d:82d0:c8c:bebe]) by MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::f4d:82d0:c8c:bebe%2]) with mapi id 15.20.6254.028; Wed, 5 Apr 2023
 22:05:56 +0000
Message-ID: <de75d47e-169c-3302-8501-f0bdf5323346@amd.com>
Date: Wed, 5 Apr 2023 17:05:54 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
Subject: Re: [PATCH] drm/amdgpu: skip kfd-iommu suspend/resume for S0ix
Content-Language: en-US
To: "Liu, Aaron" <Aaron.Liu@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
References: <20230405112921.3690452-1-aaron.liu@amd.com>
From: "Limonciello, Mario" <mario.limonciello@amd.com>
In-Reply-To: <20230405112921.3690452-1-aaron.liu@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BL1PR13CA0248.namprd13.prod.outlook.com
 (2603:10b6:208:2ba::13) To MN0PR12MB6101.namprd12.prod.outlook.com
 (2603:10b6:208:3cb::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR12MB6101:EE_|DS7PR12MB5720:EE_
X-MS-Office365-Filtering-Correlation-Id: cecec10b-8f57-4764-6abc-08db3621ee06
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: HeCzPQgmyl77Q79onUSwB70y0expBqRm+7rZjsMpJnB+aP6J5Cc8nF1aU5UY+DGAdJ64oYolZ+rFCJEWE+f6XqYNPHXM4FXfnFkpebxGBYVhQNd97ai5945YUNgsSVvHIL1cSoH8jFt+NfC+YmvGchzfnGVS9lQlme8BLKXg72SGuxj5WMxK6CaOuLGcdKB9Llr1WpMJoWojGNTcGNHXJ97Zy4X7AAg7IlufZcRESv+APax8Sr5GEWkuWspNloEeybusswmDz+OuOhzkmvGlffD3YHt6aXSNW7U9j+lQxhS3RtJ/4MAX7YW+UQDHfUByEN7irweKTCOuhZGk6jvi5NFokkBxAh6MDXsonCuGXNBTUSeLvXrEQE0CS0HBrAo+lKfo2F0BOSBT+3/5SOYhNVRVkUTXh/cHiOdXaiwOBom5dy+lyJeTYH1Yj/FUgjbYZ+KcSKpgcFjTRmIKt7nhQvBOqaMo3rtYWEJhJ6Ezv2MHhF4Ai0U85cXK2OjiFf+YcBYi/e54Pce3pp260EVkuEewZ/RlVz4lJ8VfQ/7Z2CnYmif8LBfcjbTk/iHCyXLRLj5Ln4zjvCezGF6zKzaD2hOeu5pwTYAL2cMqrqG6/n8U9SjxV9fM9DV8zesSWgX1
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN0PR12MB6101.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(4636009)(366004)(376002)(346002)(39860400002)(136003)(396003)(451199021)(31696002)(31686004)(38100700002)(66556008)(36756003)(5660300002)(8676002)(66476007)(41300700001)(66946007)(8936002)(4326008)(86362001)(83380400001)(6486002)(2616005)(966005)(6512007)(2906002)(53546011)(26005)(6506007)(54906003)(186003)(478600001)(110136005)(316002)(32563001)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dGwxWWl3VmVleHI4MFhDVUVRbDg4TERIbXZzanNhNURFVTJ2SHVQd05kTVor?=
 =?utf-8?B?ZUN6djZrbEcrNW5WS2ZXdkIxbnVNa3FlVWE5YkxCWFB0MHdOa0p6MzJpSzRs?=
 =?utf-8?B?R0EyREljRTh1UjdjR2g3L2JRdFBjNmNvR3J0UVBsekhVeFVBbkFkUXRlNUJ3?=
 =?utf-8?B?SnAwMStIL2VadFBkaGIwaWRGaXF6MHB0TlhLVTNJNEx4anF2S1JpSDh0bUda?=
 =?utf-8?B?aVU2YWZCd0dIZmJkOEZDY0N3NUcyTUJpL0NUWUpMZFlWbFhQbXJCSWVIbXF6?=
 =?utf-8?B?YkRJWEcwUW1FMWMyY0VoWkJkaHluVEZINUpRQUJFd01ndFlRV2J3OVlXLzBP?=
 =?utf-8?B?VTgyd1FSNHhNZWtoSVhTRVg5V1VUU1E2bjFMelJYUGVzYWdRVVAzREk3QlZK?=
 =?utf-8?B?aGdYQXpnSzl5YlBVTEhES3d0NUJZUnFibmJYZEJ0SzZETllHRXFaQTgzVHhQ?=
 =?utf-8?B?cDBXSDN5aEIvTzNjN05WWk9GUzdqeU92Q3FZVGRXSWtENStRZTlwRXJtOXNp?=
 =?utf-8?B?RTU0bWczcmZ1aU4wd0h6bzJ0OWtXZER2SkZ2RVRBSFFjMmZvTWdnU3dMWHNX?=
 =?utf-8?B?YzlnaG9HOU1JVm5NbTVaK1JJbUFndEZ5ZUhheklTVFcxT3F1VkJnY1FmR2p1?=
 =?utf-8?B?TDg5NWphWWdwcWNNY2dkQ0RjSHBzKzJmWlNpaGhrVHJmUm5xcFVzdUhwbXR1?=
 =?utf-8?B?NklGVk5CNm9pYzBCZ3V4TGhLNnVZdEZ1aExNQ09rL1dScUJScUxTS0g1WE9n?=
 =?utf-8?B?eUV3bXBtVEJSOVFQL0dzYWdEaWtHUHo0a2Jqai9VWms1RXRBd05aZ2JQaVlP?=
 =?utf-8?B?N1J6MVUrc09aMXBaY0ptSGU5N0E2SmJGUFh5aG9JcGViRHJrb3k5UmFtL25X?=
 =?utf-8?B?WDhnRXNwdnNiUDZPdlQxOHN6MFIzUnRJQTR5bkJBMmJLLzl1QXArQkJ3WUt4?=
 =?utf-8?B?Sm1DSVlMQnNhWWdvNnkrOWdUQWNZeWd0czJMWFpmREdob0dsREcwdTE2TzQv?=
 =?utf-8?B?aC9ENXZISzQ4aEtGYjZ6Q3A1cERPLzMzNENQYTlLRUxGMnpuTG9jYllNRnox?=
 =?utf-8?B?UWZGMlBOeFBERW9ic2NGMFlZc1JNc05pdnJPOHlpT3FtRUZtTGQ1Y0s0a3kr?=
 =?utf-8?B?R3piamRxQkQ0d241bDJidUhnb3puY1JnNG90ZWdtQTd3WkNtdHczZWFtM3RR?=
 =?utf-8?B?TjhIQmRGT1c1R0J6dEMrQWZTckVySGVOMGI2bS90TW9uK0hiWDFtcFJ2SjJn?=
 =?utf-8?B?YkkxUjFKSzF4NndPZkZHREgyVzJ5cDBha1NQS29iZkJxc2lsdDd6T28xYXVn?=
 =?utf-8?B?bmxLZHJoQjVOZXY5ZnpoRll3ZGsrU0NPV0VoTjRCVG1GWkdrdEc0Sm5MYVl3?=
 =?utf-8?B?NzNVNllKK0RTVnlJd0U4U2E2ZisyL1JzSDV5MjArVHV3Qi9PVWQ1M2xIdFNj?=
 =?utf-8?B?elNHVVo5MXdmRmxQaXduT1ZJc2ltZmRnR3N3dW1xaUtXQWNoemwvQXZjSmVz?=
 =?utf-8?B?S2NBWmNqVlBwbjBZSk96eDZMc3pxcFM0SDVhZzZkZXdSejBKbnFqOHVhU09u?=
 =?utf-8?B?Rk9Ic1lVU1EyYzlHcGtaNjEwT1c1MzhsR0V0T2svNFJNVDVsYUpQYXRnQ25q?=
 =?utf-8?B?d2lOTHdGRnFKNHJXd0VlL0FRWVdHNTQ1MG9USGlScmhzcndneFVlVllWaGN6?=
 =?utf-8?B?dHdBZXFBK3lIOWVONUlmYmMzUVIrOXJXakFkek4rWEMzTFVYZHhyaGpUNFdt?=
 =?utf-8?B?dmhqOHNhS2pxZTJleFVFVmkyeHY3NnVYWDdIamN0bEZpUEd3N080b2lUQ0JH?=
 =?utf-8?B?cDlSVjBsbThIanBvOEE5VGpFdWNDV0xhb3hHbzJDTVVLS2VOZFBRTDQxdEpt?=
 =?utf-8?B?ZUxVczd5K2lhekFkZXRUdG82VXVmWjNISmpUck9MQ0lvWVlIZUtIVlVuam5E?=
 =?utf-8?B?SEh2MmZUQUlsTVdKb0N4K3U5Zzl5MWhraDlodk9CK3ZNd3BaQk1OZ3l2bkdv?=
 =?utf-8?B?bnRuNWNHQ2hzTE9EQlF0RDJuVFJzb0k0OVpyM1d3U0RIQlF1UmVnQy9rdHRS?=
 =?utf-8?B?TUtqM3BNTm1QZ2MrRzB4Qmt3dnd2T3pmcm85eXBseTZxMnpMak9DVmpPblk5?=
 =?utf-8?Q?gJNbpvtcK7er86lWc6ABtG8QO?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cecec10b-8f57-4764-6abc-08db3621ee06
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Apr 2023 22:05:56.0805 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +XQBPtiSu1bAWiNu2ggi8bHjR0KnXj0xUCbQOajo/V42MD+OvXOdSiXFxMvDMot+ZbLI1TbzAxecjDQLLHz7YA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB5720
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
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Kuehling,
 Felix" <Felix.Kuehling@amd.com>, "Liang, Prike" <Prike.Liang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On 4/5/2023 06:29, Liu, Aaron wrote:
> GFX is in gfxoff mode during s0ix so we shouldn't need to
> actually execute kfd_iommu_suspend/kfd_iommu_resume operation.
> 
> Signed-off-by: Aaron Liu <aaron.liu@amd.com>
> ---
Probably should add to this patch:

Link: https://gitlab.freedesktop.org/drm/amd/-/issues/2449

>   drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 8 +++++---
>   1 file changed, 5 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> index 3b6b85d9e0be..5094be94fa06 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> @@ -3304,9 +3304,11 @@ static int amdgpu_device_ip_resume(struct amdgpu_device *adev)
>   {
>          int r;
> 
> -       r = amdgpu_amdkfd_resume_iommu(adev);
> -       if (r)
> -               return r;
> +       if (!adev->in_s0ix) {
> +               r = amdgpu_amdkfd_resume_iommu(adev);
> +               if (r)
> +                       return r;
> +       }
> 
>          r = amdgpu_device_ip_resume_phase1(adev);
>          if (r)
> --
> 2.39.0
> 

