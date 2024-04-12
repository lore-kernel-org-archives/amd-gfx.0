Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0E8C1C4345F
	for <amd-gfx@archiver.kernel.org>; Fri, 12 Apr 2024 09:01:59 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0B78310F3E6;
	Fri, 12 Apr 2024 09:01:58 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="hIYpT4Co";
	dkim-atps=neutral
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2069.outbound.protection.outlook.com [40.107.236.69])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DFC2E10F2BE
 for <amd-gfx@lists.freedesktop.org>; Fri, 12 Apr 2024 09:01:55 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lSWEPjJDRXLjGXhgNfk2BRLQ1sYaXQjs9BYciZMeTL6oYXtzqsMHHO7lSCeUa/36OHZHnaJfMLrvB6K2hJAZxjxVMsH1CRyDlhzDo/6JJTnqOSZo/Rk+5JtjqWvCprBKvh/U2iymdRQrnwaLq8jOjIkO6SRMUwXh1rE9/PYkt6eD38VtCwi5VYzcr9NwgOGnoaqu/T1YQAg9FpKJhF6pMnVZ185Wxdt6aRAqFruKy6S5x/ORYM11G0Art4sN3c7+Tyi3BKKU0QCTRrkhp4bpFO95LbjS85fIx/ecyH14UxSg1Rx3exy7lzrVSEYmeu0iZr9D9eB+co8xiD4c28JlkQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=S938Q4fv/bG02AQ0nXHNDFqTE7wDEWgdPBQ7XaNBsTw=;
 b=P8Hv1jo45UuwpMoh4I0DFpdTmIrhfZrehjOiSYvc02vWeE1QtjgwyXnG19kGwFnlkAZIQ8OYJZa9XEvEdlvGcRP29yYFtYwOtFX0bBjLmSfC0i/3nF8nw9hlRi9IqlGSPTXNwLBdq6MJfHpWpwyoE+jGsFK363XVbJuYYdbz0jb7pRWP3sSQh/qejeH7NF6sIP+TpVzCY9tLh1TCqWlETt6w7JvbBnCdKNS/Z1kiWCKel5XAZ3GbGvR3Rj4JXk56pH8LHe+qxcghtYWdd0akn3MmzxlKVJlbJ/NA9CTvLNfxIKuTenjEnqAJ70VhMcC2FtpLbYpAfnjBLYMuydeq5w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=S938Q4fv/bG02AQ0nXHNDFqTE7wDEWgdPBQ7XaNBsTw=;
 b=hIYpT4Coxt//wdrIN48ogATUsd6qv570cMvOWuI3DALmCjCDv1G0Z3ionZuIFn9kd6F7A7knDv03ECWrWt1UwL2AMmr63Mw+j9wtkw/trIUbd8874KUW2S7c/8QP+XjTfm8XTanWeTfFsK8xD4SPqj+Tp0FGUUrbysnfqF44Kx8=
