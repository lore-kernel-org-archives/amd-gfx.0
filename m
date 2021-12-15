Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BFA7BC433F5
	for <amd-gfx@archiver.kernel.org>; Wed, 15 Dec 2021 19:18:38 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 282FC10F8EB;
	Wed, 15 Dec 2021 19:18:38 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2067.outbound.protection.outlook.com [40.107.220.67])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4854B10F8EE
 for <amd-gfx@lists.freedesktop.org>; Wed, 15 Dec 2021 19:18:37 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GoVqG8OqcRR4NHPXyHRt8XXzmsNSOJvkc9UdFE81K1C+e6G1i9ubqSQ8m1ZD3lJLzbCXmgyeRVcMuBciWDEgi+ifdu6pH5UuIup+I/rwxolJW85SrVzRq0i5PFxXHvaZXE4Ykz3qYKMElcY7CSfx9q4OOt3trFkZgpE5ylU5XjhUqdpLAirXf78m0hlPzPpzd/gLImwAevf2E7WSXC2xsz3BupVM5dBUEQzXBXJdpJiGI7ZLDYtoqjGEdmirhYaBWfnrXXuMJ6V3ZGfgadNK+j+PO49LZkRDqPJzeZU6geBb89/eE/zccDKQsyN2HZjIsbH+d7/lgNSnJdqlSbDYSw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TGhNKyX4NUccikDc4IabnkNNYbfRKPlyBFMaJTmuJU4=;
 b=c2zN/n+GQpMJliiFD6BtZguEFhRuC6ILyTd0K4h6ClxJy9wtTM+P/+Xb8e2SXax+gFnPkDIkb+a+h6DbDa8G0SeN/hPTLeIUdjp40QHKGAkFhJwPt63ICtN7q3mnUUH0IMNqCbD7oE7qsHNdiIcNgSiB/NJaeoTkTzc3oPKpY12Iof63TtAS0z4VToa42AT/QNFFnf9ehnfcBETweeRFGkXQ4gEeQPPKEZx7yKEZ+1J1c755dv8QhamwqVzdYcLNdb/kdnyp+F644FoRixMcxDn29npPuN8PAs5XoW05S8dc8d6/2AxF3lvYhfWCE8lnEwp+HDpNFY9x7wzSxuYqlg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TGhNKyX4NUccikDc4IabnkNNYbfRKPlyBFMaJTmuJU4=;
 b=GbRj48N4v+n+pYONWyv2osQO1hn7CmWeeOxTUkfFzlqCd5i83ykHYqEFZ3N4coCSkhRhigt1LD7EQtdNwc9KcS4A6jubjH1hgFbtY+V+36pqzdd3WHTPomBJD9lqtazGmmeCZgnfFnAz2Ust45HwrIJizkiIxnwhytzM3UeCoSA=
