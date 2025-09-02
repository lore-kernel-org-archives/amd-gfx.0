Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DA34BCA1005
	for <amd-gfx@archiver.kernel.org>; Tue,  2 Sep 2025 13:39:43 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7C65610E712;
	Tue,  2 Sep 2025 13:39:43 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="f/j/lNTl";
	dkim-atps=neutral
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2058.outbound.protection.outlook.com [40.107.236.58])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 699FD10E712
 for <amd-gfx@lists.freedesktop.org>; Tue,  2 Sep 2025 13:39:41 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iT7g5XAV1IO+/8bmL+ygskzHcTcFt+7R10016OjISB2YtzUg3XLbj+nIcEMTbs80duJAJ40RCvAqybTZIkMBK6sNMcpMwFC6uNooh5SczzlmBuASI6nSp3Rf5qxyAfBxJeJDKpkqIsBMud5LqkMMJIDkz0UzlFRWR0EKr+cJ4j+p0VhhjwOvSTRU+nGxRL5UQDRifR3tt8anmfAIFk2tK6Ds9AubCnOVr6BwntzKNjXhB7oUxwPAZTHhrwiUqasGQioO3pWzWFelat69jtUooG/cwpza7/sqE3CtkYi2N4aFxJL07FhAL8NGwg0AGH7TxAkum8AjuB14VY6UCSMixg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1qeUUO4KmRYq8ax9mCaQDC7NWMX9gkrnM0YZOV7a0g4=;
 b=l4JLmQvNB2OEHV8TX6E2cSVK8jOErCbAbPv0+H/d09J1GyjPuXWoG8zj56ksqN4vD1QRmvqrPQUgUF8+Ra+4w55lfgeRhf8jTQSSeRb2+gPEyvtzAvYmpbL8YaWj92b5mzJuQHXtJ5sA8Iwch6M9NOdivOeRVUkGDzAWOomN5EfpVuCZt4ZGDaeHTWEy3AvLC3WgbEqGyZZYfKfaxSf25fAFSBn0qY7nfcetlBIYqJND+xtk4EredeSM/7VnMr4dnpMSlJgojyR6WRD1v28fMpRu6Jm1wwEAVfLd55aGhlEX/ADediRvvcRNJwqWArN+09DrBvXwARd964eWJeESng==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1qeUUO4KmRYq8ax9mCaQDC7NWMX9gkrnM0YZOV7a0g4=;
 b=f/j/lNTl0bv7OeO5UaOKBhyb/dFarIPg87Pb0HeN1dTamkgub/Bic0ZXsYBFmOwpZhQ09cd2ONAVRL6dhMkK/ZfBB7QRG3VyU2OdH780KN6Jv/wVOaR6M04yJukOFPDe9TGWvvfvQGKI6UTTUhzj08TDmiuSK8hDn3uWTyuo8Mo=
Received: from DS0PR12MB6534.namprd12.prod.outlook.com (2603:10b6:8:c1::19) by
 CH3PR12MB8902.namprd12.prod.outlook.com (2603:10b6:610:17d::5) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9052.22; Tue, 2 Sep 2025 13:39:37 +0000
Received: from DS0PR12MB6534.namprd12.prod.outlook.com
 ([fe80::ea87:74ba:36ec:8cf6]) by DS0PR12MB6534.namprd12.prod.outlook.com
 ([fe80::ea87:74ba:36ec:8cf6%4]) with mapi id 15.20.9073.026; Tue, 2 Sep 2025
 13:39:37 +0000
From: "Wheeler, Daniel" <Daniel.Wheeler@amd.com>
To: "Zuo, Jerry" <Jerry.Zuo@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
CC: "Wentland, Harry" <Harry.Wentland@amd.com>, "Li, Sun peng (Leo)"
 <Sunpeng.Li@amd.com>, "Pillai, Aurabindo" <Aurabindo.Pillai@amd.com>, "Li,
 Roman" <Roman.Li@amd.com>, "Lin, Wayne" <Wayne.Lin@amd.com>, "Chung,
 ChiaHsuan (Tom)" <ChiaHsuan.Chung@amd.com>, "Zuo, Jerry" <Jerry.Zuo@amd.com>, 
 "Wu, Ray" <Ray.Wu@amd.com>, "LIPSKI, IVAN" <IVAN.LIPSKI@amd.com>, "Hung,
 Alex" <Alex.Hung@amd.com>, "Zuo, Jerry" <Jerry.Zuo@amd.com>
