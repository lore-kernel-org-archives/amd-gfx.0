Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2CD8DC3ABDD
	for <amd-gfx@archiver.kernel.org>; Tue, 20 May 2025 13:22:28 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C59C910E0EA;
	Tue, 20 May 2025 13:22:27 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="yWf/DVq2";
	dkim-atps=neutral
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2069.outbound.protection.outlook.com [40.107.92.69])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4F2AC10E0D7
 for <amd-gfx@lists.freedesktop.org>; Tue, 20 May 2025 13:22:23 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=frw9W79Gl2d7AGRDfI2WIUsfG7pnWiZ2KLDsRwIqfKuyzBecga1RCe85dQHvH2QlCB6KVTcL8g1FM2whbUuE3etcKDeK62q2mEJ71w2/WKqGavkj97ID7+Mvp4bFIL4Q+3PKnoMTevvrcpo08XtIW9htSK/GRujSCHARn+hwFkmHo3ifTO7OyzDnn9BQkllQ898bXwZ4xDsWd4s9BJRe5ei6avKAExARwlfQ0Z8kL2bfOUqTv9uhXdrBltocir2p5Q1Ci0uGiRBvwdzLnmI6KtFgTH1j8XdD8s4HafPbB8/6sTD8jgXn1vOseQk2AT3aEOtLmrHeQgViPM+1KUhebA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=H44eA3n4uSsJUW5ARLKvJ3trmlxRNCclQ+X37eDy3RY=;
 b=sYiucprzvDP5CxsVUYrhFdwc9K4hXfmvFAfwF2uzJtFuF1HOcYy5UCQSvaZwXE0CgBnhRdfwQJ0BQ6Lg159eQBJ7XEnd60Nsbt/WGR/nstpoxe0LI3ek+473yLn4p3TNhw55PaDLu4ipxFOXr27/dc9nq+cSKsBwhYlDAuFDgdYpVLDK/yIVmigdqezxg5QYyahHiEXaQZ7jTjZ9HiNJ84WoLxNjdGGQax65mFpvbgHJc6hZdSELIQ3Qz2uxCKu4bWJS7bMG28XByBeS3B4RQz3O/FTux9PNIgGHEScVBswN4P7OIWQ0Fl0VxIcgxKIpTLeqhuwvFbt1hc0u8WmXAQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=H44eA3n4uSsJUW5ARLKvJ3trmlxRNCclQ+X37eDy3RY=;
 b=yWf/DVq27ZgvG1UwwWCGXhgxjDj0VUsE9rLaqG1BSfNfcbY9UCXPxdi+nx/6lpQLAN48XBHRbVQKeBblwHqnhRwldwELJk8/Xxs7hrGORLC/tqXJz3bo9l8Dc0gC6B+8RSm4E1W9aN2sgSOCVPStIu0xvb29DF+JSv7Cw+/Oaao=
