Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 99BB4C55167
	for <amd-gfx@archiver.kernel.org>; Fri, 31 Jul 2026 03:57:40 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 23DB810F144;
	Fri, 31 Jul 2026 03:57:40 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="3l7UQIYE";
	dkim-atps=neutral
Received: from CH1PR05CU001.outbound.protection.outlook.com
 (mail-northcentralusazon11010023.outbound.protection.outlook.com
 [52.101.193.23])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7F69510F144
 for <amd-gfx@lists.freedesktop.org>; Fri, 31 Jul 2026 03:57:38 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Aaf2GxsaK/RdgYVZg+wBXBhXXE74q6ZgP2GkeGHseD22b8l7rgwx/ui6WEgCEip2TUs0VVac9x3U5ppriFw0GjsWffoXQ24zayYKjtM6Z9BxZvGuundHQFAJFzD1QUcjswflV/h38m7tIMYYQ/oraDyp4mGsR5U+NLNAM6SHLqNw7qsxm+1BrHtYvSftXvKRUPTI8TDvIfkWN30dzMb89D2qMXkZuZuSZ3/sv63C//uB6ayFQ4ia4xVJzg7kHu08+VRVo33lXUFZwxMya+E55osygcQWdPHNKcEI5yhMO2+2jPscHz3+44jLU/oXBuvt6oaCr1UAT+GFl2gLCyNsUQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NVgABeaoqA1ldpns3i0nZPXtfAh7eyxe8qFMHhfN5nw=;
 b=KTdkBjpWOxGh28RpBc6hRHXAW93/AV5eZMzvPv34DyDIasUuARNPk9TgLNlzGFCjGFWDtoKiakJZ/4KNGpjS87iI+4L3QADF5kAlgceXToXvZLyO5TkLz/bJ46DfkUqUndw4xq4QZ956Ed5Q9la64vr3SkFXd/f/NV0aQIXgTGGvlM/h5l7/caw6hCaGSSvNiNADuP90oVL9dbsN0g12TvZewfZ3N38IWfs8WBXEh21aR0frwltJ295F9yLByXlhx3wkaFxL2hywGhKxXC5XHJ6qqsRy2k/5mPbVNsGWl0cTibtNHlvIlfLcgu7qEE+8zil/jL8rnqs9lNCnp1p7Aw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NVgABeaoqA1ldpns3i0nZPXtfAh7eyxe8qFMHhfN5nw=;
 b=3l7UQIYE09VdTBPZqbwmXvwyVr19+GegpMDSEpl24lT6FaXIBng0oBkqoojhbh2uU1FV4EmuSLHRBckD2pNm1O7p5YyCH3Lns/QJ6vy/+tyzMlgSI+dZs1f7b5tGBAK9D8eOR10KFS+MPbJxhQ55X1nzTrv8ObnSszTUGspf6qU=
