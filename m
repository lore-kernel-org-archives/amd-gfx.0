Return-Path: <SRS0=uIzi=PX=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5ED54C433EF
	for <amd-gfx@archiver.kernel.org>; Thu,  4 Nov 2021 06:47:57 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1ECDC60232
	for <amd-gfx@archiver.kernel.org>; Thu,  4 Nov 2021 06:47:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 1ECDC60232
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 616176E03C;
	Thu,  4 Nov 2021 06:47:56 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2069.outbound.protection.outlook.com [40.107.236.69])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 05D2B6E03C
 for <amd-gfx@lists.freedesktop.org>; Thu,  4 Nov 2021 06:47:55 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=R0SBHiD5RTx848fw9RL8eMR+XYf0HZXLYlKUvYyPAzCKePiNy3UuBzDCEFJa/8h0Dm8W9SKPVBDVms1b9WU5TrjGVSqylNVPRJIRMVEUyjn8Ex44Dzwga1rC1wmnDOn5cdU1YjZiqzlb4aUR8ToZ/bCCLBMpoIoV8NaOWKT47s2AsXvFF3NkgMd4jOTdDAL6QULdHTVclF9RNaLVbDOuJJ68XPlrwH/SwM/4Xxqes5fzTV2SxMsDs2nazt7XA4R4Ub5XySyj8MpjOkDHgM7V3Zb4m9KJx+nvIZoWUoqJH1diaO4WDKpfoPglN3iqQbFTSQxBgwCLLJnZW8tjK/EPGg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OVlSbGRPUHEcks60i4MOko+nBVsiCt7MHWh9iOhbvzk=;
 b=b+eGUL7GYBwuupMOiiyQpQGitayspQ0C4J5TD6V5dR7PWJ/xIpf3TwQWXU+msxIVlSkiPyKwJC9dRpPsqKTmGSQ2LKgZ0Xrulgvm6sW1tlQwt7ImRJGzJcCf6TpewmLbYo2zgu5thf44/riKdhCRhpkKVfqmcpv2lrqV4Oo3ePDqhk8wRplPGmFVB9Lr44UbDIl11HmGrQdgToqnjTWe2qKRKnL5qm11I+EbdbBBNAxbqiZhsvwbXFeX3WEqrYyLad3yUgS6V9OnQ5b29OmZniJJQyaFYuSVBcMdj9ki6S3kby55oXqrndHvIEO33TTj+SOJXmaohNdhrjZLaQpfqQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OVlSbGRPUHEcks60i4MOko+nBVsiCt7MHWh9iOhbvzk=;
 b=1Uy5Ma28hVulvF+hbR0hx8JmQMdYA8E2FoiFX6uMAW1d/5FOC5vwBQud8RNy/rrEw++Z9V8z8fuw0Yxvrp+QNPdjCRx5yYDLcs7X9tW6+02Xx4NsRk9KCYeXme2rDaIsGf9Ia8Cd6PD0bVJZLdUn/i4Y8qOx0iQaA1qK0xWEMY4=
Received: from DM5PR12MB2469.namprd12.prod.outlook.com (2603:10b6:4:af::38) by
 DM5PR12MB1770.namprd12.prod.outlook.com (2603:10b6:3:108::22) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4649.18; Thu, 4 Nov 2021 06:47:52 +0000
Received: from DM5PR12MB2469.namprd12.prod.outlook.com
 ([fe80::3142:d7d2:56a7:7c45]) by DM5PR12MB2469.namprd12.prod.outlook.com
 ([fe80::3142:d7d2:56a7:7c45%3]) with mapi id 15.20.4649.018; Thu, 4 Nov 2021
 06:47:52 +0000
From: "Chen, Guchun" <Guchun.Chen@amd.com>
To: "Quan, Evan" <Evan.Quan@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amdgpu: correctly toggle gfx on/off around RLC_SPM_*
 register access
Thread-Topic: [PATCH] drm/amdgpu: correctly toggle gfx on/off around RLC_SPM_*
 register access
