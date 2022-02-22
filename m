Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E89B3C433EF
	for <amd-gfx@archiver.kernel.org>; Tue, 22 Feb 2022 14:49:23 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5F49710E594;
	Tue, 22 Feb 2022 14:49:23 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2072.outbound.protection.outlook.com [40.107.92.72])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3BBBB10E594
 for <amd-gfx@lists.freedesktop.org>; Tue, 22 Feb 2022 14:49:22 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AFi1DulbXmWePOdHLHeGuEFw9SkBS6CIrBJYvcEApy5AN/K6CQ1RAN5Z9TDKfoS7MNxgSYqRdCzKli1Q7HqBq7ky/idLk1NVh6MmmFuLAShhqSyYs2wCtLR2/UF9GU6rR+oLxza8560Xnlzjn2yz4sqqu9ZIMD4GBYNztBzag9X6IwotlNMHF/qYqzhxI9SAiV/ZfImggT61wKwjtWIcmzYeyLhgeXH4Q5pwg3/D/41QRhmAnew68MJiar2OHedsOpN5q+0xj6I8zzQ89rVUiR1tzlfeF093exZ4dVaQwmAawnLDanfXXGHt128vnFIOsiOh7GYd8TsfUOmiHMbIJA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5a3JOgoJn67jfojBC7TTX3h5yg60gPMsMH/ds//M1HI=;
 b=CRdvGzD3C2NFuYaSFw/E+renJQLpntkGzF0YGfYn8jFVMGNQYJqC08EUXr9KA64pwp5CdwxgMe66i72UA/ccgEFzMnkCNf3hUbGNSfLEBmlxYKeCqaSFmIbwo0T9ZlbwZfUvOCncdrJg3e5oicmJxZxd5r2kg6AcHJhfSxGsxHr+0Ze8w1d0mWGU0sKguOM/N0YFvxs+cOP8kN75VWxzUgeaftgCH4TgbF8U0TbYc1Snfb+MjYQsKMeQr6J9uc+9BSIxlBXMjUrPyN8TwDz/IpdUpvpgSzIWHU52z7+PgqlYFAPqKicv4THITKEF8mTCAsfPuFPC3+35PeOR7WjUAA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5a3JOgoJn67jfojBC7TTX3h5yg60gPMsMH/ds//M1HI=;
 b=pYHllDQMJdZpcvz0Lv6IR9qDFvnjAMn8lgcDuMEzuEwk1I2Eb/aw3bIeaQzmII91fIU105Dxlqfwn/18fa7XfNO57kXOoe6F3uhyG8LYt6K+/gVCZ+hF2etGIAHkuB7SFRAqNBLS6PLjOjqNg+cxj89AZ3LkaNO2Y8octokhE+M=
