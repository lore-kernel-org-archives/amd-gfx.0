Return-Path: <SRS0=DoF4=HY=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A29C8C433DB
	for <amd-gfx@archiver.kernel.org>; Mon, 22 Feb 2021 08:04:37 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0AF2964E44
	for <amd-gfx@archiver.kernel.org>; Mon, 22 Feb 2021 08:04:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0AF2964E44
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 76C1D6E462;
	Mon, 22 Feb 2021 08:04:36 +0000 (UTC)
Received: from NAM02-BL2-obe.outbound.protection.outlook.com
 (mail-eopbgr750040.outbound.protection.outlook.com [40.107.75.40])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3F6EA6E462
 for <amd-gfx@lists.freedesktop.org>; Mon, 22 Feb 2021 08:04:34 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EAL9gBdC44bz9hHmzn1rEY2s6XuvaeBrRQHmM1r4AoeNTjYMWzd4vHyijtqq2kzkGd9rfE5hLGzqy5oh7NnZhqSrvabjBRyBtqn0qrWDpB9ru8XVrPRQCau+QQt2oC67ghmtdmWNcmWDmWgRYgVaTKAcSHn7glT59ta9pRwYN6/kWDF8er40b+fWouVY4h9UpfnylN1DXTsaruWWtSkNjKSSdXBCxwg0IL1Y36xaEb9sfXgo5OD0dTiFGbTu6ZyyzUyR6uxF1tjx49Zs7qXFkULzqCTuzYmFH7Afeg/xScp4rewwyrwio1ehySh4VrnMbZDLSdk4mGayOlILi+g8Aw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NxUiqUBAnsMgO6RMtNG0kaGu2/mlLcO2Wr+WA5Q2YdI=;
 b=c0fD8es2ST3rBDhhdWX2h4OvPcA+YY1k+66WBc/oVBFAzzZ1BF7lnBD6m/KO8ryYwW6mySmEWoQNMivFs+GVVwkWyQ/XB2LcMgnvvoc5P7Jy9mFl3FPgKSFTCdZY46raT6JaqSGT87WBEFI3SswFXHgIeYbuCfI6Ng6w2e07s5ADlcYC5vnafiqqX6wx8UPDmumaBOnck+Vlo4Mk/hKsxObLo8kYwXGndPtLFRmfkt/PQzjjrWXvfp/UtpHKUxRFZhptTxKiPZXKdGyyzpII8qT3BxGP5fzdY17bgs3ummDAIAOO1gc2qbqzkHrSbNNYLDrceOT30dghGTLofgvzSA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NxUiqUBAnsMgO6RMtNG0kaGu2/mlLcO2Wr+WA5Q2YdI=;
 b=yMmjiUTgqElS4rutyz4BasbVywhNzJMdZavOdyczGhQq/eJVwqExoyEqqHleMarGXKjrltMl9RXVd7bdVIUCQ6Y/PFO5W503OWdT/GmeVydTs/izaKVv+mLDgb7hND3y5h1KaccDOoQpDvqzPHY3jYz32VwWHQk3RppALJPuxpM=
