Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5DA78C3DA6E
	for <amd-gfx@archiver.kernel.org>; Wed, 10 Jan 2024 10:57:51 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E0F3310E5A9;
	Wed, 10 Jan 2024 10:57:50 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2079.outbound.protection.outlook.com [40.107.223.79])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 61F2310E5A9
 for <amd-gfx@lists.freedesktop.org>; Wed, 10 Jan 2024 10:57:49 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Z7Vehs55594WjM9GN4/7i6lON7LkhhXrmoG7Uf0p8URrvkX6W6xAuBaOFgk+p0+DHs05dzSpTF401lZMpUDf+ZX368VoK3HAPowl+L0F3bUOUnK4mwTxaHOSeOVKGBus9HDPO84o596P9JvH3MmqTvym9zP5GSJalojL92flbXK6dNVNunDfCSUNsEBPkLeW/0f0NlmTPKEboZe8mwD/MSy5Z66XERZIYInX6Ms6SnSeFqvGCTWpSdvE+/WS2pho+sikU0NMXm8d4ZIjZ/AqN3Xm/1HDLe6IABrPd1brf0qvWA9oB6vii+MB082klCn7eIJDnNQwnpOZciIgUMEdSw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ka7RpHmXEXqAsX8AtvwnknYq75LOCOG355IeyyBMS0U=;
 b=RVBZnhz0xlM/wg3qQDDdDTeSIyOmQJQDe3NFXzBQLGmd2C+HfdFmYSEheaAPVCBIFwBgkYVslAv+/+SnFvHUrmT8gNVWbKTUQ0TMpePQHaOYWepdCFPK2KQa304O9YXCf7V2uzbDEggoey5/lWAFu+HbMhlZ5d4uwb4HPCnTn0VTn8iZFtwzdEZ1USJ3gHms26Kp4Rok3QqYVRYgKTGfuYsNQtH5lKpB9aVF7ir0CBTSnTMFWbA3BqYU88lSRs5/3ehobCkLJKIRV1U1PXY1oBxOB9bUL4mS+iIJKGNtuQUTpNHqB4eNJSXEdjYy8Ioj+ULBLU/wU3Kd1TpJuhoBNw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ka7RpHmXEXqAsX8AtvwnknYq75LOCOG355IeyyBMS0U=;
 b=O2fxyGDx/eWfkcgP5OjIB8A7GSnRBqxLETkxyGQ9OcGqz2nnYtrqPNOOovrS+O0mF4t0Y0nvWL0s2oVGIe+F9KAuYT9zeNVpfuqs4QBQyiT1RBWvCUddYkWPVHdZT4cfcg3JA+SXQbj7bbzyVWZbbNUXrxAaWjuyUI82QCu2LZ4=
Received: from BN9PR12MB5257.namprd12.prod.outlook.com (2603:10b6:408:11e::16)
 by SA0PR12MB4368.namprd12.prod.outlook.com (2603:10b6:806:9f::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7159.27; Wed, 10 Jan
 2024 10:57:44 +0000
Received: from BN9PR12MB5257.namprd12.prod.outlook.com
 ([fe80::7ee2:4db2:1828:ba83]) by BN9PR12MB5257.namprd12.prod.outlook.com
 ([fe80::7ee2:4db2:1828:ba83%4]) with mapi id 15.20.7159.020; Wed, 10 Jan 2024
 10:57:44 +0000
From: "Zhang, Hawking" <Hawking.Zhang@amd.com>
To: "Li, Candice" <Candice.Li@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH 2/2] drm/amdgpu: Do bad page retirement for deferred errors
Thread-Topic: [PATCH 2/2] drm/amdgpu: Do bad page retirement for deferred
 errors
Thread-Index: AQHaQ6COb4Gb3xmKUUKdyv7m/3kwVbDS3fSw
Date: Wed, 10 Jan 2024 10:57:44 +0000
Message-ID: <BN9PR12MB5257F0C8622376B4FB98E182FC692@BN9PR12MB5257.namprd12.prod.outlook.com>
References: <20240110083856.412858-1-candice.li@amd.com>
 <20240110083856.412858-2-candice.li@amd.com>
