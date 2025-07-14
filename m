Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 27088C83F1B
	for <amd-gfx@archiver.kernel.org>; Mon, 14 Jul 2025 14:24:57 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 855E910E02A;
	Mon, 14 Jul 2025 14:24:57 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="A3wR+6kS";
	dkim-atps=neutral
Received: from NAM04-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam04on2062.outbound.protection.outlook.com [40.107.100.62])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 63F6410E02A
 for <amd-gfx@lists.freedesktop.org>; Mon, 14 Jul 2025 14:24:55 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=udnJWUSEBYwLstp5bZ1zCgGC3g4biL1xVEAV1QCrKD0nUa6MV/ISv4QVBRJZlW3Z7G2qGH79Vcku9x/0MJ6UpZWZJrWmhmFlJzowDao8i8Vd3K9HWnzWzNxiDHDYdfyd6fE1dUaA2OmyJBGo1LD1nQDQWrUN0jHeN82RmrKtOAdN0LjQd2JS9qiWCEuSE7QebtqyZGvgzTSQcoOgIR0bCVZVQ9wuSEg86jGSY1m4r6puVR+6JK177JdiXTBW1CJ9o6xyr/AIvUkqdq6OA9iMgwtp3i1BbU0mIQFHVnkVa6jiIG6azMUjPWgWxRXfPT6rdya1IP0DJUwVxhq61WOSEQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9MPjc3pYjMaF3zlHmKvsTdHbi/ZWIlemeEYr+khqxUk=;
 b=QChZFJQEZouMSacjO6RkpRS/XUHX/l+hOe8d0dOGkhN8Qx2ATYv9WW/kqH5J0A6evgU7d2/1LfMiYpnxu8sbftpHsVyj033DKfBf9rXomlsaA8pmdaw56HsFErN3oZ7FrZ+3TUAvruIWf36IexIqFa2xT1NxkGkq2Da/4QVdBnNgPh6ei2kgZlhuRV48lElgHdFBlAKuSX73HnstDjaYt5bYryZP/V0wgwsOMG7F5uSsqNVX/eQ1W5q0rmqngbQzeJXjRwMJxe+HzOiD0ILe4vKYjKAIQ0nKXf4BuqK2x1WV7RLpwQBu0ZyDN+vq8v+JhPPlWf9TzkG4TQ+ekJHbNQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9MPjc3pYjMaF3zlHmKvsTdHbi/ZWIlemeEYr+khqxUk=;
 b=A3wR+6kSUKh3YBVqaKJ3Y5e0WKb6hoTOVc1zR7zyQq6baqO+Gexx5yCG1ZCWL7xgznCv9K7JaAHYKsQ/W8DiBDA3OTU3lGHuyq4VlYFuHDKAL7Lbewp6/GeXmHh5y91Pv4VHRLjCTzubd6l9s2YjMMUyZlaYyIdp7GsTzEWj//M=
Received: from DS0PR12MB6534.namprd12.prod.outlook.com (2603:10b6:8:c1::19) by
 LV8PR12MB9642.namprd12.prod.outlook.com (2603:10b6:408:295::7) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8880.17; Mon, 14 Jul 2025 14:24:50 +0000
Received: from DS0PR12MB6534.namprd12.prod.outlook.com
 ([fe80::ea87:74ba:36ec:8cf6]) by DS0PR12MB6534.namprd12.prod.outlook.com
 ([fe80::ea87:74ba:36ec:8cf6%5]) with mapi id 15.20.8901.023; Mon, 14 Jul 2025
 14:24:49 +0000
From: "Wheeler, Daniel" <Daniel.Wheeler@amd.com>
To: "LIPSKI, IVAN" <IVAN.LIPSKI@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
CC: "Wentland, Harry" <Harry.Wentland@amd.com>, "Li, Sun peng (Leo)"
 <Sunpeng.Li@amd.com>, "Pillai, Aurabindo" <Aurabindo.Pillai@amd.com>, "Li,
 Roman" <Roman.Li@amd.com>, "Lin, Wayne" <Wayne.Lin@amd.com>, "Chung,
 ChiaHsuan (Tom)" <ChiaHsuan.Chung@amd.com>, "Zuo, Jerry" <Jerry.Zuo@amd.com>, 
 "Wu, Ray" <Ray.Wu@amd.com>, "Hung, Alex" <Alex.Hung@amd.com>, "LIPSKI, IVAN"
 <IVAN.LIPSKI@amd.com>
