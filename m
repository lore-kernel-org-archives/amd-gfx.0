Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 01F53ECAAD1
	for <amd-gfx@archiver.kernel.org>; Wed, 31 Aug 2022 07:12:01 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BEE6B10E1FB;
	Wed, 31 Aug 2022 07:12:00 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2052.outbound.protection.outlook.com [40.107.237.52])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5B90F10E1FB
 for <amd-gfx@lists.freedesktop.org>; Wed, 31 Aug 2022 07:11:56 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ATVODaJ2feP4AREOqYoub64LnKy+aSCt1lW0ow5TApVsBU/RHbuPauV986w9HCibAQWbCypZJ1CqRFQ98uWlOwahxsnTndOS5f8b1yxiJ5CARbeXHZMVsbcdURXEfiELrTVkW4/HA63YYVJgiaZfqiM67HuQa1YovH1OxgAOkiQ+qz95AdUUDgv8nuSfeEDnUEDbHNSaL0cqF74WiVg6KvypG3bLizv0AgdcCZ/WLRm6gbcJUFmd0lEdbQqFE+TfC79J7XIw7vr1Lf4S30tEMoOXvEHevgt8xx3PCvKhffp8cBzwDjxhSebIxTfEsEqzFxCN2l61XJ5myGHZjdHAMg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qmP1hvIO+IA6r6hfz/vdxRXgz2/YatiD8S44Fa6Rl8o=;
 b=CvnNNUWzIMP2Zyk6of/whPNkKSLVBr9ct5AA3a7H8lTZk1zWZhWhl24TI2giM9QCPfub70BNWCfX/Zn6Kfp+2Tdb4SLwnJ0URgpMlRsZs9GwUDQXr3IUYZL7x8DtjSuzunDKNNWMwPD724dMg+GhyfupprSd0zyVotERTIFnKhRMQMXyEjKxr/PpfQ3s8ThHUv5wrsUPggB22P3UtB3dmQ+gaOwpodZAq94DE8+nqMXMpOpaAhI7c6NCGJDEfKMONrHoSapXwMv1KgUC14ev9IF0i6pHTfLVm3DpNb3/jpkhx3vvKGd4wIZlUDGe0s8FzeX7ndME4ZP4O5DrMbu0/Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qmP1hvIO+IA6r6hfz/vdxRXgz2/YatiD8S44Fa6Rl8o=;
 b=BbPmfKFGEi2fsB+XEmtEME+3ekLNtXCOhCYF8Tf/joUh5iijSvsgJ7G2rOAXztuYMbI/VcjE2d7GuUvq5XIBJFSjryWSWaLjPCscUyfYgUf8ZOvGJq1ddfmJSC29byc/B9WcTTgfeY3AoPqHFZwu2XXo7diK+/xVj/SCzbvGOQo=
Received: from DM5PR12MB2469.namprd12.prod.outlook.com (2603:10b6:4:af::38) by
 PH0PR12MB5404.namprd12.prod.outlook.com (2603:10b6:510:d7::14) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5566.15; Wed, 31 Aug 2022 07:11:54 +0000
Received: from DM5PR12MB2469.namprd12.prod.outlook.com
 ([fe80::bd9a:516b:ca81:3b46]) by DM5PR12MB2469.namprd12.prod.outlook.com
 ([fe80::bd9a:516b:ca81:3b46%7]) with mapi id 15.20.5588.010; Wed, 31 Aug 2022
 07:11:54 +0000
From: "Chen, Guchun" <Guchun.Chen@amd.com>
To: "Song, Asher" <Asher.Song@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>, "Wentland, Harry" <Harry.Wentland@amd.com>,
 "Pillai, Aurabindo" <Aurabindo.Pillai@amd.com>
