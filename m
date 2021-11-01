Return-Path: <SRS0=Z8rF=PU=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00820C433F5
	for <amd-gfx@archiver.kernel.org>; Mon,  1 Nov 2021 13:55:26 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A66EA61058
	for <amd-gfx@archiver.kernel.org>; Mon,  1 Nov 2021 13:55:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org A66EA61058
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F2D386E093;
	Mon,  1 Nov 2021 13:55:24 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2063.outbound.protection.outlook.com [40.107.93.63])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 788AD6E093
 for <amd-gfx@lists.freedesktop.org>; Mon,  1 Nov 2021 13:55:23 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fNrQOtmo3F0LwkWXgHH/O58SiOOefPpHORh/xOJKePHJ5CiI2ihwWkft+RjI3cfY3MEM8VEVI0JtshQBl7mCMqschM7I81sRrIU26KBvLOO5ty8idp5EbW/o9AM+mWCRsyLJDJ3E+CrdMf2Vm6EIYo7TWJlib3YizGvuXZKk/sFEneTmdSfvlXccLiYPvOTwpvii7CUK4/hen3UykJvucU/kjnkAJV1QIzmJN800BM+5co4xKeACmuXOGRqKykp8EJH3Uq9/75bTRy0QHCpLOjpviuJIvXitk+6k1YvTs5mCqyfBjxIjJ+eJirTnNT45Bl1tqBGVocYaAwJwJDsPhQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zR6GHQG3ka8svbmmhPuPyXA6Sqp32Sg2FIAup6Dpquk=;
 b=iq3T2bHvVHjZkbTIwXpVrmeADd3n92aWSykWbMhRVDx4mBMf3JrtlKLQHcXAUNkR0ejwQEXRIFdxY2KI6UfsqORvalCBkenT5J6ZzHOr+AhaRzb2tOb5vAT2NQK64URsWxB/1UxGmyjfiSx6GSXLMyyY3Xj297/DdHmeQun9D7A2gKDpc+TV2k9hrklMAZpU0u/ptCUl9eua37xLSfYOQzk5wdfJksV3gUpaCTrgrlCpd9sqvO8KY9cewd40WVJaN4gbFaRXc33t4woNz1maLBP+VQYDc2bVpz9NAJb5tRhbp31jovFyoIHNaddAc0mVOLvZsq2IXXwiwJ0ScmGjEw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zR6GHQG3ka8svbmmhPuPyXA6Sqp32Sg2FIAup6Dpquk=;
 b=c/0qlF0F4+vUb1m97OVucyoxYg/vpBIRLga+v7k2FeycMCqKrhukZWyACYwMXq8np8ttT8CXlbmG0y0UllVu6H+MHedp47wzcBhykEPB2GaLuqxH+EQLEJwF/gClq5svci0/RoBIiZ7UyXWT0MbsJ9CBk84i3kCtQSwCGhk9Uik=
