Return-Path: <SRS0=gUFK=E2=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97C6DC5519F
	for <amd-gfx@archiver.kernel.org>; Fri, 20 Nov 2020 07:09:36 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CA74F22253
	for <amd-gfx@archiver.kernel.org>; Fri, 20 Nov 2020 07:09:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="IWVOhX6b"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CA74F22253
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 030536E874;
	Fri, 20 Nov 2020 07:09:35 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2083.outbound.protection.outlook.com [40.107.220.83])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CA51F6E873
 for <amd-gfx@lists.freedesktop.org>; Fri, 20 Nov 2020 07:09:33 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YAaPSjOF4vh32KxWqXgCVVr4qk9SVv39GbdRkfRO+3ettGn3tTFz914V+0cdDwdkwGPVxNE8j2pofFZpPbZzj0ZBtIQSLCOMieHkWPoKe4zOpP9+Ppu3Ol3+XOzj8X9PFusk0C4lygRwsIZwSHb1PMKnL0GgfbOwPBk78Rd9L5ChnpNKR9JyMD1hvC5UYcTUk0n4mx5MKu/on+AGm+8opWjz/NIDeJmmfDrphpYHUZqqGc+qML/Qo5PZfR+S0YAxA1Li4mfhyEVOdkwbjZE+BUwSX6PbEbJxAE2xTVHE7trx2l7jL3474GoH3gT2yAWdR1BOz+ja3MrZlp+HX/OjWw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DDiUkXx2vAQYsXZ1SqjL6DlEXrcfYi9/LgIjI/IZLGU=;
 b=Y8ad0Vx4w8j9/MvtBKAR8tP/diNbfOgXgGXfmmqhA3XAuamRiOGZ2TAuJa1deA4qXGP7FDFPV51s2ePqCDPTnC6FIUcZcGAbBZgORDyrm88HxK6fH738Q3i/9gjKFAlbSuT57QHoVvBR4STFD+em7QMsiIVdwjHTCFXHEhrPOiWTp1i7ltTsymoCxRiotKy9FZhVMCFMuSqBeJoAG/oo6rXA61XgXU2I2ZfXj3EGQs7zNAUVjSbFGaClVLUZIPUXWs/xJPHpgLH3aRglFJIaQK2HJ6T5PPnfQz/5wbRq+zth5ptD0SxWyI68Z4OSkLZjgIdVMvB7pFX9DOzM9KYjCg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DDiUkXx2vAQYsXZ1SqjL6DlEXrcfYi9/LgIjI/IZLGU=;
 b=IWVOhX6bLIcILM9z+o5Qbtrjuz1ICyPVpOQxN3hPtuSuYw+VGnFGzIAYG4HS+8BN9jPzH2eErzVdQ+ysqsv6b5z1VloD6h3ADPW5Bqbb9Y3P1y4WeMkREwocii/BXNEEjphwIqVThAIwJJt2cHUGZSOtg8K/kqZaGXXDe6QBMkY=
Received: from DM6PR12MB4075.namprd12.prod.outlook.com (2603:10b6:5:21d::8) by
 DM6PR12MB2825.namprd12.prod.outlook.com (2603:10b6:5:75::11) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3589.25; Fri, 20 Nov 2020 07:09:29 +0000
Received: from DM6PR12MB4075.namprd12.prod.outlook.com
 ([fe80::214c:5fb0:3572:853d]) by DM6PR12MB4075.namprd12.prod.outlook.com
 ([fe80::214c:5fb0:3572:853d%7]) with mapi id 15.20.3589.022; Fri, 20 Nov 2020
 07:09:29 +0000
