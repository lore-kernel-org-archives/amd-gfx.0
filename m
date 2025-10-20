Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BB34CCCD199
	for <amd-gfx@archiver.kernel.org>; Mon, 20 Oct 2025 13:34:21 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 59B2810E43A;
	Mon, 20 Oct 2025 13:34:21 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="MqBFGzAb";
	dkim-atps=neutral
Received: from SN4PR0501CU005.outbound.protection.outlook.com
 (mail-southcentralusazon11011018.outbound.protection.outlook.com
 [40.93.194.18])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 134FE10E43A
 for <amd-gfx@lists.freedesktop.org>; Mon, 20 Oct 2025 13:34:20 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NX9s+xa7tyvtPeEEoZ9NdwQGX6SxbUQCbHUGoorIHrfggmCOcQ8JI1QnNajZD3JfpBa3iM9qDbJVJDzZp0NHgnGYqEyaexM9EugMnnYjK/JwgeEhBmtweJB/Fj7gkhEOpY5CtxNmjxUMqUG0VQJ/vuAQZDCj/hEYV+gJ+JyDAAWUfuJoLga3Qb837fu/SSVcMJ5+H4w3VS6srxtEHFn64yqGbBUqbsVoop8dPLybkc+zXCkh7HrIUkVz5eqFCCJDcgNckDAule3LmSFkaFS28zbl+zJGwnw4jAQIBxvwd/MMFCZbGt6zL604JWHQhDSRHDbdGhkKmAoqZbL5D/muPg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vWJvk4WXQkTdnDSr5XJ2Brug/x2xjYOwqmk4yXkl0xM=;
 b=dJYdd8tab7bclJDV87tPMBJ07+hZb26XNG8H1cNBg7Qm8tPlHULNNJj/yqZLXvXE9EwOJoQHyeyOs3DwE5CZgQy+326LASQ4zuwF/NGuIPjwVxpQDP6QyG2qP2+K5bkDt9DHfpOq5VF4Awv55QjYOYmDtFK0DyidJhQmyON0NXCKW0sRyoXxOGTojZuBl+E2F07JB8D/qqs6hNI1GhHN0BVaKi6KDVWXkW2tX2CaRQkJJk+uz2Bd7vppWumM67Klju0za1yP6ifgmSRGT3nSz9fs+ZJ9q8hBrL7LtIw2RYHspZHRRQKSgyl4fNgLrh1MuUKcECR9qa/lWKK6nqZ2nQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vWJvk4WXQkTdnDSr5XJ2Brug/x2xjYOwqmk4yXkl0xM=;
 b=MqBFGzAbFP5WhdcC3ySAvnFT8XoyBTi96KtkfdCglRJbYVk80OWFLtiQnbPtNvk4qPD0LIP0rF4cspZdz7ZSJ8ttemaWicF28H2/obfSs1c2sG/k5HgN5+9g8BXttHr8X0O/KAYwQx9UWXwoXF/owpHDkH+O4wattNG1Sh1pbt0=
