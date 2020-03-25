Return-Path: <SRS0=Seja=5K=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D0BBC43331
	for <amd-gfx@archiver.kernel.org>; Wed, 25 Mar 2020 10:48:22 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 34DCA206F6
	for <amd-gfx@archiver.kernel.org>; Wed, 25 Mar 2020 10:48:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="wyOaVGV3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 34DCA206F6
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C13006E7DD;
	Wed, 25 Mar 2020 10:48:21 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2081.outbound.protection.outlook.com [40.107.244.81])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EE9EB6E7DD
 for <amd-gfx@lists.freedesktop.org>; Wed, 25 Mar 2020 10:48:20 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TtZngHfPHmeSH7vqwQ3Onf5aE/D56aYjkRA1FuQNQu5E8Q6/64lVcOdPD53u1vyDrkPSgmgqSPipHpG9rsfGJgu+HzxMUNDnImx+TaMlSvxd/36x8onLuNVDgXvLwBUVTsDDhrjFtVtPzOWyqy7a0wQ4CLShMKhs6Dh3vHwaIKKD1IYHB4G785il6sjgIdw3E0dnJDrukohE8NqRL2L3iENI8UH2NvxAsl1HsEY4W6rQH7bFIGDfgK+sJJtUcuZlIcJN9A0B8CDfxAdG58aQlKqW/URNyaScHJH8x6Kjz4JxL2kMCwdbMO26Uxmu4b0ALWY8fralM89ruXWmTw5tsQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=s9zbNtU+eNHztbLYd/BdMGE3ofzDOkLKU7AnkrzzCe0=;
 b=L+cVipOnyeBa1B1ZKx53Cqcm7sTF9ebItqX7yQoGk2QAgRZ1kk0qJom+X5L6bTI6E17VsJBXSUu9CQangPZfpHNTsdeBIo9Gc+E1lzMX63NwNUths08Ph8kAq2JaPGtrCX33VksThFAXRwFXS9I9TCxHGKfAD1f4KEM3540jrkOhbNxmV0A5Tq9Ql0XBRvtRcz10MqYZD2RfB708Ngh3o/X5Jvsjxboc6x9AhEQeyJW2d/MczSvc49gIdW9LlFnF9Pb1ojx8Y0HGMQ/b4IGmB3rs5iYO4BnchwbnvRfmfWwJAKBc0nY9GM/raz7AWb4pueAyvM/67qOaXt9pqaHTpg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=s9zbNtU+eNHztbLYd/BdMGE3ofzDOkLKU7AnkrzzCe0=;
 b=wyOaVGV3PAA7Yk87X2sO2lKqpyZwUGyi1QqbqTmA+lyyU9u+2cH5rQFTAD/6u68APBHwF39j79KntO4eV/ADkpfnDztd59IFnim7qPb7npGhhpzZUd1C7LzprXtPr+abyUsAksm58EmvW1jtn+TGX/xFPkohyOp/VZNeII64JqI=
Received: from DM5PR12MB1708.namprd12.prod.outlook.com (2603:10b6:3:10e::22)
 by DM5PR12MB1323.namprd12.prod.outlook.com (2603:10b6:3:75::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2835.18; Wed, 25 Mar
 2020 10:48:18 +0000
Received: from DM5PR12MB1708.namprd12.prod.outlook.com
 ([fe80::e9bb:a239:5bd3:7325]) by DM5PR12MB1708.namprd12.prod.outlook.com
 ([fe80::e9bb:a239:5bd3:7325%10]) with mapi id 15.20.2835.021; Wed, 25 Mar
 2020 10:48:18 +0000
From: "Liu, Monk" <Monk.Liu@amd.com>
To: "Deng, Emily" <Emily.Deng@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH 1/4] SWDEV-227605 - Virtual display need to support
 multiple ctrcs
Thread-Topic: [PATCH 1/4] SWDEV-227605 - Virtual display need to support
 multiple ctrcs