Received: from DS0PR12MB6534.namprd12.prod.outlook.com (2603:10b6:8:c1::19) by
 LV8PR12MB9206.namprd12.prod.outlook.com (2603:10b6:408:186::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8746.31; Tue, 20 May
 2025 13:22:12 +0000
Received: from DS0PR12MB6534.namprd12.prod.outlook.com
 ([fe80::ea87:74ba:36ec:8cf6]) by DS0PR12MB6534.namprd12.prod.outlook.com
 ([fe80::ea87:74ba:36ec:8cf6%5]) with mapi id 15.20.8722.027; Tue, 20 May 2025
 13:22:12 +0000
From: "Wheeler, Daniel" <Daniel.Wheeler@amd.com>
To: "Chung, ChiaHsuan (Tom)" <ChiaHsuan.Chung@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
CC: "Wentland, Harry" <Harry.Wentland@amd.com>, "Li, Sun peng (Leo)"
 <Sunpeng.Li@amd.com>, "Pillai, Aurabindo" <Aurabindo.Pillai@amd.com>, "Li,
 Roman" <Roman.Li@amd.com>, "Lin, Wayne" <Wayne.Lin@amd.com>, "Chung,
 ChiaHsuan (Tom)" <ChiaHsuan.Chung@amd.com>, "Zuo, Jerry" <Jerry.Zuo@amd.com>, 
 "Wu, Ray" <Ray.Wu@amd.com>, "Hung, Alex" <Alex.Hung@amd.com>
Subject: RE: [PATCH 00/11] DC Patches May 19 2025
Thread-Topic: [PATCH 00/11] DC Patches May 19 2025
Thread-Index: AQHbw/mpZLYwiSn63EGDt393fQashbPbi9KQ
Date: Tue, 20 May 2025 13:22:12 +0000
Message-ID: <DS0PR12MB65342A74A39C0C867A020CB29C9FA@DS0PR12MB6534.namprd12.prod.outlook.com>
References: <20250513112439.2295366-1-chiahsuan.chung@amd.com>
In-Reply-To: <20250513112439.2295366-1-chiahsuan.chung@amd.com>
Accept-Language: en-CA, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_ActionId=f37c7cc8-2cc6-45cb-a0ec-d308609b7eb3;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_ContentBits=0;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Enabled=true;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Method=Privileged;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Name=Open Source;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_SetDate=2025-05-20T13:20:19Z;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Tag=10, 0, 1, 1;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS0PR12MB6534:EE_|LV8PR12MB9206:EE_
x-ms-office365-filtering-correlation-id: 82c6da53-df09-4898-f2ca-08dd97a154e9
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|1800799024|366016|376014|38070700018;
x-microsoft-antispam-message-info: =?iso-8859-1?Q?YOPgXZpfeVG3bWSyuJt8eTChCDH8gSRfxIgv95Anlp9w0vVH5x9tfiHrXv?=
 =?iso-8859-1?Q?WZ75TsnO/OPbsjFdgRdKP82DhohiDc0K+ns6jEBW0GH3gbqe0TK7Ccl9+6?=
 =?iso-8859-1?Q?aFvZjYZf+wKrDTH8obTMLUmKMfAqxjWTNEZcFaIXwBsSVRLk0F56YNw404?=
 =?iso-8859-1?Q?x95vKPNgKHZ+NZbb+8L67y5MFND5xukAXtKiipbgrkTnSEVMib2WHaDAmD?=
 =?iso-8859-1?Q?uVTiYdtvWOULLTqTmB6EiLZuhWdYTU3OCHNL5m1fy35MsLOctLNrmQ6wjA?=
 =?iso-8859-1?Q?xMRd5bEI1F27tVEO29JHhB4t9wCwtILgMwA2Ui7Bcm6mlf1dtPwevXqKFU?=
 =?iso-8859-1?Q?P3h4URBQyLlBae/HBu5DwWgmLNRF7BagH6Ju59VL/KdgG5ITIig/51AHKW?=
 =?iso-8859-1?Q?jom17kYsvsshCpsQO46M17V3wK8lxAFndHxipu6U75B3m2czFsbo8ZdxDc?=
 =?iso-8859-1?Q?xzGBOCj/G/r6fCDoZgO21X3lsnLmedv/DKJ8q5sevV4LTFAO10FTJsYRJv?=
 =?iso-8859-1?Q?sgLyTNP35qFxck+YpAznojnp+hvN0krZm1CLuneYMuTEePz5ycHe1xNmbf?=
 =?iso-8859-1?Q?SBB0hajrl+y8J4yxwQjXa7wfynEqsTTJCpz6X9i/NMWb568uNL9u6NFcfE?=
 =?iso-8859-1?Q?pMnYgRhjmJIk6IVkCxP2G56s3VpZZlHaL+LmKV94AEfvAwlDzeCzhdwyXX?=
 =?iso-8859-1?Q?os5yA81WCmMHWpXIuD5utFOGPS2Pvz2aiL3Hl/Qapeuzkg3SiE9abMPIow?=
 =?iso-8859-1?Q?fcjv+fwdWV0RX6MwUncsFYaS9/7Z/b8Z1qABGAuo3MqlwA9IDrtXN+8+b7?=
 =?iso-8859-1?Q?RS9H7ZG+M2PFVF1XhYTa5yjY054qTFXj+I9vLZMRDvnJWqYGRQbEVw53s9?=
 =?iso-8859-1?Q?LRfebJKuDukRJXeC/TRwYZ2/r46xXZxwj5Eghg5WF5UDNK9PRcRy6TrxLZ?=
 =?iso-8859-1?Q?cnwrWklugjQr6IhZZrzta/1r7zZS91YwcaTgdgr+EZMRdJBWGdjIntIgw3?=
 =?iso-8859-1?Q?z8wXa7/BR78PlnlKKkDKzt1Bg/UfBGRBJzjIQ0dolSfhhUyGAVGyct4Qyl?=
 =?iso-8859-1?Q?WQcRgZToqN+K/mFChS2J7NNcWfBPF1DsHN095DeJtr1HigfTmTxegWl0SH?=
 =?iso-8859-1?Q?JY3ceRxrupLOg8L0CaguaVx0wul2NU3tVetleuZQpUIhi5QSVOBO6VCaNH?=
 =?iso-8859-1?Q?+t3E2pt0clpWEPCMQeoKwcssOffS5oqek7U6K+bY5aw+qqBHxo363dTzGS?=
 =?iso-8859-1?Q?7ouwZKkhg0M6RG7kWHwpL/b9z7WjqZveGZUIaJNt/fzAUOAaE6K2JUVfxD?=
 =?iso-8859-1?Q?Gw0MxcUIFuyEm7tmOrPqJkDGfKHv5hwqP0u0jOIX6BgYkaMQWktetYshgE?=
 =?iso-8859-1?Q?EkcXGMeee2vBVAIr0Uf+sYz8PhuGdXzYy0SsTiHbBAw/de36LhAJxr55xv?=
 =?iso-8859-1?Q?P2g2sZlvxqAmfWzfjUQ1La5FHaCNtcfUMphIpG9eB60239ENrH55tdoNem?=
 =?iso-8859-1?Q?IkC4yuA7u1m64oIOIH5C8A4DJHVP0K5YAeZ82R0iBXZA=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR12MB6534.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(38070700018); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?hUj0By/VGxwCAIShTchhxw1UxVl6nLC6C2VqFR5YQeN4lLkiCg5qMgBYk0?=
 =?iso-8859-1?Q?UkdjNGPbUWuogP5gXRW2lB0/NbAjKgU7IKt628JGXORVBseKmU2ziWKirc?=
 =?iso-8859-1?Q?fJ1iz0zXrl5rGEzCJ7D70zuiIIp1b2Ski2E5PPg/77WWar49URJ0BNvEsw?=
 =?iso-8859-1?Q?ztEuTlJ4EX8PtiJ6DrOhJPl+1D1Rb97s0Bk5o7G7FmwZjS9HpqcmGxB+AD?=
 =?iso-8859-1?Q?Lt8xXnvRmTkONM7mlGFUhZ3f3o6i24F+y9St+8BYfsELYf92ZUHJmsO6yl?=
 =?iso-8859-1?Q?rSypi2mrcet/Pn0FQUb5NKcwj1i6oh7fdHnN2OrQI8j/2RPVMrnfjNA/WP?=
 =?iso-8859-1?Q?POhTP+5Di41K0YkTMURT44b57kbCWLKNgSqKCtc95DkTfkk23Wjmj987C/?=
 =?iso-8859-1?Q?AnyMZIwFMXCO6s8rV3Z5UlD9GC6yC3U/S6rROmAlEnnBRMe/IOqdX38ZMf?=
 =?iso-8859-1?Q?5D2rxqgyxnkOvdYgWd2WGxnTelni/nyXyFDq7ZuHsOKIJ0WQNdCJQOZjXj?=
 =?iso-8859-1?Q?12Ye/85HY2R1OfO4JoKUXu7Q9/P3xmaydJMIZuKc4el1NRfu4ej4O3Ne5I?=
 =?iso-8859-1?Q?E1UGLY4P3/vAg3Nf1pMXjp1AcfM1KMf21YOQmaMOTHpdepMIyUQ1Lyj9ts?=
 =?iso-8859-1?Q?rXsVQDGl11kog/LDe4zGCOUODBD5BmQTQ3EJ6Jn4xwFjb/hNseH96AfJdU?=
 =?iso-8859-1?Q?LdO5Jw9fHzXKtGLhIUMG28GtaTiOcqMlaM2LBobpMI1/b1uGLaJ1rwjNn+?=
 =?iso-8859-1?Q?AKKOO2OWMO4ge6gXPWg+sy6ETbARAxsbPEJLro7WqtrF8vlpRGJVCHQi7b?=
 =?iso-8859-1?Q?CjBVAoMz+7lyDSA1ST4PIzdOZKXwD7HOID/9GnFLRIMRA2aae2wZAM9bWK?=
 =?iso-8859-1?Q?1JiP+Ag13l/3+NSAzSALcz2NI7o1NwZPqPCzNfPIBYnuYW/E5RJjKEdKZy?=
 =?iso-8859-1?Q?jpAxzgkCker3YrVJLgjSffX8kLSIsNVnqTK9S0RYnKgncZ0mpN1vPf/Pl6?=
 =?iso-8859-1?Q?wB04qnOXufKrBg4A6l8TFYokZnjZWRfXMHNycgSayLEgMebYxsXy/VlIZy?=
 =?iso-8859-1?Q?qzo3OfdDi0VGX+B1wkl3j8Nh5HV8JxJ7waZIUINFPwqLRqjYphnbjKSPYk?=
 =?iso-8859-1?Q?OzgU7CT/NhS+OUW3K9QJb/WZor91s/cJ6+n9yvaF/Q8s6NYTyUauo+AyFq?=
 =?iso-8859-1?Q?r5jqZDLuL0r/iwtSdl1+D3/SAAAh3SWBdLQgm7wIeMt+68yThQpK7FnEy2?=
 =?iso-8859-1?Q?QI1VLQw4F7Aj07Sbsid+3T/6TkOj2GtYufH66l821xCl1gu6zJPwdn2GHT?=
 =?iso-8859-1?Q?0xhOHunC9W2hdPyq4ME6p1Q1WpO8ZFloKtTkQJqqDWAJPEumqYXsYNJYWZ?=
 =?iso-8859-1?Q?i2+otx1jRJPF8oF2t6vpvsCfyxGs4eRYVUidrtOInfx1GlK5/8AJDU8Iep?=
 =?iso-8859-1?Q?Cw3KJnmwdmd0WRBHrLjT9Ty263LGozl2eSDyg4xSOGM2XaCQRF4UXVJAbl?=
 =?iso-8859-1?Q?Y3PM7rUXIW8YiSGtEeN4s7hu/V+m6AJWyuDs/AQIw75ZEmtAFPMvgCUHAq?=
 =?iso-8859-1?Q?s41ZwiEMLdGTmjOLTYLqSGAzX2K7GKLnjGRuQoDnZ4JMh5WfQecIneT1v/?=
 =?iso-8859-1?Q?ZkOnz/+BxHahA=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB6534.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 82c6da53-df09-4898-f2ca-08dd97a154e9
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 May 2025 13:22:12.6277 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: /Ct4K65SBD4dWHWK+l9gTQVSLhLWMlLQQBMvCAEy1cXvWMu13H8mBCHyrWWYQK8EfaT3j/jb26tpl1L5NlMU9w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR12MB9206
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
        * Single Display eDP -> 1080p 60hz, 1920x1200 165hz
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

The patchset consists of the amd-staging-drm-next branch (Head commit - 937=
31cdc105ab89f796a826b52a524a3be4b6f4d -> drm/amdgpu: implement get_retire_f=
lip_bits for UMC v12) with new patches added on top of it.

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
From: Tom Chung <chiahsuan.chung@amd.com>
Sent: Tuesday, May 13, 2025 7:24 AM
To: amd-gfx@lists.freedesktop.org
Cc: Wentland, Harry <Harry.Wentland@amd.com>; Li, Sun peng (Leo) <Sunpeng.L=
i@amd.com>; Pillai, Aurabindo <Aurabindo.Pillai@amd.com>; Li, Roman <Roman.=
Li@amd.com>; Lin, Wayne <Wayne.Lin@amd.com>; Chung, ChiaHsuan (Tom) <ChiaHs=
uan.Chung@amd.com>; Zuo, Jerry <Jerry.Zuo@amd.com>; Wheeler, Daniel <Daniel=
.Wheeler@amd.com>; Wu, Ray <Ray.Wu@amd.com>; Hung, Alex <Alex.Hung@amd.com>
Subject: [PATCH 00/11] DC Patches May 19 2025

This DC patchset brings improvements in multiple areas. In summary, we high=
light:

-Support external tunneling feature
-Modify DCN401 DMUB reset & halt sequence -Fix the typo in dcn401 Hubp bloc=
k -Skip backend validation for virtual monitors

Cc: Daniel Wheeler <daniel.wheeler@amd.com>


Chiawen Huang (1):
  drm/amd/display: Skip backend validation for virtual monitors

Cruise Hung (1):
  drm/amd/display: Support external tunneling feature

Dillon Varone (1):
  drm/amd/display: Modify DCN401 DMUB reset & halt sequence

Karthi Kandasamy (1):
  drm/amd/display: Move mcache allocation programming from DML to
    resource

Nevenko Stupar (1):
  drm/amd/display: Fix the typo in dcn401 Hubp block

Ovidiu Bunea (1):
  drm/amd/display: Add GPINT retries to ips_query_residency_info

Samson Tam (1):
  drm/amd/display: add support for 2nd sharpening range

Taimur Hassan (2):
  drm/amd/display: [FW Promotion] Release 0.1.11.0
  drm/amd/display: Promote DAL to 3.2.334

Tomasz Siemek (1):
  drm/amd/display: Extend dc_plane_get_status with flags

Yihan Zhu (1):
  drm/amd/display: init local variable to fix format errors

 drivers/gpu/drm/amd/display/dc/core/dc.c      | 10 ++-
 .../gpu/drm/amd/display/dc/core/dc_resource.c | 13 ++++  .../gpu/drm/amd/d=
isplay/dc/core/dc_surface.c  |  8 ++-
 drivers/gpu/drm/amd/display/dc/dc.h           |  2 +-
 drivers/gpu/drm/amd/display/dc/dc_dmub_srv.c  | 14 ++--  drivers/gpu/drm/a=
md/display/dc/dc_dp_types.h  | 21 ++++++
 drivers/gpu/drm/amd/display/dc/dc_plane.h     | 10 ++-
 .../dc/dml2/dml21/dml21_translation_helper.c  |  2 +-  .../dc/dml2/dml21/d=
ml21_translation_helper.h  |  2 +  .../amd/display/dc/dml2/dml21/dml21_wrap=
per.c | 40 +++++++++++  .../amd/display/dc/dml2/dml21/dml21_wrapper.h | 64 =
+++++++++++++++++
 .../drm/amd/display/dc/dml2/dml2_wrapper.h    |  2 +
 .../amd/display/dc/hubp/dcn401/dcn401_hubp.c  |  2 +-
 .../amd/display/dc/hwss/dcn35/dcn35_hwseq.c   |  2 +-
 .../amd/display/dc/hwss/dcn401/dcn401_hwseq.c | 16 ++---
 .../gpu/drm/amd/display/dc/inc/core_types.h   |  5 ++
 drivers/gpu/drm/amd/display/dc/inc/link.h     |  3 +
 drivers/gpu/drm/amd/display/dc/inc/resource.h |  8 +++  .../drm/amd/displa=
y/dc/link/link_detection.c  | 21 ++----
 .../gpu/drm/amd/display/dc/link/link_dpms.c   |  6 +-
 .../drm/amd/display/dc/link/link_factory.c    |  1 +
 .../dc/link/protocols/link_dp_capability.c    |  8 +--
 .../display/dc/link/protocols/link_dp_dpia.c  | 54 ++++++++++++--  .../dis=
play/dc/link/protocols/link_dp_dpia.h  |  6 ++
 .../dc/link/protocols/link_dp_dpia_bw.c       | 70 +++++++------------
 .../dc/link/protocols/link_dp_dpia_bw.h       |  4 +-
 .../dc/link/protocols/link_dp_irq_handler.c   |  4 +-
 .../drm/amd/display/dc/sspl/dc_spl_types.h    |  4 ++
 .../gpu/drm/amd/display/dmub/inc/dmub_cmd.h   | 34 ++++++++-
 .../drm/amd/display/dmub/src/dmub_dcn401.c    | 16 ++---
 30 files changed, 337 insertions(+), 115 deletions(-)

--
2.34.1

