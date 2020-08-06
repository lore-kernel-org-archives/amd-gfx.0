Return-Path: <SRS0=X6dN=BQ=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 307FCC433DF
	for <amd-gfx@archiver.kernel.org>; Thu,  6 Aug 2020 14:23:45 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2DD4723121
	for <amd-gfx@archiver.kernel.org>; Thu,  6 Aug 2020 14:23:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="rx5bi0i6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2DD4723121
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A2F446E821;
	Thu,  6 Aug 2020 14:23:44 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2045.outbound.protection.outlook.com [40.107.220.45])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AAAD46E821
 for <amd-gfx@lists.freedesktop.org>; Thu,  6 Aug 2020 14:23:43 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VKpwQ7sKpsiMdyACERS/FQU+2lBzwo0NN0fXbCoc/1iFT7zZA/6u+yMnqff+R/f5zwksW7gWXGs7ctOSS0UswR3AWGsqqXGROJ8AsmD1rRUOGNR1NuzgYJD6mTnZX3dfHdsGTXPYAKjWYNAYMOARsCdu2Sfxz1wTbNmpuR5cUmpgr7VO+IQKdXBR952r13OypuyOPoQ/9/k7dvjPFLqeYgwm9s4aLLOUTHbw8nBtDdDlLPmjgofP6HwSVW4Lij2eyszQOBbjTnJh1dRwL0ZIUon7n3vZuaJKm7iVo2snLVci8JrsmWjRlHdZgafxdaSoJHusjHy1sz3mBhKEfcVMtg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9nyBhSaV51atwkWx4qv3v0mefNDchLU5/FXnryi6mGA=;
 b=fOXJMIl8i4UG4DH7u7imp0TdJnzjPp327fMX9q3Xg6N/UlqkxjwPZnL3gBf2zSGDA7suDRAfyqNVkm1Aycuv4K4mEKVvz+EbCjPNr6y5ZE76JjWTzJCjrozNNqwHODpXlczmPsCvV+D2eLhyPe5TMsUzkzuXxA6+PUQXt3YFoNtVtSGQXzSeerQoKtJhpMRTmMF5S5aOt0oZDZchA+3UvRL0OXGAL0HlYXSlz3v7OF9lHeJXMR3Wd6npSvF4KsBY0A7ALQytp+nttkld6L9UycOw2G0pTcrqB/unGXWm+TG0hBo2zPOrpjci/s+me2K4tPqdi/WYrKQTBWi+17QRzw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9nyBhSaV51atwkWx4qv3v0mefNDchLU5/FXnryi6mGA=;
 b=rx5bi0i6Xzi8qlWzYzakW/77rSRKdCOMy3mGUzRTrvGyviISR7KouEPrXFd/RytpFCEFSlIG0cuI2t5gC8cmwFJpDksk6pHpDjjUYOKw26Jh5MzfFc2WlQLBIVjUd3EA1GRYI5ZKtHIawE+uMIHNOFIZKY+pHBpvFX5f6bU2n5U=
Received: from DM6PR12MB4075.namprd12.prod.outlook.com (2603:10b6:5:21d::8) by
 DM5PR1201MB0028.namprd12.prod.outlook.com (2603:10b6:4:5a::11) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3239.20; Thu, 6 Aug 2020 14:23:41 +0000
Received: from DM6PR12MB4075.namprd12.prod.outlook.com
 ([fe80::84dc:a0e7:6158:ce4e]) by DM6PR12MB4075.namprd12.prod.outlook.com
 ([fe80::84dc:a0e7:6158:ce4e%7]) with mapi id 15.20.3261.019; Thu, 6 Aug 2020
 14:23:41 +0000
