Return-Path: <SRS0=BBBq=HF=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7223FC433E0
	for <amd-gfx@archiver.kernel.org>; Wed,  3 Feb 2021 03:47:01 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 03ABE64E08
	for <amd-gfx@archiver.kernel.org>; Wed,  3 Feb 2021 03:47:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 03ABE64E08
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 738926E2B6;
	Wed,  3 Feb 2021 03:47:00 +0000 (UTC)
Received: from NAM04-SN1-obe.outbound.protection.outlook.com
 (mail-eopbgr700051.outbound.protection.outlook.com [40.107.70.51])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E5D946E2B6
 for <amd-gfx@lists.freedesktop.org>; Wed,  3 Feb 2021 03:46:59 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HMHfCerJCLhdjN6y6q0ouWOE/oS8IpgeSicgPvhkbnMxkgb9Pb3wwyueAipXkrPg1zlO+iNwj06TGDax12WhmXPf1OWYoQOmmWU7Ozvu7CLKNa44HIKdG41PFW4hOtAIMRuISi0FxPmGqFbZGwJMguR+hrrVDgcqL+YtVBCdD6Qrm2vpYMAAAK8DRRsjvFLoZeKWJmKWZPUqrJHJplFY9CHXvBlOPuooElqQdgG69JXdaewlTbAKFlz1a98mziraK1m+4xru75dWZ+RTAjIdDM3hS76CPRpEhB7CdEwyOVKgDLvmLvgkO2abfBzY+IDhUM8wWbgxGNGs4K3HAEE9xA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kszzaiF+e466ZWDFXl2+w5Tq4f8Aa6HiBSLRhcRXasA=;
 b=Dj6wKaQ5ni/40HWB+qmVqTO/T4QWy2OWIunMuJUHpsb1Hv476AkTyXjTUeVS4xYyOuig5Wtdo/wwv1LjnLYgbPHWJ0YlbR3kBAxtNRlXmivulY9BQZU8LB4l5EFU/nqRRwUbmWENNWm0gXmo/S54Tp+lCpo73CH9O7+B75ggw+JMDLtL+N3ZvDqogtKMu3i3+EcMsjkMROP769m+d/VOREb5bgY4B3jIAz0g0E0wLeQcSnwogTRaxXn11K97LIZeJr+RemSJbdcbtZjTIrvhViIQ+wDB3n0LS3eppnHGgS7S2y6har3XOQ8tVWHqYOc8p2RmaDZ13bFim1l3LFIpgg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kszzaiF+e466ZWDFXl2+w5Tq4f8Aa6HiBSLRhcRXasA=;
 b=xx+VbS7pLO/kewtjiI5DxWEiPS+mi8fIwBgkSUb1WGCSLBJs9Vu4Tb3nKomLsjIg1ukVwgI377zwh9EZUZiNktttmChQEx/PA48Qji5Behpr0V7fY0ttH8yfBEV+JcCOshP+m7IvHHfdq2jbLsB7o2X0wF25zQV54HN3id1/Zjc=
Received: from DM6PR12MB2619.namprd12.prod.outlook.com (2603:10b6:5:45::18) by
 DM6PR12MB2617.namprd12.prod.outlook.com (2603:10b6:5:4a::14) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3805.27; Wed, 3 Feb 2021 03:46:57 +0000
Received: from DM6PR12MB2619.namprd12.prod.outlook.com
 ([fe80::11e6:53ff:8e98:31f0]) by DM6PR12MB2619.namprd12.prod.outlook.com
 ([fe80::11e6:53ff:8e98:31f0%3]) with mapi id 15.20.3805.028; Wed, 3 Feb 2021
 03:46:57 +0000
