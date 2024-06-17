Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 40C23C2BA15
	for <amd-gfx@archiver.kernel.org>; Mon, 17 Jun 2024 14:29:06 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B891B10E3F3;
	Mon, 17 Jun 2024 14:29:05 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="1GYkek+J";
	dkim-atps=neutral
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2068.outbound.protection.outlook.com [40.107.94.68])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B952110E3F3
 for <amd-gfx@lists.freedesktop.org>; Mon, 17 Jun 2024 14:29:03 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Rw/SY6B8dIc7neLQtqcgySimuBeevxpLad4f8K8l1LY2qhIAHD4GTZJKbSrBkgZWI9Q6+c90DUwQI4BAFOVYkV12JIF6cKPWfJyfosUGUAzK2h1pjwPU7026+CjcWXzP6tj8SzKs5440tmoNI5pF1phCnSJLBu9lkeg/PODq4gS5wPDlQQh2lSwP5BiV42rOchi/g9h8WOY/FBHJMml2iS7ItNVZKUN99E0KLkMqeMfcxNCxw5HFYPDT9EPf/LPFRM0Pjzb1xbRHf7eUwfeeIXnSAR+AZR82jERUM2ncYiy+jiXTYou79zEaAbUuXSBQLgA1X5zCnHXlsCY7DKENAg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HsYGd8zQdSDNwl2r7of2HY10vrX3O3Lspgp0jFVafW0=;
 b=miIx2dGim3R67/9ZR3LyVcCvhLwILGvHvK+F726V+jlTI1YaHIRkH93tSxhW5RamflVaginFXEJPMWtgSI4Qmyl1J9CjgSdJ1IvcDe/32A9A8kbX7yT6R58bRN94lTHmssdD3Cr1irD3p8UXjCBRF6aZVbcu7yw/yWZM9zICVOotbtcdZU2nVVa1ptIlyHUNxAnnWTjn2vAdGbXh3DZsh9TrUCvYJdwF3ozIMNiivNM2JNf+YLf4YIgBD0TDtSOfNVTNtddu0OuWcxUONec9QW5417gox/vZbM6JN4QaZ6BJMcb8RZQ3REyO1P04MsMl/KOcXVA5M7KTutVl5AaNTQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HsYGd8zQdSDNwl2r7of2HY10vrX3O3Lspgp0jFVafW0=;
 b=1GYkek+JoNUgMMQraUg21rjyfgRF49EWvVEkKLVfn8zUL3esT/HQBg3A52Po3uy/NwDCvY5Hls89iBT2JorI/haFYY7ppZW+vJr4lo8MAtoQpBAf41I5WnJH/LRU1lNFkblHCtWm2/DTa6qfVRqNbSVAS6bT27BlLEdqS7iEii4=
