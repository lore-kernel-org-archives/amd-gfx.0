Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 49A7AC7EE23
	for <amd-gfx@archiver.kernel.org>; Fri, 19 May 2023 11:17:00 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 31A0610E0AD;
	Fri, 19 May 2023 11:16:59 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2055.outbound.protection.outlook.com [40.107.237.55])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 756B510E0AD
 for <amd-gfx@lists.freedesktop.org>; Fri, 19 May 2023 11:16:57 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XifL3MgK2kQ0d6cneUk5+GUTSXfs7T/n3VNY8B5nYUsoqACzfqvUfVguoxumurbK3V/PpFgAEcwNQSxPerd6vWAUVTvu2KRQ9FialLAYK3/WWW5PPII6HOK4/yybcSh1UqGjVhulv0BMKuWfkg86cDNdxGSYwLOd2B8pYxS7kBO46Cw4aqZx1RDXn3ig7q3jSRlzBwpsOhcflmV2cAe+8Z4xnBA+PQoEeTcx8h1IJLgZXq0q8J4J4dqumwpd83d19P4aBDAXdSryYEbUL2SbyY6o8k6nIaJWwl9VjnLrGW4mF9jpW5ZVH/gnlG30zQwRG98OBC8Xrjk1fATuhOiQvw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MtRGnbEO2ha4Isgs9/QAM2zLrNN1fdL3ejzts7Xh6II=;
 b=OFxGHsRaxOU52L1GFG4ckRA929wwKVJ7aQO8kHetegQn5X7vpCY6g9lNWQ9jJWxjhQnJy71beqasLPGxxILMrhM2quE6T0Pn5CfhgNo2uFzVGL2sZvmU3sohcsnS+romgTUPbtxtU8FCePUrBVHRkOj+vMnba28JWn+zPfLDGGfBD8xVdlQNyboG2zlknRMWno/qrwgbz7MsAOk//S5xf5kTiYFiZron2D9cdXHm6TUS9bV5dE/ZKN4rAYWXku8t1bogHFKwRKwGEk07c6tx1gD27C/yZg4nadIxoKfmRIZ6FEL+lgZD9l+1jUC2eRI1BOv8BE85wuMt4E3tyD0a3w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MtRGnbEO2ha4Isgs9/QAM2zLrNN1fdL3ejzts7Xh6II=;
 b=apGFunXkhNb0PFO+CfU827cVYzTsrHPsCjlrSMFpHRkHmymh4SV/cLPTmuq6S6GQE1yAfE8vk4a4VjLDGMk51vybEanvs7+ZZcZb1+H6Yh+l0iIh254w5IjYamrv8mkqH2E/GDnhymwEfPp/VK11j0n0yne+XZm+HJoUuQsDEcQ=
