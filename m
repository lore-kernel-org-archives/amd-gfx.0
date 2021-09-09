Return-Path: <SRS0=g6Hj=N7=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F544C433EF
	for <amd-gfx@archiver.kernel.org>; Thu,  9 Sep 2021 07:47:31 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D0B56610A3
	for <amd-gfx@archiver.kernel.org>; Thu,  9 Sep 2021 07:47:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org D0B56610A3
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3DAFC6E471;
	Thu,  9 Sep 2021 07:47:30 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2061.outbound.protection.outlook.com [40.107.223.61])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D1B5C6E471
 for <amd-gfx@lists.freedesktop.org>; Thu,  9 Sep 2021 07:47:28 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HQG80VS8vpPr8jnSsNv7M/cu6teBuKOp47yivh0C8H04a2B0YouiMn2X2WYekcDFcPyxIPosTrgrUUprm46C17FGfGPOiSzU4g/5EHPVSXJqUB4m1qd70mwgHn8Rec0bZNyigDeUFRcX8az4MtiM6vf7HTMJhBpCjxZE39FT11mKFFnOXEOazBksV0qrU6SHl2AH1BgIAZXsdeZ7LgNU8uHq52rCiiErns/QlzJHLGHy1QYdR8JpjH4usLV2fLLMn6bZpME1hFkirJH3mZgsmrYDQMRTEbc+82Ve1oSFCYrZ9AS/wk4bz7XkvXIcTc5iTDWGdEsI95/dR1nmd63SPg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version; 
 bh=WdJetv2ICutghNwyXRhHeO+TGtetYS9Wc8HOYX2Czxo=;
 b=mCLe1dGXMMcFBfWXd8luB8PqGFtbW5pg1qYE9g0Ckqshx3b4ZLXtcnGbBa4qyOZR2f99V7AqXiYr1xQDrf45DYHJ5g9A5IzZdHncQn/K1FWK/1WOu8Eb+GrOGsalkfsuu2leZp05Gxz/F4RyETBD4FYApTYYKiwGixS8gBARHTtxV72AZUTvY1qbrpmqNryQMYcGMGeQIQasC6zzcbx8pqUVv6NEerJAzjtyu8LXkEBz8/kXtDd/lLEGoK8BB2aP9zH1lXrvcfQaQE0Hvcmwu2155Av94xZJEHFLOrwPtDgmTGnbMdn77n+ZY1HiAq4v7iMJ7oGQzAVlaVjZrr6jXg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WdJetv2ICutghNwyXRhHeO+TGtetYS9Wc8HOYX2Czxo=;
 b=W7SwSxVZ9SRL5j+esyKVKMWkLsJNel3kRbqoewihY18edJcbQQX8YQEy+Vhs87pwkZ5u36ji4Xfmv5Quei+4ezm4S9WBlYaIRyNYHSMnoyD/hpuyyF/bwJ3hHn12FTJiPzlheIGEj0MIuEG2V4wM7hqMBX6rad6EuKg42csaYxE=
