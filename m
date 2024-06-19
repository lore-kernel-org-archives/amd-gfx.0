Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0385EC27C53
	for <amd-gfx@archiver.kernel.org>; Wed, 19 Jun 2024 03:44:15 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 71A4510E867;
	Wed, 19 Jun 2024 03:44:15 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="SiZGVeRy";
	dkim-atps=neutral
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2051.outbound.protection.outlook.com [40.107.236.51])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5B25310E944
 for <amd-gfx@lists.freedesktop.org>; Wed, 19 Jun 2024 03:44:14 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=j9EbCMeVDtzfXvhh07ebXjc4VjY8SSsA/GbFGIOrvE7fQ1xedRuHM8YBBlYusj7r7cOt4f/FgPyXvb7d/ofN7sOj+Cr2zzQ/oAEHl8Yw+Ci8jZa0RGTn3REaLQDUwrEAAjFTwN2mwjGYYImCoQJSmBBs5jL/N5Zdm8uK7h/BmSQtoyYttjExMpUUCreex0T4Yzrf01a5sYbw23xvbr8yHcM1QiwhKpY5ixVKMb2cMCQ4RLaYiWBxVcOsuB+ioXXC8fg/8lEtv8bGUhKognxkX5CkC5Fs9h/4Zw5TAszgmubsXVr5bJ6cJXce0j659WV/D0n+B+VM3AGRBf0aPhHLRA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HxJu1Fellmosu4ol7oxIeWzjaoe3A8KCbQz/RtWxRZc=;
 b=EhTKULifUykkCMoE6H6p1wCqlfqWHnyakI1iQkXQt2b1E3z0PHZybCGfdN+UIaAkG98BpJf4KVAYE76WdQ+wyqTwjegspVWv/ktClovxcXrjsMySMOHRcmLjHY4tzAAhOqaUGgKKHUhLRxHCEZ1CgfJoXAT3jZKtWT6Nd6jZC8nx5im0c7lIs0MZUcTCwCWJ3MwmRcz4QJCTZihNXj/z+ScFTlm7jS7bmKUeSZ2OwU+MijJzquq0hw+pSOlN1PPfZ5rwVLRBgc8Nkg0Hy8+kC95LPAAGRDW9/TkiwL6RE9AHc2ylL84tszRZ7QEmul33kDM3/7e/Iq1a8ceF+MHsvw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HxJu1Fellmosu4ol7oxIeWzjaoe3A8KCbQz/RtWxRZc=;
 b=SiZGVeRyxzJLNJ8gzyJe7mI5yo0+HiuGPtwjHonl5O36I3wSIqcx5502uu5w2jsZol6XKsFpQAI3uxEkC5q+0qQDdwVOCiGqKX46gXbT4j0oOLPzuozS9Ehu8hzMkToeuFS7q+ZJkkqYLLr0f5bfYOcvC0NgpLKEB+fS6Pl8OAA=
