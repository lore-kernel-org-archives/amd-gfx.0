Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E5C0EFF8867
	for <amd-gfx@archiver.kernel.org>; Wed, 29 Apr 2026 09:58:57 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 829A710EF0B;
	Wed, 29 Apr 2026 09:58:57 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="SNlC7eYv";
	dkim-atps=neutral
Received: from CH4PR04CU002.outbound.protection.outlook.com
 (mail-northcentralusazon11013012.outbound.protection.outlook.com
 [40.107.201.12])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 13BFB10EEFF
 for <amd-gfx@lists.freedesktop.org>; Wed, 29 Apr 2026 09:58:56 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PV/fd6cJYMT33xqkwF9Lc18xbka11s/KyQq/5rX0Qlw6WULySvFqHCAOZ/Kc9yw0XnE03bINSq7s+yy2dOeuwx9R6O7vWbDT4JVJQjDeFIK674gYVSLpYjjT/alFz/9UDo4hms1aeyalpcNgJ+7Vwq2+V/nYbdVOhX+Wyq7+JJoFf/Wd+Fre0sf89QhsKsYNbR6bJlfKOn18mj9ZQRgTLGZaXMNlxhcRwtj7QMRb/LEdQklXgfRAhTu2mPOMqUoPxkrmsz9MBb/TEvE7sKCXRppDN8qq6jFdS2vcyVE/YTXy72CvZO/6bKUGvEji+qhTtSfd53XFKY5NJpefuy1Qjg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hresKaTLNpkYDKtSiMsirB/Bj/jE2d2OVMJzcoxgAnM=;
 b=BDUKK/oopvZaMNpw9oTK/nX3QuRg++nl4YJNiS/qJRvxgdRf2zXhS+0l1DXDqLBEjF6od6nxw8bujW2BOC9QsAh4O10SWH/D8Y8MmbGByJ9MCc3f7d/6HNGrKuUP3jnfoiVIvxEXwwLwpqwB/hw72Nhw0xrpDwQfeZ4ZFkgUqC3V+9rYfWikuY7/xZmyCsTNtoIC7UeCVUyP3xk1uo6BJjbyOEjGSkHpUbUNIOLWgQTD5APERSFoqAYoDgfgog+PvzyyPSGalvwNtDVBQlFAwpXAYHwd9eNPEjGfc0Lz0VjpVNFr5IrxEYZDOg2cTY3yZuWJFBvAjR+VP492mdT5GQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hresKaTLNpkYDKtSiMsirB/Bj/jE2d2OVMJzcoxgAnM=;
 b=SNlC7eYvbYtM3YAUgTqydg2t/Uvb09ulntlbmQ1Dum9uEjioFQrUhc99RRGxnI82lo0WEtoIGal6WT4o5NYIgeqJFTW98562D42R96EKDP310s+pqbffAFJttaDAhrmSs7g/VM8seo5DW+ouQhezpNb+qOwuy1Z2ib0E+xntRaM=
