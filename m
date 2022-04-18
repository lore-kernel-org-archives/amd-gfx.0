Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 35DBFC433EF
	for <amd-gfx@archiver.kernel.org>; Mon, 18 Apr 2022 03:49:58 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8529C10ECF9;
	Mon, 18 Apr 2022 03:49:57 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2076.outbound.protection.outlook.com [40.107.223.76])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8C71410ECF4
 for <amd-gfx@lists.freedesktop.org>; Mon, 18 Apr 2022 03:49:55 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PlqLFB3JEEvnhiETQh6dKsU+THIxe8W1NH7Xb/skIuOAZg6qClaAQOKcjBAIorvYdssZ/KUhAg0Z4qUa2RGWm0MfymrrkzNF7Dn6Yqs5b3SPtjch2ZGgaDJqrxOWJFQ71lp2nnAPE7UKPYfb4kWq17UZnQOQu8pWfv92bjX+0wtBskPpk6nGb7KTxDvWleJXh1xayWBkTmqf6xAQBk6a/rdFnR43uWO6caIuRKTXM/9fCfKyc8xoxyugt3VQQ8F1prO1IFzi7Wz5IBta7IJ/B8DK6DWPkY9Jkhp/Q/BttIpjw2NFfLPpyuy/O73DiCl1rVULmMaDHUFih0YGST6xpA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4EtCdO90DKtPQ0rIBTYOUKi6WGgXn0stOrEJqNoDWQk=;
 b=C5J86PiTjr0fbXlo0fdTgT7/1CfBl3hmFe1I13/vy0T7q9aSv6PbLVKs+GhTzWaprcKLldPFvuWPoV76hLXvGJic1/jiHnyZbpZn141CAW0SEcivEjnypWxidg/qkbq8RmINV+9m9imqyeFPfbkDhU30XfevVG6pKEZzOQ2yedYswrfxnDBXNOm41vcqV6ecNQ4TBG/nZZ1YODkN4t0cKe/vZ+hqQqxKMuiqBaClAaDqyBCs8E/VRQZLIhtSmnTofqno4TGrxRLK3GkHLAugDMgx1Kc4h7NbYCYcNGPLL8BLgc6QecSD1liX+A4UxbPnhYycplvMCvkRpTbW1SIEQw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4EtCdO90DKtPQ0rIBTYOUKi6WGgXn0stOrEJqNoDWQk=;
 b=h0P0J9k+vOqKMcsG8A9uqlBps+BHLRQk+z+Cz9BSZbihGuVzpSP9cM+rsmwnwwAVPu75W4pAL2e6aTYp5v5wrL+oF56Sg+lbR5cmkU+08sG7yFKlCQtirMXxsn0VynJvzCzTCDl3oymXAnXS7j5pw586CaCHP0EC3C/rMQgegAI=
