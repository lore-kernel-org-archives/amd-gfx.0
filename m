Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B9456C88E64
	for <amd-gfx@archiver.kernel.org>; Mon, 14 Sep 2026 13:02:41 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0C9FB10E0DE;
	Mon, 14 Sep 2026 13:02:41 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="PgIRCNtF";
	dkim-atps=neutral
Received: from SJ2PR03CU001.outbound.protection.outlook.com
 (mail-westusazon11012014.outbound.protection.outlook.com [52.101.43.14])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 80D7D10E0DE
 for <amd-gfx@lists.freedesktop.org>; Mon, 14 Sep 2026 13:02:39 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZE4ou2eb5EHg9pyrw8Ba9EXg9NvPndrh7V9Hfq7IKxjANzRoQzKIiR6cGn124vu3qEWBw34a4mI/kfcJl4vCq/Bm80Vs5EgDrcyddyj69urtlqBUM3HZuJUoLjEdvWvccXJHF1GoXuTSSkE+4lavgxvDJtC/ltwJJCQAPzlDqjyMUOmepG43p64jNy89edyxWjGhgjDqaWRsT8ZUVZBSQVPheJ5018wpOl29B+dBK2cFATwouzVs/dlJlwcgf715VcjgLqL3wABfP3LmUOJ4b/YSQJHTXPUV77zMoIN25My5A1ASuEEgnJ/UHoG1gHHw7nOjUeXk8LznmZg3U61ciA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3cuEW7yVrZ4yBMPOyVCtSz1o+s8ODpDzMDuJ0vYqlgw=;
 b=TSffFZ3sBUCDPdy+OgwuBIHZupNDhizb/3UPAjY7Wr0bgq/A9BQYDx7fL7tKHIH6xbl/burDLL3wZGndyDn+T2aIVB0VrAkbhqXw2lXhG0BSG9BGAJ+c79A4/iW+/tNkTSRJyoImntNW8PqK0VjiO75dCY7ZMdvm3qFdqrlM/bFfdHwiyggsyXCmWEWcrOlcgu10NKzsKfelzk01OJnnI3VmgA7GZ6apMHxhlET6DJKTukwxsNdxjYHJX92ICDgGgeqN/zBHnwYhMWh3a7ax0dk5+YrWMTmEFsTMf9WzzoCbyF3iAL0rTLZh7pyiUZbT6wBAW9nruFnv9ZnbqbocFA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3cuEW7yVrZ4yBMPOyVCtSz1o+s8ODpDzMDuJ0vYqlgw=;
 b=PgIRCNtFPU6No46nC2iIuKb/5U28+Riun2IllKqtEMIJ4W7DK480T5adbmJkITXP7u1EdH3LeMQNMJq3IF6my8GAONaiYvesS93naB250JJXj1d+x7AJhWItUX3KhXllsBSa+XvLhnOXK4PhU9nJyD8GPHP6t/Ji6YxzoKlVp4A=
Received: from DS0PR12MB6534.namprd12.prod.outlook.com (2603:10b6:8:c1::19) by
 BN7PPF683A477A9.namprd12.prod.outlook.com (2603:10b6:40f:fc02::6d3)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.12; Mon, 14 Sep
 2026 13:02:35 +0000
Received: from DS0PR12MB6534.namprd12.prod.outlook.com
 ([fe80::b2e1:64e5:3b9e:738a]) by DS0PR12MB6534.namprd12.prod.outlook.com
 ([fe80::b2e1:64e5:3b9e:738a%4]) with mapi id 15.21.0406.007; Mon, 14 Sep 2026
 13:02:34 +0000
From: "Wheeler, Daniel" <Daniel.Wheeler@amd.com>
To: "Chen, Chen-Yu" <Chen-Yu.Chen@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
CC: "Wentland, Harry" <Harry.Wentland@amd.com>, "Li, Sun peng (Leo)"
 <Sunpeng.Li@amd.com>, "Pillai, Aurabindo" <Aurabindo.Pillai@amd.com>, "Li,
 Roman" <Roman.Li@amd.com>, "Lin, Wayne" <Wayne.Lin@amd.com>, "Chung,
 ChiaHsuan (Tom)" <ChiaHsuan.Chung@amd.com>, "Zuo, Jerry" <Jerry.Zuo@amd.com>, 
 "Wu, Ray" <Ray.Wu@amd.com>, "LIPSKI, IVAN" <IVAN.LIPSKI@amd.com>, "Hung,
 Alex" <Alex.Hung@amd.com>, "Lin, Ping Lei" <PingLei.Lin@amd.com>, "Chen,
 Chen-Yu" <Chen-Yu.Chen@amd.com>, "Chen, Chen-Yu" <Chen-Yu.Chen@amd.com>
