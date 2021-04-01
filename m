Return-Path: <SRS0=FlJ6=I6=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 641EBC433B4
	for <amd-gfx@archiver.kernel.org>; Thu,  1 Apr 2021 18:52:53 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2948E61003
	for <amd-gfx@archiver.kernel.org>; Thu,  1 Apr 2021 18:52:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2948E61003
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 93C2E6E037;
	Thu,  1 Apr 2021 18:52:52 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2086.outbound.protection.outlook.com [40.107.223.86])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BFB816E037
 for <amd-gfx@lists.freedesktop.org>; Thu,  1 Apr 2021 18:52:50 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Qi7d5cFASJ3tuILjlOauIlQt6crhUBRduwb2kNPvB6eV7TqaLvkPxmpvQD4qKAxSb4tFOSHBC5lr+ODGc5mVxOt6ZO/5KWcA/J2blRpO0f6A/vmwaw6NpgYBjGjnXdh2eRKwJu9waiPqnhiXc4zOIQ8OPLaWkVq0+WT0/FKMDr3bWAgjms/kqE+SaGiFj979ym6dqZcB4gHUqzyS50oP/txfWoXuQtWLTuzF1RqDvVXdIANwQPSjYPbHw2wACRiQS10XGXeSZmF0H3x98UglRDrXTzkIESe37ggj3waamrObQBt5aEhpKwNjf4EcE5xcHO1id5XvDCr/MbBhc+9cGw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uuJzDJmIWoVM/QgtoLRKqkjN0Y6oD/7z2r9P9flLZqs=;
 b=OnE4tUYb2KU70FD2PXsJkMR/CS5aSoYQgJSHiJNwCu7t58oQyN3uTeVGogrGcs01OpIgDagDxoO1gIxwHLODidzAYS+K5hWubt2YVcipwIuQ0Hamxxe+lgMZjmUNaDMv5gX/JLAB7DHwYdegMEzp9AeXnCO0AP3Avp1U6Tpgq3COy/u/etJ9+7fMyp3LLpdpzOVHfsqeXq46uHB9XSx0lG/7rXFWYsCtIxXrM+tJkdgtz4vFvKUBRFIvknsqYOFS3mdlrb7zFEL20ZjmPK3+xxFPoDwaHfUqDaAx3Gda3QIOvi4Tnu2EeUXtUjUMAJAnKP+ApB5TuypJnmKXNa3URg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uuJzDJmIWoVM/QgtoLRKqkjN0Y6oD/7z2r9P9flLZqs=;
 b=NHShVvR2sKRMdnSQncBud2tW4DUKZ0jAEICsT/TyMpkod3/cPAhiLQFoDmqzvU0fPsT+49Q2nVh69RkH9ENwWpR/+oz+9s3k6Afd0Vu6WMrgjfFIHf8K6h05GRavTq0ag6DmPDPx76tUhBUZ7jxsvC02Evrjg4oYI0lMqKbYs4c=
