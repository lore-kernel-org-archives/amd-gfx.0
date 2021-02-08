Return-Path: <SRS0=WKN7=HK=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_PATCH,
	MAILING_LIST_MULTI,PDS_BAD_THREAD_QP_64,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 555A1C433E6
	for <amd-gfx@archiver.kernel.org>; Mon,  8 Feb 2021 19:59:00 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E1C0A64E60
	for <amd-gfx@archiver.kernel.org>; Mon,  8 Feb 2021 19:58:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E1C0A64E60
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3F5556E9DF;
	Mon,  8 Feb 2021 19:58:59 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2074.outbound.protection.outlook.com [40.107.243.74])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 667476E9DF
 for <amd-gfx@lists.freedesktop.org>; Mon,  8 Feb 2021 19:58:57 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AWntcALDRKBA4/chTTN670BDvKMYViVdp3Q3kRZqLeWBHU3w6ACzP+T6Rsp90x/WKXm6jZqNHhw6IRjjaiwt78U35ouSPgODRX71vXul5ctawRKS2S+3UEAlYYzyRXw4Lt8zPTeT7sjHSlxt6PYMLKt+ebt0njX+9fWHaTOatg1bZjChxplEArAeMDGRSDnBRwJD3N5+qLHPqISJYty7v3RleX4wT6lgLr2FOtH4Oxq2oRL5pWDslxxW9Sue7tebD/tjSCQpC1OosK4PNgfAtkutOr/0FyOZSIrIWQozoJ9jfN/Y0Ka5GS6qwigBvswCWYaYBcxJDoezqzwHvo3rHQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lde1r4gJ0sZpFTI+ebt3LHhepsF/QupwVtSXCkt0ZBg=;
 b=ofJYtajcUqg2vXUtzw/JNLohbC9cNTUFrv72FygifKLFTsmM4kTOihwiNAQrEyhKMJLLf70CkVr6paP8cRMa42i/33zaGZE4IeAQZopjN3qdSLwqWvx73gQDZ8aIKX/Oy30kKYm3fX2UVIUC21P6/9Ea4rz1gwR2psv9KFQj/2+T7HOTtE/qDWzmp1Yz3zUDgbtoILxut+wZARbBwcGhC6aHIFfN9SOmOGR2J8lV/kFa3Y+daTaP6xRaLfybIGV7PFiJacnJrPMfxFDuaYd18GCcEenHzuLVgkXm2rtq6WUGFI2Aca4+Sj9wsrjXcz4H0CPq7dFuVJV2pQ3Jjh+bIQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lde1r4gJ0sZpFTI+ebt3LHhepsF/QupwVtSXCkt0ZBg=;
 b=EaWjyfPAHr9w4KK5iuuBsJmUsilv6XKYdmUm8TNagAWmVgSruOEtflAg9/tMTDgRLOaIK4E4mv3d+wyoYBxpZQ4mljR9YCY5kO4vfg+Ns2YtZYfd+/COboj0rV/NhBco4kMBVpo154NptohrBHK11cO1ThSwmxH+RDeEyZD8Cj8=
