Return-Path: <SRS0=k5/X=43=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E17DC10DCE
	for <amd-gfx@archiver.kernel.org>; Tue, 10 Mar 2020 06:10:32 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5697F24679
	for <amd-gfx@archiver.kernel.org>; Tue, 10 Mar 2020 06:10:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="zEVOxiB5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5697F24679
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C10556E34A;
	Tue, 10 Mar 2020 06:10:31 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2067.outbound.protection.outlook.com [40.107.220.67])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 932FB6E34A
 for <amd-gfx@lists.freedesktop.org>; Tue, 10 Mar 2020 06:10:30 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SvUUa9/8o3ad+S/cgfnPzX+TyrXpcOTfBx9UHCtqCRaXCZH3v8BRA5i5MwDCmbMgR/Mv9F9SDXiwwkox82+A83PRcdlXhRmYUeGhqIKhYk6n1BKkPiFvaHjs1zs4zxR8qPD/1tP+l6S2mr4GNv71uoZE57PVIo1pXfssxC1JSp3ihFG17vSvOKB9X9RAf9TKEe2XXdozPZrovm7/wezs1aVISUWNS3qsv4quLgbmRgf9UHVvDYcgNUHhsRgrUJlSPColoJaOsm7hnG/s3SEVTWVEynpKgMOtVV2tdHHGfoYhdHYGZWETIwWdPKd5IXCgUQ7dG2uNL/vGihAViQvxAw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JV2bYxRWB+q1nNybKdaBXOG0bGBrgZhrXB6fG1mn4OE=;
 b=Ox1Y4siyCXAWNuQFXQ+y2Xdf5N5AVIISFJdEMJH/GCVNQ2TLQ+i2Cs1aS1G64plaewuyvlb+X7HwT40kcxF/waJK0LrCtEbAODiH1pBma+TWAxBEyLG1bXJhrc6slhytJDZFE4ObyerptObWv4T1ck5WauG7GpztiKI2uybQdFdstDX1QuDD3jxhROazalWzAKZfYN1fOc2hjUX+7nafB3doaWsPQ9c0V6i45zE7FLQqnrVD71Gk/LR9BeDjsql5HkvwtKo6jQJZ7JaEG8b/4+l3hqRZf86SLgYjLDiw2/MhkxgsH0glYd2Ve2cTKfD+2hoKMDY6gkWY1Atot3Z9lg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JV2bYxRWB+q1nNybKdaBXOG0bGBrgZhrXB6fG1mn4OE=;
 b=zEVOxiB5FNQueyx4KebNLsYwbGB7bxOwVXBDt7CAbJPb0MxWQj9sz3QOVTVpNCoPhdJD1kAjGsNx15OZr/peTi2jKQjE4HP/qSimKKbjp4st5hZEEH2T50320lBE9aem2zdA8u6yWT7DEtyDasTDa3JQcOy4GCTy+IxZiUH38fc=
