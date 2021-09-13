Return-Path: <SRS0=miQW=OD=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29A08C433EF
	for <amd-gfx@archiver.kernel.org>; Mon, 13 Sep 2021 03:41:25 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DFA4C60F3A
	for <amd-gfx@archiver.kernel.org>; Mon, 13 Sep 2021 03:41:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org DFA4C60F3A
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 735136E0D7;
	Mon, 13 Sep 2021 03:41:24 +0000 (UTC)
Received: from NAM04-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam08on2075.outbound.protection.outlook.com [40.107.102.75])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B961B6E0D7
 for <amd-gfx@lists.freedesktop.org>; Mon, 13 Sep 2021 03:41:22 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IW5UdkNINNq774FuGKxjX+GYm3TO+5MqJm9rdjuSKf2aaS48G3JY3VwRrsZ9H3tTKzi059BAwWd7F7U0SYNaYaUzrPoEpDqM2Xu8I0M2VZv3S46T1WEXxpO2vXvIaQUW0gTuFXSsRhJKAsUP4IGs+iZT6DcqX33c1NI9ZBNw329rnmrEIQj7GCjZBfmhjZ/nVs64wArff0AoqLA2iK3WYdG8z7xBkIMlRwchUiSRzgVxwabtAIW79rUof2W8cWEovytcopTaBHuxsyXupsfwNg1exIMqOQp+xlm4jQev+34xxCAMfIL8KTWPrVDv8gBNcIgyRl83EG+UKCR2zeWI5g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version; 
 bh=mAHmOXVsnaMUBT7WY4b9TiReDmffV1pfef0JVNhplJI=;
 b=lDRrTqIO0BjOZp0MEdduB5fFL2s3geRwKtzmfzl4d6bIo/I9M/2mEe70XIWdfJDVNHEVqFvS16XAnc4DBcVBqLZ928hRcjdudNiZfwPW39SVpZHzkHsFQ6yUMbsSuGkqs8W9j7zUYfWyzhlbNI/7ETUiXAwH/4mWKWEOeEbZaYDMwVu12zZpMbbbY14D7W756Yo+ZjEYBvwJx7l4VDyW8mnE+frqKLBMcbENAzoCUwCA1pQtjF0ld4x+fHqtMYv7jz5d8yYRjc27yl4VYhrgqcXSc6Dg+BxBL5zaLVL+j6VuJK9XLt3Ut79k1+a+TCHdN2w8eeAoW0kFhe1PFb6CHQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mAHmOXVsnaMUBT7WY4b9TiReDmffV1pfef0JVNhplJI=;
 b=5r5bv7PGsm5OFs+q7KvjoXKxF9unDoMx8/enouF35CshmxRp6rjBz2QCyil3q6XQpVZm8FjFdN4aK8u5A4h4ZNg8UnpW6Q+wPwhJVgto83t8NpURtcx7BbWH+Rl7x4g8RLv9e8yPeL6PxFffU5DIGhEKbiUYniKrX8K5a0t+s5o=
Received: from BN9PR12MB5226.namprd12.prod.outlook.com (2603:10b6:408:11f::11)
 by BN9PR12MB5211.namprd12.prod.outlook.com (2603:10b6:408:11c::24)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4500.17; Mon, 13 Sep
 2021 03:41:18 +0000
Received: from BN9PR12MB5226.namprd12.prod.outlook.com
 ([fe80::a3:7688:bffe:880e]) by BN9PR12MB5226.namprd12.prod.outlook.com
 ([fe80::a3:7688:bffe:880e%3]) with mapi id 15.20.4500.018; Mon, 13 Sep 2021
 03:41:18 +0000
