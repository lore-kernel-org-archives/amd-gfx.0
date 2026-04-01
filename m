Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 575F2D2ED0A
	for <amd-gfx@archiver.kernel.org>; Wed,  1 Apr 2026 14:13:06 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E23F010ECBB;
	Wed,  1 Apr 2026 14:13:05 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="4Ci1XNET";
	dkim-atps=neutral
Received: from BN1PR04CU002.outbound.protection.outlook.com
 (mail-eastus2azon11010015.outbound.protection.outlook.com [52.101.56.15])
 by gabe.freedesktop.org (Postfix) with ESMTPS id ACDEA10ECBB
 for <amd-gfx@lists.freedesktop.org>; Wed,  1 Apr 2026 14:13:04 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fre5KtkrxKwaCi3+tXEYytbWEe6vEBK20iuLiopwuJwuNHbBynumOJF1oUF9qj3KeotpGxhbaUQTKFnNODQAi7rVQ6ClAi9E+xGNiY/oDLsjY489RtAHJSvl/l0F5bow/FsOabqNFYE4wxZZbrdW6WE0xMLyHc1eyRvW7DxAptw9Re1VRQIRalPaH4YzyI5ntzPmM7qSq/UtBQxTq54IxFbFIxssj3PB1RKiFlaS2UTdfRTUUf5eyRiACrMXG6/5sNFFprXCUwu/L0XRzp6VLPg3vDrM3a/HUm8vWuHaa7x8q++aK/wrVZV5fGtl3M8dMrXtpTpT7BWOSthA1qwPPg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GCNO+Qjbhtcbn88RmPlJhI3YPpKwDzORjq8UCUyV2xA=;
 b=pW23Ew/spp/uaq3v5CJtm1g9L2t2UB/enVx6xp3wB0+R90EID9IDTOa9a2yO2Trn1eV4Hu2jcL8bfxythJmh3Iir/fXo2JUu6mkDcjCEcKO5RBdwUoAUmj62l73PVygZOOPDBnU24wTCKorUXtgyDBu5UDBWh2JC1hdhfMEu8e7m1TX3KBv8U/D6spkliBiQgutuubu0+tUdxzYcd1YV6Q8Rz24ycTzttC6Uo3dVj2VKEyhVYZMZXg4QCt2bvDK6imby9jy7v02YBd0533kWlqLgOJkJRD15tlweBgia5ON6BSO70NslpPGrIvvopNJroDDudtggeAjjxn5BmxImXA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GCNO+Qjbhtcbn88RmPlJhI3YPpKwDzORjq8UCUyV2xA=;
 b=4Ci1XNETOvm5SFVz7ursiTKnVY2ZGrFqFskHypRpTEko4/2NJZdwTPRHBLJVPQUx0SV9AgnA2iL++bhGRuI6ceuqH6+efCGAXkypUA5zh1A2bIvgJ/hz6CyiBRkbPwcQDIHWCcQuHAo9x7RhrJPbRBKHHPG69sctNsGClsKqQt0=
