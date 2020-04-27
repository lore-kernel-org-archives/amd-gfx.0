Return-Path: <SRS0=xwvD=6L=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD49DC54FD0
	for <amd-gfx@archiver.kernel.org>; Mon, 27 Apr 2020 04:24:43 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A8B872084D
	for <amd-gfx@archiver.kernel.org>; Mon, 27 Apr 2020 04:24:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="CwTq0ojL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A8B872084D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6F18E89FCA;
	Mon, 27 Apr 2020 04:24:43 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2086.outbound.protection.outlook.com [40.107.244.86])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8B83F89FCA
 for <amd-gfx@lists.freedesktop.org>; Mon, 27 Apr 2020 04:24:41 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MaoytJoNpi3+nSHrpmN8BB9fbQNUV7VbzUCclLoy6tdsdpRWlqwqmVyl9NP5JNb0wdAp4q2vSbi2Qdhfqwl3V/UcSxMMaVx1bENFx0bfd+2vObK4CQAJKo18WaBGWkTFfO1M303V12Ujdt1hHUNh0/dMnbpGH80lvaCmYfoHFiW7jFveiA2PPFaGqN62davfyZPtG6vq4sw3c1b/5rmEEuo+7dXlWHq1Ar8ay04obXM32D+MdR6/XNNPoH15/CZv8v+LdgRKzDj48r4hRX7gpoP8qLGSKYslskIkpjyfab3MC1W4NhZeeB+lgkTB/Su8vuiKTWUqW5388CFuKUaFew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jHnYU32EZ0I/XpK5y2UgdLifGIHYszloHAC4dqbHb7U=;
 b=VCu4NBW8+7v7TQfG3sFORz8O5FMz81aiEc8JJkq6HIFg8ZjAwT/w+xf6Gx0xedVfbKpEVh0PCHfLdVeE6vruzj6shwDNDqOds0UfMqdwVyoKo1Y8RTJPfGDb0FvA3ki0gwVAfkVXdrVYLuX5Vxfqp0i3hKxVA7CmdoVKKgxjWwy0wNy+Onc/Tjj+MVclPK9+mWJAGRBTgWeri0NsPOZTKkTobUlakaOdZ7L++Dabz8TjMVXoi39CX/eMPDvoI7JeWd/BMSEVWiANH8oKp9k/6OORZ4ZRm615qOwZcNEs0k15l1vnik5H4smvzswA4qIfhfGCuF5zpClSRZ9DnBvabA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jHnYU32EZ0I/XpK5y2UgdLifGIHYszloHAC4dqbHb7U=;
 b=CwTq0ojLusTe6G10P5u3efUcL7mlV9tnmYdm9BaaDuoZCgtugfxwYV0bYD8kz9uJpoiUPJr3et7YgbFf1afzVSDlzhXcEAGo1KzQGeCcPMG3P22H25QlEfRPhudJ3YTMea45/qmBOe4K5pL6ZlR/sxMeoHqKBjxUayYQl2Xw5Ks=
Received: from DM6PR12MB4075.namprd12.prod.outlook.com (2603:10b6:5:21d::8) by
 DM6PR12MB2892.namprd12.prod.outlook.com (2603:10b6:5:182::22) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2937.22; Mon, 27 Apr 2020 04:24:39 +0000
Received: from DM6PR12MB4075.namprd12.prod.outlook.com
 ([fe80::50d1:ecd6:255c:fbcd]) by DM6PR12MB4075.namprd12.prod.outlook.com
 ([fe80::50d1:ecd6:255c:fbcd%4]) with mapi id 15.20.2937.023; Mon, 27 Apr 2020
 04:24:39 +0000
