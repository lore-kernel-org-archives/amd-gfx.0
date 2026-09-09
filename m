Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BB3F0C79FB6
	for <amd-gfx@archiver.kernel.org>; Wed,  9 Sep 2026 13:17:22 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 11CCE10E033;
	Wed,  9 Sep 2026 13:17:22 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="c74dv+bN";
	dkim-atps=neutral
Received: from PH0PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11011047.outbound.protection.outlook.com [40.107.208.47])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9BBA210E1A4
 for <amd-gfx@lists.freedesktop.org>; Wed,  9 Sep 2026 13:17:19 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XHOEQIPgmPPXjOHXDBFq5PiCOJRdgYZSPh8vVibUFZBmhuSg1W0Ltuopv/TvNyoWxQKfkY7znFUVs5331fTMxAAFm83P8vyGgrHtuZ6YNt0YkZkymQPlF9XnspHvKdF8+/jYJLjSc/gL9G5YN9+9Kq/J4qBKgAszoCkrVzhsCAqH5rCTNZ45qCoQSIqXaZGOo275NvE/yjrh6yuEQJfwASHyyhBnr9Cr/BB4sjgvu427fzN++lrpB1Yjh+TrY0735ncggs15Npa5U4/zIAkY91jP0TwcdE0knB0g7hR2CWMmuEHfEmMapweSGTIPlhnu1sZs+I4aPlawB/FKEo0PlA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4/kp7G7JDpg3J3HfFgxXKAuElInlVHd6zQRi6ZMW/cY=;
 b=Tum9PzscPneclRkUuYHs3KNCSsw5U/twsUG9rDA6SvYL9eVI2zMCbbKXFkfhaMAmG+K4OYA/ryosIFoIwVhPLWJM1K+BXAljifx4YNFVTETwX9iJp7HFjj9UphRuyiazWek5ePUGz/DCtBCrcovk8oZ1zb3cu8bACUhgcUAYQv2/6llVwJwanJ4oHpsFTIqbhkRXNzb0/URwp+kcJaAKpjSnsOh/NvxCDz1xrbq9yBwHl4FT7VosyEzn1bkcEh+0O9+wCIArTnDLdlqJxmkrgPy2G/t09pFstaXTTF/tNfS4b3zjAcKGhI3eqhpTEA9lpyQHkvc98E8CzIkb57sNFA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4/kp7G7JDpg3J3HfFgxXKAuElInlVHd6zQRi6ZMW/cY=;
 b=c74dv+bN2Tu8NIutdvwIoUdEFnlKBA0nS7pgkqiEGk79sx8i8NOTm2Dq0ndMtvfLdEcdAsuxqwnXLqUh+2esz39DU4rjGyPl8rH3tPTWe5/qDGxKjZvPOt7xit6C5ZN7snkp3mPmuKUfqZ46nT/dA4mQtN+BYgARJ5oVL8UDTjk=
Received: from DS0PR12MB6534.namprd12.prod.outlook.com (2603:10b6:8:c1::19) by
 DM6PR12MB4297.namprd12.prod.outlook.com (2603:10b6:5:211::20) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.406.8; Wed, 9 Sep 2026 13:17:17 +0000
Received: from DS0PR12MB6534.namprd12.prod.outlook.com
 ([fe80::b2e1:64e5:3b9e:738a]) by DS0PR12MB6534.namprd12.prod.outlook.com
 ([fe80::b2e1:64e5:3b9e:738a%4]) with mapi id 15.21.0406.005; Wed, 9 Sep 2026
 13:17:15 +0000
From: "Wheeler, Daniel" <Daniel.Wheeler@amd.com>
To: "Wu, Ray" <Ray.Wu@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
CC: "Wentland, Harry" <Harry.Wentland@amd.com>, "Li, Sun peng (Leo)"
 <Sunpeng.Li@amd.com>, "Pillai, Aurabindo" <Aurabindo.Pillai@amd.com>, "Li,
 Roman" <Roman.Li@amd.com>, "Lin, Wayne" <Wayne.Lin@amd.com>, "Chung,
 ChiaHsuan (Tom)" <ChiaHsuan.Chung@amd.com>, "Zuo, Jerry" <Jerry.Zuo@amd.com>, 
 "Wu, Ray" <Ray.Wu@amd.com>, "LIPSKI, IVAN" <IVAN.LIPSKI@amd.com>, "Hung,
 Alex" <Alex.Hung@amd.com>, "Lin, Ping Lei" <PingLei.Lin@amd.com>, "Chen,
 Chen-Yu" <Chen-Yu.Chen@amd.com>, "Wu, Ray" <Ray.Wu@amd.com>
