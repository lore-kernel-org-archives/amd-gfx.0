Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1473AC46CD2
	for <amd-gfx@archiver.kernel.org>; Tue,  2 Jan 2024 05:42:07 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 89A8710E023;
	Tue,  2 Jan 2024 05:42:07 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2049.outbound.protection.outlook.com [40.107.243.49])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0EA6010E023
 for <amd-gfx@lists.freedesktop.org>; Tue,  2 Jan 2024 05:42:06 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=V8DRyzmd7qhe2VIyIHMeOwyhDLoq+VAJFw/2LMkcQsy5xSM65vaQp6WrT8N3C7BtcY6V5fFCiaqHFyda7WWSqnQXuxU7KUuwkWdIoeY6n0XTEGylY2EJGT9O43cYOlnpKe4wXjjc4QIc+4ZJsj8XV5S3jpOjw8QVBDLEKOP/XLByNYTs0rGSb/k/p3JS5PmO5LXIK8CT+F0+FQCU2bbhmPFpbg69vOAcHnwUjr6FgWuoEuVGt/tgog4x+HODxPZ6SXUUlkqEPa0EouDI05saKrMriEaoE/rmly8S2KE2S+4MsckiNXb+ROjLr0A1wpsBvwbkDlYhWD977oEPOHb6yQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=v516JQ+ibWE4S+YjLTZjyLC1KTPHzs21VuT3XXsIP6s=;
 b=QsxSR93zBZq5mezxXo8icrwaw7qzniRyLWFwylsTn1u2SYR1mxAA42LWH11Obg5/g/Aca5eWK7ShjaOkyEN3b6KGLauzklFTaFFtzUozMXojl13qi6K2hoarOCnxzRzE/Go7k2OZQC8IQ8XrwdQ7M5ITWD6NN3S2XfS67TSR6wEbGBJos+BeA5lSvXsh6BqzuVmewJp0hEF8lbMVrq5ScLxnNkfluoOPMxyKJJPNNQlm2QfZoR2KMR//nFNAGJ8mKo+AyT/+OCZ0JVtgVDKXITdGWw6EE+l2di6s58uMDdYV28I808vrIHtcyTg+B/Wh48YanIFHjbjkfHtkYerFFg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=v516JQ+ibWE4S+YjLTZjyLC1KTPHzs21VuT3XXsIP6s=;
 b=Tt0pHRpWVe7eT5f0ZIvNkPuUMdH+rw2NhRK9PMNvjI8Pw27R0fVSi5vnPCL1ZpFdFRRBPhg4w9dpoApVb2OQtWPFgEC66YIxlnUXGKpvpMybAKlqrBF702J24ZDyu4wzPyFuwbBwgSYCpHvR2XIMdvjOmzOONvOIsOFWqE5ggJA=
