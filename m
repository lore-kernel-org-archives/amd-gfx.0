Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 37BBDCAC5AA
	for <amd-gfx@archiver.kernel.org>; Thu, 25 Sep 2025 04:33:45 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D3FC810E839;
	Thu, 25 Sep 2025 04:33:43 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="DnZs3a2y";
	dkim-atps=neutral
Received: from CH1PR05CU001.outbound.protection.outlook.com
 (mail-northcentralusazon11010046.outbound.protection.outlook.com
 [52.101.193.46])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 349B010E839
 for <amd-gfx@lists.freedesktop.org>; Thu, 25 Sep 2025 04:33:29 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=u0ZR3iGMjzqYuU/MowvEisRM4kOragyRlALiWFN2wsvh9dvIwKuug4PtPhVoL+0JbYwZEKNEVTf4CWp5sm0Zpd1DP9pjcQfXeeul1s4vXJ7rt/foS7rAvvHWX3rpQE8zLcBRrgTObOmwhYyZIzCwgL4J/JwH92JDuUanzIYBhvdKzlF0vSeDqmVikGEVKARGRAsuz19PxltVvOwmfs4NDSaRgcMiQWXXV+uYDRbOzupB7HkpYNQvUjQD2SFFB4JHSPrgqNUFByrHKWTzAhkf2zSh+g39Ks8ZjieEZZD+qFE6haYgSmOzO6U9ynltbQT6s2eBodTRo1O4WXfUa5UA6w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MAU6idLljxIxDv/RqXCE3iN/W1OEQazgzhlE/2I0YiY=;
 b=ArBdr5X4smsIoYED+zY064ErztXEyhbzhFvUUcnUjrCcj9KqFWUxQ6NAsc4goaT/mxT2bKeJ70e9z/2gIkXFgasqZjt/t7HwwCrQ0+IYxfgcdcLMqwU/2x83vL8tsUqEyAK1u8kQZe3YINsWkNS8/N6PznxKh9bZsqeGxCo+Qc18IhRkq04B2/Py7gafx+YrGeFWTet0zseWr03wQVR1CoNY7P9Pu+We0P1ytbNqIKdaMKSqdFek38SigbEulpjI+5hYpvpiS4WhB8qkI543PQZ+iA+YgNqNYHpWSgtyRlvG0dBDMvI2PsGiYBrbn3LyR+IlbTzid0BMeo7bt+GXnQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MAU6idLljxIxDv/RqXCE3iN/W1OEQazgzhlE/2I0YiY=;
 b=DnZs3a2ygaWKmN6jG5Ur3OImSkwv3Dls681qD65FKiKi5+dXlEh8NkDU3FxafPYJgLxvos8/7q7f1+kBryIgK754i5DKMIZHHU3KcLWkiw1uWnLaEL8rCIbSwvXX2pObwenPi8gh4HzyN5JUX13AndnS3iJ/Klq0VS6w0YoXi2I=
