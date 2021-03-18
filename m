Return-Path: <SRS0=NRDG=IQ=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 502B0C433E0
	for <amd-gfx@archiver.kernel.org>; Thu, 18 Mar 2021 07:34:03 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EF5B464E2E
	for <amd-gfx@archiver.kernel.org>; Thu, 18 Mar 2021 07:34:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EF5B464E2E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A20236E890;
	Thu, 18 Mar 2021 07:34:02 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2054.outbound.protection.outlook.com [40.107.93.54])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9C13C6E890
 for <amd-gfx@lists.freedesktop.org>; Thu, 18 Mar 2021 07:34:01 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=albqb4UFplI9B2IP/kwJWtaCJWI0ByeiiRGajN6XODYi2V2+qPwZguFJyKlpzluJHta9sXLbQP+ih42tm6fyWc3iGQvm1ldDTa7tw3m0s0T5oHzKH1+G4ng6nQ9DrLJ70tJT6cz+lNKo0yRdN9OM876KtLIXXUKTX4OxWf9uUPyBgir8qVtzIykifwwRQzu7pzHVvqcutGTyjvj2RbaCMFdUkwB0/2IdvhByCQk7KreSVCmizlvqinpN1VDV4nb9bHhP1cK9MhmG5vNxcjLG7Rq6cv2w40+wIrLt4NgrQq3AyrbacakF51e2bZl6ADTD47eet25wijn/rdmGCXRhsg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IOI0fpHvVzd3ZGMulXm/WxapJpAjlsbcVjsY8rMji4c=;
 b=T5gpibMXUMS0EW6W9uGdDE9GoXaeTOeDj07vnO8OoiD2oF2/tgTjQ4YUdTeGc5+EshykyiqpcK3Yo14rnuLQM2MHbQNVgR3X6c5q/aHNS0uAeQ1D5N5EhZJb2MTXda0iL5FGqj4ms6ylb4K2ffNByqnvrqntb3DsVAeQEKVU32xIvTbcA4MMo64hs4X2knP3zMYS7161oOdPt9n/ZDUPloz0auHW+dvX1iOWqwiOJ6vQy7PwzlC04nRoNzGpQEOp4W9S5GzNIjuiCw1FaPnKC975raVEuIenBinBd018ZLKAO4LW0oWWBpJfIpvzYY3AJGpyW99+kQrXkTez45OjWQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IOI0fpHvVzd3ZGMulXm/WxapJpAjlsbcVjsY8rMji4c=;
 b=aLGjFFl0vX+lDhR3d6kUUeJYNoH7PTxqdIBMnZu66lOBmK218hXJhf5m848mUznChM4c88ZfvvL0xVQjrmL9u6Zs3r+UtMUyJ1szC8GcvItKWmzy+T2F65TDiC5auptsE/S/9kiHQ3REjD+qSkNCADEECmkIqNDS/ZttYiOcgNc=
