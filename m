Return-Path: <SRS0=GTlj=2G=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B391C2D0C3
	for <amd-gfx@archiver.kernel.org>; Mon, 16 Dec 2019 19:28:22 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 64B9720CC7
	for <amd-gfx@archiver.kernel.org>; Mon, 16 Dec 2019 19:28:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="bw/kchxj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 64B9720CC7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2A5E76E86B;
	Mon, 16 Dec 2019 19:28:22 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2045.outbound.protection.outlook.com [40.107.237.45])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 231A56E86B
 for <amd-gfx@lists.freedesktop.org>; Mon, 16 Dec 2019 19:28:21 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Picooo8iZsXGQ2llmccLg8jDSaTH3wEf/egdXc0L+m/2sdKBYZZKSRcT8vOsiqxX8+AnfuOdmNGJo30+I8ELSxPArsoS7g7ZFnEtYOzQ1aekXUvKQvFGyvJt/wTi1WRn/iTJWp+p/3w70sFVY3GtM949VYSuibRgXh6EPLg53Lz84I29LBvFNSKXAniQGGHR8qPuue9XHWX1/DgGDocHeRvn1Knv7P9aEwM0RRLBurQRTueqF/orofSnkLAsD6GVMuoJga+GU1f2wslQoB6YTRK8Dk6xLT9WOche96aS4FD7ipKkIzbjzrviPdS2iiwiak1W/Z+AghW1Pgf6opNNvw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=a80AQVFvFkoFwns8IoTqzAmal2edEM55sknLNN+ML1c=;
 b=gF36w4EBDt1euID3k0yfOfAAu9t6nRxro0ohMsYB5NP53l/Ipw6c/p5tT95FQkgex/dSUJltWPGla4uGrgPlEgnB6EEQKjN1hNaFjcBCcToqmchZ99tX0tk+fxZFpwwwZcWwFjk6M/gbb/NZnfh85S8sxQM+T05dmrKKFfg7YsvTvdRqyJhqkMdzKmJFoX/+fguCH8Dp8TwXhL9uqmrVGmKoqQMt8rfNUm5RqmRSnE3cG0vQQmYeeXD4sBBgwcNL2BGoDoEn7MwSrJKb3y9Tkd/WxSkrbQWZDmrbNjzlOiFVIDYr6ruXIl338YRNcT/kU+rj+RwPO9BF1cdlT6XYPA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=a80AQVFvFkoFwns8IoTqzAmal2edEM55sknLNN+ML1c=;
 b=bw/kchxjUoX+bHZyR5Y5hr6XnX+F2X9oZ+h0kcq8GqVk6jSJeKiae/GS85IAdiTQQfDQvLaKs8rEI8TYIkavMLj2FVp90CbRVtsTUaEM85P4x7bYDH++u8xUYMkBOc13Qss+OWFOoUNVLLgMjYDksgxiq3oxkRnO09LGZWBcvts=
Received: from DM6PR12MB3466.namprd12.prod.outlook.com (20.178.198.225) by
 DM6PR12MB2940.namprd12.prod.outlook.com (20.179.71.211) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2538.16; Mon, 16 Dec 2019 19:28:17 +0000
Received: from DM6PR12MB3466.namprd12.prod.outlook.com
 ([fe80::8954:6ba3:6dca:4616]) by DM6PR12MB3466.namprd12.prod.outlook.com
 ([fe80::8954:6ba3:6dca:4616%7]) with mapi id 15.20.2538.019; Mon, 16 Dec 2019
 19:28:17 +0000
From: "Liu, Zhan" <Zhan.Liu@amd.com>
To: "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>, "Wu,
 Hersen" <hersenxs.wu@amd.com>, "Deucher, Alexander"
 <Alexander.Deucher@amd.com>, "Wang, Kevin(Yang)" <Kevin1.Wang@amd.com>,
 "Quan, Evan" <Evan.Quan@amd.com>, "Yin, Tianci (Rico)" <Tianci.Yin@amd.com>
Subject: RE: [PATCH] drm/amd/powerplay: Add SMU WMTABLE Validity Check for
 Renoir
Thread-Topic: [PATCH] drm/amd/powerplay: Add SMU WMTABLE Validity Check for
 Renoir
