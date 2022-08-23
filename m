Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 30416C32772
	for <amd-gfx@archiver.kernel.org>; Tue, 23 Aug 2022 15:07:50 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A1B0D10F015;
	Tue, 23 Aug 2022 15:07:48 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2044.outbound.protection.outlook.com [40.107.244.44])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2131910F015
 for <amd-gfx@lists.freedesktop.org>; Tue, 23 Aug 2022 15:07:35 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WiAR383A39CPtwT15Ps4u5S70EfYfVqZtSppY+x1+Zy8qxTv+yIm8aRNOC3xiZ6NQPnD+N2Tk47BWN7OBesKhLGU707tCT6rwa6AZXajD5X7lf7y1QEfMGno3HQYbMFheAFEiPZYLggLPM6qVH82NppF0XEfXbS986FZ7qREksaLg6pPAGP9J5AbdOY8WFMOu3/b2mkK+Kb1cBJ1IEkOIVxawXQ6zwlqCECrINV6xFZxECaOzIt7TUpau886n5TWTLZ+BTVwM+vdE52aSE2NzUiHD9scfyiJGzdbVR3mrUrmXRprkGlzUbAOUIE4TxIvVexH8VbpAlAdfFL798i9jg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=INbj2sqKZGST4I2tUOnSqOCAz2sYGI9qBB/JjJfhuj8=;
 b=BfpkfKYa20plRDJ1+1gXrH1CyciiYWkRhO3yYxNRoowouzM0ifySSYvzWOkQlSbuqkLy92/DviMrrm+yYEcsACIQ1c+4139MnySk172x0nsqMesQFJkUTITcYvvQ5sByfuBY25WeL43gAz+T6ax+h95acLdSSWaP3msNvnUxGkB68Dab0QBv1VSjLC9oVlJyhkUBPUXv8F/eAumakb52SAqRiukvnjth9/UzmwQDh896XBzsV4VNdxDTSFAjhyETwUJS+RZrOXaoUQmKsq4cf/uBZBAbejRJmfrXG8rk+HOAfMNyv4fA6FwuKyAc43cjttAYae1Rjxw1IWggr39Qeg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=INbj2sqKZGST4I2tUOnSqOCAz2sYGI9qBB/JjJfhuj8=;
 b=YvqCg3q1W7u+4N1N1I3mD4d9jf2rrX1ZwByPf0i+NysSEwOysmAMl/0V+mHObAyt+pG6Q1Jke37JQxogxKod3Bwk+LP9joBskFf4sNVsrUn426KGtm+sz9hoTVEs0s71GnLRPpXfxk1o15y9XJuH13hXPAW9IMjX8WzPMx0pCAE=
Received: from DS0PR12MB6534.namprd12.prod.outlook.com (2603:10b6:8:c1::19) by
 DM5PR12MB1212.namprd12.prod.outlook.com (2603:10b6:3:74::15) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5546.19; Tue, 23 Aug 2022 15:07:32 +0000
Received: from DS0PR12MB6534.namprd12.prod.outlook.com
 ([fe80::cdf9:a98e:ade:43f7]) by DS0PR12MB6534.namprd12.prod.outlook.com
 ([fe80::cdf9:a98e:ade:43f7%8]) with mapi id 15.20.5546.022; Tue, 23 Aug 2022
 15:07:32 +0000
