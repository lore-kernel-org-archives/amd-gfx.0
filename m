Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E4D37C3DA64
	for <amd-gfx@archiver.kernel.org>; Mon, 22 Jul 2024 13:03:03 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6A8F710E13A;
	Mon, 22 Jul 2024 13:03:03 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="db3DaNt0";
	dkim-atps=neutral
Received: from NAM02-SN1-obe.outbound.protection.outlook.com
 (mail-sn1nam02on2054.outbound.protection.outlook.com [40.107.96.54])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E75A910E13A
 for <amd-gfx@lists.freedesktop.org>; Mon, 22 Jul 2024 13:03:00 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vqul3CovhzsOC8zqE9NgxBTcNSDw8KACjiB+ATy4mtxNORkIVMFYYJgpOk5/y8ElvSwt+DZTbq8uUnM3bXelbvhJqipSx6ot1tleOKd2PVAdihQpbNOoS9Emy46YNg4BA+w02m1i5ttwNIWOsl5AdCFH9h7XPcCDTxabCLOWc9gI74fqyTpGcFJoL8r5qtQGkqoJ3GI8WKRgdogd8+laFTJihn09kyHzAnCFpTvKjNOV0CLbUHroQ1iWvcrkynbDKvcQNg6BYS0kCIR7TE4cEG99CpCWFD4S5JP+KXPjrZ/aSNqJX1OhyGgOEFHJORliqAA9mCo3wk2184mvv9kvxg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9K/0rfU6mafoQIGCSeaAQoqdfXrB1UYOxRbNEfPGfdU=;
 b=h76QphcwStv1yVmwjxTikiMpxRSJH+N1UqPrgG+omDnAAJcOQP9Q3+7BzJ3SwmXf906KCCZkIBL0Vzy62triiD8Y2Oo8woVo6/mTPsHqG0FqoWoGuR0C+Minkhe2maxJ7/EX9qzUWRhyCcpAESVapRCvzZzxlCrVbhfd/t5vH/via0gHr2NuUprDYQnsD1OvMAn9yW84CwP4yyc6suzKte/Iq3udWUlhrYEeNlQs9zSo7851t5rd1RrNhqDqQHZ3G4vfDY4Eqvz2Lf5hslnJAVMq7+pl6kNIH9b9VYCS1lDXh8cF72XZ2FZzod8kQG1AbnsLFMfKkQhXnWPFVfpIoA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9K/0rfU6mafoQIGCSeaAQoqdfXrB1UYOxRbNEfPGfdU=;
 b=db3DaNt0o4IRggmpMUy8c1X/5LirTLOi80gxeXmMaYhXT9kjgpF62S6WIzEdeSqadwhmmmk+IYV9XB0T+MOfG4OMf9AcHdrC3239ACrBjcLBnxTwdYC+YOGpMvC1oTg1oIaUzg89C0ljrfYuRRts2CpAS1gfAnJHgt3PT/s4RT4=
Received: from DS0PR12MB6534.namprd12.prod.outlook.com (2603:10b6:8:c1::19) by
 MW3PR12MB4395.namprd12.prod.outlook.com (2603:10b6:303:5c::23) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7762.27; Mon, 22 Jul 2024 13:02:57 +0000
Received: from DS0PR12MB6534.namprd12.prod.outlook.com
 ([fe80::ea87:74ba:36ec:8cf6]) by DS0PR12MB6534.namprd12.prod.outlook.com
 ([fe80::ea87:74ba:36ec:8cf6%4]) with mapi id 15.20.7784.016; Mon, 22 Jul 2024
 13:02:57 +0000
From: "Wheeler, Daniel" <Daniel.Wheeler@amd.com>
To: "Pillai, Aurabindo" <Aurabindo.Pillai@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
CC: "Wentland, Harry" <Harry.Wentland@amd.com>, "Li, Sun peng (Leo)"
 <Sunpeng.Li@amd.com>, "Siqueira, Rodrigo" <Rodrigo.Siqueira@amd.com>,
 "Pillai, Aurabindo" <Aurabindo.Pillai@amd.com>, "Li, Roman"
 <Roman.Li@amd.com>, "Lin, Wayne" <Wayne.Lin@amd.com>, "Gutierrez, Agustin"
 <Agustin.Gutierrez@amd.com>, "Chung, ChiaHsuan (Tom)"
 <ChiaHsuan.Chung@amd.com>, "Zuo, Jerry" <Jerry.Zuo@amd.com>, "Mohamed, Zaeem"
 <Zaeem.Mohamed@amd.com>
