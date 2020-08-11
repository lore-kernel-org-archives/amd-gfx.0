Return-Path: <SRS0=t0+e=BV=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8228BC433E0
	for <amd-gfx@archiver.kernel.org>; Tue, 11 Aug 2020 14:22:18 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 495F92076B
	for <amd-gfx@archiver.kernel.org>; Tue, 11 Aug 2020 14:22:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="L+wxAKlB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 495F92076B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F3C7C6E52D;
	Tue, 11 Aug 2020 14:22:17 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2072.outbound.protection.outlook.com [40.107.237.72])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F22986E52D
 for <amd-gfx@lists.freedesktop.org>; Tue, 11 Aug 2020 14:22:16 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=isIVqmIsjz5miXNbEbpls3fBuTkr5rUlHdxZaARoTkqHmIvt/aYpb+i69WtW/X+HLW88V/icADWhLY4RBSvhkQPKmMZFAG2PvBfA6pQnIkubYZbKqiZQzDs+h3RFYqWpZZ5EdpRrK8BfuYN0rh44X1euqUtM9Cd4QBj9mmsXDAUvdBU9LBA1pv5umF0wxx5ai4Dl0M+z6Ir26unms3fiq53kPXGTmSw8ZBuRBWtIjdFpZTFPh0lF08x+JW9AHKZy8/qdM0vBvEneINAWJVDhToQz5vjrWUWSaFHl7uzhgavNPc3bjI0E8zqQyy5Tm8DnGXdW9iF828Aw+4lFLYOGBQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=S3FcgZyORaOMvZ3CYqTpqMneqcqurLSrZyQWqASxAQk=;
 b=CzUCvKndGogSzuyegaLA9YDnnVTv5mpuV1VwpemXjdo35HoaBEQCw0GoGwyztT/i6qlqT2Z9PcPmDZeiB5S3Jr7yT79qTTK7kBi6/0OZ5tFkXMZtED+j9M4+qm81r/zLx1lMyjn/TRtnC116DBBMdePzKPavhMwcEpwV4jY605gw+naAgtm66kMlb8P6+L+AWOU8gYJqKkGsecCF4iThrMlpNicNxWQoYpWGlWhvGDw1cSfwO4hN3LbeOp12/0327wPM4Wp83tj9AQ4FXbT9SGnJVeFGULjRbXRh6wvPrRb5EpRWunQ2k7I/0X0ogynVQ+SuFDS1skv6/f0ZEPe32w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=S3FcgZyORaOMvZ3CYqTpqMneqcqurLSrZyQWqASxAQk=;
 b=L+wxAKlBKsFahV11RjUIwSAdaGIAE8W669SZLPbx5KS1nGBVcVD3VF1whBqjsejvmX867NClsvdwCq8t11b0agMQxA4h6PhANyJgZL7vD3E1bNZ7b6UeJ17oWxqhO8b5h60PB4buRPwkyfyoSZAa04Kf922KNjnY9fdG4xjs7zE=
