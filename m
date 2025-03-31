Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8C325C3600B
	for <amd-gfx@archiver.kernel.org>; Mon, 31 Mar 2025 16:39:35 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 343C910E123;
	Mon, 31 Mar 2025 16:39:35 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="R/O39XZF";
	dkim-atps=neutral
Received: from NAM04-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam04on2087.outbound.protection.outlook.com [40.107.100.87])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CDB9910E123
 for <amd-gfx@lists.freedesktop.org>; Mon, 31 Mar 2025 16:39:33 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=s9jNxov+QFVoCii8MJyqAP/LQf6v7iWdR0wj7T/Mhx9UWV7AKhZa88Y7eJ/jSijTVR3LpJW/1BZ3Ju6s1P3ZJvqo3sUDsq8+LhwyI8fE0x4i4EIyPtq7L4eZtDBA7YCvjmbyBDcoSYUNKnvMOaJZShANN6ni/lERbQN+lVPsYziBb8vi1wDRRUYKNDRki1JdwYGfZysk/GHO9+kdDzjuM4duLlyVTnOIPisDIdcyq4uFXU1+fSX+QPA5QEl/ncDXBlQfO+regoshAcJDL2D6jpsCoffNYA2roysqGc5Sk35uEgVOPKrnr0sVA21B58foVP86bS95vrDsQGjE0zgbnA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=swMORkMEX2o2I2FILhVJW2EypdJeWpHNsWXKduue5ks=;
 b=mRJ2BwCL4aeBBAoQkIlpURrky+956E0p4T3yiO5laXQ3FR0+ky98NWdjU6SiOm8OG7tHbB9ZDnjP+Ja+JIXajKVr+D0E9+oi01uUoeQe43W3ubE9GvZNbK29d8++ZXGihGUHA7PpR9zICASznrPi2kvSUDesgNqKaMyapsIiRrk8kw/lzjUlcqWLUbcf7ySbp7lz3pn3hSudK0BqB2ixiRv+9/cMN3STdhWqMZuSE8ZmsDcap+1IK7eTCw6FWI/6y270JH67pAJwXMiSnPinSvGIGgkpYntS78XBJGKDPRXr7OLHTtDv2bg2SmgeW6oTzxyF/wtPsAYder6ZVJQ5AQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=swMORkMEX2o2I2FILhVJW2EypdJeWpHNsWXKduue5ks=;
 b=R/O39XZF4XlsTP0tG5TR6g4xk07Q4oFK7dzP5cwQRmKVec3pXwKXK/KIuWjp1FaJ8o+6UPT0McdLb86ctKt2akoB1AwPuTUchh4CxGWrYYgUz0SJrbSMTIP9hZN1c5+a6oh3A9G5pQ7kG4hP9Hwb+/0YNN6VDJ7g/bKkD5FxnGc=
