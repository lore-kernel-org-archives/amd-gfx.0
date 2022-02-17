Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 51F5FC433EF
	for <amd-gfx@archiver.kernel.org>; Thu, 17 Feb 2022 19:17:02 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F25E610E460;
	Thu, 17 Feb 2022 19:17:01 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2048.outbound.protection.outlook.com [40.107.237.48])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2B4C010E460
 for <amd-gfx@lists.freedesktop.org>; Thu, 17 Feb 2022 19:17:00 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=m9a1x5waRmk3v7pyX4ljDdcKyEe4OCj2jdCBuV1jmjxYq9ub3pMUk/+VMsMD7YgskZnpmAQi6kvtVZ+bzvXGK8UIKH4KJWWt35PfkFh0OUGtWexV0m+ImCVUo1F/TsQ4Rc3FLNeXRaqEhM9SFqAxQABXSlrh9Q/kRZbr2HUHCe4dYHcZsoijoR/yzcBvQRNiXKuXB2OgsMp4VheCnyFYlD/CwiP93gbaTIqfiTZX4WKCMOtLt5nAALghYcPU/XzEwrqwpXZ6CKp4BCiVSWf8uuh0xt5Atj+4A+p76lXML3LCkGen/TPhrfslnkvImJ8/wwCnzadLP+hIHBPca3egVA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TlVu3FhHcX2ALPgQZre07ECfYqd9UjUAXBx+i49Ww6U=;
 b=W/th6bIoS5j1fLzS38rrLgAcWoFVOd6HgraPjIAi1iiuNRWS22/32RHGW05vQwv3xO/hzsQ3jLSehSyCgpZWpZQQIJPnL+pdRmdhzzUFDHZhqU/3juWmOu0q3/EC9qOiPrbGFs4gd9USET7sNM/wJoXbmhfGoQhRVXSn61BDTUxppySaVogGVU9wNh+6AHW8cglZ4dxFysnPV3lg5FMdUdTw0bgIE2xYVkzVcG2vbMlexWBW0gGLqjL6uWGtpY5GCvx4/oySW8B5c0qNshdken5EljOTbL8IwFp/DKgDghFBgtZ/VXIWVRaFfHE/NfpEP1SimhRV1zDNJfSWXB48FQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TlVu3FhHcX2ALPgQZre07ECfYqd9UjUAXBx+i49Ww6U=;
 b=4/rlmWxeoZzkVIOD/LVH9guv1aoagaibHj3fysdKkYlyV4dslTYp6XBgi3E1uySdybyKihyuUehzkZ4Hr53KBYRoUBKZdRRqDpGMUZckEXSXTKnIMaW7A0T3xjkbFJvjhnWGQAJ+Or/vqYh2rBBY2GwFKx1NVz6PdVpFPWusYe8=
Received: from DM5PR12MB1323.namprd12.prod.outlook.com (2603:10b6:3:75::12) by
 BN9PR12MB5114.namprd12.prod.outlook.com (2603:10b6:408:137::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4995.16; Thu, 17 Feb
 2022 19:16:58 +0000
Received: from DM5PR12MB1323.namprd12.prod.outlook.com
 ([fe80::1495:b6b7:8429:a5fb]) by DM5PR12MB1323.namprd12.prod.outlook.com
 ([fe80::1495:b6b7:8429:a5fb%11]) with mapi id 15.20.4975.021; Thu, 17 Feb
 2022 19:16:57 +0000
From: "Kasiviswanathan, Harish" <Harish.Kasiviswanathan@amd.com>
To: "Slivka, Danijel" <Danijel.Slivka@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] amdgpu/pm: Disable managing hwmon sysfs attributes for
 ONEVF mode
Thread-Topic: [PATCH] amdgpu/pm: Disable managing hwmon sysfs attributes for
 ONEVF mode
Thread-Index: AQHYHqIm6aRdTQGDh0mYTVbeOAGvU6yYKH3w
Date: Thu, 17 Feb 2022 19:16:57 +0000
Message-ID: <DM5PR12MB1323DB16294CE78D6F845F748C369@DM5PR12MB1323.namprd12.prod.outlook.com>
References: <20220211012343.3955-1-danijel.slivka@amd.com>
In-Reply-To: <20220211012343.3955-1-danijel.slivka@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Enabled=true;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SetDate=2022-02-17T19:16:55Z; 
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Method=Standard;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Name=AMD Official Use
 Only-AIP 2.0;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ActionId=ee2fb167-f34c-4b54-abef-e5226b7f6787;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ContentBits=1
msip_label_88914ebd-7e6c-4e12-a031-a9906be2db14_enabled: true
msip_label_88914ebd-7e6c-4e12-a031-a9906be2db14_setdate: 2022-02-17T19:16:55Z
msip_label_88914ebd-7e6c-4e12-a031-a9906be2db14_method: Standard
msip_label_88914ebd-7e6c-4e12-a031-a9906be2db14_name: AMD Official Use
 Only-AIP 2.0
