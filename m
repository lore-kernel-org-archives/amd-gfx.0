Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DA2BAE674B5
	for <amd-gfx@archiver.kernel.org>; Mon, 22 Dec 2025 14:37:01 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 67C3D10E6C6;
	Mon, 22 Dec 2025 14:37:01 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="VUE23joR";
	dkim-atps=neutral
Received: from BL2PR02CU003.outbound.protection.outlook.com
 (mail-eastusazon11011035.outbound.protection.outlook.com [52.101.52.35])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CCA8510E6C6
 for <amd-gfx@lists.freedesktop.org>; Mon, 22 Dec 2025 14:36:59 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=myWZsk248sWMjs0+lRgOSdQX8E+42w9nMaG4bUauva7H1f3fzasIi/Xye9PhrqWpTajqonZWAZ4UUYkTbxRcR/cESd49dH6uaH4kZeDN6dkKGly//DmAxwom3dZ/Oekh3dlKJ5b1iPDohJwZwxj/Fpvmsju9/1STlx+AUKla2hUqZHP5JfTQ/b6ZaOX0pWoIKcv41QrLq4DP7IAL3ASOtMGFearhQbzM4zEBqgTv/xjSN3wSPfNL5u4m09vyv2Foy9Qx5ADPjfXnX50xoq7tPFe5VX/f7+m2fgLwFY72WwJwdwyzxLv1V/UQMa208yyrTR+7mVGi//47VgjqrtxDNQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uQPbNp/8ZQo9+9UZLA9QtThY/ggXrtPDWfQiSd4J2mI=;
 b=ZuEFcGzcJxHUdl7DnUytQLvApSpg0b8zqNoAMd4dhC3vN+Hr9UQ35MHE+34NjQXBSR64WM4cCYNCXc/ezJVkD7mnK7uJ4/dx8szbpQxAsyVWNEwgkY+RltX5JMPZVNo0hRk8Bvyra+N9AXO6u1s4KPbIaN+T0dRd5SENqqkmB0DDZN5We+a0iiCUrwK5uqg6xJAj2bPkEgVE+3IPcgr8MKNnxEf6xXYrHMk0r0afoDZBavWQpEXGDDS/k+/XAB6gQXmIUB/Xaf0GA5FY856xGq5f/QSL0h1cvWlRdpE78KV+CwqrACSJpDgKRuqYIHloO5hXAdHVgBQeACOCg7vlBA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uQPbNp/8ZQo9+9UZLA9QtThY/ggXrtPDWfQiSd4J2mI=;
 b=VUE23joRjxNk71BLiE0fzrtK09lHR9q4j1ZgytDMgWjOsyHFYUHXy4ILPhOJB1PyphW9g3t8eo0sTHm7m0PgLRr1VFmUS/caBlbZlX9ASlZBqGUaXqK01ilA/cXGsM6zlDl5qL1p5PorWSApawcTB6bsW8NADlTUm/EYnCOOUWY=
Received: from DS0PR12MB6534.namprd12.prod.outlook.com (2603:10b6:8:c1::19) by
 DM3PR12MB9389.namprd12.prod.outlook.com (2603:10b6:0:46::9) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9434.11; Mon, 22 Dec 2025 14:36:54 +0000
Received: from DS0PR12MB6534.namprd12.prod.outlook.com
 ([fe80::ea87:74ba:36ec:8cf6]) by DS0PR12MB6534.namprd12.prod.outlook.com
 ([fe80::ea87:74ba:36ec:8cf6%7]) with mapi id 15.20.9434.009; Mon, 22 Dec 2025
 14:36:54 +0000
From: "Wheeler, Daniel" <Daniel.Wheeler@amd.com>
To: "Chen, Chen-Yu" <Chen-Yu.Chen@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
CC: "Wentland, Harry" <Harry.Wentland@amd.com>, "Li, Sun peng (Leo)"
 <Sunpeng.Li@amd.com>, "Pillai, Aurabindo" <Aurabindo.Pillai@amd.com>, "Li,
 Roman" <Roman.Li@amd.com>, "Lin, Wayne" <Wayne.Lin@amd.com>, "Chung,
 ChiaHsuan (Tom)" <ChiaHsuan.Chung@amd.com>, "Zuo, Jerry" <Jerry.Zuo@amd.com>, 
 "Wu, Ray" <Ray.Wu@amd.com>, "LIPSKI, IVAN" <IVAN.LIPSKI@amd.com>, "Hung,
 Alex" <Alex.Hung@amd.com>, "Chen, Chen-Yu" <Chen-Yu.Chen@amd.com>
