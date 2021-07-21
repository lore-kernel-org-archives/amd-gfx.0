Return-Path: <SRS0=ovQZ=MN=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94F3CC12002
	for <amd-gfx@archiver.kernel.org>; Wed, 21 Jul 2021 14:07:27 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5A51861248
	for <amd-gfx@archiver.kernel.org>; Wed, 21 Jul 2021 14:07:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5A51861248
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1A5A86EB84;
	Wed, 21 Jul 2021 14:07:27 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2046.outbound.protection.outlook.com [40.107.244.46])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3DD196EB88
 for <amd-gfx@lists.freedesktop.org>; Wed, 21 Jul 2021 14:07:25 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jgC6ilTbAJ/5A1quShV7rVXq3W8DQoAKmq2eXau29Y44WZ9E7FZpgnc0+ls1F+zitOGwjcNFf9I+9Ko/ZpjzHB973P+tXuTnQWkYhQmnHLGpVK5kfvnbv1VXFFTZDiL3Ra432KEL0BagViKTdniX+DhJm8yzpc6ucQ0ff+sewaz/go2FhiuxY2p7JnK2qPV5pOC/J0XjA+09UzTNVMn3Yp+bYov+Zv1iueWKYCrJFa+c8fR3wd19UHyITh4hkzr4B/jG3I8HRFrv7/AACNj4IUDXsg1iuRDnHOPGsW0Vij41KyK1hV1nk+IRO8tmPAD66GCvwgDpc3F5a5sknX456A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PQdahHRoZd791gXJlYTTGc5VeYLeWRshXVPHElETdUc=;
 b=UJbolinMHAwZPoJgW2c7fAEmtY4DdapMbey0W4Z2MP0gsZ6Z5izeL5e22Jle5Pbfyeg1cllyqq0CjYgToalXgzZexW5RTeWUyvG/E9SYxB1cAIqqxibEcE5jK0a6yYd+0mH7BOnfCm9IOtj+q/7vHiqBzrFcJjvkutyU0OZjEPIWym5xgFqJFT9CYEUp29eCbvCb4hUAiNEMfBNQKIapXp5QLBJ+JDJRtALe9ch4i9q32d7Zavr7HkP+7IBaa5vA+ig500ZzYKqWTDj0JJ5zagWDEQbaFTo9Ad20xrZkN1Px8tC3aOLL6Rl6wLJumTs2+kr5ip8gzrPgUCKRuClV7A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PQdahHRoZd791gXJlYTTGc5VeYLeWRshXVPHElETdUc=;
 b=elaGlu7tf8CMFRIEZFFakyH5V5YoSagT1MngXvlSse+gVj25W6KDScq+aylZG0Xs6XARJrpf0abXIeKWMhIcbevWOE1rZWLRnxLMRvDo3jsF868/7cHu7pR76Z4Ppf4jxSOTNKXRneJXi0FhsFOVq3dcoifwOu8ZEY4i/1CUX/E=
Received: from BL1PR12MB5144.namprd12.prod.outlook.com (2603:10b6:208:316::6)
 by BL1PR12MB5029.namprd12.prod.outlook.com (2603:10b6:208:310::24)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4331.21; Wed, 21 Jul
 2021 14:07:23 +0000
Received: from BL1PR12MB5144.namprd12.prod.outlook.com
 ([fe80::8cb6:59d6:24d0:4dc3]) by BL1PR12MB5144.namprd12.prod.outlook.com
 ([fe80::8cb6:59d6:24d0:4dc3%9]) with mapi id 15.20.4352.025; Wed, 21 Jul 2021
 14:07:23 +0000
From: "Deucher, Alexander" <Alexander.Deucher@amd.com>
To: "Wang, Chao-kai (Stylon)" <Stylon.Wang@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Subject: Re: [PATCH v2 0/2] Fix regression on embedded panels caused by
 enabling ASSR
Thread-Topic: [PATCH v2 0/2] Fix regression on embedded panels caused by
 enabling ASSR
Thread-Index: AQHXfeh77mcbgKBEKUSX6A27r8Xq1qtNd4wC
Date: Wed, 21 Jul 2021 14:07:23 +0000
Message-ID: <BL1PR12MB5144DB522EE6D72995C4E2D4F7E39@BL1PR12MB5144.namprd12.prod.outlook.com>
References: <20210720033317.686726-1-stylon.wang@amd.com>,
 <20210721042524.754014-1-stylon.wang@amd.com>
