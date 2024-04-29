Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3CA00C4345F
	for <amd-gfx@archiver.kernel.org>; Mon, 29 Apr 2024 13:17:42 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8C95A10EF86;
	Mon, 29 Apr 2024 13:17:41 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="DNSkt9pj";
	dkim-atps=neutral
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2071.outbound.protection.outlook.com [40.107.236.71])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8EA5710EF3F
 for <amd-gfx@lists.freedesktop.org>; Mon, 29 Apr 2024 13:17:39 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RXBjD9izZ12Ys9ErSZGZiG5MTWp2yYWwo0gSG3njNL+zsgRsdSin1/FCqGR6WDz0D67DDbXa5z7lDiwLjTYvCBuEl1B425cKihoNrCVgvo35XQz9ZfwE/1jsXrMKvam0QeYbvExwxrJInOdcLwArps4jsHYD+vYu4XaqcPjdYQ0SVg+kIZF67BHyB0ckp9+opKSt4u0QEDs1TiouCEB0t2YORqHy84SEAHxdUXaFUuhN89s+O0XXmnK5ApFj88h8kyqxcP3PS+lQ60CFJIqFfaitF/MHcitEkBQRhjG/yTdnWwDQ2dxBPakNFwJUDbjXmVMsB9RcfX6pzVNaCpHKCg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=d6/Rzyx549LBitvqHBBlkKboTnVDc1b09xAxS7DNTX4=;
 b=BIY5+hJRRnHKDsC2ITIm10E+ZoB8U9HvHasQeYc3XsM9r0OmR6igCkMGBwnchjK0EjhM60x9Egs/sXt+vMAUU/j7pWJysXl31SHd5kpclFUL2H5f5M+EcmCMYZv0t7sIRaOcJiddqMUqTViozCcIPrTG9gOKSV8KHr19VraSCq5godxwc78NTcpXPtzonhDpxsN5f2mAl4x2jt9DvdC63GkMnG9tp58nVTcpt0qgDSj5Lv6D0d4fC6IQ04oFlfiVebr+PIhzBosVLhM+UF1oGoU8vvFK+L1MEMIPHMUjVQsekzGAB/WA91Oc4aitBFlC3QfFDbTDFamLpAgTGuKfrw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=d6/Rzyx549LBitvqHBBlkKboTnVDc1b09xAxS7DNTX4=;
 b=DNSkt9pjGYPNCMgLanbT3GqNk80aBd1qzXX+w0BfUcOz6T8a1ItXMLE3Qhrb1Yui4cCdhV+UHESvklAxEPA9KcI/uihAaruoMjNEVKhv5UzhMSCZysfIL7TPvuMTQIxHZw+L/nH1PGgC27JtfTtjJH+8EFC8wsg09UTzqUa7VS0=
Received: from DS0PR12MB6534.namprd12.prod.outlook.com (2603:10b6:8:c1::19) by
 CH2PR12MB4328.namprd12.prod.outlook.com (2603:10b6:610:a6::14) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7519.34; Mon, 29 Apr 2024 13:17:36 +0000
Received: from DS0PR12MB6534.namprd12.prod.outlook.com
 ([fe80::ea87:74ba:36ec:8cf6]) by DS0PR12MB6534.namprd12.prod.outlook.com
 ([fe80::ea87:74ba:36ec:8cf6%4]) with mapi id 15.20.7519.031; Mon, 29 Apr 2024
 13:17:36 +0000
From: "Wheeler, Daniel" <Daniel.Wheeler@amd.com>
To: "Lin, Wayne" <Wayne.Lin@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
CC: "Wentland, Harry" <Harry.Wentland@amd.com>, "Li, Sun peng (Leo)"
 <Sunpeng.Li@amd.com>, "Siqueira, Rodrigo" <Rodrigo.Siqueira@amd.com>,
 "Pillai, Aurabindo" <Aurabindo.Pillai@amd.com>, "Li, Roman"
 <Roman.Li@amd.com>, "Lin, Wayne" <Wayne.Lin@amd.com>, "Gutierrez, Agustin"
 <Agustin.Gutierrez@amd.com>, "Chung, ChiaHsuan (Tom)"
 <ChiaHsuan.Chung@amd.com>, "Wu, Hersen" <hersenxs.wu@amd.com>, "Zuo, Jerry"
 <Jerry.Zuo@amd.com>, "Lin, Wayne" <Wayne.Lin@amd.com>
