Return-Path: <SRS0=W/Sk=6I=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B18BC54FCB
	for <amd-gfx@archiver.kernel.org>; Fri, 24 Apr 2020 23:17:50 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C860A214AF
	for <amd-gfx@archiver.kernel.org>; Fri, 24 Apr 2020 23:17:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="Kg2ZuPzw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C860A214AF
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3FDD16E10C;
	Fri, 24 Apr 2020 23:17:49 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2054.outbound.protection.outlook.com [40.107.93.54])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4F3E26E10C
 for <amd-gfx@lists.freedesktop.org>; Fri, 24 Apr 2020 23:17:48 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AmMY8dIpH7Vec9yd90xHqR5BIyB+vWDAqTFyYdYLwNtqf5kLqKoo4wA1mvCppSjLBdbdlkHiYkpegdD+CUlQdfpQI6tN+DDNsCBHax9NQmJa1uAhljWS4fPl+9RheowM973histKX/99/aLtwQtUfJZZRsGytb3sqr6B5tCh3O9P/w4jp4iQyz4dzTj0xen1cTbRXCV1NUn/lfDJHkYwOHwVf9Ol8w2ws5BFTWpfhjbPPUlvYVpzWyNnVYkG+kQ5SqiH39O5B4qdfBWJ5N2LVpzwFSrAUuuRFAcMDf9wiz6aU2PYmOiCpsHr+6aS4Olh3SRAfNi/oMEZo/8AwqrrQg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oJekezaKwyzLilZJIJw5qj7C2kMRg8TbN8TY70wyqxQ=;
 b=X17jYXHsdPWl8TZ0o+Feu8wel5KabSeDiOgUfGi1bwf+D5wr4X+nsLusUgxw07SXipM0IUaN2FNZOWvy/V8Hb96qhyAxCXxu8zbqNAdzoXP1IS0szBKiR6gBwdhdVQIv0MwAUO1uRjyQADA1N1E+iRUPnyu2/hgeQbGwrQ7ylcEK0ovGvyTVSbLT/WtNTuvDi5xQURcpC31GFIyC+kOj6t+QfLfC66yAWPgkhypVI6o1J+spywSXJOwygC7l+A8QkaitgrMcYAm7bbiHZTCc4+X5M9CEmH2zFAzoE7qkm0LEuiEma8hUkoH2/s/OA4Ct7afBk5sDi3GhQnP4xI2YaA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oJekezaKwyzLilZJIJw5qj7C2kMRg8TbN8TY70wyqxQ=;
 b=Kg2ZuPzwkmu6zU7yS0jYwmuHGsL9HqmzSXMf4p6GH/V1YHZ669raSWtbWCxSNAiIyWG4xzJ0ZtCkGAE3ivcL+Q1BPB2fqKKKazmNvQcyXssRunjllXTXnuLfzF3fuRAXtihcGshE+1ICiAxfQjypShBySAaqC1uliRbZZBR9EWw=
Received: from MN2PR12MB4518.namprd12.prod.outlook.com (2603:10b6:208:266::19)
 by MN2PR12MB3709.namprd12.prod.outlook.com (2603:10b6:208:167::30)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2921.29; Fri, 24 Apr
 2020 23:17:47 +0000
Received: from MN2PR12MB4518.namprd12.prod.outlook.com
 ([fe80::4cd:783:ca8:7af0]) by MN2PR12MB4518.namprd12.prod.outlook.com
 ([fe80::4cd:783:ca8:7af0%5]) with mapi id 15.20.2921.027; Fri, 24 Apr 2020
 23:17:47 +0000
From: "Kim, Jonathan" <Jonathan.Kim@amd.com>
To: "Kuehling, Felix" <Felix.Kuehling@amd.com>
Subject: RE: [PATCH] drm/amdgpu: sw pstate switch should only be for vega20
Thread-Topic: [PATCH] drm/amdgpu: sw pstate switch should only be for vega20
Thread-Index: AQHWGobR9OJWsXjI7kGxtYUvn84HcaiI4I2AgAAHJNA=
Date: Fri, 24 Apr 2020 23:17:46 +0000
Message-ID: <MN2PR12MB4518AADCFB649E9817A11EEE85D00@MN2PR12MB4518.namprd12.prod.outlook.com>
References: <20200424222206.38743-1-jonathan.kim@amd.com>
 <20f873f9-b98b-ab9d-75f6-f8c5e4c1e2d8@amd.com>
