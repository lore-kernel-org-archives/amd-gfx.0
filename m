Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E829CC369B1
	for <amd-gfx@archiver.kernel.org>; Wed, 16 Apr 2025 08:12:18 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7E8FE10E87D;
	Wed, 16 Apr 2025 08:12:18 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="hJEIsTth";
	dkim-atps=neutral
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2055.outbound.protection.outlook.com [40.107.93.55])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CB51610E87D
 for <amd-gfx@lists.freedesktop.org>; Wed, 16 Apr 2025 08:12:16 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=C5Xm0MM4LwY7uHwEM+5bRf1oImqSW3BsWCaKx06xF8CZMTFYEvFR3UTOp0wUPcx867cyH9IPjKT346xT6ouDX0+hLwtD7WNdvtBlm3Dfc0OdI48x+01OwCejli/PUEzi4iWIiwoi0a5iyASnhUWUoGKTc8kEBSDGNTV9YQ76keeqZG2qlzsU2LCgSGLkTRyiOku6gqkJV8npVpegsEdZ/s124uKSdZSOcJz99iKWginJJBe+dosYWfuIEmqul47Y13TKvM9AYxG1me4SCmH8UxDaSxSAUZ7QAsPyszhn289Ae+u13852bqdukXRmoPpaOQQgPqGLpft0xuiw97ZTsA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9Ur725Yb8mkG9vxvbb34kDWrnl+W3KhFhHFVF/jKJVg=;
 b=Vav3YLwMrWjU3H1iLp7X4zq3MT4DopGVcfBVdcGkR0k44m0Li+FEg4F9BmcpBrGPJw2pE228P9udCofUBM/zSjsuudf6OnmCyVzxq7xL53K5VPPuLF4EgR2S1NvQHY+cukg0p6ALTaW78wALGEVOOvpoSPn6XJHIvD0jMKdD9zOhZe3W6PDdbAAoNvsr27LWUXhRIfyrxdRVV9wr2c4esqsPHUzWFkC0wfmOCPaQ5kiuHVjFYPA+ZY4IydVOlwp0/84h4nr3ZjVIgBCkKeOyM95PDZKE+PdgyPSWIt4Ln0oDtSWmwC/K13PdiDgB84+bEPzZEmWGJQxUBT12FVMvoA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9Ur725Yb8mkG9vxvbb34kDWrnl+W3KhFhHFVF/jKJVg=;
 b=hJEIsTthv4oSX3Nritxj3rLmDqeGdA6yYJ8EAz4ZEDf9MQbYw4m4lZzBFfFOH7Gp7SYnIqV1SCpp7ddACy82LHRf4BK1eSsTda6Uy6iSXx5UosOjFtBmsgmDzn1ljY+bF1CxNwZpnXLeSU4UUaPIPicp3oIGCZVCBq6E8c6hsGU=
Received: from DS0PR12MB7804.namprd12.prod.outlook.com (2603:10b6:8:142::5) by
 CH2PR12MB4327.namprd12.prod.outlook.com (2603:10b6:610:7d::13) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8632.35; Wed, 16 Apr 2025 08:12:14 +0000
Received: from DS0PR12MB7804.namprd12.prod.outlook.com
 ([fe80::8327:d71a:ce21:a290]) by DS0PR12MB7804.namprd12.prod.outlook.com
 ([fe80::8327:d71a:ce21:a290%6]) with mapi id 15.20.8632.030; Wed, 16 Apr 2025
 08:12:13 +0000
From: "Lazar, Lijo" <Lijo.Lazar@amd.com>
To: "Lazar, Lijo" <Lijo.Lazar@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
CC: "Zhang, Hawking" <Hawking.Zhang@amd.com>, "Deucher, Alexander"
 <Alexander.Deucher@amd.com>, "Kamal, Asad" <Asad.Kamal@amd.com>
