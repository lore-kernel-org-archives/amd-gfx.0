Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C10BD606B1D0
	for <amd-gfx@archiver.kernel.org>; Mon,  2 Nov 2026 14:23:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=3z4g5GQT
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5DEF410EF05;
	Mon,  2 Nov 2026 14:23:04 +0000 (UTC)
Received: from BN1PR04CU002.outbound.protection.outlook.com
 (mail-eastus2azon11010009.outbound.protection.outlook.com [52.101.56.9])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C75AB10EF05
 for <amd-gfx@lists.freedesktop.org>; Mon,  2 Nov 2026 14:22:58 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mylgNn0V3Mz1VSR/PPaiowiARSnWHfYgtLz/ekxtZnI+9MYfSBwtFxHtUa4jsHMdcjVoMfpT7+8zMCIcuE7DaPW2Ff8HcC20L9TJmZ5cGXCPMPctehfgFfxkUwNLktEQX4ItqJfXrEZ47DdWWmDJ+BBGSc8I5ELvhmKN2+L4l5BLYsowScjbkyumuuHqnPnerZystUSQR1ztFy5RIhGsQI8DuMfRulLgfqRq/Q/hQJXJsicqCuoYhi+5CPDpzNiAh0tzHa6Z+Pc3aeq4nT/GxVFA77mtsVYSMlyI2rcKhMRhSfTgEXDX5sOP6JniiMNeh0ENypN4BcyoOmZd/BNhCg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oyZa68TbZAr+bVavoMSKAz+TNLfyKjsdMWkexJ0rTlU=;
 b=WLV1JgxCcFwbtOLbp0cIzMX7QMpGKjj6ZoAgzGXkmJkhXkj65/sdkpUGv3NoL5cXuSNO/y8WzqfqLe2uCoHj35aM5VSZ+uOiGYi7LKSnabTNhiGb7yf0I+z9UKkHH4bhFsYHQjlOEM9u7Wb+dPASf1iVtHvpoRQm52LOgHcfAijcWp1dR0JAh11+bctjtfbz+NxiZmCYse6D32EW3cllMwW7G1jjaa29PR1hNCXFiulIB8mVCmhvZXghLFJeOuDHD6oO+CZXAmBfTuciNlt/wDmzwIixfZ6mDrjI+/9ABGiIv43ixaoWdAS99O8hM/dJZtiD8rk9f7P7Zbp/svu2sg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oyZa68TbZAr+bVavoMSKAz+TNLfyKjsdMWkexJ0rTlU=;
 b=3z4g5GQTlTllLCftkClh9XibmUpxGXueLrsA/KDED3rCDsRgX4iBhHEd4sbGb7+LqLTgskevVVm+yrteiZDkUo6Mc4J6HuKDFn9pNIilD7ewxMjOxQK0Q1jvOld494rmom7Zyb6gn+f0lqk5n6Z9iCgJgM5jmQ5VNnv1gjDn4tc=
Received: from DS0PR12MB6534.namprd12.prod.outlook.com (2603:10b6:8:c1::19) by
 MW4PR12MB7030.namprd12.prod.outlook.com (2603:10b6:303:20a::8) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.569.12; Mon, 2 Nov 2026 14:22:52 +0000
Received: from DS0PR12MB6534.namprd12.prod.outlook.com
 ([fe80::b2e1:64e5:3b9e:738a]) by DS0PR12MB6534.namprd12.prod.outlook.com
 ([fe80::b2e1:64e5:3b9e:738a%4]) with mapi id 15.21.0569.011; Mon, 2 Nov 2026
 14:22:52 +0000
