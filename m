Return-Path: <SRS0=ErGV=EQ=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A15CC4741F
	for <amd-gfx@archiver.kernel.org>; Tue, 10 Nov 2020 17:58:01 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EDCC920781
	for <amd-gfx@archiver.kernel.org>; Tue, 10 Nov 2020 17:58:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="RamWPQbA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EDCC920781
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4E6DD89B7B;
	Tue, 10 Nov 2020 17:58:00 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2048.outbound.protection.outlook.com [40.107.93.48])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CFF6489B7B
 for <amd-gfx@lists.freedesktop.org>; Tue, 10 Nov 2020 17:57:58 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Q+/p07C+WMvBjF89FZQdFQ02iMcXv15O+ODNiu/s3rWRjUAcEACVULrAnnEZvPzNSwWJL76wtRREMIF8veKzZsZvp1d5AwuVH+8QtCl/58k+lAr3VHWK8TCV3ZwRQOBE96mE+6QclSFdY2b26pxn3p3OyXSOI8fouZlO1D4PgLfQW0j2RPJuXbT64uJoxMIJhkDnJ3ShuRx8kouZFr8IkylKmYScLADlh71+1ve3LBSl4losXtgJ9boIKQQODyyLJmAoTHw2yDbUWIdQ7K9Bklyqoz+UBN7PL5b/hXCBUlQ8PvDklavrowEXGEQGC7/sskskQEG3yUUJ8pUDAlWthA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lGYaKieUfoywGCpnXxI9l18+qopGMAGzdga5CS0wXHc=;
 b=d0WauOJCIoZL/n9dm2VJUAakmUr7n4KrOni7rJkPh52i5y9zp/zO2hjgBxuQJmwp1dtwUUIPCxcfjJkQLwRDsAQWZNPx4xjMTLYBcp4TniE3dIS3JJTDRd+zl71jPLRc7fBrfEvzJsVdWlONA2QhPlxnLXEaKtaXXcnP2C1ZWx70/ks2+8SJ3WCdgtaP+AHQpkVAx7CB/rT2TN+wYDFOlaDAersTNGyDK+AykWoB8Mun4yEGJDKONat8ivEW87yQw2CF1qID1q2pYTHgDt0O8EoBbm/5+fPlgLFpDRnDLGNwugVBmQdO8bPpCju7aiHj9NJlXZfjjcCkoJsq1XFykA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lGYaKieUfoywGCpnXxI9l18+qopGMAGzdga5CS0wXHc=;
 b=RamWPQbA56FhbIZCm8Jzor52MKOxyn8auacxFcnLMQsZpQoTBrBiq7GAIvr76Q9peGWIwVdjX6UqqSPa1M3/gKVYCNbUfsx1xTvqx87RmfsEiPHRLAkt+aOlTF6VcTRNLxwHU5Lk6ZVPFc4T5h9piRRcqTllDn05pkb2riJiG4c=
Received: from SA0PR12MB4430.namprd12.prod.outlook.com (2603:10b6:806:70::20)
 by SN1PR12MB2415.namprd12.prod.outlook.com (2603:10b6:802:26::23)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3541.25; Tue, 10 Nov
 2020 17:57:57 +0000
Received: from SA0PR12MB4430.namprd12.prod.outlook.com
 ([fe80::d436:e21c:e4e8:7deb]) by SA0PR12MB4430.namprd12.prod.outlook.com
 ([fe80::d436:e21c:e4e8:7deb%5]) with mapi id 15.20.3541.025; Tue, 10 Nov 2020
 17:57:57 +0000
From: "Sierra Guiza, Alejandro (Alex)" <Alex.Sierra@amd.com>
To: "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>, "Koenig, 
 Christian" <Christian.Koenig@amd.com>