Subject: RE: [PATCH 00/66] DC Patches Sep 14 2026
Thread-Topic: [PATCH 00/66] DC Patches Sep 14 2026
Thread-Index: AQHdP4XtHwmwY8K3VUCuQw0Ibu0oF7bOE1tw
Date: Mon, 14 Sep 2026 13:02:34 +0000
Message-ID: <DS0PR12MB6534A15D702EE87054A12A6B9CBB2@DS0PR12MB6534.namprd12.prod.outlook.com>
References: <20260908113338.2433445-1-chen-yu.chen@amd.com>
In-Reply-To: <20260908113338.2433445-1-chen-yu.chen@amd.com>
Accept-Language: en-CA, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_2d0b1989-8fc8-4a69-bcac-d46889461ba5_Enabled=True;
 MSIP_Label_2d0b1989-8fc8-4a69-bcac-d46889461ba5_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_2d0b1989-8fc8-4a69-bcac-d46889461ba5_SetDate=2026-09-14T13:02:26.0000000Z;
 MSIP_Label_2d0b1989-8fc8-4a69-bcac-d46889461ba5_Name=AMD Public
 v26; MSIP_Label_2d0b1989-8fc8-4a69-bcac-d46889461ba5_ContentBits=3;
 MSIP_Label_2d0b1989-8fc8-4a69-bcac-d46889461ba5_Method=Privileged
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS0PR12MB6534:EE_|BN7PPF683A477A9:EE_
x-ms-office365-filtering-correlation-id: 5df85157-ff7e-4daf-60c3-08df126071d0
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|23010399003|1800799024|366016|38070700021|11063799006|56012099006|10067099003|22082099003|18002099003|6133799003|3023799007;
x-microsoft-antispam-message-info: yefmrdH6qtPRIkJHeSLv6vYDxAmnAe7fENTHegPRUv+J7xN9mW4uC9BQ4eNH87Lhgl8yNBc2Aeh3VklYxXiUOPcO0P5ExawI2HSFCWaJGrC9VK2kvsIcPW7Wa3taahjqAAca+NeK4Ev1m+xC6ankLxmpLa/2DXXGQyAMSWaVDOpiVnj5JyFOylF1WmkN8cptsc0j5aPaG2ORuyaBN2GekVnjVSK9mGqLSdyDZpbsvZ/Ur+j+yzE+whq0t68Rx37fvurpbIW8MtywqdRsFjpLHcQbc3/fbE9LDgEpnph4BJvcjJ9gte0uEwSABgWChdSaGJqCYjyD/xSrDTyHAWkuMu5FTigi3GIwgl9QvrDBxG/pJ8qz4ZCWrGPU2TMGMybMd2CtIxx9cFaiQQTl0SXQDz5DrrNDuYHzJzaMB25gJd+Dzeps5s6N5/kMqUm6T0Q2kxO7ncrE3yoP5nDtdYhLHwDfP+cK6+zRGExTmPY4pdwyrz8iTbx+5/PuR2g4zrZlIC0CWqLfzUp8awO8eH3/oN2PGRNPerjpTteXIlVfgOJGp4tVRT998RDddnq2gmJjELebbTiQ4efJIhOvk8KxsQQEDBPsnlwga+Srq7YnZ30N5R6b10B/ncsbULW1G2MfcvfUF51RecH6GpWebb5VPaEhhX2de1MJWBEkKzfrF7jaFKIYfa3XQBiyykqV4fgc8aR/XgC8GBtpBUmJk7zvPi8xVMHO/9m2pqr17M0dlFw=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR12MB6534.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(23010399003)(1800799024)(366016)(38070700021)(11063799006)(56012099006)(10067099003)(22082099003)(18002099003)(6133799003)(3023799007);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?jtiRzODvJ9kQpCDXjoCNiW63aA1yA+X82nmtRBxQXiN30nREYp0c+wwG4B?=
 =?iso-8859-1?Q?2i0eAfrd+cSyM3AJLilNDNZwF0yw6Rm3/4VCQVKZlZBcuTt+QMIatrNHYp?=
 =?iso-8859-1?Q?Wwn+lbY5MQv/EyYXWpxy5D9OeyS2WCtnq040CIwPaydLUujC+F1emAiGA0?=
 =?iso-8859-1?Q?j7f6J4U4Mz0CX4FwYdZpFnseA04ReapQ3LIE4PvV6eagc0YKdZgeVOWMyS?=
 =?iso-8859-1?Q?kcBgmCu2usQ7khI+WkooIyXZ1jQTAkuVXvfvnxrsG100thSeBO9Tqo7Z7e?=
 =?iso-8859-1?Q?/p/zP/HMgQ94dDD9EuwhQ95YpZTbcE95NsQRWnchKgbWx7MsXYJ1V2vJuj?=
 =?iso-8859-1?Q?JBvg6pKWTId2ZoTk77juMKpDiK2VL0jcDzlh0Cv27UinBmE5CIcNlcRzoD?=
 =?iso-8859-1?Q?4kdT/SusNGYR9wo5zSHAEKypkH/QZZ2YJUY/8lX5L2kbVLiq65NFy8w5qD?=
 =?iso-8859-1?Q?ZL/+tADePGN1fE8MqBoGe57OLGsFdjdoxw2RT65YTg68waoONGZ5gVLj8J?=
 =?iso-8859-1?Q?5Yruh05skQ5/+LKz7Nr+C0Fmz60WbNLMaHrca09ogXucaixMeEJQeYbY6M?=
 =?iso-8859-1?Q?W7MEXm3TYQnUyMZd9Kfl4vJacAIF29VNuNYEZkVTNH22RQGvR01o5H4x0U?=
 =?iso-8859-1?Q?zXdQo223zdDgy32r1RpADTqQ9Mz+N7BEdSPTwVP3lWKYQvmonUmhF6A7ZG?=
 =?iso-8859-1?Q?UUFT8KbbzLMPY4kU0+qUla/OoIQmerUqrso/9fr7nn+d+ypD4o/+WDxkwg?=
 =?iso-8859-1?Q?5jkoKAP0VPNIOVXkHhqNHdNX+7jYjfLhiqenZDbG/qixS/TazVhS6e38dV?=
 =?iso-8859-1?Q?Gngb9rKVyK/NuUpPubMk8J6AgvE5yMbSKxPSU88P3aivD0cb3hLb5OM53A?=
 =?iso-8859-1?Q?MzkySMpCjRI0KE3a13NOXBHhi+MKcPS/7jAYik1mhc9dv7z/qUFR/iuQ+C?=
 =?iso-8859-1?Q?ZyqAJtZt6bFkOfRQx/6vP4G00h4z0WcF4g34w7KSxfEtugFaE9dEggLruz?=
 =?iso-8859-1?Q?NTB2lCMBLVGBp3xRP6AQ3adElhBUnrBtl0AyAZnN2Mjvz4flO2nMp4tnrd?=
 =?iso-8859-1?Q?P4RyYh6InjQeOzZIBSzvLbh49acxaVVKxfmzeGdB6p/B2GdeheW/2q+Cvo?=
 =?iso-8859-1?Q?BFrDkpsSWpnbxO2SOd9UBrtHy0h1uRgupi7c9+p+reZN6IU3LWeCdntGR+?=
 =?iso-8859-1?Q?qDHkDws9oysbpnocOQ4nsMPjph1mvyW9jJq5VyOgt1bNxYxSJax/tCGYts?=
 =?iso-8859-1?Q?7dkkIrW+qwa5p6TEvF4TfpdEu7GPdOzMp/52uo7U2H7w1EXTQqR21q83RR?=
 =?iso-8859-1?Q?uF8CUJUEjtvTT1bZ1DJSgdDSuFodY9S1lsQYtr6ZqCSqkQaEx+l+0zR6C2?=
 =?iso-8859-1?Q?Pq1XsxPG8bnpCmn9AjiMYALaMEM8JT+foxqJq8/cEgC7YTzAoErQny6ZD3?=
 =?iso-8859-1?Q?3SdZdGFGAKkGpSQVr5HO9ujUluHWPvBul2ZS/w8MaLIoNbMB2dOCcoJ4/Y?=
 =?iso-8859-1?Q?6Zi56dJ2fLEouDH7crl5j/4WkNwpZ2QB+QMBtS5T2FfJVZuE5/wdkWNCQW?=
 =?iso-8859-1?Q?bDyDOTiLxzurGNfQ5s9RcfHCBDujkOJ8b1vdk5nGDNV2RiTlaAsJju/txy?=
 =?iso-8859-1?Q?ynXfqCqU2Q+ILy8Kt4eBVuW6tYrRgihEnT2sT9q3C9eJs/ZagveWMZsbu2?=
 =?iso-8859-1?Q?xDhy89g9kgFbPfJNRDn7bJqc+OTtZwouDn1Qxrfg6J4uyo1wlF1AUAlHLh?=
 =?iso-8859-1?Q?fxfGW6uGnMy6TVuJoaFWW2ee781aiIFNvftIbsIoBKf189?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB6534.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5df85157-ff7e-4daf-60c3-08df126071d0
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Sep 2026 13:02:34.5402 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: sYz8jdrRToRV+O7Np244uQkyXYE7SO0+JNd8G/j6E8yRMxdZVPCXhi/p28ULLMop6YyHuTJ/Nyz3aaTkjDluoQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN7PPF683A477A9
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