Received: from DS0PR12MB6534.namprd12.prod.outlook.com (2603:10b6:8:c1::19) by
 PH7PR12MB7380.namprd12.prod.outlook.com (2603:10b6:510:20f::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.30; Mon, 17 Jun
 2024 14:28:58 +0000
Received: from DS0PR12MB6534.namprd12.prod.outlook.com
 ([fe80::ea87:74ba:36ec:8cf6]) by DS0PR12MB6534.namprd12.prod.outlook.com
 ([fe80::ea87:74ba:36ec:8cf6%4]) with mapi id 15.20.7633.036; Mon, 17 Jun 2024
 14:28:57 +0000
From: "Wheeler, Daniel" <Daniel.Wheeler@amd.com>
To: "Mahfooz, Hamza" <Hamza.Mahfooz@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
CC: "Wentland, Harry" <Harry.Wentland@amd.com>, "Li, Sun peng (Leo)"
 <Sunpeng.Li@amd.com>, "Lakha, Bhawanpreet" <Bhawanpreet.Lakha@amd.com>,
 "Siqueira, Rodrigo" <Rodrigo.Siqueira@amd.com>, "Pillai, Aurabindo"
 <Aurabindo.Pillai@amd.com>, "Zhuo, Lillian" <Qingqing.Zhuo@amd.com>, "Li,
 Roman" <Roman.Li@amd.com>, "Lin, Wayne" <Wayne.Lin@amd.com>, "Chiu, Solomon"
 <Solomon.Chiu@amd.com>, "Gutierrez, Agustin" <Agustin.Gutierrez@amd.com>,
 "Zuo, Jerry" <Jerry.Zuo@amd.com>
Subject: RE: [PATCH 00/36] DC Patches June 11, 2024
Thread-Topic: [PATCH 00/36] DC Patches June 11, 2024
Thread-Index: AQHavB+5zInzBGdv1UW+bOTA0HXwF7HMDMhw
Date: Mon, 17 Jun 2024 14:28:57 +0000
Message-ID: <DS0PR12MB6534BF565C5459A6E9B7265E9CCD2@DS0PR12MB6534.namprd12.prod.outlook.com>
References: <20240611165204.195093-1-hamza.mahfooz@amd.com>
In-Reply-To: <20240611165204.195093-1-hamza.mahfooz@amd.com>
Accept-Language: en-CA, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_0fec2151-cbe0-4586-8a3f-997880a38a28_ActionId=79ffb95a-7467-4311-b520-b33d0f15c796;
 MSIP_Label_0fec2151-cbe0-4586-8a3f-997880a38a28_ContentBits=0;
 MSIP_Label_0fec2151-cbe0-4586-8a3f-997880a38a28_Enabled=true;
 MSIP_Label_0fec2151-cbe0-4586-8a3f-997880a38a28_Method=Privileged;
 MSIP_Label_0fec2151-cbe0-4586-8a3f-997880a38a28_Name=Published AMD
 Product;
 MSIP_Label_0fec2151-cbe0-4586-8a3f-997880a38a28_SetDate=2024-06-17T14:28:03Z;
 MSIP_Label_0fec2151-cbe0-4586-8a3f-997880a38a28_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS0PR12MB6534:EE_|PH7PR12MB7380:EE_
x-ms-office365-filtering-correlation-id: 51162b0c-3087-487c-ade7-08dc8ed9d2f8
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230037|376011|1800799021|366013|38070700015;
x-microsoft-antispam-message-info: =?us-ascii?Q?PhHbH0A5jXwCM43ycJUoT+Nogfr8TIH7mC3aw8O4CnU+B7swF42+xydbfjJQ?=
 =?us-ascii?Q?Eetf0LrpHf3Y+bXUm+aUlUaIEhd6m13DmdNCBwIQyuiqHtUeoHKq6n0k5YmV?=
 =?us-ascii?Q?iQsXnmvcDxgJLgkEirCu0Ip0YpYq9tWYxcaE7DSQhVkbtXBPgKAJ0a2SzHoq?=
 =?us-ascii?Q?ZNsPrjWplIWUVEVr++pbo7kAx3NIIsbW2ueFI9EVlXoh9fSO/QBGZQmmzDMr?=
 =?us-ascii?Q?i9tCsbqo3fsi7llFSq+ajv82VEo5GDgSHL1E/lW+/OHJMvysl7+LsN/QnNws?=
 =?us-ascii?Q?BirSsTaza9G0gqK+yVcOSCLfp0KHUxTIbXZn58nJJdtAwT2Us69+Or4ohQ9t?=
 =?us-ascii?Q?1heDLYKg8txAn/IiJK1VKo5XCNdORMZHRtMlrPTWc+nwQinA9kohQEG4aVMl?=
 =?us-ascii?Q?YNQ2PsipOXaDkLBUlZ49arTbhPLj0o0Hw7weIPapqIn2W2ulp8o4BSWAjvc3?=
 =?us-ascii?Q?u2Jz2PIi/BHRx4JaHAtvBv8VVZIR0hj2vbbcHCDKxF6HIDZ6UTC84cjNQNa4?=
 =?us-ascii?Q?xXUWAmZV6wkYb8ktCNxOSJfuUqmnY4zQZe+lVtg5y+9XVIqQDt9G8tptUD00?=
 =?us-ascii?Q?JJE3IeBx+VxQ7AVjx9KBs80BT+Qyr++POe+S4O9+SobIqKo0iSgGS95AYuGM?=
 =?us-ascii?Q?2D/IUX3EM0Eq3Nf/RAV51T/Vb6Epnz297CIeIuu9TPMW4pNcZkWkp8ATXvk3?=
 =?us-ascii?Q?EX+YfjbwXEASRsceJF9Lp7hQl6i5XctiJyERlygwtafh0y6oNpexMKSQeH94?=
 =?us-ascii?Q?9OyX2p7j759VVpuQArt35G4UOCAgYKt+t0GPekQYFcMZF9D8zK1btUU31DE5?=
 =?us-ascii?Q?De6tFy/FQD8qoiG67o+1e4VaF4rO7dNB/Ba5FcoTdXjeSUyQDH8kQ94e2Zrq?=
 =?us-ascii?Q?HIsER/sZ9jzGluAnxbP5oUaWhyJehKYrq+iLP5D5BqAMYSI20F94Ol/rSwgq?=
 =?us-ascii?Q?ZOhBvDza5D2GbhyMXQsRRu3slgDlzmUwvbXt9JsaSafpCk5Z25KME+Ddo+UJ?=
 =?us-ascii?Q?WM63WgMDDQPJNs/eeQ9t/4bcm3OrTyt2i07IHvEV8EhZjGNhcg9lgQszeXfC?=
 =?us-ascii?Q?hx2mmBrkyVZgaXf1A3pzTfQJCtbR1L7jPjPNQ3aWRs9MhowBquoiltJFaL5P?=
 =?us-ascii?Q?jwSvEXN8EorCWc3ahosnFRY37bpVz/zSsixiOVPRHM+U/uqbwW4JQHRyrvDy?=
 =?us-ascii?Q?virAQa/I2i9WaZwib8eSrtXwxn4KwxabQbWTPSuSY7P2oAd71N/mRfcoYqJe?=
 =?us-ascii?Q?Moe4DjwGMxbpePc7elvkjl3SH3YMKa4Q0ng8XPEHi4/7Rmc66wOhC+pjC61q?=
 =?us-ascii?Q?lkFiQzwcomtx7sryOYwIioG1j7AUkFIbEf94sohrX0Fv46MxQ9D0tJsFV2zw?=
 =?us-ascii?Q?Y9SBHDk=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR12MB6534.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230037)(376011)(1800799021)(366013)(38070700015); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?dOZpZ+G8zUnvUcc2rEqFHge8X3JVYkC+XcuBMu88V+asWT+ngm55mhYo+l8x?=
 =?us-ascii?Q?BEAEc6hMA+Ghij4iipZ9HI0lmNN7JV7PZrLTOgCTZljpOk25WhOo6glQ7E4q?=
 =?us-ascii?Q?ho6BKEFpG/Puw2DuZH2gmlOLpWpkfhJIRnk9JzZ8btAyRpc3cr6JTFthzdeE?=
 =?us-ascii?Q?SfGNdAkPD5Z814wC5l2Ayou2ij4j2nZ1sD0n6yQswjMHJeYSDvXlbYRNBXWg?=
 =?us-ascii?Q?hqtVfvP6XkBddHJAJza1QAdYSD0vGryK8t8alJIHA6XDUpmXEkY1XTQ7m7Ex?=
 =?us-ascii?Q?DFqwbupuF8HVi0WCr1StcEtIJ+Nxb7CiRNZIewhNHk2ymhPprKw+tyapn0zp?=
 =?us-ascii?Q?zf1CvTAXGhL52lRjM8jgysoj1hKMK5khMUAkzReFDi+5zWrUcwSloqLMPpS6?=
 =?us-ascii?Q?1vueEH+99LWaMM/IOBdhwAAk7LV7fgZL2db6KftQN1lgHl1OGBRV6lIt5O17?=
 =?us-ascii?Q?uu/nnUA83rqVft6CCg6xPYxtcCxZuOdqcI772DRca2Uz95A6ZjTK1l7Iz9fD?=
 =?us-ascii?Q?XKWFQ2sl4RFmPeiU/+b5OMsmo2ZV0POoUXQWBF9ve1nZfxORgqKrKeJeK2SH?=
 =?us-ascii?Q?HoQ5VsnlDBO7/R/JuFRFrL3SIP92UOLnCw6xcUKz2NOgztVTLMpoTjE5184j?=
 =?us-ascii?Q?i+0ALwFAFZzDgXr0T6DDroxx36Wx8KCPPXPUmPrXqpPsqEVsox6hXUUq32SH?=
 =?us-ascii?Q?Mz3Dj2R69uPnins3zxbFwEixA5t+yvFRgee18HRqAJNjckRx2nBADHqXameQ?=
 =?us-ascii?Q?WDSVOh7AiEvYFvfXc4ripYoJCHZo6eYwsLEjdK73laminwLHR8fLIsiOfy9c?=
 =?us-ascii?Q?dzfEOdZNv43sWQTWsgn+QBPAYlM4fS3Hh6Tb4UWhr3/bo330Gh4X+yR0Y61j?=
 =?us-ascii?Q?PW1RBT4GE9BcXJaPRgRONecujysHtCjW+JohZNxVuOpvEfBG6T5LLWkSZlOk?=
 =?us-ascii?Q?vuXIZ5cPLDb6jiXySKWd48IM4sCyJPccjLWeZXn/TQtosQZChbKrFzp2JbMY?=
 =?us-ascii?Q?oDd7B1Zcxn0nrUphu0r5zaifSQhEMuX9GqTpC4hi6in2KxQm/LKCfuSIzed4?=
 =?us-ascii?Q?slFmYycdca6NwE0k624DyTyvN1hqff+e0zoP0Y/NT8JSkXPkxqPUg/iV9tLg?=
 =?us-ascii?Q?8mpMJfg62k796kIlJlDGPTB2uYTjhW8hUzAxlkwX+rRwn+onl4ICeKALtO75?=
 =?us-ascii?Q?RSy2NPlS0Wjfx3cHeguHuZ+EYcuJeYgJrkubW+FyD7Y2ipQ8LcGahP/NEx7Y?=
 =?us-ascii?Q?Qyh+fgQco+oaYmxfq2OTh/+rHXexzcw0li/BITaUTFo3FH4FTQY1OQc34gR/?=
 =?us-ascii?Q?4QVgH1rc8hmz/b6QNSDv9s7kIgKw97aSWbVi7GhTtYBnejkrYvcEWgpYX+E8?=
 =?us-ascii?Q?s5sDtsMnVQc4V0ZavaBbAWYPVRX4zAxysDkpjk8kCdikpB8x00UOjNnK9F+C?=
 =?us-ascii?Q?5aHosiPFsig2xIyto+rA91ex4ecJ+m5jU1cfnSHSvsCeqMTVyeqbIz6BGSPT?=
 =?us-ascii?Q?NAw4x5Q/u6u4q3WNji27ARHo+yb0k8aPNx67CpUNTzqV0ovYKet029oNlNH6?=
 =?us-ascii?Q?ZKUsr2/cS6mt7rqtHcU=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB6534.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 51162b0c-3087-487c-ade7-08dc8ed9d2f8
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Jun 2024 14:28:57.7887 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: BEG4V9S1Z9bCkExWkluioAk9Nt19QgwkRm3Xhd6Uw1yu/0Qeb4aQA035tngqCfoe1xcaphno8q/0VHL9VoWp9g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7380
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

