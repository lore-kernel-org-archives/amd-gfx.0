Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E0044C25B75
	for <amd-gfx@archiver.kernel.org>; Tue, 14 May 2024 08:17:07 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 64EA210E07F;
	Tue, 14 May 2024 08:17:07 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="D5lS7vnD";
	dkim-atps=neutral
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2043.outbound.protection.outlook.com [40.107.236.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 13F3F10E07F
 for <amd-gfx@lists.freedesktop.org>; Tue, 14 May 2024 08:17:06 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NDL6f7JGslnqUDaMcKdB3MVYhKg6SwQ8yogtJcIYkAkQw5yUQdQoMKOZushzQ4Qu+DbXVO9gnNOCmsybvd80hwI3BjBrhC1+rgwmRm81A8AdIsEzeHCxyDKN19GEvz5uWdpOu+W9Zd/TbX5QM/+J6EFzLETOCxUFjcnVzURBsPDjpG/Awzq8SqXq/52NRuTyxYF6nBr4BfLNVBqkEFWa2kPKQwqTmqJSEV8SR4mFsi8gAv54hCp9TmSE7o7ePqMdj5O1VPOQu1FAlajWUEVQKPwCMp7POc4zMmQApH040120HlTjyz2tln3rO62M7UgF8G/oRbwsLnlFxismfF3ndg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+daytprbpTCOeaWqVf7/znE4DTVHvlfH8cuxT3ddYK4=;
 b=XAthOJ9sIFiYXaM51B6dZyN9W+maUAX6K0rmAp0Y89ieKOXd6bLDbdXbs9zH9AC0HU3Yd/nIMHfDW0+T2NK3uANONQl4mehr81R39FU1m8QCO9o5ex4mOVj+EPVGglOJsIihI1IvP5ntDDysO6mJVhQAjmV0vWLWB1Dqcs6vNzoTFPMgxE7Dhw+4lQmUxs0LJT+xysB4TPtQ+MOb+QY5sGVYIC+Gyq2VE5tUyhTMHs37M1Rl7jUrbMhEKE1QDMko5Ap/NTy6iztmpwSeq5XiG+wcUrlOmdJeb2HUQqiw4IAoWKdfWSTTTII5gSOVRZ/x5W14AzzlprdldrSO27BFRQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+daytprbpTCOeaWqVf7/znE4DTVHvlfH8cuxT3ddYK4=;
 b=D5lS7vnDxo4KA3sFw2aDzrMQnRgnO3p+GRsO7tSlQLoDMR4Lmu6UA2fG/kHAmbTJ1FHafzt74RkccgrDa/asiHeMGJS36+sdH4ViEWhgSTQKI0dTlIZVfmtneNaUXFH7jJxxpHBRHcL/lECl104YoJiLdcqTr/GgMOm8+PKp624=
Received: from BN9PR12MB5257.namprd12.prod.outlook.com (2603:10b6:408:11e::16)
 by CH3PR12MB9454.namprd12.prod.outlook.com (2603:10b6:610:1c7::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.55; Tue, 14 May
 2024 08:17:03 +0000
Received: from BN9PR12MB5257.namprd12.prod.outlook.com
 ([fe80::c593:f43d:c798:e009]) by BN9PR12MB5257.namprd12.prod.outlook.com
 ([fe80::c593:f43d:c798:e009%3]) with mapi id 15.20.7544.052; Tue, 14 May 2024
 08:16:57 +0000
From: "Zhang, Hawking" <Hawking.Zhang@amd.com>
To: "Wang, Yang(Kevin)" <KevinYang.Wang@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
CC: "Zhou1, Tao" <Tao.Zhou1@amd.com>
Subject: RE: [PATCH] drm/amdgpu: add debug flag to enable RAS ACA driver.
Thread-Topic: [PATCH] drm/amdgpu: add debug flag to enable RAS ACA driver.
Thread-Index: AQHapdbP/swvAo6bMUqmbbixGcYbKbGWYl8Q
Date: Tue, 14 May 2024 08:16:57 +0000
Message-ID: <BN9PR12MB525752F5D6BF8259172F0228FCE32@BN9PR12MB5257.namprd12.prod.outlook.com>
References: <20240514081444.4095904-1-kevinyang.wang@amd.com>
In-Reply-To: <20240514081444.4095904-1-kevinyang.wang@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ActionId=b0f9246e-65ad-491d-ae27-389cca13112d;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=0;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=true;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution Only;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2024-05-14T08:16:31Z;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR12MB5257:EE_|CH3PR12MB9454:EE_
x-ms-office365-filtering-correlation-id: b42039ad-175b-4c9a-3e44-08dc73ee38f0
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230031|366007|1800799015|376005|38070700009;
x-microsoft-antispam-message-info: =?us-ascii?Q?YbPQf1CBGCgVyB8xLMo0+jADUeXruUr0yJwiQ5TmQaCcA2162yDdjmAQ1BXY?=
 =?us-ascii?Q?6VfU49tzPPrn1qdO6HQTKbNVTR2NMnF9ujJx/qRbD/ymopKRby+UAwxzlalj?=
 =?us-ascii?Q?CeyxTBZvlkZfOr9YLTaU80isdKIJZf0WYeNxh4AMlhwprAlA80yna/qQ8V+M?=
 =?us-ascii?Q?SocZXVvp2T027eTen+lMxhXA1CxSZrhD2mIupmzOd2xyfSiSZT7vcUjjjyoV?=
 =?us-ascii?Q?+vG0hmVIMehjTsHNlEK6ZMJxa8LedQzF7kZB6XTcHiPh5PtIDgqjgzKwB9kK?=
 =?us-ascii?Q?UNNrnpFLz39KsMljJiPC3ZeEpbQeQNlSCoWD28dAg+FmUKIPXbN+oJJCIOeR?=
 =?us-ascii?Q?/9eC710/m50oAZWC6VoUhwD8/gKbJHTw3E5PmLaPLh36tsnsoWbWsVnU5XXj?=
 =?us-ascii?Q?ADyDSq53qjiborxFcXN42Su+XVHfA+W2FGtThBE+uuoRWVaWDFYsDScj6liD?=
 =?us-ascii?Q?sQrMgFOUvPHkXFMaQD76UP/vJRrH7pHKvLtveEG1KpYqCSjagedEqTN3JLiJ?=
 =?us-ascii?Q?2P7T/lHMYnpttAvnwA5JD8eR8pTQJ3RVFQwtbEhUrX7IXC5F1G35+CUaDlQP?=
 =?us-ascii?Q?zPPJYELUaBWrHmLs4W44tAiwBEj3mVa2fzHJQceg+M7cu3H03XI2p62H7izO?=
 =?us-ascii?Q?uNupuY7myBhiGV4YdXy7y9wLx33tPA0maQ5AzDxaVQji/BbSNR7oQ6ldvais?=
 =?us-ascii?Q?JoO0tvNoaksCr/GszlbSoZy6XyY22m/ZwjqwSNYbrmjTIlccpyPKBMnyApSn?=
 =?us-ascii?Q?0KD7Z/CYt7Cep4vkRZMG19DLBi2ThdPM2MkBYXGit0JpC+pVC3N0TsF/bLCy?=
 =?us-ascii?Q?6LmbQpc3pn+qpzMvMO0NyN0/KAgzUqPzJL98T4WsgVEID/pqn7D8hMTZmpwQ?=
 =?us-ascii?Q?MLB+vxMX5PozmSm5Tv6N7T6WtOzeQJ3+CfGV5VUYF8tmpxMC7dOv9bXjvYwh?=
 =?us-ascii?Q?arE0cebBM3Xij0UzOA+5lZlaTU0gyavh2hPHuLXjKDkq5VxzuMzEX+sG0XFi?=
 =?us-ascii?Q?gY1Xe/lI26W9o2wrgktqhp3n+i7oyX7c3J/ygPqA0ForTaMHUB8lIFnTycOc?=
 =?us-ascii?Q?SdxJw8sXtvDqdJt6vrCwx93MR0hUdRLP0LX+ctpWeKCWBKr6AOZKfQatYzG0?=
 =?us-ascii?Q?rfBaCc2fMD72rTTb++Z32VcNHQmdF4TmIU5MsruhNHjbuhu9C3alST+NSz70?=
 =?us-ascii?Q?r5uaeEfz8LbkSDMceoOD1ZeqhVkNywaPmLnxEG85MiWfg77NDib1RgJeSJzh?=
 =?us-ascii?Q?/77uU39LrEHNp6THl5O1UgG/s7vUBNrhi6eAlIYInhiFi05tuRsHLd6X+VJw?=
 =?us-ascii?Q?YAjBcwp+2BkMoldf4RTlhws2z7wbiuHIbsmyK/I7wucRyQ=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5257.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(366007)(1800799015)(376005)(38070700009); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?UnhwQOZSJ/cDwL48zrJzT65vaVHKrPwHlHULJAp+fr1rGhDjgUTNVTN6nlVP?=
 =?us-ascii?Q?QUKZgoRwgwUN0/wETzM9HXUvHn03atzrcY9tOk2g07a1lfy8h7ajKWmDpjxi?=
 =?us-ascii?Q?9XoKBRKGxT0xsrIAiU/YzdxdUYKp/18y+M24LiARvc3CTejkRnuZeEVbKf2b?=
 =?us-ascii?Q?lSYJs6juJzdhQraXfQzBOyr2R+MUkirCeQO+Ni713IX746yOm/aN5d+xRnDi?=
 =?us-ascii?Q?UAS88NIYO1DDGPA9Iz5vnXUfVgogG29pAdnjYOxVzmFZtqs+D5r6J9mSS33g?=
 =?us-ascii?Q?s/4YUAXdK/73pIDwFDIZpnOBPYjTeS/wPjUY5wpUylohzYz9JN8XjndvRITr?=
 =?us-ascii?Q?DMnulZ7sGMoIrClZ4yTez35J++eoZLb+VYtpnYNNjQXQHoCa1Q3vseqn1PI1?=
 =?us-ascii?Q?WehusF3h0FoqS4/DLXjrspIOHDzyt7n1eZxhwdiA0oldSQD7OWQTBhREKa4b?=
 =?us-ascii?Q?qGelsIoRi/VKKonX1mgWZgIf0ssXKDbtlGUPq/whB4sNncT6/kcoseWJuEen?=
 =?us-ascii?Q?88FjUf0yHvpigfCnKB2z0WuPYY5OdDbbPDW6JvaDVpIhuIhd5FGw5jXFkPpq?=
 =?us-ascii?Q?TyPFrFSowesa+yvIKg+ekVtz+DotMDeawQqXjz01Of9hPkBt9Mhjkpnz3QX6?=
 =?us-ascii?Q?nbirTuwT7xOEdEPSXDpQz72Zvl7N4AZyTXmEMN9oT5IBzRzOunEoYkT4W23X?=
 =?us-ascii?Q?N6RcJ+yLr/w0yxKwcjG1i8il5+SGkKApCIB5woiRincihVksnKwbull0itBF?=
 =?us-ascii?Q?4UqH3KED3R3D2GQdpxgLCtSmmcWGQI21F/15TIjMQwhECAlC9QPJJ5SqlYu+?=
 =?us-ascii?Q?HcCFcSU4gVLjm3+MuAI/TG6NvSRr+Q4HQtimcks2RvPnx3pau3N2zd0DBT5I?=
 =?us-ascii?Q?Fnu7kDwsS++T1Hull2R1g3XV59PZDAqjvbOsQUktbqejCqYqiNZNZGWv4H2H?=
 =?us-ascii?Q?ApQmyLPXgbrlOInLCnA4aNQW0b/KtoZH0fDwhBrOfjzmNwlgwgHa6/IHpmYS?=
 =?us-ascii?Q?QYlROV3xy+AaYK0u1l84tdeY7DugBYxjdK+bYuHmRJnZ23AoZYPcYbE+Jruj?=
 =?us-ascii?Q?D8rjDzGKB3m1yXALL4X5jPERju2Y8Ir/gU7YWm84U4bb+V+Uzak6o+2EaH1S?=
 =?us-ascii?Q?Xwdmi3U6BAs5RP+5vMfo4fpipzG745UqEWfJrdPSDKxQLJXD/jv1bHLnMgoq?=
 =?us-ascii?Q?m2kTs4L2TWEQlOcFkX8fQze3pl+uqm86RRUp65R5nlyEYQMf0pLl8wZd/eoU?=
 =?us-ascii?Q?Dsh2NNKFubCbDEH4Lymsk1n8tP2f42W14vROuOp1+p5g9efbNnIQfrP9Ktls?=
 =?us-ascii?Q?otGbKfsqm8ix48K1kDh7m88f7O/qjCnOMUkOO22mq5KJIVWEo/gbiVIeAM97?=
 =?us-ascii?Q?LrMpkF8Yzch13+MjaYYgXXdb3eNx64ClwuxPFk0L20SwXNrQN5FF6koE7YGZ?=
 =?us-ascii?Q?B0zGMnAYer20qhKfMMUmcxyFSlbOfAQwk7MK04EHwOJvxpH7Jn8rVNJ1WSay?=
 =?us-ascii?Q?Arx+I2oQkJR4cfZTpkKjqZyBFVqDb9/UKMJuJvAHrq0ZqO3tK7nPa7NSFdSy?=
 =?us-ascii?Q?lxwL63IQHnJXwiRCAoU=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5257.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b42039ad-175b-4c9a-3e44-08dc73ee38f0
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 May 2024 08:16:57.3884 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: rmyBF1oRDlkjaa/zrGHXDCTVH/hnZNDG3bSlxX721oJHGisSKgte2GbPFIHVWSV/ejmMMbF82VUDha/C4XN4/A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB9454
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
From: Wang, Yang(Kevin) <KevinYang.Wang@amd.com>
Sent: Tuesday, May 14, 2024 16:15
To: amd-gfx@lists.freedesktop.org
Cc: Zhang, Hawking <Hawking.Zhang@amd.com>; Zhou1, Tao <Tao.Zhou1@amd.com>
Subject: [PATCH] drm/amdgpu: add debug flag to enable RAS ACA driver.

Use debug_mask=3D0x10 (BIT.4) param to help enable RAS ACA driver.
(RAS ACA is disabled by default.)

Signed-off-by: Yang Wang <kevinyang.wang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu.h     | 1 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_aca.c | 3 ++-  drivers/gpu/drm/amd/amdgp=
u/amdgpu_drv.c | 6 ++++++
 3 files changed, 9 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/amdg=
pu/amdgpu.h
index 846c3550fbda..550a42e3961f 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
@@ -1171,6 +1171,7 @@ struct amdgpu_device {
        bool                            debug_largebar;
        bool                            debug_disable_soft_recovery;
        bool                            debug_use_vram_fw_buf;
+       bool                            debug_enable_ras_aca;
 };

 static inline uint32_t amdgpu_ip_version(const struct amdgpu_device *adev,=
 diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_aca.c b/drivers/gpu/drm/amd=
/amdgpu/amdgpu_aca.c
index 987a1b4d4503..0b1b9911bd99 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_aca.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_aca.c
@@ -686,7 +686,8 @@ static void aca_manager_fini(struct aca_handle_manager =
*mgr)

 bool amdgpu_aca_is_enabled(struct amdgpu_device *adev)  {
-       return adev->aca.is_enabled;
+       return (adev->aca.is_enabled ||
+               adev->debug_enable_ras_aca);
 }

 int amdgpu_aca_init(struct amdgpu_device *adev) diff --git a/drivers/gpu/d=
rm/amd/amdgpu/amdgpu_drv.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
index caf89d21b61c..a2de55ab3a6a 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
@@ -129,6 +129,7 @@ enum AMDGPU_DEBUG_MASK {
        AMDGPU_DEBUG_LARGEBAR =3D BIT(1),
        AMDGPU_DEBUG_DISABLE_GPU_SOFT_RECOVERY =3D BIT(2),
        AMDGPU_DEBUG_USE_VRAM_FW_BUF =3D BIT(3),
+       AMDGPU_DEBUG_ENABLE_RAS_ACA =3D BIT(4),
 };

 unsigned int amdgpu_vram_limit =3D UINT_MAX; @@ -2192,6 +2193,11 @@ static=
 void amdgpu_init_debug_options(struct amdgpu_device *adev)
                pr_info("debug: place fw in vram for frontdoor loading\n");
                adev->debug_use_vram_fw_buf =3D true;
        }
+
+       if (amdgpu_debug_mask & AMDGPU_DEBUG_ENABLE_RAS_ACA) {
+               pr_info("debug: enable RAS ACA driver\n");
+               adev->debug_enable_ras_aca =3D true;
+       }
 }

 static unsigned long amdgpu_fix_asic_type(struct pci_dev *pdev, unsigned l=
ong flags)
--
2.34.1