Subject: RE: [PATCH 0/8] DC Patches August 25, 2025
Thread-Topic: [PATCH 0/8] DC Patches August 25, 2025
Thread-Index: AQHcHA6BCC0rVkR8bkqT4wXANypNj7R/5YWw
Date: Tue, 2 Sep 2025 13:39:37 +0000
Message-ID: <DS0PR12MB65340FF18DFB2254FB1C76849C06A@DS0PR12MB6534.namprd12.prod.outlook.com>
References: <20250902133529.4144-1-Jerry.Zuo@amd.com>
In-Reply-To: <20250902133529.4144-1-Jerry.Zuo@amd.com>
Accept-Language: en-CA, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Enabled=True;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_SetDate=2025-09-02T13:39:30.0000000Z;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Name=Open
 Source; MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_ContentBits=3;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Method=Privileged
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS0PR12MB6534:EE_|CH3PR12MB8902:EE_
x-ms-office365-filtering-correlation-id: c4c03265-4d3d-45d6-e0b7-08ddea26292b
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|366016|1800799024|376014|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?AsThkFVNxCtD5qz88iukBMhjQqL6t8NMRwhqZgwBoxxSQK7f8gntF9qCpkm7?=
 =?us-ascii?Q?WCRHyyVc7qzO1mmgDVkhMXUEMu+vLecCpOTMMkOz6JTsyyE0eU8UeCE4RBo1?=
 =?us-ascii?Q?uzK0XnPBHTTmlfiY/HcALDT471DEXLkdRFb4IzjybZT/qdiJt1kSPnwaBjnW?=
 =?us-ascii?Q?UTv8rPmlTnBRESwSic+b0KHzgUVWnl94n1vB1tgp+ocedw9vVsxNK84E5QOx?=
 =?us-ascii?Q?JWR52jSW3zNc3zzd3vbOOyXPf3Rf2oqZ6h58QWbed0m9qNP20mnwjzBW5d+q?=
 =?us-ascii?Q?4j7stbE6s/F2R3racUdK33VWfw8jTBHGPehZrtwADRwMqgT+zmiXe9NcQ4wv?=
 =?us-ascii?Q?9dGkFeSVA0YpfPK0JeZEUbUfwswDv5rDn5haXVbYAsVsvIWN3MAZq7B6aDpk?=
 =?us-ascii?Q?qE/kTD83B29AgOeB4uwKo/eiH2KS7UTm74xNt16wFeBHWF8CABZ5u0eZ7IUc?=
 =?us-ascii?Q?8Y0dZIPwghxY7evIyYS1Dx+RnGyktmYlAneXrJx2ZV/SZPRizdveWHiF9mks?=
 =?us-ascii?Q?Vpl2y9bDirs6icZtZ6m6lL+6usvQC1Z+6twqHu+KD6lQhhPPQJLNacxi7dA2?=
 =?us-ascii?Q?XScw1j22hwldaLtaB5TgSzJ8elC3zMuBj50dPSCFi+PYq4jfs5bzMxwx9EvD?=
 =?us-ascii?Q?2eS7GEKohYwUaTTAGsPASuVb3lalpRNmwSOCEmaQh+f43cJxcHN7bhod3qLK?=
 =?us-ascii?Q?cwwRI+mePK/5l94sU+hsN5xDODM966LyJk20NwXd7t9ifgxERXRoBxUAP2CS?=
 =?us-ascii?Q?f09rY8KFY1As/s7zM0JZgVUkYUBD1Yg+Zpxn6UaVr8ZE69dqqFiydrKXXcSe?=
 =?us-ascii?Q?V3LjRP4xSaYge1bQvv/JobG9pYwq/QRttn6aYDfNM/xk0+1tBpQQYj3VHDYj?=
 =?us-ascii?Q?bDsQM8Z1RNqq1ipFGkeb8Hu+0/Np9IMkpUEuXTzaUnNyUwHIZtElf0PqF9yP?=
 =?us-ascii?Q?ZfreRu06JieiFH1wnxkGGfuBmIBA5uabG+PCZVVLB+ofHjRTdRMJtYzdTU5Y?=
 =?us-ascii?Q?Qy9ILyfCKQD8uSWWCRGwDO+L7MVIPO1+3UeLsWD3MXnf1UX89GomL4s+Dcm1?=
 =?us-ascii?Q?8144PQkNT2c1oYZDS4POoKc4m8Z+d7OSq/DcOF7AU5Vpx184Mj9k5lBCQ/08?=
 =?us-ascii?Q?C9mJxCb5MoO/MYxlP2N2n1tNHi/uXUQz6om2Pfyv1pyfV0iUNTV8i5iEQn9O?=
 =?us-ascii?Q?688bNcsvntRXJ2+Rr9bJnfkto8eQviuOU1Cw2Obi5/x5LEPflamNe//EmH8p?=
 =?us-ascii?Q?isZjA9IE+OSxnAe1R/MgPoUwpa4N8hlTqTm5i/HwjHj/ncN1h7PZg8XlmzyQ?=
 =?us-ascii?Q?l+FxBD/thgfd/pMJP3/E8WHNW1xfrGmBQHltJzI3a4AHE5p+fG/5dpWAgOxu?=
 =?us-ascii?Q?UPYXL9Vv5XURsc6jhSZjxQaPvTEc098u6lzNOhySY9UzHm3XGPmQDSym0QKo?=
 =?us-ascii?Q?zlBxoXGfjxsD39kkOlliXEW2KkfmdTqMu2qutfpIHHiCZFAInOodfGml7xDr?=
 =?us-ascii?Q?aTs6oPxYxFEiugg=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR12MB6534.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(38070700018); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?Y/rIm2h/z5K/2PiUwuLzAdMxLBHX2Iua0uPwuqqMbap3plNEsXi965jxnxPv?=
 =?us-ascii?Q?9IK/NEUiYOpLD45QC3npACqi0fPSELe/qPqm4uI3zJfiTNv/Ep0fbAZ4XCU4?=
 =?us-ascii?Q?inBduxZeGuK+kvXYt4Apwhkvmgv55uOKcD10oQoMMYxLPsk1Mc6IWJ5GdA50?=
 =?us-ascii?Q?xyDEEJU4ZOvGFLIDp4r6vTa+SNaYmLR2c9gmeJj/eDUJwqSYq/OpDYuJU0S+?=
 =?us-ascii?Q?WFLDPvSG5J3tyckUieooNfV5/mKWJIJqzug38SzTkeg/5r4Ckls1Y/y2eDLT?=
 =?us-ascii?Q?J1yursHi5Rcjxg2w3L6p8J5LUYCID8t1ta9BrW/J49K8wxBOV4Gyq8hs9Ntc?=
 =?us-ascii?Q?0hhhL6+GPrMd00tzOZ76zIWqiqziiQTfzZz2cvyPaaJEuex/0fsZV0Ua0BJC?=
 =?us-ascii?Q?95QkCn6REe0dtgjt1V2aCNg9W4+VsvBeLhl7BjJ2idEVhnevnTipQtMDEx6c?=
 =?us-ascii?Q?wW+h+Zch/IXpBtEE8PROHjOjCj7/qYKuTjOmhfkjLE8IctCLRgyRrFPQXzuG?=
 =?us-ascii?Q?F7qUXDSdOCYNNe83eLCuuQ86N1miziOURvfPakXzne0zxHb8CqAKZkHwFRJU?=
 =?us-ascii?Q?2MCkNixNaPcwZ3MFA2/jBdNDtQixoZ4v2IK+S+D9+4GpaCjqKqBS3DzNS/hw?=
 =?us-ascii?Q?Gg1ozuph9I/cxKzQdI+MOkgsOCVgmme6jkWiK1agJkqV50LF4ub5wcWVa5Je?=
 =?us-ascii?Q?Z/Ihd0dqntlUyiZK64Zae8v7FySKpv5wKo93lOYqph9N0NftAawI6FAs/GJr?=
 =?us-ascii?Q?Ckcg3GnJVYZhfRaWEQ660+iV40rPbINNKhHIzJiQ7kZEogV4hkLPFUKVyM/z?=
 =?us-ascii?Q?2PBNrZkQ44Mp5a1QZj863xnsFk1cYfWUOLpoxOl6jY3dKj9emitYVOH3n742?=
 =?us-ascii?Q?XauRJS7ofWhwDnzLOCCjATjTwKlclsgeOvJyQwltTYgvo/QcW7GiBQKpy1yS?=
 =?us-ascii?Q?Csrvpt4bB2q06kkW+pAKiXK9IJVLDF2EUZLJOczXyW0D87832fhkRv6dBvTQ?=
 =?us-ascii?Q?5j97Z/XI8FsBg86LkyZqnAVkBPdzJBCCe5tAGGcmOWqiHH5U/1rWl7tD5lWt?=
 =?us-ascii?Q?iYahBxhNbb6HSi6CV6g6TOmEJT1K+vY/H50wqrQvspUG6OBxYQBXp04niYX3?=
 =?us-ascii?Q?nYCqskMD709/nRwiiNbrQONgalgiy7dZt9WSn5JyVqO/FZUX9q6QWmPZMU1d?=
 =?us-ascii?Q?82OxYRlk0JeF/uYZj44CLxjhg/VCEN4LGowIHKficlolz4jT25zsXVc7KY+K?=
 =?us-ascii?Q?hg5MgF23NjgtEuI3a1Z/btVPxMncqXQZ2qiRqGdgjQKphPQmGgbJBslNp608?=
 =?us-ascii?Q?EFEpN9bA1dKWV+izoQKlYNHor0dR6ZuUvHoOkvTEVjq7xHtqZFtHQMMlNXcC?=
 =?us-ascii?Q?kxyZdC/bWAAZ5QC6LSHicSJhKDljKBibf/4tou2beLEd+riKLc9N9TAQW2ik?=
 =?us-ascii?Q?Oc6ATiRCrfAyLMKpMpUWzmTcj4Frz+/qxIyQExQU694jl82B91PjzsJhbxOo?=
 =?us-ascii?Q?x8hTvuA7BlIAtgo1tG4YqVvn1mDpqYRuR12X/x1MR0wGEBpbxj4l1HihKWaZ?=
 =?us-ascii?Q?oHIu6MWM4E+qGZEstCM=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB6534.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c4c03265-4d3d-45d6-e0b7-08ddea26292b
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Sep 2025 13:39:37.6458 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: +xa3sSM3SoTT8GbWjkxD6ihnFQEf4TvHJBGJwbNxwiZv/DI5vD9jhkku+7QsUCxRQ0OsMlO1da/vT/YwfVFo+A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8902
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