From: "Clements, John" <John.Clements@amd.com>
To: "Li, Candice" <Candice.Li@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amdgpu: Unify PSP TA context
Thread-Topic: [PATCH] drm/amdgpu: Unify PSP TA context
Thread-Index: AQHXpikfhj3jZAEMoEmMiZX0N19bcKuhVgCA
Date: Mon, 13 Sep 2021 03:41:18 +0000
Message-ID: <BN9PR12MB52267859180F2D4E3D9AE887FBD99@BN9PR12MB5226.namprd12.prod.outlook.com>
References: <20210910094850.22498-1-candice.li@amd.com>
In-Reply-To: <20210910094850.22498-1-candice.li@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Enabled=true;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SetDate=2021-09-13T03:41:15Z; 
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Method=Standard;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Name=AMD Official Use
 Only-AIP 2.0;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ActionId=8e54da65-7326-4def-b896-62dca164f12a;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ContentBits=1
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 84b49d2b-3d7a-4ea6-af6c-08d976685887
x-ms-traffictypediagnostic: BN9PR12MB5211:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BN9PR12MB52116B2C91143E72C824E7A8FBD99@BN9PR12MB5211.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:1303;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: wa5QJOppE12GBRa3/O26Wa96vrBgfy8Cagi8fBxbrgmnWXyEv30V9r/L6zqOtUdgvKsiIPApAM8W7fCMpIdz/+pouz1UNaFc21/73Cph2hHy/J06GlHnAXKbP9xCoxp4CGCqCdwjHyO62erzc4LeXXxeMwR+5a4ej5k84KwgfbUPZ4VFFlNeBYEICWRq8zL3Q1hGE0cmmeEU/577u5GpvhWxHUPiFsZzylXpj+x1rDLJhFXx/7VuAsCzq4Z0OtwTQLwdu7C9+gsde+N0/9Rrl5jsQOKoPJGU+U0bwwSWAlZJBlFshJ6wS/mFBOCpQoudVQC6R5vZIYbzs3V6qoHoaLbdjnI7uOrK/OjKOrKvPGxNo10HP1LlK0mMjCysdMafI7VEleYGAlbXO4kzjXbN786/OURQuCGePE2lDT8y16hgPNVTA+EMr3v9h1Ppis/o5VZ/V45rB812ADG1N5/zeLjz1Tdx9z+/K83zcgA3gImzWtrHdLYjbX7z7kbxnvQm9pgKpUwdaLcHUxmp2ALFSM2ZAO+kOik2e5ouAbOktzeXEiFcXfx0PWhZaCMV1krTwcSpfApHgvkEdtrflSFggmUoqurGO3zNvV2W9Uho8p+DB89y6XcW21s6WPTiTcrOHA8FzZUxDpnYyfp0HGkqqQROkK4q4bdCuUoxN32q82Re/g5szcvEsx2mpFJ9XDP8E8Ko22WQX5AC8teS0wtg1A==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5226.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(2906002)(86362001)(71200400001)(110136005)(64756008)(83380400001)(26005)(8936002)(33656002)(5660300002)(8676002)(122000001)(76116006)(53546011)(38070700005)(55016002)(316002)(186003)(30864003)(38100700002)(508600001)(6506007)(66476007)(66946007)(66446008)(66556008)(52536014)(9686003)(7696005)(559001)(579004);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?H76a4JysNLfaJGmzztmNJyVgkfn5wZTGj9FRq8DP8UkiP3PZjRwAMugrewJe?=
 =?us-ascii?Q?/ugDg87fTI4BBSpmTdutIndaqhTnDq5SZbNR7ALrYs62F5RtZqru2dnjSuSc?=
 =?us-ascii?Q?vwAA6ZcP7jSkpHyYEiuVply2QhkepXXBSySP6mJqZ9x29y0UntkxdV2/0MSY?=
 =?us-ascii?Q?lbhG2sPc4m79EGQudy/7d9jFQ1xLO5H4hCdM8gpZkQbhPIok3y4QqZx/r1di?=
 =?us-ascii?Q?mg8tYODf6F/+rIcL7sAQ9GoFXRZOILWyAksiYPqEfZO89dxuYQgO47N5XY8c?=
 =?us-ascii?Q?vGXijb6X1PPYaWpKZOjJ6ZcmzmmQsWQsc3iokkVXDjNDfByLgQtwWmuD09Da?=
 =?us-ascii?Q?YtQjSEkK4avRQ5rW8+IxbjuiEw9FLrtxoTaoDYA3ji72wHVgyDfmyXcnn+OD?=
 =?us-ascii?Q?GCZuTn5SmOBw/9rgpf6dtfwbw4T8+dWFHvgoeIBn5oZl7JastByZGynSIUmm?=
 =?us-ascii?Q?gkFN8XO6PHNH04Gk0iNNVLZp47P1CAuDP6k3f3364BQkxUuSr3H6NTNrKMfS?=
 =?us-ascii?Q?9lQIqdUx85dbGwoUD2T6IaVB2jgTpXBf9HjD1NIugWkrlCOwmslV5DdspqEb?=
 =?us-ascii?Q?Otihgth6SErFF1uogFwrUoNbxPCz4DtjJEWSX8vulDe0s02ZsDAbx8EfRqE/?=
 =?us-ascii?Q?32kkAdFZ81/cI1yL7JFor7eI+noaLDmAoFjMwz0+wTbyFdLCYTqJgeC4h2Np?=
 =?us-ascii?Q?b0Sm2Hy+AGl8FwLXp2WqGP3/WOJf+Pu37fVvKmVTFcnYtKAr3OMJBcEN37r3?=
 =?us-ascii?Q?dPUpEzvCfwegnA4HvrBpBu/dbbnUyiqvP3hUUvLob1qZ1Vxpg5dodkFvEPD3?=
 =?us-ascii?Q?1jl2JDzpzuwY+J3S/CYCg91mXEUem8pzBo2WwKhsreCBeIXc07LzGs5PrAc+?=
 =?us-ascii?Q?N5kmtSZHFfsyGxgxBdMl+pR1qFqFsK2+YHr2YPAOhgeuiGIJ84t1aRCYN4us?=
 =?us-ascii?Q?nJrT4Eg2JyCXMHE5wT1eshQ9/96XqSSyX2lBqOTHipiJbV/TYBBjWhQjnh31?=
 =?us-ascii?Q?C/nezZhfC3J9OUXPnYR/zgFgi5Mc7grDGmgHKkdSRRGjGcT5Y321SkiC+vCP?=
 =?us-ascii?Q?YxJIiAlZaZQT24Mu1AmcSGBxk2r3DrONCqI8R2+4LM+OhbzZooH259Drmcxq?=
 =?us-ascii?Q?07W82+8keBr9i4QTmZKekHt2X1LwCXBV1AAX058yngGOWSu0H8ig/fCvW+0G?=
 =?us-ascii?Q?s1EbBDs97MeWwiZ9BXXwfUXb0cpr/v8E0ppUVJmugUxRxOyR/Mh+gZd5Pp3l?=
 =?us-ascii?Q?LkZWfX3uu8i+ebdvVGllJRn4DQtbPIfuVPZOxtWGZLwq7Hp4cLGo8NkSerej?=
 =?us-ascii?Q?P7bT/pOeFEKrwA9fJU7MVFM3?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5226.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 84b49d2b-3d7a-4ea6-af6c-08d976685887
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Sep 2021 03:41:18.1807 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: +WuM1j5/339LQsQBMCoBzvcqoBLNBTTvrnPTCp8SNN9ARQieZXh6m4AjOirg+Yx9+sVMlHpGjcvoMcVOw38fHg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR12MB5211
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

Reviewed-by: John Clements <john.clements@amd.com>

-----Original Message-----
From: Li, Candice <Candice.Li@amd.com>=20
Sent: Friday, September 10, 2021 5:49 PM
To: amd-gfx@lists.freedesktop.org
Cc: Clements, John <John.Clements@amd.com>; Li, Candice <Candice.Li@amd.com=
>
Subject: [PATCH] drm/amdgpu: Unify PSP TA context

Remove all TA binary structures and add the specific binary structure in st=
ruct ta_context.