Subject: RE: [PATCH] drm/amd/display: remove a duplicated declaration
Thread-Topic: [PATCH] drm/amd/display: remove a duplicated declaration
Thread-Index: AQHYvQPz3zYQdsmeBUSCbNyAUblXZ63IjkPA
Date: Wed, 31 Aug 2022 07:11:53 +0000
Message-ID: <DM5PR12MB24694CDC52A1469E56920AADF1789@DM5PR12MB2469.namprd12.prod.outlook.com>
References: <20220831063545.86428-1-Asher.Song@amd.com>
In-Reply-To: <20220831063545.86428-1-Asher.Song@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 923aef93-aad3-4949-7e26-08da8b201560
x-ms-traffictypediagnostic: PH0PR12MB5404:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: JT9zpZRGgVAab82RWhsomSL+p9BO6ak4olJ4ch1heWsmkWuZ9Ym+ctzRbSFcdls2XVzTwvFnvwbMq9sdb7O8RMyAFtpJ79+dxdE01SiIyZc1r83Elgkx43eit38/rrmySvOqO5b135BC60MITDrgoBoZrkdo+uD5XDW2Uqkesa2UnRJSSPZVtyjM7dxXdwcTrlhxCg5IoVG643DBINcVQLxo2CYHQ7GzP3f8jFYzhVVCoCRA7vEEy050VKo7Ui3siT+lpaD3GtWlvxTRiH16NllGPMVmREGf25A7/TgSvoLvsaR18ocwDa8DkQvjT+SRscL1F5M3DGucuMiyUdRNCEyJwqO/wDo4i0Uy0CJL6TMAdWgjDU9sBmjWGIBaUBGgYQlLFE6wmKMniDB/lqQZvAlLjGkISDIabSXwZkGYSjWnJnChGxusQmVsuZ10cLVgIMrYbDod8QFMvImYgdN/ETtcczUjkGWI5pO8GRla9MZVBSMh1lmTyOizwRE26ZGFlpJJakX7wt4CPUTRo8vKRIXEw74nUPE6N+Y4LNIH+pXkkZbWswYQRUVbukeD4eKVj0k8XkEAAFyL0DN1hJfx+1S2HbKZt0EhqDwqJn072h0ancAMtxSNpL9WGcM614Jrg4iQzUpdFndkd3NWT2wp3/p4PKeCKKkMiOenv1SovSItTnIxHPK1XLjJoD0XsR6NbP2pW3PmzaqKnYi4ggk7K61FlMGpbRXuje0rCEr6z/35uLxOlLaHSOH+LMXU8wCyLEnMmKnwItLbBdE/MkZSSA==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM5PR12MB2469.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230016)(4636009)(346002)(136003)(376002)(39860400002)(396003)(366004)(9686003)(86362001)(53546011)(26005)(38070700005)(71200400001)(7696005)(478600001)(6506007)(41300700001)(186003)(122000001)(38100700002)(55016003)(83380400001)(5660300002)(64756008)(66446008)(52536014)(110136005)(6636002)(66946007)(66476007)(66556008)(8936002)(54906003)(4326008)(8676002)(2906002)(316002)(33656002)(76116006);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?ilQYcGtedQoJaZyKBbUHtr0g+PMvdL5yypILGbxsUdUCryj061UuUnE90SXU?=
 =?us-ascii?Q?5mtWQ+p4XUCtHrQitDP3cIjOvFPcIpMsak8ZbIVoHKGtjFhvvH+PWL55WKw5?=
 =?us-ascii?Q?nc+9uj3L8caXDq9RiHBzYFKEql8rxjIopZ1e1GVnFeFmyZC3eK8NPJFEa6xq?=
 =?us-ascii?Q?gw3HMOPhta0JpVmQGatV2xJn47gbGUDG3kTN0IIPiaBhOI9l3JrpPMhii+Q/?=
 =?us-ascii?Q?Q5dSjtUtOwpDomNQQGT85GLGhBHvNeBXrssU0TX3/kp8x4fwoNrViWOsVnKm?=
 =?us-ascii?Q?7KvOZxskoBtImIMsVu7eqOw111zdaXXmCGTl+y7zSupQHpIbyaHQqzQ7dLo6?=
 =?us-ascii?Q?g0oQ36cUZtvjFuoHvqUy85A1GwkicdcrwrbEBkbq1hR5Hi1vE8WTsA672YX8?=
 =?us-ascii?Q?upeUGd8cJW3Q0LZyjAB1e23nR7X+aaUs7mtPnSOl6hC5UANgABlxt+RY9uDB?=
 =?us-ascii?Q?hISTG2sfbe55NeVOr2u7sCKdE9/6aYY2yFG6Mk7baqHwpc02MRouuS+wkAyC?=
 =?us-ascii?Q?l0Nkxdkn3ViMudt6HjuVLGozHl41H0TVH5DGOCyeDArjYUDNoGWhTjdlcHSA?=
 =?us-ascii?Q?el5dJLv0Yj4kMUQ8qEm2c6eBFU1Oa5TduHgBZB4oX1u/tscIY9GeTbbpZ91Q?=
 =?us-ascii?Q?GPqnidQ/vAFWZjfV8MKrm84xJp5QSQeLoXrls7xs5NqOclIK13iCiT4VKvnS?=
 =?us-ascii?Q?iBLv2HXiZcGWfJ9GezJwpq4f/bvyPX5Ja2u4ROc14x1j2ukyKS6RIvImamQ1?=
 =?us-ascii?Q?EB4u2aNSk91KE7Y70blCR24FTQBjTkUbMp/4t2bFvwNESsnXKr0R1NbBRzSw?=
 =?us-ascii?Q?numRQn46n2+ItvxwzFS6opUr2G2kcZVnoHltnl/MiXBSMciySWvOsZCWcrS4?=
 =?us-ascii?Q?H6tBgywAgAMdXt+zNPoimwhcui7Zs5ikjCQrShpH549hgh5RogzL4VutkHrw?=
 =?us-ascii?Q?5Jo80z0Xk3PGCCClmPs7T73N4i8ylUMWTG/Yjmp7GtNzNymqhDnWnpUzeiTb?=
 =?us-ascii?Q?u5GiY1CSE2j1BH9gvOcrvmh8jXj1bhwgkDLNrizy1mzvFWwIXL+8dZwu+lPa?=
 =?us-ascii?Q?Uhq7EvOrIJf9D+LPfFx51NVniYGkWbUP43FYeXJihKY16Mv3jWvCceCY/IfN?=
 =?us-ascii?Q?qi6ouickVoGiWrzvRAR5kG5TUI+X/qLNoSLY79qd+Yx8C6rT96b3KnVG0668?=
 =?us-ascii?Q?vh/PQAdnRR1+Mg43Pye6sCG/EoQkd2tlG2Dm8qzVhycMUTThjsmAXKQXkPOT?=
 =?us-ascii?Q?OZ/ZwNPakC1Nzs7MVrOwMXgQx1uuRlXWX2ijVHWl8xebQ/UegflmxClwUhbZ?=
 =?us-ascii?Q?yIwmIiW7PW0ILl7dH8NI4Frk76tXWrSm7tIKeCh1yYYw0tk5CJqLemnIACw6?=
 =?us-ascii?Q?M3kWegA+i8QbFBZpBSO3QClDhX5Ab0BLnvtpFmQEelwOMcvYimkA/As8z3e6?=
 =?us-ascii?Q?xb9BjpaULL8t8S5mXTd89uzP5+SQox+uHESodQVMVZp1Xh3MqA0Cqj6+y7ks?=
 =?us-ascii?Q?Hx26fFrJOjgXH4Ofqr4zJlsbEjhV1kuwQnEItnzSMYZN1O9Jy5C5ycTPCFV8?=
 =?us-ascii?Q?Jew2mW6Czv0cEdKvSKw4R7MSZMY00F/lqnJISZPt?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM5PR12MB2469.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 923aef93-aad3-4949-7e26-08da8b201560
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 Aug 2022 07:11:53.9737 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: tWenpBFLrps2yYsaJQ8dBgE2pVS05xWnHz3fyQbjJGOV2LFAkV5+FF0RHWYrz8GBkKfo0JO/c9YM9g2DuhWe3Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB5404
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
Cc: "Ma, Jun" <Jun.Ma2@amd.com>, "Cui, Flora" <Flora.Cui@amd.com>, "Shi,
 Leslie" <Yuliang.Shi@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