The patchset consists of the amd-staging-drm-next branch (Head commit -> 29=
393ab0e49fe052ee7292481733c3d0ce7151e2 -> drm/amd/display: Promote DC to 3.=
2.397) with new patches added on top of it.

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
From: Chenyu Chen <chen-yu.chen@amd.com>
Sent: Tuesday, September 8, 2026 7:31 AM
To: amd-gfx@lists.freedesktop.org
Cc: Wentland, Harry <Harry.Wentland@amd.com>; Li, Sun peng (Leo) <Sunpeng.L=
i@amd.com>; Pillai, Aurabindo <Aurabindo.Pillai@amd.com>; Li, Roman <Roman.=
Li@amd.com>; Lin, Wayne <Wayne.Lin@amd.com>; Chung, ChiaHsuan (Tom) <ChiaHs=
uan.Chung@amd.com>; Zuo, Jerry <Jerry.Zuo@amd.com>; Wheeler, Daniel <Daniel=
.Wheeler@amd.com>; Wu, Ray <Ray.Wu@amd.com>; LIPSKI, IVAN <IVAN.LIPSKI@amd.=
com>; Hung, Alex <Alex.Hung@amd.com>; Lin, Ping Lei <PingLei.Lin@amd.com>; =
Chen, Chen-Yu <Chen-Yu.Chen@amd.com>; Chen, Chen-Yu <Chen-Yu.Chen@amd.com>
Subject: [PATCH 00/66] DC Patches Sep 14 2026

