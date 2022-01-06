Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0834FC433F5
	for <amd-gfx@archiver.kernel.org>; Thu,  6 Jan 2022 09:17:20 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 71533113F13;
	Thu,  6 Jan 2022 09:17:19 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2071.outbound.protection.outlook.com [40.107.223.71])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DF6DE113F13
 for <amd-gfx@lists.freedesktop.org>; Thu,  6 Jan 2022 09:17:17 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HebspqudHj9BoEJqBFS6RXXD+2U3Ivb/sYZX7Qop5OMYkb3GUzwUmng4AWerwcDXxN7lqYqbir0vUz12GaZyD7nGLvRT9jZWD5CYVfjmWElHKqRhwg2KdtqUxUU4MfiHlimslB6a1McJyYeZbJQrh5FxQHeAQwlJklmJF4iXqFdtieN+vnvfk/nkeQWkekXcyXv49sEuGyyjXyQrPEnibOcoD1P5nZ5Higo5N3KWB2KhsHQnkA3t8Y1uzkh8zJWkA7x096OwQy+FRQJSProHcFkv1I+e9auLBvbZbDlVD16o9/unOsRceXSkhICPbUSh+Ozs7yaWGs++k5NiDhOkbQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nLv3p+1ZM+7GNmXTAhmKKojvJag9mnpPx25R4UmJQzY=;
 b=mpSqkd7SKcSNYPODcye0spln+wbJT4CkvoK/SrGwIZO+7+2O0p5jRs62udAU8j2IUhvwOM4veykw1r+mokQ+q5bmOiGg/wxoG/y2fcKMrF6CHuDuKA4S+gg0A2P2Rdh6uK0mvPGrP9589C18iB/g953dlK2ek69/3SlXi98fngYTNkaHCVvnpc60CG2otTqkDVrbu8+S6K8XU3ADY8jO/RzMNKVpdBo0eEQp0rxlVdDQNKU1p5uGhy7OTfJx3hPQ4AEuC8xHm88SDB4EX2ppIC9R0dZS+YHlg2spwrVPE2CD67C1AknTtJkIfPjawD3MMAlKRRkiuUxZVBDgx/RxQg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nLv3p+1ZM+7GNmXTAhmKKojvJag9mnpPx25R4UmJQzY=;
 b=tBE+U1TMUSrnqucpZXg3KzYFdIBt6hAXiHgwkywN4yYoSq0luW/S4FFg8Hv19hgOfxVVAN3rLT4XmkiB1cJjAz3CaezDNqjGVe6otF0thGB1rkB9B6YBnFJpaZmhuw++W6+Kgiid4GMNL/+EC+M2OdfjkQEU/3DzWIeL1wjgA0c=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MWHPR1201MB0192.namprd12.prod.outlook.com
 (2603:10b6:301:5a::14) by MWHPR1201MB0239.namprd12.prod.outlook.com
 (2603:10b6:301:50::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4844.15; Thu, 6 Jan
 2022 09:17:14 +0000
Received: from MWHPR1201MB0192.namprd12.prod.outlook.com
 ([fe80::b4d6:f148:3798:6246]) by MWHPR1201MB0192.namprd12.prod.outlook.com
 ([fe80::b4d6:f148:3798:6246%7]) with mapi id 15.20.4867.009; Thu, 6 Jan 2022
 09:17:14 +0000
Subject: Re: [PATCH] drm/amdgpu: Use correct VIEWPORT_DIMENSION for DCN2
To: Harry Wentland <harry.wentland@amd.com>, amd-gfx@lists.freedesktop.org,
 Becle.Lee@amd.com, Rex.Huang@amd.com, Ray.Huang@amd.com
References: <20220105203901.52175-1-harry.wentland@amd.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
Message-ID: <8e83de78-d17e-666a-fc4a-189fb116fb1c@amd.com>
Date: Thu, 6 Jan 2022 10:17:07 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
In-Reply-To: <20220105203901.52175-1-harry.wentland@amd.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-ClientProxiedBy: AM6PR08CA0039.eurprd08.prod.outlook.com
 (2603:10a6:20b:c0::27) To MWHPR1201MB0192.namprd12.prod.outlook.com
 (2603:10b6:301:5a::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ab4bfd72-8c31-4c25-e08c-08d9d0f55392
X-MS-TrafficTypeDiagnostic: MWHPR1201MB0239:EE_
X-Microsoft-Antispam-PRVS: <MWHPR1201MB0239DF83CB872A77A97B0CB1834C9@MWHPR1201MB0239.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7219;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: CFe62UZ0BaXOaGiAEQmZ6UL6AVj57WJoMz0BlmKTlXxBtyQLXmr5pwBZ+6nbuNZlghFarj88hCDP+xAzvW5a6lOFWBRhy2vbCuJUmySdJX3jTTn9BcAmeFdWVhgEOKBzKZxqPKxaSavW0z2Est68IEHtH61eb7R+SJ4Is8qdS7/DkeAuqeZbXMYhLwx3vcE6dDMIxZ7U0es4vvUXuyevBtnB44yyOAZa/OSqBgkyLwsCIreeoT15FkhOjnwu7SRl3pp8ZBLwtKmuP64XjansZD243DFbVpaCbmqw9KOYzpX1E9OFWsM/pZdNlbo9Zx5ZhIhozn1EP05vMU5MyJ914YV9ZIPiLCRfXldULzvDkYNuL/scwc8Q9RL1WJoxkgT65sHfUa7fv/vL/dlWPYdGQ3XhvtUDumw78IbWRzfFmUKYi6Ic5PmW5pRPhPEUOxVtC6dxsBIZeoAGVhrKxBOrSjH9BROSTxu9jdLYfl1jEfh8kx39tLg07Gltkkt47mZTEUgLhwG/rLP3LkQS9zmLQeu4/PPsTWlOeutv20qqPYOTjP+Ncf0bYHtVhXQnvJM4YyAPymOmqsUJW2i2jwbt3Nl+iCztDrsgnJds1/6Yi2lmJ5CFScBd4TB8SLb9bgs+bQv9F1lGfsdfiYbQflzFe76uTCTcRaqcddpB/e6TTK+Be3g2UbH0OKrDwmbUm9gt3oXbZK+eHABkiDa0ix3TmZP9L0w9yu1NcpwwFTlwN8XPbGKDN++UrsYA9yeF3UJg
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MWHPR1201MB0192.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(86362001)(6512007)(5660300002)(6636002)(8676002)(6666004)(66556008)(66574015)(66946007)(66476007)(6486002)(83380400001)(508600001)(316002)(8936002)(36756003)(6506007)(26005)(31696002)(31686004)(2906002)(2616005)(38100700002)(186003)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?eDB4WTZxemxJN3E0bWM3RG5penZIQnNRZnIwU2R6LzBML0JnYlRiOUZlL0J2?=
 =?utf-8?B?K2tLbGVyWldIekY0ODM4bHBEN3NDdS9xeGFPY0Y4REhvRTBEOVhCUlhMMlRE?=
 =?utf-8?B?aDRDbTRvdHNpcmtEYjhDcmlxbFFvVkVGZHpIamNTZ3NhbytYakVPK0VNbHF1?=
 =?utf-8?B?OUFtbUluLzdUcDNtalRVVE05MnMzZTllRXRRd0tHbUc5aU9SVndKSHpkM21a?=
 =?utf-8?B?cVRVUFBYd3lJaW02MEVuWS8rNHA1d2RuY2taNml5TlhNeDZ3WHRnV0lVVXZh?=
 =?utf-8?B?NW5XSWQ4YU1HbzVxY0ZZT2VMQjQ2aFZXQUExaURWYjF3RFNXSlUvUGxuNnVj?=
 =?utf-8?B?djAxTC9ZOUxhSm1IZ0N6MldXYVp0bk5ReGhNWVR6Qm9hS2p5M2lpZ1NaOVpp?=
 =?utf-8?B?MHhjZWl3VXNpQyt1RVZpb2dyT3prbUR5RnpLdm8zNlBHbTBMZzgrcDU1R0xj?=
 =?utf-8?B?MUJ5eXFobG9hOXNjZ2JJZmd5ZnBPckZBUHlEQ0VkL1VlWHJFbG1VY01DaGZx?=
 =?utf-8?B?VWdIUGkrWXVzNlVDM2tkdldkTkVGMmxQUDBXZkhxNkpnRnVWa3hOa0xvSTd0?=
 =?utf-8?B?V2dJTWdWL1RyR1ZxN3NSN3RSUmozb3AzZVB0TkdOajdjNHROYXBvaVcvK3BI?=
 =?utf-8?B?Q3BOVGRvMVpQZzBHSStva3c1YlVFWW5MM1A3Q04vWmU2QXI3Uk1IaGsrcFAr?=
 =?utf-8?B?NG5ZMmtOU3ZYbklRS291N2k2YU1HUzlXZWNUWUZaVmozcVcwUllVcExDa2xk?=
 =?utf-8?B?K29BL3dVRHF6NUR3WEtIRjFZbzZsemVuVW41YjVpN0FCSklGa2pUWE5ORGRP?=
 =?utf-8?B?dlNWVkdXWkt6M0RsN2FoY092SEcwcGFGc2I1MWlLOTF2TEhPRkdKalBveXNC?=
 =?utf-8?B?bGVkYkk1YmpsNndjOXF3azRBcGFNbS9KUE9CYzdaR1hwZHRIMjR0ZDhyV2lq?=
 =?utf-8?B?RUoyeUp3aHRHVEtQSm9QeWFrRnY2SGF0bUltYkJYZzBmalNZbkpYQlF1ZVBj?=
 =?utf-8?B?Q3loT001NERLYThDQjlaTEs1Y1J0MVNqWGViT25HemlJSVRjVHNCM1NiazBY?=
 =?utf-8?B?ejh4NGpTWktybFhZeTR0YVpaZjVEdVZvQWpPN3krNnpUakpDQnZJSG1lSEpY?=
 =?utf-8?B?UnFCVlBCNlFuU284NTlzYW9uMGRSOGFya1cyVno2bXhoMFNlNEQ1c281L1c3?=
 =?utf-8?B?bnM1MUljTjRha1k5bjh3c1lXRmg5MnFFSTYxWHNYT3JIaE9wMUowbXJyc0FU?=
 =?utf-8?B?RGlrdlRoeWZER3ZXTkJ6UzdsTzhLeGxhd3E4NUI3WXppalViOWtENTVtVTJp?=
 =?utf-8?B?NEkra3RIL08wRXpOWmdZL2xqeTdGMDlNb2tPK2xEOWROdGFOVDV3dGVkcVQz?=
 =?utf-8?B?QlRBOE50M3BjOGt0NEU5Mkc3amx2dGpjTkt6VFphdnNrQ0JxSjRWZ1VRV3My?=
 =?utf-8?B?TlJvaDNZcW1KK2tMM0tyNzFQbytQNU52Q2d2dkV4c01JK0xLbm1Qa0NxWkRx?=
 =?utf-8?B?OXdCa095T2dVS25MUTQ3NEN5UFBTYzBwYzdPdjNlS0pWbzZIaDMxbWVuUDYy?=
 =?utf-8?B?SlU4eXM5WWVsakxVZWpTVFlJdytnZlhVZCtxcWViMVo4ODNoOUhYNzZody9q?=
 =?utf-8?B?UUdESmYrNm8reUJGMnRUU1UwZ25SRlJrM2R2YkdRaWFuMVFpZFAvN3lEYjdT?=
 =?utf-8?B?ZDgzY21WTEZwMStzeTB0K1ZJSENDM29JMEgvRnBCVUtWNTJ6eXN2L1lETVFn?=
 =?utf-8?B?b1BJc3gzZkRuQVJLSi9oTHVIbHY3cEw2YWJmN3FaM1hnZENMUDFQU0tSaXYx?=
 =?utf-8?B?WUs2SWJDZVNkY2JzTVZVQXRKQ2tKazN4ZndkbW5UU2hZWlBSYmFFbnFsT2hH?=
 =?utf-8?B?d0grNFh2dEhPYkc3Z2V3eGN2ODFIK3YraE84ZVUra2lBaFF2blpaRUQ0SUxq?=
 =?utf-8?B?eUZ2Z2lsS291UTFhbFMxZVR2MlYwSktXSFQ1R1g3VFNnSWpNbnhUMmhVZlkx?=
 =?utf-8?B?ZmlDNU84UmFETHk2UnVSUmx4WjlaTi9IdVdTNzNZNHBrbzk0K2xXMWVIdXpX?=
 =?utf-8?B?VEVaRmRlNGlDSmptTTEwVzZIbHB0d2hxZS96SzR0THdPS2tZTmN5bEhNamZa?=
 =?utf-8?Q?iIoE=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ab4bfd72-8c31-4c25-e08c-08d9d0f55392
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1201MB0192.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jan 2022 09:17:14.0303 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2j/4FgecXuO0SSnHaT/sA7uFrFEKgGcT7fUEocX3hETnNEvTTvYqHubtJETQlYTH
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR1201MB0239
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

Am 05.01.22 um 21:39 schrieb Harry Wentland:
> For some reason this file isn't using the appropriate register
> headers for DCN headers, which means that on DCN2 we're getting
> the VIEWPORT_DIMENSION offset wrong.
>
> This means that we're not correctly carving out the framebuffer
> memory correctly for a framebuffer allocated by EFI and
> therefore see corruption when loading amdgpu before the display
> driver takes over control of the framebuffer scanout.
>
> Fix this by checking the DCE_HWIP and picking the correct offset
> accordingly.
>
> Long-term we should expose this info from DC as GMC shouldn't
> need to know about DCN registers.
>
> Signed-off-by: Harry Wentland <harry.wentland@amd.com>

Please add a TODO comment that in the long run that code should be moved 
into DC.

With that done the patch is Acked-by: Christian König 
<christian.koenig@amd.com>.

Thanks,
Christian.

> ---
>   drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c | 12 +++++++++++-
>   1 file changed, 11 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
> index 57f2729a7bd0..8367ecf61af1 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
> @@ -72,6 +72,9 @@
>   #define mmDCHUBBUB_SDPIF_MMIO_CNTRL_0                                                                  0x049d
>   #define mmDCHUBBUB_SDPIF_MMIO_CNTRL_0_BASE_IDX                                                         2
>   
> +#define DCN2_mmHUBP0_DCSURF_PRI_VIEWPORT_DIMENSION                                                          0x05ea
> +#define DCN2_mmHUBP0_DCSURF_PRI_VIEWPORT_DIMENSION_BASE_IDX                                                 2
> +
>   
>   static const char *gfxhub_client_ids[] = {
>   	"CB",
> @@ -1142,7 +1145,6 @@ static unsigned gmc_v9_0_get_vbios_fb_size(struct amdgpu_device *adev)
>   		switch (adev->ip_versions[DCE_HWIP][0]) {
>   		case IP_VERSION(1, 0, 0):
>   		case IP_VERSION(1, 0, 1):
> -		case IP_VERSION(2, 1, 0):
>   			viewport = RREG32_SOC15(DCE, 0, mmHUBP0_DCSURF_PRI_VIEWPORT_DIMENSION);
>   			size = (REG_GET_FIELD(viewport,
>   					      HUBP0_DCSURF_PRI_VIEWPORT_DIMENSION, PRI_VIEWPORT_HEIGHT) *
> @@ -1150,6 +1152,14 @@ static unsigned gmc_v9_0_get_vbios_fb_size(struct amdgpu_device *adev)
>   					      HUBP0_DCSURF_PRI_VIEWPORT_DIMENSION, PRI_VIEWPORT_WIDTH) *
>   				4);
>   			break;
> +		case IP_VERSION(2, 1, 0):
> +			viewport = RREG32_SOC15(DCE, 0, DCN2_mmHUBP0_DCSURF_PRI_VIEWPORT_DIMENSION);
> +			size = (REG_GET_FIELD(viewport,
> +					      HUBP0_DCSURF_PRI_VIEWPORT_DIMENSION, PRI_VIEWPORT_HEIGHT) *
> +				REG_GET_FIELD(viewport,
> +					      HUBP0_DCSURF_PRI_VIEWPORT_DIMENSION, PRI_VIEWPORT_WIDTH) *
> +				4);
> +			break;
>   		default:
>   			viewport = RREG32_SOC15(DCE, 0, mmSCL0_VIEWPORT_SIZE);
>   			size = (REG_GET_FIELD(viewport, SCL0_VIEWPORT_SIZE, VIEWPORT_HEIGHT) *

