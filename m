Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DA9A7C46467
	for <amd-gfx@archiver.kernel.org>; Mon, 16 Jan 2023 07:08:33 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1474610E05A;
	Mon, 16 Jan 2023 07:08:33 +0000 (UTC)
Received: from NAM02-DM3-obe.outbound.protection.outlook.com
 (mail-dm3nam02on2076.outbound.protection.outlook.com [40.107.95.76])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2208E10E05A
 for <amd-gfx@lists.freedesktop.org>; Mon, 16 Jan 2023 07:08:31 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KTGx4tF0qkKdUKABFSsSFWcj2ZASv84lVoJjTlmvSAYeCZ+dmtacvWtzhV5SwDD8cqSd8r+hnU7cX59n4uYYft5NbK1hdiXi31EXlbrbMuJKO8SuZSzgnrT8AocfOocVQXFiH28yrJ3JQQcTGffPlP7XiEsmS47kv7QkbUR0SLeWqIEymUKazVbSAdIrdr8C0UCfl6OI5epb9IgmbkdQ4ZTnc4NmjsA4MB4I3s8u0nMJs0oLQBciLbaNAHZNElzBQj0hoFJLVgnh2oRvkqeVYncGQ0Y1f1S5sjwleOQ5vlI/380VDiP8Mo5QVIF6dwYhAmsg3yygSh1AQZpMKBT41Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZCvEYG8LhL5s+a/xE9dLFrGSoT1XZI23+5D19ypASDs=;
 b=fDWr6gcNkiyNLxcvBg+QteWhPKz7tMLfBzDa1SDz8dsj/Kn+w56XggS9u6Pk0/E7q16lfvpMzbs+bDt36M3GIWCVsxS/q9lv3wlxLTta0GmQPoWZJhbGKJTHZvVdIR0UN3i/dZIn0bFKvPhopeXfbcH0jmlv8Y7s0w/pD4pof3llMJHouSQQezE3IyvqlX2PoD0K4yKUxU0WW7J8gE/gmtIB3VDWrCMPVoz1mrqsjs6v2NhgQOo9ABMBjikW5kTCesHpXCR7HnbC2kXPx72H9ZcqBUbS44UdBNfQ4dw+oizid8qRtAljclImyrvZcP3uW35Mj0i0q1hkiDoxao7GbQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZCvEYG8LhL5s+a/xE9dLFrGSoT1XZI23+5D19ypASDs=;
 b=TTdX7umnuPpV2RhNPMnC+zkOKqTo9Yqfjl9VUCPPwYDblQQmT0YDpcdd0J9K/vjP2MxNfxAN58HLsFtyDvalYiq7lIruXGpOWm4z9bMBUQWaOgbwxxdjfbLfJsZUKH3RNVTF0roBzWU1zegjzjxDpK0fnRZMnPRy6CjZKWc5wII=
Received: from DM6PR12MB2619.namprd12.prod.outlook.com (2603:10b6:5:45::18) by
 SN7PR12MB7250.namprd12.prod.outlook.com (2603:10b6:806:2aa::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6002.13; Mon, 16 Jan
 2023 07:08:28 +0000
Received: from DM6PR12MB2619.namprd12.prod.outlook.com
 ([fe80::5dc8:98e2:7b6e:a9db]) by DM6PR12MB2619.namprd12.prod.outlook.com
 ([fe80::5dc8:98e2:7b6e:a9db%5]) with mapi id 15.20.5986.018; Mon, 16 Jan 2023
 07:08:28 +0000
From: "Quan, Evan" <Evan.Quan@amd.com>
To: "Deucher, Alexander" <Alexander.Deucher@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH 2/2] drm/amdgpu/pm: update hwmon power documentation
Thread-Topic: [PATCH 2/2] drm/amdgpu/pm: update hwmon power documentation
Thread-Index: AQHZJqJvybyAoW+yNkSZmUBP0C2a766gpUgw
Date: Mon, 16 Jan 2023 07:08:27 +0000
Message-ID: <DM6PR12MB261945C65AC80623436B55A0E4C19@DM6PR12MB2619.namprd12.prod.outlook.com>
References: <20230112162443.603552-1-alexander.deucher@amd.com>
 <20230112162443.603552-2-alexander.deucher@amd.com>
