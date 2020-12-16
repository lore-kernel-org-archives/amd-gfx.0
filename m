Return-Path: <SRS0=VOM3=FU=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53E04C4361B
	for <amd-gfx@archiver.kernel.org>; Wed, 16 Dec 2020 03:46:42 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 07D7A23137
	for <amd-gfx@archiver.kernel.org>; Wed, 16 Dec 2020 03:46:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 07D7A23137
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 70B878968D;
	Wed, 16 Dec 2020 03:46:41 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2065.outbound.protection.outlook.com [40.107.223.65])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 21E4B8968D
 for <amd-gfx@lists.freedesktop.org>; Wed, 16 Dec 2020 03:46:40 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FIlijM/IS7deVyvWfhZudFyujB0EmIjd/Pn1rgwwTSAl2n0o2Q9SQNfGslL/ml1bS32SA9NXaD3+zU9XFl3iJcehCQTtHd6apXrCVi8tmVaKli+sBIi55u9MxKJ25RzgZr+AbPDGDsL7sp1uWjpVPzPEBmEKyO3kgz4NU6xSLWMjszP9w6DF78ogFA4qXjUTtulOTqHnXQi7oKWYWX1nVU1lRrP+z/K9DzLh/wEePCx9V40EKQY4FXzKhQns2/AqPiIAgUohgHyvBzEtUClM2mRYnKxU1Rk2HWyjYUb5JZVTs83dCYYvOsybKs8df+wvt4WAjc6zVnq2jk8nF/NzfQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=S+SwmlddFelk2Qt1ia1nwQU7FXoRQ8VuXpUqHCR14uc=;
 b=E74lhjARNIr4xbAxnNjju6yX/zq7DmQgsr5iowfx/us2is4Le9xufTIHR2PvUQd/1mZ6rU+Bch1vc8JcW+HvJG3wPgsBzwLFtoPx7t3Qepej1SApdd+dLZSuEui9OmO6evvKLGm0uD3DMq3hVVFZ1EP1/g5PNop91quf1DettZv0Glu5kRgv9wRLJkqekRI4Me5DAeVodEQYV5oWXQgDkqnKXBZahdlWo826oo0Uo6o7IFiuRYbUhcRdbGDKvY14rxGZFYXL4msfEpnJ1Sp0plD0knNMkusQTttAHBBxmyOZyR/kgF1yJrX4a4VREliSXRsuQkbU53AoKIKyuFf0fw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=S+SwmlddFelk2Qt1ia1nwQU7FXoRQ8VuXpUqHCR14uc=;
 b=Uv3qasuqKhal8Q6kHrm++6lrUV086YbXPR26I5RB4b6AdEXQdvqc4OwzamEIph9+XNtCZXUdd/34snMT/ZzcBQ2fK4zy/6bkNpBQJ22RafVCZ7ZMJZwrIzwB8QatTuZZEDwN7MsU7KDm7Mw4H0FcEAQxOfBMhqr+CVveRdyEWHg=
