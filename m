Return-Path: <SRS0=mZ+C=IR=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C255BC433DB
	for <amd-gfx@archiver.kernel.org>; Fri, 19 Mar 2021 02:06:51 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 79CE964F11
	for <amd-gfx@archiver.kernel.org>; Fri, 19 Mar 2021 02:06:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 79CE964F11
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F2BAC6E2C8;
	Fri, 19 Mar 2021 02:06:50 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2040.outbound.protection.outlook.com [40.107.93.40])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AC0346E2C8
 for <amd-gfx@lists.freedesktop.org>; Fri, 19 Mar 2021 02:06:49 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oP6CesRFxlDZijehmo8PFGiMcfCDMPfeTEGpu6dnflZpE+2Vv/DSekbWhkfwBi/vdRIYSDsI7hBZsf6qi+20HAP+Lb/cFouUve20jzmn8DFHM9sPPazR3t6YF8guYQEleD/5ENRvQmBftHwRecMa9I3OQXaeuuposI8OQriWAQwe2i3ND3tHEZLAzkCK8OVkHsWvqXFY2Em059ud2C4tPkwgkPMuZ0Y1qwJS39Cl3nP9C02RflPYGTD36C7v7cv7ticZ9zTFOIcPellJTFt5oXRYVZGnLXMQEPJvYhhl8z3m8HQ0uNU+oBnSEqS4WNHGPtO0LQXDD+FQEHwnnUcW5Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LockaqYyCG/VnWuL8yeRMBFnRV4UWFWQegXlC2jTB4w=;
 b=N2Lh81BVPMPbQL3fbQjlne77M68zno0PL/FEk77Vz0/B3AvD4/+qXUqovriCPlqa76mLq9CuaJ4QhqzhlKi2MFKH1lhO2H/hLeu7Qt5dwx8AZft8ceP/rWadAD9FyyC1FmElnWEVQDC4S5YLwn1aS8NPL0+zDbFO9e6FiokPGWuUSORP3bGaZjONdcSe/lHCW2ogPJ104TgvwPCI779+SDC6mXelUExls6gac7C41V/4X8pPwHF+v5OnfFAebKvHDxQNhEVp5m9ki+thNshCBFx+5ALJR5L2mlVHV+lUiEPZoRpKYkF2Ko3mCIOA8+jnCg5J0Fww8sTab4PeK8yUsQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LockaqYyCG/VnWuL8yeRMBFnRV4UWFWQegXlC2jTB4w=;
 b=KPt0XgkbssPtR3Dl1JLy7GF6sl3YFjWHZqx9yAOxjw+UQF1cbm4sPcwV+B/7i8CAbKOifEBt38BkenRc4LBZx70rFxc15g3/pFXp3i4ihzuUu9Kp+/IFCzBsibMuIBdER3htaHJN14GjtZry1Xf1kFAe0Hya/edwXEdqdTy1xis=