Thread-Index: AQHX0UQHkuX09qfbZ0WemflM9cKlrKvy7S4Q
Date: Thu, 4 Nov 2021 06:47:52 +0000
Message-ID: <DM5PR12MB2469D015630E55E3731C3BF7F18D9@DM5PR12MB2469.namprd12.prod.outlook.com>
References: <20211104061948.111865-1-evan.quan@amd.com>
In-Reply-To: <20211104061948.111865-1-evan.quan@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Enabled=true;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SetDate=2021-11-04T06:47:50Z; 
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Method=Privileged;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Name=Public-AIP 2.0;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ActionId=68faaa71-c9e0-4700-a70c-841b65a4bfda;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ContentBits=1
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 191767f4-7d81-4f87-2241-08d99f5f0670
x-ms-traffictypediagnostic: DM5PR12MB1770:
x-microsoft-antispam-prvs: <DM5PR12MB17708BB4ABA2B3E9E9075883F18D9@DM5PR12MB1770.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6790;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: fD1dmUnGF3m44jRdGimFdqXdiTXl+VHhstLD5vf15jmlrC048Bh1Po6V7DSs9+2VH9eTOCZ5kY1xcNXmBIQud5qWun+NPh/P/RZnjnQG0OMTsnzhNDrbsQN9zZvhloV1sZCdJMYCYfTjiFUkZjIy8HjvmA5f726pm9h9Wmtm3vQnzQpN6TeFdXWCdsg2vfX06Ic2GMzFRieGP2lieOUX3XKXsuT6WSQCu2xWw6otyHjU1xBqBt9sCY50pifq+IappEznbJiXOsLHGkTccjZW8TWV5cnxsVo8Nz8pDrIenmJVg7O0B3EmywKTnLeA8DI5qGKTkVCH8rmMODy2ZdBTmhEYrtkORm6emTHU6pGAJs9pGmgJZVDGIwKFKUhIcJWDPWGBg5UEZkz/sncB8p3FL+u6fKRimPgWc1n0xcOLEzZqGDumjYhzllINjVhNYK4/MZRPBvjk03elcwUS1LDigMWs3cBxCdlBXi/gwjJpR1xJVWrzW2DR88/WK7kuaGxi+yMQPJcVRqRGuyreQ6CJtoYxU11nbu3m6tBewA7Bs2V1j3KwQoifYQEbaXQpT5mxq15OTRkd1RbScRxuqp1lMamlHncac3FIbYiAOMmxvw57sw1QdbANYVy6Jc7Lw/MBI0QIqul6d6eOtavWpkWYTUccGUBRwC3Jgg+18mbfVCls9mAzURSYtvEWzThidm+DaqtnIEjWJnU2Thz+4hUd9A==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM5PR12MB2469.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(7696005)(5660300002)(71200400001)(508600001)(52536014)(54906003)(86362001)(76116006)(66446008)(316002)(66476007)(64756008)(110136005)(66556008)(4326008)(66574015)(66946007)(9686003)(186003)(8676002)(8936002)(55016002)(33656002)(2906002)(83380400001)(26005)(6506007)(53546011)(38070700005)(122000001)(38100700002);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?Lx59ep+ARBM7MwWc1wR1U9vHA+tFbWfYKcdu6cc43asUASDVMbj7R3L54JWk?=
 =?us-ascii?Q?JJdWiZyrU0Z0/z3cb9h7R9nb6Ckf2aNdR/f5LAgWUju4Hp1rFz6gxhSZKqNW?=
 =?us-ascii?Q?YKp1dfLPgD16p6U7ZO7RLw9C7ryZEYgpyxAn27r+/qlQQxajpOD0CJVn56PS?=
 =?us-ascii?Q?6qXtlJBdUPSuYqLV2LnSggn5eCmPHfRtfgNmz1cWdrJewklANKLWI9XUFgaq?=
 =?us-ascii?Q?CM9oWLvWUjGWvmlFXtTWa0Ko2DX9wbDHUyhDdVJPcfspGgrmeXIvNA/N0lP7?=
 =?us-ascii?Q?yx5CcWJeR6cT8OZ9bYtZeQthMdsAFq7KXKSnuEQO5RgH6uinOSti6+4t28tS?=
 =?us-ascii?Q?CvHHvSEareyDhx4DVrFrxp/dcDex8ZNv2Mba14bI9RKPEA9Qsuv9fXtclRtF?=
 =?us-ascii?Q?U+zUkxbNH7qhbuOpqy1na2hKpY/AsIkR+EUg3aKVNvNVy7zCE3SpgjLk3bRx?=
 =?us-ascii?Q?kT7ydjO9ReN+to5d/ZN7D7lmRChm8dF559AQ8zUL09zhhehXQmSytu3sv3Hj?=
 =?us-ascii?Q?9tZ58G89toccrSuR8zUyga707D0qQ2FOb4z48xRJSpXdF/M9yK3kTxnM1ABD?=
 =?us-ascii?Q?9ZfEzRvTMCvtfFqZZcHfm03SuKJxgzD9RJhQHgiblg5+aJemJG3IRRP5thmE?=
 =?us-ascii?Q?wiD3fQIa36M8T6YOPcm6W4IalhMyvDGOwSgScPcrIhn8Fuchamb3mugrB4+0?=
 =?us-ascii?Q?4FRx10P00443WxI2RrdlBKrZ80hpcMuG10Y4SKBjlbk52kpzDCwL1s1B2kCL?=
 =?us-ascii?Q?sJSZlMJf3alXzxqM6DdjplYfXEx0DOBvNfb4pHQr9q+L0Q7SrMnYCHShqMRH?=
 =?us-ascii?Q?qBb55+bJMmpnhL9nlNkJVzhk1H8rx4XBKZUez/kPlsn9mT3V48n8AuHsp9nF?=
 =?us-ascii?Q?EwTzb5WNii0LUByyOA3NIGwRAcMkxs7HeNO4oLGO3zAeFf4DHKucRjK2ODwR?=
 =?us-ascii?Q?qZkryCsGuWAxPUKFvRP2rLaGThdisJE0nzeLJPS5bXmebELY9YfTLWyqdpLp?=
 =?us-ascii?Q?M5BheOGT8SpbNlFdej7pCTWyUQzNUDint6ClCsZhaS5ZXpXfSoLZNoKVwGXi?=
 =?us-ascii?Q?9L+h5+fNdTKdwSymuHRQqz4QbBEtE3Pi/U/rpO3tg4BX1R3SYaT3lGJjWbuq?=
 =?us-ascii?Q?Md5lY3VzOFudtynh7RAcd02yKNHwq5681ViOHBhS83hVmqjVtPU8l32znOFy?=
 =?us-ascii?Q?5wOKRs1mkkgDcT10KdwuytJOV4e0RRjBZkXjq9EgUuC9S0/oWtPy9W4MbFTn?=
 =?us-ascii?Q?A3bXX2rbB5QNUq1tz8q7VkbedgL5MsFLviI7yGvlttBJxtnACRx/TubE1+mK?=
 =?us-ascii?Q?BsDVBVtA20vy+Y9iAhEHWwAsKq0GJfjsNxIzkNmh01tZdHUiHQGxBuu+Xely?=
 =?us-ascii?Q?OEiCJBUCG3qsfXmP+puNnBFxwcYk3WJXqL9BT32kHoFv8Ojo5l9woVnjJ0Cw?=
 =?us-ascii?Q?G9TGHz7t9dJBkXSBfbE2rx9cmLfK/BRp3BSFXlpsUUatK243l516O+nMlbp2?=
 =?us-ascii?Q?r8v51prWJtFlrDLip7eahHZi/6aQvs80rqukyQ60jAwn3V36jPGvd9ang90Z?=
 =?us-ascii?Q?+m/OtiDPFYGmYPYDF69RvFTHwVxBZJlD5HJysH5ceKoLYl4bntuQgBkqchUz?=
 =?us-ascii?Q?s2dDu71bw0v9C2sxuShUXms=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM5PR12MB2469.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 191767f4-7d81-4f87-2241-08d99f5f0670
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Nov 2021 06:47:52.7248 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: zWOxYxO2jzAvtvcg01v7F60MdezQOcG8LQ/00hgwosQz+YmeeY8MJeAR4UIHiZmCMmZrB6JTmS0iie+UkIEjyQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1770
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
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Quan,
 Evan" <Evan.Quan@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[Public]

