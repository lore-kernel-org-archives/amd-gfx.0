Return-Path: <SRS0=gBm/=OQ=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 697AEC433F5
	for <amd-gfx@archiver.kernel.org>; Sun, 26 Sep 2021 03:03:03 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 22E216108B
	for <amd-gfx@archiver.kernel.org>; Sun, 26 Sep 2021 03:03:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 22E216108B
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 882216E4FE;
	Sun, 26 Sep 2021 03:03:02 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2070.outbound.protection.outlook.com [40.107.237.70])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0956F6E4FE
 for <amd-gfx@lists.freedesktop.org>; Sun, 26 Sep 2021 03:03:02 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BiZTO1Bv5dbg8jBH4xu7f8aFY7klNDgOUTtdJX2a8X3GrkSuw1wtR/oEpMlJ5ZIoGghuoqa1iLRTn4sz1/MhDQ4sH/zJYU8VBdeK+GSi07xNotkuPUGrHgd6WFtemBjvyoHVEGosJNefcrTWhDJfRUGsPoRJiMvv/jNxR0X6lz3UT1yAWY69jjfcPsX7RP72/f75mijV7ppjhTOqM6y/DZCtwrEY7zxl1AeSuqzLuVlXyxI07Co1jBkVuvlsV8m8XPrFQp6eCnl7weuuflkL17ibec3qnn8tvZ/1fNgzZ/6oE1uesxALvAxR1YW4HPgmszg5KmatuqLT0/o400IfHQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version; 
 bh=ZrkcWIOwOUG4Kjvcu8h8Yfp2eHZfEqdyTibLOTpoj9E=;
 b=FDSU3ty6wVe9xE68q47c4b0Bh1e7dUzUOa+QIFVXWRGQs7GgHmx/2D4HVq6qke4dSlaydqTiKpjl8FvY7mFTvzceBk3a/CFsFFbCJdj56NwkOkZVdDPUj/xFOnOe3fk8rx95xR/zsv4yGa0LrYpa2lMUecNC6X8/MMHtGiwpUhNL/H/XAHoeZ8fxv+gVY5OwszsmQLD9XSz+3HzKcQUGhElQ0ErJ10TDcgThMtH3w4Brz6LHZ7LoU49jr035/1skpuykRTCsdofjhBK29DQgk2/4739LlHdUUAEw8HOalN1OKjg66j2dfHQBxV1Vq74FaM5LQ/f6JvQ3iZm87H+p5A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZrkcWIOwOUG4Kjvcu8h8Yfp2eHZfEqdyTibLOTpoj9E=;
 b=Me1DGzeVdl0qnT72QsuUQiBWyntf8IBRzaGUx5MhbELT6chxcAe5Qf4mxCVmkLVzUtm3PWl1T6cUF2uv/IxERD0BsN+xkDm8d71YniwQ8rKyhjOTM6jq3bkBctQcLSn9vbnTZLLvxJS4uiUDyO5ReY7IHcU5yMIBSL/XMbf3Dok=
