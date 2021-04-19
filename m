Return-Path: <SRS0=FsAh=JQ=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.4 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MIME_HTML_MOSTLY,PDS_BAD_THREAD_QP_64,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11D66C433B4
	for <amd-gfx@archiver.kernel.org>; Mon, 19 Apr 2021 15:43:00 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BAE02611F0
	for <amd-gfx@archiver.kernel.org>; Mon, 19 Apr 2021 15:42:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BAE02611F0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6A6DE89F3C;
	Mon, 19 Apr 2021 15:42:59 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2069.outbound.protection.outlook.com [40.107.237.69])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7CDCF89F3C
 for <amd-gfx@lists.freedesktop.org>; Mon, 19 Apr 2021 15:42:58 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JrBynTUNdkgYE68jor1NMY0V587NWgp92mrltdhU4s2ohD5xeW9OwUUT2p4HeAyFQ7RY2KhAfcxZB49dyuqFqtilf0AJtsSpoGMf8qFUEelyBHNmP3/A1PAtse+Aoltbk/toIL8WDXKY2YMYFLZiQrd1CXC5lqF44u0Mkgo4KGsLDbzb+mHIfxS4JaJHAHa/lGC+swcHVxuULmTItPXJN5+o93+9DUhn75hLljLP050FlAMlBoqqiMtYlXTvJZ61eNHXrvaokWtU13zrREkDZwIEYkCsp6R6UFoV5k0uSvgb3SyxSdgjBIuHuzuSZly9Y/QnrdEARCUPNa8hGI3bYw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XAGAWunLIHfimeba7yw/F+GAjTKAwejf94cjo7gszA4=;
 b=jhZl3rbnDeqcFyooiNXo/wAhyYRl07IjL2aa8gOUouW2INUP4WSXQ7j1RUOsAqSmakCasnRgR+aE9RcT5kB4ulYfLpvCqCwQ10dEjETh7YKDdP+XCxsxEpEhaSiM4jdIF67bnzVOaDoJGQ6AfAtQNjDp76suo/ovDqfobhpIXhCEHAGgm00n7saQrWv55ndGhKCLV1omR+cXMzDWEkoybJggZkB/7kR3r7f++tzVX2T6S5cCVT/7VI1VV0nskfuA3ypm8wnY672DSjMmDdg2dGz/J3ZMwnn+kEYFppIaWRwPHFZWWXetcAeHwl4Dwr/yvHEA50/BdY0O6Kw5vAe6CA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XAGAWunLIHfimeba7yw/F+GAjTKAwejf94cjo7gszA4=;
 b=xUBGkkLkIZHSS6Xhp8L9LMgQHOdqsgcdzsCWZJFNtW6nassEYE7Wf13uESyyV3MJc5m37vd4JhUycDO5KofoiopXLRzrx8LV23nrSMhJ5xfDl/grcLOS6QOiFlQhoXHgKQtChfYyDlLfJ+lvkKF554ZiIHHCxMEtMH2Z5ACbhJg=
