Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 983BDC04FFE
	for <amd-gfx@archiver.kernel.org>; Tue, 14 May 2024 08:52:12 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3D8D710E8C9;
	Tue, 14 May 2024 08:52:12 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="NpQfXurk";
	dkim-atps=neutral
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2041.outbound.protection.outlook.com [40.107.93.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 94A0E10E8C9
 for <amd-gfx@lists.freedesktop.org>; Tue, 14 May 2024 08:52:10 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YhZGBxeGiP1TWwrXlFdRUtHwbWDpW6l+ntRTxFA6IEalmbkkRzd8nAzHV+18//VGvAlzUvbZgVbH4snQsnZh4J/0aTs7V4XS9NeaLgGtDoR8RAGeaQnOowO3VY2j04FZ2tVYmJ/hgv6OPOeJaxFDsja2z0/7p3BwyzzjMfzoz8nU1QQmUIvmm/O0N1dXY1cPWcfGuLM4+pHCyD3gCfkXnXtlH3v+U7kdpf9mRkZKrv3HL9UMbAFREREm5BUgiMHwuLMkua3R9PBjR4xy8Jf9QG3HakkdjlKazVEkbMxnLtm2q4NiWgD0MvTDpRRcLVFHPsHBk8UH6bxHwiwrq+NbuA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rmJ2f0vG7/4rYTZPdTvjxoCZUA/GLuNhfAv3nR262oU=;
 b=FP2bItkiLmpV6HH0fkZ6KJ/HKqfS+kNeNpNRlq8YR47VUsAG/ug4Xvle79lW3NsTIDqZ4mtYxamF5W7q77/srNwhfWhIiZrw6k6EfRARCIIosbrHdgQhozlZcoeN/lLX19iVsm9heY6UFjCi0RjOxQV4H8LM2GpN1Ouq3e2wcw/EOinvI4Srtmhy7EvCv/B7Hl+rjUpt6e+MODa/E+vpfnsoN5Hjvg3pT6W3Z9YS8gZsrWOUQIU9Bg5/K/I4ZKGoAITgc6kPPfw8naUM9DyXTNyxxPW807vNemJ8Ju5Pe7KyZKLuXxTXPWX3OkXTJSyWLrsI0HpVPFnaWIHOdCMkXQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rmJ2f0vG7/4rYTZPdTvjxoCZUA/GLuNhfAv3nR262oU=;
 b=NpQfXurkGyOBVlkbOFogdC0U9LH+1FMMJ8lk8SkfgtXmpDVzfewDjcdYhBv8TXTHYfZFqJkfL8TYTfZo9s7Rr9qW7tmSKaCKsjazStqrsQe4exLzmh7joXUEsvZYA0/ZTTaDR4XjqjpWu2rCAttrgodk3041ypw6Z331AapJchI=
Received: from DM4PR12MB5181.namprd12.prod.outlook.com (2603:10b6:5:394::22)
 by CY5PR12MB6154.namprd12.prod.outlook.com (2603:10b6:930:26::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.55; Tue, 14 May
 2024 08:52:08 +0000
Received: from DM4PR12MB5181.namprd12.prod.outlook.com
 ([fe80::b1fc:750e:c91c:6d7c]) by DM4PR12MB5181.namprd12.prod.outlook.com
 ([fe80::b1fc:750e:c91c:6d7c%5]) with mapi id 15.20.7587.025; Tue, 14 May 2024
 08:52:08 +0000
From: "Gao, Likun" <Likun.Gao@amd.com>
To: amd-gfx list <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 7/8] drm/amd/pm: add pp_dpm_dcefclk for smu 14.0.2/3
Thread-Topic: [PATCH 7/8] drm/amd/pm: add pp_dpm_dcefclk for smu 14.0.2/3
Thread-Index: AQHapduIggfX1NXEgUW768odA1pa0bGWbDAw
Date: Tue, 14 May 2024 08:52:08 +0000
Message-ID: <DM4PR12MB5181722372AB2FCBD7B006A3EFE32@DM4PR12MB5181.namprd12.prod.outlook.com>
References: <20240514084751.3438103-1-likun.gao@amd.com>
 <20240514084751.3438103-7-likun.gao@amd.com>
In-Reply-To: <20240514084751.3438103-7-likun.gao@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ActionId=6e9ce8ac-d923-49ba-af40-3fa890824ea0;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=0;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=true;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution Only;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2024-05-14T08:51:46Z;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM4PR12MB5181:EE_|CY5PR12MB6154:EE_
x-ms-office365-filtering-correlation-id: 8b2ea3f0-5d64-47f2-89c2-08dc73f32342
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230031|376005|366007|1800799015|38070700009;
x-microsoft-antispam-message-info: =?us-ascii?Q?4I+bdol6ph8pJJT/PV1rCMfy7KCBZtEMNrhsRVeK0A7RxVdeyqwe/XTe4CGq?=
 =?us-ascii?Q?np7OBenDCTbEZVNbw+2/aAO7hIXeHoFC05kk9lJ5Nc/Q4V1VnnEJKMX6cf0Z?=
 =?us-ascii?Q?S+ly6a6puFFKOwA2TVPUOoiSwKEEUUyhn8JdZPo9sCUmaxqveD5Kvy/Ita8r?=
 =?us-ascii?Q?QFDMYSrhyxZAkBRs4RZofnbvZSGD4eCwxewfXZmswJVEHuN4PXOy9mDQFGad?=
 =?us-ascii?Q?NCmsXNhnUtrae2ra7+GeTCE3Q02vMYAs5zlSw19zVDqAy0KiQoaaGr56Hrip?=
 =?us-ascii?Q?MI1KCGQcTnALRWWJZ8ukleBpEqWAnaX01Q2NqUebV7hleAumQ23JcDIIv3b0?=
 =?us-ascii?Q?SJmFP0qL4s6Gao3BYZxQ5f6cNSnTOALVLBNV6yjIGG7wqX/n3lC7OHMN94Dv?=
 =?us-ascii?Q?703hN5yBsxtuAhBtFuLGc1NYA9s4GKvHL/4EvIQvS4Uig4OZipINUqfjK+9n?=
 =?us-ascii?Q?LrFVEejOHAONxMCM/n0AfXf4KvWAXc0NL3OcANmK2l5CwRv3GOc1LKCCDWkI?=
 =?us-ascii?Q?8bu2444Kadh38gTw1iBSyu4cMsPta7yOw5R/z6UYvEPB22P8/uBDDn2G6/Uv?=
 =?us-ascii?Q?mbJ2OH1q6zauRO/c4RRA9/gnD2cJu5glXWF7H+Lz1OYcsKlXzAsrxkFq7Zq2?=
 =?us-ascii?Q?9qUiut6Q4Tsv7+TBrwoVUbc/rTBW16dUoAsyv+yV67CVQa9QPSU7rT2elidO?=
 =?us-ascii?Q?5R0vVyz5pde9oEKEPIgveGY/KCdhRzyN5UfvTX5tBGlRwNtyTEXRGQA2Syqg?=
 =?us-ascii?Q?OidIJxQ20oZjpk+loh+8B9jeDWs4PqiLoJfEDmi2QZGPhVVfjNTbGZv8ngp2?=
 =?us-ascii?Q?fnx9EkYluh7hyhS8WIv8sFQTOdeFG+bQjKQ5aSbB9pqonW//e8G4/iqqOB+W?=
 =?us-ascii?Q?t+y9PdDXzQbsCkrkmpZTwDEFcyYEPCumxUTGG4iC7HpLDT98mlk8+oQU6RRH?=
 =?us-ascii?Q?XbJtVMHtaD2m8IywLTBr2K3W9IVR5cEGYIH832PsqcgV6asWMKI8raMLKKbO?=
 =?us-ascii?Q?uIKNqcepcMC0h28Xh9dvtTKUXNX/DA+ZNl5zrcx1s4ZdYJ6YM4dcDqgcNSrn?=
 =?us-ascii?Q?hic0AmF3DF80glrcVR9uWEC6dExmcnaMLKsTzArj5ziBrZyONie50o7bKMty?=
 =?us-ascii?Q?X0/GUNU7rsUNeKUj+MQCnrnndn4tGZohLUWdfpAJ9xXKF2Mku9D9v94WFS+x?=
 =?us-ascii?Q?RYy7GAieEKj6PyOkz+Gm73jBuFC8YcD0RWaBiurExEjHSfDXlIP80AL6SZhe?=
 =?us-ascii?Q?G9NcfFp0OcXbc3MSciPqvGLYx2nTB77kPKO+gkMbAmODUg6oXOZu+JWpK4o4?=
 =?us-ascii?Q?1mZAcHzwFdKsGwwRGfFKU3PF?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB5181.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(376005)(366007)(1800799015)(38070700009); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?Tz0m/PR7OIAudw6gkF9PeQyeeq5Q27DA0qjUcB4VG7UM1OJvaZHThikP6ty2?=
 =?us-ascii?Q?JEsiIuhEsKNEaHuHa4QKVMnzdk8TWYoUBWZp8oxf22L0YZEnGBYWOTFX5OT5?=
 =?us-ascii?Q?6zuZudgsTBEwy4Y9eSr994iU4LARcilDKEb2YXD8QIfh6FoQnLX2yWIdIvDL?=
 =?us-ascii?Q?0k59XNTCCCX+O91DTT7sYu+UQGwHYC7oLQK8qNGz4aKxvcdIBYKhwixBXoJz?=
 =?us-ascii?Q?sy+AaG3M53JO9FRQ87nOgo1hn7TxpVU7xLbFDHWJNY+YxtzTvDgNAumGayxf?=
 =?us-ascii?Q?dhCX4qxGO1PtBFldFeNl2ZU3inLDZQTeo7VI/ApDxYentPk4ZGN61dlDcGJt?=
 =?us-ascii?Q?v2YMFYyYqXO/3QFW7enGBv3Ggt1Xgo8nQETf54K7OIwze3YY3X1neHYGCTVl?=
 =?us-ascii?Q?5kNzldTBTFLWUfaUz/BL6xOz2FVeDShaGzohPKejzQ9vIHuzEFjpX9QL+3jM?=
 =?us-ascii?Q?1vLEzLqZvusUST6yYdyMTqEGwM9PsRM+srEphACFfZ1PMqQAIaZjYlYuA3fJ?=
 =?us-ascii?Q?XoqDyFdxJ5QfEVGHL2XmtLSZb7yLr6y8iORqDrbqtWIjzFM6PfKyTx5PCOjg?=
 =?us-ascii?Q?1w38QJwdTg3lZB7sEKEWKTt5ZKgjC7RTvE9yuqd6xe1XJF5fPL5lu3UNR5CR?=
 =?us-ascii?Q?8HMu/M0rkkxN9LglVCScx2yNmikpNhIKL7HEnjGgqTZKZRHtqmUKzOj1zrhC?=
 =?us-ascii?Q?Z5CMyYWjpIjCFsY6KLYt8nGa7ySmuRyVacM9ikYeF7g5vHew1Eh3m7V8h5Rg?=
 =?us-ascii?Q?XQYH2HPVdz36N9js21mMZvOvMe2KyoqxxOa9b5pQbieRJPhgxVxFSmfkY+eq?=
 =?us-ascii?Q?Ua5PEMq49WvtOUBlGTySN2oAdeQLL3NSRuv5Q0zZNOGRCI/h/7cZm+7izEmr?=
 =?us-ascii?Q?TecQN3IgP0l79rmLx4RxGdswgi6ahwngwBi2XrvSsfY6qp7t+IJ7hctivT5b?=
 =?us-ascii?Q?t5TpMzk1ALORKuHYcgE2WYsznhshWLPIifdQ4aImUIBqekI2oHF1vA2e7Jmc?=
 =?us-ascii?Q?qncwmwymsVhMK7IIc2f7XLMhvs7rGgenDD+HLVRJuVkoS0ORoxHi/Nyls5RN?=
 =?us-ascii?Q?tbYvfmUNJx14gP24wV2L+IUYYP/qYRWkhYQJsFvYt9x6+blCW1cD5LEuiSGR?=
 =?us-ascii?Q?Dmiuj5b4x7jbUXgXiZ7ebxOwGWn2WUyHkJbSbu76HighVwZ9aBxxs4bLo4JH?=
 =?us-ascii?Q?ZnTxUdGoxoKClduSsXjz2IYzktLzLdN4rl7qI6M9fHxqVWE6oouZBE9JpU+9?=
 =?us-ascii?Q?uPcMXjye6o4dyql/fuHiMYHq2myLZCcHXxAj7wHRTcrkxA7agfvtnO5NMxnp?=
 =?us-ascii?Q?JnjkKNFfuT0oKfSwMYfIkzuJWLxkuNclQn/MRovpD5K6yn9NPYTCkR7BZ+aA?=
 =?us-ascii?Q?2u9Ysdevc9wV3jdzLP44bSVdeGe1tcoa3xWy8HEOLTWLOFfKRent7az6SK9p?=
 =?us-ascii?Q?1OLVQtLBbsmCzFU/Tedc6bksas42nh+y68YIGI9zQV/Whi/CAZ+OBqG91FHW?=
 =?us-ascii?Q?DekjXHsbWis11s1iGTe9TonqHX/QULFWjC5kR5U2lEb1QHj0TRwCoCQJLeCm?=
 =?us-ascii?Q?U1nhHtpegOqnikYDmy8=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5181.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8b2ea3f0-5d64-47f2-89c2-08dc73f32342
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 May 2024 08:52:08.5315 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: lOih8P4N+3/PFyxO1GgCu0V6enkztuMM4MMTssfO1fZHSmbmVvo2lJ3vWXrZa7dO
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6154
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

From: Kenneth Feng <kenneth.feng@amd.com>

add pp_dpm_dcefclk for smu 14.0.2/3

Signed-off-by: Kenneth Feng <kenneth.feng@amd.com>
Reviewed-by: Jack Gui <Jack.Gui@amd.com>
---
 .../drm/amd/pm/swsmu/smu14/smu_v14_0_2_ppt.c  | 24 +++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0_2_ppt.c b/drivers=
/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0_2_ppt.c
index c22be56024d1..0e27cde82193 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0_2_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0_2_ppt.c
@@ -133,6 +133,7 @@ static struct cmn2asic_mapping smu_v14_0_2_clk_map[SMU_=
CLK_COUNT] =3D {
        CLK_MAP(MCLK,           PPCLK_UCLK),
        CLK_MAP(VCLK,           PPCLK_VCLK_0),
        CLK_MAP(DCLK,           PPCLK_DCLK_0),
+       CLK_MAP(DCEFCLK,        PPCLK_DCFCLK),
 };

 static struct cmn2asic_mapping smu_v14_0_2_feature_mask_map[SMU_FEATURE_CO=
UNT] =3D { @@ -676,6 +677,22 @@ static int smu_v14_0_2_set_default_dpm_tabl=
e(struct smu_context *smu)
                pcie_table->num_of_link_levels++;
        }

+       /* dcefclk dpm table setup */
+       dpm_table =3D &dpm_context->dpm_tables.dcef_table;
+       if (smu_cmn_feature_is_enabled(smu, SMU_FEATURE_DPM_DCN_BIT)) {
+               ret =3D smu_v14_0_set_single_dpm_table(smu,
+                                                    SMU_DCEFCLK,
+                                                    dpm_table);
+               if (ret)
+                       return ret;
+       } else {
+               dpm_table->count =3D 1;
+               dpm_table->dpm_levels[0].value =3D smu->smu_table.boot_valu=
es.dcefclk / 100;
+               dpm_table->dpm_levels[0].enabled =3D true;
+               dpm_table->min =3D dpm_table->dpm_levels[0].value;
+               dpm_table->max =3D dpm_table->dpm_levels[0].value;
+       }
+
        return 0;
 }

