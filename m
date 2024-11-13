Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 03B9AD41C17
	for <amd-gfx@archiver.kernel.org>; Wed, 13 Nov 2024 08:35:26 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A9E1F10E692;
	Wed, 13 Nov 2024 08:35:25 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="C74gpjtt";
	dkim-atps=neutral
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2041.outbound.protection.outlook.com [40.107.237.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7AA3110E692
 for <amd-gfx@lists.freedesktop.org>; Wed, 13 Nov 2024 08:35:23 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=y5g9vuFb3db5HKkLhxBTsEiGNpvL5pqH3pFywfhVNKVDOdi+I6ZuX3RRwutmYEYtxAqUp6Hw+buIcBbzSa5vfcSY2T5f8AmccY8YLJqWQfnKuKbgoY0ohukIo5lH0mTxX6eGogZlVtyrB8v+Yww7G+jD5x/6MiUbj27pYzvbqCexLmrB8/S/FwTSb2M0jZqgzOdP9JQvTAhF0775dj+YMQoQ3WZ/sb5FzuRTtG5f8Bx4pe14GMHuZDoHw1mxYrI18u2bcphv+WsieLCaoT+mcL5ZGELpNPckJbBmGLI+cP9ae0Xx8tOtB+I0zwWrBJ+GsfPDZu13q512rqBaulOPow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1Biv8KqWT63wEQp7zlGT3hghqR4E44AbKBi8aXQlMTw=;
 b=hU+B7KnGtU5r9sk6DuP03OCpM8Od1yyy8xJ0cydvbY8VvRtWR8KXUZAGJrlNXHu/sYCwAr379yEsu3a8i+cGYvVfAm0ihN0RwOd5CEK1360lRwYnk0SljfXMKZkk7XZon7on4SyDLM6oUt4OJ5BC/1lDbuZLdbkgg9PVlG1ILfxCBDuMC5gcsS2qQDVZbODtF9X/yoGqPohbeKWhQtCoABUj0SUMvmopu3jsVXh6lDuUUceVNXTTMffS1foX2gmoRPrxZUMvRdK5kIQuEWviCnHBhnjKVhUljzdcjDICWvUOWUtjgTJPMKQzFrHnvTjzUPbQdOEuZoDw2hKoR9PU0Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1Biv8KqWT63wEQp7zlGT3hghqR4E44AbKBi8aXQlMTw=;
 b=C74gpjttdGYGCtMwZDYSmiW055eVCv/QwTMXQP4EH+agfjd5SjqTcgeBApbXFHxJQy/okmodaDpxdQoywn2ZL5K6paAs774W56LQkemckwElDlX/lyOS0naprSf+feVsHcchUIEJhHmIuMMKMRfP5qBziG5UCo8Un1ny42wjfvg=
Received: from PH7PR12MB5997.namprd12.prod.outlook.com (2603:10b6:510:1d9::21)
 by SJ0PR12MB7460.namprd12.prod.outlook.com (2603:10b6:a03:48d::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.17; Wed, 13 Nov
 2024 08:35:16 +0000
Received: from PH7PR12MB5997.namprd12.prod.outlook.com
 ([fe80::c5da:9b53:9d77:c708]) by PH7PR12MB5997.namprd12.prod.outlook.com
 ([fe80::c5da:9b53:9d77:c708%5]) with mapi id 15.20.8137.027; Wed, 13 Nov 2024
 08:35:16 +0000
From: "Wang, Yang(Kevin)" <KevinYang.Wang@amd.com>
To: "Kamal, Asad" <Asad.Kamal@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>, "Lazar, Lijo" <Lijo.Lazar@amd.com>
CC: "Ma, Le" <Le.Ma@amd.com>, "Zhang, Hawking" <Hawking.Zhang@amd.com>,
 "Zhang, Morris" <Shiwu.Zhang@amd.com>, "Kamal, Asad" <Asad.Kamal@amd.com>,
 "Poag, Charis" <Charis.Poag@amd.com>, "Cheung, Donald"
 <donald.cheung@amd.com>, "Khatir, Sepehr" <sepehr.khatir@amd.com>, "Oliveira, 
 Daniel" <Daniel.Oliveira@amd.com>
Subject: RE: [PATCH v2 1/2] drm/amd/pm: Add gpu_metrics_v1_7
Thread-Topic: [PATCH v2 1/2] drm/amd/pm: Add gpu_metrics_v1_7
Thread-Index: AQHbNaWL8E5fQEJ6Yka8ScSQF6spYrK04VMg
Date: Wed, 13 Nov 2024 08:35:15 +0000
Message-ID: <PH7PR12MB59973BB070739B0B011380EF825A2@PH7PR12MB5997.namprd12.prod.outlook.com>
References: <20241113082433.1308830-1-asad.kamal@amd.com>
In-Reply-To: <20241113082433.1308830-1-asad.kamal@amd.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ActionId=f34722d0-78bd-47c9-bef5-236feac50b3b;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=0;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=true;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution Only;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2024-11-13T08:30:35Z;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR12MB5997:EE_|SJ0PR12MB7460:EE_
x-ms-office365-filtering-correlation-id: 77b1dc64-2762-4332-dc1f-08dd03be1948
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|366016|376014|1800799024|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?2rDmfPVc58+wZEwodpOQbva3WQ6C5QJW88UpAYayWslET3TeMTVoTPa3ROgF?=
 =?us-ascii?Q?8AkX8MbyeWsvJdCOIu2TbGHsFrhJDJ3vlEPo7KUeE+b1EGORj/oq+0Ww4AHx?=
 =?us-ascii?Q?u0JE5XUWQ1t5RTBHDBzgNf7N/cdI4JPAb9H73Dij8ekgDpAInivs1nrDgqKo?=
 =?us-ascii?Q?kBUATSh5nROj0dRvzw4hxn6uow7uiFRIgZ0gt68XXtOTWlEwchYnXNosdiO1?=
 =?us-ascii?Q?/vredQ2pJOS9YB+xWaLMM6tStW4bdoXorM5fGd1eZEiebXwTAVy+fjgg4PlS?=
 =?us-ascii?Q?mCUpiuxQZy3F/q7y9QqhN1RxQpoQbroYOgzv98dBMeHDBbBMkB1AsFDcuU5L?=
 =?us-ascii?Q?/7Jg3S98VOSUx2b4qZU+lhhzMlHnuoCQcajdCI1GmAZaGQGCVBliIyprVeW/?=
 =?us-ascii?Q?n3RxsYEmqDX41wXADcWh7VcuJk7SxsXELk33pRybWNnhSgMnB9jbvUoi9GEC?=
 =?us-ascii?Q?MDvzBjEQaaXxGxN1qdZ5YdCq/dLlDxJjo3FkQAwL+SxmvmxV37y6at/+WMec?=
 =?us-ascii?Q?65zBcR3Ht2BcLukMqIoPN9FaC33tPCtXCbukwExaBu+p+kR8jauSPMYXYQDN?=
 =?us-ascii?Q?HOgAdN6P7frMrBsO82/og/il0X0KYBLzvvAFH3LjgUo+41F2KDDtFQchvfB6?=
 =?us-ascii?Q?/l0fK4QwIvilVroezbKaut2lYZmwHccKj2DFzMVh3N//6kgoCSdnGJHOm4cV?=
 =?us-ascii?Q?n7UrZ7bNc4RHkIH5jUOrshbBbfdxFVHwbwGMX4gdgA85jxhgTWVmaemrozz+?=
 =?us-ascii?Q?Ga6nOftvJQOzYzULpX2op92Kz3LVFri37A7jJSMGg2zjcJ/9txDdZ3jHK6jo?=
 =?us-ascii?Q?w3gUh1RVWkAxBjlKudR+6txTDUxPdY4WZ+g37Fu+5bjnJpjaSxsoF/hsu4az?=
 =?us-ascii?Q?bfa4XaGZ1SBUYNJkvAe7oupMx4K532fKQ78/oyXSWisMhVl6wdasB0LeogL6?=
 =?us-ascii?Q?F/d4CDazk68vAnoKG9p/KTn0Eh4zeV2Rrp+AiPRAYj29I2prknyq2a2WOx3P?=
 =?us-ascii?Q?2Ujm6ChZ1nl4WSWZsFZuxgVTaIh94AngjiEyM2dPN0dqpc6jqBBN7VWfbXlD?=
 =?us-ascii?Q?n+N7ZfY7p6EoPUmLX9Q8ChS+X1zhXC2bdwhLINh2+FohDIBFWw3Yo6d/ywZR?=
 =?us-ascii?Q?JZkqSix9iKngrxP5DAg77xQwmYLEbWzKfy+F9Deh4K6kMZjS47cPM10I58sW?=
 =?us-ascii?Q?sIhUKzOW2AdbPgO0PR23P72vs/LOLT88okIkFKpUdPxx5KmxHENaPZDQPsYx?=
 =?us-ascii?Q?gVwz8JqCEwg/XdyzWAEaXnXTKHhO7CQf5RPZg3fUe4XPnOs6iMwbnVVbn/hI?=
 =?us-ascii?Q?H4U6+092CtWk9FvTkMoqtDAiCGoe1phPuyVlsPZuRC8xuWlC1STctf7wzw9Z?=
 =?us-ascii?Q?0vNu4ZI=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5997.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(38070700018); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?eoYf2LbSmzwux3TACicfMgLcjmKu8Fa1r9T1oI0ibmN8vYy61U3wYtTBiMDp?=
 =?us-ascii?Q?OLfZU1vBQ0w/APHaZ1huOQRtu+5Iz9Pk7EosbdklG4VudsMqS++sva3Iy2xh?=
 =?us-ascii?Q?pr4F9NclMK3KbymODEoszzGaiJfcWahUB+OC0wS2R9KHVQnmI1pNVOPx7fG6?=
 =?us-ascii?Q?dpTlquYPa68Cetz2GgmIgF4io9WMHrLu2MBAXZ1CLd3luhFkNioqEkyGjH0h?=
 =?us-ascii?Q?d6yM0pDPv9ahSocRGXeWjFHKaHtqHwbugv3k7jcb7O8nY9STX9CNR6UQ+chd?=
 =?us-ascii?Q?zj9byXodwwQJ5ybcIEkYqLTg2HbPDqg/E/LdyEyQi/mb8VXkDaUi1loUixbV?=
 =?us-ascii?Q?zIQt+FIbNK1wGLcVPhMzbJwUoAVl4LvFvcgDQOTGXv+6UzqIv3bbFV6XRmsM?=
 =?us-ascii?Q?7B/9UWxMYZGKCh7ttZ5mZw5rUnFUWMH07uIjuDVVU9LfMvXMeV0vIU1Fba+z?=
 =?us-ascii?Q?DFEIXXHQy2DXK/PsuH5Y1//XHlZsiBkLEQhyTnMiCUGxTs7sLNxuAcgeuJHF?=
 =?us-ascii?Q?kJJnLXgaA2J9O8FvuTG171cS6PgNaWNHT2iFPVN+VBL97QLk2Z57y+kmnD0F?=
 =?us-ascii?Q?l7rlYof2gPj1aU+YMYW8BVHL+LynafCUh9oFYqYealWrGCwA7d13rG6JkaKC?=
 =?us-ascii?Q?PJ/1q4xLQp2Je8xeOUdcsCK4kVSRQW+mfC+lBwqW2i6ocxhcV4PRjm1YGFu9?=
 =?us-ascii?Q?LFqgXqKp3jNz1X/MO7RvaMYxe9k7DzSoTI70PgBuO7zVbb+cS4SIOKdHCdJH?=
 =?us-ascii?Q?CC9AIEROjjnKvIxa7tuhjpnRLZT3K0fLMEfhg+5YDP5lkFa6zGg5ruZJeFBV?=
 =?us-ascii?Q?oy2uO+ysOZDui+PY6+qBwHmmjdzVvYA61wklql0+CbuvmTB5/iZuJlAZm5nI?=
 =?us-ascii?Q?KlpNMztiuuti8DCTYd8Ozq7o668KNdVVQH9HDkYBYYw5Tudrrla6qkFsl264?=
 =?us-ascii?Q?Eg5aa1PtPljd2lgskgp1oL2TG6KFmBl7USq5t6EWb8rIJDtrAeJWPG/Z/Gik?=
 =?us-ascii?Q?GnbMAC3JQAwGA6K7Tc4V12ydy1BH3XVIo0r3GD3WZxdb2bzIaUa2E942Emwe?=
 =?us-ascii?Q?SzcSdthwcgeMGiOp+BLMakeqxdtlzG5Agv+JloZK82+zf9cWWAKN5hC+eYAG?=
 =?us-ascii?Q?DERXS+ZvMIZ9RSEcILXz9v2ZA+H7BaFWBJdpYIGRlcxW1VUspKHheiXVlrgA?=
 =?us-ascii?Q?ZTL3kZtVb+C4NVGArL89Ac/YKCbpilRQ5YdboS1cc1UkdL/qbe1JdwShT8UQ?=
 =?us-ascii?Q?9LUpAsZiIBwzMnnqT523M6k4foWHKmc1Ws/UE82QFlyz7xQt/8tL9YFAopR6?=
 =?us-ascii?Q?GhxivC4kikz12zmXQFovKKzAiJD7WtLmrv2U3cExmuBOCvqKzfm+vbNp7uew?=
 =?us-ascii?Q?P4naxLC/KuBx38dYBP+Hkaf61D/UBVgOMQeLPEciaA6OrlFYajAN5LMHBv4R?=
 =?us-ascii?Q?7YhUHXJL4KBLkAHNASsiIwpPXNOyJN0vS9zwP2CPTnTHnkQUw+kLYUZ4zPIC?=
 =?us-ascii?Q?j5eFgeIxkcMPvYPo0AG6fEtgJkuHuIjB1fHe2hpreu9ZvA10NfdUsinm++lW?=
 =?us-ascii?Q?f9+nM2lN7ntLlh/shvo=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5997.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 77b1dc64-2762-4332-dc1f-08dd03be1948
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Nov 2024 08:35:15.9308 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: YSSi5rZvz0tiW+uHghOud5zXxS99lN0NmcWf00GnSNyjqBZ7g1pe3e0fC16ASe/C
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB7460
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

-----Original Message-----
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Asad Kam=
al
Sent: Wednesday, November 13, 2024 16:25
To: amd-gfx@lists.freedesktop.org; Lazar, Lijo <Lijo.Lazar@amd.com>
Cc: Ma, Le <Le.Ma@amd.com>; Zhang, Hawking <Hawking.Zhang@amd.com>; Zhang, =
Morris <Shiwu.Zhang@amd.com>; Kamal, Asad <Asad.Kamal@amd.com>; Poag, Chari=
s <Charis.Poag@amd.com>; Cheung, Donald <donald.cheung@amd.com>; Khatir, Se=
pehr <sepehr.khatir@amd.com>; Oliveira, Daniel <Daniel.Oliveira@amd.com>
Subject: [PATCH v2 1/2] drm/amd/pm: Add gpu_metrics_v1_7

Add new gpu_metrics_v1_7 to acquire xgmi link status, application counter a=
nd max vram bandwidth

v2: Use gpu_metrics_v1_7 for SMU_v_13_0_6 (Lijo)

Signed-off-by: Asad Kamal <asad.kamal@amd.com>
Reviewed-by: Lijo Lazar <lijo.lazar@amd.com>
---
 .../gpu/drm/amd/include/kgd_pp_interface.h    | 110 ++++++++++++++++++
 .../drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c  |   8 +-
 drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c        |   3 +
 3 files changed, 117 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/include/kgd_pp_interface.h b/drivers/gpu/d=
rm/amd/include/kgd_pp_interface.h
index ee8170cda1d7..a95935cc3d76 100644
--- a/drivers/gpu/drm/amd/include/kgd_pp_interface.h
+++ b/drivers/gpu/drm/amd/include/kgd_pp_interface.h
@@ -364,6 +364,17 @@ struct amdgpu_xcp_metrics {
        u64 gfx_busy_acc[MAX_XCC];
 };

+struct amdgpu_xcp_metrics_v1_1 {
+       /* Utilization Instantaneous (%) */
+       u32 gfx_busy_inst[MAX_XCC];
+       u16 jpeg_busy[NUM_JPEG_ENG];
+       u16 vcn_busy[NUM_VCN];
+       /* Utilization Accumulated (%) */
+       u64 gfx_busy_acc[MAX_XCC];
+       /* Total App Clock Counter Accumulated */
+       u64 gfx_below_host_limit_acc[MAX_XCC];
+};
[kevin]:

It is better to change the type to 'uint64/32/16_t' (stdint.h) to indicate =
that it is a uapi interface.

With fixed,

Reviewed-by: Yang Wang <kevinyang.wang@amd.com>

Best Regards,
Kevin
+
 struct amd_pm_funcs {
 /* export for dpm on ci and si */
        int (*pre_set_power_state)(void *handle); @@ -979,6 +990,105 @@ str=
uct gpu_metrics_v1_6 {
        uint32_t                        pcie_lc_perf_other_end_recovery;
 };

+struct gpu_metrics_v1_7 {
+       struct metrics_table_header     common_header;
+
+       /* Temperature (Celsius) */
+       uint16_t                        temperature_hotspot;
+       uint16_t                        temperature_mem;
+       uint16_t                        temperature_vrsoc;
+
+       /* Power (Watts) */
+       uint16_t                        curr_socket_power;
+
+       /* Utilization (%) */
+       uint16_t                        average_gfx_activity;
+       uint16_t                        average_umc_activity; // memory con=
troller
+
+       /* VRAM max bandwidthi (in GB/sec) at max memory clock */
+       uint64_t                        mem_max_bandwidth;
+
+       /* Energy (15.259uJ (2^-16) units) */
+       uint64_t                        energy_accumulator;
+
+       /* Driver attached timestamp (in ns) */
+       uint64_t                        system_clock_counter;
+
+       /* Accumulation cycle counter */
+       uint32_t                        accumulation_counter;
+
+       /* Accumulated throttler residencies */
+       uint32_t                        prochot_residency_acc;
+       uint32_t                        ppt_residency_acc;
+       uint32_t                        socket_thm_residency_acc;
+       uint32_t                        vr_thm_residency_acc;
+       uint32_t                        hbm_thm_residency_acc;
+
+       /* Clock Lock Status. Each bit corresponds to clock instance */
+       uint32_t                        gfxclk_lock_status;
+
+       /* Link width (number of lanes) and speed (in 0.1 GT/s) */
+       uint16_t                        pcie_link_width;
+       uint16_t                        pcie_link_speed;
+
+       /* XGMI bus width and bitrate (in Gbps) */
+       uint16_t                        xgmi_link_width;
+       uint16_t                        xgmi_link_speed;
+
+       /* Utilization Accumulated (%) */
+       uint32_t                        gfx_activity_acc;
+       uint32_t                        mem_activity_acc;
+
+       /*PCIE accumulated bandwidth (GB/sec) */
+       uint64_t                        pcie_bandwidth_acc;
+
+       /*PCIE instantaneous bandwidth (GB/sec) */
+       uint64_t                        pcie_bandwidth_inst;
+
+       /* PCIE L0 to recovery state transition accumulated count */
+       uint64_t                        pcie_l0_to_recov_count_acc;
+
+       /* PCIE replay accumulated count */
+       uint64_t                        pcie_replay_count_acc;
+
+       /* PCIE replay rollover accumulated count */
+       uint64_t                        pcie_replay_rover_count_acc;
+
+       /* PCIE NAK sent  accumulated count */
+       uint32_t                        pcie_nak_sent_count_acc;
+
+       /* PCIE NAK received accumulated count */
+       uint32_t                        pcie_nak_rcvd_count_acc;
+
+       /* XGMI accumulated data transfer size(KiloBytes) */
+       uint64_t                        xgmi_read_data_acc[NUM_XGMI_LINKS];
+       uint64_t                        xgmi_write_data_acc[NUM_XGMI_LINKS]=
;
+
+       /* XGMI link status(active/inactive) */
+       uint16_t                        xgmi_link_status[NUM_XGMI_LINKS];
+
+       uint16_t                        padding;
+
+       /* PMFW attached timestamp (10ns resolution) */
+       uint64_t                        firmware_timestamp;
+
+       /* Current clocks (Mhz) */
+       uint16_t                        current_gfxclk[MAX_GFX_CLKS];
+       uint16_t                        current_socclk[MAX_CLKS];
+       uint16_t                        current_vclk0[MAX_CLKS];
+       uint16_t                        current_dclk0[MAX_CLKS];
+       uint16_t                        current_uclk;
+
+       /* Number of current partition */
+       uint16_t                        num_partition;
+
+       /* XCP metrics stats */
+       struct amdgpu_xcp_metrics_v1_1  xcp_stats[NUM_XCP];
+
+       /* PCIE other end recovery counter */
+       uint32_t                        pcie_lc_perf_other_end_recovery;
+};
+
 /*
  * gpu_metrics_v2_0 is not recommended as it's not naturally aligned.
  * Use gpu_metrics_v2_1 or later instead.
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c b/drivers=
/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
index fa30a9e1f27a..11ecaa62f419 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
@@ -370,7 +370,7 @@ static int smu_v13_0_6_tables_init(struct smu_context *=
smu)
                return -ENOMEM;
        smu_table->metrics_time =3D 0;

-       smu_table->gpu_metrics_table_size =3D sizeof(struct gpu_metrics_v1_=
6);
+       smu_table->gpu_metrics_table_size =3D sizeof(struct gpu_metrics_v1_=
7);
        smu_table->gpu_metrics_table =3D
                kzalloc(smu_table->gpu_metrics_table_size, GFP_KERNEL);
        if (!smu_table->gpu_metrics_table) {
@@ -2321,8 +2321,8 @@ static ssize_t smu_v13_0_6_get_gpu_metrics(struct smu=
_context *smu, void **table  {
        bool per_inst, smu_13_0_6_per_inst, smu_13_0_14_per_inst, apu_per_i=
nst;
        struct smu_table_context *smu_table =3D &smu->smu_table;
-       struct gpu_metrics_v1_6 *gpu_metrics =3D
-               (struct gpu_metrics_v1_6 *)smu_table->gpu_metrics_table;
+       struct gpu_metrics_v1_7 *gpu_metrics =3D
+               (struct gpu_metrics_v1_7 *)smu_table->gpu_metrics_table;
        bool flag =3D smu_v13_0_6_is_unified_metrics(smu);
        int ret =3D 0, xcc_id, inst, i, j, k, idx;
        struct amdgpu_device *adev =3D smu->adev; @@ -2341,7 +2341,7 @@ sta=
tic ssize_t smu_v13_0_6_get_gpu_metrics(struct smu_context *smu, void **tab=
le

        metrics_a =3D (MetricsTableA_t *)metrics_x;

-       smu_cmn_init_soft_gpu_metrics(gpu_metrics, 1, 6);
+       smu_cmn_init_soft_gpu_metrics(gpu_metrics, 1, 7);

        gpu_metrics->temperature_hotspot =3D
                SMUQ10_ROUND(GET_METRIC_FIELD(MaxSocketTemperature, flag));=
 diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c b/drivers/gpu/drm/amd/=
pm/swsmu/smu_cmn.c
index fd2aa949538e..a9e69d321f8c 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c
@@ -1081,6 +1081,9 @@ void smu_cmn_init_soft_gpu_metrics(void *table, uint8=
_t frev, uint8_t crev)
        case METRICS_VERSION(1, 6):
                structure_size =3D sizeof(struct gpu_metrics_v1_6);
                break;
+       case METRICS_VERSION(1, 7):
+               structure_size =3D sizeof(struct gpu_metrics_v1_7);
+               break;
        case METRICS_VERSION(2, 0):
                structure_size =3D sizeof(struct gpu_metrics_v2_0);
                break;
--
2.46.0

