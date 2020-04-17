Return-Path: <SRS0=Q5HU=6B=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1CC63C2BB1D
	for <amd-gfx@archiver.kernel.org>; Fri, 17 Apr 2020 06:50:54 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 934C421D82
	for <amd-gfx@archiver.kernel.org>; Fri, 17 Apr 2020 06:50:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="ky8J7rTR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 934C421D82
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4DD366E33D;
	Fri, 17 Apr 2020 06:50:53 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2045.outbound.protection.outlook.com [40.107.93.45])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 020ED6E33D
 for <amd-gfx@lists.freedesktop.org>; Fri, 17 Apr 2020 06:50:51 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=clrpV2d2vhBEWiO+pXs3XGofPorsGbdGd8MdCMrVsXQuCQ+CmMQiHvHaVYriRuZqLvRlZ2QDMD52g3TUF1SwGlcz2wwEgS3L++S43vUkzjHrlS1juuKT9HUIhtfIBQHFC+mpGfeY9b35jHy2MXh59+CM/9BC7AMoT143bXwYJugNZmfMCdqyMMrPdTxu+4xf5zV7YISTHexLZv+thqqiUFIUflgKDC2myB5E9TwDbsNWgp/Ju7lq/Gr/TzFNcr29uC1WZakg35RlH9Gy7RNNE1Ern3IWntjwBtteuF9uO9T/ccKlzAPOiLhmWjjV+ObC/IM3OTzeQiedKBM8eVS+WQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oXZpVeun5MRUQWGmLxdDd5/gwjdhzBOeYE8svlCBh2U=;
 b=b/RTCrUXPsFgJaclLF/hdFNz3upjkx+mX1GqyL499v3KKSRChYLfBJGehqTRhzzhbsXawgbAFQf0tgKHH7e/G0HZMDYfPowi5ea4aphPUSn+H3qgnHvYuyIHh1HDON0y/Wx9Wl629jVvr6l/FGfMPEzmzKRJBGZf+fMXrS1IjC4oGwy/JuVehahUFnq1ap+MagZIyUUqLnfmrLa/ddg8oHO9BJQ05IQ4521zHR2uqsv8cpfxoFj8v+3QnukQ6iVRx1FDHutuXaA0zQzEiK/W2TYtr1JULShJIFFxHQ+F2gydlc2bJCBLOD8/PFwxzS2Qb6s/bbPfTiEiApBnFg/BEA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oXZpVeun5MRUQWGmLxdDd5/gwjdhzBOeYE8svlCBh2U=;
 b=ky8J7rTRFKghx8pOLm1EVviMUFUlZQV0oFFVubuZz1VAJZ01qk+/sEvtkqZim9ui0W9hUW53R7f32QzpR/qxs6i8HhYCzK/TeU+bV2FOk3ItZ0qC1E3GjhsXzd0Zqb4HOQoAdP2QuFzFr+PqAKEmTo9vKI1yHhBFV8kTIQGga0M=
Received: from CH2PR12MB4071.namprd12.prod.outlook.com (2603:10b6:610:7b::16)
 by CH2PR12MB4216.namprd12.prod.outlook.com (2603:10b6:610:a8::23)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2921.27; Fri, 17 Apr
 2020 06:50:48 +0000
Received: from CH2PR12MB4071.namprd12.prod.outlook.com
 ([fe80::e0d5:7f32:3fb6:a7e]) by CH2PR12MB4071.namprd12.prod.outlook.com
 ([fe80::e0d5:7f32:3fb6:a7e%9]) with mapi id 15.20.2900.028; Fri, 17 Apr 2020
 06:50:48 +0000
From: "Dai, Yuxian (David)" <Yuxian.Dai@amd.com>
To: "Huang, Ray" <Ray.Huang@amd.com>
Subject: RE: [PATCH] drm/amdgpu/powerplay:avoid to show invalid DPM table info
Thread-Topic: [PATCH] drm/amdgpu/powerplay:avoid to show invalid DPM table info
Thread-Index: AQHWFGQtMo6A/CnvOkeLd8D2N3HmYqh8zreAgAARPKA=
Date: Fri, 17 Apr 2020 06:50:48 +0000
Message-ID: <CH2PR12MB4071919C70CCAD812F3949538DD90@CH2PR12MB4071.namprd12.prod.outlook.com>
References: <20200417025859.17577-1-Yuxian.Dai@amd.com>
 <20200417054757.GC25917@jenkins-Celadon-RN>
