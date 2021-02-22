Return-Path: <SRS0=DoF4=HY=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.4 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MIME_HTML_MOSTLY,PDS_BAD_THREAD_QP_64,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 815D1C433DB
	for <amd-gfx@archiver.kernel.org>; Mon, 22 Feb 2021 13:43:50 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3A0D864E74
	for <amd-gfx@archiver.kernel.org>; Mon, 22 Feb 2021 13:43:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3A0D864E74
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E54B16E0CF;
	Mon, 22 Feb 2021 13:43:49 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on20621.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7eab::621])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DDB3C6E0CF
 for <amd-gfx@lists.freedesktop.org>; Mon, 22 Feb 2021 13:43:48 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lGi9o+wiFWp8pVQtsBBWzH3JAMbharHm4IePap8AmNoA44oYl5xm8bsarwlt6dZG0QMrXK2EZyinr3BY4SjzTW6lWj63tY+9r+I80CSfFiTlxxWBRqvPRQw22XBXGmgh5IkBcvJ6Rai4dQQjKQn5QAA1Ol/yUkqie652UDE4N8jRmrUxKFj+oOmL93QBcifnxfe818HaC6ZWXMus4HGZh1w6s+aku8pjvDoWy9YLgzfAuiptE6lbPwkMHoTy+4mFnV4mTc8Kw7pnFvUHgsGCi5aoL7hqSrHjbuegiW5SwLVFXuhD7PBfsIa9rXxkaVsCPV3WoeYPJiFOqPHsQ6ZjTQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ULiMT5OixzLM18qhjjOUA9RkLMQRbkQ0+z0I4Wt/fKw=;
 b=dMf3sW4pe6DjSiIBPxXmRVmb+/Iw9+dJUYrC/HAq4NMZSSVDl9xYECSyQp7pPSOOnymegXf4lApZtC/TDTCjjP0cbncGNeTSxZoE8oGkOLY+QPz8OYxRlzWOU1d89MwCEuhRruqTuJqcymj+/jYFufWVETvsCyuj6BtSEyiaA81PIC4X2Ba29hzaoVMD/Mv9i69GxUyzAXNz2sex7h/yLGsZFhzseVXa3LN2Hhu8A70rkBzi7Z4OL3KzQe071xjMoMqGDxoQEolIFwXSBU5qCMXgJdjLFJAqNEQUnq2JAmih3cHPvWd3EhLAeXYUA/vOnbcxx5ncYgJVp6HQxjU4kw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ULiMT5OixzLM18qhjjOUA9RkLMQRbkQ0+z0I4Wt/fKw=;
 b=Z66dCRCpLbxwrOEyq1y9ZyxmdHX59Lb08XIhs7KPzwwGjUFTCoJMi5tdvLDULWXelPiiSPvaMGYheyk1MW9KwQ1pu0+eYkLx89GkFj/t1UgnZUpWrJoWSAiaxH3e5fR0WZvKdDDdORZU5HP27cfEC8/yU5RDhRWp3XPaEg8v5Zs=
Received: from DM6PR12MB4267.namprd12.prod.outlook.com (2603:10b6:5:21e::16)
 by DM5PR12MB1545.namprd12.prod.outlook.com (2603:10b6:4:7::23) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3868.32; Mon, 22 Feb 2021 13:43:44 +0000
Received: from DM6PR12MB4267.namprd12.prod.outlook.com
 ([fe80::8b9:6f:13ab:1e94]) by DM6PR12MB4267.namprd12.prod.outlook.com
 ([fe80::8b9:6f:13ab:1e94%6]) with mapi id 15.20.3868.033; Mon, 22 Feb 2021
 13:43:44 +0000
From: "R, Bindu" <Bindu.R@amd.com>
To: =?iso-8859-1?Q?Nils_Wallm=E9nius?= <nils.wallmenius@gmail.com>
Subject: Re: [PATCH 08/13] drm/amd/display: Synchronize displays with
 different timings
Thread-Topic: [PATCH 08/13] drm/amd/display: Synchronize displays with
 different timings
Thread-Index: AQHXBwzzqzbBzRrZ9EmTyDpR3+5sxKpiJV8AgAIEp9U=
Date: Mon, 22 Feb 2021 13:43:44 +0000
Message-ID: <DM6PR12MB4267548CF8EE62D8AF138FD4F5819@DM6PR12MB4267.namprd12.prod.outlook.com>
References: <20210219221612.1713328-1-bindu.r@amd.com>
 <20210219221612.1713328-9-bindu.r@amd.com>,
 <CA+nq7Dv1q1ncUZzSV=Art-etybyL+Ztx64=9uMYgVZiTsympHA@mail.gmail.com>
In-Reply-To: <CA+nq7Dv1q1ncUZzSV=Art-etybyL+Ztx64=9uMYgVZiTsympHA@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-Mentions: Vladimir.Stempen@amd.com
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Enabled=True;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SetDate=2021-02-22T13:43:43.428Z;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Name=Internal
 Distribution
 Only; MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ContentBits=0;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Method=Standard; 