This week this patchset was tested on 4 systems, two dGPU and two APU based=
, and tested across multiple display and connection types.

APU
        * Single Display eDP -> 1080p 60hz, 1920x1200 165hz, 3840x2400 60hz
        * Single Display DP (SST DSC) -> 4k144hz, 4k240hz
        * Multi display -> eDP + DP/HDMI/USB-C -> 1080p 60hz eDP + 4k 144hz=
, 4k 240hz (Includes USB-C to DP/HDMI adapters)
        * Thunderbolt -> LG Ultrafine 5k
        * MST DSC -> Cable Matters 101075 (DP to 3x DP) with 3x 4k60hz disp=
lays, HP Hook G2 with 2x 4k60hz displays
        * USB 4 -> HP Hook G4, Lenovo Thunderbolt Dock, both with 2x 4k60hz=
 DP and 1x 4k60hz HDMI displays
        * SST PCON -> Club3D CAC-1085 + 1x 4k 144hz, FRL3, at a max resolut=
ion supported by the dongle of 4k 120hz YUV420 12bpc.
        * MST PCON -> 1x 4k 144hz, FRL3, at a max resolution supported by t=
he adapter of 4k 120hz RGB 8bpc.

DGPU
        * Single Display DP (SST DSC) -> 4k144hz, 4k240hz
        * Multiple Display DP -> 4k240hz + 4k144hz
        * MST (Startech MST14DP123DP [DP to 3x DP] and 2x 4k 60hz displays)
        * MST DSC (with Cable Matters 101075 [DP to 3x DP] with 3x 4k60hz d=
isplays)

