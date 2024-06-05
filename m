Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C1C30C25B76
	for <amd-gfx@archiver.kernel.org>; Wed,  5 Jun 2024 09:33:38 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4003210E09F;
	Wed,  5 Jun 2024 09:33:37 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="FzOl/j0w";
	dkim-atps=neutral
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2067.outbound.protection.outlook.com [40.107.223.67])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 42D5310E09F
 for <amd-gfx@lists.freedesktop.org>; Wed,  5 Jun 2024 09:33:34 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OQE77yDMlsfxDXMyDsV8t8XF1ot5U43v1zD5Q8TXC7uO94BMAOm+BiCneTw7semTGjR6XXzs2ov4vLv2thG4F9plDMW4dARHUOcD+f9MIoheaxEy18Ll0G7tmZmyWGBN8GHe0K3m6juhO7O0TeW19U0KO6Cj+Cxl4gfUx544qGxnYJXq7QWnU4fKWrcSzxTxxxBo70QxqnC2ol0ihfcanSuJEcuMPqlXp7WjRkF6EqlVulUSVS7lBmBzpL5i56gFJFGN5KfDcBr3VHG/FECZq7iVooNoJKHEJ0B4bK2StqUUxMSIQLAhG3HabtGOq7ui7cKePomf+/lYGEJ7ar9HAg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dsc4UuBshrqf+zVlqkwCCxetV3bvkNJGclOitfmQABE=;
 b=Ygco+eNZpI8WK84jyzoFVJBtWUcWmVJzA1j4iRQiajHf2PdZXPwRy4WaFf1a1jL7NjIROZGaIQCcuJQEpNPJI204fSNVt1LQASv+XBYmG4owYCZZYdNpVKXy/NClklMCnzLVcl/8FFsug7wUgFgH+NIv3Wv+7BKzGtRNPC0GgFDVOTjsflooVzuqCbIUBbdlyOoOo4uZzCfxwuiS7MGW+8D3GFhbN/5gSS+YQ3Q323VKDxL3andtmUGrQ/7TESHpaxKWvkcDV2mhScsJHpcc46+YHq5B5eolDWcHDlDxF9KSWcNTetbd72NbxyJZjnxvkSZFOTDfOdjuVDBk8vIqlQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dsc4UuBshrqf+zVlqkwCCxetV3bvkNJGclOitfmQABE=;
 b=FzOl/j0wzCuvJymvFNTg9OYewSfVdEdBnMAVqZvJ1qCnHJX9rgUv9qz0ZsxHUBk8fFk5OTf7hEj+mO60SW4ciJKB+GsB/+zCWZOmVdjL3qyyOteQEZi9rmY4zhVwRbPQ1wOtR4jr8/8+xpMGPS9nBBECz9rwXbEkqhSDDL5hElE=
