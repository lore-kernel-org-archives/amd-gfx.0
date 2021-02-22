Return-Path: <SRS0=DoF4=HY=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65CA0C433DB
	for <amd-gfx@archiver.kernel.org>; Mon, 22 Feb 2021 16:14:55 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0796E64EC3
	for <amd-gfx@archiver.kernel.org>; Mon, 22 Feb 2021 16:14:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0796E64EC3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9ED796E52F;
	Mon, 22 Feb 2021 16:14:54 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2059.outbound.protection.outlook.com [40.107.94.59])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7C30B6E52F
 for <amd-gfx@lists.freedesktop.org>; Mon, 22 Feb 2021 16:14:53 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SXPUhC7sRNf4vG2Fw7TFBCCm7vjK+PFl/AJx4xSd+hotbtWjwL8ykpcvwvdZh6cSfVWRh7hND2hq3ajh3CdDktfegW0xqkX70QpFDVNUTsUTheUPDBY2LRp4PJ4cx9wn1vLg9Q+NE86oyys9L4YGBu+yPRt5lFCCtibjMEEbZkgbvhs99vYdMAFzMuQJW3v8Glam0JfRqD/hCJQjKhsIlgh3oHw5EiMwl0eAi2yOFEMfGzTUTk0uWiP+MG932AlPGHk2i4jrWiT2InGop9GP62h+Sb6vXS1Ip0riGwuYyA9l7iLAlia4l0rsGfPkNx1PXsw2nt7eChhZfVfiH1SHKQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3i/p+JQGToy4s/r0RczAps2oXM4rNsjtm4FCSCN9DDQ=;
 b=gDS18XpzkLy1g0aalgAnChS/C18yo/CVUP6AKZOVqpHDc8bhP1tBHwQKu65X8YUGzkXQD6Kh/24xW6PboG55LR44z86FhC/pmrbkhFtxDtR9ljgQ0St+LII4USrXeF2zBNGqOtEQvETM1BR2MSpTgyuepvcpEJQanGjkvWH8PZIXDKZA+IMvwmgGOf68DgseLMIJJWgU3HptQHLqlwCNXawKz6lnk1BE2bSw6ao2y/Ou2uqM0TgadRvIGMNjow60m8C1pLkYNW18fVFJTDhDeSbdF+JLhKeEWW3adkR3Initt6Pmjcsp89NKaJ5CFe/y9PDUJuBUhqNqVpDQI+CABw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3i/p+JQGToy4s/r0RczAps2oXM4rNsjtm4FCSCN9DDQ=;
 b=XOQlHN5goCY/15O8gQAUCVS1zZtwV+ZMM2CZ9Fy1YV+MVZKKVLr+s9DfSs8X9ATJIh4Ifped+xKgkri3Y2LGB6Q8tcqOTQ35hIUQL5L7yEFfk2/+vj6C8LQY4UGFEh+Is6Jr749JeBtTxkpOu7BiQRNRXsMZzrZQ/zfXp7TZmFU=
