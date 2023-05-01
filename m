Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 35830C77B73
	for <amd-gfx@archiver.kernel.org>; Mon,  1 May 2023 15:16:51 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6B96A10E319;
	Mon,  1 May 2023 15:16:50 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2043.outbound.protection.outlook.com [40.107.94.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 89A5210E319
 for <amd-gfx@lists.freedesktop.org>; Mon,  1 May 2023 15:16:48 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oe6C9HlNcumRSbLY/WV3YhVxcqAQQXACiFRfuilOyZ+lU9goGetyxpR0/j+yjrtWGVGjPqFf9w3EKFmtnoz1DwaNSdul84sAHJvoLd6FSNXrtf7gxYWowDXXtvcWhIe683Fjz88821ohlwGMo5Z1tjNxTGY33vfUBJuXqTSitLnPIcKvxoptmlwehgKb6+QFA5+6datuFk8wlcg4g50/i37JD4goiJhCNvbPzKNirD9pWnlwQS0Pr5myVwk4RFBVFro0OOlaY6U1ZvtsU3AXSuJYTeub7aemYczmJ/agd1BT5y3O2WY8VtyS67NldViUOpMLwFI/eEGBoJAMTIDIUA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=idTwm8tDMfZlVGgzVOiH/f4BWbyg26SdfAhGpL7qxEo=;
 b=f1pTvAtRboF2gJDZVrcJE4q0LaiPSioYvvK/FzFRThYHNlYp0ingf7jL93+nZVoFzbPsfQMhG4x0ScBMQkNkpBDBMlnGJlg6m6SwGqNSsmSAbj+qgsKjmPzuGA0s6zHp8Xv8wD5TRuqCVYJazgQRF/X5tFS8j4/obSd6Eoiv7KbvOO7rmbfh32KsVgNE9J0ZxUS1SQ/8M/K7PNWeRnF/+ZjG2MxFvUSOskRG7VmRY9cJkrr9m0+WaB3ajZfoFJgHepCaqqeEuvzSQRDNIFOAfoIOQzRoxWlXPpfoLsxLCBacauqVX+kS+lLgNEfP14X7CLCWAcE1sstCFFNJeKKyeQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=idTwm8tDMfZlVGgzVOiH/f4BWbyg26SdfAhGpL7qxEo=;
 b=DndhplgS9sRBDURD/5Okm1W3nGhPNrRiGV2mfXRNkzLkxydmBNOPTg97p+V/SuOOtMEdoAfFrV3t9QKIb4+qlHA8Qbs75tFtB+MoEAVQUFGkeCFpF048Ffmzr7QNSVObZVOu8m5WAtcXf1WUNga5MnFIcxS12z1mYCadcMf+YG0=
Received: from DS0PR12MB6534.namprd12.prod.outlook.com (2603:10b6:8:c1::19) by
 SJ1PR12MB6361.namprd12.prod.outlook.com (2603:10b6:a03:455::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6340.30; Mon, 1 May
 2023 15:16:44 +0000
Received: from DS0PR12MB6534.namprd12.prod.outlook.com
 ([fe80::d28:1514:96a7:864e]) by DS0PR12MB6534.namprd12.prod.outlook.com
 ([fe80::d28:1514:96a7:864e%6]) with mapi id 15.20.6340.030; Mon, 1 May 2023
 15:16:43 +0000
From: "Wheeler, Daniel" <Daniel.Wheeler@amd.com>
To: "Liu, HaoPing (Alan)" <HaoPing.Liu@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH 0/8] DC Patches April 26, 2023
Thread-Topic: [PATCH 0/8] DC Patches April 26, 2023
Thread-Index: AQHZeFv6DWtQBIQqkUKbWeiHBNyLNa9Fjp4Q
Date: Mon, 1 May 2023 15:16:43 +0000
Message-ID: <DS0PR12MB65349AFE49B7ED6EDC19A2F39C6E9@DS0PR12MB6534.namprd12.prod.outlook.com>
References: <20230426162712.895717-1-HaoPing.Liu@amd.com>
In-Reply-To: <20230426162712.895717-1-HaoPing.Liu@amd.com>
Accept-Language: en-CA, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Enabled=true;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SetDate=2023-05-01T15:16:41Z; 
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Method=Privileged;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Name=Public-AIP 2.0;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ActionId=9564a34e-71d8-416f-8aba-b88a39fe1786;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ContentBits=1
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_enabled: true
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_setdate: 2023-05-01T15:16:41Z
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_method: Privileged
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_name: Public-AIP 2.0
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_actionid: a8f4b50b-5b3a-40c0-8c55-c39776a17bd2
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_contentbits: 0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS0PR12MB6534:EE_|SJ1PR12MB6361:EE_
x-ms-office365-filtering-correlation-id: d4cad320-f1cb-478a-3aee-08db4a571237
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 2y8YocRqOPYzBKfdsAdPprcF0xl2CGFzDFozB5Vm/3CpJMox9D2+W2dyz/P7z7OHbpjS5PhA5miDSlPs5DL/STs8WX5ZVcw8uhgmBVf3sunpBrhXZJUNfyMphWFFK/WMv8edRbu6GJ+ugovIScu98gasAMslgOAzuynlf+rxwKGYkCJbYqnuf4zzsD13s6XJhrRlPNUjWhakyKDgpVI/wVJ3V86R5uAN+uwvGr6TnmvR0a38fVxeC069SkkBTiCDsSKnA6MdqNqK3i5P7jlGKazz9gckiqoNSudW5bSxuk12Umv1XPapxfaVZKNf7L9xk9h6wpIS0LILLvZpFy/hs/BvzkZPFiOISKap/XnTHusKtqRP6KdGRYYMbCY1h7nS+NNDwWE3uwdNsbBG9Uam+RHZUotb1HrJOvnyrgm1Mdr4qMTbI7tC2fe5tKNSb77SgZGpQv4LEjsq5wBVpsyseI+1cRCa8xs0gn9HmSm5t9Av70L4Uu0lDwG51bS9BbmqAFNQvo1V/vg7gpySGP4gtSZje9x6aZcikxmg8IdGYKscWY1P7QEt3c4YWy5XloXpbGLLCcJt6uiuNf3W7sNXs19v+HlWUSrSWKru3c+K4UaAfZ7wKmf0SqnAA87WiUm3
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR12MB6534.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(4636009)(366004)(376002)(396003)(39860400002)(346002)(136003)(451199021)(316002)(53546011)(9686003)(26005)(6506007)(55016003)(8936002)(5660300002)(8676002)(38070700005)(33656002)(86362001)(52536014)(478600001)(64756008)(66946007)(66446008)(76116006)(66476007)(110136005)(66556008)(41300700001)(83380400001)(186003)(54906003)(38100700002)(2906002)(122000001)(7696005)(71200400001)(4326008);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?/TJysLcoYT7B0kEkYuCXM+8xgRXKQIRFM5u0MsJbZSNjFgrb5kW6FVqioI5p?=
 =?us-ascii?Q?3gBfM6iooRmst0Ik7DdweohgON23SFBf08cT5onafPhwH6NRvySwBum6xXmt?=
 =?us-ascii?Q?MrepVaJEXefgqUaFr8v+VRXKrjvmAcnKh2/jxxfG3iyAvRzcXrtzdVsw0DLk?=
 =?us-ascii?Q?e81pORAvEYEAS3MmbGV5l+cvY5kVprwTvFvhQuFkXQvCcEARU8u/3C5h1VlS?=
 =?us-ascii?Q?e2HlbODzTiqZxmzNJcmfjogU2O5F0J1njOFkx2qz4LgbESh2JySMSjm9PMkq?=
 =?us-ascii?Q?G+BckPowSq5TKzzjV53jNqN+NSGpp0KKvF+CleNoPIRh7y8tgMTcgjf9NEwk?=
 =?us-ascii?Q?F/PztLxqtPtKxj6NDW9+diwzH0FJwNl9Oltye1Vnuo9ylarodCwavS4qfWEC?=
 =?us-ascii?Q?c2f4PJeIFTdaCw4VwUo/3OkS6dCPyyCNdl/QSbL+umQVyLpC5kf5YENAAtyZ?=
 =?us-ascii?Q?/6Td4GTW/Qqztkx2CPhcykj6k1f3gREOIhHqk5LW0dZXGEcj3sfjW+Us8qRs?=
 =?us-ascii?Q?zuiOTVz2my1OdTGm32i27BlLVz5RbMvOKuN/5h3cDV3idDbYepJThRaA1hmS?=
 =?us-ascii?Q?Pm3eXE1GQ0r37uUW4h/HZ11EKfMl1rt1ZxQLO4w1qEcWbiUTxp1H46k0aSjx?=
 =?us-ascii?Q?DBN8b2F7dHEh7wkgpPX/RUlm2TpyC4RTYS4pCyv11idchmOH55z4nNafVxr2?=
 =?us-ascii?Q?2i7gYocpUiwSw+0YlyFeLPJOl3qivdlJ3UNJXtGMAvEo0BOHeRxul5a4UD1D?=
 =?us-ascii?Q?EWeszJMrzNwG0EK5YFm41EIY55T7tObwpLPRdCT7u3FGf1rDLl77rz1BeeUA?=
 =?us-ascii?Q?Yno6YwoBdISgYAE6VEHPfw8w1pX4zYuk6ykhYRgoRAQkApYJVlG+ltkKx+NJ?=
 =?us-ascii?Q?8copzVvDdlkrnyPIdj5HhNGfJ5OQrq7Y3emUEEZo+lZ24y2FDGvg6mFSqmJi?=
 =?us-ascii?Q?/2whoLArrqnJbNcNz4nLnYCN7D0ErR8dP8LBfl/PqxxFGK+u9zYilV8Z3hl/?=
 =?us-ascii?Q?cSumEfXwOlNWgD/forHShiT0Iu9vnsUuY8+iDwWyDdxWYviFNIimjykGW6jz?=
 =?us-ascii?Q?LVsZgXadVQXQKXSOAoAm5BeEBM+hpkU1EI6Xvr/wm3nN0cd0eHdcQAfv/lYI?=
 =?us-ascii?Q?MDKJMB0KW9LOM+n84k/WU02SfnPoPZr96Enh4nIsHJi7NGc5+yOVaygTJW0X?=
 =?us-ascii?Q?7OHNtowMDEtENfWYOyeFD526n9gNKna8T/JK9suZByAb1+tyWogn0z0EeTod?=
 =?us-ascii?Q?g4Ja86TdRNc5agAankJYYFXxw1LuSnS0AgleKCbr2bY/LQpMtqL/vfVjnJgy?=
 =?us-ascii?Q?ZIeCzD+YYoGSQnxikczPqc1jZDGx1NAD9OsqCPZ8zPINOBKMgVI5zBmosxRv?=
 =?us-ascii?Q?hqVD5elqZ8dPnVtulKNCqnSKqYGRWAsy67baZzPqOAjJM3wQ00mR1VUQWS5W?=
 =?us-ascii?Q?IrpQRChA3h55qNWKw2iXe7edSgH6UQzqvQGuwk+W3Ye9b/xPflSnyh09nGJQ?=
 =?us-ascii?Q?RjMWkYk6oG5cDk0sFGzTrfrXbClMjK/QOocAugjmIBR7b8yg4gij4L3Z2akl?=
 =?us-ascii?Q?MAw4mEHEIVb9hHPcM9M=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB6534.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d4cad320-f1cb-478a-3aee-08db4a571237
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 May 2023 15:16:43.1197 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ZBx/FUz9e/aKsW4kFpltx057msuFPCle/9g4CVyOziNtamMW/KPteLj1xo5KF0v2GshzHFuos84iFVb7/G8Rog==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR12MB6361
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
Cc: "Wang, Chao-kai \(Stylon\)" <Stylon.Wang@amd.com>, "Liu,
 HaoPing \(Alan\)" <HaoPing.Liu@amd.com>, "Li,
 Sun peng \(Leo\)" <Sunpeng.Li@amd.com>, "Wentland,
 Harry" <Harry.Wentland@amd.com>, "Zhuo,
 Qingqing \(Lillian\)" <Qingqing.Zhuo@amd.com>, "Siqueira,
 Rodrigo" <Rodrigo.Siqueira@amd.com>, "Li, Roman" <Roman.Li@amd.com>, "Chiu, 
 Solomon" <Solomon.Chiu@amd.com>, "Pillai, Aurabindo" <Aurabindo.Pillai@amd.com>,
 "Lin, Wayne" <Wayne.Lin@amd.com>, "Lakha,
 Bhawanpreet" <Bhawanpreet.Lakha@amd.com>, "Gutierrez,
 Agustin" <Agustin.Gutierrez@amd.com>, "Kotarac, Pavle" <Pavle.Kotarac@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[Public]

Hi all,
=20
This week this patchset was tested on the following systems:
=20
Lenovo Thinkpad T14s Gen2, with AMD Ryzen 5 5650U=20
Lenovo Thinkpad T13s Gen4 with AMD Ryzen 5 6600U
Reference AMD RX6800
=20
These systems were tested on the following display types:=20
eDP, (1080p 60hz [5650U]) (1920x1200 60hz [6600U]) (2560x1600 120hz[6600U])
VGA and DVI (1680x1050 60HZ [DP to VGA/DVI, USB-C to DVI/VGA])
DP/HDMI/USB-C (1440p 170hz, 4k 60hz, 4k 144hz [Includes USB-C to DP/HDMI ad=
apters])
=20
MST tested with Startech MST14DP123DP and 2x 4k 60Hz displays
DSC tested with Cable Matters 101075 (DP to 3x DP), and 201375 (USB-C to 3x=
 DP) with 3x 4k60 displays
HP Hook G2 with 1 and 2 4k60 Displays
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
The patchset consists of the amd-staging-drm-next branch (Head commit - f53=
eb9bfc5d7 BACKPORT: ASoC: SOF: fix compilation issue with readb/writeb help=
er) with new patches added on top of it. This branch is used for both Ubunt=
u and Chrome OS testing (ChromeOS on a bi-weekly basis).
=20
=20
Tested on Ubuntu 22.04.1 and Chrome OS
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
From: Alan Liu <HaoPing.Liu@amd.com>=20
Sent: April 26, 2023 12:27 PM
To: amd-gfx@lists.freedesktop.org
Cc: Wentland, Harry <Harry.Wentland@amd.com>; Li, Sun peng (Leo) <Sunpeng.L=
i@amd.com>; Lakha, Bhawanpreet <Bhawanpreet.Lakha@amd.com>; Siqueira, Rodri=
go <Rodrigo.Siqueira@amd.com>; Pillai, Aurabindo <Aurabindo.Pillai@amd.com>=
; Zhuo, Qingqing (Lillian) <Qingqing.Zhuo@amd.com>; Li, Roman <Roman.Li@amd=
.com>; Lin, Wayne <Wayne.Lin@amd.com>; Wang, Chao-kai (Stylon) <Stylon.Wang=
@amd.com>; Chiu, Solomon <Solomon.Chiu@amd.com>; Kotarac, Pavle <Pavle.Kota=
rac@amd.com>; Gutierrez, Agustin <Agustin.Gutierrez@amd.com>; Liu, HaoPing =
(Alan) <HaoPing.Liu@amd.com>; Wheeler, Daniel <Daniel.Wheeler@amd.com>
Subject: [PATCH 0/8] DC Patches April 26, 2023

This DC patchset brings improvements in multiple areas. In summary, we high=
light:
- FW Release 0.0.165.0
- Add w/a to disable DP dual mode on certain ports
- Revert "Update scaler recout data for visual confirm"
- Filter out invalid bits in pipe_fuses
- Adding debug option to override Z8 watermark values
- Change default Z8 watermark values
- Workaround wrong HDR colorimetry with some receivers

Cc: Daniel Wheeler <daniel.wheeler@amd.com>

Anthony Koo (1):
  drm/amd/display: [FW Promotion] Release 0.0.165.0

Aric Cyr (1):
  drm/amd/display: 3.2.234

George Shen (1):
  drm/amd/display: Add w/a to disable DP dual mode on certain ports

Ilya Bakoulin (1):
  drm/amd/display: Workaround wrong HDR colorimetry with some receivers

Leo Chen (2):
  drm/amd/display: Change default Z8 watermark values
  drm/amd/display: Adding debug option to override Z8 watermark values

Leo Ma (1):
  drm/amd/display: revert "Update scaler recout data for visual confirm"

Samson Tam (1):
  drm/amd/display: filter out invalid bits in pipe_fuses

 drivers/gpu/drm/amd/display/dc/core/dc.c       |  7 +++++++
 .../gpu/drm/amd/display/dc/core/dc_resource.c  | 17 -----------------
 drivers/gpu/drm/amd/display/dc/dc.h            |  8 +++++++-
 .../drm/amd/display/dc/dcn10/dcn10_dpp_dscl.c  | 18 +++++++++++++++++-  ..=
./drm/amd/display/dc/dcn32/dcn32_resource.c  | 11 ++++++++++-
 .../amd/display/dc/dcn321/dcn321_resource.c    | 10 +++++++++-
 .../drm/amd/display/dc/dml/dcn20/dcn20_fpu.c   | 11 +++++++++++
 .../drm/amd/display/dc/dml/dcn314/dcn314_fpu.c |  4 ++--
 .../drm/amd/display/dc/link/link_detection.c   |  4 ++++
 .../gpu/drm/amd/display/dmub/inc/dmub_cmd.h    | 10 +++++++++-
 10 files changed, 76 insertions(+), 24 deletions(-)

--
2.34.1
