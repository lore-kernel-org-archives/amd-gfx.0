Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C6709EB64D9
	for <amd-gfx@archiver.kernel.org>; Sat,  8 Jul 2023 00:54:01 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C016A10E031;
	Sat,  8 Jul 2023 00:54:00 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2046.outbound.protection.outlook.com [40.107.237.46])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1D10310E031
 for <amd-gfx@lists.freedesktop.org>; Sat,  8 Jul 2023 00:53:58 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=c6ucM2B5AWf5ZitwJUKQf6JSvrG9wZyblC/PB8SHp3cQExq3WnAGr9dSNSTMiNvxMDtcc9CA3eDK8dz/WWwuv22dHdtWL28JYF8IoDFfb7ahh8LuICm9sY1O+r4qziSYh/QDDjArWlczINfkMia7GdK4YeRqew4cFXUby/i0TjKU8RMliWXvp64ciYKCKi4vxjM7IZ5U12/uNtz9AbDVe0i3w81dn9rx7AFtbojQYns2eLSyY35419fTCfizLfvHNQPIQ8L/X4P5uaeC+YHbBiYqaFWVa0QPym3LoSIez409RdNZjMpux6zTU5QjY/f3IKkM8v9gxgf3lkzm6YuRRw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fFJBPGD9kDj+2YuHOpGxxI2e1HMhEQ8/1b6AEKLlGfg=;
 b=daRPA0RfoOXz6ZZKq7UYbY8q2PHUuD9Pat7yE0Clk9C8rqy86FCckP/Crq8legS0OeFE1kMdUyHJwdDmMY1yUVAw06iVSRCKNDdzM3T4MhNCywJ8irbwQtbR5P1t6xUFWcvCBWT55wFV/1KoLghE0MO4eTa7syVfVwvsPBVoPXP7GORxSbpzDgQ9Id9QZQ7AydICNJMChK4vwEYaRmFWp6r3/gsWKi0BRaMDzVYH1TXEg36ofx3cNDtEjZkSzAC29ga1lrL3im/sk/iNloZNtwW6kgdB/vB3zUga0SMh8LZW77Blr1K13jX3mhqZHj3q7peWYJrtz3SbztTUvodUDg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fFJBPGD9kDj+2YuHOpGxxI2e1HMhEQ8/1b6AEKLlGfg=;
 b=aDwI7cpkP8RtpCMyg6uxfTmxMnp19bQ1/EzCE1gzOpE+FEVSgC9QYvsSxtE/v9E8fZYRtN/JoyuNzMD47Fi7Ty9+FusqBvf8KI9XDEvPOn2OZFK408QN0KI2nfhYDMMEmsUMlyU2UVvGrEWnGJ0F2x/4KyPwNJpYKXrX0qGg674=