Subject: RE: [PATCH 00/16] DC Patches Dec 22 2025
Thread-Topic: [PATCH 00/16] DC Patches Dec 22 2025
Thread-Index: AQHcbnJm6BZEBsOjnE6NZMXXpayirrUtw6DA
Date: Mon, 22 Dec 2025 14:36:53 +0000
Message-ID: <DS0PR12MB6534A88E4BE1645F2F76BFC49CB4A@DS0PR12MB6534.namprd12.prod.outlook.com>
References: <20251216095723.39018-1-chen-yu.chen@amd.com>
In-Reply-To: <20251216095723.39018-1-chen-yu.chen@amd.com>
Accept-Language: en-CA, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Enabled=True;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_SetDate=2025-12-22T14:36:04.0000000Z;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Name=Open
 Source; MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_ContentBits=3;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Method=Privileged
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS0PR12MB6534:EE_|DM3PR12MB9389:EE_
x-ms-office365-filtering-correlation-id: a0ac0fe2-6948-4ffb-a703-08de41678d43
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|1800799024|366016|376014|38070700021;
x-microsoft-antispam-message-info: =?iso-8859-1?Q?2CM/XHPwvhH5sPBAFLHLD1e/3iRo6WRT/LraLxrxnpl5E/2JwQgGbxno8M?=
 =?iso-8859-1?Q?9QBvVcL+mSQvVwZ/3i/q8SDO6d3BoATveMqb2yTT+D0nl1X/B3iIhDvhJ9?=
 =?iso-8859-1?Q?F5ho/FIt3zVCP5ILjXNVL9Y0CBBCVVgXq40CC8dqKtZcxUOIqYlHX0fJs4?=
 =?iso-8859-1?Q?GjvQWGQJwdAQKNUtXKgdXjosjIgd0B91kRxGW7J2BW2qGifY20gCWgDbw+?=
 =?iso-8859-1?Q?bYDcomMsS6/kx3nkNGN636nvI9Wjm1r7vcNZrluLXqcNuGKPUb89PJH/h7?=
 =?iso-8859-1?Q?nZAkQzmzH4YsLHowBDXk6MenZ7c9mR9XV80OXpki2HszaManm+YRhKb8Ew?=
 =?iso-8859-1?Q?yHm5touTVQ6MkKd2PGz2hESvR4KOcm0YFPgzQeoGVIvMAwWhD6aw10CQha?=
 =?iso-8859-1?Q?t55SUxyweNi/LOS8gJMlvQpZ/36KIwGse2neWDlLy8UC2yTEKNmcJ2wNAS?=
 =?iso-8859-1?Q?O2d8jX7V/i8yilGunA3wG4D9kdwx0dNadp0n8lY22fPacNrrJdmtcHXXdD?=
 =?iso-8859-1?Q?4rzeXZ8YJbfhwXbEGjfqJTSWjj3dZX5toFv65RrSgZs8+K3mYaTPRnrcWp?=
 =?iso-8859-1?Q?WYqTk2IUvfN6BU2e+wWNDdsICgFQj1sYNAj+XJ4CcM0Mgjx8X+DU70GN8i?=
 =?iso-8859-1?Q?kmrKP8+xoKJd6R7gV08RWFC7RxK/w65Ey1godM23LpfeoaK2oN2DTU3qoO?=
 =?iso-8859-1?Q?MRywR4Bmdh5qEq5ARNdNLZDBoMVKwDsDqzcn51vwZWpSgIQ92N6sUs7Meq?=
 =?iso-8859-1?Q?YOYdsN5m+dTkv410eHPOHnD8sd56o5UOfTzQf5lbOcG1aBsZHo87tOdc/X?=
 =?iso-8859-1?Q?eoSv5RGVDuFIsCCFl52NLPX2wMpV8mF17vnPBM6eeAJGk+uT+nURfF5Zdt?=
 =?iso-8859-1?Q?BCAyNVXLHCtxH/g3t0uGTPSYgVTs0PXcIoYtFetR2SIV2s9zdVf395P/SR?=
 =?iso-8859-1?Q?vfjVrSdXarGdM5yFLlt95MgGnpQykcj5rWn+DBVEFnFD3F/fkpskUVDG00?=
 =?iso-8859-1?Q?dW+uUf4nzqFkk6LAAa1TUAMQnP0+zCA8RXnHRqadb+NZv5unXZrkxARVVS?=
 =?iso-8859-1?Q?fngTrFL2UM+mP3TZYPTwpnWmmSa7Y0aWxDc/Nbc3cLAnoMzL89sN9+2grX?=
 =?iso-8859-1?Q?T2v4hFcUK8G8iZE+ITDuAxgJn+vWecATiQj46Wm8XRLDbD7fr+40GvTPx6?=
 =?iso-8859-1?Q?/04Ktu0wzCVQ0gX3373P4nwroQ+qfbmSzq+1GHvLrctPucjgHeOn/31X/c?=
 =?iso-8859-1?Q?oECpxPW6PwYjMGfvXIJjcMA414xKHVnoiMzqbMRKhB9jVeGta6tfB7A3kP?=
 =?iso-8859-1?Q?79tIq0zLGZSkhxR298KXhsMzfz8wfazhb+LCqCqzkJuAYl49KR1K5gXnZi?=
 =?iso-8859-1?Q?/0SWqrfkigob6a8PSljo5KNw/2ZqFwN1osPdbdAk7B3aBNnv5iETxayS3y?=
 =?iso-8859-1?Q?c/6JbmJRhP3YOyYv0r0JsPOm8mnHs3lijrbkALGgycMUMbGG34AlpJYrB5?=
 =?iso-8859-1?Q?xa2xaM4mHWWbjNCRHw2WWBw+weJIwtJjypUp/hmXJDhDc85dOYAviMTO6P?=
 =?iso-8859-1?Q?AMHEE548woTIkdqAOv508A3VjR7I?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR12MB6534.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(38070700021); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?vgfLRJUYii+QO1fZQtE7qGOPfnt4bFJ8FDwxtiOsxoQKLepsgjuziMH1M5?=
 =?iso-8859-1?Q?58KmwDJtFHbKaTjo7hywAqINhwnVVVYY4XELu7fXBwF9T/Z+U4jQJs2pYg?=
 =?iso-8859-1?Q?wGvvoDYSncvbK7NZEhOL5mW2HQOgzG6Vgs2wK0dpixyAj2Rb8MjJoAIEt1?=
 =?iso-8859-1?Q?P8Iv06O+Iw/dzcUAi0nhpoGCQo+Fd1D8BcFWznkTxcYqLCp0VpqMmayG46?=
 =?iso-8859-1?Q?YWuaRSX0cOlX7RahUrIjCH3MwZvHRpakKA3h/l8YXzit1zcRVzaTRI6iLk?=
 =?iso-8859-1?Q?LxyG9gQ/ahlyEocE9GIVogw6u6PvQs+dZh6noZ80QAiUNmqo/g0ZIi3Sdh?=
 =?iso-8859-1?Q?9sgC8EM+qETEUEss1pfwWlu9o5DwJd6I9e3PNBgxSsALh4H60WPkI92kLE?=
 =?iso-8859-1?Q?P+tINkL59RO3lv1yuV1LXMr8Yol+37ZRtxrTCnwUMWZ5rZ3SwOrxkoGou+?=
 =?iso-8859-1?Q?R6PXcNGgMxgXI7o3n7/Hs4VDLprC202q/I/3qQX6p5rHD8ryWRY8GpEhy/?=
 =?iso-8859-1?Q?8WkFet6bneBfm3uCDCuqJgdxBEjvAZzVwWyWctW2gf/NXdpiKGsKfGE9ZB?=
 =?iso-8859-1?Q?g/jlyl4QooP/gjQMB/5LNuqQQp3pWExMHH2igPP5VWqqCEDz4PFjsZX00V?=
 =?iso-8859-1?Q?bEoIYz8dt5GMJNEfGJ6jB8bhQIO7vRXlql78LkyjarL8sb/fL5HpadkdFr?=
 =?iso-8859-1?Q?GXoYUJdYlOIaE9+klwHtXvV+h/ozApbWhFbIJ422GSGEfoHI4NAsNMKPvj?=
 =?iso-8859-1?Q?q9aSXxTYXTlVaXulMFGXlD9vGIV4CRbWWC4RZhbZ7kDy0zepK1J2OjqVS1?=
 =?iso-8859-1?Q?SndchqpF6FcJiY5auWf5wrly4BUNf75BWab85TvxKhCK6uClUhsQyJ9dDz?=
 =?iso-8859-1?Q?eLIWaPNF8mkdNeoH2vPRIoI0/fcDYF8z0GNnsWVEGLRH+BHtYwnDKyL+vk?=
 =?iso-8859-1?Q?PB7gMQb7lC6YngN0ycwjckH13H6bVxDjAHFy8vocWefRZX4fbve+S8eYlC?=
 =?iso-8859-1?Q?b3eq/L1X7Xx/+DsMl9WZqa9JgW4xeasIg3Vi53L+6bbZNu3LJNIIPv1LBR?=
 =?iso-8859-1?Q?ulE65rm5Y+007hfjdCAof4SlQPTXMr/bxyCijseBnjPJP6bSv+wK2YkpEC?=
 =?iso-8859-1?Q?RaXRtfZ+/JxVXVp4ajCTkB/2erpFQQREPJD+r/MLaKVenSKUBkcKdaEvP1?=
 =?iso-8859-1?Q?t2rHmUTPqdsQD+Zm4BJDxLeJskMhYGKhYEy4iG1QDP7WEp4aBSviQww3uq?=
 =?iso-8859-1?Q?Z9Z9UwJzhEDK1f2EVAiH/kFaJXpiNy3Wq4aRump+93zw+4nG/yfEA7rMZ9?=
 =?iso-8859-1?Q?fbzV7vCTMp4gn7JLN3qfLaFsPIjPKiVdkgarbGtSPBWIGlnE0xMXxNXZfE?=
 =?iso-8859-1?Q?Zgukpnum4KD2LZVOJ/1d+b5TFy2q0ZX1xISVBtBWdnShAcEloYMdKEU46L?=
 =?iso-8859-1?Q?lE/xQU0Zd/e9B/M8Pk5uhKS+mq3b+vFOzqDAtK6po1Nq4IaJu8+Ucnur8H?=
 =?iso-8859-1?Q?9Dc3qr8evN0W3rW16THn0y7H83Vx6nskEVBKDdVJK9n7bhpsLD5sIUskGq?=
 =?iso-8859-1?Q?FPDdz6LfL0Ttx1QdnNa916Nb0jOaDrDYBdMf9GgffzUzfhcQZJ2f1oK6Z9?=
 =?iso-8859-1?Q?PHLLODFj2SIq8WJgyiiZMdtqgmRy3L8y+TPq/SZJ9RFJ/5UWULMy6sG28B?=
 =?iso-8859-1?Q?gYamwntb9lktF9x2gf14LZ1jmjVqMfswFb3bugzRWDduQVIoWtmcx5HmKw?=
 =?iso-8859-1?Q?q3VpGA3G1zyT/dxDgzRlMG8PoT3y/5fGDpyuw7C31Fg/mM?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB6534.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a0ac0fe2-6948-4ffb-a703-08de41678d43
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Dec 2025 14:36:54.0358 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: tVUlIeI/6V6rz5R81jfV7Dybo/gych21l8XEDro5oq/Nsv5yIwiP8RboVkB1bP42l8Ap6HQvf4z1DOhK9XLWiA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM3PR12MB9389
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


