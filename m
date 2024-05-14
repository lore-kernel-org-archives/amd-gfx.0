Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9ACA0C25B75
	for <amd-gfx@archiver.kernel.org>; Tue, 14 May 2024 10:11:12 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D83C110E1EF;
	Tue, 14 May 2024 10:11:11 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="s2AaGhm9";
	dkim-atps=neutral
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2049.outbound.protection.outlook.com [40.107.244.49])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 99E8110E279
 for <amd-gfx@lists.freedesktop.org>; Tue, 14 May 2024 10:11:10 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=M4ZTMKV41G7CW7Eu/3nUPHQZ+xeCMufQKCOWDGq6szjafMsciuKVZVQaq4UCBIO0lJgyu4RNwYoq8cSkZvUGNO12VXysQz8/7+x2Uwwebu03+2EoNNTEDm5s/nMyYNTaDD87fCGWku4l/WoIgL1Foztza6u73B1ECNQQxQSQ9T+iPZKx+FveqdoPIzyvY3gVJS1kGCruhuieuZbWaTs7nCrlTueri6QNeNzDAwvFn1qr1xztQwU17cxQqrTeopGd99h7KHB31yMCf0oF7psbN0Yj+ual+WPtsgdOalE/iqlSkHpTb55hDCsAY/B6YvKbGpKnohhkxhNIdu34+DWyEg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=L/gY056ie/agO0HLuo50T6QMB4nPfRejvktrpTSxxu0=;
 b=Ov/uFcOOvMViarVMGrG3HOQXbQXswmCskxMRtbyLAZZOXiQA6d3f4/CAvBsOQaz33w6slAXvJvukCGVuc+ybr0md+nj1ttfqtz6OPLb1KONKL7MzzcPyjshq++hzxt3IjlAJFzKAT4X1TbtHXgG9YMK0ixznir/ooujry4jNEu+nfhKUwQycM9bZzSP646aOua9sUzHs76mo3y47NzyvLUwHLbpWKJl2mQkuqH6//rEMVeXb9NrJssPwROthEFC24w3VKjJhCJBWx216wd3KbqBPUeGHNQKBehxMM7/VrqyQurBVHHFz3HkJkAti6EopcY+VzAjmlijCs8YkdGUY0Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=L/gY056ie/agO0HLuo50T6QMB4nPfRejvktrpTSxxu0=;
 b=s2AaGhm9Sy6dxCACyMBRY2cZuBA9Z8OC1CWYS8JkNvMQYyps3hppN4AmyRvMOT5QGrtyU6kD4BWE3Ed9ZHTNyPLQE2UhojxIqCvDnuLRy98Q35sk94YafT+29hKjxLl87y3jbBMBAZ4TsbLorblu//u2I43pWYKJIxbtCHU9r98=
Received: from BN9PR12MB5257.namprd12.prod.outlook.com (2603:10b6:408:11e::16)
 by DM3PR12MB9390.namprd12.prod.outlook.com (2603:10b6:0:42::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.55; Tue, 14 May
 2024 10:11:05 +0000
Received: from BN9PR12MB5257.namprd12.prod.outlook.com
 ([fe80::c593:f43d:c798:e009]) by BN9PR12MB5257.namprd12.prod.outlook.com
 ([fe80::c593:f43d:c798:e009%3]) with mapi id 15.20.7544.052; Tue, 14 May 2024
 10:11:05 +0000
From: "Zhang, Hawking" <Hawking.Zhang@amd.com>
To: "Gao, Likun" <Likun.Gao@amd.com>, amd-gfx list
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH 1/8] drm/amdgpu: support imu for gc 12_0_0
Thread-Topic: [PATCH 1/8] drm/amdgpu: support imu for gc 12_0_0
Thread-Index: AQHapdt5FMwM72pxpE6ZS9gY3uyCabGWa9VQgAAWQ2A=
Date: Tue, 14 May 2024 10:11:05 +0000
Message-ID: <BN9PR12MB525733AD5E5D4F04F6B86407FCE32@BN9PR12MB5257.namprd12.prod.outlook.com>
References: <20240514084751.3438103-1-likun.gao@amd.com>
 <DM4PR12MB5181370915A60C0ABA2623F7EFE32@DM4PR12MB5181.namprd12.prod.outlook.com>
