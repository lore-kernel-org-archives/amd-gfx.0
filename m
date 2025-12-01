Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D8F99D116F5
	for <amd-gfx@archiver.kernel.org>; Mon,  1 Dec 2025 13:08:26 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8472D10E3CA;
	Mon,  1 Dec 2025 13:08:26 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="3benX6LX";
	dkim-atps=neutral
Received: from PH7PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11010029.outbound.protection.outlook.com [52.101.201.29])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DA0FE10E3CA
 for <amd-gfx@lists.freedesktop.org>; Mon,  1 Dec 2025 13:08:24 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=eP7JFLO43QyJh+k/SezvIsbkzg38XHEp9gh7Duo2iZQWQPVZmvcJ9kN7/0whqRsWO1y7TgPIJrvSGb6o6dY/WX2dbvX29RjYIBLoxZb7Gk/JLMt9UWOOFQvLhC91qt87gPNhg2dVvQOBV482/6JAjEoFQi+yuvzQkAgBSmF69sNjl+acyZ921dTtfls6dZllsQszOVwrhCg2gAJd4+gVmRjyYZm49T8FkQaG8y27kxdro4W768stBLjAhE5D6JUr/1ifV6E2QghDrgXL1bESo6kTBKxpyTXIy/NTw1jLkfu4Ueqogz6qfzr+80ipYl92f8Qrx8ig0busZ5sC2xbe2Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zp7rV7gcIcpAcJ5mqyIq65eZD+3F2gNmFccJkRTmeyk=;
 b=B4TVWEJ1rjnkDPrN7W1WBXiioRdKhxf5MDZSUp5lxcPUVdKR9P3QQ1ugBEWht7u50qJQ6dMeuqhhx+jD8LH9kIWPauF9gii2x9/L/Kn+uBzrOasw6k7Wt/Vib++r5gZIquoW8o9dToYIiRfXoNXn+KTPxTHtaFm2BhIyVUVbdT5ZouquY4hvw7PhmRx99UXRBcYTH/GWDFdf57tdGfAe7eb8AqlL+7viLh+3t7tRc2lqsaNKyVEI1GFZqDf4ksyXkRfw2sCDU0ty0Fv6YZ5FV4thiPN4G3wy+3IDcwTkc4y3tIqaQShMD/21llJgqcEVlzO/6urxtlHWkE3PAQ2CtA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zp7rV7gcIcpAcJ5mqyIq65eZD+3F2gNmFccJkRTmeyk=;
 b=3benX6LXuRhlmRqHHEGRYYjXLtB8VcMp2qMxRF1g+RaXE49VcPS53tdd9OUzVFB6lB0ap4srvCYnPR+ELJdivNNKe1lCtv+tCH9Abtx7SoQ+KN3e5q56rnYZBKUiSB13InEwPzO2/vH2iesrCyUkXnjouBvs3ElgaGbILRHCLkU=
