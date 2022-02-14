Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 678DCC433F5
	for <amd-gfx@archiver.kernel.org>; Mon, 14 Feb 2022 08:40:15 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BBBA410E285;
	Mon, 14 Feb 2022 08:40:14 +0000 (UTC)
Received: from NAM02-SN1-obe.outbound.protection.outlook.com
 (mail-sn1anam02on2049.outbound.protection.outlook.com [40.107.96.49])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 96ADE10E1C6
 for <amd-gfx@lists.freedesktop.org>; Mon, 14 Feb 2022 08:40:13 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hS0ARs64x2UitQEMxT3AX7dBAAdHLcO1lRMQWH54ertK3jiwsL0FUOtvZx+qbfyu2lhGV51R+f2UhGsED3bgdXtJxmxFtzQeroSW7uYObS9uxXZ/ZkXnNnXSzpePnxZBRjqrtXI80vsmjPJ1l1P8oliewuwVXr5U2mmophMBdr6p8Fweq/bjxHXuREZ9lWkcsQHtSy0O1f7obszqYBljL/JsL/do6SGZfeNF8YSAjDOwj8uaStYw1RBWLQ9IUliY1+MeFk62ueGTdpk0+toGZqaNZntaohYulXzV+fgbH7KSulR/XNyjJxm9EXfr0q+kDRb7qFi5/hMIQrCjYdh6zg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VFgo8Wyjk8jLquRlTxPo1DowC5+dYMlNwPuFJwrZ0kc=;
 b=mmbJJpgGgIIsPgogQays/8TwPHxKFAT2dDgSz75NrdRKCl1GOQQ/1baqwBLzO6MEsp8uB4yjdhW5jvD0mQP/bjaOsq8m6p09zEfA9q6umdWfaBP8Vj9oKlD7JGq/5xg5VxqOiBTj6rWKhF/rMc3Kg5keb6gLAHLe6QAatpSsgair2rrKHClzjTIypyl0T3Aetkjuy8xjM1LOB56IXz45M51YKVxWhjYHECrs4qBO+7y/GfUoKVNVKstLlH3xhgrI9+4m28qAgWesJ+DXm19kLthaUucZnBmDfHDu2qWE4POPSecL4NbNjd7pzpFrab5DA8bzuPZMyeQrtlwypihKVA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VFgo8Wyjk8jLquRlTxPo1DowC5+dYMlNwPuFJwrZ0kc=;
 b=rbU5waM/V2V4U6/lvuUTFp6QNcRqS5LPgJhPAFSnyJAM9E/5DrC45Bh06rf4jjxH/VfNkNnoBMyzWa6brTmqbJq1TYHxnWAZ6rP8Xw8UJCC8tDi+25sdssurhRBtwmOz5Mi2s5M9L5W7FtTjO6lg5GZL2sbzN0jAkSEdix5SKv4=