From: "Wheeler, Daniel" <Daniel.Wheeler@amd.com>
To: "Chang, Brian" <Brian.Chang@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH 00/14]  DC Patches August 22, 2022
Thread-Topic: [PATCH 00/14]  DC Patches August 22, 2022
Thread-Index: AQHYti8cWfm0a/bGTkiomBTfEzzg0628lwyA
Date: Tue, 23 Aug 2022 15:07:32 +0000
Message-ID: <DS0PR12MB65346B0820E565A8E7AA75579C709@DS0PR12MB6534.namprd12.prod.outlook.com>
References: <20220822095752.3750614-1-Brian.Chang@amd.com>
In-Reply-To: <20220822095752.3750614-1-Brian.Chang@amd.com>
Accept-Language: en-CA, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Enabled=true;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SetDate=2022-08-23T15:07:29Z; 
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Method=Privileged;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Name=Public-AIP 2.0;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ActionId=0bab260d-2bdb-4acc-b5fd-e78514901cc9;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ContentBits=1
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_enabled: true
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_setdate: 2022-08-23T15:07:30Z
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_method: Privileged
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_name: Public-AIP 2.0
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_actionid: 2104423b-face-4f7a-8216-110ed7f22680
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_contentbits: 0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 32e50a7a-5940-465b-29aa-08da85193445
x-ms-traffictypediagnostic: DM5PR12MB1212:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: aWfbL3TVZ71L2PfuqA5KE1RjOOE5Z0UDZqSZvJvEl/B/RDBki6G5BNtoS/f/uqG4wK2mdf5D6m6SSwzYjgi5ES09re4nF0h9bp0HHAkvx39wzQWud1TqI1WUvMXdDwLDVKYYaIEY14eJKoiN1Dfe+NnpitrRNKGq7k8d1itz9cBkoV7f/NEQYe/RxeIvB5N2jJ5Is1MQQrTKrcEEFmfv4NnqvMou9pIErdXGg8oIdWcoBCytf9iVfTOV8RzpAcMHYHPNQGrrHJnqestjCpKTSSMuxonEM2CFP1htZEHg3+pjG/LA8/yzY27/AXjvXsHCvWlkn9TJlT5OAPTGFrizTVdUbq39hOyhs/JVkgWMbT/Xs3THrkUYUGGY6+yKzh1hg034wclCoH/TOI0HfumF8oZejxHLgl+X/GKrNQmnr6X2jm2yl7cVuOUWXSe60I33vNop1xFzKSjhk0gJZAJA2GTwPU1reeJSnQG4ygi7M6q6NrWcAOKP5R1lomHPebrGsOQdUBTECefxWiW9cqWjBRI8Mx3B0c3h5Bz9nLNcu//aB91+c/QBM+Z0fBwLFAetI4M79YzXzZo925e8bNAm3xS7+P36iT7EseZ32Y7mzNwoIAH8l/BXb2s3w+owHCXI/PuKG8yTwPzcTy+kjU7+egqsrzVl4VauO0LlqNjvmN1iSezo6bRQg1MB7oj3xTlavyWO39Zc3K6dr3cxcQ45ntbvQRNDIVLdlOOfv5td6VwvNMe+1MGAwcUBMfdyV4KBWxdxFAJDFhPiRNtpSsWRXg==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR12MB6534.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230016)(4636009)(346002)(136003)(376002)(396003)(39860400002)(366004)(26005)(76116006)(52536014)(8936002)(5660300002)(122000001)(316002)(41300700001)(71200400001)(478600001)(66446008)(66946007)(66476007)(110136005)(4326008)(64756008)(66556008)(8676002)(38100700002)(54906003)(33656002)(9686003)(7696005)(6506007)(53546011)(83380400001)(2906002)(55016003)(38070700005)(86362001)(186003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?0MQorVTVCK8IGIq370To1UmFZuCx3yVhhk8p0rtvvnqBScVZP6sbjIhpaBw0?=
 =?us-ascii?Q?vxvHR8Qn+Uqf4wgqqJHWZzGUotvIMEGNgHGtODFm8R6aXVmBgY8AWlvjs2Pd?=
 =?us-ascii?Q?uGxtImTbVkEcgOD2HVkZvj6T96YjybxSay0DIl5O5JyBKXJT9KUCATVne9Ye?=
 =?us-ascii?Q?1KJZqB3LO5NZxM/UAOLDXmt+FQl+NLqK96DQ3auq3x37kbaK4EuqEeg2g9+E?=
 =?us-ascii?Q?yhRdl+qMTzj8HLOkXreWjdTUo6M9gnPUB5/LwGxonu56y4ifXFn4QS/d4xCV?=
 =?us-ascii?Q?j70i4jYSdcFT6y1nvowjQ6jM0VuVzvQ9S5YwDnBSck21X9fAkQDTpGRNJneK?=
 =?us-ascii?Q?+//b60OQXIeAnt2F7h+Z4FYfrGoC/0yrl5FAsQweN5u6stfIRwnDahwWP6n0?=
 =?us-ascii?Q?cd1fNEb51epHp/xSFK6mkM+Y6at07qP584mqvFW/TJVKLlJua51JPEWzVQ4j?=
 =?us-ascii?Q?tt2F0eCJLOh5Si4v/lHgQa0ll8A44vcwRMm5IlD1y14AmWBeax5LdhsEqOuF?=
 =?us-ascii?Q?m1jqtJUQYbuMD2ITrTSNxkaQmmki8g4/0n+oM99Q7nQwh014KhZA9D1sMEaD?=
 =?us-ascii?Q?8f1aa46QRgqCcoTiQHcpsbXnOemq906v3DCzuTSWn6NfkcmkssOyKVTlY32X?=
 =?us-ascii?Q?Za122X9X/JichCV5AHdp4IqrUecRlOcE+yebJpmjODY4p/5ypvRyOyOMUU/e?=
 =?us-ascii?Q?Rj2bWtxOjoNoaoSgCns/pusIHotzmrRZw2z1VRN/77jEdBXC7zgsJZLcHy0k?=
 =?us-ascii?Q?eURjgSaAi65DyQmaHCUfy/MSLBBip4DJbBsgHFUv7rIFRT/tJ/NNUwSz81jS?=
 =?us-ascii?Q?HaaRj36/Qr6kOjfBjh1hKFld/AkOw/YC5bzFl+L8uoBLLWcvol5/5uWIenl6?=
 =?us-ascii?Q?n5dumOtrbZz4ezZYJAvYzXAmAirXaU57vqcb1U3+T1nZmpRBYq34yo6KDKnF?=
 =?us-ascii?Q?gIsdJFbRBFIcNqJ1VEP1sa/gvt3PAf7+jHFw3snJXaCcldnTQJ8vRRtzOpWt?=
 =?us-ascii?Q?X0mM8eOnIr9wMfghW8k0IQXg5z6EmGVnwLcVGnKzW54zZ3C+Ql8KgwCp1CLz?=
 =?us-ascii?Q?m/+7tTrftu41NSnd0V35F60ihxBtTCYXeYo7GvnVtGPutVhyiL5p6kneiL/I?=
 =?us-ascii?Q?4KC6hdOasjQ2e67Uj2yfO+VIhB/APiDIynL3DQyyq7hn+cW+4fwKamANIfoO?=
 =?us-ascii?Q?xm25tRoLqzZO51OmcZuzT7wVOEIu+JE19Prrl5J3a+NsqbR64FMErP15Lnod?=
 =?us-ascii?Q?8c+ymMLsFCdAGoY4WEk8T20QPLp9cgun5bd7pSEnuGwkKarSSMRpNpQk6yCm?=
 =?us-ascii?Q?rU0fpoibyAZr0ap7B9hvOTTJMtWcd6wZDWN5JldWQUmfE92M5sHg7jk6N0r+?=
 =?us-ascii?Q?YRsQHw8o0P8M0BYlQFQpU+9BYys2Im3evKkT4ymhJMqm57+rK1xl6AGzNINc?=
 =?us-ascii?Q?NYZ++T4S+KD8jW+8/3A1Qy07TiGavnlNBdLdtEwJhmyzp7VucN0Du1gdbh8k?=
 =?us-ascii?Q?I8S/BY0DTIaf4zjTohF9Wxqoq5K7dGE1m78wXn7Fzpu0/ZbpCb3EYVPkQrjG?=
 =?us-ascii?Q?JtZ/D9KiQs8Y44/gRq28j3Z9oKxRnG+c/nC1d9wX?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB6534.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 32e50a7a-5940-465b-29aa-08da85193445
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Aug 2022 15:07:32.3659 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: o/XXZ6t4G7/zaiTmkM2FqahazwySk/o7e6HUIva0nkTqw7BcomSRuF331OqQ8grJs+AeAFhylTL3Vw4mwFCAiA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1212
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
Cc: "Wang, Chao-kai \(Stylon\)" <Stylon.Wang@amd.com>, "Chang,
 Brian" <Brian.Chang@amd.com>, "Li, Sun peng \(Leo\)" <Sunpeng.Li@amd.com>,
 "Lakha, Bhawanpreet" <Bhawanpreet.Lakha@amd.com>, "Zhuo,
 Qingqing \(Lillian\)" <Qingqing.Zhuo@amd.com>, "Siqueira,
 Rodrigo" <Rodrigo.Siqueira@amd.com>, "Li, 
 Roman" <Roman.Li@amd.com>, "Chiu, Solomon" <Solomon.Chiu@amd.com>, "Pillai,
 Aurabindo" <Aurabindo.Pillai@amd.com>, "Lin, Wayne" <Wayne.Lin@amd.com>,
 "Wentland, Harry" <Harry.Wentland@amd.com>, "Gutierrez,
 Agustin" <Agustin.Gutierrez@amd.com>, "Kotarac, Pavle" <Pavle.Kotarac@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[Public]

