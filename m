Return-Path: <SRS0=Zxj3=KV=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8EAE7C2B9F7
	for <amd-gfx@archiver.kernel.org>; Wed, 26 May 2021 11:40:00 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4C9336101B
	for <amd-gfx@archiver.kernel.org>; Wed, 26 May 2021 11:40:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4C9336101B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id ED9606E062;
	Wed, 26 May 2021 11:39:59 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2047.outbound.protection.outlook.com [40.107.92.47])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A044C6E062
 for <amd-gfx@lists.freedesktop.org>; Wed, 26 May 2021 11:39:58 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LltUZOOPPgMhy/yzWQlebnrjjlwaVu+cp4qKmRvpbIrEIvXAxDp0PWp1m0slcdCDNn+/sL0wDJtA88iWBEYg8Kj11EGPSBp5BDAxAHs6jz2ZIRHM0FrVe5F01W13pqTGcijtzwGEfcLe3oi+CmvWTr+kXUKks/NU+42GGWif4vm/fDLFxNyNy/AYhJ5EuLq84lppK1ELm4C7TH7brHOM91kCU4WdCmDpGl0VQnWEMqJ6ur6xve0mDxVQwMWGpFhRlO/FOKO4PzddwQJs5VxqXAc9zGTuHLOGeDREHl/skG+2J8DuYCOVobzfKjoKdmbkeHqtX7PkNJ7ezkZbNbYZkA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oE5I6MVOBhnXDsVMb5rdKBIKPXnMq6/X99Q1t+o+NhU=;
 b=I+ADL7qHjmVMwjnVBYtC0AA/WG7mycHePpiuS1caYgYbNy1KqnvVgzdpBO8hKPYikJzXzwXmHusNd6WfBYl2aSHubUJot9/g94BmlS3tJyE2cVDZRjcRNtCPMfMlSpzA4N4rhyWCk8j5dHBAuebLmAsLLY0k5gx+KeSxg0lg91f9FR92xRZNdFB6lKy/l13BiCAZhSDURyY9TaZ5GYdmhRn8WxQYAJ8f8KjaBp8Ao5m91MuyrrPX71INoKoNjp8quJ6KJ/PbSqF1g2EA3PwKiQsrBbuC1JmuJCRMS+r2lr9xxsEme+kvo2hWGp2jshwSLKiKsu9FvLreIkqtEe/68g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oE5I6MVOBhnXDsVMb5rdKBIKPXnMq6/X99Q1t+o+NhU=;
 b=cy43MxJBiAGsDWR5EzdRFW5Oh64khv5Ra8Gx1aqNFJSX7fnKmQhoErJRHV05ezFj/YcVz0IgVYRmLrctAUGAAJV3eGy+op6UKmcS4h1NAn3BIq+/+rUr67Sp2HrPp6Ua/ymtQsYQpwgcG+aChh5RPrHnTb427O2lK1VVmWnBfmA=