authentication-results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [2607:fea8:4ce1:13a0:7882:89cb:eb8b:3cae]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 767f0f4c-a54c-4092-6cf4-08d8d737df5e
x-ms-traffictypediagnostic: DM5PR12MB1545:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM5PR12MB1545CBA45162F14CA5667A7CF5819@DM5PR12MB1545.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7691;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: uWip+if3o+nbQB9mFa0ahHuW33jQt06C1OyEIdplYYGowH5EzrT2DfOA83E9uABAAI4mS2yELjq0IiYEfAaJh3veyXXLFjK9aYXog9yxFdh5QREecHCH022yw5wEbGz9uxtV5hd5xPnhpmtoJ7+5Po3Q2GUBR3gyySysAI/baHO624u+W5l8CSAtNM3o5/agPfyPSgwV4gnFoAA8ca1gueJWfJbNs5FB0WETXRoGT92k7vkHdR8j1DfnDtctIZPazbCMO+NhDGtwbtsgJBeVuCZK7v8lt1x9kYNGoMCKggAh7oZx3cm5FogigY9mMEr/xmP4qc+wkbp9TwWp+loZ6Gg7d0unjxcqKJB3lJsoB8xjj+dFssfdyRcP+1jLFiFbJg1smUSQbt5VdsVW5eWibnjsbE2hvdg4BpWZ9OPeink03gvDA1LNA0yngaF4O3+id6ioU3cND+1/HKlU0dREaajwVgTSjzirCBSt1Qi7GJzkJd5mMSPjugJh4FL8uApSuQ0GwXB9oVaAm2KFxr+Vfg==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB4267.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(396003)(346002)(376002)(136003)(366004)(39860400002)(33656002)(52536014)(316002)(19627405001)(6506007)(19627235002)(7696005)(54906003)(2906002)(30864003)(478600001)(186003)(86362001)(71200400001)(64756008)(66476007)(91956017)(5660300002)(66556008)(66946007)(66446008)(6916009)(76116006)(66574015)(83380400001)(8676002)(4326008)(9686003)(8936002)(55016002)(53546011);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: =?iso-8859-1?Q?vQqDi/LhXRootOByv+YITeOOlXvMkETswk8a0xb4qlLEtukhC6283zOg2c?=
 =?iso-8859-1?Q?uw0vx+C6NJJHECeepHqVrBdLWTfM7Wi0RwPzosaIFokM8NIbNWYw1xh/5U?=
 =?iso-8859-1?Q?tRxh2UzXOtOxWSkoOf+LNCUYHgPORM2jNjb5LVYvipCtAJJ0jGvzKJhwVN?=
 =?iso-8859-1?Q?oekDThyoq9jcv512OWVHkrbIEXBX4gbOSgpKcDFZ+HIy9Z1A4VSFVsc/mR?=
 =?iso-8859-1?Q?9KkND19+JN9y55mrsZpVllxAEyLB6HZJSPY1RgCokMtr3n8VqgM0OFFHKs?=
 =?iso-8859-1?Q?kK6CTrETp8J0zZweuBA0caSNDDXwddbzxgUNBp8Htz0jP5UeU1wONtZ/MA?=
 =?iso-8859-1?Q?Zhmp5veP5xGfuAXmI8TwFdy2IlNws7CFq5CuhN8cyKlblOZfcoVJmLE/mP?=
 =?iso-8859-1?Q?qfWDZlnVZWO2/1hl+iSPhf/p7QAicVDvABudp6fWg9UDM/jHIznQc0ukB0?=
 =?iso-8859-1?Q?YqTq+OLQIY+JEejpUEBRKwh6+NCcy2JQ6O4+1Q3V4L+MA/9NDLpXWNpdgN?=
 =?iso-8859-1?Q?8rUguC7LY8Jc+zii2XYravr80/iZQX7jnhYqS56ZBSFbbzURD1Sp4uNzyv?=
 =?iso-8859-1?Q?8WvUHLQP3evuOyDAxG4eHs2NtzUZN+uJ90BNCA5aG27U9aXyybJ1TsJgB9?=
 =?iso-8859-1?Q?hxWLda1tQQ91EJUthI27R2IR0uhBq8lLFvpRocgOYenrsUsrHUyW+fabXF?=
 =?iso-8859-1?Q?pBA8Dr2714+J6fwT6pH0/wGGZjqIIJgsas5U/EM5db/Q7oSyMVfMZ+Uko+?=
 =?iso-8859-1?Q?u3aTvezjdZef9pDboSiS27CKf4kdNjsrFpepAbmyckrInSCRk1a98Nl9HD?=
 =?iso-8859-1?Q?sjkPaQkXECwkSKRCU3g8xKkfQb9dirkAHhFMs7LrpkB2t/GTdl+EQeMabT?=
 =?iso-8859-1?Q?MDxPKm3xW4/IcqAK7idUIf56AwHl2eqSnXK7n/LKAwlwY+V5m1IMhD56XR?=
 =?iso-8859-1?Q?wmGIyfTbQTHPIQ4Xh2TRkMBl/HiejPjA5J6FsOZnbP4KYNFIaIHjHuzJRx?=
 =?iso-8859-1?Q?zVzC0QOdFbKQLY0uqltCyAOfkmw0L3+p13W3zGxVv7z+B/bILb2ALKMFBQ?=
 =?iso-8859-1?Q?nVngXO3lwsBHuo2oNjn0TXwCiZUjNiOUPXF2X57/DEbnmES/iOwrMn6QfT?=
 =?iso-8859-1?Q?ETFCdbGYA2s/TynpEqVXYX31XV7jPudfcnGSUEpgazruUgjKXSrPukynaE?=
 =?iso-8859-1?Q?tVBJpfp6uvlVh5hXIX3degV6QSfKUFZ43fnHU4Wg4blpkfW88QlgaLX6/r?=
 =?iso-8859-1?Q?u+UQMmY577FbyqhOYQX/2txQlxyJvTWosbktFOZ9/3zyQein+1k2Y1djuP?=
 =?iso-8859-1?Q?caiBPJ+LqaVT0q49axnf/+JqzboIV7jRCVNIrs/TT9Fj7B2iXGK6g5eTuT?=
 =?iso-8859-1?Q?9Y1e4UsMlcc2zwxuEc+M+GrtRY8Yk1DcgYR9PLrcJP0erQkqtUQwcz2JTv?=
 =?iso-8859-1?Q?9ckGAd/nG5GKqcol?=
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4267.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 767f0f4c-a54c-4092-6cf4-08d8d737df5e
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Feb 2021 13:43:44.2102 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Vd6mGto5rRqL9U7PupoBfs0ofp7BTpxf4GUpNU1NdMJmOsVi9UKXKOsxV5LybQEFdNRQNqvFJMBJArmUFiDU0Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1545
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
Cc: "Brol, Eryk" <Eryk.Brol@amd.com>, "Li,
 Sun peng \(Leo\)" <Sunpeng.Li@amd.com>, "Lakha,
 Bhawanpreet" <Bhawanpreet.Lakha@amd.com>, "Zhuo,
 Qingqing" <Qingqing.Zhuo@amd.com>, "Siqueira,
 Rodrigo" <Rodrigo.Siqueira@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>, "Jacob,
 Anson" <Anson.Jacob@amd.com>, "Stempen, 
 Vladimir" <Vladimir.Stempen@amd.com>, "Pillai,
 Aurabindo" <Aurabindo.Pillai@amd.com>, "Wentland,
 Harry" <Harry.Wentland@amd.com>
Content-Type: multipart/mixed; boundary="===============1640239883=="
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--===============1640239883==
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_DM6PR12MB4267548CF8EE62D8AF138FD4F5819DM6PR12MB4267namp_"

--_000_DM6PR12MB4267548CF8EE62D8AF138FD4F5819DM6PR12MB4267namp_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

[AMD Official Use Only - Internal Distribution Only]

Hi Nils,?
   ?Thanks for the inputs.

@ Stempen, Vladimir<mailto:Vladimir.Stempen@amd.com>,
      ? As the array 'prime_numbers' has constant values defined, we can ma=
rk this as static const. Would you like to change the count calculation -or=
- retain the same limit iteration ? All the patches would be merged to upst=
ream by today. please suggest.

Thanks,
Bindu
________________________________
From: Nils Wallm=E9nius <nils.wallmenius@gmail.com>
Sent: Sunday, February 21, 2021 1:21 AM
To: R, Bindu <Bindu.R@amd.com>
Cc: amd-gfx@lists.freedesktop.org <amd-gfx@lists.freedesktop.org>; Stempen,=
 Vladimir <Vladimir.Stempen@amd.com>; Brol, Eryk <Eryk.Brol@amd.com>; Li, S=
un peng (Leo) <Sunpeng.Li@amd.com>; Wentland, Harry <Harry.Wentland@amd.com=
>; Zhuo, Qingqing <Qingqing.Zhuo@amd.com>; Siqueira, Rodrigo <Rodrigo.Sique=
ira@amd.com>; Jacob, Anson <Anson.Jacob@amd.com>; Pillai, Aurabindo <Aurabi=
ndo.Pillai@amd.com>; Lakha, Bhawanpreet <Bhawanpreet.Lakha@amd.com>
Subject: Re: [PATCH 08/13] drm/amd/display: Synchronize displays with diffe=
rent timings

Hi Bindu, an inline comment below.

Den fre 19 feb. 2021 23:16Bindu Ramamurthy <bindu.r@amd.com<mailto:bindu.r@=
amd.com>> skrev:
From: Vladimir Stempen <vladimir.stempen@amd.com<mailto:vladimir.stempen@am=
d.com>>

[why]
 Vendor based fan noise improvement

[how]
Report timing synchronizable when DP streams time frame
difference is less than 0.05 percent. Adjust DP  DTOs and
sync displays using  MASTER_UPDATE_LOCK_DB_X_Y

Signed-off-by: Vladimir Stempen <vladimir.stempen@amd.com<mailto:vladimir.s=
tempen@amd.com>>
Acked-by: Bindu Ramamurthy <bindu.r@amd.com<mailto:bindu.r@amd.com>>
---
 drivers/gpu/drm/amd/display/dc/core/dc.c      |  28 ++-
 .../gpu/drm/amd/display/dc/core/dc_resource.c |  43 ++++
 drivers/gpu/drm/amd/display/dc/dc.h           |   3 +
 drivers/gpu/drm/amd/display/dc/dc_hw_types.h  |   1 +
 drivers/gpu/drm/amd/display/dc/dc_stream.h    |   3 +
 .../drm/amd/display/dc/dce/dce_clock_source.c |  52 +++-
 .../amd/display/dc/dcn10/dcn10_hw_sequencer.c | 225 ++++++++++++++++++
 .../amd/display/dc/dcn10/dcn10_hw_sequencer.h |   5 +
 .../gpu/drm/amd/display/dc/dcn10/dcn10_optc.h |   2 +
 .../display/dc/dcn10/dcn10_stream_encoder.c   |   1 -
 .../gpu/drm/amd/display/dc/dcn20/dcn20_init.c |   1 +
 .../gpu/drm/amd/display/dc/dcn20/dcn20_optc.c | 123 ++++++++++
 .../drm/amd/display/dc/dcn20/dcn20_resource.c |   8 +-
 .../dc/dcn30/dcn30_dio_stream_encoder.c       |   1 -
 .../gpu/drm/amd/display/dc/inc/clock_source.h |   5 +
 .../amd/display/dc/inc/hw/timing_generator.h  |  12 +
 .../gpu/drm/amd/display/dc/inc/hw_sequencer.h |   3 +
 drivers/gpu/drm/amd/display/dc/inc/resource.h |   4 +
 18 files changed, 505 insertions(+), 15 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc.c b/drivers/gpu/drm/amd=
