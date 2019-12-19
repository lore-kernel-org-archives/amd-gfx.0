Return-Path: <SRS0=793y=2J=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9973C43603
	for <amd-gfx@archiver.kernel.org>; Thu, 19 Dec 2019 07:04:16 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 94BD8227BF
	for <amd-gfx@archiver.kernel.org>; Thu, 19 Dec 2019 07:04:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="YohpbM71"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 94BD8227BF
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0723489E2C;
	Thu, 19 Dec 2019 07:04:16 +0000 (UTC)
Received: from NAM04-CO1-obe.outbound.protection.outlook.com
 (mail-eopbgr690074.outbound.protection.outlook.com [40.107.69.74])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5279D89E2C
 for <amd-gfx@lists.freedesktop.org>; Thu, 19 Dec 2019 07:04:14 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=m9wHNjiJM/5szED/1e2IGfs4MlvzzYf3AaJw03Lm6o89tRWOdxyhbKXMbQEn9/0JyWPQASE+zT1VhE2IIGsmZVCPdROmQfqYKlVfSpdwNVEfKD2FAu9uRWLR1EkQillFbxSfH2rNKz5dZ1CTiJowJ7UXQ9KeQ2LIOx5U+x+D0mjyYS6u5jTqplp9KS3qBFbiHN3YR3eKphcyhtWyL89SzK1LbwfGYOeqn9YmNsn2fttAp+vqRFe/OgOZHI2xQTOnx1Hs0xvXAFOIb68ZlBPFUU9xdhwQvi/X4i1mPcfXnbSLbwV6tbLLGtWcZUl9YnMLeqbQ5xttp1U+5xW2tCA/Ow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PzH0uso3xst8bZFCJWmL5O+DruC1Un5n6G/G4xKOik4=;
 b=ad+7xXOxfbON7iyosDUDGsOG49gCZZN8yflFC8mcY031AMOBWKp9IAeDU2vLZ06zJnHlSSqN+sV6QgVUYY5k0/z9+ONC1+m565dc2xXflzJmlUECMvhv1HcAiPAQgPdKVItURGTKEZCI2CXLCE0mHZFbB9z3eczV8JRuTYyu1n+Lj+jKHGjrdHwn02mrg4Bs5wRgWnKESTjdNs9K3dFxwyL00BtWz6Jt949R/Gxn+xwPJruPzUDcBwAnVuIHQ4GOgAdf6jOOqf6Hk0SwyNYppNap+nlk86GGjehwwWOCSNw//D7RY8HamSUJBDMDbGKqxkfPvAoWuVG/8kdAshCSsQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PzH0uso3xst8bZFCJWmL5O+DruC1Un5n6G/G4xKOik4=;
 b=YohpbM71DGFOmw5UrmyVPuSHI/U2a7Mj8CIyEKtsSKDWFwqsIOVNIO5NzmmZCiDEgSF2kCIc/ATtl/SdycevhFpDxQfyuya9I/hD8uZ/54JFqtJN715lC2aA0I3cYgZZrqM85K++oQlqAqBuBGd/NqSrpOORLWDvbMucxgJ3InU=
Received: from MN2PR12MB3743.namprd12.prod.outlook.com (10.255.237.225) by
 MN2PR12MB3904.namprd12.prod.outlook.com (10.255.237.31) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2559.14; Thu, 19 Dec 2019 07:04:12 +0000
Received: from MN2PR12MB3743.namprd12.prod.outlook.com
 ([fe80::196b:de4b:eb11:ea6e]) by MN2PR12MB3743.namprd12.prod.outlook.com
 ([fe80::196b:de4b:eb11:ea6e%7]) with mapi id 15.20.2538.019; Thu, 19 Dec 2019
 07:04:12 +0000
From: "Dai, Yuxian (David)" <Yuxian.Dai@amd.com>
To: "Liang, Prike" <Prike.Liang@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amd/powerplay: suppress nonsupport profile mode
 overrun message
Thread-Topic: [PATCH] drm/amd/powerplay: suppress nonsupport profile mode
 overrun message
Thread-Index: AQHVtjfu8eZyTfiNzECEhKO7WVBCAKfBBrRQ
Date: Thu, 19 Dec 2019 07:04:12 +0000
Message-ID: <MN2PR12MB37434D66DE4F972A1C29C8268D520@MN2PR12MB3743.namprd12.prod.outlook.com>
References: <1576737930-20998-1-git-send-email-Prike.Liang@amd.com>
In-Reply-To: <1576737930-20998-1-git-send-email-Prike.Liang@amd.com>
Accept-Language: en-AS, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ActionId=f394d4c0-8cd0-476b-9cb9-0000e7e6c534;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ContentBits=0;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Enabled=true;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Method=Standard;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Name=Internal
 Use Only - Unrestricted;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SetDate=2019-12-19T06:57:27Z;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Yuxian.Dai@amd.com; 
