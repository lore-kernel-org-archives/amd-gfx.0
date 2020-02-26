Return-Path: <SRS0=BS7L=4O=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33779C4BA0A
	for <amd-gfx@archiver.kernel.org>; Wed, 26 Feb 2020 04:00:17 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C017321927
	for <amd-gfx@archiver.kernel.org>; Wed, 26 Feb 2020 04:00:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="3FI3f/7l"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C017321927
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 294266E0E6;
	Wed, 26 Feb 2020 04:00:16 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2054.outbound.protection.outlook.com [40.107.244.54])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 315666E0E6
 for <amd-gfx@lists.freedesktop.org>; Wed, 26 Feb 2020 04:00:15 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=M3wYWOn8bsFHhUvcX/dOIOBE+xdOCJrSHKbBWU18jXlbaMZKfu1ZArDCqJaZzR3qRg6EobxB5sowk8Qq3DYJpuke/L1EAWUnghF63TgB5dFIUMPVRnZB6xPt+gkbJLXh+yyKyBVl2EluinMiPv+Ep1m9jXSYd7JVcK6SF0tXYQCuu16YjGxYPv6CW/xbJde8Ad3/AnR/x25kcK1OjCZDhk7wJlxLG5qZ6XxqBm5WxGFz7mgWzPgalMop0F7PYB97F8maLDk92bzyJteASUem7Q+k3eObqgqMauz+wc5XIek1T9nAMGHP/qu2Dlz5z6Nui6bA90AY6mRJNKwwUSxv5w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Dtt8ecjK3kNvBZWTBdnpmCmHfXS8fC3TPMbyn/0Ww/Q=;
 b=FDYDobghJVTGZLQ2JlHGSA8fJ1wrRd2V22olarRNmafQOvsw/YtLHSJpOqGt4xg1M/BKVy0zMl0xjj4KmjzmfUFYl39lsZANgUw95swYmz3SLp6LN55XKpUUvA4mqMy1XBLn8ybO4ivZQiLbLSMOq4XEY+EWquJ1Iwh8X7BleF6PXjVXXiDlu5JbfcSyJ2gAMCX+MZP0pu931q6tvvaYbbJDEQw8AJN8sVElQ+3Plxql8ZtVQM1IQYxEOV2UZ/KdBYX/xHDmdLwR9o6lZf9vPNTEG2TfBpSFzNStCDc/2+RgN5eCqzQ8S3WuuDDwlhfp0zwLdNYZDH4u8Kd7/WZ5Ww==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Dtt8ecjK3kNvBZWTBdnpmCmHfXS8fC3TPMbyn/0Ww/Q=;
 b=3FI3f/7lAus3uZXMjdF4lKXJ+e7mQoMP9cIINxjqnSNdOwJlXst5NwCuD2sDXSZrY0jDZxxytchokeCgoFPEh87Anp7rnjyoJeOqJwxCIdQS6ygINx7Vvn1HApqBFk7yREQ5UIVF5GR1oE59NAJfMkV4mAXA4ISO8mKAPpkqjok=
