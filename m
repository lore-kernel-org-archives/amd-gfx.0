Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8350FD3C928
	for <amd-gfx@archiver.kernel.org>; Wed, 10 Dec 2025 17:22:37 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 209AE10E785;
	Wed, 10 Dec 2025 17:22:37 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="ZhnAYIZW";
	dkim-atps=neutral
Received: from PH8PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11012036.outbound.protection.outlook.com [40.107.209.36])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2A25F10E785
 for <amd-gfx@lists.freedesktop.org>; Wed, 10 Dec 2025 17:22:36 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hYuquHxHFSvGkVl/xVPf7FxsybnvVdz9/TdgQRxj25eep5O3/D3/Dks6FgpNbr/GRlT9VcMUklct2cJPmJZ0Fb5LbOGtHo2z25goCO0elYPWE9NGWCh2kOp1LT+HHnZWVstJ6iEvo2irUs3KNufwflPyzMQifCtaGNPSPH+dPTcbL5ZnrsCUGUuB97I/y0y+aC+aobu0QJ2O53AblX9t0orkMRDgKx6mKsuv2SQQVRpig1NZ9F11thSfqzR4K/0bNPd3NAu6SciUWC+uKVh4db1KK8TLbY2Irw7dq/xuSRi5O6KGB7nnaFriJy3HoSdx9jdjyqlMln8tCZqzHWeYtA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=g5Yhnq1CrgWRNWDycK2/PKGzpBLrJkh/AlhvZex5VHY=;
 b=uAR6HK3F/qDBQc3CAOUL6ryffnt2ekXF/cq1XILFovD4/fpDgIG8uD2yHGO06CNPL98HSsu4Ouiub4+Yr3zN7iAhWtigVGk4zHUhMIRrQ9OcLnf92wWBNDJ+hE9W1jBIS20OdreEAaf5X+fJ+DRuYabd93ZAqCoSqnW4Yp4N/YuS6SrYF54POPTCqd4FNQn4OWMc21IARHPGpKOKA5aJMJ63ywo9xOjBol8oahEyrYTtAbVh11tsz4USmh7zFsALMnARS8NBgUgF2UKeVtEgooQQpbranVtnBgiYCgXNRz32aB6RriDZ+mJE+rh95H/Hvyq14WMVi/DZEXl0EtWpng==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=g5Yhnq1CrgWRNWDycK2/PKGzpBLrJkh/AlhvZex5VHY=;
 b=ZhnAYIZWPQBJODurJvhB66U5kNBvQWsC2QcSCln4VhchzWOsqm29DAejxHV2sUb8MZ9zJtNkYr6ieFqVczqWp6Za3Zsm/O2jXzazUnE5iZFIibZ7YnJ4gki8gz4wU4m23jafwyLOUn9dtg9um3RMKUBvjO3LJ1pHgQBCD26hubU=
