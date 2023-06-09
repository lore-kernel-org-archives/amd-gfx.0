Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4BA72C7EE23
	for <amd-gfx@archiver.kernel.org>; Fri,  9 Jun 2023 03:26:10 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A2F2E10E0AB;
	Fri,  9 Jun 2023 03:26:09 +0000 (UTC)
Received: from NAM02-BN1-obe.outbound.protection.outlook.com
 (mail-bn1nam02on2086.outbound.protection.outlook.com [40.107.212.86])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5D95410E0AB
 for <amd-gfx@lists.freedesktop.org>; Fri,  9 Jun 2023 03:26:07 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Mfz8ntUlbBK79oQ7C46Uiqm8Jh6tq+QtNX83c3QQuSvUcE7qNqcPO94PWsL4d5zcQ8Y+/CVa5oLlc1Qg8mniv3cJs7E+7cQGs3l6wK8QnIHTw+aHQW+WytUf1DgqUUZtosLz6uNR8+CeudxHEmh5s7m9IZANgn6PF1Zpd8R+7imLw7FEuQpGUYa6Bj19aXa5Q1AUS4CbUhqgmtQ2eY7rMaYoTK1rNRzxAVl2RkHiPnP2ZBykSNdyEWb1Fiy6ChXew7+wIkX2en/GDhIdZt2zQZMNGpNgRm+9YqUlYLRPbjRq8WCnKEQJYbnvPg+5inxEX0I9nH0/4AMqx4ZfNa1SUA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FmwqM2yV3tLFml5tRpG41aeiRMgSWAMCKgqWpMIDTEg=;
 b=SgotfIhk48uwfjhTx0AVs0ckQsarG6o5FdelI5RiMXa1LfEnKW2Upyq9d6QmesaB7MLUPc5EkPDeOER1NtQtARdaU5aYXwx87rZt2PMprruw/zU4RmLjUZkSYOhUcvxu9sRJcKj7IYLKputicVw3OtzF1duc6rt7hhcdUB4h3bbrItebOmU/g/iFLAgmA52uSqSzMVAanMR5NK4WpVv3rE3FXY0X3f/lPjyEKhYD73v/e6nakpBGhWFsQRdH5DJ9kDnM35AittxGpnPe6xeCoH0za5DtlV7TRJe7vF3Zrxa63sparHMgST2qKqZmhKUSLkkfa94z8mAG/2aBl2K3VA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FmwqM2yV3tLFml5tRpG41aeiRMgSWAMCKgqWpMIDTEg=;
 b=r//5y7NzRGft9CeZUXwieY+W3WiKYCIdXuaILuBqbOVXTrQYMeDMphMpsN7lxB9QkK2Y4+UF79hqiWUGLHti29FQU5bzxvEQBzGfJKIxXXMGuIRIwnNVRj+ViKoW83VemDT3DquLo1FENpbTVcpKA6u4Bf+TN9d0d6eoRJgaP7M=
