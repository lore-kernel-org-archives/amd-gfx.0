Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7BDFAC4332F
	for <amd-gfx@archiver.kernel.org>; Wed,  8 Nov 2023 13:48:55 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0945110E759;
	Wed,  8 Nov 2023 13:48:55 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on20625.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:fe5a::625])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4F1E810E75A
 for <amd-gfx@lists.freedesktop.org>; Wed,  8 Nov 2023 13:48:52 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bdGSru9Nd8aOxb33yDyd+rCXhmLK/enPNsx7SopDk95uqTC44bdhmrIvYN87G7tC5AY75aT+7qBem55C70uoi7bDjaG74SU1CdlYZn0inZhm2lQntPP99HAAEW0tbn/BSoA9u1pS8sylkKVA4PQJ7XClZJLMj3LuarkNiBYKOPZrEijp5FW44ScHF/FVcoZ+hrw0+SOGbtir6RVJZn0m3mCr8htDguniYBbWExAeKTQs+XveOco2AxHt488so92YhHfyFXgFUyPM11ZCXuKQqiw/yJIvmWjNcYZ4EkoDhVsQGuF3Lx0w9L7UYTLEpbnaxZxrUT56EoBSg1E7VyQeDg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DngQ6gB0h1Ece9Ln5lUGLViQ4z6PK8L4Y2L1Feace+c=;
 b=CtcaYrSFTU8lUWBbWJ044YqL1+IqeKoqJpKDap7BbO1BZnsmc5UIOk5iGps2oGwF8Ck9tOzc9YSzV1Yb0tYJv/Ed83BMU2d01nwK/XdyyGLvuethtYPwpbT3Mef2OprdUouGewNM36N9q4FE5I80JTyhMjyIB6zMyMQO+Nmu/U0vCuig3AMy6QfZeie+WOVMeI/zt8eTzU3SEzr0JKK7uK9q0S6ThduBbKG3BTfEjfIJl1jF3FIvvnLnaGTrylnLhtCKSvBHi7P1b7CjY+a9dr6SAt3nVmPM6ZWMibb7Owob5nkjf12o4LouZ8/CT1qlo8B/xh48sAqpzDAUsu8Ztg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DngQ6gB0h1Ece9Ln5lUGLViQ4z6PK8L4Y2L1Feace+c=;
 b=VZOv5Sz6zfWlEhUrs5HbMalXmk8CQZ8Oyuk2cgwa/5NB3sFtOpjKV+214FHzVEG2C2E17aUOhKyabIrGdfHY6nikgSNcWTla7msilxJqMiEWKqohM+qJCgkXms2GSxMeLagjbbAgVy1qqLmRp5ZgA7yru8NnqIHYcnqKLsV0AEE=
Received: from PH7PR12MB5997.namprd12.prod.outlook.com (2603:10b6:510:1d9::21)
 by MN6PR12MB8513.namprd12.prod.outlook.com (2603:10b6:208:472::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6954.28; Wed, 8 Nov
 2023 13:48:49 +0000
Received: from PH7PR12MB5997.namprd12.prod.outlook.com
 ([fe80::ca1f:8b18:846d:234e]) by PH7PR12MB5997.namprd12.prod.outlook.com
 ([fe80::ca1f:8b18:846d:234e%4]) with mapi id 15.20.6954.028; Wed, 8 Nov 2023
 13:48:49 +0000
From: "Wang, Yang(Kevin)" <KevinYang.Wang@amd.com>
To: "Wang, Yang(Kevin)" <KevinYang.Wang@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH 6/7] drm/amdgpu: correct acclerator check architecutre dump
Thread-Topic: [PATCH 6/7] drm/amdgpu: correct acclerator check architecutre
 dump
Thread-Index: AQHaEkNAvq8jDP8tI0uSQG9DcSFxbrBwb+Uw
Date: Wed, 8 Nov 2023 13:48:49 +0000
Message-ID: <PH7PR12MB5997B9635BC239DD8613E15982A8A@PH7PR12MB5997.namprd12.prod.outlook.com>
References: <20231108125735.2497856-1-kevinyang.wang@amd.com>
 <20231108125735.2497856-6-kevinyang.wang@amd.com>