The patchset consists of the amd-staging-drm-next branch (Head commit - 589=
8aca9771eadeeb9c898c35cb175cee5baa930 -> drm/amdgpu: do not use amdgpu_bo_g=
pu_offset_no_check individually) with new patches added on top of it.

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
From: Chenyu Chen <chen-yu.chen@amd.com>
Sent: Tuesday, December 16, 2025 4:56 AM
To: amd-gfx@lists.freedesktop.org
Cc: Wentland, Harry <Harry.Wentland@amd.com>; Li, Sun peng (Leo) <Sunpeng.L=
i@amd.com>; Pillai, Aurabindo <Aurabindo.Pillai@amd.com>; Li, Roman <Roman.=
Li@amd.com>; Lin, Wayne <Wayne.Lin@amd.com>; Chung, ChiaHsuan (Tom) <ChiaHs=
uan.Chung@amd.com>; Zuo, Jerry <Jerry.Zuo@amd.com>; Wheeler, Daniel <Daniel=
.Wheeler@amd.com>; Wu, Ray <Ray.Wu@amd.com>; LIPSKI, IVAN <IVAN.LIPSKI@amd.=
com>; Hung, Alex <Alex.Hung@amd.com>; Chen, Chen-Yu <Chen-Yu.Chen@amd.com>
Subject: [PATCH 00/16] DC Patches Dec 22 2025