Received: from CY4PR12MB1287.namprd12.prod.outlook.com (2603:10b6:903:40::8)
 by CY4PR12MB1285.namprd12.prod.outlook.com (2603:10b6:903:3e::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3933.32; Fri, 19 Mar
 2021 02:06:44 +0000
Received: from CY4PR12MB1287.namprd12.prod.outlook.com
 ([fe80::8908:d7:5544:6007]) by CY4PR12MB1287.namprd12.prod.outlook.com
 ([fe80::8908:d7:5544:6007%8]) with mapi id 15.20.3933.033; Fri, 19 Mar 2021
 02:06:44 +0000
From: "Chen, Guchun" <Guchun.Chen@amd.com>
To: "Deucher, Alexander" <Alexander.Deucher@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amdgpu: Add additional Sienna Cichlid PCI ID
Thread-Topic: [PATCH] drm/amdgpu: Add additional Sienna Cichlid PCI ID
Thread-Index: AQHXHDeg4xLOtgG+AESTdW9YfQUGBKqKkH7A
Date: Fri, 19 Mar 2021 02:06:44 +0000
Message-ID: <CY4PR12MB1287D1C941C20B92B0FC1259F1689@CY4PR12MB1287.namprd12.prod.outlook.com>
References: <20210318204506.453258-1-alexander.deucher@amd.com>
In-Reply-To: <20210318204506.453258-1-alexander.deucher@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Enabled=true;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_SetDate=2021-03-19T02:06:40Z; 
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Method=Privileged;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Name=Public_0;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_ActionId=3404cc6b-7c8a-4bce-91d2-c4305540692a;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_ContentBits=1
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [180.167.199.189]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 3fe04836-cb1c-4680-1112-08d8ea7ba4fd
x-ms-traffictypediagnostic: CY4PR12MB1285:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <CY4PR12MB1285D4D55F4FA0C4AAB5CBBFF1689@CY4PR12MB1285.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:147;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: OAGK8EDRJuJWq7b05C8T5LfqpA5WjGN6IOeq99X2UrJUDStP/Fe32DiakqAfj/AcO+OY6npgFrauG2ekcyIBsCkcpkTwSuL6NwFbCwvz7dlbKlyli/DDpPT0wrMOSMv95YNI88Dnx2pkcdfKinfJP/HQG0Te4NSde5TDb6FauvwDNUOhBR3JKFwlj4DA+OC7HmSoZSGFbFroZzt+pfdFSf7EUh6LA20nVWNZ+XX28/3vWvGONs2XQ3kvi0S+4A2H9xGVoS0p23xGe0uGROp0e4+rjuI6OBRMhltTa783pkcq0aXnzr4MOtTAXGdUu6xms+1XzBA90jEZODO8XNU78p6pWNk2ZF8hcC6/t9P6FK3SVDXnZZhQ0A2CH0iX0Ovqu/K/e6k570vq3/eSlBHe0b3dCvo32BsxwrBWn5ZfSljvrLWtVPoNq7yxsBPE3XRFKE7xt/ZoECvrKjCckiOkSEPnEAC4iuWkweXEVRS/16ejrL6nwtLybW2SUY1Tec7Pmu7ClgYAAu1586OmwzkRocjHHZhMSpnSWFHLJGrzG8YcdrfGNmKP6olfUq4Fq6E6kzaZ6YRwcFUd0C+IChxDXE1Oc9OSRlw5LPWAlODrk7RPN+Hm484KLbaWp7plV3HXlyg+kRcSPl3uFStQXGIf+r5Q+nkozyYmIhBIyC8h7RyJ7lPYQ9AYEUk79iETJOSu
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CY4PR12MB1287.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(346002)(39860400002)(366004)(376002)(136003)(396003)(33656002)(8936002)(110136005)(52536014)(26005)(71200400001)(316002)(186003)(55016002)(2906002)(5660300002)(66476007)(66446008)(8676002)(478600001)(66946007)(83380400001)(7696005)(76116006)(9686003)(6506007)(38100700001)(45080400002)(966005)(86362001)(4326008)(53546011)(64756008)(66556008);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?D2+9YI1wdg0B5Lx5z06y1Yc9xObSRnbbWabaY6/JNTTQEjoIxOcPNpJyQ0sZ?=
 =?us-ascii?Q?+pLlO196LWixZN0meFDKyfi7qpQoqn6Q3Rg7BsGWJ/ZhsU+RTMCCO6uY0rXb?=
 =?us-ascii?Q?zxQbgNfpwLDqJQjKks1av2yyGdZV1tzmP/1hFFLdUs9OMuWPw84XQZofN8k8?=
 =?us-ascii?Q?y3J36PWp5G3LdqqskCG6oEDI3Au3SC8BVv6K1278gvpKKhcBx3pL2D88CLYY?=
 =?us-ascii?Q?O9Ghsd9cv2ndjm9artyUf4MxYfL86A/CZGrSQpeDYrEEbwinjYrGfeBbx34T?=
 =?us-ascii?Q?cZWfgI1wNlQ8cqUA0pluhmSRHbG+8Tg1Z1DH2n1f5ork/8jHPbY6GZp8iQPr?=
 =?us-ascii?Q?M2pqHoqPFQV3kI47eWuXcaB5Z8b8OhuJyj3LBfbhe7r+LmVvHszE+G4rJsun?=
 =?us-ascii?Q?e9Kzzq+8tkNeGBOCbyInGkJ+lbC9ThdW/yYI1jE0lFZnHKxU8hjGW2qVtSmR?=
 =?us-ascii?Q?OTZAqcvrGisk4Q5mNbsA5/Klmk1CML9DdvcmnCu0nLgWkzME2pfy9yHEFtRv?=
 =?us-ascii?Q?mJ2080W8C+M7RaxOo1aSRDLUyKz87lXIpchkSlz6Nq2GHemIiZAdPMJ4B7hV?=
 =?us-ascii?Q?kyRC8zGzV9F8wdwknhWCJmfa+7l46ow3+S2sWWOoX17kSZ/HfQvJx+tWMyTL?=
 =?us-ascii?Q?Ez41ompNuNW7PRh4QY2u1rdRMNi6+hiPYbWca/dtrCWDVndZhuJzS2sU1yJu?=
 =?us-ascii?Q?RFCLLj25cjle8ANOjWoGUQlSYOL2GL7MdAJigD6kWIAgx3iskGt/vBNcA5ln?=
 =?us-ascii?Q?c81YtP3ucAC4ON1IosGT2fPMAua7JX8Nt/viy+v1MJXSLhj202m2WGt+XcVy?=
 =?us-ascii?Q?clIbMiePvunfMM+kBAUQBql+7iysKr5tv27jbVQwYd3wkBZlBP4m+wlorCUU?=
 =?us-ascii?Q?1xcW7zI8d3SwDk5yLCkPRRjzoN8pnvJqF3Hgt52wD9vzdMP4HvNB6XoyeiZ0?=
 =?us-ascii?Q?zyk0KXVs5YqmSnoyv7nYBs6v2f1S9Yt83PklD/vy8lg3pxc+VSfjiwIOVJB2?=
 =?us-ascii?Q?0i58szaYmqVHqPAllz1djlsP6bXmK62SUCAmpxCjEcPV8RteDbNEl+Y7DBEU?=
 =?us-ascii?Q?XI5IPu++SdMcYQqOzeHp2sj1CJDSmtV1c710OTzNT/FOETYihkcOxeRm/6bk?=
 =?us-ascii?Q?a78k21iZzmzqjyjpdCdkn1uCZ1LPaWX4xf+eWdqallPo6/KCvDKZgo6CX1hy?=
 =?us-ascii?Q?p3mMieln9ZxDw6RQq6pW/3fpHqPH3D757eESm8nR7xL9UQ4XG6c+WpyYXw/D?=
 =?us-ascii?Q?uD3yQMjFaSbPEjcQKi8tCeck2/oLYSZ/j0YCUQFGoBXQrDhhqnxNklBng0LR?=
 =?us-ascii?Q?xF7y2bHaIi/ZH7R3tZpA2ws3?=
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY4PR12MB1287.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3fe04836-cb1c-4680-1112-08d8ea7ba4fd
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Mar 2021 02:06:44.1011 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Y1qo649kmBT//05FO5bfREqvfG0+gj+0oCHtiqomvkiSoGksY8Tn5zm9rQHAG2KDyZ3UeGlo3tW04fuYSUsR2g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR12MB1285
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
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Public Use]

