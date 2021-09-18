Return-Path: <SRS0=x7R6=OI=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13741C433EF
	for <amd-gfx@archiver.kernel.org>; Sat, 18 Sep 2021 08:59:16 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C864B6124B
	for <amd-gfx@archiver.kernel.org>; Sat, 18 Sep 2021 08:59:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org C864B6124B
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5CC326E122;
	Sat, 18 Sep 2021 08:59:15 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2079.outbound.protection.outlook.com [40.107.92.79])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2D0D46E122
 for <amd-gfx@lists.freedesktop.org>; Sat, 18 Sep 2021 08:59:14 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=b3QnrxqopD6/LTBRXjwI6R1Gq5DNTOO9gtlaRCXlmBOWABAnnh+4n0crST+7/R0I6CmHO6pzE5jhas8uszTxRYO6Mv0TA2a0rxgNDLKIZsAWa/BK80ZFZikTFGD0ZsMc9PNhj0wdrwuNmYFvGb2afG6JdwkvUqe+uj72Sl+D9Kc/bYRnG7ueCRclIKDOmHDwtZA787av6HFIsh7eJvXqv0mDRyFgfdEfA9Tzb7XwfpHF6WWuEXLdoXN6fermJNFZK7V461aupvR7MHAIJ1/606lDjANSwJ39z0MtactfUoNaYJMuDwdLRdKoN3aAaM/j7nw0j6DyAAfkhki/BGXJ2g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version; 
 bh=UGzdsMHTkYwFq6HwTFFWd66coyTbd1/Hl7PdZRDWtTI=;
 b=MtPxAyW2U4Ay/pKPQ16FaqiW0bAmxQkB602thG5d6H3Lm6q28v1qIYW8pkj2ci3PE2q85Bh2LhXZoLzIEjSgVXvqXk0Cwue5H5QEmqNEG6gX+ygdCVkXkfV41n8McUrLMP2BRllx2DoPOwCk4aWpSlGzw6oE7U9q4mzYni6BGU2nf3u51bECJQEexpkt3Schc7ZCeiFw7TfT4DetHvhyHUSK8djf6VxAt9X5x+zZVtatMsZFVkoY5hfk4S6TSv+KfZIaNIMwEIcCoRZ7qQoIUxrrfAClpgX2u2qTsWV3RVxRq4KfBU2Es7f6doGG0W06IEj8hgbGpQciPVjbyRCH8Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UGzdsMHTkYwFq6HwTFFWd66coyTbd1/Hl7PdZRDWtTI=;
 b=OakAyIJlL6KTst0uy/Ad+JuN5ztQczX2bA87OCkRl4eP5ah6D9EhcShaM2zs2uy5gn9ux5uQy1KVlKun1Uw/KUlXRj+jPQW7ktcKK8CYOfMik9sR4I3noThOG12kO9wBUa4TzpjtZ45pNUVMRLgsocpjcJkgJ2c7KPJ3jtABtWY=
