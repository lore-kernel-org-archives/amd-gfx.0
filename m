Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0A9E0C433F5
	for <amd-gfx@archiver.kernel.org>; Wed, 15 Dec 2021 19:24:34 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6D33410F862;
	Wed, 15 Dec 2021 19:24:33 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2053.outbound.protection.outlook.com [40.107.236.53])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A7C2D10F862
 for <amd-gfx@lists.freedesktop.org>; Wed, 15 Dec 2021 19:24:32 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SI+W9NL5K83n77MlMy48GOA0wbZP1+PpDlsuKob4wtTvbz9afMGtd+k6GLE5+l31JVq5c8JcwMv11dDUE28rncDOCp4i8beTd83G5cb1a8c546rXT//qgU7g6GWu/gOmsk3K7CfsNdM+qdm9YB4jnlSE8GBXW/rCyMRiQOA9nGPKU/CkNdTrnLsqiXlsWuF9Sfqg4iaBbaR9g63U0yvJAfAXnqI/snKSJNLFeNljESZpTuX+/yDm7U3VUEHw+t7Piq9DS1N9Hx6nc6ymdD4fZ0/3bRG5gZ2k6Fp71B1iu6h6YHHl2B/wGDg2Cr1U1TwDzxoiYjHVCu1QDLpfNJye6w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2DB48CKXcO+TJIAwQX628h/3HiPWNFuhcjcsa3TO7jk=;
 b=PUWUhmSVmj90Q2jeXfzeJYmwIgG+jGbwZZd9bOQFKKTPRbnfHCucryYrSdBB1qKR00Xdb/mSUGjwq3OKX07+O7x3lNLuC2W3PWtAbFHkh355aptyOcAcowzZCLdoVZrBAiVl5Uyt+PTIZTjCZ9YWxMAJo4BGMG/I139UiP1G0Tf7s48SKPO2H6i3FVPlXCExxgUnqKqyhR5ot2givOvxgifUM9/9wEIDqJ0vmp3G87ggf684Y4DRH3hczj4Ax4Woui/0+gHO20IYFplSldff+9R7zkj1cm4aO2+OcePqPk3K7u+UtbI1XIji+BYmV7rYDpLHQKHx2ddP5PZu25khUw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2DB48CKXcO+TJIAwQX628h/3HiPWNFuhcjcsa3TO7jk=;
 b=2cPg9qc7sNHquJDxwQ8nDEWXBcFOPNc3qNZbM73W5bGMkU1MvkPYIm96pI4qvxMM2o/95TgOT1xnECNPbsoAFm5U7ANNKhJF+s5Q2eiB13To16IEpfsFlQetilbxsI1WtMrfTUcS+EAEOhp70Riuz1Klxtg5bREJaGrGPs/OE88=