Received: from MW4PR12MB6803.namprd12.prod.outlook.com (2603:10b6:303:20e::10)
 by SA0PR12MB7089.namprd12.prod.outlook.com (2603:10b6:806:2d5::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.270.15; Fri, 31 Jul
 2026 03:57:34 +0000
Received: from MW4PR12MB6803.namprd12.prod.outlook.com
 ([fe80::c193:ef2e:260f:dcfd]) by MW4PR12MB6803.namprd12.prod.outlook.com
 ([fe80::c193:ef2e:260f:dcfd%6]) with mapi id 15.21.0270.012; Fri, 31 Jul 2026
 03:57:33 +0000
From: "Feng, Kenneth" <Kenneth.Feng@amd.com>
To: "Wang, Yang(Kevin)" <KevinYang.Wang@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
CC: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Zhang, Hawking"
 <Hawking.Zhang@amd.com>
Subject: RE: [PATCH 0/4] drm/amd/pm: refactor PPT limit runtime policy
Thread-Topic: [PATCH 0/4] drm/amd/pm: refactor PPT limit runtime policy
Thread-Index: AQHdIJov9mhAVgdHZUWKMqAJP90qBbaG//wQ
Date: Fri, 31 Jul 2026 03:57:33 +0000
Message-ID: <MW4PR12MB680320D90AD91DE0DAA5EFAA8EC82@MW4PR12MB6803.namprd12.prod.outlook.com>
References: <cover.1785467079.git.kevinyang.wang@amd.com>
In-Reply-To: <cover.1785467079.git.kevinyang.wang@amd.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Enabled=True;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SetDate=2026-07-31T03:56:41.0000000Z;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Name=AMD General
 v26; MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_ContentBits=3;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Method=Standard
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MW4PR12MB6803:EE_|SA0PR12MB7089:EE_
x-ms-office365-filtering-correlation-id: e3e07aa3-1fe3-4656-b3a1-08deeeb7da15
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|23010399003|1800799024|366016|3023799007|38070700021|10067099003|11063799006|56012099006|18002099003|22082099003|6133799003;
x-microsoft-antispam-message-info: 2QeuW61WBvfnYXF1dVlkR3M7ujywfTv5BbTUN1a0gMlhlSt6qWzf04vKsOOBZ0vaStK3XF6kAKJO3JDqz9hPEGGZqRlYI84qetLhRAqhoolWNnbXBsFZzM2ACCWciUBuZt8jskJMKBLqJmnOhDC4duG5jHBcSo7cLZ7+tPTLLBPRGQ8g3tV5hAdkYgEPmIN/rknfjoJXmCh8cArbNXdB9thj6ezDrSd/I5ZPIL5c4iGdFUZ4B7s4N8uOiZk+jOui7RfoDlf+vl+n959XTqn3DSqf4QQ46owcJt4FraCaR2/m5uiUWF+23YgXNuYrczswxaJ6nOywLqYMF+o6sOurJuZ9UhCp/FFoYh/XpY2XzfbJDJTxTTiRg66gPcN/1AbsMfUpYlVtxpWjZySZL/LsZKH8O5cTbz57+NmyWcs0wT6aNL1rMocrF1q6kLg8cLnbhL6A1uaoz0FGCkBvdMg7NbiYedMdZpOadiY5RH5oJ1Z8ky2gERf5UG2ahHogWW+CH6o/XCQr22Wp/6/jteeMZD9c4M6VUFTYMUvZ0oca9AffQ1N+RyXNMrcoQLPnwwKuVw32JNa00b1H8dvnznQBm3UhTKe6Z7eiOIp0bGEuM7paKcml3T/0fO9k+jE0P6Uv/xQiv8+QXwbibQVfQkCYf/txYfmEtQwS0/35GZTaadTEQ+TPzjj6Xr5naj8whJp09GZntX2rzg/WUe0S6NpbDQ==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MW4PR12MB6803.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(23010399003)(1800799024)(366016)(3023799007)(38070700021)(10067099003)(11063799006)(56012099006)(18002099003)(22082099003)(6133799003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?oj6MY+gc3BGHfoO2H6ZzeUXYNSl7Fj391PqQgCrX/ShitbYCS/Za3Lm88Atu?=
 =?us-ascii?Q?oV+YSFnCVImKSeSfhgYPN4Wtd/csE70+SDPWdA+pDOupQyG9bluQVO4Yu2cq?=
 =?us-ascii?Q?6hpjVVaFCYh7PkaX/RwbZNguaPTQP03P/lKcDLDCvEgFFeoVn/0J5wujQjDJ?=
 =?us-ascii?Q?MdXeeQSVsTQDau7Amgp2fxeyeZjTlulfZ+R4ZqS3D0u8k6HE09BUjPdpQ/Zb?=
 =?us-ascii?Q?rg20W4Hj6c536pqwsWhFID/P+Aa1mNUVKzjeOqQOJvp9D6/BUan9V9q3xEQ9?=
 =?us-ascii?Q?EsQrIjUK8kIjIQC7muxWz/99TpJVoZ2dHhviyeA4c7AbBKnLyAomhyWWDoPd?=
 =?us-ascii?Q?tnd3FqARPku+TY8WMXHQTWDhxwNFEnfgbG1I3V273u1U/UXtec3UnMu7UOfJ?=
 =?us-ascii?Q?pVi12OD9s0zEQCAqqAG6u6kdvyC1ZWH4pjnNHT7JyG6N94azFf7rPSxBKb85?=
 =?us-ascii?Q?Scj+b7eWk4cLo6jRsOW0tvqdT8zs+S5MHov7yP/3YNXJdw0ot+MVWqMCAIzl?=
 =?us-ascii?Q?oCSD/vZ52dtzIWjKLte+i+OXPh4U4NJSM7J8T0jnwOrVGRpSmVcMAinVb/k9?=
 =?us-ascii?Q?nBbiNwg3gH7zjIyUE+mcCdj9luQauLrUavLQ/BM6kmmLRigDtBsjNxKOUoBg?=
 =?us-ascii?Q?/ybCk3m/lpb52cUl5tlmy63/3WN/0DAl6MdfJp+nJoTHZy2bbGasWeHFMvHo?=
 =?us-ascii?Q?9QIru0K1Ey075c9dMjhJufsOaafY7Os3d43VgDg7cs6dC1YS6fvQvLVbRBbt?=
 =?us-ascii?Q?czSYqh55M0JB3ECxZ7qq3Fja6k883M+e08KxlRd7kiU3/ZkG2yN6DSmQa15S?=
 =?us-ascii?Q?o+tZNyYpEIwIXDpCYyrMSpk1zReDTaQofR193IUq16J1lGtkgcnNNhMxgWS0?=
 =?us-ascii?Q?4PnKuLQ8r9Jrmt72T03URiLyzeg0HLv3rog/CB3UtVJ6SYzxjloGKNaFQ3IY?=
 =?us-ascii?Q?TSN1WvUN78rTEZ05y3bVmJeNcR9EvD1mXuuJURLGcoFMfsMclH+KxjAtyoGz?=
 =?us-ascii?Q?6PXuwtlYhqcrDv+SCePKaRTC/ZCPXDs4Yo7pH4DfDKZK5dcMa5cxb4ufxYGO?=
 =?us-ascii?Q?dAR6JWpShBTBzv9o+BNfDXeyOEBgYbXM+P18zkW1zI3p8V7v5oZBXbpJnwro?=
 =?us-ascii?Q?KN6qR4sBFYT3YsIqo8eV5AXixllGTJKI5Ze2Q5ZVUjmCXW2flFIUKesnKmJ5?=
 =?us-ascii?Q?l0V3ad4JTME0EryyJi35Jzl8Z/Bbh1kswpGYnz3cNqwU9l64yHxTl8rX3sXR?=
 =?us-ascii?Q?yEoD3JA5Y8fcebZh3FVLIBJ7S+/B2W/uVryhQykD2D7juVYNcYApBL1VTh98?=
 =?us-ascii?Q?1H9ucvJSmO1WMRYI+KnOi2MQf87h4DI1D0G7m6+ZP0qaNqVHTC2qiVbrMlKT?=
 =?us-ascii?Q?LtvfH9be63C/WonRXcjlrSSjJeX0GDZxV+dGYGbMqgFujw4+kGybY7QOWUqZ?=
 =?us-ascii?Q?TBFpOFWSHbP7t3SJLMPoEcLuAukLDjiVMMWgRfvmrwPr2EhrSVfwjiXYWdND?=
 =?us-ascii?Q?Jf0sNTojLHFkd+7ffqAxMj2ypKjgVDRW3jv9POQZgjuUpyjHoGeWg1Cg08TS?=
 =?us-ascii?Q?zfrCgmo2/6SdHadIO62mpBhFaxfqDTGlxrhE7ldrswr8H2d0u5y3NvU2IO4h?=
 =?us-ascii?Q?h2CZl4s1hfHU9ij2tbJkEJTo11R3VqWs1bDMshmvgG2lHCOkQyXdibFTg25c?=
 =?us-ascii?Q?JzbLhGyRNMzEfgRGIUC4/U00eKQuf9lvPfhoiQR4AAFZQEkF?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW4PR12MB6803.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e3e07aa3-1fe3-4656-b3a1-08deeeb7da15
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 Jul 2026 03:57:33.7898 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: aefbiP/D0L2/mJCuMrugtx1Ek0RqAnbB56ggKbOpQc3EawQMKZWwviToPthnQJ4C
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB7089
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


-----Original Message-----
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Yang Wan=
g
Sent: Friday, July 31, 2026 11:10 AM
To: amd-gfx@lists.freedesktop.org
Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Zhang, Hawking <Hawking=
.Zhang@amd.com>; Feng, Kenneth <Kenneth.Feng@amd.com>
Subject: [PATCH 0/4] drm/amd/pm: refactor PPT limit runtime policy

PPT limit handling combines controller identity, AC/DC source, immutable ca=
pabilities, PMFW runtime state, and persistent user policy in scalar state.=
 This prevents the driver from representing PPT0/PPT1 independently and lea=
ves user limits vulnerable to PMFW reset.

The runtime model requires separate ownership for each class of data:

- PPTable-derived ranges define normal and OD capabilities.
- PMFW messages and tables define the effective runtime limit.
- Common user-profile state defines persistent policy by source and
  controller.

The four patches establish these boundaries:

- Index common ranges by AC/DC source and PPT0/PPT1 controller; pass the
  controller through get and set callbacks.
- Account for PMFW protocols that represent an effective limit as a
  message base plus an OD percentage.
- Save user values and validity masks by source and controller; restore
  them after suspend and live AC/DC transitions.
- Restore the saved PPT policy after GPU reset reinitializes PMFW and the
  platform power table.

The resulting policy preserves explicit user limits without caching mutable=
 PMFW current values.

Yang Wang (4):
  drm/amd/pm: refactor PPT limits by controller and power source
  drm/amd/pm: account for OD percentage in effective PPT limits
  drm/amd/pm: refactor user PPT policy save and restore
  drm/amd/pm: restore user PPT limits after GPU reset

 drivers/gpu/drm/amd/pm/amdgpu_dpm.c           |   2 +-
 drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c     | 222 ++++++++++--------
 drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h |  63 ++---  drivers/gpu/drm=
/amd/pm/swsmu/inc/smu_v11_0.h  |  15 +-  drivers/gpu/drm/amd/pm/swsmu/inc/s=
mu_v13_0.h  |  11 +-  drivers/gpu/drm/amd/pm/swsmu/inc/smu_v14_0.h  |  11 +=
-  drivers/gpu/drm/amd/pm/swsmu/inc/smu_v15_0.h  |  11 +-  .../gpu/drm/amd/=
pm/swsmu/smu11/arcturus_ppt.c |  52 ++--
 .../gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c   |  78 +++---
 .../amd/pm/swsmu/smu11/sienna_cichlid_ppt.c   | 122 +++++-----
 .../gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c    |  23 +-
 .../gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c  | 118 ++++------
 .../drm/amd/pm/swsmu/smu13/aldebaran_ppt.c    |  93 ++++----
 .../gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c    |  23 +-
 .../drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c  | 123 ++++++----  .../drm/am=
d/pm/swsmu/smu13/smu_v13_0_6_ppt.c  | 124 +++++-----  .../drm/amd/pm/swsmu/=
smu13/smu_v13_0_7_ppt.c  | 123 ++++++----
 .../gpu/drm/amd/pm/swsmu/smu14/smu_v14_0.c    |  23 +-
 .../drm/amd/pm/swsmu/smu14/smu_v14_0_2_ppt.c  | 123 ++++++----
 .../gpu/drm/amd/pm/swsmu/smu15/smu_v15_0.c    |  23 +-
 .../drm/amd/pm/swsmu/smu15/smu_v15_0_8_ppt.c  | 122 +++++-----
 drivers/gpu/drm/amd/pm/swsmu/smu_internal.h   |   3 +-
 22 files changed, 792 insertions(+), 716 deletions(-)

--
2.54.0
