Return-Path: <SRS0=anlk=IC=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18450C433DB
	for <amd-gfx@archiver.kernel.org>; Thu,  4 Mar 2021 07:31:15 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B29C164E1F
	for <amd-gfx@archiver.kernel.org>; Thu,  4 Mar 2021 07:31:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B29C164E1F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 200CF6E0D7;
	Thu,  4 Mar 2021 07:31:14 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2082.outbound.protection.outlook.com [40.107.236.82])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 68BB06E0D7
 for <amd-gfx@lists.freedesktop.org>; Thu,  4 Mar 2021 07:31:13 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HNZdAGpSGtsfcwJY4otom5ieXA/rXPFAV6wXVcng4VKostibSeoAGgiuUXci8LgIA7/mngdYQTURhIKv0mj+F3R4gHJeduYarZfShueuRoMFzbFRFKU0xk30n7qrRo8sjlHTsTGSkKN1AunWE97o2cGofIYfahMPFP8v6fmALGqvTlmcjH9WXxshJmGom89BggU8zFfJxfxobbR5vFCL8rys8GsJWCHxpH6XBgIef3Q9glZZQEOymMkTw2kSJzRmJpzYZdSFCaaDDqdqemsBziKfCrMr71DpN3La5brbptaqnBKkU8fGfUuwK75UpgdgRxXq8/OSWBu9Pdya6p3c7A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rtKLpISL3N/pm09+f/QAlVklR4GXsp7UTuUaFvmbEIg=;
 b=m6LVbIl7Jh3NZfeLcpFDYQhL2DuC6BFdiDeXq9vZqefDk+/Ggzwx/M1/6XPm4xbB2V6Mir4Mq7IOptY99w51pqQT4EuyWMkn+fKuYJWX+90U3CNen3unqlguwVlEsfJmLMe1w2LbJ6lPJnYPolVZn7qA8DT0wZuA1A0c956QcvpozvV97RySMX3xgs2M5UBPB1Y3Ds3Kt4+iuIMhJKsLFQrDXEUQw36lnwknq/sh4P6y9SdpSEecmhqT6nk9Qv7X+i87foOjiNwod7X1O9lL/dqnNxNMNWYAU50fY1DzIHomhcO2dJV8pUt8VD8v4ZAvXTAWPFbrVga4v44GUmRf3w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rtKLpISL3N/pm09+f/QAlVklR4GXsp7UTuUaFvmbEIg=;
 b=V07ezRARaSwJ6jwaX5gjrmg/OLQh6sSLNWLsRlogod/qP52xF2qH8igDx90FeAoxmITVq0CPMXL2iZyi16yweA152a3p6dUX1Yg7gyns6f4VG8Doc5Msc3L4KiLBKxLj9hpLdO3cO2gMJ/rqKmpYIPKHKC+ydmbcIH+H3G5ay1M=
Received: from DM6PR12MB4075.namprd12.prod.outlook.com (2603:10b6:5:21d::8) by
 DM6PR12MB3275.namprd12.prod.outlook.com (2603:10b6:5:185::29) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3912.17; Thu, 4 Mar 2021 07:31:09 +0000
Received: from DM6PR12MB4075.namprd12.prod.outlook.com
 ([fe80::34e3:c46e:188c:ef53]) by DM6PR12MB4075.namprd12.prod.outlook.com
 ([fe80::34e3:c46e:188c:ef53%5]) with mapi id 15.20.3890.029; Thu, 4 Mar 2021
 07:31:09 +0000
