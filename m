Return-Path: <SRS0=u9ZA=5T=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 039A5C43331
	for <amd-gfx@archiver.kernel.org>; Fri,  3 Apr 2020 07:59:06 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C609B2073B
	for <amd-gfx@archiver.kernel.org>; Fri,  3 Apr 2020 07:59:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="RujRK4Aw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C609B2073B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6C2D46EB1C;
	Fri,  3 Apr 2020 07:59:05 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2074.outbound.protection.outlook.com [40.107.220.74])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D9DAD6EB1C
 for <amd-gfx@lists.freedesktop.org>; Fri,  3 Apr 2020 07:59:03 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=O8O2TaMUlMrTSmrnKwTyICrjn2kPOmnw5x668TPXnCcno5/55XYtYLpmuiOfDuoQY1/oYPHDLgpm9GTTEqJ0BzmgmKjft6IAdrCIJ+JNTmXEZTNVoagMsE7IXMtUGD0KICj8gSYgAs3cih9KCfpLesb62WBH8G1sTTdia6Y6IC0ulTIRVzZINq5qkdvFY7Lf0YQ7Lk2X9DUrTZFktG16QGWfskZePX2PWe45vgbwtvwr2+q6UEXj/fSgsXlB3/JcTF6Bk5V0gyzUQCp3sk+HftTGShLa0i5lddmsY6UZJl5TDUhouAcbS3BMax0Z/4yTEJl7TzfLgpGBlG0KwNcYvg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MsDDtN8sh8/Mt1Kkc04pV5iJkWqAF6mWIoj8ctmSIzA=;
 b=NpKnESz9piefr3wWpw5hNkdKXWoLeR4O8Jl7b6UKJv0WCBg9p6j1VjJsGGyhrDWZ5vRjz6Rio8FlAzn0jKjiWb4NufSllbhJQliXzrseR57ejuhfm8mzpFlV8L2uWIWjA85NJNX1mZaPJi87IA/MVS3vmEC+NqsQ51B2sM94T+cQ9H43Ixx70zMkit0uhqe+HzYzQLA3afCKfvnqZzmcGWdF6E9/1QRraHJywVEBHQ5UDg6ggzJmiQlismhU9/VdU6f+MMJKP59VcZTZYAm/hUGmnJ74Sia2/uqXI19vF1sJs6pHZCDh+QNhCy03xSU6xrUvS6PSPvjt6yJf5DD8Ag==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MsDDtN8sh8/Mt1Kkc04pV5iJkWqAF6mWIoj8ctmSIzA=;
 b=RujRK4Awy718hwMhQSSfV/zgAgzUrvfqUWGani2nwGzYnLqQSF6LrcYhv/4b+5r+JaBrIYxOKFxnrwNAm803A04VO5FN5eTOCaFZHxz1Wyin8YPjuTW2S6wvTjXzU6xmO+sjEiV4HD8XfAbiUTmcSKKl8+mqju2Bijtyn1RReVI=
Received: from BY5PR12MB4115.namprd12.prod.outlook.com (2603:10b6:a03:20f::20)
 by BY5PR12MB3985.namprd12.prod.outlook.com (2603:10b6:a03:196::32)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2878.16; Fri, 3 Apr
 2020 07:59:02 +0000
Received: from BY5PR12MB4115.namprd12.prod.outlook.com
 ([fe80::405b:93fe:202d:123b]) by BY5PR12MB4115.namprd12.prod.outlook.com
 ([fe80::405b:93fe:202d:123b%4]) with mapi id 15.20.2878.016; Fri, 3 Apr 2020
 07:59:02 +0000
From: "Deng, Emily" <Emily.Deng@amd.com>
To: "Zhou, Tiecheng" <Tiecheng.Zhou@amd.com>, "Zhou, Tiecheng"
 <Tiecheng.Zhou@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amd/powerplay: avoid using pm_en before it is
 initialized
Thread-Topic: [PATCH] drm/amd/powerplay: avoid using pm_en before it is
 initialized
Thread-Index: AQHWCNE+hTzuefFabE+InlbYjviFN6hm0tCAgAA27AA=
Date: Fri, 3 Apr 2020 07:59:02 +0000
Message-ID: <BY5PR12MB4115D4E1FFA9C90D109A9E508FC70@BY5PR12MB4115.namprd12.prod.outlook.com>
References: <20200402092833.30558-1-Tiecheng.Zhou@amd.com>
 <MN2PR12MB377583766525C1130B8FD895E4C70@MN2PR12MB3775.namprd12.prod.outlook.com>
