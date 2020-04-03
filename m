Return-Path: <SRS0=u9ZA=5T=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3423C2BA18
	for <amd-gfx@archiver.kernel.org>; Fri,  3 Apr 2020 04:42:08 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 944F72063A
	for <amd-gfx@archiver.kernel.org>; Fri,  3 Apr 2020 04:42:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="XQq9CVSK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 944F72063A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 401596E1B4;
	Fri,  3 Apr 2020 04:42:08 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2056.outbound.protection.outlook.com [40.107.94.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3E7C46E1B4
 for <amd-gfx@lists.freedesktop.org>; Fri,  3 Apr 2020 04:42:07 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RIqAgi+pohmfYKFzcJW+pAsN6UnGJlee4kAXr/AqhOS/bYT8g5+GMmyHwcSAy/ZaQs1V1JDI9XXlZug4mOFmkL9dYY2T0/I4Kg1NnAPfuXchn3WWyDoEjyAyw9o9V9DfG0KHRq3L5yLaWJaVpQzYN9nBOotKSr0//EquaJFI8cKUaI8A+ffOHez9Imvaatg/ES+q4ENYHylzqOi8uIPKEEi13PJTpJgxcQ2IRHjFj+yd28jUBZuhCtjPReXN3RwH7h5o256O2+B0Md70V2VhhJN7b50WEGhDGem86HHVU38vHD3oN2LPJc9RSFK3sZdaY/gYCWyv+uYXGln5RNwbIQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mtXiB7tTbHq6G5h8TGn9fzabBNxb6LydY3pm4Ct4O68=;
 b=MFhg7QKmMEu38cfls9V1hbKtgTdbfcAESXs31T9fX+TDjBTKbkfObOl9kQvNmNGT4by+kk+Erayw2I3ppKD4b5a/bCe3GTUdx1CCWOg0zubuKOUD12kKN5QChArKwU2c0x5LWxtAoMTCReJe1JGi8IPDWUGkcyHjhezflsEtJpQRxHEELlpQ/ha++SEwcegXHZNcWQ77B6pom+ueOEvbVr5sekfrY5cM15Xi4pTrZPXws7jdeOOl4I1GM6HdoGr6yyzFOQMVyzenVXmKtjkqzpkIzqx26lVNeSDQnhdwzYvIp60ipVMmWjd0FEj45LAZAbhHC0Xeo74Jfz9stXp3rg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mtXiB7tTbHq6G5h8TGn9fzabBNxb6LydY3pm4Ct4O68=;
 b=XQq9CVSKyl8KQHwg2bLtwdmyeGLQRKvT0GShU4OyYX38DREQnnzk3/h2thB5IBNw+4n/iv4bBUlvTheb8VYT0wsrK2IDsFaCEd9aPeZ/UzcPmbzmCaXE7HTSJTtSobfMn6RVyR+ZJIRzvaROC+dy71ig+hKnu1/3lGhBR1VdnOM=
Received: from MN2PR12MB3775.namprd12.prod.outlook.com (2603:10b6:208:159::19)
 by MN2PR12MB3472.namprd12.prod.outlook.com (2603:10b6:208:d2::33)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2878.17; Fri, 3 Apr
 2020 04:42:06 +0000
Received: from MN2PR12MB3775.namprd12.prod.outlook.com
 ([fe80::1c3c:dd52:2b19:4462]) by MN2PR12MB3775.namprd12.prod.outlook.com
 ([fe80::1c3c:dd52:2b19:4462%7]) with mapi id 15.20.2878.017; Fri, 3 Apr 2020
 04:42:05 +0000
From: "Zhou, Tiecheng" <Tiecheng.Zhou@amd.com>
To: "Zhou, Tiecheng" <Tiecheng.Zhou@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amd/powerplay: avoid using pm_en before it is
 initialized
Thread-Topic: [PATCH] drm/amd/powerplay: avoid using pm_en before it is
 initialized
Thread-Index: AQHWCNEYhnGGnPkw0kmy2xmo7sN/K6hm0r8w
Date: Fri, 3 Apr 2020 04:42:05 +0000
Message-ID: <MN2PR12MB377583766525C1130B8FD895E4C70@MN2PR12MB3775.namprd12.prod.outlook.com>
References: <20200402092833.30558-1-Tiecheng.Zhou@amd.com>
In-Reply-To: <20200402092833.30558-1-Tiecheng.Zhou@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Enabled=true;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SetDate=2020-04-03T04:42:01Z; 
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Method=Standard;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Name=Internal Use Only -
 Unrestricted;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ActionId=36746590-739e-4baa-b77f-00001b8b7407;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ContentBits=1
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_enabled: true
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_setdate: 2020-04-03T04:42:01Z
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_method: Standard
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_name: Internal Use Only -
 Unrestricted
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_actionid: fe75bd1c-d83a-4e06-99f2-0000f4331677
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_contentbits: 0
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Tiecheng.Zhou@amd.com; 
x-originating-ip: [117.135.125.126]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: c53623c2-072d-46cb-5b62-08d7d7895c8e
x-ms-traffictypediagnostic: MN2PR12MB3472:|MN2PR12MB3472:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MN2PR12MB3472B3BB19D5D0945157DBD9E4C70@MN2PR12MB3472.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:5516;
x-forefront-prvs: 0362BF9FDB
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB3775.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(10009020)(4636009)(366004)(136003)(396003)(346002)(39860400002)(376002)(81156014)(8936002)(7696005)(8676002)(4326008)(81166006)(6506007)(478600001)(2906002)(53546011)(186003)(26005)(33656002)(316002)(55016002)(9686003)(66556008)(64756008)(52536014)(66476007)(76116006)(71200400001)(66446008)(86362001)(66946007)(5660300002)(110136005);
 DIR:OUT; SFP:1101; 
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: njqo+fctSSBfWwkU1HoBFftmP+eXxDWSYQO5V8D86E1GYehRGvBrzMNEtRI9zIg+Zt9UERnqMsN+O8vmcJ58mCIpSGrXC0k0TNzcQApFIcN7WrgN/xhriKaEzT263irKduWghXmW6fj6RBWUcSQYiVw/F0RfHTOpaTaizaXHEOKg2+0P/IvKnYGEnw3VWqRju9wCOrLYKuKqq6YmBs0Rjp50R91gfldBvU33aaC8alqm0l8wFKHEDd+nEEBWpAAgazPx4MZjbRu1T5gRn8T0l7y3RtvNNHgwIOOHkbwNmaOD9xuXogQj4jLZPkPF3GVQxzyVQYPf3q3YgLjLwh6Wn1oTtuDhO6F38Bp5Iwd4hgtl5qIb2cdn5MqT+5UgmpEeAoRlVkg9PxMnsiK+YnVHe0w2H9UAE5g6wJnINQFIkzFrdgIy6qB3u7h7Vu1CByhy
x-ms-exchange-antispam-messagedata: YbKpV0GNuX2bMgVAMoNOxYpyaS1KLoyQBkJR7leTW1LDcl01Zb8ce+EKionb6+O730y+Vj3J+03+OXGVJaoME38CBqBDaIF3n2dbCa3GQQe+2QDYXBhyiQy6QZoUofuaXbp0nXhL78tA00jDR38ppA==
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c53623c2-072d-46cb-5b62-08d7d7895c8e
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Apr 2020 04:42:05.8859 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: S2q0AS7cG+Mu3AJRk/mxp3eQmJn1cSuJXKhl8iLLvB3eYGcCaorXXWx0BuRrzeHY
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3472
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
Cc: "Tao, Yintian" <Yintian.Tao@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Official Use Only - Internal Distribution Only]