In-Reply-To: <20f873f9-b98b-ab9d-75f6-f8c5e4c1e2d8@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Enabled=true;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SetDate=2020-04-24T23:17:41Z; 
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Method=Standard;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Name=Internal Use Only -
 Unrestricted;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ActionId=e64db0ba-1efd-430f-bd24-00000d7561a0;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ContentBits=1
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_enabled: true
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_setdate: 2020-04-24T23:17:41Z
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_method: Standard
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_name: Internal Use Only -
 Unrestricted
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_actionid: 6ea07c6a-663f-47b7-9bc1-00004b23fa16
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_contentbits: 0
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Jonathan.Kim@amd.com; 
x-originating-ip: [2607:fea8:7a0:187:5538:9a7a:87a0:c0b6]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 1b64309a-35bf-4fb2-e69c-08d7e8a5b337
x-ms-traffictypediagnostic: MN2PR12MB3709:|MN2PR12MB3709:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MN2PR12MB370991F401554FAD80AFE26685D00@MN2PR12MB3709.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7691;
x-forefront-prvs: 03838E948C
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB4518.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(10009020)(4636009)(376002)(136003)(366004)(396003)(346002)(39860400002)(66556008)(66476007)(9686003)(6506007)(7696005)(76116006)(8676002)(53546011)(66946007)(186003)(55016002)(71200400001)(66446008)(64756008)(5660300002)(6862004)(478600001)(52536014)(86362001)(4326008)(81156014)(33656002)(6636002)(316002)(8936002)(2906002);
 DIR:OUT; SFP:1101; 
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: +8CG+aAOfTDAGXkd4mUJ0/5p85YiC6rV4Dr5qp3rFMthVdZPlS7JxCJHxu7Fs/nPdFDZ4D9bcLte0ZmUP/GS33Bk/WBUeWcKR2zUgJt7tNx8cU/tvDfickVCdz/pfc9y5RXe2E+OrQfcD2DWPAZPPPyZUjILfjpkStGrBnJilbEan8a8Vgffa4A/4aUIYGbbnsvCh0CZv5KoZApHqGAAaQlpaOt81Nv6zmXR8Z4xIED9uWcZKwdxbPIBbxo2iPh821uzTqMdQx+S2ovkW3Sc9bbJdWpztzFdYB+TjKhI/pLIWprS9YOMh0mesVSdL2SiKQ/xa0c+8VHr5SZNvYKOvDuJoHmZYbk8IjCgbpt5rZFnt0j2NhmkHqzXWrZ3yNy8fqeQtXvFPDyldwejwQmwcfD/nerGrCTRy4Bv11JOocBHiQjheTa+oSMYJEhUB5AD
x-ms-exchange-antispam-messagedata: kSGqHg7Moq5wmKVTmOEe2n2ov7smeDVdJ55M3x8nzNr5kWg0eu5AcQ6MbjhVwEzNIbbriadwcbgMfDnGXCWkOaWjLdXQXd/mxwUN8Ekm+WvVQC21cBtCuAPOYnSi9You/ahwUaWABTHSANiL8DDErXI20zEFtp3A46JAoDRpatOEXg2AyaEpSEcuzcSPSfH533ZxPrzXWwj1iXKTZjaOdpToybTbawjY44Sk8ZdG/LeJTH3ncvDRxTWATTZmELoaLKfZHbKJsaet14A927u4AjaN3EHcs37SnRyWXAnbIDVDElq1jSGo+yDK+oydbQw0oAisoMhDNCxTlH8MBi5Vv7g06Rhd2w3dbycMQiZPRufiD6DMvWv3JWSj0XiFTcYFzL5JUoa7DDAcY0l9nR9F8Y+0OaKBVw4BuXmnOyccnc8TIVk0tK66Je1+CYGYnE7JL0ByIrLeVoVDXEkmzpNwkI66PdzL9f4u9qUhxY3x4bAHFAlts1M+SjnSo1feZ4VFsCnoYv0H4q2/2/rW5+DtD+ZlYyeixEiVP7uhKQ3Y8QIx8+fcKW41yahbTsjdFOoCGecS0djgW37P/Yzz1KnsFKdwSO5yhKJ7fhc6I38cfeSVYqsPLvYlu9gtR31Br9vo7GkeDTpCPUJRX6OSKs4Iv8E2yMpiD+f84zdzXqRgF4x3kLqnODFYn2bBalKVb5syVjw3i+rNlujtBKsvsPDc5Wmy+K8WmIyu0hIlWll92Y/AKZ59FnMvc/5qcj7+b5C2/utmZFXj3ATZkblFFWIS4B/zAasVZpdLD+qXPhzarRM+0UutAwG3CDQhtD1OYMRW9pjCGjj6e0fJc00eJdACGzRizNzWHkQPn+T0COJ2WOY=
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1b64309a-35bf-4fb2-e69c-08d7e8a5b337
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Apr 2020 23:17:46.8993 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: M71c6uZAOEBpRen2e0CXctwvggRKXjNuprtDCF8Cdlx5SBXirKXPpmDoDjKyiLp2
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3709
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
Cc: "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Official Use Only - Internal Distribution Only]

Yes that is correct.

Thank you,

Jon

-----Original Message-----
From: Kuehling, Felix <Felix.Kuehling@amd.com> 
Sent: Friday, April 24, 2020 6:51 PM
To: Kim, Jonathan <Jonathan.Kim@amd.com>
Cc: amd-gfx@lists.freedesktop.org
Subject: Re: [PATCH] drm/amdgpu: sw pstate switch should only be for vega20

Am 2020-04-24 um 6:22 p.m. schrieb Jonathan Kim:
> Driver steered p-state switching is designed for Vega20 only.
> Also simplify early return for temporary disable due to SMU FW bug.
>
> Signed-off-by: Jonathan Kim <Jonathan.Kim@amd.com>

Reviewed-by: Felix Kuehling <Felix.Kuehling@amd.com>

I assume the early return would be qualified with a firmware version check once a firmware fix is available.

> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c 
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c
> index 54d8a3e7e75c..48c0ce13f68e 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c
> @@ -395,7 +395,9 @@ int amdgpu_xgmi_set_pstate(struct amdgpu_device *adev, int pstate)
>  	bool init_low = hive->pstate == AMDGPU_XGMI_PSTATE_UNKNOWN;
>  
>  	/* fw bug so temporarily disable pstate switching */
> -	if (!hive || adev->asic_type == CHIP_VEGA20)
> +	return 0;
> +
> +	if (!hive || adev->asic_type != CHIP_VEGA20)
>  		return 0;
>  
>  	mutex_lock(&hive->hive_lock);
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
