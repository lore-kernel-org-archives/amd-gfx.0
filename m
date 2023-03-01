Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 62BD5C64EC7
	for <amd-gfx@archiver.kernel.org>; Wed,  1 Mar 2023 08:27:48 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0AA2C10E0A7;
	Wed,  1 Mar 2023 08:27:48 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on20616.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:fe59::616])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7527D10E099
 for <amd-gfx@lists.freedesktop.org>; Wed,  1 Mar 2023 08:27:46 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=V7ISOH4Eh++DB6bM9ucQBq1QWe/Ay6f+nhsyg3h5zKj1JQ3AHtrlnV1/6TG3u7eA+3CmD2EiolcE17JFa0CBQ6t0Aiprx3F2T3t5IpfQXUChT7DjS2xal+fVaAX3nZ+xPbROq0Bki0rLD/zFU8VuJJXIJl66XaqSbixgqMyMw/nC/Ok5CquPQKw4AbHHLYQ1VzZexiMv5P0YD3B4T3lbfiO/INrraT4tOagjv0y6hVReY1PikEhApUnN6sUZ8TqYouGManusVEFXRJBFhnkuj3oGE80pl2YyVQ/oEZkYjx+7vajwSaao8yRHtiEY24BUK1SgMQO6tKRlUT+IbRLl1Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=K5XR27o17FbPmfjW60QqXP1E4gJFp3RGjtmmaugV+4I=;
 b=gTYJR2tiIZl/GOyEgJ2iYmSFYeG/yRxy2mXEJikAu7wAB/3t43fNlxXLp3o5c/9kwmGa4EYhTdOr52GabQTQ0HdPmSGfwpuJr6i4qsMmI24d853dq+Spi398D5uja3XVkYSG/9M93sNXx4QFErkG44QYTsjKsiqBN1SBGMlY7FvxqZOqSUzWm1m9as30vjJIMV4QA4A8nD1vOSBD0SvY/Za3u53kYIAR0+4BEXftG6+kvH6IietqUbE8ySVW2dW7V6xPToIcrgLT0N8pAned8gxJXRgLb1zS3QvA0UESBnf5gGoHXzysS+mztlZYcHkenCG1Q7pZp6HPQUo1bN69jg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=K5XR27o17FbPmfjW60QqXP1E4gJFp3RGjtmmaugV+4I=;
 b=VA2nXZo8hMcSt63FrDrhTXIG0LX+YWeZ91kZw6f8tVKzdFdfi7yY73G+veh1T7io0pcm5QLXy7bL0bJj4CLKQJITs11PkAlRRCX7ZGZFvARbAsoWHyw+wmK2eWE6u3Ous8uNFuTvJpvDbMz2zpMcbE53DL+wyTVyCaL26JMHc48=
Received: from DM5PR12MB2469.namprd12.prod.outlook.com (2603:10b6:4:af::38) by
 CY8PR12MB7612.namprd12.prod.outlook.com (2603:10b6:930:9c::6) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6134.26; Wed, 1 Mar 2023 08:27:44 +0000
Received: from DM5PR12MB2469.namprd12.prod.outlook.com
 ([fe80::5ca6:3a18:d6ee:c103]) by DM5PR12MB2469.namprd12.prod.outlook.com
 ([fe80::5ca6:3a18:d6ee:c103%7]) with mapi id 15.20.6156.018; Wed, 1 Mar 2023
 08:27:44 +0000
From: "Chen, Guchun" <Guchun.Chen@amd.com>
To: "Li, Candice" <Candice.Li@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amd/pm: Enable ecc_info table support for smu v13_0_10
Thread-Topic: [PATCH] drm/amd/pm: Enable ecc_info table support for smu
 v13_0_10
