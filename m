Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B6F5AC47258
	for <amd-gfx@archiver.kernel.org>; Tue, 23 Jan 2024 12:50:49 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 685FF10E78E;
	Tue, 23 Jan 2024 12:50:49 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2040.outbound.protection.outlook.com [40.107.236.40])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1354E10E78E
 for <amd-gfx@lists.freedesktop.org>; Tue, 23 Jan 2024 12:50:47 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AiZBNe/RLWNhSnMCcCbmcGhGQfdwY+obeuIBi+oGmKz0iPPfLtn/8mca7uBIQAmOHR89PxxP+9pQRY9OuL4l+OspukFmBY6cSwXw92a/oXokSD4H6PxlxGOcRu5GdKiVpteYB6GYLjJ/Q3v2Qtv3dnNUXICUlxjVjw140dHDOcVwLETtxoMTHk5PIsNnMG14un0ARwwJVkE4nJj+SUWfksNqZAp+BSfNHXFegYxU3o9hOE7egVeD7jVyzvhMTaFrr80VmGyGJDROXiAbyfgq8EBL1NoY0zodHPJo9xp27CkbGzUpeEqZzP+eqm/TMkUvgPcgElLF1xH0nM+O0NgRPQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nhOD6xmodNU2IaJ1Kj3bj0iMxJtMXzW5ib+Yd1rMjcY=;
 b=W/B4+ipKq9aYeDaF/7odz5/JVvHH+aK48hL7FBuWnkqGOwFf1uITLFGrhYgJh5kmnd2SMA7Ejoe8wlIqS6b/nZX1DtzyT71cdfBGJTStr50BwSWmsmwq2dvItrra2SCNhcmnIjG0kbO3Vj2d3vCaH33L+oATq76Pgo429nYjW2Wdj8WOK4oSkB3O/lZxwUWsotsaRVIqIe/ecIdcqzREFwuX1tDvZus8hvx/shMNKsicTwn9TOOj/bxTEwELTFSROSuqcs/fyAOkabgeE8pYvIedvmCtATpY5Lk3rRl5jV4S8qrimgMznlWZYASLXeu7Ql28a7EjvbW45lUloYD1VA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nhOD6xmodNU2IaJ1Kj3bj0iMxJtMXzW5ib+Yd1rMjcY=;
 b=JEUx2RHyJXW0mtWNCyMi48Ur7loD23X6G9cDvRV0niRmE2DPPEYAzHGJJTjaBdgYP5zi+0fVvqyhpu6orjKnliTptHLhhzvfQ998b1qPHvzbntGQPQAR6hlN3DDPHALP3lhF/nSg9DEFbeD5FSrDfQE5kMWHXq7SqnQXfJu9m3k=