This DC patchset brings improvements in multiple areas. In summary, we high=
light:

 - Expand amdgpu_dm KUnit coverage across connector init, sink stream
   creation, FreeSync caps, forced atomic commit, plane modifiers, cursor
   updates, panic flush, MST connector creation, AUX transfers, link
   bandwidth readback and MST DSC configuration.
 - Refactor RMCM into a separate module.
 - Decouple cursor offload hwss executors from pipe context.
 - Decouple HUBP_UPDATE_PLANE_ADDR from pipe_ctx.
 - Rename lock_and_validation_needed to needs_dc_state_realloc.
 - Drop the dead update_type param from update_planes_and_stream_adapter.
 - Attach only plane updates and stream updates that actually changed.
 - Unify fast update classification paths.
 - Request DMUB HW cursor offload.
 - Program DCC as part of address update.
 - Update LLS and UPSP programming paths.
 - Add lock-free memory pool.
 - Add instance field to struct mpc and struct dccg.
 - Cleanup DMUB command submission interfaces.
 - Add inbox0 HW lock helpers for DCN35.
 - Atomize IRQ register read/modify/write ops.
 - Add Replay cumulative residency query.
 - Add urgent assertion counter probe.
 - Add debug option to force optional UCLK support.
 - Force DSC to 8bpp for SST and MST DP tunneling over USB4.
 - Honor forced RGB pixel encoding.
 - Add option for certain panels to disable FEC.
 - Cap DML2.1 vmin ODM combine at 2:1 for eDP.
 - Add is_odm_enabled callback to skip init_odm on active ODM pipes.
 - Remove MALL capabilities from DCN42B.
 - Skip MALL calculations when there is no MALL.
 - Enable power gating on dcn42b.
 - Remove SDPIF_PORT_CONTROL programming for DCN31/35/42.
 - Enable back alt-ch.
 - Flush ISM work before releasing the stream.
 - Fix HDMI FRL audio enable.
 - Fix peak bandwidth measurement sequence.
 - Bound the DSC power gating loop by num_dsc.
 - Cast DP DTO pixel clock math to avoid overflow and narrowing.
 - Use unsigned types for FRL cap check params and HPO read_state.
 - Return success status from check_mode_supported.
 - Add SPDX license identifier to dcn30_dpp_cm.c.

Cc: Daniel Wheeler <daniel.wheeler@amd.com>