Received: from CH0PR12MB5284.namprd12.prod.outlook.com (2603:10b6:610:d7::13)
 by PH7PR12MB5686.namprd12.prod.outlook.com (2603:10b6:510:13d::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9412.7; Wed, 10 Dec
 2025 17:22:31 +0000
Received: from CH0PR12MB5284.namprd12.prod.outlook.com
 ([fe80::c1d5:bb14:abc3:7fd1]) by CH0PR12MB5284.namprd12.prod.outlook.com
 ([fe80::c1d5:bb14:abc3:7fd1%4]) with mapi id 15.20.9388.012; Wed, 10 Dec 2025
 17:22:31 +0000
From: "Pillai, Aurabindo" <Aurabindo.Pillai@amd.com>
To: "SHANMUGAM, SRINIVASAN" <SRINIVASAN.SHANMUGAM@amd.com>, "Hung, Alex"
 <Alex.Hung@amd.com>
CC: "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>, "Chen,
 Robin" <robin.chen@amd.com>, "Chang, Jack" <jack.chang@amd.com>, "Huang,
 Leon" <Leon.Huang1@amd.com>, "Li, Roman" <Roman.Li@amd.com>, "Wentland,
 Harry" <Harry.Wentland@amd.com>, "Chung, ChiaHsuan (Tom)"
 <ChiaHsuan.Chung@amd.com>
Subject: Re: [PATCH] drm/amd/display: Fix 64-bit state pointer passed as
 32-bit GPINT response buffer
Thread-Topic: [PATCH] drm/amd/display: Fix 64-bit state pointer passed as
 32-bit GPINT response buffer
Thread-Index: AQHcaaG1IJZ1sVmQwUmscbA9f/Vm/rUbH5OP
Date: Wed, 10 Dec 2025 17:22:31 +0000
Message-ID: <CH0PR12MB52844E92F105DD3815F34C7E8BA0A@CH0PR12MB5284.namprd12.prod.outlook.com>
References: <20251210065319.540578-1-srinivasan.shanmugam@amd.com>
In-Reply-To: <20251210065319.540578-1-srinivasan.shanmugam@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=True;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2025-12-10T17:22:30.870Z;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution
 Only; MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=1;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard; 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH0PR12MB5284:EE_|PH7PR12MB5686:EE_
x-ms-office365-filtering-correlation-id: 08747504-64cc-420c-7b45-08de3810b379
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|1800799024|366016|38070700021|8096899003|7053199007; 
x-microsoft-antispam-message-info: =?us-ascii?Q?nzSy0blr04FBcz9DNFcB9n2Ymp1ZRLWtR/QL6zeJl6MHBDJ7IzzifOXTjdHt?=
 =?us-ascii?Q?tNGoviDkCl/BfjESic9CNeilkwc9m0xlmh1BVmRwW7+JnackFYYRnJIliu1z?=
 =?us-ascii?Q?G/wEPv9tq9GEylPJjePm3tzllCMVswACvj8tEiN0zL8M5xmwWcTXojJ8o7z2?=
 =?us-ascii?Q?ARVUjbNQXzrz9E1SCwOBb6w/XNsKdMhnrQQof3i6JDfSBZhEUFtHp0zwskl8?=
 =?us-ascii?Q?MglWfJfkfzB0EdBMmmMAjoprj70CYeN9XdJ38FI7d2OIK0l0SWFVT4X3s5y6?=
 =?us-ascii?Q?oCvDEs95uzLCmd8/Uyttjnqtt+tM/6AQD93wg2+NPkD8g55lyDtPP5Y+Kh3s?=
 =?us-ascii?Q?0Ik1N2+fZfqt048d6EjB6h9dG0Ge26Sx2viQ/kp/LodgHBoYeisSpRL3/PPR?=
 =?us-ascii?Q?JoNkWN8/L3oN0R0o/DP/btGJ0PZv7FCwMrnYJDYxUaivyk67ILbnrxgm8N5K?=
 =?us-ascii?Q?0mltBAnvBNtNxQw2OrfPVtSuSntYx/h1VkHN0QTQHrpFnjKzMpl1om2qJsg7?=
 =?us-ascii?Q?0GhoJMoCUsY+tscIc4Yeqd8IIgeqvm6RcixfqhC05MK3j2f6TeynvErSRnW5?=
 =?us-ascii?Q?qTj/fzz7PgrVvWp90BT0R4dcmGgqR4dXA3Qdj4iWNvUHUIz4s0lp7G2Z1pqE?=
 =?us-ascii?Q?Z8MmVkvQtUYmVDaLbLFJj1N/0KROkpAUS8GM9rkzZ4Mtcpg2vYH6gKZQonfT?=
 =?us-ascii?Q?vLT6nopxJAh/9UOta1s2uDJcu6g2lFVteIB4EwiztNn+p7BDMqMX/JRMbnxr?=
 =?us-ascii?Q?1OIyNvc0YlmHahrJXCOCot7ReX7KsTUPiE7OlCFvGxDVdTKFKKgedSo9aw21?=
 =?us-ascii?Q?X4qCGalLtkqZ0wEilLfgvsPbMjWrO3/RdQ4eW6lj3qSUNXFEUPoUwXTyBIpu?=
 =?us-ascii?Q?748nnKZ4thBGu2dk+nQg+sS6YLAzQsgRyMtcnP0hQtfG7/shHZTGDytyfaJq?=
 =?us-ascii?Q?pF7qAqewirQyfmpMdLVqK+DeuR5LvrsqZWFCIdz/rjltTqo8a4AoHGXFiiiI?=
 =?us-ascii?Q?1QU8xuKubmrsV0Jnjjh+bDYgqKot3UsgKB5VB6SDftumNvsW4FEPPgGmIsWG?=
 =?us-ascii?Q?UsaucAug8MvRfVoZ0emTrNPZ6sEcHpT+wswh8nr1bItJKj9xUM9XyuURTHHc?=
 =?us-ascii?Q?BPfdngpQu5uIsUFajIohTiKXraXGPMMzfWmGzgLTb+Re6izZKTuJU9FllRmB?=
 =?us-ascii?Q?OK/mCLua1/aiG4D/x1nC+Ef2TU1bFhK384rMkY/kBW1uK42nHp9FWsiXpcYQ?=
 =?us-ascii?Q?Y5oTqXBa+hVPs/M/vFx9KpMcgpYtFXnAe/o+dBwqjub8G0Klc5sx+fz7Y62F?=
 =?us-ascii?Q?Lty7uprawk5DMbw473aIAvtfVQRi65BTe8PH6iDHeGZvOf9j8PLimRhkYPgq?=
 =?us-ascii?Q?9ws8yi4sF9TbnQDlJ1lgsoADdLxcXuhdPC3FV7xbvbV+LWoiJnwaCIOjY1u8?=
 =?us-ascii?Q?YGk7kcox0OtrNBwVxpxmsJAThnPxJsZJvC2dMMUqsvCArCfcnTg6/RzrDlKv?=
 =?us-ascii?Q?8G00WVxO230TRXXEaVi5D7Ac2CzCEwE6Ka0d?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH0PR12MB5284.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(38070700021)(8096899003)(7053199007);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?luNHzPCFqEWoqOrp4ZWAV45aydTa0J38Sy1bbYxVBtnEkAEwS+7EmKsmP5so?=
 =?us-ascii?Q?RYdaynImhCX71McpszAtNT8ygdsQxGa9xv0bYxzRguK1ZOZoI+p3EfHC2gfn?=
 =?us-ascii?Q?huOSPue3uQ/q1wMFCB6VcrexUV1EemWCFLdmz2zP7w2wBj6FLSgxJQ2UBckt?=
 =?us-ascii?Q?4gis4EBZH9ScwfIo7H4L36YFEDWooZkWg2J9j4Ocsp3tDgsMPLlGhcNFRgVk?=
 =?us-ascii?Q?hTsJ4iIj2h3TxsN9gkqqRzu2IR0h0UGqPxIYHBHQzPF8Ss890O6/NMs80bLM?=
 =?us-ascii?Q?q5FYmJTBk/T9H9dxMB6B9eMmLeudaxrYYB4M0qoTUydnGTzp22Nx0foRwZev?=
 =?us-ascii?Q?nW1gC27BehlIbPEEg+oekdGKnbh/4KfGXY3etHWznrqdvCKm+4FR1gScv+pB?=
 =?us-ascii?Q?wg+rxInNJa11MZyQymB40+NYQiMgjPiBF++W0I/ssfdXyOXQzR4a7kpN7aVy?=
 =?us-ascii?Q?0DqXzH1LoGgS4RYcWMwCtIqAMBejExr0jSfKzZNecz30MIz9yr/5MC+qtbou?=
 =?us-ascii?Q?F5JW56tAUdtwuWRFPOsoKQcxfyClSqs0gwLcjVCKsOBlhTSSENK3d7Xv0EKf?=
 =?us-ascii?Q?LlxebI6RRIEK4HGMm/R5NFeTy/6qCTqvRnTdgXWggstl5q1m+vik+Z6n+fV6?=
 =?us-ascii?Q?h1ekQVbau6nV05eSiKpjJ1/HwE9vdV53iGSu6NCEHMjEU45DpA7o5LBgmtnH?=
 =?us-ascii?Q?cwy7Sc9mooxkyBtN1om3qsN9uiBmhglU+1k7+AQUbVhmbfVw5Wyuv4444oEt?=
 =?us-ascii?Q?ndesv2JZZkN0bPD9zfJiWNViSDo6XmZnQ6U9KHzpFzWLz2QisXajIGe999S+?=
 =?us-ascii?Q?5KeCV7AKa2VwMP1zwCCaYuWlF7BXa7g6jRJC/NhbvOrp0qwDBWEqqNskqL/e?=
 =?us-ascii?Q?oNzlsGjeTGAVEafLqQCQPaJIYAtBGwynXM05POhsJUTTQD9CBjcCZNif3SVF?=
 =?us-ascii?Q?/dU93WWb52mUUMouprHiUFQHu7GN2sJ7RQn6QbSbaFfhEGIV7j9R5VIUAgbC?=
 =?us-ascii?Q?pxUgebtBYvLsbuEO7PCtSeiePvpmaYdtAIh1d9S2z3f7/4Y8leVEDlmncOk6?=
 =?us-ascii?Q?24eno4LrsQfFsXoqVSqCLlrLMJjzw4mHPPVZDl7UGhKT3wJ0LflyORDOYF+b?=
 =?us-ascii?Q?Bz9wHrX6GABauiQKaN1/j/Z0WZYl/nqnj+2G8mERg0tPx6R6aGM6ZwN45yrZ?=
 =?us-ascii?Q?CZyJ4xDJ8ZaFWTALjdcpHhqF0ztCeNt25JMEfLm8xgE1s1s48wejO2819b2M?=
 =?us-ascii?Q?6d7eDQR5WVuawgrhEgO+r4RFQallTf6Iw90/pnZZHfvbSFXWVlr2BJsD60aH?=
 =?us-ascii?Q?GDAbYhmbIh3PL7t7/tSh9E+xvgjo3+/52uRWNm0VdSIAVgfVxGNXaJsLz2TS?=
 =?us-ascii?Q?7lZBIbUOriLZM5bTf9TF4U+CVTzIs53ImmPnJHP/AkdiGxIhJpFMrct1zqUK?=
 =?us-ascii?Q?dlzBFaEO2nue153a9L36jH+B4RBnTjenMEhhYxPX8zTlpPTaDnW76Gwq01q7?=
 =?us-ascii?Q?GAI7rWVvTal3Kn8vHrnDtjdLeQrhT8MwjNFXxXlEVDlq0ZzItodG24XVUM3+?=
 =?us-ascii?Q?a7+764IBeYJV0Ibn+V0=3D?=
Content-Type: multipart/alternative;
 boundary="_000_CH0PR12MB52844E92F105DD3815F34C7E8BA0ACH0PR12MB5284namp_"
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH0PR12MB5284.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 08747504-64cc-420c-7b45-08de3810b379
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Dec 2025 17:22:31.4876 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 8Q3Z7AWwnfoQczSc2Vge7LRO2qkeHmVZan2FLY1N9llT6lFclsldJW6tvPb9uAZIGZrqPdj7nNs7/hBpKBkYKw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB5686
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

--_000_CH0PR12MB52844E92F105DD3815F34C7E8BA0ACH0PR12MB5284namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

[AMD Official Use Only - AMD Internal Distribution Only]

Reviewed-by: Aurabindo Pillai <aurabindo.pillai@amd.com>

--

Regards,
Jay
________________________________
From: SHANMUGAM, SRINIVASAN <SRINIVASAN.SHANMUGAM@amd.com>
Sent: Wednesday, December 10, 2025 1:53 AM
To: Hung, Alex <Alex.Hung@amd.com>; Pillai, Aurabindo <Aurabindo.Pillai@amd=
.com>
Cc: amd-gfx@lists.freedesktop.org <amd-gfx@lists.freedesktop.org>; SHANMUGA=
M, SRINIVASAN <SRINIVASAN.SHANMUGAM@amd.com>; Chen, Robin <robin.chen@amd.c=
om>; Chang, Jack <jack.chang@amd.com>; Huang, Leon <Leon.Huang1@amd.com>; L=
i, Roman <Roman.Li@amd.com>; Wentland, Harry <Harry.Wentland@amd.com>; Chun=
g, ChiaHsuan (Tom) <ChiaHsuan.Chung@amd.com>
Subject: [PATCH] drm/amd/display: Fix 64-bit state pointer passed as 32-bit=
 GPINT response buffer

edp_pr_get_state() incorrectly casts a uint64_t * to uint32_t * when
calling dc_wake_and_execute_gpint(). The GPINT path writes only 32 bits,
leaving the upper 32 bits of the u64 output uninitialized. Replace the
cast with a u32 temporary and copy the result into the u64 pointer.

Fixes the below:
drivers/gpu/drm/amd/amdgpu/../display/dc/link/protocols/link_edp_panel_cont=
rol.c
    1448 bool edp_pr_get_state(const struct dc_link *link, uint64_t *state)
                                                           ^^^^^^^^^^^^^^^
    1449 {

    ...

    1457         do {
    1458                 // Send gpint command and wait for ack
--> 1459                 if (!dc_wake_and_execute_gpint(dc->ctx, DMUB_GPINT=
__GET_REPLAY_STATE, panel_inst,
    1460                                                (uint32_t *)state, =
DM_DMUB_WAIT_TYPE_WAIT_WITH_REPLY)) {
                                                        ^^^^^^^^^^^^^^^^^

The dc_wake_and_execute_gpint() function doesn't take a u64, it takes a
u32.  It tries to initialize the state to zero at the start but that's
not going to work because of the type mismatch.  It suggests that
callers are allowed to pass uninitialized data to edp_pr_get_state() but
at present there are no callers so this is only a bug in the code but
doesn't affect runtime.

    1461                         // Return invalid state when GPINT times o=
ut
    1462                         *state =3D PR_STATE_INVALID;
    1463                 }

Fixes: f2429468b582 ("drm/amd/display: Refactor panel replay set dmub cmd f=
low")
Reported by: Dan Carpenter <dan.carpenter@linaro.org>
Cc: Robin Chen <robin.chen@amd.com>
Cc: Jack Chang <jack.chang@amd.com>
Cc: Leon Huang <Leon.Huang1@amd.com>
Cc: Alex Hung <alex.hung@amd.com>
Cc: Aurabindo Pillai <aurabindo.pillai@amd.com>
Cc: Roman Li <roman.li@amd.com>
Cc: Harry Wentland <harry.wentland@amd.com>
Cc: Tom Chung <chiahsuan.chung@amd.com>
Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
---
 .../amd/display/dc/link/protocols/link_edp_panel_control.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/link/protocols/link_edp_panel_c=
ontrol.c b/drivers/gpu/drm/amd/display/dc/link/protocols/link_edp_panel_con=
trol.c
index 0b05ee9f6ea1..cf06b9b62e1d 100644
--- a/drivers/gpu/drm/amd/display/dc/link/protocols/link_edp_panel_control.=
c
+++ b/drivers/gpu/drm/amd/display/dc/link/protocols/link_edp_panel_control.=
c
@@ -1450,6 +1450,7 @@ bool edp_pr_get_state(const struct dc_link *link, uin=
t64_t *state)
         const struct dc  *dc =3D link->ctx->dc;
         unsigned int panel_inst =3D 0;
         uint32_t retry_count =3D 0;
+       uint32_t replay_state =3D 0;

         if (!dc_get_edp_link_panel_inst(dc, link, &panel_inst))
                 return false;
@@ -1457,10 +1458,12 @@ bool edp_pr_get_state(const struct dc_link *link, u=
int64_t *state)
         do {
                 // Send gpint command and wait for ack
                 if (!dc_wake_and_execute_gpint(dc->ctx, DMUB_GPINT__GET_RE=
PLAY_STATE, panel_inst,
-                                              (uint32_t *)state, DM_DMUB_W=
AIT_TYPE_WAIT_WITH_REPLY)) {
+                                              &replay_state, DM_DMUB_WAIT_=
TYPE_WAIT_WITH_REPLY)) {
                         // Return invalid state when GPINT times out
-                       *state =3D PR_STATE_INVALID;
+                       replay_state =3D PR_STATE_INVALID;
                 }
+               /* Copy 32-bit result into 64-bit output */
+               *state =3D replay_state;
         } while (++retry_count <=3D 1000 && *state =3D=3D PR_STATE_INVALID=
);

         // Assert if max retry hit
--
2.34.1


--_000_CH0PR12MB52844E92F105DD3815F34C7E8BA0ACH0PR12MB5284namp_
Content-Type: text/html; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<html>
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Dus-ascii"=
>
<style type=3D"text/css" style=3D"display:none;"> P {margin-top:0;margin-bo=
ttom:0;} </style>
</head>
<body dir=3D"ltr">
<div class=3D"elementToProof" style=3D"text-align: left; margin-left: 5pt; =
font-family: Calibri; font-size: 10pt; color: rgb(0, 0, 255);">
[AMD Official Use Only - AMD Internal Distribution Only]</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);" clas=
s=3D"elementToProof">
<br>
</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);" clas=
s=3D"elementToProof">
Reviewed-by: Aurabindo Pillai &lt;aurabindo.pillai@amd.com&gt;</div>
<div id=3D"Signature">
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);">
<br>
</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
--</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
<br>
</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
Regards,</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
Jay<br>
</div>
</div>
<div id=3D"appendonsend"></div>
<hr style=3D"display:inline-block;width:98%" tabindex=3D"-1">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" st=
yle=3D"font-size:11pt" color=3D"#000000"><b>From:</b> SHANMUGAM, SRINIVASAN=
 &lt;SRINIVASAN.SHANMUGAM@amd.com&gt;<br>
