Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2A36BC561E6
	for <amd-gfx@archiver.kernel.org>; Thu,  6 Aug 2026 08:43:09 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9264C10F13F;
	Thu,  6 Aug 2026 08:43:08 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="R1xx0Via";
	dkim-atps=neutral
Received: from DM5PR21CU001.outbound.protection.outlook.com
 (mail-centralusazon11011030.outbound.protection.outlook.com [52.101.62.30])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2CE7B10F13F
 for <amd-gfx@lists.freedesktop.org>; Thu,  6 Aug 2026 08:43:07 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rn109WxqfcLlrhhDSwwiWIijEJtGTwib1c/rESTSANUOSK6p+gIUIwWvsKAZYs/RSo44+TCDgBJcV8DFZ7rZUGFAjDKk3C6p5mc+vjQ/tjaKOVr/ZdWdrRFG3qohTGpludbomX6aXEw8G0qUJvlUZk+y9Smo0aLpOA8ITetxu1J7RwulqnhazEUstB/1iFxNlDzFLVchIvcfL/cfurQoLSHvTCAJvAUmU1H04jok5CVRC0xu5lJIFd9ADqQpPyjGueI91S5yPIlo8JfQygpxBaFyex3//S0a1jjUrqBtAfDXgQnx8v7XTKLtddfdUbxqUJIGKjWLypZTdb2DCZ3YXg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hbJP0VnHnRwCjMuq9V1qHhk53c5fDl6V8PEMlY1mDao=;
 b=Td1tbDMKm6Cz2vlypl0jr1EsaoHM+jvI1IMikJI0fbPwZaCMktvK71oZDIfTcQe2X4CFV8Q1JhggDMoV7moaWpLz4wzxjHKwby0woCFN2t+wWevzYNy7RNRhZwwRazgV6nzNHp1oas8n1W/0xNEm+ykynI3qsWxMpMvoJ03dFaRRcaWKw7A/j9bkkmDiMdOPQw44+SbxAkfljs0a7Ov2aqMYU7JFlz1a7kv7R8ujYU+Qxvj1DSPCMy4XvJ4l49JJmbpTaxGFm5Bp0tqIbSdf0PugL78HCQm71218onz8MAjuOyoffPKdGPxjWEVGOBacZ4ri2gBHFcw23UMo80GigA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hbJP0VnHnRwCjMuq9V1qHhk53c5fDl6V8PEMlY1mDao=;
 b=R1xx0Via/oyH34cmmbVwwQgyJLvtslSO6XG1PHslHJ8sGJDHlYE55Ly6pFwYlLTnK7sGvDhfn4+OmIfMCMmy31ZWl8uiTH6+oi+/C/YF/kBpBVFTf1u4Va+H7PnPQfbJJ+7iQNm5pHZ+RQpXhuMUfH9jZmatdEI2ezKpEuri1Os=
