Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 67CC5C369B1
	for <amd-gfx@archiver.kernel.org>; Wed, 16 Apr 2025 08:45:49 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1249610E252;
	Wed, 16 Apr 2025 08:45:49 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="SBC7nE8E";
	dkim-atps=neutral
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2085.outbound.protection.outlook.com [40.107.237.85])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D56A210E252
 for <amd-gfx@lists.freedesktop.org>; Wed, 16 Apr 2025 08:45:47 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=J9zfKko83Stqth7GFtQaGXfprv7SGuCiWDVUJO9oJ5UhAED8zaIb4Fes8QMTJchgqk5uIM7CV5IN8jOF+WBtISxnXLi10J3CTlBuMKOZn4V5EVlr32mQ++4eZrZczPp3UTWiKGeoUaE2DZFGfw8KyDEKIfBGys2wy2mGr1dpp8eUX0cEEn12rbYLZpXNfS554LNFXrnmjbaPjAE+L+uqpq50e8s4wFGa4G0X5Xbylt/y90rgfOZ+etXAz6ZuhnOuWOM7iDZHGHiGE4uSqXQOJGBme4pphsfL+LPDIJulr9ISr6ImUoClgSMYPs09vV9D1wihBGR2vzLGX0t9fXMevQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=h9DLNoOzYpckyC6t0mIjpe9C2PTPTMi/uGq1+SdJx9I=;
 b=tntLvEiKzYLybKaIQ+YDZ4adHalIlrnfNi4RhlXD4L0ahFzProcgScfvGPRq8rZWYlYBaaYmHUyAKPUbbvVjk1f5UHXa0i9IyPv1vitj/n+ziU5kkeKd5MmIWKCcMCBYmSJf5wjEoemO7KP0+6LpOHk5mFcP7/NZFQ9mju1lommw7BxGfY4O2ZY6s352eGcY3nQ9oQ9esJY3JPFPwVEcWFZ7EMXDSrj8FcM86OaD5QQ9wXhTuPqSULm39FiXh6hTdZpWPNHLf5ouh/9w6yhZhb9ByfG4R/S7+R0PZx4+Ezdd0jGIohcyQhOWxnOhhXdFswrCBhyG8ZdqWhgXEORIAQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=h9DLNoOzYpckyC6t0mIjpe9C2PTPTMi/uGq1+SdJx9I=;
 b=SBC7nE8E1SaSU1G/ToCZ4iR2G/EiUNEhYHqQUHKRc/Ayg2IrIYAjfLLPGYnmoRlOnIDynFaiKsg7Yo0VsMCd6Kzo1UPKS5Ubwzfzf5h1oSHzwUSXOhUb+uu4OCcFqCdfjVhUxCqhjqDk5PhEK20Zn48J6MMNTxnxk9lfGzwUQBI=
