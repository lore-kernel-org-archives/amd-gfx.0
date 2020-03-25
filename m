Return-Path: <SRS0=Seja=5K=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4CAFC43331
	for <amd-gfx@archiver.kernel.org>; Wed, 25 Mar 2020 10:49:33 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 77F4520722
	for <amd-gfx@archiver.kernel.org>; Wed, 25 Mar 2020 10:49:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="lU/nFfFS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 77F4520722
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 28AB56E7DD;
	Wed, 25 Mar 2020 10:49:33 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2076.outbound.protection.outlook.com [40.107.243.76])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AF74B6E7DD
 for <amd-gfx@lists.freedesktop.org>; Wed, 25 Mar 2020 10:49:31 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IOwH5uS+6GaduB8Cenq9ammlK+l0Pqz6I9+/Olu6RKBz/lKQB2X18iAx/YVIRqXF6Z+8k1g8MZ7VHDBucHC/LrwjdyD30+HoZPRce90LVxkBMuqO1/HmnJmuDAw3fCaCrbLg2ckp7LZ7Gh0Y8N7ebf73nmgpHPnCoFR3IkuaDtxKQ6dbeIbSQjKwHYIJeGUuiBbcTfJJyY6JcUnnggSLjqooTPbcbnd6ghG1nDnfOHpxjuDjPcq0TKC614oikZcNZFdux1qBRUa9F9iQPSWlkngckI7D9L4eHuT/pWCTQLtQhrc5HRa+M6jye8AgZ5QAlYb3DWFXQEg9FhfuE3Z88Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6u+XKebEbnOxlj3aMz/NS33pnbRMca98Ba5FymGCG00=;
 b=HDxttOB0dtyUdYyQFlKlrafyOOXvSoOczxHTPTCUHBdEUahBZB3HpK1GpRWoLhdiieeA0N+dC+7xdOzDy9CehEZjeYdpN38VhFB42JcD0Q5ezAVz4MvDp6DLAPMG0kFckMJxdFzu6zoRpxKKymVjBvFAXBWA5LKAkaERIRtm5QvXMa5J1zmgziTNVO8XLqU4LXT7Zcg1ooDAB7URheQRZWoTqHid1DpV0NmDRpUFyI5z2e1gk98yPoqFZs1AKbaS2V/7DI6gtIF2romtBd7kp2fBlJU9gT3RHP9uwOTdYfrx+Ira6UBOeL9+Uta1+EqnoqoQhdF6ks3644gptg6G+g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6u+XKebEbnOxlj3aMz/NS33pnbRMca98Ba5FymGCG00=;
 b=lU/nFfFSOA4XMt8V5r85vWQqe3x75mnWNguN2rZ5ckI16iSJQVmSs1QyvTrRiUSDrcC/TQrt0JVRIcjbcxer231Du/z6ponwwAOuam1Jhy97dJDu6j6mgRT6sKr0eLHXPRGGzIXhImiCljJ9UBA17txiOYPoSNP42LF9arwawqA=
Received: from DM5PR12MB1708.namprd12.prod.outlook.com (2603:10b6:3:10e::22)
 by DM5PR12MB1323.namprd12.prod.outlook.com (2603:10b6:3:75::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2835.18; Wed, 25 Mar
 2020 10:49:30 +0000
Received: from DM5PR12MB1708.namprd12.prod.outlook.com
 ([fe80::e9bb:a239:5bd3:7325]) by DM5PR12MB1708.namprd12.prod.outlook.com
 ([fe80::e9bb:a239:5bd3:7325%10]) with mapi id 15.20.2835.021; Wed, 25 Mar
 2020 10:49:30 +0000
From: "Liu, Monk" <Monk.Liu@amd.com>
To: "Deng, Emily" <Emily.Deng@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH 4/4] SWDEV-226663 - Ignore the not supported error from psp
Thread-Topic: [PATCH 4/4] SWDEV-226663 - Ignore the not supported error from
 psp
Thread-Index: AQHWAoAh2Q6U+qrX7kOfoy/F0g03vKhZIRzg
Date: Wed, 25 Mar 2020 10:49:30 +0000
Message-ID: <DM5PR12MB17084F1D1BA88F4EA95B5F9384CE0@DM5PR12MB1708.namprd12.prod.outlook.com>
References: <1585125181-14195-1-git-send-email-Emily.Deng@amd.com>
 <1585125181-14195-3-git-send-email-Emily.Deng@amd.com>
