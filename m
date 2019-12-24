Return-Path: <SRS0=l0jK=2O=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 013D2C2D0C3
	for <amd-gfx@archiver.kernel.org>; Tue, 24 Dec 2019 05:05:29 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AC0D720706
	for <amd-gfx@archiver.kernel.org>; Tue, 24 Dec 2019 05:05:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="1LjmVVc9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AC0D720706
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 65C756E5A9;
	Tue, 24 Dec 2019 05:05:29 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2055.outbound.protection.outlook.com [40.107.237.55])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2430289D67
 for <amd-gfx@lists.freedesktop.org>; Tue, 24 Dec 2019 05:05:28 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GFetqCdP41ZeYVOJfKMJSnGeUzlGM4Qsx3F8LGVgEs69hhE50kJLDuBxEafJLOpFeMKavOYewiNIv49faAEKZ2iuJSqiLdrefHAELF0jqLq/hjGLdLtBhIuPghnt1T6W0ZNMlD8SU6vi4jjDYf5qJpSytGwrPFhYn2PAMyAdnwK9qs+0BLoZzd7UrskJ4amFGWbxBJZjRQh/Q+UqMwn3RBYlwPNn/Z3vFZ3GLxGpM40tepvSBRqY5fWmoPpAWBNYNoFE6+l4K2NXZIbC0Xce3N6HPiRmW9wl3XkldYOFKsXYSeJFnrnFUfoOSe80sfOW+yDX3vTiLaT/Q0Sx9zJKdQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZtTCiV44bhX9jzjJWb5e9d3NPOBa5tV8B8lQBjMUxU8=;
 b=bdGwfOkR2iKL6xp0uvX8igtiARGQiwp7hFLY3/ORKkBAbMve6RUA5RI5w9RO6fFim/kMB2yBZvtFEWoJ6D38zagyq2BEYwBT9OK4QLEBPKplTA34I+JxJztrkLu5+uckW/4PVM5DyM8ikNMdX+A0Tl/7mkReXIuhu5LqAr5QvOLDPGYC9yu9a05ta+I1GF6Ur4Lt+aS5TaxDrSGkg3tbEfZWaXW10BSes+5deb23Re+5kK8RIrFZvnDH30IcZ+O7jddqjcuoG+e/ILC9tdhaLbQRJN74tBIWs9c/c/EtbWRR/CVNED/i56URwglXroVdlJhPxjgy8QesOpjuEVGmKw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZtTCiV44bhX9jzjJWb5e9d3NPOBa5tV8B8lQBjMUxU8=;
 b=1LjmVVc9PswbyOeQ5L+YmmHWl76kqm2j9Y/CR78PZ3V5m8u+m9Y4UOWQBJvT9SlvVnWi5O78Jk7n9gaSxrZv5mslri+0/ph3aORGf0aRBQdbM5HWO6PfLNHztdnb3H7rB6bPnkopoEak2yzq6fNmOEeI1Xh96hqsCn0rANjMbVo=
Received: from CH2PR12MB3672.namprd12.prod.outlook.com (52.132.246.139) by
 CH2PR12MB3895.namprd12.prod.outlook.com (52.132.245.205) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2559.16; Tue, 24 Dec 2019 05:05:26 +0000
Received: from CH2PR12MB3672.namprd12.prod.outlook.com
 ([fe80::8dbe:e9a8:801e:9b9d]) by CH2PR12MB3672.namprd12.prod.outlook.com
 ([fe80::8dbe:e9a8:801e:9b9d%7]) with mapi id 15.20.2559.016; Tue, 24 Dec 2019
 05:05:26 +0000
From: "Zhang, Jack (Jian)" <Jack.Zhang1@amd.com>
To: "Wang, Kevin(Yang)" <Kevin1.Wang@amd.com>, "Feng, Kenneth"
 <Kenneth.Feng@amd.com>, "Quan, Evan" <Evan.Quan@amd.com>, "Zhang, Jack
 (Jian)" <Jack.Zhang1@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amd/powerplay free driver_pptable for smu reinit
