Return-Path: <SRS0=j6k1=2N=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D47AFC2D0C0
	for <amd-gfx@archiver.kernel.org>; Mon, 23 Dec 2019 21:06:24 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9DC8C206D3
	for <amd-gfx@archiver.kernel.org>; Mon, 23 Dec 2019 21:06:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="QzdeFMxu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9DC8C206D3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 590D56E2F0;
	Mon, 23 Dec 2019 21:06:23 +0000 (UTC)
Received: from NAM04-CO1-obe.outbound.protection.outlook.com
 (mail-eopbgr690079.outbound.protection.outlook.com [40.107.69.79])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4AFDE6E2F0
 for <amd-gfx@lists.freedesktop.org>; Mon, 23 Dec 2019 21:06:22 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=b9r2+IZT1TRvPBwZJoj8pqVK61okjqkES4teOIqVokH/hMuNuXybFqUSz1Zvzu7jtfoa70Y56xY04HegJOZYMP5l8qsKtCZk83GVdl5NLpGd/KUZuEyfl7+e/L8AR08XwesqOkWhGWFi3GWJu0KorQmvk27maH15TJ+fovNRoMN/IVVhCWrdXqHEilHVPB6uplnIXG4kiWSPVv3dZZf49BQWFnB2P+QQwp06AdIjskkSIHaLxhkmNXTAR946FZI6c95EjurgYiQyHVvZlnsHGQbXU/JkOLDBAYMTMtMKJPloqzL/AU7CUTHIfxHqWLavIeqN+bO2E+FCRvBjDkY6fg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ePX4hRbh1DDoL91C1BD00wnt6uqN19Zw0DPMiu/1V+k=;
 b=T1Gvjae4ANu9YoJgAn3rQxjg6AmTkJ9uhLSLqdsz6dJYGssexAQpcPE9URhLmYQLK5d3ohydz49wOgxlvr8tYuzvybuRE1hxafiQi8sJg310j04FaP7DCCcC+LvCcUTiEmPF1ZfawqCl/kWw29REwVHr9RBRUu/nwlA/RPhjoaSrmvfXWsmHmgnPQad6eMK3XdAqKaxCMlfYp2PLZevCOGuJ4IgWheAoi2yxUiarsvBtMRPr4yNmfYNikeElDHamIOvLOQWXD3yPNy0oZBrA8QgJwKfFvTnv9Ni3JGR+RQXec0fUI8Nw8uv5xL7WqCFTxjyA94WLv5vjsnx7ozpi1w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ePX4hRbh1DDoL91C1BD00wnt6uqN19Zw0DPMiu/1V+k=;
 b=QzdeFMxuElxkb0Or5T7svxGz2WDSb8jFQKae6scvT2YQGtSZ9juGM4U58BwnZgjEZGk7s4VKXrqKmKWzJAHOQur+o9N2OU6H73jowPQxlVQ6TimyCa31X0Fhq46iXG+LYolP2B/PSrvU2thG9X6t4HmkzNlBXno3pupBbLbmjPI=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Harry.Wentland@amd.com; 
Received: from CY4PR1201MB0230.namprd12.prod.outlook.com (10.172.79.7) by
 CY4PR1201MB0038.namprd12.prod.outlook.com (10.172.76.137) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2559.20; Mon, 23 Dec 2019 21:06:20 +0000
Received: from CY4PR1201MB0230.namprd12.prod.outlook.com
 ([fe80::301e:b0c8:7af:d77d]) by CY4PR1201MB0230.namprd12.prod.outlook.com
 ([fe80::301e:b0c8:7af:d77d%11]) with mapi id 15.20.2559.017; Mon, 23 Dec 2019
 21:06:20 +0000
Subject: Re: [PATCH] drm/amd/display: Don't disable DP PHY when link loss
 happens
To: Zhan Liu <zhan.liu@amd.com>, amd-gfx@lists.freedesktop.org,
 hersenxs.wu@amd.com, Wenjing.Liu@amd.com, paul.hsieh@amd.com
References: <20191223204617.2174-1-zhan.liu@amd.com>
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
Message-ID: <5ba0c1b9-b8cf-1a27-f616-a4ab144b7284@amd.com>
Date: Mon, 23 Dec 2019 16:06:17 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.0
In-Reply-To: <20191223204617.2174-1-zhan.liu@amd.com>
Content-Language: en-US
X-ClientProxiedBy: YTOPR0101CA0025.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b00:15::38) To CY4PR1201MB0230.namprd12.prod.outlook.com
 (2603:10b6:910:1e::7)