This DC patchset brings improvements in multiple areas. In summary, we high=
light:

 - Add frame skip feature support flag.
 - Add sink EDID data null check.
 - Update function name to link_detect_connection_type_analog.
 - Fix mismatched unlock for DMUB HW lock in HWSS fast path.
 - Fix P010, NV12, YUY2 scale down by four times failure.
 - Fix and reenable UPDATE_V3_FLOW_NEW_CONTEXT_MINIMAL.
 - Consolidate dmub fb info to a single struct.
 - Add new fields to fams2 config.
 - Update timing source enums.
 - Add signal type check for dcn401 get_phyd32clk_src.
 - Fix dsc eDP issue.
 - Remove unnecessary divider update flag.
 - Update dc_connection_dac_load to dc_connection_analog_load.
 - Check NULL before calling dac_load_detection.
 - Replace log macro for analog display detection.

Cc: Daniel Wheeler <daniel.wheeler@amd.com>

Alex Hung (4):
  drm/amd/display: Update function name to
    link_detect_connection_type_analog
  drm/amd/display: Update dc_connection_dac_load to
    dc_connection_analog_load
  drm/amd/display: Check NULL before calling dac_load_detection
  drm/amd/display: Replace log macro for analog display detection

Charlene Liu (1):
  drm/amd/display: Fix dsc eDP issue

