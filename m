Return-Path: <SRS0=WKN7=HK=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_PATCH,
	MAILING_LIST_MULTI,PDS_BAD_THREAD_QP_64,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8747CC433DB
	for <amd-gfx@archiver.kernel.org>; Mon,  8 Feb 2021 21:53:59 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1F24664E8C
	for <amd-gfx@archiver.kernel.org>; Mon,  8 Feb 2021 21:53:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1F24664E8C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9122D6E956;
	Mon,  8 Feb 2021 21:53:58 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2054.outbound.protection.outlook.com [40.107.243.54])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A81B26E93D
 for <amd-gfx@lists.freedesktop.org>; Mon,  8 Feb 2021 21:53:57 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MZIwOk0R02q3P+jmqQrpkiIZAjrNDPe4yoj1UEsv0c9uHXnrZkti949YMCmsbLxzC97Dxyc9or7M4RmLsRYehUS6MgkTUfoLHRz/5ir2+kNoxB5MoblQz3dT/FPm08mxgCIMGw7qtsWPntnKENNonN17AAR+edbwB8evq4c/NHX46PXvsdvX/HsPehj0if58KGcs7IfU5E75IVn2VPY5RCX625yuLbI1u+72aGHHbM00SE6P+yR9t7fXcRYPgQ+qetHCgmjI+4nNbug753V8VrXfb0i8JoiW32eJ4Wb7C6b+2QqYvwRp2uOYq+EJ7fh4LS7BVX8PLHT6uABD+N148w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=p8gZpGx8bnTAYk8GM2/pUbGd5ehNbtGPbE0qkqA6h4Y=;
 b=EG4wJPT9/c/YeYfSnSUBrOWXGWqBtpHLloR9lECuCztRp7zT61YkzjhdaQbPLmzTrB9WefA0PHunG7+lyGktk3Fkb3+vGVQUpUVEBHaL/KOrVYC0gRn5xRfytQrPJB/J2SCLZ3FdJfqoYxTrhz4OHxeejPucUGHutFzbgPiBHkmTr0XpNO+F4OBpTK6secjm1RmdAH56c2tm1mMGD7JKMECQJKHUZkPBWEp9zQeI36BM4SUcAO/9dlhMZXcSKkgdO2jPLyRVpw6giT5KzbDrKgKQ/xeN8R9eE1ryHDmjVK1fclRrH4JvBVa9d1uiRRiUbai63tVPVbmCAq4jRoMGjg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=p8gZpGx8bnTAYk8GM2/pUbGd5ehNbtGPbE0qkqA6h4Y=;
 b=vhPoWPnGvzjqOHLTTDEJlQv+QPzXqOQFRZfTtTF4LkKafb6YWH9MEy46crIc5yrKTfVSRk1S2YQQQAe0rtO7IuxX3iC9aWMx6AUAN+xc0p/jE2OlLzmXEM3fLxxcFvSkzJlJoFRw3Tee9aZ00nirUnRuhnwSxnZ3RLjkVgmKjC0=
Received: from BYAPR12MB3528.namprd12.prod.outlook.com (2603:10b6:a03:138::28)
 by BYAPR12MB3256.namprd12.prod.outlook.com (2603:10b6:a03:135::26)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3825.20; Mon, 8 Feb
 2021 21:53:51 +0000
Received: from BYAPR12MB3528.namprd12.prod.outlook.com
 ([fe80::f577:7272:3619:bff9]) by BYAPR12MB3528.namprd12.prod.outlook.com
 ([fe80::f577:7272:3619:bff9%7]) with mapi id 15.20.3825.030; Mon, 8 Feb 2021
 21:53:51 +0000
From: "Jacob, Anson" <Anson.Jacob@amd.com>
To: "Deucher, Alexander" <Alexander.Deucher@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Subject: Re: [PATCH] Revert "drm/amd/display: move edp sink present detection
 to hw init"
Thread-Topic: [PATCH] Revert "drm/amd/display: move edp sink present detection
 to hw init"