The patchset consists of the amd-staging-drm-next branch (Head commit - 0a6=
4705ad8b13bb27909ec47bd6b3a4209eb37bd -> drm/amd/display: Disable PHYSYMCLK=
 RCO) with new patches added on top of it.

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
From: Mahfooz, Hamza <Hamza.Mahfooz@amd.com>
Sent: Tuesday, June 11, 2024 12:51 PM
To: amd-gfx@lists.freedesktop.org
Cc: Wheeler, Daniel <Daniel.Wheeler@amd.com>; Wentland, Harry <Harry.Wentla=
nd@amd.com>; Li, Sun peng (Leo) <Sunpeng.Li@amd.com>; Lakha, Bhawanpreet <B=
hawanpreet.Lakha@amd.com>; Siqueira, Rodrigo <Rodrigo.Siqueira@amd.com>; Pi=
llai, Aurabindo <Aurabindo.Pillai@amd.com>; Zhuo, Lillian <Qingqing.Zhuo@am=
d.com>; Li, Roman <Roman.Li@amd.com>; Lin, Wayne <Wayne.Lin@amd.com>; Chiu,=
 Solomon <Solomon.Chiu@amd.com>; Gutierrez, Agustin <Agustin.Gutierrez@amd.=
com>; Zuo, Jerry <Jerry.Zuo@amd.com>; Mahfooz, Hamza <Hamza.Mahfooz@amd.com=
>
Subject: [PATCH 00/36] DC Patches June 11, 2024

