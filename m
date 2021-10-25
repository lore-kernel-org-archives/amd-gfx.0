Return-Path: <SRS0=aCMl=PN=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61AABC433EF
	for <amd-gfx@archiver.kernel.org>; Mon, 25 Oct 2021 02:37:16 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1635260F22
	for <amd-gfx@archiver.kernel.org>; Mon, 25 Oct 2021 02:37:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 1635260F22
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4B65389D46;
	Mon, 25 Oct 2021 02:37:15 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2087.outbound.protection.outlook.com [40.107.94.87])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 26CA089D46
 for <amd-gfx@lists.freedesktop.org>; Mon, 25 Oct 2021 02:37:14 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=l9l0E89bezTpB8JiDYaEyBBUjmn9qWDd6Vpcm5tVAEeyxTGS0UkNz3QztVuoTHC5746/RqBtSSs08DM/4OLB3YKo3mgz7RFqCzzS3W7xJtW/b8EmK7z9+MoRGX/Bz7UCfAVgGMcQAXa3KOn7VBFQSYPdB0vzmVBBbqOa6VBbBIV1cTH8hfyYn7LIKSVD3ypq9k0UFr3g0KB4TulJfiAugNXPcjEYSs2xb0tnKX5YUJYz9AU9emJgnufzWv52bqCOLs0t0xdoEhcxLRrUqWQk5ATbgjewP0w4apyqhYy5/MJ8zsTvEv7M6zOm5xV6QEM/Fv8YD0dB+b+AnRPr5vdcDQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4uiBeqYZZX+aUJUmNWLx/8OERK6e6fKCsavVGZMh6g4=;
 b=A08LRnaF/MdkfQheHgTYgNjEYvII0OrDEMk/QhV0sPJoxUOSMA48L8KDioP3t+OsD/0+FtZe1Oom50UEPv+qgjukHLNlzzn0S4apwaT1Q//2FhfbRv4Jy5tquQ1fchhapvrNa7hE5grC5lNPGuvlL1kFoyT+htjdEl7Vu72rxOr7udI67JsfFPQ7ktBH4tQfd+lrRgzsXS1c6aS/JYYDq2ul5NcU3jK2acLDx5Ayb5Quub2sYCPGXgvaSgYtv/iJEJDuagDiAd3rphzalDZ7Oxe3fcJ9h7/l1SmO2VLnHW/F5G8f+XZWiJRhk32eX4fJiMdB9eitymgtFECBkeDTpg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4uiBeqYZZX+aUJUmNWLx/8OERK6e6fKCsavVGZMh6g4=;
 b=tSCfcyJbtg8PE4vK4P++eTqsStMhNducnJsiu1RMAhAoykM+zZlgOA6fcJJ6ijdbTSirYJVfrcMkcDqcZDcVTtvtqntja8xsViKUWwBsv3LuOdsO3JKgnX7BpLT3iZ+yC0fIbtyoZbXMYaNFGwvmfNnU69yubCvEvJb9qhN5ckc=
