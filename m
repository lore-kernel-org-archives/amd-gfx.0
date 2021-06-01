Return-Path: <SRS0=H3yO=K3=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A795FC4708F
	for <amd-gfx@archiver.kernel.org>; Tue,  1 Jun 2021 16:50:37 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6B59461263
	for <amd-gfx@archiver.kernel.org>; Tue,  1 Jun 2021 16:50:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6B59461263
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1A9386EAB6;
	Tue,  1 Jun 2021 16:50:37 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2076.outbound.protection.outlook.com [40.107.236.76])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 095E06EAB6
 for <amd-gfx@lists.freedesktop.org>; Tue,  1 Jun 2021 16:50:36 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=k9Gn0cud4xsUR3ApiELyKD9cpYK9NOPFnXMLhe+LMlwiBH0yYyGZ6Bp8ACwg9IdgF3rGJpwy7a6UUAxPQBa2Z0+ZfeZpRT5viQfh8SQDCTkfumZjdIoM5SAzAhFAEyBmgqjUlbpeQq4cd9+2JTQfvq4t2xle9UQ8ROzdT+KkBQ1+qBPhvp7nwdlhF1L3eu7uI3b3rFfCCyUrisUnt81j59fme5gSe1knTwUVkIs1ZFzhcHxsu8t3iSJy5dN1cgRUAk9jIPCSR1yVOG3rFJ+7CM2YqHc2hO5Gx63TpP9DVXN4S6z69iU3h2V2THSV4sQBXNsoyDhPPkcZr2FwRMSLkQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NHunUGtU2uxdkmZ8MBEp7YvAcYwcTkEAImQEFYzpG/4=;
 b=X8ll7BHSBLEWFNUlLPXW0uCsnGh3EF7G+jsy2Z9fD7rqC4lFq3OGr1dYI4OJzdvSzqQ2xfipajDGKXg7DdYxqScveGYajTEJXtuLow4nIyDwzzbOe5tI1qbctZJzHV/Jx4/pDA//gB5j5ae1oJKM7HjXFPEx1Ti+mveBV2fJ2zjF6f2U2mKSiVACerhbsy4YQbmklQazUGJOW3dJuphVUAevNRKwtNih0qM3KiMUxmGyK47MW/NAKspDvsy6ta26ZqFxsP6MtQ2DWijHv8jLgKWza1R8NKVTwHm0j+Hupq2y4MdXAD/SUUbKrjn95QeBQNPPS7cbNvWgV9wxRNSrUg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NHunUGtU2uxdkmZ8MBEp7YvAcYwcTkEAImQEFYzpG/4=;
 b=xD2eI4CmNQ65ZQ6d/+W/5qpBlipZeFr5NUaw+VO6fYOk5E8qUqsTtHlldZba6Dwdvpub49v3IkN1HGlVBoWCbyLkQKSzPAPRT0GM0g8Gel+QAUnfG5s4a7UtPPClWf8t/a5x4KwScR/8nlqpf5pCSPHKg27BIU2C3YGPTS6qCM0=