In-Reply-To: <20240110083856.412858-2-candice.li@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=8836cd97-217c-41a9-b39f-f8538ea82e81;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=0;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2024-01-10T10:48:54Z;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR12MB5257:EE_|SA0PR12MB4368:EE_
x-ms-office365-filtering-correlation-id: 55b57b81-0c13-4245-1b70-08dc11caf98a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: X74GwdY7w2vH05vk+Cntt9cOtP48v7lw/mpimGMLBdRYtjo2QkJ01MhM3sXfzVOt4P0miNnB9/fjJ+y+P+bzRdwf39bfMOoH4FCgcM3ywFrJdbr8KrlhxT3+zibyPeqhy+S2m56cE1GNK07tP2/9LrayRNAXOfKYDXsqzj4m8D14cxNQNyqe+uh7cD3igbbdedvwzcBP0q3Q6QT4yhfj2f0cDctS3xjbFaCqsOLWSoWgZn3WFgzJQ3vnwETSNm2RIVjs5cEt9V/xw/X52ZuPzmEZhxwj2jbLHPKJPhvK1sgMy6wTrrkqHX9ci5raDRyD7pBaM7v3+2PTAMXZx4jKmEm/pTnhVcVp9y0+tUWINnNLthfXz82tplCqgHB4OpIAeGI0jGC4COSYbT7qUd3R/+CvOyMPcWnyOCNX/lAKiFAHna/s8qFlIbhDVQMyp4QYfTcmBbQ880GFjiFi7IhKb50N/Pml7wQlenYz8Je2Ih6yaJ3YSQ2dfaplH71bz3XLYIsRCJLRbXBiBehUIIvJVkZuaB4s0gWBETSvNC0u5bBMwIyGxRtnYcvchWLXlJzcQ5fn+n7G2R7ydbXn36SN4HTupzJrJb7bco9l8bT4CaTT+ZQ74S29xI9EZ4lF52is
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5257.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(39860400002)(376002)(136003)(396003)(366004)(346002)(230922051799003)(1800799012)(186009)(64100799003)(451199024)(76116006)(66476007)(66446008)(66946007)(66556008)(64756008)(26005)(110136005)(316002)(71200400001)(8676002)(52536014)(8936002)(4326008)(83380400001)(55016003)(7696005)(6506007)(9686003)(53546011)(5660300002)(2906002)(478600001)(122000001)(38100700002)(86362001)(41300700001)(38070700009)(33656002);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?sWNrmVgabb3mhgRCMbWuJr6Y07TN9RtWtDuZPG4HekywWg8yqajCFXjIdBq2?=
 =?us-ascii?Q?iWleKg09k/QqPFBPhNCP53Yq/kDmq7gEpT6ptB15Gnj05m+zssLVd8FC9pvi?=
 =?us-ascii?Q?mgLOpRmcwWuVE2TCIDtEhxLRbt1Ph3of8SK6Q8+xaAy7SLPfuvCBc7k0ZLB4?=
 =?us-ascii?Q?ImnWSNihh+XcQ99sFAqdC+CkzX08j+wMXkfGSpopklju5VMsDB3s+6k1GWzv?=
 =?us-ascii?Q?PMBzDONvdl6Cf4lOvYL0zdr+S/P9ltfBoL7DxFje3utktXLjLxpP4lliDnYp?=
 =?us-ascii?Q?JVNXi8aXW87+on5oozyd5BBfdij/OUSCWcGC8bfGP1S09kMW+RuROsCfN9Z1?=
 =?us-ascii?Q?XX6+jawiAX7cVzeLj/Kc4nnGmRhqH1Jv/rn03WfwTCHDBSodujKg7TpPD9u8?=
 =?us-ascii?Q?r2qi2JCb408PrxOhWsVJQqDhWJUk4znw2g0itva8pMl07Afioiwg2kysbfig?=
 =?us-ascii?Q?fqlkEnE5colL6RU1zEA7/5x+uWsmJ/Y4eJzMDDOsgxzvRrLtBiL5K0LtfSMy?=
 =?us-ascii?Q?bNssb/FVc1oKZUX3S/exNrOXDx+iHbyI9+ov9UJjdLuNNhio3zT1vb5XNerc?=
 =?us-ascii?Q?zkl4xlotOy2A2gagEM+Z9XE3bfKmgRC5R3U+3c7QsyqPyRHcHMO0xz1U3yo1?=
 =?us-ascii?Q?CiRc3YAFRpJasOWUlKe1Vp5GVH/5TA8d6qUwyPQLTkwJyga+oEKQGpeoiiqJ?=
 =?us-ascii?Q?sxHG4I80QJlE5C2pYLD/KB6/RDFnTbEsFD4Ss+G2wmoBVc+jBpnYDyuefYWB?=
 =?us-ascii?Q?cFgWpgc9+cC1t8cVo6r957sEssROeAIIsNsp6aJplLYUbZR5ahfQtQXHNjeq?=
 =?us-ascii?Q?6xbPBnW+lF3YLE/D5VWa+DYyn6RKVJEuy2va9lymb8TYKeYJbqN/TyHWWILJ?=
 =?us-ascii?Q?wQLB4486YGgGL+XExSnnhTBXqn42wJBDPcnr5k3fIP345ZwEqlokTQTKJb+a?=
 =?us-ascii?Q?a+tiurJ6KVHM6MABusP/4aHkAFtIspscK+bvKX8BfVT2tURY14HWbxN6uj/G?=
 =?us-ascii?Q?tvO4l2r4gs/e0sdjdeYuEIxGES3EhD1qdu+dmyKUhY74sKGfDZT3IlcR5Dsu?=
 =?us-ascii?Q?lsm+tXJUbTk1Mc8QzZ9loyGNjoLHtM1JoMbtBSDcY7GA2fw06HKiQtFFKsB0?=
 =?us-ascii?Q?zmZuhKinmi92TRHh8u9oFfBwG1QVVYE2a0FrbJeM9x7ki8spufTmfTxPJI8D?=
 =?us-ascii?Q?OciH93Ts8o9ef2D3Y+PkOs4uOlyjYqzzNPQFN7uFGXdvjI2xQpCmNIwJRMtd?=
 =?us-ascii?Q?A6guRTbXOevbRqVcedV+cxiGd0QHpE22X6NIUPYBTlAcyS/sgeOmUxNTeRIN?=
 =?us-ascii?Q?lOjmOigxPco3GEHDZ/8qEUmtj20AKV253bTAQE75ES+aGCLzpfqkjCW8X2sO?=
 =?us-ascii?Q?d5dzVaXIZxY0h+6JJQI4mZafudBGdvQgCSJtJBgHhReZxCbpj2gHn/FHfiT5?=
 =?us-ascii?Q?vzdMVjandanK0b0eOuwUk4raiIAZE20Qj0Oydq9EP76FeTlWiSvvOlyB/42E?=
 =?us-ascii?Q?DdQ6YHplONOVEiEzZwZx7AgWgI4KQpFcgbn+oloCnv7FduunJYoiVSlG+sVX?=
 =?us-ascii?Q?E6LxXS2H2CF4d6m+O3UtdeEnYz57muPhT3u4nKYq?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5257.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 55b57b81-0c13-4245-1b70-08dc11caf98a
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Jan 2024 10:57:44.6915 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 1k1p9mimRkd/epieOCCbLiVjlXtuBWDfqfO4d0FHEd2Z3zPJYT0YqA0OVeueBKswQjEehEGq69iqqluigh+lgw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4368
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
Cc: "Li, Candice" <Candice.Li@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Official Use Only - General]

