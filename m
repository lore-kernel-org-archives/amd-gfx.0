Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3DCC8E7717D
	for <amd-gfx@archiver.kernel.org>; Mon,  9 Dec 2024 15:14:41 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C47AB10E0A9;
	Mon,  9 Dec 2024 15:14:40 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="DzyCXC1f";
	dkim-atps=neutral
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2071.outbound.protection.outlook.com [40.107.92.71])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D154710E0A9
 for <amd-gfx@lists.freedesktop.org>; Mon,  9 Dec 2024 15:14:39 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cJLHY/gw59s+kxM7Q290reBcOODy+V80NKf93RJQMkyo8rssZFhVRqsysGp7iumdKabnrmfuIlXNJpYvdgoqEi/fzpRP67qZXaXlxf4LqJh5t61V9j74vCxr2NiwhE1rAtqa1u1MxObdBIxp46JpHh+g6fYkQQdlEg6NINF/brrHa/bggIG7tKYptsM150D0evsV8ptlayZH64WqUNLopWCekxmENaG+k4awv07krrqbwDGJ8T26dIhZrFBVtd1VrK5g0OeE5g4cWEWpjXinz+YqiVlXx5dJQ3IZCWaZS+hBMOSjJsNQol6JG2wbjtMp9SIMZdJdzVZnrWIPA6Plzw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cEcR1WDRgvIL7/7vVAxwxWTS7lX3ID1MUPKxSIjUO3c=;
 b=Gj/c9Ezs1GFVB/RoSeyazdLu4CwmzAQBe9aG1Rym01F5yb3UA+x8S4Amr656z1bMyI1RZg0C9nhcM6PxoJd5dpYRHYp2xvEOWvYnoFYNFxomugK8YvkNSFXPgtHzdVP/VvOHI/C2D+QDMEmITpcOrDisi87D/7iP9lWo9rFGlEMJoRIMMY1dK9WfNpa3r9AD9iGwWq70VLL2zWKfCBMjRSoXeLQKUpgFBNQUQidRG1uJVYLM9VqoOjbAg18J8tyhyaqWoA8OIEkgl5erT4LwrpHiThZBAvVOuaWoIzg71S3PxGLc30WpjIe4HScYdxgceUY/JKMAB7AR+TDNo9ZN4Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cEcR1WDRgvIL7/7vVAxwxWTS7lX3ID1MUPKxSIjUO3c=;
 b=DzyCXC1fxiCY/LYo76fIyplqAzG5Q0lViZPjchzYgyGV2Ooq8cOgxbJovAdRHNY2b2KxHfZ/1FlR6Gwav1iyPJNGwMNK6ElmzIao5bXMe5sz8hvf6plziFSOK9+o6FbR7ZmFetqxBf8Hyt57/KivKhzzrRo5ygBskU8NkstIt1Y=
Received: from DS0PR12MB6534.namprd12.prod.outlook.com (2603:10b6:8:c1::19) by
 DS0PR12MB6655.namprd12.prod.outlook.com (2603:10b6:8:d0::12) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8230.18; Mon, 9 Dec 2024 15:14:33 +0000
Received: from DS0PR12MB6534.namprd12.prod.outlook.com
 ([fe80::ea87:74ba:36ec:8cf6]) by DS0PR12MB6534.namprd12.prod.outlook.com
 ([fe80::ea87:74ba:36ec:8cf6%6]) with mapi id 15.20.8230.016; Mon, 9 Dec 2024
 15:14:33 +0000
From: "Wheeler, Daniel" <Daniel.Wheeler@amd.com>
To: "Pillai, Aurabindo" <Aurabindo.Pillai@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
CC: "Wentland, Harry" <Harry.Wentland@amd.com>, "Li, Sun peng (Leo)"
 <Sunpeng.Li@amd.com>, "Siqueira, Rodrigo" <Rodrigo.Siqueira@amd.com>,
 "Pillai, Aurabindo" <Aurabindo.Pillai@amd.com>, "Li, Roman"
 <Roman.Li@amd.com>, "Lin, Wayne" <Wayne.Lin@amd.com>, "Chung, ChiaHsuan
 (Tom)" <ChiaHsuan.Chung@amd.com>, "Zuo, Jerry" <Jerry.Zuo@amd.com>, "Mohamed, 
 Zaeem" <Zaeem.Mohamed@amd.com>, "Chiu, Solomon" <Solomon.Chiu@amd.com>
