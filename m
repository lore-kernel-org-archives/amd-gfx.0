Return-Path: <SRS0=KDYH=4M=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E31A5C38BE2
	for <amd-gfx@archiver.kernel.org>; Mon, 24 Feb 2020 20:54:36 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A7D7B21556
	for <amd-gfx@archiver.kernel.org>; Mon, 24 Feb 2020 20:54:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="jPTGBIQI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A7D7B21556
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 444DF6E856;
	Mon, 24 Feb 2020 20:54:36 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2071.outbound.protection.outlook.com [40.107.93.71])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C04496E856
 for <amd-gfx@lists.freedesktop.org>; Mon, 24 Feb 2020 20:54:34 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=C7dAdgPT2r1GBWoHhFN3g+SLw4oH5dZ09wAM+4BPzpvCaMXstPLU9UeJEu8EqWY10QB0Mwpg8Rzzjnsu+di5ZWB0nYZpRSEelHMORdVKFUbPdlpAxVBOSpPNEPrjFpSRkQnm5v8gA7qw7tRQXGg//A7ki9f5Q5sGo+uyhTYmqiEhX4KPqDvUS8xKIHB+Hv3fHufZo4fwwfTa7y8n4QhRSbodRg+fovBp9Z0V2nfxDEdoyf/e/zIYtgcJ00eCqCmsP2iEcYw9CbFsj++m57FwhzmC7z5oPnNAl6LZ6d4CZm8bZroq0rVns5jC9W0C/mtpaBJHNHXfI8mGVltbuLR53g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=41Vin5hYI4r9ZXQpAqyarnfHjoF1vsX7S41YwgpPmPw=;
 b=gkQMgAU0cCFaG90hVGzrNEWJSaepVUZXVpGRL4/oOOtWsRWaF4i2Nq3gxWrRXeuVX6wI6dJRY/doFIgxWYhSNAMJWgmu3x6gznyPREwxWPzAYhj8d4neRNhlr9PbRAXgFmPp0Ar/YviurY3pHhy0rekDPvd9zVwEOy9vm5z8cMUvtOlqSbRIPcfRT3+zGgeYlxxChIha9aoB0KjCvX+o0r3SytUWOJNGts+h7qOnPA1PBYN+ns70bc8G1phv3lWKin4gaEDBywMh/whfjZbgBAFdBFQDGwxpgJJurQ5Bw6dOUAUIt4cGvHO+1TBTCKYsx27hftTbcUYYImorPo48jg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=41Vin5hYI4r9ZXQpAqyarnfHjoF1vsX7S41YwgpPmPw=;
 b=jPTGBIQI+1XeAk+FnPPaVNCEugh3w4k6u2I71IUWnFlqU//ZdCPTj4CT7Rtd2m23xuuj3ZF1Mys7bH4peiiJFX+1TCar5MIXCgLAHHxNvZGN5TfFcckxiSiKHa8u1cRkiLKl5ZpKhv4x4f4SrWFe3M3dbYKDkvkp8EGnFqCggXU=