Subject: RE: [PATCH 00/18] DC Patches July 7, 2025
Thread-Topic: [PATCH 00/18] DC Patches July 7, 2025
Thread-Index: AQHb8eHJNhbq41JtJEuH54akKexRe7QxpJ7w
Date: Mon, 14 Jul 2025 14:24:49 +0000
Message-ID: <DS0PR12MB65341C4C6D32FC4C5947FFB29C54A@DS0PR12MB6534.namprd12.prod.outlook.com>
References: <20250710212941.630259-1-IVAN.LIPSKI@amd.com>
In-Reply-To: <20250710212941.630259-1-IVAN.LIPSKI@amd.com>
Accept-Language: en-CA, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Enabled=True;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_SetDate=2025-07-14T14:24:34.0000000Z;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Name=Open
 Source; MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_ContentBits=3;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Method=Privileged
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS0PR12MB6534:EE_|LV8PR12MB9642:EE_
x-ms-office365-filtering-correlation-id: 3e14a0c8-4dbb-4f86-4b6f-08ddc2e230f0
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|1800799024|376014|366016|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?qfSZwzq1ZrtL7sTDZTHNyaBYlO8RDkhBE8Keuqsoclz+++KCKXPSjpmPAuck?=
 =?us-ascii?Q?vXzfqHNbHTjTx03j+Mk+V0kAwXHjfIUBoSA9RyfXnDDahjt1c1SybHT8y3tV?=
 =?us-ascii?Q?L+3PTDf5fo7GSRASHaVSlODu06l6NZy/EpWiHvUUmE8hvs/J71fdxYtkTzQF?=
 =?us-ascii?Q?BnYkJUIqcHCVqnm5BSIqt986/H7GQygdFvYTTRhgDq81jS5jeh9HbD0EdZ36?=
 =?us-ascii?Q?CL4WSnhpZujbExc8+E5NcqeSacnDRl1mmmRcBOlokKpLzuYeoLTRkwXttTwv?=
 =?us-ascii?Q?SKeCu5SMMhZkMBq9JQJx2+imVrCApkvt2aq2Cc8dpeWifq1HmOBT8tiBzMWg?=
 =?us-ascii?Q?o/qz9J0rfnH41Fz5lJ3zAG6ynOyZc068KAErm8Sagai6AoMBQtxcxOZCCwfS?=
 =?us-ascii?Q?/6fAW71rPEiaQI6e6GBXlsKctMXD/d01IHGCDmDsn+1hm6wN/AwmQeN04Oq4?=
 =?us-ascii?Q?tTRHXYuZWR7o2Ti5iIR9E+uNWtJ6WQD3hYhJ46sp6n3mNX93+o7Fwb0Trqgq?=
 =?us-ascii?Q?aMukFY3e3Uhue+sUPtO/MvCjfdpMCTJS5Fbi9yvE/gFxn9GhFo92mMuf/NR1?=
 =?us-ascii?Q?3AmwXNAGTKsQIBn2Jkw4i0WfOgk61KxSSARU9qlIuH7noyun2Q7A8kq4pLGX?=
 =?us-ascii?Q?BTFMNwy0ZtZR5HWURgXaKIGoZ0s1TyQD38AedXUWd+QK/L9B8uKFAeDhSSNv?=
 =?us-ascii?Q?G8IfOThIdVjpOWmNrrwta3WKGLqjXfdGqIxI8AQwf/7Q1/Qfasy//WUju9uW?=
 =?us-ascii?Q?LawtrR+ryD3zsP8gMTa5OtOmhv+cbvndjknYHt3gh7C84YZB8rUW0im5G3fJ?=
 =?us-ascii?Q?nhRHrEVxHe5fgJdCF/ne6LR8TxHVDp2KKDRA3yl/rp+gbpVuPwnB3QXhRojZ?=
 =?us-ascii?Q?8FbNvF9Ze1VoLQ/bNpg9sm3iBOv9kVdToqEs72WR5Anwqng16ptZD7jcxbO+?=
 =?us-ascii?Q?cPf5Eu9alQOZzM0adGeTooJLZmhEjSi/stew9RpVVcUusITxKNZ92Sygd6to?=
 =?us-ascii?Q?iN2Q1/2fEz2ktn0XRgJuQ3GVjhf/mk73DCOpWvlatQTYPmuPLbnfMdCJF3RB?=
 =?us-ascii?Q?Y7xWq4G6kmrw+CmkBGOWpqbmuXfNcx7eHzTC8ojH+gkpUcpFSWEaoaXgRhT/?=
 =?us-ascii?Q?4MMxtwsScUFeIWJenX8ufD3YqdL9ex9U+ZmO3os+Soyb1bFhElRg4IWc/v+M?=
 =?us-ascii?Q?WSbs2gjdOZnhTaycIxCmUDY87Sq/Q9S6sm8kvI242LDugJBPx1l4Lhy1OatG?=
 =?us-ascii?Q?3vkCEFO/U87Q5oyRxoZLRAzdbe8fJ4erKPTludgLGsaGGWHfXqD4+oU/AV7a?=
 =?us-ascii?Q?T5YWZZ8//xusfHDNoNhw6mo/dw0nlIg0ZJdYGIcRLwa3klvuFxYqyTF+3CXT?=
 =?us-ascii?Q?3wtv62UwF5gWRR1L8jCNC0cBDZUcOCEog4mP4rgB3OIvu1GETMjKrcL6FagK?=
 =?us-ascii?Q?c7+6JOdP7bjyjWV/o8Y9LmsYJmlxowpp1NFUoCWGAp6IlarG9L2tzg=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR12MB6534.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(38070700018); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?3+kfmayXdMIdPrdmwPXtGdClIMuAbydjrLI6iBsQqnOJmPmlNfmwhBtrE+8j?=
 =?us-ascii?Q?/wZyA+Hu+DG2HkvrHlds/NEPA3NvYx2NT3ueQzMsJFewSYL4/MZYeySgwBjK?=
 =?us-ascii?Q?kCXVL6NUkEU+AkE7yM14R35p3TiYUWZcwPiTa3p6mliLyZ2j8cP/PiA2OuVA?=
 =?us-ascii?Q?3CnYC9H/E4k21wtStmjNpNGLgDaqjdNCLavBQTfSPPldnPyxUAKPW/USwrm6?=
 =?us-ascii?Q?BcPAqKi3DOVMHWYuSey6m3nEQq/JMYYRE6nlYWvVwEISlV44Jpb/g/DeqprY?=
 =?us-ascii?Q?4VJjJUa5FDzD1GoHsyB7QeaQET5dQgJmGwYges8/2hI4EX92IqZkhtbT1ou9?=
 =?us-ascii?Q?pb2xAHFrSe0QjIIKskwLiB13KntDg0uisQZBx5IFL5jFLW1s7s/DqJ98i1dT?=
 =?us-ascii?Q?1eLitN+3KxnH4mpkkO5k9ItP44NHtTm6sRek55DOapVsRIJiG5hKJXA7RXYl?=
 =?us-ascii?Q?GkXxATNGlx67XJp3+0E4J7PJI5s3+g2dtpHzPeCPSMvzgULznl7meld2CB7f?=
 =?us-ascii?Q?T3L5lMk3lALOdRg5f1xs8n/mv7oBBFb+DCNGCnXAWjNgw28exKa1s8uU1N6/?=
 =?us-ascii?Q?ecGtRrbaPvc8WkWXEPOdzLKJvvafx54g/SDe3AunDDHDdlvSLXsgb2OXRjUT?=
 =?us-ascii?Q?R6L3j5x0u+HQdB+5J3AMeXSg0NsiTmN8vGYj4gv2/wkd7Pyxp7Ie5obnYxT6?=
 =?us-ascii?Q?rn/lISC4JgsrQ0453oZ7Yo1mqLr3j89k9riVbxHSYVxeNExgBbo4NZUssimz?=
 =?us-ascii?Q?qn9WxdVnvxvfKihqlsR1QIdP9bxh/T13zklRlrylWEmu/n1yoirlvjrmFOIh?=
 =?us-ascii?Q?IaPGFmJyjBP6wCl70BsWcDvdueNkjQSwfqZSCOsm3Ic+Lau0Es0kihPQXRdJ?=
 =?us-ascii?Q?AP8keDDa3LzD+0oEOIqK+kWv5kW5epnAsOf8yEHTOv1wYFGZ8Oy7EMJeuCdT?=
 =?us-ascii?Q?fwfKWwFKjT7EizwOvgfouGsxcAl2jWV6+G3QnJF5cxqOBTfjtJ3KmjTV4Nyc?=
 =?us-ascii?Q?fxInaN4aIhGlPFkKc3lqPYhrOStNFVLih+5fdwvpLFkvfA7Ou2TeO5ucmjyE?=
 =?us-ascii?Q?b0yLLAt6HLi/bIY+usB7DJk9LiJEzDM/8V0Ve5+EZdnzwedzFdh59lINJlkK?=
 =?us-ascii?Q?KtMwHo7ojz9BC6HP7QJy5zJUSLVDyofsYIKf0670kpBv+vv6ZbtoyaZi1J2/?=
 =?us-ascii?Q?pi9kTlV7y6rj4lAfbgfdU4Dmd5RUjiK+bmjt6OyvDlcRf7LZolizQzkLBGWe?=
 =?us-ascii?Q?V/VAjl++gL3wPS6hFL24702q++sO2NuvrZ7xEEmS5z/V4TI4a+FTLUdjsEei?=
 =?us-ascii?Q?7J+F1+N+MQCVmjdyar/OteYhGq2JMv63MQJXZ6Fk5StNmr5jmGbe9WFd4w8e?=
 =?us-ascii?Q?WRwTxtjbULTFiHvZ/s8k1NZdHsLEbriqh9OZxyK31QWsR+xEzpa+ovMmwtj6?=
 =?us-ascii?Q?KYwb0u2yUjbICK+jQV1VNZj8DjXuVzf4PWj4ocrW0BRov0Fuab69HhJrf9vd?=
 =?us-ascii?Q?iKtnlQA4eKu+BOMDqiHMfkYRO+mQWUQBuw3jGSEZLxGjYOFy3AgWQ7PHTHA/?=
 =?us-ascii?Q?JjACNfMxeaGnHJLBdpA=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB6534.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3e14a0c8-4dbb-4f86-4b6f-08ddc2e230f0
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Jul 2025 14:24:49.5879 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: FZp+a6Dop5Y7HQiJyUhQh0WaVMDcqfCgZMQ+6OVGDlZTcLovle+L8Hfn0zks/dsnjXm+MPft0QVGdCNOWgquaQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR12MB9642
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

