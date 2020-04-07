Return-Path: <SRS0=Z8oe=5X=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D168EC2BA16
	for <amd-gfx@archiver.kernel.org>; Tue,  7 Apr 2020 08:16:02 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A10E4206F5
	for <amd-gfx@archiver.kernel.org>; Tue,  7 Apr 2020 08:16:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="IFFWxHBo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A10E4206F5
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4E3986E5CF;
	Tue,  7 Apr 2020 08:16:02 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2067.outbound.protection.outlook.com [40.107.223.67])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0615989FA9
 for <amd-gfx@lists.freedesktop.org>; Tue,  7 Apr 2020 08:16:00 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FG1U7kHTANjeDFu++3xNU8HFwC793VImcLQLKR4A4w5yK2i5sXLWvgtGrJyMCVUuAsLefI6uDncyx5pjcNBovuFlu5yywy1+K4DP+rEw0pzcZLzCoYbbO5ptflZ7JbDxqFx+q+Jk2sA0EuSW0RNG9BIiUKwPDL+A5rZlpbQ7c+YO9J3X1o/Kjamhf8rUzlEPTLyr5FhJ9lZCuNod1mQ86+U4k5f7ht8tiFe4C0w9zxM7s4q3hn8QnxdHHwlNQsxl2f+2PAwSp9pmk7Xu2ZVYsBVL1rLu41wgC4s4TKuuhDFqq2M2whoqprRrLwSvCrSpjY+/2rqrBR+xMxlO7+cZ8A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DSgh0us8Jzde4DfH3bQh3DLNLamUNdx4oSzpXP/tkSQ=;
 b=KH1TbRT8wzF1CuzCLVZklasDv8GixNOPDQ/hFogBKCNTvPN/xU/exGmasrRbt70cO4/SePk7XKJdsbGB5UJWYltK92IgqpwoZWWy76qPpEkQKL+HQnChlfdrMyr2lN7eIp18A7o+yK3hNuQI3VB8x6L4I8hbelgr9whMWmjI7qADlTIRT2KJmLPXL0HDuuut/dElcPIQ8/RzQQV5EimnBUjX8RwsPrwD+S9RmWSb9sbC/HEq4sDoyogZlkq8RuKRyF0C3Fdppdygty7rDRyJq4MXmI40eQOgRmQBUNghX1/nUsdbWxTr6lxZPePIW4Av8gu0CflQVag/dDt7RnFw8A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DSgh0us8Jzde4DfH3bQh3DLNLamUNdx4oSzpXP/tkSQ=;
 b=IFFWxHBohOq81W/2eAzc4KMRtD6XNsM4+6RPwn5nIulxtb6iVC/K9YwdgHAJWDi8xpgbTvdVFoyIfy9wpAwb7mAuEYt+voJwdck7uktQTqffN351aQfhjMTuN7VibaUSY5kaOgozMAI94Sho4L+IinePf5Vt8EtPpU0AVI5mic4=
Received: from DM5PR12MB1708.namprd12.prod.outlook.com (2603:10b6:3:10e::22)
 by DM5PR12MB1258.namprd12.prod.outlook.com (2603:10b6:3:79::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2878.15; Tue, 7 Apr
 2020 08:15:59 +0000
Received: from DM5PR12MB1708.namprd12.prod.outlook.com
 ([fe80::a8d8:ad45:3232:f8bd]) by DM5PR12MB1708.namprd12.prod.outlook.com
 ([fe80::a8d8:ad45:3232:f8bd%8]) with mapi id 15.20.2878.018; Tue, 7 Apr 2020
 08:15:59 +0000
From: "Liu, Monk" <Monk.Liu@amd.com>
To: "Zhang, Jack (Jian)" <Jack.Zhang1@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH 2/2] drm/amdgpu/sriov add amdgpu_amdkfd_pre_reset in gpu
 reset
Thread-Topic: [PATCH 2/2] drm/amdgpu/sriov add amdgpu_amdkfd_pre_reset in gpu
 reset