Received: from DS0PR12MB6534.namprd12.prod.outlook.com (2603:10b6:8:c1::19) by
 CH0PR12MB8464.namprd12.prod.outlook.com (2603:10b6:610:184::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9366.17; Mon, 1 Dec
 2025 13:08:22 +0000
Received: from DS0PR12MB6534.namprd12.prod.outlook.com
 ([fe80::ea87:74ba:36ec:8cf6]) by DS0PR12MB6534.namprd12.prod.outlook.com
 ([fe80::ea87:74ba:36ec:8cf6%7]) with mapi id 15.20.9366.012; Mon, 1 Dec 2025
 13:08:19 +0000
From: "Wheeler, Daniel" <Daniel.Wheeler@amd.com>
To: "Li, Roman" <Roman.Li@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
CC: "Wentland, Harry" <Harry.Wentland@amd.com>, "Li, Sun peng (Leo)"
 <Sunpeng.Li@amd.com>, "Pillai, Aurabindo" <Aurabindo.Pillai@amd.com>, "Li,
 Roman" <Roman.Li@amd.com>, "Lin, Wayne" <Wayne.Lin@amd.com>, "Chung,
 ChiaHsuan (Tom)" <ChiaHsuan.Chung@amd.com>, "Zuo, Jerry" <Jerry.Zuo@amd.com>, 
 "Wu, Ray" <Ray.Wu@amd.com>, "LIPSKI, IVAN" <IVAN.LIPSKI@amd.com>, "Hung,
 Alex" <Alex.Hung@amd.com>, "Li, Roman" <Roman.Li@amd.com>
Subject: RE: [PATCH 00/14] DC Patches November 26, 2025
Thread-Topic: [PATCH 00/14] DC Patches November 26, 2025
Thread-Index: AQHcXylRwJjYcBo9q0qev4VRYl2ZKrUMyEIw
Date: Mon, 1 Dec 2025 13:08:19 +0000
Message-ID: <DS0PR12MB65348010C5B05C351F0D980B9CDBA@DS0PR12MB6534.namprd12.prod.outlook.com>
References: <20251126230614.13409-1-Roman.Li@amd.com>
In-Reply-To: <20251126230614.13409-1-Roman.Li@amd.com>
Accept-Language: en-CA, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Enabled=True;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_SetDate=2025-12-01T13:08:04.0000000Z;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Name=Open
 Source; MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_ContentBits=3;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Method=Privileged
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS0PR12MB6534:EE_|CH0PR12MB8464:EE_
x-ms-office365-filtering-correlation-id: f4396ef7-5348-42d4-d670-08de30dab314
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|1800799024|376014|366016|38070700021;
x-microsoft-antispam-message-info: =?iso-8859-1?Q?LdNPqOvV+kIqJ2JjGnTpU6BYB1eDQzneDCiz3/N0CYQFir2bwWTa27JxQM?=
 =?iso-8859-1?Q?1k0xlmhCQwCEj+0OtUr0YJsW4vvCXbeGQp0LUEo5NTpA8jnSKAKc/RVxxT?=
 =?iso-8859-1?Q?xBaZppaMYnDbpzG8J5iRhYYlCIE6+1pMAtokph5m9yfFn5IcIOefGP7IkJ?=
 =?iso-8859-1?Q?GgFx33GWdNBnTxfkcYRB3NPqQ3opcKjT/7GAimyARXP0vu1q2PW3XwOHZt?=
 =?iso-8859-1?Q?wUqSEAJxszAVQsdx50Y3R1ebIDK2glpnqzgkR5p40uXUFPVRDKI4IkXx7M?=
 =?iso-8859-1?Q?YAQURt66io3wKZvFjG4Q14YhM1pO++UnSZPtleT8VpKzEflEQ0G9ONKcJB?=
 =?iso-8859-1?Q?r80Bp/5UPvRWxOpIS1ZYnfQcnULQHa6Aui3czANxYjJsYQz7d/YIPhzV14?=
 =?iso-8859-1?Q?b7cnqAcleHXV00Y8cHiH7ejR/G+NmHtQ+I4abKNxUQeBpzJlMrbrRg6f0j?=
 =?iso-8859-1?Q?/OiMGdRsGhEWIc9V4TW4m8onLcRu6Tsb3aIhPxUDZToDAc8FF9ci0XH7Nn?=
 =?iso-8859-1?Q?1P55+fv+jzLq3WKDKPW59obJ200XcZBjvjrV3cj2EPJ0qXpov3uv5sAkul?=
 =?iso-8859-1?Q?G/rrrpxaR4E0Pg+ggHxNj4YCynPKaUPXzPSrvYgwCrdP7Ec9DvZhttkNwz?=
 =?iso-8859-1?Q?EzOFeSl20/L51c0eqG7VLsy9o+z5Fgm4YDGXIkWGhQxUXfsaUtt0Y936UP?=
 =?iso-8859-1?Q?N6GH/SDCerg0EW1z57DoOqS40xD+a+S1BRLZTzO9JWkIh2AF4A3MtOah1Q?=
 =?iso-8859-1?Q?mAZryRfBGOKgxgCMx57VdWYoet8cvmrsM2J87L4MPWl5fSd8Ss/WB8zl30?=
 =?iso-8859-1?Q?U4umUEwcV3MBBjmRo4Y41YSJsqEESLjsCXvjNo4VIK67MYA5EcL+AR55fK?=
 =?iso-8859-1?Q?HD5Thnr6L5hVfmzyJSvHs6/PKFJbMHkzxgrftV7FlxNa1OTSs/egtuDpq1?=
 =?iso-8859-1?Q?30ekUNjDh8l5yNz5tZkNqJAQM1HOeYPc7Q57YjbEkaMH4fu2iGLc21yHKH?=
 =?iso-8859-1?Q?fYOMIMxvCZDeLP/7/D9bk2JIXMr05k2U/mYXxpZcuwKIFwI8AvrJBrBOu9?=
 =?iso-8859-1?Q?pmHspr53OksElHZKHdZwa550FKJBD46NvGIW0P7liYLVK7ylkhZlo5T+Dn?=
 =?iso-8859-1?Q?iVY7wuJrPmmzjeg4Owue5XBuLa4xjntZUr9cqGrQLt1ls47Y537ig8V0ks?=
 =?iso-8859-1?Q?bNRSAEkqG0ceUAwjIrOEBdWZ+cFUIaF0rXXw6eMvo8wucY6s4h5/8YNuZ/?=
 =?iso-8859-1?Q?eb33oJ97B2KJ+pX8VYhh1GUTxyKxXiZgg26G+/BWahb2cCtabr5VoJG/2g?=
 =?iso-8859-1?Q?EClYfRwpnCOQKupJpYOCrZ+zqOD3P1b2BU4t18CHJqrmyjqriQShfM/vxJ?=
 =?iso-8859-1?Q?m3hQN6CyMXYfBpIb0kjxGiIn3fgM3mHF25vIT2CJODb3XcynsP/JSNptEY?=
 =?iso-8859-1?Q?Wq9wy21sL0EFELwAbN3SH7JfZkcFXUrkYGkdHT03X8XSVI0tr2OD53DEqw?=
 =?iso-8859-1?Q?yXGzqxAtRspFV6c+HanjbR5EZNT0J5d18GfYKD0o0ti/+JjTczmPo2V/2p?=
 =?iso-8859-1?Q?ij0v07Q7GP7mGAi1cOnc07ZW9HMr?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR12MB6534.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(38070700021); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?2NOGxPEwQrwGYgrfvVW/ELAmbF3IR8Z5rTGJlBqXh/S0nS02ZIfk2YUe7H?=
 =?iso-8859-1?Q?u9Er+PKqxZc9/mTI/dC64vp50NNC6T58N6q5hKzJK6lE0hZ7w/XYxLTfFs?=
 =?iso-8859-1?Q?fk97gCzxlcorUbjl1sYxqAZd6G2x9gmaeDoac7u6GQjaLycJm7IfL3/7Rm?=
 =?iso-8859-1?Q?A99tVWPb4xsSbklVV3o3zRs7MFYlJE3eQLGIIauMBECsmVvnvPF4M9ASjX?=
 =?iso-8859-1?Q?THuRInRrnrcw/Zy8HEXUvLUmjwJRk1wvpE6t6mMsj0bTAXyyXaYpiJAbI5?=
 =?iso-8859-1?Q?dn8ntQu1UoQ8W10/F4nAo/YOtjcByTjCp/E0Gq6NswceZmkuILU3KyiR9K?=
 =?iso-8859-1?Q?3ujNdb5HUAcqXWIhpNSSDMGL17ztUGg8M7GJgHRKdX6B36MaRr9FBU4T3t?=
 =?iso-8859-1?Q?B5lEh7CdTRNfbIoaXTkJoMTGqcGBlgHGlSwUvIcJnG66/2OVJVcLPIQMBw?=
 =?iso-8859-1?Q?8Gr/BF7yqf6I0lmbu05oY5ziF1LTqBciZQPa3LV99N1276Pt/SMl5oZ933?=
 =?iso-8859-1?Q?TmeNm/fAcQLdQxWQpLT65z4xhkJYrFKLJeps5LC0tFVHLUOnHrKcfggO/M?=
 =?iso-8859-1?Q?hllKFhEDtDu6yL+uiNb5iZw5gR5RYGgt+WtQZ8cXuTRGRMF6jaL2DTYson?=
 =?iso-8859-1?Q?7xH5pGetuZzRGv9ZL+6tyY3tQ5+sF3TheRv22EjYWWGNeg8T5F6Pq8NCrt?=
 =?iso-8859-1?Q?vrZyRFrLs/uOS9it37fwye5iyPoNL7ZS/ZrFCgc5GDeEMTmLPII0FGpdDG?=
 =?iso-8859-1?Q?Ye2zGdH5NlBCZQ+4S6f1wybI3U6MTpLxrogdTQi3anF7JPEUuHESqL/+57?=
 =?iso-8859-1?Q?sTbMaBJHvr+9wq7X6xQ0hZzs4Y2UJ6859twt/rlAitNLE//9XVY2aRmpUA?=
 =?iso-8859-1?Q?8JHt5oMKAMtF9w9ietWDI1p7NRkSmBfIt8dQu84eENZMv06u22TVVP0xTv?=
 =?iso-8859-1?Q?nwhITVXjlfxfwv7h25Tv8S1ub4kY/1AuMEW8ax5MlRYBSz40nM1FisvctD?=
 =?iso-8859-1?Q?I68r4nge2LC/FpLf/x54p6/yEIkqUzSKf0LFN4sGG2twBnZHEIWokNDQPH?=
 =?iso-8859-1?Q?qaHjsERDk7/T3XlyLiMEDGToTQMqtMrYT4PgU+Qc/aGnfeUDHLbUkkn/B0?=
 =?iso-8859-1?Q?F/fB+W0A2OQFa34aZ4n4ftFUDo2TomZOyC2bs4rW2nrhi3cpXpkaqyNXKg?=
 =?iso-8859-1?Q?Ugn28XufToZbu0GBQqUnNFQQ/hhIVqeEmsqM7aAKqiZ0MS8iOIV2y/nYQp?=
 =?iso-8859-1?Q?9IIOI/3Y1MiJMnfZBB/D0m9N+lg3eoYvZxd7wBZTvw0h6CY8BZnvJ3Looo?=
 =?iso-8859-1?Q?afQtXEVXgtmL4Huf1HbJh2eyd6IwiOsmzCI2vbDmIOMtmQ3/o9R6I3IMhZ?=
 =?iso-8859-1?Q?M6+g9K6RT2thd9QoGpmc42BiIsdzZvPh4bAVB5vXUDWlwEgGYOzR8c6r6S?=
 =?iso-8859-1?Q?AG7zUyceHMWMGxVvjMwHpj0VlKeuDw9MSdH6/LGpr3sHkVVELkkkPo5Lq5?=
 =?iso-8859-1?Q?GfcoK+R2Q1yTmpwfhKGcXSR4pPwD4EBa/my8wsBr+ZkaAq+M6jYekRSJ+a?=
 =?iso-8859-1?Q?Yrb9iHW+wa2CYeEzbUHlvJShP5ZllsO2J/qLTzncnwZwJA/EpRPr6Df6LB?=
 =?iso-8859-1?Q?fOO0514bB8AZA=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB6534.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f4396ef7-5348-42d4-d670-08de30dab314
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Dec 2025 13:08:19.8578 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 5LLDqJeaXgThqyLG6i97wmt49Zhzhnivr6ySYrePE9R+txiQHxNlAGeHqgPpiWpo0j470w7Db/TVoDZ4p4KNag==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR12MB8464
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


The patchset consists of the amd-staging-drm-next branch (Head commit - 0ff=
cd28fcd5447b83449cdecfa4260c6fa967df1 -> drm/amdgpu: create pm4 header for =
gc v12_1) with new patches added on top of it.

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
From: Roman.Li@amd.com <Roman.Li@amd.com>
Sent: Wednesday, November 26, 2025 6:06 PM
To: amd-gfx@lists.freedesktop.org
Cc: Wentland, Harry <Harry.Wentland@amd.com>; Li, Sun peng (Leo) <Sunpeng.L=
i@amd.com>; Pillai, Aurabindo <Aurabindo.Pillai@amd.com>; Li, Roman <Roman.=
Li@amd.com>; Lin, Wayne <Wayne.Lin@amd.com>; Chung, ChiaHsuan (Tom) <ChiaHs=
uan.Chung@amd.com>; Zuo, Jerry <Jerry.Zuo@amd.com>; Wheeler, Daniel <Daniel=
.Wheeler@amd.com>; Wu, Ray <Ray.Wu@amd.com>; LIPSKI, IVAN <IVAN.LIPSKI@amd.=
com>; Hung, Alex <Alex.Hung@amd.com>; Li, Roman <Roman.Li@amd.com>
Subject: [PATCH 00/14] DC Patches November 26, 2025

From: Roman Li <Roman.Li@amd.com>

This DC patchset brings improvements in multiple areas. In summary, we high=
light:
* Add configurable SPL namespace prefix.
* Add register definitions in dcn_hubbub_registers.
* Add additional info from DML.
* Add dc interface for query QoS information.
* Fix wrong x_pos and y_pos for cursor offload.
* Fix Smart Power OLED not working after S4.
* Fix double cursor when switching between hw and sw cursor.
* Refactor HPD to increase flexibility.
* Remove unused encoder types.

Cc: Dan Wheeler <daniel.wheeler@amd.com>

Charlene Liu (1):
  drm/amd/display: add register definitions in dcn_hubbub_registers

Dillon Varone (1):
  drm/amd/display: Guard FAMS2 configuration updates

Dmytro Laktyushkin (1):
  drm/amd/display: refactor HPD to increase flexibility

Ian Chen (1):
  drm/amd/display: fix Smart Power OLED not working after S4

Ivan Lipski (3):
  drm/amd/display: Remove unused encoder types
  drm/amd/display: Use local variable for analog_engine initialization
  drm/amd/display: Move RGB-type check for audio sync to DCE HW sequence

Jing Zhou (1):
  drm/amd/display: Correct FIXED_VS Link Rate Toggle Condition

Navid Assadian (1):
  drm/amd/display - dc: Add configurable SPL namespace prefix

Nevenko Stupar (1):
  drm/amd/display: Add additional info from DML

Nicholas Kazlauskas (2):
  drm/amd/display: Fix wrong x_pos and y_pos for cursor offload
  drm/amd/display: Reset pipe mask at beginning of cursor offload

Taimur Hassan (1):
  drm/amd/display: Promote DC to 3.2.361

Wenjing Liu (1):
  drm/amd/display: add dc interface for query QoS information

 drivers/gpu/drm/amd/display/dc/core/dc.c      |  30 +++
 drivers/gpu/drm/amd/display/dc/dc.h           |  39 ++-
 drivers/gpu/drm/amd/display/dc/dc_dmub_srv.c  |  18 +-  .../drm/amd/displa=
y/dc/dce/dce_link_encoder.c |  47 +++-
 .../drm/amd/display/dc/dce/dce_link_encoder.h |   8 +-
 .../display/dc/dcn201/dcn201_link_encoder.c   |   3 +
 .../amd/display/dc/dcn21/dcn21_link_encoder.c |   3 +
 .../display/dc/dio/dcn10/dcn10_link_encoder.c |  43 ++++  .../display/dc/d=
io/dcn10/dcn10_link_encoder.h |  11 +-
 .../display/dc/dio/dcn20/dcn20_link_encoder.c |   3 +
 .../dc/dio/dcn30/dcn30_dio_link_encoder.c     |   3 +
 .../dc/dio/dcn301/dcn301_dio_link_encoder.c   |   3 +
 .../dc/dio/dcn31/dcn31_dio_link_encoder.c     |   3 +
 .../dc/dio/dcn32/dcn32_dio_link_encoder.c     |   3 +
 .../dc/dio/dcn321/dcn321_dio_link_encoder.c   |   3 +
 .../dc/dio/dcn35/dcn35_dio_link_encoder.c     |   3 +
 .../dc/dio/dcn401/dcn401_dio_link_encoder.c   |   3 +
 .../display/dc/hubbub/dcn10/dcn10_hubbub.h    |   6 +-
 .../amd/display/dc/hubp/dcn401/dcn401_hubp.c  |  14 +-  .../amd/display/dc=
/hwss/dce110/dce110_hwseq.c |  25 +-
 .../amd/display/dc/hwss/dcn35/dcn35_hwseq.c   |   1 +
 .../amd/display/dc/hwss/dcn401/dcn401_hwseq.c |  17 +-
 .../drm/amd/display/dc/hwss/hw_sequencer.h    |  37 +++
 .../drm/amd/display/dc/inc/hw/link_encoder.h  |   4 +
 .../gpu/drm/amd/display/dc/inc/link_service.h |   3 -
 .../drm/amd/display/dc/link/link_detection.c  |  10 +-
 .../gpu/drm/amd/display/dc/link/link_dpms.c   |   3 +-
 .../drm/amd/display/dc/link/link_factory.c    | 240 +++++++++---------
 .../link_dp_training_fixed_vs_pe_retimer.c    |   2 +-
 .../amd/display/dc/link/protocols/link_hpd.c  | 165 ++++--------
 .../amd/display/dc/link/protocols/link_hpd.h  |   1 -
 .../dc/resource/dcn32/dcn32_resource.h        |   5 +-
 drivers/gpu/drm/amd/display/dc/sspl/dc_spl.c  | 186 +++++++-------
 drivers/gpu/drm/amd/display/dc/sspl/dc_spl.h  |   8 -
 .../drm/amd/display/dc/sspl/dc_spl_filters.c  |   4 +-
 .../drm/amd/display/dc/sspl/dc_spl_filters.h  |   4 +-
 .../display/dc/sspl/dc_spl_isharp_filters.c   |  31 +--
 .../display/dc/sspl/dc_spl_isharp_filters.h   |  16 +-
 .../display/dc/sspl/dc_spl_scl_easf_filters.c | 155 +++++------  .../displ=
ay/dc/sspl/dc_spl_scl_easf_filters.h |  37 +--  .../amd/display/dc/sspl/dc_=
spl_scl_filters.c  |  27 +-
 .../amd/display/dc/sspl/dc_spl_scl_filters.h  |   3 +-
 .../amd/display/dc/sspl/spl_custom_float.c    |  11 +-
 .../amd/display/dc/sspl/spl_custom_float.h    |   4 +-
 .../drm/amd/display/dc/sspl/spl_fixpt31_32.c  |  78 +++---  .../drm/amd/di=
splay/dc/sspl/spl_fixpt31_32.h  |  56 ++--
 .../drm/amd/display/dc/sspl/spl_os_types.h    |   9 +
 47 files changed, 777 insertions(+), 611 deletions(-)

--
2.34.1

