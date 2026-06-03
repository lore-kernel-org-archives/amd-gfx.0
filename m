Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 01088CD6E55
	for <amd-gfx@archiver.kernel.org>; Wed,  3 Jun 2026 12:55:59 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8497710FD91;
	Wed,  3 Jun 2026 12:55:59 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="wWUZrMCF";
	dkim-atps=neutral
Received: from CO1PR03CU002.outbound.protection.outlook.com
 (mail-westus2azon11010062.outbound.protection.outlook.com [52.101.46.62])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 51ABA10FD91
 for <amd-gfx@lists.freedesktop.org>; Wed,  3 Jun 2026 12:55:58 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=X8ttWX4Uv5xQDwK3LoQ4V63LsA2VRHVZDxJkyTZ2hR6/TjQ/YXUdgTXqm4ToCSyWcPtTgc80lMDmJxbIHiLOWr64ySMLRF3K86EmoPQuRHmQft1cv2pDap0RlVfCG2qOSXCEwXNU3uzc/tj/JKjd5eke0eiqI/ASZ0gx8dskxc4W4qQjWFU9USC016kmHfip94KVaFJyaxX+RNhHv5B5bisaJza195/Z8Y0DpEFwTOBdHRiMjkeFN9SrS0IOLy9lNhRWOHQGfiE9InCvJSVc2TDHo2NxQMGyuawXEcaAqYOGPNyo5pTbkwA1w/Seiw9feQLhlxCvVp6dTkSP4MQ10g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=H8r3HrAuvkjimePQF9pNPZ0e3o/5Du2u1iOJPWOZhFM=;
 b=sXIYQi9msJSCypYoeWiXP8SQOFnfTv1NUSaFvjSMwfzDPux51di3oqmLV8EUNN35oVRQzaP55RLW6hnLaKR+m/4ZMbnOaSFbH0wsHc0cqmFzJl/sP2L2zXvEzI0qYkD3kzuM9SJKGLDizAGVROFd6YXuYL/c+D+4omg1h7W2Gu/Q5tzYb1icqh/1K0ap6K+YFIBjWCuzDlNhZb5XOOfLxkrPgXL7PWs1f4K/FSXDzLg2vTaOfLoF11N47kzHhG3Eanb/rFvbIRgkq7EDIY96HpVVPnWg7o1Qaa3pN/2JYh+2rvY4RMqZDshl7r84JACxDPP3GFBhYh+Fc3CIHgVSnQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=H8r3HrAuvkjimePQF9pNPZ0e3o/5Du2u1iOJPWOZhFM=;
 b=wWUZrMCFvEWlHwOGh+8jL29I6XWeroOBmDDAEEIJYvWyUMXVy0LNVqAP6KIwxSTJ/spCFHAd2E4AAwkGLp76qVKdR8b1mv/U8qoA+/pbEBgw1ECrXpBGn7xi0dHeoPIDtFV7Nccx7YO9I6ia3NhoPoZYJqmvvxBUpXellAr7uQE=