The patchset consists of the amd-staging-drm-next branch (Head commit - ab6=
38da61c278a66ff51d44b89834444a0014894 ->drm/amdgpu: Replace HQD terminology=
 with slots naming) with new patches added on top of it.

Tested on Ubuntu 24.04.3, on Wayland and X11, using KDE Plasma and Gnome.

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
From: IVAN.LIPSKI@amd.com <IVAN.LIPSKI@amd.com>
Sent: Thursday, July 10, 2025 5:26 PM
To: amd-gfx@lists.freedesktop.org
Cc: Wentland, Harry <Harry.Wentland@amd.com>; Li, Sun peng (Leo) <Sunpeng.L=
i@amd.com>; Pillai, Aurabindo <Aurabindo.Pillai@amd.com>; Li, Roman <Roman.=
Li@amd.com>; Lin, Wayne <Wayne.Lin@amd.com>; Chung, ChiaHsuan (Tom) <ChiaHs=
uan.Chung@amd.com>; Zuo, Jerry <Jerry.Zuo@amd.com>; Wheeler, Daniel <Daniel=
.Wheeler@amd.com>; Wu, Ray <Ray.Wu@amd.com>; Hung, Alex <Alex.Hung@amd.com>=
; LIPSKI, IVAN <IVAN.LIPSKI@amd.com>
Subject: [PATCH 00/18] DC Patches July 7, 2025