Received: from DM5PR1201MB2554.namprd12.prod.outlook.com (2603:10b6:3:ec::14)
 by DM5PR1201MB0121.namprd12.prod.outlook.com (2603:10b6:4:56::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2750.21; Mon, 24 Feb
 2020 20:54:33 +0000
Received: from DM5PR1201MB2554.namprd12.prod.outlook.com
 ([fe80::c4c:bafd:5833:2b51]) by DM5PR1201MB2554.namprd12.prod.outlook.com
 ([fe80::c4c:bafd:5833:2b51%5]) with mapi id 15.20.2750.021; Mon, 24 Feb 2020
 20:54:33 +0000
From: "Liu, Zhan" <Zhan.Liu@amd.com>
To: "Lakha, Bhawanpreet" <Bhawanpreet.Lakha@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>, "Deucher,
 Alexander" <Alexander.Deucher@amd.com>, "Zhang, Hawking"
 <Hawking.Zhang@amd.com>
Subject: RE: [PATCH] drm/amdgpu: log TA versions on init
Thread-Topic: [PATCH] drm/amdgpu: log TA versions on init
Thread-Index: AQHV60sYUsjH3SqTtk+0APy3brdqA6gq0m3g
Date: Mon, 24 Feb 2020 20:54:33 +0000
Message-ID: <DM5PR1201MB25540AA66E86F5FC291898CB9EEC0@DM5PR1201MB2554.namprd12.prod.outlook.com>
References: <20200224194527.15599-1-Bhawanpreet.Lakha@amd.com>
In-Reply-To: <20200224194527.15599-1-Bhawanpreet.Lakha@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Zhan.Liu@amd.com; 
x-originating-ip: [165.204.55.250]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 5e52b2f8-4b3d-4e74-0e29-08d7b96bc03c
x-ms-traffictypediagnostic: DM5PR1201MB0121:|DM5PR1201MB0121:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM5PR1201MB01213AF8F2B32790135A51209EEC0@DM5PR1201MB0121.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6790;
x-forefront-prvs: 032334F434
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(4636009)(366004)(136003)(39860400002)(346002)(376002)(396003)(199004)(189003)(52536014)(186003)(478600001)(53546011)(9686003)(6506007)(7696005)(71200400001)(86362001)(55016002)(26005)(6636002)(66476007)(2906002)(5660300002)(81166006)(76116006)(8676002)(33656002)(81156014)(66946007)(8936002)(66446008)(64756008)(66556008)(110136005)(316002)(4326008);
 DIR:OUT; SFP:1101; SCL:1; SRVR:DM5PR1201MB0121;
 H:DM5PR1201MB2554.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: cCLqdTL8CVXjiMwz1XP+4xDRER0eQDjDWF91wY5XrWkNZzwRl2/EeRJgg9TSCc/uqJygtLtoiAX1If+ePV04KMUJAGKSWahYDcm/Nfzc+bW7wwDsJut6seJqomI+cW6QyFvDIgBvgQrz89qt3X36pa6jMkWQkhIQFt4hlaKUoz14hfgqEAT+/MoTqgacF8+haNT07rZrQblPFcM3etjQs4YWDwhpUid+tDP0ROgLWyUrlRH/iK2vVdfkMrZdzX1zXaZUMYfd73F7i2IZ9fpCOW+4TOE4tG+RYCpJPW2WDvbNEhRBqd1/iO9FfbXrsc4rfn2DgxSG8lDvUBb+qmkFbl/Q86ayxeITlp9gpPYwPx8Mn6tIjIIKha0HuwrB7JnUZeQXFYQK0ruMJ2fG4RAKDyKPHxWxn4cbHzwu7Ejrs7ygeddP7RvyGE6edrqoP6as
x-ms-exchange-antispam-messagedata: /8D1ng3H7KnI+SljLOKDJh8p6wJA3fFKTxASokwuseqDfflOPUisVAjCLximtrRG/yP9GWI+Iz17Aa0JwuEU1Hgb4Hcp+xQXgcRlRxwGsViAaIRRGM2WZy5RBUMQrCL1wYBfJcv6WLoIgewUTv1sCA==
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5e52b2f8-4b3d-4e74-0e29-08d7b96bc03c
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Feb 2020 20:54:33.2105 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: UWlx4ot+gj6HDd8iHZjPHQVaVTj3iUJjMRF6dlbZLEXLlqyBCj2fVzLjvwqZjxVB
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR1201MB0121
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


> -----Original Message-----
> From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of
> Bhawanpreet Lakha
> Sent: 2020/February/24, Monday 2:45 PM
> To: amd-gfx@lists.freedesktop.org; Deucher, Alexander
> <Alexander.Deucher@amd.com>; Zhang, Hawking
> <Hawking.Zhang@amd.com>
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