Received: from DM6PR12MB3835.namprd12.prod.outlook.com (2603:10b6:5:1c7::12)
 by DM5PR12MB1658.namprd12.prod.outlook.com (2603:10b6:4:5::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3868.32; Mon, 22 Feb 2021 16:14:51 +0000
Received: from DM6PR12MB3835.namprd12.prod.outlook.com
 ([fe80::102:2c9a:54ce:63e9]) by DM6PR12MB3835.namprd12.prod.outlook.com
 ([fe80::102:2c9a:54ce:63e9%6]) with mapi id 15.20.3846.046; Mon, 22 Feb 2021
 16:14:51 +0000
From: "Liu, Shaoyun" <Shaoyun.Liu@amd.com>
To: "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH 3/4] drm/amdgpu: Add kfd init_complete flag to check from
 amdgpu side
Thread-Topic: [PATCH 3/4] drm/amdgpu: Add kfd init_complete flag to check from
 amdgpu side
Thread-Index: AQHXBl1Pt2LnISRy902bbZTuDh2Li6pkXuGQ
Date: Mon, 22 Feb 2021 16:14:51 +0000
Message-ID: <DM6PR12MB383590C0509F2E62A4CA89DFF4819@DM6PR12MB3835.namprd12.prod.outlook.com>
References: <20210219011934.28514-1-shaoyun.liu@amd.com>
In-Reply-To: <20210219011934.28514-1-shaoyun.liu@amd.com>
Accept-Language: en-CA, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Enabled=true;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SetDate=2021-02-22T16:14:42Z; 
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Method=Standard;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Name=Internal Use Only -
 Unrestricted;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ActionId=a3e8ae2e-d454-482a-81ee-4c47296f0ce6;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ContentBits=1
msip_justification: I confirm the recipients are approved for sharing this
 content
authentication-results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
x-originating-ip: [2607:fea8:3bc0:316:c0d5:387b:19b:615f]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: cd6341c7-0a24-4a56-dfa0-08d8d74cfbbd
x-ms-traffictypediagnostic: DM5PR12MB1658:
x-microsoft-antispam-prvs: <DM5PR12MB165886D848362C6E1DE3AD02F4819@DM5PR12MB1658.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7219;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ViegHDrTgjxy5wJyXxPa6/acFfJsKTg6jC0i+kqoS29fqC2TEyAP49wajuZlPIy+UmGWDat84FNNW66Q/ovKw/OdMzdEROdMOzcIPsqyEiynelefuOGtWM4zPaPn7F3yqrUptDPjcmTk8Qa5kiMwWi7Sq/eL6zLef7zgOoBzWtZrS/hVFr0Tvc2Vmk1Qa6E+y80iIN/6LM59bWxYKPAj2R6FO/nTQb34CKZc+dBX24TSJukJ4VaJlOZIvzSff/HS60PTyqR/2TCDIw41mXXz04DLW71CX6Mr9nTf3T5+NaAfKypk1CoNZufRs7dRnpRT74AqW/Ew4DBkaE6u6OeUOcpeLne30nEt/kd3O14yOMBtjD2xqxVmECpcPU1MMQ/4eN3faPJnhs8Rwsuna0YDbGtOB/7jJ1x773B6YUxiM3KXCWBR/Qic058U01yrfIrCvyznY/OynHskJ7QdYX1LTXM2dTCKms++KxlKawV9u6HTxyEPhusoEHoYJwkv+ArgQTmuqJPo80KStJqwxcrMSQ==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB3835.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(39860400002)(396003)(136003)(346002)(366004)(376002)(71200400001)(53546011)(76116006)(7696005)(478600001)(66476007)(66946007)(6506007)(64756008)(66556008)(66446008)(8936002)(2906002)(52536014)(8676002)(5660300002)(316002)(86362001)(33656002)(6916009)(9686003)(55016002)(186003)(83380400001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?LK293OaZHAYUEAF9muZGaDrII7KKcANscldVpMZ9ao1ULIk6yGqSAcpknn1p?=
 =?us-ascii?Q?KwcuDwkr9a/l5ODo8WEWF+ILm0w/tF2pMfBEoOBRAfOPha8xdPh4X62UiJzz?=
 =?us-ascii?Q?H4KBv0xGnlgoL5ELMTn53BsU+JJP2/12yDVLgBjV7UDGYvTMyPGIrNPNYrr0?=
 =?us-ascii?Q?VBiF/a9EQQG9CS1x7qvrW9zhpjDSmsnMAgSO7825QmONIzC3TpRYBH/296dz?=
 =?us-ascii?Q?mDReKLFF929fFMxfUCihMRfnl5Y90uH6z4EUJVHBvmOxDrOL5WqtutLdmuqb?=
 =?us-ascii?Q?2AEnvtvKi0CbxfpmqMTU88Kuu+klAF3iiMSWk5qE4e/9tdOCEEQ5ltLvr6bz?=
 =?us-ascii?Q?LnY+EmgW7kYVfChuFsPd6zMYmmdcetGBlS+u0lkI5fQlnhfvcOaU1r5+QdcO?=
 =?us-ascii?Q?QYf7PucxkM/WtaOi6YTj1XNIuaDRIwLrI6/b+j2JAEYb5+PNeLh+heacigxw?=
 =?us-ascii?Q?33YWpNXYTa/yZbQ99YTHqqlWIf+ZQMNa1ZAZcnJajf8Ma76cfcskm7HpevV6?=
 =?us-ascii?Q?L2VPo+HQ+Nvhl71vZeU0AlcDFcLn1/AyEMWq9rPhKi6wQ6/jg8/pq/0Fg9J2?=
 =?us-ascii?Q?zRzzIPp/nq8fNzcHhjQ3dBxS697pBJ5nwDnvNexomZUUWA5uTphUFS0Qb2R1?=
 =?us-ascii?Q?czWknou3kYo692/kMGX0xQ4eBTUvwQyXiefp2icC804CZmb5ZkXd7mqikaZ4?=
 =?us-ascii?Q?XdVbUuV+ykQ5+94s6huhJA/MpblkgB2xB9OYPQQ1YPV4MrqJstTeplFJUVqu?=
 =?us-ascii?Q?gmMxWw7KrZAqfHIYGNN7p1JpvOWP6Ela5qVDf9eJX46c7sNYc/hFOtohnIR9?=
 =?us-ascii?Q?lE7t6iOg5qFC3dt0FKnFhV5Zh5eNmGGkDlUKCZmtC89iC8c+L7OajJ+VMHog?=
 =?us-ascii?Q?beJF2pTP9mcLyL+l78/NPndgKxGU7JMRXS1jWB+IReSQgw4FLfTkwgBm25Wp?=
 =?us-ascii?Q?03pzDrMeuMMOq+vwDruT8vCY2PeO/2XrSL5AYXBh4mc0FQzry+XEz9Ot2YE3?=
 =?us-ascii?Q?ZfTKPaRtMAFcbXNNVXW3s/xURO3V5i79g2tQMiak5NgPd6LAqB4r0fLO/aHQ?=
 =?us-ascii?Q?sWz4Y44B/W5N6FDvewatiG1a9LR/QEub1Xx1SD+0xlzrSmdw4KCgZEKNVNAT?=
 =?us-ascii?Q?SZKuGVH9sh/I/75E2ilErYE88dOM99dZH71vY3YqX6JYMsX0y74AcbMH6xMr?=
 =?us-ascii?Q?KWIZo04X/Lj5EKbY9bh+3e5BMnz1nAkKXTsB4VrpD9Ps1gu9WYmjcp69snuW?=
 =?us-ascii?Q?LtJR/6HWb53h9KrET202B4MrUMPDbsDqeXZf2/2go/Ucp8fEBU2JdlPdC5++?=
 =?us-ascii?Q?W6KXjwKRK8Pss3lIxYwpWFfae2GqDMBVPWutlLxNGPoN/zml2mcFmhVsYmNA?=
 =?us-ascii?Q?3uc+qEKTgqc7HiyZ/xBS7us4jtZy?=
x-ms-exchange-transport-forked: True
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3835.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cd6341c7-0a24-4a56-dfa0-08d8d74cfbbd
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Feb 2021 16:14:51.3356 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 1igKwFoofrQmZszQ89rTtBLs4KCOcPHPzogBJmOV3M4azwYHk9F0hfHSZibNs5NFfg0By8Gk8qq0y+NtjLFl6A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1658
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

[AMD Official Use Only - Internal Distribution Only]



-----Original Message-----
From: Liu, Shaoyun <shaoyun.liu@amd.com> 
Sent: Thursday, February 18, 2021 8:20 PM
To: amd-gfx@lists.freedesktop.org
Cc: Liu, Shaoyun <Shaoyun.Liu@amd.com>
Subject: [PATCH 3/4] drm/amdgpu: Add kfd init_complete flag to check from amdgpu side

amdgpu driver may in reset state duirng init which will not initialize the kfd, driver need to initialize the KFD after reset by check the flag

Signed-off-by: shaoyunl <shaoyun.liu@amd.com>
Change-Id: Ic1684b55b27e0afd42bee8b9b431c4fb0afcec15
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c | 3 ++-  drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h | 1 +  drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 7 +++++++
 3 files changed, 10 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
index c5343a5eecbe..a876dc3af017 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
@@ -165,7 +165,8 @@ void amdgpu_amdkfd_device_init(struct amdgpu_device *adev)
 					adev->doorbell_index.last_non_cp;
 		}
 
-		kgd2kfd_device_init(adev->kfd.dev, adev_to_drm(adev), &gpu_resources);
+		adev->kfd.init_complete = kgd2kfd_device_init(adev->kfd.dev,
+						adev_to_drm(adev), &gpu_resources);
 	}
 }
 
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
index 4687ff2961e1..3182dd97840e 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
@@ -80,6 +80,7 @@ struct amdgpu_amdkfd_fence {  struct amdgpu_kfd_dev {
 	struct kfd_dev *dev;
 	uint64_t vram_used;
+	bool init_complete;
 };
 
 enum kgd_engine_type {
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index 9f574fd151bc..e898fce96f75 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -4841,6 +4841,13 @@ int amdgpu_device_gpu_recover(struct amdgpu_device *adev,
 		/*unlock kfd: SRIOV would do it separately */
 		if (!need_emergency_restart && !amdgpu_sriov_vf(tmp_adev))
 	                amdgpu_amdkfd_post_reset(tmp_adev);
+
+		/*kfd_post_reset will do nothing if kfd device is not initialized,
+		 *need to bring up kfd here if it's not be initialized before
+		 */
+		if (!adev->kfd.init_complete)
+			amdgpu_amdkfd_device_init(adev);
+
 		if (audio_suspended)
 			amdgpu_device_resume_display_audio(tmp_adev);
 		amdgpu_device_unlock_adev(tmp_adev);
--
2.17.1
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
