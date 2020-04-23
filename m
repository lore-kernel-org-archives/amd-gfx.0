Return-Path: <SRS0=mx+S=6H=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6B45C2BA19
	for <amd-gfx@archiver.kernel.org>; Thu, 23 Apr 2020 09:01:35 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 63B3A20781
	for <amd-gfx@archiver.kernel.org>; Thu, 23 Apr 2020 09:01:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="guWXjy64"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 63B3A20781
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 163AA89CE3;
	Thu, 23 Apr 2020 09:01:35 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2041.outbound.protection.outlook.com [40.107.94.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E903B89CE3
 for <amd-gfx@lists.freedesktop.org>; Thu, 23 Apr 2020 09:01:33 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OtmlYRCGuSXNznc0R1CgQQUBeUGx/QXqWma5dgeUi6+bElX1jxKWnCic5gpBN0IGW26Vu7OZlKltJ5JZnOktryoY9K5gqnhxvAHMh33+plQDnWTy4EbfWVYSaqMWLa44OXdU2MsIfvQWkukwdtrSuMne2RIOIiC0Ogsn6uGgR7GzlkRcdxkcypYt0BmYQbjXvC3Z1TpY5eHQD9NidCINKcR4G1Cls1yYE1cIGeILpf3CO3Ft4QliOM2kTQiKcDyI9hfO3EUEZnJ7uaGsuUFVcCvDz3Oqs1YS1KFTlih/gu8xSiM6kyG60yAYZaaO/QSLM/A4jzzlynu/QVxwbUoo0Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BaYP8i3a2FL08LzDNZcLmoU3YsEdWlzEzAV+AF70umw=;
 b=NaKXqLdhvXeyUvPgoEE66zaFs8aawVEU48J7849mawj+lR/8ihPsZlrBHfmkWbqW4Da/WFbD0uKt9zqi5iL6FifY90WQKNtOP5G2u5AgKRFk20WXy0Byw9AFMma7YflEzUWY6X1Jp2CWeLGdIbNQiKSykcFUT8ext746UHq3qinsbWehP4z03lId4J1rgNfEk80zHSrDOKKTY04GgG+ui7LnOpLZIAaCh4M30xTbJ08cgxsKxWDWOnSngh8tLzLCQ5HFuFrFIc3dnToGuSIjh2eF5GShquhsA6Ew+r3K1007f3thq8+A2h6WnittQEaGjvV1ObaBUXwwsvkMoz7PjQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BaYP8i3a2FL08LzDNZcLmoU3YsEdWlzEzAV+AF70umw=;
 b=guWXjy642I5SXCyarKnE61HM4rNWIBoqC4PgLLFR57CBXamZB+xD7rgRAx24wq9NFAukauDKaf2qCAv61DkTARFx4ZuQg1V0MaVBw1CP4D/ur8FKxTBOTiI6zUtwQMHrg6oC+encDgfRsrgFneliSyaLzfBohhh/nmf0mn+wStc=
Received: from DM5PR12MB1708.namprd12.prod.outlook.com (2603:10b6:3:10e::22)
 by DM5PR12MB1436.namprd12.prod.outlook.com (2603:10b6:3:78::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2921.29; Thu, 23 Apr 2020 09:01:31 +0000
Received: from DM5PR12MB1708.namprd12.prod.outlook.com
 ([fe80::a8d8:ad45:3232:f8bd]) by DM5PR12MB1708.namprd12.prod.outlook.com
 ([fe80::a8d8:ad45:3232:f8bd%8]) with mapi id 15.20.2921.030; Thu, 23 Apr 2020
 09:01:31 +0000
From: "Liu, Monk" <Monk.Liu@amd.com>
To: "Liu, Monk" <Monk.Liu@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH 2/2] drm/amdgpu: limit smu_set_mp1_state to pp_one_vf or
 bare-metal
Thread-Topic: [PATCH 2/2] drm/amdgpu: limit smu_set_mp1_state to pp_one_vf or
 bare-metal
Thread-Index: AQHWGUcE10JiHm9dR0SW16PVAgqgU6iGaPzg
Date: Thu, 23 Apr 2020 09:01:31 +0000
Message-ID: <DM5PR12MB1708D418B278EC0F0FAEA0FD84D30@DM5PR12MB1708.namprd12.prod.outlook.com>
References: <1587629567-32108-1-git-send-email-Monk.Liu@amd.com>
 <1587629567-32108-2-git-send-email-Monk.Liu@amd.com>
In-Reply-To: <1587629567-32108-2-git-send-email-Monk.Liu@amd.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Monk.Liu@amd.com; 
x-originating-ip: [58.247.170.242]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 9629fe4a-cec0-4b0c-0968-08d7e764eab9
x-ms-traffictypediagnostic: DM5PR12MB1436:|DM5PR12MB1436:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM5PR12MB1436672B398F0768DFECF6C884D30@DM5PR12MB1436.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:3513;
x-forefront-prvs: 03827AF76E
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM5PR12MB1708.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(10009020)(4636009)(396003)(376002)(346002)(39860400002)(136003)(366004)(478600001)(5660300002)(52536014)(6506007)(53546011)(186003)(7696005)(26005)(66556008)(71200400001)(66946007)(316002)(76116006)(66476007)(66446008)(64756008)(110136005)(9686003)(86362001)(8936002)(55016002)(8676002)(81156014)(33656002)(2906002);
 DIR:OUT; SFP:1101; 
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: VFOd0ire4/fPUNm5xd94NtEf7Bdob+6aw1RGOMQL/zuInJ46UiKxV4dy9VykwCBFOPgwGC2RVnzvFKhJzI2WitzviAVjej9aOYFaIA/l8TN818GiuP+Vzex74KGN5p+8L4Y2cEqT7iMpSfLwxCp0py8abeAJelrB2BKxw5kgaJawJc2+oN5SyvNom/RtSeLmgUcPZVEZsWLMAf2UqsSuq6HFNexPTj3fjkBoKbhwQ6mxNucci6fHGmVTYVZuj4XNnUIqiYD67SuyHWCYGtxLCHwgEHpyq42MNxyTbyh3+Ck5zSm/dZIBY5j/jgqshkL3NfMGexCPb6PXGORtY0+fF/1ywt81tcJyRSq79s66ZqrFgsCyJr7CjcZCSCGi4Fdx40DuatUQqezJG+uMqtoqyK8Vg7ZRdzzWqB54EkSHU3xpUffIUwbwNRxyNy8+e1/m
x-ms-exchange-antispam-messagedata: bOSpxMtt+xm6V/7iLhVyR8S8uPoGLd0Rbghrk1S6k+y+sMeHoPNKkizSaPi/R7Pooo5HNTPyrdJyZQAJ5yKi4PUCWo1Us7VfnwYmr00J0hZDcJ7XIeaNoSMihcURx6PPQV0cFwksiWjJaZOEM2SAag==
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9629fe4a-cec0-4b0c-0968-08d7e764eab9
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Apr 2020 09:01:31.6285 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 433zK+eoUPlrHpGUVbnlvTB+Tt1HNqvrq4xOUhjoxB/jCMrLPK5a/Jc7xePQZxM3
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1436
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

Drop this one

_____________________________________
Monk Liu|GPU Virtualization Team |AMD


-----Original Message-----
From: Monk Liu <Monk.Liu@amd.com> 
Sent: Thursday, April 23, 2020 4:13 PM
To: amd-gfx@lists.freedesktop.org
Cc: Liu, Monk <Monk.Liu@amd.com>
Subject: [PATCH 2/2] drm/amdgpu: limit smu_set_mp1_state to pp_one_vf or bare-metal

Signed-off-by: Monk Liu <Monk.Liu@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index 3d601d5..810141f 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -2465,7 +2465,7 @@ static int amdgpu_device_ip_suspend_phase2(struct amdgpu_device *adev)
 		}
 		adev->ip_blocks[i].status.hw = false;
 		/* handle putting the SMC in the appropriate state */
-		if(!amdgpu_sriov_vf(adev)){
+		if (!amdgpu_sriov_vf(adev) || amdgpu_sriov_is_pp_one_vf(adev)) {
 			if (adev->ip_blocks[i].version->type == AMD_IP_BLOCK_TYPE_SMC) {
 				r = amdgpu_dpm_set_mp1_state(adev, adev->mp1_state);
 				if (r) {
-- 
2.7.4

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
