Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6574DD58CBE
	for <amd-gfx@archiver.kernel.org>; Mon, 23 Mar 2026 04:06:03 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EA24C10E366;
	Mon, 23 Mar 2026 04:06:02 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Fq5hyNyD";
	dkim-atps=neutral
Received: from PH0PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11011058.outbound.protection.outlook.com [40.107.208.58])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3197910E3AC
 for <amd-gfx@lists.freedesktop.org>; Mon, 23 Mar 2026 04:06:01 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wvITr5f2qopA+MiWo/EnckBVCekCLocTssHTAOIKZ3xL/nS61TEKvY7Mqxp9hX5zxiScl06gQGMj7NVt2abKjiEDd3th+2OVDQJGm7vLvoEODCaRDnzMIkvdv46fMBP3wJB9h4e+9+g7APpCmnt1EiK+iACSn9jz9OilwNG3/hab64IfVXDm2PIzEzlruGgZXAkq1nanATLoIDmKXOpKRkM4u2emw/6jRj6Cl2tN4p2lXN7d9BHk8Ehc2rfYCwcVYg+ouw3DOE8d60qIp4s6EkcY53HjWW9Od4FhM0UX8T8l8lGsoJdb2bOq4/U+ENSDbzw03vyoIUxWDqHUxc85sA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=trytq5t3PRSaDgyLXja6k78M7NWeXxLH8DR1KJjdi4A=;
 b=GBJut+eeY7NoIiBHQodbJla4PGanL8zrwuOn0UhCmWJv3G5XC6uWYjoW0fpamkAnvtppxg/OK54Eg7yhnWNQLewIpTbcP53fsdyx4zTZiya0woKzkKw/qjGxK09RwTJOr688nFdrHF1muevMYKwRcP/QEaW43qCltzyWxACRMxq3MWgFJ+h/OZOqNRQUA/ZDvdIRO+QA2K4FSSnVTEeIjmdR7yNY+X014aa2/FNKRO8GC9Di+E5SL7xhqe/BdG7PIKntBmn+m1LMqX/LOT3CmWeXV5ZdlSsUv4OggxKFzNi5dPVnOmjG77kRuJH2SVJHQ0iKesqWLSojgT5ICguQQQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=trytq5t3PRSaDgyLXja6k78M7NWeXxLH8DR1KJjdi4A=;
 b=Fq5hyNyDfOFp+F1hEX27lucCIplZqvOnIOcK6rOwZF2tsI+W2ZDeBvWtbbaVWK5XMTlKQnF79cRH0zzsoAe1Nm9jN7OKnUm/HV4G81I+kY1wj9nJtkzCRrGEbSiZ158VuNwL7ATf1bxP6D0oy0oCbdctnma0ng5y6Pao5xGcng8=
