Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5E12BC3064D
	for <amd-gfx@archiver.kernel.org>; Fri, 28 Jun 2024 15:06:52 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DEA6E10E0AC;
	Fri, 28 Jun 2024 15:06:51 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="rqYvKj9l";
	dkim-atps=neutral
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2056.outbound.protection.outlook.com [40.107.94.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1A4FF10EC72
 for <amd-gfx@lists.freedesktop.org>; Fri, 28 Jun 2024 15:06:50 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PcMTpiBNaVyowBp633qB6OVlglcgiv9UibMCjXrJsOVKwoxXn7xQbuzANmiAUT1WVOz/wvtBCag8DzHNMWv/NMWQTaRl5ukyKFHS7tsoJj8dOWI/GmZswzitADpa2BMGICUOj8WwKlv3JfW+LZUVvjn4DBAJL6AWn943SCLFuk+zVpZbGlHbG9Zq5ojTW0Nm4zeeITH2bVYngU/nPtu8tww53BX3d4suB29lnPomJIRnqxGHB4px0VbZqBEQisxSdW2S4fAwkSminZ1p4IJK1xXDhmL4U0lAa5fpIE2st0yV1H8t73/EMgKS5UbrU7dwjQBEIn0PbBc1xEWVuvr/Fg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=I4xJLOYZY5iK3i9qmBfnOSx7vjnDE9FG54C/Q+0s5d0=;
 b=fLs4ZwAac8MsmyejPn0D2h/gy9yODDh9j1UwWixEE9mpxZWyKO1OPIn2/p0xdEInr+4ZwehLGs1Itl6hjwdg7wjhSjRigSC5SENb0bZoJk5wXmmVJGu8Sr2mrKexC+uKodiGJcwiPc1B3uiFgZqTa6OqZshOriTttJ5IDdRndsNBnyqMYy7Edx6nKk2pM2bhoCc8WdUQy+LVnZOrPJb0KOSUT6N3+y2PxTSI5G8DG5UL90/IKLEimZ7YpSUWSX0zJSKFSX1FSBmQoeH3C1tivlRstnyvTkIwqY4DeoolF0gvXPhDVofv6E6td5qD77aFb+P96lZs3FJ8btfoHL7Ktw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=I4xJLOYZY5iK3i9qmBfnOSx7vjnDE9FG54C/Q+0s5d0=;
 b=rqYvKj9lOC557qU5VfXq7ZAmsfMxsbM3yaPgagbV1XJ1gQpI4Wi4DyuT+1PwTt46MZxAt2FJWjvzbIKppV2wK+m58QQ0XXGdEI4DiKhNbaoCN8cGKx2uISyM2PH8twMVgcFPIglIuBqEQliGxYzxQfPjUy8rBfmBnqYjLX2WOOA=
Received: from DS0PR12MB6534.namprd12.prod.outlook.com (2603:10b6:8:c1::19) by
 DS7PR12MB5910.namprd12.prod.outlook.com (2603:10b6:8:7b::7) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7698.32; Fri, 28 Jun 2024 15:06:42 +0000
Received: from DS0PR12MB6534.namprd12.prod.outlook.com
 ([fe80::ea87:74ba:36ec:8cf6]) by DS0PR12MB6534.namprd12.prod.outlook.com
 ([fe80::ea87:74ba:36ec:8cf6%4]) with mapi id 15.20.7719.022; Fri, 28 Jun 2024
 15:06:41 +0000
From: "Wheeler, Daniel" <Daniel.Wheeler@amd.com>
To: "Zuo, Jerry" <Jerry.Zuo@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
CC: "Wentland, Harry" <Harry.Wentland@amd.com>, "Li, Sun peng (Leo)"
 <Sunpeng.Li@amd.com>, "Siqueira, Rodrigo" <Rodrigo.Siqueira@amd.com>,
 "Pillai, Aurabindo" <Aurabindo.Pillai@amd.com>, "Li, Roman"
 <Roman.Li@amd.com>, "Lin, Wayne" <Wayne.Lin@amd.com>, "Gutierrez, Agustin"
 <Agustin.Gutierrez@amd.com>, "Chung, ChiaHsuan (Tom)"
 <ChiaHsuan.Chung@amd.com>, "Zuo, Jerry" <Jerry.Zuo@amd.com>, "Zuo, Jerry"
 <Jerry.Zuo@amd.com>
Subject: RE: [PATCH 00/26] DC Patches June 27th, 2024
Thread-Topic: [PATCH 00/26] DC Patches June 27th, 2024
Thread-Index: AQHayNbrmaio45npskuh8iuWoUSq2rHdR5PQ
Date: Fri, 28 Jun 2024 15:06:41 +0000
Message-ID: <DS0PR12MB6534DE3D6C08126D9CCB8FFA9CD02@DS0PR12MB6534.namprd12.prod.outlook.com>
References: <20240627211329.26386-1-Jerry.Zuo@amd.com>
In-Reply-To: <20240627211329.26386-1-Jerry.Zuo@amd.com>
Accept-Language: en-CA, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_0fec2151-cbe0-4586-8a3f-997880a38a28_ActionId=ef87a54b-68b8-4d20-9d9d-a01340380c87;
 MSIP_Label_0fec2151-cbe0-4586-8a3f-997880a38a28_ContentBits=0;
 MSIP_Label_0fec2151-cbe0-4586-8a3f-997880a38a28_Enabled=true;
 MSIP_Label_0fec2151-cbe0-4586-8a3f-997880a38a28_Method=Privileged;
 MSIP_Label_0fec2151-cbe0-4586-8a3f-997880a38a28_Name=Published AMD
 Product;
 MSIP_Label_0fec2151-cbe0-4586-8a3f-997880a38a28_SetDate=2024-06-28T15:06:04Z;
 MSIP_Label_0fec2151-cbe0-4586-8a3f-997880a38a28_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS0PR12MB6534:EE_|DS7PR12MB5910:EE_
x-ms-office365-filtering-correlation-id: 2c0b20e7-8a14-4ff0-5654-08dc9783ea99
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|1800799024|366016|376014|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?xUnD3EZh+Bi+09g9aJruK0miH2tru+wXY5DHs0Hpl8+P+vSrzW8CEgaqNa4b?=
 =?us-ascii?Q?Qco/IuJy4nPxoTbmfHpwqiPl5sKV+jTQdWn55WRPCq3J9e6jW4Q11M335njo?=
 =?us-ascii?Q?ZaoD2c+Ekd3uUYtLUrnwCMastItsq43sAHkXltHWnovmViCK6tRgGGBtO6xZ?=
 =?us-ascii?Q?SWbHZfNdMIBHBM5CAAtPn2csg9Fwxw7+TVroGN3iWZRrfOC3DPUMrmzODSMM?=
 =?us-ascii?Q?85mEozi/vjLtt+NCbJEqXIJ31tV/maMIbyPifJSSwCAqbIE+lWbfAvUCRQQ1?=
 =?us-ascii?Q?6YwaDEOJfACAXI8+6dp7l3M7ffAm32Y2knfKoLaaTOLAJLzcpxZI2MCqZZen?=
 =?us-ascii?Q?NYCwavmdQunStNRmgvkLOiARb/pH6+0Zxxw3w7usL5ZUho/d29JqVskQlJ94?=
 =?us-ascii?Q?zY7mQNLf/VXJBVAaLVg1zrngxybkYZ7otTdSBb1WY0oXexNwLwHqI+2DkbHN?=
 =?us-ascii?Q?vkP/XrQ1A7OdXDk86BSbB63MqHsYxD22wELp1V1r4Uipx4xz8OyhUM6gZVCh?=
 =?us-ascii?Q?ooK2NWyLIxrhACXcKrb4p0bPP8XcC6+3Tz2X+oFpUJZmF8YUBkSwG4lOTUD6?=
 =?us-ascii?Q?HmnMuaGP6JVeGSPfXSf6eB03i1n/Rjvwho9LFOTOL2cFLhxFX42HUUr9GtQS?=
 =?us-ascii?Q?LcHmbkfALN8rDbJhhgpmeDZfDS5d4vcH8NLmpSSeCmyajDD6vgNrGOU8/uXY?=
 =?us-ascii?Q?DJbx22SjLOSU9hkQe5ZcrF5xPPCAoQV3BbqYJHEJ4bY6Y5HhkzC8NC2M2KYP?=
 =?us-ascii?Q?vNKctpsvMlOkE/AWffQzG58cVubuxeKOBjwggAe7ZHnuXztXeCN/u1rMp5wx?=
 =?us-ascii?Q?WUkdqirN6Uy/eRcPu+ac3glgorYkA60gnqAL/24SlMboL0j6kqoGcPYDuDpn?=
 =?us-ascii?Q?Ja1zSTKhdWL673J3jskNaVn+rzoVKCLbHhRATSWVKucLeNoKSGKDxoFlh9rt?=
 =?us-ascii?Q?VzgXmwOSbcO0Eg9FMiv4v0FSYGlAMh6b9KvMTCCWXM2lePCC5l2RL8MAIkcX?=
 =?us-ascii?Q?oMX/eZ/SUM3OgJVq3Al3+Mw9wdqBVMXaaYPj4DVFeky6bcP0cre5WaJM/bgS?=
 =?us-ascii?Q?d2qu++wQVnM33vyTLcFBkuWNGXVHpAn4ePvvSjpHQFAk9LlmBnDdSQV+6KkZ?=
 =?us-ascii?Q?DRE/RmMHoWWFrj5lR7jhAReUAFiWhSmDccmA93dV0MDBYXHfI7dPTD/3BW7l?=
 =?us-ascii?Q?IRfu6N5sXqEn7yPseFwuDAvvZT8BlnEwhY6WZxKo2NAobWRttcj+7dEMQpa+?=
 =?us-ascii?Q?f1Do7jWR2LgECZPYUgBks4fsWJwLoSx3lNbEp7JE+MaHmKAiQQv1LFOkNJaM?=
 =?us-ascii?Q?qXMCTN8zkZ+KnZxDmbmlPOFR4eGfbY388XUayZNiaq8PRoEf+kcdcX2D6WNY?=
 =?us-ascii?Q?VbhgppnsGBLwyrJF2w4e7wkeKBUrxgG3KgRX9CMPqQlvyLp16A=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR12MB6534.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(38070700018); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?bKW9XmOfXQ4Qaa9o9ltx4Ul9VvkNQIp5xwgQbatTdJQMdf5QpZ52WWHzxg++?=
 =?us-ascii?Q?G3c+Ttl0pJ5pZZyeQl2NiQu3grKqAYIfYp79fC+M1CuPr38sFkQPoIMKweIi?=
 =?us-ascii?Q?ntNWxWDanJS8lFWhj8pIHDoNKH1rbcTj2OCHffsgZ92bAiqdY1YKPUf71PaZ?=
 =?us-ascii?Q?VDx9dshf3Dmd7SNuXVyvheWo3kl2TDnz2YI2g7giDDHQIwOvnhz+LDS6C6pD?=
 =?us-ascii?Q?++oHY9+8sh9sAunVlEkhU6QFA1gQP3lrT58KPi8OGOBWycQ7ntLLlJLR6ngH?=
 =?us-ascii?Q?k2bDaFF3LVOcf+8AnYFi1aHHE5VLnOeG4nT/2YBgqht0y04CC8FM+ZDyeQB2?=
 =?us-ascii?Q?s32p09dI+WSONUOGG3TOu6iDCk0iLh2WOEUZspulJhAf0nt+LOUFpqvOOcgw?=
 =?us-ascii?Q?iDcT4xKvyRH1RhDP5R/2haMoA7B5VNSIp/39exQ8MzqE/yXNOohgwmTwMniv?=
 =?us-ascii?Q?wwWsZ23LpZlEle85MygfblU6w/9UVydeh1nLEmotxH1pWdTiIPwUKGV6W2FQ?=
 =?us-ascii?Q?83HWc13RkE70E5gdkkbUrymVzFFbo1LssS/CcBRg7jsymEDkqYjIdaf7MWcv?=
 =?us-ascii?Q?3nZz97n07yCHr3IY7oGM7HNkpI5HLl7LAq1lAhTNEq3LWeHpE1+oNDLNw1En?=
 =?us-ascii?Q?eftfGiXCgD2VtCE/qSlWutpmYv/MQ0ihgMcs1ze9Hs+QzaycM1gV3hMwlK8O?=
 =?us-ascii?Q?OVv0mHmkIsPLflT6KNd1sq2fFBilR7V4/sn/dzrwqPQzzeQTQIkKOFQfnSrq?=
 =?us-ascii?Q?TpE8rMvlhLKZZ39LoUDMIXuNhJgBtTGrZ31yeQ2F1Ar4USM8S/aKVHG9jTKx?=
 =?us-ascii?Q?jSyMKPAaDzQ1OFMOfNZudWIjrNP+8OcCxWpZQ02r4gipeslAvUNB4MnnBa8z?=
 =?us-ascii?Q?DhfeumBOAQrGCxMBb0P0RjQzURE/f7fX3UKv4B1BHfuPKKK7Zf+SAxWe9eMA?=
 =?us-ascii?Q?QH1VVaFbWnFhyqe0b7JIGZ13o0F9LCNZm9nT7+FPg8s1pCeQph5rMObFsMM6?=
 =?us-ascii?Q?sSl8ylfmAB8Neh23vyYepakFZl8NeIm7+mbzaQfpyzTzGuT50hUkgl4Zfy2h?=
 =?us-ascii?Q?UKy/4Z1Cq4t+sLbXmwzy+5SfqBW/wzZu6hMOrivB9gN72chRYK6utymWBWVl?=
 =?us-ascii?Q?ZxoRxYx6g/d0vrLR9MUODhBDj84RqRa89vjvzMtBZROKBLDtaNJYSOZtXalM?=
 =?us-ascii?Q?vSyE8QXtoW4/eWR6UUB6BfzTIDy5DYIK9qF6ZspPgjaj6+X1kb4FTp764Qx9?=
 =?us-ascii?Q?GC3VYi/oNNQoS0MSLV4fuxk1R0iA+q/g8TCovDUicNMQ44LRgKIDXt60vPIz?=
 =?us-ascii?Q?Gb51haSHc7BKnM8FbcMemNZGkmc6PaTIQyjXpjhE+sz9kpaJR6rn88R5mtlr?=
 =?us-ascii?Q?HL55Yf9JRumjg886FdWqtNM5pM2ALicxCvrA7uQIUlwngG2pLCMvOh9V0xVR?=
 =?us-ascii?Q?rtOuNk7OC/uNRNPlMeEderWA1hnwuQKVhuLt51VxkRr3+QajU45sJgdI6+AE?=
 =?us-ascii?Q?Sfi+lTX968+bc39yS2w4SsK4yysNT/6zuAkilVgnttYMlnA2QntkyY1QODM+?=
 =?us-ascii?Q?jyLxAo11+jpFs8m7cEc=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB6534.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2c0b20e7-8a14-4ff0-5654-08dc9783ea99
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Jun 2024 15:06:41.2040 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Om/KwtMHP8DaNdeM7lXzJU/9czlo5/Fe6psmgIBXCa6Fh+7tbZhgGVXndrZ+wd7VLMbC8Yxa6hF0GnoLb1AGug==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB5910
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

This week this patchset was tested on the following systems:
        * Lenovo ThinkBook T13s Gen4 with AMD Ryzen 5 6600U
        * MSI Gaming X Trio RX 6800
        * Gigabyte Gaming OC RX 7900 XTX

These systems were tested on the following display/connection types:
        * eDP, (1080p 60hz [5650U]) (1920x1200 60hz [6600U]) (2560x1600 120=
hz[6600U])
        * VGA and DVI (1680x1050 60hz [DP to VGA/DVI, USB-C to VGA/DVI])
        * DP/HDMI/USB-C (1440p 170hz, 4k 60hz, 4k 144hz, 4k 240hz [Includes=
 USB-C to DP/HDMI adapters])
        * Thunderbolt (LG Ultrafine 5k)
        * MST (Startech MST14DP123DP [DP to 3x DP] and 2x 4k 60Hz displays)
        * DSC (with Cable Matters 101075 [DP to 3x DP] with 3x 4k60 display=
s, and HP Hook G2 with 1 4k60 display)
        * USB 4 (Kensington SD5700T and 1x 4k 60Hz display)
        * PCON (Club3D CAC-1085 and 1x 4k 144Hz display [at 4k 120HZ, as th=
at is the max the adapter supports])

The testing is a mix of automated and manual tests. Manual testing includes=
 (but is not limited to):
        * Changing display configurations and settings
        * Benchmark testing
        * Feature testing (Freesync, etc.)

Automated testing includes (but is not limited to):
        * Script testing (scripts to automate some of the manual checks)
        * IGT testing

The patchset consists of the amd-staging-drm-next branch (Head commit - a20=
10c00faa46264d7722486609cd9a40aaffd69 -> drm/amd: Add some missing register=
 definitions) with new patches added on top of it.

Tested on Ubuntu 22.04.3, on Wayland and X11, using KDE Plasma and Gnome.


Tested-by: Daniel Wheeler <daniel.wheeler@amd.com>


Thank you,

Dan Wheeler
Sr. Technologist | AMD
SW Display
---------------------------------------------------------------------------=
---------------------------------------
1 Commerce Valley Dr E, Thornhill, ON L3T 7X6
amd.com

-----Original Message-----
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Fangzhi =
Zuo
Sent: Thursday, June 27, 2024 5:13 PM
To: amd-gfx@lists.freedesktop.org
Cc: Wentland, Harry <Harry.Wentland@amd.com>; Li, Sun peng (Leo) <Sunpeng.L=
i@amd.com>; Siqueira, Rodrigo <Rodrigo.Siqueira@amd.com>; Pillai, Aurabindo=
 <Aurabindo.Pillai@amd.com>; Li, Roman <Roman.Li@amd.com>; Lin, Wayne <Wayn=
e.Lin@amd.com>; Gutierrez, Agustin <Agustin.Gutierrez@amd.com>; Chung, Chia=
Hsuan (Tom) <ChiaHsuan.Chung@amd.com>; Zuo, Jerry <Jerry.Zuo@amd.com>; Zuo,=
 Jerry <Jerry.Zuo@amd.com>
Subject: [PATCH 00/26] DC Patches June 27th, 2024

This DC patchset brings improvements in multiple areas. In summary, we high=
light:

    * FW Release 0.0.224.0
    * Fix bw issue for dcn351
    * Fix FAMS2 logic issue for dcn401
    * Fix Coverity issues
    * Fix cursor issues
    * Refactor dio sources

Alex Hung (3):
  drm/amd/display: Fix possible overflow in integer multiplication
  drm/amd/display: Check denominator pbn_div before used
  drm/amd/display: Check denominator crb_pipes before used

Alvin Lee (1):
  drm/amd/display: Account for cursor prefetch BW in DML1 mode support

Anthony Koo (1):
  drm/amd/display: Add replay state entry to replay_state

Aric Cyr (1):
  drm/amd/display: 3.2.291

Bhuvanachandra Pinninti (1):
  drm/amd/display: Move dio files into dio folder

Dillon Varone (1):
  drm/amd/display: Cleanup dce_get_dp_ref_freq_khz

Fangzhi Zuo (2):
  drm/amd/display: Fix dmub timeout after fams2 enabled
  drm/amd/display: Update efficiency bandwidth for dcn351

George Shen (2):
  drm/amd/display: Fix divide by zero in CURSOR_DST_X_OFFSET calculation
  drm/amd/display: Add ASIC cap to limit DCC surface width

Joshua Aberback (1):
  drm/amd/display: Remove unnecessary error message

Nevenko Stupar (1):
  drm/amd/display: Adjust cursor visibility between MPC slices

Nicholas Kazlauskas (1):
  drm/amd/display: Add debug option for disabling SLDO optimizations

Paul Hsieh (1):
  drm/amd/display: un-block 8k with single dimm

Roman Li (1):
  drm/amd/display: Fix array-index-out-of-bounds in
    dml2/FCLKChangeSupport

Ryan Seto (1):
  drm/amd/display: Add available bandwidth calculation for audio
    (#16909)

Sherry Wang (1):
  drm/amd/display: Skip unnecessary abm disable

Sung Joon Kim (1):
  drm/amd/display: Choose HUBP unbounded request based on DML output

Teeger (1):
  drm/amd/display: Revert Add workaround to restrict max frac urgent for
    DPM0

Tom Chung (3):
  drm/amd/display: Reset freesync config before update new state
  drm/amd/display: Add refresh rate range check
  drm/amd/display: Fix refresh rate range for some panel

Wenjing Liu (1):
  drm/amd/display: fix a crash when clock source is reference for non
    otg master pipe

Xi (Alex) Liu (1):
  drm/amd/display: replace CRTC disable function call

 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 55 +++++++++++++++-  .../a=
md/display/amdgpu_dm/amdgpu_dm_helpers.c |  4 +-  .../drm/amd/display/amdgp=
u_dm/amdgpu_dm_psr.c |  2 +-  .../gpu/drm/amd/display/dc/basics/dce_calcs.c=
 |  2 +-
 .../display/dc/clk_mgr/dce100/dce_clk_mgr.c   |  2 +-
 .../display/dc/clk_mgr/dcn32/dcn32_clk_mgr.c  |  2 +-  .../display/dc/clk_=
mgr/dcn35/dcn35_clk_mgr.c  |  4 +-
 .../dc/clk_mgr/dcn401/dcn401_clk_mgr.c        | 38 ++++++------
 .../gpu/drm/amd/display/dc/core/dc_resource.c |  8 +--
 .../gpu/drm/amd/display/dc/core/dc_stream.c   |  6 +-
 drivers/gpu/drm/amd/display/dc/dc.h           |  4 +-
 .../gpu/drm/amd/display/dc/dce/dce_audio.c    |  5 +-
 .../drm/amd/display/dc/dce/dce_clock_source.c |  8 +--
 .../drm/amd/display/dc/dce/dce_panel_cntl.c   |  2 +-
 drivers/gpu/drm/amd/display/dc/dcn10/Makefile |  1 -  drivers/gpu/drm/amd/=
display/dc/dcn20/Makefile |  1 -  drivers/gpu/drm/amd/display/dc/dcn30/Make=
file |  2 -  drivers/gpu/drm/amd/display/dc/dcn31/Makefile |  2 +-
 drivers/gpu/drm/amd/display/dc/dio/Makefile   | 36 +++++++++++
 .../dc/{ =3D> dio}/dcn10/dcn10_link_encoder.c   |  0
 .../dc/{ =3D> dio}/dcn10/dcn10_link_encoder.h   |  0
 .../dc/{ =3D> dio}/dcn10/dcn10_stream_encoder.c |  0  .../dc/{ =3D> dio}/d=
cn10/dcn10_stream_encoder.h |  0
 .../dc/{ =3D> dio}/dcn20/dcn20_link_encoder.c   |  0
 .../dc/{ =3D> dio}/dcn20/dcn20_link_encoder.h   |  0
 .../dc/{ =3D> dio}/dcn20/dcn20_stream_encoder.c |  0  .../dc/{ =3D> dio}/d=
cn20/dcn20_stream_encoder.h |  0  .../{ =3D> dio}/dcn30/dcn30_dio_link_enco=
der.c  |  0  .../{ =3D> dio}/dcn30/dcn30_dio_link_encoder.h  |  0
 .../dcn30/dcn30_dio_stream_encoder.c          |  0
 .../dcn30/dcn30_dio_stream_encoder.h          |  0
 .../{ =3D> dio}/dcn31/dcn31_dio_link_encoder.c  |  0  .../{ =3D> dio}/dcn3=
1/dcn31_dio_link_encoder.h  |  0  .../drm/amd/display/dc/dml/dcn32/dcn32_fp=
u.c  |  2 +-
 .../dc/dml/dcn32/display_mode_vba_32.c        |  3 +
 .../amd/display/dc/dml2/dml21/dml21_wrapper.c |  7 ++-  .../display/dc/dml=
2/dml2_translation_helper.c |  1 +  .../gpu/drm/amd/display/dc/dml2/dml2_ut=
ils.c  | 14 +----
 .../drm/amd/display/dc/dml2/dml2_wrapper.c    | 15 -----
 .../drm/amd/display/dc/dml2/dml2_wrapper.h    |  2 -
 .../display/dc/hubbub/dcn401/dcn401_hubbub.c  |  6 ++  .../amd/display/dc/=
hubp/dcn401/dcn401_hubp.c  | 15 ++++-  .../amd/display/dc/hwss/dce110/dce11=
0_hwseq.c | 62 +++++++++++++++++--
 .../amd/display/dc/hwss/dcn10/dcn10_hwseq.c   |  2 +-
 .../amd/display/dc/hwss/dcn21/dcn21_hwseq.c   |  6 ++
 .../amd/display/dc/hwss/dcn401/dcn401_hwseq.c | 47 +++++++++++---  .../amd=
/display/dc/hwss/dcn401/dcn401_hwseq.h |  1 +
 .../link/protocols/link_edp_panel_control.c   |  2 +-
 .../dc/resource/dcn314/dcn314_resource.c      | 22 -------
 .../dc/resource/dcn315/dcn315_resource.c      |  2 +-
 .../dc/resource/dcn35/dcn35_resource.c        |  2 -
 .../dc/resource/dcn401/dcn401_resource.c      |  3 +
 drivers/gpu/drm/amd/display/dc/spl/dc_spl.c   |  8 +--
 drivers/gpu/drm/amd/display/dmub/dmub_srv.h   |  1 +
 .../gpu/drm/amd/display/dmub/inc/dmub_cmd.h   |  5 +-
 .../gpu/drm/amd/display/dmub/src/dmub_dcn35.c |  1 +
 .../amd/display/modules/freesync/freesync.c   |  2 +-
 57 files changed, 287 insertions(+), 128 deletions(-)  rename drivers/gpu/=
drm/amd/display/dc/{ =3D> dio}/dcn10/dcn10_link_encoder.c (100%)  rename dr=
ivers/gpu/drm/amd/display/dc/{ =3D> dio}/dcn10/dcn10_link_encoder.h (100%) =
 rename drivers/gpu/drm/amd/display/dc/{ =3D> dio}/dcn10/dcn10_stream_encod=
er.c (100%)  rename drivers/gpu/drm/amd/display/dc/{ =3D> dio}/dcn10/dcn10_=
stream_encoder.h (100%)  rename drivers/gpu/drm/amd/display/dc/{ =3D> dio}/=
dcn20/dcn20_link_encoder.c (100%)  rename drivers/gpu/drm/amd/display/dc/{ =
=3D> dio}/dcn20/dcn20_link_encoder.h (100%)  rename drivers/gpu/drm/amd/dis=
play/dc/{ =3D> dio}/dcn20/dcn20_stream_encoder.c (100%)  rename drivers/gpu=
/drm/amd/display/dc/{ =3D> dio}/dcn20/dcn20_stream_encoder.h (100%)  rename=
 drivers/gpu/drm/amd/display/dc/{ =3D> dio}/dcn30/dcn30_dio_link_encoder.c =
(100%)  rename drivers/gpu/drm/amd/display/dc/{ =3D> dio}/dcn30/dcn30_dio_l=
ink_encoder.h (100%)  rename drivers/gpu/drm/amd/display/dc/{ =3D> dio}/dcn=
30/dcn30_dio_stream_encoder.c (100%)  rename drivers/gpu/drm/amd/display/dc=
/{ =3D> dio}/dcn30/dcn30_dio_stream_encoder.h (100%)  rename drivers/gpu/dr=
m/amd/display/dc/{ =3D> dio}/dcn31/dcn31_dio_link_encoder.c (100%)  rename =
drivers/gpu/drm/amd/display/dc/{ =3D> dio}/dcn31/dcn31_dio_link_encoder.h (=
100%)

--
2.34.1

