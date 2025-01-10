Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7C880E7719A
	for <amd-gfx@archiver.kernel.org>; Fri, 10 Jan 2025 02:07:18 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1124810EF5A;
	Fri, 10 Jan 2025 02:07:18 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="lIn8z0dV";
	dkim-atps=neutral
Received: from NAM02-DM3-obe.outbound.protection.outlook.com
 (mail-dm3nam02on2077.outbound.protection.outlook.com [40.107.95.77])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BACD010E4BB
 for <amd-gfx@lists.freedesktop.org>; Fri, 10 Jan 2025 02:07:16 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wIwElvDwQHg4LLGAsEPmiv+j5r3GIks0nKb5S6VY8buE323LnyF6wD3SDhGlT4s6BNLhfgmqdH5C4NswM4jfP9Y3StFz2X7u1FUyU0hWwiNF2kKRvbyRN/m2EdvQuxqoBJXiljCDtLsKAAWu9QFLhUhvp+rIfegMKJCHJhsmNUBznJcmwRQGK6Mf9yVKbY3as+HiVJI+ZQ2DyIW9j7xIcCw3ddZGUWUgnGPkLNRZuAV1ahikl75OQhHxD8IuU5Q5QqecWDN8DfYzoEvBeTW2hU660wLXETUPxTSYOWO0UcN1Z5X7Nmq0xNxSlfGHYSo/XH1ER3RYRH9HUDVcCgv5tg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0xXiZ1au7jV5tw83gKjxRBFwLoACZq3JJhNREDlPbT4=;
 b=Aw+9/KV/xWxN2uvirlz0EXWOMkzKDh4Ia6G9Schn3c0Qh5Jm4nbxBBU8iUu+7WIVojduRzbsz3ExU9LTdtfynrtYSfx+tYD+wrb0oQ0z7B9dqkMupD6ejQLq9h95Zz09zk1svYoDC/CDjTo5YoNT1qA6bFMt71ce2Gu3C6XRVfJu/Gvc7P7RRnWwMmpkVNGdkWMd/BhaZ7MpQWdFk4P9DN8jIv0uL9asddIxsyjJKT3PimuQ4iSMSWHEeZJ5CBd0yPmM+IBwHCQc6YyXYV+L/rCB7dtPWfhTINUTohnW7xypKJNXzlVOgzj9p2ldsOOOHgUE+3V37t7/+ScrpiXAUA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0xXiZ1au7jV5tw83gKjxRBFwLoACZq3JJhNREDlPbT4=;
 b=lIn8z0dVSUsy5ADt1ATVdKDzdpz4ydgqb1uHpP4tvQ6Uvr4Er9E/jH+QpNVxcGCVjrTiL1L0WdKZWlQOBHix7N3CJUZWW7v81y97s94TwQ868cDab6zzeD3vJ2CDpW7xvp6fWctAxpDZSf7gL8H0nIO30bq0YuJc2IzHbnIFxCs=
