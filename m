Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 10EACC5AD49
	for <amd-gfx@archiver.kernel.org>; Mon,  2 Jun 2025 13:24:29 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 832C010E2BF;
	Mon,  2 Jun 2025 13:24:29 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="fAeHX07X";
	dkim-atps=neutral
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2062.outbound.protection.outlook.com [40.107.243.62])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2606810E2BF
 for <amd-gfx@lists.freedesktop.org>; Mon,  2 Jun 2025 13:24:28 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ogytgxMNTJnY1LaeLQ/dh6WF8QobcHuQCQ0usoK99WvsKmIDU3foYYpB8libF8ihjBlaJ5YpWIWl7WVwogxN7GiXZpfv7PJ1KTlnWYQZTzF183MsM8d3qEaS2hqwo7btgJSpRyLKyb4iXfi3W+d/KZojsVncoqzfOmeotn/5S067qn+b5wfiVAVvLSoRwM3Vh/vhbaDzDAH2LKxlcPBkNhOla56xaO598oZIAyWfHgMD6pkQzQHBrRpI7YTXOzZOHPbz8xu8D39SjaRXx352vS8hYm/q5nrzdsLgtXy0UbSRQ7rQBCtbPibLJgbaNjMu79al1wJ/0g4lr4WrVxcUkg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hJ8fbO5BSR6tyDb++AY3IXE5IgL1aaWiIDqO1nPIPDc=;
 b=Zg2ZuM8LGHXGDRtn6OJk1UanW/Ir6YvUD7MCcmEtydtnpqZ5xwGl85q9INpSMAJFNLnucr3wm/PQ4xeEoxLriGBg79oXb/k39mHvJG/5ut99wI7BN+qNKJlZTnXiLLRScdJFeXxGr/bNycxwpx8BPGC/NF+R5sF/9XdJ31+jO/RGv+K5KB/Tk94GENeGTuREPRvHLV83tprzYAzhnQT0DQVdr0M5ELgekocUwF5qoKvSYc9MPDH390gc2F6NT6SEkQ6O7d/h0ZdVJMETY5isVjqlABX/kxeiMvMzG7uPnh5KjtRp4yxIZ1EFy8fTAuNqDQH5OBDiJxrU+AzZtLzjbw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hJ8fbO5BSR6tyDb++AY3IXE5IgL1aaWiIDqO1nPIPDc=;
 b=fAeHX07XTPSzyiwIVaSX1BhW4onXuLkzFobRdgZGssbjm7CQp07/A0/04VpTrIVUcs1Ljh4fbH58iXGzjlgxEU3Vv6u6fHf+7aEAxi1jAupVjy+M8Y1Ufeh3qwRcXg6LGLk32fVpGUe4PMKTvJlJXIwUscs0x99kEBjG93BuyIk=
Received: from DS0PR12MB6534.namprd12.prod.outlook.com (2603:10b6:8:c1::19) by
 MN0PR12MB6342.namprd12.prod.outlook.com (2603:10b6:208:3c1::9) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8769.33; Mon, 2 Jun 2025 13:24:25 +0000
Received: from DS0PR12MB6534.namprd12.prod.outlook.com
 ([fe80::ea87:74ba:36ec:8cf6]) by DS0PR12MB6534.namprd12.prod.outlook.com
 ([fe80::ea87:74ba:36ec:8cf6%5]) with mapi id 15.20.8769.029; Mon, 2 Jun 2025
 13:24:25 +0000
From: "Wheeler, Daniel" <Daniel.Wheeler@amd.com>
To: "Lin, Wayne" <Wayne.Lin@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
CC: "Wentland, Harry" <Harry.Wentland@amd.com>, "Li, Sun peng (Leo)"
 <Sunpeng.Li@amd.com>, "Pillai, Aurabindo" <Aurabindo.Pillai@amd.com>, "Li,
 Roman" <Roman.Li@amd.com>, "Lin, Wayne" <Wayne.Lin@amd.com>, "Chung,
 ChiaHsuan (Tom)" <ChiaHsuan.Chung@amd.com>, "Zuo, Jerry" <Jerry.Zuo@amd.com>, 
 "Wu, Ray" <Ray.Wu@amd.com>, "Hung, Alex" <Alex.Hung@amd.com>, "Lin, Wayne"
 <Wayne.Lin@amd.com>