Received: from DS0PR12MB6534.namprd12.prod.outlook.com (2603:10b6:8:c1::19) by
 MN6PR12MB8567.namprd12.prod.outlook.com (2603:10b6:208:478::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9228.16; Mon, 20 Oct
 2025 13:34:15 +0000
Received: from DS0PR12MB6534.namprd12.prod.outlook.com
 ([fe80::ea87:74ba:36ec:8cf6]) by DS0PR12MB6534.namprd12.prod.outlook.com
 ([fe80::ea87:74ba:36ec:8cf6%7]) with mapi id 15.20.9228.015; Mon, 20 Oct 2025
 13:34:15 +0000
From: "Wheeler, Daniel" <Daniel.Wheeler@amd.com>
To: "Chung, ChiaHsuan (Tom)" <ChiaHsuan.Chung@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
CC: "Wentland, Harry" <Harry.Wentland@amd.com>, "Li, Sun peng (Leo)"
 <Sunpeng.Li@amd.com>, "Pillai, Aurabindo" <Aurabindo.Pillai@amd.com>, "Li,
 Roman" <Roman.Li@amd.com>, "Lin, Wayne" <Wayne.Lin@amd.com>, "Chung,
 ChiaHsuan (Tom)" <ChiaHsuan.Chung@amd.com>, "Zuo, Jerry" <Jerry.Zuo@amd.com>, 
 "Wu, Ray" <Ray.Wu@amd.com>, "LIPSKI, IVAN" <IVAN.LIPSKI@amd.com>, "Hung,
 Alex" <Alex.Hung@amd.com>
Subject: RE: [PATCH 0/8] DC Patches Oct 20 2025
Thread-Topic: [PATCH 0/8] DC Patches Oct 20 2025
Thread-Index: AQHcPX+g8uKz2jx3XkG/DbrFzHHli7TLERDg
Date: Mon, 20 Oct 2025 13:34:14 +0000
Message-ID: <DS0PR12MB6534BC71057B9E207D18EB349CF5A@DS0PR12MB6534.namprd12.prod.outlook.com>
References: <20251015025816.1542507-1-chiahsuan.chung@amd.com>
In-Reply-To: <20251015025816.1542507-1-chiahsuan.chung@amd.com>
Accept-Language: en-CA, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Enabled=True;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_SetDate=2025-10-20T13:33:10.0000000Z;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Name=Open
 Source; MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_ContentBits=3;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Method=Privileged
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS0PR12MB6534:EE_|MN6PR12MB8567:EE_
x-ms-office365-filtering-correlation-id: 0cf65109-86e5-4386-e31a-08de0fdd5c9a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|1800799024|366016|376014|38070700021;
x-microsoft-antispam-message-info: =?iso-8859-1?Q?tc7LtmUdIRRn/Fhr6oJkMO7leQJmfocNHgp5QSDyASOw1bsTXASexcI/01?=
 =?iso-8859-1?Q?rIgD6UiEjgQegd9KuucGU+s1/hweA3WOV25QGPzQ44lZdMB1yBYV64warB?=
 =?iso-8859-1?Q?hDAFe4uK6TM4J+6frA0rK0HxjYMbeyXbC5k0i2SK7tXrQ2OR8qO3rRihZB?=
 =?iso-8859-1?Q?s4iIIXfNj6D8UvKJSlBQrqb0xxG+/DAYKEjEyi44G4XOVyj10sSkaMsX4H?=
 =?iso-8859-1?Q?UnwvOkjcXa6wo1/o/skyMDeJvq77yVfNcyqV/mOaWOhCeR8vVAAtdhbMh1?=
 =?iso-8859-1?Q?PQZMR2qVyiJ0VvrH0m/d3qcf5n5hk1X7N9erkboJRbuORHUtJgvzJ0lGrP?=
 =?iso-8859-1?Q?yb9stoBX3IcX1QvbtlSOrY4/CEqxHpDnvrgapNR6gGeB76Zi0B5VRwkCMv?=
 =?iso-8859-1?Q?zamHCgDO9580pp0RZCy+1hdPmYq+GbZ4+B7VCqqQReZzFgHk8J06SMxSoo?=
 =?iso-8859-1?Q?CJz1Ujs0DJNvYLkjTgNNMo8tLPFjmvcZMvvebYHv7MCGtG0YbTlyeTYYuu?=
 =?iso-8859-1?Q?u/nS88jbD9nsqNclkLGSNChTj7/wTrLdMiVYB5NJFRCaONN0EeKUn9c3M1?=
 =?iso-8859-1?Q?xJsDwKvR35NuNGhy8XOlMN0Zd6M7zNDI4IRE9qIST69ix4t1I1SPkwoSK6?=
 =?iso-8859-1?Q?a3d+DdlwhEfVA9+jNFCLaYP3UkvWA5uoVCAmcN7P6WeGOvLex60geNq13j?=
 =?iso-8859-1?Q?keTGwPOnnx0ofnn2K2Mad64cdwqOGiPip03rAIsIXWo4hh3gqh+Edfe1dq?=
 =?iso-8859-1?Q?tCtNFmJXRrciB6C6Qx8JCjQSe/V/4zxFzHZXj0ROlo/LA9nuP2Y2ynRoG8?=
 =?iso-8859-1?Q?MmHItH4BBKz65bdwYkQqYL8PG0dBM8kPXq5W6wc/jctItlkGbXAM9eIGFn?=
 =?iso-8859-1?Q?lJpNkwnyuU18LC0F26b3/oiQS8NpcaV3UVJRN0HfXn1iK12vUNsRpS4IKN?=
 =?iso-8859-1?Q?whrvBKGTZTgrsKfRzbrsln0zNr0AEYbMCFTHxmqRfF4GkSeu40R6dea9JU?=
 =?iso-8859-1?Q?01hdk0SXr/a5pQLB8u4965Tq8kqh2Cn2vazu/yzeZrDYpMFYsJgfha/600?=
 =?iso-8859-1?Q?rXFbl97DwsQjwo8MMTbKcMKfNLBcrSzhf+i1yi2FmDqLF07wSE2IEFABZl?=
 =?iso-8859-1?Q?y6TQu824uxzBikXGbqJhLo6eB/7u5wHC0IpAShpUX+rxycbX6+pRJTwMOE?=
 =?iso-8859-1?Q?yYiQIzVDNwNC4Eq4w1mfTJ3+tSWruMYIbMH2XBGdqvxf7T/X5XwbFXsmWu?=
 =?iso-8859-1?Q?ooPtpNfOpu4kUEWni0U8mW6oDENIAtASoxhf1uhzeRJVDWdPFhtWp+FUew?=
 =?iso-8859-1?Q?Y3WcSe3pbOuhYbiM31WyeT5gq55yqTYpOOPlAsLMPBf5MtGHXZIgYGPXhG?=
 =?iso-8859-1?Q?iB6RQDpUg7rI+p+O2T+Lp1xgPdmyRRC9mGAQEyPIuIGmGXEOtTMrBz0Qyf?=
 =?iso-8859-1?Q?/oAbP6uYFJvC1QvRT0f58rIYHFFQRA0qihtZ54t0NJS9AvSpMfjfqd4uBt?=
 =?iso-8859-1?Q?bfAK6qnIKGuPG33OE5ptFe8bwpjC9HeevEt+KDLOnAXzMxEnY4KPxs64L5?=
 =?iso-8859-1?Q?y6ZI1LSq5di/bVes79hDiw9Ed1S1?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR12MB6534.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(38070700021); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?QE+Icn7gsFEi9VJBk8Mu/N6KA1AdBF2tq5nfCFN5IP4vhr9oo86AMlv1m1?=
 =?iso-8859-1?Q?JiWRiDIFFegO9/aujlpWTkHMX2qudMl+2LnEN8eHSMc0HPeiTD3+d9QJBm?=
 =?iso-8859-1?Q?NS8RUZ8Ydxb3cl5zBv0yQsNiC4lsgXfUEuFhlNZ9ISfTlFrYBaDHlNGvlq?=
 =?iso-8859-1?Q?JDKcWA2iJqWHkn8eLcZNorvvyXA+IVokqhmSf1WBmzufwbC8gbjmYjTGKH?=
 =?iso-8859-1?Q?Jld4ECI1SOaRklSFZ+bMhq4wgZ271BtyXsmw8f/za0E0aOvfbOoJq6FWog?=
 =?iso-8859-1?Q?QDRxhWFyb20yFzTfqQHkh3Rr2JFf7AyLBghTN6LYSvaVdqdkecBJdGl4Pw?=
 =?iso-8859-1?Q?NyKVIxYDaATrPpdqVK4e3s8R04GVOPxevCiQ6HKSGjcIpsUDB4c5wS5zvy?=
 =?iso-8859-1?Q?TFclQ8ddx5Qozp1e1+aXbY3Rg7bjOM5y+d6xKoK2O5iR4O4wQDxYNj3YdD?=
 =?iso-8859-1?Q?34/pN4u6aWDtOfMP7Y5rJvg4NqECo4cU+lxx8opiEYR0qQfTOL4M8Jywbs?=
 =?iso-8859-1?Q?8bHh4kX+zniZtasGKCh5Zr2oLraGcDhIjDkQoYiyv2UXXBWQv5ZqQrVEgw?=
 =?iso-8859-1?Q?TQyrqHLX4UII4b2XvUcXBaYcehYKEFmgMTbS8Kl75HZBqFAW7YhthZuWx1?=
 =?iso-8859-1?Q?nPmCGNAxOLZEr3BNpdZpfOoIkN0ewkg2/uUVEAh239pHPsYW6+DJ86rUiL?=
 =?iso-8859-1?Q?pNC3zqZxlZVqgHUe55HJmgM9lEYi8DrbO577YeE4UG0t650h7Mjqrni8ll?=
 =?iso-8859-1?Q?jx3b9WI6G3xuJ/EicZ76vh7nuYRo0CF3UtqkQDPSBu2GOSfqzQo8jlLivl?=
 =?iso-8859-1?Q?FX4zvDb7n66XSuUATCyjPFc/MJGZSPVPu3b0LG0YgU1SEhSz0dPC0OUm+q?=
 =?iso-8859-1?Q?4NJg9HAoL9xsCp6hvd28yv+GW3WtSAUn91c4q8l9sp7ZKz0I+O4Z24lw/G?=
 =?iso-8859-1?Q?hN/TlzUJo09yxVxqyDHq5jaLKdPvSVP2sALqAzUYYs7zg7kzKXM47U4XAI?=
 =?iso-8859-1?Q?De1Qj85ZZI0rGGwtqORYgvnkDDsPKUMmWLZve5WjDqZSy9GN+ad6x/JxFT?=
 =?iso-8859-1?Q?X96z5qMg7wzU62HpaJio9JHHpIBpy2WbFqmYUrshFAcNAuTZN0x9EMmXF8?=
 =?iso-8859-1?Q?fAQUosIAFRPj8reEhknVcjkunFADW9Fv800n+K3/Kc17vTPmtWf+PdJuP1?=
 =?iso-8859-1?Q?PxSNs4vkIO+bs5464hHlwQMNCJLjBWOevCzpcWh6ECW/gW4v9ccUBuF033?=
 =?iso-8859-1?Q?EzrFTY0Y8JO3wK6lR5RK6VhzXivS8TGcHp5oSrBcczJl8J2eZxYeYSXAtB?=
 =?iso-8859-1?Q?9kFycrP8aflOaEa4zvc5nz5/siFCOf38snMf8xE9fOKYPSTM+BBr8kHx0W?=
 =?iso-8859-1?Q?ZpliIWpC542RgpyFZplyVUsaUkWgmuhDxIt1nBDNQ9CDztGX6ytIQZKfNZ?=
 =?iso-8859-1?Q?wJBrdXKb2biwigS7iueU7BkItNrYdfBGTlUpl0ki2f9M1B9rBqdn9DeYks?=
 =?iso-8859-1?Q?7uYvN70E72tq3N4o9TxFLH/fWdwyOMRpSGQlUnHD9hxWNpyjk4rd2zkh9K?=
 =?iso-8859-1?Q?bjBYJuJTlEOQUBeaiRf/J5mCuOuLX0n06ZUnGXXjPdTXSxqkS4w5/x+Lln?=
 =?iso-8859-1?Q?TevsBfqB61aWM=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB6534.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0cf65109-86e5-4386-e31a-08de0fdd5c9a
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Oct 2025 13:34:14.8639 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: p69b/Ef437J3whTaVW37QFtjk9uP5DqmNfSPHFJfgvE8jZ1QlKqg306XcInDe2cnmqRCw4g5vG147+xG4KKXFw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN6PR12MB8567
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


The patchset consists of the amd-staging-drm-next branch (Head commit - a31=
e5a23e933b2087601d9f3debce21aea9205e8 -> drm/amd/display: Promote DC to 3.2=
.354) with new patches added on top of it.

Tested on Ubuntu 24.04.3, on Wayland and X11, using Gnome.

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
From: Tom Chung <chiahsuan.chung@amd.com>
Sent: Tuesday, October 14, 2025 10:57 PM
To: amd-gfx@lists.freedesktop.org
Cc: Wentland, Harry <Harry.Wentland@amd.com>; Li, Sun peng (Leo) <Sunpeng.L=
i@amd.com>; Pillai, Aurabindo <Aurabindo.Pillai@amd.com>; Li, Roman <Roman.=
Li@amd.com>; Lin, Wayne <Wayne.Lin@amd.com>; Chung, ChiaHsuan (Tom) <ChiaHs=
uan.Chung@amd.com>; Zuo, Jerry <Jerry.Zuo@amd.com>; Wheeler, Daniel <Daniel=
.Wheeler@amd.com>; Wu, Ray <Ray.Wu@amd.com>; LIPSKI, IVAN <IVAN.LIPSKI@amd.=
com>; Hung, Alex <Alex.Hung@amd.com>
Subject: [PATCH 0/8] DC Patches Oct 20 2025

This DC patchset brings improvements in multiple areas. In summary, we have=
:

* Fix GFP_ATOMIC abuse
* Fix several checkpatch issues
* Set DCN32 to use update planes and stream version 3
* Write segment pointer with mot enabled for MST
* Control BW allocation in FW side
* Change clean dsc blocks condition in accelerated mode
* Check disable_fec flag before enabling FEC

Cc: Daniel Wheeler <daniel.wheeler@amd.com>

Aurabindo Pillai (1):
  drm/amd/display: Fix GFP_ATOMIC abuse

Cruise Hung (1):
  drm/amd/display: Control BW allocation in FW side

Ilya Bakoulin (1):
  drm/amd/display: Fix misc. checkpatch issues

Lewis Huang (1):
  drm/amd/display: Change clean dsc blocks condition in accelerated mode

Meenakshikumar Somasundaram (2):
  drm/amd/display: Check disable_fec flag before enabling fec.
  drm/amd/display: write segment pointer with mot enabled for mst

Nicholas Carbones (1):
  drm/amd/display: Set DCN32 to use update planes and stream version 3

Taimur Hassan (1):
  drm/amd/display: Promote DC to 3.2.355

 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c |   2 +-
 drivers/gpu/drm/amd/display/dc/core/dc.c      |   3 +-
 .../drm/amd/display/dc/core/dc_hw_sequencer.c |  57 +++----
 drivers/gpu/drm/amd/display/dc/dc.h           |   5 +-
 .../amd/display/dc/dccg/dcn20/dcn20_dccg.c    |   2 +-
 drivers/gpu/drm/amd/display/dc/dce/dce_abm.c  |   2 +-
 drivers/gpu/drm/amd/display/dc/dce/dce_dmcu.c |   6 +-
 .../amd/display/dc/hwss/dce110/dce110_hwseq.c |  11 +-  .../amd/display/dc=
/hwss/dcn401/dcn401_hwseq.c | 160 ++++++++----------
 .../drm/amd/display/dc/link/link_factory.c    |   3 -
 .../dc/link/protocols/link_dp_capability.c    |  10 +-
 .../dc/link/protocols/link_dp_dpia_bw.c       |   5 -
 .../dc/resource/dcn20/dcn20_resource.c        |  28 ++-
 .../dc/resource/dcn201/dcn201_resource.c      |  30 ++--
 drivers/gpu/drm/amd/display/dmub/dmub_srv.h   |   1 +
 .../gpu/drm/amd/display/dmub/src/dmub_dcn31.c |   1 +
 .../gpu/drm/amd/display/dmub/src/dmub_dcn35.c |   1 +
 17 files changed, 144 insertions(+), 183 deletions(-)

--
2.43.0

