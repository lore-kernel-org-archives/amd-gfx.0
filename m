Return-Path: <SRS0=Kz8i=4N=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D76DAC35DF5
	for <amd-gfx@archiver.kernel.org>; Tue, 25 Feb 2020 06:27:10 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9844A2176D
	for <amd-gfx@archiver.kernel.org>; Tue, 25 Feb 2020 06:27:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="Ffn6Zv/o"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9844A2176D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 423096E0E8;
	Tue, 25 Feb 2020 06:27:10 +0000 (UTC)
Received: from NAM04-BN3-obe.outbound.protection.outlook.com
 (mail-eopbgr680052.outbound.protection.outlook.com [40.107.68.52])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3B5F26E0E8
 for <amd-gfx@lists.freedesktop.org>; Tue, 25 Feb 2020 06:27:09 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Fq6VS79SYJyFuCBXmJ6mLc3tKJQzUGK6etO/A1yaK9HOB3wgIfPVk6kmshxWx6ZpzF1qjM35ne7NEFbmmubTK6g6sqn10vZNM0CTWJLRbyhGjgNTN9bvnrJwl0Nf0OjND+BQfdn83ctPGlugvwMPrqEaklcxja2t4moNv3yByop300Fi0tff8VnPFGwZLLvrzatUnZ4rRbVL+/9KkcRAnI2iVaTWixHFgkLV4+hq3YCWzTgoAqHjiG7KgscNDKO9iq1rAHr3nSzX5wv/ynDfUAS08KRBO8iuSOmrmQmPB4GWg2cPlPvhoINcyODP7C7eNojhbYK1VIAb+23opNdtoA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/UncPPwp6xDLVReJNu2szWkKxlv52rorUruzZawuhzQ=;
 b=ImdGe4o+jT5xpr6tGkcLR9SapkwCvtpsRdtzREXBHLpWbo8KRK2ACVTP0Hg8BBM3xSb2II/M38uRGjDGcdckNfPWR2/lVVwt1RrDxHTwD6jmqFOyFvzqbff1txfF6CFJkcq+djAQ+7v3KIyPxDEajp7P1z1eLQXPK7ieWv8yWQ4gsT6CldVzNFoYNZicaaUHfsCAGmTXBtusMjPIzuCUSXoyV4MHwI429V7XXEQdLsHPsen9kRf8Z+bv4n4HhcVftuRmT41wdKpwj9wFfNB59hLJw+NBNLJSoCEak1U6nwF8tqjJlio/pO+KuBT4nHPY3de+aHbiCVXRBu65sWqPXg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/UncPPwp6xDLVReJNu2szWkKxlv52rorUruzZawuhzQ=;
 b=Ffn6Zv/obj8wi45ryVlmluHYasLEmbDXbhjTXYR6hxfMK2IzG/zkZJ3W+S3H04KZZ0q3yOMereOoy5dDFiv6mnXrK8bG3L86i7/IUn2AyYxr90gSve6aWqwDQ1CYnFKtVGGYh/QcwOcN3vd0qDqgGWi7aUHh89QedeBuuan2fh8=
Received: from DM5PR12MB1418.namprd12.prod.outlook.com (2603:10b6:3:7a::15) by
 DM5PR12MB1131.namprd12.prod.outlook.com (2603:10b6:3:73::10) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2750.21; Tue, 25 Feb 2020 06:27:07 +0000
Received: from DM5PR12MB1418.namprd12.prod.outlook.com
 ([fe80::c8ba:7e4e:e1c3:d8db]) by DM5PR12MB1418.namprd12.prod.outlook.com
 ([fe80::c8ba:7e4e:e1c3:d8db%5]) with mapi id 15.20.2750.021; Tue, 25 Feb 2020
 06:27:07 +0000
From: "Zhang, Hawking" <Hawking.Zhang@amd.com>
To: "Liu, Zhan" <Zhan.Liu@amd.com>, "Lakha, Bhawanpreet"
 <Bhawanpreet.Lakha@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>, "Deucher, Alexander"
 <Alexander.Deucher@amd.com>
