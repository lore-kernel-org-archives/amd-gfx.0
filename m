Return-Path: <SRS0=F+/f=52=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5AE78C2D0EC
	for <amd-gfx@archiver.kernel.org>; Fri, 10 Apr 2020 05:02:44 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 29F0620787
	for <amd-gfx@archiver.kernel.org>; Fri, 10 Apr 2020 05:02:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="dFwMX2ey"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 29F0620787
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CDFD96EC60;
	Fri, 10 Apr 2020 05:02:43 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2054.outbound.protection.outlook.com [40.107.93.54])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4BA376EC5F
 for <amd-gfx@lists.freedesktop.org>; Fri, 10 Apr 2020 05:02:42 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bx2o1RbWMEW8CFFsCDQGsInqS8GEn19CHiOU/QtlkLS4qNSKlturJ7M56O/pAGhfw3ZEpJWnrEXLoSmmmAUEsC7N3CLGVN3td4EKgNBRMLTs4mQF/YGl4qGZ16GLywgyc5SVrXHn/1kLhB8n1fntlLRYxHroQmC1ElG8zY3hhhvR9sTqnRKGytU7jwnYH9mAqKJeNw50p4a1vQ1raOTm8I1NSc+v4LIcLaNKARRskiZotMj5uNZ5tqPXhlBt/MUU0SFhI0w7OECqtKsJdTjf5B1d9XmyhOOlHPEl6/XCw0UzZXDg3k6Tt7cJLkLG3BAwAQzGWneQd2FMFqCFhScnPg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ga9ZoABMZJn1OcspS8DIEPv4nIWnfYWutFy9UtIugLU=;
 b=XOzfmIbnzJsjvwdPTBSp9ADg/SWCFiImOt0gDgOSEgPsghG7g9CYG5bhzwLS9pPvzR3kA8ifIgbFlTVIIYR/jEF3OozD76oR/OOj8WXP1KyMoB9IUZEHGvwQryTtWsiAyNwo1Y8809QAw/10wGaadxRI3saOI5KjoNhic7ABGwAcXirbIKc2Xb9ckDnS/M1TLfzLtdJcKZ3nkaEaLIeRrh70lsXyBeO1U+1WEtZ21o4OssBThIpJcT/v14Uaiv+DT/u8/Fcir9+E5aMKbZrM34LcF3jMPUt/OruJJHbt78rGsDG8lRXAyb+XIU7L+F5+JLDyFTTatT0gvqdks3SDCw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ga9ZoABMZJn1OcspS8DIEPv4nIWnfYWutFy9UtIugLU=;
 b=dFwMX2eyIkg4wBZOlXks3Ri9Qaah1vck0YO+wOFxme4eDRuzm6gXForNRnl9GrKG3Evq2LH8HDyCclNdVbIscswFBtSPDD4AOv4MvYuBaQHaqnw/QXMLZreG/DXqTWgQpuZCDh0JP4In+tdSmdca01TRuMv0qaIfT+YV8I7YR+A=