Received: from BN6PR12MB1187.namprd12.prod.outlook.com (2603:10b6:404:1b::19)
 by BYAPR12MB3093.namprd12.prod.outlook.com (2603:10b6:a03:dc::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4995.24; Tue, 22 Feb
 2022 14:49:19 +0000
Received: from BN6PR12MB1187.namprd12.prod.outlook.com
 ([fe80::28:9df5:e8a4:a6a0]) by BN6PR12MB1187.namprd12.prod.outlook.com
 ([fe80::28:9df5:e8a4:a6a0%6]) with mapi id 15.20.5017.022; Tue, 22 Feb 2022
 14:49:19 +0000
From: "Zhang, Yifan" <Yifan1.Zhang@amd.com>
To: Alex Deucher <alexdeucher@gmail.com>, "Wentland, Harry"
 <Harry.Wentland@amd.com>
Subject: RE: [PATCH v2] drm/amd/display: add GTT domain support for dcn 3.1.5
 and 3.1.6
Thread-Topic: [PATCH v2] drm/amd/display: add GTT domain support for dcn 3.1.5
 and 3.1.6
Thread-Index: AQHYJ7H1Xzqmeh0B6kSL8qzcCUcl86yfl5WAgAAGvwCAAAiiMA==
Date: Tue, 22 Feb 2022 14:49:19 +0000
Message-ID: <BN6PR12MB11872E260D57453B325DBED9C13B9@BN6PR12MB1187.namprd12.prod.outlook.com>
References: <20220222060313.856546-1-yifan1.zhang@amd.com>
 <ecbaee85-b44a-85df-accc-fad4d3029b10@amd.com>
 <CADnq5_PFKKW-=ghAPHoVDE5aPZ4kYM+_ZXKgDVZ=MTHV1ZjJNg@mail.gmail.com>
In-Reply-To: <CADnq5_PFKKW-=ghAPHoVDE5aPZ4kYM+_ZXKgDVZ=MTHV1ZjJNg@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Enabled=true;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SetDate=2022-02-22T14:49:15Z; 
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Method=Standard;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Name=AMD Official Use
 Only-AIP 2.0;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ActionId=6d77a7ba-f403-4e14-a2af-23eb394405a8;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ContentBits=1
msip_label_88914ebd-7e6c-4e12-a031-a9906be2db14_enabled: true
msip_label_88914ebd-7e6c-4e12-a031-a9906be2db14_setdate: 2022-02-22T14:49:15Z
msip_label_88914ebd-7e6c-4e12-a031-a9906be2db14_method: Standard
msip_label_88914ebd-7e6c-4e12-a031-a9906be2db14_name: AMD Official Use
 Only-AIP 2.0
msip_label_88914ebd-7e6c-4e12-a031-a9906be2db14_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_88914ebd-7e6c-4e12-a031-a9906be2db14_actionid: 296ce2e5-633e-41e2-a85d-a67fedcedbb9
msip_label_88914ebd-7e6c-4e12-a031-a9906be2db14_contentbits: 0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 1a5f161c-b1ef-47e9-ce0a-08d9f61281b6
x-ms-traffictypediagnostic: BYAPR12MB3093:EE_
x-microsoft-antispam-prvs: <BYAPR12MB3093D6DAC9B39DA29740706DC13B9@BYAPR12MB3093.namprd12.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 1lxJClLusrM1u/yCxa15kIKMgLMu3g1I8j72ZlR0OTvIAvUotvYeI9DW05UC3M59BTztio3GWCnlbxrjuGBkmbJDIrDBc9m+PIvSaw3wKWWhb4bPLKDO9wX2iRqWx/KAjweAJOAYfRQxtUTIl/oNm2s35BekYaJFog9Lt0ITBFYM3BeX859u9TZPB3VwB9H42T6+EUlXQxrXPhTEptTXNiUV7reK6tPHeubFG4Pl9ikTZZOep79SyVe2B5vCPY/VCv2/UiPmhRgN973BwO3FiMygaPwFzWTqskpsMjWxdDmCJ3GflzH09uogcD5jUKcKHDNcjAqbNBaDneN8s/hdYwVMv/IpS6PKyf+kqPGQSMbqiT924jl7xE/IHUEUV+bUrJcvpHfJvmP5VigFO4A77PJxgVj0DsEOlOYFqOST7p6t6wr9N5tVURLc1RXedIn5BbyFrS+Hm79HjkGASWZC3YDHUtJBD97p90pxNshn6R/fj3QJ1+Jzd8/qr/wIof7iBuGkXcpRKU0cImQhJYEUGPS1UIgb2Nua7KQ4EwE50POzjbJBr9DA61eu67UZ2atPogJ4xhre15L6D4SIcV5iPc58Pjzs6Zot98CV69BZwqYDvozMBI/m17SkX7phpagMHQcgQi5b28PcbdQaLw6M6KHlFKy2520HFnQ//swxC1OHrqLrkgdzCn8xTeVu+uR+ncvyX69jB1Cms7id/WYwnQ==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN6PR12MB1187.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(4636009)(366004)(6636002)(33656002)(76116006)(83380400001)(110136005)(54906003)(38070700005)(316002)(55016003)(52536014)(66556008)(5660300002)(2906002)(66446008)(8676002)(66476007)(6506007)(9686003)(7696005)(966005)(508600001)(38100700002)(8936002)(71200400001)(53546011)(64756008)(66946007)(86362001)(4326008)(122000001)(45080400002)(186003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?lLjJnx2o4ez8vKfPxmNQX8Zy2jmruar1omIsW3RbmxcB398CMhPXjBXqd5s4?=
 =?us-ascii?Q?Z0Q2RbFceiO+ri5Atp+ZWJBX0sMTP3iVSDviVrO44ZuR31NWSVf3/VieU96w?=
 =?us-ascii?Q?day19Y30Qdt1VPobfcfa5MrII6qzanTqG+KLHIehKnGRRKuhtyi1M5dnb5KL?=
 =?us-ascii?Q?3JRgyu4llTb0GmMM98kgtnvF5fOTpyY32DhOuqKHAAAd9DE5UuZfk3Kvjdz5?=
 =?us-ascii?Q?EqRVqs287Qpy8K4jEhculqHDv1NwChLjR3bzKesqPt30NzrC1avdnbHJVQku?=
 =?us-ascii?Q?8iOAdQPUYk4LesQPqt+cea3XDixKnO2nr3vjJtN7+gSkt2ewHwX2x32amJ80?=
 =?us-ascii?Q?W+cZJ/m9nHyzq6op9gg5fH4prGbCaWL3xMNwIX4X9w092jSuX9Ddff/RCxe4?=
 =?us-ascii?Q?CGF9EvWjIMwNYfr/SqbXRn2uAGEd/tvjhYR/jkBoj0X7pCjL0qAI6kdAUbdN?=
 =?us-ascii?Q?ADsgRkt40aq2ZdQ+v+JplW8BKMsdzoY78eloMmfx2LD1/K064X01R7BB+HaG?=
 =?us-ascii?Q?JeLg1qRT/HCSakMGZga1Dcb6FeskPyUHNext8DGXyJUD5ifTaa4wRYCRPPto?=
 =?us-ascii?Q?IVhDrN3rFTGLw4r+Z6B79Q89j+Gb0gY0UkNb0fpMWdNNQH7jiuEmXrJ8TRJV?=
 =?us-ascii?Q?arXKVHzoR/IcdlamZx6k39se7k++p74Mbw8ve0ltncZXBxq1SyeUZxBV/1YD?=
 =?us-ascii?Q?Qh4fbf5MZek3rR146ClcA3rqbOA2O6l3jrDyZi0npO3up3zqBmXWoKbNvJFv?=
 =?us-ascii?Q?jwnhsE943WjO9iJw/zI+FCdJHkAXY7QWRNvDJ+bv7EXW48ApMpNZm37O3zoo?=
 =?us-ascii?Q?6bbdw+2CNcC3IeSGB0PDFR9P5/6e/XiC+q2VCKO5sDCvJUhnEV0Oy+CTBqe2?=
 =?us-ascii?Q?qpeSpNbrt0Dpotg72lb7AGENKnTnxMcglTHUyRDFNUf/cwOumnQsToMJyYst?=
 =?us-ascii?Q?dh5kGexoeUlQiXAusEjkqQexp6Aa49ZETamjb9GqPirkX0mvqoutlMLpzeWY?=
 =?us-ascii?Q?zY2N2CaOXUHIUplJY4blBtPZ4w6C6AIIZe9C/NnV9q+AVDm9Rig8+/VT5FtH?=
 =?us-ascii?Q?Qlb5/tr54LWZj3CrEeJsG2LnN8p3BAVYcBHfNQ8j6ZinL9xEeeyqUcyYYgL5?=
 =?us-ascii?Q?mze7OLc0LLtKmgG+ZEpsuOxLycBK0ZPGiStGVbAofJT+8bEl3eqXQq+YpG+D?=
 =?us-ascii?Q?SfSRgXs7twP0RUeBxISeXrKj7OVPCxj6/7Brs5X11iFCKU8gByXdHFtUoq67?=
 =?us-ascii?Q?p5pSaafRq8U+K67fHba9U1AkmvDAil2mtcbum/rX8eSw9bW6h6LB6+zWqBZO?=
 =?us-ascii?Q?Rb/UjBMzcIB5nFq5l6OcBLjXGTGNhIUVetJmUpzROPC8mwSZ98MPX5anTxQJ?=
 =?us-ascii?Q?U2shToz5W1uRMubVQlZCEpcRPU3fD3ZH6JfhL4BK26b7z2Tf1Orpe7VyXiY0?=
 =?us-ascii?Q?wJCeGOrwkDRtqZ0XT+931nP5JQ+2kmd5m2TO2xChOZZekujqs0siXCQcrAJX?=
 =?us-ascii?Q?oZD4CfTmZhzWmALO0+aGNFkLYgMbY5Pfym8qO3YvdWwVPqLhl/gGmcTmF+hi?=
 =?us-ascii?Q?+Lnm148dMrxTBqs0Fv+aPw9hKf7zhTz2EgmwU7N/ml1RDYy441hySfBTviPz?=
 =?us-ascii?Q?lV0VfRYTVfkVsL1c4pNTspI=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN6PR12MB1187.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1a5f161c-b1ef-47e9-ce0a-08d9f61281b6
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Feb 2022 14:49:19.3377 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 90MbkxsUkznB5nlDyDG+TO1UOUQ3222ALP25+DvcVxIRCdIVq8KSmgtLFCd3q0Fw
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB3093
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
Cc: "Li, Sun peng \(Leo\)" <Sunpeng.Li@amd.com>, "Yin,
 Tianci \(Rico\)" <Tianci.Yin@amd.com>,
 amd-gfx list <amd-gfx@lists.freedesktop.org>, "Liang,
 Prike" <Prike.Liang@amd.com>, "Deucher, Alexander" <Alexander.Deucher@amd.com>,
 "Koenig, Christian" <Christian.Koenig@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Official Use Only]