Subject: RE: [PATCH 00/46] DC Patches April 29, 2024
Thread-Topic: [PATCH 00/46] DC Patches April 29, 2024
Thread-Index: AQHaliRiIkeRVAJQyECKoQjOsrvEv7F/Qj8A
Date: Mon, 29 Apr 2024 13:17:36 +0000
Message-ID: <DS0PR12MB6534FCF2871BAFB4B539027D9C1B2@DS0PR12MB6534.namprd12.prod.outlook.com>
References: <20240424084931.2656128-1-Wayne.Lin@amd.com>
In-Reply-To: <20240424084931.2656128-1-Wayne.Lin@amd.com>
Accept-Language: en-CA, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ActionId=738c945c-abdb-4e84-998b-c7770fb794f3;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ContentBits=0;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Enabled=true;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Method=Privileged;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Name=Public-AIP
 2.0;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SetDate=2024-04-29T13:17:31Z;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS0PR12MB6534:EE_|CH2PR12MB4328:EE_
x-ms-office365-filtering-correlation-id: 6aae529f-074a-4e77-4517-08dc684ebcad
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230031|376005|1800799015|366007|38070700009;
x-microsoft-antispam-message-info: =?us-ascii?Q?LGu5QHHrEJyWn1oOrx5so4Kon8JZAzhRJtn5sLoR/D7Bh6Lme+pvVWsEvkvE?=
 =?us-ascii?Q?ab9rwGOU+dyXTBK09PElcbj90FQlT91BL+oiavlS1wwfN0pwJdgrOdq0DPJx?=
 =?us-ascii?Q?cxxTuF4rdvxHOIfn2Cfvq/wOUb1f579QYxYEJn/YAYpCQCn74TJPj2UUSUMV?=
 =?us-ascii?Q?4/HcsBKZW/o0xORk77c+g8zZSJ2mdlhi5W7AROIIjYVabKexF8S2ASoFjYjC?=
 =?us-ascii?Q?hKAwBOmjGJhmqPRoKCriVYQX/6boO4Uqo7oCe9CJfGAFIA2Sih4XjDaNS/yg?=
 =?us-ascii?Q?Hfws/YYPF8KjoaEuv1LUSg/r/DOVmiqLOH77BQwM0TBTiBQaNtpxXYG8Y7Ct?=
 =?us-ascii?Q?v1eTbbaAN2ZUpO9sDypMc9Pf74G9U/1wVLZNmBEFeyXoJOeoYMnIljxW5/GL?=
 =?us-ascii?Q?sfYhlk12TTLPtapKDZpTBgxT8w6CsXggyFg134DUhawV/ZsqzCW+TCOX5hcj?=
 =?us-ascii?Q?h8IXmLtA9l5Ok+OJf7eCB8jboa58PLjw3CkQeMBQSEhWMXZSDNC1X21X7l/q?=
 =?us-ascii?Q?G7V2B3+tv2yoy15JddOOpDaQ1Ttru+e6GSuoMdsSXMsHzTKaq5dgEwUdVyNV?=
 =?us-ascii?Q?MpDpyewNZ0RAqhmQFgvlHxSoMwkFTIQAslOXMCj7H9uVDc+8LeqKRLCW+gDM?=
 =?us-ascii?Q?6mRxM5AcObnKf+QYQ+K0E1F8rGf/gtlc+ndBGMkEVMjhEoz6zz4M1j31dBXW?=
 =?us-ascii?Q?Waefa9u8N3r37qQfLC7xN10BaBipgN55ram0UYUNMAqFd6IvmU+BfaifMgCZ?=
 =?us-ascii?Q?hWOEaPKOYEbWIlkqgQcC8ZjZun2gAOsEJsInQ0AiCOFrAACoklqZJOYOEpjd?=
 =?us-ascii?Q?a5ghGs7VB+istk5R9MnSx04g9frDWUIMaRsi3JnckV/8ZfqL10SO6McXE+vN?=
 =?us-ascii?Q?7m7IIRCCCffyxvLghQp9GwtylYsJWx+gEMmTSAwhlzA4q3hQV2QlNspsTtGG?=
 =?us-ascii?Q?i5BDe3+edVrJKtqCb/ozxk9LWXxTiQuCMVcRBjz1aW7xvW+pv4WJf6csqutb?=
 =?us-ascii?Q?ONJ+0Yj3Yw3EVMKQgAaULEanqqZ53MWe48EBEELGMq25g+v+vaX5iDuCPTk1?=
 =?us-ascii?Q?5uC3Jv7iYGJ1DEUm78sM9+1tXQUjD2Q7d0RqOiEwYGz3kyB/eKbVYW8PMLho?=
 =?us-ascii?Q?iyAZOcUgyJP7x4brz678I6S+KQXOfmm+fOkYp9yoKoqTpthNy/KkEaVV7LWK?=
 =?us-ascii?Q?xGO8hVOYor8OnloqNsOniQ9/IGWmDeuJhsNtozuIOnmSjyRLBLcnboyvkpJW?=
 =?us-ascii?Q?VZuuNJPRHojVehp+OekWG1IeKx1mqABDofDSidNk270FPyMGKdR2GozLIRDh?=
 =?us-ascii?Q?rjtIUvNz9e0To0Hv41fz8sjHJmGNaaB4dnIah1KXAUovzQ=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR12MB6534.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(376005)(1800799015)(366007)(38070700009); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?7Jo2Cigsx0u6nRZ7ABzQLbn9cd8+Ux6/xoLfwXyTbJ1MaiHrUtXM9LK759aV?=
 =?us-ascii?Q?ENHCHolg2uIKsvkczAcBErzrXDtKFGYBN/OAde7rclS9dv6IbftNzwNXQgUv?=
 =?us-ascii?Q?uyS4e+ixiRyTpgde2rOcOtzIOr8IYc9urY9l+dRGOhT4xdktJf/4miVJWaVG?=
 =?us-ascii?Q?MWZTuam3zvtSUpJu76gz1rC3pETC7YoE9Mp1j9hOTBCpWVpry1eli1yTbmTT?=
 =?us-ascii?Q?HLMJLRgzMKesDTkvwMVbht6/MrW0YXYu9cqHXt8bW0jiWmQysfV2gZ/y52j+?=
 =?us-ascii?Q?/Ihpf7mITiBCVjct7Yzn8xTXVWZQ8Ndy+XUtMoP+6IOw5UMFAA4hAthZ4Y8J?=
 =?us-ascii?Q?evVIDWqSWID5QFN4s+FnUgXPRfQzeQWkOdjbndCtrTuO7FrNEpG6v7/U6amS?=
 =?us-ascii?Q?Bs1kgLPOrOQ1XOX0rlseLR2UHJeTX7X3M5ahRql2IFPR+qeRQmpIQMJmh3aA?=
 =?us-ascii?Q?GZTAHp2rtiLYffX+AEJPejR5JAUMLk9+ukYY5dB384Fz1Cze8Ox3NifUBDVz?=
 =?us-ascii?Q?+t+gQkTIBIL8/cdBJXuVEg/Ja6l6Uhcdhep31Z/APUMWD9HN5weNBjUUE5ED?=
 =?us-ascii?Q?XaqjbpbrJUC+MQIkckjTpA+rgija8IQBXE4ES5DuHaFoqhfNcobvBWliEhNi?=
 =?us-ascii?Q?qQXn+Nsw+0RefTMGadlfgiGxwZ5wszLW96Z2X9jnjWR+UQniAUvr2aPB3r1+?=
 =?us-ascii?Q?TmZd48ylpFSVOGLSmF8t+WWMUVqEr+xE0B6zgPqt3f7ct+0frVBFe9we7kTa?=
 =?us-ascii?Q?yKdDTo2gkBcBTngqzCi9Vhfd6EauBaKvT6urzQ0AEuMDRLX3eHwzyKxOJrY1?=
 =?us-ascii?Q?FCbmYgYJLDfjBLD+JfYXjO9ZwlLk93f74z9gDXpw7AkTdbR5i6NQUO9rUJk1?=
 =?us-ascii?Q?dQdP5WiWt3TDp/BXf0JA5mFCDsObcLwG8VIW5i7yXxEPJBFYMYDLaHmg3Kzk?=
 =?us-ascii?Q?UGUlAYJwg+9ok0qHyrEc8An/uCVx5XgUrcKsEFhJxQanSK2a7HzXu0uGo6mP?=
 =?us-ascii?Q?r8tXtP2YiORj/5i8rk5w/ZUtcnZSJPNA1GTQx4OAxILCfqJ+Lg3pkaXBcWP/?=
 =?us-ascii?Q?YXCYas7rQDKe2o/fneDzUPJNcun+ZFk3kJFgxnJ1z4sV9dtd0XmA+xPCQ3g5?=
 =?us-ascii?Q?vwFzhqSq4ccDKFpeLR04KrQH57lHrxTvrLKrlI242fhgu1oTRe9yfmELYh8N?=
 =?us-ascii?Q?8s28lhP9ZsiSbKGYVNka7bhwpvJhEQR+XhDOhiiougOzGSlhycurrPY3uAzY?=
 =?us-ascii?Q?lxTyPzggse8Q/2jhLGeKrgg822E8wC8PlIbUXPMvQPWmid4jzJiKJnBznIl9?=
 =?us-ascii?Q?FFdCU1FirgppP03rNh6Watsy3vNo7qm9QNx+3BRmOiQx9PYKO5riDiZaTnAq?=
 =?us-ascii?Q?qePv+xKDipU9/BCazZpm9Qndq0xkvLGYVxQoSE+EVqdQ92l+zIX2RMmlR9To?=
 =?us-ascii?Q?Ph3vNhyYcf7ljUkgKzRgJzPjchcsK42oc7x3xs1tCCUTrtCTI/lknB5Xlv/s?=
 =?us-ascii?Q?PSwx7SGGYs04Vj5pIqacjpGkC4/MUhgz7BwPU1KgSqtWmV4XfotVZigNiSdo?=
 =?us-ascii?Q?5f0TbQvM2HuECdAQZY4=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB6534.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6aae529f-074a-4e77-4517-08dc684ebcad
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Apr 2024 13:17:36.1355 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: aqOzQRRC3qFRSyPSI/lzxYdQ/JkA2kW1O0rhnIdxlqrNqImQv1E2R4sa6OCXNsOff8qVDXEUJhXcpvSF9rj3Fw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4328
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