ChunTao Tso (1):
  drm/amd/display: Add frame skip feature support flag

Clay King (1):
  drm/amd/display: Update timing source enums

Cruise Hung (1):
  drm/amd/display: Remove unnecessary divider update flag

Dillon Varone (2):
  drm/amd/display: Consolidate dmub fb info to a single struct
  drm/amd/display: Add new fields to fams2 config

Dmytro Laktyushkin (1):
  drm/amd/display: Add signal type check for dcn401 get_phyd32clk_src

Dominik Kaszewski (1):
  drm/amd/display: Fix and reenable UPDATE_V3_FLOW_NEW_CONTEXT_MINIMAL

Kaier Hsueg (1):
  drm/amd/display: Fix P010, NV12, YUY2 scale down by four times failure

Nicholas Kazlauskas (1):
  drm/amd/display: Fix mismatched unlock for DMUB HW lock in HWSS fast
    path

Richard Chiang (1):
  drm/amd/display: sink EDID data null check

Taimur Hassan (1):
  drm/amd/display: Promote DC to 3.2.364

 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c |  6 +-
 drivers/gpu/drm/amd/display/dc/core/dc.c      | 80 +++++++++----------
 .../drm/amd/display/dc/core/dc_hw_sequencer.c | 10 ++-
 drivers/gpu/drm/amd/display/dc/dc.h           |  2 +-
 drivers/gpu/drm/amd/display/dc/dc_types.h     |  5 +-
 .../amd/display/dc/hwss/dce110/dce110_hwseq.c | 12 ++-  .../amd/display/dc=
/hwss/dcn401/dcn401_hwseq.c |  6 +-  .../display/dc/link/accessories/link_d=
p_cts.c |  6 +-  .../drm/amd/display/dc/link/link_detection.c  | 27 ++++---=
  drivers/gpu/drm/amd/display/dc/sspl/dc_spl.c  |  3 +-
 drivers/gpu/drm/amd/display/dmub/dmub_srv.h   | 16 +++-
 .../gpu/drm/amd/display/dmub/src/dmub_dcn20.c |  6 +-  .../gpu/drm/amd/dis=
play/dmub/src/dmub_dcn30.c |  6 +-  .../gpu/drm/amd/display/dmub/src/dmub_d=
cn31.c |  6 +-  .../gpu/drm/amd/display/dmub/src/dmub_dcn32.c |  6 +-  .../=
gpu/drm/amd/display/dmub/src/dmub_dcn35.c |  6 +-
 .../drm/amd/display/dmub/src/dmub_dcn401.c    |  6 +-
 .../gpu/drm/amd/display/dmub/src/dmub_srv.c   |  7 +-
 .../amd/display/modules/power/power_helpers.c |  3 +
 19 files changed, 121 insertions(+), 98 deletions(-)

--
2.43.0

