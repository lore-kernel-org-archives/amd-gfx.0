Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1ACC6E77180
	for <amd-gfx@archiver.kernel.org>; Fri, 13 Dec 2024 01:15:08 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A690310E637;
	Fri, 13 Dec 2024 01:15:08 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="DmkGSyKr";
	dkim-atps=neutral
Received: from NAM02-DM3-obe.outbound.protection.outlook.com
 (mail-dm3nam02on2077.outbound.protection.outlook.com [40.107.95.77])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 18EF810E637
 for <amd-gfx@lists.freedesktop.org>; Fri, 13 Dec 2024 01:15:08 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fw+lqhqKsxaEf0zYCGw9ayhOwvreAeNZM/moHPHdo9KBF6ZhkF0Uc+ST6XBwABGVUrONoCOZXRMAgWFL3Dy+0sLG8G6qbMfMj0H01LpIC0qBxvGlwsn2eQvgnRb1ChGJFNQ0GxbKey0Qt47XiEXiiLWhnqhfTJ+x8Q2LDRfdeGkxjeIhnCLdGDkM4J8vkQSyRtQOFEHPTIcTI058KYOmPrbuAmt0BI3tiUHKCtsmF+IbiPeY3eEYxwJX8RnmRvm8lAglRbX3+nlU0gDysHHSljekDErm6i3QUMC82JR0AOReukAthQqah7Rb2953LIOrtfute/I5A2Uix2iATAp79g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ewx0XDoGGzxsOPBGXNpvEFWG/COQ/LcGkVzPJPF4MNk=;
 b=pFN0vPaEj6zZ86LxJQQ0VGqRCuNhh81DBLnetIG1PEkFUELTwiO1ESRyH9yMnwio7hBCfogKkQ5YTdxnYhtL4fRNmuOQtzKwiVD6PFi07FxXSPaRstetMAu5R4jt/QKJhJ88NEKFpcpj1kj6Ax6Z8Ghr3+TKJLK7gQlOFzkpeEKourk6YhT1qmAOq+To2ICBLkHUneg8Hw8QNpB0NAdlK2yIsDlfMdbdK1Q4kUYRWBjaoqd7wEHvAxGJl0H2GYwSfVrvmmpcZfGlSNGBWiDKvIRw/4Lp8xvXIScwnGemlaKLqDirFYZl68J99GCynj+iOTKcYfS/SgJDRJEFtnSdFA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ewx0XDoGGzxsOPBGXNpvEFWG/COQ/LcGkVzPJPF4MNk=;
 b=DmkGSyKrF2Td+Bjko+Iw0nvu1DVrsghiwCWHn8N5INUPvLhUSyTpJzKg9S5MkZOKRzUjIjRsLRx1bdiMnzq1LT73IaIz4fTGeRXStdTs3ebHUdQivbPlH9uS+4oxnEk2JrTe9YWCcUIvPgwnzirXiBhR1FuOAGhiRN3CPbNxjuU=
