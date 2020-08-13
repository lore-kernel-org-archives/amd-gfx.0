Return-Path: <SRS0=ZeSq=BX=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72C7AC433E1
	for <amd-gfx@archiver.kernel.org>; Thu, 13 Aug 2020 06:21:16 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0865620716
	for <amd-gfx@archiver.kernel.org>; Thu, 13 Aug 2020 06:21:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="YS5nBqEn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0865620716
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A26AD6E1D7;
	Thu, 13 Aug 2020 06:21:15 +0000 (UTC)
Received: from NAM04-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam08on2081.outbound.protection.outlook.com [40.107.102.81])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 725316E1D7
 for <amd-gfx@lists.freedesktop.org>; Thu, 13 Aug 2020 06:21:14 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BFlVyB22diMBaxRRqJZp+1nkKe1C17Lq7yvqv3mLNtM+XzfYdEFSl/VJtiKAh7qNKsvR1Tx1SFt7LQdlOfh81yuS0+kbXUPs7EAovBmgvneTv+Mzg+/BQXQ/msPkR8e4i/KWUeO8BpZW88xeTIEF6St3PkGXuVku5XYFgt721k9wSgYZeuIwvN01Nw8cVOj1109kThlB8AZSQ03nlY7TihXhzyJ17PSFzT9YYL9LVj/JsHCUENaDIcldInbyEwFvUhsA/nxN1bx/9X/2Pr8uwxaRpAGirMLnCka47u9FnMv8LO2nUSVf+qVHHYBrI7N5egGCqxmcNoGEwBNjsayx7g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uoh7CnHcqI2GQ9HmpLk1VNTmE6l7K50A8+tBsq168nc=;
 b=eE5eMaQQBLGA8/qcd+3DZkItI9WFJOH//dBohvI2e44uzkU0ifPjP9Kv/KJPIuFVs+JnLQIbErRg5Y0Obi7i30LyI4Zk6gmjb6KJZcStwb/bgDZwpo5tIsJ5Sh0iXpG+rBMNibuOAW/p5DOceSFhjH7tH1NpJ/hFsp0lgxVyuciPc05jjdxOCdStd4kjnMFlua1CgAsZyK8vap41NinFfOIzcsOHaS5WrvC5Xl3954PRw/yGRWlEnlinh6gF2o5HRXSFgtO6BeSXQzsFR7DI10+1WVLJbSoUsOhPkYhHFtWhfr4fSZ1QSXRlSIS8Y7KACqquEB+/nlW992bfNjk6lQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uoh7CnHcqI2GQ9HmpLk1VNTmE6l7K50A8+tBsq168nc=;
 b=YS5nBqEn+x/go8aC/O3amZsyOmU69ISyU4P0qcvq0jdA2Wj4disKiPa2E8AXbGTA1aBXKTQ2J+BLz/iFBJk/z922SJ1UK/ea3/49WCM7jLbm0B6cIbFCtJjpL59X7DMdssS8LaybJIlaby6R2qecFeDWxO2paym7jtA03V3bHNs=