Subject: RE: [PATCH 00/40] DC Patches September 7, 2026
Thread-Topic: [PATCH 00/40] DC Patches September 7, 2026
Thread-Index: AQHdOpiJCfJ8ZyDs/UGV9KRwbUSXfLbGRbvg
Date: Wed, 9 Sep 2026 13:17:15 +0000
Message-ID: <DS0PR12MB65345E321315C556D8506E169CB02@DS0PR12MB6534.namprd12.prod.outlook.com>
References: <20260902050411.3473916-1-ray.wu@amd.com>
In-Reply-To: <20260902050411.3473916-1-ray.wu@amd.com>
Accept-Language: en-CA, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_2d0b1989-8fc8-4a69-bcac-d46889461ba5_Enabled=True;
 MSIP_Label_2d0b1989-8fc8-4a69-bcac-d46889461ba5_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_2d0b1989-8fc8-4a69-bcac-d46889461ba5_SetDate=2026-09-09T13:17:11.0000000Z;
 MSIP_Label_2d0b1989-8fc8-4a69-bcac-d46889461ba5_Name=AMD Public
 v26; MSIP_Label_2d0b1989-8fc8-4a69-bcac-d46889461ba5_ContentBits=3;
 MSIP_Label_2d0b1989-8fc8-4a69-bcac-d46889461ba5_Method=Privileged
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS0PR12MB6534:EE_|DM6PR12MB4297:EE_
x-ms-office365-filtering-correlation-id: 5ef059c6-cc8c-43bb-c017-08df0e74ab03
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|1800799024|23010399003|366016|38070700021|6133799003|3023799007|10067099003|11063799006|56012099006|22082099003|18002099003;
x-microsoft-antispam-message-info: O2k1Hd/W5e97W0OZEbbkRd+p/pplASh1qoAhOLujygOCVdZrAQgU9BC/HdjNGxuvHFoNvIk0G5DPOp70zU+D6n+t12YtdZ4zAcx1DeCbq9CeD5dLsvBIIAN0HdseFicLjkML1a0Nm4s+UlPjlThXf9v4+UQ6ZmLD0HdrxaxycGBHSSbZ+aan1Gczz0500rqkEsF5EN+FlkWmY9XVdm5CGlJ9+fOrAwcGsft102ORRn5zgoGsWiQbUGPAMDpt4m/J2cA6vgf+AIjHFB6HlsdG9tMDcghi1PhRAbQ/yXvKSEDVydzqCnOmASx1gn0rkEQc6/60pgchO+zSvXls7dwgDloJDNE7ZZPwPlB65WwnRdX5cL6lISbooBIGPsx6rgGOU+WJsDZaCmNDjfS1qfBQu+mD9tv5Nt/tHZ0sXulDSkSzgNdt8nNm3bC5CSOTEdNXyvLYZpskh6AmI7VYeRVAQv6iacgaCRPiUC3QFN2KLfwPufcYfd4CUOIA5OYpx4B9RcUOWmcLRr3lLvDYZFAaf8x/J/S91M/mHnRPMz3dwnZ25yq5u3m2NqKq+STtRkDN3gkeaqS11mg61RKv0o9sQzmDo+7QlCqvazMkikI6hgym2qgMWr7sXicSQ4S2RCG2c40FCicqN/veBWEMZK15a2h8AEgvuypIvvNkhnEKha5EJAXcGeh0npZyeGbhDClukYk7QULw9x/yVQ8keBP+YyvEhEqVIRiERShLFWxCarw=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR12MB6534.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(23010399003)(366016)(38070700021)(6133799003)(3023799007)(10067099003)(11063799006)(56012099006)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?wVthPjFwL3gv5WACqJc+c/SG3u8LqFMxiiU5YnVLNVIelPMxZ0M1ZQAfUP?=
 =?iso-8859-1?Q?TwZTalpoTrNecxjm1OT3Ey4ZBvdD/cBFjCQCcTYEVCmRUDOvTZZPAL7ktd?=
 =?iso-8859-1?Q?RAqxHo38UsY+GJkcmQfnoIbRp2ymBzVrY6gLhq6tnrPAt+SYk9nX91hyiA?=
 =?iso-8859-1?Q?RNEHLG52XLF9BZYo3NRNncF8N4R1wx8ITDblV2rm/nAtpHA4tzlxfpDmq4?=
 =?iso-8859-1?Q?tCCEVCjsnzNIOLuP/sNgLVtoVBGx38ZmSxjFiUHez9VEby0wSG9maEKuRD?=
 =?iso-8859-1?Q?bi/DRHycrS2cWS8SA4q2HIOtj/MyYIhSlVR3SENVG8u8YQlclY3oSYZsPE?=
 =?iso-8859-1?Q?v58X41AahD1yL6Z3Lul7v3FkHPy4ddUYcgKhoOLVXvS1uMgAPaRXnYrP6s?=
 =?iso-8859-1?Q?FBNVPY3fgzhZB1LtvkWxPpig+ND6U2QjSa61lgW6MJypra90ISg9YNDVl8?=
 =?iso-8859-1?Q?U67rLD4v23vTBQTFon/IwBGOtUKnvMyAtOmv9iVEuhp6xfYl7+jdI/iwFP?=
 =?iso-8859-1?Q?cvFs3a5WLosHg7ZJcs64j46Dfdm3UWIA8UoSi7Ccr+wUxP4ufByYS8lOPw?=
 =?iso-8859-1?Q?2MN+kemXiPfNw9W2tOW2TVufBcilWAv2eSYP2BqKZghxMjDoSOpTfMSw7Z?=
 =?iso-8859-1?Q?v3sqwwzSD+IZxNe8mmvt/WvHn1QmdaLPJYa9DpdS5cJXzGGBdeHzGjEj5C?=
 =?iso-8859-1?Q?J2Ls9bAxos3IJDshkZMogqWmKpyFg86j/5mLVKOUjNjj2D235C+GsRbA0F?=
 =?iso-8859-1?Q?Gr+wnNK9MuPXfmPjm7zI9rICY8q4SC5YsAotGWEU/bvdIxkMpKCPqSSZ8O?=
 =?iso-8859-1?Q?IfFZ2mfxj4e9pMLKqGGnpvzm1KC3wo4CnskiSVZ5dv6dXQpUyEO9IsoAq5?=
 =?iso-8859-1?Q?ELX9VtnWZ0XEohpEKwVFNAItI4Gp7IQfcU3tJCJ9uPt5njMUYMN126lPes?=
 =?iso-8859-1?Q?XCy7cpfPaSR+cPsBFK+K1J5TXY6n/zhY3h4CjTFOfHYJOQqydRPzBP8PjX?=
 =?iso-8859-1?Q?Xh4L5KRn6LqFw8ZuRJ9s+Jr+F9krNGgZAyDtQAFD3R17ySM875GDXLsQ9Z?=
 =?iso-8859-1?Q?0/7gBAaWTOJSG90/lTEIjBQhabOB7rwIrLEX2OQbDJnSyUNVVLlyoR4XUw?=
 =?iso-8859-1?Q?nu8GyGkpH+dk4FeUq9GEJOPyYFxP3nDn0FJgD5/lvg5q54gfF6JfuccB3C?=
 =?iso-8859-1?Q?pKmFmGyVWAXGKs4xqqeqMftrMKp1QDuTy9kEN+guKgH6I2B15HXrtYIRHT?=
 =?iso-8859-1?Q?o/bRblA8RlqPsdamaKNzjNexZVek9voEuSXpdFayvxZ0NXWhcls800IAYq?=
 =?iso-8859-1?Q?aY/kIMAnmp1B1aGVC2fWYDZ6zWExtLSSIFoMafHvEnIwjJG8EInlW3Eg81?=
 =?iso-8859-1?Q?5Jko82xlG/pHsPAKbGWv7kBoAm66qSnTIlV34uQ6H018bKtUZvRc5Ngq6f?=
 =?iso-8859-1?Q?z1pR31emWHOIwdZeigsU40fWMKMNk1gJHx+jnSaJ8R5yDJIEmIwtS27RUB?=
 =?iso-8859-1?Q?gXOCl8zraCdfT1jjtrkKutPtk836cjkIrSgV9svK1GzYI1h7f8fByhDilx?=
 =?iso-8859-1?Q?oD5uTociaVrEfRXYB+KNHZTJOxYFtWhR1/qu7puTnXOS/5uApZ1KpnjElk?=
 =?iso-8859-1?Q?Ro77wVxb8f+YMZch6Ut8A9vumfQ/1xQiDIcSZPjFCxlfZUnzibEas6hc0r?=
 =?iso-8859-1?Q?EfYkySwtqvqH9FZIaBM7gjIkLe79djbS2k2dS0rnr7UQX3QD/o9putM4+U?=
 =?iso-8859-1?Q?+Ji4jdc9tvUHuieviMIMyWs2svedZhFt7SL/xP16k3sOtF?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB6534.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5ef059c6-cc8c-43bb-c017-08df0e74ab03
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Sep 2026 13:17:15.7751 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: GAwCfPgY5rcx5NOpazCmEpmO9NW2nG66Plvo61mgH2+3ysoleXYwkO5m09TU8Ezr9AW1fcGI/AezCgguB/1SSA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4297
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


