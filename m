Return-Path: <SRS0=drzA=JM=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11925C433B4
	for <amd-gfx@archiver.kernel.org>; Thu, 15 Apr 2021 02:41:04 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B092B611AB
	for <amd-gfx@archiver.kernel.org>; Thu, 15 Apr 2021 02:41:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B092B611AB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6DE8A6E4E8;
	Thu, 15 Apr 2021 02:41:03 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2071.outbound.protection.outlook.com [40.107.94.71])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 13DBE6E4E8
 for <amd-gfx@lists.freedesktop.org>; Thu, 15 Apr 2021 02:41:02 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LOqTlkyQh4jfUPvX+tjwQRnb2+vizGlsFUAtGcq32Y8x1orD38w6su6YAG+aaTMl2nNsdkB2jktSe6R1kA30j2OcY9X8LUtM0m6ZLrbp/2d/3W46diDxN1TpCJt0YfrS4x/1wD8o3gid4F9OkXzZvjsMoGAxW8KSw5johQdb+QhKrNew+DoA5yUssw+UG+csPpkBsJozbjkCsiHXb0/KHbENn/oPZrMyty8bfi8hHzkksch6u9I5MEuTdy/brLiy472w2QrRI763zdYP6idF1b0AkZydTHy9ni3PbImQmjyg3tamtBCmfMcQ2T+DRvtZ9Ki2U/pIzo2E+fTr0IscvA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FmKNd1zABU8ZUd4dKdGV9ZTjgNIZt5Zp32nXvf4EFDY=;
 b=nZYqO2wxzzyr7J/qtYHwdamHOl9+8nVFNrTx6iyWj7YLSc+4ibSLVBpdWy7OydiumGDOH4Iw7538uGQ0HmicJxrNEY6sHT5HkBZv977vZNzXRCCe8YLCC04psCv4dpgjXPUc48GQlArw6Tm3NmpYZy+cRn4Z6TOyQst5n7uKHV94YDm0dpQ5ri3KfuC8h3SfKu01ItmfVwvoFZqtA5YPwn/JDd6Nd3vtxIv2SJ6zawruDDXGdR92RCYZF2YvXmk5Lu5bRKbULpWXAfA5aDR2YB3lONTvG7n8Pn0oUhJbLGI4RWQQPErrdP1ATH6cegn2sLzfq1WhfwRra8J+VPGN9g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FmKNd1zABU8ZUd4dKdGV9ZTjgNIZt5Zp32nXvf4EFDY=;
 b=NB+9V6ZZb5Ul2gYxW7yywZcbZ7wzEEfA4FMtRWX4hsvj9LZd9LHGiiQqdo5Gz66RDexH3OUthX2L0KkJG9QpcLyxIg1gqBAPw8cyFR4KozabTKjUUvU+jbGDPAIRLOAa8HSt2NsjniZ97W9QaJcrcu+2S5CSf7Fk2vHNdqUd+jg=
Received: from BN9PR12MB5368.namprd12.prod.outlook.com (13.101.158.248) by
 BN9PR12MB5289.namprd12.prod.outlook.com (13.101.158.146) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4042.18; Thu, 15 Apr 2021 02:40:59 +0000
Received: from BN9PR12MB5368.namprd12.prod.outlook.com
 ([fe80::1ef:6c3d:170c:8328]) by BN9PR12MB5368.namprd12.prod.outlook.com
 ([fe80::1ef:6c3d:170c:8328%6]) with mapi id 15.20.4042.016; Thu, 15 Apr 2021
 02:40:59 +0000
From: "Zhang, Hawking" <Hawking.Zhang@amd.com>
To: "Greathouse, Joseph" <Joseph.Greathouse@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amdgpu: Copy MEC FW version to MEC2 if we skipped
 loading MEC2
Thread-Topic: [PATCH] drm/amdgpu: Copy MEC FW version to MEC2 if we skipped
 loading MEC2
