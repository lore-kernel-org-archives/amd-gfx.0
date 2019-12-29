Return-Path: <SRS0=XVZG=2T=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00BB5C2D0C0
	for <amd-gfx@archiver.kernel.org>; Sun, 29 Dec 2019 06:44:21 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C5A3C208C4
	for <amd-gfx@archiver.kernel.org>; Sun, 29 Dec 2019 06:44:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="XRj4+TQP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C5A3C208C4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7902D89E3B;
	Sun, 29 Dec 2019 06:44:20 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2070.outbound.protection.outlook.com [40.107.94.70])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 110B489E3B
 for <amd-gfx@lists.freedesktop.org>; Sun, 29 Dec 2019 06:44:19 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Tvhz40x4LWogtURcHEXiSg9BEaYx7Y84YHA014BKmikoAQAYd4aN9B3P9ntTSEk/a2p+hxLvYgPkPEJPr610MVV1WM8NT+22oQSVqXXI30Ln9qbbzfsSmK3wzuRzuAv6WPSRjRNhcgptpSCUyQX922i727yGX9SWEDVcr+CYRdZzATyqXihznONmbUgw/tSia6Ni//5LRQsJBPTXicsQZ0BLnyKRoQ5N/5KH6+rF4VS5Ko85+t/Y+XW0+eyCggccGUKD17ARM85npwwmV7DmOdBKVecxwz5svUGH0dwfA1ojXSg9Xhz5SIFT3sND8v2NJIXrywTsnvkUJXU/cUOR0Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nI6+0cu1lbUz11hes1GmuEfUY2gtScnvEYqpLHsDwM4=;
 b=B4mKelOibhN58TaVldkjTaQbm985R8vw1UINqGAXECGc09h27Mfe0fDk++zXr2pE+c+OIg4VGcx8RcTZIc1JD8CgTch/EIf7Y4rBvtVbHAcvxbw1npdwZZG5sQX5zCpfgny1dZ0kekJncDN41eTF5jE6VLa5rS2m/8mnHxukRwOsHlR7uuZve17DqF2H/OlRRM1nwGs5j0QqK5+lVb93hrHmgjQYvJOlnIvPXpy0Im22tBHj9kNrtr21AQqlOUNuu8cJRBDqpxep5iLO0CI/KkthjWrtnBDN1IdVdKGP2GzVQXah8oXuGHdeLm1MDu3YedZZtbRa8zchC0oueFIYHQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nI6+0cu1lbUz11hes1GmuEfUY2gtScnvEYqpLHsDwM4=;
 b=XRj4+TQPhr3Pv9tKVcv7xnxVsTRYGnnthaJM8dLPYX1G9EdquaJezlTYh/hFTOrrH0tGYvvRCQ9oZ4r2tZ2xt4o2CJkiKOYmY9F1wPefH8cnfLs+SCg7eWIkd+y6Q5KcD9JL9m9djI/KiwK8Sn0bToY2fVonxqcXC0UgZAlKiNM=
Received: from MWHPR12MB1358.namprd12.prod.outlook.com (10.169.203.148) by
 MWHPR12MB1455.namprd12.prod.outlook.com (10.172.56.18) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2581.11; Sun, 29 Dec 2019 06:44:17 +0000
Received: from MWHPR12MB1358.namprd12.prod.outlook.com
 ([fe80::2d1b:f19e:cdc7:8b4c]) by MWHPR12MB1358.namprd12.prod.outlook.com
 ([fe80::2d1b:f19e:cdc7:8b4c%10]) with mapi id 15.20.2581.007; Sun, 29 Dec
 2019 06:44:17 +0000
From: "Deucher, Alexander" <Alexander.Deucher@amd.com>
To: "Quan, Evan" <Evan.Quan@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH 2/2] drm/amdgpu: avoid unnecessary SMC firmware reloading
Thread-Topic: [PATCH 2/2] drm/amdgpu: avoid unnecessary SMC firmware reloading
Thread-Index: AQHVu8QLvC4lE8e/9kyM93r0dMXT5qfQr6/w
Date: Sun, 29 Dec 2019 06:44:17 +0000
Message-ID: <MWHPR12MB135815F5A75849CFA01DDF3CF7240@MWHPR12MB1358.namprd12.prod.outlook.com>
References: <20191226081041.8747-1-evan.quan@amd.com>
 <20191226081041.8747-2-evan.quan@amd.com>