The patchset consists of the amd-staging-drm-next branch (Head commit - 6fd=
f2d7a8aaa drm/amd/display: 3.2.282) with new patches added on top of it.

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
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Wayne Li=
n
Sent: Wednesday, April 24, 2024 4:49 AM
To: amd-gfx@lists.freedesktop.org
Cc: Wentland, Harry <Harry.Wentland@amd.com>; Li, Sun peng (Leo) <Sunpeng.L=
i@amd.com>; Siqueira, Rodrigo <Rodrigo.Siqueira@amd.com>; Pillai, Aurabindo=
 <Aurabindo.Pillai@amd.com>; Li, Roman <Roman.Li@amd.com>; Lin, Wayne <Wayn=
e.Lin@amd.com>; Gutierrez, Agustin <Agustin.Gutierrez@amd.com>; Chung, Chia=
Hsuan (Tom) <ChiaHsuan.Chung@amd.com>; Wu, Hersen <hersenxs.wu@amd.com>; Zu=
o, Jerry <Jerry.Zuo@amd.com>; Lin, Wayne <Wayne.Lin@amd.com>
Subject: [PATCH 00/46] DC Patches April 29, 2024

This DC patchset brings improvements in multiple areas. In summary, we high=
light:

- Disable seamless boot on 128b/132b encoding
- Change ASSR disable sequence to avoid corruption
- Fix few IPS problems
- Enable Replay for DCN315
- Fix few ODM problems
- Fix FEC_READY write timing
- Fix few FPO problems
- Adjust DML21 gpuvm_enable assignment
- Fix divide by 0 error in VM environment
- Fix few DCN35 problems
- Fix flickering on DCN321
- Fix mst resume problem
- Fix multi-disp FAMS problem
- Refactor Replay
- Update some of the dcn303 parameters
- Enable legacy fast update for dcn301
- Add VCO parameter for DCN31 FPU
- Have cursor and surface updates together
- Fix problems reported by Coverity