Received: from CH2PR12MB4152.namprd12.prod.outlook.com (2603:10b6:610:a7::8)
 by DS0PR12MB7971.namprd12.prod.outlook.com (2603:10b6:8:14e::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.33; Fri, 9 Jun
 2023 03:26:04 +0000
Received: from CH2PR12MB4152.namprd12.prod.outlook.com
 ([fe80::635a:9689:10d6:36cb]) by CH2PR12MB4152.namprd12.prod.outlook.com
 ([fe80::635a:9689:10d6:36cb%6]) with mapi id 15.20.6455.030; Fri, 9 Jun 2023
 03:26:04 +0000
From: "Xu, Feifei" <Feifei.Xu@amd.com>
To: "Feng, Kenneth" <Kenneth.Feng@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amd/pm: workaround for compute workload type on some
 skus
Thread-Topic: [PATCH] drm/amd/pm: workaround for compute workload type on some
 skus
Thread-Index: AQHZmn3s4GfEaBFJQkGW5C4LaODgxK+Bzzag
Date: Fri, 9 Jun 2023 03:26:04 +0000
Message-ID: <CH2PR12MB4152FD34A38545FC68B79735FE51A@CH2PR12MB4152.namprd12.prod.outlook.com>
References: <20230609025544.4179487-1-kenneth.feng@amd.com>
In-Reply-To: <20230609025544.4179487-1-kenneth.feng@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=e9bd1e14-4a09-413c-8f66-b983453f4fba;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=0;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2023-06-09T03:25:53Z;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH2PR12MB4152:EE_|DS0PR12MB7971:EE_
x-ms-office365-filtering-correlation-id: 3a44835a-45e8-4ed8-7762-08db6899419e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: cWpbiE0iIaKn6OQs8oZhYv+RcH2a7renBwTSXdm0Iu/nr0PvMOLS1ysHHEFd/0Ail7mzg86+VQqheOmFBVtwih7Utz0/DXI/i11yTzF4eYna9GJYi+y/qpG9oNyMdbXhKhigQdMINwFSvR1kudhhdX4EoVQPam+8nZveDxzfHTs+FutmgmAo41ezpZu+yDjaJ3Eg3mzySg6YdZdSIqn2yAVK2jyUJSx5X1NE9ln3+0FkUzqxr5L38tHXStd5JCmKY9YFdp6GtVxk8InW3gjSi0UXuDnZOaHNBNFCJlKy85I+G4+ndQCnU8E1Lz/HE4kdb4OqAp8LxCB2Tmz+qEa2NlHINFYKzHXyCBTiw+3kN7uxYM7Nqbn9NC15BtBQ54AmpeEc/96It5KE+CMpy2q2FMpqMjrCLhazcHm+LcSYoF1O8X0CVjF0q4zAJAuq6H2oo2ukabq66buKZMUm+U7o7ww4d+MgSGAH/+5QyORdL4hLri1qLauMhqTQ4mbx10hgOb7f0lhj/cwD5OmuUIxQXRV+phyvXN6wwHrGDraNwpNrqm7DzblmxN7d5uEb//m2xW4m75nr3/F6ijVIxbixMHwOGV4oaq2kfrA3wKYOFY+zOxCxVnRQL7k6NmOxoaY7
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH2PR12MB4152.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(4636009)(376002)(346002)(39860400002)(366004)(396003)(136003)(451199021)(478600001)(2906002)(38070700005)(83380400001)(6506007)(186003)(26005)(53546011)(9686003)(86362001)(122000001)(33656002)(38100700002)(7696005)(55016003)(71200400001)(5660300002)(52536014)(8676002)(8936002)(41300700001)(66946007)(66446008)(66556008)(64756008)(4326008)(66476007)(76116006)(316002)(54906003)(110136005);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?UsgDRGZVmAFKSAKsBAmgT39ZX0ewtiEXOn2Cbv940LuVf8jlME2wouakUwTJ?=
 =?us-ascii?Q?6KXV/RlSQ7MNKC259ZrcK8TF21892uJlW2+qDC5BaOgnhpAD5CL0a0EoqdoC?=
 =?us-ascii?Q?r/ObJy/X/NAE4abINXJKGQsj/74erE6kDQoGwhkL3n7q3VqQ7aT0ry4CDPzy?=
 =?us-ascii?Q?5NCYXtaLkIUuAXvPVIXeFY049j64S4+r+kdLfJktd5sSrxnboTOLsL4dFPnp?=
 =?us-ascii?Q?85SAaAfTXnWW/W3PoEhjjD3IVmUwai3OvdLUMyEBTQ2pPPWaOh6fyXLtib4k?=
 =?us-ascii?Q?WE3qRYkwk2xaN7V8CRBZgBFvJ0fsg9nxr3Kz5GPEEsNpMO4PbOvx2cFfUdQl?=
 =?us-ascii?Q?WicCL5IR1b0VEy0mVa2qZYyw/a7DmgIhpwt7pZUUWAEFz6s5VRKny9ixiezi?=
 =?us-ascii?Q?D7K4y1RmVpww5pTwTpt3wMMHsKSPZczTWQbuvfVkUJEL9XB49KmtOeDoBaYJ?=
 =?us-ascii?Q?FRjIc9TXmmGN7UIVSMJj1bCAR54I3W/e/fS8hDUmjYJGg9OJqGzWIinvDkOu?=
 =?us-ascii?Q?Ih42EUQXj/Z29PhbnE11KLqVWAyI5HMTbpqWUUwj4T1WPXgzpWCp42OCJKd/?=
 =?us-ascii?Q?j04BeTqoCPY6c7SBwwHMkzKe9Bq/KKmg6QwgNurdT/6jZFyqutN+u4iqMo6P?=
 =?us-ascii?Q?ibRY8I8uO9rbRL5qIxTrtayt9flxl5Y0kvk1vtRzfKvxcTjsRzSYITD/6Ia2?=
 =?us-ascii?Q?Oh3UvNVyKPvqJZI0aiIFD4ksPNxgiNTf4X3jLFXZlzTqwGNSWPgem+mqHkAj?=
 =?us-ascii?Q?7rKUnEC6nMk9aYDnNmoQ+qNiRlqliEbWm7RrGA6LZF+khQll+bLM05TZwMeL?=
 =?us-ascii?Q?e9NHFkwV+i0fu93lVznR7oDw0ltAPnuTeFkD7WZ+cXlUeZ8LmjAwJBEHj8N1?=
 =?us-ascii?Q?owHIYzGtOrhnE5BSxnf5KhjE9+WWDR9lG+O9X0A4u2moZieuEEm8GazFgvgK?=
 =?us-ascii?Q?B7NhdF5da4VtprqjdNtMOpAhWMqW9Py4r19HZKCduAs+qApTm0YHbOxYHW76?=
 =?us-ascii?Q?b3qsnDOM+EyK6J1l/q29EhHt6CJc7YVw+LM9TCVt4D+nlCzekDxBySWT5XYB?=
 =?us-ascii?Q?EuT3JPud28VBeRVGICqDboSVSqY6UiDzhHOR6QV1KfnCJ7bS/va2lnPAn9un?=
 =?us-ascii?Q?rIHWvEjm2DqthRJ9quxcxEnPhWGsG1QhFTkevEuMZr3r67Q/EA4PCZLPILl7?=
 =?us-ascii?Q?NrlVd0eT96O8ylh721pDaQNXgCRRFzIVQFNNu4dzMAsEByyN/gFpB+Qczd9Z?=
 =?us-ascii?Q?BWifU0CgL4V/SUxbWsGeWvEHnxwO4lrcFXd5KBAmSkB/CD96T8gSdSXAbwrL?=
 =?us-ascii?Q?UUQE65snOy3iDh108zgLmyqMJAYl6dHoAgFX/GiNQEvfkqsMACDveX3w2Pvb?=
 =?us-ascii?Q?HotfB4QbtpnzOVyT0m5MZxVUu2/qVHXtEAxcatCUq1tWrben1DFP58yVobqv?=
 =?us-ascii?Q?tWxL+CpMLsqHrGOR5S5Uk66y0EamumZbqPllJBof95U3CCRv8YrYI9aGcrNa?=
 =?us-ascii?Q?SMlNU0Wwh/l8X/qXwyv+VfsgIjswnv70DSjMuX/H/u4jyfB5Au7l9X7zlyia?=
 =?us-ascii?Q?PVMMryvt6Yo9PigKeRI=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH2PR12MB4152.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3a44835a-45e8-4ed8-7762-08db6899419e
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Jun 2023 03:26:04.3109 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Cqn/4NS9yqHhzQulgX9P4mBjOEsDtjMeGdWBM+r6a/m8nyiW445439accVmwOBCz
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7971
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
Cc: "Quan, Evan" <Evan.Quan@amd.com>, "Feng, Kenneth" <Kenneth.Feng@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Official Use Only - General]