Received: from CO6PR12MB5473.namprd12.prod.outlook.com (2603:10b6:303:13e::8)
 by DM6PR12MB2619.namprd12.prod.outlook.com (2603:10b6:5:45::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5164.20; Mon, 18 Apr
 2022 03:49:52 +0000
Received: from CO6PR12MB5473.namprd12.prod.outlook.com
 ([fe80::28df:431f:d965:e6ef]) by CO6PR12MB5473.namprd12.prod.outlook.com
 ([fe80::28df:431f:d965:e6ef%6]) with mapi id 15.20.5164.025; Mon, 18 Apr 2022
 03:49:52 +0000
From: "Wang, Yang(Kevin)" <KevinYang.Wang@amd.com>
To: "Li, Candice" <Candice.Li@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: Re: [PATCH 2/2] drm/amdgpu: Add debugfs TA load/unload/invoke support
Thread-Topic: [PATCH 2/2] drm/amdgpu: Add debugfs TA load/unload/invoke support
Thread-Index: AQHYUtHT9Kli5Km+uUqhl7Wpa34Sfqz1AltU
Date: Mon, 18 Apr 2022 03:49:52 +0000
Message-ID: <CO6PR12MB5473BE8C2250B7607FA6F86682F39@CO6PR12MB5473.namprd12.prod.outlook.com>
References: <20220418030927.11320-1-candice.li@amd.com>
 <20220418030927.11320-2-candice.li@amd.com>
In-Reply-To: <20220418030927.11320-2-candice.li@amd.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Enabled=True;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SetDate=2022-04-18T03:49:52.973Z;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Name=AMD
 Official Use
 Only; MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ContentBits=0;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Method=Standard; 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: e2faae97-ac3f-429d-6184-08da20ee7ecd
x-ms-traffictypediagnostic: DM6PR12MB2619:EE_
x-microsoft-antispam-prvs: <DM6PR12MB261982C4CCB7D9ADD14344BB82F39@DM6PR12MB2619.namprd12.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: E+ZxyGIq81kCmNPr8YT2U++Gf45qi9DifuKPhmnQnJuxRWLvPjKiq5l9G4817VLdz+IJBrh9RRvU3c/XhqdXdiYcPDqDIlKu3KeA4LJom0HbMrGSxgVFo3nJ/ZhoSuIb8hOQZLoQUQbuD7ibo5quBa64xbWJB2R+pkroyEbh5DY2xs584UBZuOvx29pWl/mVntEovsjL9Y8vPUH8gNeWeiLnxWZ5H1ThLoWjhc3T+y0rM5VmP6elFIjDnlONj+bjWfEi2StTBszeVXqcWGj4q0lj2P0s0cQNKB5CBBwVtKk0d3uR+tZ3PIOfHhY+BHe/6dyuxWz3QIM8MvqnX2uapibx9CQtjC1ZoZTDajPkKleYJWCSiQ1F2i5psoLirmqdAtlFBo3NO8hksecqsM11ClOnqWYkcpKeU9OcS9/khgONcnMh47ZqSPZTp7+WazAhcTyjZ+M0342VVFivb7je//knqfSUxXREI8xUHcyWWg6bUw6eSXknLOCUAZf9MXAtzWWka2F4tk6h1Ax7D1zVmrxeApCjfGx7Ye/W0ifRChCxtR588887pBs8dm7AJQ5pKeim01BwL2fIieM3TI+V24C13s9Kd9jQW+N2syoJOj7OedingNzLfvVNWVVjan3QxdmbxY0pVJCRQ2u0oBzykL2t1ZeDSPHmXe7Qi46WOCUoDue9zLQKhnGIRr31nnUZaYh/sXSPmb2cvSO36M+C6quJks59tn4fdNuWz0u+elw=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CO6PR12MB5473.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(4636009)(366004)(91956017)(7696005)(38070700005)(122000001)(66476007)(66446008)(64756008)(66556008)(66946007)(4326008)(38100700002)(316002)(6506007)(53546011)(52536014)(8936002)(33656002)(55016003)(5660300002)(30864003)(110136005)(2906002)(76116006)(508600001)(8676002)(83380400001)(71200400001)(9686003)(26005)(19627405001)(186003)(86362001)(461764006);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?Windows-1252?Q?IlJtl3XJxIUSO2/wUhThV7x5F84TdlLumtIbFtq7qrGGAfshNjm2+k6p?=
 =?Windows-1252?Q?8OgLEGXJDRe56ZuRMiI3F0zUGvMGR4cX5hprEgR87eNV79RZll8nmQ5y?=
 =?Windows-1252?Q?TgFvYZrkTpMsnGAJYEa/OBd6vAV+QPiSqwff/vfwKwRGGkV1wuBFsBrA?=
 =?Windows-1252?Q?1fQ2tNCxg8kjc3jN65GHlCdAnbUP2Jd9U7I9wamfjluv6u+/rlz1z2+Z?=
 =?Windows-1252?Q?bLeVqJgMrEljn/ya73hDVuy/gNPQ6gIIOTl98FUVhjJjdhD9A6y9R5GV?=
 =?Windows-1252?Q?s+KD51ea0mEvqjtV8yGgTRNklDJVb2W8N0pehFfGo5LSkTe8MgkxEjwz?=
 =?Windows-1252?Q?Ju7sRwDsXmlAEY1K9BBeWJ1cOhfmGBitDGhA17ZI3GugqM+Qv4+HcGsJ?=
 =?Windows-1252?Q?2eJJF7CrzkCnTLzdofbGXqecUM4pdS0My0PGZ7KVDTuKNv9Z7LVOURhC?=
 =?Windows-1252?Q?/Xa/UL0L4dW0FhnIIdOkvIbEEI1AOCKG+PMTMuusPuQhOM2uSSIyCdXR?=
 =?Windows-1252?Q?3Nbe813v5caSJq+JXIgV7xSKNXfcCNV2i68libXcH1q1aqhcqCtGGhsU?=
 =?Windows-1252?Q?usTqSZ5KGFYwXugt50sUsVHe1b89Zh3nImwArxnbyxNJ2lVZJ9+VlzcW?=
 =?Windows-1252?Q?n0C+88U5BnOrAB73tok6zXZt1mDjly6xso4e7K1OcHdM0cIO5uOVwJq1?=
 =?Windows-1252?Q?ZAjZgBJJWHvanS2Q+caWctXiG5zVSF+c2VSe23/td9SKjbqeXqC5fOHm?=
 =?Windows-1252?Q?8XJ9ZMqol/wqj4rmoA8InROzsmcvYHhIddrFuXTuSGmHywFt/g/+Cxzr?=
 =?Windows-1252?Q?9X+ryfup63t1uGO/GurxVn9i3CvrpYVMO6HriObFxJrsO43Ozh2/Addx?=
 =?Windows-1252?Q?C6aGd7hb9ICVDnZnb/wS4ZuJ3lINMs2hBhwVteL5UK6viFAXEDM3lLWj?=
 =?Windows-1252?Q?a78X1UAPEdjh1PrgGuNYy9fijo3DfKHsUEE2P2tcf47Q1D+YfT1BQUv5?=
 =?Windows-1252?Q?g1OhrrsHKo12xydLbiam/AZc0akXqcUURhqquh5tnPoF5vvQ7uM2Ez+X?=
 =?Windows-1252?Q?pyKrZVB6nfPYKpMIYW3T6uQMTGyauRlTJq0y3TARf3KbkgMsf4S2O0K5?=
 =?Windows-1252?Q?tQxE5jFSFHTrKJvB+749KK1iDwKhBLPA+Nn31bnPX+u2YxsYe8jgSJ6E?=
 =?Windows-1252?Q?57yniHrGIC6Or5aE1lr8d5rwE9ePW6tTQUsfT2jp5wOzS3N9fFLt0Sk4?=
 =?Windows-1252?Q?41QVHRfmUg8ZJbVBSgLQQQtYv8pkKQg1m6I1rC6VSwHrFNYQ56R+TEv4?=
 =?Windows-1252?Q?9tJ/c4540bwx2Gvubae3TKU0uSkLPbpBjlMqubnBMsH1HhgWdD6NnYFL?=
 =?Windows-1252?Q?CJYrZZIeDZigX3fquBFdkS1jhNNgw0XX6uagLpiXJDJVLLaURFtEAfbu?=
 =?Windows-1252?Q?xhS8NaaYamlSCsNh81crsqBeQNUD9QkoIQU/zWPO8BBBnGIeUA7CyGO4?=
 =?Windows-1252?Q?j26rF4WwWg+/MBMwArvVzirr174JE1NoG9GOF7ZpYVdkttvE0aqvGnsf?=
 =?Windows-1252?Q?YMSZ/UBCa+lE4N1xhfH7bxNt1T7xf2H/o3Je8Q94TrjkGA/4AyYo3m2/?=
 =?Windows-1252?Q?JhbnsuDXfv/T5luN8PV12HLtB1tyCq8WLoZ8+8y7sdeUUQlGpzYGDvPk?=
 =?Windows-1252?Q?enHLYHNYCv6fQH3xffjESjur/dquKdSR2xNQmgT8MdAQsTMqd8hdzECY?=
 =?Windows-1252?Q?mamgm9kRhWSpEsS224R4zP44C7gjsVI3FEW1P719PTl8SHG+dEtxGluY?=
 =?Windows-1252?Q?y3MsQEZ/XcilaAN6EszfEj+k6Yv5hcRi9uG7yzVHdh7fa7yN?=
Content-Type: multipart/alternative;
 boundary="_000_CO6PR12MB5473BE8C2250B7607FA6F86682F39CO6PR12MB5473namp_"
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CO6PR12MB5473.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e2faae97-ac3f-429d-6184-08da20ee7ecd
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Apr 2022 03:49:52.6946 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 10RhLZJaHOEHnO8ICAEaen0HDyc7s7HB6N55PmuCOvfmXgUFyd5pKnKp6dUw3eNF
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB2619
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
Cc: "Clements, John" <John.Clements@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--_000_CO6PR12MB5473BE8C2250B7607FA6F86682F39CO6PR12MB5473namp_
Content-Type: text/plain; charset="Windows-1252"
Content-Transfer-Encoding: quoted-printable

[AMD Official Use Only]


________________________________
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> on behalf of Candice =
Li <candice.li@amd.com>
Sent: Monday, April 18, 2022 11:09 AM
To: amd-gfx@lists.freedesktop.org <amd-gfx@lists.freedesktop.org>
Cc: Li, Candice <Candice.Li@amd.com>; Clements, John <John.Clements@amd.com=
>
Subject: [PATCH 2/2] drm/amdgpu: Add debugfs TA load/unload/invoke support

Add debugfs support to load/unload/invoke TA in runtime.

Signed-off-by: John Clements <john.clements@amd.com>
Signed-off-by: Candice Li <candice.li@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/Makefile         |   2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c |   2 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_psp_ta.c  | 312 ++++++++++++++++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_psp_ta.h  |  30 ++
 4 files changed, 345 insertions(+), 1 deletion(-)
 create mode 100644 drivers/gpu/drm/amd/amdgpu/amdgpu_psp_ta.c
 create mode 100644 drivers/gpu/drm/amd/amdgpu/amdgpu_psp_ta.h

diff --git a/drivers/gpu/drm/amd/amdgpu/Makefile b/drivers/gpu/drm/amd/amdg=
pu/Makefile
index 7d7af43a258f83..b525f9be9326f4 100644
--- a/drivers/gpu/drm/amd/amdgpu/Makefile
+++ b/drivers/gpu/drm/amd/amdgpu/Makefile
@@ -58,7 +58,7 @@ amdgpu-y +=3D amdgpu_device.o amdgpu_kms.o \
         amdgpu_vm_sdma.o amdgpu_discovery.o amdgpu_ras_eeprom.o amdgpu_nbi=
o.o \
         amdgpu_umc.o smu_v11_0_i2c.o amdgpu_fru_eeprom.o amdgpu_rap.o \
         amdgpu_fw_attestation.o amdgpu_securedisplay.o \
-       amdgpu_eeprom.o amdgpu_mca.o
+       amdgpu_eeprom.o amdgpu_mca.o amdgpu_psp_ta.o

 amdgpu-$(CONFIG_PROC_FS) +=3D amdgpu_fdinfo.o

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c b/drivers/gpu/drm/=
amd/amdgpu/amdgpu_debugfs.c
index 13e4d8f9b87449..eedb12f6b8a32d 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
@@ -38,6 +38,7 @@
 #include "amdgpu_umr.h"

 #include "amdgpu_reset.h"
+#include "amdgpu_psp_ta.h"

 #if defined(CONFIG_DEBUG_FS)

@@ -1767,6 +1768,7 @@ int amdgpu_debugfs_init(struct amdgpu_device *adev)
                 DRM_ERROR("registering register debugfs failed (%d).\n", r=
);

         amdgpu_debugfs_firmware_init(adev);
+       amdgpu_ta_if_debugfs_init(adev);

 #if defined(CONFIG_DRM_AMD_DC)
         if (amdgpu_device_has_dc_support(adev))
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp_ta.c b/drivers/gpu/drm/a=
md/amdgpu/amdgpu_psp_ta.c
new file mode 100644
index 00000000000000..916bf3f6fce0d4
--- /dev/null
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp_ta.c
@@ -0,0 +1,312 @@
+/*
+ * Copyright 2022 Advanced Micro Devices, Inc.
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
+ *
+ */
+
+#include "amdgpu.h"
+#include "amdgpu_psp_ta.h"
+
+static const char *TA_IF_FS_NAME =3D "ta_if";
+
+struct dentry *dir;
+struct dentry *ta_load_debugfs_dentry;
+struct dentry *ta_unload_debugfs_dentry;
+struct dentry *ta_invoke_debugfs_dentry;

[kevin]:

make above variable as static is better for this case, but it seems it is n=
ot used in this patch?
if so, you will get a "defined but not used" error, when turn on build opti=
on " -Werror=3Dunused-variable".

Please don't mind this prompt.

Best Regards,
Kevin
+
+static ssize_t ta_if_load_debugfs_read(struct file *fp, char *buf, size_t =
len, loff_t *off);
+static ssize_t ta_if_unload_debugfs_read(struct file *fp, char *buf, size_=
t len, loff_t *off);
+static ssize_t ta_if_invoke_debugfs_read(struct file *fp, char *buf, size_=
t len, loff_t *off);
+
+
+static uint32_t get_bin_version(const uint8_t *bin)
+{
+       const struct common_firmware_header *hdr =3D
+                            (const struct common_firmware_header *)bin;
+
+       return hdr->ucode_version;
+}
+
+static uint32_t get_shared_buf_size(uint32_t shared_buf_len)
+{
+       return (shared_buf_len % PAGE_SIZE) ?
+                            (shared_buf_len/PAGE_SIZE + 1) * PAGE_SIZE :
+                            shared_buf_len;
[kevin]:

  1.  the above code can be replaced with "ALIGN" macro..
  2.
  3.   #define ALIGN(x, a)>---->-------__ALIGN_KERNEL((x), (a)

  1.  do you forget to add some lock resource to protect/cover multi proces=
s case?
  2.  e.g: process#1 exec load_ta() and process#2 exec unload_ta()

and why not use write operation instead of read (load/unload/invoke) ? this=
 seems more reasonable.

Best Regards,
Kevin

+}
+
+static void prep_ta_mem_context(struct psp_context *psp,
+                                            struct ta_context *context,
+                                            uint8_t *shared_buf,
+                                            uint32_t shared_buf_len)
+{
+       context->mem_context.shared_mem_size =3D get_shared_buf_size(shared=
_buf_len);
+       psp_ta_init_shared_buf(psp, &context->mem_context);
+
+       memcpy((void *)context->mem_context.shared_buf, shared_buf, shared_=
buf_len);
+}
+
+static bool is_ta_type_valid(enum ta_type_id ta_type)
+{
+       bool ret =3D false;
+
+       switch (ta_type) {
+       case TA_TYPE_RAS:
+               ret =3D true;
+               break;
+       default:
+               break;
+       }
+
+       return ret;
+}
+
+static const struct file_operations ta_load_debugfs_fops =3D {
+       .read   =3D ta_if_load_debugfs_read,
+       .llseek =3D default_llseek,
+       .owner  =3D THIS_MODULE
+};
+
+static const struct file_operations ta_unload_debugfs_fops =3D {
+       .read   =3D ta_if_unload_debugfs_read,
+       .llseek =3D default_llseek,
+       .owner  =3D THIS_MODULE
+};
+
+static const struct file_operations ta_invoke_debugfs_fops =3D {
+       .read   =3D ta_if_invoke_debugfs_read,
+       .llseek =3D default_llseek,
+       .owner  =3D THIS_MODULE
+};
+
+
+/**
+ * DOC: AMDGPU TA debugfs interfaces
+ *
+ * Three debugfs interfaces can be opened by a program to
+ * load/invoke/unload TA,
+ *
+ * - /sys/kernel/debug/dri/<N>/ta_if/ta_load
+ * - /sys/kernel/debug/dri/<N>/ta_if/ta_invoke
+ * - /sys/kernel/debug/dri/<N>/ta_if/ta_unload
+ *
+ * How to use the interfaces in a program?
+ *
+ * A program needs to provide transmit buffer to the interfaces
+ * and will receive buffer from the interfaces below,
+ *
+ * - For TA load debugfs interface:
+ *   Transmit buffer:
+ *    - TA type (4bytes)
+ *    - TA bin length (4bytes)
+ *    - TA bin
+ *   Receive buffer:
+ *    - TA ID (4bytes)
+ *
+ * - For TA invoke debugfs interface:
+ *   Transmit buffer:
+ *    - TA ID (4bytes)
+ *    - TA CMD ID (4bytes)
+ *    - TA shard buf length (4bytes)
+ *    - TA shared buf
+ *   Receive buffer:
+ *    - TA shared buf
+ *
+ * - For TA unload debugfs interface:
+ *   Transmit buffer:
+ *    - TA ID (4bytes)
+ */
+
+static ssize_t ta_if_load_debugfs_read(struct file *fp, char *buf, size_t =
len, loff_t *off)
+{
+       uint32_t ta_type    =3D 0;
+       uint32_t ta_bin_len =3D 0;
+       uint8_t  *ta_bin    =3D NULL;
+       uint32_t copy_pos   =3D 0;
+       int      ret        =3D 0;
+
+       struct amdgpu_device *adev   =3D (struct amdgpu_device *)file_inode=
(fp)->i_private;
+       struct psp_context   *psp    =3D &adev->psp;
+       struct ta_context    context =3D {0};
+
+       if ((fp =3D=3D NULL) || (buf =3D=3D NULL))
+               return -EINVAL;
+
+       ret =3D copy_from_user((void *)&ta_type, &buf[copy_pos], sizeof(uin=
t32_t));
+       if (ret || (!is_ta_type_valid(ta_type)))
+               return -EINVAL;
+
+       copy_pos +=3D sizeof(uint32_t);
+
+       ret =3D copy_from_user((void *)&ta_bin_len, &buf[copy_pos], sizeof(=
uint32_t));
+       if (ret)
+               return -EINVAL;
+
+       copy_pos +=3D sizeof(uint32_t);
+
+       ta_bin =3D kzalloc(ta_bin_len, GFP_KERNEL);
+       if (!ta_bin)
+               ret =3D -ENOMEM;
+       ret =3D copy_from_user((void *)ta_bin, &buf[copy_pos], ta_bin_len);
+       if (ret)
+               goto err_free_bin;
+
+       ret =3D psp_ras_terminate(psp);
+       if (ret) {
+               dev_err(adev->dev, "Failed to unload embedded RAS TA\n");
+               goto err_free_bin;
+       }
+
+       context.ta_type             =3D ta_type;
+       context.ta_load_type        =3D GFX_CMD_ID_LOAD_TA;
+       context.bin_desc.fw_version =3D get_bin_version(ta_bin);
+       context.bin_desc.size_bytes =3D ta_bin_len;
+       context.bin_desc.start_addr =3D ta_bin;
+
+       ret =3D psp_ta_load(psp, &context);
+
+       if (ret || context.resp_status) {
+               dev_err(adev->dev, "TA load via debugfs failed (%d) status =
%d\n",
+                        ret, context.resp_status);
+               goto err_free_bin;
+       }
+
+       context.initialized =3D true;
+       ret =3D copy_to_user((char *)buf, (void *)&context.session_id, size=
of(uint32_t));
+
+err_free_bin:
+       kfree(ta_bin);
+
+       return ret;
+}
+
+static ssize_t ta_if_unload_debugfs_read(struct file *fp, char *buf, size_=
t len, loff_t *off)
+{
+       uint32_t ta_id  =3D 0;
+       int      ret    =3D 0;
+
+       struct amdgpu_device *adev   =3D (struct amdgpu_device *)file_inode=
(fp)->i_private;
+       struct psp_context   *psp    =3D &adev->psp;
+       struct ta_context    context =3D {0};
+
+       if ((fp =3D=3D NULL) || (buf =3D=3D NULL))
+               return -1;
+
+       ret =3D copy_from_user((void *)&ta_id, buf, sizeof(uint32_t));
+       if (ret)
+               return -EINVAL;
+
+       context.session_id =3D ta_id;
+
+       ret =3D psp_ta_unload(psp, &context);
+       if (!ret)
+               context.initialized =3D false;
+
+       return ret;
+}
+
+static ssize_t ta_if_invoke_debugfs_read(struct file *fp, char *buf, size_=
t len, loff_t *off)
+{
+       uint32_t ta_id          =3D 0;
+       uint32_t cmd_id         =3D 0;
+       uint32_t shared_buf_len =3D 0;
+       uint8_t  *shared_buf    =3D NULL;
+       uint32_t copy_pos       =3D 0;
+       int      ret            =3D 0;
+
+       struct amdgpu_device *adev   =3D (struct amdgpu_device *)file_inode=
(fp)->i_private;
+       struct psp_context   *psp    =3D &adev->psp;
+       struct ta_context    context =3D {0};
+
+       if ((fp =3D=3D NULL) || (buf =3D=3D NULL))
+               return -EINVAL;

[kevin]:
   =93if ((fp =3D=3D NULL) ..."
   The linux kernel will automatically create struct file instance when you=
 open the file, even if you do not provide a callback function (in fops)

[kevin]:

      you should add some check here to avoid that the user buf is overflow=
.
      e.g: If the length of the user buf is less than that required, an err=
or should be returned directly

+
+       ret =3D copy_from_user((void *)&ta_id, &buf[copy_pos], sizeof(uint3=
2_t));
+       if (ret)
+               return -EINVAL;
+       copy_pos +=3D sizeof(uint32_t);
+
+       ret =3D copy_from_user((void *)&cmd_id, &buf[copy_pos], sizeof(uint=
32_t));
+       if (ret)
+               return -EINVAL;
+       copy_pos +=3D sizeof(uint32_t);
+
+       ret =3D copy_from_user((void *)&shared_buf_len, &buf[copy_pos], siz=
eof(uint32_t));
+       if (ret)
+               return -EINVAL;
+       copy_pos +=3D sizeof(uint32_t);
+
+       shared_buf =3D kzalloc(shared_buf_len, GFP_KERNEL);
+       if (!shared_buf)
+               ret =3D -ENOMEM;
+       ret =3D copy_from_user((void *)shared_buf, &buf[copy_pos], shared_b=
uf_len);
+       if (ret)
+               goto err_free_shared_buf;
+
+       context.session_id =3D ta_id;
+
+       prep_ta_mem_context(psp, &context, shared_buf, shared_buf_len);
+
+       ret =3D psp_ta_invoke_indirect(psp, cmd_id, &context);
+
+       if (ret || context.resp_status) {
+               dev_err(adev->dev, "TA invoke via debugfs failed (%d) statu=
s %d\n",
+                        ret, context.resp_status);
+               goto err_free_ta_shared_buf;
+       }
+
+       ret =3D copy_to_user((char *)buf, context.mem_context.shared_buf, s=
hared_buf_len);
+
+err_free_ta_shared_buf:
+       psp_ta_free_shared_buf(&context.mem_context);
+
+err_free_shared_buf:
+       kfree(shared_buf);
+
+       return ret;
+}
+
+static struct dentry *amdgpu_ta_if_debugfs_create(struct amdgpu_device *ad=
ev)
+{
+       struct drm_minor *minor =3D adev_to_drm(adev)->primary;
+
+       dir =3D debugfs_create_dir(TA_IF_FS_NAME, minor->debugfs_root);
+
+       ta_load_debugfs_dentry =3D debugfs_create_file("ta_load", 0400, dir=
, adev,
+                                                    &ta_load_debugfs_fops)=
;
+
+       ta_unload_debugfs_dentry =3D debugfs_create_file("ta_unload", 0400,=
 dir,
+                                                    adev, &ta_unload_debug=
fs_fops);
+
+       ta_invoke_debugfs_dentry =3D debugfs_create_file("ta_invoke", 0400,=
 dir,
+                                                    adev, &ta_invoke_debug=
fs_fops);
+       return dir;
+}
+
+void amdgpu_ta_if_debugfs_init(struct amdgpu_device *adev)
+{
+#if defined(CONFIG_DEBUG_FS)
+       dir =3D amdgpu_ta_if_debugfs_create(adev);
+#endif
+}
+
+void amdgpu_ta_if_debugfs_remove(void)
+{
+       debugfs_remove_recursive(dir);
+}
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp_ta.h b/drivers/gpu/drm/a=
md/amdgpu/amdgpu_psp_ta.h
new file mode 100644
index 00000000000000..883f89d57616d0
--- /dev/null
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp_ta.h
@@ -0,0 +1,30 @@
+/*
+ * Copyright 2022 Advanced Micro Devices, Inc.
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
+ *
+ */
+
+#ifndef __AMDGPU_PSP_TA_H__
+#define __AMDGPU_PSP_TA_H__
+
+void amdgpu_ta_if_debugfs_init(struct amdgpu_device *adev);
+void amdgpu_ta_if_debugfs_remove(void);
+
+#endif
--
2.17.1


--_000_CO6PR12MB5473BE8C2250B7607FA6F86682F39CO6PR12MB5473namp_
Content-Type: text/html; charset="Windows-1252"
Content-Transfer-Encoding: quoted-printable

<html>
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3DWindows-1=
252">
<style type=3D"text/css" style=3D"display:none;"> P {margin-top:0;margin-bo=
ttom:0;} </style>
</head>
<body dir=3D"ltr">
<p style=3D"font-family:Arial;font-size:10pt;color:#0000FF;margin:5pt;" ali=
gn=3D"Left">
[AMD Official Use Only]<br>
</p>
<br>
<div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
<br>
</div>
<hr tabindex=3D"-1" style=3D"display:inline-block; width:98%">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" co=
lor=3D"#000000" style=3D"font-size:11pt"><b>From:</b> amd-gfx &lt;amd-gfx-b=
ounces@lists.freedesktop.org&gt; on behalf of Candice Li &lt;candice.li@amd=
.com&gt;<br>
<b>Sent:</b> Monday, April 18, 2022 11:09 AM<br>
<b>To:</b> amd-gfx@lists.freedesktop.org &lt;amd-gfx@lists.freedesktop.org&=
gt;<br>
<b>Cc:</b> Li, Candice &lt;Candice.Li@amd.com&gt;; Clements, John &lt;John.=
Clements@amd.com&gt;<br>
<b>Subject:</b> [PATCH 2/2] drm/amdgpu: Add debugfs TA load/unload/invoke s=
upport</font>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt"=
 class=3D"elementToProof">
<div class=3D"PlainText elementToProof">Add debugfs support to load/unload/=
invoke TA in runtime.<br>
<br>
Signed-off-by: John Clements &lt;john.clements@amd.com&gt;<br>
Signed-off-by: Candice Li &lt;candice.li@amd.com&gt;<br>
---<br>
&nbsp;drivers/gpu/drm/amd/amdgpu/Makefile&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; |&nbsp;&nbsp; 2 +-<br>
&nbsp;drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c |&nbsp;&nbsp; 2 +<br>
&nbsp;drivers/gpu/drm/amd/amdgpu/amdgpu_psp_ta.c&nbsp; | 312 ++++++++++++++=
++++++<br>
&nbsp;drivers/gpu/drm/amd/amdgpu/amdgpu_psp_ta.h&nbsp; |&nbsp; 30 ++<br>
&nbsp;4 files changed, 345 insertions(+), 1 deletion(-)<br>
&nbsp;create mode 100644 drivers/gpu/drm/amd/amdgpu/amdgpu_psp_ta.c<br>
&nbsp;create mode 100644 drivers/gpu/drm/amd/amdgpu/amdgpu_psp_ta.h<br>
<br>
diff --git a/drivers/gpu/drm/amd/amdgpu/Makefile b/drivers/gpu/drm/amd/amdg=
pu/Makefile<br>
index 7d7af43a258f83..b525f9be9326f4 100644<br>
--- a/drivers/gpu/drm/amd/amdgpu/Makefile<br>
+++ b/drivers/gpu/drm/amd/amdgpu/Makefile<br>
@@ -58,7 +58,7 @@ amdgpu-y +=3D amdgpu_device.o amdgpu_kms.o \<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_vm_sdma.o amdgpu_di=
scovery.o amdgpu_ras_eeprom.o amdgpu_nbio.o \<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_umc.o smu_v11_0_i2c=
.o amdgpu_fru_eeprom.o amdgpu_rap.o \<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_fw_attestation.o am=
dgpu_securedisplay.o \<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_eeprom.o amdgpu_mca.o<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_eeprom.o amdgpu_mca.o amdgpu_p=
sp_ta.o<br>
&nbsp;<br>
&nbsp;amdgpu-$(CONFIG_PROC_FS) +=3D amdgpu_fdinfo.o<br>
&nbsp;<br>
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c b/drivers/gpu/drm/=
amd/amdgpu/amdgpu_debugfs.c<br>
index 13e4d8f9b87449..eedb12f6b8a32d 100644<br>
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c<br>
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c<br>
@@ -38,6 +38,7 @@<br>
&nbsp;#include &quot;amdgpu_umr.h&quot;<br>
&nbsp;<br>
&nbsp;#include &quot;amdgpu_reset.h&quot;<br>
+#include &quot;amdgpu_psp_ta.h&quot;<br>
&nbsp;<br>
&nbsp;#if defined(CONFIG_DEBUG_FS)<br>
&nbsp;<br>
@@ -1767,6 +1768,7 @@ int amdgpu_debugfs_init(struct amdgpu_device *adev)<b=
r>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; DRM_ERROR(&quot;registering register debugfs failed (=
%d).\n&quot;, r);<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_debugfs_firmware_in=
it(adev);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_ta_if_debugfs_init(adev);<br>
&nbsp;<br>
&nbsp;#if defined(CONFIG_DRM_AMD_DC)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (amdgpu_device_has_dc_s=
upport(adev))<br>
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp_ta.c b/drivers/gpu/drm/a=
md/amdgpu/amdgpu_psp_ta.c<br>
new file mode 100644<br>
index 00000000000000..916bf3f6fce0d4<br>
--- /dev/null<br>
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp_ta.c<br>
@@ -0,0 +1,312 @@<br>
+/*<br>
+ * Copyright 2022 Advanced Micro Devices, Inc.<br>
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
+ *<br>
+ */<br>
+<br>
+#include &quot;amdgpu.h&quot;<br>
+#include &quot;amdgpu_psp_ta.h&quot;<br>
+<br>
+static const char *TA_IF_FS_NAME =3D &quot;ta_if&quot;;<br>
+<br>
+struct dentry *dir;<br>
+struct dentry *ta_load_debugfs_dentry;<br>
+struct dentry *ta_unload_debugfs_dentry;<br>
+struct dentry *ta_invoke_debugfs_dentry;</div>
<div class=3D"PlainText elementToProof"><br>
</div>
<div class=3D"PlainText elementToProof"><span style=3D"font-family: &quot;S=
egoe UI&quot;, &quot;Segoe UI Web (West European)&quot;, &quot;Segoe UI&quo=
t;, -apple-system, BlinkMacSystemFont, Roboto, &quot;Helvetica Neue&quot;, =
sans-serif; font-size: 11pt; color: rgb(0, 0, 0); background-color: rgba(0,=
 0, 0, 0);">[kevin]:</span></div>
<div class=3D"PlainText elementToProof"><br>
</div>
<div class=3D"PlainText elementToProof"><span style=3D"font-family: &quot;S=
egoe UI&quot;, &quot;Segoe UI Web (West European)&quot;, &quot;Segoe UI&quo=
t;, -apple-system, BlinkMacSystemFont, Roboto, &quot;Helvetica Neue&quot;, =
sans-serif; font-size: 11pt; color: rgb(0, 0, 0); background-color: rgba(0,=
 0, 0, 0);">make
 above variable as static is better for this case, but it seems it is not u=
sed in this patch?&nbsp;</span></div>
<div class=3D"PlainText elementToProof"><span style=3D"font-family: &quot;S=
egoe UI&quot;, &quot;Segoe UI Web (West European)&quot;, &quot;Segoe UI&quo=
t;, -apple-system, BlinkMacSystemFont, Roboto, &quot;Helvetica Neue&quot;, =
sans-serif; font-size: 11pt; color: rgb(0, 0, 0); background-color: rgba(0,=
 0, 0, 0);">if
 so, you will get a &quot;defined but not used&quot; error, when turn on bu=
ild option &quot; -Werror=3Dunused-variable&quot;.</span></div>
<div class=3D"PlainText elementToProof"><br>
</div>
<div class=3D"PlainText elementToProof"></div>
</span><span style=3D"font-size: 11pt; font-family: &quot;Segoe UI&quot;, &=
quot;Segoe UI Web (West European)&quot;, &quot;Segoe UI&quot;, -apple-syste=
m, BlinkMacSystemFont, Roboto, &quot;Helvetica Neue&quot;, sans-serif; colo=
r: rgb(0, 0, 0); background-color: rgba(0, 0, 0, 0);" class=3D"elementToPro=
of">Please
 don't mind this prompt.</span><span style=3D"font-size:11pt" class=3D"elem=
entToProof">
<div><br>
</div>
<div class=3D"PlainText elementToProof"><span style=3D"font-family: &quot;S=
egoe UI&quot;, &quot;Segoe UI Web (West European)&quot;, &quot;Segoe UI&quo=
t;, -apple-system, BlinkMacSystemFont, Roboto, &quot;Helvetica Neue&quot;, =
sans-serif; font-size: 11pt; color: rgb(0, 0, 0); background-color: rgba(0,=
 0, 0, 0);">Best
 Regards,</span></div>
<div class=3D"PlainText elementToProof"><span style=3D"font-family: &quot;S=
egoe UI&quot;, &quot;Segoe UI Web (West European)&quot;, &quot;Segoe UI&quo=
t;, -apple-system, BlinkMacSystemFont, Roboto, &quot;Helvetica Neue&quot;, =
sans-serif; font-size: 11pt; color: rgb(0, 0, 0); background-color: rgba(0,=
 0, 0, 0);">Kevin</span><br>
+<br>
+static ssize_t ta_if_load_debugfs_read(struct file *fp, char *buf, size_t =
len, loff_t *off);<br>
+static ssize_t ta_if_unload_debugfs_read(struct file *fp, char *buf, size_=
t len, loff_t *off);<br>
+static ssize_t ta_if_invoke_debugfs_read(struct file *fp, char *buf, size_=
t len, loff_t *off);<br>
+<br>
+<br>
+static uint32_t get_bin_version(const uint8_t *bin)<br>
+{<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; const struct common_firmware_header *=
hdr =3D<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp; (const struct common_firmware_header *)bin;<br>
+<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return hdr-&gt;ucode_version;<br>
+}<br>
+<br>
+static uint32_t get_shared_buf_size(uint32_t shared_buf_len)<br>
+{<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return (shared_buf_len % PAGE_SIZE) ?=
<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp; (shared_buf_len/PAGE_SIZE + 1) * PAGE_SIZE :<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp; shared_buf_len;</div>
<div class=3D"PlainText elementToProof">[kevin]:</div>
<div class=3D"PlainText elementToProof">
<ol>
<li><span>the above code can be replaced with &quot;ALIGN&quot; macro..</sp=
an></li><li style=3D"display:block"></li><li style=3D"display:block">&nbsp;=
#define ALIGN(x, a)&gt;----&gt;-------__ALIGN_KERNEL((x), (a)</li></ol>
<ol start=3D"2">
<li>do you forget to add some lock resource to protect/cover multi process =
case?</li><li style=3D"display:block">e.g: process#1 exec load_ta() and pro=
cess#2 exec unload_ta()</li></ol>
<div><br>
</div>
<div></div>
</div>
<div class=3D"PlainText elementToProof">and why not use write operation ins=
tead of read (load/unload/invoke)
<span style=3D"background-color:rgb(255, 255, 255);display:inline !importan=
t">?&nbsp;</span>this seems more reasonable.</div>
<div class=3D"PlainText elementToProof">
<div><br>
</div>
</div>
<div class=3D"PlainText elementToProof">Best Regards,</div>
<div class=3D"PlainText elementToProof">Kevin</div>
<div class=3D"PlainText elementToProof"><br>
</div>
<div class=3D"PlainText elementToProof">+}<br>
+<br>
+static void prep_ta_mem_context(struct psp_context *psp,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct ta_context *context,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint8_t *shared_buf,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t shared_buf_len)<br>
+{<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; context-&gt;mem_context.shared_mem_si=
ze =3D get_shared_buf_size(shared_buf_len);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; psp_ta_init_shared_buf(psp, &amp;cont=
ext-&gt;mem_context);<br>
+<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; memcpy((void *)context-&gt;mem_contex=
t.shared_buf, shared_buf, shared_buf_len);<br>
+}<br>
+<br>
+static bool is_ta_type_valid(enum ta_type_id ta_type)<br>
+{<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; bool ret =3D false;<br>
+<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; switch (ta_type) {<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case TA_TYPE_RAS:<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; ret =3D true;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; break;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; default:<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; break;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
+<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return ret;<br>
+}<br>
+<br>
+static const struct file_operations ta_load_debugfs_fops =3D {<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .read&nbsp;&nbsp; =3D ta_if_load_debu=
gfs_read,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .llseek =3D default_llseek,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .owner&nbsp; =3D THIS_MODULE<br>
+};<br>
+<br>
+static const struct file_operations ta_unload_debugfs_fops =3D {<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .read&nbsp;&nbsp; =3D ta_if_unload_de=
bugfs_read,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .llseek =3D default_llseek,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .owner&nbsp; =3D THIS_MODULE<br>
+};<br>
+<br>
+static const struct file_operations ta_invoke_debugfs_fops =3D {<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .read&nbsp;&nbsp; =3D ta_if_invoke_de=
bugfs_read,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .llseek =3D default_llseek,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .owner&nbsp; =3D THIS_MODULE<br>
+};<br>
+<br>
+<br>
+/**<br>
+ * DOC: AMDGPU TA debugfs interfaces<br>
+ *<br>
+ * Three debugfs interfaces can be opened by a program to<br>
+ * load/invoke/unload TA,<br>
+ *<br>
+ * - /sys/kernel/debug/dri/&lt;N&gt;/ta_if/ta_load<br>
+ * - /sys/kernel/debug/dri/&lt;N&gt;/ta_if/ta_invoke<br>
+ * - /sys/kernel/debug/dri/&lt;N&gt;/ta_if/ta_unload<br>
+ *<br>
+ * How to use the interfaces in a program?<br>
+ *<br>
+ * A program needs to provide transmit buffer to the interfaces<br>
+ * and will receive buffer from the interfaces below,<br>
+ *<br>
+ * - For TA load debugfs interface:<br>
+ *&nbsp;&nbsp; Transmit buffer:<br>
+ *&nbsp;&nbsp;&nbsp; - TA type (4bytes)<br>
+ *&nbsp;&nbsp;&nbsp; - TA bin length (4bytes)<br>
+ *&nbsp;&nbsp;&nbsp; - TA bin<br>
+ *&nbsp;&nbsp; Receive buffer:<br>
+ *&nbsp;&nbsp;&nbsp; - TA ID (4bytes)<br>
+ *<br>
+ * - For TA invoke debugfs interface:<br>
+ *&nbsp;&nbsp; Transmit buffer:<br>
+ *&nbsp;&nbsp;&nbsp; - TA ID (4bytes)<br>
+ *&nbsp;&nbsp;&nbsp; - TA CMD ID (4bytes)<br>
+ *&nbsp;&nbsp;&nbsp; - TA shard buf length (4bytes)<br>
+ *&nbsp;&nbsp;&nbsp; - TA shared buf<br>
+ *&nbsp;&nbsp; Receive buffer:<br>
+ *&nbsp;&nbsp;&nbsp; - TA shared buf<br>
+ *<br>
+ * - For TA unload debugfs interface:<br>
+ *&nbsp;&nbsp; Transmit buffer:<br>
+ *&nbsp;&nbsp;&nbsp; - TA ID (4bytes)<br>
+ */<br>
+<br>
+static ssize_t ta_if_load_debugfs_read(struct file *fp, char *buf, size_t =
len, loff_t *off)<br>
+{<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t ta_type&nbsp;&nbsp;&nbsp; =
=3D 0;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t ta_bin_len =3D 0;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint8_t&nbsp; *ta_bin&nbsp;&nbsp;&nbs=
p; =3D NULL;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t copy_pos&nbsp;&nbsp; =3D 0;<=
br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ret=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =3D 0;<br>
+<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_device *adev&nbsp;&nbsp=
; =3D (struct amdgpu_device *)file_inode(fp)-&gt;i_private;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct psp_context&nbsp;&nbsp; *psp&n=
bsp;&nbsp;&nbsp; =3D &amp;adev-&gt;psp;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct ta_context&nbsp;&nbsp;&nbsp; c=
ontext =3D {0};<br>
+<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if ((fp =3D=3D NULL) || (buf =3D=3D N=
ULL))<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; return -EINVAL;<br>
+<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ret =3D copy_from_user((void *)&amp;t=
a_type, &amp;buf[copy_pos], sizeof(uint32_t));<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (ret || (!is_ta_type_valid(ta_type=
)))<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; return -EINVAL;<br>
+<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; copy_pos +=3D sizeof(uint32_t);<br>
+<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ret =3D copy_from_user((void *)&amp;t=
a_bin_len, &amp;buf[copy_pos], sizeof(uint32_t));<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (ret)<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; return -EINVAL;<br>
+<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; copy_pos +=3D sizeof(uint32_t);<br>
+<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ta_bin =3D kzalloc(ta_bin_len, GFP_KE=
RNEL);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!ta_bin)<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; ret =3D -ENOMEM;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ret =3D copy_from_user((void *)ta_bin=
, &amp;buf[copy_pos], ta_bin_len);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (ret)<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; goto err_free_bin;<br>
+<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ret =3D psp_ras_terminate(psp);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (ret) {<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; dev_err(adev-&gt;dev, &quot;Failed to unload embedded RAS TA\n&q=
uot;);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; goto err_free_bin;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
+<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; context.ta_type&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =3D ta_type;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; context.ta_load_type&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp; =3D GFX_CMD_ID_LOAD_TA;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; context.bin_desc.fw_version =3D get_b=
in_version(ta_bin);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; context.bin_desc.size_bytes =3D ta_bi=
n_len;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; context.bin_desc.start_addr =3D ta_bi=
n;<br>
+<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ret =3D psp_ta_load(psp, &amp;context=
);<br>
+<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (ret || context.resp_status) {<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; dev_err(adev-&gt;dev, &quot;TA load via debugfs failed (%d) stat=
us %d\n&quot;,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ret, conte=
xt.resp_status);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; goto err_free_bin;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
+<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; context.initialized =3D true;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ret =3D copy_to_user((char *)buf, (vo=
id *)&amp;context.session_id, sizeof(uint32_t));<br>
+<br>
+err_free_bin:<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; kfree(ta_bin);<br>
+<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return ret;<br>
+}<br>
+<br>
+static ssize_t ta_if_unload_debugfs_read(struct file *fp, char *buf, size_=
t len, loff_t *off)<br>
+{<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t ta_id&nbsp; =3D 0;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ret=
&nbsp;&nbsp;&nbsp; =3D 0;<br>
+<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_device *adev&nbsp;&nbsp=
; =3D (struct amdgpu_device *)file_inode(fp)-&gt;i_private;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct psp_context&nbsp;&nbsp; *psp&n=
bsp;&nbsp;&nbsp; =3D &amp;adev-&gt;psp;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct ta_context&nbsp;&nbsp;&nbsp; c=
ontext =3D {0};<br>
+<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if ((fp =3D=3D NULL) || (buf =3D=3D N=
ULL))<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; return -1;<br>
+<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ret =3D copy_from_user((void *)&amp;t=
a_id, buf, sizeof(uint32_t));<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (ret)<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; return -EINVAL;<br>
+<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; context.session_id =3D ta_id;<br>
+<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ret =3D psp_ta_unload(psp, &amp;conte=
xt);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!ret)<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; context.initialized =3D false;<br>
+<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return ret;<br>
+}<br>
+<br>
</div>
<div class=3D"PlainText elementToProof">+static ssize_t ta_if_invoke_debugf=
s_read(struct file *fp, char *buf, size_t len, loff_t *<span style=3D"backg=
round-color:rgb(255, 255, 255);display:inline !important"><span style=3D"ba=
ckground-color:rgb(255, 255, 255);display:inline !important"><span style=3D=
"background-color:rgb(255, 255, 255);display:inline !important"><span style=
=3D"background-color:rgb(255, 255, 255);display:inline !important">off</spa=
n></span></span></span>)<br>
</div>
<div class=3D"PlainText elementToProof">+{<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t ta_id&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =3D 0;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t cmd_id&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp; =3D 0;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t shared_buf_len =3D 0;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint8_t&nbsp; *shared_buf&nbsp;&nbsp;=
&nbsp; =3D NULL;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t copy_pos&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp; =3D 0;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ret=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =3D 0;<b=
r>
+<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_device *adev&nbsp;&nbsp=
; =3D (struct amdgpu_device *)file_inode(fp)-&gt;i_private;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct psp_context&nbsp;&nbsp; *psp&n=
bsp;&nbsp;&nbsp; =3D &amp;adev-&gt;psp;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct ta_context&nbsp;&nbsp;&nbsp; c=
ontext =3D {0};<br>
+<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if ((fp =3D=3D NULL) || (buf =3D=3D N=
ULL))<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; return -EINVAL;</div>
<div class=3D"PlainText elementToProof"><br>
</div>
<div class=3D"PlainText elementToProof"><span style=3D"font-family: &quot;S=
egoe UI&quot;, &quot;Segoe UI Web (West European)&quot;, &quot;Segoe UI&quo=
t;, -apple-system, BlinkMacSystemFont, Roboto, &quot;Helvetica Neue&quot;, =
sans-serif; font-size: 11pt; color: rgb(0, 0, 0); background-color: rgba(0,=
 0, 0, 0);">[kevin]:</span></div>
<div class=3D"PlainText elementToProof"><span style=3D"font-family: &quot;S=
egoe UI&quot;, &quot;Segoe UI Web (West European)&quot;, &quot;Segoe UI&quo=
t;, -apple-system, BlinkMacSystemFont, Roboto, &quot;Helvetica Neue&quot;, =
sans-serif; font-size: 11pt; color: rgb(0, 0, 0); background-color: rgba(0,=
 0, 0, 0);"><span style=3D"background-color:rgb(255, 255, 255);display:inli=
ne !important">&nbsp;
 &nbsp;=93if ((fp =3D=3D NULL)<span>&nbsp;...&quot;</span></span><br>
</span></div>
<div class=3D"PlainText elementToProof"><span style=3D"font-family: &quot;S=
egoe UI&quot;, &quot;Segoe UI Web (West European)&quot;, &quot;Segoe UI&quo=
t;, -apple-system, BlinkMacSystemFont, Roboto, &quot;Helvetica Neue&quot;, =
sans-serif; font-size: 11pt; color: rgb(0, 0, 0); background-color: rgba(0,=
 0, 0, 0);">&nbsp;
 &nbsp;</span><span style=3D"font-family: &quot;Segoe UI&quot;, &quot;Segoe=
 UI Web (West European)&quot;, &quot;Segoe UI&quot;, -apple-system, BlinkMa=
cSystemFont, Roboto, &quot;Helvetica Neue&quot;, sans-serif; font-size: 11p=
t; color: rgb(0, 0, 0); background-color: rgba(0, 0, 0, 0);">The linux kern=
el will
 automatically create struct file instance when you open the file, even if =
you do not provide a callback function (in fops)</span></div>
<div class=3D"PlainText elementToProof">
<div><br>
</div>
</div>
<div class=3D"PlainText elementToProof">[kevin]:</div>
<div class=3D"PlainText elementToProof"><br>
</div>
<div class=3D"PlainText elementToProof">&nbsp; &nbsp; &nbsp; you should add=
 some check here to avoid that the user buf is overflow.</div>
<div class=3D"PlainText elementToProof"></div>
&nbsp; &nbsp; &nbsp; e.g: If the length of the user buf is less than that r=
equired, an error should be returned directly
<div><br>
</div>
<div class=3D"PlainText elementToProof">+<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ret =3D copy_from_user((void *)&amp;t=
a_id, &amp;buf[copy_pos], sizeof(uint32_t));<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (ret)<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; return -EINVAL;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; copy_pos +=3D sizeof(uint32_t);<br>
+<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ret =3D copy_from_user((void *)&amp;c=
md_id, &amp;buf[copy_pos], sizeof(uint32_t));<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (ret)<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; return -EINVAL;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; copy_pos +=3D sizeof(uint32_t);<br>
+<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ret =3D copy_from_user((void *)&amp;s=
hared_buf_len, &amp;buf[copy_pos], sizeof(uint32_t));<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (ret)<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; return -EINVAL;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; copy_pos +=3D sizeof(uint32_t);<br>
+<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; shared_buf =3D kzalloc(shared_buf_len=
, GFP_KERNEL);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!shared_buf)<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; ret =3D -ENOMEM;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ret =3D copy_from_user((void *)shared=
_buf, &amp;buf[copy_pos], shared_buf_len);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (ret)<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; goto err_free_shared_buf;<br>
+<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; context.session_id =3D ta_id;<br>
+<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; prep_ta_mem_context(psp, &amp;context=
, shared_buf, shared_buf_len);<br>
+<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ret =3D psp_ta_invoke_indirect(psp, c=
md_id, &amp;context);<br>
+<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (ret || context.resp_status) {<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; dev_err(adev-&gt;dev, &quot;TA invoke via debugfs failed (%d) st=
atus %d\n&quot;,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ret, conte=
xt.resp_status);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; goto err_free_ta_shared_buf;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
+<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ret =3D copy_to_user((char *)buf, con=
text.mem_context.shared_buf, shared_buf_len);<br>
+<br>
+err_free_ta_shared_buf:<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; psp_ta_free_shared_buf(&amp;context.m=
em_context);<br>
+<br>
+err_free_shared_buf:<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; kfree(shared_buf);<br>
+<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return ret;<br>
+}<br>
+<br>
+static struct dentry *amdgpu_ta_if_debugfs_create(struct amdgpu_device *ad=
ev)<br>
+{<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct drm_minor *minor =3D adev_to_d=
rm(adev)-&gt;primary;<br>
+<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dir =3D debugfs_create_dir(TA_IF_FS_N=
AME, minor-&gt;debugfs_root);<br>
+<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ta_load_debugfs_dentry =3D debugfs_cr=
eate_file(&quot;ta_load&quot;, 0400, dir, adev,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp; &amp;ta_load_debugfs_fops);<br>
+<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ta_unload_debugfs_dentry =3D debugfs_=
create_file(&quot;ta_unload&quot;, 0400, dir,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp; adev, &amp;ta_unload_debugfs_fops);<br>
+<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ta_invoke_debugfs_dentry =3D debugfs_=
create_file(&quot;ta_invoke&quot;, 0400, dir,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp; adev, &amp;ta_invoke_debugfs_fops);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return dir;<br>
+}<br>
+<br>
+void amdgpu_ta_if_debugfs_init(struct amdgpu_device *adev)<br>
+{<br>
+#if defined(CONFIG_DEBUG_FS)<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dir =3D amdgpu_ta_if_debugfs_create(a=
dev);<br>
+#endif<br>
+}<br>
+<br>
+void amdgpu_ta_if_debugfs_remove(void)<br>
+{<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; debugfs_remove_recursive(dir);<br>
+}<br>
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp_ta.h b/drivers/gpu/drm/a=
md/amdgpu/amdgpu_psp_ta.h<br>
new file mode 100644<br>
index 00000000000000..883f89d57616d0<br>
--- /dev/null<br>
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp_ta.h<br>
@@ -0,0 +1,30 @@<br>
+/*<br>
+ * Copyright 2022 Advanced Micro Devices, Inc.<br>
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
+ *<br>
+ */<br>
+<br>
+#ifndef __AMDGPU_PSP_TA_H__<br>
+#define __AMDGPU_PSP_TA_H__<br>
+<br>
+void amdgpu_ta_if_debugfs_init(struct amdgpu_device *adev);<br>
+void amdgpu_ta_if_debugfs_remove(void);<br>
+<br>
+#endif<br>
-- <br>
2.17.1<br>
<br>
</div>
</span></font></div>
</div>
</body>
</html>

--_000_CO6PR12MB5473BE8C2250B7607FA6F86682F39CO6PR12MB5473namp_--