---
Alex Hung (9):
  drm/amd/display: Check index msg_id before read or write
  drm/amd/display: Check pipe offset before setting vblank
  drm/amd/display: Skip finding free audio for unknown engine_id
  drm/amd/display: Do not return negative stream id for array
  drm/amd/display: ASSERT when failing to find index by plane/stream id
  drm/amd/display: Remove redundant include file
  drm/amd/display: Fix uninitialized variables in DM
  drm/amd/display: Fix uninitialized variables in DC
  drm/amd/display: Fix uninitialized variables in DC

Alvin Lee (3):
  drm/amd/display: Only program P-State force if pipe config changed
  drm/amd/display: Assign linear_pitch_alignment even for VM
  drm/amd/display: For FPO + Vactive check that all pipes support VA

Aric Cyr (1):
  drm/amd/display: 3.2.283

Daniel Miess (1):
  drm/amd/display: Enable RCO for PHYSYMCLK in DCN35

Dennis Chan (1):
  drm/amd/display: Refactor for Replay Link off frame count

Harry Wentland (2):
  drm/amd/display: Do cursor programming with rest of pipe
  drm/amd/display: Always use legacy way of setting cursor on DCE

Hersen Wu (2):
  drm/amd/display: Add NULL pointer check for kzalloc
  drm/amd/display: Fix overlapping copy within dml_core_mode_programming

Ilya Bakoulin (1):
  drm/amd/display: Fix FEC_READY write on DP LT

Iswara Nagulendran (1):
  drm/amd/display: Restrict multi-disp support for in-game FAMS

Joan Lee (1):
  drm/amd/display: Enable Replay for DCN315

Leo Ma (1):
  drm/amd/display: Fix DC mode screen flickering on DCN321

Nevenko Stupar (1):
  drm/amd/display: gpuvm handling in DML21

Nicholas Kazlauskas (2):
  drm/amd/display: Add trigger FIFO resync path for DCN35
  drm/amd/display: Notify idle link detection through shared state

Revalla Hari Krishna (1):
  drm/amd/display: Refactor HUBBUB into component folder