Received: from BN9PR12MB5257.namprd12.prod.outlook.com (2603:10b6:408:11e::16)
 by DM5PR1201MB2554.namprd12.prod.outlook.com (2603:10b6:3:ec::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4975.15; Mon, 14 Feb
 2022 08:40:10 +0000
Received: from BN9PR12MB5257.namprd12.prod.outlook.com
 ([fe80::bc82:1b0d:96db:25aa]) by BN9PR12MB5257.namprd12.prod.outlook.com
 ([fe80::bc82:1b0d:96db:25aa%6]) with mapi id 15.20.4975.018; Mon, 14 Feb 2022
 08:40:10 +0000
From: "Zhang, Hawking" <Hawking.Zhang@amd.com>
To: "Yang, Stanley" <Stanley.Yang@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>, "Zhou1, Tao" <Tao.Zhou1@amd.com>
Subject: RE: [PATCH Review 1/1] drm/amdgpu: print more error info
Thread-Topic: [PATCH Review 1/1] drm/amdgpu: print more error info
Thread-Index: AQHYIXrlBvRkkt2T4E6A8hp9MoSCVaySuRPQ
Date: Mon, 14 Feb 2022 08:40:10 +0000
Message-ID: <BN9PR12MB5257376434DA7D0749CB9A4BFC339@BN9PR12MB5257.namprd12.prod.outlook.com>
References: <20220214081425.22205-1-Stanley.Yang@amd.com>
In-Reply-To: <20220214081425.22205-1-Stanley.Yang@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Enabled=true;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SetDate=2022-02-14T08:40:06Z; 
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Method=Standard;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Name=AMD Official Use
 Only-AIP 2.0;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ActionId=54675393-0117-4078-9c31-d041c4464681;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ContentBits=1
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: e7b765e9-488d-40c1-f6cf-08d9ef959c89
x-ms-traffictypediagnostic: DM5PR1201MB2554:EE_
x-microsoft-antispam-prvs: <DM5PR1201MB255419F5D7E04B2DE79E034BFC339@DM5PR1201MB2554.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2089;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Qrt4l9lwGXJU0GgB6eqPjr01Akil6sQbZsc9wSEKbsvC2dGwjrQUgDO0NrrIBNxrvouNOw3YLxqRFylSxMvbtOMVj427ewl0u+UApXVdRb/bS7AKghWq9odMt81DAio0hR9wT1Lx5arbUq+Y2LnFRJqdoRwy9CMgb2gze+nTIi++e8zTuOLN9cgFr7B9UWNJlr9iS6BVY3GUcYyalRpuM1MHOQpvm+MgtQzYcYqZRcwBPftV73+1JAXVoePY1i1EUF2prKrEE4CVo2KlTCLi+FYLcnYJi+NQdp8jWRjJiRDkvHufSdrKl9wv3Xvp3AnmDTE1vqYDQAN/fbuHSFqfqQGQ4fmNjeVMG6IUvJpUIUqtAAQTLtmwV7cblqW/7e1EH38GcJXG34tqw/pJz7XrNYRAIpkPiY1eeSWUoaQ9nAxCsmAjkCcYrBvzrXWfWUdzlWBdHfx3f9rjDwxqAJokOxGtGSWn2WxOJZJZNIeWVd6sIuM4x2ZIkuBXL+4+CIixh3fK2M3U1azbcPzZMdCCQAoXe113AyTuomlEEtKbrtDNBNWv0ugU38rjt4kyQDBMmyybjWxAlqEPdDaKKs69n0h4lj4hEPNwu9x7O+s8nuDWtA43vXso3NpqiGbm450NW4PfJK66DPO+QXUy9DoqTe5D05vNjFy8EJRsT0aCgDbL+ZoU13TYkzK8D8632PI8ifKLkOEdSxVsuROiF6845Q==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5257.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(4636009)(366004)(83380400001)(86362001)(508600001)(2906002)(33656002)(55016003)(7696005)(52536014)(9686003)(8676002)(122000001)(53546011)(6506007)(66946007)(26005)(5660300002)(316002)(66446008)(66476007)(186003)(38100700002)(71200400001)(110136005)(4326008)(38070700005)(8936002)(6636002)(76116006)(66556008)(64756008);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?1XmaCGduVWNTvbzSHiiqlIC1JOKOlhlS9nI8xHVb/7GHxfOoGbGgl1yX/DVo?=
 =?us-ascii?Q?ahYCi3wLzPuzK6m78tBb7y9KW//9irjgD2LwtZY58TOgZfAywPoEOfm+MTw7?=
 =?us-ascii?Q?s/TEy9zkmbRv7Xg3K+1DpSXO8us7obaB1FnQN/y1oNvWC2APeiJq48z9Xxbb?=
 =?us-ascii?Q?4E7yxodnEC46QG4FHZzZ2I6jf6qfcmRIoDUlizZxJTpgDIWsI0UB997tQ/ZK?=
 =?us-ascii?Q?jkpdqnZ/jivktjiWkhv/D2N/70pYFMb/puEnMoE/vbZrd1eBEC8mU9kmLxXC?=
 =?us-ascii?Q?lM4FHenticwpltfUSTg3PEDSnJ2fggRq4wuhN+RkXSCq+iHJyU5wlByeiw3i?=
 =?us-ascii?Q?hCfQhlObeRuL/T4SngalIeZiLIpOrWcMm7SWGe6jCkc20Cl70RAWwJhbLOBj?=
 =?us-ascii?Q?3Cwg02Yp5Lv3gVChu2TnNvC9RAyeHJbVXQslZu8/Y0aiYiW1aTcjIvyW/5B2?=
 =?us-ascii?Q?bqa3YiO97Y2H8jyo5YM7oEiM+vzFzLevlKZWJCPdTfeHIMdFQQgWYinO9DHg?=
 =?us-ascii?Q?1aQ2mRn/jtU80oMl2appR8BIuRxOZuk5jWKoxk13yMkwrqytfy7jagASE93q?=
 =?us-ascii?Q?oY/R50f1PWcHQm243o5OgCBqh2SxCvoxclAGrXfD8RQDchaRSDxLbCmo9Ed9?=
 =?us-ascii?Q?iINrFSJRmNYP+t2AlrQfhuboFwe6itX1PIxuLeXeflpocLAqte1j3/vCbIi0?=
 =?us-ascii?Q?A1DX2IbBkxXtq9DVmruBlPLXo+aklLwNpkEK+daF+lYsM0pycznuQHNMugag?=
 =?us-ascii?Q?BGIeEztdX0dOSgTtNbrVXeuWIrMLCTPT2+IN+0coeY4C43Sjg9x37i1tz/7o?=
 =?us-ascii?Q?K8KrhLXlTDSSg5FAc2balm0vsJG6R1AY5a0Cmjk8cn88OYbgY/hzS5Od8zq2?=
 =?us-ascii?Q?ZQxJcEvYscfN2CUYrKh1VjwsOCgcBG7mmSCxjjw8GFRpoJPAHJ0K7jEuwqxc?=
 =?us-ascii?Q?9E7zskAhe9eKCNv36KohEetIqzH9JNsW7yd9eSltk9jHMnFMGOh3G7citmnV?=
 =?us-ascii?Q?t7t700ZiVndrnXzq/9IHl6fFcYmno/Zr19bXXNm6VyFlWfHIYwFlU0StW//j?=
 =?us-ascii?Q?HqoE5iK0Ld8GwuGXW5Xq4LQ2X5ju01wmfcAYiJZ19e5QCJl7l1fLowVHYzif?=
 =?us-ascii?Q?XgnWcDmL7V0C+I3ea9RswcSCvLL4O8t53nqqHAWfKwBY7C0DYLNpp/BF8Gvv?=
 =?us-ascii?Q?Gy3SKvpEnS+feOSZA0DS6UuLNLzlZwdbEzC7ltkcV6qBdMRXrD4c89Xu2V3N?=
 =?us-ascii?Q?787aAn5ji44GJBTQRth729daRmdnaY6yQV4Hv6z5gnuYEp/+NhYn6nK9WQna?=
 =?us-ascii?Q?M795k2X1T2l5BNMHVCi2U/Bz/jiaJxO0iG3xxLADHPyCTeDErqy0NWwCs3dc?=
 =?us-ascii?Q?G+ZJGQpmPwhv/G5iD0hcaScGKPR5P1CbQpLbgCrpghgSdP01i2Ko3zRJKvX6?=
 =?us-ascii?Q?jKGdRTGDMCv+JfFuTNOOYsleb9T1LFQuAyYefUcH93YRTPi9lfbROA1j5ZxR?=
 =?us-ascii?Q?XpwyqtujC2/liN9Npl1n3/Q6tR5bCJf1dKc4yuysE04aH+BbUFgpwpTJoBsC?=
 =?us-ascii?Q?WZKpHeEYu4ZajwNa1dyyAt/o6NWR+UxsfbInCH/y+6zjDj9vB4+k06C9Af8b?=
 =?us-ascii?Q?NETzX4KsanjjddabWreE43Y=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5257.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e7b765e9-488d-40c1-f6cf-08d9ef959c89
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Feb 2022 08:40:10.3682 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: yoM1NejaKBb96/+9n6pvIdAXfrTGjGMsaHCb5j+Gu3rlZQiGk8PY9XVS8nwYppKlV1GR/Dvu4Nh0nsyvjBcHnw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR1201MB2554
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
Cc: "Yang, Stanley" <Stanley.Yang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Official Use Only]