Received: from DM6PR12MB3529.namprd12.prod.outlook.com (2603:10b6:5:15d::18)
 by DM6PR12MB4236.namprd12.prod.outlook.com (2603:10b6:5:212::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4649.15; Mon, 1 Nov
 2021 13:55:21 +0000
Received: from DM6PR12MB3529.namprd12.prod.outlook.com
 ([fe80::ac45:5fcd:5b30:9bef]) by DM6PR12MB3529.namprd12.prod.outlook.com
 ([fe80::ac45:5fcd:5b30:9bef%5]) with mapi id 15.20.4628.020; Mon, 1 Nov 2021
 13:55:21 +0000
From: "Wheeler, Daniel" <Daniel.Wheeler@amd.com>
To: "Pillai, Aurabindo" <Aurabindo.Pillai@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH 00/14] DC patches for Nov 1, 2021
Thread-Topic: [PATCH 00/14] DC patches for Nov 1, 2021
Thread-Index: AQHXzNfB/XYC9UF/y02JpoB54VxMjqvute3A
Date: Mon, 1 Nov 2021 13:55:21 +0000
Message-ID: <DM6PR12MB35293E19A651F90CD0FE2F7C9C8A9@DM6PR12MB3529.namprd12.prod.outlook.com>
References: <20211029151456.955294-1-aurabindo.pillai@amd.com>
In-Reply-To: <20211029151456.955294-1-aurabindo.pillai@amd.com>
Accept-Language: en-CA, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Enabled=true;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SetDate=2021-11-01T13:55:18Z; 
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Method=Privileged;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Name=Public-AIP 2.0;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ActionId=e697b083-95d6-4f57-90c0-fbacacfe3707;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ContentBits=1
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: a4aa1a7e-22a2-4b4f-a7af-08d99d3f3f05
x-ms-traffictypediagnostic: DM6PR12MB4236:
x-microsoft-antispam-prvs: <DM6PR12MB423637B7988E6766ED23BDE79C8A9@DM6PR12MB4236.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: kV4q8Mg4C9kuknOsbz2rTWtvB0BtGIbOxp5VTBoZdDdEt+aFSGAy6jtepQF3LgP9hnsmUMXER0IVDl4R0K78WwG4gzgT13hKAt5UUYhV5ixe7WMvCKZImUU2+6We6FRPZc9qsZqwhb/HzNRl35jK5yHyIuedHd0ge7zbsGu7WbazDdGGercNGjnSKYtDM/IdB7X+NsTfCSLkTT+0G58MRox+M8zd5F2sOyKA1rSnIfGJWj+h/Qfv3AKqJ5eZ/xzwbEvyfD/1PoxflpNVlRRQn6qdJymVnJTQl+ivYh1T2bWQl5sQsdHMLyHrfeVCclhurMnlGuLqhgOek4VAl1DJuHWrA4zWGTTNVEVCSYZ2ZmixuA5y685ivQhYFC/yRjq/KV83d09o0rpthWX8yyPec+QZvgyhAUodY7CoGoTkFyFurbsSWLneCTSpJej+VQArpfUYB77RzRLfv+DaeSE54pQxbgoFh62fenJrX+A02/XtVMMX9e3JBoMuMgHuAtinpMtMwp08WcsMOFBPMoTD9Igi1f6495x7Tb1FxYL1VMLLDhBR217N54Yp6vTY0kH5I5i063S/wrQQo4zOaBdbKcc5gF8CM+xnhm6ZLfCA+DTFQVoUEKrNZ7eF0krLUoVOWu/cuasou+YzCelcauRYSXYO+AH3pdyedosdAsyApLbSJVttJ9g60AB7G063yQinN7YF/owXRYrp7ZAN6LdCwg==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB3529.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(33656002)(9686003)(54906003)(508600001)(122000001)(316002)(110136005)(7696005)(8936002)(86362001)(186003)(26005)(8676002)(53546011)(6506007)(38100700002)(55016002)(38070700005)(4326008)(66946007)(66476007)(66556008)(64756008)(66446008)(2906002)(71200400001)(76116006)(83380400001)(52536014)(5660300002);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?oI6uuEA/+JlaL6LfUyvS8ftQlp/ouElV6X7aN240FGwZnFnoLqs2525pXR?=
 =?iso-8859-1?Q?1swSyaDUhyKP+QKmfGr6QpgLXUXWk/DfZm6MGB5zysLJDBO2WNYKJVanLc?=
 =?iso-8859-1?Q?ecqTAYNWQdHU3F9D/EpN0vePDZLaWNYSnDrtpOA+Wu/IVnhACIVSwIXaUb?=
 =?iso-8859-1?Q?SaMMc3g5szahpR/9peE/3Q83MmgctpMbAyuv62sMOfPOgqI/jeym0k+haC?=
 =?iso-8859-1?Q?WYmS8t842W9W1e2zBmAjt+Ve2FiZarOyCgt/xttE8C7e7DJTyhHA5m3rbh?=
 =?iso-8859-1?Q?pq/mbK5BJFLvWrLY+kpYrZrpim/QR1zYTMdqMBdvINMFCtGvrRqDJg2P3X?=
 =?iso-8859-1?Q?o7U+dVlamw7Tlvv0jtSitl11YKhu2pSyK78tBX/mq1ZhPt7jUPi2MLi3Zu?=
 =?iso-8859-1?Q?KlJifDPEryj1SZCkIH/6q0jbXgl/KqrZRMu6AOCgu3EmPVHBakYe2oD4D0?=
 =?iso-8859-1?Q?dOrqxY4++50ZXKfJnAQZHD7iTSAWgzSWpKEZ24kIRLSIgJM4Gsak2RcWvB?=
 =?iso-8859-1?Q?aXXqmfZQsT7Boxng0U+92GYd2bLaGA7mhzV9RJT2ycPyxqBaOKDm6Cw3XW?=
 =?iso-8859-1?Q?bheRhqzmiv02fwB0fmgm4EWSWnceGVWEmyFsDlgGizCYbHnPPQmi4IN2WM?=
 =?iso-8859-1?Q?XAoGQX/uOxF6MKXdAiddZQoUsbexDFOA50HxJ9iD/hdbCnA87gbmphGarO?=
 =?iso-8859-1?Q?QgnjB7ABBtjVo1kP5RfCVomYZFYXMcEQELH3SzLw1Rks1It4p3GUDMZdvA?=
 =?iso-8859-1?Q?k2MZPO7HucZ93ri+mZYA4fBbNglYW6EFCboevQH3s9EuQTFZkA35nr3m87?=
 =?iso-8859-1?Q?uogWPM39kJ2BJ1/x1pQYSHex1tZpTo6bi/NS6zV8ySa/E7C0bfJN2jMROt?=
 =?iso-8859-1?Q?p9uMal/lqf2tXb9SVMTygSB3wehHYA5dqWSA9mOCAcD6e0rmryOe1TA3Zh?=
 =?iso-8859-1?Q?fngIhV5PICtJm62a92ma5ROsIQ71LeZ7KVBq4X4QcvAQ61uCwyuHBdA+V/?=
 =?iso-8859-1?Q?+55/5kE93kauC0+Hc/508Jv1Z/46oaH2Ebf7oPtFzlbXjZr9JLQ+2vRgOH?=
 =?iso-8859-1?Q?bSfKfZMbDCtqwU4t0Jmd5s0P2rBrXExpSZYrazJyKQr+JIWzLtAg7+tvNP?=
 =?iso-8859-1?Q?an0AZ+4sPvSCCps5RblpMl/F2iqUL2ggp/9IvTpDdcpEJaeTnlSx2g187B?=
 =?iso-8859-1?Q?WIGWttt7Xe7q9CxoN48Hx9zpOKgcKpKqr2kPiH85Qs/5rvde6Jn4zYwibI?=
 =?iso-8859-1?Q?doH52H1XP9t/0j4m9gMLkyG46PcUHX2odsP64QYGmdq8F4l06h2gI+dMNL?=
 =?iso-8859-1?Q?Avdizc+AdgfL+0JMkAcH3EabtAP6Vz72I91aRAXoYxlyL6hmILkYkFz+8q?=
 =?iso-8859-1?Q?x3V5UzDzDPREUA91GOHdTR7t1F5floZm1N1WMGtkgj7STfpWCLuq0Si8xx?=
 =?iso-8859-1?Q?XRYQYHVC8ipOjTxYE3F27DQmZrsWusgXLcj66FJRPwqurPapCY7ppfpdSV?=
 =?iso-8859-1?Q?B/ZVAitoobeIfygQS+HMc6rcT7zdCZvdj3uZr+l/5/y1jotQrYnR2VNSBm?=
 =?iso-8859-1?Q?WD2sM/ft0s3HQO7Bfiq6eZTbPdD1MhtAintKU//UNgOUaprbfEwsl0A7ig?=
 =?iso-8859-1?Q?mGCjfwPh6mlxbq1LSIMpGZCUWCYMxvrfzDBpWeLwy2/5VFzNjiQC6vS6xt?=
 =?iso-8859-1?Q?QRK5gkVanu6aXyGcaxs=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3529.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a4aa1a7e-22a2-4b4f-a7af-08d99d3f3f05
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Nov 2021 13:55:21.4222 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: J9sl8SULNLBFWHQX44dXwCaOI402MPgEpujsGIBJiRSlA5HKQkn+NmxQmNtKFWuZ1MCFntVwT9Zx4EXhdu8Rng==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4236
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
Cc: "Wang, Chao-kai \(Stylon\)" <Stylon.Wang@amd.com>, "Chiu,
 Solomon" <Solomon.Chiu@amd.com>, "Li, Sun peng \(Leo\)" <Sunpeng.Li@amd.com>,
 "Wentland, Harry" <Harry.Wentland@amd.com>, "Zhuo,
 Qingqing" <Qingqing.Zhuo@amd.com>, "Siqueira,
 Rodrigo" <Rodrigo.Siqueira@amd.com>, "Li, Roman" <Roman.Li@amd.com>, "Jacob,
 Anson" <Anson.Jacob@amd.com>, "Pillai, Aurabindo" <Aurabindo.Pillai@amd.com>,
 "Lin, Wayne" <Wayne.Lin@amd.com>, "Lipski, Mikita" <Mikita.Lipski@amd.com>,
 "Lakha, Bhawanpreet" <Bhawanpreet.Lakha@amd.com>, "Gutierrez, 
 Agustin" <Agustin.Gutierrez@amd.com>, "Kotarac, Pavle" <Pavle.Kotarac@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[Public]