Thread-Index: AQHWDLSN3Zh8KlqJ4kWnx7jp7t8MUahtUBeg
Date: Tue, 7 Apr 2020 08:15:59 +0000
Message-ID: <DM5PR12MB17088DF13FB2D3770C00342484C30@DM5PR12MB1708.namprd12.prod.outlook.com>
References: <1586247246-823-1-git-send-email-Jack.Zhang1@amd.com>
In-Reply-To: <1586247246-823-1-git-send-email-Jack.Zhang1@amd.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Monk.Liu@amd.com; 
x-originating-ip: [180.167.199.185]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: b30a6c9a-5d4b-4229-9e5d-08d7dacbe7aa
x-ms-traffictypediagnostic: DM5PR12MB1258:|DM5PR12MB1258:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM5PR12MB125815A9546A7FB147AC6EFA84C30@DM5PR12MB1258.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:1775;
x-forefront-prvs: 036614DD9C
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM5PR12MB1708.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(10009020)(4636009)(136003)(346002)(396003)(366004)(39860400002)(376002)(53546011)(110136005)(6506007)(7696005)(81156014)(966005)(4326008)(81166006)(8936002)(8676002)(316002)(86362001)(66946007)(66446008)(66556008)(55016002)(26005)(71200400001)(76116006)(66476007)(2906002)(64756008)(45080400002)(9686003)(5660300002)(33656002)(52536014)(478600001)(186003);
 DIR:OUT; SFP:1101; 
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 22oDUkspjCFSj8gKHlhSNvs0dlhu2jPOF2muKDEd+LSQcNa7jpJYZOsqib4genxeIu2XBrpZe9vs4hcDmO5h/0lWCsRTZvRQVgX6bIRJvf3mn0YTFnQR1PmgcDDenL952UC6jAtAkTaqXZ9Sm6oV01N4VxQ4mbhNNfYl/wm9l6y/YyUDaZgxpcJsWcHPAErsBcmBTxB689+3ekbPcqZIW1yrschu+Abfb+QrbFkrquMp26Zdcbbr9gLzHkUHByeDMU8/9XBGUh6rb2NU/hCZ6o7ZJImps8U5P3DHcH19QGwCadx4CUAYNgcpAuZJ2nCuXGuT4JFRFfoBpezfGWyoeyfi7u0w8dPJqzZ9W23wXUx/tUmo6uEED/6spO+ZxglWL/qvoFaWqR6IaCWUhRhDkSCbUdqYWoWi1HE/Wp8hGzejcAuPFCWGXhytKUHbq4glSFkDpc1kJiByv8FpHXV+7KlJjRtcPDW9QSolc7L9zK4=
x-ms-exchange-antispam-messagedata: i27n+q+885MepMS6cTPLxm4nGnzis0Q1pvojaPYrjiUElnK8+sXxVWPIRpJ1jOgcsYDdQtW0xE0zUi9LzDUQ21giSVyHHT9/fdaXiP/Zmj/GEVgGKhg66Jsut+ydsl0VK9Iby9xrl5cFKHT5ZEEDBQ==
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b30a6c9a-5d4b-4229-9e5d-08d7dacbe7aa
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Apr 2020 08:15:59.4969 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: RibIy5fJOGcRYROjE4Ln7tdxEJYj30YDzQz5FkljukF+U0vkNcfCczHunxaRvKJ5
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1258
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

Series review by Monk

_____________________________________
Monk Liu|GPU Virtualization Team |AMD


-----Original Message-----
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Jack Zhang
Sent: Tuesday, April 7, 2020 4:14 PM
To: amd-gfx@lists.freedesktop.org
Cc: Zhang, Jack (Jian) <Jack.Zhang1@amd.com>
Subject: [PATCH 2/2] drm/amdgpu/sriov add amdgpu_amdkfd_pre_reset in gpu reset

[PATCH 2/2]
kfd_pre_reset will free mem_objs allocated by kfd_gtt_sa_allocate

Without this change, sriov tdr code path will never free those allocated memories and get memory leak.

Signed-off-by: Jack Zhang <Jack.Zhang1@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index d94eff9..2e1f955 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -3852,6 +3852,8 @@ static int amdgpu_device_reset_sriov(struct amdgpu_device *adev,
 	if (r)
 		return r;
 
+	amdgpu_amdkfd_pre_reset(adev);
+
 	/* Resume IP prior to SMC */
 	r = amdgpu_device_ip_reinit_early_sriov(adev);
 	if (r)
--
2.7.4

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Flists.freedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;data=02%7C01%7Cmonk.liu%40amd.com%7Cebe990b99a9440d51b6808d7dacba8ec%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637218440651934136&amp;sdata=DIMSblS%2FoflA8J2NlM1Oq%2FTyIpXMYwZHQgdO%2FQ8nIn0%3D&amp;reserved=0
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