Received: from CY8PR12MB7657.namprd12.prod.outlook.com (2603:10b6:930:9d::14)
 by BN7PPFEE0F400A9.namprd12.prod.outlook.com
 (2603:10b6:40f:fc02::6e9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9160.9; Thu, 25 Sep
 2025 04:33:23 +0000
Received: from CY8PR12MB7657.namprd12.prod.outlook.com
 ([fe80::dc50:9698:ac9a:b44b]) by CY8PR12MB7657.namprd12.prod.outlook.com
 ([fe80::dc50:9698:ac9a:b44b%5]) with mapi id 15.20.9160.008; Thu, 25 Sep 2025
 04:33:22 +0000
From: "Gande, Shravan kumar" <Shravankumar.Gande@amd.com>
To: "Pan, Ellen" <Yunru.Pan@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
CC: "Luo, Zhigang" <Zhigang.Luo@amd.com>
Subject: RE: [PATCH] drm/amdgpu: Introduce dynamic pf-vf critical region
 handling in SRIOV
Thread-Topic: [PATCH] drm/amdgpu: Introduce dynamic pf-vf critical region
 handling in SRIOV
Thread-Index: AQHcBy6TuXU/N6xXYEWLpryZrfRfUbSjnE6g
Date: Thu, 25 Sep 2025 04:33:22 +0000
Message-ID: <CY8PR12MB7657CC6EB28498FDFC2869DA8B1FA@CY8PR12MB7657.namprd12.prod.outlook.com>
References: <20250807000156.196220-1-yunru.pan@amd.com>
In-Reply-To: <20250807000156.196220-1-yunru.pan@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=True;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2025-09-25T04:32:00.0000000Z;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution
 Only; MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=3;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CY8PR12MB7657:EE_|BN7PPFEE0F400A9:EE_
x-ms-office365-filtering-correlation-id: 0da62f97-4bb7-4475-b20c-08ddfbeca94a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|1800799024|366016|38070700021|7053199007; 
x-microsoft-antispam-message-info: =?us-ascii?Q?e2rzXY2Uq+kHmT5XQNPq582wVTISoTyU9OvcS5xF+z/EJKliOxEmStWrb/gu?=
 =?us-ascii?Q?dqQY5KqIzCS/VYC4YlBmJaAIy7iWRjo0DGhxg60hbGIhYbxsridv3pV4QqmY?=
 =?us-ascii?Q?6/ALiAtAAzaPvzpR785zrTAu/CcHMijEeFXdENyvYcFu+1l8BKRa/vdZrJZp?=
 =?us-ascii?Q?peq5QbscBBS2e41GGMEXazwuRpP2ChaFEJGXVfiAKBNyA3BGlw6+KrpOWwTi?=
 =?us-ascii?Q?p1J/1bPt422MrbFF6eDszMA5inH7qCbcM6+V+8P/sbxXePn+wZOmg+U+rRbE?=
 =?us-ascii?Q?DequoH5NCuiNMAaESowVTMFHeRGuX4yAWIf5gtqJqi8+SQ55vCRm9WjFdDni?=
 =?us-ascii?Q?0if05Y/xGvHrY3LGqtqu7UCwV3kpgoFrqk5ApQfuRDos9u69UNOz6csKBpjS?=
 =?us-ascii?Q?m0ghqGNlZUWhMtGi1WlZSQASoa7MXtdu7KRTcVVYvILuS3TK1j747/4ujiuE?=
 =?us-ascii?Q?P+ov1P/WfFd5QCrEiR8ucagQ9OtbDzz5FhnkfnsBBco6R3vQLh3PcNCUePYI?=
 =?us-ascii?Q?mmi35pWM2iyfYqK/f5h+JvJ33HGm/HiCBT+fCdVhsdUxy5FuwCKn4WhTxmvx?=
 =?us-ascii?Q?bhokA4Nywg4egtqsRjKmrvoztWDlGzc481Uq1I/aF1OyKxrUWrgfDmTAHjXg?=
 =?us-ascii?Q?2cQZCohViWF//GTSTlj7JzFxjMFruVCmZv9qLp/+GwwRBet7oqTOjefe5Op9?=
 =?us-ascii?Q?BOkpEGQeaXoGYQdgQvSHYwTFTSCT2iC8fMp4WEaeK+MKaBcIrLaDHVXTPvHn?=
 =?us-ascii?Q?7Jb9JdcpErEocQnAecJajnjDpfG8a8EeCn+oMj39iWPAd5tWiyjZ4HoNVj8X?=
 =?us-ascii?Q?lrSazn8chtJqyJpgTns86Y1wb47KcjvvtBhpeHx3xwOyF5uBFS1IytY5BJuU?=
 =?us-ascii?Q?4KTXkyJsbONeVDmNOj+5b1ie+2U06DkGKEHNR44KXXkzdP8rb9gvZUAzOouR?=
 =?us-ascii?Q?LIILYS/dwyTq6961JKGa90BZIrX0jRqYOz59g5rF5sNpuUVtP1v73WpiAPK3?=
 =?us-ascii?Q?BMmePAhvRJw3EOHnByWH5yRkg4Uyb4ACvLe7dkMmMKfVdGnKt2Zu7WPcp1d9?=
 =?us-ascii?Q?NsYYmYFoVLrQ4vSem4LWALBKc/PnJ7ZQJrd3JwLepiM9PR86aA+brgRnOpmo?=
 =?us-ascii?Q?RlaiHEKS3aj73Ub8hfDw8JdUZQIve4t71zTSUPgvSYSa/KelPkAaOhnPFmoN?=
 =?us-ascii?Q?TGzybtbtRerZ7HULOAgGyNyPsRBXvldzbwWtzA9wVPj9Z9FIvGdvI3ML4u8e?=
 =?us-ascii?Q?/xIX5oMXJQnOhWjZxyqgyZpDlY3rPCihht2sljtATrqA7GDA1MEszC51YZDl?=
 =?us-ascii?Q?9lOh+e1bCDOEG4UgrAaPq1JeKpN7nt3ZHB908nB0fzSU/y7Sa0Arqt0IvLMQ?=
 =?us-ascii?Q?W9AfA8oP7x/cCUHSuMmwiYvSooi9g07+DileQ7y0Zwn/QD9tVr/A6qaiNxoM?=
 =?us-ascii?Q?NH+OjzXUlpWYh6Dx58Fn5i1qvsLMTZxIMEHSn4TxDvYlNwZVchjsZFqY3hS/?=
 =?us-ascii?Q?C58OE5KZdq/kMrQ=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CY8PR12MB7657.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(38070700021)(7053199007); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?n/OnVGOt3lOBItAf+NYXJNJeInPhnmg3ipmQlIZY5+fI4uIAF77K6omIRkHC?=
 =?us-ascii?Q?TUQWdXvZpiMw3NE6KeDgQr+WKb1ZeUMWywqVarLogFU+EiKFUI/8yfRC62wT?=
 =?us-ascii?Q?0SONPuHO4cuOqmu8EeM5HLzTX9wW7eyUQUEyLDjptq8/th6H1L0JNzV4+ofe?=
 =?us-ascii?Q?FpPhXAAIqC7y7/3u4/INORLrhAZca2k1HiqXcroSLg7ul6eaZkhm45YAr2uU?=
 =?us-ascii?Q?d2NL1MjmZxC3z7ubd9L9MY9RgviEEqBSXNvU8X6iGWCpI9e7WtImsqHwb2Lh?=
 =?us-ascii?Q?RpRycZteN/ol1AtFuxo+Qh9Mz7llr13bDshyZF3XYSjIu6UeeByRsdmR38nE?=
 =?us-ascii?Q?AJHv6iX+qfo3gxQDRNAqSvReOM6yhruQ2/LLMsrxdP1fbz2la1C6NRnUy+Bt?=
 =?us-ascii?Q?vJbI7jvwSIWYQnDVCBiHjv4vepnYLEVslpf44ktWl3lmzLPTj05mZ3Q8fo1v?=
 =?us-ascii?Q?xHiSCKFeKg3Ayfz0Fn59JanxjmOspGKGzYS376uhi/l66KX2Uhn/rvtaDydV?=
 =?us-ascii?Q?pzEmSUapsOeAxVOg9jxbrDeRKDUBWy9WWzn1nmwsgAD0UtwMkpJE6wMVoabX?=
 =?us-ascii?Q?8/W47/JxRUiPEh2nVXzBBFAvD/YkJudU8Z5okmn9DNaqqjFA66nYRVQHByNM?=
 =?us-ascii?Q?dDuqYcuHYfgRHavl2Ul5JH58NZ5oOskTELBSIQ88+sn5WtrRX6XizIRDJo3+?=
 =?us-ascii?Q?kOjeGKwN3WuZtw5cDGmdJ/A6ftQQzfiuS+ABDPMbYdv/zQVZyVm/DmhkB9sx?=
 =?us-ascii?Q?3gZ/z3V2lvK/LWtRyrbTXyy2rOeZSy6doZkzEXhpNykYz8DElWTR+kqfDNI9?=
 =?us-ascii?Q?y3qcbXw9XFiboajS4Aaff5wQqtVJL62RU7RHrbojzO3uzo87ldzXJA+dDhER?=
 =?us-ascii?Q?Kyiqp0SVajdnX3DH0Cc+sg9QoKW6Tfuwkf270CafNuEC42xzKslfxtVx/54p?=
 =?us-ascii?Q?SY1qn3ZYDEGjSUNITNuP9VYdUHhYu3UYMFwo5EwvIvkzysNQc6yeiuP3EDWi?=
 =?us-ascii?Q?iWdzUSyoTVGQA9CeCMc2489fWjiP0imZvXsRAb/fxsMdDMQICuu955LHSt9S?=
 =?us-ascii?Q?enf0jdrbk4x1WVK07jSUVY896HP/cvmpl6u93XbVio202wSFOMroQcpgZ/Np?=
 =?us-ascii?Q?XmROTmvxPvz7748HgQRxVb5rtPQUFTS48f5CWkQLBy5QclP7V2opr1ryoRTD?=
 =?us-ascii?Q?4idxd+TcbQTWLZd3IS/JIEoRWDvzQLTLmcumj2x9xbtz36ZeIzgalPcec61m?=
 =?us-ascii?Q?F1BQ/UEZIZ5iXHYrvA+OUbcReH5fALyJPWEZ43rZN316HJ+MvABvEBAaCi3h?=
 =?us-ascii?Q?HAYnVz/eLrDbIFsaoY1qY/yMbUlUVL2f9znX2iEypm3wCoYohr/8DSxPGIV1?=
 =?us-ascii?Q?nIr5qJqIwiowxONQWbwCbH+zNLpLlR4+tSEUIUSTqCkFM9GN3iY4JGPnZQJm?=
 =?us-ascii?Q?zd3rHqkDI4tnDjVjqvX4RDm0AXsALaiTB2Vv2tKJYV+lxAXwo8boiIPiQYo2?=
 =?us-ascii?Q?QEHWi9ZjocNVrJ1ywfpmZ7TK7uazKvqXVeC/fAhhXopkbITq0kpGHnMmqJtS?=
 =?us-ascii?Q?muWhgPBXNirUPPj38G0=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY8PR12MB7657.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0da62f97-4bb7-4475-b20c-08ddfbeca94a
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Sep 2025 04:33:22.7523 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: oHuUbtUVgA+PGhoLf6asQ4DxFhm4bKcHWi5M5apWHP2pmJwxNezcw3GziOdOAPgP
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN7PPFEE0F400A9
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

looks good.

Reviewed-by: Shravan Kumar Gande <Shravankumar.Gande@amd.com>

Thanks,
Shravan

-----Original Message-----
From: Pan, Ellen <Yunru.Pan@amd.com>
Sent: Wednesday, August 6, 2025 8:02 PM
To: amd-gfx@lists.freedesktop.org
Cc: Gande, Shravan kumar <Shravankumar.Gande@amd.com>; Luo, Zhigang <Zhigan=
g.Luo@amd.com>; Pan, Ellen <Yunru.Pan@amd.com>
Subject: [PATCH] drm/amdgpu: Introduce dynamic pf-vf critical region handli=
ng in SRIOV

1. Updated previous layout offsets and sizes to _V1.
2. Added v2 layout offset enums for dynamic pf-vf critical region handling.
3. Added crit_region version in VF's msg[2] during REQ_INIT_DATA.
4. Added support to init critical region v2 during device init.
 - After VF sends out supported crit_region version during REQ_INIT_DATA, P=
F would confirm back with provided crit_region_header offset and size.
 - VF uses the offset and size to fetch critical regions' offsets in VRAM a=
nd save to local struct.
5. Added support for critical region handling:
 - Init IP discovery table from dynamic offset from init_data_table.
 - Init VF BIOS.
 - Init DATA exchange region for VFs.
 - Introduced ttm to manage critical region data in a 5MB chunk.

Signed-off-by: Ellen Pan <yunru.pan@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_bios.c      |  12 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c    |   6 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c |   5 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c       |  90 +++--
 drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h       |   6 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c      | 354 +++++++++++++++---
 drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h      |  15 +
 drivers/gpu/drm/amd/amdgpu/amdgv_sriovmsg.h   |  93 ++++-
 drivers/gpu/drm/amd/amdgpu/mxgpu_nv.c         |  23 +-
 9 files changed, 506 insertions(+), 98 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_bios.c b/drivers/gpu/drm/amd=
/amdgpu/amdgpu_bios.c
index 00e96419fcda..2cbb24ede86e 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_bios.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_bios.c
@@ -114,7 +114,17 @@ static bool amdgpu_read_bios_from_vram(struct amdgpu_d=
evice *adev)

        adev->bios =3D NULL;
        vram_base =3D pci_resource_start(adev->pdev, 0);
-       bios =3D ioremap_wc(vram_base, size);
+
+       if (amdgpu_sriov_vf(adev) && adev->virt.init_data_done) {
+               resource_size_t bios_offset;
+
+               if (amdgpu_virt_get_bios_info(adev, &bios_offset, &size))
+                       return false;
+
+               bios =3D ioremap_wc(vram_base + bios_offset, size);
+       } else
+               bios =3D ioremap_wc(vram_base, size);
+
        if (!bios)
                return false;

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/a=
md/amdgpu/amdgpu_device.c
index f7d7e4748197..51157143135a 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -2716,6 +2716,12 @@ static int amdgpu_device_ip_early_init(struct amdgpu=
_device *adev)
                r =3D amdgpu_virt_request_full_gpu(adev, true);
                if (r)
                        return r;
+
+               if (adev->virt.req_init_data_ver =3D=3D GPU_CRIT_REGION_V2)=
 {
+                       r =3D amdgpu_virt_init_critical_region(adev);
+                       if (r)
+                               return r;
+               }
        }

        switch (adev->asic_type) {
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c b/drivers/gpu/dr=
m/amd/amdgpu/amdgpu_discovery.c
index efe0058b48ca..76d5e13aa837 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
@@ -292,6 +292,11 @@ static int amdgpu_discovery_read_binary_from_mem(struc=
t amdgpu_device *adev,
                }
        }