Hi Alex,

I'm OK w/ this series. Acked.

BRs,
Yifan

-----Original Message-----
From: Alex Deucher <alexdeucher@gmail.com>=20
Sent: Tuesday, February 22, 2022 10:17 PM
To: Wentland, Harry <Harry.Wentland@amd.com>
Cc: Zhang, Yifan <Yifan1.Zhang@amd.com>; amd-gfx list <amd-gfx@lists.freede=
sktop.org>; Li, Sun peng (Leo) <Sunpeng.Li@amd.com>; Deucher, Alexander <Al=
exander.Deucher@amd.com>; Liang, Prike <Prike.Liang@amd.com>; Yin, Tianci (=
Rico) <Tianci.Yin@amd.com>; Koenig, Christian <Christian.Koenig@amd.com>
Subject: Re: [PATCH v2] drm/amd/display: add GTT domain support for dcn 3.1=
.5 and 3.1.6

How about this series instead?
https://nam11.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Fpatchwo=
rk.freedesktop.org%2Fseries%2F100519%2F&amp;data=3D04%7C01%7Cyifan1.zhang%4=
0amd.com%7C23aba82394f446c4c41b08d9f60e0687%7C3dd8961fe4884e608e11a82d994e1=
83d%7C0%7C0%7C637811362370697462%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMD=
AiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C3000&amp;sdata=3DoMn8bBc=
pNupXv3Kf%2FkMMbHLBtuQ45b46rEq4cAZYs2g%3D&amp;reserved=3D0

