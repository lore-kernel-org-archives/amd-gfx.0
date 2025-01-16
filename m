Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 40833C02183
	for <amd-gfx@archiver.kernel.org>; Thu, 16 Jan 2025 23:23:01 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E69D810EA24;
	Thu, 16 Jan 2025 23:23:00 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="rTYBdL1U";
	dkim-atps=neutral
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2047.outbound.protection.outlook.com [40.107.243.47])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6F37910EA24
 for <amd-gfx@lists.freedesktop.org>; Thu, 16 Jan 2025 23:22:59 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=m3d02/5nQ6aQuLSTxjJOHLi7W1oUoDn2IkJ+krHuEGDUVFQlDFqJe/7G3ErW56m0p4qplScya3P6YNMkN3qJVKA51TGR9Xozi6gtKF80rZvY1ODf4dXlnDAiRUbZhwVUQy29DHNVCSW05piVm7XC/kNU7Hik9xioJf/3VtIMQIKWq/Vj2mV0sK9wMlI+4n/OsgtE/dQ8aHi+S2FWeJVGOrUcZNIYnSBNHcLHh7nLydCsziKgYgzxTR2oSzkvc5cNEgg04uNg1jJiyb1pfdpEBPyfGFL8AkumR3yMw5VXEz1pPrhBiPO4J2rY+g32x1r8neDh8ate39P2+/acG0cVew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bOdMVWumsVv2IkvxOgqXu0i0u7IYMrXDKkdcgOC+nWc=;
 b=mIIbzRoJB3Ay1JtoBow4jOKYWkV/sQ8GVdGJQeX0wzCYqEp6fX0p+drXydmy8/FpUPai1YHH0Ny7Trcm8ucLsUQKz6appJI6KoNFFwxHwBY6PBNi1k2Pb4Os7PJY5BLUqUkTo7ZiTsCX31Bh1DeJkF/fIzRzq1vIt805q4QOpSF18M/JxxrmwfF0gXSjB5Bt5xsnWVAZH7D6Ai/B8o98gxa1M/j/9D4Ns6ZB7dOXjteKPvv/jPwmvD282VbhYp6l/0MxQhpqDK0UMMEKIQ3XQdKYafve3SRjbq1PrKJGk9xoiXybGroU3RHrq14Ud+3l098uG6UDfeYptaU16nkHVg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bOdMVWumsVv2IkvxOgqXu0i0u7IYMrXDKkdcgOC+nWc=;
 b=rTYBdL1UREJIq2REtCc/mgrDCbeYUbCfOlLTas+6cLfnUiizx6kNIrO7UMu2Md75ZKTkHyNqnx2eQYeYtwIp9QxzsHuy0Bnb2EBXyNofxXpj4TDnUFSrNStB5BXh5QKg1sm97g8f6qiuLxB1R3eRuTV2okHXOwdZW+pd5SqJZ6s=
