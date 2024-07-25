Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DAA73C3DA5D
	for <amd-gfx@archiver.kernel.org>; Thu, 25 Jul 2024 13:37:56 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 921E310E073;
	Thu, 25 Jul 2024 13:37:56 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="yztLTZKb";
	dkim-atps=neutral
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2080.outbound.protection.outlook.com [40.107.94.80])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9084D10E073
 for <amd-gfx@lists.freedesktop.org>; Thu, 25 Jul 2024 13:37:55 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rMEa7LQPBA48sCyfFYNmq3W96ifyRPyOHALsa40AmgyYXMKPy67PEG26x7NmssVyeP3clbBhn6QgLqn1E+lHE2kCfqW7aqvnzxrvlKkZhP36XOo/9WrYwNlNh7FHTduBBzu5vUyP0xVH2+SwJeYZIEPvFtmrWBgZGpB36LKD9HSpJqFroNjXYfFNX/0bBgNBgXySegQzTPYrkt5iyaRlzW/sOYfmOx637EaehL7XdjQoUR0CxgG5nIiBPIXk26bjzdvLm86MKbkRx0XxwTqmVT2LahFsGRk7em9LfTWjyEjYkuk5MzSjY0XuSf0A8bmwS3lVSTD0ADItfl1fjkX6DQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NcYQvGxOO+NSsNKBGilWAnqpveNMqOOjW8I+a/JpQ+8=;
 b=Kui2BlkwURKZYbcFssdr/9R10lYlSHrf51WK9db4ApxsK3h7d1o4wCOq/4lm83QfrHJEKhhybWOEV4FdI3svq5ul5pRBEB/yqmH4FaOlQzwR9V91F93Xe8S5GTWCpLZZMRgLD81ZIJgrTFettrOdjVLDfVy0MNjF1yyLPL1uLy89V3rousXaTMCYlha1MH1XmjLRaHbElTkSSnQ3gloFhVPpKDuNAlUwzGW5+FSLzKulJym8CCdxBZnR58itQkBKcHJwLROmPxxTpAsxWj3gZJJ9u18SIlVTvhRzS3J4AngvV0mF3+tSjeG+xW8CAn9oG6fIyZByPn1sN09Rs70oGQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NcYQvGxOO+NSsNKBGilWAnqpveNMqOOjW8I+a/JpQ+8=;
 b=yztLTZKbX9xYrILdKnLlKJZ9csETNeHlqmdL9vMJcKWZQ5dSLzqPOB6/XbSb19DmwcbQNjxHf6GouI71zGr7tUn/hU+R/3xWKyf6vtUc7FgMQtFG4wg51bYXZhfjb7p8/IW+plVRLOpAc6T+oYIniyyEzbga3UUuydbAqjkdK+M=
Received: from DS7PR12MB6071.namprd12.prod.outlook.com (2603:10b6:8:9d::11) by
 DM6PR12MB4403.namprd12.prod.outlook.com (2603:10b6:5:2ab::24) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7784.28; Thu, 25 Jul 2024 13:37:52 +0000
Received: from DS7PR12MB6071.namprd12.prod.outlook.com
 ([fe80::be26:4c33:76bc:e1b]) by DS7PR12MB6071.namprd12.prod.outlook.com
 ([fe80::be26:4c33:76bc:e1b%6]) with mapi id 15.20.7784.020; Thu, 25 Jul 2024
 13:37:52 +0000
From: "Kamal, Asad" <Asad.Kamal@amd.com>
To: "Lazar, Lijo" <Lijo.Lazar@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
CC: "Zhang, Hawking" <Hawking.Zhang@amd.com>, "Deucher, Alexander"
 <Alexander.Deucher@amd.com>