Received: from BN9PR12MB5324.namprd12.prod.outlook.com (2603:10b6:408:105::15)
 by BN9PR12MB5324.namprd12.prod.outlook.com (2603:10b6:408:105::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4778.16; Wed, 15 Dec
 2021 19:18:34 +0000
Received: from BN9PR12MB5324.namprd12.prod.outlook.com
 ([fe80::a10e:e3e6:7760:fd5a]) by BN9PR12MB5324.namprd12.prod.outlook.com
 ([fe80::a10e:e3e6:7760:fd5a%3]) with mapi id 15.20.4778.018; Wed, 15 Dec 2021
 19:18:34 +0000
From: "Skvortsov, Victor" <Victor.Skvortsov@amd.com>
To: "Nieto, David M" <David.Nieto@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>, "Deng, Emily" <Emily.Deng@amd.com>, "Liu,
 Monk" <Monk.Liu@amd.com>, "Ming, Davis" <Davis.Ming@amd.com>, "Liu, Shaoyun"
 <Shaoyun.Liu@amd.com>, "Zhou, Peng Ju" <PengJu.Zhou@amd.com>, "Chen, JingWen"
 <JingWen.Chen2@amd.com>, "Chen, Horace" <Horace.Chen@amd.com>
Subject: RE: [PATCH 5/5] drm/amdgpu: Modify indirect register access for gfx9
 sriov
Thread-Topic: [PATCH 5/5] drm/amdgpu: Modify indirect register access for gfx9
 sriov
Thread-Index: AQHX8eVYmuBqCA4Fe0WzC0Whr/cJRqwz7J6AgAAAGvA=
Date: Wed, 15 Dec 2021 19:18:34 +0000
Message-ID: <BN9PR12MB5324E5F73B6CD4829091DE6E8B769@BN9PR12MB5324.namprd12.prod.outlook.com>
References: <20211215185510.15134-1-victor.skvortsov@amd.com>
 <20211215185510.15134-6-victor.skvortsov@amd.com>
 <BYAPR12MB2840F2BD83E7E075F7EF40D0F4769@BYAPR12MB2840.namprd12.prod.outlook.com>
In-Reply-To: <BYAPR12MB2840F2BD83E7E075F7EF40D0F4769@BYAPR12MB2840.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Enabled=true;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SetDate=2021-12-15T19:18:31Z; 
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Method=Standard;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Name=AMD Official Use
 Only-AIP 2.0;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ContentBits=1
msip_label_88914ebd-7e6c-4e12-a031-a9906be2db14_enabled: true
msip_label_88914ebd-7e6c-4e12-a031-a9906be2db14_setdate: 2021-12-15T19:18:31Z
msip_label_88914ebd-7e6c-4e12-a031-a9906be2db14_method: Standard
msip_label_88914ebd-7e6c-4e12-a031-a9906be2db14_name: AMD Official Use
 Only-AIP 2.0
msip_label_88914ebd-7e6c-4e12-a031-a9906be2db14_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_88914ebd-7e6c-4e12-a031-a9906be2db14_actionid: aa39872e-fda5-4e35-81f4-4579f81f2e91
msip_label_88914ebd-7e6c-4e12-a031-a9906be2db14_contentbits: 0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 29d32153-6e11-4cc9-751b-08d9bfffb05e
x-ms-traffictypediagnostic: BN9PR12MB5324:EE_
x-microsoft-antispam-prvs: <BN9PR12MB532456F2241C567D598A06EF8B769@BN9PR12MB5324.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:4502;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: voKYE5kbMZTdSbdHiuc3/lflusp7EPdS8rSkjkQY57eRC7hptOSDQdhxj9POzgPWSWXM215lgXxeQymEO/agVcusKL4f3GIuJEEvzyL8JON/EiU20hi+qMuVoO8ueJvb3HAlkJX9ziLXGlHT+3Z15CR5z+BLPLJZ/t46esbHNwWzJ67m8N54dXJBc+fS8WHEARY9/Dmd4RXo+4Y4+bAdlZtNGXQafWfClPaHb9mPF7rS4TXs/ShwU+rQ415NFLBMRIUU6nLTugkPVv/CrMYvuY68IeOMiWqcb8GvxV6xU03xN4fAWPxwSRO693jcTB+qmqMPxj++Xs26V2JASBNnpkrdSE0ecKSnTeqGHQW+sjLOGCe4CP0iiA2zUcEfpLWUH+BQ3is5GqEIPXA5LtLiWiIcQf0ScqMzJEi/zK1er7NfDMIEt4by9EZ9CbnMK8nJBGRjb3D3jxIoKdmneQxLpACPk6IkacX3xB06owdHXTXMKy3ajaRJ0b89QEIGCCHLUo4F+xU6oKUwj4IUaLLk3+HU9bxRsovMM1m7GAfXb12dsl4j6c59K8nrK/wJY1aTcaefghKGiObKIXb5GJUuP+vu77Nd94BIcRWKsxBEc/GoZvxNX04Ke3bYOZHNLFMnNDV5BiJ6SJH2/n8NfkT+e8bgwMZFkZDr7VdhxqUAqQn2fCVIidoT0mlFWmt9aYEcPKkDQbDdbBG2hPk3BheqRfqei4A25pLjniWgFXTWJec=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5324.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(55016003)(38100700002)(76116006)(8936002)(8676002)(2906002)(7696005)(110136005)(71200400001)(26005)(122000001)(33656002)(86362001)(83380400001)(5660300002)(64756008)(66556008)(52536014)(66476007)(508600001)(66946007)(921005)(6506007)(9686003)(186003)(66446008)(38070700005)(53546011)(6636002)(316002);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?OTYnJzkrMeRTw+uNx4iPFrNzVmA8Lbl2LkDKObXCQOXsXaSMP9jrZZ7Bo5Y5?=
 =?us-ascii?Q?FU/FGRgg1kzavY8QmyQ85rXl3F6xCxxd+ZWFKh/SfT3t/ToP1iKA3VJdViHY?=
 =?us-ascii?Q?buie9VdCyR5sRNhzlVkQCKq7NXZMpCHmDFC0UFoT4nwMcBhN/kCayyCitzw8?=
 =?us-ascii?Q?tBVYknjw519KJ6/VTSdX4Ygx6uyhNmcHkL10vdiL5EQpIXiZm+vDZy34BG1L?=
 =?us-ascii?Q?mtSk/aDS9KxdqKzlV65Lzrn4aT88aYkCcA4bN0By4a2DKN7aLMke3yOjKWUv?=
 =?us-ascii?Q?t1wm569U/2Y+gQHNWa8ZirEd+SZt+4IOTVFba+wR/pzwnXRnxRZ+R9nrN3ug?=
 =?us-ascii?Q?S7bDzwUyREKdbUtNouhauMXk+yPaYNkXjEURKzweB19KY4kD4bhpTmoxdvxD?=
 =?us-ascii?Q?qIF89gWs9BHu0c3HN0a+OnSPDfbwA+YkQHzuIYmsl9czYwq26UDZBUKw/qjJ?=
 =?us-ascii?Q?yGnGLll7XrO6Zkgda/jaAWl3UdrsTKi0a7mJPJhPpj4mgxlyriWPhI6N46PR?=
 =?us-ascii?Q?Lo3eCBEBJ7TKBZ0RN2JZcPjJV1ugY2tAYJtbftcFqIQLElEJYl1ezgeX1CQ2?=
 =?us-ascii?Q?8sza10lPFfR0srK0eJI8BC9dNDu0O9gH8LDt9luf7QZgsxgQX2mtfDb5MpUk?=
 =?us-ascii?Q?hCEOVunTNCKl+mlQy1XkQ1csTZo1+teMRxE02eYw8S1GAIESFt5deZZUFvgQ?=
 =?us-ascii?Q?w8Qvrx6vtHsC6db/id14on4zkAap5zOy8kZ2TkQHi2D+9Z73r1YAKXuKclJP?=
 =?us-ascii?Q?hDQIApfMe2jHX72SBz5QXvSWxf6uO/4oPu9l3m8JPZqrCh+CJQFEXCfxHWwm?=
 =?us-ascii?Q?W8GNDEfzQdzlCT8SIlYf9LMUHIStz4xEhyKIJLJ8Mm+cM9hxEnpe4kQ2L8pl?=
 =?us-ascii?Q?+6vHSArirs/UHxyS1zdwad83PdUxANYcJ/5GsbaGMC2RUZyZcK/eifYzrAhe?=
 =?us-ascii?Q?UYRaa7nYwWFzpcUYg/DsU+vd6yrJcFQUBOjpe4lGh4h8rgvJMzZ5jUELPI33?=
 =?us-ascii?Q?JBW3sC1NZpf7Q/dxI5iu/VUpkJ3Q6zaI0MPMk5HEBRGEv5Qg7ScDH/xP9fBf?=
 =?us-ascii?Q?kr00nH4elHlXbpyCrpJkqyGdgoUwsEZE2d4+WrjycNuijfDS/QDfyPGdYt1Y?=
 =?us-ascii?Q?sK3MiK2KtkCWHZWXawZIJTnxRBXgXqhj+BXUreBTWWPFcfVIIkPFno0s9nlL?=
 =?us-ascii?Q?gJ42DcPxTcZOEaHIEAJSBc/oBEaABVd4loEQYwFjXRCwcQoWES6dHe/Bj2P7?=
 =?us-ascii?Q?z4eWCIzjqDN4k85LKBY534opR5wSd57vuIEdYjhshK9RCISi77DmN5sY4fBc?=
 =?us-ascii?Q?HvZhQ8eIpgA6QSxSSBR3mw5h0zZLL9j7Z3QDEaM6Pb+SHoqwnt7SO8nGZOJa?=
 =?us-ascii?Q?pj7DPyZOM3ZeBhIxzpPW3JpvU2ICU1b//2UF/iSakZurOHeCD0oMJtmemJ/O?=
 =?us-ascii?Q?PUmSy3E+qSpsUqtpvycaJje9KxeWmfSdEwdZsshRpSaU0vcSxhWfHxu1p6Rb?=
 =?us-ascii?Q?vjqMpBDcfKzQhJSaesBfYLssnmpUV6Wl7wke+sqACvxTQGNQOzHG/wJdYl08?=
 =?us-ascii?Q?gEhzSrc0VAADxVuQcLrfIWgcdFx/169CFVAYsJn8FvaCDq898c93whNA7K0m?=
 =?us-ascii?Q?0ihNTJkUJ1vz24SHfK4IIZA=3D?=
Content-Type: multipart/alternative;
 boundary="_000_BN9PR12MB5324E5F73B6CD4829091DE6E8B769BN9PR12MB5324namp_"
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5324.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 29d32153-6e11-4cc9-751b-08d9bfffb05e
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Dec 2021 19:18:34.4450 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: BqL1hvwKKu0MpI+D7wWD2GdapL8eLyXiP/CnzbvMlmEsfECefVxsBh9R1jR/i4Bp+4v91pvEg6RVAHIt3lg77A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR12MB5324
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
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--_000_BN9PR12MB5324E5F73B6CD4829091DE6E8B769BN9PR12MB5324namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

[AMD Official Use Only]

This was a bug in the original definition, but it functionally it makes no =
difference (in both cases the macros resolve to the same value).

From: Nieto, David M <David.Nieto@amd.com>
Sent: Wednesday, December 15, 2021 2:16 PM
To: Skvortsov, Victor <Victor.Skvortsov@amd.com>; amd-gfx@lists.freedesktop=
.org; Deng, Emily <Emily.Deng@amd.com>; Liu, Monk <Monk.Liu@amd.com>; Ming,=
 Davis <Davis.Ming@amd.com>; Liu, Shaoyun <Shaoyun.Liu@amd.com>; Zhou, Peng=
 Ju <PengJu.Zhou@amd.com>; Chen, JingWen <JingWen.Chen2@amd.com>; Chen, Hor=
ace <Horace.Chen@amd.com>
Subject: Re: [PATCH 5/5] drm/amdgpu: Modify indirect register access for gf=
x9 sriov


[AMD Official Use Only]

         scratch_reg0 =3D adev->rmmio + (adev->reg_offset[GC_HWIP][0][mmSCR=
ATCH_REG0_BASE_IDX] + mmSCRATCH_REG0)*4;
         scratch_reg1 =3D adev->rmmio + (adev->reg_offset[GC_HWIP][0][mmSCR=
ATCH_REG1_BASE_IDX] + mmSCRATCH_REG1)*4;
-       scratch_reg2 =3D adev->rmmio + (adev->reg_offset[GC_HWIP][0][mmSCRA=
TCH_REG1_BASE_IDX] + mmSCRATCH_REG2)*4;
-       scratch_reg3 =3D adev->rmmio + (adev->reg_offset[GC_HWIP][0][mmSCRA=
TCH_REG1_BASE_IDX] + mmSCRATCH_REG3)*4;
+       scratch_reg2 =3D adev->rmmio + (adev->reg_offset[GC_HWIP][0][mmSCRA=
TCH_REG2_BASE_IDX] + mmSCRATCH_REG2)*4;
+       scratch_reg3 =3D adev->rmmio + (adev->reg_offset[GC_HWIP][0][mmSCRA=
TCH_REG3_BASE_IDX] + mmSCRATCH_REG3)*4;
         spare_int =3D adev->rmmio + (adev->reg_offset[GC_HWIP][0][mmRLC_SP=
ARE_INT_BASE_IDX] + mmRLC_SPARE_INT)*4;

the definition of scratch_reg2 and 3 has here.... will this be backwards co=
mpatible? Was it a bug in the definition?
________________________________
From: Skvortsov, Victor <Victor.Skvortsov@amd.com<mailto:Victor.Skvortsov@a=
md.com>>
Sent: Wednesday, December 15, 2021 10:55 AM
To: amd-gfx@lists.freedesktop.org<mailto:amd-gfx@lists.freedesktop.org> <am=
d-gfx@lists.freedesktop.org<mailto:amd-gfx@lists.freedesktop.org>>; Deng, E=
mily <Emily.Deng@amd.com<mailto:Emily.Deng@amd.com>>; Liu, Monk <Monk.Liu@a=
md.com<mailto:Monk.Liu@amd.com>>; Ming, Davis <Davis.Ming@amd.com<mailto:Da=
vis.Ming@amd.com>>; Liu, Shaoyun <Shaoyun.Liu@amd.com<mailto:Shaoyun.Liu@am=
d.com>>; Zhou, Peng Ju <PengJu.Zhou@amd.com<mailto:PengJu.Zhou@amd.com>>; C=
hen, JingWen <JingWen.Chen2@amd.com<mailto:JingWen.Chen2@amd.com>>; Chen, H=
orace <Horace.Chen@amd.com<mailto:Horace.Chen@amd.com>>; Nieto, David M <Da=
vid.Nieto@amd.com<mailto:David.Nieto@amd.com>>
Cc: Skvortsov, Victor <Victor.Skvortsov@amd.com<mailto:Victor.Skvortsov@amd=
.com>>
Subject: [PATCH 5/5] drm/amdgpu: Modify indirect register access for gfx9 s=
riov

Expand RLCG interface for new GC read & write commands.
New interface will only be used if the PF enables the flag in pf2vf msg.

Signed-off-by: Victor Skvortsov <victor.skvortsov@amd.com<mailto:victor.skv=
ortsov@amd.com>>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c | 111 +++++++++++++++++++-------
 1 file changed, 83 insertions(+), 28 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c b/drivers/gpu/drm/amd/am=
dgpu/gfx_v9_0.c
index d252b06efa43..bce6ab52cae0 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
@@ -63,6 +63,13 @@
 #define mmGCEA_PROBE_MAP                        0x070c
 #define mmGCEA_PROBE_MAP_BASE_IDX               0

+#define GFX9_RLCG_GC_WRITE_OLD                 (0x8 << 28)
+#define GFX9_RLCG_GC_WRITE                     (0x0 << 28)
+#define GFX9_RLCG_GC_READ                      (0x1 << 28)
+#define GFX9_RLCG_VFGATE_DISABLED              0x4000000
+#define GFX9_RLCG_WRONG_OPERATION_TYPE         0x2000000
+#define GFX9_RLCG_NOT_IN_RANGE                 0x1000000
+
 MODULE_FIRMWARE("amdgpu/vega10_ce.bin");
 MODULE_FIRMWARE("amdgpu/vega10_pfp.bin");
 MODULE_FIRMWARE("amdgpu/vega10_me.bin");
@@ -739,7 +746,7 @@ static const u32 GFX_RLC_SRM_INDEX_CNTL_DATA_OFFSETS[] =
=3D
         mmRLC_SRM_INDEX_CNTL_DATA_7 - mmRLC_SRM_INDEX_CNTL_DATA_0,
 };