MIME-Version: 1.0
Received: from [10.4.33.74] (165.204.55.251) by
 YTOPR0101CA0025.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b00:15::38) with
 Microsoft SMTP Server (version=TLS1_2, cipher=) via Frontend Transport;
 Mon, 23 Dec 2019 21:06:19 +0000
X-Originating-IP: [165.204.55.251]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 649fda44-6326-4474-6014-08d787ebf533
X-MS-TrafficTypeDiagnostic: CY4PR1201MB0038:|CY4PR1201MB0038:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <CY4PR1201MB003817E3518757CF4E08255F8C2E0@CY4PR1201MB0038.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7691;
X-Forefront-PRVS: 0260457E99
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10009020)(4636009)(346002)(39860400002)(376002)(136003)(396003)(366004)(199004)(189003)(31696002)(6636002)(5660300002)(16576012)(316002)(6486002)(8936002)(36756003)(81166006)(8676002)(81156014)(2906002)(31686004)(4001150100001)(53546011)(186003)(2616005)(66476007)(66946007)(52116002)(66556008)(26005)(16526019)(478600001)(956004);
 DIR:OUT; SFP:1101; SCL:1; SRVR:CY4PR1201MB0038;
 H:CY4PR1201MB0230.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: +F/cpiEB1+JotyDWu9aMYa3PT2SYlUUg3qAR96Lkbu1ZccEjTM89gSSMaadDlEx69CsUJwLcRFQdCnH+jPlQkDcF2zUF3BUtsoZz25gkCH7c8ObvJUMBfGwleTW16C09/NeRh7nKwV4+jF2jV8OaZUOVM8t8uopIAJoO0TSA3LnIKmv6iwRIiBW05Bo/c6B1DxYzSUBQv3zqBNcuIiGr67/ecfqkZNU08R5UnG4yHSCWiEJceXV90FrUOZD1lX+tt4kdL4yviKQJ3XK05aafbIJP4nf89Oy1dcdd5JYQz4rBoCAA3lMmsRVbdl5FKpJCfF/r/Tqi992PRjzDaB8Aq71Zqxcgvs3spyvj+vwCgVU3IZ8PWT9K3rliauoR8N535X9z98emNtnIIMRehsaTkgHpNr93DDT56ePT77HDn4Y5lxLKbA1oEp2Ip75lWZJV
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 649fda44-6326-4474-6014-08d787ebf533
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Dec 2019 21:06:19.9532 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /GrWHgE7yKiSmYmB8R/U41KR3/cdmh4CAQIG0PyK4rbErdaLUao5Dr5kPP+kbRoes6/HDodpuFtMUyIwIkGv0w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR1201MB0038
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On 2019-12-23 3:46 p.m., Zhan Liu wrote:
> [Why]
> There is a use case that link loss happens accidentally,
> and we need to recover that link loss as soon as possible.
> Under this circumstance, DP PHY will perform link training,
> then try to recover the link that's just lost.
> 
> However, if link PHY is disabled by code here, then
> DP display will never come back again.
> 
> [How]
> Don't disable DP transmitter and its encoder, even if
> link loss is detected.
> 
> Signed-off-by: Zhan Liu <zhan.liu@amd.com>
> ---
>  drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c b/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c
> index 38b0f4347383..49f48d432923 100644
> --- a/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c
> +++ b/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c
> @@ -2876,7 +2876,6 @@ bool dc_link_handle_hpd_rx_irq(struct dc_link *link, union hpd_irq_data *out_hpd
>  			return false;
>  
>  		previous_link_settings = link->cur_link_settings;
> -		dp_disable_link_phy(link, pipe_ctx->stream->signal);

Have you synced with Paul to make sure this doesn't regress his patch?
We don't want to break USB-C displays again.

It sounds like that dp_disable_link_phy was added here for a reason but
it's hard to see from Paul's patch whether this line is integral or
incidental.

Harry

>  
>  		perform_link_training_with_retries(&previous_link_settings,
>  			true, LINK_TRAINING_ATTEMPTS,
> 
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
