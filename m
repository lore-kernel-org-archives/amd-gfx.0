Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CAF61C433F5
	for <amd-gfx@archiver.kernel.org>; Mon, 22 Nov 2021 15:38:21 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4C7B189B49;
	Mon, 22 Nov 2021 15:38:21 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2077.outbound.protection.outlook.com [40.107.243.77])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 37A0B89B49
 for <amd-gfx@lists.freedesktop.org>; Mon, 22 Nov 2021 15:38:20 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZBzRoLIGzyYXVhQ5Ff11IC5/izAxCocYgrakUImgsPwDyMD4OEce8NpkcgZO1nlO015QRGyZTMJPSUvjtf5CkqJhzu14yIUCOVqL0lxWLoWPI7DGwjs+t5aEhl98wyQVEOxRqVof7KBf24ntri7fP8E4W7yBLwTk62eQx+eKE0zbLsuWV6BTAgn2ldkI3qfnt46hTYpK8qUFn9e+RSZugZo0RNlhJ5JQcmec19+dbvD+xRWzo3XnQ+s/l5bFxfhzlAWDFJbhpPxliueyo7yM2YcJL3tWdEteHs9GeYlB1ybRURQfg3RRaMmFznVkOkVjA6HfSKS/hTfMYL7fguhXbg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=G2nD49jwbgy4A61IRXUhYA/tRGQzynt+wXH0WmfrEvM=;
 b=JMnmEHSaEOf/+LKdglEOaoGNNcKemvMu0eXpE1bmabvmQRhwgwygbsldMaahzBIBKt/SQCpYAr86UI7nDzJsspmxJzhp3jTvRqLKnFvYAyWjwjTMnM/DBFrUM+jypQHOk1jtQRRYUCs48WzUBTyBPD5FtfT8mE3TvoWzKcIG/oFczH/YjvGOBN/iuEUJPhmVDxC7MLxsgH6nRm0Cz0rP6uzphfBhtNEv0qWnGldICu7t+bAL/q+zobkGot6MJB6zS7DXMdImARIjF71JDx3Y1wBFhem4CTCcqUC6Xno8KeJ19VEQQ1m8MQtyWxSHQKLWK28Mby+ZecfKRouHhNfMyQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G2nD49jwbgy4A61IRXUhYA/tRGQzynt+wXH0WmfrEvM=;
 b=IKAQQpmWxPh+ixouudJDjLIpeueV9/2JVD0nbnkNqDi5knf3bfglzsF6Zqd/YtKfAvqsP/whgKbb7cwiTz+nVUNOnh6XSiaR5P6q7xBRlU2hMWPQ1C07dU9nHr1jGRICzgdk2LplHzDMbR4gIH1w23vL9BYvPuyIIKT24miujWE=
