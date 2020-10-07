Return-Path: <SRS0=8cN+=DO=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2719C4363C
	for <amd-gfx@archiver.kernel.org>; Wed,  7 Oct 2020 09:17:47 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4767320870
	for <amd-gfx@archiver.kernel.org>; Wed,  7 Oct 2020 09:17:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="mTxuPX3l"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4767320870
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 318CF6E8B1;
	Wed,  7 Oct 2020 09:17:46 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2061.outbound.protection.outlook.com [40.107.243.61])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1B5346E8B1
 for <amd-gfx@lists.freedesktop.org>; Wed,  7 Oct 2020 09:17:43 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EypTZZYPN3A66N0bl+yCyWMVEbINJ9ACZWVGIye2jHFs5QB+RWUG/KboCgSWX5sZRh079QjihGq6gUdiEd7BEVKBhKkZ1H+O1vxh08oi/5r7tkRepLnIcoWeqCjVL+nivwTXL/QWAEMudlaPDgemzVQL/4E6GvP0Ma8nSBWY3jbGv/+ywZ8vwFpp7/zCtSb7aX9aq1pw1LaqhEY5nzTKAoKowy+lHa84a+9hkCdfCUUIxSUe9ASUaDnAXBod+Hb3nLeCJP0zGnOlkn5qMQb1mrlZmgjRe69YOcQ665Qu1k59I/C/awPD8PRsH3jLGHkcVrNsikQhLg7FakM00vNbiA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yTpQjnUIjTKGnirOfvsuocIk4+frNbPS9ehaU60ZyUE=;
 b=DvIk2gDjUfnQItbxK5KlsG3jya7BnxDxTU6J40Uq0SQ5ppQuxeWGufRqnqh807GwSH9+qyn9fAzip42CrlNZDGNRzs091SGl6HSOEqPapKmtSegypn/T+DX5zDrXiM4bdyHPYPkP1ll4B4+Rr2topxazOzZuo0NLbYVNxZQ+drqnyWUQMkTZTD43w5D2ZwmqjaLZa4WACUvRJqofPCV2Ze/EOgwtRx+2wItUEc1o85dC7xmZ6a5Of1AzpKeMNERBOunhrc52K5oFq4a609ukpmIrR2Ch2p7T9EnGnH1AYdYA7PuZj9gnBoAa4QEMpws5Fx5XH77ljcFuy/ZvGFwmIg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yTpQjnUIjTKGnirOfvsuocIk4+frNbPS9ehaU60ZyUE=;
 b=mTxuPX3lcvC0Bt59zZqUhyCtupy0tpfF7rwDtKmU2a/9mjnf5ro30/N6ZRnTXHyCWmHhiaPHLpXy7qUYAADms8/0jcQnrqhrJRUvNRM7lh2y78afARnQEMfaLY9BS//2o8/ste9XSdKOluSmCosNO/D2nXnFB9ErtHwLixG1Xdc=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB3916.namprd12.prod.outlook.com (2603:10b6:5:1ca::21)
 by DM6PR12MB2972.namprd12.prod.outlook.com (2603:10b6:5:39::31) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3433.36; Wed, 7 Oct
 2020 09:17:41 +0000
Received: from DM6PR12MB3916.namprd12.prod.outlook.com
 ([fe80::5c29:f133:1209:b74d]) by DM6PR12MB3916.namprd12.prod.outlook.com
 ([fe80::5c29:f133:1209:b74d%6]) with mapi id 15.20.3433.045; Wed, 7 Oct 2020
 09:17:41 +0000
