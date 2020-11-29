Return-Path: <SRS0=tlEs=FD=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C016AC3E8C5
	for <amd-gfx@archiver.kernel.org>; Sun, 29 Nov 2020 07:23:04 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 409132080C
	for <amd-gfx@archiver.kernel.org>; Sun, 29 Nov 2020 07:23:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="1/xtnmjx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 409132080C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 43E646E16F;
	Sun, 29 Nov 2020 07:23:03 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2053.outbound.protection.outlook.com [40.107.94.53])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B15DD6E16F
 for <amd-gfx@lists.freedesktop.org>; Sun, 29 Nov 2020 07:23:01 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Vr1OpScAJX5KxMS7govUjFhwRXUx2fGKIUc8U0xaqgL9ny/j7k4H+Ybp19wZ3hIqgf18v6lrpKWcOFOLR702ZZd2nrkAn55QwY8KN6cuXJpslX0lra199QV/58tSLteCaQhYT7j/WHpBqn5fW8/tJLxl7PAbjfb5BlbJC1rMkvUGToPZ6B7eVZNJ9RFhySFwcnZgXOTLvQvPpzNO7urJGS5D2Y2x5nC3tlXO65zYypxibZEi4AoFZGcAGhzfvrZxqcREQDLqHjyh2qsi/7EDABhbiADgiBMt1xYGiQMOTLgipLEpFOUh616LtywNanLFMvfocUdFBlCVEALkgwcW8Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kKtx57qe90mqAD5b1uRQpTLaxwSnvqHOKwOvlwuZQJk=;
 b=VfJ4F2pbryKV2I4d67runnurw6dazBTYTUxXOAQG+Vnk1v1OaDRIQY/qF6PEvFZ9HMTftUqzeydvncDE1/U0XJrcT1hhWEeyfFCaLdTn3do4rqFf5VBYIxxQboxPGLShPes2U4j3hG1Tq+ApTB496n+ylY6tI1XEfjb6EOe/VII/eUa3UH65pFEkm6+akirQLYH8eW6JhBYfidnNeRt9lonhnEx1PNCNCn8+RA5lFuX2u4JcpsZzvGbRSmPg6tmFesOJKZxmQWI6ERpo/TYqT8EoXFBtlFmaR17snQuk8FPrJqWOQqFs3EAPROPvsj8TlYfwazPd+7Mun54kwwJIwg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kKtx57qe90mqAD5b1uRQpTLaxwSnvqHOKwOvlwuZQJk=;
 b=1/xtnmjxnjiTjzRdo0ySqFKLwXu0RizaSr3/tnU07oao6egodH+fko+4MRy7d0YBlSKst28Hhpt8pT0P6EcxlUq28/azSpq5NYiqMcDduASG+vN8NN1Q4g/1w/iD6/rvuMvvdBpPZW5avm7J4v005XDw7ZYFcB4VlZO0j5HM0mk=
