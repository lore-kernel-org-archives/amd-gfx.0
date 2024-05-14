Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1A219C04FFE
	for <amd-gfx@archiver.kernel.org>; Tue, 14 May 2024 08:50:55 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BE3A310E4BF;
	Tue, 14 May 2024 08:50:54 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="N2Wa55XE";
	dkim-atps=neutral
Received: from NAM02-SN1-obe.outbound.protection.outlook.com
 (mail-sn1nam02on2053.outbound.protection.outlook.com [40.107.96.53])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6F45210E4BF
 for <amd-gfx@lists.freedesktop.org>; Tue, 14 May 2024 08:50:53 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZkHiYRscqmAIUlx0kBfHMbw/lkWS1zzXkdSZEmKu+/1MUYJiM5tbLJSLp5ALZ4qWbTgAoDfRZJuLvtzrMWfQuQi8CqNRc0Z2n6D8wvNWvjm/6k0NXuUBvvmn1QaPBowPNtlF40AueZmqglDWIHDXrmb6e2BbJBLNQTJHT2gXtp6/Wdsq3ad2DG2sWYz8T+A25Z/1KsNd+HZR7ZUsOkRzmzNhCnpFMF/XIzR2OQvW6grHHv2cD0YnXkC34AirZQoPcP3OsIATmj7vHqif9G/lDxUaT1g4xiuP5w0P3lgftzg1/Z5LWdc7zYxn1DXQ0zUczBikLbwPKuWi9h4SJvFWMA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qbuUOgIJ56dxpkpx0pecUkbDhcdO1YP2XPbZBnBKlbg=;
 b=ZvYsebtejARHM6Viik9+6ZTsGQNjfkNv/TD3xogXHEo2F9qJ/vZQNAGcnUmfB8CQK86EFNyilW52jQtElhyloW4Qg0HtNLuyeNj5o4Y4i2fyQ+b9BFbyzz4HsFGLA7Zw7YTzOOPdHZH67DvPtbER+lgYijJqROFgCOQOBR3500e5XEpeZ5Gajg7FwupwkfgDO+jdwgQXQsjathPlXUuu8f5LCXEF9ZB8kmIvn1bu3FM92RNVG766GxaZv9dufCeqP1vxYIKqKeMSLL8j3nG0EKNpvMoE+Xb1W9fdSk9TdQ4z0NIwFtIzcomRfVD9795krVwPUBZj+kxeWkbrgw/ISA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qbuUOgIJ56dxpkpx0pecUkbDhcdO1YP2XPbZBnBKlbg=;
 b=N2Wa55XEHmbPAaFf5T8xz59gY7jj6xq+WHGoqGh1dA9Uzvz3ZmM7t1rsdlzIeTr8vf7eIuiXMZpeogn9/xMu4bdcV8K2FqWzJQ6YuWcxf7Bmn7v54m3RBSGYKtdCwPPnA5tHcCpPT4He00TM+PLmZLSU3BxqSo6aOt2wHa2NQMs=
