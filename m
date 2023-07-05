Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BE826EB64D9
	for <amd-gfx@archiver.kernel.org>; Wed,  5 Jul 2023 02:27:12 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4B8CD10E133;
	Wed,  5 Jul 2023 02:27:12 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2054.outbound.protection.outlook.com [40.107.94.54])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E9E2B10E133
 for <amd-gfx@lists.freedesktop.org>; Wed,  5 Jul 2023 02:27:10 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mmF5tBhBRCi3cYwMIK41xfL1QzbMdtab4F/TNcjLceB2tb1/lL1QU4gA/AvbaULbadkapU50f8F7A5G0NCADTcRvG1coO2EROnvwo6xpH5UkkX8Bo6kWxexNtC6/bXEGRQyOtwFEKs4fG4LOBe4b/h02i6QFSsvG8qKLTItqNsILhKRbAJwZx/jFkdefAG3HoAZQhFhejPcdTh2f+H4JyrcuN2f+xWsZB0oDOWySR6szM3rMj2teL4sZ2qkkZaEhvTeJLlaoMYHM3sJpCabPJ0KEK2UH5iGAFkTQ8rMMOHeUvotLw6ZZ86VI+Ayq0Kawy4jJEd4l7CLIkXXKhzK+yQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EfwUy23aVrtPOpktC3+KVHUk+A/x7uxlqMiE9//RPHQ=;
 b=dHHvbvLXlVXWBnQRN4MSJMdekMHSNvm7aTISvvlq+jQf9uZNbCNRBAKO9kHX4BcWEUeXztv9akNSjS+6125Dut11+ZVC75pCFGpTnt6mbRE/Fu3/vAynDUk4yfXNYFKUx828HT7rNFYbC+VyG2we0sG2z1T0qbv12uiTNdj6qFI6ITZaJ+dCW763A7LDFOkZtClCye5zEXKiwFFOcU736GrKOed0D/QhMin5rrr2CkN+cOnKOC8/FLqpnIAcFSfeJ+ZAxRz9OSasmF0tV4koeDb93NOmTq6tUm9wnTiYPhHKvQgUOSM4modtcH09zU0SfKg5yFSZtYHnRW/37mSFjA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EfwUy23aVrtPOpktC3+KVHUk+A/x7uxlqMiE9//RPHQ=;
 b=AC0AYuAhE4SqlW2o8W9moJ5kEZZx1aKZpCU94gDSFd4ZHpDhKJG8Z62Y5pqRa9Cj2tr1ckSQzSlwND53wQRL93dUnx+y1SwFpjscKuyarHT4Vrk3yK/bPiC41zlq+hLIMpYmTBnrsrEVAKDsd2T0KCSQNAcfzTbBN8CrKkykCNU=
Received: from DM4PR12MB5165.namprd12.prod.outlook.com (2603:10b6:5:394::9) by
 MW6PR12MB8661.namprd12.prod.outlook.com (2603:10b6:303:23f::5) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6544.24; Wed, 5 Jul 2023 02:27:08 +0000
Received: from DM4PR12MB5165.namprd12.prod.outlook.com
 ([fe80::f0ee:c42e:fba1:4f02]) by DM4PR12MB5165.namprd12.prod.outlook.com
 ([fe80::f0ee:c42e:fba1:4f02%3]) with mapi id 15.20.6544.024; Wed, 5 Jul 2023
 02:27:07 +0000
From: "Feng, Kenneth" <Kenneth.Feng@amd.com>
To: "Wang, Yang(Kevin)" <KevinYang.Wang@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amd/pm: disbale dcefclk device sysnode on GFX v9.4.3
 chip
Thread-Topic: [PATCH] drm/amd/pm: disbale dcefclk device sysnode on GFX v9.4.3
 chip
Thread-Index: AQHZq0UYb/35I0cA7US1Sv0LlTw1+q+qeWOAgAAAOYA=
Date: Wed, 5 Jul 2023 02:27:07 +0000
Message-ID: <DM4PR12MB5165BA8EB9AD04F8CB1695328E2FA@DM4PR12MB5165.namprd12.prod.outlook.com>
References: <20230630112135.3347421-1-kevinyang.wang@amd.com>
 <PH7PR12MB5997E56F35376475F7EA0502822FA@PH7PR12MB5997.namprd12.prod.outlook.com>