Received: from BN6PR12MB1283.namprd12.prod.outlook.com (2603:10b6:404:19::8)
 by BN6PR12MB1809.namprd12.prod.outlook.com (2603:10b6:404:106::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2878.20; Fri, 10 Apr
 2020 05:02:37 +0000
Received: from BN6PR12MB1283.namprd12.prod.outlook.com
 ([fe80::60b6:8e56:2853:614a]) by BN6PR12MB1283.namprd12.prod.outlook.com
 ([fe80::60b6:8e56:2853:614a%5]) with mapi id 15.20.2878.022; Fri, 10 Apr 2020
 05:02:37 +0000
From: "Chen, Guchun" <Guchun.Chen@amd.com>
To: "Zhang, Hawking" <Hawking.Zhang@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>, "Li, Dennis" <Dennis.Li@amd.com>, "Zhou1, 
 Tao" <Tao.Zhou1@amd.com>, "Clements, John" <John.Clements@amd.com>
Subject: RE: [PATCH] drm/amdgpu: add uncorrectable error count print in UMC
 ecc irq cb
Thread-Topic: [PATCH] drm/amdgpu: add uncorrectable error count print in UMC
 ecc irq cb
Thread-Index: AQHWDuvqsSAWGrZhHEW++nfZhlP1CqhxywAAgAABXIA=
Date: Fri, 10 Apr 2020 05:02:37 +0000
Message-ID: <BN6PR12MB12835D42328D30CD718B0382F1DE0@BN6PR12MB1283.namprd12.prod.outlook.com>
References: <20200410035528.27347-1-guchun.chen@amd.com>
 <DM6PR12MB4075902286A10D35E42015D1FCDE0@DM6PR12MB4075.namprd12.prod.outlook.com>
In-Reply-To: <DM6PR12MB4075902286A10D35E42015D1FCDE0@DM6PR12MB4075.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Enabled=true;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_SetDate=2020-04-10T05:02:10Z; 
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Method=Privileged;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Name=Public_0;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_ActionId=1c99be12-fd0a-416b-88df-0000b136d3e1;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_ContentBits=1
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_enabled: true
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_setdate: 2020-04-10T05:02:34Z
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_method: Privileged
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_name: Public_0
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_actionid: fa85d05b-3532-4f4d-8d02-00002f49fa21
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_contentbits: 0
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Guchun.Chen@amd.com; 
x-originating-ip: [180.167.199.189]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 049d2aed-af46-4678-aa8d-08d7dd0c63a4
x-ms-traffictypediagnostic: BN6PR12MB1809:|BN6PR12MB1809:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BN6PR12MB18097FAEFB6FD2D660C721BAF1DE0@BN6PR12MB1809.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-forefront-prvs: 0369E8196C
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN6PR12MB1283.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(10009020)(4636009)(346002)(366004)(376002)(39860400002)(396003)(136003)(64756008)(26005)(186003)(66446008)(33656002)(7696005)(53546011)(55016002)(8936002)(66476007)(9686003)(66946007)(110136005)(6636002)(76116006)(478600001)(66556008)(6506007)(86362001)(52536014)(316002)(81156014)(5660300002)(8676002)(71200400001)(2906002);
 DIR:OUT; SFP:1101; 
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 0ZXjQcRTd4L3oCgJckEe6H1hk+kyRSIeMXYzG91TqbVm+FTs1xw7aExsmRIX1AaHnBTiU7z6MyWthvQNHESEV5E7Y63b4hWmW8xRTTfK1nNBheTupm+aSzo4jETGJLgddDwEBoygZCNMX4gxw7NELvV/C+gnNfEsHINxg3aA/z3KOeH8tqoW4F7eu7zIkr2PhLMM5Ak+OQgsb8ZyEwBM1f8rhhJgYa7gYoKnBHQlLJ7VqRY5zBi4H1wgiace5H/YTLeXfeAt4ppB/u5Bkzf4t82GdUYj5pFZyszpsp73qNi3Nlx/DsGQAVw/gRcZtORg3BlOErYMKaliD9utHZAUM05SXx6jlVMQVA4Jjgml17E/kGDBr4UXMNsauCfLGT8UC2pZYxYI60YMVcBaPI8KaQU29k9BHYrYJCvhqm1xceeR9GpmvMi204Y0lj3pAvAd
x-ms-exchange-antispam-messagedata: I8GLHS0Q+ywDCqxM3ixeq3wG+U/M93WPkGjV11QLz967wDERLC4tAI2/fLoWwjq8+N9hTGOsxCzM0OBPVKHNKelpvx4XVcueUqMYnJPUiC1CilIw1gPn7Qs9Fxdx2/3MWTjft2rXv0b7Ob2KW6ZV3w==
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 049d2aed-af46-4678-aa8d-08d7dd0c63a4
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Apr 2020 05:02:37.5807 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: vTnM3Bp0soQI2yjR2wOCrhZA8W1hpN7rZGIS0w8owf8DQgINfgoq28NRz6wfpWjKNAiUDyCEcR6hFj7qtT8NgA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR12MB1809
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Public Use]

Sure Hawking. I will submit patches to address these.

Regards,
Guchun

-----Original Message-----
From: Zhang, Hawking <Hawking.Zhang@amd.com> 
Sent: Friday, April 10, 2020 12:57 PM
To: Chen, Guchun <Guchun.Chen@amd.com>; amd-gfx@lists.freedesktop.org; Li, Dennis <Dennis.Li@amd.com>; Zhou1, Tao <Tao.Zhou1@amd.com>; Clements, John <John.Clements@amd.com>
Subject: RE: [PATCH] drm/amdgpu: add uncorrectable error count print in UMC ecc irq cb

[AMD Official Use Only - Internal Distribution Only]

Hello Guchun,

Besides this, could you please also make a patch to replace DRM_INFO with dev_info in amdgpu_ras_check_supported. Basically, we'd prefer to have device bdf as the prefix in RAS related wording in kernel message, instead of DRM pre-fix.

Please also have a review again on the other RAS wording in case there is still use DRM_INFO for the print out message. We shall let user know exactly gpu device for any RAS error information.

Regards,
Hawking
-----Original Message-----
From: Chen, Guchun <Guchun.Chen@amd.com> 
Sent: Friday, April 10, 2020 11:55
To: amd-gfx@lists.freedesktop.org; Zhang, Hawking <Hawking.Zhang@amd.com>; Li, Dennis <Dennis.Li@amd.com>; Zhou1, Tao <Tao.Zhou1@amd.com>; Clements, John <John.Clements@amd.com>
Cc: Chen, Guchun <Guchun.Chen@amd.com>
Subject: [PATCH] drm/amdgpu: add uncorrectable error count print in UMC ecc irq cb

Uncorrectable error count printing is missed when issuing UMC UE injection. When going to the error count log function in GPU recover work thread, there is no chance to get correct error count value by last error injection and print, because the error status register is automatically cleared after reading in UMC ecc irq callback. So add such message printing in UMC ecc irq cb to be consistent with other RAS error interrupt cases.

Signed-off-by: Guchun Chen <guchun.chen@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_umc.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_umc.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_umc.c
index f4d40855147b..267f7c30f4dd 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_umc.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_umc.c
@@ -121,6 +121,9 @@ int amdgpu_umc_process_ras_data_cb(struct amdgpu_device *adev,
 
 	/* only uncorrectable error needs gpu reset */
 	if (err_data->ue_count) {
+		dev_info(adev->dev, "%ld uncorrectable errors detected in UMC block\n",
+			err_data->ue_count);
+
 		if (err_data->err_addr_cnt &&
 		    amdgpu_ras_add_bad_pages(adev, err_data->err_addr,
 						err_data->err_addr_cnt))
--
2.17.1
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