Received: from BY5PR12MB4885.namprd12.prod.outlook.com (2603:10b6:a03:1de::20)
 by BYAPR12MB2917.namprd12.prod.outlook.com (2603:10b6:a03:130::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3654.12; Wed, 16 Dec
 2020 03:46:38 +0000
Received: from BY5PR12MB4885.namprd12.prod.outlook.com
 ([fe80::f40a:39e1:ad71:3e6a]) by BY5PR12MB4885.namprd12.prod.outlook.com
 ([fe80::f40a:39e1:ad71:3e6a%7]) with mapi id 15.20.3632.032; Wed, 16 Dec 2020
 03:46:38 +0000
From: "Chen, Jiansong (Simon)" <Jiansong.Chen@amd.com>
To: "Zhou1, Tao" <Tao.Zhou1@amd.com>, "Gui, Jack" <Jack.Gui@amd.com>, "Zhang, 
 Hawking" <Hawking.Zhang@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amdgpu: print mmhub client name for dimgrey_cavefish
Thread-Topic: [PATCH] drm/amdgpu: print mmhub client name for dimgrey_cavefish
Thread-Index: AQHW010zBQi1ArMnq0aEu86v1jYx8an5FTfw
Date: Wed, 16 Dec 2020 03:46:38 +0000
Message-ID: <BY5PR12MB48853B11720B6143AA30A28AEAC50@BY5PR12MB4885.namprd12.prod.outlook.com>
References: <20201216034008.28027-1-tao.zhou1@amd.com>
In-Reply-To: <20201216034008.28027-1-tao.zhou1@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_ActionId=ee5c3733-5421-45ed-b315-d1e1d62224a8;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_ContentBits=0;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Enabled=true;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Method=Privileged;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Name=Public_0;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_SetDate=2020-12-16T03:46:27Z;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
dlp-product: dlpe-windows
dlp-version: 11.5.0.60
dlp-reaction: no-action
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [180.167.199.189]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 17877b66-fb0c-4933-18d7-08d8a1753167
x-ms-traffictypediagnostic: BYAPR12MB2917:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BYAPR12MB2917B7267609C8A551842EFEEAC50@BYAPR12MB2917.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:849;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: vBss7u2A//Lv82XPbLXKevmdzS3c06IwJrC0UbJK39aQbrdQ59OmpvSqMIL6wf/oPo15N95MFSel/YoINl0P+Jnhnm8MWoi0yYCd87VNfXIrwOF859fCag5AaBninSqp9EBOTq7tSMBuWYk+9CWc7xiaNtR3XVwdKHRO+xzVrQyB3SsS464lc7yBIjq9Si4udA799Why5wfYVesp2CAeKFDyzh9Ml8AhXVYHsNakALvTOmkDmWtFyBcakT7jJ1rZ/cjL7/3qZxT50O/fd7HkkUr/E3oK0fBKIx201BswCiVeruIn5fCH7AfB9NxCdFjwXXb2LrIhLqcolc6joouT0Q==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BY5PR12MB4885.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(136003)(346002)(39850400004)(396003)(376002)(8676002)(64756008)(9686003)(66556008)(53546011)(66446008)(76116006)(52536014)(66476007)(7696005)(66946007)(4744005)(8936002)(110136005)(316002)(478600001)(26005)(33656002)(6506007)(55016002)(186003)(2906002)(5660300002)(86362001)(83380400001)(71200400001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?ZB75b9KjWZVPs8Wur6v3FZTwBGVQhpkZ0eg4Oe7rRta40BHff1MrvWCdCraZ?=
 =?us-ascii?Q?R3Sx8N2+BxPckMYiAiUprB8Au8xOnsYuQAmQQJPpKSDDT7MzCybReqQqTDhA?=
 =?us-ascii?Q?AkFuPzrH0ow6z/ahZ4BXNOZJIzC2epVLeeRpM7DdjzzkZ8lFypQB5ns8WQBn?=
 =?us-ascii?Q?v2z51ndAEDTajpXENV/LrAb+bb0TNddBYeCzLcXImRAvOLiM8nnjhfS2tbnQ?=
 =?us-ascii?Q?KxuiL18+QtdMJzwG68ZDHZWgd9iGqvOwCMRWuK3tjyCbQguLoxx6kvWKZXpl?=
 =?us-ascii?Q?ELfvp9HJXsGJc5H+JfENViR8B5TA0FQ8vaz/ucQOJOO3IQF+4Jjz7eIUSJjF?=
 =?us-ascii?Q?sbYtfyZMAwVuZzbsP4PR617OdWGK6YovzIqFM5GzU+JRANZuKgYr1/3WleKZ?=
 =?us-ascii?Q?ZqucojrqTxzPIn8E3+K/3clNhNOmmOqO7Mw450A3fqQyzXr13gTQHW4vh6XO?=
 =?us-ascii?Q?8+pZIDeKTiF6VnSYo17HPB71KuCamYNs9wpADuJEE1MgCch8g+gLA12lpawN?=
 =?us-ascii?Q?Xw33hdY2NhesN7LXxahzjbDPuOTNIPOutMpMr2TgpP6AiWsjVt0TkkYBn0t4?=
 =?us-ascii?Q?2xNeLIeAMr61mbEJe5Q1xBkfdyOoYGzjCdsme6/BvUfAi8KXhl5Jn7fw32kX?=
 =?us-ascii?Q?hx1TDGYKqmB+h6CBSO8x5l0Da2PElljj8QxY016SZqP/9O2//QmAlAxd7wlK?=
 =?us-ascii?Q?P9ro7MMLyHrv+aJVTdCmVePHChIAuq9pyjW2t3poSiUjE9P/vTO/8DQevKBE?=
 =?us-ascii?Q?efP8x57N7IsUDIBU9UVJ/nt22tH+zAEQMxSkE9mRPU3lgZKXG7tQik0WyaUv?=
 =?us-ascii?Q?Qs7acEYxFK4s1M7FUDLa4UsyHP0X7gRSCgb4NkpIZd0+ysYelk9tU+p+DcJP?=
 =?us-ascii?Q?sHYXczQQUM2yzsbFUEb5iNUTDnjsEiB8XG2OZi4KeNgVOpI1fn0Ga0g8puLB?=
 =?us-ascii?Q?QVIBXhrle+kfE0tzg6yInxO0UgGR8r580kNcioejTD0=3D?=
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BY5PR12MB4885.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 17877b66-fb0c-4933-18d7-08d8a1753167
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Dec 2020 03:46:38.3636 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: mqbV30hj6EWN65HsV4xg/sQKo7XpZDG8xH/lb830ftU3hY7jOovp0J5KkA7/nwIZpVqOc0yutf+70UFjAjiSeg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB2917
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

[AMD Public Use]

Reviewed-by: Jiansong Chen <Jiansong.Chen@amd.com>

-----Original Message-----
From: Zhou1, Tao <Tao.Zhou1@amd.com>
Sent: Wednesday, December 16, 2020 11:40 AM
To: Chen, Jiansong (Simon) <Jiansong.Chen@amd.com>; Gui, Jack <Jack.Gui@amd.com>; Zhang, Hawking <Hawking.Zhang@amd.com>; amd-gfx@lists.freedesktop.org
Cc: Zhou1, Tao <Tao.Zhou1@amd.com>
Subject: [PATCH] drm/amdgpu: print mmhub client name for dimgrey_cavefish

This makes it easier to debug what block is causing the fault, same as sienna_cichlid.

Signed-off-by: Tao Zhou <tao.zhou1@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/mmhub_v2_0.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/mmhub_v2_0.c b/drivers/gpu/drm/amd/amdgpu/mmhub_v2_0.c
index 092ff2c43658..f107385faba2 100644
--- a/drivers/gpu/drm/amd/amdgpu/mmhub_v2_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/mmhub_v2_0.c
@@ -136,6 +136,7 @@ mmhub_v2_0_print_l2_protection_fault_status(struct amdgpu_device *adev,
 break;
 case CHIP_SIENNA_CICHLID:
 case CHIP_NAVY_FLOUNDER:
+case CHIP_DIMGREY_CAVEFISH:
 mmhub_cid = mmhub_client_ids_sienna_cichlid[cid][rw];
 break;
 default:
--
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