Subject: RE: [PATCH] drm/amdgpu: log TA versions on init
Thread-Topic: [PATCH] drm/amdgpu: log TA versions on init
Thread-Index: AQHV60r9gp24juZqGESYIa9k/OvOz6gq0qWAgACfmRA=
Date: Tue, 25 Feb 2020 06:27:07 +0000
Message-ID: <DM5PR12MB1418B4C3BE0EF80AA06C6ADFFCED0@DM5PR12MB1418.namprd12.prod.outlook.com>
References: <20200224194527.15599-1-Bhawanpreet.Lakha@amd.com>
 <DM5PR1201MB25540AA66E86F5FC291898CB9EEC0@DM5PR1201MB2554.namprd12.prod.outlook.com>
In-Reply-To: <DM5PR1201MB25540AA66E86F5FC291898CB9EEC0@DM5PR1201MB2554.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Enabled=true;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SetDate=2020-02-25T06:27:04Z; 
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Method=Standard;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Name=Internal Use Only -
 Unrestricted;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ActionId=bd149804-12ba-4013-adea-000011e6bc37;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ContentBits=1
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_enabled: true
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_setdate: 2020-02-25T06:27:04Z
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_method: Standard
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_name: Internal Use Only -
 Unrestricted
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_actionid: da7dc98b-a2cd-45f4-af67-0000972a7696
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_contentbits: 0
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Hawking.Zhang@amd.com; 
x-originating-ip: [180.167.199.189]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 0d6fbb0e-711f-4060-3701-08d7b9bbbcb2
x-ms-traffictypediagnostic: DM5PR12MB1131:|DM5PR12MB1131:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM5PR12MB1131D36926D0C8E74AB2AD47FCED0@DM5PR12MB1131.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-forefront-prvs: 0324C2C0E2
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(4636009)(346002)(366004)(39860400002)(376002)(136003)(396003)(189003)(199004)(2906002)(6636002)(71200400001)(8936002)(9686003)(53546011)(8676002)(110136005)(316002)(6506007)(7696005)(55016002)(186003)(26005)(66946007)(66476007)(76116006)(66446008)(4326008)(52536014)(64756008)(478600001)(66556008)(86362001)(5660300002)(81166006)(81156014)(33656002);
 DIR:OUT; SFP:1101; SCL:1; SRVR:DM5PR12MB1131;
 H:DM5PR12MB1418.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: zUNIGUSBEB09k1SXgT5VRDtlPIto0qTjDNqjYTRtw6CPl7Ws2IKiQUam+gwbG5tXl68UR8rn3c8xrnG6HQx8OxU1imISya8GdTtQ0Z8qSexbzqag3yFsmsbTXa109FoYo+toYvmN8l70i5tuUF5IJIV6n2ppv6sXCWH/rn4XaPXyAJcJmofGikPbF8AEk21/LWTNDiIS57Y7IZTNl4iqGpXTITgZ/rA4aQhOi3pnqeFelabhDJsQzl1Aba6sOq3SFXiLO8UnH8gHy0UNkjZFs8y6AT812oKNNsiXo34ecM/Y/S2T6lpH9e94CMMs0gbZaLnD7SRBb8WDqQYnwt8MW3PRfZsDcl7gdfcaaCcKCGUpLDYeAsD3ZHK+utoJYj5vJQcdJjKX6aPMWfdKI1QDPOfK7f4rRKAUR/8g7XSK0RKODO3+Xd/fhMuNYoMaIlwm
x-ms-exchange-antispam-messagedata: hHpYLYpkl0gR3yPQKBtP57Gk5jW6wZi8kpkg76H4CqoeKX0FsrFbdO368octmxQEAR+e1L0wQF1ZtLaBvfpE48tI7zQABfO9lXM82VvQJDlbB2Dxz5cUOzgD40ZtmIPkMHSTt+9/2xX/ksQ0Nzz/fQ==
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0d6fbb0e-711f-4060-3701-08d7b9bbbcb2
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Feb 2020 06:27:07.0784 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 9zV3QoUBCnTk7T3LePK4MKB/xIe3co2ojvuQkdAvYLufN+M/r+rsTWyqkjH9lBf8zgVTtFWvazJXGOZ4c8bMvQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1131
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
Cc: "Lakha, Bhawanpreet" <Bhawanpreet.Lakha@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Official Use Only - Internal Distribution Only]

