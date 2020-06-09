Return-Path: <SRS0=75wA=7W=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37408C433E0
	for <amd-gfx@archiver.kernel.org>; Tue,  9 Jun 2020 11:00:40 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 066532078D
	for <amd-gfx@archiver.kernel.org>; Tue,  9 Jun 2020 11:00:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="LQfuTroW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 066532078D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 822826E115;
	Tue,  9 Jun 2020 11:00:39 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2088.outbound.protection.outlook.com [40.107.237.88])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5A7496E115
 for <amd-gfx@lists.freedesktop.org>; Tue,  9 Jun 2020 11:00:38 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bdPorw4tSWtn/XwEubupbXQpFAOS2OdVgVtRuzZnJlNN9WN89IteyvyT/JJ+K6bm5E9FOoslBLyc+nZA5c2XK38nPzWlmUfiYvwGg69UvzmbA4ALF+xTbHfLMtc2iLgouIdYEHyhzsKhPT1ctMkTgy8VWfWJDtANwscP4ZnTRe2XkF8q/NG2FoH+Zca03qFBz1ki7fKG8s+JEzi61Bvm3WqmH5AkVUaUw922eRbKMQYPbwIYqXB0XgAOVULCdA8NpzcoU+6ZXomIpGfEVJOdwcccWqLdqxeCIznPAhPLNtDJnsSgyO9/dqutrCwLhZLFNnAWf5fRLZUzSLSLMViKTQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9fKSdMPhkQJxP2uLUAHPMVGbSGmyPZaAxBquMPvO4RU=;
 b=Zy4wdJr043CFX2OvOArIOHigAsGeOWT0HXIKvi7tTqyRGoMImxpoHixqLWWXGU2/X+AU0QRno/7siVHpwm04gKuS5G5W/tWg91UBpC0vQhH32eoSM1yG/S5i7LqZCngQ0QSG5+1BHOzl4FiJdPMsYLcPqSOSd7FFZrGbcgdNbFY9TUTeQv+4IAVbJlVrJafz8k4ql3PrsX27xum+ZF/4O9vnoHpe63Tvm1JJo3MXbMA38sDDKe+DpH0teVN7gu/fJXqTE7yxMcPO6CUnOZ0E5Q7j0JO+JvyxUl2+EPkERf4PpExqXv5H0p0sdOm/2D+DbGKUqNl7/3J7rZc882aooA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9fKSdMPhkQJxP2uLUAHPMVGbSGmyPZaAxBquMPvO4RU=;
 b=LQfuTroWTwtBwHzY3e43zKTC82eMilDu28oNIJzUoGCp7mp255/Q+cLcZzHOCkzZckXcd1oD6pfS5QjApaQOqmAjYeA8kNCPJN3aQiRgxYdIpobT84SIf9m/4IPshH9xIznXFlOfFImyhhyQo/kcHExzGXddZRcLBYvILE84XmE=