Subject: RE: [PATCH 00/24] DC Patches June 2nd, 2025
Thread-Topic: [PATCH 00/24] DC Patches June 2nd, 2025
Thread-Index: AQHbz3uJOAAsAbl1/EO+IGt9bpFcy7Pv4+8g
Date: Mon, 2 Jun 2025 13:24:25 +0000
Message-ID: <DS0PR12MB65343AC7E9E1A8F1BA0E8A3F9C62A@DS0PR12MB6534.namprd12.prod.outlook.com>
References: <20250528025204.79578-1-Wayne.Lin@amd.com>
In-Reply-To: <20250528025204.79578-1-Wayne.Lin@amd.com>
Accept-Language: en-CA, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_ActionId=81004465-a010-48c8-be1a-9531da1faf21;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_ContentBits=0;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Enabled=true;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Method=Privileged;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Name=Open Source;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_SetDate=2025-06-02T13:24:20Z;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Tag=10, 0, 1, 1;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS0PR12MB6534:EE_|MN0PR12MB6342:EE_
x-ms-office365-filtering-correlation-id: fe4ba7d7-e8b3-48aa-3e8b-08dda1d8cb6d
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|366016|376014|1800799024|38070700018;
x-microsoft-antispam-message-info: =?iso-8859-1?Q?Bl/2Q758h9vwcFE1sRXMQ3uUJoGVbDKUDZQmH+bYKYLBe1GbAxQBZhzRXz?=
 =?iso-8859-1?Q?9MLShlAZL2eiiJmpE0sPrLE2K1BBt2kx0gLxOWH3goNdhxWy0wvC/Eko1Y?=
 =?iso-8859-1?Q?mez/yjKGjKLuu6giJfyjKJYbEEz/jhiGD6KgmmHDBApYHEIJOGKz5gBe0D?=
 =?iso-8859-1?Q?r2Ve25NCSkj/J9zNH3zSlIt0f9lH+AVNjONKdIra26oqW2kDqsFImHaF8t?=
 =?iso-8859-1?Q?DEqYJd5fi6wroiQshhIvEMf/JQcZg8wpNdt3qAEmbUxdECbgoZmV5ejgiV?=
 =?iso-8859-1?Q?5qW/VGBef95WXrJOQIUFIdJKcasDvGkVnyePpyhDHqtZYUkVUR/H9XEFtn?=
 =?iso-8859-1?Q?9q5wUIYtlQzk+cr9VIUNGNfvrBh/K55iok1OoxcL7fLGGlQbsO3SlRXw0q?=
 =?iso-8859-1?Q?GWovtj02v1Uvcx5c3/yxHUhTjm/6U9YJSgyV8A/6aazAj5vRVQCsL5tEmU?=
 =?iso-8859-1?Q?mcc7bqrnX+BP2lX2CUNFu8YP41qhKbOxmpEl0rBKFgzEF78+/mTSzHRMfQ?=
 =?iso-8859-1?Q?LpB9jPJwgi43TWOZ8SikwaFFMR6XUhLeXQ3LubUfxrUNMJMj3P7sMyAkuy?=
 =?iso-8859-1?Q?T83wwmISnh+PYxinKmet5SikmaW3pYtQ2Y1ZHuKdxOFk6InfIHfUdaHeEd?=
 =?iso-8859-1?Q?p7V5mWm7qIozAx+GkKRnl6tWAzB+ZwS64MqBFIcuXakr2R188LHDPa+R2s?=
 =?iso-8859-1?Q?nAhV/Ich4hGFhRXr6JxpfOC/cRnbRvX80SBv2YHngnVuK+WnL1OuluimsA?=
 =?iso-8859-1?Q?GeUW4JEQ4fzZ9yf/dILe9i1LiN1705BGuUV/lCytJp6CJhaCRi7F3MUkwc?=
 =?iso-8859-1?Q?6nuquhy3GGPQq/f+MDpVD6Fi9aCTHSTZYvQjUzvHiwggydVvYt+s7P1b1M?=
 =?iso-8859-1?Q?ThVokBYXcjyQ1vybVdMEVyslOxLdc3i+j+S3AnX8Edi6fV9/uV4hcFHzPY?=
 =?iso-8859-1?Q?8Vte1XqjJLOeTh4dFNzexpmk/wpMYlfzU9CH1l8qxEtlGQAkeTqaQoPcHp?=
 =?iso-8859-1?Q?QaOPryeLyhVJPWDWhUopP9d8jS2A2ykjNuAEmf9BWGVcBWyhvD/4UFt+vR?=
 =?iso-8859-1?Q?z3KgGdwp0FKs/QPVAE2sciojHeAxCLB5fqR8nXypWqmPf1MxOjxvWBZCud?=
 =?iso-8859-1?Q?PR+Cy3SHCx3SSS/O+hLn2JnaHfqNe0Ldl+LfCIksrRyDJG3anFNsYt+7dA?=
 =?iso-8859-1?Q?tIFK8Vps+mLzK9tgRmpMUdoOI8FLdAoJUl4TMYaM+ipkRWx0bd40JqJgA8?=
 =?iso-8859-1?Q?TEXo/GvP6jNcivOCQCn0OIWtNWH7YPllyz73QAwD4oGOzI/7GxuitEPY7c?=
 =?iso-8859-1?Q?lBkOIoyY97igHnZ4wcuL965SjPB8FsozeVlL7VI71rmr9HwwAaSthrtNgO?=
 =?iso-8859-1?Q?3ALKRGvAyJkG2AyGpnwhDZNG5TXdEBLyIWYvdgUY5Q+ddhlGJXOhOVXgLa?=
 =?iso-8859-1?Q?TSX91FSShHqXJYc33PbMbp7FSIa2ynsW0F9ps/PHPDOQ27oJvIB0a8iIPg?=
 =?iso-8859-1?Q?1OjZ8ASIf41yGTJedjm9bICr4rNMYCcvz7TxfZIXfU4A=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR12MB6534.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(38070700018); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?lYwMvCxB2rod0xQl227WaBVgXGlBI94KZS8nftWAL2UqudYCBHr4PMz0W4?=
 =?iso-8859-1?Q?CluI2mkWOqTGRSD9anYr4EbbjLwZxQX4dfltAsQce2sigLvgwY+cF6+XmQ?=
 =?iso-8859-1?Q?P8ndU4qw2xRwa/KxZ5/87peOegNiXKpOVgNqvILMeXdTSdwMwD201cLiw5?=
 =?iso-8859-1?Q?t97LCTumyDm4cdGYFZ2h0skUl+Jyj+VJrBoX40rKixLliQ9hHOZRX7ebh4?=
 =?iso-8859-1?Q?CAOg/kp7S89EvFTiAZefc0NTLgddwi/Xg1HYVXmZVzgv6J9HSYahRIHJHX?=
 =?iso-8859-1?Q?o65osQP5aYk/cPqQB//SHafF1qeuVpZtVYQG5PdJSa5ietapwkCCuUeq4v?=
 =?iso-8859-1?Q?SftcTyd28ME+m7kq8+Tb0gKVbEZARQVUZimsjs0LhTQc9c7y/gfyuZ39f0?=
 =?iso-8859-1?Q?YbLHtwaPF7UV13aYqFXbUsiq+wmW055h0DUA1uOQ2CvatJON0ViMlfv1zY?=
 =?iso-8859-1?Q?z3GE8GzfpbJ5Is0vOtXX5RsjzhruB0rQWmpvkWkPxlmrRFli9GQI/7Wkmc?=
 =?iso-8859-1?Q?TmDfnqjXtCEzzelq2wi4YdWO5c8JO+pnUDnlKint4w/ypXhKF/dPgqkUG6?=
 =?iso-8859-1?Q?zUr5B9MPT0Muj1lbPofgYYnbJgWZJAQ9ZYB4ivdQe8TSce8LnzMRS1Y2rg?=
 =?iso-8859-1?Q?HQQkp84vCKFNY3Vzl+f+mREqQT/9honSiZJ2jk2I4at5ludQlsqMwiAKiY?=
 =?iso-8859-1?Q?C2OD6guBrmhQYdP2uJ3uP3q0Magc5oaNVn//NF0T3vN6xB7wJCDFQP14tV?=
 =?iso-8859-1?Q?EBC7CPpNtxRwODlj6KCod76Bxcjru5kAUsmJi5Z0WVXIBjSl2RJXNB9jFy?=
 =?iso-8859-1?Q?vTPMD5GcetCuLdc7HAknYWy48rDNF6qR5qejIJaRvh1smZhsz9Rrua4WLZ?=
 =?iso-8859-1?Q?PghwSToMED+wUgcyqdsqcy/+ZMgwFgEodWjqpKsjrpJd/tGiUo4kaAj+R4?=
 =?iso-8859-1?Q?jzi/2tfC+ouM64WOmGqPmclfJMvzLZKiyleVZ2sXk4glByUg7rtseHdfLe?=
 =?iso-8859-1?Q?wauo7FpzVWjP/4DxHMM3l4/GZOipgbnxRe/+MQ4TqCDYaAhv27EZDOWP3O?=
 =?iso-8859-1?Q?KlFYuCa7pU752sVwAWKN5Wd+mmAV3h1TBIVVlGnv6tfgsUnRFLucyLu3V/?=
 =?iso-8859-1?Q?RMpNlzuUhb23r5Pg844+n1UsyHt6AH5aUN3+Kc2e5aLNKEh1iAfYJyC+Z4?=
 =?iso-8859-1?Q?CMDv+Ems5dpHw/F8SGyj1gcXEs7iyvwBkVlbLyy8qVoHsxOCKJECjaI7Ns?=
 =?iso-8859-1?Q?O9D7IszWKpCkfwwoliCrWq5ZD4jzMHAeWzRqw4eqQmkuDVSDhyA5XcTYfC?=
 =?iso-8859-1?Q?9+8xFCHpmjmDodbajJzKyeNU57BbQsC3MutJ9FCp+5z3FpDMLVJTVKACg7?=
 =?iso-8859-1?Q?QZtDy6G0fVdsH4PzV2Q+0OXtjyVMfGlGpDiTifXuo7gptSCJFU0996noe6?=
 =?iso-8859-1?Q?GAeVw1lU2ESTFkmLgRHAWd/k6MqMq5XX7cTMgQ0J/pTAdhs2kakmBHUzjk?=
 =?iso-8859-1?Q?FXcDP2XWPTYMwzWhb11mhkHe8rC0vK+o+MyhXyLdS1VnPdY7OQIhc5QjDu?=
 =?iso-8859-1?Q?UvNGXZ6DZrwetGjJ3vcsk+GmW3r5RMg6b+jA3JqxaagywU50QBDg6zsSGr?=
 =?iso-8859-1?Q?9MzzG9+qQ3wE4=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB6534.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fe4ba7d7-e8b3-48aa-3e8b-08dda1d8cb6d
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Jun 2025 13:24:25.4142 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: pjueDB2u02JoComsOWUyFeeT4dgOM5XQK3lF1Uavv7lV1r3OlFXjfEXR9sXs86MaWSxBSXgTCpybqKGK2+Dn1A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB6342
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

