Return-Path: <SRS0=p2a1=3E=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E627FC33CB2
	for <amd-gfx@archiver.kernel.org>; Wed, 15 Jan 2020 09:25:53 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BC209207E0
	for <amd-gfx@archiver.kernel.org>; Wed, 15 Jan 2020 09:25:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="zFZqSwfD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BC209207E0
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6B6C26E8C1;
	Wed, 15 Jan 2020 09:25:53 +0000 (UTC)
Received: from NAM04-BN3-obe.outbound.protection.outlook.com
 (mail-eopbgr680076.outbound.protection.outlook.com [40.107.68.76])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B3E1C6E8C1
 for <amd-gfx@lists.freedesktop.org>; Wed, 15 Jan 2020 09:25:51 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Cou4lvjWwLtoddwfjD7SmQUZSjAd7fRZVHDIZVUQKYr9XEM1h8RS9P8wpKhC80m41GIJuZZntqYJxAZJGFr47AYU7R4UCwLryvM7yjTmgrB9kaklZodPeAE4+xYKTlKd+RiD8b/GLOWCnUlfvTmzIQZk/GmyNI2TtdSb8jI8FFkXLQUYlHSFXVxbWI/Xm7t5J5HG2uoeFaw3YagoOH8PrJUXvbOxFg/VLKGHuH/eqWPG04Ql+q+a29JWf+i7Fw3hdVpdGhReXbnYPgtFUX2Bmm+L/CtKZ3efhZUI58tWKHJKbiD8bi3E1a2xTHKmjOR5YTaOr6Kx1G1LM+JFj0+RiQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CUyJ03+/raYOc3PNEWFPvaDlHwp8+yQWxLbljy0Yaw0=;
 b=Xs2Z487kMeGBvE3bJy07U1bR2Mwh6iL+tgoTqXyiculQz3SkABWcprZ8iVhv3Up82cz+7BcA6LbAVS6d2FHU54iDPV3yHolCg85zV9CymfXoAdQv2C1yi2qT8U5utRb5DfKGLd3GifEa858zu4t6xgcsto2IWqFMCFVUA1OjkomX/i4Pvuq+xT87TtWbObsul9kbfHMdxE10nIBZc1e4CJJEjNTLTRLxTnfDSIwPWe1Njk7LeDxsbZDY6EW2F2hMHXXujIv4/X9ZlNsNxoofy2CJUJWJoU5bgNJTKjOu2E9IyF/qPx8wCEdDfIAPhIpJLIjALrU9cRGF+ZUDbIuAbQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CUyJ03+/raYOc3PNEWFPvaDlHwp8+yQWxLbljy0Yaw0=;
 b=zFZqSwfDAk0LAn+/BBgZCph9YGvwVqjdqk/vF7BeUhRRsfk+sVGseNZENURmkJxcjUkd3FmTEv4AvcqSK8kVaFdXq1lo+cYEhecsK1K5Avoh6QeJmBmVPptGKy/23+CpX0nVifNw4DqNEirSAtvBeaOu0eAb08V7MAw3XnnIomk=
Received: from MN2PR12MB3344.namprd12.prod.outlook.com (20.178.241.74) by
 MN2PR12MB3357.namprd12.prod.outlook.com (20.178.244.94) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2644.19; Wed, 15 Jan 2020 09:25:50 +0000
Received: from MN2PR12MB3344.namprd12.prod.outlook.com
 ([fe80::1010:4621:68dd:5b47]) by MN2PR12MB3344.namprd12.prod.outlook.com
 ([fe80::1010:4621:68dd:5b47%5]) with mapi id 15.20.2644.015; Wed, 15 Jan 2020
 09:25:50 +0000
From: "Quan, Evan" <Evan.Quan@amd.com>
To: "Zhang, Jack (Jian)" <Jack.Zhang1@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amdgpu/sriov skip the update of
 SMU_TABLE_ACTIVITY_MONITOR_COEFF
Thread-Topic: [PATCH] drm/amdgpu/sriov skip the update of
 SMU_TABLE_ACTIVITY_MONITOR_COEFF
Thread-Index: AQHVy4UTFUMwtcHK8UGXjcG4iSZhZafrdG3g
Date: Wed, 15 Jan 2020 09:25:49 +0000
Message-ID: <MN2PR12MB3344677A2466C9CDC4921215E4370@MN2PR12MB3344.namprd12.prod.outlook.com>
References: <1579080028-27730-1-git-send-email-Jack.Zhang1@amd.com>
In-Reply-To: <1579080028-27730-1-git-send-email-Jack.Zhang1@amd.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ActionId=c82068a8-ad98-484a-a074-0000d17d81bb;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ContentBits=0;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Enabled=true;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Method=Standard;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Name=Internal
 Use Only - Unrestricted;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SetDate=2020-01-15T09:25:33Z;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Evan.Quan@amd.com; 