Thread-Index: AQHZTASDOAUriof5g0SaQiEkyU8Ewq7llrhA
Date: Wed, 1 Mar 2023 08:27:43 +0000
Message-ID: <DM5PR12MB2469139A9D740760CF1C8EC4F1AD9@DM5PR12MB2469.namprd12.prod.outlook.com>
References: <20230301061001.16542-1-candice.li@amd.com>
In-Reply-To: <20230301061001.16542-1-candice.li@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM5PR12MB2469:EE_|CY8PR12MB7612:EE_
x-ms-office365-filtering-correlation-id: 238a23de-763d-4abd-a3b8-08db1a2ed456
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: DOLehCbOo5FoXQjbARpst0g6CFkpa9yL/5A6YdjzPey4a8MYBthWUxN401JvGKEdxLcVVDi2vq1MLFFz/WOASIf6l4pbLuqF4TBoNRB3g90eqUiDa069OsytbuKxiyKbYYL8MqsnUxd/qN8kP4JEfW9vj0YpZvFNhQKZyHI/9L9X0pNpxsI6GBtPj6hdCKf2DhuFijo5OrmjLuRfNqaX1yeqK30ieL4NdClCEr/z2aQW4QqFFg9kyBpWxlXSInpH6I6FbAerr3bMsjq6c0UJxlAxGPVA5YVFnlYeFqhy9jYb8iKXuHVjw5FlXTBl4UdJID3dT+V5vADIe/v5hXfKnEIZGi6QadFgTOM5pvZ6WzpfBR6w3s/tJq2G7y5kNayrODYXHm0aqwkX/aYEF+APx5QbaahuMe4yFhfc8cCPkwxXQTwUKiFVyHUv+Qg1qnOEJEYb4sUmhE9DUk7RO27A1kraDMQ/QlD1zghFl3RN98Loxc/xiWWZb5wcxodIIONG8NeFtUQPCTGHczaY72PAHP3/UjbaeQf87i/H5fXJgMLJNV0zACubmstr+c/QnYBoQbqKst0P0u50/Haoh4JsRS2XMaMctA4BN3SHYosJ5gK3mjPEnYqGtxLXzi9t2tjXnaDACpvYG7mHUcwRbipkwnPEvcG+GOGfrij/yQV1vEBHvwhoNkCqjzbUJs9RApuN5eAF16Tw96MClSgIoft+0g==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM5PR12MB2469.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230025)(4636009)(39860400002)(346002)(366004)(376002)(136003)(396003)(451199018)(9686003)(53546011)(26005)(6506007)(186003)(38100700002)(83380400001)(33656002)(38070700005)(86362001)(55016003)(122000001)(66946007)(8676002)(66476007)(66556008)(4326008)(2906002)(64756008)(76116006)(8936002)(66446008)(5660300002)(52536014)(7696005)(71200400001)(41300700001)(478600001)(316002)(110136005);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?x2RuOS8JPxs8iNaC+vx8KuXI1amnYPWPFZnoHl/EG/zlKfQJgSFDfN/V60y5?=
 =?us-ascii?Q?9oLFGBNoUoN+1jBeWNDPXZGr6dxMdxRERPPvQwPSdGNnW2Ee27N2t/BpFUmc?=
 =?us-ascii?Q?fqk6O6PKDywxcb1qqfYUB8UyXp8b/mHwJyaNDhwhdtE2YhaDtz8D5puPrbB5?=
 =?us-ascii?Q?6vqGDgIqZCn0APNYaROZjbOEi7dNyfgolqGWhz0I+FAxxX9ZlaQBewxdNYk7?=
 =?us-ascii?Q?ErRLbZtOfhuhAR4QP1hcVaEvEdERgsPZuXcsqDAMeDYOA3C5PclZmdtpq/zA?=
 =?us-ascii?Q?LsMZPHE1tr/uxht/mV+Eh8PItclIfqI5VKqtxeeExFFCmFELjUmg4ZBhXyGW?=
 =?us-ascii?Q?X1HagYSzKctJbSDu9jZlPYpaDrNKxZQtW/k8hviEFsoNW2j/XY0a7ewMllyb?=
 =?us-ascii?Q?YwQPcbcZ7kQHCI0O5gL6Jr1Ia22eHAiWdrvPFVTdPd4IUcjTxEHaSJ6O18we?=
 =?us-ascii?Q?s34Xv8uayaQ0XHJ6UXV91PCTCENEguufjsmaG7azF6UphhGblvT4LjZj6AcS?=
 =?us-ascii?Q?pnLTh5j770rZZ8tucd77GqMTgyCJnpJZcdduNCgDlpLp9UhjFxXTh70glWR1?=
 =?us-ascii?Q?NfUrydpp0r4hVbEYekzKHVmo17DxXWd7f/Ru1PuD+br/qn+IASOrUq4bYOrl?=
 =?us-ascii?Q?a6VhKowPAnq+9fYilxZ72Q0aX2zj/tIzBlbrMdGWxgv5/uX22UgzvIOIPe7m?=
 =?us-ascii?Q?1Vk7UBJh64UW5/CBwbTpcFw0FsR1F3bHWRHc6QzIWJBPsiqMd+QlbBGUx0/1?=
 =?us-ascii?Q?4xHMwdps6X66QoaaxJFt5ExDOn+Ln/E3BRDzkh/rw/Wz72RsIGhcl3cgwfDS?=
 =?us-ascii?Q?gRyvgL6iPxQnsC8o4JwUn4r771Az+5PAiNZbpqoZSD0h9t8+zGSGjKUpwvR9?=
 =?us-ascii?Q?5ItnldbUWRSj1KwAkXHZm0+ONtkvYfRamKTDWOaDDhoxD/OlWh/4YCgHYAro?=
 =?us-ascii?Q?ngxhA7x1Vs/UZWG2y7dW+o2IzqrJDlye/FYadQJ0onfszB6rpBxFapj7ABok?=
 =?us-ascii?Q?6JjDn55ROwXcbvPpetsUAEAkXYjdiPZh1b/D46N3MSqlurICvxJH5rr7sdO/?=
 =?us-ascii?Q?vs4yr9uzWtSMtJzVaMKN9jc125xQgxJGHwRs0pftt/luVAyM6dVOQtTquIJ+?=
 =?us-ascii?Q?6BcioVJ9wbj6enDnEQxqpb6E6QqTWT99v9Za9qvo1tgSeY8q0g6BOnY1pyjX?=
 =?us-ascii?Q?XpvDpqV0V1rMLd5WqQgpXTIrnmpBA9nHWDZCybqZBSTBl8VXzmCd/Uum0J0f?=
 =?us-ascii?Q?DA+nXgoysvIaTX65aFpUSOX/a6oLLhjBpv34zbXxBTy9PwgMcbuBl6T30o71?=
 =?us-ascii?Q?mlLhWmabVEYG+osQlRnUKjzQ3LVCHPxYOY2TsA6YDFDM5lK2C7HsaldhIK+K?=
 =?us-ascii?Q?wdXQlzmn20ZiPGQsXKUu5jJS5YJ5kMvSWIS7BSTkBFF4bCdZL5rILe+Z1603?=
 =?us-ascii?Q?RE9unWXhC1NdmzfVcABAGSBBl6/AjMimPyy0nfsy1mCVG23tWCR3nbwOfgPj?=
 =?us-ascii?Q?xg9DhEWz4iuIspPfz1i7dtHereVd7nYnbJN4oCniOKJnZHh6Ff9WB6D6kUg0?=
 =?us-ascii?Q?/F4oIwmYY/3I08KHESGgVa3L87jQwHna7CMrfDso?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM5PR12MB2469.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 238a23de-763d-4abd-a3b8-08db1a2ed456
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Mar 2023 08:27:43.6010 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 5qC1iCd18UIA+F7MshdcRnYexjV/TcNi2vKK0ugG3EILuWxLWPIFC3NpLZ9yNmRWDRKxVJXrOIXFO1kM91rXSQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7612
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
Cc: "Li, Candice" <Candice.Li@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

