Return-Path: <SRS0=LN+i=D3=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A55C7C433DF
	for <amd-gfx@archiver.kernel.org>; Tue, 20 Oct 2020 03:36:56 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0F8C82244C
	for <amd-gfx@archiver.kernel.org>; Tue, 20 Oct 2020 03:36:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="0Q4PPZ9k"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0F8C82244C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 493236F407;
	Tue, 20 Oct 2020 03:36:55 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2061.outbound.protection.outlook.com [40.107.236.61])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 588776F407
 for <amd-gfx@lists.freedesktop.org>; Tue, 20 Oct 2020 03:36:54 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZZZK85IliVc90sggUbcdkoNxnoCzRc3wvcodJMaUlP+EBiSZysIpbfq/qcYRpJ67twwPr10qI8XjBX0adqAGn8RVFbxI7gqFu0PLRn53s3jq/eFYuvjDioEMtOW99hcFOJlnY9QRqtESQuz4alhF3mlPWsqJBKJ79uIgvO4mAIN9o+SoKAgFXmgfI/g9P9IAPZweeWQ7u8ZSBm6lTNpmbe/QO5b9wibIH7oeqdOfaw3EYolt1bTI70WRdEvpXWCtGmCLzufChxLzgPjig3L+Pr0QxzmS+4+UMR92qZ1FnufvIPyXJAq5MQ2MEKjh0F3XzLLPnd6+UKCNO0Ok9s1nfQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=91kLVLnDrRQIYUSoT9p4xyV/kDU+1XFXLaz+eGWRImE=;
 b=Ujmm07ychYq4j7laVg8sqc1ugbIZGSVdXoR0g6to00WG6+HTJHPr7fz8gWfpfk+m69Q6Ixu/YD702SgGiw5Idj1RKrBuAqd+IkCC6k0MQ2a6sdbx8exkCWP/waxZucmBiBnt+ydhpo/eyC3mjIeNwZ1AFrf/K3bHMtMrMSTHJFewG2wjKLuczrHQgU8rWL6z1uNGe3sqvPv/sgc+MAyhtwgtS4nioqB1eOgK9UYIUfLeAfIuGRJFaY48rpb7LfUCGME9CbL23uMt1sHPWdwycFKHKGxuLnwRtWso6KOzmUlQ0B+vzmfcVr7Ou6rDUnZf5ow3Lj9WH8T9bZ5m1ibS2Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=91kLVLnDrRQIYUSoT9p4xyV/kDU+1XFXLaz+eGWRImE=;
 b=0Q4PPZ9k2R/Kua0JJz55MZsc7XLUogA+mZeGXB6IHsXYpS04jB/5TF69aOKBS9Dzhdiz7P+jV5NsIYM4aPs0NWFOzks/xn8/QWm3eRasj11yXN/nQ6U/mQ7G5FOyamgXgJRuUBn9nla7GY9xhLKtxmBavh+wktYcP5U5+svD+es=
