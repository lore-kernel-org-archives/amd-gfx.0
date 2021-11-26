Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BC0CEC433F5
	for <amd-gfx@archiver.kernel.org>; Fri, 26 Nov 2021 13:31:03 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EFB4D6EEB2;
	Fri, 26 Nov 2021 13:31:02 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2064.outbound.protection.outlook.com [40.107.92.64])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4320B6EEB1
 for <amd-gfx@lists.freedesktop.org>; Fri, 26 Nov 2021 13:31:01 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GdYw8IzL4VXq6PFCMg1cn6oHjSqmU8eGh7okWlOQW/OxNf4sgphLwfYJFImV6BXO++Wc4rsfU1Dt4bBP81oQmiF5BCVazygxt6Kn84cv1BmlnCQ4Bt2i/vXFafOm+y+0pypRZJOECMlNqk4lOL1SbH/OmcoLZZEvcZ3r3SHr39d5IKKCl6XZaLEzmlVA5ZUec1J9Am0NtwxSTM+0Tcf4E97Id2WMHj61WIGYWQRsgR3GWnan/FVl/7dMS53MfCKGGryCZiFCQZuW6NX8wnKBK42tZ51zJcLqtNjGKW3cMrn7eZ+CkHaYn7bAZPZIYY+M2BcH7/s/bdMrpur06h9cCQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oHG55vCQENoumUp5ST/xN87o29AlXE+lSsTbamjneMo=;
 b=QuKOjNN6xcutQpYDuAPFqYA+EuEFgewSZbzSmZ+BmhXP6PplYkWF6BVt0EcdnTIQN3VDKtyVWpEiR+IbE6l6C8OEuBLKCpozTMzlHKQ9NQyePBW8O1TY5YAmlzEptYM8aFnZkJononMIiMknD6pUxCFR/p97eT6DJWTESAORisvBffT7CH+gkqE0rfl6UC9v7rJ0erQBK+WlgE4Xv6IpPR/Njsyenad0fcm4KnYxj3K79RqodDUtQUH67CJF7EAIUtuqrI0ktcFncfYSirpYG/o5XSIDsZtHQcazQqgFRD6flnFdc3/UwKHBQy+5VQddDpc0gJJuQ5bdnwc2ucWdSA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oHG55vCQENoumUp5ST/xN87o29AlXE+lSsTbamjneMo=;
 b=KhYC6A4ysvaxJHCly7udNG6WmfRA//1z9YhsEgNwrMCw/3X2mMiGvzNJlsx7YW7ZAQVJSPM7GNhmwj/FOvS45K+SM5t2jwWGjOuBM8feO/0a2eFbpAfZEKsdDm/dA3DV0EiIPkd/o1ILZp6nuewsAzrz3FW3b4INgBz0udcukuQ=