The testing is a mix of automated and manual tests. Manual testing includes=
 (but is not limited to)
        * Changing display configurations and settings
        * Video/Audio playback
        * Benchmark testing
        * Suspend/Resume testing
        * Feature testing (Freesync, HDCP, etc.)

Automated testing includes (but is not limited to)
        * Script testing (scripts to automate some of the manual checks)
        * IGT testing

The testing is mainly tested on the following displays, but occasionally th=
ere are tests with other displays
        * Samsung G8 Neo 4k240hz
        * Samsung QN55QN95B 4k 120hz
        * Acer XV322QKKV 4k144hz
        * HP U27 4k Wireless 4k60hz
        * LG 27UD58B 4k60hz
        * LG 32UN650WA 4k60hz
        * LG Ultrafine 5k 5k60hz
        * AU Optronics B140HAN01.1 1080p 60hz eDP
        * AU Optronics B160UAN01.J 1920x1200 165hz eDP
        * Samsung ATNA60YV02-0 3840x2400 60Hz OLED eDP


The patchset consists of the amd-staging-drm-next branch (Head commit - 944=
b2e39077bc733746de7714e0262f83a696c3b -> drm/amd/display: DC v3.2.347) with=
 new patches added on top of it.

Tested on Ubuntu 24.04.3, on Wayland and X11, using KDE Plasma and Gnome.

