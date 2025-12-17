Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1A988D6409B
	for <amd-gfx@archiver.kernel.org>; Wed, 17 Dec 2025 15:35:54 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AA6F410ED17;
	Wed, 17 Dec 2025 15:35:53 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="SqxycocI";
	dkim-atps=neutral
Received: from DM1PR04CU001.outbound.protection.outlook.com
 (mail-centralusazon11010029.outbound.protection.outlook.com [52.101.61.29])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8BD4910ED09
 for <amd-gfx@lists.freedesktop.org>; Wed, 17 Dec 2025 15:35:52 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QxFUFVNWDljz24nYa5JQZgwkAvhFxyspVO5X4ofrs6KkRtQ9kNrPqTNiQ6bVOqQYoF1oIbxn3sj/ciuBHVjkEeCGgdISEql2AqH6rSQAb/LqqQ3nKyHN+FDeC4Gvw8n3m/u0QoHzgOMkS3xTACswAQQsIktSopPP5vrbHnW8ah2EnFBEh4RBcUIson40krMs1kdliZByjSHSezkg3HiYbFgwjmKGscH5Qrw/6f+CViM219UCykSM8dn1unXVmnaxealDp/+GtxzMuiu4kosERJJR6pY38vobUzdaaZF6NdigDLvuKOIm/3GunC03HAik48zkhGDX8XHqMOBUiWFdtA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4d2nz4FxbMllkhI3hvgnURKCGAh/HxJ2k7JI7iTfek0=;
 b=iUKynriAKuA26VOKbrNtWczpApRTKzkXbZmWDi6dOVuLd+ADKK+1zl4BuBcX/cvBe5xt0kg/QqcEctKkLGne61143eWLCoNzc+UUVWKatF2nqk0j+epDALN2J51IHqV322zFBRdNvE4/WbjckRHInkrz01ZrRnULeEh6F6OzcIOmM1pwXQXv10uzVo8o03IUJCC6IoZJ7HEwPdStsCqxOkm0b0Hanl3OnPlzoVDRWvz9VDBngGzUWyoYm5PBU1mWraulPgzT6Jq/Jy3Lw19jHTpshads0wLYsMCfEsDjCe4ih0h+I7YvVyhNPxxrO4WlJ+xWvtexhLAX0fHGTzTXGw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4d2nz4FxbMllkhI3hvgnURKCGAh/HxJ2k7JI7iTfek0=;
 b=SqxycocIowAG7v3pYV+Xb1m6xPdUyUqf68I0nV2hG8ZCVbw6MdU/XGTKzI3rH4AM9CceDjokoPMpVlS/zK79VPuZz8jbhLvoKBJla9ljHSziuqiIhAXs84bodOFCO6mvo5lYdP9Zf+ig/EkQ0/cmO47ClfwH2W8HjI9lBzwZNlE=