Subject: Re: [PATCH] drm/amdgpu: Add error message for DAC setup failure
To: amd-gfx@lists.freedesktop.org
References: <20201006060515.4622-1-shashank.sharma@amd.com>
From: Nirmoy <nirmodas@amd.com>
Message-ID: <518249f6-b530-10f4-032f-1ad7b12fccb4@amd.com>
Date: Wed, 7 Oct 2020 11:17:37 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
In-Reply-To: <20201006060515.4622-1-shashank.sharma@amd.com>
Content-Language: en-US
X-Originating-IP: [217.86.108.107]
X-ClientProxiedBy: AM4PR0302CA0002.eurprd03.prod.outlook.com
 (2603:10a6:205:2::15) To DM6PR12MB3916.namprd12.prod.outlook.com
 (2603:10b6:5:1ca::21)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.178.87] (217.86.108.107) by
 AM4PR0302CA0002.eurprd03.prod.outlook.com (2603:10a6:205:2::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3455.21 via Frontend
 Transport; Wed, 7 Oct 2020 09:17:41 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 3ca72181-f582-45cf-d9a3-08d86aa1d7bb
X-MS-TrafficTypeDiagnostic: DM6PR12MB2972:
X-Microsoft-Antispam-PRVS: <DM6PR12MB29721FE173B9196592DD273E8B0A0@DM6PR12MB2972.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:439;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: vKYquQgB5JgfLqPYCvHmAae7/+sgbujJRd1oH7cnSHLS3SOI1NfGarrnWrINTedmU75KBUoTxbBLa8cjz4ob4FmbeMaxQujBtHofnLLYgSVCGlHzX5JmPjM0+1fbn0oS3+tt0y1seLi+se577T55OGjX6rfXro/o+kLRaN4qtDcp5Rqk/QuiLxkLwwaf50Z1Kt416bwk/ttoEBxhN54U9tlr/pXa5p4KJ8dOj6amCKZVCs7DvhWJ7AOab6b6hGaRU6RmjjyfD5Dg3oEe4yxkYuIrqf353PYVdhSq0mOAlgw5gguVgerU4zIyw0OCZ/iNOs2cCfwXJlaGKueiM5wO5QLQS+kTp1gSbwW7+HyQFqBlfqxlQXZIwaeGa9Z9Fbmm
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB3916.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(376002)(136003)(39860400002)(396003)(346002)(366004)(26005)(956004)(2616005)(8676002)(31696002)(66556008)(5660300002)(66476007)(186003)(16526019)(66946007)(478600001)(6916009)(16576012)(31686004)(6486002)(83380400001)(8936002)(2906002)(53546011)(36756003)(15650500001)(52116002)(6666004)(316002)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: H1klOk0R+OV4KiBgWPKN9w3uauVJhZgOiAHz3ZtyYPRHwBcqSN0r99PTCTFclicMc9Rn7eozyesjGu8hjJLQJXuEH5VMzlz45CBVrvWqSvp+fC6x/Sr1BUua3jjrPCN0DRAiyBz4jWsR27MJHn/V29avFoVyyN0FfM81vkGqbz6j3CqkrH3effZvsI3t+YT2AM5/lB9eboqUmhF6+kCRzJtqGsba+NENDh4u9DoOdPzy95zNDEaq9kaNIzlh0Hd9M8ja1k6N6P4XyqP6bXtCEg7aMeJapdzzpcJmb1eQWK8hwxiZ/ENc36nbg3ZvfR9/9H1jEh/5N+7GxCLiT/PBUIKtnhv6z0qh9Pib+P9bS5xlLewmCe1tT/J/08VQqRCfVG30Jkxh3Wd7x2hBYhQ1+UU3LYXLBUW1imoZeo2plBmUL88m6KYPMBvAHxjVUYSo+K+2qg0b4Oxe/1PFYYOBQ5/EpTZrjAtzhAH3Ll48lt/V4hwlK+Bu7THzjSiVphXMvyKzvSOn4P1OduXYF4mOx3saIwxz2wmzqEB0WFC0Tl4M1C38WHDMOq2bFQ6jSKw1Y7YhJJN6L6zz98YEyeIsjlA5GVIHQEqFjQf6A0lqscoITEgtInRXBuQiIlk/wQRACqeahmW0AOoNf/3/o/VZSg==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3ca72181-f582-45cf-d9a3-08d86aa1d7bb
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3916.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Oct 2020 09:17:41.6865 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 38VeXUyAn2mAHWfBzgUMeSMtpPgnNtFg49khm+mElmtkf//i/S3lYCLOv0JJyaIvjRnSpy2fvG+pk+zsvjJc1g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB2972
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
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Acked-by: Nirmoy Das <nirmoy.das@amd.com>

On 10/6/20 8:05 AM, Shashank Sharma wrote:
> This patch adds a return value check and an error message to
> highlight the DAC setup failure case during encoder DPMS
> operation.
>
> Cc: Alex Deucher <alexander.deucher@amd.com>
> Signed-off-by: Shashank Sharma <shashank.sharma@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/atombios_encoders.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/atombios_encoders.c b/drivers/gpu/drm/amd/amdgpu/atombios_encoders.c
> index 1e94a9b652f7..3779f933564b 100644
> --- a/drivers/gpu/drm/amd/amdgpu/atombios_encoders.c
> +++ b/drivers/gpu/drm/amd/amdgpu/atombios_encoders.c
> @@ -341,8 +341,8 @@ amdgpu_atombios_encoder_setup_dac(struct drm_encoder *encoder, int action)
>   	args.ucDacStandard = ATOM_DAC1_PS2;
>   	args.usPixelClock = cpu_to_le16(amdgpu_encoder->pixel_clock / 10);
>   
> -	amdgpu_atom_execute_table(adev->mode_info.atom_context, index, (uint32_t *)&args);
> -
> +	if (amdgpu_atom_execute_table(adev->mode_info.atom_context, index, (uint32_t *)&args))
> +		DRM_ERROR("AMDGPU: dac setup failed\n");
>   }
>   
>   static u8 amdgpu_atombios_encoder_get_bpc(struct drm_encoder *encoder)
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