Tested-by: Dan Wheeler <daniel.wheeler@amd.com>



Thank you,

Dan Wheeler
Sr. Technologist | AMD
SW Display
---------------------------------------------------------------------------=
---------------------------------------
1 Commerce Valley Dr E, Thornhill, ON L3T 7X6
amd.com

-----Original Message-----
From: Fangzhi Zuo <Jerry.Zuo@amd.com>
Sent: Tuesday, September 2, 2025 9:33 AM
To: amd-gfx@lists.freedesktop.org
Cc: Wentland, Harry <Harry.Wentland@amd.com>; Li, Sun peng (Leo) <Sunpeng.L=
i@amd.com>; Pillai, Aurabindo <Aurabindo.Pillai@amd.com>; Li, Roman <Roman.=
Li@amd.com>; Lin, Wayne <Wayne.Lin@amd.com>; Chung, ChiaHsuan (Tom) <ChiaHs=
uan.Chung@amd.com>; Zuo, Jerry <Jerry.Zuo@amd.com>; Wheeler, Daniel <Daniel=
.Wheeler@amd.com>; Wu, Ray <Ray.Wu@amd.com>; LIPSKI, IVAN <IVAN.LIPSKI@amd.=
com>; Hung, Alex <Alex.Hung@amd.com>; Zuo, Jerry <Jerry.Zuo@amd.com>
Subject: [PATCH 0/8] DC Patches August 25, 2025

Summary:

* DC version 3.2.348
* Remove state/param from check update
* Refactor bounding box values handling
* Fix incorrect condition to fail dto clk calculation
* Skip check downlink setting for a certain MST branch device
* Fix double cursor issue on dcn314

Austin Zheng (1):
  drm/amd/display: Add Component To Handle Bounding Box Values and IP
    Caps