Alex Hung (25):
  drm/amd/display: Test sink stream creation
  drm/amd/display: Test connector init helper
  drm/amd/display: Test HDMI connector init
  drm/amd/display: Test FreeSync caps update
  drm/amd/display: Test connector init
  drm/amd/display: Test forced atomic commit
  drm/amd/display: Test DCC reject for multi-plane format
  drm/amd/display: Test modifier list growth failure
  drm/amd/display: Test pre-GFX9 plane buffer attributes
  drm/amd/display: Test accepted plane atomic check
  drm/amd/display: Test cursor update without DC stream
  drm/amd/display: Test panic flush DCC teardown
  drm/amd/display: Test optional plane property creation
  drm/amd/display: Build MST DSC helpers for KUnit
  drm/amd/display: Test oversized AUX transfer
  drm/amd/display: Test MST connector creation
  drm/amd/display: Test link bandwidth readback
  drm/amd/display: Test cascaded Panamera check
  drm/amd/display: Test DSC caps validation
  drm/amd/display: Test MST port mode support
  drm/amd/display: Test FRL bandwidth lookup
  drm/amd/display: Test DSC precompute helpers
  drm/amd/display: Test DSC recompute check
  drm/amd/display: Test DSC config computation
  drm/amd/display: Test per-link DSC configs

Alvin Lee (5):
  drm/amd/display: Update LLS and UPSP programming paths
  drm/amd/display: Add debug option to force optional UCLK support
  drm/amd/display: Enable back alt-ch
  drm/amd/display: Program DCC as part of address update
  drm/amd/display: Return success status from check_mode_supported

Chenyu Chen (1):
  drm/amd/display: Use unsigned types for FRL cap check params and HPO
    read_state

Dillon Varone (1):
  drm/amd/display: Cleanup DMUB command submission interfaces

Dominik Kaszewski (1):
  drm/amd/display: Add lock-free memory pool

Fangzhi Zuo (2):
  drm/amd/display: Force DSC to 8bpp for MST DP tunneling over USB4
  drm/amd/display: Force DSC to 8bpp for SST DP tunneling over USB4

Gabe Teeger (4):
  drm/amd/display: Enable power gating on dcn42b
  drm/amd/display: Bound DSC power gating loop by num_dsc
  drm/amd/display: Remove MALL capabilities from DCN42B
  drm/amd/display: Remove MALL capabilities from DCN42B bounding box

Ilya Bakoulin (1):
  drm/amd/display: Fix HDMI FRL audio enable

Ivan Lipski (1):
  drm/amd/display: Honor forced RGB pixel encoding

James Lin (6):
  drm/amd/display: Rename lock_and_validation_needed to
    needs_dc_state_realloc
  drm/amd/display: Attach only plane updates that actually changed
  drm/amd/display: Request DMUB HW cursor offload
  drm/amd/display: Send stream_update to DC only when it changed
  drm/amd/display: Drop dead update_type param from
    update_planes_and_stream_adapter
  drm/amd/display: Cast DP DTO pixel clock math to avoid overflow and
    narrowing

Leo Chen (1):
  drm/amd/display: Cap DML2.1 vmin ODM combine at 2:1 for eDP

Leo Li (1):
  drm/amd/display: Atomize IRQ register read/modify/write ops

Ovidiu Bunea (2):
  drm/amd/display: Remove SDPIF_PORT_CONTROL programming for DCN31/35/42
  drm/amd/display: Add condition to skip MALL calculations if there is
    no MALL

Rafal Ostrowski (2):
  drm/amd/display: Refactor RMCM into a separate module
  drm/amd/display: Unify fast update classification paths

Ray Wu (1):
  drm/amd/display: Flush ISM work before releasing the stream

Taimur Hassan (1):
  drm/amd/display: Promote DC to 3.2.398

Tom Chung (1):
  drm/amd/display: Add inbox0 HW lock helpers for DCN35

Tomasz Siemek (2):
  drm/amd/display: Decouple cursor offload hwss executors from pipe
    context
  drm/amd/display: Decouple HUBP_UPDATE_PLANE_ADDR from pipe_ctx

Tony Cheng (3):
  drm/amd/display: Add instance field to struct mpc
  drm/amd/display: Add instance field to struct dccg
  drm/amd/display: Add SPDX license identifier to dcn30_dpp_cm.c

Wang, Sung-huai (1):
  drm/amd/display: Add is_odm_enabled callback to skip init_odm on
    active ODM pipes

Wei-Guang Li (1):
  drm/amd/display: Add Replay cumulative residency query

Wenjing Liu (2):
  drm/amd/display: Add urgent assertion counter probe
  drm/amd/display: Fix peak bandwidth measurement sequence

