Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3F749C433EF
	for <amd-gfx@archiver.kernel.org>; Mon, 25 Jul 2022 01:38:15 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9B77F1138CB;
	Mon, 25 Jul 2022 01:38:14 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2047.outbound.protection.outlook.com [40.107.92.47])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8E69C1138CB
 for <amd-gfx@lists.freedesktop.org>; Mon, 25 Jul 2022 01:38:13 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WuR/V0evihtI2xLk+vT9lPj5iQWBZ38cwgdQqa3jwwoVjrop8bIbM2QimqGBOUYRuJRiGEV1Lo9Lj0kXzvJTh2/O+yoBRrZrPbAwEKonm4TZDO2Aotpw5rFmREPw1gzHv1H662uEN97d14+DDOWiXe3UJsWx/L4S7yCj4fuKNAekSi2MInriU+RPPf5sbohCJUJ0Jm1JtnFlY3Ds88ozzHprtu9WNauVaLD0dU32c97zMLecxYAvJE5J2MRwJh3VMEH2I/nnAMyMgo7NsgBLJOGMzsA1ay1CF8mC0m+zPfw7B5KXGEnHuAT3WpP5CDHmKLJFoD56T2Q1tDaoHXsv5w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1qSSrHZBvabr0fLKD2PCyUJYuqUworgGT0FW3ZBOoxU=;
 b=BoJEvOXo6SUf8poBW+bDONguEOLG58GDGmuGXLEb1gClZqOFcpkkdjKWfaQD1q/0GtmdrF8e67kbHYxesXgTOtVA9eI2Vop8BWYe4Rr7SczyhRCSafyw7S4Sem9ieTXEDOOlES15dnsDVUauhjV0B3wVh8elfS6DBGbGzmt5eKG3atsQPFjQgyzfCTxivpcJfj2o6wRHnY8h2WHJ0PZSe+1up6fhl1P/yVfWb/2xfhcE2/TnVexqTNNp25mWmdA/jBRF4mb2uzbVmZetFsbMT1037FywssiBdOh93KeJp2//v0jJVpY3qjDUy+eN7mj/PnDtTKnH1/wBYMqvreI/7g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1qSSrHZBvabr0fLKD2PCyUJYuqUworgGT0FW3ZBOoxU=;
 b=moZWvei4CKJYk0Gxn1z78o2mZfPczlIR+gwhOide8dzOGDnoH8Dv6Ychii29cEuNASGFJvncsM0oJB138sxU0UT2wBkC8pr+/ABJ3YKHtNgT4oGRFIFyfSwE/ym14Sps3O4uaLXa2ILnBtJ++IB7bfxakaa6qOe6FfM4UIRtkKg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM5PR12MB2504.namprd12.prod.outlook.com (2603:10b6:4:b5::19) by
 BYAPR12MB3222.namprd12.prod.outlook.com (2603:10b6:a03:12c::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5458.18; Mon, 25 Jul
 2022 01:38:07 +0000
Received: from DM5PR12MB2504.namprd12.prod.outlook.com
 ([fe80::ec80:e3fd:e3e2:605d]) by DM5PR12MB2504.namprd12.prod.outlook.com
 ([fe80::ec80:e3fd:e3e2:605d%5]) with mapi id 15.20.5458.024; Mon, 25 Jul 2022
 01:38:07 +0000
Date: Mon, 25 Jul 2022 09:37:46 +0800
From: Huang Rui <ray.huang@amd.com>
To: "Liu, Aaron" <Aaron.Liu@amd.com>
Subject: Re: [PATCH] drm/amdgpu: add =?gb2312?Q?dec?=
 =?gb2312?Q?laration_of_function_=A1=AEdrm=5Fneed=5Fswiotlb?=
 =?gb2312?B?oa8=?= in gmc10.0
Message-ID: <Yt3z6h4LsRJF6T2M@amd.com>
References: <20220725013027.1423657-1-aaron.liu@amd.com>
Content-Type: text/plain; charset=gb2312
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220725013027.1423657-1-aaron.liu@amd.com>
X-ClientProxiedBy: SG3P274CA0005.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:be::17)
 To DM5PR12MB2504.namprd12.prod.outlook.com
 (2603:10b6:4:b5::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 3d192320-1495-4f8a-942c-08da6dde52bb
X-MS-TrafficTypeDiagnostic: BYAPR12MB3222:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ZSKDtkoMNtW+PYU9QM4NkD30EsmegmHjZpUiB/d9btYGg/pciobdzqdtvdSauAHzgUARhUDBJx5RXOPuK0muRoLrcF8cBtofqPDdf9wOUMMISZmAB05savt3MhEEHmRAibEE3mcnVll/JjaRt/CeDPzVlVECWC1Olp8T8ZYCJR3Q8ongWkaO/+izL+E3sQEEapcEV5YqDtYt0Nn2gejp7pbQUtkrb+a1H4Sw96dze0OVdm6ahuc3K5ds/LDXnVKr4i/N633ClQhlU19qXaTHx7I9w9ZwbuTaKtHA6X2O0py2pNPWBisRrRYhRfnUTIYmZZ3pme443edb5WfDFme9Ovokgiywuq84YPEForQksxTBe0M5deaD/fqB4L7aZ7ojwzA/qZ2W4LMMIrG2wFaD5mPaQMtsmbxk1KYQ/akwY6Ztt9tNx6VG8qDwSHTiMpHf7BdOW2IH0ZHrYvNGLK73O+HeegB4X9nmMYSCpRfv637MqUNUHRaVOacW1oVjx4nToH9CjXkfRT6UP8YHRP9mkyGJr5JB+z3MUWQxVtZI9/a0x8XsVa/rek7k8B6cegk0zceVfdh0ZcyqRmkfRWYW/UVl80uhNnw0ro8zevyjs1s8e2abmxPjXZzw49YZpBjKpZ3tHkV1v/6eUeNuPe6qr2IwKZsXMg1uTbHYbsrTBX0YP0Ze4iBXpau82qLkLuD5SJaKNYDmt/y3SE0glI4Q4rxAMDZhqjnY6E7phGqNvSanqk9EV9Ar0R820zbs49FG
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM5PR12MB2504.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230016)(4636009)(366004)(396003)(376002)(39860400002)(136003)(346002)(4326008)(66946007)(66476007)(66556008)(36756003)(8936002)(6862004)(6636002)(54906003)(37006003)(316002)(38100700002)(86362001)(6506007)(6486002)(478600001)(41300700001)(6666004)(2616005)(2906002)(26005)(186003)(5660300002)(6512007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?gb2312?B?eGhDK2VNb3VwdDlTcE44S3R4eFZYV0NwWmlqU1UwZFRQQjBXSFQydGRlVDhD?=
 =?gb2312?B?ZVc0QXdTN2orc2dQZkErR0NDYkFlaHcvTEdKampid3ZsRGVhVjE5K0t4R29K?=
 =?gb2312?B?Q3lMMlpYbStlTXJxRVRWUCtncHpyUFJYRk1CN0pLR0hDQjVTdkpMcmZnWktt?=
 =?gb2312?B?YjRWZkJrZkdVR2dXTDBZRmNCUWxYQmNDTHBUeDdMcEtKYTI4cUhlWkVUSk1v?=
 =?gb2312?B?Z1cxMWFnV1lEVjdmMUVNZ3pGZk1UM003dFB1UkVvMTNYSlJRdjBHSkR6T2tI?=
 =?gb2312?B?NmxTV2RYSFd6MVlBM0grRnZsbTY0NjAwSGRpK2JpNWtDQVB4NkJxaWlram5D?=
 =?gb2312?B?OXhFZEZkNTYrOHZpdmh5NUFWdE5LaGFjS2QrcjhvWW5PN3gzTjJ2NXFJN0cr?=
 =?gb2312?B?OExGQ0VoV0cyakFWNmh1UEE2Vlk2eCtpcG9wekg4V0JPdnlPL1lWM1RQMTZB?=
 =?gb2312?B?U09kS0plUVFVeS9NbDR0Ujg4Z3M4MzhGdXB5VzJ4aG15VHhYLzJ4YU5qcTJF?=
 =?gb2312?B?V3ZFWGJnK0N1UVJGSXY0YlJNMG1MUlVNc0pEZm84cFlWazBsSkhQTENSNFhU?=
 =?gb2312?B?L2VIQ1Axek1jR2NQTTczUkljbDdQQ2JGRVN3K2ZkWmtZK0FCdjZpSTg5VXZm?=
 =?gb2312?B?UGJBL2VaZUFBamx6elhmWTVsMFFjWTRlY1h2OEpVaTlSdUZSY2NLMUVSS05Z?=
 =?gb2312?B?aWJjckpzRWYvdXVkMGdHemp6cHJuWU1xTi8wc25tUnVVcmYxYm1VQXUzOFND?=
 =?gb2312?B?M2FQakVBaUNjRkVCbHVFWDhEYXhObWlPUXhxb0VOQjRLL203dk0wRW43VUhq?=
 =?gb2312?B?OVRiSTFyMitLdHc2YlNHVUo0N1R1d0dydmUrbGRiZjU4SnphVDAvTVIycm45?=
 =?gb2312?B?eUM0WlNVYlZMU1ZuMDVmS3NweWtIZTE2c1lvRFFxcUpDOWQ1bm5jVDRURzVE?=
 =?gb2312?B?ZGQzeVhhQXd5RGlpWTlWMlBoNUx1d0tTU0hVbVJGU2RHclZ3eWlsYVRzN21q?=
 =?gb2312?B?UGlwQkhoL25iS2hYRkpwTWhnb216UmI4SXFXcjlRVU1WdElCc3JiL2FMc2JZ?=
 =?gb2312?B?REVJTzAwWWFqVGVkZEhsbTZmdllaTDd5NS93WjliM2JvU2V1cW1VUmpwb1Y5?=
 =?gb2312?B?d2ZhY3Zwc1hpWTBXV0ErdjFNQkpZaGMxNUdXNlI5b3JXUmRrZm92ZUptdHA2?=
 =?gb2312?B?eUJGblBuMjRoWlV3WG9rWHVxN21CcHlZRDQyaG8xWEUrZTllUzBOVVFrUWxI?=
 =?gb2312?B?dURuMXBlUjlSZkpRTDRJU3VKcUtqRzJWRGtqN2dsYjBlVWEzNFFkRkR3RjVX?=
 =?gb2312?B?WS9PMXU2Zi9NWHVPeGtUUTU0aERYS3YwWStOVUN6MWU0V3YxSEMrVHZ2Rlln?=
 =?gb2312?B?bVhEMm9LejVWcjlheUNpRkRZa2lCS2lncUdYV0VFTUgzWitnY0YwMU93NUZR?=
 =?gb2312?B?b0JrNWp6T1FYOFp4aWM1YUdmMCs2azRsaVBUTkhPQitKRHVzTXE0bW9IQ2RS?=
 =?gb2312?B?bFczVTcxaXZibEgrOXJoaEVOSGdRU2FHMisrV2E0MUhYMUkvRE9RTjZic29L?=
 =?gb2312?B?anlHOE1QeCtJS1BadVFTV1lSTllnTHlPY0hPU1Q4SDFNdGNzUjVPTG0wM1Q2?=
 =?gb2312?B?NHpLYTdLVS9icEFHOHJ2ODZzQVhCR3I5K1BxdnRyU3Z2MWVCM1FoNlROQlFm?=
 =?gb2312?B?NTd6RGtxdG9YK245TUJYRWYxY0JKWGhGOFlORm01U0pka2lLaDlvQTFveUtL?=
 =?gb2312?B?Rm9GYzFsbFpsT3d5bU1WSXYzemptSG9OWkoyWTNLLytpeFFabjh1eTJ3RS90?=
 =?gb2312?B?aFhCZGVhdEF6VFBacWY0YmI0NEtDQ0NqVXpCajcxUTNJUkZuZHFzR0paZHkw?=
 =?gb2312?B?UkRtMkc1R0V6eDI0ZmQzNWNmUVdybHBITW1kVThLaXNJTmFmOWMxY3RnaGcy?=
 =?gb2312?B?VFY2TTM3TUpvdDMxTGZRK1Y3OC9OcFNWV2R2eWJTMDdld1dEVFV4UU05NTZ1?=
 =?gb2312?B?VFgwZGFZUUJHL25sQ2pQd21ZdFdqWllCK2RSZCs0QU9NcFFsOHV4UWFIVk9I?=
 =?gb2312?B?VmhEMWJQSS9iUDB1M1UvbE5WRWVFZ3BsSnRCNHB0R1ArNjBmYVFQOEZVd2hF?=
 =?gb2312?Q?jBIFscKBTV00mfQdRwzPqiZST?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3d192320-1495-4f8a-942c-08da6dde52bb
X-MS-Exchange-CrossTenant-AuthSource: DM5PR12MB2504.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jul 2022 01:38:06.9694 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: C2CoVXpwPuMdsMjrgOSbjh5e0qJ+4lwbPo0ywysQwavuiHBneB12Kap1TYjnuXgukpN0HF7cQb2HQJALm6ogjA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB3222
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
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Mon, Jul 25, 2022 at 09:30:27AM +0800, Liu, Aaron wrote:
> Fixing compiling error:
> drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c: In function ¡®gmc_v10_0_sw_init¡¯:
> drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c:983:23: error: implicit declaration of function ¡®drm_need_swiotlb¡¯ [-Werror=implicit-function-declaration]
>   983 |  adev->need_swiotlb = drm_need_swiotlb(44);
> 
> Signed-off-by: Aaron Liu <aaron.liu@amd.com>

Please revert the one in the amd-staging-drm-next, and squeeze it into the
last one. We would better not separate them as two.

Please make sure the patch can be built successfully at least before push
it.

Thanks,
Ray

> ---
>  drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
> index f8fa27b7b53b..9ae8cdaa033e 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
> @@ -22,6 +22,9 @@
>   */
>  #include <linux/firmware.h>
>  #include <linux/pci.h>
> +
> +#include <drm/drm_cache.h>
> +
>  #include "amdgpu.h"
>  #include "amdgpu_atomfirmware.h"
>  #include "gmc_v10_0.h"
> -- 
> 2.37.0
> 
