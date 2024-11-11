Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1C936D12D5C
	for <amd-gfx@archiver.kernel.org>; Mon, 11 Nov 2024 00:45:53 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C2D8A10E0B4;
	Mon, 11 Nov 2024 00:45:52 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="SfNTNNDx";
	dkim-atps=neutral
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2089.outbound.protection.outlook.com [40.107.92.89])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4604C10E0B4
 for <amd-gfx@lists.freedesktop.org>; Mon, 11 Nov 2024 00:45:52 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hZ7H18rnkYn3aduD8gCyYcHBNaXltrTPHpVTMuYjYbwrXlJiAM9JPggTOgaOBu2EK/YRoa+SIMU1o2fUHXtVUFteziDDXRwFectAKmikhkfMgMBwt+AanjplD15SP4/HYF7cyTcRpM+NVoO/cAQ8o4Kn1GYWhISpP10d8Vj5qtoFt3wPAdFJvS8a72sfCaP3ZJxHRi1baSGLz1BAwXoRDxTjoNy8iTrpHMrpe/Y/IL7AqQjDF6JtHCfZ6mih0UBjhWgzbr3+OJtZbPQgEntDumsZ8HqfYgTSuCID5k1sK0D5NqJExB1+/neuCHU8THkVq4ar1T3GsHktlOrJHMG5OQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IAeZTmM9KvkCRZ7JAtsbx1ahQ6cgJovtVePkIRIqkgo=;
 b=ND4KqaT2ZKuI2zpUQ9bnMnvMBBww2FtHqr3imfqccYCVnoT/P+HQKIeFLphr0JtNB33fa2gp1VzK+NqhEdmS27+LXop/p4z9l5U9cRkv/UiL5i8toah5U8cAQnIu+YvHbWRewWqGSNABtxcaalho0NoUbyqTxYi81nziGOmX3QxNLz4YPenpy8bHyrmTw4GzHTcSsYr1GOQIOK0/czEBEpiPx1WWwQy6LLxYNqHwCAm1WGNsuQnV4TFgYo42sk+r8Z7RwhfAGEmTQ+gCynKu5eyFmkw0kDL3UAmZyPK5/RAy1jKYbS8E6rcN2Ys7NZInyrhCY3SELFXSxsNElXvn3Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IAeZTmM9KvkCRZ7JAtsbx1ahQ6cgJovtVePkIRIqkgo=;
 b=SfNTNNDxICjpT/3i9446qO1SYjP9K8H2Bg/LDYeotVsWN3HWSmekDNiOos8egssLrtaDIOoHLaJ/JPXBElw04FtAc7ATa/+bfECvhPRra9BtZDKxNKqz/rmaKcS8Lkowo/lnVsgrZCy4PtLvGwieE/bWkr2x591fvvSTXWowUkI=