Received: from PH7PR12MB5997.namprd12.prod.outlook.com (2603:10b6:510:1d9::21)
 by CYYPR12MB8855.namprd12.prod.outlook.com (2603:10b6:930:bb::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8356.14; Thu, 16 Jan
 2025 23:22:57 +0000
Received: from PH7PR12MB5997.namprd12.prod.outlook.com
 ([fe80::c5da:9b53:9d77:c708]) by PH7PR12MB5997.namprd12.prod.outlook.com
 ([fe80::c5da:9b53:9d77:c708%4]) with mapi id 15.20.8356.010; Thu, 16 Jan 2025
 23:22:56 +0000
From: "Wang, Yang(Kevin)" <KevinYang.Wang@amd.com>
To: "Lazar, Lijo" <Lijo.Lazar@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
CC: "Zhang, Hawking" <Hawking.Zhang@amd.com>, "Deucher, Alexander"
 <Alexander.Deucher@amd.com>, "Kamal, Asad" <Asad.Kamal@amd.com>
Subject: RE: [PATCH] drm/amd/pm: Add capability flags for SMU v13.0.6
Thread-Topic: [PATCH] drm/amd/pm: Add capability flags for SMU v13.0.6
Thread-Index: AQHbaBJKfdW1ZUUKlU6hhFLX7BjD1bMaCu7A
Date: Thu, 16 Jan 2025 23:22:56 +0000
Message-ID: <PH7PR12MB5997E677160E80D55CCE8034821A2@PH7PR12MB5997.namprd12.prod.outlook.com>
References: <20250116122908.1451094-1-lijo.lazar@amd.com>
In-Reply-To: <20250116122908.1451094-1-lijo.lazar@amd.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ActionId=dc7f78ea-bec4-4245-a8d1-2ae824928285;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=0;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=true;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution Only;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2025-01-16T23:22:40Z;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR12MB5997:EE_|CYYPR12MB8855:EE_
x-ms-office365-filtering-correlation-id: 970c5580-21ab-4437-b309-08dd3684b5ae
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|38070700018|7053199007; 
x-microsoft-antispam-message-info: =?us-ascii?Q?URd5iSEirlsn0WleuuTrEIBzNuNOU+oilLwFeXaCQrK90rcJow/Ko5tYoNhR?=
 =?us-ascii?Q?XWWzZ/c8wfPRaR8Pewn/xyjjRDYtgDhx3MuNU+Qz+3qSQLsxwCdg9IlK6Xjj?=
 =?us-ascii?Q?X5FfIpDuLf7dR+QlNLxmpLob4y0MXDoF7Z1n3J9bMfvLz/YSoLeedh+hswuZ?=
 =?us-ascii?Q?Aoa0+IiKJr3wmAcOneSwvjp516flJF5TnH4liGb3+cqnXqXzOa0diCZBSZFw?=
 =?us-ascii?Q?xx5wQBSUe2iU6aoKFlw6nvBSqhF6g8gnPltgwZ6KiIUH+CnKEoTfOee2ioAE?=
 =?us-ascii?Q?rLK6qRVE0wixwI/S+UZ2XLRyItngTpfSQASXuWtirwpL67Uqo2D9DZTJFV8R?=
 =?us-ascii?Q?jfJGOEKhVh9LWD9UjM3pPCLuAZYZ6NHNahrjgRhSNQz/C+22OhDD0UdE9+1E?=
 =?us-ascii?Q?MaNOUiDfWK9yxNNOArn/k99c7UkLjRtgE91dVRJpfD1+ezrGAGLHKAsmC85G?=
 =?us-ascii?Q?CNr+I+6CdH+4kdh13tQGfkhMhw3pHDO/c1/INLf3UG39Z5SXLyG+TcRU2Hl9?=
 =?us-ascii?Q?AH30unJNKQ+06Xi3o6eLDSRM3lfWj3JqPFjzNWEU91b7wuXlqlu4C/L9jAuj?=
 =?us-ascii?Q?7Dq5TxgKBZKDkp1SGY3agaEMXOctE0woiqp6I4xfAkdtUh1HZfO7xUtQ3Rhx?=
 =?us-ascii?Q?JaEZ2/e1XhFqnoyUMqtw9vWxMf3IrwUTtOjKL3oBMEWmm6Pf0/NfvCxZzkYJ?=
 =?us-ascii?Q?GHcHSjxXnvXoCirNSPy8N48gKiXpe7DUWGwCKlD0HHre3wv07qwzOkD84i3J?=
 =?us-ascii?Q?Xu1fzNf2Y2eYTz+g5dyFgG06vHkTdVRF0bsFRltP7yjlpgorfq92ruCavURQ?=
 =?us-ascii?Q?nTqRNyEhckHkhFldPvT/D0MDYG9gvt8MsrYPN861yE+85u+m3nmTg55RaNQT?=
 =?us-ascii?Q?8M4sX34l8AMSzn0Ht3CiXLBNjJG7Ql/1ZN2brpEx+qhifp6P23MbLLMyT6WR?=
 =?us-ascii?Q?tX4DFyQIE+5F8AR/2i6aOvuLQrrgWNozYwtzIZc1panny9/Tctrh5KE/Um/z?=
 =?us-ascii?Q?jI/ICFBkIZvKOVhWsewhopNhHsP6cFENNghLz0UTaTucQ6+y0fi5WjVTr0EY?=
 =?us-ascii?Q?aj/zc5s5+q/x0eRZhVQItkkpq8dcvvc3OWTHJmwCs9KaTYmxSEKpTrpz/+UI?=
 =?us-ascii?Q?oxXYtXoMWVI0KeY/puB2y8fhKz4qigZU3RY+aYhckx2zS0FQVm2NumFQg5Ej?=
 =?us-ascii?Q?Aw3XwuOwWpkD7OYGknrXCsDkwnnvi+J/Xy3c9bxa/KLLh86NdHFBrhm2oKJS?=
 =?us-ascii?Q?PRWdSFjngxIdLlbVJgztJb7sOdFXrker+fzz3xJIbPtatH9oG/dHRQLcXLIb?=
 =?us-ascii?Q?fypT0DAKqrVLXKWnzesz9/lWu+EZ6R6TBtCpJF/UOHrhpN+my1Ozy+qX2IN9?=
 =?us-ascii?Q?KKs4lFYQmbpRx1798ekzBBdexaXGFsiPjXHOUkoGSo2fqwbrv1gjFsGaWIRh?=
 =?us-ascii?Q?ngd0Qcbxrs9A4xZszm3fJ1RZG8+NEUMH?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5997.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(38070700018)(7053199007); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?v4Cm43rGAFEcxFohRAigqISXJOwBvxCsSunOxen5oadXoMmNcBaAUr3Rb1Ov?=
 =?us-ascii?Q?8lu6FI32v9cE4CyGbt1XtBZTP50a6dpx15FuJHWrFj7UAIBDsDwmhedI2HbK?=
 =?us-ascii?Q?eLEt2QP2CpiPqOlSAXiVrR7q+Uzm2wXbc8AuXLD96NeT1R0V+NnW9hGmze+/?=
 =?us-ascii?Q?Kac3xtWHu5TYyzgUiUPZ5N9WdrtwDDALKdVG7iHapRXMvo0+phxcOMOzeeRR?=
 =?us-ascii?Q?Tv9xCHI+a+D6XNp0NmHq44U5TLJ2Ws4npMPb/D2iq6joxlYzXgn/HcUhcT8N?=
 =?us-ascii?Q?WvWF3DgzlC78Fax76Ol0tLf/UpnlJ3DkLE5iNUYu7DSkG/bwzLqLLQ9S4crN?=
 =?us-ascii?Q?WvW2qUl6FTvin5IFL3z2DOQDt38SbP9Tf0KT2xix1VKLxo153kCPj0i88i9L?=
 =?us-ascii?Q?4dNy7DKkNZqeEhiC66FQV75sIZEPLEcLLJJiQ0IUgD5UlBrXdNd7BV0BUKpI?=
 =?us-ascii?Q?BsZkzDtz0F+wUQfgEHE/uf66+hRd5SXmTsiJg2q0yR2pRUJ2jTjFjK0EqgAU?=
 =?us-ascii?Q?3dQnyWdr/pjcYb7lSI84RtTaCW+beXZr7PJ1SAvuHoEz+ugaRbmdSsIlH76V?=
 =?us-ascii?Q?nuA2q1DAvENUAEmJNT/dreHj3WK+RiUfaElWGLh86WS/oYLpog3HFr2cpvYl?=
 =?us-ascii?Q?86rfjJEjy/unWgJJT7SENdhLVkv3bH0G/6NM/osxjshBok2Zk6++49nOaNpw?=
 =?us-ascii?Q?kEupaKH2Z0EU9KvtRgHMEDAbdW67114AXpqwsoLXOFcv3vdGUNFFPpJnG8jc?=
 =?us-ascii?Q?nXC07e92xC/NW/IWEZ6f9IqNEh10tT1RATR7Ncc/uF+uGT8IVTkIn8O1olbD?=
 =?us-ascii?Q?S0v53CQAiZrASG6RsBLnwPf5c4k001yhu2j9/M1VwkJWRqHxKcprp3z1KWJS?=
 =?us-ascii?Q?cHj0Z4NiBLgkMoVzeMy1+NuevPNIzB2iNnEhUWE9l1fpjXpzqpkZFy3P9Bdp?=
 =?us-ascii?Q?IsQPvPGmxnXvOq3wmYyzxJnXX6pPWl3lDJLi3T2Snk/EqIElVzzUce1frfSy?=
 =?us-ascii?Q?ezfu35vIG+PVTj641iURveE8puoNo4TDiK5/CpTfwgWq2MOmu8ufVdVFL4Dc?=
 =?us-ascii?Q?Vcw7P6vRiIq++YdchdfLTZ0006Kbfhr+dQVaknde4pxVqes5T6oWN5pA4UG3?=
 =?us-ascii?Q?rqRn4hM1QVfoLLVa5xNG0fF61UxVb4J2igtUjp5RMUiaUYQBECbooYtSsMHt?=
 =?us-ascii?Q?3RrUnlW7/4/pIJVLN6N2oRLLqU19gGAC1JVg2YCVeDhrbXkmwgosO2TSYsRi?=
 =?us-ascii?Q?KsPAM6LOLlRgOYjsqERYBSaKNlKR/ewt9gtvPM+ZptOPwNIxJL4Ku1KV4fHS?=
 =?us-ascii?Q?J9a8EIqmbrApEjW1rWc1Fjuf6YZlosezSbHpQdtf2KhuDyvfVy2utP0CcHVn?=
 =?us-ascii?Q?8Jum+A6oM/TOcAtTn1Qb3UAdn7iOqlTRap3+zXYDkfGKxZJ+ffisQwYWX1lx?=
 =?us-ascii?Q?f0k6ZNue62kXIn3P5fRkMKVZViUEm655vodZctE6TGpNS5A01Uc36V0NaIRT?=
 =?us-ascii?Q?7zPNzsJAu4KY8o3zRMTCL3yW8ry0BUTk6jx9Czo88gPzFXMWRlEptyU4c8iD?=
 =?us-ascii?Q?sYtPK0j1MSjttCooulA=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5997.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 970c5580-21ab-4437-b309-08dd3684b5ae
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Jan 2025 23:22:56.8081 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: nQSNsMHTiyFpRw7iGSC5QyLoOdBNvNMlftNqM1leT8DFoc8wMiJkkuL4JAFlbFLH
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYYPR12MB8855
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

Reviewed-by: Yang Wang <kevinyang.wang@amd.com>

Best Regards,
Kevin

-----Original Message-----
From: Lazar, Lijo <Lijo.Lazar@amd.com>
Sent: Thursday, January 16, 2025 20:29
To: amd-gfx@lists.freedesktop.org
Cc: Zhang, Hawking <Hawking.Zhang@amd.com>; Deucher, Alexander <Alexander.D=
eucher@amd.com>; Kamal, Asad <Asad.Kamal@amd.com>; Wang, Yang(Kevin) <Kevin=
Yang.Wang@amd.com>
Subject: [PATCH] drm/amd/pm: Add capability flags for SMU v13.0.6

Add capability flags for SMU v13.0.6 variants. Initialize the flags based o=
n firmware support. As there are multiple IP versions maintained, it is mor=
e manageable with one time initialization caps flags based on IP version an=
d firmware feature support.

Signed-off-by: Lijo Lazar <lijo.lazar@amd.com>
---
 drivers/gpu/drm/amd/pm/swsmu/inc/smu_v13_0.h  |   1 +
 .../drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c  | 225 ++++++++++++------
 2 files changed, 158 insertions(+), 68 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/inc/smu_v13_0.h b/drivers/gpu/drm=
/amd/pm/swsmu/inc/smu_v13_0.h
index 356d9422b411..8d4a96e23326 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/inc/smu_v13_0.h
+++ b/drivers/gpu/drm/amd/pm/swsmu/inc/smu_v13_0.h
@@ -107,6 +107,7 @@ struct smu_13_0_dpm_context {
        struct smu_13_0_dpm_tables  dpm_tables;
        uint32_t                    workload_policy_mask;
        uint32_t                    dcef_min_ds_clk;
+       uint64_t                    caps;
 };

 enum smu_13_0_power_state {
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c b/drivers=
/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
index c12959a36d78..56e26fcd3066 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
@@ -101,38 +101,25 @@ MODULE_FIRMWARE("amdgpu/smu_13_0_14.bin");
 #define MCA_BANK_IPID(_ip, _hwid, _type) \
        [AMDGPU_MCA_IP_##_ip] =3D { .hwid =3D _hwid, .mcatype =3D _type, }

-static inline bool smu_v13_0_6_is_unified_metrics(struct smu_context *smu)=
 -{
-       return (smu->adev->flags & AMD_IS_APU) &&
-               smu->smc_fw_version <=3D 0x4556900;
-}
-
-static inline bool smu_v13_0_6_is_other_end_count_available(struct smu_con=
text *smu) -{
-       switch (amdgpu_ip_version(smu->adev, MP1_HWIP, 0)) {
-       case IP_VERSION(13, 0, 6):
-               return smu->smc_fw_version >=3D 0x557600;
-       case IP_VERSION(13, 0, 14):
-               return smu->smc_fw_version >=3D 0x05550E00;
-       default:
-               return false;
-       }
-}
-
-static inline bool smu_v13_0_6_is_blw_host_limit_available(struct smu_cont=
ext *smu) -{
-       if (smu->adev->flags & AMD_IS_APU)
-               return smu->smc_fw_version >=3D 0x04556F00;
+enum smu_v13_0_6_caps {
+       SMU_13_0_6_CAPS_DPM,
+       SMU_13_0_6_CAPS_UNI_METRICS,
+       SMU_13_0_6_CAPS_DPM_POLICY,
+       SMU_13_0_6_CAPS_OTHER_END_METRICS,
+       SMU_13_0_6_CAPS_SET_UCLK_MAX,
+       SMU_13_0_6_CAPS_PCIE_METRICS,
+       SMU_13_0_6_CAPS_HST_LIMIT_METRICS,
+       SMU_13_0_6_CAPS_MCA_DEBUG_MODE,
+       SMU_13_0_6_CAPS_PER_INST_METRICS,
+       SMU_13_0_6_CAPS_CTF_LIMIT,
+       SMU_13_0_6_CAPS_RMA_MSG,
+       SMU_13_0_6_CAPS_ACA_SYND,
+       SMU_13_0_6_CAPS_SDMA_RESET,
+       SMU_13_0_6_CAPS_ALL,
+};

-       switch (amdgpu_ip_version(smu->adev, MP1_HWIP, 0)) {
-       case IP_VERSION(13, 0, 6):
-               return smu->smc_fw_version >=3D 0x557900;
-       case IP_VERSION(13, 0, 14):
-               return smu->smc_fw_version >=3D 0x05551000;
-       default:
-               return false;
-       }
-}
+#define SMU_CAPS_MASK(x) (ULL(1) << x)
+#define SMU_CAPS(x) SMU_CAPS_MASK(SMU_13_0_6_CAPS_##x)

 struct mca_bank_ipid {
        enum amdgpu_mca_ip ip;
@@ -297,6 +284,119 @@ struct smu_v13_0_6_dpm_map {
        uint32_t *freq_table;
 };

+static void smu_v13_0_14_init_caps(struct smu_context *smu) {
+       struct smu_13_0_dpm_context *dpm_context =3D smu->smu_dpm.dpm_conte=
xt;
+       uint64_t caps =3D SMU_CAPS(DPM) | SMU_CAPS(UNI_METRICS) |
+                       SMU_CAPS(SET_UCLK_MAX) | SMU_CAPS(DPM_POLICY) |
+                       SMU_CAPS(PCIE_METRICS) | SMU_CAPS(CTF_LIMIT) |
+                       SMU_CAPS(MCA_DEBUG_MODE) | SMU_CAPS(RMA_MSG) |
+                       SMU_CAPS(ACA_SYND);
+       uint32_t fw_ver =3D smu->smc_fw_version;
+
+       if (fw_ver >=3D 0x05550E00)
+               caps |=3D SMU_CAPS(OTHER_END_METRICS);
+       if (fw_ver >=3D 0x05551000)
+               caps |=3D SMU_CAPS(HST_LIMIT_METRICS);
+       if (fw_ver >=3D 0x05550B00)
+               caps |=3D SMU_CAPS(PER_INST_METRICS);
+       if (fw_ver > 0x05550f00)
+               caps |=3D SMU_CAPS(SDMA_RESET);
+
+       dpm_context->caps =3D caps;
+}
+
+static void smu_v13_0_6_init_caps(struct smu_context *smu) {
+       uint64_t caps =3D SMU_CAPS(DPM) | SMU_CAPS(UNI_METRICS) |
+                       SMU_CAPS(SET_UCLK_MAX) | SMU_CAPS(DPM_POLICY) |
+                       SMU_CAPS(PCIE_METRICS) | SMU_CAPS(MCA_DEBUG_MODE) |
+                       SMU_CAPS(CTF_LIMIT) | SMU_CAPS(RMA_MSG) |
+                       SMU_CAPS(ACA_SYND);
+       struct smu_13_0_dpm_context *dpm_context =3D smu->smu_dpm.dpm_conte=
xt;
+       struct amdgpu_device *adev =3D smu->adev;
+       uint32_t fw_ver =3D smu->smc_fw_version;
+       uint32_t pgm =3D (fw_ver >> 24) & 0xFF;
+
+       if (fw_ver < 0x552F00)
+               caps &=3D ~SMU_CAPS(DPM);
+
+       if (adev->flags & AMD_IS_APU) {
+               caps &=3D ~SMU_CAPS(PCIE_METRICS);
+               caps &=3D ~SMU_CAPS(SET_UCLK_MAX);
+               caps &=3D ~SMU_CAPS(DPM_POLICY);
+               caps &=3D ~SMU_CAPS(RMA_MSG);
+               caps &=3D ~SMU_CAPS(ACA_SYND);
+
+               if (fw_ver <=3D 0x4556900)
+                       caps &=3D ~SMU_CAPS(UNI_METRICS);
+
+               if (fw_ver >=3D 0x04556F00)
+                       caps |=3D SMU_CAPS(HST_LIMIT_METRICS);
+               if (fw_ver >=3D 0x04556A00)
+                       caps |=3D SMU_CAPS(PER_INST_METRICS);
+               if (fw_ver < 0x554500)
+                       caps &=3D ~SMU_CAPS(CTF_LIMIT);
+       } else {
+               if (fw_ver >=3D 0x557600)
+                       caps |=3D SMU_CAPS(OTHER_END_METRICS);
+               if (fw_ver < 0x00556000)
+                       caps &=3D ~SMU_CAPS(DPM_POLICY);
+               if (amdgpu_sriov_vf(adev) && (fw_ver < 0x556600))
+                       caps &=3D ~SMU_CAPS(SET_UCLK_MAX);
+               if (fw_ver < 0x556300)
+                       caps &=3D ~SMU_CAPS(PCIE_METRICS);
+               if (fw_ver < 0x554800)
+                       caps &=3D ~SMU_CAPS(MCA_DEBUG_MODE);
+               if (fw_ver >=3D 0x556F00)
+                       caps |=3D SMU_CAPS(PER_INST_METRICS);
+               if (fw_ver < 0x554500)
+                       caps &=3D ~SMU_CAPS(CTF_LIMIT);
+               if (fw_ver < 0x00555a00)
+                       caps &=3D ~SMU_CAPS(RMA_MSG);
+               if (fw_ver < 0x00555600)
+                       caps &=3D ~SMU_CAPS(ACA_SYND);
+               if (pgm =3D=3D 0 && fw_ver >=3D 0x557900)
+                       caps |=3D SMU_CAPS(HST_LIMIT_METRICS);
+       }
+       if (((pgm =3D=3D 7) && (fw_ver > 0x07550700)) ||
+           ((pgm =3D=3D 0) && (fw_ver > 0x00557700)) ||
+           ((pgm =3D=3D 4) && (fw_ver > 0x4556e6c)))
+               caps |=3D SMU_CAPS(SDMA_RESET);
+
+       dpm_context->caps =3D caps;
+}
+
+static inline bool smu_v13_0_6_caps_supported(struct smu_context *smu,
+                                             enum smu_v13_0_6_caps caps)
+{
+       struct smu_13_0_dpm_context *dpm_context =3D smu->smu_dpm.dpm_conte=
xt;
+
+       return (dpm_context->caps & SMU_CAPS_MASK(caps)) =3D=3D
+SMU_CAPS_MASK(caps); }
+
+static void smu_v13_0_x_init_caps(struct smu_context *smu) {
+       switch (amdgpu_ip_version(smu->adev, MP1_HWIP, 0)) {
+       case IP_VERSION(13, 0, 14):
+               return smu_v13_0_14_init_caps(smu);
+       default:
+               return smu_v13_0_6_init_caps(smu);
+       }
+}
+
+static int smu_v13_0_6_check_fw_version(struct smu_context *smu) {
+       int r;
+
+       r =3D smu_v13_0_check_fw_version(smu);
+       /* Initialize caps flags once fw version is fetched */
+       if (!r)
+               smu_v13_0_x_init_caps(smu);
+
+       return r;
+}
+
 static int smu_v13_0_6_init_microcode(struct smu_context *smu)  {
        const struct smc_firmware_header_v2_1 *v2_1; @@ -616,7 +716,7 @@ st=
atic int smu_v13_0_6_setup_driver_pptable(struct smu_context *smu)
        MetricsTableA_t *metrics_a =3D (MetricsTableA_t *)smu_table->metric=
s_table;
        struct PPTable_t *pptable =3D
                (struct PPTable_t *)smu_table->driver_pptable;
-       bool flag =3D smu_v13_0_6_is_unified_metrics(smu);
+       bool flag =3D !smu_v13_0_6_caps_supported(smu, SMU_CAPS(UNI_METRICS=
));
        int ret, i, retry =3D 100;
        uint32_t table_version;

@@ -812,8 +912,7 @@ static int smu_v13_0_6_set_default_dpm_table(struct smu=
_context *smu)
        smu_v13_0_6_setup_driver_pptable(smu);

        /* DPM policy not supported in older firmwares */
-       if (!(smu->adev->flags & AMD_IS_APU) &&
-           (smu->smc_fw_version < 0x00556000)) {
+       if (!smu_v13_0_6_caps_supported(smu, SMU_CAPS(DPM_POLICY))) {
                struct smu_dpm_context *smu_dpm =3D &smu->smu_dpm;

                smu_dpm->dpm_policies->policy_mask &=3D @@ -990,7 +1089,7 @=
@ static int smu_v13_0_6_get_smu_metrics_data(struct smu_context *smu,
        struct smu_table_context *smu_table =3D &smu->smu_table;
        MetricsTableX_t *metrics_x =3D (MetricsTableX_t *)smu_table->metric=
s_table;
        MetricsTableA_t *metrics_a =3D (MetricsTableA_t *)smu_table->metric=
s_table;
-       bool flag =3D smu_v13_0_6_is_unified_metrics(smu);
+       bool flag =3D !smu_v13_0_6_caps_supported(smu, SMU_CAPS(UNI_METRICS=
));
        struct amdgpu_device *adev =3D smu->adev;
        int ret =3D 0;
        int xcc_id;
@@ -1003,7 +1102,7 @@ static int smu_v13_0_6_get_smu_metrics_data(struct sm=
u_context *smu,
        switch (member) {
        case METRICS_CURR_GFXCLK:
        case METRICS_AVERAGE_GFXCLK:
-               if (smu->smc_fw_version >=3D 0x552F00) {
+               if (smu_v13_0_6_caps_supported(smu, SMU_CAPS(DPM))) {
                        xcc_id =3D GET_INST(GC, 0);
                        *value =3D SMUQ10_ROUND(GET_METRIC_FIELD(GfxclkFreq=
uency, flag)[xcc_id]);
                } else {
@@ -1692,7 +1791,7 @@ static int smu_v13_0_6_notify_unload(struct smu_conte=
xt *smu)  static int smu_v13_0_6_mca_set_debug_mode(struct smu_context *smu=
, bool enable)  {
        /* NOTE: this ClearMcaOnRead message is only supported for smu vers=
ion 85.72.0 or higher */
-       if (smu->smc_fw_version < 0x554800)
+       if (!smu_v13_0_6_caps_supported(smu, SMU_CAPS(MCA_DEBUG_MODE)))
                return 0;

        return smu_cmn_send_smc_msg_with_param(smu, SMU_MSG_ClearMcaOnRead,=
 @@ -1837,9 +1936,8 @@ static int smu_v13_0_6_set_soft_freq_limited_range(s=
truct smu_context *smu,
                        if (max =3D=3D pstate_table->uclk_pstate.curr.max)
                                return 0;
                        /* For VF, only allowed in FW versions 85.102 or gr=
eater */
-                       if (amdgpu_sriov_vf(adev) &&
-                           ((smu->smc_fw_version < 0x556600) ||
-                            (adev->flags & AMD_IS_APU)))
+                       if (!smu_v13_0_6_caps_supported(smu,
+                                                       SMU_CAPS(SET_UCLK_M=
AX)))
                                return -EOPNOTSUPP;
                        /* Only max clock limiting is allowed for UCLK */
                        ret =3D smu_v13_0_set_soft_freq_limited_range(
@@ -2043,7 +2141,7 @@ static int smu_v13_0_6_get_enabled_mask(struct smu_co=
ntext *smu,

        ret =3D smu_cmn_get_enabled_mask(smu, feature_mask);

-       if (ret =3D=3D -EIO && smu->smc_fw_version < 0x552F00) {
+       if (ret =3D=3D -EIO && !smu_v13_0_6_caps_supported(smu, SMU_CAPS(DP=
M))) {
                *feature_mask =3D 0;
                ret =3D 0;
        }
@@ -2336,11 +2434,10 @@ static int smu_v13_0_6_get_current_pcie_link_speed(=
struct smu_context *smu)

 static ssize_t smu_v13_0_6_get_gpu_metrics(struct smu_context *smu, void *=
*table)  {
-       bool per_inst, smu_13_0_6_per_inst, smu_13_0_14_per_inst, apu_per_i=
nst;
        struct smu_table_context *smu_table =3D &smu->smu_table;
        struct gpu_metrics_v1_7 *gpu_metrics =3D
                (struct gpu_metrics_v1_7 *)smu_table->gpu_metrics_table;
-       bool flag =3D smu_v13_0_6_is_unified_metrics(smu);
+       bool flag =3D !smu_v13_0_6_caps_supported(smu, SMU_CAPS(UNI_METRICS=
));
        int ret =3D 0, xcc_id, inst, i, j, k, idx;
        struct amdgpu_device *adev =3D smu->adev;
        MetricsTableX_t *metrics_x;
@@ -2348,6 +2445,7 @@ static ssize_t smu_v13_0_6_get_gpu_metrics(struct smu=
_context *smu, void **table
        struct amdgpu_xcp *xcp;
        u16 link_width_level;
        u32 inst_mask;
+       bool per_inst;

        metrics_x =3D kzalloc(max(sizeof(MetricsTableX_t), sizeof(MetricsTa=
bleA_t)), GFP_KERNEL);
        ret =3D smu_v13_0_6_get_metrics_table(smu, metrics_x, true); @@ -24=
21,7 +2519,7 @@ static ssize_t smu_v13_0_6_get_gpu_metrics(struct smu_conte=
xt *smu, void **table
                 * table for both pf & one vf for smu version 85.99.0 or hi=
gher else report only
                 * for pf from registers
                 */
-               if (smu->smc_fw_version >=3D 0x556300) {
+               if (smu_v13_0_6_caps_supported(smu, SMU_CAPS(PCIE_METRICS))=
) {
                        gpu_metrics->pcie_link_width =3D metrics_x->PCIeLin=
kWidth;
                        gpu_metrics->pcie_link_speed =3D
                                pcie_gen_to_speed(metrics_x->PCIeLinkSpeed)=
;
@@ -2450,7 +2548,8 @@ static ssize_t smu_v13_0_6_get_gpu_metrics(struct smu=
_context *smu, void **table
                                metrics_x->PCIeNAKSentCountAcc;
                gpu_metrics->pcie_nak_rcvd_count_acc =3D
                                metrics_x->PCIeNAKReceivedCountAcc;
-               if (smu_v13_0_6_is_other_end_count_available(smu))
+               if (smu_v13_0_6_caps_supported(smu,
+                                              SMU_CAPS(OTHER_END_METRICS))=
)
                        gpu_metrics->pcie_lc_perf_other_end_recovery =3D
                                metrics_x->PCIeOtherEndRecoveryAcc;

@@ -2475,17 +2574,7 @@ static ssize_t smu_v13_0_6_get_gpu_metrics(struct sm=
u_context *smu, void **table

        gpu_metrics->num_partition =3D adev->xcp_mgr->num_xcps;

-       apu_per_inst =3D (adev->flags & AMD_IS_APU) && (smu->smc_fw_version=
 >=3D 0x04556A00);
-       smu_13_0_6_per_inst =3D !(adev->flags & AMD_IS_APU) &&
-                               (amdgpu_ip_version(smu->adev, MP1_HWIP, 0)
-                                =3D=3D IP_VERSION(13, 0, 6)) &&
-                               (smu->smc_fw_version >=3D 0x556F00);
-       smu_13_0_14_per_inst =3D !(adev->flags & AMD_IS_APU) &&
-                               (amdgpu_ip_version(smu->adev, MP1_HWIP, 0)
-                                =3D=3D IP_VERSION(13, 0, 14)) &&
-                               (smu->smc_fw_version >=3D 0x05550B00);
-
-       per_inst =3D apu_per_inst || smu_13_0_6_per_inst || smu_13_0_14_per=
_inst;
+       per_inst =3D smu_v13_0_6_caps_supported(smu,
+SMU_CAPS(PER_INST_METRICS));

        for_each_xcp(adev->xcp_mgr, xcp, i) {
                amdgpu_xcp_get_inst_details(xcp, AMDGPU_XCP_VCN, &inst_mask=
); @@ -2516,7 +2605,8 @@ static ssize_t smu_v13_0_6_get_gpu_metrics(struct =
smu_context *smu, void **table
                                gpu_metrics->xcp_stats[i].gfx_busy_acc[idx]=
 =3D
                                        SMUQ10_ROUND(metrics_x->GfxBusyAcc[=
inst]);

-                               if (smu_v13_0_6_is_blw_host_limit_available=
(smu))
+                               if (smu_v13_0_6_caps_supported(
+                                           smu, SMU_CAPS(HST_LIMIT_METRICS=
)))
                                        gpu_metrics->xcp_stats[i].gfx_below=
_host_limit_acc[idx] =3D
                                                SMUQ10_ROUND(metrics_x->Gfx=
clkBelowHostLimitAcc
                                                                [inst]);
@@ -2624,7 +2714,7 @@ static int smu_v13_0_6_get_thermal_temperature_range(=
struct smu_context *smu,
                return -EINVAL;

        /*Check smu version, GetCtfLimit message only supported for smu ver=
sion 85.69 or higher */
-       if (smu->smc_fw_version < 0x554500)
+       if (!smu_v13_0_6_caps_supported(smu, SMU_CAPS(CTF_LIMIT)))
                return 0;

        /* Get SOC Max operating temperature */ @@ -2726,11 +2816,10 @@ sta=
tic int smu_v13_0_6_smu_send_hbm_bad_page_num(struct smu_context *smu,

 static int smu_v13_0_6_send_rma_reason(struct smu_context *smu)  {
-       struct amdgpu_device *adev =3D smu->adev;
        int ret;

        /* NOTE: the message is only valid on dGPU with pmfw 85.90.0 and ab=
ove */
-       if ((adev->flags & AMD_IS_APU) || smu->smc_fw_version < 0x00555a00)
+       if (!smu_v13_0_6_caps_supported(smu, SMU_CAPS(RMA_MSG)))
                return 0;

        ret =3D smu_cmn_send_smc_msg(smu, SMU_MSG_RmaDueToBadPageThreshold,=
 NULL); @@ -2750,18 +2839,17 @@ static int smu_v13_0_6_reset_sdma(struct sm=
u_context *smu, uint32_t inst_mask)
        smu_program =3D (smu->smc_fw_version >> 24) & 0xff;
        switch (amdgpu_ip_version(smu->adev, MP1_HWIP, 0)) {
        case IP_VERSION(13, 0, 6):
-               if (((smu_program =3D=3D 7) && (smu->smc_fw_version > 0x075=
50700)) ||
-                       ((smu_program =3D=3D 0) && (smu->smc_fw_version > 0=
x00557700)))
+               if ((smu_program =3D=3D 7 || smu_program =3D=3D 0) &&
+                   smu_v13_0_6_caps_supported(smu, SMU_CAPS(SDMA_RESET)))
                        ret =3D smu_cmn_send_smc_msg_with_param(smu,
                                SMU_MSG_ResetSDMA, inst_mask, NULL);
                else if ((smu_program =3D=3D 4) &&
-                       (smu->smc_fw_version > 0x4556e6c))
+                        smu_v13_0_6_caps_supported(smu, SMU_CAPS(SDMA_RESE=
T)))
                        ret =3D smu_cmn_send_smc_msg_with_param(smu,
                                      SMU_MSG_ResetSDMA2, inst_mask, NULL);
                break;
        case IP_VERSION(13, 0, 14):
-               if ((smu_program =3D=3D 5) &&
-                       (smu->smc_fw_version > 0x05550f00))
+               if (smu_v13_0_6_caps_supported(smu, SMU_CAPS(SDMA_RESET)))
                        ret =3D smu_cmn_send_smc_msg_with_param(smu,
                                      SMU_MSG_ResetSDMA2, inst_mask, NULL);
                break;
@@ -3087,7 +3175,7 @@ static bool mca_smu_bank_is_valid(const struct mca_ra=
s_info *mca_ras, struct amd
        if (instlo !=3D 0x03b30400)
                return false;

-       if (!(adev->flags & AMD_IS_APU) && smu->smc_fw_version >=3D 0x00555=
600) {
+       if (smu_v13_0_6_caps_supported(smu, SMU_CAPS(ACA_SYND))) {
                errcode =3D MCA_REG__SYND__ERRORINFORMATION(entry->regs[MCA=
_REG_IDX_SYND]);
                errcode &=3D 0xff;
        } else {
@@ -3373,9 +3461,10 @@ static int aca_smu_get_valid_aca_bank(struct amdgpu_=
device *adev,

 static int aca_smu_parse_error_code(struct amdgpu_device *adev, struct aca=
_bank *bank)  {
+       struct smu_context *smu =3D adev->powerplay.pp_handle;
        int error_code;

-       if (!(adev->flags & AMD_IS_APU) && adev->pm.fw_version >=3D 0x00555=
600)
+       if (smu_v13_0_6_caps_supported(smu, SMU_CAPS(ACA_SYND)))
                error_code =3D ACA_REG__SYND__ERRORINFORMATION(bank->regs[A=
CA_REG_IDX_SYND]);
        else
                error_code =3D ACA_REG__STATUS__ERRORCODE(bank->regs[ACA_RE=
G_IDX_STATUS]);
@@ -3413,7 +3502,7 @@ static const struct pptable_funcs smu_v13_0_6_ppt_fun=
cs =3D {
        .fini_power =3D smu_v13_0_fini_power,
        .check_fw_status =3D smu_v13_0_6_check_fw_status,
        /* pptable related */
-       .check_fw_version =3D smu_v13_0_check_fw_version,
+       .check_fw_version =3D smu_v13_0_6_check_fw_version,
        .set_driver_table_location =3D smu_v13_0_set_driver_table_location,
        .set_tool_table_location =3D smu_v13_0_set_tool_table_location,
        .notify_memory_pool_location =3D smu_v13_0_notify_memory_pool_locat=
ion,
--
2.25.1

