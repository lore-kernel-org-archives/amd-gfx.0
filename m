Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E1973C433F5
	for <amd-gfx@archiver.kernel.org>; Mon, 14 Feb 2022 21:12:54 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 42A4D10E1D4;
	Mon, 14 Feb 2022 21:12:54 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2061.outbound.protection.outlook.com [40.107.220.61])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D476510E1D4
 for <amd-gfx@lists.freedesktop.org>; Mon, 14 Feb 2022 21:12:52 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=K8gZOyJaMb2drCyrATs6ZeZu7XWTNXOr/coqszpTR9v0vA6TCfhwlqPCQypYQRcm/Yq8IdajV0F+lhaq0IyiXo+UCoe42OrmS1mQK2tTpA28Xy1pSCSxz8XSyU95rJLymqC1iBQTHQbda1/MKiFXWrWhaRqR4k6l4hJLlQknB81yifIm144vQIaHfOS52pwN4I/CPipZbtL2JVyhAbgaTsCc+7440lkZ0vkwInyhQq211lZh58541a/TxBs1lvAPVGL+XTT7Qd50eehj6XS7v6nAm5L/OZvJ1DvbbleNq0y+Rs4Yazkpi0iGcXx3ux4WmOpP8eX3WKq1JRm/1FrJnQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=387RXCtO0qBrMVqsOEuv2Q4Ft33fhsjAd/hKOkZseik=;
 b=oAUmVO4PcwSbMMRDZwDv/pU94LJAZSsar+kpXUCKOE8edxUSUzIPAx4t9FT0SDKybD2sak5PldU2SS42n+tINJOzw6IbYntaX2MrTBXKwJtvu0bqyMlcUSFhKXjqRH69F6KszZWlOhgRkbR2Hseponq1fo2j1rjtcOYUaF9JpItFWjDq3Ki9Ro6nsMDgrq8acj7z0C7EMF2LQHPgrG+9dZS/0a770tZF+cJeJ2lAiqCh6/tbgSp7FPwrFJBJzIKtY2VfkoFekR1JPuw0JRi4cJWp1wQwxt309GEFXiAVHC80BwYpRpUDMq+m4yXr/w7qq/6+PMqAn2PnF6KokW3XVQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=387RXCtO0qBrMVqsOEuv2Q4Ft33fhsjAd/hKOkZseik=;
 b=uBXqFQF/h9UWvKt86ttawSiPmmDOu1FxWlha7quM5CzvYZJfwYjNl8EOeFz1YxHkxoooEqgi8Ubd++ojeLMfxjbU/SU+zJa1Wohr+mRfOUjx5FsiHMBeenp8+50JqE71ItnODGWuoPGuwA7RCeAGltzMmP3mPpE8SMhI6AvskK0=
Received: from DM6PR12MB3529.namprd12.prod.outlook.com (2603:10b6:5:15d::18)
 by DM6PR12MB3804.namprd12.prod.outlook.com (2603:10b6:5:1cd::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4975.11; Mon, 14 Feb
 2022 21:12:49 +0000
Received: from DM6PR12MB3529.namprd12.prod.outlook.com
 ([fe80::2c:40ad:b492:a81a]) by DM6PR12MB3529.namprd12.prod.outlook.com
 ([fe80::2c:40ad:b492:a81a%6]) with mapi id 15.20.4975.019; Mon, 14 Feb 2022
 21:12:49 +0000
From: "Wheeler, Daniel" <Daniel.Wheeler@amd.com>
To: "Dhillon, Jasdeep" <Jasdeep.Dhillon@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH 00/11] DC Patches Feburary 14, 2022
Thread-Topic: [PATCH 00/11] DC Patches Feburary 14, 2022
Thread-Index: AQHYH5Ga3QkAivLe2UizekHro+cuTayTkAfQ
Date: Mon, 14 Feb 2022 21:12:49 +0000
Message-ID: <DM6PR12MB3529D81A1559DD3E97CCD30B9C339@DM6PR12MB3529.namprd12.prod.outlook.com>
References: <20220211215142.94169-1-jdhillon@amd.com>
In-Reply-To: <20220211215142.94169-1-jdhillon@amd.com>
Accept-Language: en-CA, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Enabled=true;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SetDate=2022-02-14T21:12:47Z; 
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Method=Standard;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Name=AMD Official Use
 Only-AIP 2.0;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ActionId=5daa6347-962d-4303-b399-f08550115f6e;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ContentBits=1
