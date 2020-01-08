Return-Path: <SRS0=oKuu=25=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D19EC282DD
	for <amd-gfx@archiver.kernel.org>; Wed,  8 Jan 2020 15:28:06 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B050420673
	for <amd-gfx@archiver.kernel.org>; Wed,  8 Jan 2020 15:28:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="rHH80xrx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B050420673
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 649926E8AC;
	Wed,  8 Jan 2020 15:28:05 +0000 (UTC)
Received: from NAM02-CY1-obe.outbound.protection.outlook.com
 (mail-eopbgr760052.outbound.protection.outlook.com [40.107.76.52])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 99C3A6E8A9
 for <amd-gfx@lists.freedesktop.org>; Wed,  8 Jan 2020 15:28:04 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WLyDG5vNrZr73bptoFk327BGHKuO7NN6QMod3BRU3LuVXWlXKJfqVbbK+8+TRK2+eZDrOapMw2lWDnpaSekOCfIZGrsta2ON6Ooim5VahhbxhtkK2SaMLlzl0etpvq1s5Z9qT3RulU1IQ+HUWGgvHktwwzLUHce1dA6rM/0XqZIWIg688iUwz6rKEQ0jfIIclgCEoNa/loq8cXaq8hawmK/mlbUoFRXwDK32QLuIUj1XOPfOtjDXBv/skl4AqcS5j8VX9vN9QxXBF9rB2ZuPFun8f6A3DKD7HPT54xwGkKGlAHQeXmoB/aM2EdgLaNALmkKS9IuFUM9VaE2d4Oo6VQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Iui1OTEesN5IoL5xCfjEdwVtNTgpCmDOYYRp2n8GlxY=;
 b=mknZZGQU/qsV6WmEComsRg6b25uRzqka3GtPaf/UbNEkr8uA2Tj5BEemkM4uDXu4jxf8YzAgp7AO8TLfarrc5Yl4Z0228/Dvo+UIoQej1yM2lfed3YPHtOxRvWldpEKvXf3WMqVUjQcqFvZrEAYs9dBPP1y2rB5ISIraa1EK/iqKALP2oKty+4u5FGAxcnHK+P7inj2rsmYD09hycM3jUyeCCyoUwSKOe9+KGYde0edK8c1ObYKmDpjsvTjICOVW8hzf6WEU7sGNr99eJnQQELr/Kxt4/D2uKJGvevQ33lo3BYwfSVFJr7Rt6WSns9Ro2OTp51vym8LhG6q/JGB4aA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Iui1OTEesN5IoL5xCfjEdwVtNTgpCmDOYYRp2n8GlxY=;
 b=rHH80xrxVyX9wCdaMjl+i0dPcAexek0zkgVBWYno7c4PK3KJyjbrLCB0N7Bd3d+RPG2r5jQBCouZSM0ztsxVeagseIhEFNoUr60YBvPbCWCQlxjyriTIo6qyJzC2yqYsB1un7NBedR5IJK1mQsHQ3+hMln8vPXmppIjerrVryEY=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Harry.Wentland@amd.com; 
Received: from CY4PR1201MB0230.namprd12.prod.outlook.com (10.172.79.7) by
 CY4PR1201MB0261.namprd12.prod.outlook.com (10.172.78.21) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2602.10; Wed, 8 Jan 2020 15:27:49 +0000
Received: from CY4PR1201MB0230.namprd12.prod.outlook.com
 ([fe80::4c09:215c:e5d2:3c8f]) by CY4PR1201MB0230.namprd12.prod.outlook.com
 ([fe80::4c09:215c:e5d2:3c8f%9]) with mapi id 15.20.2602.016; Wed, 8 Jan 2020
 15:27:49 +0000
Subject: Re: [PATCH 2/2] drm/amdgpu: enable S/G display for renoir
To: Alex Deucher <alexdeucher@gmail.com>, amd-gfx@lists.freedesktop.org
References: <20200107211320.1820393-1-alexander.deucher@amd.com>
 <20200107211320.1820393-2-alexander.deucher@amd.com>