<b>Sent:</b> Wednesday, December 10, 2025 1:53 AM<br>
<b>To:</b> Hung, Alex &lt;Alex.Hung@amd.com&gt;; Pillai, Aurabindo &lt;Aura=
bindo.Pillai@amd.com&gt;<br>
<b>Cc:</b> amd-gfx@lists.freedesktop.org &lt;amd-gfx@lists.freedesktop.org&=
gt;; SHANMUGAM, SRINIVASAN &lt;SRINIVASAN.SHANMUGAM@amd.com&gt;; Chen, Robi=
n &lt;robin.chen@amd.com&gt;; Chang, Jack &lt;jack.chang@amd.com&gt;; Huang=
, Leon &lt;Leon.Huang1@amd.com&gt;; Li, Roman &lt;Roman.Li@amd.com&gt;;
 Wentland, Harry &lt;Harry.Wentland@amd.com&gt;; Chung, ChiaHsuan (Tom) &lt=
;ChiaHsuan.Chung@amd.com&gt;<br>
<b>Subject:</b> [PATCH] drm/amd/display: Fix 64-bit state pointer passed as=
 32-bit GPINT response buffer</font>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt;=
">
<div class=3D"PlainText">edp_pr_get_state() incorrectly casts a uint64_t * =
to uint32_t * when<br>
calling dc_wake_and_execute_gpint(). The GPINT path writes only 32 bits,<br=
>
leaving the upper 32 bits of the u64 output uninitialized. Replace the<br>
cast with a u32 temporary and copy the result into the u64 pointer.<br>
<br>
Fixes the below:<br>
drivers/gpu/drm/amd/amdgpu/../display/dc/link/protocols/link_edp_panel_cont=
rol.c<br>
&nbsp;&nbsp;&nbsp; 1448 bool edp_pr_get_state(const struct dc_link *link, u=
int64_t *state)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ^^^^^^^^^^^^^^^<br>
&nbsp;&nbsp;&nbsp; 1449 {<br>
<br>
&nbsp;&nbsp;&nbsp; ...<br>
<br>
&nbsp;&nbsp;&nbsp; 1457&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; do =
{<br>
&nbsp;&nbsp;&nbsp; 1458&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; // Send gpint command and wait=
 for ack<br>
--&gt; 1459&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!dc_wake_and_execute_gpint(dc-&gt;ctx,=
 DMUB_GPINT__GET_REPLAY_STATE, panel_inst,<br>
&nbsp;&nbsp;&nbsp; 1460&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp; (uint32_t *)state, DM_DMUB_WAIT_TYPE_WAIT_WITH_REPLY)) {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ^^^^^^^^^^^^^^^^^<br>
<br>
The dc_wake_and_execute_gpint() function doesn't take a u64, it takes a<br>
u32.&nbsp; It tries to initialize the state to zero at the start but that's=
<br>
not going to work because of the type mismatch.&nbsp; It suggests that<br>
callers are allowed to pass uninitialized data to edp_pr_get_state() but<br=
>
at present there are no callers so this is only a bug in the code but<br>
doesn't affect runtime.<br>
<br>
&nbsp;&nbsp;&nbsp; 1461&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp; // Return invalid state when GPINT times out<br>
&nbsp;&nbsp;&nbsp; 1462&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp; *state =3D PR_STATE_INVALID;<br>
&nbsp;&nbsp;&nbsp; 1463&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
<br>
Fixes: f2429468b582 (&quot;drm/amd/display: Refactor panel replay set dmub =
cmd flow&quot;)<br>
Reported by: Dan Carpenter &lt;dan.carpenter@linaro.org&gt;<br>
Cc: Robin Chen &lt;robin.chen@amd.com&gt;<br>
Cc: Jack Chang &lt;jack.chang@amd.com&gt;<br>
Cc: Leon Huang &lt;Leon.Huang1@amd.com&gt;<br>
Cc: Alex Hung &lt;alex.hung@amd.com&gt;<br>
Cc: Aurabindo Pillai &lt;aurabindo.pillai@amd.com&gt;<br>
Cc: Roman Li &lt;roman.li@amd.com&gt;<br>
Cc: Harry Wentland &lt;harry.wentland@amd.com&gt;<br>
Cc: Tom Chung &lt;chiahsuan.chung@amd.com&gt;<br>
Signed-off-by: Srinivasan Shanmugam &lt;srinivasan.shanmugam@amd.com&gt;<br=
>
---<br>
&nbsp;.../amd/display/dc/link/protocols/link_edp_panel_control.c | 7 +++++-=
-<br>
&nbsp;1 file changed, 5 insertions(+), 2 deletions(-)<br>
<br>
diff --git a/drivers/gpu/drm/amd/display/dc/link/protocols/link_edp_panel_c=
ontrol.c b/drivers/gpu/drm/amd/display/dc/link/protocols/link_edp_panel_con=
trol.c<br>
index 0b05ee9f6ea1..cf06b9b62e1d 100644<br>
--- a/drivers/gpu/drm/amd/display/dc/link/protocols/link_edp_panel_control.=
c<br>
+++ b/drivers/gpu/drm/amd/display/dc/link/protocols/link_edp_panel_control.=
c<br>
@@ -1450,6 +1450,7 @@ bool edp_pr_get_state(const struct dc_link *link, uin=
t64_t *state)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; const struct dc&nbsp; *dc =
=3D link-&gt;ctx-&gt;dc;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; unsigned int panel_inst =
=3D 0;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t retry_count =3D 0=
;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t replay_state =3D 0;<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!dc_get_edp_link_panel=
_inst(dc, link, &amp;panel_inst))<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; return false;<br>
@@ -1457,10 +1458,12 @@ bool edp_pr_get_state(const struct dc_link *link, u=
int64_t *state)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; do {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; // Send gpint command and wait for ack<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; if (!dc_wake_and_execute_gpint(dc-&gt;ctx, DMUB_GPINT=
__GET_REPLAY_STATE, panel_inst,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; (uint32_t *)state, DM_DMUB_W=
AIT_TYPE_WAIT_WITH_REPLY)) {<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &amp;replay_state, DM_DMUB_W=
AIT_TYPE_WAIT_WITH_REPLY)) {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; // Re=
turn invalid state when GPINT times out<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; *state =3D PR_ST=
ATE_INVALID;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; replay_state =3D=
 PR_STATE_INVALID;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; }<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; /* Copy 32-bit result into 64-bit output */<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; *state =3D replay_state;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; } while (++retry_count &lt=
;=3D 1000 &amp;&amp; *state =3D=3D PR_STATE_INVALID);<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; // Assert if max retry hit=
<br>
-- <br>
2.34.1<br>
<br>
</div>
</span></font></div>
</body>
</html>

--_000_CH0PR12MB52844E92F105DD3815F34C7E8BA0ACH0PR12MB5284namp_--