From: "Quan, Evan" <Evan.Quan@amd.com>
To: Alex Deucher <alexdeucher@gmail.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amdgpu/smu12: fix power reporting on renoir
Thread-Topic: [PATCH] drm/amdgpu/smu12: fix power reporting on renoir
Thread-Index: AQHW+Yc6XNhgjQ45u0K6UMvSFB8Jg6pFy0Ww
Date: Wed, 3 Feb 2021 03:46:56 +0000
Message-ID: <DM6PR12MB261960D64B7CF9C8C3C8E90BE4B49@DM6PR12MB2619.namprd12.prod.outlook.com>
References: <20210202171641.1062381-1-alexander.deucher@amd.com>
In-Reply-To: <20210202171641.1062381-1-alexander.deucher@amd.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ActionId=416dffe9-a41b-41f0-a0f1-a4b2fc3dd68e;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ContentBits=0;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Enabled=true;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Method=Standard;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Name=Internal
 Use Only - Unrestricted;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SetDate=2021-02-03T03:46:33Z;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [180.167.199.189]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 998c4699-4e67-43f8-7f77-08d8c7f65ae2
x-ms-traffictypediagnostic: DM6PR12MB2617:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM6PR12MB26177BFBDD6C61390AF33F53E4B49@DM6PR12MB2617.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:161;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: hlwvIXTRfZl/QuE8XcJxsuBXdP7IM+YD8be4v9PD/QnUtO7knhW8xKnfW7WtO/HdyB3coAu71Alv7VnosiTFhWDI/LAl1apdsAROXV3iPaGOwcR36+c5AvdZUJCmRWYDQPc5IxpjkGeBw0m6Jym5fDXUounZOF6Yt+f583Ox4H3XpcB98ETCrC5CMRFzDHK8N7gUY9EaBY22MU8L/nIn87PVi0Ege/5vfMeubvltWTUG3iQCuPmQ0ki4Gs82urOwvLoNFDzuiNOFXrFLSU73HmenViizjtXwGnb7FW7b7FdAVrG70II1yaLQaOyoMjRBjmxVbSWF5/iF7RDcS5Lj+E39toG9QO/WmGUKswJxFHLeWVHJvzwKWGrZV3xGCeOgoqs0x98vDLrWlx3N8vw9fpAMWhJvHckOiO6BCqHTm1HSDpAY9xbVW0G9LL4knyDYP36Qx/o9kb71KYoFyW3Tpa+5Zn7Mu4n3DXszkKPjXGFxonHH5O2aauan8y1z+Xwx18pwkJ9jhl5Y1XzvrH/9ULZX7uXNPza6By+Z5ycTo7dxyA480vCfMHIKoAGsIsGK
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB2619.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(396003)(376002)(346002)(366004)(39860400002)(136003)(55016002)(9686003)(478600001)(2906002)(5660300002)(26005)(8676002)(186003)(4326008)(83380400001)(86362001)(7696005)(53546011)(6506007)(33656002)(66446008)(66476007)(71200400001)(66556008)(66946007)(110136005)(966005)(52536014)(76116006)(316002)(8936002)(45080400002)(64756008);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?1olwmR1/CTP8PUYYRZPq7JK+e0TC2TAHSE07YZTRMHoMwOAQE06+BBf4bW71?=
 =?us-ascii?Q?VjWqX92VPJ0312WhXFWFDRbNvy7VTPwlscBYun32/dJIvBGDdFvJZ9pxRK2z?=
 =?us-ascii?Q?FmFPfKE+pj6df4LAO9xtH0HDqW8NbTuHJ4y/066KOX2x+XC4pV1dP0RmGTOF?=
 =?us-ascii?Q?yP704P0WPMNeNi1Yk51/iWe1bRmxZHPyFzd/at28v+0pEqyOActsFQFHGqGd?=
 =?us-ascii?Q?QpeoTa0F3Y7bhPcJKgRRYjR8e5Ua+pPehr2eWSPZuQzAapF2b2CNHFR4PW5E?=
 =?us-ascii?Q?cBzAjp/MVecu0Ii7XaUHiiInGYJrSI/nMcEak1QYbMWWiUG7KksmVGFBONit?=
 =?us-ascii?Q?9cf2ZEMZtAJNYbBisU4zbHS+BwfRDEHHyADjX2RKQOwlH///2e7HH1o50ZL4?=
 =?us-ascii?Q?3fAlK1bVO0hzzYxKdt4AVmlpA/wtXZaY9KwIEfK/ahiSjhsdLD+agkomYn4q?=
 =?us-ascii?Q?nDrDEBWzbv1E7VJKXZbUvzgGjuCefr1rmM5wmuS1lq72OijwBy3OjrSldN5X?=
 =?us-ascii?Q?nNnInVY7pBob1P0//jmYYOJ39b2BQb3spEZxnSke9TRaeYcD/supjz2qljvD?=
 =?us-ascii?Q?8jAFFjeGbtkX1u8wn0BaOKj6wzX1LJ6NPaKZuGgxDHMjsQoVo4hAfxUzLZVa?=
 =?us-ascii?Q?SgD34Jzo0a4z0ZDP4QCVXPTIULQG5bqxq53N3SsaqFLXc3AVapL3of8CVg33?=
 =?us-ascii?Q?oIdle24uNw35kG62aGImXtxU72e6BfgLJUsimjRkbS6Tn8oBHGwoy8H9Q+Qc?=
 =?us-ascii?Q?rDiovRbg+IlxFKL6mQfupdX3D7riYtuclDbRB4OjLXsyp8Agv1GPbUWTxDUb?=
 =?us-ascii?Q?INW1lIW6fgDV9cm2zDFxxXF/dCnwMyEH95ZGL8llPa7/wDYHtX3Pqfobdi7Q?=
 =?us-ascii?Q?kPWyIaE9b25x0WdvBpQB520XgnsoTiAU+cnRKDpWqkKj/6x9DHtKlr6KN+qt?=
 =?us-ascii?Q?xoLgQ+5d8e6/lh2alNffW08v7zSFY+r1s0QRqoQ/3yhnHJ7NwDFRU42cWP7I?=
 =?us-ascii?Q?CNENA54xpY/ZmOC7aV+2lN47JHixETxFF2MpRzUlzd1LFnJwJI2JYdtZ6Ite?=
 =?us-ascii?Q?KGd87ilf?=
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB2619.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 998c4699-4e67-43f8-7f77-08d8c7f65ae2
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Feb 2021 03:46:57.1661 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: kRYqLxt2EbqcD7VTSGD0Sve2MBJL+zRalGn46IGj8Xl698KynyKorRsUem4M2tPm
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB2617
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
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Official Use Only - Internal Distribution Only]