In-Reply-To: <PH7PR12MB5997E56F35376475F7EA0502822FA@PH7PR12MB5997.namprd12.prod.outlook.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=202dcf06-c755-4b06-8eb7-e996c81b24cc;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=0;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2023-07-05T02:25:15Z;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM4PR12MB5165:EE_|MW6PR12MB8661:EE_
x-ms-office365-filtering-correlation-id: 230d2783-f2cb-468d-a491-08db7cff540b
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: cIJtrS79INozPCQpSXUFmJbhgWnBI6sHD+WuGE+3lpF9+b6BC9DkxIKzGuzkDQ/c9NoPjvFZmgwpPp/6V8q0jv3R9CftOT/cucfIEQB++k7SXFnBXYhJJcOTUgHgfNZIEDEDP90m9N/Dy2IM+zLly1OHNVvBS7KuOvJZ6zaGyefWDcHL465YqP91Sxhqcr9LmGGKw8spqNHQcsCiTpgvAfVYnS9r0sDbEuZ8oauiwu40wrQxuYsaj3P4iELhRWRMmglJqvg1cbgQJ7c+8TyVbnTUdyxc72LQCcbR0U+5pFraqtAFf0y5u3m3EMdvEtFE9qgE9mdj6gHVWGvMKnUM+rzfdvaKSCrETQMIq87iI46Tb6IHXRTDhQ/z3HBdhWutCAjWpbPUugrNRSEnqAzniyi/xqs+bg58O+/APtEZg7ORw4ya2/ixXUAMhPPMHqb7ixDwaKzBR2+u6UK+qYh5fV5f3IVmBcXi/v8H/enO/6q9PYvDDdAZKM7uysZwawRxtF3JWedLrF4hfm+I0lsoyeuDp/TvLBISCin2dzdWPallNKnfF26ry9cKx6sl9Ifukca/yHrO7Cfv2+KZYigul29VxCa/COOHGTNnPWGZSB9Mz9oD1yLPXfrbZ+pcZGLL
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB5165.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(4636009)(366004)(396003)(136003)(39860400002)(346002)(376002)(451199021)(38070700005)(2906002)(41300700001)(52536014)(8676002)(5660300002)(8936002)(33656002)(55016003)(86362001)(186003)(478600001)(26005)(6506007)(9686003)(71200400001)(53546011)(7696005)(122000001)(76116006)(316002)(66476007)(64756008)(66446008)(66946007)(66556008)(38100700002)(110136005)(83380400001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?QWwrlqyK229Tp0HrKeiJEJB009oKurDhSPwwqbBOg01+MYPPTB7SFtkQ62LL?=
 =?us-ascii?Q?0jmuRo1U0IsN7XiZa0BqJgaHDP1O0HOxwWp/buouaDVmo+lh/MWZ/RDnXfS1?=
 =?us-ascii?Q?cYWO0MugXLaclcPVaHpSv141d7M3cCxcFmeJk1Hf3lUNdDRxGXWfaTev3Efn?=
 =?us-ascii?Q?VHx/3k04zuiY9sWT/iidYb7kKoti4QHttnQA0gXdI5yaUzZ1Ktt6ntf2f3Mf?=
 =?us-ascii?Q?F5x2FAEVsLuaOf7jsgzmZDcBe3oQwED8AcBntQhJsVP9jz5KyTQWewHlgonn?=
 =?us-ascii?Q?9W/HVLYJQ6Eq/yEyZ/4hZlbf/T/vgZUR35t8kO1RG4dKPhMmrFoIlNtjyMWC?=
 =?us-ascii?Q?aQu5vmDZQucigq5Q+xGhn6qUzIPQGByF5gWrOwcg7wRPlLsVCrBEMfLouPS0?=
 =?us-ascii?Q?EiUNXOwgLX4CFgED7v4sWgUmNnppco/7gMkVeb6XPOYfJ4Grr2bBMy3uxLWw?=
 =?us-ascii?Q?Du5Noo636+/bOnmb6xz0SGPSwy33/8ty892qUkWsnaKoQQByMynacHYL6Lfl?=
 =?us-ascii?Q?Lm7ISYvAxSDV9nbtKhvv7Rah8M0RdeXv3cjMi0B9X8aTOVyBozE4Z40FTNWq?=
 =?us-ascii?Q?TuQIaS+0HXzDvvOJn0gdwzwN+eFCTLODdWxWD5i3DR1k6tMq9lojYvtwJ+yW?=
 =?us-ascii?Q?rcu0snOLvUJIbo0qMLhA+8/31CPa9KGg3PA3+A3ObNQd63kQl2gqPlWKXCU3?=
 =?us-ascii?Q?sT42b0YHmFS0XPzs/uuEp6NBXGgvqaPKFV9NSDlI2oYukp4fVqvX7nMNTBxv?=
 =?us-ascii?Q?GgY4fBSNIvA0IMqf3D0DTeWHX9BB9U1XCgSxgYaDGbp5+EMGYNsq0BTF57q3?=
 =?us-ascii?Q?AJbIAYjJaKYRm2lIU+tMzOuT9dOalAiCeHmykNrDIcwuMdkSFXoiGZ6//7pl?=
 =?us-ascii?Q?EshsS9vhudRGckQdUJpWT/TSNpxa+DK1T6YVlQGH++DIgOXobBEenhcoEy4L?=
 =?us-ascii?Q?uv1fOI5VUM++tWRmApYNSh/AZekYG7dkaEMvNTPGTKFDI1leC7gvTygXo5sn?=
 =?us-ascii?Q?PYd4LTPplhpXE6mEeGxe8MlRbkUd8MyIyF3tYvHT28TT/h5rsrkOW9s0229m?=
 =?us-ascii?Q?sZ0vEDwLjAxouwcFPHeNz6BLoWx9yQINVZZfK3LR4FBQoBhX6jDshbrjF5RF?=
 =?us-ascii?Q?om270yp3PD/DmWn3PpxwVJXn1ub7jck+CKKYS079itx7Kw9sHLwh02C46Ksj?=
 =?us-ascii?Q?1SGf9hN6CAviKxZnf4bzyMpbdEqzITIV0+cq4ev8b3ssvLkRJHxf1X+WLnji?=
 =?us-ascii?Q?5pwbBwSo1cVTzV+WKptkjPe+JHrRZ5GJrtLlynxFGzTQWnpv2svcn5+Ha3E5?=
 =?us-ascii?Q?g5VbNRaUdvvwBPNlyWKmwzDzYqC7AcjZSd3vvoiTashsyH8NQSgcpfSxaC3Z?=
 =?us-ascii?Q?4pqOczj+B/wfcl5+YVP053iyXgBX4WUanRdY0y1Oml6lLeAyzHuqfcyIva69?=
 =?us-ascii?Q?oRDp8/1tcSpjPYnWvzZdU3FdzZJWXtrkCi0+8kz4wCG0Q4iF27nsIkvkz0CY?=
 =?us-ascii?Q?ylKUwgGHxaeKc7emQosLxGwj2zNt9cYR8wTjtAfe5mQuJfQroiKvyfSKPBsU?=
 =?us-ascii?Q?jVYPSP4rzyqn/7sM2gA=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5165.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 230d2783-f2cb-468d-a491-08db7cff540b
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Jul 2023 02:27:07.1244 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: rXif3JwqisRY2HWqpLFsZN9usEpYnfvAHs4tMwpaUgpRglwFIwsicLsMNXJ1r4cf
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW6PR12MB8661
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
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Official Use Only - General]