Yi-Ling Chen (1):
  drm/amd/display: Add option for certain panels to disable FEC

 drivers/gpu/drm/amd/display/Makefile          |    1 +
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c |  113 +-
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h |   27 +-
 .../display/amdgpu_dm/amdgpu_dm_connector.c   |   19 +-
 .../display/amdgpu_dm/amdgpu_dm_connector.h   |    1 +
 .../amd/display/amdgpu_dm/amdgpu_dm_crtc.c    |    9 +-
 .../amd/display/amdgpu_dm/amdgpu_dm_helpers.c |    3 +-
 .../drm/amd/display/amdgpu_dm/amdgpu_dm_irq.c |   64 +-
 .../drm/amd/display/amdgpu_dm/amdgpu_dm_irq.h |   28 +
 .../drm/amd/display/amdgpu_dm/amdgpu_dm_ism.c |   21 +-
 .../drm/amd/display/amdgpu_dm/amdgpu_dm_ism.h |    2 +-
 .../display/amdgpu_dm/amdgpu_dm_mst_types.c   |   61 +-
 .../display/amdgpu_dm/amdgpu_dm_mst_types.h   |   19 +
 .../amd/display/amdgpu_dm/amdgpu_dm_plane.c   |   33 +
 .../tests/amdgpu_dm_connector_test.c          | 1345 +++++++++++
 .../amdgpu_dm/tests/amdgpu_dm_crtc_test.c     |   16 +-
 .../amdgpu_dm/tests/amdgpu_dm_helpers_test.c  |    8 +-
 .../amdgpu_dm/tests/amdgpu_dm_irq_test.c      |   34 +-
 .../amdgpu_dm/tests/amdgpu_dm_ism_test.c      |   83 +-
 .../tests/amdgpu_dm_mst_types_test.c          | 2041 ++++++++++++++++-
 .../amdgpu_dm/tests/amdgpu_dm_plane_test.c    |  357 ++-
 .../display/amdgpu_dm/tests/amdgpu_dm_test.c  |    4 +-
 drivers/gpu/drm/amd/display/dc/Makefile       |    3 +-
 drivers/gpu/drm/amd/display/dc/core/dc.c      |  254 +-
 .../drm/amd/display/dc/core/dc_hw_sequencer.c |  246 +-  .../gpu/drm/amd/d=