Received: from MN2PR12MB4488.namprd12.prod.outlook.com (2603:10b6:208:24e::19)
 by MN2PR12MB4653.namprd12.prod.outlook.com (2603:10b6:208:1b8::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3825.17; Mon, 8 Feb
 2021 19:58:55 +0000
Received: from MN2PR12MB4488.namprd12.prod.outlook.com
 ([fe80::b0c4:9a8b:4c4c:76af]) by MN2PR12MB4488.namprd12.prod.outlook.com
 ([fe80::b0c4:9a8b:4c4c:76af%8]) with mapi id 15.20.3805.038; Mon, 8 Feb 2021
 19:58:55 +0000
From: "Deucher, Alexander" <Alexander.Deucher@amd.com>
To: "Jacob, Anson" <Anson.Jacob@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: Re: [PATCH] Revert "drm/amd/display: move edp sink present detection
 to hw init"
Thread-Topic: [PATCH] Revert "drm/amd/display: move edp sink present detection
 to hw init"
Thread-Index: AQHW/lBDIGPrVrMVoke0ahpfxmtS+6pOrK73
Date: Mon, 8 Feb 2021 19:58:54 +0000
Message-ID: <MN2PR12MB4488D27AB1A77FF23A786711F78F9@MN2PR12MB4488.namprd12.prod.outlook.com>
References: <20210208192531.2924743-1-Anson.Jacob@amd.com>
In-Reply-To: <20210208192531.2924743-1-Anson.Jacob@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Enabled=True;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SetDate=2021-02-08T19:58:53.804Z;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Name=Internal
 Distribution
 Only; MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ContentBits=0;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Method=Standard; 
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [192.161.78.237]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 7b12c40e-f241-4992-9c36-08d8cc6bf71d
x-ms-traffictypediagnostic: MN2PR12MB4653:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MN2PR12MB46533690B1AF6938FAD361DCF78F9@MN2PR12MB4653.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:163;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: xaKaKTH7lmdHT9WLNYMFh7+ob4juy5ASLGNBZOBoNchKEp9/51nq4JsJ2fzpsmFVCAZDhsQL+oFARLnBHvZ+UsNE7VkR+1lrc1Vtvw1XJsc8dyFKdAIX5jmvlF/VNigFin3NGykiEpaDXoCTgdpKlVxy3D2JFCx9dGh4nVChAXj46SHKYO49k9MUGF0dFinyH3tC2JLrUhbcknxV4gj8Vi6k6oSsPjNbDaKFwE/92JLvlR5uKefTusNQeiaYFHM5XotrlAThGu7lrwuaruPtZDTtGvmYPv5/qvtBbLZEmnOc/bmwPry+nsnq/iNyj9XZjw3YuG47aNKhEArtxbyyksUpAjEFdCWKm03GVU6K96PkD1Yoz7g/eQwqsmbR493TzsTT6WvGpTre5P3zFDIs8pOheN8EfufQ5IUTrS7TMtrT+2UK2y5v+VMBU2D4zSU8yEjotv1E3BW+FH8dIsWmST8w/GWymJzC+rOWbw6mwesWn8tUc/6uL26qsAjn/E1M5ZArSp+dbZZ+fCKbO8LoK7TC3I6q9L19fMP7hr2Qi0GXx9vsYj9ywG5Yhl8d3CA8
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB4488.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(39860400002)(396003)(366004)(136003)(376002)(346002)(66476007)(4326008)(55016002)(166002)(316002)(52536014)(76116006)(66446008)(5660300002)(33656002)(8936002)(19627405001)(64756008)(83380400001)(45080400002)(54906003)(66556008)(2906002)(478600001)(8676002)(86362001)(966005)(26005)(6506007)(9686003)(71200400001)(7696005)(66946007)(186003)(53546011)(110136005);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: =?iso-8859-1?Q?brnuu/OJLqKhh9HMjhYTCHRQdSOOZpzj06/KohHfeY3gI4RwmveS2q0wq7?=
 =?iso-8859-1?Q?X/ISySctBP6P7ibz9EgaRpjAwtowj+GvkzGAjbMF496wrwrm8UZXbHqRX7?=
 =?iso-8859-1?Q?7HSjAbAKeHeHTUcgnjLaPLf6Zm73elLJ4QwkPf9xY6mM2CmjJkhd2BpQZE?=
 =?iso-8859-1?Q?bJ1mO6Jgj1lHe1yADRhbukw+1fHDoGk6LOXRBh3K+ckV81RWRiohQnlLwn?=
 =?iso-8859-1?Q?x58tcTzNlhDWt9sQQCGCgrUlYvDB8nEBKV3k/iZ26pOBRVwQdnJbNF1OvE?=
 =?iso-8859-1?Q?lhm81SyWrox0+SqeFUu5h5HegwP6AOQGiFMtWx2d8oyJh41ChaxePp8srn?=
 =?iso-8859-1?Q?UL60cdOVP32IWHmUJCbfJVjQt4J1ThOnxKOqPbzAiF0V6bWqTyR3J3RY2b?=
 =?iso-8859-1?Q?9jHwswyqI7IsPQ57Zp9j7Dm9DOKx475dLocvgT/athu6iMJjLhGaRMQ439?=
 =?iso-8859-1?Q?ELfYDiPTH1rXeQITYE8sNBrwDuA+kqQvPAGaIvnGzkdlE/xpWjETQKg6j4?=
 =?iso-8859-1?Q?nkiiKH5/PN2jlDz+LFItuG8puK6nIL/r10hxf9AFPZuIitdDvloUHOcMxf?=
 =?iso-8859-1?Q?kwFjTnRU0XEptrCgVUBPieqwW/RkN3rwFrJw9DV6TfM6fmF3YxDa5NO+vF?=
 =?iso-8859-1?Q?xL23j7quIQqzHcfGSo+HsT9z6p+Qg3gBw0XtK99OyqsfUV1sIP8Qp2O2ZZ?=
 =?iso-8859-1?Q?gMo5Y1f/gQ6RiEEkGw8bgRzfroYSjCdkyybMrXi2ZHkNuVdfYD6VVNcG2L?=
 =?iso-8859-1?Q?38lEt9Vi85+aWgtiFUeVyAHgX85AeingU8wZlaBpA29N+jnwEFZYs5BikS?=
 =?iso-8859-1?Q?mvc5/2+5RB9MzA8RJzkX7WuIToQ/NxPgSog+2kYahKigK3VYJ1NyFDVBVt?=
 =?iso-8859-1?Q?o2sVTkHvASw9nqJGEb8QTxQI4YzmDxsuTaOvRY8B5R+YQadvJFh0ZkAfPv?=
 =?iso-8859-1?Q?IQn5tGhQKi6ADTZ9tqt6Y1F2zIDpEI4pwJgfUt71BScuqN2xNLRYN418IF?=
 =?iso-8859-1?Q?P5BzsO6PJUcy9S/xlBsz36u733axM0BQQlj9i8YdEfNpJxpsrBS6pEY35z?=
 =?iso-8859-1?Q?baajf++NN2f8sjzeuCOmM8mfDqguvG//g4xIRdWLZDcNbkel30IXMHp6BF?=
 =?iso-8859-1?Q?zB1L3ge2ULhbYr8X52QKP/odN9+QS0FKe8WWXzBd776+Yx+Unz27oHnmEB?=
 =?iso-8859-1?Q?psFwLNkVSiFwZHpV2MxdeDYx5jb39hdb7HHQUiH5iCqW7ORX0GLW5bgXic?=
 =?iso-8859-1?Q?+G8O/p/akFh6r9KMUzoBX+sPH28u/u5ARPKDsaZJ0yJFc2Z59tmALYu1rw?=
 =?iso-8859-1?Q?PKXBs25VXMShODg+tH06//uPMi1TcxXlV2tQpDnOLueFLkK6xyrFWzASxL?=
 =?iso-8859-1?Q?tByG8346vI?=
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB4488.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7b12c40e-f241-4992-9c36-08d8cc6bf71d
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Feb 2021 19:58:54.9139 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: w3CljpjbBSUgef8pGPt2G4sPqRPoRha5/Jx8XbF2IracX5VHk1/GpN/y2DrXSBZBBh4NTuS/wevQ0z/MMdNPCA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4653
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
Content-Type: multipart/mixed; boundary="===============0193413901=="
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--===============0193413901==
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_MN2PR12MB4488D27AB1A77FF23A786711F78F9MN2PR12MB4488namp_"

--_000_MN2PR12MB4488D27AB1A77FF23A786711F78F9MN2PR12MB4488namp_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

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

--_000_MN2PR12MB4488D27AB1A77FF23A786711F78F9MN2PR12MB4488namp_
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
Patch is missing your signed-off-by.&nbsp; Please also give some details as=
 to the regression (blank screen, segfault, etc.) and affected platforms.<b=
r>
</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
<br>
</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
Alex</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
<br>
</div>
<div id=3D"appendonsend"></div>
<div style=3D"font-family:Calibri,Arial,Helvetica,sans-serif; font-size:12p=
t; color:rgb(0,0,0)">
<br>
</div>
<hr tabindex=3D"-1" style=3D"display:inline-block; width:98%">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font style=3D"font-size:11pt" face=
=3D"Calibri, sans-serif" color=3D"#000000"><b>From:</b> amd-gfx &lt;amd-gfx=
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
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt"=
>
<div class=3D"PlainText">This reverts commit de6571ecbb88643fa4bb4172e65c12=
795a2f3124.<br>
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
</body>
</html>

--_000_MN2PR12MB4488D27AB1A77FF23A786711F78F9MN2PR12MB4488namp_--

--===============0193413901==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

--===============0193413901==--