Received: from BYAPR12MB2840.namprd12.prod.outlook.com (2603:10b6:a03:62::32)
 by BYAPR12MB3285.namprd12.prod.outlook.com (2603:10b6:a03:134::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4778.12; Wed, 15 Dec
 2021 19:24:29 +0000
Received: from BYAPR12MB2840.namprd12.prod.outlook.com
 ([fe80::5425:7b82:3787:d5fa]) by BYAPR12MB2840.namprd12.prod.outlook.com
 ([fe80::5425:7b82:3787:d5fa%5]) with mapi id 15.20.4778.018; Wed, 15 Dec 2021
 19:24:28 +0000
From: "Nieto, David M" <David.Nieto@amd.com>
To: "Skvortsov, Victor" <Victor.Skvortsov@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>, "Deng,
 Emily" <Emily.Deng@amd.com>, "Liu, Monk" <Monk.Liu@amd.com>, "Ming, Davis"
 <Davis.Ming@amd.com>, "Liu, Shaoyun" <Shaoyun.Liu@amd.com>, "Zhou, Peng Ju"
 <PengJu.Zhou@amd.com>, "Chen, JingWen" <JingWen.Chen2@amd.com>, "Chen,
 Horace" <Horace.Chen@amd.com>
Subject: Re: [PATCH 3/5] drm/amdgpu: Modify indirect register access for
 amdkfd_gfx_v9 sriov
Thread-Topic: [PATCH 3/5] drm/amdgpu: Modify indirect register access for
 amdkfd_gfx_v9 sriov
Thread-Index: AQHX8eVXewyAITysP0aO3OxEfBNs7qwz7txe
Date: Wed, 15 Dec 2021 19:24:28 +0000
Message-ID: <BYAPR12MB2840C0F674858A20DC43348CF4769@BYAPR12MB2840.namprd12.prod.outlook.com>
References: <20211215185510.15134-1-victor.skvortsov@amd.com>
 <20211215185510.15134-4-victor.skvortsov@amd.com>
In-Reply-To: <20211215185510.15134-4-victor.skvortsov@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Enabled=True;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SetDate=2021-12-15T19:24:27.890Z;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Name=AMD
 Official Use
 Only; MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ContentBits=0;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Method=Standard; 
suggested_attachment_session_id: 9a81ec42-c83f-61f2-b62e-dcaaa6b33bd9
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: af953235-ded0-4b34-a70a-08d9c0008393
x-ms-traffictypediagnostic: BYAPR12MB3285:EE_
x-microsoft-antispam-prvs: <BYAPR12MB32853E76BAB7F30AF745B976F4769@BYAPR12MB3285.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:475;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 1w9rkgRHws9eek2GfKVT9oPSg0H+VeNWkUx6mPrBEyMDIcg54yDt4tVLNoB/okWlDTIfdxtXaPTaLKq6/tI5FLJz0Ukxqxc0zFDDEhlBzei9Xke1ZvjHWBwcbWcvtx2V6PcHVvDZ+8fl7WJKnQ2uWCLSKUb7So552fXZDow4RCveMx5tYTM6ZEuawqRxqtdXUhjzOylMBPh3mwLxbCgoQ/cuB/wYDB4FWDC+4hg2g0Bx44ac1DkF9WMqhpKAMhKxeLzZ5DLe372urrKDW2bA1Y7wGxzW7DWM4zpl3cVbLC2Dy2qz4fk5Jnz+9PLn1hkV6eLebZNxN1E+mOW+wAOtTMR5CLyeOOR4papY6AonUO3/M3HjwyYkOh+Szapn3yAI40+Ekwu6zY/+qbnfJ+DCtJwYaEItwXDIOJYLA9lUCvs0sPvA4hBkzu8SJ5hEwAWov0x+vmQqqlPl2r9QodNm5Z/Z6tJ8QmqBXjsrvN/TOT0k11T3gX9gNj2l13J4N/n3ve8IOJz8zPN0MWgE3oaIYhT8YBfjrXN75HyfhcXbQXr+o5iHxnnoD1fpwbpe/OMAbmGOtFREDd2tfTrLvGObAso9inoFaNTzH1UnoQGPnct4nuJpoHpFTf08iaolCX12+5LL3gpywFl+TdGwYYlz0N0KKMXrNAp0X6arWAJWvlhFpD2zRYEvvtchnzywniMrmoQjyH/KP2x7quMrwzfz/2cRN3ebkc0Zng9LQDCJffU=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR12MB2840.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(8676002)(122000001)(83380400001)(19627405001)(5660300002)(52536014)(38070700005)(6506007)(2906002)(6636002)(316002)(55016003)(186003)(7696005)(38100700002)(8936002)(86362001)(110136005)(76116006)(33656002)(66446008)(66476007)(66556008)(66946007)(64756008)(921005)(71200400001)(9686003)(53546011)(508600001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?uYqf0w1Bz6AwQqR7sDqFBb4El/QMTtvzwQB0WYbcvPItyTEkI8tfeKUOmKJU?=
 =?us-ascii?Q?YwCyK+x33yNMzBfTzVbOE0H7a06YpOAFupWXLzzaDi1BX7zU24tE91Pv4oUj?=
 =?us-ascii?Q?dP+adKjP+SR+J1wlto4Q3pROvIaqjTJdzfUMekCtur4oaatM0YQmQT8keFHx?=
 =?us-ascii?Q?7CWWlNR/ABzDPGXH65Z8CDm6obTcNUPnPsa2O7tqLe+R+794+QUm91+mVAOW?=
 =?us-ascii?Q?p9NLo+zgv4BOoJZf/2iYiCZ3/F/Cmmq45KoDs9We8Z+4NVClm4yo5UqLmB6Q?=
 =?us-ascii?Q?TvTS8SeUIjO+zhDeKWEIu9SDSFN93xfOOvUl+6YQWsKxS9e/05BOqfSzb0ZK?=
 =?us-ascii?Q?qVn8sEn5AiEBgwC9XcNCpAJdPy+ZkNzWvnv73sZoLr8v63mxfpDjvsTMlVFx?=
 =?us-ascii?Q?G6PDjLSqo33o7jLQIeHM7fOcoMhsWc7rhxCkOT03aGA53TzqbVLJ4wyXy0/t?=
 =?us-ascii?Q?W1dRPO+D+IBar2WFjdPqaZZfakzciBVuXVGyY2BGH9Z1c04GAbHKpRgFNDJp?=
 =?us-ascii?Q?yhEJn6s+BszebqNFmJP2rQDwmgsbmF4odBxZEERHJrySolmdwTwmH5RiNg23?=
 =?us-ascii?Q?Hf+OSgG7ztFRuCz8Zw1lJeg+YEOf/a0p774SZ3SY0QuBpSqYYYQHaFnSTMNl?=
 =?us-ascii?Q?BuTHjYGDZavvYa4R/tDD0LKIUtQkZMO7K8OQn/oS6mwbvJCqZ6bvWJBsriR7?=
 =?us-ascii?Q?JiNWRrvfrhXo0itjcqR+r64mvM2cnbQAqkOOHnEIDpY3We2NGR7iL9LuQnvE?=
 =?us-ascii?Q?xhlLWNDDk/yR5MuHE3ElR1Rpg+Jh2yJV35YUr1ZIR57VuUt1rt6sbM3H1i/m?=
 =?us-ascii?Q?R+ODy+DubKY2FAAQAFI2nGEjUnsDSs14af5/P68K7RocvhgSDTWZ2Xx4dauN?=
 =?us-ascii?Q?e93RjWybYYHyzBm+s2pP3siwERplfcp5QLLJZMF1eKut2pXMii8Rtr7I6CYZ?=
 =?us-ascii?Q?Zo0c9He2jqvOo8ACwCO3RS5JmVzOhp9+gTbxn5nPZZ+TgTtJ9BlTwHDcWOUZ?=
 =?us-ascii?Q?p7R1/DzKM3WED39IKh2B4CbVtNWUj5KIWjwq3NcEpsEA7t4cDyo3Hq+7vBQu?=
 =?us-ascii?Q?Cl/0izt0QOMwab9DmNbqtbZM/xrBtyJSF8Fk9bChJOvrxDpGGXEsJPGPRB1a?=
 =?us-ascii?Q?kvoVybx5AvEb5sJREF3HvCwg07kOk++mw0c6sG4pbpkTabBMe48YzHwS+C29?=
 =?us-ascii?Q?hkMSWi2NjhLdtzb7196jsxSr8TT5GSZL+k8EVgUQGfC7o1aVa9hLRRn/KaXx?=
 =?us-ascii?Q?x0IdKWz+1TxKWqMQhY8d99NzWuBG7PEEhxNlSYw6yqKTeVv8fx9f3x/4hQk0?=
 =?us-ascii?Q?51mTZw6g4Am1qkytGgzsG78ffd2U0czW61KohKtCPy7yzyW1ge3h+6pZtOyO?=
 =?us-ascii?Q?tisihWxhUJ1d5+b1FPCRU9jvWHAQcFg1msfLGzNmKbE3Oiukjb8+719f8ZLD?=
 =?us-ascii?Q?j/iPYaFrOL7a4BUApedLKW7Qtr6mcIwqLfGQX9+OphN5i+jaQAJcOFMQdJgU?=
 =?us-ascii?Q?qiM32e7GPpm9PenHWCWkf3C2R4X8KSae9AdFBoLr/vNKKsy/pbNvUtyLe7VF?=
 =?us-ascii?Q?clr3yjDmM1alk+wLZnmAP9Gh76LC3uqJ+EfHx0IT?=
Content-Type: multipart/alternative;
 boundary="_000_BYAPR12MB2840C0F674858A20DC43348CF4769BYAPR12MB2840namp_"
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB2840.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: af953235-ded0-4b34-a70a-08d9c0008393
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Dec 2021 19:24:28.9150 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: dErT3GwwxmKyjxOd7ntmcsNJ8eoGYs2veC0T8ljDPHyJIKLze7AswZ/MOUW2bkMh
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB3285
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

--_000_BYAPR12MB2840C0F674858A20DC43348CF4769BYAPR12MB2840namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

[AMD Official Use Only]

Reviewed-by: David Nieto <david.nieto@amd.com>
________________________________
From: Skvortsov, Victor <Victor.Skvortsov@amd.com>
Sent: Wednesday, December 15, 2021 10:55 AM
To: amd-gfx@lists.freedesktop.org <amd-gfx@lists.freedesktop.org>; Deng, Em=
ily <Emily.Deng@amd.com>; Liu, Monk <Monk.Liu@amd.com>; Ming, Davis <Davis.=
Ming@amd.com>; Liu, Shaoyun <Shaoyun.Liu@amd.com>; Zhou, Peng Ju <PengJu.Zh=
ou@amd.com>; Chen, JingWen <JingWen.Chen2@amd.com>; Chen, Horace <Horace.Ch=
en@amd.com>; Nieto, David M <David.Nieto@amd.com>
Cc: Skvortsov, Victor <Victor.Skvortsov@amd.com>
Subject: [PATCH 3/5] drm/amdgpu: Modify indirect register access for amdkfd=
_gfx_v9 sriov

Modify GC register access from MMIO to RLCG if the indirect
flag is set

Signed-off-by: Victor Skvortsov <victor.skvortsov@amd.com>
---
 .../gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v9.c | 27 +++++++++----------
 1 file changed, 13 insertions(+), 14 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v9.c b/drivers/gp=
u/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v9.c
index ddfe7aff919d..1abf662a0e91 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v9.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v9.c
@@ -166,7 +166,7 @@ int kgd_gfx_v9_init_interrupts(struct amdgpu_device *ad=
ev, uint32_t pipe_id)

         lock_srbm(adev, mec, pipe, 0, 0);

-       WREG32(SOC15_REG_OFFSET(GC, 0, mmCPC_INT_CNTL),
+       WREG32_SOC15(GC, 0, mmCPC_INT_CNTL,
                 CP_INT_CNTL_RING0__TIME_STAMP_INT_ENABLE_MASK |
                 CP_INT_CNTL_RING0__OPCODE_ERROR_INT_ENABLE_MASK);

@@ -279,7 +279,7 @@ int kgd_gfx_v9_hqd_load(struct amdgpu_device *adev, voi=
d *mqd,
                        lower_32_bits((uintptr_t)wptr));
                 WREG32_RLC(SOC15_REG_OFFSET(GC, 0, mmCP_HQD_PQ_WPTR_POLL_A=
DDR_HI),
                        upper_32_bits((uintptr_t)wptr));
-               WREG32(SOC15_REG_OFFSET(GC, 0, mmCP_PQ_WPTR_POLL_CNTL1),
+               WREG32_SOC15(GC, 0, mmCP_PQ_WPTR_POLL_CNTL1,
                        (uint32_t)get_queue_mask(adev, pipe_id, queue_id));
         }

@@ -488,13 +488,13 @@ bool kgd_gfx_v9_hqd_is_occupied(struct amdgpu_device =
*adev,
         uint32_t low, high;

         acquire_queue(adev, pipe_id, queue_id);
-       act =3D RREG32(SOC15_REG_OFFSET(GC, 0, mmCP_HQD_ACTIVE));
+       act =3D RREG32_SOC15(GC, 0, mmCP_HQD_ACTIVE);
         if (act) {
                 low =3D lower_32_bits(queue_address >> 8);
                 high =3D upper_32_bits(queue_address >> 8);

-               if (low =3D=3D RREG32(SOC15_REG_OFFSET(GC, 0, mmCP_HQD_PQ_B=
ASE)) &&
-                  high =3D=3D RREG32(SOC15_REG_OFFSET(GC, 0, mmCP_HQD_PQ_B=
ASE_HI)))
+               if (low =3D=3D RREG32_SOC15(GC, 0, mmCP_HQD_PQ_BASE) &&
+                  high =3D=3D RREG32_SOC15(GC, 0, mmCP_HQD_PQ_BASE_HI))
                         retval =3D true;
         }
         release_queue(adev);
@@ -556,7 +556,7 @@ int kgd_gfx_v9_hqd_destroy(struct amdgpu_device *adev, =
void *mqd,

         end_jiffies =3D (utimeout * HZ / 1000) + jiffies;
         while (true) {
-               temp =3D RREG32(SOC15_REG_OFFSET(GC, 0, mmCP_HQD_ACTIVE));
+               temp =3D RREG32_SOC15(GC, 0, mmCP_HQD_ACTIVE);
                 if (!(temp & CP_HQD_ACTIVE__ACTIVE_MASK))
                         break;
                 if (time_after(jiffies, end_jiffies)) {
@@ -645,7 +645,7 @@ int kgd_gfx_v9_wave_control_execute(struct amdgpu_devic=
e *adev,
         mutex_lock(&adev->grbm_idx_mutex);

         WREG32_SOC15_RLC_SHADOW(GC, 0, mmGRBM_GFX_INDEX, gfx_index_val);
-       WREG32(SOC15_REG_OFFSET(GC, 0, mmSQ_CMD), sq_cmd);
+       WREG32_SOC15(GC, 0, mmSQ_CMD, sq_cmd);

         data =3D REG_SET_FIELD(data, GRBM_GFX_INDEX,
                 INSTANCE_BROADCAST_WRITES, 1);
@@ -722,7 +722,7 @@ static void get_wave_count(struct amdgpu_device *adev, =
int queue_idx,
         pipe_idx =3D queue_idx / adev->gfx.mec.num_queue_per_pipe;
         queue_slot =3D queue_idx % adev->gfx.mec.num_queue_per_pipe;
         soc15_grbm_select(adev, 1, pipe_idx, queue_slot, 0);
-       reg_val =3D RREG32(SOC15_REG_OFFSET(GC, 0, mmSPI_CSQ_WF_ACTIVE_COUN=
T_0) +
+       reg_val =3D RREG32_SOC15_IP(GC, SOC15_REG_OFFSET(GC, 0, mmSPI_CSQ_W=
F_ACTIVE_COUNT_0) +
                          queue_slot);
         *wave_cnt =3D reg_val & SPI_CSQ_WF_ACTIVE_COUNT_0__COUNT_MASK;
         if (*wave_cnt !=3D 0)
@@ -809,8 +809,7 @@ void kgd_gfx_v9_get_cu_occupancy(struct amdgpu_device *=
adev, int pasid,
                 for (sh_idx =3D 0; sh_idx < sh_cnt; sh_idx++) {

                         gfx_v9_0_select_se_sh(adev, se_idx, sh_idx, 0xffff=
ffff);
-                       queue_map =3D RREG32(SOC15_REG_OFFSET(GC, 0,
-                                          mmSPI_CSQ_WF_ACTIVE_STATUS));
+                       queue_map =3D RREG32_SOC15(GC, 0, mmSPI_CSQ_WF_ACTI=
VE_STATUS);

                         /*
                          * Assumption: queue map encodes following schema:=
 four
@@ -860,17 +859,17 @@ void kgd_gfx_v9_program_trap_handler_settings(struct =
amdgpu_device *adev,
         /*
          * Program TBA registers
          */
-       WREG32(SOC15_REG_OFFSET(GC, 0, mmSQ_SHADER_TBA_LO),
+       WREG32_SOC15(GC, 0, mmSQ_SHADER_TBA_LO,
                         lower_32_bits(tba_addr >> 8));
-       WREG32(SOC15_REG_OFFSET(GC, 0, mmSQ_SHADER_TBA_HI),
+       WREG32_SOC15(GC, 0, mmSQ_SHADER_TBA_HI,
                         upper_32_bits(tba_addr >> 8));

         /*
          * Program TMA registers
          */
-       WREG32(SOC15_REG_OFFSET(GC, 0, mmSQ_SHADER_TMA_LO),
+       WREG32_SOC15(GC, 0, mmSQ_SHADER_TMA_LO,
                         lower_32_bits(tma_addr >> 8));
-       WREG32(SOC15_REG_OFFSET(GC, 0, mmSQ_SHADER_TMA_HI),
+       WREG32_SOC15(GC, 0, mmSQ_SHADER_TMA_HI,
                         upper_32_bits(tma_addr >> 8));

         unlock_srbm(adev);
--
2.25.1


--_000_BYAPR12MB2840C0F674858A20DC43348CF4769BYAPR12MB2840namp_
Content-Type: text/html; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<html>
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Dus-ascii"=
>
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
: 12pt; color: rgb(0, 0, 0); background-color: rgb(255, 255, 255);">
Reviewed-by: David Nieto &lt;david.nieto@amd.com&gt;</div>
<div id=3D"appendonsend"></div>
<hr style=3D"display:inline-block;width:98%" tabindex=3D"-1">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" st=
yle=3D"font-size:11pt" color=3D"#000000"><b>From:</b> Skvortsov, Victor &lt=
;Victor.Skvortsov@amd.com&gt;<br>
<b>Sent:</b> Wednesday, December 15, 2021 10:55 AM<br>
<b>To:</b> amd-gfx@lists.freedesktop.org &lt;amd-gfx@lists.freedesktop.org&=
gt;; Deng, Emily &lt;Emily.Deng@amd.com&gt;; Liu, Monk &lt;Monk.Liu@amd.com=
&gt;; Ming, Davis &lt;Davis.Ming@amd.com&gt;; Liu, Shaoyun &lt;Shaoyun.Liu@=
amd.com&gt;; Zhou, Peng Ju &lt;PengJu.Zhou@amd.com&gt;; Chen, JingWen
 &lt;JingWen.Chen2@amd.com&gt;; Chen, Horace &lt;Horace.Chen@amd.com&gt;; N=
ieto, David M &lt;David.Nieto@amd.com&gt;<br>
<b>Cc:</b> Skvortsov, Victor &lt;Victor.Skvortsov@amd.com&gt;<br>
<b>Subject:</b> [PATCH 3/5] drm/amdgpu: Modify indirect register access for=
 amdkfd_gfx_v9 sriov</font>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt;=
">
<div class=3D"PlainText">Modify GC register access from MMIO to RLCG if the=
 indirect<br>
flag is set<br>
<br>
Signed-off-by: Victor Skvortsov &lt;victor.skvortsov@amd.com&gt;<br>
---<br>
&nbsp;.../gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v9.c | 27 +++++++++---------=
-<br>
&nbsp;1 file changed, 13 insertions(+), 14 deletions(-)<br>
<br>
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v9.c b/drivers/gp=
u/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v9.c<br>
index ddfe7aff919d..1abf662a0e91 100644<br>
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v9.c<br>
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v9.c<br>
@@ -166,7 +166,7 @@ int kgd_gfx_v9_init_interrupts(struct amdgpu_device *ad=
ev, uint32_t pipe_id)<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; lock_srbm(adev, mec, pipe,=
 0, 0);<br>
&nbsp;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; WREG32(SOC15_REG_OFFSET(GC, 0, mmCPC_=
INT_CNTL),<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; WREG32_SOC15(GC, 0, mmCPC_INT_CNTL,<b=
r>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; CP_INT_CNTL_RING0__TIME_STAMP_INT_ENABLE_MASK |<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; CP_INT_CNTL_RING0__OPCODE_ERROR_INT_ENABLE_MASK);<br>
&nbsp;<br>
@@ -279,7 +279,7 @@ int kgd_gfx_v9_hqd_load(struct amdgpu_device *adev, voi=
d *mqd,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; lower_32_bi=
ts((uintptr_t)wptr));<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; WREG32_RLC(SOC15_REG_OFFSET(GC, 0, mmCP_HQD_PQ_WPTR_P=
OLL_ADDR_HI),<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; upper_32_bi=
ts((uintptr_t)wptr));<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; WREG32(SOC15_REG_OFFSET(GC, 0, mmCP_PQ_WPTR_POLL_CNTL1),<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; WREG32_SOC15(GC, 0, mmCP_PQ_WPTR_POLL_CNTL1,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; (uint32_t)g=
et_queue_mask(adev, pipe_id, queue_id));<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&nbsp;<br>
@@ -488,13 +488,13 @@ bool kgd_gfx_v9_hqd_is_occupied(struct amdgpu_device =
*adev,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t low, high;<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; acquire_queue(adev, pipe_i=
d, queue_id);<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; act =3D RREG32(SOC15_REG_OFFSET(GC, 0=
, mmCP_HQD_ACTIVE));<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; act =3D RREG32_SOC15(GC, 0, mmCP_HQD_=
ACTIVE);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (act) {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; low =3D lower_32_bits(queue_address &gt;&gt; 8);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; high =3D upper_32_bits(queue_address &gt;&gt; 8);<br>
&nbsp;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; if (low =3D=3D RREG32(SOC15_REG_OFFSET(GC, 0, mmCP_HQD_PQ_BASE))=
 &amp;&amp;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp; high =3D=3D RREG32(SOC15_REG_OFFSET(GC, 0, mmC=
P_HQD_PQ_BASE_HI)))<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; if (low =3D=3D RREG32_SOC15(GC, 0, mmCP_HQD_PQ_BASE) &amp;&amp;<=
br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp; high =3D=3D RREG32_SOC15(GC, 0, mmCP_HQD_PQ_BA=
SE_HI))<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; retva=
l =3D true;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; release_queue(adev);<br>
@@ -556,7 +556,7 @@ int kgd_gfx_v9_hqd_destroy(struct amdgpu_device *adev, =
void *mqd,<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; end_jiffies =3D (utimeout =
* HZ / 1000) + jiffies;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; while (true) {<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; temp =3D RREG32(SOC15_REG_OFFSET(GC, 0, mmCP_HQD_ACTIVE));<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; temp =3D RREG32_SOC15(GC, 0, mmCP_HQD_ACTIVE);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; if (!(temp &amp; CP_HQD_ACTIVE__ACTIVE_MASK))<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; break=
;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; if (time_after(jiffies, end_jiffies)) {<br>
@@ -645,7 +645,7 @@ int kgd_gfx_v9_wave_control_execute(struct amdgpu_devic=
e *adev,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mutex_lock(&amp;adev-&gt;g=
rbm_idx_mutex);<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; WREG32_SOC15_RLC_SHADOW(GC=
, 0, mmGRBM_GFX_INDEX, gfx_index_val);<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; WREG32(SOC15_REG_OFFSET(GC, 0, mmSQ_C=
MD), sq_cmd);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; WREG32_SOC15(GC, 0, mmSQ_CMD, sq_cmd)=
;<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; data =3D REG_SET_FIELD(dat=
a, GRBM_GFX_INDEX,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; INSTANCE_BROADCAST_WRITES, 1);<br>
@@ -722,7 +722,7 @@ static void get_wave_count(struct amdgpu_device *adev, =
int queue_idx,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; pipe_idx =3D queue_idx / a=
dev-&gt;gfx.mec.num_queue_per_pipe;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; queue_slot =3D queue_idx %=
 adev-&gt;gfx.mec.num_queue_per_pipe;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; soc15_grbm_select(adev, 1,=
 pipe_idx, queue_slot, 0);<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; reg_val =3D RREG32(SOC15_REG_OFFSET(G=
C, 0, mmSPI_CSQ_WF_ACTIVE_COUNT_0) +<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; reg_val =3D RREG32_SOC15_IP(GC, SOC15=
_REG_OFFSET(GC, 0, mmSPI_CSQ_WF_ACTIVE_COUNT_0) +<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
 queue_slot);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; *wave_cnt =3D reg_val &amp=
; SPI_CSQ_WF_ACTIVE_COUNT_0__COUNT_MASK;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (*wave_cnt !=3D 0)<br>
@@ -809,8 +809,7 @@ void kgd_gfx_v9_get_cu_occupancy(struct amdgpu_device *=
adev, int pasid,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; for (sh_idx =3D 0; sh_idx &lt; sh_cnt; sh_idx++) {<br=
>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; gfx_v=
9_0_select_se_sh(adev, se_idx, sh_idx, 0xffffffff);<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; queue_map =3D RR=
EG32(SOC15_REG_OFFSET(GC, 0,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp; mmSPI_CSQ_WF_ACTIVE_STATUS));<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; queue_map =3D RR=
EG32_SOC15(GC, 0, mmSPI_CSQ_WF_ACTIVE_STATUS);<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /*<br=
>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
 * Assumption: queue map encodes following schema: four<br>
@@ -860,17 +859,17 @@ void kgd_gfx_v9_program_trap_handler_settings(struct =
amdgpu_device *adev,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /*<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * Program TBA regist=
ers<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; */<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; WREG32(SOC15_REG_OFFSET(GC, 0, mmSQ_S=
HADER_TBA_LO),<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; WREG32_SOC15(GC, 0, mmSQ_SHADER_TBA_L=
O,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; lower=
_32_bits(tba_addr &gt;&gt; 8));<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; WREG32(SOC15_REG_OFFSET(GC, 0, mmSQ_S=
HADER_TBA_HI),<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; WREG32_SOC15(GC, 0, mmSQ_SHADER_TBA_H=
I,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; upper=
_32_bits(tba_addr &gt;&gt; 8));<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /*<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * Program TMA regist=
ers<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; */<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; WREG32(SOC15_REG_OFFSET(GC, 0, mmSQ_S=
HADER_TMA_LO),<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; WREG32_SOC15(GC, 0, mmSQ_SHADER_TMA_L=
O,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; lower=
_32_bits(tma_addr &gt;&gt; 8));<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; WREG32(SOC15_REG_OFFSET(GC, 0, mmSQ_S=
HADER_TMA_HI),<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; WREG32_SOC15(GC, 0, mmSQ_SHADER_TMA_H=
I,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; upper=
_32_bits(tma_addr &gt;&gt; 8));<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; unlock_srbm(adev);<br>
-- <br>
2.25.1<br>
<br>
</div>
</span></font></div>
</div>
</body>
</html>

--_000_BYAPR12MB2840C0F674858A20DC43348CF4769BYAPR12MB2840namp_--
