Return-Path: <SRS0=CyhX=B4=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 836D4C433DF
	for <amd-gfx@archiver.kernel.org>; Tue, 18 Aug 2020 02:26:58 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1CCB7206DA
	for <amd-gfx@archiver.kernel.org>; Tue, 18 Aug 2020 02:26:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="cVzJP15O"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1CCB7206DA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BBDB989A35;
	Tue, 18 Aug 2020 02:26:57 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2049.outbound.protection.outlook.com [40.107.237.49])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2C94A89A35
 for <amd-gfx@lists.freedesktop.org>; Tue, 18 Aug 2020 02:26:55 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=K2F8doU//GB0OU0Mad5akjn30qpQjr02ja5YnGjGjShDheN1ZZ528Rdgh4bHWP4FffPQD0if7wtWTQzDJll9Qp65ffv9MH1ts3AHW9kLAQVvPhaVnBR5NzgVAGZB97+L8uEDnlVxr+WhtNI4uOzh5OKfzkPo22NRPRIarlXafpcwq2ejRjmoZSUQklfVoAsS6mBe3CkEdIuX8RNcAFrBa7eslU5f88987ByNxqtJrvmzoMaSzHSewjINadjhnaI7i729KZHqtwgPCNl2TOTpcg66R7WXLYKsiVo9mzsCr7bU3P34S4XJXsOhpQTyTk03+25tlyQAAP58Khin8yH4Xg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oow4Fuw7sA0EqyttIifEOhJ3ItLvGG9AupFOZxHcBQc=;
 b=Zu9Sb4oIswKkkTiCqX3TVM4UsI16Do4tIDmMGb/qRM3Ygty8bJ42T8VUaAdtV+is4/FQ7eI0G0/UK6ZIfsh2s1zsOFyhsOWYe8GqvLgBrHVSrZ/pklCmxLg0W35TUbzb0ucAajZF6oEVGirsy7J7PWKGONCw1iQW9xfsxjkUMbPCrvckc5BEEEGPlZaHrAIbvLciffWtUNr5UyUw0/VP7U5dYHqmMx1xJ9GIfyTd1CeBuMZM0dZd5DH8IMnuUdWQawkE7Z7jeTcn/vKsp3x+bR/C0GLVfa+zUQXWZhgdXqabmwFM8QviCCGCymIXURKDVb4ZIcrMqccYs/LdJXzVWA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oow4Fuw7sA0EqyttIifEOhJ3ItLvGG9AupFOZxHcBQc=;
 b=cVzJP15Ofp1dNskTcFa8JgcM7UiHugCO5h8+BZfjrB4JQOGGp8Uk7emyYp6deA2sNxq5LVAxnn9h1G32dxpT/nvNnySQbSG3Uk9Pd1taHRHkvgQbmcGm99tsJGrT78hsi0kX1ngP8+MVym2fRkn99WglJ6LpyMkDF/JshbNag2A=
Received: from BYAPR12MB2888.namprd12.prod.outlook.com (2603:10b6:a03:137::24)
 by BYAPR12MB3494.namprd12.prod.outlook.com (2603:10b6:a03:ad::28)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3283.16; Tue, 18 Aug
 2020 02:26:53 +0000
Received: from BYAPR12MB2888.namprd12.prod.outlook.com
 ([fe80::6ce3:37a4:5c5b:c9bf]) by BYAPR12MB2888.namprd12.prod.outlook.com
 ([fe80::6ce3:37a4:5c5b:c9bf%4]) with mapi id 15.20.3283.028; Tue, 18 Aug 2020
 02:26:53 +0000
