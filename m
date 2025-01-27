Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 47E2DC0218C
	for <amd-gfx@archiver.kernel.org>; Mon, 27 Jan 2025 14:06:24 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E0E1E10E113;
	Mon, 27 Jan 2025 14:06:23 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="WTKvuXAK";
	dkim-atps=neutral
Received: from NAM02-SN1-obe.outbound.protection.outlook.com
 (mail-sn1nam02on2075.outbound.protection.outlook.com [40.107.96.75])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E553710E529
 for <amd-gfx@lists.freedesktop.org>; Mon, 27 Jan 2025 14:06:21 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pLDom0Y2Bpn4pSVB58ACWqjsRAkhyhHWV/IRZT/TvFnMQIiNOBEr2wivRKGImmFdjpqzKrO2WTGtjmd35unq9y4vx1up460Xb0CQiiARfTcvxA3IHFz2oK49ayHQ2Utv2FYa/LK8GT8E9aTCrJIWHu8G0lKhmDXaSFha5t72s4/9tnNB8hv9Ks8JKixA4vf6bOQTy3C9U32nDJH/D9SPUnMKMeJVPIP5IP5TLO/+7cAGVa/JGTysjG0DfFeAX3jJDH7o+GJN27AmMCx9mTmM9wWsnZ7CZngO5ACVXXpAN6+671+XqCeJCTHIcKSJ1Mj8X3f33xBaR9VZeI0XfGYrxw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+AWN4VbVeDYXTF8TkQnLmA5J1BTwh4PHFtKej4W2VPo=;
 b=dpXJ1+b5qzK/7Ih+unw+ANG16UtsnBvtvUX/nH7JP9dZY2SJ8tizFtaqb22fXzOgqlwvcVI6846TY/Ab40VvJ5LcgK8DylhvPwBvGxc7PERI+2t+Lu2Kan27Z/yiFgNPBSx2jVelCjTIRJB8lNxagcU+n6AZm26YMRRs/FgjN89f7apKacCcvXO2DcLx3Pz7yTqRlJVV+zsDD39NVWu7VYosxP2aR7CTwpLe7oCHCuOYnoyWF7SIC4yvEtxxBj5CZ+82v0g5NVqJ0XSc/3rFzbIyv8IO5ajNryUAK8RJiS+mctW0dIAEF6vsKaz2W7HPHZkny/1ZJJ2sMEUozON7pw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+AWN4VbVeDYXTF8TkQnLmA5J1BTwh4PHFtKej4W2VPo=;
 b=WTKvuXAKRpXUZG9tT3JDCO5Q8ZmtTXBATGj0B+PfUvoqRypKao2RocHHadvCuN4uxFYK0nlY324UlgJBg+qn29/bzoluD4grLyD1jpi2nASMbgHInBXYU2XOA52s144H7JoNyd+XCri2QOVAbBMsCjb65xr2Q1trkoRcdpiqY+Y=