The patchset consists of the amd-staging-drm-next branch (Head commit - a84=
de5c9feaa2dbffac1f062ad3b4c0deca1ccc7 -> drm/amd/display: validate plane de=
gamma LUT size for private color prop) with new patches added on top of it.

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
From: Ray Wu <ray.wu@amd.com>
Sent: Wednesday, September 2, 2026 12:58 AM
To: amd-gfx@lists.freedesktop.org
Cc: Wentland, Harry <Harry.Wentland@amd.com>; Li, Sun peng (Leo) <Sunpeng.L=
i@amd.com>; Pillai, Aurabindo <Aurabindo.Pillai@amd.com>; Li, Roman <Roman.=
Li@amd.com>; Lin, Wayne <Wayne.Lin@amd.com>; Chung, ChiaHsuan (Tom) <ChiaHs=
uan.Chung@amd.com>; Zuo, Jerry <Jerry.Zuo@amd.com>; Wheeler, Daniel <Daniel=
.Wheeler@amd.com>; Wu, Ray <Ray.Wu@amd.com>; LIPSKI, IVAN <IVAN.LIPSKI@amd.=
com>; Hung, Alex <Alex.Hung@amd.com>; Lin, Ping Lei <PingLei.Lin@amd.com>; =
Chen, Chen-Yu <Chen-Yu.Chen@amd.com>; Wu, Ray <Ray.Wu@amd.com>
Subject: [PATCH 00/40] DC Patches September 7, 2026