In-Reply-To: <20230112162443.603552-2-alexander.deucher@amd.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2023-01-16T07:08:24Z; 
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=56604cf1-887b-4595-a530-8d77cc8f5b9b;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=1
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM6PR12MB2619:EE_|SN7PR12MB7250:EE_
x-ms-office365-filtering-correlation-id: 36ee2507-8c81-422e-01f3-08daf7907797
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 2BQ0o+mwDazH+1qgpHHlIwvxXg0uOmd48rjZ/Jeg/GEgSHSFRBj7dPQzS2DBCw5ZwdfvkPwY1toXWRC7dJeBUu46Rlq59A0Lluam1BExN6AXrTYi/FL7YgAoD15ib2yvKW+eRBhU7XVya3mCSHfb2692EJuCOFZrquTgOLulYqvC5bsGoaMUS+RaIusTXAP6lUKysGnQUa6HPQKU3FlsbjhwZcHYoCJk16SSyFngjiJ6OBL2CdnJvfukbLQVX2JrTQVpZQrSPohlKHHFUkyn5tf7vdinqo88c2RrvMrGwYyWcf0w/6aFWUCn1bQ5uXWGzJLG/lfMkmw71HvosZSFRwRVgvSfdaP/jP0kWr+42yx75+RljX917zrvqj9+vH0BibfgC9CUN5K6PhzIuaxcaPS585I9kSTqNrUkBtBl9S17S6o+xndMS3yfWQwb3nsZ4p3EyHbqdrnSCjhkKzGbDDiBykszGLax6rI2k68M2yiHm5Kiln08uyOwRwJASEpY/K1d+TH7gLy92DxwbsGQYmtPJOXHUmU1zMMTHmE3HdQtJVfOiUnJTNtktM1FcKgT/7/QonPDbipBM3VimVD9aA8c9Ojc8KlKPJAqbUFqP625sf69VZ+DZM/f95x96lhhr5j7RWbqh2X41tEj0eBZ8EFsV3Ykdlp++xG5sC1OtV/BqQQF5Gvwjk2GXXO49axS
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB2619.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230022)(4636009)(346002)(376002)(366004)(136003)(396003)(39860400002)(451199015)(66946007)(15650500001)(5660300002)(2906002)(33656002)(110136005)(316002)(53546011)(26005)(38100700002)(122000001)(83380400001)(71200400001)(7696005)(186003)(55016003)(9686003)(86362001)(478600001)(6506007)(38070700005)(52536014)(8936002)(66446008)(4326008)(66476007)(64756008)(66556008)(8676002)(76116006)(41300700001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?U3HGVndnjTt5Pfk2LCpp2tXsQlU2Yc3QGLN5EisZ5/QOe3XUM28cejVIe+a+?=
 =?us-ascii?Q?5HGMG7hyot2CfNm61OxEPLvovZHfgLKtqbFulTdbYyBLRKPbiVTYuqIrGvU+?=
 =?us-ascii?Q?+RRujFowlQ7ESm/lGG5VeokCqDbph7CrW9ff2mbloT71zwH+dOiX7oGoHUwP?=
 =?us-ascii?Q?j0eM9uwHeqt01fIyB2jwUR071rccMPpg4I6NAIW1kOSefkCGrqF2ruWdX5Ns?=
 =?us-ascii?Q?zJTKSMPD1rFMvZ863QJiCtX0dPLiBXp09IXVprdAvqTe5OdMXuIV25PH6aR3?=
 =?us-ascii?Q?iF+8vvB1mnSSIfXEmQ3LDA3uNYIh84HWrrkujjy8yb/DtSHyXjrFR+ZPAyZk?=
 =?us-ascii?Q?oS/wPo67fANYnXWL/6qWXDMhWk3WqmBRvTG9xUgaIC0jf/HcpT+/krUg9LX/?=
 =?us-ascii?Q?TCCnKkSVqEPOxRF8p3qqczmYX1GKlKIDpzOM/2xy+5o0NYzoCoC5ubxbgEdH?=
 =?us-ascii?Q?h+obIYXh4vkxwEe8ZkiAKfTYU/qw8TBEgUGC55n23Y0N+6u0NMkEJuZTah+3?=
 =?us-ascii?Q?kHRYVHEQqx1dEpjjB1OCxrqsOYJub9AowSysrA6l4x2RvNJyxB9x/jo/1xLr?=
 =?us-ascii?Q?rDMz9BnuEX7q7MqDvOK0k8+q0sH/FPEBufV6AbAZ63akjvPw9uwqczM0uSO1?=
 =?us-ascii?Q?lH9gIa4NLXw0GnhJPptwZvkesl2RS72A02TUcNDnWFQcAb3bHTdtDY3MhNSQ?=
 =?us-ascii?Q?1gGoNy8DUlotWcfyVKd+JkaIx5BAILqJ3DBqzJeQFOhXXn6z1TJAdwIwy9ra?=
 =?us-ascii?Q?RloFJRTExzNMdAUDYy/6//cgbKxKtVlcyfaxLr/pMF0HeZowUPnh6hNDHOjS?=
 =?us-ascii?Q?eD072YSU7Z3m/aIWvlZn2QKDhsZRj6WgXjmn+Vx8SWXsdYVxBbyC8jy6tjAg?=
 =?us-ascii?Q?hvdwkhWRSgfSuTrLcEAvdKL1GEMH48Xe+oCuTQmqU2xflw4q5gb6nP4l3vrH?=
 =?us-ascii?Q?QcxRUlx11XSPFQq3+uuz2h6znAbIvoduGxvIUpR3f4erMAgVfPQc+tWxYh7O?=
 =?us-ascii?Q?z45w49K0I4BYKd7d0VBXu7VBpvHhZYkTHtIRpxnbcbhjTpvrrja3cM+0cgCy?=
 =?us-ascii?Q?3HJ6oHgANW/lrgCfItyovxkmcsSbpfJE3n3aVKwPMOebPwn0yC38JWAYxQn7?=
 =?us-ascii?Q?IEaA5k5nbPNhlcbm+UAYJ63bJOKCA0hpQ/P508F1rWJVUrnQJytdkW4QLjXO?=
 =?us-ascii?Q?PQnPNPsEMqPC/5HADtUWvAULOi/1er0NHbfoj5asBuNJPKgHMYeO/vNC3Xee?=
 =?us-ascii?Q?/NGOIC8rugK2lL8GmuDRogyD+zBG2NiuR529roQsogm+Xw+8qB2oRE1vUJ0g?=
 =?us-ascii?Q?fwVlnQbBlCBdMgnkak03QG8jshaL6k+4mJoV+5RJ4PAqM8cpWkidbp/xTzdT?=
 =?us-ascii?Q?QCW556nwjM/RClBlLp+CvpUXAKQXwQXhNGwjg4MyUC2OQNJHJLZXiwV0KRIA?=
 =?us-ascii?Q?KWMDW26z/Hh18EqiJCapmurVR0I/XVFCf5ePrRvs2fnPCZZoqrSNEU3ezON9?=
 =?us-ascii?Q?yMPekZ16RywkWnzEWW+04y01mf3Bg1HihGlTp2LMD7Fv8hjnQptYUWVwqS+7?=
 =?us-ascii?Q?TMhbJiIJSV72MLHegUo=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB2619.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 36ee2507-8c81-422e-01f3-08daf7907797
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Jan 2023 07:08:27.9926 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: +77R9M6oFG0qizwKZSoB0toZjcHHV7D7BFNcaClGMrDtap8Jk1xqXlvA9YLSNRMf
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7250
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
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Official Use Only - General]