Reviewed-by: Guchun Chen <guchun.chen@amd.com>

Regards,
Guchun

-----Original Message-----
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Alex Deucher
Sent: Friday, March 19, 2021 4:45 AM
To: amd-gfx@lists.freedesktop.org
Cc: Deucher, Alexander <Alexander.Deucher@amd.com>
Subject: [PATCH] drm/amdgpu: Add additional Sienna Cichlid PCI ID

Add new DID.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
index 5438a4d3d517..6c78107db789 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
@@ -1162,6 +1162,7 @@ static const struct pci_device_id pciidlist[] = {
 	{0x1002, 0x73A3, PCI_ANY_ID, PCI_ANY_ID, 0, 0, CHIP_SIENNA_CICHLID},
 	{0x1002, 0x73AB, PCI_ANY_ID, PCI_ANY_ID, 0, 0, CHIP_SIENNA_CICHLID},
 	{0x1002, 0x73AE, PCI_ANY_ID, PCI_ANY_ID, 0, 0, CHIP_SIENNA_CICHLID},
+	{0x1002, 0x73AF, PCI_ANY_ID, PCI_ANY_ID, 0, 0, CHIP_SIENNA_CICHLID},
 	{0x1002, 0x73BF, PCI_ANY_ID, PCI_ANY_ID, 0, 0, CHIP_SIENNA_CICHLID},
 
 	/* Van Gogh */
-- 
2.30.2

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Flists.freedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;data=04%7C01%7Cguchun.chen%40amd.com%7C00dc99aa172142a1161408d8ea4ec1f0%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637516971281942067%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C1000&amp;sdata=O8A7Tjn0%2BrO1Iz4G0poDgqZYFu9l2StmAVFEQFFFNtQ%3D&amp;reserved=0
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
