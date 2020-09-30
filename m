Return-Path: <SRS0=9SYE=DH=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B7ADC2D0A8
	for <amd-gfx@archiver.kernel.org>; Wed, 30 Sep 2020 07:54:26 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 32CF42075F
	for <amd-gfx@archiver.kernel.org>; Wed, 30 Sep 2020 07:54:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="ehLmxgSj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 32CF42075F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D2611899B0;
	Wed, 30 Sep 2020 07:54:25 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2077.outbound.protection.outlook.com [40.107.94.77])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0CE74899B0
 for <amd-gfx@lists.freedesktop.org>; Wed, 30 Sep 2020 07:54:25 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ej8WGRo50tfdu8EvWKxq0lxegPpIhWnl8lRe1+ecjw6Qeo6dec4IcbmLBmJoXChyqfbhxC2/22fjhvsHCEb7bCSQRIHHf/DZ6FUFY8xzkrKcYdh0hM9ZwuXtXMdfLkyLoaJhDmyq1fqeQ+OQ82+lduRiwZCeuaBHk0lgfRttQRyz02TEK55voUbxjTbR0bGSXjeGBgZEAfSuMaicGx6konqoyGHztD2acDC2iGV99YMADVin9ib0wo+pn8UB5IC8FqX+byJ6H0R+JLOcwORqxonL0+kZNZMKspY2aqn81n39l0erXvwA9T9wvxX8tulAjQHEV3LtyWH1+xmzu39+yg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hA1cUTzBmM9ShnCDAXmbgs+oxzwUmbZeYmeWm6DMUAE=;
 b=TQGjKEPQryV8YOitlX3ZHQXKh2RpoWiL2yq+buulEshP2++2KuIalncyXKP3TZdF8Fc8bos+i7LaKntwSmXkN/LH2ROfhIQlOhakbx4+ApUE0B6qkH2nqhYOX1Xd3g/gMJ9NiI7RXEKzKJSLpOOIdhw3qjNd7ymimEH7pRpyX/hMZ+mpGhLtHJdyzJT4a9ZBCyp7AYnZzBjugTKk4oUB50da2WJS922owZ9V820aIBhk+VOK7t69NM+DMrKT8utTgEvcGWvUmmmF2CxzF+BNDWg/10g6Y9jOv+MnLgysXwShJTu1boXhmQzTFh7ojtIp7XGfR9SwtikQfx097+ftww==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hA1cUTzBmM9ShnCDAXmbgs+oxzwUmbZeYmeWm6DMUAE=;
 b=ehLmxgSj7jv5NHXwcy59/qb8mKVhbm3BOyNZNCTpjHadMguvUPw6d+g+xkgkyz6v6AIjnvGcMb1n9Sdgorr9Ak+UoU2jJgYfeFpuVV6qZKRXLKr26+O9ue7H7ohXn39td9Pj1h79NZKG6CJwn7VCGav1HvRwFnlEZa4UymeI2AU=