From: Harry Wentland <hwentlan@amd.com>
Autocrypt: addr=hwentlan@amd.com; keydata=
 mQENBFhb4C8BCADhHHUNoBQ7K7LupCP0FsUb443Vuqq+dH0uo4A3lnPkMF6FJmGcJ9Sbx1C6
 cd4PbVAaTFZUEmjqfpm+wCRBe11eF55hW3GJ273wvfH69Q/zmAxwO8yk+i5ZWWl8Hns5h69K
 D9QURHLpXxrcwnfHFah0DwV23TrD1KGB7vowCZyJOw93U/GzAlXKESy0FM7ZOYIJH83X7qhh
 Q9KX94iTEYTeH86Wy8hwHtqM6ySviwEz0g+UegpG8ebbz0w3b5QmdKCAg+eZTmBekP5o77YE
 BKqR+Miiwo9+tzm2N5GiF9HDeI2pVe/egOLa5UcmsgdF4Y5FKoMnBbAHNaA6Fev8PHlNABEB
 AAG0J0hhcnJ5IFdlbnRsYW5kIDxoYXJyeS53ZW50bGFuZEBhbWQuY29tPokBNwQTAQgAIQUC
 WFvgLwIbAwULCQgHAgYVCAkKCwIEFgIDAQIeAQIXgAAKCRAtWBXJjBS24xUlCAC9MqAlIbZO
 /a37s41h+MQ+D20C6/hVErWO+RA06nA+jFDPUWrDJKYdn6EDQWdLY3ATeAq3X8GIeOTXGrPD
 b2OXD6kOViW/RNvlXdrIsnIDacdr39aoAlY1b+bhTzZVz4pto4l+K1PZb5jlMgTk/ks9HesL
 RfYVq5wOy3qIpocdjdlXnSUKn0WOkGBBd8Nv3o0OI18tiJ1S/QwLBBfZoVvfGinoB2p4j/wO
 kJxpi3F9TaOtLGcdrgfghg31Fb48DP+6kodZ4ircerp4hyAp0U2iKtsrQ/sVWR4mbe3eTfcn
 YjBxGd2JOVdNQZa2VTNf9GshIDMD8IIQK6jN0LfY8Py2uQENBFhb4C8BCAC/0KWY3pIbU2cy
 i7GMj3gqB6h0jGqRuMpMRoSNDoAUIuSh17w+bawuOF6XZPdK3D4lC9cOXMwP3aP9tTJOori2
 8vMH8KW9jp9lAYnGWYhSqLdjzIACquMqi96EBtawJDct1e9pVgp+d4JXHlgIrl11ITJo8rCP
 dEqjro2bCBWxijsIncdCzMjf57+nR7u86SBtGSFcXKapS7YJeWcvM6MzFYgIkxHxxBDvBBvm
 U2/mAXiL72kwmlV1BNrabQxX2UnIb3xt3UovYJehrnDUMdYjxJgSPRBx27wQ/D05xAlhkmmL
 FJ01ZYc412CRCC6gjgFPfUi2y7YJTrQHS79WSyANABEBAAGJAR8EGAEIAAkFAlhb4C8CGwwA
 CgkQLVgVyYwUtuM72Qf+J6JOQ/27pWf5Ulde9GS0BigA1kV9CNfIq396TgvQzeyixHMvgPdq
 Z36x89zZi0otjMZv6ypIdEg5co1Bvz0wFaKbCiNbTjpnA1VAbQVLSFjCZLQiu0vc+BZ1yKDV
 T5ASJ97G4XvQNO+XXGY55MrmhoNqMaeIa/3Jas54fPVd5olcnUAyDty29/VWXNllUq38iBCX
 /0tTF7oav1lzPGfeW2c6B700FFZMTR4YBVSGE8jPIzu2Fj0E8EkDmsgS+nibqSvWXfo1v231
 410h35CjbYDlYQO7Z1YD7asqbaOnF0As+rckyRMweQ9CxZn5+YBijtPJA3x5ldbCfQ9rWiTu XQ==
Message-ID: <216a2402-29c6-e093-42d8-e70b5a0d5be6@amd.com>
Date: Wed, 8 Jan 2020 10:27:47 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.1
In-Reply-To: <20200107211320.1820393-2-alexander.deucher@amd.com>
Content-Language: en-US
X-ClientProxiedBy: YTXPR0101CA0047.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b00:1::24) To CY4PR1201MB0230.namprd12.prod.outlook.com
 (2603:10b6:910:1e::7)