Received: from BN9PR12MB5257.namprd12.prod.outlook.com (2603:10b6:408:11e::16)
 by LV3PR12MB9268.namprd12.prod.outlook.com (2603:10b6:408:216::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7135.24; Tue, 2 Jan
 2024 05:42:02 +0000
Received: from BN9PR12MB5257.namprd12.prod.outlook.com
 ([fe80::7ee2:4db2:1828:ba83]) by BN9PR12MB5257.namprd12.prod.outlook.com
 ([fe80::7ee2:4db2:1828:ba83%4]) with mapi id 15.20.7135.023; Tue, 2 Jan 2024
 05:42:02 +0000
From: "Zhang, Hawking" <Hawking.Zhang@amd.com>
To: "Wang, Yang(Kevin)" <KevinYang.Wang@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>, "Zhou1, Tao"
 <Tao.Zhou1@amd.com>, "Yang, Stanley" <Stanley.Yang@amd.com>, "Chai, Thomas"
 <YiPeng.Chai@amd.com>, "Li, Candice" <Candice.Li@amd.com>
Subject: RE: [PATCH 3/5] drm/amdgpu: Add ras helper to query boot errors
Thread-Topic: [PATCH 3/5] drm/amdgpu: Add ras helper to query boot errors
Thread-Index: AQHaPS35IdYNba+H4kiPq/eslIAH57DF/Y0AgAAD9tA=
Date: Tue, 2 Jan 2024 05:42:02 +0000
Message-ID: <BN9PR12MB5257A72FF70458AD25BC4FCCFC61A@BN9PR12MB5257.namprd12.prod.outlook.com>
References: <20240102034341.16321-1-Hawking.Zhang@amd.com>
 <20240102034341.16321-4-Hawking.Zhang@amd.com>
 <PH7PR12MB59976F8EECA747F159A1BA178261A@PH7PR12MB5997.namprd12.prod.outlook.com>
In-Reply-To: <PH7PR12MB59976F8EECA747F159A1BA178261A@PH7PR12MB5997.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=64d1046d-f2f9-422f-bb90-a1265beff4eb;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=0;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2024-01-02T05:23:08Z;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR12MB5257:EE_|LV3PR12MB9268:EE_
x-ms-office365-filtering-correlation-id: 6da6d9d3-f000-4602-23e5-08dc0b558be3
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: YgjmO49BkOYDvHglIUG/YLOF4eRa116GRVueRlQR5lMFOd+oqGKxHFnvYtcB+IrHSvahIPEcJ8RVVLFvHa+mUiOufemhy2K0J6zNhX7uXBJTH4wBHVzd1v24k8QSe066jG9NoLQYNxPu+szlj7wM6n4glomlD9zV4gsrpyvcaU/6YMA2LG0UyWJ9O+pQCKf0U6sQWu2uMSbRXPbtZFMGHcu1iy5uewn+wtILVOAERVepEooX2/Qu7w/8SvcGOoiViYENoQonPl/wa8bJ8z3op+muXRa61gCaPrxuSXqbDBWDee4J8rltDzlAmJTu1HQQuwElihz1Kzv13KRL2rsM7C/faRnXZFfEBkz1addcp+7Fr3KlCNAhLl9YFuqGvi/gu9K5LW9EQdmfacIZEt/gSI/Rn+HLSl4q9wb7frEL1TtCj5AGC062Xl3a9oLHrj34vYQPet2L2s6daiEf7fB7dxbO1TI4PFLruzgoja7YiLij9EGNEWiYI2+t1349X4C+GO4Y68XhCAD0IKdZkPdynDR0UpcRRtNXJsnog6gLIL2fzux97Ov1DPftVF/Pzm6t+nV5rfSbd8qssfKZ2DQOMZF3BsbLVEIi+8kTEi/ZqSnYg6isAmJVWssIs6gfUqucOkTCSiuqya6HfnJdOUwWQg==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5257.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(396003)(136003)(346002)(376002)(366004)(39860400002)(230922051799003)(64100799003)(186009)(451199024)(1800799012)(55016003)(921011)(83380400001)(26005)(86362001)(38070700009)(38100700002)(71200400001)(33656002)(5660300002)(4326008)(52536014)(53546011)(9686003)(7696005)(6506007)(8676002)(8936002)(54906003)(76116006)(316002)(6636002)(66946007)(64756008)(66556008)(66476007)(66446008)(41300700001)(478600001)(110136005)(2906002)(122000001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?oKm9pzOKyTRvwL4IIJlIdCiN5GYAaKKZYQGXNfSdSB2kJudOC1CvlEF92jeO?=
 =?us-ascii?Q?80Kow+oemWkBjenzgdcfMaqOqrUhfROmRQxYD9IMYl2l9L/qANpzx/m7OAKy?=
 =?us-ascii?Q?c3PxXqmAM+aPZZ8/Hi1usLeQxKjz1LdKST6EH3L2OS0qzTVhG0wSqPRrXdAj?=
 =?us-ascii?Q?VmnJFcIzasFE4bnRRjDPFK4Q+yJ4NIk6zt6r2p7CZTgGq8oXzU1MgOq0lGEs?=
 =?us-ascii?Q?nlKUVtDhKylazz3Mq3Myucx6RfCy4MMCVgiETzMMFv28C7E+0H2rqXnvk7n/?=
 =?us-ascii?Q?XCMDHy8Gy9e5XgkgwAf68cGrbfvybwemozw8Xf0wMVURRKBZd7KdnjsFJPUx?=
 =?us-ascii?Q?QcFgFuU/6U3Y9vIzpTg9r99oThKIP0AroOsZMjuUkXF/z7WDvYtxpvlb/Pcj?=
 =?us-ascii?Q?L6AXQvyepIojIpnY2jOVq2AzXRz2uqIxBY0j6f8Z/94VqpS80fVhhuQKFRZq?=
 =?us-ascii?Q?2KjFvankeVZryHlJTHM0SOnsCqc4lBDfPGOfiZGRsQzxw27bPmIZlSKKr598?=
 =?us-ascii?Q?87zep85M1m+6s8F4JssunBK2g8v4KhehiJLR2ZlV1TBLqt3T4EY3r9V8LcN6?=
 =?us-ascii?Q?MMZyKW85OMTZWBdT4uxmA1dOKLuN+8mVDi4qEdcuio5nWXjECTQO+uH6oMek?=
 =?us-ascii?Q?PpylZM6X8Y+ndydizFzLRFvzCWckQuOfL4bgHrKOD/q8dtty+qq2ONhZU2sQ?=
 =?us-ascii?Q?rzvLf0ucy6ltVMEVNMFZX+sd+WZhILradvHv8RnpqPVaGuSmyedgOBS8q9Ma?=
 =?us-ascii?Q?l+Vt8rFgwzPqrSsqVjg8dEz9d6Bux8jdWN7GS+QBMBYe9jmjwfB5FqLTH+Wt?=
 =?us-ascii?Q?joQRePtj+tJ+s7+ReEgB3FtucPkDNNZZ/Ht8dVZ4Y5TYSLjw6NbGmEs99wLM?=
 =?us-ascii?Q?rFjMWrtlyuHtZ9Y1hVTtk1iS2jxQNJsyZHl+5hZe0Qx5zTvJqvIPwG8FPUQD?=
 =?us-ascii?Q?QrXZvVu/gCP25AbiqZVH2vw4lqMHwewv6XiyTZVzM9ySa3inN9qZmXEV79/i?=
 =?us-ascii?Q?MTNgrHhc5JVYbvjhHcnYu6zHhzFnZkKfzVyv1ScY3HqEXCPNlvBehDkhUkH0?=
 =?us-ascii?Q?9nuLHvvLVPRAr2wL4oeMx0qtDs07CKrcP0xsBdUIRnz7n8o+rz1WVjiUdd0g?=
 =?us-ascii?Q?b+nRVj1bZHDDKp+LoTGsn06lbXo/h4Z7VextP1Yfcmj+KJhTse7iN2zafgod?=
 =?us-ascii?Q?2lcqWXZfdzH96xuwM56QdJnW8qRufzm3mUrgVFY0262L8as7RE1+1DtxHAaB?=
 =?us-ascii?Q?BxhMjLXeAaTb57cXOp2MqoPnw7HyzDyhuexcFVM5qy8q1qMnmV8TgNDsutUB?=
 =?us-ascii?Q?g+8S80UjNxi7044H5rF03GOYndgTaxL8IQX4yHsgB+SByzrWtZCqyVb2GBFi?=
 =?us-ascii?Q?fL1v3s3opRAqIf8JuP4QrsnXTp5f9uG5i2MN3E4yIWgSkRy/9NJWQGnONc1n?=
 =?us-ascii?Q?MaY6sO9qyGDuV353r1+fsyxhWFqGLqilELv3FLswT87K9KGyE+93g7Vbeytm?=
 =?us-ascii?Q?blpVjQOiin3HWGik7icN2K+kLBRlxjiRjbBRX1iOVlyaC+Ien0Pg0GWNZCp+?=
 =?us-ascii?Q?AsS+ha1r6mxsujV6PCU=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5257.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6da6d9d3-f000-4602-23e5-08dc0b558be3
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Jan 2024 05:42:02.6531 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: kXgNlO1GTnBs62L6uOqJT28yhqIP4wKKLhPivqINfZoYAHdSrVf8yRvRL0Aw4zA4u49IziqpmBhXjQdKyzaj2A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR12MB9268
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
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Ma, Le" <Le.Ma@amd.com>,
 "Lazar, Lijo" <Lijo.Lazar@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Official Use Only - General]

I was hoping the macro could be used for 64bit registers as well. i.e., the=
 aca regs.

Regards,
Hawking

-----Original Message-----
From: Wang, Yang(Kevin) <KevinYang.Wang@amd.com>
Sent: Tuesday, January 2, 2024 13:24
To: Zhang, Hawking <Hawking.Zhang@amd.com>; amd-gfx@lists.freedesktop.org; =
Zhou1, Tao <Tao.Zhou1@amd.com>; Yang, Stanley <Stanley.Yang@amd.com>; Chai,=
 Thomas <YiPeng.Chai@amd.com>; Li, Candice <Candice.Li@amd.com>
Cc: Zhang, Hawking <Hawking.Zhang@amd.com>; Deucher, Alexander <Alexander.D=
eucher@amd.com>; Lazar, Lijo <Lijo.Lazar@amd.com>; Ma, Le <Le.Ma@amd.com>
Subject: RE: [PATCH 3/5] drm/amdgpu: Add ras helper to query boot errors

[AMD Official Use Only - General]

-----Original Message-----
From: Hawking Zhang <Hawking.Zhang@amd.com>
Sent: Tuesday, January 2, 2024 11:44 AM
To: amd-gfx@lists.freedesktop.org; Zhou1, Tao <Tao.Zhou1@amd.com>; Yang, St=
anley <Stanley.Yang@amd.com>; Wang, Yang(Kevin) <KevinYang.Wang@amd.com>; C=
hai, Thomas <YiPeng.Chai@amd.com>; Li, Candice <Candice.Li@amd.com>
Cc: Zhang, Hawking <Hawking.Zhang@amd.com>; Deucher, Alexander <Alexander.D=
eucher@amd.com>; Lazar, Lijo <Lijo.Lazar@amd.com>; Ma, Le <Le.Ma@amd.com>
Subject: [PATCH 3/5] drm/amdgpu: Add ras helper to query boot errors

Add ras helper function to query boot time gpu errors.

Signed-off-by: Hawking Zhang <Hawking.Zhang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu.h     |  3 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c | 95 +++++++++++++++++++++++++  dr=
ivers/gpu/drm/amd/amdgpu/amdgpu_ras.h | 15 +++-
 3 files changed, 112 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/amdg=
pu/amdgpu.h
index 616b6c911767..db44ec857a31 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
@@ -1328,6 +1328,9 @@ int emu_soc_asic_init(struct amdgpu_device *adev);
 #define WREG32_FIELD_OFFSET(reg, offset, field, val)   \
        WREG32(mm##reg + offset, (RREG32(mm##reg + offset) & ~REG_FIELD_MAS=
K(reg, field)) | (val) << REG_FIELD_SHIFT(reg, field))