From: "Wheeler, Daniel" <Daniel.Wheeler@amd.com>
To: "Hung, Alex" <Alex.Hung@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
CC: "Wentland, Harry" <Harry.Wentland@amd.com>, "Li, Sun peng (Leo)"
 <Sunpeng.Li@amd.com>, "Pillai, Aurabindo" <Aurabindo.Pillai@amd.com>, "Li,
 Roman" <Roman.Li@amd.com>, "Lin, Wayne" <Wayne.Lin@amd.com>, "Chung,
 ChiaHsuan (Tom)" <ChiaHsuan.Chung@amd.com>, "Zuo, Jerry" <Jerry.Zuo@amd.com>, 
 "Wu, Ray" <Ray.Wu@amd.com>, "LIPSKI, IVAN" <IVAN.LIPSKI@amd.com>, "Lin, Ping
 Lei" <PingLei.Lin@amd.com>, "Chen, Chen-Yu" <Chen-Yu.Chen@amd.com>
Subject: RE: [PATCH 00/28] DC Patches Oct 27, 2026
Thread-Topic: [PATCH 00/28] DC Patches Oct 27, 2026
Thread-Index: AQHdZmnAGNrG34Aiiku5F9DoSThY/7ca3kzQ
Date: Mon, 2 Nov 2026 14:22:51 +0000
Message-ID: <DS0PR12MB6534C498DC92EB6A6FB7FA779C6A2@DS0PR12MB6534.namprd12.prod.outlook.com>
References: <20261027232005.2879750-1-alex.hung@amd.com>
In-Reply-To: <20261027232005.2879750-1-alex.hung@amd.com>
Accept-Language: en-CA, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_2d0b1989-8fc8-4a69-bcac-d46889461ba5_Enabled=True;
 MSIP_Label_2d0b1989-8fc8-4a69-bcac-d46889461ba5_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_2d0b1989-8fc8-4a69-bcac-d46889461ba5_SetDate=2026-11-02T14:22:46.0000000Z;
 MSIP_Label_2d0b1989-8fc8-4a69-bcac-d46889461ba5_Name=AMD Public
 v26; MSIP_Label_2d0b1989-8fc8-4a69-bcac-d46889461ba5_ContentBits=3;
 MSIP_Label_2d0b1989-8fc8-4a69-bcac-d46889461ba5_Method=Privileged
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS0PR12MB6534:EE_|MW4PR12MB7030:EE_
x-ms-office365-filtering-correlation-id: 02b13d04-4b73-40de-a99c-08df38ecc772
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|366016|1800799024|23010399003|6133799003|10067099003|18002099003|22082099003|18092099006|10086099003|3023799007|38070700021|56012099006|11063799006|261021121427099003|261022075727099003|261022105027099003|261026121527099003|261022113327099003|261026140227099003|261009223027099003|261028144727099003|261021135927099003|261021123027099003;
x-microsoft-antispam-message-info: F6lEbiQ6uFd1rqonl0new1aQWntxe5nRgyb8b4KI4qbBBjgdPo3Esw8/aooUQgWltVu+Gl+LHP/Yana5+NT0wBzAMxMla2qvl77DaKmSGDPlACAh1pvjF4f+mKhIcy3j1YiK6L3baCskRjLBTQS8MEqyRrQbe8uY2MyS7enOIgsep8JaKpc6uhX2Ve5Obhw52BZHOMGTk2cCIeP6/gJ8iFrYJm/gjL0/E9Lgkj9y1nZEg6h6itE99UKx97hft9klg7gBeDzjnQ9qymxZktnONBzl55akHpVNzEyjCo1bHfAVRXoGAl1LtpDHUC9EigVSL+qBgjhPjl/DVMoM6/KridrRwcHXeC6N8mkXO3N3L9m0vAPiaVcG8y5oePt7iZATxXLB3g04hOCyPRfLCcpf7qS3R0nTuuo860tKU6N/lFC1zvHsZ5BBkp8Zwq0ZJAHTLPCXwA7is/ufu7ge2D7CNvhVbe6rT8ERq/+xnGuHjUVnWhVtB7I6iOSu+m5vMQeppoC1Bwav/YfTzyb/elHl9b0EsDuncQrd2GZ+ji3vwr0OLXUj6i+GSKCunC5JbmkupwwUsns6kCPankyg+UxmVEJtJez+ztaX0eVD7B+mOwZObPltp5cT1Xlm8bLnbkxqgKBIXNjGuvkO6B/X8s0EKeE7wECQxS7e3IViYiWLaSgi2kMf+UhoeXnBnmNFnWPaOronUwoML9JvFgPSMymyxAxuO8g6QuCGb+4kPKJ8QMU=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR12MB6534.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(23010399003)(6133799003)(10067099003)(18002099003)(22082099003)(18092099006)(10086099003)(3023799007)(38070700021)(56012099006)(11063799006)(261021121427099003)(261022075727099003)(261022105027099003)(261026121527099003)(261022113327099003)(261026140227099003)(261009223027099003)(261028144727099003)(261021135927099003)(261021123027099003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?u8/D/McKjN9xWThwfKS57chDun+xcXQv+8dVDQG5gzDwjt6+UGPGi/x7cG?=
 =?iso-8859-1?Q?uccI040kVdIfmOdNap3HLj4V5T04GfLqmuqDEIhgrIeZmJ83Arw92Zw3rN?=
 =?iso-8859-1?Q?tRmgri8W9wM44chYnXn8hMkVdkyEygSGkR5ePxwHy1UNnqpd6XQzGdLPbD?=
 =?iso-8859-1?Q?HAJYDhAgyV7WMYSLhmgkfPMAZ2ZBJ3m5HLxKI6jmT+B9tkQslqe1M7Lvhd?=
 =?iso-8859-1?Q?pXDkuTqUPaiyyxXFJE3NgvAUjkEZJzATHdn01F3H0RtWCej9hw2sRnNTV4?=
 =?iso-8859-1?Q?jL+YfHmIbpONOwqam4RierZrga3KCTRTCT8Js6LORT069/3/b8063Vlncr?=
 =?iso-8859-1?Q?+wh80EH0aqO1rRW1mrX6OSoTBYTLeiyuGpZ9waTdMrMbLJvjjKHuzQUQrI?=
 =?iso-8859-1?Q?onFA8ZyQjbY7OEw+owMsrNAZzOqmyw5/axl3j3lbMdSDRixR66lkojNQrL?=
 =?iso-8859-1?Q?46qDNocL0TDzYI/kKK3iMcARnuJtxPUd6anzRGrlGowaRjrQwPb6iRQBaU?=
 =?iso-8859-1?Q?9FurJ4a7R78KmLckVmGtGlXzppKoKuUvgq4EPTx8fKBqa7xmLm/ZZnkUJF?=
 =?iso-8859-1?Q?OrdcmLQTe+70ldffZU9ZHFVfL6PNypTyRGZcOrYL4VsQZqPURqp4+c5AgG?=
 =?iso-8859-1?Q?/2viBDMhkIZ2ndvsPVlpr6TCh6/rvZsv3RdfXK/A3Yo94Bfp6MLjf5aPqo?=
 =?iso-8859-1?Q?97Id8imEWU0svhB335txtvq1AKE17fk/RjzqAJse1IA4iqw8VZJJPaY4qZ?=
 =?iso-8859-1?Q?DLPMThrK27jygLcDQolQUoaDjjsaYcbfI+vBFjwst8ajdoWy6zs12LiL1P?=
 =?iso-8859-1?Q?Q0SYwTZ/70hroDzrdeV0EGnZCgVdtUDUcA90n2eVQAf68jg/6FrCJiHMQL?=
 =?iso-8859-1?Q?eQkJGFjxWO5z2hSlA01cxtIHtR1+FfPuJlyGFKCu5q/6EkTad+VwhvZLHT?=
 =?iso-8859-1?Q?9M+75hnJcWv1MPfCD0+wgAkbyKzV3EL5d5a3IKUCdSXV3fF+L5ndNepz6N?=
 =?iso-8859-1?Q?9gkXfKDyANPrkTvH0Vmm3W+3oFCB4rihQNICozZRB30EDnzFJk/S2fe+6Z?=
 =?iso-8859-1?Q?zurCyK5elomZ+q5Rl/VtbTg/N3xidPUrfFAbvKC7yClsH4yeoWCzSD7J0K?=
 =?iso-8859-1?Q?z4MDag3PXGB0+VTuRFgKsBJbWDXz9RCPkgS9MFKR1LLPI1eeDyfTnXxdo4?=
 =?iso-8859-1?Q?tuiWEtK/yJB89qhhMkXFswao0onDhmvlmO+tCbZF6FugAvt5MzXVr84077?=
 =?iso-8859-1?Q?7RU+Uv4jkTeTIydqo7aHCwrrYOJxzfNOp+P+MY6RnHeHhG8kxj8BvJgYn+?=
 =?iso-8859-1?Q?/t/Kbml16Yz0hDWLHvdnTUpjAWsHHRu+JfmNQN4GSFBuDI++8qXJJO4Z7Z?=
 =?iso-8859-1?Q?VRb2Ujf3LAvBE44Xl6muf79mEDoDHFCItktd9eBrCpHq+YxBeFBzIpl+lc?=
 =?iso-8859-1?Q?BXZf86zY+KbQ7xCWTOdTYZUzAjVAGo6G2r1b+H8ObKaFxYI5WYwEpQrjvF?=
 =?iso-8859-1?Q?0KLYzP66AsvL7xhqXnQH9NR87jcvSQPqIWyhY4zGr6H5PM7sVP23SCLTQU?=
 =?iso-8859-1?Q?RGbjiGPju9vgRkkFog3pX+IJwN9iJPRySCX6xrs5h4j3vtp5F/ggK2J49V?=
 =?iso-8859-1?Q?Nr1a9LNlsDRbaOnDefCMEfs8BuM4rymmjpls4BBmvsBiphq46e9cmsNzqb?=
 =?iso-8859-1?Q?ycWRv6Eebx14zhTQE/Oq8g/F1zGw+3+Ppo7xjdAHCQ1KfDQ9gXRlKWDYzV?=
 =?iso-8859-1?Q?w7u5LDvuBwcNCOwNboDSPvy6lUcJj3vvcZqyvOM2FNYpyq?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB6534.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 02b13d04-4b73-40de-a99c-08df38ecc772
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Nov 2026 14:22:51.8889 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 4w40K7X7Gbzpl8Y3WWJqus0gp6Dz3isYgG2qp/thVChTWoTnp8UHsJy3aGt8jX6crS6KF33Hn7h8VjBIcxaFmQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB7030
X-BeenThere: amd-gfx@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Discussion list for AMD gfx <amd-gfx.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/amd-gfx>
List-Post: <mailto:amd-gfx@lists.freedesktop.org>
List-Help: <mailto:amd-gfx-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/amd-gfx>,
 <mailto:amd-gfx-request@lists.freedesktop.org?subject=subscribe>
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

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


The patchset consists of the amd-staging-drm-next branch (Head commit -> ba=
496bb837882eb1af58f41572fc289e46c77b8c -> drm/radeon: retry UVD v1 init on =
failure after resume) with new patches added on top of it.

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
From: Hung, Alex <Alex.Hung@amd.com>
Sent: Tuesday, October 27, 2026 7:17 PM
To: amd-gfx@lists.freedesktop.org
Cc: Wentland, Harry <Harry.Wentland@amd.com>; Li, Sun peng (Leo) <Sunpeng.L=
i@amd.com>; Pillai, Aurabindo <Aurabindo.Pillai@amd.com>; Li, Roman <Roman.=
Li@amd.com>; Lin, Wayne <Wayne.Lin@amd.com>; Chung, ChiaHsuan (Tom) <ChiaHs=
uan.Chung@amd.com>; Zuo, Jerry <Jerry.Zuo@amd.com>; Wheeler, Daniel <Daniel=
.Wheeler@amd.com>; Wu, Ray <Ray.Wu@amd.com>; LIPSKI, IVAN <IVAN.LIPSKI@amd.=
com>; Hung, Alex <Alex.Hung@amd.com>; Lin, Ping Lei <PingLei.Lin@amd.com>; =
Chen, Chen-Yu <Chen-Yu.Chen@amd.com>
Subject: [PATCH 00/28] DC Patches Oct 27, 2026

This DC patchset brings improvements in multiple areas. In summary, we have=
:

* Fixes on mode detection, DSC with DPMS off and HUBP DET reset
* Fixes on DDC pins and missing OTG_CRC1 regs for DCN3.1.x
* Improvements on DCN6 FAMS immediate restore and PPCLK_e enum
* Improvements on DSCCLK check and DSC slice calc policy
* Improvements on Replay frame update interval and debug mode
* Improvements on DML VM rounding and P-State optimizer
* Removal of DCN401 RDPCS PHY state reads
* New debug options for HDMI VRR and visual confirm
* More KUnit tests for connector, CRC, color and backlight

Cc: Dan Wheeler <daniel.wheeler@amd.com>

Alex Hung (5):
  drm/amd/display: Avoid closing unowned DDC pins
  drm/amd/display: Add more backlight Kunit tests
  drm/amd/display: Add more color KUnit tests
  drm/amd/display: Add more CRC KUnit tests
  drm/amd/display: Add more connector KUnit tests

Allen Li (1):
  drm/amd/display: Allow bypassing link_off_frame_count check for replay
    debug mode

Alvin Lee (4):
  drm/amd/display: Add visual confirm full viewport debug option
  drm/amd/display: Indicate wait_resp based on FAMS even in disable path
  drm/amd/display: Enable immediate restore for FAMS on DCN6
  drm/amd/display: Update alt shared lib to use dynamic state

Austin Zheng (2):
  drm/amd/display: Update Rounding For VM stage groups
  drm/amd/display: Parameterize FCLK/PPT/Temp Read P-State Optimizer

Dmitry Artemenko (2):
  drm/amd/display: Add missing OTG_CRC1 reg/mask entries for DCN3.1.4
  drm/amd/display: Add missing OTG_CRC1 reg/mask entries for DCN3.1.2

Dominik Kaszewski (1):
  drm/amd/display: Clarify endianness error

Fangzhi Zuo (2):
  drm/amd/display: Fix unadvertised mode detection
  drm/amd/display: Add debugfs override for HDMI VRR

George Shen (1):
  drm/amd/display: Skip dsc sequence for stream if dpms off

Ilya Bakoulin (2):
  drm/amd/display: Adjust DSC slice calc. policy
  drm/amd/display: Expand DSCCLK support check

Ivan Lipski (2):
  drm/amd/display: Use DCN6 driver_if for PPCLK_e enum
  drm/amd/display: Configure alternate-channel apertures

Meenakshikumar Somasundaram (1):
  drm/amd/display: Support replay frame update interval

Rafal Ostrowski (1):
  drm/amd/display: Decouple FAMS2 config update from dc/dc_state and add
    BLS opcode

Roman Li (1):
  drm/amd/display: Reset DET of HUBPs without a plane before outstanding
    updates

Taimur Hassan (2):
  drm/amd/display: [FW Promotion] Release 0.1.82.0
  drm/amd/display: Promote DC to 3.2.405

Tony Cheng (1):
  drm/amd/display: Remove DCN401 RDPCS PHY state reads

 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h |   7 +
 .../display/amdgpu_dm/amdgpu_dm_connector.c   | 110 +++++++++++++---
 .../amd/display/amdgpu_dm/amdgpu_dm_debugfs.c |  30 +++++
 .../amd/display/amdgpu_dm/amdgpu_dm_dmub.c    |  63 +++++++++
 .../display/amdgpu_dm/amdgpu_dm_freesync.c    |   2 +-
 .../tests/amdgpu_dm_backlight_test.c          |  79 ++++++++++-
 .../amdgpu_dm/tests/amdgpu_dm_color_test.c    |  18 +++
 .../tests/amdgpu_dm_connector_test.c          | 118 +++++++++++++++--
 .../amdgpu_dm/tests/amdgpu_dm_crc_test.c      | 124 ++++++++++++++++++
 .../display/dc/clk_mgr/dcn60/dcn60_clk_mgr.c  |  37 +++++-
 drivers/gpu/drm/amd/display/dc/core/dc.c      |   6 +-
 .../drm/amd/display/dc/core/dc_hw_sequencer.c |  69 ++++++++++  .../gpu/dr=
m/amd/display/dc/core/dc_resource.c |  47 ++++++-
 drivers/gpu/drm/amd/display/dc/dc.h           |   4 +-
 drivers/gpu/drm/amd/display/dc/dc_dmub_srv.c  | 113 ++++++++--------  driv=
ers/gpu/drm/amd/display/dc/dc_dmub_srv.h  |  27 +++-
 drivers/gpu/drm/amd/display/dc/dc_types.h     |   3 +
 .../gpu/drm/amd/display/dc/dce/dmub_replay.c  |   1 +
 .../gpu/drm/amd/display/dc/dce/dmub_replay.h  |   1 -
 .../dc/dcn10/dcn10_hw_sequencer_debug.c       |  16 +--
 .../dc/dio/dcn401/dcn401_dio_link_encoder.c   |  22 +---
 .../dc/dio/dcn401/dcn401_dio_link_encoder.h   |   8 --
 .../dml2_core/dml2_core_dcn5_calcs_dchub.c    |   2 +-
 .../dml2_core_dcn5_funcs_mode_support.c       |  24 +++-
 .../dml2_core_dcn6_funcs_mode_programming.c   |   1 +
 .../dml2_core_dcn6_funcs_mode_support.c       |  19 ++-
 .../dml2_pmo/dml2_pmo_dcn6_stage_optimizers.c |  25 ++--
 .../alternate_pstate_shared_lib.c             |   2 +-
 .../alternate_pstate_shared_lib.h             |   1 +
 .../dml2_utm_soc_bb/dml2_utm_soc_bb_dcn5.c    |   1 +
 .../dml2_utm_soc_bb/dml2_utm_soc_bb_dcn6.c    |   1 +
 .../src/inc/dml2_internal_shared_types.h      |   4 +
 drivers/gpu/drm/amd/display/dc/dsc/dc_dsc.c   |  24 +++-
 .../drm/amd/display/dc/dsc/dcn60/dcn60_dsc.c  |   1 +
 drivers/gpu/drm/amd/display/dc/dsc/dsc.h      |   1 +
 .../amd/display/dc/hwss/dcn401/dcn401_hwseq.c |  64 ++++++---
 .../amd/display/dc/hwss/dcn401/dcn401_hwseq.h |   4 +-
 .../amd/display/dc/hwss/dcn401/dcn401_init.c  |   2 +-
 .../amd/display/dc/hwss/dcn42/dcn42_init.c    |   2 +-
 .../amd/display/dc/hwss/dcn60/dcn60_init.c    |   2 +-
 .../drm/amd/display/dc/hwss/hw_sequencer.h    |  20 ++-
 .../drm/amd/display/dc/inc/hw/link_encoder.h  |   2 -
 .../dc/link/protocols/link_dp_capability.c    |   6 +-
 .../amd/display/dc/optc/dcn31/dcn31_optc.h    |  18 +++
 .../amd/display/dc/optc/dcn314/dcn314_optc.h  |  18 +++
 .../dc/resource/dcn401/dcn401_resource.c      |  10 +-
 .../dc/resource/dcn60/dcn60_resource.c        |   1 +
 .../gpu/drm/amd/display/dmub/inc/dmub_cmd.h   |  31 ++++-
 .../amd/display/include/link_service_types.h  |   2 +-
 49 files changed, 987 insertions(+), 206 deletions(-)

--
2.53.0