Received: from PH7PR12MB5997.namprd12.prod.outlook.com (2603:10b6:510:1d9::21)
 by IA1PR12MB6601.namprd12.prod.outlook.com (2603:10b6:208:3a3::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7202.37; Tue, 23 Jan
 2024 12:50:42 +0000
Received: from PH7PR12MB5997.namprd12.prod.outlook.com
 ([fe80::61a8:83e4:c057:7790]) by PH7PR12MB5997.namprd12.prod.outlook.com
 ([fe80::61a8:83e4:c057:7790%5]) with mapi id 15.20.7202.034; Tue, 23 Jan 2024
 12:50:42 +0000
From: "Wang, Yang(Kevin)" <KevinYang.Wang@amd.com>
To: Samasth Norway Ananda <samasth.norway.ananda@oracle.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH  1/1] drm/amdgpu: fix wrong sizeof argument
Thread-Topic: [PATCH  1/1] drm/amdgpu: fix wrong sizeof argument
Thread-Index: AQHaTfRk/vqQ6GkgZ0WjXXTEEydpc7DnWYoA
Date: Tue, 23 Jan 2024 12:50:42 +0000
Message-ID: <PH7PR12MB5997FB5AB47A008D4586C9A382742@PH7PR12MB5997.namprd12.prod.outlook.com>
References: <20240122213139.3571875-1-samasth.norway.ananda@oracle.com>
In-Reply-To: <20240122213139.3571875-1-samasth.norway.ananda@oracle.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR12MB5997:EE_|IA1PR12MB6601:EE_
x-ms-office365-filtering-correlation-id: abe7c5cb-5977-4e63-d576-08dc1c11e88a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 2+ETp3z/l3IxLSMRwf5GVCImjPCajGFWm/+we/3yKTD+HmugBWRflcML+YBbFLQs23EvXchsAosNX4OFHfZRx7bURpcsrjbDfqkmLZYTz/E/UmTXuhIGb+Kj/Gxh3BFhAwQz+kRkGeyQPxMz8j0r69NpdNb9KE5OTOuCb5VIXBCJB7NT3pWR7lNXLwCV/44hDSsG/38m8GSzkPCInaJ5Ewp6UkuGnVj32UaeOr9fgttTgZ4o30ZOYn2ayNwKe71X8RoRMkdA4rxfwCuEQQpg4iHxFDvvw//pdjeMqcfDVXCd4YCGhAKtHE7hWhzO4K9ql7BIDeiKYUFvHy8A+jUv41lqH2sWAqpW8LMrqiMZRj3p7kN4Ez5Nhhsh7yZHF5+Guh408jA13KJ/PFyA969UcU2kVgpJgN+DyfloaqjKlWegwGVmPONBLUHyWE6HAvSFSrJ1LTp3NpERiBaVkpgjh7a0mmjrpi3yEOz5Plx27hx7Ur9flFc0w/KgIlqPwPTUjonZFudpSg9EKPepiZUDo7LTTUvq7iW+hTbLOsZPIbDW3hTLhxumnoIKUj0hkJYJ3VYQObDTUlg6qwt6lTGSTGDSyvZ9pzE9GvG3iBTaMbuZzNe0UXQpRYaxXqdbgOyk
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5997.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(396003)(366004)(39860400002)(346002)(136003)(376002)(230922051799003)(1800799012)(186009)(64100799003)(451199024)(55016003)(41300700001)(38070700009)(122000001)(52536014)(9686003)(83380400001)(2906002)(26005)(38100700002)(33656002)(6506007)(7696005)(478600001)(5660300002)(53546011)(71200400001)(66946007)(76116006)(66556008)(66476007)(110136005)(86362001)(66446008)(64756008)(316002)(8676002)(8936002)(4326008);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?MEHFW//lBFcjwK4xaZILQ7S8DYDCii1iAH3oR6GDaxgkz8uuszvKFXiDd/zV?=
 =?us-ascii?Q?ffWKrmm/HFEEfXTconkNYwUXmgHIJJ5pkDzahob3+rID7FlpdtLHWxO2/hHc?=
 =?us-ascii?Q?ZT7aaS+RMXbERDRo9hibBqX2HXont+jF8bpGgBadbKyTgytddlQiq9HWw5Ts?=
 =?us-ascii?Q?ebPB4NdN6sHHKBPkgxDlwyklmNcwv+mGlx2ZWRUZf5oqQCjFoGLGKLwcuoJb?=
 =?us-ascii?Q?+rW3x63CUw0rN6EoNc0AiZuvP8VMzsZh/TvdN8rinS2BV+6v4NuayENu/YeQ?=
 =?us-ascii?Q?cWrth4jZ42vPOSIlyZa6wmIF1Rs2osJ3QY/vgnnUHp07qVQcXh4N3kIibZg5?=
 =?us-ascii?Q?BjpoXjPi+M57mcy4t4cxuCp2dhFvU1b1B5Sz+I4TbqhDxSJepL43tIOUpnyp?=
 =?us-ascii?Q?b8qJvWX2CdMXEBwlq5jqzYaP2lebaFo1d9P0+ZnbfM0UkLeUlunWrvGgPphj?=
 =?us-ascii?Q?Pwrc88nVk4En5cAOoj32BfCmrlixY93M+Unjv9WSi5OIMbuliX+2Wy/OFh6F?=
 =?us-ascii?Q?WnCKHZMrrLSGO+qCcJqXvNU+ffKB+GxT8fGGVoOfzxgazMtxTLCUb06Doc6l?=
 =?us-ascii?Q?Imh6ghxYnhS8YS0ln2HE2IIo68PTIt33My4MOFy+QtM1ug/QLaEOH1WFpM8N?=
 =?us-ascii?Q?lVa8iVjwYYwjV5S5YdPbOviC7hyNWC2fcCExt5b/4tmCMgUMkd0SC+FXEKgM?=
 =?us-ascii?Q?kCz5G1xxbcj9oP3WGvB0cSElR5yk++7YJhNcLjbn9WHnpyuqlLbVnwjjBdGq?=
 =?us-ascii?Q?Yjyq/3jE0siTCIApWTesj7nZwdn9u5JiRKkkldCbsxllqdmnUB5J2qHpDToL?=
 =?us-ascii?Q?L9MWGxgmZs43EMwk/ilqo8zE65RiBpmA7ifLtrukOKVg/ToW123lAwkZELfm?=
 =?us-ascii?Q?tT7G2n9iK9pNdmkqfB+Qw5FS2azx4AFQ8drvZeeRL0q+/+RmAIDMYuYr8jm5?=
 =?us-ascii?Q?xoOU7dYHo5mKCy7Ncp82ZBBLlCxKePub0M8I+FibfnJY90j1ZrrcgiJ4wZ3y?=
 =?us-ascii?Q?30uhev7H6qhs2mQYXI3ddHS/Ym3pIQ8FqIi8zi+XoR7+/aCHmZ/mUorHfMRd?=
 =?us-ascii?Q?ydDYNtjLjyzJmxT893bpzCCGMHgSqjHDYUEMxasGBfKTwOwz4JXmcCmIXNea?=
 =?us-ascii?Q?BAgzBQJuIy1I76ezJk0+Wi7n8wtxSvNaarTtUMpdPx2ysFJyophqTLmQM7Tm?=
 =?us-ascii?Q?IHBSwkjJqujIuQPDWxQZFRoXAd5I/EOf/LZHFcRixQlEkLImJgFJA2WRuUdC?=
 =?us-ascii?Q?FBHDVgVctWWSz1Z8s6W2H8LhcLrTFcaZ0YjVVHNU7EXED2YhY37QzYo2CdGS?=
 =?us-ascii?Q?OpLbT0iow6FkSXbCV+DlzlP0C6L0DgZpcJR4iKvhABTBoQRkSg4tcgo0I6b4?=
 =?us-ascii?Q?mFsfwKcKe+2Qu70URIUDf7LURDR/+2bROuWqlN4lhE6RPHwQJNAJxNeU9e21?=
 =?us-ascii?Q?N0qxqf9ybDDbs0W/xg6Pt91nRA34IrC2me3YVusKubVBro++K9PHB1YhDXrr?=
 =?us-ascii?Q?j/dPh27/gqddWHW1S/vZFdh6CmwjgS87dxBxKxxf8s5kaW6Wy868p/c+kkfZ?=
 =?us-ascii?Q?B+yCBUbb6JXEe27UJ4w=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5997.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: abe7c5cb-5977-4e63-d576-08dc1c11e88a
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Jan 2024 12:50:42.1067 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Zf+I3hunDcFq7XyqZvRDxdL9L0tF8wRyRb9pDVj7wKinvGV1Px3fk0KgtVKcci4g
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6601
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
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Reviewed-by: Yang Wang <kevinyang.wang@amd.com>

