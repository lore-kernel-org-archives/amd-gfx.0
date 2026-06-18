Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 09C7DCD98ED
	for <amd-gfx@archiver.kernel.org>; Thu, 18 Jun 2026 06:32:15 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9637010EC4A;
	Thu, 18 Jun 2026 06:32:14 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Y7AYxThO";
	dkim-atps=neutral
Received: from BN8PR05CU002.outbound.protection.outlook.com
 (mail-eastus2azon11011046.outbound.protection.outlook.com [52.101.57.46])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EA30510EC4A
 for <amd-gfx@lists.freedesktop.org>; Thu, 18 Jun 2026 06:32:12 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KgPjT1kNPj53B58vTh8e0d7f8JYFz4GL2xOgJ0B9vYiZ6An3xaLWH0Zm5PF/hf2RnWK0Qrz98w8f8oK9apHJaeYdXcJIpDKu/ROxw2oBF4EEAsxmRu26EnW3abdrAKp4OiMg+caCmrF2vCIc8Jvm5Zt4yen5i3n0/NTfLDXtQfzwQ9hTmApX/EioYfTSJsRWrYx5PdZNw4xB+si54LEd2QkQogqamzcRGBt7aURiaova0BRV42+gwHkdKmrE+FaXj5O5hxs3OYGIwcyi9mJ7h1ZKp1gqie+GMukzeE/J0VHXCzuHmWLeQHlYvhQYKzKCEWHlihDimjbJggL0Skni0w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0wVVme0wpKxYcMpta9GSkSC+H1MOhz0uX9KILgTMtlg=;
 b=GWZr2ZzmCBnn264Lvxvs5lWGfApwLo/mtmncSBTTjXc0E9MCzK/iEGNIH2v9966D6n0U2VmK2drlyM8PazQPjVMl96I/yN1S5ce9Vs2YvUQbxBSTABI/lblZ+haVRde1mjxsd025yfO0hFzUKi31myMV50P6SEp8iqhplqk4t9upJu4kLEbnIcmnhtMnmOhiAaBhSGytuvZACWNLMBNrh6VWQyI8SPBJu4fmBZRK11FRc+JiQ2M/zb/TPEVLo1V60JOPx50Kcoq/NIkdEfHlW7CfZialh4Ngf7SYlwosV5GP/k0Bk2w6y18wGgBtKNl+ywprJGQmGcVAU5h2kZwqtg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0wVVme0wpKxYcMpta9GSkSC+H1MOhz0uX9KILgTMtlg=;
 b=Y7AYxThOMsshwsB2wXix/HgR0Frr92DxIQd1ImbH4yM6HmOPW0aM/B8shQxEA5BPZKnXjhXFe+WxCgXeEWN+k+PdY9VBxmqmP2oyH4i7AjqFgusH79GrDlzCUbqJD3CxgZRJWOwfrgBDae3uClZ/fRdKSXcmXWaeZYiPzbadOqM=
