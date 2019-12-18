Return-Path: <SRS0=4PMp=2I=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE599C43603
	for <amd-gfx@archiver.kernel.org>; Wed, 18 Dec 2019 10:30:03 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 94635218AC
	for <amd-gfx@archiver.kernel.org>; Wed, 18 Dec 2019 10:30:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="Y5j2OapW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 94635218AC
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8FD6388894;
	Wed, 18 Dec 2019 10:30:01 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2071.outbound.protection.outlook.com [40.107.244.71])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EF61D88647
 for <amd-gfx@lists.freedesktop.org>; Wed, 18 Dec 2019 10:29:59 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Na9CGBHgPmvx2NGLUqGWCPxGYWQDFGYfrzkntLh9d1upQ2uDluR1E25/6BBGGEcSqxnFhTinNARvgoA+W83guMvb4wVgFxbfE86aPrGxKGh6ZzRtezaG4f/oI3TZUv3dAaA0+hnrnCVaVphg+pjfcUYnVZAXWeFyQeq4KpkuoRCv54aTo6Cxw1aVM7fcMfMymy4JNi5Uq0/hty+W9cC5CetMvG3ybBZFilKshsjjEgBd3RQ1Q9fS+PwjePc9N+xaz3cKZpm1foTSjKsdio983HzzvST8NkOrR1YF5EsxHYDFxrzWvUcyNj0DH7DjYWdq3Sgj5q9qrMyJ4rSw19GvZw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sfWme57wL0MLcJjwZ6SSCdm6GhQL0OiN8fnSuvHYxqY=;
 b=fHgGRhcKjPpIV6l7VUlACvcJdPcvBy3I6blD1v9LTdbYJ4f80UKB8fBf5SRZYjOPBM3k5wtFTw1GB6g398MV5vZDAyyET1F70uws5W2do4bUUuqd4lrtOZnqNoPT/5HZKQj9ESnPdn6xVhQFAjorlp+5Kb0hA4COkXeM22GzDPgO7KO6htLmK2jzn93C5+BiL9rzhmpRwrspfz9sg8Nv+SdA2viQ5pXwMRF0EPHplQf7fcApT0qki9QYDH4Gdmu/0tbOZyRAFFMEodM9wpBRpAAFgtIlypvtGK1+iSjXTXXQzuMKhI54gky0jzZbzHCtlyK4mdgLAjiafBLC+Tludw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sfWme57wL0MLcJjwZ6SSCdm6GhQL0OiN8fnSuvHYxqY=;
 b=Y5j2OapWAegFyar9pOv/BwSwovUdXTmRRIMHmW1lkXaiO574QZluo6ODR5VLsyAIuTHhWXdTXCMIb/RgFfuz7G8zM1ApAYRk8UUcLDUbcF4h9+aC4SbjHyoutfKOuEWvf/60Na4ELOa/ovrNQ07xpaS3mfoKBQWN7j8imfbw9Is=
Received: from MN2PR12MB3598.namprd12.prod.outlook.com (20.178.244.84) by
 MN2PR12MB3709.namprd12.prod.outlook.com (10.255.237.158) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2559.14; Wed, 18 Dec 2019 10:29:58 +0000
Received: from MN2PR12MB3598.namprd12.prod.outlook.com
 ([fe80::58ae:be91:c063:b2a1]) by MN2PR12MB3598.namprd12.prod.outlook.com
 ([fe80::58ae:be91:c063:b2a1%6]) with mapi id 15.20.2559.012; Wed, 18 Dec 2019
 10:29:58 +0000
