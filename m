Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 95DB4C982E1
	for <amd-gfx@archiver.kernel.org>; Sun, 20 Sep 2026 14:41:41 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EEE5910E040;
	Sun, 20 Sep 2026 14:41:40 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="b8HC8uwV";
	dkim-atps=neutral
Received: from BN1PR04CU002.outbound.protection.outlook.com
 (mail-eastus2azon11010058.outbound.protection.outlook.com [52.101.56.58])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 58C4810E22F
 for <amd-gfx@lists.freedesktop.org>; Sun, 20 Sep 2026 14:41:39 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SEmnf2ABSY59YsfePO/YSSJvKRqqzyZu83X4L+0qi+8bwuaKcaHBQUX4UiD13FIB0QTcfAKZ+W1nD/IpXnYutMghQecUN6PncduSGsE4Gey1G5FuVzUouHQz9n/ys/U4Ego84C7YNwic0YsIeZndeZNTtUgJEFxBTJTnmFxUeQDuS4EnN0IbMD9re0+YbC1tvtfwDSdwPG1MFZ4RzGpjpGMWB93BKU8uyhswqvaI/xLoutjl7XfX1ogQHLzXD3AyFmfM6kg01gyoVk3MD4Y5Dba7btAb44GVmgSbDLhcACcyJrinM5L2yd82TSMkxmyKuMe26nuV085QJMxfr+j0sQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BYf+r/s9P/qHl+qohUXF+NvF0ux5KrXGAbg1HRYltsw=;
 b=Lbyzea4Sf+LUEJ+rt2Z/7hWJT9g9UNNGFagwTNgZ2xMzvfyq0WaZwi/fz79kJj8H1y3iMSJc9YyqRD5AaxqJygBX0zKvd665VJkuYORIUkCLmRcaZ+z1zEZtFuG5yaMP2GEmSvWmyvY5iwPvvjqMgSAteuydUGb5j3MiSlHYbep0wD5r76okB+1sQjWAuthzC+t8gBJkPKojybhQLxNxnMifmyABRpE737BhWzGMDx7JrtVQPQOgJF0ueOzF5yDwZDz2ZDIeZP99UjTj+Tmnxl+t3LMWTFionTO2jOq4ipmcr8ZAh5ipiYaoQYOUTVE/OOA/bBpO+LSoGLnvgzb9Zw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BYf+r/s9P/qHl+qohUXF+NvF0ux5KrXGAbg1HRYltsw=;
 b=b8HC8uwVOXPBiiHcPohzDDwHJzC3amrDX4bJ6I0OfoaDsMWLuBRaD+sPT6bfQx6Z+juHdZCFRGSUUG/SutY7JIdurfzsrgA0yiB4ZjdzWIxCmrXr3xnC01Wm+HATkf1XjHQ4igDxyLEChX0GJjXTX3Sv/GoK+Izaastm4LdCZWo=