There might be some miscommunication. Anyway, let's keep the message to inf=
orm poison creation event
-				dev_info(obj->adev->dev,
-						"Poison is created, no user action is needed.\n");
While remove " poison is created " from MCA_STATUS query function.=20

With above fixed, the patch is

Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>

Regards,
Hawking
-----Original Message-----
From: Stanley.Yang <Stanley.Yang@amd.com>=20
Sent: Monday, February 14, 2022 16:14
To: amd-gfx@lists.freedesktop.org; Zhang, Hawking <Hawking.Zhang@amd.com>; =
Zhou1, Tao <Tao.Zhou1@amd.com>
Cc: Yang, Stanley <Stanley.Yang@amd.com>
Subject: [PATCH Review 1/1] drm/amdgpu: print more error info

print more error info when deferred uncorrectable ras error

changed from V1:
    move Defferred error msg into query uncorrectable error
    count function.

Signed-off-by: Stanley.Yang <Stanley.Yang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c       |  7 +-
 drivers/gpu/drm/amd/amdgpu/umc_v6_7.c         | 72 ++++++++++++++++++-
 .../include/asic_reg/umc/umc_6_7_0_offset.h   |  6 ++
 3 files changed, 78 insertions(+), 7 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c b/drivers/gpu/drm/amd/=