Received: from PH7PR12MB5997.namprd12.prod.outlook.com (2603:10b6:510:1d9::21)
 by DM4PR12MB6229.namprd12.prod.outlook.com (2603:10b6:8:a8::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7611.19; Wed, 5 Jun
 2024 09:33:31 +0000
Received: from PH7PR12MB5997.namprd12.prod.outlook.com
 ([fe80::c5da:9b53:9d77:c708]) by PH7PR12MB5997.namprd12.prod.outlook.com
 ([fe80::c5da:9b53:9d77:c708%5]) with mapi id 15.20.7633.021; Wed, 5 Jun 2024
 09:33:31 +0000
From: "Wang, Yang(Kevin)" <KevinYang.Wang@amd.com>
To: "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
CC: "Zhang, Hawking" <Hawking.Zhang@amd.com>, "Deucher, Alexander"
 <Alexander.Deucher@amd.com>
Subject: RE: [PATCH 00/18] Enhance amdgpu_firmware_request() to improve
 function flexibility
Thread-Topic: [PATCH 00/18] Enhance amdgpu_firmware_request() to improve
 function flexibility
Thread-Index: AQHatVdbKaU0WqPYkk+VakI0B4pymLG47AnQ
Date: Wed, 5 Jun 2024 09:33:31 +0000
Message-ID: <PH7PR12MB5997A438EEF49A7BA1D6C23682F92@PH7PR12MB5997.namprd12.prod.outlook.com>
References: <20240603014212.1969546-1-kevinyang.wang@amd.com>
In-Reply-To: <20240603014212.1969546-1-kevinyang.wang@amd.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ActionId=30488cf6-821f-48ec-a04c-ae88d0602549;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=0;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=true;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution Only;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2024-06-05T09:33:01Z;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR12MB5997:EE_|DM4PR12MB6229:EE_
x-ms-office365-filtering-correlation-id: a80874f8-056f-4a3b-3879-08dc8542902a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230031|366007|376005|1800799015|38070700009;
x-microsoft-antispam-message-info: =?us-ascii?Q?vxHkH1UzNO5KK+z9f7fxDGpVmPLfVKp4o9oRo76c3wV+DpLXoUKLJLeJsBcY?=
 =?us-ascii?Q?Ur6A5dMOj1d8eh2xm1jE9kf/PWB/zjyDvPSqjVmrj7do69Hybsbq1fTviN88?=
 =?us-ascii?Q?eNO7XLhXATEs0Hif/tSbdIaAHAl/U6eKP2lGGnphOgF7MzuBOJHtvBpnFtIE?=
 =?us-ascii?Q?dxXtSr2KP21GqJglcE8vpoFZRsnhB/XEf83rEJvij5ckHXN+msMQmYEwPg0l?=
 =?us-ascii?Q?3DaqR7sJVovDi784on8FICmefAPmfUpzYicd2Z1SsPFXz2vNA5lZd+24x3bD?=
 =?us-ascii?Q?JcX64Y5puMoKoNCvbfVMnWgQesu4iVO16MZtRlBsb7h4ayDRBeAVg9iypBAL?=
 =?us-ascii?Q?jAj8E26W/LSNYQ0TffM7J//kgm/oFJlpNxJ/E0JaDDVuUPtZ6VhXcGWpESQU?=
 =?us-ascii?Q?8QpEIxbCeXycyuYrBwsj7JiLpa5QM/D8sV8ztVYgH07ZxKEsxRRmenXtV0JU?=
 =?us-ascii?Q?DaIM10xC0hfMxVGa87B2/zu8w5EtNHgVn1FLyXRrbCyVy4WHbeeBC0bcGx+6?=
 =?us-ascii?Q?hC1Et+AfC36SHscIIPFpaqCpzYF6SSVtzseXIDuIxp4xVkoPiRmGYunLItnS?=
 =?us-ascii?Q?5HZ6+0sKha2M8taxH7nMgqcoZBjlgCcSQLztWBnW7mKcdahal8EI1JuDU1wB?=
 =?us-ascii?Q?SzqJsjuxmX8y1jC7U8QCC8bswgc8arm8L8ikX5Gx5ojMeV9uMbPl+pSYD+Hg?=
 =?us-ascii?Q?F/UvzwbYyAtIbU+s2gk7wyKzs/Y+M26/G7fekmLdNUSSRS3UD2I1XiBvn3cn?=
 =?us-ascii?Q?reMGxJ2m1ZOf8c9wbzAVoTnvA6rT9QnONH2BeWrPd0xn4g4JNN2FFPnwixMt?=
 =?us-ascii?Q?7qoX2aN3VvU+GxUGJD/lxwAuzvSwu+SbpiLt7A9XNwGObfFCDlFTxi5YDSL+?=
 =?us-ascii?Q?Xob3cynJoPbBgp3/czHyQLiZuHa6t9S9ZyKrml8t0nXS82zdO/jMsQPYykfP?=
 =?us-ascii?Q?Ph2Mz4Ig/r1wudKNW2U/G1d9BO1vEE344BFYDqjEh5DRNsCvpMt/irUdocTT?=
 =?us-ascii?Q?jwJ0aPDtidJTG0atZAIcaDVB3KHtYjYdwAkIRdpB7jLrMKOt+ecNFbdIvS0/?=
 =?us-ascii?Q?lTfFKLnwiLn3alnNrK7F3eGQxGQJvAPfsGFujaTSVUIBKrcRIczPpsQeaYED?=
 =?us-ascii?Q?L4iLlAEZ5K9wn6kcpO/2RL+UGR7EIWVdBs5X4nChTv1rR1oXtwoWBG/GyXZp?=
 =?us-ascii?Q?mq0G0UyraUHnpI4V0MncTQ844nfin2hpVeoGtZ6/Qp0uhIECUtw+iFuC41de?=
 =?us-ascii?Q?QJMdFi5O1vIjdticK0KacBSIsq0usRJJ9GgAKHtl1zgd62UGBPuYeoo1mEGp?=
 =?us-ascii?Q?MBHRWVbdTURdIvhNa/kVbS1URhWzmltsGMY+3vczIiIt4A=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5997.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(366007)(376005)(1800799015)(38070700009); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?1/NvMdbuzF5SmIj8J4slF4Q+6EArQk9+hNk8UDtDTDIG+DE0kd8gQpKoQdAi?=
 =?us-ascii?Q?8/2HOP8cfsXkmn2ye7zoOotT6HbYtl8tNV51ampdVSP9kpMT2rLYHYR/bnka?=
 =?us-ascii?Q?sFmMKCmQIyoalZZIz36C0ohhRCXOlvPc3baibO/D5X/7rgskej9bqOpLIczn?=
 =?us-ascii?Q?Z9+GjhugwOofhGH0z+fbYF1GrCUI/HLnqdnh+YOWTdqZhvjRUneRsJUQgE3X?=
 =?us-ascii?Q?itxWY80a9WROuqJNslNBdOrPaX70FjLvcIuwT9d38knG3wlUNPJH3aC0rGFT?=
 =?us-ascii?Q?t02eylQ07O33FZEMRHQJIdFrGmwbg6o1uJPodxHhlibjIb+a2a8VfUqLKnS4?=
 =?us-ascii?Q?gg40p9x0rSiEXoBbb3dpYje2663zZeOOGuzbSbnmYh+qfOYJO/00dKJFQB+c?=
 =?us-ascii?Q?P41PZkdxaBIXwG0kY+Zfh25xoz8/WHdbfQ8p63ihtsoMZP2WZ0B96LpXGDY7?=
 =?us-ascii?Q?RRjI6uutdUeueRZcRkrEbt+u9sUKMAPW/iUoLNA95EOguhlJc/iyasyk0Kuk?=
 =?us-ascii?Q?j+TZMBXwHRGfo885u0kl9BIH5BCN7Snw1tfp5NAJEVfqb2bgRAG01XeGlwpJ?=
 =?us-ascii?Q?ksGBP5Wmff3Av0XRMmaImB+92Ve2mh6hsI+e23B/f7iaD+wiQ58Fm1UEQLKo?=
 =?us-ascii?Q?kwxu4vd6rIu2OdLr8ABPzQMP+eycarjCrV7+8m/bOgIGPzYWOnLo1dZCshrR?=
 =?us-ascii?Q?U2N85WbhYLzeOMzd3IbxbjFLByDwPpEBrjL497nCifoHGn29FwT6OO56wEsZ?=
 =?us-ascii?Q?YKhTkRgN6VV7WF1173KR0JnzHCnVoR7ObU4jtIzvCTuwk+4yIzA6YEYYh/7Y?=
 =?us-ascii?Q?vE+yktPDhwddEJjHxr3dJlUjDagEEmrf1W8agpYLYkazEZh7z3Qw8l9dwVnc?=
 =?us-ascii?Q?4pvrCOGO86ic9O4bln8veaPAFEet8PRRtXroI3me9+FN3jQrFdhbbTkg71hX?=
 =?us-ascii?Q?j1L6ko1NYFPPW1uk72zdAoAI/dFysrlzVAx4N0l4SXN5vp9FPmbDMxY4o1zV?=
 =?us-ascii?Q?iazGBFET7oJg5LBPbWdurLOrvqS4w4BelNmDF1JAMn/qwQlqpB4SR4moVkK3?=
 =?us-ascii?Q?hkBGrGcr88ELrdVRbvL/8rJ91KdB8ZkS59Ec6+0TkDu/lL0d93GIk80nfwsR?=
 =?us-ascii?Q?NtQlEfd/napiO6QOHAh61mzl/8jR9+vb/wBt6NM2IQuvwM818MMq7KjXy6V/?=
 =?us-ascii?Q?eK4IS02+R5fAtoBKC6bqSYJOXoW24ekbPd30BSMFw3SL+UB0qnnaMtjZRP3W?=
 =?us-ascii?Q?nxqp+Z2x9K7QZHl9YC2Q8p+kdbzAbS3XasDH3XrrZILz7gJ3Ior5YBsg9jN/?=
 =?us-ascii?Q?cQNADfgH2n338H+uZR1Ts1XTw4ITYxLbGnCDgqIWXp5jCBguy1wiPdh+AD80?=
 =?us-ascii?Q?W3FW/ZYb6OnhxEg0i+fZSAbO8mhvqu5bC5VrtCENk7JYSzVhnfa9gnUVPbz6?=
 =?us-ascii?Q?FleFNC3wnR50Nn9RDmhiBidramgSiOSETv3SO/4bTHYb6fB8villYw9Kel1U?=
 =?us-ascii?Q?FGQJrkeiWWNj5hCsGcxV/EtlXA8wdXjZVH370thzIOYqsvsdFCr2o8S9F3I4?=
 =?us-ascii?Q?gDCUsYwZ5dqA0G9zbmw=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5997.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a80874f8-056f-4a3b-3879-08dc8542902a
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Jun 2024 09:33:31.2350 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: dkfiknpK0PudKvtz9NNgurzfF5E38mUsZNReksUM3yKdhdfrYiR6PfqO0lDyYQEF
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6229
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

Ping...

Best Regards,
Kevin

-----Original Message-----
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Yang Wan=
g
Sent: Monday, June 3, 2024 9:42 AM
To: amd-gfx@lists.freedesktop.org
Cc: Zhang, Hawking <Hawking.Zhang@amd.com>; Deucher, Alexander <Alexander.D=
eucher@amd.com>
Subject: [PATCH 00/18] Enhance amdgpu_firmware_request() to improve functio=
n flexibility

Adding variable parameter support to function amdgpu_firmware_request() to =
improve function flexibility.

Yang Wang (18):
  drm/amdgpu: enhance amdgpu_ucode_request() function flexibility
  drm/amdgpu: refine gpu_info firmware loading
  drm/amdgpu: refine isp firmware loading
  drm/amdgpu: refine mes firmware loading
  drm/amdgpu: refine psp firmware loading
  drm/amdgpu: refine sdma firmware loading
  drm/amdgpu: refine imu firmware loading
  drm/amdgpu: refine pmfw/smu firmware loading
  drm/amdgpu: refine gmc firmware loading
  drm/amdgpu: refine vcn firmware loading
  drm/amdgpu: refine vpe firmware loading
  drm/amdgpu: refine gfx6 firmware loading
  drm/amdgpu: refine gfx7 firmware loading
  drm/amdgpu: refine gfx8 firmware loading
  drm/amdgpu: refine gfx9 firmware loading
  drm/amdgpu: refine gfx10 firmware loading
  drm/amdgpu: refine gfx11 firmware loading
  drm/amdgpu: refine gfx12 firmware loading

 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c    |  9 ++-
 drivers/gpu/drm/amd/amdgpu/amdgpu_isp.c       |  4 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c       |  6 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c       | 26 ++-----
 drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.c      |  8 +--
 drivers/gpu/drm/amd/amdgpu/amdgpu_ucode.c     | 30 +++++---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ucode.h     |  3 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c       | 14 ++--
 drivers/gpu/drm/amd/amdgpu/amdgpu_vpe.c       |  6 +-
 drivers/gpu/drm/amd/amdgpu/cik_sdma.c         | 11 +--
 drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c        | 25 ++++---
 drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c        | 26 ++++---
 drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c        | 22 +++---
 drivers/gpu/drm/amd/amdgpu/gfx_v6_0.c         | 19 +++--
 drivers/gpu/drm/amd/amdgpu/gfx_v7_0.c         | 27 ++++----
 drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c         | 69 +++++++++----------
 drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c         | 45 ++++++------
 drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c       | 11 ++-
 drivers/gpu/drm/amd/amdgpu/gmc_v6_0.c         | 14 ++--
 drivers/gpu/drm/amd/amdgpu/gmc_v7_0.c         |  7 +-
 drivers/gpu/drm/amd/amdgpu/gmc_v8_0.c         |  6 +-
 drivers/gpu/drm/amd/amdgpu/imu_v11_0.c        | 10 ++-
 drivers/gpu/drm/amd/amdgpu/imu_v12_0.c        | 10 ++-
 drivers/gpu/drm/amd/amdgpu/sdma_v2_4.c        | 11 +--
 drivers/gpu/drm/amd/amdgpu/sdma_v3_0.c        | 11 +--
 drivers/gpu/drm/amd/pm/legacy-dpm/si_dpm.c    |  8 +--
 .../gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c    |  6 +-
 .../gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c    |  6 +-
 .../drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c  |  6 +-
 .../gpu/drm/amd/pm/swsmu/smu14/smu_v14_0.c    |  6 +-
 30 files changed, 205 insertions(+), 257 deletions(-)

--
2.34.1