Alex

On Tue, Feb 22, 2022 at 8:53 AM Harry Wentland <harry.wentland@amd.com> wro=
te:
>
> On 2022-02-22 01:03, Yifan Zhang wrote:
> > From: "Tianci.Yin" <tianci.yin@amd.com>
> >
> > this patch adds GTT domain support for dcn 3.1.5 and 3.1.6
> >
> > Signed-off-by: Tianci.Yin <tianci.yin@amd.com>
> > Signed-off-by: Yifan Zhang <yifan1.zhang@amd.com>
>
> Acked-by: Harry Wentland <harry.wentland@amd.com>
>
> Harry
>
> > ---
> >  drivers/gpu/drm/amd/amdgpu/amdgpu_display.c | 2 ++
> >  1 file changed, 2 insertions(+)
> >
> > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_display.c b/drivers/gpu/=
drm/amd/amdgpu/amdgpu_display.c
> > index 9709368b4915..37f4da219a5f 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_display.c
> > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_display.c
> > @@ -523,6 +523,8 @@ uint32_t amdgpu_display_supported_domains(struct am=
dgpu_device *adev,
> >                       case IP_VERSION(3, 0, 1):
> >                       case IP_VERSION(3, 1, 2):
> >                       case IP_VERSION(3, 1, 3):
> > +                     case IP_VERSION(3, 1, 5):
> > +                     case IP_VERSION(3, 1, 6):
> >                               domain |=3D AMDGPU_GEM_DOMAIN_GTT;
> >                               break;
> >                       default:
>