Received: from CY4PR12MB1287.namprd12.prod.outlook.com (2603:10b6:903:40::8)
 by CY4PR1201MB0184.namprd12.prod.outlook.com (2603:10b6:910:1d::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3611.25; Sun, 29 Nov
 2020 07:22:57 +0000
Received: from CY4PR12MB1287.namprd12.prod.outlook.com
 ([fe80::bc0f:dd2:ef80:de2]) by CY4PR12MB1287.namprd12.prod.outlook.com
 ([fe80::bc0f:dd2:ef80:de2%12]) with mapi id 15.20.3611.025; Sun, 29 Nov 2020
 07:22:56 +0000
From: "Chen, Guchun" <Guchun.Chen@amd.com>
To: Bas Nieuwenhuizen <bas@basnieuwenhuizen.nl>, "Kuehling, Felix"
 <Felix.Kuehling@amd.com>
Subject: RE: [PATCH v3] drm/amd/amdgpu: set the default value of noretry to 1
 for some dGPUs
Thread-Topic: [PATCH v3] drm/amd/amdgpu: set the default value of noretry to 1
 for some dGPUs
Thread-Index: AQHWoqSea8/RHrXrY06VY8TpxEe+5amYujGAgEXQZACAAG/W0A==
Date: Sun, 29 Nov 2020 07:22:56 +0000
Message-ID: <CY4PR12MB1287D8AA91368C4BCA99E47BF1F60@CY4PR12MB1287.namprd12.prod.outlook.com>
References: <20201015033557.3046-1-Jack.Gui@amd.com>
 <ccd27274-44e1-3bfc-24a8-e24750889efe@amd.com>
 <CAP+8YyF59Hnq=NgVbfV__GqMZ8y+HyNYRqoPo3hOBDUj1+CtZA@mail.gmail.com>
In-Reply-To: <CAP+8YyF59Hnq=NgVbfV__GqMZ8y+HyNYRqoPo3hOBDUj1+CtZA@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Enabled=true;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_SetDate=2020-11-29T07:18:38Z; 
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Method=Privileged;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Name=Public_0;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_ActionId=96257f6e-0b42-4f7f-b703-00002cb9ce40;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_ContentBits=1
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_enabled: true
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_setdate: 2020-11-29T07:22:53Z
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_method: Privileged
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_name: Public_0
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_actionid: 28c69859-8922-4a7c-a55f-00006902b896
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_contentbits: 0
authentication-results: basnieuwenhuizen.nl; dkim=none (message not signed)
 header.d=none;basnieuwenhuizen.nl; dmarc=none action=none
 header.from=amd.com;
x-originating-ip: [180.158.166.36]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: e9d75b69-f6e7-4bc1-eccc-08d89437981b
x-ms-traffictypediagnostic: CY4PR1201MB0184:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <CY4PR1201MB0184F9DD12296E44F5DEA626F1F60@CY4PR1201MB0184.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7691;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 9TUJBUNUVyI7h6W5ZMd+xxJ+2KEECkWoDG7JQg6u97W+6XrwLxSMzb/Qf94iAJ2upmEb5Iv1SdqqcmiLjpf/EnHLH8pWiOO9Ssl3OvvSZuW5FDn7ZBWYoYVo+yGqFmGKefJwujfA45bdKsC0opuQNxpdnCUoUs2ExeE6NB2g5q1uvgT2ziJ0XBqxxcWCibqR/XNgYfU5FBhhb1b6NHzKBtjv/QMKyhyBcECbrS8j2TJV3oQtRQ9EF2XMLquMDewB3ytuXwQN5ih5ZBlYrK8f7vB2hsmyS+7ygpopX95Xlp8WiaroIcXqSwiPRKUCIz0emH0nm989kiri9wGerfjh/PxmcQXhrmzGnje8Nn2Tme6t95T/KJzcNkg9s02cEp/aMRrmH+QuO0ZJQuO5ZcdDCg==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CY4PR12MB1287.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(376002)(366004)(346002)(136003)(396003)(39850400004)(966005)(86362001)(45080400002)(6636002)(478600001)(8936002)(55016002)(6506007)(4326008)(53546011)(4001150100001)(76116006)(54906003)(66446008)(64756008)(26005)(66556008)(110136005)(186003)(83380400001)(9686003)(66476007)(316002)(66946007)(5660300002)(7696005)(33656002)(52536014)(8676002)(71200400001)(2906002);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?QlP6cQejtYzP64Wc6se2gM86IPOVlfQd1yT7X/2jwmkdWTwPdQBBZF/hhTh8?=
 =?us-ascii?Q?1yditITKjZWSLwceVk+t75fcTnSMadTiJRVqvTqoQx29yzlkMpJ877GNGG6u?=
 =?us-ascii?Q?qANfffO3r+4lr+rV0UfFWcn2X+qCje/rltga9z5gb9aF677eMsQ4tmaQuaQL?=
 =?us-ascii?Q?iv03tl7VC5ExoySjtrbDx2+UOpnANNeiOu4hF946twYhvsbKpAQ4A/F9KG88?=
 =?us-ascii?Q?R2UFi/+btSxQTCMB9XN95VMwLt6KKTb0yqWCXo7xN+Uf44KvBNYs9wIg78Zo?=
 =?us-ascii?Q?9CqY4E1AS6gABo7j+qiaa2VVR9NICaWNH+NIITTKNV+EiY8c+nVG/sFZaq+v?=
 =?us-ascii?Q?osOYcfhFNHEhKfbiYiwSGZPG4Dcmcpnd/NF5hSCcz+l5kxwzSMpQQXR0b49q?=
 =?us-ascii?Q?hNB3fCp211jida0OGF+i6+GvkeIoxyeWFBTmkuz5LmZGk8qhK3Z4KZ1EnzZu?=
 =?us-ascii?Q?Cxjs+IK8Ped+lsI9qeVBE8I6NosborpoI5SIJN6W6GD5j9LhFgqNdr+v8ZZC?=
 =?us-ascii?Q?MtHKVVA2Q8wcYJozh9fKMnzVFXhY3A24A5JRrIJTMaGB3mD/fK69ObUXZVRs?=
 =?us-ascii?Q?1YiL0jrM88FiEyGPSM3x2Lxd34btURDa+3ZId2dqt6Lt/Ue8Qm+y4KC2KM5e?=
 =?us-ascii?Q?+OzP25jlrCMJIOFh4RunLMpoZZ6mmOW5zHMwb+50DFPnSuoVX6LjqFZZC2zA?=
 =?us-ascii?Q?gO99Oq60rdt9iWvmj//FLmIbY19q+hAT1GJru+M/vaKujDzxxS5Om7mZXzzF?=
 =?us-ascii?Q?q10hHwXCt6ihIoKrEh4in/2YW7MhT0gzRJzE3G5nmySRSlfeqUdagwCXMrqh?=
 =?us-ascii?Q?E7KU4HbrewWMFSiYt9ISEsYx80SaNF4JzN/eYW2aocQ9qohSXbdYd9zzgjed?=
 =?us-ascii?Q?6oiwDV7zyS5f5IaCw2itsNn43Oio7fTst/tKCWCudoevSk8Kr/ooni7hlKNt?=
 =?us-ascii?Q?4CBNbmPypJI8Q1tygNjsbj5nlluWT+qh/rtE5+PnroY=3D?=
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY4PR12MB1287.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e9d75b69-f6e7-4bc1-eccc-08d89437981b
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Nov 2020 07:22:56.7175 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: UcqPoEAIys5rEbRlSKYUGfp9aoBfZjVow5WBt/GInVJJy7BseyxZfZwGGCxca/6otS0zUQ9iCW6EWaCP+/hBCw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR1201MB0184
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
Cc: "Gui, Jack" <Jack.Gui@amd.com>, "Zhou1, Tao" <Tao.Zhou1@amd.com>,
 amd-gfx mailing list <amd-gfx@lists.freedesktop.org>, "Huang,
 Ray" <Ray.Huang@amd.com>, "Deucher, Alexander" <Alexander.Deucher@amd.com>,
 "Zhang, Hawking" <Hawking.Zhang@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Public Use]