Subject: RE: [PATCH] drm/amd/pm: Ignore throttle events on SMUv13.0.6
Thread-Topic: [PATCH] drm/amd/pm: Ignore throttle events on SMUv13.0.6
Thread-Index: AQHa3bgtXi55D7FgmkeilE4cDUx/f7IHdCkQ
Date: Thu, 25 Jul 2024 13:37:52 +0000
Message-ID: <DS7PR12MB60713303CCFFBE71C7876E908EAB2@DS7PR12MB6071.namprd12.prod.outlook.com>
References: <20240724105627.1543568-1-lijo.lazar@amd.com>
In-Reply-To: <20240724105627.1543568-1-lijo.lazar@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ActionId=b7a15acf-8223-4f8d-a0d2-982624221984;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=0;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=true;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution Only;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2024-07-25T13:37:32Z;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS7PR12MB6071:EE_|DM6PR12MB4403:EE_
x-ms-office365-filtering-correlation-id: e423fcbd-da47-4dcd-1840-08dcacaefbc0
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|1800799024|376014|366016|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?7LZ/lf32hKeYd4hA5nPE4ShnzkIcDcfBsvbFFVHuG33gI/OEJ7dZERJb4X6a?=
 =?us-ascii?Q?LyRCfTZipyO0x+qfWYrERJ+61C92zSPQ3Kvy6k2whn8aACFohXuvsywD8hOu?=
 =?us-ascii?Q?BwTDYfd4uL3a+bAO3r29N92ufLMHzAgKymM0XHekHcEUuo9a7KeEg0Ybngn4?=
 =?us-ascii?Q?CFwGyTXoHnVIPLRA9AhoW/YyucrOOmff91MNmRl9eeYUy/ts1Orzew17oCFV?=
 =?us-ascii?Q?dKM3sfcLRnLgJxzHxV1kf4AwieQCTu8F6rG7neU/TCJ5au69RRt6VWheRtlZ?=
 =?us-ascii?Q?xOAbTva7Bg8qYgjfrYsEM9UHKPp5HjkwfmNxwx1Z5gKPwza56/szRvoxNXb2?=
 =?us-ascii?Q?0VLyEPGCLPXB1bJ0MYAt2qN1BhlQdfdLxp9F9eEUqyLNPoYOUjleHrlmh74T?=
 =?us-ascii?Q?TngTefmxJgei92RxcLfXyIPkya50+uITfWznz8wYbnB0MvsNvplgl1liJd+n?=
 =?us-ascii?Q?DngSZ2pBpnfWETyTL6J8ljtYh6XAmvXcJ/xt3hRiDWA1VclQOdD/e+TDXlrc?=
 =?us-ascii?Q?IRuizfbf4+A0kM090QmbLFDJDyhsNuBNZSku3AeAPNssHeGivCw1ndf+CMB8?=
 =?us-ascii?Q?HZEDRXCPU6jpWhMuIe+xchGZA6y2FFpZrTqFAKtVSit5bAJYq630DOea1Y/a?=
 =?us-ascii?Q?6xJAjtRPThayxU2EzL2CtOfuLjX2jb/L4qMC6Z6u+uTP8hG2pB4a0p9ZjyDL?=
 =?us-ascii?Q?+HPwRM1omdGKy3HoT21pPIwMb4mJcDoLMAoQ6BKN3XTe1azKfTSSqOQTMCHW?=
 =?us-ascii?Q?6nIm8ClGJaLUJGc981ygj68iRVnH6xRP00uWWIuTkxo4Jc4Hmdyct1xn3l7X?=
 =?us-ascii?Q?mRLNrX6OshiUFB/mzPCoPod2YWroXTxld5K1dCg0zV+8j6BN7Fjyv89GF9EN?=
 =?us-ascii?Q?PNN8cZEB2ZqAPlRd0kD1XRKIskOpu2u4wwErLq3v28Ggsm2KO9zmrHlXt4Nf?=
 =?us-ascii?Q?f4/uddwuzLT5Eeh7BLdD8mV+5fqswtn4pGmoYvV4WqN+vYqAfHMyoWgI92of?=
 =?us-ascii?Q?k1crjxmAWHGEw3MXaHEUfi4ONLgg5BobWpopXMChg92FlDNNhfvuKNxjC8Gz?=
 =?us-ascii?Q?OHYIWWR3qcnwC+5cuj//lfWbpwC0HBcNpYugDX6psRmEd8rhLzdMDAaZ3jh0?=
 =?us-ascii?Q?hRVsGXXewjvdFi6J57civl78fhTNpAcU97wfu2t8pHF4Owjm/fz9u/sTpkSp?=
 =?us-ascii?Q?Tcaubf3E5Pn5/tIRN90BMhaoAdwj2Nd5odrquZbhJQgKdt5OPHDW5c35Wn7B?=
 =?us-ascii?Q?Z+SoM0l4FCGlgIKlyLD8ZM0XhbJ/mzbQ/bu0L1uh+4c/jdsqYcfb2LrGX1yo?=
 =?us-ascii?Q?vjCK3BdTyczzeizxN9oxOiz2vXg5QrEtZb6OD9JH6UgV2dpeUWSS1OdHE75j?=
 =?us-ascii?Q?PvB0f4a3RsftlFbiscbZtdMqfTJ7GxRZDCHqEdWlkkUMS3FUrQ=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS7PR12MB6071.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(38070700018); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?+Ex1lm4IbcqcfYrwLeM39NXH9xk4bfzbdPoN7YmRPPf9lj5Ydq67ejo3SSu2?=
 =?us-ascii?Q?Fw3mwrL1+Hyvz3rpwY39BRQYMu5CGWoF3iTV++qBUhGN8QXYEkZz2Dy0wCsb?=
 =?us-ascii?Q?B+WiE1CMAScNMR9oaAc1h6hTu+Ev8mVtUeBLsXP+ZQ8XrB0vWLaAy9ah07S7?=
 =?us-ascii?Q?i9ZGKC5mD4gu1vuhlff/KWv62xnRrU6dyV2n5J/A23pufuf+HIInhBeraE2V?=
 =?us-ascii?Q?C5BSthRR/GxbhkCzgDjevHiHsOLzC7+PbT5Yw/5TncTFYhP0VFNJVO9DTPyP?=
 =?us-ascii?Q?7rGhLqyeH9qI1Jezfka3VHRTkzqtultOUuLH+2U8DYkTsD1kE17eo0ANLd7b?=
 =?us-ascii?Q?lpNt7pzRkH+bZDtmG4TAPUFM/kWb9/2HbLyQxpviIHq2ux7tPl32hZom6hr3?=
 =?us-ascii?Q?GS4+D/bBpme18ntVgX8GSFI8MOTzcpR9bsckP/XWkkry2G2IJqx8FGKdtPWR?=
 =?us-ascii?Q?EPqb7xWRnlkss1h54/VMGngKt6zQ6DhMG5Mw5TAbn7QOfj6Eg2myDnM7yv/+?=
 =?us-ascii?Q?d+z6lQu7cQua5qSezTSFdA5WeVawksOD5Q5c+/kTq4zl5AMJ13bvSbkPzBkV?=
 =?us-ascii?Q?itOP2WvOGqmIWIlsRloIO6kTa/Qw8HUXVqwpZi8VtOjDKwl61XdBF5JXTqXz?=
 =?us-ascii?Q?UXCmwuCdcjuvhMe7U7zfJXH+ju1621VStjnhB18UWSC7ZZBZOyj4dcGe+Wup?=
 =?us-ascii?Q?nOChVAig7QCi3wu6HP89W4PdLaPuKLVhJUkC9r4QU4W9mUHWwo4Eq9TDQt2m?=
 =?us-ascii?Q?VQqEhYabsWdeSu5RRfaeA78LwcTqI/DQxQ9Ev9L3x1YHJKfmN1oKIFlWjbyc?=
 =?us-ascii?Q?f9epq+/qKtypqGebNZNXBqdLF0cHf6/UyBKhSM47Fv6EgxzsC8VDoyvR+wZv?=
 =?us-ascii?Q?xlqtyCRmwmyScDBatL8ED9n4cuQRCfmSdyMV8ZIAj9rM9o0RbuZwyyW6dqpe?=
 =?us-ascii?Q?JOkKQI9aTSbdvUOCDrWs33rp9hXn6tzm9bMqiHKWIeHZl8QUrLRz5XAyi0fT?=
 =?us-ascii?Q?SME/nu9QV0iY+Pymtyfa/HvbC1uXBcVd9XO1TxaTURk5L77/J0aUytpemC3/?=
 =?us-ascii?Q?BSutUgvymK5agJ14UpaEeRcPAMWn9ub3Q5NntQeyjxh/qUWNkAX2mmIyEzZk?=
 =?us-ascii?Q?AnIP0vK7H6cdo8hu/R4hTyvu6Ku3Hmnr2XbkG0/ofaR3PLhx+PEjArXlAMIG?=
 =?us-ascii?Q?I8Sr8b+0ZHvMl2ISz9Uv4MEOD/oOXqqRH7+45YhHLbVCYguiWw8xoCVVCRIX?=
 =?us-ascii?Q?yfn7JmeHaCjmXPxzWbKS8Z+/LAmW7WFzGThfT8njHFXIVq5D6jc8hhWNd0Ro?=
 =?us-ascii?Q?9OI33NOTTffiTuRtb+K5NOsmsmo5YKHcw1Rvi53+lbebk69CCRc9dU3KgkFP?=
 =?us-ascii?Q?SlcneOH6/QdjoTynrWfte0CqWU7fG7NSqD6FR+0z6iJZ5X19X1sLpxl0Iv4G?=
 =?us-ascii?Q?/v5L3aJZZe1r/xGEYUa+KFLnwvcngTC8zJ6j1SKkf1w4UJGWMrJQJgzQNv1I?=
 =?us-ascii?Q?c35Ib9Wlk7F935GQZwtavoiTHQ9jm2RUxVt38zS6upBWkYCeaLcGOUvKKYL/?=
 =?us-ascii?Q?cRsuwN2TWCkOKvi7iXc=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB6071.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e423fcbd-da47-4dcd-1840-08dcacaefbc0
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Jul 2024 13:37:52.7322 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Icf7DAmYaLjcjn8JcmM6tH0Pd3KGmdTxSEXHv20r9JMtVL1htDubhyb+f++gCzzsqj/lLC1LqDgb05sJuYk3iw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4403
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