Received: from DM4PR12MB5181.namprd12.prod.outlook.com (2603:10b6:5:394::22)
 by DS0PR12MB8342.namprd12.prod.outlook.com (2603:10b6:8:f9::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6411.21; Fri, 19 May
 2023 11:16:55 +0000
Received: from DM4PR12MB5181.namprd12.prod.outlook.com
 ([fe80::2eea:1d6d:9e75:8cea]) by DM4PR12MB5181.namprd12.prod.outlook.com
 ([fe80::2eea:1d6d:9e75:8cea%7]) with mapi id 15.20.6411.019; Fri, 19 May 2023
 11:16:54 +0000
From: "Gao, Likun" <Likun.Gao@amd.com>
To: amd-gfx list <amd-gfx@lists.freedesktop.org>
Subject: FW: [PATCH 1/2] drm/amdgpu: fix vga_set_state NULL pointer issue
Thread-Topic: [PATCH 1/2] drm/amdgpu: fix vga_set_state NULL pointer issue
Thread-Index: AQHZikLKBKanJK5R0EK+NtYY0dKpgK9hcfrQ
Date: Fri, 19 May 2023 11:16:54 +0000
Message-ID: <DM4PR12MB5181BF00A429D4C4CB115D30EF7C9@DM4PR12MB5181.namprd12.prod.outlook.com>
References: <20230519111158.1354372-1-likun.gao@amd.com>
In-Reply-To: <20230519111158.1354372-1-likun.gao@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=fb67d2c1-42ca-4866-8dd3-1d6203923721;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=0;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Privileged;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2023-05-19T11:15:07Z;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM4PR12MB5181:EE_|DS0PR12MB8342:EE_
x-ms-office365-filtering-correlation-id: e4e62fa5-f73e-45f3-bd18-08db585a8d57
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: x6qy9JUesXfSZIlA8JYGVnSLG8OYrF8PF4ey8xIQk+Cj8a+/uyXovlV7XrH9ydFRD8BCsuQA4k/aNJ0etZGIF3qC5xERdW8T/pg+LWbdxdh+edvEGZfOrB8XnC3jUFBP8ZWe1FsyMrcykBQwmU6fPZRF2rKvgSHSnPyBah52YOU3GmAJYqpNESE4itF+jTXRuat27Fo68mLWIdJwq+mtTZBD8oZxMIG9au9gQp4scLP0WqS7CwTzAdOtjX7lIWS5WwTIHH6pWumoWWMphyDmvGlus07svXG722sPXwmvuFov1psPWGHtTUwcNrcmrc+ruZwbbECFXTtN661PqrOwJh3h6kKWO4WGNWJGH/2pvusW1p5SJ4T6S2k8YZAXm4/lORtUri2qqGuVWaTJjR7H0GY4V1ICFxGkteoEgQEBr6+4P7JZi7Uqm2vpI9UHFsjlGVjhtrDiC5BpUhDoFc/Iv50D+4BQW4ikRHevf15GEZH/t208EIIDXnf/hosfbGIz4AUIhe4pe3+r5OQulCpakgsZjBzGxGecgmRaS4mCa3t3ebYEI9cyKpywqaIzYN2Ygft0XyPtKxmeP2lYHMH7625nsEYWmrmgbpDDoi8X4WINpUVoU6dyi1oFjimwB25N
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB5181.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(4636009)(376002)(346002)(366004)(396003)(39860400002)(136003)(451199021)(55016003)(66476007)(4326008)(66946007)(6916009)(66446008)(76116006)(8936002)(8676002)(478600001)(5660300002)(52536014)(64756008)(41300700001)(316002)(122000001)(38100700002)(83380400001)(7696005)(71200400001)(186003)(66556008)(26005)(6506007)(9686003)(86362001)(33656002)(2906002)(38070700005);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?ujdpr+TtBZ8aNgGRxWV+lzKMLdVlYNMRR3CIuo839SX5tVWe2UDFA3ae3/b5?=
 =?us-ascii?Q?T4HcOoV7ZhcMfvh+0J7OmbhMrjD5GSB206Pt/e2QPv6QjRokIoqq0WNblqrL?=
 =?us-ascii?Q?Ql3KQKxuVrx5bgL+CPiEXWsbUpb/Iag/8BsbSnDcer2fTU8SJXd7Andqiil2?=
 =?us-ascii?Q?G9aD5Vp40m+GRl4jStQGvCvq7SbT+tJVlb6txCdlBeOgVLLwEm2MXFsQI1t1?=
 =?us-ascii?Q?mqGjfjuY0meJsKMHjmPClR6Qm9wdUnOxqs1iZbljxREGtDqw+GIwpTOCf3vL?=
 =?us-ascii?Q?2mjJXaz0yeybSo2VCDu8iuwEBwjvfFWhfPTok7Sj57V4A6EjDBrbkO74xlma?=
 =?us-ascii?Q?9A3IQ+uo7gbURMyDAGdWkZLME/JHQyJpc1EiFsJddXG9TqFc2fVIbGZAaHS1?=
 =?us-ascii?Q?uLjnOD3IqYPM98aG2ZRVXeUXNkztgrzXpTMSFwdJHJ03Np4d2ISUph+iMU7e?=
 =?us-ascii?Q?VYlaTo+Fc6UfyyTgpJl/wZBUf30wSvQekoQzUUiBrX7UFRtJVAgdxHsTO2Wa?=
 =?us-ascii?Q?IegRs7jQ+s+E32OrzFl43NVFsDYWdqgfWBc5bQzAGFr6+FpIFwQRE32MRhWA?=
 =?us-ascii?Q?cggxc9dr9NjEAGX37WVfXFQuBmOx6SWlQiX6nL48hMPUxYVgyJhggKVGRlN5?=
 =?us-ascii?Q?J/Jv6+RO34QgI17KXSgHRQPFFfA0NWmmeXaFgn5vS9cRv7J+qiHUlK/5IDeb?=
 =?us-ascii?Q?pDFzNhTH7UKvfgZnmBsc7Bmdo5wZyeF6iyKrFqTdtSbs6wVGmfMHWQcfYc6v?=
 =?us-ascii?Q?hUNhsVfOu2xxYflwbLq4vNpiU7v3zxOOVy5QTjyzCeq5bzVB0FpW4p0ZSZez?=
 =?us-ascii?Q?P+E8zImZnr8k/Ixw9QmIQkC0jnZ5ziShZQueomyWRBY1liP6u6Ot+JStxvpq?=
 =?us-ascii?Q?jddE4PcqMO5jpihb+rY5pEOPjqDbvDB/hh1UWERzBHmPAg6dxcuMebkvI6Km?=
 =?us-ascii?Q?bisVRtHsNRW8LONlB9Dsz7TCZ/WIWeEGUAxKAKoZUqGG3G6ts/WDBOvzW3aR?=
 =?us-ascii?Q?gYPInGOxtCnzU0yzFJr3XdJmjBcjEy+VbL0ZtFaezY6toZY6AJ4G+AtDtSkt?=
 =?us-ascii?Q?kipNBCBpqdgNk4kABoG2aYAbRbLvoDVVSNzMBUQ3MRoepTFpAFtwgLI7hcwd?=
 =?us-ascii?Q?BIOuiTjfJ96nXsyCRxQw/9u/q78nL0GbdUFVWei3h4SfoovSxUqohwdvCou8?=
 =?us-ascii?Q?EOrQdpwLiqPphsZfFXdcwYLJF8S6TckwCBeYzFDxPSNATrVYXamkxnuhEebP?=
 =?us-ascii?Q?aCQD+NnjJM9J2OljwdWT0YpunDX6JSaI6g/RR/UtVXrPFdsvUX5Xy6P0pcZK?=
 =?us-ascii?Q?3TZp3+JP38OYzneK1ioSYraZL4EaHVgLEHVbf4Ho/6JgKQzWh+XY7t66yJzS?=
 =?us-ascii?Q?L6yRTa1hH93We1v4wavjOPOgAos+C+X+6qZ+t+eKfTvyNIzQ68fN8JLynfrr?=
 =?us-ascii?Q?NaVdftQjQ7SyYokE9g9DAmyP5IZI57n+CF6dfDmACVbFhVAcQY4BYMakB+44?=
 =?us-ascii?Q?nlxCOrmMuMqUpNBJCyydeoS+6xvz2ghE2EXntDTjxWiVhadMi8DSw6a/HUXB?=
 =?us-ascii?Q?naFc1bpIb98hppKCitA=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5181.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e4e62fa5-f73e-45f3-bd18-08db585a8d57
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 May 2023 11:16:54.4278 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: qZgo4XSDnIoTT6eH88j0KPemKonPJtFGG9gZeARVTTodriRE1gDyU8ALKdRS8cFJ
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8342
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
Cc: "Zhang, Hawking" <Hawking.Zhang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Official Use Only - General]

From: Likun Gao <Likun.Gao@amd.com>

Fix NULL pointer issue for vga_set_state function as not all the ASIC need =
this operation.

Signed-off-by: Likun Gao <Likun.Gao@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu.h | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/amdg=
pu/amdgpu.h
index ce196badf42d..5af954abd5ba 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
@@ -1260,7 +1260,8 @@ int emu_soc_asic_init(struct amdgpu_device *adev);
 /*
  * ASICs macro.
  */
-#define amdgpu_asic_set_vga_state(adev, state) (adev)->asic_funcs->set_vga=
_state((adev), (state))
+#define amdgpu_asic_set_vga_state(adev, state) \
+    ((adev)->asic_funcs->set_vga_state ?
+(adev)->asic_funcs->set_vga_state((adev), (state)) : 0)
 #define amdgpu_asic_reset(adev) (adev)->asic_funcs->reset((adev))  #define=
 amdgpu_asic_reset_method(adev) (adev)->asic_funcs->reset_method((adev))
 #define amdgpu_asic_get_xclk(adev) (adev)->asic_funcs->get_xclk((adev))
--
2.34.1