Reviewed-by: Evan Quan <evan.quan@amd.com>

-----Original Message-----
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Alex Deucher
Sent: Wednesday, February 3, 2021 1:17 AM
To: amd-gfx@lists.freedesktop.org
Cc: Deucher, Alexander <Alexander.Deucher@amd.com>
Subject: [PATCH] drm/amdgpu/smu12: fix power reporting on renoir

Align with Vangogh.

Bug: https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Fgitlab.freedesktop.org%2Fdrm%2Famd%2F-%2Fissues%2F1467&amp;data=04%7C01%7Cevan.quan%40amd.com%7C58ce04c3aa7c49734cd008d8c79e57d2%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637478830246184021%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C1000&amp;sdata=qvKZYxY1BVaGscUkgha0TeauvwmwwWrErHE7ht%2BC5Ic%3D&amp;reserved=0
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/pm/swsmu/smu12/renoir_ppt.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu12/renoir_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu12/renoir_ppt.c
index ab15570305f7..f6844b90ca67 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu12/renoir_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu12/renoir_ppt.c
@@ -1129,7 +1129,7 @@ static int renoir_get_smu_metrics_data(struct smu_context *smu,
 *value = metrics->AverageUvdActivity / 100;
 break;
 case METRICS_AVERAGE_SOCKETPOWER:
-*value = metrics->CurrentSocketPower << 8;
+*value = (metrics->CurrentSocketPower << 8) / 1000;
 break;
 case METRICS_TEMPERATURE_EDGE:
 *value = (metrics->GfxTemperature / 100) *
--
2.29.2

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Flists.freedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;data=04%7C01%7Cevan.quan%40amd.com%7C58ce04c3aa7c49734cd008d8c79e57d2%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637478830246184021%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C1000&amp;sdata=1NYKw0SEa%2F3MUUVpF8hxOhXf48311uhRKUB9W%2BMEeW0%3D&amp;reserved=0
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