Hi all,
=20
This week this patchset was tested on the following systems:
=20
Sapphire Pulse RX5700XT=20
Reference AMD RX6800
Engineering board with Ryzen 9 5900H
=20
These systems were tested on the following display types:=20
eDP, (1080p 60hz [4500U, 5650U, 5900H])
VGA and DVI (1680x1050 60HZ [DP to VGA/DVI, USB-C to DVI/VGA])
DP/HDMI/USB-C (1440p 170hz, 4k 60hz, 4k 144hz [Includes USB-C to DP/HDMI ad=
apters])
=20
MST tested with Startech MST14DP123DP and 2x 4k 60Hz displays
DSC tested with Cable Matters 101075 (DP to 3x DP), and 201375 (USB-C to 3x=
 DP) with 3x 4k60 displays
=20
The testing is a mix of automated and manual tests. Manual testing includes=
 (but is not limited to):
Changing display configurations and settings
Benchmark testing
Feature testing (Freesync, etc.)
=20
Automated testing includes (but is not limited to):
Script testing (scripts to automate some of the manual checks)
IGT testing
=20
The patchset consists of the amd-staging-drm-next branch (Head commit - 633=
9782c00f4e5dda276b1ecc5cb167c5789aa3a) with new patches added on top of it.=
 This branch is used for both Ubuntu and Chrome OS testing (ChromeOS on a b=
i-weekly basis).