Acked-by: Guchun Chen <guchun.chen@amd.com>

Regards,
Guchun

-----Original Message-----
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Evan Qua=
n
Sent: Thursday, November 4, 2021 2:20 PM
To: amd-gfx@lists.freedesktop.org
Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Quan, Evan <Evan.Quan@a=
md.com>
Subject: [PATCH] drm/amdgpu: correctly toggle gfx on/off around RLC_SPM_* r=
egister access

As part of the ib padding process, accessing the RLC_SPM_* register may tri=
gger gfx hang. Since gfxoff may be already kicked during the whole period.
To address that, we manually toggle gfx on/off around the RLC_SPM_* registe=
r access.

This can resolve the gfx hang issue observed on running Talos with RDP laun=
ched in parallel.

Signed-off-by: Evan Quan <evan.quan@amd.com>
Change-Id: Ifae152e8151fecd25a238ebe87dffb3b17cdb540
---
 drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c | 5 +++++  drivers/gpu/drm/amd/amdg=
pu/gfx_v7_0.c  | 4 ++++  drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c  | 4 ++++  d=
rivers/gpu/drm/amd/amdgpu/gfx_v9_0.c  | 4 ++++
 4 files changed, 17 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c b/drivers/gpu/drm/amd/a=
mdgpu/gfx_v10_0.c
index fa03db34aec4..10fc9197602e 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
@@ -8388,6 +8388,9 @@ static int gfx_v10_0_update_gfx_clock_gating(struct a=
mdgpu_device *adev,  static void gfx_v10_0_update_spm_vmid(struct amdgpu_de=
vice *adev, unsigned vmid)  {
 	u32 reg, data;
+
+	amdgpu_gfx_off_ctrl(adev, false);
+
 	/* not for *_SOC15 */
 	reg =3D SOC15_REG_OFFSET(GC, 0, mmRLC_SPM_MC_CNTL);
 	if (amdgpu_sriov_is_pp_one_vf(adev))
@@ -8402,6 +8405,8 @@ static void gfx_v10_0_update_spm_vmid(struct amdgpu_d=
evice *adev, unsigned vmid)
 		WREG32_SOC15_NO_KIQ(GC, 0, mmRLC_SPM_MC_CNTL, data);
 	else
 		WREG32_SOC15(GC, 0, mmRLC_SPM_MC_CNTL, data);
+
+	amdgpu_gfx_off_ctrl(adev, true);
 }
=20
 static bool gfx_v10_0_check_rlcg_range(struct amdgpu_device *adev, diff --=
git a/drivers/gpu/drm/amd/amdgpu/gfx_v7_0.c b/drivers/gpu/drm/amd/amdgpu/gf=
x_v7_0.c
index 37b4a3db6360..d17a6f399347 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v7_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v7_0.c
@@ -3575,12 +3575,16 @@ static void gfx_v7_0_update_spm_vmid(struct amdgpu_=
device *adev, unsigned vmid)  {
 	u32 data;
=20
+	amdgpu_gfx_off_ctrl(adev, false);
+
 	data =3D RREG32(mmRLC_SPM_VMID);
=20
 	data &=3D ~RLC_SPM_VMID__RLC_SPM_VMID_MASK;
 	data |=3D (vmid & RLC_SPM_VMID__RLC_SPM_VMID_MASK) << RLC_SPM_VMID__RLC_S=
PM_VMID__SHIFT;
=20
 	WREG32(mmRLC_SPM_VMID, data);
+
+	amdgpu_gfx_off_ctrl(adev, true);
 }
=20
 static void gfx_v7_0_enable_cgcg(struct amdgpu_device *adev, bool enable) =
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c b/drivers/gpu/drm/amd/am=
dgpu/gfx_v8_0.c
index aefae5b1ff7b..1a476de20d08 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c
@@ -5727,6 +5727,8 @@ static void gfx_v8_0_update_spm_vmid(struct amdgpu_de=
vice *adev, unsigned vmid)  {
 	u32 data;
=20
+	amdgpu_gfx_off_ctrl(adev, false);
+
 	if (amdgpu_sriov_is_pp_one_vf(adev))
 		data =3D RREG32_NO_KIQ(mmRLC_SPM_VMID);
 	else
@@ -5739,6 +5741,8 @@ static void gfx_v8_0_update_spm_vmid(struct amdgpu_de=
vice *adev, unsigned vmid)
 		WREG32_NO_KIQ(mmRLC_SPM_VMID, data);
 	else
 		WREG32(mmRLC_SPM_VMID, data);
+
+	amdgpu_gfx_off_ctrl(adev, true);
 }
=20
 static const struct amdgpu_rlc_funcs iceland_rlc_funcs =3D { diff --git a/=
drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0=
.c
index 08e91e7245df..d9367747fed3 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
@@ -5218,6 +5218,8 @@ static void gfx_v9_0_update_spm_vmid(struct amdgpu_de=
vice *adev, unsigned vmid)  {
 	u32 reg, data;
=20
+	amdgpu_gfx_off_ctrl(adev, false);
+
 	reg =3D SOC15_REG_OFFSET(GC, 0, mmRLC_SPM_MC_CNTL);
 	if (amdgpu_sriov_is_pp_one_vf(adev))
 		data =3D RREG32_NO_KIQ(reg);
@@ -5231,6 +5233,8 @@ static void gfx_v9_0_update_spm_vmid(struct amdgpu_de=
vice *adev, unsigned vmid)
 		WREG32_SOC15_NO_KIQ(GC, 0, mmRLC_SPM_MC_CNTL, data);
 	else
 		WREG32_SOC15(GC, 0, mmRLC_SPM_MC_CNTL, data);
+
+	amdgpu_gfx_off_ctrl(adev, true);
 }
=20
 static bool gfx_v9_0_check_rlcg_range(struct amdgpu_device *adev,
--
2.29.0