+       if ((adev->virt.req_init_data_ver =3D=3D GPU_CRIT_REGION_V2) && ade=
v->virt.init_data_done) {
+               ret =3D amdgpu_virt_init_ip_discovery(adev, binary);
+               return ret;
+       }
+
        vram_size =3D RREG32(mmRCC_CONFIG_MEMSIZE);
        if (!vram_size || vram_size =3D=3D U32_MAX)
                sz_valid =3D false;
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c b/drivers/gpu/drm/amd/=
amdgpu/amdgpu_ttm.c
index 27ab4e754b2a..6a77d63d224b 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
@@ -1644,6 +1644,20 @@ static void amdgpu_ttm_drv_reserve_vram_fini(struct =
amdgpu_device *adev)
                                                  &adev->mman.drv_vram_usag=
e_va);  }

+/**
+ * amdgpu_ttm_crit_regions_reserve_vram_fini - free crit regions
+reserved vram
+ *
+ * @adev: amdgpu_device pointer
+ *
+ * free crit regions reserved vram if it has been reserved.
+ */
+static void amdgpu_ttm_crit_regions_reserve_vram_fini(struct
+amdgpu_device *adev) {
+       amdgpu_bo_free_kernel(&adev->mman.crit_regions_vram_usage_reserved_=
bo,
+                                                 NULL,
+                                                 &adev->mman.crit_regions_=
vram_usage_va);
+}
+
 /**
  * amdgpu_ttm_fw_reserve_vram_init - create bo vram reservation from fw
  *
@@ -1694,6 +1708,31 @@ static int amdgpu_ttm_drv_reserve_vram_init(struct a=
mdgpu_device *adev)
                                          &adev->mman.drv_vram_usage_va);
 }

+/**
+ * amdgpu_ttm_crit_regions_reserve_vram_init - create bo vram
+reservation for critical regions
+ *
+ * @adev: amdgpu_device pointer
+ *
+ * create bo vram reservation for critical regions.
+ */
+static int amdgpu_ttm_crit_regions_reserve_vram_init(struct
+amdgpu_device *adev) {
+       u64 vram_size =3D adev->gmc.visible_vram_size;
+
+       adev->mman.crit_regions_vram_usage_va =3D NULL;
+       adev->mman.crit_regions_vram_usage_reserved_bo =3D NULL;
+
+       if (adev->mman.crit_regions_vram_usage_size =3D=3D 0 ||
+           adev->mman.crit_regions_vram_usage_size > vram_size)
+               return 0;
+
+       return amdgpu_bo_create_kernel_at(adev,
+                                         adev->mman.crit_regions_vram_usag=
e_start_offset,
+                                         adev->mman.crit_regions_vram_usag=
e_size,
+                                         &adev->mman.crit_regions_vram_usa=
ge_reserved_bo,
+                                         &adev->mman.crit_regions_vram_usa=
ge_va);
+}
+
 /*
  * Memoy training reservation functions
  */
@@ -1901,31 +1940,37 @@ int amdgpu_ttm_init(struct amdgpu_device *adev)
                                adev->gmc.visible_vram_size);
 #endif

