Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C550BD46C01
	for <amd-gfx@archiver.kernel.org>; Thu, 29 Jan 2026 03:04:53 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 70C4C10E7B1;
	Thu, 29 Jan 2026 03:04:53 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="cp9/hQ5/";
	dkim-atps=neutral
Received: from CH1PR05CU001.outbound.protection.outlook.com
 (mail-northcentralusazon11010048.outbound.protection.outlook.com
 [52.101.193.48])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BFCE710E7B1
 for <amd-gfx@lists.freedesktop.org>; Thu, 29 Jan 2026 03:04:52 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Slgi8L1O3iLqwP4158C1mE4BHDnyhVq5mi1RjEiZzHQ3Ue3F4EfQDKJSyGb3v9oGAHjGmvKu+pr1FeDLSUC7uRVRIn8+eKSEOW0ems9S5QxTQZOwMN5ILWHGY/UzdklNwbN+0HSUGQBPjQrhSJdTpekj88Dh/bG2npcCFAI2tLJyPYXrFX1jzHq0K24PEI7PwNRavryEDfWnRB8dvRiaDRatk5u0dNsgew6hjnpi/yrhYF/4j4169edsgVBvwzOWhaQTDaAo6enSa0JxKtmWTTab9SmnOoNMUHSuMnQm+lJgDaqPO1lYpd85bqENzPFQYFHg26XbWEzhioF+Vn4zCg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RNYe1rdLlpgc8tSP5A4sV23D4hJVQYW+4iEeGCBdJBk=;
 b=a2MuminRr+Zg/P/dmX92pzbI5OQU1aFB4n6o+Ysg47g97BFo+jtc06mezk3TzQpLg3QTChkhKGGdkV/ot1KByTab1hGid8l7aRE6XoD56pCQ315phiEMiGhe1tSdnZwemRN3K3v1cDrGH/zloExdn66e6COvlRFCTfooyD7HM5Oryw7wWbixuDUlyaF+mhVPiV9td33EFqwMeF4MbfTtISeI21DB6J+GIScrR8XExuuAkUfsc5gzB+cnzny0wdm3CkwFVfOda7PXm7Kp2cIwDEUgqGSXcRwl+ai1IH3hoaiRM2ae+r1UnmgrHNxT2saDwKTAje1J8ZhXGdZ+HZtgrA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RNYe1rdLlpgc8tSP5A4sV23D4hJVQYW+4iEeGCBdJBk=;
 b=cp9/hQ5/XOol1v+Ed2Epk8Vmh+Lxlqey/aliNdBCnL7Zngob9peQnstbVzPeBa22NlrRRvVhjOBIv1O4LaY223gKNcMmrn9y9BYQOmhUTOus5fLhhfV+dIQ29dBZIFzsPXJzFBoXbJQWzxi47rCI6VSw8QSglIHKiLaT9y4w1mA=
