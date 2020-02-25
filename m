Return-Path: <SRS0=Kz8i=4N=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE7ECC35DF2
	for <amd-gfx@archiver.kernel.org>; Tue, 25 Feb 2020 06:29:28 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B488F2176D
	for <amd-gfx@archiver.kernel.org>; Tue, 25 Feb 2020 06:29:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="k93zKWar"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B488F2176D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 601B26E113;
	Tue, 25 Feb 2020 06:29:28 +0000 (UTC)
Received: from NAM04-BN3-obe.outbound.protection.outlook.com
 (mail-eopbgr680069.outbound.protection.outlook.com [40.107.68.69])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1251A6E113
 for <amd-gfx@lists.freedesktop.org>; Tue, 25 Feb 2020 06:29:27 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=L/4WztEdEHgXgdKafzYUYtAg9jqGaKjHdmxKUZhGMrmP050oVMqfU0lbGKptJcjdDNWTISMo5G8PbabBNMoEz3dK2epiIqNkLGQmlWZpGepn5klzH4uOmUS4/ugsFlO2MttbYklOPp58MZbpmxy5cx0204xZAC9iDiVydjUqsk389BiJyUt/MK/fq32w8lwSwUUdgRjh36m9b+3We6m8sRrKy2fkcifFyzeci2LGegOAm6QJPV5efFEy0E1Kvb9zyajxfatVFcrxuia7ZQ80lbvZC/iTn7RICP1C1Sdcpuz5p1UcjGJkC9KxAPo3HPp219FbHUD/EP03vZ3iixgP1Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sZ/RdOemWWz51pp3DFXivj+8DkIrfha8g7p4+b7zKVg=;
 b=XLuxACcs2o383wQeY2751xlwDs7AZJqknKgMANF2k2Pnsg0/svKVNSpnLsv9STUMIO13qB0GqFtqAIcZIMhE4tJ9CQvHl5xRRgvhl+h762usVM7eX4tdekevTXkC2SuAXWjYjyauuLcedNzAwhD7WaDIMfqQzd0vY2llz8HP47aa7ZXs3AyxvIhnagcTglruEls2fXhOg1JNEN5PRJePq4f5TgevOUQccRuF7akTg3XdjB6u7TbkuNjdEMBIZD1XvaeUTXzgCG+XyWXAw7erd7gynoFw1w8v2kLRPkhu6ZCtTUs8ZSFLvP4/Xvsjvpz66QJC5kMSIACi1fjGEB4sUQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sZ/RdOemWWz51pp3DFXivj+8DkIrfha8g7p4+b7zKVg=;
 b=k93zKWarRS/NUmHpFTdp4tTv7b48HiCUvWcU7qFrXVlR3NmLukVVE2CStvOr2bk0y8f49rJ1Fv2wLWplNe2QFCyMcwlEhY5x0d7WcvCa7+BeRAhugs4uWP2AKsJrrg9O7ByvdHuyEgeEteXP8dboRbN3OISR6bWiTeV9s3VKJkc=
Received: from DM5PR12MB1418.namprd12.prod.outlook.com (2603:10b6:3:7a::15) by
 DM5PR12MB1131.namprd12.prod.outlook.com (2603:10b6:3:73::10) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2750.21; Tue, 25 Feb 2020 06:29:25 +0000
Received: from DM5PR12MB1418.namprd12.prod.outlook.com
 ([fe80::c8ba:7e4e:e1c3:d8db]) by DM5PR12MB1418.namprd12.prod.outlook.com
 ([fe80::c8ba:7e4e:e1c3:d8db%5]) with mapi id 15.20.2750.021; Tue, 25 Feb 2020
 06:29:25 +0000
From: "Zhang, Hawking" <Hawking.Zhang@amd.com>
To: "Liu, Zhan" <Zhan.Liu@amd.com>, "Lakha, Bhawanpreet"
 <Bhawanpreet.Lakha@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>, "Deucher, Alexander"
 <Alexander.Deucher@amd.com>
Subject: RE: [PATCH] drm/amdgpu: log TA versions on init
Thread-Topic: [PATCH] drm/amdgpu: log TA versions on init
Thread-Index: AQHV60r9gp24juZqGESYIa9k/OvOz6gq0qWAgACfmRCAAABtEA==
Date: Tue, 25 Feb 2020 06:29:25 +0000
Message-ID: <DM5PR12MB141834A0DCB1065A37947588FCED0@DM5PR12MB1418.namprd12.prod.outlook.com>
References: <20200224194527.15599-1-Bhawanpreet.Lakha@amd.com>
 <DM5PR1201MB25540AA66E86F5FC291898CB9EEC0@DM5PR1201MB2554.namprd12.prod.outlook.com>
 <DM5PR12MB1418B4C3BE0EF80AA06C6ADFFCED0@DM5PR12MB1418.namprd12.prod.outlook.com>