Hi Bas Nieuwenhuizen,

I don't think direct revert is one right approach, though it's able to fix your problem.  noretry=0 will cause other test failure on several ASICs.

Regards,
Guchun

-----Original Message-----
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Bas Nieuwenhuizen
Sent: Sunday, November 29, 2020 8:38 AM
To: Kuehling, Felix <Felix.Kuehling@amd.com>
Cc: Gui, Jack <Jack.Gui@amd.com>; Chen, Guchun <Guchun.Chen@amd.com>; Zhou1, Tao <Tao.Zhou1@amd.com>; amd-gfx mailing list <amd-gfx@lists.freedesktop.org>; Huang, Ray <Ray.Huang@amd.com>; Deucher, Alexander <Alexander.Deucher@amd.com>; Zhang, Hawking <Hawking.Zhang@amd.com>
Subject: Re: [PATCH v3] drm/amd/amdgpu: set the default value of noretry to 1 for some dGPUs

Can we revert this patch to fix
https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Fgitlab.freedesktop.org%2Fdrm%2Famd%2F-%2Fissues%2F1374&amp;data=04%7C01%7Cguchun.chen%40amd.com%7C6d626e2a3bae4877024f08d893ff15db%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637422071085800476%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C1000&amp;sdata=Jxa2V1TuszoBKtF%2FPbIA3YwOrXHgLreBY%2FXej1HTZ4k%3D&amp;reserved=0 ?

