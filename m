Return-Path: <SRS0=Q5HU=6B=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8245EC2BA2B
	for <amd-gfx@archiver.kernel.org>; Fri, 17 Apr 2020 03:00:22 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 515FE21D94
	for <amd-gfx@archiver.kernel.org>; Fri, 17 Apr 2020 03:00:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="bLSVIzIr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 515FE21D94
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0376E6E0EB;
	Fri, 17 Apr 2020 03:00:22 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2058.outbound.protection.outlook.com [40.107.243.58])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0264C6E0EB
 for <amd-gfx@lists.freedesktop.org>; Fri, 17 Apr 2020 03:00:19 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LGaxhqp0kbDg+ROdyU32Bg/fWaguFDfOIxy9/ukfUfk0+Zar7BVCKzDolq/PUCnoL+2gaZT5EHD1ndZBiu86cjaTIzuXxiLvsx4unVBJxhXxqjqrqdTawOYpkTDojVwmdIod23KrdSqaeI1BoJDnFta7tJevLYig+CqlDj/HDtyqPEzuj5VruzWUx+KmU5/P+V16HZDyaD6bBKXSchLGvP7Rknb93OuLMigKfYcT6UwcUiCAaaT/hMNXE4beDR2AlFSjF9bnEdwpqbC4wz4kNXwhFr/QHqiXM5W7KJC3oXj/nkBHoa+nM/Q4X56nSXqTKcnukSSDfOq8RQb0nu6bdA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0Ex7WsX/M7lpSyZxrtlWu/37qSfeNk7nM0C7zsnJzCM=;
 b=ik1G0nGKloNpcpzYm/n6zQRtJCRX6hl7pM3/m07uH3uuUr6F3LKl/6gUzTQUPFHbuB5MjqRg6b3Tz+3dU2AxI0GOOijP1qpfJ5lQFjTpZ3iaQtSszd8LWK9SFDGpTW0qS8dVJCzrprLmsfz0vZgqSmgsR1Darqe3iCIvc6x0muzblzvFRaMvmdLcegQkaCg1CRxi0HHsJaesh0RcLtT/87NweSnhUQ2yX7FL8XxOrwrUkPa6psKPYfusLKp0q0sG1sUkyOaC/6kq+rpj4kzep4ldeHS+AB+W4rmEqqwhYf6+qf8a3Ew3fN8h1YKqwvdOamIpbQpRPgx5pr2xO9iJmw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0Ex7WsX/M7lpSyZxrtlWu/37qSfeNk7nM0C7zsnJzCM=;
 b=bLSVIzIrU8ksm3bAS+xW+F88s1FPVrws4Op2H0ummS7dOB/jZaozmTdTnp+OG4c+OQ+BK5Lp7yobqnEdVwCoJhGRpRIFGywMlI/G/fddi9BUU5Hy5whRlpJgWwjdLXKMVWwKSoIkfOBkmLsmG1lOs0+oKDMUkLbTeWg/ANjmT5I=
