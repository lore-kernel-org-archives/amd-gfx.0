Return-Path: <SRS0=/AY/=LL=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12A50C2B9F4
	for <amd-gfx@archiver.kernel.org>; Thu, 17 Jun 2021 09:23:10 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B5CB461209
	for <amd-gfx@archiver.kernel.org>; Thu, 17 Jun 2021 09:23:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B5CB461209
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5FE2B6E8E6;
	Thu, 17 Jun 2021 09:23:09 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2073.outbound.protection.outlook.com [40.107.92.73])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 67BD46E8D7
 for <amd-gfx@lists.freedesktop.org>; Thu, 17 Jun 2021 09:23:08 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HdCGZWJQHStNZd6LGu9hlsyYsnctY+FRyYb13QBs102/+/pT0jzPFb9MAWZPnf1kjH66aqleaCSsRtstjQrm0wsEymPoAoOeMH+Qe44lKcNUKsXS51LV+SxSbRAPYKLvoqnFspsHLm6LV2OjnpptiwyYU+c/cAyn7ff2BhQc2ezcD9wAFGh7LY3cEY2wdSQJYAqjuJgF7OVGiZbL5c49u8zGKNZ/oiD1+yJXpNLBFRZSWPsvF/6aRkE9LeiFCE0usUv5o8TyifQAgXuOiZ+VIZaMhE+9TTNabQkCMgUOQ3a9w/1B3/DgcgTAr+LX3js6b97cHtZYV3IcRiqPJSj/ow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8ijANQUitQ++Bx7waY1dJTb2OpbD6T06woJmH96p69M=;
 b=Vk3V27Eg2CMjU2VXVSuOFQcvDcD2wSEVWsLxY52FFgrssFW43iXPRxpGDzSfnIXshyKJ3BIyBzemw9Olvk7RsnMbB5aiwTXgUGtrdySC8W1g2qrJ2VZGZcV+j9NrxgkTMJyH35RX5WEyWmODkaF8UV1OBrYF0DzN0FVQIWPvholEHmcGfonUqtIeUy7P6Q/5okPA1lfo6Vr9yWX7PzYsF+lQifYMzuxeeYMZe4pn3Ux2KHRzqMywXm68FfMbnH80rVvEp4I488grtvTur7czwnNZjmi2atD/PlmJot56FNnMo+IxPDiQZNM64YNqLvxgx5V+iiL1ZiIrNtQC/oAXgQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8ijANQUitQ++Bx7waY1dJTb2OpbD6T06woJmH96p69M=;
 b=OoZ7QYVARkZQuENnBJrHnhCYELXuXBiT7CZsNNslDxIMY1cWU+8JKgcz5KJRuQVKWb+DtiIjKEai+8rblBdiUogKEMUXfoAflWlhz4cqxqGe0D+S7J7mWXdMz2FuhGw4A5UaAJxGJICacNj/6zizpgEZXLtqXB8YFOGuixBmXN0=