Subject: RE: [PATCH 00/19] DC Patches for 6 Dec 2024
Thread-Topic: [PATCH 00/19] DC Patches for 6 Dec 2024
Thread-Index: AQHbRcwbDiIlJpTiUUm7W2AY75OADbLeDe5Q
Date: Mon, 9 Dec 2024 15:14:33 +0000
Message-ID: <DS0PR12MB65346B16319CE6E1CC951D7A9C3C2@DS0PR12MB6534.namprd12.prod.outlook.com>
References: <20241203214120.1161810-1-aurabindo.pillai@amd.com>
In-Reply-To: <20241203214120.1161810-1-aurabindo.pillai@amd.com>
Accept-Language: en-CA, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_ActionId=13be2ecb-c274-4683-8b8c-daacf455ad6b;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_ContentBits=0;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Enabled=true;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Method=Privileged;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Name=Open Source;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_SetDate=2024-12-09T15:13:23Z;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS0PR12MB6534:EE_|DS0PR12MB6655:EE_
x-ms-office365-filtering-correlation-id: 910874e3-2568-42fb-5063-08dd18642ffe
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|1800799024|366016|376014|38070700018;
x-microsoft-antispam-message-info: =?iso-8859-1?Q?LYYPH7TqCdhVHWZk/RXo9Q7HS1dawmZ0HmcELKrXPFWa/WYowsLW9kJyLR?=
 =?iso-8859-1?Q?5MwQVsGoginBxjBpvLFICzWFKDq/Hh2VstiQFqPlzkQE1EsiVBwr0dXQ/Q?=
 =?iso-8859-1?Q?EAkkXdIcFTseI+yDmWkZ74TpVt0Yr/+UddmJDfcLLaWQxfNHyU7k4CTkRw?=
 =?iso-8859-1?Q?6FTFaSHAglAO3Djb7SkpKFaQYmbviXnyVEc4ByhPDMMkfJGfwfThCJkCVC?=
 =?iso-8859-1?Q?Z5UvgA9eqmNubcLNNY4oC1ECbIr+Dp5hzhcxiqhmar3/K+c3IQNuw/hhhK?=
 =?iso-8859-1?Q?UIGRKhdZRoLn5ozOHy2xgSVdMSPoYP5F9PEjK9TRkuhPKxFi7ad3Y8hbaX?=
 =?iso-8859-1?Q?j7uVl4M0mnaoVfOiZ2rYQkAJs3x7ZCpfK3/19jNYt1U/gQ06petKDLx/AH?=
 =?iso-8859-1?Q?urNoRd1ooMH1X+cutQEXDONaTZgPTHlRxTmhwmfr9fCbM6R4/b8uCwXwHd?=
 =?iso-8859-1?Q?ag5KhkyLtMijJ4dfh76EUJ8xMFystruppyo4EY20hmB/bNejWwP1YpiOol?=
 =?iso-8859-1?Q?CyokoRmdZDpMy6yo/fK4YxgxpkCSNf1PvqPxY+Mc+HVz7ZxtbAwlK/2C5s?=
 =?iso-8859-1?Q?LXDJ8ODMZL7Wcwhcy/JH+38QfDvI1EFwPjhxhAXJzMxZhQ8izdhsfM4mPm?=
 =?iso-8859-1?Q?RptsbA44HH9Gw1JIEBKilyJIcT0zIVm227e8paSRH/OgkdsQo4c4jQ6HzO?=
 =?iso-8859-1?Q?PxcaeBikuMIuD2zY8nc9r167+mMCCU2Qs1cHqaPRjMXjU91FlGFdSm79eL?=
 =?iso-8859-1?Q?w8enSfDZw1/mjhXxF7sMoMt96ORBG0aOiD3ZKcTG0oUhXRCMNHcFnBI+N2?=
 =?iso-8859-1?Q?pR5lV5zSt46BjPaFNGnYxV6gDlWq04a31WhmiFyY5M1/O6o61ULD1X5ocf?=
 =?iso-8859-1?Q?xAG39/5ZilhjZh2QXw5PNGageZ9le/jQ1QaS5/JvGWc4Wmt9pKPPSe3iSA?=
 =?iso-8859-1?Q?hukhgMCGxg/i4H8jA68MVjkxlvsMwyrLNtuAmCSaWUKh5gwicCeglphBVE?=
 =?iso-8859-1?Q?xXdQWbeZ/dQgdM/pKmV2bxxIUUBubdfOFnJ5Bh7Hyt6OKcNrALATtWN1Tw?=
 =?iso-8859-1?Q?JiLzGk8dWZck9Klmu6A312Nm0oqEM4k4+gQFupKw7BZfekHC6fEwjvd393?=
 =?iso-8859-1?Q?ZMNPb778VCmN3NoITQalqwJphrnoncZD12oSBFRwGxHzSuLiUDeXzCaqTf?=
 =?iso-8859-1?Q?z8mbnC/BsSCZ5nqJxbc28bzJZkRrvRHoipXJlRwsFxB4z4r5lDc9bHuFEt?=
 =?iso-8859-1?Q?V0w6oLNJ299a0DHFnc5xgzv54QYREKyF0//ImF7icZ22uCNvsANVyMJuK0?=
 =?iso-8859-1?Q?7leYi/R2uLVI6AEJBofwBLXoDuR/3ukD4Rk+8q4GXmefTqtt7gmWlhkIiJ?=
 =?iso-8859-1?Q?+StBZK7V5gvE7oI6hOCsu0f7vexAoeGObIn1cWj7relZVLZXLoBZeZfSas?=
 =?iso-8859-1?Q?hYyVecBkG6EMOLeuSOrgrRnZLEHYgBdOsN8zng=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR12MB6534.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(38070700018); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?lLRnzry5qA+m9xGIIzqzZFGY8SLbBKYu66i/QLIOTHbFmjH9GorfjuX06V?=
 =?iso-8859-1?Q?DARUXRSeqZkU6LhW1lUc67Cbg3IAhf/n+xoqYEdFYBVb83fezY5so9MkOm?=
 =?iso-8859-1?Q?Gvnr4pU6OQT6uv0YjKYhIDefAYTW1XX8Iqv2KFfTthM5n/QxEr7kvJmack?=
 =?iso-8859-1?Q?iujmkwLd6g8CZARiQVHhQ1Bkr9fVRwoVep2bCn+oCEVkIHkWgYeLkPqqhZ?=
 =?iso-8859-1?Q?eeGyHzVsOeQJZkDqphpyj3FMpLY82HNzo1eGEfVUIIiD858/oLEIMYOI7K?=
 =?iso-8859-1?Q?ylzFXWXN6DaxipIOIuoWWZiBh4L31vw8afcRwxa0/mJJosZukU0nVdyY7+?=
 =?iso-8859-1?Q?a+Fb+iO7Jp92RQA0jOFy0hwEBN1z7AQyCwsZkIgMXl9EvevUuA6aEDRwpA?=
 =?iso-8859-1?Q?DfT7LMJXmDV6J7QNZDlfS3M6vmtm2C8mYk2ZJyVPeAsRW5bx/VNnhQRAUX?=
 =?iso-8859-1?Q?OeqlldHLyoR/teykrtJbxpsYf1X90+OJteyQDYjN5YgIIfjCApwlVHM9jM?=
 =?iso-8859-1?Q?1RuKZVlNllhjAot9BoBh+7nj2uAz6fWChYu1EIIfx+FFCgrTAypkEUlUXy?=
 =?iso-8859-1?Q?5VMFS9ao9NmrY3ZslxYLviaZWoL5zYhLuJplLkLT/x/mTmcZwm34UNNjo7?=
 =?iso-8859-1?Q?81H/b9EhbzB0dvzD/JiObsezGjuyISflxQ+Xbjrdt89tdQiPzw/wDVj4UC?=
 =?iso-8859-1?Q?uFeSOA8ARsfVSyZspxw/wAgDnvNwXEvGcSkIUVy1VLyrYtcVQMYviQMAX8?=
 =?iso-8859-1?Q?9vx7Kdk7OLZ3Fe+hp+SuMmpGZrliJeQdvgvjgKRFv7uK3PHPu4IH0A0zGt?=
 =?iso-8859-1?Q?2z+8YJcQNunZ/BFEt/cwu4ZNaLeM07+FJ/laOYC7KTjzIeQVal6wANVC+J?=
 =?iso-8859-1?Q?0TnRKndGRe0lqtMcQv8+Ly+3oW0Mtkh7uExtgBe8+mQu8aCiPDc1Gd/dsc?=
 =?iso-8859-1?Q?NkTt5B7wMk2LXCtmC/PhiwRgErAhm2Ww/qWwx2qWLM7NRYPbkFT2DouFmG?=
 =?iso-8859-1?Q?u8nYEvFs9hxB2PXTOrQvg3pAqdfIq3z1orrTBqDc+GDkr+J5GM6bBh7FF6?=
 =?iso-8859-1?Q?42lEoDzApFBhzzAMveEDg+IApNqd7SHcmYWvfgw7ONOMOnx/HTDBf37Hc2?=
 =?iso-8859-1?Q?U0e5Pzv3MFS1eKhZRWlzJjBgc/b+0DYskwfEznRILjOQoRNYvzhcMg9u9j?=
 =?iso-8859-1?Q?78pPxOUSqQ/KH1HwCshEo3eIGnCJL9Pd3rqKe0Kdue9YzQdzAlM986zNFn?=
 =?iso-8859-1?Q?IJTIaVfSd6bQRoVFx495usvGV1reSaAz4KfRhnCOVWXB5JPoBLfvotTQ6v?=
 =?iso-8859-1?Q?QoN3aeaSy2LAuOZcgBZWMrvaRJRncdqL4OeYXsPYJhFpxtED5rarnUVDFc?=
 =?iso-8859-1?Q?yHrBL2xYQ17HJQwDTwNPCZ7dW7f5ifN+5lIETUtIcysMR1nKqcn9uErJCz?=
 =?iso-8859-1?Q?bJa7oMEGkz+FK4LFM3MVPjTFJLTxqeL7JwFp2ql2lAM1TuX++x/wNP+EtJ?=
 =?iso-8859-1?Q?+9Mwv4bw2CUmhjuGEmwxg1GUqBRfZ6LOZXHKMMGk112pHhi2b19qMhhq5o?=
 =?iso-8859-1?Q?ZigpGiu+vvU8Nc0IYpgTLOtEZ9XQGpWw80exivWGh4bIInS/TDvBgkUxYm?=
 =?iso-8859-1?Q?/qz7qHI3LPUkY=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB6534.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 910874e3-2568-42fb-5063-08dd18642ffe
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Dec 2024 15:14:33.7258 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: hzLguje0T+Aenur5ZQn4cqS11UKQnmqHW1mwGpbotHeYV/cuqm8nbwvmOjhglAME5HtpmgXiULNXMaRedb4i/w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB6655
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
        * Single Display DP -> 4k144hz, 4k240hz
        * Multi display -> eDP + DP/HDMI/USB-C -> 1080p 60hz eDP + 4k 144hz=