Reviewed-by: Asad Kamal <asad.kamal@amd.com>

Thanks & Regards
Asad

-----Original Message-----
From: Lazar, Lijo <Lijo.Lazar@amd.com>
Sent: Wednesday, July 24, 2024 4:26 PM
To: amd-gfx@lists.freedesktop.org
Cc: Zhang, Hawking <Hawking.Zhang@amd.com>; Deucher, Alexander <Alexander.D=
eucher@amd.com>; Kamal, Asad <Asad.Kamal@amd.com>
Subject: [PATCH] drm/amd/pm: Ignore throttle events on SMUv13.0.6

Spurious events are seen, temporarily ignore the events altogether.

Signed-off-by: Lijo Lazar <lijo.lazar@amd.com>
---
 drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c b/drivers=
/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
index 1d76916ed056..b2059663883a 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
@@ -1739,6 +1739,8 @@ static int smu_v13_0_6_irq_process(struct amdgpu_devi=
ce *adev,
                         */
                        switch (ctxid) {
                        case IH_INTERRUPT_CONTEXT_ID_THERMAL_THROTTLING:
+                               /* Ignore throttle events temporarily as so=
me are spurious.*/
+                               return 0;
                                /*
                                 * Increment the throttle interrupt counter
                                 */
--
2.25.1

