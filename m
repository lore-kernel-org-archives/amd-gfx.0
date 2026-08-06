Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 26C0AC55ABF
	for <amd-gfx@archiver.kernel.org>; Thu,  6 Aug 2026 11:16:48 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9990810E304;
	Thu,  6 Aug 2026 11:16:47 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="BRlYD4mG";
	dkim-atps=neutral
Received: from CY3PR05CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11013011.outbound.protection.outlook.com
 [40.93.201.11])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D82BF10E304
 for <amd-gfx@lists.freedesktop.org>; Thu,  6 Aug 2026 11:16:46 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nYjXeRLXH2gaMajyvMQUElhNPiV6+pLj8uHMh+fTagDXWGRWkwNezNhyRxAHgoxEi71C3DNrkb9UVh2TbU9xUyYavIivyD7FBvc/dcxDB0lWeDsz0MVEbtgwsLr04WQW2z9EO8LZAvECfFyz2NHxzR451llE71dPkyXoZbGJe62zI8Q4RFSFulTmfA0c3VzaUTP1neFwUeTORWqA/9XTGBIUb8IBO6jkdd1ZNRAigiAl/eK5IpcwmKeMv4hz1RKCSYInivCx+FMg+mgoDTDGvxi4YygLpbeSLbtZfkqkW+xPt3c4FvRpjPTmDX3x08QiB1kQXE0TaebBlaWDnTy+3g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KxyOcXVuXfHdXTgdpj0nvNDkC4iC925xdQ+Djz1OwcM=;
 b=wgRKQLHqhKXVdhVVktpnXN+xlG+pcPoHVzJ2j/HncmnOMzAAslDL4Yie2x/7knzznzYkxQcqHvFt6hrl3tcAOlnbQ6lDLLJ4wCi3hc2ADaxNsVopcFljR1F0wjwg1ZGaS8w1471HyMVeTjzzHSUGj8uo2T+Kt6Pd3tOYfn2rJcNMy46QyCkxpNR0oHzOjlvvz/Y8NAUzRlpoHTPqhNFuiSEpOS9l8S0pW+moPFxRbvkPtYe4/hltflM/FlgEgi2BUs50iHjGqEuG90J/ibrHs7mG5e1LLgS5SFiuL+7D+OSgsJqRo/EPZnqUav4rdekAEESDahCG6EABcoltzow5pQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KxyOcXVuXfHdXTgdpj0nvNDkC4iC925xdQ+Djz1OwcM=;
 b=BRlYD4mGVT6XKvdZqJId0eV+xaGFR27prjF7O9Hubg4FyrzKlEdzZr2oAJYKr5+h68GnfHczxR1l6quNpc90BOdA6ZcVLZHYeNboQM/Z4/Lo9odc158L+hW30FxZZGjPN8nW8Ty9ZAjrQo4TJmUHXK0YtTTBeuR1o57TnUXQt20=
