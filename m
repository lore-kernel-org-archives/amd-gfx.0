Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CB85DFF8867
	for <amd-gfx@archiver.kernel.org>; Tue, 28 Apr 2026 03:16:45 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 56CF210E2E3;
	Tue, 28 Apr 2026 03:16:45 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="WO4EgXZx";
	dkim-atps=neutral
Received: from DM1PR04CU001.outbound.protection.outlook.com
 (mail-centralusazon11010026.outbound.protection.outlook.com [52.101.61.26])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C295310E2E3
 for <amd-gfx@lists.freedesktop.org>; Tue, 28 Apr 2026 03:16:43 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=A7Lz+1KKiATxiwOZXeRZmhmffzbz/nWiAQd42biKZlCe2Yo+I9Fk5+qf3vvMWNVsaK6lB1UM9t4yI+jLBXOr3UDToTZAGksCtpKIACnepI6EXivK5CLHNXhNsrdNc3CFz78WG06SYLXAj4kZtvPolzjSMQMTgogBwRZx/j92Spq8TKU5RghQrSCGwCQN/znv0p42QgDC71C7OOezmEVe5r3iFCVj+g44o6yV4d3hp2NcheoVmyEyKy+TW6zYzfakawQfM/Jrcd03gotwQi74zvBEvM10GsaD0qW14cUhybJr/JYCylMnVjb+Tiy10uLbUd/KmPJaYW8ii32C+PF9qQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=m3ahqwAFfeTi5Pg/LrdFDtUuA385HTDikWIUIXfXEbA=;
 b=jaFHhdpUn3aWe3GSd1ECdPw+YkumWXC7yHgv/4I17PNbc4rr0JHBO30B1vcFCM4UO9qDuwg9TcR/AthGA405vO8Rr0VpMAfve4WiRLg/k3W+y13ad/Cm5RXhMfDXM4q0Nlalyx4xZwNs6MJIhFcr1DfikyVGwvwbSlcfdQXpXn97u+Tn8dq9ZQSU1DtIJbq02E+MUuuJPUQA/Q5ItLNOblHxydmCjcvzmgE4exNj1tICWRlqJ8q8xX0ZoJ8TBYAYiEcJNkqpo4EfTgdOj9G62kwueNMPmJlRicS+s2o8JQjuBqRhmu6XVW8ysYGapdtfA0h/oC2QQwdp+bmO3wyWKg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=m3ahqwAFfeTi5Pg/LrdFDtUuA385HTDikWIUIXfXEbA=;
 b=WO4EgXZxt6NGm+xo5+tYiG4tjFZFA8QXy1Tn0YdDaTctuDZq1ny+ROOTb6iYnHbqbcO9iXthwXuDHw3qdXSJ2EUSqp2KjTnFU6E/HFFrELe1XqnHWfVSLpdnzHovG3OSAzfCYgBpEOD++Avg2cfU71yw05dSSi54Y96TwcvLN9s=
