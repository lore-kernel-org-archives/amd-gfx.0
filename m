Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 14EBFC55174
	for <amd-gfx@archiver.kernel.org>; Wed,  5 Aug 2026 08:23:53 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A2DD810E0DE;
	Wed,  5 Aug 2026 08:23:52 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="aQFZn/+f";
	dkim-atps=neutral
Received: from PH8PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11012013.outbound.protection.outlook.com [40.107.209.13])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4959010E0DE
 for <amd-gfx@lists.freedesktop.org>; Wed,  5 Aug 2026 08:23:51 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oEOBKsiTQn+uAaZvDzsDIr7mMQJKDZh5Kmrp7lPbVN2xdHa4Veeq+7otrfdFjZPcjpTWiIhMmm/cvpyE+TB+gKRExLFd5Xcr8U3WswlfyVvAMlUy8WeyAirytNV0ISOXCwYRp2BfR1CdbCLiegWK7/BAciP/LHhJVgpRN2GBL8WbhBI67K73PKanIHDbqItYKm+ykT8CGCwm2RTNYKXzJhHXxLIG0YptPCDmcz6m/GhuOIdcr7/6utFuvzfuQck5UgC9kPXlafxg2cbOzd3fPLjLAB3XAxDjYOXpuV6924w9oSgTVw4pEP1uvcCAbQXt69qJL19Q0pYYQ77MX9GlRQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=p6uH291Fahoj29ccbu2wFVOh5yrA1hZR1HIeRqRXpyY=;
 b=J3M9syOSekU01/BKE1MUz17VBoYawKO7U1MGf4XZKY9tu4Jv1yR5C4Ue5IwVSx//2GS7BQYST45Nrw8xszCYHmokEHBWPc+HJe7emj+8FeptjeCAr5+3KQn6bpPdzfuppwyZhL9u9rrsyjBMmf/fTlAuY2f/T+46aUWySFuJt3wyJfU5hpjxg6c31aTq/pEya2wDFvI01G297FkkxP8s7sGqX28UmBQ5Odph2MuP/Dowzp/LeFzjCxFbxQUJAbDZokdQrB2M+E9WhYZ/YejeZwr/p0dUUiPj0rG8oIE+mwPSA/7J6pwrrvKkoM5YbrU7AN1JgDzMksUBRP4QwS3mrw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=p6uH291Fahoj29ccbu2wFVOh5yrA1hZR1HIeRqRXpyY=;
 b=aQFZn/+fXaoDV3mi6PUqIK4fGwEi25kWKhprpcBTZfTT9LHqj9RInME1usoVlIC/rNc2Pr+g84u7lly5UtZ/yMn2hezG+l3IlkTmoWMj7Aej9RtByykUvuwbJZ0GUtrwCMjTajxP/dcMCJGeulx2XL43WjCi/xj6ky2O/gwfbew=