The patchset consists of the amd-staging-drm-next branch (Head commit - b69=
3472094cd4b6cc96715df2e1a17d1ebf85313 drm/amd/display: [FW Promotion] Relea=
se 0.1.11.0) with new patches added on top of it.

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
From: Wayne Lin <Wayne.Lin@amd.com>
Sent: Tuesday, May 27, 2025 10:49 PM
To: amd-gfx@lists.freedesktop.org
Cc: Wentland, Harry <Harry.Wentland@amd.com>; Li, Sun peng (Leo) <Sunpeng.L=
i@amd.com>; Pillai, Aurabindo <Aurabindo.Pillai@amd.com>; Li, Roman <Roman.=
Li@amd.com>; Lin, Wayne <Wayne.Lin@amd.com>; Chung, ChiaHsuan (Tom) <ChiaHs=
uan.Chung@amd.com>; Zuo, Jerry <Jerry.Zuo@amd.com>; Wheeler, Daniel <Daniel=
.Wheeler@amd.com>; Wu, Ray <Ray.Wu@amd.com>; Hung, Alex <Alex.Hung@amd.com>=
; Lin, Wayne <Wayne.Lin@amd.com>
Subject: [PATCH 00/24] DC Patches June 2nd, 2025

This DC patchset brings improvements in multiple areas. In summary, we high=
light:

- Fixes for DML21
- Support OLED SDR with AMD ABC
- Indirect buffer transport for FAMS2 commands
- Correct stream attributes setup timing
- Correct non-OLED pre_T11_delay
- Optime boot-up consuming time
- Add support for 2nd sharpening range
- Fix on chroma planes scaling
- Fix brightness relevant settings
- Fix calling blanking stream twice
- Extend dc mode validation types to support more scenarios
- Update DMCUB loading sequence for DCN3.5

Cc: Daniel Wheeler <daniel.wheeler@amd.com>

---
Alvin Lee (1):
  drm/amd/display: Re-order FAMS2 sub commands

Austin Zheng (1):
  drm/amd/display: DML21 Fixes

Camille Cho (1):
  drm/amd/display: Support OLED SDR with AMD ABC

Cruise Hung (1):
  drm/amd/display: Use DC log instead of using DM error msg

Jingwen Zhu (1):
  drm/amd/display: Add disconnect case on dongle check

Mario Limonciello (3):
  drm/amd/display: Drop unnecessary `amdgpu` prefix
  drm/amd/display: Add debugging message for brightness caps
  drm/amd/display: Fix default DC and AC levels

Michael Strauss (1):
  drm/amd/display: Call setup_stream_attribute after stream enc clk is
    ungated

