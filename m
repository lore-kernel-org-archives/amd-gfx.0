Return-Path: <SRS0=XteM=PG=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5FA4C433F5
	for <amd-gfx@archiver.kernel.org>; Mon, 18 Oct 2021 17:01:28 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5EDD861074
	for <amd-gfx@archiver.kernel.org>; Mon, 18 Oct 2021 17:01:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 5EDD861074
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CFA386E866;
	Mon, 18 Oct 2021 17:01:27 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2041.outbound.protection.outlook.com [40.107.93.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D14C86E866
 for <amd-gfx@lists.freedesktop.org>; Mon, 18 Oct 2021 17:01:25 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=c3P97HzMZg4fUku1OFTnf3bGz98EzP/BmgRNToPaC3yzrH9hJf4hXMf+z7EHO83W8kwGnzbNQG25TfA4zo+BL+zcN2gV7fyXYcMbNXb92uR4/1LtBNIeHJvsPEBBtlVli1rLZj/7/9jBkWnj3LD6wKymvq+PXpdlpPgTM2kwWl4R1xBD1d/oCj5q5DOig/CWcTZ7qIUfkKlUQMdyyjgSGNtBGvxAnrX8mV6G31qm2/AX5S6UicSW+bdo4Fy/PCbWm68K84dgTF0GZ6w5QMq+gEk9bKiiki2QFk2PeiQcIXdgDnG+kPDiWBubNfJk6qee4miiutxK6x5Z6qSRN4iaVg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DQoglFVFbFMUuJlijWZ4TsPxkiwEsd/7rCLkapG/85A=;
 b=XVl+9ILWftmiFJ2suCk//93ObBLxdGZXsHZIr83/hSTx6GX+TMmOyNSRpGjwa4F4iuPE80FIpLroFvzTLs+JMODBDHWsoGei7cAZgpvv2ubMcc88d3yu4qT+yVQ2K8MdN+Jy1jv5Uyrf3ahrfI4EMbnaTMJ+fc3vcMwGBtnIh3f0f4niVzU2mgz1dpCyFAeUKIBRzFBu8sYTQq8FuvaXKWAhLfDfn9hTadjdgvx0owxD9QlBEq77OesTxLjv55ggjv2cQ58XnLNfEabCofuGmlL+sl2AJ6JlLQtPzAIaPPqfZEpc3ENdc4qlHxO1VcdLKRF9adVOhBdt7vT/2kcKDQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DQoglFVFbFMUuJlijWZ4TsPxkiwEsd/7rCLkapG/85A=;
 b=i757eb1ZflMx+ACsP5iMXVA17RTwmHIJwsN6yy6RpNI/ms9jITuDKU8PX0WNl+/zNW+CUjBGgh6kyNieq1YQ6IBHPWH6ZucmTqOs/H2tsKyKbqAS38LLqmUur76uJTMLK19ZZpXW+KoZgUYokUzUdK4hTYzUUpjVKBhQttAu9J0=
Received: from DM6PR12MB3529.namprd12.prod.outlook.com (2603:10b6:5:15d::18)
 by DM6PR12MB3708.namprd12.prod.outlook.com (2603:10b6:5:1c5::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4608.18; Mon, 18 Oct
 2021 17:01:21 +0000
Received: from DM6PR12MB3529.namprd12.prod.outlook.com
 ([fe80::ac45:5fcd:5b30:9bef]) by DM6PR12MB3529.namprd12.prod.outlook.com
 ([fe80::ac45:5fcd:5b30:9bef%5]) with mapi id 15.20.4608.018; Mon, 18 Oct 2021
 17:01:21 +0000
From: "Wheeler, Daniel" <Daniel.Wheeler@amd.com>
To: "Gutierrez, Agustin" <Agustin.Gutierrez@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
CC: "Wentland, Harry" <Harry.Wentland@amd.com>, "Li, Sun peng (Leo)"
 <Sunpeng.Li@amd.com>, "Lakha, Bhawanpreet" <Bhawanpreet.Lakha@amd.com>,
 "Siqueira, Rodrigo" <Rodrigo.Siqueira@amd.com>, "Pillai, Aurabindo"
 <Aurabindo.Pillai@amd.com>, "Zhuo, Qingqing" <Qingqing.Zhuo@amd.com>,
 "Lipski, Mikita" <Mikita.Lipski@amd.com>, "Li, Roman" <Roman.Li@amd.com>,
 "Jacob, Anson" <Anson.Jacob@amd.com>, "Lin, Wayne" <Wayne.Lin@amd.com>,
 "Wang, Chao-kai (Stylon)" <Stylon.Wang@amd.com>, "Chiu, Solomon"
 <Solomon.Chiu@amd.com>, "Kotarac, Pavle" <Pavle.Kotarac@amd.com>,
 "Broadworth, Mark" <Mark.Broadworth@amd.com>
Subject: RE: [PATCH 00/27] DC Patchset for October 15
Thread-Topic: [PATCH 00/27] DC Patchset for October 15
Thread-Index: AQHXwfSZ1WCkUukPKU6GnvvScGLtzavY/3+g
Date: Mon, 18 Oct 2021 17:01:20 +0000
Message-ID: <DM6PR12MB35294FF2AB0360BE93BE79259CBC9@DM6PR12MB3529.namprd12.prod.outlook.com>
References: <20211015184332.221091-1-agustin.gutierrez@amd.com>
In-Reply-To: <20211015184332.221091-1-agustin.gutierrez@amd.com>
Accept-Language: en-CA, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Enabled=true;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SetDate=2021-10-18T17:01:19Z; 
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Method=Privileged;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Name=Public-AIP 2.0;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ActionId=7b1310ed-e0da-4a90-bb2c-3490395382e6;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ContentBits=1
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 939ba777-3796-4292-c067-08d99258e8db
x-ms-traffictypediagnostic: DM6PR12MB3708:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM6PR12MB37085C7498ECFEEE87322A1C9CBC9@DM6PR12MB3708.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 0FRAzh4/QP/CdW1kIPwjxPkUKbjjfblZuTAFez7Zr9i3H0itf3Q4caoiiVbeJnZSNBA2FQ9QFxEULotbezvVFW8rxXYkcfePUpN+yQQDGmg45hV54Ts+/hVMbbJd8E6uksa7/ZYDxNQ7Fjcey5GZM6m5V5kjUDF5Hrd492u+OYDXcuCAvHtKk3xgtSQMeixLEHgg41vIPdOVVwOyDtlOtwrYXKOm67xknOv27QomWx4TxCas3L0yaxInFEWE3/kk4PVrh2bssUSgH1iWqMvcFkxKWzAg4KcnVLPCj6IEbDbYkxKgUGT70h2TkYOus9pQcQtYJvffhOrp+/4xH6pk6L59FW8BeiomgeGgDJMzMkOzFa447QKOOqN2ONsK9dj1wRLopSE5XaKnBIq4l+aw8hXTkgtB4rkwMWPBqiNfBR3dJ/ekgbg3J3dob0Llen0xtebPuQ2YawTLbvtSH1/Xvoxg2On118+lexlFLzRj2c2bQQfvo9Z5kiXz4ixY2Xss6hCw+Hzhs+7M2DSrF9nS7CRs1GYLe35ZE2uBXNTe2fxu/9lY6zxtW4lnogwDy6rHYZVWTHF8WR0NhTUc6KXbE4mVwLthcqeovTaiwSk+hdJav8MlSLiimayotH8I+8ACvTgNq3lx+qC0/h+nSdAk9zCCvUrHhNxa8It7YtPUapES3r0HNJa0zFROpKLapbM/cs46aVjhNK5JuvuqClXFyA==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB3529.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(38070700005)(66946007)(26005)(110136005)(66476007)(64756008)(54906003)(8936002)(66556008)(6506007)(53546011)(86362001)(8676002)(186003)(71200400001)(7696005)(2906002)(76116006)(316002)(4326008)(66446008)(83380400001)(33656002)(55016002)(5660300002)(508600001)(9686003)(38100700002)(122000001)(52536014);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?liAugQAyN3YH6sq3jm1uFBTEpd1m+q9EZpSTniqYwCHMWzQkNDG9PrO7CF?=
 =?iso-8859-1?Q?4qq78hcD4BLriOzUQlQNoVCIv4bZGEJtpUgnZEXIVOqIT3eWrjgxkek8e3?=
 =?iso-8859-1?Q?g6zD4rnp5Vqj9+ESPAsWmdiRvYufkrULei4KIcsvrzKBD23KBZ6GLNhRLp?=
 =?iso-8859-1?Q?I6ufwa/AtgMvoTs4nK+J27lanl+K1l/uT4R8IGwiti5PXX7478pHRvXUJ+?=
 =?iso-8859-1?Q?+gbwWe2VVECpd3DemaKdLkiSvxDfV1b5Ly8Cqhl19xU2somWwVKfMbPdLH?=
 =?iso-8859-1?Q?vOwsuUTvgSbtssbhzwRk1lIDrR4hTgy9k6X6/g6ydRPmG7DsXdeCXpHO32?=
 =?iso-8859-1?Q?7SDFDlrIxxMwo6GbC6OQenBFMDBO+gw3kKUIhueLNBCEBuTnc0ctzRbXkN?=
 =?iso-8859-1?Q?hwCWx2+Tk95d1SW9NBKLyHdOGRSo4nuvd83K7rmEv1m0X8hIdtVc2CuhzE?=
 =?iso-8859-1?Q?W1A4PhlRfWf9VxZkCQL/x4rU+HvwLgM9jtrVl0wtYmY3UOWUdS/fONPHIx?=
 =?iso-8859-1?Q?3bDc0tghw4+0MtYoZvbHcM375K+aQiWcx1WgKsbh9Vry+BhYmdwioJWClu?=
 =?iso-8859-1?Q?GcM7Q2ODrXuPhb1unv/EbW5/muP8buV3KwRUh0MMZjBIaz31F1IpdfiEwx?=
 =?iso-8859-1?Q?Fv0gfecA5AbXPQNyk5b/tvnSs4q2pO5+C1sqo9dMxIDm4rpY+mDk/KCaCQ?=
 =?iso-8859-1?Q?IM6WGLlQ+yqR5CgOTEjtNDeErHSMbgBoM4oD6jZfs9OTYAnp0KO6x99Exk?=
 =?iso-8859-1?Q?/GGJ7CyWdaopSAgbTuCW46Zz/Qt6RzENS/YKpjOOqOx+Sl7MZqUzPELrcD?=
 =?iso-8859-1?Q?LaYt0OwbRWR/9ArpBzB0MrB1IX6jARt/JoKU7v/+JQUbW5iwgScCyIXIel?=
 =?iso-8859-1?Q?s8Kg+71DcZeKa6OzGsiPJwvkk7juwdfqEoEUE5haRtkI/oHRWaSgzbmSRI?=
 =?iso-8859-1?Q?5Jm0WW0P4pV0pAntxkFaaXwsJZagVZ4Dr/SNGaTdZZ/i7HIM2MGKIyCA3+?=
 =?iso-8859-1?Q?O1dJz6ojrvGCvb10pD0Bu4GtREWBvnMrDQXoEb/W5T82wz/UQ/T82iWQQQ?=
 =?iso-8859-1?Q?iwnhgPeHy/QfYFPStfAztT4EabMRZVv4Sa2nlaD67JRTsoWi3ozAlloDjO?=
 =?iso-8859-1?Q?FPkKapzxK9GFnNTp03qwbgu4xDNMJc/VsOmLni5WRC6IiTVMTzf3AiuaU0?=
 =?iso-8859-1?Q?bESh6vDo5270yuUoqB/1dtMxfJDVUf8NdaBYKq1hbVCAI1zA6FXh5vOio8?=
 =?iso-8859-1?Q?9UkuZNL4qnfPM0OXkqVZEstOnSyWnRUKttrTjWUinkibSIxKDAcrxL3mka?=
 =?iso-8859-1?Q?44mq40meMG142TgI5bitREYGQGRj5KPrZnfeCJ5JSTYaptw=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3529.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 939ba777-3796-4292-c067-08d99258e8db
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Oct 2021 17:01:20.9509 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: wfTEOMv0XjMP+FjVEmyUkscUXdBSGw9tRJoC1RXUOYWwn7saycYC5lLEIf7KlywnYJOD7bOnYL2F7HESxRfzOQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3708
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
p 60hz on all systems.
=A0
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
From: Gutierrez, Agustin <Agustin.Gutierrez@amd.com>=20
Sent: October 15, 2021 2:43 PM
To: amd-gfx@lists.freedesktop.org
Cc: Wentland, Harry <Harry.Wentland@amd.com>; Li, Sun peng (Leo) <Sunpeng.L=
i@amd.com>; Lakha, Bhawanpreet <Bhawanpreet.Lakha@amd.com>; Siqueira, Rodri=
go <Rodrigo.Siqueira@amd.com>; Pillai, Aurabindo <Aurabindo.Pillai@amd.com>=
; Zhuo, Qingqing <Qingqing.Zhuo@amd.com>; Lipski, Mikita <Mikita.Lipski@amd=
.com>; Li, Roman <Roman.Li@amd.com>; Jacob, Anson <Anson.Jacob@amd.com>; Li=
n, Wayne <Wayne.Lin@amd.com>; Wang, Chao-kai (Stylon) <Stylon.Wang@amd.com>=
; Chiu, Solomon <Solomon.Chiu@amd.com>; Kotarac, Pavle <Pavle.Kotarac@amd.c=
om>; Gutierrez, Agustin <Agustin.Gutierrez@amd.com>; Wheeler, Daniel <Danie=
l.Wheeler@amd.com>; Broadworth, Mark <Mark.Broadworth@amd.com>
Subject: [PATCH 00/27] DC Patchset for October 15

This DC patchset brings improvements in multiple areas. In summary, we
highlight:

* Fix some issues such as DP2 problem, prefetch bandwidth calculation for D=
CN3.1 and others.
* Increased Z9 latency and removed z10 save after dsc disable.
* Revert a couple of bad changes.
* Added missing PSR state patch.

Cc: Daniel Wheeler <daniel.wheeler@amd.com>
Cc: Mark Broadworth <mark.broadworth@amd.com>

Agustin Gutierrez (2):
  Revert "drm/amd/display: Fix error in dmesg at boot"
  Revert "drm/amd/display: Add helper for blanking all dp displays"

Anthony Koo (2):
  drm/amd/display: Change initializer to single brace
  drm/amd/display: [FW Promotion] Release 0.0.88

Aric Cyr (2):
  drm/amd/display: Validate plane rects before use
  drm/amd/display: 3.2.157

Eric Yang (1):
  drm/amd/display: increase Z9 latency to workaround underflow in Z9

Hansen (1):
  drm/amd/display: Fix DP2 SE and LE SYMCLK selection for B0 PHY

Jake Wang (6):
  drm/amd/display: Disable dpp root clock when not being used
  drm/amd/display: Disable dsc root clock when not being used
  drm/amd/display: Disable dpstreamclk, symclk32_se, and symclk32_le
  drm/amd/display: Removed z10 save after dsc disable
  drm/amd/display: Moved dccg init to after bios golden init
  drm/amd/display: Disable hdmistream and hdmichar clocks

Jimmy Kizito (2):
  drm/amd/display: Clear encoder assignment for copied streams
  drm/amd/display: Do not skip link training on DP quick hot plug

Josip Pavic (1):
  drm/amd/display: do not compare integers of different widths

Lai, Derek (1):
  drm/amd/display: Removed power down on boot from DCN31

Michael Strauss (1):
  drm/amd/display: Clean Up VPG Low Mem Power

Mikita Lipski (1):
  drm/amd/display: Add missing PSR state

Nevenko Stupar (1):
  drm/amd/display: Add bios parser support for latest firmware_info

Nicholas Kazlauskas (2):
  drm/amd/display: Fix prefetch bandwidth calculation for DCN3.1
  drm/amd/display: Require immediate flip support for DCN3.1 planes

Nikola Cornij (2):
  drm/amd/display: Limit display scaling to up to true 4k for DCN 3.1
  drm/amd/display: Increase watermark latencies for DCN3.1

Wenjing Liu (2):
  drm/amd/display: add DP2.0 debug option to set MST_EN for SST stream
  drm/amd/display: correct apg audio channel enable golden value

 .../drm/amd/display/dc/bios/bios_parser2.c    |  90 ++++++-
 .../display/dc/clk_mgr/dcn31/dcn31_clk_mgr.c  |  21 +-
 drivers/gpu/drm/amd/display/dc/core/dc.c      |  10 -
 drivers/gpu/drm/amd/display/dc/core/dc_link.c |  63 +----
 .../gpu/drm/amd/display/dc/core/dc_link_ddc.c |   2 +-
 .../gpu/drm/amd/display/dc/core/dc_link_dp.c  |  32 +--
 .../drm/amd/display/dc/core/dc_link_enc_cfg.c |   9 +-
 .../gpu/drm/amd/display/dc/core/dc_resource.c |   5 +
 .../gpu/drm/amd/display/dc/core/dc_stream.c   |   4 +
 drivers/gpu/drm/amd/display/dc/dc.h           |   3 +-
 drivers/gpu/drm/amd/display/dc/dc_link.h      |   1 -
 drivers/gpu/drm/amd/display/dc/dc_types.h     |   1 +
 drivers/gpu/drm/amd/display/dc/dce/dmub_psr.c |   2 +
 .../display/dc/dce110/dce110_hw_sequencer.c   |  24 +-
 .../amd/display/dc/dcn10/dcn10_hw_sequencer.c |  49 +++-  .../gpu/drm/amd/=
display/dc/dcn20/dcn20_dccg.h |  34 ++-
 .../drm/amd/display/dc/dcn20/dcn20_hwseq.c    |   4 +-
 .../drm/amd/display/dc/dcn30/dcn30_hwseq.c    |  39 ++-
 .../gpu/drm/amd/display/dc/dcn31/dcn31_apg.c  |   2 +-
 .../gpu/drm/amd/display/dc/dcn31/dcn31_dccg.c | 237 +++++++++++++++++-  ..=
./gpu/drm/amd/display/dc/dcn31/dcn31_dccg.h |  34 ++-
 .../drm/amd/display/dc/dcn31/dcn31_hwseq.c    | 114 +++++----
 .../drm/amd/display/dc/dcn31/dcn31_resource.c |  17 +-
 .../dc/dml/dcn31/display_mode_vba_31.c        |   6 +-
 drivers/gpu/drm/amd/display/dc/inc/hw/dccg.h  |   9 +
 .../gpu/drm/amd/display/dc/inc/link_enc_cfg.h |   2 +-
 .../gpu/drm/amd/display/dmub/inc/dmub_cmd.h   |   4 +-
 .../include/asic_reg/dcn/dcn_3_1_2_offset.h   |   2 +
 .../include/asic_reg/dcn/dcn_3_1_2_sh_mask.h  |   8 +
 29 files changed, 643 insertions(+), 185 deletions(-)

--
2.25.1