msip_label_88914ebd-7e6c-4e12-a031-a9906be2db14_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_88914ebd-7e6c-4e12-a031-a9906be2db14_actionid: d419bf7c-c422-46fc-9879-3a41cd042099
msip_label_88914ebd-7e6c-4e12-a031-a9906be2db14_contentbits: 0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 291ebfdc-9cce-492f-b71c-08d9f24a1131
x-ms-traffictypediagnostic: BN9PR12MB5114:EE_
x-microsoft-antispam-prvs: <BN9PR12MB51144C783A434B29ADD5FDB78C369@BN9PR12MB5114.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:3631;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 5T/b88N4N+wdERxfRfcTwCiYEFfgs/6+aW9K3FI7xLACOIIIG4erBaAHS6mDKKuJHR+bJ2GVFr7I1ZwZpz89xfocOhJJZL2vAfYqF+Cl/qYarYzbeREmTw/QcNf7V8DEAKMtYM9wqbMJb9CFn0gyA16YoxvINc7dtBlh/8AGTUvMIpndYFPYRh6Xfz8ApmtH2Y7xwkO9N/m27SjBk24pQgTKuSnmFDsfkXjMVQVDr6OajuZyMAMd0ldTRmbxz8xXYeWlSo+KiajjF4ZEKcGRdCSz7dlU1n3b9EnF7aiLPMhMumx9B5Ji2OUlbZAp0eK30TL8spdKs79AKjZq3bVOTisIVKNsO1/8C6PpursLgm8r7GcdP/B0+YwjAn2SPiolDrCF+KTfmYlemTKRNeG8e2SmG2ltt8XenuxIRA3CRmKMZe8IVxbSZbVwXFOf+yWEgv2r9g3dWqGsHYZZ5ens9P7xG+dvIpCXpxcHTzGPVhar/XFJRaTU9Vj80hFzQTkQCQVv7JAuKH2VqlnhBkrtUiMLMOQTGxzjJv9TThz6TqCdmdZ67aRKpD7v2b3GDXnG5Y6UbhoK98KKiB1KS8nZD5SCmuVBN6/EnyOloVv3E6Rq0JTaIClU8CW9tj2BLp6j5SmJiSlLE6lNHTl7uu2/ZApxXB4rg7X2LoI6vTj0aBdqWdf0tPNgq/N4B4tlZRXawaB5kfa3kQjSlKw+18tQbg==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM5PR12MB1323.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(4636009)(366004)(316002)(186003)(8936002)(5660300002)(122000001)(26005)(2906002)(9686003)(53546011)(38100700002)(7696005)(110136005)(52536014)(6506007)(38070700005)(8676002)(4326008)(71200400001)(66556008)(64756008)(66476007)(86362001)(66446008)(83380400001)(66946007)(55016003)(76116006)(508600001)(33656002);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?V4X+6lQ1eyOzP7mH/qdmRvl5e8pa0u13LO2W5f1FOSREoNOFNUcHJSn9IfaD?=
 =?us-ascii?Q?3YLJCE4Lr2FjKLwsrRNjo++em0DE3vNefu9+OGNqx037h+Rz18cLe5Z0IgSP?=
 =?us-ascii?Q?B4qbReXqd/dhctw8jpp88TU7zWQqOrVQbrUxqHUFYIPZ820EH5Ik4Sf8WRzM?=
 =?us-ascii?Q?JU8Afo9bW3NXGuRCHE/dKKVfB1REIJuX0FaZs1gBCtMFeTEzgvGh6y70K0Ln?=
 =?us-ascii?Q?0ItGjsoqJggVgCi1qYSTtgYsG508Qshz8k/I8Sg6Oa323ULtoewczblSgjEi?=
 =?us-ascii?Q?yFR9GFvRrIxsGNgNTtvTrynzhT4UQl4FmlzWCforG1WWod9mCIwvyqi8lAvH?=
 =?us-ascii?Q?5by3G9UUrawkCK1L/1X31hfTJgY5C6QL7kXtFAMUEr/ANRtwZr/kHC8b8cWi?=
 =?us-ascii?Q?q/wCQ8DxhmrWFp0CfyLdayDth2505VDZ2X8mdC3lO1kFniST/4VwF50dSRw5?=
 =?us-ascii?Q?mj2od8Of3A64wWWuhrh7a7L6MkGeNr0CEeAYxl9lWHrL1eMwYhhp17TuGCoH?=
 =?us-ascii?Q?dArxniea04Jzm5K1Gfmb8mAaDoxFhuOldK+E3snt+4qcS5VYGh4WFbSCIpIp?=
 =?us-ascii?Q?i2NbGRuYhAliGz1kx8gN45dic4JpqD3eQu4ePix6sMRe3FS3oGiqkLMoMN8j?=
 =?us-ascii?Q?1zIFs5BXD2Clf10NHYEeQwvZR4eAxaw9I+eGOBymG/Vv0kmpwDZp8TWvdBrh?=
 =?us-ascii?Q?X1nIByFBTcJ0qhbmSS9hAgU/9IldhI8Ww/AxFZOrZWowIGrs1cFaAMaK7nv7?=
 =?us-ascii?Q?v+aLEJ1pWkk9HNHKL5EKujAvuJix6pC4qK2Q3jas7HPG9VSOXeyh0Of4jqIR?=
 =?us-ascii?Q?6ClTvpefAnITK/oz21LkE3L6MAil6gOK854+oVZwSYjVDHg4N9hl0ew2xRPU?=
 =?us-ascii?Q?HCXVh8SStkyNUa0rEAvj7OOeOFCBx7gCHi5qxB2vJipEPD4IiOymZTmYRgpX?=
 =?us-ascii?Q?tDLy6I4nW3NIh8qcW65hHKmGqvnNkRyZu1h/o+7aLNsZoWnOlrWdoPqomNgY?=
 =?us-ascii?Q?16Vu89JmkQPiRoKHw+/pGNAe9zGFy9jtU4BL8GfTYTZuyg5Rty88QRKt57n1?=
 =?us-ascii?Q?Z9sQtElsBnxPvz3qFrOll1ENARKeo0wQdIgdetFbLrx9ndsPDsxdKT8uO2/s?=
 =?us-ascii?Q?27s5lfVqvK+coKqGs7SQ84RAeFCeHx9Zhlir4agJe2FQvHjqscHst/VqG78/?=
 =?us-ascii?Q?ozUKJjHXavjpZQW6546OLo2Y21vXLE0r+UTodcics81ROlUxBijTnNhixVUE?=
 =?us-ascii?Q?ORBC9s9uc0zEDnDR7BzL5Si66tfEH56IU3GoeLRAyQd4ZT3H2O33XgNV9Kt9?=
 =?us-ascii?Q?Qjd4ivnqx/CHQxwKrCVrFoJR+aHaGFS4ubL6ROkB7WUDVbKsaae1HcHHjYRb?=
 =?us-ascii?Q?Qp3OsP8ioUNWTi97eC8WoQmkn8E6nd6E8v6kq6dXyC7zvMzk8cO6Yir6DvDx?=
 =?us-ascii?Q?vvccT0ktiZQisrWdrCEg9WobsFGXWuBPiwUCXgiQhjyiZZxq1DkpZFqvho6v?=
 =?us-ascii?Q?jM6DfPn/j0uEdBXChB2hpUyGGkCplq2GLHqx6PPG08sAF4OzcLKZFUFlwa4D?=
 =?us-ascii?Q?ZKkmZYthO1+iBALm7ELhiXLBYjyEG3cqlzFFRWvPqj88yS+DoY6XFtRbSM7s?=
 =?us-ascii?Q?TA=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM5PR12MB1323.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 291ebfdc-9cce-492f-b71c-08d9f24a1131
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Feb 2022 19:16:57.8202 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: MLyLBlSoV8KbrlgLX9UwTcIHAJIwVPavn5R9TP0RJNi+UqP44c4JhB0v0ay0/aisr8QOiRneeVVBJbuPIZdOew==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR12MB5114
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
Cc: "Slivka, Danijel" <Danijel.Slivka@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Official Use Only]