Navid Assadian (1):
  drm/amd/display: Do not bypass chroma scaling in 1:1 case

Nicholas Kazlauskas (1):
  drm/amd/display: Update DMCUB loading sequence for DCN3.5

Oleh Kuzhylnyi (2):
  drm/amd/display: Indirect buffer transport for FAMS2 commands
  drm/amd/display: Add DML path for FAMS methods

Ray Wu (1):
  drm/amd/display: Move vmalloc include to header file

Samson Tam (1):
  drm/amd/display: Add support for 2nd sharpening range

Taimur Hassan (4):
  drm/amd/display: [FW Promotion] Release 0.1.11.0
  drm/amd/display: [FW Promotion] Release 0.1.12.0
  drm/amd/display: Promote DAL to 3.2.335
  drm/amd/display: Promote DAL to 3.2.336

Wayne Lin (1):
  drm/amd/display: Avoid trying AUX transactions on disconnected ports

Yan Li (1):
  drm/amd/display: replace fast_validate with enum dc_validate_mode

Yihan Zhu (1):
  drm/amd/display: move RMCM programming

Zhongwei Zhang (2):
  drm/amd/display: Correct non-OLED pre_T11_delay.
  drm/amd/display: Avoid calling blank_stream() twice

 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c |  48 +--
 .../display/amdgpu_dm/amdgpu_dm_mst_types.c   |   6 +-
 drivers/gpu/drm/amd/display/dc/core/dc.c      |  12 +-
 .../gpu/drm/amd/display/dc/core/dc_resource.c |  12 +-
 drivers/gpu/drm/amd/display/dc/dc.h           |  47 ++-
 drivers/gpu/drm/amd/display/dc/dc_dmub_srv.c  |  59 +++-  .../gpu/drm/amd/=
display/dc/dc_spl_translate.c |  19 +-
 drivers/gpu/drm/amd/display/dc/dc_types.h     |  10 +-
 .../drm/amd/display/dc/dml/calcs/dcn_calcs.c  |   6 +-
 .../drm/amd/display/dc/dml/dcn20/dcn20_fpu.c  |  45 ++-  .../drm/amd/displ=