Received: from PH7PR12MB5997.namprd12.prod.outlook.com (2603:10b6:510:1d9::21)
 by PH7PR12MB5733.namprd12.prod.outlook.com (2603:10b6:510:1e0::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8335.10; Fri, 10 Jan
 2025 02:07:13 +0000
Received: from PH7PR12MB5997.namprd12.prod.outlook.com
 ([fe80::c5da:9b53:9d77:c708]) by PH7PR12MB5997.namprd12.prod.outlook.com
 ([fe80::c5da:9b53:9d77:c708%4]) with mapi id 15.20.8335.011; Fri, 10 Jan 2025
 02:07:13 +0000
From: "Wang, Yang(Kevin)" <KevinYang.Wang@amd.com>
To: "Feng, Kenneth" <Kenneth.Feng@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
CC: "Feng, Kenneth" <Kenneth.Feng@amd.com>
Subject: Recall: [PATCH] drm/amdgpu: disable gfxoff with the compute workload
 on gfx12
Thread-Topic: [PATCH] drm/amdgpu: disable gfxoff with the compute workload on
 gfx12
Thread-Index: AQHbYwRd4/tkL+WJIE2Wt4cL5yqYnw==
X-CallingTelephoneNumber: IPM.Note
X-VoiceMessageDuration: 1
X-FaxNumberOfPages: 0
Date: Fri, 10 Jan 2025 02:07:13 +0000
Message-ID: <PH7PR12MB5997F4DC5B02DBE5DC5DB3D9821C2@PH7PR12MB5997.namprd12.prod.outlook.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-traffictypediagnostic: PH7PR12MB5997:EE_|PH7PR12MB5733:EE_LegacyOutlookRecall
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 08f34b4c-abdd-4d0d-46f5-08dd311b7fea
x-ms-exchange-recallreportgenerated: true
x-ms-exchange-recallreportcfmgenerated: true
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|366016|376014|1800799024|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?u9kqbZl9hHx0DfJCm03JUiBnhdJy3t4w8mKOYog9LtIt6A9NPE3TqT45v+nr?=
 =?us-ascii?Q?jmUySDxBwDZfabcNifhwD9Ugwz2/prkqTS0lkb54WckwXlY9WwlwBm7mP3Ey?=
 =?us-ascii?Q?XMezr1VOp8ehXiHmU2E+GSGFHbehgzgpA3J6PKYcOe+tah6ImhTEounBVPtc?=
 =?us-ascii?Q?eKfVqE1plYGaT3hDx7/EL+EneE0YxQSvmLEi7ajo+eANRhgcoq0xSghOqLRc?=
 =?us-ascii?Q?83Qeinwn6E5M5VBtfYp7g/Ef+3daukoQd/jFLopTm6dc+J+bBsXpZE0pea8l?=
 =?us-ascii?Q?gTcIqGbtsaKUvNYJzQJk8uLa69svEsNbRftVgE5LPRWZUML1zVY57HmNCHsp?=
 =?us-ascii?Q?BWvEq218S8HMo3P1gzAaHH08hbBmiPkf8acmu92AmpxOegv1Z9up2d0cILkn?=
 =?us-ascii?Q?Fxn0zxw5v/+RWuteH1utzCEPVaugWXClB0JD/BRPlqZDxEwqNUvl6PW5Z1M6?=
 =?us-ascii?Q?03vKhbahhTZbAtFwK0EaTAoWPLftb4bhcxx0lr76AWM422sXuZfk+ukKHQnh?=
 =?us-ascii?Q?hMa0OjhwQ54FM+QS4lOjizK7Y8oVKIP+DsSdWcl00IWMuBtrx6ExJ7qpai3W?=
 =?us-ascii?Q?gvoham/iBPBGwzRSpZDRzj9N8HhAAOzoNQQ8hsz+sZ9sxmSPd+jAz2dQtEL/?=
 =?us-ascii?Q?q5f7jtj8z82zhfOiJcTLltReN7wCxEj2A2PtAWzxi47FOsVJbO+tycrKW6dM?=
 =?us-ascii?Q?lLbD3NRbAV2i/4AJ/N+WwPkbu6y9kPzofuY3BZC3cv76xTSwuXkBfYC/nOZY?=
 =?us-ascii?Q?n6CS1uNRDpcALJasCrCRGPvwvVhC3vKrMjCjI+wO7BWDuNB/55kHXAvClVFT?=
 =?us-ascii?Q?HuFlt+wQCndrMRncIFVJT1veqPsH5U9DCG4NbGEtUKFoA+UwyyjLXovGnoIv?=
 =?us-ascii?Q?llvPNJ86vEiyrSpzXdcPtrsZVf6gIaMCjqa/jGONX5ypgfIL9A450wRSvElc?=
 =?us-ascii?Q?t476c3StKyIzOWBWEK+35k/TybrMpkboBmGlTzNjCECl81Ea58n8UPPto3gR?=
 =?us-ascii?Q?rXpLzeC5GyZUsD94R+cniMQJNQHP0mfYW2Rqgrac7tQ1HPHsQkYjQ+UQ0IYG?=
 =?us-ascii?Q?UKfvD+KrhZV7Khi/NFoO2AdyuUeiBjdPmRgPyEFTRVlfGeHLqTSWHkzR2PfP?=
 =?us-ascii?Q?Mj+sGSfBOTHbMt6O3PusJT3FbciRSzJdWxs/zQS2VzWMb/pcDeiLq4UH0aLM?=
 =?us-ascii?Q?m6fyaC724YySOXhG0Lr5Nzij9JGbeDHqwIAUHq+1L4k0Tx2nKOS66+JPfp8N?=
 =?us-ascii?Q?K+OyPbslw2Ad6MppTX2kCCharmjiwubUNWXmad80cE4qA1Z4MnRvkwfnijww?=
 =?us-ascii?Q?6UeOxyStX4uFFUyV8tWlSDG7UY0gZJZz4ocWbeeSjGQzGHLyLuCvio78Bkmc?=
 =?us-ascii?Q?yzSJ8ewVD+uWVexpx1/NY+BGX3MJ1SIFnN7O9DmTHY9mGo+EbWDOk3tXUBwt?=
 =?us-ascii?Q?bTpk4BOE6Mn7HZC8ad9eMImvSQUh2A2m?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5997.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(38070700018); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?wi2W7EDOlXHiCO50tHWZ4zaJHN+5n3ecWy6JJWjz1qmjfR88jpr4V4wG7sm6?=
 =?us-ascii?Q?U0WelkaMk7Eqhq/ARSxbmc45eoLcQMS4KFVKMaFs2gMtBM5V6CXIHgcllKwj?=
 =?us-ascii?Q?EI3XpD87Puxm6XnZTfnbeGaKfb0C7jALSn7Isy0dPjFIQucaF/b2SJLdDZQ+?=
 =?us-ascii?Q?ofQMk7LgMj6bKnHhIYepCnM5XvdD22cFdSActG0ZUDrDBpJFie0sIB2fW62D?=
 =?us-ascii?Q?7qOsGkLXZn3Ljf/aKuV/si+3zUpKmPxRcRFSAwGs917p5GUsO8oRDmSgnk4n?=
 =?us-ascii?Q?9qelYSn5VPZgCK7GThCJZInLbyqTo9PFAWQZdRV2r9vnMtQeRjp4OezExqzE?=
 =?us-ascii?Q?lfDKcaKdsFCkNn9g/694FTL1+Isyyu9w7COEUlGdy1H45pRi2h1TLXAvVOZr?=
 =?us-ascii?Q?4aYoRxuzrRuQ2qndv2fDbgHmx2BiD5TEhHZAgYvuMhMIXIMhfr9oQHD07acR?=
 =?us-ascii?Q?iR+zmyGAnRYFdmyG4HT0PeGy/wb7wYmFEq6Rpr04SkTYyxVsc3xZlIaTW4kV?=
 =?us-ascii?Q?hLLA/2JfLJ2rRPAve8/yJdqKHt1kl3MJas2rVMbayJa88ik2s16Zr4SQqT8T?=
 =?us-ascii?Q?/o3fBPko/v9hUKmVZYDZBxAIaOyx2SKO2bLJN/dnPQG1H8SuZJ4v2pZJanPW?=
 =?us-ascii?Q?7alDkeTDHVHaY0dTyPJe5TpAstUUFJqJ/HRbeTTKo+B9SOKS0HciULEona2q?=
 =?us-ascii?Q?T/0yDwJVdvKVMeK9rgrpl37S/BzjT5QvkUKvtBPQAM52pJZM2l7n9g1jxL3q?=
 =?us-ascii?Q?3pAj7+3hVOnge6n2CmXLJquF/jbR3DJFFxIl87bxz1wE4Spw6VDRtQQTIRPW?=
 =?us-ascii?Q?R+jq4T3tnwGvQsztrrEK57jhx3xj+k1dE7OY0SxdvQITqeGQM2mTqBrGtswV?=
 =?us-ascii?Q?JGrWbsTGL4+mK2C7Z7PGCroZkGqdXuCLYcRylYSIow6qmsJQ9PXKF707usJ9?=
 =?us-ascii?Q?QJjk0mXdcfrpmeEE7t4rOEMbuPlMHEuH7aE1TA0wXrA8vGCjjNXFnw1dIy8s?=
 =?us-ascii?Q?CBDV+qtryz6OBs2+4rFFAKqA3UV9l/9bnEM8TgHIJrSFPaZLbA3ZWJYIY4xE?=
 =?us-ascii?Q?Nbcti7tdvi1SDAlcVe4yR7oFPLs9DXMNaUiXYw+ERenoS6wuK3R+TDa4dNKX?=
 =?us-ascii?Q?ls3dP7QTT/tML8x2X8cThCQSA4CIZ222EHZUJkAfNJTufWursL/4CHoGlnlF?=
 =?us-ascii?Q?G1k1MFrKi1k8BBp0C9Dv2itUyZI/89Ek31jkJ39Ket2sp9HJjPgfjgvULatl?=
 =?us-ascii?Q?f6y3Xptz5PsV6vNrB8SO9DKJRFIQv9ANSinSEP23mrCduktvV6BdGOzbZ7/N?=
 =?us-ascii?Q?d02bUXRmt0fgjyXstDL1NzFNcMn4/W+nqvLnn1pa3aBs0Zs43ZYVIFBroQN6?=
 =?us-ascii?Q?uaDQGKY168qkxrAgvI0iQyl4kPvOfjvkIe1KkqX0y1eYG6klF7o5PX4UiKZr?=
 =?us-ascii?Q?PEjokJumtQbAc6rz8wvQ1Je4bMEIh9uDZzAuuXd+0IIpgQ/Td51vUW6ly6Kj?=
 =?us-ascii?Q?zhS1X79b0F0MQvCgSM5M7m7Cu4GqT54jZJEjUwSX4PglhbDDl+rf0C6ZNuc/?=
 =?us-ascii?Q?PliPnDALBonee+G2tpM=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5997.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 08f34b4c-abdd-4d0d-46f5-08dd311b7fea
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Jan 2025 02:07:13.6405 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: b5ZMc+QBELmuegR39t4Z+RnnvGBntVjdgl4QbeAnc9Svf+/67V3xw9pfM/K4x/ad
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB5733
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

Wang, Yang(Kevin) would like to recall the message, "[PATCH] drm/amdgpu: di=
sable gfxoff with the compute workload on gfx12".=