Ping...

-----Original Message-----
From: Tiecheng Zhou <Tiecheng.Zhou@amd.com> 
Sent: Thursday, April 2, 2020 5:29 PM
To: amd-gfx@lists.freedesktop.org
Cc: Zhou, Tiecheng <Tiecheng.Zhou@amd.com>; Tao, Yintian <Yintian.Tao@amd.com>
Subject: [PATCH] drm/amd/powerplay: avoid using pm_en before it is initialized

hwmgr->pm_en is initialized at hwmgr_hw_init.
during amdgpu_device_init, there is amdgpu_asic_reset that calls to pp_get_asic_baco_capability, while hwmgr->pm_en has not yet been initialized.

so avoid using pm_en in pp_get_asic_baco_capability.

Signed-off-by: Tiecheng Zhou <Tiecheng.Zhou@amd.com>
Signed-off-by: Yintian Tao <yttao@amd.com>
---
 drivers/gpu/drm/amd/powerplay/amd_powerplay.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/powerplay/amd_powerplay.c b/drivers/gpu/drm/amd/powerplay/amd_powerplay.c
index 71b843f542d8..fdff3e1c5e95 100644
--- a/drivers/gpu/drm/amd/powerplay/amd_powerplay.c
+++ b/drivers/gpu/drm/amd/powerplay/amd_powerplay.c
@@ -1455,7 +1455,8 @@ static int pp_get_asic_baco_state(void *handle, int *state)
 	if (!hwmgr)
 		return -EINVAL;
 
-	if (!hwmgr->pm_en || !hwmgr->hwmgr_func->get_asic_baco_state)
+	if (!(hwmgr->not_vf && amdgpu_dpm) ||
+		!hwmgr->hwmgr_func->get_asic_baco_state)
 		return 0;
 
 	mutex_lock(&hwmgr->smu_lock);
--
2.17.1
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
