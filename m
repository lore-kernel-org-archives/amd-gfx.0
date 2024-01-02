Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DDF4BC46CD2
	for <amd-gfx@archiver.kernel.org>; Tue,  2 Jan 2024 05:24:35 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3A07410E061;
	Tue,  2 Jan 2024 05:24:35 +0000 (UTC)
Received: from NAM04-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam04on2086.outbound.protection.outlook.com [40.107.100.86])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B792E10E061
 for <amd-gfx@lists.freedesktop.org>; Tue,  2 Jan 2024 05:24:33 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NagDxF38zu7L/tRUFHF+wsc8WGwmikWasVUv0VGKhF8endwspg8Wa5vi7/fOjCszV7D2jEzLa30560iqjc4Kpk0SKJVN6fQEPlKW2n0rJ7mx/VICBVI5vDCMT4n7SgiDn1WMlt7Ny2JM7BwHbgeaB2/jQ3efxr6+1suyquxtr/kOYf9CGzPQTpgv4QYmKLop3UhJPT1MRQa5aaq0n7HfJ0yx8elzj0BlBFcZdUamlBm6HWrZUrywJL+kYMGlGbebDlxOXiusNt0GxGyxWSOM5bH81TVtV4aBXhEgYpBbuHnCYD4JyoGAavqIizIPc9IsI/fSvT4aFc/2Kjga89FEHw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uerWPxwNonSEmkOJNdSpz4mI03ib/uSrZgXHZNp6/RI=;
 b=jFYWC2m/LBYBZCxpEAluVs4Jqmij7NoVfHC7kXKGk7cc6if6L1jFHCDX8d7kXWeOw/CxYbYjEhLECB7r2lx2MWFGg902yXfESy5ts9HPV8eXCcntgWya0KKunxt6UXHkzzQbBnYQFo5vym9RSiaxY4d2eQ1EsxMbtATHKwIh5T4npV5T8JJxAyAqaJ2BmZxPArO4uIjHRdXHLUI9BcId0LNkWPxGEc7mboxk06yeR+MlxSziZtY7C30totowrwDAKsEwvgiXZ6PrWQ1YTjbHNJu8LloSWGWLYY77RwHhh5Y+GrMOSZCzOvCNIKLCs594UCly4npHi/vNg185tUfvhA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uerWPxwNonSEmkOJNdSpz4mI03ib/uSrZgXHZNp6/RI=;
 b=BLCEo8emUDtHwUal5cE8+VD5ELXdBFvOaA+dbAjeEs36k5RgMoGlUKOTVMU33DBuACrjBD/ZzMV8aQvKcWWHy8r5mOoj6pmLQ1LKpACNGfGDQNA2PLA0pphnOMb1hvhe2aIDNG+bRunVmXj/6u3ZXjPrKkARkXV6n6kXKo6RCQU=
Received: from PH7PR12MB5997.namprd12.prod.outlook.com (2603:10b6:510:1d9::21)
 by DM4PR12MB6303.namprd12.prod.outlook.com (2603:10b6:8:a3::6) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7135.24; Tue, 2 Jan 2024 05:24:28 +0000
Received: from PH7PR12MB5997.namprd12.prod.outlook.com
 ([fe80::61a8:83e4:c057:7790]) by PH7PR12MB5997.namprd12.prod.outlook.com
 ([fe80::61a8:83e4:c057:7790%4]) with mapi id 15.20.7135.023; Tue, 2 Jan 2024
 05:24:28 +0000
From: "Wang, Yang(Kevin)" <KevinYang.Wang@amd.com>
To: "Zhang, Hawking" <Hawking.Zhang@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>, "Zhou1, Tao" <Tao.Zhou1@amd.com>, "Yang, 
 Stanley" <Stanley.Yang@amd.com>, "Chai, Thomas" <YiPeng.Chai@amd.com>, "Li,
 Candice" <Candice.Li@amd.com>
