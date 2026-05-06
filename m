Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6BB26CD342C
	for <amd-gfx@archiver.kernel.org>; Wed,  6 May 2026 09:45:54 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F362410E19D;
	Wed,  6 May 2026 09:45:53 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="D2e0azjo";
	dkim-atps=neutral
Received: from BN8PR05CU002.outbound.protection.outlook.com
 (mail-eastus2azon11011047.outbound.protection.outlook.com [52.101.57.47])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7B52610E19D
 for <amd-gfx@lists.freedesktop.org>; Wed,  6 May 2026 09:45:52 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gDTyHd2XTNNeAPSfSqiiBFueUFqE1G+Ajxis+9eOE5I1FH60n5/aev98cnSg2GGJGvq9WSbd8Fd3XKIEImdKt7Dw8htaHhpjasJBYkXTe3Sc39t7rTmd2Z7A8545VZS8lYYoPFm44Pg6wtmLZhhaFsoyvN0Eo943QbmO8YnBBC5iI1xXYH0KgrXK7HSal3gQSXuxJ2jzSR3oiqIvXpmmzJHeaE8U3osk04m4c06CIkxTeLXIzoJQVH9vqq8t82/lnhR7BWVjvvQYfgxx8FhNnqqz3F8de/pHpjl7xdB1JINN4g+b3DFTaPdKffVhxI6SWFAzZV7460iwf87qpOH0Jw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=32yFSEi6eREiIBOe5wpNROBWm4fXnJgkZFv20mYFNoQ=;
 b=ZR/cAp7zeoRD99u9tUTyUbbOQJ1jb4of22AYy+tNnHBDCU4vbcWzx04IHHr7v1tKD27Ts8Z+Ar6zwpOheGKjhqLBzowpZwdjO1vAscSrxTmcHI+hFozhYlpR9SCRSNYFGk6cWiHS62RPX56f8KHA6Np/jhQEWADoyl59YZnd31w8RatI4OZG0M3Vnufcgk5P7++JBiSW2BHx30kaqcrL3r//XInwnUH2cSMqICSrf+z1sfTzeqPftYnagXUAiWFyiR6QWiCkM+sdQrHfbQdLi+LpWJ+JGMVKbY9Q5bO/Iz3sZYULAQ/QvgYzuneqH9QmuVT0kEBLxIaRWUQNUW5Nrw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=32yFSEi6eREiIBOe5wpNROBWm4fXnJgkZFv20mYFNoQ=;
 b=D2e0azjoZTZ3+DgnjdJ9qOl4ZzTQiliaFKEJMfw+inml3QRqdWRUimbNLzmJqdzXGf+oUl9pyrDcISi/lbNSPkEW+hRVlhqhjo2GLyt+05qbfy84uI0qKk3CRb6ZCoYOre3bybunXJmR7fBRw2P8melM8WgKjFdZEdhnNw9Y3vM=
Received: from DM4PR12MB6328.namprd12.prod.outlook.com (2603:10b6:8:a0::16) by
 DM4PR12MB7768.namprd12.prod.outlook.com (2603:10b6:8:102::21) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9870.27; Wed, 6 May 2026 09:45:48 +0000
Received: from DM4PR12MB6328.namprd12.prod.outlook.com
 ([fe80::e205:4b83:4880:5e22]) by DM4PR12MB6328.namprd12.prod.outlook.com
 ([fe80::e205:4b83:4880:5e22%5]) with mapi id 15.20.9870.023; Wed, 6 May 2026
 09:45:48 +0000
From: "Ostrowski, Rafal" <Rafal.Ostrowski@amd.com>
To: Ard Biesheuvel <ardb@kernel.org>, ChuanYu Tseng <ChuanYu.Tseng@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
CC: "Wentland, Harry" <Harry.Wentland@amd.com>, "Li, Sun peng (Leo)"
 <Sunpeng.Li@amd.com>, "Pillai, Aurabindo" <Aurabindo.Pillai@amd.com>, "Li,
 Roman" <Roman.Li@amd.com>, "Lin, Wayne" <Wayne.Lin@amd.com>, "Chung,
 ChiaHsuan (Tom)" <ChiaHsuan.Chung@amd.com>, "Zuo, Jerry" <Jerry.Zuo@amd.com>, 
 "Wheeler, Daniel" <Daniel.Wheeler@amd.com>, "Wu, Ray" <Ray.Wu@amd.com>,
 "LIPSKI, IVAN" <IVAN.LIPSKI@amd.com>, "Hung, Alex" <Alex.Hung@amd.com>,
 "Varone, Dillon" <Dillon.Varone@amd.com>
Subject: Re: [PATCH v2 23/30] drm/amd/display: Move FPU Guards From DML To DC
 - Part 1
Thread-Topic: [PATCH v2 23/30] drm/amd/display: Move FPU Guards From DML To DC
 - Part 1
