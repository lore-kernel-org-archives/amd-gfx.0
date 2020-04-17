Return-Path: <SRS0=Q5HU=6B=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E12CFC2BA2B
	for <amd-gfx@archiver.kernel.org>; Fri, 17 Apr 2020 03:01:39 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B440821D94
	for <amd-gfx@archiver.kernel.org>; Fri, 17 Apr 2020 03:01:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="sVIluu8g"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B440821D94
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4D3596E0EB;
	Fri, 17 Apr 2020 03:01:39 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2052.outbound.protection.outlook.com [40.107.237.52])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CCE076E0EB
 for <amd-gfx@lists.freedesktop.org>; Fri, 17 Apr 2020 03:01:37 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Cj0zbEp/ovr81m5/ZVbbjV6OV52ZxvXOqBJqRsCT33fTqMW8/YvsWpUxTG2pWxqBmUBzZ0J65jI6rwsbSWzbgh3JisYw0qyQYTUu5qyzpOnZJred1Vcfy0hIW+2M8o4ZaHYrWkM/oQbMmxkM+kX9pg0EfNo7qGq1Hlxk3oFl0hx5NS1hYJg5X1msDmrRyi6r0ItaS58I5YovtjneWGUvloniI270DUQ+oi6KdGIujxKMIqZn9+xDe727YM25OLEthhI9A3+8DJxaJ+YtYxUjEphC8YrmxJsumirxIa41itWUzz/lgQAtyXNuUXiVTeljgrGu+pZrr00Oy/s3k3pCmw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gDmp6Ya9GD/Kym4L+WaffinkCuGOzLHbcokWhck8ZXM=;
 b=dTtNwNbjmq1Q6SmmO/x3FwGdisk1V3/wrUnYulXRg0p0oY48L70Qc38jfN9Aut7QJ/mCrnaT8CAgFlDBW5w15FlGamRhRRUidrtIJFRyHJOag99+0GkMcarDPwIxlHoRDDms3C23AekdQMciNXObOzh9qJfPe5e0JLXyvMRPuC++gWG+Hxqn0+6UXayyzzdV42jDxba0kbPQ1eiPQt5ZxY54UfO8SvYecLSUqqVAmqeWmzD14FLHIAT41Qt2WoQupwkmEWJBZt6O+HkKLA8Cqd/T1ip0+Lo4SE2+LaAcHoU0xT3wqI8Z+dkjad1VXaheAto8jykqNYSEy12+jYbQJA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gDmp6Ya9GD/Kym4L+WaffinkCuGOzLHbcokWhck8ZXM=;
 b=sVIluu8gBmyrSDrZ2UDye5IsQpIMRz3NkMjxzTKzUxjasJQ3mG2czgIVGzw6dkcjGmQfR4r0PuXW7326DlYoF8qEJwkiZCa6RmLoK97RvkNFC7VvHVDU+9qg8vGguOyB2Sbiu5U0OdtTt99nVDH69NTdQVICzZ+NwHGTCxPOH5g=
Received: from DM6PR12MB2619.namprd12.prod.outlook.com (2603:10b6:5:45::18) by
 DM6PR12MB3674.namprd12.prod.outlook.com (2603:10b6:5:1c4::29) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2900.26; Fri, 17 Apr 2020 03:01:30 +0000
Received: from DM6PR12MB2619.namprd12.prod.outlook.com
 ([fe80::5c27:185c:be20:1fb6]) by DM6PR12MB2619.namprd12.prod.outlook.com
 ([fe80::5c27:185c:be20:1fb6%5]) with mapi id 15.20.2900.028; Fri, 17 Apr 2020
 03:01:30 +0000
From: "Quan, Evan" <Evan.Quan@amd.com>
To: "Russell, Kent" <Kent.Russell@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amdgpu: Disable FRU read on Arcturus
Thread-Topic: [PATCH] drm/amdgpu: Disable FRU read on Arcturus
Thread-Index: AQHWE+pulrmy2dPO4kCDoIv/BsIzTah8oQYw
Date: Fri, 17 Apr 2020 03:01:30 +0000
Message-ID: <DM6PR12MB26197B75E7D861F9F4558A15E4D90@DM6PR12MB2619.namprd12.prod.outlook.com>
References: <20200416122616.29174-1-kent.russell@amd.com>
In-Reply-To: <20200416122616.29174-1-kent.russell@amd.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ActionId=876b9957-13fd-4cd1-a394-000092647d47;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ContentBits=0;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Enabled=true;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Method=Standard;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Name=Internal
 Use Only - Unrestricted;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SetDate=2020-04-17T03:01:03Z;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Evan.Quan@amd.com; 