Received: from BN9PR12MB5257.namprd12.prod.outlook.com (2603:10b6:408:11e::16)
 by BN9PR12MB5148.namprd12.prod.outlook.com (2603:10b6:408:119::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4734.22; Fri, 26 Nov
 2021 13:30:58 +0000
Received: from BN9PR12MB5257.namprd12.prod.outlook.com
 ([fe80::2919:f0f6:40a9:e1c0]) by BN9PR12MB5257.namprd12.prod.outlook.com
 ([fe80::2919:f0f6:40a9:e1c0%7]) with mapi id 15.20.4713.026; Fri, 26 Nov 2021
 13:30:58 +0000
From: "Zhang, Hawking" <Hawking.Zhang@amd.com>
To: "Yang, Stanley" <Stanley.Yang@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>, "Clements, John" <John.Clements@amd.com>,
 "Zhou1, Tao" <Tao.Zhou1@amd.com>, "Li, Candice" <Candice.Li@amd.com>, "Chai,
 Thomas" <YiPeng.Chai@amd.com>
Subject: RE: [PATCH Review 1/1] drm/amdgpu: fix disable ras feature failed
 when unload drvier v2
Thread-Topic: [PATCH Review 1/1] drm/amdgpu: fix disable ras feature failed
 when unload drvier v2
Thread-Index: AQHX4skliN2efUkDDU+VH+mIg+U+DKwVzgGQ
Date: Fri, 26 Nov 2021 13:30:58 +0000
Message-ID: <BN9PR12MB5257C235349DB965960A5425FC639@BN9PR12MB5257.namprd12.prod.outlook.com>
References: <20211126132549.15175-1-Stanley.Yang@amd.com>
In-Reply-To: <20211126132549.15175-1-Stanley.Yang@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Enabled=true;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SetDate=2021-11-26T13:30:56Z; 
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Method=Standard;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Name=AMD Official Use
 Only-AIP 2.0;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ActionId=68ef946b-52db-4956-a4be-492c2714c679;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ContentBits=1
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: fdd238b7-cced-4ea3-a7af-08d9b0e0fb6a
x-ms-traffictypediagnostic: BN9PR12MB5148:
x-microsoft-antispam-prvs: <BN9PR12MB5148385C84AC9B3C2BE49841FC639@BN9PR12MB5148.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:393;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: X+3kWHEzFrCzNULT5v397sUC9aqtCSHxY75yCQ5BvFzPCK0hNmR4qrq9ICDsPQCVtviQVEc70kjXn6phdeiUV8heuOmMTX1TAMmlLP8A3XiObEsBRcCguoSiwVLs8rVdkgJVbFHfG7DtAxOKiK23m/c+gFg8E2RLCMicrV/ScyTIAFSOtzTBER5P8mWa3ZXELgsh2gSYLfofOFqBK5ADVkcCZbuHlQRtRWuKHD5nZVK7g0DVzvP+fPgYO9AG1QRsPkhCHfw5o3E4gg8Kg7i1FOAfFzdTrM8cQFSsVfWvgNxuAJrImEEEqz9JdvmDEKkZn8PyYktmqlf7uy1ITK1RWw+xHlR1yd0IE97vKsEqs67rI6my56drHHI7TOuJaN47yfg2XtqbfyflTATX1kJzQ+gE1JM2cnJ3B27stNiE+dK9ySfOzHkgaHC5Vr4O3f9Or/AngpQsiXRkzj86Sur2WzNV2mCyRy411KmhOOPFENZ9wp31eYHN0NRwvk6MEBxERsCFIft38ttGazNp26iiUxAzX8IL1YpEbX+KDfU1jMn9OQMeEAZlni6KbBh2Ym7RnTbrGc3kvnTOqgptDV9YWdxZauuVO2jgtPbgofE7OlINIxT9MIcWgLVfZkyAm4Xcq32qbMXkpOtv4lITokKYLBZdw2ZMWU2WCP/0Aw1QOd+6Q0rKwtziwphJHXqDoi3vLbcGb4n6SPpCxYayzWUekVEChO5TNs42uBmesK8sfAs=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5257.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(38100700002)(2906002)(8936002)(5660300002)(6506007)(83380400001)(110136005)(66476007)(33656002)(9686003)(6636002)(7696005)(122000001)(186003)(4326008)(66556008)(64756008)(66446008)(71200400001)(66946007)(26005)(8676002)(53546011)(316002)(55016003)(52536014)(508600001)(38070700005)(76116006)(921005)(86362001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?phu7MEiJfOMdNRM7vs1OQeXD2B8DxEX9952qUv3SlQKPKZPN/ukYafLU5QIL?=
 =?us-ascii?Q?HDAaTbASToDDr6GMMMTECV3OU0grva2q4L2RX2767s6ylVQdLvr4FDQw2gsJ?=
 =?us-ascii?Q?HdhN8fMKcNKvgZZ7ClmMsXos8jI0jp0nh+CRVbFHzR3sAjmMEDP2ULM24bfR?=
 =?us-ascii?Q?LaiY1GzSVZ/fJkmpCy5lHcP+sjefz56s6IQ2lSGueMCWr3o2eeCGcPePViI7?=
 =?us-ascii?Q?rfwb0S1+8fGF0YRm/5mUgsT7CGnBJwatSiKwkvHjUDyarqQOzCKHG+531WPT?=
 =?us-ascii?Q?ANRYikyKKlDOXR1WQUqkfw3WCuhd7JCmUARt+qIoGBwF6Na1bkpK8TRofrHF?=
 =?us-ascii?Q?JwYGf4UI2uuT8WzcCRXMtdeeVo5vxdhnh9FC+RQFQUxi2NR4odBo/aN/TJ8M?=
 =?us-ascii?Q?4NE4NNKo4hkhC/wMkvr3ehwsManmVuevyBXAF3QyCZXioLZ+i9QIKZnnBRZa?=
 =?us-ascii?Q?/2fJBA/eWoGw6+yfBz8eC2EozSmFi5gkOHxYeyTKBiLxBkdPDvrCs4Xvn621?=
 =?us-ascii?Q?au4FHZXv5yfHozq+ykDqZTKobXwO7ndSQxs4lAr92RasWzJGYTwU8bvu679n?=
 =?us-ascii?Q?ub0DNew0TG6e5jodRDasrc1TVNF38wevcBiYYXaq3rOiEBb2HwiYvkRorh4o?=
 =?us-ascii?Q?pCDRwDD0k/E7Nw701lNLBpy/RwdfB7yjRq+9ibLWSpSOhHj+nXMYrq01jBWG?=
 =?us-ascii?Q?YP9JQEcNHfkT8/DpaWnXyCi3v/O6oLwInCKo1EtMhFXYfho6uyQ0YXHat38C?=
 =?us-ascii?Q?kaTT5xGZXwBTE5wwSRwSgQqQdwbzkmCn540ZvpOPEGpvzcDd35fnd9jPdUQ7?=
 =?us-ascii?Q?afXXpXJuzzq6UD04jnjs9sHHELokrpM2Rlh+SDN1nygxVLz/tunP4bzOlBxs?=
 =?us-ascii?Q?3jDFiwwV5vAw0jFOxaCYBEh+5kpAW6niCI3mv/5hdDix5cTakaLcfo8z8bjG?=
 =?us-ascii?Q?Uk5Dbwivk11oyXf5i5hNovmUVStLYrYu0CSXIhx+ZEgx4AXr7jZ6VjJ4v7ie?=
 =?us-ascii?Q?Chxmyh/+eK250h0dNv0yBPf/BWYobuppDwMmU5TyW9Oc+iXT+oyT+J7on6iH?=
 =?us-ascii?Q?AKU5Osmk5LM/2cDL+Fnuk75C9k9KelADdFFYmCqQo8MH31yvSchxALYFI7Ep?=
 =?us-ascii?Q?/pfAUSOgNCygVJTMHqwnKxh5CkPq8TfiFV/ZBQ6RarKppKYNCdzROSpL1v6S?=
 =?us-ascii?Q?fUckkJ5vb2tDetycIR7N0Izqrhqe58/l3mdathSoF7rG4eVWq8JR4zGgJO1y?=
 =?us-ascii?Q?G4SwJJw6QI/vZYgRerHcHX/msprEQxP+fZ/r5ZFZfcpNMaTt5C9bKoZDbJ60?=
 =?us-ascii?Q?nR7Bg3EfBr95dp4II0oPUomG8upinyNPrtPsSg/cfJi+q7CDnAmPstZ/N5QH?=
 =?us-ascii?Q?MQVg6RE0C1WDx/2gcwdONSa3TKpA6s0q5LuJ8tPLmjHAmG0DfIxwqzxO+vpW?=
 =?us-ascii?Q?y4UVCfqNvSwolhBjNNtq4Phw+/FGNS3sL8b7GeqltXBzBbjelW/r/lGiKrir?=
 =?us-ascii?Q?/SazGWV62lDYjl8DUOJRxbHbUog2HVwEJm6FLBAHh3LzxsBnBMZmJ00OF88X?=
 =?us-ascii?Q?F6Y8vVYFJ1pa40kwELdO3WZk2EaUXoZ40na3t+xEXRNx1OraqTgdeTHaKMGy?=
 =?us-ascii?Q?Xm84DzclLyVXbSmdJNwnXXw=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5257.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fdd238b7-cced-4ea3-a7af-08d9b0e0fb6a
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Nov 2021 13:30:58.4121 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: uvvoId02acekj8m7gbJL84VxTo9IKdCblEgUj5Z+lJyKbN9sP77/TJlj6WzPIJB7F6M71keBq7Is+9Zd1ULLpg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR12MB5148
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
Cc: "Yang, Stanley" <Stanley.Yang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Official Use Only]

Thanks!=20

Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>

Regards,
Hawking
-----Original Message-----
From: Stanley.Yang <Stanley.Yang@amd.com>=20
Sent: Friday, November 26, 2021 21:26
To: amd-gfx@lists.freedesktop.org; Zhang, Hawking <Hawking.Zhang@amd.com>; =
Clements, John <John.Clements@amd.com>; Zhou1, Tao <Tao.Zhou1@amd.com>; Li,=
 Candice <Candice.Li@amd.com>; Chai, Thomas <YiPeng.Chai@amd.com>
Cc: Yang, Stanley <Stanley.Yang@amd.com>
Subject: [PATCH Review 1/1] drm/amdgpu: fix disable ras feature failed when=
 unload drvier v2

v2:
    still need call ras_disable_all_featrures to handle
    ras initilization failure case.

Function amdgpu_device_fini_hw is called before amdgpu_device_fini_sw, so r=
as ta will unload before send ras disable command, ras dsiable operation mu=
st before hw fini.

Signed-off-by: Stanley.Yang <Stanley.Yang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 5 +++--
 drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c    | 1 -
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/a=
md/amdgpu/amdgpu_device.c
index 73ec46140d68..d5e642e90010 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -2838,8 +2838,6 @@ static int amdgpu_device_ip_fini(struct amdgpu_device=
 *adev)
 	if (amdgpu_sriov_vf(adev) && adev->virt.ras_init_done)
 		amdgpu_virt_release_ras_err_handler_data(adev);
=20
-	amdgpu_ras_pre_fini(adev);
-
 	if (adev->gmc.xgmi.num_physical_nodes > 1)
 		amdgpu_xgmi_remove_device(adev);
=20
@@ -3959,6 +3957,9 @@ void amdgpu_device_fini_hw(struct amdgpu_device *adev=
)
=20
 	amdgpu_fbdev_fini(adev);
=20
+	/* disable ras feature must before hw fini */
+	amdgpu_ras_pre_fini(adev);
+
 	amdgpu_device_ip_fini_early(adev);
=20
 	amdgpu_irq_fini_hw(adev);
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c b/drivers/gpu/drm/amd/=
amdgpu/amdgpu_ras.c
index 39dfd4d59881..9400029ac3bf 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
@@ -2484,7 +2484,6 @@ void amdgpu_ras_late_fini(struct amdgpu_device *adev,
 	amdgpu_ras_sysfs_remove(adev, ras_block);
 	if (ih_info->cb)
 		amdgpu_ras_interrupt_remove_handler(adev, ih_info);
-	amdgpu_ras_feature_enable(adev, ras_block, 0);
 }
=20
 /* do some init work after IP late init as dependence.
--
2.17.1