Received: from MWHPR1201MB2542.namprd12.prod.outlook.com
 (2603:10b6:300:e8::20) by MWHPR12MB1373.namprd12.prod.outlook.com
 (2603:10b6:300:14::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4628.18; Mon, 25 Oct
 2021 02:37:12 +0000
Received: from MWHPR1201MB2542.namprd12.prod.outlook.com
 ([fe80::b841:5638:564b:30d7]) by MWHPR1201MB2542.namprd12.prod.outlook.com
 ([fe80::b841:5638:564b:30d7%11]) with mapi id 15.20.4628.020; Mon, 25 Oct
 2021 02:37:12 +0000
From: "Clements, John" <John.Clements@amd.com>
To: "Li, Candice" <Candice.Li@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amdgpu: Update TA version output in driver
Thread-Topic: [PATCH] drm/amdgpu: Update TA version output in driver
Thread-Index: AQHXyUhrX6QJhbVnlUaKBjZvD4bEWavi/7ow
Date: Mon, 25 Oct 2021 02:37:11 +0000
Message-ID: <MWHPR1201MB2542BA0E9BC3AEF4ABA5E4D5FB839@MWHPR1201MB2542.namprd12.prod.outlook.com>
References: <20211025023112.22059-1-candice.li@amd.com>
In-Reply-To: <20211025023112.22059-1-candice.li@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Enabled=true;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SetDate=2021-10-25T02:37:08Z; 
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Method=Standard;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Name=AMD Official Use
 Only-AIP 2.0;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ActionId=62f53fdd-37b1-472d-a7a9-173199b8f234;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ContentBits=1
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 419ac761-1232-472f-4101-08d99760594f
x-ms-traffictypediagnostic: MWHPR12MB1373:
x-microsoft-antispam-prvs: <MWHPR12MB1373C30AECAFBC2478757A37FB839@MWHPR12MB1373.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:227;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 7UWuzpwNNNaiTin+ifTR3QozvRangwEeLiZ4zMobEfOa6wl/pIc+6a24SvvMSp876Shdp2OWscEGq4OSC0PWDyHOo4zlnBH1GfxTE64wxIDC4hbPaSpirouUUxZFYQbq6mFL170YB6+8sUNBfadUnp4mG4rUqm+RVLVcTfo3zWmxtThZaSxRa9FUo64eXWGpg9O7CUOkYZi7WxcHV9SPKbamvIPr8QuOULrgSlEUJPPndbAcHjs9jB98aPpUOSzmQvKphRfHpr66S6i/+IUJXkOWJ1heMZ1JaioroznX0wQd92lDnzh0YgdDz478Ttg0CmRcrv1OrGRu0YK4H9SFoX5MVrr9RZGeyNlNB1HETaCcpbokj5QhRHTeJSg9SXbf5bLLDBr4Pri80HKvIiFicqiMTKFXP6QwAOQTcqHg8fDFsLk9bgrqCog/ikXyLTq83lpXbhrVzHqgt+Dbnj9ybJN7yOlIoLZDGd5fD7kogHdQQiUidEEF5z9/ZQkgVB4iW5iLlki/FxXdNz9T8+RdRVEAOJd5evVoroBTx8/cbrHz11pbMkHPLbqTLHCsLrpGGPPvITGdU47oDvFnJtES/bHktnEHaa0MRnfhjQGNGSy7ln+fEhggvsgQNRDyBHoKkyKLrE6n5brV10j7W4lJtf7WuNuANRUuxXLKNwWaJA+mua6QFedtdpi2XFCLYlcIbE3xUjWD1f5dQlpUjfTbgQ==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MWHPR1201MB2542.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(15650500001)(8936002)(5660300002)(33656002)(9686003)(55016002)(66556008)(38070700005)(53546011)(110136005)(8676002)(71200400001)(2906002)(66946007)(6506007)(83380400001)(52536014)(316002)(508600001)(76116006)(7696005)(86362001)(26005)(186003)(30864003)(38100700002)(64756008)(66446008)(122000001)(66476007);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?DP8pIZ9aqxeG8bf5IsWDfoZlaxZ/W2QFvAExuq9+2wMaNbggC6UDl4Tt2kzs?=
 =?us-ascii?Q?UvrNS226KvvH0Vn7Fj6JLrHG6XuvB/phYs4PYqkAWf10rM8e+lfWUEf9/k/+?=
 =?us-ascii?Q?ZWwgt2HIhq4PC+L+WwKs/qGHMed3WmCmY+kNRHthIKBpjbmaOa26dJK3w/V3?=
 =?us-ascii?Q?tQWmYb794gf6TYDhLPDNGeCZlrdejCS8LkpAnVvuK3IDnyYf4BMcKUP0mjzM?=
 =?us-ascii?Q?dzL3S4X6o98R8aUyx8arh24Wf7U8dvgecpEy14pVwRzXAAI4PPY5zakIQeLZ?=
 =?us-ascii?Q?otsJ8S1YoF8oAMXck8s/6YM1R+6UcBTn1jy8HYwP7x1ghG5rTh8ioBkvukVz?=
 =?us-ascii?Q?xfjqhaFH/FOFyXWq5OUJvdaiZjBmtwAgy0wEBOq9+8vRVXD2oujuGHXuZmfv?=
 =?us-ascii?Q?KC1l3TjVNuaDS1s/ZFyT2uUnBZ0Hw0O5K1BJbd4wqOzPE5BRMpFqlj8mYiGx?=
 =?us-ascii?Q?J9xnbixSHTrF02sW9AZib32rGGK7gKp/poZvikYFvqLCC8cmL1xQsqtNjeve?=
 =?us-ascii?Q?lDNCpC6Isbl0f3OeaKjDQN1SdGca37GzKCZDtlaNJ4ZQrhrG5BT2PT7tQWad?=
 =?us-ascii?Q?ycNvs4rzxfxuNfg5WagtY4QwFnNJYkVZJH4ElAD53VEXF0FSh+vDZ1wOpclG?=
 =?us-ascii?Q?oigV+HT9SJ7LWCQWDF0T2IipBoInMmQXn0NjobKDzH5vQUoYtzgAHNGqjjy8?=
 =?us-ascii?Q?gjfTCAQWw8XS6ywE2pxfXEOYotCvOOYZ/eKyURukMod/30ITf31WVwEorBBn?=
 =?us-ascii?Q?fE/i6Mq1wTNNmTbL7RDt+cIn/fIUVSy1FW1PO+mTzlVCAkHmxu3KQ71yGLBj?=
 =?us-ascii?Q?z+RusRF6wTkppquZoLv7sY/qZQ+FW7tYfONCEMys4d2cQ4nd4vk4luQmSrwO?=
 =?us-ascii?Q?DWX5n/vxaY6xXFstc7EK8vqAhY+xtBlLCv08DxStn/c0wn9wbf4jWfRFHihs?=
 =?us-ascii?Q?UImlA2gmWNB9E9m8Z5O3tLPC4IoN8EkU+zWigqv7cwYafX0jPm6y4e3DbmYF?=
 =?us-ascii?Q?K64gbJ7Y+OKNby5VYS6U9cIA6NTchk3alAZODd1XmZ/5kC+/YZ8wo2NVKZas?=
 =?us-ascii?Q?hxVPfFIoXDNwEmn98msUQFCyHHZ2ZrgtHy6C9ZxMeFdipn0Wb4GHrA4M6vm/?=
 =?us-ascii?Q?pMxCErjEp6XA72SLkIPEmxcNsgnjQ8HtFBvU8p+RE/0zSaqC3j9YeTJnP2hL?=
 =?us-ascii?Q?4xug8o8SjqmZK0JgqueyFNDJQOyH/Dwpic8I1BwmjAEKqPW/a3j64bFBiTv2?=
 =?us-ascii?Q?GXr42fv/XqSVVGfpgvY0WIn9Tx0mwV7jP6mFhNXx4hkXKCktDMWb/oUEuRUM?=
 =?us-ascii?Q?pGi73rZ4S+3nbvyBJnREStwwiAeQZ63iy6ixXSQsnMEwwVT60HIjioVfZIfd?=
 =?us-ascii?Q?+HgNAuXUAdcnAdS8mVw3ABdpyv+SSHIHvHOxSo6PJF8r6/IRPAQimhS1A/Kz?=
 =?us-ascii?Q?GxE9Xa6bfOcJiln0s61FvisondmZqK2h3S7f9u9UX/AJSL2qw6KKg6Pvk7Yp?=
 =?us-ascii?Q?+ZnrG7QAqUsFcaN81B/3rwpBXTqjWhIIvzcl7aDNX+2KJc/XmYnPgMiiWdtG?=
 =?us-ascii?Q?yFXs9nfhSf0KSx+AnlzsLKRbmDE9gPZUmL6KFGbWtmT4eux2s9MUa59it2lz?=
 =?us-ascii?Q?fAAtSrDyqnomCB7xB8wybKE=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1201MB2542.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 419ac761-1232-472f-4101-08d99760594f
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Oct 2021 02:37:11.8577 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 65c5ZVxmZDxk8nKmmszP6IDBKLEsg+yrV1K3RAh9xTvG0amPH7fv46II/TAdFY7iCYfxlRVBf7mM7r7AMiwoqw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR12MB1373
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
Sent: Monday, October 25, 2021 10:31 AM
To: amd-gfx@lists.freedesktop.org
Cc: Clements, John <John.Clements@amd.com>; Li, Candice <Candice.Li@amd.com=
>
Subject: [PATCH] drm/amdgpu: Update TA version output in driver

TA version should only be displayed in firmware version column.

Signed-off-by: Candice Li <candice.li@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c   | 12 ++++++------
 drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c   | 14 +++++++-------
 drivers/gpu/drm/amd/amdgpu/amdgpu_ucode.c |  4 ++--  drivers/gpu/drm/amd/a=
mdgpu/amdgpu_virt.c  |  4 ++--
 drivers/gpu/drm/amd/amdgpu/psp_v10_0.c    |  6 +++---
 drivers/gpu/drm/amd/amdgpu/psp_v11_0.c    |  8 ++++----
 drivers/gpu/drm/amd/amdgpu/psp_v12_0.c    |  4 ++--
 7 files changed, 26 insertions(+), 26 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c b/drivers/gpu/drm/amd/=
amdgpu/amdgpu_kms.c
index d2955ea4a62bf4..dfe667ea8b058e 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
@@ -340,32 +340,32 @@ static int amdgpu_firmware_info(struct drm_amdgpu_inf=
o_firmware *fw_info,
 	case AMDGPU_INFO_FW_TA:
 		switch (query_fw->index) {
 		case TA_FW_TYPE_PSP_XGMI:
-			fw_info->ver =3D adev->psp.ta_fw_version;
+			fw_info->ver =3D adev->psp.xgmi_context.context.bin_desc.fw_version;
 			fw_info->feature =3D adev->psp.xgmi_context.context
 						   .bin_desc.feature_version;
 			break;
 		case TA_FW_TYPE_PSP_RAS:
-			fw_info->ver =3D adev->psp.ta_fw_version;
+			fw_info->ver =3D adev->psp.ras_context.context.bin_desc.fw_version;
 			fw_info->feature =3D adev->psp.ras_context.context
 						   .bin_desc.feature_version;
 			break;
 		case TA_FW_TYPE_PSP_HDCP:
-			fw_info->ver =3D adev->psp.ta_fw_version;
+			fw_info->ver =3D adev->psp.hdcp_context.context.bin_desc.fw_version;
 			fw_info->feature =3D adev->psp.hdcp_context.context
 						   .bin_desc.feature_version;
 			break;
 		case TA_FW_TYPE_PSP_DTM:
-			fw_info->ver =3D adev->psp.ta_fw_version;
+			fw_info->ver =3D adev->psp.dtm_context.context.bin_desc.fw_version;
 			fw_info->feature =3D adev->psp.dtm_context.context
 						   .bin_desc.feature_version;
 			break;
 		case TA_FW_TYPE_PSP_RAP:
-			fw_info->ver =3D adev->psp.ta_fw_version;
+			fw_info->ver =3D adev->psp.rap_context.context.bin_desc.fw_version;
 			fw_info->feature =3D adev->psp.rap_context.context
 						   .bin_desc.feature_version;
 			break;
 		case TA_FW_TYPE_PSP_SECUREDISPLAY:
-			fw_info->ver =3D adev->psp.ta_fw_version;
+			fw_info->ver =3D=20
+adev->psp.securedisplay_context.context.bin_desc.fw_version;
 			fw_info->feature =3D
 				adev->psp.securedisplay_context.context.bin_desc
 					.feature_version;
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c b/drivers/gpu/drm/amd/=
amdgpu/amdgpu_psp.c
index fd04e83031d642..c641f84649d6bd 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
@@ -1115,7 +1115,7 @@ int psp_xgmi_get_node_id(struct psp_context *psp, uin=
t64_t *node_id)  static bool psp_xgmi_peer_link_info_supported(struct psp_c=
ontext *psp)  {
 	return psp->adev->ip_versions[MP0_HWIP][0] =3D=3D IP_VERSION(13, 0, 2) &&
-		psp->xgmi_context.context.bin_desc.feature_version >=3D 0x2000000b;
+		psp->xgmi_context.context.bin_desc.fw_version >=3D 0x2000000b;
 }
=20
 /*
@@ -3108,32 +3108,32 @@ static int parse_ta_bin_descriptor(struct psp_conte=
xt *psp,
 		psp->asd_context.bin_desc.start_addr        =3D ucode_start_addr;
 		break;
 	case TA_FW_TYPE_PSP_XGMI:
-		psp->xgmi_context.context.bin_desc.feature_version  =3D le32_to_cpu(desc=
->fw_version);
+		psp->xgmi_context.context.bin_desc.fw_version       =3D le32_to_cpu(desc=
->fw_version);
 		psp->xgmi_context.context.bin_desc.size_bytes       =3D le32_to_cpu(desc=
->size_bytes);
 		psp->xgmi_context.context.bin_desc.start_addr       =3D ucode_start_addr=
;
 		break;
 	case TA_FW_TYPE_PSP_RAS:
-		psp->ras_context.context.bin_desc.feature_version   =3D le32_to_cpu(desc=
->fw_version);
+		psp->ras_context.context.bin_desc.fw_version        =3D le32_to_cpu(desc=
->fw_version);
 		psp->ras_context.context.bin_desc.size_bytes        =3D le32_to_cpu(desc=
->size_bytes);
 		psp->ras_context.context.bin_desc.start_addr        =3D ucode_start_addr=
;
 		break;
 	case TA_FW_TYPE_PSP_HDCP:
-		psp->hdcp_context.context.bin_desc.feature_version  =3D le32_to_cpu(desc=
->fw_version);
+		psp->hdcp_context.context.bin_desc.fw_version       =3D le32_to_cpu(desc=
->fw_version);
 		psp->hdcp_context.context.bin_desc.size_bytes       =3D le32_to_cpu(desc=
->size_bytes);
 		psp->hdcp_context.context.bin_desc.start_addr       =3D ucode_start_addr=
;
 		break;
 	case TA_FW_TYPE_PSP_DTM:
-		psp->dtm_context.context.bin_desc.feature_version  =3D le32_to_cpu(desc-=
>fw_version);
+		psp->dtm_context.context.bin_desc.fw_version       =3D le32_to_cpu(desc-=
>fw_version);
 		psp->dtm_context.context.bin_desc.size_bytes       =3D le32_to_cpu(desc-=
>size_bytes);
 		psp->dtm_context.context.bin_desc.start_addr       =3D ucode_start_addr;
 		break;
 	case TA_FW_TYPE_PSP_RAP:
-		psp->rap_context.context.bin_desc.feature_version  =3D le32_to_cpu(desc-=
>fw_version);
+		psp->rap_context.context.bin_desc.fw_version       =3D le32_to_cpu(desc-=
>fw_version);
 		psp->rap_context.context.bin_desc.size_bytes       =3D le32_to_cpu(desc-=
>size_bytes);
 		psp->rap_context.context.bin_desc.start_addr       =3D ucode_start_addr;
 		break;
 	case TA_FW_TYPE_PSP_SECUREDISPLAY:
-		psp->securedisplay_context.context.bin_desc.feature_version =3D
+		psp->securedisplay_context.context.bin_desc.fw_version =3D
 			le32_to_cpu(desc->fw_version);
 		psp->securedisplay_context.context.bin_desc.size_bytes =3D
 			le32_to_cpu(desc->size_bytes);
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ucode.c b/drivers/gpu/drm/am=
d/amdgpu/amdgpu_ucode.c
index 920c4f6ac9146f..ca335050261891 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ucode.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ucode.c
@@ -527,8 +527,8 @@ FW_VERSION_ATTR(mec_fw_version, 0444, gfx.mec_fw_versio=
n);  FW_VERSION_ATTR(mec2_fw_version, 0444, gfx.mec2_fw_version);  FW_VERSI=
ON_ATTR(sos_fw_version, 0444, psp.sos.fw_version);  FW_VERSION_ATTR(asd_fw_=
version, 0444, psp.asd_context.bin_desc.fw_version);
-FW_VERSION_ATTR(ta_ras_fw_version, 0444, psp.ras_context.context.bin_desc.=
feature_version);
-FW_VERSION_ATTR(ta_xgmi_fw_version, 0444, psp.xgmi_context.context.bin_des=
c.feature_version);
+FW_VERSION_ATTR(ta_ras_fw_version, 0444,=20
+psp.ras_context.context.bin_desc.fw_version);
+FW_VERSION_ATTR(ta_xgmi_fw_version, 0444,=20
+psp.xgmi_context.context.bin_desc.fw_version);
 FW_VERSION_ATTR(smc_fw_version, 0444, pm.fw_version);  FW_VERSION_ATTR(sdm=
a_fw_version, 0444, sdma.instance[0].fw_version);  FW_VERSION_ATTR(sdma2_fw=
_version, 0444, sdma.instance[1].fw_version); diff --git a/drivers/gpu/drm/=
amd/amdgpu/amdgpu_virt.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c
index 88c4177b708ac8..8899c219defab8 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c
@@ -535,9 +535,9 @@ static void amdgpu_virt_populate_vf2pf_ucode_info(struc=
t amdgpu_device *adev)
 	POPULATE_UCODE_INFO(vf2pf_info, AMD_SRIOV_UCODE_ID_ASD,
 			    adev->psp.asd_context.bin_desc.fw_version);
 	POPULATE_UCODE_INFO(vf2pf_info, AMD_SRIOV_UCODE_ID_TA_RAS,
-			    adev->psp.ras_context.context.bin_desc.feature_version);
+			    adev->psp.ras_context.context.bin_desc.fw_version);
 	POPULATE_UCODE_INFO(vf2pf_info, AMD_SRIOV_UCODE_ID_TA_XGMI,
-			    adev->psp.xgmi_context.context.bin_desc.feature_version);
+			    adev->psp.xgmi_context.context.bin_desc.fw_version);
 	POPULATE_UCODE_INFO(vf2pf_info, AMD_SRIOV_UCODE_ID_SMC,      adev->pm.fw_=
version);
 	POPULATE_UCODE_INFO(vf2pf_info, AMD_SRIOV_UCODE_ID_SDMA,     adev->sdma.i=
nstance[0].fw_version);
 	POPULATE_UCODE_INFO(vf2pf_info, AMD_SRIOV_UCODE_ID_SDMA2,    adev->sdma.i=
nstance[1].fw_version);
diff --git a/drivers/gpu/drm/amd/amdgpu/psp_v10_0.c b/drivers/gpu/drm/amd/a=
mdgpu/psp_v10_0.c
index 59644015dfc3ee..ed2293686f0de3 100644
--- a/drivers/gpu/drm/amd/amdgpu/psp_v10_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/psp_v10_0.c
@@ -84,7 +84,7 @@ static int psp_v10_0_init_microcode(struct psp_context *p=
sp)
=20
 		ta_hdr =3D (const struct ta_firmware_header_v1_0 *)
 				 adev->psp.ta_fw->data;
-		adev->psp.hdcp_context.context.bin_desc.feature_version =3D
+		adev->psp.hdcp_context.context.bin_desc.fw_version =3D
 			le32_to_cpu(ta_hdr->hdcp.fw_version);
 		adev->psp.hdcp_context.context.bin_desc.size_bytes =3D
 			le32_to_cpu(ta_hdr->hdcp.size_bytes);
@@ -92,7 +92,7 @@ static int psp_v10_0_init_microcode(struct psp_context *p=
sp)
 			(uint8_t *)ta_hdr +
 			le32_to_cpu(ta_hdr->header.ucode_array_offset_bytes);
=20
-		adev->psp.dtm_context.context.bin_desc.feature_version =3D
+		adev->psp.dtm_context.context.bin_desc.fw_version =3D
 			le32_to_cpu(ta_hdr->dtm.fw_version);
 		adev->psp.dtm_context.context.bin_desc.size_bytes =3D
 			le32_to_cpu(ta_hdr->dtm.size_bytes);
@@ -100,7 +100,7 @@ static int psp_v10_0_init_microcode(struct psp_context =
*psp)
 			(uint8_t *)adev->psp.hdcp_context.context.bin_desc.start_addr +
 			le32_to_cpu(ta_hdr->dtm.offset_bytes);
=20
-		adev->psp.securedisplay_context.context.bin_desc.feature_version =3D
+		adev->psp.securedisplay_context.context.bin_desc.fw_version =3D
 			le32_to_cpu(ta_hdr->securedisplay.fw_version);
 		adev->psp.securedisplay_context.context.bin_desc.size_bytes =3D
 			le32_to_cpu(ta_hdr->securedisplay.size_bytes);
diff --git a/drivers/gpu/drm/amd/amdgpu/psp_v11_0.c b/drivers/gpu/drm/amd/a=
mdgpu/psp_v11_0.c
index 21a325ea49cb30..2176ef85f137e6 100644
--- a/drivers/gpu/drm/amd/amdgpu/psp_v11_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/psp_v11_0.c
@@ -151,7 +151,7 @@ static int psp_v11_0_init_microcode(struct psp_context =
*psp)
 				goto out2;
=20
 			ta_hdr =3D (const struct ta_firmware_header_v1_0 *)adev->psp.ta_fw->dat=
a;
-			adev->psp.xgmi_context.context.bin_desc.feature_version =3D
+			adev->psp.xgmi_context.context.bin_desc.fw_version =3D
 				le32_to_cpu(ta_hdr->xgmi.fw_version);
 			adev->psp.xgmi_context.context.bin_desc.size_bytes =3D
 				le32_to_cpu(ta_hdr->xgmi.size_bytes);
@@ -159,7 +159,7 @@ static int psp_v11_0_init_microcode(struct psp_context =
*psp)
 				(uint8_t *)ta_hdr +
 				le32_to_cpu(ta_hdr->header.ucode_array_offset_bytes);
 			adev->psp.ta_fw_version =3D le32_to_cpu(ta_hdr->header.ucode_version);
-			adev->psp.ras_context.context.bin_desc.feature_version =3D
+			adev->psp.ras_context.context.bin_desc.fw_version =3D
 				le32_to_cpu(ta_hdr->ras.fw_version);
 			adev->psp.ras_context.context.bin_desc.size_bytes =3D
 				le32_to_cpu(ta_hdr->ras.size_bytes);
@@ -192,7 +192,7 @@ static int psp_v11_0_init_microcode(struct psp_context =
*psp)
 				goto out2;
=20
 			ta_hdr =3D (const struct ta_firmware_header_v1_0 *)adev->psp.ta_fw->dat=
a;
-			adev->psp.hdcp_context.context.bin_desc.feature_version =3D
+			adev->psp.hdcp_context.context.bin_desc.fw_version =3D
 				le32_to_cpu(ta_hdr->hdcp.fw_version);
 			adev->psp.hdcp_context.context.bin_desc.size_bytes =3D
 				le32_to_cpu(ta_hdr->hdcp.size_bytes);
@@ -203,7 +203,7 @@ static int psp_v11_0_init_microcode(struct psp_context =
*psp)
=20
 			adev->psp.ta_fw_version =3D le32_to_cpu(ta_hdr->header.ucode_version);
=20
-			adev->psp.dtm_context.context.bin_desc.feature_version =3D
+			adev->psp.dtm_context.context.bin_desc.fw_version =3D
 				le32_to_cpu(ta_hdr->dtm.fw_version);
 			adev->psp.dtm_context.context.bin_desc.size_bytes =3D
 				le32_to_cpu(ta_hdr->dtm.size_bytes);
diff --git a/drivers/gpu/drm/amd/amdgpu/psp_v12_0.c b/drivers/gpu/drm/amd/a=
mdgpu/psp_v12_0.c
index 281bc4d7f0a1aa..a2588200ea5809 100644
--- a/drivers/gpu/drm/amd/amdgpu/psp_v12_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/psp_v12_0.c
@@ -84,7 +84,7 @@ static int psp_v12_0_init_microcode(struct psp_context *p=
sp)
=20
 		ta_hdr =3D (const struct ta_firmware_header_v1_0 *)
 				 adev->psp.ta_fw->data;
-		adev->psp.hdcp_context.context.bin_desc.feature_version =3D
+		adev->psp.hdcp_context.context.bin_desc.fw_version =3D
 			le32_to_cpu(ta_hdr->hdcp.fw_version);
 		adev->psp.hdcp_context.context.bin_desc.size_bytes =3D
 			le32_to_cpu(ta_hdr->hdcp.size_bytes);
@@ -94,7 +94,7 @@ static int psp_v12_0_init_microcode(struct psp_context *p=
sp)
=20
 		adev->psp.ta_fw_version =3D le32_to_cpu(ta_hdr->header.ucode_version);
=20
-		adev->psp.dtm_context.context.bin_desc.feature_version =3D
+		adev->psp.dtm_context.context.bin_desc.fw_version =3D
 			le32_to_cpu(ta_hdr->dtm.fw_version);
 		adev->psp.dtm_context.context.bin_desc.size_bytes =3D
 			le32_to_cpu(ta_hdr->dtm.size_bytes);
--
2.17.1
