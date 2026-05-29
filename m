Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3DB2ECD6E45
	for <amd-gfx@archiver.kernel.org>; Fri, 29 May 2026 07:19:28 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D191110F9F0;
	Fri, 29 May 2026 07:19:27 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="eB8qcIL4";
	dkim-atps=neutral
Received: from DM5PR21CU001.outbound.protection.outlook.com
 (mail-centralusazon11011019.outbound.protection.outlook.com [52.101.62.19])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 362F610F9F0
 for <amd-gfx@lists.freedesktop.org>; Fri, 29 May 2026 07:19:26 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IkwfmZijnv3eAS4Ji1gejZxe/ETrh6qX/UubX6QzaQ9IrpFsL/gU4M5WrrgJeNMdaZ/9lUs8/BhFuIGrDZH1vXXLzgIRedU8ik5RZUK80FDwKCaWei2DH+Ekmj6bdV3z8aYggkIxY77J54Tp+qKqSIC5SqEG0tyRHoxTiwJzzbU9pcKr1MNM2EMZ82GrL6wRHcrptLgJDnPxwib4zExVaKtnJB5SrdAbIAGlH+MGfhLiUjHdsLNfllsByAGYeDrcOcGsHPe5ScoItchUl2qq1Q5ieMdk/J8mDsd/J4sivLRRlAm0ka5mQw3ErH2Vm+Rt/Xb63xpblRPPWvTuwbPYVA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pMhIRJ6AL2aZ5YqjMvGOldM4YciHim26IpdFv3QTCTc=;
 b=R9zFN1oaQfynCm0PAfSTG6PM1H8V6zpcYGcH8D+TAGTjUf00H6Po3ENObCbDm0Y5WVP72YwDHtPU+hQlQnGpPrDQg12G1pypBW3m8jP/yI01zHAWP02UQbMDE2XIeHuqFmA1pNdSHbCBSYVZR/AROH1HBqPXJipi468R9f5ne6XQiZ7jfW3VZPhJq4caW8WhKxD4oP0OA3Psak1VwtV0jJn9HA75BP2krEIZ9FdFraxg4OgdoLGXHNUJzyJfMQ7xcuB30IGbIYeIquaYdTnCg66azvKwdBFhULQDJUoucGdLB7+KRbdtOc4VCnGsuQ6q37+t6OXQRx6odXbnc/aMog==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pMhIRJ6AL2aZ5YqjMvGOldM4YciHim26IpdFv3QTCTc=;
 b=eB8qcIL4xg3r42al88+FbqWNzVy/+S+fgH5N+U2wNDrteiUuoIyKmnJuXZ/AS/Bh/xT6VeO9bpZKbo5DOH6edENHalIVflH7AAqN+psCFA+1mZ1uT+rwfvmCdyrErtLl2gSf75/72S1xyfckYFSLmLr58g3zDFu++7h0y1xyVYw=