Let's drop the following message.

+               dev_info(adev->dev, "%ld uncorrectable hardware errors and =
"
+                               "%ld deferred hardware errors detected in U=
MC block\n",
+                               err_data->ue_count, err_data->de_count);

With that fixed, the series is

Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>

Regards,
Hawking
-----Original Message-----
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Candice =
Li
Sent: Wednesday, January 10, 2024 16:39
To: amd-gfx@lists.freedesktop.org
Cc: Li, Candice <Candice.Li@amd.com>
Subject: [PATCH 2/2] drm/amdgpu: Do bad page retirement for deferred errors

Needs to do bad page retirement for deferred errors.

Signed-off-by: Candice Li <candice.li@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_umc.c | 12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_umc.c b/drivers/gpu/drm/amd/=
amdgpu/amdgpu_umc.c
index 848df7acdd3210..df61df7e9b155f 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_umc.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_umc.c
@@ -93,6 +93,7 @@ static int amdgpu_umc_do_page_retirement(struct amdgpu_de=
vice *adev,
        struct ras_err_data *err_data =3D (struct ras_err_data *)ras_error_=
status;
        struct amdgpu_ras *con =3D amdgpu_ras_get_context(adev);
        int ret =3D 0;
+       unsigned long err_count;

        kgd2kfd_set_sram_ecc_flag(adev->kfd.dev);
        ret =3D amdgpu_dpm_get_ecc_info(adev, (void *)&(con->umc_ecc)); @@ =
-147,16 +148,17 @@ static int amdgpu_umc_do_page_retirement(struct amdgpu_d=
evice *adev,
        }

        /* only uncorrectable error needs gpu reset */
-       if (err_data->ue_count) {
-               dev_info(adev->dev, "%ld uncorrectable hardware errors "
-                               "detected in UMC block\n",
-                               err_data->ue_count);
+       if (err_data->ue_count || err_data->de_count) {
+               dev_info(adev->dev, "%ld uncorrectable hardware errors and =
"
+                               "%ld deferred hardware errors detected in U=
MC block\n",
+                               err_data->ue_count, err_data->de_count);

+               err_count =3D err_data->ue_count + err_data->de_count;
                if ((amdgpu_bad_page_threshold !=3D 0) &&
                        err_data->err_addr_cnt) {
                        amdgpu_ras_add_bad_pages(adev, err_data->err_addr,
                                                err_data->err_addr_cnt);
-                       amdgpu_ras_save_bad_pages(adev, &(err_data->ue_coun=
t));
+                       amdgpu_ras_save_bad_pages(adev, &err_count);

                        amdgpu_dpm_send_hbm_bad_pages_num(adev, con->eeprom=
_control.ras_num_recs);

--
2.25.1