In-Reply-To: <20200417054757.GC25917@jenkins-Celadon-RN>
Accept-Language: en-AS, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Enabled=true;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SetDate=2020-04-17T06:50:45Z; 
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Method=Standard;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Name=Internal Use Only -
 Unrestricted;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ActionId=60fee671-43e9-4120-ab62-000053344161;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ContentBits=1
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_enabled: true
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_setdate: 2020-04-17T06:50:45Z
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_method: Standard
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_name: Internal Use Only -
 Unrestricted
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_actionid: 601f2185-fca6-4a09-9115-00003bd222b6
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_contentbits: 0
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Yuxian.Dai@amd.com; 
x-originating-ip: [180.167.199.189]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 77413a3a-116d-4a83-3d1d-08d7e29ba967
x-ms-traffictypediagnostic: CH2PR12MB4216:|CH2PR12MB4216:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <CH2PR12MB4216DA53F2E2B3E3DB1E0CF28DD90@CH2PR12MB4216.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:327;
x-forefront-prvs: 0376ECF4DD
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH2PR12MB4071.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(10009020)(4636009)(346002)(376002)(39860400002)(396003)(136003)(366004)(66476007)(66556008)(45080400002)(64756008)(6862004)(66946007)(66446008)(966005)(478600001)(26005)(4326008)(76116006)(52536014)(6506007)(186003)(81156014)(8676002)(33656002)(71200400001)(8936002)(316002)(86362001)(6636002)(83080400001)(5660300002)(55016002)(9686003)(7696005)(2906002);
 DIR:OUT; SFP:1101; 
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 7sAHp2irgvnCnnEEN6mG6rGD7Fxa8/1wFZVcgN5nl7DRfbby9lXCWx81GsaQy1zd9kPWRxcABvCAkAvlLjZEfSm11Ih0pmHcFOQ7CD0MQc94KhoSSJ8dOlIklujQrol0E/HhZivyrFsc6dTcHMRsFRsUl0tgJUfFmt2bZH0T2XnNyt+33a11TUX27WTGA9yggve44f3gwz/tklV52BJm3wo2UHIoT0cJA/0F8/8UOLxnpnLW4XTQuUxg9dq5V+JrPGcEZ8xN122ehSRFa/5Xqus1Q4DEZ8WmA5LuACK6I839PXaFqGwmsNSnVpH7qdb6UN/6NmaUA9eJwjMiKnaEYbniWg15+Ut6USPavYfgwWYEdY0NXwldZEotH2O/lM+JSs7I48gEUS9W+VLGp7GriENsVN8q7OJmIAR41Aha4SaWf3NXf78lGVh86VI9IFIdNcV2DnXnolHcEP8a/i4VlsEecuqduMzQOAHylE+8zhX+hl/0YnxCy89E/I2xsSPwulNs8nq0mkA7EvUbdD1HMA==
x-ms-exchange-antispam-messagedata: CvA1sDm300NgtPZ8+jtKAh6mpwA/KvOrYYLZhOL2IRm6yni33djObjC4HXtazgxFAGMrEuwz41cU9rwWrcv/A9cFf/sethDofuReG4FQtnyPUXucwr2WGt0uIt/WdunGtvtL8muYf0yZs6Nk1p92Rg==
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 77413a3a-116d-4a83-3d1d-08d7e29ba967
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Apr 2020 06:50:48.4823 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: riVNXjGwPHFMmJQIc4asq9tzkgEUlns2i92i6M5geCj3CT5yB04b0wjN0FiEr/UxsfxfLhIPEKYVOeU6AyrW3g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4216
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

On Fri, Apr 17, 2020 at 10:58:59AM +0800, Yuxian Dai wrote:
> for different ASIC support different the number of DPM levels, we 
> should avoid to show the invalid level value.
> v1 -> v2:
> 	follow the suggestion,clarifiy the description for this change
> Signed-off-by: Yuxian Dai <Yuxian.Dai@amd.com>
> Change-Id: I579ef417ddc8acb4a6cf15c60094743a72d9b050

Reviewed-by: Huang Rui <ray.huang@amd.com>

git format-patch --subject-prefix="PATCH v2" HEAD~

It's to indicate v2 patch in the subject.

Thanks,
Ray
 > got it. Thank for your help
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
> y.huang%40amd.com%7C1b5650c171874272ba8208d7e27b538d%7C3dd8961fe4884e6
> 08e11a82d994e183d%7C0%7C0%7C637226891622403483&amp;sdata=kUI7EzW5SgOyf
> DN57C1tZtFngwmXWTK5sNCAwJqmC3k%3D&amp;reserved=0
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