From: Ivan Lipski <ivan.lipski@amd.com>

Title: DC Patches July 7, 2025

This DC patchset brings improvements in multiple areas. In summary, we high=
light:

* Fixes for DCN401, DCN32;
* Initial support of SmartMux;
* Improvements for Replay, IPS, and IPS2;
* Refactor of DSC;


Cc: Daniel Wheeler <daniel.wheeler@amd.com>



Aurabindo Pillai (1):
  drm/amd/display: Initial support for SmartMux

Charlene Liu (1):
  drm/amd/display: limit clear_update_flags to dcn32 and above

Clayton King (1):
  drm/amd/display: Free memory allocation

Dillon Varone (1):
  drm/amd/display: Refactor DSC cap calculations

Duncan Ma (2):
  drm/amd/display: Notify display idle on D3
  drm/amd/display: Notify DMUB on HW Release

Fudongwang (1):
  drm/amd/display: Monitor patch to ignore EDID audio SAB check

Ilya Bakoulin (1):
  drm/amd/display: Add definitions to support DID Type5 descriptors

Ivan Lipski (1):
  drm/amd/display: Revert "Add DPP & HUBP reset if power gate enabled on
    DCN314"

Karthi Kandasamy (1):
  drm/amd/display: Make dcn401_initialize_min_clocks() available to
    other compilation units