In-Reply-To: <20210721042524.754014-1-stylon.wang@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Enabled=True;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SetDate=2021-07-21T14:07:22.362Z;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Name=Public;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ContentBits=0;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Method=Privileged; 
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 1b16727c-9e76-40b2-7d10-08d94c50dcd0
x-ms-traffictypediagnostic: BL1PR12MB5029:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BL1PR12MB5029E7FD32502F08319D6F43F7E39@BL1PR12MB5029.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:3826;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: xcdH8fjYda2dY8Vb/ngBqClw7YOUhjaUHh8ZJJAvZ4OsOuEg/Pz/Br2Fl5uL1aPpT9yF30Rikzvwv0QuyF7sLn72T1oIBXkCcgX7/gRkWlOD+H73WB1HIa8GR8SruozT4gZoeJighrFXmHkfAIwqAC0GfemGCGC9HOhfu8ec9rv3DHMDOG+olWAKccIpgYcdvzcc1FHJ+dR50ptnaXbHLqMKqJoZEY+tocLvpYl6TSPOmk2KJ9GcLRLT3LqK7NSX7Uub0VT5Z428B/7jJGxGo/MgUeDb2/Y4ktQOVvwhNYGP/gTe8XiT+RDvziGeus+YNgazhFon6LhrnWnuLDQcoElE/Eqhb68WpQV2K01307JTkhEYoHIQAOjeu4iSy5bVq0ONOMMBEvPJNTg/Vt2lL3Olx7fD+rLf1b6WPtx0ZYLF8OrOhbllJ62YZntbkYFmp9cNcKjNeEzr4Ynm+bjENyfp4Ja97tDl1b1Mdo6YCAqwrPuNxnpXGQ8XQAp/UiCtCPNtQhEaZuMn6m2MWsr/tiD+KHcQoULbPMAJNH78E+LcByHTm+IzTq2zxcxnNjn0PQ4f141bIQ+Ex78oByc7PUmexiPF0Y1DUqjqdnURCCXs51UsatI+l4gnikkW+YQbjJ/rUIWA8g2OyLvpBhbpA+oNxLIhTzA9Wc0bdluS6DKl71Hp/CwBoH7GCxYDr08e3Pc7fiCNEUc/EIWV32iP/g==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL1PR12MB5144.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(54906003)(45080400002)(33656002)(316002)(8936002)(122000001)(2906002)(66556008)(966005)(64756008)(66446008)(8676002)(52536014)(76116006)(110136005)(508600001)(7696005)(5660300002)(19627405001)(71200400001)(66476007)(83380400001)(4326008)(186003)(26005)(166002)(86362001)(66946007)(6506007)(53546011)(38100700002)(55016002)(9686003)(38070700004);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?W7IVSUjBHcPT2Z+jZU9h66Oq5Z5sDq91aRewMpnNPzd2osyKXtwX1k7wy+Gl?=
 =?us-ascii?Q?assUTnzQg7UE2KqjVVaTk20OIM6Ne2Wjl19Zi56LRN8N7FgCq1AeDwG6XNCH?=
 =?us-ascii?Q?BF8uPyIkWOUw3vFFrI1MjLPPMkleb3zndntcXZMJAJCtSxbM2c3/bMe8tqJr?=
 =?us-ascii?Q?yHftEsUEvJcg08iYsX365ekxlVTQ8TXY5cWSGD3GruXWv5dg1v8vafpGwjAa?=
 =?us-ascii?Q?Iq60sz9fmpr8796RaidEHNzu4V/n3igQARaNK0hXLR/5LL7sBGObPAVE9npL?=
 =?us-ascii?Q?/HqboeW+POTz1iPJWoSi3m7jx3dZt0+W2y7RglUqQbQiq5eWG1wEbzYrw1CI?=
 =?us-ascii?Q?YsgfGPeLTtj626Otuse9aG8qkIyte6L465BPHDqYniHE7vbf5Lc1FrtjFRGv?=
 =?us-ascii?Q?3jfnW5/FHliHNQ76JGJDt/ARCtZgArMrL5ZPZ3Qefo9gsiK21yDk4LBoFGsd?=
 =?us-ascii?Q?vducNv0gZkC6kzlTpYMTBjf4K2ac4vykrLNIl8BT7ONTajiwFJrIkkPqflIF?=
 =?us-ascii?Q?PW10Kj7TC+mLfhONzj7M8uq1nsLmBr2c0UvDB2Dz4GR/3NxlzYnzG4B2Eq+D?=
 =?us-ascii?Q?LoE+SBJhKKJ6LIhcLyaNIky+JsPMfnq+Z5ZWihEUJ5Z89qq/6QD7qijI0GTo?=
 =?us-ascii?Q?YJ6OAss4o0M4B264jayRD4Njvy3yaBU0L7NFFpoaXCcmmzhcTTLArj2iK/iS?=
 =?us-ascii?Q?ROfpC/8V81rfHT0PFGmZkjz8rVkjWYZjk3A/8D/aUQ60wZ6OgLAVUetRBqSM?=
 =?us-ascii?Q?AXzE45kgk2F1QLAPyaeOHOG70iSjOEJL5XZ6PUATOUHNl8HJsQCdgD5YZ9UW?=
 =?us-ascii?Q?MAxtJzx9ibkxLzq1i3oxWPxLzfFbGDFWt2sLWfM9UO5xlFEBDBtZ95BTn9JW?=
 =?us-ascii?Q?LCH1g9f6aisLOK7rlAX0KYnw2IAlsTNeGM7nt95ro3wv7CnAsUy9v3i3jSnU?=
 =?us-ascii?Q?13eveeciC3NQZTxnuQdDR8fxnQo11rdPgTa+i0GJ+zOdcLsj4FzhLWW9o0Vm?=
 =?us-ascii?Q?Zpwi3BgSawrV47Djafj3MZS3KGrl9+9vd3TFIwPmVwyLVNm8rlUcE73jyFua?=
 =?us-ascii?Q?U6kO48WQUbWn+BAM1br3VmaSOjX4mzsj4vNWvzeFutzd49rBWzRvkr+M1vU6?=
 =?us-ascii?Q?Glv2/WAEN5I0Xm6HTPls5529Lg6uaCNDESoMMrrpF/TbwwF1VlHT0rWtdiad?=
 =?us-ascii?Q?zEoJGjheKm/K+0pfkCgJ8ZNA01KalTaN95wfX6jGzlqT6zJ+r9Wf9yFM6B6Y?=
 =?us-ascii?Q?VSryx1IUt7/G9Qz6JECRIsdY4/fFhwQDTKz8n3HULvljMUePz4yS13WyUG+Y?=
 =?us-ascii?Q?jrPSNRAyUYfIBZ6ARxgt4PJM?=
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5144.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1b16727c-9e76-40b2-7d10-08d94c50dcd0
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Jul 2021 14:07:23.3708 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: DtVmk+Nwd9dp/h2XojJovo7gQf9TsWT2KTO0frG9rad7F8KbtHXxkBiddIH78fvYBeFIR0Ev5n8eL3Ckop3EYQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5029
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
Cc: "Li, Sun peng \(Leo\)" <Sunpeng.Li@amd.com>, "Lakha,
 Bhawanpreet" <Bhawanpreet.Lakha@amd.com>, "Zhuo,
 Qingqing" <Qingqing.Zhuo@amd.com>, "Siqueira,
 Rodrigo" <Rodrigo.Siqueira@amd.com>, "Jacob, Anson" <Anson.Jacob@amd.com>,
 "Pillai, Aurabindo" <Aurabindo.Pillai@amd.com>, "Wentland,
 Harry" <Harry.Wentland@amd.com>, "R, Bindu" <Bindu.R@amd.com>