Received: from BN9PR12MB5257.namprd12.prod.outlook.com (2603:10b6:408:11e::16)
 by BN9PR12MB5194.namprd12.prod.outlook.com (2603:10b6:408:11b::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4500.14; Thu, 9 Sep
 2021 07:47:24 +0000
Received: from BN9PR12MB5257.namprd12.prod.outlook.com
 ([fe80::5101:db26:96eb:2ce4]) by BN9PR12MB5257.namprd12.prod.outlook.com
 ([fe80::5101:db26:96eb:2ce4%6]) with mapi id 15.20.4500.016; Thu, 9 Sep 2021
 07:47:24 +0000
From: "Zhang, Hawking" <Hawking.Zhang@amd.com>
To: "Gao, Likun" <Likun.Gao@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amdgpu: refactor function to init no-psp fw
Thread-Topic: [PATCH] drm/amdgpu: refactor function to init no-psp fw
Thread-Index: AQHXpUpzvHbyY4cw3kiNtJDGvgXPqKubUy4A
Date: Thu, 9 Sep 2021 07:47:24 +0000
Message-ID: <BN9PR12MB525793F53D33C74CE111E703FCD59@BN9PR12MB5257.namprd12.prod.outlook.com>
References: <20210909071502.3322586-1-likun.gao@amd.com>
In-Reply-To: <20210909071502.3322586-1-likun.gao@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Enabled=true;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SetDate=2021-09-09T07:47:22Z; 
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Method=Standard;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Name=AMD Official Use
 Only-AIP 2.0;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ActionId=8bc1c20d-4301-43c4-9616-c1f7ded1ed39;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ContentBits=1
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 6ca5c6d3-07ea-4531-5ad3-08d973661020
x-ms-traffictypediagnostic: BN9PR12MB5194:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BN9PR12MB5194B9B86FD811F739769C6EFCD59@BN9PR12MB5194.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2512;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: GdyJc+iy2k+Fke8d6YqhDUFm8Ygj/iaGon8svx0sDcp56kj6ZxKQsu3D6EeqgcITlVHVzT1mty4UCo+5XWJdcl26PB8eXI3fPQhr9clxiBKI8qPam6Cx3aM/loQh6O2FpA7+Xzf6yG6TZXLcsVSaQXoNbP0oeEp0LQLdm0SMCi0fVBU1KEgdiqhlIpe14+7EHYUxYZKMo4Tu4AHLpNXVAraVLyoulIqp9clk6dB7H43Rs7A+g02PWHDID7AnwLqRwqozOUGfu+BCEpLZTJipzAhrLua0o1fwt+3mO0s6pBl8FTTaquLDdHaW/RbZnqf/9ezbZt6ajbCgYTiWQcpDg4rTsY1QPc5NfXANW72JPERaWI0O2CnMaj0QmEisl773MlUseAlV6xB3e3IJDfwd5mYGHg62qvMfiIfC25zbRbLTdBNV7hzfRGwle5dTvU4ptgXn6qKnqHvjJKi+Z9gHXQZxRMkXMh44w4reAU3NfteazjSrbph+j8D3+b7au9uswVvjO9Th43KZuNky1L9vUYfnH3cj1jvrR1N5FVjuiOvvmnY2/+UFHoA9vQKqo4NyoFB2iCHi6nbwFZ2tkQU+fGEvaJzb0GU8E7dX7pIg6pwnJyDsjYivOrf4/siEcXe3nFPvFyf7OT062/Vmjnlt7CCPwUdnvwC3M3VE95RaGJh3cwc8ug20Hss5346n09usOdC9A1zWrFiWSxMA6z1+nA==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5257.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(39860400002)(346002)(136003)(376002)(396003)(366004)(6506007)(53546011)(83380400001)(71200400001)(55016002)(66556008)(64756008)(66946007)(38070700005)(66446008)(66476007)(7696005)(76116006)(33656002)(186003)(478600001)(52536014)(2906002)(38100700002)(8936002)(9686003)(122000001)(110136005)(316002)(8676002)(5660300002)(26005)(86362001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?0Eze1x7nov1CxDh9H2nDw/eT4aGCBC7ZGelwX27QxFIk4XnKkrqNHSBFZh+d?=
 =?us-ascii?Q?Tlm+QhMwe6uncLdJPKooDFZfkKhS7v1Rr9Sz1vS+sh9udzpFqo64VrU3DlLb?=
 =?us-ascii?Q?3dYsv1P1n3fb0pE1O0MCCad5nr3nguIHfGeOAhzhl7cUIUNn2bYASTTCo8pc?=
 =?us-ascii?Q?6Qo9rTOk5O87jcUspWplsvsE+c7BMGMndLH+L8ZLJ1vki9CPyDVS+O75cS33?=
 =?us-ascii?Q?AzKtvY2YWGNv3EF66zOyaIPmTa9hX0VnNU1tXgzieuTUtNNbLhY634doGsgl?=
 =?us-ascii?Q?DnKZKmtry2asEiYNRc7P3Gz9+iCNObDNrSxT2kmHmec1+fvEDbSoIBpu7qlh?=
 =?us-ascii?Q?Iy1Ct2wm17f8BD3fg+LWrcObfpa76F7u6WEz/Ag31Xw6riXixFYUXzml74S8?=
 =?us-ascii?Q?Zo6eeqoc1sM9Je7cjqLItemnSXJ5/lEoOg2v1w3zA49zpGIaPaO7sTysUkE1?=
 =?us-ascii?Q?7JpcV01QhmshJukxRMgVueHqzARKdEpitGQphpSHrChwBjcYiG17soBJtvte?=
 =?us-ascii?Q?jA9j/qM95uZms7D6V9Tn4Z8eVw//2rUqaL9pIX6FPWU2D2BpaU/l4dCwu9E5?=
 =?us-ascii?Q?yvQ3a7lrDGkH7UQCeDkGADLxJVjAmfavvMGrb/YBylc90n3HthbR9UhrnpuV?=
 =?us-ascii?Q?4hjGh0bxd6CsySdEY11U1Dz09x2CkbY7LQ+7DXhd490rFzqulbZu0Xb7Y5no?=
 =?us-ascii?Q?UeMWGL72+V0hKR95iD0LRFE1T20omILzoJFhFFlB+jUy3GgN/8gvw3Us1asb?=
 =?us-ascii?Q?jgt8qj7t22xNVcMorhAqlmAksXXVDCOwUwpg+4PdP1kfxyqnlQ+KOrArR/mE?=
 =?us-ascii?Q?Yao/1DWCYxNKHWqoX9jAhIroMEB6kddhFgx9diF5K8s/cK7siP2KvbC16cPm?=
 =?us-ascii?Q?dDROG8hQdjA2T6TLO3xZdTcCZmecGm9uS11LKfNtaERIJeHzhIszU9hazuKf?=
 =?us-ascii?Q?IpM0r0a/n2F0uHum1ss3VYySbksC3epNg5AZcE4xtO61z+wSNjyCVsMRrvgn?=
 =?us-ascii?Q?iFprJML0Xy5VxaRvsykkT+8xUdJrorowmc6rRL1JUCDlXYCnvSSQ3quXJyEy?=
 =?us-ascii?Q?xyyx9HNhttwf+tSfZU5sDzP1Wt8rjQM2NnMpyKz5h217gCbSpkPDj4KUAf7o?=
 =?us-ascii?Q?p2TMgtKpkuqDEDeBvpMfvB22nNcrULIDoDk/k4tXuCbamN8lc764SHFPqQum?=
 =?us-ascii?Q?YVnmSYkQNL2Ui+xrQnnFCZRtBynMk5Bpx30tfkilyrEkiCXh13lRkGmxNwgx?=
 =?us-ascii?Q?/BgwfGoeVFwwuW8FPP7FCbwCqw9PBB9K2PmqVfF9I6VWEuRwT9LC4GT8nUJk?=
 =?us-ascii?Q?7SHgHehMwZaC2pjD4LqBKyWI?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5257.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6ca5c6d3-07ea-4531-5ad3-08d973661020
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Sep 2021 07:47:24.2198 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: JYa33hAhm+R2kdS8HZfmeUrHQBix1Pr3nD0lksp3gMzj68ukmR1ZYbgGdp/YOMIV8Cg7NSzDn709J1H41qoUZA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR12MB5194
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
From: Gao, Likun <Likun.Gao@amd.com>=20
Sent: Thursday, September 9, 2021 15:15
To: amd-gfx@lists.freedesktop.org
Cc: Zhang, Hawking <Hawking.Zhang@amd.com>; Gao, Likun <Likun.Gao@amd.com>
Subject: [PATCH] drm/amdgpu: refactor function to init no-psp fw

From: Likun Gao <Likun.Gao@amd.com>

Refactor the code of amdgpu_ucode_init_single_fw to make it more readable a=
s too many ucode need to handle on this function currently.

Signed-off-by: Likun Gao <Likun.Gao@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ucode.c | 160 ++++++++++------------
 1 file changed, 75 insertions(+), 85 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ucode.c b/drivers/gpu/drm/am=
d/amdgpu/amdgpu_ucode.c
index abd8469380e5..5f396936c6ad 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ucode.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ucode.c
@@ -572,6 +572,7 @@ static int amdgpu_ucode_init_single_fw(struct amdgpu_de=
vice *adev,
 	const struct dmcu_firmware_header_v1_0 *dmcu_hdr =3D NULL;
 	const struct dmcub_firmware_header_v1_0 *dmcub_hdr =3D NULL;
 	const struct mes_firmware_header_v1_0 *mes_hdr =3D NULL;
+	u8 *ucode_addr;
=20
 	if (NULL =3D=3D ucode->fw)
 		return 0;
@@ -588,94 +589,83 @@ static int amdgpu_ucode_init_single_fw(struct amdgpu_=
device *adev,
 	dmcub_hdr =3D (const struct dmcub_firmware_header_v1_0 *)ucode->fw->data;
 	mes_hdr =3D (const struct mes_firmware_header_v1_0 *)ucode->fw->data;
=20
-	if (adev->firmware.load_type !=3D AMDGPU_FW_LOAD_PSP ||
-	    (ucode->ucode_id !=3D AMDGPU_UCODE_ID_CP_MEC1 &&
-	     ucode->ucode_id !=3D AMDGPU_UCODE_ID_CP_MEC2 &&
-	     ucode->ucode_id !=3D AMDGPU_UCODE_ID_CP_MEC1_JT &&
-	     ucode->ucode_id !=3D AMDGPU_UCODE_ID_CP_MEC2_JT &&
-	     ucode->ucode_id !=3D AMDGPU_UCODE_ID_CP_MES &&
-	     ucode->ucode_id !=3D AMDGPU_UCODE_ID_CP_MES_DATA &&
-	     ucode->ucode_id !=3D AMDGPU_UCODE_ID_RLC_RESTORE_LIST_CNTL &&
-	     ucode->ucode_id !=3D AMDGPU_UCODE_ID_RLC_RESTORE_LIST_GPM_MEM &&
-	     ucode->ucode_id !=3D AMDGPU_UCODE_ID_RLC_RESTORE_LIST_SRM_MEM &&
-	     ucode->ucode_id !=3D AMDGPU_UCODE_ID_RLC_IRAM &&
-	     ucode->ucode_id !=3D AMDGPU_UCODE_ID_RLC_DRAM &&
-		 ucode->ucode_id !=3D AMDGPU_UCODE_ID_DMCU_ERAM &&
-		 ucode->ucode_id !=3D AMDGPU_UCODE_ID_DMCU_INTV &&
-		 ucode->ucode_id !=3D AMDGPU_UCODE_ID_DMCUB)) {
-		ucode->ucode_size =3D le32_to_cpu(header->ucode_size_bytes);
-
-		memcpy(ucode->kaddr, (void *)((uint8_t *)ucode->fw->data +
-					      le32_to_cpu(header->ucode_array_offset_bytes)),
-		       ucode->ucode_size);
-	} else if (ucode->ucode_id =3D=3D AMDGPU_UCODE_ID_CP_MEC1 ||
-		   ucode->ucode_id =3D=3D AMDGPU_UCODE_ID_CP_MEC2) {
-		ucode->ucode_size =3D le32_to_cpu(header->ucode_size_bytes) -
-			le32_to_cpu(cp_hdr->jt_size) * 4;
-
-		memcpy(ucode->kaddr, (void *)((uint8_t *)ucode->fw->data +
-					      le32_to_cpu(header->ucode_array_offset_bytes)),
-		       ucode->ucode_size);
-	} else if (ucode->ucode_id =3D=3D AMDGPU_UCODE_ID_CP_MEC1_JT ||
-		   ucode->ucode_id =3D=3D AMDGPU_UCODE_ID_CP_MEC2_JT) {
-		ucode->ucode_size =3D le32_to_cpu(cp_hdr->jt_size) * 4;
-
-		memcpy(ucode->kaddr, (void *)((uint8_t *)ucode->fw->data +
-					      le32_to_cpu(header->ucode_array_offset_bytes) +
-					      le32_to_cpu(cp_hdr->jt_offset) * 4),
-		       ucode->ucode_size);
-	} else if (ucode->ucode_id =3D=3D AMDGPU_UCODE_ID_DMCU_ERAM) {
-		ucode->ucode_size =3D le32_to_cpu(header->ucode_size_bytes) -
+	if (adev->firmware.load_type =3D=3D AMDGPU_FW_LOAD_PSP) {
+		switch (ucode->ucode_id) {
+		case AMDGPU_UCODE_ID_CP_MEC1:
+		case AMDGPU_UCODE_ID_CP_MEC2:
+			ucode->ucode_size =3D le32_to_cpu(header->ucode_size_bytes) -
+				le32_to_cpu(cp_hdr->jt_size) * 4;
+			ucode_addr =3D (u8 *)ucode->fw->data +
+				le32_to_cpu(header->ucode_array_offset_bytes);
+			break;
+		case AMDGPU_UCODE_ID_CP_MEC1_JT:
+		case AMDGPU_UCODE_ID_CP_MEC2_JT:
+			ucode->ucode_size =3D le32_to_cpu(cp_hdr->jt_size) * 4;
+			ucode_addr =3D (u8 *)ucode->fw->data +
+				le32_to_cpu(header->ucode_array_offset_bytes) +
+				le32_to_cpu(cp_hdr->jt_offset) * 4;
+			break;
+		case AMDGPU_UCODE_ID_RLC_RESTORE_LIST_CNTL:
+			ucode->ucode_size =3D adev->gfx.rlc.save_restore_list_cntl_size_bytes;
+			ucode_addr =3D adev->gfx.rlc.save_restore_list_cntl;
+			break;
+		case AMDGPU_UCODE_ID_RLC_RESTORE_LIST_GPM_MEM:
+			ucode->ucode_size =3D adev->gfx.rlc.save_restore_list_gpm_size_bytes;
+			ucode_addr =3D adev->gfx.rlc.save_restore_list_gpm;
+			break;
+		case AMDGPU_UCODE_ID_RLC_RESTORE_LIST_SRM_MEM:
+			ucode->ucode_size =3D adev->gfx.rlc.save_restore_list_srm_size_bytes;
+			ucode_addr =3D adev->gfx.rlc.save_restore_list_srm;
+			break;
+		case AMDGPU_UCODE_ID_RLC_IRAM:
+			ucode->ucode_size =3D adev->gfx.rlc.rlc_iram_ucode_size_bytes;
+			ucode_addr =3D adev->gfx.rlc.rlc_iram_ucode;
+			break;
+		case AMDGPU_UCODE_ID_RLC_DRAM:
+			ucode->ucode_size =3D adev->gfx.rlc.rlc_dram_ucode_size_bytes;
+			ucode_addr =3D adev->gfx.rlc.rlc_dram_ucode;
+			break;
+		case AMDGPU_UCODE_ID_CP_MES:
+			ucode->ucode_size =3D le32_to_cpu(mes_hdr->mes_ucode_size_bytes);
+			ucode_addr =3D (u8 *)ucode->fw->data +
+				le32_to_cpu(mes_hdr->mes_ucode_offset_bytes);
+			break;
+		case AMDGPU_UCODE_ID_CP_MES_DATA:
+			ucode->ucode_size =3D le32_to_cpu(mes_hdr->mes_ucode_data_size_bytes);
+			ucode_addr =3D (u8 *)ucode->fw->data +
+				le32_to_cpu(mes_hdr->mes_ucode_data_offset_bytes);
+			break;
+		case AMDGPU_UCODE_ID_DMCU_ERAM:
+			ucode->ucode_size =3D le32_to_cpu(header->ucode_size_bytes) -
 				le32_to_cpu(dmcu_hdr->intv_size_bytes);
-
-		memcpy(ucode->kaddr, (void *)((uint8_t *)ucode->fw->data +
-					      le32_to_cpu(header->ucode_array_offset_bytes)),
-		       ucode->ucode_size);
-	} else if (ucode->ucode_id =3D=3D AMDGPU_UCODE_ID_DMCU_INTV) {
-		ucode->ucode_size =3D le32_to_cpu(dmcu_hdr->intv_size_bytes);
-
-		memcpy(ucode->kaddr, (void *)((uint8_t *)ucode->fw->data +
-					      le32_to_cpu(header->ucode_array_offset_bytes) +
-					      le32_to_cpu(dmcu_hdr->intv_offset_bytes)),
-		       ucode->ucode_size);
-	} else if (ucode->ucode_id =3D=3D AMDGPU_UCODE_ID_DMCUB) {
-		ucode->ucode_size =3D le32_to_cpu(dmcub_hdr->inst_const_bytes);
-		memcpy(ucode->kaddr,
-		       (void *)((uint8_t *)ucode->fw->data +
-				le32_to_cpu(header->ucode_array_offset_bytes)),
-		       ucode->ucode_size);
-	} else if (ucode->ucode_id =3D=3D AMDGPU_UCODE_ID_RLC_RESTORE_LIST_CNTL) =
{
-		ucode->ucode_size =3D adev->gfx.rlc.save_restore_list_cntl_size_bytes;
-		memcpy(ucode->kaddr, adev->gfx.rlc.save_restore_list_cntl,
-		       ucode->ucode_size);
-	} else if (ucode->ucode_id =3D=3D AMDGPU_UCODE_ID_RLC_RESTORE_LIST_GPM_ME=
M) {
-		ucode->ucode_size =3D adev->gfx.rlc.save_restore_list_gpm_size_bytes;
-		memcpy(ucode->kaddr, adev->gfx.rlc.save_restore_list_gpm,
-		       ucode->ucode_size);
-	} else if (ucode->ucode_id =3D=3D AMDGPU_UCODE_ID_RLC_RESTORE_LIST_SRM_ME=
M) {
-		ucode->ucode_size =3D adev->gfx.rlc.save_restore_list_srm_size_bytes;
-		memcpy(ucode->kaddr, adev->gfx.rlc.save_restore_list_srm,
-		       ucode->ucode_size);
-	} else if (ucode->ucode_id =3D=3D AMDGPU_UCODE_ID_RLC_IRAM) {
-		ucode->ucode_size =3D adev->gfx.rlc.rlc_iram_ucode_size_bytes;
-		memcpy(ucode->kaddr, adev->gfx.rlc.rlc_iram_ucode,
-		       ucode->ucode_size);
-	} else if (ucode->ucode_id =3D=3D AMDGPU_UCODE_ID_RLC_DRAM) {
-		ucode->ucode_size =3D adev->gfx.rlc.rlc_dram_ucode_size_bytes;
-		memcpy(ucode->kaddr, adev->gfx.rlc.rlc_dram_ucode,
-		       ucode->ucode_size);
-	} else if (ucode->ucode_id =3D=3D AMDGPU_UCODE_ID_CP_MES) {
-		ucode->ucode_size =3D le32_to_cpu(mes_hdr->mes_ucode_size_bytes);
-		memcpy(ucode->kaddr, (void *)((uint8_t *)adev->mes.fw->data +
-			      le32_to_cpu(mes_hdr->mes_ucode_offset_bytes)),
-		       ucode->ucode_size);
-	} else if (ucode->ucode_id =3D=3D AMDGPU_UCODE_ID_CP_MES_DATA) {
-		ucode->ucode_size =3D le32_to_cpu(mes_hdr->mes_ucode_data_size_bytes);
-		memcpy(ucode->kaddr, (void *)((uint8_t *)adev->mes.fw->data +
-			      le32_to_cpu(mes_hdr->mes_ucode_data_offset_bytes)),
-		       ucode->ucode_size);
+			ucode_addr =3D (u8 *)ucode->fw->data +
+				le32_to_cpu(header->ucode_array_offset_bytes);
+			break;
+		case AMDGPU_UCODE_ID_DMCU_INTV:
+			ucode->ucode_size =3D le32_to_cpu(dmcu_hdr->intv_size_bytes);
+			ucode_addr =3D (u8 *)ucode->fw->data +
+				le32_to_cpu(header->ucode_array_offset_bytes) +
+				le32_to_cpu(dmcu_hdr->intv_offset_bytes);
+			break;
+		case AMDGPU_UCODE_ID_DMCUB:
+			ucode->ucode_size =3D le32_to_cpu(dmcub_hdr->inst_const_bytes);
+			ucode_addr =3D (u8 *)ucode->fw->data +
+				le32_to_cpu(header->ucode_array_offset_bytes);
+			break;
+		default:
+			ucode->ucode_size =3D le32_to_cpu(header->ucode_size_bytes);
+			ucode_addr =3D (u8 *)ucode->fw->data +
+				le32_to_cpu(header->ucode_array_offset_bytes);
+			break;
+		}
+	} else {
+		ucode->ucode_size =3D le32_to_cpu(header->ucode_size_bytes);
+		ucode_addr =3D (u8 *)ucode->fw->data +
+			le32_to_cpu(header->ucode_array_offset_bytes);
 	}
=20
+	memcpy(ucode->kaddr, ucode_addr, ucode->ucode_size);
+
 	return 0;
 }
=20
--
2.25.1