Leo Chen (3):
  drm/amd/display: Adding missing driver code for IPSv2.0
  drm/amd/display: Add static pg implementations for future use
  drm/amd/display: New Behavior for debug option disable_ips_in_vpb

Melissa Wen (1):
  drm/amd/display: Disable CRTC degamma LUT for DCN401

Michael Strauss (1):
  drm/amd/display: Fix FIXED_VS retimer clock gen source override

Ovidiu Bunea (2):
  drm/amd/display: Add support for Panel Replay on DP1 eDP
    (panel_inst=3D1)
  drm/amd/display: Add HPO encoder support to Replay

Yihan Zhu (1):
  drm/amd/display: MPC basic allocation logic and TMZ

 .../amd/display/amdgpu_dm/amdgpu_dm_crtc.c    |  11 +-
 .../gpu/drm/amd/display/dc/clk_mgr/Makefile   |   2 +-
 .../gpu/drm/amd/display/dc/clk_mgr/clk_mgr.c  |   2 +-
 .../drm/amd/display/dc/clk_mgr/dcn30/dalsmc.h |   3 +-
 .../display/dc/clk_mgr/dcn30/dcn30_clk_mgr.c  |   4 +-
 .../display/dc/clk_mgr/dcn30/dcn30m_clk_mgr.c |  36 ++++  .../display/dc/c=