Received: from BN7PPFFF39339DD.namprd12.prod.outlook.com
 (2603:10b6:40f:fc02::6eb) by DS7PR12MB6008.namprd12.prod.outlook.com
 (2603:10b6:8:7f::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.428.14; Sun, 20 Sep
 2026 14:41:33 +0000
Received: from BN7PPFFF39339DD.namprd12.prod.outlook.com
 ([fe80::9e62:eec6:fa38:a6a6]) by BN7PPFFF39339DD.namprd12.prod.outlook.com
 ([fe80::9e62:eec6:fa38:a6a6%4]) with mapi id 15.21.0428.015; Sun, 20 Sep 2026
 14:41:33 +0000
From: "Zhang, Hawking" <Hawking.Zhang@amd.com>
To: "Zhang, Horatio" <Hongkun.Zhang@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
CC: "Ma, Le" <Le.Ma@amd.com>, "Kuehling, Felix" <Felix.Kuehling@amd.com>,
 "Joshi, Mukul" <Mukul.Joshi@amd.com>, "Deucher, Alexander"
 <Alexander.Deucher@amd.com>
Subject: RE: [PATCH] drm/amdgpu: skip the PASID TLB fence for the UALink NPA VM
Thread-Topic: [PATCH] drm/amdgpu: skip the PASID TLB fence for the UALink NPA
 VM
Thread-Index: AQHdRov0BhuUh10hvE2DaTrMR97YE7bXPOmAgABP1qA=
Date: Sun, 20 Sep 2026 14:41:33 +0000
Message-ID: <BN7PPFFF39339DDA5A38FD4F0358D122C45FC852@BN7PPFFF39339DD.namprd12.prod.outlook.com>
References: <20260917100430.217954-1-hongkun.zhang@amd.com>
 <MN0PR12MB576143F1D159DB5DF1C1018CF7852@MN0PR12MB5761.namprd12.prod.outlook.com>
In-Reply-To: <MN0PR12MB576143F1D159DB5DF1C1018CF7852@MN0PR12MB5761.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-Mentions: Hongkun.Zhang@amd.com
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Enabled=True;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SetDate=2026-09-20T09:42:56.0000000Z;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Name=AMD General
 v26; MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_ContentBits=3;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Method=Standard
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN7PPFFF39339DD:EE_|DS7PR12MB6008:EE_
x-ms-office365-filtering-correlation-id: 25091ef5-c514-4705-513d-08df17254417
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|23010399003|376014|1800799024|366016|10067099003|56012099006|3023799007|22082099003|18002099003|4143699003|11063799006|5023799004|38070700021;
x-microsoft-antispam-message-info: 0va8sbf0LsBW/nLcHx6d8vqeQiroBd52rG5WAB+VRDVAXnUdfxglEfjTJYmKrXtItjDpGlpZ6UgZ1Xnh1wjxYMKPq5Ly/gWZht2K3yYgIGGVjDgJHhupinTLMzaiE9hlrvd2gyxbwKgwaYofixyC/u533lJXt2GXHPH4xl+/x3XorASOytZlHjdMVaDO3X8o7WE4MuN4dzIMUW8XMmOtvCC8uHQrEC/jMfmcM9AKPIRz0A8vicRPrEz76/uGFWH5Vqo76EApBZxVa7gcnKgFuYJjAsp30tpGVg1W+yIiwNuGKyZqvKH4bd+FcowB2OM0J4SLWJ0VB8B0Hl4O6YjmeTuwE0TwLqorKk/lqE5IivXSWgGwS7jkTW1PX36M23t0HJBwF8gXXTXiilXT6Wz91l4KLg+E1Ee8YzPguJenNMu94gbIhp1Z19RxIm3crCcFQpS9EnY1Zkf53cFkoNt0YMqM6fV2uNUjh8IcpKmtm3Mh3wo3VBLU/4e16pGVFPFMYUmjKz1dGCNL0oH/L5KZ7u+HZXqrXqqpK1adQ2gMKr7BeKOI/Fu6U2hN5ubtpKicvwxg22N7dWJQ4TPD5G0S4G86j4Hs0OFyLfsA9gHNHrpGeyyi1ETdQOxAskv2XUe3dULLG/9OjuLeJXr0zbvj9QfxIZ2DwAu8eBbFodfvpn65c3bj45AnUH28j+CoulUmj4MCG4nLpgnYt1AZX3n9sqdxZlngjDzM+gQTr+ckocA=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN7PPFFF39339DD.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(376014)(1800799024)(366016)(10067099003)(56012099006)(3023799007)(22082099003)(18002099003)(4143699003)(11063799006)(5023799004)(38070700021);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?hqwGJDBiCESfrpZvBqbT49J1xYFFAKujIvuf8kTz64MRB+QtvM4rlSl0RwB/?=
 =?us-ascii?Q?0pP8sX0rXUTZFnKtFdfNObwPSaZq8C9jWXNrUUlFByHC2WxbQmWFpskf9WoC?=
 =?us-ascii?Q?8ltbzz/pCXEHCAsgpqbeVB+xY5NUHtP9MkDXTmvYg7RomTugHt/0MpcNMff2?=
 =?us-ascii?Q?3ihp8rZUTQzuUZOAy0Ve82XF17zb94GqWt1aLRM3Y4SsJIL2IbeUH7vaKign?=
 =?us-ascii?Q?igQR/6eIzjEGSa7ennorsY0s54FyvmQCnJx6LYGF5H2WTz/u0H9lXqKo5LCX?=
 =?us-ascii?Q?iRBqR/1yLhTpBCpqLyLRX3OEUF1f+wypfC7PP1BOWLzrRIt0QbOx9opzQJ6e?=
 =?us-ascii?Q?A+ARGxlrvYKHTNI5cprCQSyVtttAVoJDCublCTfYzpnP8CsPEbG2RQ+Xp4Dt?=
 =?us-ascii?Q?mcF4J/7x1JYD97TZvdm7G83oi48K73tH3MDN/r+gy6xDt4OCi34R+eaZrzoQ?=
 =?us-ascii?Q?Dp35IYrxgQTSJmrC2GmbovIw0y+mMV4K3ZtibXDaBrjNTOCXkMCn9WZggoS4?=
 =?us-ascii?Q?qMyrnTkzuE25LfRj188+xtTI20s2n16FSu+Fhcg+z8xNTljI4IKXNhtMYGVx?=
 =?us-ascii?Q?1jHqIVhp10jUQTuCFrfVcBI7iqy2V2OATJ3sg2YsUjVQL1Onk7FZAbOnvEa6?=
 =?us-ascii?Q?CjwY3pR9LJIGhO/CBCWEzL3VaWcOS/wF3nhz5qTtsWcLkU6P9BD+42HB/ZOo?=
 =?us-ascii?Q?RaMeAXnPVEzCZEVrzniSF1Df6lSMr+sfj4qynGhCy7/+ugIT35f+3vacCESR?=
 =?us-ascii?Q?aorIOowIUSBrjGVBQlenka0aw9NTkSPDzW3RywxZLGc0HExaRrWP267plY/w?=
 =?us-ascii?Q?i9cWJflEABk8GsAXS/WtnNLK6q/iYWpgl+5Zd11gAbDH/18enmeXZIhzVfLB?=
 =?us-ascii?Q?jEeUhdTd/n84vzJLQJmqETkZjVGJCqEvFEnGLhsYV5GoMKoEY9c0BF0BCpRz?=
 =?us-ascii?Q?5ur4U6ndxUqeaeVMLrKPNeQhAnDSEwG0+tvcZZkVCi/xPrguYtvMWjUNY068?=
 =?us-ascii?Q?gjZ7XK4h2rEUaeueQ/DyGqRI7FUtHhFxaCVr2GgD0aRb1UltKnmYJ7PQsJCh?=
 =?us-ascii?Q?FX5qqLry0nqgBna10FvkLakvDRu4fhuiS6sTO06Wk978deUAUXUi0fikQDAc?=
 =?us-ascii?Q?BCSvBYGgFOYOulrSlTolSjM8VcBABhqo50SvmMBCf+4zgcjNghH5Figgqnrt?=
 =?us-ascii?Q?G89g3WguirJDbPVWAFLr3Zxp07FvYRkkmEFaaiGp70gk0RHnTKcxkZaxVvNt?=
 =?us-ascii?Q?sshas92o4cP8Zk1p2GgwLyA4yB43LVcD9hVe4qL2y2vMQSXEHPISL0OclYbt?=
 =?us-ascii?Q?AWo8eE0MPHRfnwM+z8H4Ri2GdUwU68e3PQZVQ3fLLgibmnCDMp8IgzbCoWy/?=
 =?us-ascii?Q?E+oteI7dApPhp7sYJFR91nMPZxaXcKUavUO5ROQvxyeh/iASHqzJN3kAT8v4?=
 =?us-ascii?Q?givyKU511QaMVCNXmtA/qivOulOyIU+UCMPzP1IcvFK4NQnd5FSP4YREUYj7?=
 =?us-ascii?Q?3rxmJEcFgN2TPyOkSVTbJNsuN+12v622yCwHxZtEeFWfIyi5N82RikGMrxXP?=
 =?us-ascii?Q?xuqmK15vyind6inEisT6zyLqogi0MI0fcZSihaCjH2Dr4trrxS7F3Rn8wSU7?=
 =?us-ascii?Q?b9YPmENWFZoLUbaYZVKYfYetwh0XygXCnVj1Tz3v4K6cefaooxBfl731NnPU?=
 =?us-ascii?Q?jpSZWD0VmQdyxGnqG4AlSkBqr2E8d78KqnYtaemZaLziETPQ?=
Content-Type: multipart/alternative;
 boundary="_000_BN7PPFFF39339DDA5A38FD4F0358D122C45FC852BN7PPFFF39339DD_"
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN7PPFFF39339DD.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 25091ef5-c514-4705-513d-08df17254417
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Sep 2026 14:41:33.3454 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: AZszTumpLiydRW1p3jp1hIt+YJqd6FLOhImeH5snvwRrHxNcY8Qf3ENbRecM+CZhohXFT7O+CUIYZfyPuOS8/A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB6008
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

--_000_BN7PPFFF39339DDA5A38FD4F0358D122C45FC852BN7PPFFF39339DD_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

AMD General


Hi @Zhang, Horatio<mailto:Hongkun.Zhang@amd.com>,

I think the issue is caused by the following code in sdma_v7_1_sw_init, whi=
ch incorrectly marks amdgpu user queues as enabled for SDMA 7.1 as long as =
the CONFIG_DRM_AMDGPU_NAVI3X_USERQ is enabled.

Since SDMA 7.1 does not amdgpu user queues (it only supports rocm user queu=
es), could you please remove this code and check whether the issue still oc=
curs?

#ifdef CONFIG_DRM_AMDGPU_NAVI3X_USERQ
        adev->userq_funcs[AMDGPU_HW_IP_DMA] =3D &userq_mes_funcs;
#endif

Regards,
Hawking

-----Original Message-----
From: Zhang, Horatio <Hongkun.Zhang@amd.com>
Sent: Sunday, September 20, 2026 5:47 AM
To: amd-gfx@lists.freedesktop.org
Cc: Zhang, Hawking <Hawking.Zhang@amd.com>; Ma, Le <Le.Ma@amd.com>; Kuehlin=
g, Felix <Felix.Kuehling@amd.com>; Joshi, Mukul <Mukul.Joshi@amd.com>; Deuc=
her, Alexander <Alexander.Deucher@amd.com>
Subject: RE: [PATCH] drm/amdgpu: skip the PASID TLB fence for the UALink NP=
A VM

AMD General

Gentle Ping ...

Best regards,
Horatio

-----Original Message-----
From: Horatio Zhang <hongkun.zhang@amd.com<mailto:hongkun.zhang@amd.com>>
Sent: Thursday, September 17, 2026 6:05 PM
To: amd-gfx@lists.freedesktop.org<mailto:amd-gfx@lists.freedesktop.org>
Cc: Zhang, Hawking <Hawking.Zhang@amd.com<mailto:Hawking.Zhang@amd.com>>; M=
a, Le <Le.Ma@amd.com<mailto:Le.Ma@amd.com>>; Zhang, Horatio <Hongkun.Zhang@=
amd.com<mailto:Hongkun.Zhang@amd.com>>
Subject: [PATCH] drm/amdgpu: skip the PASID TLB fence for the UALink NPA VM

amdgpu_vm_make_npa() builds the UALink NPA VM on top of amdgpu_vm_make_comp=
ute(), which unconditionally sets need_tlb_fence.
That flag makes amdgpu_vm_tlb_flush() queue an asynchronous PASID based TLB=
 invalidation after every page table update.

The NPA VM is created by the driver itself in
amdgpu_ualink_manager_start() and never gets a PASID assigned, so
vm->pasid stays 0, which MES cannot resolve on the MMHUB. The
vm->invalidation
never completes and MES stays unresponsive for the rest of the probe:

  amdgpu: MES(0, 0) failed to respond to msg=3DINVALIDATE_TLBS

The invalidation is not needed in the first place. An NPA VM is bound to th=
e reserved NPA VMID and amdgpu_ualink_flush_tlb() already invalidates that =
VMID on the MMHUB after every mapping change. Clear need_tlb_fence for NPA =
VMs.

Fixes: aac13f6eded6 ("drm/amdgpu: Pin page tables in NPA VMs")
Signed-off-by: Horatio Zhang <hongkun.zhang@amd.com<mailto:hongkun.zhang@am=
d.com>>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c b/drivers/gpu/drm/amd/a=
mdgpu/amdgpu_vm.c
index 68d668dfe4f8..e255b5100362 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
@@ -2793,6 +2793,7 @@ int amdgpu_vm_make_npa(struct amdgpu_device *adev, st=
ruct amdgpu_vm *vm)
                return r;

        vm->is_npa =3D true;
+       vm->need_tlb_fence =3D false;

        return 0;
 }