Rodrigo Siqueira (10):
  drm/amd/display: Improve registers write
  drm/amd/display: Add missing SMU version
  drm/amd/display: Adjust codestyle for dcn31 and hdcp_msg
  drm/amd/display: Add VCO speed parameter for DCN31 FPU
  drm/amd/display: Adjust functions prefix for some of the dcn301 fpu
    functions
  drm/amd/display: Enable legacy fast update for dcn301
  drm/amd/display: Update some of the dcn303 parameters
  drm/amd/display: Remove legacy code in DC
  drm/amd/display: Add log_color_state callback to multiple DCNs
  drm/amd/display: Handle the case which quad_part is equal 0

Roman Li (2):
  drm/amd/display: Re-enable IPS2 for static screen
  drm/amd/display: Add periodic detection for IPS

Sung Joon Kim (1):
  drm/amd/display: Disable seamless boot on 128b/132b encoding

Swapnil Patel (1):
  drm/amd/display: Change ASSR disable sequence

Wayne Lin (2):
  drm/amd/display: Remove unnecessary files
  drm/amd/display: Defer handling mst up request in resume

Webb Chen (1):
  drm/amd/display: Revert "dc: Keep VBios pixel rate div setting util
    next mode set"

Wenjing Liu (2):
  drm/amd/display: take ODM slice count into account when deciding DSC
    slice
  drm/amd/display: use even ODM slice width for two pixels per container

 drivers/gpu/drm/amd/display/Makefile          |   1 +
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 105 ++++++++++++++++--
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h |   9 ++
 .../amd/display/amdgpu_dm/amdgpu_dm_crtc.c    |  59 +++++++++-
 .../amd/display/amdgpu_dm/amdgpu_dm_debugfs.c |   4 +-
 .../amd/display/amdgpu_dm/amdgpu_dm_helpers.c |   5 +-
 .../amd/display/amdgpu_dm/amdgpu_dm_plane.c   |   4 +-
 .../amd/display/amdgpu_dm/amdgpu_dm_plane.h   |   3 +
 .../drm/amd/display/amdgpu_dm/amdgpu_dm_psr.c |  28 +++++
 .../drm/amd/display/amdgpu_dm/amdgpu_dm_psr.h |   1 +
 drivers/gpu/drm/amd/display/dc/Makefile       |   2 +-
 .../drm/amd/display/dc/bios/command_table.c   |   2 +-
 .../drm/amd/display/dc/bios/command_table2.c  |   2 +-
 .../display/dc/clk_mgr/dcn30/dcn30_clk_mgr.c  |   8 ++
 .../display/dc/clk_mgr/dcn32/dcn32_clk_mgr.c  |  23 +++-
 drivers/gpu/drm/amd/display/dc/core/dc.c      |  13 ++-
 .../gpu/drm/amd/display/dc/core/dc_resource.c |  24 +++-
 .../gpu/drm/amd/display/dc/core/dc_stream.c   |  14 +--
 .../drm/amd/display/dc/core/dc_vm_helper.c    |   1 +
 drivers/gpu/drm/amd/display/dc/dc.h           |  11 +-
 drivers/gpu/drm/amd/display/dc/dc_dmub_srv.c  |  30 +++++  drivers/gpu/drm=
/amd/display/dc/dc_dmub_srv.h  |  10 ++
 drivers/gpu/drm/amd/display/dc/dc_stream.h    |  12 ++
 drivers/gpu/drm/amd/display/dc/dc_types.h     |   2 +-
 .../dc/dce110/dce110_timing_generator.c       |  18 +++
 .../dc/dce110/dce110_timing_generator.h       |   2 +
 .../dc/dce110/dce110_timing_generator_v.c     |   3 +-
 .../dc/dce120/dce120_timing_generator.c       |   1 +
 .../display/dc/dce80/dce80_timing_generator.c |   1 +
 drivers/gpu/drm/amd/display/dc/dcn10/Makefile |   2 +-
 .../dc/dcn10/dcn10_hw_sequencer_debug.c       |   2 +-
 drivers/gpu/drm/amd/display/dc/dcn20/Makefile |   2 +-
 .../gpu/drm/amd/display/dc/dcn201/Makefile    |   3 +-
 drivers/gpu/drm/amd/display/dc/dcn21/Makefile |   2 +-
 drivers/gpu/drm/amd/display/dc/dcn30/Makefile |   3 +-
 .../gpu/drm/amd/display/dc/dcn30/dcn30_mpc.c  |   2 +-
 .../gpu/drm/amd/display/dc/dcn301/Makefile    |   2 +-
 drivers/gpu/drm/amd/display/dc/dcn31/Makefile |   2 +-
 .../drm/amd/display/dc/dcn314/dcn314_dccg.c   |  12 +-
 drivers/gpu/drm/amd/display/dc/dcn32/Makefile |   2 +-
 .../gpu/drm/amd/display/dc/dcn32/dcn32_dccg.c |  12 +-
 .../dc/dcn32/dcn32_dio_stream_encoder.c       |  40 ++++++-
 .../display/dc/dcn32/dcn32_resource_helpers.c |   6 +-
 drivers/gpu/drm/amd/display/dc/dcn35/Makefile |   2 +-
 .../gpu/drm/amd/display/dc/dcn35/dcn35_dccg.c |  63 +++--------
 .../dc/dcn35/dcn35_dio_stream_encoder.c       |  36 +++++-
 drivers/gpu/drm/amd/display/dc/dm_pp_smu.h    |   3 +-
 .../drm/amd/display/dc/dml/dcn20/dcn20_fpu.c  |   4 +-
 .../drm/amd/display/dc/dml/dcn30/dcn30_fpu.c  |   2 +-
 .../amd/display/dc/dml/dcn301/dcn301_fpu.c    |   4 +-
 .../amd/display/dc/dml/dcn301/dcn301_fpu.h    |   7 +-
 .../drm/amd/display/dc/dml/dcn31/dcn31_fpu.c  |  22 +---  .../drm/amd/disp=
