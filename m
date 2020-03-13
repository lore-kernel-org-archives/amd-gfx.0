Return-Path: <SRS0=NWgq=46=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24730C2BB1D
	for <amd-gfx@archiver.kernel.org>; Fri, 13 Mar 2020 14:04:05 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EBCE020746
	for <amd-gfx@archiver.kernel.org>; Fri, 13 Mar 2020 14:04:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="vWgxOncy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EBCE020746
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 984006EBCF;
	Fri, 13 Mar 2020 14:04:04 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2077.outbound.protection.outlook.com [40.107.92.77])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A58706EBCF
 for <amd-gfx@lists.freedesktop.org>; Fri, 13 Mar 2020 14:04:03 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=a+s4E8nsnxoQzT+mTWcqRECCU7iYJHLxWkv7Wyz0FGrzLlfd8LOLLn54pbpOGV7BPu9t4z9D6oCi6ba+tFCoRKymz80YDS51OPJqUpNJnkkAoBke6i+mCcJsFR2SioZmOyEveThV+4NdM076NthOjnAtHKspvaFgHRI6z4JcK9s32oOrJT0h0wat8V4oQde8o/zXcP5NK0jpRJE3C09GCZ2sB6bO2JnRDdk0rePWk3OvoC2vpHwBNN+3W/ADSnbF1dR3mvIqTYmukPPH31I0JbS15gCIqPq6gnPeP9ephhs72LLmBEiggSS77TGaY/2tFaJgE/94/55r+SRi6RP1+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Q3JwoKEbdSDEvJv46esyVyTlrdR6w3vvKT+XsPTNvCc=;
 b=cRbMubJAcxcpp+KWTgTTkiY6GrQ/ls+Awvc4/34alqUKHYuZo9uYy95VYKFsrRWOZaX/s0cJZu3uP93XB4m4yztvfLWoGHWcJFvwyET/Lk0Ywcq4eZXeuOYvQxh0I60jRCJFMdTyVPGz27gmEx45kwVZpeg+m48s4pJmAkUoL9LeQ2D8clGnULGKo8Sp/ZuqX8xQdN3+AnG7VIn3wtuRJgxKuGhk2hKVCWScIlje2cVLv9JRZ3o3ay3uZn29Wfp17byzgDDu00Uuw0XAG19U/STlX6yh3NshELB+yJZDVKq6g4vpOEu6zwzJNPdDHSuSPkCWv6G9Cj7YS4mllYbnDw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Q3JwoKEbdSDEvJv46esyVyTlrdR6w3vvKT+XsPTNvCc=;
 b=vWgxOncy89cFOUJJX+auoqVH1omxIq/6U8OKhIsCMWH33a54HC0NXL9NYxs7SeXFrvXr+9UT9h2fvygOHtNeYWkhsLG0J3/zfmctnoPgvWeuYOvG03H8unjZDsJLRbxVp7mIJrbNUCvvfLi/GC928WOiaxJ98SWeZ2LVY0izK+E=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Christian.Koenig@amd.com; 
Received: from DM5PR12MB1578.namprd12.prod.outlook.com (2603:10b6:4:e::7) by
 DM5PR12MB1724.namprd12.prod.outlook.com (2603:10b6:3:10f::13) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2814.13; Fri, 13 Mar 2020 14:04:02 +0000
Received: from DM5PR12MB1578.namprd12.prod.outlook.com
 ([fe80::113e:3059:1470:c73c]) by DM5PR12MB1578.namprd12.prod.outlook.com
 ([fe80::113e:3059:1470:c73c%7]) with mapi id 15.20.2793.021; Fri, 13 Mar 2020
 14:04:02 +0000
Subject: Re: [PATCH 2/2] drm/amdgpu: disable gpu_sched load balancer for vcn
 jobs
To: Nirmoy Das <nirmoy.aiemd@gmail.com>, amd-gfx@lists.freedesktop.org
References: <20200313135953.68418-1-nirmoy.das@amd.com>
 <20200313135953.68418-2-nirmoy.das@amd.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