, 4k 240hz (Includes USB-C to DP/HDMI adapters)
        * Thunderbolt -> LG Ultrafine 5k
        * DSC -> Cable Matters 101075 (DP to 3x DP) with 3x 4k60hz displays=
, HP Hook G2 with 2x 4k60hz displays
        * USB 4 -> HP Hook G4, Lenovo Thunderbolt Dock, both with 2x 4k60hz=
 DP and 1x 4k60hz HDMI displays
        * SST PCON -> Club3D CAC-1085 + 1x 4k 144hz, FRL3, at a max resolut=
ion supported by the dongle of 4k 120hz YUV420 12bpc.
        * MST PCON -> 1x 4k 144hz, FRL3, at a max resolution supported by t=
he adapter of 4k 120hz RGB 8bpc.

DGPU
        * Single Display DP -> 4k144hz, 4k240hz
        * Multiple Display DP -> 4k240hz + 4k144hz
        * MST (Startech MST14DP123DP [DP to 3x DP] and 2x 4k 60hz displays)
        * DSC (with Cable Matters 101075 [DP to 3x DP] with 3x 4k60hz displ=
ays)

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

The patchset consists of the amd-staging-drm-next branch (Head commit - 32a=
8dc1b252b9066366a27d3d9ce571278212418 -> drm/amdgpu: rework resume handling=
 for display (v2)) with new patches added on top of it.