x-originating-ip: [180.167.199.189]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 82ebfb79-b47f-49ba-9ff4-08d78451a71f
x-ms-traffictypediagnostic: MN2PR12MB3904:|MN2PR12MB3904:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MN2PR12MB3904EE5186EB6FFFED7261238D520@MN2PR12MB3904.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:132;
x-forefront-prvs: 0256C18696
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(4636009)(396003)(136003)(39860400002)(366004)(376002)(346002)(199004)(189003)(13464003)(186003)(54906003)(4326008)(26005)(7696005)(6506007)(110136005)(53546011)(316002)(9686003)(55016002)(33656002)(86362001)(15650500001)(5660300002)(2906002)(81156014)(81166006)(76116006)(478600001)(64756008)(71200400001)(8676002)(66946007)(66556008)(66446008)(66476007)(8936002)(52536014);
 DIR:OUT; SFP:1101; SCL:1; SRVR:MN2PR12MB3904;
 H:MN2PR12MB3743.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 3X7cyPTYufz/2QP7Z4iclaVxk2GhEaUKHd/atZP0trpb+/78i9h35Td2Jqv+1NYUxKH7E/o46GwgXlcscWRPSmvALa3NjoXZMkSlZs2BnwWge+X5pwFAVf/W78nLsNTjWNEHjhzBeBpOvVfCUToUKMRsZuCUq/4YQTTHWWhkrwT0vFK8+bAQqWA2fqCNPBuy7YRX6cTXgo/bz1f6V7QksDW+KCxYPaHVTcmZAVH9/VLo+LZFGsgpSB+5IWEhXWzq0cAsTz7snzFmuc9kh218TbicJG5ZqeJdUpnzJTijvMnNjTmvZ29M9+VWvTbobux5XG8q4Q6TTFuy9xEeJ9bNTPPsC3GKmzQw/QTe48iKZ8oFPRLNAnTbQkFylnDPkrMR9kLKA4eGT6o6cgRT6lhPFukrOfMlEBKxwgzWgWfK38/Dc+2nNDZ7R0wtQiW2P0/6c5Rb8H1MB223SaxvtPDw7m8gqsGbkgInGr+vlMnGnAI40Ds+IoxB3825BBySW5Ig
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 82ebfb79-b47f-49ba-9ff4-08d78451a71f
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Dec 2019 07:04:12.6130 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: vyy5yMhHcFLHwKLsAQokn8sWpAZa/01t3OdwbQ4C8DQGFj1w/RefK60cvpRLxIgK6tZKMvw/w7c3znLpPQfAhQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3904
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
Cc: "Quan, Evan" <Evan.Quan@amd.com>, "Huang, Ray" <Ray.Huang@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

For we don't support the mode, so shouldn't print the error message, or regard as a error.
For log message, the error is high level .maybe change from "error"  to "warning" , it will be much better.
 

-----Original Message-----
From: Liang, Prike <Prike.Liang@amd.com> 
Sent: Thursday, December 19, 2019 2:46 PM
To: amd-gfx@lists.freedesktop.org
Cc: Quan, Evan <Evan.Quan@amd.com>; Huang, Ray <Ray.Huang@amd.com>; Dai, Yuxian (David) <Yuxian.Dai@amd.com>; Liang, Prike <Prike.Liang@amd.com>
Subject: [PATCH] drm/amd/powerplay: suppress nonsupport profile mode overrun message

SMU12 not support WORKLOAD_DEFAULT_BIT and WORKLOAD_PPLIB_POWER_SAVING_BIT.

Signed-off-by: Prike Liang <Prike.Liang@amd.com>
---
 drivers/gpu/drm/amd/powerplay/renoir_ppt.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/powerplay/renoir_ppt.c b/drivers/gpu/drm/amd/powerplay/renoir_ppt.c
index 784903a3..f9a1817 100644
--- a/drivers/gpu/drm/amd/powerplay/renoir_ppt.c
+++ b/drivers/gpu/drm/amd/powerplay/renoir_ppt.c
@@ -550,14 +550,18 @@ static int renoir_set_power_profile_mode(struct smu_context *smu, long *input, u
 	/* conv PP_SMC_POWER_PROFILE* to WORKLOAD_PPLIB_*_BIT */
 	workload_type = smu_workload_get_type(smu, smu->power_profile_mode);
 	if (workload_type < 0) {
-		pr_err("Unsupported power profile mode %d on RENOIR\n",smu->power_profile_mode);
+		/*
+		 * TODO: If some case need switch to powersave/default power mode
+		 * then can consider enter WORKLOAD_COMPUTE/WORKLOAD_CUSTOM for power saving.
+		 */
+		pr_err_once("Unsupported power profile mode %d on RENOIR\n",smu->power_profile_mode);
 		return -EINVAL;
 	}
 
 	ret = smu_send_smc_msg_with_param(smu, SMU_MSG_SetWorkloadMask,
 				    1 << workload_type);
 	if (ret) {
-		pr_err("Fail to set workload type %d\n", workload_type);
+		pr_err_once("Fail to set workload type %d\n", workload_type);
 		return ret;
 	}
 
-- 
2.7.4

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