On Thu, Oct 15, 2020 at 4:30 PM Felix Kuehling <felix.kuehling@amd.com> wrote:
>
> Am 2020-10-14 um 11:35 p.m. schrieb Chengming Gui:
> > noretry = 0 cause some dGPU's kfd page fault tests fail, so set 
> > noretry to 1 for these special ASICs:
> > vega20/navi10/navi14/ARCTURUS
> >
> > v2: merge raven and default case due to the same setting
> > v3: remove ARCTURUS
> >
> > Signed-off-by: Chengming Gui <Jack.Gui@amd.com>
> > Change-Id: I3be70f463a49b0cd5c56456431d6c2cb98b13872
>
> Acked-by: Felix Kuhling <Felix.Kuehling@amd.com>
>
>
> > ---
> >  drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c | 23 
> > +++++++++++++++--------
> >  1 file changed, 15 insertions(+), 8 deletions(-)
> >
> > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c 
> > b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
> > index 36604d751d62..f26eb4e54b12 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
> > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
> > @@ -425,20 +425,27 @@ void amdgpu_gmc_noretry_set(struct amdgpu_device *adev)
> >       struct amdgpu_gmc *gmc = &adev->gmc;
> >
> >       switch (adev->asic_type) {
> > -     case CHIP_RAVEN:
> > -             /* Raven currently has issues with noretry
> > -              * regardless of what we decide for other
> > -              * asics, we should leave raven with
> > -              * noretry = 0 until we root cause the
> > -              * issues.
> > +     case CHIP_VEGA20:
> > +     case CHIP_NAVI10:
> > +     case CHIP_NAVI14:
> > +             /*
> > +              * noretry = 0 will cause kfd page fault tests fail
> > +              * for some ASICs, so set default to 1 for these ASICs.
> >                */
> >               if (amdgpu_noretry == -1)
> > -                     gmc->noretry = 0;
> > +                     gmc->noretry = 1;
> >               else
> >                       gmc->noretry = amdgpu_noretry;
> >               break;
> > +     case CHIP_RAVEN:
> >       default:
> > -             /* default this to 0 for now, but we may want
> > +             /* Raven currently has issues with noretry
> > +              * regardless of what we decide for other
> > +              * asics, we should leave raven with
> > +              * noretry = 0 until we root cause the
> > +              * issues.
> > +              *
> > +              * default this to 0 for now, but we may want
> >                * to change this in the future for certain
> >                * GPUs as it can increase performance in
> >                * certain cases.
> _______________________________________________
> amd-gfx mailing list
> amd-gfx@lists.freedesktop.org
> https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Flist
> s.freedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;data=04%7C01%7Cgu
> chun.chen%40amd.com%7C6d626e2a3bae4877024f08d893ff15db%7C3dd8961fe4884
> e608e11a82d994e183d%7C0%7C0%7C637422071085800476%7CUnknown%7CTWFpbGZsb
> 3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%
> 7C1000&amp;sdata=VFqegGwPCj10q3Y5BdZsVq2a%2B4Tb358mYVDaNkA9zLU%3D&amp;
> reserved=0
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Flists.freedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;data=04%7C01%7Cguchun.chen%40amd.com%7C6d626e2a3bae4877024f08d893ff15db%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637422071085800476%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C1000&amp;sdata=VFqegGwPCj10q3Y5BdZsVq2a%2B4Tb358mYVDaNkA9zLU%3D&amp;reserved=0
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
