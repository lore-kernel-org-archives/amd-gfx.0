Return-Path: <SRS0=l0jK=2O=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3162FC2D0C0
	for <amd-gfx@archiver.kernel.org>; Tue, 24 Dec 2019 02:03:30 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EDDD32070E
	for <amd-gfx@archiver.kernel.org>; Tue, 24 Dec 2019 02:03:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="qm+0nefQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EDDD32070E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 70A77897BC;
	Tue, 24 Dec 2019 02:03:29 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2058.outbound.protection.outlook.com [40.107.220.58])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 51ABF897BC
 for <amd-gfx@lists.freedesktop.org>; Tue, 24 Dec 2019 02:03:28 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eiTpilmTzXUvcxGBjt0Eip4KJ4UpTe6EkJGRtcv5/poQrsugTrZBtDiCWLMShjb9G4hYpbKJIBrQ5t2DVPE6jpFff9UWsoHPp0uTWdUVfTYId0cVEcHYqzbptIVUSXNf4XOSTs04Hl393H+UpZGQzp0eJaw2tWj+DhqpqJIkafsucXn4tGReOtAC2DtGW/FrOpIiVMjiibyeHn9/+UMWlWNeWcXlCXoWqQO/x9ak3iMIQCyLl/aoCSbIEWHbnLpiRXOhbjgvISqm4zixVVtV6hFfK+W5rNrqNhetyH/ZQwpl8Eqox3i0mLPTa7qtn0BWnD58j0WFTNGkW4uTKAqcsg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1wj0ba7/nkSudhhZSSW2uMS2GtxaKOJpEfCAqjVHkHw=;
 b=BWKvmklI7UnUD+B1cRIRjAKSafs/G/rGIgKteBaq4Rz5oi2+Imxn2DBo+GgpI557AsRF6BceU1lPgXk4Idpe7bXOQ12XZzSj1OpeGUvys9fquiDcBOGftKbuKXlD7ulQF7R4/v1M6TRb92hFsvf47Qwug6W+/EAnQx3Y20wmVgXYp+waVsCDaEAXhukXqVwBqzBseKZogS6i+GohEKCul4o93TCrcTFgqaBse/cjK7Er2xUMuXjWv2j7u1+ToTTinqtJvy5Z3eBUCdkggdpyEBRHy+ijW33sOlypqtQfJhvH7LO17+R20bOMJ1b/uFROzEgnWq67JLPUS3GWFPNtRQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1wj0ba7/nkSudhhZSSW2uMS2GtxaKOJpEfCAqjVHkHw=;
 b=qm+0nefQMcPqUcwqoq8SCDCLKl3GbvImOBZ3mpRkA5an66qNQK5FMzkqnYzQPqFRUcP8UiAB5tc2qsq9ygcgeBdcPGbdaKyf55iY6LgmkAciz8trwEF1mKohmKgiQ8StZTO5rsVzUVM+lmQKwUHrzyXspStzkidY/n2SBBYvv4M=
Received: from MN2PR12MB3344.namprd12.prod.outlook.com (20.178.241.74) by
 MN2PR12MB3278.namprd12.prod.outlook.com (20.179.81.19) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2559.16; Tue, 24 Dec 2019 02:03:24 +0000
Received: from MN2PR12MB3344.namprd12.prod.outlook.com
 ([fe80::1010:4621:68dd:5b47]) by MN2PR12MB3344.namprd12.prod.outlook.com
 ([fe80::1010:4621:68dd:5b47%5]) with mapi id 15.20.2559.017; Tue, 24 Dec 2019
 02:03:24 +0000
From: "Quan, Evan" <Evan.Quan@amd.com>
To: Alex Deucher <alexdeucher@gmail.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] Revert "drm/amdgpu: simplify ATPX detection"
Thread-Topic: [PATCH] Revert "drm/amdgpu: simplify ATPX detection"
Thread-Index: AQHVt5NIsYLYD/il+UG4xU5t5zeeQ6fIjWDQ
Date: Tue, 24 Dec 2019 02:03:24 +0000
Message-ID: <MN2PR12MB33442448E124529080EE9CBAE4290@MN2PR12MB3344.namprd12.prod.outlook.com>
References: <20191221001142.1338192-1-alexander.deucher@amd.com>
In-Reply-To: <20191221001142.1338192-1-alexander.deucher@amd.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ActionId=5ba1f840-a618-472f-8c01-000066a3c689;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ContentBits=0;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Enabled=true;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Method=Standard;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Name=Internal
 Use Only - Unrestricted;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SetDate=2019-12-24T02:02:59Z;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Evan.Quan@amd.com; 