Subject: RE: [PATCH 00/22] DC Patches for 15 July, 2024
Thread-Topic: [PATCH 00/22] DC Patches for 15 July, 2024
Thread-Index: AQHa2IEAaxKgLbyV+E+UC/qgqEG9hrICvVmA
Date: Mon, 22 Jul 2024 13:02:56 +0000
Message-ID: <DS0PR12MB653407FAB305FDB694A93D769CA82@DS0PR12MB6534.namprd12.prod.outlook.com>
References: <20240717193901.8821-1-aurabindo.pillai@amd.com>
In-Reply-To: <20240717193901.8821-1-aurabindo.pillai@amd.com>
Accept-Language: en-CA, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_ActionId=5079e97f-579d-41c6-9f21-12634020d3eb;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_ContentBits=0;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Enabled=true;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Method=Privileged;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Name=Open Source;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_SetDate=2024-07-22T13:01:10Z;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS0PR12MB6534:EE_|MW3PR12MB4395:EE_
x-ms-office365-filtering-correlation-id: a6bf4784-116f-40c9-bcea-08dcaa4e9b5a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|1800799024|366016|376014|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?xhtanG8Ka8pNFh7yDoZL6k3xxpjsj18WruCHroXm5gb6DFSgJav36zUWw87J?=
 =?us-ascii?Q?/g1vwn5xxmps8JuNusCJVd1yTfVt2L3aQVbPjBKX1J5Xc5FW78XY8thd7b8L?=
 =?us-ascii?Q?3c+whf27akkpPxDwd+/pgrWuEdVYINlOKzhh+iIYDWUAgHklKBs407lZ9Kvq?=
 =?us-ascii?Q?O86US+bFeSpSM3VmmLY0yNFTvV3rtTuhFNGk4CrG/tk5hJ/pvfhFdLPG2RJv?=
 =?us-ascii?Q?EeNMIp8Pfm+5IoU7DiyTJ4zeGnPOtlLHZOsgqdUDr9lvTeJo/6N5SGyQwjAm?=
 =?us-ascii?Q?1BdSMT9ZxxsdvrGgl99fyI94vet5RiJaQ9G3EkGteZXTaSdBEAXyolgauPXl?=
 =?us-ascii?Q?da7lYXliB7tbs7EXJvyijcT2fZVsFXYlRSnErh9wwWe3X312TadTmLsJ9Kah?=
 =?us-ascii?Q?018Hkx0Tee0e0S9pCl+d9bQ8hyQVM166QYkVTIlSfmbpRV2wr9DKTmnvpMwc?=
 =?us-ascii?Q?QTaSVtBPr0+Gl4JkF65ZszYS5E9smM1df+Mv8F3QIOmTb8Qq1dT12SIjvx4c?=
 =?us-ascii?Q?DZU5YCh9T4lvOq927oeB9nHXFvZzykk3yD5YFYis0qojvqgXtjaHcvn8xal4?=
 =?us-ascii?Q?DdghAhlXvhy0x3sXj2v1rK+vohq8pAd/XFCiOrlC2HTtrfnhdYzKyZJXgkoO?=
 =?us-ascii?Q?uQXO1NbxiXTPP902lAwwdd346rhGLpnl9EQOdggJee5e1zPqMtiLXQyGQ+3Q?=
 =?us-ascii?Q?YBLeuuEEPXnS771/835vPn0Sb3J3s+KWjkUv13TuwY2HfKCwly+mGDB5eDAB?=
 =?us-ascii?Q?zkX0U0F+lxpXq6r7LlFK1k2DmyULd8HU8hiB3XFhDVi1lNAhGQNTk6CvuY7Z?=
 =?us-ascii?Q?u75hGQuNFOw8G2X08EzASUUBT7h2eh3IKOfabQXKjG5301fNdiwrv9yoO3iW?=
 =?us-ascii?Q?SBMJctaHw+FLhwki/ZFoiOugZga3gnbJ9TvEgPIwUYaJLngm12DorlCmpIlY?=
 =?us-ascii?Q?tfYqrwtfvypAMgXa09U2rPij4g+Iu6qcvHhRK2zsMl4u5n4QGCUidDopeNMJ?=
 =?us-ascii?Q?RgMLNT9j9sjWfSXsvJLzkI2yUToNisuH/vJmhm7vSlTrMfvPIzmmsmMocUmw?=
 =?us-ascii?Q?rAcZWdlHjvGl9XfeKDXjOLMAJSxuBFmDQe+Ml1PB8NaIhiYNx1NXJ87fXU64?=
 =?us-ascii?Q?jTc2E2FmT17B7XBg0498wBy/jvacUg+W5KBqSbNqWhGziB4x/B7TnRGSjAMT?=
 =?us-ascii?Q?/qyibXo9+HmPu14X4BA8arKJVVEx+wd6Uh8+UbQVExm5v/3//DFSzn/prqez?=
 =?us-ascii?Q?fnFeDzCPq2KuQpfGTaMj1ZFIEXgQNGuBEAyKtYXAZAbeeG0ZElCbHYYXBM9d?=
 =?us-ascii?Q?wtYgfK/alSco/EOo5zQeB94hY7PQGfkPB9kG7efeBG5QmVw1YLNXiS3bdDFO?=
 =?us-ascii?Q?zfrwzYXe3lVcxhFRMjGKY9SAAq+g+etk5XlJfdsVTzvulCHhBg=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR12MB6534.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(38070700018); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?FRfotoRu0A4M+g2Z8IkwU6i9DLUOACKgi5MNa1BkRU+Xvmo9ZoxtWKPqQP7a?=
 =?us-ascii?Q?UYIqQbUdMzTts159zgiDr5LAET0BxW9VQxnmFvgllqhxEXs+T9pvRrEsSUS5?=
 =?us-ascii?Q?GAeR9Wh2QHX+Vtq4RpNQ5/sWE/qbUcpESN5tL1JCY9vreMijqgLV8jhwmvfZ?=
 =?us-ascii?Q?Y02e55XiqnEhYtUXy5ibWSxXvYMDB2vYLPv1uoMcUe7k66iNb7U2gNjqDPls?=
 =?us-ascii?Q?1IKMkW7506tn1RPC2iVCDdr4LVVf/qbzlqkReCFEaTnzY1sY0ZFGZe2rR6kl?=
 =?us-ascii?Q?kvYbQt33lg2ewjm4yiO1gFHypvBrx3aFRaRoXK1wM3FiKZoKWyoe8WIVQUa1?=
 =?us-ascii?Q?kwMxgjz0fk420PrqX+nD131mhiavV7J46lGOKa4nZZSLBCwPA1ivEiLAETMj?=
 =?us-ascii?Q?VGToaZ5BhKgiB0pa6Kp7zHv2eL8T5aSBccPnQYFf2QcYg0HqjQWWlQAK7wiW?=
 =?us-ascii?Q?IT8ls9i2dflUobyrYYyu1zIIjON52p2hifUQyXAgq9V7fj0y1tLWShuRxACb?=
 =?us-ascii?Q?Nm3FKWEYV9AszDI51MHWWSNurQ9uiE98pgKftiT2qnBzsXzbCuOXTo0mGhAx?=
 =?us-ascii?Q?89r0de4H0Sdi41riXE7IcRR3SxtyIdKDpm6gStJLDAKKL7vzkjiDkQFGf9a6?=
 =?us-ascii?Q?fcBsryi9Wry+/fCxvh5eoOabPbmlAM3Av8WT5uD/IaI8tEhaSZ17Ftbs+2g7?=
 =?us-ascii?Q?yRi23rglsBV0Av3NcfAWqNISy1Bosctl0nsurSHbroPB+ayEHyfsZ2mbA7r6?=
 =?us-ascii?Q?ZX6Kchsu0bMiPiJtrpm+f6IPtetz/9+Ndpfhj8KIpRM96Y0GundRTznPsSae?=
 =?us-ascii?Q?HLnWBA3hZHv7iaDWxvjb5ij1FddXbTOjyAIM02vDNc41DVxGDakzyPmyJ6fC?=
 =?us-ascii?Q?utLOpyzIu41qlRl3NyKyetIvnabALqDbZvTJ0d8I8VtlSoW1bFSe91zpCbBE?=
 =?us-ascii?Q?W6NVhkHsQb3O7XXCkykLGwPXHtoSO7Uy+WEEzyOxJF784q1uxlB2SL8P1fK4?=
 =?us-ascii?Q?rHjWoSCc2i//EA5xYQBgUj9uAQ8ni4zGCGkr596tLlfx8sq1mg0s/qCyHH+a?=
 =?us-ascii?Q?iwnetGlXfehiQstsK+tyM3mDEXZjyYZSKrR5Zv3Ff8gP6NhQ7uV9dJziU4to?=
 =?us-ascii?Q?zWvfo7b9Sp1DS6y4jKLjpZkbyPVVJmCKyWPS7aZin3vejLHW4dgUACs9DTu+?=
 =?us-ascii?Q?7GmooS+sJAJhVPcPyTEgEi2Wvvr5JI69nsU/17NJELSJk1FEvv9a3ldt58M/?=
 =?us-ascii?Q?BFCL9A7kGwgxjj8dWVjR4BLzJBMEoSLqdfaBM7JSwammmFfcHpvqauaALHyL?=
 =?us-ascii?Q?zaVKhl56R/dv8pEhZWPwxfRyWi/l9BajJhZEfMrNjHL0Unv9HUHbLbwIq8vt?=
 =?us-ascii?Q?QwMOfTRxy51Bg9QwzT5sM9hzy9qpoNqhcpJVEc5FgEBk9JKIXrA3MqJMEY0C?=
 =?us-ascii?Q?TnvQf1lToM/SrX4w9DLefrNykpJc5JsOTuNS5kxynLggadnvhvncJPr3XRmn?=
 =?us-ascii?Q?SlyzfvrXnEr4tgzAIeo0fTLNsvPxQm6bwZV4CXv8JsfobYbRntwfHzHKB7Y7?=
 =?us-ascii?Q?iClsVV/ocSrfYsBVhoE=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB6534.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a6bf4784-116f-40c9-bcea-08dcaa4e9b5a
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Jul 2024 13:02:57.0149 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: yN8450Jw+8EDYSdxB41XWe9a4TthY475z6DAdnxq8yKeK13P/wTu5P+ExrC75gCZjYD1UcxpNBKSCxyK2CYJ4Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR12MB4395
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

