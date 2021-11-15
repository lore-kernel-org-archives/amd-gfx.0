Return-Path: <SRS0=ctnh=QC=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06037C433EF
	for <amd-gfx@archiver.kernel.org>; Mon, 15 Nov 2021 20:04:32 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B8A1B61B73
	for <amd-gfx@archiver.kernel.org>; Mon, 15 Nov 2021 20:04:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org B8A1B61B73
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 715C86E0C5;
	Mon, 15 Nov 2021 20:04:31 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2065.outbound.protection.outlook.com [40.107.237.65])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EE3456E0C5
 for <amd-gfx@lists.freedesktop.org>; Mon, 15 Nov 2021 20:04:29 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=A4P9zIGXNNkTWPbENeBktLxsMIiI1RFjoF+vCaDmYhfmIpN0js4H1ty9316DKsHA8DyrGsd5NMYnB0KI8aTEYMCkA6iwVse4R6TUePathht67LwsRMZiP13hhDcdoKJUCjGatDei3EUty/KRzsL0qTXGFrvkBpvPbfE+Ahql9qP9c2343Y4GXnjrJx4YTj76+uOvmPsW098OYXRA2Hem8k+qF69xCkhH8imupk9NDxDQeSsD7mAWQN3cCyQRkdXeojnZwn0VAXNac8gvEtFCJagYUq1XtoFZFXP42Cy0llWQXMNMoghQm69yhetzjg4qLTTEHf5GRWowDvDAeynl2g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0cQgG9vvrmkK9xQAzcwloTVWtA9xTCQYdfoa7L6qB8c=;
 b=INc3zVpcUSeOqz0lw/2CwYwytf3PqdPvtLck0QDJ19DiuVKAkOGpTl9bhBLwGPxtR29B29hcnuLwHoMl8tLVnso3sp0waUsSSAJyWU6BMhnTV5atRqWCEObT17xQgpsGUf2BAmg0P2KPLNij1vcJmZZyFLukNn47WD3qdunRQwmzu7VecudRXWza1Ojn6o9n0YGoAhHxplMFu678pwetLh4Wxk5fzTer+g86zK4ARs1JxzxQizn3kHvynpk+bzL8A2lE4/vw3IQgd4ae+iuWeLC9ZY/OPLNemPUUsXsiRl/ZosVvkudZbi2SWJfMliyKcpyiZnO+wN6COSCVC6lPgA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0cQgG9vvrmkK9xQAzcwloTVWtA9xTCQYdfoa7L6qB8c=;
 b=PCPRg1lbz9MjktEFUCAuWs61bkMwiYMO+HQ7Ik3MI2kndp34LDAzepYCqeqTUwVvKHQ2sL42ZDrp+8ptXRF+ieKqykYUziEHgOytTfpl4i6nn2ajpt+uLqVi3jXaJWYCN8NWO1eFF05rWD84y+RDz4mnHTyAQt9s4LwDIF/dSDw=
