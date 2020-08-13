Return-Path: <SRS0=ZeSq=BX=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97FA9C433E1
	for <amd-gfx@archiver.kernel.org>; Thu, 13 Aug 2020 07:55:23 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 65C5620716
	for <amd-gfx@archiver.kernel.org>; Thu, 13 Aug 2020 07:55:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="If7lATmJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 65C5620716
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 160FB6E51C;
	Thu, 13 Aug 2020 07:55:23 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2061.outbound.protection.outlook.com [40.107.220.61])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D3CF06E51C
 for <amd-gfx@lists.freedesktop.org>; Thu, 13 Aug 2020 07:55:21 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AINUs4NGw27+6LjeRThqr5KXtpH0h92XtqhtUXtw0ThS6DhFGUFolwXMZWOOT3PIOu5L1PWyeUL/hugt89jOfqZLX7qKuM/vk3zFr7VioreRu26okY47k5y0HW01wYIOqi47lpuIxT4r8ynIbMVtAUrLKBDSbTvblLASltDRO2M0Mauf5SXy5WcV/bwc9mAqtjzdIOzIe74k0jAQrW4ECW+MPvoPIhVijQcNb56m91XsTH/uiDRzv4eg0kupDx1fvObL0eLc9tcnSDQS2SDEYm8RHSq9rw4J5AdtRIgk7jx9TRD+wzCdgp1WkYc+Z/DYkHBzU9x+XBQp6qTqMjeO3A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AaIOWMGtQLYI725hzcMMbjCGrKPdqVFGjgSds0xDpu0=;
 b=g7ls/+y3LB6lLqucDoReDCIHyPmGQ69HyXj6IHW2gEPmGJdrMuWv1b6JssT+d0fpUMMn7OEVrQykzH+WIOo5Ptm/C8ay27gK2tJgV4/0ACr7K7/oLLqXRpYobDH8g3PtdFwyh4ppqO9WdpCON/qg2xKr1zWOcOGaoz/znEohXzZYLfShzKyoyAHE+VgwtqPuN0Pf0rQ/EyHdvb+SPXSc/3RyBUEwBiqYAAWJ+mjuFP6y3mPMKI2jGrpknEXEJol0JGEmrJ58rzJvO7+Qfvi7DTX/0h3tS2atnOKxLWBLPERsMLdlx1MJ42pif5FDtqT4MVucwapvSRX/0+QJPKs29g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AaIOWMGtQLYI725hzcMMbjCGrKPdqVFGjgSds0xDpu0=;
 b=If7lATmJHjgFXRfe2c3RTEW5hXXmv+vSs8jqsUzcBDLquWgV6HE7OiaqpaTSU9JwrT2AtOfiKzAqdtAm0/Lb3ixtfh+4ZPwW4xLEqDQQ1PqUZVStIg6Ns/RJ/dyhgOKYb7kKcLXVDIHOw4xjoRByCtgdd340wW6BdbodDnmr9CY=