Thread-Index: AQHW/lA/ID1TVWELQ0izxGZutgmWpqpOrQcAgAAflJE=
Date: Mon, 8 Feb 2021 21:53:51 +0000
Message-ID: <BYAPR12MB3528183084D1D8720CAE50E3EB8F9@BYAPR12MB3528.namprd12.prod.outlook.com>
References: <20210208192531.2924743-1-Anson.Jacob@amd.com>,
 <MN2PR12MB4488D27AB1A77FF23A786711F78F9@MN2PR12MB4488.namprd12.prod.outlook.com>
In-Reply-To: <MN2PR12MB4488D27AB1A77FF23A786711F78F9@MN2PR12MB4488.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Enabled=True;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_SetDate=2021-02-08T21:53:50.602Z;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Name=AMD
 Public; MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_ContentBits=0;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Method=Privileged; 
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [165.204.84.11]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 61305444-e8ec-4399-db66-08d8cc7c059c
x-ms-traffictypediagnostic: BYAPR12MB3256:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BYAPR12MB32565C72AF3E7BA4CE2E4EFFEB8F9@BYAPR12MB3256.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:4714;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: PIbbTECkxNNNQnVYonB9gMX7+XzLKBBdxJXkcEyJ/vQjGvIXFZ1s5Y4HsO9HG0Y9yjFJnqJGnIVhtFzblPblwjXvTcP/taBwexWHn84GIj5c8elP3PaHRXNchH+IqcIo53g4ex538iazeaYAKOdnmIpob2PeotxwGXk7rdqQHGTLLtYXx4EQG/qsd4d8sNx60y9qIiiwd4brkd7AmUxcRm4wJI7/neghH7rMQruXEmUoFZnOKnNMXWbkDLTMbjWtGpGIXL0ai/XlYwh90UCcCzd/pUXze98hspF+JhAomIeu7mheRgJIX9XkyF2uGWYJcg4Vg0mAufpZ8Dx4xANWIGfiSDXgYMstL1J2TD309csAqmapQKqIWCgAKMnhZRsr6CSrl6wvpPoIlPmqefd6IwOUoAhHCA/JmrWI8SX37BX7pbOKrq2bednSLoTAAHEsqd22xCF1uQCN/CFMkAZogEuaJkdKdlkx8LsS55jdrjnSbwMez68jZuGLLePSdLasPlTjMcyVwVFw1gD0NjptNpkbGgyiXLBULWq29EKOHKMEZsdhbilzO0SaSpdQfKeE
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR12MB3528.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(396003)(346002)(376002)(136003)(39860400002)(366004)(52536014)(5660300002)(8676002)(64756008)(66446008)(66556008)(66476007)(71200400001)(83380400001)(86362001)(33656002)(91956017)(8936002)(166002)(66946007)(26005)(45080400002)(19627405001)(54906003)(2906002)(9686003)(4326008)(7696005)(110136005)(316002)(76116006)(966005)(478600001)(53546011)(55016002)(186003)(6506007);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?VFBLB4ktakv7GpXBXjN+RBtFu4ddPnPXcQhfuG9n04alAdveb98LcrVoW/sP?=
 =?us-ascii?Q?c3t7do5/5otsvvAftjwCRIwgFrIiJiNNYrUNz53lDBeKrR+yZpfIDfMb9Sos?=
 =?us-ascii?Q?6FBE7+5KwPwFc7cQtDBz3iWMH3TtTadlnyXdO6enNJ0r8h6Sw0+lj3lv+EJ6?=
 =?us-ascii?Q?y0nLns6+LbRSSVyifpF5mftYc8dq8DtOgFcN82REPG42dN9cLz6QjU+grnht?=
 =?us-ascii?Q?zn4/J1RxnuU94SQ3DQrj3numDVTi56ERC+uyOIk9koEQnEhJ1/ib+PBHDP7D?=
 =?us-ascii?Q?CqAMvFOkKuhwH85bgi4b2TfFHaWGk6pEWJKFasiznJ77u6DMkvElvgOGzTFE?=
 =?us-ascii?Q?N6q82QYrGs+CbpqAiF0OpCMJgRoAlmME0BSNArz7XsXGXBupTuu1JxYePSLD?=
 =?us-ascii?Q?adhf1Tqy8NqGlcrIJs7GLzrEfcvkVvcZ3ZBDbYt7Cn4ujj9KulwJg5pqbXGr?=
 =?us-ascii?Q?hr7KPdazhxOtkws7GO9c5A4PGyDXMq1j1NQ50CrUpXGWFfcKWxyspMJemnF8?=
 =?us-ascii?Q?UeNqGDRwMFadRsa4nB/Byr3EdZ3leMcChj9ADXRPYCEm/42gmYr0qAhg6eC0?=
 =?us-ascii?Q?o331CAvzias4HKOXx0uBiVzLQCtuiPPBIX5T81UTDDUPf5/0+z3ytL3xTMP9?=
 =?us-ascii?Q?rxDAcVKKFQYhPSqKbux8tlnZOKoMs46q+HOZP6xOO0+8LIJF9CWezreYSr2C?=
 =?us-ascii?Q?HOQokZEGl5peXugAoDTouvc5uH4pWOWZDZP4QQOhw8ASzi5P+Hk2ysT0ulbf?=
 =?us-ascii?Q?ExG00ag0RcBmewPYnyDf1cBcpALuNKrnuJixxY5wRVuaU2o6MwXIkIYC+Uvq?=
 =?us-ascii?Q?PW7+Z4AcqOk682C+3y0bg3UQhIANpx/3rRymaTEGadm5/AqxDUAaQRAUa/+D?=
 =?us-ascii?Q?4p26Pz6HlNEnfb4KVDvh9sYw6tzwWWMfBDB714B2jkmDeRkt58d7DgSxX3ov?=
 =?us-ascii?Q?2Z8dCMTd8v3BeHBjGbFOPT/QtLFz/B2MVJ9JvEbjHpdProm/WdpN+uNgLo82?=
 =?us-ascii?Q?LTeDbi2LUBa0iVFppC5J1dPBOXY2UMdRoiFcLofN3S0e/Xivgr1rDCVi2jnc?=
 =?us-ascii?Q?B7EpkR8vlBr11aZeVjpvzF0Me8jjH/TNyMyAqJq+F8uhlBowypAYNNEjwcjV?=
 =?us-ascii?Q?SbakruhImDO6Ta4mBbMlkYUvX5u6xx0jpyyPpAfP/oqZurDnD17hNosegCyn?=
 =?us-ascii?Q?WuHnu1r+7SeKlRmO2lXY8+3A1YqqTNmc3Q5SL+xAfCq6mthZJApzooHlfmdi?=
 =?us-ascii?Q?0MSlhym/I6A9ZiTOpAZg9TXPgCoJghRvF3LZBshdBADG4FYqcZTcYChpO5du?=
 =?us-ascii?Q?VRs=3D?=
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB3528.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 61305444-e8ec-4399-db66-08d8cc7c059c
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Feb 2021 21:53:51.2513 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 5vQ27GyX4Pq1BXIO3V1GHHPeMzjiHmVCmY4e6846WHq4XPWElkfY5ixA2KFsxcXw/zQ2HP41HKVc62U1a9kJow==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB3256
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
 Rodrigo" <Rodrigo.Siqueira@amd.com>, "Pillai,
 Aurabindo" <Aurabindo.Pillai@amd.com>, "Wentland,
 Harry" <Harry.Wentland@amd.com>, "R, Bindu" <Bindu.R@amd.com>