Received: from DS0PR12MB6534.namprd12.prod.outlook.com (2603:10b6:8:c1::19) by
 PH0PR12MB7469.namprd12.prod.outlook.com (2603:10b6:510:1e9::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.47; Mon, 31 Mar
 2025 16:39:28 +0000
Received: from DS0PR12MB6534.namprd12.prod.outlook.com
 ([fe80::ea87:74ba:36ec:8cf6]) by DS0PR12MB6534.namprd12.prod.outlook.com
 ([fe80::ea87:74ba:36ec:8cf6%2]) with mapi id 15.20.8534.043; Mon, 31 Mar 2025
 16:39:28 +0000
From: "Wheeler, Daniel" <Daniel.Wheeler@amd.com>
To: "Zuo, Jerry" <Jerry.Zuo@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
CC: "Wentland, Harry" <Harry.Wentland@amd.com>, "Li, Sun peng (Leo)"
 <Sunpeng.Li@amd.com>, "Pillai, Aurabindo" <Aurabindo.Pillai@amd.com>, "Li,
 Roman" <Roman.Li@amd.com>, "Lin, Wayne" <Wayne.Lin@amd.com>, "Chung,
 ChiaHsuan (Tom)" <ChiaHsuan.Chung@amd.com>, "Zuo, Jerry" <Jerry.Zuo@amd.com>, 
 "Mohamed, Zaeem" <Zaeem.Mohamed@amd.com>, "Chiu, Solomon"
 <Solomon.Chiu@amd.com>, "Hung, Alex" <Alex.Hung@amd.com>, "Zuo, Jerry"
 <Jerry.Zuo@amd.com>
Subject: RE: [PATCH 00/17] DC Patches Mar 24, 2024
Thread-Topic: [PATCH 00/17] DC Patches Mar 24, 2024
Thread-Index: AQHbnoi0B1aor2Uq8EOOm4ZZpQj4r7ONeTLA
Date: Mon, 31 Mar 2025 16:39:28 +0000
Message-ID: <DS0PR12MB6534A1380DD46A53B06E20589CAD2@DS0PR12MB6534.namprd12.prod.outlook.com>
References: <20250326195202.17343-1-Jerry.Zuo@amd.com>
In-Reply-To: <20250326195202.17343-1-Jerry.Zuo@amd.com>
Accept-Language: en-CA, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_ActionId=d9a5af08-e2dc-4df0-ae36-6929d9f862fb;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_ContentBits=0;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Enabled=true;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Method=Privileged;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Name=Open Source;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_SetDate=2025-03-31T16:37:17Z;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Tag=10, 0, 1, 1;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS0PR12MB6534:EE_|PH0PR12MB7469:EE_
x-ms-office365-filtering-correlation-id: dec4cfc6-a63e-43a7-9882-08dd70729af6
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|376014|1800799024|366016|38070700018;
x-microsoft-antispam-message-info: =?iso-8859-1?Q?FpGoK2gJTpEkbt59th/p8oPymfVpaPtjd2UYVJyW3VXHvIy59HLXhf95u0?=
 =?iso-8859-1?Q?8fn+eP8m136eAtwWes550YZi9cB/eFo3I2UxNdEbiOl2yDRmSaHP0iyPl9?=
 =?iso-8859-1?Q?MXpm09IZVb54oTU508bNnfYpITzhur56OZdVe+f0uZCu9NvFmqpaMHp4bB?=
 =?iso-8859-1?Q?W0j2YwnWsts/+UUv17oEasncBFiU509IwR6AgiGImvrriHjwT0mD0bNeRI?=
 =?iso-8859-1?Q?MJmMKhNwLVj9z0TS7W/x1UWPmLEU8x+UySGtSUuLG1BE4omCjXrZmieSfd?=
 =?iso-8859-1?Q?yeBRMBt+THnkMvwiuQq15Vfd331HFDUBLafwc0iQR5zSMek54L4odt2Fz2?=
 =?iso-8859-1?Q?JnwaFPqhunghjkqU5IOMvswgAdZbImV+VEAIkoAbWFb3UvS6pDvZnF2IXJ?=
 =?iso-8859-1?Q?wrDq6mhWby8vq/ZjeLPKp6p40ZKrGIXygQn0oTdzelrZSlRA/XECiOsCxW?=
 =?iso-8859-1?Q?XeoN1se+xp1SdE/xz4fXd2+/ETBGNp82dungoO25Hqu6vmFaG4pcFLgwck?=
 =?iso-8859-1?Q?O0TS490LxL9Ri56YT63PKq1cQXebFHdx2vSQfEtx/DuUfthS4pvnhq6vQZ?=
 =?iso-8859-1?Q?T60YncyPt84cwLqHI8KRL3flr0CABejWrvh48utp9hVMbeodKv8VvHPcjC?=
 =?iso-8859-1?Q?VYdmy3dO4bOVR/Du6sPtbNG/Y3laIJvfQ0FAKos1XWBexHDrpucyQdfVxb?=
 =?iso-8859-1?Q?m30Jt9WVityYMzaipBUJEC7pGts7V59CykWe+0QAuxROA436pYdAUVevYq?=
 =?iso-8859-1?Q?T3urvjXKMmdLIPMCZ/japiBpyOgYngjuOlzVC1GQsotdlRAKSl44UGVj0H?=
 =?iso-8859-1?Q?QDd6pJsPJpfN3k9TODr3Q/0MBZNg2/MInR8eJ8dBLiREfT6zESaVmFLbbk?=
 =?iso-8859-1?Q?1bY4sylmEVPJeFS6zNtkgL+7V5cFq77uhYEY7ycif9KIcDPRdQgl728IPo?=
 =?iso-8859-1?Q?D27DbZT3Q+UREhEjPpnWZyEe5cQJSH1ASadFb1bUX45iSm62YBvrZ23DBa?=
 =?iso-8859-1?Q?yWix+6ez8P0ldSU05+FUyj6Tprl8in8TIk2K+WGc+VW1opRcVc+0nc8Leh?=
 =?iso-8859-1?Q?15HLo14SRMeyIrCS5zQvYRuI5zaD/FgnkFopF99I3yGRXpFikNqFVIpwUK?=
 =?iso-8859-1?Q?re/kb3ZqfXHYktnpgCpjkzKRdd4SqmTIjtvachtjcSfAd5HuE/cLH6dvPa?=
 =?iso-8859-1?Q?u9+qq1vDtMjtQ2mrTyS8MUbQfFsWIYaRSr9FZD3ITBazTFEPilG+PkJXr5?=
 =?iso-8859-1?Q?62FrtRdJS45ZNeeGqDs86L9UywNMHuxL4zTGY9HzNSutuQMGjmtNuVHb7J?=
 =?iso-8859-1?Q?SfQWP7x5M6Ti6bo+Gm2AJ724NWbtiCb+MA45PPtcI60zBZl3HTM1e/PIQ0?=
 =?iso-8859-1?Q?/c8RkK+T4bcLyzXGNo2QBH5twUI/OGOjaigNOxgr94rc1YahLjXLXY2ZM/?=
 =?iso-8859-1?Q?PwCPsr+dH3DSThr41HPj4u0uuIPD8X68LbPcTGm2Jqoo3lTbv6ylojCGnu?=
 =?iso-8859-1?Q?0UE9dfMovKBMytC3+hsIMX?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR12MB6534.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(38070700018); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?ARccausR4B4Ao8Z3fPu7zDnJGhfPGB9FUwM5Z3qqzZXWKCgySNI7F/gIuq?=
 =?iso-8859-1?Q?SnQbHEjlPOd0WR6BBgaFmuCN2wjKiPJof6V3YfbKyHPU0JGr7xtjFR61Ak?=
 =?iso-8859-1?Q?0h+7NDea7m1vAwzXNh6Naup/28WN3lJM48LrwOLpQuwIIa9m/zobrNVF+H?=
 =?iso-8859-1?Q?Mjz4WGFduidcsY95PQWL9iZ0m4ZqvVS0r4JOkQeA6zLxbVam+lFe3GQ4XB?=
 =?iso-8859-1?Q?aYLWgJSUcpy3MedmH16C49kTP3sNE5QWl6pNLQGlQ3zYzjkIaj72m2srzg?=
 =?iso-8859-1?Q?jTFD8gFe5DLen61Msvm2VbS2S3Q4iFtJOdCa8VjNy01O8ZVdgsxWBx7M+0?=
 =?iso-8859-1?Q?lIZQpKqEYWCtZnVtVsDGFa/EofcNRCkCZfPg7MxZRSQ+Dq2YD5m8FyQ5Bn?=
 =?iso-8859-1?Q?0Rx2xu/mZW7eOB3ZNyvtD5Ju5rGvoQRwLBOmxtDS/SWa6KgH0PcTKJoV5J?=
 =?iso-8859-1?Q?MInBWQ/ciDanqSa6cw5hyv0wp4DNJVAQSZRQllwV9paJCi7s9MPeCMgJ4X?=
 =?iso-8859-1?Q?cs4ROPFHku43ZxRjb77W8JdZZlGe0eLVty/oOuml6KB2bavxffriOx9hmr?=
 =?iso-8859-1?Q?EYzQJcQ2BwWBMsTBXEiPSRfHJUDCPk6hssUspO/l5gxXWjj30Ut0cxGPvP?=
 =?iso-8859-1?Q?keP3EmHRbr8W19V6fYV3nK+mYI+WbEmBtbfuF2t7U2EWZDJMbZDidsF5Cv?=
 =?iso-8859-1?Q?DT2P/icHUlgflDvGx48BREJ7HccvxbIF+FzdAG9gwm1+pZP14h53uCDXb7?=
 =?iso-8859-1?Q?kjsYqaIl57HS/PvyJVTr+HOsYtq9CeitaOtpoikORBCrIeYiCRod8NhnPg?=
 =?iso-8859-1?Q?NF2XC5g2KWrMEiqbsZGvCHhdSK/0wqwtQXjGIkOQN9YLAkCUWkjUPWt/hy?=
 =?iso-8859-1?Q?VgwpbXd5PXOel1JKAwBHICZd6IhDpnwqDusvpa2ZVHSV3KsJ/i+PfgYJmO?=
 =?iso-8859-1?Q?KH7YEDS3s6gaiOXEw97PXwJKyrt+lIuQ32tfhaPWgeVhAieK1Ik3nDZoTc?=
 =?iso-8859-1?Q?y3urXgK5HjyN4ruT+p1/VG4VO+9PCTsphijBPgZwO0yrJU1gizkt62PxYP?=
 =?iso-8859-1?Q?0qLLkfiZZTeahyE/L7PpzWo2hz6zg5TzM9BXFT0T4gwdPHdAh2gWBELev+?=
 =?iso-8859-1?Q?lSy/No0GMgyya9AMtujTcSHo8VVeaeggSFyv1DIRTdk5ZvJ/6alNXx9bvX?=
 =?iso-8859-1?Q?oLmAkIXTaFw8FcUwhdu4DRdlAhdkaiW5+f4H+PVUPxNCr5eZR8kw6umUBy?=
 =?iso-8859-1?Q?ji3sBIkH89DfaOO+Vk+3McHgYwRYL5bCus3xBYDAWSZZEORVK7j88o7SUM?=
 =?iso-8859-1?Q?dv7aN1+YS/Jdb6pjEBH9/fEd7rBUjTYRovVaG3T7ldduzOsJAcBBkDqAYy?=
 =?iso-8859-1?Q?0I3uI2r8BbsQf8X43lh0fJNVWFnDvaJi8urO82EyZjrSNJDRbs6owDM1sq?=
 =?iso-8859-1?Q?fg5pyDDNureNYkxI9Vgx/i9cxYL7LjjKVfVWXVuX2vVvnKmhk40gdF2Avk?=
 =?iso-8859-1?Q?BXba24PA5f4y5HcSW1VHOKF5vTU7rj4UeRFjOzqnTBtv9CthIcUPZfyhof?=
 =?iso-8859-1?Q?LcwPE+hVdU6TKAccfl9SDR/QM3Sr5EgaGqW0blGwPtUmU0o7ZkDjuE3JDT?=
 =?iso-8859-1?Q?X1SKjtzDvSYGw=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB6534.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dec4cfc6-a63e-43a7-9882-08dd70729af6
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 Mar 2025 16:39:28.4644 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Mnn9zgw0NEQBEeAMV2df3l6sjwqp/KcoZJFPZPL1kbCV5X+0ks6JRKRwARE5TgBNapHmXwPRS7wckTV4grk8WA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB7469
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
        * Single Display eDP -> 1080p 60hz, 2560x1600 120hz, 1920x1200 165h=
z
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
        * AU Optronics B160QAN02.L 2560x1600 120hz eDP

The patchset consists of the amd-staging-drm-next branch (Head commit - 001=
b75cd258042a9c366f07e1718b510763752a3 -> drm/amd/display: DC v3.2.326) with=
 new patches added on top of it.

Tested on Ubuntu 24.04.1, on Wayland and X11, using KDE Plasma and Gnome.

Tested-by: Daniel Wheeler <daniel.wheeler@amd.com>

Thank you,

Dan Wheeler
Sr. Technologist  |  AMD
SW Display
---------------------------------------------------------------------------=
---------------------------------------
1 Commerce Valley Dr E, Thornhill, ON L3T 7X6
Facebook |  Twitter |  amd.com


-----Original Message-----
From: Fangzhi Zuo <Jerry.Zuo@amd.com>
Sent: Wednesday, March 26, 2025 3:49 PM
To: amd-gfx@lists.freedesktop.org
Cc: Wentland, Harry <Harry.Wentland@amd.com>; Li, Sun peng (Leo) <Sunpeng.L=
i@amd.com>; Pillai, Aurabindo <Aurabindo.Pillai@amd.com>; Li, Roman <Roman.=
Li@amd.com>; Lin, Wayne <Wayne.Lin@amd.com>; Chung, ChiaHsuan (Tom) <ChiaHs=
uan.Chung@amd.com>; Zuo, Jerry <Jerry.Zuo@amd.com>; Mohamed, Zaeem <Zaeem.M=
ohamed@amd.com>; Chiu, Solomon <Solomon.Chiu@amd.com>; Wheeler, Daniel <Dan=
iel.Wheeler@amd.com>; Hung, Alex <Alex.Hung@amd.com>; Zuo, Jerry <Jerry.Zuo=
@amd.com>
Subject: [PATCH 00/17] DC Patches Mar 24, 2024

Summary:

* Improve vrr for replay and psr
* Rewrite drm debug message
* Fix clock issues for dcn32 and dcn401
* Fix mst dsc mode validation issue

Aric Cyr (1):
  drm/amd/display: Promote DAL to 3.2.327

Aurabindo Pillai (6):
  drm/amd/display: convert DRM_ERROR to drm_err in
    hpd_rx_irq_create_workqueue()
  drm/amd/display: use drm_err in hpd rx offload
  drm/amd/display: use drm_err in create_validate_stream_for_sink()
  drm/amd/display: convert more DRM_ERROR to drm_err
  drm/amd/display: use drm_info instead of DRM_INFO
  drm/amd/display: use drm_warn instead of DRM_WARN

Austin Zheng (1):
  drm/amd/display: Set ODM Factor Based On DML Architecture

ChunTao Tso (1):
  drm/amd/display: Add a Panel Replay config option

Dillon Varone (4):
  drm/amd/display: Consider downspread against max clocks in DML2.1
  drm/amd/display: Add Support for reg inbox0 for host->DMUB CMDs
  drm/amd/display: Fix VUpdate offset calculations for dcn401
  drm/amd/display: Fix Vertical Interrupt definitions for dcn32, dcn401

Fangzhi Zuo (1):
  drm/amd/display: Do Not Consider DSC if Valid Config Not Found

Joshua Aberback (1):
  drm/amd/display: Use meaningful size for block_sequence array

Robin Chen (1):
  drm/amd/display: Enable Replay Low Hz feature flag

Tom Chung (1):
  drm/amd/display: Do not enable Replay and PSR while VRR is on in
    amdgpu_dm_commit_planes()

 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 296 ++++++++---------
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h |   4 +
 .../amd/display/amdgpu_dm/amdgpu_dm_crtc.c    |   6 +-
 .../display/amdgpu_dm/amdgpu_dm_mst_types.c   |  17 +-
 .../drm/amd/display/dc/core/dc_hw_sequencer.c |   4 +-
 drivers/gpu/drm/amd/display/dc/dc.h           |   2 +-
 drivers/gpu/drm/amd/display/dc/dc_dmub_srv.c  | 185 ++++++-----
 drivers/gpu/drm/amd/display/dc/dc_dmub_srv.h  |   2 +-
 drivers/gpu/drm/amd/display/dc/dc_helper.c    |   2 +-
 drivers/gpu/drm/amd/display/dc/dc_types.h     |   7 +-
 .../gpu/drm/amd/display/dc/dce/dmub_abm_lcd.c |   3 +-
 .../gpu/drm/amd/display/dc/dce/dmub_replay.c  |  19 +-
 .../src/dml2_core/dml2_core_dcn4_calcs.c      |   6 +-
 .../dml2/dml21/src/dml2_mcg/dml2_mcg_dcn4.c   |   4 +
 .../src/inc/dml2_internal_shared_types.h      |   6 +
 .../display/dc/dml2/dml2_dc_resource_mgmt.c   |  24 +-
 .../amd/display/dc/hwss/dcn401/dcn401_hwseq.c |  44 +++
 .../amd/display/dc/hwss/dcn401/dcn401_hwseq.h |   1 +
 .../amd/display/dc/hwss/dcn401/dcn401_init.c  |   2 +-
 .../drm/amd/display/dc/hwss/hw_sequencer.h    |   8 +-
 .../gpu/drm/amd/display/dc/inc/core_types.h   |   2 +-
 .../display/dc/irq/dcn32/irq_service_dcn32.c  |  61 +++-
 .../dc/irq/dcn401/irq_service_dcn401.c        |  60 +++-
 drivers/gpu/drm/amd/display/dc/irq_types.h    |   9 +
 .../display/dc/link/protocols/link_dp_dpia.c  |   1 +
 .../link/protocols/link_edp_panel_control.c   |   3 +
 drivers/gpu/drm/amd/display/dmub/dmub_srv.h   | 132 +++++---
 .../gpu/drm/amd/display/dmub/inc/dmub_cmd.h   |   4 +
 .../drm/amd/display/dmub/src/dmub_dcn401.c    | 121 ++++---
 .../drm/amd/display/dmub/src/dmub_dcn401.h    |   4 +-
 .../gpu/drm/amd/display/dmub/src/dmub_srv.c   | 297 ++++++++++++------
 31 files changed, 858 insertions(+), 478 deletions(-)

--
2.43.0

