Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 80E77D25930
	for <amd-gfx@archiver.kernel.org>; Tue, 27 Jan 2026 04:19:02 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1B56510E04D;
	Tue, 27 Jan 2026 04:19:02 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="2s6WTwKr";
	dkim-atps=neutral
Received: from DM5PR21CU001.outbound.protection.outlook.com
 (mail-centralusazon11011025.outbound.protection.outlook.com [52.101.62.25])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 19A5610E04D
 for <amd-gfx@lists.freedesktop.org>; Tue, 27 Jan 2026 04:19:01 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=B47XtLPAI00EFhC/rcFnZNTLn8OaJGgznK5Zo20y2dpsxtsIbzkplLqkILnDraTZe7Qpw80iHefr9cO+ERZhEF84MSytdv4dO79lxpfET6nlO82IQ+l7ZR2PQ1r9W+MhrYYuyefFcTpfkT9VuQjLXELGWV6ZsgEWFa5akcxEuc1uTalL5gSA6JXs3wzRFU8c/MTuaCzeYyaclk15+yJgOiNINLqMv6RaaUjihhz6dUlbD16jT41Tj1DwmbVfkBO59w5hYrzGzH6nPvWmic0Gtc4jebjdFrcgR9qOYlNvLikMLMG7bRDchET+/QxXcTY8tU/N9+ARdAFN/52cS7nQ0g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZTuBSbQSC5l41qyJ0Fe/aT49c/dNdUY03PkUPqX0STc=;
 b=t/6uAEXJrsh6SUwBT019LPThkVmJQwqE422wJwmiMYAelQmIm9840tIxBMnNYcJEqOnbO11K27AhsfPvJ39dF6r5JjPUtAmob3V93WC0Corp/29P8pSMELIR0fAbqJKcH8P4VsuvOypmtDpfJ7NrGWMEESeBykkodTZVkF2sGdYrrgvmNfN9bEJsqcH7oUJps2hldG+P71N63m2pCfIW0TkXmCrfO7BK+jnC0LXFC3zdFL5O2dl58c9I+wN60Bg8Dnzk6VldX4YijKVvkP9Iag+84CP9RH+C+koxfiYKgAkyQIP9e+y2ebbQwiHW+PDOngKYHW2QhN5Lw4VAyp5Q2g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZTuBSbQSC5l41qyJ0Fe/aT49c/dNdUY03PkUPqX0STc=;
 b=2s6WTwKrbzi2xebCIMxFG2AEN3WPY5WOb5vAl9s2whgM1qnHdr5Cr+XS7Jl6G7PmtXyXXfsSQd1rHpieg4DoYUue4NEIM5tjauBpq4XcJHbgIGPlF/GHtmO3P7ZlfsqddSa29yGVfS+3LaGlFGHdNFJuPF4YAAnY83lG8E77qtY=