From: "Zhang, Hawking" <Hawking.Zhang@amd.com>
To: "Xu, Feifei" <Feifei.Xu@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amdgpu: simplify the sdma 4_x MGCG/MGLS logic.
Thread-Topic: [PATCH] drm/amdgpu: simplify the sdma 4_x MGCG/MGLS logic.
Thread-Index: AQHXEMJ2eeTKdn9dWU6uxeoDC8G9aKpzbwSA
Date: Thu, 4 Mar 2021 07:31:09 +0000
Message-ID: <DM6PR12MB40755253DC063A520C912143FC979@DM6PR12MB4075.namprd12.prod.outlook.com>
References: <20210304064850.40488-1-Feifei.Xu@amd.com>
In-Reply-To: <20210304064850.40488-1-Feifei.Xu@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Enabled=true;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_SetDate=2021-03-04T07:31:07Z; 
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Method=Privileged;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Name=Public_0;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_ActionId=c64ec9fc-848b-4f28-a31d-1f99fdbe9455;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_ContentBits=1
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [180.167.199.189]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 85bc2a53-7acc-4ddd-0b64-08d8dedf7b11
x-ms-traffictypediagnostic: DM6PR12MB3275:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM6PR12MB32758BD7C19DD3511A8FDCA9FC979@DM6PR12MB3275.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:1060;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: L9spa+Hm//Ey+GtTN/9eBkAM54IWXfqWhJ3kaccw2QP+ghP+pYKlV40rLnqeDqlu5rCuMbAeQVryS6JW986TYUaC0fHka5AW12bXawhHrKdcELmMSqHZ2ds9kLsvsHqzpt/2KR2O/YH99Ux6PVp6Rl1SOROVMTryu8Pa8mhHzh+iWDEuc9IHZRuo0iq18THNjVjm1GcmnHjWWllXrfEmklnPEZLFfF13WGJQuRCHNlBq0PrC4xiShFldS+8MOqW/R37+XkUjJ68ZNa1eraLmohB0WkAv8kD5EknDpUxE16d+Qy+j8q8bNzAiBR31mIf3d5uBgnVLY/oUFUZ3o+CfGm9Gqn3takyjnX+7pzyb3wZrrwmQ6GoBQum3rt7/5e1LLlnvXbhujsZMx37di4vNqPo/dMLlvVqTUokg1aM+FPStEVfhbQm73WVBLo7Mk4A9B9CiVzloBfi08dj4CQ9mxwpTALJ548IFTcs4G1RiE7BtfQvEAeaLgl1VqsaeKLAuB1CRwQIFXFiZ+6dtqIhvG4M/GmLI6HmoOtRY/JeF80g8ELQ33Yu5ymUyht9uss1C
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB4075.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(376002)(346002)(366004)(396003)(39860400002)(136003)(110136005)(33656002)(7696005)(26005)(86362001)(53546011)(6506007)(186003)(52536014)(54906003)(316002)(66946007)(2906002)(71200400001)(66476007)(66556008)(8676002)(66446008)(64756008)(5660300002)(8936002)(966005)(9686003)(478600001)(45080400002)(76116006)(4326008)(83380400001)(55016002);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?PtxPJ0LhwVEwtvFMV1yDILnB2nC9q50bPKYjiONO21UWbV8Ftc+uAf9N8F0T?=
 =?us-ascii?Q?rL0SA//DF/7RqpwcUmAc6otV9Vey1sFnp2kLLk4/m1owGLMtKL+UyHoeBxxy?=
 =?us-ascii?Q?496lEnjufTO0nH8qxeKNM0lHBAcnrDNhfSd+7Ca9EC3yTumS7efzQh3+qENN?=
 =?us-ascii?Q?MZLoEGfufR5+IAgAkHmODIYeJvCTu+GDK2wjZohk1bUaUYsSCRcgy1qxTnSY?=
 =?us-ascii?Q?e22b9jrToog23ZgbIylcQdaIldhnf8Q+YkYIUb655hJF+biZvwJutVfl4qUl?=
 =?us-ascii?Q?PuE+fzVMDFglgjjb6bC/Wj4s1Ae+uTyO3leA22T/sxLBsh5Wi5n44DKCFQEt?=
 =?us-ascii?Q?ZJrHRFHXzk9/F/Tt0lLiyuTiGlTLh1NaFefr+njJEHwV3Fx+dPN+WDvqmIDS?=
 =?us-ascii?Q?bXFx/5BqlBRTxv3XRuWAC5ydjTw9A9OUU2v9K9sd6dOoP/C6UcX16EOMqlmw?=
 =?us-ascii?Q?qL1iCQk0xgip39isOxA9q2vq9lRHnwF50zL7i16UevUxZgSfTvG7Wd3rpS2F?=
 =?us-ascii?Q?QSDmbG/L7CyNnoe6VaK9XmqMR0iDvhhaQSE3S/nsoMf7g+/X17SwV59EF+fW?=
 =?us-ascii?Q?ZCTHoLrFrpRPUEw6oHFwInTIShXJsHQx0aVnXhCG1x9g8Tgbf72tfcai9qnw?=
 =?us-ascii?Q?zd7JC7doM1aU6wQVsD1ElTLNUkAiiK4dk/w01g+5giDzuDhnvD6jLxiWHSAe?=
 =?us-ascii?Q?t9L23G+DVbze4i45Ghse5LyL1kXmqMLUfKCQTCeqcob3tYhNmknv0cFWuFvd?=
 =?us-ascii?Q?BlfR7mVhMery7Gd20MdQDhvMRotvUFTLK/mDMNXnSydG81C/lioUy2iSCKZP?=
 =?us-ascii?Q?/Y6CIXJGsd0ZOS/86RLPCEMYGX6r9q1UpFr4u3fo+iiSot9r0nP7o5HIK3dY?=
 =?us-ascii?Q?A7gFiX2xnmUGWNDhBET7Bl77FJwXy1hQIKLPjYJ84LbTytXAOudT7m5dHT0m?=
 =?us-ascii?Q?FinAZAvpjjNFOKvFV2h91S4ymGF/RXr0I3m0guSSPxDk2UxytFjjftjFd3JO?=
 =?us-ascii?Q?6nQRp85v8EwvX8mtCjEJ4+RxD/PisVDzGBxX7hE2fqatppOJVDnaksvEB1Tx?=
 =?us-ascii?Q?7PY4cqxMCfyt2s+4khA/qS8d7fklTLZfXQOuERG31T+kTvGBtp/5fQyB+jWp?=
 =?us-ascii?Q?TqNEVq5NQt9F66m5FKzjRo7+do5Vi5rqYyV7gwmuDhG7yC9bLholeq8i79S8?=
 =?us-ascii?Q?VtELCluRoO7aUiknxKvAtuTH+VIC2hOHR3d4CDhBARM9namJ32/KwWCDKuYG?=
 =?us-ascii?Q?7qu553HQ3ya/MFde3sP/3uyaX70vDs1XPPyweAz/Tu+bZ54oaIJVfG1aC7Oi?=
 =?us-ascii?Q?Z79pHcOZytAeczXQSoORNjOV?=
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4075.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 85bc2a53-7acc-4ddd-0b64-08d8dedf7b11
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Mar 2021 07:31:09.5946 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: MldFk3WF+HZ5h264H4teaS6T4OfrOQIZxpdgYrCvvnuknPPNyyC6JX2/t/ViZPnWVIAYEr3d4KO2AnsWveshJQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3275
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
Cc: "alexdeucher@gmail.com" <alexdeucher@gmail.com>, "Xu,
 Feifei" <Feifei.Xu@amd.com>, "Lazar, Lijo" <Lijo.Lazar@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Public Use]

Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>