Received: from CH0PR12MB5284.namprd12.prod.outlook.com (2603:10b6:610:d7::13)
 by CH0PR12MB5187.namprd12.prod.outlook.com (2603:10b6:610:ba::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4042.16; Mon, 19 Apr
 2021 15:42:54 +0000
Received: from CH0PR12MB5284.namprd12.prod.outlook.com
 ([fe80::6c8a:904f:7403:8d60]) by CH0PR12MB5284.namprd12.prod.outlook.com
 ([fe80::6c8a:904f:7403:8d60%5]) with mapi id 15.20.4042.024; Mon, 19 Apr 2021
 15:42:54 +0000
From: "Pillai, Aurabindo" <Aurabindo.Pillai@amd.com>
To: "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Subject: Re: [PATCH 14/19] drm/amd/display: fix HDCP drm prop update for MST
Thread-Topic: [PATCH 14/19] drm/amd/display: fix HDCP drm prop update for MST
Thread-Index: AQHXMs2mmFiTC+dT9kiTkV/qoC5UiKq7/4lx
Date: Mon, 19 Apr 2021 15:42:53 +0000
Message-ID: <CH0PR12MB528457F2643C9A68B6CD21E78B499@CH0PR12MB5284.namprd12.prod.outlook.com>
References: <20210416143417.611019-1-aurabindo.pillai@amd.com>,
 <20210416143417.611019-15-aurabindo.pillai@amd.com>
In-Reply-To: <20210416143417.611019-15-aurabindo.pillai@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Enabled=True;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SetDate=2021-04-19T15:42:53.576Z;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Name=Internal
 Distribution
 Only; MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ContentBits=0;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Method=Standard; 
authentication-results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
x-originating-ip: [165.204.55.250]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 5e865da8-fc2d-4967-8970-08d90349cc0f
x-ms-traffictypediagnostic: CH0PR12MB5187:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <CH0PR12MB5187221C0C48085571EFDE458B499@CH0PR12MB5187.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:172;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: cx9rC3hHTc3pi0kJKbpy5vRpEsFk6Sh4RN04uyVzO7y0q5pssNX/JN8lSO9/rOFvcy12yElR9nLwwwodWQkBUBZM+XeNnv00qi61bUSvrBJdaxv0hzr0I5O9gj7vGn+MNxdgLIBDCeWVKTGsofhBkoUVKkcdvafFtno3bEH60pkOS3eiWFLo1HDWgm4cMbLwX+mMnJqO4kh8X7hcuQXyRKSojIkRT/jbBNoJOtL5wqG2W8Hhu8tLUS23PcdZYvKVtGwiA2h3xzzGdX91COQEP9aMgh0814yhjUP+ywDqL4kTxZ6qCHAS0ELH+yYMVX62pgICQzf1uHdAclUjSceS1Z0wTMSwYBRnc5Mva3A8+h7LzzISkvvufv08EeQ/+bCye+YP3KHc/MVe/oUw1sXI5noGsAZW3LjSN8pD69VWYWU37OYpZQ9aVWlkWWqcQ7oooxGbgZbxEI48r3oWAd8J36Q/ZyuPRGJtC0sLjecVdZ+fvTzNS9r+b4FVM15oqQqJN3SRoTPxoDUbdp2NVcKkqiWq9aDLWBTJNFTTjMQ8Nw2flB6oBEOgmUEyL8ux31OP8CDRdaIWF+XIpnwKCBTaLO+GqgPPfD/V6ohEkYjVSxY=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH0PR12MB5284.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(136003)(346002)(376002)(396003)(39860400002)(83380400001)(38100700002)(66556008)(53546011)(7696005)(30864003)(66446008)(66946007)(478600001)(91956017)(66476007)(8676002)(6506007)(64756008)(76116006)(8936002)(52536014)(5660300002)(19627405001)(9686003)(122000001)(316002)(33656002)(2906002)(15650500001)(54906003)(26005)(71200400001)(86362001)(55016002)(6916009)(186003)(4326008);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?i0Km32LApTKIKCkhcV7znDaPcqcScJBuz202JcueNh/w7IJdGfUAOtplEbeI?=
 =?us-ascii?Q?ViFBwYhYN2+dafEEgqfyrfb4KMIF9cfVJSufHdZSQS2iW71TzkK64KDC12Wl?=
 =?us-ascii?Q?t4SgblqZcaNxiSX0Uco6Sf7aovM/qAzaMzUBnxB2Pznku6tHhDowfUWE0bru?=
 =?us-ascii?Q?1ohxRxoEXpA5og4EwZtwUAWsDSU89RHZGqxZhFDLmXfe+knGsu8WAZ2EXYI8?=
 =?us-ascii?Q?HCpRB5piGSBkPDdBNk9NT06cHNQZAOYdJB1HjE5da9dYYEqPq4COgNVoWFv1?=
 =?us-ascii?Q?MNr2x1k9OM0khfrmE5KwUvvqxSxavs3iHg9+KA2Rw4eTQklONpGmQveyGdzH?=
 =?us-ascii?Q?czITxpTlojbSrmyllgf6TU64Y5YFd8AdIH0tR5+iL6rfe9Ze1ybO1Dix7GrV?=
 =?us-ascii?Q?+hJCHBgwba/kyCSf07X+l6ZOzeuERaRB7yAWWHP0rYYaU7A6AEPHxu4Rq181?=
 =?us-ascii?Q?StofDl6h5P+elBvWSHKFloBp8tDwWAoQhqYHnu+ckOzd/SEyra3E9Wzzc4bP?=
 =?us-ascii?Q?NmuucoiUklLfjj8VKpbcc7OApbbdvAUXUFpXefhNXuULQA4t65bDW1JKGoHd?=
 =?us-ascii?Q?jIRgIq/VMbwERwFlwdtXVpikmHl499bZ59AELJ4sMXWXQ0rCMRRR9dLEJ/5P?=
 =?us-ascii?Q?pKnxkY693Mruk8+pxSI+kRWSxloSj107p6ejDQbAZqNKy/2QlyAxZ7l+4ygK?=
 =?us-ascii?Q?KyUPNh48vwL82JuDfIbLo3D4riHMbbolPJZSFUirw59t/+hm2Do9uGinxrRp?=
 =?us-ascii?Q?uirYbDkOB9mOLNv0nVLwzaixQa1i48jspzQ6logZ8jCw4/a9nRuPiRf1TDJ7?=
 =?us-ascii?Q?NGc853e5GkFtCe+XXant3K+oBNjnSQVKl23ppCNDz5JJ45O4C6bhbtuphDNH?=
 =?us-ascii?Q?Ldgf8I4N/OrIVhF+kpzArbxAb/Lpf9Ci+c4A2XUNEAfmbaH+1MDVmgT4Mlmc?=
 =?us-ascii?Q?6VhxKj3HNeTWbbjc1UwqE4IlG2GCjJ/jMTwMXnm/rJ9QKyzLJrC0Iwv0pOkH?=
 =?us-ascii?Q?pHg7ozqr0lUhZlPPV0UTokdLIWAyfuO3czgLQqqFRVQWSs+0WxV4Ta6+3/Xq?=
 =?us-ascii?Q?SRmkr9zT9JYHuJT3NWV64yVpyy352nXBosynF9fdzUNZ6Upbc1ukN74xI2vc?=
 =?us-ascii?Q?KFAsk5UmAWIH1kklb9omjor5mlC0x8Quf8/mSwoxyIYMKc9U1ehdw8C3yxN9?=
 =?us-ascii?Q?C7pO4NfOTcz+i+WlCCdC1zhmsezls2RJxkMoIzqYmjvHp3BBuD5KabmNAAgf?=
 =?us-ascii?Q?DBdK/k8IqUaRfZDBLnAbfLGSUULvJES45vH8ihaDUxoGvtcZFHamTkqMyncK?=
 =?us-ascii?Q?uNxfahjQN6fMhUT+wCPoWZNO?=
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH0PR12MB5284.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5e865da8-fc2d-4967-8970-08d90349cc0f
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Apr 2021 15:42:53.9109 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: St3cW00ebH9JBvDP5IooWvfFOsXKZ0Sx4wcAp9M1q8vQKEpWdcxvquhsXhwn0tkJ/uaExcPgCUB1YHTwgWBxWA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR12MB5187
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
Cc: "Zhang, Dingchen \(David\)" <Dingchen.Zhang@amd.com>, "Brol,
 Eryk" <Eryk.Brol@amd.com>, "Li, Sun peng \(Leo\)" <Sunpeng.Li@amd.com>,
 "Wentland, Harry" <Harry.Wentland@amd.com>, "Zhuo,
 Qingqing" <Qingqing.Zhuo@amd.com>, "Siqueira,
 Rodrigo" <Rodrigo.Siqueira@amd.com>, "Jacob, Anson" <Anson.Jacob@amd.com>,
 "Lakha, Bhawanpreet" <Bhawanpreet.Lakha@amd.com>, "R, Bindu" <Bindu.R@amd.com>
Content-Type: multipart/mixed; boundary="===============0361578157=="
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--===============0361578157==
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_CH0PR12MB528457F2643C9A68B6CD21E78B499CH0PR12MB5284namp_"

--_000_CH0PR12MB528457F2643C9A68B6CD21E78B499CH0PR12MB5284namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

[AMD Official Use Only - Internal Distribution Only]

This patch is a related change for the MST null pointer deref regression, s=
o will be dropped.

--

Thanks & Regards,
Aurabindo Pillai
________________________________
From: Aurabindo Pillai <aurabindo.pillai@amd.com>
Sent: Friday, April 16, 2021 10:34 AM
To: amd-gfx@lists.freedesktop.org <amd-gfx@lists.freedesktop.org>
Cc: Wentland, Harry <Harry.Wentland@amd.com>; Li, Sun peng (Leo) <Sunpeng.L=
i@amd.com>; Lakha, Bhawanpreet <Bhawanpreet.Lakha@amd.com>; Siqueira, Rodri=
go <Rodrigo.Siqueira@amd.com>; Pillai, Aurabindo <Aurabindo.Pillai@amd.com>=
; Zhuo, Qingqing <Qingqing.Zhuo@amd.com>; Brol, Eryk <Eryk.Brol@amd.com>; R=
, Bindu <Bindu.R@amd.com>; Jacob, Anson <Anson.Jacob@amd.com>; Zhang, Dingc=
hen (David) <Dingchen.Zhang@amd.com>; Zhang, Dingchen (David) <Dingchen.Zha=
ng@amd.com>
Subject: [PATCH 14/19] drm/amd/display: fix HDCP drm prop update for MST

From: "Dingchen (David) Zhang" <dingchen.zhang@amd.com>

[why]
For MST topology with 1 physical link and multiple connectors (>=3D2),
e.g. daisy cahined MST + SST, or 1-to-multi MST hub, if userspace
set to enable the HDCP simultaneously on all connected outputs, the
commit tail iteratively call the hdcp_update_display() for each
display (connector). However, the hdcp workqueue data structure for
each link has only one DM connector and encryption status members,
which means the work queue of property_validate/update() would only
be triggered for the last connector within this physical link, and
therefore the HDCP property value of other connectors would stay on
DESIRED instead of switching to ENABLED, which is NOT as expected.

[how]
Use array of MAX_NUM_OF_DISPLAY for both aconnector and encryption
status in hdcp workqueue data structure for each physical link.
For property validate/update work queue, we iterates over the array
and do similar operation/check for each connected display.

Signed-off-by: Dingchen (David) Zhang <dingchen.zhang@amd.com>
Reviewed-by: Dingchen Zhang <Dingchen.Zhang@amd.com>
Acked-by: Aurabindo Pillai <aurabindo.pillai@amd.com>
---
 .../amd/display/amdgpu_dm/amdgpu_dm_hdcp.c    | 109 +++++++++++++-----
 .../amd/display/amdgpu_dm/amdgpu_dm_hdcp.h    |   6 +-
 2 files changed, 81 insertions(+), 34 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_hdcp.c b/drive=
rs/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_hdcp.c
index 50f6b3a86931..2ec076af9e89 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_hdcp.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_hdcp.c
@@ -171,9 +171,10 @@ void hdcp_update_display(struct hdcp_workqueue *hdcp_w=
ork,
         struct mod_hdcp_display *display =3D &hdcp_work[link_index].displa=
y;
         struct mod_hdcp_link *link =3D &hdcp_work[link_index].link;
         struct mod_hdcp_display_query query;
+       unsigned int conn_index =3D aconnector->base.index;

         mutex_lock(&hdcp_w->mutex);
-       hdcp_w->aconnector =3D aconnector;
+       hdcp_w->aconnector[conn_index] =3D aconnector;

         query.display =3D NULL;
         mod_hdcp_query_display(&hdcp_w->hdcp, aconnector->base.index, &que=
ry);
@@ -205,7 +206,7 @@ void hdcp_update_display(struct hdcp_workqueue *hdcp_wo=
rk,
                                               msecs_to_jiffies(DRM_HDCP_CH=
ECK_PERIOD_MS));
                 } else {
                         display->adjust.disable =3D MOD_HDCP_DISPLAY_DISAB=
LE_AUTHENTICATION;
-                       hdcp_w->encryption_status =3D MOD_HDCP_ENCRYPTION_S=
TATUS_HDCP_OFF;
+                       hdcp_w->encryption_status[conn_index] =3D MOD_HDCP_=
ENCRYPTION_STATUS_HDCP_OFF;
                         cancel_delayed_work(&hdcp_w->property_validate_dwo=
rk);
                 }

@@ -224,9 +225,10 @@ static void hdcp_remove_display(struct hdcp_workqueue =
*hdcp_work,
 {
         struct hdcp_workqueue *hdcp_w =3D &hdcp_work[link_index];
         struct drm_connector_state *conn_state =3D aconnector->base.state;
+       unsigned int conn_index =3D aconnector->base.index;

         mutex_lock(&hdcp_w->mutex);
-       hdcp_w->aconnector =3D aconnector;
+       hdcp_w->aconnector[conn_index] =3D aconnector;

         /* the removal of display will invoke auth reset -> hdcp destroy a=
nd
          * we'd expect the CP prop changed back to DESIRED if at the time =
ENABLED.
@@ -247,13 +249,16 @@ static void hdcp_remove_display(struct hdcp_workqueue=
 *hdcp_work,
 void hdcp_reset_display(struct hdcp_workqueue *hdcp_work, unsigned int lin=
k_index)
 {
         struct hdcp_workqueue *hdcp_w =3D &hdcp_work[link_index];
+       unsigned int conn_index;

         mutex_lock(&hdcp_w->mutex);

         mod_hdcp_reset_connection(&hdcp_w->hdcp,  &hdcp_w->output);

         cancel_delayed_work(&hdcp_w->property_validate_dwork);
-       hdcp_w->encryption_status =3D MOD_HDCP_ENCRYPTION_STATUS_HDCP_OFF;
+
+       for (conn_index =3D 0; conn_index < MAX_NUM_OF_DISPLAYS; ++conn_ind=
ex)
+               hdcp_w->encryption_status[conn_index] =3D MOD_HDCP_ENCRYPTI=
ON_STATUS_HDCP_OFF;

         process_output(hdcp_w);

@@ -290,38 +295,67 @@ static void event_callback(struct work_struct *work)


 }
+
+static struct amdgpu_dm_connector *find_first_connected_output(struct hdcp=
_workqueue *hdcp_work)
+{
+       unsigned int conn_index;
+
+       for (conn_index =3D 0; conn_index < MAX_NUM_OF_DISPLAYS; ++conn_ind=
ex) {
+               if (hdcp_work->aconnector[conn_index])
+                       return hdcp_work->aconnector[conn_index];
+       }
+
+       return NULL;
+}
+
 static void event_property_update(struct work_struct *work)
 {

         struct hdcp_workqueue *hdcp_work =3D container_of(work, struct hdc=
p_workqueue, property_update_work);
-       struct amdgpu_dm_connector *aconnector =3D hdcp_work->aconnector;
-       struct drm_device *dev =3D hdcp_work->aconnector->base.dev;
+       struct amdgpu_dm_connector *aconnector =3D find_first_connected_out=
put(hdcp_work);
+       struct drm_device *dev;
         long ret;
+       unsigned int conn_index;
+       struct drm_connector *connector;
+       struct drm_connector_state *conn_state;
+
+       if (!aconnector)
+               return;
+
+       dev =3D aconnector->base.dev;

         drm_modeset_lock(&dev->mode_config.connection_mutex, NULL);
         mutex_lock(&hdcp_work->mutex);

+       for (conn_index =3D 0; conn_index < MAX_NUM_OF_DISPLAYS; ++conn_ind=
ex) {
+               aconnector =3D hdcp_work->aconnector[conn_index];
+
+               if (!aconnector)
+                       continue;

-       if (aconnector->base.state->commit) {
-               ret =3D wait_for_completion_interruptible_timeout(&aconnect=
or->base.state->commit->hw_done, 10 * HZ);
+               connector =3D &aconnector->base;
+               conn_state =3D aconnector->base.state;
+               if (conn_state->commit) {
+                       ret =3D wait_for_completion_interruptible_timeout(&=
conn_state->commit->hw_done, 10 * HZ);

-               if (ret =3D=3D 0) {
-                       DRM_ERROR("HDCP state unknown! Setting it to DESIRE=
D");
-                       hdcp_work->encryption_status =3D MOD_HDCP_ENCRYPTIO=
N_STATUS_HDCP_OFF;
+                       if (ret =3D=3D 0) {
+                               DRM_ERROR("HDCP state unknown! Setting it t=
o DESIRED");
+                               hdcp_work->encryption_status[conn_index] =
=3D MOD_HDCP_ENCRYPTION_STATUS_HDCP_OFF;
+                       }
                 }
-       }

-       if (hdcp_work->encryption_status !=3D MOD_HDCP_ENCRYPTION_STATUS_HD=
CP_OFF) {
-               if (aconnector->base.state->hdcp_content_type =3D=3D DRM_MO=
DE_HDCP_CONTENT_TYPE0 &&
-                   hdcp_work->encryption_status <=3D MOD_HDCP_ENCRYPTION_S=
TATUS_HDCP2_TYPE0_ON)
-                       drm_hdcp_update_content_protection(&aconnector->bas=
e, DRM_MODE_CONTENT_PROTECTION_ENABLED);
-               else if (aconnector->base.state->hdcp_content_type =3D=3D D=
RM_MODE_HDCP_CONTENT_TYPE1 &&
-                        hdcp_work->encryption_status =3D=3D MOD_HDCP_ENCRY=
PTION_STATUS_HDCP2_TYPE1_ON)
-                       drm_hdcp_update_content_protection(&aconnector->bas=
e, DRM_MODE_CONTENT_PROTECTION_ENABLED);
-       } else {
-               drm_hdcp_update_content_protection(&aconnector->base, DRM_M=
ODE_CONTENT_PROTECTION_DESIRED);
-       }
+               if (hdcp_work->encryption_status[conn_index] !=3D MOD_HDCP_=
ENCRYPTION_STATUS_HDCP_OFF) {
+                       if (conn_state->hdcp_content_type =3D=3D DRM_MODE_H=
DCP_CONTENT_TYPE0 &&
+                           hdcp_work->encryption_status[conn_index] <=3D M=
OD_HDCP_ENCRYPTION_STATUS_HDCP2_TYPE0_ON)
+                               drm_hdcp_update_content_protection(connecto=
r, DRM_MODE_CONTENT_PROTECTION_ENABLED);
+                       else if (conn_state->hdcp_content_type =3D=3D DRM_M=
ODE_HDCP_CONTENT_TYPE1 &&
+                                hdcp_work->encryption_status[conn_index] =
=3D=3D MOD_HDCP_ENCRYPTION_STATUS_HDCP2_TYPE1_ON)
+                               drm_hdcp_update_content_protection(connecto=
r, DRM_MODE_CONTENT_PROTECTION_ENABLED);
+               } else {
+                       drm_hdcp_update_content_protection(connector, DRM_M=
ODE_CONTENT_PROTECTION_DESIRED);
+               }

+       }

         mutex_unlock(&hdcp_work->mutex);
         drm_modeset_unlock(&dev->mode_config.connection_mutex);
@@ -332,19 +366,28 @@ static void event_property_validate(struct work_struc=
t *work)
         struct hdcp_workqueue *hdcp_work =3D
                 container_of(to_delayed_work(work), struct hdcp_workqueue,=
 property_validate_dwork);
         struct mod_hdcp_display_query query;
-       struct amdgpu_dm_connector *aconnector =3D hdcp_work->aconnector;
-
-       if (!aconnector)
-               return;
+       struct amdgpu_dm_connector *aconnector;
+       unsigned int conn_index;

         mutex_lock(&hdcp_work->mutex);

-       query.encryption_status =3D MOD_HDCP_ENCRYPTION_STATUS_HDCP_OFF;
-       mod_hdcp_query_display(&hdcp_work->hdcp, aconnector->base.index, &q=
uery);
+       for (conn_index =3D 0; conn_index < MAX_NUM_OF_DISPLAYS; ++conn_ind=
ex) {
+               aconnector =3D hdcp_work->aconnector[conn_index];
+
+               if (!aconnector)
+                       continue;
+
+               query.encryption_status =3D MOD_HDCP_ENCRYPTION_STATUS_HDCP=
_OFF;
+               mod_hdcp_query_display(&hdcp_work->hdcp, aconnector->base.i=
ndex, &query);

-       if (query.encryption_status !=3D hdcp_work->encryption_status) {
-               hdcp_work->encryption_status =3D query.encryption_status;
-               schedule_work(&hdcp_work->property_update_work);
+               pr_debug("[HDCP_DM] display %d, CP %u, (query->enc_st, work=
->enc_st): (%d, %d)\n",
+                        aconnector->base.index, aconnector->base.state->co=
ntent_protection,
+                        query.encryption_status, hdcp_work->encryption_sta=
tus[conn_index]);
+
+               if (query.encryption_status !=3D hdcp_work->encryption_stat=
us[conn_index]) {
+                       hdcp_work->encryption_status[conn_index] =3D query.=
encryption_status;
+                       schedule_work(&hdcp_work->property_update_work);
+               }
         }

         mutex_unlock(&hdcp_work->mutex);
@@ -655,6 +698,10 @@ struct hdcp_workqueue *hdcp_create_workqueue(struct am=
dgpu_device *adev, struct
                 hdcp_work[i].hdcp.config.ddc.funcs.read_i2c =3D lp_read_i2=
c;
                 hdcp_work[i].hdcp.config.ddc.funcs.write_dpcd =3D lp_write=
_dpcd;
                 hdcp_work[i].hdcp.config.ddc.funcs.read_dpcd =3D lp_read_d=
pcd;
+
+               memset(hdcp_work[i].aconnector, 0, sizeof(struct amdgpu_dm_=
connector *) * MAX_NUM_OF_DISPLAYS);
+               memset(hdcp_work[i].encryption_status, 0,
+                       sizeof(enum mod_hdcp_encryption_status) * MAX_NUM_O=
F_DISPLAYS);
         }

         cp_psp->funcs.update_stream_config =3D update_config;
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_hdcp.h b/drive=
rs/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_hdcp.h
index 09294ff122fe..570863160d60 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_hdcp.h
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_hdcp.h
@@ -1,5 +1,5 @@
 /*
- * Copyright 2019 Advanced Micro Devices, Inc.
+ * Copyright (C) 2019-2020 Advanced Micro Devices, Inc. All rights reserve=
d.
  *
  * Permission is hereby granted, free of charge, to any person obtaining a
  * copy of this software and associated documentation files (the "Software=
"),
@@ -43,7 +43,7 @@ struct hdcp_workqueue {
         struct delayed_work callback_dwork;
         struct delayed_work watchdog_timer_dwork;
         struct delayed_work property_validate_dwork;
-       struct amdgpu_dm_connector *aconnector;
+       struct amdgpu_dm_connector *aconnector[MAX_NUM_OF_DISPLAYS];
         struct mutex mutex;

         struct mod_hdcp hdcp;
@@ -51,7 +51,7 @@ struct hdcp_workqueue {
         struct mod_hdcp_display display;
         struct mod_hdcp_link link;

-       enum mod_hdcp_encryption_status encryption_status;
+       enum mod_hdcp_encryption_status encryption_status[MAX_NUM_OF_DISPLA=
YS];
         uint8_t max_link;

         uint8_t *srm;
--
2.31.1


--_000_CH0PR12MB528457F2643C9A68B6CD21E78B499CH0PR12MB5284namp_
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
<p style=3D"font-family:Arial;font-size:11pt;color:#0078D7;margin:5pt;" ali=
gn=3D"Left">
[AMD Official Use Only - Internal Distribution Only]<br>
</p>
<br>
<div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0); background-color: rgb(255, 255, 255);">
This patch is a related change for the MST null pointer deref regression, s=
o will be dropped.<br>
</div>
<div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
<br>
</div>
<div id=3D"Signature">
<div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
--</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
<br>
</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
Thanks &amp; Regards,</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
Aurabindo Pillai<br>
</div>
</div>
</div>
</div>
<div id=3D"appendonsend"></div>
<hr style=3D"display:inline-block;width:98%" tabindex=3D"-1">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" st=
yle=3D"font-size:11pt" color=3D"#000000"><b>From:</b> Aurabindo Pillai &lt;=
aurabindo.pillai@amd.com&gt;<br>
<b>Sent:</b> Friday, April 16, 2021 10:34 AM<br>
<b>To:</b> amd-gfx@lists.freedesktop.org &lt;amd-gfx@lists.freedesktop.org&=
gt;<br>
<b>Cc:</b> Wentland, Harry &lt;Harry.Wentland@amd.com&gt;; Li, Sun peng (Le=
o) &lt;Sunpeng.Li@amd.com&gt;; Lakha, Bhawanpreet &lt;Bhawanpreet.Lakha@amd=
.com&gt;; Siqueira, Rodrigo &lt;Rodrigo.Siqueira@amd.com&gt;; Pillai, Aurab=
indo &lt;Aurabindo.Pillai@amd.com&gt;; Zhuo, Qingqing &lt;Qingqing.Zhuo@amd=
.com&gt;;
 Brol, Eryk &lt;Eryk.Brol@amd.com&gt;; R, Bindu &lt;Bindu.R@amd.com&gt;; Ja=
cob, Anson &lt;Anson.Jacob@amd.com&gt;; Zhang, Dingchen (David) &lt;Dingche=
n.Zhang@amd.com&gt;; Zhang, Dingchen (David) &lt;Dingchen.Zhang@amd.com&gt;=
<br>
<b>Subject:</b> [PATCH 14/19] drm/amd/display: fix HDCP drm prop update for=
 MST</font>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt;=
">
<div class=3D"PlainText">From: &quot;Dingchen (David) Zhang&quot; &lt;dingc=
hen.zhang@amd.com&gt;<br>
<br>
[why]<br>
For MST topology with 1 physical link and multiple connectors (&gt;=3D2),<b=
r>
e.g. daisy cahined MST + SST, or 1-to-multi MST hub, if userspace<br>
set to enable the HDCP simultaneously on all connected outputs, the<br>
commit tail iteratively call the hdcp_update_display() for each<br>
display (connector). However, the hdcp workqueue data structure for<br>
each link has only one DM connector and encryption status members,<br>
which means the work queue of property_validate/update() would only<br>
be triggered for the last connector within this physical link, and<br>
therefore the HDCP property value of other connectors would stay on<br>
DESIRED instead of switching to ENABLED, which is NOT as expected.<br>
<br>
[how]<br>
Use array of MAX_NUM_OF_DISPLAY for both aconnector and encryption<br>
status in hdcp workqueue data structure for each physical link.<br>
For property validate/update work queue, we iterates over the array<br>
and do similar operation/check for each connected display.<br>
<br>
Signed-off-by: Dingchen (David) Zhang &lt;dingchen.zhang@amd.com&gt;<br>
Reviewed-by: Dingchen Zhang &lt;Dingchen.Zhang@amd.com&gt;<br>
Acked-by: Aurabindo Pillai &lt;aurabindo.pillai@amd.com&gt;<br>
---<br>
&nbsp;.../amd/display/amdgpu_dm/amdgpu_dm_hdcp.c&nbsp;&nbsp;&nbsp; | 109 ++=
+++++++++++-----<br>
&nbsp;.../amd/display/amdgpu_dm/amdgpu_dm_hdcp.h&nbsp;&nbsp;&nbsp; |&nbsp;&=
nbsp; 6 +-<br>
&nbsp;2 files changed, 81 insertions(+), 34 deletions(-)<br>
<br>
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_hdcp.c b/drive=
rs/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_hdcp.c<br>
index 50f6b3a86931..2ec076af9e89 100644<br>
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_hdcp.c<br>
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_hdcp.c<br>
@@ -171,9 +171,10 @@ void hdcp_update_display(struct hdcp_workqueue *hdcp_w=
ork,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct mod_hdcp_display *d=
isplay =3D &amp;hdcp_work[link_index].display;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct mod_hdcp_link *link=
 =3D &amp;hdcp_work[link_index].link;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct mod_hdcp_display_qu=
ery query;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; unsigned int conn_index =3D aconnecto=
r-&gt;base.index;<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mutex_lock(&amp;hdcp_w-&gt=
;mutex);<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; hdcp_w-&gt;aconnector =3D aconnector;=
<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; hdcp_w-&gt;aconnector[conn_index] =3D=
 aconnector;<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; query.display =3D NULL;<br=
>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mod_hdcp_query_display(&am=
p;hdcp_w-&gt;hdcp, aconnector-&gt;base.index, &amp;query);<br>
@@ -205,7 +206,7 @@ void hdcp_update_display(struct hdcp_workqueue *hdcp_wo=
rk,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; msecs_to_jiffies(DRM_HD=
CP_CHECK_PERIOD_MS));<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; } else {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; displ=
ay-&gt;adjust.disable =3D MOD_HDCP_DISPLAY_DISABLE_AUTHENTICATION;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; hdcp_w-&gt;encry=
ption_status =3D MOD_HDCP_ENCRYPTION_STATUS_HDCP_OFF;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; hdcp_w-&gt;encry=
ption_status[conn_index] =3D MOD_HDCP_ENCRYPTION_STATUS_HDCP_OFF;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; cance=
l_delayed_work(&amp;hdcp_w-&gt;property_validate_dwork);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; }<br>
&nbsp;<br>
@@ -224,9 +225,10 @@ static void hdcp_remove_display(struct hdcp_workqueue =
*hdcp_work,<br>
&nbsp;{<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct hdcp_workqueue *hdc=
p_w =3D &amp;hdcp_work[link_index];<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct drm_connector_state=
 *conn_state =3D aconnector-&gt;base.state;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; unsigned int conn_index =3D aconnecto=
r-&gt;base.index;<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mutex_lock(&amp;hdcp_w-&gt=
;mutex);<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; hdcp_w-&gt;aconnector =3D aconnector;=
<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; hdcp_w-&gt;aconnector[conn_index] =3D=
 aconnector;<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* the removal of display =
will invoke auth reset -&gt; hdcp destroy and<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * we'd expect the CP=
 prop changed back to DESIRED if at the time ENABLED.<br>
@@ -247,13 +249,16 @@ static void hdcp_remove_display(struct hdcp_workqueue=
 *hdcp_work,<br>
&nbsp;void hdcp_reset_display(struct hdcp_workqueue *hdcp_work, unsigned in=
t link_index)<br>
&nbsp;{<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct hdcp_workqueue *hdc=
p_w =3D &amp;hdcp_work[link_index];<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; unsigned int conn_index;<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mutex_lock(&amp;hdcp_w-&gt=
;mutex);<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mod_hdcp_reset_connection(=
&amp;hdcp_w-&gt;hdcp,&nbsp; &amp;hdcp_w-&gt;output);<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; cancel_delayed_work(&amp;h=
dcp_w-&gt;property_validate_dwork);<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; hdcp_w-&gt;encryption_status =3D MOD_=
HDCP_ENCRYPTION_STATUS_HDCP_OFF;<br>
+<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; for (conn_index =3D 0; conn_index &lt=
; MAX_NUM_OF_DISPLAYS; ++conn_index)<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; hdcp_w-&gt;encryption_status[conn_index] =3D MOD_HDCP_ENCRYPTION=
_STATUS_HDCP_OFF;<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; process_output(hdcp_w);<br=
>
&nbsp;<br>
@@ -290,38 +295,67 @@ static void event_callback(struct work_struct *work)<=
br>
&nbsp;<br>
&nbsp;<br>
&nbsp;}<br>
+<br>
+static struct amdgpu_dm_connector *find_first_connected_output(struct hdcp=
_workqueue *hdcp_work)<br>
+{<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; unsigned int conn_index;<br>
+<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; for (conn_index =3D 0; conn_index &lt=
; MAX_NUM_OF_DISPLAYS; ++conn_index) {<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; if (hdcp_work-&gt;aconnector[conn_index])<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return hdcp_work=
-&gt;aconnector[conn_index];<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
+<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return NULL;<br>
+}<br>
+<br>
&nbsp;static void event_property_update(struct work_struct *work)<br>
&nbsp;{<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct hdcp_workqueue *hdc=
p_work =3D container_of(work, struct hdcp_workqueue, property_update_work);=
<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_dm_connector *aconnecto=
r =3D hdcp_work-&gt;aconnector;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct drm_device *dev =3D hdcp_work-=
&gt;aconnector-&gt;base.dev;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_dm_connector *aconnecto=
r =3D find_first_connected_output(hdcp_work);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct drm_device *dev;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; long ret;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; unsigned int conn_index;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct drm_connector *connector;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct drm_connector_state *conn_stat=
e;<br>
+<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!aconnector)<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; return;<br>
+<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dev =3D aconnector-&gt;base.dev;<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; drm_modeset_lock(&amp;dev-=
&gt;mode_config.connection_mutex, NULL);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mutex_lock(&amp;hdcp_work-=
&gt;mutex);<br>
&nbsp;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; for (conn_index =3D 0; conn_index &lt=
; MAX_NUM_OF_DISPLAYS; ++conn_index) {<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; aconnector =3D hdcp_work-&gt;aconnector[conn_index];<br>
+<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; if (!aconnector)<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; continue;<br>
&nbsp;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (aconnector-&gt;base.state-&gt;com=
mit) {<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; ret =3D wait_for_completion_interruptible_timeout(&amp;aconnecto=
r-&gt;base.state-&gt;commit-&gt;hw_done, 10 * HZ);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; connector =3D &amp;aconnector-&gt;base;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; conn_state =3D aconnector-&gt;base.state;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; if (conn_state-&gt;commit) {<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ret =3D wait_for=
_completion_interruptible_timeout(&amp;conn_state-&gt;commit-&gt;hw_done, 1=
0 * HZ);<br>
&nbsp;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; if (ret =3D=3D 0) {<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; DRM_ERROR(&quot;=
HDCP state unknown! Setting it to DESIRED&quot;);<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; hdcp_work-&gt;en=
cryption_status =3D MOD_HDCP_ENCRYPTION_STATUS_HDCP_OFF;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (ret =3D=3D 0=
) {<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; DRM_ERROR(&quot;HDCP state unknown! Setting=
 it to DESIRED&quot;);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; hdcp_work-&gt;encryption_status[conn_index]=
 =3D MOD_HDCP_ENCRYPTION_STATUS_HDCP_OFF;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; }<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&nbsp;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (hdcp_work-&gt;encryption_status !=
=3D MOD_HDCP_ENCRYPTION_STATUS_HDCP_OFF) {<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; if (aconnector-&gt;base.state-&gt;hdcp_content_type =3D=3D DRM_M=
ODE_HDCP_CONTENT_TYPE0 &amp;&amp;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; hdcp_work-&gt;encryption_status &lt;=3D =
MOD_HDCP_ENCRYPTION_STATUS_HDCP2_TYPE0_ON)<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; drm_hdcp_update_=
content_protection(&amp;aconnector-&gt;base, DRM_MODE_CONTENT_PROTECTION_EN=
ABLED);<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; else if (aconnector-&gt;base.state-&gt;hdcp_content_type =3D=3D =
DRM_MODE_HDCP_CONTENT_TYPE1 &amp;&amp;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; hdcp_work-=
&gt;encryption_status =3D=3D MOD_HDCP_ENCRYPTION_STATUS_HDCP2_TYPE1_ON)<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; drm_hdcp_update_=
content_protection(&amp;aconnector-&gt;base, DRM_MODE_CONTENT_PROTECTION_EN=
ABLED);<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; } else {<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; drm_hdcp_update_content_protection(&amp;aconnector-&gt;base, DRM=
_MODE_CONTENT_PROTECTION_DESIRED);<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; if (hdcp_work-&gt;encryption_status[conn_index] !=3D MOD_HDCP_EN=
CRYPTION_STATUS_HDCP_OFF) {<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (conn_state-&=
gt;hdcp_content_type =3D=3D DRM_MODE_HDCP_CONTENT_TYPE0 &amp;&amp;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp; hdcp_work-&gt;encryption_status[conn_index] &lt;=3D MOD_HDCP_ENCRYP=
TION_STATUS_HDCP2_TYPE0_ON)<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; drm_hdcp_update_content_protection(connecto=
r, DRM_MODE_CONTENT_PROTECTION_ENABLED);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; else if (conn_st=
ate-&gt;hdcp_content_type =3D=3D DRM_MODE_HDCP_CONTENT_TYPE1 &amp;&amp;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; hdcp_work-&gt;encryption_status[conn_=
index] =3D=3D MOD_HDCP_ENCRYPTION_STATUS_HDCP2_TYPE1_ON)<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; drm_hdcp_update_content_protection(connecto=
r, DRM_MODE_CONTENT_PROTECTION_ENABLED);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; } else {<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; drm_hdcp_update_=
content_protection(connector, DRM_MODE_CONTENT_PROTECTION_DESIRED);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; }<br>
&nbsp;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mutex_unlock(&amp;hdcp_wor=
k-&gt;mutex);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; drm_modeset_unlock(&amp;de=
v-&gt;mode_config.connection_mutex);<br>
@@ -332,19 +366,28 @@ static void event_property_validate(struct work_struc=
t *work)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct hdcp_workqueue *hdc=
p_work =3D<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; container_of(to_delayed_work(work), struct hdcp_workq=
ueue, property_validate_dwork);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct mod_hdcp_display_qu=
ery query;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_dm_connector *aconnecto=
r =3D hdcp_work-&gt;aconnector;<br>
-<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!aconnector)<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; return;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_dm_connector *aconnecto=
r;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; unsigned int conn_index;<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mutex_lock(&amp;hdcp_work-=
&gt;mutex);<br>
&nbsp;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; query.encryption_status =3D MOD_HDCP_=
ENCRYPTION_STATUS_HDCP_OFF;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mod_hdcp_query_display(&amp;hdcp_work=
-&gt;hdcp, aconnector-&gt;base.index, &amp;query);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; for (conn_index =3D 0; conn_index &lt=
; MAX_NUM_OF_DISPLAYS; ++conn_index) {<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; aconnector =3D hdcp_work-&gt;aconnector[conn_index];<br>
+<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; if (!aconnector)<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; continue;<br>
+<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; query.encryption_status =3D MOD_HDCP_ENCRYPTION_STATUS_HDCP_OFF;=
<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; mod_hdcp_query_display(&amp;hdcp_work-&gt;hdcp, aconnector-&gt;b=
ase.index, &amp;query);<br>
&nbsp;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (query.encryption_status !=3D hdcp=
_work-&gt;encryption_status) {<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; hdcp_work-&gt;encryption_status =3D query.encryption_status;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; schedule_work(&amp;hdcp_work-&gt;property_update_work);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; pr_debug(&quot;[HDCP_DM] display %d, CP %u, (query-&gt;enc_st, w=
ork-&gt;enc_st): (%d, %d)\n&quot;,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; aconnector=
-&gt;base.index, aconnector-&gt;base.state-&gt;content_protection,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; query.encr=
yption_status, hdcp_work-&gt;encryption_status[conn_index]);<br>
+<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; if (query.encryption_status !=3D hdcp_work-&gt;encryption_status=
[conn_index]) {<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; hdcp_work-&gt;en=
cryption_status[conn_index] =3D query.encryption_status;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; schedule_work(&a=
mp;hdcp_work-&gt;property_update_work);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; }<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mutex_unlock(&amp;hdcp_wor=
k-&gt;mutex);<br>
@@ -655,6 +698,10 @@ struct hdcp_workqueue *hdcp_create_workqueue(struct am=
dgpu_device *adev, struct<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; hdcp_work[i].hdcp.config.ddc.funcs.read_i2c =3D lp_re=
ad_i2c;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; hdcp_work[i].hdcp.config.ddc.funcs.write_dpcd =3D lp_=
write_dpcd;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; hdcp_work[i].hdcp.config.ddc.funcs.read_dpcd =3D lp_r=
ead_dpcd;<br>
+<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; memset(hdcp_work[i].aconnector, 0, sizeof(struct amdgpu_dm_conne=
ctor *) * MAX_NUM_OF_DISPLAYS);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; memset(hdcp_work[i].encryption_status, 0,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; sizeof(enum mod_=
hdcp_encryption_status) * MAX_NUM_OF_DISPLAYS);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; cp_psp-&gt;funcs.update_st=
ream_config =3D update_config;<br>
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_hdcp.h b/drive=
rs/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_hdcp.h<br>
index 09294ff122fe..570863160d60 100644<br>
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_hdcp.h<br>
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_hdcp.h<br>
@@ -1,5 +1,5 @@<br>
&nbsp;/*<br>
- * Copyright 2019 Advanced Micro Devices, Inc.<br>
+ * Copyright (C) 2019-2020 Advanced Micro Devices, Inc. All rights reserve=
d.<br>
&nbsp; *<br>
&nbsp; * Permission is hereby granted, free of charge, to any person obtain=
ing a<br>
&nbsp; * copy of this software and associated documentation files (the &quo=
t;Software&quot;),<br>
@@ -43,7 +43,7 @@ struct hdcp_workqueue {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct delayed_work callba=
ck_dwork;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct delayed_work watchd=
og_timer_dwork;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct delayed_work proper=
ty_validate_dwork;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_dm_connector *aconnecto=
r;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_dm_connector *aconnecto=
r[MAX_NUM_OF_DISPLAYS];<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct mutex mutex;<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct mod_hdcp hdcp;<br>
@@ -51,7 +51,7 @@ struct hdcp_workqueue {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct mod_hdcp_display di=
splay;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct mod_hdcp_link link;=
<br>
&nbsp;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; enum mod_hdcp_encryption_status encry=
ption_status;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; enum mod_hdcp_encryption_status encry=
ption_status[MAX_NUM_OF_DISPLAYS];<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint8_t max_link;<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint8_t *srm;<br>
-- <br>
2.31.1<br>
<br>
</div>
</span></font></div>
</div>
</body>
</html>

--_000_CH0PR12MB528457F2643C9A68B6CD21E78B499CH0PR12MB5284namp_--

--===============0361578157==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

--===============0361578157==--