Received: from DS7PR12MB6071.namprd12.prod.outlook.com (2603:10b6:8:9d::11) by
 MW6PR12MB8900.namprd12.prod.outlook.com (2603:10b6:303:244::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.15; Mon, 23 Mar
 2026 04:05:58 +0000
Received: from DS7PR12MB6071.namprd12.prod.outlook.com
 ([fe80::6f14:4646:fb11:829]) by DS7PR12MB6071.namprd12.prod.outlook.com
 ([fe80::6f14:4646:fb11:829%3]) with mapi id 15.20.9745.012; Mon, 23 Mar 2026
 04:05:57 +0000
From: "Kamal, Asad" <Asad.Kamal@amd.com>
To: "Wang, Yang(Kevin)" <KevinYang.Wang@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
CC: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Zhang, Hawking"
 <Hawking.Zhang@amd.com>, "Feng, Kenneth" <Kenneth.Feng@amd.com>, "Lazar,
 Lijo" <Lijo.Lazar@amd.com>
Subject: RE: [PATCH] drm/amd/pm: add dedicated dram addr msg for smu v15
Thread-Topic: [PATCH] drm/amd/pm: add dedicated dram addr msg for smu v15
Thread-Index: AQHcumh0hQzi+Mh63UmUCeU9IN9WlbW7f9ug
Date: Mon, 23 Mar 2026 04:05:57 +0000
Message-ID: <DS7PR12MB60710414048B709ADCD618458E4BA@DS7PR12MB6071.namprd12.prod.outlook.com>
References: <20260323015732.564251-1-kevinyang.wang@amd.com>
In-Reply-To: <20260323015732.564251-1-kevinyang.wang@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=True;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2026-03-23T04:05:51.0000000Z;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution
 Only; MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=3;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS7PR12MB6071:EE_|MW6PR12MB8900:EE_
x-ms-office365-filtering-correlation-id: 2b50c377-b68e-489d-335b-08de88917cae
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|376014|1800799024|38070700021|18002099003|7053199007|56012099003|22082099003;
x-microsoft-antispam-message-info: kfvgQkc+EF0q+lSF/dPtVC/j5/qSBiCWx/XN12130G9sIgPe/dsLEewM9MrW7ZixAYhs3qo1so3EdOieg5Qd8hAVhZhIg1WeU7FpmUzAcoy2efJzUDBSAOAZHTyf39I6iVavVKCN6D1NjnFblbX2XRXaI8qX4F/mJ6pBCFlwuLwX97ZoulQoPfQ0go8PtoufeJ6imVMj/wfbMwkhVMCPTPnftfc9i2hCMnvlgkCWkKb9QAFCucAe1huDO4kldEGBy6AdjkgsUsj7MwDGhaj8DXQjfU3o4Qtk6V8VSJ/0erZen3XSW9plWF27IkKU9OET6ggvlaMqNvrobDzrT39Nr9yCKwYKFk3S77GtyWF7SsI25z6PdbDzjxVy5BDsvTi5KxpUnxsqZmD+3p6x1JjXem1AeGJooxw2W2DHNZvqtIW2I8UFo/HsJVIh6jwo1BAhCyjNDHUC+TVYDc/5JB2Io+yERlGw9a+i8Ule+41Y3t51UB1XStIY40oA6GXGLeJuHkrHxYfw4RbAhVYqDudKZtZCCl5Ewtyj+XWr9bDKKNI+3PIm915ZHUF/+kIBO4H9/tDOmEdiUIjsbULs7QGDh1QzyEh2qQOMef+K/4iE7iRLco1ngWjLR83kL7Qn8O/6+wnO43ylB2iVIIh0UPqRLMYistq4/skryrwyWwwAVeqILqSrzot3sXpwRDGD3tLrc7RGVWDCAHEy2TjSTAfNqnaBJ2Pw85Vpb7g6VvIAWoITjbkdpBoZl2WGgKSw0Wq2zS2XAog3xgy1ixmsTN56nzkAHLgtLTO279Gli9bn+b4=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS7PR12MB6071.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(38070700021)(18002099003)(7053199007)(56012099003)(22082099003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?KJtudDUB+bbXwa6XE/m2GuNoAGCqXGy8TSQNyPhr+30/RoBObERwXoUeCo8A?=
 =?us-ascii?Q?SdeCR4WOuwk3udmYF0AhumS1TzwEEqmG92Ji1FBXCLcivHlFlS6cilmg39I3?=
 =?us-ascii?Q?rO7H6oFWjHVptTW0JAzQl3iiPHMaY03cQ0y0sXjVQRD45fWNr4+2tmethebE?=
 =?us-ascii?Q?aRKVUafaFHF5RdScqLVCYDufaBv6pXZ3XzkL/x45ZAlyBJKszW5SA4g+LVZg?=
 =?us-ascii?Q?LqtnJJJiOMPpVSTMBFkAo9pYQzs2JZHK471JvQUpDi5h+SMcS4I1AJGEzAt2?=
 =?us-ascii?Q?R23ONVI1P0PYT8DMCEwTF3HEqF+fnzM3snkTCrtgCepVVuQuHxmg6xdgKWRD?=
 =?us-ascii?Q?YBvtYm7QsM11VqSlcqPGGUBb9U7qjQVRmnO2fNawAFdGWpnnvidAZjRdebwp?=
 =?us-ascii?Q?ytXRg6BROarYScyf7gcQgr/do3G7vb4sG21WjsPc5ChlNkWDCM28h1CMTHFC?=
 =?us-ascii?Q?lxmzCdiD6aj0mOHLUYE17h4CiiBs+vrRrc2jBfRvRakHvK7HCkFUbqlaOUn8?=
 =?us-ascii?Q?/rnurtFDfhZcve2GpMs8i8o2dDDlFrZA6qKmllup/M+auB1syEt3ngp2MsNz?=
 =?us-ascii?Q?wkBWwbZ1LZmKxc1j+5ihn8cdBod21xxkrGk5Nhb78UJPJ8j75BNIpRBkttOd?=
 =?us-ascii?Q?ngG/NLVXhPKDe5na0YzV6QGhn72S2PKRFAOYwjHfEPz9GMTrNuDWd7xRXpiF?=
 =?us-ascii?Q?yc+h+c1N52zQIbqyQ33cdmpMGpzDJaWSkFjgF4jhyIBWaREDnuaSGFFmGKkR?=
 =?us-ascii?Q?DfEewi/0v4mhfw8kTZTdyB2jME396t/czTFjl4hgb/uuJvvXCnwpCblhWKzr?=
 =?us-ascii?Q?O0fHY88P80FC+dPT7aN7EXovyiC+F4oYCp/jMaaFIgSQ9CYssfCf3P5YFox9?=
 =?us-ascii?Q?RseHo9TC8B3GGCRCLeHJTvH2KwC2zaNxCKBqLuReKr+5/okCU1N6Pq1u+54/?=
 =?us-ascii?Q?hy1i3wsKlOepfJlwAks+nydtbyRDDuQwZZQfMVmajdfycYsR9YPDz3naJzEG?=
 =?us-ascii?Q?xm9CnlhCavne8pJSVSJrbPmdQW1P/JS4RuQytOmdFs78+KyDUKkDYGvshqei?=
 =?us-ascii?Q?ZQZu2mhmtaOSL+2Z9tnY73P2wf+fqzN6SqDtjkEFaBzIYdYzIfcstS1cu6bO?=
 =?us-ascii?Q?e946IFX57LGgER878I7UeTEbRho61sZtUSEQWWtX1Sh/QfdtlOTj5I/GXQQK?=
 =?us-ascii?Q?mpcsZMC67zDrhCuflF+RQT4I+gAOvHEG+pxUwMAb/CU39jnt+iZYSAkeR8Fg?=
 =?us-ascii?Q?HsQBEKdrV6gnO+CjV/Oa4HC9a0B4obA0OlKa5NwxuZFTmyTrGcv12/JF8sbO?=
 =?us-ascii?Q?NOku7keQXPuSx+kRbOYUhiGx7Q3R/DR4zWfrduXy9h6JoP5ZPVmHkCa/FyKV?=
 =?us-ascii?Q?aUE6YH4mpeDgwxVnnCiygkxrPTdIm5M+1sADKhH4RhUhkSojZclS+9T0oEUA?=
 =?us-ascii?Q?Jky37vs43ZLt6RTevtXahcAF3IKgglasavq7EN0TLJIGrtdsJhneZlUK0tsi?=
 =?us-ascii?Q?wkCnrAfU7+sE4BQCOEJzZ25rSwGXEqG217ob+DNkyyvUkrLvaUPXG6zY20RD?=
 =?us-ascii?Q?lpxkQISgYHS30aNiPhp4t2QEaAI5Xt6cEQZxfvps70YKsy0ZUfCA9g8W1qKQ?=
 =?us-ascii?Q?wz0PZ2hAWBvwcmnqspL86Pp9MHY61hYNeA9JuY78bKWNkDLdUCa6t10lj5it?=
 =?us-ascii?Q?S0nSv5nwp6q8StpLQ+kcwbIhIYKi5/6mpk1xEgkgcsuomZCC?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB6071.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2b50c377-b68e-489d-335b-08de88917cae
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Mar 2026 04:05:57.6465 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: jvltDtGM4Txvter5J7HOXvbAbvk/DHOizR+/mjRJ1LcfI5QXHj3eT3bmX0EtrZMagprDO/q2qieWEO7P3o5Jpw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW6PR12MB8900
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
From: Wang, Yang(Kevin) <KevinYang.Wang@amd.com>
Sent: Monday, March 23, 2026 7:28 AM
To: amd-gfx@lists.freedesktop.org
Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Zhang, Hawking <Hawking=
.Zhang@amd.com>; Feng, Kenneth <Kenneth.Feng@amd.com>; Kamal, Asad <Asad.Ka=
mal@amd.com>; Lazar, Lijo <Lijo.Lazar@amd.com>
Subject: [PATCH] drm/amd/pm: add dedicated dram addr msg for smu v15

Add dedicated SMU Dram MSG mapping to avoid conflicts in SMU IP v15 common =
code for upcoming ASICs.

add new smu msg:
- SMU_MSG_SetDriverDramAddr
- SMU_MSG_SetToolsDramAddr

Signed-off-by: Yang Wang <kevinyang.wang@amd.com>
---
 drivers/gpu/drm/amd/pm/swsmu/inc/smu_types.h         | 2 ++
 drivers/gpu/drm/amd/pm/swsmu/smu15/smu_v15_0.c       | 4 ++--
 drivers/gpu/drm/amd/pm/swsmu/smu15/smu_v15_0_8_ppt.c | 4 ++--
 3 files changed, 6 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/inc/smu_types.h b/drivers/gpu/drm=
/amd/pm/swsmu/inc/smu_types.h
index fc31cc5e97c8..636ff90923d9 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/inc/smu_types.h
+++ b/drivers/gpu/drm/amd/pm/swsmu/inc/smu_types.h
@@ -42,8 +42,10 @@
        __SMU_DUMMY_MAP(SetPptLimit),                  \
        __SMU_DUMMY_MAP(SetDriverDramAddrHigh),        \
        __SMU_DUMMY_MAP(SetDriverDramAddrLow),         \
+       __SMU_DUMMY_MAP(SetDriverDramAddr),            \
        __SMU_DUMMY_MAP(SetToolsDramAddrHigh),         \
        __SMU_DUMMY_MAP(SetToolsDramAddrLow),          \
+       __SMU_DUMMY_MAP(SetToolsDramAddr),             \
        __SMU_DUMMY_MAP(TransferTableSmu2Dram),        \
        __SMU_DUMMY_MAP(TransferTableDram2Smu),        \
        __SMU_DUMMY_MAP(UseDefaultPPTable),            \
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu15/smu_v15_0.c b/drivers/gpu/d=
rm/amd/pm/swsmu/smu15/smu_v15_0.c
index 966fa0238ad0..8e95a62e186c 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu15/smu_v15_0.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu15/smu_v15_0.c
@@ -611,7 +611,7 @@ int smu_v15_0_set_driver_table_location(struct smu_cont=
ext *smu)  {
        struct smu_table *driver_table =3D &smu->smu_table.driver_table;
        struct smu_msg_args args =3D {
-               .msg =3D SMU_MSG_SetDriverDramAddrHigh,
+               .msg =3D SMU_MSG_SetDriverDramAddr,
                .num_args =3D 2,
                .num_out_args =3D 0,
        };
@@ -626,7 +626,7 @@ int smu_v15_0_set_tool_table_location(struct smu_contex=
t *smu)  {
        struct smu_table *tool_table =3D &smu->smu_table.tables[SMU_TABLE_P=
MSTATUSLOG];
        struct smu_msg_args args =3D {
-               .msg =3D SMU_MSG_SetToolsDramAddrHigh,
+               .msg =3D SMU_MSG_SetToolsDramAddr,
                .num_args =3D 2,
                .num_out_args =3D 0,
        };
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu15/smu_v15_0_8_ppt.c b/drivers=
/gpu/drm/amd/pm/swsmu/smu15/smu_v15_0_8_ppt.c
index 5938e88726d2..89a44b456e8a 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu15/smu_v15_0_8_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu15/smu_v15_0_8_ppt.c
@@ -87,8 +87,8 @@ static const struct cmn2asic_msg_mapping smu_v15_0_8_mess=
age_map[SMU_MSG_MAX_COU
        MSG_MAP(GetMetricsVersion,                   PPSMC_MSG_GetMetricsVe=
rsion,               1),
        MSG_MAP(GetMetricsTable,                     PPSMC_MSG_GetMetricsTa=
ble,                 1),
        MSG_MAP(GetEnabledSmuFeatures,               PPSMC_MSG_GetEnabledSm=
uFeatures,           1),
-       MSG_MAP(SetDriverDramAddrHigh,               PPSMC_MSG_SetDriverDra=
mAddr,               1),
-       MSG_MAP(SetToolsDramAddrHigh,                PPSMC_MSG_SetToolsDram=
Addr,                0),
+       MSG_MAP(SetDriverDramAddr,                   PPSMC_MSG_SetDriverDra=
mAddr,               1),
+       MSG_MAP(SetToolsDramAddr,                    PPSMC_MSG_SetToolsDram=
Addr,                0),
        MSG_MAP(SetSoftMaxByFreq,                    PPSMC_MSG_SetSoftMaxBy=
Freq,                1),
        MSG_MAP(SetPptLimit,                         PPSMC_MSG_SetPptLimit,=
                     0),
        MSG_MAP(GetPptLimit,                         PPSMC_MSG_GetPptLimit,=
                     1),
--
2.47.3