Received: from MWHPR12MB1837.namprd12.prod.outlook.com (2603:10b6:300:113::20)
 by MWHPR12MB1149.namprd12.prod.outlook.com (2603:10b6:300:c::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2793.17; Tue, 10 Mar
 2020 06:10:29 +0000
Received: from MWHPR12MB1837.namprd12.prod.outlook.com
 ([fe80::84e2:7919:afcd:a928]) by MWHPR12MB1837.namprd12.prod.outlook.com
 ([fe80::84e2:7919:afcd:a928%10]) with mapi id 15.20.2793.013; Tue, 10 Mar
 2020 06:10:29 +0000
From: "Yang, Stanley" <Stanley.Yang@amd.com>
To: "Zhou1, Tao" <Tao.Zhou1@amd.com>, "Quan, Evan" <Evan.Quan@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amdgpu: check for the existence of RAS dir before
 creating
Thread-Topic: [PATCH] drm/amdgpu: check for the existence of RAS dir before
 creating
Thread-Index: AQHV9pyn2uzUZIWwQUW4aBG5SVzh7qhBTxGAgAAGw3A=
Date: Tue, 10 Mar 2020 06:10:28 +0000
Message-ID: <MWHPR12MB1837D15A8A90A52397EFC3A89AFF0@MWHPR12MB1837.namprd12.prod.outlook.com>
References: <20200310052614.22208-1-evan.quan@amd.com>
 <MN2PR12MB3054A7246FCEFB9A2BB1742EB0FF0@MN2PR12MB3054.namprd12.prod.outlook.com>
In-Reply-To: <MN2PR12MB3054A7246FCEFB9A2BB1742EB0FF0@MN2PR12MB3054.namprd12.prod.outlook.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Enabled=true;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SetDate=2020-03-10T05:38:34Z; 
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Method=Standard;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Name=Internal Use Only -
 Unrestricted;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ActionId=7e3509de-497f-4903-ae84-0000feec9fca;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ContentBits=1
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_enabled: true
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_setdate: 2020-03-10T06:10:25Z
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_method: Standard
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_name: Internal Use Only -
 Unrestricted
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_actionid: 49ecd9ec-ac88-447e-be35-0000cd68bbef
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_contentbits: 0
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Stanley.Yang@amd.com; 
x-originating-ip: [180.167.199.189]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 2d5e9786-6778-4784-6049-08d7c4b9bb8f
x-ms-traffictypediagnostic: MWHPR12MB1149:|MWHPR12MB1149:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MWHPR12MB11495908DC7FCD256BAEE0339AFF0@MWHPR12MB1149.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:5516;
x-forefront-prvs: 033857D0BD
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10001)(10009020)(4636009)(366004)(376002)(396003)(346002)(39830400003)(136003)(189003)(199004)(26005)(7696005)(8676002)(6506007)(316002)(8936002)(81166006)(5660300002)(2906002)(81156014)(53546011)(45080400002)(52536014)(33656002)(966005)(66446008)(55016002)(66476007)(66556008)(86362001)(4326008)(66946007)(186003)(71200400001)(110136005)(76116006)(64756008)(9686003)(478600001)(54906003);
 DIR:OUT; SFP:1101; SCL:1; SRVR:MWHPR12MB1149;
 H:MWHPR12MB1837.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: cQCUlSIbccwx7wDH+Lzp8Ft19fq1c7CoftfLxfzqCt+op9/Gn5VEQNCYX8IU1lX1dA8HllE3azkt/3+9VBodSipIg6+yOT0OEhsXHvSY2UANHMcqI9LSqUURRJ0/AtHHTpKxwvJhZPjShnyLGn6GdnHGdpCC3+V9Ag8ypvDD+r6L8R7PHBFSbQsMBc9wTL2KBNDeQ4IbQ3bgrAr0BxcF3p+ACYziqvHg1H3H9QFFtwZ1HE+QN6SOipZQIif3FVRlLLEqBZ5pLieBbtWHsw7pkc2bn60plosmeRT2ow06stGmjOwz847yzZa3JoA4OOEOt9lVyuOfG/fOUl0anIASz1qaRkv0t5OYl7/QGfhEXK7e2EESly7cwxIO9BuqITJqdf9fcCtXM8D5JscVEUaBfgUo1vDS/63yG6AsDGMkR7hWWIPdV6PLcDMsUvAOQ8KiNMWFRMXqKbpYT7X7H3DM9AepBAbz2WntovI0W0y73macUU7HZn7DAR76LhSyt2Lu2/+h2Be1Xr3GbQ9J0/ilh7NIVWCoWL5r3osPJFyTfC1HtR++NUC/ZtTBQ+JhP2htTGP24/ho44Y/zxIQmrO4ySOhsTTzhUWaCderSGdL0VlYw1yr1ztKwICjjCpJdqbY
