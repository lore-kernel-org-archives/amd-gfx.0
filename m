Return-Path: <SRS0=Kvqq=AK=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1DDEEC433E0
	for <amd-gfx@archiver.kernel.org>; Mon, 29 Jun 2020 06:11:23 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DFD7B2312F
	for <amd-gfx@archiver.kernel.org>; Mon, 29 Jun 2020 06:11:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="0/EVUDun"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DFD7B2312F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 974486E08A;
	Mon, 29 Jun 2020 06:11:22 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2054.outbound.protection.outlook.com [40.107.244.54])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 709CF6E08A
 for <amd-gfx@lists.freedesktop.org>; Mon, 29 Jun 2020 06:11:21 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jPn5P7ev2OsUvY91o/sKChw/9JrhXdoA3+pnvK0/OMAIOnExgISBJvut3G/pEdEmZDWblBo424A609c9UY2idNLdWo0EOZTYlQJYOLV16kjsY0tkO9NYMqi1jb7cdsCioUE2HSA8dRZIL9y7NqA2fE4JvogANxph7oWgC5YEaIgEN5Lh6bCSoUNDgMJU6XA4iGu3jB7BI4pDTFyyvQCfoQWyBcuoU3r8p7BWIzR5Q47b7irt7Ff6TEE1jDDB2uBHufYceRxoO8YF9QN9AKfKoDLpD7grhDT9sRrFs9gPfCfxifPm2K3JlBmfm2HDZ+e3xJSNK0yyxhXQB5LsnGR0AQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ElfOf8W5bMnsPzeWC+3ZnXS6FyGbMwhwoGCwyiM9CSo=;
 b=S7uI+O3m5G4wpLfDP3ArQUrHdXKoe8DZYO9owJ5WUQhWE10Rg0SnXJ9mJCMhheJfAP4rbJJ3B5oYjocnuOqwj9gw53m4nNs8sNlP+VzJDkoPDJViQzcZGbatwAnagRTU9KveLNMF8sdln6fGFavwgzlnQDZbuDTWr5rJvWRvlwgKn4ZWaWH/+L84L8JlxdC4aEpPM4HGR+YxG9ZbU+7B8GJJ3vhIME7L1gYqOx7u/F9MhvQnwoNaZU8xvInhFuXhJ0AsNwpOrJNNLtNbKptHVML4q2nvU8G/yHdvxErhQ9ZXCgmcxntPi9O50JOh4PLXY4aXk3nPto27Civ6ljkNKA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ElfOf8W5bMnsPzeWC+3ZnXS6FyGbMwhwoGCwyiM9CSo=;
 b=0/EVUDunAhMfFIleYeQoqfWp8t9KG/VJ+hR0raL6rIs2M8mBpSw/B+xrhxtbJ+bfqnlrc1gVPt+f7ioPMQxzfsXt6DGLwktWUQOhwPlCSLpkSRuCotD+8IF1OLmPy70gIIVi+C5ALp0MM/lRYUeEskigYb5vCxZ4N9mggi2PPkM=
Received: from DM6PR12MB4075.namprd12.prod.outlook.com (2603:10b6:5:21d::8) by
 DM6PR12MB3868.namprd12.prod.outlook.com (2603:10b6:5:1c8::21) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3131.25; Mon, 29 Jun 2020 06:11:20 +0000
Received: from DM6PR12MB4075.namprd12.prod.outlook.com
 ([fe80::81eb:c31f:a63a:20eb]) by DM6PR12MB4075.namprd12.prod.outlook.com
 ([fe80::81eb:c31f:a63a:20eb%8]) with mapi id 15.20.3131.027; Mon, 29 Jun 2020
 06:11:20 +0000