Message-ID: <338f39d6-fd4c-0823-4da8-e81115ee9c60@amd.com>
Date: Fri, 13 Mar 2020 15:03:55 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
In-Reply-To: <20200313135953.68418-2-nirmoy.das@amd.com>
Content-Language: en-US
X-ClientProxiedBy: FR2P281CA0021.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:14::8) To DM5PR12MB1578.namprd12.prod.outlook.com
 (2603:10b6:4:e::7)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [IPv6:2a02:908:1252:fb60:be8a:bd56:1f94:86e7]
 (2a02:908:1252:fb60:be8a:bd56:1f94:86e7) by
 FR2P281CA0021.DEUP281.PROD.OUTLOOK.COM (2603:10a6:d10:14::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2814.18 via Frontend Transport; Fri, 13 Mar 2020 14:03:59 +0000
X-Originating-IP: [2a02:908:1252:fb60:be8a:bd56:1f94:86e7]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 849da9f9-e324-4fec-198e-08d7c757621a
X-MS-TrafficTypeDiagnostic: DM5PR12MB1724:|DM5PR12MB1724:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM5PR12MB17246D90BC326024225624FB83FA0@DM5PR12MB1724.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-Forefront-PRVS: 034119E4F6
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10009020)(4636009)(39860400002)(396003)(366004)(346002)(376002)(136003)(199004)(316002)(52116002)(36756003)(2616005)(478600001)(66946007)(66476007)(66556008)(6666004)(5660300002)(6486002)(4326008)(31686004)(31696002)(86362001)(81166006)(8936002)(186003)(16526019)(2906002)(81156014)(8676002);
 DIR:OUT; SFP:1101; SCL:1; SRVR:DM5PR12MB1724;
 H:DM5PR12MB1578.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: VhoRW093k/xLaO+wIEQKPffTmioKe6GU5N57JhnpqkoT3qTE+tTtZxhocGgf4nEWr3IyRokNe6J90XvNjELKrUeCUQsl+tZKX7PIFs+AjoSFdeByjP4zN5Av59jbYgbl4YvXBsKjzGltkZc2Z6QKV5ydR1OATu1UoNOS2TlpvihySoHlupeju6cabhAhmyMVwNWV15Ggsh1ABF0BrObTMumLf0q5Jpeqm+kUV8sNMr0s/E29HOXiSAspgf3uJJgNbwsDyFP0uewTGxIZsDK48DFXCRtOJRw8uEaIY5lz+3W8097d5K/igZ5wr69vbo90QBOcDLp848diAVQYw+rQsUTIEqp9du4EV8104KHc4SgpGZX69AzuIDWCf6H9qpAyqhimVA36C2QA3dkV9qzqx2QXc2AeNZfJYJCRfco8C1/zKHfS8O77WEymQkNr6YD5
X-MS-Exchange-AntiSpam-MessageData: K3rwjbhKnNyzIrXm/mXLHZKcVfs0BMJGTLBRUHPbuRESAl7Ji5cB5cWxE/pDxP5amrY6iWzMW7DUfT0/HbG9qV2JgfdezRdMF+rsaEmRWUP4qCr/CqFLTrRDSzh/3YCAR+mp/Xl7nCGnKO249s9StivcIeqJwKYDd3iw4lsi7jQdld21sq1hJO+2XiRKltObt5q6/Rzo6Ys616l3vJGwZg==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 849da9f9-e324-4fec-198e-08d7c757621a
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Mar 2020 14:04:02.1282 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GibZkmYngQVCuYdUbCARlQRf4AIOAljkLx8TL4KObrmDOixgslno4ePVaum2IuzT
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1724
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
Cc: alexander.deucher@amd.com, Boyuan.Zhang@amd.com, nirmoy.das@amd.com,
 Leo.Liu@amd.com, James.Zhu@amd.com
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Am 13.03.20 um 14:59 schrieb Nirmoy Das:
> VCN HW doesn't support dynamic load balance on multiple instances
> for a context. This patch initializes VNC entities with only one
> drm_gpu_scheduler picked by drm_sched_pick_best(). Picking a
> drm_gpu_scheduler using drm_sched_pick_best() ensures that we
> do load balance among multiple contexts but not among multiple
> jobs in a context.
>
> Signed-off-by: Nirmoy Das <nirmoy.das@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c | 7 ++++++-
>   1 file changed, 6 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c
> index fa575bdc03c8..8f1e3c05812e 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c
> @@ -121,12 +121,17 @@ static int amdgpu_ctx_init_entity(struct amdgpu_ctx *ctx, const u32 hw_ip, const
>   			num_scheds = 1;
>   			break;
>   		case AMDGPU_HW_IP_VCN_DEC:
> -			scheds = adev->vcn.vcn_dec_sched;
>   			num_scheds =  adev->vcn.num_vcn_dec_sched;
> +			sched = drm_sched_pick_best(adev->vcn.vcn_dec_sched,
> +						    num_scheds);
> +			scheds = &sched;
>   			break;
>   		case AMDGPU_HW_IP_VCN_ENC:
>   			scheds = adev->vcn.vcn_enc_sched;
>   			num_scheds =  adev->vcn.num_vcn_enc_sched;
> +			sched = drm_sched_pick_best(adev->vcn.vcn_enc_sched,
> +						    num_scheds);
> +			scheds = &sched;

num_scheds need to be set to 1 here and above.

And maybe add a separate patch to fix the indentation of the case labels.

Christian.

>   			break;
>   		case AMDGPU_HW_IP_VCN_JPEG:
>   			scheds = adev->jpeg.jpeg_sched;

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