Received: from BL1PR12MB5144.namprd12.prod.outlook.com (2603:10b6:208:316::6)
 by BL1PR12MB5364.namprd12.prod.outlook.com (2603:10b6:208:314::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4713.19; Mon, 22 Nov
 2021 15:38:17 +0000
Received: from BL1PR12MB5144.namprd12.prod.outlook.com
 ([fe80::6452:dc31:2a24:2830]) by BL1PR12MB5144.namprd12.prod.outlook.com
 ([fe80::6452:dc31:2a24:2830%8]) with mapi id 15.20.4713.025; Mon, 22 Nov 2021
 15:38:17 +0000
From: "Deucher, Alexander" <Alexander.Deucher@amd.com>
To: "Zhuo, Qingqing (Lillian)" <Qingqing.Zhuo@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Subject: Re: [PATCH 14/16] drm/amd/display: add else to avoid double destroy
 clk_mgr
Thread-Topic: [PATCH 14/16] drm/amd/display: add else to avoid double destroy
 clk_mgr
Thread-Index: AQHX3X3WDpho2wwhwEOWNCeptDwvPKwPsk7M
Date: Mon, 22 Nov 2021 15:38:17 +0000
Message-ID: <BL1PR12MB514434CD840471692E9894A2F79F9@BL1PR12MB5144.namprd12.prod.outlook.com>
References: <20211119194339.97573-1-qingqing.zhuo@amd.com>
 <20211119194339.97573-15-qingqing.zhuo@amd.com>
In-Reply-To: <20211119194339.97573-15-qingqing.zhuo@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Enabled=True;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SetDate=2021-11-22T15:38:16.927Z;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Name=Public;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ContentBits=0;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Method=Privileged; 
suggested_attachment_session_id: 2d1b3040-12bd-4153-2753-1fee08dc0ff5
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: f7aa31e9-62ba-4fa2-22b8-08d9adce1b11
x-ms-traffictypediagnostic: BL1PR12MB5364:
x-ld-processed: 3dd8961f-e488-4e60-8e11-a82d994e183d,ExtAddr
x-microsoft-antispam-prvs: <BL1PR12MB5364754893883CA7C585CFF7F79F9@BL1PR12MB5364.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:398;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: LYfugC1LU5TBscZ2qtDxY3LOuRU/x/0rbOJTLQ1h8qDsHtIf831Jey2qHQ67mvhcz1DLagAiopYq4iqSInZftZjjtMN73i4btn9PhaRWMZUvGwdwCTMlJlrJGNYwG2XIB27kPk1fdy37aD/c/CXoWhtEbd2W+gRgJjhekD5udGjuvg6SIAFZpUy7AWW7wTOP5bJ6cR0g49fphfRWy/vEN+3lkr3jNS5nRa1EFJlB+T035iOBJYyyXGKIdPI08cCao+8SYVd4e/6a153d606tgFEhBOB/ZUn0/kjPpYnGM1BRBW1EwTuzgMzXJK5Ow0BDd6DOKY5GhJYwbKVVt46akc4Rrev33q5P/zzqsF2T9zbcimdUEU1l1yvGttd3dt/PjCWkqjJxrWI3QHXpEj0uH3tOTsrIZCVsAXeoTShzV+40epE/e0b+nHGldR5Lm9BMtZU8QUrjz3TPwAyM/kTnd4j03YdD39H+5rkySnaRzw7yqDlbKFrwLJrqTKqZysC3ATsBMqpObAB1dtZpT9nq/itjY1EQi8G+VnUOExOH3RYM3gW9LAFUvFGFCdSU6BqxlBoOj4BtHV66hA1PPhcpjxqEsXKSDY/vvewD28Z9B5sxrK1LfdA22z8XNdTpppQgQOdm8Hv4RUtP4gImVtDdj4nCbPlIonL2PjArR+UXtXUzrwp4GvBfmlTozN4fBlL3jUrsxkZNSE+hcXLk4Y6LbA==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL1PR12MB5144.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(316002)(76116006)(66446008)(66556008)(64756008)(66476007)(508600001)(66946007)(33656002)(83380400001)(8936002)(86362001)(54906003)(8676002)(110136005)(186003)(38070700005)(26005)(6506007)(52536014)(53546011)(2906002)(7696005)(9686003)(55016002)(4326008)(5660300002)(19627405001)(38100700002)(122000001)(71200400001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?YQCm5CprmKktJoyFlBOICVZx8pmd9X63CyUW1ZJ1O3By+LUIrCZFDZKaAPsv?=
 =?us-ascii?Q?MHU5FCDXhgqKJJQPyZRHfS+cbWRVFieAYQ3udHBwmi/x8DQEHlUL6TgCQRI9?=
 =?us-ascii?Q?/QHyKyEb3viPBuMTiW23NfPid6/MzAtQDO6INXPV5TEjiU3FO34JjsxrsUn4?=
 =?us-ascii?Q?xhT8JLlajg5gdW/+pVfcl2Oh4dx5iWrZPt1f4Q9V80//pwSLVx4jLXIuFV+p?=
 =?us-ascii?Q?i8ftMkx9cG5ik0uiDSa9W6sCYETAweKS/Xy7Zj7N3Z3OFeCq9WOhm+m/3b4m?=
 =?us-ascii?Q?MUZhB75hcSJLMdo1HtSAVXDJkSUp5TBFqUcrQGnlI+87UwvPXw8NywsNbZaM?=
 =?us-ascii?Q?wWfVkfzPq5MKH0jVkyduDb6OyBBLznvkh2PxmxT7G8gc7Lm3VmBXeLw5CPKZ?=
 =?us-ascii?Q?rdgPqeE5v/BPYgsOhGNfms5oeUrKjQkK0yb1mepAZkIuYuF36jj2edOcsYcO?=
 =?us-ascii?Q?u4o68AaTBIKZ9718ytJZbkBqfOmi3d+K20kM0qO3hmlIuAF7+VHnmx0b8ggz?=
 =?us-ascii?Q?LfGaVHGMR0EtqJpPwb0HyP9h7GMCSLgPzN6xCiW350Zeoj1VYXT3H9boCNCu?=
 =?us-ascii?Q?ewLAyn4LepLTsXMwL1ZdxIOg0j3VKfi2+3PCrSZuLX1Oz1vtyG3ETpkX3bM+?=
 =?us-ascii?Q?BpUkd6vN7+nLseA6a0WScPmBF6fUZznOQCW+bp8MuEzdxOKG+L1qicXmZwas?=
 =?us-ascii?Q?i8Lnoe3KItBvlCX7IlP96afY4SmZ0tF+dL3XHPWA9NRbBo/pS9rzVX37h1b3?=
 =?us-ascii?Q?mKSkBrRgBIsi5wcWDdAP0xhSMwBtbQv0UN/tP725Jb8gWc1i2MkAg3HbjgTc?=
 =?us-ascii?Q?J0ORTpK7bHelmXEyPoSg4PV4o8VTHH0TCkectMBCBjfcjvavNuzr+PrxCpPu?=
 =?us-ascii?Q?Fv31i24D4JFKsGYiyPqwpWxAO8xuH/gXUgCh9rrcidFWn9ARofrm7cvBffav?=
 =?us-ascii?Q?H/5GSPa0RRdY26lW9kuvxbjPCVaRcEQ6JA+hR57QZhr3/FO1MH1gjpaJ8OvL?=
 =?us-ascii?Q?FXwoc8zwmdpjZgA0DYc6sBGlLoIv0HvyvCwFeiu69QYkOwXJnYp+PuCYNe13?=
 =?us-ascii?Q?agLYlP61WxlBXKnphalXnpD2E9HOVJArfCiucHoKnMyC8X+iQ3UbpBvmXto9?=
 =?us-ascii?Q?JNYb00xLyl+hlI4RaW2goanpIx90Nhv/KxOHe3PqOesJLorrv35zeSqadTSx?=
 =?us-ascii?Q?/jAi3dfcXEJAY52jGGN+4U5BpxLolroPqqSE/Ny4GxKl+2a50RdMhI/9FxX+?=
 =?us-ascii?Q?Q7ifrRZEZ9bXiE88H4B4nq700g/tCQZTduSOC8d4Cxo8iY4rhufJysWVCOb/?=
 =?us-ascii?Q?y4/kU+3gtboRAGLGeUIXzTM+RZS0lDsYmsxcdAPxcBDfW/InDMV5q2ieTuPL?=
 =?us-ascii?Q?9cxS+cGMMdEdVQokl/rlgmsUO7eQQhAzRtNcP5OzR/qAFc9VAjsiVXgOjvY7?=
 =?us-ascii?Q?hJbLOOh3XBFFSdDOCh/rcsCXB2Nym8rTQqK0L52hE4mlGcJ1LcZOYTYndDcg?=
 =?us-ascii?Q?/CgkFxZUN4g0oii1nPfvvxbmQMyE9k13U789H/eU7t8JOwAalPhMPSR+jyH8?=
 =?us-ascii?Q?TK958Y3/lomS4NFHfh/Bc0myUg2XSHfGLyyTh/DS/+MPYrVKBwPQ/ota9f8/?=
 =?us-ascii?Q?vg=3D=3D?=
Content-Type: multipart/alternative;
 boundary="_000_BL1PR12MB514434CD840471692E9894A2F79F9BL1PR12MB5144namp_"
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5144.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f7aa31e9-62ba-4fa2-22b8-08d9adce1b11
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Nov 2021 15:38:17.6819 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Z2Oxv2UhdbdI3UY0pgijOO90+zmK+eF+PH2HmWCaurxr9BiK5TW4TOyjZ+GqrftekOGCIjTRs6sD0Awq8q6sCQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5364
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
Cc: "Wang, Chao-kai \(Stylon\)" <Stylon.Wang@amd.com>, "Cyr,
 Aric" <Aric.Cyr@amd.com>, "Jacob, Anson" <Anson.Jacob@amd.com>, "Li, Sun peng
 \(Leo\)" <Sunpeng.Li@amd.com>, "Lakha,
 Bhawanpreet" <Bhawanpreet.Lakha@amd.com>, "Lin,
 Wayne" <Wayne.Lin@amd.com>, "Siqueira, Rodrigo" <Rodrigo.Siqueira@amd.com>, "Li,
 Roman" <Roman.Li@amd.com>, "Chiu, Solomon" <Solomon.Chiu@amd.com>, "Pillai,
 Aurabindo" <Aurabindo.Pillai@amd.com>, "Leung, Martin" <Martin.Leung@amd.com>,
 "Lipski, Mikita" <Mikita.Lipski@amd.com>, "Wentland,
 Harry" <Harry.Wentland@amd.com>, "Gutierrez,
 Agustin" <Agustin.Gutierrez@amd.com>, "Kotarac, Pavle" <Pavle.Kotarac@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--_000_BL1PR12MB514434CD840471692E9894A2F79F9BL1PR12MB5144namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

[Public]

Do you want to change the ASICREV_IS_BEIGE_GOBY_P() check to else if as wel=
l?  maybe something like:

if (ASICREV_IS_SIENNA_CICHLID_P(clk_mgr_base->ctx->asic_id.hw_internal_rev)=
 ||
    ASICREV_IS_DIMGREY_CAVEFISH_P(clk_mgr_base->ctx->asic_id.hw_internal_re=
v) ||
     ASICREV_IS_BEIGE_GOBY_P(clk_mgr_base->ctx->asic_id.hw_internal_rev))
         dcn3_clk_mgr_destroy(clk_mgr);

Alex
________________________________
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> on behalf of Qingqing=
 Zhuo <qingqing.zhuo@amd.com>
Sent: Friday, November 19, 2021 2:43 PM
To: amd-gfx@lists.freedesktop.org <amd-gfx@lists.freedesktop.org>
Cc: Wang, Chao-kai (Stylon) <Stylon.Wang@amd.com>; Cyr, Aric <Aric.Cyr@amd.=
com>; Chiu, Solomon <Solomon.Chiu@amd.com>; Li, Sun peng (Leo) <Sunpeng.Li@=
amd.com>; Wentland, Harry <Harry.Wentland@amd.com>; Zhuo, Qingqing (Lillian=
) <Qingqing.Zhuo@amd.com>; Leung, Martin <Martin.Leung@amd.com>; Siqueira, =
Rodrigo <Rodrigo.Siqueira@amd.com>; Li, Roman <Roman.Li@amd.com>; Jacob, An=
son <Anson.Jacob@amd.com>; Pillai, Aurabindo <Aurabindo.Pillai@amd.com>; Li=
n, Wayne <Wayne.Lin@amd.com>; Lipski, Mikita <Mikita.Lipski@amd.com>; Lakha=
, Bhawanpreet <Bhawanpreet.Lakha@amd.com>; Gutierrez, Agustin <Agustin.Guti=
errez@amd.com>; Kotarac, Pavle <Pavle.Kotarac@amd.com>
Subject: [PATCH 14/16] drm/amd/display: add else to avoid double destroy cl=
k_mgr

From: Martin Leung <Martin.Leung@amd.com>

[Why & How]
when changing some code we accidentally
changed else if-> if. reverting that.

Reviewed-by: Aric Cyr <Aric.Cyr@amd.com>
Acked-by: Qingqing Zhuo <qingqing.zhuo@amd.com>
Signed-off-by: Martin Leung <Martin.Leung@amd.com>
---
 drivers/gpu/drm/amd/display/dc/clk_mgr/clk_mgr.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/clk_mgr/clk_mgr.c b/drivers/gpu=
/drm/amd/display/dc/clk_mgr/clk_mgr.c
index 26f96ee32472..9200c8ce02ba 100644
--- a/drivers/gpu/drm/amd/display/dc/clk_mgr/clk_mgr.c
+++ b/drivers/gpu/drm/amd/display/dc/clk_mgr/clk_mgr.c
@@ -308,8 +308,7 @@ void dc_destroy_clk_mgr(struct clk_mgr *clk_mgr_base)
         case FAMILY_NV:
                 if (ASICREV_IS_SIENNA_CICHLID_P(clk_mgr_base->ctx->asic_id=
.hw_internal_rev)) {
                         dcn3_clk_mgr_destroy(clk_mgr);
-               }
-               if (ASICREV_IS_DIMGREY_CAVEFISH_P(clk_mgr_base->ctx->asic_i=
d.hw_internal_rev)) {
+               } else if (ASICREV_IS_DIMGREY_CAVEFISH_P(clk_mgr_base->ctx-=
>asic_id.hw_internal_rev)) {
                         dcn3_clk_mgr_destroy(clk_mgr);
                 }
                 if (ASICREV_IS_BEIGE_GOBY_P(clk_mgr_base->ctx->asic_id.hw_=
internal_rev)) {
--
2.25.1


--_000_BL1PR12MB514434CD840471692E9894A2F79F9BL1PR12MB5144namp_
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
<p style=3D"font-family:Arial;font-size:10pt;color:#008000;margin:15pt;" al=
ign=3D"Left">
[Public]<br>
</p>
<br>
<div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
Do you want to change the <font size=3D"2"><span style=3D"font-size:11pt">A=
SICREV_IS_BEIGE_GOBY_P</span></font>() check to else if as well?&nbsp; mayb=
e something like:</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
<br>
</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
if (ASICREV_IS_SIENNA_CICHLID_P(clk_mgr_base-&gt;ctx-&gt;asic_id.hw_interna=
l_rev) ||</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
&nbsp;&nbsp;&nbsp;&nbsp;ASICREV_IS_DIMGREY_CAVEFISH_P(clk_mgr_base-&gt;ctx-=
&gt;asic_id.hw_internal_rev) ||</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
&nbsp;&nbsp;&nbsp;&nbsp; ASICREV_IS_BEIGE_GOBY_P(clk_mgr_base-&gt;ctx-&gt;a=
sic_id.hw_internal_rev))</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dcn3_clk_mgr_destroy(clk_m=
gr);<br>
</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
<br>
</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
Alex<br>
</div>
<div id=3D"appendonsend"></div>
<hr style=3D"display:inline-block;width:98%" tabindex=3D"-1">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" st=
yle=3D"font-size:11pt" color=3D"#000000"><b>From:</b> amd-gfx &lt;amd-gfx-b=
ounces@lists.freedesktop.org&gt; on behalf of Qingqing Zhuo &lt;qingqing.zh=
uo@amd.com&gt;<br>
<b>Sent:</b> Friday, November 19, 2021 2:43 PM<br>
<b>To:</b> amd-gfx@lists.freedesktop.org &lt;amd-gfx@lists.freedesktop.org&=
gt;<br>
<b>Cc:</b> Wang, Chao-kai (Stylon) &lt;Stylon.Wang@amd.com&gt;; Cyr, Aric &=
lt;Aric.Cyr@amd.com&gt;; Chiu, Solomon &lt;Solomon.Chiu@amd.com&gt;; Li, Su=
n peng (Leo) &lt;Sunpeng.Li@amd.com&gt;; Wentland, Harry &lt;Harry.Wentland=
@amd.com&gt;; Zhuo, Qingqing (Lillian) &lt;Qingqing.Zhuo@amd.com&gt;;
 Leung, Martin &lt;Martin.Leung@amd.com&gt;; Siqueira, Rodrigo &lt;Rodrigo.=
Siqueira@amd.com&gt;; Li, Roman &lt;Roman.Li@amd.com&gt;; Jacob, Anson &lt;=
Anson.Jacob@amd.com&gt;; Pillai, Aurabindo &lt;Aurabindo.Pillai@amd.com&gt;=
; Lin, Wayne &lt;Wayne.Lin@amd.com&gt;; Lipski, Mikita &lt;Mikita.Lipski@am=
d.com&gt;;
 Lakha, Bhawanpreet &lt;Bhawanpreet.Lakha@amd.com&gt;; Gutierrez, Agustin &=
lt;Agustin.Gutierrez@amd.com&gt;; Kotarac, Pavle &lt;Pavle.Kotarac@amd.com&=
gt;<br>
<b>Subject:</b> [PATCH 14/16] drm/amd/display: add else to avoid double des=
troy clk_mgr</font>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt;=
">
<div class=3D"PlainText">From: Martin Leung &lt;Martin.Leung@amd.com&gt;<br=
>
<br>
[Why &amp; How]<br>
when changing some code we accidentally<br>
changed else if-&gt; if. reverting that.<br>
<br>
Reviewed-by: Aric Cyr &lt;Aric.Cyr@amd.com&gt;<br>
Acked-by: Qingqing Zhuo &lt;qingqing.zhuo@amd.com&gt;<br>
Signed-off-by: Martin Leung &lt;Martin.Leung@amd.com&gt;<br>
---<br>
&nbsp;drivers/gpu/drm/amd/display/dc/clk_mgr/clk_mgr.c | 3 +--<br>
&nbsp;1 file changed, 1 insertion(+), 2 deletions(-)<br>
<br>
diff --git a/drivers/gpu/drm/amd/display/dc/clk_mgr/clk_mgr.c b/drivers/gpu=
/drm/amd/display/dc/clk_mgr/clk_mgr.c<br>
index 26f96ee32472..9200c8ce02ba 100644<br>
--- a/drivers/gpu/drm/amd/display/dc/clk_mgr/clk_mgr.c<br>
+++ b/drivers/gpu/drm/amd/display/dc/clk_mgr/clk_mgr.c<br>
@@ -308,8 +308,7 @@ void dc_destroy_clk_mgr(struct clk_mgr *clk_mgr_base)<b=
r>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case FAMILY_NV:<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; if (ASICREV_IS_SIENNA_CICHLID_P(clk_mgr_base-&gt;ctx-=
&gt;asic_id.hw_internal_rev)) {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dcn3_=
clk_mgr_destroy(clk_mgr);<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; }<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; if (ASICREV_IS_DIMGREY_CAVEFISH_P(clk_mgr_base-&gt;ctx-&gt;asic_=
id.hw_internal_rev)) {<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; } else if (ASICREV_IS_DIMGREY_CAVEFISH_P(clk_mgr_base-&gt;ctx-&g=
t;asic_id.hw_internal_rev)) {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dcn3_=
clk_mgr_destroy(clk_mgr);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; }<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; if (ASICREV_IS_BEIGE_GOBY_P(clk_mgr_base-&gt;ctx-&gt;=
asic_id.hw_internal_rev)) {<br>
-- <br>
2.25.1<br>
<br>
</div>
</span></font></div>
</div>
</body>
</html>

--_000_BL1PR12MB514434CD840471692E9894A2F79F9BL1PR12MB5144namp_--