-static void gfx_v9_0_rlcg_w(struct amdgpu_device *adev, u32 offset, u32 v,=
 u32 flag)
+static u32 gfx_v9_0_rlcg_rw(struct amdgpu_device *adev, u32 offset, u32 v,=
 uint32_t flag)
 {
         static void *scratch_reg0;
         static void *scratch_reg1;
@@ -748,21 +755,20 @@ static void gfx_v9_0_rlcg_w(struct amdgpu_device *ade=
v, u32 offset, u32 v, u32 f
         static void *spare_int;
         static uint32_t grbm_cntl;
         static uint32_t grbm_idx;
+       uint32_t i =3D 0;
+       uint32_t retries =3D 50000;
+       u32 ret =3D 0;
+       u32 tmp;

         scratch_reg0 =3D adev->rmmio + (adev->reg_offset[GC_HWIP][0][mmSCR=
ATCH_REG0_BASE_IDX] + mmSCRATCH_REG0)*4;
         scratch_reg1 =3D adev->rmmio + (adev->reg_offset[GC_HWIP][0][mmSCR=
ATCH_REG1_BASE_IDX] + mmSCRATCH_REG1)*4;
-       scratch_reg2 =3D adev->rmmio + (adev->reg_offset[GC_HWIP][0][mmSCRA=
TCH_REG1_BASE_IDX] + mmSCRATCH_REG2)*4;
-       scratch_reg3 =3D adev->rmmio + (adev->reg_offset[GC_HWIP][0][mmSCRA=
TCH_REG1_BASE_IDX] + mmSCRATCH_REG3)*4;
+       scratch_reg2 =3D adev->rmmio + (adev->reg_offset[GC_HWIP][0][mmSCRA=
TCH_REG2_BASE_IDX] + mmSCRATCH_REG2)*4;
+       scratch_reg3 =3D adev->rmmio + (adev->reg_offset[GC_HWIP][0][mmSCRA=
TCH_REG3_BASE_IDX] + mmSCRATCH_REG3)*4;
         spare_int =3D adev->rmmio + (adev->reg_offset[GC_HWIP][0][mmRLC_SP=
ARE_INT_BASE_IDX] + mmRLC_SPARE_INT)*4;

         grbm_cntl =3D adev->reg_offset[GC_HWIP][0][mmGRBM_GFX_CNTL_BASE_ID=
X] + mmGRBM_GFX_CNTL;
         grbm_idx =3D adev->reg_offset[GC_HWIP][0][mmGRBM_GFX_INDEX_BASE_ID=
X] + mmGRBM_GFX_INDEX;

-       if (amdgpu_sriov_runtime(adev)) {
-               pr_err("shouldn't call rlcg write register during runtime\n=
");
-               return;
-       }
-
         if (offset =3D=3D grbm_cntl || offset =3D=3D grbm_idx) {
                 if (offset  =3D=3D grbm_cntl)
                         writel(v, scratch_reg2);
@@ -771,41 +777,89 @@ static void gfx_v9_0_rlcg_w(struct amdgpu_device *ade=
v, u32 offset, u32 v, u32 f

                 writel(v, ((void __iomem *)adev->rmmio) + (offset * 4));
         } else {
-               uint32_t i =3D 0;
-               uint32_t retries =3D 50000;
-
                 writel(v, scratch_reg0);
-               writel(offset | 0x80000000, scratch_reg1);
+               writel(offset | flag, scratch_reg1);
                 writel(1, spare_int);
-               for (i =3D 0; i < retries; i++) {
-                       u32 tmp;

+               for (i =3D 0; i < retries; i++) {
                         tmp =3D readl(scratch_reg1);
-                       if (!(tmp & 0x80000000))
+                       if (!(tmp & flag))
                                 break;

                         udelay(10);
                 }
-               if (i >=3D retries)
-                       pr_err("timeout: rlcg program reg:0x%05x failed !\n=
", offset);
+
+               if (i >=3D retries) {
+                       if (amdgpu_sriov_reg_indirect_gc(adev)) {
+                               if (tmp & GFX9_RLCG_VFGATE_DISABLED)
+                                       pr_err("The vfgate is disabled, pro=
gram reg:0x%05x failed!\n", offset);
+                               else if (tmp & GFX9_RLCG_WRONG_OPERATION_TY=
PE)
+                                       pr_err("Wrong operation type, progr=
am reg:0x%05x failed!\n", offset);
+                               else if (tmp & GFX9_RLCG_NOT_IN_RANGE)
+                                       pr_err("The register is not in rang=
e, program reg:0x%05x failed!\n", offset);
+                               else
+                                       pr_err("Unknown error type, program=
 reg:0x%05x failed!\n", offset);
+                       } else
+                               pr_err("timeout: rlcg program reg:0x%05x fa=
iled!\n", offset);
+               }
+       }
+
+       ret =3D readl(scratch_reg0);
+
+       return ret;
+}
+
+static bool gfx_v9_0_get_rlcg_flag(struct amdgpu_device *adev, u32 acc_fla=
gs, u32 hwip,
+                               int write, u32 *rlcg_flag)
+{
+
+       switch (hwip) {
+       case GC_HWIP:
+               if (amdgpu_sriov_reg_indirect_gc(adev)) {
+                       *rlcg_flag =3D write ? GFX9_RLCG_GC_WRITE : GFX9_RL=
CG_GC_READ;
+
+                       return true;
+               /* only in new version, AMDGPU_REGS_NO_KIQ and AMDGPU_REGS_=
RLC enabled simultaneously */
+               } else if ((acc_flags & AMDGPU_REGS_RLC) && !(acc_flags & A=
MDGPU_REGS_NO_KIQ) && write) {
+                       *rlcg_flag =3D GFX9_RLCG_GC_WRITE_OLD;
+                       return true;
+               }
+
+               break;
+       default:
+               return false;
         }

+       return false;
+}
+
+static u32 gfx_v9_0_sriov_rreg(struct amdgpu_device *adev, u32 offset, u32=
 acc_flags, u32 hwip)
+{
+       u32 rlcg_flag;
+
+       if (!amdgpu_sriov_runtime(adev) && gfx_v9_0_get_rlcg_flag(adev, acc=
_flags, hwip, 0, &rlcg_flag))
+               return gfx_v9_0_rlcg_rw(adev, offset, 0, rlcg_flag);
+
+       if (acc_flags & AMDGPU_REGS_NO_KIQ)
+               return RREG32_NO_KIQ(offset);
+       else
+               return RREG32(offset);
 }

 static void gfx_v9_0_sriov_wreg(struct amdgpu_device *adev, u32 offset,
-                              u32 v, u32 acc_flags, u32 hwip)
+                              u32 value, u32 acc_flags, u32 hwip)
 {
-       if ((acc_flags & AMDGPU_REGS_RLC) &&
-           amdgpu_sriov_fullaccess(adev)) {
-               gfx_v9_0_rlcg_w(adev, offset, v, acc_flags);
+       u32 rlcg_flag;

+       if (!amdgpu_sriov_runtime(adev) && gfx_v9_0_get_rlcg_flag(adev, acc=
_flags, hwip, 1, &rlcg_flag)) {
+               gfx_v9_0_rlcg_rw(adev, offset, value, rlcg_flag);
                 return;
         }

         if (acc_flags & AMDGPU_REGS_NO_KIQ)
-               WREG32_NO_KIQ(offset, v);
+               WREG32_NO_KIQ(offset, value);
         else
-               WREG32(offset, v);
+               WREG32(offset, value);
 }

 #define VEGA10_GB_ADDR_CONFIG_GOLDEN 0x2a114042
@@ -5134,7 +5188,7 @@ static void gfx_v9_0_update_spm_vmid(struct amdgpu_de=
vice *adev, unsigned vmid)
         if (amdgpu_sriov_is_pp_one_vf(adev))
                 data =3D RREG32_NO_KIQ(reg);
         else
-               data =3D RREG32(reg);
+               data =3D RREG32_SOC15(GC, 0, mmRLC_SPM_MC_CNTL);

         data &=3D ~RLC_SPM_MC_CNTL__RLC_SPM_VMID_MASK;
         data |=3D (vmid & RLC_SPM_MC_CNTL__RLC_SPM_VMID_MASK) << RLC_SPM_M=
C_CNTL__RLC_SPM_VMID__SHIFT;
@@ -5190,6 +5244,7 @@ static const struct amdgpu_rlc_funcs gfx_v9_0_rlc_fun=
cs =3D {
         .start =3D gfx_v9_0_rlc_start,
         .update_spm_vmid =3D gfx_v9_0_update_spm_vmid,
         .sriov_wreg =3D gfx_v9_0_sriov_wreg,
+       .sriov_rreg =3D gfx_v9_0_sriov_rreg,
         .is_rlcg_access_range =3D gfx_v9_0_is_rlcg_access_range,
 };

@@ -5795,16 +5850,16 @@ static void gfx_v9_0_set_compute_eop_interrupt_stat=
e(struct amdgpu_device *adev,

         switch (state) {
         case AMDGPU_IRQ_STATE_DISABLE:
-               mec_int_cntl =3D RREG32(mec_int_cntl_reg);
+               mec_int_cntl =3D RREG32_SOC15_IP(GC,mec_int_cntl_reg);
                 mec_int_cntl =3D REG_SET_FIELD(mec_int_cntl, CP_ME1_PIPE0_=
INT_CNTL,
                                              TIME_STAMP_INT_ENABLE, 0);
-               WREG32(mec_int_cntl_reg, mec_int_cntl);
+               WREG32_SOC15_IP(GC, mec_int_cntl_reg, mec_int_cntl);
                 break;
         case AMDGPU_IRQ_STATE_ENABLE:
-               mec_int_cntl =3D RREG32(mec_int_cntl_reg);
+               mec_int_cntl =3D RREG32_SOC15_IP(GC, mec_int_cntl_reg);
                 mec_int_cntl =3D REG_SET_FIELD(mec_int_cntl, CP_ME1_PIPE0_=
INT_CNTL,
                                              TIME_STAMP_INT_ENABLE, 1);
-               WREG32(mec_int_cntl_reg, mec_int_cntl);
+               WREG32_SOC15_IP(GC, mec_int_cntl_reg, mec_int_cntl);
                 break;
         default:
                 break;
--
2.25.1

--_000_BN9PR12MB5324E5F73B6CD4829091DE6E8B769BN9PR12MB5324namp_
Content-Type: text/html; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<html xmlns:v=3D"urn:schemas-microsoft-com:vml" xmlns:o=3D"urn:schemas-micr=
osoft-com:office:office" xmlns:w=3D"urn:schemas-microsoft-com:office:word" =
xmlns:m=3D"http://schemas.microsoft.com/office/2004/12/omml" xmlns=3D"http:=
//www.w3.org/TR/REC-html40">
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Dus-ascii"=
>
<meta name=3D"Generator" content=3D"Microsoft Word 15 (filtered medium)">
<!--[if !mso]><style>v\:* {behavior:url(#default#VML);}
o\:* {behavior:url(#default#VML);}
w\:* {behavior:url(#default#VML);}
.shape {behavior:url(#default#VML);}
</style><![endif]--><style><!--
/* Font Definitions */
@font-face
	{font-family:"Cambria Math";
	panose-1:2 4 5 3 5 4 6 3 2 4;}
@font-face
	{font-family:Calibri;
	panose-1:2 15 5 2 2 2 4 3 2 4;}
@font-face
	{font-family:"Segoe UI";
	panose-1:2 11 5 2 4 2 4 2 2 3;}
/* Style Definitions */
p.MsoNormal, li.MsoNormal, div.MsoNormal
	{margin:0in;
	font-size:11.0pt;
	font-family:"Calibri",sans-serif;}
a:link, span.MsoHyperlink
	{mso-style-priority:99;
	color:#0563C1;
	text-decoration:underline;}
span.EmailStyle18
	{mso-style-type:personal-reply;
	font-family:"Calibri",sans-serif;
	color:windowtext;}
p.msipheadera4477989, li.msipheadera4477989, div.msipheadera4477989
	{mso-style-name:msipheadera4477989;
	mso-margin-top-alt:auto;
	margin-right:0in;
	mso-margin-bottom-alt:auto;
	margin-left:0in;
	font-size:11.0pt;
	font-family:"Calibri",sans-serif;}
.MsoChpDefault
	{mso-style-type:export-only;
	font-size:10.0pt;}
@page WordSection1
	{size:8.5in 11.0in;
	margin:1.0in 1.0in 1.0in 1.0in;}
div.WordSection1
	{page:WordSection1;}
--></style><!--[if gte mso 9]><xml>
<o:shapedefaults v:ext=3D"edit" spidmax=3D"1026" />
</xml><![endif]--><!--[if gte mso 9]><xml>
<o:shapelayout v:ext=3D"edit">
<o:idmap v:ext=3D"edit" data=3D"1" />
</o:shapelayout></xml><![endif]-->
</head>
<body lang=3D"EN-US" link=3D"#0563C1" vlink=3D"#954F72" style=3D"word-wrap:=
break-word">
<div class=3D"WordSection1">
<p class=3D"msipheadera4477989" style=3D"margin:0in"><span style=3D"font-si=
ze:10.0pt;font-family:&quot;Arial&quot;,sans-serif;color:blue">[AMD Officia=
l Use Only]</span><o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">This was a bug in the original definition, but it fu=
nctionally it makes no difference (in both cases the macros resolve to the =
same value).<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<div>
<div style=3D"border:none;border-top:solid #E1E1E1 1.0pt;padding:3.0pt 0in =
0in 0in">
<p class=3D"MsoNormal"><b>From:</b> Nieto, David M &lt;David.Nieto@amd.com&=
gt; <br>
<b>Sent:</b> Wednesday, December 15, 2021 2:16 PM<br>
<b>To:</b> Skvortsov, Victor &lt;Victor.Skvortsov@amd.com&gt;; amd-gfx@list=
s.freedesktop.org; Deng, Emily &lt;Emily.Deng@amd.com&gt;; Liu, Monk &lt;Mo=
nk.Liu@amd.com&gt;; Ming, Davis &lt;Davis.Ming@amd.com&gt;; Liu, Shaoyun &l=
t;Shaoyun.Liu@amd.com&gt;; Zhou, Peng Ju &lt;PengJu.Zhou@amd.com&gt;;
 Chen, JingWen &lt;JingWen.Chen2@amd.com&gt;; Chen, Horace &lt;Horace.Chen@=
amd.com&gt;<br>
<b>Subject:</b> Re: [PATCH 5/5] drm/amdgpu: Modify indirect register access=
 for gfx9 sriov<o:p></o:p></p>
</div>
</div>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p style=3D"margin:5.0pt"><span style=3D"font-size:10.0pt;font-family:&quot=
;Arial&quot;,sans-serif;color:blue">[AMD Official Use Only]<o:p></o:p></spa=
n></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<div>
<div>
<p class=3D"MsoNormal" style=3D"background:white"><span style=3D"font-famil=
y:&quot;Segoe UI&quot;,sans-serif;color:black;background:white">&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; scratch_reg0 =3D adev-&gt;rmmio + (ad=
ev-&gt;reg_offset[GC_HWIP][0][mmSCRATCH_REG0_BASE_IDX] + mmSCRATCH_REG0)*4;=
</span><span style=3D"font-size:12.0pt;color:black"><br>
</span><span style=3D"font-family:&quot;Segoe UI&quot;,sans-serif;color:bla=
ck;background:white">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; scrat=
ch_reg1 =3D adev-&gt;rmmio + (adev-&gt;reg_offset[GC_HWIP][0][mmSCRATCH_REG=
1_BASE_IDX] + mmSCRATCH_REG1)*4;</span><span style=3D"font-family:&quot;Seg=
oe UI&quot;,sans-serif;color:black"><br>
<span style=3D"background:white">-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; scra=
tch_reg2 =3D adev-&gt;rmmio + (adev-&gt;reg_offset[GC_HWIP][0][mmSCRATCH_RE=
G1_BASE_IDX] + mmSCRATCH_REG2)*4;</span><br>
<span style=3D"background:white">-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; scra=
tch_reg3 =3D adev-&gt;rmmio + (adev-&gt;reg_offset[GC_HWIP][0][mmSCRATCH_RE=
G1_BASE_IDX] + mmSCRATCH_REG3)*4;</span><br>
<span style=3D"background:white">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; scra=
tch_reg2 =3D adev-&gt;rmmio + (adev-&gt;reg_offset[GC_HWIP][0][mmSCRATCH_RE=
G2_BASE_IDX] + mmSCRATCH_REG2)*4;</span><br>
<span style=3D"background:white">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; scra=
tch_reg3 =3D adev-&gt;rmmio + (adev-&gt;reg_offset[GC_HWIP][0][mmSCRATCH_RE=
G3_BASE_IDX] + mmSCRATCH_REG3)*4;</span><br>
<span style=3D"background:white">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp; spare_int =3D adev-&gt;rmmio + (adev-&gt;reg_offset[GC_HWIP][0][mmRL=
C_SPARE_INT_BASE_IDX] + mmRLC_SPARE_INT)*4;</span></span><span style=3D"fon=
t-size:12.0pt;color:black"><o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal" style=3D"background:white"><span style=3D"font-size:=
12.0pt;color:black"><o:p>&nbsp;</o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal" style=3D"background:white"><span style=3D"font-famil=
y:&quot;Segoe UI&quot;,sans-serif;color:black;background:white">the definit=
ion of scratch_reg2 and 3 has here.... will this be backwards compatible? W=
as it a bug in the definition?</span><span style=3D"font-size:12.0pt;color:=
black"><o:p></o:p></span></p>
</div>
<div class=3D"MsoNormal" align=3D"center" style=3D"text-align:center">
<hr size=3D"1" width=3D"98%" align=3D"center">
</div>
<div id=3D"divRplyFwdMsg">
<p class=3D"MsoNormal"><b><span style=3D"color:black">From:</span></b><span=
 style=3D"color:black"> Skvortsov, Victor &lt;<a href=3D"mailto:Victor.Skvo=
rtsov@amd.com">Victor.Skvortsov@amd.com</a>&gt;<br>
<b>Sent:</b> Wednesday, December 15, 2021 10:55 AM<br>
<b>To:</b> <a href=3D"mailto:amd-gfx@lists.freedesktop.org">amd-gfx@lists.f=
reedesktop.org</a> &lt;<a href=3D"mailto:amd-gfx@lists.freedesktop.org">amd=
-gfx@lists.freedesktop.org</a>&gt;; Deng, Emily &lt;<a href=3D"mailto:Emily=
.Deng@amd.com">Emily.Deng@amd.com</a>&gt;; Liu, Monk
 &lt;<a href=3D"mailto:Monk.Liu@amd.com">Monk.Liu@amd.com</a>&gt;; Ming, Da=
vis &lt;<a href=3D"mailto:Davis.Ming@amd.com">Davis.Ming@amd.com</a>&gt;; L=
iu, Shaoyun &lt;<a href=3D"mailto:Shaoyun.Liu@amd.com">Shaoyun.Liu@amd.com<=
/a>&gt;; Zhou, Peng Ju &lt;<a href=3D"mailto:PengJu.Zhou@amd.com">PengJu.Zh=
ou@amd.com</a>&gt;;
 Chen, JingWen &lt;<a href=3D"mailto:JingWen.Chen2@amd.com">JingWen.Chen2@a=
md.com</a>&gt;; Chen, Horace &lt;<a href=3D"mailto:Horace.Chen@amd.com">Hor=
ace.Chen@amd.com</a>&gt;; Nieto, David M &lt;<a href=3D"mailto:David.Nieto@=
amd.com">David.Nieto@amd.com</a>&gt;<br>
<b>Cc:</b> Skvortsov, Victor &lt;<a href=3D"mailto:Victor.Skvortsov@amd.com=
">Victor.Skvortsov@amd.com</a>&gt;<br>
<b>Subject:</b> [PATCH 5/5] drm/amdgpu: Modify indirect register access for=
 gfx9 sriov</span>
<o:p></o:p></p>
<div>
<p class=3D"MsoNormal">&nbsp;<o:p></o:p></p>
</div>
</div>
<div>
<div>
<p class=3D"MsoNormal" style=3D"margin-bottom:12.0pt">Expand RLCG interface=
 for new GC read &amp; write commands.<br>
New interface will only be used if the PF enables the flag in pf2vf msg.<br=
>
<br>
Signed-off-by: Victor Skvortsov &lt;<a href=3D"mailto:victor.skvortsov@amd.=
com">victor.skvortsov@amd.com</a>&gt;<br>
---<br>
&nbsp;drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c | 111 +++++++++++++++++++------=
-<br>
&nbsp;1 file changed, 83 insertions(+), 28 deletions(-)<br>
<br>
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c b/drivers/gpu/drm/amd/am=
dgpu/gfx_v9_0.c<br>
index d252b06efa43..bce6ab52cae0 100644<br>
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c<br>
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c<br>
@@ -63,6 +63,13 @@<br>
&nbsp;#define mmGCEA_PROBE_MAP&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp; 0x070c<br>
&nbsp;#define mmGCEA_PROBE_MAP_BASE_IDX&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0<br>
&nbsp;<br>
+#define GFX9_RLCG_GC_WRITE_OLD&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; (0x8 &lt;&lt; 28)<br>
+#define GFX9_RLCG_GC_WRITE&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; (0=
x0 &lt;&lt; 28)<br>
+#define GFX9_RLCG_GC_READ&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p; (0x1 &lt;&lt; 28)<br>
+#define GFX9_RLCG_VFGATE_DISABLED&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0x4000000<br>
+#define GFX9_RLCG_WRONG_OPERATION_TYPE&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp; 0x2000000<br>
+#define GFX9_RLCG_NOT_IN_RANGE&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0x1000000<br>
+<br>
&nbsp;MODULE_FIRMWARE(&quot;amdgpu/vega10_ce.bin&quot;);<br>
&nbsp;MODULE_FIRMWARE(&quot;amdgpu/vega10_pfp.bin&quot;);<br>
&nbsp;MODULE_FIRMWARE(&quot;amdgpu/vega10_me.bin&quot;);<br>
@@ -739,7 +746,7 @@ static const u32 GFX_RLC_SRM_INDEX_CNTL_DATA_OFFSETS[] =
=3D<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mmRLC_SRM_INDEX_CNTL_DATA_=
7 - mmRLC_SRM_INDEX_CNTL_DATA_0,<br>
&nbsp;};<br>
&nbsp;<br>
-static void gfx_v9_0_rlcg_w(struct amdgpu_device *adev, u32 offset, u32 v,=
 u32 flag)<br>
+static u32 gfx_v9_0_rlcg_rw(struct amdgpu_device *adev, u32 offset, u32 v,=
 uint32_t flag)<br>
&nbsp;{<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; static void *scratch_reg0;=
<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; static void *scratch_reg1;=
<br>
@@ -748,21 +755,20 @@ static void gfx_v9_0_rlcg_w(struct amdgpu_device *ade=
v, u32 offset, u32 v, u32 f<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; static void *spare_int;<br=
>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; static uint32_t grbm_cntl;=
<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; static uint32_t grbm_idx;<=
br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t i =3D 0;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t retries =3D 50000;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; u32 ret =3D 0;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; u32 tmp;<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; scratch_reg0 =3D adev-&gt;=
rmmio + (adev-&gt;reg_offset[GC_HWIP][0][mmSCRATCH_REG0_BASE_IDX] + mmSCRAT=
CH_REG0)*4;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; scratch_reg1 =3D adev-&gt;=
rmmio + (adev-&gt;reg_offset[GC_HWIP][0][mmSCRATCH_REG1_BASE_IDX] + mmSCRAT=
CH_REG1)*4;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; scratch_reg2 =3D adev-&gt;rmmio + (ad=
ev-&gt;reg_offset[GC_HWIP][0][mmSCRATCH_REG1_BASE_IDX] + mmSCRATCH_REG2)*4;=
<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; scratch_reg3 =3D adev-&gt;rmmio + (ad=
ev-&gt;reg_offset[GC_HWIP][0][mmSCRATCH_REG1_BASE_IDX] + mmSCRATCH_REG3)*4;=
<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; scratch_reg2 =3D adev-&gt;rmmio + (ad=
ev-&gt;reg_offset[GC_HWIP][0][mmSCRATCH_REG2_BASE_IDX] + mmSCRATCH_REG2)*4;=
<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; scratch_reg3 =3D adev-&gt;rmmio + (ad=
ev-&gt;reg_offset[GC_HWIP][0][mmSCRATCH_REG3_BASE_IDX] + mmSCRATCH_REG3)*4;=
<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; spare_int =3D adev-&gt;rmm=
io + (adev-&gt;reg_offset[GC_HWIP][0][mmRLC_SPARE_INT_BASE_IDX] + mmRLC_SPA=
RE_INT)*4;<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; grbm_cntl =3D adev-&gt;reg=
_offset[GC_HWIP][0][mmGRBM_GFX_CNTL_BASE_IDX] + mmGRBM_GFX_CNTL;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; grbm_idx =3D adev-&gt;reg_=
offset[GC_HWIP][0][mmGRBM_GFX_INDEX_BASE_IDX] + mmGRBM_GFX_INDEX;<br>
&nbsp;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (amdgpu_sriov_runtime(adev)) {<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; pr_err(&quot;shouldn't call rlcg write register during runtime\n=
&quot;);<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; return;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
-<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (offset =3D=3D grbm_cnt=
l || offset =3D=3D grbm_idx) {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; if (offset&nbsp; =3D=3D grbm_cntl)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; write=
l(v, scratch_reg2);<br>
@@ -771,41 +777,89 @@ static void gfx_v9_0_rlcg_w(struct amdgpu_device *ade=
v, u32 offset, u32 v, u32 f<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; writel(v, ((void __iomem *)adev-&gt;rmmio) + (offset =
* 4));<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; } else {<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; uint32_t i =3D 0;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; uint32_t retries =3D 50000;<br>
-<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; writel(v, scratch_reg0);<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; writel(offset | 0x80000000, scratch_reg1);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; writel(offset | flag, scratch_reg1);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; writel(1, spare_int);<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; for (i =3D 0; i &lt; retries; i++) {<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; u32 tmp;<br>
&nbsp;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; for (i =3D 0; i &lt; retries; i++) {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; tmp =
=3D readl(scratch_reg1);<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!(tmp &amp; =
0x80000000))<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!(tmp &amp; =
flag))<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; break;<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; udela=
y(10);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; }<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; if (i &gt;=3D retries)<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; pr_err(&quot;tim=
eout: rlcg program reg:0x%05x failed !\n&quot;, offset);<br>
+<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; if (i &gt;=3D retries) {<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (amdgpu_sriov=
_reg_indirect_gc(adev)) {<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (tmp &amp; GFX9_RLCG_VFGATE_DISABLED)<br=
>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp; pr_err(&quot;The vfgate is disabled, program reg:0x%05x failed!\n&quot=
;, offset);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; else if (tmp &amp; GFX9_RLCG_WRONG_OPERATIO=
N_TYPE)<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp; pr_err(&quot;Wrong operation type, program reg:0x%05x failed!\n&quot;,=
 offset);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; else if (tmp &amp; GFX9_RLCG_NOT_IN_RANGE)<=
br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp; pr_err(&quot;The register is not in range, program reg:0x%05x failed!\=
n&quot;, offset);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; else<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp; pr_err(&quot;Unknown error type, program reg:0x%05x failed!\n&quot;, o=
ffset);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; } else<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; pr_err(&quot;timeout: rlcg program reg:0x%0=
5x failed!\n&quot;, offset);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; }<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
+<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ret =3D readl(scratch_reg0);<br>
+<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return ret;<br>
+}<br>
+<br>
+static bool gfx_v9_0_get_rlcg_flag(struct amdgpu_device *adev, u32 acc_fla=
gs, u32 hwip,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int write, u32 *rlcg_flag)<br>
+{<br>
+<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; switch (hwip) {<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case GC_HWIP:<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; if (amdgpu_sriov_reg_indirect_gc(adev)) {<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; *rlcg_flag =3D w=
rite ? GFX9_RLCG_GC_WRITE : GFX9_RLCG_GC_READ;<br>
+<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return true;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; /* only in new version, AMDGPU_REGS_NO_KIQ and AMDGPU_REGS_RLC e=
nabled simultaneously */<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; } else if ((acc_flags &amp; AMDGPU_REGS_RLC) &amp;&amp; !(acc_fl=
ags &amp; AMDGPU_REGS_NO_KIQ) &amp;&amp; write) {<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; *rlcg_flag =3D G=
FX9_RLCG_GC_WRITE_OLD;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return true;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; }<br>
+<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; break;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; default:<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; return false;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&nbsp;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return false;<br>
+}<br>
+<br>
+static u32 gfx_v9_0_sriov_rreg(struct amdgpu_device *adev, u32 offset, u32=
 acc_flags, u32 hwip)<br>
+{<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; u32 rlcg_flag;<br>
+<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!amdgpu_sriov_runtime(adev) &amp;=
&amp; gfx_v9_0_get_rlcg_flag(adev, acc_flags, hwip, 0, &amp;rlcg_flag))<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; return gfx_v9_0_rlcg_rw(adev, offset, 0, rlcg_flag);<br>
+<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (acc_flags &amp; AMDGPU_REGS_NO_KI=
Q)<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; return RREG32_NO_KIQ(offset);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; else<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; return RREG32(offset);<br>
&nbsp;}<br>
&nbsp;<br>
&nbsp;static void gfx_v9_0_sriov_wreg(struct amdgpu_device *adev, u32 offse=
t,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp; u32 v, u32 acc_flags, u32 hwip)<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp; u32 value, u32 acc_flags, u32 hwip)<br>
&nbsp;{<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if ((acc_flags &amp; AMDGPU_REGS_RLC)=
 &amp;&amp;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_sriov_=
fullaccess(adev)) {<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; gfx_v9_0_rlcg_w(adev, offset, v, acc_flags);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; u32 rlcg_flag;<br>
&nbsp;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!amdgpu_sriov_runtime(adev) &amp;=
&amp; gfx_v9_0_get_rlcg_flag(adev, acc_flags, hwip, 1, &amp;rlcg_flag)) {<b=
r>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; gfx_v9_0_rlcg_rw(adev, offset, value, rlcg_flag);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; return;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (acc_flags &amp; AMDGPU=
_REGS_NO_KIQ)<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; WREG32_NO_KIQ(offset, v);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; WREG32_NO_KIQ(offset, value);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; else<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; WREG32(offset, v);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; WREG32(offset, value);<br>
&nbsp;}<br>
&nbsp;<br>
&nbsp;#define VEGA10_GB_ADDR_CONFIG_GOLDEN 0x2a114042<br>
@@ -5134,7 +5188,7 @@ static void gfx_v9_0_update_spm_vmid(struct amdgpu_de=
vice *adev, unsigned vmid)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (amdgpu_sriov_is_pp_one=
_vf(adev))<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; data =3D RREG32_NO_KIQ(reg);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; else<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; data =3D RREG32(reg);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; data =3D RREG32_SOC15(GC, 0, mmRLC_SPM_MC_CNTL);<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; data &amp;=3D ~RLC_SPM_MC_=
CNTL__RLC_SPM_VMID_MASK;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; data |=3D (vmid &amp; RLC_=
SPM_MC_CNTL__RLC_SPM_VMID_MASK) &lt;&lt; RLC_SPM_MC_CNTL__RLC_SPM_VMID__SHI=
FT;<br>
@@ -5190,6 +5244,7 @@ static const struct amdgpu_rlc_funcs gfx_v9_0_rlc_fun=
cs =3D {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .start =3D gfx_v9_0_rlc_st=
art,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .update_spm_vmid =3D gfx_v=
9_0_update_spm_vmid,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .sriov_wreg =3D gfx_v9_0_s=
riov_wreg,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .sriov_rreg =3D gfx_v9_0_sriov_rreg,<=
br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .is_rlcg_access_range =3D =
gfx_v9_0_is_rlcg_access_range,<br>
&nbsp;};<br>
&nbsp;<br>
@@ -5795,16 +5850,16 @@ static void gfx_v9_0_set_compute_eop_interrupt_stat=
e(struct amdgpu_device *adev,<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; switch (state) {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case AMDGPU_IRQ_STATE_DISA=
BLE:<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; mec_int_cntl =3D RREG32(mec_int_cntl_reg);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; mec_int_cntl =3D RREG32_SOC15_IP(GC,mec_int_cntl_reg);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; mec_int_cntl =3D REG_SET_FIELD(mec_int_cntl, CP_ME1_P=
IPE0_INT_CNTL,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; TIME_STAMP_INT_ENABLE, 0);<br=
>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; WREG32(mec_int_cntl_reg, mec_int_cntl);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; WREG32_SOC15_IP(GC, mec_int_cntl_reg, mec_int_cntl);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; break;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case AMDGPU_IRQ_STATE_ENAB=
LE:<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; mec_int_cntl =3D RREG32(mec_int_cntl_reg);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; mec_int_cntl =3D RREG32_SOC15_IP(GC, mec_int_cntl_reg);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; mec_int_cntl =3D REG_SET_FIELD(mec_int_cntl, CP_ME1_P=
IPE0_INT_CNTL,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; TIME_STAMP_INT_ENABLE, 1);<br=
>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; WREG32(mec_int_cntl_reg, mec_int_cntl);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; WREG32_SOC15_IP(GC, mec_int_cntl_reg, mec_int_cntl);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; break;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; default:<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; break;<br>
-- <br>
2.25.1<o:p></o:p></p>
</div>
</div>
</div>
</div>
</body>
</html>

--_000_BN9PR12MB5324E5F73B6CD4829091DE6E8B769BN9PR12MB5324namp_--