Received: from DS7PR12MB6071.namprd12.prod.outlook.com (2603:10b6:8:9d::11) by
 BL1PR12MB5707.namprd12.prod.outlook.com (2603:10b6:208:386::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9434.6; Wed, 17 Dec
 2025 15:35:43 +0000
Received: from DS7PR12MB6071.namprd12.prod.outlook.com
 ([fe80::6f14:4646:fb11:829]) by DS7PR12MB6071.namprd12.prod.outlook.com
 ([fe80::6f14:4646:fb11:829%4]) with mapi id 15.20.9434.001; Wed, 17 Dec 2025
 15:35:43 +0000
From: "Kamal, Asad" <Asad.Kamal@amd.com>
To: "Lazar, Lijo" <Lijo.Lazar@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
CC: "Zhang, Hawking" <Hawking.Zhang@amd.com>, "Deucher, Alexander"
 <Alexander.Deucher@amd.com>
Subject: RE: [PATCH] drm/amd/pm: Return right size for gpuboard metrics
Thread-Topic: [PATCH] drm/amd/pm: Return right size for gpuboard metrics
Thread-Index: AQHca0GrydyIRbu0IUy7SarInBpY3rUl/w/g
Date: Wed, 17 Dec 2025 15:35:43 +0000
Message-ID: <DS7PR12MB6071D9F0538656C1E69E294B8EABA@DS7PR12MB6071.namprd12.prod.outlook.com>
References: <20251212083045.2463099-1-lijo.lazar@amd.com>
In-Reply-To: <20251212083045.2463099-1-lijo.lazar@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=True;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2025-12-17T15:35:35.0000000Z;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution
 Only; MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=3;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS7PR12MB6071:EE_|BL1PR12MB5707:EE_
x-ms-office365-filtering-correlation-id: b29446f1-1b77-4dc0-242e-08de3d81f0ea
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|376014|366016|38070700021|7053199007; 
x-microsoft-antispam-message-info: =?us-ascii?Q?3k6dAb05kTtQLvG7LT3IH+6P3F63VZMQmB2ceMYJsMD/IS82kah/4Jtc80i3?=
 =?us-ascii?Q?9vaAmOqZs5Qk0vwJfMl+SnPxHXqnWz4FWXmKQNdpzIa3b08VIAPPL8eSQCKd?=
 =?us-ascii?Q?YZ4EU6X8RxSiCGdvFstBuuAbtyktxD1fLyJlp+KqqzsJY1Qch5lUG6RDs0tE?=
 =?us-ascii?Q?uEw4LYKmWLQHhc97bsrvM/XBS2gv5UlwkIZfh0mRanYeQoc4PNWgj5QIgGze?=
 =?us-ascii?Q?YXTMjn0K2UlfcHezYByxZcrR9X0/3IcBBm6epek4cYJcyjCezmGwQmlVTs9+?=
 =?us-ascii?Q?fnrdlL9li7Wqv1JhjyzkCMLc7zUAYPGUP9q/7f2z/CJnokeAo4/VZFLKYkvP?=
 =?us-ascii?Q?9tO/lyaYKA+kyM6RYvH2WYI8IqqPmwqnkRh+/eaoYlijbyHX7W0bX1UuQWrB?=
 =?us-ascii?Q?tCvzvXvIjd/ASmpvyJdNCFXwER2hfXOqFqXculoOVEmzOxog5QjHFzZ31Kj3?=
 =?us-ascii?Q?lMYl9+nk1vVVvlHjMAWnJSOtwD7RjGfkr1g12bWtEANiDxwACxo9DZRYCkZ9?=
 =?us-ascii?Q?19a5lG5an6tUEm0d1gVLXITR6nb7KWC7lzTYXQjD9CUrQgu7cx1HMi+Fej1y?=
 =?us-ascii?Q?a42IB9D6u9zlkB0DTeUuPgLcfKBAMG2sibdxmwAsxCqv0pVRod4OKX3dcTSo?=
 =?us-ascii?Q?HlD0v2AukTOs1hXpl9RisnYMEdPnbxAZBEefJ7y9rIEuiL+/m9cJKzc2ddBo?=
 =?us-ascii?Q?QYH3UPYgEWK9OSZBVaoRcOvq6ueNTr3AxXtlgKRR9BBmJkpbJFUQxn0brgzL?=
 =?us-ascii?Q?W+t33/z3B6zUbotayjYEb7+PWXnExupI2XQD0gQKbWVxm0wNe0xtF9FgShx2?=
 =?us-ascii?Q?K2ASZtkcLgESeIRbYRUhW9oTisZWAxbWscalPA8sRSAppfo5vXqF/pSrPz0N?=
 =?us-ascii?Q?bs4k0bKJ9OPtPuraJB6aR3q4H9P5xDLHCGOLk0Ei/fkKICngs5C52GjaSDiC?=
 =?us-ascii?Q?g5+vddts8T2SiK5tsNOSqmikq5/0EvpJbtmxXGqOW65qxkSpBEJWSTE9E7n4?=
 =?us-ascii?Q?jd40/OV1BELYcinXmG7O4N/vrQDnW0tO7fR9KlPMv5x/xh4RVVL/6Jg15Sig?=
 =?us-ascii?Q?gO7q+aSL1o456NYDkQ7lt7k9Scde+4W8TjfHRMz94j+v36sInZ1MyhQVJXDm?=
 =?us-ascii?Q?Uv64CghYo4L0mBZnYdO/+EG3NBE4PoxTECCpfvWeRpm01av1urMfDtKS/gGC?=
 =?us-ascii?Q?QkWbtzIkuywUiXWOtTSHwKcUPKXMS9MVYuialbDkCQwN+mQqa3X0b5L0o5oq?=
 =?us-ascii?Q?yszobsNMBgkk1IeGS0no0SYf0IKVY89L7hZLRBm2KyUDU63SHQcDqk6Spjku?=
 =?us-ascii?Q?/61W+YX/VWVdmNXe4zOWG/c6HtQ2oeQMNXo/2USNYKRvSWZbvLRvuTtyeSFp?=
 =?us-ascii?Q?VTVJ3V0demB99QVPPIpSdzsbwDJrSH02fh4gE8wCIAbJ8K7rNc2ofCMnE0oE?=
 =?us-ascii?Q?SY18fc1diHTrAqiQe+UeEWSacCv/WKx6c3s9W7wZVlzuku8K9UzlVJTRgZqP?=
 =?us-ascii?Q?mBB2LByGJrPaKzaam0zrtck/QMhWzVFMbzTj?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS7PR12MB6071.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(38070700021)(7053199007); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?F3XBWI1y2jgXlSDiN+T55Wyvbh/FwA0m8CoMsg44tSMRjQZbiW5PpE3EtqO1?=
 =?us-ascii?Q?cTXjmEYSntX7fvCM7Mn4iQ0iwlc+MHJ4ZHKRG32usLCoag/KeY7XMrNZdSlH?=
 =?us-ascii?Q?SbXnJ5Ra3IgmDkA+50XYIwflPDTEY/vthr4bMSR2obEPde2rX4yOuoT/3Jxq?=
 =?us-ascii?Q?llpsXGbkDsujeVABeSw2ULIjfj2Jf5/dwTOOLjMV/aJ4HJEO0aLG08/7UnDl?=
 =?us-ascii?Q?eeHRsRuUdKuFice9suw/ov+GnlNWSK3B714Vd1LgmmQMdU7qkKKBJ6abT9nQ?=
 =?us-ascii?Q?19djDzp3cI+KZEGHxqCGybyO71jhBwuAeoRkg6mR3PnouqvSU12+dEW+/tHk?=
 =?us-ascii?Q?UdPjE55W7KRl6LFJSLtguhB3pjmGt50A6oTGDmItwxdJWeTcAFgOx8tS0SJ1?=
 =?us-ascii?Q?i22P8bcZMgj8+aDBCk95oFlKWnfz/D+NzYQx5vCo47vogKkrPgW5WQQMpqG5?=
 =?us-ascii?Q?sWQj65kGk9JnZqm5k1TxvrbaDH2dzxUZOEm6R7fJIMYsNLhHO0Yn7wL0MyAJ?=
 =?us-ascii?Q?z8lLgmNoPRNo4sJI99RrZTolws9NVguu9gSGHOZnm4S/Gy3Xw69gglsL1EaP?=
 =?us-ascii?Q?7NoQ0PO+ncFEFE3JffDqlTHv1NdFab1LZ8yU5HPMOoI3N6NFU4yhcBW11dtc?=
 =?us-ascii?Q?WOlw44qGxANp6we268FPGRMMmewsqldJYj/aJNm2VkFkwDgEUxyC5qnPDI1o?=
 =?us-ascii?Q?SkKS4thSPJNQFWx9x2M6wNWusaUcfaqpJftZdWNnaVxh/V8/DTtkyebwLBzp?=
 =?us-ascii?Q?w3TTr3oZwSeivhxZa1QU8SlWjoleePWwfR5KQgjG1VDGJxfWqMgXVQEiVG1t?=
 =?us-ascii?Q?vMePgaWQvEdmDczlbiszUuHj8F+4kjInazUHJnDQrMWniCT4uYHeBZt0t8Ac?=
 =?us-ascii?Q?j7V8v7dOh9e2/TV4hEW4Y8eX9NqA8YDgJuzuZjzV/m+/hmIJuS/3XITD/A56?=
 =?us-ascii?Q?3B4JVfcOA+MdHh3jQgJEMiLkXstsKn7pZI52jfloM06ohKqmPrarEH5KbzXO?=
 =?us-ascii?Q?Uo4VaFkiPfw9GSNCL+uZO++NvHbA2wBSwlc46xHFos6CFi7QhpzlhDbR6lGp?=
 =?us-ascii?Q?OmCUdHAdQGNbCkAV+wlmHAfMT4lgNwnbvcLjUwhFrVrW6fcDXPNFVXAILCqE?=
 =?us-ascii?Q?jyWQ3ZkfMdU/oWC0MjmYHkuQVU82LFMxSDME5drFegza0s2eDEJ79IX53BgG?=
 =?us-ascii?Q?APeJ5AaXA93HAwZdW4uJI3hL8fCK1ZB+IU3upUhXWDOOTcPnEW2lG1Z/CZMu?=
 =?us-ascii?Q?Fr3Uk3D2QbMmJYCDxoUlMihP92N1BES7/5NIu4F6JLccRMmzdV+mcL7WjAbT?=
 =?us-ascii?Q?xJ62PIwL1voAexb3UYqClWlbhRBPiv0z9nCdiklCH7/mLO2gRoGYziQP6iR4?=
 =?us-ascii?Q?X9dnGgla8Mxi7qgmcuV0t3VBatNR3n1o3cZi64OF1t66WXayqgtyO2HvuWEw?=
 =?us-ascii?Q?qtIuI96SallDu3dUrG4tU5DdsTdgeV1sasSx3HHYP02z4JFmupjQ1qteJJ/M?=
 =?us-ascii?Q?IB7T1hlA3/EvG1PXqy73yYKbJg6WiV72+3pRkvE7jidS+6qZt7CwcM7CY0lz?=
 =?us-ascii?Q?pjDu4qnZ1RsV0ouXz+g=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB6071.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b29446f1-1b77-4dc0-242e-08de3d81f0ea
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Dec 2025 15:35:43.4595 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: DkvN9ZwLJ9drZu3HVYn8GolbAorpeN48UmV+Fq1A/RNZGSp0aHwq441N21o6t/KKIv4jxfjVmGolDMzlswHSYg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5707
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
Sent: Friday, December 12, 2025 2:01 PM
To: amd-gfx@lists.freedesktop.org
Cc: Zhang, Hawking <Hawking.Zhang@amd.com>; Deucher, Alexander <Alexander.D=
eucher@amd.com>; Kamal, Asad <Asad.Kamal@amd.com>
Subject: [PATCH] drm/amd/pm: Return right size for gpuboard metrics

Change to switch style checks and return the correct size for gpu board met=
rics.

Signed-off-by: Lijo Lazar <lijo.lazar@amd.com>
---
 .../drm/amd/pm/swsmu/smu13/smu_v13_0_12_ppt.c | 45 +++++++++----------
 1 file changed, 22 insertions(+), 23 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_12_ppt.c b/driver=
s/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_12_ppt.c
index 91a17db7912b..44d5f134a87a 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_12_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_12_ppt.c
@@ -693,30 +693,21 @@ static ssize_t smu_v13_0_12_get_temp_metrics(struct s=
mu_context *smu,
        u32 idx, sensors;
        ssize_t size;

-       if (type =3D=3D SMU_TEMP_METRIC_BASEBOARD) {
-               /* Initialize base board temperature metrics */
-               table_id =3D SMU_DRIVER_TABLE_BASEBOARD_TEMP_METRICS;
-               baseboard_temp_metrics =3D
-                       (struct amdgpu_baseboard_temp_metrics_v1_0 *)
-                               smu_driver_table_ptr(smu, table_id);
-               size =3D sizeof(*baseboard_temp_metrics);
-       } else {
-               table_id =3D SMU_DRIVER_TABLE_GPUBOARD_TEMP_METRICS;
-               gpuboard_temp_metrics =3D
-                       (struct amdgpu_gpuboard_temp_metrics_v1_0 *)
-                               smu_driver_table_ptr(smu, table_id);
-               size =3D sizeof(*baseboard_temp_metrics);
-       }
-
        ret =3D smu_v13_0_12_get_system_metrics_table(smu);
        if (ret)
                return ret;

        sys_table =3D &tables[SMU_TABLE_PMFW_SYSTEM_METRICS];
        metrics =3D (SystemMetricsTable_t *)sys_table->cache.buffer;
-       smu_driver_table_update_cache_time(smu, table_id);

-       if (type =3D=3D SMU_TEMP_METRIC_GPUBOARD) {
+       switch (type) {
+       case SMU_TEMP_METRIC_GPUBOARD:
+               table_id =3D SMU_DRIVER_TABLE_GPUBOARD_TEMP_METRICS;
+               gpuboard_temp_metrics =3D
+                       (struct amdgpu_gpuboard_temp_metrics_v1_0 *)
+                               smu_driver_table_ptr(smu, table_id);
+               size =3D sizeof(*gpuboard_temp_metrics);
+
                gpuboard_temp_metrics->accumulation_counter =3D metrics->Ac=
cumulationCounter;
                gpuboard_temp_metrics->label_version =3D metrics->LabelVers=
ion;
                gpuboard_temp_metrics->node_id =3D metrics->NodeIdentifier;=
 @@ -743,7 +734,15 @@ static ssize_t smu_v13_0_12_get_temp_metrics(struct s=
mu_context *smu,
                                idx++;
                        }
                }
-       } else if (type =3D=3D SMU_TEMP_METRIC_BASEBOARD) {
+               memcpy(table, gpuboard_temp_metrics, size);
+               break;
+       case SMU_TEMP_METRIC_BASEBOARD:
+               table_id =3D SMU_DRIVER_TABLE_BASEBOARD_TEMP_METRICS;
+               baseboard_temp_metrics =3D
+                       (struct amdgpu_baseboard_temp_metrics_v1_0 *)
+                               smu_driver_table_ptr(smu, table_id);
+               size =3D sizeof(*baseboard_temp_metrics);
+
                baseboard_temp_metrics->accumulation_counter =3D metrics->A=
ccumulationCounter;
                baseboard_temp_metrics->label_version =3D metrics->LabelVer=
sion;
                baseboard_temp_metrics->node_id =3D metrics->NodeIdentifier=
; @@ -758,12 +757,12 @@ static ssize_t smu_v13_0_12_get_temp_metrics(struct=
 smu_context *smu,
                                idx++;
                        }
                }
-       }
-
-       if (type =3D=3D SMU_TEMP_METRIC_BASEBOARD)
                memcpy(table, baseboard_temp_metrics, size);
-       else
-               memcpy(table, gpuboard_temp_metrics, size);
+               break;
+       default:
+               return -EINVAL;
+       }
+       smu_driver_table_update_cache_time(smu, table_id);

        return size;
 }
--
2.49.0

