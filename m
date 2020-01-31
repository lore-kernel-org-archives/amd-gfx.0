Return-Path: <SRS0=jwYW=3U=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 697D1C2D0DB
	for <amd-gfx@archiver.kernel.org>; Fri, 31 Jan 2020 16:06:31 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3200D206D5
	for <amd-gfx@archiver.kernel.org>; Fri, 31 Jan 2020 16:06:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="M2sft9Ak"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3200D206D5
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C1EB76FB95;
	Fri, 31 Jan 2020 16:06:30 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2041.outbound.protection.outlook.com [40.107.237.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E0F8E6FB95
 for <amd-gfx@lists.freedesktop.org>; Fri, 31 Jan 2020 16:06:28 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GT+LdZSAcXak1Zeg3nVGKXCQ8H+0IviOusXJA0cqusYcIBkyB0TtlEp74lY0gCIKh1l/pUphvBB7yF0zx0ntgUW4gMOXGafjbjEKw6snS9tSgclQ7N9vHTkcu8XcHBAXPqziuv3F6bKLRrcw18WPRMq9vsArXUwYNks4lrHTQ+GuG2Kkf7SnfI8S2IuIRSjgl1dnotsQTOrhS8Hmn0yOnYx09CxvC9aDVYJPSO1vEXaMlt9TYvHJKIzWuKstl6bpEbJzN7qpwMA7ABjKKN6PbHyodnUlnDnx1+zbvbbUN9mA7glyq1qFKasaLutM5DHxKm475tirTqVhddNOqjaq0g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NLiOT3MYFgtvjRdgqczgA3pg2RtoHqc8ajVjsNVmILs=;
 b=BQs4m/RmGzJ5kY2e3F7gtArHQFOxBfWWDS/DyGUuxuev89OU4K1GOB2AQMv0NaF0lf2TN4JJUCmktnNGFyaiA2PJw7Bq9NwbD2aTpbzvPKmyxBUlSX5Vi4JIw0G+4DfoIuSOjztWnOf7WjVfJQvKc3JcyXeNTJNiOevY9rGz6iDlB32Hz9Z7TjiPdc0YBboAcv9pDyA4bLQlfpjemKmfsXdAqkW+HpMpFxR+ID2rAX31AK33rXQETzkq2uRe0yNGIVQlKaqfOLljzpOcC5ziPbU97Cd5Ho/pCcPG6tmTHBjzFTOv8gbMdPuRQ0gXakIRocImURDOuzUndnWa2U3BMg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NLiOT3MYFgtvjRdgqczgA3pg2RtoHqc8ajVjsNVmILs=;
 b=M2sft9AktgMrxmdE1IpRMnBTBKleOZxZFAWscVQfi2uO1KVin0WJnqWL7M0Q0M6gXwqio0680iehqdST2aThiqze7ogND4+X/WnRXE0fcM6BC0VwW0PYbAFKg/Ev9dfQemh4RMnnUeoostdlAtrJ0wIuDpS+SVSIxd2SI/vvQRE=
Received: from DM5PR1201MB2554.namprd12.prod.outlook.com (10.172.92.14) by
 DM5PR1201MB0138.namprd12.prod.outlook.com (10.174.107.21) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2686.29; Fri, 31 Jan 2020 16:06:27 +0000
Received: from DM5PR1201MB2554.namprd12.prod.outlook.com
 ([fe80::f4c6:42e8:77bb:d721]) by DM5PR1201MB2554.namprd12.prod.outlook.com
 ([fe80::f4c6:42e8:77bb:d721%6]) with mapi id 15.20.2686.028; Fri, 31 Jan 2020
 16:06:27 +0000
From: "Liu, Zhan" <Zhan.Liu@amd.com>
To: "Lipski, Mikita" <Mikita.Lipski@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amd/display: Fix a typo when computing dsc
 configuration
Thread-Topic: [PATCH] drm/amd/display: Fix a typo when computing dsc
 configuration
Thread-Index: AQHV2EcmjK4uGu9AAECf4HbVB5Lxq6gE7/hg
Date: Fri, 31 Jan 2020 16:06:27 +0000
Message-ID: <DM5PR1201MB255498B69A1213BF9203BC639E070@DM5PR1201MB2554.namprd12.prod.outlook.com>
References: <20200131150004.5920-1-mikita.lipski@amd.com>
In-Reply-To: <20200131150004.5920-1-mikita.lipski@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Zhan.Liu@amd.com; 
x-originating-ip: [165.204.55.250]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 18556e40-99de-4d97-5407-08d7a667870e
x-ms-traffictypediagnostic: DM5PR1201MB0138:|DM5PR1201MB0138:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM5PR1201MB0138C7613B9958D72D182B1F9E070@DM5PR1201MB0138.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:378;
x-forefront-prvs: 029976C540
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(4636009)(136003)(346002)(376002)(39860400002)(396003)(366004)(199004)(189003)(8936002)(4326008)(316002)(81166006)(33656002)(5660300002)(81156014)(86362001)(186003)(8676002)(110136005)(9686003)(54906003)(6506007)(478600001)(53546011)(71200400001)(26005)(55016002)(64756008)(66556008)(66446008)(66946007)(66476007)(52536014)(7696005)(76116006)(2906002);
 DIR:OUT; SFP:1101; SCL:1; SRVR:DM5PR1201MB0138;
 H:DM5PR1201MB2554.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: WP/Et9B8zrrzOhUNrwNrkloiaj4s2HlWWZWGEe2EBHTBkfmd9z695ma0B5RqJAYgGl5lmFEYD6zNq8u0s6xAUc7x30pz6Obj4zACEqBP7KnhxS7t3ObZeYeJZxKQt29OWWUuc7mtsEjAuo8ZcrqRR8QykZU5sZ7Xx1HbXVJrPtr50ziK7RFx1xYsoNHOFGN2VI94nJD0JI+9IfMvin3buV46hsif3V9Xy2qOmGunnlRdkvaBUz6xebiVSprV6r4G0eyL/w52kxro2zeyt8Rb/f7/CmcMIiyFYATlBiEtz/1Ro/TA2RWof6iMWOyWWr9DTKy59yfywlNoqkyDWNcH0wVnTK2WkWxW1HLIq+/qAIi1UjYWphwFzqbUS67G7wvdtl7WHOjHsnDezUTwJf6JHpLU09j+je1up1crEhLkXVr3JcXBCDpvl3fr++X50zED
x-ms-exchange-antispam-messagedata: AX+ma1JIgC/TJFvlgZUtcTRK2VXlunOSLezSXfO0+kEjB5IEdhya2Gkq2Wenzo+VWLatvyEegrBUobBgVOlrJhO6AbH7HNM4eVyCRba7C2+mztcH7sdT31GT4zeqT9BRwy2CkC+uHRX01y24JkUnfQ==
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 18556e40-99de-4d97-5407-08d7a667870e
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 Jan 2020 16:06:27.2490 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: oL8su8ilTaCKYScOQUbdb2Pc48VZTxSpIRlgM+c3lK8xIXvOm1/eUd6/6bzwLxsf
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR1201MB0138
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
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Lipski,
 Mikita" <Mikita.Lipski@amd.com>, "Wentland, Harry" <Harry.Wentland@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>



> -----Original Message-----
> From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of
> mikita.lipski@amd.com
> Sent: 2020/January/31, Friday 10:00 AM
> To: amd-gfx@lists.freedesktop.org
> Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Lipski, Mikita
> <Mikita.Lipski@amd.com>; Wentland, Harry <Harry.Wentland@amd.com>
> Subject: [PATCH] drm/amd/display: Fix a typo when computing dsc
> configuration
> 
> From: Mikita Lipski <mikita.lipski@amd.com>

Reviewed-by: Zhan Liu <zhan.liu@amd.com>

> 
> [why]
> Remove a backslash symbol accidentally left in increase bpp function when
> computing mst dsc configuration.
> 
> Signed-off-by: Mikita Lipski <mikita.lipski@amd.com>
> ---
>  drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git
> a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.c
> b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.c
> index 96b391e4b3e7..5672f7765919 100644
> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.c
> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.c
> @@ -632,7 +632,7 @@ static void increase_dsc_bpp(struct
> drm_atomic_state *state,
>  			if (drm_dp_atomic_find_vcpi_slots(state,
> 
> params[next_index].port->mgr,
> 
> params[next_index].port,
> -
> vars[next_index].pbn,\
> +
> vars[next_index].pbn,
> 
> dm_mst_get_pbn_divider(dc_link)) < 0)
>  				return;
>  			if (!drm_dp_mst_atomic_check(state)) {
> --
> 2.17.1
> 
> _______________________________________________
> amd-gfx mailing list
> amd-gfx@lists.freedesktop.org

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