Tested on Ubuntu 24.04.1, on Wayland and X11, using KDE Plasma and Gnome.


Thank you,

Dan Wheeler
Sr. Technologist  |  AMD
SW Display
---------------------------------------------------------------------------=
---------------------------------------
1 Commerce Valley Dr E, Thornhill, ON L3T 7X6
Facebook |  Twitter |  amd.com


-----Original Message-----
From: Aurabindo Pillai <aurabindo.pillai@amd.com>
Sent: Tuesday, December 3, 2024 4:40 PM
To: amd-gfx@lists.freedesktop.org
Cc: Wentland, Harry <Harry.Wentland@amd.com>; Li, Sun peng (Leo) <Sunpeng.L=
i@amd.com>; Siqueira, Rodrigo <Rodrigo.Siqueira@amd.com>; Pillai, Aurabindo=
 <Aurabindo.Pillai@amd.com>; Li, Roman <Roman.Li@amd.com>; Lin, Wayne <Wayn=
e.Lin@amd.com>; Chung, ChiaHsuan (Tom) <ChiaHsuan.Chung@amd.com>; Zuo, Jerr=
y <Jerry.Zuo@amd.com>; Mohamed, Zaeem <Zaeem.Mohamed@amd.com>; Chiu, Solomo=
n <Solomon.Chiu@amd.com>; Wheeler, Daniel <Daniel.Wheeler@amd.com>
Subject: [PATCH 00/19] DC Patches for 6 Dec 2024