Received: from DM6PR12MB3547.namprd12.prod.outlook.com (2603:10b6:5:18a::20)
 by DM6PR12MB4878.namprd12.prod.outlook.com (2603:10b6:5:1b8::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4173.20; Tue, 1 Jun
 2021 16:50:33 +0000
Received: from DM6PR12MB3547.namprd12.prod.outlook.com
 ([fe80::6c1d:e14b:dc15:7e56]) by DM6PR12MB3547.namprd12.prod.outlook.com
 ([fe80::6c1d:e14b:dc15:7e56%2]) with mapi id 15.20.4173.030; Tue, 1 Jun 2021
 16:50:33 +0000
From: "StDenis, Tom" <Tom.StDenis@amd.com>
To: Mario Kleiner <mario.kleiner.de@gmail.com>
Subject: Re: display regression on Carrizo
Thread-Topic: display regression on Carrizo
Thread-Index: AQHXVicrrc1NgRIk1U2QjRt8FzPtAar/JJKAgAA7hvU=
Date: Tue, 1 Jun 2021 16:50:33 +0000
Message-ID: <DM6PR12MB3547B98DE79FE9CEAE399CBAF73E9@DM6PR12MB3547.namprd12.prod.outlook.com>
References: <DM6PR12MB3547CA74B0AA230909080A0AF73F9@DM6PR12MB3547.namprd12.prod.outlook.com>,
 <CAEsyxyhmjds=87PKyVVkruwZLOQgk_DALgD_-_nLxzmMiH3qFg@mail.gmail.com>
In-Reply-To: <CAEsyxyhmjds=87PKyVVkruwZLOQgk_DALgD_-_nLxzmMiH3qFg@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Enabled=True;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SetDate=2021-06-01T16:50:32.936Z;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Name=AMD-Official
 Use
 Only; MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ContentBits=0;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Method=Standard; 
authentication-results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [2607:f2c0:e4c0:b2:d3fb:b908:583b:772c]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: cf21fbff-e155-40fa-c49f-08d9251d5f94
x-ms-traffictypediagnostic: DM6PR12MB4878:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM6PR12MB487815018717ED0DE97EFDE9F73E9@DM6PR12MB4878.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:3968;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: rEeKfXAd3VLmO3cYEGx7xo9yUeLtRKHwFvIaQ5oitD4ZgqHjx0o8MaEKNLvXRfeg6w80vqYaTqoJC2NIDxSOQTrYZSdBY3I8qcrLY2vkq6SaaknleOc+OEbgi6ptmisgTm/G60gthnyucDr52HMKKxwVy6ZZFPwEkTk28lbhL9PVzaXsvRzJojgueEYtTo4Xu3k26hen+oJY1sUP9gn43UXL8UCVFfMMARDxs8VFB7b29oAmxJMo3+q7P9WzECFw9jVscZM2WjdrSaJEixndMb8ee7vLnDNgeJ/6O4iYJ6wHd6G/8V4PtcmW2RROsDMJUTzgAknhL0pZ8dExMkIwoTVRylrHDBRoIVf2g6jer3Q24Zk1fu8rjHQp35aZAHixfw4UrlpxMpdhq6h5hShJfQ+Ov5M1U9yltcEEPouvK70KgreXWIXx3yDAe05c9JzBT0J2yM5kdi81F6x2FfaOCzYGD8dfzPqMcw9dDPGF0bap+7D90qts5MnOQDmZuKw7BR1+7pbkwW1sdPJ6AcUXgLqp8zQ3copZO8Ndq38+n8PBmRuunpVKlYbp1T/xLSV2TUa/E/6m2aBtaG6aJQYKQpIkbKK20mT9TrOFkNL94l8=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB3547.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(376002)(39860400002)(136003)(396003)(346002)(366004)(53546011)(55016002)(6506007)(478600001)(7696005)(4326008)(52536014)(66946007)(66446008)(186003)(2906002)(8936002)(33656002)(64756008)(54906003)(66476007)(5660300002)(83380400001)(8676002)(38100700002)(3480700007)(9686003)(316002)(66556008)(71200400001)(122000001)(6916009)(76116006)(86362001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: =?iso-8859-1?Q?a4JQDFPPt+oDOLptbwuOPzeqGljbCP/1b7/+eb0KfQDBWnHQUQppc9BJ/o?=
 =?iso-8859-1?Q?KXch3qbSCfkjyXI1EerWVp77bVCR/WBcNGbeN36ewnfe8Y6lITMuWAnQuB?=
 =?iso-8859-1?Q?xUnovmALB1DtiPbQisvSeC3UBSJ0TneTFttXvz2VXD9jcCWtlIgvV+g8gt?=
 =?iso-8859-1?Q?WdFrPP9PsIqpHDDVI/q7xWJt33kUCgRmpfVkc7NEvMmre7bbpl3yheS/tS?=
 =?iso-8859-1?Q?I9ucULqE5yxY5VgDyjIPRjGWCWgov1Rk2R8tAm7ZNfv/S49O+N8zf9YxN8?=
 =?iso-8859-1?Q?6W9jC9OTmNNp2PJnioeq986VleUnqAbfyObqWWyBJvk4nbbaTLihew4LBv?=
 =?iso-8859-1?Q?/ppS/2c6eD2BoSc5qBugTBIEKN9mLUdAGaYLbF97SkVPHzW81g+YQCvgz1?=
 =?iso-8859-1?Q?MpLp8tDfUge0JajlUpY22whgtfptwxWjvN8tyL9oNlqs4TcBTojuGmM26m?=
 =?iso-8859-1?Q?zFhJLq3WvJD4bvc3VfBCjOXpJ7jvsdl9rFEkzjVjZCVrMuqhyBUcFdrjcv?=
 =?iso-8859-1?Q?HPcwOsVawabOFVVrgLrESwDatxcc2LmVmUojzjHFxRgQHs83PiXRwDDTnu?=
 =?iso-8859-1?Q?POIYvX8d2Aoj5l6B64dTn8uVJP0yxJgGxAG6lM8vdTd41zZP1cZFzSVz57?=
 =?iso-8859-1?Q?sQP7kRKC8c4ClNsCH6TpAkLCKCZ7sue9VJ1XBRJTskQOCo0Da70dIRSgXN?=
 =?iso-8859-1?Q?mqlO56p2PraBIPrycnuXJ/VEZZMLTMp+F0w1xWuI7KZWUjRtWkxmSoasMU?=
 =?iso-8859-1?Q?FqZ95dJ+hRB8SGrrAidzDLdyydG7zgGXSLm5IT22KBh93Lcomjs1KxUX4Q?=
 =?iso-8859-1?Q?N339M/ozQgIcByrjCQU9h+hdHRQX++WINyk6zIfrU0q6GnFyNLXle3ISGt?=
 =?iso-8859-1?Q?uQFdc7KnM71u/Nw0fM7v9nrTqiAHhj462q4RxKuY55sMlY0CwW0h33ry5N?=
 =?iso-8859-1?Q?LwwZJ94unXVFOGjuGtECEA317Y+yzzF994zXS5h7fLCeu3s3YGG1B1GLHl?=
 =?iso-8859-1?Q?o0a89Sl5X2t5ySovVlvzWeMKN2/VXSW90vt0J9HwoyAADCz4j2L9gyqLOF?=
 =?iso-8859-1?Q?ehZRwFzKtdbd7fkHXcsRbFXis2C7KHa2M4SDEj91VSoo+9kB7wmB6t6aVO?=
 =?iso-8859-1?Q?pNHmGXNvMEBn80HTk9hpSDgzcNPv8JFff5nIqZOI+XsRSLEM3GZPd/0pI5?=
 =?iso-8859-1?Q?S4jr8TCSRwrjuKn6LtmwvJc6Kpj5MK6a64OpYzb8cBtBjzaYiTzpW9rmQ2?=
 =?iso-8859-1?Q?wQ/jp4A84RBQ740VepDKLy0mGT4wIqSSKgZkcf0Uth+nzGNwmWsYp9kkpD?=
 =?iso-8859-1?Q?8yhbQCMpqOfIlmrcT8Yy7A0ZHdTk3EuRDJ10soiKloHg7gdLB5SOqRkp7I?=
 =?iso-8859-1?Q?PrrhNYDmLGc2yE9hbDN3YhrFdz3RH359O7FR5RzB0tk/h7710Lf+A=3D?=
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3547.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cf21fbff-e155-40fa-c49f-08d9251d5f94
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Jun 2021 16:50:33.6101 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: oVJE91LdJwS6PPRHf2W6O2Q5S9mAoU6DIMnk6t0zuFUzWAyb5DE8CyJPZcpe+RXuuhd+KroNbjVrZia5uhNUuA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4878
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
 amd-gfx list <amd-gfx@lists.freedesktop.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Official Use Only]

Hi Mario,

Yes, this diff fixes the display on my Carrizo:

[root@carrizo linux]# git diff
diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_resource.c b/drivers/gpu/drm/amd/display/dc/core/dc_resource.c
index cd864cc83539..ca7739c9f6cb 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_resource.c
@@ -1044,7 +1044,7 @@ bool resource_build_scaling_params(struct pipe_ctx *pipe_ctx)
         * SURFACE_PIXEL_FORMAT_GRPH_ABGR16161616 with actual > 10 bpc
         * precision on at least DCN display engines.
         */
-       pipe_ctx->plane_res.scl_data.lb_params.depth = LB_PIXEL_DEPTH_36BPP;
+       pipe_ctx->plane_res.scl_data.lb_params.depth = LB_PIXEL_DEPTH_30BPP;
        pipe_ctx->plane_res.scl_data.lb_params.alpha_en = plane_state->per_pixel_alpha;

        if (pipe_ctx->plane_res.xfm != NULL)

Tom

________________________________________
From: Mario Kleiner <mario.kleiner.de@gmail.com>
Sent: Tuesday, June 1, 2021 09:17
To: StDenis, Tom
Cc: amd-gfx list; Deucher, Alexander
Subject: Re: display regression on Carrizo

On Mon, May 31, 2021 at 4:14 PM StDenis, Tom <Tom.StDenis@amd.com> wrote:
>
> [AMD Official Use Only]
>
> Hi Mario,
>

Hi Tom,

> The following commit causes a display regression on my Carrizo when booting linux into a console (e.g. no WM).  When the driver inits the display goes green and is unusable.  The commit prior to this one on amd-staging-drm-next results in a clean init.
>

That's sad. What happens if you only revert the change to
drivers/gpu/drm/amd/display/dc/core/dc_resource.c in this commit,ie.
change the assignment in resource_build_scaling_params() back to:

pipe_ctx->plane_res.scl_data.lb_params.depth = LB_PIXEL_DEPTH_30BPP;

As my testing on Polaris / DCE11.2 showed, for some reason the change
in linebuffer pixeldepth was not required for my Polaris11 to get
12bpc output, only for my Raven Ridge / DCN-1. Maybe I could make a
followup patch to make it conditional on asic? Either only increase lb
depth on DCN-1+, leave it off for DCE, or just exclude DCE-11.0 from
the change, as Carrizo is DCE-11? I seem to remember there were some
other DCE-11 specific restrictions wrt. 64bpp fp16 and the scaler.
Maybe something similar happens here?

-mario

> commit b1114ddd63be03825182d6162ff25fa3492cd6f5
> Author: Mario Kleiner <mario.kleiner.de@gmail.com>
> Date:   Fri Mar 19 22:03:15 2021 +0100
>
>     drm/amd/display: Increase linebuffer pixel depth to 36bpp.
>
>     Testing with the photometer shows that at least Raven Ridge DCN-1.0
>     does not achieve more than 10 bpc effective output precision with a
>     16 bpc unorm surface of type SURFACE_PIXEL_FORMAT_GRPH_ABGR16161616,
>     unless linebuffer depth is increased from LB_PIXEL_DEPTH_30BPP to
>     LB_PIXEL_DEPTH_36BPP. Otherwise precision gets truncated somewhere
>     to 10 bpc effective depth.
>
>     Strangely this increase was not needed on Polaris11 DCE-11.2 during
>     testing to get 12 bpc effective precision. It also is not needed for
>     fp16 framebuffers.
>
>     Tested on DCN-1.0 and DCE-11.2.
>
>     Signed-off-by: Mario Kleiner <mario.kleiner.de@gmail.com>
>     Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
>
>  drivers/gpu/drm/amd/display/dc/core/dc_resource.c          | 7 +++++--
>  drivers/gpu/drm/amd/display/dc/dce/dce_transform.c         | 6 ++++--
>  drivers/gpu/drm/amd/display/dc/dce110/dce110_transform_v.c | 3 ++-
>  drivers/gpu/drm/amd/display/dc/dcn10/dcn10_dpp.c           | 3 ++-
>  drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hw_sequencer.c  | 2 +-
>  drivers/gpu/drm/amd/display/dc/dcn20/dcn20_dpp.c           | 3 ++-
>  drivers/gpu/drm/amd/display/dc/dcn20/dcn20_hwseq.c         | 2 +-
>  drivers/gpu/drm/amd/display/dc/dcn30/dcn30_dpp.c           | 3 ++-
>  8 files changed, 19 insertions(+), 10 deletions(-)
>
> Tom
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