Received: from EAYPR12MB999158.namprd12.prod.outlook.com
 (2603:10b6:303:2c1::15) by SA0PR12MB4462.namprd12.prod.outlook.com
 (2603:10b6:806:95::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.270.18; Thu, 6 Aug
 2026 08:43:03 +0000
Received: from EAYPR12MB999158.namprd12.prod.outlook.com
 ([fe80::c52f:2856:964e:a4b2]) by EAYPR12MB999158.namprd12.prod.outlook.com
 ([fe80::c52f:2856:964e:a4b2%4]) with mapi id 15.21.0292.018; Thu, 6 Aug 2026
 08:43:03 +0000
From: "Zhang, Hawking" <Hawking.Zhang@amd.com>
To: "Wang, Yang(Kevin)" <KevinYang.Wang@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
CC: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Feng, Kenneth"
 <Kenneth.Feng@amd.com>
Subject: RE: [PATCH] drm/amdgpu: check ASPM on the dGPU host link
Thread-Topic: [PATCH] drm/amdgpu: check ASPM on the dGPU host link
Thread-Index: AQHdJWcPD6U7ckVmLUWMZQmiGuXftLaQtCEg
Date: Thu, 6 Aug 2026 08:43:02 +0000
Message-ID: <EAYPR12MB99915883459EB371FDD88D5D50FCD22@EAYPR12MB999158.namprd12.prod.outlook.com>
References: <20260806054705.1580442-1-kevinyang.wang@amd.com>
In-Reply-To: <20260806054705.1580442-1-kevinyang.wang@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Enabled=True;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SetDate=2026-08-06T08:42:09.0000000Z;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Name=AMD General
 v26; MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_ContentBits=3;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Method=Standard
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: EAYPR12MB999158:EE_|SA0PR12MB4462:EE_
x-ms-office365-filtering-correlation-id: 7e4fcda9-64df-42ff-13c1-08def396ba4a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|366016|23010399003|1800799024|11063799006|10067099003|6133799003|56012099006|22082099003|18002099003|38070700021;
x-microsoft-antispam-message-info: 6kLmrtqVwc+ybYk4+KJuYi0qZubSrPoErFhzNUq8mVT2rdar7uqhX/3yc5oByfCKNOJMJMMQuE53011e5uCbtiVv6jeY7J1QCYxu4UjnSF3GFViwgfi9TqpQWCydEL5ATm5JJ2FuOhanHZokeBg3zxVkpgDBzfkVxfArEnOjfy+vLCEE7BzV79HqG9jDKmXsuzEaGs7oQu1VMRT9uvwWJD7CYmiONjkBny37eMK/aJpG/8hl7MnGniBA6wKG9aGLMhH5c26UBS6wXyv5soxFu8aygqRJVcoKBgmpvcFOYAuMsmOPWnzqj0A5koDbBCPaLvt67qb0VPL7EgQgtC6j9IiO7yalVUU/Pubb8an8c7C4NNvJj+rtOxEa/9x73cVXlpvl8XJRl65yNW4F9T/8maXU1AkU2bhJYiIotlGtbqJZ2bxr71d5B8jtEpZ1GTggHFkmFnxNlfYBXy7MtCtpJGVSG7pSu7VgtxzaWUwsQtyHhzrfyEC9UtRg69ebOpUr2VV6+SfP++IYSkQJwuSYLLh+zBGVgP1omJ2n7mdJo9dUnrallSpCeTe9dIx3ZpFQB/Hgp/P7qAGFHmc8sZNggzlHae8v9OJ6HheXLlQe4NxZd9St38SXTurHBtpURzvtcd9DfYPfnTjI3TnEKKMg35kgSpar4fQbA4oqSZo4k1vIqm6HxzJMEz+XQkfTIvaF1GyXUFqlpP+9OomNIgXlYis+JWcYP/xwrY1wthOZGcA=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:EAYPR12MB999158.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(23010399003)(1800799024)(11063799006)(10067099003)(6133799003)(56012099006)(22082099003)(18002099003)(38070700021);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?lKBDxG3Ou0JN1gYSkwoJ2hgrPL2v3pE9jnanlhA1397mF42KvDguhu5MQaM8?=
 =?us-ascii?Q?65Jlq+xjxuC/ofYDJ50Hvl5N9a2xlwh+QJmoGH5eFUAK1IM92emkJd0RDWMS?=
 =?us-ascii?Q?SksuXB0CuWejNV2NeTbznkSw3kRYhM6ESQ83D0MhyfJRV27/HoXBxr1sJH2n?=
 =?us-ascii?Q?esc7vWZjY14zPRdx+AyLo/kpP4//XOqYZdeZiKRPFOoYlF53lmfqtLo2CwVx?=
 =?us-ascii?Q?BHoEc5trk3MTgbGbR/zo6kb3WLTzlXnPgpHcSexVLhyNVF36Ym9l/LLMatyh?=
 =?us-ascii?Q?Nrdgp04nZIBeHUrRu0ZEq5EMpqkF9DALK/BYv9tQ6ewXs1j88gyc0Ti+BG1p?=
 =?us-ascii?Q?z2SSBfYTyfbfjhUDjLnOFvjgnK6eeK/b2S0UPMsbOEGSUqOCFrH4jxlQZjy+?=
 =?us-ascii?Q?cIvMjeIcR9yZe+zuMyryvtAqE9FLf7dI0B37s1iaBz3FfECoTzHbOyXM1SKb?=
 =?us-ascii?Q?psPf5cUNiO6papOhTSUXIIMV4b+dyUJqDCg3vkINSApQCmnSzZUX7wehjS5d?=
 =?us-ascii?Q?dmDkHXP2QrcvFDcyGZ8UURvUuGKMgE2KpteMzemo5fLpwVNp9ei1kVl4w9Xm?=
 =?us-ascii?Q?QreWrpNNg0J7QJ1Ba8XgFR6u2VCIZ7O5L6IGtMPZNkt2OJQ5vQySe7aW28ow?=
 =?us-ascii?Q?tG9BEBiRZg7npIrd+5GZ8k0h07taNQVlGGlb0fC5MvhebJOL//QYPw5OkPuW?=
 =?us-ascii?Q?DTmLfVW8Jn1BamPG8MTDlqw5CmlUlNNUFQYiANI1mjwFQJqxfIIDFDl60L4m?=
 =?us-ascii?Q?c3rVw3/wh6vebJhJprLielPP0tC4zfUbjmUUlkfVws58iW3wMl01nX+c/1yS?=
 =?us-ascii?Q?B8foUzLuEYYdx0qSRVsmUY9LDTCqczMHOHFcf9ey6W5pMUE/fk3Dim30hhdG?=
 =?us-ascii?Q?iYVXw4Kqhb5DWPGkTGxvsT+9OaLw9gMAWdRE4ID3wdnvy8SLDerhFaOQUj89?=
 =?us-ascii?Q?tugp7qu8soPtmAhL3yySKZdgyNkyvk9EGPwoN7UC9gaijIoIzsjQtx9vxunl?=
 =?us-ascii?Q?EanyJwctZNGeiH18nYpbFfTfSRn+OkGQxloL9FlttJccSVO8Y5QYVfNDEsbC?=
 =?us-ascii?Q?+g/ZcXDkJwX3S4PP1xHqvZKyYBm/J99vJDB/hkiSqNSAEaP/0Zcu5YxeFrwg?=
 =?us-ascii?Q?8X+i6O6hJ+yhGNYI4KPj3OCij1cJ5nGggQlthDO7bHc8OsGUL6AiJrhD4JhZ?=
 =?us-ascii?Q?Gr49owZG0YwsEZoxx8tj9BJTl4Gn6ig4IMUOsn4LtYvxuZYw7qMT4MpZxNKo?=
 =?us-ascii?Q?XE+wBt/OLRR0Bp74AGbaiTdSoWKuD1CIeDG49sQA/QYsxzy9OpXBKaSHyCcr?=
 =?us-ascii?Q?gWctlw6QkSsUDXDfDRpNplFScZTb7hdfOb3STxr+24dqrwk/GbmtzAnX3Yh0?=
 =?us-ascii?Q?Q0u15e34xLqFftfOgYyn5JNQLD+5mztCVywTKgF1zam+AzUnQbrIAoSQ5WJN?=
 =?us-ascii?Q?EuVicXIyQm186D9EHNvLuu7GM/F/PGBNvGDGFMV7xNHJQrEay3JJ4RDjYLnG?=
 =?us-ascii?Q?hclwf8/59i2akdDx+9s5kCHSWCf8Z4PvgQiL0yin1SKwlZeYorb/4N+a98Yr?=
 =?us-ascii?Q?3+MN7KG3XV1Ipdh+H0N6vIZJGUjexUQU95PoMNA/O8P7qCpYL8TZxWkW7eck?=
 =?us-ascii?Q?G/q2jVljf5G1RtkRBB15FM5t5HeTe80suwuw4043IQoAWFH9YOAY7y69mrHz?=
 =?us-ascii?Q?j+3+tgCTSNHskweA5fZCFffb94ogUh6dSyW7DCE+FmvlcOo4?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: EAYPR12MB999158.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7e4fcda9-64df-42ff-13c1-08def396ba4a
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Aug 2026 08:43:02.8838 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: NMrySH8U4djtY3qzuFO52nhsc+BpwgnMUSDOMKcY7WeywYFOH/JG8qhgHy3eSJAn8frmMy5NbAoYvp/9YyimhQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4462
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

Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>

Regards,
Hawking
-----Original Message-----
From: Wang, Yang(Kevin) <KevinYang.Wang@amd.com>
Sent: Thursday, August 6, 2026 1:47 PM
To: amd-gfx@lists.freedesktop.org
Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Zhang, Hawking <Hawking=
.Zhang@amd.com>; Feng, Kenneth <Kenneth.Feng@amd.com>
Subject: [PATCH] drm/amdgpu: check ASPM on the dGPU host link

dGPUs with an internal PCIe switch expose graphics functions below the swit=
ch downstream port. The automatic ASPM check uses the display endpoint and =
evaluates the internal link instead of the host link.

Use the switch upstream port for the check and report the selected link.

Fixes: 0ab5d711ec74 ("drm/amd: Refactor `amdgpu_aspm` to be evaluated per d=
evice")
Signed-off-by: Yang Wang <kevinyang.wang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 50 +++++++++++++++++++++-
 1 file changed, 49 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/a=
md/amdgpu/amdgpu_device.c
index 2b9799033174..e68a5ddcae69 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -1344,6 +1344,31 @@ static bool amdgpu_device_aspm_support_quirk(struct =
amdgpu_device *adev)  #endif  }

+/*
+ * Some dGPUs expose their display endpoint below an internal PCIe switch.
+ * Use the switch upstream port to query the host-facing link.
+ */
+static struct pci_dev *amdgpu_device_get_aspm_pdev(struct amdgpu_device
+*adev) {
+       struct pci_dev *swds, *swus;
+
+       swds =3D pci_upstream_bridge(adev->pdev);
+       if (!swds ||
+           (swds->vendor !=3D PCI_VENDOR_ID_ATI &&
+            swds->vendor !=3D PCI_VENDOR_ID_AMD) ||
+           pci_pcie_type(swds) !=3D PCI_EXP_TYPE_DOWNSTREAM)
+               return adev->pdev;
+
+       swus =3D pci_upstream_bridge(swds);
+       if (!swus ||
+           (swus->vendor !=3D PCI_VENDOR_ID_ATI &&
+            swus->vendor !=3D PCI_VENDOR_ID_AMD) ||
+           pci_pcie_type(swus) !=3D PCI_EXP_TYPE_UPSTREAM)
+               return adev->pdev;
+
+       return swus;
+}
+
 /**
  * amdgpu_device_should_use_aspm - check if the device should program ASPM
  *
@@ -1356,6 +1381,9 @@ static bool amdgpu_device_aspm_support_quirk(struct a=
mdgpu_device *adev)
  */
 bool amdgpu_device_should_use_aspm(struct amdgpu_device *adev)  {
+       struct pci_dev *aspm_pdev, *parent;
+       bool enabled;
+
        switch (amdgpu_aspm) {
        case -1:
                break;
@@ -1370,7 +1398,27 @@ bool amdgpu_device_should_use_aspm(struct amdgpu_dev=
ice *adev)
                return false;
        if (amdgpu_device_aspm_support_quirk(adev))
                return false;
-       return pcie_aspm_enabled(adev->pdev);
+
+       /*
+        * pcie_aspm_enabled() checks the link between its argument and
+        * the immediate upstream bridge. Use SWUS for dGPUs with an
+        * internal switch so that this is the host-facing link.
+        */
+       aspm_pdev =3D amdgpu_device_get_aspm_pdev(adev);
+       parent =3D pci_upstream_bridge(aspm_pdev);
+       if (!parent) {
+               dev_info(adev->dev, "ASPM: no upstream PCIe link for %s\n",
+                        pci_name(aspm_pdev));
+               return false;
+       }
+
+       enabled =3D pcie_aspm_enabled(aspm_pdev);
+       /* Report the exact link used for the automatic ASPM decision. */
+       dev_info(adev->dev, "ASPM: link %s <-> %s is %s\n",
+                pci_name(parent), pci_name(aspm_pdev),
+                enabled ? "enabled" : "disabled");
+
+       return enabled;
 }

 /* if we get transitioned to only one device, take VGA back */
--
2.54.0

