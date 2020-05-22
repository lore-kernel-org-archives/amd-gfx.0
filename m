Return-Path: <SRS0=+s4F=7E=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71B4CC433E0
	for <amd-gfx@archiver.kernel.org>; Fri, 22 May 2020 08:56:21 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 09CDA206DD
	for <amd-gfx@archiver.kernel.org>; Fri, 22 May 2020 08:56:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="gBK8ybVh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 09CDA206DD
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B566C6E027;
	Fri, 22 May 2020 08:56:20 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2041.outbound.protection.outlook.com [40.107.94.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C1C826E027
 for <amd-gfx@lists.freedesktop.org>; Fri, 22 May 2020 08:56:19 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CRtuAPko6EkqEXISE+ZlqnpQRXRhrjgjic1/V5LB34KnTlCccyXqfg79AJhBHi6c3IhJvRCLEbuWTpDzp9usa8yeDJCqtVSD90dEbkPLoAQrsIIpj4ClzJWvq0xyQt2olCSO6cMnUraAMOK5KJJr0UpYIZKoQX8/Fn8Rtx6DO5vZkcRBu5r9JeKPOtDJ/7C0kytExCNfpw6Br8sxAyYrGi2w4m0mi9A1pnDwMauHS2eFXa7uy7ZhFKJNV8yvkGkBx2jxywlQ4MdE5+0+IFjLDY59v2gigKzSO1ccIB7WFTMd3IRTDp90t4B1G8bG8zrDikGHjdDJ0Ojw86LVFbJiFA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rCluJ+7y8uO3nWlfPGfsxUATPw/FhmI6bn8OX7MkhcY=;
 b=hlBBKlO/flTJiVbeodf5k7BIXB+RlRWy9z2WLswsUrEUHSMh1TJKrLuND8NRz0eFD2V1L42IcPL2AC6M/hI7VX2jXLptQW2jGwjYYrdrKOkEEhhSoYkiReZylnV3r3LSsUyc0kLLRroKGyJO9PRyj12RRzGVzt0BRNjDzsnWai9jtWsYklsK3uJsVXXRyIyKLll5yXUZcn+Nl+DPrx/TrsINgFaSnItGLPUhfUGOWFhVQ4edn05jAw85SH7/kFfm9dJTtdlBZvFsBpC5wu6PoYf/72xIALe2LjO24dnpWd02Jv1UB9WlNBskMFVlIimbihEcRdB2scJtypMklgeFaA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rCluJ+7y8uO3nWlfPGfsxUATPw/FhmI6bn8OX7MkhcY=;
 b=gBK8ybVhDS5Aqp6Nm2/LQrIbzLVfC1Ew9cv6te/kI52FbRbig9z3X/xerorkHHLiaWDsd99QOFwyDpeXW6cPox7zSEob1m2B+0mIb13n1g27XC56lQ/yuMQb6IHu73UsXOyv+QAnQ9/AFlTPP0XxnLm3cKScziCT7K9kjvHOfPU=
Received: from CY4PR12MB1287.namprd12.prod.outlook.com (2603:10b6:903:40::8)
 by CY4PR12MB1448.namprd12.prod.outlook.com (2603:10b6:910:f::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3021.27; Fri, 22 May
 2020 08:56:18 +0000
Received: from CY4PR12MB1287.namprd12.prod.outlook.com
 ([fe80::a8f9:dd91:3039:d3dc]) by CY4PR12MB1287.namprd12.prod.outlook.com
 ([fe80::a8f9:dd91:3039:d3dc%8]) with mapi id 15.20.3021.027; Fri, 22 May 2020
 08:56:18 +0000
From: "Chen, Guchun" <Guchun.Chen@amd.com>
To: "Zhou1, Tao" <Tao.Zhou1@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>, "Zhang, Hawking" <Hawking.Zhang@amd.com>,
 "Clements, John" <John.Clements@amd.com>, "Li, Dennis" <Dennis.Li@amd.com>
Subject: RE: [PATCH] drm/amdgpu: print warning when input address is invalid
Thread-Topic: [PATCH] drm/amdgpu: print warning when input address is invalid
Thread-Index: AQHWMA4TRn3s7jd+rkGNxbO9m1trTaizwNgAgAADp9CAAAejgIAAAUVQ
Date: Fri, 22 May 2020 08:56:18 +0000
Message-ID: <CY4PR12MB1287B0C8D39C0FDA858DB2B0F1B40@CY4PR12MB1287.namprd12.prod.outlook.com>
References: <20200522075304.22231-1-guchun.chen@amd.com>
 <BYAPR12MB2888E86B6A5017E5D55A5DFAB0B40@BYAPR12MB2888.namprd12.prod.outlook.com>
 <CY4PR12MB1287F8AC265664C6227826C6F1B40@CY4PR12MB1287.namprd12.prod.outlook.com>
 <BYAPR12MB2888EC9BD9FBADABDDAEE5C1B0B40@BYAPR12MB2888.namprd12.prod.outlook.com>
In-Reply-To: <BYAPR12MB2888EC9BD9FBADABDDAEE5C1B0B40@BYAPR12MB2888.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Enabled=true;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_SetDate=2020-05-22T08:23:49Z; 
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Method=Privileged;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Name=Public_0;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_ActionId=1a5bba39-b210-47a7-a48b-0000c15207cf;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_ContentBits=1
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_enabled: true
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_setdate: 2020-05-22T08:56:16Z
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_method: Privileged
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_name: Public_0
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_actionid: 5381e587-72dd-4d5c-9ecd-0000f3067127
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_contentbits: 0
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [58.247.170.242]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: cd36c19c-db06-462f-d0d1-08d7fe2dfe06
x-ms-traffictypediagnostic: CY4PR12MB1448:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <CY4PR12MB1448714FBD21B49B0418B5A7F1B40@CY4PR12MB1448.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:551;
x-forefront-prvs: 04111BAC64
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: sXviyFZXxyjCPr8fHj075d2BpBH8mqr8eUG3WBeVFi56LFnxHW1vn+xWgkRGjv830zHNy5dZF8DOOg4vzBKxrTRx4sQuWU5X7eUI1SoyTn10I5fTKFwvAWZJlhPqAayggEobMZG6zAite7xlWL/5JFbHFoBxjuTGkaVOKEjQDl8K2qxrIvUIeJEVKQUOCcLAftkVHYLwF3409Lzf0e1MTiUrQbe8I8VBit06PPd4+4LyIpfr3xNurKHgMrGdqBLOn+vOYpXGIj1F5tNARgMFt1ZyB/SVtXa3cFVQGplywEAUY+nGiK94rpZ+Bxy2vIfO
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CY4PR12MB1287.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(366004)(346002)(376002)(39860400002)(136003)(396003)(76116006)(2906002)(66946007)(316002)(110136005)(52536014)(186003)(26005)(66476007)(53546011)(7696005)(66446008)(64756008)(6506007)(66556008)(86362001)(5660300002)(33656002)(8676002)(71200400001)(6636002)(8936002)(478600001)(9686003)(55016002);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: Fb6Ao1rseKcbU7MVhGEhf9N9szGO9bdQrjrf7qoig34XGZOJbUO2bcugoxQ2x/pnZaw0EUGjk9LeheGL6m2WrD+pI+gGD9zlLWSku/MXp/c06sLJujQKU8p7Zx9nCjeFtEs7FHE8IDx6gb7hYOhjxy7judNF4lyZRqN2IbGNSxEQbdEkiqrWbtYYO9VNcIhIRC7bPZYhHy2zPlk90MLudhtFl+X3RwF0xlFoS9honU1negXwI66iw+AO07DmQAF0Rp9mJRGTQFK97OJoJZszO+NLpypCRTbEeaGbyMK+zqZ0IWhmU+G6gL6BnNwPyxZOKsN6lGeCBHWH/O/NjDN6WbUmGBizydu974vEvu7EDov3XmVnrLw7/C4os3iVrZzjnFS122RQqZDfWeVXLZFCyVdRiCSKpBJqdClqN690VV7O75h9mQ5QZe4UajBRGvmB61K2NUSygdoWjOea8Ip8NJ0OIGIZyj2OBFe7VSI7BxyLx9tNWahVX34sB2Lw0qZ8
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cd36c19c-db06-462f-d0d1-08d7fe2dfe06
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 May 2020 08:56:18.3808 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: qc116rUmaNuiHb6ARM039zlhe1UvI+Yo8njzUld9V68211SoCCeJSyrDg11IneiTx18vUEtkHqp5ubJCgR2HHg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR12MB1448
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
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Public Use]

Thanks Tao. I will address that when pushing.

Regards,
Guchun

-----Original Message-----
From: Zhou1, Tao <Tao.Zhou1@amd.com> 
Sent: Friday, May 22, 2020 4:51 PM
To: Chen, Guchun <Guchun.Chen@amd.com>; amd-gfx@lists.freedesktop.org; Zhang, Hawking <Hawking.Zhang@amd.com>; Clements, John <John.Clements@amd.com>; Li, Dennis <Dennis.Li@amd.com>
Subject: RE: [PATCH] drm/amdgpu: print warning when input address is invalid

[AMD Public Use]

OK, but I still suggest adding "RAS" in the print to indicate its module, with this addressed the patch is:

Reviewed-by: Tao Zhou <tao.zhou1@amd.com>

> -----Original Message-----
> From: Chen, Guchun <Guchun.Chen@amd.com>
> Sent: 2020年5月22日 16:31
> To: Zhou1, Tao <Tao.Zhou1@amd.com>; amd-gfx@lists.freedesktop.org; 
> Zhang, Hawking <Hawking.Zhang@amd.com>; Clements, John 
> <John.Clements@amd.com>; Li, Dennis <Dennis.Li@amd.com>
> Subject: RE: [PATCH] drm/amdgpu: print warning when input address is 
> invalid
> 
> [AMD Public Use]
> 
> Hi Tao,
> 
> Please see my response inline.
> 
> Regards,
> Guchun
> 
> -----Original Message-----
> From: Zhou1, Tao <Tao.Zhou1@amd.com>
> Sent: Friday, May 22, 2020 4:11 PM
> To: Chen, Guchun <Guchun.Chen@amd.com>; amd- 
> gfx@lists.freedesktop.org; Zhang, Hawking <Hawking.Zhang@amd.com>; 
> Clements, John <John.Clements@amd.com>; Li, Dennis <Dennis.Li@amd.com>
> Subject: RE: [PATCH] drm/amdgpu: print warning when input address is 
> invalid
> 
> [AMD Official Use Only - Internal Distribution Only]
> 
> 
> 
> > -----Original Message-----
> > From: Chen, Guchun <Guchun.Chen@amd.com>
> > Sent: 2020年5月22日 15:53
> > To: amd-gfx@lists.freedesktop.org; Zhang, Hawking 
> > <Hawking.Zhang@amd.com>; Zhou1, Tao <Tao.Zhou1@amd.com>;
> Clements,
> > John <John.Clements@amd.com>; Li, Dennis <Dennis.Li@amd.com>
> > Cc: Chen, Guchun <Guchun.Chen@amd.com>
> > Subject: [PATCH] drm/amdgpu: print warning when input address is 
> > invalid
> >
> > This will assist debug.
> >
> > Signed-off-by: Guchun Chen <guchun.chen@amd.com>
> > ---
> >  drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c | 2 ++
> >  1 file changed, 2 insertions(+)
> >
> > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
> > b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
> > index 6e911ca97038..5c73f444eaef 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
> > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
> > @@ -318,6 +318,8 @@ static ssize_t
> > amdgpu_ras_debugfs_ctrl_write(struct
> > file *f, const char __user *
> >  	case 2:
> >  		if ((data.inject.address >= adev->gmc.mc_vram_size) ||
> >  		    (data.inject.address >= RAS_UMC_INJECT_ADDR_LIMIT)) {
> > +			dev_warn(adev->dev, "Input address 0x%llx is
> > invalid.",
> > +					data.inject.address);
> 
> [Tao] How about this way:
> dev_warn(adev->dev, "RAS injection address 0x%llx exceeds limit 0x%llx.",
> 				data.inject.address,
> RAS_UMC_INJECT_ADDR_LIMIT); [Guchun]There are two cases for invalid 
> input address, one is limited by board vram size, and one is by 
> RAS_UMC_INJECT_ADDR_LIMIT.
> So it's not necessary to distinguish here, just print warning to let 
> user knows the input address is not correct, and this error injection is blocked.
> 
> >  			ret = -EINVAL;
> >  			break;
> >  		}
> > --
> > 2.17.1
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