Received: from BN8PR12MB3585.namprd12.prod.outlook.com (2603:10b6:408:49::18)
 by BN6PR1201MB2531.namprd12.prod.outlook.com (2603:10b6:404:b2::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3999.28; Thu, 1 Apr
 2021 18:52:48 +0000
Received: from BN8PR12MB3585.namprd12.prod.outlook.com
 ([fe80::c8ca:4051:77b:c14e]) by BN8PR12MB3585.namprd12.prod.outlook.com
 ([fe80::c8ca:4051:77b:c14e%6]) with mapi id 15.20.3977.033; Thu, 1 Apr 2021
 18:52:48 +0000
From: "Joshi, Mukul" <Mukul.Joshi@amd.com>
To: "Lin, Amber" <Amber.Lin@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amdkfd: Avoid null pointer in SMI event
Thread-Topic: [PATCH] drm/amdkfd: Avoid null pointer in SMI event
Thread-Index: AQHXJagX9oFiUSJGPU+BgtX8BAdNDqqgBJpA
Date: Thu, 1 Apr 2021 18:52:48 +0000
Message-ID: <BN8PR12MB3585C2F898F660ED6E670A7AEE7B9@BN8PR12MB3585.namprd12.prod.outlook.com>
References: <20210330210236.23732-1-Amber.Lin@amd.com>
In-Reply-To: <20210330210236.23732-1-Amber.Lin@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Enabled=true;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SetDate=2021-04-01T18:52:39Z; 
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Method=Standard;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Name=Internal Use Only -
 Unrestricted;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ActionId=4546ba6a-988a-4056-ab7a-1588380e752a;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ContentBits=1
msip_justification: I confirm the recipients are approved for sharing this
 content
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [72.137.116.80]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 3750f28f-0cae-4812-c408-08d8f53f583e
x-ms-traffictypediagnostic: BN6PR1201MB2531:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BN6PR1201MB25314E9BDE09A7CB5BF3D563EE7B9@BN6PR1201MB2531.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:3631;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 9yYpmWzjuQbWwCif/PvyG/WAi8leKZadOY7pG1L4etGWAB3KQTmWqB43voo0jGvk2EPcdVq1uP3PamcVOAWGxi+FuSvuFps/FTT3aBYKOcTzNlRYRxCqVMjVx0N8bi49mIkyxw8385V30EUofYXQYSNMK1ukqYdTu2VOtp//JjPDfKrM+K9j1OQ14OWdCggpA55sitlz6gNTnV0j3X/2Hzbh+4oYpgh9M9WkeYpBogbBcSjyCGywQYvlVmFjTY0gIfM8NP9QLrYQ5Dk/Bh10LiILR5D8Cc376RpS+MG1i2OKxXmm+QeXmw8b9g9j/nPswOqip3ghHJcGJRsMv8D7zN8/JcLFUJhsW//zmVDZ1dz2c4bTXtbhjPjor6DCgTneLr2Yu6cAHYJ4BuSBXLumkOhyz0f4W8QGVTbpo9IvKa6JGmxVnpuk4F5HdPPLfpub2GjulNUds1TenRcvPSE1lUBCG3oPcosZYSfvEJzcEV5SDHbUV4kOxUIb0hKnUjDUn9jRb6ZSK5HR9FZtdk3rfcDEmzAXMNsFcG8ASTTX/2h3xjYkyjPdp4uUDp2iKzm+WAPo5AG1Ug8vQ56BztWkaWyXWPUAieapBB5qRKNMMd+nrauilEe5FZYMHEdc1po9OUsdL5QclZs8g0O5onPZdQ8OoBDixGRrHkLSmqr9xF8=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN8PR12MB3585.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(376002)(396003)(136003)(39860400002)(366004)(346002)(26005)(110136005)(6506007)(2906002)(5660300002)(186003)(316002)(478600001)(71200400001)(83380400001)(86362001)(38100700001)(33656002)(8676002)(66946007)(76116006)(66446008)(64756008)(66556008)(66476007)(55016002)(52536014)(9686003)(8936002)(53546011)(7696005);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?LW2yjgJAF7fgug/SL6u+KBZKx84xnPJ4KIien5H4NqUoXgsBSDkiK0l7Ifws?=
 =?us-ascii?Q?nHkT33YEORpkb6zG93nbHuAIuXd8lxsxyrrZ/FR5aONaD87TY7+nfZy4v6cY?=
 =?us-ascii?Q?kGX+aHLyahpbd0+TWQkb7P8nCPE/QQIjSgIet686KadJ2ceokaqc3KTgtwbG?=
 =?us-ascii?Q?co6IhRtO73r4lbg1NHwXIY5m4UP6oqC6XnpGboyHcdcjNJ8vE9QpwLNtyBmv?=
 =?us-ascii?Q?flBDmW/aGCOziyYk+j2uvt2S3UVbN6bSunIfByZID8sPsMr9lXaAbB3y1dbM?=
 =?us-ascii?Q?wMV+2/v/eYNrWmQKIceuSeSAC7VqVravIdMbTJlS9M6eOWR1+yKecCVSqFRo?=
 =?us-ascii?Q?lN4BH1bqc7e/cXZkdMedJf7HpBOew1o0scpXl6FuUSl7qfSa2lRIOFHPk5tl?=
 =?us-ascii?Q?6ZxcrJXpWZc5wKgho5NoXJbHAJNjwNNdQQTyFB5XjhCUZbRw2k2v+fj4mX9r?=
 =?us-ascii?Q?FbnXJ/eLB+waDg+5gxpE/DCGoIgFV7Gso1bT5A0aGHW+VIwtw3nA4wh3zrwj?=
 =?us-ascii?Q?ThNPKtbPpNDv5GvWu1EIdK53hvT+S4gnvmIlBIa5Bns0WZ2DzVIyxhIDagIH?=
 =?us-ascii?Q?5iE9fCsmDri6tbSh4qmw+Wvgf2wyOCAwNoQ/jxu803tT5J4JsLkfAlR/vkvK?=
 =?us-ascii?Q?jDoV1TvOpfIpKLFryL+b7fth1KZ54hQNwHIrD9kctDCSa8IAY2KHbOPTmRN+?=
 =?us-ascii?Q?A1BJ9QFPhp40ZCVmdZEBFN89vSmvuL4jhleRR/t9OuxP70VxEdvbkB3Fm7xb?=
 =?us-ascii?Q?GZaTcN4IUR8lLU3vLWMYsnoDio5jhtn7GD3jJ8hr2Tz4hDFrw+mlA0KlNTZi?=
 =?us-ascii?Q?oElrmsY4geLnxC+xPoc/QxiXvobpks9blnxXhgHXIOky6i0Vz7Kshnhpe7Tj?=
 =?us-ascii?Q?A4mRxazuPYmWuqI9j5ELS90tpWCuruMHyO2ibPVC9htuVKnEFuH0SAtjXaX9?=
 =?us-ascii?Q?fRuJipzuOaHOoGpOPD/fGE4jUuPy9fACtrgRqt9L/5yPH7PdfQXXbB9LPgXM?=
 =?us-ascii?Q?1/bVWBjN2Kl7LECAxs9Un8TJDRaqY7LX8jQZ7g5d4EYnfVYXUEahWTcira6s?=
 =?us-ascii?Q?wF7QZBv1LvBFBolKI/GmqsVVv+9qnqGtERx70GhhQLP7MnImZI7D79iR3tUt?=
 =?us-ascii?Q?VzWrD4ode5tgcomx2uK70IU3wo2JfOEJkoaj/zJoxfeCuSGcuAgG+Kt6PXMN?=
 =?us-ascii?Q?ufxIV1swyupJushAniUE30nut1JAJG0E3K2lQ4juXc5flG9v4lecxZ2uLLfu?=
 =?us-ascii?Q?btCijYQK+47dxXeGlzoQbyRZ7BMCypouxO2iFkigp6SbWuLK6UQvRe/MmBFx?=
 =?us-ascii?Q?DMHUSlNT8wJoarOg05ftBTsc?=
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN8PR12MB3585.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3750f28f-0cae-4812-c408-08d8f53f583e
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Apr 2021 18:52:48.4148 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: OEFNQBSR1LGL0GuHp0JTRjI/cpipEhShEiVcvHO/demQRu3Tq4J0cJrD2hZFdYU6ES+kc+0piRbD0y/GCehiWQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR1201MB2531
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

Reviewed-by: Mukul Joshi <mukul.joshi@amd.com>

Regards,
Mukul

-----Original Message-----
From: Lin, Amber <Amber.Lin@amd.com> 
Sent: Tuesday, March 30, 2021 5:03 PM
To: amd-gfx@lists.freedesktop.org
Cc: Joshi, Mukul <Mukul.Joshi@amd.com>; Lin, Amber <Amber.Lin@amd.com>
Subject: [PATCH] drm/amdkfd: Avoid null pointer in SMI event

Power Management IP is initialized/enabled before KFD init. When a thermal throttling happens before kfd_smi_init is done, calling the KFD SMI update function causes a stack dump by referring a NULL pointer ( smi_clients list). Check if kfd_init is completed before calling the function.

Signed-off-by: Amber Lin <Amber.Lin@amd.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_device.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device.c b/drivers/gpu/drm/amd/amdkfd/kfd_device.c
index 72c893fff61a..3cd46d7190b3 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_device.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_device.c
@@ -1297,7 +1297,7 @@ void kfd_dec_compute_active(struct kfd_dev *kfd)
 
 void kgd2kfd_smi_event_throttle(struct kfd_dev *kfd, uint32_t throttle_bitmask)  {
-	if (kfd)
+	if (kfd && kfd->init_complete)
 		kfd_smi_event_update_thermal_throttling(kfd, throttle_bitmask);  }
 
--
2.17.1
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