Received: from BN9PR12MB5257.namprd12.prod.outlook.com (2603:10b6:408:11e::16)
 by BN9PR12MB5161.namprd12.prod.outlook.com (2603:10b6:408:11a::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4523.14; Sat, 18 Sep
 2021 08:59:12 +0000
Received: from BN9PR12MB5257.namprd12.prod.outlook.com
 ([fe80::5101:db26:96eb:2ce4]) by BN9PR12MB5257.namprd12.prod.outlook.com
 ([fe80::5101:db26:96eb:2ce4%7]) with mapi id 15.20.4523.018; Sat, 18 Sep 2021
 08:59:12 +0000
From: "Zhang, Hawking" <Hawking.Zhang@amd.com>
To: "Zhou1, Tao" <Tao.Zhou1@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>, "Clements, John" <John.Clements@amd.com>,
 "Yang, Stanley" <Stanley.Yang@amd.com>
Subject: RE: [PATCH 1/3] drm/amdgpu: add poison mode query for UMC
Thread-Topic: [PATCH 1/3] drm/amdgpu: add poison mode query for UMC
Thread-Index: AQHXrGRSmqNa/Jhpj0y9Dc4WNyI/1aupfUYw
Date: Sat, 18 Sep 2021 08:59:12 +0000
Message-ID: <BN9PR12MB5257E84F56621EDE58CF6497FCDE9@BN9PR12MB5257.namprd12.prod.outlook.com>
References: <20210918080751.23615-1-tao.zhou1@amd.com>
In-Reply-To: <20210918080751.23615-1-tao.zhou1@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Enabled=true;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SetDate=2021-09-18T08:59:07Z; 
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Method=Standard;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Name=AMD Official Use
 Only-AIP 2.0;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ActionId=af588c0b-d87f-47eb-873a-b301c22dbf95;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ContentBits=1
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: daa8f78c-aa19-4a4c-c42b-08d97a8295d5
x-ms-traffictypediagnostic: BN9PR12MB5161:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BN9PR12MB51614419C88A2B5E155C0633FCDE9@BN9PR12MB5161.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:345;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: X36ipX+Q5BDifHg8ZbUvh14VFHk53Nmh+bJGalZfdXlx1TdARv3ADRrPAWltoOV7jgjvDAeSO8+hKF0UXgU8EnlAf6dl0vgCY/6Dljt7boC/75haZ3bWsls68VX3OG1eJqcYMQ/GnkVeXRpKlBe0hFIN9b8Zq2hrZkSLzO95WWQNCwdft+923kFT3PpC+vNlcxJfGcAYk5deMat06CQXYM4OwiGMq8/KyLZA2WI/OOVhBN+5A3Ff/tUgLZAPGYfbLX4iXv1z5KF7v8MU/pp/h2WrqHCLlQBz763hsUvu7OzVXmQtUC2jj/X3iIreRZ3aQ01jNoOzxQlYz5LgaNX2Utj9KcnSUfToJyhpBvnaXo8BuFBS9jPF99Xy2qArG+8SyI8LjCXZN1CzN+fTLFKfhXCYKO2rDWe/fFk6PUGdL8v1W4nCoyomUq1T50U2Yx2XZlbojQL1dbHw67KiZ5vBIfX/U/wSRPRd8ape1s1q6pNL5bugFDUcUya5NWq0bwkYK9PMy4/KBgpP6FZrOX2NjV0PkShvMiTv2hGvMCwcw0t/qV3tkr0jtWI2Axjg4AUAun+IWeYqGky1AahcLMsyQu73CyX683GTeuyM5eLs+PS1+URhn+PQHM2vwm5lAad+Yf1i2agdBj7bMpEs8XzIOxL/GIb32DOo1wCeS3kbt/ntAlU15RnAu9/ubH1A6NAUSZERBZL/Fzu8KNuLo0RIOQ==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5257.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(396003)(136003)(346002)(39860400002)(376002)(316002)(33656002)(64756008)(110136005)(52536014)(122000001)(66476007)(76116006)(66556008)(186003)(38100700002)(83380400001)(66446008)(6636002)(2906002)(66946007)(5660300002)(26005)(53546011)(6506007)(86362001)(478600001)(8936002)(9686003)(55016002)(8676002)(38070700005)(7696005)(71200400001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?y0tNiZUKpZLye5vk6QdV305/vv6dZ1oGXHbfPkvcjFo5+23oE5rsZFUCFlc+?=
 =?us-ascii?Q?BjpmrpxX+WfP1GHkjetpNLji8P/V0xWcKPqp/2oRK2dkU6n1SA/we1IqXzCe?=
 =?us-ascii?Q?hcH3CWzkwuOP6ZfmSuu4ga5WUPjGOtgJLuGTkgNh/nzQZbAjO6r3ps/2xpow?=
 =?us-ascii?Q?DdVKKoBQZP9ti/U+UzioSmhsEY/YkNeRp49KFLCveJIxfCd9NebUnUn64OD8?=
 =?us-ascii?Q?T4vpB6aaUuwMqTeZE+tlfoaNtPpQMKQlOvIJGTac1zoeI1GQQf5kHAk4JhF6?=
 =?us-ascii?Q?roJ2dfty74vp/yj9iUCRx3/9oc8jGGWKPt7BTrlJ5HfDfGQ4qCpV+AH05jRy?=
 =?us-ascii?Q?4GlMQEetzomBf7dVCSKJz1xlRMQl+F2HqZYuuLjYCiick8ELvu1s+Cx9/ATk?=
 =?us-ascii?Q?DzZu3WQkNdPaaT3SrsGFzGQNKItYMGp9wVmjnVcsAmNylPiYC3jMIxUknmSC?=
 =?us-ascii?Q?vKTuxYmYMoGWSuZ4QLmMODdL4HkX0yHPYqVjTNQ25NNzkl2bGb24O5sZhYPX?=
 =?us-ascii?Q?Sfn8lzlKdOK3bUaQLpqV+BsGJI/RhH86DxK6vpojSVTYkI6oAVsQ8+YZ5ncF?=
 =?us-ascii?Q?AylU/4YbyMDYgtSKxaua65O1haO/KPk/N7aIe3uHQwTBCnP3pmuG4NjwO49l?=
 =?us-ascii?Q?oJ2YjTcQiIVDvast9zndjV1gWjspBsDIKsHCfj8TJe/E2Q/GGiF5Q7jyeEp3?=
 =?us-ascii?Q?gYoNFmwRj3SZEa6g6yv05ojcHZn8aqOlhNzz63wv9Y+nCj5TnQGcX7EWUslZ?=
 =?us-ascii?Q?8VPdU9PXLoND0NOPqsq1w0t8VQPhDRPgZ+7RNDxeFUPu1pfBWk/fiymWYGqJ?=
 =?us-ascii?Q?CKg3qjgIAno2y+T2lJf4Cj/cBEc/5iAdXmKcLFlQFuXFqVOTI/8tvsUY4rAb?=
 =?us-ascii?Q?UhI60asPJtCZKX5npduF9ljRWxNUyu4DMSgQOXk/HH/Nc6Dqx9xjLtegqlCD?=
 =?us-ascii?Q?flU7iPzmtbOIkE6YP0/F/Stb8PEGp1eJmmmpNSMxEOLj8grxMuzh6rtKFg3N?=
 =?us-ascii?Q?MdMPN1wFLSsCd/NcT2Wd87x55UuNiJWX5M0/0DDl06LkYhBetklgFXMp7o1W?=
 =?us-ascii?Q?GUiQ2stZdTRrDjJJFTDpCsAtnqKsZDaTL6qpAkg3RllEHZXBf5Tb8F3OBy0M?=
 =?us-ascii?Q?t6QmrN7jp78fqxuOBqyO515vNy/hhguhsA9T7TmaYW7jgy+pPabHFcyhKETr?=
 =?us-ascii?Q?J0S8I57CpxkJd/60Wb5/6kHFFPgVeagCTIq9dP0rSZJqih9s516VJ4JdoMPt?=
 =?us-ascii?Q?XztbsMEr0ES09CBLIu+aH53DgMp7a9TMKcOpAfK4aVYCAvLM8zEiJvv8oSWV?=
 =?us-ascii?Q?JKHyXvKxYlerTLbqk8ahAacs?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5257.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: daa8f78c-aa19-4a4c-c42b-08d97a8295d5
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Sep 2021 08:59:12.6194 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: P4qqop5VFRV/cOnshIu8D/V79Eya9//lH+spDb6sYJnDj5faGh7TnHZWIvSsy39IU+r5OV3k+FMeuskNheVeWQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR12MB5161
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
From: Zhou1, Tao <Tao.Zhou1@amd.com>=20
Sent: Saturday, September 18, 2021 16:08
To: amd-gfx@lists.freedesktop.org; Zhang, Hawking <Hawking.Zhang@amd.com>; =
Clements, John <John.Clements@amd.com>; Yang, Stanley <Stanley.Yang@amd.com=
>
Cc: Zhou1, Tao <Tao.Zhou1@amd.com>
Subject: [PATCH 1/3] drm/amdgpu: add poison mode query for UMC

Add ras poison mode query interface for UMC.

Signed-off-by: Tao Zhou <tao.zhou1@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_umc.h |  1 +
 drivers/gpu/drm/amd/amdgpu/umc_v6_7.c   | 34 +++++++++++++++++++++++++
 2 files changed, 35 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_umc.h b/drivers/gpu/drm/amd/=
amdgpu/amdgpu_umc.h
index e5a75fb788dd..1f5fe2315236 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_umc.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_umc.h
@@ -48,6 +48,7 @@ struct amdgpu_umc_ras_funcs {
 				      void *ras_error_status);
 	void (*query_ras_error_address)(struct amdgpu_device *adev,
 					void *ras_error_status);
+	bool (*query_ras_poison_mode)(struct amdgpu_device *adev);
 };
=20
 struct amdgpu_umc_funcs {
diff --git a/drivers/gpu/drm/amd/amdgpu/umc_v6_7.c b/drivers/gpu/drm/amd/am=
dgpu/umc_v6_7.c
index bb30336b1e8d..f7ec3fe134e5 100644
--- a/drivers/gpu/drm/amd/amdgpu/umc_v6_7.c
+++ b/drivers/gpu/drm/amd/amdgpu/umc_v6_7.c
@@ -288,9 +288,43 @@ static void umc_v6_7_query_ras_error_address(struct am=
dgpu_device *adev,
 	}
 }
=20
+static uint32_t umc_v6_7_query_ras_poison_mode_per_channel(
+						struct amdgpu_device *adev,
+						uint32_t umc_reg_offset)
+{
+	uint32_t ecc_ctrl_addr, ecc_ctrl;
+
+	ecc_ctrl_addr =3D
+		SOC15_REG_OFFSET(UMC, 0, regUMCCH0_0_EccCtrl);
+	ecc_ctrl =3D RREG32_PCIE((ecc_ctrl_addr +
+					umc_reg_offset) * 4);
+
+	return REG_GET_FIELD(ecc_ctrl, UMCCH0_0_EccCtrl, UCFatalEn); }
+
+static bool umc_v6_7_query_ras_poison_mode(struct amdgpu_device *adev)=20
+{
+	uint32_t umc_inst        =3D 0;
+	uint32_t ch_inst         =3D 0;
+	uint32_t umc_reg_offset  =3D 0;
+
+	LOOP_UMC_INST_AND_CH(umc_inst, ch_inst) {
+		umc_reg_offset =3D get_umc_v6_7_reg_offset(adev,
+							umc_inst,
+							ch_inst);
+		/* Enabling fatal error in one channel will be considered
+		   as fatal error mode */
+		if (umc_v6_7_query_ras_poison_mode_per_channel(adev, umc_reg_offset))
+			return false;
+	}
+
+	return true;
+}
+
 const struct amdgpu_umc_ras_funcs umc_v6_7_ras_funcs =3D {
 	.ras_late_init =3D amdgpu_umc_ras_late_init,
 	.ras_fini =3D amdgpu_umc_ras_fini,
 	.query_ras_error_count =3D umc_v6_7_query_ras_error_count,
 	.query_ras_error_address =3D umc_v6_7_query_ras_error_address,
+	.query_ras_poison_mode =3D umc_v6_7_query_ras_poison_mode,
 };
--
2.17.1