+Harry/Jay to comment if needed.

Reviewed-by: Guchun Chen <guchun.chen@amd.com>

Regards,
Guchun

-----Original Message-----
From: Song, Asher <Asher.Song@amd.com>=20
Sent: Wednesday, August 31, 2022 2:36 PM
To: amd-gfx@lists.freedesktop.org
Cc: Chen, Guchun <Guchun.Chen@amd.com>; Ma, Jun <Jun.Ma2@amd.com>; Cui, Flo=
ra <Flora.Cui@amd.com>; Shi, Leslie <Yuliang.Shi@amd.com>; Song, Asher <Ash=
er.Song@amd.com>
Subject: [PATCH] drm/amd/display: remove a duplicated declaration

There are duplicated declarations of i, remove one of those.

Signed-off-by: Asher Song <Asher.Song@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dml/dcn32/dcn32_fpu.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dml/dcn32/dcn32_fpu.c b/drivers=
/gpu/drm/amd/display/dc/dml/dcn32/dcn32_fpu.c
index 9f8976b18839..7f6c977c4981 100644
--- a/drivers/gpu/drm/amd/display/dc/dml/dcn32/dcn32_fpu.c
+++ b/drivers/gpu/drm/amd/display/dc/dml/dcn32/dcn32_fpu.c
@@ -1025,7 +1025,7 @@ static void dcn32_full_validate_bw_helper(struct dc *=
dc,
=20
 		dcn32_merge_pipes_for_subvp(dc, context);
 		// to re-initialize viewport after the pipe merge
-		for (int i =3D 0; i < dc->res_pool->pipe_count; i++) {
+		for (i =3D 0; i < dc->res_pool->pipe_count; i++) {
 			struct pipe_ctx *pipe_ctx =3D &context->res_ctx.pipe_ctx[i];
=20
 			if (!pipe_ctx->plane_state || !pipe_ctx->stream)
--=20
2.25.1