Received: from CY4PR12MB1287.namprd12.prod.outlook.com (2603:10b6:903:40::8)
 by CY4PR12MB1285.namprd12.prod.outlook.com (2603:10b6:903:3e::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3261.20; Tue, 11 Aug
 2020 14:22:14 +0000
Received: from CY4PR12MB1287.namprd12.prod.outlook.com
 ([fe80::e181:b736:5067:12f2]) by CY4PR12MB1287.namprd12.prod.outlook.com
 ([fe80::e181:b736:5067:12f2%9]) with mapi id 15.20.3261.024; Tue, 11 Aug 2020
 14:22:14 +0000
From: "Chen, Guchun" <Guchun.Chen@amd.com>
To: "Das, Nirmoy" <Nirmoy.Das@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH 1/1] drm/amdgpu: pass NULL pointer instead of 0
Thread-Topic: [PATCH 1/1] drm/amdgpu: pass NULL pointer instead of 0
Thread-Index: AQHWb+nmIUmBnLs820OjdJuJEdLX2Kky9YTg
Date: Tue, 11 Aug 2020 14:22:13 +0000
Message-ID: <CY4PR12MB1287E47298BFA7D87F07837EF1450@CY4PR12MB1287.namprd12.prod.outlook.com>
References: <20200811141819.93228-1-nirmoy.das@amd.com>
In-Reply-To: <20200811141819.93228-1-nirmoy.das@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Enabled=true;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_SetDate=2020-08-11T14:21:24Z; 
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Method=Privileged;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Name=Public_0;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_ActionId=5cc0ea46-2c0b-42b7-8825-0000c9187603;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_ContentBits=1
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_enabled: true
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_setdate: 2020-08-11T14:22:11Z
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_method: Privileged
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_name: Public_0
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_actionid: 32e91e2f-d5f8-48d2-91d2-00004334baca
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_contentbits: 0
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [116.227.81.236]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: d58c526f-12cc-4974-fde7-08d83e01f17e
x-ms-traffictypediagnostic: CY4PR12MB1285:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <CY4PR12MB1285DDE6AC38F8178A4E8698F1450@CY4PR12MB1285.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:3044;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: gn9W8tzTZ6vX6OdpcI+ypRUkxGBmgSaJoOn7GQzFtsZP80PAIARz+Ic+YYu/uWV/3/uBJy1XsnKwyQ4mWlCZnZI9tw4gCp9t3qNXIeeuObRHq4ue7mF5yos0psC53F0nMc4Evdb/6HWv4/nAXtAhdn8vEcSIYk3NXVOAuArwmQJf7W9j/7GDjnyM2VHhv05VxbEJ3JbYW52MwGY9ljwx+WFJYYgpPdvhFCScTTQfHOMlPOBNvAvu5YnuPePD/2TVQK2g1stOnYyiILKrfKM4Y7P2YnU0EIFdFEvZ07Dlxx07U5h4Vo4U6HxNLVcO14i9DmLiYi8ZKEd84rkxEyt3CyT4bcKFYZYrzLqy18sFNKE=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CY4PR12MB1287.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(346002)(136003)(396003)(376002)(366004)(39860400002)(52536014)(66946007)(316002)(9686003)(71200400001)(53546011)(64756008)(6506007)(83380400001)(45080400002)(110136005)(55016002)(76116006)(66446008)(4326008)(66556008)(66476007)(7696005)(8676002)(478600001)(86362001)(5660300002)(186003)(2906002)(26005)(8936002)(966005)(33656002);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: CCaO6QK2Q8xZcSliv4975vACX589F2fvn8qGQNzRoj98uQKIqNpotMjTOqUEkcXNzyvL4pbaKyckyzuGw9XokNIU+z+94PaquBIoyvrloIwIrmeEo71T9NxFUNl0KorocG/R3eD+HvbG26sK8Anfb09gMJh98bFiM4buC52brwpHs6XJLbw3m4DJvXhSueq8aaUSHryOMUnRmvnSs8AcqAu7ArIvE7EQuiLQl7bst5ab9w+3UhPHfX1d+uaYt49VMNn6FuKEbdV/C0iyUUbC3NhuZNfSGmQJ0G1rf3ybdBVP57WV5yrO/pVrQURPH8KcD/1SlYAG98a+bpmg+yNZfoxlLa72Y0Mb4qsoh4n6usKlUZAk2J8IUXQdeHTXuj1Wx6uuiLvZm8HUjd4LgUnGA7u4str/vhA2sfxfluvAE/2UHRBOUx2vUzrK0r1TDX8EMjg9xSCPF1lPeAi+cgwQF/9SAZKphYi9rtcDtcbilawGVNRFkU2WkY04zWKkwFRi0a39XsPA8I5cP2hGaxpD2W+31iqhqnep+I3GNneba+IfDhuEZNqp0m960liYgvguKi9c+QfztYZ19sNwlqGfL3wPbHUAfVsoV7bSp4W+u0oKEORFs5n/S31UyBT38t3yMCJWqgxGMvOdzE2iGX7rfw==
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY4PR12MB1287.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d58c526f-12cc-4974-fde7-08d83e01f17e
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Aug 2020 14:22:13.8996 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: pDzMW2nDHgZ4dMj1LiTkNyC9Oz9r5voVl70y0NnxXpwT/uSHK81Qw+xpaa2HWGGr4gSKxXYjniSjPtlP3LPqdg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR12MB1285
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
Cc: "Das, Nirmoy" <Nirmoy.Das@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Public Use]

Thanks for your fix. The patch is:
Reviewed-by: Guchun Chen <guchun.chen@amd.com>

Regards,
Guchun

-----Original Message-----
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Nirmoy Das
Sent: Tuesday, August 11, 2020 10:18 PM
To: amd-gfx@lists.freedesktop.org
Cc: Das, Nirmoy <Nirmoy.Das@amd.com>
Subject: [PATCH 1/1] drm/amdgpu: pass NULL pointer instead of 0

Fixes: c030f2e4166c3f55 (drm/amdgpu: add amdgpu_ras.c to support ras (v2))

Signed-off-by: Nirmoy Das <nirmoy.das@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
index 2d1fad1abf7a..cd1403f83dcf 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
@@ -1570,7 +1570,7 @@ static void amdgpu_ras_do_recovery(struct work_struct *work)
 	}
 
 	if (amdgpu_device_should_recover_gpu(ras->adev))
-		amdgpu_device_gpu_recover(ras->adev, 0);
+		amdgpu_device_gpu_recover(ras->adev, NULL);
 	atomic_set(&ras->in_recovery, 0);
 }
 
-- 
2.27.0

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Flists.freedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;data=02%7C01%7Cguchun.chen%40amd.com%7C812e856745bd4ad0ae8c08d83e00f4d1%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637327521441996356&amp;sdata=ajX0MlH2uWqdV%2FIg%2FBYhzJV2GIgyi%2FGYQgXRpPyaolE%3D&amp;reserved=0
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