Received: from CY8PR12MB7435.namprd12.prod.outlook.com (2603:10b6:930:51::6)
 by IA1PR12MB6651.namprd12.prod.outlook.com (2603:10b6:208:3a0::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6565.26; Sat, 8 Jul
 2023 00:53:53 +0000
Received: from CY8PR12MB7435.namprd12.prod.outlook.com
 ([fe80::100e:1d82:bd2a:e05e]) by CY8PR12MB7435.namprd12.prod.outlook.com
 ([fe80::100e:1d82:bd2a:e05e%3]) with mapi id 15.20.6565.025; Sat, 8 Jul 2023
 00:53:53 +0000
From: "Kim, Jonathan" <Jonathan.Kim@amd.com>
To: "Huang, JinHuiEric" <JinHuiEric.Huang@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Subject: Re: [PATCH 1/4] drm/amdkfd: add kfd2kgd debugger callbacks for GC
 v9.4.3
Thread-Topic: [PATCH 1/4] drm/amdkfd: add kfd2kgd debugger callbacks for GC
 v9.4.3
Thread-Index: AQHZsPsMuHmQUP2OdUqHcMBw1kCB86+u+NbigAAKdgCAAAeXag==
Date: Sat, 8 Jul 2023 00:53:53 +0000
Message-ID: <CY8PR12MB7435F6FE975BDE1BCD17101C8532A@CY8PR12MB7435.namprd12.prod.outlook.com>
References: <20230707174648.146441-1-jinhuieric.huang@amd.com>
 <20230707174648.146441-2-jinhuieric.huang@amd.com>
 <CY8PR12MB7435CB35A4EED90C5DADDA3E852DA@CY8PR12MB7435.namprd12.prod.outlook.com>
 <12373fb9-a6bd-908d-b37c-1a583da4d576@amd.com>
In-Reply-To: <12373fb9-a6bd-908d-b37c-1a583da4d576@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CY8PR12MB7435:EE_|IA1PR12MB6651:EE_
x-ms-office365-filtering-correlation-id: 8eeb858f-3a7b-4f17-4c22-08db7f4dcd02
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: XwqjKhwwHC9uLseQrz7Mn0oMHM+uRkKLGp5JbQe0q0wVpBBl9YQ5lQI7JO0uPhldp/fW0qrwSK2ngYEg+mjxOSA5EvXrwLpTNUEjSvCjPp4ymIGKg8QfMfis/gwn+VCQA13NFxQJXUd3c7U/Wh7AAGnZv39L3q6VRXt+9FCB6w8QjJiHN52eNB7UdSHavj6pC2wyj48anIRURr1RN9KcTWwiUk/+DjFpwTe7otdegLZrOFNDdLekppwlOTPaDRJWUmcA6XmSQu4r3O38beYY8UDzaLiPBNWgkVR+gpQvZlSlwyVZq1dKV9d/prBhbOij2xpqCcCNeFIhszINIpfbPOjCyysg+T1/pUVpBJgIBrg38LSnZxadK9X2BGX0fxCBxxxsj4nP3hRpINDE5HCV4SrA2/1bYGCvo61KTkFh/nccoTTf/D3m7kfQ+hQKX84cOtJNiDZcy+XWoJEeG0shsq+5GOm6NpLRsmil+93qipwJI2qZriDSr1l62iejdOrgvrWLEK6cHtU+vPnprxby8EhVl7IECYS0fFA75Fg5SOXH10lLkS6bZlxeS+nWowHGlYk2s0Bjtm0HD5fwBC5596hujOstTXy2fZtejAmw2qF/1y37Kk0PMzzjb+niRRIu
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CY8PR12MB7435.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(4636009)(136003)(376002)(366004)(346002)(39860400002)(396003)(451199021)(66946007)(66446008)(64756008)(66476007)(66556008)(86362001)(38070700005)(30864003)(2906002)(316002)(76116006)(91956017)(41300700001)(478600001)(110136005)(5660300002)(52536014)(8936002)(8676002)(66899021)(38100700002)(71200400001)(122000001)(7696005)(55016003)(9686003)(83380400001)(6506007)(26005)(53546011)(186003)(33656002)(579004);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?yEco+n1bhA4H08eZQo0X57B2XRxYpSjvUeLhgHf1Um0qcIaU8eqTw6YS53BO?=
 =?us-ascii?Q?wkUMPidbraKNufp8w1J5jolK3s7Sn4KQ9yQWc8MO+KFESj93/rUDKtiX9FCx?=
 =?us-ascii?Q?JIxJc8FhO+wqflWtOsfHUNQPLeLMUma46ojHbu5U1vqIKpv8U4msHglxH/IF?=
 =?us-ascii?Q?VpCowbRduHwhPZmRxbWsVbUACbVS76NTzd8b8VwVeduz4EFIHTOKHy7+7qJn?=
 =?us-ascii?Q?oXn4i+3Bk6aAHC09f11gNOChITIrW4z/E5UPTHqwMuMiDgkjI/MOzQJE26LO?=
 =?us-ascii?Q?GJHdwJVTyoCP3cQ0D9Q3Xcuea8E5HfrRuaYVZ2/lQUik1gplrnspxSqPESQs?=
 =?us-ascii?Q?Dtt1MysVRhww+PyhaZd1hccy9MauiSY9MYh85j2r4RcKOZah1TbxCXcK3Keq?=
 =?us-ascii?Q?Lg1ZKDOJGv4tUvPgRY2V+6Xxj6DJBJZMCaU3nVd0M1TcqHsZLG00z3IvuJPs?=
 =?us-ascii?Q?LFaneSiJunPmuvONNlM4UvuN3no7N6r23aNWgY4BWivvVFDrscF5W9rkXHBZ?=
 =?us-ascii?Q?udieiBcDDFnRCvTHAPyxqNCALQDYayoI79YfXV4CCfQ8WgWRRzvwxjgkyMUu?=
 =?us-ascii?Q?EL5aKL7aGJULbffNnWacrTFakYhEjUxhXvLD+fuRJTYcVDp7Md3BPS0UfjoR?=
 =?us-ascii?Q?EwHbzuNfStKqt4sWPqKdIzMd8OJfCozrANu4rDs/g7a9hZ0hPIYNg0KLxdgW?=
 =?us-ascii?Q?wrlacDo6p2islR8pqVQ9xUFUf7MhvtIBuxP1PIaywE2BC8YxqIf1RF9jcsF4?=
 =?us-ascii?Q?h1LR4JghDOJwBjt7B8ZKvxWXv6dGDvrPsZMCDHS7X4PIvK1HKnRHC4+Wc4al?=
 =?us-ascii?Q?G8CKdAGU8WelLhXtiz3e9YmxBnqkkVwUXhC3zS71TmcSVaGnzj8UxhF/wtsO?=
 =?us-ascii?Q?7DAEg6FSShhx+w1EVck/DNpjgeZ4EjQjzY1zUdf9BGJoxCIMv7WyObs8Nmon?=
 =?us-ascii?Q?ROdStDA/T49XWWP7NRaLjxzcDM9J3ir0wzXOpHqylPH0lKYo7w9VTEPtdD8D?=
 =?us-ascii?Q?z41Mzcnv1Vm0U5XAc7lCH/it9I3WjEGDOmDTQsWYuVCk/BvjswMvMMf9rRcr?=
 =?us-ascii?Q?6UCV0rwrPd8SvsT14o8yDYvzOR4jUpz/DwaUniiMn9CtSQyHbyAAm1O62gJG?=
 =?us-ascii?Q?VcLUJuVdHOXtqRakQn46PyuJ1QgZFSOQMl7wCNGYr4cduQ7izj4o7JgGp/cO?=
 =?us-ascii?Q?HPivrP7gCP2izFbdIfVeEXjJFW65jiEWLVaTGnsbY+jBnNgigbpkzohqY0YT?=
 =?us-ascii?Q?Xm17SkbWdjTx3zRgAHUTUdm1cvJ7tDfkf/p2hi2+MfyXfPspuRw/q4MZozKc?=
 =?us-ascii?Q?sqQwwn3MHxd6OIj7QbRCWqiufWUocdTeG3OoOjiQV0abnTH/dN1aOYQiyEKx?=
 =?us-ascii?Q?5s4V4pJuPHGPYvrs6th5MeFccfrLQ4BxO6bteUp384O7M/hzK0TBdl0faw3O?=
 =?us-ascii?Q?vZHvo9osXojbutFZxu1lczehxP7rv8MXhiQkf4DZPdSHKCtdJy025MPoif+8?=
 =?us-ascii?Q?3K5KyiGKK3DR9ISykOsyB3NuUsC2JabduXuigvg6KQ1ooCQ71OEwORB9tSdE?=
 =?us-ascii?Q?y3SnQjFlsOL4P0BYSBk=3D?=
Content-Type: multipart/alternative;
 boundary="_000_CY8PR12MB7435F6FE975BDE1BCD17101C8532ACY8PR12MB7435namp_"
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY8PR12MB7435.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8eeb858f-3a7b-4f17-4c22-08db7f4dcd02
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Jul 2023 00:53:53.1313 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: pU25wIfjmqYaZ1Lrg9TB/S5eoJYw38Iyhsz7qEyGBdgte8JS3X9ZKUyijwWaqLjo
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6651
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

--_000_CY8PR12MB7435F6FE975BDE1BCD17101C8532ACY8PR12MB7435namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Yeah that's an unfortunate mismatch.
Leave it then.  We can always clean it up later if theres a strong preferen=
ce to do so.

Jon

________________________________
From: Huang, JinHuiEric <JinHuiEric.Huang@amd.com>
Sent: Friday, July 7, 2023 8:25 PM
To: Kim, Jonathan <Jonathan.Kim@amd.com>; amd-gfx@lists.freedesktop.org <am=
d-gfx@lists.freedesktop.org>
Subject: Re: [PATCH 1/4] drm/amdkfd: add kfd2kgd debugger callbacks for GC =
v9.4.3

Thanks for your review. The prefix name change will be contradictory that n=
ew functions prefix name is different with existing functions prefix name. =
Are you sure it doesn't matter?

Regards,
Eric

On 2023-07-07 19:52, Kim, Jonathan wrote:
I would change the static prefix names from kgd_gfx_ to kgd_gc_ to match fi=
le name and specify it as the target GC version.

With that fixed and assuming grace period instance fix ups will follow afte=
r, this patch and series is:

Reviewed-by: Jonathan Kim <jonathan.kim@amd.com><mailto:jonathan.kim@amd.co=
m>


________________________________
From: Huang, JinHuiEric <JinHuiEric.Huang@amd.com><mailto:JinHuiEric.Huang@=
amd.com>
Sent: Friday, July 7, 2023 1:46 PM
To: amd-gfx@lists.freedesktop.org<mailto:amd-gfx@lists.freedesktop.org> <am=
d-gfx@lists.freedesktop.org><mailto:amd-gfx@lists.freedesktop.org>
Cc: Kim, Jonathan <Jonathan.Kim@amd.com><mailto:Jonathan.Kim@amd.com>; Kim,=
 Jonathan <Jonathan.Kim@amd.com><mailto:Jonathan.Kim@amd.com>; Huang, JinHu=
iEric <JinHuiEric.Huang@amd.com><mailto:JinHuiEric.Huang@amd.com>
Subject: [PATCH 1/4] drm/amdkfd: add kfd2kgd debugger callbacks for GC v9.4=
.3

From: Jonathan Kim <jonathan.kim@amd.com><mailto:jonathan.kim@amd.com>

Implement the similarities as GC v9.4.2, and the difference
for GC v9.4.3 HW spec, i.e. xcc instance.

Signed-off-by: Jonathan Kim <jonathan.kim@amd.com><mailto:jonathan.kim@amd.=
com>
Signed-off-by: Eric Huang <jinhuieric.huang@amd.com><mailto:jinhuieric.huan=
g@amd.com>
---
 .../drm/amd/amdgpu/amdgpu_amdkfd_aldebaran.c  |   8 +-
 .../drm/amd/amdgpu/amdgpu_amdkfd_aldebaran.h  |  27 +++
 .../drm/amd/amdgpu/amdgpu_amdkfd_gc_9_4_3.c   | 166 +++++++++++++++++-
 .../drm/amd/amdgpu/amdgpu_amdkfd_gfx_v10.c    |   3 +-
 .../drm/amd/amdgpu/amdgpu_amdkfd_gfx_v10.h    |   6 +-
 .../drm/amd/amdgpu/amdgpu_amdkfd_gfx_v11.c    |   3 +-
 .../gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v9.c |   3 +-
 .../gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v9.h |   3 +-
 drivers/gpu/drm/amd/amdkfd/kfd_debug.c        |   3 +-
 .../gpu/drm/amd/include/kgd_kfd_interface.h   |   3 +-
 10 files changed, 213 insertions(+), 12 deletions(-)
 create mode 100644 drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_aldebaran.h

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_aldebaran.c b/drivers=
/gpu/drm/amd/amdgpu/amdgpu_amdkfd_aldebaran.c
index 60f9e027fb66..a06a99c5d311 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_aldebaran.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_aldebaran.c
@@ -23,6 +23,7 @@
 #include "amdgpu_amdkfd.h"
 #include "amdgpu_amdkfd_arcturus.h"
 #include "amdgpu_amdkfd_gfx_v9.h"
+#include "amdgpu_amdkfd_aldebaran.h"
 #include "gc/gc_9_4_2_offset.h"
 #include "gc/gc_9_4_2_sh_mask.h"
 #include <uapi/linux/kfd_ioctl.h>
@@ -36,7 +37,7 @@
  * initialize the debug mode registers after it has disabled GFX off durin=
g the
  * debug session.
  */
-static uint32_t kgd_aldebaran_enable_debug_trap(struct amdgpu_device *adev=
,
+uint32_t kgd_aldebaran_enable_debug_trap(struct amdgpu_device *adev,
                                             bool restore_dbg_registers,
                                             uint32_t vmid)
 {
@@ -107,7 +108,7 @@ static uint32_t kgd_aldebaran_set_wave_launch_trap_over=
ride(struct amdgpu_device
         return data;
 }

-static uint32_t kgd_aldebaran_set_wave_launch_mode(struct amdgpu_device *a=
dev,
+uint32_t kgd_aldebaran_set_wave_launch_mode(struct amdgpu_device *adev,
                                         uint8_t wave_launch_mode,
                                         uint32_t vmid)
 {
@@ -125,7 +126,8 @@ static uint32_t kgd_gfx_aldebaran_set_address_watch(
                                         uint32_t watch_address_mask,
                                         uint32_t watch_id,
                                         uint32_t watch_mode,
-                                       uint32_t debug_vmid)
+                                       uint32_t debug_vmid,
+                                       uint32_t inst )
 {
         uint32_t watch_address_high;
         uint32_t watch_address_low;
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_aldebaran.h b/drivers=
/gpu/drm/amd/amdgpu/amdgpu_amdkfd_aldebaran.h
new file mode 100644
index 000000000000..a7bdaf8d82dd
--- /dev/null
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_aldebaran.h
@@ -0,0 +1,27 @@
+/*
+ * Copyright 2023 Advanced Micro Devices, Inc.
+ *
+ * Permission is hereby granted, free of charge, to any person obtaining a
+ * copy of this software and associated documentation files (the "Software=
"),
+ * to deal in the Software without restriction, including without limitati=
on
+ * the rights to use, copy, modify, merge, publish, distribute, sublicense=
,
+ * and/or sell copies of the Software, and to permit persons to whom the
+ * Software is furnished to do so, subject to the following conditions:
+ *
+ * The above copyright notice and this permission notice shall be included=
 in
+ * all copies or substantial portions of the Software.
+ *
+ * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS=
 OR
+ * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY=
,
+ * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.  IN NO EVENT SHAL=
L
+ * THE COPYRIGHT HOLDER(S) OR AUTHOR(S) BE LIABLE FOR ANY CLAIM, DAMAGES O=
R
+ * OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE,
+ * ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
+ * OTHER DEALINGS IN THE SOFTWARE.
+ */
+uint32_t kgd_aldebaran_enable_debug_trap(struct amdgpu_device *adev,
+                                       bool restore_dbg_registers,
+                                       uint32_t vmid);
+uint32_t kgd_aldebaran_set_wave_launch_mode(struct amdgpu_device *adev,
+                                       uint8_t wave_launch_mode,
+                                       uint32_t vmid);
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gc_9_4_3.c b/drivers/=
gpu/drm/amd/amdgpu/amdgpu_amdkfd_gc_9_4_3.c
index 5b4b7f8b92a5..543405a28b19 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gc_9_4_3.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gc_9_4_3.c
@@ -22,6 +22,7 @@
 #include "amdgpu.h"
 #include "amdgpu_amdkfd.h"
 #include "amdgpu_amdkfd_gfx_v9.h"
+#include "amdgpu_amdkfd_aldebaran.h"
 #include "gc/gc_9_4_3_offset.h"
 #include "gc/gc_9_4_3_sh_mask.h"
 #include "athub/athub_1_8_0_offset.h"
@@ -32,6 +33,7 @@
 #include "soc15.h"
 #include "sdma/sdma_4_4_2_offset.h"
 #include "sdma/sdma_4_4_2_sh_mask.h"
+#include <uapi/linux/kfd_ioctl.h>

 static inline struct v9_sdma_mqd *get_sdma_mqd(void *mqd)
 {
@@ -361,6 +363,156 @@ static int kgd_gfx_v9_4_3_hqd_load(struct amdgpu_devi=
ce *adev, void *mqd,
         return 0;
 }

+/* returns TRAP_EN, EXCP_EN and EXCP_REPLACE. */
+static uint32_t kgd_gfx_v9_4_3_disable_debug_trap(struct amdgpu_device *ad=
ev,
+                                               bool keep_trap_enabled,
+                                               uint32_t vmid)
+{
+       uint32_t data =3D 0;
+
+       data =3D REG_SET_FIELD(data, SPI_GDBG_PER_VMID_CNTL, TRAP_EN, 1);
+       data =3D REG_SET_FIELD(data, SPI_GDBG_PER_VMID_CNTL, EXCP_EN, 0);
+       data =3D REG_SET_FIELD(data, SPI_GDBG_PER_VMID_CNTL, EXCP_REPLACE, =
0);
+
+       return data;
+}
+
+static int kgd_gfx_v9_4_3_validate_trap_override_request(
+                               struct amdgpu_device *adev,
+                               uint32_t trap_override,
+                               uint32_t *trap_mask_supported)
+{
+       *trap_mask_supported &=3D KFD_DBG_TRAP_MASK_FP_INVALID |
+                               KFD_DBG_TRAP_MASK_FP_INPUT_DENORMAL |
+                               KFD_DBG_TRAP_MASK_FP_DIVIDE_BY_ZERO |
+                               KFD_DBG_TRAP_MASK_FP_OVERFLOW |
+                               KFD_DBG_TRAP_MASK_FP_UNDERFLOW |
+                               KFD_DBG_TRAP_MASK_FP_INEXACT |
+                               KFD_DBG_TRAP_MASK_INT_DIVIDE_BY_ZERO |
+                               KFD_DBG_TRAP_MASK_DBG_ADDRESS_WATCH |
+                               KFD_DBG_TRAP_MASK_DBG_MEMORY_VIOLATION |
+                               KFD_DBG_TRAP_MASK_TRAP_ON_WAVE_START |
+                               KFD_DBG_TRAP_MASK_TRAP_ON_WAVE_END;
+
+       if (trap_override !=3D KFD_DBG_TRAP_OVERRIDE_OR &&
+                       trap_override !=3D KFD_DBG_TRAP_OVERRIDE_REPLACE)
+               return -EPERM;
+
+       return 0;
+}
+
+static uint32_t trap_mask_map_sw_to_hw(uint32_t mask)
+{
+       uint32_t trap_on_start =3D (mask & KFD_DBG_TRAP_MASK_TRAP_ON_WAVE_S=
TART) ? 1 : 0;
+       uint32_t trap_on_end =3D (mask & KFD_DBG_TRAP_MASK_TRAP_ON_WAVE_END=
) ? 1 : 0;
+       uint32_t excp_en =3D mask & (KFD_DBG_TRAP_MASK_FP_INVALID |
+                               KFD_DBG_TRAP_MASK_FP_INPUT_DENORMAL |
+                               KFD_DBG_TRAP_MASK_FP_DIVIDE_BY_ZERO |
+                               KFD_DBG_TRAP_MASK_FP_OVERFLOW |
+                               KFD_DBG_TRAP_MASK_FP_UNDERFLOW |
+                               KFD_DBG_TRAP_MASK_FP_INEXACT |
+                               KFD_DBG_TRAP_MASK_INT_DIVIDE_BY_ZERO |
+                               KFD_DBG_TRAP_MASK_DBG_ADDRESS_WATCH |
+                               KFD_DBG_TRAP_MASK_DBG_MEMORY_VIOLATION);
+       uint32_t ret;
+
+       ret =3D REG_SET_FIELD(0, SPI_GDBG_PER_VMID_CNTL, EXCP_EN, excp_en);
+       ret =3D REG_SET_FIELD(ret, SPI_GDBG_PER_VMID_CNTL, TRAP_ON_START, t=
rap_on_start);
+       ret =3D REG_SET_FIELD(ret, SPI_GDBG_PER_VMID_CNTL, TRAP_ON_END, tra=
p_on_end);
+
+       return ret;
+}
+
+static uint32_t trap_mask_map_hw_to_sw(uint32_t mask)
+{
+       uint32_t ret =3D REG_GET_FIELD(mask, SPI_GDBG_PER_VMID_CNTL, EXCP_E=
N);
+
+       if (REG_GET_FIELD(mask, SPI_GDBG_PER_VMID_CNTL, TRAP_ON_START))
+               ret |=3D KFD_DBG_TRAP_MASK_TRAP_ON_WAVE_START;
+
+       if (REG_GET_FIELD(mask, SPI_GDBG_PER_VMID_CNTL, TRAP_ON_END))
+               ret |=3D KFD_DBG_TRAP_MASK_TRAP_ON_WAVE_END;
+
+       return ret;
+}
+
+/* returns TRAP_EN, EXCP_EN and EXCP_REPLACE. */
+static uint32_t kgd_gfx_v9_4_3_set_wave_launch_trap_override(
+                               struct amdgpu_device *adev,
+                               uint32_t vmid,
+                               uint32_t trap_override,
+                               uint32_t trap_mask_bits,
+                               uint32_t trap_mask_request,
+                               uint32_t *trap_mask_prev,
+                               uint32_t kfd_dbg_trap_cntl_prev)
+
+{
+       uint32_t data =3D 0;
+
+       *trap_mask_prev =3D trap_mask_map_hw_to_sw(kfd_dbg_trap_cntl_prev);
+
+       data =3D (trap_mask_bits & trap_mask_request) |
+              (*trap_mask_prev & ~trap_mask_request);
+       data =3D trap_mask_map_sw_to_hw(data);
+
+       data =3D REG_SET_FIELD(data, SPI_GDBG_PER_VMID_CNTL, TRAP_EN, 1);
+       data =3D REG_SET_FIELD(data, SPI_GDBG_PER_VMID_CNTL, EXCP_REPLACE, =
trap_override);
+
+       return data;
+}
+
+#define TCP_WATCH_STRIDE (regTCP_WATCH1_ADDR_H - regTCP_WATCH0_ADDR_H)
+static uint32_t kgd_gfx_v9_4_3_set_address_watch(
+                               struct amdgpu_device *adev,
+                               uint64_t watch_address,
+                               uint32_t watch_address_mask,
+                               uint32_t watch_id,
+                               uint32_t watch_mode,
+                               uint32_t debug_vmid,
+                               uint32_t inst)
+{
+       uint32_t watch_address_high;
+       uint32_t watch_address_low;
+       uint32_t watch_address_cntl;
+
+       watch_address_cntl =3D 0;
+       watch_address_low =3D lower_32_bits(watch_address);
+       watch_address_high =3D upper_32_bits(watch_address) & 0xffff;
+
+       watch_address_cntl =3D REG_SET_FIELD(watch_address_cntl,
+                       TCP_WATCH0_CNTL,
+                       MODE,
+                       watch_mode);
+
+       watch_address_cntl =3D REG_SET_FIELD(watch_address_cntl,
+                       TCP_WATCH0_CNTL,
+                       MASK,
+                       watch_address_mask >> 7);
+
+       watch_address_cntl =3D REG_SET_FIELD(watch_address_cntl,
+                       TCP_WATCH0_CNTL,
+                       VALID,
+                       1);
+
+       WREG32_RLC((SOC15_REG_OFFSET(GC, GET_INST(GC, inst),
+                       regTCP_WATCH0_ADDR_H) +
+                       (watch_id * TCP_WATCH_STRIDE)),
+                       watch_address_high);
+
+       WREG32_RLC((SOC15_REG_OFFSET(GC, GET_INST(GC, inst),
+                       regTCP_WATCH0_ADDR_L) +
+                       (watch_id * TCP_WATCH_STRIDE)),
+                       watch_address_low);
+
+       return watch_address_cntl;
+}
+
+static uint32_t kgd_gfx_v9_4_3_clear_address_watch(struct amdgpu_device *a=
dev,
+                               uint32_t watch_id)
+{
+       return 0;
+}
+
 const struct kfd2kgd_calls gc_9_4_3_kfd2kgd =3D {
         .program_sh_mem_settings =3D kgd_gfx_v9_program_sh_mem_settings,
         .set_pasid_vmid_mapping =3D kgd_gfx_v9_4_3_set_pasid_vmid_mapping,
@@ -380,5 +532,17 @@ const struct kfd2kgd_calls gc_9_4_3_kfd2kgd =3D {
         .set_vm_context_page_table_base =3D
                                 kgd_gfx_v9_set_vm_context_page_table_base,
         .program_trap_handler_settings =3D
-                               kgd_gfx_v9_program_trap_handler_settings
+                               kgd_gfx_v9_program_trap_handler_settings,
+       .build_grace_period_packet_info =3D
+                               kgd_gfx_v9_build_grace_period_packet_info,
+       .get_iq_wait_times =3D kgd_gfx_v9_get_iq_wait_times,
+       .enable_debug_trap =3D kgd_aldebaran_enable_debug_trap,
+       .disable_debug_trap =3D kgd_gfx_v9_4_3_disable_debug_trap,
+       .validate_trap_override_request =3D
+                       kgd_gfx_v9_4_3_validate_trap_override_request,
+       .set_wave_launch_trap_override =3D
+                       kgd_gfx_v9_4_3_set_wave_launch_trap_override,
+       .set_wave_launch_mode =3D kgd_aldebaran_set_wave_launch_mode,
+       .set_address_watch =3D kgd_gfx_v9_4_3_set_address_watch,
+       .clear_address_watch =3D kgd_gfx_v9_4_3_clear_address_watch
 };
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v10.c b/drivers/g=
pu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v10.c
index 8ad7a7779e14..fd42b524a161 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v10.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v10.c
@@ -886,7 +886,8 @@ uint32_t kgd_gfx_v10_set_address_watch(struct amdgpu_de=
vice *adev,
                                         uint32_t watch_address_mask,
                                         uint32_t watch_id,
                                         uint32_t watch_mode,
-                                       uint32_t debug_vmid)
+                                       uint32_t debug_vmid,
+                                       uint32_t inst)
 {
         uint32_t watch_address_high;
         uint32_t watch_address_low;
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v10.h b/drivers/g=
pu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v10.h
index e6b70196071a..306ea176032d 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v10.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v10.h
@@ -44,10 +44,12 @@ uint32_t kgd_gfx_v10_set_address_watch(struct amdgpu_de=
vice *adev,
                                         uint32_t watch_address_mask,
                                         uint32_t watch_id,
                                         uint32_t watch_mode,
-                                       uint32_t debug_vmid);
+                                       uint32_t debug_vmid,
+                                       uint32_t inst);
 uint32_t kgd_gfx_v10_clear_address_watch(struct amdgpu_device *adev,
                                         uint32_t watch_id);
-void kgd_gfx_v10_get_iq_wait_times(struct amdgpu_device *adev, uint32_t *w=
ait_times);
+void kgd_gfx_v10_get_iq_wait_times(struct amdgpu_device *adev,
+                               uint32_t *wait_times);
 void kgd_gfx_v10_build_grace_period_packet_info(struct amdgpu_device *adev=
,
                                                uint32_t wait_times,
                                                uint32_t grace_period,
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v11.c b/drivers/g=
pu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v11.c
index 91c3574ebed3..77ca5cbfb601 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v11.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v11.c
@@ -743,7 +743,8 @@ static uint32_t kgd_gfx_v11_set_address_watch(struct am=
dgpu_device *adev,
                                         uint32_t watch_address_mask,
                                         uint32_t watch_id,
                                         uint32_t watch_mode,
-                                       uint32_t debug_vmid)
+                                       uint32_t debug_vmid,
+                                       uint32_t inst)
 {
         uint32_t watch_address_high;
         uint32_t watch_address_low;
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v9.c b/drivers/gp=
u/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v9.c
index 51d93fb13ea3..bb496e818d52 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v9.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v9.c
@@ -822,7 +822,8 @@ uint32_t kgd_gfx_v9_set_address_watch(struct amdgpu_dev=
ice *adev,
                                         uint32_t watch_address_mask,
                                         uint32_t watch_id,
                                         uint32_t watch_mode,
-                                       uint32_t debug_vmid)
+                                       uint32_t debug_vmid,
+                                       uint32_t inst)
 {
         uint32_t watch_address_high;
         uint32_t watch_address_low;
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v9.h b/drivers/gp=
u/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v9.h
index 5f54bff0db49..4e8aa0432e8b 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v9.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v9.h
@@ -89,7 +89,8 @@ uint32_t kgd_gfx_v9_set_address_watch(struct amdgpu_devic=
e *adev,
                                         uint32_t watch_address_mask,
                                         uint32_t watch_id,
                                         uint32_t watch_mode,
-                                       uint32_t debug_vmid);
+                                       uint32_t debug_vmid,
+                                       uint32_t inst);
 uint32_t kgd_gfx_v9_clear_address_watch(struct amdgpu_device *adev,
                                         uint32_t watch_id);
 void kgd_gfx_v9_get_iq_wait_times(struct amdgpu_device *adev, uint32_t *wa=
it_times);
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_debug.c b/drivers/gpu/drm/amd/a=
mdkfd/kfd_debug.c
index fff3ccc04fa9..24083db44724 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_debug.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_debug.c
@@ -466,7 +466,8 @@ int kfd_dbg_trap_set_dev_address_watch(struct kfd_proce=
ss_device *pdd,
                                 watch_address_mask,
                                 *watch_id,
                                 watch_mode,
-                               pdd->dev->vm_info.last_vmid_kfd);
+                               pdd->dev->vm_info.last_vmid_kfd,
+                               0);
         amdgpu_gfx_off_ctrl(pdd->dev->adev, true);

         if (!pdd->dev->kfd->shared_resources.enable_mes)
diff --git a/drivers/gpu/drm/amd/include/kgd_kfd_interface.h b/drivers/gpu/=
drm/amd/include/kgd_kfd_interface.h
index d0df3381539f..30d91d2ffe4c 100644
--- a/drivers/gpu/drm/amd/include/kgd_kfd_interface.h
+++ b/drivers/gpu/drm/amd/include/kgd_kfd_interface.h
@@ -315,7 +315,8 @@ struct kfd2kgd_calls {
                                         uint32_t watch_address_mask,
                                         uint32_t watch_id,
                                         uint32_t watch_mode,
-                                       uint32_t debug_vmid);
+                                       uint32_t debug_vmid,
+                                       uint32_t inst);
         uint32_t (*clear_address_watch)(struct amdgpu_device *adev,
                         uint32_t watch_id);
         void (*get_iq_wait_times)(struct amdgpu_device *adev,
--
2.34.1



--_000_CY8PR12MB7435F6FE975BDE1BCD17101C8532ACY8PR12MB7435namp_
Content-Type: text/html; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<html>
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Dus-ascii"=
>
</head>
<body>
<div>Yeah that's an unfortunate mismatch.</div>
<div>Leave it then.&nbsp; We can always clean it up later if theres a stron=
g preference to do so.</div>
<div><br>
</div>
<div>Jon</div>
<br>
<hr style=3D"display:inline-block;width:98%" tabindex=3D"-1">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" st=
yle=3D"font-size:11pt" color=3D"#000000"><b>From:</b> Huang, JinHuiEric &lt=
;JinHuiEric.Huang@amd.com&gt;<br>
<b>Sent:</b> Friday, July 7, 2023 8:25 PM<br>
<b>To:</b> Kim, Jonathan &lt;Jonathan.Kim@amd.com&gt;; amd-gfx@lists.freede=
sktop.org &lt;amd-gfx@lists.freedesktop.org&gt;<br>
<b>Subject:</b> Re: [PATCH 1/4] drm/amdkfd: add kfd2kgd debugger callbacks =
for GC v9.4.3</font>
<div>&nbsp;</div>
</div>
<div>Thanks for your review. The prefix name change will be contradictory t=
hat new functions prefix name is different with existing functions prefix n=
ame. Are you sure it doesn't matter?<br>
<br>
Regards,<br>
Eric<br>
<br>
<div class=3D"x_moz-cite-prefix">On 2023-07-07 19:52, Kim, Jonathan wrote:<=
br>
</div>
<blockquote type=3D"cite">
<div>I would change the static prefix names from kgd_gfx_ to kgd_gc_ to mat=
ch file name and specify it as the target GC version.</div>
<div><br>
</div>
<div>With that fixed and assuming grace period instance fix ups will follow=
 after, this patch and series is:</div>
<div><br>
</div>
<div>Reviewed-by: Jonathan Kim <a class=3D"x_moz-txt-link-rfc2396E" href=3D=
"mailto:jonathan.kim@amd.com">
&lt;jonathan.kim@amd.com&gt;</a></div>
<br>
<br>
<hr tabindex=3D"-1" style=3D"display:inline-block; width:98%">
<div id=3D"x_divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" =
color=3D"#000000" style=3D"font-size:11pt"><b>From:</b> Huang, JinHuiEric
<a class=3D"x_moz-txt-link-rfc2396E" href=3D"mailto:JinHuiEric.Huang@amd.co=
m">&lt;JinHuiEric.Huang@amd.com&gt;</a><br>
<b>Sent:</b> Friday, July 7, 2023 1:46 PM<br>
<b>To:</b> <a class=3D"x_moz-txt-link-abbreviated" href=3D"mailto:amd-gfx@l=
ists.freedesktop.org">
amd-gfx@lists.freedesktop.org</a> <a class=3D"x_moz-txt-link-rfc2396E" href=
=3D"mailto:amd-gfx@lists.freedesktop.org">
&lt;amd-gfx@lists.freedesktop.org&gt;</a><br>
<b>Cc:</b> Kim, Jonathan <a class=3D"x_moz-txt-link-rfc2396E" href=3D"mailt=
o:Jonathan.Kim@amd.com">
&lt;Jonathan.Kim@amd.com&gt;</a>; Kim, Jonathan <a class=3D"x_moz-txt-link-=
rfc2396E" href=3D"mailto:Jonathan.Kim@amd.com">
&lt;Jonathan.Kim@amd.com&gt;</a>; Huang, JinHuiEric <a class=3D"x_moz-txt-l=
ink-rfc2396E" href=3D"mailto:JinHuiEric.Huang@amd.com">
&lt;JinHuiEric.Huang@amd.com&gt;</a><br>
<b>Subject:</b> [PATCH 1/4] drm/amdkfd: add kfd2kgd debugger callbacks for =
GC v9.4.3</font>
<div>&nbsp;</div>
</div>
<div class=3D"x_BodyFragment"><font size=3D"2"><span style=3D"font-size:11p=
t">
<div class=3D"x_PlainText">From: Jonathan Kim <a class=3D"x_moz-txt-link-rf=
c2396E" href=3D"mailto:jonathan.kim@amd.com">
&lt;jonathan.kim@amd.com&gt;</a><br>
<br>
Implement the similarities as GC v9.4.2, and the difference<br>
for GC v9.4.3 HW spec, i.e. xcc instance.<br>
<br>
Signed-off-by: Jonathan Kim <a class=3D"x_moz-txt-link-rfc2396E" href=3D"ma=
ilto:jonathan.kim@amd.com">
&lt;jonathan.kim@amd.com&gt;</a><br>
Signed-off-by: Eric Huang <a class=3D"x_moz-txt-link-rfc2396E" href=3D"mail=
to:jinhuieric.huang@amd.com">
&lt;jinhuieric.huang@amd.com&gt;</a><br>
---<br>
&nbsp;.../drm/amd/amdgpu/amdgpu_amdkfd_aldebaran.c&nbsp; |&nbsp;&nbsp; 8 +-=
<br>
&nbsp;.../drm/amd/amdgpu/amdgpu_amdkfd_aldebaran.h&nbsp; |&nbsp; 27 +++<br>
&nbsp;.../drm/amd/amdgpu/amdgpu_amdkfd_gc_9_4_3.c&nbsp;&nbsp; | 166 +++++++=
++++++++++-<br>
&nbsp;.../drm/amd/amdgpu/amdgpu_amdkfd_gfx_v10.c&nbsp;&nbsp;&nbsp; |&nbsp;&=
nbsp; 3 +-<br>
&nbsp;.../drm/amd/amdgpu/amdgpu_amdkfd_gfx_v10.h&nbsp;&nbsp;&nbsp; |&nbsp;&=
nbsp; 6 +-<br>
&nbsp;.../drm/amd/amdgpu/amdgpu_amdkfd_gfx_v11.c&nbsp;&nbsp;&nbsp; |&nbsp;&=
nbsp; 3 +-<br>
&nbsp;.../gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v9.c |&nbsp;&nbsp; 3 +-<br>
&nbsp;.../gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v9.h |&nbsp;&nbsp; 3 +-<br>
&nbsp;drivers/gpu/drm/amd/amdkfd/kfd_debug.c&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp; |&nbsp;&nbsp; 3 +-<br>
&nbsp;.../gpu/drm/amd/include/kgd_kfd_interface.h&nbsp;&nbsp; |&nbsp;&nbsp;=
 3 +-<br>
&nbsp;10 files changed, 213 insertions(+), 12 deletions(-)<br>
&nbsp;create mode 100644 drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_aldebaran=
.h<br>
<br>
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_aldebaran.c b/drivers=
/gpu/drm/amd/amdgpu/amdgpu_amdkfd_aldebaran.c<br>
index 60f9e027fb66..a06a99c5d311 100644<br>
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_aldebaran.c<br>
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_aldebaran.c<br>
@@ -23,6 +23,7 @@<br>
&nbsp;#include &quot;amdgpu_amdkfd.h&quot;<br>
&nbsp;#include &quot;amdgpu_amdkfd_arcturus.h&quot;<br>
&nbsp;#include &quot;amdgpu_amdkfd_gfx_v9.h&quot;<br>
+#include &quot;amdgpu_amdkfd_aldebaran.h&quot;<br>
&nbsp;#include &quot;gc/gc_9_4_2_offset.h&quot;<br>
&nbsp;#include &quot;gc/gc_9_4_2_sh_mask.h&quot;<br>
&nbsp;#include &lt;uapi/linux/kfd_ioctl.h&gt;<br>
@@ -36,7 +37,7 @@<br>
&nbsp; * initialize the debug mode registers after it has disabled GFX off =
during the<br>
&nbsp; * debug session.<br>
&nbsp; */<br>
-static uint32_t kgd_aldebaran_enable_debug_trap(struct amdgpu_device *adev=
,<br>
+uint32_t kgd_aldebaran_enable_debug_trap(struct amdgpu_device *adev,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; bool restore_dbg_registers,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t vmid)<br>
&nbsp;{<br>
@@ -107,7 +108,7 @@ static uint32_t kgd_aldebaran_set_wave_launch_trap_over=
ride(struct amdgpu_device<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return data;<br>
&nbsp;}<br>
&nbsp;<br>
-static uint32_t kgd_aldebaran_set_wave_launch_mode(struct amdgpu_device *a=
dev,<br>
+uint32_t kgd_aldebaran_set_wave_launch_mode(struct amdgpu_device *adev,<br=
>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; uint8_t wave_launch_mode,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; uint32_t vmid)<br>
&nbsp;{<br>
@@ -125,7 +126,8 @@ static uint32_t kgd_gfx_aldebaran_set_address_watch(<br=
>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; uint32_t watch_address_mask,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; uint32_t watch_id,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; uint32_t watch_mode,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp; uint32_t debug_vmid)<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp; uint32_t debug_vmid,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp; uint32_t inst )<br>
&nbsp;{<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t watch_address_hig=
h;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t watch_address_low=
;<br>
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_aldebaran.h b/drivers=
/gpu/drm/amd/amdgpu/amdgpu_amdkfd_aldebaran.h<br>
new file mode 100644<br>
index 000000000000..a7bdaf8d82dd<br>
--- /dev/null<br>
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_aldebaran.h<br>
@@ -0,0 +1,27 @@<br>
+/*<br>
+ * Copyright 2023 Advanced Micro Devices, Inc.<br>
+ *<br>
+ * Permission is hereby granted, free of charge, to any person obtaining a=
<br>
+ * copy of this software and associated documentation files (the &quot;Sof=
tware&quot;),<br>
+ * to deal in the Software without restriction, including without limitati=
on<br>
+ * the rights to use, copy, modify, merge, publish, distribute, sublicense=
,<br>
+ * and/or sell copies of the Software, and to permit persons to whom the<b=
r>
+ * Software is furnished to do so, subject to the following conditions:<br=
>
+ *<br>
+ * The above copyright notice and this permission notice shall be included=
 in<br>
+ * all copies or substantial portions of the Software.<br>
+ *<br>
+ * THE SOFTWARE IS PROVIDED &quot;AS IS&quot;, WITHOUT WARRANTY OF ANY KIN=
D, EXPRESS OR<br>
+ * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY=
,<br>
+ * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.&nbsp; IN NO EVENT=
 SHALL<br>
+ * THE COPYRIGHT HOLDER(S) OR AUTHOR(S) BE LIABLE FOR ANY CLAIM, DAMAGES O=
R<br>
+ * OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE,<b=
r>
+ * ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR<b=
r>
+ * OTHER DEALINGS IN THE SOFTWARE.<br>
+ */<br>
+uint32_t kgd_aldebaran_enable_debug_trap(struct amdgpu_device *adev,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp; bool restore_dbg_registers,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp; uint32_t vmid);<br>
+uint32_t kgd_aldebaran_set_wave_launch_mode(struct amdgpu_device *adev,<br=
>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp; uint8_t wave_launch_mode,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp; uint32_t vmid);<br>
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gc_9_4_3.c b/drivers/=
gpu/drm/amd/amdgpu/amdgpu_amdkfd_gc_9_4_3.c<br>
index 5b4b7f8b92a5..543405a28b19 100644<br>
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gc_9_4_3.c<br>
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gc_9_4_3.c<br>
@@ -22,6 +22,7 @@<br>
&nbsp;#include &quot;amdgpu.h&quot;<br>
&nbsp;#include &quot;amdgpu_amdkfd.h&quot;<br>
&nbsp;#include &quot;amdgpu_amdkfd_gfx_v9.h&quot;<br>
+#include &quot;amdgpu_amdkfd_aldebaran.h&quot;<br>
&nbsp;#include &quot;gc/gc_9_4_3_offset.h&quot;<br>
&nbsp;#include &quot;gc/gc_9_4_3_sh_mask.h&quot;<br>
&nbsp;#include &quot;athub/athub_1_8_0_offset.h&quot;<br>
@@ -32,6 +33,7 @@<br>
&nbsp;#include &quot;soc15.h&quot;<br>
&nbsp;#include &quot;sdma/sdma_4_4_2_offset.h&quot;<br>
&nbsp;#include &quot;sdma/sdma_4_4_2_sh_mask.h&quot;<br>
+#include &lt;uapi/linux/kfd_ioctl.h&gt;<br>
&nbsp;<br>
&nbsp;static inline struct v9_sdma_mqd *get_sdma_mqd(void *mqd)<br>
&nbsp;{<br>
@@ -361,6 +363,156 @@ static int kgd_gfx_v9_4_3_hqd_load(struct amdgpu_devi=
ce *adev, void *mqd,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return 0;<br>
&nbsp;}<br>
&nbsp;<br>
+/* returns TRAP_EN, EXCP_EN and EXCP_REPLACE. */<br>
+static uint32_t kgd_gfx_v9_4_3_disable_debug_trap(struct amdgpu_device *ad=
ev,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; bool keep_trap_enabled=
,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t vmid)<br>
+{<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t data =3D 0;<br>
+<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; data =3D REG_SET_FIELD(data, SPI_GDBG=
_PER_VMID_CNTL, TRAP_EN, 1);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; data =3D REG_SET_FIELD(data, SPI_GDBG=
_PER_VMID_CNTL, EXCP_EN, 0);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; data =3D REG_SET_FIELD(data, SPI_GDBG=
_PER_VMID_CNTL, EXCP_REPLACE, 0);<br>
+<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return data;<br>
+}<br>
+<br>
+static int kgd_gfx_v9_4_3_validate_trap_override_request(<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_device *adev,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t trap_override,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t *trap_mask_supported)<br>
+{<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; *trap_mask_supported &amp;=3D KFD_DBG=
_TRAP_MASK_FP_INVALID |<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; KFD_DBG_TRAP_MASK_FP_INPUT_DENORMAL |<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; KFD_DBG_TRAP_MASK_FP_DIVIDE_BY_ZERO |<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; KFD_DBG_TRAP_MASK_FP_OVERFLOW |<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; KFD_DBG_TRAP_MASK_FP_UNDERFLOW |<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; KFD_DBG_TRAP_MASK_FP_INEXACT |<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; KFD_DBG_TRAP_MASK_INT_DIVIDE_BY_ZERO |<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; KFD_DBG_TRAP_MASK_DBG_ADDRESS_WATCH |<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; KFD_DBG_TRAP_MASK_DBG_MEMORY_VIOLATION |<br=
>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; KFD_DBG_TRAP_MASK_TRAP_ON_WAVE_START |<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; KFD_DBG_TRAP_MASK_TRAP_ON_WAVE_END;<br>
+<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (trap_override !=3D KFD_DBG_TRAP_O=
VERRIDE_OR &amp;&amp;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; trap_override !=
=3D KFD_DBG_TRAP_OVERRIDE_REPLACE)<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; return -EPERM;<br>
+<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return 0;<br>
+}<br>
+<br>
+static uint32_t trap_mask_map_sw_to_hw(uint32_t mask)<br>
+{<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t trap_on_start =3D (mask &amp=
; KFD_DBG_TRAP_MASK_TRAP_ON_WAVE_START) ? 1 : 0;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t trap_on_end =3D (mask &amp; =
KFD_DBG_TRAP_MASK_TRAP_ON_WAVE_END) ? 1 : 0;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t excp_en =3D mask &amp; (KFD_=
DBG_TRAP_MASK_FP_INVALID |<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; KFD_DBG_TRAP_MASK_FP_INPUT_DENORMAL |<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; KFD_DBG_TRAP_MASK_FP_DIVIDE_BY_ZERO |<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; KFD_DBG_TRAP_MASK_FP_OVERFLOW |<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; KFD_DBG_TRAP_MASK_FP_UNDERFLOW |<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; KFD_DBG_TRAP_MASK_FP_INEXACT |<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; KFD_DBG_TRAP_MASK_INT_DIVIDE_BY_ZERO |<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; KFD_DBG_TRAP_MASK_DBG_ADDRESS_WATCH |<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; KFD_DBG_TRAP_MASK_DBG_MEMORY_VIOLATION);<br=
>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t ret;<br>
+<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ret =3D REG_SET_FIELD(0, SPI_GDBG_PER=
_VMID_CNTL, EXCP_EN, excp_en);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ret =3D REG_SET_FIELD(ret, SPI_GDBG_P=
ER_VMID_CNTL, TRAP_ON_START, trap_on_start);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ret =3D REG_SET_FIELD(ret, SPI_GDBG_P=
ER_VMID_CNTL, TRAP_ON_END, trap_on_end);<br>
+<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return ret;<br>
+}<br>
+<br>
+static uint32_t trap_mask_map_hw_to_sw(uint32_t mask)<br>
+{<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t ret =3D REG_GET_FIELD(mask, =
SPI_GDBG_PER_VMID_CNTL, EXCP_EN);<br>
+<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (REG_GET_FIELD(mask, SPI_GDBG_PER_=
VMID_CNTL, TRAP_ON_START))<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; ret |=3D KFD_DBG_TRAP_MASK_TRAP_ON_WAVE_START;<br>
+<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (REG_GET_FIELD(mask, SPI_GDBG_PER_=
VMID_CNTL, TRAP_ON_END))<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; ret |=3D KFD_DBG_TRAP_MASK_TRAP_ON_WAVE_END;<br>
+<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return ret;<br>
+}<br>
+<br>
+/* returns TRAP_EN, EXCP_EN and EXCP_REPLACE. */<br>
+static uint32_t kgd_gfx_v9_4_3_set_wave_launch_trap_override(<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_device *adev,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t vmid,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t trap_override,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t trap_mask_bits,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t trap_mask_request,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t *trap_mask_prev,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t kfd_dbg_trap_cntl_prev)<br>
+<br>
+{<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t data =3D 0;<br>
+<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; *trap_mask_prev =3D trap_mask_map_hw_=
to_sw(kfd_dbg_trap_cntl_prev);<br>
+<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; data =3D (trap_mask_bits &amp; trap_m=
ask_request) |<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp; (*trap_mask_prev &amp; ~trap_mask_request);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; data =3D trap_mask_map_sw_to_hw(data)=
;<br>
+<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; data =3D REG_SET_FIELD(data, SPI_GDBG=
_PER_VMID_CNTL, TRAP_EN, 1);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; data =3D REG_SET_FIELD(data, SPI_GDBG=
_PER_VMID_CNTL, EXCP_REPLACE, trap_override);<br>
+<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return data;<br>
+}<br>
+<br>
+#define TCP_WATCH_STRIDE (regTCP_WATCH1_ADDR_H - regTCP_WATCH0_ADDR_H)<br>
+static uint32_t kgd_gfx_v9_4_3_set_address_watch(<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_device *adev,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint64_t watch_address,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t watch_address_mask,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t watch_id,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t watch_mode,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t debug_vmid,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t inst)<br>
+{<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t watch_address_high;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t watch_address_low;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t watch_address_cntl;<br>
+<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; watch_address_cntl =3D 0;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; watch_address_low =3D lower_32_bits(w=
atch_address);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; watch_address_high =3D upper_32_bits(=
watch_address) &amp; 0xffff;<br>
+<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; watch_address_cntl =3D REG_SET_FIELD(=
watch_address_cntl,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; TCP_WATCH0_CNTL,=
<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; MODE,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; watch_mode);<br>
+<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; watch_address_cntl =3D REG_SET_FIELD(=
watch_address_cntl,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; TCP_WATCH0_CNTL,=
<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; MASK,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; watch_address_ma=
sk &gt;&gt; 7);<br>
+<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; watch_address_cntl =3D REG_SET_FIELD(=
watch_address_cntl,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; TCP_WATCH0_CNTL,=
<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; VALID,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 1);<br>
+<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; WREG32_RLC((SOC15_REG_OFFSET(GC, GET_=
INST(GC, inst),<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; regTCP_WATCH0_AD=
DR_H) +<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; (watch_id * TCP_=
WATCH_STRIDE)),<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; watch_address_hi=
gh);<br>
+<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; WREG32_RLC((SOC15_REG_OFFSET(GC, GET_=
INST(GC, inst),<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; regTCP_WATCH0_AD=
DR_L) +<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; (watch_id * TCP_=
WATCH_STRIDE)),<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; watch_address_lo=
w);<br>
+<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return watch_address_cntl;<br>
+}<br>
+<br>
+static uint32_t kgd_gfx_v9_4_3_clear_address_watch(struct amdgpu_device *a=
dev,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t watch_id)<br>
+{<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return 0;<br>
+}<br>
+<br>
&nbsp;const struct kfd2kgd_calls gc_9_4_3_kfd2kgd =3D {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .program_sh_mem_settings =
=3D kgd_gfx_v9_program_sh_mem_settings,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .set_pasid_vmid_mapping =
=3D kgd_gfx_v9_4_3_set_pasid_vmid_mapping,<br>
@@ -380,5 +532,17 @@ const struct kfd2kgd_calls gc_9_4_3_kfd2kgd =3D {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .set_vm_context_page_table=
_base =3D<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; kgd_gfx_v9_set_vm_context_page_t=
able_base,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .program_trap_handler_sett=
ings =3D<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; kgd_gfx_v9_program_trap_handler_settings<br=
>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; kgd_gfx_v9_program_trap_handler_settings,<b=
r>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .build_grace_period_packet_info =3D<b=
r>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; kgd_gfx_v9_build_grace_period_packet_info,<=
br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .get_iq_wait_times =3D kgd_gfx_v9_get=
_iq_wait_times,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .enable_debug_trap =3D kgd_aldebaran_=
enable_debug_trap,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .disable_debug_trap =3D kgd_gfx_v9_4_=
3_disable_debug_trap,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .validate_trap_override_request =3D<b=
r>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; kgd_gfx_v9_4_3_v=
alidate_trap_override_request,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .set_wave_launch_trap_override =3D<br=
>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; kgd_gfx_v9_4_3_s=
et_wave_launch_trap_override,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .set_wave_launch_mode =3D kgd_aldebar=
an_set_wave_launch_mode,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .set_address_watch =3D kgd_gfx_v9_4_3=
_set_address_watch,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .clear_address_watch =3D kgd_gfx_v9_4=
_3_clear_address_watch<br>
&nbsp;};<br>
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v10.c b/drivers/g=
pu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v10.c<br>
index 8ad7a7779e14..fd42b524a161 100644<br>
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v10.c<br>
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v10.c<br>
@@ -886,7 +886,8 @@ uint32_t kgd_gfx_v10_set_address_watch(struct amdgpu_de=
vice *adev,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; uint32_t watch_address_mask,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; uint32_t watch_id,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; uint32_t watch_mode,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp; uint32_t debug_vmid)<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp; uint32_t debug_vmid,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp; uint32_t inst)<br>
&nbsp;{<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t watch_address_hig=
h;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t watch_address_low=
;<br>
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v10.h b/drivers/g=
pu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v10.h<br>
index e6b70196071a..306ea176032d 100644<br>
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v10.h<br>
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v10.h<br>
@@ -44,10 +44,12 @@ uint32_t kgd_gfx_v10_set_address_watch(struct amdgpu_de=
vice *adev,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; uint32_t watch_address_mask,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; uint32_t watch_id,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; uint32_t watch_mode,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp; uint32_t debug_vmid);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp; uint32_t debug_vmid,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp; uint32_t inst);<br>
&nbsp;uint32_t kgd_gfx_v10_clear_address_watch(struct amdgpu_device *adev,<=
br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; uint32_t watch_id);<br>
-void kgd_gfx_v10_get_iq_wait_times(struct amdgpu_device *adev, uint32_t *w=
ait_times);<br>
+void kgd_gfx_v10_get_iq_wait_times(struct amdgpu_device *adev,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t *wait_times);<br>
&nbsp;void kgd_gfx_v10_build_grace_period_packet_info(struct amdgpu_device =
*adev,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t wait_tim=
es,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t grace_pe=
riod,<br>
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v11.c b/drivers/g=
pu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v11.c<br>
index 91c3574ebed3..77ca5cbfb601 100644<br>
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v11.c<br>
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v11.c<br>
@@ -743,7 +743,8 @@ static uint32_t kgd_gfx_v11_set_address_watch(struct am=
dgpu_device *adev,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; uint32_t watch_address_mask,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; uint32_t watch_id,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; uint32_t watch_mode,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp; uint32_t debug_vmid)<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp; uint32_t debug_vmid,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp; uint32_t inst)<br>
&nbsp;{<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t watch_address_hig=
h;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t watch_address_low=
;<br>
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v9.c b/drivers/gp=
u/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v9.c<br>
index 51d93fb13ea3..bb496e818d52 100644<br>
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v9.c<br>
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v9.c<br>
@@ -822,7 +822,8 @@ uint32_t kgd_gfx_v9_set_address_watch(struct amdgpu_dev=
ice *adev,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; uint32_t watch_address_mask,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; uint32_t watch_id,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; uint32_t watch_mode,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp; uint32_t debug_vmid)<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp; uint32_t debug_vmid,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp; uint32_t inst)<br>
&nbsp;{<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t watch_address_hig=
h;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t watch_address_low=
;<br>
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v9.h b/drivers/gp=
u/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v9.h<br>
index 5f54bff0db49..4e8aa0432e8b 100644<br>
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v9.h<br>
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v9.h<br>
@@ -89,7 +89,8 @@ uint32_t kgd_gfx_v9_set_address_watch(struct amdgpu_devic=
e *adev,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; uint32_t watch_address_mask,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; uint32_t watch_id,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; uint32_t watch_mode,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp; uint32_t debug_vmid);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp; uint32_t debug_vmid,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp; uint32_t inst);<br>
&nbsp;uint32_t kgd_gfx_v9_clear_address_watch(struct amdgpu_device *adev,<b=
r>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; uint32_t watch_id);<br>
&nbsp;void kgd_gfx_v9_get_iq_wait_times(struct amdgpu_device *adev, uint32_=
t *wait_times);<br>
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_debug.c b/drivers/gpu/drm/amd/a=
mdkfd/kfd_debug.c<br>
index fff3ccc04fa9..24083db44724 100644<br>
--- a/drivers/gpu/drm/amd/amdkfd/kfd_debug.c<br>
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_debug.c<br>
@@ -466,7 +466,8 @@ int kfd_dbg_trap_set_dev_address_watch(struct kfd_proce=
ss_device *pdd,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; watch_address_mask,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; *watch_id,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; watch_mode,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; pdd-&gt;dev-&gt;vm_info.last_vmid_kfd);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; pdd-&gt;dev-&gt;vm_info.last_vmid_kfd,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_gfx_off_ctrl(pdd-&g=
t;dev-&gt;adev, true);<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!pdd-&gt;dev-&gt;kfd-&=
gt;shared_resources.enable_mes)<br>
diff --git a/drivers/gpu/drm/amd/include/kgd_kfd_interface.h b/drivers/gpu/=
drm/amd/include/kgd_kfd_interface.h<br>
index d0df3381539f..30d91d2ffe4c 100644<br>
--- a/drivers/gpu/drm/amd/include/kgd_kfd_interface.h<br>
+++ b/drivers/gpu/drm/amd/include/kgd_kfd_interface.h<br>
@@ -315,7 +315,8 @@ struct kfd2kgd_calls {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; uint32_t watch_address_mask,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; uint32_t watch_id,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; uint32_t watch_mode,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp; uint32_t debug_vmid);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp; uint32_t debug_vmid,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp; uint32_t inst);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t (*clear_address_w=
atch)(struct amdgpu_device *adev,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint3=
2_t watch_id);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; void (*get_iq_wait_times)(=
struct amdgpu_device *adev,<br>
-- <br>
2.34.1<br>
<br>
</div>
</span></font></div>
</blockquote>
<br>
</div>
</body>
</html>

--_000_CY8PR12MB7435F6FE975BDE1BCD17101C8532ACY8PR12MB7435namp_--