+#define AMDGPU_SMN_TARGET_AID(x) ((u64)(x) << 32) #define
+AMDGPU_SMN_CROSS_AID (1ULL << 34) #define AMDGPU_GET_REG_FIELD(x, h, l)
+(((x) & GENMASK_ULL(h, l)) >> (l))

[kevin]:
The macro GENMASK_ULL() will return a 64bit mask value, but the register is=
 32 bits (in this patch),  do we need to change it to GENMASK() ? or you wa=
nt to cover 64bit register cases..
Thanks.

Best Regards,
Kevin
 /*
  * BIOS helpers.
  */
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c b/drivers/gpu/drm/amd/=
amdgpu/amdgpu_ras.c
index 39399d0f2ce5..5f302b7693b3 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
@@ -3764,3 +3764,98 @@ int amdgpu_ras_error_statistic_ce_count(struct ras_e=
rr_data *err_data,

        return 0;
 }
+
+#define mmMP0_SMN_C2PMSG_92    0x1609C
+#define mmMP0_SMN_C2PMSG_126   0x160BE
+static void amdgpu_ras_boot_time_error_reporting(struct amdgpu_device *ade=
v,
+                                                u32 instance, u32
+boot_error) {
+       u32 socket_id, aid_id, hbm_id;
+       u32 reg_data;
+       u64 reg_addr;
+
+       socket_id =3D AMDGPU_RAS_GPU_ERR_SOCKET_ID(boot_error);
+       aid_id =3D AMDGPU_RAS_GPU_ERR_AID_ID(boot_error);
+       hbm_id =3D AMDGPU_RAS_GPU_ERR_HBM_ID(boot_error);
+
+       if (instance)
+               reg_addr =3D (mmMP0_SMN_C2PMSG_92 << 2) +
+                          AMDGPU_SMN_TARGET_AID(instance) +
+                          AMDGPU_SMN_CROSS_AID;
+       else
+               reg_addr =3D (mmMP0_SMN_C2PMSG_92 << 2);
+
+       reg_data =3D amdgpu_device_indirect_rreg_ext(adev, reg_addr);
+       dev_err(adev->dev, "socket: %d, aid: %d, firmware boot failed, fw s=
tatus is 0x%x\n",
+               socket_id, aid_id, reg_data);
+
+       if (AMDGPU_RAS_GPU_ERR_MEM_TRAINING(boot_error))
+               dev_info(adev->dev, "socket: %d, aid: %d, hbm: %d, memory t=
raining failed\n",
+                        socket_id, aid_id, hbm_id);
+
+       if (AMDGPU_RAS_GPU_ERR_FW_LOAD(boot_error))
+               dev_info(adev->dev, "socket: %d, aid: %d, firmware load fai=
led at boot time\n",
+                        socket_id, aid_id);
+
+       if (AMDGPU_RAS_GPU_ERR_WAFL_LINK_TRAINING(boot_error))
+               dev_info(adev->dev, "socket: %d, aid: %d, wafl link trainin=
g failed\n",
+                        socket_id, aid_id);
+
+       if (AMDGPU_RAS_GPU_ERR_XGMI_LINK_TRAINING(boot_error))
+               dev_info(adev->dev, "socket: %d, aid: %d, xgmi link trainin=
g failed\n",
+                        socket_id, aid_id);
+
+       if (AMDGPU_RAS_GPU_ERR_USR_CP_LINK_TRAINING(boot_error))
+               dev_info(adev->dev, "socket: %d, aid: %d, usr cp link train=
ing failed\n",
+                        socket_id, aid_id);
+
+       if (AMDGPU_RAS_GPU_ERR_USR_DP_LINK_TRAINING(boot_error))
+               dev_info(adev->dev, "socket: %d, aid: %d, usr dp link train=
ing failed\n",
+                        socket_id, aid_id);
+
+       if (AMDGPU_RAS_GPU_ERR_HBM_MEM_TEST(boot_error))
+               dev_info(adev->dev, "socket: %d, aid: %d, hbm: %d, hbm memo=
ry test failed\n",
+                        socket_id, aid_id, hbm_id);
+
+       if (AMDGPU_RAS_GPU_ERR_HBM_BIST_TEST(boot_error))
+               dev_info(adev->dev, "socket: %d, aid: %d, hbm: %d, hbm bist=
 test failed\n",
+                        socket_id, aid_id, hbm_id); }
+
+static int amdgpu_ras_wait_for_boot_complete(struct amdgpu_device *adev,
+                                            u32 instance, u32 *boot_error)=
 {
+       u32 reg_addr;
+       u32 reg_data;
+       int retry_loop;
+
+       if (instance)
+               reg_addr =3D (mmMP0_SMN_C2PMSG_126 << 2) +
+                          AMDGPU_SMN_TARGET_AID(instance) +
+                          AMDGPU_SMN_CROSS_AID;
+       else
+               reg_addr =3D (mmMP0_SMN_C2PMSG_126 << 2);
+
+       for (retry_loop =3D 0; retry_loop < 1000; retry_loop++) {
+               reg_data =3D amdgpu_device_indirect_rreg_ext(adev, reg_addr=
);
+               if (AMDGPU_RAS_GPU_ERR_BOOT_STATUS(reg_data)) {
+                       *boot_error =3D reg_data;
+                       return 0;
+               }
+               msleep(1);
+       }
+
+       *boot_error =3D reg_data;
+       return -ETIME;
+}
+
+void amdgpu_ras_query_boot_status(struct amdgpu_device *adev, u32
+num_instances) {
+       u32 boot_error =3D 0;
+       u32 i;
+
+       for (i =3D 0; i < num_instances; i++) {
+               if (amdgpu_ras_wait_for_boot_complete(adev, i, &boot_error)=
)
+                       amdgpu_ras_boot_time_error_reporting(adev, i, boot_=
error);
+       }
+}
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h b/drivers/gpu/drm/amd/=
amdgpu/amdgpu_ras.h
index 76fb85628716..5785b705c692 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h
@@ -32,6 +32,19 @@

 struct amdgpu_iv_entry;

