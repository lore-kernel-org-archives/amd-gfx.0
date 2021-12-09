Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CE287C433F5
	for <amd-gfx@archiver.kernel.org>; Thu,  9 Dec 2021 16:52:56 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 329B310E127;
	Thu,  9 Dec 2021 16:52:51 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2066.outbound.protection.outlook.com [40.107.243.66])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 46B8810E116
 for <amd-gfx@lists.freedesktop.org>; Thu,  9 Dec 2021 05:53:46 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=clp2YiokvRU36qiWSCSQsTBdEVrrMhOx4wpPUzBzsk0ypiy7h5n9rooTFzooKyftABAPqaM4Yx/juC1xTaF4zIbyeHOhL71n3zivEz7vKF6ILiljOxWuuL5CY/ZS0Fjxhe2KFwVkIgnTICEPvtLaweWAdx1o9k4hqwK5xK49jhhhtC0dhMxXbu8NBOKvB+GXBYG9N2DywX60MU1YkHJQFQHhLQfhZluwR0op33zD2uTWu3uHSi/cH636LSWl+479PVO0lD9009hhkXs7Y/vbnU7u6E2tiD5TdyNryFugbljSN1G3H7I1K2LQPdrDLyTDaLW8yIlI7LwqymngfMLE4Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aeSfg2x/at1YQ90hDAiaZuMs3pj+vcEpV8H8+5bBO1c=;
 b=PgJOWRxQX17dhXVNkXL5OqTtzn3xZsKLPgAzDQlarc+q6JLN3RkAgmOUUkOrfQQrfOjRuaX2FZaEmdadAYAd2Zd35wOqn1VfNztJJDw+g2sX/QDVGWDIID8OR8wtJSMA8QruywbPNoddV0TuDWnnZck6F04I9LgHHyVILLl0l14+y1lcuRpsNOnJlCw1u7U6M1rOoL8rsf6+pxnARj+y/MSjktockMu1XY3EvwzdFm2FXgBY+n5Wf+zGjooGhKbicAuqv74Bnyp6uRmuBe4/bw0NpnEa5sir9r3q3/TUpWZB2re5ikJDn/cDSHKW8FnUTAzbmmCSHT4TmeAvCNlDMA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aeSfg2x/at1YQ90hDAiaZuMs3pj+vcEpV8H8+5bBO1c=;
 b=L+5TXkIpBtNC9p2/Zbcy2bobOWhsbeB+seiiYCyzBkxcgxDVbEz76CvdBViKwiBTLsCRMiVWEorwS/YXP2w5aUJ53QVlHJrSqkWsP+47KNYtC0mJo+mPliq/oD6r9Ja5nN4W8jPhM6wbT3QfezLEAqvC5aU5cE/arZIm/iwEALc=