Thread-Topic: [PATCH] drm/amd/powerplay free driver_pptable for smu reinit
Thread-Index: AQHVuhemLl+B7+75+0qe2ZQ2gTLpLqfIuyRw
Date: Tue, 24 Dec 2019 05:05:25 +0000
Message-ID: <CH2PR12MB3672B764698E7096C75B1ABABB290@CH2PR12MB3672.namprd12.prod.outlook.com>
References: <20191224050436.14641-1-Jack.Zhang1@amd.com>
In-Reply-To: <20191224050436.14641-1-Jack.Zhang1@amd.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Jack.Zhang1@amd.com; 
x-originating-ip: [180.167.199.189]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: f3dee362-efb1-4589-6bf7-08d7882ee354
x-ms-traffictypediagnostic: CH2PR12MB3895:|CH2PR12MB3895:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <CH2PR12MB38956C9A0E667EF7CC8EEC88BB290@CH2PR12MB3895.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:4125;
x-forefront-prvs: 0261CCEEDF
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(4636009)(39860400002)(136003)(346002)(366004)(396003)(376002)(13464003)(189003)(199004)(5660300002)(66446008)(55016002)(53546011)(478600001)(66946007)(66556008)(64756008)(66476007)(6506007)(110136005)(2906002)(9686003)(52536014)(33656002)(7696005)(86362001)(316002)(71200400001)(8936002)(26005)(76116006)(8676002)(186003)(81156014)(81166006);
 DIR:OUT; SFP:1101; SCL:1; SRVR:CH2PR12MB3895;
 H:CH2PR12MB3672.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: G4YXh7WJb5pUu42P8ALbT/mm/XcmEy8nOjS1E6chRZtVuuMCX09ixvmsT2qtk1sZ9t53SaFasYQBh7/anFbvCGPKt/VfkgnKABkKyT17iupkM35eHyF6HSzaD/lydcxzwosJ4SQQ7LdSPQBEDOaipDNvPSu0g/yAnhklEh5sQoD3gJibSt0CvwUFZFbtvSde408NIhtNRzQAmJaVh3D10X/Xfvc/rTTt91vjmXGdMDqALPnDcyxFCYuZpiblFHiGWMIWpXnJbF7qTpnkJicD0xXBs9fGNj/mmV1pN5iqlH87WNQ0esNiGBAkEyzjZN+sqE8XSvq+D7+Jrxtl+JmYk4U+6Nep6WnnO9LcFfWxF/6sDWNkXguJAFQxPzrYpOnuctU1/W6STqVEwoVaUE14zdjInijnZ9222nhEIq5lQ0s9gpZRjdPCqIZKNVJHfIRhsXDk0/+acfndh4Q4kevyjNAtlHJ5dbMBAtQLxpTa7Q1jAhLCrMb+MHP3mZ8GXcdI
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f3dee362-efb1-4589-6bf7-08d7882ee354
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Dec 2019 05:05:25.8989 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: VL2mHYuU8s6VsOreV9oWpk1DLATelHehGV2PUarYjwyKfMqHFeDa4AcdtDu3HMA+
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB3895
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



-----Original Message-----
From: Jack Zhang <Jack.Zhang1@amd.com> 
Sent: Tuesday, December 24, 2019 1:05 PM
To: amd-gfx@lists.freedesktop.org
Cc: Zhang, Jack (Jian) <Jack.Zhang1@amd.com>
Subject: [PATCH] drm/amd/powerplay free driver_pptable for smu reinit

During gpu recover, smu hw reinit will fail becasue table_context->driver_pptable is not freed and set to NULL.

Free the driver_pptable pointer if it's not NULL.

Signed-off-by: Jack Zhang <Jack.Zhang1@amd.com>
---
 drivers/gpu/drm/amd/powerplay/smu_v11_0.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/powerplay/smu_v11_0.c b/drivers/gpu/drm/amd/powerplay/smu_v11_0.c
index 7781d24..ca877bd 100644
--- a/drivers/gpu/drm/amd/powerplay/smu_v11_0.c
+++ b/drivers/gpu/drm/amd/powerplay/smu_v11_0.c
@@ -713,8 +713,10 @@ int smu_v11_0_parse_pptable(struct smu_context *smu)
 	struct smu_table_context *table_context = &smu->smu_table;
 	struct smu_table *table = &table_context->tables[SMU_TABLE_PPTABLE];
 
-	if (table_context->driver_pptable)
-		return -EINVAL;
+	if (table_context->driver_pptable) {
+		kfree(table_context->driver_pptable);
+		table_context->driver_pptable = NULL;
+	}
 
 	table_context->driver_pptable = kzalloc(table->size, GFP_KERNEL);
 
--
2.7.4

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