The patchset consists of the amd-staging-drm-next branch (Head commit - 18e=
60d38308b -> drm/amdgpu: timely save bad pages to eeprom after gpu ras rese=
t is completed) with new patches added on top of it.

Tested on Ubuntu 24.04.1, on Wayland and X11, using KDE Plasma and Gnome.


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
From: Aurabindo Pillai <aurabindo.pillai@amd.com>
Sent: Wednesday, July 17, 2024 3:39 PM
To: amd-gfx@lists.freedesktop.org
Cc: Wentland, Harry <Harry.Wentland@amd.com>; Li, Sun peng (Leo) <Sunpeng.L=
i@amd.com>; Siqueira, Rodrigo <Rodrigo.Siqueira@amd.com>; Pillai, Aurabindo=
 <Aurabindo.Pillai@amd.com>; Li, Roman <Roman.Li@amd.com>; Lin, Wayne <Wayn=
e.Lin@amd.com>; Gutierrez, Agustin <Agustin.Gutierrez@amd.com>; Chung, Chia=
Hsuan (Tom) <ChiaHsuan.Chung@amd.com>; Zuo, Jerry <Jerry.Zuo@amd.com>; Moha=
med, Zaeem <Zaeem.Mohamed@amd.com>; Pillai, Aurabindo <Aurabindo.Pillai@amd=
.com>; Wheeler, Daniel <Daniel.Wheeler@amd.com>
Subject: [PATCH 00/22] DC Patches for 15 July, 2024