Received: from DM4PR12MB5181.namprd12.prod.outlook.com (2603:10b6:5:394::22)
 by CY5PR12MB6154.namprd12.prod.outlook.com (2603:10b6:930:26::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.55; Tue, 14 May
 2024 08:50:51 +0000
Received: from DM4PR12MB5181.namprd12.prod.outlook.com
 ([fe80::b1fc:750e:c91c:6d7c]) by DM4PR12MB5181.namprd12.prod.outlook.com
 ([fe80::b1fc:750e:c91c:6d7c%5]) with mapi id 15.20.7587.025; Tue, 14 May 2024
 08:50:51 +0000
From: "Gao, Likun" <Likun.Gao@amd.com>
To: amd-gfx list <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 1/8] drm/amdgpu: support imu for gc 12_0_0
Thread-Topic: [PATCH 1/8] drm/amdgpu: support imu for gc 12_0_0
Thread-Index: AQHapdt5FMwM72pxpE6ZS9gY3uyCabGWa9VQ
Date: Tue, 14 May 2024 08:50:51 +0000
Message-ID: <DM4PR12MB5181370915A60C0ABA2623F7EFE32@DM4PR12MB5181.namprd12.prod.outlook.com>
References: <20240514084751.3438103-1-likun.gao@amd.com>
In-Reply-To: <20240514084751.3438103-1-likun.gao@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ActionId=4246b0bc-83c5-4d89-a5dc-6a0a529c1f05;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=0;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=true;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution Only;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2024-05-14T08:50:29Z;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM4PR12MB5181:EE_|CY5PR12MB6154:EE_
x-ms-office365-filtering-correlation-id: 3b66548a-7468-48ae-e01c-08dc73f2f52a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230031|376005|366007|1800799015|38070700009;
x-microsoft-antispam-message-info: =?us-ascii?Q?sqzoDxNV0YiuQTmuOYyprTinSgLTU+mwD91mjknFLCsZYAnW+w5S3/TSTDnq?=
 =?us-ascii?Q?9pGmY1z8FsXae9bSev6R57F9bfijWaep6yi96faDDb2sDXKvA0+/ud0T6zFC?=
 =?us-ascii?Q?ha970GKiX7Zcuke7l/roRzcdtZ/olYWanVZAx6pUb/ldM0zZVxD9ARircCmG?=
 =?us-ascii?Q?Vk/4OzgsyCQvxtzqIz/HQwinr+LpGsQVyeMDejpPPyfuSjnk2Tyj5/rMPDBZ?=
 =?us-ascii?Q?Ij8vsbJnmXIfsDdvfPFeSqAVARKrLRTJoLd806/4Rsi81pWRtjYLF6wX5Llu?=
 =?us-ascii?Q?WNJt86mu2hsg0CkTNh46M6DTrKlkwdv9t76jr0nVUTTNDuKtB+w0LoL5MXIX?=
 =?us-ascii?Q?mOFAVA2Rxnjcx5BS/C1nnkp3dFoSv0DXnSdbImldPXDWckShqM6bwsn7A3Ff?=
 =?us-ascii?Q?EX9nh3KA+x0zzjCoomCBR4sv0MrRyS5+wTxIX6/61oY5zVXRPoHErh5S5E79?=
 =?us-ascii?Q?DGjQ/1NXECG0I9A7oKchSvbh2WitMk9zsCRsSWNQpnE4waeTTWF49QGSDyiy?=
 =?us-ascii?Q?q0iPgpmtF9Mw/S2wppg0tpzfhHGLW4LZjA0REmZ5/WPmC1hNY2MmWXpQTAOQ?=
 =?us-ascii?Q?YYwR0V2evYoIFcFh44iImV27Xq12EQl1LdreDmupR/rz7dwOn80aN1V7t7tr?=
 =?us-ascii?Q?/aiFS6N7+k7NzzC35lDEIELbIW89BMrfVcXvvc93REE0DL/T19Ot852AZ8MI?=
 =?us-ascii?Q?WGDvvXQ1u2nlNMcEqGyxbrXX1z1ubuGSywT7zeMfPGDJkmQZnPWwljxQMwL5?=
 =?us-ascii?Q?PXThAnirQpNs0lsi8w8MOCkt3O4H7r3PnMKsJHnOgV9YiH2Qi8wX2yw5b3P8?=
 =?us-ascii?Q?hh+GL2X4v07Bp6yGlkFEhJsn1u1JpfV63AIVH1TjXq7Ufq3YbXvUYuaAor9W?=
 =?us-ascii?Q?YGNuHJqFuryhn/nMf15btsrGLo0FXMHWTh5SonY5CJOWD25grIpLRwBecbSz?=
 =?us-ascii?Q?CrRJ6QIcsf5ImtVx2oqZEzu8z7PFfDz9QuAfK4ktuEEzgHD/MXCBkEtMNujU?=
 =?us-ascii?Q?JNJxmWIr154tkjuvxL0VXqfugBwtdSIEzGLdZV0vuVi3kKtgr37TRPx66pSG?=
 =?us-ascii?Q?E78iX4fNzgcue3ekim6tCmIO3GrZpRBAfaKb3a0uQizNtkiqdWjnsJYT2+uB?=
 =?us-ascii?Q?1z9aPypNXRDY1SfViQBDqAXgYvK544yuxxNq970xGfgKMdm4AY1LK/tXxJqF?=
 =?us-ascii?Q?E+lrir5uT7/p/FSBB3anL0O0JzfzRT5Lx1Pr+Yt4i+e3JzhijscXbce6SG8t?=
 =?us-ascii?Q?62PX/jxpOcscFNe01xanOyara6Y+nmr0PBRIsZAIX2aCC6e2ow4qmFDhm+r2?=
 =?us-ascii?Q?IIL0NgMyKMaP2S2lKU4/ScjWsVhJW491Pe6ViSQmiurdwA=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB5181.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(376005)(366007)(1800799015)(38070700009); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?fUs+6pHBHDEIdUL/jorx1CPHtdAyf2o3910guf1RQ0qFAuZ2xXjE1CZXNdzp?=
 =?us-ascii?Q?uQV/rPsFVN/ImBAkRTIueScmEP4LPsx3bGm1nXEXDSa02H3EL6iXgCp5kdBk?=
 =?us-ascii?Q?lgWm4vVG1bsxIAQ/c9geT6s16f/5NSuuJy49eDxtviFRBQoNt8qp+WYAehwB?=
 =?us-ascii?Q?gsNOCYXjYBngKJzx+Mqrs/k/Tw4y6L1sTdnBVWxyBdnZwUyAQ4sIvSZlN4Vn?=
 =?us-ascii?Q?+tcVcBNQkPIieYvDqH+7Khiq+cpJbCNUCPfO+fKSKbJ9jBrqGzRXrNXAhAy4?=
 =?us-ascii?Q?qffroQgyptWImkdzO4xb0IjpgjBR50Zz3z8nqQ5xjAgaXLZaCVKHeYfGuqwZ?=
 =?us-ascii?Q?95xO1X+2Si7OltOzQKyDZtfbVMntPR43wyq34Kgq11VHRKhLb4mQCA5yvqnp?=
 =?us-ascii?Q?knV5XvmZj8Bd9zYSZgeO1mP6JmH5lzxsRylC8AspJKj0ozSIPefa1uSkRzH5?=
 =?us-ascii?Q?swpEpeCD7zOpOZVphbXdLZir/GE6tpKJQFuO0kga1PkRboW2FdrDbCF/AOgI?=
 =?us-ascii?Q?8Iau1XbpVQun1YfUF51aujOuZ9n4w0vowcDdBXxVHVFD1IUhL0nRJT7xQ7Zv?=
 =?us-ascii?Q?RJtufExSmce6/bYZREQha/Ce2YcCu6mtpgnp4yLNxoeFLsXcM7LomDXW94wn?=
 =?us-ascii?Q?csk3QfpfWiLRfwdEh6d7AeS9cK6YzvqFMqq3PIy2iFFE1fNoQ/AxpZH46RbN?=
 =?us-ascii?Q?O23jgXBaCd7k/GFyPrFauJVAALsxBhO8OwHYdPKg/otl7+PKhhEnRqofHCWU?=
 =?us-ascii?Q?Eolne9zziuIYbrkeN9rN3AMzxVcxSBoYegA6uvDvsp8uVeaXwkmkRRkSVfJ8?=
 =?us-ascii?Q?iVAErKpPkCy3wSYrsYen8BcCKwILZk7S9cSpC6rrMQCVFVd8ScY5ibbiu9ex?=
 =?us-ascii?Q?hW6bzj75/Jbc3vs8nP9tj+obpLF07EnYrBCV3AgtisTJDDQ3DMlfo6a5PnkP?=
 =?us-ascii?Q?81m4hsVqIZF7knyuuCyuq5SvKF5HRJo1r4FO8f0F3v7spHcc+o+DChBBY1kq?=
 =?us-ascii?Q?SV6Ly9UdcGzEJZb5UVdmhlcuSmg6KPFuUeyGG5g4sLwnZ7AmWOo/OGhsRZ3c?=
 =?us-ascii?Q?SIgy04lJ/euw8VEQPmI/vVlaRgwFAfunHJLEp5OFr5e1KHzjSwbUPaDYtZ6Y?=
 =?us-ascii?Q?4Am9K2ua9M3CiUqpEdfctqrEb3qicO1fnhlPPJ5gNJbcpj6khG6yAfDGtnqd?=
 =?us-ascii?Q?8Yf0Gk1OvYqBYxeoHbJFbyWYqN3fr1BJg0b8b7A4gLkkGaNifBhV/7pI+Yb2?=
 =?us-ascii?Q?EwRTNSazzBIPOpVhUuARssQwYHkTOgw0ZSVjaKypNn1FPmjXi/SWJqEWfl9G?=
 =?us-ascii?Q?zlswjIZabT5j0/dRpa8Y5vyjsKLkxn9LGPCsfGvJZ3QwmONHaJJnkkYylLs9?=
 =?us-ascii?Q?GCa/GTzBh4k5V0jKQEhCbFPNnpwIVmPs80yvYaK/StU6ZIeW9LPt+yVqzUfs?=
 =?us-ascii?Q?UNxQTLeMHFI6nSME2Ff7Y0+gH+duKEXJyAyrlB4pi4XJS+qzCd9TMUrIeCRv?=
 =?us-ascii?Q?Zbyg5suD2ZPdyG7/iD9R4p5ty3YlcOThiYKkM1Th4cVmwz6TVZqHDJoNqkPH?=
 =?us-ascii?Q?MciGircnMhrJSffId7s=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5181.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3b66548a-7468-48ae-e01c-08dc73f2f52a
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 May 2024 08:50:51.1848 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 3OGFR+vNIHSiUcWQfyvVyxkBZzRTotipqy4TTJXVSJ/7kium2m+jeA9wqjQOinGt
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6154
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