x-ms-exchange-antispam-messagedata: CiUTHa91aQ0TRji4K2h2MeoFvzlLAwF1whzWJOmr7WECH7Ew7Cc54/zgrGGWe6QWeUOzsyCwCs5+DmviLat4SIlHeGMjRiPhhmADgIng7byi0nv7RHqqVG9N1+C3ERD99GEgAbK6F2FfjgQX9fvoQA==
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2d5e9786-6778-4784-6049-08d7c4b9bb8f
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Mar 2020 06:10:28.9844 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: qbU/24EOtfs0/Oa1tPeC4Ctw/Ij8YAddVNhrICobh6w5LN/MgFO11O56P2zXxLERdlm0m6JjjDGjJz4RG7fhhg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR12MB1149
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
Cc: "Quan, Evan" <Evan.Quan@amd.com>, "Zhang, Hawking" <Hawking.Zhang@amd.com>
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Official Use Only - Internal Distribution Only]

centralize all debugfs creation in one place for ras

Signed-off-by: Tao Zhou <tao.zhou1@amd.com>
Signed-off-by: Stanley.Yang <Stanley.Yang@amd.com>
Change-Id: I7489ccb41dcf7a11ecc45313ad42940474999d81

Patches have been pushed to branch.

Regards,
Stanley

-----Original Message-----
From: Zhou1, Tao <Tao.Zhou1@amd.com> 
Sent: Tuesday, March 10, 2020 1:39 PM
To: Quan, Evan <Evan.Quan@amd.com>; amd-gfx@lists.freedesktop.org; Yang, Stanley <Stanley.Yang@amd.com>
Cc: Quan, Evan <Evan.Quan@amd.com>; Zhang, Hawking <Hawking.Zhang@amd.com>
Subject: RE: [PATCH] drm/amdgpu: check for the existence of RAS dir before creating

[AMD Official Use Only - Internal Distribution Only]

The issue is fixed by:

centralize all debugfs creation in one place for ras

Signed-off-by: Tao Zhou <tao.zhou1@amd.com>
Signed-off-by: Stanley.Yang <Stanley.Yang@amd.com>
Change-Id: I7489ccb41dcf7a11ecc45313ad42940474999d81

Hi Stanley:

Have you pushed the patch?

Regards,
Tao

> -----Original Message-----
> From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of 
> Evan Quan
> Sent: 2020年3月10日 13:26
> To: amd-gfx@lists.freedesktop.org
> Cc: Quan, Evan <Evan.Quan@amd.com>; Zhang, Hawking 
> <Hawking.Zhang@amd.com>
> Subject: [PATCH] drm/amdgpu: check for the existence of RAS dir before 
> creating
> 
> To address the error message below:
> debugfs: Directory 'ras' with parent '/' already present!
> 
> Change-Id: I2539e89fdfe4e22055c3be5a48a8c0adad315f91
> Signed-off-by: Evan Quan <evan.quan@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
> index e1e8fd4b2b89..2195f6c63b50 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
> @@ -1075,7 +1075,9 @@ static void
> amdgpu_ras_debugfs_create_ctrl_node(struct amdgpu_device *adev)
>  	struct amdgpu_ras *con = amdgpu_ras_get_context(adev);
>  	struct drm_minor *minor = adev->ddev->primary;
> 
> -	con->dir = debugfs_create_dir("ras", minor->debugfs_root);
> +	con->dir = debugfs_lookup("ras", minor->debugfs_root);
> +	if (!con->dir)
> +		con->dir = debugfs_create_dir("ras", minor->debugfs_root);
>  	debugfs_create_file("ras_ctrl", S_IWUGO | S_IRUGO, con->dir,
>  				adev, &amdgpu_ras_debugfs_ctrl_ops);
>  	debugfs_create_file("ras_eeprom_reset", S_IWUGO | S_IRUGO, con-
> >dir,
> --
> 2.25.1
> 
> _______________________________________________
> amd-gfx mailing list
> amd-gfx@lists.freedesktop.org
> https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Flist
> s.f
> reedesktop.org%2Fmailman%2Flistinfo%2Famd-
> gfx&amp;data=02%7C01%7Ctao.zhou1%40amd.com%7C9b53a604785f4aa69
> 01808d7c4b39d50%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C
> 637194148679373493&amp;sdata=j9L0ibbh%2Fl9btsZCwOQK0D86Nrp1xR%2
> BTZWCixnSDY%2FY%3D&amp;reserved=0
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