Thread-Index: AQHXMYd5Rfnv5koULkWjmCkn+mUIcqq03lhg
Date: Thu, 15 Apr 2021 02:40:59 +0000
Message-ID: <BN9PR12MB5368CBA8A77444B9355439C6FC4D9@BN9PR12MB5368.namprd12.prod.outlook.com>
References: <20210414233933.266833-1-Joseph.Greathouse@amd.com>
In-Reply-To: <20210414233933.266833-1-Joseph.Greathouse@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Enabled=true;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_SetDate=2021-04-15T02:40:57Z; 
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Method=Privileged;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Name=Public_0;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_ActionId=ab92be06-cadf-46fe-8f89-0f8cd099a1d9;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_ContentBits=1
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [180.167.199.189]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 0e809ac9-71c8-40d3-2136-08d8ffb7e73c
x-ms-traffictypediagnostic: BN9PR12MB5289:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BN9PR12MB52896673036829BDFE5DF82EFC4D9@BN9PR12MB5289.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7219;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Q+F/6WIyh2sjXGrrOiVV9q/cRt1TYTdqmG/+SbyOAiWYhziFAUfjzfE6/PvbridU6GCl6A2/SdbywcgqRUIFpeY+OijiD1OUAVSs3kJe9Vf8OKquUYBviswnGd+VI6Int/g9IXFjVz6KORLeLpeu+XAOuEXfpTB/sbHPzZoV6BTEJgfaqLR8EjB98oF3d7z9Xz5mbo1rk+3Pf3bVmH59VGxulWMcW0l0skCEWxvsiWQ0DW/yNgsUSGIQuftUqQmSz9Mm7QXJbuzDAGeKR3mJ0rRWv3wacnK5aEO9a57COXvTbrCpiovorDXPbMkv9H63nEiATw5Ye1Ks8CviMvEfpfSiAai3iKK8SJiUmXujgcAKyfkCUrxjd6t6mOq91zp5qMRs4zAM3ZQQu+lqNDQd1wjdTzdSZp4oUvJcfNQNeZFTjmN2YnfTfzFLsSKK7aggbQrXi0A25ekHXBvlr/FokVuRxZSlb90d3uzk7m7/weU5TrvqF5pThWTAJSGD24C1/vqq6xxelP4YUriC3SoOpVi7ffsTkXCBNhWCLRHONBHzHQ2MVRO8Zuc1PseS/39FZJB6vph/PA7aSXV24Q5Yo88d3eWEtmW23/zB/rWo+W/ZvqT6L0wbIwvs3fcr5hvKi6KHXzAg5Ma1+7d/5mEPYg==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5368.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(396003)(366004)(39860400002)(346002)(136003)(376002)(66476007)(66946007)(66556008)(64756008)(66446008)(76116006)(2906002)(33656002)(45080400002)(53546011)(6506007)(83380400001)(7696005)(8936002)(478600001)(26005)(186003)(966005)(55016002)(110136005)(8676002)(86362001)(4326008)(71200400001)(316002)(9686003)(38100700002)(122000001)(5660300002)(52536014);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?MM3r7fhHAYng5QWgkZJ7L6i8/C3HWANq5rzazRA8SK/p4OMpVGuY3vkyJQYP?=
 =?us-ascii?Q?MK6nbp+W2tzEHstcBhCybgoQtoXRNxCi04kjAbwpBw5IDOPBusKgkod86mVK?=
 =?us-ascii?Q?eWkgTDJqmYwPpooIJznBgc876fl6GHJEVaoO8sRuB137x6J1WkW6h41Aw4ek?=
 =?us-ascii?Q?SQ2y83PyD8Vi6ClhgK5yIJb6OMpNeSkIcflfVeaDTtV6lrFW5A30F512567x?=
 =?us-ascii?Q?5+MWqGInpQmWyNskaGy5nsvQbjXwsY5vjClIibNc240267nMUqr0ZMHcw0Ah?=
 =?us-ascii?Q?4Gn2aYBM4ypO+vxeDeYpqRcz9kigCRFKIXhRk688FO3+H2SNOah0l6LDAgLx?=
 =?us-ascii?Q?ruehGZxDe/tH+Fi2owWjoJklPrB57KyhaB5+uzmmVt3X1a0m/Q/NWQ7nHmzD?=
 =?us-ascii?Q?Ejwf0NUnRiGv2nCdUe3oDgB6XI7MZvlhAeaaVFIzw6++Uhca9dyUJoxwfXRe?=
 =?us-ascii?Q?egTiz1ia2+EmfO7XqNZ3qNnZmjQOb+4ANc+6RLRT42mw2TwsnRaxgE8F/3yI?=
 =?us-ascii?Q?0DkAESyGT+Mffal5LMaKrFTzROgJNgdzygyUYS8LFLVianYNRgYzNMXSmlxZ?=
 =?us-ascii?Q?JMfVnBdpNJMEw/8A81gzEUZ9OU4GELpZ4Q2NY43h5eSQzYXw0u8U3ZBHzt1b?=
 =?us-ascii?Q?XxJPSB9qHtfYWyw0kQtGDBvLAH3boSDGDEpc17mb0dB9dJSMJARLxHkZgvHH?=
 =?us-ascii?Q?+H/44of0PMvR1lwuAK3nVv94d1icPiNBqFrrD12EQlIn+SDWGVzdPTSYbNgE?=
 =?us-ascii?Q?+4xWDFge7w//8yujRJnK7mRinq+yzOaUpOAs6XHoWmoDH1z5Er9XonTMxxSb?=
 =?us-ascii?Q?bW4Qj/3GUktXCqZVuV7mUGF9B1gdnvNbaUGkypX/GFLHBxV6rscl0NlLV197?=
 =?us-ascii?Q?U6R2WIiCfEjL8fZKHOyEt8ZtCn+RImJibnrg75zHHOsplnQ0pVZU+8ntLslI?=
 =?us-ascii?Q?GKE4ilv69GIDNcdaZau1K+CUQcL8lsf0t8ArP2tD7kUd1YltDK8vy7du+525?=
 =?us-ascii?Q?n1EAQIoVyv++YaeIrkt9ngh8f7myqakLTEPgTEZq11tiOawmLy3Ri+Us9d99?=
 =?us-ascii?Q?bJtKW0VNOeu9rsHbNNPAKkoPHHh84xyI93RNfpqzyNKH+tEKOw5XF/a0+gbp?=
 =?us-ascii?Q?dyy4qTz53aOI2wkuX3sSfmrBACx2fqXL7/aYIBZsCaoh0pUWo1mM9/vbcFT1?=
 =?us-ascii?Q?UtNPuSg1oQ7oeXfvg9W2SAHRaII81Nu/WtCUI0+TyApF/A4Tze2zT/UvrcGW?=
 =?us-ascii?Q?0vHe1iVwxQ7ad8JOfVlYJjJYsSdHUKAEZOW2qIc9KunDf94PUrbIq0zjNoko?=
 =?us-ascii?Q?2s6cEqYrl8LddeRPyTDZygJM?=
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5368.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0e809ac9-71c8-40d3-2136-08d8ffb7e73c
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Apr 2021 02:40:59.4698 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: vd5jL1Aym5ZXC3lRu/CpL2vZMKSIbHJ6ATyg3Ad/oj2LiEGAeVMe/pp77irBaLB2VPQBYTOBioI4VRNb7+pKrA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR12MB5289
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
Cc: "Greathouse, Joseph" <Joseph.Greathouse@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Public Use]

Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>