Received: from MN2PR12MB3344.namprd12.prod.outlook.com (2603:10b6:208:c5::10)
 by MN2PR12MB3376.namprd12.prod.outlook.com (2603:10b6:208:c2::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2750.22; Wed, 26 Feb
 2020 04:00:13 +0000
Received: from MN2PR12MB3344.namprd12.prod.outlook.com
 ([fe80::69c7:b493:690:2173]) by MN2PR12MB3344.namprd12.prod.outlook.com
 ([fe80::69c7:b493:690:2173%3]) with mapi id 15.20.2750.021; Wed, 26 Feb 2020
 04:00:13 +0000
From: "Quan, Evan" <Evan.Quan@amd.com>
To: "Russell, Kent" <Kent.Russell@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amdgpu: Fix check for DPM when returning max clock
Thread-Topic: [PATCH] drm/amdgpu: Fix check for DPM when returning max clock
Thread-Index: AQHV7Bj80WA9SM1AWE25qZF63lEVp6gs2jsw
Date: Wed, 26 Feb 2020 04:00:13 +0000
Message-ID: <MN2PR12MB334438423E1EDFCAA2054F19E4EA0@MN2PR12MB3344.namprd12.prod.outlook.com>
References: <20200225201945.27720-1-kent.russell@amd.com>
In-Reply-To: <20200225201945.27720-1-kent.russell@amd.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ActionId=58dd93be-9270-41d8-bb14-0000d53dbe83;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ContentBits=0;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Enabled=true;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Method=Standard;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Name=Internal
 Use Only - Unrestricted;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SetDate=2020-02-26T04:00:00Z;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Evan.Quan@amd.com; 
x-originating-ip: [180.167.199.189]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: bc57fbf3-fbad-45db-3106-08d7ba7061c1
x-ms-traffictypediagnostic: MN2PR12MB3376:|MN2PR12MB3376:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MN2PR12MB3376B69CCF5CC2AEC6E9BAA9E4EA0@MN2PR12MB3376.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:3968;
x-forefront-prvs: 0325F6C77B
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(4636009)(376002)(366004)(39860400002)(396003)(136003)(346002)(189003)(199004)(66946007)(186003)(71200400001)(8936002)(64756008)(8676002)(26005)(66556008)(33656002)(66446008)(66476007)(7696005)(6506007)(966005)(5660300002)(53546011)(316002)(478600001)(110136005)(9686003)(55016002)(81166006)(2906002)(4326008)(81156014)(86362001)(76116006)(45080400002)(52536014);
 DIR:OUT; SFP:1101; SCL:1; SRVR:MN2PR12MB3376;
 H:MN2PR12MB3344.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 5EmlNRp5cA1btVdJkRjoWRLj6B9JRluteOecLxyG0PHaBpy1S/dSrCxZY2rK7kR8WGFpoR+w4DDgyptX/4tiM6AxqAMem6kNk617+N4eNLUMSQpdgHfDEIO4yBI5r0W8Sd/xDWOGwSaedNXefROcP9NmElHYJ7vU5P2Ha9IMPDC5dKbuTOQohVMrWhrQpmB1jAw7YlKUFxce6YEtvZ5BK8JiPRXFJMu3e2Tzr1xiiFDCEeTZ4tmgkUMFA6drC3ApgLtTW/nFlOunQJEaXD9tD6VdFmqrk5cOzAM+nfNco53P8j7SEbVEwqOOjgTrznViOZXRNa9++tWG2CkpcVOjst5hbo/5dfOvo3xUsq8iGP9K42rHZjtN4v7mxVWfwGNIkt8fmm4Ojw0bS0Ra69L1ruCMek0i936tDhl4MlYvyIiLVGpNhkPqz2QIEmwhUGteHZNy1TQ2v1tqLIhfCQa0LvO7zWun5++8U18YVdxn7gqmFwvthoCatASo9w8caI3iLxFSggA9+ZaesATjZYMeLA==
x-ms-exchange-antispam-messagedata: CpgDMTCiBBn3Z6GPGVRYFQgDcMYbv4mXN4MriZJc+4UUZxUmZz/+R/RLEmAo5jqSTo/z7uATpNpPidYW706xZGHvTt72Ew3T9MC7ayojMxPngwiJB3Mk6CEIKrk6YZlju/GeMIsf1Z/znbV7nu1VdA==
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bc57fbf3-fbad-45db-3106-08d7ba7061c1
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Feb 2020 04:00:13.2910 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: uWXJ21s3XgShyEyoSecBkzniJUml5jZ8c7NEeGu4bcTNaZFbGkZuBXuFKJgeoPwM
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3376
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

Reviewed-by: Evan Quan <evan.quan@amd.com>

-----Original Message-----
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Kent Russell
Sent: Wednesday, February 26, 2020 4:20 AM
To: amd-gfx@lists.freedesktop.org
Cc: Russell, Kent <Kent.Russell@amd.com>
Subject: [PATCH] drm/amdgpu: Fix check for DPM when returning max clock

pp_funcs may not exist, while dpm may be enabled. This change ensures
that KFD topology will report the same as pp_dpm_sclk, as the conditions
for reporting them will be the same.

Otherwise, we may see the issue where KFD reports "100MHz" in topology
as the max speed, while DPM is working correctly.

Change-Id: I967988e936de5371c22bf92895bda22324d9631b
Signed-off-by: Kent Russell <kent.russell@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
index e1c2c182898f..7e8276651865 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
@@ -402,7 +402,7 @@ void amdgpu_amdkfd_get_local_mem_info(struct kgd_dev *kgd,
 
 	if (amdgpu_sriov_vf(adev))
 		mem_info->mem_clk_max = adev->clock.default_mclk / 100;
-	else if (adev->powerplay.pp_funcs) {
+	else if (adev->pm.dpm_enabled) {
 		if (amdgpu_emu_mode == 1)
 			mem_info->mem_clk_max = 0;
 		else
@@ -427,7 +427,7 @@ uint32_t amdgpu_amdkfd_get_max_engine_clock_in_mhz(struct kgd_dev *kgd)
 	/* the sclk is in quantas of 10kHz */
 	if (amdgpu_sriov_vf(adev))
 		return adev->clock.default_sclk / 100;
-	else if (adev->powerplay.pp_funcs)
+	else if (adev->pm.dpm_enabled)
 		return amdgpu_dpm_get_sclk(adev, false) / 100;
 	else
 		return 100;
-- 
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Flists.freedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;data=02%7C01%7Cevan.quan%40amd.com%7C663886c987544bc009dd08d7ba3018c1%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637182588127200343&amp;sdata=Eie%2BqVNC1%2FgC7G3Ry7PeFVjPNBrEy89IWrh53Bhy%2Bs8%3D&amp;reserved=0
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
