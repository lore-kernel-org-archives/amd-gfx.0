Return-Path: <SRS0=kbWR=KQ=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7363C04FF3
	for <amd-gfx@archiver.kernel.org>; Fri, 21 May 2021 21:32:39 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 97510613EC
	for <amd-gfx@archiver.kernel.org>; Fri, 21 May 2021 21:32:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 97510613EC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1C2AA6E87F;
	Fri, 21 May 2021 21:32:39 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2061.outbound.protection.outlook.com [40.107.237.61])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 55B296E87F
 for <amd-gfx@lists.freedesktop.org>; Fri, 21 May 2021 21:32:37 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=P0tyJ7p3/KiRsLADiN6IQzPhf1ticsUV2ZIslNHyQjMuLzCVJNnP1YJyBk9+DbJaKGn6C97Za9QbN5KckW44OWDWc/wsmFJrMgBBZuaBG6LX9GlHlP7OmgLH7Jn+m4RTzSkGJhAPHR86zHQP5uYNbAIOnXUTHu4YclSwElmcTHNox/tixL9sT/UUy7kR1IeJdZVKCyiqoQxcfpgGAnkC+X0MqgMaa3/+i8fk2zGXczPDsrkFBokAMrnihKCaBK30eAkPJuozlxrFDkEn0Wt4qLtAlEjQzEjOMBWjQDdrkvswjPJRZW+uYh81E8hPlf+A78cFDwplQTSm3N8asyukNw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=a8ZzcWZJoOYJG91+A+auUEIxUI5uMgedBWQaPklkPoM=;
 b=gsL0mCuC9tXbDlXSlrKKwqLir47UJ6Teo08UF7VHZH/0eOsPoosAjQahVJJKvK1Gce9mv2aFe9w6TN29YVyrCa+DD4brExOl2Kp1jS+OXFoCJkV0hEMrRkCJPmVAXAwayzJ7t6uP5yNGJtzY5SQ17o41Xp4El0OtQpt+qgMzN2Id2UdLOx9OpcWZZAHCUZWYkmt6rMCxiEZKLHCkyuGy+J6VYf6Qywz+M1yYtJ17cEpmHNTdZTpV5ji14/LMowAOMWAeqBQa91xZvoEsk4g8FuIfNjReD/g2b6MB0P49uQ1kUYdS5lwIJDxcJSNMYIybEBN4gICi2RDqbUo0WGdk3g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=a8ZzcWZJoOYJG91+A+auUEIxUI5uMgedBWQaPklkPoM=;
 b=FjV0qywQKQUdb2pP/yhckN/V5Wto8ItuSjEvHSkQdxvHJMOXo9ZeHbvaUBpe+rYLRzdWrfEFnTlqANuF/ZXFr+DhUi4RPc3tVqvl254dmIQN+Ux0ZhtQhjoyoq9F7B7S5+NA30ffTRCoTPDHj+AN7Bd2c6flkIQzVboZywKYgIo=