This DC patchset brings improvements in multiple areas. In summary, we have=
:

    * Fix some regressions related to IPS2 and PSR Panel Replay
    * Bug fixes in DML
    * DMCUB debug improvements
    * Other refactors and improvements across multiple components

Cc: Daniel Wheeler <daniel.wheeler@amd.com>

________________

Aric Cyr (1):
  drm/amd/display: 3.2.313

Ausef Yousof (1):
  drm/amd/display: Overwriting dualDPP UBF values before usage

Austin Zheng (1):
  drm/amd/display: DML21 Update Prefetch Calculations

Charlene Liu (1):
  drm/amd/display: update dcn351 used clock offset

Chris Park (1):
  drm/amd/display: Update color space, bias and scale programming
    sequence

Gabe Teeger (1):
  Revert "drm/amd/display: Revised for Replay Pseudo vblank"

Harry VanZyllDeJong (1):
  drm/amd/display: populate VABC support in DMCUB

Joshua Aberback (1):
  drm/amd/display: Refactor dcn31_panel_construct to avoid assert

Karthi Kandasamy (1):
  drm/amd/display: expose DCN401 HUBP functions

Leo Li (1):
  drm/amd/display: Make DMCUB tracebuffer debugfs chronological

Nicholas Kazlauskas (2):
  Revert "drm/amd/display: Don't allow IPS2 in D0 for RCG Dynamic"
  drm/amd/display: Fix DML2 out_states to match in_states for
    DCN35/DCN351

