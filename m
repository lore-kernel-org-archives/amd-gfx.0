Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2E9B8C4332F
	for <amd-gfx@archiver.kernel.org>; Wed,  1 Nov 2023 02:35:06 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AC2F910E617;
	Wed,  1 Nov 2023 02:35:05 +0000 (UTC)
Received: from NAM04-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam04on2043.outbound.protection.outlook.com [40.107.101.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 04EF410E617
 for <amd-gfx@lists.freedesktop.org>; Wed,  1 Nov 2023 02:35:04 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dPgOsRRzxtrAMdHX/MdnxFpnKEiAXvOKX5+LGG4le+4XgcjqbV1wKA+uyB8VXEvsAZmn6orJxRuJHRo6IwPZQRHqr9ynBCvqjc+RTnhZkocgQh30A9xzrySvUrvSSLcp3d0SSDPAaS8isX3x8+ku31SQ4CrjwSDfRhrWtopv5ia09tW2JZLAM8/eR/E0U52v5sdfXjWDIzPedLii9dcNGVEuTQFAQk7+Td2Hz+7BenxN7Veo3i9ZioBCF8ynTL7QIBU2azxgSzhsQhGPAfatyq8W5XDmb2Eeof3A1Fsep0fUPkUiPcKIgZW+SdD+hJclZzBGVveIIUT1fcUkJgExfA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BFtpMLz2Up6SBB3M/EYeBICRLrzVxn+Xepau6NSGbec=;
 b=WlAnmQULzbMVVixyVCauJuIavhz8dkMsN8k7i1rzHCbG9v8BWpqaKRtU3rRDOMU7LUqDaVB8+InTfEti7XzK8C8QZRBYx+WJbh+bbft9sJSb4lNue0POjWOz0kwrcNsva2qCcwx+/GRF+sdaEteeuYMQp52/EFawzSmM4lyAusNhMmsayyNED+COE0OfHYOJu1BlxXCgWqD3nvCfTCtJZVkdFzgHapPdOFXNbdxMlv7zUOTcwEFmLCz+SXYUnwg3CLIIgGefZhEICaEVl3acs4mnSebmej9sJqsv+3QJVaxBLHI87IzfE9JDMfnps5NBNxmnI6wCsHfttgqPGPWBaw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BFtpMLz2Up6SBB3M/EYeBICRLrzVxn+Xepau6NSGbec=;
 b=qK9qUBcFjENMb/FgEFNp1siTjE9c8H2QICYyiT++lQxpcnVhF6KefqwGTnS59rV1HroaTUQbyJVJwdM0hBqpM+R7SUqMu+p33mQvACkpuuJL5K3G87U+Twc7RAoiSQbTBwbWKkaThkk9BHFfLzN6i5jnUrgiv05k1BHLmr4XUm8=
Received: from DM4PR12MB6351.namprd12.prod.outlook.com (2603:10b6:8:a2::6) by
 SN7PR12MB7275.namprd12.prod.outlook.com (2603:10b6:806:2ae::9) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6907.33; Wed, 1 Nov 2023 02:35:02 +0000
Received: from DM4PR12MB6351.namprd12.prod.outlook.com
 ([fe80::5287:5f3:34f:4402]) by DM4PR12MB6351.namprd12.prod.outlook.com
 ([fe80::5287:5f3:34f:4402%7]) with mapi id 15.20.6933.028; Wed, 1 Nov 2023
 02:35:01 +0000
From: "Ma, Jun" <Jun.Ma2@amd.com>
To: "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>, "Feng,
 Kenneth" <Kenneth.Feng@amd.com>, "Deucher, Alexander"
 <Alexander.Deucher@amd.com>
Subject: Recall: [PATCH 1/2] drm/amdgpu: Optimize the asic type fix code
Thread-Topic: [PATCH 1/2] drm/amdgpu: Optimize the asic type fix code
Thread-Index: AQHaDGwDuKzJx/LqfEyHClbnofGsWA==
X-CallingTelephoneNumber: IPM.Note
X-VoiceMessageDuration: 35
X-FaxNumberOfPages: 0
Date: Wed, 1 Nov 2023 02:35:01 +0000
Message-ID: <DM4PR12MB6351FD999F62DA0A38ABE1A6BCA7A@DM4PR12MB6351.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM4PR12MB6351:EE_|SN7PR12MB7275:EE_
x-ms-office365-filtering-correlation-id: 140de428-c47e-45ce-92f7-08dbda832630
x-ms-exchange-recallreportgenerated: true
x-ms-exchange-recallreportcfmgenerated: true
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ySm5kLT45J0G++yHytOWpYYHM5VS4fW9ACRCJv9mYGIGDXakfq76ZFttSFaABjRJEs4zJZej61A28Wo57mo1BoZtCzZKWLh3VrWSBIC++OKl8mH87YSD2yEhcAzBWnMo2fIeUCqWQgtxM2wqzdvvMZqya5dlNQeod2FT16MN5YtUAkNbD900zhb3y/wZVi3E6ALzyWJ1I0NYHrsPneaE1aYN+BfyouleFkH259KpRuH6QK2oSChwIPDEatjXQ4BcF7qEJwRrepvSifiR8QGGJyKOCQ/8Ketl/DwA5tJKa/QQJKgrwgeJL2PWHLE+aZ+TWvLM1edFUMApDh7QC2x7PLouWG5cSfYuYbYGQ6FTqkPwLm/g+uHY7WM57RgPPqfZ/Y/kmqbbL3U2gYQm4dYsNy0se9I/A24Xf9VxHkfcfE9UIAZ/k19vJ5PF2LdXayFhuMvAp7sFBCBbc3/Z2qrHRkdhdc23wttSE1LisqgA9cVyv5vKFL/qiTBDsONMs4kaa2jLjwe6j8Vh+XxemvS1eo8s1s90G2fHX6m8r+R5lo2z6CXp9xt1iG3mhhdEHhwrhTMmxhuxlknelI/yy4d1y0Sf9g6eJBlglEd6vHYQ4xxr1KhUVkVn/xWMqyFIDBZ2
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB6351.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(396003)(366004)(346002)(39860400002)(136003)(376002)(230922051799003)(186009)(64100799003)(1800799009)(451199024)(26005)(38100700002)(2906002)(86362001)(4326008)(55016003)(33656002)(64756008)(122000001)(66446008)(66556008)(478600001)(7696005)(9686003)(83380400001)(71200400001)(6636002)(76116006)(66476007)(52536014)(316002)(41300700001)(5660300002)(110136005)(8676002)(8936002)(558084003)(66946007)(38070700009)(6506007);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?eHm9I+fGvCF9V8CaRPeC1nx4g4n4cErWZBOgDnixA2HBsdTZycMyvlDTCtaU?=
 =?us-ascii?Q?5+nbldPHyHwz1vNmw8ZMZ2HA4aZojpPAb9qBsijJnti5KRdLJDrlpD+IJmbw?=
 =?us-ascii?Q?z6mSNNyD/64YqctwoZ74o24AN1AfwW+AogPKCyK3x0Le91e77bXyxFeBHC36?=
 =?us-ascii?Q?f5IxPy9Z7ZaRvkZCsXFkCl2h3Vd/Sf3oYzEwkjSmK8djuCDrQgGzooDbIOgp?=
 =?us-ascii?Q?OXwZjhH8qN1YjnDICEsHLqeQADXUJx/4Lgrs1iUivdZ6+d34+qIdiUbNL8Sh?=
 =?us-ascii?Q?QG4eKa0fjCvULPqXTU6ffPNhYE7e9pzWE+jsVg2MlItfiYClSOdG9QYvHHY6?=
 =?us-ascii?Q?tu/Q8yJ1ijaAd0LtwfPvPYkZLYDTpNqXMSGdtYWM3BJBLbQHVUiQjICd8DV/?=
 =?us-ascii?Q?DoqWWroGBen8OkBmDy2deRdpHvDa4oO7SLMXpt1h1DxipRJWA2sMmpxHjzyW?=
 =?us-ascii?Q?ny9mkoR6rsG9IRymZL4uY6jQTHGgk2cUsXq3GuTaXBvPbJvt5MWvJmbhj4pN?=
 =?us-ascii?Q?KehUDnkLoIzLV84HPPekg72eDTWq3PFCirt0ZsX5IQ/XGa2wrAsJhw8SreqN?=
 =?us-ascii?Q?3Ojz5t40wH+FafyN2hnrr5Pz2IESq3IZUzFl8Py+AYdI4dObaA1Sfec+/mGl?=
 =?us-ascii?Q?B2k1ob4jqNPL7Osb+R+5kcimtlKMzOtJTBYPP6fBXacMTmgLlXc1cq8gwwit?=
 =?us-ascii?Q?vG9+mWTukSffsHAbUjLifmt38U9moWdxzR1O68ETN4K8s20uyi24EHbeen3m?=
 =?us-ascii?Q?Jb+elXu363Bd/Dm0mQXkxMvwURF3t3Grc+tYQf+eHindGwQYXxUlA8sB1PUb?=
 =?us-ascii?Q?IE7Vp0mVxJp81n1OhcFXf4q8wp07EfZDXMLknHoRiHRCaNErOThi+r1Hkqo5?=
 =?us-ascii?Q?VSgR80g1alrNy4mEpEjgx/oiexeXdcDcMNdWVgj/dsQ9L+AWYnl9fS0P8ZDu?=
 =?us-ascii?Q?7+y/XqgQoHGfI0eiCZgv//I2I8TdZKhGdAcV9X5ZI8qgK05zrhSEUGmamStt?=
 =?us-ascii?Q?t8aOF4YU1gAAvmHSVf+W3FUGmxmF/PQzjQ+EU5S1ZF9eylTRxcDJ7rMcf6uM?=
 =?us-ascii?Q?ZrYrhzejHSaAYTY9f8gEMwajFq6oJockLoL5c373FoWxIqDo+IpEcyjW9Ur/?=
 =?us-ascii?Q?+C7u1Cbj+DNxecpLNi04TpMhCSddKvG1zfFTTisVD7N2/XGNECyBKe+y6J+b?=
 =?us-ascii?Q?uNRdOIePQBUWpi1+/r2fyMj2dsZ9P8/BUkwwcCH8xr1qEABtnZc/Kj4Mg31x?=
 =?us-ascii?Q?/7Ik3etX2dJwVVV11+nYxsLYK85Q8tvwPnrUbXXOs9N0Jps4es6RWYcVFbk1?=
 =?us-ascii?Q?VK4V8xX5LIz1C00nYXXZgUjPZXhojU9RT/KLg/u7Kut+Dax53P5/+MtfOX2o?=
 =?us-ascii?Q?2zYR9DOWYOiLJ6XSujUORb7+G4oisPvOJrGl93E1dHSblJiCwwnbld71/Ie8?=
 =?us-ascii?Q?DdheepRLunebHBjSvnu/2idVp/ctxI9nBpStk9To37QHGMkzYOAroSYoDOwI?=
 =?us-ascii?Q?2PnV4ptTOmUkXVPpz/Otsd7HO9UaHotlneaW+LDA4/lp4EyKal3jVLEhKtSn?=
 =?us-ascii?Q?xTh0+aUfjMvnDPm2oPw=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB6351.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 140de428-c47e-45ce-92f7-08dbda832630
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Nov 2023 02:35:01.9241 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: pNoOUIb8IxLz0papaXf5qfttUD5gi1amB41pSy0dNWWGMKavUasq1NZceDHoQMmD
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7275
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
Cc: "Ma, Jun" <Jun.Ma2@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Ma, Jun would like to recall the message, "[PATCH 1/2] drm/amdgpu: Optimize=
 the asic type fix code".=