Received: from DM6PR12MB4153.namprd12.prod.outlook.com (2603:10b6:5:212::22)
 by BL3PR12MB6521.namprd12.prod.outlook.com (2603:10b6:208:3bd::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.31; Wed, 19 Jun
 2024 03:43:59 +0000
Received: from DM6PR12MB4153.namprd12.prod.outlook.com
 ([fe80::b123:924f:dde5:9637]) by DM6PR12MB4153.namprd12.prod.outlook.com
 ([fe80::b123:924f:dde5:9637%4]) with mapi id 15.20.7698.017; Wed, 19 Jun 2024
 03:43:59 +0000
From: "Xu, Feifei" <Feifei.Xu@amd.com>
To: "Zhang, Hawking" <Hawking.Zhang@amd.com>, "Lazar, Lijo"
 <Lijo.Lazar@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
CC: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Kamal, Asad"
 <Asad.Kamal@amd.com>
Subject: RE: [PATCH] drm/amdgpu: Fix pci state save during mode-1 reset
Thread-Topic: [PATCH] drm/amdgpu: Fix pci state save during mode-1 reset
Thread-Index: AQHawVvEiPy/49phy02Xt34i35jVFLHNZCoAgAEO4kA=
Date: Wed, 19 Jun 2024 03:43:58 +0000
Message-ID: <DM6PR12MB4153F653BF24CDC843AE2042FECF2@DM6PR12MB4153.namprd12.prod.outlook.com>
References: <20240618084423.1144125-1-lijo.lazar@amd.com>
 <BN9PR12MB5257BBF75DB519040A60A183FCCE2@BN9PR12MB5257.namprd12.prod.outlook.com>
In-Reply-To: <BN9PR12MB5257BBF75DB519040A60A183FCCE2@BN9PR12MB5257.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ActionId=495d7642-7672-462f-8802-4cfa061af0d6;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=0;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=true;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution Only;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2024-06-18T11:33:44Z;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM6PR12MB4153:EE_|BL3PR12MB6521:EE_
x-ms-office365-filtering-correlation-id: 780df2d0-7e9f-461d-1937-08dc90120d7a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230037|376011|1800799021|366013|38070700015;
x-microsoft-antispam-message-info: =?us-ascii?Q?mlcYCVIZysp5nZS89w+GYVMOKVFqa6kciVwkD0Ds2Rr98g+4VgnOQygP5ShU?=
 =?us-ascii?Q?zRzdAT/EVTPs7ePkU9wP5xwOXj3J6KpLq6yq1bj1Z82V4VN32j0Kc7Nk/f5k?=
 =?us-ascii?Q?wVUMlNLoR+RU+JD3CBdCtVOB4QuQBI8XA12ZC78H+39ChWRLwwjMrFOWAOEo?=
 =?us-ascii?Q?RhcxfUczrrjsmBqPpJkJMIxjLQjspx3SqrBmCThlneuJ9aSKjEc9VGgxlliE?=
 =?us-ascii?Q?umrY9SLZxSqeZbsWqdLu3iuys5k6NG9BGhdRZtHuGNFa+CGx3RkyLVXLEjtE?=
 =?us-ascii?Q?5+jwDkEFJcVRpuZWt8W5Axndj4JiEhUhvAk/PHxAsPjmYsPT+0a8zlgf0uk6?=
 =?us-ascii?Q?ZzMf3Ngd4uHXVZhgZqXhYCfOPycn5LRd+D3FTwOzmaWguGElpcBnJok2xJZa?=
 =?us-ascii?Q?DE2Nk/Fwg3tB0qZwbuz6Ew3t2rv141CW8CFBjapxlfhIequqr+eNzahIjTBr?=
 =?us-ascii?Q?hu/SVgEJcLXL/4AW8iQKKzVSHqRV9Uwu2uAowKat1UxA60lACR6c1tPXDiXd?=
 =?us-ascii?Q?L4mo8YYBA6SkEuaOaY05ZD9g0LsqhCZRfZjV6DolZpta85wHtiD5PdDEe2tZ?=
 =?us-ascii?Q?fhcN2R0XUxJHZxlD89YrEfuUGEP2cuuZjXkXqi5swMAUiVZCCPqsfjy/PER2?=
 =?us-ascii?Q?8sKWuet2ZZ+6vAfgJ6KBkp/30MMrTixinlmDjME9ud1YAA6VMsVtVJ1k+Mxg?=
 =?us-ascii?Q?/NPUlGER0N6x1nUomUYbu2RHOIgOxe3dHyWavbJkbijD2bQIFBZig9IO8P7f?=
 =?us-ascii?Q?WtEH46AD1KTod9xCxlixWevLLaYBzweNQswybhMABGDkHZJt+Pc25giAT+4Q?=
 =?us-ascii?Q?I00UKf/PbHesKSq5Hu5GsckCaTQBzA/KjThnAXSrZYnSvENlqC66sORKZ6IN?=
 =?us-ascii?Q?wKljVDl3Qx3Ze9JsFP6MDlmFZYWCD/p8z60CqIe8bPdhahqagyhtEFkh9o+S?=
 =?us-ascii?Q?hagBUsPHbkpzOkSzliLKXIWZcOpLcgucxviKpXvzdOquz02rZmqU7UofFmLI?=
 =?us-ascii?Q?DJpd+Pszd5nMVorf4pNCrceEEwLafOVY9u/WuNkVBAdcxbQpn1VOsH3Amva1?=
 =?us-ascii?Q?3yRIQhMdSd84G0Grh53Wrxwwi7eLmAkx6DEdup/tvv7WdFn/4aqMqfB0F9nQ?=
 =?us-ascii?Q?66LqGDbGh+/E7Iikz5szrMEZTIz4yte5IJW3DnLik5+1SKU82WJzCPYY9aEm?=
 =?us-ascii?Q?tZSItw75M48bMq1lR1kWNrYNBzZVbpaCzFvaACQSLWg9pInaF0zZFgfycZRV?=
 =?us-ascii?Q?V3ZeOEXYWdxpib94iYakuWrA6WBDWvVvl5ZRx53CK06p+G+stFjhcnYzTTGm?=
 =?us-ascii?Q?W4SkONup8RZqj4YkUwWT904SAJj8wsPYTSTIuu9cnCRKES5n7V9HPyGPJK+0?=
 =?us-ascii?Q?VwT0fHg=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB4153.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230037)(376011)(1800799021)(366013)(38070700015); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?p/G0D+XUvgdC2mU/2r9nC8Z6FEFxIzJvMckmju60ej9evgZo+ot0pHte+Kv4?=
 =?us-ascii?Q?GnuVQhhCR8JqmI5MAjjrRJpLN6XwbLd63ApBvWSpKvoh1tZt474kFQyU83bZ?=
 =?us-ascii?Q?KBQq603czRHqMTe4W5IC4VyymW4jnAHlfOBDEJAXnFvrbvjAly0hZzDzGEP5?=
 =?us-ascii?Q?GAZwsMlyc+TmFVwZKD0MmX6ZohtznEPLl2KoJwtReB8NKedgBYF1r7VWqsU5?=
 =?us-ascii?Q?N6WKr+qdgSk3MBVrNP68tgPrJaLM3AVmmkkogqted259vdT0mX0alqAtawC5?=
 =?us-ascii?Q?Z84rUzLbZHbpCBseGktV9/71UMeAwzFQIzwj17g4UTTE2sAZ3kHHm39fadP4?=
 =?us-ascii?Q?sBIVKTSP1BW5DUJYM/2R0+OhdTru34nZUIeNTOA+Xdau/EmOMcJpWCgWozb5?=
 =?us-ascii?Q?oaI5UixJj7S+NYmelsCJjcz7Cbsj5d1ayHU8PnfEkXpmSldQVj1UYuNXmRCx?=
 =?us-ascii?Q?Pei7Lk+H5TixufAYxQKYfn7fFpq1BT1fN32Tc8vO2VK1ulWCQQoj4xUMTUZe?=
 =?us-ascii?Q?d4y7bbQ69u7YCwszLVlWtjokYdjpNc4B0IrP7l4l5NA78sUIiNuvI0FFZAmR?=
 =?us-ascii?Q?/2+z3RH3QH0+N9dJ0uVxAH0GzCzCBoeHztHJvbpnCrB0TDc+iNAorWRTH7Qi?=
 =?us-ascii?Q?+jf4p0ZdpCV2+yfpn5odI+jLzOboa9hOTFW/sb2lEJlaoYtW99LcEtv/Rr91?=
 =?us-ascii?Q?kSIP7x0KMHsIqpD4A+D0oInwG1ikKs06/+0gCXqeoiKGWjFOIBSeJBqKL9cK?=
 =?us-ascii?Q?Q2V1HJDMx6Ypm5KSXXrEgicm4U33xvwjp27dOZZhR2gsx8O4MJfJfyv6a2i6?=
 =?us-ascii?Q?goQ4xL+JCsgpuhkNOpxWqD9jWvBqHSTyO/jGZcHXj/bzi6R9axHXlwESzjLz?=
 =?us-ascii?Q?ZDT5E5zR+osAMFy+CJ9n+xma4DQzno+iIsmntzFaHq/uY1fSbLbIvOPanhjc?=
 =?us-ascii?Q?4zd4voIvD6IAUW65A0KbSY9EJJBsvKIh7ptywPUbPwtpVb2uPMCF6+NHeFD3?=
 =?us-ascii?Q?TAwqvbx22qXqv6yXZLuePx0om1XROm5z6ydKGR+P6QVoPOZ/blsg/oEmWhOJ?=
 =?us-ascii?Q?DA1CoQlYk2+cgXBCs/WwfJmE+QU7k911gN0CPXAqMLzjwI7u4iCm4s/7azpk?=
 =?us-ascii?Q?7k9wkZEdOTSHuL2iX01LA9DteMN57/DcbmHsub4Y2v++NX4s77WibruruqIn?=
 =?us-ascii?Q?ztX797JloYjmUOnVANPlAtZLhrDXUjkxZr8VtFadAcmAl1s2MAJXwKkQWKR+?=
 =?us-ascii?Q?Yd77IUcAmB8lXwDv160VEMJbL75cAcNS/cI9fBIIypliSa2F4cXdy7lMpnn5?=
 =?us-ascii?Q?UUP3K/NUIblqbwqR+Ge2IJmsh6eCo9cpmT2tnvWQcdePUm/NYxlnm9CZv2pQ?=
 =?us-ascii?Q?4UMT+kHJajZiWRCSvRF9jdkooNyqiAuhg92Jl50VRt8XGo7GCKHjelHoHZij?=
 =?us-ascii?Q?wCx3t4Xgl3wg36PxUrWLJVM5HaNcbMRqiDc5LFSTHOFxrQgCDbYwIsmrjjcR?=
 =?us-ascii?Q?xZk95MpyI11OF9C5dM9Kl5WU+UZzUekDzcwRxx3xnVmmZ5EomnX2+YghZaF9?=
 =?us-ascii?Q?HSgU6nPCuvSYmehs3PA=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4153.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 780df2d0-7e9f-461d-1937-08dc90120d7a
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Jun 2024 03:43:58.9275 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: TmfkoI4WUFQcEIVXaDeN9gPK62w4IIRIys/neYpW9Nvxl3N943RxyCuhyCMK7wDL
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR12MB6521
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