Received: from BY5PR12MB4179.namprd12.prod.outlook.com (2603:10b6:a03:211::8)
 by SN7PR12MB7201.namprd12.prod.outlook.com (2603:10b6:806:2a8::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.16; Tue, 28 Apr
 2026 03:16:41 +0000
Received: from BY5PR12MB4179.namprd12.prod.outlook.com
 ([fe80::2036:e8b:9b3:f325]) by BY5PR12MB4179.namprd12.prod.outlook.com
 ([fe80::2036:e8b:9b3:f325%6]) with mapi id 15.20.9870.016; Tue, 28 Apr 2026
 03:16:41 +0000
From: "Ma, Bing" <Bing.Ma@amd.com>
To: "Zhu, James" <James.Zhu@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>, "Deucher, Alexander"
 <Alexander.Deucher@amd.com>, "Francis, David" <David.Francis@amd.com>
CC: "Zhang, Jesse(Jie)" <Jesse.Zhang@amd.com>, "Liu, Jenny (Jing)"
 <Jenny-Jing.Liu@amd.com>
Subject: RE: [PATCH v2 09/17] drm/amdgpu: add profiler/spm ioctl
Thread-Topic: [PATCH v2 09/17] drm/amdgpu: add profiler/spm ioctl
Thread-Index: AQHcu9QXPigmYG/AKUu+yQ+sYvtTfrX0AyfA
Date: Tue, 28 Apr 2026 03:16:40 +0000
Message-ID: <BY5PR12MB417920FC848D45FBB47552B1FD372@BY5PR12MB4179.namprd12.prod.outlook.com>
References: <20260324212030.822932-1-James.Zhu@amd.com>
 <20260324212030.822932-10-James.Zhu@amd.com>
In-Reply-To: <20260324212030.822932-10-James.Zhu@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Enabled=True;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SetDate=2026-04-28T03:16:29.0000000Z;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Name=AMD General
 v26; MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_ContentBits=3;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Method=Standard
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BY5PR12MB4179:EE_|SN7PR12MB7201:EE_
x-ms-office365-filtering-correlation-id: a549819a-fa4f-4d12-e27b-08dea4d4913c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|366016|376014|18002099003|22082099003|56012099003|38070700021;
x-microsoft-antispam-message-info: GM0wlLIgUzYMBwB7VkJIrtaWymJIbA2NjcHw0GEm91ks8dPLLxvjMh5k2pYetZdejuqV0MszNLBxM1k9lajqb4YoZgP3OpStFYeqNH6RASPo8lZBMeTJPyt/ecnGbr1uUYJWPXqng4S2Pi+qrtKp/G/4oGY/fhiy2IIYX/iJMFWV8+gW7otU/YLnYd7rfsocT3r2mfu9sq9a+vSi/oEn1lMDzNS9vRgA3xSBG8FMduQPDJEKHILs/s25mRCRBbj9dYnR2s4DZMripgmjCQaLaUpXV2mwOWLLrawU5NuDl+OCUdNmg5tph1YURubr8vitr0rNHGtkeMiaCliRMGINWqEhqDK/nP668fPYDEDh5n+hauenhy42RyE/4O4gcC7+HJgiUNPnMjFunO6AP9KAf9uM3sNThWBfQMWlHAXlhgpLnzt1nCk6rkKJW9YKfraDwEHUDjDZ7ueyLoVHqqMDuQJmAPpI3FLJVvBMFxQHwTwjwEwaRQ8wkcFF9P4HXnRvpyb5v6ogD6AStFR2o+hKmPLXsSEKBOa47vlrWgCaPN4AhQ+a9ld2YIo2twcDmcuy1p2Y3JJ3ASx0U87RQuJbnu631NxaSq7TANOtUdDANcxtmekAsUfTdld1zn4cW7dfAjEn/ghREQvOiPkRTz1v/EgsbqYtMNhxQSSLaQYzrg0n8XdXDy6n44nKeVXtYRadr9DO6v6MhbI8sFr2TD2C8M/voP9BxO2lGJFjZbRbySCzyxCIl8ZU/pSkaxGr7W9IlK7p4wSm3BigZuM4dUB9jBPudz8rqEP3YPYkkxEGaus=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BY5PR12MB4179.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(18002099003)(22082099003)(56012099003)(38070700021);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?o3+UVQ6sK92FGowH9/5qWavzTwGaRCDgEap9j0/s1HPhDK30LWhE/+sq7cW/?=
 =?us-ascii?Q?cBNo7QWc/UTPH3piZdbVJ2OPPuhMQfRJz3e3giFMnBaGTmJ+sC8biAmUJXTw?=
 =?us-ascii?Q?tgzlIf5uobEFSOWdB3rhXXoYXRsp0i4ITD/crfPTZ3q85pHZYDEysLXNu/Tm?=
 =?us-ascii?Q?6ATVU3JV9atgpfFEfYxH+7GDZj7GBRC/28nsl63SLBMYDC4CwcHLOfOFAlBe?=
 =?us-ascii?Q?zkCH8lhSkQPuRCrk6EbLbNxmACaRjFMqzrBpqZFmiIyZIGbr3Qo4LEchjbCu?=
 =?us-ascii?Q?SjyWWdHVQt8pB3TH/WMoj2Vp4mp8W5DrBuZ7Cg/OEoR9YO9MnVqxxCRoV19S?=
 =?us-ascii?Q?ZF4fYY88je47FUmELT1eaM/B2Lr6PUpeGrM7o72DyygbKDg3IUvfUDX0+GBK?=
 =?us-ascii?Q?M1Z7kGcfl6jNOB1TpIucHd0rQ+0F5x+dj96H8YDGnlqx0b5myMXvudVb4OXL?=
 =?us-ascii?Q?kdz1/M/nzSKeHGLjvFiAiH5T4wxf7RxBcGPdGZ0LAO1V0zAlvUSG+uCklnRI?=
 =?us-ascii?Q?pdnaxrZIa069kyRC27YgRuiTkaSu0GQzgSEizZ9IjTTubZ2IyWM7jVmZ5rdC?=
 =?us-ascii?Q?V4oKhac0ON+Oe02nu43axVl2kIkNsZbqrIR3LB//sAgI1kl2/8XI+D/kNIRg?=
 =?us-ascii?Q?9svg9KtEGdTgyQ5EeTBHAQcggJW/PRVwnopcMEoMYPyZUpfQjFd0o2lz+4Rw?=
 =?us-ascii?Q?3Yo0LrHnwo6kCx1gQvABxuKuJJMFNnz1n1Qpaq7OvvJBeub1lT2NKYUScv7y?=
 =?us-ascii?Q?9XXAA2frtiYJDySipboVr05BOt9AEmfKVPIJFjZwIRviBvQdi3WqP4hoRZBj?=
 =?us-ascii?Q?OM3MtKTWeVdIGTIPgz3QEwaNj9fe8bm1aM+XzSgsP6MOYK21YtPJchgLvLoI?=
 =?us-ascii?Q?twD9ui8+BQGxv9yUChp346GDJzmeeWKm2oaWOhE5dX85SwYYRlF72zpYUVHE?=
 =?us-ascii?Q?j5AjQSqpMd3iGOmzQ+SJukkhhurE612rxhxQ3gBt96AX3mHLckOB+TMlSZaT?=
 =?us-ascii?Q?gTM0kt9vtG8t+9DBMPnTtE8+d0w9i6z3GkKpNwVyQVKRQuZYH+783iF9YFqg?=
 =?us-ascii?Q?PP+NR4P9f04HSp1fYuzEFCO8yh4ZQesB0xdjWFWVdMPX86ramnRzvvVnIUEH?=
 =?us-ascii?Q?Gc8xwE79DC99lJr6oxDfu38fIffFOX+C+KlPfTZgPlAjOi3Squ4xpafMiepe?=
 =?us-ascii?Q?6aGLZQHi7JwLureCgbXQjdVUMpiM3ykMIkzfCM/Z9CdGHDTjk7agho0ASgS3?=
 =?us-ascii?Q?nwjzYRbGCJPLIArz0n4Bte9TBRUKyOfzuFq1UFLX0p06QipBeu4ni4fszpRt?=
 =?us-ascii?Q?y9TcYyMFnsAbGoqj7fphB/xwitoY+XqUPifYpFzuLzOZ2JRrtdixx0fBNJQM?=
 =?us-ascii?Q?b0RMXVZjzSLo4s2xxKH5+I+CgixAGAY4ZTG+zmoD2ttXSoMMLt5HUZTxDjxS?=
 =?us-ascii?Q?fFVs8oauv/hxK8ONsQBzP9d1l87Plh1OXID8vGbG4HJAy0xd2WRvC6I80byk?=
 =?us-ascii?Q?5npONfQ2iNsoNUYhU8GmNccoCZ/ND2mI51BSdcksp5oBF6ECrRfEHVSHxQwB?=
 =?us-ascii?Q?dQHwsJDpWthca51ZjRf15qHSQQkrMhIoF6yZY52QangHbSFN1/V1ywX1BM/o?=
 =?us-ascii?Q?eR0us8U10D6TohEBC7E0Y9V95NFDaR/weDq9Z9GNVpcRgIHnMWsp+SEByA39?=
 =?us-ascii?Q?dzvldELKL9G5DNbJc5t42prFnxq9TxWUUkpnjyvVwHLXVWp9?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BY5PR12MB4179.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a549819a-fa4f-4d12-e27b-08dea4d4913c
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Apr 2026 03:16:40.9432 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 2iQohNCqz6/otOPPTYa28SkNIF91sy3vhCT+C2ds1bwSyTDkmZOzNnj9jmqy9a/QVW00vIWWRNR6HOBIEvTw/Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7201
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

Reviewed-by: Bing Ma <Bing.Ma@amd.com>

-----Original Message-----
From: Zhu, James <James.Zhu@amd.com>
Sent: Tuesday, March 24, 2026 2:20 PM
To: amd-gfx@lists.freedesktop.org; Deucher, Alexander <Alexander.Deucher@am=
d.com>; Ma, Bing <Bing.Ma@amd.com>; Francis, David <David.Francis@amd.com>
Cc: Zhang, Jesse(Jie) <Jesse.Zhang@amd.com>; Liu, Jenny (Jing) <Jenny-Jing.=
Liu@amd.com>; Zhu, James <James.Zhu@amd.com>
Subject: [PATCH v2 09/17] drm/amdgpu: add profiler/spm ioctl

to wire the AMDGPU_PROFILER_SPM operation into the profiler ioctl dispatch =
path, and introduce amdgpu_spm_ioctl() as the dedicated SPM sub-ioctl handl=
er.

In amdgpu_profiler_ioctl(), the new AMDGPU_PROFILER_SPM case extracts the e=
mbedded drm_amdgpu_spm_args from the profiler args union and forwards it to=
 amdgpu_spm_ioctl(dev, &args->spm, filp).

amdgpu_spm_ioctl() resolves the per-device amdgpu_device from the drm_file'=
s driver_priv and switches on args->op. At this point only the default erro=
r path is present, returning -EINVAL for all unknown operations. Subsequent=
 patches will add cases for AMDGPU_SPM_OP_ACQUIRE, AMDGPU_SPM_OP_SET_DEST_B=
UF, and AMDGPU_SPM_OP_RELEASE.

Signed-off-by: James Zhu <James.Zhu@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_profiler.c |  3 +++
 drivers/gpu/drm/amd/amdgpu/amdgpu_spm.c      | 14 ++++++++++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_spm.h      |  3 +++
 3 files changed, 20 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_profiler.c b/drivers/gpu/drm=
/amd/amdgpu/amdgpu_profiler.c
index d462d99dc8bb..194bd9339cad 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_profiler.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_profiler.c
@@ -50,6 +50,9 @@ int amdgpu_profiler_ioctl(
                                        AMDGPU_PROFILER_VERSION_MINOR;
                return 0;

+       case AMDGPU_PROFILER_SPM:
+               return amdgpu_spm_ioctl(dev, &args->spm, filp);
+
        default:
                dev_dbg(adev->dev, "Invalid option: %i", args->op);
        }
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_spm.c b/drivers/gpu/drm/amd/=
amdgpu/amdgpu_spm.c
index af7ee74aaa35..6ff88dfabf1c 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_spm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_spm.c
@@ -47,6 +47,20 @@ static int amdgpu_spm_release(struct amdgpu_spm_mgr *spm=
_mgr, struct drm_file *f
        return 0;
 }

+int amdgpu_spm_ioctl(struct drm_device *dev, void *data,
+                      struct drm_file *filp)
+{
+       struct amdgpu_fpriv *fpriv =3D filp->driver_priv;
+       struct amdgpu_device *adev =3D fpriv_to_adev(fpriv);
+       struct drm_amdgpu_spm_args *args =3D data;
+
+       switch (args->op) {
+       default:
+               dev_dbg(adev->dev, "Invalid option: %i\n", args->op);
+               return -EINVAL;
+       }
+}
+
 int amdgpu_spm_mgr_init(struct amdgpu_spm_mgr *spm_mgr)  {
        amdgpu_spm_init_device(spm_mgr);
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_spm.h b/drivers/gpu/drm/amd/=
amdgpu/amdgpu_spm.h
index ade50abfa590..dc55d2a8f016 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_spm.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_spm.h
@@ -28,6 +28,9 @@ struct amdgpu_spm_mgr {
        struct drm_file *file;
 };

+int amdgpu_spm_ioctl(struct drm_device *dev, void *data,
+                      struct drm_file *filp);
+
 int amdgpu_spm_mgr_init(struct amdgpu_spm_mgr *spm_mgr);  void amdgpu_spm_=
mgr_fini(struct amdgpu_spm_mgr *spm_mgr);  void amdgpu_spm_interrupt(struct=
 amdgpu_device *adev, int xcc_id);
--
2.34.1