Signed-off-by: Candice Li <candice.li@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c   |  23 ++--
 drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c   | 122 +++++++++++-----------
 drivers/gpu/drm/amd/amdgpu/amdgpu_psp.h   |  23 ++--
 drivers/gpu/drm/amd/amdgpu/amdgpu_ucode.c |   6 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c  |   9 +-
 drivers/gpu/drm/amd/amdgpu/psp_v10_0.c    |  22 ++--
 drivers/gpu/drm/amd/amdgpu/psp_v11_0.c    |  40 ++++---
 drivers/gpu/drm/amd/amdgpu/psp_v12_0.c    |  14 +--
 8 files changed, 141 insertions(+), 118 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c b/drivers/gpu/drm/amd/=
amdgpu/amdgpu_kms.c
index 7e45640fbee026..d2955ea4a62bf4 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
@@ -341,27 +341,34 @@ static int amdgpu_firmware_info(struct drm_amdgpu_inf=
o_firmware *fw_info,
 		switch (query_fw->index) {
 		case TA_FW_TYPE_PSP_XGMI:
 			fw_info->ver =3D adev->psp.ta_fw_version;
-			fw_info->feature =3D adev->psp.xgmi.feature_version;
+			fw_info->feature =3D adev->psp.xgmi_context.context
+						   .bin_desc.feature_version;
 			break;
 		case TA_FW_TYPE_PSP_RAS:
 			fw_info->ver =3D adev->psp.ta_fw_version;
-			fw_info->feature =3D adev->psp.ras.feature_version;
+			fw_info->feature =3D adev->psp.ras_context.context
+						   .bin_desc.feature_version;
 			break;
 		case TA_FW_TYPE_PSP_HDCP:
 			fw_info->ver =3D adev->psp.ta_fw_version;
-			fw_info->feature =3D adev->psp.hdcp.feature_version;
+			fw_info->feature =3D adev->psp.hdcp_context.context
+						   .bin_desc.feature_version;
 			break;
 		case TA_FW_TYPE_PSP_DTM:
 			fw_info->ver =3D adev->psp.ta_fw_version;
-			fw_info->feature =3D adev->psp.dtm.feature_version;
+			fw_info->feature =3D adev->psp.dtm_context.context
+						   .bin_desc.feature_version;
 			break;
 		case TA_FW_TYPE_PSP_RAP:
 			fw_info->ver =3D adev->psp.ta_fw_version;
-			fw_info->feature =3D adev->psp.rap.feature_version;
+			fw_info->feature =3D adev->psp.rap_context.context
+						   .bin_desc.feature_version;
 			break;
 		case TA_FW_TYPE_PSP_SECUREDISPLAY:
 			fw_info->ver =3D adev->psp.ta_fw_version;
-			fw_info->feature =3D adev->psp.securedisplay.feature_version;
+			fw_info->feature =3D
+				adev->psp.securedisplay_context.context.bin_desc
+					.feature_version;
 			break;
 		default:
 			return -EINVAL;
@@ -378,8 +385,8 @@ static int amdgpu_firmware_info(struct drm_amdgpu_info_=
firmware *fw_info,
 		fw_info->feature =3D adev->psp.sos.feature_version;
 		break;
 	case AMDGPU_INFO_FW_ASD:
-		fw_info->ver =3D adev->psp.asd.fw_version;
-		fw_info->feature =3D adev->psp.asd.feature_version;
+		fw_info->ver =3D adev->psp.asd_context.bin_desc.fw_version;
+		fw_info->feature =3D adev->psp.asd_context.bin_desc.feature_version;
 		break;
 	case AMDGPU_INFO_FW_DMCU:
 		fw_info->ver =3D adev->dm.dmcu_fw_version; diff --git a/drivers/gpu/drm/=
amd/amdgpu/amdgpu_psp.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
index 885876e2ce73b6..071dadf3a4509f 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
@@ -803,15 +803,16 @@ static int psp_asd_load(struct psp_context *psp)
 	 * add workaround to bypass it for sriov now.
 	 * TODO: add version check to make it common
 	 */
-	if (amdgpu_sriov_vf(psp->adev) || !psp->asd.size_bytes)
+	if (amdgpu_sriov_vf(psp->adev) ||=20
+!psp->asd_context.bin_desc.size_bytes)
 		return 0;
=20
 	cmd =3D acquire_psp_cmd_buf(psp);
=20
-	psp_copy_fw(psp, psp->asd.start_addr, psp->asd.size_bytes);
+	psp_copy_fw(psp, psp->asd_context.bin_desc.start_addr,
+		    psp->asd_context.bin_desc.size_bytes);
=20
 	psp_prep_asd_load_cmd_buf(cmd, psp->fw_pri_mc_addr,
-				  psp->asd.size_bytes);
+				  psp->asd_context.bin_desc.size_bytes);
=20
 	ret =3D psp_cmd_submit_buf(psp, NULL, cmd,
 				 psp->fence_buf_mc_addr);
@@ -900,17 +901,18 @@ int psp_reg_program(struct psp_context *psp, enum psp=
_reg_prog_id reg,
=20
 static void psp_prep_ta_load_cmd_buf(struct psp_gfx_cmd_resp *cmd,
 				     uint64_t ta_bin_mc,
-				     uint32_t ta_bin_size,
-				     struct ta_mem_context *mem_ctx)
+				     struct ta_context *context)
 {
 	cmd->cmd_id				=3D GFX_CMD_ID_LOAD_TA;
 	cmd->cmd.cmd_load_ta.app_phy_addr_lo 	=3D lower_32_bits(ta_bin_mc);
 	cmd->cmd.cmd_load_ta.app_phy_addr_hi	=3D upper_32_bits(ta_bin_mc);
-	cmd->cmd.cmd_load_ta.app_len		=3D ta_bin_size;
+	cmd->cmd.cmd_load_ta.app_len		=3D context->bin_desc.size_bytes;
=20
-	cmd->cmd.cmd_load_ta.cmd_buf_phy_addr_lo =3D lower_32_bits(mem_ctx->share=
d_mc_addr);
-	cmd->cmd.cmd_load_ta.cmd_buf_phy_addr_hi =3D upper_32_bits(mem_ctx->share=
d_mc_addr);
-	cmd->cmd.cmd_load_ta.cmd_buf_len	 =3D mem_ctx->shared_mem_size;
+	cmd->cmd.cmd_load_ta.cmd_buf_phy_addr_lo =3D
+		lower_32_bits(context->mem_context.shared_mc_addr);
+	cmd->cmd.cmd_load_ta.cmd_buf_phy_addr_hi =3D
+		upper_32_bits(context->mem_context.shared_mc_addr);
+	cmd->cmd.cmd_load_ta.cmd_buf_len =3D=20
+context->mem_context.shared_mem_size;
 }
=20
 static int psp_ta_init_shared_buf(struct psp_context *psp, @@ -969,7 +971,=
6 @@ static int psp_ta_invoke(struct psp_context *psp,  }
=20
 static int psp_ta_load(struct psp_context *psp,
-			   struct psp_bin_desc *bin_desc,
 			   struct ta_context *context)
 {
 	int ret;
@@ -977,12 +978,12 @@ static int psp_ta_load(struct psp_context *psp,
=20
 	cmd =3D acquire_psp_cmd_buf(psp);
=20
-	psp_copy_fw(psp, bin_desc->start_addr, bin_desc->size_bytes);
+	psp_copy_fw(psp, context->bin_desc.start_addr,
+		    context->bin_desc.size_bytes);
=20
 	psp_prep_ta_load_cmd_buf(cmd,
 				 psp->fw_pri_mc_addr,
-				 bin_desc->size_bytes,
-				 &context->mem_context);
+				 context);
=20
 	ret =3D psp_cmd_submit_buf(psp, NULL, cmd,
 				 psp->fence_buf_mc_addr);
@@ -998,7 +999,7 @@ static int psp_ta_load(struct psp_context *psp,
=20
 static int psp_xgmi_load(struct psp_context *psp)  {
-	return psp_ta_load(psp, &psp->xgmi, &psp->xgmi_context.context);
+	return psp_ta_load(psp, &psp->xgmi_context.context);
 }
=20
 static int psp_xgmi_unload(struct psp_context *psp) @@ -1042,8 +1043,8 @@ =
int psp_xgmi_initialize(struct psp_context *psp, bool set_extended_data, bo=
ol lo
 	int ret;
=20
 	if (!psp->ta_fw ||
-	    !psp->xgmi.size_bytes ||
-	    !psp->xgmi.start_addr)
+	    !psp->xgmi_context.context.bin_desc.size_bytes ||
+	    !psp->xgmi_context.context.bin_desc.start_addr)
 		return -ENOENT;
=20
 	if (!load_ta)
@@ -1119,7 +1120,7 @@ int psp_xgmi_get_node_id(struct psp_context *psp, uin=
t64_t *node_id)  static bool psp_xgmi_peer_link_info_supported(struct psp_c=
ontext *psp)  {
 	return psp->adev->asic_type =3D=3D CHIP_ALDEBARAN &&
-				psp->xgmi.feature_version >=3D 0x2000000b;
+				psp->xgmi_context.context.bin_desc.feature_version >=3D 0x2000000b;
 }
=20
 /*
@@ -1288,7 +1289,7 @@ static int psp_ras_init_shared_buf(struct psp_context=
 *psp)
=20
 static int psp_ras_load(struct psp_context *psp)  {
-	return psp_ta_load(psp, &psp->ras, &psp->ras_context.context);
+	return psp_ta_load(psp, &psp->ras_context.context);
 }
=20
 static int psp_ras_unload(struct psp_context *psp) @@ -1401,8 +1402,8 @@ s=
tatic int psp_ras_initialize(struct psp_context *psp)
 	if (amdgpu_sriov_vf(adev))
 		return 0;
=20
-	if (!adev->psp.ras.size_bytes ||
-	    !adev->psp.ras.start_addr) {
+	if (!adev->psp.ras_context.context.bin_desc.size_bytes ||
+	    !adev->psp.ras_context.context.bin_desc.start_addr) {
 		dev_info(adev->dev, "RAS: optional ras ta ucode is not available\n");
 		return 0;
 	}
@@ -1518,8 +1519,9 @@ static int psp_hdcp_init_shared_buf(struct psp_contex=
t *psp)
=20
 static int psp_hdcp_load(struct psp_context *psp)  {
-	return psp_ta_load(psp, &psp->hdcp, &psp->hdcp_context.context);
+	return psp_ta_load(psp, &psp->hdcp_context.context);
 }
+
 static int psp_hdcp_initialize(struct psp_context *psp)  {
 	int ret;
@@ -1530,8 +1532,8 @@ static int psp_hdcp_initialize(struct psp_context *ps=
p)
 	if (amdgpu_sriov_vf(psp->adev))
 		return 0;
=20
-	if (!psp->hdcp.size_bytes ||
-	    !psp->hdcp.start_addr) {
+	if (!psp->hdcp_context.context.bin_desc.size_bytes ||
+	    !psp->hdcp_context.context.bin_desc.start_addr) {
 		dev_info(psp->adev->dev, "HDCP: optional hdcp ta ucode is not available\=
n");
 		return 0;
 	}
@@ -1608,7 +1610,7 @@ static int psp_dtm_init_shared_buf(struct psp_context=
 *psp)
=20
 static int psp_dtm_load(struct psp_context *psp)  {
-	return psp_ta_load(psp, &psp->dtm, &psp->dtm_context.context);
+	return psp_ta_load(psp, &psp->dtm_context.context);
 }
=20
 static int psp_dtm_initialize(struct psp_context *psp) @@ -1621,8 +1623,8 =
@@ static int psp_dtm_initialize(struct psp_context *psp)
 	if (amdgpu_sriov_vf(psp->adev))
 		return 0;
=20
-	if (!psp->dtm.size_bytes ||
-	    !psp->dtm.start_addr) {
+	if (!psp->dtm_context.context.bin_desc.size_bytes ||
+	    !psp->dtm_context.context.bin_desc.start_addr) {
 		dev_info(psp->adev->dev, "DTM: optional dtm ta ucode is not available\n"=
);
 		return 0;
 	}
@@ -1699,7 +1701,7 @@ static int psp_rap_init_shared_buf(struct psp_context=
 *psp)
=20
 static int psp_rap_load(struct psp_context *psp)  {
-	return psp_ta_load(psp, &psp->rap, &psp->rap_context.context);
+	return psp_ta_load(psp, &psp->rap_context.context);
 }
=20
 static int psp_rap_unload(struct psp_context *psp) @@ -1718,8 +1720,8 @@ s=
tatic int psp_rap_initialize(struct psp_context *psp)
 	if (amdgpu_sriov_vf(psp->adev))
 		return 0;
=20
-	if (!psp->rap.size_bytes ||
-	    !psp->rap.start_addr) {
+	if (!psp->rap_context.context.bin_desc.size_bytes ||
+	    !psp->rap_context.context.bin_desc.start_addr) {
 		dev_info(psp->adev->dev, "RAP: optional rap ta ucode is not available\n"=
);
 		return 0;
 	}
@@ -1813,8 +1815,7 @@ static int psp_securedisplay_init_shared_buf(struct p=
sp_context *psp)
=20
 static int psp_securedisplay_load(struct psp_context *psp)  {
-	return psp_ta_load(psp, &psp->securedisplay,
-			   &psp->securedisplay_context.context);
+	return psp_ta_load(psp, &psp->securedisplay_context.context);
 }
=20
 static int psp_securedisplay_unload(struct psp_context *psp) @@ -1833,8 +1=
834,8 @@ static int psp_securedisplay_initialize(struct psp_context *psp)
 	if (amdgpu_sriov_vf(psp->adev))
 		return 0;
=20
-	if (!psp->securedisplay.size_bytes ||
-	    !psp->securedisplay.start_addr) {
+	if (!psp->securedisplay_context.context.bin_desc.size_bytes ||
+	    !psp->securedisplay_context.context.bin_desc.start_addr) {
 		dev_info(psp->adev->dev, "SECUREDISPLAY: securedisplay ta ucode is not a=
vailable\n");
 		return 0;
 	}
@@ -2783,10 +2784,10 @@ int psp_init_asd_microcode(struct psp_context *psp,
 		goto out;
=20
 	asd_hdr =3D (const struct psp_firmware_header_v1_0 *)adev->psp.asd_fw->da=
ta;
-	adev->psp.asd.fw_version =3D le32_to_cpu(asd_hdr->header.ucode_version);
-	adev->psp.asd.feature_version =3D le32_to_cpu(asd_hdr->sos.fw_version);
-	adev->psp.asd.size_bytes =3D le32_to_cpu(asd_hdr->header.ucode_size_bytes=
);
-	adev->psp.asd.start_addr =3D (uint8_t *)asd_hdr +
+	adev->psp.asd_context.bin_desc.fw_version =3D le32_to_cpu(asd_hdr->header=
.ucode_version);
+	adev->psp.asd_context.bin_desc.feature_version =3D le32_to_cpu(asd_hdr->s=
os.fw_version);
+	adev->psp.asd_context.bin_desc.size_bytes =3D le32_to_cpu(asd_hdr->header=
.ucode_size_bytes);
+	adev->psp.asd_context.bin_desc.start_addr =3D (uint8_t *)asd_hdr +
 				le32_to_cpu(asd_hdr->header.ucode_array_offset_bytes);
 	return 0;
 out:
@@ -3073,40 +3074,43 @@ static int parse_ta_bin_descriptor(struct psp_conte=
xt *psp,
=20
 	switch (desc->fw_type) {
 	case TA_FW_TYPE_PSP_ASD:
-		psp->asd.fw_version        =3D le32_to_cpu(desc->fw_version);
-		psp->asd.feature_version   =3D le32_to_cpu(desc->fw_version);
-		psp->asd.size_bytes        =3D le32_to_cpu(desc->size_bytes);
-		psp->asd.start_addr 	   =3D ucode_start_addr;
+		psp->asd_context.bin_desc.fw_version        =3D le32_to_cpu(desc->fw_ver=
sion);
+		psp->asd_context.bin_desc.feature_version   =3D le32_to_cpu(desc->fw_ver=
sion);
+		psp->asd_context.bin_desc.size_bytes        =3D le32_to_cpu(desc->size_b=
ytes);
+		psp->asd_context.bin_desc.start_addr        =3D ucode_start_addr;
 		break;
 	case TA_FW_TYPE_PSP_XGMI:
-		psp->xgmi.feature_version  =3D le32_to_cpu(desc->fw_version);
-		psp->xgmi.size_bytes       =3D le32_to_cpu(desc->size_bytes);
-		psp->xgmi.start_addr       =3D ucode_start_addr;
+		psp->xgmi_context.context.bin_desc.feature_version  =3D le32_to_cpu(desc=
->fw_version);
+		psp->xgmi_context.context.bin_desc.size_bytes       =3D le32_to_cpu(desc=
->size_bytes);
+		psp->xgmi_context.context.bin_desc.start_addr       =3D ucode_start_addr=
;
 		break;
 	case TA_FW_TYPE_PSP_RAS:
-		psp->ras.feature_version   =3D le32_to_cpu(desc->fw_version);
-		psp->ras.size_bytes        =3D le32_to_cpu(desc->size_bytes);
-		psp->ras.start_addr        =3D ucode_start_addr;
+		psp->ras_context.context.bin_desc.feature_version   =3D le32_to_cpu(desc=
->fw_version);
+		psp->ras_context.context.bin_desc.size_bytes        =3D le32_to_cpu(desc=
->size_bytes);
+		psp->ras_context.context.bin_desc.start_addr        =3D ucode_start_addr=
;
 		break;
 	case TA_FW_TYPE_PSP_HDCP:
-		psp->hdcp.feature_version  =3D le32_to_cpu(desc->fw_version);
-		psp->hdcp.size_bytes       =3D le32_to_cpu(desc->size_bytes);
-		psp->hdcp.start_addr       =3D ucode_start_addr;
+		psp->hdcp_context.context.bin_desc.feature_version  =3D le32_to_cpu(desc=
->fw_version);
+		psp->hdcp_context.context.bin_desc.size_bytes       =3D le32_to_cpu(desc=
->size_bytes);
+		psp->hdcp_context.context.bin_desc.start_addr       =3D ucode_start_addr=
;
 		break;
 	case TA_FW_TYPE_PSP_DTM:
-		psp->dtm.feature_version  =3D le32_to_cpu(desc->fw_version);
-		psp->dtm.size_bytes       =3D le32_to_cpu(desc->size_bytes);
-		psp->dtm.start_addr       =3D ucode_start_addr;
+		psp->dtm_context.context.bin_desc.feature_version  =3D le32_to_cpu(desc-=
>fw_version);
+		psp->dtm_context.context.bin_desc.size_bytes       =3D le32_to_cpu(desc-=
>size_bytes);
+		psp->dtm_context.context.bin_desc.start_addr       =3D ucode_start_addr;
 		break;
 	case TA_FW_TYPE_PSP_RAP:
-		psp->rap.feature_version  =3D le32_to_cpu(desc->fw_version);
-		psp->rap.size_bytes       =3D le32_to_cpu(desc->size_bytes);
-		psp->rap.start_addr       =3D ucode_start_addr;
+		psp->rap_context.context.bin_desc.feature_version  =3D le32_to_cpu(desc-=
>fw_version);
+		psp->rap_context.context.bin_desc.size_bytes       =3D le32_to_cpu(desc-=
>size_bytes);
+		psp->rap_context.context.bin_desc.start_addr       =3D ucode_start_addr;
 		break;
 	case TA_FW_TYPE_PSP_SECUREDISPLAY:
-		psp->securedisplay.feature_version  =3D le32_to_cpu(desc->fw_version);
-		psp->securedisplay.size_bytes       =3D le32_to_cpu(desc->size_bytes);
-		psp->securedisplay.start_addr       =3D ucode_start_addr;
+		psp->securedisplay_context.context.bin_desc.feature_version =3D
+			le32_to_cpu(desc->fw_version);
+		psp->securedisplay_context.context.bin_desc.size_bytes =3D
+			le32_to_cpu(desc->size_bytes);
+		psp->securedisplay_context.context.bin_desc.start_addr =3D
+			ucode_start_addr;
 		break;
 	default:
 		dev_warn(psp->adev->dev, "Unsupported TA type: %d\n", desc->fw_type); di=
ff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.h b/drivers/gpu/drm/amd/am=
dgpu/amdgpu_psp.h
index cc09b9e911199a..cfd7ac976cd1e6 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.h
@@ -133,9 +133,17 @@ struct psp_xgmi_topology_info {
 	struct psp_xgmi_node_info	nodes[AMDGPU_XGMI_MAX_CONNECTED_NODES];
 };
=20
+struct psp_bin_desc {
+	uint32_t fw_version;
+	uint32_t feature_version;
+	uint32_t size_bytes;
+	uint8_t *start_addr;
+};
+
 struct psp_asd_context {
 	bool			asd_initialized;
 	uint32_t		session_id;
+	struct psp_bin_desc		bin_desc;
 };
=20
 struct ta_mem_context {
@@ -149,6 +157,7 @@ struct ta_context {
 	bool			initialized;
 	uint32_t		session_id;
 	struct ta_mem_context	mem_context;
+	struct psp_bin_desc		bin_desc;
 };
=20
 struct ta_cp_context {
@@ -266,13 +275,6 @@ struct psp_runtime_boot_cfg_entry {
 	uint32_t reserved;
 };
=20
-struct psp_bin_desc {
-	uint32_t fw_version;
-	uint32_t feature_version;
-	uint32_t size_bytes;
-	uint8_t *start_addr;
-};
-
 struct psp_context
 {
 	struct amdgpu_device            *adev;
@@ -304,7 +306,6 @@ struct psp_context
=20
 	/* asd firmware */
 	const struct firmware	*asd_fw;
-	struct psp_bin_desc		asd;
=20
 	/* toc firmware */
 	const struct firmware		*toc_fw;
@@ -329,12 +330,6 @@ struct psp_context
 	/* xgmi ta firmware and buffer */
 	const struct firmware		*ta_fw;
 	uint32_t			ta_fw_version;
-	struct psp_bin_desc		xgmi;
-	struct psp_bin_desc		ras;
-	struct psp_bin_desc		hdcp;
-	struct psp_bin_desc		dtm;
-	struct psp_bin_desc		rap;
-	struct psp_bin_desc		securedisplay;
=20
 	struct psp_asd_context		asd_context;
 	struct psp_xgmi_context		xgmi_context;
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ucode.c b/drivers/gpu/drm/am=
d/amdgpu/amdgpu_ucode.c
index 5f396936c6addf..527d67ded8a008 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ucode.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ucode.c
@@ -525,9 +525,9 @@ FW_VERSION_ATTR(rlc_srls_fw_version, 0444, gfx.rlc_srls=
_fw_version);  FW_VERSION_ATTR(mec_fw_version, 0444, gfx.mec_fw_version);  =
FW_VERSION_ATTR(mec2_fw_version, 0444, gfx.mec2_fw_version);  FW_VERSION_AT=
TR(sos_fw_version, 0444, psp.sos.fw_version); -FW_VERSION_ATTR(asd_fw_versi=
on, 0444, psp.asd.fw_version); -FW_VERSION_ATTR(ta_ras_fw_version, 0444, ps=
p.ras.feature_version); -FW_VERSION_ATTR(ta_xgmi_fw_version, 0444, psp.xgmi=
.feature_version);
+FW_VERSION_ATTR(asd_fw_version, 0444,=20
+psp.asd_context.bin_desc.fw_version);
+FW_VERSION_ATTR(ta_ras_fw_version, 0444,=20
+psp.ras_context.context.bin_desc.feature_version);
+FW_VERSION_ATTR(ta_xgmi_fw_version, 0444,=20
+psp.xgmi_context.context.bin_desc.feature_version);
 FW_VERSION_ATTR(smc_fw_version, 0444, pm.fw_version);  FW_VERSION_ATTR(sdm=
a_fw_version, 0444, sdma.instance[0].fw_version);  FW_VERSION_ATTR(sdma2_fw=
_version, 0444, sdma.instance[1].fw_version); diff --git a/drivers/gpu/drm/=
amd/amdgpu/amdgpu_virt.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c
index ca058fbcccd43a..88c4177b708ac8 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c
@@ -532,9 +532,12 @@ static void amdgpu_virt_populate_vf2pf_ucode_info(stru=
ct amdgpu_device *adev)
 	POPULATE_UCODE_INFO(vf2pf_info, AMD_SRIOV_UCODE_ID_MEC,      adev->gfx.me=
c_fw_version);
 	POPULATE_UCODE_INFO(vf2pf_info, AMD_SRIOV_UCODE_ID_MEC2,     adev->gfx.me=
c2_fw_version);
 	POPULATE_UCODE_INFO(vf2pf_info, AMD_SRIOV_UCODE_ID_SOS,      adev->psp.so=
s.fw_version);
-	POPULATE_UCODE_INFO(vf2pf_info, AMD_SRIOV_UCODE_ID_ASD,      adev->psp.as=
d.fw_version);
-	POPULATE_UCODE_INFO(vf2pf_info, AMD_SRIOV_UCODE_ID_TA_RAS,   adev->psp.ra=
s.feature_version);
-	POPULATE_UCODE_INFO(vf2pf_info, AMD_SRIOV_UCODE_ID_TA_XGMI,  adev->psp.xg=
mi.feature_version);
+	POPULATE_UCODE_INFO(vf2pf_info, AMD_SRIOV_UCODE_ID_ASD,
+			    adev->psp.asd_context.bin_desc.fw_version);
+	POPULATE_UCODE_INFO(vf2pf_info, AMD_SRIOV_UCODE_ID_TA_RAS,
+			    adev->psp.ras_context.context.bin_desc.feature_version);
+	POPULATE_UCODE_INFO(vf2pf_info, AMD_SRIOV_UCODE_ID_TA_XGMI,
+			    adev->psp.xgmi_context.context.bin_desc.feature_version);
 	POPULATE_UCODE_INFO(vf2pf_info, AMD_SRIOV_UCODE_ID_SMC,      adev->pm.fw_=
version);
 	POPULATE_UCODE_INFO(vf2pf_info, AMD_SRIOV_UCODE_ID_SDMA,     adev->sdma.i=
nstance[0].fw_version);
 	POPULATE_UCODE_INFO(vf2pf_info, AMD_SRIOV_UCODE_ID_SDMA2,    adev->sdma.i=
nstance[1].fw_version);
diff --git a/drivers/gpu/drm/amd/amdgpu/psp_v10_0.c b/drivers/gpu/drm/amd/a=
mdgpu/psp_v10_0.c
index 5872d68ed13d70..59644015dfc3ee 100644
--- a/drivers/gpu/drm/amd/amdgpu/psp_v10_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/psp_v10_0.c
@@ -84,28 +84,28 @@ static int psp_v10_0_init_microcode(struct psp_context =
*psp)
=20
 		ta_hdr =3D (const struct ta_firmware_header_v1_0 *)
 				 adev->psp.ta_fw->data;
-		adev->psp.hdcp.feature_version =3D
+		adev->psp.hdcp_context.context.bin_desc.feature_version =3D
 			le32_to_cpu(ta_hdr->hdcp.fw_version);
-		adev->psp.hdcp.size_bytes =3D
+		adev->psp.hdcp_context.context.bin_desc.size_bytes =3D
 			le32_to_cpu(ta_hdr->hdcp.size_bytes);
-		adev->psp.hdcp.start_addr =3D
+		adev->psp.hdcp_context.context.bin_desc.start_addr =3D
 			(uint8_t *)ta_hdr +
 			le32_to_cpu(ta_hdr->header.ucode_array_offset_bytes);
=20
-		adev->psp.dtm.feature_version =3D
+		adev->psp.dtm_context.context.bin_desc.feature_version =3D
 			le32_to_cpu(ta_hdr->dtm.fw_version);
-		adev->psp.dtm.size_bytes =3D
+		adev->psp.dtm_context.context.bin_desc.size_bytes =3D
 			le32_to_cpu(ta_hdr->dtm.size_bytes);
-		adev->psp.dtm.start_addr =3D
-			(uint8_t *)adev->psp.hdcp.start_addr +
+		adev->psp.dtm_context.context.bin_desc.start_addr =3D
+			(uint8_t *)adev->psp.hdcp_context.context.bin_desc.start_addr +
 			le32_to_cpu(ta_hdr->dtm.offset_bytes);
=20
-		adev->psp.securedisplay.feature_version =3D
+		adev->psp.securedisplay_context.context.bin_desc.feature_version =3D
 			le32_to_cpu(ta_hdr->securedisplay.fw_version);
-		adev->psp.securedisplay.size_bytes =3D
+		adev->psp.securedisplay_context.context.bin_desc.size_bytes =3D
 			le32_to_cpu(ta_hdr->securedisplay.size_bytes);
-		adev->psp.securedisplay.start_addr =3D
-			(uint8_t *)adev->psp.hdcp.start_addr +
+		adev->psp.securedisplay_context.context.bin_desc.start_addr =3D
+			(uint8_t *)adev->psp.hdcp_context.context.bin_desc.start_addr +
 			le32_to_cpu(ta_hdr->securedisplay.offset_bytes);
=20
 		adev->psp.ta_fw_version =3D le32_to_cpu(ta_hdr->header.ucode_version);
diff --git a/drivers/gpu/drm/amd/amdgpu/psp_v11_0.c b/drivers/gpu/drm/amd/a=
mdgpu/psp_v11_0.c
index 29bf9f09944be7..3c02e75fd366b5 100644
--- a/drivers/gpu/drm/amd/amdgpu/psp_v11_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/psp_v11_0.c
@@ -151,14 +151,20 @@ static int psp_v11_0_init_microcode(struct psp_contex=
t *psp)
 				goto out2;
=20
 			ta_hdr =3D (const struct ta_firmware_header_v1_0 *)adev->psp.ta_fw->dat=
a;
-			adev->psp.xgmi.feature_version =3D le32_to_cpu(ta_hdr->xgmi.fw_version)=
;
-			adev->psp.xgmi.size_bytes =3D le32_to_cpu(ta_hdr->xgmi.size_bytes);
-			adev->psp.xgmi.start_addr =3D (uint8_t *)ta_hdr +
+			adev->psp.xgmi_context.context.bin_desc.feature_version =3D
+				le32_to_cpu(ta_hdr->xgmi.fw_version);
+			adev->psp.xgmi_context.context.bin_desc.size_bytes =3D
+				le32_to_cpu(ta_hdr->xgmi.size_bytes);
+			adev->psp.xgmi_context.context.bin_desc.start_addr =3D
+				(uint8_t *)ta_hdr +
 				le32_to_cpu(ta_hdr->header.ucode_array_offset_bytes);
 			adev->psp.ta_fw_version =3D le32_to_cpu(ta_hdr->header.ucode_version);
-			adev->psp.ras.feature_version =3D le32_to_cpu(ta_hdr->ras.fw_version);
-			adev->psp.ras.size_bytes =3D le32_to_cpu(ta_hdr->ras.size_bytes);
-			adev->psp.ras.start_addr =3D (uint8_t *)adev->psp.xgmi.start_addr +
+			adev->psp.ras_context.context.bin_desc.feature_version =3D
+				le32_to_cpu(ta_hdr->ras.fw_version);
+			adev->psp.ras_context.context.bin_desc.size_bytes =3D
+				le32_to_cpu(ta_hdr->ras.size_bytes);
+			adev->psp.ras_context.context.bin_desc.start_addr =3D
+				(uint8_t *)adev->psp.xgmi_context.context.bin_desc.start_addr +
 				le32_to_cpu(ta_hdr->ras.offset_bytes);
 		}
 		break;
@@ -186,16 +192,24 @@ static int psp_v11_0_init_microcode(struct psp_contex=
t *psp)
 				goto out2;
=20
 			ta_hdr =3D (const struct ta_firmware_header_v1_0 *)adev->psp.ta_fw->dat=
a;
-			adev->psp.hdcp.feature_version =3D le32_to_cpu(ta_hdr->hdcp.fw_version)=
;
-			adev->psp.hdcp.size_bytes =3D le32_to_cpu(ta_hdr->hdcp.size_bytes);
-			adev->psp.hdcp.start_addr =3D (uint8_t *)ta_hdr +
-				le32_to_cpu(ta_hdr->header.ucode_array_offset_bytes);
+			adev->psp.hdcp_context.context.bin_desc.feature_version =3D
+				le32_to_cpu(ta_hdr->hdcp.fw_version);
+			adev->psp.hdcp_context.context.bin_desc.size_bytes =3D
+				le32_to_cpu(ta_hdr->hdcp.size_bytes);
+			adev->psp.hdcp_context.context.bin_desc.start_addr =3D
+				(uint8_t *)ta_hdr +
+				le32_to_cpu(
+					ta_hdr->header.ucode_array_offset_bytes);
=20
 			adev->psp.ta_fw_version =3D le32_to_cpu(ta_hdr->header.ucode_version);
=20
-			adev->psp.dtm.feature_version =3D le32_to_cpu(ta_hdr->dtm.fw_version);
-			adev->psp.dtm.size_bytes =3D le32_to_cpu(ta_hdr->dtm.size_bytes);
-			adev->psp.dtm.start_addr =3D (uint8_t *)adev->psp.hdcp.start_addr +
+			adev->psp.dtm_context.context.bin_desc.feature_version =3D
+				le32_to_cpu(ta_hdr->dtm.fw_version);
+			adev->psp.dtm_context.context.bin_desc.size_bytes =3D
+				le32_to_cpu(ta_hdr->dtm.size_bytes);
+			adev->psp.dtm_context.context.bin_desc.start_addr =3D
+				(uint8_t *)adev->psp.hdcp_context.context
+					.bin_desc.start_addr +
 				le32_to_cpu(ta_hdr->dtm.offset_bytes);
 		}
 		break;
diff --git a/drivers/gpu/drm/amd/amdgpu/psp_v12_0.c b/drivers/gpu/drm/amd/a=
mdgpu/psp_v12_0.c
index cc649406234ba7..281bc4d7f0a1aa 100644
--- a/drivers/gpu/drm/amd/amdgpu/psp_v12_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/psp_v12_0.c
@@ -84,22 +84,22 @@ static int psp_v12_0_init_microcode(struct psp_context =
*psp)
=20
 		ta_hdr =3D (const struct ta_firmware_header_v1_0 *)
 				 adev->psp.ta_fw->data;
-		adev->psp.hdcp.feature_version =3D
+		adev->psp.hdcp_context.context.bin_desc.feature_version =3D
 			le32_to_cpu(ta_hdr->hdcp.fw_version);
-		adev->psp.hdcp.size_bytes =3D
+		adev->psp.hdcp_context.context.bin_desc.size_bytes =3D
 			le32_to_cpu(ta_hdr->hdcp.size_bytes);
-		adev->psp.hdcp.start_addr =3D
+		adev->psp.hdcp_context.context.bin_desc.start_addr =3D
 			(uint8_t *)ta_hdr +
 			le32_to_cpu(ta_hdr->header.ucode_array_offset_bytes);
=20
 		adev->psp.ta_fw_version =3D le32_to_cpu(ta_hdr->header.ucode_version);
=20
-		adev->psp.dtm.feature_version =3D
+		adev->psp.dtm_context.context.bin_desc.feature_version =3D
 			le32_to_cpu(ta_hdr->dtm.fw_version);
-		adev->psp.dtm.size_bytes =3D
+		adev->psp.dtm_context.context.bin_desc.size_bytes =3D
 			le32_to_cpu(ta_hdr->dtm.size_bytes);
-		adev->psp.dtm.start_addr =3D
-			(uint8_t *)adev->psp.hdcp.start_addr +
+		adev->psp.dtm_context.context.bin_desc.start_addr =3D
+			(uint8_t *)adev->psp.hdcp_context.context.bin_desc.start_addr +
 			le32_to_cpu(ta_hdr->dtm.offset_bytes);
 	}
=20
--
2.17.1