This DC patchset brings improvements in multiple areas. In summary, we high=
light:

- Ensure requested LSDMA bandwidth stays within the SOP bound.
- Refactor DC_SEND_CURSOR_INFO_TO_DMU to drop the pipe_ctx param.
- Add an override for LSDMA bandwidth in the QoS table.
- Expand amdgpu_dm KUnit coverage across vblank IRQ, self-refresh, GPU
  reset, plane update, MST resume, cached suspend state, writeback
  transitions, atomic validation, connector-state restore, EDID CEA
  parsing and DM IRQ source handling.
- Keep streamclk gating off when enabling streamclk.
- Set mpc_tree_params->opp_id during OPP resource construct.
- Add override capability for UTM table params.
- Add immediate restore to FAMS2 for DRR.
- Fix missing APG registers for DCN60 HDMI.
- Exit IPS before connector detection on resume.
- Fix HF-VSDB DSC bpc detection to be cumulative.
- Fix unused params in flip schedule.
- Enable the FW locality check in DCN6.
- Fix DC Hub reference frequency assert range.
- Dump clock registers in HW init instead of SW init.
- Validate the IRQ source in the DM IRQ handler.
- Revert "Fix CalculateFlipSchedule Calculation".
- Assorted DML updates.
- Update urgent burst calculation to account for unbounded requests.
- Add a stressed peak-bandwidth probe with DMA contention.
- Revert "Unify CalculateFlipSchedule Logic".

Cc: Dan Wheeler <daniel.wheeler@amd.com>