ret =3D smu_cmn_get_smc_version(smu, &if_version, &smu_version);
+	if (ret)
+		return -EOPNOTSUPP;

A nit-pick comment, looks querying if_version in this case is redundant, pa=
ssing NULL may be more efficient.

Regards,
Guchun

-----Original Message-----
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Candice =
Li
Sent: Wednesday, March 1, 2023 2:10 PM
To: amd-gfx@lists.freedesktop.org
Cc: Li, Candice <Candice.Li@amd.com>
Subject: [PATCH] drm/amd/pm: Enable ecc_info table support for smu v13_0_10

Support EccInfoTable which includes umc ras error count and error address.

Signed-off-by: Candice Li <candice.li@amd.com>
Reviewed-by: Evan Quan <evan.quan@amd.com>
---
 .../drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c  | 75 +++++++++++++++++++
 1 file changed, 75 insertions(+)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c b/drivers=
/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c
index 923a9fb3c8873c..27448ffe60a439 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c
@@ -46,6 +46,7 @@
 #include "asic_reg/mp/mp_13_0_0_sh_mask.h"
 #include "smu_cmn.h"
 #include "amdgpu_ras.h"
+#include "umc_v8_10.h"
=20
 /*
  * DO NOT use these for err/warn/info/debug messages.
@@ -90,6 +91,12 @@
=20
 #define DEBUGSMC_MSG_Mode1Reset	2
=20
+/*
+ * SMU_v13_0_10 supports ECCTABLE since version 80.34.0,
+ * use this to check ECCTABLE feature whether support  */ #define=20
+SUPPORT_ECCTABLE_SMU_13_0_10_VERSION 0x00502200
+
 static struct cmn2asic_msg_mapping smu_v13_0_0_message_map[SMU_MSG_MAX_COU=
NT] =3D {
 	MSG_MAP(TestMessage,			PPSMC_MSG_TestMessage,                 1),
 	MSG_MAP(GetSmuVersion,			PPSMC_MSG_GetSmuVersion,               1),
@@ -229,6 +236,7 @@ static struct cmn2asic_mapping smu_v13_0_0_table_map[SM=
U_TABLE_COUNT] =3D {
 	TAB_MAP(ACTIVITY_MONITOR_COEFF),
 	[SMU_TABLE_COMBO_PPTABLE] =3D {1, TABLE_COMBO_PPTABLE},
 	TAB_MAP(I2C_COMMANDS),
+	TAB_MAP(ECCINFO),
 };
=20
 static struct cmn2asic_mapping smu_v13_0_0_pwr_src_map[SMU_POWER_SOURCE_CO=
UNT] =3D { @@ -462,6 +470,8 @@ static int smu_v13_0_0_tables_init(struct sm=
u_context *smu)
 		       AMDGPU_GEM_DOMAIN_VRAM);
 	SMU_TABLE_INIT(tables, SMU_TABLE_COMBO_PPTABLE, MP0_MP1_DATA_REGION_SIZE_=
COMBOPPTABLE,
 			PAGE_SIZE, AMDGPU_GEM_DOMAIN_VRAM);
+	SMU_TABLE_INIT(tables, SMU_TABLE_ECCINFO, sizeof(EccInfoTable_t),
+			PAGE_SIZE, AMDGPU_GEM_DOMAIN_VRAM);
=20
 	smu_table->metrics_table =3D kzalloc(sizeof(SmuMetricsExternal_t), GFP_KE=
RNEL);
 	if (!smu_table->metrics_table)
@@ -477,8 +487,14 @@ static int smu_v13_0_0_tables_init(struct smu_context =
*smu)
 	if (!smu_table->watermarks_table)
 		goto err2_out;
=20
+	smu_table->ecc_table =3D kzalloc(tables[SMU_TABLE_ECCINFO].size, GFP_KERN=
EL);
+	if (!smu_table->ecc_table)
+		goto err3_out;
+
 	return 0;
=20
+err3_out:
+	kfree(smu_table->watermarks_table);
 err2_out:
 	kfree(smu_table->gpu_metrics_table);
 err1_out:
@@ -2036,6 +2052,64 @@ static int smu_v13_0_0_send_bad_mem_channel_flag(str=
uct smu_context *smu,
 	return ret;
 }
=20
+static int smu_v13_0_0_check_ecc_table_support(struct smu_context *smu)=20
+{
+	struct amdgpu_device *adev =3D smu->adev;
+	uint32_t if_version =3D 0xff, smu_version =3D 0xff;
+	int ret =3D 0;
+
+	ret =3D smu_cmn_get_smc_version(smu, &if_version, &smu_version);
+	if (ret)
+		return -EOPNOTSUPP;
+
+	if ((adev->ip_versions[MP1_HWIP][0] =3D=3D IP_VERSION(13, 0, 10)) &&
+		(smu_version >=3D SUPPORT_ECCTABLE_SMU_13_0_10_VERSION))
+		return ret;
+	else
+		return -EOPNOTSUPP;
+}
+
+static ssize_t smu_v13_0_0_get_ecc_info(struct smu_context *smu,
+									void *table)
+{
+	struct smu_table_context *smu_table =3D &smu->smu_table;
+	struct amdgpu_device *adev =3D smu->adev;
+	EccInfoTable_t *ecc_table =3D NULL;
+	struct ecc_info_per_ch *ecc_info_per_channel =3D NULL;
+	int i, ret =3D 0;
+	struct umc_ecc_info *eccinfo =3D (struct umc_ecc_info *)table;
+
+	ret =3D smu_v13_0_0_check_ecc_table_support(smu);
+	if (ret)
+		return ret;
+
+	ret =3D smu_cmn_update_table(smu,
+					SMU_TABLE_ECCINFO,
+					0,
+					smu_table->ecc_table,
+					false);
+	if (ret) {
+		dev_info(adev->dev, "Failed to export SMU ecc table!\n");
+		return ret;
+	}
+
+	ecc_table =3D (EccInfoTable_t *)smu_table->ecc_table;
+
+	for (i =3D 0; i < UMC_V8_10_TOTAL_CHANNEL_NUM(adev); i++) {
+		ecc_info_per_channel =3D &(eccinfo->ecc[i]);
+		ecc_info_per_channel->ce_count_lo_chip =3D
+				ecc_table->EccInfo[i].ce_count_lo_chip;
+		ecc_info_per_channel->ce_count_hi_chip =3D
+				ecc_table->EccInfo[i].ce_count_hi_chip;
+		ecc_info_per_channel->mca_umc_status =3D
+				ecc_table->EccInfo[i].mca_umc_status;
+		ecc_info_per_channel->mca_umc_addr =3D
+				ecc_table->EccInfo[i].mca_umc_addr;
+	}
+
+	return ret;
+}
+
 static const struct pptable_funcs smu_v13_0_0_ppt_funcs =3D {
 	.get_allowed_feature_mask =3D smu_v13_0_0_get_allowed_feature_mask,
 	.set_default_dpm_table =3D smu_v13_0_0_set_default_dpm_table,
@@ -2111,6 +2185,7 @@ static const struct pptable_funcs smu_v13_0_0_ppt_fun=
cs =3D {
 	.send_hbm_bad_pages_num =3D smu_v13_0_0_smu_send_bad_mem_page_num,
 	.send_hbm_bad_channel_flag =3D smu_v13_0_0_send_bad_mem_channel_flag,
 	.gpo_control =3D smu_v13_0_gpo_control,
+	.get_ecc_info =3D smu_v13_0_0_get_ecc_info,
 };
=20
 void smu_v13_0_0_set_ppt_funcs(struct smu_context *smu)
--
2.17.1