Received: from BN7PR12MB2609.namprd12.prod.outlook.com (2603:10b6:408:28::33)
 by BN6PR12MB1330.namprd12.prod.outlook.com (2603:10b6:404:1e::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4755.21; Thu, 9 Dec
 2021 05:24:21 +0000
Received: from BN7PR12MB2609.namprd12.prod.outlook.com
 ([fe80::44dc:faaa:ef09:66c5]) by BN7PR12MB2609.namprd12.prod.outlook.com
 ([fe80::44dc:faaa:ef09:66c5%5]) with mapi id 15.20.4755.022; Thu, 9 Dec 2021
 05:24:21 +0000
From: "Shi, Leslie" <Yuliang.Shi@amd.com>
To: "Lazar, Lijo" <Lijo.Lazar@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: Recall: [PATCH v2] drm/amdgpu: fix incorrect VCN revision in SRIOV
Thread-Topic: [PATCH v2] drm/amdgpu: fix incorrect VCN revision in SRIOV
Thread-Index: AQHX7L0FcnRgFaWEm0uKUtGsO2/70w==
X-CallingTelephoneNumber: IPM.Note
X-VoiceMessageDuration: 35
X-FaxNumberOfPages: 0
Date: Thu, 9 Dec 2021 05:24:21 +0000
Message-ID: <BN7PR12MB26092E9A576E209637989AA8E0709@BN7PR12MB2609.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 4fcd76dc-e1d5-47e3-e0ba-08d9bad427d9
x-ms-traffictypediagnostic: BN6PR12MB1330:EE_
x-microsoft-antispam-prvs: <BN6PR12MB1330508321FA266780F7BA3BE0709@BN6PR12MB1330.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:4941;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: uDAomp5Eu5AfHJmAmAiQQaCaKOmeAOH9GhS9vsEKFHCfvsYXqRGWEdRe9C2zeLAWIvlTDAQ2o7g6Ai9DqV4vEpdxRl4bxZExxvdG3+FW7sUU4ztIpsAneAkan/rpdpwnnEB271kKWYEyel4RK2BNEwEAWPeHb8JqzsAZwGlC+NVICtEGOPcGWJXh/7cbDMSSI9jeaBTBgIseOHx2GnNs44V+3GWNIVaf2Dkl7k33guZxI+iMlVus52fyVdWG19tFaoPmZFMhbp8G2VGFCVQK6XcCzKqBas6b/HKMEH9C27wsi1xB2lpKy+qnwB5nmbksG5k6ldystAuDlBhIaSCg9tZrc641QeNV7EtgqxkwkQ8CYK1geGAH0hmZx78jewCrScDVfSqBWxHKU2n27NDozv5wzwMFM+siwbfJ4uZmnbvPgTiwNUZTQ9Jqj70v97tEt5xWYNsVVCRDlCqvLv3lC1vpxz78IA5n+KP3Xq+Xqd4xSpotYU2UYQm89LUl5M8ZEz9hlpkJJpVQjVtVnIgJQEmOWY6+kzZaDf8o8GoipLzRPQYPjl6aQTOPmwPZB0AT1hQZnvhyWz9LPDzyZkTzdp130HoXmBNPPZDCkC8UvUHqLRW3+KwrE+FogefybAX7Hjh6mIFam47OtJsZOk5ccmCOuNRVfS+o7T5N6qCMDXYBpWn3z+H9AOAB6VV2enHzU/7juk22rXC21BqmcEaESA==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN7PR12MB2609.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(558084003)(2906002)(38070700005)(4326008)(38100700002)(5660300002)(122000001)(83380400001)(8676002)(54906003)(316002)(33656002)(110136005)(8936002)(55016003)(86362001)(9686003)(52536014)(6506007)(26005)(76116006)(64756008)(66446008)(66476007)(66946007)(186003)(71200400001)(66556008)(508600001)(7696005);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?MxxHmKjXiS/YK5A32qOglz3RsFuD2rFUjNUwnlQRN4+6wZ3VWavkb/GIqZ3r?=
 =?us-ascii?Q?gPpel83M7frClXdbjN7GeKd4XfId7gvRjoBCqt23yf7ru8+o9z1xxUxcqZ1Y?=
 =?us-ascii?Q?Tlafnje1s6vI/gavurM56dBw77J1AuOjs2yhDGuNEROGP3J2AIrRjI0KlJc+?=
 =?us-ascii?Q?xlkzGok+2Uja5fuTjB55rBlDZ4stSv2Sv9wRls2XWS8ha1GYMMHxJqoIHxXF?=
 =?us-ascii?Q?PIjwRtjTLni994FXw0OMrWyx67kVil14cQeTg19ZhM22N4SWfBkpFmcxcm3w?=
 =?us-ascii?Q?DOvtZlhrO1QyoHUaeXum4224yNyXWylQVsV6xIz7xHJhg0IC8f2TFTm7O26F?=
 =?us-ascii?Q?jfuxjJF/Gg7hsW/AJudUoNdWy4xmYSOiKhxJ2VaIROLT71xhG+9kKCvU6k6a?=
 =?us-ascii?Q?YVXorjBMpN6wEFSWEg/tbJ07ZqXgL8I1n2rsDaWEbI7lP3wrD7avdBu76lt0?=
 =?us-ascii?Q?79JbkENbNFYGaEV42T1Zlotwnvow1TDkXwZOr0P06iUTT1sl57nIug/Qq476?=
 =?us-ascii?Q?f2QHLuu5RROiu0QqBhWSPEYzcX8x89lTBgKJMPIV8NEsyKVVCvdawLU8f7wk?=
 =?us-ascii?Q?DtgG49cGJP1MHhGQAMppQXIJ5xuzx3GwC0LQUQaxvZOS7ruaRvEaM4uktz9v?=
 =?us-ascii?Q?DCp309UEvXZjT4DH8FXF0hLDSSmbAS1HXDobAH6taaNO97emJlLWaeqLtoHJ?=
 =?us-ascii?Q?PiNo93sLT6leCwK7aG64bIFhpeujpESc0XvGlM6x4J6AzOKXnG6zCtayxCp4?=
 =?us-ascii?Q?0OX3b9vlJT8jxe7koZEXwWE6Sprh/cjNvRxmmCWALJ3euU4z/CTrI/W64v81?=
 =?us-ascii?Q?i/0frpKEJTLNuJl6ouJ/Ez7FwsOBOTlYteFxu8SK/mXU2unxj5f/DbwdB4X+?=
 =?us-ascii?Q?LXEie//PptULUg8kbwWSq2CA/vcMwVpN1SeeFLgW1IoAGji7WwPnsBarhJaI?=
 =?us-ascii?Q?yoSn61HhTBFT/3zhYPNkoeiF1HZKTyWgLtIjhPCVir8QHRShiNvHUAlKdwAy?=
 =?us-ascii?Q?uAw8XUGeEUGYHT9BwHmz7o+61KYDllfrRRsMapFocLA40AQa431jEEendaQB?=
 =?us-ascii?Q?Z/dHWq77h58/RI/l1aISi+aq4wW/98sfUpmeYo9tRbSY0RUloAiU/J9ZUd23?=
 =?us-ascii?Q?2vRzeVI5flpRU7Kqe5stntokyXj+BxUqXd4zAXm2AdhM7sqlfokugf/vsC8k?=
 =?us-ascii?Q?ClhEi0gY3PncAL8QbgGaME7sWxm759SoaB69nrM6If7JtuhfNqrkH2eLpfIP?=
 =?us-ascii?Q?6F1leIwe92jicZfYFLxzBTIIczIBKcDfgJ+BrVfdkH6gO3h/rFrEODS+0QBt?=
 =?us-ascii?Q?u/UATVjZkWKiNv5QWOaC74Kr9Ct7ZWHrYAVDRhxqWCR4DMvYwUohBh+7qF3W?=
 =?us-ascii?Q?cEFJeqY8LJRXS868llUrd8nKe0Ry3+/OpqKjhi6YOPnHjjJRyr2/nPOKhzfl?=
 =?us-ascii?Q?K4Tl4RIMoNahIHfslygwwFJUhFlmjZXryBKxjaKMlHagl1/avYbaMCaZvyaG?=
 =?us-ascii?Q?IV58l8/AKn3y0MStWRY4jss1OjHliDtnSWwjKcdHcql3o9l3dtyqXPFzV/a0?=
 =?us-ascii?Q?L5QTmKn2kZUEM/5qoStzk0759QRbU1kfQIm+aPAGBsJagrfm4jyAEZrck8VM?=
 =?us-ascii?Q?wNXaOHqIXYSinLAdioZZE6k=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN7PR12MB2609.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4fcd76dc-e1d5-47e3-e0ba-08d9bad427d9
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Dec 2021 05:24:21.3277 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: pxE5A8cinZMH99z3vVA9CHg9NLzm2fv2sGJw+xnrkzX/wbi3giSFqwkcz1T1GH4JAWI/k0z3nZCaFjG0tSGrHw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR12MB1330
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
Cc: "alexdeucher@gmail.com" <alexdeucher@gmail.com>, "Shi,
 Leslie" <Yuliang.Shi@amd.com>, "Chen, Guchun" <Guchun.Chen@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Shi, Leslie would like to recall the message, "[PATCH v2] drm/amdgpu: fix i=
ncorrect VCN revision in SRIOV".=