x-originating-ip: [180.167.199.189]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 4cd0f799-17ad-49d6-dd6e-08d7999ce924
x-ms-traffictypediagnostic: MN2PR12MB3357:|MN2PR12MB3357:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MN2PR12MB335759C5C4753E68EE26C43DE4370@MN2PR12MB3357.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:158;
x-forefront-prvs: 02830F0362
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(4636009)(366004)(39860400002)(376002)(136003)(396003)(346002)(199004)(189003)(2906002)(966005)(8936002)(4326008)(110136005)(81166006)(316002)(86362001)(66446008)(66476007)(66946007)(66556008)(64756008)(81156014)(8676002)(7696005)(71200400001)(15650500001)(33656002)(478600001)(186003)(6506007)(45080400002)(26005)(53546011)(55016002)(52536014)(9686003)(76116006)(5660300002);
 DIR:OUT; SFP:1101; SCL:1; SRVR:MN2PR12MB3357;
 H:MN2PR12MB3344.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 5WVA0aT1LWZT250Hmja95b6Ochtma14/L/dkkyIAsiPLLM5s1yC2DRn7eYRP4bhJ2hCdEt256sJBVbK2KlAGgLw4evPXgfE8aF1QFCyTmN/2mQr4y4aoLLleDIIx1wKeuOGV3FgDajB5i+UExAHLcfu2O8pqYcHmH+OzYpOQWTyvimLr6jkn9vyZaEhAdartnPmBk5UQfbA2u8YMhAmgLhRhpAT2N1DnaKBxrpR5FLUjqqnYPSMlWJl7E4/ccVdfEAiwzZq493jhKHcJAZ/VpGaD/kAYQ4cVX8uqJkFOTkSRGCWOa1OElgndpGW5b/wurR3ZOu4NGyZGNwqnPNEQixxB82xBY5UGKec7Wowr4up/FJ0R8yAZSVqKEfqQgfmpAy854tkvu/ezhQ2SCOHsLeLtaLfR06mrigpozV4JocNs82F1K3jmLw8jzhvNRiqhjX9HVaQT03M+rV0mjEuU3RDc09Y3vyl49Q55RXX1q0Q=
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4cd0f799-17ad-49d6-dd6e-08d7999ce924
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Jan 2020 09:25:50.0060 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: /8QEWcAklYo4Emzrpeopi15va9O9VuN595D7LIlvU7ir782BCYAz6EFO1GT70ldf
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3357
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
Cc: "Zhang, Jack \(Jian\)" <Jack.Zhang1@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Reviewed-by: Evan Quan <evan.quan@amd.com>

-----Original Message-----
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Jack Zhang
Sent: Wednesday, January 15, 2020 5:20 PM
To: amd-gfx@lists.freedesktop.org
Cc: Zhang, Jack (Jian) <Jack.Zhang1@amd.com>
Subject: [PATCH] drm/amdgpu/sriov skip the update of SMU_TABLE_ACTIVITY_MONITOR_COEFF

There's no need to dump ACTIVITY_MONITOR_COEFF under VF.
Therefore, Skip the update of SMU_TABLE_ACTIVITY_MONITOR_COEFF
under SRIOV VF.

Signed-off-by: Jack Zhang <Jack.Zhang1@amd.com>
---
 drivers/gpu/drm/amd/powerplay/arcturus_ppt.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/powerplay/arcturus_ppt.c b/drivers/gpu/drm/amd/powerplay/arcturus_ppt.c
index 1c15c6f..14ba6aa 100644
--- a/drivers/gpu/drm/amd/powerplay/arcturus_ppt.c
+++ b/drivers/gpu/drm/amd/powerplay/arcturus_ppt.c
@@ -1318,6 +1318,7 @@ static int arcturus_get_power_limit(struct smu_context *smu,
 static int arcturus_get_power_profile_mode(struct smu_context *smu,
 					   char *buf)
 {
+	struct amdgpu_device *adev = smu->adev;
 	DpmActivityMonitorCoeffInt_t activity_monitor;
 	static const char *profile_name[] = {
 					"BOOTUP_DEFAULT",
@@ -1351,7 +1352,7 @@ static int arcturus_get_power_profile_mode(struct smu_context *smu,
 	if (result)
 		return result;
 
-	if (smu_version >= 0x360d00)
+	if (smu_version >= 0x360d00 && !amdgpu_sriov_vf(adev))
 		size += sprintf(buf + size, "%16s %s %s %s %s %s %s %s %s %s %s\n",
 			title[0], title[1], title[2], title[3], title[4], title[5],
 			title[6], title[7], title[8], title[9], title[10]);
@@ -1368,7 +1369,7 @@ static int arcturus_get_power_profile_mode(struct smu_context *smu,
 		if (workload_type < 0)
 			continue;
 
-		if (smu_version >= 0x360d00) {
+		if (smu_version >= 0x360d00 && !amdgpu_sriov_vf(adev)) {
 			result = smu_update_table(smu,
 						  SMU_TABLE_ACTIVITY_MONITOR_COEFF,
 						  workload_type,
@@ -1383,7 +1384,7 @@ static int arcturus_get_power_profile_mode(struct smu_context *smu,
 		size += sprintf(buf + size, "%2d %14s%s\n",
 			i, profile_name[i], (i == smu->power_profile_mode) ? "*" : " ");
 
-		if (smu_version >= 0x360d00) {
+		if (smu_version >= 0x360d00 && !amdgpu_sriov_vf(adev)) {
 			size += sprintf(buf + size, "%19s %d(%13s) %7d %7d %7d %7d %7d %7d %7d %7d %7d\n",
 				" ",
 				0,
-- 
2.7.4

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Flists.freedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;data=02%7C01%7Cevan.quan%40amd.com%7C06062548b6fa454cb0b308d7999c2f6d%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637146768486251371&amp;sdata=DfWppJesEKo6jHwonWF%2B%2FcGTnloaWwT32A7DOr17JQ4%3D&amp;reserved=0
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