msip_label_88914ebd-7e6c-4e12-a031-a9906be2db14_enabled: true
msip_label_88914ebd-7e6c-4e12-a031-a9906be2db14_setdate: 2022-02-14T21:12:47Z
msip_label_88914ebd-7e6c-4e12-a031-a9906be2db14_method: Standard
msip_label_88914ebd-7e6c-4e12-a031-a9906be2db14_name: AMD Official Use
 Only-AIP 2.0
msip_label_88914ebd-7e6c-4e12-a031-a9906be2db14_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_88914ebd-7e6c-4e12-a031-a9906be2db14_actionid: 77289ae8-aeea-4557-b9bd-7ed50d5dec8b
msip_label_88914ebd-7e6c-4e12-a031-a9906be2db14_contentbits: 0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: d5518bc3-97d9-40de-06e6-08d9effec17b
x-ms-traffictypediagnostic: DM6PR12MB3804:EE_
x-microsoft-antispam-prvs: <DM6PR12MB380400F5CD3ADAAF256C5E909C339@DM6PR12MB3804.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: bx+3m0aagtjHwsVonjmkpMUJmRP7p3pDskqAwXYRcS/zdcCHs5L71hqlLnRqVXl59xQXDZB95kZTDfXdndhw2IDmjpiFzpgigslteJHhAKeMV1QbwnXE3d1yB17oWBBMBhLi/y3u9ei5oF6v9+pwd5va+fDMOdypUmAaEFRXkEI7EC5CAgQoXsavHCL6ImcxQXqUO+hVCpbk9q2hWbnCTm1xvcQ4HXmTVCKleKQ1lmyc14Iqat8tGPpYWqWKZajlwETtOpRvRXclWpKcYHWuF3Oi47uTuM9wxZsoS7qqirhxsLcIMM5nTIJrjm+uExqQ9uBKfB6PLLbIe5xHB2O5SGdafvFcG2dvXkXFxudnJJEiboMF1HrpHWnWhIs9JqxbACXhp3PjgKMg0ONG7azR/WQDnJfeKsuV0OwhFIyKw+Z1BfaNnU7VPtQE7qK8DiAaj6qUdmQAslJP56HP60pp/JkPOEjHZg1jSHqG0bRI8T9XIejlOnc73gfLV6kOtVBtVoANpReUFZDUiyJfPq4bPWRkNHEoWuj9L1vL0X6aw3hFzx4+pZqCFIBeDCIlOQWBNVysf+niurTIP9O57X83PmEcCPc/9t2N0aPSl65ARQbPIkB9sSl3FPDMlje8LSAifo2VcmHku0pX7dVWdLimfI9JxJM9gGI28i/daKZkLrI0spxmMhY1jfXJlbS8oAWCxletL4VlpLBNBa0Qaoakzg==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB3529.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(4636009)(366004)(110136005)(66446008)(4326008)(26005)(8676002)(5660300002)(7696005)(53546011)(8936002)(66476007)(316002)(186003)(2906002)(83380400001)(508600001)(66946007)(76116006)(64756008)(38100700002)(55016003)(54906003)(86362001)(122000001)(6506007)(33656002)(52536014)(38070700005)(9686003)(66556008)(71200400001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?jB810srsaGvAN0Ccz+jZHGmuJnZqmBswhEAATFWThG1WhIcU+H0sJ+YALFTa?=
 =?us-ascii?Q?kHKL6/9LJxGoolp2AO7fM3tqVu3cV1DIvksaNrCCcrvHIdoHnlcz/cW3FFbb?=
 =?us-ascii?Q?GUN+r8eXWfBBGQI3liQSa1yTkruV3f5NmBv+r5Br/Cf0S49N+93XMySvMFV0?=
 =?us-ascii?Q?roiSqlUWPkHcxMzW0QPnLlxkIUaVtTaujSFSqcpkyovKfz0lSS8XhlOdAw0J?=
 =?us-ascii?Q?992uvXPQGTXraCgOs+BauBlOkOjPEhyBKW5vKfK+MgUWRyj9CKzJ8BvlCvMN?=
 =?us-ascii?Q?EhUDPobL3GD8pxWZ1nKDh8xYvEu72Fhbj8FoavunESioPVVyP5nDU1Vw/tm8?=
 =?us-ascii?Q?0z4m7UlX1+38vebi9Uol0kt+ANcXaxdlMGZMRxXJnyP3EgnxqwOF2J6iqMpA?=
 =?us-ascii?Q?T1Uy0/V381Kc6QuBwVtHuN/adnirNOUkGUedC37VlCNirkVNrYI8tbfJ5ck0?=
 =?us-ascii?Q?khFTW8maNjtOl2PBRx4ZuFwSMl/EaYqT+vXW5ATur1fA1m+OvAPdSiTiHUeB?=
 =?us-ascii?Q?KrjMWuIP9MWGRM30YOEGuWWbQRr/cstVFBTdtf1EhmtA2QIC1we2nKNjVbcI?=
 =?us-ascii?Q?eZCKK2C1l3iVNFAxBA8htjiV3V1TQmKI1wEP/eHfrwYBWE/5Ife3cLHB2V5L?=
 =?us-ascii?Q?FuW8uNkKLsC/eajNRZl1c/wkJ9NdyMGYlSENg1U6gkC7klP4vkb8A8LXPZYj?=
 =?us-ascii?Q?8ciGm7cYr4O7hmiFeVzX+Dih5Am46lHRS1s/Vaa7zout310oo5EtS/8e6VzP?=
 =?us-ascii?Q?hOCNReKkHtvJoDtlTTgen+SkPKA4affrq7zBltG4lO3gfZzc6UAkdgrvhDDU?=
 =?us-ascii?Q?srMVO74/9HfgcXaem2ubNG7ohnJ1irZT/x/fsxxcmLiJQlwLwqudW+IPtrPA?=
 =?us-ascii?Q?/5eUgyRBNzVrr2kfDnLM/P7AIpUxEGeAAsa8kjx9fAjckgs08aV3MAsP4z+o?=
 =?us-ascii?Q?3pWlzdg7xSOLkyHFoTgMswOP46oB5JE/T+e88RBkVhmqtDWubzA9jUDgIV7/?=
 =?us-ascii?Q?0vj/DWVt2xP+GuaMbpFqtbExsXIz8Y31DIe3lXX1u3ykdfF1cDx42mik/9Qw?=
 =?us-ascii?Q?+fGuxWYE854b8sATTQFEbvUMv5Xv+LJBKNEVLLOyfCsBZ/7234oDIaF0bOIQ?=
 =?us-ascii?Q?aaq8RsThFLE0zWSsLL4GlOOxYnBR+EeoWhLnkjLkxphzmvVzboWkooirKJTg?=
 =?us-ascii?Q?2PzPanrc/qeS+5QhayRSgKtSpvy5AOS1V3s5NOMK7XAg6dGnBTkJ/Cu9VNZ5?=
 =?us-ascii?Q?p0VpFQo1HVyzBXMWGnN/2/NZe8HhGDd6NFSEvbQcLPUOsBIxBcY3q5W/cc7L?=
 =?us-ascii?Q?TJbp7MiQ/fYokVrhc1uUdlc2pQzTOdIoOynrIKVwBrvrjB+xH9+IEkORiK1b?=
 =?us-ascii?Q?WPcYaBXhNPrFKA+F2/H56sujOuCQNjhzIlhk0IKSy+/2YTDBPdcIbVRQQPAp?=
 =?us-ascii?Q?IhKv11q8xh3nPw8GQDi6QJ9N1YfIjmlLj8yletBaiIlozIMBCCY1RWvtfwGz?=
 =?us-ascii?Q?qJ6lWptJLyO/QidkdaCjSm3RmXoQ4qn2bmNNVLxnK1X+NSi9TJuHZPXUfERe?=
 =?us-ascii?Q?Imxb3EJMdU2l1nNLRsrtsB+Jq8is9waPu1NvKRBDsUsagoO2mQewm2DXZ9KR?=
 =?us-ascii?Q?E2tUvEvzw2QVWsdfycqq8X4=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3529.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d5518bc3-97d9-40de-06e6-08d9effec17b
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Feb 2022 21:12:49.5026 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: XilCS2mM1MA/c6ZVFTUbgPkUxEAxoa44tyays830gt9u1EbZx9jd22R46FpS+VqkjLQSe7R/8QrkhvFUIIDtqQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3804
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
Cc: "Wang, Chao-kai \(Stylon\)" <Stylon.Wang@amd.com>, "Li,
 Sun peng \(Leo\)" <Sunpeng.Li@amd.com>, "Wentland,
 Harry" <Harry.Wentland@amd.com>, "Zhuo, 
 Qingqing \(Lillian\)" <Qingqing.Zhuo@amd.com>, "Siqueira,
 Rodrigo" <Rodrigo.Siqueira@amd.com>, "Li, Roman" <Roman.Li@amd.com>, "Lakha,
 Bhawanpreet" <Bhawanpreet.Lakha@amd.com>, "Chiu,
 Solomon" <Solomon.Chiu@amd.com>, "Pillai,
 Aurabindo" <Aurabindo.Pillai@amd.com>, "Lin, Wayne" <Wayne.Lin@amd.com>,
 "Dhillon, Jasdeep" <Jasdeep.Dhillon@amd.com>, "Gutierrez,
 Agustin" <Agustin.Gutierrez@amd.com>, "Kotarac, Pavle" <Pavle.Kotarac@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Official Use Only]

Hi all,
=20
This week this patchset was tested on the following systems:
=20
Lenovo Thinkpad T14s Gen2 with AMD Ryzen 5 5650U, with the following displa=
y types: eDP 1080p 60hz, 4k 60hz  (via USB-C to DP/HDMI), 1440p 144hz (via =
USB-C to DP/HDMI), 1680*1050 60hz (via USB-C to DP and then DP to DVI/VGA)
=20
Sapphire Pulse RX5700XT with the following display types:
4k 60hz  (via DP/HDMI), 1440p 144hz (via DP/HDMI), 1680*1050 60hz (via DP t=
o DVI/VGA)
=20
Reference AMD RX6800 with the following display types:
4k 60hz  (via DP/HDMI and USB-C to DP/HDMI), 1440p 144hz (via USB-C to DP/H=
DMI and USB-C to DP/HDMI), 1680*1050 60hz (via DP to DVI/VGA)
=20
Included testing using a Startech DP 1.4 MST hub at 2x 4k 60hz, and 3x 1080=
p 60hz on all systems. Also tested DSC via USB-C to DP DSC Hub with 3x 4k 6=
0hz on Ryzen 9 5900h and Ryzen 5 4500u.
=20
Tested on Ubuntu 20.04.3 with Kernel Version 5.13
=20
Tested-by: Daniel Wheeler <daniel.wheeler@amd.com>
=20
=20
Thank you,
=20
Dan Wheeler
Technologist  |  AMD
SW Display

-----Original Message-----
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Jasdeep =
Dhillon
Sent: February 11, 2022 4:52 PM
To: amd-gfx@lists.freedesktop.org
Cc: Wang, Chao-kai (Stylon) <Stylon.Wang@amd.com>; Li, Sun peng (Leo) <Sunp=
eng.Li@amd.com>; Wentland, Harry <Harry.Wentland@amd.com>; Zhuo, Qingqing (=
Lillian) <Qingqing.Zhuo@amd.com>; Dhillon, Jasdeep <Jasdeep.Dhillon@amd.com=
>; Siqueira, Rodrigo <Rodrigo.Siqueira@amd.com>; Li, Roman <Roman.Li@amd.co=
m>; Chiu, Solomon <Solomon.Chiu@amd.com>; Pillai, Aurabindo <Aurabindo.Pill=
ai@amd.com>; Lin, Wayne <Wayne.Lin@amd.com>; Lakha, Bhawanpreet <Bhawanpree=
t.Lakha@amd.com>; Gutierrez, Agustin <Agustin.Gutierrez@amd.com>; Kotarac, =
Pavle <Pavle.Kotarac@amd.com>
Subject: [PATCH 00/11] DC Patches Feburary 14, 2022

This DC patchset brings improvements in multiple areas. In summary, we high=
light:
-Fixes bugs for dsc mst hub
-Enables Z9 denial interface by default
-Fixes dmub outbox notification

Anthony Koo (1):
  drm/amd/display: [FW Promotion] Release 0.0.104.0

Aric Cyr (1):
  drm/amd/display: 3.2.173

Charlene Liu (1):
  drm/amd/display: make sure pipe power gating reach requested hw state

Eric Yang (1):
  drm/amd/display: enable z9 denial interface by default

Hersen Wu (2):
  drm/amd/display: dsc mst re-compute pbn for changes on hub
  drm/amd/display: add dsc mst stream pbn log for debug

Meenakshikumar Somasundaram (1):
  drm/amd/display: Fix for dmub outbox notification enable

Oliver Logush (1):
  drm/amd/display: extend dcn201 support

Roman Li (2):
  drm/amd/display: Add affected crtcs to atomic state for dsc mst unplug
  drm/amd/display: Add dsc pre-validation in atomic check

Sung Joon Kim (1):
  drm/amd/display: reset lane settings after each PHY repeater LT

 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c |  18 +-  .../gpu/drm/amd/di=
splay/amdgpu_dm/amdgpu_dm.h |  13 +
 .../display/amdgpu_dm/amdgpu_dm_mst_types.c   | 257 +++++++++++++++++-
 .../display/amdgpu_dm/amdgpu_dm_mst_types.h   |   4 +
 drivers/gpu/drm/amd/display/dc/core/dc.c      |  66 ++++-
 drivers/gpu/drm/amd/display/dc/core/dc_link.c |  20 ++  .../gpu/drm/amd/di=
splay/dc/core/dc_link_dp.c  |  15 +-
 .../gpu/drm/amd/display/dc/core/dc_resource.c |   4 +-
 .../gpu/drm/amd/display/dc/core/dc_stream.c   |  16 ++
 drivers/gpu/drm/amd/display/dc/dc.h           |   5 +-
 drivers/gpu/drm/amd/display/dc/dc_hw_types.h  |   1 +
 .../gpu/drm/amd/display/dc/dce/dmub_outbox.c  |  25 +-
 .../gpu/drm/amd/display/dc/dce/dmub_outbox.h  |   4 +-
 .../amd/display/dc/dcn10/dcn10_hw_sequencer.c |   4 -
 .../drm/amd/display/dc/dcn31/dcn31_hwseq.c    |  23 +-
 .../drm/amd/display/dc/dcn31/dcn31_resource.c |   2 +-
 .../gpu/drm/amd/display/dmub/inc/dmub_cmd.h   |   4 +-
 .../gpu/drm/amd/display/include/dal_asic_id.h |   1 +
 18 files changed, 429 insertions(+), 53 deletions(-)

--
2.25.1