/display/dc/core/dc.c
index 2f56fa2c0bf4..39df5d2c0108 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc.c
@@ -1102,6 +1102,7 @@ static void program_timing_sync(

        for (i =3D 0; i < pipe_count; i++) {
                int group_size =3D 1;
+               enum timing_synchronization_type sync_type =3D NOT_SYNCHRON=
IZABLE;
                struct pipe_ctx *pipe_set[MAX_PIPES];

                if (!unsynced_pipes[i])
@@ -1116,10 +1117,22 @@ static void program_timing_sync(
                for (j =3D i + 1; j < pipe_count; j++) {
                        if (!unsynced_pipes[j])
                                continue;
-
-                       if (resource_are_streams_timing_synchronizable(
+                       if (sync_type !=3D TIMING_SYNCHRONIZABLE &&
+                               dc->hwss.enable_vblanks_synchronization &&
+                               unsynced_pipes[j]->stream_res.tg->funcs->al=
ign_vblanks &&
+                               resource_are_vblanks_synchronizable(
+                                       unsynced_pipes[j]->stream,
+                                       pipe_set[0]->stream)) {
+                               sync_type =3D VBLANK_SYNCHRONIZABLE;
+                               pipe_set[group_size] =3D unsynced_pipes[j];
+                               unsynced_pipes[j] =3D NULL;
+                               group_size++;
+                       } else
+                       if (sync_type !=3D VBLANK_SYNCHRONIZABLE &&
+                               resource_are_streams_timing_synchronizable(
                                        unsynced_pipes[j]->stream,
                                        pipe_set[0]->stream)) {
+                               sync_type =3D TIMING_SYNCHRONIZABLE;
                                pipe_set[group_size] =3D unsynced_pipes[j];
                                unsynced_pipes[j] =3D NULL;
                                group_size++;
@@ -1145,7 +1158,6 @@ static void program_timing_sync(
                        }
                }

-
                for (k =3D 0; k < group_size; k++) {
                        struct dc_stream_status *status =3D dc_stream_get_s=
tatus_from_state(ctx, pipe_set[k]->stream);

@@ -1175,8 +1187,14 @@ static void program_timing_sync(
                }

                if (group_size > 1) {
-                       dc->hwss.enable_timing_synchronization(
-                               dc, group_index, group_size, pipe_set);
+                       if (sync_type =3D=3D TIMING_SYNCHRONIZABLE) {
+                               dc->hwss.enable_timing_synchronization(
+                                       dc, group_index, group_size, pipe_s=
et);
+                       } else
+                               if (sync_type =3D=3D VBLANK_SYNCHRONIZABLE)=
 {
+                               dc->hwss.enable_vblanks_synchronization(
+                                       dc, group_index, group_size, pipe_s=
et);
+                               }
                        group_index++;
                }
                num_group++;
diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_resource.c b/drivers/gp=
u/drm/amd/display/dc/core/dc_resource.c
index 0c26c2ade782..0241c9d96d7a 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_resource.c
@@ -417,6 +417,49 @@ int resource_get_clock_source_reference(
        return -1;
 }

+bool resource_are_vblanks_synchronizable(
+       struct dc_stream_state *stream1,
+       struct dc_stream_state *stream2)
+{
+       uint32_t base60_refresh_rates[] =3D {10, 20, 5};
+       uint8_t i;
+       uint8_t rr_count =3D sizeof(base60_refresh_rates)/sizeof(base60_ref=
resh_rates[0]);
+       int64_t frame_time_diff;
+
+       if (stream1->ctx->dc->config.vblank_alignment_dto_params &&
+               stream1->ctx->dc->config.vblank_alignment_max_frame_time_di=
ff > 0 &&
+               dc_is_dp_signal(stream1->signal) &&
+               dc_is_dp_signal(stream2->signal) &&
+               false =3D=3D stream1->has_non_synchronizable_pclk &&
+               false =3D=3D stream2->has_non_synchronizable_pclk &&
+               stream1->timing.flags.VBLANK_SYNCHRONIZABLE &&
+               stream2->timing.flags.VBLANK_SYNCHRONIZABLE) {
+               /* disable refresh rates higher than 60Hz for now */
+               if (stream1->timing.pix_clk_100hz*100/stream1->timing.h_tot=
al/
+                               stream1->timing.v_total > 60)
+                       return false;
+               if (stream2->timing.pix_clk_100hz*100/stream2->timing.h_tot=
al/
+                               stream2->timing.v_total > 60)
+                       return false;
+               frame_time_diff =3D (int64_t)10000 *
+                       stream1->timing.h_total *
+                       stream1->timing.v_total *
+                       stream2->timing.pix_clk_100hz /
+                       stream1->timing.pix_clk_100hz /
+                       stream2->timing.h_total /
+                       stream2->timing.v_total;
+               for (i =3D 0; i < rr_count; i++) {
+                       int64_t diff =3D (frame_time_diff * base60_refresh_=
rates[i]) / 10 - 10000;
+
+                       if (diff < 0)
+                               diff =3D -diff;
+                       if (diff < stream1->ctx->dc->config.vblank_alignmen=
t_max_frame_time_diff)
+                               return true;
+               }
+       }
+       return false;
+}
+
 bool resource_are_streams_timing_synchronizable(
        struct dc_stream_state *stream1,
        struct dc_stream_state *stream2)
diff --git a/drivers/gpu/drm/amd/display/dc/dc.h b/drivers/gpu/drm/amd/disp=
lay/dc/dc.h
index a10daf6655f9..9e631980fa1b 100644
--- a/drivers/gpu/drm/amd/display/dc/dc.h
+++ b/drivers/gpu/drm/amd/display/dc/dc.h
@@ -301,6 +301,8 @@ struct dc_config {
 #if defined(CONFIG_DRM_AMD_DC_DCN)
        bool clamp_min_dcfclk;
 #endif
+       uint64_t vblank_alignment_dto_params;
+       uint8_t  vblank_alignment_max_frame_time_diff;
 };

 enum visual_confirm {
@@ -528,6 +530,7 @@ struct dc_debug_options {
        bool disable_dsc;
        bool enable_dram_clock_change_one_display_vactive;
        union mem_low_power_enable_options enable_mem_low_power;
+       bool force_vblank_alignment;
 };

 struct dc_debug_data {
diff --git a/drivers/gpu/drm/amd/display/dc/dc_hw_types.h b/drivers/gpu/drm=
/amd/display/dc/dc_hw_types.h
index b41e6367b15e..48d3ed97ead9 100644
--- a/drivers/gpu/drm/amd/display/dc/dc_hw_types.h
+++ b/drivers/gpu/drm/amd/display/dc/dc_hw_types.h
@@ -705,6 +705,7 @@ struct dc_crtc_timing_flags {
 #ifndef TRIM_FSFT
        uint32_t FAST_TRANSPORT: 1;
 #endif
+       uint32_t VBLANK_SYNCHRONIZABLE: 1;
 };

 enum dc_timing_3d_format {
diff --git a/drivers/gpu/drm/amd/display/dc/dc_stream.h b/drivers/gpu/drm/a=
md/display/dc/dc_stream.h
index e243c01b9672..7fa998f97e7a 100644
--- a/drivers/gpu/drm/amd/display/dc/dc_stream.h
+++ b/drivers/gpu/drm/amd/display/dc/dc_stream.h
@@ -228,6 +228,9 @@ struct dc_stream_state {
        uint32_t stream_id;
        bool is_dsc_enabled;
        union stream_update_flags update_flags;
+
+       bool has_non_synchronizable_pclk;
+       bool vblank_synchronized;
 };

 #define ABM_LEVEL_IMMEDIATE_DISABLE 255
diff --git a/drivers/gpu/drm/amd/display/dc/dce/dce_clock_source.c b/driver=
s/gpu/drm/amd/display/dc/dce/dce_clock_source.c
index dec58b3c42e4..6f47f9bab5ee 100644
--- a/drivers/gpu/drm/amd/display/dc/dce/dce_clock_source.c
+++ b/drivers/gpu/drm/amd/display/dc/dce/dce_clock_source.c
@@ -1002,15 +1002,27 @@ static bool get_pixel_clk_frequency_100hz(
 {
        struct dce110_clk_src *clk_src =3D TO_DCE110_CLK_SRC(clock_source);
        unsigned int clock_hz =3D 0;
+       unsigned int modulo_hz =3D 0;

        if (clock_source->id =3D=3D CLOCK_SOURCE_ID_DP_DTO) {
                clock_hz =3D REG_READ(PHASE[inst]);

-               /* NOTE: There is agreement with VBIOS here that MODULO is
-                * programmed equal to DPREFCLK, in which case PHASE will b=
e
-                * equivalent to pixel clock.
-                */
-               *pixel_clk_khz =3D clock_hz / 100;
+               if (clock_source->ctx->dc->hwss.enable_vblanks_synchronizat=
ion &&
+                       clock_source->ctx->dc->config.vblank_alignment_max_=
frame_time_diff > 0) {
+                       /* NOTE: In case VBLANK syncronization is enabled, =
MODULO may
+                        * not be programmed equal to DPREFCLK
+                        */
+                       modulo_hz =3D REG_READ(MODULO[inst]);
+                       *pixel_clk_khz =3D ((uint64_t)clock_hz*
+                               clock_source->ctx->dc->clk_mgr->dprefclk_kh=
z*10)/
+                               modulo_hz;
+               } else {
+                       /* NOTE: There is agreement with VBIOS here that MO=
DULO is
+                        * programmed equal to DPREFCLK, in which case PHAS=
E will be
+                        * equivalent to pixel clock.
+                        */
+                       *pixel_clk_khz =3D clock_hz / 100;
+               }
                return true;
        }

@@ -1074,8 +1086,35 @@ static bool dcn20_program_pix_clk(
                struct pixel_clk_params *pix_clk_params,
                struct pll_settings *pll_settings)
 {
+       struct dce110_clk_src *clk_src =3D TO_DCE110_CLK_SRC(clock_source);
+       unsigned int inst =3D pix_clk_params->controller_id - CONTROLLER_ID=
_D0;
+
        dce112_program_pix_clk(clock_source, pix_clk_params, pll_settings);

+       if (clock_source->ctx->dc->hwss.enable_vblanks_synchronization &&
+                       clock_source->ctx->dc->config.vblank_alignment_max_=
frame_time_diff > 0) {
+               /* NOTE: In case VBLANK syncronization is enabled,
+                * we need to set modulo to default DPREFCLK first
+                * dce112_program_pix_clk does not set default DPREFCLK
+                */
+               REG_WRITE(MODULO[inst],
+                       clock_source->ctx->dc->clk_mgr->dprefclk_khz*1000);
+       }
+       return true;
+}
+
+static bool dcn20_override_dp_pix_clk(
+               struct clock_source *clock_source,
+               unsigned int inst,
+               unsigned int pixel_clk,
+               unsigned int ref_clk)
+{
+       struct dce110_clk_src *clk_src =3D TO_DCE110_CLK_SRC(clock_source);
+
+       REG_UPDATE(PIXEL_RATE_CNTL[inst], DP_DTO0_ENABLE, 0);
+       REG_WRITE(PHASE[inst], pixel_clk);
+       REG_WRITE(MODULO[inst], ref_clk);
+       REG_UPDATE(PIXEL_RATE_CNTL[inst], DP_DTO0_ENABLE, 1);
        return true;
 }

@@ -1083,7 +1122,8 @@ static const struct clock_source_funcs dcn20_clk_src_=
funcs =3D {
        .cs_power_down =3D dce110_clock_source_power_down,
        .program_pix_clk =3D dcn20_program_pix_clk,
        .get_pix_clk_dividers =3D dce112_get_pix_clk_dividers,
-       .get_pixel_clk_frequency_100hz =3D get_pixel_clk_frequency_100hz
+       .get_pixel_clk_frequency_100hz =3D get_pixel_clk_frequency_100hz,
+       .override_dp_pix_clk =3D dcn20_override_dp_pix_clk
 };

 #if defined(CONFIG_DRM_AMD_DC_DCN)
diff --git a/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hw_sequencer.c b/dr=
ivers/gpu/drm/amd/display/dc/dcn10/dcn10_hw_sequencer.c
index 89912bb5014f..669cee48b0b5 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hw_sequencer.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hw_sequencer.c
@@ -1851,6 +1851,225 @@ static bool wait_for_reset_trigger_to_occur(
        return rc;
 }

+uint64_t reduceSizeAndFraction(
+       uint64_t *numerator,
+       uint64_t *denominator,
+       bool checkUint32Bounary)
+{
+       int i;
+       bool ret =3D checkUint32Bounary =3D=3D false;
+       uint64_t max_int32 =3D 0xffffffff;
+       uint64_t num, denom;
+       uint16_t prime_numbers[] =3D {
+               2, 3, 5, 7, 11, 13, 17, 19, 23, 29, 31, 37, 41, 43,
+               47, 53, 59, 61, 67, 71, 73, 79, 83, 89, 97, 101, 103,
+               107, 109, 113, 127, 131, 137, 139, 149, 151, 157, 163,
+               167, 173, 179, 181, 191, 193, 197, 199, 211, 223, 227,
+               229, 233, 239, 241, 251, 257, 263, 269, 271, 277, 281,
+               283, 293, 307, 311, 313, 317, 331, 337, 347, 349, 353,
+               359, 367, 373, 379, 383, 389, 397, 401, 409, 419, 421,
+               431, 433, 439, 443, 449, 457, 461, 463, 467, 479, 487,
+               491, 499, 503, 509, 521, 523, 541, 547, 557, 563, 569,
+               571, 577, 587, 593, 599, 601, 607, 613, 617, 619, 631,
+               641, 643, 647, 653, 659, 661, 673, 677, 683, 691, 701,
+               709, 719, 727, 733, 739, 743, 751, 757, 761, 769, 773,
+               787, 797, 809, 811, 821, 823, 827, 829, 839, 853, 857,
+               859, 863, 877, 881, 883, 887, 907, 911, 919, 929, 937,
+               941, 947, 953, 967, 971, 977, 983, 991, 997};
+       int count =3D ARRAY_SIZE(prime_numbers)/sizeof(prime_numbers[0]);

ARRAY_SIZE gives the number of elements, so this will limit iteration to th=
e first half of the prime_numbers array. Btw, the array can be "static cons=
t".

BR
Nils

--_000_DM6PR12MB4267548CF8EE62D8AF138FD4F5819DM6PR12MB4267namp_
Content-Type: text/html; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

<html>
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Diso-8859-=
1">
<style type=3D"text/css" style=3D"display:none;"> P {margin-top:0;margin-bo=
ttom:0;} </style>
</head>
<body dir=3D"ltr">
<p style=3D"font-family:Arial;font-size:11pt;color:#0078D7;margin:5pt;" ali=
gn=3D"Left">
[AMD Official Use Only - Internal Distribution Only]<br>
</p>
<br>
<div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
<span style=3D"font-size: 11pt;">Hi&nbsp;</span><span style=3D"font-size: 1=
1pt;">Nils,</span><span style=3D"font-size: 11pt;">&#8203;</span></div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
&nbsp;&nbsp; <span style=3D"font-size: 11pt;">&#8203;Thanks for the inputs.=
 <br>
</span></div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
<span style=3D"font-size: 11pt;"><br>
</span></div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
<span style=3D"font-size: 11pt;"><a id=3D"OWAAM727992" class=3D"_1OtrSZdhKX=
Vv3UhaivrdJ4 mention ms-bgc-nlr ms-fcl-b" href=3D"mailto:Vladimir.Stempen@a=
md.com">@ Stempen, Vladimir</a>,</span></div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
<span style=3D"font-size: 11pt;">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<font =
size=3D"2"><span style=3D"font-size: 11pt;">&#8203; As the a</span><span st=
yle=3D"font-size: 11pt;">rray</span><span style=3D"font-size: 11pt;">
</span><font size=3D"2"><span style=3D"font-size:11pt">'prime_numbers</span=
></font><span style=3D"font-size: 11pt;">' has constant values defined, we =
can mark this as static const. Would you like to change the count calculati=
on -or- retain
</span><span style=3D"font-size:11pt"></span></font></span><span style=3D"f=
ont-size: 11pt;"></span>the same limit iteration ?
<span style=3D"font-size: 11pt;">All the patches would be merged to upstrea=
m by today. please suggest.
</span><br>
</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
<br>
</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
<span style=3D"font-size: 11pt;">Thanks,</span></div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
<span style=3D"font-size: 11pt;">Bindu </span><br>
</div>
<div id=3D"appendonsend"></div>
<hr style=3D"display:inline-block;width:98%" tabindex=3D"-1">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" st=
yle=3D"font-size:11pt" color=3D"#000000"><b>From:</b> Nils Wallm=E9nius &lt=
;nils.wallmenius@gmail.com&gt;<br>
<b>Sent:</b> Sunday, February 21, 2021 1:21 AM<br>
<b>To:</b> R, Bindu &lt;Bindu.R@amd.com&gt;<br>
<b>Cc:</b> amd-gfx@lists.freedesktop.org &lt;amd-gfx@lists.freedesktop.org&=
gt;; Stempen, Vladimir &lt;Vladimir.Stempen@amd.com&gt;; Brol, Eryk &lt;Ery=
k.Brol@amd.com&gt;; Li, Sun peng (Leo) &lt;Sunpeng.Li@amd.com&gt;; Wentland=
, Harry &lt;Harry.Wentland@amd.com&gt;; Zhuo, Qingqing &lt;Qingqing.Zhuo@am=
d.com&gt;;
 Siqueira, Rodrigo &lt;Rodrigo.Siqueira@amd.com&gt;; Jacob, Anson &lt;Anson=
.Jacob@amd.com&gt;; Pillai, Aurabindo &lt;Aurabindo.Pillai@amd.com&gt;; Lak=
ha, Bhawanpreet &lt;Bhawanpreet.Lakha@amd.com&gt;<br>
<b>Subject:</b> Re: [PATCH 08/13] drm/amd/display: Synchronize displays wit=
h different timings</font>
<div>&nbsp;</div>
</div>
<div>
<div dir=3D"auto">
<div>Hi Bindu, an inline comment below.<br>
<br>
<div class=3D"x_gmail_quote">
<div dir=3D"ltr" class=3D"x_gmail_attr">Den fre 19 feb. 2021 23:16Bindu Ram=
amurthy &lt;<a href=3D"mailto:bindu.r@amd.com">bindu.r@amd.com</a>&gt; skre=
v:<br>
</div>
<blockquote class=3D"x_gmail_quote" style=3D"margin:0 0 0 .8ex; border-left=
:1px #ccc solid; padding-left:1ex">
From: Vladimir Stempen &lt;<a href=3D"mailto:vladimir.stempen@amd.com" targ=
et=3D"_blank" rel=3D"noreferrer">vladimir.stempen@amd.com</a>&gt;<br>
<br>
[why]<br>
&nbsp;Vendor based fan noise improvement<br>
<br>
[how]<br>
Report timing synchronizable when DP streams time frame<br>
difference is less than 0.05 percent. Adjust DP&nbsp; DTOs and<br>
sync displays using&nbsp; MASTER_UPDATE_LOCK_DB_X_Y<br>
<br>
Signed-off-by: Vladimir Stempen &lt;<a href=3D"mailto:vladimir.stempen@amd.=
com" target=3D"_blank" rel=3D"noreferrer">vladimir.stempen@amd.com</a>&gt;<=
br>
Acked-by: Bindu Ramamurthy &lt;<a href=3D"mailto:bindu.r@amd.com" target=3D=
"_blank" rel=3D"noreferrer">bindu.r@amd.com</a>&gt;<br>
---<br>
&nbsp;drivers/gpu/drm/amd/display/dc/core/dc.c&nbsp; &nbsp; &nbsp; |&nbsp; =
28 ++-<br>
&nbsp;.../gpu/drm/amd/display/dc/core/dc_resource.c |&nbsp; 43 ++++<br>
&nbsp;drivers/gpu/drm/amd/display/dc/dc.h&nbsp; &nbsp; &nbsp; &nbsp; &nbsp;=
 &nbsp;|&nbsp; &nbsp;3 +<br>
&nbsp;drivers/gpu/drm/amd/display/dc/dc_hw_types.h&nbsp; |&nbsp; &nbsp;1 +<=
br>
&nbsp;drivers/gpu/drm/amd/display/dc/dc_stream.h&nbsp; &nbsp; |&nbsp; &nbsp=
;3 +<br>
&nbsp;.../drm/amd/display/dc/dce/dce_clock_source.c |&nbsp; 52 +++-<br>
&nbsp;.../amd/display/dc/dcn10/dcn10_hw_sequencer.c | 225 +++++++++++++++++=
+<br>
&nbsp;.../amd/display/dc/dcn10/dcn10_hw_sequencer.h |&nbsp; &nbsp;5 +<br>
&nbsp;.../gpu/drm/amd/display/dc/dcn10/dcn10_optc.h |&nbsp; &nbsp;2 +<br>
&nbsp;.../display/dc/dcn10/dcn10_stream_encoder.c&nbsp; &nbsp;|&nbsp; &nbsp=
;1 -<br>
&nbsp;.../gpu/drm/amd/display/dc/dcn20/dcn20_init.c |&nbsp; &nbsp;1 +<br>
&nbsp;.../gpu/drm/amd/display/dc/dcn20/dcn20_optc.c | 123 ++++++++++<br>
&nbsp;.../drm/amd/display/dc/dcn20/dcn20_resource.c |&nbsp; &nbsp;8 +-<br>
&nbsp;.../dc/dcn30/dcn30_dio_stream_encoder.c&nbsp; &nbsp; &nbsp; &nbsp;|&n=
bsp; &nbsp;1 -<br>
&nbsp;.../gpu/drm/amd/display/dc/inc/clock_source.h |&nbsp; &nbsp;5 +<br>
&nbsp;.../amd/display/dc/inc/hw/timing_generator.h&nbsp; |&nbsp; 12 +<br>
&nbsp;.../gpu/drm/amd/display/dc/inc/hw_sequencer.h |&nbsp; &nbsp;3 +<br>
&nbsp;drivers/gpu/drm/amd/display/dc/inc/resource.h |&nbsp; &nbsp;4 +<br>
&nbsp;18 files changed, 505 insertions(+), 15 deletions(-)<br>
<br>
diff --git a/drivers/gpu/drm/amd/display/dc/core/dc.c b/drivers/gpu/drm/amd=
/display/dc/core/dc.c<br>
index 2f56fa2c0bf4..39df5d2c0108 100644<br>
--- a/drivers/gpu/drm/amd/display/dc/core/dc.c<br>
+++ b/drivers/gpu/drm/amd/display/dc/core/dc.c<br>
@@ -1102,6 +1102,7 @@ static void program_timing_sync(<br>
<br>
&nbsp; &nbsp; &nbsp; &nbsp; for (i =3D 0; i &lt; pipe_count; i++) {<br>
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; int group_size =3D =
1;<br>
+&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;enum timing_synchro=
nization_type sync_type =3D NOT_SYNCHRONIZABLE;<br>
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; struct pipe_ctx *pi=
pe_set[MAX_PIPES];<br>
<br>
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; if (!unsynced_pipes=
[i])<br>
@@ -1116,10 +1117,22 @@ static void program_timing_sync(<br>
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; for (j =3D i + 1; j=
 &lt; pipe_count; j++) {<br>
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp=
; &nbsp; if (!unsynced_pipes[j])<br>
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp=
; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; continue;<br>
-<br>
-&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbs=
p; &nbsp;if (resource_are_streams_timing_synchronizable(<br>
+&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbs=
p; &nbsp;if (sync_type !=3D TIMING_SYNCHRONIZABLE &amp;&amp;<br>
+&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbs=
p; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;dc-&gt;hwss.enable_vblanks_synchroniza=
tion &amp;&amp;<br>
+&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbs=
p; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;unsynced_pipes[j]-&gt;stream_res.tg-&g=
t;funcs-&gt;align_vblanks &amp;&amp;<br>
+&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbs=
p; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;resource_are_vblanks_synchronizable(<b=
r>
+&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbs=
p; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;unsynced_p=
ipes[j]-&gt;stream,<br>
+&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbs=
p; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;pipe_set[0=
]-&gt;stream)) {<br>
+&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbs=
p; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;sync_type =3D VBLANK_SYNCHRONIZABLE;<b=
r>
+&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbs=
p; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;pipe_set[group_size] =3D unsynced_pipe=
s[j];<br>
+&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbs=
p; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;unsynced_pipes[j] =3D NULL;<br>
+&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbs=
p; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;group_size++;<br>
+&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbs=
p; &nbsp;} else<br>
+&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbs=
p; &nbsp;if (sync_type !=3D VBLANK_SYNCHRONIZABLE &amp;&amp;<br>
+&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbs=
p; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;resource_are_streams_timing_synchroniz=
able(<br>
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp=
; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; unsynced_p=
ipes[j]-&gt;stream,<br>
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp=
; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; pipe_set[0=
]-&gt;stream)) {<br>
+&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbs=
p; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;sync_type =3D TIMING_SYNCHRONIZABLE;<b=
r>
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp=
; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; pipe_set[group_size] =3D unsynced_pipe=
s[j];<br>
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp=
; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; unsynced_pipes[j] =3D NULL;<br>
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp=
; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; group_size++;<br>
@@ -1145,7 +1158,6 @@ static void program_timing_sync(<br>
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp=
; &nbsp; }<br>
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; }<br>
<br>
-<br>
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; for (k =3D 0; k &lt=
; group_size; k++) {<br>
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp=
; &nbsp; struct dc_stream_status *status =3D dc_stream_get_status_from_stat=
e(ctx, pipe_set[k]-&gt;stream);<br>
<br>
@@ -1175,8 +1187,14 @@ static void program_timing_sync(<br>
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; }<br>
<br>
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; if (group_size &gt;=
 1) {<br>
-&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbs=
p; &nbsp;dc-&gt;hwss.enable_timing_synchronization(<br>
-&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbs=
p; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;dc, group_index, group_size, pipe_set)=
;<br>
+&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbs=
p; &nbsp;if (sync_type =3D=3D TIMING_SYNCHRONIZABLE) {<br>
+&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbs=
p; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;dc-&gt;hwss.enable_timing_synchronizat=
ion(<br>
+&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbs=
p; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;dc, group_=
index, group_size, pipe_set);<br>
+&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbs=
p; &nbsp;} else<br>
+&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbs=
p; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;if (sync_type =3D=3D VBLANK_SYNCHRONIZ=
ABLE) {<br>
+&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbs=
p; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;dc-&gt;hwss.enable_vblanks_synchroniza=
tion(<br>
+&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbs=
p; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;dc, group_=
index, group_size, pipe_set);<br>
+&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbs=
p; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;}<br>
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp=
; &nbsp; group_index++;<br>
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; }<br>
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; num_group++;<br>
diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_resource.c b/drivers/gp=
u/drm/amd/display/dc/core/dc_resource.c<br>
index 0c26c2ade782..0241c9d96d7a 100644<br>
--- a/drivers/gpu/drm/amd/display/dc/core/dc_resource.c<br>
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_resource.c<br>
@@ -417,6 +417,49 @@ int resource_get_clock_source_reference(<br>
&nbsp; &nbsp; &nbsp; &nbsp; return -1;<br>
&nbsp;}<br>
<br>
+bool resource_are_vblanks_synchronizable(<br>
+&nbsp; &nbsp; &nbsp; &nbsp;struct dc_stream_state *stream1,<br>
+&nbsp; &nbsp; &nbsp; &nbsp;struct dc_stream_state *stream2)<br>
+{<br>
+&nbsp; &nbsp; &nbsp; &nbsp;uint32_t base60_refresh_rates[] =3D {10, 20, 5}=
;<br>
+&nbsp; &nbsp; &nbsp; &nbsp;uint8_t i;<br>
+&nbsp; &nbsp; &nbsp; &nbsp;uint8_t rr_count =3D sizeof(base60_refresh_rate=
s)/sizeof(base60_refresh_rates[0]);<br>
+&nbsp; &nbsp; &nbsp; &nbsp;int64_t frame_time_diff;<br>
+<br>
+&nbsp; &nbsp; &nbsp; &nbsp;if (stream1-&gt;ctx-&gt;dc-&gt;config.vblank_al=
ignment_dto_params &amp;&amp;<br>
+&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;stream1-&gt;ctx-&gt=
;dc-&gt;config.vblank_alignment_max_frame_time_diff &gt; 0 &amp;&amp;<br>
+&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;dc_is_dp_signal(str=
eam1-&gt;signal) &amp;&amp;<br>
+&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;dc_is_dp_signal(str=
eam2-&gt;signal) &amp;&amp;<br>
+&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;false =3D=3D stream=
1-&gt;has_non_synchronizable_pclk &amp;&amp;<br>
+&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;false =3D=3D stream=
2-&gt;has_non_synchronizable_pclk &amp;&amp;<br>
+&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;stream1-&gt;timing.=
flags.VBLANK_SYNCHRONIZABLE &amp;&amp;<br>
+&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;stream2-&gt;timing.=
flags.VBLANK_SYNCHRONIZABLE) {<br>
+&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;/* disable refresh =
rates higher than 60Hz for now */<br>
+&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;if (stream1-&gt;tim=
ing.pix_clk_100hz*100/stream1-&gt;timing.h_total/<br>
+&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbs=
p; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;stream1-&gt;timing.v_total &gt; 60)<br=
>
+&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbs=
p; &nbsp;return false;<br>
+&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;if (stream2-&gt;tim=
ing.pix_clk_100hz*100/stream2-&gt;timing.h_total/<br>
+&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbs=
p; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;stream2-&gt;timing.v_total &gt; 60)<br=
>
+&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbs=
p; &nbsp;return false;<br>
+&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;frame_time_diff =3D=
 (int64_t)10000 *<br>
+&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbs=
p; &nbsp;stream1-&gt;timing.h_total *<br>
+&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbs=
p; &nbsp;stream1-&gt;timing.v_total *<br>
+&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbs=
p; &nbsp;stream2-&gt;timing.pix_clk_100hz /<br>
+&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbs=
p; &nbsp;stream1-&gt;timing.pix_clk_100hz /<br>
+&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbs=
p; &nbsp;stream2-&gt;timing.h_total /<br>
+&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbs=
p; &nbsp;stream2-&gt;timing.v_total;<br>
+&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;for (i =3D 0; i &lt=
; rr_count; i++) {<br>
+&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbs=
p; &nbsp;int64_t diff =3D (frame_time_diff * base60_refresh_rates[i]) / 10 =
- 10000;<br>
+<br>
+&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbs=
p; &nbsp;if (diff &lt; 0)<br>
+&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbs=
p; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;diff =3D -diff;<br>
+&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbs=
p; &nbsp;if (diff &lt; stream1-&gt;ctx-&gt;dc-&gt;config.vblank_alignment_m=
ax_frame_time_diff)<br>
+&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbs=
p; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;return true;<br>
+&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;}<br>
+&nbsp; &nbsp; &nbsp; &nbsp;}<br>
+&nbsp; &nbsp; &nbsp; &nbsp;return false;<br>
+}<br>
+<br>
&nbsp;bool resource_are_streams_timing_synchronizable(<br>
&nbsp; &nbsp; &nbsp; &nbsp; struct dc_stream_state *stream1,<br>
&nbsp; &nbsp; &nbsp; &nbsp; struct dc_stream_state *stream2)<br>
diff --git a/drivers/gpu/drm/amd/display/dc/dc.h b/drivers/gpu/drm/amd/disp=
lay/dc/dc.h<br>
index a10daf6655f9..9e631980fa1b 100644<br>
--- a/drivers/gpu/drm/amd/display/dc/dc.h<br>
+++ b/drivers/gpu/drm/amd/display/dc/dc.h<br>
@@ -301,6 +301,8 @@ struct dc_config {<br>
&nbsp;#if defined(CONFIG_DRM_AMD_DC_DCN)<br>
&nbsp; &nbsp; &nbsp; &nbsp; bool clamp_min_dcfclk;<br>
&nbsp;#endif<br>
+&nbsp; &nbsp; &nbsp; &nbsp;uint64_t vblank_alignment_dto_params;<br>
+&nbsp; &nbsp; &nbsp; &nbsp;uint8_t&nbsp; vblank_alignment_max_frame_time_d=
iff;<br>
&nbsp;};<br>
<br>
&nbsp;enum visual_confirm {<br>
@@ -528,6 +530,7 @@ struct dc_debug_options {<br>
&nbsp; &nbsp; &nbsp; &nbsp; bool disable_dsc;<br>
&nbsp; &nbsp; &nbsp; &nbsp; bool enable_dram_clock_change_one_display_vacti=
ve;<br>
&nbsp; &nbsp; &nbsp; &nbsp; union mem_low_power_enable_options enable_mem_l=
ow_power;<br>
+&nbsp; &nbsp; &nbsp; &nbsp;bool force_vblank_alignment;<br>
&nbsp;};<br>
<br>
&nbsp;struct dc_debug_data {<br>
diff --git a/drivers/gpu/drm/amd/display/dc/dc_hw_types.h b/drivers/gpu/drm=
/amd/display/dc/dc_hw_types.h<br>
index b41e6367b15e..48d3ed97ead9 100644<br>
--- a/drivers/gpu/drm/amd/display/dc/dc_hw_types.h<br>
+++ b/drivers/gpu/drm/amd/display/dc/dc_hw_types.h<br>
@@ -705,6 +705,7 @@ struct dc_crtc_timing_flags {<br>
&nbsp;#ifndef TRIM_FSFT<br>
&nbsp; &nbsp; &nbsp; &nbsp; uint32_t FAST_TRANSPORT: 1;<br>
&nbsp;#endif<br>
+&nbsp; &nbsp; &nbsp; &nbsp;uint32_t VBLANK_SYNCHRONIZABLE: 1;<br>
&nbsp;};<br>
<br>
&nbsp;enum dc_timing_3d_format {<br>
diff --git a/drivers/gpu/drm/amd/display/dc/dc_stream.h b/drivers/gpu/drm/a=
md/display/dc/dc_stream.h<br>
index e243c01b9672..7fa998f97e7a 100644<br>
--- a/drivers/gpu/drm/amd/display/dc/dc_stream.h<br>
+++ b/drivers/gpu/drm/amd/display/dc/dc_stream.h<br>
@@ -228,6 +228,9 @@ struct dc_stream_state {<br>
&nbsp; &nbsp; &nbsp; &nbsp; uint32_t stream_id;<br>
&nbsp; &nbsp; &nbsp; &nbsp; bool is_dsc_enabled;<br>
&nbsp; &nbsp; &nbsp; &nbsp; union stream_update_flags update_flags;<br>
+<br>
+&nbsp; &nbsp; &nbsp; &nbsp;bool has_non_synchronizable_pclk;<br>
+&nbsp; &nbsp; &nbsp; &nbsp;bool vblank_synchronized;<br>
&nbsp;};<br>
<br>
&nbsp;#define ABM_LEVEL_IMMEDIATE_DISABLE 255<br>
diff --git a/drivers/gpu/drm/amd/display/dc/dce/dce_clock_source.c b/driver=
s/gpu/drm/amd/display/dc/dce/dce_clock_source.c<br>
index dec58b3c42e4..6f47f9bab5ee 100644<br>
--- a/drivers/gpu/drm/amd/display/dc/dce/dce_clock_source.c<br>
+++ b/drivers/gpu/drm/amd/display/dc/dce/dce_clock_source.c<br>
@@ -1002,15 +1002,27 @@ static bool get_pixel_clk_frequency_100hz(<br>
&nbsp;{<br>
&nbsp; &nbsp; &nbsp; &nbsp; struct dce110_clk_src *clk_src =3D TO_DCE110_CL=
K_SRC(clock_source);<br>
&nbsp; &nbsp; &nbsp; &nbsp; unsigned int clock_hz =3D 0;<br>
+&nbsp; &nbsp; &nbsp; &nbsp;unsigned int modulo_hz =3D 0;<br>
<br>
&nbsp; &nbsp; &nbsp; &nbsp; if (clock_source-&gt;id =3D=3D CLOCK_SOURCE_ID_=
DP_DTO) {<br>
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; clock_hz =3D REG_RE=
AD(PHASE[inst]);<br>
<br>
-&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;/* NOTE: There is a=
greement with VBIOS here that MODULO is<br>
-&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; * programmed equal=
 to DPREFCLK, in which case PHASE will be<br>
-&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; * equivalent to pi=
xel clock.<br>
-&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; */<br>
-&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;*pixel_clk_khz =3D =
clock_hz / 100;<br>
+&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;if (clock_source-&g=
t;ctx-&gt;dc-&gt;hwss.enable_vblanks_synchronization &amp;&amp;<br>
+&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbs=
p; &nbsp;clock_source-&gt;ctx-&gt;dc-&gt;config.vblank_alignment_max_frame_=
time_diff &gt; 0) {<br>
+&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbs=
p; &nbsp;/* NOTE: In case VBLANK syncronization is enabled, MODULO may<br>
+&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbs=
p; &nbsp; * not be programmed equal to DPREFCLK<br>
+&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbs=
p; &nbsp; */<br>
+&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbs=
p; &nbsp;modulo_hz =3D REG_READ(MODULO[inst]);<br>
+&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbs=
p; &nbsp;*pixel_clk_khz =3D ((uint64_t)clock_hz*<br>
+&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbs=
p; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;clock_source-&gt;ctx-&gt;dc-&gt;clk_mg=
r-&gt;dprefclk_khz*10)/<br>
+&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbs=
p; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;modulo_hz;<br>
+&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;} else {<br>
+&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbs=
p; &nbsp;/* NOTE: There is agreement with VBIOS here that MODULO is<br>
+&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbs=
p; &nbsp; * programmed equal to DPREFCLK, in which case PHASE will be<br>
+&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbs=
p; &nbsp; * equivalent to pixel clock.<br>
+&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbs=
p; &nbsp; */<br>
+&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbs=
p; &nbsp;*pixel_clk_khz =3D clock_hz / 100;<br>
+&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;}<br>
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; return true;<br>
&nbsp; &nbsp; &nbsp; &nbsp; }<br>
<br>
@@ -1074,8 +1086,35 @@ static bool dcn20_program_pix_clk(<br>
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; struct pixel_clk_pa=
rams *pix_clk_params,<br>
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; struct pll_settings=
 *pll_settings)<br>
&nbsp;{<br>
+&nbsp; &nbsp; &nbsp; &nbsp;struct dce110_clk_src *clk_src =3D TO_DCE110_CL=
K_SRC(clock_source);<br>
+&nbsp; &nbsp; &nbsp; &nbsp;unsigned int inst =3D pix_clk_params-&gt;contro=
ller_id - CONTROLLER_ID_D0;<br>
+<br>
&nbsp; &nbsp; &nbsp; &nbsp; dce112_program_pix_clk(clock_source, pix_clk_pa=
rams, pll_settings);<br>
<br>
+&nbsp; &nbsp; &nbsp; &nbsp;if (clock_source-&gt;ctx-&gt;dc-&gt;hwss.enable=
_vblanks_synchronization &amp;&amp;<br>
+&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbs=
p; &nbsp;clock_source-&gt;ctx-&gt;dc-&gt;config.vblank_alignment_max_frame_=
time_diff &gt; 0) {<br>
+&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;/* NOTE: In case VB=
LANK syncronization is enabled,<br>
+&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; * we need to set m=
odulo to default DPREFCLK first<br>
+&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; * dce112_program_p=
ix_clk does not set default DPREFCLK<br>
+&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; */<br>
+&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;REG_WRITE(MODULO[in=
st],<br>
+&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbs=
p; &nbsp;clock_source-&gt;ctx-&gt;dc-&gt;clk_mgr-&gt;dprefclk_khz*1000);<br=
>
+&nbsp; &nbsp; &nbsp; &nbsp;}<br>
+&nbsp; &nbsp; &nbsp; &nbsp;return true;<br>
+}<br>
+<br>
+static bool dcn20_override_dp_pix_clk(<br>
+&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;struct clock_source=
 *clock_source,<br>
+&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;unsigned int inst,<=
br>
+&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;unsigned int pixel_=
clk,<br>
+&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;unsigned int ref_cl=
k)<br>
+{<br>
+&nbsp; &nbsp; &nbsp; &nbsp;struct dce110_clk_src *clk_src =3D TO_DCE110_CL=
K_SRC(clock_source);<br>
+<br>
+&nbsp; &nbsp; &nbsp; &nbsp;REG_UPDATE(PIXEL_RATE_CNTL[inst], DP_DTO0_ENABL=
E, 0);<br>
+&nbsp; &nbsp; &nbsp; &nbsp;REG_WRITE(PHASE[inst], pixel_clk);<br>
+&nbsp; &nbsp; &nbsp; &nbsp;REG_WRITE(MODULO[inst], ref_clk);<br>
+&nbsp; &nbsp; &nbsp; &nbsp;REG_UPDATE(PIXEL_RATE_CNTL[inst], DP_DTO0_ENABL=
E, 1);<br>
&nbsp; &nbsp; &nbsp; &nbsp; return true;<br>
&nbsp;}<br>
<br>
@@ -1083,7 +1122,8 @@ static const struct clock_source_funcs dcn20_clk_src_=
funcs =3D {<br>
&nbsp; &nbsp; &nbsp; &nbsp; .cs_power_down =3D dce110_clock_source_power_do=
wn,<br>
&nbsp; &nbsp; &nbsp; &nbsp; .program_pix_clk =3D dcn20_program_pix_clk,<br>
&nbsp; &nbsp; &nbsp; &nbsp; .get_pix_clk_dividers =3D dce112_get_pix_clk_di=
viders,<br>
-&nbsp; &nbsp; &nbsp; &nbsp;.get_pixel_clk_frequency_100hz =3D get_pixel_cl=
k_frequency_100hz<br>
+&nbsp; &nbsp; &nbsp; &nbsp;.get_pixel_clk_frequency_100hz =3D get_pixel_cl=
k_frequency_100hz,<br>
+&nbsp; &nbsp; &nbsp; &nbsp;.override_dp_pix_clk =3D dcn20_override_dp_pix_=
clk<br>
&nbsp;};<br>
<br>
&nbsp;#if defined(CONFIG_DRM_AMD_DC_DCN)<br>
diff --git a/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hw_sequencer.c b/dr=
ivers/gpu/drm/amd/display/dc/dcn10/dcn10_hw_sequencer.c<br>
index 89912bb5014f..669cee48b0b5 100644<br>
--- a/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hw_sequencer.c<br>
+++ b/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hw_sequencer.c<br>
@@ -1851,6 +1851,225 @@ static bool wait_for_reset_trigger_to_occur(<br>
&nbsp; &nbsp; &nbsp; &nbsp; return rc;<br>
&nbsp;}<br>
<br>
+uint64_t reduceSizeAndFraction(<br>
+&nbsp; &nbsp; &nbsp; &nbsp;uint64_t *numerator,<br>
+&nbsp; &nbsp; &nbsp; &nbsp;uint64_t *denominator,<br>
+&nbsp; &nbsp; &nbsp; &nbsp;bool checkUint32Bounary)<br>
+{<br>
+&nbsp; &nbsp; &nbsp; &nbsp;int i;<br>
+&nbsp; &nbsp; &nbsp; &nbsp;bool ret =3D checkUint32Bounary =3D=3D false;<b=
r>
+&nbsp; &nbsp; &nbsp; &nbsp;uint64_t max_int32 =3D 0xffffffff;<br>
+&nbsp; &nbsp; &nbsp; &nbsp;uint64_t num, denom;<br>
+&nbsp; &nbsp; &nbsp; &nbsp;uint16_t prime_numbers[] =3D {<br>
+&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;2, 3, 5, 7, 11, 13,=
 17, 19, 23, 29, 31, 37, 41, 43,<br>
+&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;47, 53, 59, 61, 67,=
 71, 73, 79, 83, 89, 97, 101, 103,<br>
+&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;107, 109, 113, 127,=
 131, 137, 139, 149, 151, 157, 163,<br>
+&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;167, 173, 179, 181,=
 191, 193, 197, 199, 211, 223, 227,<br>
+&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;229, 233, 239, 241,=
 251, 257, 263, 269, 271, 277, 281,<br>
+&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;283, 293, 307, 311,=
 313, 317, 331, 337, 347, 349, 353,<br>
+&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;359, 367, 373, 379,=
 383, 389, 397, 401, 409, 419, 421,<br>
+&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;431, 433, 439, 443,=
 449, 457, 461, 463, 467, 479, 487,<br>
+&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;491, 499, 503, 509,=
 521, 523, 541, 547, 557, 563, 569,<br>
+&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;571, 577, 587, 593,=
 599, 601, 607, 613, 617, 619, 631,<br>
+&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;641, 643, 647, 653,=
 659, 661, 673, 677, 683, 691, 701,<br>
+&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;709, 719, 727, 733,=
 739, 743, 751, 757, 761, 769, 773,<br>
+&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;787, 797, 809, 811,=
 821, 823, 827, 829, 839, 853, 857,<br>
+&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;859, 863, 877, 881,=
 883, 887, 907, 911, 919, 929, 937,<br>
+&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;941, 947, 953, 967,=
 971, 977, 983, 991, 997};<br>
+&nbsp; &nbsp; &nbsp; &nbsp;int count =3D ARRAY_SIZE(prime_numbers)/sizeof(=
prime_numbers[0]);<br>
</blockquote>
</div>
</div>
<div dir=3D"auto"><br>
</div>
<div dir=3D"auto">ARRAY_SIZE gives the number of elements, so this will lim=
it iteration to the first half of the prime_numbers array. Btw, the array c=
an be &quot;static const&quot;.</div>
<div dir=3D"auto"><br>
</div>
<div dir=3D"auto">BR</div>
<div dir=3D"auto">Nils</div>
</div>
</div>
</div>
</body>
</html>

--_000_DM6PR12MB4267548CF8EE62D8AF138FD4F5819DM6PR12MB4267namp_--

--===============1640239883==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

--===============1640239883==--