Alex Hung (12):
  drm/amd/display: Test vblank IRQ handling
  drm/amd/display: Test self refresh entry
  drm/amd/display: Test GPU reset helpers
  drm/amd/display: Test plane update adapter
  drm/amd/display: Test MST resume guards
  drm/amd/display: Test cached suspend state
  drm/amd/display: Test writeback state transitions
  drm/amd/display: Test atomic validation guards
  drm/amd/display: Fix unused params in flip sched
  drm/amd/display: Validate irq source in DM IRQ handler
  drm/amd/display: Test DM IRQ handler source guard
  drm/amd/display: Fix signedness mismatches in cm3

Alvin Lee (5):
  drm/amd/display: Ensure requested LSDMA BW is within the SOP bound
  drm/amd/display: Add override for LSDMA BW in QoS table
  drm/amd/display: Add override capability for UTM table params
  drm/amd/display: Enable FW locality check in DCN6
  drm/amd/display: Dump clock registers in HW init instead of SW init

Austin Zheng (4):
  drm/amd/display: Set DISPCLK per surface in DML
  drm/amd/display: Update Urgent Burst Calculation To Account For
    Unbounded Requests
  Revert "drm/amd/display: Unify CalculateFlipSchedule Logic"
  drm/amd/display: Update DML fields used for mode support

Bhawanpreet Lakha (2):
  drm/amd/display: Cover dm_restore_drm_connector_state
  drm/amd/display: Cover EDID CEA parsing helpers

Charlene Liu (1):
  drm/amd/display: Make sure streamclk gating is off when enabling
    streamclk

Dillon Varone (1):
  drm/amd/display: Add immediate restore to FAMS2 for DRR

Fangzhi Zuo (3):
  drm/amd/display: Exit IPS before connector detection on resume
  drm/amd/display: Fix HF-VSDB DSC bpc detection to be cumulative
  drm/amd/display: Fix NULL deref of new_stream->sink in VTEM guard

Ilya Bakoulin (1):
  drm/amd/display: Fix missing APG regs for DCN60 HDMI

Joshua Aberback (1):
  drm/amd/display: Remove unnecessary includes

Nevenko Stupar (1):
  drm/amd/display: Fix DC Hub reference frequency assert range

Ovidiu Bunea (1):
  drm/amd/display: Set mpc_tree_params->opp_id during OPP resource
    construct

Samson Tam (1):
  Revert "drm/amd/display: Fix CalculateFlipSchedule Calculation"

Taimur Hassan (2):
  drm/amd/display: [FW Promotion] Release 0.1.74.0
  drm/amd/display: Promote DC to 3.2.397

Tomasz Siemek (1):
  drm/amd/display: Refactor DC_SEND_CURSOR_INFO_TO_DMU to drop pipe_ctx

Wenjing Liu (4):
  drm/amd/display: Add stressed peak bandwidth probe with DMA contention
  drm/amd/display: Add dml2_core_dcn6_calcs function pointer table
  drm/amd/display: Route DCN6 mode support calcs through function
    pointer table
  drm/amd/display: Route DCN6 mode programming calcs through function
    pointer table

 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 141 ++--  .../gpu/drm/amd/=
