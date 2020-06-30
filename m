Return-Path: <SRS0=hrZh=AL=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F987C433DF
	for <amd-gfx@archiver.kernel.org>; Tue, 30 Jun 2020 12:00:02 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id ABD1B20702
	for <amd-gfx@archiver.kernel.org>; Tue, 30 Jun 2020 12:00:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="zBvO5J3j"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ABD1B20702
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4C33789DD3;
	Tue, 30 Jun 2020 12:00:01 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2078.outbound.protection.outlook.com [40.107.220.78])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4DED689DD3
 for <amd-gfx@lists.freedesktop.org>; Tue, 30 Jun 2020 11:59:58 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=I2mV00oCufgj06Bjt5TfbzYyghCRB8PWKsav3gXPeU3OyWci1typdHYTVQDMPNtdTdIAthYLEIWMH6fe2Cr/LdQV9p76AROXgg04oWWMfFvh7l6xWcpDD32NZLfPcAz8GiuhLiSz1IjODabu8N9se5Lf6OYJzZO3bDGk6TtZDN7ci7jPWU6svXu9/IiKevAawnghb6o9gXQJyatYMIjRhSIfaScQeU1Cees6ayKFIrpDWsYMyvNkBG1WrBX74K+0Dv9U1aGTPq+wvwYwhfVcn7Y4fd5ohcsS9BKjxoWAxEh59fpuRzXuDd61mGwVSRdnIJ8b5caGUmzDCVGJ7XAxhg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=y4PeEhKS3bIbgawon0NU6TKF2r+y9xiVbyABeloQUEc=;
 b=NnplZNPhKHb3zYqpoxF0IVzhJ9dKTHzhVyT61y27xQoWuCid03myY+vKKEC4qdXMI57Z0YJfgLyf6MwEOW3KhbD9lPstP5yEu6/nIeCXb3n67+DeTij38D60brK2VtqEIB9NskGhM425+QHWxhh/OrxhvQkXGjVPcu5epUyPRqdtHNy+ZkJrX/cVW+RlLGbB+yVqL/7Y3bDKG0GkjtPChvDNmAVAkqcA8YqJE/+8wsj93u86AT6Hc2FqporOXXHfEtw6SDks4vn/ioZsSt7RGVE8/h+jighfsxC16uQ1+GisX1Utz2zaXoRWAj2tQpjrrDtx4QCTj9kFXseQl2ZuFQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=y4PeEhKS3bIbgawon0NU6TKF2r+y9xiVbyABeloQUEc=;
 b=zBvO5J3jDEFaVmsIxsn5+p40k6TCpL4licLBPEP0V0PgASJf965r+7lH6dJH53CgybCqmSdchf2XmL9h+I3CJPBEpsfQh+eMskOQUwjDR57FfkCWkwd0I5xlLZn2zJxYdLn03ICaucWIxcW8KkBUKSby5P2tudmr4Qd6wbGNAks=
Received: from DM6PR12MB3721.namprd12.prod.outlook.com (10.255.172.82) by
 DM5PR12MB1210.namprd12.prod.outlook.com (10.168.237.136) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3131.25; Tue, 30 Jun 2020 11:59:52 +0000
Received: from DM6PR12MB3721.namprd12.prod.outlook.com
 ([fe80::e027:654c:5d9f:a648]) by DM6PR12MB3721.namprd12.prod.outlook.com
 ([fe80::e027:654c:5d9f:a648%3]) with mapi id 15.20.3131.028; Tue, 30 Jun 2020
 11:59:52 +0000