Regards,
Hawking
-----Original Message-----
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Joseph Greathouse
Sent: Thursday, April 15, 2021 07:40
To: amd-gfx@lists.freedesktop.org
Cc: Greathouse, Joseph <Joseph.Greathouse@amd.com>
Subject: [PATCH] drm/amdgpu: Copy MEC FW version to MEC2 if we skipped loading MEC2

If we skipped loading MEC2 firmware separately from MEC, then
MEC2 will be running the same firmware image. Copy the MEC version and feature numbers into MEC2 version and feature numbers. This is needed for things like GWS support, where we rely on knowing what version of firmware is running on MEC2. Leaving these MEC2 entries blank breaks our ability to version-check enables and workarounds.

Signed-off-by: Joseph Greathouse <Joseph.Greathouse@amd.com>
Change-Id: Id6f672fc69452abd6ff41821a5f2240037048a6f
---
 drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
index 06811a1f4625..a078a38c2cee 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
@@ -1587,6 +1587,9 @@ static int gfx_v9_0_init_cp_compute_microcode(struct amdgpu_device *adev,
 			err = 0;
 			adev->gfx.mec2_fw = NULL;
 		}
+	} else {
+		adev->gfx.mec2_fw_version = adev->gfx.mec_fw_version;
+		adev->gfx.mec2_feature_version = adev->gfx.mec_feature_version;
 	}
 
 	if (adev->firmware.load_type == AMDGPU_FW_LOAD_PSP) {
--
2.20.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Flists.freedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;data=04%7C01%7Chawking.zhang%40amd.com%7C7d6c47df75ed45ba91de08d8ff9e9ae7%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637540403966327155%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C1000&amp;sdata=ikRLjhzcWaHCAGIwFqjILjRYw7Dy5xUsZBECmyY%2FYOI%3D&amp;reserved=0
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