Cc: Daniel Wheeler <daniel.wheeler@amd.com>

Alex Hung (15):
  drm/amd/display: Explicitly extend unsigned 16 bit to 64 bit
  drm/amd/display: Add null checker before passing variables
  drm/amd/display: Check BIOS images before it is used
  drm/amd/display: Skip wbscl_set_scaler_filter if filter is null
  drm/amd/display: Add null checker before access structs
  drm/amd/display: Check dc_stream_state before it is used
  drm/amd/display: Check pipe_ctx before it is used
  drm/amd/display: Covert integers to double before divisions
  drm/amd/display: Remove redundant checks for res_pool->dccg
  drm/amd/display: Remove redundant checks for ctx->dc_bios
  drm/amd/display: Remove redundant null checks
  drm/amd/display: Remove redundant checks for opp
  drm/amd/display: Remove redundant checks for context
  drm/amd/display: Check UnboundedRequestEnabled's value
  drm/amd/display: Remove redundant null checks

Alvin Lee (1):
  drm/amd/display: Make sure to reprogram ODM when resync fifo

Anthony Koo (1):
  drm/amd/display: [FW Promotion] Release 0.0.222.0

Aric Cyr (1):
  drm/amd/display: 3.2.289

Chris Park (1):
  drm/amd/display: On clock init, maintain DISPCLK freq