Reviewed-by: Evan Quan <evan.quan@amd.com>

> -----Original Message-----
> From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Alex
> Deucher
> Sent: Friday, January 13, 2023 12:25 AM
> To: amd-gfx@lists.freedesktop.org
> Cc: Deucher, Alexander <Alexander.Deucher@amd.com>
> Subject: [PATCH 2/2] drm/amdgpu/pm: update hwmon power
> documentation
>=20
> Power reporting is socket power.  On APUs this includes the CPU.  Update
> the documentation to clarify this.
>=20
> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> ---
>  drivers/gpu/drm/amd/pm/amdgpu_pm.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/drivers/gpu/drm/amd/pm/amdgpu_pm.c
> b/drivers/gpu/drm/amd/pm/amdgpu_pm.c
> index 236657eece47..76b9ec64ca50 100644
> --- a/drivers/gpu/drm/amd/pm/amdgpu_pm.c
> +++ b/drivers/gpu/drm/amd/pm/amdgpu_pm.c
> @@ -3059,7 +3059,7 @@ static ssize_t
> amdgpu_hwmon_show_mclk_label(struct device *dev,
>   *
>   * hwmon interfaces for GPU power:
>   *
> - * - power1_average: average power used by the GPU in microWatts
> + * - power1_average: average power used by the SoC in microWatts.  On
> APUs this includes the CPU.
>   *
>   * - power1_cap_min: minimum cap supported in microWatts
>   *
> --
> 2.39.0