Best Regards,
Kevin

-----Original Message-----
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Samasth =
Norway Ananda
Sent: Tuesday, January 23, 2024 5:32 AM
To: amd-gfx@lists.freedesktop.org
Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; samasth.norway.ananda@o=
racle.com
Subject: [PATCH 1/1] drm/amdgpu: fix wrong sizeof argument

voltage_parameters is a point to a struct of type SET_VOLTAGE_PARAMETERS_V1=
_3. Passing just voltage_parameters would not print the right size of the s=
truct variable. So we need to pass *voltage_parameters to sizeof().

Fixes: 4630d5031cd8 ("drm/amdgpu: check PS, WS index")
Signed-off-by: Samasth Norway Ananda <samasth.norway.ananda@oracle.com>
---
 drivers/gpu/drm/amd/pm/powerplay/hwmgr/ppatomctrl.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/ppatomctrl.c b/drivers/=
gpu/drm/amd/pm/powerplay/hwmgr/ppatomctrl.c
index 8f58954739e0..b1b4c09c3467 100644
--- a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/ppatomctrl.c
+++ b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/ppatomctrl.c
@@ -1526,7 +1526,7 @@ int atomctrl_get_leakage_id_from_efuse(struct pp_hwmg=
r *hwmgr, uint16_t *virtual
=20
 	result =3D amdgpu_atom_execute_table(adev->mode_info.atom_context,
 			GetIndexIntoMasterTable(COMMAND, SetVoltage),
-			(uint32_t *)voltage_parameters, sizeof(voltage_parameters));
+			(uint32_t *)voltage_parameters, sizeof(*voltage_parameters));
=20
 	*virtual_voltage_id =3D voltage_parameters->usVoltageLevel;
=20
--
2.42.0