Received: from BN9PR12MB5257.namprd12.prod.outlook.com (2603:10b6:408:11e::16)
 by IA0PR12MB9045.namprd12.prod.outlook.com (2603:10b6:208:406::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8632.35; Wed, 16 Apr
 2025 08:45:45 +0000
Received: from BN9PR12MB5257.namprd12.prod.outlook.com
 ([fe80::c593:f43d:c798:e009]) by BN9PR12MB5257.namprd12.prod.outlook.com
 ([fe80::c593:f43d:c798:e009%4]) with mapi id 15.20.8632.030; Wed, 16 Apr 2025
 08:45:45 +0000
From: "Zhang, Hawking" <Hawking.Zhang@amd.com>
To: "Lazar, Lijo" <Lijo.Lazar@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
CC: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Kamal, Asad"
 <Asad.Kamal@amd.com>
Subject: RE: [PATCH v2] drm/amdgpu: Disallow partition query during reset
Thread-Topic: [PATCH v2] drm/amdgpu: Disallow partition query during reset
Thread-Index: AQHbrqc4Jmks61vsGkO25sDkqwoo4LOl+oCA
Date: Wed, 16 Apr 2025 08:45:45 +0000
Message-ID: <BN9PR12MB52578C679851A98F55E92D19FCBD2@BN9PR12MB5257.namprd12.prod.outlook.com>
References: <20250416081134.850454-1-lijo.lazar@amd.com>
In-Reply-To: <20250416081134.850454-1-lijo.lazar@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ActionId=f20f2af3-50a2-4dc9-8a44-779f6b1d8407;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=0;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=true;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution Only;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2025-04-16T08:45:28Z;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Tag=10, 3, 0, 1;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR12MB5257:EE_|IA0PR12MB9045:EE_
x-ms-office365-filtering-correlation-id: c5c0b255-c09e-45b3-a4b1-08dd7cc313f2
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|38070700018|7053199007; 
x-microsoft-antispam-message-info: =?us-ascii?Q?dys1Y3yTntyDVBpfWwsp5Xe6AS3aV4ce7LCZ24nra8vrUHHMl7CRRa+76jOD?=
 =?us-ascii?Q?VxwPEFt0DRvxLzbvN7CHJbMewbmqkoQwVBQxvT0lro4V7uhK+MZqpp1VK3gJ?=
 =?us-ascii?Q?u0tGqhHn7K38CqsKdtty0meKLxEpsNiQXsC8UWMtEj2gBxXjaiBKLZUmftYQ?=
 =?us-ascii?Q?djiCNmDqA4cyswBeTpjG5ViTiVeKUz/BoUW0fs2qUQeElEUxaJW0H0k2Ob5e?=
 =?us-ascii?Q?PcKifhK51aCQAwTX7YXEIewKnghBu3/0jn2JrzbiNK8A+4NGiI44HmeMV3GO?=
 =?us-ascii?Q?fKKdwm4/evWVEd9R2Ce4S6JBh6Za0HpegfxMSAWaHXTXk+NJqAqyHIz1iJij?=
 =?us-ascii?Q?OuCrdGZGl0wbJ8VMJUFrewV4DOEEL3AuUD4nP+GJrRHChjKRxSrQopizFREZ?=
 =?us-ascii?Q?p4z7wkZB1xOKDyJ0czwVzRsvL5A0ZhmfQmL1DpF4+cf3Q0B1UUw5Gj0toVoM?=
 =?us-ascii?Q?mWYLfl5l1Ew1U5fpMlo6Dj3FS9aINAUF11tLPRDUFxA7DYqdcI1rKr8sZhM8?=
 =?us-ascii?Q?F7easORroESSD1UYYM65bavLs89WT5M8aovxMIt4wtLgaeA+iyMBkCf/EH59?=
 =?us-ascii?Q?iMt40is9doaa5zrKpn0WF7UEWHL0iCpjydy0qeMX7931EUY2TZohU/LU0/2p?=
 =?us-ascii?Q?UemGRDyDVspjCq293GotD/qBeIPfNOVnE6qhKkpDmkyw1ug5JBd6FArBssys?=
 =?us-ascii?Q?g6OUcz//+vsi3fOwfRB50+jkNjSr4h2uTYHuqmeLNLTxDbvEuFNEV/8f5dQ0?=
 =?us-ascii?Q?EBiFdWwrDJsaIMx19HM+3gxmdL5Ovzk+0jZdbczGJ86mRCVL0C6KOXjnWfPn?=
 =?us-ascii?Q?5w2nKoXpFzzA/6LCnkRTckrazWe59HlUgLl1mbOF0RbB9oLbFNIuxCbsbfKq?=
 =?us-ascii?Q?gCHenkMGY+pFR3mIlxIrSoPdr8yQCe5fd9YTVRrzYngsqdR67ewYEo9ILMQu?=
 =?us-ascii?Q?554issQOS2i4fIiXqrJvE15Ok/vobB2Xn8i2xy+p3O9GC13SmaLQFgNUawvI?=
 =?us-ascii?Q?A/MA07HDRtL/DTBE+LqEvsp/pFoq7gLjxlpSr4RB1v9q1txPpDGU4D7+aq/1?=
 =?us-ascii?Q?LvLJMjilVJArhASUq1qbtuYAwWDei+LqJbJHS5uOd0s+HEXMdchv41vt2LFt?=
 =?us-ascii?Q?GhMMZwq2Poubgn1Yln6RoQQB+pwcFCZB1LXslOuktc23Dzny9dfI/ywcrW8t?=
 =?us-ascii?Q?Nr7cQ+4TWf2um85oHhpSgsYYEawwr6ctuTBD6hcZlLWsrRnNms3ysx+qJXg1?=
 =?us-ascii?Q?xqyzVNiwl8waUnBTyLTvVdue2bKl+0Es0RfxDYhdYCO2EMEn/LVBZy3xnuWo?=
 =?us-ascii?Q?+LRAq3v+eioXWibnIbeiBRqGjjDN+yiSsVgeY+JESWVDfMsyoODbdO95hlqC?=
 =?us-ascii?Q?CJClF8IjufNHkdYRv0PMb+aecnR5w8qYlocc7zkOefLMabGTs7tM5G/ITq24?=
 =?us-ascii?Q?+eprbIc2yzvZekfvtmXdotUneD7d2HeP/RBTBgZo+Hf681Z0EmRTVw=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5257.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(38070700018)(7053199007); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?nT0SAmETTtXstBFCjJ6yeUhzW90LxQG1wcHjcklpszqwJ3S+xnDj517l4U2q?=
 =?us-ascii?Q?9KEKhaxrOgwxCyAGlI5+Xoj5+3mvwI/91NXrid1BuMB2rXtSi/LlOACORtML?=
 =?us-ascii?Q?Az2Ojuemi14qtkNzN7TZip8iCZ/Os//gQk1IxKUOQTzeCCajoQXMn7ch5Y7U?=
 =?us-ascii?Q?aOMLAimlLqRYd4xmnqoiEJw1CL5gxkt6QNp+bpn4n7xsBWo3dlmUD5Tcf1Jj?=
 =?us-ascii?Q?hRxNyNTqnXfnXHIikyVU1YYGjyxOhvkqvMAlisSgmguVksUsZnLXZh96rASm?=
 =?us-ascii?Q?tRhBdtGgtWS+TaNmmQZtB+VJdk4d/ydzWyZS6VEhKyA0PJqDvwDKaChR4eya?=
 =?us-ascii?Q?Haw7q2NzCd/oU1Vtwl58hesWgrndGST1jK9ArV8AJE23zqQw3owmMVzifjCw?=
 =?us-ascii?Q?15pdt+Yuq9+BqrGlq1+tf+McdsOg4LXFYSXjATq2h8ksA11bLiHYPNkLbzWf?=
 =?us-ascii?Q?XuRggO9NuX6gSFtPRKOPhGv6rDaF2qCIOPl+OUHlxTvujolhKAIZaCC+Op2g?=
 =?us-ascii?Q?2fcOU4Nn2aIdy9k52nV0owc0kw7i4VXYpSczRvtyHWYi79WJL7OxKZVb/ljF?=
 =?us-ascii?Q?EMZFkY8DsLFqDnbMxlIP/yE6wh7zOyoT252M3z+b3PnKmLINM6gRmlkO5dv/?=
 =?us-ascii?Q?75nID+F8BnRYcmvetyZ2DM1wlShft80lcrBhjXWJGWNqleT6ZqCANOj/7uoY?=
 =?us-ascii?Q?Pbbtp0907lux9AKpzAQZ5B8+6kB9DZOuKL+CZWn19n/uC6dn33kReUHYAAkQ?=
 =?us-ascii?Q?lYtzg4wpG8p4Oa2f3UarT7fcl2kwHuXlkUUWQd5dPltR58c2jjNP8SsxB7zI?=
 =?us-ascii?Q?cqfckqdk3jsgoI+lOKlcUcC8DwoDo9ozYacdMehJ1ZlVmEGQpz/9HbfWx/lG?=
 =?us-ascii?Q?iex7I1tt9s99+UE4HZnhkCSz8RMqokqh68vRxIALN1rXRtKNcN/y1kOJZnTH?=
 =?us-ascii?Q?TxCdCMRCEPCJZaPUpcKR6t83TDb6bH7K3nTqgWzyh4bKd2P3e6BfXaFGSCNm?=
 =?us-ascii?Q?udhfFoBaKjEpeCTCenVPm3Ch79Qad1N0LxmVWz4zMRG8mGJGfGF9+IGfsSfV?=
 =?us-ascii?Q?yi/OYfnMRTuiO+UED/+9XVHLp/o+iVlWLPVPGuvSwN4gs6G4pMba0bazvI0g?=
 =?us-ascii?Q?+tRX/LyoFqmxOf8RoSsapgRG6C5D/uWEuzAsprigsp8+MbHskg89kRrPQfF0?=
 =?us-ascii?Q?PLB9wxEklIbIVO/riqLPLbZnMjJwCrP3flBJGZzzbCTLwVYn7xsAraCcZrf3?=
 =?us-ascii?Q?9W3SRytr90defUdd5M+y8F4gYiDabLV6j8jwzUV3NLv+eI2Z9zKgP7kPZ8t8?=
 =?us-ascii?Q?XXW5LQjTY3cEgrOsPKx4NiSIXl67VPccooAFU2a7AdvyllwRfJyV0KL9Z19I?=
 =?us-ascii?Q?08YCCTHYXuG9+vHBEcnyQTo03eQta7U+C1/bWQXhhRa/Hdef1nihBbYW36Wq?=
 =?us-ascii?Q?uuUPCSmQSm94FHHWkjnwkX0z1ndDDnQyPRfGU37q6VYped68MLHScNsb5AX+?=
 =?us-ascii?Q?b3JDVzh9BWVF4Y3PIwWLp54cq7aFPcQ2USa2QJw9HOMXo9SmTbj7opB7SUOH?=
 =?us-ascii?Q?SfuQIXHhoxRSoOcVu7k=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5257.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c5c0b255-c09e-45b3-a4b1-08dd7cc313f2
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Apr 2025 08:45:45.1442 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: CXgMoAF2iNJbYgpHBfynJnSJgJJ/CvYMh/qv8PEoz1iQUW40Cv2u11pU4g78c4B8d/jjGCug2GDRIv1gv18zCg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB9045
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

Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>

Regards,
Hawking
-----Original Message-----
From: Lazar, Lijo <Lijo.Lazar@amd.com>
Sent: Wednesday, April 16, 2025 16:12
To: amd-gfx@lists.freedesktop.org
Cc: Zhang, Hawking <Hawking.Zhang@amd.com>; Deucher, Alexander <Alexander.D=
eucher@amd.com>; Kamal, Asad <Asad.Kamal@amd.com>
Subject: [PATCH v2] drm/amdgpu: Disallow partition query during reset

Reject queries to get current partition modes during reset. Also, don't acc=
ept sysfs interface requests to switch compute partition mode while in rese=
t.

Signed-off-by: Lijo Lazar <lijo.lazar@amd.com>
---
v2: Keep consistent error code, return EPERM

 drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c | 10 ++++++++++  drivers/gpu/drm/a=
md/amdgpu/amdgpu_gmc.c |  4 ++++
 2 files changed, 14 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c b/drivers/gpu/drm/amd/=
amdgpu/amdgpu_gfx.c
index 2c933d436e56..67ebeed77d71 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
@@ -1353,6 +1353,10 @@ static ssize_t amdgpu_gfx_get_current_compute_partit=
ion(struct device *dev,
        struct amdgpu_device *adev =3D drm_to_adev(ddev);
        int mode;

+       /* Only minimal precaution taken to reject requests while in reset.=
*/
+       if (amdgpu_in_reset(adev))
+               return -EPERM;
+
        mode =3D amdgpu_xcp_query_partition_mode(adev->xcp_mgr,
                                               AMDGPU_XCP_FL_NONE);

@@ -1396,8 +1400,14 @@ static ssize_t amdgpu_gfx_set_compute_partition(stru=
ct device *dev,
                return -EINVAL;
        }

+       /* Don't allow a switch while under reset */
+       if (!down_read_trylock(&adev->reset_domain->sem))
+               return -EPERM;
+
        ret =3D amdgpu_xcp_switch_partition_mode(adev->xcp_mgr, mode);

+       up_read(&adev->reset_domain->sem);
+
        if (ret)
                return ret;

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c b/drivers/gpu/drm/amd/=
amdgpu/amdgpu_gmc.c
index ecb74ccf1d90..6b0fbbb91e57 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
@@ -1230,6 +1230,10 @@ static ssize_t current_memory_partition_show(
        struct amdgpu_device *adev =3D drm_to_adev(ddev);
        enum amdgpu_memory_partition mode;

+       /* Only minimal precaution taken to reject requests while in reset =
*/
+       if (amdgpu_in_reset(adev))
+               return -EPERM;
+
        mode =3D adev->gmc.gmc_funcs->query_mem_partition_mode(adev);
        if ((mode >=3D ARRAY_SIZE(nps_desc)) ||
            (BIT(mode) & AMDGPU_ALL_NPS_MASK) !=3D BIT(mode))
--
2.25.1

