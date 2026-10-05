Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A32C0CA5FF0
	for <amd-gfx@archiver.kernel.org>; Mon,  5 Oct 2026 13:31:05 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2151D10ECDF;
	Mon,  5 Oct 2026 13:31:05 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="uZBqF2VF";
	dkim-atps=neutral
Received: from CY3PR05CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11013000.outbound.protection.outlook.com
 [40.93.201.0])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7001C10ECDF
 for <amd-gfx@lists.freedesktop.org>; Mon,  5 Oct 2026 13:31:03 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=o+rB7y3pgsC0TdK9tXc1DrWKrgubrRD28JBuihB7gGvRYv22BqeOPA8U5jLjra+WzrtBrntL846uPv266ZpO6zgQZM3EJ/g6QU5O/09YKsbA1xLPyJJXnQ+IKZscarrFQyKhNUJD35ZcEi0drLCCyGLs7/VXAZ0qdzRqf9D7rC3T0EAO8unl6eGfH4sBLOApGNhMT3eEsaWXVXBG9oawDtdvA5oyr0vjt2NYtfAoBB4tPY0OTUxry9PEVTfGoU0e0lRnLTTH94gapV5n//XQtcKVEzs0J7qMSp9sCE9+kK1VAwD5DnCNV7HcEmMrP7I7UiZCrq5nqUTCXUcOHmHSPQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SXtYt1WaUV3NGL79o77rZ2qRTAGNU2UlSjQkNztbJFI=;
 b=B3E8zxROJT+hkjL/V702Tu6ubvQvONKmQ99bzyYnK2jGrwHviTN/CbCAtIkS0SMyfwEqCzrbulnb9A7g4IxlAocePgtyf/yptGBG2doxCCnI/LLRNAL66q9xwstlhPXIsj2sxL+6qazFLwTPnX6vM/AJJAStM9nlktLriphJtXrbXChaIy0AZ8Io8YyZRBforaCiFHZem8MO+QUux67milehnZc4fTUIVTe4SpaBAhxohx6LdQlCRyH7ba+v9Q5ELN4yt1rIbud26M1te3aVDvZCQRTT0x7ikqAtOJeJg89nppRZ3K8Kesz3TVSaHP4Le9f+vJ/e07sEX6y0OQcYQg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SXtYt1WaUV3NGL79o77rZ2qRTAGNU2UlSjQkNztbJFI=;
 b=uZBqF2VFAjRhFjjxxXIkSEoaoEWmiOhsxzjNsE7sGP+GfaUhXhWKCfdmqmSY8l3Fk8mLW8gz/YugQltkUmbBbYRXh/IOHO+NYoPgh/YzhXfnDw2sDdrhDNV+j6wYprhlH+qPnx1hmTQuvw6KKSm/cpnKzj56pVEtB4OGKJMeAx8=