This DC patchset brings improvements in multiple areas. In summary, we have=
:

* bug fixes for SubVP, DML, SPL, DCCG, and various stability fixes
* more reorganization of code into corresponding sub components
* renaming certain variables in DML to better reflect their relevance.

Cc: Daniel Wheeler <daniel.wheeler@amd.com>

Alex Hung (2):
  drm/amd/display: Add MST debug message when link detection fails
  drm/amd/display: Check link_res->hpo_dp_link_enc before using it

Aric Cyr (1):
  drm/amd/display: 3.2.293

Aurabindo Pillai (3):
  drm/amd/display: rename dcn3/dcn4 to more sound terms
  drm/amd/display: rename dcn401_soc to dcn4_variant_a_soc
  drm/amd/display: remove unused folder

Austin Zheng (1):
  drm/amd/display: Check if Mode is Supported Before Returning Result

Dillon Varone (2):
  drm/amd/display: Remove hardmax usage for dcn401
  drm/amd/display: Various DML2 fixes for FAMS2

Gabe Teeger (1):
  drm/amd/display: Fix Potential Null Dereference

Hansen Dsouza (3):
  drm/amd/display: Add private data type for RCG
  drm/amd/display: Add RCG helper functions
  drm/amd/display: Add source select helper functions

Ilya Bakoulin (1):
  drm/amd/display: Add helper function to check for non-address fast
    updates