From: "Russell, Kent" <Kent.Russell@amd.com>
To: "Greathouse, Joseph" <Joseph.Greathouse@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amdkfd: Add Arcturus GWS support and fix VG10
Thread-Topic: [PATCH] drm/amdkfd: Add Arcturus GWS support and fix VG10
Thread-Index: AQHWToG3b3Yd6v+jHUi5syn3+OymV6jxDlBw
Date: Tue, 30 Jun 2020 11:59:52 +0000
Message-ID: <DM6PR12MB3721BBE5C48881F357B90E8B856F0@DM6PR12MB3721.namprd12.prod.outlook.com>
References: <20200630015526.197720-1-Joseph.Greathouse@amd.com>
In-Reply-To: <20200630015526.197720-1-Joseph.Greathouse@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Enabled=true;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_SetDate=2020-06-30T11:59:46Z; 
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Method=Privileged;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Name=Public_0;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_ActionId=70894e1c-be0b-469e-9577-00003d1bc2c4;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_ContentBits=1
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_enabled: true
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_setdate: 2020-06-30T11:59:29Z
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_method: Standard
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_name: Internal Use Only -
 Unrestricted
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_actionid: a3834a88-b046-4024-994b-0000d3dc419b
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_contentbits: 0
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_enabled: true
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_setdate: 2020-06-30T11:59:50Z
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_method: Privileged
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_name: Public_0
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_actionid: d8693878-febc-4a20-873b-0000879c68cd
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_contentbits: 0
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [2607:fea8:1ca0:70e8:89d3:2a74:6d44:185a]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 13b8110f-b5f0-411b-2574-08d81ced1945
x-ms-traffictypediagnostic: DM5PR12MB1210:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM5PR12MB1210206FD61B78AD8432772C856F0@DM5PR12MB1210.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:5797;
x-forefront-prvs: 0450A714CB
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ped5LAbU/2pOpUAHL+pDAXZ5Y3qWiA+gJTrmOpL/6F0IUyLaalM/LYz0mfD9SZxOrhGjOsMmUUFbMHRhyL3KR4/J8AJtjDdjs2c3Jd0BKtJOrlxLbBNTHWmXLItXCXwrER2tn2fXl3R9y0EM7wVjKb82Zp7PkS2dieUxy5D+9Li6bmnN814oJXjqtARL7USvS34Dq+LB2YbRGhxI21w5EuC/4A+YuWgHqAW5fmDtxIcIfl+tHwQNDGdX/Vlcp3ABi7s0iG3FzrGYDIs6EUZaM/yGQOMmdeLV2J/npeb2v7Fp31g0sEp4n3Fyd/yzFSljjPIPYZBOqGrYmdOjlqB0G7kvPS5M3BbvBUlZxmDa5M61ElSqgDVX/kS+CMIy63cYg9ehsP3NoojH0ryA6S5HlQ==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB3721.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(39860400002)(366004)(346002)(396003)(376002)(136003)(8936002)(52536014)(478600001)(186003)(5660300002)(316002)(110136005)(4326008)(6506007)(45080400002)(53546011)(71200400001)(66556008)(2906002)(966005)(33656002)(66476007)(86362001)(9686003)(8676002)(64756008)(66946007)(55016002)(66446008)(76116006)(7696005)(83380400001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: Nx0kP9Vbk6Oz+fkXmnJQfEe4B2pretYKaYl+GF97yj+9VT/QvvHV/if2sSZbwipaDDqPx8eMwgKaWvE639EKXlce0NIWw7eK6UhwlzVF4AF2SuE9/WatHQrf5jO2tEc2MqVU5bFT8SrYABeB12qAVOS4tqoufHiVI47g/HMSljcIgqfcbP4lKJ8CzP9L+EFV7SYs9Vn8mD4ODYt8NyMhy2mfQ6tl50cy/07i7ljJZUASgKJ/t529V1ALzDKrU7DEQRPi8OznCgqIyGGfUuecf5l+fLqNP83AK4VIEyVnabxc/EOG82gUWT5OXRio53fKJBN7SDtJirR2TvR5tuGSVEtRg1CHDiPobGXIVDlbTp8L/fKjFlpWb8gA2j0zriUHK5xnWihkuKvESOIiuRPdQUnXu4DZC/4gF1ZhlTopjIhFNtiasKHB3BaNt1HhmsFntAQOnMoLHN0qHX6lyMFs4TJgVdOSlXJsaqr7ip9gzpXFDaj6CTQjgdrIBrdeRMnD7h0yWYHRS965Krpdw7PKxYNYc8gD4ZFSFvhO13dxwa2dUUMHTubgdrM8L7Gk15/F
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3721.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 13b8110f-b5f0-411b-2574-08d81ced1945
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Jun 2020 11:59:52.9324 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 4Q3yKLa9OnvSRdbwx0Hl0kVn3pvrxjDftD8Oy6SgLkTfHhnRMlOtBM1vsgZ9S48UHb6dQFYInd62s8320U59Og==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1210
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
Cc: "Greathouse, Joseph" <Joseph.Greathouse@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Public Use]

One inquiry inline

> -----Original Message-----
> From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Joseph
> Greathouse
> Sent: Monday, June 29, 2020 9:55 PM
> To: amd-gfx@lists.freedesktop.org
> Cc: Greathouse, Joseph <Joseph.Greathouse@amd.com>
> Subject: [PATCH] drm/amdkfd: Add Arcturus GWS support and fix VG10
> 
> Add support for GWS in Arcturus, which needs MEC2 firmware #48 or above.
> Fix the MEC2 version check for Vega 10 GWS support, since Vega 10 firmware
> adds 0x8000 to the actual firmware revision. We were previously declaring
> support where it did not exist.
> 
> Signed-off-by: Joseph Greathouse <Joseph.Greathouse@amd.com>
> Change-Id: I9b44dfe59bdd8a38a0342e5155cdb071cf646cc5
> ---
>  drivers/gpu/drm/amd/amdkfd/kfd_device.c | 8 ++++++--
>  1 file changed, 6 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device.c
> b/drivers/gpu/drm/amd/amdkfd/kfd_device.c
> index 80393e0583bb..50886de3ba0a 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_device.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_device.c
> @@ -602,9 +602,13 @@ static int kfd_gws_init(struct kfd_dev *kfd)
>  		return 0;
> 
>  	if (hws_gws_support
> -		|| (kfd->device_info->asic_family >= CHIP_VEGA10
> +		|| (kfd->device_info->asic_family == CHIP_VEGA10
> +			&& kfd->mec2_fw_version >= 0x81b3)
> +		|| (kfd->device_info->asic_family >= CHIP_VEGA12
>  			&& kfd->device_info->asic_family <= CHIP_RAVEN
> -			&& kfd->mec2_fw_version >= 0x1b3))
> +			&& kfd->mec2_fw_version >= 0x1b3)
[KR] Is it 0x1b3 for both VG12 and RV? I wasn't sure if it was 0x1b4 for VG12, or did they just update the FW again and I missed the original?
> +		|| (kfd->device_info->asic_family == CHIP_ARCTURUS
> +			&& kfd->mec2_fw_version >= 0x30))
>  		ret = amdgpu_amdkfd_alloc_gws(kfd->kgd,
>  				amdgpu_amdkfd_get_num_gws(kfd->kgd),
> &kfd->gws);
> 
> --
> 2.20.1
> 
> _______________________________________________
> amd-gfx mailing list
> amd-gfx@lists.freedesktop.org
> https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Flists.fr
> eedesktop.org%2Fmailman%2Flistinfo%2Famd-
> gfx&amp;data=02%7C01%7Ckent.russell%40amd.com%7C763e1f08fe29488bf1
> 6c08d81c98b2c5%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C63
> 7290790080559728&amp;sdata=22Hd8tIxsjF%2BLXiBKQgSt6EbOTIHqifVSYMb
> W1AWxV4%3D&amp;reserved=0
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