In-Reply-To: <1585125181-14195-3-git-send-email-Emily.Deng@amd.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Monk.Liu@amd.com; 
x-originating-ip: [180.167.199.185]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: c33e2b0b-a77a-4c13-7809-08d7d0aa3267
x-ms-traffictypediagnostic: DM5PR12MB1323:|DM5PR12MB1323:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM5PR12MB13233BFF4280CEB1867E2CB984CE0@DM5PR12MB1323.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7219;
x-forefront-prvs: 0353563E2B
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(4636009)(39860400002)(366004)(376002)(346002)(136003)(396003)(53546011)(2906002)(45080400002)(81166006)(33656002)(66476007)(966005)(66556008)(86362001)(81156014)(316002)(64756008)(8676002)(8936002)(66446008)(110136005)(7696005)(66946007)(55016002)(71200400001)(76116006)(6506007)(52536014)(9686003)(186003)(26005)(5660300002)(478600001)(4326008);
 DIR:OUT; SFP:1101; SCL:1; SRVR:DM5PR12MB1323;
 H:DM5PR12MB1708.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; 
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: KXuMCl5S2Re38f7xrPqVGjRhUX4y8VoY4QowWmsUYQrfrI153wsAZvr62edIzn+DZoOZPKHzXQ5okHCJXMWgEag8mvf6rHENBmbx4OYz2FsTwnRgFNfV0j+hMx4PiMfm6ry1XiNK+Y0E1itcsNdnqPoEK4FpGdo41KYiGGuCDkxMWwSLPWWdY91ebyPiT8c+UrpTX9l0aopT9+VYYG09wpRJZ+AWbJs0lVFtWupGgfIrnce/smIp5/he6oNRuTKSaobSHA08Ggo+J6rJc3NAFSpSImqhzmZLaO/V4YbTYQXJ8DDbi2+5rzuYFDHfdrxmR+ZIvrzXUDWj7XZFIHQBzAHNq4w7BW0VEmbZ71aw3PUXlVhBvdqaiaN8LCf0BVITLjGlVTj6IyYLSZjou+rKNqBPzBj55zG9MOUt4z4YfWE1zn8hNQC5KZ02DbgSqxlHn79Puil69Mjt6Up49n5SJTlaonwODdsl/BAD/0xzb44=
x-ms-exchange-antispam-messagedata: WXG9CpkCxRkOGG+scrHZ+rdwJkGhBDWf7zNhzINY0sZ1CQwzCzLwupeupNmsg8Vv9PidAyVAWrTEzJ902mRXBJmwWW0E/spW46Ff7YlqKfEIKWnKghCpF+C4coINnc26NfhTQe0WSmBLvJPI6moRuw==
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c33e2b0b-a77a-4c13-7809-08d7d0aa3267
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Mar 2020 10:49:30.3154 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: RCSDpuStIYGhxgBzEl475iKOrGoDGGvMTOKjlmG0MlOcLpAP8H3D66X5ZiXKUadd
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1323
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
Cc: "Deng, Emily" <Emily.Deng@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Reviewed-by: Monk Liu < monk.liu@amd.com>

_____________________________________
Monk Liu|GPU Virtualization Team |AMD


-----Original Message-----
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Emily Deng
Sent: Wednesday, March 25, 2020 4:33 PM
To: amd-gfx@lists.freedesktop.org
Cc: Deng, Emily <Emily.Deng@amd.com>
Subject: [PATCH 4/4] SWDEV-226663 - Ignore the not supported error from psp

As the VCN firmware will not use
vf vmr now. And new psp policy won't support set tmr now.
For driver compatible issue, ignore the not support error.

Signed-off-by: Emily Deng <Emily.Deng@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
index c2bf2d9..1a46050 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
@@ -205,6 +205,7 @@ psp_cmd_submit_buf(struct psp_context *psp,
 	int index;
 	int timeout = 2000;
 	bool ras_intr = false;
+	bool skip_unsupport = false;
 
 	mutex_lock(&psp->mutex);
 
@@ -236,6 +237,9 @@ psp_cmd_submit_buf(struct psp_context *psp,
 		amdgpu_asic_invalidate_hdp(psp->adev, NULL);
 	}
 
+	/* We allow TEE_ERROR_NOT_SUPPORTED for VMR command in SRIOV */
+	skip_unsupport = (psp->cmd_buf_mem->resp.status == 0xffff000a) && 
+amdgpu_sriov_vf(psp->adev);
+
 	/* In some cases, psp response status is not 0 even there is no
 	 * problem while the command is submitted. Some version of PSP FW
 	 * doesn't write 0 to that field.
@@ -243,7 +247,7 @@ psp_cmd_submit_buf(struct psp_context *psp,
 	 * during psp initialization to avoid breaking hw_init and it doesn't
 	 * return -EINVAL.
 	 */
-	if ((psp->cmd_buf_mem->resp.status || !timeout) && !ras_intr) {
+	if (!skip_unsupport && (psp->cmd_buf_mem->resp.status || !timeout) && 
+!ras_intr) {
 		if (ucode)
 			DRM_WARN("failed to load ucode id (%d) ",
 				  ucode->ucode_id);
--
2.7.4

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Flists.freedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;data=02%7C01%7Cmonk.liu%40amd.com%7C62d9f9c813ab4abc2d8d08d7d09742a0%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637207220397136549&amp;sdata=bdF3bmwXnmsYeJNcgImMHq2o4ambY0VVYCc4gC24zEc%3D&amp;reserved=0
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