Received: from MW5PR12MB5684.namprd12.prod.outlook.com (2603:10b6:303:1a1::21)
 by CY5PR12MB6154.namprd12.prod.outlook.com (2603:10b6:930:26::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9542.11; Tue, 27 Jan
 2026 04:18:58 +0000
Received: from MW5PR12MB5684.namprd12.prod.outlook.com
 ([fe80::9eac:1160:c373:f105]) by MW5PR12MB5684.namprd12.prod.outlook.com
 ([fe80::9eac:1160:c373:f105%3]) with mapi id 15.20.9542.015; Tue, 27 Jan 2026
 04:18:58 +0000
From: "Xie, Patrick" <Gangliang.Xie@amd.com>
To: "Zhou1, Tao" <Tao.Zhou1@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
CC: "Chai, Thomas" <YiPeng.Chai@amd.com>
Subject: RE: [PATCH 05/14] drm/amd/ras: add wrapper funcs for pmfw eeprom
Thread-Topic: [PATCH 05/14] drm/amd/ras: add wrapper funcs for pmfw eeprom
Thread-Index: AQHcjnetQfkrsyJ/6EyW9oU7gpZRp7VlZDgAgAAGLwA=
Date: Tue, 27 Jan 2026 04:18:57 +0000
Message-ID: <MW5PR12MB56849CA646643481FEF55F4CE590A@MW5PR12MB5684.namprd12.prod.outlook.com>
References: <20260126035527.1108488-1-ganglxie@amd.com>
 <20260126035527.1108488-5-ganglxie@amd.com>
 <PH7PR12MB8796F858979F601C30DE07D7B090A@PH7PR12MB8796.namprd12.prod.outlook.com>
In-Reply-To: <PH7PR12MB8796F858979F601C30DE07D7B090A@PH7PR12MB8796.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=True;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2026-01-27T03:53:04.0000000Z;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution
 Only; MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=3;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MW5PR12MB5684:EE_|CY5PR12MB6154:EE_
x-ms-office365-filtering-correlation-id: 80034ce5-cfc7-40cb-a5ee-08de5d5b30fe
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|366016|376014|7053199007|38070700021; 
x-microsoft-antispam-message-info: =?us-ascii?Q?6s/MjZbDFv4QoocaqXoEPV2/IHNPAKuzRfXLaxwoS1Bg2lpc6eePoYPxcUrR?=
 =?us-ascii?Q?rNR/gXcSHg47XykhRT7dIOGuqjPhS4+fONBskpINlLhT2A7XwS92V5xRGUyQ?=
 =?us-ascii?Q?4UR0ujsScnj5t9xweGCWk8DgL05Au7GZxDfJY63S4WRpQLi1G8SbM33WMexC?=
 =?us-ascii?Q?dHy3RXK/7Vsj6zlWUNayVDHX3iZoIVkokS+UKDNKKwhxfkGHqWWwMNX069s4?=
 =?us-ascii?Q?qTqoQLpAcVB0NAtekY3D+6AoKaY+dkdrE+MSSAi6dhRluKtBvO/iYbYlD5sU?=
 =?us-ascii?Q?yVlSQvbaLaubRd/PcTW5uFY81dyMCamysR28It8dXIuxF2ziW5GwD4rkik8v?=
 =?us-ascii?Q?R5DaXDMf4uVKIqXJ1LXF6tWsfaUsgtz4K103KdxqcuBVzJLjh1IIF4q/dhpp?=
 =?us-ascii?Q?mb/fRdI1WmE99Hzq6tzwuwa2bvANPAWoDl2BKmOyxqmV+ckyFfiV1nETMfoR?=
 =?us-ascii?Q?RktSO48wXhtCYrwfqcSy2QWok30eBgiSymw/6OwNLJzfnc/nmMpKbgCroE97?=
 =?us-ascii?Q?jbjg4qN4pO4zpaqTXrUvhfr3pVpS0qx2w8uJcAQtQ8j37L28HUz/ss7E+p36?=
 =?us-ascii?Q?796m7b9Q4HtpNduSty5cKLFAlZejLzr3GeCH/+GnYZA2ARcR2y71jSxZEX2j?=
 =?us-ascii?Q?zdiQyxSJYyASE/MnL3ap8vNvwjTvZod1WFwQRnocVzmnRRSF1KlcJ49jk0m/?=
 =?us-ascii?Q?iviNamc7FbsBEzA+KTm9aIRSX3FYDnO1EtIRszfBfa5po8Zg5a5VD0y4Di3b?=
 =?us-ascii?Q?qWFcyGChWaHJPf9uBCQHrieURBUgJygOmvUA+udb8DQhl+OQcJZijy8deXJ8?=
 =?us-ascii?Q?uRXmEsW6PhD8X8h6vxyMxFDo8Hzbpk2ClecqPC/emG0+irHy3hNV/If/RsvP?=
 =?us-ascii?Q?7SEgC0ruKwyEjTzPJ18Sq/SS95Qxb7pm8qPOHaQaxJl4kIn18mAuGcgzlJom?=
 =?us-ascii?Q?4Rutw+i6W6rxTTELs2mvuhbhBPSJmJQJ1KXUnpnH65g5I8my81x578quXcPo?=
 =?us-ascii?Q?xK6Jgy3rgYH2yzijqWbD5wB30itdu7Yoi2vRxYc1ySLfztay8kP5zO6VnH9A?=
 =?us-ascii?Q?20Wz3DD/NbBSgHV0bilZIgZa2S8F69IyxVIZy32Vx71YUXJ/EiaIb6ZGns8M?=
 =?us-ascii?Q?/kVjw5mbJNdt2uJmTLzow9Kk1V3/GgmuAKYBBYA8pJeAhqq3HDn6bXQ+rYxD?=
 =?us-ascii?Q?AQ9mJOSTIsJ8R+DNHVeq027EHTUtaIMwxEEm5mjwQLFTQCFqvftJreGhSHyL?=
 =?us-ascii?Q?PkPm2HAnleojf+fNhC8h/90kO378FpwGXjrAF7UHrmmy4t0GuqlFuFk3/Yff?=
 =?us-ascii?Q?YHTCc36TEy7CcCqZ6uNR/Jb+XymXt9xeeLnHjIOO5InlAtKgadk8jwdr1pwT?=
 =?us-ascii?Q?mzyrdDHL9L9ltcKcJrIQGQgIZFoQmQ5c1XytmdOQKxoXz1p6BVpnvsbpNvwE?=
 =?us-ascii?Q?UUechJNJ3Bir67cvGRP1ceWKMnGZiTzQMeAWEbuSrLF1Thd7eWFzHbtYsIh7?=
 =?us-ascii?Q?OtyFb8TCX6i6h7wNh1ZrKOpBgbrBe3Rx+UYhaZhFCFh//6uz5k8h26wrgEp/?=
 =?us-ascii?Q?TPVS7gVmUNGKd/ihN+N5CjL8iSo437aOHz8AvgiEjwK3VvEOvD+HPCJv9zBh?=
 =?us-ascii?Q?V9KGgwMY+MNF20eavTmlob8=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MW5PR12MB5684.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(7053199007)(38070700021); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?wzPeXbA5y6/uViX6wbdDjVWfoqKatsPGv1sUgMZvzzSUGqItCQ33CcgaYMFp?=
 =?us-ascii?Q?RgqbPkB4xM3emwqFDm0/b6f5DtSrMNo7WfqMGdTgjfCsnzNc94smAepiWOEH?=
 =?us-ascii?Q?1sb3kdZ42yhyyFgyTMVU19/Fx9NpOPaHYuPdShn5uiqFQtxMX4nbyMc7x0XW?=
 =?us-ascii?Q?8YbiEubKtqzwk4/SbaCN/lwOEaxeR/42njHRTM3gcU6t2NZIBTdyejf/r0Ta?=
 =?us-ascii?Q?xMb4G2Hj1Xy7B0F0i3XjR5sN67brFSNRdfzjg+g/03ATlfUmVPlK5D6UCKhC?=
 =?us-ascii?Q?4aT1Z5mLLH2FPt972fJg9dTbps0/xILfK0o+WCb/oSXoIk5y74dox9twqj4V?=
 =?us-ascii?Q?b8oqn6nt5tGH1rYTecbJzkKdzYaWN0sf45dygE44HBBDjGOySp2xpoTbTNfL?=
 =?us-ascii?Q?WNvxKdIHglD6HilSLMUn8uqNnBHD12IAjfqiAMNmOwk6uSWFyZ4vr6ovtXA8?=
 =?us-ascii?Q?Di3YI2HY/LMtAm3a3gdjeOsoPmxZhTUx2e6elU2CprnM5IX/jvp4DxjPK4L3?=
 =?us-ascii?Q?OilVt/DFVM1oavPS9EkRVPf9MRqyzauEmrmisBovGaCJMN8NePpKIQ0MW4ha?=
 =?us-ascii?Q?T//+mSJ7iT7a2kW7yVQpOVimvkyUMVy8y9EXOERmIsLyPf+yuNk1p9LbOa1c?=
 =?us-ascii?Q?1HNgwzaoYUap4CEBOxejojFKhbtMkH8kZWfaNs/CRq14o28K/IDZX6RdaQDK?=
 =?us-ascii?Q?iRVZame+PP6111wV7YacGYYl+Yep0aOy7V5BvN0EQStbklwVbxnMIbUsyEng?=
 =?us-ascii?Q?/EljP6RP87QHL81vlktHSj6vrJmhgoCzlfQbcg4mYeTrKaYahZdPrQneQ3co?=
 =?us-ascii?Q?mY+Ztyhj9dSPl0WP9Z5MHGkCxbypBdN4JdB+lb2R8qa+8afY2IXevqMbCEmN?=
 =?us-ascii?Q?O+IhJpRg+xrvBVXX8OK6fYzlAP3R2dgXBRG0vIS7r4j32aBVY7ptJJZIIEY5?=
 =?us-ascii?Q?0ulECpDTXAMz9Wa2Bhc8cN8chHsPuubxUjBSBCGFHvmbXsdvsVYZfyFHim90?=
 =?us-ascii?Q?FkSfWKK44ReelZ5TwdYlkp1ub0Fs0HzxgOdEVINTP0cTuEhLOWPBXfvCXH3/?=
 =?us-ascii?Q?61HRnKDnURD6SVlPv4pCNZrsJHlF526TA3S57jANZ+2rVLk2llLezH704F8u?=
 =?us-ascii?Q?FfAPQsUmDir2BfawMRPLW90RY3575RdsVJtLNv9luuKkIMpQS5Q5x+aNqbij?=
 =?us-ascii?Q?JAPgLdWui8BfTjkIrsCN106gjYYJIZlwtzNeuRp/ZvFXvH7D4NNebB1j/fyz?=
 =?us-ascii?Q?DvA7l0odBt45vD3q0DqPp/thDasB9yNuP7a6ZT26VqxJfAaa+QG2wOQvOwbu?=
 =?us-ascii?Q?jLdWFJZPBJAXnULGRmiTwf1EV1PcUtTALCjibcNNpWSdi5pkVDpN12xsOBg6?=
 =?us-ascii?Q?b0WiYkVcRlVJv6MBa72luilVOclbVLaRTYK47fEiBFQPkb7fNBiHM9YCZoXE?=
 =?us-ascii?Q?0Hq2iTADk72a6ziQsQd2zgqg6ibmrU8SaCwX7EgQeoijTdDftEwzNdy1CFeL?=
 =?us-ascii?Q?C9nSWMFq87wrda47aHvKTDEyspk3H7rhFPFbQoXLaLnrALi+INDqNPXTFOdZ?=
 =?us-ascii?Q?RxbM+WsNTqtNxNHpELje6toY01MxjHwvhTPaVADLA9Ze/QuFnoRw4UsIdzHi?=
 =?us-ascii?Q?Z7rcFtfecVOhCZtoAoVicnslq5IqbIB3WsiEtFPPotx74mMd6OfyWzbeCkK8?=
 =?us-ascii?Q?hQEFKAP/3Xko/fn6jMdl2tvGgG0c64swUKPK7WM/dl1WUxNV?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW5PR12MB5684.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 80034ce5-cfc7-40cb-a5ee-08de5d5b30fe
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Jan 2026 04:18:57.8492 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: eb/LXSSuK8zuUDEvhQpvL3Q1yfYxa+xXaXcZ9RHFP1VNY1slHe7y90wCyj6fXHn71oRCej5qeBZZC+xstERPzw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6154
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

[AMD Official Use Only - AMD Internal Distribution Only]

Hi, Tao
        At start, there is a null check for each call of mp1->sys_func and =
sys_func->mp1_send_eeprom_msg. Thomas suggested we remove the check at thes=
e places, instead only check it in hw_init func, to simplify the code.

-----Original Message-----
From: Zhou1, Tao <Tao.Zhou1@amd.com>
Sent: Tuesday, January 27, 2026 11:54 AM
To: Xie, Patrick <Gangliang.Xie@amd.com>; amd-gfx@lists.freedesktop.org
Cc: Chai, Thomas <YiPeng.Chai@amd.com>
Subject: RE: [PATCH 05/14] drm/amd/ras: add wrapper funcs for pmfw eeprom

[AMD Official Use Only - AMD Internal Distribution Only]

> -----Original Message-----
> From: Xie, Patrick <Gangliang.Xie@amd.com>
> Sent: Monday, January 26, 2026 11:55 AM
> To: amd-gfx@lists.freedesktop.org
> Cc: Zhou1, Tao <Tao.Zhou1@amd.com>; Chai, Thomas
> <YiPeng.Chai@amd.com>; Xie, Patrick <Gangliang.Xie@amd.com>
> Subject: [PATCH 05/14] drm/amd/ras: add wrapper funcs for pmfw eeprom
>
> add wrapper funcs for pmfw eeprom interface to make them easier to be
> called
>
> Signed-off-by: Gangliang Xie <ganglxie@amd.com>
> ---
>  .../gpu/drm/amd/ras/rascore/ras_eeprom_fw.c   | 125 ++++++++++++++++++
>  .../gpu/drm/amd/ras/rascore/ras_eeprom_fw.h   |  16 +++
>  2 files changed, 141 insertions(+)
>
> diff --git a/drivers/gpu/drm/amd/ras/rascore/ras_eeprom_fw.c
> b/drivers/gpu/drm/amd/ras/rascore/ras_eeprom_fw.c
> index 4a65351569e8..5231dfe8c518 100644
> --- a/drivers/gpu/drm/amd/ras/rascore/ras_eeprom_fw.c
> +++ b/drivers/gpu/drm/amd/ras/rascore/ras_eeprom_fw.c
> @@ -36,3 +36,128 @@ void ras_fw_init_feature_flags(struct
> ras_core_context
> *ras_core)
>       if (!sys_func->mp1_get_ras_enabled_mask(ras_core, &flags))
>               ras_core->ras_fw_features =3D flags;  }
> +
> +bool ras_fw_eeprom_supported(struct ras_core_context *ras_core) {
> +     return !!(ras_core->ras_fw_features &
> +RAS_CORE_FW_FEATURE_BIT__RAS_EEPROM);
> +}
> +
> +int ras_fw_get_table_version(struct ras_core_context *ras_core,
> +                                  uint32_t *table_version) {
> +     struct ras_mp1 *mp1 =3D &ras_core->ras_mp1;
> +     const struct ras_mp1_sys_func *sys_func =3D mp1->sys_func;
> +
> +     return sys_func->mp1_send_eeprom_msg(ras_core,
> +                             RAS_SMU_GetRASTableVersion, 0,
> + table_version); }