--
2.43.0



--_000_BN7PPFFF39339DDA5A38FD4F0358D122C45FC852BN7PPFFF39339DD_
Content-Type: text/html; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<html>
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Dus-ascii"=
>
<meta name=3D"Generator" content=3D"Microsoft Exchange Server">
<!-- converted from rtf -->
<style><!-- .EmailQuote { margin-left: 1pt; padding-left: 4pt; border-left:=
 #800000 2px solid; } --></style>
</head>
<body>
<font face=3D"Calibri" size=3D"2"><span style=3D"font-size:10pt;">
<div style=3D"padding-right:5pt;padding-left:5pt;"><font color=3D"blue">AMD=
 General<br>

</font></div>
<div style=3D"margin-top:5pt;"><font face=3D"Times New Roman" size=3D"3"><s=
pan style=3D"font-size:12pt;"><br>

</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">Hi <=
a href=3D"mailto:Hongkun.Zhang@amd.com"><font color=3D"#2B579A"><span style=
=3D"background-color:#E1DFDD;">@Zhang, Horatio</span></font></a>,</span></f=
ont></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">&nbs=
p;</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">I th=
ink the issue is caused by the following code in sdma_v7_1_sw_init, which i=
ncorrectly marks amdgpu user queues as enabled for SDMA 7.1 as long as the =
CONFIG_DRM_AMDGPU_NAVI3X_USERQ is enabled.
</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">&nbs=
p;</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">Sinc=
e SDMA 7.1 does not amdgpu user queues (it only supports rocm user queues),=
 could you please remove this code and check whether the issue still occurs=
?</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">&nbs=
p;</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">#ifd=
ef CONFIG_DRM_AMDGPU_NAVI3X_USERQ</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; adev-&gt;userq_funcs[AMDGPU_HW_IP_DM=
A] =3D &amp;userq_mes_funcs;</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">#end=
if</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">&nbs=
p;</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">Rega=
rds,</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">Hawk=
ing</span></font></div>
<a name=3D"_MailEndCompose"></a>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">&nbs=
p;</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">----=
-Original Message-----<br>

From: Zhang, Horatio &lt;Hongkun.Zhang@amd.com&gt; <br>

Sent: Sunday, September 20, 2026 5:47 AM<br>

To: amd-gfx@lists.freedesktop.org<br>

Cc: Zhang, Hawking &lt;Hawking.Zhang@amd.com&gt;; Ma, Le &lt;Le.Ma@amd.com&=
gt;; Kuehling, Felix &lt;Felix.Kuehling@amd.com&gt;; Joshi, Mukul &lt;Mukul=
.Joshi@amd.com&gt;; Deucher, Alexander &lt;Alexander.Deucher@amd.com&gt;<br=
>

Subject: RE: [PATCH] drm/amdgpu: skip the PASID TLB fence for the UALink NP=
A VM</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">&nbs=
p;</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">AMD =
General</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">&nbs=
p;</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">Gent=
le Ping ...</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">&nbs=
p;</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">Best=
 regards,</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">Hora=
tio</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">&nbs=
p;</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">----=
-Original Message-----</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">From=
: Horatio Zhang &lt;<a href=3D"mailto:hongkun.zhang@amd.com">hongkun.zhang@=
amd.com</a>&gt;</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">Sent=
: Thursday, September 17, 2026 6:05 PM</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">To: =
<a href=3D"mailto:amd-gfx@lists.freedesktop.org">amd-gfx@lists.freedesktop.=
org</a></span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">Cc: =
Zhang, Hawking &lt;<a href=3D"mailto:Hawking.Zhang@amd.com">Hawking.Zhang@a=
md.com</a>&gt;; Ma, Le &lt;<a href=3D"mailto:Le.Ma@amd.com">Le.Ma@amd.com</=
a>&gt;; Zhang, Horatio &lt;<a href=3D"mailto:Hongkun.Zhang@amd.com">Hongkun=
.Zhang@amd.com</a>&gt;</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">Subj=
ect: [PATCH] drm/amdgpu: skip the PASID TLB fence for the UALink NPA VM</sp=
an></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">&nbs=
p;</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">amdg=
pu_vm_make_npa() builds the UALink NPA VM on top of amdgpu_vm_make_compute(=
), which unconditionally sets need_tlb_fence.</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">That=
 flag makes amdgpu_vm_tlb_flush() queue an asynchronous PASID based TLB inv=
alidation after every page table update.</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">&nbs=
p;</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">The =
NPA VM is created by the driver itself in</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">amdg=
pu_ualink_manager_start() and never gets a PASID assigned, so</span></font>=
</div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">vm-&=
gt;pasid stays 0, which MES cannot resolve on the MMHUB. The </span></font>=
</div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">vm-&=
gt;invalidation</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">neve=
r completes and MES stays unresponsive for the rest of the probe:</span></f=
ont></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">&nbs=
p;</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">&nbs=
p; amdgpu: MES(0, 0) failed to respond to msg=3DINVALIDATE_TLBS</span></fon=
t></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">&nbs=
p;</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">The =
invalidation is not needed in the first place. An NPA VM is bound to the re=
served NPA VMID and amdgpu_ualink_flush_tlb() already invalidates that VMID=
 on the MMHUB after every mapping change.
Clear need_tlb_fence for NPA VMs.</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">&nbs=
p;</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">Fixe=
s: aac13f6eded6 (&quot;drm/amdgpu: Pin page tables in NPA VMs&quot;)</span>=
</font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">Sign=
ed-off-by: Horatio Zhang &lt;<a href=3D"mailto:hongkun.zhang@amd.com">hongk=
un.zhang@amd.com</a>&gt;</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">---<=
/span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;"> dri=
vers/gpu/drm/amd/amdgpu/amdgpu_vm.c | 1 +</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;"> 1 f=
ile changed, 1 insertion(+)</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">&nbs=
p;</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">diff=
 --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c b/drivers/gpu/drm/amd/amdgp=
u/amdgpu_vm.c</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">inde=
x 68d668dfe4f8..e255b5100362 100644</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">--- =
a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+++ =
b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">@@ -=
2793,6 +2793,7 @@ int amdgpu_vm_make_npa(struct amdgpu_device *adev, struct=
 amdgpu_vm *vm)</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp; return r;</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">&nbs=
p;</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; vm-&gt;is_npa =3D true;</span></font=
></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; vm-&gt;need_tlb_fence =3D false;</span></=
font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">&nbs=
p;</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return 0;</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;"> }</=
span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">--</=
span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">2.43=
.0</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">&nbs=
p;</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">&nbs=
p;</span></font></div>
</span></font>
</body>
</html>

--_000_BN7PPFFF39339DDA5A38FD4F0358D122C45FC852BN7PPFFF39339DD_--