MIME-Version: 1.0
Received: from [10.4.33.74] (165.204.55.251) by
 YTXPR0101CA0047.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b00:1::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2623.9 via Frontend
 Transport; Wed, 8 Jan 2020 15:27:48 +0000
X-Originating-IP: [165.204.55.251]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 12910c53-4ad9-4ef9-a928-08d7944f51ab
X-MS-TrafficTypeDiagnostic: CY4PR1201MB0261:|CY4PR1201MB0261:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <CY4PR1201MB02611C824A4DF475B475B5268C3E0@CY4PR1201MB0261.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1303;
X-Forefront-PRVS: 02760F0D1C
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10009020)(4636009)(366004)(376002)(346002)(39860400002)(396003)(136003)(199004)(189003)(31696002)(66946007)(66476007)(186003)(16526019)(2906002)(2616005)(81166006)(956004)(8936002)(81156014)(31686004)(478600001)(26005)(8676002)(53546011)(66556008)(4326008)(52116002)(5660300002)(6486002)(316002)(16576012)(36756003);
 DIR:OUT; SFP:1101; SCL:1; SRVR:CY4PR1201MB0261;
 H:CY4PR1201MB0230.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: o2ixUHL7TZfRaixNJq5kHtXS0QGjjJUuxaRJkVVHoAQrzX2eJSdWOtkvhLQ71osjMnzd7syHc3MJe5F45eGonoiGnOlLzIC2xOV+8eRvXQTPvMq/+XjRLc0jaYUFasBRTMFC+XIBd9Mlup8ZpQCpv2AGtgnQ7EdbKn+mqgCwUcrQ1r9z0NOExa9dyGM4nrI2YGwhj+QyjsKQQqrrchCLHgPX72oJLoX/AfBxx/+UHXIChCZbytF7il3KF9vdkZ9BXUIHxBQtYwsyAMzhMt53dVPaIu1T+AiT/wrK0KJSmtL0QFrhUj5XUa8pEJ0sDtaNoax7QIugyYVSSrminLUOE0+OoIAtF3dXisgrb6AF2M4ew+RyBM0TgTkudCVrAngh6FBWJp/psJ+FotaGNEUv2fP2G4gxzLxkmS08a4jFGuge3l+tw5MHqvZ54cx7oYGP
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 12910c53-4ad9-4ef9-a928-08d7944f51ab
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jan 2020 15:27:49.6113 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MnpJaPaxo6wMmYwJiQC1Lu1R1tveg/p0pY6UKn5f9yL/P7JYxmi9zpwGKFsKTZGNjGBvH4CxJXUCbK2LwEkmEg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR1201MB0261
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Series is
Reviewed-by: Harry Wentland <harry.wentland@amd.com>

Harry

On 2020-01-07 4:13 p.m., Alex Deucher wrote:
> Everything is in place so go ahead and enable this for
> renoir.
> 
> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> ---
> 
> I don't have a renoir board handy.  Can someone test this?
> 
>  drivers/gpu/drm/amd/amdgpu/amdgpu_display.c       | 1 +
>  drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 1 +
>  2 files changed, 2 insertions(+)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_display.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_display.c
> index 6d520a3eec40..318605ca9bc3 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_display.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_display.c
> @@ -519,6 +519,7 @@ uint32_t amdgpu_display_supported_domains(struct amdgpu_device *adev,
>  		switch (adev->asic_type) {
>  		case CHIP_CARRIZO:
>  		case CHIP_STONEY:
> +		case CHIP_RENOIR:
>  			domain |= AMDGPU_GEM_DOMAIN_GTT;
>  			break;
>  		case CHIP_RAVEN:
> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> index 05118c8860f9..3be7ab0ce9e3 100644
> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> @@ -909,6 +909,7 @@ static int amdgpu_dm_init(struct amdgpu_device *adev)
>  	switch (adev->asic_type) {
>  	case CHIP_CARRIZO:
>  	case CHIP_STONEY:
> +	case CHIP_RENOIR:
>  		init_data.flags.gpu_vm_support = true;
>  		break;
>  	case CHIP_RAVEN:
> 
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