Dillon Varone (2):
  drm/amd/display: Enable DCN401 idle optimizations by default
  drm/amd/display: Add null check to dml21_find_dc_pipes_for_plane

Ivan Lipski (3):
  drm/amd/display: Remove redundant condition with DEADCODE
  drm/amd/display: Remove redundant condition in VBA 314 func
  drm/amd/display: Remove unused value set from 'min_hratio_fact' in dml

Joshua Aberback (3):
  drm/amd/display: DCN401 full power down in HW init if any link enabled
  Revert "drm/amd/display: workaround for oled eDP not lighting up on
    DCN401"
  drm/amd/display: Remove duplicate HWSS interfaces

Michael Strauss (1):
  drm/amd/display: Attempt to avoid empty TUs when endpoint is DPIA

Mounika Adhuri (1):
  drm/amd/display: Refactor DCN3X into component folder

Relja Vojvodic (1):
  drm/amd/display: Add dcn401 DIG fifo enable/disable

Rodrigo Siqueira (3):
  drm/amd/display: Fix NULL pointer dereference for DTN log in DCN401
  drm/amd/display: Fix warning caused by an attempt to configure a
    non-otg master
  drm/amd/display: Improve warning log for get OPP for OTG master

Sridevi Arvindekar (1):
  drm/amd/display: mirror case cleanup for cursors

Sung Joon Kim (1):
  drm/amd/display: Send message to notify the DPIA host router bandwidth

Wenjing Liu (1):
  drm/amd/display: fix minor coding errors where dml21 phase 5 uses
    wrong variables

 drivers/gpu/drm/amd/display/Makefile          |   7 ++
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c |  19 +--
 .../amd/display/amdgpu_dm/amdgpu_dm_debugfs.c |   2 +-
 .../amd/display/amdgpu_dm/amdgpu_dm_helpers.c |   3 -
 drivers/gpu/drm/amd/display/dc/Makefile       |   6 +-
 .../gpu/drm/amd/display/dc/bios/bios_parser.c |  14 +++
 .../amd/display/dc/clk_mgr/dcn21/rn_clk_mgr.c |   2 +-
 .../display/dc/clk_mgr/dcn301/vg_clk_mgr.c    |   2 +-
 .../display/dc/clk_mgr/dcn31/dcn31_clk_mgr.c  |   2 +-
 .../dc/clk_mgr/dcn314/dcn314_clk_mgr.c        |   2 +-
 .../dc/clk_mgr/dcn315/dcn315_clk_mgr.c        |   2 +-
 .../dc/clk_mgr/dcn316/dcn316_clk_mgr.c        |   2 +-
 .../display/dc/clk_mgr/dcn32/dcn32_clk_mgr.c  |   2 +-
 .../display/dc/clk_mgr/dcn35/dcn35_clk_mgr.c  |  57 ++++++++-  .../amd/dis=