Received: from BN9PR12MB5257.namprd12.prod.outlook.com (2603:10b6:408:11e::16)
 by SA1PR12MB7269.namprd12.prod.outlook.com (2603:10b6:806:2be::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.71.14; Fri, 29 May
 2026 07:19:22 +0000
Received: from BN9PR12MB5257.namprd12.prod.outlook.com
 ([fe80::1aeb:47e6:faf1:5f13]) by BN9PR12MB5257.namprd12.prod.outlook.com
 ([fe80::1aeb:47e6:faf1:5f13%5]) with mapi id 15.21.0071.014; Fri, 29 May 2026
 07:19:22 +0000
From: "Zhang, Hawking" <Hawking.Zhang@amd.com>
To: "Zhang, Morris" <Shiwu.Zhang@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amdgpu: block the register writing if security
 lockdown
Thread-Topic: [PATCH] drm/amdgpu: block the register writing if security
 lockdown
Thread-Index: AQHc7nEQGW8UbbRmeUKNty4iAiXNLbYkmfWQ
Date: Fri, 29 May 2026 07:19:22 +0000
Message-ID: <BN9PR12MB52578677CEF6B43E3E9F3313FC162@BN9PR12MB5257.namprd12.prod.outlook.com>
References: <20260528070957.1081827-1-shiwu.zhang@amd.com>
In-Reply-To: <20260528070957.1081827-1-shiwu.zhang@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Enabled=True;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SetDate=2026-05-29T07:19:00.0000000Z;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Name=AMD General
 v26; MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_ContentBits=3;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Method=Standard
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR12MB5257:EE_|SA1PR12MB7269:EE_
x-ms-office365-filtering-correlation-id: 50bb7d30-56f9-49f1-02ac-08debd529b4f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|376014|366016|38070700021|56012099006|18002099003|11063799006|22082099003;
x-microsoft-antispam-message-info: vyZa2zPmsQm33kEbQqQ8E+Mh/zqq98Tgwj0c+BrqEPs28otgmIXr5xH9EitiaCOEd47TKo/jxjYwE8CThY/wzkekBj5ly+Ij8ndFAN2hMyzmJS/nb4IQ9EdSwPop7h6oba5qrXsRia8jMRY24JGF3XCz3WibMdqODGEYXNPAk1KEBbycozbW2PTjTtr4vYxZvRvk7l15htsWiTJjJbDPqM9GiRjKtBU/kIm1RXvdumuFsLmmt/zxXIykxToJs/2rMaewij+6uO8jquE4/8Z2HamAPM1ObedAEdy9q44JMcteFJDm/EYMv8gkdjmBXE2OEotnzbdOltizsIqRpTk2Zayp2QQAtaKrZKU6yRz5hAoSnB6pfe1ccxO9IwKLBEddj5xiYYRYyhlEgDY0WwGepW9SsSUa/9FmD6oGiJ8WthyUicxyykdHylHx1vyFSI0qa/+N/oOw2aXbdyJ4lPAVc47l7FkS1nL0Us7/rYmbZmVOpUcMMCqjoKG4z9HnkunjqfIgp8iHnFk1Vj7PCswFI66wOQAu63RNpy6LspC/NiUJe6XX56m1l9HtyW6PhsGQTSB38tkWfHC4eggxR1Er4mupEJD+AZIgJXoIJ+d8b7qdAUthw8wJCN3q5saA/OVWqFoWXl+fPSV2cvRkSJE+WlMUp6bzT3Z6Pivv7EocrvsymoDyLQGc5mnRZZ1orMDwiZNl4WwiC6bAYCb7XAqXIFt+Nx0yeVuvQoAyU+n2ocwBUPtr5rKLSP4sI1eQMdCE
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5257.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(38070700021)(56012099006)(18002099003)(11063799006)(22082099003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?PkNkCo4sV2T6fVPBztJ83DjxZMpnwRCYqtnGNZBecQpyhwLqXFbC6EclWX/N?=
 =?us-ascii?Q?ZVzuzcaKxkZMxuw49iypdg81TnVepAfaXvNRIO+hyo8v+YoqdO5YyZiGNN7q?=
 =?us-ascii?Q?siTSh/3B+d49rqxPgb7qSK+5bBJ6gh3cywnt74HBMKoLVNV7phdckpKPWeHT?=
 =?us-ascii?Q?P4JX8O0JhXi/zTmDaKyAo6u+fexETeE/f2zvASOLWzh2PCJs8irFZNPy6QVq?=
 =?us-ascii?Q?vtu/4U3wCrbTFe2oMfdkNOmZbCnVrT0RNrtu6iASoEMwsDHFXkwJN4zKX68K?=
 =?us-ascii?Q?7kOqXJ8u19VDBZTbWJLadLBCfYk5Cagwcy1t7IeboeP+BtCKvpMuhayNd2fO?=
 =?us-ascii?Q?DhSnpbvupqd+p2vXHdqzsPtWrnWcqR62WcZQ7LRcSTure8CI++VifQBZ36si?=
 =?us-ascii?Q?q1R+CQzw71lWwTv/xBykKzVk977RXqIHDF9ev2ZK7mbUw5RuvMqXVoqADoAl?=
 =?us-ascii?Q?cLSlZDbOcjVASblkzDDRTznovoA+IiGRuu+nwpZccFIJAOVm+WRtln5m8qyA?=
 =?us-ascii?Q?epMYWpk60+OUKclGrTIGiHrm/+ZDnqo/0DnSmTYOxcuOxnOMFIdpiy09Memi?=
 =?us-ascii?Q?6E6xWm0Ra8ycH5y6gGHmti7MQOL1aVaQLPv9dLQnAKqIfFtawwwCeXwo1ZDS?=
 =?us-ascii?Q?K2D6rfbKaWvfMK7KgAzp2Ester2E0orCynN5i1BVaD269MlXstrwXX6jkDHe?=
 =?us-ascii?Q?Dfs0bnx80Pcx8ovCZPwtU/BXe2ZH+QuZYvorYAWtKxuOkKUYZSgkMBCc0fcb?=
 =?us-ascii?Q?hZ6dZsBaw7JMYQLXOTR+SPN9NS4sS1ujuHHifxYKZUjsqIBSdzKI2fB60pk3?=
 =?us-ascii?Q?xKRwzm/+VtW8odbdGRnhkgL92v3r7x8ktYz8tjurHtZe6zr73JhiVZKzqbvr?=
 =?us-ascii?Q?tmVfbNnUt0YjeyBvqsi53Q8BVz814BYUu0ICumtMzi0w1NBibTwmOv9HhDWd?=
 =?us-ascii?Q?OtrouGJ7A89wPtGsBfdIINRgNkhFSLHM2gukWEwz7I7rm1bjGj2sC8fdp61X?=
 =?us-ascii?Q?QvNlDQJ8WmUhA2vu4mhoReuJ7Kj49y7i0s0M0r3mZv72pHadgy4DkgIWJ9oG?=
 =?us-ascii?Q?qyvxMzGGsKXmntBVfNLZT/9vGLN4Ytfuhem/sXABQ2s8+8ihHt4ydNd0KSKd?=
 =?us-ascii?Q?iSG+sysMAntE3FSEGkj+JohUTor3oNe8lSIicwUIHDC+mLqJDP2qaqAOaxrF?=
 =?us-ascii?Q?YDUeLTDPrCqju0ke2rzerHac4amMdL9U/vPVfnNAic7CZ9q0gLwY2QBOoc3A?=
 =?us-ascii?Q?YGY1AWsXdP2OwpFxBruR8eKk2SASQukQggePhBIcX2vOWAdwUi/ztnXqsR93?=
 =?us-ascii?Q?ih0RhseiDE1ZCyiSh6qsRPpsP5uTahR4EtQWrc5L96qhKPQBXo1N5/5g/sCq?=
 =?us-ascii?Q?uFUyJVJEnJNJonRGn7Jn/ifjJIHHWz9nuGOonaPMSzN0JX5joMH8KnrEvIZx?=
 =?us-ascii?Q?Hl0Ib9tJDoTDCa1pCFdrigu8lbcx5I3Gw1gwrk3Nik3KLbYrrVXXzsiBmzDx?=
 =?us-ascii?Q?HBeFII3aRfCHaULdefpYcRyRGbhQg5m0k8kFzgSp2SIQid9kgI5qgE+rFAOc?=
 =?us-ascii?Q?XAcjaaaf9fv12E9cv6YGeMVzSkVy25liznt+i9OKYlQmN0g/m8cvBslH78Oj?=
 =?us-ascii?Q?5H8Dt5naZMaxCm9+2mHTc/C+Uz34AGpSFO3WE5AYwQJT+yp7TBmERcR/2o4b?=
 =?us-ascii?Q?GFdC9OtucNOXu68TjSVWRmLNG39uTy96FwpBBnalRAqm4ohQ?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5257.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 50bb7d30-56f9-49f1-02ac-08debd529b4f
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 May 2026 07:19:22.3651 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Mmsnb9x3s2kALGA3u/GMAwQ42Z2GHD0MKQQPloXPtvGSCOgjwt9EacZk0rEjx+2BHKap8JXfnVC9ScZSHjo0Zw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB7269
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
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Shiwu Zh=
ang
Sent: Thursday, May 28, 2026 3:10 PM
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH] drm/amdgpu: block the register writing if security lockdow=
n

In case of security lockdown with integrity, prevent the root from changing=
 kernel/firmware state by register writing to comply with the LSM security =
requirement.

Signed-off-by: Shiwu Zhang <shiwu.zhang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c b/drivers/gpu/drm/=
amd/amdgpu/amdgpu_debugfs.c
index 0ce6e2e4342c..3f9e5020722e 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
@@ -27,6 +27,7 @@
 #include <linux/pci.h>
 #include <linux/uaccess.h>
 #include <linux/pm_runtime.h>
+#include <linux/security.h>

 #include "amdgpu.h"
 #include "amdgpu_pm.h"
@@ -200,6 +201,9 @@ static ssize_t amdgpu_debugfs_regs_read(struct file *f,=
 char __user *buf,  static ssize_t amdgpu_debugfs_regs_write(struct file *f=
, const char __user *buf,
                                         size_t size, loff_t *pos)
 {
+       if (security_locked_down(LOCKDOWN_DEBUGFS))
+               return -EPERM;
+
        return amdgpu_debugfs_process_reg_op(false, f, (char __user *)buf, =
size, pos);  }

@@ -365,6 +369,9 @@ static ssize_t amdgpu_debugfs_regs2_read(struct file *f=
, char __user *buf, size_

 static ssize_t amdgpu_debugfs_regs2_write(struct file *f, const char __use=
r *buf, size_t size, loff_t *pos)  {
+       if (security_locked_down(LOCKDOWN_DEBUGFS))
+               return -EPERM;
+
        return amdgpu_debugfs_regs2_op(f, (char __user *)buf, *pos, size, 1=
);  }

@@ -577,6 +584,9 @@ static ssize_t amdgpu_debugfs_regs_pcie_write(struct fi=
le *f, const char __user
        ssize_t result =3D 0;
        int r;

+       if (security_locked_down(LOCKDOWN_DEBUGFS))
+               return -EPERM;
+
        if (size & 0x3 || *pos & 0x3)
                return -EINVAL;

@@ -684,6 +694,9 @@ static ssize_t amdgpu_debugfs_regs_pcie64_write(struct =
file *f, const char __use
        ssize_t result =3D 0;
        int r;

+       if (security_locked_down(LOCKDOWN_DEBUGFS))
+               return -EPERM;
+
        if (size & 0x7 || *pos & 0x7)
                return -EINVAL;

@@ -798,6 +811,9 @@ static ssize_t amdgpu_debugfs_regs_didt_write(struct fi=
le *f, const char __user
        ssize_t result =3D 0;
        int r;

+       if (security_locked_down(LOCKDOWN_DEBUGFS))
+               return -EPERM;
+
        if (size & 0x3 || *pos & 0x3)
                return -EINVAL;

@@ -915,6 +931,9 @@ static ssize_t amdgpu_debugfs_regs_smc_write(struct fil=
e *f, const char __user *
        ssize_t result =3D 0;
        int r;

+       if (security_locked_down(LOCKDOWN_DEBUGFS))
+               return -EPERM;
+
        if (!adev->reg.smc.wreg)
                return -EOPNOTSUPP;

--
2.43.0