Received: from BYAPR12MB2888.namprd12.prod.outlook.com (2603:10b6:a03:137::24)
 by BY5PR12MB4243.namprd12.prod.outlook.com (2603:10b6:a03:20f::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3433.34; Wed, 30 Sep
 2020 07:54:20 +0000
Received: from BYAPR12MB2888.namprd12.prod.outlook.com
 ([fe80::6ce3:37a4:5c5b:c9bf]) by BYAPR12MB2888.namprd12.prod.outlook.com
 ([fe80::6ce3:37a4:5c5b:c9bf%4]) with mapi id 15.20.3412.029; Wed, 30 Sep 2020
 07:54:20 +0000
From: "Zhou1, Tao" <Tao.Zhou1@amd.com>
To: "Chen, Jiansong (Simon)" <Jiansong.Chen@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amdgpu: disable gfxoff temporarily for navy_flounder
Thread-Topic: [PATCH] drm/amdgpu: disable gfxoff temporarily for navy_flounder
Thread-Index: AQHWlvx51geTgFR/T0ugOrzoC/ljgKmAz46A
Date: Wed, 30 Sep 2020 07:54:20 +0000
Message-ID: <BYAPR12MB288862BD6DDADC5D52C341E6B0330@BYAPR12MB2888.namprd12.prod.outlook.com>
References: <20200930073642.7438-1-Jiansong.Chen@amd.com>
In-Reply-To: <20200930073642.7438-1-Jiansong.Chen@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Enabled=true;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_SetDate=2020-09-30T07:54:08Z; 
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Method=Privileged;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Name=Public_0;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_ActionId=386388ea-b343-4b44-ac26-000055585d59;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_ContentBits=1
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_enabled: true
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_setdate: 2020-09-30T07:54:03Z
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_method: Standard
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_name: Internal Use Only -
 Unrestricted
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_actionid: 8ec95cdf-4143-42ce-a391-0000421794fb
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_contentbits: 0
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_enabled: true
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_setdate: 2020-09-30T07:54:10Z
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_method: Privileged
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_name: Public_0
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_actionid: 9ba16d6c-3dc6-44ef-9014-0000ba71cc61
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_contentbits: 0
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [180.169.125.178]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 9950357c-63e1-41a1-ca9d-08d8651609f8
x-ms-traffictypediagnostic: BY5PR12MB4243:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BY5PR12MB4243543FF74002773A6EB492B0330@BY5PR12MB4243.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:4303;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: qwbNuUMwaQ30GPmN+6YaL+4ym93iCFdDR/JRwKjXZOJ4H9HCUnmhhz9siFrxr883YqFnvDrOrwV0+zCiJdls98Fxizvh82Z3/zM0ruzC4GKd2igwvkRdCSNRQndSuQjOtcf1YX091zzQfSbb2L2HI45daHIuRQAR1mq/N/XgXWm0WRKdq22X2zRTwIBGZkKFRq2IVhKP6yeIf4m5g2HNYbbbgpdt2OjuzF6APRWyfOVCqdKzEmTUH+6xhQ9zaHWTJEUaXiyDEQnWfiSqlNkE0TAKThrKR11jZmoVfQEzvF2+4F4+bHVxzLElDyVTKpzPnc5SbGCF1ee0xkH2WPxyUg==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR12MB2888.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(396003)(39860400002)(136003)(346002)(366004)(376002)(54906003)(110136005)(33656002)(316002)(8936002)(26005)(186003)(83380400001)(9686003)(52536014)(8676002)(55016002)(2906002)(4326008)(66446008)(64756008)(7696005)(66556008)(76116006)(66946007)(66476007)(478600001)(6506007)(53546011)(86362001)(71200400001)(5660300002);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: JSf0rOf9dLqlkJIK/TBQbrv/W3mykZm8hX60xTxdMiNN+FZv75tXlM/CxctiqK5bfnP9Y3oA2B997z1oMf4lhGjuA4PWgagtrvksIYI8ufykY5qvf/4ut6Bu48OIg+nxqqgXOD3UUd1oBYuyG5nR6JxpUO453PFJQ4Fz4prWckrFbHWL4zh30h8BSqArwQACM/gm/Dv57BwLZgDl5DLhWKviZ0pd9Va9dl9O4DzU9nmsGV7PXVierMzeiVw3mRB+wLejlyZ38pedkREHFk8UGvbeeXVKllcQOISgAhzSFjTdAwci+023jGO/HejS75HkHjpp/4lUGl3C43E5QQfkbBS6NA6q/uKU6+AUhhgbfeg/rdPiD/+uCIOUbIjbBmd09QfOOX36yg/M2wxwScoEKO5pZKQLt9gdhDnT3PsYgdNcMqie+EAUnT0rlonD6bkAhDPGrcIq/LCOsCG7/MKdkX+6z3APOaJy03R1b2BtYmiMlscPilwCdyTmTAfTr82AqNV4SBzSoN0EfJLsWG4K/mb2ERkTj4G+ZjYedqtMVX7Xa7RXbxaLHt22emN+xRGA/OS2hLkBtahQ+cOIavf2oPHdg6Peozz4viXHOPVDP/85po04lHKoOMykRuyqatb1vJn/ysDwSWM2AzgmCwmYfg==
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB2888.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9950357c-63e1-41a1-ca9d-08d8651609f8
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Sep 2020 07:54:20.2671 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: otcnBc/+y53/iCcNS1OK9ODUNEyI44Q0G24I0gMxQfQ1DH1l4QerWrIOd+QXaj9z
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4243
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
Cc: "Chen, Jiansong \(Simon\)" <Jiansong.Chen@amd.com>, "Zhang,
 Hawking" <Hawking.Zhang@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Public Use]

Reviewed-by: Tao Zhou <tao.zhou1@amd.com>

> -----Original Message-----
> From: Jiansong Chen <Jiansong.Chen@amd.com>
> Sent: Wednesday, September 30, 2020 3:37 PM
> To: amd-gfx@lists.freedesktop.org
> Cc: Zhou1, Tao <Tao.Zhou1@amd.com>; Zhang, Hawking
> <Hawking.Zhang@amd.com>; Chen, Jiansong (Simon)
> <Jiansong.Chen@amd.com>
> Subject: [PATCH] drm/amdgpu: disable gfxoff temporarily for navy_flounder
> 
> gfxoff is temporarily disabled for navy_flounder, since at present the feature
> caused some tdr when performing display operation.
> 
> Signed-off-by: Jiansong Chen <Jiansong.Chen@amd.com>
> Change-Id: Ib2be4041f82a3f5e12c657541c516815c8eb3670
> ---
>  drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
> b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
> index 17fb2efdadd3..9792ec737029 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
> @@ -3610,6 +3610,9 @@ static void gfx_v10_0_check_gfxoff_flag(struct
> amdgpu_device *adev)
>  		if (!gfx_v10_0_navi10_gfxoff_should_enable(adev))
>  			adev->pm.pp_feature &= ~PP_GFXOFF_MASK;
>  		break;
> +	case CHIP_NAVY_FLOUNDER:
> +		adev->pm.pp_feature &= ~PP_GFXOFF_MASK;
> +		break;
>  	default:
>  		break;
>  	}
> --
> 2.25.1
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