From: "Zhou1, Tao" <Tao.Zhou1@amd.com>
To: "Chen, Jiansong (Simon)" <Jiansong.Chen@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] Revert "drm/amdgpu: disable gfxoff for navy_flounder"
Thread-Topic: [PATCH] Revert "drm/amdgpu: disable gfxoff for navy_flounder"
Thread-Index: AQHWdKUgp6rnB9nvzkCaHiCEPXXuw6k9JKpw
Date: Tue, 18 Aug 2020 02:26:52 +0000
Message-ID: <BYAPR12MB2888499F5B458D0D881A9E27B05C0@BYAPR12MB2888.namprd12.prod.outlook.com>
References: <20200817144549.16407-1-Jiansong.Chen@amd.com>
In-Reply-To: <20200817144549.16407-1-Jiansong.Chen@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Enabled=true;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_SetDate=2020-08-18T02:26:43Z; 
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Method=Privileged;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Name=Public_0;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_ActionId=b2ec91f9-ec6a-494a-9c49-00004cb2e1c1;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_ContentBits=1
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_enabled: true
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_setdate: 2020-08-18T02:26:37Z
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_method: Standard
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_name: Internal Use Only -
 Unrestricted
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_actionid: a406de6a-fe08-4129-a654-00000756d73b
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_contentbits: 0
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_enabled: true
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_setdate: 2020-08-18T02:26:47Z
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_method: Privileged
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_name: Public_0
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_actionid: 0f50fa21-7762-4915-9899-0000c15592d6
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_contentbits: 0
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [58.247.170.242]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 135dfa16-d6be-447b-e28b-08d8431e2b86
x-ms-traffictypediagnostic: BYAPR12MB3494:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BYAPR12MB34948F7D31CD3721F24E650FB05C0@BYAPR12MB3494.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:345;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 7DsBBmZ/HEOZmHdbb9mTXNbFvbaaKvuUhD2baNCoVQVYgKei6nOwUSMHxAi/qd6NRnFa0khDi4aExC1SEeVwhnquNu3TqPYw69pJZuNzym/Am+7JOei5MdR6FOzgkxmVduHQ4WkttNSTr/c69WHYrjw8JDF3DBe268xm9Lvgssv3PqTnjiCfd1VVlhLFtzSzOTmnEr3rBKEILkR31vIFWYOSxBYopyPnyg2NeniYaGgwmo9h3YviKP0xreGUuP7pFRffniApQ/z123HNK2/aLKt86AHYLCpltAl6MZDcArNvDTa1ha4rBK2+62nWt+a7OjLsTjVAoIQyq4CF2udPxQ==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR12MB2888.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(39860400002)(346002)(366004)(376002)(136003)(396003)(66946007)(76116006)(54906003)(86362001)(66556008)(6506007)(316002)(52536014)(478600001)(33656002)(110136005)(71200400001)(8936002)(2906002)(66446008)(66476007)(83380400001)(7696005)(9686003)(64756008)(5660300002)(53546011)(4326008)(55016002)(8676002)(186003)(26005);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: a/XX5wPxJqd1/GRP/mD94VmtagC49txatXK+vzaVn35ajEDVvsdE4IPfks83azKatbxZNGkwG5qjfZuddefzaBaA9pXXHx+Bob6AZVLvPF2H/mzc7jzO97awVPgDMmr4MsOKQ4roXChEwtwZ+ReUwtqkWo6Q+VQnTkdHTPSVuZ6VlpP3Z1r7K//G+gPq3ZFU5rkGM0BUB0QgR45sqEyEnntZ6ZiyuWvO5SPReCQivNNYE3VPxrQ50OVI7nyQZ4UQiBfgCOLAppX0tyyIhij6S8phIHehqrpFg0ibVTjF+Mx+x/Rhr3lTaoF8rpVcLOoixbjiNQqJ8SfGv0CK80ebOYMG6y+8yincC2+d/gJ+fP07FsyIfGwYq2JO+I64w57h3+EbMpW4GsdS43E+gQvkCbP4xkFhvYAWm7sHumKb4cpeQkfFOSX4clSgM0juW4O26mIuVQL+iIinfN153hmuduSh2tjGvSWqGHy+M0GW9UGfF6rh9emBw8zHp5l9Yin41rr3yhO2fHvy1p7W39rnH/jUJWkK+y3cHvYwFJRhZnLLsF4h3BEDpoYNGE7Rl74TpgDswZmdIPTkU1Omyj2tfp7ENtw6UD3XYzQOl+8ZATynVlTzUv2iH/IxqkJxY27n+iyu+naaht9u6+YuqbOmTQ==
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB2888.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 135dfa16-d6be-447b-e28b-08d8431e2b86
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Aug 2020 02:26:52.8916 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 26teXISb2iKRhLoNCrdH5fbf81z9od97UIUOVDS2wrQaib5v/0vagdqtezPzRVPN
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB3494
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
Cc: "Feng, Kenneth" <Kenneth.Feng@amd.com>, "Chen,
 Jiansong \(Simon\)" <Jiansong.Chen@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Public Use]

Reviewed-by: Tao Zhou <tao.zhou1@amd.com>

> -----Original Message-----
> From: Jiansong Chen <Jiansong.Chen@amd.com>
> Sent: Monday, August 17, 2020 10:46 PM
> To: amd-gfx@lists.freedesktop.org
> Cc: Zhou1, Tao <Tao.Zhou1@amd.com>; Feng, Kenneth
> <Kenneth.Feng@amd.com>; Chen, Jiansong (Simon) <Jiansong.Chen@amd.com>
> Subject: [PATCH] Revert "drm/amdgpu: disable gfxoff for navy_flounder"
> 
> This reverts commit 6a72ad7e387c6fec821c230fda3460f79fc0f877.
> Newly released sdma fw (51.52) provides a fix for the issue.
> ---
>  drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c | 3 ---
>  1 file changed, 3 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
> b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
> index e87d43537013..e527be22a3d5 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
> @@ -3610,9 +3610,6 @@ static void gfx_v10_0_check_gfxoff_flag(struct
> amdgpu_device *adev)
>  		if (!gfx_v10_0_navi10_gfxoff_should_enable(adev))
>  			adev->pm.pp_feature &= ~PP_GFXOFF_MASK;
>  		break;
> -	case CHIP_NAVY_FLOUNDER:
> -		adev->pm.pp_feature &= ~PP_GFXOFF_MASK;
> -		break;
>  	default:
>  		break;
>  	}
> --
> 2.25.1
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