Received: from DM4PR12MB5038.namprd12.prod.outlook.com (2603:10b6:5:389::18)
 by LV0PR12MB999093.namprd12.prod.outlook.com (2603:10b6:408:32e::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.139.11; Thu, 18 Jun
 2026 06:32:10 +0000
Received: from DM4PR12MB5038.namprd12.prod.outlook.com
 ([fe80::3c29:3d93:2028:85c4]) by DM4PR12MB5038.namprd12.prod.outlook.com
 ([fe80::3c29:3d93:2028:85c4%6]) with mapi id 15.21.0139.011; Thu, 18 Jun 2026
 06:32:10 +0000
From: "Kamal, Asad" <Asad.Kamal@amd.com>
To: "Wang, Yang(Kevin)" <KevinYang.Wang@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
CC: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Zhang, Hawking"
 <Hawking.Zhang@amd.com>, "Feng, Kenneth" <Kenneth.Feng@amd.com>,
 "zdenek.koprivik@post.cz" <zdenek.koprivik@post.cz>
Subject: RE: [PATCH] drm/amd/pm: fix amdgpu_pm_info power display units
Thread-Topic: [PATCH] drm/amd/pm: fix amdgpu_pm_info power display units
Thread-Index: AQHc/uJjAdDwS6E55kWAWv7rX29nl7ZD2o3A
Date: Thu, 18 Jun 2026 06:32:10 +0000
Message-ID: <DM4PR12MB503885BAABACF5B95AC425DA8EE32@DM4PR12MB5038.namprd12.prod.outlook.com>
References: <20260618052135.2334397-1-kevinyang.wang@amd.com>
In-Reply-To: <20260618052135.2334397-1-kevinyang.wang@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Enabled=True;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SetDate=2026-06-18T06:31:57.0000000Z;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Name=AMD General
 v26; MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_ContentBits=3;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Method=Standard
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM4PR12MB5038:EE_|LV0PR12MB999093:EE_
x-ms-office365-filtering-correlation-id: 9b64f423-3115-46fa-67bf-08decd035374
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|23010399003|376014|1800799024|56012099006|3023799007|11063799006|38070700021|18002099003|22082099003;
x-microsoft-antispam-message-info: k9LZ7IlQb1kZIEkS9TespOtPfwWlF2lsFeMdFaaZjdgl7YZD3XaTbobvx6a4BzCoYpm/YrF2qfaZftQbOUHHyfPk+qSmzbmB3l6yaOaWdZWHXEZ396q8m54w+gkDT5jLqQIvIWVA2fbQFo7fLwsbKfthRTvS2bCyjifn96CbvDZJFD+jOQyRRR0V/xBIVNe49bgrNCBJNh/6mNaavzKJu5L+D2VdoFzJjaBpsnicwckrwngqkoS3kDf98npLhecTTCuKjOiPA1eCDO6yuNSa1pGXbwul7o7sCj/w2Y2eOZ3rbHwvySj1woiB9ZU+ep8zOB0mh2VA9wHYGwzPauhyTC6GNVj0GEjKzoxeOTuS3wzUxO5Q5HqI2n5tqmfud3nCMXs/L8WE3zpJvDudmL9g3AD3HJLiQ/1jJAJNlGkCOu78zBdTeX1FKxLpBlclZKkfItk0ZkZt3OILa9Qe177SEDEAndBnw1wCaBF92gYsqG6k0JUzOBfVfaTsO+/sOy9KhXXNVLK6sEvPutTTZWl+8KVNX+2lPDlYNdI9iEUm3lNfPpzE8xfVJvYbdbp4DTUkM7pCjtL5YwkeDMax2WPlfBMUgJgAVv6BKSUmNkpSk9ISDDCwz1263ankzOzzDmI1koaUXIkaEHRNE+SMog7F0V1CS7ynJTUlnX5/IqFUW4FuiZl3fM0nKcqjOMgYOHoL0PVsTJ4Ol3oYIRRPALL2S0nfIMih0W1yxvgndZZr3jx2qN2DxeP/AE82S8N9Hv2T
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB5038.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(23010399003)(376014)(1800799024)(56012099006)(3023799007)(11063799006)(38070700021)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?e74MWn0gnskhgTbc7VG0w9hNVUCVfa2PiE7OpyLHaEU7mpLoIU4n6Dt9PXe6?=
 =?us-ascii?Q?29BaJ0CSW5lIhU6ecIiDQhvCYvxmRQkEey26JubCAzYL1yqsIh8v8zsF9gPJ?=
 =?us-ascii?Q?fTCkQfrv+TBukme68iTJ2zkx4O4HvWtlYQTY3nqxTMWdSn9FB/Bn3TkgtEyy?=
 =?us-ascii?Q?ymYQNILKR3kPVZ8yNPDwY6D9ORh7tsBJvIOzppMNcOiLlvm2KtOQzoeMNESA?=
 =?us-ascii?Q?dj93PKJMJxl8uk9e3hJKWGXuCp+pIamzqvlehmzzd9uO9xUMaG1QHtpfjqcu?=
 =?us-ascii?Q?qBV++PprU+B97C8UVHuMCqqLiMVxUWQJ0xG9L2w94PVkVimygzuSSazT8VSe?=
 =?us-ascii?Q?JKns2TRlTkmRBYA6zUYMJ5a0pQVWBrJMMpC3wPx/m9q4e4d9sOCYtJrhrEAh?=
 =?us-ascii?Q?+irqiriMXsMf/w3Aq0TtuA+rKzsfqRFVqJvwWK4plvLUOnf+RFvl6EhEC9Ea?=
 =?us-ascii?Q?SN/K68FXjqlVjUTN2Kb7j76zQBB1GN0LJvC4bVj+aeqD4++ssjIh2RTNJs4V?=
 =?us-ascii?Q?ctNXNB6AGt/XU5ZkwdFRCw/peF4cKYhY2hwLNHVTrod1kZ1yk6UmfdG2ccqk?=
 =?us-ascii?Q?1/QQ84B1/uW1LgR+eO+L9RnD5xNdfqjpzvPglkE3EWoZpvNclkcpLk34o/sd?=
 =?us-ascii?Q?c+rXNlcyAuQcTkDXHMCN5LulPGgZBzqSMN0+B5UPQSxSsQ1nrKAfDwTmhPF8?=
 =?us-ascii?Q?R9wleB+gv6R6ZbwhHX+bsfp96PMNhMAfa2fiyklNjn5D9FyasmIcqEz63//X?=
 =?us-ascii?Q?yT+JjrUCddHl5i6T5U46TSBSfMPNUBM2IN8USmwv1ft2vwEn6BpJNKPWJCZ1?=
 =?us-ascii?Q?4PdW3Q3TVrh6LXv8Te6WNQFjNOnL2niVItpDKpRSKqc7e/banypPd4xyDA80?=
 =?us-ascii?Q?+UAMuQOpMnve6IIgaDnPHe80zgms/T0zy0JbtAl4ho06Egy9vnmBX8/ltrPd?=
 =?us-ascii?Q?5OQBdHxYxdzQMsmNxx9ds81kaP/C2Mmqfa7q/krr7pO4vO8VR+BTLiTmPcsQ?=
 =?us-ascii?Q?v1jZEIdE5mT8srAR1bE9IESqpchtMKy8v9kvzw7AYu/c1oxRerAHubdx1hvE?=
 =?us-ascii?Q?oFFOTxSVmt6D6GdX0Fyh6xBGlmQOA7RtiYOhvBpgvqw2Y35ilYSyg4iUbwiI?=
 =?us-ascii?Q?7RNeSSk3F3xUWsI6NTtEufa2o4pn+KRGkVCir1ChsL+1L0uBGcHw5XSOMgab?=
 =?us-ascii?Q?AxzRsUZ/NziVtt6yxspaeNhMLP3nnwHmcbDxd2m8a6k8LmvI9FLS31Y1QJDe?=
 =?us-ascii?Q?9v/7VIbmYw0LxuETh8tFJa4IlKTBZSTCJjh62H/bUz+jm7cxuVxvR6pXZzM/?=
 =?us-ascii?Q?VTHz7IzAJzCj/Z0Msio0JMIi5cejE8a+9IAY8uU05gP5unnVyHptbuzeqIKG?=
 =?us-ascii?Q?6UG1UehPOgIBGgEXiSmBmlAFk7jICf5dfni+D21EWJXXkHtWS86GVhAgXdoq?=
 =?us-ascii?Q?h4c8hnGR/M1iApRBS+X73/GYvLpiKiBcfKtomdteMmW91lyZ8PwpvEfiQM7z?=
 =?us-ascii?Q?sX1DdWrbSXeEhX788GbNLyPL5rZs5bS8nhdqJALbt9CLagl4pFNQNGFRgDQq?=
 =?us-ascii?Q?d87nh4+Z2hKoRUrnLKZGHWKCXjAt403vAyFLPj/ED04RnBRoGWTGf2YdYvVl?=
 =?us-ascii?Q?uVRtknclXsCbaUzMR9wbifceF8OtzFa/ud7LycewRaYAKkM7sbKY3YAQdkuj?=
 =?us-ascii?Q?Eb0Ik+24uctI5dp/ckvExOmVcnGaKJdxl/BXTwflzmgbXQ7P?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5038.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9b64f423-3115-46fa-67bf-08decd035374
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Jun 2026 06:32:10.1764 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: TpB1DVVuXQOwGI81z+C4btpcflFe1wEzLgMh5SG35kES1LUWbJnLespLRrB1pRedbVGLvJ5vl0kO483XOtdbVg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV0PR12MB999093
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

Reviewed-by: Asad Kamal <asad.kamal@amd.com>

Thanks & Regards
Asad

-----Original Message-----
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Yang Wan=
g
Sent: Thursday, June 18, 2026 10:52 AM
To: amd-gfx@lists.freedesktop.org
Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Zhang, Hawking <Hawking=
.Zhang@amd.com>; Feng, Kenneth <Kenneth.Feng@amd.com>; zdenek.koprivik@post=
.cz
Subject: [PATCH] drm/amd/pm: fix amdgpu_pm_info power display units

amdgpu_pm_info displayed power sensor readings with the wrong fractional un=
it.
It treated the low byte of the raw sensor value as the decimal part of watt=
s, while that field represents milliwatts in the decoded value. As a result=
, debugfs could report misleading SoC power when the remainder was not alre=
ady a two-digit centiwatt value.

Example with query =3D 0x00000354:

  raw field        value
  ---------------------
  query >> 8       3 W
  query & 0xff     84 mW
  decoded power    3084 mW

  output           value
  ---------------------
  before           3.84 W
  after            3.08 W

Fixes: f0b8f65b4825 ("drm/amd/amdgpu: fix the GPU power print error in pm i=
nfo")

Signed-off-by: Yang Wang <kevinyang.wang@amd.com>
---
 drivers/gpu/drm/amd/pm/amdgpu_pm.c | 21 ++++++++++++---------
 1 file changed, 12 insertions(+), 9 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/amdgpu_pm.c b/drivers/gpu/drm/amd/pm/am=
dgpu_pm.c
index f69bb77ecbfe..719b743adc37 100644
--- a/drivers/gpu/drm/amd/pm/amdgpu_pm.c
+++ b/drivers/gpu/drm/amd/pm/amdgpu_pm.c
@@ -41,6 +41,8 @@

 #define DEVICE_ATTR_IS(_name)          (attr_id =3D=3D device_attr_id__##_=
name)

+#define power_2_mwatt(power)   (((power) >> 8) * 1000 + ((power) & 0xff))
+
 struct od_attribute {
        struct kobj_attribute   attribute;
        struct list_head        entry;
@@ -3354,7 +3356,6 @@ static int amdgpu_hwmon_get_power(struct device *dev,
                                  enum amd_pp_sensors sensor)
 {
        struct amdgpu_device *adev =3D dev_get_drvdata(dev);
-       unsigned int uw;
        u32 query =3D 0;
        int r;

@@ -3363,9 +3364,7 @@ static int amdgpu_hwmon_get_power(struct device *dev,
                return r;

        /* convert to microwatts */
-       uw =3D (query >> 8) * 1000000 + (query & 0xff) * 1000;
-
-       return uw;
+       return power_2_mwatt(query) * 1000;
 }

 static ssize_t amdgpu_hwmon_show_power_avg(struct device *dev, @@ -4908,7 =
+4907,7 @@ static int amdgpu_debugfs_pm_info_pp(struct seq_file *m, struct =
amdgpu_device *a  {
        uint32_t mp1_ver =3D amdgpu_ip_version(adev, MP1_HWIP, 0);
        uint32_t gc_ver =3D amdgpu_ip_version(adev, GC_HWIP, 0);
-       uint32_t value;
+       uint32_t value, mwatt, centiwatt;
        uint64_t value64 =3D 0;
        uint32_t query =3D 0;
        int size;
@@ -4933,17 +4932,21 @@ static int amdgpu_debugfs_pm_info_pp(struct seq_fil=
e *m, struct amdgpu_device *a
                seq_printf(m, "\t%u mV (VDDNB)\n", value);
        size =3D sizeof(uint32_t);
        if (!amdgpu_dpm_read_sensor(adev, AMDGPU_PP_SENSOR_GPU_AVG_POWER, (=
void *)&query, &size)) {
+               mwatt =3D power_2_mwatt(query);
+               centiwatt =3D DIV_ROUND_CLOSEST(mwatt, 10);
                if (adev->flags & AMD_IS_APU)
-                       seq_printf(m, "\t%u.%02u W (average SoC including C=
PU)\n", query >> 8, query & 0xff);
+                       seq_printf(m, "\t%u.%02u W (average SoC including C=
PU)\n", centiwatt
+/ 100, centiwatt % 100);
                else
-                       seq_printf(m, "\t%u.%02u W (average SoC)\n", query =
>> 8, query & 0xff);
+                       seq_printf(m, "\t%u.%02u W (average SoC)\n", centiw=
att / 100,
+centiwatt % 100);
        }
        size =3D sizeof(uint32_t);
        if (!amdgpu_dpm_read_sensor(adev, AMDGPU_PP_SENSOR_GPU_INPUT_POWER,=
 (void *)&query, &size)) {
+               mwatt =3D power_2_mwatt(query);
+               centiwatt =3D DIV_ROUND_CLOSEST(mwatt, 10);
                if (adev->flags & AMD_IS_APU)
-                       seq_printf(m, "\t%u.%02u W (current SoC including C=
PU)\n", query >> 8, query & 0xff);
+                       seq_printf(m, "\t%u.%02u W (current SoC including C=
PU)\n", centiwatt
+/ 100, centiwatt % 100);
                else
-                       seq_printf(m, "\t%u.%02u W (current SoC)\n", query =
>> 8, query & 0xff);
+                       seq_printf(m, "\t%u.%02u W (current SoC)\n", centiw=
att / 100,
+centiwatt % 100);
        }
        size =3D sizeof(value);
        seq_printf(m, "\n");
--
2.47.3