play/dc/clk_mgr/dcn35/dcn35_smu.c  |  21 +++-
 .../amd/display/dc/clk_mgr/dcn35/dcn35_smu.h  |   2 +
 .../dc/clk_mgr/dcn401/dcn401_clk_mgr.c        |  17 +++
 drivers/gpu/drm/amd/display/dc/core/dc.c      |  21 +++-
 .../drm/amd/display/dc/core/dc_hw_sequencer.c |   2 +-
 .../gpu/drm/amd/display/dc/core/dc_resource.c |  15 ++-
 .../gpu/drm/amd/display/dc/core/dc_state.c    |  24 ++--
 drivers/gpu/drm/amd/display/dc/dc.h           |   6 +-
 drivers/gpu/drm/amd/display/dc/dc_dmub_srv.c  |  20 +++-
 .../drm/amd/display/dc/dcn20/dcn20_dwb_scl.c  |   3 +
 drivers/gpu/drm/amd/display/dc/dcn32/Makefile |  19 ---
 .../gpu/drm/amd/display/dc/dcn321/Makefile    |  17 ---
 drivers/gpu/drm/amd/display/dc/dcn35/Makefile |  19 ---
 drivers/gpu/drm/amd/display/dc/dio/Makefile   |  63 ++++++++++
 .../{ =3D> dio}/dcn32/dcn32_dio_link_encoder.c  |   0
 .../{ =3D> dio}/dcn32/dcn32_dio_link_encoder.h  |   0
 .../dcn32/dcn32_dio_stream_encoder.c          |   0
 .../dcn32/dcn32_dio_stream_encoder.h          |   0
 .../dcn321/dcn321_dio_link_encoder.c          |   0
 .../dcn321/dcn321_dio_link_encoder.h          |   0
 .../{ =3D> dio}/dcn35/dcn35_dio_link_encoder.c  |   0
 .../{ =3D> dio}/dcn35/dcn35_dio_link_encoder.h  |   0
 .../dcn35/dcn35_dio_stream_encoder.c          |   4 +-
 .../dcn35/dcn35_dio_stream_encoder.h          |   6 +
 .../dcn401/dcn401_dio_link_encoder.c          |   0
 .../dcn401/dcn401_dio_link_encoder.h          |   0
 .../dcn401/dcn401_dio_stream_encoder.c        |   4 +-
 .../dcn401/dcn401_dio_stream_encoder.h        |   0
 .../drm/amd/display/dc/dml/calcs/dcn_calcs.c  |   2 +-
 .../drm/amd/display/dc/dml/dcn20/dcn20_fpu.c  |  20 ++--
 .../dc/dml/dcn20/display_mode_vba_20.c        |  16 +--
 .../dc/dml/dcn20/display_mode_vba_20v2.c      |   4 +-
 .../dc/dml/dcn20/display_rq_dlg_calc_20.c     |   5 -
 .../dc/dml/dcn20/display_rq_dlg_calc_20v2.c   |   5 -
 .../dc/dml/dcn21/display_mode_vba_21.c        |   2 +-
 .../dc/dml/dcn21/display_rq_dlg_calc_21.c     |   8 --
 .../dc/dml/dcn30/display_mode_vba_30.c        |   2 +-
 .../dc/dml/dcn30/display_rq_dlg_calc_30.c     |   5 -
 .../dc/dml/dcn31/display_mode_vba_31.c        |   4 +-
 .../dc/dml/dcn31/display_rq_dlg_calc_31.c     |   5 -
 .../dc/dml/dcn314/display_mode_vba_314.c      |  11 +-
 .../dc/dml/dcn314/display_rq_dlg_calc_314.c   |   5 -
 .../drm/amd/display/dc/dml/dcn32/dcn32_fpu.c  |  11 +-
 .../dc/dml/dcn32/display_mode_vba_util_32.c   |   8 +-
 .../display/dc/dml/dml1_display_rq_dlg_calc.c |   5 -
 .../amd/display/dc/dml2/display_mode_core.c   |  12 +-
 .../dc/dml2/dml21/dml21_translation_helper.c  |   4 +-
 .../amd/display/dc/dml2/dml21/dml21_utils.c   |  28 ++++-
 .../src/dml2_core/dml2_core_dcn4_calcs.c      |  28 ++---
 .../dml21/src/dml2_core/dml2_core_shared.c    |  24 ++--
 .../dml21/src/dml2_pmo/dml2_pmo_dcn4_fams2.c  |   5 +
 .../dc/dml2/dml21/src/dml2_top/dml_top.c      |   4 +-
 .../display/dc/dml2/dml2_dc_resource_mgmt.c   |   9 +-
 .../drm/amd/display/dc/dml2/dml2_wrapper.c    |   5 +-
 drivers/gpu/drm/amd/display/dc/dwb/Makefile   |  37 ++++++
 .../display/dc/{ =3D> dwb}/dcn35/dcn35_dwb.c    |   0
 .../display/dc/{ =3D> dwb}/dcn35/dcn35_dwb.h    |   0
 drivers/gpu/drm/amd/display/dc/hpo/Makefile   |  35 ++++++
 .../dcn32/dcn32_hpo_dp_link_encoder.c         |   0
 .../dcn32/dcn32_hpo_dp_link_encoder.h         |   0
 .../amd/display/dc/hwss/dce110/dce110_hwseq.c |   9 +-
 .../amd/display/dc/hwss/dcn10/dcn10_hwseq.c   |  61 +++++-----
 .../amd/display/dc/hwss/dcn10/dcn10_init.c    |   2 -
 .../amd/display/dc/hwss/dcn20/dcn20_hwseq.c   |  11 +-
 .../amd/display/dc/hwss/dcn20/dcn20_init.c    |   1 -
 .../amd/display/dc/hwss/dcn201/dcn201_hwseq.c |   5 +-
 .../amd/display/dc/hwss/dcn201/dcn201_init.c  |   1 -
 .../amd/display/dc/hwss/dcn21/dcn21_init.c    |   2 -
 .../amd/display/dc/hwss/dcn30/dcn30_hwseq.c   |  10 +-
 .../amd/display/dc/hwss/dcn30/dcn30_init.c    |   1 -
 .../amd/display/dc/hwss/dcn301/dcn301_init.c  |   1 -
 .../amd/display/dc/hwss/dcn31/dcn31_hwseq.c   |   2 +-
 .../amd/display/dc/hwss/dcn31/dcn31_init.c    |   2 -
 .../amd/display/dc/hwss/dcn314/dcn314_hwseq.c |  19 ++-
 .../amd/display/dc/hwss/dcn314/dcn314_init.c  |   2 -
 .../amd/display/dc/hwss/dcn32/dcn32_hwseq.c   | 110 ++++++++++--------
 .../amd/display/dc/hwss/dcn32/dcn32_init.c    |   1 -
 .../amd/display/dc/hwss/dcn35/dcn35_hwseq.c   |  82 ++++++++++++-
 .../amd/display/dc/hwss/dcn35/dcn35_hwseq.h   |   2 +
 .../amd/display/dc/hwss/dcn35/dcn35_init.c    |   4 +-
 .../amd/display/dc/hwss/dcn351/dcn351_init.c  |   2 -
 .../amd/display/dc/hwss/dcn401/dcn401_hwseq.c |  75 ++++++------
 .../amd/display/dc/hwss/dcn401/dcn401_init.c  |   1 -
 .../drm/amd/display/dc/hwss/hw_sequencer.h    |   1 -
 .../display/dc/hwss/hw_sequencer_private.h    |   2 -
 .../link/protocols/link_edp_panel_control.c   |   3 -
 .../gpu/drm/amd/display/dc/mmhubbub/Makefile  |  45 +++++++
 .../dc/{ =3D> mmhubbub}/dcn32/dcn32_mmhubbub.c  |   0
 .../dc/{ =3D> mmhubbub}/dcn32/dcn32_mmhubbub.h  |   0
 .../dc/{ =3D> mmhubbub}/dcn35/dcn35_mmhubbub.c  |   0
 .../dc/{ =3D> mmhubbub}/dcn35/dcn35_mmhubbub.h  |   0
 drivers/gpu/drm/amd/display/dc/mpc/Makefile   |  45 +++++++
 .../display/dc/{ =3D> mpc}/dcn32/dcn32_mpc.c    |   0
 .../display/dc/{ =3D> mpc}/dcn32/dcn32_mpc.h    |   0
 .../display/dc/{ =3D> mpc}/dcn401/dcn401_mpc.c  |   0
 .../display/dc/{ =3D> mpc}/dcn401/dcn401_mpc.h  |   0
 drivers/gpu/drm/amd/display/dc/opp/Makefile   |  35 ++++++
 .../display/dc/{ =3D> opp}/dcn35/dcn35_opp.c    |   0
 .../display/dc/{ =3D> opp}/dcn35/dcn35_opp.h    |   0
 drivers/gpu/drm/amd/display/dc/pg/Makefile    |  35 ++++++
 .../display/dc/{ =3D> pg}/dcn35/dcn35_pg_cntl.c |   0
 .../display/dc/{ =3D> pg}/dcn35/dcn35_pg_cntl.h |   0
 .../gpu/drm/amd/display/dc/resource/Makefile  |   2 +-
 .../dc/resource/dcn20/dcn20_resource.c        |   2 +-
 .../dc/resource/dcn201/dcn201_resource.c      |   4 +-
 .../dc/resource/dcn32/dcn32_resource.c        |   2 +
 .../dcn32/dcn32_resource_helpers.c            |   0
 .../dc/resource/dcn351/dcn351_resource.c      |   1 +
 .../dc/resource/dcn401/dcn401_resource.c      |   3 -
 .../gpu/drm/amd/display/dmub/inc/dmub_cmd.h   |   9 +-
 124 files changed, 880 insertions(+), 409 deletions(-)  delete mode 100644=
 drivers/gpu/drm/amd/display/dc/dcn32/Makefile
 delete mode 100644 drivers/gpu/drm/amd/display/dc/dcn321/Makefile
 delete mode 100644 drivers/gpu/drm/amd/display/dc/dcn35/Makefile
 create mode 100644 drivers/gpu/drm/amd/display/dc/dio/Makefile
 rename drivers/gpu/drm/amd/display/dc/{ =3D> dio}/dcn32/dcn32_dio_link_enc=