Reviewed-by: Kenneth Feng <kenneth.feng@amd.com>

-----Original Message-----
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Wang, Ya=
ng(Kevin)
Sent: Wednesday, July 5, 2023 10:25 AM
To: amd-gfx@lists.freedesktop.org
Subject: RE: [PATCH] drm/amd/pm: disbale dcefclk device sysnode on GFX v9.4=
.3 chip

[AMD Official Use Only - General]

Caution: This message originated from an External Source. Use proper cautio=
n when opening attachments, clicking links, or responding.


[AMD Official Use Only - General]

Ping...

-----Original Message-----
From: Wang, Yang(Kevin) <KevinYang.Wang@amd.com>
Sent: Friday, June 30, 2023 7:22 PM
To: amd-gfx@lists.freedesktop.org
Cc: Wang, Yang(Kevin) <KevinYang.Wang@amd.com>
Subject: [PATCH] drm/amd/pm: disbale dcefclk device sysnode on GFX v9.4.3 c=
hip

the dceflck sysnode is not aviable on GFX v9.4.3 chip.

Signed-off-by: Yang Wang <kevinyang.wang@amd.com>
---
 drivers/gpu/drm/amd/pm/amdgpu_pm.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/pm/amdgpu_pm.c b/drivers/gpu/drm/amd/pm/am=
dgpu_pm.c
index 9ef88a0b1b57..5bf401533103 100644
--- a/drivers/gpu/drm/amd/pm/amdgpu_pm.c
+++ b/drivers/gpu/drm/amd/pm/amdgpu_pm.c
@@ -2050,7 +2050,8 @@ static int default_attr_update(struct amdgpu_device *=
adev, struct amdgpu_device_
        } else if (DEVICE_ATTR_IS(pp_dpm_dcefclk)) {
                if (gc_ver < IP_VERSION(9, 0, 0) ||
                    gc_ver =3D=3D IP_VERSION(9, 4, 1) ||
-                   gc_ver =3D=3D IP_VERSION(9, 4, 2))
+                   gc_ver =3D=3D IP_VERSION(9, 4, 2) ||
+                   gc_ver =3D=3D IP_VERSION(9, 4, 3))
                        *states =3D ATTR_STATE_UNSUPPORTED;
        } else if (DEVICE_ATTR_IS(pp_dpm_fclk)) {
                if (mp1_ver < IP_VERSION(10, 0, 0))
--
2.34.1