Authentication-Results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
Received: from MWHPR12MB1248.namprd12.prod.outlook.com (2603:10b6:300:12::21)
 by MW3PR12MB4571.namprd12.prod.outlook.com (2603:10b6:303:5c::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3933.32; Thu, 18 Mar
 2021 07:33:58 +0000
Received: from MWHPR12MB1248.namprd12.prod.outlook.com
 ([fe80::5094:3a69:806f:8a28]) by MWHPR12MB1248.namprd12.prod.outlook.com
 ([fe80::5094:3a69:806f:8a28%5]) with mapi id 15.20.3955.018; Thu, 18 Mar 2021
 07:33:58 +0000
Date: Thu, 18 Mar 2021 15:33:33 +0800
From: Huang Rui <ray.huang@amd.com>
To: "Du, Xiaojian" <Xiaojian.Du@amd.com>
Subject: Re: [PATCH] drm/amdgpu: enable mode-2 gpu reset for vangogh
Message-ID: <20210318073333.GC2497230@hr-amd>
References: <20210318072120.10535-1-Xiaojian.Du@amd.com>
Content-Disposition: inline
In-Reply-To: <20210318072120.10535-1-Xiaojian.Du@amd.com>
X-Originating-IP: [58.247.170.245]
X-ClientProxiedBy: HKAPR03CA0004.apcprd03.prod.outlook.com
 (2603:1096:203:c8::9) To MWHPR12MB1248.namprd12.prod.outlook.com
 (2603:10b6:300:12::21)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from hr-amd (58.247.170.245) by
 HKAPR03CA0004.apcprd03.prod.outlook.com (2603:1096:203:c8::9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3977.9 via Frontend Transport; Thu, 18 Mar 2021 07:33:56 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 9c3f61b0-7a82-461f-dcb1-08d8e9e030e1
X-MS-TrafficTypeDiagnostic: MW3PR12MB4571:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MW3PR12MB457104582652F0F8B0916EAAEC699@MW3PR12MB4571.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1091;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 4tLpB+VK2+6cJ1ey8TUxlcDYtRL7zh8RgZgAGRke6EXGHs6lI9EhTzbH/AUTesX3ut40a6ekjdFCljXpTKeTaBIUVaOjdydgM7S6LDBZSxUgEgjYs0tdRgkvTSBtA7HJ9ruVrDgBPZ9dNJCMSihgc/caBc5kLaDgGtP4oXs2tdUt7OfydJ3fxOZWYcP8GNkWS0BgBwrYuTP8X3k8QkqlqIyyTX0Gg3t38ZsHgEr/AOyXdx11c22PSZ5IsevUqG0kZqwB3UBWe2A+kW2QgwR0SepFUqv3EFLxzFvJo8Ma0Ss+lTfzheFmq3q8FP15OuxHeSjBTw32fu5LtIygD9C7uRysBsXr7hGV7VJY7RfPQZ9ywYBJJU0P67qcLmAAS8fd0BCAUyS48emY/sLBEwrMnXueVOTaX5waaW0yQ2BWhxco5BEQYWto5f0tejQSrEndupRHZinhwJX5/ySgYCfbN+xRwNkgbONeT0m+DjKSGuhNUCX5PYlw5o4mIER/xrq/aJqFuF2S0rLbjWea51biz2T6RKRskPM765jxIQULRoZrX5OBkCHJf78zQfN9OfZ0q1PfVglpsowLb2t03ESFmLGFeAJp7TNR1BsuhLh+8F40aHb+i8AZoTdocXZyK1HQ
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MWHPR12MB1248.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(136003)(366004)(346002)(396003)(39860400002)(376002)(86362001)(6666004)(9686003)(6636002)(5660300002)(6496006)(6862004)(52116002)(38100700001)(316002)(1076003)(55016002)(33716001)(66946007)(33656002)(2906002)(4326008)(83380400001)(66556008)(956004)(8936002)(26005)(186003)(54906003)(8676002)(16526019)(66476007)(478600001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?Ry1O2Nr6/LpZt2ny7hP2I6gtt7ahvDR6S5hF3qOwiFFwlwQyNFX/mAS+028J?=
 =?us-ascii?Q?7qNQRmDnBU3FabEmmwpjuYch7EeXTgj4XUGMLtRtIAe2+v/w4gLmEvKeRlTc?=
 =?us-ascii?Q?ZKIH96+JRXj+Eb/iv25FpjaPG4NPqy1V8inW4WZHN/hsGTuq1lQeJGoiKz/I?=
 =?us-ascii?Q?tyB9oCmX+Yl0uqGX2gdl7quiMWpGJCKAQrBgZrsmS18pcC6+/Jr+58ejM/KO?=
 =?us-ascii?Q?98vg+Bl+N6a28TX6ANwph/J3FyUhamyy69Ei44PdTL6yPA1lMAEwGJHuQ9eb?=
 =?us-ascii?Q?pvpK2Q/oz3mssMWVP/h05GL/eSdNmj3YW3y9tpD+EXzEB77kYqW7UpSrRq99?=
 =?us-ascii?Q?P6VFG08OjBVRByfDiuntZGF1nur8Ssx1evVcpFebuXyd9bwNHW9/6oi7ZSFz?=
 =?us-ascii?Q?VvFkXPOGJoELxHEeGt3HulvL2Q5+tdGxWj7tCYOK9zG06hXXG8WYtcAyM47E?=
 =?us-ascii?Q?R+sIgSsZrNRX9FHxpq3JvPkTp1cmlhJZp7T1yh1wZ+xZ+Fu8SQAAxEgS5/oO?=
 =?us-ascii?Q?VYrjt5zKN6EQo0nMLDsgzbJMM0dtKjSBJfnT6FsqLRiUs+e098wjKErDj5ic?=
 =?us-ascii?Q?x+2dN+6+uu4KcTniaJ4aDuQwqvmIzv6yb100Jq4Ln2pIupkcJo/bixn4s/Lu?=
 =?us-ascii?Q?JMmYJlPAa8pZ/CAe02XxQqoXNlXFrwkPJXkHAcW2up1SfPeL7UP7uPvhr8Ht?=
 =?us-ascii?Q?s902lMtoMt7nU3jhZEcxv4UnGLw0qcPgdnS6tmVs/zGKBWpd1DOuh/2WY3ru?=
 =?us-ascii?Q?drGd0QrKrwEfU1lseuUEW7Q11g99b0MkjCjiqg8Ck+6q8DwqcbKhJiPjRcAT?=
 =?us-ascii?Q?1LIblwNyP02l3ik+gw6R0xMWCBRhkY4aW6GBYL3ETjRvr0cBSzdHvHcBB94Q?=
 =?us-ascii?Q?vlEfHMEO4tMSbVUwGYG3E6rU1HeX7bZgo2qLK9ZAjaLvAQ5OKVS+BL482V2s?=
 =?us-ascii?Q?OW0hP2ldresGiJaLMTw4wCX7UgbH/bOkN0ZKEEJ+rxLauXg2iyZ+Yt2xZYN7?=
 =?us-ascii?Q?OJ6OnFsrQttN9vQQS0cVHW2soiVsoEMkLhKDa13TxaVQ7xOzuV87XyJORvE7?=
 =?us-ascii?Q?sCmRB9/e7YUy8N/PE292ieapb+wCnKIplIHrbafoJ6oYYR6M8+RM7tyuL6Fw?=
 =?us-ascii?Q?KC2S2ZYcC1cBkHVSpL7cuzZsm0SGAGuye8rIiJiwBDWy5wh46tZv9eGraEZ9?=
 =?us-ascii?Q?ZduDsnoVoFO25IleJJWZILMG4EyiAT9zLri2awwJtKON3snky4cxiUYE+LrY?=
 =?us-ascii?Q?WIZey5IMLnoqxzcA9UCjivjcP05Hwr3uhOWAJCo8D6UXAiL6AughSqrmF8R1?=
 =?us-ascii?Q?aJo1Ds8U2To8pPAYxhf8ysPH?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9c3f61b0-7a82-461f-dcb1-08d8e9e030e1
X-MS-Exchange-CrossTenant-AuthSource: MWHPR12MB1248.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Mar 2021 07:33:58.3565 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +tmi/1QliJCvRmJf/2ywhtoRE1FrsK/k/X2bMQmLeFR71nrXerk5DcwI8j6NeMI+JWkDhZHKsZH/Zt9AK1/o/w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR12MB4571
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Thu, Mar 18, 2021 at 03:21:20PM +0800, Du, Xiaojian wrote:
> From: Xiaojian Du <xiaojian.du@amd.com>
> 
> From: Xiaojian Du <Xiaojian.Du@amd.com>
> 
> This patch is to enable mdoe-2 gpu reset for vangogh.
> 
> Signed-off-by: Xiaojian Du <Xiaojian.Du@amd.com>

Please add the fix PSP firmware version in the commit to let us know the
good version for reset.

Others look good for me, good job!

Reviewed-by: Huang Rui <ray.huang@amd.com>

> ---
>  drivers/gpu/drm/amd/amdgpu/nv.c | 4 ----
>  1 file changed, 4 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/nv.c b/drivers/gpu/drm/amd/amdgpu/nv.c
> index 5846eac292c3..a31ef68ee2ab 100644
> --- a/drivers/gpu/drm/amd/amdgpu/nv.c
> +++ b/drivers/gpu/drm/amd/amdgpu/nv.c
> @@ -561,10 +561,6 @@ static int nv_asic_reset(struct amdgpu_device *adev)
>  	int ret = 0;
>  	struct smu_context *smu = &adev->smu;
>  
> -	/* skip reset on vangogh for now */
> -	if (adev->asic_type == CHIP_VANGOGH)
> -		return 0;
> -
>  	switch (nv_asic_reset_method(adev)) {
>  	case AMD_RESET_METHOD_PCI:
>  		dev_info(adev->dev, "PCI reset\n");
> -- 
> 2.17.1
> 
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
