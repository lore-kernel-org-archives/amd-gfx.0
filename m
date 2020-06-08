Return-Path: <SRS0=JmOw=7V=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8BB73C433DF
	for <amd-gfx@archiver.kernel.org>; Mon,  8 Jun 2020 06:00:08 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 45A162076A
	for <amd-gfx@archiver.kernel.org>; Mon,  8 Jun 2020 06:00:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="Urjd7doA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 45A162076A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id ED6246E466;
	Mon,  8 Jun 2020 06:00:07 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2065.outbound.protection.outlook.com [40.107.94.65])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 26E616E466
 for <amd-gfx@lists.freedesktop.org>; Mon,  8 Jun 2020 06:00:06 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=c3BPSomqIpkQTF8R4bC37c44wQIlbbRlu7fjmlO1r8fCe2cv9M0uwFJHavNRTqD3/DX8N43+kiagwYYACoDSigKod3HEnroaVjFnUEaLFWRI9JeSqwrZ3I1bgUDjl7losW1h+XFfFtGDAyn33Y7eNgLBeoF+Lxh4o9q/1yLolHXrQQHhj843A19wU+2lEaSgRRN294KPYm8OHtwn3NNR2vPz5W8rL98S74ESp14a9faWQ1X/N05ioSc4RBbr+OoKCa4NoImIJclvZbVcfO2jpVcptjEXFJ7msxuF/sxU7kRfeeiT1PPA9q7d+t7FLyEC8FVA7G1KgIxaM6V3VLdE1g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uHRnlS96i8BOSJKGbq7U8uhI9hwX6WXQrFkFq2lmEwk=;
 b=K+vVDUBFDOBroel6kQ6D2NM0azqKnlVK0xqy2wvPYEE5W/ypxcsOrlxi6rdfa3i99tuZQGH4W/QyovbOhXM8Cz0H51zqlqEzogX0D2xdH64qi7VSw5cOCUWw0zl7b7wRx7qFATsFB9d5NodWHzQPoGYx9sPTV5aIixyBvtEfqaydfan1a2OWeNGAtEDXDSnDZzJj2XWH2liAUBLSBK3x7CP+FkeCGcFdlP06+iCtt2Y6U3lBA/1pPUnU6UZeqCAQjfoLtuCZele22Bqt6OFndQEYvZNF9QFhdKx803Opo/6KlgKA+VzuaR7JXO4KSeYQcQu8UOh3Ws7Wgae7ADGkkw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uHRnlS96i8BOSJKGbq7U8uhI9hwX6WXQrFkFq2lmEwk=;
 b=Urjd7doA620INXWArKPX1oLclX+fUoNe3NSaLvHDqfqQmHxGnZAf8KPu3ZAqFC4jbqjcNOq6LZPp4HxWBpOQG/2BsYCc7Qq2qObuf9MeUJxCeyOJmIqYfiLySrtDkdTSQaayoUmTRD+iBPfkTVJhkxP1JPkTAigB9BBQ3m4mfuU=
Received: from BY5PR12MB4307.namprd12.prod.outlook.com (2603:10b6:a03:20c::16)
 by BY5PR12MB3875.namprd12.prod.outlook.com (2603:10b6:a03:1ae::24)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3066.20; Mon, 8 Jun
 2020 06:00:04 +0000
Received: from BY5PR12MB4307.namprd12.prod.outlook.com
 ([fe80::2c8e:6202:8066:9e8]) by BY5PR12MB4307.namprd12.prod.outlook.com
 ([fe80::2c8e:6202:8066:9e8%7]) with mapi id 15.20.3066.023; Mon, 8 Jun 2020
 06:00:04 +0000
From: "Liang, Prike" <Prike.Liang@amd.com>
To: Alex Deucher <alexdeucher@gmail.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amdgpu/soc15: fix using ip discovery tables on renoir
 (v2)
Thread-Topic: [PATCH] drm/amdgpu/soc15: fix using ip discovery tables on
 renoir (v2)
Thread-Index: AQHWO0+tXoWcuny65kuY37gMpF4t4KjOMhJw
Date: Mon, 8 Jun 2020 06:00:04 +0000
Message-ID: <BY5PR12MB43073DD83173ACFC0A67F4D0FB850@BY5PR12MB4307.namprd12.prod.outlook.com>
References: <20200605154029.118736-1-alexander.deucher@amd.com>
In-Reply-To: <20200605154029.118736-1-alexander.deucher@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ActionId=f58f55a6-09d6-49f1-9a1d-00001e553bcb;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ContentBits=0;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Enabled=true;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Method=Standard;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Name=Internal
 Use Only - Unrestricted;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SetDate=2020-06-08T05:19:13Z;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [58.247.170.242]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 038498af-51d6-4c22-1a0a-08d80b71308a