In-Reply-To: <20191226081041.8747-2-evan.quan@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Enabled=true;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_SetDate=2019-12-29T06:45:54Z; 
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Method=Privileged;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Name=Public_0;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_ActionId=e81ce327-d6a3-4db0-8aa6-00004d66b3af;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_ContentBits=1
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_enabled: true
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_setdate: 2019-12-29T06:46:29Z
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_method: Privileged
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_name: Public_0
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_actionid: ea829775-12be-4fb7-8d4f-0000dd06cfd9
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_contentbits: 0
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Deucher@amd.com; 
x-originating-ip: [71.219.59.120]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 7635d5ef-b442-4820-2db7-08d78c2a8705
x-ms-traffictypediagnostic: MWHPR12MB1455:|MWHPR12MB1455:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MWHPR12MB14553850954678A1818D3F32F7240@MWHPR12MB1455.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:546;
x-forefront-prvs: 0266491E90
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(4636009)(396003)(346002)(376002)(39840400004)(136003)(366004)(189003)(199004)(13464003)(76116006)(8936002)(8676002)(7696005)(66476007)(66446008)(66946007)(64756008)(66556008)(26005)(81166006)(81156014)(55016002)(86362001)(71200400001)(110136005)(5660300002)(186003)(316002)(52536014)(478600001)(9686003)(6506007)(53546011)(2906002)(33656002);
 DIR:OUT; SFP:1101; SCL:1; SRVR:MWHPR12MB1455;
 H:MWHPR12MB1358.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: rAILI57LwZInKoK8ZB5aJp+xKMxv1VJawI3LYhyqS4X47rAKXz9WO2u5e+nr6cST8ARtCPDzeRfgWNI1G1mhmWaPEmBBAH4r2Dc2KvQuNQT9CfS/SDMfsKijEVdmfI7aB63/1FsnKhSxfSzH5zMEZVenkBrHU/NaNO+j1J1DFKezzS0IYn+nyMcbtahRpNCv525syTOCUFU4rwLEhaExc2VdRd0g6vDq1XFIc/QJP6CcmLT/aMHIt/6R3BmbYWr+P+2E2PxLjvMB7mprSLNbVkDI2r9z01xqEzQrsL2xj6XZ4jaNkuf2BuilrWf7X/Qmup5r+EPrxguIvWfCqSX/T/E6+TMa/AVNLVDwp9nIdB8pkWZxkVsU9J8mWXQ1JrH3PXDGmGapIDg9A6k1kiUNBfjm5IeVwmy2OKGC1Gxdvb0uAfvK5WE99lElYkUa6hjV/dlDmBTzNbf5jLukuHBYE9izcXbZuKP6rJ1OS4wJyGba5I2mEu7ZznPmkwoqE4qt
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7635d5ef-b442-4820-2db7-08d78c2a8705
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Dec 2019 06:44:17.6573 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: NyoKeUAMO4GzRMrs72ONxr49DjLxfP/VeP/uDv/bRqfu/qS71g7ECAEvs26z5LWOVQ0aLDMMlCV12mMjr39K2Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR12MB1455
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

> -----Original Message-----
> From: Quan, Evan <Evan.Quan@amd.com>
> Sent: Thursday, December 26, 2019 3:11 AM
> To: amd-gfx@lists.freedesktop.org
> Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Quan, Evan
> <Evan.Quan@amd.com>
> Subject: [PATCH 2/2] drm/amdgpu: avoid unnecessary SMC firmware
> reloading
> 
> E.g. During non-RAS baco reset, the SMC is still alive.
> Thus there is no need to reload the SMC firmware.
> 
> Change-Id: I73f6284541d0ca0e82761380a27e32484fb0061c
> Signed-off-by: Evan Quan <evan.quan@amd.com>


Acked-by: Alex Deucher <alexander.deucher@amd.com>

> ---
>  drivers/gpu/drm/amd/amdgpu/psp_v11_0.c | 14 ++++++++++++++
>  1 file changed, 14 insertions(+)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/psp_v11_0.c
> b/drivers/gpu/drm/amd/amdgpu/psp_v11_0.c
> index c66ca8cc2ebd..ba761e9366e3 100644
> --- a/drivers/gpu/drm/amd/amdgpu/psp_v11_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/psp_v11_0.c
> @@ -676,6 +676,19 @@ static bool psp_v11_0_compare_sram_data(struct
> psp_context *psp,
>  	return true;
>  }
> 
> +/*
> + * Check whether SMU is still alive. If that's true
> + * (e.g. for non-RAS baco reset), we need to skip SMC firmware reloading.
> + */
> +static bool psp_v11_0_smu_reload_quirk(struct psp_context *psp) {
> +	struct amdgpu_device *adev = psp->adev;
> +	uint32_t reg;
> +
> +	reg = RREG32_PCIE(smnMP1_FIRMWARE_FLAGS | 0x03b00000);
> +	return (reg &
> MP1_FIRMWARE_FLAGS__INTERRUPTS_ENABLED_MASK) ? true :
> +false; }
> +
>  static int psp_v11_0_mode1_reset(struct psp_context *psp)  {
>  	int ret;
> @@ -1070,6 +1083,7 @@ static const struct psp_funcs psp_v11_0_funcs = {
>  	.ring_stop = psp_v11_0_ring_stop,
>  	.ring_destroy = psp_v11_0_ring_destroy,
>  	.compare_sram_data = psp_v11_0_compare_sram_data,
> +	.smu_reload_quirk = psp_v11_0_smu_reload_quirk,
>  	.mode1_reset = psp_v11_0_mode1_reset,
>  	.xgmi_get_topology_info = psp_v11_0_xgmi_get_topology_info,
>  	.xgmi_set_topology_info = psp_v11_0_xgmi_set_topology_info,
> --
> 2.24.0
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
