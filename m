Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 869B1C77B7C
	for <amd-gfx@archiver.kernel.org>; Thu, 11 May 2023 02:31:17 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0E43110E589;
	Thu, 11 May 2023 02:31:17 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2041.outbound.protection.outlook.com [40.107.236.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1B2EF10E589
 for <amd-gfx@lists.freedesktop.org>; Thu, 11 May 2023 02:31:14 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Rd2ga280z/ckSPyTYRd4tKfMaqOgQ600wMJwnB/WxP14c9s8SW12IKKbF694w2A4qDEs+ez78fS/3Xy27ITNC7tWYMqi0uwFLzgphSugp1tRSSZWKIzg3Rjbum/GHrK98oNP5XXsUUsLSRT9SISIfAm/iJa8o6/85X4BZ6uJP0pOo/+lpmMe0yQCi4q8C6iBdjlTQFBSsf75+QDOziA5nh0rzmSDQZAzy4zLxwE2fqmHiE293MLvfr+bA+7Lz3rhfyX7ZIvU46bUiPs79iujvXsD0Kde/+mQfuL237oZE8aY+KENfaQWPns+gMNg0wSvVlcuNwWGXoR7HR+P+vUrPw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Fq9rPgfmuwRCHPWoVI3FYACsovGKOsa/FWInUlOdzsQ=;
 b=Cd/DSAws2Rxuw5vF3Zl89BRE/oKHEf48YDwxtdakyESqDd7hZc3sBwwahvga5vLRlfffDClfQ4B0MntPP6rMw3ZSgzNkgQmzRSD7MjY9JZAzNW1EdoBi/RIeVx4qPj1Mo4rDhziJAtSqBMBsAQmZo4cfw+FwYq9p/ilXn8vBUXN7fgOyfO+LDxll/OIDzmhicHJap4SjsHTldfUGykhss1OCVTX0q2Qy7lyHlnlGPuagFrVKPuPl+F0RRFtSgQdC0j5bT0DdysbfG+JdQdjsp8c1cYO1EQNTWFXA8xhpsJTUBtNSCAqui0LtFCv1Ylf2V3QnBdLwpuvKoawroFas1A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Fq9rPgfmuwRCHPWoVI3FYACsovGKOsa/FWInUlOdzsQ=;
 b=XM69fndZaBUpRjwHAErvB34iGw+c5uatwxTBaHt3xnBJY1bMAVcYNzr3vzCCQ6y4OoRLMOcK8wckwC0mTtHrNH5ODWnjrBqXdIdvktz7+Ij/uFM5SAM8Hfdkec+N8bXIp6ik4r8nXafykLH6VGtzU/N894R/CQzMm8/Mw+obEyU=
Received: from SN1PR12MB2591.namprd12.prod.outlook.com (2603:10b6:802:30::32)
 by DM4PR12MB7694.namprd12.prod.outlook.com (2603:10b6:8:102::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6387.19; Thu, 11 May
 2023 02:31:11 +0000
Received: from SN1PR12MB2591.namprd12.prod.outlook.com
 ([fe80::18e1:c084:6d96:3228]) by SN1PR12MB2591.namprd12.prod.outlook.com
 ([fe80::18e1:c084:6d96:3228%4]) with mapi id 15.20.6363.032; Thu, 11 May 2023
 02:31:11 +0000
From: "Zhang, Horatio" <Hongkun.Zhang@amd.com>
To: "Zhang, Hawking" <Hawking.Zhang@amd.com>, "Zhou1, Tao"
 <Tao.Zhou1@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH 1/2] drm/amdgpu: fix amdgpu_irq_put call trace in
 jpeg_v4_0_hw_fini
Thread-Topic: [PATCH 1/2] drm/amdgpu: fix amdgpu_irq_put call trace in
 jpeg_v4_0_hw_fini
Thread-Index: AQHZgZasx4yv7EsXXkiG6DYL4plGza9QNtUAgAAYHwCAAOhZcIADJg6AgAAAQRA=
Date: Thu, 11 May 2023 02:31:10 +0000
Message-ID: <SN1PR12MB25914E8E84986E5E0B53FFDBF7749@SN1PR12MB2591.namprd12.prod.outlook.com>
References: <20230508101931.32544-1-Hongkun.Zhang@amd.com>
 <DM5PR12MB17705E6C9957FABED1BA9765B0719@DM5PR12MB1770.namprd12.prod.outlook.com>
 <BN9PR12MB5257E9F12A8C0FC2CF8B1A5CFC719@BN9PR12MB5257.namprd12.prod.outlook.com>
 <SN1PR12MB2591B9BCFB27E5F48156EF5BF7779@SN1PR12MB2591.namprd12.prod.outlook.com>
 <BN9PR12MB52573D335EEF399D2E5135A9FC749@BN9PR12MB5257.namprd12.prod.outlook.com>
In-Reply-To: <BN9PR12MB52573D335EEF399D2E5135A9FC749@BN9PR12MB5257.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2023-05-11T02:31:08Z; 
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=a490c4aa-82aa-485c-bbc1-c470b98a3163;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=1
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_enabled: true
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_setdate: 2023-05-11T02:31:08Z
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_method: Standard
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_name: General
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_actionid: f13bf2b6-84ce-4a53-b405-8e40681c499a
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_contentbits: 0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN1PR12MB2591:EE_|DM4PR12MB7694:EE_
x-ms-office365-filtering-correlation-id: e75a2488-5f54-4875-8259-08db51c7c868
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: GNQz/9QypUVGdabK9HBv68aE1QV/22lafA8nHwRyRdsX2vgFthmSgiM9QZzWdTyBc9JLCVuJ0ugVeVdoJrCXXgUk/YAltCms+OcyERx37Y8154TWh1hidVPIhcX31j+v5cU7A2IYI4zhLRLyaNNmfzD5mH8OJtX8XK+XqG+s3ZhdRYNq2WtXNwg9HbeoIF2PoE7kngF9g9djqyIRht59jtwFvjDW9/Xg1cb++pYjTM8RHnFwBplb3uo0tTIfTUSW2WQ0IxvaSSJUcDOLaGL0Q120x1gkNHa7JRaA5JiqicW9kZT4A/8utOqy2+NmyCNZCUI7NVlfQDlQKaJNjFohTR1wdf0VZ/zoUclUy/zNbllrqIaZf1wShXuvRdSqFPugEnbOfRgH5foaoJyyPvJULEW11MFUqHTWNh0f85kDX2tYx8NKwdmmBf3S4pM+qaasue5BebBN/sFDoR35JreJRi+Rr0X08mSWalU4acFv2PG3lKp4zeEshMR7OXma09yl+rKu1S9YH+Ev7oAFP2DE9UJQYDneHdRVtR9/xxkoYvLlUULcRLwCuht3B2aiD1Rr18tLNpbiGJAsKd79f7O4mUBkokQlUU9H4TD6/SJ7K+tiF4xNyOCo/DG6wMqU2PUaVymCFfxVDcLWPJCk2hJCog==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SN1PR12MB2591.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(4636009)(376002)(346002)(396003)(136003)(39860400002)(366004)(451199021)(66476007)(66446008)(4326008)(71200400001)(478600001)(7696005)(66946007)(64756008)(66556008)(76116006)(316002)(110136005)(54906003)(33656002)(86362001)(9686003)(83380400001)(26005)(186003)(6506007)(53546011)(8936002)(5660300002)(8676002)(2906002)(41300700001)(55016003)(52536014)(38100700002)(122000001)(38070700005)(21314003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?V78ERciEc1El9cVw8yTQZ4h0sOMwF0fEjZEIt5ResvPEvpsM66aF5adCTT6K?=
 =?us-ascii?Q?6DSd1cIBK+06sXSY0IZ9bTVcy+xMCcxrdoLz81H4KM8RYautYuyCVSEmciYv?=
 =?us-ascii?Q?rT204quZQmUl6XBEw0nztBmUGlF9b85RZHgw8uGFlknqz07YrHDbQ2JhuuDZ?=
 =?us-ascii?Q?C5IVB9zHZeejzO+mTp3tDllioDPvjnUXUcj5mKRO3LnVGrF2fPFBZP/0dpvo?=
 =?us-ascii?Q?nt+l2QhZ76AHUIYpO7slzFAMXNfFExRH09VliN5i+14d/UpFKlquYyYYPZvP?=
 =?us-ascii?Q?Qff93+4EPcB7v5mcdxQdR8eDjO9znDAyiwgn7xW8I7kZ/JUDoLZ5IoSLMwZt?=
 =?us-ascii?Q?rzdmxVXC8o8OFw20QFrzuPhi6OE2uTFBCc8l7x8kk63Svn8Bw+mOMOgaOzoO?=
 =?us-ascii?Q?6KLhg8jHpxfCHgNIyEac6+0bPmVo1P9EtNa7JVQml6ip16dh+DJhFL08XtNR?=
 =?us-ascii?Q?wpFHf9jbqW2tfsM6kHkrAaj5x6EprVNMTfX/EMLRF4WNb0u3Vp4J8pAmd7KH?=
 =?us-ascii?Q?KBXBGaRc49qoz90x41pdZr1EtxvfcZGR9ZOoIpfAxbRTjPw/5FiWtfB1fwmn?=
 =?us-ascii?Q?xq5WASVi4YgutEX06rGEXBJaR8dK1MpavcXHPnuQljtoMACOvZjOXLfE6Imz?=
 =?us-ascii?Q?ynZdwEMNwM74yJRAbfLDqr3sW0FDC5LI/yQZSjsQGMU6pJOF6NCK/gqAK/M/?=
 =?us-ascii?Q?8NO4mOuxoFUETGMC4Q9nBLVwjAziG+c2M4n2M3T1Gacsf6Ttz2hIaUJVr3W7?=
 =?us-ascii?Q?5nADjvQON7PH27FtX3ASy2aY0UNTZb/ch22dwOXAAJoFLMMrDPZ356pzETef?=
 =?us-ascii?Q?Ikt20LKPxfhdYPaBpQ4WIv4zUC1jKo5FQ9woBW88rGhWWm/LTxxy0qeLHOft?=
 =?us-ascii?Q?TeCLoWppZQN4NHbqcmeSDSigkI08GK9pPqFl7aTtUuWhyii8CW7WfHpaKTv+?=
 =?us-ascii?Q?/kzjv/2jppcsRIAGTERxLnMCipB4EFrg3fm8Dzuk11a0s5/1Xcb0h02CGMRL?=
 =?us-ascii?Q?6alFvG0qRhtqXcTHIxLLvdtOLrorChepD1lbAYS9AHPMtobZQ+eUq6BGERk1?=
 =?us-ascii?Q?Di7YKRcQ7kudYTC8nD+LlX3sxJ/T0J59V1Mq66zAtgkHbDE81oQ9nUip3Ghy?=
 =?us-ascii?Q?G8lK8/k6ICkdczyVznMgGxwr2TbLIyYQUM2Psi0dkjgC16592IUlwIVjikDG?=
 =?us-ascii?Q?wFTdAD5Iwa6LhEjMU8FOVyHyF+Xz4YJiY8Ed2a/djuGEGIMtdysa1nP9y1vZ?=
 =?us-ascii?Q?LRTN+1NqThEbQ/FSfAFMYNPrUkzj2KL53k+an0dYXr/2iTDomdVzJRI2i0Hd?=
 =?us-ascii?Q?LfZOyrkI7pYyWUmlWBQ4I9XqELaLYk1joHvNSRKDbA4QoL0EkyhKY6wu/eNK?=
 =?us-ascii?Q?LyfyvSuLoxAoAnjhMlfDzolbHH+Cro4gjD5HdI3VuA0jKjDbXS16VBJKypOj?=
 =?us-ascii?Q?1tgVbiIryPrV6hBjbMIXJfz7eruqaQ2myM28Z2yQy5P8WHK553tcad0Wz7fb?=
 =?us-ascii?Q?MIJuGHccmOLjEaj8X6g/9RgzD65IXwYVlCGFLE9roGkhUpWPjU8Q3TLZ+KLa?=
 =?us-ascii?Q?kLv8LLC2wSRGy9pylO8=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN1PR12MB2591.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e75a2488-5f54-4875-8259-08db51c7c868
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 May 2023 02:31:10.5402 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: AqCVl03I1Zao1kfJhnNtVsSVpzITSINL795oH6rSiUimJ9ayorIAog5ECgCndeiqIIUAA+bOqT8Tu0URvHAtmg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB7694
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
Cc: "Liu, HaoPing \(Alan\)" <HaoPing.Liu@amd.com>, "Zhou,
 Bob" <Bob.Zhou@amd.com>, "Xu, Feifei" <Feifei.Xu@amd.com>, "Jiang, 
 Sonny" <Sonny.Jiang@amd.com>, "Limonciello, Mario" <Mario.Limonciello@amd.com>,
 "Liu, Leo" <Leo.Liu@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Official Use Only - General]

Got it!

Thanks,
Horatio

-----Original Message-----
From: Zhang, Hawking <Hawking.Zhang@amd.com>=20
Sent: Thursday, May 11, 2023 10:28 AM
To: Zhang, Horatio <Hongkun.Zhang@amd.com>; Zhou1, Tao <Tao.Zhou1@amd.com>;=
 amd-gfx@lists.freedesktop.org
Cc: Xu, Feifei <Feifei.Xu@amd.com>; Liu, Leo <Leo.Liu@amd.com>; Jiang, Sonn=
y <Sonny.Jiang@amd.com>; Limonciello, Mario <Mario.Limonciello@amd.com>; Li=
u, HaoPing (Alan) <HaoPing.Liu@amd.com>; Zhou, Bob <Bob.Zhou@amd.com>
Subject: RE: [PATCH 1/2] drm/amdgpu: fix amdgpu_irq_put call trace in jpeg_=
v4_0_hw_fini

[AMD Official Use Only - General]

Please register dedicated ras_irq src and funcs for UVD_POISON, which shoul=
d allow you to create vcn ras sw calls like gfx/sdma ip block.

Regards,
Hawking

-----Original Message-----
From: Zhang, Horatio <Hongkun.Zhang@amd.com>
Sent: Wednesday, May 10, 2023 18:55
To: Zhang, Hawking <Hawking.Zhang@amd.com>; Zhou1, Tao <Tao.Zhou1@amd.com>;=
 amd-gfx@lists.freedesktop.org
Cc: Xu, Feifei <Feifei.Xu@amd.com>; Liu, Leo <Leo.Liu@amd.com>; Jiang, Sonn=
y <Sonny.Jiang@amd.com>; Limonciello, Mario <Mario.Limonciello@amd.com>; Li=
u, HaoPing (Alan) <HaoPing.Liu@amd.com>; Zhou, Bob <Bob.Zhou@amd.com>
Subject: RE: [PATCH 1/2] drm/amdgpu: fix amdgpu_irq_put call trace in jpeg_=
v4_0_hw_fini

[AMD Official Use Only - General]

Hi Hawking,

When modprobe, the interrupt of jpeg/vcn was enabled in amdgpu_fence_driver=
_hw_init(). If the amdgpu_irq_get function is added in amdgpu_xxx_ras_late_=
init/xxx_v4_0_late_init, it will enable the instance interrupt twice.=20
My previous modification plan also had this issue. Perhaps we should remove=
 the amdgpu_irq_put function from jpeg/vcn_v4_0_hw_fini.

Regards,
Horatio

-----Original Message-----
From: Zhang, Hawking <Hawking.Zhang@amd.com>
Sent: Monday, May 8, 2023 8:32 PM
To: Zhou1, Tao <Tao.Zhou1@amd.com>; Zhang, Horatio <Hongkun.Zhang@amd.com>;=
 amd-gfx@lists.freedesktop.org
Cc: Xu, Feifei <Feifei.Xu@amd.com>; Liu, Leo <Leo.Liu@amd.com>; Jiang, Sonn=
y <Sonny.Jiang@amd.com>; Limonciello, Mario <Mario.Limonciello@amd.com>; Li=
u, HaoPing (Alan) <HaoPing.Liu@amd.com>; Zhang, Horatio <Hongkun.Zhang@amd.=
com>
Subject: RE: [PATCH 1/2] drm/amdgpu: fix amdgpu_irq_put call trace in jpeg_=
v4_0_hw_fini

[AMD Official Use Only - General]

Shall we consider creating amdgpu_vcn_ras_late_init as a common helper for =
interrupt enablement, like other IP blocks. This also reduces further effor=
t when RAS feature is introduced in new version of vcn/jpeg

Regards,
Hawking

-----Original Message-----
From: Zhou1, Tao <Tao.Zhou1@amd.com>
Sent: Monday, May 8, 2023 19:06
To: Zhang, Horatio <Hongkun.Zhang@amd.com>; amd-gfx@lists.freedesktop.org
Cc: Zhang, Hawking <Hawking.Zhang@amd.com>; Xu, Feifei <Feifei.Xu@amd.com>;=
 Liu, Leo <Leo.Liu@amd.com>; Jiang, Sonny <Sonny.Jiang@amd.com>; Limonciell=
o, Mario <Mario.Limonciello@amd.com>; Liu, HaoPing (Alan) <HaoPing.Liu@amd.=
com>; Zhang, Horatio <Hongkun.Zhang@amd.com>
Subject: RE: [PATCH 1/2] drm/amdgpu: fix amdgpu_irq_put call trace in jpeg_=
v4_0_hw_fini

[AMD Official Use Only - General]

The series is:

Reviewed-by: Tao Zhou <tao.zhou1@amd.com>

> -----Original Message-----
> From: Horatio Zhang <Hongkun.Zhang@amd.com>
> Sent: Monday, May 8, 2023 6:20 PM
> To: amd-gfx@lists.freedesktop.org
> Cc: Zhang, Hawking <Hawking.Zhang@amd.com>; Zhou1, Tao=20
> <Tao.Zhou1@amd.com>; Xu, Feifei <Feifei.Xu@amd.com>; Liu, Leo=20
> <Leo.Liu@amd.com>; Jiang, Sonny <Sonny.Jiang@amd.com>; Limonciello,=20
> Mario <Mario.Limonciello@amd.com>; Liu, HaoPing (Alan)=20
> <HaoPing.Liu@amd.com>; Zhang, Horatio <Hongkun.Zhang@amd.com>
> Subject: [PATCH 1/2] drm/amdgpu: fix amdgpu_irq_put call trace in=20
> jpeg_v4_0_hw_fini
>=20
> During the suspend, the jpeg_v4_0_hw_init function will use the=20
> amdgpu_irq_put to disable the irq of jpeg.inst, but it was not enabled=20
> during the resume process, which resulted in a call trace during the GPU =
reset process.
>=20
> [   50.497562] RIP: 0010:amdgpu_irq_put+0xa4/0xc0 [amdgpu]
> [   50.497619] RSP: 0018:ffffaa2400fcfcb0 EFLAGS: 00010246
> [   50.497620] RAX: 0000000000000000 RBX: 0000000000000001 RCX:
> 0000000000000000
> [   50.497621] RDX: 0000000000000000 RSI: 0000000000000000 RDI:
> 0000000000000000
> [   50.497621] RBP: ffffaa2400fcfcd0 R08: 0000000000000000 R09:
> 0000000000000000
> [   50.497622] R10: 0000000000000000 R11: 0000000000000000 R12:
> ffff99b2105242d8
> [   50.497622] R13: 0000000000000000 R14: ffff99b210500000 R15:
> ffff99b210500000
> [   50.497623] FS:  0000000000000000(0000) GS:ffff99b518480000(0000)
> knlGS:0000000000000000
> [   50.497623] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [   50.497624] CR2: 00007f9d32aa91e8 CR3: 00000001ba210000 CR4:
> 0000000000750ee0
> [   50.497624] PKRU: 55555554
> [   50.497625] Call Trace:
> [   50.497625]  <TASK>
> [   50.497627]  jpeg_v4_0_hw_fini+0x43/0xc0 [amdgpu]
> [   50.497693]  jpeg_v4_0_suspend+0x13/0x30 [amdgpu]
> [   50.497751]  amdgpu_device_ip_suspend_phase2+0x240/0x470 [amdgpu]
> [   50.497802]  amdgpu_device_ip_suspend+0x41/0x80 [amdgpu]
> [   50.497854]  amdgpu_device_pre_asic_reset+0xd9/0x4a0 [amdgpu]
> [   50.497905]  amdgpu_device_gpu_recover.cold+0x548/0xcf1 [amdgpu]
> [   50.498005]  amdgpu_debugfs_reset_work+0x4c/0x80 [amdgpu]
> [   50.498060]  process_one_work+0x21f/0x400
> [   50.498063]  worker_thread+0x200/0x3f0
> [   50.498064]  ? process_one_work+0x400/0x400
> [   50.498065]  kthread+0xee/0x120
> [   50.498067]  ? kthread_complete_and_exit+0x20/0x20
> [   50.498068]  ret_from_fork+0x22/0x30
>=20
> Fixes: 86e8255f941e ("drm/amdgpu: add JPEG 4.0 RAS poison consumption
> handling")
> Signed-off-by: Horatio Zhang <Hongkun.Zhang@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/jpeg_v4_0.c | 9 ++++++++-
>  1 file changed, 8 insertions(+), 1 deletion(-)
>=20
> diff --git a/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0.c
> b/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0.c
> index 77e1e64aa1d1..b5c14a166063 100644
> --- a/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0.c
> @@ -66,6 +66,13 @@ static int jpeg_v4_0_early_init(void *handle)
>  	return 0;
>  }
>=20
> +static int jpeg_v4_0_late_init(void *handle) {
> +	struct amdgpu_device *adev =3D (struct amdgpu_device *)handle;
> +
> +	return amdgpu_irq_get(adev, &adev->jpeg.inst->irq, 0); }
> +
>  /**
>   * jpeg_v4_0_sw_init - sw init for JPEG block
>   *
> @@ -696,7 +703,7 @@ static int jpeg_v4_0_process_interrupt(struct
> amdgpu_device *adev,  static const struct amd_ip_funcs jpeg_v4_0_ip_funcs=
 =3D {
>  	.name =3D "jpeg_v4_0",
>  	.early_init =3D jpeg_v4_0_early_init,
> -	.late_init =3D NULL,
> +	.late_init =3D jpeg_v4_0_late_init,
>  	.sw_init =3D jpeg_v4_0_sw_init,
>  	.sw_fini =3D jpeg_v4_0_sw_fini,
>  	.hw_init =3D jpeg_v4_0_hw_init,
> --
> 2.34.1
