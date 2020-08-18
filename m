Return-Path: <SRS0=CyhX=B4=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9DD64C433E1
	for <amd-gfx@archiver.kernel.org>; Tue, 18 Aug 2020 02:31:05 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6CF3220716
	for <amd-gfx@archiver.kernel.org>; Tue, 18 Aug 2020 02:31:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="138HRmEJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6CF3220716
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 15C5F89B78;
	Tue, 18 Aug 2020 02:31:05 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2054.outbound.protection.outlook.com [40.107.223.54])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9B1EB89B78
 for <amd-gfx@lists.freedesktop.org>; Tue, 18 Aug 2020 02:31:03 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TyHC7nfk8uEqfI+U2IDfDISBRnJSgNVZAIPJ+Nie0wTdV/I1fjy0I2ZXak6+5/JjyS3PZfE74vJ1PZLu6uSp/dV4RTHqTmEn7Kpb71z3hZBcoi8NACRnPbpjayQsfpXXZfRaQle5tOIgil90hpPxAN9bZOfiL0WYoMtD3bxtXYYfn8dePp14zBHhO27WIwItsBmfbysWEGMBRM5eJbyRn7MUakGOm88GAm4UAo5mclh/2Sond1goLUSrNhd8L9ziysNTNhARFeugBNdvC5WjO5zMu8d+he5NY8rzv7dBImcVkLDpZeY8zXen+4cYtLUF3a8u27tdqMuFnoa2VfZL+w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KRo2t4dy/sf9C86TMyvbiAqdm6IbMmGq39pin+qJypc=;
 b=GBx6091RbOrQazrnQpCp612BD26qZ3jX6UMT+XngV/I/5Av9e/tb+HZhBx7P4MD0AGG/ZwX3Kt05h66siEhHkeouWt/s+q7E4embPTiiyPfwFuqlqmMEW8oEdUBAcscNqdcwcyLl4kW2mDtOQp3MERQqJEDCcHgRUKllBStKoRJ3hcY4rtGUnlOcHRZNIRkRyNzustiA9e0Lr1dajJW98XpBofWiS24sVM2AiX4X1XBuO7MlOwioFu+DyMe7FafeN1cUFIdgmmpw2mP6Y1AUzqeseeiz5UM2sb1UQINMqLJ6z2+S0TJJGmcZJAhtfhvjD7LNOl46lB7lgVOt1kK0lw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KRo2t4dy/sf9C86TMyvbiAqdm6IbMmGq39pin+qJypc=;
 b=138HRmEJG/Tne+3bmFNj7Uy6jMch758tLdoFYW/MAhsv3g9tsWndzNz8WxXl8oXmi1FLIOeiVVWMeQcptJkEQnincbbX989wsYi4TECoNGJ6Aeq7wCjhwB0kFd48Y3XGgaOHGvMmdAHQaIfuxG+fvHo2c1i+FY61TRXXFdRbVDk=
Received: from BY5PR12MB4161.namprd12.prod.outlook.com (2603:10b6:a03:209::24)
 by BYAPR12MB2966.namprd12.prod.outlook.com (2603:10b6:a03:df::27)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3283.22; Tue, 18 Aug
 2020 02:31:02 +0000
Received: from BY5PR12MB4161.namprd12.prod.outlook.com
 ([fe80::90f3:b006:b7c0:d399]) by BY5PR12MB4161.namprd12.prod.outlook.com
 ([fe80::90f3:b006:b7c0:d399%4]) with mapi id 15.20.3283.028; Tue, 18 Aug 2020
 02:31:02 +0000