-       /*
-        *The reserved vram for firmware must be pinned to the specified
-        *place on the VRAM, so reserve it early.
-        */
-       r =3D amdgpu_ttm_fw_reserve_vram_init(adev);
-       if (r)
-               return r;
-
-       /*
-        *The reserved vram for driver must be pinned to the specified
-        *place on the VRAM, so reserve it early.
-        */
-       r =3D amdgpu_ttm_drv_reserve_vram_init(adev);
-       if (r)
-               return r;
+       if (amdgpu_sriov_vf(adev) && (adev->virt.req_init_data_ver =3D=3D G=
PU_CRIT_REGION_V2)) {
+               r =3D amdgpu_ttm_crit_regions_reserve_vram_init(adev);
+               if (r)
+                       return r;
+       } else {
+               /*
+                *The reserved vram for firmware must be pinned to the spec=
ified
+                *place on the VRAM, so reserve it early.
+                */
+               r =3D amdgpu_ttm_fw_reserve_vram_init(adev);
+               if (r)
+                       return r;

-       /*
-        * only NAVI10 and onwards ASIC support for IP discovery.
-        * If IP discovery enabled, a block of memory should be
-        * reserved for IP discovey.
-        */
-       if (adev->mman.discovery_bin) {
-               r =3D amdgpu_ttm_reserve_tmr(adev);
+               /*
+                *The reserved vram for driver must be pinned to the specif=
ied
+                *place on the VRAM, so reserve it early.
+                */
+               r =3D amdgpu_ttm_drv_reserve_vram_init(adev);
                if (r)
                        return r;
+
+               /*
+                * only NAVI10 and onwards ASIC support for IP discovery.
+                * If IP discovery enabled, a block of memory should be
+                * reserved for IP discovey.
+                */
+               if (adev->mman.discovery_bin) {
+                       r =3D amdgpu_ttm_reserve_tmr(adev);
+                       if (r)
+                               return r;
+               }
        }

        /* allocate memory as required for VGA @@ -2072,6 +2117,7 @@ void a=
mdgpu_ttm_fini(struct amdgpu_device *adev)
                                        &adev->mman.sdma_access_ptr);
        amdgpu_ttm_fw_reserve_vram_fini(adev);
        amdgpu_ttm_drv_reserve_vram_fini(adev);
+       amdgpu_ttm_crit_regions_reserve_vram_fini(adev);

        if (drm_dev_enter(adev_to_drm(adev), &idx)) {

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h b/drivers/gpu/drm/amd/=
amdgpu/amdgpu_ttm.h
index 2309df3f68a9..aa8ed6524386 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h
@@ -100,6 +100,12 @@ struct amdgpu_mman {
        struct amdgpu_bo        *drv_vram_usage_reserved_bo;
        void            *drv_vram_usage_va;

+       /* critical region VRAM reservation */
+       u64             crit_regions_vram_usage_start_offset;
+       u64             crit_regions_vram_usage_size;
+       struct amdgpu_bo        *crit_regions_vram_usage_reserved_bo;
+       void            *crit_regions_vram_usage_va;
+
        /* PAGE_SIZE'd BO for process memory r/w over SDMA. */
        struct amdgpu_bo        *sdma_access_bo;
        void                    *sdma_access_ptr;
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c b/drivers/gpu/drm/amd=
/amdgpu/amdgpu_virt.c
index 13f0cdeb59c4..24d25e4ed1b8 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c
@@ -150,7 +150,8 @@ void amdgpu_virt_request_init_data(struct amdgpu_device=
 *adev)
                virt->ops->req_init_data(adev);

        if (adev->virt.req_init_data_ver > 0)
-               DRM_INFO("host supports REQ_INIT_DATA handshake\n");
+               DRM_INFO("host supports REQ_INIT_DATA handshake of critical=
_region_version %d\n",
+                               adev->virt.req_init_data_ver);
        else
                DRM_WARN("host doesn't support REQ_INIT_DATA handshake\n");=
  } @@ -423,10 +424,14 @@ static void amdgpu_virt_add_bad_page(struct amdgp=
u_device *adev,
        uint32_t bp_idx, bp_cnt;
        void *vram_usage_va =3D NULL;

-       if (adev->mman.fw_vram_usage_va)
-               vram_usage_va =3D adev->mman.fw_vram_usage_va;
-       else
-               vram_usage_va =3D adev->mman.drv_vram_usage_va;
+       if (adev->virt.req_init_data_ver =3D=3D GPU_CRIT_REGION_V2) {
+               vram_usage_va =3D adev->mman.crit_regions_vram_usage_va;
+       } else {
+               if (adev->mman.fw_vram_usage_va)
+                       vram_usage_va =3D adev->mman.fw_vram_usage_va;
+               else
+                       vram_usage_va =3D adev->mman.drv_vram_usage_va;
+       }

        memset(&bp, 0, sizeof(bp));

@@ -669,74 +674,137 @@ void amdgpu_virt_fini_data_exchange(struct amdgpu_de=
vice *adev)

 void amdgpu_virt_init_data_exchange(struct amdgpu_device *adev)  {
+       uint32_t *pfvf_data =3D NULL;
+
        adev->virt.fw_reserve.p_pf2vf =3D NULL;
        adev->virt.fw_reserve.p_vf2pf =3D NULL;
        adev->virt.vf2pf_update_interval_ms =3D 0;
        adev->virt.vf2pf_update_retry_cnt =3D 0;

-       if (adev->mman.fw_vram_usage_va && adev->mman.drv_vram_usage_va) {
-               DRM_WARN("Currently fw_vram and drv_vram should not have va=
lues at the same time!");
-       } else if (adev->mman.fw_vram_usage_va || adev->mman.drv_vram_usage=
_va) {
-               /* go through this logic in ip_init and reset to init workq=
ueue*/
-               amdgpu_virt_exchange_data(adev);
-
-               INIT_DELAYED_WORK(&adev->virt.vf2pf_work, amdgpu_virt_updat=
e_vf2pf_work_item);
-               schedule_delayed_work(&(adev->virt.vf2pf_work), msecs_to_ji=
ffies(adev->virt.vf2pf_update_interval_ms));
-       } else if (adev->bios !=3D NULL) {
-               /* got through this logic in early init stage to get necess=
ary flags, e.g. rlcg_acc related*/
-               adev->virt.fw_reserve.p_pf2vf =3D
-                       (struct amd_sriov_msg_pf2vf_info_header *)
-                       (adev->bios + (AMD_SRIOV_MSG_PF2VF_OFFSET_KB << 10)=
);
-
-               amdgpu_virt_read_pf2vf_data(adev);
+       if (adev->virt.req_init_data_ver =3D=3D GPU_CRIT_REGION_V2) {
+               if (adev->mman.crit_regions_vram_usage_va) {
+                       /* go through this logic in ip_init and reset to in=
it workqueue*/
+                       amdgpu_virt_exchange_data(adev);
+
+                       INIT_DELAYED_WORK(&adev->virt.vf2pf_work,
+                                       amdgpu_virt_update_vf2pf_work_item)=
;
+                       schedule_delayed_work(&(adev->virt.vf2pf_work),
+                                       msecs_to_jiffies(adev->virt.vf2pf_u=
pdate_interval_ms));
+               } else if (adev->bios !=3D NULL) {
+                       /* got through this logic in early init stage to ge=
t necessary flags,
+                        * e.g. rlcg_acc related */
+                       pfvf_data =3D
+                               kzalloc(adev->virt.crit_region_sizes_kb[AMD=
_SRIOV_MSG_DATAEXCHANGE_TABLE_ID] << 10,
+                                       GFP_KERNEL);
+                       if (!pfvf_data) {
+                               DRM_ERROR("Failed to allocate memory for pf=
vf_data\n");
+                               return;
+                       }
+
+                       if (amdgpu_virt_read_exchange_data_from_mem(adev, p=
fvf_data))
+                               goto free_pfvf_data;
+
+                       adev->virt.fw_reserve.p_pf2vf =3D
+                               (struct amd_sriov_msg_pf2vf_info_header *)p=
fvf_data;
+
+                       amdgpu_virt_read_pf2vf_data(adev);
+
+free_pfvf_data:
+                       kfree(pfvf_data);
+                       pfvf_data =3D NULL;
+                       adev->virt.fw_reserve.p_pf2vf =3D NULL;
+               }
+       } else {
+               if (adev->mman.fw_vram_usage_va && adev->mman.drv_vram_usag=
e_va) {
+                       DRM_WARN("Currently fw_vram and drv_vram should not=
 have values "
+                                       "at the same time!");
+               } else if (adev->mman.fw_vram_usage_va || adev->mman.drv_vr=
am_usage_va) {
+                       /* go through this logic in ip_init and reset to in=
it workqueue*/
+                       amdgpu_virt_exchange_data(adev);
+
+                       INIT_DELAYED_WORK(&adev->virt.vf2pf_work,
+                               amdgpu_virt_update_vf2pf_work_item);
+                       schedule_delayed_work(&(adev->virt.vf2pf_work),
+                                       msecs_to_jiffies(adev->virt.vf2pf_u=
pdate_interval_ms));
+               } else if (adev->bios !=3D NULL) {
+                       /* got through this logic in early init stage to ge=
t necessary flags,
+                        * e.g. rlcg_acc related*/
+                       adev->virt.fw_reserve.p_pf2vf =3D
+                               (struct amd_sriov_msg_pf2vf_info_header *)
+                               (adev->bios + (AMD_SRIOV_MSG_PF2VF_OFFSET_K=
B_V1 << 10));
+
+                       amdgpu_virt_read_pf2vf_data(adev);
+               }
        }
 }

-
 void amdgpu_virt_exchange_data(struct amdgpu_device *adev)  {
        uint64_t bp_block_offset =3D 0;
        uint32_t bp_block_size =3D 0;
        struct amd_sriov_msg_pf2vf_info *pf2vf_v2 =3D NULL;

-       if (adev->mman.fw_vram_usage_va || adev->mman.drv_vram_usage_va) {
-               if (adev->mman.fw_vram_usage_va) {
+       if (adev->virt.req_init_data_ver =3D=3D GPU_CRIT_REGION_V2) {
+               if (adev->mman.crit_regions_vram_usage_va) {
                        adev->virt.fw_reserve.p_pf2vf =3D
                                (struct amd_sriov_msg_pf2vf_info_header *)
-                               (adev->mman.fw_vram_usage_va + (AMD_SRIOV_M=
SG_PF2VF_OFFSET_KB << 10));
+                               (adev->mman.crit_regions_vram_usage_va +
+
+adev->virt.crit_region_offsets[AMD_SRIOV_MSG_DATAEXCHANGE_TABLE_ID]);
                        adev->virt.fw_reserve.p_vf2pf =3D
                                (struct amd_sriov_msg_vf2pf_info_header *)
-                               (adev->mman.fw_vram_usage_va + (AMD_SRIOV_M=
SG_VF2PF_OFFSET_KB << 10));
+                               (adev->mman.crit_regions_vram_usage_va +
+                               adev->virt.crit_region_offsets[AMD_SRIOV_MS=
G_DATAEXCHANGE_TABLE_ID] +
+                               (AMD_SRIOV_MSG_SIZE_KB_V1 << 10));
                        adev->virt.fw_reserve.ras_telemetry =3D
-                               (adev->mman.fw_vram_usage_va + (AMD_SRIOV_M=
SG_RAS_TELEMETRY_OFFSET_KB << 10));
-               } else if (adev->mman.drv_vram_usage_va) {
-                       adev->virt.fw_reserve.p_pf2vf =3D
-                               (struct amd_sriov_msg_pf2vf_info_header *)
-                               (adev->mman.drv_vram_usage_va + (AMD_SRIOV_=
MSG_PF2VF_OFFSET_KB << 10));
-                       adev->virt.fw_reserve.p_vf2pf =3D
-                               (struct amd_sriov_msg_vf2pf_info_header *)
-                               (adev->mman.drv_vram_usage_va + (AMD_SRIOV_=
MSG_VF2PF_OFFSET_KB << 10));
-                       adev->virt.fw_reserve.ras_telemetry =3D
-                               (adev->mman.drv_vram_usage_va + (AMD_SRIOV_=
MSG_RAS_TELEMETRY_OFFSET_KB << 10));
+                               (adev->mman.crit_regions_vram_usage_va +
+                               adev->virt.crit_region_offsets[AMD_SRIOV_MS=
G_RAS_TELEMETRY_TABLE_ID]);
+               }
+       } else {
+               if (adev->mman.fw_vram_usage_va || adev->mman.drv_vram_usag=
e_va) {
+                       if (adev->mman.fw_vram_usage_va) {
+                               adev->virt.fw_reserve.p_pf2vf =3D
+                                       (struct amd_sriov_msg_pf2vf_info_he=
ader *)
+                                       (adev->mman.fw_vram_usage_va +
+                                       (AMD_SRIOV_MSG_PF2VF_OFFSET_KB_V1 <=
< 10));
+                               adev->virt.fw_reserve.p_vf2pf =3D
+                                       (struct amd_sriov_msg_vf2pf_info_he=
ader *)
+                                       (adev->mman.fw_vram_usage_va +
+                                       (AMD_SRIOV_MSG_VF2PF_OFFSET_KB_V1 <=
< 10));
+                               adev->virt.fw_reserve.ras_telemetry =3D
+                                       (adev->mman.fw_vram_usage_va +
+                                        (AMD_SRIOV_MSG_RAS_TELEMETRY_OFFSE=
T_KB_V1 << 10));
+                       } else if (adev->mman.drv_vram_usage_va) {
+                               adev->virt.fw_reserve.p_pf2vf =3D
+                                       (struct amd_sriov_msg_pf2vf_info_he=
ader *)
+                                       (adev->mman.drv_vram_usage_va +
+                                       (AMD_SRIOV_MSG_PF2VF_OFFSET_KB_V1 <=
< 10));
+                               adev->virt.fw_reserve.p_vf2pf =3D
+                                       (struct amd_sriov_msg_vf2pf_info_he=
ader *)
+                                       (adev->mman.drv_vram_usage_va +
+                                       (AMD_SRIOV_MSG_VF2PF_OFFSET_KB_V1 <=
< 10));
+                               adev->virt.fw_reserve.ras_telemetry =3D
+                                       (adev->mman.drv_vram_usage_va +
+                                        (AMD_SRIOV_MSG_RAS_TELEMETRY_OFFSE=
T_KB_V1 << 10));
+                       }
                }
+       }

-               amdgpu_virt_read_pf2vf_data(adev);
-               amdgpu_virt_write_vf2pf_data(adev);
+       amdgpu_virt_read_pf2vf_data(adev);
+       amdgpu_virt_write_vf2pf_data(adev);

-               /* bad page handling for version 2 */
-               if (adev->virt.fw_reserve.p_pf2vf->version =3D=3D 2) {
-                       pf2vf_v2 =3D (struct amd_sriov_msg_pf2vf_info *)ade=
v->virt.fw_reserve.p_pf2vf;
+       /* bad page handling for version 2 */
+       if (adev->virt.fw_reserve.p_pf2vf->version =3D=3D 2) {
+               pf2vf_v2 =3D (struct amd_sriov_msg_pf2vf_info
+*)adev->virt.fw_reserve.p_pf2vf;

-                       bp_block_offset =3D ((uint64_t)pf2vf_v2->bp_block_o=
ffset_low & 0xFFFFFFFF) |
-                               ((((uint64_t)pf2vf_v2->bp_block_offset_high=
) << 32) & 0xFFFFFFFF00000000);
-                       bp_block_size =3D pf2vf_v2->bp_block_size;
+               bp_block_offset =3D ((uint64_t)pf2vf_v2->bp_block_offset_lo=
w & 0xFFFFFFFF) |
+                       ((((uint64_t)pf2vf_v2->bp_block_offset_high) << 32)=
 & 0xFFFFFFFF00000000);
+               bp_block_size =3D pf2vf_v2->bp_block_size;

-                       if (bp_block_size && !adev->virt.ras_init_done)
-                               amdgpu_virt_init_ras_err_handler_data(adev)=
;
+               if (bp_block_size && !adev->virt.ras_init_done)
+                       amdgpu_virt_init_ras_err_handler_data(adev);

-                       if (adev->virt.ras_init_done)
-                               amdgpu_virt_add_bad_page(adev, bp_block_off=
set, bp_block_size);
-               }
+               if (adev->virt.ras_init_done)
+                       amdgpu_virt_add_bad_page(adev, bp_block_offset, bp_=
block_size);
        }
 }

@@ -839,6 +907,192 @@ static void amdgpu_virt_init_ras(struct amdgpu_device=
 *adev)
        adev->virt.ras.cper_rptr =3D 0;
 }

+static uint8_t amdgpu_virt_crit_region_calc_checksum(uint8_t
+*buf_start, uint8_t *buf_end) {
+       uint32_t sum =3D 0;
+
+       if (buf_start >=3D buf_end)
+               return 0;
+
+       for (; buf_start < buf_end; buf_start++)
+               sum +=3D buf_start[0];
+
+       return 0xffffffff - sum;
+}
+
+#define mmRCC_CONFIG_MEMSIZE   0xde3
+int amdgpu_virt_init_critical_region(struct amdgpu_device *adev) {
+       struct amd_sriov_msg_init_data_header *init_data_hdr =3D NULL;
+       uint32_t init_hdr_offset =3D adev->virt.init_data_header_offset;
+       uint32_t init_hdr_size =3D adev->virt.init_data_header_size_kb << 1=
0;
+       uint64_t pos =3D 0;
+       uint64_t vram_size;
+       int r =3D 0;
+       uint8_t checksum =3D 0;
+
+       if (init_hdr_offset < 0) {
+               DRM_ERROR("Invalid init header offset\n");
+               return -EINVAL;
+       }
+
+       vram_size =3D RREG32(mmRCC_CONFIG_MEMSIZE) << 20;
+       if ((init_hdr_offset + init_hdr_size) > vram_size) {
+               DRM_ERROR("init_data_header exceeds VRAM size, exiting\n");
+               return -EINVAL;
+       }
+
+       /* Allocate for init_data_hdr */
+       init_data_hdr =3D kzalloc(sizeof(struct amd_sriov_msg_init_data_hea=
der), GFP_KERNEL);
+       if (!init_data_hdr)
+               return -ENOMEM;
+
+       pos =3D (uint64_t)init_hdr_offset;
+       amdgpu_device_vram_access(adev, pos, (uint32_t *)init_data_hdr,
+                                       sizeof(struct amd_sriov_msg_init_da=
ta_header), false);
+
+       switch (init_data_hdr->version) {
+       case GPU_CRIT_REGION_V2:
+               if (strncmp(init_data_hdr->signature, "INDA", 4) !=3D 0) {
+                       DRM_ERROR("Invalid init data signature: %.4s\n", in=
it_data_hdr->signature);
+                       r =3D -EINVAL;
+                       goto out;
+               }
+
+               checksum =3D
+                       amdgpu_virt_crit_region_calc_checksum((uint8_t *)&i=
nit_data_hdr->initdata_offset,
+                               (uint8_t *)init_data_hdr + sizeof(struct am=
d_sriov_msg_init_data_header));
+               if (checksum !=3D init_data_hdr->checksum) {
+                       DRM_ERROR("Found unmatching checksum from calculati=
on 0x%x and init_data 0x%x\n",
+                                               checksum, init_data_hdr->ch=
ecksum);
+                       r =3D -EINVAL;
+                       goto out;
+               }
+
+               /* Initialize critical region offsets */
+               adev->virt.crit_region_base_offset =3D init_data_hdr->initd=
ata_offset;
+               adev->virt.crit_region_offsets[AMD_SRIOV_MSG_IPD_TABLE_ID] =
=3D
+                       init_data_hdr->ip_discovery_offset;
+               adev->virt.crit_region_offsets[AMD_SRIOV_MSG_VBIOS_IMG_TABL=
E_ID] =3D
+                       init_data_hdr->vbios_img_offset;
+               adev->virt.crit_region_offsets[AMD_SRIOV_MSG_RAS_TELEMETRY_=
TABLE_ID] =3D
+                       init_data_hdr->ras_tele_info_offset;
+               adev->virt.crit_region_offsets[AMD_SRIOV_MSG_DATAEXCHANGE_T=
ABLE_ID] =3D
+                       init_data_hdr->dataexchange_offset;
+               adev->virt.crit_region_offsets[AMD_SRIOV_MSG_BAD_PAGE_INFO_=
TABLE_ID] =3D
+                       init_data_hdr->bad_page_info_offset;
+
+               /* Initialize critical region sizes */
+               adev->virt.crit_region_size_in_kb =3D init_data_hdr->initda=
ta_size_in_kb;
+               adev->virt.crit_region_sizes_kb[AMD_SRIOV_MSG_IPD_TABLE_ID]=
 =3D
+                       init_data_hdr->ip_discovery_size_in_kb;
+               adev->virt.crit_region_sizes_kb[AMD_SRIOV_MSG_VBIOS_IMG_TAB=
LE_ID] =3D
+                       init_data_hdr->vbios_img_size_in_kb;
+               adev->virt.crit_region_sizes_kb[AMD_SRIOV_MSG_RAS_TELEMETRY=
_TABLE_ID] =3D
+                       init_data_hdr->ras_tele_info_size_in_kb;
+               adev->virt.crit_region_sizes_kb[AMD_SRIOV_MSG_DATAEXCHANGE_=
TABLE_ID] =3D
+                       init_data_hdr->dataexchange_size_in_kb;
+               adev->virt.crit_region_sizes_kb[AMD_SRIOV_MSG_BAD_PAGE_INFO=
_TABLE_ID] =3D
+                       init_data_hdr->bad_page_size_in_kb;
+
+               /* reserved memory starts from crit region base offset  wit=
h the size of 5MB */
+               adev->mman.crit_regions_vram_usage_start_offset =3D adev->v=
irt.crit_region_base_offset;
+               adev->mman.crit_regions_vram_usage_size =3D adev->virt.crit=
_region_size_in_kb << 10;
+               DRM_INFO("critical region v%d requested to reserve memory s=
tart at %08x with %d KB.\n",
+                         init_data_hdr->version,
+                         adev->mman.crit_regions_vram_usage_start_offset,
+                         adev->mman.crit_regions_vram_usage_size >> 10);
+
+               adev->virt.init_data_done =3D true;
+               break;
+       default:
+               DRM_ERROR("Invalid init header version: 0x%x\n", init_data_=
hdr->version);
+               r =3D -EINVAL;
+               goto out;
+       }
+
+out:
+       kfree(init_data_hdr);
+       init_data_hdr =3D NULL;
+
+       return r;
+}
+
+int amdgpu_virt_init_ip_discovery(struct amdgpu_device *adev, uint8_t
+*binary) {
+       uint32_t ip_discovery_offset =3D
+               adev->virt.crit_region_offsets[AMD_SRIOV_MSG_IPD_TABLE_ID];
+       uint32_t ip_discovery_size =3D
+               adev->virt.crit_region_sizes_kb[AMD_SRIOV_MSG_IPD_TABLE_ID]=
 << 10;
+       uint64_t pos =3D 0;
+
+       dev_info(adev->dev, "use ip discovery information copied from dynam=
ic "
+               "crit_region_table at offset 0x%x with size of 0x%x bytes.\=
n",
+                       ip_discovery_offset, ip_discovery_size);
+
+       if (!IS_ALIGNED(ip_discovery_offset, 4) || !IS_ALIGNED(ip_discovery=
_size, 4)) {
+               DRM_ERROR("IP discovery data not aligned to 4 bytes\n");
+               return -EINVAL;
+       }
+
+       if (ip_discovery_size > DISCOVERY_TMR_SIZE) {
+               DRM_ERROR("Invalid IP discovery size: 0x%x\n", ip_discovery=
_size);
+               return -EINVAL;
+       }
+
+       pos =3D (uint64_t)ip_discovery_offset;
+       amdgpu_device_vram_access(adev, pos, (uint32_t *)binary,
+                                         ip_discovery_size, false);
+
+       return 0;
+}
+
+int amdgpu_virt_get_bios_info(struct amdgpu_device *adev,
+               resource_size_t *bios_offset, resource_size_t *bios_size) {
+       uint32_t vbios_offset =3D adev->virt.crit_region_offsets[AMD_SRIOV_=
MSG_VBIOS_IMG_TABLE_ID];
+       uint32_t vbios_size =3D
+               adev->virt.crit_region_sizes_kb[AMD_SRIOV_MSG_VBIOS_IMG_TAB=
LE_ID] <<
+10;
+
+       dev_info(adev->dev, "use bios information copied from dynamic "
+               "crit_region_table at offset 0x%x with size of 0x%x bytes.\=
n",
+                       vbios_offset, vbios_size);
+
+       if (vbios_size > *bios_size) {
+               DRM_ERROR("Invalid vbios size: 0x%x\n", vbios_size);
+               return -EINVAL;
+       }
+
+       *bios_offset =3D vbios_offset;
+       *bios_size =3D vbios_size;
+
+       return 0;
+}
+
+int amdgpu_virt_read_exchange_data_from_mem(struct amdgpu_device *adev,
+uint32_t *pfvf_data) {
+       uint32_t dataexchange_offset =3D
+               adev->virt.crit_region_offsets[AMD_SRIOV_MSG_DATAEXCHANGE_T=
ABLE_ID];
+       uint32_t dataexchange_size =3D
+               adev->virt.crit_region_sizes_kb[AMD_SRIOV_MSG_DATAEXCHANGE_=
TABLE_ID] << 10;
+       uint64_t pos =3D 0;
+
+       dev_info(adev->dev, "use data exchange information copied from dyna=
mic "
+               "crit_region_table at offset 0x%x with size of 0x%x bytes.\=
n",
+                       dataexchange_offset, dataexchange_size);
+
+       if (!IS_ALIGNED(dataexchange_offset, 4) || !IS_ALIGNED(dataexchange=
_size, 4)) {
+               DRM_ERROR("Data exchange data not aligned to 4 bytes\n");
+               return -EINVAL;
+       }
+
+       pos =3D (uint64_t)dataexchange_offset;
+       amdgpu_device_vram_access(adev, pos, pfvf_data,
+                                       dataexchange_size, false);
+
+       return 0;
+}
+
 void amdgpu_virt_init(struct amdgpu_device *adev)  {
        bool is_sriov =3D false;
@@ -1301,7 +1555,7 @@ static int amdgpu_virt_cache_host_error_counts(struct=
 amdgpu_device *adev,
        checksum =3D host_telemetry->header.checksum;
        used_size =3D host_telemetry->header.used_size;

-       if (used_size > (AMD_SRIOV_RAS_TELEMETRY_SIZE_KB << 10))
+       if (used_size > (AMD_SRIOV_RAS_TELEMETRY_SIZE_KB_V1 << 10))
                return 0;

        tmp =3D kmemdup(&host_telemetry->body.error_count, used_size, GFP_K=
ERNEL); @@ -1380,7 +1634,7 @@ amdgpu_virt_write_cpers_to_ring(struct amdgpu=
_device *adev,
        checksum =3D host_telemetry->header.checksum;
        used_size =3D host_telemetry->header.used_size;

-       if (used_size > (AMD_SRIOV_RAS_TELEMETRY_SIZE_KB << 10))
+       if (used_size > (AMD_SRIOV_RAS_TELEMETRY_SIZE_KB_V1 << 10))
                return -EINVAL;

        cper_dump =3D kmemdup(&host_telemetry->body.cper_dump, used_size, G=
FP_KERNEL); diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h b/drivers=
/gpu/drm/amd/amdgpu/amdgpu_virt.h
index 3da3ebb1d9a1..f1498671e8a7 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h
@@ -281,6 +281,15 @@ struct amdgpu_virt {
        bool ras_init_done;
        uint32_t reg_access;

+       /* critical regions v2 */
+       uint32_t init_data_header_offset;
+       uint32_t init_data_header_size_kb;
+       uint32_t crit_region_base_offset;
+       uint32_t crit_region_size_in_kb;
+       uint64_t crit_region_offsets[AMD_SRIOV_MSG_MAX_TABLE_ID];
+       uint64_t crit_region_sizes_kb[AMD_SRIOV_MSG_MAX_TABLE_ID];
+       bool init_data_done;
+
        /* vf2pf message */
        struct delayed_work vf2pf_work;
        uint32_t vf2pf_update_interval_ms;
@@ -416,6 +425,12 @@ void amdgpu_virt_exchange_data(struct amdgpu_device *a=
dev);  void amdgpu_virt_fini_data_exchange(struct amdgpu_device *adev);  vo=
id amdgpu_virt_init(struct amdgpu_device *adev);

+int amdgpu_virt_init_critical_region(struct amdgpu_device *adev); int
+amdgpu_virt_init_ip_discovery(struct amdgpu_device *adev, uint8_t
+*binary); int amdgpu_virt_get_bios_info(struct amdgpu_device *adev,
+                                         resource_size_t *bios_offset, res=
ource_size_t *bios_size); int
+amdgpu_virt_read_exchange_data_from_mem(struct amdgpu_device *adev,
+uint32_t *pfvf_data);
+
 bool amdgpu_virt_can_access_debugfs(struct amdgpu_device *adev);  int amdg=
pu_virt_enable_access_debugfs(struct amdgpu_device *adev);  void amdgpu_vir=
t_disable_access_debugfs(struct amdgpu_device *adev); diff --git a/drivers/=
gpu/drm/amd/amdgpu/amdgv_sriovmsg.h b/drivers/gpu/drm/amd/amdgpu/amdgv_srio=
vmsg.h
index 33edad1f9dcd..130f188ebb84 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgv_sriovmsg.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgv_sriovmsg.h
@@ -23,26 +23,83 @@
 #ifndef AMDGV_SRIOV_MSG__H_
 #define AMDGV_SRIOV_MSG__H_

-/* unit in kilobytes */
-#define AMD_SRIOV_MSG_VBIOS_OFFSET          0
-#define AMD_SRIOV_MSG_VBIOS_SIZE_KB         64
-#define AMD_SRIOV_MSG_DATAEXCHANGE_OFFSET_KB AMD_SRIOV_MSG_VBIOS_SIZE_KB
-#define AMD_SRIOV_MSG_DATAEXCHANGE_SIZE_KB   4
-#define AMD_SRIOV_MSG_TMR_OFFSET_KB         2048
-#define AMD_SRIOV_MSG_BAD_PAGE_SIZE_KB      2
-#define AMD_SRIOV_RAS_TELEMETRY_SIZE_KB             64
 /*
- * layout
+ * layout v1
  * 0           64KB        65KB        66KB           68KB                =
   132KB
  * |   VBIOS   |   PF2VF   |   VF2PF   |   Bad Page   | RAS Telemetry Regi=
on | ...
  * |   64KB    |   1KB     |   1KB     |   2KB        | 64KB              =
   | ...
  */

-#define AMD_SRIOV_MSG_SIZE_KB                   1
-#define AMD_SRIOV_MSG_PF2VF_OFFSET_KB           AMD_SRIOV_MSG_DATAEXCHANGE=
_OFFSET_KB
-#define AMD_SRIOV_MSG_VF2PF_OFFSET_KB           (AMD_SRIOV_MSG_PF2VF_OFFSE=
T_KB + AMD_SRIOV_MSG_SIZE_KB)
-#define AMD_SRIOV_MSG_BAD_PAGE_OFFSET_KB        (AMD_SRIOV_MSG_VF2PF_OFFSE=
T_KB + AMD_SRIOV_MSG_SIZE_KB)
-#define AMD_SRIOV_MSG_RAS_TELEMETRY_OFFSET_KB   (AMD_SRIOV_MSG_BAD_PAGE_OF=
FSET_KB + AMD_SRIOV_MSG_BAD_PAGE_SIZE_KB)
+/*
+ * layout v2 (offsets are dynamically allocated and the offsets below are =
examples)
+ * 0           1KB         64KB        65KB        66KB           68KB    =
               132KB
+ * |  INITD_H  |   VBIOS   |   PF2VF   |   VF2PF   |   Bad Page   | RAS Te=
lemetry Region | ...
+ * |   1KB     |   64KB    |   1KB     |   1KB     |   2KB        | 64KB  =
               | ...
+ *
+ * Note: PF2VF + VF2PF + Bad Page =3D DataExchange region (allocated
+contiguously)  */
+
+/* v1 layout sizes */
+#define AMD_SRIOV_MSG_VBIOS_SIZE_KB_V1                 64
+#define AMD_SRIOV_MSG_PF2VF_SIZE_KB_V1                 1
+#define AMD_SRIOV_MSG_VF2PF_SIZE_KB_V1                 1
+#define AMD_SRIOV_MSG_BAD_PAGE_SIZE_KB_V1              2
+#define AMD_SRIOV_MSG_RAS_TELEMETRY_SIZE_KB_V1         64
+#define AMD_SRIOV_MSG_DATAEXCHANGE_SIZE_KB_V1          \
+       (AMD_SRIOV_MSG_PF2VF_SIZE_KB_V1 + AMD_SRIOV_MSG_VF2PF_SIZE_KB_V1 + =
\
+        AMD_SRIOV_MSG_BAD_PAGE_SIZE_KB_V1)
+
+/* v1 offsets */
+#define AMD_SRIOV_MSG_VBIOS_OFFSET_V1                  0
+#define AMD_SRIOV_MSG_DATAEXCHANGE_OFFSET_KB_V1                AMD_SRIOV_M=
SG_VBIOS_SIZE_KB_V1
+#define AMD_SRIOV_MSG_TMR_OFFSET_KB                    2048
+#define AMD_SRIOV_MSG_SIZE_KB_V1                       1
+#define AMD_SRIOV_MSG_PF2VF_OFFSET_KB_V1               AMD_SRIOV_MSG_DATAE=
XCHANGE_OFFSET_KB_V1
+#define AMD_SRIOV_MSG_VF2PF_OFFSET_KB_V1               \
+       (AMD_SRIOV_MSG_PF2VF_OFFSET_KB_V1 + AMD_SRIOV_MSG_SIZE_KB_V1)
+#define AMD_SRIOV_MSG_BAD_PAGE_OFFSET_KB_V1            \
+       (AMD_SRIOV_MSG_VF2PF_OFFSET_KB_V1 + AMD_SRIOV_MSG_SIZE_KB_V1)
+#define AMD_SRIOV_MSG_RAS_TELEMETRY_OFFSET_KB_V1       \
+       (AMD_SRIOV_MSG_BAD_PAGE_OFFSET_KB_V1 + AMD_SRIOV_MSG_BAD_PAGE_SIZE_=
KB_V1)
+#define AMD_SRIOV_MSG_INIT_DATA_TOT_SIZE_KB_V1         \
+       (AMD_SRIOV_MSG_VBIOS_SIZE_KB_V1 + AMD_SRIOV_MSG_DATAEXCHANGE_SIZE_K=
B_V1 + \
+        AMD_SRIOV_MSG_RAS_TELEMETRY_SIZE_KB_V1)
+
+/* v2 layout offset enum (in order of allocation) */ enum
+amd_sriov_msg_table_id_enum {
+       AMD_SRIOV_MSG_IPD_TABLE_ID =3D 0,
+       AMD_SRIOV_MSG_VBIOS_IMG_TABLE_ID,
+       AMD_SRIOV_MSG_RAS_TELEMETRY_TABLE_ID,
+       AMD_SRIOV_MSG_DATAEXCHANGE_TABLE_ID,
+       AMD_SRIOV_MSG_BAD_PAGE_INFO_TABLE_ID,
+       AMD_SRIOV_MSG_INITD_H_TABLE_ID,
+       AMD_SRIOV_MSG_MAX_TABLE_ID,
+};
+
+enum amd_sriov_crit_region_version {
+       GPU_CRIT_REGION_V1 =3D 1,
+       GPU_CRIT_REGION_V2 =3D 2,
+};
+
+struct amd_sriov_msg_init_data_header {
+       char     signature[4];  /* "INDA"  */
+       uint32_t version;
+       uint32_t checksum;
+       uint32_t initdata_offset; /* 0 */
+       uint32_t initdata_size_in_kb; /* 5MB */
+       uint32_t valid_tables;
+       uint32_t vbios_img_offset;
+       uint32_t vbios_img_size_in_kb;
+       uint32_t dataexchange_offset;
+       uint32_t dataexchange_size_in_kb;
+       uint32_t ras_tele_info_offset;
+       uint32_t ras_tele_info_size_in_kb;
+       uint32_t ip_discovery_offset;
+       uint32_t ip_discovery_size_in_kb;
+       uint32_t bad_page_info_offset;
+       uint32_t bad_page_size_in_kb;
+       uint32_t reserved[8];
+};

 /*
  * PF2VF history log:
@@ -431,12 +488,12 @@ unsigned int amd_sriov_msg_checksum(void *obj, unsign=
ed long obj_size, unsigned  #define _stringification(s) #s

 _Static_assert(
-       sizeof(struct amd_sriov_msg_vf2pf_info) =3D=3D AMD_SRIOV_MSG_SIZE_K=
B << 10,
-       "amd_sriov_msg_vf2pf_info must be " stringification(AMD_SRIOV_MSG_S=
IZE_KB) " KB");
+       sizeof(struct amd_sriov_msg_vf2pf_info) =3D=3D AMD_SRIOV_MSG_SIZE_K=
B_V1 << 10,
+       "amd_sriov_msg_vf2pf_info must be "
+stringification(AMD_SRIOV_MSG_SIZE_KB_V1) " KB");

 _Static_assert(
-       sizeof(struct amd_sriov_msg_pf2vf_info) =3D=3D AMD_SRIOV_MSG_SIZE_K=
B << 10,
-       "amd_sriov_msg_pf2vf_info must be " stringification(AMD_SRIOV_MSG_S=
IZE_KB) " KB");
+       sizeof(struct amd_sriov_msg_pf2vf_info) =3D=3D AMD_SRIOV_MSG_SIZE_K=
B_V1 << 10,
+       "amd_sriov_msg_pf2vf_info must be "
+stringification(AMD_SRIOV_MSG_SIZE_KB_V1) " KB");

 _Static_assert(AMD_SRIOV_MSG_RESERVE_UCODE % 4 =3D=3D 0,
               "AMD_SRIOV_MSG_RESERVE_UCODE must be multiple of 4"); diff -=
-git a/drivers/gpu/drm/amd/amdgpu/mxgpu_nv.c b/drivers/gpu/drm/amd/amdgpu/m=
xgpu_nv.c
index f6d8597452ed..e1244cbee1c0 100644
--- a/drivers/gpu/drm/amd/amdgpu/mxgpu_nv.c
+++ b/drivers/gpu/drm/amd/amdgpu/mxgpu_nv.c
@@ -222,12 +222,20 @@ static int xgpu_nv_send_access_requests_with_param(st=
ruct amdgpu_device *adev,
                                adev->virt.req_init_data_ver =3D 0;
                } else {
                        if (req =3D=3D IDH_REQ_GPU_INIT_DATA) {
-                               adev->virt.req_init_data_ver =3D
-                                       RREG32_NO_KIQ(mmMAILBOX_MSGBUF_RCV_=
DW1);
-
-                               /* assume V1 in case host doesn't set versi=
on number */
-                               if (adev->virt.req_init_data_ver < 1)
-                                       adev->virt.req_init_data_ver =3D 1;
+                               switch (RREG32_NO_KIQ(mmMAILBOX_MSGBUF_RCV_=
DW1)) {
+                               case GPU_CRIT_REGION_V2:
+                                       adev->virt.req_init_data_ver =3D GP=
U_CRIT_REGION_V2;
+                                       adev->virt.init_data_header_offset =
=3D
+                                               RREG32_NO_KIQ(mmMAILBOX_MSG=
BUF_RCV_DW2);
+                                       adev->virt.init_data_header_size_kb=
 =3D
+                                               RREG32_NO_KIQ(mmMAILBOX_MSG=
BUF_RCV_DW3);
+                                       break;
+                               default:
+                                       adev->virt.req_init_data_ver =3D GP=
U_CRIT_REGION_V1;
+                                       adev->virt.init_data_header_offset =
=3D -1;
+                                       adev->virt.init_data_header_size_kb=
 =3D 0;
+                                       break;
+                               }
                        }
                }

@@ -285,7 +293,8 @@ static int xgpu_nv_release_full_gpu_access(struct amdgp=
u_device *adev,

 static int xgpu_nv_request_init_data(struct amdgpu_device *adev)  {
-       return xgpu_nv_send_access_requests(adev, IDH_REQ_GPU_INIT_DATA);
+       return xgpu_nv_send_access_requests_with_param(adev, IDH_REQ_GPU_IN=
IT_DATA,
+                       0, GPU_CRIT_REGION_V2, 0);
 }

 static int xgpu_nv_mailbox_ack_irq(struct amdgpu_device *adev,
--
2.17.1