From: "Feng, Kenneth" <Kenneth.Feng@amd.com>
To: "Tao, Yintian" <Yintian.Tao@amd.com>
Subject: RE: [PATCH] drm/amd/powerplay: skip disable dynamic state management
Thread-Topic: [PATCH] drm/amd/powerplay: skip disable dynamic state management
Thread-Index: AQHVtYwYZ+zvdomd+kS3btG1MF/UT6e/sM1Q
Date: Wed, 18 Dec 2019 10:29:58 +0000
Message-ID: <MN2PR12MB35989F89AAD7F0692CF998E78E530@MN2PR12MB3598.namprd12.prod.outlook.com>
References: <20191218101515.22327-1-yttao@amd.com>
In-Reply-To: <20191218101515.22327-1-yttao@amd.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Enabled=true;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SetDate=2019-12-18T10:29:47Z; 
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Method=Standard;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Name=Internal Use Only -
 Unrestricted;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ActionId=938954c4-00f5-4a2a-9a2d-0000930616ac;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ContentBits=1
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_enabled: true
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_setdate: 2019-12-18T10:29:47Z
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_method: Standard
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_name: Internal Use Only -
 Unrestricted
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_actionid: 9d47ee43-6f7a-414a-8d76-00008137061e
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_contentbits: 0
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Kenneth.Feng@amd.com; 
x-originating-ip: [180.167.199.189]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: d5bed3f8-8f2e-4778-317a-08d783a53b4c
x-ms-traffictypediagnostic: MN2PR12MB3709:|MN2PR12MB3709:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MN2PR12MB370932F9D4A4A82820C039968E530@MN2PR12MB3709.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:1227;
x-forefront-prvs: 0255DF69B9
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(4636009)(366004)(136003)(39860400002)(346002)(376002)(396003)(199004)(189003)(13464003)(66946007)(66556008)(316002)(6636002)(66446008)(64756008)(53546011)(4744005)(6506007)(54906003)(9686003)(71200400001)(76116006)(55016002)(2906002)(52536014)(4326008)(6862004)(186003)(5660300002)(66476007)(33656002)(26005)(8936002)(478600001)(86362001)(81166006)(81156014)(8676002)(7696005);
 DIR:OUT; SFP:1101; SCL:1; SRVR:MN2PR12MB3709;
 H:MN2PR12MB3598.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: R4yYwblk8iPzSOj8mL9RQDRMEwj71vKOBUH81MpWbZrSIX7/rLdPtWyscwq98aqrMK16OS5hagPJ1Fn456cohxTGdKaHIjz/OzkzPgm/k1Jjdn+GeAF88or1V/sXvr9c1qiAQUMjxYsm24pMZvlPXsxAN0kByYwFijVON4rLBSTioVC1JsD6xNbo36BaddUDAJjG+ht9cyWKxQ8RrB9ixorz3Vl+eTtHXy2wmzbxNOV60/PD58wNJIg6p7ERtOPXklZr74DEHt4V7KVqD/GfseYcygW0pcdYQuBz6EMLJ4WXXlKkMT3XGViY1R9GqulnTt/sY6DZ5pC4omtZN8pfSryUcDWOoK2Xm6tYeQXigVWAjrVkD0w5XP9BijZjJ9RINOVi6CGiZdx4kTU98omfdfcb4EhJwVWw/ds3QhX3UUrxnBvtzS+4J4PH9IrdF0M/yZ32Ozxll70/4Kw8PXQb7Hqp/9e1/vR7Pg4EaK79Ps06gjYAPmWXlTQ6uWweyivT
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d5bed3f8-8f2e-4778-317a-08d783a53b4c
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Dec 2019 10:29:58.2906 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: s5nNv7a+aWBeAUs7VqdQEn1hX6V/fS3ajH3k4VyLy8FLhATQqnsgNxval0U/V+rv
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3709
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
Cc: "Tao, Yintian" <Yintian.Tao@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Official Use Only - Internal Distribution Only]

Reviewed-by: Kenneth Feng <kenneth.feng@amd.com>


-----Original Message-----
From: Yintian Tao <yttao@amd.com> 
Sent: Wednesday, December 18, 2019 6:15 PM
To: Feng, Kenneth <Kenneth.Feng@amd.com>
Cc: amd-gfx@lists.freedesktop.org; Tao, Yintian <Yintian.Tao@amd.com>
Subject: [PATCH] drm/amd/powerplay: skip disable dynamic state management

Under sriov, the disable operation is no allowed.

Signed-off-by: Yintian Tao <yttao@amd.com>
---
 drivers/gpu/drm/amd/powerplay/hwmgr/hardwaremanager.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/gpu/drm/amd/powerplay/hwmgr/hardwaremanager.c b/drivers/gpu/drm/amd/powerplay/hwmgr/hardwaremanager.c
index 253860d30b20..9454ab50f9a1 100644
--- a/drivers/gpu/drm/amd/powerplay/hwmgr/hardwaremanager.c
+++ b/drivers/gpu/drm/amd/powerplay/hwmgr/hardwaremanager.c
@@ -99,6 +99,9 @@ int phm_disable_dynamic_state_management(struct pp_hwmgr *hwmgr)
 
 	PHM_FUNC_CHECK(hwmgr);
 
+	if (!hwmgr->not_vf)
+		return 0;
+
 	if (!smum_is_dpm_running(hwmgr)) {
 		pr_info("dpm has been disabled\n");
 		return 0;
-- 
2.17.1
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