In-Reply-To: <DM4PR12MB5181370915A60C0ABA2623F7EFE32@DM4PR12MB5181.namprd12.prod.outlook.com>
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
x-ms-traffictypediagnostic: BN9PR12MB5257:EE_|DM3PR12MB9390:EE_
x-ms-office365-filtering-correlation-id: dc5f2bcd-3a8e-4140-e7a4-08dc73fe2a98
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230031|366007|1800799015|376005|38070700009;
x-microsoft-antispam-message-info: =?us-ascii?Q?f+kYt+OJ5/pKrbDI1sIrlyCjppa67Wwxnh+Wi6aalLdw61vL5slkO8J2LWj7?=
 =?us-ascii?Q?P5ZN0FGBviC387w+24y7baLGZx9zUptaToeDx4z3JK/mwVWGv8ygmyZigUmR?=
 =?us-ascii?Q?C/atIrggMyGqy3kGSDPTbFZHz8euf/UHFBQ5UZ64AWRuc30zfYMHOH8dSiL2?=
 =?us-ascii?Q?DgEd+E0uKBvqE3skbCYIz5FMvMDQHXk4XNP1xVsR5fj82XkiSFNJDxcb0lwI?=
 =?us-ascii?Q?S0QJvbTdYWzVt3TMjWXJmXxEX9vUuK8sd1KpoCtYgracmdjXl7hxWDynAn7L?=
 =?us-ascii?Q?ND2N2KzgnDk0vUng5z2NSF/nYcdD8ZmzCcROn6hl+ODFhf1JxFmstzNgkyiG?=
 =?us-ascii?Q?9tVGslhCVqypWk3Uyk/OVY9lDMwcP5SCNBB49MrhVST9nO2GpL/Ou9mqPYpI?=
 =?us-ascii?Q?isXt8W89fUlpEEArtyra8ASM9xzXuulHRXUVc+NF3DOclagAZTRvDaLXRyC0?=
 =?us-ascii?Q?sMKpBjz6xq1kEcR49eladCwV5jgecsFJZaCQVgKrSRLMNXt4prP+3QDETJub?=
 =?us-ascii?Q?N9zrOxaxFH+6/48+7/Tvz4fpIDNymjDY+uHH9qVfebbXug+l4qFJ+I9XnSWF?=
 =?us-ascii?Q?mXoFKkF7oXsmEU7UThVJ7PQTNLgbmxhoSJyKZYLqggXH1Fbb1baX5eE1HY1/?=
 =?us-ascii?Q?MLnk5a2Vts0JeSBYCwQ7bDupw9/4lN+UkbAJ4AINL81L13LyS/MPQW1DmSdj?=
 =?us-ascii?Q?akHRRsNVih4AcoiyP+mXrm5zOCf0V4Waz/3SEIIdMJ25NPIYK1tfSI6GKvGN?=
 =?us-ascii?Q?H6EVf3U1AcaOrX2Q82LJOUHau3fpbz+i4Rtvy9c6cOlHvqIIiIfIe5puc7ph?=
 =?us-ascii?Q?E+yDkbrX+qZF3CwY02ahcxZmjGAKTuuHgUxaVGjE26cwgqAZQ+4lEtf3j7sp?=
 =?us-ascii?Q?9xMWifiFtecSM95JB9Zeg/5KMSkxfi85HvoXIAeeGxT87qaCn659mchMxleu?=
 =?us-ascii?Q?TlcVA86DBWspaWkY303tff/EuefSffUwDsL9+3rtXWWCwiCDXL7k6MoH0x7B?=
 =?us-ascii?Q?dEhQC/k5JXrvnQJtE77NumPXB4TAENdtxAON2ZDxtLpqA4oOg6yg3HLfvL9r?=
 =?us-ascii?Q?vPoUXRhHopPn8kVGzIsNMObIaPXwWsUL11fZIIt1Wl8vBITYIsm28cC1rd7D?=
 =?us-ascii?Q?WTcZzThqhrHE+WQGpPDgSX9andABOIs+aroY2jAoZ0WEOd2svQ90IYe5S9AH?=
 =?us-ascii?Q?t6KG5hfIIxNZSYC5W2s+i9vHGhuVewS5NZejELEzX+8glZMrrEs/F/kbLpCx?=
 =?us-ascii?Q?1eI8gLu/CnISUoqMAjdTamaq+lWt1XnkHrMzJc1+Tzrl32S0n2yYRvGM0jHA?=
 =?us-ascii?Q?MYg8tGVwzqdxNpWD8vSuSuSPciI3hzIAAazCmASx5+YnlA=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5257.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(366007)(1800799015)(376005)(38070700009); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?oIyuZ/HWgxlVaF2V3EeYKeuimDMYKQx30MVSxHEI3R4/w/LK2gq1qy+jmALi?=
 =?us-ascii?Q?1nG6OpPiObj2xHGP5PutJk/kL3GO5Utj1UgLP5GzUKhpvBJFuFPakMXMo3by?=
 =?us-ascii?Q?dXsdWNjdoZk2+wVv6d980ANzcl/oafpz7bw3SmFEI0HULnLvBOy5DcldFEQE?=
 =?us-ascii?Q?ypovkY638tUONxW2rzQ9o2a+PM5Ik+4M7XSymvpNxzxc83/iRMfn3RUsqeWW?=
 =?us-ascii?Q?xnkv8W+YGD/jIjO5ZRHbui/b1pZaN3wbacMyy+KBRgGZ27LAydIF+Rxc+l9L?=
 =?us-ascii?Q?QAUlugZur6LreDM+6vN4dFiAjcSgH2fy9NTwLoWANQcvnTyuyQnSe+tFKX9y?=
 =?us-ascii?Q?Pa42W6Hq3+i7ES6RHNE7+0AW5bV9pb2CxJ94UgHJHlLtFjux6TnOnYhCwH/6?=
 =?us-ascii?Q?nCjscrCG/FMrP59PKC8UzmcneZXPFjObFWM9j5sLvGXtXH7kOE/+e4QNyk7Z?=
 =?us-ascii?Q?hmIg+RQH4nu0sIEi/u9sBXYFPEy0rthQVj60CAsrk4TNENwvkvApzZuavi3o?=
 =?us-ascii?Q?5ilBNSbxSpDKx/NVifX/b581VsRDL93ri2HngLFXzIs3iMMG84QhHdVdMgbf?=
 =?us-ascii?Q?VOHyZ00u5yj/hbKXOKSV6+XxWdaPwpiCd8k4jniUb0/xaumLXYkQVNkhzx4Y?=
 =?us-ascii?Q?Dl7FesfHX76thZ/wXNpJTx11VscVTmAh/i6UCSclA7zRIvattRu1Zu/nekVd?=
 =?us-ascii?Q?xUiha7t3WqE6csYLLr/M81edKdEasum4DEGvBCjaoxX0YTgAno4iPSlUMcYr?=
 =?us-ascii?Q?XAdxA0dehDDeFgU2zyM6neUeMH1pjidQVKenIYngk257ovEePHpkVMJvBq7E?=
 =?us-ascii?Q?Yh9+UxqKmR+pekiKZq31sZthz4XiOtMgoYfJi0e8BVM9MTcPUX+MmyK+srSM?=
 =?us-ascii?Q?os1b46wKtlFDyPiEY35PuXaEexNbX8bXl/mg4jpAnBmgDXq1Vl+8fr9N+b5D?=
 =?us-ascii?Q?ag76U/L/Flb0Y+7qzkRuwKmIHJvE57QVcgUaxUzDGViyF0VIynafWtupG70h?=
 =?us-ascii?Q?dJuwTlWUI5zY/qq3JGvu8J6AQ+Aw4J5qumaNhuq/Ddg5T+I/evkEh99n1P+M?=
 =?us-ascii?Q?TgzcdzJe77c5GsmqckAnxHpIEtrm12wxM884Z9XL0V5OjtT5/++TZg5zyrqN?=
 =?us-ascii?Q?4e5QHFFi9pEOHnQXp6mJOtie1aumum+PGQkSvy/GPuzHLHTJdRcPEI1MJPs8?=
 =?us-ascii?Q?Qo4MpQ4brYkTztILKV4RKYhGCyvK2YHREgBNHP6ygEDbMubkPlXSiC63BsqU?=
 =?us-ascii?Q?3TMESlIoRERX+6K1rArj34lkeMJRWhuxTJD9T2flOhp8JYNNEojJmTIJJu/W?=
 =?us-ascii?Q?7p7fxy6Dd3wvbsfjbo01SIUwsREx6/vENVKp0QHO36njZndMRKL/Cu8lwTX6?=
 =?us-ascii?Q?CdQhRcAqMsl0xkhcjf9OuMfV5gnA8pstZ6fbP2koMXbshRyOYkiOKGaY2NKD?=
 =?us-ascii?Q?AxKsqp1dX5h85MLj8lxL5+g8QxEOoO2gDm9elwuUwEEOWVpeOLRnYpg/7EG0?=
 =?us-ascii?Q?tNoIhBe3YchBQ/ultxCoq4ZmIP55g8M6D0DmW9ISZQHzJdu99s5jSTPxm0ro?=
 =?us-ascii?Q?SYV3GBM0Y3G09A+ILqIb2SfGqD14nVVaCc0q6Q6s?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5257.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dc5f2bcd-3a8e-4140-e7a4-08dc73fe2a98
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 May 2024 10:11:05.2853 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: +ZUHiBmkvK2UGEUoBORrVrfSlILtS0JMP4C6QsDBNt45LJL8jeXCUWSGXnd0mGJbinzKPzAyLqNJ/NW5ZuAtiQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM3PR12MB9390
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

Series is

Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>

Regards,
Hawking
-----Original Message-----
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Gao, Lik=
un
Sent: Tuesday, May 14, 2024 16:51
To: amd-gfx list <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 1/8] drm/amdgpu: support imu for gc 12_0_0

[AMD Official Use Only - AMD Internal Distribution Only]

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