Content-Type: multipart/mixed; boundary="===============1965236103=="
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--===============1965236103==
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_BYAPR12MB3528183084D1D8720CAE50E3EB8F9BYAPR12MB3528namp_"

--_000_BYAPR12MB3528183084D1D8720CAE50E3EB8F9BYAPR12MB3528namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

[AMD Public Use]

Hi Alex,

Thanks for catching it.

But, please discard this patch as it was send out incorrectly.

-- Anson
________________________________
From: Deucher, Alexander <Alexander.Deucher@amd.com>
Sent: Monday, February 8, 2021 2:58 PM
To: Jacob, Anson <Anson.Jacob@amd.com>; amd-gfx@lists.freedesktop.org <amd-=
gfx@lists.freedesktop.org>
Cc: Brol, Eryk <Eryk.Brol@amd.com>; Li, Sun peng (Leo) <Sunpeng.Li@amd.com>=
; Wentland, Harry <Harry.Wentland@amd.com>; Zhuo, Qingqing <Qingqing.Zhuo@a=
md.com>; Siqueira, Rodrigo <Rodrigo.Siqueira@amd.com>; Pillai, Aurabindo <A=
urabindo.Pillai@amd.com>; Lakha, Bhawanpreet <Bhawanpreet.Lakha@amd.com>; R=
, Bindu <Bindu.R@amd.com>
Subject: Re: [PATCH] Revert "drm/amd/display: move edp sink present detecti=
on to hw init"