From: "Zhang, Hawking" <Hawking.Zhang@amd.com>
To: "Feng, Kenneth" <Kenneth.Feng@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amd/amdgpu: skip unload message in reset
Thread-Topic: [PATCH] drm/amd/amdgpu: skip unload message in reset
Thread-Index: AQHWvwg+lbcZ/BvnDE63vLgBa6siUKnQmWaQ
Date: Fri, 20 Nov 2020 07:09:28 +0000
Message-ID: <DM6PR12MB40758B8F8AAAE09D468A4049FCFF0@DM6PR12MB4075.namprd12.prod.outlook.com>
References: <20201120064104.29795-1-kenneth.feng@amd.com>
In-Reply-To: <20201120064104.29795-1-kenneth.feng@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Enabled=true;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_SetDate=2020-11-20T07:09:25Z; 
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Method=Privileged;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Name=Public_0;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_ActionId=f8d47599-e556-49f9-83aa-00006c393193;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_ContentBits=1
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_enabled: true
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_setdate: 2020-11-20T07:09:15Z
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_method: Standard
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_name: Internal Use Only -
 Unrestricted
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_actionid: 7ec68759-6c3a-47b6-9cf8-0000f56b4475
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_contentbits: 0
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_enabled: true
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_setdate: 2020-11-20T07:09:26Z
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_method: Privileged
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_name: Public_0
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_actionid: 884e7008-018d-4210-bc39-000066e3d307
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_contentbits: 0
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [58.247.170.242]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 3e1dc116-3773-4b35-202f-08d88d2338da
x-ms-traffictypediagnostic: DM6PR12MB2825:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM6PR12MB28252D543CDE04F691DBA802FCFF0@DM6PR12MB2825.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6108;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: rOODBThimOU5cL498Gesm8TkHm6tvPf8qnsi9pdlJC23oB0eAiIFkR6wr+umSUghnnfAb8ek4s+sF39SpGMVG7Oz0gpB0xyW6yVtsMc4ozSDp9M8kQpnI5OSBwqPT0nXBbtM6iNASFTXzhA6V0+Lgvcvysct4Snq4LkGJIgVnnwTPv5AjwROIAr/ASdcJZvaVWveiOYiLxS+ST+98Spyjxdq3wrE0iNJponGwFCWHXbYMKg8apOYGEv+IFXGOJoQyZ/FHo4bD3JSklZg0xkbZ/nYtDMMvifX66TMPjTCSAaupVz89sVDHdKk9jmIwLNHLSl/FnEZlTWSx+NIZt1GhSJbP5VPINUbt3alToEXGnI=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB4075.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(396003)(366004)(39860400002)(376002)(136003)(346002)(66946007)(64756008)(66556008)(66476007)(110136005)(9686003)(76116006)(66446008)(33656002)(52536014)(7696005)(45080400002)(53546011)(966005)(478600001)(5660300002)(6506007)(83380400001)(71200400001)(26005)(86362001)(186003)(15650500001)(8936002)(316002)(4326008)(8676002)(2906002)(55016002);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: 1M4to0kVFN2iB4zDYjuVubh5fGAX0kmaFwnljPDL96FThWf043GPQjJwKyHI9/dDCzquHWTTCMAnckwNWPRdRWT58SabvFt2DQvAarhXOnJRJEh/aCV60N+2vAUzskr7I6gcp1CzZRhvJiWpvRfOOkwajnshT8B8GTfW5p03nFBR/FLHRAym2X+/0NBBebcYh1Kb73FL/xqFPwl6WNr4JVRpxBAohz2IayUqXM9ES1QO7u3WiIMKH9riDPldD3dkUQqQw8npoCL8FCTepyIxS5KA9N09i3qsSMJZIPmKJtj80LiUxYOziE3TxC/TD6UN90sQZ+/zG5u6tqRJ0rY80zvTp8OOq5iE82NO5DkxlbnC77qWJJ32Z1OcpXJ8Ns+z1gqnS8wcQocpa2sMrTBiuwQWTwiyG/h46P/cUBUTjLQP7FWEGkhd6DURPPUPPffkz6EfOvBdjq7O4eZi5fERlohCCvIKm+VMinIEPceX79PUJ/LpeAHWieMMKUpW9jbZlErNJ/tboaN9V5aCc5D0wXAaAi7D6i42NaWk7H1rbC4boSE5Nbp/uCFdXL4V1KXsM34F+siVGmx9F7EHhZIV4FMPPVT0vUgd6TmNC2A09HqTFydrWVEqqcbfr1EuwQI+hkaSWY1soEf9t6MTlphCU6x2F+GsQ9DYtNPkRXSL94V2d9iPCNqeHFwspYHRz/rp+R9o5twtyQt/eCUFLp54EboLsAkMxShVfGeEWBP8sUoz52ntFpT8wHm9/jKAdIxbNlEjYbAz99WPEmCDzZsUZNk96W2CUS8B4qg07ziYky6b0y2YZouZS+X1ZVe9LZ0Pni3Ybp1qWwnLe/DSc3KPUgJFpzcEEPW6i47j5gVurtKynXwVfFUU5E4ZQ1h4tQ1FYo7T77DcDP6jwHQQ7A4GEg==
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4075.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3e1dc116-3773-4b35-202f-08d88d2338da
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Nov 2020 07:09:28.9877 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ZytjM+KA3W01FhqTBrYEomYOdbNpKXaKX9fl2Bv6JugQ87u9wSz0oSCMvdwdAKTo+DZTXEcQIajbPctV+W9g6g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB2825
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
Cc: "Feng, Kenneth" <Kenneth.Feng@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Public Use]

Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>

Regards,
Hawking
-----Original Message-----
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Kenneth Feng
Sent: Friday, November 20, 2020 14:41
To: amd-gfx@lists.freedesktop.org
Cc: Feng, Kenneth <Kenneth.Feng@amd.com>
Subject: [PATCH] drm/amd/amdgpu: skip unload message in reset

This has been confirmed that unload message is not needed from SIENNA_CICHLID in reset.
Otherwise it will cause the fw wrong state after reset and no response for any messages.

Signed-off-by: Kenneth Feng <kenneth.feng@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
index 74cbaf212698..0f0ee7c5ffab 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
@@ -1925,7 +1925,8 @@ static int psp_load_smu_fw(struct psp_context *psp)
 		return 0;
 
 
-	if (amdgpu_in_reset(adev) && ras && ras->supported) {
+	if (amdgpu_in_reset(adev) && ras && ras->supported &&
+		adev->asic_type == CHIP_ARCTURUS) {
 		ret = amdgpu_dpm_set_mp1_state(adev, PP_MP1_STATE_UNLOAD);
 		if (ret) {
 			DRM_WARN("Failed to set MP1 state prepare for reload\n");
-- 
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Flists.freedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;data=04%7C01%7Chawking.zhang%40amd.com%7C45bd004548f04e12ba1e08d88d1f5e96%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637414513171894856%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C1000&amp;sdata=rO6cuJEwNk8mXAXFtVtMchYljIEwnUd3B1z16023Fow%3D&amp;reserved=0
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