Received: from DS0PR12MB6534.namprd12.prod.outlook.com (2603:10b6:8:c1::19) by
 SA1PR12MB6946.namprd12.prod.outlook.com (2603:10b6:806:24d::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8377.23; Mon, 27 Jan
 2025 14:06:18 +0000
Received: from DS0PR12MB6534.namprd12.prod.outlook.com
 ([fe80::ea87:74ba:36ec:8cf6]) by DS0PR12MB6534.namprd12.prod.outlook.com
 ([fe80::ea87:74ba:36ec:8cf6%5]) with mapi id 15.20.8377.009; Mon, 27 Jan 2025
 14:06:18 +0000
From: "Wheeler, Daniel" <Daniel.Wheeler@amd.com>
To: "Mohamed, Zaeem" <Zaeem.Mohamed@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
CC: "Wentland, Harry" <Harry.Wentland@amd.com>, "Li, Sun peng (Leo)"
 <Sunpeng.Li@amd.com>, "Siqueira, Rodrigo" <Rodrigo.Siqueira@amd.com>,
 "Pillai, Aurabindo" <Aurabindo.Pillai@amd.com>, "Li, Roman"
 <Roman.Li@amd.com>, "Lin, Wayne" <Wayne.Lin@amd.com>, "Chung, ChiaHsuan
 (Tom)" <ChiaHsuan.Chung@amd.com>, "Zuo, Jerry" <Jerry.Zuo@amd.com>, "Chiu,
 Solomon" <Solomon.Chiu@amd.com>
Subject: RE: [PATCH 00/14] DC Patches JANUARY 20, 2025
Thread-Topic: [PATCH 00/14] DC Patches JANUARY 20, 2025
Thread-Index: AQHbbDw/fm7bD1iR1Eu0LE1nXHdpsLMqsEyQ
Date: Mon, 27 Jan 2025 14:06:18 +0000
Message-ID: <DS0PR12MB6534DCC26F736861D7A854509CEC2@DS0PR12MB6534.namprd12.prod.outlook.com>
References: <20250121193919.3342348-1-zaeem.mohamed@amd.com>
In-Reply-To: <20250121193919.3342348-1-zaeem.mohamed@amd.com>
Accept-Language: en-CA, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_ActionId=c454b7ba-ce61-435b-973e-0854ab7e91f3;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_ContentBits=0;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Enabled=true;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Method=Privileged;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Name=Open Source;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_SetDate=2025-01-27T14:06:05Z;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS0PR12MB6534:EE_|SA1PR12MB6946:EE_
x-ms-office365-filtering-correlation-id: 0f851954-bc07-4ce4-c480-08dd3edbc534
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|1800799024|366016|376014|38070700018;
x-microsoft-antispam-message-info: =?iso-8859-1?Q?0Nyh8P1hVX25b7LLqdATENF3f1rKAuvpZcovUOsKOOJEHe596jYPUl16Nh?=
 =?iso-8859-1?Q?H9g2xo21g01ogP9A0idSSI60DkGm3MWlxszPEqcpUbVIswW/TgLvRszVyq?=
 =?iso-8859-1?Q?tbrBF/QNhdg3HISXMAxV2qrbouY8vm0XwT/eJYoUbsQt3/AfR8kOruoudx?=
 =?iso-8859-1?Q?ryXlQwA7a1cmJTwvIUNFVHQC2khqVIdnF+iwoDR51gGhzSre9nrrNpy69x?=
 =?iso-8859-1?Q?Rykov8tVhSTFHxxhUUMzFN8Uw40U91VmvGuzSm+P46q++rRwjFbwONnVSe?=
 =?iso-8859-1?Q?F10aERR3mnnYPWMiHWoj00d1CUJaJq9hgVE2K2btOlSDM+NbxnRAyRXVhL?=
 =?iso-8859-1?Q?Oz5rzIWfdU2RrzBE+7oJgUY8TJbDhYfOzS9RIVDjDgdXq9GsnHqJM4mMA3?=
 =?iso-8859-1?Q?kzTqeYslZs6jT40tkUKk/CUjw8RnsY8YMffMaX/8ECVZmSjWdXS4i53Ffa?=
 =?iso-8859-1?Q?f+SPBbKBlzWNk1VoNUkxj3HjmauLsU58TQjAimrkIJ78Bl2I4iomaR9wN5?=
 =?iso-8859-1?Q?NAt8kG5t9aIOIi2j0wgeW2cClvZgyjDUWn7aso6kuK9KS3xK+ODyJFgtwN?=
 =?iso-8859-1?Q?GXRjAghHVgR0NEaLw04pXR2PbtnPkChrez6vWsdMmAmmhnE7vXvWMt7zCQ?=
 =?iso-8859-1?Q?5IEnHQKK5V3fZQbr+oqlOdr7DwdPSzG1uFjdVOkeNpsBUE/ML1xsUsVMT2?=
 =?iso-8859-1?Q?Izdf1DTtLj7DPOxPsr8tReJL3C1aMuwO5Y2iBjE+vtYIFlMCoDeCBTUVbj?=
 =?iso-8859-1?Q?pflgh13TPWVmeiJegnioQphtGJa8r3lgIe9ZHYuHbXFiJygc/nXQGq41Q/?=
 =?iso-8859-1?Q?E9sAkzj5aNSS0rN/hZJtHEHgpiRYESfh5hIdrujCO3KmPXSSPUrP6kEqMN?=
 =?iso-8859-1?Q?Sc2uAXB8cjCgnfF9ert4fROD+8+LnbMA4EBwpmZV0RI1Auf82nvd1dafLO?=
 =?iso-8859-1?Q?NjVG1xTlyk0035LPO90v47Kyw8bbwjdpC5D2siz9H6wkm3IYqjU8VJmu3L?=
 =?iso-8859-1?Q?YSKayWOsDEpmYbcAH85PxK6BZ57TqKuU9xFxn2y1nITi9z5//k1w2eFx3Y?=
 =?iso-8859-1?Q?2Wa/atxQcJsmUox8+276A2K6NJnrOB/AMC5I15yVJDm60P7mB62UUU2w9p?=
 =?iso-8859-1?Q?KD6VnHtmGG5wig52NawdTXLACKMvNViLKxLn6g6nwX+Cor6SnL7uBC2euo?=
 =?iso-8859-1?Q?4qxUJiEdLgbsic9AxwNDyyvZVqS0vy9CZlPCA90z964kTA8lasjBlHWvg0?=
 =?iso-8859-1?Q?bzcCTMZjKdAfufJNN+fSzvwJeXcJliEYorZ6dgTGI7i6SPWpzrCCnd6l4e?=
 =?iso-8859-1?Q?pklYvDzATmCg1TIF0yTquHHGSivYa2noEuCsHF4JBvtk0ZE4RLcToNNBdI?=
 =?iso-8859-1?Q?yDtDI1kY0bDEc3m6GxI2RX+tLCvL5jDPv4JvE3Hok77AsSjdjjWfV/OFQE?=
 =?iso-8859-1?Q?U5+XED9Pgndu1mCrih9loqnWb071FWqvCWEsz28UgtUrM1xf70JR49dKYa?=
 =?iso-8859-1?Q?4=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR12MB6534.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(38070700018); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?X0c3ueCy6GzdkoT4Kgyy7ye2ulH0lY8ixo/WGiUAYgfwLSMtNnttKa9yTP?=
 =?iso-8859-1?Q?egNjtTcp6t5VixGO4jmxGTPdzIYERXUcsBG+UcNDiii0i+e6ZAZ2c4id+X?=
 =?iso-8859-1?Q?5IPDacYm0lqpmiyO1d7ZSCSr3sa/EKmVrj2UvmbC80Y0PdrWBPaxnlDM+0?=
 =?iso-8859-1?Q?NSSaR8TDP4FemdGaYogsZLrHCf16mCox3nUWJ7SBbLsLXVNj5oNU+UpwKI?=
 =?iso-8859-1?Q?67hU6F0XwnrUC6v+8pVCIs0CqPYoJi7CBurCF5MNUgGjQ9reT0G6Badmck?=
 =?iso-8859-1?Q?mWDdbOPZrIcM0DMEo9v/D3ouG6oWQeh+K/3jQ6PUpKFICtV3bBBf6gYYM5?=
 =?iso-8859-1?Q?YvRsPjtnbrwYHCqL/v7SCjKHnJTE6TCmHuHzJIP09JBSGPW6lXDwlCokRX?=
 =?iso-8859-1?Q?m8QUXgDiPXS5Zf6rkWzHA9/IqGHlGB/gsoDxsUy7rzvGzcTuWEAnaOa3vJ?=
 =?iso-8859-1?Q?u5++PAITsuB+m7kuoLIOJDAvx1cKvLFEnqgjRKg8dM+bxpmBnKkOwsx6xD?=
 =?iso-8859-1?Q?SPPsymVvVTEBEHZOe8D4MqO1R5L5dDW2fz2cnjHQ5aCU3xV0k/pKZL25vo?=
 =?iso-8859-1?Q?MJEVorHwRHqTD7M6zqJlvJ0ukbs2xTjMIu9RuWIkZZTG41ml6m2nXmLr1k?=
 =?iso-8859-1?Q?0YljZYHCfUGOrkP+aCjh8kgRCcDdpbkMXDS/DERpVftqrnX1qdErMnmdol?=
 =?iso-8859-1?Q?O7WU6Pw7bwGdETVDuYo+MgvP3lv+Gf6nzLVr3wo/jASdQQudI78gqq1EYb?=
 =?iso-8859-1?Q?oh8GS7Wikdrp5fOb+nYxPUwxRiBWpvjNk4+4/sb4phsJvPc5Qynx1Fgsni?=
 =?iso-8859-1?Q?iyasuTiqPbOHICaDZQ05v0guXrhbKVGbNvtJr6qVHaQfm1f2UWwy7BgGcc?=
 =?iso-8859-1?Q?gkQgqCIub3Gd0bx2v/FTgeHgxuJzIXe+JHao0ob+h6cu/yyhG5m8SYsRIm?=
 =?iso-8859-1?Q?Tora5WGD8Q/Pf/2zf2V0Er1Gp1cFBxekq1Sfcg84NZzDSPylE/8ihsJU8z?=
 =?iso-8859-1?Q?TKcGfwlTuElQpycFgOC4zPTKz3O7I0itDfWmINhOOmInFdube4jxRwep7N?=
 =?iso-8859-1?Q?QyhePPSvdF9bLoDRy5ju9wxmAaKN6PaNTedT3z0yrti+ElPfdcPRNpQpc6?=
 =?iso-8859-1?Q?Y/9gs4EkryrTCKP7Wt6p/kCAdxjU2558SRb+p6gw4ZAcnT3HuMS646YTZI?=
 =?iso-8859-1?Q?3wgHQDvpXTLbjfqsrILMWis6wAAjlile5GvQEKUQaz+hAAl6y01yHvJVOs?=
 =?iso-8859-1?Q?WwTm0AjjaTI9+XguKy6HNaWTlalgJ7WfQD/glCdqrIp2aasBG8CD9lNUeV?=
 =?iso-8859-1?Q?kKHIPuOA6btRr+7Qi4HSME61V/4y04XTBom/G5boG9S1x8wMkMO9e243lz?=
 =?iso-8859-1?Q?8sja7EI7L6qCpbkPiFojkV+O3b7v+oF04zK0oLvymBhO8l3pLtPzQY5/xb?=
 =?iso-8859-1?Q?JJS1bEvARqShNjoD3037dfPGEQlB+Yx3IaDWTN/3ccRzC9xGj/qCFHuXrN?=
 =?iso-8859-1?Q?vuk0uj6KaHXJ3Mo+znLhMFehtzQN+5lAJNATetf83QjNwpDaFF67rQnE+a?=
 =?iso-8859-1?Q?rvYbIP54qicvES2EgnofHeMGXy/XuVLCyPp1wIL8xBR/do9tdgZaj3WV1c?=
 =?iso-8859-1?Q?Rf4WSfI+M4/zA=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB6534.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0f851954-bc07-4ce4-c480-08dd3edbc534
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Jan 2025 14:06:18.3150 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: fhwswoCGGS80IY+yaSeRPCMBNk7ZG+4Mu1W7r+hDFuNPQHRtSSEchNLLgLft1w/rPPq2PFJQ9Ma1fQo6V+4msg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB6946
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

The patchset consists of the amd-staging-drm-next branch (Head commit - b00=
449dc8724d2c6f924f1954bdab911afdfce02 drm/amd/pm: Update metrics tbl struct=
 for smu_v_13.0.6) with new patches added on top of it.

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
From: Mohamed, Zaeem <Zaeem.Mohamed@amd.com>
Sent: Tuesday, January 21, 2025 2:39 PM
To: amd-gfx@lists.freedesktop.org
Cc: Wentland, Harry <Harry.Wentland@amd.com>; Li, Sun peng (Leo) <Sunpeng.L=
i@amd.com>; Siqueira, Rodrigo <Rodrigo.Siqueira@amd.com>; Pillai, Aurabindo=
 <Aurabindo.Pillai@amd.com>; Li, Roman <Roman.Li@amd.com>; Lin, Wayne <Wayn=
e.Lin@amd.com>; Chung, ChiaHsuan (Tom) <ChiaHsuan.Chung@amd.com>; Zuo, Jerr=
y <Jerry.Zuo@amd.com>; Mohamed, Zaeem <Zaeem.Mohamed@amd.com>; Chiu, Solomo=
n <Solomon.Chiu@amd.com>; Wheeler, Daniel <Daniel.Wheeler@amd.com>
Subject: [PATCH 00/14] DC Patches JANUARY 20, 2025

This DC patchset brings improvements in multiple areas. In summary, we have=
:

- Fixes on psr_version, dcn35 register address, DCPG OP control sequences
- Imporvements to CR AUX RD interval interpretation, dio link encoder
- Disable PSR-SU on some OLED panels


Cc: Daniel Wheeler <daniel.wheeler@amd.com>

Alex Hung (1):
  drm/amd/display: Fix possible NULL dereferencing

Aric Cyr (1):
  drm/amd/display: 3.2.318

Austin Zheng (1):
  drm/amd/display: Account For OTO Prefetch Bandwidth When Calculating
    Urgent Bandwidth

Charlene Liu (1):
  drm/amd/display: pass calculated dram_speed_mts to dml2

Dillon Varone (1):
  drm/amd/display: Ammend DCPG IP control sequences to align with HW
    guidance

George Shen (1):
  drm/amd/display: Update CR AUX RD interval interpretation

Hansen Dsouza (1):
  drm/amd/display: Add boot option to reduce PHY SSC for HBR3

Peichen Huang (1):
  drm/amd/display: refactor dio link encoder assigning

Sung Lee (1):
  drm/amd/display: Guard Possible Null Pointer Dereference

Tom Chung (2):
  drm/amd/display: Initial psr_version with correct setting
  drm/amd/display: Disable PSR-SU on some OLED panel

Wayne Lin (1):
  drm/amd/display: Fix potential NULL dereference

Zhikai Zhai (1):
  drm/amd/display: Update Cursor request mode to the beginning prefetch
    always

loanchen (1):
  drm/amd/display: Correct register address in dcn35

 .../drm/amd/display/amdgpu_dm/amdgpu_dm_psr.c |  20 ++
 .../drm/amd/display/dc/bios/bios_parser2.c    |   4 +-
 .../display/dc/clk_mgr/dcn35/dcn35_clk_mgr.c  |   2 +-
 drivers/gpu/drm/amd/display/dc/core/dc.c      |  11 +-
 .../gpu/drm/amd/display/dc/core/dc_resource.c | 202 +++++++++++++++++-
 drivers/gpu/drm/amd/display/dc/dc.h           |   4 +-
 .../drm/amd/display/dc/dml/dcn35/dcn35_fpu.c  |   2 +
 .../amd/display/dc/dml/dcn351/dcn351_fpu.c    |   1 +
 .../src/dml2_core/dml2_core_dcn4_calcs.c      |  25 ++-
 .../src/dml2_core/dml2_core_shared_types.h    |   5 +
 .../display/dc/dml2/dml2_translation_helper.c |   9 +-
 .../drm/amd/display/dc/dml2/dml2_wrapper.h    |   1 +
 .../amd/display/dc/hubp/dcn31/dcn31_hubp.c    |   2 +-
 .../amd/display/dc/hwss/dcn10/dcn10_hwseq.c   |  22 +-
 .../amd/display/dc/hwss/dcn20/dcn20_hwseq.c   |  14 +-
 .../amd/display/dc/hwss/dcn401/dcn401_hwseq.c |  34 +++
 .../amd/display/dc/hwss/dcn401/dcn401_hwseq.h |   3 +
 .../amd/display/dc/hwss/dcn401/dcn401_init.c  |   2 +-
 .../gpu/drm/amd/display/dc/inc/core_types.h   |   3 +
 .../link/protocols/link_dp_training_8b_10b.c  |   7 +-
 .../gpu/drm/amd/display/dmub/src/dmub_dcn31.c |   1 +
 21 files changed, 339 insertions(+), 35 deletions(-)

--
2.34.1

