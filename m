Return-Path: <SRS0=ZYFY=5S=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9551C10F26
	for <amd-gfx@archiver.kernel.org>; Thu,  2 Apr 2020 07:22:34 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AEEFF2080C
	for <amd-gfx@archiver.kernel.org>; Thu,  2 Apr 2020 07:22:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="qhs6WNvT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AEEFF2080C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 753F76E9DE;
	Thu,  2 Apr 2020 07:22:34 +0000 (UTC)
Received: from NAM02-BL2-obe.outbound.protection.outlook.com
 (mail-bl2nam02on060e.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:fe46::60e])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DB0176E9DE
 for <amd-gfx@lists.freedesktop.org>; Thu,  2 Apr 2020 07:22:32 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FYqrUEJriYEfSwtZCkUZbPX6Suh4suI1zVGmtpLxV4PVwFv8owV6EjlU3lB6Vq65qNYcqBmL2r999EBRoqfgzLGiCObI6y5Z0JhqJsH3DhbSzKPWT57wABxoWRtk2LID8Vo5qQ4L1a6zQuGMOgrK2WnoW115ga1g41mC2x/EqMdnBxpHcrHdR6HHLqwILbVnR5deFFRLSnOD/awJgyo7F6eJHcN02V7kIonknVYvhCyiAFcuh/SU0kqg0JHHmnlGMMng1Yqruytisi3En1Agc+I6UtQ96gQWtbz/vGXg948WPP2lXlGtgBchLwT2Xj0VBByulvXFV0i7uu7bVe5Wzw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QF9OT/Wnx0aSIlJewjA1CB98PkNPiVc8mRRqrhrmwMQ=;
 b=KiTy9GfAUrxrzxSuxMAf2ZtP9M8ZGSGuCxunzEpmVJjJMMsVnvZQv6WgG2JSpMgQzJqSHdd9Xc4H2KqHEzulm32wma40z8jzpa15qHSSU5zob0vheWo7GJ8NvPuFR3tN79j/MwTBUUKFTkWeppMjlxb2tx/iQBgkQSSaXLFkr5UlZUxDglm0x09uxgILIG3O0MzKZ2kx4ZYg5WKVxTm1H+IjZVdWIw4kfgEi/VfetPEL5k/qP/lgLUqq7eh5RLntDsdZJ5+IbPcTzbN4Hj0G72baO6Z53pWcDOgn5z8zSH94Z8T6AstQFfwePXcRKrbQj38HvcHkM1G3gokkamyK6g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QF9OT/Wnx0aSIlJewjA1CB98PkNPiVc8mRRqrhrmwMQ=;
 b=qhs6WNvTD8E3Jp3B3Y2CP2B9I5rT9XIPHVe3tDbVmjViSjjFtagRnUCRalNNnbBhzuYwz97DAleB3579nagG64Gi0ea568DLCCa5hGCyNVZb13iUGvGAdrwZxSDeCGJRzKk2YjxXiZ2CEft86055C/nIqcSBzg3P8wj0x0n44kg=