Hi all,
=A0
This week this patchset was tested on the following systems:
=A0
HP Envy 360, with Ryzen 5 4500U, with the following display types: eDP 1080=
p 60hz, 4k 60hz  (via USB-C to DP/HDMI), 1440p 144hz (via USB-C to DP/HDMI)=
, 1680*1050 60hz (via USB-C to DP and then DP to DVI/VGA)
=A0
AMD Ryzen 9 5900H, with the following display types: eDP 1080p 60hz, 4k 60h=
z  (via USB-C to DP/HDMI), 1440p 144hz (via USB-C to DP/HDMI), 1680*1050 60=
hz (via USB-C to DP and then DP to DVI/VGA)
=A0
Sapphire Pulse RX5700XT with the following display types:
4k 60hz  (via DP/HDMI), 1440p 144hz (via DP/HDMI), 1680*1050 60hz (via DP t=
o DVI/VGA)
=A0
Reference AMD RX6800 with the following display types:
4k 60hz  (via DP/HDMI and USB-C to DP/HDMI), 1440p 144hz (via USB-C to DP/H=
DMI and USB-C to DP/HDMI), 1680*1050 60hz (via DP to DVI/VGA)
=A0
Included testing using a Startech DP 1.4 MST hub at 2x 4k 60hz, and 3x 1080=
p 60hz on all systems. Also tested DSC via USB-C to DP DSC Hub with 3x 4k 6=
0hz on Ryzen 9 5900h and Ryzen 5 4500u.
=A0
Tested on Ubuntu 20.04.3 with Kernel Version 5.13 and ChromeOS
=A0
Tested-by: Daniel Wheeler <daniel.wheeler@amd.com>
=A0
=A0
Thank you,
=A0
Dan Wheeler
Technologist  |  AMD
SW Display
---------------------------------------------------------------------------=
---------------------------------------
1 Commerce Valley Dr E, Thornhill, ON L3T 7X6
Facebook=A0|=A0=A0Twitter=A0|=A0=A0amd.com=A0=A0