ay/dc/dml/dcn20/dcn20_fpu.h  |  12 +-
 .../drm/amd/display/dc/dml/dcn30/dcn30_fpu.c  |   6 +-
 .../drm/amd/display/dc/dml/dcn31/dcn31_fpu.h  |   2 +-
 .../amd/display/dc/dml/dcn314/dcn314_fpu.c    |   4 +-
 .../amd/display/dc/dml/dcn314/dcn314_fpu.h    |   2 +-
 .../drm/amd/display/dc/dml/dcn32/dcn32_fpu.c  |  30 +-
 .../drm/amd/display/dc/dml/dcn32/dcn32_fpu.h  |   2 +-
 .../drm/amd/display/dc/dml/dcn35/dcn35_fpu.c  |   4 +-
 .../drm/amd/display/dc/dml/dcn35/dcn35_fpu.h  |   2 +-
 .../amd/display/dc/dml/dcn351/dcn351_fpu.c    |   4 +-
 .../amd/display/dc/dml/dcn351/dcn351_fpu.h    |   2 +-
 .../dc/dml2/dml21/dml21_translation_helper.c  |   4 +-
 .../amd/display/dc/dml2/dml21/dml21_utils.c   |  14 +-
 .../amd/display/dc/dml2/dml21/dml21_wrapper.c |   9 +-
 .../amd/display/dc/dml2/dml21/dml21_wrapper.h |  11 +-
 .../amd/display/dc/dml2/dml21/inc/dml_top.h   |   1 -
 .../display/dc/dml2/dml21/inc/dml_top_types.h |  10 +-
 .../src/dml2_core/dml2_core_dcn4_calcs.c      |   7 +-
 .../src/dml2_core/dml2_core_shared_types.h    |  82 ++++-
 .../dml2/dml21/src/dml2_dpmm/dml2_dpmm_dcn4.c |   3 -
 .../src/inc/dml2_internal_shared_types.h      |  10 +-
 .../amd/display/dc/dml2/dml2_mall_phantom.c   |   2 +-
 .../drm/amd/display/dc/dml2/dml2_wrapper.c    |  11 +-
 .../drm/amd/display/dc/dml2/dml2_wrapper.h    |   4 +-
 .../amd/display/dc/hwss/dce110/dce110_hwseq.c |  11 +-
 .../amd/display/dc/hwss/dcn20/dcn20_hwseq.c   |  12 +-
 .../amd/display/dc/hwss/dcn31/dcn31_hwseq.c   |  11 +-
 .../amd/display/dc/hwss/dcn401/dcn401_hwseq.c | 292 +-----------------
 .../amd/display/dc/hwss/dcn401/dcn401_hwseq.h |   8 -
 .../display/dc/hwss/hw_sequencer_private.h    |   1 +
 .../gpu/drm/amd/display/dc/inc/core_types.h   |   9 +-
 .../gpu/drm/amd/display/dc/inc/dcn_calcs.h    |   2 +-
 .../gpu/drm/amd/display/dc/link/link_dpms.c   |   6 +-
 .../drm/amd/display/dc/link/link_validation.c |   8 +
 .../dc/link/protocols/link_dp_capability.c    |   2 +-
 .../link/protocols/link_edp_panel_control.c   |  21 ++
 .../drm/amd/display/dc/mpc/dcn32/dcn32_mpc.c  |   3 -
 drivers/gpu/drm/amd/display/dc/os_types.h     |   1 +
 .../dc/resource/dce100/dce100_resource.c      |   2 +-
 .../dc/resource/dce110/dce110_resource.c      |   2 +-
 .../dc/resource/dce112/dce112_resource.c      |   2 +-
 .../dc/resource/dce112/dce112_resource.h      |   2 +-
 .../dc/resource/dce60/dce60_resource.c        |   2 +-
 .../dc/resource/dce80/dce80_resource.c        |   2 +-
 .../dc/resource/dcn10/dcn10_resource.c        |   4 +-
 .../dc/resource/dcn20/dcn20_resource.c        |   8 +-
 .../dc/resource/dcn20/dcn20_resource.h        |   4 +-
 .../dc/resource/dcn21/dcn21_resource.c        |   8 +-
 .../dc/resource/dcn21/dcn21_resource.h        |   2 +-
 .../dc/resource/dcn30/dcn30_resource.c        |  22 +-
 .../dc/resource/dcn30/dcn30_resource.h        |   6 +-
 .../dc/resource/dcn31/dcn31_resource.c        |  18 +-
 .../dc/resource/dcn31/dcn31_resource.h        |   4 +-
 .../dc/resource/dcn314/dcn314_resource.c      |  14 +-
 .../dc/resource/dcn314/dcn314_resource.h      |   2 +-
 .../dc/resource/dcn315/dcn315_resource.c      |   4 +-
 .../dc/resource/dcn316/dcn316_resource.c      |   4 +-
 .../dc/resource/dcn32/dcn32_resource.c        |  26 +-
 .../dc/resource/dcn32/dcn32_resource.h        |   4 +-
 .../dc/resource/dcn35/dcn35_resource.c        |   6 +-
 .../dc/resource/dcn351/dcn351_resource.c      |   6 +-
 .../dc/resource/dcn36/dcn36_resource.c        |   6 +-
 .../dc/resource/dcn401/dcn401_resource.c      |  31 +-
 .../dc/resource/dcn401/dcn401_resource.h      |   2 +-
 drivers/gpu/drm/amd/display/dc/sspl/dc_spl.c  |  28 +-
 .../dc/virtual/virtual_stream_encoder.c       |   7 +
 drivers/gpu/drm/amd/display/dmub/dmub_srv.h   |   2 +
 .../gpu/drm/amd/display/dmub/inc/dmub_cmd.h   | 204 +++++++++++-
 .../gpu/drm/amd/display/dmub/src/dmub_dcn35.c |  16 +-
 .../gpu/drm/amd/display/dmub/src/dmub_srv.c   |   9 +-
 80 files changed, 771 insertions(+), 577 deletions(-)

--
2.43.0