Received: from MW3PR12MB4554.namprd12.prod.outlook.com (2603:10b6:303:55::21)
 by MWHPR1201MB0206.namprd12.prod.outlook.com (2603:10b6:301:55::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4690.27; Mon, 15 Nov
 2021 20:04:27 +0000
Received: from MW3PR12MB4554.namprd12.prod.outlook.com
 ([fe80::7810:8aa4:1337:6820]) by MW3PR12MB4554.namprd12.prod.outlook.com
 ([fe80::7810:8aa4:1337:6820%7]) with mapi id 15.20.4690.027; Mon, 15 Nov 2021
 20:04:27 +0000
From: "Lakha, Bhawanpreet" <Bhawanpreet.Lakha@amd.com>
To: "Pillai, Aurabindo" <Aurabindo.Pillai@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Subject: Re: [PATCH] drm/amd/display: Fix LTTPR not Enabled on HP ZBook G8
 laptop
Thread-Topic: [PATCH] drm/amd/display: Fix LTTPR not Enabled on HP ZBook G8
 laptop
Thread-Index: AQHX2ltDb8znoSh8rU+K+Zg+VwvIyqwFAx7n
Date: Mon, 15 Nov 2021 20:04:27 +0000
Message-ID: <MW3PR12MB455464EF8ACAF3558479D8FFF9989@MW3PR12MB4554.namprd12.prod.outlook.com>
References: <20211115195906.822218-1-aurabindo.pillai@amd.com>
In-Reply-To: <20211115195906.822218-1-aurabindo.pillai@amd.com>
Accept-Language: en-CA, en-US
Content-Language: en-CA
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Enabled=True;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SetDate=2021-11-15T20:04:26.987Z;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Name=AMD
 Official Use
 Only; MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ContentBits=0;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Method=Standard; 
suggested_attachment_session_id: c92cbfa5-361a-01c7-3e97-a6e13cb71886
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 9a41c0ce-81b2-4cf2-03f3-08d9a87320df
x-ms-traffictypediagnostic: MWHPR1201MB0206:
x-microsoft-antispam-prvs: <MWHPR1201MB0206A258D4BC381581494AB1F9989@MWHPR1201MB0206.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:1775;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: jodz6DDzKt7fnizInnofPVtub5I6Kk75G64uMb0ZJ10PYMyPAv+9RPJnAF70a+6piGfa1/fUm3KIwkRdPrSdmKFdGMWpBIfTQHF0qd0/T82Sld8B9k3FNDkRH6RoruhAdfXsJW2yOVbvUMjHkpvrgdxJ4RLiJ3iIAKDEw51LXEhazT+0FepRPeu4370KmTbfv4cUDNI7UEWhvg6QijIFHjDHoZ9dVQ38XejxiHpyRapi4c8EzGJ1eGoxuX/nJ6Djd6k66dzXld4iQy8oAkNIOsPNRPwDYpiDM85Pu28TLEq28aEigPRj4FTSQXAuN/2A3hRbfQkSXUldBBtZCHfBkFMxPdQUfvRI86iJBPTmIHlliSg30kquNfy2vz375wq6IofMW1Ck5IjgSRwKwgaeLXx7bWdNkT6R+8A65vmEvvFQTVaGEAR9Dq5zQfKC0WPbfN3ECayH9wU7Tdn/IMOeDMjv91L4CHOVwWbZghVhMAxUgu0ij9sVLy/Ejg9nNJyio2JB61FZPRTiQhqt31pjzRbYD7j/v4nASGWFs/itT5GpfuDnHhtb7bZ7r1KJIuHW87MM37UrOSipROZEeveUhWOb9cSW6jLcIbtWyn0TRkbiUe53VhmGiOXW/OzJOvNbFgG8C1PMlivByU8sUvKflzbGUJ62QpymqGNb7MlLptcTtSQ271l2S94GuHKFw6H/tPOafOmQw7IyA5oKqV1aAEAeAmYL5y13neUUoECV4K8=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MW3PR12MB4554.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(508600001)(55016002)(19627405001)(6506007)(53546011)(71200400001)(91956017)(110136005)(83380400001)(8936002)(2906002)(76116006)(38070700005)(122000001)(4326008)(54906003)(33656002)(8676002)(38100700002)(316002)(66446008)(52536014)(7696005)(66946007)(66476007)(64756008)(9686003)(66556008)(186003)(5660300002)(86362001)(309714004);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?h+S8D807xd7+pMWx+K2K68kewHQ52QmV5Xaj3RjWhzGZLXvFQtu3M6kzPMvg?=
 =?us-ascii?Q?pQXp8HtbjcMu25VmRM8erLR3okx8eS7vQBtH58Z6Acf1R1q9nK13QVD5YBcG?=
 =?us-ascii?Q?h6siolzPjMtS2yNAs9m53iuP4u8t5QJYqiCViuioJa+Rd+BC6lVPQkk53MSP?=
 =?us-ascii?Q?RCAY+UsT6B59B0SkFe2iZZ/o5rbafa8/EuzHc2faupam6htoviLXZsguOsWQ?=
 =?us-ascii?Q?S0iYbiZx/S2uQ7yhKhl1nRvpvspZKrTNjgNuJiD/DfUAE0j9pc6ubmboDCkg?=
 =?us-ascii?Q?RZRVZU+jfWhmPgp1SU8MOsagQM/4FKk+eplWETxa/LOjDCJj/0IonBvAgKvi?=
 =?us-ascii?Q?3M5q0wzPkd/NGhWyegABJMaJBnNxgukmr4g43HYcfKNrv+Jwvway+vlWNsfT?=
 =?us-ascii?Q?QNIsVlC3oQ+2+R39iu7nIUwjE4QKGizQUKLoaZb5KzM3kXmwKSPy40J+XEaO?=
 =?us-ascii?Q?MV69CUikKNXYQ4jHFm5CN86nF7WhWku234vZhwjAzyfOIP4acSYs4GWHwqWK?=
 =?us-ascii?Q?h/k7wcy1575/HuKqoCoEC4mRFy7rWK8xWNRa+PdY7LgzeBLqaSF/Z60tAOt2?=
 =?us-ascii?Q?55Ms5RJOigGXfbVnS93dBYaa8A4xI816B6B0XyYXMfiE9nTA+KJJLzvDjfFL?=
 =?us-ascii?Q?PUJaCfZMyPRr6Qexeiw/dY9o30ufb+jYxe+SH/eejk80dDcULoLDbY040QVH?=
 =?us-ascii?Q?6buDKz/DirFUt6SL1v0xpZQAE4xTZKn0glgsglQdAmc0F7gjabZyxLx/BYBu?=
 =?us-ascii?Q?foBzK5wB0C9uWMjEG2224wLKNhLKJJbkbEtJnqT2006/e2WTwxC7Od6TGmZI?=
 =?us-ascii?Q?m+r+Oceju+GIDXAC3sw1FipnAaMiLfOcDIKclP3HRcrbRrdA1k1Gq/eBvfUd?=
 =?us-ascii?Q?Q4sYmruGjebXEcfih9eN2fLEnm5d3SEID1Nn53EIMn721dWlJDzpUpUtwyeU?=
 =?us-ascii?Q?B/legLHW8RE6PvGoHi429BAHOsGhwxiDgwroyrV0g4oXGBoQk1cLWK3m/i5w?=
 =?us-ascii?Q?tje8nSXSunxO7XFZa1rIi0cZkDAYWoty2EkacO0aXaddskK0wuleKyj3u2EZ?=
 =?us-ascii?Q?zcqfZazhVR0Gx7iFVIryK3GRWGKAXnNoxvGTu2tM8LLWpDNTghc9ekyzbTCu?=
 =?us-ascii?Q?GWgGK89jDmcAMpSzj5SLsPPg6tQQRX4hjkfSMkhqzlWvQKXOH7hY+W41uWJm?=
 =?us-ascii?Q?oEMJk54B7SC6cXGF2v1LDgXxxUqwQdWEiS6bfuInV2VqgFzUQU+RJjburYMK?=
 =?us-ascii?Q?drWNQTIo5Vh9uZyJ6qzIb6oGkA8qfkeVBSxTdYhxZtCCJEA4sJiz4576/4jB?=
 =?us-ascii?Q?BSw42Hpa5hxS039uj9EJ3+fMrHllvnIXWxZOC1qXy1q9Jkq2+yFs5mdLTuRE?=
 =?us-ascii?Q?RkaE7B+yMzcPDE9nzNRNXElefe5loQ/fU4DuQIlSVtNiQr5JXg6L3/AN4Axk?=
 =?us-ascii?Q?gEzJc3H9kFZDzJb2DeOQJiUEPm+KKScqg67ugMWn11cmt1rTdGRNqv0MJkbu?=
 =?us-ascii?Q?ZNtrpeRhTw8pFivDY2gff5VTI4j6c7MJiOv94UvJ0SetsZzddX5ckF0u4vXF?=
 =?us-ascii?Q?Vy8BBYrQlAreEpLYbTkoJDHHBLAM0pZSaX1jiumt?=
Content-Type: multipart/alternative;
 boundary="_000_MW3PR12MB455464EF8ACAF3558479D8FFF9989MW3PR12MB4554namp_"
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW3PR12MB4554.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9a41c0ce-81b2-4cf2-03f3-08d9a87320df
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Nov 2021 20:04:27.4583 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 7iqYvUZyImMId2krCTMBQlh47J8TEGIAQiIeNpbvvYeOsNT4wTaW/aZNWXwmCp7Z
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR1201MB0206
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
Cc: "Zhuo, Qingqing" <Qingqing.Zhuo@amd.com>, "Siqueira,
 Rodrigo" <Rodrigo.Siqueira@amd.com>, "Chalmers,
 Wesley" <Wesley.Chalmers@amd.com>, "Wang, Angus" <Angus.Wang@amd.com>, "Leung,
 Martin" <Martin.Leung@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--_000_MW3PR12MB455464EF8ACAF3558479D8FFF9989MW3PR12MB4554namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

[AMD Official Use Only]

Reviewed-by: Bhawanpreet Lakha <Bhawanpreet.Lakha@amd.com>
________________________________
From: Aurabindo Pillai <aurabindo.pillai@amd.com>
Sent: November 15, 2021 2:59 PM
To: amd-gfx@lists.freedesktop.org <amd-gfx@lists.freedesktop.org>
Cc: Lakha, Bhawanpreet <Bhawanpreet.Lakha@amd.com>; Siqueira, Rodrigo <Rodr=
igo.Siqueira@amd.com>; Pillai, Aurabindo <Aurabindo.Pillai@amd.com>; Wang, =
Angus <Angus.Wang@amd.com>; Chalmers, Wesley <Wesley.Chalmers@amd.com>; Leu=
ng, Martin <Martin.Leung@amd.com>; Zhuo, Qingqing <Qingqing.Zhuo@amd.com>
Subject: [PATCH] drm/amd/display: Fix LTTPR not Enabled on HP ZBook G8 lapt=
op

From: Angus Wang <angus.wang@amd.com>

[WHY]
Previous LTTPR change has caused a regression that led to an
issue where LTTPR is disabled

[HOW]
Extended changes from previous fix to DCN30X

Reviewed-by: Wesley Chalmers <wesley.chalmers@amd.com>
Reviewed-by: Martin Leung <Martin.Leung@amd.com>
Acked-by: Qingqing Zhuo <qingqing.zhuo@amd.com>
Signed-off-by: Angus Wang <angus.wang@amd.com>
---
 .../amd/display/dc/dcn301/dcn301_resource.c    | 18 ++++++++++++++++++
 .../amd/display/dc/dcn302/dcn302_resource.c    | 18 ++++++++++++++++++
 .../amd/display/dc/dcn303/dcn303_resource.c    | 17 +++++++++++++++++
 3 files changed, 53 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/dc/dcn301/dcn301_resource.c b/driv=
ers/gpu/drm/amd/display/dc/dcn301/dcn301_resource.c
index 2650d3bd50ec..9cc1610360bd 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn301/dcn301_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn301/dcn301_resource.c
@@ -1485,6 +1485,24 @@ static bool dcn301_resource_construct(
         dc->caps.color.mpc.ogam_rom_caps.hlg =3D 0;
         dc->caps.color.mpc.ocsc =3D 1;

+       /* read VBIOS LTTPR caps */
+
+       if (ctx->dc_bios->funcs->get_lttpr_caps) {
+               enum bp_result bp_query_result;
+               uint8_t is_vbios_lttpr_enable =3D 0;
+
+               bp_query_result =3D ctx->dc_bios->funcs->get_lttpr_caps(ctx=
->dc_bios, &is_vbios_lttpr_enable);
+               dc->caps.vbios_lttpr_enable =3D (bp_query_result =3D=3D BP_=
RESULT_OK) && !!is_vbios_lttpr_enable;
+       }
+
+       if (ctx->dc_bios->funcs->get_lttpr_interop) {
+               enum bp_result bp_query_result;
+               uint8_t is_vbios_interop_enabled =3D 0;
+
+               bp_query_result =3D ctx->dc_bios->funcs->get_lttpr_interop(=
ctx->dc_bios, &is_vbios_interop_enabled);
+               dc->caps.vbios_lttpr_aware =3D (bp_query_result =3D=3D BP_R=
ESULT_OK) && !!is_vbios_interop_enabled;
+       }
+
         if (dc->ctx->dce_environment =3D=3D DCE_ENV_PRODUCTION_DRV)
                 dc->debug =3D debug_defaults_drv;
         else if (dc->ctx->dce_environment =3D=3D DCE_ENV_FPGA_MAXIMUS) {
diff --git a/drivers/gpu/drm/amd/display/dc/dcn302/dcn302_resource.c b/driv=
ers/gpu/drm/amd/display/dc/dcn302/dcn302_resource.c
index fcf96cf08c76..058f5d71e037 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn302/dcn302_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn302/dcn302_resource.c
@@ -1557,6 +1557,24 @@ static bool dcn302_resource_construct(
         dc->caps.color.mpc.ogam_rom_caps.hlg =3D 0;
         dc->caps.color.mpc.ocsc =3D 1;

+       /* read VBIOS LTTPR caps */
+       if (ctx->dc_bios->funcs->get_lttpr_caps) {
+               enum bp_result bp_query_result;
+               uint8_t is_vbios_lttpr_enable =3D 0;
+
+               bp_query_result =3D ctx->dc_bios->funcs->get_lttpr_caps(ctx=
->dc_bios, &is_vbios_lttpr_enable);
+               dc->caps.vbios_lttpr_enable =3D (bp_query_result =3D=3D BP_=
RESULT_OK) && !!is_vbios_lttpr_enable;
+       }
+
+       if (ctx->dc_bios->funcs->get_lttpr_interop) {
+               enum bp_result bp_query_result;
+               uint8_t is_vbios_interop_enabled =3D 0;
+
+               bp_query_result =3D ctx->dc_bios->funcs->get_lttpr_interop(=
ctx->dc_bios,
+                               &is_vbios_interop_enabled);
+               dc->caps.vbios_lttpr_aware =3D (bp_query_result =3D=3D BP_R=
ESULT_OK) && !!is_vbios_interop_enabled;
+       }
+
         if (dc->ctx->dce_environment =3D=3D DCE_ENV_PRODUCTION_DRV)
                 dc->debug =3D debug_defaults_drv;
         else
diff --git a/drivers/gpu/drm/amd/display/dc/dcn303/dcn303_resource.c b/driv=
ers/gpu/drm/amd/display/dc/dcn303/dcn303_resource.c
index 4a9b64023675..7024aeb0884c 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn303/dcn303_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn303/dcn303_resource.c
@@ -1500,6 +1500,23 @@ static bool dcn303_resource_construct(
         dc->caps.color.mpc.ogam_rom_caps.hlg =3D 0;
         dc->caps.color.mpc.ocsc =3D 1;

+       /* read VBIOS LTTPR caps */
+       if (ctx->dc_bios->funcs->get_lttpr_caps) {
+               enum bp_result bp_query_result;
+               uint8_t is_vbios_lttpr_enable =3D 0;
+
+               bp_query_result =3D ctx->dc_bios->funcs->get_lttpr_caps(ctx=
->dc_bios, &is_vbios_lttpr_enable);
+               dc->caps.vbios_lttpr_enable =3D (bp_query_result =3D=3D BP_=
RESULT_OK) && !!is_vbios_lttpr_enable;
+       }
+
+       if (ctx->dc_bios->funcs->get_lttpr_interop) {
+               enum bp_result bp_query_result;
+               uint8_t is_vbios_interop_enabled =3D 0;
+
+               bp_query_result =3D ctx->dc_bios->funcs->get_lttpr_interop(=
ctx->dc_bios, &is_vbios_interop_enabled);
+               dc->caps.vbios_lttpr_aware =3D (bp_query_result =3D=3D BP_R=
ESULT_OK) && !!is_vbios_interop_enabled;
+       }
+
         if (dc->ctx->dce_environment =3D=3D DCE_ENV_PRODUCTION_DRV)
                 dc->debug =3D debug_defaults_drv;
         else
--
2.30.2


--_000_MW3PR12MB455464EF8ACAF3558479D8FFF9989MW3PR12MB4554namp_
Content-Type: text/html; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<html>
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Dus-ascii"=
>
<style type=3D"text/css" style=3D"display:none;"> P {margin-top:0;margin-bo=
ttom:0;} </style>
</head>
<body dir=3D"ltr">
<p style=3D"font-family:Arial;font-size:10pt;color:#0000FF;margin:5pt;" ali=
gn=3D"Left">
[AMD Official Use Only]<br>
</p>
<br>
<div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
Reviewed-by: Bhawanpreet Lakha &lt;Bhawanpreet.Lakha@amd.com&gt;<br>
</div>
<div id=3D"appendonsend"></div>
<hr style=3D"display:inline-block;width:98%" tabindex=3D"-1">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" st=
yle=3D"font-size:11pt" color=3D"#000000"><b>From:</b> Aurabindo Pillai &lt;=
aurabindo.pillai@amd.com&gt;<br>
<b>Sent:</b> November 15, 2021 2:59 PM<br>
<b>To:</b> amd-gfx@lists.freedesktop.org &lt;amd-gfx@lists.freedesktop.org&=
gt;<br>
<b>Cc:</b> Lakha, Bhawanpreet &lt;Bhawanpreet.Lakha@amd.com&gt;; Siqueira, =
Rodrigo &lt;Rodrigo.Siqueira@amd.com&gt;; Pillai, Aurabindo &lt;Aurabindo.P=
illai@amd.com&gt;; Wang, Angus &lt;Angus.Wang@amd.com&gt;; Chalmers, Wesley=
 &lt;Wesley.Chalmers@amd.com&gt;; Leung, Martin &lt;Martin.Leung@amd.com&gt=
;;
 Zhuo, Qingqing &lt;Qingqing.Zhuo@amd.com&gt;<br>
<b>Subject:</b> [PATCH] drm/amd/display: Fix LTTPR not Enabled on HP ZBook =
G8 laptop</font>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt;=
">
<div class=3D"PlainText">From: Angus Wang &lt;angus.wang@amd.com&gt;<br>
<br>
[WHY]<br>
Previous LTTPR change has caused a regression that led to an<br>
issue where LTTPR is disabled<br>
<br>
[HOW]<br>
Extended changes from previous fix to DCN30X<br>
<br>
Reviewed-by: Wesley Chalmers &lt;wesley.chalmers@amd.com&gt;<br>
Reviewed-by: Martin Leung &lt;Martin.Leung@amd.com&gt;<br>
Acked-by: Qingqing Zhuo &lt;qingqing.zhuo@amd.com&gt;<br>
Signed-off-by: Angus Wang &lt;angus.wang@amd.com&gt;<br>
---<br>
&nbsp;.../amd/display/dc/dcn301/dcn301_resource.c&nbsp;&nbsp;&nbsp; | 18 ++=
++++++++++++++++<br>
&nbsp;.../amd/display/dc/dcn302/dcn302_resource.c&nbsp;&nbsp;&nbsp; | 18 ++=
++++++++++++++++<br>
&nbsp;.../amd/display/dc/dcn303/dcn303_resource.c&nbsp;&nbsp;&nbsp; | 17 ++=
+++++++++++++++<br>
&nbsp;3 files changed, 53 insertions(+)<br>
<br>
diff --git a/drivers/gpu/drm/amd/display/dc/dcn301/dcn301_resource.c b/driv=
ers/gpu/drm/amd/display/dc/dcn301/dcn301_resource.c<br>
index 2650d3bd50ec..9cc1610360bd 100644<br>
--- a/drivers/gpu/drm/amd/display/dc/dcn301/dcn301_resource.c<br>
+++ b/drivers/gpu/drm/amd/display/dc/dcn301/dcn301_resource.c<br>
@@ -1485,6 +1485,24 @@ static bool dcn301_resource_construct(<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dc-&gt;caps.color.mpc.ogam=
_rom_caps.hlg =3D 0;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dc-&gt;caps.color.mpc.ocsc=
 =3D 1;<br>
&nbsp;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* read VBIOS LTTPR caps */<br>
+<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (ctx-&gt;dc_bios-&gt;funcs-&gt;get=
_lttpr_caps) {<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; enum bp_result bp_query_result;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; uint8_t is_vbios_lttpr_enable =3D 0;<br>
+<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; bp_query_result =3D ctx-&gt;dc_bios-&gt;funcs-&gt;get_lttpr_caps=
(ctx-&gt;dc_bios, &amp;is_vbios_lttpr_enable);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; dc-&gt;caps.vbios_lttpr_enable =3D (bp_query_result =3D=3D BP_RE=
SULT_OK) &amp;&amp; !!is_vbios_lttpr_enable;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
+<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (ctx-&gt;dc_bios-&gt;funcs-&gt;get=
_lttpr_interop) {<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; enum bp_result bp_query_result;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; uint8_t is_vbios_interop_enabled =3D 0;<br>
+<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; bp_query_result =3D ctx-&gt;dc_bios-&gt;funcs-&gt;get_lttpr_inte=
rop(ctx-&gt;dc_bios, &amp;is_vbios_interop_enabled);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; dc-&gt;caps.vbios_lttpr_aware =3D (bp_query_result =3D=3D BP_RES=
ULT_OK) &amp;&amp; !!is_vbios_interop_enabled;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
+<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (dc-&gt;ctx-&gt;dce_env=
ironment =3D=3D DCE_ENV_PRODUCTION_DRV)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; dc-&gt;debug =3D debug_defaults_drv;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; else if (dc-&gt;ctx-&gt;dc=
e_environment =3D=3D DCE_ENV_FPGA_MAXIMUS) {<br>
diff --git a/drivers/gpu/drm/amd/display/dc/dcn302/dcn302_resource.c b/driv=
ers/gpu/drm/amd/display/dc/dcn302/dcn302_resource.c<br>
index fcf96cf08c76..058f5d71e037 100644<br>
--- a/drivers/gpu/drm/amd/display/dc/dcn302/dcn302_resource.c<br>
+++ b/drivers/gpu/drm/amd/display/dc/dcn302/dcn302_resource.c<br>
@@ -1557,6 +1557,24 @@ static bool dcn302_resource_construct(<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dc-&gt;caps.color.mpc.ogam=
_rom_caps.hlg =3D 0;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dc-&gt;caps.color.mpc.ocsc=
 =3D 1;<br>
&nbsp;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* read VBIOS LTTPR caps */<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (ctx-&gt;dc_bios-&gt;funcs-&gt;get=
_lttpr_caps) {<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; enum bp_result bp_query_result;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; uint8_t is_vbios_lttpr_enable =3D 0;<br>
+<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; bp_query_result =3D ctx-&gt;dc_bios-&gt;funcs-&gt;get_lttpr_caps=
(ctx-&gt;dc_bios, &amp;is_vbios_lttpr_enable);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; dc-&gt;caps.vbios_lttpr_enable =3D (bp_query_result =3D=3D BP_RE=
SULT_OK) &amp;&amp; !!is_vbios_lttpr_enable;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
+<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (ctx-&gt;dc_bios-&gt;funcs-&gt;get=
_lttpr_interop) {<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; enum bp_result bp_query_result;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; uint8_t is_vbios_interop_enabled =3D 0;<br>
+<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; bp_query_result =3D ctx-&gt;dc_bios-&gt;funcs-&gt;get_lttpr_inte=
rop(ctx-&gt;dc_bios,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &amp;is_vbios_interop_enabled);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; dc-&gt;caps.vbios_lttpr_aware =3D (bp_query_result =3D=3D BP_RES=
ULT_OK) &amp;&amp; !!is_vbios_interop_enabled;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
+<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (dc-&gt;ctx-&gt;dce_env=
ironment =3D=3D DCE_ENV_PRODUCTION_DRV)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; dc-&gt;debug =3D debug_defaults_drv;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; else<br>
diff --git a/drivers/gpu/drm/amd/display/dc/dcn303/dcn303_resource.c b/driv=
ers/gpu/drm/amd/display/dc/dcn303/dcn303_resource.c<br>
index 4a9b64023675..7024aeb0884c 100644<br>
--- a/drivers/gpu/drm/amd/display/dc/dcn303/dcn303_resource.c<br>
+++ b/drivers/gpu/drm/amd/display/dc/dcn303/dcn303_resource.c<br>
@@ -1500,6 +1500,23 @@ static bool dcn303_resource_construct(<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dc-&gt;caps.color.mpc.ogam=
_rom_caps.hlg =3D 0;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dc-&gt;caps.color.mpc.ocsc=
 =3D 1;<br>
&nbsp;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* read VBIOS LTTPR caps */<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (ctx-&gt;dc_bios-&gt;funcs-&gt;get=
_lttpr_caps) {<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; enum bp_result bp_query_result;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; uint8_t is_vbios_lttpr_enable =3D 0;<br>
+<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; bp_query_result =3D ctx-&gt;dc_bios-&gt;funcs-&gt;get_lttpr_caps=
(ctx-&gt;dc_bios, &amp;is_vbios_lttpr_enable);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; dc-&gt;caps.vbios_lttpr_enable =3D (bp_query_result =3D=3D BP_RE=
SULT_OK) &amp;&amp; !!is_vbios_lttpr_enable;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
+<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (ctx-&gt;dc_bios-&gt;funcs-&gt;get=
_lttpr_interop) {<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; enum bp_result bp_query_result;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; uint8_t is_vbios_interop_enabled =3D 0;<br>
+<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; bp_query_result =3D ctx-&gt;dc_bios-&gt;funcs-&gt;get_lttpr_inte=
rop(ctx-&gt;dc_bios, &amp;is_vbios_interop_enabled);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; dc-&gt;caps.vbios_lttpr_aware =3D (bp_query_result =3D=3D BP_RES=
ULT_OK) &amp;&amp; !!is_vbios_interop_enabled;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
+<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (dc-&gt;ctx-&gt;dce_env=
ironment =3D=3D DCE_ENV_PRODUCTION_DRV)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; dc-&gt;debug =3D debug_defaults_drv;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; else<br>
-- <br>
2.30.2<br>
<br>
</div>
</span></font></div>
</div>
</body>
</html>

--_000_MW3PR12MB455464EF8ACAF3558479D8FFF9989MW3PR12MB4554namp_--