oder.c (100%)  rename drivers/gpu/drm/amd/display/dc/{ =3D> dio}/dcn32/dcn3=
2_dio_link_encoder.h (100%)  rename drivers/gpu/drm/amd/display/dc/{ =3D> d=
io}/dcn32/dcn32_dio_stream_encoder.c (100%)  rename drivers/gpu/drm/amd/dis=
play/dc/{ =3D> dio}/dcn32/dcn32_dio_stream_encoder.h (100%)  rename drivers=
/gpu/drm/amd/display/dc/{ =3D> dio}/dcn321/dcn321_dio_link_encoder.c (100%)=
  rename drivers/gpu/drm/amd/display/dc/{ =3D> dio}/dcn321/dcn321_dio_link_=
encoder.h (100%)  rename drivers/gpu/drm/amd/display/dc/{ =3D> dio}/dcn35/d=
cn35_dio_link_encoder.c (100%)  rename drivers/gpu/drm/amd/display/dc/{ =3D=
> dio}/dcn35/dcn35_dio_link_encoder.h (100%)  rename drivers/gpu/drm/amd/di=
splay/dc/{ =3D> dio}/dcn35/dcn35_dio_stream_encoder.c (99%)  rename drivers=
/gpu/drm/amd/display/dc/{ =3D> dio}/dcn35/dcn35_dio_stream_encoder.h (99%) =
 rename drivers/gpu/drm/amd/display/dc/{ =3D> dio}/dcn401/dcn401_dio_link_e=