Received: from DS0PR12MB6534.namprd12.prod.outlook.com (2603:10b6:8:c1::19) by
 PH8PR12MB7254.namprd12.prod.outlook.com (2603:10b6:510:225::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.472.16; Mon, 5 Oct
 2026 13:30:59 +0000
Received: from DS0PR12MB6534.namprd12.prod.outlook.com
 ([fe80::b2e1:64e5:3b9e:738a]) by DS0PR12MB6534.namprd12.prod.outlook.com
 ([fe80::b2e1:64e5:3b9e:738a%4]) with mapi id 15.21.0451.026; Mon, 5 Oct 2026
 13:30:59 +0000
From: "Wheeler, Daniel" <Daniel.Wheeler@amd.com>
To: "Li, Roman" <Roman.Li@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
CC: "Wentland, Harry" <Harry.Wentland@amd.com>, "Li, Sun peng (Leo)"
 <Sunpeng.Li@amd.com>, "Li, Roman" <Roman.Li@amd.com>, "Lin, Wayne"
 <Wayne.Lin@amd.com>, "Chung, ChiaHsuan (Tom)" <ChiaHsuan.Chung@amd.com>,
 "Zuo, Jerry" <Jerry.Zuo@amd.com>, "Wu, Ray" <Ray.Wu@amd.com>, "LIPSKI, IVAN"
 <IVAN.LIPSKI@amd.com>, "Hung, Alex" <Alex.Hung@amd.com>, "Lin, Ping Lei"
 <PingLei.Lin@amd.com>, "Chen, Chen-Yu" <Chen-Yu.Chen@amd.com>, "Li, Roman"
 <Roman.Li@amd.com>
Subject: RE: [PATCH 00/17] DC Patches October 2, 2026
Thread-Topic: [PATCH 00/17] DC Patches October 2, 2026
Thread-Index: AQHdUqTc3nqpxBbJxUSgKEBn+BnuC7bu9esQ
Date: Mon, 5 Oct 2026 13:30:59 +0000
Message-ID: <DS0PR12MB65341F65C8C8E99CAA83BB3A9C962@DS0PR12MB6534.namprd12.prod.outlook.com>
References: <20261002193240.3441018-1-Roman.Li@amd.com>
In-Reply-To: <20261002193240.3441018-1-Roman.Li@amd.com>
Accept-Language: en-CA, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_2d0b1989-8fc8-4a69-bcac-d46889461ba5_Enabled=True;
 MSIP_Label_2d0b1989-8fc8-4a69-bcac-d46889461ba5_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_2d0b1989-8fc8-4a69-bcac-d46889461ba5_SetDate=2026-10-05T13:30:05.0000000Z;
 MSIP_Label_2d0b1989-8fc8-4a69-bcac-d46889461ba5_Name=AMD Public
 v26; MSIP_Label_2d0b1989-8fc8-4a69-bcac-d46889461ba5_ContentBits=3;
 MSIP_Label_2d0b1989-8fc8-4a69-bcac-d46889461ba5_Method=Privileged
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS0PR12MB6534:EE_|PH8PR12MB7254:EE_
x-ms-office365-filtering-correlation-id: 49cad5e7-8d9c-4e7d-1929-08df22e4e4ba
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|376014|1800799024|23010399003|10067099003|56012099006|6133799003|3023799007|11063799006|22082099003|18002099003|38070700021;
x-microsoft-antispam-message-info: KUmxQNyULJmwPjohLHET34cEzEgVlV2aEyLA+WwY5GxPG8hRK9Ou5tYa4KRLeapiq8lbc6YbayUGe4QBdVxZHpyJl5nMN+Q5bL8XzPCrryZhp3bbRI2R3rHJJwBIzzIuxUqtd5PYcLqhzSwzuiFiz+Ck1Prq8VDEuNyC3xnNL7urAup9XJowhJC79GRBpm+urixB1x04GCuo1iwf0aAQ8Om4uma/wwcb9DMMfZz1AJZGIS3njnXxiSwodEAmB4S8PtdO2nOvM81yejjhKR44NrAqUORfRvsg9dk6KDaE8GCidWxb2+Y+sA5pwm7i5VZ68EaNsjIeBUXJJiCkTm3jHAviqzoKtnOBXLRnGmB70MVeL9V1iByk36RQ6SS8cfhmXNoNQa4bm/t9w7joSxhcW9BaXfKOq8YN59Jci8zh/hUSbIetoeBeB3DMExHp7PWv78DqfnMsxZJpmWoqd0aCJPWZbW2S3abhA8/YQ7SG5X+IoTX0Ty506Z6UrREwx3wP4pFIYeUR4UiyaS6cLAw/4jy7TP5HhYPuT1/yOx3HSnPsodUaF27YMc09LEQHOFhdntzVheMXlMIwp1KkNCCDK0PYnV4d0LD7eww6BtyxDsjwbq0HIasfXOEfMnacpAz3JYWAUJp3fhjQ8N7LZQYkyxYdcRFZvtpX1N9FISfTmAdiomI18fVJdEIawu56A1c7PWIdPicKCN46R3HhmOrIeZBhngP4qSJ/ivGDypKoiSg=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR12MB6534.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(23010399003)(10067099003)(56012099006)(6133799003)(3023799007)(11063799006)(22082099003)(18002099003)(38070700021);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?NjRtsRkeGXzIvgy7/7R+vwh1DEFCvARjHilsqz8IdKEG2TXW/RwnKHO0Qs?=
 =?iso-8859-1?Q?Y05RejWmv6om2DPeeFPVx5NQE1tbrVr/27wu1/AIcmI4Y0oINxgDUjHThL?=
 =?iso-8859-1?Q?vteBVkWLEOXLIQTyJgpFWXsr0ZnF/i+cVx/GuWyih8KA6C7/YO3iFIWqIz?=
 =?iso-8859-1?Q?ZvFEioDU7W9ojp3xVfV2BniQsA219n9tpWn0/ChAtDFBJMD6Lm3VTX6sAn?=
 =?iso-8859-1?Q?tG2f4YxWGjjqNOMq46OEacYkWsYaMuuKaaJmP7y/WrJFCwyZpPUDJ+v8D/?=
 =?iso-8859-1?Q?AWI/465fOqpoP6AGRrtCNkngLMQiwteZMqtnqga9si4kEN2DqZTDfCSzXH?=
 =?iso-8859-1?Q?Ibt/kac6vv0jVBd7rgKCmq+tfk27/B8HLyIqJAF52BOSTW0Tt1sz0eKYtY?=
 =?iso-8859-1?Q?vmL2+mddn8mF0bR0wPcejJops9Hljhfl/Arz5QFkGhC6wC3IW0KLD/7oT6?=
 =?iso-8859-1?Q?VvFlvRGNamSy0d+OjjbvXxZwIzos5YrdW7uQBwzy3zVrTSz998npNw8QGS?=
 =?iso-8859-1?Q?4Na+zOoM0IEsSpeF7gE2CmEAWwqXu39lTkmqk04wJNaR4C0nLivzSpOR7E?=
 =?iso-8859-1?Q?++9b6Ux+tDNhwJOgIjHf9nAFlXwquIqSl7EZEcPOZlqfjK2m3YZWkuvypw?=
 =?iso-8859-1?Q?P6tR2Spm614qkFjW8ya9QhovJmMysgzDfFEsQNJ8Cp7SZjNOD6QRjQiHhM?=
 =?iso-8859-1?Q?dwVdCkwXtnweei7kwdHH5pe5vj1bHw9bwR1jgvgX1YNPE/5KFuK3cLQ9+k?=
 =?iso-8859-1?Q?oZRVn3579cQW81UK6w8mLNvVmE/t8u0ECCwK9nxiH+Agna4nJgOBM++KzM?=
 =?iso-8859-1?Q?YYRGPSUx2/Co+7NvflJtk9eK/SawImMc0CCFjvIFa7DM1FAy7LDCsmphCe?=
 =?iso-8859-1?Q?CStw/LnxTC4jEPvvgWdwGHRPj0qUjX9b6RL0pZOKP4DV1Z8E6vU8CgT1Mt?=
 =?iso-8859-1?Q?qK0PQDjOO9m06VKQsYS/s2TKUosMhqfWSckQUwjuXLbXJ+GAYcHWB6RRyG?=
 =?iso-8859-1?Q?rnFkc+uD07dB1ToQkS4YjhwecYTnwCTBUM3THnrzwCp7WJHHGv5dFbU6+5?=
 =?iso-8859-1?Q?nTExs/mJs4f4E3h1KMychAqqfE3ihe/pHiPlSZenRc1gaD278UC99RrJUL?=
 =?iso-8859-1?Q?wHSQzDhK8MNc520aZG1tJjVk3OS5RzIM5WDQ0o8lfccQU1VNFQR+qOwOAf?=
 =?iso-8859-1?Q?JL9qZoAf2CPp4+JAW7ZzUC5Fc25jp4gcurvKNMPeCbnZKRraiTN5lBSHbw?=
 =?iso-8859-1?Q?/ipZtxumWXwfPfbU6L/y4XdVh7nAOO27Y5Muw/afbvl7ffrGcCLb+/w+sZ?=
 =?iso-8859-1?Q?pNDezTsAqSeWhPEjY049GeUpZJZ3DG6BdCczbGNHp7UyBJ4r2bUAv2WT7N?=
 =?iso-8859-1?Q?RrrZIzN390CvDbHY/8/l5APoAsBpIGojstFVx+Y7hsfhRhUfq+eqn8zKE/?=
 =?iso-8859-1?Q?mtAqrJn4+/LCjl7O9CNc1k8dny3XrG1nIvuLuMTbwFyB+fMprcPstWZrg5?=
 =?iso-8859-1?Q?xb/2/tH8Dj8eTKS2UcwpKAyncD5xVcEBgPvUdS+15NIwHhq1uqSdaD6DmD?=
 =?iso-8859-1?Q?X2oU/1EfZfLhAkWq29+xxMNvb2kMyv4iY58t7Kbb6l/OaqCUKY9sgFiJAI?=
 =?iso-8859-1?Q?XoEmsN59HO6CSXnY7loXmvpA1JdEpDyeb6QqUgdDrVLnyRx++dbDAaK/cp?=
 =?iso-8859-1?Q?GQMBqmd0tCRUYR6bxuJai3g7PeYOLvAq01rB4iPGVOtfeHIm8k/0AmvDdA?=
 =?iso-8859-1?Q?7SsNL7ASdNFeHPwE3nWrjZkWIFpvmBaNAlCstosNkxdK1f?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB6534.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 49cad5e7-8d9c-4e7d-1929-08df22e4e4ba
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Oct 2026 13:30:59.4959 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: epR2CvhdcNKWuPtbw11LdIYDEEVluEC/HcMquLIQdk6CLod1e6jC6XJBPVRRmTXby9tNlR7qkeobDmfW5VHIfw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB7254
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

Public

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


The patchset consists of the amd-staging-drm-next branch (Head commit -> 0f=
e07578aeb611d89ceacacfa77345dbeba45bc4 -> drm/amdgpu: Fix race on ualink_ha=
ndle_lo in UALink handle export) with new patches added on top of it.

Tested on Ubuntu 26.04, on Gnome Wayland.

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
From: Roman.Li@amd.com <Roman.Li@amd.com>
Sent: Friday, October 2, 2026 3:32 PM
To: amd-gfx@lists.freedesktop.org
Cc: Wentland, Harry <Harry.Wentland@amd.com>; Li, Sun peng (Leo) <Sunpeng.L=
i@amd.com>; Li, Roman <Roman.Li@amd.com>; Lin, Wayne <Wayne.Lin@amd.com>; C=
hung, ChiaHsuan (Tom) <ChiaHsuan.Chung@amd.com>; Zuo, Jerry <Jerry.Zuo@amd.=
com>; Wheeler, Daniel <Daniel.Wheeler@amd.com>; Wu, Ray <Ray.Wu@amd.com>; L=
IPSKI, IVAN <IVAN.LIPSKI@amd.com>; Hung, Alex <Alex.Hung@amd.com>; Lin, Pin=
g Lei <PingLei.Lin@amd.com>; Chen, Chen-Yu <Chen-Yu.Chen@amd.com>; Li, Roma=
n <Roman.Li@amd.com>
Subject: [PATCH 00/17] DC Patches October 2, 2026

From: Roman Li <Roman.Li@amd.com>

This DC 3.2.401 patchset brings improvements in multiple areas. In summary,=
 we have:

* HDMI: RR and SCDC skips, link-training timeout behaviour, VRR metadata in=
 the
  VTEM info packet, and a TMDS output regression revert;
* MCM shaper/3DLUT programming and DTN logging improvements;
* DMUB: fast-lock sequencing refactor and FAMS2 command update;
* DSC configuration preparation and DRR reprogramming optimizations;
* Replay/low-power, eDP link-bandwidth, cursor offload, and virtual link
  encoder handling;
* New DCN42b project ID.

Cc: Dan Wheeler <daniel.wheeler@amd.com>

Allen Li (1):
  drm/amd/display: Skip link off frame count for general UI

Alvin Lee (3):
  drm/amd/display: Set cursor_offload for all pipes for a given stream
  drm/amd/display: Assign alt wa bit in fams2 cmd
  drm/amd/display: Add debug option to override low power SR latencies

Aric Cyr (1):
  drm/amd/display: only reprogram DRR when v_total values change

Ashwin Santhosh (1):
  drm/amd/display: Promote DC to 3.2.401

Dillon Varone (1):
  drm/amd/display: Add dcn42b project id

Harry Wentland (2):
  drm/amd/display: enable shaper when programming 3DLUT
  drm/amd/display: log MCM shaper and 3D LUT mode in the DTN log

Ilya Bakoulin (1):
  drm/amd/display: Add HDMI RR and SCDC skips

Ivan Lipski (1):
  drm/amd/display: Send HDMI VRR metadata in VTEM info packet slot

Joshua Aberback (1):
  drm/amd/display: Revert "avoid to write signal specific for tmds"

Martin Tsai (1):
  drm/amd/display: allow skipping link bandwidth clear

Rafal Ostrowski (2):
  drm/amd/display: Refactor DMUB fast lock sequencing
  drm/amd/display: Prepare DSC configuration before BLS execution

Relja Vojvodic (1):
  drm/amd/display: Update link training no timeout behaviour on HDMI

Sridevi Arvindekar (1):
  drm/amd/display: Handle virtual link encoder

 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c |   2 +
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h |   1 +
 .../amd/display/amdgpu_dm/amdgpu_dm_color.c   |   1 +
 .../display/amdgpu_dm/amdgpu_dm_freesync.c    |  26 +-
 drivers/gpu/drm/amd/display/dc/core/dc.c      | 101 +---
 .../drm/amd/display/dc/core/dc_hw_sequencer.c | 522 ++++++++++++------
 .../drm/amd/display/dc/core/dc_link_exports.c |   5 +
 .../gpu/drm/amd/display/dc/core/dc_resource.c |   2 +-
 .../gpu/drm/amd/display/dc/core/dc_stream.c   |  36 +-
 drivers/gpu/drm/amd/display/dc/dc.h           |   8 +-
 drivers/gpu/drm/amd/display/dc/dc_dmub_srv.c  |   1 +
 drivers/gpu/drm/amd/display/dc/dc_dp_types.h  |   1 +
 drivers/gpu/drm/amd/display/dc/dc_types.h     |   2 +
 .../drm/amd/display/dc/dce/dmub_hw_lock_mgr.c |  12 +-
 .../dc/dml2_0/dml21/inc/dml_top_types.h       |   1 +
 .../dml21/src/dml2_cga/dml2_cga_factory.c     |   1 +
 .../dml21/src/dml2_core/dml2_core_factory.c   |   1 +
 .../dml21/src/dml2_dpmm/dml2_dpmm_factory.c   |   1 +
 .../dml21/src/dml2_mcg/dml2_mcg_factory.c     |   1 +
 .../dml21/src/dml2_pmo/dml2_pmo_factory.c     |   1 +
 .../dml21/src/dml2_top/dml2_top_interfaces.c  |   1 +
 .../dml2_utm_soc_bb/dml2_utm_soc_bb_factory.c |   1 +
 .../drm/amd/display/dc/dsc/dcn20/dcn20_dsc.c  |  48 +-  .../drm/amd/displa=
y/dc/dsc/dcn20/dcn20_dsc.h  |  13 +-
 .../drm/amd/display/dc/dsc/dcn35/dcn35_dsc.c  |   1 +
 .../amd/display/dc/dsc/dcn401/dcn401_dsc.c    |  34 +-
 .../amd/display/dc/dsc/dcn401/dcn401_dsc.h    |   5 +-
 .../drm/amd/display/dc/dsc/dcn60/dcn60_dsc.c  |  41 +-
 .../drm/amd/display/dc/dsc/dcn60/dcn60_dsc.h  |   3 +-
 drivers/gpu/drm/amd/display/dc/dsc/dsc.h      |   3 +-
 .../amd/display/dc/hwss/dcn10/dcn10_hwseq.c   |  17 +-
 .../amd/display/dc/hwss/dcn20/dcn20_hwseq.c   |  11 +-
 .../amd/display/dc/hwss/dcn314/dcn314_hwseq.c |  14 +-
 .../amd/display/dc/hwss/dcn32/dcn32_hwseq.c   |  32 +-
 .../amd/display/dc/hwss/dcn32/dcn32_hwseq.h   |   2 +-
 .../amd/display/dc/hwss/dcn32/dcn32_init.c    |   2 +-
 .../amd/display/dc/hwss/dcn35/dcn35_hwseq.c   |  99 ++--
 .../amd/display/dc/hwss/dcn35/dcn35_hwseq.h   |  12 +-
 .../amd/display/dc/hwss/dcn35/dcn35_init.c    |   2 +
 .../amd/display/dc/hwss/dcn351/dcn351_init.c  |   2 +
 .../amd/display/dc/hwss/dcn401/dcn401_hwseq.c |  67 +--
 .../amd/display/dc/hwss/dcn401/dcn401_hwseq.h |   2 +-
 .../amd/display/dc/hwss/dcn401/dcn401_init.c  |   2 +-
 .../amd/display/dc/hwss/dcn42/dcn42_hwseq.c   |  16 +-
 .../amd/display/dc/hwss/dcn42/dcn42_hwseq.h   |   2 +-
 .../amd/display/dc/hwss/dcn42/dcn42_init.c    |   2 +-
 .../amd/display/dc/hwss/dcn50/dcn50_hwseq.c   |  11 +-
 .../amd/display/dc/hwss/dcn60/dcn60_init.c    |   2 +-
 .../drm/amd/display/dc/hwss/hw_sequencer.h    | 108 ++--
 .../drm/amd/display/dc/link/link_detection.c  |   4 +-
 .../gpu/drm/amd/display/dc/link/link_dpms.c   |  17 +-
 .../amd/display/dc/link/protocols/link_ddc.c  |  17 +-
 .../amd/display/dc/link/protocols/link_ddc.h  |   1 -
 .../dc/link/protocols/link_dp_training.c      |  20 +-
 .../display/dc/link/protocols/link_hdmi_frl.c |  12 +-
 .../amd/display/dc/mpc/dcn401/dcn401_mpc.c    |  18 +-
 .../dcn60/dcn60_soc_and_ip_translator.c       |  39 +-
 .../amd/display/include/link_service_types.h  |   1 +
 .../amd/display/modules/power/power_replay.c  |   6 +-
 59 files changed, 853 insertions(+), 563 deletions(-)

--
2.34.1

