Return-Path: <SRS0=qt+g=GW=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77F57C433E0
	for <amd-gfx@archiver.kernel.org>; Tue, 19 Jan 2021 07:20:07 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1262D23132
	for <amd-gfx@archiver.kernel.org>; Tue, 19 Jan 2021 07:20:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1262D23132
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 41D576E829;
	Tue, 19 Jan 2021 07:20:06 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2068.outbound.protection.outlook.com [40.107.244.68])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 47A4F6E829
 for <amd-gfx@lists.freedesktop.org>; Tue, 19 Jan 2021 07:20:05 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OMf25JGkBymX+A+a2S7U+9Str5FGXcz8xe+QYDwKOdhf9E8Cf7Wm4gUIx4PSYlT8ewPf1A0IyWwsG7AvX+ckHzaM1+G1AmLiDgyOKnoZtUUNXJVZFBBvC9TMgSnpRRe4s+gCOtAarXOG1QfVr9Mz3hqSxiPIbvoiFpUUBqkIswUkvOekTlfkYEPAtOpH0SGrGrgE6plMkG32mEEDmwBd7CNIw1IbTpQOjk78plUbsE9S2uavf3UUBWUPn5Mis61n6K5JQFjTG9hyX+qKTp82LsHHHIiGTRrPU846u6G7YiaLNoyxxzO9GceVwWlYILHqyU/1FuzSIeQ5iyGRIxYNBw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+mSjkk3bdEMRGRq6ZFzTocIts7phfwXpqEdhKm+syR4=;
 b=ec97c+lwKSGPH6zzIumCUjm0uaWysYrppg/ri+MBbRcrqIkuci8ofBfgfPHr31/rCs6e4Db3XGW1HJ5/K6db86GK7y9e6KY0AhF4tZyKQYbTCJI/P9TUCDUHvFLzoNT5jZKea1X1HsqjwwSnCn2tGX6kPssFJ7EXPP/PX84Zl+B9Pwv7cONQFufvEevsCDoS9JlaXXYrBSEBF8lkIkp5KQDJIaZsP38VQykfN74nI8Ehil201/D6/ptcJspqXaLnSadd0kJAIMmdpraKJ8yFqXHCPe312LNbh2AHV9OrGKKZdgmIDAyl8lL/NbziwLcdD2tcIpv3cAXDRTZNElk6tA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+mSjkk3bdEMRGRq6ZFzTocIts7phfwXpqEdhKm+syR4=;
 b=viKRSrdEdWjqB5UKYceEUX4DI2jzXm0AO++ITa4f/IwcAztgCI1uZboaTOt6DGOU+viDnl44Zd0KlqtZ15pYIjivPMpTZ6GfE8s8Y4EVROIuzyb+TV3yMh5cTRx0RTCSb3ZoP3G/sftimbs1F/5ipgWYg0cJpyYWAs3CNRkv/7Q=