Thread-Index: AQHcvMzzPG8/1S4AF0ScAgEZI7BA7LX+uHMAgAJH9Xc=
Date: Wed, 6 May 2026 09:45:48 +0000
Message-ID: <DM4PR12MB632884CFB2718FF565461C43F83F2@DM4PR12MB6328.namprd12.prod.outlook.com>
References: <20260326030153.406612-1-ChuanYu.Tseng@amd.com>
 <20260326030153.406612-24-ChuanYu.Tseng@amd.com>
 <2c3edb6b-fb1c-4b5c-90d4-48d2aba7c986@app.fastmail.com>
In-Reply-To: <2c3edb6b-fb1c-4b5c-90d4-48d2aba7c986@app.fastmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Enabled=True;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SetDate=2026-05-06T09:45:48.121Z;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Name=AMD
 General; MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_ContentBits=1;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Method=Standard; 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM4PR12MB6328:EE_|DM4PR12MB7768:EE_
x-ms-office365-filtering-correlation-id: 07f4ed49-cd4b-4f7c-1088-08deab5440bc
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|376014|1800799024|22082099003|18002099003|38070700021|56012099003;
x-microsoft-antispam-message-info: yfNDk3ORUht6ZccSn/9rfEpOF7EhU63CQpNxTqotm+9hoZTlXldWJKvmQP+VdYyxhMKTfKbFiVlDHmNeFVY80SbfPJX8o2N5AcHLmGsvPJyCI+XIV4Enn9Mmo/Xo8H4u6te/5sXhZqOkm4Ra+PUvPNOiO4mRV5Cyv2hJsD8//m59tmLhu4LG0A/kzp9h7w+9egb4N2rZogYW29kFpSojGj3rO3VKQVtv+5EEaqQaEZYre4WGal5sfHOyEPJOipbOUIwdcpucQK3i6xivJOdfjyaFEwNb5B23hHYwTbRDO66h7T+l2LALdGpDaxSTnAyBxCvIAhssoOjVhtFGoh/tyC17jATzvZDzRuK184YlIZYMpwKznfZEmR7ueoYV3C+N+vEdrlM2haXP2IY8hSxGSJAEGV87Z/eQ+qsnwgenhKSkjHdXiBeRa2G+XqfhEBJKtX1a+fOZFDhx2rRgBtdefpisjo31jUSjU67izrs2xpwyD3yj+7K84hZ6WOgYzi4w83tjnsHPOGSvpyfQxktN7X4biY00yS9ba7yr4plrYjrZBSp6PSRoP5xJiCmU0JTrF1Xb3khOKU5Ot2WlLsHYcPmVzLmYAYMuOJrBF/dvSFztnWzY/Nn3Awi7AN/kY0yO/tanwezIbGiUMthepuQIfxJapOrsuLtP/SLeTM938vGWdDlBtjO5EKhh4Z7qHW4UIt4CBVmClrzVGroVQ2u8MxgVNiWTdJNr7G/4CXqT7YdoV6iNHbh5Qu00FBISPN0f
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB6328.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(22082099003)(18002099003)(38070700021)(56012099003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?AeS5Ojkzpc/ugouxVtImI+rhReobI5z3r0T1AqCM98GDDPnGc17JSASSk5?=
 =?iso-8859-1?Q?WRW00IYKltLMHbVBgrnNtwpBeeLK/tfoBWeklOGtSM/Q9s6dswz7metTMM?=
 =?iso-8859-1?Q?nWXfofbHonxfZSd06PlRoK5oIsEwg3iwQyi2Q+vkvO88EVfOiOUNU/aZyc?=
 =?iso-8859-1?Q?PBIGJvWM/Mu4L1BAdwetMjHM5tFB7fshmsv4YjGZ9AVLkzD6J1KTafhZ7T?=
 =?iso-8859-1?Q?/1UQXGT72BJbcQ8eZ0rOTBBKwm4s93E831OmoPBvAlVK0/beW/ElGuKE3q?=
 =?iso-8859-1?Q?ndP1Uib5w8qN/lwB48/n67WFb2p0SxpLR5wNkt6WZB2tCCMaEegKVFfUv5?=
 =?iso-8859-1?Q?lKhypXyWXaJBOkqv7qFTX91gD7XuOVdN/FIYJqEuYhw7ylXVEeDydg1J8b?=
 =?iso-8859-1?Q?CHGKsb6Sw7B05EjUMduPzUiC9kRhDSKco+qpMnioXfiAK71uAreMKFfTRz?=
 =?iso-8859-1?Q?HouPIF5hGDD2+iwPyw1nzDJ2R1OHiS9qkDKmahD8YaMonD1CsfzFzCRd9L?=
 =?iso-8859-1?Q?wAsuS8sMvm3d2KTM89AJ8eB3h6X58ZgRBJ0udiMA3Qlnu7UyRVU7rk55Er?=
 =?iso-8859-1?Q?Qf02levc/IFTFJJ5LX8MZR41Cehv5Peno3iEiJy/0a+MjBUqpIwtyL0EJp?=
 =?iso-8859-1?Q?ZbSJkcOowCV0c7z+/81WhlhOFikavwBx+d0/8y6TvfVPcufyeWrUqiz+PM?=
 =?iso-8859-1?Q?YrVJ6HfF859s8DBmnUUi2ZPEXqPthNfYYFH8jbZENQj6F9OfSGzMs2f2bW?=
 =?iso-8859-1?Q?seSp8WbhI3QmenHsry8+eyIas6h0JoU62D/c2Peac/vVzz381iXLIBJ4wO?=
 =?iso-8859-1?Q?1icXR/LX8Ofs7pQk5cbDxplvnQGMJYewcT7m7fv9xyeXU7K6Hj3LYE7SET?=
 =?iso-8859-1?Q?0qdJnsyGQwxiT+wjJBypPhs7qwzowmBBrZuBT5cNdDcw9oeQjA6KPSRoGF?=
 =?iso-8859-1?Q?Vj6zcYHEkWACQomWUBC3i1wFZ2AZ4++Dqc04LfP5ThQJCTEBzeOMk49fl+?=
 =?iso-8859-1?Q?voI/fk4GMRCYwVPpChPOQUmSZMT7ToQobcmNK46Ddgzd/uVt/Yv8tXPbJQ?=
 =?iso-8859-1?Q?12UwVy4uIGVAU/JNhzaa1gBqiEyinAJTvY3qV7FAVk9ozqxKb2pgDbebOo?=
 =?iso-8859-1?Q?Vmp7O/gBY7n6OBep8HPGjBsft1xMJmJ+GsMIjvelelLymiT9OfQkgmJcg+?=
 =?iso-8859-1?Q?D9vLY9d80wVkHm9+17qd1LICgpE2m8mzH2F1JFaBRotkR0A9xXHjF2T+Tw?=
 =?iso-8859-1?Q?eIMSiQ6mKovoCPNPSInhI8uBcvNYLPMss69eGAab7X/0UqaSycIpqOvCzk?=
 =?iso-8859-1?Q?4izN8qPnVoyUVqdvSfs0i5omEepaq21/+BmMzojXULY1Ar3Dhhqr5J5J2N?=
 =?iso-8859-1?Q?WkKuI9JCYAy7wuJiAI83/UaeMp6+eN1HfUkLLnCvNp+cBT6lrVRInLqVdg?=
 =?iso-8859-1?Q?P/8Ya4GvgcjDepQyhvlzZ6BVDz6XWh3ZFix5ywpHy/r8ZBnpOcju6s/fcj?=
 =?iso-8859-1?Q?h66okA5o/uVKd46+7l2Z/UEsyBXi4nOmeKdjHQlDQCx+4Oc6FO+nAgYVKs?=
 =?iso-8859-1?Q?Dxzg8TkObW5v2WeE+lBES2JYqHf1EGMsZlmcVVF+qspmgkzQsrBgw2UvXH?=
 =?iso-8859-1?Q?VjeRck2Exv9mNa3gXkoU/PBj/6D/qPeNQh+bdKHHPKeA7fXZiwDjPwU4Jh?=
 =?iso-8859-1?Q?0BUMsndtPRfrjfkfpJASPaRzzeaYZwuCEOBG5gMVjnNnaiL9DNlFR2pgj6?=
 =?iso-8859-1?Q?R06EYUn5Ln2PsRKio1AogaTOj0bShuc37C+A2FDHowzhDp?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB6328.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 07f4ed49-cd4b-4f7c-1088-08deab5440bc
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 May 2026 09:45:48.4448 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ppFabBDQlD5SIMHQhV3TRaOzdXzkgh1AD9b7TPEMzjlT/fcdyQjqZ82TRlJ3QmzE5F+1AFvcY9k3jtlAz9ubnw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB7768
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

On Tue, 05 May 2026, at 12:55, Ard Biesheuvel<ardb@kernel.org> wrote:=0A=
> This looks wrong to me. If _LINUX_FPU_COMPILATION_UNIT is #define'd,=0A=
> it means the code runs within a DC_FP_START/END pair, and so doing=0A=
> nothing will not re-enable preemption.=0A=
> =0A=
> I think this #define should probably just be dropped. If that breaks=0A=
> the build, it means the code is already fundamentally broken and=0A=
> needs fixing.=0A=
=0A=
Hi Ard,=0A=
=0A=
I appreciate your feedback. Yes, you are right, it is not needed.=0A=
I decided to replace it with:=0A=
#define DC_RUN_WITH_PREEMPTION_ENABLED(code)	BUILD_BUG()=0A=
I compiled it on various supported platforms without issues.=0A=
Is that ok to you? If yes, I will work on patch.=0A=
=0A=
Kind Regards,=0A=
Rafal Ostrowski=
