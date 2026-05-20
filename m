Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 56D78CD4F54
	for <amd-gfx@archiver.kernel.org>; Wed, 20 May 2026 06:52:23 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E86DA10E5F4;
	Wed, 20 May 2026 06:52:22 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="FHFqzv/c";
	dkim-atps=neutral
Received: from BN8PR05CU002.outbound.protection.outlook.com
 (mail-eastus2azon11011025.outbound.protection.outlook.com [52.101.57.25])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CECB210E5F4
 for <amd-gfx@lists.freedesktop.org>; Wed, 20 May 2026 06:52:21 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bfoYkMHyeXoBwyoNlWeo0ioxYGrBZpF7diMY+1GXMTL6+AFbApLSyKoxxd6allCgUfZLtZLyx4JGVWEIpoT1NtdAXfegtn+sDyMKbNYycOZovqwrk0hMX3mRZ7khg7P7oqLn9yPnTrIFsLfbvChBAxbR8dZxOSrohuF8XDjtx5Wr5H3a6YneNx0boiX6ougQrrOXKkWs1JeneOqhFcmLmKkMc/AktZ/XiV2PlYavf3z8x99YUcDerrTjHUV8dqFswaJhKwPOH5TtTxgHMApcJAnu+s+ZNmqgJGi2I1ByAXgTtttXqdHnNY8l+Q53Y/yyiT1BTNLseLis2zbQ6vrF9w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gn2OIpn1kisjpSoSiEWAMXRSlYSJzSnIwekFOyZso/U=;
 b=hh2/WGapdamyH0hWzAgpJimxAVdUED97QSYjNZz4jYgH6uWfyx80OXqDGbeoZ3dqRTm32i7Wq91FAQrR8r3VpdccoCi+O/ZwM+mF9KXQGiUgwg9kAMi2d1R/IrXpuVgqgMuKozNCVGoQMqDxe9W7xNUlfeJlx/Iim8wt2KePnziTkiq1kpsXVjPWHOcAlZz5z8GrMiPy2lDDfYj9bWDG+FDSXvkU/opzlMAajCGG8w04XBYBOj1yOrA7Y4fRExoE/QDUPkOKGOw7UAnNscAwCbdGbZDP7BqG3+xoGmkK27AVQ2CJOxu/4hJGhvQVrEQ1QQZDd9rZ0zRtBJ5+hjw9FQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gn2OIpn1kisjpSoSiEWAMXRSlYSJzSnIwekFOyZso/U=;
 b=FHFqzv/csSnry3+bofPx5E3F2VVKN8NGEOqT+/34u9nyVCZfiNI6jNuHnt3HH0dLbRwcjQfthj+Fo/iK0CQZWlsfqtN3rT7awqECotet651B+ahnbh6C8GA4Nh9d5zslMLYH3MnpBF3xES2Mopy8hKlnEk0xilgJg0d39A3wQWg=