Received: from BYAPR12MB3238.namprd12.prod.outlook.com (2603:10b6:a03:13b::20)
 by BY5PR12MB4998.namprd12.prod.outlook.com (2603:10b6:a03:1d4::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3763.10; Tue, 19 Jan
 2021 07:20:03 +0000
Received: from BYAPR12MB3238.namprd12.prod.outlook.com
 ([fe80::6daf:7d00:b03b:8a16]) by BYAPR12MB3238.namprd12.prod.outlook.com
 ([fe80::6daf:7d00:b03b:8a16%4]) with mapi id 15.20.3763.014; Tue, 19 Jan 2021
 07:20:03 +0000
From: "Liang, Prike" <Prike.Liang@amd.com>
To: "Huang, Ray" <Ray.Huang@amd.com>
Subject: RE: [PATCH] drm/amdgpu: remove gpu info firmware of green sardine
Thread-Topic: [PATCH] drm/amdgpu: remove gpu info firmware of green sardine
Thread-Index: AQHW7icytGfBHKG4PU6f7OSt1G9H86oueYVggAAK4ICAAAMiIA==
Date: Tue, 19 Jan 2021 07:20:03 +0000
Message-ID: <BYAPR12MB3238D59E095B5A473363325DFBA30@BYAPR12MB3238.namprd12.prod.outlook.com>
References: <20210119055135.70134-1-ray.huang@amd.com>
 <BYAPR12MB3238BA59B2D36A50A2E93B46FBA30@BYAPR12MB3238.namprd12.prod.outlook.com>
 <20210119065729.GD22628@hr-amd>
In-Reply-To: <20210119065729.GD22628@hr-amd>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ActionId=21f6e1a6-2978-4caf-ac2f-01f7db6d475f;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ContentBits=0;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Enabled=true;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Method=Standard;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Name=Internal
 Use Only - Unrestricted;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SetDate=2021-01-19T07:08:41Z;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [139.227.235.92]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 1125e8a9-3ca5-43db-e322-08d8bc4aa3d6
x-ms-traffictypediagnostic: BY5PR12MB4998:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BY5PR12MB49984935148B65268A130EA4FBA30@BY5PR12MB4998.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: qzKuAdCA14U8D8frS1y/Ipca6IkwDgHCUzlRtIbkhGEQx6FvAAlKS9E8elv9H3IpuDKPtBxME9B9vrEWXwa9vXMlCKNhq55wWUtKFKAh1LMhgfeZU4cYIqUp3G+AtJl3/XDQa/biFSVGaFwvo3q4IU6s8yOjtIft05t+e5yC81+ZnzwUnFsF3GWckMSvgphmRQBgbTzJA6VTu3rtsXcCovGPyzvUfHHkf59ZOnlOuktjxaKn+Gur6iiTeYhoVOl05YsKPf1ItcNgIllgNEb/nAoHkc2yHoJ7QMwsqYUwF4YFupETLZ286p5Dmq/o50IzeXMtFkkROO2kZm62uDUreTOl4C0u+kOlSROSTzYun84Dn1Qom0y+gO1nqtauwn2HmwI4U67QFSyqwsU+36vk+cXboxfMOAhBHsyvZqz8udsZEcoWhl+EpPNVOq9ThEk8mFBcE32WNrPyNtYNx53lfODBgtcC5tAl6g1WWoxMV4tn6FeTisiJtcIryDovYKPMLz63y/5141Ib0PBneAv3Pw==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR12MB3238.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(136003)(366004)(376002)(39860400002)(346002)(396003)(6636002)(6506007)(86362001)(26005)(54906003)(316002)(53546011)(52536014)(66446008)(66476007)(66946007)(76116006)(55016002)(33656002)(7696005)(8936002)(9686003)(8676002)(83380400001)(6862004)(4326008)(66556008)(5660300002)(71200400001)(64756008)(2906002)(478600001)(186003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?x+XtZ48Ec9doc7c1bjHx632bR/0aaIKBWO1LHcF+spmHl9uwJXT82QEe/POY?=
 =?us-ascii?Q?HFZUPyHrtr+iCJtAUPUe5zstDBjHjl0pnYjOTGQYFHSSGyFR15im+Gc0EKF6?=
 =?us-ascii?Q?b+0dAgIOhGjovknCB+tWLwOOf4gm2GNHjT5+XiLyi18YXWcHOJBGhTpDFnQQ?=
 =?us-ascii?Q?fHiFk8ETN+T0GDfCBD8WzUgo/r+4TcjFY6qrTTzMJ93ZJIrW8RK0SkXBZIGZ?=
 =?us-ascii?Q?H79HS7Vsin4cCK+HDwAOQVMTAhcyg8usH/ugFq6sRaZD2sw77cIwmr0Cg5Fe?=
 =?us-ascii?Q?7NkzZ4dbtOSyjePccm6nnUXjbtVTaRLjPI0cdl5WkPrppSC99ut3RafisRnm?=
 =?us-ascii?Q?2n0/wfyx+o8qarG/7Znc0xLUfQ+1cGN4W+ayaVz8xW8klg0dlgyLnTMqs2gM?=
 =?us-ascii?Q?TokDk0QFAFMovT4BfmBSpCyBjBH3NsUoqDothaII33Fud5V2xAW1PCBE8QJI?=
 =?us-ascii?Q?wz/qr4dr8NxUOum4VPeLDUgpnBsSJa2wJS8zl230m2OpLOc+koupj9cvlrKA?=
 =?us-ascii?Q?4DY0+BA6zgLhZAY+HbNhFB8aNFr9bu02gv00tpZMVWTGm52bfIS5sV9o90Qo?=
 =?us-ascii?Q?iO7jG6PCKZgZXbQNKjQSHJm1bqT18MG4N1sgIOr3v0JfcS3do8VGY6zQpG/K?=
 =?us-ascii?Q?T1bKDOGefLV5nBl0x3JflvaHlahQgHgHr3lOcBdxLaG2BSJ7I72h70bfGkuo?=
 =?us-ascii?Q?hWiAd08vQrCLsV2Jy/Oys50+W1RxzHgExNeKoBaHqR1Y8xiL2+jEf9gtyWGI?=
 =?us-ascii?Q?mmLDLjScP/Pj5n+h3DcAUP6kIXoxG7Uju+IQlcaWRdCHH6hJcI0xzjQFVF7Y?=
 =?us-ascii?Q?ruLpCybpyPR/J6YMOekwTY2pse2f/Xwq2ycHjSBv2hs6QX1CbmCQf5LCt/Wy?=
 =?us-ascii?Q?1HoGGaFg5JQD1eAZZjkFGBd1BGpFhh+Q6AQeJmEUL+LmlywhmnlnQ128BwUR?=
 =?us-ascii?Q?xorcrPcJAqPe3Qzi81PdSoOQUApPXPd/LeoWQW/OP60=3D?=
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB3238.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1125e8a9-3ca5-43db-e322-08d8bc4aa3d6
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Jan 2021 07:20:03.3487 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: AODTXxGQHbaS9R5HXKwMHfdI1EzhXEjqs+JVfnihOmaq9tR0qJBwq52bpQ42slcs
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4998
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
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Official Use Only - Internal Distribution Only]

> -----Original Message-----
> From: Huang, Ray <Ray.Huang@amd.com>
> Sent: Tuesday, January 19, 2021 2:57 PM
> To: Liang, Prike <Prike.Liang@amd.com>
> Cc: amd-gfx@lists.freedesktop.org; Deucher, Alexander
> <Alexander.Deucher@amd.com>
> Subject: Re: [PATCH] drm/amdgpu: remove gpu info firmware of green
> sardine
>
> On Tue, Jan 19, 2021 at 02:25:36PM +0800, Liang, Prike wrote:
> > [AMD Official Use Only - Internal Distribution Only]
> >
> > Thanks help clean up. Generally that seems fine but could we keep the
> green sardine chip name to retrieve the GPU info FW when the IP discovery
> fail back to legacy mode?
>
> Do you want to only clean MODULE_FIRMWARE(gpu_info.bin)? That's fine
> for me.
[Prike]  Yeah, that seems enough just remove the green sardine GPU info FW declared for amdgpu driver module.
>
> Thanks,
> Ray
>
> >
> > Anyway this patch is Reviewed-by: Prike Liang <Prike.Liang@amd.com>
> >
> > Thanks,
> > Prike
> > > -----Original Message-----
> > > From: Huang, Ray <Ray.Huang@amd.com>
> > > Sent: Tuesday, January 19, 2021 1:52 PM
> > > To: amd-gfx@lists.freedesktop.org
> > > Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Liang, Prike
> > > <Prike.Liang@amd.com>; Huang, Ray <Ray.Huang@amd.com>
> > > Subject: [PATCH] drm/amdgpu: remove gpu info firmware of green
> > > sardine
> > >
> > > The ip discovery is supported on green sardine, it doesn't need gpu
> > > info firmware anymore.
> > >
> > > Signed-off-by: Huang Rui <ray.huang@amd.com>
> > > ---
> > >  drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 3 +--
> > >  1 file changed, 1 insertion(+), 2 deletions(-)
> > >
> > > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> > > b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> > > index 4d434803fb49..f1a426d8861d 100644
> > > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> > > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> > > @@ -81,7 +81,6 @@
> MODULE_FIRMWARE("amdgpu/navi10_gpu_info.bin");
> > >  MODULE_FIRMWARE("amdgpu/navi14_gpu_info.bin");
> > >  MODULE_FIRMWARE("amdgpu/navi12_gpu_info.bin");
> > >  MODULE_FIRMWARE("amdgpu/vangogh_gpu_info.bin");
> > > -MODULE_FIRMWARE("amdgpu/green_sardine_gpu_info.bin");
> > >
> > >  #define AMDGPU_RESUME_MS2000
> > >
> > > @@ -1825,7 +1824,7 @@ static int
> > > amdgpu_device_parse_gpu_info_fw(struct amdgpu_device *adev)  if
> > > (adev->apu_flags & AMD_APU_IS_RENOIR)  chip_name = "renoir";  else
> > > -chip_name = "green_sardine";
> > > +return 0;
> > >  break;
> > >  case CHIP_NAVI10:
> > >  chip_name = "navi10";
> > > --
> > > 2.25.1
> >
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