Received: from CH2PR12MB4071.namprd12.prod.outlook.com (2603:10b6:610:7b::16)
 by CH2PR12MB3928.namprd12.prod.outlook.com (2603:10b6:610:23::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2921.27; Fri, 17 Apr
 2020 03:00:15 +0000
Received: from CH2PR12MB4071.namprd12.prod.outlook.com
 ([fe80::e0d5:7f32:3fb6:a7e]) by CH2PR12MB4071.namprd12.prod.outlook.com
 ([fe80::e0d5:7f32:3fb6:a7e%9]) with mapi id 15.20.2900.028; Fri, 17 Apr 2020
 03:00:15 +0000
From: "Dai, Yuxian (David)" <Yuxian.Dai@amd.com>
To: "Huang, Ray" <Ray.Huang@amd.com>
Subject: RE: [PATCH] drm/amdgpu/powerplay:avoid to show invalid DPM table info
Thread-Topic: [PATCH] drm/amdgpu/powerplay:avoid to show invalid DPM table info
Thread-Index: AQHWExfy6OCxEmhrJE+E7S52BhHdP6h8nnoAgAADyYA=
Date: Fri, 17 Apr 2020 03:00:15 +0000
Message-ID: <CH2PR12MB4071DBF06D49C816707EAEA68DD90@CH2PR12MB4071.namprd12.prod.outlook.com>
References: <20200415112031.9950-1-Yuxian.Dai@amd.com>
 <20200417024601.GB25917@jenkins-Celadon-RN>
In-Reply-To: <20200417024601.GB25917@jenkins-Celadon-RN>
Accept-Language: en-AS, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Enabled=true;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SetDate=2020-04-17T03:00:12Z; 
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Method=Standard;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Name=Internal Use Only -
 Unrestricted;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ActionId=37a38f18-9fed-404d-a380-0000b51eee82;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ContentBits=1
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_enabled: true
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_setdate: 2020-04-17T03:00:12Z
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_method: Standard
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_name: Internal Use Only -
 Unrestricted
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_actionid: 6ce45dcb-d771-4198-99aa-0000d0b10867
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_contentbits: 0
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Yuxian.Dai@amd.com; 
x-originating-ip: [180.167.199.189]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 5c8c78a9-e037-4d71-1fae-08d7e27b7437
x-ms-traffictypediagnostic: CH2PR12MB3928:|CH2PR12MB3928:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <CH2PR12MB3928CB6E900567391CE0EB7A8DD90@CH2PR12MB3928.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:105;
x-forefront-prvs: 0376ECF4DD
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH2PR12MB4071.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(10009020)(4636009)(376002)(346002)(39860400002)(396003)(136003)(366004)(316002)(966005)(478600001)(66556008)(64756008)(86362001)(66946007)(76116006)(66446008)(6862004)(52536014)(4326008)(66476007)(33656002)(71200400001)(45080400002)(6636002)(83080400001)(9686003)(81156014)(8676002)(2906002)(186003)(7696005)(5660300002)(6506007)(55016002)(8936002)(26005);
 DIR:OUT; SFP:1101; 
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: dGAHPIBlQEu0QCeo3DL5koUAisUF4wbxdE+AKI2krkpWWV4xgOFpCa6u2SIWbcUo58UxSP+5mTScyuYUDA6sQgMyWB9t407i04vDTGpdsutgiJJLBouVVJHFiOF4yd653XClgOzTtiZ0c6X1H+zj5ZH2BIY9Y1gVNZ8mbuIlu28DMs+hCakrVWKQXWRmtP7Qb/kQFpEEsKY2l6LVryKbQq008zmT6usDY2DWQeGGNkllZfHjXpk7g2qNEJ+4Jk6yj+3DYDi+HAJa2LxJKDXdAePnbE/2LgToHZT1x8PlE5d5iyhE3U+bCXBln49Yq1Lii+TFwFVOHz5uuYtLSb+r6+muQ5U/74HwkNr3kMsHQLw06rGuOPxF5RgcA4WqSBfgEnIjBUKCvMPViBy+4Slow6asngufxiOShKr4fTP+mG75d8W+yT62LTer0zdA9odt4CSJ/cBontJWcc/FfS9+4JbSNiYhen0BZJ0/os942JXvgSCsh1F5BlIrFdaCFX5qHM+7pNr7u8lUuPfvZFVVUA==
x-ms-exchange-antispam-messagedata: /XKLb3hCuruwYmRtW7y8+P0gfwrv4b9TjafFbIQK7zCk0tKntec7URUNYyYnQYkCEUKgWwQdNsJ2L03T4Cc09sYjO/Sbzyd0Sc3XAwJRP5ucNMdEwCTx0VSxFhormjJaZzaEo2ArsvwBr+DKYwsoNQ==
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5c8c78a9-e037-4d71-1fae-08d7e27b7437
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Apr 2020 03:00:15.2618 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: DOxfhICst1yKrV3tKE1Gn9Fy5f0LE+x+GQOitJIAkTHj+2/dRQrKvzwRfBgLHlvPa7GlX/4UQ20T33vFBR2Tbw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB3928
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

On Wed, Apr 15, 2020 at 07:20:31PM +0800, Yuxian Dai wrote:
> we should avoid to show the invalid level value when the DPM_LEVELS 
> supported number changed
> 
> Signed-off-by: Yuxian Dai <Yuxian.Dai@amd.com>
> Change-Id: Ib66d0cf34a866fa6f0cedd1d5fc642f59236787d

Please add comment in the commit message to explain some asic only have 2 level, and cause the invalid level as 0.

With that fixed, patch is
>ok

Reviewed-by: Huang Rui <ray.huang@amd.com>

> ---
>  drivers/gpu/drm/amd/powerplay/renoir_ppt.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/gpu/drm/amd/powerplay/renoir_ppt.c 
> b/drivers/gpu/drm/amd/powerplay/renoir_ppt.c
> index 281b7b6cf1a4..e4e7a352d032 100644
> --- a/drivers/gpu/drm/amd/powerplay/renoir_ppt.c
> +++ b/drivers/gpu/drm/amd/powerplay/renoir_ppt.c
> @@ -296,6 +296,8 @@ static int renoir_print_clk_levels(struct 
> smu_context *smu,
>  
>  	for (i = 0; i < count; i++) {
>  		GET_DPM_CUR_FREQ(clk_table, clk_type, i, value);
> +		if (!value)
> +			continue;
>  		size += sprintf(buf + size, "%d: %uMhz %s\n", i, value,
>  				cur_value == value ? "*" : "");
>  		if (cur_value == value)
> --
> 2.17.1
> 
> _______________________________________________
> amd-gfx mailing list
> amd-gfx@lists.freedesktop.org
> https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Flist
> s.freedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;data=02%7C01%7Cra
> y.huang%40amd.com%7C4858c507c09943274af508d7e12f15a1%7C3dd8961fe4884e6
> 08e11a82d994e183d%7C0%7C0%7C637225464660212899&amp;sdata=eNcYS0dWUHPpQ
> QXPHD6M5%2BqRI8dj1OC2auB0ZQB9Rgs%3D&amp;reserved=0
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
