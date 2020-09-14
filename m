Return-Path: <SRS0=HfWL=CX=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5392BC433E2
	for <amd-gfx@archiver.kernel.org>; Mon, 14 Sep 2020 14:32:16 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D9047206C9
	for <amd-gfx@archiver.kernel.org>; Mon, 14 Sep 2020 14:32:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="m+aD9unc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D9047206C9
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3CAE26E30C;
	Mon, 14 Sep 2020 14:32:15 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2074.outbound.protection.outlook.com [40.107.92.74])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D6EB76E30C
 for <amd-gfx@lists.freedesktop.org>; Mon, 14 Sep 2020 14:32:14 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Q8mXGaqWPPbwrvVGiTOljvvXqh/RigS/5XSYzzgFia0fMXuBsBDz2JOYpjzvKeAJCU7nQYKnhQp7VT19A9+ZZouv5jrYPsz5g4w2zhu+6L8Nu2GIZs/KrLaMMwBTXq6E/Vi92JP9ruqeGvMNskwY/xozQQRK6UT2KdyBqAuF+eEVxTEW3ymLWhYzTxIXhJY5y0vsQL2Zchpr7y8eEUrH3md/QBDgc4X+YvRrYnrR1NY8qdBs/NVikfqOthBtagj2kCfnpum7I4cnO8YnXFwFfwr2qWfsMY5PtzA0SMgHfWez26U3ULRMqVoVppEO0yYnsr8r75XIs43NqVybnBVS4A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qrlhWE/gTAd465TYQwGXH2VlroOE1dxAvUUX1mOez7M=;
 b=ayfc3DSKBudNw8wGOBsjc7s3Zw2bXpmLpjJMQcZ9RfKm2UGodd+fCssUA5l9F3IMDm/9mOy5okQ0QMm/+B4Dhh+AxhskQf4otOeICGGJeRBEDvXTzyrkpF2tZRESY4V4FIC+vWU7+C6Zqwrh6Hs6WqZWasxgiNcDiFXmQt8HMMaxr96LUwx6d+fT0JfPLHLlo1cGENDOpg17R1NOakU8tD89UQTt97ufYfXEglnWLcCCXomQcuza/I4m/1N1t0Z9vYELXutrYkKPCwnNkNSeiuU4szPf3CKzOx6aITF7itbJsmy4LbYyZD+LQls7+DnfTSW7gS7MsTk24wcFAR98Kg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qrlhWE/gTAd465TYQwGXH2VlroOE1dxAvUUX1mOez7M=;
 b=m+aD9uncIliPJbLDEjeXJEA4IEWCMonYGGxerECa2d1fYVOXQdNXkdZGh6XMLPUVIFnKpO2BKI6DsIx9EFIJkqeVzjKS/dt0C0zJAmtCCzYX9ujo9ynXSWN2GXfzPWhmS2YGkaeSbTROF5nRyockdvdD5Vq+2YkaC56TW+DLZ6Y=
Authentication-Results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB4340.namprd12.prod.outlook.com (2603:10b6:5:2a8::7) by
 DM6PR12MB4338.namprd12.prod.outlook.com (2603:10b6:5:2a2::21) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3370.16; Mon, 14 Sep 2020 14:32:13 +0000
Received: from DM6PR12MB4340.namprd12.prod.outlook.com
 ([fe80::60b8:886b:2c51:2983]) by DM6PR12MB4340.namprd12.prod.outlook.com
 ([fe80::60b8:886b:2c51:2983%3]) with mapi id 15.20.3370.019; Mon, 14 Sep 2020
 14:32:13 +0000
Subject: Re: [PATCH] drm/amdgpu: Include sienna_cichlid in USBC PD FW support.
To: amd-gfx@lists.freedesktop.org
References: <1599761153-13679-1-git-send-email-andrey.grodzovsky@amd.com>
From: Andrey Grodzovsky <Andrey.Grodzovsky@amd.com>
Message-ID: <a968c176-ebd4-65d5-b27e-af4881342f6a@amd.com>
Date: Mon, 14 Sep 2020 10:32:11 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
In-Reply-To: <1599761153-13679-1-git-send-email-andrey.grodzovsky@amd.com>
Content-Language: en-US
X-ClientProxiedBy: YTOPR0101CA0010.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b00:15::23) To DM6PR12MB4340.namprd12.prod.outlook.com
 (2603:10b6:5:2a8::7)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [IPv6:2607:fea8:3edf:49b0:a449:6c1c:ec54:53b9]
 (2607:fea8:3edf:49b0:a449:6c1c:ec54:53b9) by
 YTOPR0101CA0010.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b00:15::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3370.16 via Frontend
 Transport; Mon, 14 Sep 2020 14:32:12 +0000