Received: from MW4PR12MB6803.namprd12.prod.outlook.com (2603:10b6:303:20e::10)
 by CY5PR12MB9055.namprd12.prod.outlook.com (2603:10b6:930:35::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.292.15; Thu, 6 Aug
 2026 11:16:40 +0000
Received: from MW4PR12MB6803.namprd12.prod.outlook.com
 ([fe80::c193:ef2e:260f:dcfd]) by MW4PR12MB6803.namprd12.prod.outlook.com
 ([fe80::c193:ef2e:260f:dcfd%6]) with mapi id 15.21.0292.015; Thu, 6 Aug 2026
 11:16:40 +0000
From: "Feng, Kenneth" <Kenneth.Feng@amd.com>
To: "Wang, Yang(Kevin)" <KevinYang.Wang@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
CC: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Zhang, Hawking"
 <Hawking.Zhang@amd.com>
Subject: RE: [PATCH] drm/amdgpu: check ASPM on the dGPU host link
Thread-Topic: [PATCH] drm/amdgpu: check ASPM on the dGPU host link
Thread-Index: AQHdJWcQ8lslOQ07+Ee525mEwB7trLaQ3sJw
Date: Thu, 6 Aug 2026 11:16:40 +0000
Message-ID: <MW4PR12MB68034831F1DE57DB42EAD0C98ED22@MW4PR12MB6803.namprd12.prod.outlook.com>
References: <20260806054705.1580442-1-kevinyang.wang@amd.com>
In-Reply-To: <20260806054705.1580442-1-kevinyang.wang@amd.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Enabled=True;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SetDate=2026-08-06T11:14:43.0000000Z;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Name=AMD General
 v26; MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_ContentBits=3;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Method=Standard
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MW4PR12MB6803:EE_|CY5PR12MB9055:EE_
x-ms-office365-filtering-correlation-id: 1caf74d9-dead-4749-0d0f-08def3ac303f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|23010399003|1800799024|376014|11063799006|56012099006|10067099003|6133799003|18002099003|22082099003|38070700021;
x-microsoft-antispam-message-info: YXxRdxbb2C539M14ibrVEr2gSkRMfKMKTKZHzR4vGGdC8GXZz1CTTa3zv3LHbXUeXYczpHmwVXuvzK3mvBz3ADnNqz48G1IrUPD4f44Uymq3rgI68DJFLczO772Jplztb74FUH4MQE4RQ8G6LoYu6FUY6CLabBUXufoHAa9yeZTwyvHEaH0+lkVjNjLP1yrYLsnoaWTraXjHYQfYhpKPtD8cIi9yZP2cfrNzdMPAtZTq/DLSiL/zK9qwdRgh2w7ZalZ9Ns76FlUNnrPZU35rw1KI8FMJCF5u22DlXv0+72V0m+UYxkk2M2bUbP1FuyxoN7/NarocyqJmcSPUrYcVhWp+l7SpO4Cy8vVQHIO7C3x6TvRPxGquPWz3ya+n/AZAlCPQ0Lm72L0do0ChiFolGOtMBdDUlSUrZMofpNi8AUMp9r059bnU8EHGe+dQh+D+LQEggr9YJKdkEytTN55zBJDiZjoU2AI1t6MrkBMOj/kU2Psls3mAiaeCwMD+TFyE0ZYP94KE2dRkq2//cwG8o4aIJ4D/uX/VL3QAbnkeBlfARSZeJSzXmNs0N88embquR7k1Ia+1ToSlSmG96DI2QubmK3y62zkBzuSCnBMoTfnGwId0biGIJFgLzCUC3wMMmyJgXkG6eGqdh5PzWxpoOHVKcmPMV4MgyI4NOxYt8J/SOJCnp2P1idaDgBwwogAXydPdorhTUN5Cy1ISjW77cuD3dE/BOV0BMj+R+tYEg2c=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MW4PR12MB6803.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(23010399003)(1800799024)(376014)(11063799006)(56012099006)(10067099003)(6133799003)(18002099003)(22082099003)(38070700021);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?M5wmrAX/JzYBJyp3lYeY+kigxKT5EyXQiysIrcV+V+yFYnzh8W41lS7/lDgu?=
 =?us-ascii?Q?UZu+VK5lm9yrQBERrSnLY42Wcqhz7gJY9+cd3gi67sQVnjBxkyUdIiq4qtmH?=
 =?us-ascii?Q?heZ9MznL1fjJneQT16QkBUsVqP0Nh2C+8AAE1iKqYE6kL7U++PJpip89+4WN?=
 =?us-ascii?Q?BtArHiVHlbVj3ROKWJG7hO6Fv+mrXd/MVcvgJ856ao5oiPbWpDubxpPySlEI?=
 =?us-ascii?Q?gR/i6ovUKb8keLDvu5NjzEBwwtrgv4gP6HLZ+cAIXFauvpctEVACSXFcS271?=
 =?us-ascii?Q?x7seJruZwY3FmDMRAPquFwjb9FuYzZBbhTg/YeQB9tmGDLSRztB5h+WBM36g?=
 =?us-ascii?Q?QFx54mkhXgZ/s28D/z5vpSTmGcN6iWIruI5L2jXvEe3N4fSz5saqN1d+x4vb?=
 =?us-ascii?Q?lgRifDlUmyxTVvkzV9jmrdtYAc4R5KyrYNMYUybNDWrR7bvPz6cpHLzHo9s8?=
 =?us-ascii?Q?4M5jV7FSXb0cf3LBZ4KIliusaCLjCaP7cLw9Wo9DexRYI3hvJteRJZhezi8A?=
 =?us-ascii?Q?EGzJrWyyu+Mlsr20X5xOf6APWmtArxYx/A2jRMP74ISpmxNnm/ozACZFoU+N?=
 =?us-ascii?Q?ByCaeZ/M+S2+FiR7ij1ncukVv5v4fVoC8hLp65l7QeIPGlFs2+05NFIcVs2/?=
 =?us-ascii?Q?FvK9kjO6NokgdPjecISXEYGzovLVcccTmoHgXG2ZKzXSRC6QaxNKLOReNlFE?=
 =?us-ascii?Q?ZgJGrcTw2EMeKa6Xc4td/574M+3HxyGslo8nHO4UceumWt8QTtw1vAosMTDY?=
 =?us-ascii?Q?RbIi2tYmriguAwqR/t9rbuM/O/FDfM+iGCHC5uxH4z2ukdJHpmS3LR3Ix0Tf?=
 =?us-ascii?Q?isFRHPRcp/7N26u9sQsLh/ihN5X2Nwil7jeJfP6FUw118UUrtC0BnWXW0va0?=
 =?us-ascii?Q?2g0voQO9dffERgGylGfcsddxK3A2r3d67I040tAh3XSLJBDMZP8qd9FKj8J2?=
 =?us-ascii?Q?Zl41aVux4FJP6wLbAroYxIrBMnYfPNA4xRJgH005rtcz5xIG0GFEggCxyZOf?=
 =?us-ascii?Q?LSSxHVqF5Dyy5eD3zePAzJx9BO16s2/7FRFhlSrjRxXOoMBGzipVlFOrQS5A?=
 =?us-ascii?Q?noqReegurhPFvttKO2SBoktgcSpiC2/091ABoYqI3I5TKlaD5UFwdj5uIvtj?=
 =?us-ascii?Q?iF78eRSlcT+HvbvBuQiWEqZ8M4GFitSZzlpQpfRT8qemIdH55LSQ6wQFM6zr?=
 =?us-ascii?Q?2d/5IOZ81UQyTuwVr9zyfHGstfWtxygh9T14k0UcL64Of+LkmZRCm+YXbM9B?=
 =?us-ascii?Q?mxZMfKcfnd1tB/fqCZvcVG7EfRB/J3IdV3Bbfq8U/shumyM4gVNwDIAPY4Yv?=
 =?us-ascii?Q?g5Vaql5j9DwKoeU41RC8GbJFD9tcxpg4dpQIuWu2lKJfmWseh5cG/0oMGHE4?=
 =?us-ascii?Q?7GzQGYedMQS6aIQmZRhP6jsANhlPnc9z6moqIHQHCt3Bx/KRlk+rsJyKqSks?=
 =?us-ascii?Q?gQrnlZZO9Xz5EV9qSAxWPRge3bwOwLSOWgThzce9irMXiypKXNu0IXvGbNQT?=
 =?us-ascii?Q?L4KcpGFrBp+SMvJ+prpZs+3KvdqfKjKTIyhnJGlaqvxprxEosc90kjzl8D4C?=
 =?us-ascii?Q?NzP0d7URRlvl6UVjR3GkO1MckhuxKbZJSvFRi1wFF31MEGrIiUuHSJ1lDEbv?=
 =?us-ascii?Q?G+UYPQ9DeC+y2OD3wbw3bfMihyXmKiZbxXgsLl7A2Ou+a1J1QFq83YRXMhZ0?=
 =?us-ascii?Q?TgZ9Q93lkYSnswxSSiWmphyKuTnWsPFFLwURPphc6Geyk0a2?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW4PR12MB6803.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1caf74d9-dead-4749-0d0f-08def3ac303f
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Aug 2026 11:16:40.2287 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: VtV1jFnqKzHlBPAAynFMK7gHq+xi2KNsxaQ0aHjqSgtD0KmkraSehaoqsSkSM/zG
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB9055
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

dev_info() could flood dmesg, better to use dev_dbg().
Reviewed-by: Kenneth Feng <kenneth.feng@amd.com>

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