-----Original Message-----
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Aurabind=
o Pillai
Sent: October 29, 2021 11:15 AM
To: amd-gfx@lists.freedesktop.org
Cc: Wentland, Harry <Harry.Wentland@amd.com>; Li, Sun peng (Leo) <Sunpeng.L=
i@amd.com>; Lakha, Bhawanpreet <Bhawanpreet.Lakha@amd.com>; Siqueira, Rodri=
go <Rodrigo.Siqueira@amd.com>; Pillai, Aurabindo <Aurabindo.Pillai@amd.com>=
; Zhuo, Qingqing <Qingqing.Zhuo@amd.com>; Lipski, Mikita <Mikita.Lipski@amd=
.com>; Li, Roman <Roman.Li@amd.com>; Jacob, Anson <Anson.Jacob@amd.com>; Li=
n, Wayne <Wayne.Lin@amd.com>; Wang, Chao-kai (Stylon) <Stylon.Wang@amd.com>=
; Chiu, Solomon <Solomon.Chiu@amd.com>; Kotarac, Pavle <Pavle.Kotarac@amd.c=
om>; Gutierrez, Agustin <Agustin.Gutierrez@amd.com>
Subject: [PATCH 00/14] DC patches for Nov 1, 2021

This DC patchset brings improvements in multiple areas. In summary, we high=
light:

* DC release version 3.2.160
* DMUB fw version 0.0.91 and bug fixes
* DSC related fixes
* Minor power optimization improvements
* Bug fixes and improvements in display pipeline

-------------------------------

Anson Jacob (1):
  drm/amd/display: Fix dcn10_log_hubp_states printf format string

Anthony Koo (1):
  drm/amd/display: [FW Promotion] Release 0.0.91

Aric Cyr (1):
  drm/amd/display: 3.2.160

Aurabindo Pillai (1):
  drm/amd/display: add condition check for dmub notification

Bing Guo (1):
  drm/amd/display: Fix bpc calculation for specific encodings

Felipe Clark (1):
  drm/amd/display: Fix dummy p-state hang on monitors with extreme
    timing

Hersen Wu (1):
  drm/amd/display: dsc engine not disabled after unplug dsc mst hub

Jake Wang (3):
  drm/amd/display: Added HPO HW control shutdown support
  drm/amd/display: Add MPC meory shutdown support
  drm/amd/display: Added new DMUB boot option for power optimization

Jimmy Kizito (1):
  drm/amd/display: Clear encoder assignments when state cleared.

Roman Li (1):
  drm/amd/display: Force disable planes on any pipe split change

Wenjing Liu (1):
  drm/amd/display: fix register write sequence for LINK_SQUARE_PATTERN

Yu-ting Shen (1):
  drm/amd/display: avoid link loss short pulse stuck the system

 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c |  31 ++--
 .../display/amdgpu_dm/amdgpu_dm_mst_types.c   | 150 ++++++++++++++----
 drivers/gpu/drm/amd/display/dc/core/dc.c      |   8 +-
 drivers/gpu/drm/amd/display/dc/core/dc_link.c |   2 +
 .../gpu/drm/amd/display/dc/core/dc_link_dp.c  |   8 +
 .../drm/amd/display/dc/core/dc_link_enc_cfg.c |  22 +++
 drivers/gpu/drm/amd/display/dc/dc.h           |   3 +-
 drivers/gpu/drm/amd/display/dc/dc_dp_types.h  |   3 +
 .../gpu/drm/amd/display/dc/dce/dce_hwseq.h    |   4 +-
 .../display/dc/dce110/dce110_hw_sequencer.c   |   6 +
 .../amd/display/dc/dcn10/dcn10_hw_sequencer.c |   2 +-
 .../drm/amd/display/dc/dcn20/dcn20_hwseq.c    |   3 +
 .../gpu/drm/amd/display/dc/dcn30/dcn30_mpc.c  |   7 +-
 .../drm/amd/display/dc/dcn30/dcn30_resource.c |   7 +-
 .../drm/amd/display/dc/dcn31/dcn31_hwseq.c    |  78 +++++----
 .../drm/amd/display/dc/dcn31/dcn31_hwseq.h    |   1 +
 .../gpu/drm/amd/display/dc/dcn31/dcn31_init.c |   1 +
 .../drm/amd/display/dc/dcn31/dcn31_resource.c |   6 +-
 .../dc/dml/dcn30/display_mode_vba_30.c        |  13 +-
 .../dc/dml/dcn31/display_mode_vba_31.c        |  14 +-
 drivers/gpu/drm/amd/display/dc/inc/hw/mpc.h   |   1 +
 .../amd/display/dc/inc/hw_sequencer_private.h |   1 +
 drivers/gpu/drm/amd/display/dmub/dmub_srv.h   |   1 +
 .../gpu/drm/amd/display/dmub/inc/dmub_cmd.h   |   4 +-
 .../gpu/drm/amd/display/dmub/src/dmub_dcn31.c |   1 +
 25 files changed, 271 insertions(+), 106 deletions(-)

--=20
2.30.2