Received: from DM4PR12MB5748.namprd12.prod.outlook.com (2603:10b6:8:5f::19) by
 LV8PR12MB9643.namprd12.prod.outlook.com (2603:10b6:408:297::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.270.18; Wed, 5 Aug
 2026 08:23:47 +0000
Received: from DM4PR12MB5748.namprd12.prod.outlook.com
 ([fe80::6c62:e99c:480d:2729]) by DM4PR12MB5748.namprd12.prod.outlook.com
 ([fe80::6c62:e99c:480d:2729%2]) with mapi id 15.21.0270.017; Wed, 5 Aug 2026
 08:23:47 +0000
From: "Kamal, Asad" <Asad.Kamal@amd.com>
To: "Lazar, Lijo" <Lijo.Lazar@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
CC: "Zhang, Hawking" <Hawking.Zhang@amd.com>, "Deucher, Alexander"
 <Alexander.Deucher@amd.com>
Subject: RE: [PATCH 1/3] drm/amd/pm: Simplify SoC power printing in debugfs
Thread-Topic: [PATCH 1/3] drm/amd/pm: Simplify SoC power printing in debugfs
Thread-Index: AQHdI++xx4qTPCkW80Ck3wZiUonzaLaPH1VA
Date: Wed, 5 Aug 2026 08:23:47 +0000
Message-ID: <DM4PR12MB57485C416DA1361F455824AB8ED32@DM4PR12MB5748.namprd12.prod.outlook.com>
References: <20260804085953.2947798-1-lijo.lazar@amd.com>
In-Reply-To: <20260804085953.2947798-1-lijo.lazar@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Enabled=True;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SetDate=2026-08-05T08:22:49.0000000Z;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Name=AMD General
 v26; MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_ContentBits=3;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Method=Standard
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM4PR12MB5748:EE_|LV8PR12MB9643:EE_
x-ms-office365-filtering-correlation-id: d166a9c9-9fbb-48f0-2610-08def2cadf4d
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|23010399003|1800799024|376014|11063799006|10067099003|56012099006|18002099003|22082099003|38070700021;
x-microsoft-antispam-message-info: bnQlYaHcwdWgtVpGlbP0z+n8yl0EJ1QnWElogSoK8XS4gdMjf9itNyhhaPoFOtTEzUQdPh/qVDSOve4Fhf26luo/OzBUjTHiZVDNJEp53wIbQH2g+byumGgSDwGrH4ptyMPhjGvqUdVWL0xq6hyezcAMD4NFOjtGxA/V5RPy9i0uQBJCYnBBlG1kIf4Px8oIcChxTAXLq4bcQ6zGk4g3PS2xlJQ66z5/P7fpcvyn/g5TQc6cqw6Yu3TWO9zWuRiJuxL8UXNA90ejcHDL1+q84CSUH7gwYr+P1tPMkbOyGORrLPv8ZrXqAoxFum16lQMVG0lRd+nYBUyMB0lBf+gGxZJdGwqCTJiuj+OXlKMSPxZQcI+nvtZdVcQ+4vAfGNPoBrmxVslqJd58mu1+INfxHRyJ1NZgK330M2NrGwLfRyY06DybCJ0HEgg0OPG5iccu/0CpWbs7y3wJLqCdZLdZtLENDHVVDc1ecVnkZZrD826UgdzgWZ+udY0j5F70weKAH9XwysFrjBT0cnJtRzMiFypnZwL0h1+QvI0Qa8k4SyFCAD0MwFwFWQuydSj3pQLbtyEO6GlA+tob24P6+BlsipFJnIX8N28VyBwfEK+diqPW1FrM+sCBwEVlOv2LWxfr98iKZFW2bykpG5mk7cXZEk7JvhYMPir9p3QYT0h8TuvrDvRE/DDfn+FMRydqOR5Qk5bCP2SOwN+tTgrcCe6+ZSf4F63+DQBe2Oqef5jMftc=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB5748.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(23010399003)(1800799024)(376014)(11063799006)(10067099003)(56012099006)(18002099003)(22082099003)(38070700021);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?db+utax39DO4ewJcO2grK2vq7ggQ2KxZe79StSg787xcAhFy2P7VeaTVwUPs?=
 =?us-ascii?Q?neFpmuznAFTSYvMwu3wWM0FdbL7PvxZV6hg97WBi9N4VCee/Ndv3G2m4eCWN?=
 =?us-ascii?Q?4PhqUXIw5cQhJPS8pjAvM/UH0xUFnjfaIohwxYM7tF1ZB0yEkdOxMrSgXYiG?=
 =?us-ascii?Q?1niQauwsVuxf0c/BjKRHIgYPtqzs04SIubDw6Mf6iKkTDYxkogGhKZQFvvaS?=
 =?us-ascii?Q?N/+3y0JpQTrqBELfhYoYagiA1YUiuDc/w4YFZikZMuxADfB1CRc/pulXpdbL?=
 =?us-ascii?Q?Twpm1OCCIa+htz1PckcUkn8Ux0MCBNoyKwVfSZ7MooLOiYjlmM1ZjQIk1rqF?=
 =?us-ascii?Q?TwgLo3KREpMTz58LzitcCa4aTvFmAbT1xEOmFu+q/bwrBKq5ppt2KZKicrs1?=
 =?us-ascii?Q?vR0eknAh8Hnvx1N3N6UsrLq1iqIMs4a/FbpoqS5g7H/qStMDhPelMfTQWYHE?=
 =?us-ascii?Q?5AZInIK4ZH7yvFphkUTsPJ/qKyH0t6yUK+YSdfikDeTEJ2JW/i7jzK4nMaWz?=
 =?us-ascii?Q?HQpvWCntnqEhi0hKXVTehDCVaPo32ZF5ebfG1zhc4JIiR4C3k6ySIaLmvBii?=
 =?us-ascii?Q?oRENZy4Ui5JhJl0OdMbKXQ45GjT4Fj0SvqMJdnIYfHZobgSo+ccYL4t7IZQz?=
 =?us-ascii?Q?vht1prV77g9WvZVqrlKwml+Jca3G0JU/kmyu+Xg+0g/37+m0inia9ew2WLTI?=
 =?us-ascii?Q?KjZO0VoWVOYMPavzAPM2vP6TeDaKCduk2su9BAhx1IetAWeI8uUQt1EAMHme?=
 =?us-ascii?Q?XlSp4Ann9Crt67xPi75r+pneIr7J1ah/3aa65KHj8kMMUKVKqiz8yty9eosk?=
 =?us-ascii?Q?Luj7mO9hZ5lySiq81AU17fFQtQr+Fb9pc8+adzFOsQ2jimte/bw5HnmIWmI0?=
 =?us-ascii?Q?y2V/1el6ekcikpvbO3ezbN95wcRTbYp8snU+O18rCoxJQM5aOJf3Jnu119Dn?=
 =?us-ascii?Q?lK2aqilS5NGw5DNiVT6oOV9VTNzRyb04yeI2q50wHomGKg22TBpeDvMg+/Ev?=
 =?us-ascii?Q?g1BVOcPkzMjXUG39p5hMg9dN9VFLcqGEOlnBUbwyTZIbMgrYkO9ap+EVrv0a?=
 =?us-ascii?Q?C2qbNrw2uR+YUrVmT1QJbiH1Y2DsAYqdXwOCutqADmMaZBGGVX7IAjJYEyKW?=
 =?us-ascii?Q?AQrZsqFVibHj6p4xpdptcUJ2Jc6AovnLu6nO7XBzLhHJNIIo+5cUwepWFIeo?=
 =?us-ascii?Q?7n2XrrZ0FY7k+dqhipIf4GN20nOOEGm/wwE8ChaoklzRZ38dCNJDyU0BA0AT?=
 =?us-ascii?Q?r1nyHVzq7usjxbeU4YpQMiNE+5VBXyvmZdne312R3Hjy2tnLEP5O7uePqx/0?=
 =?us-ascii?Q?DRvFTWQu47h/BE5OjlP6P4u6rGdUBlqPtTK/JxIi4jqo4Mg13xzfuJswbpn1?=
 =?us-ascii?Q?DHUk9bw6R6YBRNX7JOgXUl5QQnTFD4k30IBaeczouxkRa6ZYHLvH+TMwKtDf?=
 =?us-ascii?Q?1zdNoeq9/vcypnl+8byOYoVo4AD6ADe2VWvz6womJt07YvJKcp8yzWEGHlyW?=
 =?us-ascii?Q?ZNnhgroxx1GicFnCIMo1Em14io+j4QcpKy0kiMiVBnVgYPGaiTpDfM2DTRh0?=
 =?us-ascii?Q?mGyf0o1sbO6ZyNG0q+bQjdy4w4FM+GrTPbRxgKilihAR0DxlD6VtLMbEJ9l4?=
 =?us-ascii?Q?/v0rq+pa4fqWcrpSXw7KmzpuZzZveA8SrQ018Pp8WzFM1UUr/yaJ/nOSii7B?=
 =?us-ascii?Q?2nBZI1LiJHDM8lTB7aL6qB8e+v793Cd/s/+m4l3xmBh2IAix?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5748.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d166a9c9-9fbb-48f0-2610-08def2cadf4d
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Aug 2026 08:23:47.6321 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: jwImY8U2k90V5QCfwfLPXkIV0YaSKPnxhJRB7Tl2kgo7+OiKRMYWtKv1Hz1qbWfzVaJUyVUINDgDLNXRf4MDXA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR12MB9643
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

Series is

Reviewed-by: Asad Kamal <asad.kamal@amd.com>

Thanks & Regards
Asad

-----Original Message-----
From: Lazar, Lijo <Lijo.Lazar@amd.com>
Sent: Tuesday, August 4, 2026 2:30 PM
To: amd-gfx@lists.freedesktop.org
Cc: Zhang, Hawking <Hawking.Zhang@amd.com>; Deucher, Alexander <Alexander.D=
eucher@amd.com>; Kamal, Asad <Asad.Kamal@amd.com>
Subject: [PATCH 1/3] drm/amd/pm: Simplify SoC power printing in debugfs

Convert SoC power directly from milliwatts using MILLIWATT_PER_WATT and rem=
ove redundant variables.

Signed-off-by: Lijo Lazar <lijo.lazar@amd.com>
---
 drivers/gpu/drm/amd/pm/amdgpu_pm.c | 27 ++++++++++++---------------
 1 file changed, 12 insertions(+), 15 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/amdgpu_pm.c b/drivers/gpu/drm/amd/pm/am=
dgpu_pm.c
index 15b2923d5378..c0e677328af5 100644
--- a/drivers/gpu/drm/amd/pm/amdgpu_pm.c
+++ b/drivers/gpu/drm/amd/pm/amdgpu_pm.c
@@ -34,6 +34,7 @@
 #include <linux/nospec.h>
 #include <linux/pm_runtime.h>
 #include <linux/string_choices.h>
+#include <linux/units.h>
 #include <asm/processor.h>

 #define MAX_NUM_OF_FEATURES_PER_SUBSET         8
@@ -4876,9 +4877,8 @@ static int amdgpu_debugfs_pm_info_pp(struct seq_file =
*m, struct amdgpu_device *a  {
        uint32_t mp1_ver =3D amdgpu_ip_version(adev, MP1_HWIP, 0);
        uint32_t gc_ver =3D amdgpu_ip_version(adev, GC_HWIP, 0);
-       uint32_t value, mwatt, centiwatt;
        uint64_t value64 =3D 0;
-       uint32_t query =3D 0;
+       uint32_t value;
        int size;

        /* GPU Clocks */
@@ -4899,25 +4899,22 @@ static int amdgpu_debugfs_pm_info_pp(struct seq_fil=
e *m, struct amdgpu_device *a
                seq_printf(m, "\t%u mV (VDDGFX)\n", value);
        if (!amdgpu_dpm_read_sensor(adev, AMDGPU_PP_SENSOR_VDDNB, (void *)&=
value, &size))
                seq_printf(m, "\t%u mV (VDDNB)\n", value);
-       size =3D sizeof(uint32_t);
-       if (!amdgpu_dpm_read_sensor(adev, AMDGPU_PP_SENSOR_GPU_AVG_POWER, (=
void *)&query, &size)) {
-               mwatt =3D query;
-               centiwatt =3D DIV_ROUND_CLOSEST(mwatt, 10);
+       if (!amdgpu_dpm_read_sensor(adev, AMDGPU_PP_SENSOR_GPU_AVG_POWER,
+(void *)&value, &size)) {
                if (adev->flags & AMD_IS_APU)
-                       seq_printf(m, "\t%u.%02u W (average SoC including C=
PU)\n", centiwatt / 100, centiwatt % 100);
+                       seq_printf(m, "\t%u.%02u W (average SoC including C=
PU)\n",
+                                  (u32)(value / MILLIWATT_PER_WATT), (u32)=
(value %
+MILLIWATT_PER_WATT) / 10);
                else
-                       seq_printf(m, "\t%u.%02u W (average SoC)\n", centiw=
att / 100, centiwatt % 100);
+                       seq_printf(m, "\t%u.%02u W (average SoC)\n",
+                                  (u32)(value / MILLIWATT_PER_WATT), (u32)=
(value %
+MILLIWATT_PER_WATT) / 10);
        }
-       size =3D sizeof(uint32_t);
-       if (!amdgpu_dpm_read_sensor(adev, AMDGPU_PP_SENSOR_GPU_INPUT_POWER,=
 (void *)&query, &size)) {
-               mwatt =3D query;
-               centiwatt =3D DIV_ROUND_CLOSEST(mwatt, 10);
+       if (!amdgpu_dpm_read_sensor(adev, AMDGPU_PP_SENSOR_GPU_INPUT_POWER,
+(void *)&value, &size)) {
                if (adev->flags & AMD_IS_APU)
-                       seq_printf(m, "\t%u.%02u W (current SoC including C=
PU)\n", centiwatt / 100, centiwatt % 100);
+                       seq_printf(m, "\t%u.%02u W (current SoC including C=
PU)\n",
+                                  (u32)(value / MILLIWATT_PER_WATT), (u32)=
(value %
+MILLIWATT_PER_WATT) / 10);
                else
-                       seq_printf(m, "\t%u.%02u W (current SoC)\n", centiw=
att / 100, centiwatt % 100);
+                       seq_printf(m, "\t%u.%02u W (current SoC)\n",
+                                  (u32)(value / MILLIWATT_PER_WATT), (u32)=
(value %
+MILLIWATT_PER_WATT) / 10);
        }
-       size =3D sizeof(value);
        seq_printf(m, "\n");

        /* GPU Temp */
--
2.49.0