Received: from BYAPR12MB2888.namprd12.prod.outlook.com (2603:10b6:a03:137::24)
 by BYAPR12MB2696.namprd12.prod.outlook.com (2603:10b6:a03:68::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3283.15; Thu, 13 Aug
 2020 07:55:20 +0000
Received: from BYAPR12MB2888.namprd12.prod.outlook.com
 ([fe80::6ce3:37a4:5c5b:c9bf]) by BYAPR12MB2888.namprd12.prod.outlook.com
 ([fe80::6ce3:37a4:5c5b:c9bf%4]) with mapi id 15.20.3283.016; Thu, 13 Aug 2020
 07:55:20 +0000
From: "Zhou1, Tao" <Tao.Zhou1@amd.com>
To: "Chen, Guchun" <Guchun.Chen@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>, "Zhang, Hawking" <Hawking.Zhang@amd.com>,
 "Li, Dennis" <Dennis.Li@amd.com>, "Clements, John" <John.Clements@amd.com>,
 "Deucher, Alexander" <Alexander.Deucher@amd.com>
Subject: RE: [PATCH] drm/amdgpu: guard ras debugfs creation/removal based on
 CONFIG_DEBUG_FS
Thread-Topic: [PATCH] drm/amdgpu: guard ras debugfs creation/removal based on
 CONFIG_DEBUG_FS
Thread-Index: AQHWcT/2YVFWcT4dgEi7F/LB+9xyi6k1q5qw
Date: Thu, 13 Aug 2020 07:55:20 +0000
Message-ID: <BYAPR12MB288825D84B3160FDECC578E0B0430@BYAPR12MB2888.namprd12.prod.outlook.com>
References: <20200813070359.31132-1-guchun.chen@amd.com>
In-Reply-To: <20200813070359.31132-1-guchun.chen@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Enabled=true;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_SetDate=2020-08-13T07:55:09Z; 
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Method=Privileged;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Name=Public_0;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_ActionId=c9e782d8-df81-42e1-85b4-0000a2af47ce;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_ContentBits=1
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_enabled: true
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_setdate: 2020-08-13T07:55:15Z
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_method: Privileged
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_name: Public_0
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_actionid: 2e2f4c1a-cd62-4b1a-baa5-0000795b3d41
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_contentbits: 0
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [58.247.170.242]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 1a54e3f2-2d27-4af3-0988-08d83f5e3a2b
x-ms-traffictypediagnostic: BYAPR12MB2696:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BYAPR12MB2696C292861B37B3F7546146B0430@BYAPR12MB2696.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:883;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: RZsDT5JBiHbKhHXKVwmTuqjjaTWsIgOQeuya8yG+o0EoP6zxtKaKUCjapr3MV1NPGCIqdL7C+O9MV3dcBFT3TLlYtqfDEXOYlE0PYxeu5qEq6jBxAxVkaQ2IWiCNMeBUGTpEl1I62z4XTxqTY1pKyGrjJe4ooiLxkvT3i78Ats0UtfDgPoUvO4aCZXAVPMaYxtar7XVwzlOqhLZ6LjuijWZH0HUqe5lhTvD1XcwqhhrGqztu9Ye5y9fPMARaNuPG+xv4k1Nk0JJaGibRXTqZWB5A67Fr5rCHQCzO2AvCQfXHUWjTJQHRfyiR1Hmj8KlAHB2ZnmRmsQ278dNsPRv1LmxvDpyyPQPtnf/MmO+XaZJWhZ2J4V0wjrHdFzeWu/Sg
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR12MB2888.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(346002)(136003)(376002)(396003)(39860400002)(366004)(6636002)(76116006)(53546011)(186003)(6506007)(71200400001)(2906002)(26005)(33656002)(66946007)(66446008)(66476007)(66556008)(64756008)(86362001)(7696005)(478600001)(52536014)(110136005)(316002)(83380400001)(55016002)(8936002)(9686003)(8676002)(5660300002)(921003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: dqMLlSyCmBHQDbCH1+5MNzGBGjfMBA4/8oi/NTZMob7Hg2M4lDf/85Wa8GiSaocRRzsxMhmeBshj5bC6VpkA+XvD1MISF5xvRcObKPp/VT/1PmH4A8+EEPm+Bvx/Ysgphu0NqD8YK26yDpJ4dD04Q2MzHxyWMlTGr1MPu0chqMJFv+cY0Iti3fZ0K5UMk0wT+N7BEYD2jQqIUMXZAVjz96lqyRlmWMTdhZQdKri0zVazlKzUWfRnSZVFfjkoUA9+9tNQsuDbLbeZ0EWF2uLDT9N6is9Y6Qfi7imLbuf0tAlE+jz44kaPkyWdksrDpsbWcRdEz9T87TvC49asBJb16XBbmcaM/HxcdCsuYmss7lgYTihv/jcE38xKRZ0CJ/Wwo6ryRAkwUs40sOHlWN6yPvAvSBOPBThZk1esVAMXiHpxJBje7f1YwpeEgP8WdEBby8UG6SvFJVG/xLkbzXufvUsg7QoDHhrOgo+XpSbWLnli9U82kSr82iLhLUQ0UGFNMF+ZZe63AB6RaoZNIosc/1Z/ySxYB7xjqfEID6fdO60iRxKjgCh6wLigGuSM21t+T239ylOijaUcuwmgtgo38Z26Ra4+jEja04RTINrQX1GEkOBWF4PIln+UTxb1Zofxvp4VA2alZYCP60Ichb5ykw==
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB2888.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1a54e3f2-2d27-4af3-0988-08d83f5e3a2b
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Aug 2020 07:55:20.5811 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: OY4sqjo0BOxroiUCaITvUt9R+qzK17O7g6IrgGWMpOpZSraTjETCYeruibz3Rqy1
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB2696
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

[AMD Public Use]

Reviewed-by: Tao Zhou <tao.zhou1@amd.com>

> -----Original Message-----
> From: Chen, Guchun <Guchun.Chen@amd.com>
> Sent: Thursday, August 13, 2020 3:04 PM
> To: amd-gfx@lists.freedesktop.org; Zhang, Hawking
> <Hawking.Zhang@amd.com>; Li, Dennis <Dennis.Li@amd.com>; Zhou1, Tao
> <Tao.Zhou1@amd.com>; Clements, John <John.Clements@amd.com>; Deucher,
> Alexander <Alexander.Deucher@amd.com>
> Cc: Chen, Guchun <Guchun.Chen@amd.com>
> Subject: [PATCH] drm/amdgpu: guard ras debugfs creation/removal based on
> CONFIG_DEBUG_FS
> 
> It can avoid potential build warn/error when CONFIG_DEBUG_FS is not set.
> 
> Signed-off-by: Guchun Chen <guchun.chen@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
> index 35d5bf9e6f6f..e1d78cb448e2 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
> @@ -1244,6 +1244,7 @@ void amdgpu_ras_debugfs_create(struct
> amdgpu_device *adev,
> 
>  void amdgpu_ras_debugfs_create_all(struct amdgpu_device *adev)  {
> +#if defined(CONFIG_DEBUG_FS)
>  	struct amdgpu_ras *con = amdgpu_ras_get_context(adev);
>  	struct ras_manager *obj;
>  	struct ras_fs_if fs_info;
> @@ -1266,6 +1267,7 @@ void amdgpu_ras_debugfs_create_all(struct
> amdgpu_device *adev)
>  			amdgpu_ras_debugfs_create(adev, &fs_info);
>  		}
>  	}
> +#endif
>  }
> 
>  void amdgpu_ras_debugfs_remove(struct amdgpu_device *adev, @@ -1282,6
> +1284,7 @@ void amdgpu_ras_debugfs_remove(struct amdgpu_device *adev,
> 
>  static void amdgpu_ras_debugfs_remove_all(struct amdgpu_device *adev)  {
> +#if defined(CONFIG_DEBUG_FS)
>  	struct amdgpu_ras *con = amdgpu_ras_get_context(adev);
>  	struct ras_manager *obj, *tmp;
> 
> @@ -1290,6 +1293,7 @@ static void amdgpu_ras_debugfs_remove_all(struct
> amdgpu_device *adev)
>  	}
> 
>  	con->dir = NULL;
> +#endif
>  }
>  /* debugfs end */
> 
> --
> 2.17.1
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