Subject: RE: [PATCH] drm/amdgpu: enable 48-bit IH timestamp counter
Thread-Topic: [PATCH] drm/amdgpu: enable 48-bit IH timestamp counter
Thread-Index: AQHWt4q3ou1EC75tmEeDMM+MBGzIwqnBpn+Q
Date: Tue, 10 Nov 2020 17:57:57 +0000
Message-ID: <SA0PR12MB4430DF99234F8097DE57FBF5FDE90@SA0PR12MB4430.namprd12.prod.outlook.com>
References: <20201110175519.21308-1-alex.sierra@amd.com>
In-Reply-To: <20201110175519.21308-1-alex.sierra@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Enabled=true;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_SetDate=2020-11-10T17:57:49Z; 
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Method=Privileged;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Name=Public_0;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_ActionId=6e31ca63-d8c5-4015-a751-0000ca307b4c;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_ContentBits=1
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_enabled: true
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_setdate: 2020-11-10T17:57:40Z
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_method: Standard
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_name: Internal Use Only -
 Unrestricted
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_actionid: 4c6fe959-e84e-4833-b514-0000c18f29e9
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_contentbits: 0
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_enabled: true
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_setdate: 2020-11-10T17:57:55Z
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_method: Privileged
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_name: Public_0
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_actionid: 601d1a5e-cfdc-423e-9ac6-0000da6babbc
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_contentbits: 0
authentication-results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
x-originating-ip: [165.204.78.25]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 2cda9625-d01c-45f8-5d23-08d885a2280e
x-ms-traffictypediagnostic: SN1PR12MB2415:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <SN1PR12MB24156FB8E7E5EDA802EDF9F4FDE90@SN1PR12MB2415.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:3276;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: n88s2D4yMDfALcW30V/YhEcJhsGdR/ycMGrG3pI2rjIGnKvcxKlgwknDayONY2r3KUrKfnU3mQgrpdFroRkmoi8bmIgKkIAHtB9Iv7pTY6t4Tyl0orsBEiMsgX1tZleWHS48+Zdi//6xOTVaTDYJDXNbODwaCbuV3o0r8MPoUam12VCW004ripDv1HMm5QmMj+crOJGnw61No5lCgF+HMbwYPPdLpd76ST+DiNrHwhwi2Vh1aWbpEdZmXGDpzPLvTVMiNo+69ObiXzzyVk69DCbrAQz3vNnSJ7gYf8oyEKsRzBOa5wTQGfKrHmio2v8eTW1Xi9/GpqPjGN5xujm8RQ==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SA0PR12MB4430.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(39860400002)(376002)(346002)(136003)(396003)(66446008)(71200400001)(186003)(8676002)(4326008)(66476007)(55016002)(7696005)(8936002)(53546011)(66946007)(2906002)(64756008)(66556008)(86362001)(9686003)(110136005)(26005)(52536014)(5660300002)(6636002)(316002)(6506007)(83380400001)(76116006)(478600001)(33656002);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: iDdI6i40rGyKt1Mp9Rf5UbirIwDPqavdLg6NkUIChTCDMqnVNWdbLEWaSTAWP/qJIgJ6NBbQUrTugkvXTAwQR4wKqNoTqMLHF3SKBUraPGv4GM98erKuw3v9ATA7GLxF306pF0onVlaUKQEgTC/4RIcRqJ4R6Ya5VKE6wws4LfP+o2UPF69CQAMK9NYDwswOXHEWqCp4rkKcprvJnXrHoxQUAQtZdQy/BEgjcgxE3sTQ9L9iYk4JSyLYtnIr2cyzg5Z90Hbh0epNO2zrWxr8JdTNcTYlHVzL1GUVcpDQcvftBWPuC4MMnhHBUfIwe7oSPOqaF9v/h/nv+tHpZPEb/LRN7inozHPlZvRw7KL2UlR3cGZr/FCiYykvVmrqNdsi1XJfZ9NqZaKOQ5xLhuDyZWUGGefAN64rTfbGt8c5MeR07lwO3wrAES1XZD2GL5LCjyHKbbtaLrogyyGM12JTB8oBPoKsRL426wunPO1n3uDLKFGlsj0TtWt+y6v6TqcNYiOYvsMWWY9t9LC4J12tCnMYnBofoo2TfkkGJai3c1EiIe2erXXskX0/yIFLcK3Qk7QaIQ/ECIIc4Y0AUYvsUDiV1FlxdSarU5at2w6vTYE6/itnu7sIadPnohquuYg7+/7oEUFKtg/W9e7tPDQjoh/7FZIy4Mh271Th9ypRDSmOOvo5wL4aRINvkmmTXnZIzqHxReAGJFG7mD/gQP+K1lFh9VXCEuQkrPe7Sw5WmFejHOkUBo4rKEG+sF9eyZfxSwf1Lp/Yt1UZV7+hSW47soTlcABCoGtEguUqMdle/slLZafBPt6n0663oAPKylcwWMLJet4BK9ROudu1Qsar3cxNIC1ifSyk88xyiRvl5m7PeReg42/jd71pWeKtInbe2414NQgHEEwiWlOTBx673g==
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA0PR12MB4430.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2cda9625-d01c-45f8-5d23-08d885a2280e
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Nov 2020 17:57:57.4687 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: F9OHDhEGgACPYCrug4Xzd92aSacIYsBKmrepkvqNNux58mYQFWHi4RKg9mTdd6TdJq3MuCzv88kylOmzXYxb8Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN1PR12MB2415
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
Cc: "Kuehling, Felix" <Felix.Kuehling@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Public Use]