Received: from BL1PR12MB5269.namprd12.prod.outlook.com (2603:10b6:208:30b::20)
 by IA1PR12MB6162.namprd12.prod.outlook.com (2603:10b6:208:3ea::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8137.26; Mon, 11 Nov
 2024 00:45:48 +0000
Received: from BL1PR12MB5269.namprd12.prod.outlook.com
 ([fe80::962e:1ce3:e83f:8482]) by BL1PR12MB5269.namprd12.prod.outlook.com
 ([fe80::962e:1ce3:e83f:8482%7]) with mapi id 15.20.8137.027; Mon, 11 Nov 2024
 00:45:47 +0000
From: "Liu, Monk" <Monk.Liu@amd.com>
To: "Lazar, Lijo" <Lijo.Lazar@amd.com>, "Koenig, Christian"
 <Christian.Koenig@amd.com>, Alex Deucher <alexdeucher@gmail.com>, "Zhao,
 Victor" <Victor.Zhao@amd.com>
CC: "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>, "Yang,
 Philip" <Philip.Yang@amd.com>, "Kuehling, Felix" <Felix.Kuehling@amd.com>
Subject: Recall: [PATCH 2/2] drm/amdkfd: use cache GTT buffer for PQ and wb
 pool
Thread-Topic: [PATCH 2/2] drm/amdkfd: use cache GTT buffer for PQ and wb pool
Thread-Index: AQHbM9MMvICw6C1V4k+WmN749zeAng==
X-CallingTelephoneNumber: IPM.Note
X-VoiceMessageDuration: 1
X-FaxNumberOfPages: 0
Date: Mon, 11 Nov 2024 00:45:47 +0000
Message-ID: <BL1PR12MB5269BD53D4BA4346EB772C3884582@BL1PR12MB5269.namprd12.prod.outlook.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL1PR12MB5269:EE_|IA1PR12MB6162:EE_
x-ms-office365-filtering-correlation-id: c07b1a8c-f11b-44d8-44a0-08dd01ea2ef6
x-ms-exchange-recallreportgenerated: true
x-ms-exchange-recallreportcfmgenerated: true
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|366016|376014|1800799024|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?Ig+qZcxhHe+uvUdRXzmzx9CPiqfbJ+UhPbRT15pdvjIrb0XcL4aV+3pbGZgD?=
 =?us-ascii?Q?MmfJJ6hXS3oLNPjzwn7+Ro4c5lGgfb9to/dlaToKfqNW8sHVV8o2uSO+0SK8?=
 =?us-ascii?Q?bqS2nYbpHF7x2XJMkYEzGSYdabLKY54qtcHem2YOxK+rgU+ZwmaMCXNhTgyW?=
 =?us-ascii?Q?8nDDM53Ye+m8IYfhz5sJmekVYRFQuwuuCTZjOV7PgR2zht4xxdzzsylU0WMZ?=
 =?us-ascii?Q?7mCa3ZtOQSckNms+y2LgvOBGjJd0Lo9djWgXc0Iz61bcfu2WsI9+wB3ooebY?=
 =?us-ascii?Q?8/jjFzN0HKUQPtWkiS1AHS1y96BgiXxUozceL3OgJvRI6Ekzlb7VYL/K+Kcd?=
 =?us-ascii?Q?m6+DajAAzhO0SchWwNA7U8TFtkgG2hEqqaFQbS0a7UNJiDIYHmZbmNpm2RCf?=
 =?us-ascii?Q?hGj0exRqNZFC/2sNN3sarYbyC332PybrT//de420TrHxiyOeSwVZnQ0tggea?=
 =?us-ascii?Q?XtcCLJIXF5spP2rIpT4jgaBuL+unmdjLHV13h9nVI9yBPs0ZOAs3J7WPXDtR?=
 =?us-ascii?Q?XOgGp6FLkrBZykR76W7bm/qihFyFOlb8R/kSaAEIt1+NYeHJYS0/1e4pzeuX?=
 =?us-ascii?Q?b8zzT9L70xhKHolAJSUeneHORz1WFXX2uzs1OTaSN2UcbrJF+EtmaK9uJ9OH?=
 =?us-ascii?Q?ew3M0DQvbOsw8WegwlohSMNi4OoefT3RmK4oq4fNDHRUYAzIQ6S5I0qs1iTO?=
 =?us-ascii?Q?CzL/mQ5s4CcJFkQsLvhy1HYRFP/q0hZ/yeJcUjYz3sKrYcZITEngci+1og4M?=
 =?us-ascii?Q?mfGf06Ue7BGybq6LofnmQnUHQM+ihYJ5b9XY3Nd1ZtYaAbFy2f/0Y8XbMGer?=
 =?us-ascii?Q?2AyuUjHiQT1z84YndPiEqf2rUqZ47mB61rK0+UsTTe8ffbu66v6xbQ1oV6lt?=
 =?us-ascii?Q?Mhye6+k7QPhJS6//Hz+GNzZ1/681EwqPtyUoeHzyySzt7il4K5w1FzeSM22A?=
 =?us-ascii?Q?TBSoYWSun2bDAafkegRrTLMaH+95wgI1dq8ZZhm7/CVQ/bdxtCeXom5Embv2?=
 =?us-ascii?Q?170aB14zxEzWB8ivUQIDK+Zf95JrGVGjDdrIQZasv4hWt2JZD8tTkMRqjS/D?=
 =?us-ascii?Q?+ldEURmqTjYO/e9F3W53o3j4O384sdrhJ+24MZxwFgwVHTSOKGU5VXzQXcsV?=
 =?us-ascii?Q?5DpxLP3Hk80D0lxeOekGBPr0QmuAI7bCJ25oNxyTXAiV10VmG21UQv0V2YxD?=
 =?us-ascii?Q?udFRSeONbpyXlzlwmFgPKnZI7PU+FOXJTFQTJnPK+kBFY4TblqJDFsH/2eh7?=
 =?us-ascii?Q?A7qAAJEWC3Xb0VwO8mteIOlybE7VitM7DIhfeeHWLTyfDuNK1VtoZ7b0SinG?=
 =?us-ascii?Q?G7CCZMkzlm/S1089aBg7eGTx/1w0uIi9Cl0MS1TR8mdXSvAnvuLtx0iYU3b1?=
 =?us-ascii?Q?UJ0V9hQ=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL1PR12MB5269.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(38070700018); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?rMZVd1OJAr9OsYR8U8VNe17y92z3t2l9RHulexU5R2BuXybATvmnVb9EOOtG?=
 =?us-ascii?Q?oSDSpY+P1IbA/0v+g/LIfv4dM70Bd3QF55IkLXpGM3Y0vZwFJadLPT9Pqhd+?=
 =?us-ascii?Q?POhilLF4zNXp+B4PyiXurQ8Akgb+zqIEAbys8UIiIvcEAIfhmhGJ22mBde/N?=
 =?us-ascii?Q?cGKSNKBh5JEZT0KXV0QBmdm6rbelD1oFdLmSR6JdZojgOrwTPWkHufQ3RRSh?=
 =?us-ascii?Q?Ztu+aRZqNzH2Pz0eotLP3clQ9hoArtE2cOgNLB98UdnYYAPaUGK47yJR88th?=
 =?us-ascii?Q?CPKTq20WZwPZRnOSTjjwstrTq9cj7Ym9sENS2LyAiCUzGt73IHxfCMp1m57B?=
 =?us-ascii?Q?pVCvUksQy1OWI7exO2SKUJ48ELzHishsepyB1jm68r/qel3jFybMFeoQJyRK?=
 =?us-ascii?Q?1ZeWG3zV6dUlfFWGzsPQ7TkY2WTKdyxtwKn+m9ZKXOARlqYLEPIiGyTUFcvC?=
 =?us-ascii?Q?ig1u3npNC4ozTqwx/9ms3me5jxqtGQNLM89iNdBwYLzxRQggr699DqrTwRgi?=
 =?us-ascii?Q?ppLVGAhbUkhRF4e9H1XkemmumX0GakVT9F5xYEblo/fKhpHlFMVucqLs8/p3?=
 =?us-ascii?Q?yWZyLT4CY0o4CHRBgv3PXTGyx4lYgVYX0O9F2mPu1m2FvUQQxdOGVhanD59e?=
 =?us-ascii?Q?pQFSzhGW8bSQN/7TUBxsz/vzc9t6Sez8+QiBCH9mAmS3U5QpU5oY8+Kp8Xij?=
 =?us-ascii?Q?UWZIxFWXCPA8odZaYsAS1VFlyjY3FyZ1+6wOOEmCR6aCn7PPH273EO5mE0Ie?=
 =?us-ascii?Q?1NXfw0sn8ctqyiH1yFfQsneBHpOtr9tuXcsDLtA6rPow9DHJXkORxWrp2v8t?=
 =?us-ascii?Q?8XxqFjRaobqxSFMHfx/1Epm5VkxHVkg1TXJ/OAlVHV1jWN4H0zMoUu773TT9?=
 =?us-ascii?Q?6g7iiZIwvSnZA6+KvY7apHouqAxAW91t++s9xHAq2TcvDvUHoJMvVlwBcyIC?=
 =?us-ascii?Q?Jjfkz8n5E0pFTJGcf+BuzsdJX2UCJ1ppzvv5R3BIYDN26qNETQ7tgNqWLCzP?=
 =?us-ascii?Q?IQB3T+Z7hY21eQl7YIa9noTzSUwpiCaLSJCsEbuFNjJlVZXpK/ca5BUb9SYD?=
 =?us-ascii?Q?EPbk4jykIV4AUbOJ/nI72JazNhmTv+JuUe965Bsr8G/thceZEgzQirEx2Dr3?=
 =?us-ascii?Q?PXZjv8uKnArbA69+TNngIOMOw5vZ9dS71ugN0ofgJHFNvh0dGFWVZcTvVwu9?=
 =?us-ascii?Q?C23Q+NEplO/A3PGmsp8sSX7K08P4NWVVSWfUHt8mze6sZgVYOtNy/3LrKkCx?=
 =?us-ascii?Q?p8HINsdK9r0c9wlFGosI/fBBMtChYv+X7m7dtLV8UC7/6rC6Sv38PIDRUt65?=
 =?us-ascii?Q?9ee5eYz1vrWIcqhbqImJjio5cng16noMNEz16JKQUfcmva8/gsma4MgUDa8D?=
 =?us-ascii?Q?qnRfBSaSQDasrGSCfNA0HfWjusFw1Dk8yVF1UO3nkX5dV0puTDybqTAwp4tO?=
 =?us-ascii?Q?XN/IiRZo8kmxaHWxMLqbVNqR9vuRY+x0YZrm87FETJ/4U2eqBEWNnfFypA6l?=
 =?us-ascii?Q?Ufnne1BGfs2Y9N8HnHpt2Pp5ArLTE1y8+co/UzeQSuW5fqPyBWGl8Hul2DcF?=
 =?us-ascii?Q?gNYn6SrOb9fIhR2nfhM=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5269.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c07b1a8c-f11b-44d8-44a0-08dd01ea2ef6
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Nov 2024 00:45:47.8045 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 9lBjIQ0SekHYKgC8VW4U6NP1zd5DHJd7PS7h0lY1iWlDyfb0PEBGAtuazqW0WmVU
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6162
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

Liu, Monk would like to recall the message, "[PATCH 2/2] drm/amdkfd: use ca=
che GTT buffer for PQ and wb pool".=