Subject: RE: [PATCH 3/5] drm/amdgpu: Add ras helper to query boot errors
Thread-Topic: [PATCH 3/5] drm/amdgpu: Add ras helper to query boot errors
Thread-Index: AQHaPS35KxQyR9WLiEyHDq7KSNUPIrDF/S/g
Date: Tue, 2 Jan 2024 05:24:28 +0000
Message-ID: <PH7PR12MB59976F8EECA747F159A1BA178261A@PH7PR12MB5997.namprd12.prod.outlook.com>
References: <20240102034341.16321-1-Hawking.Zhang@amd.com>
 <20240102034341.16321-4-Hawking.Zhang@amd.com>
In-Reply-To: <20240102034341.16321-4-Hawking.Zhang@amd.com>
Accept-Language: en-US, zh-CN
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
x-ms-traffictypediagnostic: PH7PR12MB5997:EE_|DM4PR12MB6303:EE_
x-ms-office365-filtering-correlation-id: e0af3139-adcb-46ad-61eb-08dc0b53175b
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: BlKsU7SPJ2dJOCqBhx5YPRWvPLxMF4vESVhZkbXh7ws7w5SgM0VCyBe4FXjhC/XOHHeM9dHYglLXv0X6HL94Iqqlo/up2H6o1fYWaqVi5xKDOwzsB9jlNqxVEWsPwa+axvpIBDsaBjm1AsaUPLbcoTe/zXYw8XNhf9jwyK+NnH6vv40IP0mSv1OrvXQiXaeMKa6/rK41IPllN4EQGHdJGkzosQVDBnYcrTHOylIevPcproplFfLqYgDhvchCTYg0ZlzF9H4iWGjfoDM8AUrIlUGTqcnnwCUBg6hXP08fTYK5CrbKqDyKiaWayRJvpnIrsZV5jldfVnxHFIoX35S17KmNRMTE68br1jJCb30fj7h3xq+/z00ClESJ3DDhse2Ulbe7sbBsg3F3PYLk8o9AYCTg0LvnUDRrybFatS52gACxgC0+4cCFJHYgLmh2qpnoam3FDoHfaZoY/8bq08vC2Gg6BO3kWANo41Iqnph8BHkbKX6/ZefV5lfhVVpcL7BQIFTbBKaVdWYVRtlWjHrXW0LYvOfUHOx+0nJPy1J0fty999UJ7TUvozIhhh8Z66/xqdNyCjGsly+5CjSkbP5FwOvdibOnO5m3u5bK52umT2vFu3L0Pch1vzm/EJ4tLy8LWKzAqWYL32beiuM5Dcke8A==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5997.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(39860400002)(376002)(346002)(136003)(396003)(366004)(230922051799003)(451199024)(186009)(1800799012)(64100799003)(9686003)(83380400001)(26005)(53546011)(41300700001)(52536014)(5660300002)(4326008)(8676002)(8936002)(7696005)(2906002)(478600001)(66446008)(71200400001)(6506007)(316002)(54906003)(64756008)(122000001)(66946007)(66556008)(6636002)(66476007)(76116006)(110136005)(38070700009)(33656002)(86362001)(38100700002)(921011)(55016003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?Oxh4nKwB7DL+WltvZocMFidrUZ5BriHw8BW5QVZk644EWbxJD1JA4eWQMTaZ?=
 =?us-ascii?Q?9KJdrKJTZZP2kqywkluwm4qCO9M003y+iPc50HBC+V8mVYfb4jJ//9zi50Vx?=
 =?us-ascii?Q?w2GAkZIPqs7x4M/VtktNy84zDHjMZKsW/8AtAqKAZRqsm673+CQYd7gdJ8KY?=
 =?us-ascii?Q?BGlQACs5HWGj4bQxk9K+dVPxntEUU4lANs6OY0offeensZFkd5iqNdrVV4VX?=
 =?us-ascii?Q?gdT6c8+mDIJM5Fj4oCpsTxv3OVBCtMFI6S3AW5b2c8Z3IvLujlK2a3kyczrE?=
 =?us-ascii?Q?6jBwY6i/k2KyJ3upbx+VqUTrL0xw9INJuA+1zNI+GjWEXMGiFtOA5zq7fcbf?=
 =?us-ascii?Q?GXMKHqTnuf/C2h4lOH+3vMUnAYTxEWH8dxO+OtnD3XbO6sliE1/0Tqln0m5d?=
 =?us-ascii?Q?5L6NntdJSHSEpunCRCadcUu7xuodcdza7wzL0xNBMzfnnpgfzDM1Dohi39Kt?=
 =?us-ascii?Q?65mbGQxDwFiSxa5TfnP2z58aUxtxy8WOD36EiA+EJfsttV6sVcbxuCFGwdoJ?=
 =?us-ascii?Q?FP+/6qyGz5w7sL3uhMwBzhUgGaGIGo9pssZqVviKbw4ubnx7Bq7R2qd8I6I6?=
 =?us-ascii?Q?qnid1Hg4dTciZgwIHhVWQaBM44AkjccoUBU1LVlWhb3JUW9EUFG09WKZPhIJ?=
 =?us-ascii?Q?aBWIj/+68cn6jJLQek5+3xdp9CdIuX379T25VFylXIOZIKDaOAuErNRdOWVk?=
 =?us-ascii?Q?HQHBO7oIhkEgqH2XfIwzVzf+dw3hqk+HX61pWdyZtjH9j1xO4AhlGr9KiRsL?=
 =?us-ascii?Q?mcPknlABX2Fs1J1wyLzG0DUCaQHBPzZn1vZPi8OGAnpfTOmJSlv4veoxjoTq?=
 =?us-ascii?Q?04hAPmszr8wuuz/aq3YoniXUPbDeuE9bifKTSadrpE+aDouiMuy8ShCi/ufz?=
 =?us-ascii?Q?Z/a/XxygPl00SZQnMyzPrPU/OvQhNB4iQAu3UbS3HoWSUroG+haXU5CUTCZU?=
 =?us-ascii?Q?0M/yBBcKlU1gElpF5/5iYL1AuqykhCDUm3wwiT1KV3ObuQvguPFzmBvXSgss?=
 =?us-ascii?Q?uMpRAf6IYXMdEHM7u7KoU+55CueuY6jN3TqZhLZguKlTVKAiF4zQfXmWqFUk?=
 =?us-ascii?Q?2VwH6zaCH/dEFrBRFBFv3cqaQ7a0jkIRRZRna12maElikQnJtlW/FSRZP5TM?=
 =?us-ascii?Q?tr+mhxdmE/+PV2sgR7HOuBaTQnfxCZJNOJkpAqQlh/baF6IBUKLss1rQ3it+?=
 =?us-ascii?Q?bCDEDgeALhiQDVw4VVm5yLJwbXKYttJQZBUGjsyPPxRbhTOsZWi6b2JOrrtf?=
 =?us-ascii?Q?VdWeCYhQpOEJwcTftZbT3EP4bZlgi15eE6MBe23LeJCLC2ZNnui44ag+zVga?=
 =?us-ascii?Q?XSVNpt9+pyFZFPbmycr2MD9B2E8W50zLeiVnU38KnPH+w3ULECQNWozCSio0?=
 =?us-ascii?Q?TiFRIxtqvMfKczHlUzfKn9hVM76NBPGs46l23OUMfOU4m+iS6eW5+IIk5rk4?=
 =?us-ascii?Q?oSvd140hQ+TUDvpxjWNlpWHQD+lP6LXwSVjd1aRYKdp06eEMi6LhvzkJERXu?=
 =?us-ascii?Q?LzAHH/3SBzgd8emdkftDnPLJcHM3HTf/7h0TEOTGxxN0fODNxo9I0f+vks4r?=
 =?us-ascii?Q?GjiPncZjsLRMYPJ+x0Q=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5997.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e0af3139-adcb-46ad-61eb-08dc0b53175b
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Jan 2024 05:24:28.1239 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: lDOPEEL7cJSAuTPaxyWGJVTfmNvoVb0d0UvURyEkUTV+sna0VPP5Amr6mjIohAlU
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6303
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
 "Lazar, Lijo" <Lijo.Lazar@amd.com>, "Zhang, Hawking" <Hawking.Zhang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

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
+                                                u32 instance, u32 boot_err=
or)
+{
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
+                        socket_id, aid_id, hbm_id);
+}
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