Received: from SJ2PR12MB8650.namprd12.prod.outlook.com (2603:10b6:a03:544::13)
 by BY5PR12MB4052.namprd12.prod.outlook.com (2603:10b6:a03:209::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.16; Wed, 1 Apr
 2026 14:12:59 +0000
Received: from SJ2PR12MB8650.namprd12.prod.outlook.com
 ([fe80::574c:e97b:b0d8:3957]) by SJ2PR12MB8650.namprd12.prod.outlook.com
 ([fe80::574c:e97b:b0d8:3957%6]) with mapi id 15.20.9723.018; Wed, 1 Apr 2026
 14:12:58 +0000
From: "Kasiviswanathan, Harish" <Harish.Kasiviswanathan@amd.com>
To: "Liu, Alysa" <Alysa.Liu@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: Re: [PATCH v4] drm/amdkfd: Add upper bound check for num_of_nodes
Thread-Topic: [PATCH v4] drm/amdkfd: Add upper bound check for num_of_nodes
Thread-Index: AQHcweCrMiI6yePY70CEYzRqoB78VrXKP3VW
Date: Wed, 1 Apr 2026 14:12:58 +0000
Message-ID: <SJ2PR12MB8650B44EAE1BDBAD444088198C50A@SJ2PR12MB8650.namprd12.prod.outlook.com>
References: <20260401140551.19398-1-Alysa.Liu@amd.com>
In-Reply-To: <20260401140551.19398-1-Alysa.Liu@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=True;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2026-04-01T14:12:58.479Z;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution
 Only; MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=1;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard; 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ2PR12MB8650:EE_|BY5PR12MB4052:EE_
x-ms-office365-filtering-correlation-id: 9515fd02-17f8-43c3-a627-08de8ff8c722
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|38070700021|8096899003|22082099003|18002099003|56012099003;
x-microsoft-antispam-message-info: obhyDgQ7N15cxbFr7QoUeMyVLBGDpp0gRbd9dBxcb2GFpjBTvm8l8I2eXWcLWPtFxW6u5oQSv+nw0RjThK5akfJwXIEwxmNmTztVHr1l8rG+M1wcs/whXIBIbUp/xsYs9HYPr1Udcd3wJpt17LkHq5nLcKRQnuW0SrK75FUGjRrwOGp1+2n3csYhZRzYsthPX4FrxuVT+3J6yBeYK+Sz1Kez9WxuREgdRuBWqxireBFZn8e0UIK6l/zvl7y1viZWbVl/OOJtDtli5nXBx5sbID13YRZyeo+MFSNhGascmKtU7X0amF1AD65wh59mN69XmC7nBn1rrmcKeaXox2bWdoE1v/yC+7R2zStIz9e1y95egxc71VU8ldVQp1JlALaFkmvarbqUuHwIqE7IBEVT2iElwmiyeUTOSqu2WWw/ZwX0bU3efYogGXvT4k8f7kaatvPDRaJC830C97F7kQUiClQx7eC3syO/m54wBMDcpewOth373Owt4FUPmK4SfOQ45/1fcMfOCTjrIfgS093v83G//S4lXbhasi2KDGKsd+1bGAeeNs/SHvUs9Jd2lLQ2kzr8NH6Qw87gN9EwXL+UtYZ7UM4YI8/7/p2vCPV9Dq1YrV/ZNnN4AkVxQAoN8YDUW1tQq/ogv9gYsfd1Q2hvMr7T/tBBzn9cG0O86+W+bXc0R9TXCIchIFOjp1uYaDnQtVYnEn8L5jbzzuE8/t/xqyqVSkFg2Dw8aBE9aXNQw+cNUErcOkpLnlT263hfTjReNvXi0aG0KlMIAh0QTCi30v77A9/B5gup67rL3hUgHWo=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ2PR12MB8650.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(38070700021)(8096899003)(22082099003)(18002099003)(56012099003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?ufM8eEf3B1h2xz8gcxkrfx9OYqSpPOqRyGC29KFZJ/yEIw7JXlNfSAyG5IFZ?=
 =?us-ascii?Q?2VtQ7TEMSnxgZFR0xG+SPjSYKTMlPSecYj6bPBvY6jJ5nELwbqkCzNAOjtu2?=
 =?us-ascii?Q?Ta9prYAx6F8RxmCySaniZidg6hjKgRJ+m54PQufU2Dn2F2bK00Zcdb7Jebeq?=
 =?us-ascii?Q?76ZLEU6E6DHs8Vo6PIY+XzGiyubmp+eCR+ZZdh/g2EJnFXzONIyZv45qSkNr?=
 =?us-ascii?Q?9g/djf1mmsFI4Ve1D165Pflvl/iiumbXSmYVLwt/IqkyS/jMtju7f1SySS8M?=
 =?us-ascii?Q?uLgxrNBtjOh+L09zFBp+D01vtIrNoCY6n5dQNPfLiMr0lYbSSBNYkqQxXzBQ?=
 =?us-ascii?Q?H7BxeDK3YEGzIsHvYfI1T/eaX8U8X5LsIKjKF03JyyCzP9T5FUyMBG07vqo1?=
 =?us-ascii?Q?ywmT2XczN+QwIS+AbzDcYH1GcaAM3Xx2cJNpomDltQHwxE86tE1Ci2kkqPlP?=
 =?us-ascii?Q?Q/1rmWDHQYY0IV7sszr+RW+QTmD4XN8Xp9QZqwaD6eP1kJrSX0aN1kM3RIac?=
 =?us-ascii?Q?w3onoA7HdgIUuy6iS++1JxLIb7MfKCjS0UGQCWG74reuB+9ysdrc3tnfHWAu?=
 =?us-ascii?Q?SeWhjJIw0/a3UB1teNz2bLGyxQKS/6uxoZDkcO0pC2U9ywcsfNTJnggGPoub?=
 =?us-ascii?Q?u0xH8MgahgWY24Y0+3j+4hOVv6I4I58KusrVJdsH/WoAUUp+P3qVOWwkbJex?=
 =?us-ascii?Q?CsIxVVvcTgjp3pfQo4q73g3DfYw44M1RgFpXZ7e568M71blw0Ztjnok0hdnz?=
 =?us-ascii?Q?x2vkqps0DZxa5e+N+XQhwzZUJMo3UZPBUdNRmy2QKBpfVMMTTUNwC7XA8xkL?=
 =?us-ascii?Q?iTzmvwVRqbFV2ugK8RiQuq+51pmLcPkOHh0qNyUnaUTMoSXMkyg+4r8uqxmD?=
 =?us-ascii?Q?tJ1Sui3C2j4x34Ket5/+0MS0NMnQ4+EFXId29DVy2EuUpkSqZYvDqTcILNDW?=
 =?us-ascii?Q?TNtpWdQkp47SDOjt69eX4+3/UWycLMUcR8K7hQt7E6ckZ75QzyvARY4ZlErx?=
 =?us-ascii?Q?QRbnEVFIE8y4ufwxpXk51qUOhOydnJzB4Ai9i64xGE/19jsTxUUlqp9ZNJNC?=
 =?us-ascii?Q?FxhxowGpr0wr5Qkg1OYYL/Ky+M6fnRZnW3+rUjTGt0/ZSgMALXadYkUSLCDM?=
 =?us-ascii?Q?CIhHsbHd5emrq8c9eVug6PQljL3KzaQ1aqCLeZry+oWOi1vPe14dqmaH42Cl?=
 =?us-ascii?Q?HtAiyFuBV3N2ElO5p4w4xndE3DIGcjrNit+heRSAp0zH4wAQB9eod14wa60e?=
 =?us-ascii?Q?6eR3JerMV7U8sIOTiyUUPPFn+lq6h0/8CeNIDwDJ/FUxEBwpmpeoRoOeRsVY?=
 =?us-ascii?Q?m6uL3f6RmPeiaYwn4Ofc8nhGTcfMG91kn8rXXqj+y2JhzgTttjw7PaKDhe0s?=
 =?us-ascii?Q?VurQYAs3O4MwrNAJ1J3Vjp1WBbZ0PP4901bc+FzjmBOucX2dpNy2YIRewkx6?=
 =?us-ascii?Q?PCTtpYYHI5C7TmKUFRPsemJm17tBakwVosZZ2ianSRkUF7Q/jfYYR5/unX7z?=
 =?us-ascii?Q?YMsNklxI1zCpgHnWsuR9k2j7idlH++RNWfprRlqMB6nBNdpge9DdSJRLkUza?=
 =?us-ascii?Q?BWoeuntYqdxu7Qfux123ZJY+GC4ffo7SJ48mqKqI1jUjkJs7E80I1vV8peAQ?=
 =?us-ascii?Q?Yw71GaKn/4N3KzKWvpHH19BNe++m8Sg9T22BwwvMqEXXPeXj6IeRB5ei0yVB?=
 =?us-ascii?Q?QPUnwyJS5MyGjfRTDH2WBTvaO5uFQI6sHmENPAts0jDocr5t?=
Content-Type: multipart/alternative;
 boundary="_000_SJ2PR12MB8650B44EAE1BDBAD444088198C50ASJ2PR12MB8650namp_"
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR12MB8650.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9515fd02-17f8-43c3-a627-08de8ff8c722
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Apr 2026 14:12:58.8467 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 15nUqSHNMk0xSpBXXGnzqOLFhzESmcedTpTN4XrkcKMWhDQ/ZUytN5tJo3ZwqNtqJUjBZ5peGV9puEyP36iVpg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4052
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

--_000_SJ2PR12MB8650B44EAE1BDBAD444088198C50ASJ2PR12MB8650namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

[AMD Official Use Only - AMD Internal Distribution Only]

Reviewed-by: Harish Kasiviswanathan <Harish.Kasiviswanathan@amd.com>
________________________________
From: Liu, Alysa <Alysa.Liu@amd.com>
Sent: Wednesday, April 1, 2026 10:05 AM
To: amd-gfx@lists.freedesktop.org <amd-gfx@lists.freedesktop.org>
Cc: Kasiviswanathan, Harish <Harish.Kasiviswanathan@amd.com>; Liu, Alysa <A=
lysa.Liu@amd.com>
Subject: [PATCH v4] drm/amdkfd: Add upper bound check for num_of_nodes

drm/amdkfd: Add upper bound check for num_of_nodes
in kfd_ioctl_get_process_apertures_new.

Signed-off-by: Alysa Liu <Alysa.Liu@amd.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_chardev.c  |  3 +++
 drivers/gpu/drm/amd/amdkfd/kfd_priv.h     |  1 +
 drivers/gpu/drm/amd/amdkfd/kfd_topology.c | 11 +++++++++++
 3 files changed, 15 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c b/drivers/gpu/drm/amd=
/amdkfd/kfd_chardev.c
index 1db565442c48..5435419a7bd9 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
@@ -776,6 +776,9 @@ static int kfd_ioctl_get_process_apertures_new(struct f=
ile *filp,
                 goto out_unlock;
         }

+       if (args->num_of_nodes > kfd_topology_get_num_devices())
+               return -EINVAL;
+
         /* Fill in process-aperture information for all available
          * nodes, but not more than args->num_of_nodes as that is
          * the amount of memory allocated by user
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h b/drivers/gpu/drm/amd/am=
dkfd/kfd_priv.h
index e7a8f3e17872..af7b687d729c 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
@@ -1191,6 +1191,7 @@ static inline struct kfd_node *kfd_node_by_irq_ids(st=
ruct amdgpu_device *adev,
         return NULL;
 }
 int kfd_topology_enum_kfd_devices(uint8_t idx, struct kfd_node **kdev);
+uint32_t kfd_topology_get_num_devices(void);
 int kfd_numa_node_to_apic_id(int numa_node_id);
 uint32_t kfd_gpu_node_num(void);

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_topology.c b/drivers/gpu/drm/am=
d/amdkfd/kfd_topology.c
index 1ccd4514d3ee..4dc9f9aa3a2e 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_topology.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_topology.c
@@ -2297,6 +2297,17 @@ int kfd_topology_remove_device(struct kfd_node *gpu)
         return res;
 }

+uint32_t kfd_topology_get_num_devices(void)
+{
+       uint32_t num_devices;
+
+       down_read(&topology_lock);
+       num_devices =3D sys_props.num_devices;
+       up_read(&topology_lock);
+
+       return num_devices;
+}
+
 /* kfd_topology_enum_kfd_devices - Enumerate through all devices in KFD
  *     topology. If GPU device is found @idx, then valid kfd_dev pointer i=
s
  *     returned through @kdev
--
2.34.1


--_000_SJ2PR12MB8650B44EAE1BDBAD444088198C50ASJ2PR12MB8650namp_
Content-Type: text/html; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<html>
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Dus-ascii"=
>
<style type=3D"text/css" style=3D"display:none;"> P {margin-top:0;margin-bo=
ttom:0;} </style>
</head>
<body dir=3D"ltr">
<div>
<div style=3D"font-family: Calibri; text-align: left; color: rgb(0, 0, 255)=
; margin-left: 5pt; font-size: 10pt;">
[AMD Official Use Only - AMD Internal Distribution Only]</div>
<br>
</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 11pt; c=
olor: rgb(0, 0, 0);">
Reviewed-by: Harish Kasiviswanathan &lt;Harish.Kasiviswanathan@amd.com&gt;<=
/div>
<div id=3D"appendonsend"></div>
<hr style=3D"display:inline-block;width:98%" tabindex=3D"-1">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" st=
yle=3D"font-size:11pt" color=3D"#000000"><b>From:</b> Liu, Alysa &lt;Alysa.=
Liu@amd.com&gt;<br>
<b>Sent:</b> Wednesday, April 1, 2026 10:05 AM<br>
<b>To:</b> amd-gfx@lists.freedesktop.org &lt;amd-gfx@lists.freedesktop.org&=
gt;<br>
<b>Cc:</b> Kasiviswanathan, Harish &lt;Harish.Kasiviswanathan@amd.com&gt;; =
Liu, Alysa &lt;Alysa.Liu@amd.com&gt;<br>
<b>Subject:</b> [PATCH v4] drm/amdkfd: Add upper bound check for num_of_nod=
es</font>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt;=
">
<div class=3D"PlainText">drm/amdkfd: Add upper bound check for num_of_nodes=
<br>
in kfd_ioctl_get_process_apertures_new.<br>
<br>
Signed-off-by: Alysa Liu &lt;Alysa.Liu@amd.com&gt;<br>
---<br>
&nbsp;drivers/gpu/drm/amd/amdkfd/kfd_chardev.c&nbsp; |&nbsp; 3 +++<br>
&nbsp;drivers/gpu/drm/amd/amdkfd/kfd_priv.h&nbsp;&nbsp;&nbsp;&nbsp; |&nbsp;=
 1 +<br>
&nbsp;drivers/gpu/drm/amd/amdkfd/kfd_topology.c | 11 +++++++++++<br>
&nbsp;3 files changed, 15 insertions(+)<br>
<br>
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c b/drivers/gpu/drm/amd=
/amdkfd/kfd_chardev.c<br>
index 1db565442c48..5435419a7bd9 100644<br>
--- a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c<br>
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c<br>
@@ -776,6 +776,9 @@ static int kfd_ioctl_get_process_apertures_new(struct f=
ile *filp,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; goto out_unlock;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&nbsp;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (args-&gt;num_of_nodes &gt; kfd_to=
pology_get_num_devices())<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; return -EINVAL;<br>
+<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* Fill in process-apertur=
e information for all available<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * nodes, but not mor=
e than args-&gt;num_of_nodes as that is<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * the amount of memo=
ry allocated by user<br>
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h b/drivers/gpu/drm/amd/am=
dkfd/kfd_priv.h<br>
index e7a8f3e17872..af7b687d729c 100644<br>
--- a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h<br>
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h<br>
@@ -1191,6 +1191,7 @@ static inline struct kfd_node *kfd_node_by_irq_ids(st=
ruct amdgpu_device *adev,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return NULL;<br>
&nbsp;}<br>
&nbsp;int kfd_topology_enum_kfd_devices(uint8_t idx, struct kfd_node **kdev=
);<br>
+uint32_t kfd_topology_get_num_devices(void);<br>
&nbsp;int kfd_numa_node_to_apic_id(int numa_node_id);<br>
&nbsp;uint32_t kfd_gpu_node_num(void);<br>
&nbsp;<br>
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_topology.c b/drivers/gpu/drm/am=
d/amdkfd/kfd_topology.c<br>
index 1ccd4514d3ee..4dc9f9aa3a2e 100644<br>
--- a/drivers/gpu/drm/amd/amdkfd/kfd_topology.c<br>
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_topology.c<br>
@@ -2297,6 +2297,17 @@ int kfd_topology_remove_device(struct kfd_node *gpu)=
<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return res;<br>
&nbsp;}<br>
&nbsp;<br>
+uint32_t kfd_topology_get_num_devices(void)<br>
+{<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t num_devices;<br>
+<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; down_read(&amp;topology_lock);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; num_devices =3D sys_props.num_devices=
;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; up_read(&amp;topology_lock);<br>
+<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return num_devices;<br>
+}<br>
+<br>
&nbsp;/* kfd_topology_enum_kfd_devices - Enumerate through all devices in K=
FD<br>
&nbsp; *&nbsp;&nbsp;&nbsp;&nbsp; topology. If GPU device is found @idx, the=
n valid kfd_dev pointer is<br>
&nbsp; *&nbsp;&nbsp;&nbsp;&nbsp; returned through @kdev<br>
-- <br>
2.34.1<br>
<br>
</div>
</span></font></div>
</body>
</html>

--_000_SJ2PR12MB8650B44EAE1BDBAD444088198C50ASJ2PR12MB8650namp_--
