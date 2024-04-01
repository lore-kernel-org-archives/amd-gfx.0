Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CA6FBCD128A
	for <amd-gfx@archiver.kernel.org>; Mon,  1 Apr 2024 01:58:20 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3E88B10E909;
	Mon,  1 Apr 2024 01:58:20 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="C4wNMMjd";
	dkim-atps=neutral
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2132.outbound.protection.outlook.com [40.107.243.132])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CF55710E909
 for <amd-gfx@lists.freedesktop.org>; Mon,  1 Apr 2024 01:58:18 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QVF3hqZMO0prWmA7niXuQomshtroqLeTe2u6nie2a516maun/j7A3FGHUGp+7W6uvXx85RfbrS+YJlieLi8owF3LbcoFFN9sY7wTwF0Qm8H57yRdnUpciKavNCb8VMBJMFQE5n4pQWJmC4iSh1g+dSHwOOvcPNeqh63k+pnfqvm2Tu40alTxrHx2G9fW7smnseQoLk704EeNb0Nyk7FgvZRpQFvkCVMfAyff4SZ7P2/6dl96eNh+cH5d9+zUNUQKLkBXJYPMTbrZQvJdSyfZHdJTwp8mNCMEjC6daQ1Akl/+z2JSC+Beehj4HhUpsU7ktQf2N7CA1LN9ODp71w3Zuw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JBSInbLC+/CFEDlnXKrQDdKXgJKtGul4Aph/Y5z/ZLE=;
 b=kySq4E0pQsECZdA6buq36KpHvn223Q1sexHHfI9Oan6QCwWypEzwYj3aaQvwouFJ2kFJ6NN5t7qIfy5Td4XjT+WOv0Q41KYn+DdPsBBEgznmPRutnkogZ11izlMaBwq+NdA+epS6mg9B3jTjG8gvSRDZtQITMkDQ+7gQLPeBZUXE1416vfot6S2BKEtDwluzkp0f9/RblR9euUDJNva/Txkx9DrD9tBU1cmF7pqyZsj6BnWMvswEpEXdWpTor6X/mgoA0gVnJRNFuuSp5ACkVm1uSHpT2zsM2rtZSrnMFTaJC3kcFbLNmYS+dXqI2tbqRpfm7a3OfRjUU0934OX+vA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JBSInbLC+/CFEDlnXKrQDdKXgJKtGul4Aph/Y5z/ZLE=;
 b=C4wNMMjdfszKjzvLePocbW7SEV0pKZ6SZoFK6Kw5BynfU/tPp2icX11xvSTyKIUatj0Ha6QLlnhMqukrFYKFE1nI4bix/PD7toBUDYiC9sG6C1Yr0VcZL9HBLYOhQhRbtcY4HNm8X201vlY7NU4W+xEu/gjEY3pANswn+xYg92w=