Joshua Aberback (1):
  drm/amd/display: Remove duplicate HWSS interfaces

Revalla Hari Krishna (1):
  drm/amd/display: Refactoring HPO

Rodrigo Siqueira (2):
  drm/amd/display: Remove ASSERT if significance is zero in math_ceil2
  drm/amd/display: Remove old comments

Ryan Seto (1):
  drm/amd/display: Fix visual confirm bug for SubVP

Samson Tam (1):
  drm/amd/display: ensure EASF and ISHARP coefficients are programmed
    together

Sung Joon Kim (2):
  drm/amd/display: Check for NULL pointer
  drm/amd/display: Check top sink only when multiple streams for DP2

 .../amd/display/amdgpu_dm/amdgpu_dm_debugfs.c |   5 +-
 .../display/dc/clk_mgr/dcn35/dcn35_clk_mgr.c  |   6 +-
 .../dc/clk_mgr/dcn401/dcn401_clk_mgr.c        |  44 +-
 drivers/gpu/drm/amd/display/dc/core/dc.c      |  36 +-
 .../gpu/drm/amd/display/dc/core/dc_surface.c  |   3 +-
 drivers/gpu/drm/amd/display/dc/dc.h           |   8 +-
 .../amd/display/dc/dccg/dcn35/dcn35_dccg.c    | 712 ++++++++++++++++++
 drivers/gpu/drm/amd/display/dc/dcn30/Makefile |   2 -
 .../gpu/drm/amd/display/dc/dcn303/Makefile    |  13 -
 drivers/gpu/drm/amd/display/dc/dcn31/Makefile |   2 +-
 .../gpu/drm/amd/display/dc/dcn401/Makefile    |  10 -
 .../drm/amd/display/dc/dml/dcn32/dcn32_fpu.c  |   4 +-
 .../amd/display/dc/dml/dcn321/dcn321_fpu.c    |   4 +-
 .../dc/dml2/dml21/dml21_translation_helper.c  |  51 +-
 .../dc/dml2/dml21/dml21_translation_helper.h  |   2 +-
 .../amd/display/dc/dml2/dml21/dml21_utils.c   |  24 +-
 .../dml21/inc/bounding_boxes/dcn3_soc_bb.h    |   8 +-
 .../dml21/inc/bounding_boxes/dcn4_soc_bb.h    |  10 +-
 .../dml21/inc/dml_top_display_cfg_types.h     |   1 -
 .../dml21/inc/dml_top_soc_parameter_types.h   |  10 +-
 .../display/dc/dml2/dml21/inc/dml_top_types.h |  10 +-
 .../dml2/dml21/src/dml2_core/dml2_core_dcn4.c |   2 +-
 .../src/dml2_core/dml2_core_dcn4_calcs.c      | 186 ++---
 .../dml21/src/dml2_core/dml2_core_shared.c    | 192 ++---
 .../dml2/dml21/src/dml2_dpmm/dml2_dpmm_dcn4.c | 130 ++--
 .../dml21/src/dml2_pmo/dml2_pmo_dcn4_fams2.c  |   2 +-
 .../lib_float_math.c                          |   2 -
 .../dc/dml2/dml21/src/dml2_top/dml_top.c      |   3 +-
 .../amd/display/dc/dml2/dml2_internal_types.h |   1 +
 .../display/dc/dml2/dml2_translation_helper.c |  41 +-
 .../display/dc/dml2/dml2_translation_helper.h |   2 +-
 .../gpu/drm/amd/display/dc/dml2/dml2_utils.c  |   6 +-
 .../display/dc/dpp/dcn401/dcn401_dpp_dscl.c   |  28 +-
 drivers/gpu/drm/amd/display/dc/hpo/Makefile   |  15 +
 .../dcn31/dcn31_hpo_dp_link_encoder.c         |   0
 .../dcn31/dcn31_hpo_dp_link_encoder.h         |   0
 .../dcn31/dcn31_hpo_dp_stream_encoder.c       |   0
 .../dcn31/dcn31_hpo_dp_stream_encoder.h       |   0
 .../display/dc/hubbub/dcn401/dcn401_hubbub.c  | 364 ++++-----
 .../amd/display/dc/hwss/dce110/dce110_hwseq.c |   1 -
 .../amd/display/dc/hwss/dcn10/dcn10_hwseq.c   |  10 +-
 .../amd/display/dc/hwss/dcn10/dcn10_init.c    |   2 -
 .../amd/display/dc/hwss/dcn20/dcn20_hwseq.c   |   2 +-
 .../amd/display/dc/hwss/dcn20/dcn20_init.c    |   1 -
 .../amd/display/dc/hwss/dcn201/dcn201_init.c  |   1 -
 .../amd/display/dc/hwss/dcn21/dcn21_init.c    |   2 -
 .../amd/display/dc/hwss/dcn30/dcn30_hwseq.c   |   8 +-
 .../amd/display/dc/hwss/dcn30/dcn30_init.c    |   1 -
 .../amd/display/dc/hwss/dcn301/dcn301_init.c  |   1 -
 .../amd/display/dc/hwss/dcn31/dcn31_init.c    |   2 -
 .../amd/display/dc/hwss/dcn314/dcn314_init.c  |   2 -
 .../amd/display/dc/hwss/dcn32/dcn32_hwseq.c   |   8 +-
 .../amd/display/dc/hwss/dcn32/dcn32_init.c    |   1 -
 .../amd/display/dc/hwss/dcn35/dcn35_hwseq.c   |   8 +-
 .../amd/display/dc/hwss/dcn35/dcn35_init.c    |   2 -
 .../amd/display/dc/hwss/dcn351/dcn351_init.c  |   2 -
 .../amd/display/dc/hwss/dcn401/dcn401_hwseq.c |  11 +-
 .../amd/display/dc/hwss/dcn401/dcn401_init.c  |   2 -
 .../drm/amd/display/dc/hwss/hw_sequencer.h    |   1 -
 .../display/dc/hwss/hw_sequencer_private.h    |   2 -
 .../gpu/drm/amd/display/dc/inc/hw/mem_input.h |   2 +-
 .../display/dc/link/hwss/link_hwss_hpo_dp.c   |   5 +
 62 files changed, 1401 insertions(+), 615 deletions(-)  delete mode 100644=
 drivers/gpu/drm/amd/display/dc/dcn303/Makefile
 delete mode 100644 drivers/gpu/drm/amd/display/dc/dcn401/Makefile
 rename drivers/gpu/drm/amd/display/dc/{ =3D> hpo}/dcn31/dcn31_hpo_dp_link_=
encoder.c (100%)  rename drivers/gpu/drm/amd/display/dc/{ =3D> hpo}/dcn31/d=
cn31_hpo_dp_link_encoder.h (100%)  rename drivers/gpu/drm/amd/display/dc/{ =
=3D> hpo}/dcn31/dcn31_hpo_dp_stream_encoder.c (100%)  rename drivers/gpu/dr=
m/amd/display/dc/{ =3D> hpo}/dcn31/dcn31_hpo_dp_stream_encoder.h (100%)

--
2.39.2