[Tao] do we need null check for mp1->sys_func and sys_func->mp1_send_eeprom=
_msg?

> +
> +int ras_fw_get_badpage_count(struct ras_core_context *ras_core,
> +                                  uint32_t *count, uint32_t timeout) {
> +     struct ras_mp1 *mp1 =3D &ras_core->ras_mp1;
> +     const struct ras_mp1_sys_func *sys_func =3D mp1->sys_func;
> +     uint64_t end, now;
> +     int ret =3D 0;
> +
> +     now =3D (uint64_t)ktime_to_ms(ktime_get());
> +     end =3D now + timeout;
> +
> +     do {
> +             ret =3D sys_func->mp1_send_eeprom_msg(ras_core,
> +                     RAS_SMU_GetBadPageCount, 0, count);
> +             /* eeprom is not ready */
> +             if (ret !=3D -EBUSY)
> +                     return ret;
> +
> +             mdelay(10);
> +             now =3D (uint64_t)ktime_to_ms(ktime_get());
> +     } while (now < end);
> +
> +     RAS_DEV_ERR(ras_core->dev,
> +                     "smu get bad page count timeout!\n");
> +     return ret;
> +}
> +
> +int ras_fw_get_badpage_mca_addr(struct ras_core_context *ras_core,
> +                                     uint16_t index, uint64_t *mca_addr)=
 {
> +     struct ras_mp1 *mp1 =3D &ras_core->ras_mp1;
> +     const struct ras_mp1_sys_func *sys_func =3D mp1->sys_func;
> +     uint32_t temp_arg, temp_addr_lo, temp_addr_high;
> +     int ret;
> +
> +     temp_arg =3D index | (1 << 16);
> +     ret =3D sys_func->mp1_send_eeprom_msg(ras_core,
> +                     RAS_SMU_GetBadPageMcaAddr, temp_arg,
> &temp_addr_lo);
> +     if (ret)
> +             return ret;
> +
> +     temp_arg =3D index | (2 << 16);
> +     ret =3D sys_func->mp1_send_eeprom_msg(ras_core,
> +                     RAS_SMU_GetBadPageMcaAddr, temp_arg,
> &temp_addr_high);
> +
> +     if (!ret)
> +             *mca_addr =3D (uint64_t)temp_addr_high << 32 |
> + temp_addr_lo;
> +
> +     return ret;
> +}
> +
> +int ras_fw_set_timestamp(struct ras_core_context *ras_core,
> +                              uint64_t timestamp) {
> +     struct ras_mp1 *mp1 =3D &ras_core->ras_mp1;
> +     const struct ras_mp1_sys_func *sys_func =3D mp1->sys_func;
> +
> +     return sys_func->mp1_send_eeprom_msg(ras_core,
> +                     RAS_SMU_SetTimestamp, (uint32_t)timestamp, 0); }
> +
> +int ras_fw_get_timestamp(struct ras_core_context *ras_core,
> +                              uint16_t index, uint64_t *timestamp) {
> +     struct ras_mp1 *mp1 =3D &ras_core->ras_mp1;
> +     const struct ras_mp1_sys_func *sys_func =3D mp1->sys_func;
> +     uint32_t temp =3D 0;
> +     int ret;
> +
> +     ret =3D sys_func->mp1_send_eeprom_msg(ras_core,
> +                     RAS_SMU_GetTimestamp, 0, &temp);
> +     if (!ret)
> +             *timestamp =3D temp;
> +
> +     return ret;
> +}
> +
> +int ras_fw_get_badpage_ipid(struct ras_core_context *ras_core,
> +                                 uint16_t index, uint64_t *ipid) {
> +     struct ras_mp1 *mp1 =3D &ras_core->ras_mp1;
> +     const struct ras_mp1_sys_func *sys_func =3D mp1->sys_func;
> +     uint32_t temp_arg, temp_ipid_lo, temp_ipid_high;
> +     int ret;
> +
> +     temp_arg =3D index | (1 << 16);
> +     ret =3D sys_func->mp1_send_eeprom_msg(ras_core,
> +                     RAS_SMU_GetBadPageIpid, temp_arg, &temp_ipid_lo);
> +     if (ret)
> +             return ret;
> +
> +     temp_arg =3D index | (2 << 16);
> +     ret =3D sys_func->mp1_send_eeprom_msg(ras_core,
> +                     RAS_SMU_GetBadPageIpid, temp_arg, &temp_ipid_high);
> +     if (!ret)
> +             *ipid =3D (uint64_t)temp_ipid_high << 32 | temp_ipid_lo;
> +
> +     return ret;
> +}
> +
> +int ras_fw_erase_ras_table(struct ras_core_context *ras_core,
> +                                uint32_t *result) {
> +     struct ras_mp1 *mp1 =3D &ras_core->ras_mp1;
> +     const struct ras_mp1_sys_func *sys_func =3D mp1->sys_func;
> +
> +     return sys_func->mp1_send_eeprom_msg(ras_core,
> +                     RAS_SMU_EraseRasTable, 0, result); }
> diff --git a/drivers/gpu/drm/amd/ras/rascore/ras_eeprom_fw.h
> b/drivers/gpu/drm/amd/ras/rascore/ras_eeprom_fw.h
> index 58472e459470..ad98077d532e 100644
> --- a/drivers/gpu/drm/amd/ras/rascore/ras_eeprom_fw.h
> +++ b/drivers/gpu/drm/amd/ras/rascore/ras_eeprom_fw.h
> @@ -24,6 +24,22 @@
>  #ifndef __RAS_EEPROM_FW_H__
>  #define __RAS_EEPROM_FW_H__
>
> +
>  void ras_fw_init_feature_flags(struct ras_core_context *ras_core);
> +bool ras_fw_eeprom_supported(struct ras_core_context *ras_core); int
> +ras_fw_get_table_version(struct ras_core_context *ras_core,
> +                                  uint32_t *table_version); int
> +ras_fw_get_badpage_count(struct ras_core_context *ras_core,
> +                                  uint32_t *count, uint32_t timeout);
> +int ras_fw_get_badpage_mca_addr(struct ras_core_context *ras_core,
> +                                     uint16_t index, uint64_t
> +*mca_addr); int ras_fw_set_timestamp(struct ras_core_context *ras_core,
> +                              uint64_t timestamp); int
> +ras_fw_get_timestamp(struct ras_core_context *ras_core,
> +                              uint16_t index, uint64_t *timestamp);
> +int ras_fw_get_badpage_ipid(struct ras_core_context *ras_core,
> +                                 uint16_t index, uint64_t *ipid); int
> +ras_fw_erase_ras_table(struct ras_core_context *ras_core,
> +                                uint32_t *result);
>
>  #endif
> --
> 2.34.1