In-Reply-To: <MN2PR12MB377583766525C1130B8FD895E4C70@MN2PR12MB3775.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Enabled=true;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SetDate=2020-04-03T04:42:01Z; 
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Method=Standard;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Name=Internal Use Only -
 Unrestricted;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ActionId=36746590-739e-4baa-b77f-00001b8b7407;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ContentBits=1
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_enabled: true
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_setdate: 2020-04-03T07:58:59Z
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_method: Standard
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_name: Internal Use Only -
 Unrestricted
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_actionid: 58830a10-ffaf-4408-8361-00006abefe01
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_contentbits: 0
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Emily.Deng@amd.com; 
x-originating-ip: [180.167.199.189]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 95567af9-f260-4f32-2ead-08d7d7a4dfaf
x-ms-traffictypediagnostic: BY5PR12MB3985:|BY5PR12MB3985:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BY5PR12MB398521481B090FDD24176C078FC70@BY5PR12MB3985.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:5516;
x-forefront-prvs: 0362BF9FDB
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BY5PR12MB4115.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(10009020)(4636009)(346002)(39860400002)(376002)(366004)(396003)(136003)(8676002)(2906002)(5660300002)(110136005)(9686003)(81166006)(26005)(81156014)(478600001)(186003)(52536014)(45080400002)(86362001)(33656002)(8936002)(64756008)(66476007)(55016002)(7696005)(66946007)(66556008)(66446008)(76116006)(4326008)(316002)(71200400001)(6506007);
 DIR:OUT; SFP:1101; 
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: xw0IHyGUIewI88032ANoUSeAOcUOQ/WjY+Xeyd5OMD+7wPFnGg2CzUEM52cCErzxpsrpBaJpbe/p18nvlWGUiFRr7s+oIjtIYaZ2Nmqk57Hj4yQZq+Sox0gdxKraDqvhw1QIH5VSMDSPlFDRicbIFCcBeQ5ErvNjBoBf4kWEE0MX/9OMvsLvsFE7svlHoCmFuJb2+oVffMbyicG8Id/1qVQIw8urcYcP/U5jxeqYKvOvmgh3U6SXLlQKttiXyYhd3OjZjvpCSLceu8660uJFiM+K95yIN5cxy4ti/JNyF0Iesj7wnlbatjB3tEHhZb3ybNnF850WgG6lwmdFYxoVgOacCplVEaj5FbqRwKCgqvzCRT9GFSLDNTgP9Vc4ZmIFJ4trhA42sac7gLviHnkViPvOuZdwV3nbYVultmrWCM2ySf7ofTtYcKLxlC7HBNlydIKEGeOUsPM1OfPTJbFrZ1ZP7vPk5Kz7wf8by7LmJMg=
x-ms-exchange-antispam-messagedata: kNz1D+fV3MCugdO8/SRZUsDxaWOK4hB98XUWYDjEuH8t2SYttkBZrjAKvWJY4aoRdtTfr0hnZR3QknBHcwgg8VcHDGTisIOzVQpwuTKMwigN/BN2RQJ4A6NRrvcLMDQlW/n4szJPTGLTXPalGm/ARA==
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 95567af9-f260-4f32-2ead-08d7d7a4dfaf
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Apr 2020 07:59:02.1711 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: aUVghv9Yuj3XSvFEmf0f/GqnjGDE5/8V5BVpQzPzBWue9fK634ksIQO5Kyj4Uskw
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB3985
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
Cc: "Tao, Yintian" <Yintian.Tao@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Official Use Only - Internal Distribution Only]

Reviewed-by: Emily Deng <Emily.Deng@amd.com>

>-----Original Message-----
>From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Zhou,
>Tiecheng
>Sent: Friday, April 3, 2020 12:42 PM
>To: Zhou, Tiecheng <Tiecheng.Zhou@amd.com>; amd-
>gfx@lists.freedesktop.org
>Cc: Tao, Yintian <Yintian.Tao@amd.com>
>Subject: RE: [PATCH] drm/amd/powerplay: avoid using pm_en before it is
>initialized
>
>[AMD Official Use Only - Internal Distribution Only]
>
>Ping...
>
>-----Original Message-----
>From: Tiecheng Zhou <Tiecheng.Zhou@amd.com>
>Sent: Thursday, April 2, 2020 5:29 PM
>To: amd-gfx@lists.freedesktop.org
>Cc: Zhou, Tiecheng <Tiecheng.Zhou@amd.com>; Tao, Yintian
><Yintian.Tao@amd.com>
>Subject: [PATCH] drm/amd/powerplay: avoid using pm_en before it is
>initialized
>
>hwmgr->pm_en is initialized at hwmgr_hw_init.
>during amdgpu_device_init, there is amdgpu_asic_reset that calls to
>pp_get_asic_baco_capability, while hwmgr->pm_en has not yet been
>initialized.
>
>so avoid using pm_en in pp_get_asic_baco_capability.
>
>Signed-off-by: Tiecheng Zhou <Tiecheng.Zhou@amd.com>
>Signed-off-by: Yintian Tao <yttao@amd.com>
>---
> drivers/gpu/drm/amd/powerplay/amd_powerplay.c | 3 ++-
> 1 file changed, 2 insertions(+), 1 deletion(-)
>
>diff --git a/drivers/gpu/drm/amd/powerplay/amd_powerplay.c
>b/drivers/gpu/drm/amd/powerplay/amd_powerplay.c
>index 71b843f542d8..fdff3e1c5e95 100644
>--- a/drivers/gpu/drm/amd/powerplay/amd_powerplay.c
>+++ b/drivers/gpu/drm/amd/powerplay/amd_powerplay.c
>@@ -1455,7 +1455,8 @@ static int pp_get_asic_baco_state(void *handle, int
>*state)
> 	if (!hwmgr)
> 		return -EINVAL;
>
>-	if (!hwmgr->pm_en || !hwmgr->hwmgr_func->get_asic_baco_state)
>+	if (!(hwmgr->not_vf && amdgpu_dpm) ||
>+		!hwmgr->hwmgr_func->get_asic_baco_state)
> 		return 0;
>
> 	mutex_lock(&hwmgr->smu_lock);
>--
>2.17.1
>_______________________________________________
>amd-gfx mailing list
>amd-gfx@lists.freedesktop.org
>https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Flists.fre
>edesktop.org%2Fmailman%2Flistinfo%2Famd-
>gfx&amp;data=02%7C01%7CEmily.Deng%40amd.com%7Cfc7cc02f1db043b393
>1108d7d7895f4d%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637
>214857946885870&amp;sdata=J8iQUQc8phHtblO1gn9TkoI%2BJ%2BehvD4RVfi
>7MybTuCQ%3D&amp;reserved=0
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