From: "Zhang, Hawking" <Hawking.Zhang@amd.com>
To: "Liu, Monk" <Monk.Liu@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amdgpu: fix one vf mode
Thread-Topic: [PATCH] drm/amdgpu: fix one vf mode
Thread-Index: AQHWHETllTaqLdRLPkWrC2qwVl26UKiMXoeg
Date: Mon, 27 Apr 2020 04:24:39 +0000
Message-ID: <DM6PR12MB40756F527F7715A384A74632FCAF0@DM6PR12MB4075.namprd12.prod.outlook.com>
References: <1587958502-10638-1-git-send-email-Monk.Liu@amd.com>
In-Reply-To: <1587958502-10638-1-git-send-email-Monk.Liu@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Enabled=true;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SetDate=2020-04-27T04:24:35Z; 
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Method=Standard;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Name=Internal Use Only -
 Unrestricted;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ActionId=ab523217-3d8c-4a90-903b-0000e76cf829;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ContentBits=1
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_enabled: true
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_setdate: 2020-04-27T04:24:35Z
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_method: Standard
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_name: Internal Use Only -
 Unrestricted
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_actionid: beb78cfd-0e27-41f0-a8db-000090e55c21
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_contentbits: 0
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Hawking.Zhang@amd.com; 
x-originating-ip: [58.247.170.242]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: dcb9bef5-0d1f-4ca2-5a3e-08d7ea62e68a
x-ms-traffictypediagnostic: DM6PR12MB2892:|DM6PR12MB2892:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM6PR12MB289256679B55F242573F7CDDFCAF0@DM6PR12MB2892.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-forefront-prvs: 0386B406AA
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB4075.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(346002)(39860400002)(396003)(376002)(366004)(136003)(64756008)(966005)(76116006)(86362001)(53546011)(478600001)(33656002)(45080400002)(4326008)(8936002)(6506007)(26005)(8676002)(55016002)(71200400001)(66476007)(316002)(5660300002)(66946007)(7696005)(66556008)(66446008)(81156014)(186003)(52536014)(2906002)(110136005)(9686003);
 DIR:OUT; SFP:1101; 
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: U2EwwN/zeQAeAu8rUCvRhZjZbTB7cjCwaZXFchQBlwvogklmEiG7FS2htD99F8ucMxXUfOrUAw/OexuOobu+V8Hzbtj1xLqwiyL2iH9wghjFfB77+pLIZHCjKf7cHr3QMXbKUHl761Ulk0R8bGkx7mL+Kq8YmkUUsoaDAo8BaivIJov6y2Y04ynXLCj4MH0kLS9VnRVOXzsomw/znQpx2d4kGxoC20MfI940bjg2Pd3AE7/O4JCTGLaz5i/+lnAuB2UAtgF7lz6oK+O5UUzm//UHMlT8aH/Y388fSbXCOoS9Mfk/D1bT0yqqxBBHw62Kd8wPUNFVwYm6PkbALfvUFbVE/hQv2U6PqKqjY2SOamqUexKySzdlALUInC6HMz73xSpOSZMPBGGnL1zFiCMOrXgBb/HuMGiNRaLjukjhxjHPqI6Lt7jblkwNQfpoP0JfEKzAxuN2iGxd0H3zAIgTWJMPJ7D81fNfsf1QLU2yD/8=
x-ms-exchange-antispam-messagedata: DH64wzXEu4nrpmxgBKQZQPWa3BKUt4KJnLYvCx3raXy1wokyvWYN26fQCrIRX2KA1bsXuAwvErDgU71L7hgsfgRMfbw8FtX6nCTGmvIqsLKETulfpF0osRZrzQDdyeifBoDXfxlyLkRAlO4IB8v3dpQbytcUXcIBwPKzC+T0rkbgrcBYmygI/+fncfWTC9CWwtmtSzpW1PX7S6vUdpa0OLByV5vk13NX5kTRraVyoyyqJlJvnQe+f49FFgE/0ZszI69aGAnw5nUbLMNcnm3pWUthR1mvRhQwmWGgiAOZWTlhcKxKf1EllNyF/hCPxlbdiumawthZiu6QMGdqvaf0vPwE1A4efTWNB3qgc4R+EdtVFs1jB+R17flSMfNMIUEBSLJ1vFAdUPp5Q5KqFHhqEQvKBZSMRJIv8gMODXX47PmkgVRFNvWdaUum4D/JfyIm7quFAmrbRe+AwU2bPxw7DsYnQOGIiYkio8UcGIex6wRwmyljTiIlzBnY4lT8Zd02fPs93ZYLnmaBwO1rRuKSGgqjm+sM+Mt085NgV+y04OyknAf4Fa8Tp8C4tKW73EF1SnOJ1bSmr8Id4O/JMJf1VogaHNN/TJaEAw+I5A9ITzQS3zTAc6IaT/prREyf/bB2lLwlqQOD4kCJBDIiP9J9SFH5awTRULNwcZ6KjBoEgG7jKOXg4cAsQVLzSB+fLwl1c/eSnn0tUDWsc8F5cFWONsc/1370bQQMCDoN5jd9rD3aWu9gSIJTWXFt3hIg2KjxYGkegnQBPzBNWY6qtj8MEyIUdJogZoKF5S5DcI+TNck=
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dcb9bef5-0d1f-4ca2-5a3e-08d7ea62e68a
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Apr 2020 04:24:39.0521 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 6ZFKIkZDtjHSwbakVkHXjCfrG9nIPACVJPBZait6pTVSDQ8GEIxnlk1xM98MnwRWkwIcknYke9xvxVLGFsnaWw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB2892
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
Cc: "Liu, Monk" <Monk.Liu@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Official Use Only - Internal Distribution Only]