isplay/dc/core/dc_resource.c |  147 +-
 .../gpu/drm/amd/display/dc/core/dc_state.c    |    2 -
 .../gpu/drm/amd/display/dc/core/dc_stream.c   |  124 +-
 drivers/gpu/drm/amd/display/dc/dc.h           |   48 +-
 drivers/gpu/drm/amd/display/dc/dc_dmub_srv.c  |   50 +-
 drivers/gpu/drm/amd/display/dc/dc_dmub_srv.h  |   12 +-
 .../gpu/drm/amd/display/dc/dc_memory_pool.c   |  277 +++
 .../gpu/drm/amd/display/dc/dc_memory_pool.h   |  107 +
 drivers/gpu/drm/amd/display/dc/dc_stream.h    |   14 +-
 .../amd/display/dc/dccg/dcn20/dcn20_dccg.c    |    1 +
 .../amd/display/dc/dccg/dcn201/dcn201_dccg.c  |    1 +
 .../amd/display/dc/dccg/dcn21/dcn21_dccg.c    |    1 +
 .../amd/display/dc/dccg/dcn30/dcn30_dccg.c    |    2 +
 .../amd/display/dc/dccg/dcn301/dcn301_dccg.c  |    1 +
 .../amd/display/dc/dccg/dcn31/dcn31_dccg.c    |    1 +
 .../amd/display/dc/dccg/dcn314/dcn314_dccg.c  |    1 +
 .../amd/display/dc/dccg/dcn32/dcn32_dccg.c    |    1 +
 .../amd/display/dc/dccg/dcn35/dcn35_dccg.c    |    1 +
 .../amd/display/dc/dccg/dcn401/dcn401_dccg.c  |    1 +
 .../amd/display/dc/dccg/dcn42/dcn42_dccg.c    |    1 +
 .../amd/display/dc/dccg/dcn60/dcn60_dccg.c    |    1 +
 .../drm/amd/display/dc/dce/dce_clock_source.c |    6 +-
 .../gpu/drm/amd/display/dc/dce/dmub_replay.c  |   25 +
 .../gpu/drm/amd/display/dc/dce/dmub_replay.h  |    2 +
 .../dml21/inc/bounding_boxes/dcn42b_soc_bb.h  |    2 +-
 .../src/dml2_core/dml2_core_dcn4_calcs.c      |    4 +
 .../dml21/src/dml2_pmo/dml2_pmo_dcn4_fams2.c  |   11 +-
 .../dml2_0/dml21/src/dml2_top/dml2_top_utm.c  |    2 +-
 .../dml21_wrapper/dml21_translation_helper.c  |    1 +
 .../amd/display/dc/dpp/dcn30/dcn30_dpp_cm.c   |    2 +
 .../drm/amd/display/dc/dpp/dcn50/dcn50_dpp.c  |   20 +-
 .../drm/amd/display/dc/dpp/dcn50/dcn50_dpp.h  |    3 +-
 .../hpo/dcn30/dcn30_hpo_frl_stream_encoder.c  |    6 +-
 .../hpo/dcn42/dcn42_hpo_frl_stream_encoder.c  |    9 +-
 .../hpo/dcn60/dcn60_hpo_frl_stream_encoder.c  |    9 +-
 .../display/dc/hubbub/dcn31/dcn31_hubbub.c    |    5 -
 .../display/dc/hubbub/dcn35/dcn35_hubbub.c    |    7 +-
 .../display/dc/hubbub/dcn42/dcn42_hubbub.c    |   13 +-
 .../display/dc/hubbub/dcn60/dcn60_hubbub.c    |   44 +-
 .../amd/display/dc/hubp/dcn10/dcn10_hubp.c    |    4 +-
 .../amd/display/dc/hubp/dcn10/dcn10_hubp.h    |    3 +-
 .../amd/display/dc/hubp/dcn20/dcn20_hubp.c    |    5 +-
 .../amd/display/dc/hubp/dcn20/dcn20_hubp.h    |    3 +-
 .../amd/display/dc/hubp/dcn21/dcn21_hubp.c    |    5 +-
 .../amd/display/dc/hubp/dcn30/dcn30_hubp.c    |    5 +-
 .../amd/display/dc/hubp/dcn30/dcn30_hubp.h    |    3 +-
 .../amd/display/dc/hubp/dcn401/dcn401_hubp.c  |    9 +-
 .../amd/display/dc/hubp/dcn401/dcn401_hubp.h  |    3 +-
 .../amd/display/dc/hubp/dcn42/dcn42_hubp.c    |    6 +-
 .../amd/display/dc/hubp/dcn50/dcn50_hubp.c    |   28 +-
 .../amd/display/dc/hubp/dcn50/dcn50_hubp.h    |    3 +-
 .../amd/display/dc/hwss/dcn10/dcn10_hwseq.c   |  108 +-
 .../amd/display/dc/hwss/dcn10/dcn10_hwseq.h   |    2 +
 .../amd/display/dc/hwss/dcn10/dcn10_init.c    |    1 +
 .../amd/display/dc/hwss/dcn20/dcn20_hwseq.c   |   40 +-
 .../amd/display/dc/hwss/dcn20/dcn20_hwseq.h   |    2 +
 .../amd/display/dc/hwss/dcn20/dcn20_init.c    |    1 +
 .../amd/display/dc/hwss/dcn201/dcn201_hwseq.c |   27 +-
 .../amd/display/dc/hwss/dcn201/dcn201_hwseq.h |    2 +
 .../amd/display/dc/hwss/dcn201/dcn201_init.c  |    1 +
 .../amd/display/dc/hwss/dcn21/dcn21_init.c    |    1 +
 .../amd/display/dc/hwss/dcn30/dcn30_init.c    |    1 +
 .../amd/display/dc/hwss/dcn301/dcn301_init.c  |    1 +
 .../amd/display/dc/hwss/dcn31/dcn31_init.c    |    1 +
 .../amd/display/dc/hwss/dcn314/dcn314_init.c  |    1 +
 .../amd/display/dc/hwss/dcn32/dcn32_hwseq.c   |   43 +-
 .../amd/display/dc/hwss/dcn32/dcn32_init.c    |    1 +
 .../amd/display/dc/hwss/dcn35/dcn35_hwseq.c   |  117 +-
 .../amd/display/dc/hwss/dcn35/dcn35_hwseq.h   |   14 +-
 .../amd/display/dc/hwss/dcn35/dcn35_init.c    |    1 +
 .../amd/display/dc/hwss/dcn351/dcn351_init.c  |    1 +
 .../amd/display/dc/hwss/dcn401/dcn401_hwseq.c |   39 +-
 .../amd/display/dc/hwss/dcn401/dcn401_hwseq.h |    5 +-
 .../amd/display/dc/hwss/dcn401/dcn401_init.c  |    1 +
 .../amd/display/dc/hwss/dcn42/dcn42_hwseq.c   |  283 ++-
 .../amd/display/dc/hwss/dcn42/dcn42_hwseq.h   |   17 +-
 .../amd/display/dc/hwss/dcn42/dcn42_init.c    |    6 +-
 .../amd/display/dc/hwss/dcn50/dcn50_hwseq.c   |   10 +-
 .../amd/display/dc/hwss/dcn60/dcn60_hwseq.c   |  194 +-
 .../amd/display/dc/hwss/dcn60/dcn60_hwseq.h   |    5 +-
 .../amd/display/dc/hwss/dcn60/dcn60_init.c    |    8 +-
 .../drm/amd/display/dc/hwss/hw_sequencer.h    |   70 +-
 .../display/dc/hwss/hw_sequencer_private.h    |    4 +
 .../gpu/drm/amd/display/dc/inc/core_types.h   |    4 +-
 drivers/gpu/drm/amd/display/dc/inc/hw/dccg.h  |    1 +
 drivers/gpu/drm/amd/display/dc/inc/hw/dpp.h   |    3 +-
 drivers/gpu/drm/amd/display/dc/inc/hw/hubp.h  |    4 +-
 drivers/gpu/drm/amd/display/dc/inc/hw/mpc.h   |   65 +-
 drivers/gpu/drm/amd/display/dc/inc/hw/rmcm.h  |  140 ++
 .../amd/display/dc/inc/hw/timing_generator.h  |    1 +
 .../gpu/drm/amd/display/dc/inc/link_service.h |    2 +
 drivers/gpu/drm/amd/display/dc/inc/resource.h |   18 +-
 .../drm/amd/display/dc/link/link_factory.c    |    1 +
 .../link/protocols/link_edp_panel_control.c   |   22 +
 .../link/protocols/link_edp_panel_control.h   |    2 +
 .../drm/amd/display/dc/mpc/dcn10/dcn10_mpc.c  |    1 +
 .../drm/amd/display/dc/mpc/dcn20/dcn20_mpc.c  |    1 +
 .../drm/amd/display/dc/mpc/dcn30/dcn30_mpc.c  |    1 +
 .../drm/amd/display/dc/mpc/dcn32/dcn32_mpc.c  |    1 +
 .../amd/display/dc/mpc/dcn401/dcn401_mpc.c    |    1 +
 .../drm/amd/display/dc/mpc/dcn42/dcn42_mpc.c  |  680 +-----  .../drm/amd/d=