Received: from BN9PR12MB5257.namprd12.prod.outlook.com (2603:10b6:408:11e::16)
 by BN9PR12MB5244.namprd12.prod.outlook.com (2603:10b6:408:101::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4544.13; Sun, 26 Sep
 2021 03:02:57 +0000
Received: from BN9PR12MB5257.namprd12.prod.outlook.com
 ([fe80::5101:db26:96eb:2ce4]) by BN9PR12MB5257.namprd12.prod.outlook.com
 ([fe80::5101:db26:96eb:2ce4%7]) with mapi id 15.20.4544.021; Sun, 26 Sep 2021
 03:02:57 +0000
From: "Zhang, Hawking" <Hawking.Zhang@amd.com>
To: "Zhou1, Tao" <Tao.Zhou1@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
CC: "Zhou1, Tao" <Tao.Zhou1@amd.com>
Subject: RE: [PATCH] drm/amdgpu: add poison mode query for DF (v2)
Thread-Topic: [PATCH] drm/amdgpu: add poison mode query for DF (v2)
Thread-Index: AQHXsn+LGtGwlIOuckO4cSTZXrdSWqu1oOuA
Date: Sun, 26 Sep 2021 03:02:57 +0000
Message-ID: <BN9PR12MB5257B596B88A651FF62976E1FCA69@BN9PR12MB5257.namprd12.prod.outlook.com>
References: <20210926023741.28736-1-tao.zhou1@amd.com>
In-Reply-To: <20210926023741.28736-1-tao.zhou1@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Enabled=true;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SetDate=2021-09-26T03:02:54Z; 
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Method=Standard;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Name=AMD Official Use
 Only-AIP 2.0;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ActionId=8796844b-711e-4074-9349-0cc1669ed4de;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ContentBits=1
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: cb15ea0c-5d0f-47ad-7631-08d9809a2480
x-ms-traffictypediagnostic: BN9PR12MB5244:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BN9PR12MB52449280DF3303653FAE2028FCA69@BN9PR12MB5244.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:619;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: UbmTRj3mvcT6jU8qz8Hvzf2n7AHPf1SzhdGhYhy6aEpzZ3EMQV2n/TI0CEB6+SUtasZFOYP1CkzFM2zhBqwq+SnXGrqseW8CjtRdQ1ud3Bblhw5ESoIdVPaxMvwZG1lL8bQiIQslkN/IlmpQYogFKZCVoDs/P1Yzmi8kJWVpImE1hhB8t793/0eZhMHiA4rytkHlYm9kWsxANEuPbg7/nE2v8Wgkx1lK/VUoZa3cFahSoevviV6yZYTAZh6surcRoa9CSdzfeNaYRKrmq7Qiu3DScJA++gu+S6mGc5/o7qGhYeHAozUXdffy+t2mmr0ZPf1oOCFWO14wCFbmS7wPHbrzU/qX7OfN1ZQSI6749PmkxpWuhZ/NM7eLx/hdVb8tHFS5PgAplhXeK4PKVfuYINgeF32Edpq+ay0Zs6Ykq5AFvfyMcKrVDWfM2aJRFpYvxRPq8CRo/f7jZJmRv6fDrJz2MEr2s7KMifNHpUi6VwUtegA06Jwbk9ZWdcRrhJ/mQKw3sduBOXy0XHpAVDwuP71Yy8GiF8CWr/aj52u5JjhzC2eUR4zBPc9HiceY28ZjE4Oh0aWBwmf2l2I81I6Px5jyZ7G91xQ2Nrt/aFAzvylCl1RlQUCe3H4CkLGCiqHr/k+ec0bZcnqe0PlWYBUpOXmHRrTvpwkicwEDTk47uz+NQdof8+W4bTVh7jLCPHcI7cQORZAK2dqfFEYIP08YCg==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5257.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(508600001)(2906002)(19627235002)(316002)(7696005)(33656002)(30864003)(6506007)(53546011)(71200400001)(26005)(83380400001)(76116006)(66946007)(5660300002)(8676002)(186003)(38100700002)(8936002)(122000001)(55016002)(9686003)(4326008)(66446008)(64756008)(66556008)(66476007)(86362001)(38070700005)(52536014)(110136005)(579004);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?GvBwfoFUCgh9pjTL+i4Xg9h1e30zhebo+FwyQfjsFBjhNB3lWXyp8Qu/GJp0?=
 =?us-ascii?Q?qpuRQcjmVvtj64O93V0/Wsd6Q9DnBgPHsqXRoAXEVm0rQb72RUYUoVp/jHkD?=
 =?us-ascii?Q?OFRDaUKZxBKH9Rsklo34ozhPEpaShmzln6h2B+lx9mXSDz0ardc30NLdhjJX?=
 =?us-ascii?Q?f88OYQcth1vzSExjYymjC36wGxk208exUcvfwqV8gsNZt4JH41BJiVI9SuQt?=
 =?us-ascii?Q?0GOhOWne224xxRomV+9+Hyu6zCqjRCRQRCk0YT092kGHcgU9uq7I296aDB3J?=
 =?us-ascii?Q?wNHdyqG01KVjtLHLY0+FBOiFu/lvuFFLx+39EIOpPRYt8VgxD2N4OPAVHe9m?=
 =?us-ascii?Q?ZF3rVSsph3gwz4XJNuvQ6+cMIig1XqDR5uaDf86nIYDebvYZLeIuMiOqo115?=
 =?us-ascii?Q?F2Uz63NDx32ro6FTaEbatUccuuuoL40tcSRn5OZoEvvLjj1VX9Oqsu1VqfIs?=
 =?us-ascii?Q?Ywx80R5/eNC9c5MEXJ8YR8HIhO3/BFV9eQt0e/BGeSkQ7cRIYL617S5NxFY7?=
 =?us-ascii?Q?DhDW2RWMwclYObLhtdEQ+eWm68EqHrrkN3yLkrUYuqnzV7NaoQJuJXBjcROH?=
 =?us-ascii?Q?bvQOYpStXCtFTKvorOh9w3YyMHscqAJ/dpmoC+at0oATW2rNYoadfRUV3Xxq?=
 =?us-ascii?Q?DcdQMC+DpABZfwWYuAA7w+Q+aWrtpKXi5lq6DgGJh1ctyPo5xY/9oH8a8KlG?=
 =?us-ascii?Q?57WomdFgELLA7DeEpDR7WNAsXzX9MIuB6BpKoSAvxkBwYiQqj122Uin4bGRB?=
 =?us-ascii?Q?Rq9qo46mKt46AexGNN4Dqb+A3o7u76+IHI5CpXW6TDYEpuYa8tssdoHo/XTF?=
 =?us-ascii?Q?YGBRK6qFj2W7sqKZFLerbAoagchPYiaSXPILdhXS2DQtSR+vYLhIsw17ajrM?=
 =?us-ascii?Q?4vfhrCBNG3iln6ujDExU5KZ11JgFbXwsSLZjZlJhpm3z9pL9RDvu6GoyDtY0?=
 =?us-ascii?Q?lc10MDG58verl0aKK1xmh8L+iupLLiQiPTxKV5igBCEhRl+08ErIdPINAIOb?=
 =?us-ascii?Q?+cQid22+O3Y0/ZsEasIjkP4qH6jAPHH/QRx0XN5XHB9yjTyTwLVh1DxKcg82?=
 =?us-ascii?Q?1WcRTZFVdfAJ8PjL2qV20iBe/U39eIOx8G26XZep7iDUmrfypg1q6Uo+EujQ?=
 =?us-ascii?Q?e5hZHKMam+3mftO+JfFy3yAI8ZIvcFQE5AKyIXNbLdSBe7yW3lbwr48G282+?=
 =?us-ascii?Q?Y8OrVFNA2AweGgbP7F98D6PkH3LuRcGn9I+tm8izXFiUHwGL0INR+YlsZehV?=
 =?us-ascii?Q?Nbv3CWsU9SGMVWjrBbbISepl9+XjKPSAa8nrwygbMuurZeuj0LJ0ZF/c/bK6?=
 =?us-ascii?Q?GlVn5yEOMtg7FOtKbYdMzjNi?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5257.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cb15ea0c-5d0f-47ad-7631-08d9809a2480
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Sep 2021 03:02:57.4298 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Wa89ejep90diRy5ejsRp34yAs8+euZlDNJ5hwS97sDJKQxdcOndj0NEejI+Fz/k6f/9Upt+JopgLLNuOrN70tg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR12MB5244
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

[AMD Official Use Only]

Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>

Regards,
Hawking
-----Original Message-----
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Tao Zhou
Sent: Sunday, September 26, 2021 10:38
To: amd-gfx@lists.freedesktop.org
Cc: Zhou1, Tao <Tao.Zhou1@amd.com>
Subject: [PATCH] drm/amdgpu: add poison mode query for DF (v2)

Add ras poison mode query interface for DF.

v2: replace RREG32_PCIE with RREG32_SOC15.

Signed-off-by: Tao Zhou <tao.zhou1@amd.com>
Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_df.h        |   1 +
 drivers/gpu/drm/amd/amdgpu/df_v3_6.c          |  31 ++++
 .../amd/include/asic_reg/df/df_3_6_offset.h   |   5 +
 .../amd/include/asic_reg/df/df_3_6_sh_mask.h  | 132 ++++++++++++++++++
 4 files changed, 169 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_df.h b/drivers/gpu/drm/amd/a=
mdgpu/amdgpu_df.h
index 52488bb45112..6b25837955c4 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_df.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_df.h
@@ -52,6 +52,7 @@ struct amdgpu_df_funcs {
 	uint64_t (*get_fica)(struct amdgpu_device *adev, uint32_t ficaa_val);
 	void (*set_fica)(struct amdgpu_device *adev, uint32_t ficaa_val,
 			 uint32_t ficadl_val, uint32_t ficadh_val);
+	bool (*query_ras_poison_mode)(struct amdgpu_device *adev);
 };
=20
 struct amdgpu_df {
diff --git a/drivers/gpu/drm/amd/amdgpu/df_v3_6.c b/drivers/gpu/drm/amd/amd=
gpu/df_v3_6.c
index 14514a145c17..43c5e3ec9a39 100644
--- a/drivers/gpu/drm/amd/amdgpu/df_v3_6.c
+++ b/drivers/gpu/drm/amd/amdgpu/df_v3_6.c
@@ -637,6 +637,36 @@ static void df_v3_6_pmc_get_count(struct amdgpu_device=
 *adev,
 	}
 }
=20
+static bool df_v3_6_query_ras_poison_mode(struct amdgpu_device *adev) {
+	uint32_t hw_assert_msklo, hw_assert_mskhi;
+	uint32_t v0, v1, v28, v31;
+
+	hw_assert_msklo =3D RREG32_SOC15(DF, 0,
+				mmDF_CS_UMC_AON0_HardwareAssertMaskLow);
+	hw_assert_mskhi =3D RREG32_SOC15(DF, 0,
+				mmDF_NCS_PG0_HardwareAssertMaskHigh);
+
+	v0 =3D REG_GET_FIELD(hw_assert_msklo,
+		DF_CS_UMC_AON0_HardwareAssertMaskLow, HWAssertMsk0);
+	v1 =3D REG_GET_FIELD(hw_assert_msklo,
+		DF_CS_UMC_AON0_HardwareAssertMaskLow, HWAssertMsk1);
+	v28 =3D REG_GET_FIELD(hw_assert_mskhi,
+		DF_NCS_PG0_HardwareAssertMaskHigh, HWAssertMsk28);
+	v31 =3D REG_GET_FIELD(hw_assert_mskhi,
+		DF_NCS_PG0_HardwareAssertMaskHigh, HWAssertMsk31);
+
+	if (v0 && v1 && v28 && v31)
+		return true;
+	else if (!v0 && !v1 && !v28 && !v31)
+		return false;
+	else {
+		dev_warn(adev->dev, "DF poison setting is inconsistent(%d:%d:%d:%d)!\n",
+				v0, v1, v28, v31);
+		return false;
+	}
+}
+
 const struct amdgpu_df_funcs df_v3_6_funcs =3D {
 	.sw_init =3D df_v3_6_sw_init,
 	.sw_fini =3D df_v3_6_sw_fini,
@@ -651,4 +681,5 @@ const struct amdgpu_df_funcs df_v3_6_funcs =3D {
 	.pmc_get_count =3D df_v3_6_pmc_get_count,
 	.get_fica =3D df_v3_6_get_fica,
 	.set_fica =3D df_v3_6_set_fica,
+	.query_ras_poison_mode =3D df_v3_6_query_ras_poison_mode,
 };
diff --git a/drivers/gpu/drm/amd/include/asic_reg/df/df_3_6_offset.h b/driv=
ers/gpu/drm/amd/include/asic_reg/df/df_3_6_offset.h
index bd37aa6b6560..b4b2584bbd66 100644
--- a/drivers/gpu/drm/amd/include/asic_reg/df/df_3_6_offset.h
+++ b/drivers/gpu/drm/amd/include/asic_reg/df/df_3_6_offset.h
@@ -77,4 +77,9 @@
 #define smnDF_CS_UMC_AON0_DramBaseAddress0 	0x1c110UL
 #define smnDF_CS_UMC_AON0_DramLimitAddress0 	0x1c114UL
=20
+#define mmDF_CS_UMC_AON0_HardwareAssertMaskLow                            =
                             0x067e
+#define mmDF_CS_UMC_AON0_HardwareAssertMaskLow_BASE_IDX                   =
                             0
+#define mmDF_NCS_PG0_HardwareAssertMaskHigh                               =
                             0x067f
+#define mmDF_NCS_PG0_HardwareAssertMaskHigh_BASE_IDX                      =
                             0
+
 #endif
diff --git a/drivers/gpu/drm/amd/include/asic_reg/df/df_3_6_sh_mask.h b/dri=
vers/gpu/drm/amd/include/asic_reg/df/df_3_6_sh_mask.h
index f804e13b002e..f45ec6f97ff2 100644
--- a/drivers/gpu/drm/amd/include/asic_reg/df/df_3_6_sh_mask.h
+++ b/drivers/gpu/drm/amd/include/asic_reg/df/df_3_6_sh_mask.h
@@ -62,4 +62,136 @@
 #define DF_CS_UMC_AON0_DramLimitAddress0__AllowReqIO_MASK                 =
                                    0x00000400L
 #define DF_CS_UMC_AON0_DramLimitAddress0__DramLimitAddr_MASK              =
                                    0xFFFFF000L
=20
+//DF_CS_UMC_AON0_HardwareAssertMaskLow
+#define DF_CS_UMC_AON0_HardwareAssertMaskLow__HWAssertMsk0__SHIFT         =
                                    0x0
+#define DF_CS_UMC_AON0_HardwareAssertMaskLow__HWAssertMsk1__SHIFT         =
                                    0x1
+#define DF_CS_UMC_AON0_HardwareAssertMaskLow__HWAssertMsk2__SHIFT         =
                                    0x2
+#define DF_CS_UMC_AON0_HardwareAssertMaskLow__HWAssertMsk3__SHIFT         =
                                    0x3
+#define DF_CS_UMC_AON0_HardwareAssertMaskLow__HWAssertMsk4__SHIFT         =
                                    0x4
+#define DF_CS_UMC_AON0_HardwareAssertMaskLow__HWAssertMsk5__SHIFT         =
                                    0x5
+#define DF_CS_UMC_AON0_HardwareAssertMaskLow__HWAssertMsk6__SHIFT         =
                                    0x6
+#define DF_CS_UMC_AON0_HardwareAssertMaskLow__HWAssertMsk7__SHIFT         =
                                    0x7
+#define DF_CS_UMC_AON0_HardwareAssertMaskLow__HWAssertMsk8__SHIFT         =
                                    0x8
+#define DF_CS_UMC_AON0_HardwareAssertMaskLow__HWAssertMsk9__SHIFT         =
                                    0x9
+#define DF_CS_UMC_AON0_HardwareAssertMaskLow__HWAssertMsk10__SHIFT        =
                                    0xa
+#define DF_CS_UMC_AON0_HardwareAssertMaskLow__HWAssertMsk11__SHIFT        =
                                    0xb
+#define DF_CS_UMC_AON0_HardwareAssertMaskLow__HWAssertMsk12__SHIFT        =
                                    0xc
+#define DF_CS_UMC_AON0_HardwareAssertMaskLow__HWAssertMsk13__SHIFT        =
                                    0xd
+#define DF_CS_UMC_AON0_HardwareAssertMaskLow__HWAssertMsk14__SHIFT        =
                                    0xe
+#define DF_CS_UMC_AON0_HardwareAssertMaskLow__HWAssertMsk15__SHIFT        =
                                    0xf
+#define DF_CS_UMC_AON0_HardwareAssertMaskLow__HWAssertMsk16__SHIFT        =
                                    0x10
+#define DF_CS_UMC_AON0_HardwareAssertMaskLow__HWAssertMsk17__SHIFT        =
                                    0x11
+#define DF_CS_UMC_AON0_HardwareAssertMaskLow__HWAssertMsk18__SHIFT        =
                                    0x12
+#define DF_CS_UMC_AON0_HardwareAssertMaskLow__HWAssertMsk19__SHIFT        =
                                    0x13
+#define DF_CS_UMC_AON0_HardwareAssertMaskLow__HWAssertMsk20__SHIFT        =
                                    0x14
+#define DF_CS_UMC_AON0_HardwareAssertMaskLow__HWAssertMsk21__SHIFT        =
                                    0x15
+#define DF_CS_UMC_AON0_HardwareAssertMaskLow__HWAssertMsk22__SHIFT        =
                                    0x16
+#define DF_CS_UMC_AON0_HardwareAssertMaskLow__HWAssertMsk23__SHIFT        =
                                    0x17
+#define DF_CS_UMC_AON0_HardwareAssertMaskLow__HWAssertMsk24__SHIFT        =
                                    0x18
+#define DF_CS_UMC_AON0_HardwareAssertMaskLow__HWAssertMsk25__SHIFT        =
                                    0x19
+#define DF_CS_UMC_AON0_HardwareAssertMaskLow__HWAssertMsk26__SHIFT        =
                                    0x1a
+#define DF_CS_UMC_AON0_HardwareAssertMaskLow__HWAssertMsk27__SHIFT        =
                                    0x1b
+#define DF_CS_UMC_AON0_HardwareAssertMaskLow__HWAssertMsk28__SHIFT        =
                                    0x1c
+#define DF_CS_UMC_AON0_HardwareAssertMaskLow__HWAssertMsk29__SHIFT        =
                                    0x1d
+#define DF_CS_UMC_AON0_HardwareAssertMaskLow__HWAssertMsk30__SHIFT        =
                                    0x1e
+#define DF_CS_UMC_AON0_HardwareAssertMaskLow__HWAssertMsk31__SHIFT        =
                                    0x1f
+#define DF_CS_UMC_AON0_HardwareAssertMaskLow__HWAssertMsk0_MASK           =
                                    0x00000001L
+#define DF_CS_UMC_AON0_HardwareAssertMaskLow__HWAssertMsk1_MASK           =
                                    0x00000002L
+#define DF_CS_UMC_AON0_HardwareAssertMaskLow__HWAssertMsk2_MASK           =
                                    0x00000004L
+#define DF_CS_UMC_AON0_HardwareAssertMaskLow__HWAssertMsk3_MASK           =
                                    0x00000008L
+#define DF_CS_UMC_AON0_HardwareAssertMaskLow__HWAssertMsk4_MASK           =
                                    0x00000010L
+#define DF_CS_UMC_AON0_HardwareAssertMaskLow__HWAssertMsk5_MASK           =
                                    0x00000020L
+#define DF_CS_UMC_AON0_HardwareAssertMaskLow__HWAssertMsk6_MASK           =
                                    0x00000040L
+#define DF_CS_UMC_AON0_HardwareAssertMaskLow__HWAssertMsk7_MASK           =
                                    0x00000080L
+#define DF_CS_UMC_AON0_HardwareAssertMaskLow__HWAssertMsk8_MASK           =
                                    0x00000100L
+#define DF_CS_UMC_AON0_HardwareAssertMaskLow__HWAssertMsk9_MASK           =
                                    0x00000200L
+#define DF_CS_UMC_AON0_HardwareAssertMaskLow__HWAssertMsk10_MASK          =
                                    0x00000400L
+#define DF_CS_UMC_AON0_HardwareAssertMaskLow__HWAssertMsk11_MASK          =
                                    0x00000800L
+#define DF_CS_UMC_AON0_HardwareAssertMaskLow__HWAssertMsk12_MASK          =
                                    0x00001000L
+#define DF_CS_UMC_AON0_HardwareAssertMaskLow__HWAssertMsk13_MASK          =
                                    0x00002000L
+#define DF_CS_UMC_AON0_HardwareAssertMaskLow__HWAssertMsk14_MASK          =
                                    0x00004000L
+#define DF_CS_UMC_AON0_HardwareAssertMaskLow__HWAssertMsk15_MASK          =
                                    0x00008000L
+#define DF_CS_UMC_AON0_HardwareAssertMaskLow__HWAssertMsk16_MASK          =
                                    0x00010000L
+#define DF_CS_UMC_AON0_HardwareAssertMaskLow__HWAssertMsk17_MASK          =
                                    0x00020000L
+#define DF_CS_UMC_AON0_HardwareAssertMaskLow__HWAssertMsk18_MASK          =
                                    0x00040000L
+#define DF_CS_UMC_AON0_HardwareAssertMaskLow__HWAssertMsk19_MASK          =
                                    0x00080000L
+#define DF_CS_UMC_AON0_HardwareAssertMaskLow__HWAssertMsk20_MASK          =
                                    0x00100000L
+#define DF_CS_UMC_AON0_HardwareAssertMaskLow__HWAssertMsk21_MASK          =
                                    0x00200000L
+#define DF_CS_UMC_AON0_HardwareAssertMaskLow__HWAssertMsk22_MASK          =
                                    0x00400000L
+#define DF_CS_UMC_AON0_HardwareAssertMaskLow__HWAssertMsk23_MASK          =
                                    0x00800000L
+#define DF_CS_UMC_AON0_HardwareAssertMaskLow__HWAssertMsk24_MASK          =
                                    0x01000000L
+#define DF_CS_UMC_AON0_HardwareAssertMaskLow__HWAssertMsk25_MASK          =
                                    0x02000000L
+#define DF_CS_UMC_AON0_HardwareAssertMaskLow__HWAssertMsk26_MASK          =
                                    0x04000000L
+#define DF_CS_UMC_AON0_HardwareAssertMaskLow__HWAssertMsk27_MASK          =
                                    0x08000000L
+#define DF_CS_UMC_AON0_HardwareAssertMaskLow__HWAssertMsk28_MASK          =
                                    0x10000000L
+#define DF_CS_UMC_AON0_HardwareAssertMaskLow__HWAssertMsk29_MASK          =
                                    0x20000000L
+#define DF_CS_UMC_AON0_HardwareAssertMaskLow__HWAssertMsk30_MASK          =
                                    0x40000000L
+#define DF_CS_UMC_AON0_HardwareAssertMaskLow__HWAssertMsk31_MASK          =
                                    0x80000000L
+
+//DF_NCS_PG0_HardwareAssertMaskHigh
+#define DF_NCS_PG0_HardwareAssertMaskHigh__HWAssertMsk0__SHIFT            =
                                    0x0
+#define DF_NCS_PG0_HardwareAssertMaskHigh__HWAssertMsk1__SHIFT            =
                                    0x1
+#define DF_NCS_PG0_HardwareAssertMaskHigh__HWAssertMsk2__SHIFT            =
                                    0x2
+#define DF_NCS_PG0_HardwareAssertMaskHigh__HWAssertMsk3__SHIFT            =
                                    0x3
+#define DF_NCS_PG0_HardwareAssertMaskHigh__HWAssertMsk4__SHIFT            =
                                    0x4
+#define DF_NCS_PG0_HardwareAssertMaskHigh__HWAssertMsk5__SHIFT            =
                                    0x5
+#define DF_NCS_PG0_HardwareAssertMaskHigh__HWAssertMsk6__SHIFT            =
                                    0x6
+#define DF_NCS_PG0_HardwareAssertMaskHigh__HWAssertMsk7__SHIFT            =
                                    0x7
+#define DF_NCS_PG0_HardwareAssertMaskHigh__HWAssertMsk8__SHIFT            =
                                    0x8
+#define DF_NCS_PG0_HardwareAssertMaskHigh__HWAssertMsk9__SHIFT            =
                                    0x9
+#define DF_NCS_PG0_HardwareAssertMaskHigh__HWAssertMsk10__SHIFT           =
                                    0xa
+#define DF_NCS_PG0_HardwareAssertMaskHigh__HWAssertMsk11__SHIFT           =
                                    0xb
+#define DF_NCS_PG0_HardwareAssertMaskHigh__HWAssertMsk12__SHIFT           =
                                    0xc
+#define DF_NCS_PG0_HardwareAssertMaskHigh__HWAssertMsk13__SHIFT           =
                                    0xd
+#define DF_NCS_PG0_HardwareAssertMaskHigh__HWAssertMsk14__SHIFT           =
                                    0xe
+#define DF_NCS_PG0_HardwareAssertMaskHigh__HWAssertMsk15__SHIFT           =
                                    0xf
+#define DF_NCS_PG0_HardwareAssertMaskHigh__HWAssertMsk16__SHIFT           =
                                    0x10
+#define DF_NCS_PG0_HardwareAssertMaskHigh__HWAssertMsk17__SHIFT           =
                                    0x11
+#define DF_NCS_PG0_HardwareAssertMaskHigh__HWAssertMsk18__SHIFT           =
                                    0x12
+#define DF_NCS_PG0_HardwareAssertMaskHigh__HWAssertMsk19__SHIFT           =
                                    0x13
+#define DF_NCS_PG0_HardwareAssertMaskHigh__HWAssertMsk20__SHIFT           =
                                    0x14
+#define DF_NCS_PG0_HardwareAssertMaskHigh__HWAssertMsk21__SHIFT           =
                                    0x15
+#define DF_NCS_PG0_HardwareAssertMaskHigh__HWAssertMsk22__SHIFT           =
                                    0x16
+#define DF_NCS_PG0_HardwareAssertMaskHigh__HWAssertMsk23__SHIFT           =
                                    0x17
+#define DF_NCS_PG0_HardwareAssertMaskHigh__HWAssertMsk24__SHIFT           =
                                    0x18
+#define DF_NCS_PG0_HardwareAssertMaskHigh__HWAssertMsk25__SHIFT           =
                                    0x19
+#define DF_NCS_PG0_HardwareAssertMaskHigh__HWAssertMsk26__SHIFT           =
                                    0x1a
+#define DF_NCS_PG0_HardwareAssertMaskHigh__HWAssertMsk27__SHIFT           =
                                    0x1b
+#define DF_NCS_PG0_HardwareAssertMaskHigh__HWAssertMsk28__SHIFT           =
                                    0x1c
+#define DF_NCS_PG0_HardwareAssertMaskHigh__HWAssertMsk29__SHIFT           =
                                    0x1d
+#define DF_NCS_PG0_HardwareAssertMaskHigh__HWAssertMsk30__SHIFT           =
                                    0x1e
+#define DF_NCS_PG0_HardwareAssertMaskHigh__HWAssertMsk31__SHIFT           =
                                    0x1f
+#define DF_NCS_PG0_HardwareAssertMaskHigh__HWAssertMsk0_MASK              =
                                    0x00000001L
+#define DF_NCS_PG0_HardwareAssertMaskHigh__HWAssertMsk1_MASK              =
                                    0x00000002L
+#define DF_NCS_PG0_HardwareAssertMaskHigh__HWAssertMsk2_MASK              =
                                    0x00000004L
+#define DF_NCS_PG0_HardwareAssertMaskHigh__HWAssertMsk3_MASK              =
                                    0x00000008L
+#define DF_NCS_PG0_HardwareAssertMaskHigh__HWAssertMsk4_MASK              =
                                    0x00000010L
+#define DF_NCS_PG0_HardwareAssertMaskHigh__HWAssertMsk5_MASK              =
                                    0x00000020L
+#define DF_NCS_PG0_HardwareAssertMaskHigh__HWAssertMsk6_MASK              =
                                    0x00000040L
+#define DF_NCS_PG0_HardwareAssertMaskHigh__HWAssertMsk7_MASK              =
                                    0x00000080L
+#define DF_NCS_PG0_HardwareAssertMaskHigh__HWAssertMsk8_MASK              =
                                    0x00000100L
+#define DF_NCS_PG0_HardwareAssertMaskHigh__HWAssertMsk9_MASK              =
                                    0x00000200L
+#define DF_NCS_PG0_HardwareAssertMaskHigh__HWAssertMsk10_MASK             =
                                    0x00000400L
+#define DF_NCS_PG0_HardwareAssertMaskHigh__HWAssertMsk11_MASK             =
                                    0x00000800L
+#define DF_NCS_PG0_HardwareAssertMaskHigh__HWAssertMsk12_MASK             =
                                    0x00001000L
+#define DF_NCS_PG0_HardwareAssertMaskHigh__HWAssertMsk13_MASK             =
                                    0x00002000L
+#define DF_NCS_PG0_HardwareAssertMaskHigh__HWAssertMsk14_MASK             =
                                    0x00004000L
+#define DF_NCS_PG0_HardwareAssertMaskHigh__HWAssertMsk15_MASK             =
                                    0x00008000L
+#define DF_NCS_PG0_HardwareAssertMaskHigh__HWAssertMsk16_MASK             =
                                    0x00010000L
+#define DF_NCS_PG0_HardwareAssertMaskHigh__HWAssertMsk17_MASK             =
                                    0x00020000L
+#define DF_NCS_PG0_HardwareAssertMaskHigh__HWAssertMsk18_MASK             =
                                    0x00040000L
+#define DF_NCS_PG0_HardwareAssertMaskHigh__HWAssertMsk19_MASK             =
                                    0x00080000L
+#define DF_NCS_PG0_HardwareAssertMaskHigh__HWAssertMsk20_MASK             =
                                    0x00100000L
+#define DF_NCS_PG0_HardwareAssertMaskHigh__HWAssertMsk21_MASK             =
                                    0x00200000L
+#define DF_NCS_PG0_HardwareAssertMaskHigh__HWAssertMsk22_MASK             =
                                    0x00400000L
+#define DF_NCS_PG0_HardwareAssertMaskHigh__HWAssertMsk23_MASK             =
                                    0x00800000L
+#define DF_NCS_PG0_HardwareAssertMaskHigh__HWAssertMsk24_MASK             =
                                    0x01000000L
+#define DF_NCS_PG0_HardwareAssertMaskHigh__HWAssertMsk25_MASK             =
                                    0x02000000L
+#define DF_NCS_PG0_HardwareAssertMaskHigh__HWAssertMsk26_MASK             =
                                    0x04000000L
+#define DF_NCS_PG0_HardwareAssertMaskHigh__HWAssertMsk27_MASK             =
                                    0x08000000L
+#define DF_NCS_PG0_HardwareAssertMaskHigh__HWAssertMsk28_MASK             =
                                    0x10000000L
+#define DF_NCS_PG0_HardwareAssertMaskHigh__HWAssertMsk29_MASK             =
                                    0x20000000L
+#define DF_NCS_PG0_HardwareAssertMaskHigh__HWAssertMsk30_MASK             =
                                    0x40000000L
+#define DF_NCS_PG0_HardwareAssertMaskHigh__HWAssertMsk31_MASK             =
                                    0x80000000L
+
 #endif
--
2.17.1