Received: from BN9PR12MB5368.namprd12.prod.outlook.com (2603:10b6:408:105::24)
 by BN9PR12MB5067.namprd12.prod.outlook.com (2603:10b6:408:134::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4173.20; Wed, 26 May
 2021 11:39:57 +0000
Received: from BN9PR12MB5368.namprd12.prod.outlook.com
 ([fe80::245d:c14d:fd99:be85]) by BN9PR12MB5368.namprd12.prod.outlook.com
 ([fe80::245d:c14d:fd99:be85%6]) with mapi id 15.20.4173.021; Wed, 26 May 2021
 11:39:57 +0000
From: "Zhang, Hawking" <Hawking.Zhang@amd.com>
To: "Joshi, Mukul" <Mukul.Joshi@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amdgpu: Correctly clear GCEA error status
Thread-Topic: [PATCH] drm/amdgpu: Correctly clear GCEA error status
Thread-Index: AQHXUaNxtXqYFmxV2UCMB4hQj2wEYKr1pFSQ
Date: Wed, 26 May 2021 11:39:57 +0000
Message-ID: <BN9PR12MB53688E663D957BAAF0344F62FC249@BN9PR12MB5368.namprd12.prod.outlook.com>
References: <20210525202020.21280-1-mukul.joshi@amd.com>
In-Reply-To: <20210525202020.21280-1-mukul.joshi@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Enabled=true;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SetDate=2021-05-26T11:39:52Z; 
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Method=Standard;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Name=AMD Official Use
 Only-AIP 2.0;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ActionId=473f9737-f0d4-42ea-8c85-1b01ccbfa5d9;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ContentBits=1
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [165.204.134.244]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: b4b9cf98-91e8-494b-dfd9-08d9203afcd4
x-ms-traffictypediagnostic: BN9PR12MB5067:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BN9PR12MB506721204A879B901195D5AAFC249@BN9PR12MB5067.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:1169;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: x/T97fyevwWrrVmZ1LIS+WNVZ9sn/TCfLzlJVqC1SBqVtR6crJlRpr9yzuPPQw2mhLKI2dHs5Lu+qPtgnImiM48z9gy8FD00tIm+jpevYII+GDbu9pBi/U8CqIDuxMcLRyNp8q2l5U1T2ib7Bv2tmZI+kX2Pz5OwviP9If2Wwp9MA0OcEFVrOu8/R/YOFF71O/O8l6EcVDioyNztV9cfndjKUd++QEmy2qnCzknIYEXSs23w1iOZ08obl/xbTLMmX6zVPZMN3rEUUtWQMihzy7usByD1Mp4Nwr5EaoFLSRX72PsuZH8SFVbJn/QterZPwLTCxzrb5GC5MdJhwdPenseEi8owybfNsY2F5gDWpocWHYIsHTGD6IZQEksVCKO+1k/BVanJ62RUkMGmo4J9dWxT6L+3LCobIADLZq+DvGATl/CzFWBiYd5KIUGN3L/dnLAMtautXkv0bm8EDmrnMTqg4YRP3umZhKHr8pP8jXAQAwqHFR2fyoaU3xZEetx61kmczHYtK6q8vRR0vWTUUVtY+38BtYPztM4t1sP59wjFH8wxo8rY4+zwV1EM5MMTAV8RlE6faoP6Up2ka18TS8/87VDoPuTuQTz+W/Qyk4g=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5368.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(136003)(376002)(39860400002)(396003)(346002)(8936002)(8676002)(2906002)(4326008)(38100700002)(26005)(55016002)(9686003)(66476007)(122000001)(478600001)(64756008)(316002)(76116006)(52536014)(83380400001)(186003)(86362001)(66946007)(66556008)(54906003)(5660300002)(6506007)(53546011)(110136005)(33656002)(66446008)(7696005)(71200400001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?D4RWNdIHQv2p5wnDYf2C+WPQTpFDWZO96JaznCjGqnSfJOcf4fkeOzSawngg?=
 =?us-ascii?Q?daQmiFhQDiiX3NJhVD0PzNwOw9yG6PcHwtRFbu9Gcxww2wqwY2PNg2JgxAkv?=
 =?us-ascii?Q?9y5cFHatlUEkBYN8ynEs0+6CD5HJByRPakD2xwPGlj2D0GRZ58cUD/5kj256?=
 =?us-ascii?Q?h7iae5JrItgUPQ6bVv3KDxeNGbf1UnMyM9jmKxdFUJuLNb4V43Q68k2NyZN9?=
 =?us-ascii?Q?Fv8STotf/oeRh5gnVYAPsiLIZoMv8UVTzsA8qTh1jmj7oJACKr5kZC0qfq3W?=
 =?us-ascii?Q?rNQkm8U/6kFh/hoElDkjtB8vyvwjvf1vJEGapsWkzMsJ+ia9SyMED1Ece6w4?=
 =?us-ascii?Q?UYI86FiVW0cXIVx/S3OEElpPWBKKn95mfAuXUpBGOn7ha2UsxtNEV3ZobGjt?=
 =?us-ascii?Q?mzByoghuSHclI4S8X0Cthpqgm1XN4AyXu7sUVH08kmS9m6B6VZJ3WTGz+hf6?=
 =?us-ascii?Q?R+sF/FJ3EO74jmiwCEjOz17z3jQjoBKDZiAc6TNX8d8Jwk4JsotTj5XngA9P?=
 =?us-ascii?Q?sr+pJm/lUUvIsskjFR4pZdRYJLj3hlnPK5m+b4PVS+eU0HVhDVA4QGPqRBLc?=
 =?us-ascii?Q?zOBM/Axp3a6QpUXelmWdSUCNC+VrMNTDfH7PuA3zLToPPdj8zQHSkjaIs7A2?=
 =?us-ascii?Q?yYvJEkKvZvfMlwQ1P/5dgMrL6mO7Y6+tnHxzsLee7FNXABtDKsgOIVC9hDrU?=
 =?us-ascii?Q?luXSri6NZG3nXjDon5IKkM2uNzL9WqTvtqHmd3dbT18FKNOljUyLE7OW979s?=
 =?us-ascii?Q?D3fWUt3UHD5tu4EzatX8lJdjaq4o/EuSevrwLjLeoh1A9FS4I0NVJ+53O80f?=
 =?us-ascii?Q?LtwoFrfE+b0oZJWQzG7wKtgvy5xK7sSRoAvq6ozHuE0JRsYWHeC7AQI0rDcR?=
 =?us-ascii?Q?C1hTbeUCYq9hXe5cvARzhOlMHtkQhwvKpI7r+x3qW+mIAaZVL9KpgZmFhyAP?=
 =?us-ascii?Q?X1Q8GW8r+ugZPxcY/rzENDId7DenZ/fSIhYxQ4GRR6h+YWz36qmDGdTUHJPp?=
 =?us-ascii?Q?YhiZfURuIryzcvgy0OXKRqhfT4iBFFooYNd0de9rx6OzTIuLL+MJEQwy2W/A?=
 =?us-ascii?Q?xIyBj4uZ2WiLfHBmCYaW9chQuRMmaezzuhpOE6wTAJYBN9Y1WB0o7L8Qfyhl?=
 =?us-ascii?Q?Zr+4yIeUuArtj/2oZmKjLQIl9puWAgc7xdpDMreQ2nWtHiSKX2mfT7dE6fgz?=
 =?us-ascii?Q?uMls5C9TyoJTY7nLHar0M9LIRezPb1DJ2FfeojmbMXji23fBv2YhCGdjHa6S?=
 =?us-ascii?Q?yvtjtcOXHsxbo71Ywvxo1erDkpd6/JpDV7cM/JGd/CHVbrjaeOz7gujQnSul?=
 =?us-ascii?Q?lumMRg3rpGKRDto+V59+hYUu?=
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5368.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b4b9cf98-91e8-494b-dfd9-08d9203afcd4
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 May 2021 11:39:57.0960 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: y1AWb1Tf4hUnh1nxXNRBGqCP9PPBi+Lcp2AkYzvtXoI9LWMDtMnHqOjEGlxGVevKEZ202fLNFRdRfYjoi6tprA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR12MB5067
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
Cc: "Clements, John" <John.Clements@amd.com>, "Li, Dennis" <Dennis.Li@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Official Use Only]

Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>

Regards,
Hawking
-----Original Message-----
From: Joshi, Mukul <Mukul.Joshi@amd.com> 
Sent: Wednesday, May 26, 2021 04:20
To: amd-gfx@lists.freedesktop.org
Cc: Zhang, Hawking <Hawking.Zhang@amd.com>; Clements, John <John.Clements@amd.com>; Li, Dennis <Dennis.Li@amd.com>; Joshi, Mukul <Mukul.Joshi@amd.com>
Subject: [PATCH] drm/amdgpu: Correctly clear GCEA error status

While clearing GCEA error status, do not clear the bits set by RAS TA.

Signed-off-by: Mukul Joshi <mukul.joshi@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v9_4_2.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_2.c b/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_2.c
index 87ec96a18a5d..c0352dcc89be 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_2.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_2.c
@@ -1676,13 +1676,14 @@ static void gfx_v9_4_2_reset_ea_err_status(struct amdgpu_device *adev)
 	uint32_t i, j;
 	uint32_t value;
 
-	value = REG_SET_FIELD(0, GCEA_ERR_STATUS, CLEAR_ERROR_STATUS, 0x1);
-
 	mutex_lock(&adev->grbm_idx_mutex);
 	for (i = 0; i < gfx_v9_4_2_ea_err_status_regs.se_num; i++) {
 		for (j = 0; j < gfx_v9_4_2_ea_err_status_regs.instance;
 		     j++) {
 			gfx_v9_4_2_select_se_sh(adev, i, 0, j);
+			value = RREG32(SOC15_REG_ENTRY_OFFSET(
+				gfx_v9_4_2_ea_err_status_regs));
+			value = REG_SET_FIELD(value, GCEA_ERR_STATUS, CLEAR_ERROR_STATUS, 
+0x1);
 			WREG32(SOC15_REG_ENTRY_OFFSET(gfx_v9_4_2_ea_err_status_regs), value);
 		}
 	}
@@ -1734,6 +1735,7 @@ static void gfx_v9_4_2_query_ea_err_status(struct amdgpu_device *adev)
 			gfx_v9_4_2_select_se_sh(adev, i, 0, j);
 			reg_value = RREG32(SOC15_REG_ENTRY_OFFSET(
 				gfx_v9_4_2_ea_err_status_regs));
+
 			if (REG_GET_FIELD(reg_value, GCEA_ERR_STATUS, SDP_RDRSP_STATUS) ||
 			    REG_GET_FIELD(reg_value, GCEA_ERR_STATUS, SDP_WRRSP_STATUS) ||
 			    REG_GET_FIELD(reg_value, GCEA_ERR_STATUS, SDP_RDRSP_DATAPARITY_ERROR)) { @@ -1741,7 +1743,9 @@ static void gfx_v9_4_2_query_ea_err_status(struct amdgpu_device *adev)
 						j, reg_value);
 			}
 			/* clear after read */
-			WREG32(SOC15_REG_ENTRY_OFFSET(gfx_v9_4_2_ea_err_status_regs), 0x10);
+			reg_value = REG_SET_FIELD(reg_value, GCEA_ERR_STATUS,
+						  CLEAR_ERROR_STATUS, 0x1);
+			WREG32(SOC15_REG_ENTRY_OFFSET(gfx_v9_4_2_ea_err_status_regs), 
+reg_value);
 		}
 	}
 
--
2.17.1
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