lay/dc/dml/dcn32/dcn32_fpu.c  |  22 +++-
 .../drm/amd/display/dc/dml/dcn32/dcn32_fpu.h  |   2 +-
 .../dc/dml/dcn32/display_mode_vba_util_32.c   |   4 +-
 .../amd/display/dc/dml2/display_mode_core.c   |   4 +-
 .../dc/dml2/dml21/dml21_translation_helper.c  |   2 +-
 .../display/dc/dml2/dml2_dc_resource_mgmt.c   |   8 +-
 .../display/dc/dml2/dml2_translation_helper.c |   6 +-
 .../drm/amd/display/dc/dml2/dml2_wrapper.h    |   1 +
 .../amd/display/dc/dpp/dcn10/CMakeLists.txt   |   6 -
 .../amd/display/dc/dpp/dcn10/dcn10_dpp_cm.c   |   5 +-
 .../amd/display/dc/dpp/dcn20/CMakeLists.txt   |   5 -
 .../amd/display/dc/dpp/dcn20/dcn20_dpp_cm.c   |   2 +-
 .../amd/display/dc/dpp/dcn201/CMakeLists.txt  |   4 -
 .../amd/display/dc/dpp/dcn30/CMakeLists.txt   |   5 -
 .../amd/display/dc/dpp/dcn30/dcn30_dpp_cm.c   |   2 +-
 .../amd/display/dc/dpp/dcn32/CMakeLists.txt   |   4 -
 .../amd/display/dc/dpp/dcn35/CMakeLists.txt   |   4 -
 drivers/gpu/drm/amd/display/dc/dsc/dc_dsc.c   |  30 +++--
 .../drm/amd/display/dc/gpio/gpio_service.c    |   6 +-
 .../gpu/drm/amd/display/dc/hdcp/hdcp_msg.c    |   2 +-
 .../gpu/drm/amd/display/dc/hubbub/Makefile    | 100 +++++++++++++++++
 .../dc/{ =3D> hubbub}/dcn10/dcn10_hubbub.c      |   2 +-
 .../dc/{ =3D> hubbub}/dcn10/dcn10_hubbub.h      |   0
 .../dc/{ =3D> hubbub}/dcn20/dcn20_hubbub.c      |   0
 .../dc/{ =3D> hubbub}/dcn20/dcn20_hubbub.h      |   2 +-
 .../dc/{ =3D> hubbub}/dcn201/dcn201_hubbub.c    |   0
 .../dc/{ =3D> hubbub}/dcn201/dcn201_hubbub.h    |   0
 .../dc/{ =3D> hubbub}/dcn21/dcn21_hubbub.c      |   0
 .../dc/{ =3D> hubbub}/dcn21/dcn21_hubbub.h      |   0
 .../dc/{ =3D> hubbub}/dcn30/dcn30_hubbub.c      |   0
 .../dc/{ =3D> hubbub}/dcn30/dcn30_hubbub.h      |   0
 .../dc/{ =3D> hubbub}/dcn301/dcn301_hubbub.c    |   0
 .../dc/{ =3D> hubbub}/dcn301/dcn301_hubbub.h    |   0
 .../dc/{ =3D> hubbub}/dcn31/dcn31_hubbub.c      |   0
 .../dc/{ =3D> hubbub}/dcn31/dcn31_hubbub.h      |   0
 .../dc/{ =3D> hubbub}/dcn32/dcn32_hubbub.c      |   0
 .../dc/{ =3D> hubbub}/dcn32/dcn32_hubbub.h      |   0
 .../dc/{ =3D> hubbub}/dcn35/dcn35_hubbub.c      |   0
 .../dc/{ =3D> hubbub}/dcn35/dcn35_hubbub.h      |   0
 drivers/gpu/drm/amd/display/dc/hwss/Makefile  |   6 -
 .../amd/display/dc/hwss/dce110/dce110_hwseq.c |  28 +----
 .../amd/display/dc/hwss/dcn10/dcn10_hwseq.c   |   6 +-
 .../amd/display/dc/hwss/dcn20/dcn20_hwseq.c   |  42 ++++---
 .../amd/display/dc/hwss/dcn201/dcn201_hwseq.c |   7 +-
 .../amd/display/dc/hwss/dcn21/dcn21_hwseq.c   |   2 +-
 .../amd/display/dc/hwss/dcn21/dcn21_init.c    |   1 +
 .../amd/display/dc/hwss/dcn30/dcn30_hwseq.h   |   2 +-
 .../amd/display/dc/hwss/dcn30/dcn30_init.c    |   1 +
 .../amd/display/dc/hwss/dcn301/dcn301_init.c  |   4 +-
 .../amd/display/dc/hwss/dcn31/dcn31_hwseq.c   |   2 +-
 .../amd/display/dc/hwss/dcn31/dcn31_init.c    |   1 +
 .../amd/display/dc/hwss/dcn314/dcn314_hwseq.c |  29 +----
 .../amd/display/dc/hwss/dcn314/dcn314_hwseq.h |   4 -
 .../amd/display/dc/hwss/dcn314/dcn314_init.c  |   2 +-
 .../amd/display/dc/hwss/dcn32/dcn32_hwseq.c   |  68 +++++-------
 .../amd/display/dc/hwss/dcn32/dcn32_hwseq.h   |   4 -
 .../amd/display/dc/hwss/dcn32/dcn32_init.c    |   1 -
 .../amd/display/dc/hwss/dcn35/dcn35_hwseq.c   |  34 +++++-
 .../amd/display/dc/hwss/dcn35/dcn35_hwseq.h   |   2 +
 .../amd/display/dc/hwss/dcn35/dcn35_init.c    |   4 +-
 .../amd/display/dc/hwss/dcn351/dcn351_init.c  |   2 +-
 .../display/dc/hwss/hw_sequencer_private.h    |   7 +-
 .../gpu/drm/amd/display/dc/inc/core_types.h   |   7 --
 drivers/gpu/drm/amd/display/dc/inc/hw/dccg.h  |   5 -
 drivers/gpu/drm/amd/display/dc/inc/hw/optc.h  |   4 +-
 .../amd/display/dc/inc/hw/stream_encoder.h    |   1 -
 .../amd/display/dc/inc/hw/timing_generator.h  |   1 +
 .../dc/irq/dce110/irq_service_dce110.c        |   8 +-
 .../drm/amd/display/dc/link/link_detection.c  |   4 +-
 .../gpu/drm/amd/display/dc/link/link_dpms.c   |  11 +-
 .../dc/link/protocols/link_dp_capability.c    |  16 +--
 .../dc/link/protocols/link_dp_irq_handler.c   |  10 +-
 .../display/dc/link/protocols/link_dp_phy.c   |  14 +--
 .../dc/link/protocols/link_dp_training.c      |   2 +-
 .../link/protocols/link_edp_panel_control.c   |   4 +-
 .../amd/display/dc/link/protocols/link_hpd.c  |   2 +-
 .../amd/display/dc/optc/dcn10/dcn10_optc.c    |  46 ++++----
 .../amd/display/dc/optc/dcn20/dcn20_optc.c    |  10 +-
 .../amd/display/dc/optc/dcn20/dcn20_optc.h    |   1 -
 .../amd/display/dc/optc/dcn201/dcn201_optc.c  |   7 +-
 .../amd/display/dc/optc/dcn201/dcn201_optc.h  |   3 -
 .../amd/display/dc/optc/dcn30/dcn30_optc.c    |   3 +-
 .../amd/display/dc/optc/dcn301/dcn301_optc.c  |   1 +
 .../amd/display/dc/optc/dcn31/dcn31_optc.c    |   1 +
 .../amd/display/dc/optc/dcn314/dcn314_optc.c  |   3 +-
 .../amd/display/dc/optc/dcn32/dcn32_optc.c    |   3 +-
 .../amd/display/dc/optc/dcn35/dcn35_optc.c    |   1 +
 .../amd/display/dc/optc/dcn401/dcn401_optc.c  |  15 ++-
 drivers/gpu/drm/amd/display/dc/os_types.h     |   2 -
 .../display/dc/resource/dce80/CMakeLists.txt  |   4 -
 .../dc/resource/dcn20/dcn20_resource.c        |   2 +-
 .../dc/resource/dcn30/dcn30_resource.c        |   5 +-
 .../dc/resource/dcn301/dcn301_resource.c      |  20 +++-
 .../dc/resource/dcn303/dcn303_resource.c      |  13 ++-
 .../dc/resource/dcn31/dcn31_resource.c        |   5 +
 .../dc/resource/dcn314/dcn314_resource.c      |   5 +
 .../dc/resource/dcn315/dcn315_resource.c      |  14 +++
 .../dc/resource/dcn316/dcn316_resource.c      |   2 +
 .../dc/resource/dcn32/dcn32_resource.c        |   5 +
 .../dc/resource/dcn321/dcn321_resource.c      |   2 +
 .../dc/resource/dcn35/dcn35_resource.c        |   2 +
 .../dc/resource/dcn351/dcn351_resource.c      |   2 +
 drivers/gpu/drm/amd/display/dmub/dmub_srv.h   |   1 +
 .../gpu/drm/amd/display/dmub/inc/dmub_cmd.h   |  15 ++-
 .../gpu/drm/amd/display/dmub/src/dmub_srv.c   |   2 +
 .../gpu/drm/amd/display/include/dal_types.h   |   1 -
 .../drm/amd/display/modules/hdcp/hdcp_ddc.c   |   8 ++
 .../amd/display/modules/power/power_helpers.c |   8 +-
 160 files changed, 952 insertions(+), 469 deletions(-)  delete mode 100644=
 drivers/gpu/drm/amd/display/dc/dpp/dcn10/CMakeLists.txt
 delete mode 100644 drivers/gpu/drm/amd/display/dc/dpp/dcn20/CMakeLists.txt
 delete mode 100644 drivers/gpu/drm/amd/display/dc/dpp/dcn201/CMakeLists.tx=