Authentication-Results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
Received: from MN2PR12MB3022.namprd12.prod.outlook.com (2603:10b6:208:ce::32)
 by MN2PR12MB3294.namprd12.prod.outlook.com (2603:10b6:208:af::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3261.18; Thu, 13 Aug
 2020 06:21:12 +0000
Received: from MN2PR12MB3022.namprd12.prod.outlook.com
 ([fe80::44b3:9382:383e:ab93]) by MN2PR12MB3022.namprd12.prod.outlook.com
 ([fe80::44b3:9382:383e:ab93%4]) with mapi id 15.20.3261.025; Thu, 13 Aug 2020
 06:21:12 +0000
Subject: Re: [PATCH] drm/amdgpu: drop log message in amdgpu_dpm_baco_reset()
To: Alex Deucher <alexdeucher@gmail.com>, amd-gfx@lists.freedesktop.org
References: <20200813042519.4793-1-alexander.deucher@amd.com>
From: Kevin Wang <kevwa@amd.com>
Message-ID: <ddf8f71a-40d1-e932-e42f-debd76c89e96@amd.com>
Date: Thu, 13 Aug 2020 14:22:27 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
In-Reply-To: <20200813042519.4793-1-alexander.deucher@amd.com>
Content-Language: en-US
X-ClientProxiedBy: HK0PR01CA0059.apcprd01.prod.exchangelabs.com
 (2603:1096:203:a6::23) To MN2PR12MB3022.namprd12.prod.outlook.com
 (2603:10b6:208:ce::32)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [10.65.98.46] (58.247.170.242) by
 HK0PR01CA0059.apcprd01.prod.exchangelabs.com (2603:1096:203:a6::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3283.15 via Frontend
 Transport; Thu, 13 Aug 2020 06:21:10 +0000
X-Originating-IP: [58.247.170.242]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: b3b1d3db-bd3a-4f1b-c16c-08d83f511378
X-MS-TrafficTypeDiagnostic: MN2PR12MB3294:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MN2PR12MB32940203DD0D05A3625B37B7A2430@MN2PR12MB3294.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1247;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: BNyLwgIoBA7uQTmM5VxOHftm1dTWnq+Tfaz8/ww9pble627JZwbAUTa8Q6Cmn36NP3MVVhTnGs66tbl2jxrIoRmvOmD69O6dnUuPkhY47Sn+DJYnVLDFXudo8oNlsAAlyPwil0NBUgB+LTM9T6ENeNlMXboZD8eBLg1KAhygCPOuKMc5H+JucFP2VKvGlKLmQZQk+qfUIx1iv2Y8YF7+DcDlB4Wlsphd0gy3jcXfMXWGyCCkOt6w2vwErHOSTmXGbKuVEEldk2HVtZaI5mY+0jWmJRXH8sjt8aw1l4HP2UrfclqcJLi/YL15/WCXjIlb/Zi7niPWDZ6md2yPzEPgL+ZfpnMcNiEZYNIH31cSDn3XFulTLuLNNwlYu+v9X5YW
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB3022.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(376002)(396003)(136003)(346002)(366004)(39860400002)(6486002)(66476007)(66556008)(956004)(66946007)(186003)(31696002)(16526019)(16576012)(36756003)(2616005)(83380400001)(316002)(4744005)(2906002)(6666004)(478600001)(26005)(4326008)(53546011)(52116002)(8936002)(31686004)(5660300002)(8676002)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: omMwGfv2g9iMzb7DtbeZilk/Gp6PXfGN2P/ilktApGY+zb3EMS6qYBqFxhwUMx8BuUlZd5ryRvhVPNFvdnKiRjKXJ7ADUezc1GDRczO+CknxDS5hoEVwOXzSL5Nqh2Fq5fAK1SqHZbxvtiDH1lE9YHr7vB2P/Q6dow+6/X0awZ5M0Jxn80lwJpAh08NXvwsEpXkvxvGd4H3SIagDDQGHWOxVjKSlQEvIdoTFCwPSRIyDy81MEP8y94ec+PJQd1gReOAwL4kTmdGhrdUmzz/hF1P8E5sSCAq9vh+qsUydxkQLUbfzxbnYf8NZ90SaDrx2dIQtFaCwLNF/mCA4bR38SkWtXfQZaQMBUfpgaiawK2pqV0K2aP0Iay7lAaOsM+017Altv8FsVm0OZ94lE/QUUmkpCFxIpbhqv+h28yuK9w/9bn212zG/R3BzG8tWPXBHjwBS7qxGi31fimGW4xv42qGpLzbADgqwj73/mU7gykssiNyDNAZ+MyDvZk+8Ghkbk8MTZSiUAVHKLOX4/MDwyhwyMI1e0DfdoF8CrkuO+MHVbp9kI5feKr1kE7htLpDsSS5ZROyRI2pG4J5Wa7WR5Bk0WfFBLdaqgBTOaIhh9Iro869kGVyo5vuQ/WqKqTvY46XJYA7+ntbdjWbTo91Wlw==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b3b1d3db-bd3a-4f1b-c16c-08d83f511378
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB3022.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Aug 2020 06:21:12.6336 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6sOX97wAK8ZOY7TKI7quSPaEsqWcvyLKkEd6l8ZaF/z8tO51m1myFdSJ6Z0oWXpN
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3294
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
Cc: Alex Deucher <alexander.deucher@amd.com>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Reviewed-by: Kevin Wang <kevin1.wang@amd.com>

Best Regards,
Kevin

On 8/13/20 12:25 PM, Alex Deucher wrote:
> The caller does this now for all reset types.  This is now
> a duplicate call.
>
> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_dpm.c | 2 --
>   1 file changed, 2 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_dpm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_dpm.c
> index 2082c0acd216..1c661c7ab49f 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_dpm.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_dpm.c
> @@ -1110,8 +1110,6 @@ int amdgpu_dpm_baco_reset(struct amdgpu_device *adev)
>   	struct smu_context *smu = &adev->smu;
>   	int ret = 0;
>   
> -	dev_info(adev->dev, "GPU BACO reset\n");
> -
>   	if (is_support_sw_smu(adev)) {
>   		ret = smu_baco_enter(smu);
>   		if (ret)
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