display/amdgpu_dm/amdgpu_dm.h |  50 ++
 .../display/amdgpu_dm/amdgpu_dm_connector.c   |  13 +-
 .../display/amdgpu_dm/amdgpu_dm_connector.h   |  10 +
 .../display/amdgpu_dm/amdgpu_dm_freesync.c    |   4 +-
 .../amd/display/amdgpu_dm/amdgpu_dm_helpers.c |   5 +-
 .../drm/amd/display/amdgpu_dm/amdgpu_dm_irq.c |   5 +
 .../tests/amdgpu_dm_connector_test.c          | 514 +++++++++++++
 .../amdgpu_dm/tests/amdgpu_dm_helpers_test.c  |   2 +-
 .../amdgpu_dm/tests/amdgpu_dm_irq_test.c      |  45 ++
 .../display/amdgpu_dm/tests/amdgpu_dm_test.c  | 676 +++++++++++++++++-
 .../drm/amd/display/dc/clk_mgr/dcn60/dalsmc.h |   2 +-
 .../display/dc/clk_mgr/dcn60/dcn60_clk_mgr.c  | 210 ++++--
 .../dc/clk_mgr/dcn60/dcn60_smu_driver_if.h    |  44 +-
 drivers/gpu/drm/amd/display/dc/core/dc.c      |   4 +-
 .../gpu/drm/amd/display/dc/core/dc_debug.c    |   2 +
 .../drm/amd/display/dc/core/dc_hw_sequencer.c |  86 ++-
 .../gpu/drm/amd/display/dc/core/dc_resource.c |   4 +
 .../gpu/drm/amd/display/dc/core/dc_stream.c   |  21 +-
 drivers/gpu/drm/amd/display/dc/dc.h           |   4 +-
 drivers/gpu/drm/amd/display/dc/dc_dmub_srv.c  |  45 +-
 drivers/gpu/drm/amd/display/dc/dc_dmub_srv.h  |   7 +-
 drivers/gpu/drm/amd/display/dc/dc_probe.h     |   1 +
 .../amd/display/dc/dccg/dcn35/dcn35_dccg.c    |   1 +
 .../amd/display/dc/dccg/dcn42/dcn42_dccg.c    |  14 +-
 .../amd/display/dc/dccg/dcn42/dcn42_dccg.h    |   2 +-
 .../amd/display/dc/dcn30/dcn30_cm_common.c    |   8 +-
 .../drm/amd/display/dc/dml/dcn10/dcn10_fpu.c  |   1 -
 .../drm/amd/display/dc/dml/dsc/rc_calc_fpu.c  |   1 -
 .../gpu/drm/amd/display/dc/dml2_0/Makefile    |   1 +
 .../dml21/inc/bounding_boxes/dcn4_soc_bb.h    |   2 +-
 .../dml21/inc/bounding_boxes/dcn6_soc_bb.h    |  12 +
 .../dml21/inc/dml_top_dchub_registers.h       |   1 +
 .../dml21/inc/dml_top_soc_parameter_types.h   |   2 +
 .../dc/dml2_0/dml21/inc/dml_top_types.h       |  13 +
 .../dml2_0/dml21/src/dml2_cga/dml2_cga_dcn6.c |   4 +-
 .../src/dml2_core/dml2_core_dcn4_calcs.c      | 172 +++--
 .../dml2_core/dml2_core_dcn5_calcs_dchub.c    |   8 +-
 .../dml2_core/dml2_core_dcn5_calcs_dchub.h    |  23 +
 .../dml2_core_dcn5_calcs_display_pipe.c       |   2 +-
 .../dml2_core_dcn5_funcs_mode_programming.c   |   4 +
 .../dml2_core_dcn5_funcs_mode_support.c       |   4 +
 .../src/dml2_core/dml2_core_dcn6_calcs.c      |  63 +-
 .../src/dml2_core/dml2_core_dcn6_calcs.h      | 468 ++++++++++++
 .../dml2_core/dml2_core_dcn6_calcs_dchub.c    |  35 +-
 .../dml2_core_dcn6_funcs_initialize.c         |   2 +
 .../dml2_core_dcn6_funcs_mode_programming.c   |  52 +-
 .../dml2_core_dcn6_funcs_mode_programming.h   |  31 +
 .../dml2_core_dcn6_funcs_mode_support.c       | 312 ++++----
 .../dml2_core_dcn6_funcs_mode_support.h       | 324 +++++++++
 .../src/dml2_core/dml2_core_shared_types.h    |   7 +-
 .../dml2_utm_soc_bb/dml2_utm_soc_bb_dcn6.c    |  13 +
 .../src/inc/dml2_internal_shared_types.h      |  18 +
 .../display/dc/hubbub/dcn20/dcn20_hubbub.c    |   5 +-
 .../display/dc/hubbub/dcn60/dcn60_hubbub.c    |   3 +-
 .../amd/display/dc/hwss/dcn60/dcn60_hwseq.c   |  26 +-
 .../drm/amd/display/dc/hwss/hw_sequencer.h    |  25 +-
 .../gpu/drm/amd/display/dc/inc/core_status.h  |   2 +
 .../gpu/drm/amd/display/dc/inc/core_types.h   |   9 +
 .../drm/amd/display/dc/opp/dcn20/dcn20_opp.c  |   2 +
 .../dc/resource/dcn60/dcn60_resource.c        |  25 +-
 .../gpu/drm/amd/display/dmub/inc/dmub_cmd.h   |  26 +
 62 files changed, 3148 insertions(+), 470 deletions(-)

--
2.43.0