Received: from MW4PR12MB6803.namprd12.prod.outlook.com (2603:10b6:303:20e::10)
 by MN0PR12MB5763.namprd12.prod.outlook.com (2603:10b6:208:376::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.16; Wed, 29 Apr
 2026 09:58:52 +0000
Received: from MW4PR12MB6803.namprd12.prod.outlook.com
 ([fe80::c193:ef2e:260f:dcfd]) by MW4PR12MB6803.namprd12.prod.outlook.com
 ([fe80::c193:ef2e:260f:dcfd%7]) with mapi id 15.20.9870.016; Wed, 29 Apr 2026
 09:58:52 +0000
From: "Feng, Kenneth" <Kenneth.Feng@amd.com>
To: "Wang, Yang(Kevin)" <KevinYang.Wang@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
CC: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Zhang, Hawking"
 <Hawking.Zhang@amd.com>
Subject: RE: [PATCH 0/4] drm/amd/pm: add and use the SMU multi-msgs helper
Thread-Topic: [PATCH 0/4] drm/amd/pm: add and use the SMU multi-msgs helper
Thread-Index: AQHc1hhC4GPSzRHa0kq5s/dnwVFf4rX10VUg
Date: Wed, 29 Apr 2026 09:58:51 +0000
Message-ID: <MW4PR12MB6803E58980E1939F1555B3EE8E342@MW4PR12MB6803.namprd12.prod.outlook.com>
References: <20260427073355.3363500-1-kevinyang.wang@amd.com>
In-Reply-To: <20260427073355.3363500-1-kevinyang.wang@amd.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Enabled=True;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SetDate=2026-04-29T09:58:43.0000000Z;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Name=AMD General
 v26; MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_ContentBits=3;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Method=Standard
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MW4PR12MB6803:EE_|MN0PR12MB5763:EE_
x-ms-office365-filtering-correlation-id: 7f1e6270-23dc-412e-e786-08dea5d5eae6
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|376014|1800799024|22082099003|56012099003|18002099003|38070700021;
x-microsoft-antispam-message-info: ppyHa78eRHVyejgYI6D3IIFGTFQ5ryoLOvha8G/sFezpKTMXsJ+zYD4isTXklhs89RY/jZV/c16m4K1rk8re4sYNqUckj/xcjRw1ySUbjYipClbyCbyvlWDtV49KVP/mugvckNqJmeRIxSGobmyM8exE1mi554PmYtcrjLGRMLMQJ6bxK10qzA2IkU9BLJjVeKwLzx4C6HhIT1X1iXxeAkan72o/yiQfB9WrwCmbHxdbczGUEMcpOv8iUDO7VSvYyUbBjsC9GueBDwf91SfKorLzeZs5ipS2Uff7HU6uXK/P00eAxLbpi0ODcvAMH6d7dNvRj7J+ZtOUvKrnivyXaQbQd7+RSAc6WUrXBfbmM1PkpCUjnWTSCfEF9JeGNZCIy29bBBmwfUlDnBL8x0KRcugiuX5nHOAcOWDfauOG/TzfPAY9MaW+Snr+YbUgkaSAG7f4eAypmAaf3W5y85AyecvBe5cG0Z9xcBgKUdpvf0XX+1+mvPMQXbqvA1AT/QfWmOWnPKvqGyPnZwgon/qJlLzT5m0AHkDb8dhkpCnWELy2EQTD5GJaU8nqcPGcxA9BbJHYt+x4EZGt9ZERswk6tfwDR2RSBvBF73HuZ5/noD44FDQFg2aIMMYm3Jf3LvgN1GSuEifFLMVpZ19xzbj/YHqbvdPoPv68IyTAwpC+vdegA1Om+3yuMxNkrvv78dR2RfG2QazJWHflFep4GNiVFlA/7E5r0BdoGwCjaVY6NwqdtJDwfJEJ05nBqwZryg+iVECi7aiys+edwAWUttTMoEFUrpJ4ilzyG4nXHi03DxQ=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MW4PR12MB6803.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(22082099003)(56012099003)(18002099003)(38070700021);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?2N6NP5IdHRGskUERAQbeBQ5kEnr/JGo5wDwOP6le09lEpY8bIBVWFqIqeAf5?=
 =?us-ascii?Q?RxSDBNnqXX3KNXSszXhx0+busLUa3QVthcQhjbNC43RLuIlG4+DtWf1kkBRv?=
 =?us-ascii?Q?3q4W0V9qGsnyDUbAcylOkI91eMjt55hiFO/uuuU1Uq9IDOLPH515e6lAOCR9?=
 =?us-ascii?Q?B2fFsrGkGExL9x+/U2S9aiqEICPKBgupdo3VdsVSTLqvvQS37MKDqVasfDCH?=
 =?us-ascii?Q?tQdcYwjEmUVo5r/fBXvPBzxogAARHRF6drYpSvAqWj4bVJ6Z6MYxbiOL9+Qb?=
 =?us-ascii?Q?cb/uaI9UAizUJUaHaQ7zF1t51EL1IUQydegkCbV1YEv/dUy9Mk32ACzaVlLq?=
 =?us-ascii?Q?wusTW3NwGlNwd/m+evPjrPLJNp0WdTncfw5KXpVEw0mJ6cFKutC651dtmNDd?=
 =?us-ascii?Q?m06J8F/oJgE15LsIvc2STGb0B0G6Zna5eHOkz27ehFRLWuADZ5oL4lYSXH8D?=
 =?us-ascii?Q?X2Df4AYHwjNV/ukkPGIDqJFb52FaX3xc4vcQbd0jYVXWS+rpLN1QhGxLftKQ?=
 =?us-ascii?Q?ijWLpuM/K2pqq0BS2hAWz3QnXrK5OyGLC1FqyD1cA/uLhF3syFWRDRHAjVBu?=
 =?us-ascii?Q?Sa6E59yxAbkxlYlatEZYN4sQDIk5aO/xBSMDEPZJ2iNJhhH3ZHRVikKttSes?=
 =?us-ascii?Q?9t2ZZ9iBQg+4vxv7A82LgODCr1OLoH5isPjfct1VExGa2EvUriUTJPimpnvQ?=
 =?us-ascii?Q?ODjjD95PGCxsf6EJhh13pkFaEuP04vqE1uGkSWdPmS51O37poIFWlDinU7cK?=
 =?us-ascii?Q?RgBef4Z/lxu6vgSzEuoT4M4GzNkMkaxfeGMZiwzHXP2ysjMCpe3k/7m5v+me?=
 =?us-ascii?Q?u2J+Ec/uHQcI84pxvxVa+6q/8fUgrvy0KhbQX54hbvZMhimrMlG5ZeIAlupk?=
 =?us-ascii?Q?sDsCFExoyjmQ0bzV07G90Xkq2zhyieMrM4E9J495NEoxCTY3/msEbD5Lgr4e?=
 =?us-ascii?Q?yKvPIWj4JUZhBlgxobHa6cixvOtm++xgwjOUnPOvzqzMsddbLCDicpPUBeN/?=
 =?us-ascii?Q?t3fo1ZGsq9kKhrgkEO1umcEIabtU94JA7kLmX40aM7+bVFv16BlnoC8YQwBA?=
 =?us-ascii?Q?u7ZHjvUvtLTPdF+HZcs4uvOWFpuE90tp36/BWsB1PHnoszemYBFAWfS/qX9/?=
 =?us-ascii?Q?scclD26RFvgyGvV5ckUkm2+21BhRG56ZTGErw1jO4fzwLrzE1saZxT4c36t5?=
 =?us-ascii?Q?O+vThxaddDFWwwxv3n90uZrj+NjGJ8ZDfqaWpcnvPtVm7ekGj9TICJ8t6Zd+?=
 =?us-ascii?Q?hIabcNvAc5QFMLeBKKLzXUI934fbhIeO8vc1YTEspnTPCjpa0sK5lDoG56U7?=
 =?us-ascii?Q?ZHURHZIGeJXZwysx4MkzhPe0uEozKfAwwEVpUp0iG2Ow83kTSe4qrVxq7QSc?=
 =?us-ascii?Q?uhn+t53V8wRrkCz1P9PnU9+/slKSuoK0Dw2xrD6hJk7dtsPVoUxcThn/uJUX?=
 =?us-ascii?Q?j07MorXiMalt6FF3Mj7fe6gDQW77UVOeRPPfNAhbq6Qx7hDtiA2QMePftexG?=
 =?us-ascii?Q?+goJIsv53NccMcnUCA6MLtnWKnIhtRSbX5hwhAaJ03dUg4B/jC5vhF4mfuQA?=
 =?us-ascii?Q?pWM/KlnT0sIFojw1q7s6TuBphnShL4EZajtKfuwgYMj9wp3aep704fvuJ4AT?=
 =?us-ascii?Q?yjV3rc77UdOhgR/gqm0hmF6iztWzFCrDvljRNVLITMRVB65gS03E7046z6HN?=
 =?us-ascii?Q?UuHcuaJJ1mAw36FpizZpn9OEYLT2nR563Ket1AfQDahSaQhd?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW4PR12MB6803.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7f1e6270-23dc-412e-e786-08dea5d5eae6
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Apr 2026 09:58:52.0386 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 2w70Lip4DAuurPZTWHz2V1rtNzYF3QmcG0S23bR4akMJUzS12c36w7f3NlcpuShR
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB5763
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

AMD General

Series is Reviewed-by: Kenneth Feng <kenneth.feng@amd.com>
Thanks.


-----Original Message-----
From: Wang, Yang(Kevin) <KevinYang.Wang@amd.com>
Sent: Monday, April 27, 2026 3:34 PM
To: amd-gfx@lists.freedesktop.org
Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Zhang, Hawking <Hawking=
.Zhang@amd.com>; Feng, Kenneth <Kenneth.Feng@amd.com>
Subject: [PATCH 0/4] drm/amd/pm: add and use the SMU multi-msgs helper

SMU15 introduced driver messages that can carry multiple input parameters a=
nd return values, but callers still have to build struct smu_msg_args direc=
tly.

Add common SMU multi-msgs helpers in smu_cmn and switch the first SMU15 use=
rs over to them. This keeps multi-parameter messages and multi-return queri=
es on one helper path while leaving the older single-parameter interface un=
changed.

Patch 1 adds the common helpers and updates the shared path.
Patch 2 converts the SMU15 base table address messages.
Patch 3 converts the SMU15.0.0 table transfer and enabled-feature query.
Patch 4 converts the SMU15.0.8 enabled-feature query.

No functional change intended.

Yang Wang (4):
  drm/amd/pm: add SMU multi-msgs helpers
  drm/amd/pm: use the SMU multi-msgs helper in smu_v15_0
  drm/amd/pm: use the SMU multi-msgs helper in smu_v15_0_0
  drm/amd/pm: use the SMU multi-msgs helper in smu_v15_0_8

 .../gpu/drm/amd/pm/swsmu/smu15/smu_v15_0.c    | 47 ++++-----
 .../drm/amd/pm/swsmu/smu15/smu_v15_0_0_ppt.c  | 38 +++-----  .../drm/amd/p=
m/swsmu/smu15/smu_v15_0_8_ppt.c  | 14 ++-
 drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c        | 96 +++++++++++++------
 drivers/gpu/drm/amd/pm/swsmu/smu_cmn.h        | 22 +++++
 5 files changed, 130 insertions(+), 87 deletions(-)

--
2.47.3