=20
Tested on Ubuntu 22.04
=20
Tested-by: Daniel Wheeler <daniel.wheeler@amd.com>
=20
=20
Thank you,
=20
Dan Wheeler
Sr. Technologist | AMD
SW Display
---------------------------------------------------------------------------=
---------------------------------------
1 Commerce Valley Dr E, Thornhill, ON L3T 7X6
amd.com

-----Original Message-----
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of brichang
Sent: August 22, 2022 5:58 AM
To: amd-gfx@lists.freedesktop.org
Cc: Wang, Chao-kai (Stylon) <Stylon.Wang@amd.com>; Chang, Brian <Brian.Chan=
g@amd.com>; Li, Sun peng (Leo) <Sunpeng.Li@amd.com>; Wentland, Harry <Harry=
.Wentland@amd.com>; Zhuo, Qingqing (Lillian) <Qingqing.Zhuo@amd.com>; Sique=
ira, Rodrigo <Rodrigo.Siqueira@amd.com>; Li, Roman <Roman.Li@amd.com>; Chiu=
, Solomon <Solomon.Chiu@amd.com>; Pillai, Aurabindo <Aurabindo.Pillai@amd.c=
om>; Lin, Wayne <Wayne.Lin@amd.com>; Lakha, Bhawanpreet <Bhawanpreet.Lakha@=
amd.com>; Gutierrez, Agustin <Agustin.Gutierrez@amd.com>; Kotarac, Pavle <P=
avle.Kotarac@amd.com>
Subject: [PATCH 00/14] DC Patches August 22, 2022

This DC patchset brings improvements in multiple areas. In summary, we have=
:

* Remove redundant check in atomic_check.
* Add log clock table for SMU.
* Add SubVP scaling.
* Add interface to track PHY state.
* Free phantom plane after removing from the context.
* Add k1/k2 driver for virtual signal for DCN32.
* Fix cursor flicker when entering PSRSU.
* Change reg offset for DCN321 and DCN32 during runtime initialization.
* Change AUX NACK behavior.
* Correct HDMI ODM combine policy.
* Fix odm 2:1 policy in 4k144 mode.
* Fix pipe split policy for RV2

Alvin Lee (2):
  drm/amd/display: Free phantom plane and stream properly
  drm/amd/display: Uncomment SubVP scaling case

Aric Cyr (1):
  drm/amd/display: 3.2.199

Aurabindo Pillai (3):
  drm/amd/display: change to runtime initialization for reg offsets for
    DCN32
  drm/amd/display: change to runtime initialization for reg offsets for
    DCN321
  drm/amd/display: program k1/k2 divider for virtual signal for DCN32

Derek Lai (1):
  drm/amd/display: do not change pipe split policy for RV2

Ilya Bakoulin (1):
  drm/amd/display: Change AUX NACK behavior

Leo Chen (1):
  drm/amd/display: Adding log clock table from SMU

Robin Chen (1):
  drm/amd/display: Cursor flicker when entering PSRSU

Roman Li (1):
  drm/amd/display: Remove redundant check in atomic_check

Saaem Rizvi (1):
  drm/amd/display: HDMI ODM Combine Policy Correction

Samson Tam (1):
  drm/amd/display: fix odm 2:1 policy not being applied consistently in
    4k144 modes

Taimur Hassan (1):
  drm/amd/display: Add interface to track PHY state

 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c |   3 -
 .../display/dc/clk_mgr/dcn31/dcn31_clk_mgr.c  |  46 +
 .../dc/clk_mgr/dcn314/dcn314_clk_mgr.c        |  48 +
 .../dc/clk_mgr/dcn315/dcn315_clk_mgr.c        |  46 +
 drivers/gpu/drm/amd/display/dc/core/dc.c      |  27 +-
 .../gpu/drm/amd/display/dc/core/dc_link_dp.c  |  12 +-
 .../gpu/drm/amd/display/dc/core/dc_resource.c |   3 -
 drivers/gpu/drm/amd/display/dc/dc.h           |   3 +-
 drivers/gpu/drm/amd/display/dc/dc_dmub_srv.c  |   5 +-
 drivers/gpu/drm/amd/display/dc/dc_link.h      |   1 +
 drivers/gpu/drm/amd/display/dc/dc_stream.h    |   2 -
 drivers/gpu/drm/amd/display/dc/dce/dce_aux.c  |  12 +-
 .../display/dc/dce110/dce110_hw_sequencer.c   |   8 +-
 .../amd/display/dc/dcn10/dcn10_hw_sequencer.c |   3 +
 .../drm/amd/display/dc/dcn10/dcn10_resource.c |  18 +
 .../drm/amd/display/dc/dcn20/dcn20_hwseq.c    |   9 +-
 .../drm/amd/display/dc/dcn31/dcn31_hwseq.c    |   9 +-
 .../drm/amd/display/dc/dcn32/dcn32_hwseq.c    |  34 +-
 .../drm/amd/display/dc/dcn32/dcn32_hwseq.h    |   3 +
 .../gpu/drm/amd/display/dc/dcn32/dcn32_init.c |   1 +
 .../drm/amd/display/dc/dcn32/dcn32_resource.c | 658 ++++++------  .../drm/=
amd/display/dc/dcn32/dcn32_resource.h | 997 ++++++++++++++++++
 .../amd/display/dc/dcn321/dcn321_resource.c   | 638 ++++++-----
 .../drm/amd/display/dc/dml/calcs/dcn_calcs.c  |  32 +-
 .../drm/amd/display/dc/dml/dcn32/dcn32_fpu.c  |   5 +
 .../gpu/drm/amd/display/dc/inc/hw/hw_shared.h |   6 +
 .../gpu/drm/amd/display/dc/inc/hw_sequencer.h |   2 +
 27 files changed, 1979 insertions(+), 652 deletions(-)

--
2.25.1