amdgpu/amdgpu_ras.c
index 5d3968b5f92c..8016a638c847 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
@@ -1529,11 +1529,8 @@ static void amdgpu_ras_interrupt_handler(struct ras_=
manager *obj)
 				data->rptr) % data->ring_size;
=20
 		if (data->cb) {
-			if (amdgpu_ras_is_poison_mode_supported(obj->adev) &&
-			    obj->head.block =3D=3D AMDGPU_RAS_BLOCK__UMC)
-				dev_info(obj->adev->dev,
-						"Poison is created, no user action is needed.\n");
-			else {
+			if (!(amdgpu_ras_is_poison_mode_supported(obj->adev) &&
+					obj->head.block =3D=3D AMDGPU_RAS_BLOCK__UMC)) {
 				/* Let IP handle its data, maybe we need get the output
 				 * from the callback to udpate the error type/count, etc
 				 */
diff --git a/drivers/gpu/drm/amd/amdgpu/umc_v6_7.c b/drivers/gpu/drm/amd/am=
dgpu/umc_v6_7.c
index 87e4ef18e151..2a91452c5ac8 100644
--- a/drivers/gpu/drm/amd/amdgpu/umc_v6_7.c
+++ b/drivers/gpu/drm/amd/amdgpu/umc_v6_7.c
@@ -87,8 +87,14 @@ static void umc_v6_7_ecc_info_querry_uncorrectable_error=
_count(struct amdgpu_dev  {
 	uint64_t mc_umc_status;
 	uint32_t eccinfo_table_idx;
+	uint32_t umc_reg_offset;
+	uint32_t mc_umc_addr;
+	uint64_t reg_value;
 	struct amdgpu_ras *ras =3D amdgpu_ras_get_context(adev);
=20
+	umc_reg_offset =3D get_umc_v6_7_reg_offset(adev,
+						umc_inst, ch_inst);
+
 	eccinfo_table_idx =3D umc_inst * adev->umc.channel_inst_num + ch_inst;
 	/* check the MCUMC_STATUS */
 	mc_umc_status =3D ras->umc_ecc.ecc[eccinfo_table_idx].mca_umc_status;
@@ -97,8 +103,36 @@ static void umc_v6_7_ecc_info_querry_uncorrectable_erro=
r_count(struct amdgpu_dev
 	    REG_GET_FIELD(mc_umc_status, MCA_UMC_UMC0_MCUMC_STATUST0, UECC) =3D=
=3D 1 ||
 	    REG_GET_FIELD(mc_umc_status, MCA_UMC_UMC0_MCUMC_STATUST0, PCC) =3D=3D=
 1 ||
 	    REG_GET_FIELD(mc_umc_status, MCA_UMC_UMC0_MCUMC_STATUST0, UC) =3D=3D =
1 ||
-	    REG_GET_FIELD(mc_umc_status, MCA_UMC_UMC0_MCUMC_STATUST0, TCC) =3D=3D=
 1))
+	    REG_GET_FIELD(mc_umc_status, MCA_UMC_UMC0_MCUMC_STATUST0, TCC) =3D=3D=
=20
+1)) {
 		*error_count +=3D 1;
+
+		if (REG_GET_FIELD(mc_umc_status, MCA_UMC_UMC0_MCUMC_STATUST0, Deferred) =
=3D=3D 1)
+			dev_info(adev->dev, "Deferred error, poison is created, no user=20
+action is needed.\n");
+
+		if (mc_umc_status)
+			dev_info(adev->dev, "MCA STATUS 0x%llx, umc_reg_offset 0x%x\n",=20
+mc_umc_status, umc_reg_offset);
+
+		/* print IPID registers value */
+		mc_umc_addr =3D
+			SOC15_REG_OFFSET(UMC, 0, regMCA_UMC_UMC0_MCUMC_IPIDT0);
+		reg_value =3D RREG64_PCIE((mc_umc_addr + umc_reg_offset) * 4);
+		if (reg_value)
+			dev_info(adev->dev, "MCA IPID 0x%llx, umc_reg_offset 0x%x\n",=20
+reg_value, umc_reg_offset);
+
+		/* print SYND registers value */
+		mc_umc_addr =3D
+			SOC15_REG_OFFSET(UMC, 0, regMCA_UMC_UMC0_MCUMC_SYNDT0);
+		reg_value =3D RREG64_PCIE((mc_umc_addr + umc_reg_offset) * 4);
+		if (reg_value)
+			dev_info(adev->dev, "MCA SYND 0x%llx, umc_reg_offset 0x%x\n",=20
+reg_value, umc_reg_offset);
+
+		/* print MISC0 registers value */
+		mc_umc_addr =3D
+			SOC15_REG_OFFSET(UMC, 0, regMCA_UMC_UMC0_MCUMC_MISC0T0);
+		reg_value =3D RREG64_PCIE((mc_umc_addr + umc_reg_offset) * 4);
+		if (reg_value)
+			dev_info(adev->dev, "MCA MISC0 0x%llx, umc_reg_offset 0x%x\n", reg_valu=
e, umc_reg_offset);
+	}
 }
=20
 static void umc_v6_7_ecc_info_query_ras_error_count(struct amdgpu_device *=
adev, @@ -168,11 +202,13 @@ static void umc_v6_7_ecc_info_query_error_addre=
ss(struct amdgpu_device *adev,
 			/* loop for all possibilities of [C4 C3 C2] */
 			for (column =3D 0; column < UMC_V6_7_NA_MAP_PA_NUM; column++) {
 				retired_page =3D soc_pa | (column << UMC_V6_7_PA_C2_BIT);
+				dev_info(adev->dev, "Error Address(PA): 0x%llx\n", retired_page);
 				amdgpu_umc_fill_error_record(err_data, err_addr,
 					retired_page, channel_index, umc_inst);
=20
 				/* shift R14 bit */
 				retired_page ^=3D (0x1ULL << UMC_V6_7_PA_R14_BIT);
+				dev_info(adev->dev, "Error Address(PA): 0x%llx\n", retired_page);
 				amdgpu_umc_fill_error_record(err_data, err_addr,
 					retired_page, channel_index, umc_inst);
 			}
@@ -251,6 +287,8 @@ static void umc_v6_7_querry_uncorrectable_error_count(s=
truct amdgpu_device *adev  {
 	uint64_t mc_umc_status;
 	uint32_t mc_umc_status_addr;
+	uint32_t mc_umc_addr;
+	uint64_t reg_value;
=20
 	mc_umc_status_addr =3D
 		SOC15_REG_OFFSET(UMC, 0, regMCA_UMC_UMC0_MCUMC_STATUST0); @@ -262,8 +300=
,36 @@ static void umc_v6_7_querry_uncorrectable_error_count(struct amdgpu_=
device *adev
 	    REG_GET_FIELD(mc_umc_status, MCA_UMC_UMC0_MCUMC_STATUST0, UECC) =3D=
=3D 1 ||
 	    REG_GET_FIELD(mc_umc_status, MCA_UMC_UMC0_MCUMC_STATUST0, PCC) =3D=3D=
 1 ||
 	    REG_GET_FIELD(mc_umc_status, MCA_UMC_UMC0_MCUMC_STATUST0, UC) =3D=3D =
1 ||
-	    REG_GET_FIELD(mc_umc_status, MCA_UMC_UMC0_MCUMC_STATUST0, TCC) =3D=3D=
 1))
+	    REG_GET_FIELD(mc_umc_status, MCA_UMC_UMC0_MCUMC_STATUST0, TCC) =3D=3D=
=20
+1)) {
 		*error_count +=3D 1;
+
+		if (REG_GET_FIELD(mc_umc_status, MCA_UMC_UMC0_MCUMC_STATUST0, Deferred) =
=3D=3D 1)
+			dev_info(adev->dev, "Deferred error, poison is created, no user=20
+action is needed.\n");
+
+		if (mc_umc_status)
+			dev_info(adev->dev, "MCA STATUS 0x%llx, umc_reg_offset 0x%x\n",=20
+mc_umc_status, umc_reg_offset);
+
+		/* print IPID registers value */
+		mc_umc_addr =3D
+			SOC15_REG_OFFSET(UMC, 0, regMCA_UMC_UMC0_MCUMC_IPIDT0);
+		reg_value =3D RREG64_PCIE((mc_umc_addr + umc_reg_offset) * 4);
+		if (reg_value)
+			dev_info(adev->dev, "MCA IPID 0x%llx, umc_reg_offset 0x%x\n",=20
+reg_value, umc_reg_offset);
+
+		/* print SYND registers value */
+		mc_umc_addr =3D
+			SOC15_REG_OFFSET(UMC, 0, regMCA_UMC_UMC0_MCUMC_SYNDT0);
+		reg_value =3D RREG64_PCIE((mc_umc_addr + umc_reg_offset) * 4);
+		if (reg_value)
+			dev_info(adev->dev, "MCA SYND 0x%llx, umc_reg_offset 0x%x\n",=20
+reg_value, umc_reg_offset);
+
+		/* print MISC0 registers value */
+		mc_umc_addr =3D
+			SOC15_REG_OFFSET(UMC, 0, regMCA_UMC_UMC0_MCUMC_MISC0T0);
+		reg_value =3D RREG64_PCIE((mc_umc_addr + umc_reg_offset) * 4);
+		if (reg_value)
+			dev_info(adev->dev, "MCA MISC0 0x%llx, umc_reg_offset 0x%x\n", reg_valu=
e, umc_reg_offset);
+	}
 }
=20
 static void umc_v6_7_reset_error_count_per_channel(struct amdgpu_device *a=
dev, @@ -403,11 +469,13 @@ static void umc_v6_7_query_error_address(struct =
amdgpu_device *adev,
 			/* loop for all possibilities of [C4 C3 C2] */
 			for (column =3D 0; column < UMC_V6_7_NA_MAP_PA_NUM; column++) {
 				retired_page =3D soc_pa | (column << UMC_V6_7_PA_C2_BIT);
+				dev_info(adev->dev, "Error Address(PA): 0x%llx\n", retired_page);
 				amdgpu_umc_fill_error_record(err_data, err_addr,
 					retired_page, channel_index, umc_inst);
=20
 				/* shift R14 bit */
 				retired_page ^=3D (0x1ULL << UMC_V6_7_PA_R14_BIT);
+				dev_info(adev->dev, "Error Address(PA): 0x%llx\n", retired_page);
 				amdgpu_umc_fill_error_record(err_data, err_addr,
 					retired_page, channel_index, umc_inst);
 			}
diff --git a/drivers/gpu/drm/amd/include/asic_reg/umc/umc_6_7_0_offset.h b/=
drivers/gpu/drm/amd/include/asic_reg/umc/umc_6_7_0_offset.h
index 912955f75b14..37d89a3f336a 100644
--- a/drivers/gpu/drm/amd/include/asic_reg/umc/umc_6_7_0_offset.h
+++ b/drivers/gpu/drm/amd/include/asic_reg/umc/umc_6_7_0_offset.h
@@ -31,6 +31,12 @@
 #define regMCA_UMC_UMC0_MCUMC_STATUST0_BASE_IDX                           =
                              0
 #define regMCA_UMC_UMC0_MCUMC_ADDRT0                                      =
                              0x03c4
 #define regMCA_UMC_UMC0_MCUMC_ADDRT0_BASE_IDX                             =
                              0
+#define regMCA_UMC_UMC0_MCUMC_MISC0T0                                     =
                              0x03c6
+#define regMCA_UMC_UMC0_MCUMC_MISC0T0_BASE_IDX                            =
                              0
+#define regMCA_UMC_UMC0_MCUMC_IPIDT0                                      =
                              0x03ca
+#define regMCA_UMC_UMC0_MCUMC_IPIDT0_BASE_IDX                             =
                              0
+#define regMCA_UMC_UMC0_MCUMC_SYNDT0                                      =
                              0x03cc
+#define regMCA_UMC_UMC0_MCUMC_SYNDT0_BASE_IDX                             =
                              0
=20
=20
 // addressBlock: umc_w_phy_umc0_umcch0_umcchdec
--
2.17.1