Subject: RE: [PATCH] drm/amdgpu: Disallow partition query during reset
Thread-Topic: [PATCH] drm/amdgpu: Disallow partition query during reset
Thread-Index: AQHbrqZM/tiJ/YxLL0e9VcGCQiUhq7Ol8SnQ
Date: Wed, 16 Apr 2025 08:12:13 +0000
Message-ID: <DS0PR12MB78040BD27A0CFFD2866B46DD97BD2@DS0PR12MB7804.namprd12.prod.outlook.com>
References: <20250416080442.849968-1-lijo.lazar@amd.com>
In-Reply-To: <20250416080442.849968-1-lijo.lazar@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ActionId=a05afbb2-f7aa-4234-b215-414e8f00b5a3;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=0;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=true;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution Only;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2025-04-16T08:12:01Z;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Tag=10, 3, 0, 1;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS0PR12MB7804:EE_|CH2PR12MB4327:EE_
x-ms-office365-filtering-correlation-id: 35052acd-be3e-4e17-bab9-08dd7cbe6526
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|366016|376014|7053199007|38070700018; 
x-microsoft-antispam-message-info: =?us-ascii?Q?dSpSVpaufc6XTw0CNN+FYq0J7QxyAqDQkLSWXirPWPlAKQm+EVqESj5V8o64?=
 =?us-ascii?Q?6vedWs2ca/I+SrCMbnMRhZyNZ0CMeR/SJDQDmW/BlzoKoxqyjWmu/NJWz40F?=
 =?us-ascii?Q?S56olZ03blm2U7ESqMjD356pKx6Oiy1an83hwH9mXT/D4Hj1xdobx35pMEtG?=
 =?us-ascii?Q?ymSykuPaVh/JZW1ewHmT/FUYN6yGGxv5e6YWjEx2h8ygKB22MwZfOoSJgmEC?=
 =?us-ascii?Q?mzuukdi6Ee1FiT4FTgdoN9pTdqLryQ4hweQq1jvZO6SwstBUhV+6kY3VHm/I?=
 =?us-ascii?Q?c+16xHD2YVar6idu5gW20NN18H9CBQOmICVLGdNz/LP+ZTbPvt5pJJtzArT/?=
 =?us-ascii?Q?OXHxhStKaWEfg/o6tliK3ziYPkN2gMvVTI9femsTWw/ZPdBYOUI6/hC/yfIh?=
 =?us-ascii?Q?Mo5BlLNxuaS1/VXVoqPNzzSKuujcqUegkRUps9oanbsdYY1XIeT4hrT9BGRb?=
 =?us-ascii?Q?fWCmpZ+/57cYOwoRO6H1bdlmSnTEFk1W3/scVDzW2Ufjl4QGQjGURH1wDhQm?=
 =?us-ascii?Q?yTaChJ+iGCb2GgcDK/XNkIcK5Qes0HHHxjcHz3Gvch9qYZhaAFJG6my1cToO?=
 =?us-ascii?Q?SSOM2eD9lGucQSoqEWHoPwElnsj188xwGuHoohLQoNG0YDYhSLv76t9EZ1eJ?=
 =?us-ascii?Q?IDs4KX0uo6gmN6XOj+Qg418FHQ5kC1S9ay90gX/Zkd7X83WCTXkdtCszt/oU?=
 =?us-ascii?Q?mFYDinYIYftTnnRchpI0iRzDKWW/pASbhZrY9D1sy6kGqfSpYPE58uHNKvYn?=
 =?us-ascii?Q?f+pu6mzER2shnfUObOw347jao8umOTQvWziSoqIMR/GsCB7YeM3ZgxJE7hHV?=
 =?us-ascii?Q?eI9w9tkUlgNGMfnKf8MnajMHBqM9IkmKnt0gJKC3B9nEprMQSBkkoaLAC059?=
 =?us-ascii?Q?x/omxoqD+Aa4pUmtu5z/7/jOsgdzOjhgQPORTv7Ne/p6chqGDTSS69vW7TXp?=
 =?us-ascii?Q?s2hagmY16/+oQkJJNNp5W05kXHozoUQEf/Lcy1zM0h9/wbpwfaR5SSNpDR2G?=
 =?us-ascii?Q?0Jnx4V4YnzjVlkZFUOb99GxRlYaGEeG2s+a12WSiqiwMdxWlDeOguLt7IzE3?=
 =?us-ascii?Q?AnxaJdYwTU6A94rr0uKx6ATZ6GZmDsaiPSLtbi4F6moWXZB5R/r70jSHbA6j?=
 =?us-ascii?Q?BtRr1GbFYPAR+0jZ/16vrAXRRNKehOb++Lg8LfoCIPX8N2MHLkxnTcVR54i5?=
 =?us-ascii?Q?4IGqclh6qjPyF4UjG9LaII5yS5l9i+I2sbjoFrFfi3XtevRBF47ggKW/W3VZ?=
 =?us-ascii?Q?1413oejoGSO4pPHyzdVbk8ujg/HlK5+TOVTeaweW3au4+FdH3W0gKG6OWQ0L?=
 =?us-ascii?Q?QsbaoDLnjaYek/p1UkObxkF0RwQ49LwdWPYpesJW5YPyjg72gS+ba0LOZyIp?=
 =?us-ascii?Q?8V8SEK6s5+ECJdo+Py3pOB+WSaH2Jgwlm2jy95m1fqeuYwlz5uXXUNiDpclL?=
 =?us-ascii?Q?U95wQtCIkeeWnkluKY8QFYpuOlMwOcxrsGmrFLxYXjXAnKc4X/EJxg=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR12MB7804.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(7053199007)(38070700018); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?2/zxsJjIDb5JP7tYnHqJf9uZpvyGLEV2d7Gw4mFkV0xlR1OINdyVlFLGR4cS?=
 =?us-ascii?Q?DJ/n7AdoYByeQihjrXNsl3w7NgHXmhdxT/TS427ACHwo92reJ65zA2xLNhCY?=
 =?us-ascii?Q?i5ZEvGR1IzEiWcCg0HgWc2JbCHEaLqJmgcg4AZ7Qf6utwmhRVIbT93JZ1sUx?=
 =?us-ascii?Q?dje/pSXQq8TA3rQG2p/xLSKFNWll5Vj5aMhatkAb+XOxvZj4QERwO8Intyz5?=
 =?us-ascii?Q?MCxALMiH/4serMKk1hQ2lvuo9VQlFILzcxYz+6PytT7ZDtWnVT8/Z7lgLGJ3?=
 =?us-ascii?Q?Jr46RrgIP9XVJnPdXPfC64y3FsulqR0wpr52FcsHVb4RIYhdnTQaJ8AdZWqB?=
 =?us-ascii?Q?40tasklSIatGJzkCS9D5bt+AxvZw10f5w/R13GKlu//yxfDvLK94/FNfsdkx?=
 =?us-ascii?Q?0bk12RMDHyBvOOJkXho5+i3kNpzMo6rHH3c+HcSkNPIjK5mYzGimQ1bP+nAo?=
 =?us-ascii?Q?8ef6cMLu9i/3SU0KyoVSCm8O2r6NWDybyaOYmgwFOZZUi+GoSiTCOMuyI+Y0?=
 =?us-ascii?Q?552o2MzT97afEZ+AaE/6dP2fhu7/RZX1TzFgt0bDAs4SmPDeA+VNJr6A84wL?=
 =?us-ascii?Q?pM+F9qByL8k3IHpYOAMrlkCLjcmVeCbXyRdK+Z/7eo1+JEVvK2eYw4rKOk24?=
 =?us-ascii?Q?lLwAR8s/SwNMFCGQFt/sEa8ycETJFTL/00mOZTpOnW7epNutqJlgPriIh2AF?=
 =?us-ascii?Q?mAS1/w2LNE8Ae0KYvDmccHCflxBVF+dlPJHEU4VDzjsLE/rK4B51QQtb+GY0?=
 =?us-ascii?Q?KzvVeP4nTKjNcG/S4w/A4CYbuN49xEJlyNx57IXaViGlqXM6QX7p3UB+ZUr9?=
 =?us-ascii?Q?xDr62Uxm+3m0JEL8CFdm1KvEI6alGhqqRYmU4MBxsdItIt2nXfDwB+Vx8yDw?=
 =?us-ascii?Q?MSR/SXglRAcB+Ob9OmgmmtuZM+OpmglzmIymxNnSvlajWb9Haj0C2ROhgWEr?=
 =?us-ascii?Q?JGaXrs5ArZ3GsdOVOdK9ObCRtMBrvJXdXTQLsIiRg/Q+FypOMx+lHE4ev6r4?=
 =?us-ascii?Q?/1analP4ty8Is7JBRP6ShFtc85vBf7bRBrMV61V4ski2Jtlumksbj9YdxUmr?=
 =?us-ascii?Q?YXz8sZNIYERx7sRn7tJXO4asJFwSsKcecLcYNvGrn63sfbWq5GGCFUzkpYex?=
 =?us-ascii?Q?C1Dv3XGdlLrKO5rxTA/CFWsfZHAYHe9dLPwIpo21jO9y7kFuUHCh468hifQ+?=
 =?us-ascii?Q?JvbNEfdQaUAsWTB9AWFn5ETOimb40XASbGfKX0EJ1MfciBL8idLwT0rtf/xp?=
 =?us-ascii?Q?VBVgOWAMnQ7owAsHWUoEO+FGMh2ErCkB6qO5DDo946UrOk374C2rFWWslg8T?=
 =?us-ascii?Q?sYosuN1ENkPTndJ880cdKjh8uIYZdRbqv6veEDhox0bunmLJJ5b6YHeemglz?=
 =?us-ascii?Q?Q01ganJvoCiF4LBA2Xqqs8BLOccn6kt7g1Tn5Ej5fCn2tqkanbgGn+gQg62K?=
 =?us-ascii?Q?5Psk5THFJ4H/HzTHuBjQIjTy4qevRwFZcSr+GWnoeupMDwhWzJdZhdAS2Bkz?=
 =?us-ascii?Q?yr44xHKAgwKaeybd2sBdyszRYsc720Tg7ELHgM8peyV89yLbByvlKLx2IvPu?=
 =?us-ascii?Q?MqIWP4UVr4l1QiwGGLs=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB7804.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 35052acd-be3e-4e17-bab9-08dd7cbe6526
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Apr 2025 08:12:13.9072 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: uBZblaDRA0gHEiNS4q9oZzUKz37fLJLfIHrfCYp/3CREJyUeKqD2RuaK9Q4v/lFw
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4327
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