Received: from BN9PR12MB5257.namprd12.prod.outlook.com (2603:10b6:408:11e::16)
 by SJ2PR12MB7847.namprd12.prod.outlook.com (2603:10b6:a03:4d2::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.25.27; Wed, 20 May
 2026 06:52:16 +0000
Received: from BN9PR12MB5257.namprd12.prod.outlook.com
 ([fe80::1aeb:47e6:faf1:5f13]) by BN9PR12MB5257.namprd12.prod.outlook.com
 ([fe80::1aeb:47e6:faf1:5f13%5]) with mapi id 15.21.0048.016; Wed, 20 May 2026
 06:52:15 +0000
From: "Zhang, Hawking" <Hawking.Zhang@amd.com>
To: "Chai, Thomas" <YiPeng.Chai@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
CC: "Zhou1, Tao" <Tao.Zhou1@amd.com>
Subject: RE: [PATCH] drm/amdgpu: Add parameter NULL pointer check
Thread-Topic: [PATCH] drm/amdgpu: Add parameter NULL pointer check
Thread-Index: AQHc6BtzMJsz6q41MESSaYTZ93xYlbYWehAA
Date: Wed, 20 May 2026 06:52:15 +0000
Message-ID: <BN9PR12MB5257B86CBF3E9DFE34BDAA60FC012@BN9PR12MB5257.namprd12.prod.outlook.com>
References: <20260520054151.268430-1-YiPeng.Chai@amd.com>
In-Reply-To: <20260520054151.268430-1-YiPeng.Chai@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Enabled=True;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SetDate=2026-05-20T06:51:52.0000000Z;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Name=AMD General
 v26; MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_ContentBits=3;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Method=Standard
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR12MB5257:EE_|SJ2PR12MB7847:EE_
x-ms-office365-filtering-correlation-id: 177dc808-731b-4ba4-ba72-08deb63c53fb
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|366016|376014|22082099003|18002099003|56012099003|38070700021|11063799006;
x-microsoft-antispam-message-info: IxsTQJ+uL8nQvxbqpsuQj51ph/U5UNBIebxRvhCoR55mTuSh7SrdJRBmPYOCP9QLEuCg4t9xktUV2Rb9TsqgBXKn3fmVx8SB7CHjbQg0d4Ir8IZK6uHRynj73Agz7qo7oIoKhpXNK4j8bVMXqGSFQvVvDil1yytJ1pLqT/Tx7oqqPWV1gdIVkVxsk6x4CJ75gyyfTOkbZoHUU37LXgQEiq54wATAtX5W1FTa7xBPQVDMbkDO6ECnO4/TlGOwQj2M/nId/NaI/wrJfAxChTuggKhx89W76LHWFtmN/wAaVXuIUAcd3ic7EF2dWwCTBSRbqmmUn7HeCrd7yHYhy1K16lSLoXnqzvpkYL6nCzuzBhinwmHOv5MXoR3CkGc486qxYaHMDPkgiPaUq0/A806ASmYcUO+J1Z4sUge1WgIV3vDBh7ZlWs2eLNouw6ZgqDljps5NqFSZWGYWEPd6hS/r82Hp3/zMKgLvmxcgdcjwd9FoaSspZNxTLwrS6mzhUpniYU499TsrBAiOburML36LaXgweQyuePT2WowZVo0CGlTAY6/nrNObonrDG7/3GV0K/LuC3smFFCNo0fl5ytbhg9X4EFM5lIuJVURMPS3jTMGxIswajcSKrJWIbJuS8zq6j1Yd1Mr4uH05woL9JdbmGwC5ESFjBuTxLV0gacgppQ/f24x1K2Wc7b4NFIxectcl8dQcbeCLQR/QOJj7whvSiuUQYIbjPCkkhQ390BFegZXjca7hQhd2ZqxqljlAeBiS
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5257.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(22082099003)(18002099003)(56012099003)(38070700021)(11063799006);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?Q1k28YDBoqIFueetvIGWPzrMT/uIYNhzd+sLYnEGwoSeMaN2EQY+9D/u4eYz?=
 =?us-ascii?Q?Tby7dwtVAo7z8X4LSyR1ZcEtIQ3/axbPZa2Zmtj4JNwUmkunombzoo0TljWj?=
 =?us-ascii?Q?hPe/qPNc/I+uR+ngDPQiOJ/EB9KuGswLWszD+LtGMNXfT6phmQAI6aEgbSsQ?=
 =?us-ascii?Q?w1NxNXEkqWGNcHIDrzr95sW+b3Lm5KX6pOv3wkiSx0HNzdL/adC/sEXklxic?=
 =?us-ascii?Q?dg2P6riMx1Jz19FidkkmSjPfFKyCBLWNGScaKgtUykGR8+jlcYbhcpYVLxzI?=
 =?us-ascii?Q?1YNLjLVBoIeWSc0t5ok4aT2H8U18IrZCuE8SEPc6CZndahzU9cqyFyKjMRER?=
 =?us-ascii?Q?/qzS33aX1zEgqidPddFmYxEGoNDTecMUgrd60OuH24bV0z84yoaS9snBoIlp?=
 =?us-ascii?Q?8XvlWD5RpNU3GihJCXVde5p40VR5/kulxIeJc5iDE+fAg6koMqmNqHe1wS2k?=
 =?us-ascii?Q?mHpSOg89/RH0+Bvz6TDjsyrCzUo2fWSjNdg+XpX/49xUMy8aE+5LDV+Khg23?=
 =?us-ascii?Q?JMszSsFo3ywFbr9rCdeyoD2MjRljw5pGEu38GblKGIngLFnZaqXU4mEdsCM5?=
 =?us-ascii?Q?MZJWUz+F12SnN4boEVk40LE+3ms6UkUq83Ti4NI043cfeJCZVFsHnSVlwIGB?=
 =?us-ascii?Q?D9mHnsCR4YDEtqYpavISMrpCDqM65/eGRJ7FPIxl5UqWy6rQjIXlVjF3c9tX?=
 =?us-ascii?Q?8uBV1GURNNn1ETSAUvjDu0KJodlUyeauQDuRjIG7z/5zpCWHn9qooR1TG1kf?=
 =?us-ascii?Q?2H+fcMTegmop36UA1Snmv2SCwuom1f0qvT0GaSS584sAz0HFDxOBabp/mhc6?=
 =?us-ascii?Q?qKBaeNoZPRA4LmUnal7+cVh4hhisSAj7oYaZ+5QlV4XXGgOXEWi46CThGalB?=
 =?us-ascii?Q?m/cHB6pT435PwSeSfEWPlYMZlmYSuYgGNRKIGo/UfgpTSYUJ/xl25siavrqT?=
 =?us-ascii?Q?FGu2I/Sz0zFyiBw8uqGHXCQGld5u+uKVKiLrC3esd19FagKNDbYTmQraaDdO?=
 =?us-ascii?Q?LhLOcbY2/eoTv+5aH8zUAEVBy0lqMhIEE4WdH08JUScDx59YrgBk2YKe/15n?=
 =?us-ascii?Q?nJMBIc1vJ4sL7yQwcfcT/KpU3GGZpftZBzMG/PMkyX8aXsWav0xVyhbY+xtT?=
 =?us-ascii?Q?hDt8CBvRnjo6qEwUjdc48FAsm1Wt5BhonlAUoGe2CPkAJnH1JGNrqJ8+mZX6?=
 =?us-ascii?Q?Uk2sbNXJhHYA5flVmt3GyU43cYCHRFsDDJUZ8BjsFrEnokF0px8JosJ4kjJo?=
 =?us-ascii?Q?m/0hwVyyd/rypX9fHzj5JKkxKelw1qhoEDc7ds4XawvFCR3lHj6PGTpOJ89T?=
 =?us-ascii?Q?ig05icqUSGXfoIU4WbosH2N5tp7iDRdbvpKpN8G9Ioo8CAiK8t870Njj4Gts?=
 =?us-ascii?Q?rumTXNegDDQkoJJUU4hHypuOb2Ht5WXIiI5YXD/vN6qovJPsvptdCFItuzIt?=
 =?us-ascii?Q?rrrDsC/JX/TWReCPlnROEjXvgH5Uy9+iDa0W1T9IMn8kKjJxUJK+mpnLMuEF?=
 =?us-ascii?Q?JxQ7YpdiIomgoE5U7mHPi2uaXoKXzx64+7OyxWurgQU8vBcDEnbEieUBqH45?=
 =?us-ascii?Q?uaw9iTGk2FIFZ/NVW6N/I7gEodsX92f5N7tIK+cxHai9EOzXJhJg/okb11AQ?=
 =?us-ascii?Q?tuRE5rXfRxy8/j4Y8URFIorD5xbfonFFCSuK3U2sOuzs5yBptUR+wq+iWAUp?=
 =?us-ascii?Q?10FcWayXhn0Dd8W6EZiXe81iDpBfdpk8n6pLt0wV3vbbRd+V?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5257.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 177dc808-731b-4ba4-ba72-08deb63c53fb
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 May 2026 06:52:15.5791 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: qoEOOZTEuc36QvV97EG1jSqRn7+MwFEljs4nN8CHckCKfZRx7hQZ9uv+DumsstP53EW1IwZnLOktpJ5x78whlg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB7847
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
From: Chai, Thomas <YiPeng.Chai@amd.com>
Sent: Wednesday, May 20, 2026 1:42 PM
To: amd-gfx@lists.freedesktop.org
Cc: Chai, Thomas <YiPeng.Chai@amd.com>; Zhang, Hawking <Hawking.Zhang@amd.c=
om>; Zhou1, Tao <Tao.Zhou1@amd.com>; Chai, Thomas <YiPeng.Chai@amd.com>
Subject: [PATCH] drm/amdgpu: Add parameter NULL pointer check

Add parameter NULL pointer check.

Signed-off-by: YiPeng Chai <YiPeng.Chai@amd.com>
---
 drivers/gpu/drm/amd/amdxcp/amdgpu_xcp_drv.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdxcp/amdgpu_xcp_drv.c b/drivers/gpu/drm/=
amd/amdxcp/amdgpu_xcp_drv.c
index 44009aa8216e..7c100630f096 100644
--- a/drivers/gpu/drm/amd/amdxcp/amdgpu_xcp_drv.c
+++ b/drivers/gpu/drm/amd/amdxcp/amdgpu_xcp_drv.c
@@ -55,6 +55,9 @@ int amdgpu_xcp_drm_dev_alloc(struct drm_device **ddev)
        char dev_name[20];
        int ret, i;

+       if (!ddev)
+               return -EINVAL;
+
        guard(mutex)(&xcp_mutex);

        if (pdev_num >=3D MAX_XCP_PLATFORM_DEVICE)
--
2.43.0