Reviewed-by: Feifei Xu <Feifei.Xu@amd.com>

-----Original Message-----
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Kenneth =
Feng
Sent: Friday, June 9, 2023 10:56 AM
To: amd-gfx@lists.freedesktop.org
Cc: Quan, Evan <Evan.Quan@amd.com>; Feng, Kenneth <Kenneth.Feng@amd.com>
Subject: [PATCH] drm/amd/pm: workaround for compute workload type on some s=
kus

On smu 13.0.0, the compute workload type cannot be set on all the skus due =
to some other problems. This workaround is to make sure compute workload ty=
pe can also run on some specific skus.

Signed-off-by: Kenneth Feng <kenneth.feng@amd.com>
---
 .../drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c  | 26 +++++++++++++++++++
 1 file changed, 26 insertions(+)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c b/drivers=
/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c
index e2265f50bacc..6e8acd021ee6 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c
@@ -2179,6 +2179,32 @@ static int smu_v13_0_0_set_power_profile_mode(struct=
 smu_context *smu,
                }
        }

+       if (smu->power_profile_mode =3D=3D PP_SMC_POWER_PROFILE_COMPUTE &&
+               (((smu->adev->pdev->device =3D=3D 0x744C) && (smu->adev->pd=
ev->revision =3D=3D 0xC8)) ||
+               ((smu->adev->pdev->device =3D=3D 0x744C) && (smu->adev->pde=
v->revision =3D=3D 0xCC)))) {
+               ret =3D smu_cmn_update_table(smu,
+                                          SMU_TABLE_ACTIVITY_MONITOR_COEFF=
,
+                                          WORKLOAD_PPLIB_COMPUTE_BIT,
+                                          (void *)(&activity_monitor_exter=
nal),
+                                          false);
+               if (ret) {
+                       dev_err(smu->adev->dev, "[%s] Failed to get activit=
y monitor!", __func__);
+                       return ret;
+               }
+
+               ret =3D smu_cmn_update_table(smu,
+                                          SMU_TABLE_ACTIVITY_MONITOR_COEFF=
,
+                                          WORKLOAD_PPLIB_CUSTOM_BIT,
+                                          (void *)(&activity_monitor_exter=
nal),
+                                          true);
+               if (ret) {
+                       dev_err(smu->adev->dev, "[%s] Failed to set activit=
y monitor!", __func__);
+                       return ret;
+               }
+
+               smu->power_profile_mode =3D PP_SMC_POWER_PROFILE_CUSTOM;
+       }
+
        /* conv PP_SMC_POWER_PROFILE* to WORKLOAD_PPLIB_*_BIT */
        workload_type =3D smu_cmn_to_asic_specific_index(smu,
                                                       CMN2ASIC_MAPPING_WOR=
KLOAD,
--
2.34.1