Received: from CY4PR12MB1287.namprd12.prod.outlook.com (2603:10b6:903:40::8)
 by CY4PR1201MB2551.namprd12.prod.outlook.com (2603:10b6:903:d9::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3868.29; Mon, 22 Feb
 2021 08:04:31 +0000
Received: from CY4PR12MB1287.namprd12.prod.outlook.com
 ([fe80::992b:4e6b:afe3:ff25]) by CY4PR12MB1287.namprd12.prod.outlook.com
 ([fe80::992b:4e6b:afe3:ff25%2]) with mapi id 15.20.3868.032; Mon, 22 Feb 2021
 08:04:31 +0000
From: "Chen, Guchun" <Guchun.Chen@amd.com>
To: "Quan, Evan" <Evan.Quan@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amd/pm: correct Arcturus mmTHM_BACO_CNTL register
 address
Thread-Topic: [PATCH] drm/amd/pm: correct Arcturus mmTHM_BACO_CNTL register
 address
Thread-Index: AQHXCM5GBIoGA7X3HkuvxFFs9aXsY6pj0Pdg
Date: Mon, 22 Feb 2021 08:04:31 +0000
Message-ID: <CY4PR12MB1287E96910026685CAA4F982F1819@CY4PR12MB1287.namprd12.prod.outlook.com>
References: <20210222035301.1280592-1-evan.quan@amd.com>
In-Reply-To: <20210222035301.1280592-1-evan.quan@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Enabled=true;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_SetDate=2021-02-22T08:04:28Z; 
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Method=Privileged;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Name=Public_0;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_ActionId=3aa6fd57-e3e4-4ea9-8fec-1aaa68aed136;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_ContentBits=1
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [180.167.199.189]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 205283ea-e4e9-4ea7-8206-08d8d7087bed
x-ms-traffictypediagnostic: CY4PR1201MB2551:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <CY4PR1201MB2551C7827FE61E50C713B596F1819@CY4PR1201MB2551.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:185;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: qFKYK5+z/J7jiDxfa3yKLrJd+aRKVpB8MsFsoCKQOFjsV/V0pOoxzC3cCNhka8RYgRz0KfvRBQ3K6yA9fI5HEXa73wZ0gAfcaL+tl1agL2wgjuHw7uMx+uYAvRR729hWFJyUGkyISPKMtmdLP7xTdBYopVtWWMF2K0xy1dRM6KaKHEqrB2BY19O2xKPMrB/BMMNEd/utWASnUrFKpD8pImiQDGBupQMK1b9FTuKVwXLtvamIkb+vRPu9m1D1rtH8wkbrOJFeo18YpTpc45G/CPOb+r8QcZai3UsPZ7gu0PXMmMf22LS8PowLjwYLK3kEPCQpd9jvLuwKzMDJCj3MCGN4+9h53Ej/coCtZqe9mMoa2QnI3bsmWEy/rPScdoF3ea49o/WTMnzHIX7DiL8DKd1/ZR5M6OD+CXtMf+IKj9gljemrq2QeRqWRZi6G1HX5j+4HLKikOugc/bYZb858i2odV9oqkTaBVOL4sgtO6JFqjwW9Uf6CwJyipA0K380zwRhKkQnnwAjSXl1TfpxAbAARh8ifCApr5zIiNEQ9KhaeNwMQGFJ+5agT5Dkvqjas
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CY4PR12MB1287.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(136003)(366004)(396003)(39860400002)(376002)(346002)(966005)(8676002)(45080400002)(8936002)(71200400001)(33656002)(186003)(26005)(4326008)(86362001)(478600001)(53546011)(2906002)(76116006)(66946007)(66556008)(110136005)(83380400001)(6506007)(316002)(5660300002)(52536014)(64756008)(66446008)(66476007)(19627235002)(54906003)(7696005)(55016002)(9686003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?9kRlf2mf4dfRa00ZajJooJQJKgIsiknfJt8JCISKcYrzkG08tgKQGg0Fxe5x?=
 =?us-ascii?Q?v36dVSXIyTGl/7EvNRc+GX9tSUVCnmohYl7HadOeo2TTM+xOV7edBl8BiQQ/?=
 =?us-ascii?Q?cM1JB/Cn12QSelfEIqh/k5ROGHN0P1RDc9xNJTNNNDkPQVx03kxHcJ/PpsKL?=
 =?us-ascii?Q?PEax5HpJeZD0aac+U4vw31DD9wJLTjTMr65oBMGAvZbx/ygLYaYOsR2504XQ?=
 =?us-ascii?Q?gBjdlIkHGkoqG83a0+NYoZX8y/ZPA03yAl4gaDu9qrwVmSpL1wdWGxx2tGJK?=
 =?us-ascii?Q?f/qs6ZjpUFDKQJ/F5ksdtlBazsv/ehWQIwdnzTWzqlx6q4oUyGLzx+S3EN44?=
 =?us-ascii?Q?KPvhwWLkdvHHAOMiJiwFzcfk7u52r4NrVJdmgL+i95HMf/9MOrxDT9KlKytP?=
 =?us-ascii?Q?+iK6WUXket1lD9V+EX95hDAbysDKUnq1z3uI3Gp7JnHSXtizC8Xd5noCMolU?=
 =?us-ascii?Q?9X8oF8I2+clJC+KYZ/80e1sRVEakj+9VMgfpvjx09JsaYEac2rDjTNFQLZ64?=
 =?us-ascii?Q?477KG/2tC5inxBJc1RLuubbryKJdwG6jC4ndfCI2ufb8CamI3gZaS6qLNpHk?=
 =?us-ascii?Q?8u5sT/vNpvhLZjf0pz221RK/z2En9yW61uo6FeerY2rgoS4Fra6mW12Mv+Tr?=
 =?us-ascii?Q?XtJNnC3a+Ryg+/dzxc1F8szU62HK2Shqsoleagx71I+tR7n8XpTB3xefRUVm?=
 =?us-ascii?Q?9sCkD29lXJelsAo1i+lx/Fu1Fl5RBE9v3RpvL73VKexNybud8CKwfsH/UH7I?=
 =?us-ascii?Q?ANm5k2aYfp9s7n9R6qGtjUJtuk33Z/YWC/HUe2yhW6DEj2mocbflYTVE6rII?=
 =?us-ascii?Q?KS2Lm1zoz4MvmGwhHR0QLzO9bMYR0WoPEs0Y5kskFhK2YpLdS0Tuj67UunEY?=
 =?us-ascii?Q?JxNgusdXpG4oALckkw/Q8Z6YYiCAgrf9aSkWefdQ5e747uVx/vZ7ZQj/cxIM?=
 =?us-ascii?Q?23IunIYCZz0osEhC3sOmx7c9mEnJ8SCGemDbalo4cJ+LuOFOI0B4iy/nvtS2?=
 =?us-ascii?Q?9BbBTweUJF+zB9usrFsdvYIepckVQ0YJmM/jkkXyR86XTaj1qTZdfJE7DmqM?=
 =?us-ascii?Q?/RgY4F96odSrvawgoAOYi2MH/BWfJp2bo8+MF+6eNLg8FIYGHb71ZqWKOIGi?=
 =?us-ascii?Q?1SK4dt9os9oiApc6MrTDKVUrp2gHhSyWGHYBTmN2tWs0jb9qYcZuVcRzUbvd?=
 =?us-ascii?Q?DQfgqGUxAxrrHwFSkXRfxfpCf6cw+vHasu8f1+63LMARU2ZucjVLKXSokiOo?=
 =?us-ascii?Q?tN4x4oRin6D3JZ3aLjwVwUkoGFZyRMPQcsDOtfWkRtP9CSxpTegzQZjUECeu?=
 =?us-ascii?Q?Vt28hBk7rJARuFmyrwb97BYr?=
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY4PR12MB1287.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 205283ea-e4e9-4ea7-8206-08d8d7087bed
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Feb 2021 08:04:31.0828 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: kG/GeUP2EvKSxAb5MjplLoK8YWfV8NbaOX8gIthxGLgOBCMbKVDNuIKKLTsuggboZnSRWq2GeQ44q09mMNEwZw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR1201MB2551
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Public Use]

Acked-by: Guchun Chen <guchun.chen@amd.com>

Regards,
Guchun

-----Original Message-----
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Evan Quan
Sent: Monday, February 22, 2021 11:53 AM
To: amd-gfx@lists.freedesktop.org
Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Quan, Evan <Evan.Quan@amd.com>
Subject: [PATCH] drm/amd/pm: correct Arcturus mmTHM_BACO_CNTL register address

Arcturus has a different register address from other SMU V11 ASICs.

Change-Id: I2bb9b4f00ebd563880ed3d3687e8f24124213150
Signed-off-by: Evan Quan <evan.quan@amd.com>
---
 drivers/gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c | 15 ++++++++++++---
 1 file changed, 12 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c b/drivers/gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c
index b0922b221bf1..74758fb10de2 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c
@@ -78,6 +78,9 @@ MODULE_FIRMWARE("amdgpu/dimgrey_cavefish_smc.bin");
 #define PCIE_LC_SPEED_CNTL__LC_CURRENT_DATA_RATE_MASK 0xC000  #define PCIE_LC_SPEED_CNTL__LC_CURRENT_DATA_RATE__SHIFT 0xE
 
+#define mmTHM_BACO_CNTL_ARCT			0xA7
+#define mmTHM_BACO_CNTL_ARCT_BASE_IDX		0
+
 static int link_width[] = {0, 1, 2, 4, 8, 12, 16};  static int link_speed[] = {25, 50, 80, 160};
 
@@ -1532,9 +1535,15 @@ int smu_v11_0_baco_set_state(struct smu_context *smu, enum smu_baco_state state)
 			break;
 		default:
 			if (!ras || !ras->supported) {
-				data = RREG32_SOC15(THM, 0, mmTHM_BACO_CNTL);
-				data |= 0x80000000;
-				WREG32_SOC15(THM, 0, mmTHM_BACO_CNTL, data);
+				if (adev->asic_type == CHIP_ARCTURUS) {
+					data = RREG32_SOC15(THM, 0, mmTHM_BACO_CNTL_ARCT);
+					data |= 0x80000000;
+					WREG32_SOC15(THM, 0, mmTHM_BACO_CNTL_ARCT, data);
+				} else {
+					data = RREG32_SOC15(THM, 0, mmTHM_BACO_CNTL);
+					data |= 0x80000000;
+					WREG32_SOC15(THM, 0, mmTHM_BACO_CNTL, data);
+				}
 
 				ret = smu_cmn_send_smc_msg_with_param(smu, SMU_MSG_EnterBaco, 0, NULL);
 			} else {
--
2.29.0

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Flists.freedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;data=04%7C01%7Cguchun.chen%40amd.com%7C8f8203d939934ef80c8908d8d6e567e4%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637495628072369582%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C1000&amp;sdata=7fn74dklamcK9F8J%2BCeVsqxkrfOvCwVCKUoMKg7F0c4%3D&amp;reserved=0
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