Received: from DM4PR12MB5038.namprd12.prod.outlook.com (2603:10b6:5:389::18)
 by PH0PR12MB8099.namprd12.prod.outlook.com (2603:10b6:510:29d::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.7; Wed, 3 Jun 2026
 12:55:55 +0000
Received: from DM4PR12MB5038.namprd12.prod.outlook.com
 ([fe80::3c29:3d93:2028:85c4]) by DM4PR12MB5038.namprd12.prod.outlook.com
 ([fe80::3c29:3d93:2028:85c4%6]) with mapi id 15.21.0092.006; Wed, 3 Jun 2026
 12:55:55 +0000
From: "Kamal, Asad" <Asad.Kamal@amd.com>
To: "StDenis, Tom" <Tom.StDenis@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
CC: "Lazar, Lijo" <Lijo.Lazar@amd.com>, "Zhang, Hawking"
 <Hawking.Zhang@amd.com>, "Ma, Le" <Le.Ma@amd.com>, "Zhang, Morris"
 <Shiwu.Zhang@amd.com>, "Deucher, Alexander" <Alexander.Deucher@amd.com>,
 "Wang, Yang(Kevin)" <KevinYang.Wang@amd.com>
Subject: RE: [PATCH v3] drm/amdgpu: Gate debugfs MMIO access on kernel lockdown
Thread-Topic: [PATCH v3] drm/amdgpu: Gate debugfs MMIO access on kernel
 lockdown
Thread-Index: AQHc805zEVVWuGKc8EiTSYUHqImhnrYswr8AgAAGykA=
Date: Wed, 3 Jun 2026 12:55:54 +0000
Message-ID: <DM4PR12MB5038DCB4BFE6DB4689682CBC8E132@DM4PR12MB5038.namprd12.prod.outlook.com>
References: <20260603114459.938031-1-asad.kamal@amd.com>
 <DS0PR12MB7993177B829CF9CCE0BA7DFEF7132@DS0PR12MB7993.namprd12.prod.outlook.com>
In-Reply-To: <DS0PR12MB7993177B829CF9CCE0BA7DFEF7132@DS0PR12MB7993.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Enabled=True;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SetDate=2026-06-03T12:29:54.4210000Z;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Name=AMD
 General; MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_ContentBits=3;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Method=Standard
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM4PR12MB5038:EE_|PH0PR12MB8099:EE_
x-ms-office365-filtering-correlation-id: d807e6f6-8a21-4ed3-9991-08dec16f732c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|376014|366016|56012099006|4143699003|3023799007|11063799006|22082099003|38070700021|18002099003;
x-microsoft-antispam-message-info: 6Uhs8EMuN2OpqkP/ITMELSuUf9K5GwfH+A6Fj3CU2o/+ryhoN5nzBAS/4jLOLCxuDw/xMEc6TxXDir9jRpyhrZAYEtuwyAbOHn/M+xjSk+pSx016gUpV/LqskSRd3Y8nAKFsfvkWAa9KdpwXYvJsvtQpxwlSvvpgwnPcJYt62S3n8NNTP2ZDn6c6qlJAiHcw9cMsTLRsBmbs7feuodNHC65fNOAdQ1X5kQc8rws61c9+Ft9hx/xKcIDFD5/mWAbOCaBe7vXoaxwQS8in2Fe68uUskYm4WPHsMfKTt6s5y9w8+n3OjoyzrCb96XsK32ri1HSrv9usV3pnUiiEFM4rZA/K7GYj9F7uLgRy+47D7AKTBXYMjgzp5yg6ZRYGkBFOh7HrthCLYFrFR5yHDoiY7UOpS2+5pZcGbl+n0kSriMObwwUQUtTad1NGvFH9G99++dawbWgvcZEDtZ1uLYL7GsiSKPl2MM6tEm2VRlssmLABG51v3PvrPqAZsJomqyW8lsONo5xDp9oH4igr488bLajMo1G8D7dmMxnyPTcdaUmSXwL1oOf1ttTBZp/89hx4xRB6M4/L7hjx1c/f8JQ6KpGEiELev9hHb1i0WtHsp+DFlk68PWl3wjmMaV//BFwHYNksFckko+gx7p6QMxJa4P0yI5UHAszHQR2xEXZkXAvXdLGYt3CHlI1rFeiRWK0JJ67kP0GEPFng9gqzUnQCbOmYDknEoJ10vz39+88fGXaujU7vHM5eJNrIMqc+NnfK
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB5038.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(56012099006)(4143699003)(3023799007)(11063799006)(22082099003)(38070700021)(18002099003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?UwrvuQdLXLwBud330+ghjGvCPEC/0/C/jOGXl1Jo+912JDez0bLIc35v5dIl?=
 =?us-ascii?Q?W0wOK6oJWZP2Ok3dnU563Ljs7+el1vAlxBrZi/TyAFgS55EgKv+Dq0Wy0IJs?=
 =?us-ascii?Q?0SKSORQq/b3jMQSMdkNhLAXhJlK08zZUx4F9Hk+egHnV/UIQY0Bx/Bg0Csxp?=
 =?us-ascii?Q?a+42zGkVGnDB4Kd75xOY1ODf4mlTPuI9OkWuAoZFJcd/FIusEZjouQWdQUIZ?=
 =?us-ascii?Q?2vCb91ZI+lLOinkUiAwvVqlGEDrhpIT9sSkhy3uFwPE+XhXSVoxLRTd0ro9a?=
 =?us-ascii?Q?vDSNv4L877Y0S25XUmt7WBbo7AKD6LNIA7fnPMQKTaC0fr5LTrtmssTPwQYx?=
 =?us-ascii?Q?a3LheQii00zoFeNgajj5yeP/zGqa5ZsAzQbVy8TfaRDuBn0UBxf/fjf3OCMV?=
 =?us-ascii?Q?TZPAPdS6QYAn9/cJvIWgGehYVd33UDIfHKVyvDvTGS0HjPi9dVEiLB8shRWf?=
 =?us-ascii?Q?mZFix99eaqG2sDltUoJfFCZZOKlS3xg4DcGGVb+om18/tUJugOhWGJ3JPJ0M?=
 =?us-ascii?Q?7bh++wCBfvAOaR9dVvJ3ZzlFFjRJNPy9EwvG619Njxj6M5F0Yu/f1l7HGQbE?=
 =?us-ascii?Q?bV6ZlAV6584uWKNnzhVx4NCSfLX/BRXYCFhIkdrTjeMVeu8W4ib32xZf8ooO?=
 =?us-ascii?Q?bxl+3RX41R5HAVfvBL//i/+GFWT8fBk+1X0vn+6khtPtHqNF+nBcqtbGcwa5?=
 =?us-ascii?Q?wAdxCP3VEyno7h9HUbdXYJuIvpYCeWGLVZpk2Z+NCro/KAMwAeqC7Qa7xduE?=
 =?us-ascii?Q?Daq+VH96EKOfBaoAAL8vpdxqIgkEEpoz6fbQA0TDxlOrSSc8UO1Nb03xJE9a?=
 =?us-ascii?Q?J4Gy+h0qrgLZNU3kNnOuKeYgyajaQVWKu3gmRxVe1vhckar9u8kJEmVICB7N?=
 =?us-ascii?Q?PA1fOorMlCf6cWMGXHTyOt15plnwWrADqYDJX6O1B5fvOG0H7HVq/zGX4HCu?=
 =?us-ascii?Q?Ya22d84CjsJbwbC2zqC+I3T4u8vY3kJE587Mv7h2i6EQJ7Np6II5tTKg3W0U?=
 =?us-ascii?Q?8llZ0vGGiOxC8QA4W+ahzKCSyHz32+eDVraDvBCBQqoSVbz3+azpn6FDX7cf?=
 =?us-ascii?Q?Kqa54Tx7qd1kQ57iyeGVLY6346K0CnFSY1eFcoytD9OqX7zhUm89bIg+KUV/?=
 =?us-ascii?Q?V3HatBQWPHVUc/wMgeSPdy6QWQYmWeU3Dmmw9VsOgE3rGQW7Yo5rYNvJ/+15?=
 =?us-ascii?Q?WpbIkZUzk9oAI7xx50VCXVwPGlrqmhVbt/wnZDLBCRSUV0pHtON5Y5gv44EL?=
 =?us-ascii?Q?Cr3Hhb6a1EPhExKlHnQ8xyQYdmHD6QOLmqayv/z5/wg9dzwz0jK054ARZq5K?=
 =?us-ascii?Q?KRSSpvp13g4hsNxDym9O40gPH4NVz1FdXwL05lWxQY1+0YcFYGsr5zsgy5So?=
 =?us-ascii?Q?rLZd4SjJEvcLym1dQF8IAVgPiJmyJFN3JttnpOBlzzeqOKWG5f6q1I7+zjOk?=
 =?us-ascii?Q?wJuN/dyqq24y/f29ZGXCNv70Gpdck5M9eldeGPW7wLmeuYT/6fLDdYX0sAtI?=
 =?us-ascii?Q?gSOjnWER+U42uvzJTRRTa4AK04azjq+07fa2FWZWCRNNXJRp9iwDz4qaKE8b?=
 =?us-ascii?Q?GX3C/UjywKrig+ttvTK0BvSeWTbtCvOojEYkmKBV51VhAlcfxF0znUQamo0U?=
 =?us-ascii?Q?KlCCO6Ym5oB7Q78EEb8jTuqIUw2w/X6kClNb59j/nrR4i2F5H3jRth36JIK8?=
 =?us-ascii?Q?6uCEegDAHWYNrmsNEz4/OF9XKADmFpQwZPlyGZ7R6uwUpjKP?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5038.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d807e6f6-8a21-4ed3-9991-08dec16f732c
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Jun 2026 12:55:55.0394 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: e5kJ+gLQsUcDeeBdjvaM5rxANyutmFeBX4jYsuExgD79eTU9Fto6KRaWhqVXe5JpxK67zHHlmJxrPI2sYPD2AA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB8099
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

Hi Dennis,

Yes, debugfs file(amdgpu_regs) wont be created when lockdown mode is not "n=
one".

Thanks & Regards
Asad

-----Original Message-----
From: StDenis, Tom <Tom.StDenis@amd.com>
Sent: Wednesday, June 3, 2026 6:00 PM
To: Kamal, Asad <Asad.Kamal@amd.com>; amd-gfx@lists.freedesktop.org
Cc: Lazar, Lijo <Lijo.Lazar@amd.com>; Zhang, Hawking <Hawking.Zhang@amd.com=
>; Ma, Le <Le.Ma@amd.com>; Zhang, Morris <Shiwu.Zhang@amd.com>; Deucher, Al=
exander <Alexander.Deucher@amd.com>; Wang, Yang(Kevin) <KevinYang.Wang@amd.=
com>
Subject: Re: [PATCH v3] drm/amdgpu: Gate debugfs MMIO access on kernel lock=
down

HI Asad,

This should be fine for umr.  UMR detects when the lockdown mode isn't "non=
e" and warns the user that the tool might not work.

So the net effect of this patch is the debugfs files are just not created a=
t all?  That'll likely cause umr discovery to fail (after it prints he warn=
ing) which is still fine.

Tom


________________________________________
From: Kamal, Asad <Asad.Kamal@amd.com>
Sent: Wednesday, June 3, 2026 07:44
To: amd-gfx@lists.freedesktop.org
Cc: Lazar, Lijo; Zhang, Hawking; Ma, Le; Zhang, Morris; Deucher, Alexander;=
 Wang, Yang(Kevin); Kamal, Asad; StDenis, Tom
Subject: [PATCH v3] drm/amdgpu: Gate debugfs MMIO access on kernel lockdown

amdgpu_regs, amdgpu_regs2, and related debugfs nodes allow arbitrary MMIO r=
ead/write via RREG32/WREG32 without checking security_locked_down(). On ker=
nel_lockdown=3Dintegrity systems this bypasses the same restrictions as /de=
v/mem and PCI config space sysfs.

Check LOCKDOWN_PCI_ACCESS (matching pci-sysfs) at the entry of every debugf=
s handler that performs direct register access.

v2: Use consistent check as per previous check to use
LOCKDOWN_DEBUGFS(Lijo)

v3: Do not create any entry from amdgpu_debugfs_regs_init() if LOCKDOWN_PCI=
_ACCESS is active and log once. (Lijo)

Signed-off-by: Asad Kamal <asad.kamal@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c b/drivers/gpu/drm/=
amd/amdgpu/amdgpu_debugfs.c
index 0ce6e2e4342c..5c4d4ff001ea 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
@@ -26,6 +26,7 @@
 #include <linux/kthread.h>
 #include <linux/pci.h>
 #include <linux/uaccess.h>
+#include <linux/security.h>
 #include <linux/pm_runtime.h>

 #include "amdgpu.h"
@@ -1739,6 +1740,12 @@ int amdgpu_debugfs_regs_init(struct amdgpu_device *a=
dev)
        struct dentry *ent, *root =3D minor->debugfs_root;
        unsigned int i;

+       if (security_locked_down(LOCKDOWN_PCI_ACCESS)) {
+               drm_info(adev_to_drm(adev),
+                        "amdgpu: HW debugfs nodes disabled (kernel lockdow=
n)\n");
+               return 0;
+       }
+
        for (i =3D 0; i < ARRAY_SIZE(debugfs_regs); i++) {
                ent =3D debugfs_create_file(debugfs_regs_names[i],
                                          S_IFREG | 0400, root,
--
2.46.0