Received: from PH7PR12MB5997.namprd12.prod.outlook.com (2603:10b6:510:1d9::21)
 by PH0PR12MB7885.namprd12.prod.outlook.com (2603:10b6:510:28f::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8251.16; Fri, 13 Dec
 2024 01:15:05 +0000
Received: from PH7PR12MB5997.namprd12.prod.outlook.com
 ([fe80::c5da:9b53:9d77:c708]) by PH7PR12MB5997.namprd12.prod.outlook.com
 ([fe80::c5da:9b53:9d77:c708%4]) with mapi id 15.20.8251.015; Fri, 13 Dec 2024
 01:15:04 +0000
From: "Wang, Yang(Kevin)" <KevinYang.Wang@amd.com>
To: "Deucher, Alexander" <Alexander.Deucher@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
CC: "Deucher, Alexander" <Alexander.Deucher@amd.com>
Subject: Recall: [PATCH 1/2] drm/amdgpu/nbio7.7: fix IP version check
Thread-Topic: [PATCH 1/2] drm/amdgpu/nbio7.7: fix IP version check
Thread-Index: AQHbTPxwcWukJvj3t0OzWQ4wWoHoQw==
X-CallingTelephoneNumber: IPM.Note
X-VoiceMessageDuration: 1
X-FaxNumberOfPages: 0
Date: Fri, 13 Dec 2024 01:15:04 +0000
Message-ID: <PH7PR12MB5997D50F138AF5C392BC046182382@PH7PR12MB5997.namprd12.prod.outlook.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR12MB5997:EE_|PH0PR12MB7885:EE_
x-ms-office365-filtering-correlation-id: 107ea721-a1e1-4684-a293-08dd1b13937d
x-ms-exchange-recallreportgenerated: true
x-ms-exchange-recallreportcfmgenerated: true
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|1800799024|376014|366016|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?cD2teGrfxaxtWf+QRnOD7n2ERtPZH7O9/DZJ9YlKpCcXMtnc0k2Obzeh0g9l?=
 =?us-ascii?Q?arrXdQ9q5ef6QeeNMI7LewqHYBMVENj8ZTj8pfSBYS9fdFk6s61MdQBGyXWp?=
 =?us-ascii?Q?/QGepHLkCOT39XpQZtra19zK7CN4YO+M0U6bwkAt6HZ1X/tjw1bJ+p6/NA1A?=
 =?us-ascii?Q?rJLW9gCbW3E6wQqWpnzX17gUoJthzVDeI5npP5tPmHmqZnxoiWODtTfcaKIR?=
 =?us-ascii?Q?41HmUfrquJaSyTk0cJOxpWIuO+yYI3DhRY3eC8H+dzXNaefVaOp/HpkQKGp4?=
 =?us-ascii?Q?53Xh2LGJAD/m2V2AWa74XdSznqwYvf5cmWfBrTEfRmMTHK06UkrN0Ot2S2zu?=
 =?us-ascii?Q?ieVMzaGmmkNMem9rVCrQxdwzikR3NpwaQNdTeld2BPBKG8MyM3pz4Su2KrjH?=
 =?us-ascii?Q?LUJjHtEKNd7tsRtPTpZIasiskrGB/q7eJEXsGGbATyKwVWo01amH8/iLhqzs?=
 =?us-ascii?Q?2KOYysWqU8nS6egkvf7gtLwTYLuSnI91VNQDgCdtuBz12a1FRG9NXGfmFsET?=
 =?us-ascii?Q?CSKGkeO619BCPRFgnSATT9XRbK5UtYhnOEPDWRJNSvK2MEbG9fVD4W2vyDDC?=
 =?us-ascii?Q?th8Pf7ZAIB2j25LE0Cco+aNK5MKVg6SRw37hSeSYFDuOU9wbBDJQCzZvL9/I?=
 =?us-ascii?Q?xikULrcdOYb/XySx93hZj1n4GjqLTp3syFRbnFFCcysaui3w5j2mO16fM9Ib?=
 =?us-ascii?Q?t3+O9opLmShKAcpM1TjOdXXNwAU5uPl01vKCxi2036OJ9syXKlaHp8ZKhAhM?=
 =?us-ascii?Q?ofdCKXaC4wQcJ3G3szWhSpNx7brVpPQoUkrWcLojZ6kSlm0bGqEJcNzLK4JT?=
 =?us-ascii?Q?VOHr43EQH3hQTbYgNtkycljs82ibZZ6HYwSMoxN50KW+zP9iu8hap4RXRaK/?=
 =?us-ascii?Q?6mUJ8Xutq9+r0uYD9HP7ME6HqqWeT5mV8otqRi4ReZRlmkynPyDm96PSAm7G?=
 =?us-ascii?Q?uJYkaGdswKPanXphZxOyJh42JEyzEb0GdKYcFCzRLiD77AXFthlTGV79u8zX?=
 =?us-ascii?Q?Ptl6j0Dj5dJVgedz7nOCrr8LBeOJLMBGZjm+UGD4C4LtLxv7JVl1S7gRjIky?=
 =?us-ascii?Q?IWj9I+pbMy5mzRh536abCQQPQ5Ca+MqDHjZYFesnDJAUUjl9n1C7GDiUl7Vw?=
 =?us-ascii?Q?fLyLmflzeL9vXrbRoSKNOKpnN5LOEyg9dpv5IPYZjQaiafjxJNhGkmdW92Bq?=
 =?us-ascii?Q?ih/JHRILypQJcZYMy0WmiGhElWsVpyEoVFezwFsgYI/eGVnlZW+aNAXVk4H0?=
 =?us-ascii?Q?gtKJJbxXGcMb3vm4FgjvVl3bOc3HwCyVbVfpKgaKJQMUi64hRQ84ogTFzOFR?=
 =?us-ascii?Q?mCM9n9vqy35Yk7lEH5zoKRM8Cq3uHTc2mFsLjcS3CJ1SwX6ctW2lSLUWi+3+?=
 =?us-ascii?Q?qAaca23+qgTYTOrhwlBSAauMPrVCYalgrOmAmOk416jKtvMNsw=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5997.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(38070700018); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?cxzhH3ilW8bB3z2w9T/ossixS94T7enVwu/FKoXVXSQ0IXLwjhCeq4UWCf4Y?=
 =?us-ascii?Q?UO8eSWQjdgwfm3EAYPpCHAz8a81+pYffl5Xvx160UMCe2YnPlBWunRKcN/J5?=
 =?us-ascii?Q?+X99PiyNNYu0Ysk0jYnBgbj2kY4HdAbMvB1TUItfzJ2qYAJIj4yTO8f8AWUq?=
 =?us-ascii?Q?m2/24KqGwa01AEXEKvgvBIurHJhbjCkqjXNxZXKaq/urCqvffarjHe5nU+tj?=
 =?us-ascii?Q?+wAdYj0NHTugiMnKxSmem+QWl1nqSg+2xsSECJTaFbrWzQ9ZdjSwMSV1IE6w?=
 =?us-ascii?Q?f/gh9gdbqPkbwEHu12gAL+tMthJ8WKK8fa37aOQwy026BqYjkkcLzgvQuKno?=
 =?us-ascii?Q?O7aKMQTj17jVWmTBCy/RbGdNizCAQyYsjMTme0IW8TsH/hz+FAXtsiW2pKjA?=
 =?us-ascii?Q?cIn8//Zq4grZNzmGn2vwIjtmQ/LbBuBD+7Mn4rM//cp7Ne7Na+bA8EXfgZhq?=
 =?us-ascii?Q?VGNA1ccrJtVE6pM1L2cDahDGSstBMFtgoICH0dZp6iTvBCzZo2uchOasgq98?=
 =?us-ascii?Q?yKVHjBdd4l+Qlfg39JernO/ysEZfUOEgAPAFMjf+jktX+MJCzPA+ZNbNWLqs?=
 =?us-ascii?Q?VBM5zJ0Ce4yOsMW4wnKU5fuPy9mmzEbwboxGIE1X//Ak8v8c+jZDFGnREw3q?=
 =?us-ascii?Q?zfvgy1M5wjyxeB4hM6RVqwUSDgxZwdn/vncdbKhx2fjM9FmnbIrDdU9NiE1F?=
 =?us-ascii?Q?oKHFhnL6T1dWKO99L2RpsdHRUkT8JCTFBBELri2Sa7tUmEfDQRD82+ZrVzdy?=
 =?us-ascii?Q?w+kIurp+X7MSJQJWDTgAWDP/W5yHHzYYg6VWJmivz26RZZDtzb00ehiTzx5u?=
 =?us-ascii?Q?Gd7AvdB07H6rB3v7SGTtnEpKDXK6xn/D3QVu2KUX/E3AQjaGAoh/YrhU8D15?=
 =?us-ascii?Q?hsH5nTk5YfQOfyNWGyBtf03mVF2pa8S0bGlTjQbIxO57FugvRpOyU/1ZMcWq?=
 =?us-ascii?Q?VkPDxNxQMoOmqjglm1PO2i/2KrAy6M3Bn1S0mg4+84855rZetLbIwWFNQP7P?=
 =?us-ascii?Q?xWXzANIljEuFCH2wS4y6IAIrZP1xdMm/pM4J23r/GjJy3xoUDX5Pw8+lPxri?=
 =?us-ascii?Q?5rdqe8D9HpUrQM2xWXZuL+mQ22UKilJ47PEcxs5QIs9a54d532o+0jrf9ybI?=
 =?us-ascii?Q?0Xb4yGQjkqGKL7pjlPmx6pJxNTzrF7ZFiXFG3OHKUbdgIEQzVdIYaL6IXy/r?=
 =?us-ascii?Q?cyvIvYYN0spM+920VJkp6a5Pa41VLZfp1j2ph9zeL9TGbzFP9kwJwBVBwJAv?=
 =?us-ascii?Q?fiYKFS+gB/4tGutD2+/56xLcmhs8lI0po6qVez9XsLsAKA4z9nveGgFKlFne?=
 =?us-ascii?Q?UgZsEoeHf+KgjsrUOZDOtJHwZbsuhGvAhi1dDj7f8w7PYcedET8pgrPnDmUK?=
 =?us-ascii?Q?TRy6djOXWm+OZJdEZIkJKGEitqpUw4vQ8fY+FrKYOVVQK34VGe/U3FfPwiw6?=
 =?us-ascii?Q?Tz86d2u8L6SAnFPXdpQUGEckqbVT/XgTziHjWWQ2sglnI6lY03zX0khgsc/o?=
 =?us-ascii?Q?8dW++Mu3X3q2vIXqUuqFKkYBd5CCp8p4EaZ/3VPnpV3/vtgF7HsfC0JTni93?=
 =?us-ascii?Q?zx5MiOs6L7fXh4C0lVE=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5997.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 107ea721-a1e1-4684-a293-08dd1b13937d
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Dec 2024 01:15:04.9206 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 4KdsrYH1W7gHRif85QDeiXo4m8dHDcdB0xDZJcsNQYimvmGzEOl6Qtf6VWJJUGmc
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB7885
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

Wang, Yang(Kevin) would like to recall the message, "[PATCH 1/2] drm/amdgpu=
/nbio7.7: fix IP version check".=