Reviewed-by: Feifei Xu <Feifei.Xu@amd.com>

-----Original Message-----
From: Zhang, Hawking <Hawking.Zhang@amd.com>
Sent: Tuesday, June 18, 2024 7:34 PM
To: Lazar, Lijo <Lijo.Lazar@amd.com>; amd-gfx@lists.freedesktop.org
Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Kamal, Asad <Asad.Kamal=
@amd.com>; Xu, Feifei <Feifei.Xu@amd.com>
Subject: RE: [PATCH] drm/amdgpu: Fix pci state save during mode-1 reset

[AMD Official Use Only - AMD Internal Distribution Only]

Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>

Regards,
Hawking
-----Original Message-----
From: Lazar, Lijo <Lijo.Lazar@amd.com>
Sent: Tuesday, June 18, 2024 16:44
To: amd-gfx@lists.freedesktop.org
Cc: Zhang, Hawking <Hawking.Zhang@amd.com>; Deucher, Alexander <Alexander.D=
eucher@amd.com>; Kamal, Asad <Asad.Kamal@amd.com>; Xu, Feifei <Feifei.Xu@am=
d.com>
Subject: [PATCH] drm/amdgpu: Fix pci state save during mode-1 reset

Cache the PCI state before bus master is disabled. The saved state is later=
 used for other cases like restoring config space after mode-2 reset.

Signed-off-by: Lijo Lazar <lijo.lazar@amd.com>
Fixes: 5c03e5843e6b ("drm/amdgpu:add smu mode1/2 support for aldebaran")
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/a=
md/amdgpu/amdgpu_device.c
index 3fb02f5b91c9..6c2ab14ca102 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -5224,11 +5224,14 @@ int amdgpu_device_mode1_reset(struct amdgpu_device =
*adev)

        dev_info(adev->dev, "GPU mode1 reset\n");

+       /* Cache the state before bus master disable. The saved config spac=
e
+        * values are used in other cases like restore after mode-2 reset.
+        */
+       amdgpu_device_cache_pci_state(adev->pdev);
+
        /* disable BM */
        pci_clear_master(adev->pdev);

-       amdgpu_device_cache_pci_state(adev->pdev);
-
        if (amdgpu_dpm_is_mode1_reset_supported(adev)) {
                dev_info(adev->dev, "GPU smu mode1 reset\n");
                ret =3D amdgpu_dpm_mode1_reset(adev);
--
2.25.1