x-ms-traffictypediagnostic: BY5PR12MB3875:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BY5PR12MB38759FE6B7F14F8B067381CFFB850@BY5PR12MB3875.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-forefront-prvs: 042857DBB5
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Uw7aH+gBtaQyW/vmBFx6vmM+OmG4yc2MI0DYKFJIgc5aNRWZuPWBuBElttTrr3clmF/5mugLbwHEsE8NO/ihTb1UqpO4/5Nx7TmVfHX7DJsJM28kkS483RTCB4mor0Vf1tZrf6bYIW6JSLKl7qvsE4ZFWnPncUuK1Jqrki3kRCSugk0d3NJ4+QcfVWbN49wki3byMp38lI08ifqu7UoB8aKQHJpisTkxrdqVe0BKv2R0FcmrX8y824uWPPN3MinRBV2B6vH3U/jQ+UEN2YHnlMchsWRQPsjVwvk5P/M9JbTEDmT5zRbo19C+whp7Ph70
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BY5PR12MB4307.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(396003)(39860400002)(136003)(366004)(376002)(346002)(186003)(52536014)(6506007)(316002)(8676002)(83380400001)(9686003)(8936002)(478600001)(110136005)(53546011)(33656002)(66476007)(2906002)(4326008)(66946007)(71200400001)(5660300002)(86362001)(55016002)(7696005)(26005)(76116006)(66446008)(64756008)(66556008);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: KvotHHCXVyNGoM+j86aC6WjdPLk+TyD1x2vzZZAWoYRa6qiTFLWBuI/PCbiwmGCdDNwg34ped4PF6Xx+67YQl1QxtuN6G58jH0a14+FNiExi1Xv5xtJt30gQTQilRDIbzZflL6ZKB1hpjIRMLhi2ygkcGPOTiTPiMgru/ufpzdpCaeCd3tZ8Vl+/g2PtAYV92LktkAJdHtc3grFlpWfOOBcyboX3D4BE1gcg6uN4dtitcZdmCKqHsUKAfno3ru2ysMUtYKGErJekp3z/5kNjsGUopZmdW51Z/tGq2ocd/N2er83dDo8vFq42sSwyJeSJBYsBoV1lgzV1iS2Mccwo2tq4TNdZE3dMXpwVCNFdZ88lVjFadcI8y0Qe2jqB6n1miGzRPhCCudioCZMPnt10e5SA1aW5m2Jvryww2idZFWkUsuGadRFUWIG9x0DAUsNsahmRN43oGPVhuasWGR0WzDryxvcWC5XYuUn3Utcau6l66UfjCh1Q1QKJTOdLbF/J
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 038498af-51d6-4c22-1a0a-08d80b71308a
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Jun 2020 06:00:04.4540 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: eHn+/ObTecUwTM1fE+/CrCWPIkCc37Sf11FxE6tkDxYmoznenK00Q+xIuQT8EMww
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB3875
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

[AMD Official Use Only - Internal Distribution Only]

According to reg_offset assignment in amdgpu_discovery_reg_base_init() the reg_offset is calculated as IP base address pointer therefore PWR IP base should be map to adev->reg_offset[SMUIO_HWIP][0] + 1. Moreover, not sure whether can use/need  the mapped address to access PWR_MISC_CNTL_STATUS for controlling  the GFX CGPG in Renoir.

Base on the above modify the PWR IP access  nullptr issue should can be fix, but should hold on this patch since  start X will be occur other nullptr issue during amdgpu_info_ioctl().

Thanks,
Prike
> -----Original Message-----
> From: Alex Deucher <alexdeucher@gmail.com>
> Sent: Friday, June 5, 2020 11:40 PM
> To: amd-gfx@lists.freedesktop.org; Liang, Prike <Prike.Liang@amd.com>
> Cc: Deucher, Alexander <Alexander.Deucher@amd.com>
> Subject: [PATCH] drm/amdgpu/soc15: fix using ip discovery tables on renoir
> (v2)
>
> The PWR block moved into SMUIO, so the ip discovery table doesn't have an
> entry for PWR, but the register has the same absolute offset, so just patch up
> the offsets after updating the offsets from the IP discovery table.
>
> v2: PWR became SMUIO block 1.  fix the mapping.
>
> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/soc15.c | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/soc15.c
> b/drivers/gpu/drm/amd/amdgpu/soc15.c
> index 623745b2d8b3..dd17a8422111 100644
> --- a/drivers/gpu/drm/amd/amdgpu/soc15.c
> +++ b/drivers/gpu/drm/amd/amdgpu/soc15.c
> @@ -686,6 +686,9 @@ int soc15_set_ip_blocks(struct amdgpu_device *adev)
>  DRM_WARN("failed to init reg base from ip
> discovery table, "
>   "fallback to legacy init method\n");
>  vega10_reg_base_init(adev);
> +} else {
> +/* PWR block was merged into SMUIO on
> renoir and became SMUIO block 1 */
> +adev->reg_offset[PWR_HWIP][0] = adev-
> >reg_offset[SMUIO_HWIP][1];
>  }
>  }
>  break;
> --
> 2.25.4

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