[AMD Official Use Only - Internal Distribution Only]

Patch is missing your signed-off-by.  Please also give some details as to t=
he regression (blank screen, segfault, etc.) and affected platforms.

Alex


________________________________
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> on behalf of Anson Ja=
cob <Anson.Jacob@amd.com>
Sent: Monday, February 8, 2021 2:25 PM
To: amd-gfx@lists.freedesktop.org <amd-gfx@lists.freedesktop.org>
Cc: Brol, Eryk <Eryk.Brol@amd.com>; Li, Sun peng (Leo) <Sunpeng.Li@amd.com>=
; Wentland, Harry <Harry.Wentland@amd.com>; Zhuo, Qingqing <Qingqing.Zhuo@a=
md.com>; Siqueira, Rodrigo <Rodrigo.Siqueira@amd.com>; Jacob, Anson <Anson.=
Jacob@amd.com>; Pillai, Aurabindo <Aurabindo.Pillai@amd.com>; Lakha, Bhawan=
preet <Bhawanpreet.Lakha@amd.com>; R, Bindu <Bindu.R@amd.com>
Subject: [PATCH] Revert "drm/amd/display: move edp sink present detection t=
o hw init"

This reverts commit de6571ecbb88643fa4bb4172e65c12795a2f3124.

Patch causes regression in resume time.
---
 drivers/gpu/drm/amd/display/dc/core/dc.c | 40 +++++++++++-------------
 drivers/gpu/drm/amd/display/dc/dc_link.h |  2 --
 2 files changed, 18 insertions(+), 24 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc.c b/drivers/gpu/drm/amd=
/display/dc/core/dc.c
index c9aede2f783d..8d5378f53243 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc.c
@@ -205,9 +205,27 @@ static bool create_links(
                 link =3D link_create(&link_init_params);

                 if (link) {
+                       bool should_destory_link =3D false;
+
+                       if (link->connector_signal =3D=3D SIGNAL_TYPE_EDP) =
{
+                               if (dc->config.edp_not_connected) {
+                                       if (!IS_DIAG_DC(dc->ctx->dce_enviro=
nment))
+                                               should_destory_link =3D tru=
e;
+                               } else {
+                                       enum dc_connection_type type;
+                                       dc_link_detect_sink(link, &type);
+                                       if (type =3D=3D dc_connection_none)
+                                               should_destory_link =3D tru=
e;
+                               }
+                       }
+
+                       if (dc->config.force_enum_edp || !should_destory_li=
nk) {
                                 dc->links[dc->link_count] =3D link;
                                 link->dc =3D dc;
                                 ++dc->link_count;
+                       } else {
+                               link_destroy(&link);
+                       }
                 }
         }

@@ -998,30 +1016,8 @@ struct dc *dc_create(const struct dc_init_data *init_=
params)
         return NULL;
 }

-static void detect_edp_presence(struct dc *dc)
-{
-       struct dc_link *edp_link =3D get_edp_link(dc);
-       bool edp_sink_present =3D true;
-
-       if (!edp_link)
-               return;
-
-       if (dc->config.edp_not_connected) {
-                       edp_sink_present =3D false;
-       } else {
-               enum dc_connection_type type;
-               dc_link_detect_sink(edp_link, &type);
-               if (type =3D=3D dc_connection_none)
-                       edp_sink_present =3D false;
-       }
-
-       edp_link->edp_sink_present =3D edp_sink_present;
-}
-
 void dc_hardware_init(struct dc *dc)
 {
-
-       detect_edp_presence(dc);
         if (dc->ctx->dce_environment !=3D DCE_ENV_VIRTUAL_HW)
                 dc->hwss.init_hw(dc);
 }