In-Reply-To: <DM5PR12MB1418B4C3BE0EF80AA06C6ADFFCED0@DM5PR12MB1418.namprd12.prod.outlook.com>
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
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_setdate: 2020-02-25T06:29:23Z
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_method: Standard
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_name: Internal Use Only -
 Unrestricted
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_actionid: 38001c4d-e5cb-484a-8c1e-0000dc013a63
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_contentbits: 0
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Hawking.Zhang@amd.com; 
x-originating-ip: [180.167.199.189]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 11c37956-1551-4ffb-5b74-08d7b9bc0ee7
x-ms-traffictypediagnostic: DM5PR12MB1131:|DM5PR12MB1131:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM5PR12MB113199045B9DF2300CF66306FCED0@DM5PR12MB1131.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-forefront-prvs: 0324C2C0E2
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(4636009)(346002)(366004)(39860400002)(376002)(136003)(396003)(189003)(199004)(2906002)(6636002)(2940100002)(71200400001)(8936002)(9686003)(53546011)(8676002)(110136005)(316002)(6506007)(7696005)(55016002)(186003)(26005)(66946007)(66476007)(76116006)(66446008)(4326008)(52536014)(64756008)(478600001)(66556008)(86362001)(5660300002)(81166006)(81156014)(33656002);
 DIR:OUT; SFP:1101; SCL:1; SRVR:DM5PR12MB1131;
 H:DM5PR12MB1418.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: HEvnU2jKrrxSKfYboLtEyII+JzqQ68cZIOsDsIes4vUxQyP6RDk+BoEuZxu6Idp3n7vu9g1Ms3oU4l2FwFLpUbRpbPw1ebGPgjrcE3HEDOAm7tGvyAzeRowqcAjKOJHSE1P5ha2+FPLRy90T/p0WfCtqskVCG0EDP9faZaLdDMQT1/G24CFqVHOLfKgg/3b9BWdbeTd6UrFIWzCbt44YoLttke7dTOTvmf0EulrI0neJTlM0xF2SXvvR4+jMc8jYaGQFOiR/cGjNEooid0UqMdPMXncjkEUrEY+slk+y8z481cJRXb54Rou7Eb/xM9rxUdgjHTkcNZ74L8B/NlGFeqv6dbGweXOSSYRQWyhOL4GjQXoctvbVJvbKeWaeCXJ4525REAABei2ucyXnX73A247tmtusTChXOyqe80U8JBHlDwb061co/sBKRI3C8blS
x-ms-exchange-antispam-messagedata: +GtKUJ/1QkITv8Ji5S5aRiWVORrAugsh4NROgVkZeOWYZTH4c6vuIGZ81/R6LLNBdPBHQK+Cu6Mjwc+Omduogdocgw8nswSntrPxcNOJN3QzduF0j6AdfK64eydU8YIJ0EXjrRgP+ptURzeCxYZEig==
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 11c37956-1551-4ffb-5b74-08d7b9bc0ee7
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Feb 2020 06:29:25.0718 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: pxz2C/6tswh9yDv2DW2NHJ+7uNfpUu5gi9TeCvKTxF6ZxCrXLi9mOA2YchsaJ5Xh2Rmc3zMGHBXkFEQrHFgRmg==
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

Specific for your case, you just need add dtm and hdcp ta version in amdgpu_debugfs_firmware_info, Similar as xgmi and ras ta. The following cmd will give you all the firmware version information.

sudo cat /sys/kernel/debug/dri/x/amdgpu_firmware_info

Regards,
Hawking

-----Original Message-----
From: Zhang, Hawking 
Sent: Tuesday, February 25, 2020 14:27
To: Liu, Zhan <Zhan.Liu@amd.com>; Lakha, Bhawanpreet <Bhawanpreet.Lakha@amd.com>; amd-gfx@lists.freedesktop.org; Deucher, Alexander <Alexander.Deucher@amd.com>
Cc: Lakha, Bhawanpreet <Bhawanpreet.Lakha@amd.com>
Subject: RE: [PATCH] drm/amdgpu: log TA versions on init

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