Peterson (1):
  drm/amd/display: Use resource_build_scaling_params for dcn20

Samson Tam (1):
  drm/amd/display: clean up SPL code

Taimur Hassan (1):
  drm/amd/display: [FW Promotion] Release 0.0.246.0

Wayne Lin (3):
  drm/amd/display: Adjust dc_stream_forward_crc_window to accept
    assignment of phy_id
  drm/amd/display: Fix phy id mapping issue for secure display
  drm/amd/display: Adjust secure_display_context data structure

Zhongwei (1):
  drm/amd/display: remove clearance code of force_ffu_mode flag in
    dmub_psr_copy_settings()

 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c |  16 +-
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h |   8 +-
 .../drm/amd/display/amdgpu_dm/amdgpu_dm_crc.c | 327 ++++++++++++++++--  ..=
./drm/amd/display/amdgpu_dm/amdgpu_dm_crc.h |  25 +-  .../amd/display/amdgp=
u_dm/amdgpu_dm_debugfs.c |  26 +-
 .../gpu/drm/amd/display/dc/clk_mgr/Makefile   |   2 +-
 .../gpu/drm/amd/display/dc/clk_mgr/clk_mgr.c  |   5 +-
 .../display/dc/clk_mgr/dcn35/dcn351_clk_mgr.c | 140 ++++++++  .../display/=
dc/clk_mgr/dcn35/dcn35_clk_mgr.c  | 132 +++++--
 .../display/dc/clk_mgr/dcn35/dcn35_clk_mgr.h  |   4 +
 drivers/gpu/drm/amd/display/dc/core/dc.c      |   8 +-
 drivers/gpu/drm/amd/display/dc/dc.h           |   3 +-
 drivers/gpu/drm/amd/display/dc/dc_dmub_srv.c  |   5 +-
 drivers/gpu/drm/amd/display/dc/dc_dmub_srv.h  |   1 -
 .../gpu/drm/amd/display/dc/dc_spl_translate.c |   9 +-
 drivers/gpu/drm/amd/display/dc/dc_stream.h    |   1 +
 drivers/gpu/drm/amd/display/dc/dc_types.h     |   4 +-
 drivers/gpu/drm/amd/display/dc/dce/dmub_psr.c |   3 +-
 .../amd/display/dc/dcn31/dcn31_panel_cntl.c   |  34 +-
 .../amd/display/dc/dml2/display_mode_core.c   |  30 +-
 .../dc/dml2/display_mode_core_structs.h       |   6 +-
 .../src/dml2_core/dml2_core_dcn4_calcs.c      |  11 +
 .../display/dc/dml2/dml2_translation_helper.c |  15 +-  .../amd/display/dc=
/hubp/dcn401/dcn401_hubp.c  |  20 +-  .../amd/display/dc/hubp/dcn401/dcn401=
_hubp.h  |  23 ++
 .../amd/display/dc/hwss/dcn32/dcn32_hwseq.c   |   1 +
 .../amd/display/dc/inc/hw/clk_mgr_internal.h  |  59 ++++
 .../dc/resource/dcn20/dcn20_resource.c        |  57 +--
 drivers/gpu/drm/amd/display/dc/spl/dc_spl.c   |  71 ++--
 .../gpu/drm/amd/display/dc/spl/dc_spl_types.h |   6 +-
 drivers/gpu/drm/amd/display/dmub/dmub_srv.h   |   3 +
 .../gpu/drm/amd/display/dmub/inc/dmub_cmd.h   | 154 ++++++---
 .../gpu/drm/amd/display/dmub/src/dmub_srv.c   |   4 -
 .../amd/display/modules/power/power_helpers.c |   4 +-
 .../amd/display/modules/power/power_helpers.h |   2 +-
 35 files changed, 919 insertions(+), 300 deletions(-)  create mode 100644 =
drivers/gpu/drm/amd/display/dc/clk_mgr/dcn35/dcn351_clk_mgr.c

--
2.47.1