t
 delete mode 100644 drivers/gpu/drm/amd/display/dc/dpp/dcn30/CMakeLists.txt
 delete mode 100644 drivers/gpu/drm/amd/display/dc/dpp/dcn32/CMakeLists.txt
 delete mode 100644 drivers/gpu/drm/amd/display/dc/dpp/dcn35/CMakeLists.txt
 create mode 100644 drivers/gpu/drm/amd/display/dc/hubbub/Makefile
 rename drivers/gpu/drm/amd/display/dc/{ =3D> hubbub}/dcn10/dcn10_hubbub.c =
(99%)  rename drivers/gpu/drm/amd/display/dc/{ =3D> hubbub}/dcn10/dcn10_hub=
bub.h (100%)  rename drivers/gpu/drm/amd/display/dc/{ =3D> hubbub}/dcn20/dc=
n20_hubbub.c (100%)  rename drivers/gpu/drm/amd/display/dc/{ =3D> hubbub}/d=
cn20/dcn20_hubbub.h (99%)  rename drivers/gpu/drm/amd/display/dc/{ =3D> hub=
bub}/dcn201/dcn201_hubbub.c (100%)  rename drivers/gpu/drm/amd/display/dc/{=
 =3D> hubbub}/dcn201/dcn201_hubbub.h (100%)  rename drivers/gpu/drm/amd/dis=