@@ -1000,6 +1017,9 @@ static int smu_v14_0_2_get_current_clk_freq_by_table(=
struct smu_context *smu,
        case PPCLK_DCLK_0:
                member_type =3D METRICS_AVERAGE_DCLK;
                break;
+       case PPCLK_DCFCLK:
+               member_type =3D METRICS_CURR_DCEFCLK;
+               break;
        default:
                return -EINVAL;
        }
@@ -1047,6 +1067,9 @@ static int smu_v14_0_2_print_clk_levels(struct smu_co=
ntext *smu,
        case SMU_DCLK1:
                single_dpm_table =3D &(dpm_context->dpm_tables.dclk_table);
                break;
+       case SMU_DCEFCLK:
+               single_dpm_table =3D &(dpm_context->dpm_tables.dcef_table);
+               break;
        default:
                break;
        }
@@ -1060,6 +1083,7 @@ static int smu_v14_0_2_print_clk_levels(struct smu_co=
ntext *smu,
        case SMU_VCLK1:
        case SMU_DCLK:
        case SMU_DCLK1:
+       case SMU_DCEFCLK:
                ret =3D smu_v14_0_2_get_current_clk_freq_by_table(smu, clk_=
type, &curr_freq);
                if (ret) {
                        dev_err(smu->adev->dev, "Failed to get current cloc=
k freq!");
--
2.34.1