+#define AMDGPU_RAS_GPU_ERR_MEM_TRAINING(x)             AMDGPU_GET_REG_FIEL=
D(x, 0, 0)
+#define AMDGPU_RAS_GPU_ERR_FW_LOAD(x)                  AMDGPU_GET_REG_FIEL=
D(x, 1, 1)
+#define AMDGPU_RAS_GPU_ERR_WAFL_LINK_TRAINING(x)       AMDGPU_GET_REG_FIEL=
D(x, 2, 2)
+#define AMDGPU_RAS_GPU_ERR_XGMI_LINK_TRAINING(x)       AMDGPU_GET_REG_FIEL=
D(x, 3, 3)
+#define AMDGPU_RAS_GPU_ERR_USR_CP_LINK_TRAINING(x)     AMDGPU_GET_REG_FIEL=
D(x, 4, 4)
+#define AMDGPU_RAS_GPU_ERR_USR_DP_LINK_TRAINING(x)     AMDGPU_GET_REG_FIEL=
D(x, 5, 5)
+#define AMDGPU_RAS_GPU_ERR_HBM_MEM_TEST(x)             AMDGPU_GET_REG_FIEL=
D(x, 6, 6)
+#define AMDGPU_RAS_GPU_ERR_HBM_BIST_TEST(x)            AMDGPU_GET_REG_FIEL=
D(x, 7, 7)
+#define AMDGPU_RAS_GPU_ERR_SOCKET_ID(x)                        AMDGPU_GET_=
REG_FIELD(x, 10, 8)
+#define AMDGPU_RAS_GPU_ERR_AID_ID(x)                   AMDGPU_GET_REG_FIEL=
D(x, 12, 11)
+#define AMDGPU_RAS_GPU_ERR_HBM_ID(x)                   AMDGPU_GET_REG_FIEL=
D(x, 13, 13)
+#define AMDGPU_RAS_GPU_ERR_BOOT_STATUS(x)              AMDGPU_GET_REG_FIEL=
D(x, 31, 31)
+
 #define AMDGPU_RAS_FLAG_INIT_BY_VBIOS          (0x1 << 0)
 /* position of instance value in sub_block_index of
  * ta_ras_trigger_error_input, the sub block uses lower 12 bits @@ -818,5 =
+831,5 @@ int amdgpu_ras_error_statistic_ce_count(struct ras_err_data *err_=
data,  int amdgpu_ras_error_statistic_ue_count(struct ras_err_data *err_dat=
a,
                struct amdgpu_smuio_mcm_config_info *mcm_info,
                struct ras_err_addr *err_addr, u64 count);
-
+void amdgpu_ras_query_boot_status(struct amdgpu_device *adev, u32
+num_instances);
 #endif
--
2.17.1