Received: from CY4PR12MB1287.namprd12.prod.outlook.com (2603:10b6:903:40::8)
 by CY4PR12MB1270.namprd12.prod.outlook.com (2603:10b6:903:43::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3477.25; Tue, 20 Oct
 2020 03:36:51 +0000
Received: from CY4PR12MB1287.namprd12.prod.outlook.com
 ([fe80::ad96:acee:5c1c:d92c]) by CY4PR12MB1287.namprd12.prod.outlook.com
 ([fe80::ad96:acee:5c1c:d92c%4]) with mapi id 15.20.3477.028; Tue, 20 Oct 2020
 03:36:51 +0000
From: "Chen, Guchun" <Guchun.Chen@amd.com>
To: "Gui, Jack" <Jack.Gui@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>, "Deucher, Alexander"
 <Alexander.Deucher@amd.com>, "Kuehling, Felix" <Felix.Kuehling@amd.com>
Subject: RE: [PATCH] drm/amd/amdgpu: enable noretry for
 Sienna_Cichlid/Navy_Flounder/Dimgrey_Cavefish
Thread-Topic: [PATCH] drm/amd/amdgpu: enable noretry for
 Sienna_Cichlid/Navy_Flounder/Dimgrey_Cavefish
Thread-Index: AQHWpo3ds5Omi3pMnka5UFAlJjFPTqmf1zuw
Date: Tue, 20 Oct 2020 03:36:51 +0000
Message-ID: <CY4PR12MB1287AAC2075C8BA8CE35BF60F11F0@CY4PR12MB1287.namprd12.prod.outlook.com>
References: <20201020030514.28309-1-Jack.Gui@amd.com>
In-Reply-To: <20201020030514.28309-1-Jack.Gui@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Enabled=true;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_SetDate=2020-10-20T03:36:39Z; 
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Method=Privileged;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Name=Public_0;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_ActionId=37ce43e9-fb93-4ad7-a912-0000ee8a67be;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_ContentBits=1
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_enabled: true
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_setdate: 2020-10-20T03:36:49Z
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_method: Privileged
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_name: Public_0
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_actionid: 37292f48-ccca-493f-b81f-00008c5405a1
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_contentbits: 0
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [58.247.170.242]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 28b1a151-e1c4-437a-af92-08d874a961e1
x-ms-traffictypediagnostic: CY4PR12MB1270:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <CY4PR12MB12703F1FE302F1BE0A2A58DBF11F0@CY4PR12MB1270.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:561;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: nN/7sCdR2OTnYwCW4fR99cAt/Tv554SFFx6q/uBw3vs128p6iJdxLaoWW1GbC9OQdFcs5FQJsOAo5N3GwfrHdllKHSwqvBEiObI742+/WvnCOlBDTkuCUQtjnSf+e6sxAzmJ6sflojSAAQwsVVFBkHtOnjZ1DrkTTk6oqrvvekJ6dR6yykq0D5y5Hoj6BNTRLP8FsFEXhtZwxya/feU3EIFM0XNvqjXlK/UbMz02BVFMCaa8en0XayN1MorV2ma9FM+AiFxzAFhs2a+4MReFuzWJWl85Iats703SVsSSr2IxFGZ3B0mM0edZvMs03+db
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CY4PR12MB1287.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(346002)(366004)(376002)(136003)(396003)(39860400002)(2906002)(8676002)(76116006)(8936002)(66946007)(66476007)(52536014)(86362001)(55016002)(66446008)(64756008)(66556008)(83380400001)(4326008)(5660300002)(9686003)(110136005)(33656002)(54906003)(186003)(71200400001)(478600001)(6636002)(26005)(53546011)(6506007)(7696005)(316002);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: 5OhTDEEqCpLgaeD80QGqNlHbtFJimqvWhw2FHg7+T9RFpAZ8a0xHC3cTpo4tLUW7H//Mytpz1ycatjTrj09WSEonVrxs0DWDCTNhw1YrozzEn0PMRmo2T6Smk1ZMSDvm0sqekkOMuETd52J2I/4SHmpLNvQiZUX4aoypvnhBRsmMFEtDwYVYmPVajZCTERbQuVml88TGGAVyhALvHcQn8BwQWwTz4eV4yGfphy8sWbetrDOSxiLX4kYEpOd5RB3c+3SemL+TSAmKUvXxYI3Hj/fyAPPyHT9PjD4uRMKAcmCTqNprwLpD+9pp+Neo3OWczrnKO5vYlQINxMgq9SglBfvHbLVzVmW5UiOERd6w9juLETq2peuHvGnBsYiHGBDAoRLAjJbK93RmbR5fnHs7sDWkLjVmjpYf1lixFvipoY+ey7K/SSzQFdAaYfNe1cZhNxSFc2HZ4kZVxcnjxY3KT6NLzjqsJjbeRjT/yQ8PKbGnKohTeuCnCAyQ67AvyC6m4ve/Jxn+SG5UL/AyjOiGMO/yda+gVESBRTSTgctRRAt+GTC1UWUuXox7bhP6uh5j8+6C6i89rEXhJynX8ukDx6Df6O7xNeosY1beaLycvAKPMFF+99eckASMn1pFD30Y7ZCvRBTN4RkbSJM/VZH6Og==
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY4PR12MB1287.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 28b1a151-e1c4-437a-af92-08d874a961e1
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Oct 2020 03:36:51.2111 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 86AGBS0FTYeABAP6RIlkH+WT7xPMXeLc39GhQqTBEuedpta+OC97ab53Yw/2BaUTIcaCZUXVxRH/cQz6gua6sA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR12MB1270
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
Cc: "Zhou1, Tao" <Tao.Zhou1@amd.com>, "Huang,
 Ray" <Ray.Huang@amd.com>, "Gui, Jack" <Jack.Gui@amd.com>, "Zhang,
 Hawking" <Hawking.Zhang@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Public Use]

Reviewed-by: Guchun Chen <guchun.chen@amd.com>

Regards,
Guchun

-----Original Message-----
From: Chengming Gui <Jack.Gui@amd.com> 
Sent: Tuesday, October 20, 2020 11:05 AM
To: amd-gfx@lists.freedesktop.org; Deucher, Alexander <Alexander.Deucher@amd.com>; Kuehling, Felix <Felix.Kuehling@amd.com>
Cc: Gui, Jack <Jack.Gui@amd.com>; Zhou1, Tao <Tao.Zhou1@amd.com>; Huang, Ray <Ray.Huang@amd.com>; Chen, Guchun <Guchun.Chen@amd.com>; Zhang, Hawking <Hawking.Zhang@amd.com>
Subject: [PATCH] drm/amd/amdgpu: enable noretry for Sienna_Cichlid/Navy_Flounder/Dimgrey_Cavefish

set noretry default value to 1 for
sienna_cichlid/navy_founder/dimgrey_cavefish.

Signed-off-by: Chengming Gui <Jack.Gui@amd.com>
Change-Id: I2fba7a325ae6f805ba15f33cae47ca065553d3d1
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
index f26eb4e54b12..fa799600a58f 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
@@ -428,6 +428,9 @@ void amdgpu_gmc_noretry_set(struct amdgpu_device *adev)
 	case CHIP_VEGA20:
 	case CHIP_NAVI10:
 	case CHIP_NAVI14:
+	case CHIP_SIENNA_CICHLID:
+	case CHIP_NAVY_FLOUNDER:
+	case CHIP_DIMGREY_CAVEFISH:
 		/*
 		 * noretry = 0 will cause kfd page fault tests fail
 		 * for some ASICs, so set default to 1 for these ASICs.
-- 
2.17.1
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