Received: from DM6PR12MB3067.namprd12.prod.outlook.com (2603:10b6:5:115::10)
 by DM5PR12MB2373.namprd12.prod.outlook.com (2603:10b6:4:b1::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4129.25; Fri, 21 May
 2021 21:32:35 +0000
Received: from DM6PR12MB3067.namprd12.prod.outlook.com
 ([fe80::5c8c:adff:ab42:9345]) by DM6PR12MB3067.namprd12.prod.outlook.com
 ([fe80::5c8c:adff:ab42:9345%6]) with mapi id 15.20.4129.035; Fri, 21 May 2021
 21:32:34 +0000
From: "Sider, Graham" <Graham.Sider@amd.com>
To: Alex Deucher <alexdeucher@gmail.com>
Subject: RE: [PATCH 2/6] drm/amd/pm: Add arcturus throttler translation
Thread-Topic: [PATCH 2/6] drm/amd/pm: Add arcturus throttler translation
Thread-Index: AQHXTYSqhVvD5xR5YU6jGKA1xw/dbKrt/8GAgAAz2ACAAC09gIAAED3A
Date: Fri, 21 May 2021 21:32:34 +0000
Message-ID: <DM6PR12MB3067E3CC583A472F14DE7A1A8A299@DM6PR12MB3067.namprd12.prod.outlook.com>
References: <20210520142930.8369-1-Graham.Sider@amd.com>
 <20210520142930.8369-2-Graham.Sider@amd.com>
 <CADnq5_MnENbvZJTAr8nfmvENZoeZaWxpU=zaeGeUasgz5TfUFA@mail.gmail.com>
 <DM6PR12MB3067FD5B64C665F5E264F6EA8A299@DM6PR12MB3067.namprd12.prod.outlook.com>
 <CADnq5_O=LP9y_YNmvPC8om7KOf2eKyBr2P+CL1j4zAhBrRak1A@mail.gmail.com>
In-Reply-To: <CADnq5_O=LP9y_YNmvPC8om7KOf2eKyBr2P+CL1j4zAhBrRak1A@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [72.141.145.172]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 09b85584-fd35-4743-6b19-08d91c9ff2d2
x-ms-traffictypediagnostic: DM5PR12MB2373:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM5PR12MB2373417F83907DCEBF90A7718A299@DM5PR12MB2373.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: dcO1gIGwMbBZ0Rnd0UvqNyKe2xNs5FmDyvtY9smzAyWC7DpLwKsdeOPskFAY9sD2LSDb78Ugti5c+nB//5gBdcKDLwWLyH7oStCFk0sD7O/4K2/OwwB5+8byv7A2fnX20ZdI9uBu6io/8dhywHhn5lt2yVmEetOB9VtaOj3azz9PXiGLC3B6cgjLaMpmpMb+jA3ZHdjrEh/D0TqwI+a520kF1yzbIOmYN0RWHAbBIklQ79Hcposg7NKaaW1ZwEtWrAlffBZ3D68yuoXZwQjFiCw0fJ2Qc46ZPBhvDEhklXmWVtMfo5/9iLLSRRiitVMelW+vgtCtw+EipZ9kcKom3Istpvh5L/8GlYPjbr3kXwHNk6YpdROYRi5Pii2Z0wjTtBHu/E1vs9PkwnhgzAJ0j5RAFxVrqb8B0duVspRLcVbRhJMNbfTDv3OpRAJaDmS6n65WVu//wngh1EUC9LQfi+w7r+BwzooiQvtPzIGcOZmBbVM6Q8rufllwBQ43+yAnUx3qq8yNEY11KwjcqdJsJTZBU9RBHdJGdnqhN5kzWxZNKGvMiA4BE8mA4Xn+eALpn5iIH/acRaAkh7gm9Q0zdamEbNT6sPTXxNbaQgiaKiyq43ArAQ3sbTjWkc9cDYUMR1G+uvsPhiColwAv9A7EbV8VpfeYsZUCd+seaCpye+PgErs4wRNCoMMc8rGtOsnCPC6xj//kJv/AK0mr5ojxKynklJ5ndPpQXTea4BBxkCbbex4T2SDCYYzuFW2Lm5p1OW5anUkHuxDjC3yRdMsU7w==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB3067.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(39860400002)(346002)(376002)(136003)(366004)(396003)(6506007)(5660300002)(33656002)(966005)(83380400001)(8936002)(76116006)(478600001)(4326008)(8676002)(45080400002)(66946007)(38100700002)(71200400001)(86362001)(186003)(66556008)(53546011)(9686003)(6916009)(55016002)(66476007)(64756008)(122000001)(316002)(26005)(54906003)(66446008)(2906002)(7696005)(52536014)(357404004);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?U7dBoxWf9dBt7TaIQlrylmC4p8zP+N9jUhUhKSE7yy95OPSUp1RSwXUJVoka?=
 =?us-ascii?Q?74U6hj22MvoauB8jJadVQcDcn4KyiPkfSXYjiOlyQ/lqY6BuyKEtccycbNKt?=
 =?us-ascii?Q?z6eJw3gfLjuId9f4SmB1xgRU6/v/42X1W5Bs8VY1h4M/GBTrNNRHCaT+joTP?=
 =?us-ascii?Q?72+EG22IRgldS0ap5Ym33G18iEW7VbsLCwU3sv6H2vMRoo+1NXxGw7paydSU?=
 =?us-ascii?Q?3nBNlm/kr9s4vLxUKCrex3NfT0THQeQczOAb/WSfia631wr4Bsm0BtS/jm+a?=
 =?us-ascii?Q?Xd2xKcjz2zo+a0+Xt1ETLTfmKAEBHid3Yy9M33VBSHU0XyHy6rei08bMO72W?=
 =?us-ascii?Q?DFpfaxWESqkzV+kOeRqv5Z7mycnf3owt+aAchT3eym5u67tXS/UTd1qrkl65?=
 =?us-ascii?Q?gqMLu+iSD3mmiK0v0mfr/MVL/gDgaPJQvCDX6j+/Fs7IBbeq2Cn0oZueNI+5?=
 =?us-ascii?Q?Phkvsk2yrzJ6Bc2aFm/9zAdaS170/Q9Zmv4MF119y/bhv3cg6A7so4xql81s?=
 =?us-ascii?Q?tCOeSyfjKnZRVNPdiIzmBX2UAHQhgCFpyEgHxLpoOQ4sRgQNWfjxaxjE5uQH?=
 =?us-ascii?Q?mVxHGbrQZwE0/vBbWVeBdiFfciAPDrLIPREOH8voaw101wUZBpygQHxbdNnX?=
 =?us-ascii?Q?GrQnNqYVulXyhBmAVCkUYVUWpqnvm5CbcBjy3M68MXWepmurqbPDyl9OWrJy?=
 =?us-ascii?Q?iRtoG4LnDngRaMPF2pesbUaGk2b8G6ba7c0N2BSVSrN7NgT7HZ4zyq1dAlN2?=
 =?us-ascii?Q?uuc6qroxNfaxriK3x8f+WOfDNR8OMJmid538ADQ78KwWCg0mJ0JvyrBxkZ3z?=
 =?us-ascii?Q?VV2PO7zevHEEhVjF2UGtaVtN1lJrLdsAj67PgDIRmdTEH2f1QoB5X08jafbn?=
 =?us-ascii?Q?JFz8gEWOEa4fVOZ5O0S9lh8ExyCttCsd3vRqrj1p3S3vuPEvWQaFpGOnO929?=
 =?us-ascii?Q?xLuWUJwwF2PlnXYRLS3CZ/0vvgeDm7DbScjRlqlhCWLg7Ur8qzRCqQBUFfnH?=
 =?us-ascii?Q?R0Jy81YOLotOf+Qn1WHagQ1A6d8xTRbfhNZDiiw/y0rOS0BSj4MlMAYulNm3?=
 =?us-ascii?Q?7s+WLEAxiMrXqH8+Z0AIYTXsEN44WeiWdtM7aqOuosIv//IWjaE/+mqD135t?=
 =?us-ascii?Q?VxLtmerHLpNIAZ8hfBC5Hlxkh8WrtWLSoiK3KScIsg/kWHoouE558WZC0bz0?=
 =?us-ascii?Q?2zY5QQ9e45qJvjga/8HBbIUeagWoi56JMXxCCI8HE7aBSVC1oi3jYeLtOy0Y?=
 =?us-ascii?Q?OTW3eHExCaJU0sKwH2szxvb+7uIuQ1zsUuunC6DPX+KPBt9QEMUtACbCpMhY?=
 =?us-ascii?Q?F7Q=3D?=
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3067.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 09b85584-fd35-4743-6b19-08d91c9ff2d2
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 May 2021 21:32:34.7170 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: xaAkVmPxg4PAwzxeSXr8xpXnj1Yt9WFSkRNQhfCMrf7lqExWQpebM/TVy+mhTXSmwxZ5HJCgW/PdonbLkoiqow==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB2373
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
Cc: "Kasiviswanathan, Harish" <Harish.Kasiviswanathan@amd.com>,
 amd-gfx list <amd-gfx@lists.freedesktop.org>, "Sakhnovitch,
 Elena \(Elen\)" <Elena.Sakhnovitch@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Would this be referring to tools that may parse /sys/class/.../device/gpu_metrics or the actual gpu_metrics_vX_Y structs? For the latter, if there are tools that parse dependent on version vX_Y, I agree that we would not want to break those.

Since most ASICs are using different version currently, we would have to create a duplicate struct for each gpu_metrics version currently being used, unless I'm misunderstanding. I'm not sure if this is what you had in mind - let me know.

Best,
Graham

-----Original Message-----
From: Alex Deucher <alexdeucher@gmail.com> 
Sent: Friday, May 21, 2021 4:15 PM
To: Sider, Graham <Graham.Sider@amd.com>
Cc: amd-gfx list <amd-gfx@lists.freedesktop.org>; Kasiviswanathan, Harish <Harish.Kasiviswanathan@amd.com>; Sakhnovitch, Elena (Elen) <Elena.Sakhnovitch@amd.com>
Subject: Re: [PATCH 2/6] drm/amd/pm: Add arcturus throttler translation

[CAUTION: External Email]

On Fri, May 21, 2021 at 1:39 PM Sider, Graham <Graham.Sider@amd.com> wrote:
>
> Hi Alex,
>
> Are you referring to bumping the gpu_metrics_vX_Y version number? Different ASICs are currently using different version numbers already, so I'm not sure how feasible this might be (e.g. arcturus ==  gpu_metrics_v1_1, navi1x == gpu_metrics_v1_3, vangogh == gpu_metrics_v2_1).
>
> Technically speaking no new fields have been added to any of the gpu_metrics versions, just a change in representation in the throttle_status field. Let me know your thoughts on this.
>

I don't know if we have any existing tools out there that parse this data, but if so, they would interpret it incorrectly after this change.  If we bump the version, at least the tools will know how to handle it.

Alex


> Best,
> Graham
>
> -----Original Message-----
> From: Alex Deucher <alexdeucher@gmail.com>
> Sent: Friday, May 21, 2021 10:27 AM
> To: Sider, Graham <Graham.Sider@amd.com>
> Cc: amd-gfx list <amd-gfx@lists.freedesktop.org>; Kasiviswanathan, 
> Harish <Harish.Kasiviswanathan@amd.com>; Sakhnovitch, Elena (Elen) 
> <Elena.Sakhnovitch@amd.com>
> Subject: Re: [PATCH 2/6] drm/amd/pm: Add arcturus throttler 
> translation
>
> [CAUTION: External Email]
>
> General comment on the patch series, do you want to bump the metrics table version since the meaning of the throttler status has changed?
>
> Alex
>
> On Thu, May 20, 2021 at 10:30 AM Graham Sider <Graham.Sider@amd.com> wrote:
> >
> > Perform dependent to independent throttle status translation for 
> > arcturus.
> > ---
> >  .../gpu/drm/amd/pm/swsmu/smu11/arcturus_ppt.c | 62
> > ++++++++++++++++---
> >  1 file changed, 53 insertions(+), 9 deletions(-)
> >
> > diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/arcturus_ppt.c
> > b/drivers/gpu/drm/amd/pm/swsmu/smu11/arcturus_ppt.c
> > index 1735a96dd307..7c01c0bf2073 100644
> > --- a/drivers/gpu/drm/amd/pm/swsmu/smu11/arcturus_ppt.c
> > +++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/arcturus_ppt.c
> > @@ -540,6 +540,49 @@ static int arcturus_freqs_in_same_level(int32_t frequency1,
> >         return (abs(frequency1 - frequency2) <= EPSILON);  }
> >
> > +static uint32_t arcturus_get_indep_throttler_status(
> > +                                       unsigned long
> > +dep_throttler_status) {
> > +       unsigned long indep_throttler_status = 0;
> > +
> > +       __assign_bit(INDEP_THROTTLER_TEMP_EDGE_BIT, &indep_throttler_status,
> > +                 test_bit(THROTTLER_TEMP_EDGE_BIT, &dep_throttler_status));
> > +       __assign_bit(INDEP_THROTTLER_TEMP_HOTSPOT_BIT, &indep_throttler_status,
> > +                 test_bit(THROTTLER_TEMP_HOTSPOT_BIT, &dep_throttler_status));
> > +       __assign_bit(INDEP_THROTTLER_TEMP_MEM_BIT, &indep_throttler_status,
> > +                 test_bit(THROTTLER_TEMP_MEM_BIT, &dep_throttler_status));
> > +       __assign_bit(INDEP_THROTTLER_TEMP_VR_GFX_BIT, &indep_throttler_status,
> > +                 test_bit(THROTTLER_TEMP_VR_GFX_BIT, &dep_throttler_status));
> > +       __assign_bit(INDEP_THROTTLER_TEMP_VR_MEM_BIT, &indep_throttler_status,
> > +                 test_bit(THROTTLER_TEMP_VR_MEM_BIT, &dep_throttler_status));
> > +       __assign_bit(INDEP_THROTTLER_TEMP_VR_SOC_BIT, &indep_throttler_status,
> > +                 test_bit(THROTTLER_TEMP_VR_SOC_BIT, &dep_throttler_status));
> > +       __assign_bit(INDEP_THROTTLER_TDC_GFX_BIT, &indep_throttler_status,
> > +                 test_bit(THROTTLER_TDC_GFX_BIT, &dep_throttler_status));
> > +       __assign_bit(INDEP_THROTTLER_TDC_SOC_BIT, &indep_throttler_status,
> > +                 test_bit(THROTTLER_TDC_SOC_BIT, &dep_throttler_status));
> > +       __assign_bit(INDEP_THROTTLER_PPT0_BIT, &indep_throttler_status,
> > +                 test_bit(THROTTLER_PPT0_BIT, &dep_throttler_status));
> > +       __assign_bit(INDEP_THROTTLER_PPT1_BIT, &indep_throttler_status,
> > +                 test_bit(THROTTLER_PPT1_BIT, &dep_throttler_status));
> > +       __assign_bit(INDEP_THROTTLER_PPT2_BIT, &indep_throttler_status,
> > +                 test_bit(THROTTLER_PPT2_BIT, &dep_throttler_status));
> > +       __assign_bit(INDEP_THROTTLER_PPT3_BIT, &indep_throttler_status,
> > +                 test_bit(THROTTLER_PPT3_BIT, &dep_throttler_status));
> > +       __assign_bit(INDEP_THROTTLER_PPM_BIT, &indep_throttler_status,
> > +                 test_bit(THROTTLER_PPM_BIT, &dep_throttler_status));
> > +       __assign_bit(INDEP_THROTTLER_FIT_BIT, &indep_throttler_status,
> > +                 test_bit(THROTTLER_FIT_BIT, &dep_throttler_status));
> > +       __assign_bit(INDEP_THROTTLER_APCC_BIT, &indep_throttler_status,
> > +                 test_bit(THROTTLER_APCC_BIT, &dep_throttler_status));
> > +       __assign_bit(INDEP_THROTTLER_VRHOT0_BIT, &indep_throttler_status,
> > +                 test_bit(THROTTLER_VRHOT0_BIT, &dep_throttler_status));
> > +       __assign_bit(INDEP_THROTTLER_VRHOT1_BIT, &indep_throttler_status,
> > +                 test_bit(THROTTLER_VRHOT1_BIT, 
> > + &dep_throttler_status));
> > +
> > +       return (uint32_t)indep_throttler_status; }
> > +
> >  static int arcturus_get_smu_metrics_data(struct smu_context *smu,
> >                                          MetricsMember_t member,
> >                                          uint32_t *value) @@ -629,7
> > +672,7 @@ static int arcturus_get_smu_metrics_data(struct 
> > +smu_context *smu,
> >                         SMU_TEMPERATURE_UNITS_PER_CENTIGRADES;
> >                 break;
> >         case METRICS_THROTTLER_STATUS:
> > -               *value = metrics->ThrottlerStatus;
> > +               *value =
> > + arcturus_get_indep_throttler_status(metrics->ThrottlerStatus);
> >                 break;
> >         case METRICS_CURR_FANSPEED:
> >                 *value = metrics->CurrFanSpeed; @@ -2213,13 +2256,13 
> > @@ static const struct throttling_logging_label {
> >         uint32_t feature_mask;
> >         const char *label;
> >  } logging_label[] = {
> > -       {(1U << THROTTLER_TEMP_HOTSPOT_BIT), "GPU"},
> > -       {(1U << THROTTLER_TEMP_MEM_BIT), "HBM"},
> > -       {(1U << THROTTLER_TEMP_VR_GFX_BIT), "VR of GFX rail"},
> > -       {(1U << THROTTLER_TEMP_VR_MEM_BIT), "VR of HBM rail"},
> > -       {(1U << THROTTLER_TEMP_VR_SOC_BIT), "VR of SOC rail"},
> > -       {(1U << THROTTLER_VRHOT0_BIT), "VR0 HOT"},
> > -       {(1U << THROTTLER_VRHOT1_BIT), "VR1 HOT"},
> > +       {(1U << INDEP_THROTTLER_TEMP_HOTSPOT_BIT), "GPU"},
> > +       {(1U << INDEP_THROTTLER_TEMP_MEM_BIT), "HBM"},
> > +       {(1U << INDEP_THROTTLER_TEMP_VR_GFX_BIT), "VR of GFX rail"},
> > +       {(1U << INDEP_THROTTLER_TEMP_VR_MEM_BIT), "VR of HBM rail"},
> > +       {(1U << INDEP_THROTTLER_TEMP_VR_SOC_BIT), "VR of SOC rail"},
> > +       {(1U << INDEP_THROTTLER_VRHOT0_BIT), "VR0 HOT"},
> > +       {(1U << INDEP_THROTTLER_VRHOT1_BIT), "VR1 HOT"},
> >  };
> >  static void arcturus_log_thermal_throttling_event(struct 
> > smu_context
> > *smu)  { @@ -2314,7 +2357,8 @@ static ssize_t 
> > arcturus_get_gpu_metrics(struct smu_context *smu,
> >         gpu_metrics->current_vclk0 = metrics.CurrClock[PPCLK_VCLK];
> >         gpu_metrics->current_dclk0 = metrics.CurrClock[PPCLK_DCLK];
> >
> > -       gpu_metrics->throttle_status = metrics.ThrottlerStatus;
> > +       gpu_metrics->throttle_status =
> > +
> > + arcturus_get_indep_throttler_status(metrics.ThrottlerStatus);
> >
> >         gpu_metrics->current_fan_speed = metrics.CurrFanSpeed;
> >
> > --
> > 2.17.1
> >
> > _______________________________________________
> > amd-gfx mailing list
> > amd-gfx@lists.freedesktop.org
> > https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Fli
> > st 
> > s.freedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;data=04%7C01%7C
> > Gr
> > aham.Sider%40amd.com%7Ca3ca9a6b0576479e545808d91c648f50%7C3dd8961fe4
> > 88 
> > 4e608e11a82d994e183d%7C0%7C0%7C637572040495495758%7CUnknown%7CTWFpbG
> > Zs 
> > b3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%
> > 3D 
> > %7C1000&amp;sdata=YxUx7BrsQKBauKE3fHpNrkWMAG4dBy11fV9xnJdMHns%3D&amp
> > ;r
> > eserved=0
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