ncoder.c (100%)  rename drivers/gpu/drm/amd/display/dc/{ =3D> dio}/dcn401/d=
cn401_dio_link_encoder.h (100%)  rename drivers/gpu/drm/amd/display/dc/{ =
=3D> dio}/dcn401/dcn401_dio_stream_encoder.c (99%)  rename drivers/gpu/drm/=
amd/display/dc/{ =3D> dio}/dcn401/dcn401_dio_stream_encoder.h (100%)  creat=
e mode 100644 drivers/gpu/drm/amd/display/dc/dwb/Makefile
 rename drivers/gpu/drm/amd/display/dc/{ =3D> dwb}/dcn35/dcn35_dwb.c (100%)=
  rename drivers/gpu/drm/amd/display/dc/{ =3D> dwb}/dcn35/dcn35_dwb.h (100%=
)  create mode 100644 drivers/gpu/drm/amd/display/dc/hpo/Makefile
 rename drivers/gpu/drm/amd/display/dc/{ =3D> hpo}/dcn32/dcn32_hpo_dp_link_=
encoder.c (100%)  rename drivers/gpu/drm/amd/display/dc/{ =3D> hpo}/dcn32/d=
cn32_hpo_dp_link_encoder.h (100%)  create mode 100644 drivers/gpu/drm/amd/d=
isplay/dc/mmhubbub/Makefile
 rename drivers/gpu/drm/amd/display/dc/{ =3D> mmhubbub}/dcn32/dcn32_mmhubbu=
b.c (100%)  rename drivers/gpu/drm/amd/display/dc/{ =3D> mmhubbub}/dcn32/dc=
n32_mmhubbub.h (100%)  rename drivers/gpu/drm/amd/display/dc/{ =3D> mmhubbu=
b}/dcn35/dcn35_mmhubbub.c (100%)  rename drivers/gpu/drm/amd/display/dc/{ =
=3D> mmhubbub}/dcn35/dcn35_mmhubbub.h (100%)  create mode 100644 drivers/gp=
u/drm/amd/display/dc/mpc/Makefile
 rename drivers/gpu/drm/amd/display/dc/{ =3D> mpc}/dcn32/dcn32_mpc.c (100%)=
  rename drivers/gpu/drm/amd/display/dc/{ =3D> mpc}/dcn32/dcn32_mpc.h (100%=
)  rename drivers/gpu/drm/amd/display/dc/{ =3D> mpc}/dcn401/dcn401_mpc.c (1=
00%)  rename drivers/gpu/drm/amd/display/dc/{ =3D> mpc}/dcn401/dcn401_mpc.h=
 (100%)  create mode 100644 drivers/gpu/drm/amd/display/dc/opp/Makefile
 rename drivers/gpu/drm/amd/display/dc/{ =3D> opp}/dcn35/dcn35_opp.c (100%)=
  rename drivers/gpu/drm/amd/display/dc/{ =3D> opp}/dcn35/dcn35_opp.h (100%=
)  create mode 100644 drivers/gpu/drm/amd/display/dc/pg/Makefile
 rename drivers/gpu/drm/amd/display/dc/{ =3D> pg}/dcn35/dcn35_pg_cntl.c (10=
0%)  rename drivers/gpu/drm/amd/display/dc/{ =3D> pg}/dcn35/dcn35_pg_cntl.h=
 (100%)  rename drivers/gpu/drm/amd/display/dc/{ =3D> resource}/dcn32/dcn32=
_resource_helpers.c (100%)

--
2.45.1