x-originating-ip: [180.167.199.189]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: ae3ade31-7a71-4002-2321-08d7e27ba0f5
x-ms-traffictypediagnostic: DM6PR12MB3674:|DM6PR12MB3674:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM6PR12MB36747A70726C644E90ED38A1E4D90@DM6PR12MB3674.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-forefront-prvs: 0376ECF4DD
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB2619.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(10009020)(4636009)(396003)(376002)(346002)(39860400002)(366004)(136003)(7696005)(71200400001)(52536014)(478600001)(2906002)(76116006)(5660300002)(186003)(45080400002)(66946007)(26005)(66446008)(4326008)(53546011)(66476007)(966005)(8936002)(86362001)(55016002)(316002)(9686003)(6506007)(8676002)(81156014)(110136005)(33656002)(66556008)(64756008);
 DIR:OUT; SFP:1101; 
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: SMmlbbAUV6ORzPGWFFWLivBvAPRk5s8VNhRWuBRySEgimIckAOc7YEBbYUrbJSdeR41Uy/AIxCvfBK/f003lRMIRMECVhQrDFrqaIki+ehPG3JNDb6XWoI7oXyOrAKLswgadESDWSDZrhh7Xs9z23UUAaZi0lUROxYRUPci6TOioTfzDuWsyZEuxn5wbIwrKgZwR3Yk7F4kTQFdY2UAll3twq8QPKzqo9Q8mLPo9Yj2NAkW1img2+QdUPPtwEaSyNdDzgwhiOaoipI4mPliI1jYIFP/lcT9Lc1nCG3m9lTHPtFBJk3NpLfoPoqcL/wtJ27uBlvtI2o4E2jDl1jp2mPDzGYu42uB0ymamJ7ba008Is5b/y0BvRHCU+aoJmhQntl3qHz1PAgvbJ98OoDrfIxU+0p/LGj5hZ2J/rEDDpa7iZEHRW6a7kFMvc80sUYLcZq/GeaStnl/q6YALmZCZZqahMqF76spLAjzoYuM57pM=
x-ms-exchange-antispam-messagedata: rDdF3v8eVoHsVW2Wg7+qLpLw9Maci7fjLNZizT2xKX/+OXr3Q04DRqnhHDZVD3KNts7fT2YYVRcZcFH+8KLdIiLuHTnkVqiyDP3LgpISY2S9tZG0cYaYjVzAVU9hzScKu1D4jlCpWAnC2g2xDHziqA==
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ae3ade31-7a71-4002-2321-08d7e27ba0f5
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Apr 2020 03:01:30.4279 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: RSeTZq01mWBHD+ww8uIbOt0DB0KGYgJfwHav5qCTJk48Rmktos9rxqsoVaDKvMUK
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3674
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
Cc: "Russell, Kent" <Kent.Russell@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Acked-by: Evan Quan <evan.quan@amd.com>

-----Original Message-----
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Kent Russell
Sent: Thursday, April 16, 2020 8:26 PM
To: amd-gfx@lists.freedesktop.org
Cc: Russell, Kent <Kent.Russell@amd.com>
Subject: [PATCH] drm/amdgpu: Disable FRU read on Arcturus

Update the list with supported Arcturus chips, but disable for now until final list is confirmed.

Ideally we can poll atombios for FRU support, instead of maintaining this list of chips, but this will enable serial number reading for supported ASICs for the time-being.

Signed-off-by: Kent Russell <kent.russell@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_fru_eeprom.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_fru_eeprom.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_fru_eeprom.c
index c7e55fe170bd..815c072ac4da 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_fru_eeprom.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_fru_eeprom.c
@@ -36,10 +36,11 @@ bool is_fru_eeprom_supported(struct amdgpu_device *adev)
 	/* TODO: Gaming SKUs don't have the FRU EEPROM.
 	 * Use this hack to address hangs on modprobe on gaming SKUs
 	 * until a proper solution can be implemented by only supporting
-	 * it on Arcturus, and the explicit chip IDs for VG20 Server cards
+	 * the explicit chip IDs for VG20 Server cards
+	 *
+	 * TODO: Add list of supported Arcturus DIDs once confirmed
 	 */
-	if ((adev->asic_type == CHIP_ARCTURUS) ||
-	    (adev->asic_type == CHIP_VEGA20 && adev->pdev->device == 0x66a0) ||
+	if ((adev->asic_type == CHIP_VEGA20 && adev->pdev->device == 0x66a0) 
+||
 	    (adev->asic_type == CHIP_VEGA20 && adev->pdev->device == 0x66a1) ||
 	    (adev->asic_type == CHIP_VEGA20 && adev->pdev->device == 0x66a4))
 		return true;
--
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Flists.freedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;data=02%7C01%7Cevan.quan%40amd.com%7C42f34f3317a34ab721b308d7e2016ac3%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637226368645218793&amp;sdata=zy6uWE0oQcnrCfrPtdrkQYQnW5VVlrKTtet%2Bm5ufYW4%3D&amp;reserved=0
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