Clay King (1):
  drm/amd/display: incorrect conditions for failing dto calculations

Fangzhi Zuo (1):
  drm/amd/display: Skip Check Runtime Link Setting for Specific Branch
    Device

Ivan Lipski (1):
  drm/amd/display: Clear the CUR_ENABLE register on DCN314 w/out DPP PG

Mario Limonciello (1):
  drm/amd/display: Optimize custom brightness curve interpolation

Relja Vojvodic (1):
  drm/amd/display: Increase minimum clock for TMDS 420 with pipe
    splitting

Taimur Hassan (2):
  drm/amd/display: [FW Promotion] Release 0.1.25.0
  drm/amd/display: Promote DC to 3.2.348

 drivers/gpu/drm/amd/display/Makefile          |   1 +
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c |  64 +--
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h |   3 +
 .../display/amdgpu_dm/amdgpu_dm_mst_types.c   |  40 +-
 drivers/gpu/drm/amd/display/dc/Makefile       |   1 +
 drivers/gpu/drm/amd/display/dc/core/dc.c      |   8 +-
 drivers/gpu/drm/amd/display/dc/dc.h           |   4 +-
 .../amd/display/dc/dccg/dcn401/dcn401_dccg.c  |   2 +-
 .../dc/dml2/dml21/dml21_translation_helper.c  | 368 +-----------------
 .../amd/display/dc/dml2/dml21/dml21_wrapper.c |   2 +-
 .../src/dml2_core/dml2_core_dcn4_calcs.c      |  28 +-
 .../drm/amd/display/dc/dpp/dcn10/dcn10_dpp.c  |   9 +
 .../drm/amd/display/dc/dpp/dcn10/dcn10_dpp.h  |   2 +
 .../drm/amd/display/dc/dpp/dcn30/dcn30_dpp.c  |   1 +
 .../amd/display/dc/hwss/dcn314/dcn314_hwseq.c |  72 ++++
 .../amd/display/dc/hwss/dcn314/dcn314_hwseq.h |   2 +
 .../amd/display/dc/hwss/dcn314/dcn314_init.c  |   1 +
 drivers/gpu/drm/amd/display/dc/inc/hw/dpp.h   |   3 +
 .../display/dc/inc/soc_and_ip_translator.h    |  24 ++
 .../display/dc/soc_and_ip_translator/Makefile |  19 +
 .../dcn401/dcn401_soc_and_ip_translator.c     | 304 +++++++++++++++
 .../dcn401/dcn401_soc_and_ip_translator.h     |  22 ++
 .../dcn42/dcn42_soc_and_ip_translator.c       |  27 ++
 .../dcn42/dcn42_soc_and_ip_translator.h       |  16 +
 .../soc_and_ip_translator.c                   |  37 ++
 .../gpu/drm/amd/display/dmub/inc/dmub_cmd.h   |  13 +-
 26 files changed, 672 insertions(+), 401 deletions(-)  create mode 100644 =
drivers/gpu/drm/amd/display/dc/inc/soc_and_ip_translator.h
 create mode 100644 drivers/gpu/drm/amd/display/dc/soc_and_ip_translator/Ma=
kefile
 create mode 100644 drivers/gpu/drm/amd/display/dc/soc_and_ip_translator/dc=
n401/dcn401_soc_and_ip_translator.c
 create mode 100644 drivers/gpu/drm/amd/display/dc/soc_and_ip_translator/dc=
n401/dcn401_soc_and_ip_translator.h
 create mode 100644 drivers/gpu/drm/amd/display/dc/soc_and_ip_translator/dc=
n42/dcn42_soc_and_ip_translator.c
 create mode 100644 drivers/gpu/drm/amd/display/dc/soc_and_ip_translator/dc=
n42/dcn42_soc_and_ip_translator.h
 create mode 100644 drivers/gpu/drm/amd/display/dc/soc_and_ip_translator/so=
c_and_ip_translator.c

--
2.43.0