I just added support for vega10_ih too.

Regards,
Alex

> -----Original Message-----
> From: Sierra Guiza, Alejandro (Alex) <Alex.Sierra@amd.com>
> Sent: Tuesday, November 10, 2020 11:55 AM
> To: amd-gfx@lists.freedesktop.org
> Cc: Koenig, Christian <Christian.Koenig@amd.com>; Kuehling, Felix
> <Felix.Kuehling@amd.com>; Sierra Guiza, Alejandro (Alex)
> <Alex.Sierra@amd.com>
> Subject: [PATCH] drm/amdgpu: enable 48-bit IH timestamp counter
> 
> By default this timestamp is based on a 32 bit counter.
> This is used by the amdgpu_gmc_filter_faults, to avoid process the same
> interrupt in retry configuration.
> Apparently there's a problem when the timestamp coming from IH overflows
> and compares against timestamp coming from the the hash table.
> This patch only extends the time overflow from 10 minutes to aprx 455 days.
> 
> Signed-off-by: Alex Sierra <alex.sierra@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/navi10_ih.c | 6 ++++++
> drivers/gpu/drm/amd/amdgpu/vega10_ih.c | 6 ++++++
>  2 files changed, 12 insertions(+)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/navi10_ih.c
> b/drivers/gpu/drm/amd/amdgpu/navi10_ih.c
> index 837769fcb35b..bda916f33805 100644
> --- a/drivers/gpu/drm/amd/amdgpu/navi10_ih.c
> +++ b/drivers/gpu/drm/amd/amdgpu/navi10_ih.c
> @@ -94,6 +94,8 @@ static void navi10_ih_enable_interrupts(struct
> amdgpu_device *adev)
> 
>  	ih_rb_cntl = REG_SET_FIELD(ih_rb_cntl, IH_RB_CNTL, RB_ENABLE, 1);
>  	ih_rb_cntl = REG_SET_FIELD(ih_rb_cntl, IH_RB_CNTL, ENABLE_INTR,
> 1);
> +	ih_rb_cntl = REG_SET_FIELD(ih_rb_cntl, IH_RB_CNTL,
> +				   RB_GPU_TS_ENABLE, 1);
>  	if (amdgpu_sriov_vf(adev) && adev->asic_type < CHIP_NAVI10) {
>  		if (psp_reg_program(&adev->psp, PSP_REG_IH_RB_CNTL,
> ih_rb_cntl)) {
>  			DRM_ERROR("PSP program IH_RB_CNTL failed!\n");
> @@ -109,6 +111,8 @@ static void navi10_ih_enable_interrupts(struct
> amdgpu_device *adev)
>  		ih_rb_cntl = RREG32_SOC15(OSSSYS, 0,
> mmIH_RB_CNTL_RING1);
>  		ih_rb_cntl = REG_SET_FIELD(ih_rb_cntl, IH_RB_CNTL_RING1,
>  					   RB_ENABLE, 1);
> +		ih_rb_cntl = REG_SET_FIELD(ih_rb_cntl, IH_RB_CNTL_RING1,
> +					   RB_GPU_TS_ENABLE, 1);
>  		if (amdgpu_sriov_vf(adev) && adev->asic_type <
> CHIP_NAVI10) {
>  			if (psp_reg_program(&adev->psp,
> PSP_REG_IH_RB_CNTL_RING1,
>  						ih_rb_cntl)) {
> @@ -125,6 +129,8 @@ static void navi10_ih_enable_interrupts(struct
> amdgpu_device *adev)
>  		ih_rb_cntl = RREG32_SOC15(OSSSYS, 0,
> mmIH_RB_CNTL_RING2);
>  		ih_rb_cntl = REG_SET_FIELD(ih_rb_cntl, IH_RB_CNTL_RING2,
>  					   RB_ENABLE, 1);
> +		ih_rb_cntl = REG_SET_FIELD(ih_rb_cntl, IH_RB_CNTL_RING2,
> +					   RB_GPU_TS_ENABLE, 1);
>  		if (amdgpu_sriov_vf(adev) && adev->asic_type <
> CHIP_NAVI10) {
>  			if (psp_reg_program(&adev->psp,
> PSP_REG_IH_RB_CNTL_RING2,
>  						ih_rb_cntl)) {
> diff --git a/drivers/gpu/drm/amd/amdgpu/vega10_ih.c
> b/drivers/gpu/drm/amd/amdgpu/vega10_ih.c
> index 407c6093c2ec..35d68bc5d95e 100644
> --- a/drivers/gpu/drm/amd/amdgpu/vega10_ih.c
> +++ b/drivers/gpu/drm/amd/amdgpu/vega10_ih.c
> @@ -50,6 +50,8 @@ static void vega10_ih_enable_interrupts(struct
> amdgpu_device *adev)
> 
>  	ih_rb_cntl = REG_SET_FIELD(ih_rb_cntl, IH_RB_CNTL, RB_ENABLE, 1);
>  	ih_rb_cntl = REG_SET_FIELD(ih_rb_cntl, IH_RB_CNTL, ENABLE_INTR,
> 1);
> +	ih_rb_cntl = REG_SET_FIELD(ih_rb_cntl, IH_RB_CNTL,
> +				   RB_GPU_TS_ENABLE, 1);
>  	if (amdgpu_sriov_vf(adev)) {
>  		if (psp_reg_program(&adev->psp, PSP_REG_IH_RB_CNTL,
> ih_rb_cntl)) {
>  			DRM_ERROR("PSP program IH_RB_CNTL failed!\n");
> @@ -64,6 +66,8 @@ static void vega10_ih_enable_interrupts(struct
> amdgpu_device *adev)
>  		ih_rb_cntl = RREG32_SOC15(OSSSYS, 0,
> mmIH_RB_CNTL_RING1);
>  		ih_rb_cntl = REG_SET_FIELD(ih_rb_cntl, IH_RB_CNTL_RING1,
>  					   RB_ENABLE, 1);
> +		ih_rb_cntl = REG_SET_FIELD(ih_rb_cntl, IH_RB_CNTL_RING1,
> +					   RB_GPU_TS_ENABLE, 1);
>  		if (amdgpu_sriov_vf(adev)) {
>  			if (psp_reg_program(&adev->psp,
> PSP_REG_IH_RB_CNTL_RING1,
>  						ih_rb_cntl)) {
> @@ -80,6 +84,8 @@ static void vega10_ih_enable_interrupts(struct
> amdgpu_device *adev)
>  		ih_rb_cntl = RREG32_SOC15(OSSSYS, 0,
> mmIH_RB_CNTL_RING2);
>  		ih_rb_cntl = REG_SET_FIELD(ih_rb_cntl, IH_RB_CNTL_RING2,
>  					   RB_ENABLE, 1);
> +		ih_rb_cntl = REG_SET_FIELD(ih_rb_cntl, IH_RB_CNTL_RING2,
> +					   RB_GPU_TS_ENABLE, 1);
>  		if (amdgpu_sriov_vf(adev)) {
>  			if (psp_reg_program(&adev->psp,
> PSP_REG_IH_RB_CNTL_RING2,
>  						ih_rb_cntl)) {
> --
> 2.17.1
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