From: "Zhang, Hawking" <Hawking.Zhang@amd.com>
To: "Sheng, Wenhui" <Wenhui.Sheng@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amdgpu: correct discovery_tmr_size init val
Thread-Topic: [PATCH] drm/amdgpu: correct discovery_tmr_size init val
Thread-Index: AQHWTdul1O+ziysvU0i0Op5/yRvm06jvHFdg
Date: Mon, 29 Jun 2020 06:11:20 +0000
Message-ID: <DM6PR12MB4075A2144F9D4BDF87A14251FC6E0@DM6PR12MB4075.namprd12.prod.outlook.com>
References: <20200629060746.21697-1-Wenhui.Sheng@amd.com>
In-Reply-To: <20200629060746.21697-1-Wenhui.Sheng@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Enabled=true;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_SetDate=2020-06-29T06:11:15Z; 
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Method=Privileged;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Name=Public_0;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_ActionId=c91fb2a2-a334-49e9-9d6b-0000022db0b7;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_ContentBits=1
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_enabled: true
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_setdate: 2020-06-29T06:11:05Z
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_method: Standard
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_name: Internal Use Only -
 Unrestricted
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_actionid: 6d1f9921-8bff-436a-9419-000045ae1b00
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_contentbits: 0
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_enabled: true
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_setdate: 2020-06-29T06:11:16Z
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_method: Privileged
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_name: Public_0
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_actionid: 12703b8c-6ad6-4cd6-8e80-00008d4a95da
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_contentbits: 0
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [58.247.170.242]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 836c48cd-edf1-4162-68ca-08d81bf33de4
x-ms-traffictypediagnostic: DM6PR12MB3868:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM6PR12MB38685183527CAACAFE9626ECFC6E0@DM6PR12MB3868.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6790;
x-forefront-prvs: 044968D9E1
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 5nanbDp3L3m/8kQGmzaV+81hWMudHJq6vbIWz+UycLgjDQLZnVGvZHqFQBaB6SSoAAVCOQuR+5BsMFrfye5f3XD4/5yUZMAm9ua3Sn1ZBc6uqhyxEyOLVI3lkW/lFylpM6Tc1HXxTtkqk9KJCOMXUVYUiuhzWEeUYLfUQ3n7kP1jX8ax2p3R/szc7olOshDUPkKyVmh64dv4ueXUWWCCODF5feIBSkY8D+qSdHHw0ylPuHpvp10ulSJtCLX6KKX4coesafJtnYhEJlSNBdo/rOd0FmKxKii95xlEG5tszdXYQc8O38+o0NQw6XSSj0oSl8QQWatwumsfYMFucG7p7g==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB4075.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(39860400002)(376002)(366004)(396003)(346002)(136003)(2906002)(478600001)(186003)(8676002)(71200400001)(53546011)(26005)(8936002)(7696005)(6506007)(64756008)(83380400001)(86362001)(66446008)(66476007)(66556008)(110136005)(66946007)(55016002)(316002)(76116006)(9686003)(5660300002)(33656002)(52536014);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: COEqKKujyy9r52HLlU0yTe29IAlYc/178qcpYRnwKF8fuH/oPe1pDDmtMRaSUhb/I1ueYwBuEsjmMm36N4jMB2nLaQj8U+yFT2vNhR2B8W6RX1EuSKZHYHu89Ku3tq7rhgUIGER1YbL1GUUdRgJENKM3+bQwGZ0Qc0Cwuj4hHH+FBZ42dllXgztEaawNELGCTXI04/Vbo2JcCjjmbxOxalT+SqWTZHEwohrpwJpV4z31f0cRb5+ALLBirGbl0Baf4+29fxHe03MWHWqr17zcd4pfTTHCzNB0n2BoIUabsaIgD1rWIEHu9hIJunS/NnUYgW7XTDwlzPfBpBHgvENNB72T5GeYQLPbz5Fyu4V2dNTtMg0gheQ/TqoB4nQQAF9e2HuTWsKcLOBd2mk/S4fK428/rj9P1E7s8Jk9gJpGHmRQSkcyQ0bt3GthGb8y1feEqgyFesaWfNxboQPkFJCKO2H7S9hddDnB+g1mVT+9aW3CnKe6V//AgWLUmqIOQc9v
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4075.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 836c48cd-edf1-4162-68ca-08d81bf33de4
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Jun 2020 06:11:20.0574 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: BeWD7kLfGCK4kSzNDiCb+tD4cVTo0hve7M2GkC4Xtt2VddoMT1fNRJom0avEiZ+8kimSi9BDKI3uxZu5j72Yug==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3868
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

Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>

Regards,
Hawking
-----Original Message-----
From: Sheng, Wenhui <Wenhui.Sheng@amd.com> 
Sent: Monday, June 29, 2020 14:08
To: amd-gfx@lists.freedesktop.org
Cc: Zhang, Hawking <Hawking.Zhang@amd.com>; Sheng, Wenhui <Wenhui.Sheng@amd.com>
Subject: [PATCH] drm/amdgpu: correct discovery_tmr_size init val

From: Wenhui Sheng <Wenhui.Sheng@amd.com>

The legacy way to initialize discovery_tmr_size is using DISCOVERY_TMR_SIZE, while after we reduce DISCOVERY_TMR_SIZE from 64KB to 4KB, variable discovery_tmr_size is also reduced to 4KB, this is not correct, it still should be 64KB, discovery_tmr_size will be used to calculate ip_discovery reserved mem's start address and size.

Using DISCOVERY_TMR_OFFSET to init discovery_tmr_size instead.

Signed-off-by: Wenhui Sheng <Wenhui.Sheng@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
index 7d51768684dd..56beafbd3ab9 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
@@ -1872,7 +1872,7 @@ static int amdgpu_ttm_reserve_tmr(struct amdgpu_device *adev)
 	adev->discovery_tmr_size =
 		amdgpu_atomfirmware_get_fw_reserved_fb_size(adev);
 	if (!adev->discovery_tmr_size)
-		adev->discovery_tmr_size = DISCOVERY_TMR_SIZE;
+		adev->discovery_tmr_size = DISCOVERY_TMR_OFFSET;
 
 	if (mem_train_support) {
 		/* reserve vram for mem train according to TMR location */
--
2.17.1
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