Content-Type: multipart/mixed; boundary="===============1782334239=="
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--===============1782334239==
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_BL1PR12MB5144DB522EE6D72995C4E2D4F7E39BL1PR12MB5144namp_"

--_000_BL1PR12MB5144DB522EE6D72995C4E2D4F7E39BL1PR12MB5144namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

[Public]

Series looks good to me. Thanks!

Alex

________________________________
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> on behalf of Stylon W=
ang <stylon.wang@amd.com>
Sent: Wednesday, July 21, 2021 12:25 AM
To: amd-gfx@lists.freedesktop.org <amd-gfx@lists.freedesktop.org>
Cc: Wang, Chao-kai (Stylon) <Stylon.Wang@amd.com>; Li, Sun peng (Leo) <Sunp=
eng.Li@amd.com>; Wentland, Harry <Harry.Wentland@amd.com>; Zhuo, Qingqing <=
Qingqing.Zhuo@amd.com>; Siqueira, Rodrigo <Rodrigo.Siqueira@amd.com>; Jacob=
, Anson <Anson.Jacob@amd.com>; Pillai, Aurabindo <Aurabindo.Pillai@amd.com>=
; Lakha, Bhawanpreet <Bhawanpreet.Lakha@amd.com>; R, Bindu <Bindu.R@amd.com=
>
Subject: [PATCH v2 0/2] Fix regression on embedded panels caused by enablin=
g ASSR

Previous ASSR-enabling patches cause blank screen on some embedded
panels. This patch set minimize the changes made to code logic prior to
the ASSR change and also improve on code readability.

Changes from prior rev1 to now:

v2:
 - Update reviewed-by and bug links

Stylon Wang (2):
  drm/amd/display: Revert "Re-enable 'Guard ASSR with internal display
    flag'"
  drm/amd/display: Fix ASSR regression on embedded panels

 .../gpu/drm/amd/display/dc/core/dc_link_dp.c  | 58 +++++++------------
 1 file changed, 20 insertions(+), 38 deletions(-)