X-Originating-IP: [2607:fea8:3edf:49b0:a449:6c1c:ec54:53b9]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 8b10339a-d833-4798-cfaa-08d858baf89b
X-MS-TrafficTypeDiagnostic: DM6PR12MB4338:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR12MB4338B5DFC266CD6E512D2B78EA230@DM6PR12MB4338.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1303;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: /kqHkaqWAhSfxsQBo76bR9cCNuo3/LbQJoGf4x/H+AYpJEfpiDQou7bI1Lo53SD3OWdD5B0mWMU32d7iDZTfhK6dzt83Y6He/KeN/zLL4ewPfXlli2lMMeEEb2nAI4G5DyVOwNZcfMdiPe71BfKJkmnxTFX8zo15Yqtuvvai0jw34gQ//3O5cymoe4WYWsiCR+FoZSXzC2PGPoUDlAwdvk1/QyYGulOG8JGhiDqYKTII/O81kNb9emOSPQgBX3gGksU6hOdxArJEsdc3sE0TtnAqJCmmP5eE4z5F5ajNuL/jfQlhnGsoXYyaA8myio75VRBImlCUKOiEEl1JFnipkQoVIzxcYzxrN9y7I0Qc0IJI//iQunju0bmG3GnIHf8f
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB4340.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(39860400002)(396003)(376002)(346002)(136003)(366004)(316002)(8936002)(8676002)(52116002)(53546011)(186003)(478600001)(16526019)(4326008)(2616005)(31686004)(31696002)(66556008)(66476007)(66946007)(86362001)(2906002)(36756003)(6916009)(83380400001)(5660300002)(6486002)(4744005)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: XLeAoklSxUx6BuxoHg8evkLTx5LoUeIJDHPAh97AAr3a9SU142qQXwE/L8lkPkUSGWO0FMWbm3bG/SOminx/QfXZY/SgC/rmTZnJWTj7fTT+rPzMKdBkA5g2w+Bq6cW1+ZkTxdzIx0rJr2/YkITeEXglzFjN0eSfetNjk5yj0bZ0Lv3r/HcVuKiovfSDhMLJp5fXfRSuK5jZeSrA43ivVfWEtM9rD2d0CqYG9f3xGQ0jPqm9bTuHe4MILAKvyhKGVbT/Fch8dST7Sxec8yXfKsUI236iZFz9UnvFf56aCp48MfXQyo1MThJPylY6SM3TVONXis6ZY/rZ0zgxc0LmYZNp2sv+LA0uDi5UqyEXWOixPojbnsQhj7NMqsm4YKYnpwQ7NtDR0uGsSsuaSviGhRdMDFtdG+1MU7SnNpDg0p00UrEKAzDwo7oC+40R10zIc9NzSMDT3vTMVsIhtSNp1/5+HJUeAxx1ERqcNx1699dxgmPFA5tYGPU7sT/NElD6C2FnK75q4Wa1A5bspJVz8U6QkoAsS1H3OFKFUbkOE2QNRQbjs61cS2CyHDK3tYJNeV/4e9juHbAPEfXFkOb9GhWFp3si45FUf2YNMQ1h9r1AFDAx4bj9lX7z1R6lu8fAh2gCkE31hO6cSlmPLa2k0ShRM9FRiFKu00oWav1zj/WTkFjg/pu7LylhUouZaLQESTA5mrZVCQ87MSYFfjxLIA==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8b10339a-d833-4798-cfaa-08d858baf89b
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4340.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Sep 2020 14:32:13.2799 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: l4Dy41mFaq2cTz6A753zj1BYOWYVWaZih6epCYdxaWnVLb2f/P0+ripYD8ZaeIVhYsiF55l51zY7LhLULlm7QQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4338
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
Cc: alexander.deucher@amd.com
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Ping

Andrey

On 9/10/20 2:05 PM, Andrey Grodzovsky wrote:
> Create sysfs interface also for sienna_cichlid.
>
> Signed-off-by: Andrey Grodzovsky <andrey.grodzovsky@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
> index a7771aa..600015e 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
> @@ -178,7 +178,7 @@ static int psp_sw_init(void *handle)
>   		return ret;
>   	}
>   
> -	if (adev->asic_type == CHIP_NAVI10) {
> +	if (adev->asic_type == CHIP_NAVI10 || adev->asic_type == CHIP_SIENNA_CICHLID) {
>   		ret= psp_sysfs_init(adev);
>   		if (ret) {
>   			return ret;
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