From: "Zhang, Hawking" <Hawking.Zhang@amd.com>
To: "Gao, Likun" <Likun.Gao@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amdgpu: use mode1 reset by default for sienna_cichlid
Thread-Topic: [PATCH] drm/amdgpu: use mode1 reset by default for sienna_cichlid
Thread-Index: AQHWa9YQGaft2T4KGUe+jpUCuSnpsakrImIQ
Date: Thu, 6 Aug 2020 14:23:41 +0000
Message-ID: <DM6PR12MB4075CF1E3517AC69F971F95CFC480@DM6PR12MB4075.namprd12.prod.outlook.com>
References: <20200806094317.2022184-1-likun.gao@amd.com>
In-Reply-To: <20200806094317.2022184-1-likun.gao@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Enabled=true;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_SetDate=2020-08-06T14:23:37Z; 
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Method=Privileged;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Name=Public_0;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_ActionId=0edb3529-1de7-4a06-a6ed-0000ebe72382;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_ContentBits=1
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_enabled: true
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_setdate: 2020-08-06T14:23:11Z
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_method: Standard
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_name: Internal Use Only -
 Unrestricted
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_actionid: e4482888-661b-42fb-87ed-00007c3f0c65
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_contentbits: 0
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_enabled: true
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_setdate: 2020-08-06T14:23:38Z
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_method: Privileged
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_name: Public_0
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_actionid: a265b57d-18ea-4ae8-aac3-0000f34c64b6
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_contentbits: 0
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [58.247.170.242]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 1af640f8-986f-4975-2088-08d83a1451d1
x-ms-traffictypediagnostic: DM5PR1201MB0028:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM5PR1201MB002811549AF97362E1B7AD8EFC480@DM5PR1201MB0028.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2000;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: mNqpE64xx1KMXJhCNtASVRKJvx2zrJT8IQoA3CmVWebl2ca8KgGwnvXYpvxT1rS/jyBoJq+5vmR4tctm+hC7SdV5DArM/8y73MO1JV0UqJLOIoX4jPCvNLZkNz4nbeoF5Uaa8sk8bxzMiojHMLPKqcyOEWiWSdGFAaBvNGtIDXzCacm3YpmROtIMyKxN9SF1H7a9zytp+7A+RQoMBFkShsqLI5DnhqLE7zYpEooA4p0a+Jp577Elz5mYiuuvUf//kN4wNT2S8lVsbLc5e/K8JyJBCdou2RiMNg8t9RwjUJMcuK9B6P3MM7aImoC4SkiB
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB4075.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(39860400002)(366004)(396003)(136003)(346002)(376002)(55016002)(5660300002)(71200400001)(9686003)(186003)(66946007)(83380400001)(52536014)(316002)(76116006)(66446008)(64756008)(66556008)(4326008)(66476007)(54906003)(110136005)(8936002)(86362001)(8676002)(2906002)(478600001)(53546011)(33656002)(7696005)(26005)(6506007);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: 88kTXJaooMVO/NGq2ienX4ClWhJn8tnMNdaT2wP6fCRKPzHdQbejJabQCB48Opkf8zDmK+eDNj94BRCmAgvRLDOJYQ7ZgyXkmRbcUqrR2GHnCQWfYJqBjpFVwAt+HmYBQ7hJ7g9rdcoIbmoxMGZDzRYWud6bGH/7gep5BAv8N98XvNg/hBqthe1Ro2PPoIFZfvuExI+K9vz32tlO/RcbBA0/VwE7tC++I2y2spH0NgHtil4qo/W0TzgbdixanOp+PspZb+vJHD5d9IDVBU+C2GQ4T+UyhJgomh6xMIeiOev9/yPAc0UeAHzeAmInE48ABBS71fksHYcd65mLGVnXg3BoijUpjc2KVYJy4pW6byrcQbwwBsv6PKKVAkNa8zccTDLCwnRNph7DGVM8/l5yaTzFQgBDxRbAzSG8yPPCx6MZOCPnj+T8Lz1Qr3raCMfNxHyH1JtKDE5o7VNl2x8KvU/0DFkss1K+4tsBoHvsoBuc12PpuNk1zsACIf1uiOiBlOf4RKBg7wTIQU4FQL1JWuvPQjyBTxFNU7uQaw9XONg0xePd4WthRl0exURn4zNVgVJdoqg00ojos8xT8U50O0k5TkszMT0gDjA7jfC73rh58pMeElnb3gDip5e/ovGey2MGv8l8hRFrgx6pPFIuYw==
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4075.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1af640f8-986f-4975-2088-08d83a1451d1
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Aug 2020 14:23:41.7748 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: qSv79yOOk1pCGFrOVNCArdZGipuRP9HJYoB2N3CxvA6G3I3E7UbCx12zsZonpmleQNrd8xTfZXIiv4QjVh+/Aw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR1201MB0028
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
Cc: "Feng, Kenneth" <Kenneth.Feng@amd.com>, "Sheng,
 Wenhui" <Wenhui.Sheng@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Public Use]

Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>

Regards,
Hawking
-----Original Message-----
From: Gao, Likun <Likun.Gao@amd.com> 
Sent: Thursday, August 6, 2020 17:43
To: amd-gfx@lists.freedesktop.org
Cc: Zhang, Hawking <Hawking.Zhang@amd.com>; Feng, Kenneth <Kenneth.Feng@amd.com>; Sheng, Wenhui <Wenhui.Sheng@amd.com>; Gao, Likun <Likun.Gao@amd.com>
Subject: [PATCH] drm/amdgpu: use mode1 reset by default for sienna_cichlid

From: Likun Gao <Likun.Gao@amd.com>

Swith default gpu reset method for sienna_cichlid to MODE1 reset.

Signed-off-by: Likun Gao <Likun.Gao@amd.com>
Change-Id: I775e5a66bbac474f65ca8c999136ccaf9c1dc14e
---
 drivers/gpu/drm/amd/amdgpu/nv.c | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/nv.c b/drivers/gpu/drm/amd/amdgpu/nv.c index 74d02d270d34..da8024c2826e 100644
--- a/drivers/gpu/drm/amd/amdgpu/nv.c
+++ b/drivers/gpu/drm/amd/amdgpu/nv.c
@@ -362,10 +362,15 @@ nv_asic_reset_method(struct amdgpu_device *adev)
 		dev_warn(adev->dev, "Specified reset method:%d isn't supported, using AUTO instead.\n",
 				  amdgpu_reset_method);
 
-	if (smu_baco_is_support(smu))
-		return AMD_RESET_METHOD_BACO;
-	else
+	switch (adev->asic_type) {
+	case CHIP_SIENNA_CICHLID:
 		return AMD_RESET_METHOD_MODE1;
+	default:
+		if (smu_baco_is_support(smu))
+			return AMD_RESET_METHOD_BACO;
+		else
+			return AMD_RESET_METHOD_MODE1;
+	}
 }
 
 static int nv_asic_reset(struct amdgpu_device *adev)
--
2.25.1
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