Received: from MW5PR12MB5684.namprd12.prod.outlook.com (2603:10b6:303:1a1::21)
 by CY8PR12MB7193.namprd12.prod.outlook.com (2603:10b6:930:5b::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9564.7; Thu, 29 Jan
 2026 03:04:49 +0000
Received: from MW5PR12MB5684.namprd12.prod.outlook.com
 ([fe80::f0a2:a7d9:42a8:ace6]) by MW5PR12MB5684.namprd12.prod.outlook.com
 ([fe80::f0a2:a7d9:42a8:ace6%5]) with mapi id 15.20.9564.007; Thu, 29 Jan 2026
 03:04:49 +0000
From: "Xie, Patrick" <Gangliang.Xie@amd.com>
To: "Wang, Yang(Kevin)" <KevinYang.Wang@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
CC: "Zhou1, Tao" <Tao.Zhou1@amd.com>, "Chai, Thomas" <YiPeng.Chai@amd.com>
Subject: RE: [PATCH 01/14] drm/amd/pm: add pmfw eeprom messages into uniras
 interface
Thread-Topic: [PATCH 01/14] drm/amd/pm: add pmfw eeprom messages into uniras
 interface
Thread-Index: AQHcjneptRAKaMH09EaUUxskn3YfZbVochKAgAAI0aA=
Date: Thu, 29 Jan 2026 03:04:48 +0000
Message-ID: <MW5PR12MB5684D2535C4A40013F72BDBCE59EA@MW5PR12MB5684.namprd12.prod.outlook.com>
References: <20260126035527.1108488-1-ganglxie@amd.com>
 <PH7PR12MB59975DF0C09788ECA4FF7357829EA@PH7PR12MB5997.namprd12.prod.outlook.com>
In-Reply-To: <PH7PR12MB59975DF0C09788ECA4FF7357829EA@PH7PR12MB5997.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=True;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2026-01-29T02:30:17.0000000Z;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution
 Only; MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=3;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MW5PR12MB5684:EE_|CY8PR12MB7193:EE_
x-ms-office365-filtering-correlation-id: 1b7d3147-0e57-4144-9425-08de5ee32a25
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|366016|376014|7053199007|38070700021; 
x-microsoft-antispam-message-info: =?us-ascii?Q?6l0qjmJIjfWmD8wYWz/FbDzj46wX9e5LBujk+UcNvD5nlGW2F3U4Ymf6kOfF?=
 =?us-ascii?Q?d3+IE4YfytQKNP4I+tM6Hw8ba4Ev7UmsAoCw3o/ZpGS4XQeqlpPEC71R7gAz?=
 =?us-ascii?Q?p6pkSiPlMeqgQQy+CEAAXak0r5oCbjYhex3JVVRSJXpOncA7IgQAFD5FGpt6?=
 =?us-ascii?Q?0KYwB0ZmPbevI2WjDYTpR9dI/Uj9xstTwyUQeFUceIdPhX6EiqIOWOVw9aGu?=
 =?us-ascii?Q?PNcTljbwiziwS8tznuozwFsdK6nOqW2o5uSpU7MBDUXFGyt/ajBqLijDLmgO?=
 =?us-ascii?Q?cBtiw0dn71J0Y57tMiVzCwpGK8Kq9tTobDrrrz7bPGwHaRA3UwqBloip4qFE?=
 =?us-ascii?Q?KkQrM57RVAF3Tw0S69vBdtw6Oyox0PS0MRfBtdaqM3UfBXg0r2Knm8AKVdco?=
 =?us-ascii?Q?5Pdkwsy8irs+j+w8BBv725L/c46qQC5RS2iq4ZuZeCgSSFpnpnG++N9XoLJ5?=
 =?us-ascii?Q?v8ilzt66xi1lacYBDcQqehOLYx54sieF6ChnnIfUFSGTFgFc6g05IDVo0PoE?=
 =?us-ascii?Q?Casl0lVl28lorFPOD5YfERT3GtsTN8EvrxgylAt+cv4MMcPr/OMweTsiSvnB?=
 =?us-ascii?Q?OqAev6eEbq9GBFdrNZYw+QA0bG4rXGh1V2m6EgGq6ez9NK5bX2ASpLz3Ppuu?=
 =?us-ascii?Q?6B6CVN9YGDoDgFooEt3Tx/bWer6kbpr/Io1kYRif/0zOgtwPchuimE5UtmUm?=
 =?us-ascii?Q?DrWVJ4l1ud2xi9XVHd/xVXC+1AyRLoMSGixMiTcsC3kTiQsvw1CDmUf95GaT?=
 =?us-ascii?Q?zd1ap2as7Uhyee1/mGC14Z69dykoFSIPxHa6FDHQEYEhMibFDEHbBA75bFWV?=
 =?us-ascii?Q?2jZ0y+FO8tFABthCnnkfUeQbV8vr9wNNYjaaGFF526JMAT2AIv64qhZGYEsb?=
 =?us-ascii?Q?bo9mBMlSBTn/lV4j2lp/cpZMxADZw18SGCuNIAhPAO7ECRSrbRVIS/fov6Vk?=
 =?us-ascii?Q?N5n2st9lrvb7uzNf+m/pW3BhtAnK7OYwxXz1Gh1Yumff70GU95Z7d+e6K83o?=
 =?us-ascii?Q?HifEXxsSPb6btu0IcKYW9awwsuCfWqvB26mIFt/SYHXwGWEq7lMnobpvQcmd?=
 =?us-ascii?Q?sK0GpAdBgOjChis+yZdw6XkadzmTAxg6fkZ523kFrm9wnX15jAH9f5O4ezCh?=
 =?us-ascii?Q?RGZYpsqvtGNxbDWf62WPGCfe42BXxz/w4JwxHyNi2BAN+sfhpZEWJevhxbJb?=
 =?us-ascii?Q?3UOoRGe/2s+xolfwbXvnzEG7Z1ENDhcRGBpOWticH4ECwlQ48Ym9xx4t3orE?=
 =?us-ascii?Q?8lwXdh8mfWDhasuT/aGjcJfYoSN56WingsLqJP5lUTqexAIYSK5SS52Hvz4t?=
 =?us-ascii?Q?L6Lf3T9beheYIeW7QTMRZv70CwH2OltdxkMcOWy1qj2rI92WSJ1y5Z4dAQN0?=
 =?us-ascii?Q?8s5KSIfBCz6HngfR6U4xFqZdQOpppV427nwLOHtJnBEVskY5ts03ez2Y90J5?=
 =?us-ascii?Q?UEBNM6PB1pxdVcWc0Z6ZaMYcq5Z93xYamPN/v2XZEyTzlubouyn9uDuk7ZUV?=
 =?us-ascii?Q?TJHEHdMXck/qnV7kW3oO9ORykhBkKFYW2UHJieIIyn/LUpQGBxelXpTv1EBN?=
 =?us-ascii?Q?3zRKqPZJslrzIhjAtENbPIWoFhVUxxVfDohRRJHTbVbWZbOiY1RwSp50dqRr?=
 =?us-ascii?Q?Se5LCoAb0UJJDeZHRJLpXOE=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MW5PR12MB5684.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(7053199007)(38070700021); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?xVhFlFuzw+HcOkFQE38UBt7fJpuYcQyvmri5cx3+GqvFCkuq2HMG5Y/oqV0n?=
 =?us-ascii?Q?alwIkBdq3qD99OG2GGo7/w1Jo5OnhcH3G43PzRGaSKIsse6RAgc9/U855RxO?=
 =?us-ascii?Q?P4rd2O2x0WDBYSbWxguHCSulTDAyhxR0p8Ou29qNS4zIS78f9Xm/bPxfKOzE?=
 =?us-ascii?Q?UqwrXM+yqBCO85BtMmp//v69i5gxET2655qyVNSOBki0AJBP30FGiWuTXdBb?=
 =?us-ascii?Q?aRxicEgHkh2BQ8Y1ePf40G0pOkx6gMRW7Md7FZaf8W8WuMKxrPtNRoTLOR7v?=
 =?us-ascii?Q?jNsx/oHfKpshvHNSvsvvah09qqDUnDH0EC2B1C3tSSicSFvO5u3B0CTLWsWE?=
 =?us-ascii?Q?/hB9DXpSWy7G3oU3hIbjz0EtA3rUrI6zlnD4QRQzp1J02Gi9kyFXzm+Vi0kh?=
 =?us-ascii?Q?BP9o9K4WXABJC5j/fofn+QZXSdCy4+Qt9TYJFBauziD0unfkwm55OZSIt6SH?=
 =?us-ascii?Q?XxlAtAwJlzAX708nrQBV7TWB8fZnwJ2D44h+UiPImSLttC4Nh2Pr2UGGP6Kx?=
 =?us-ascii?Q?zQkudixd2DL2qRQ2HEGFYUG7Ru0Twcm35LqIAVF3UzUMnXXDEoPe0sW8s273?=
 =?us-ascii?Q?A8lEBJwJNy512xOZntGZa1iXZzp2Li0iCI8tyUNqWjrifgWXb9WsaVLytbKd?=
 =?us-ascii?Q?6G/wFeKWVWj5L65PWt8io+Wic1XwSpLFkRkmlfdmpfColrFXFhxjkTmQZ5rk?=
 =?us-ascii?Q?1p2iZ5KxqOUPh2xRFjLmMiVc93KO0Wl6qjNL0Q6sO2eIrjrr4tzZlsGjcdG7?=
 =?us-ascii?Q?41uP/P8D8jg3umDgbKlezkWZdTkkPreJ1hGXOytCZiTMGGkHWWxTB/ISaJWm?=
 =?us-ascii?Q?HiLamxJRDDGijsNN5SxRzJI30suV8xav1KR6i6uICpUYlJyO7YbJ5Wez8Vo6?=
 =?us-ascii?Q?e5h7D39EcT2ekegXUEIhu5f1sKTHKukt9lnxeLQFqQpe3X0c29s8nJ3IFqrx?=
 =?us-ascii?Q?eM8HDjE+7ivLjc+iPm5s8hX0pQ//jhrFhXEo/C5C+M/i0/yRuZvwYE54mMgz?=
 =?us-ascii?Q?et8itlKDDEcIs6RtvC5X6ClfSKKMTvkKao6j5a6VQJUnw036wuiypagkq3Za?=
 =?us-ascii?Q?HxGBeHloWLuI+Dv8Z5DIVQ21hJo6LfIejvXsFmDFUcH//c+qNja4IL+GJdqm?=
 =?us-ascii?Q?QZuvVXcXDlhABFaYMFNP7mrxDrByHFcncpvttG38bVStuaKiDUjEx+6CSsjk?=
 =?us-ascii?Q?SiEM09QXg3pPki2fvgw0cS5qQNhIs2jSO/md9C28w1molShOY/ve2+ztU+rQ?=
 =?us-ascii?Q?Cs1aoEila2CIJ6yl7ksQvg9GD3/f5F8WyHXZCZ3ti7XdjxsqcOdhckTtEadm?=
 =?us-ascii?Q?YJOP4jm5FHyKnIgZv2lUpR5PpsYFXzjNJ5+XQHtqKYXrlEE0WSuQ70kZOfHy?=
 =?us-ascii?Q?ZCYeeSvEmJELoYBEUBMubZxdwGiVpLce0aZoGMK0P4AlmJKF8tW+1Qb5n3H5?=
 =?us-ascii?Q?ldPvhTHWnjLqUA4nc8y411gVBnbGB3AbLaMFeB9ajNARtBSCgg4/DmRZQYKa?=
 =?us-ascii?Q?f+HL9w3xqQy7GIYoEpHxucfUignjWgmEHCfVgl5mn2xNckS3DGZrZHbX99d4?=
 =?us-ascii?Q?HsIFmOEur0HhDfo25a/159CUkObnek6m6aHNjKLGOPGMUPeFrAL51kTU3l78?=
 =?us-ascii?Q?P/zZpDc/AFMyEtMLqjOxMOoSeE2h9ICQTaytbMrujZqAkrxH0lqvMBg/tM/x?=
 =?us-ascii?Q?CeQeTgyFmGamKsasR5+0vLuI9B2dk75S1fJKldXEFaiRwLOz?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW5PR12MB5684.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1b7d3147-0e57-4144-9425-08de5ee32a25
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Jan 2026 03:04:48.9569 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: SZqg4Mc12J24Nb3nxPEo/TnbfgnI8IAB0eaW/fzfVgY35+Zi9OP3/o5G5hY4bwNBovCUQdE7AyxnwjHYkHQctg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7193
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

Thanks, Kevin
Will add sriov check inside.

-----Original Message-----
From: Wang, Yang(Kevin) <KevinYang.Wang@amd.com>
Sent: Thursday, January 29, 2026 10:32 AM
To: Xie, Patrick <Gangliang.Xie@amd.com>; amd-gfx@lists.freedesktop.org
Cc: Zhou1, Tao <Tao.Zhou1@amd.com>; Chai, Thomas <YiPeng.Chai@amd.com>; Xie=
, Patrick <Gangliang.Xie@amd.com>
Subject: RE: [PATCH 01/14] drm/amd/pm: add pmfw eeprom messages into uniras=
 interface

[AMD Official Use Only - AMD Internal Distribution Only]

Reviewed-by: Yang Wang <kevin.yang@amd.com>

Btw,
it is better to add sriov check inside, what do you think?

Best Regards,
Kevin

-----Original Message-----
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Ganglian=
g Xie
Sent: Monday, January 26, 2026 11:55
To: amd-gfx@lists.freedesktop.org
Cc: Zhou1, Tao <Tao.Zhou1@amd.com>; Chai, Thomas <YiPeng.Chai@amd.com>; Xie=
, Patrick <Gangliang.Xie@amd.com>
Subject: [PATCH 01/14] drm/amd/pm: add pmfw eeprom messages into uniras int=
erface

add pmfw eeprom related messages into smu_v13_0_6_ras_send_msg

Signed-off-by: Gangliang Xie <ganglxie@amd.com>
---
 drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c b/drivers=
/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
index 57f4069bc827..81b7fafa1817 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
@@ -3505,6 +3505,13 @@ static int smu_v13_0_6_ras_send_msg(struct smu_conte=
xt *smu, enum smu_message_ty
        case SMU_MSG_McaBankDumpDW:
        case SMU_MSG_McaBankCeDumpDW:
        case SMU_MSG_ClearMcaOnRead:
+       case SMU_MSG_GetRASTableVersion:
+       case SMU_MSG_GetBadPageCount:
+       case SMU_MSG_GetBadPageMcaAddr:
+       case SMU_MSG_SetTimestamp:
+       case SMU_MSG_GetTimestamp:
+       case SMU_MSG_GetBadPageIpid:
+       case SMU_MSG_EraseRasTable:
                ret =3D smu_cmn_send_smc_msg_with_param(smu, msg, param, re=
ad_arg);
                break;
        default:
--
2.34.1