As discussed, we want to keep this patch until we finalized onevf mode support design in guest driver.

Current approach to add one_vf mode check for every smu function is not sustatinable and error prone when new asic support added in software smu

Regards,
Hawking
-----Original Message-----
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Monk Liu
Sent: Monday, April 27, 2020 11:35
To: amd-gfx@lists.freedesktop.org
Cc: Liu, Monk <Monk.Liu@amd.com>
Subject: [PATCH] drm/amdgpu: fix one vf mode

still need to call system_enable_features for one vf mode but need to block the SMU request from SRIOV case and allows the software side change pass in "smu_v11_0_system_features_control"

by this patlch the pp_dpm_mclk/sclk now shows correct output

Signed-off-by: Monk Liu <Monk.Liu@amd.com>
Singed-off-by: Rohit <rohit.khaire@amd.com>
---
 drivers/gpu/drm/amd/powerplay/amdgpu_smu.c |  8 ++++++++  drivers/gpu/drm/amd/powerplay/smu_v11_0.c  | 13 +++++++++----
 2 files changed, 17 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/powerplay/amdgpu_smu.c b/drivers/gpu/drm/amd/powerplay/amdgpu_smu.c
index 5964d63..bfb026c 100644
--- a/drivers/gpu/drm/amd/powerplay/amdgpu_smu.c
+++ b/drivers/gpu/drm/amd/powerplay/amdgpu_smu.c
@@ -1183,7 +1183,15 @@ static int smu_smc_table_hw_init(struct smu_context *smu,
 				return ret;
 			}
 		}
+	} else {
+		/* we need to enable some SMU features for one vf mode */
+		if (amdgpu_sriov_is_pp_one_vf(adev)) {
+			ret = smu_system_features_control(smu, true);
+			if (ret)
+				return ret;
+		}
 	}
+
 	if (adev->asic_type != CHIP_ARCTURUS) {
 		ret = smu_notify_display_change(smu);
 		if (ret)
diff --git a/drivers/gpu/drm/amd/powerplay/smu_v11_0.c b/drivers/gpu/drm/amd/powerplay/smu_v11_0.c
index 3e1b3ed..6fb2fd1 100644
--- a/drivers/gpu/drm/amd/powerplay/smu_v11_0.c
+++ b/drivers/gpu/drm/amd/powerplay/smu_v11_0.c
@@ -764,6 +764,9 @@ int smu_v11_0_write_pptable(struct smu_context *smu)
 	struct smu_table_context *table_context = &smu->smu_table;
 	int ret = 0;
 
+	if (amdgpu_sriov_vf(smu->adev))
+		return 0;
+
 	ret = smu_update_table(smu, SMU_TABLE_PPTABLE, 0,
 			       table_context->driver_pptable, true);
 
@@ -922,10 +925,12 @@ int smu_v11_0_system_features_control(struct smu_context *smu,
 	uint32_t feature_mask[2];
 	int ret = 0;
 
-	ret = smu_send_smc_msg(smu, (en ? SMU_MSG_EnableAllSmuFeatures :
-				     SMU_MSG_DisableAllSmuFeatures), NULL);
-	if (ret)
-		return ret;
+	if (!amdgpu_sriov_vf(smu->adev)) {
+		ret = smu_send_smc_msg(smu, (en ? SMU_MSG_EnableAllSmuFeatures :
+									 SMU_MSG_DisableAllSmuFeatures), NULL);
+		if (ret)
+			return ret;
+	}
 
 	bitmap_zero(feature->enabled, feature->feature_num);
 	bitmap_zero(feature->supported, feature->feature_num);
--
2.7.4

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Flists.freedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;data=02%7C01%7Chawking.zhang%40amd.com%7Cadd54868b3d8404af9a508d7ea5c0535%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637235553277191960&amp;sdata=bdieikeeCvuUqIBD7LHUpoZzFxIdRxMsXmQdqZ12AD0%3D&amp;reserved=0
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