--
2.32.0

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://nam11.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Flists.f=
reedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;data=3D04%7C01%7Calexande=
r.deucher%40amd.com%7C448d5309ea364844350d08d94bff9c47%7C3dd8961fe4884e608e=
11a82d994e183d%7C0%7C0%7C637624383495009435%7CUnknown%7CTWFpbGZsb3d8eyJWIjo=
iMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C1000&amp;sdat=
a=3DKuBaIHeinOgubF5Mp%2FnZA45ia6FrxVdrNtTBwf7OqPE%3D&amp;reserved=3D0

--_000_BL1PR12MB5144DB522EE6D72995C4E2D4F7E39BL1PR12MB5144namp_
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
Series looks good to me. Thanks!</div>
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
<hr style=3D"display:inline-block;width:98%" tabindex=3D"-1">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" st=
yle=3D"font-size:11pt" color=3D"#000000"><b>From:</b> amd-gfx &lt;amd-gfx-b=
ounces@lists.freedesktop.org&gt; on behalf of Stylon Wang &lt;stylon.wang@a=
md.com&gt;<br>
<b>Sent:</b> Wednesday, July 21, 2021 12:25 AM<br>
<b>To:</b> amd-gfx@lists.freedesktop.org &lt;amd-gfx@lists.freedesktop.org&=
gt;<br>
<b>Cc:</b> Wang, Chao-kai (Stylon) &lt;Stylon.Wang@amd.com&gt;; Li, Sun pen=
g (Leo) &lt;Sunpeng.Li@amd.com&gt;; Wentland, Harry &lt;Harry.Wentland@amd.=
com&gt;; Zhuo, Qingqing &lt;Qingqing.Zhuo@amd.com&gt;; Siqueira, Rodrigo &l=
t;Rodrigo.Siqueira@amd.com&gt;; Jacob, Anson &lt;Anson.Jacob@amd.com&gt;;
 Pillai, Aurabindo &lt;Aurabindo.Pillai@amd.com&gt;; Lakha, Bhawanpreet &lt=
;Bhawanpreet.Lakha@amd.com&gt;; R, Bindu &lt;Bindu.R@amd.com&gt;<br>
<b>Subject:</b> [PATCH v2 0/2] Fix regression on embedded panels caused by =
enabling ASSR</font>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt;=
">
<div class=3D"PlainText">Previous ASSR-enabling patches cause blank screen =
on some embedded<br>
panels. This patch set minimize the changes made to code logic prior to<br>
the ASSR change and also improve on code readability.<br>
<br>
Changes from prior rev1 to now:<br>
<br>
v2:<br>
&nbsp;- Update reviewed-by and bug links <br>
<br>
Stylon Wang (2):<br>
&nbsp; drm/amd/display: Revert &quot;Re-enable 'Guard ASSR with internal di=
splay<br>
&nbsp;&nbsp;&nbsp; flag'&quot;<br>
&nbsp; drm/amd/display: Fix ASSR regression on embedded panels<br>
<br>
&nbsp;.../gpu/drm/amd/display/dc/core/dc_link_dp.c&nbsp; | 58 +++++++------=
------<br>
&nbsp;1 file changed, 20 insertions(+), 38 deletions(-)<br>
<br>
-- <br>
2.32.0<br>
<br>
_______________________________________________<br>
amd-gfx mailing list<br>
amd-gfx@lists.freedesktop.org<br>
<a href=3D"https://nam11.safelinks.protection.outlook.com/?url=3Dhttps%3A%2=
F%2Flists.freedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;amp;data=3D04%=
7C01%7Calexander.deucher%40amd.com%7C448d5309ea364844350d08d94bff9c47%7C3dd=
8961fe4884e608e11a82d994e183d%7C0%7C0%7C637624383495009435%7CUnknown%7CTWFp=
bGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%=
7C1000&amp;amp;sdata=3DKuBaIHeinOgubF5Mp%2FnZA45ia6FrxVdrNtTBwf7OqPE%3D&amp=
;amp;reserved=3D0">https://nam11.safelinks.protection.outlook.com/?url=3Dht=
tps%3A%2F%2Flists.freedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;amp;da=
ta=3D04%7C01%7Calexander.deucher%40amd.com%7C448d5309ea364844350d08d94bff9c=
47%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637624383495009435%7CUnknow=
n%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI=
6Mn0%3D%7C1000&amp;amp;sdata=3DKuBaIHeinOgubF5Mp%2FnZA45ia6FrxVdrNtTBwf7OqP=
E%3D&amp;amp;reserved=3D0</a><br>
</div>
</span></font></div>
</div>
</body>
</html>

--_000_BL1PR12MB5144DB522EE6D72995C4E2D4F7E39BL1PR12MB5144namp_--

--===============1782334239==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

--===============1782334239==--