Regards,
Hawking
-----Original Message-----
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Feifei Xu
Sent: Thursday, March 4, 2021 14:49
To: amd-gfx@lists.freedesktop.org
Cc: alexdeucher@gmail.com; Xu, Feifei <Feifei.Xu@amd.com>; Lazar, Lijo <Lijo.Lazar@amd.com>
Subject: [PATCH] drm/amdgpu: simplify the sdma 4_x MGCG/MGLS logic.

SDMA 4_x asics share the same MGCG/MGLS setting.

Signed-off-by: Feifei Xu <Feifei.Xu@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c | 20 ++++----------------
 1 file changed, 4 insertions(+), 16 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c b/drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c
index 3bede8a70d7e..70d247841d14 100644
--- a/drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c
@@ -2271,22 +2271,10 @@ static int sdma_v4_0_set_clockgating_state(void *handle,
 	if (amdgpu_sriov_vf(adev))
 		return 0;
 
-	switch (adev->asic_type) {
-	case CHIP_VEGA10:
-	case CHIP_VEGA12:
-	case CHIP_VEGA20:
-	case CHIP_RAVEN:
-	case CHIP_ARCTURUS:
-	case CHIP_RENOIR:
-	case CHIP_ALDEBARAN:
-		sdma_v4_0_update_medium_grain_clock_gating(adev,
-				state == AMD_CG_STATE_GATE);
-		sdma_v4_0_update_medium_grain_light_sleep(adev,
-				state == AMD_CG_STATE_GATE);
-		break;
-	default:
-		break;
-	}
+	sdma_v4_0_update_medium_grain_clock_gating(adev,
+			state == AMD_CG_STATE_GATE);
+	sdma_v4_0_update_medium_grain_light_sleep(adev,
+			state == AMD_CG_STATE_GATE);
 	return 0;
 }
 
-- 
2.25.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Flists.freedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;data=04%7C01%7Chawking.zhang%40amd.com%7Cb242d7b4c7ef418c04e808d8ded9980c%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637504373431976237%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C1000&amp;sdata=Cix3f%2Bji1gZRCmqdSBiNiSTu9dcwqLQ%2FNcCrtNTuQ3Q%3D&amp;reserved=0
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