play/dc/{ =3D> hubbub}/dcn21/dcn21_hubbub.c (100%)  rename drivers/gpu/drm/=
amd/display/dc/{ =3D> hubbub}/dcn21/dcn21_hubbub.h (100%)  rename drivers/g=
pu/drm/amd/display/dc/{ =3D> hubbub}/dcn30/dcn30_hubbub.c (100%)  rename dr=
ivers/gpu/drm/amd/display/dc/{ =3D> hubbub}/dcn30/dcn30_hubbub.h (100%)  re=
name drivers/gpu/drm/amd/display/dc/{ =3D> hubbub}/dcn301/dcn301_hubbub.c (=
100%)  rename drivers/gpu/drm/amd/display/dc/{ =3D> hubbub}/dcn301/dcn301_h=
ubbub.h (100%)  rename drivers/gpu/drm/amd/display/dc/{ =3D> hubbub}/dcn31/=
dcn31_hubbub.c (100%)  rename drivers/gpu/drm/amd/display/dc/{ =3D> hubbub}=
/dcn31/dcn31_hubbub.h (100%)  rename drivers/gpu/drm/amd/display/dc/{ =3D> =
hubbub}/dcn32/dcn32_hubbub.c (100%)  rename drivers/gpu/drm/amd/display/dc/=
{ =3D> hubbub}/dcn32/dcn32_hubbub.h (100%)  rename drivers/gpu/drm/amd/disp=
lay/dc/{ =3D> hubbub}/dcn35/dcn35_hubbub.c (100%)  rename drivers/gpu/drm/a=
md/display/dc/{ =3D> hubbub}/dcn35/dcn35_hubbub.h (100%)  delete mode 10064=
4 drivers/gpu/drm/amd/display/dc/resource/dce80/CMakeLists.txt

--
2.37.3