lk_mgr/dcn30/dcn30m_clk_mgr.h |  31 +++  .../dc/clk_mgr/dcn30/dcn30m_clk_mg=
r_smu_msg.c | 118 +++++++++++  .../dc/clk_mgr/dcn30/dcn30m_clk_mgr_smu_msg.=
h |  34 ++++
 .../dc/clk_mgr/dcn401/dcn401_clk_mgr.c        |  33 ++-
 .../dc/clk_mgr/dcn401/dcn401_clk_mgr.h        |   2 +
 drivers/gpu/drm/amd/display/dc/core/dc.c      |  16 +-
 .../drm/amd/display/dc/core/dc_hw_sequencer.c |  26 +++
 .../gpu/drm/amd/display/dc/core/dc_resource.c |   4 +-
 .../gpu/drm/amd/display/dc/core/dc_state.c    |   2 +
 .../gpu/drm/amd/display/dc/core/dc_stream.c   |  67 ++++++
 drivers/gpu/drm/amd/display/dc/dc.h           |  23 +++
 drivers/gpu/drm/amd/display/dc/dc_dmub_srv.c  |  75 +++++--
 drivers/gpu/drm/amd/display/dc/dc_dmub_srv.h  |   6 +
 drivers/gpu/drm/amd/display/dc/dc_stream.h    |  11 +
 drivers/gpu/drm/amd/display/dc/dc_types.h     |   3 +
 .../gpu/drm/amd/display/dc/dce/dmub_replay.c  |  43 +++-
 .../gpu/drm/amd/display/dc/dce/dmub_replay.h  |   2 +-
 drivers/gpu/drm/amd/display/dc/dsc/dc_dsc.c   | 192 +++++++++++++++---
 .../amd/display/dc/dsc/dcn401/dcn401_dsc.c    |  24 +--
 .../amd/display/dc/dsc/dcn401/dcn401_dsc.h    |   1 -
 drivers/gpu/drm/amd/display/dc/dsc/dsc.h      |   1 +
 .../amd/display/dc/hubp/dcn401/dcn401_hubp.c  |   4 +-
 .../amd/display/dc/hubp/dcn401/dcn401_hubp.h  |   2 +-
 .../amd/display/dc/hwss/dce110/dce110_hwseq.c |  24 +++
 .../amd/display/dc/hwss/dcn10/dcn10_hwseq.c   |   2 +-
 .../amd/display/dc/hwss/dcn31/dcn31_hwseq.c   |  13 ++
 .../amd/display/dc/hwss/dcn314/dcn314_hwseq.c |  37 +---
 .../amd/display/dc/hwss/dcn314/dcn314_hwseq.h |   2 -
 .../amd/display/dc/hwss/dcn314/dcn314_init.c  |   2 +-
 .../amd/display/dc/hwss/dcn401/dcn401_hwseq.c |  14 +-
 .../amd/display/dc/hwss/dcn401/dcn401_hwseq.h |   1 +
 .../drm/amd/display/dc/hwss/hw_sequencer.h    |   3 +
 .../gpu/drm/amd/display/dc/inc/core_types.h   |   3 +
 .../gpu/drm/amd/display/dc/inc/hw/clk_mgr.h   |  14 ++
 drivers/gpu/drm/amd/display/dc/inc/hw/hubp.h  |   2 +-
 .../gpu/drm/amd/display/dc/inc/hw/pg_cntl.h   |   2 +
 .../link_hwss_hpo_fixed_vs_pe_retimer_dp.c    |   2 +-
 .../gpu/drm/amd/display/dc/link/link_dpms.c   |  19 +-
 .../drm/amd/display/dc/link/link_factory.c    |   8 +-
 .../dc/link/protocols/link_dp_capability.c    |  19 ++
 .../link/protocols/link_edp_panel_control.c   |  19 +-
 .../link/protocols/link_edp_panel_control.h   |   1 +
 .../dc/resource/dcn20/dcn20_resource.c        |   2 +
 .../dc/resource/dcn201/dcn201_resource.c      |   2 +
 .../dc/resource/dcn21/dcn21_resource.c        |   2 +
 .../dc/resource/dcn30/dcn30_resource.c        |   2 +
 .../dc/resource/dcn301/dcn301_resource.c      |   2 +
 .../dc/resource/dcn302/dcn302_resource.c      |   2 +
 .../dc/resource/dcn303/dcn303_resource.c      |   2 +
 .../dc/resource/dcn31/dcn31_resource.c        |   2 +
 .../dc/resource/dcn314/dcn314_resource.c      |   2 +
 .../dc/resource/dcn315/dcn315_resource.c      |   2 +
 .../dc/resource/dcn316/dcn316_resource.c      |   2 +
 .../dc/resource/dcn32/dcn32_resource.c        |   2 +
 .../dc/resource/dcn321/dcn321_resource.c      |   2 +
 .../dc/resource/dcn35/dcn35_resource.c        |   2 +
 .../dc/resource/dcn351/dcn351_resource.c      |   2 +
 .../dc/resource/dcn36/dcn36_resource.c        |   2 +
 .../dc/resource/dcn401/dcn401_resource.c      |   2 +
 .../gpu/drm/amd/display/dmub/inc/dmub_cmd.h   |  36 +++-
 .../amd/display/modules/power/power_helpers.h |   2 +
 67 files changed, 912 insertions(+), 125 deletions(-)  create mode 100644 =
drivers/gpu/drm/amd/display/dc/clk_mgr/dcn30/dcn30m_clk_mgr.c
 create mode 100644 drivers/gpu/drm/amd/display/dc/clk_mgr/dcn30/dcn30m_clk=
_mgr.h
 create mode 100644 drivers/gpu/drm/amd/display/dc/clk_mgr/dcn30/dcn30m_clk=
_mgr_smu_msg.c
 create mode 100644 drivers/gpu/drm/amd/display/dc/clk_mgr/dcn30/dcn30m_clk=
_mgr_smu_msg.h

--
2.43.0