In-Reply-To: <20231108125735.2497856-6-kevinyang.wang@amd.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR12MB5997:EE_|MN6PR12MB8513:EE_
x-ms-office365-filtering-correlation-id: 19c8d95b-b539-4d3d-823d-08dbe0616fc4
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: tja1azJeC8fEoqDiM+yKmMCBI7FdhU7gyUx+p/Q90hlL9KhREb+P9Ksjr81hA0H3DEEIGW62+YrXwgW4E6N1Or11rF7FAkFvF04HZNqA34a+h0gSaPEJH/AZ9C5U/6OzItcda8nndyXKBMnsX9Ormc23WcxED9IlmdZS7choYi2/v9lP0TsUlyuDyiPakosjiBBd8quWT1GdjI6xXXsKrhEhOzmPpCrc2xikre493TRBTr3psh3VIGBrosdpfqfiqlKcTdLPgB9b23weLyuDzDuUWCFotihL6dGVk3pNC++30Z2Suyget6yiu4ZtvYcXnsc7XbN6GIbRDSC1GECtXxZCspbWA8Siuzkm3xLj5dhEqcfw76WYu5AION+1YiXURMfw4eFz8B2SMpz8nF/Z4QOFhZSrAWv/WJRZ34pHdJl4uBDwTml3B9Z4BFP1zKnpw16K3ZrtKi9vZuHE9wTPrQBJNBP8kJEZuzLXnkTc6JpqUip+YePbivt/rqXTyXG3CXuoMlvufOFzjOlnc4HOO1ssRjHNMas9v1Egfgyoo8XvpqT2vaMp77hJ2Z9YQV1/LBWP+zuIoIfgb8/d9iG6WNS2xcdlEYbAunHLd4BopQAFbBdcfmF2quA7hMNxENbH
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5997.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(136003)(366004)(396003)(39860400002)(376002)(346002)(230922051799003)(1800799009)(451199024)(64100799003)(186009)(55016003)(2906002)(5660300002)(4326008)(8936002)(8676002)(86362001)(38100700002)(41300700001)(83380400001)(33656002)(76116006)(9686003)(122000001)(52536014)(316002)(110136005)(64756008)(66446008)(66556008)(66476007)(66946007)(71200400001)(7696005)(6506007)(53546011)(38070700009)(26005)(478600001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?UQsgqEuw8s6kWE6nzcXomee8MhONxWVDEpn2Sw/qJG/CsPBAot+xAUG+Gpxr?=
 =?us-ascii?Q?/Qaby9nSU1RjqPPg5LIWtrSoA/M7V7uazS+WApQ3FdBt31alGgOCz1f24LBP?=
 =?us-ascii?Q?Ig54dq5W3Hpt3GtBa5urzANy26keaV47dku5FyS3sMgGoxerX/VKP+2AQprk?=
 =?us-ascii?Q?kAdAUvPyIo3BymT72xHlBUuI0USo6XN3RlLvEvld/faiwKJkZaLq77peZZAz?=
 =?us-ascii?Q?uobX0LXZ7oXXPyB3BnQv5GhcUDv8aF9yNPklvoOpcRQCEqKGzd/Fu1PoWYaY?=
 =?us-ascii?Q?6zwAQ6bK0xm1WPE2SyQnzGScgEd55jnToA+FhZd7dePeOlFT2kffxVjZMwt+?=
 =?us-ascii?Q?Kqs6ixWH1gS6Wn+dMcFp9NxrBVlp4RSFoKB+6RVPNvZYMYS7ahMX/emUcOhm?=
 =?us-ascii?Q?9SBd5OOFBVKo/AzB7btQFGmFj9wEZhWEV6nDQVeylih10qnGxTYq0cMFBU9h?=
 =?us-ascii?Q?zJM3VHCxbmeGy05kFNRPkN+sw3+3M2vuKbNTuXrk/e4HNmXYWuB+WF0Ra3+c?=
 =?us-ascii?Q?XqwTaf2Fjo0+AReZ8B8rY/YHSCByJ5KfqgK/7ylNwNhMtD2DegrCJkko6gzY?=
 =?us-ascii?Q?GMwjAMFB4D8irZhM1ghGUDyxjEOMcXptd8DnldNgUQpI+BP1T8po5nIUJGmQ?=
 =?us-ascii?Q?ugKT4548wjIUgqQ267N0hYeDTi4PbGgIYJCrTjFlXPzNmZnZXShSku0AhHaZ?=
 =?us-ascii?Q?Lv8RSXTPwOio1UwFUbZk8OMuB3NwtWrDi3DGH2IpHNRwyG1WA/cBbCrIH6CV?=
 =?us-ascii?Q?03Z2PStlELpbPrUNZw7ibkTZKaVcdqfcydDRTehn+wi2XUAslaAjZVRa3C6o?=
 =?us-ascii?Q?x7C2H9vm76yfDq0PCBhcbMdIek5jzFQFS2qqEwEiDnvlYp/mMg/4eDNgsG1g?=
 =?us-ascii?Q?v+63H0MlmgWyfem1GGbiYTLCMdQ492a9+HRJOdT2ZHYhuTCPSFF9m1NMP5Bx?=
 =?us-ascii?Q?BruOMXlHCII+k9Ehvf2XQhUsmTiUqXgupS4I2eR7ITjtukCT3hjwJtJy5fLF?=
 =?us-ascii?Q?xtfN3g4zlSqNmzgRlTtMxzT95ftV/kV7vjXRwdpdgBnt+Oo4x081L+7UgwiK?=
 =?us-ascii?Q?c/h561IZJ5FJ3BuYvKoK91ZCJ4WzJz8nuV6H3e0NUyBkeIEKnAkc3mabjvVZ?=
 =?us-ascii?Q?BLUID6MmiPu/sfZqiGWAjbgRFkNlflbM/l5daFonDbdTNWpHYXia59lr66D6?=
 =?us-ascii?Q?dVx9ERON8wZjj83XQI5bJvV5w3SILDLjGecwNB3VekgoNll6zdnuE5qN5/1G?=
 =?us-ascii?Q?CxGHc6zrRn0RDlDH2s9yXIj1Ph+QLrqvz4BmXBLsLxyAlAjIKcFtKeBjNemZ?=
 =?us-ascii?Q?JOcVtFVK+cA6OeVAY8rgjr7DkrA3edRmoyIr/Kc5xP+NUjX0eM5PMlbADrhQ?=
 =?us-ascii?Q?zZQvlZZPx3YClUI/4p6pgF85CQMuSmWlWdVQP/5diMitUm+LW3Sbxa7SeOoi?=
 =?us-ascii?Q?RAdGqnV/Hdh4byghKpieuBjOiaQQwSjibYo84bu4FG7pNGjr/UzPw6qIdAl7?=
 =?us-ascii?Q?WBPtReWFi9VJgj8+UPGbhW/WMNR3StV7AYRqEpl42lpW6K/kb3T3dS0k7xKL?=
 =?us-ascii?Q?npa576oRU/jvRwXelQU=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5997.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 19c8d95b-b539-4d3d-823d-08dbe0616fc4
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Nov 2023 13:48:49.4424 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: S+k4U5luDCbOJubQrL+ITkD1aKEDb+GNm5378FmeW60845PXwGvcfhh+zDocbpOD
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN6PR12MB8513
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
Cc: "Zhang, Hawking" <Hawking.Zhang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Reviewed-by: Yang Wang <kevinyang.wang@amd.com>

Best Regards,
Kevin

-----Original Message-----
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Yang Wan=
g
Sent: Wednesday, November 8, 2023 8:58 PM
To: amd-gfx@lists.freedesktop.org
Cc: Zhang, Hawking <Hawking.Zhang@amd.com>
Subject: [PATCH 6/7] drm/amdgpu: correct acclerator check architecutre dump

From: Hawking Zhang <Hawking.Zhang@amd.com>

So driver doesn't touch invalid aca entries.

Signed-off-by: Hawking Zhang <Hawking.Zhang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_mca.c | 15 +++++++++++----  drivers/gpu/=
drm/amd/amdgpu/amdgpu_mca.h |  2 --
 2 files changed, 11 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_mca.c b/drivers/gpu/drm/amd/=
amdgpu/amdgpu_mca.c
index 3302f4a29387..65926f3c708a 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_mca.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_mca.c
@@ -202,10 +202,17 @@ int amdgpu_mca_smu_set_debug_mode(struct amdgpu_devic=
e *adev, bool enable)
=20
 static void amdgpu_mca_smu_mca_bank_dump(struct amdgpu_device *adev, int i=
dx, struct mca_bank_entry *entry)  {
-	int i;
-
-	for (i =3D 0; i < ARRAY_SIZE(entry->regs); i++)
-		dev_dbg(adev->dev, "mca entry[%02d].regs[%02d]=3D0x%016llx\n", idx, i, e=
ntry->regs[i]);
+	dev_info(adev->dev, "[Hardware error] Accelerator Check Architecture even=
ts logged\n");
+	dev_info(adev->dev, "[Hardware error] aca entry[%02d].STATUS=3D0x%016llx\=
n",
+		 idx, entry->regs[MCA_REG_IDX_STATUS]);
+	dev_info(adev->dev, "[Hardware error] aca entry[%02d].ADDR=3D0x%016llx\n"=
,
+		 idx, entry->regs[MCA_REG_IDX_ADDR]);
+	dev_info(adev->dev, "[Hardware error] aca entry[%02d].MISC0=3D0x%016llx\n=
",
+		 idx, entry->regs[MCA_REG_IDX_MISC0]);
+	dev_info(adev->dev, "[Hardware error] aca entry[%02d].IPID=3D0x%016llx\n"=
,
+		 idx, entry->regs[MCA_REG_IDX_IPID]);
+	dev_info(adev->dev, "[Hardware error] aca entry[%02d].SYND=3D0x%016llx\n"=
,
+		 idx, entry->regs[MCA_REG_IDX_SYND]);
 }
=20
 int amdgpu_mca_smu_log_ras_error(struct amdgpu_device *adev, enum amdgpu_r=
as_block blk, enum amdgpu_mca_error_type type, struct ras_err_data *err_dat=
a) diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_mca.h b/drivers/gpu/drm/a=
md/amdgpu/amdgpu_mca.h
index 45f90edf2283..e4f30d20170f 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_mca.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_mca.h
@@ -79,11 +79,9 @@ struct amdgpu_mca {
 };
=20
 enum mca_reg_idx {
-	MCA_REG_IDX_CONTROL		=3D 0,
 	MCA_REG_IDX_STATUS		=3D 1,
 	MCA_REG_IDX_ADDR		=3D 2,
 	MCA_REG_IDX_MISC0		=3D 3,
-	MCA_REG_IDX_CONFIG		=3D 4,
 	MCA_REG_IDX_IPID		=3D 5,
 	MCA_REG_IDX_SYND		=3D 6,
 	MCA_REG_IDX_COUNT		=3D 16,
--
2.34.1