Received: from MW2PR12MB2444.namprd12.prod.outlook.com (2603:10b6:907:11::12)
 by MW2PR12MB2492.namprd12.prod.outlook.com (2603:10b6:907:8::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3066.18; Tue, 9 Jun
 2020 11:00:35 +0000
Received: from MW2PR12MB2444.namprd12.prod.outlook.com
 ([fe80::e136:57ed:ea00:a70a]) by MW2PR12MB2444.namprd12.prod.outlook.com
 ([fe80::e136:57ed:ea00:a70a%6]) with mapi id 15.20.3066.023; Tue, 9 Jun 2020
 11:00:35 +0000
From: "Chauhan, Madhav" <Madhav.Chauhan@amd.com>
To: "Liu, Cheng Zhe" <ChengZhe.Liu@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amd/amdgpu: handle return value of
 amdgpu_driver_load_kms
Thread-Topic: [PATCH] drm/amd/amdgpu: handle return value of
 amdgpu_driver_load_kms
Thread-Index: AQHWPj9d/AvF62Il4EKwENAvbUNOgKjQF0Ig
Date: Tue, 9 Jun 2020 11:00:35 +0000
Message-ID: <MW2PR12MB2444B2C004C31D3DB2CDC3CA9C820@MW2PR12MB2444.namprd12.prod.outlook.com>
References: <20200609092017.578945-1-ChengZhe.Liu@amd.com>
In-Reply-To: <20200609092017.578945-1-ChengZhe.Liu@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f2ed062d-8486-4f50-a4f1-3cce0dd00d64_Enabled=true;
 MSIP_Label_f2ed062d-8486-4f50-a4f1-3cce0dd00d64_SetDate=2020-06-09T10:36:55Z; 
 MSIP_Label_f2ed062d-8486-4f50-a4f1-3cce0dd00d64_Method=Privileged;
 MSIP_Label_f2ed062d-8486-4f50-a4f1-3cce0dd00d64_Name=Non-Business;
 MSIP_Label_f2ed062d-8486-4f50-a4f1-3cce0dd00d64_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_f2ed062d-8486-4f50-a4f1-3cce0dd00d64_ActionId=78a37127-5971-4962-afb6-0000b1526cc1;
 MSIP_Label_f2ed062d-8486-4f50-a4f1-3cce0dd00d64_ContentBits=0
msip_label_f2ed062d-8486-4f50-a4f1-3cce0dd00d64_enabled: true
msip_label_f2ed062d-8486-4f50-a4f1-3cce0dd00d64_setdate: 2020-06-09T11:00:32Z
msip_label_f2ed062d-8486-4f50-a4f1-3cce0dd00d64_method: Privileged
msip_label_f2ed062d-8486-4f50-a4f1-3cce0dd00d64_name: Non-Business
msip_label_f2ed062d-8486-4f50-a4f1-3cce0dd00d64_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_f2ed062d-8486-4f50-a4f1-3cce0dd00d64_actionid: 812ec6d9-3f5f-431e-a270-0000a0f2fd0d
msip_label_f2ed062d-8486-4f50-a4f1-3cce0dd00d64_contentbits: 0
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [122.171.211.118]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: a96381dc-e1d1-45cb-f78b-08d80c645634
x-ms-traffictypediagnostic: MW2PR12MB2492:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MW2PR12MB249216E793E988ED49CD74249C820@MW2PR12MB2492.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:628;
x-forefront-prvs: 042957ACD7
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: PFggMLJMqHb23MoKgkBg9ST7oIdB3HOPQ+S/E51oWKWs1YazDnVN9HV9b6TfguL7OGB26/nkz6XL1ggJ+JmVka8HMCVCiK/p9NJvCRVzCojAexYNCLYA2WhamaP6StDsZHZ451T5eJOXiaxCdE7ij7SBhBkHqyYeFeNrOOM2FHvUYwTtXWvS5rMxLRGUSbYFsnyx9DvsBzltSSUF+KWqLHebBwfdT0I9m/tWQdpnnQ+W3ylvj45vbzai/YXjwRk9WaeFHoOJMqTjrCgOSEPnYAPLwvAWBS+ov2BfoLO7KnvZS4pUHaP9awLoFbPfcCNrX1WMllYpZob2WpUHQbQeXQ==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MW2PR12MB2444.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(396003)(346002)(136003)(39860400002)(366004)(376002)(9686003)(55016002)(478600001)(33656002)(316002)(2906002)(86362001)(7696005)(53546011)(71200400001)(83380400001)(110136005)(186003)(6506007)(8936002)(66946007)(66476007)(8676002)(26005)(76116006)(4326008)(5660300002)(66556008)(64756008)(66446008)(52536014);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: yURQuCdktWOypqvJma/S5RZzOtDNE+VpPi5h+YCDGqooLsR015EV6D3zpYYxoi3hg3yInCBCzrWdTLPIQb1wtuyK7bhq5YiPj8Z3fnlr4WzCNZ6KE1NwpfSueradmktpqSnwGDR4efPXcWaWKgCnm8uR84kKJ0m8r7RcNNPQU8e95cZOibjNjq1bt4ohCX7l/CJ4b3/kMLaVmv7X/vInMvECEIvwoZySwxqTN9dV1ExoYvissDQ6kHEVE9bA9NwT/sR+/J5w6M1G2iJX0BR/Hjs5B1MYpF4DP8txwQ+JPBjWtaoEseGMPULSwM1gaKgqM/izciZENtJIPuYXELJLB/qLRmKLa+PTvFzE/GgT+JdZ2GZ+Yz7c9aQkawzcMWj4XiXVT9irsCZz9VXS0/p+LunJ87oKhTlqObdlDeRjbzZB3GSRbVZlTwTQYnFs39VsAnIwo0RVuYoKy5ezdTw/x6aj603zZ643Zf/nq2phevHHnaWVGQXI2c9NUjTdGf98
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a96381dc-e1d1-45cb-f78b-08d80c645634
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Jun 2020 11:00:35.2951 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: izdV1jovTALSWr3reJ6mCyzQgfrnYhMSl5AiRDANsSZ0gKNTh5x0X5XXJCP6NhyRSeAxITCtJhKqbWB674RNiA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW2PR12MB2492
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
Cc: "Liu, Cheng Zhe" <ChengZhe.Liu@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

-----Original Message-----
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Liu ChengZhe
Sent: Tuesday, June 9, 2020 2:50 PM
To: amd-gfx@lists.freedesktop.org
Cc: Liu, Cheng Zhe <ChengZhe.Liu@amd.com>
Subject: [PATCH] drm/amd/amdgpu: handle return value of amdgpu_driver_load_kms

[CAUTION: External Email]

if guest driver failed to enter full GPU access, amdgpu_driver_load_kms will unload kms and free dev->dev_private, drm_dev_register would access null pointer. Driver will enter an error state and can't be unloaded.

Signed-off-by: Liu ChengZhe <mailto:ChengZhe.Liu@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
index 667aad1f15c0..9c81a3d0b546 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
@@ -1165,7 +1165,9 @@ static int amdgpu_pci_probe(struct pci_dev *pdev,

        pci_set_drvdata(pdev, dev);

-       amdgpu_driver_load_kms(dev, ent->driver_data);
+       ret = amdgpu_driver_load_kms(dev, ent->driver_data);
+       if (ret)
+               goto err_pci;

Looks good to me. Reviewed-by: Madhav Chauhan <madhav.chauhan@amd.com>

 retry_init:
        ret = drm_dev_register(dev, ent->driver_data);
--
2.25.1

_______________________________________________
amd-gfx mailing list
mailto:amd-gfx@lists.freedesktop.org
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