diff --git a/drivers/gpu/drm/amd/display/dc/dc_link.h b/drivers/gpu/drm/amd=
/display/dc/dc_link.h
index e189f16bc026..d5d8f0ad9233 100644
--- a/drivers/gpu/drm/amd/display/dc/dc_link.h
+++ b/drivers/gpu/drm/amd/display/dc/dc_link.h
@@ -103,8 +103,6 @@ struct dc_link {
         bool lttpr_non_transparent_mode;
         bool is_internal_display;

-       bool edp_sink_present;
-
         /* caps is the same as reported_link_cap. link_traing use
          * reported_link_cap. Will clean up.  TODO
          */
--
2.25.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://nam11.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Flists.f=
reedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;data=3D04%7C01%7Calexande=
r.deucher%40amd.com%7C330474ac8a4246a1246e08d8cc676331%7C3dd8961fe4884e608e=
11a82d994e183d%7C0%7C0%7C637484091731093304%7CUnknown%7CTWFpbGZsb3d8eyJWIjo=
iMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C1000&amp;sdat=
a=3DV%2FXbCLY8Vr%2BwEFQ4xE07QQBRNwXE9xKQY4Wnv%2B5PLCI%3D&amp;reserved=3D0

--_000_BYAPR12MB3528183084D1D8720CAE50E3EB8F9BYAPR12MB3528namp_
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
<p style=3D"font-family:Arial;font-size:10pt;color:#317100;margin:15pt;" al=
ign=3D"Left">
[AMD Public Use]<br>
</p>
<br>
<div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
Hi Alex,</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
<br>
</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
Thanks for catching it.&nbsp;</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
<br>
</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
But, please discard this patch as it was send out incorrectly.</div>
<div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
<br>
</div>
<div id=3D"Signature">
<div>
<div style=3D"font-family:Calibri,Arial,Helvetica,sans-serif; font-size:12p=
t; color:rgb(0,0,0)">
-- Anson</div>
</div>
</div>
</div>
<div id=3D"appendonsend"></div>
<hr style=3D"display:inline-block;width:98%" tabindex=3D"-1">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" st=
yle=3D"font-size:11pt" color=3D"#000000"><b>From:</b> Deucher, Alexander &l=
t;Alexander.Deucher@amd.com&gt;<br>
<b>Sent:</b> Monday, February 8, 2021 2:58 PM<br>
<b>To:</b> Jacob, Anson &lt;Anson.Jacob@amd.com&gt;; amd-gfx@lists.freedesk=
top.org &lt;amd-gfx@lists.freedesktop.org&gt;<br>
<b>Cc:</b> Brol, Eryk &lt;Eryk.Brol@amd.com&gt;; Li, Sun peng (Leo) &lt;Sun=
peng.Li@amd.com&gt;; Wentland, Harry &lt;Harry.Wentland@amd.com&gt;; Zhuo, =
Qingqing &lt;Qingqing.Zhuo@amd.com&gt;; Siqueira, Rodrigo &lt;Rodrigo.Sique=
ira@amd.com&gt;; Pillai, Aurabindo &lt;Aurabindo.Pillai@amd.com&gt;;
 Lakha, Bhawanpreet &lt;Bhawanpreet.Lakha@amd.com&gt;; R, Bindu &lt;Bindu.R=
@amd.com&gt;<br>
<b>Subject:</b> Re: [PATCH] Revert &quot;drm/amd/display: move edp sink pre=
sent detection to hw init&quot;</font>
<div>&nbsp;</div>
</div>
<style type=3D"text/css" style=3D"display:none">
<!--
p
	{margin-top:0;
	margin-bottom:0}
-->
</style>
<div dir=3D"ltr">
<p align=3D"Left" style=3D"font-family:Arial; font-size:11pt; color:#0078D7=
; margin:5pt">
[AMD Official Use Only - Internal Distribution Only]<br>
</p>
<br>
<div>
<div style=3D"font-family:Calibri,Arial,Helvetica,sans-serif; font-size:12p=
t; color:rgb(0,0,0)">
Patch is missing your signed-off-by.&nbsp; Please also give some details as=
 to the regression (blank screen, segfault, etc.) and affected platforms.<b=
r>
</div>
<div style=3D"font-family:Calibri,Arial,Helvetica,sans-serif; font-size:12p=
t; color:rgb(0,0,0)">
<br>
</div>
<div style=3D"font-family:Calibri,Arial,Helvetica,sans-serif; font-size:12p=
t; color:rgb(0,0,0)">
Alex</div>
<div style=3D"font-family:Calibri,Arial,Helvetica,sans-serif; font-size:12p=
t; color:rgb(0,0,0)">
<br>
</div>
<div id=3D"x_appendonsend"></div>
<div style=3D"font-family:Calibri,Arial,Helvetica,sans-serif; font-size:12p=
t; color:rgb(0,0,0)">
<br>
</div>
<hr tabindex=3D"-1" style=3D"display:inline-block; width:98%">
<div id=3D"x_divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" =
color=3D"#000000" style=3D"font-size:11pt"><b>From:</b> amd-gfx &lt;amd-gfx=
-bounces@lists.freedesktop.org&gt; on behalf of Anson Jacob &lt;Anson.Jacob=
@amd.com&gt;<br>
<b>Sent:</b> Monday, February 8, 2021 2:25 PM<br>
<b>To:</b> amd-gfx@lists.freedesktop.org &lt;amd-gfx@lists.freedesktop.org&=
gt;<br>
<b>Cc:</b> Brol, Eryk &lt;Eryk.Brol@amd.com&gt;; Li, Sun peng (Leo) &lt;Sun=
peng.Li@amd.com&gt;; Wentland, Harry &lt;Harry.Wentland@amd.com&gt;; Zhuo, =
Qingqing &lt;Qingqing.Zhuo@amd.com&gt;; Siqueira, Rodrigo &lt;Rodrigo.Sique=
ira@amd.com&gt;; Jacob, Anson &lt;Anson.Jacob@amd.com&gt;; Pillai, Aurabind=
o
 &lt;Aurabindo.Pillai@amd.com&gt;; Lakha, Bhawanpreet &lt;Bhawanpreet.Lakha=
@amd.com&gt;; R, Bindu &lt;Bindu.R@amd.com&gt;<br>
<b>Subject:</b> [PATCH] Revert &quot;drm/amd/display: move edp sink present=
 detection to hw init&quot;</font>
<div>&nbsp;</div>
</div>
<div class=3D"x_BodyFragment"><font size=3D"2"><span style=3D"font-size:11p=
t">
<div class=3D"x_PlainText">This reverts commit de6571ecbb88643fa4bb4172e65c=
12795a2f3124.<br>
<br>
Patch causes regression in resume time.<br>
---<br>
&nbsp;drivers/gpu/drm/amd/display/dc/core/dc.c | 40 +++++++++++------------=
-<br>
&nbsp;drivers/gpu/drm/amd/display/dc/dc_link.h |&nbsp; 2 --<br>
&nbsp;2 files changed, 18 insertions(+), 24 deletions(-)<br>
<br>
diff --git a/drivers/gpu/drm/amd/display/dc/core/dc.c b/drivers/gpu/drm/amd=
/display/dc/core/dc.c<br>
index c9aede2f783d..8d5378f53243 100644<br>
--- a/drivers/gpu/drm/amd/display/dc/core/dc.c<br>
+++ b/drivers/gpu/drm/amd/display/dc/core/dc.c<br>
@@ -205,9 +205,27 @@ static bool create_links(<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; link =3D link_create(&amp;link_init_params);<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; if (link) {<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; bool should_dest=
ory_link =3D false;<br>
+<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (link-&gt;con=
nector_signal =3D=3D SIGNAL_TYPE_EDP) {<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (dc-&gt;config.edp_not_connected) {<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp; if (!IS_DIAG_DC(dc-&gt;ctx-&gt;dce_environment))<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; should_destory_link =
=3D true;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; } else {<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp; enum dc_connection_type type;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp; dc_link_detect_sink(link, &amp;type);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp; if (type =3D=3D dc_connection_none)<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; should_destory_link =
=3D true;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
+<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (dc-&gt;confi=
g.force_enum_edp || !should_destory_link) {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dc-&gt;links[dc-&gt;link_count] =
=3D link;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; link-&gt;dc =3D dc;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ++dc-&gt;link_count;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; } else {<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; link_destroy(&amp;link);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; }<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&nbsp;<br>
@@ -998,30 +1016,8 @@ struct dc *dc_create(const struct dc_init_data *init_=
params)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return NULL;<br>
&nbsp;}<br>
&nbsp;<br>
-static void detect_edp_presence(struct dc *dc)<br>
-{<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct dc_link *edp_link =3D get_edp_=
link(dc);<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; bool edp_sink_present =3D true;<br>
-<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!edp_link)<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; return;<br>
-<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (dc-&gt;config.edp_not_connected) =
{<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; edp_sink_present=
 =3D false;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; } else {<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; enum dc_connection_type type;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; dc_link_detect_sink(edp_link, &amp;type);<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; if (type =3D=3D dc_connection_none)<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; edp_sink_present=
 =3D false;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
-<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; edp_link-&gt;edp_sink_present =3D edp=
_sink_present;<br>
-}<br>
-<br>
&nbsp;void dc_hardware_init(struct dc *dc)<br>
&nbsp;{<br>
-<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; detect_edp_presence(dc);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (dc-&gt;ctx-&gt;dce_env=
ironment !=3D DCE_ENV_VIRTUAL_HW)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; dc-&gt;hwss.init_hw(dc);<br>
&nbsp;}<br>
diff --git a/drivers/gpu/drm/amd/display/dc/dc_link.h b/drivers/gpu/drm/amd=
/display/dc/dc_link.h<br>
index e189f16bc026..d5d8f0ad9233 100644<br>
--- a/drivers/gpu/drm/amd/display/dc/dc_link.h<br>
+++ b/drivers/gpu/drm/amd/display/dc/dc_link.h<br>
@@ -103,8 +103,6 @@ struct dc_link {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; bool lttpr_non_transparent=
_mode;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; bool is_internal_display;<=
br>
&nbsp;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; bool edp_sink_present;<br>
-<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* caps is the same as rep=
orted_link_cap. link_traing use<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * reported_link_cap.=
 Will clean up.&nbsp; TODO<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; */<br>
-- <br>
2.25.1<br>
<br>
_______________________________________________<br>
amd-gfx mailing list<br>
amd-gfx@lists.freedesktop.org<br>
<a href=3D"https://nam11.safelinks.protection.outlook.com/?url=3Dhttps%3A%2=
F%2Flists.freedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;amp;data=3D04%=
7C01%7Calexander.deucher%40amd.com%7C330474ac8a4246a1246e08d8cc676331%7C3dd=
8961fe4884e608e11a82d994e183d%7C0%7C0%7C637484091731093304%7CUnknown%7CTWFp=
bGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%=
7C1000&amp;amp;sdata=3DV%2FXbCLY8Vr%2BwEFQ4xE07QQBRNwXE9xKQY4Wnv%2B5PLCI%3D=
&amp;amp;reserved=3D0">https://nam11.safelinks.protection.outlook.com/?url=
=3Dhttps%3A%2F%2Flists.freedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;a=
mp;data=3D04%7C01%7Calexander.deucher%40amd.com%7C330474ac8a4246a1246e08d8c=
c676331%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637484091731093304%7CU=
nknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLC=
JXVCI6Mn0%3D%7C1000&amp;amp;sdata=3DV%2FXbCLY8Vr%2BwEFQ4xE07QQBRNwXE9xKQY4W=
nv%2B5PLCI%3D&amp;amp;reserved=3D0</a><br>
</div>
</span></font></div>
</div>
</div>
</div>
</body>
</html>

--_000_BYAPR12MB3528183084D1D8720CAE50E3EB8F9BYAPR12MB3528namp_--

--===============1965236103==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

--===============1965236103==--
