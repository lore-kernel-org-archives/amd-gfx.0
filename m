Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 66D4EC369C1
	for <amd-gfx@archiver.kernel.org>; Wed, 16 Apr 2025 09:45:39 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4491510E8BA;
	Wed, 16 Apr 2025 09:45:34 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="qDMsTR9e";
	dkim-atps=neutral
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2076.outbound.protection.outlook.com [40.107.237.76])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 117A110E8BA
 for <amd-gfx@lists.freedesktop.org>; Wed, 16 Apr 2025 09:45:33 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yZzUDqGCT/5vUoW2d0Pw6wBPKpUPkZO9doN206lJ6XxOERTSZI1fYrneGJ+v+iP+rUZHm2xbBc5XnbU6zZhJb7tcoGbdS/0pi8GFTWe9rMF1q5Mi+3ofy975PDjk8D/XVVRuwEfBUuZ8um0wtjIwsZJ1qwaa669F3I1uAHf2q4sNZbS4i573fSUyK4N8vXTXLWMps4OFzxlroPyKpzj+C+qGPTW2rgLfRSq8Sv98zTR25FH3pZHFRWdvyTDFVbittjnEcibMe4CGDCAwdaS+VW4nxRc4e/gkQvQe7qdomu7VVUPw8EBjfa2g00V67SV+mWc+sMfPRX8OnBj10K4tag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GBX6pW0LCiY1QKfGQnIMV8FZ1kAU0ye84aZveZMsyLw=;
 b=P1Ht1k8M5b+ppQHQc20AEx44bqZ03Ikch/XsVY4yCOJGf4jtWYxuCUdR37D/pbTfaVvQNmAYRKiJ6S84NjexUAd+JaJVL40c9247otXogXc4WMiPeA+7ljqCrgt4jT1pXuxY2BViqChiphTXVn7CgqfTSaUT9h0CZSwWdU3TbjSupIQbk0pO9ffkyk+q83S73cclbaMofNfQLZgFNE/10Cnnbqq/AMLi+2/LcOUPEu3MXrHRRJtEVQ+bbhLOPnjIZIEOTNtA1dj3Ccr32NIX3BjcRIneZtUZlppztHoj0AoWnUfN3MRvi0pMlF89QQQXqhHsM4Kibwlf24i9BhDBLw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GBX6pW0LCiY1QKfGQnIMV8FZ1kAU0ye84aZveZMsyLw=;
 b=qDMsTR9e0p1g81jcJk3aAfC+6Zm1g8GoqXO4lQVsBTcc/5OJuq/VxDXyJR3zPPNEOhI7o3/jzNhEMNLltVur2ZpIDii89P0oigq0nfJ2dj1XpnBg5FCATLK3lAub8iUDiKalwh8fbtHik2xaqzbGGfYf9ABmhZSsg45JBcK1sQw=