Received: from DM4PR12MB5165.namprd12.prod.outlook.com (2603:10b6:5:394::9) by
 SN7PR12MB6789.namprd12.prod.outlook.com (2603:10b6:806:26b::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.46; Mon, 1 Apr
 2024 01:58:13 +0000
Received: from DM4PR12MB5165.namprd12.prod.outlook.com
 ([fe80::b088:86ad:44e7:a075]) by DM4PR12MB5165.namprd12.prod.outlook.com
 ([fe80::b088:86ad:44e7:a075%7]) with mapi id 15.20.7409.042; Mon, 1 Apr 2024
 01:58:13 +0000
From: "Feng, Kenneth" <Kenneth.Feng@amd.com>
To: "Wang, Yang(Kevin)" <KevinYang.Wang@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
CC: "Lazar, Lijo" <Lijo.Lazar@amd.com>
Subject: RE: [PATCH] drm/amd/pm: centralize all pp_dpm_xxx attribute nodes
 update cb
Thread-Topic: [PATCH] drm/amd/pm: centralize all pp_dpm_xxx attribute nodes
 update cb
Thread-Index: AQHag80GTQcRGmEEH0mtPXAPZObBG7FSo0mQ
Date: Mon, 1 Apr 2024 01:58:13 +0000
Message-ID: <DM4PR12MB5165658A193482D60BB9F5418E3F2@DM4PR12MB5165.namprd12.prod.outlook.com>
References: <20240401003901.384897-1-kevinyang.wang@amd.com>
In-Reply-To: <20240401003901.384897-1-kevinyang.wang@amd.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=a51b5872-1d76-407a-b618-b39795361264;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=0;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2024-04-01T01:39:31Z;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM4PR12MB5165:EE_|SN7PR12MB6789:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 2laK3e1dVDiM1TmVfoIDWciO4n5FXw53mfOWufhmAgWK05c1COd7ez/p90RBfTfH3MDD3X21qZA/OW/terodCDRJn/McOPszqX9W39ukd2/A926K1RDiDiYmhGbZgE+bgDpe+1k0P68iHEXykjwX/EU7ZYqW+dZSZyn4BJxOFhICUNUu4SXEgK0qFy2qjdNvzNjNHsH49pIE2FiTZ8qoQG41kbuIQfM1N/gPE97XIGFHwA+C+De5PLyPc0nAR02/yoafkwtePgTTotRdbH1/quShVo5MDlryGm9FRaO/7aW03MzwuPIe/rFzTb3YjR3NIyC0q0VtIjlrZBhTxuHko4bq532+3C+x4NvCknHOo9y4aMO1Qdu++FDp9DOb0Vwqlr80ostwaGg/V/DctELACXF+WjbexSnxOerxVJlwvYI52wor3zo8wUF1nEw/nW9gMDEj7PxgTcwtaf8F8i0TVgRb/SgRR9xOSbREYJOTKl7ZHA63EJCUp+VCfq3o9AkdnJvQlihBvdJ7LKOEpxB/DUZtZJoww05G6js/rbEEplSOZ7X6VpaCEMVI+JVe2XJ7RhyQPj4iU+FPeD1vO9S3Zukgttkk3vFH6Cz9kAputtTc7GfntBQud46Ih1gFYpV6lE0SULD5fdY/5IrGsoZOlaiXd11/+v93fy9xsSkMu8Q=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB5165.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(366007)(376005)(1800799015); DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?iC43i0CcwAwcG0VEFVTwcSRPkqq8VYyTntbbYF+aTGy0AaNWv0teGCNshwJ8?=
 =?us-ascii?Q?ktQ9g75Jvn9GPawVu4weVNhuuXhTsvq4niwfv+8xLYSV6KOdX36WGbLAtjX4?=
 =?us-ascii?Q?kOO5VHP0wStgLhmU/QAAV6MWh2zUKXTmGdiZ3uMUCEzo9le/IUr/ZP92Cxjm?=
 =?us-ascii?Q?GmziCLAz5BFKaaIto6LLFpw3UQlQ23+LTwlZnCjIoZJK44XE4gGUrz0Hfcr5?=
 =?us-ascii?Q?hjrZc5TUpnan2AlTslg8LpyjfeYrLet6xpNVP33hm6RD9rvI9Uje9rj5FPV5?=
 =?us-ascii?Q?cAWLSWrDkoaQususBssQYz36/XDLSqByVW1R6/DlpT38/tEyptzKMwfO3I3u?=
 =?us-ascii?Q?E3h8lN2EtBdkCFKaq0YhOyinyJyzicOWBg5HdeOsXgpNrLvMXCx1MqhJR41h?=
 =?us-ascii?Q?fNpg6T7gHQEgoyDpB1vz2SdRqqV+8BqwGATwkuASGAT5PazDarTaYK37eI6i?=
 =?us-ascii?Q?0xAl6+7E4M2WfiMrb2WiXPAm7lKHAY6OFQsGUS186h3l8Z4rJkCH0QEDhmhh?=
 =?us-ascii?Q?hTN4rcmVseN1dOzZkgAE8WXZF7eiC57Y2Wyk/r/KvUFqtwpnisXWmVMvgroU?=
 =?us-ascii?Q?rt3+W+g4lo0J0w6tX3wgCGf0FlE9TnJUpg7tzFqkH4g9ADVp9/xBnK1jg7k2?=
 =?us-ascii?Q?rANmTpj8xaTqWS7bIO326Q8v/mZ1Z2XvfHvRQd8dSBuLvHIYtZBD9JtHKrvp?=
 =?us-ascii?Q?/qRk3HgM0zytPansSxcYzkzvARmdCZdTmfzfUq1GE2FIkSke32NoNdJJvMuN?=
 =?us-ascii?Q?wR5NFXj87/0+JcoFdQs5IRpkvVebCyfnOradKLxsehfpvqkuXcMFJ/2EcYZd?=
 =?us-ascii?Q?b6iaizcDFEfYMt6+E+6mYnIz5y/ynREAKzIy7mvF63N0smGN1wUUr13jjVUF?=
 =?us-ascii?Q?dkQrZSBwsD5BMU5wAT3461kQTQjS1pvFGdOo1Eno80mJTeIoYW9OLThl/pso?=
 =?us-ascii?Q?yiFeXK9us3z8ltzF7l0NaArj0/UyYozscX8jLmiCxKE77gtQV06tDV/40QE/?=
 =?us-ascii?Q?Gi0gKmmDhKQmP5N0Aa5cspGp6o4TjbRXKAqYwo+oW4USQ+vTyFsRAinjwFLu?=
 =?us-ascii?Q?OeQrIO//H2/Cjc8RNMdvJgGFSNBgB4b8GW05xqo8RCL4e54uHO8vy3wiawfS?=
 =?us-ascii?Q?+G/yxRzjqHEt+cJm+Be1xSbibLZ+bje9RyaZ1Q30FEDN6iOkL/2MYgHXtU7Q?=
 =?us-ascii?Q?caw06SdxdPTCAza4CNEOaPTSlqqQDICDgTrFChxVWITEF2PsMzxEbY4gxexb?=
 =?us-ascii?Q?v/3LmMMx/IWCJlYOI/foqO5xKmA8Z2DMWPzeqbjadUSfd+DMK6cRUE4t7y8H?=
 =?us-ascii?Q?8gZWsUpbLPbjOtcEuWzcuggZ1G2Rcrb3GviIMc1NIWkNU/HktvApZAMlNLyn?=
 =?us-ascii?Q?dbs8TM0dzOb/ELXJT/ueEZW4jSasqODy1gt/vAc0ollN5M402x6FTfaJ97s2?=
 =?us-ascii?Q?4+2jHSsZhb46uCjaE6SuGa+AOPGoWMpj8nHECUNm0V4TN57YJQwAHvCnwApz?=
 =?us-ascii?Q?NhfkxFkRLLOoY+F7GsRjQ4WMMt1pA3ncnOj/teKxYK9Yfe7rSTz5U+uf1U4l?=
 =?us-ascii?Q?942hBJyyP4Xog2bxL8I=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5165.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a0d0173b-c42a-4a8a-3e5b-08dc51ef30c5
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Apr 2024 01:58:13.6645 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: LV1NU6CyS3lmZdfrTCJ/yYzHneogpjbuKANrYh6i7B91x6jqYwcUauknKEoahRnI
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB6789
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

[AMD Official Use Only - General]

Reviewed-by: Kenneth Feng <kenneth.feng@amd.com>


-----Original Message-----
From: Wang, Yang(Kevin) <KevinYang.Wang@amd.com>
Sent: Monday, April 1, 2024 8:39 AM
To: amd-gfx@lists.freedesktop.org
Cc: Feng, Kenneth <Kenneth.Feng@amd.com>; Lazar, Lijo <Lijo.Lazar@amd.com>;=
 Wang, Yang(Kevin) <KevinYang.Wang@amd.com>
Subject: [PATCH] drm/amd/pm: centralize all pp_dpm_xxx attribute nodes upda=
te cb

centralize all pp_dpm_xxx attr nodes into
pp_dpm_clk_default_attr_update() function.

Signed-off-by: Yang Wang <kevinyang.wang@amd.com>
---
 drivers/gpu/drm/amd/pm/amdgpu_pm.c | 207 ++++++++++++++++-------------
 1 file changed, 115 insertions(+), 92 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/amdgpu_pm.c b/drivers/gpu/drm/amd/pm/am=
dgpu_pm.c
index b410df28ccb2..5bc1cd4993e8 100644
--- a/drivers/gpu/drm/amd/pm/amdgpu_pm.c
+++ b/drivers/gpu/drm/amd/pm/amdgpu_pm.c
@@ -38,6 +38,8 @@
 #define MAX_NUM_OF_FEATURES_PER_SUBSET         8
 #define MAX_NUM_OF_SUBSETS                     8

+#define DEVICE_ATTR_IS(_name)          (attr_id =3D=3D device_attr_id__##_=
name)
+
 struct od_attribute {
        struct kobj_attribute   attribute;
        struct list_head        entry;
@@ -2115,6 +2117,99 @@ static int pp_dpm_dcefclk_attr_update(struct amdgpu_=
device *adev, struct amdgpu_
        return 0;
 }

+static int pp_dpm_clk_default_attr_update(struct amdgpu_device *adev, stru=
ct amdgpu_device_attr *attr,
+                                         uint32_t mask, enum amdgpu_device=
_attr_states *states) {
+       struct device_attribute *dev_attr =3D &attr->dev_attr;
+       enum amdgpu_device_attr_id attr_id =3D attr->attr_id;
+       uint32_t mp1_ver =3D amdgpu_ip_version(adev, MP1_HWIP, 0);
+       uint32_t gc_ver =3D amdgpu_ip_version(adev, GC_HWIP, 0);
+
+       *states =3D ATTR_STATE_SUPPORTED;
+
+       if (!(attr->flags & mask)) {
+               *states =3D ATTR_STATE_UNSUPPORTED;
+               return 0;
+       }
+
+       if (DEVICE_ATTR_IS(pp_dpm_socclk)) {
+               if (gc_ver < IP_VERSION(9, 0, 0))
+                       *states =3D ATTR_STATE_UNSUPPORTED;
+       } else if (DEVICE_ATTR_IS(pp_dpm_fclk)) {
+               if (mp1_ver < IP_VERSION(10, 0, 0))
+                       *states =3D ATTR_STATE_UNSUPPORTED;
+       } else if (DEVICE_ATTR_IS(pp_dpm_vclk)) {
+               if (!(gc_ver =3D=3D IP_VERSION(10, 3, 1) ||
+                     gc_ver =3D=3D IP_VERSION(10, 3, 3) ||
+                     gc_ver =3D=3D IP_VERSION(10, 3, 6) ||
+                     gc_ver =3D=3D IP_VERSION(10, 3, 7) ||
+                     gc_ver =3D=3D IP_VERSION(10, 3, 0) ||
+                     gc_ver =3D=3D IP_VERSION(10, 1, 2) ||
+                     gc_ver =3D=3D IP_VERSION(11, 0, 0) ||
+                     gc_ver =3D=3D IP_VERSION(11, 0, 1) ||
+                     gc_ver =3D=3D IP_VERSION(11, 0, 4) ||
+                     gc_ver =3D=3D IP_VERSION(11, 5, 0) ||
+                     gc_ver =3D=3D IP_VERSION(11, 0, 2) ||
+                     gc_ver =3D=3D IP_VERSION(11, 0, 3) ||
+                     gc_ver =3D=3D IP_VERSION(9, 4, 3)))
+                       *states =3D ATTR_STATE_UNSUPPORTED;
+       } else if (DEVICE_ATTR_IS(pp_dpm_vclk1)) {
+               if (!((gc_ver =3D=3D IP_VERSION(10, 3, 1) ||
+                      gc_ver =3D=3D IP_VERSION(10, 3, 0) ||
+                      gc_ver =3D=3D IP_VERSION(11, 0, 2) ||
+                      gc_ver =3D=3D IP_VERSION(11, 0, 3)) && adev->vcn.num=
_vcn_inst >=3D 2))
+                       *states =3D ATTR_STATE_UNSUPPORTED;
+       } else if (DEVICE_ATTR_IS(pp_dpm_dclk)) {
+               if (!(gc_ver =3D=3D IP_VERSION(10, 3, 1) ||
+                     gc_ver =3D=3D IP_VERSION(10, 3, 3) ||
+                     gc_ver =3D=3D IP_VERSION(10, 3, 6) ||
+                     gc_ver =3D=3D IP_VERSION(10, 3, 7) ||
+                     gc_ver =3D=3D IP_VERSION(10, 3, 0) ||
+                     gc_ver =3D=3D IP_VERSION(10, 1, 2) ||
+                     gc_ver =3D=3D IP_VERSION(11, 0, 0) ||
+                     gc_ver =3D=3D IP_VERSION(11, 0, 1) ||
+                     gc_ver =3D=3D IP_VERSION(11, 0, 4) ||
+                     gc_ver =3D=3D IP_VERSION(11, 5, 0) ||
+                     gc_ver =3D=3D IP_VERSION(11, 0, 2) ||
+                     gc_ver =3D=3D IP_VERSION(11, 0, 3) ||
+                     gc_ver =3D=3D IP_VERSION(9, 4, 3)))
+                       *states =3D ATTR_STATE_UNSUPPORTED;
+       } else if (DEVICE_ATTR_IS(pp_dpm_dclk1)) {
+               if (!((gc_ver =3D=3D IP_VERSION(10, 3, 1) ||
+                      gc_ver =3D=3D IP_VERSION(10, 3, 0) ||
+                      gc_ver =3D=3D IP_VERSION(11, 0, 2) ||
+                      gc_ver =3D=3D IP_VERSION(11, 0, 3)) && adev->vcn.num=
_vcn_inst >=3D 2))
+                       *states =3D ATTR_STATE_UNSUPPORTED;
+       } else if (DEVICE_ATTR_IS(pp_dpm_pcie)) {
+               if (gc_ver =3D=3D IP_VERSION(9, 4, 2) ||
+                   gc_ver =3D=3D IP_VERSION(9, 4, 3))
+                       *states =3D ATTR_STATE_UNSUPPORTED;
+       }
+
+       switch (gc_ver) {
+       case IP_VERSION(9, 4, 1):
+       case IP_VERSION(9, 4, 2):
+               /* the Mi series card does not support standalone mclk/socc=
lk/fclk level setting */
+               if (DEVICE_ATTR_IS(pp_dpm_mclk) ||
+                   DEVICE_ATTR_IS(pp_dpm_socclk) ||
+                   DEVICE_ATTR_IS(pp_dpm_fclk)) {
+                       dev_attr->attr.mode &=3D ~S_IWUGO;
+                       dev_attr->store =3D NULL;
+               }
+               break;
+       default:
+               break;
+       }
+
+       /* setting should not be allowed from VF if not in one VF mode */
+       if (amdgpu_sriov_vf(adev) && amdgpu_sriov_is_pp_one_vf(adev)) {
+               dev_attr->attr.mode &=3D ~S_IWUGO;
+               dev_attr->store =3D NULL;
+       }
+
+       return 0;
+}
+
 /* Following items will be read out to indicate current plpd policy:
  *  - -1: none
  *  - 0: disallow
@@ -2186,17 +2281,26 @@ static struct amdgpu_device_attr amdgpu_device_attr=
s[] =3D {
        AMDGPU_DEVICE_ATTR_RO(pp_cur_state,                             ATT=
R_FLAG_BASIC|ATTR_FLAG_ONEVF),
        AMDGPU_DEVICE_ATTR_RW(pp_force_state,                           ATT=
R_FLAG_BASIC|ATTR_FLAG_ONEVF),
        AMDGPU_DEVICE_ATTR_RW(pp_table,                                 ATT=
R_FLAG_BASIC|ATTR_FLAG_ONEVF),
-       AMDGPU_DEVICE_ATTR_RW(pp_dpm_sclk,                              ATT=
R_FLAG_BASIC|ATTR_FLAG_ONEVF),
-       AMDGPU_DEVICE_ATTR_RW(pp_dpm_mclk,                              ATT=
R_FLAG_BASIC|ATTR_FLAG_ONEVF),
-       AMDGPU_DEVICE_ATTR_RW(pp_dpm_socclk,                            ATT=
R_FLAG_BASIC|ATTR_FLAG_ONEVF),
-       AMDGPU_DEVICE_ATTR_RW(pp_dpm_fclk,                              ATT=
R_FLAG_BASIC|ATTR_FLAG_ONEVF),
-       AMDGPU_DEVICE_ATTR_RW(pp_dpm_vclk,                              ATT=
R_FLAG_BASIC|ATTR_FLAG_ONEVF),
-       AMDGPU_DEVICE_ATTR_RW(pp_dpm_vclk1,                             ATT=
R_FLAG_BASIC|ATTR_FLAG_ONEVF),
-       AMDGPU_DEVICE_ATTR_RW(pp_dpm_dclk,                              ATT=
R_FLAG_BASIC|ATTR_FLAG_ONEVF),
-       AMDGPU_DEVICE_ATTR_RW(pp_dpm_dclk1,                             ATT=
R_FLAG_BASIC|ATTR_FLAG_ONEVF),
+       AMDGPU_DEVICE_ATTR_RW(pp_dpm_sclk,                              ATT=
R_FLAG_BASIC|ATTR_FLAG_ONEVF,
+                             .attr_update =3D pp_dpm_clk_default_attr_upda=
te),
+       AMDGPU_DEVICE_ATTR_RW(pp_dpm_mclk,                              ATT=
R_FLAG_BASIC|ATTR_FLAG_ONEVF,
+                             .attr_update =3D pp_dpm_clk_default_attr_upda=
te),
+       AMDGPU_DEVICE_ATTR_RW(pp_dpm_socclk,                            ATT=
R_FLAG_BASIC|ATTR_FLAG_ONEVF,
+                             .attr_update =3D pp_dpm_clk_default_attr_upda=
te),
+       AMDGPU_DEVICE_ATTR_RW(pp_dpm_fclk,                              ATT=
R_FLAG_BASIC|ATTR_FLAG_ONEVF,
+                             .attr_update =3D pp_dpm_clk_default_attr_upda=
te),
+       AMDGPU_DEVICE_ATTR_RW(pp_dpm_vclk,                              ATT=
R_FLAG_BASIC|ATTR_FLAG_ONEVF,
+                             .attr_update =3D pp_dpm_clk_default_attr_upda=
te),
+       AMDGPU_DEVICE_ATTR_RW(pp_dpm_vclk1,                             ATT=
R_FLAG_BASIC|ATTR_FLAG_ONEVF,
+                             .attr_update =3D pp_dpm_clk_default_attr_upda=
te),
+       AMDGPU_DEVICE_ATTR_RW(pp_dpm_dclk,                              ATT=
R_FLAG_BASIC|ATTR_FLAG_ONEVF,
+                             .attr_update =3D pp_dpm_clk_default_attr_upda=
te),
+       AMDGPU_DEVICE_ATTR_RW(pp_dpm_dclk1,                             ATT=
R_FLAG_BASIC|ATTR_FLAG_ONEVF,
+                             .attr_update =3D pp_dpm_clk_default_attr_upda=
te),
        AMDGPU_DEVICE_ATTR_RW(pp_dpm_dcefclk,                           ATT=
R_FLAG_BASIC|ATTR_FLAG_ONEVF,
                              .attr_update =3D pp_dpm_dcefclk_attr_update),
-       AMDGPU_DEVICE_ATTR_RW(pp_dpm_pcie,                              ATT=
R_FLAG_BASIC|ATTR_FLAG_ONEVF),
+       AMDGPU_DEVICE_ATTR_RW(pp_dpm_pcie,                              ATT=
R_FLAG_BASIC|ATTR_FLAG_ONEVF,
+                             .attr_update =3D pp_dpm_clk_default_attr_upda=
te),
        AMDGPU_DEVICE_ATTR_RW(pp_sclk_od,                               ATT=
R_FLAG_BASIC),
        AMDGPU_DEVICE_ATTR_RW(pp_mclk_od,                               ATT=
R_FLAG_BASIC),
        AMDGPU_DEVICE_ATTR_RW(pp_power_profile_mode,                    ATT=
R_FLAG_BASIC|ATTR_FLAG_ONEVF),
@@ -2204,7 +2308,7 @@ static struct amdgpu_device_attr amdgpu_device_attrs[=
] =3D {
                              .attr_update =3D pp_od_clk_voltage_attr_updat=
e),
        AMDGPU_DEVICE_ATTR_RO(gpu_busy_percent,                         ATT=
R_FLAG_BASIC|ATTR_FLAG_ONEVF),
        AMDGPU_DEVICE_ATTR_RO(mem_busy_percent,                         ATT=
R_FLAG_BASIC|ATTR_FLAG_ONEVF),
-       AMDGPU_DEVICE_ATTR_RO(vcn_busy_percent,         ATTR_FLAG_BASIC|ATT=
R_FLAG_ONEVF),
+       AMDGPU_DEVICE_ATTR_RO(vcn_busy_percent,                         ATT=
R_FLAG_BASIC|ATTR_FLAG_ONEVF),
        AMDGPU_DEVICE_ATTR_RO(pcie_bw,                                  ATT=
R_FLAG_BASIC),
        AMDGPU_DEVICE_ATTR_RW(pp_features,                              ATT=
R_FLAG_BASIC|ATTR_FLAG_ONEVF),
        AMDGPU_DEVICE_ATTR_RO(unique_id,                                ATT=
R_FLAG_BASIC|ATTR_FLAG_ONEVF),
@@ -2227,7 +2331,6 @@ static int default_attr_update(struct amdgpu_device *=
adev, struct amdgpu_device_  {
        struct device_attribute *dev_attr =3D &attr->dev_attr;
        enum amdgpu_device_attr_id attr_id =3D attr->attr_id;
-       uint32_t mp1_ver =3D amdgpu_ip_version(adev, MP1_HWIP, 0);
        uint32_t gc_ver =3D amdgpu_ip_version(adev, GC_HWIP, 0);

        if (!(attr->flags & mask)) {
@@ -2235,15 +2338,7 @@ static int default_attr_update(struct amdgpu_device =
*adev, struct amdgpu_device_
                return 0;
        }

-#define DEVICE_ATTR_IS(_name)          (attr_id =3D=3D device_attr_id__##_=
name)
-
-       if (DEVICE_ATTR_IS(pp_dpm_socclk)) {
-               if (gc_ver < IP_VERSION(9, 0, 0))
-                       *states =3D ATTR_STATE_UNSUPPORTED;
-       } else if (DEVICE_ATTR_IS(pp_dpm_fclk)) {
-               if (mp1_ver < IP_VERSION(10, 0, 0))
-                       *states =3D ATTR_STATE_UNSUPPORTED;
-       } else if (DEVICE_ATTR_IS(mem_busy_percent)) {
+       if (DEVICE_ATTR_IS(mem_busy_percent)) {
                if ((adev->flags & AMD_IS_APU &&
                     gc_ver !=3D IP_VERSION(9, 4, 3)) ||
                    gc_ver =3D=3D IP_VERSION(9, 0, 1))
@@ -2287,48 +2382,6 @@ static int default_attr_update(struct amdgpu_device =
*adev, struct amdgpu_device_
        } else if (DEVICE_ATTR_IS(gpu_metrics)) {
                if (gc_ver < IP_VERSION(9, 1, 0))
                        *states =3D ATTR_STATE_UNSUPPORTED;
-       } else if (DEVICE_ATTR_IS(pp_dpm_vclk)) {
-               if (!(gc_ver =3D=3D IP_VERSION(10, 3, 1) ||
-                         gc_ver =3D=3D IP_VERSION(10, 3, 3) ||
-                         gc_ver =3D=3D IP_VERSION(10, 3, 6) ||
-                         gc_ver =3D=3D IP_VERSION(10, 3, 7) ||
-                     gc_ver =3D=3D IP_VERSION(10, 3, 0) ||
-                     gc_ver =3D=3D IP_VERSION(10, 1, 2) ||
-                     gc_ver =3D=3D IP_VERSION(11, 0, 0) ||
-                         gc_ver =3D=3D IP_VERSION(11, 0, 1) ||
-                         gc_ver =3D=3D IP_VERSION(11, 0, 4) ||
-                         gc_ver =3D=3D IP_VERSION(11, 5, 0) ||
-                     gc_ver =3D=3D IP_VERSION(11, 0, 2) ||
-                     gc_ver =3D=3D IP_VERSION(11, 0, 3) ||
-                     gc_ver =3D=3D IP_VERSION(9, 4, 3)))
-                       *states =3D ATTR_STATE_UNSUPPORTED;
-       } else if (DEVICE_ATTR_IS(pp_dpm_vclk1)) {
-               if (!((gc_ver =3D=3D IP_VERSION(10, 3, 1) ||
-                          gc_ver =3D=3D IP_VERSION(10, 3, 0) ||
-                          gc_ver =3D=3D IP_VERSION(11, 0, 2) ||
-                          gc_ver =3D=3D IP_VERSION(11, 0, 3)) && adev->vcn=
.num_vcn_inst >=3D 2))
-                       *states =3D ATTR_STATE_UNSUPPORTED;
-       } else if (DEVICE_ATTR_IS(pp_dpm_dclk)) {
-               if (!(gc_ver =3D=3D IP_VERSION(10, 3, 1) ||
-                         gc_ver =3D=3D IP_VERSION(10, 3, 3) ||
-                         gc_ver =3D=3D IP_VERSION(10, 3, 6) ||
-                         gc_ver =3D=3D IP_VERSION(10, 3, 7) ||
-                     gc_ver =3D=3D IP_VERSION(10, 3, 0) ||
-                     gc_ver =3D=3D IP_VERSION(10, 1, 2) ||
-                     gc_ver =3D=3D IP_VERSION(11, 0, 0) ||
-                         gc_ver =3D=3D IP_VERSION(11, 0, 1) ||
-                         gc_ver =3D=3D IP_VERSION(11, 0, 4) ||
-                         gc_ver =3D=3D IP_VERSION(11, 5, 0) ||
-                     gc_ver =3D=3D IP_VERSION(11, 0, 2) ||
-                     gc_ver =3D=3D IP_VERSION(11, 0, 3) ||
-                     gc_ver =3D=3D IP_VERSION(9, 4, 3)))
-                       *states =3D ATTR_STATE_UNSUPPORTED;
-       } else if (DEVICE_ATTR_IS(pp_dpm_dclk1)) {
-               if (!((gc_ver =3D=3D IP_VERSION(10, 3, 1) ||
-                          gc_ver =3D=3D IP_VERSION(10, 3, 0) ||
-                          gc_ver =3D=3D IP_VERSION(11, 0, 2) ||
-                          gc_ver =3D=3D IP_VERSION(11, 0, 3)) && adev->vcn=
.num_vcn_inst >=3D 2))
-                       *states =3D ATTR_STATE_UNSUPPORTED;
        } else if (DEVICE_ATTR_IS(pp_power_profile_mode)) {
                if (amdgpu_dpm_get_power_profile_mode(adev, NULL) =3D=3D -E=
OPNOTSUPP)
                        *states =3D ATTR_STATE_UNSUPPORTED;
@@ -2350,23 +2403,9 @@ static int default_attr_update(struct amdgpu_device =
*adev, struct amdgpu_device_
                if (amdgpu_dpm_get_apu_thermal_limit(adev, &limit) =3D=3D
                    -EOPNOTSUPP)
                        *states =3D ATTR_STATE_UNSUPPORTED;
-       } else if (DEVICE_ATTR_IS(pp_dpm_pcie)) {
-               if (gc_ver =3D=3D IP_VERSION(9, 4, 2) ||
-                   gc_ver =3D=3D IP_VERSION(9, 4, 3))
-                       *states =3D ATTR_STATE_UNSUPPORTED;
        }

        switch (gc_ver) {
-       case IP_VERSION(9, 4, 1):
-       case IP_VERSION(9, 4, 2):
-               /* the Mi series card does not support standalone mclk/socc=
lk/fclk level setting */
-               if (DEVICE_ATTR_IS(pp_dpm_mclk) ||
-                   DEVICE_ATTR_IS(pp_dpm_socclk) ||
-                   DEVICE_ATTR_IS(pp_dpm_fclk)) {
-                       dev_attr->attr.mode &=3D ~S_IWUGO;
-                       dev_attr->store =3D NULL;
-               }
-               break;
        case IP_VERSION(10, 3, 0):
                if (DEVICE_ATTR_IS(power_dpm_force_performance_level) &&
                    amdgpu_sriov_vf(adev)) {
@@ -2378,22 +2417,6 @@ static int default_attr_update(struct amdgpu_device =
*adev, struct amdgpu_device_
                break;
        }

-       /* setting should not be allowed from VF if not in one VF mode */
-       if (amdgpu_sriov_vf(adev) && (!amdgpu_sriov_is_pp_one_vf(adev) ||
-               DEVICE_ATTR_IS(pp_dpm_sclk) ||
-               DEVICE_ATTR_IS(pp_dpm_mclk) ||
-               DEVICE_ATTR_IS(pp_dpm_socclk) ||
-               DEVICE_ATTR_IS(pp_dpm_fclk) ||
-               DEVICE_ATTR_IS(pp_dpm_vclk) ||
-               DEVICE_ATTR_IS(pp_dpm_vclk1) ||
-               DEVICE_ATTR_IS(pp_dpm_dclk) ||
-               DEVICE_ATTR_IS(pp_dpm_dclk1))) {
-               dev_attr->attr.mode &=3D ~S_IWUGO;
-               dev_attr->store =3D NULL;
-       }
-
-#undef DEVICE_ATTR_IS
-
        return 0;
 }

--
2.34.1