Thread-Index: AQHVsdVWCWA70Diac06p01xvVtWOJ6e9KjuQ
Date: Mon, 16 Dec 2019 19:28:17 +0000
Message-ID: <DM6PR12MB34660C3DC2BBDE6DBA469FA89E510@DM6PR12MB3466.namprd12.prod.outlook.com>
References: <20191213164931.26471-1-zhan.liu@amd.com>
In-Reply-To: <20191213164931.26471-1-zhan.liu@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Zhan.Liu@amd.com; 
x-originating-ip: [165.204.55.250]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 4969e4a4-2b8a-47df-1d00-08d7825e1a65
x-ms-traffictypediagnostic: DM6PR12MB2940:|DM6PR12MB2940:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM6PR12MB2940D6BDECD8CC28344B85E29E510@DM6PR12MB2940.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:813;
x-forefront-prvs: 02530BD3AA
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(4636009)(396003)(366004)(346002)(39860400002)(376002)(136003)(13464003)(189003)(199004)(66476007)(64756008)(66556008)(26005)(81156014)(66446008)(8676002)(2906002)(86362001)(186003)(33656002)(5660300002)(7696005)(9686003)(6636002)(478600001)(55016002)(53546011)(71200400001)(52536014)(76116006)(66946007)(8936002)(6506007)(110136005)(316002)(81166006)(921003)(1121003);
 DIR:OUT; SFP:1101; SCL:1; SRVR:DM6PR12MB2940;
 H:DM6PR12MB3466.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: QW+iaSq7QtVcm5OWP+28jAY1K48BPx4ZD2TxOfZ8dRKNaOpibUCN0Yg7EM6UNghZ0wtwZQb/MHl+OeUck/dqd5VQW8lsBqrEZvobVPLrjPJhOY/mmRbgueiG9De4Wzp6D9so//GqD2vjJV5LE9E1+TRlZp6AEtfCQA4zeCdQH9tQxZVq1vOcFwh2oD/Y1xn7LyVklQJC9kPfjb0O2A4rli0N+JbdYSKLXKlhlz8uyX1wI/1ion0aUA3btlzCMNIi44l4N2YcDY7aPr1E4XeTgc5wDL4ThIiFlDKxh6RnZaiB2KIbzOB+EXO0pHbkj39DVKW7gTQMgpmjQVegl/4WTt6GFC7Tkmgnea7cl2fHXaeUhw0frFuPTpoq/mtQ7Mu52G2jeusdjuAuNV/klXT41XCccE7sQYVJxgtS6wMj6Kxpusm7hN7SuME829GeCiWjLJ+L9z5ns1pZ1O+mdxRHFZdfcM5Ui2u7KoZH5xkpGubqVVZ9Qt+DF8JjkeqFJW32E3OGVg/mY/HtLLDQcM+epQ==
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4969e4a4-2b8a-47df-1d00-08d7825e1a65
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Dec 2019 19:28:17.6625 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: OYOvwzNwOkbn2FSsParNFkYcmWbOKIdkz2OeVf8lo/02T+CPKvYwMGWbEsLsciP0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB2940
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

Ping...

> -----Original Message-----
> From: Liu, Zhan <Zhan.Liu@amd.com>
> Sent: 2019/December/13, Friday 11:50 AM
> To: amd-gfx@lists.freedesktop.org; Wu, Hersen <hersenxs.wu@amd.com>;
> Deucher, Alexander <Alexander.Deucher@amd.com>; Wang, Kevin(Yang)
> <Kevin1.Wang@amd.com>; Quan, Evan <Evan.Quan@amd.com>; Yin, Tianci
> (Rico) <Tianci.Yin@amd.com>
> Cc: Liu, Zhan <Zhan.Liu@amd.com>
> Subject: [PATCH] drm/amd/powerplay: Add SMU WMTABLE Validity Check
> for Renoir
> 
> [Why]
> SMU watermark table (WMTABLE) validity check is missing on Renoir. This
> validity check is very useful for checking whether WMTABLE is updated
> successfully.
> 
> [How]
> Add SMU watermark validity check.
> 
> Signed-off-by: Zhan Liu <zhan.liu@amd.com>
> ---
>  drivers/gpu/drm/amd/powerplay/renoir_ppt.c | 12 ++++++++++--
>  1 file changed, 10 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/powerplay/renoir_ppt.c
> b/drivers/gpu/drm/amd/powerplay/renoir_ppt.c
> index 89a54f8e08d3..81520b0fca68 100644
> --- a/drivers/gpu/drm/amd/powerplay/renoir_ppt.c
> +++ b/drivers/gpu/drm/amd/powerplay/renoir_ppt.c
> @@ -777,9 +777,17 @@ static int renoir_set_watermarks_table(
>  	}
> 
>  	/* pass data to smu controller */
> -	ret = smu_write_watermarks_table(smu);
> +	if ((smu->watermarks_bitmap & WATERMARKS_EXIST) &&
> +			!(smu->watermarks_bitmap &
> WATERMARKS_LOADED)) {
> +		ret = smu_write_watermarks_table(smu);
> +		if (ret) {
> +			pr_err("Failed to update WMTABLE!");
> +			return ret;
> +		}
> +		smu->watermarks_bitmap |= WATERMARKS_LOADED;
> +	}
> 
> -	return ret;
> +	return 0;
>  }
> 
>  static int renoir_get_power_profile_mode(struct smu_context *smu,
> --
> 2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