Received: from DS7PR12MB6071.namprd12.prod.outlook.com (2603:10b6:8:9d::11) by
 PH7PR12MB7329.namprd12.prod.outlook.com (2603:10b6:510:20c::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8632.35; Wed, 16 Apr
 2025 09:45:29 +0000
Received: from DS7PR12MB6071.namprd12.prod.outlook.com
 ([fe80::be26:4c33:76bc:e1b]) by DS7PR12MB6071.namprd12.prod.outlook.com
 ([fe80::be26:4c33:76bc:e1b%4]) with mapi id 15.20.8632.030; Wed, 16 Apr 2025
 09:45:29 +0000
From: "Kamal, Asad" <Asad.Kamal@amd.com>
To: "Lazar, Lijo" <Lijo.Lazar@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
CC: "Zhang, Hawking" <Hawking.Zhang@amd.com>, "Deucher, Alexander"
 <Alexander.Deucher@amd.com>
Subject: RE: [PATCH v2] drm/amdgpu: Disallow partition query during reset
Thread-Topic: [PATCH v2] drm/amdgpu: Disallow partition query during reset
Thread-Index: AQHbrqc4rvR9O4AyEkebHRRJAWafkLOmCx4g
Date: Wed, 16 Apr 2025 09:45:29 +0000
Message-ID: <DS7PR12MB6071A3CC7FBECB2250B84F528EBD2@DS7PR12MB6071.namprd12.prod.outlook.com>
References: <20250416081134.850454-1-lijo.lazar@amd.com>
In-Reply-To: <20250416081134.850454-1-lijo.lazar@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ActionId=94674d97-cabe-4c48-8158-0021c2b0878a;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=0;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=true;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution Only;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2025-04-16T09:44:56Z;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Tag=10, 3, 0, 1;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS7PR12MB6071:EE_|PH7PR12MB7329:EE_
x-ms-office365-filtering-correlation-id: b85d063e-df68-4d65-1125-08dd7ccb6c3c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|376014|1800799024|38070700018|7053199007; 
x-microsoft-antispam-message-info: =?us-ascii?Q?EomIuLauF7VNNjGuIQLSY/apnD9DIdDuTCFTuJARKQ7TZ3RSR6xfl3Dpwpgj?=
 =?us-ascii?Q?bCQ61zW27TlAipMkEhiCP2PDaHb6wJh5gNXg2ZRXDhoEFElRuvOOPL45iaq4?=
 =?us-ascii?Q?UU75V0v5rAV7x4XSGV1fmdVVXpwRYVEmx/AkPDJPM9532+JRCI6rsLtP6QpY?=
 =?us-ascii?Q?tE6Mn3UwhNo5l6653YeEDAZTbraR/adCtrW5THmdL2SCq5MCk1kwM+RpFXq0?=
 =?us-ascii?Q?3EMUoRzXuU+9VcEdEn5KKoOZuWcu5gKCWC/8EQ3YS+dDmZAWOzUGB+2hXko2?=
 =?us-ascii?Q?3CHFsL9tBWpHgyd2V658glGYkzebzHlJTrcKwElhWWy/0SN+dNn35kJ/re5s?=
 =?us-ascii?Q?6b1Ga1sLzS5skbrurZ+vSZjit6CU3sOTySpc9fdSG9CGzdaZVRdPfk0gnbKW?=
 =?us-ascii?Q?Qi0tpWHsnzdT1M2+whZoh93ZW1bngrjygv0P8vYc/y7TQNT18RC42fbgUSWL?=
 =?us-ascii?Q?4u4vKnFF+u6aHEtdY2dMN/dX1M4qc5PKAHLR5Dlok8BuXBRCaoYgybBYYZNO?=
 =?us-ascii?Q?zgN8BiCJnL9KXMq6wRT+rW8vt2lfys3mEQz0u/fQZmO4fBx4DHT2x2dmWuw6?=
 =?us-ascii?Q?cJB2/kt6r2p4VSbm1y/aowKh0L9qeTEY3qay8vteTzQPHfgU/DmiLzZiX9az?=
 =?us-ascii?Q?00hqGJS3y1bjH70IpA16F8AHWNCoMIh6DbtGwUP3TA+4um+tG+IX+H3ZTeX5?=
 =?us-ascii?Q?XomHQarKlDCZd2RG6turISTSyrypGV0am7EQOoDEhqGqpwKTwA6ys+2+/FbH?=
 =?us-ascii?Q?dDhudgjBhy41r2jpWG1LtncQhYVCnKcImrlYGU0TUltheJP6cASz0lF5FD0N?=
 =?us-ascii?Q?i/sp4Riu5+/F2nKgIY4NjtV5uoORzfVVTxsHHy4HfwvIt85K1U8LHRZ8tmJk?=
 =?us-ascii?Q?+r6z/B1VZ6mD2lPhGYsNUqpe5NQ3CPwPcxClQjEwOetCdmQGcssjxac8u2do?=
 =?us-ascii?Q?bY96Rd3AlrgRQHRW62CTEO8H9u0+WaqGbO/IqjDDiSDvk3MXFtvfkjqwDBsR?=
 =?us-ascii?Q?atZHvKt/OEQmsSdt9Vo7lYK4qaG3vJvvlkUoi+bwmtkmHTPOtWG1+RjlxPC0?=
 =?us-ascii?Q?ryUQfXcpVG36gd1Y481x1mTObKYCrJ8jcUIexePfkfRfLPWAaHcOJ+vHrRwZ?=
 =?us-ascii?Q?60IJshHkDxI/CH/vwAhbCufP1ivDOHdyIHh15PFefEkeMkAuDJTtg4OhTrty?=
 =?us-ascii?Q?OSDYW/wKzDrjLKFH/iLE0giHnTaxd268Uw2P4PY4rTBKqi1+Kj0/JIZhb713?=
 =?us-ascii?Q?rk0wPI1va5bnPSdGHFv4hiMKg47MoSF/RgSxehb5PtPh4Tbz5rpba9WQtgvv?=
 =?us-ascii?Q?d3WfqtHc1S8Xkhv//oxXQdyuQa+llK5SGJXVHlMJZQCu9+JjuXJuX64g19Rb?=
 =?us-ascii?Q?6/OupV2nKIFnuKExkrYFu3P0G4o3AIjHfh49VK0SHbDrLQiODk6D18NfTAZR?=
 =?us-ascii?Q?1p3YJlpUjO0n0bW5wUyGMY+0VBjLwSkwTOgEVRm13wrO/9iRh/ydug=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS7PR12MB6071.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(38070700018)(7053199007); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?SF6fxqEsStuVsKFRyDUryp6/tKCl11jiTJIzyICSgYDugxYJbbeY1gVpiqaj?=
 =?us-ascii?Q?XhAeAO1N7y2RfeXWtWnJJWpcl2dWVmvvdgdp0FX7PAT+gkhOX1gC/wztObwv?=
 =?us-ascii?Q?CPfymB2SIysDwprZU9bnt7eMau6UmKwCiWk0beMmrNULMHq0tGnb98vGy4ld?=
 =?us-ascii?Q?3kSzjLUup272oP9k4BpIS92X3QtAGTzd6xxWbPRSIhPNYq8uvgkCLGtM+cfg?=
 =?us-ascii?Q?/yF6OtJYqQ00qa2Gq2AirBdbutiAh/MvQHYHmc8OQiDr4TKDj5S5dFp0c8yx?=
 =?us-ascii?Q?WkdrFpwrQXVFBhASVcduFPN6pwPFHI+sokpU6y4jTu+ueymSp8MRFlNQTJGj?=
 =?us-ascii?Q?Jze/hYgczKp0rdiapcT3BcRo1neaUlg/gNSqnHATx5O4TDsfbGheOsL1oXPD?=
 =?us-ascii?Q?MOQP4PtpGIBbBmj3T3YHTq4iulzOJSpNSeEddunxkYOobO8r4w3b7sC+MccS?=
 =?us-ascii?Q?rYHCiNtWOYwNPDTurp9wDZIVMJZjrTvH7nK24/HiX9cF92dO1fPKyOUiY2i4?=
 =?us-ascii?Q?mtxb4r6mRPk+I96j+oQBVkDVQm1ZWeKsoJmDV/e7I64hCA20wkNDZ+2UIecW?=
 =?us-ascii?Q?QYXi/NmZAj2nI5bXTGx6s/BFdiI/6opJtF0FowdxvgHhiBcG8uTVOZ1gKHUw?=
 =?us-ascii?Q?CkOnrktpjRbgmg/V0nM7sjC28mXgidaEj0mMIsHo7NraxC/o0oh7nOHq8nGq?=
 =?us-ascii?Q?uuRan0WFswoLWAk6ifgJ6ls7bClerkV1F15eS5HNVWrBwNhosoR3EDWdfIcS?=
 =?us-ascii?Q?FczUwYe9HOarRbUFAo1JnO5cDSYeT2nDIOAkhUYDj0HXpH5VpIquxw0yiFb6?=
 =?us-ascii?Q?VCjrTv+jFVzipAR0RR6DCsZJGQO/cK6//gnwMdzeUHC/86D/m8iZZxaW3dQ6?=
 =?us-ascii?Q?s94b3IsAOwh05FmR8Qz6i+pmsAremkRSh9Iwxng1TB9nRmnBjGT6jtT2FhY+?=
 =?us-ascii?Q?M4Zro97r4iL8uciIlw/YOrbKbvVf9sX1vHNrHPR83C8nOT6jB7PNeWZiIm3+?=
 =?us-ascii?Q?3B/9yKmsieRMFFirPMm2OwFVHMH3pEYnplPqdT060Yhd3sE4SJWCkaK9P7Mv?=
 =?us-ascii?Q?Q9OdBPjRI/yOlmKLieMUwSg7uSsDjzouAoQ1H1Prq3KRjLUX6o6vA0D5X8SA?=
 =?us-ascii?Q?Lxem3hGRf3Yzg9nLM4M1YIcN5HJ42qCIx2J7hoZLBzZ9iEk/SVc8/kFgjg6/?=
 =?us-ascii?Q?WFgbJHezDllD/ivDgkG4TbdQPVDFKLGrzCOFMgX2hPP2N3J+eji3PzGg+4I3?=
 =?us-ascii?Q?cmDIrfBIxlxJSC7EiroMB4jhORbU99FkEQjn8Y+OVDdrOsLZbRXYzfkBeHag?=
 =?us-ascii?Q?8++y99139eQUIMsrXm5h6nJXFwK8nRn0puL4F5oyMaQ+A0K0FeBPOvUbXWmx?=
 =?us-ascii?Q?00B1KmzfzFcdb5+HbA18Beh3yMRuSgIhVdz4WMsaPYEF9c7K4cySeJh4+Tmw?=
 =?us-ascii?Q?kIdjhqvMj2vfse2Gj75BfBVmBb8zCpAU1kYLGddxbh/ysK9qYgYRT+u/zO2S?=
 =?us-ascii?Q?ujUgcWn1WPD/qX5SGHcMhsHqvyVRGQjt+4IY2GQ8Uwma/nBMAIVTgik5fuoU?=
 =?us-ascii?Q?9McRjUlXsk1xZl6srkU=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB6071.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b85d063e-df68-4d65-1125-08dd7ccb6c3c
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Apr 2025 09:45:29.2163 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Ky8rCs0qe0shZXZj69p74CIjCk4u4SQ8P5zmyPhP+LiTPke3n5lqnCXZaloezPhpTQYrxfAeB7HHrTHo+09wdw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7329
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

Reviewed-by: Asad Kamal <asad.kamal@amd.com>

Thanks & Regards
Asad

-----Original Message-----
From: Lazar, Lijo <Lijo.Lazar@amd.com>
Sent: Wednesday, April 16, 2025 1:42 PM
To: amd-gfx@lists.freedesktop.org
Cc: Zhang, Hawking <Hawking.Zhang@amd.com>; Deucher, Alexander <Alexander.D=
eucher@amd.com>; Kamal, Asad <Asad.Kamal@amd.com>
Subject: [PATCH v2] drm/amdgpu: Disallow partition query during reset

Reject queries to get current partition modes during reset. Also, don't acc=
ept sysfs interface requests to switch compute partition mode while in rese=
t.

Signed-off-by: Lijo Lazar <lijo.lazar@amd.com>
---
v2: Keep consistent error code, return EPERM

 drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c | 10 ++++++++++  drivers/gpu/drm/a=
md/amdgpu/amdgpu_gmc.c |  4 ++++
 2 files changed, 14 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c b/drivers/gpu/drm/amd/=
amdgpu/amdgpu_gfx.c
index 2c933d436e56..67ebeed77d71 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
@@ -1353,6 +1353,10 @@ static ssize_t amdgpu_gfx_get_current_compute_partit=
ion(struct device *dev,
        struct amdgpu_device *adev =3D drm_to_adev(ddev);
        int mode;

+       /* Only minimal precaution taken to reject requests while in reset.=
*/
+       if (amdgpu_in_reset(adev))
+               return -EPERM;
+
        mode =3D amdgpu_xcp_query_partition_mode(adev->xcp_mgr,
                                               AMDGPU_XCP_FL_NONE);

@@ -1396,8 +1400,14 @@ static ssize_t amdgpu_gfx_set_compute_partition(stru=
ct device *dev,
                return -EINVAL;
        }

+       /* Don't allow a switch while under reset */
+       if (!down_read_trylock(&adev->reset_domain->sem))
+               return -EPERM;
+
        ret =3D amdgpu_xcp_switch_partition_mode(adev->xcp_mgr, mode);

+       up_read(&adev->reset_domain->sem);
+
        if (ret)
                return ret;

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c b/drivers/gpu/drm/amd/=
amdgpu/amdgpu_gmc.c
index ecb74ccf1d90..6b0fbbb91e57 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
@@ -1230,6 +1230,10 @@ static ssize_t current_memory_partition_show(
        struct amdgpu_device *adev =3D drm_to_adev(ddev);
        enum amdgpu_memory_partition mode;

+       /* Only minimal precaution taken to reject requests while in reset =
*/
+       if (amdgpu_in_reset(adev))
+               return -EPERM;
+
        mode =3D adev->gmc.gmc_funcs->query_mem_partition_mode(adev);
        if ((mode >=3D ARRAY_SIZE(nps_desc)) ||
            (BIT(mode) & AMDGPU_ALL_NPS_MASK) !=3D BIT(mode))
--
2.25.1