[AMD Official Use Only - AMD Internal Distribution Only]

Sending a v2. Please ignore this.

Thanks,
Lijo
-----Original Message-----
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Lijo Laz=
ar
Sent: Wednesday, April 16, 2025 1:35 PM
To: amd-gfx@lists.freedesktop.org
Cc: Zhang, Hawking <Hawking.Zhang@amd.com>; Deucher, Alexander <Alexander.D=
eucher@amd.com>; Kamal, Asad <Asad.Kamal@amd.com>
Subject: [PATCH] drm/amdgpu: Disallow partition query during reset

Reject queries to get current partition modes during reset. Also, don't acc=
ept sysfs interface requests to switch compute partition mode while in rese=
t.

Signed-off-by: Lijo Lazar <lijo.lazar@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c | 10 ++++++++++  drivers/gpu/drm/a=
md/amdgpu/amdgpu_gmc.c |  4 ++++
 2 files changed, 14 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c b/drivers/gpu/drm/amd/=
amdgpu/amdgpu_gfx.c
index 2c933d436e56..f21051b82ad4 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
@@ -1353,6 +1353,10 @@ static ssize_t amdgpu_gfx_get_current_compute_partit=
ion(struct device *dev,
        struct amdgpu_device *adev =3D drm_to_adev(ddev);
        int mode;

+       /* Only minimal precaution taken to reject requests while in reset.=
*/
+       if (amdgpu_in_reset(adev))
+               return -EPERM;
+
        mode =3D amdgpu_xcp_query_partition_mode(adev->xcp_mgr,
                                               AMDGPU_XCP_FL_NONE);

@@ -1396,8 +1400,14 @@ static ssize_t amdgpu_gfx_set_compute_partition(stru=
ct device *dev,
                return -EINVAL;
        }

+       /* Don't allow a switch while under reset */
+       if (!down_read_trylock(&adev->reset_domain->sem))
+               return -EBUSY;
+
        ret =3D amdgpu_xcp_switch_partition_mode(adev->xcp_mgr, mode);

+       up_read(&adev->reset_domain->sem);
+
        if (ret)
                return ret;

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c b/drivers/gpu/drm/amd/=
amdgpu/amdgpu_gmc.c
index ecb74ccf1d90..6b0fbbb91e57 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
@@ -1230,6 +1230,10 @@ static ssize_t current_memory_partition_show(
        struct amdgpu_device *adev =3D drm_to_adev(ddev);
        enum amdgpu_memory_partition mode;

+       /* Only minimal precaution taken to reject requests while in reset =
*/
+       if (amdgpu_in_reset(adev))
+               return -EPERM;
+
        mode =3D adev->gmc.gmc_funcs->query_mem_partition_mode(adev);
        if ((mode >=3D ARRAY_SIZE(nps_desc)) ||
            (BIT(mode) & AMDGPU_ALL_NPS_MASK) !=3D BIT(mode))
--
2.25.1