Thread-Index: AQHWAn7gunDaoKNOPUqbnk8an9OAi6hZILaQ
Date: Wed, 25 Mar 2020 10:48:18 +0000
Message-ID: <DM5PR12MB1708AF440E8B08DEF59C893984CE0@DM5PR12MB1708.namprd12.prod.outlook.com>
References: <1585124676-14143-1-git-send-email-Emily.Deng@amd.com>
In-Reply-To: <1585124676-14143-1-git-send-email-Emily.Deng@amd.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Monk.Liu@amd.com; 
x-originating-ip: [180.167.199.185]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: cfb962ea-fa62-4e59-993f-08d7d0aa07c0
x-ms-traffictypediagnostic: DM5PR12MB1323:|DM5PR12MB1323:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM5PR12MB1323AFA7C8D17DFEAE10654E84CE0@DM5PR12MB1323.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:546;
x-forefront-prvs: 0353563E2B
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(4636009)(136003)(396003)(39860400002)(346002)(376002)(366004)(76116006)(6506007)(186003)(52536014)(9686003)(71200400001)(478600001)(4326008)(26005)(5660300002)(55016002)(66476007)(33656002)(86362001)(966005)(66556008)(53546011)(45080400002)(81166006)(2906002)(8936002)(8676002)(66946007)(66446008)(110136005)(7696005)(316002)(81156014)(64756008)(17423001);
 DIR:OUT; SFP:1101; SCL:1; SRVR:DM5PR12MB1323;
 H:DM5PR12MB1708.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; 
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: a5XduZ+orL6ZF8bwNFq+NK+n1hOhqklvV+juB+KWDSfvO3aipXZmFbTjQiGYmvFapEnpcKkp5n095SGM5l3QmndbhiW248teaAQWf6Torv7McLYNIlsap4Tr7r0UWaPwH5JwdPexrqG0eS2mjICtmeyF5UwF7Hp4n/Jme6m/wz8jugA5LX6H/wnuAXYAcTRjBtszdlSvw6WiVZTT4x2ObKYuvvgDZwpIK3Fnhq/+bYQ75OTTJlpnIJONnHd/HWPa6vTylyh9u2r/EEVMMHjXz3qDnjxwBUTvMTMytL1J81Ng3dK2TtRoAWoueVLT04hEV47GbT/xKVsd7EtjeyWYKNmRVL/5/tR2T4uelwYik31kvF9KJILMpUymreEcvRs5j09StT8Yrpz0vh8lWqPDzhGRQz497TGGsPbHdcycHJbmQFki2bs9AL6Km4F4QILJQk5v1Vjn/x3wg8DNQdXQGsCOBYX++lrf+iCrFAWSO89GCWsavXe6+bHFimq/stXElqAeKKtSmzUmoWGH1J2CDw==
x-ms-exchange-antispam-messagedata: E0JE17Jn/6gJbKzNOgXljvYfy1ybkJmPaiK94ERvzZ2f0hIgWzeEb6g7LzdidHF4k9klniJOxWsi9EcHpNPI07CYNchNcglNeBdBIjrVqmrPeZ9QQjZhCXc1rRO9hH+WBvTsPFxJfI7ZB/WUdna0UQ==
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cfb962ea-fa62-4e59-993f-08d7d0aa07c0
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Mar 2020 10:48:18.7805 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 4O6LM/KxvFtC8zySaFAvMZ5ptHFDgZtsNwPI0FdUudUKGQpwmnba/IcdWCPqBEL8
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
Sent: Wednesday, March 25, 2020 4:25 PM
To: amd-gfx@lists.freedesktop.org
Cc: Deng, Emily <Emily.Deng@amd.com>
Subject: [PATCH 1/4] SWDEV-227605 - Virtual display need to support multiple ctrcs

The crtc num is determined by virtual_display parameter.

Signed-off-by: Emily Deng <Emily.Deng@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c
index 43a1ee3..d791bfe 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c
@@ -38,7 +38,8 @@ bool amdgpu_virt_mmio_blocked(struct amdgpu_device *adev)  void amdgpu_virt_init_setting(struct amdgpu_device *adev)  {
 	/* enable virtual display */
-	adev->mode_info.num_crtc = 1;
+	if (adev->mode_info.num_crtc == 0)
+		adev->mode_info.num_crtc = 1;
 	adev->enable_virtual_display = true;
 	adev->ddev->driver->driver_features &= ~DRIVER_ATOMIC;
 	adev->cg_flags = 0;
--
2.7.4

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Flists.freedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;data=02%7C01%7Cmonk.liu%40amd.com%7C165c5b40d3c74410156a08d7d0960180%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637207215014705193&amp;sdata=XtuRzfNYovWNa%2FuJrTWVlLsyohUctdk4hDrAE5a94E4%3D&amp;reserved=0
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