From: "Feng, Kenneth" <Kenneth.Feng@amd.com>
To: "Chen, Jiansong (Simon)" <Jiansong.Chen@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] Revert "drm/amdgpu: disable gfxoff for navy_flounder"
Thread-Topic: [PATCH] Revert "drm/amdgpu: disable gfxoff for navy_flounder"
Thread-Index: AQHWdKUgQlrm5tXwfU6dYe1az1IetKk9JeOg
Date: Tue, 18 Aug 2020 02:31:02 +0000
Message-ID: <BY5PR12MB416167F543BC27747AA7737A8E5C0@BY5PR12MB4161.namprd12.prod.outlook.com>
References: <20200817144549.16407-1-Jiansong.Chen@amd.com>
In-Reply-To: <20200817144549.16407-1-Jiansong.Chen@amd.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Enabled=true;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SetDate=2020-08-18T02:30:55Z; 
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Method=Standard;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Name=Internal Use Only -
 Unrestricted;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ActionId=59666f29-034b-4478-9e21-00003c64e47d;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ContentBits=1
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_enabled: true
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_setdate: 2020-08-18T02:30:55Z
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_method: Standard
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_name: Internal Use Only -
 Unrestricted
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_actionid: b2f4df3c-3702-43c8-94f2-0000bd19041f
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_contentbits: 0
msip_justification: I confirm the recipients are approved for sharing this
 content
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [58.247.170.242]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 0fc01755-4b21-445e-ee3f-08d8431ec002
x-ms-traffictypediagnostic: BYAPR12MB2966:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BYAPR12MB29662A0A6A0E083D2F5A22198E5C0@BYAPR12MB2966.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:345;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 5BMQiUcS0Lu2wPbbW18omVzDEYZpu26mv/J5gwm5F0pvnqjeodKmzbA65Q+9ckY7wXIyxT7kaP6mCAI4m2L/UeuHGWVZvLv8OAOS9tDuCCP+fXYpST3z0t2y+RZq/s6FDAyk6QYWFHJAE6VyTqw+I1Jp7m5ZkCtGe/cZcPuVb+NhQz+qjTeWODf69gFp7PXG80OaXbhC20TfTrkOlaAGziwafs7B7S8gt6FqgmFdC7S5M7BrzJg9Zog75qugnq6RHAPKYX51I43Ml+J/qM7kTZz/p7bHyAoUFpV/W/eI/7HbdSuTsSWea5olPapSjAiOzZZScnTFRujJR9SKHb9f/g==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BY5PR12MB4161.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(39860400002)(376002)(366004)(396003)(136003)(346002)(83380400001)(66946007)(2906002)(86362001)(66476007)(76116006)(64756008)(66446008)(478600001)(5660300002)(33656002)(66556008)(52536014)(9686003)(8936002)(316002)(6506007)(55016002)(71200400001)(54906003)(4326008)(53546011)(26005)(7696005)(110136005)(186003)(8676002);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: UM65Wu10PqHVW+787RSlFbHyHzs0VM8saPAmKPi4gQkYKVdzNojS2fWWe1UHkoSYPIpIO0laavBGWi9ddIGumYwkhwsfMJB/EdaZtN32+4Mtjhlbrjwcol5LFhb8BqJwaDc//EnxX+YbuK0hXjKYuAX78WeVmb2rXWZADxoIDu5l2gHH1+xsH6ISa1T+0kS5vEDcabsSUIwbAwjeFmP9QHUqCwL9cCPCxwrcGF37qDQv8KB8VZeWx4+w34adlvuEkx4VdCMp6D4P3GMB4Csyz/S7aRoJ1TVWLAKDqjieeVULDoGoxjAEoMztXHBuDuhTmwJLgA6P6A6cNRgd9facuaGW8TpkeOVGPwNZrx+PgzqSKjUcw528OJSj5dsnoYASRRjFrrW4j3Mf79f9tGl2SNRrh+sDXrk9NBZNcSgi6tCRmthdNxNEMqkK3R68jwLKn/w4CWMVaR5kNStycYoE0CqfaJ3qQawBdUK8DHUftfFOcjbKQeN6OLaoYKLATWLR1g2taM7rVmouk2/7G19WyciD0lpjFW/m5zgMl1XQxCtB50eEEmQdYaYuqcxhg/1rsRthZScWAO4PkdjEKceRdCnTxazyuT2+r1M7to9M+4YDmxQ0n08rR8ahy8FHAxJthDlsUUEHJwtumHXab3fYdQ==
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BY5PR12MB4161.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0fc01755-4b21-445e-ee3f-08d8431ec002
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Aug 2020 02:31:02.0391 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: +1YWd2C0sJMqEvQ/aPKhnp+VEPp2X6gtDXsvE9VT8MHjYHopiNkEdY3tRJWqTW9Y
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB2966
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
Cc: "Zhou1, Tao" <Tao.Zhou1@amd.com>, "Chen,
 Jiansong \(Simon\)" <Jiansong.Chen@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Official Use Only - Internal Distribution Only]

Reviewed-by: Kenneth Feng <kenneth.feng@amd.com>


-----Original Message-----
From: Jiansong Chen <Jiansong.Chen@amd.com> 
Sent: Monday, August 17, 2020 10:46 PM
To: amd-gfx@lists.freedesktop.org
Cc: Zhou1, Tao <Tao.Zhou1@amd.com>; Feng, Kenneth <Kenneth.Feng@amd.com>; Chen, Jiansong (Simon) <Jiansong.Chen@amd.com>
Subject: [PATCH] Revert "drm/amdgpu: disable gfxoff for navy_flounder"

This reverts commit 6a72ad7e387c6fec821c230fda3460f79fc0f877.
Newly released sdma fw (51.52) provides a fix for the issue.
---
 drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
index e87d43537013..e527be22a3d5 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
@@ -3610,9 +3610,6 @@ static void gfx_v10_0_check_gfxoff_flag(struct amdgpu_device *adev)
 		if (!gfx_v10_0_navi10_gfxoff_should_enable(adev))
 			adev->pm.pp_feature &= ~PP_GFXOFF_MASK;
 		break;
-	case CHIP_NAVY_FLOUNDER:
-		adev->pm.pp_feature &= ~PP_GFXOFF_MASK;
-		break;
 	default:
 		break;
 	}
-- 
2.25.1
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