Hold on please. 

I don't think this is the best approach as we already had existing debugfs interface for that purpose. We shall centralize all the firmware information query under amdgpu_debugfs_firmware_info, and user should go through debugfs to query firmware information.

Regards,
Hawking
-----Original Message-----
From: Liu, Zhan <Zhan.Liu@amd.com> 
Sent: Tuesday, February 25, 2020 04:55
To: Lakha, Bhawanpreet <Bhawanpreet.Lakha@amd.com>; amd-gfx@lists.freedesktop.org; Deucher, Alexander <Alexander.Deucher@amd.com>; Zhang, Hawking <Hawking.Zhang@amd.com>
Cc: Lakha, Bhawanpreet <Bhawanpreet.Lakha@amd.com>
Subject: RE: [PATCH] drm/amdgpu: log TA versions on init


> -----Original Message-----
> From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of 
> Bhawanpreet Lakha
> Sent: 2020/February/24, Monday 2:45 PM
> To: amd-gfx@lists.freedesktop.org; Deucher, Alexander 
> <Alexander.Deucher@amd.com>; Zhang, Hawking <Hawking.Zhang@amd.com>
> Cc: Lakha, Bhawanpreet <Bhawanpreet.Lakha@amd.com>
> Subject: [PATCH] drm/amdgpu: log TA versions on init
> 
> It is helpful to know what version the TA's are for debugging
> 
> Signed-off-by: Bhawanpreet Lakha <Bhawanpreet.Lakha@amd.com>

Reviewed-by: Zhan Liu <zhan.liu@amd.com>

> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
> index a16c8101e250..09d1433677a6 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
> @@ -358,6 +358,7 @@ static int psp_asd_load(struct psp_context *psp)
>  	if (!ret) {
>  		psp->asd_context.asd_initialized = true;
>  		psp->asd_context.session_id = cmd->resp.session_id;
> +		DRM_INFO("ASD: Initialized (version: 0x%X)", psp-
> >asd_fw_version);
>  	}
> 
>  	kfree(cmd);
> @@ -518,6 +519,7 @@ static int psp_xgmi_load(struct psp_context *psp)
>  	if (!ret) {
>  		psp->xgmi_context.initialized = 1;
>  		psp->xgmi_context.session_id = cmd->resp.session_id;
> +		DRM_INFO("XGMI: Initialized (version: 0x%X)", psp-
> >ta_xgmi_ucode_version);
>  	}
> 
>  	kfree(cmd);
> @@ -658,6 +660,7 @@ static int psp_ras_load(struct psp_context *psp)
>  	if (!ret) {
>  		psp->ras.ras_initialized = true;
>  		psp->ras.session_id = cmd->resp.session_id;
> +		DRM_INFO("RAS: Initialized (version: 0x%X)", psp-
> >ta_ras_ucode_version);
>  	}
> 
>  	kfree(cmd);
> @@ -832,6 +835,7 @@ static int psp_hdcp_load(struct psp_context *psp)
>  	if (!ret) {
>  		psp->hdcp_context.hdcp_initialized = true;
>  		psp->hdcp_context.session_id = cmd->resp.session_id;
> +		DRM_INFO("HDCP: Initialized (version: 0x%X)", psp-
> >ta_hdcp_ucode_version);
>  	}
> 
>  	kfree(cmd);
> @@ -977,6 +981,7 @@ static int psp_dtm_load(struct psp_context *psp)
>  	if (!ret) {
>  		psp->dtm_context.dtm_initialized = true;
>  		psp->dtm_context.session_id = cmd->resp.session_id;
> +		DRM_INFO("DTM: Initialized (version: 0x%X)", psp-
> >ta_dtm_ucode_version);
>  	}
> 
>  	kfree(cmd);
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