Received: from PH7PR12MB5596.namprd12.prod.outlook.com (2603:10b6:510:136::13)
 by DM4PR12MB8452.namprd12.prod.outlook.com (2603:10b6:8:184::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.46; Fri, 12 Apr
 2024 09:01:53 +0000
Received: from PH7PR12MB5596.namprd12.prod.outlook.com
 ([fe80::6974:3875:ed0:7033]) by PH7PR12MB5596.namprd12.prod.outlook.com
 ([fe80::6974:3875:ed0:7033%3]) with mapi id 15.20.7409.042; Fri, 12 Apr 2024
 09:01:53 +0000
From: "Khatri, Sunil" <Sunil.Khatri@amd.com>
To: "Khatri, Sunil" <Sunil.Khatri@amd.com>, "Deucher, Alexander"
 <Alexander.Deucher@amd.com>, "Koenig, Christian" <Christian.Koenig@amd.com>
CC: "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH 0/2] First set in IP dump patches
Thread-Topic: [PATCH 0/2] First set in IP dump patches
Thread-Index: AQHajLfa5UyjuUMPd0m7V2FtcGCOZLFkVp8g
Date: Fri, 12 Apr 2024 09:01:53 +0000
Message-ID: <PH7PR12MB559687B21A3592B4AB4429B793042@PH7PR12MB5596.namprd12.prod.outlook.com>
References: <20240412090016.10897-1-sunil.khatri@amd.com>
In-Reply-To: <20240412090016.10897-1-sunil.khatri@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=c4941324-b949-4c48-b6b1-c8eca0215e75;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=0;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2024-04-12T09:01:39Z;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR12MB5596:EE_|DM4PR12MB8452:EE_
x-ms-office365-filtering-correlation-id: 9725cb28-2187-484c-fd4d-08dc5acf32b3
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ZtGObXOJkoU7mwLpcvWbEQ6I2ufBa1RkK89OsnybVFs94ABAtevLStwJ3Uv36PzOry0nV8HMuvq8cqz057A2yGswg/IK8HjTrSAHojUuQJInSBG4Jn9mcqv5e/C1G0aN2Uwgoaj8uZezZnmZhZb6fMVK5sw0gsctj1TPvydJN4Ojv6UXlxv5MovGKPAvxqJfKsIa5vx2WHUSMlwEMxzE7UyIN6xfL9O4jWJ6Ncm8SdXvqEo/5bWDQ1RO6sBk2/EzJubRfNyv1WvAwpnwNKK+67DdCw18E5J8pQ7eEhvxC05kixBIsM6C3ZOHRUQ3Etmca1OpSPxFlkMAutGmVv4lKT5X+6YnSiQ60NWi+H+XsOHHQ7XDyljXUIT4xxOWu+wLTyXJWnoO/21VJxO4ydCz1y3kCsG6pJA3ZOt0WQmVsd16j7Eq28l8ZVaXgI+AXWwxN0oySHqR4IjEXSjDF8Hv8aukvXWw8XJV1Ajvt2g7PM1hVVMoM/aJitWwiw8SIlohkNjgw6cSJs4l7dPT2mdcF/5Xz7067UG4mYRy4xSvXn3sWB5ieC0LdBJhp4KgTIS11Qsjo5/AmBG1Hf6qBLWV3Xsvv5Nq/k8OGt4J85xwnAvIF84cgxzT76ly1OdbYilAuKMekjFlq1vQ3WTLQbarnIBEHb3aRcItAcZRrhufMIUGwc0ZJ+KgYbcZWe3BJm4W/RjOGDv1UOwkWs1StcnU4y8XR7JcYC1C+B8f7WBow0I=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5596.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(376005)(1800799015)(366007)(38070700009); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?mj3hK7lqgBu3OT4q31249lOnIpNwG2l1lAMV9qHhxnxyAWYp0mXPKVUeL60l?=
 =?us-ascii?Q?Xw534ClswwkJcWmmgy69Tln7kTP4LAs4YuGffNhz1EGPmY176TkkQoMsHior?=
 =?us-ascii?Q?x6NqCOwsEkbLhSA0djVxcaZhvrQGjq4hhkRyH+7cvZVeNBRTACVeG/30+Wt6?=
 =?us-ascii?Q?TmzliLDuW2i8ig85TW9p4CjBQqUJA2EBOfQdjZiE8Z9XoAPDXBL03ZEYcyhu?=
 =?us-ascii?Q?w9TnXDUUTD4bX155yt3YTwKmoiGw/vEikddDhFDmYLwAZsSJyJ2CN2j17fNg?=
 =?us-ascii?Q?FQsiRgoa0CnugxCasy8csNAHfKfYGtpfTvFzJKEmKhbkaODQnTUuT6WbIwUf?=
 =?us-ascii?Q?rruTBrvSAa1mLLYJRemQEVBm/JKjDE0CSGzr0iMzaPIGiqb+Fkt9E/OVsDfr?=
 =?us-ascii?Q?yWtLReAUzhJJfQthtRbk7hrrL+6A6O8mptpGo+HMp/3RcaQ3/OlHMlSo+cV8?=
 =?us-ascii?Q?KvkztQe/kQvvoNgdhvKNKloEkC56bKabt/LXP0ObjVWsfictcrqfNdPkxXax?=
 =?us-ascii?Q?PfB5C1NiaHKM4YbBFNc1CGaFawwJR8Pw0eX6Cmkw+MU8bDNaiyh4RfIE7UtK?=
 =?us-ascii?Q?sYZTJGdetwfJ/70QsW+huLbyRIuLg3asAgMNTaXhqxFO7VAyUunndkklzADu?=
 =?us-ascii?Q?Tbghx3gxZI3rNioZecdHvfmvl1G7lP9gLXDbGODVkNnQUMYtWvEGtKSMupq1?=
 =?us-ascii?Q?DB9TvxSE9CPmJiWeIaZEf9nogtOxWFI2a1bCWS/yPzDhh3RAeXPu2SFtQxPV?=
 =?us-ascii?Q?gP7zDarcQmMuzRRf95/pbrv1viPGAsPx8s+ih8U7XhfdEBE0O5/rJzT7iQHx?=
 =?us-ascii?Q?ULlexamBMRpEZfsrFfK0RPekn8HpTtBPOx7EdHTy6AKO7I5PF1DJpDe1P0j6?=
 =?us-ascii?Q?ShjbCXRcr6eJuA6EyHB3/M1RmDFoDmJ5NmZ4H+2Eku6O7MjQR6pUkexr9+k3?=
 =?us-ascii?Q?6587iGyxFwXSYVPu1cseSM2Psf6Pyw1JE/dJmQtbhE0H2JOtEyjv39IzfoO9?=
 =?us-ascii?Q?SiJeJz+7SMI6ZGvRNVHVH3iRyA4SrmEB98B9CylEP7jOsETPtZsH3ZqM3wn+?=
 =?us-ascii?Q?kx/NqRpS2nTRCOIzC9Lqlt8+1UaY4IqI83k15rmV/5noVfUl/dQc5Yap5OuN?=
 =?us-ascii?Q?VHhCzF5x5Vb6VcFlsDuGEwWMlU3ect27GEmtQZjPCFujNt4Qjjf+XvyshTIP?=
 =?us-ascii?Q?U3+Bo64SW8OEgM721kZauJOoXVRclEZLFY/MxIEqiqQKLxSEG2PHVg/I1j7I?=
 =?us-ascii?Q?V5GT4AoXSIND6bSvVLSCUxXF2fZT7uebD7ZAggUD0sXcJSatzEeD2kkn1qqx?=
 =?us-ascii?Q?mZirZuDMH//3f/x2prSRjQYaNrIVe2QVapOS+Wfi827QQCqnKAL8rFdXygGt?=
 =?us-ascii?Q?4PpZRi1PipGJvuxbK2eKDCN0Z+yAsZ1peY+RFb00j5ZJThtTlUV2LmdFfIf+?=
 =?us-ascii?Q?Xx8UzqgeOgrTAfgBpItaSdpOGoVwO9gDys4nkWN6AQx1OB3Sr/hhURw3crV5?=
 =?us-ascii?Q?qDXfNjeWVYILrhF+fdw3HvhJ0ZaqpPtGUSksL2uZtUWB9vavbC/J7t8DfItk?=
 =?us-ascii?Q?vXKIVM9yakjee57xwbQ=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5596.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9725cb28-2187-484c-fd4d-08dc5acf32b3
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Apr 2024 09:01:53.4827 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 4qKDh27M2NMZpSC1g5N+i9HNecnh2/MhtAkFI7aZ0KvU6xOUVB6wo1zefQs869yMqdrJNfRhsX3CUa38iZibAQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB8452
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

[AMD Official Use Only - General]

Ignore the series sent by mistake


-----Original Message-----
From: Sunil Khatri <sunil.khatri@amd.com>
Sent: Friday, April 12, 2024 2:30 PM
To: Deucher, Alexander <Alexander.Deucher@amd.com>; Koenig, Christian <Chri=
stian.Koenig@amd.com>
Cc: amd-gfx@lists.freedesktop.org; Khatri, Sunil <Sunil.Khatri@amd.com>
Subject: [PATCH 0/2] First set in IP dump patches

Adding infrastructure needed for ipdump along with dumping gfx10 registers.

Sunil Khatri (2):
  drm/amdgpu: add prototype to dump ip state
  drm/amdgpu: Add support of gfx10 register dump

 drivers/gpu/drm/amd/amdgpu/amdgpu.h           |  16 ++
 drivers/gpu/drm/amd/amdgpu/amdgpu_acp.c       |   1 +
 .../gpu/drm/amd/amdgpu/amdgpu_dev_coredump.c  |  22 +++
 drivers/gpu/drm/amd/amdgpu/amdgpu_umsch_mm.c  |   1 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_vkms.c      |   1 +
 drivers/gpu/drm/amd/amdgpu/cik.c              |   1 +
 drivers/gpu/drm/amd/amdgpu/cik_ih.c           |   1 +
 drivers/gpu/drm/amd/amdgpu/cik_sdma.c         |   1 +
 drivers/gpu/drm/amd/amdgpu/cz_ih.c            |   1 +
 drivers/gpu/drm/amd/amdgpu/dce_v10_0.c        |   1 +
 drivers/gpu/drm/amd/amdgpu/dce_v11_0.c        |   1 +
 drivers/gpu/drm/amd/amdgpu/dce_v6_0.c         |   1 +
 drivers/gpu/drm/amd/amdgpu/dce_v8_0.c         |   1 +
 drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c        | 142 ++++++++++++++++++
 drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c        |   1 +
 drivers/gpu/drm/amd/amdgpu/gfx_v6_0.c         |   1 +
 drivers/gpu/drm/amd/amdgpu/gfx_v7_0.c         |   1 +
 drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c         |   1 +
 drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c         |   1 +
 drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c       |   1 +
 drivers/gpu/drm/amd/amdgpu/gmc_v6_0.c         |   1 +
 drivers/gpu/drm/amd/amdgpu/gmc_v7_0.c         |   1 +
 drivers/gpu/drm/amd/amdgpu/gmc_v8_0.c         |   1 +
 drivers/gpu/drm/amd/amdgpu/iceland_ih.c       |   1 +
 drivers/gpu/drm/amd/amdgpu/ih_v6_0.c          |   1 +
 drivers/gpu/drm/amd/amdgpu/ih_v6_1.c          |   1 +
 drivers/gpu/drm/amd/amdgpu/ih_v7_0.c          |   1 +
 drivers/gpu/drm/amd/amdgpu/jpeg_v2_0.c        |   1 +
 drivers/gpu/drm/amd/amdgpu/jpeg_v2_5.c        |   2 +
 drivers/gpu/drm/amd/amdgpu/jpeg_v3_0.c        |   1 +
 drivers/gpu/drm/amd/amdgpu/jpeg_v4_0.c        |   1 +
 drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_3.c      |   1 +
 drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_5.c      |   1 +
 drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_0.c      |   1 +
 drivers/gpu/drm/amd/amdgpu/mes_v10_1.c        |   1 +
 drivers/gpu/drm/amd/amdgpu/mes_v11_0.c        |   1 +
 drivers/gpu/drm/amd/amdgpu/navi10_ih.c        |   1 +
 drivers/gpu/drm/amd/amdgpu/nv.c               |   1 +
 drivers/gpu/drm/amd/amdgpu/sdma_v2_4.c        |   1 +
 drivers/gpu/drm/amd/amdgpu/sdma_v3_0.c        |   1 +
 drivers/gpu/drm/amd/amdgpu/si.c               |   1 +
 drivers/gpu/drm/amd/amdgpu/si_dma.c           |   1 +
 drivers/gpu/drm/amd/amdgpu/si_ih.c            |   1 +
 drivers/gpu/drm/amd/amdgpu/soc15.c            |   1 +
 drivers/gpu/drm/amd/amdgpu/soc21.c            |   1 +
 drivers/gpu/drm/amd/amdgpu/tonga_ih.c         |   1 +
 drivers/gpu/drm/amd/amdgpu/uvd_v3_1.c         |   1 +
 drivers/gpu/drm/amd/amdgpu/uvd_v4_2.c         |   1 +
 drivers/gpu/drm/amd/amdgpu/uvd_v5_0.c         |   1 +
 drivers/gpu/drm/amd/amdgpu/uvd_v6_0.c         |   1 +
 drivers/gpu/drm/amd/amdgpu/vce_v2_0.c         |   1 +
 drivers/gpu/drm/amd/amdgpu/vce_v3_0.c         |   1 +
 drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c         |   1 +
 drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c         |   1 +
 drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c         |   2 +
 drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c         |   1 +
 drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c         |   1 +
 drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c       |   1 +
 drivers/gpu/drm/amd/amdgpu/vcn_v4_0_5.c       |   1 +
 drivers/gpu/drm/amd/amdgpu/vcn_v5_0_0.c       |   1 +
 drivers/gpu/drm/amd/amdgpu/vi.c               |   1 +
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c |   1 +
 drivers/gpu/drm/amd/include/amd_shared.h      |   1 +
 drivers/gpu/drm/amd/pm/legacy-dpm/kv_dpm.c    |   1 +
 drivers/gpu/drm/amd/pm/legacy-dpm/si_dpm.c    |   1 +
 .../gpu/drm/amd/pm/powerplay/amd_powerplay.c  |   1 +
 66 files changed, 245 insertions(+)

--
2.34.1