Acked-by: Harish Kasiviswanathan <Harish.Kasiviswanathan@amd.com>

-----Original Message-----
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Danijel =
Slivka
Sent: Thursday, February 10, 2022 8:24 PM
To: amd-gfx@lists.freedesktop.org
Cc: Slivka, Danijel <Danijel.Slivka@amd.com>
Subject: [PATCH] amdgpu/pm: Disable managing hwmon sysfs attributes for ONE=
VF mode

This patch prohibits performing of set commands on all hwmon attributes thr=
ough sysfs in ONEVF mode.

Signed-off-by: Danijel Slivka <danijel.slivka@amd.com>
---
 drivers/gpu/drm/amd/pm/amdgpu_pm.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/gpu/drm/amd/pm/amdgpu_pm.c b/drivers/gpu/drm/amd/pm/am=
dgpu_pm.c
index ad5da252228b..3cec023a7b06 100644
--- a/drivers/gpu/drm/amd/pm/amdgpu_pm.c
+++ b/drivers/gpu/drm/amd/pm/amdgpu_pm.c
@@ -3161,6 +3161,10 @@ static umode_t hwmon_attributes_visible(struct kobje=
ct *kobj,
 	if (amdgpu_sriov_vf(adev) && !amdgpu_sriov_is_pp_one_vf(adev))
 		return 0;
=20
+	/* under pp one vf mode manage of hwmon attributes is not supported */
+	if (amdgpu_sriov_is_pp_one_vf(adev))
+		effective_mode &=3D ~S_IWUSR;
+
 	/* Skip fan attributes if fan is not present */
 	if (adev->pm.no_fan && (attr =3D=3D &sensor_dev_attr_pwm1.dev_attr.attr |=
|
 	    attr =3D=3D &sensor_dev_attr_pwm1_enable.dev_attr.attr ||
--
2.25.1