isplay/dc/mpc/dcn42/dcn42_mpc.h  |  714 +-----
 .../drm/amd/display/dc/mpc/dcn60/dcn60_mpc.c  |   41 +-
 .../drm/amd/display/dc/mpc/dcn60/dcn60_mpc.h  |  238 --
 .../amd/display/dc/optc/dcn31/dcn31_optc.c    |   10 +
 .../amd/display/dc/optc/dcn31/dcn31_optc.h    |    1 +
 .../amd/display/dc/optc/dcn314/dcn314_optc.c  |    1 +
 .../amd/display/dc/optc/dcn35/dcn35_optc.c    |    1 +
 .../amd/display/dc/optc/dcn42/dcn42_optc.c    |    1 +
 drivers/gpu/drm/amd/display/dc/os_types.h     |    1 +
 .../amd/display/dc/pg/dcn42/dcn42_pg_cntl.c   |    4 +
 .../dc/resource/dcn42/dcn42_resource.c        |   56 +-
 .../dc/resource/dcn42b/dcn42b_resource.c      |  123 +-
 .../dc/resource/dcn60/dcn60_resource.c        |   20 +-
 drivers/gpu/drm/amd/display/dc/rmcm/Makefile  |   44 +
 .../amd/display/dc/rmcm/dcn42/dcn42_rmcm.c    |  867 +++++++
 .../amd/display/dc/rmcm/dcn42/dcn42_rmcm.h    |  717 ++++++
 .../amd/display/dc/rmcm/dcn60/dcn60_rmcm.c    |  251 ++
 .../amd/display/dc/rmcm/dcn60/dcn60_rmcm.h    |   35 +
 drivers/gpu/drm/amd/display/dmub/dmub_srv.h   |    2 +-
 .../gpu/drm/amd/display/dmub/src/dmub_srv.c   |    7 +-
 .../drm/amd/display/modules/inc/mod_power.h   |    3 +
 .../amd/display/modules/power/power_replay.c  |   13 +
 148 files changed, 8132 insertions(+), 2808 deletions(-)  create mode 1006=
44 drivers/gpu/drm/amd/display/dc/dc_memory_pool.c
 create mode 100644 drivers/gpu/drm/amd/display/dc/dc_memory_pool.h
 create mode 100644 drivers/gpu/drm/amd/display/dc/inc/hw/rmcm.h
 create mode 100644 drivers/gpu/drm/amd/display/dc/rmcm/Makefile
 create mode 100644 drivers/gpu/drm/amd/display/dc/rmcm/dcn42/dcn42_rmcm.c
 create mode 100644 drivers/gpu/drm/amd/display/dc/rmcm/dcn42/dcn42_rmcm.h
 create mode 100644 drivers/gpu/drm/amd/display/dc/rmcm/dcn60/dcn60_rmcm.c
 create mode 100644 drivers/gpu/drm/amd/display/dc/rmcm/dcn60/dcn60_rmcm.h

--
2.43.0