Received: from BL1PR12MB5269.namprd12.prod.outlook.com (2603:10b6:208:30b::20)
 by BL1PR12MB5240.namprd12.prod.outlook.com (2603:10b6:208:319::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4242.19; Thu, 17 Jun
 2021 09:23:01 +0000
Received: from BL1PR12MB5269.namprd12.prod.outlook.com
 ([fe80::d9d7:2d92:acc3:e3c3]) by BL1PR12MB5269.namprd12.prod.outlook.com
 ([fe80::d9d7:2d92:acc3:e3c3%4]) with mapi id 15.20.4242.021; Thu, 17 Jun 2021
 09:23:01 +0000
From: "Liu, Monk" <Monk.Liu@amd.com>
To: "Zha, YiFan(Even)" <Yifan.Zha@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amd/pm: Disable SMU messages in navi10 sriov
Thread-Topic: [PATCH] drm/amd/pm: Disable SMU messages in navi10 sriov
Thread-Index: AQHXXq9zgBgun8wVEkqaam6ynKkcj6sX90sQ
Date: Thu, 17 Jun 2021 09:23:01 +0000
Message-ID: <BL1PR12MB5269A9D50BA47BEC6567901B840E9@BL1PR12MB5269.namprd12.prod.outlook.com>
References: <20210611104911.121779-1-Yifan.Zha@amd.com>
In-Reply-To: <20210611104911.121779-1-Yifan.Zha@amd.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Enabled=true;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SetDate=2021-06-17T09:22:57Z; 
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Method=Standard;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Name=AMD Official Use
 Only-AIP 2.0;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ActionId=ab1d9dbd-8a73-4fc6-865a-79596830aa66;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ContentBits=1
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [165.204.134.244]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 07fe4676-f5e6-4a60-8e9d-08d9317180f4
x-ms-traffictypediagnostic: BL1PR12MB5240:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BL1PR12MB5240150E02E91B75D07E6362840E9@BL1PR12MB5240.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2449;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: qeOcp42/kp+T2daruQWH6M3TOJod7844EfA/RwDtOZbLLBf2IwL4LG4p47eR/SiRvwLdNbUCcj2+a0aeYbXGTaykaTvJ52+GeUXBlT1x5HzjjqLHxeDWK36aEEeKWbkY1Sp+yzgWZrHAmEEFp4ZPMn5cfagTGjcinapEzJ2JYjqZwJkVi5MJ8oDsX1P/3U+mDP/aua4wzWnu78BWFqzUCyh0IJY1UfxGLw4Oc7VGpYP68mTD+9XhYPjT+AGf2q3NGq4v6vxMPZyZ2unwmMUq9kx4X3N11KrJhyjmILl/uO4r/BYgWaNG22OPlzZVJQ+c8ATx+NFgxKaB4arWEiySoQOfZK2RQly1G6yjcp/iH4cSAWTFdSqU7J0vdCgLPfaIkugi4FP+XeULFab9+XsXdjZtdfi4Gh8Zn4Uj4GgMO9+tAWfUR51EfIT4XOTMmQuXzA5j4VRIxe+KsCLEzLklh5ZLFSTBBoIwSCacE3i4l+SEfEUVSFK2t5zHfJX9zjTKflITZtxmdyF7GuQCGnWEWK0FZSpwS+RU3RzyXR2bF8NxuElkXuln/SoO1iChCj8zB1aPN5vtRyD89dNbFEWr0MyruNGHqrBkl7IF/uXaATk=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL1PR12MB5269.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(396003)(376002)(136003)(346002)(366004)(39860400002)(66946007)(2906002)(8676002)(55016002)(110136005)(7696005)(83380400001)(33656002)(9686003)(54906003)(316002)(8936002)(86362001)(76116006)(186003)(66446008)(64756008)(66556008)(66476007)(4326008)(71200400001)(5660300002)(478600001)(15650500001)(52536014)(6506007)(53546011)(38100700002)(122000001)(26005);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?c72fSiXfpowbjBGMrd6JyoaX+DT1m2tFckdBOk5qcJJP29LVEd4PDI7mV7av?=
 =?us-ascii?Q?mUpR+JoR7VA3ZKBkWhqznuFul79C/TOBwtZ9AJbuc4uVcuHN0zspl8EhKRDS?=
 =?us-ascii?Q?T2Eb4ZY7b8crV7uK13M5IIdba2wuclXcEJirGGGj/wQ3R+Pn+FOurPlIrBYE?=
 =?us-ascii?Q?u2Z6x11lYTgBhhi/sdlhoVy6rWob3wId6QyK7XbVi2WZqsvglkp1RpK8B1Y3?=
 =?us-ascii?Q?pzaVSvvB0ctN0R6wAaH5Lv7RcNY/oS2RxIC+/ygR3qeidFv/8xoaniv76gQ1?=
 =?us-ascii?Q?ZjbRp4ls1q1DmsELw/CTuRLZVHZqRP3hQX2l0wx+czmjSEsyRDpth3UZXmTX?=
 =?us-ascii?Q?c8zNWTt1uLeyht4hiS8+vNaW0rzwgU6WJSSNJO/x+ElQ0Ow5hq9VDr4MthUa?=
 =?us-ascii?Q?UMglmgQ/IvkWBEe2ra/m3L2Og+flQ00RUYPAT/bUTNtYb5E4gxOuMoBRStIr?=
 =?us-ascii?Q?yool2iLJyZ5tVNchTXnzmSbMzf/6XALp0aqKgPiy2YBIAwr1us9dBeILNRhE?=
 =?us-ascii?Q?B+JrRbOFbGQtEvi9tkuDMjk5018+WDGKPl5T+UGkNzQLTleEs+UVMmrvMauI?=
 =?us-ascii?Q?smVzORLm7M/9d7TlR3Yy7DE/J0swEFnj65GQ+kUF6hpZJtPMAAUKxFVsmGZM?=
 =?us-ascii?Q?/BawYFlF4CM1517FUSSAH3pg+PdfeaFENv2P8aCR6vLEYsmz0pfMAvfwT3V+?=
 =?us-ascii?Q?RzB2WquC7tQWzFn5KrDNUscRnM4tmC3Fy6J1fiuVa/8dYpMigTdS4bBbyE0W?=
 =?us-ascii?Q?N+UEuy3cHDmH74QjkdvvrrtdBONOgZQ3xurROrf2xU2JDCXzd0LSiSsAn3iG?=
 =?us-ascii?Q?HvGsmBIbZtE+GYcYllylSHLqtaeWYYmDTJboAVf0c+Fo0dq929oIpYwJ8fXs?=
 =?us-ascii?Q?Xdlj5R1XlJOj054suC6wtnnknscovkOML4xdzqCAACoNxp8rnh1ppu2SSVY6?=
 =?us-ascii?Q?zwWJjcibcMeHbwJ6T0yASBIvpe9OcLl4m3W48PQEvnhzHZJU/cMtfsH6gHmy?=
 =?us-ascii?Q?epsMe51WiHaxrXtrbPHJmOq2tagBg9B+IbewhA4tSa2yQVvh9emAC5gw07ZI?=
 =?us-ascii?Q?L5pq9wjN2oKlJIKYxZkDEl5M4uGX6rKxem6iM3YGDYOk3z42cd7cKTn6XDVJ?=
 =?us-ascii?Q?u27RMcZ0+mLEO+Vpr2VxB1GlFFZEtJ20DvFBD/UNr5DisjWPKypbK1RL6SMp?=
 =?us-ascii?Q?zqrkIEhdmJ8tVy8HucDSiUHZ1kX103L2RIw/K3ZLT7RDIIGOi4Z/yDdDCYRP?=
 =?us-ascii?Q?3FWE7ofmTVhxopdDrfDM13CZiosdQiqnkKcoLP76JrIBR4rci8wgRYNSRLQy?=
 =?us-ascii?Q?Dao2V6EFWnEn/gvUgUwnIkn8?=
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5269.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 07fe4676-f5e6-4a60-8e9d-08d9317180f4
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Jun 2021 09:23:01.3067 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ED3t/KPE1VDntBFH0d7XcLPbWgHta3BqiC9cXoUA4CZUhoUqa3Gh1vqRpLa0/XL/
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5240
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
Cc: "Chen, JingWen" <JingWen.Chen2@amd.com>, "Zha,
 YiFan\(Even\)" <Yifan.Zha@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Official Use Only]

Reviewed-by: Monk Liu <monk.liu@amd.com>

Thanks 

------------------------------------------
Monk Liu | Cloud-GPU Core team
------------------------------------------

-----Original Message-----
From: Yifan Zha <Yifan.Zha@amd.com> 
Sent: Friday, June 11, 2021 6:49 PM
To: amd-gfx@lists.freedesktop.org
Cc: Liu, Monk <Monk.Liu@amd.com>; Chen, JingWen <JingWen.Chen2@amd.com>; Zha, YiFan(Even) <Yifan.Zha@amd.com>
Subject: [PATCH] drm/amd/pm: Disable SMU messages in navi10 sriov

[Why]
sriov vf send unsupported SMU message lead to fail.

[How]
disable related messages in sriov.

Signed-off-by: Yifan Zha <Yifan.Zha@amd.com>
---
 drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c
index 78fe13183e8b..e1b019115e92 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c
@@ -80,10 +80,10 @@ static struct cmn2asic_msg_mapping navi10_message_map[SMU_MSG_MAX_COUNT] = {
 	MSG_MAP(SetAllowedFeaturesMaskHigh,	PPSMC_MSG_SetAllowedFeaturesMaskHigh,	0),
 	MSG_MAP(EnableAllSmuFeatures,		PPSMC_MSG_EnableAllSmuFeatures,		0),
 	MSG_MAP(DisableAllSmuFeatures,		PPSMC_MSG_DisableAllSmuFeatures,	0),
-	MSG_MAP(EnableSmuFeaturesLow,		PPSMC_MSG_EnableSmuFeaturesLow,		1),
-	MSG_MAP(EnableSmuFeaturesHigh,		PPSMC_MSG_EnableSmuFeaturesHigh,	1),
-	MSG_MAP(DisableSmuFeaturesLow,		PPSMC_MSG_DisableSmuFeaturesLow,	1),
-	MSG_MAP(DisableSmuFeaturesHigh,		PPSMC_MSG_DisableSmuFeaturesHigh,	1),
+	MSG_MAP(EnableSmuFeaturesLow,		PPSMC_MSG_EnableSmuFeaturesLow,		0),
+	MSG_MAP(EnableSmuFeaturesHigh,		PPSMC_MSG_EnableSmuFeaturesHigh,	0),
+	MSG_MAP(DisableSmuFeaturesLow,		PPSMC_MSG_DisableSmuFeaturesLow,	0),
+	MSG_MAP(DisableSmuFeaturesHigh,		PPSMC_MSG_DisableSmuFeaturesHigh,	0),
 	MSG_MAP(GetEnabledSmuFeaturesLow,	PPSMC_MSG_GetEnabledSmuFeaturesLow,	1),
 	MSG_MAP(GetEnabledSmuFeaturesHigh,	PPSMC_MSG_GetEnabledSmuFeaturesHigh,	1),
 	MSG_MAP(SetWorkloadMask,		PPSMC_MSG_SetWorkloadMask,		1),
-- 
2.25.1
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