From: Likun Gao <Likun.Gao@amd.com>

Support IMU for ASIC with GC 12.0.0
Drop some unused function.

Signed-off-by: Likun Gao <Likun.Gao@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/imu_v12_0.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/imu_v12_0.c b/drivers/gpu/drm/amd/a=
mdgpu/imu_v12_0.c
index 032ae12b2be2..0c8ef908d112 100644
--- a/drivers/gpu/drm/amd/amdgpu/imu_v12_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/imu_v12_0.c
@@ -32,6 +32,7 @@
 #include "gc/gc_12_0_0_sh_mask.h"
 #include "mmhub/mmhub_4_1_0_offset.h"

+MODULE_FIRMWARE("amdgpu/gc_12_0_0_imu.bin");
 MODULE_FIRMWARE("amdgpu/gc_12_0_1_imu.bin");

 #define TRANSFER_RAM_MASK      0x001c0000
@@ -367,6 +368,7 @@ static void imu_v12_0_program_rlc_ram(struct amdgpu_dev=
ice *adev)
        WREG32_SOC15(GC, 0, regGFX_IMU_RLC_RAM_INDEX, 0x2);

        switch (amdgpu_ip_version(adev, GC_HWIP, 0)) {
+       case IP_VERSION(12, 0, 0):
        case IP_VERSION(12, 0, 1):
                if (!r)
                        program_imu_rlc_ram(adev, data, (const u32)size);
--
2.34.1