Received: from DM5PR1201MB0204.namprd12.prod.outlook.com (2603:10b6:4:51::10)
 by DM5PR1201MB0266.namprd12.prod.outlook.com (2603:10b6:4:57::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2856.19; Thu, 2 Apr
 2020 07:22:31 +0000
Received: from DM5PR1201MB0204.namprd12.prod.outlook.com
 ([fe80::dc9b:b24a:da40:19f6]) by DM5PR1201MB0204.namprd12.prod.outlook.com
 ([fe80::dc9b:b24a:da40:19f6%5]) with mapi id 15.20.2856.019; Thu, 2 Apr 2020
 07:22:31 +0000
From: "Zhang, Jack (Jian)" <Jack.Zhang1@amd.com>
To: "Kuehling, Felix" <Felix.Kuehling@amd.com>, "Min, Frank"
 <Frank.Min@amd.com>, "Liu, Monk" <Monk.Liu@amd.com>, "Deng, Emily"
 <Emily.Deng@amd.com>, "Tao, Yintian" <Yintian.Tao@amd.com>, "Jian, Jane"
 <Jane.Jian@amd.com>, "Zhao, Jiange" <Jiange.Zhao@amd.com>
Subject: RE: [PATCH] drm/amdgpu/sriov add amdgpu_amdkfd_pre_reset in gpu reset
Thread-Topic: [PATCH] drm/amdgpu/sriov add amdgpu_amdkfd_pre_reset in gpu reset
Thread-Index: AQHWCL8uh4cpltSLTECyMztLy6BapqhlbOtg
Date: Thu, 2 Apr 2020 07:22:31 +0000
Message-ID: <DM5PR1201MB0204F6FF3CB39EF79229C424BBC60@DM5PR1201MB0204.namprd12.prod.outlook.com>
References: <1585812006-3368-1-git-send-email-Jack.Zhang1@amd.com>
In-Reply-To: <1585812006-3368-1-git-send-email-Jack.Zhang1@amd.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Jack.Zhang1@amd.com; 
x-originating-ip: [180.167.199.189]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 6e26360e-e352-4976-5b59-08d7d6d69b70
x-ms-traffictypediagnostic: DM5PR1201MB0266:|DM5PR1201MB0266:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM5PR1201MB026611B4FA3FD682F3EF0954BBC60@DM5PR1201MB0266.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:1443;
x-forefront-prvs: 0361212EA8
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM5PR1201MB0204.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(10009020)(4636009)(136003)(396003)(376002)(366004)(39860400002)(346002)(6636002)(316002)(110136005)(478600001)(26005)(86362001)(53546011)(6506007)(7696005)(186003)(4744005)(5660300002)(52536014)(8936002)(81156014)(81166006)(66476007)(71200400001)(8676002)(33656002)(9686003)(55016002)(66446008)(66946007)(76116006)(2906002)(64756008)(4326008)(66556008)(921003)(1121003);
 DIR:OUT; SFP:1101; 
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: /0mWQmeCavIbnzSwjKQWRwU4x2nNpN6QEwqfp0WL6N4DfgewGmKbsjfM2lPd+ITtlNs3j2Cl7T/uOs7KkFTUjzdr2kdKgQXsWvypQ61q7ICh67Lyib0uiGbS+LA78mbtGMJn5dH5SVrk6IKkTRK0/I7WP1YhSGB9vxT548mnyarhSLAvf/45vVQo7/yICYpNQiheOpm4os9kVA7ppBPTX+069t9Wc5mt7ULtSWX6bVrt31POyfvmy9s1bez6VbJ4AKn9qmIbtPb3LkZxJ5HGe0YtuYihu6p6Xv4yd9MbIJJPzm5C6MALDLqPWqen0iwZqAEBxtISW3Bk45QA5/Nco6ShA0T/aab7U0iK0folvQN3vwKDbTCgfsZoPvF37mLIQISeZZhC8eoZtV2xsP1KBMEvtXzf+WEzqmKHVDN0vTjV75NwHSZwajFgo7s7ZICJtMiv8cHpcgRseMZW+kue+gj5GBue+erLsIj2l/+10+BXKM9dNoDTIM8gmXmRXydW
x-ms-exchange-antispam-messagedata: 4gFMbOag8m4Bm7jW4pxOzHaqdlRyouKH8PrZvPcueg4nZ+sHUCBDofGmaT37TPrzpwZvDpdcdQPa9GYwht6Jzob/7W1VBB+IIGo7x7d8NF2s5zTl196OKkmOfr2ZSqCYHoN2qyAIusrlapOV0Be+Cw==
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6e26360e-e352-4976-5b59-08d7d6d69b70
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Apr 2020 07:22:31.4392 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: FmM4WPiY9e4ClwKKNp9aybavKrNroER+lIIjHoAdjSvr4jjYrzzAfaPXQMWqYjDQ
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR1201MB0266
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
Cc: "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>


-----Original Message-----
From: Jack Zhang <Jack.Zhang1@amd.com> 
Sent: Thursday, April 2, 2020 3:20 PM
To: amd-gfx@lists.freedesktop.org
Cc: Zhang, Jack (Jian) <Jack.Zhang1@amd.com>
Subject: [PATCH] drm/amdgpu/sriov add amdgpu_amdkfd_pre_reset in gpu reset

kfd_pre_reset will free mem_objs allocated by kfd_gtt_sa_allocate

Without this change, sriov tdr code path will never free those allocated memories and get memory leak.

Signed-off-by: Jack Zhang <Jack.Zhang1@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index 8faaa17..832daf7 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -3847,6 +3847,8 @@ static int amdgpu_device_reset_sriov(struct amdgpu_device *adev,  {
 	int r;
 
+	amdgpu_amdkfd_pre_reset(adev);
+
 	if (from_hypervisor)
 		r = amdgpu_virt_request_full_gpu(adev, true);
 	else
--
2.7.4

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