x-originating-ip: [180.167.199.189]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 4c9ed7bf-31c4-46ae-df22-08d788157589
x-ms-traffictypediagnostic: MN2PR12MB3278:|MN2PR12MB3278:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MN2PR12MB3278FC398EEFD15CB7A67E91E4290@MN2PR12MB3278.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:20;
x-forefront-prvs: 0261CCEEDF
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(4636009)(39860400002)(136003)(346002)(366004)(396003)(376002)(13464003)(189003)(199004)(5660300002)(53546011)(66446008)(55016002)(45080400002)(478600001)(66946007)(966005)(66556008)(66476007)(64756008)(6506007)(2906002)(110136005)(52536014)(9686003)(4326008)(7696005)(33656002)(86362001)(316002)(71200400001)(26005)(8936002)(81166006)(76116006)(81156014)(8676002)(186003);
 DIR:OUT; SFP:1101; SCL:1; SRVR:MN2PR12MB3278;
 H:MN2PR12MB3344.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: /qOq3VJ0V+T38OaUHLaxqd0FLOvSHoarXWU9UY8WRmnM9evNJovRFhZslkz1s50CByLxTUbWlIv5S2o4RE8vJxsLqQCFFQT4tBotsKA58e06koBf7oJ8FlaO/pbP5rDrDNDGA9ZKA57nXLDWKwqe64HnKSA3DHcJPIz18WYyTMnIuTjRih47N1HzokdO3DER8CmjEWCRV91q9yEwSAQY7khAyKvFfnINx6XCM2xiJW4HOZl7fTcK6kqZDn0xerRGWJpocwBKg0yQGw3iNl3P5cF6YQqy4YCQ2zaKLqwZCZM6cfDvOpc5lUp1nohKr6HcM76lqCgoh5P+cPWsw2TzMZseLl67nuFD3jJ2koT4yZNb0uSiODKqHxjYDO9nqX4E2ZI+e4i5Ln5ywVkjTsWKZxZNcYUP4Jv2uKTxFHhtglX6tuqzQTDu8Bw/G09HJFX1nhcILPlYsWDNy/SltkPV4arRYEDoKyOtX7AiKGBLCTMRBDsRIMc1iFg8uGMVVPVNKtIVJNcy/h5BzrjvdsLoI1Vp+jFHtjSicus2dtOfLE8=
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4c9ed7bf-31c4-46ae-df22-08d788157589
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Dec 2019 02:03:24.2365 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: VLzFp8LNAk/T5C6/rHcPLtZSnv/wTka9YM7LeY2AdrShQc/9ppZve+/1/Nc0hvUM
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3278
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
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Acked-by: Evan Quan <evan.quan@amd.com>

> -----Original Message-----
> From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Alex
> Deucher
> Sent: Saturday, December 21, 2019 8:12 AM
> To: amd-gfx@lists.freedesktop.org
> Cc: Deucher, Alexander <Alexander.Deucher@amd.com>
> Subject: [PATCH] Revert "drm/amdgpu: simplify ATPX detection"
> 
> This reverts commit f5fda6d89afe6e9cedaa1c3303903c905262f6e8.
> 
> You can't use BASE_CLASS in pci_get_class.
> 
> Bug:
> https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Fgitlab.fre
> edesktop.org%2Fdrm%2Famd%2Fissues%2F995&amp;data=02%7C01%7Cevan.q
> uan%40amd.com%7C2347975d48674464206608d785aa63d1%7C3dd8961fe488
> 4e608e11a82d994e183d%7C0%7C0%7C637124839286316424&amp;sdata=iIVA
> BG6tvVYviqAYF8ywRM41C82TNkr1PGgj8%2BAjGjQ%3D&amp;reserved=0
> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_atpx_handler.c | 12 +++++++++++-
>  1 file changed, 11 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_atpx_handler.c
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_atpx_handler.c
> index a97fb759e2f4..3e35a8f2c5e5 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_atpx_handler.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_atpx_handler.c
> @@ -613,7 +613,17 @@ static bool amdgpu_atpx_detect(void)
>  	bool d3_supported = false;
>  	struct pci_dev *parent_pdev;
> 
> -	while ((pdev = pci_get_class(PCI_BASE_CLASS_DISPLAY << 16, pdev)) !=
> NULL) {
> +	while ((pdev = pci_get_class(PCI_CLASS_DISPLAY_VGA << 8, pdev)) !=
> NULL) {
> +		vga_count++;
> +
> +		has_atpx |= (amdgpu_atpx_pci_probe_handle(pdev) == true);
> +
> +		parent_pdev = pci_upstream_bridge(pdev);
> +		d3_supported |= parent_pdev && parent_pdev->bridge_d3;
> +		amdgpu_atpx_get_quirks(pdev);
> +	}
> +
> +	while ((pdev = pci_get_class(PCI_CLASS_DISPLAY_OTHER << 8,
> pdev)) != NULL) {
>  		vga_count++;
> 
>  		has_atpx |= (amdgpu_atpx_pci_probe_handle(pdev) == true);
> --
> 2.24.1
> 
> _______________________________________________
> amd-gfx mailing list
> amd-gfx@lists.freedesktop.org
> https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Flists.free
> desktop.org%2Fmailman%2Flistinfo%2Famd-
> gfx&amp;data=02%7C01%7Cevan.quan%40amd.com%7C2347975d4867446420
> 6608d785aa63d1%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637
> 124839286316424&amp;sdata=HAa2GZfLSVJnQzPSxwYadxXvaKUIhLIQ30REX%2
> FJN6gU%3D&amp;reserved=0
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
