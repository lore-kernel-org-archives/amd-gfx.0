Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 96914C678D4
	for <amd-gfx@archiver.kernel.org>; Thu,  2 Mar 2023 05:28:17 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D398410E0F9;
	Thu,  2 Mar 2023 05:28:16 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2054.outbound.protection.outlook.com [40.107.243.54])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F2D8210E03E
 for <amd-gfx@lists.freedesktop.org>; Thu,  2 Mar 2023 05:28:15 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=F5YwxOXFP/qFVo3BZ2RUYpb5u+hrhuK/LCsigUzjKQiR5TZoSuwp0bOmBDP44yi5bwtVQgfKd24ZRoRc2tXWX7Ao9qsQfXn0X3/1OGFSBxUVyWYOxzSaWdMkcZg3fUcO/0fYb585FZh+gNFt/jis+XuhmYeKxtaUs9X/jc0GRziUWmBLw44OVzOid9H63EXqHfMgtO8xCM0pqO65/annMoHj8za6Qn/7WqKWEmHYA4fok2yW/f+rfAq56G9UgOaAMxxmVWuOFkywmPFrUIzZ7kBSz/a0XJdz87L/uT1L+pDxV6PdLQx4mkuFxZXmaOQqzpS8yGzze81l4Tg44A8O/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QUuR0npjPquQvk+EKde5Oq8n6CFok7irwlBQzsxJNMo=;
 b=L/DaVSxMN42WbH3tg564ffceS1JW12NDA5d87lcK+UUoFAAczMdc57rT/4E408jNh1VK8b4TSwXFerOdJTTb9mVTeYvulf/ZZAQNC5WsGGxe57gcObT6j6NHxdkAhwbUNfk+k1wBKaRIv2bIbYw1U6nA00l2xbRG4lqhipvDY/ngwJg7twquM42kCcJJ7HR5yI0+SqVbpvdHuRBnZINaVVmRe2zPZtnNDWWy6Hhk/ri+LlRIW4J8mALvDmZkKMQGfpgCoS8NrXTR/6QikZQO3LxpjGbMbz4TXheMl/vsxB7AU7Wsklew+f9OLV3gSArPHPfpQuLOKAHPIzn57VmL2g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QUuR0npjPquQvk+EKde5Oq8n6CFok7irwlBQzsxJNMo=;
 b=NPw8k6eILCfR/Xi4ALxslN/RzwvAxfk2rubKaWwfHWQIaINtVJWr9EisgKvdD7/MOAyQN/QqYiiC4lSoounOkP9CWujaiLvG4Y189lx3y9RcvL7MNzRUQf/yvOcTcmAqJ9MK3Pfv3SxzwH/jG0B1kDF+m4+MCUuvZ6FrC/bunmo=
Received: from DM5PR12MB2469.namprd12.prod.outlook.com (2603:10b6:4:af::38) by
 CH3PR12MB8209.namprd12.prod.outlook.com (2603:10b6:610:123::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6156.19; Thu, 2 Mar
 2023 05:28:10 +0000
Received: from DM5PR12MB2469.namprd12.prod.outlook.com
 ([fe80::5ca6:3a18:d6ee:c103]) by DM5PR12MB2469.namprd12.prod.outlook.com
 ([fe80::5ca6:3a18:d6ee:c103%7]) with mapi id 15.20.6156.018; Thu, 2 Mar 2023
 05:28:10 +0000
From: "Chen, Guchun" <Guchun.Chen@amd.com>
To: "Li, Lyndon" <Lyndon.Li@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amdgpu: Fix call trace warning and hang when removing
 amdgpu device
Thread-Topic: [PATCH] drm/amdgpu: Fix call trace warning and hang when
 removing amdgpu device
Thread-Index: AQHZTMN6iIRulzDNQUGww3Qj17OBn67m9dlA
Date: Thu, 2 Mar 2023 05:28:10 +0000
Message-ID: <DM5PR12MB2469D48DA87D7CCC9AEF49B0F1B29@DM5PR12MB2469.namprd12.prod.outlook.com>
References: <20230302045707.2299-1-Lyndon.Li@amd.com>
In-Reply-To: <20230302045707.2299-1-Lyndon.Li@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM5PR12MB2469:EE_|CH3PR12MB8209:EE_
x-ms-office365-filtering-correlation-id: 6bca7f05-3f2e-4c0f-83f6-08db1adee98e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: g2FexuvuElXOiM1hdW1jDIBuZ//ENMSUzFpYE0t5Z8JCoU+KfZk1MgOYw6smuGsBJKGqkWSmAo9V8SqTd6RkvKy1fCK/6OIh4WAEn161bon7cH3N4ZVUGbqexi1Uklqh/wsID6dkd8w3G7lRkmV7l31CkEJgfbye+n4cM7T4wKXCody6Y2XJCquoU4tYsWUWYbYoJDW3qWp2vb9S1jgYCuKZjIJo1Pq9nqbPoRzL+w8apMTsMlYA//dtGMeozhe7IFM8xhCdeEB+puvFo1IQtJy9Uwf+29/wxKKqmHKjT1dgfDYdAzi/4/ou/lGR0uRZkrZdDt0N1+GVPHQuJtjCgRpxCeVhGkNHcuAerqb5kzoU4OpPnN4PfBgzbESVVcE2EtBCCt5Hcvj5D5dh1lzGv4s8PDxwQjWBhGqWeTtHbPa+LSvjfVrq2KMgdmU/MPJk5jwhkPKU/HOWgL2iYbEO4eHkr9O3Jun9deWKi3bwvhmcRdPpNWZ1sXqYNsozoWalDKngW0w9zhAiX1G03RhK4Ja/MUYgKv++mi5r3ApP7U/uCiP5XWTbxsqP6pRGevu4EKC7AE1O0vSvrpwOkkVQsNu+YmScN3+h537kILTV0rDcrofyhpUJJfgOzgpWnUEFguSTH9XLhlw09zaDLcXBYpqDMR+ovoU0ypMcpbQiEud7XUvHYaMdML/kBtJgEgyjCHyL5x5g/E5mRiexuWtLfA==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM5PR12MB2469.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230025)(4636009)(136003)(376002)(346002)(39860400002)(396003)(366004)(451199018)(83380400001)(122000001)(38100700002)(8936002)(52536014)(5660300002)(71200400001)(478600001)(55016003)(33656002)(86362001)(38070700005)(186003)(26005)(9686003)(6506007)(53546011)(76116006)(64756008)(66446008)(66476007)(66556008)(66946007)(7696005)(2906002)(8676002)(316002)(4326008)(41300700001)(110136005)(54906003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?3PTq4MSn7Ymk925Ot3OgSI8qWXSnqYhqiLPxMisuTFTOJlRY9m4mGaCc8Xos?=
 =?us-ascii?Q?ofv9GXRuPNRMLytzBoGNcD8T8naLkOqJL0tBEgaDr26olJX/k3zhbRahQy9y?=
 =?us-ascii?Q?DLUIOE0Rnk8+uALPe7mBp4sV0Ru9nbnGeaXvtX2b9utSF09/Bu22UJgg0bJ2?=
 =?us-ascii?Q?wQDGjcq4oZw2WDQADdnMu7ELjycGR5SlqMOKr7Lrzt6IJqXKNB6JVatQ4ecn?=
 =?us-ascii?Q?Hh1CuNR52MonM9d7m5oT3f5AUJ8UU/wYZIc9yBK9kVqPrdKRmkXncjREefip?=
 =?us-ascii?Q?mFMEVoQxxIOYOKM7nlewOomikMoARNvBkhVVdBFEXWvmArdvdDDkJEKXUfPQ?=
 =?us-ascii?Q?svFNiacoDXQP/sP8OfKqTHtNpRk0J77zccv+C20SpsjgQQcXE6HBTMz01ero?=
 =?us-ascii?Q?pjDxh20EuqBYkvYyOJRXIoOVmamOxeSzXLmEFupn4+LOl0Qcsbv8k5Gi+XWh?=
 =?us-ascii?Q?NTgPqS2oHACqoqWkXptI+evhKVn2zng4u46pkwklQp3GXZcBJdaGbWrSapSA?=
 =?us-ascii?Q?/8IPj5wIRPezlMaBcxLzVHW/yBc4VAWLzciQKBhFjro384gYS6HK7NWOaYFu?=
 =?us-ascii?Q?8RZNsPw6i231ib5no8P0op1a82N9v6L5nWBqi+2lP7qDE1s855FbkZzgvew3?=
 =?us-ascii?Q?0kIQ65B+6lXjktLOnOfpVgRgxCtGm4tEVgrUyCHMvrYQp0k9J6BL8MIVgr8s?=
 =?us-ascii?Q?HIBMtPHRmuA76eEyTidtkq21chVyoHkHCHIcFAqolU2zAwnv4P6UPJHMQsuc?=
 =?us-ascii?Q?ok+ZNC+QbvRO3naoZrpQDcrem25cS2jHx3Vb3e+4WwMpn4d/Bw6c0nic7CAN?=
 =?us-ascii?Q?k41fe96uqbY+T0tXA8GFDVMQ17KPwKBMvFPTwDppQMERNg741gsamfkovp5m?=
 =?us-ascii?Q?ea0dIXJ+HBgEoSqUmTZvceTQwF23MoTcI5fisleaDjUpn++JcwiTjZNk92nf?=
 =?us-ascii?Q?8IZSVYYJ76luH3BJ1zcVBmf4/cgA37t2pqt9fahxGL8OFt5rEhyeUBKWp180?=
 =?us-ascii?Q?cLBNCaHrZ24kH9duCvtNTfLHLs/wgbaBcAR6+ej+Rb+N6WvtlA/ahG7hSUU9?=
 =?us-ascii?Q?shHX5VU9BA+JrJHX3Spr4rf7LjatASxbOoHThXIkQ9Dp8TMTs77MIPYTWE28?=
 =?us-ascii?Q?WfBpOZS1cdPbVM6h0sMGeFe3VpcW87azJkmulDw5eUEEbPU2iFJg0U/mETb3?=
 =?us-ascii?Q?f1NjaA+BGS5tqrKQTYJ9K9H6WOE2zflJQVBEt4kR5i5Lz2S6z0TJXpfPqVs5?=
 =?us-ascii?Q?pHq4Ctv0hK8SKndT+weFaO4YlbFgr8he1UxDIqCgBbSI2uyzgW0ZEey2KCve?=
 =?us-ascii?Q?Zox11SEDlKQV5MA5E305EU7wy7g4oyBtmoEYcjnLmLVWnw2ZXeU3I+gQjqW3?=
 =?us-ascii?Q?cxH2kejUM/l7OVeITmHhTXoIRDLvlsrub8B6vQzviuD8BP0RKn0gy7+ciYRp?=
 =?us-ascii?Q?fD2X1oOFjP2zryWif3s2DqjQRRUL9hWI1ek481TkUko7zEtKTaIPH0cM0xl5?=
 =?us-ascii?Q?z6IICDmLQk96svpBMO/fXELWMlZtSM8PgxThxtEg8kPR2ZmCO4eSLAB6p7wo?=
 =?us-ascii?Q?yNWrU/Plvj9RH/Y1pxY0YE/uJ70a08iJTifOMYtT?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM5PR12MB2469.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6bca7f05-3f2e-4c0f-83f6-08db1adee98e
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Mar 2023 05:28:10.6237 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 7vMWcY3FG8EXEY1oNcXBNlDjImaqrDDQs6DQp4pHeo/jEeiqnvlLvJwetwdIUihfc4mjF1MPL0a9+EpCw2AXkA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8209
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
Cc: "Xu, Feifei" <Feifei.Xu@amd.com>, "Chai, Thomas" <YiPeng.Chai@amd.com>,
 "Koenig, Christian" <Christian.Koenig@amd.com>, "Li,
 Lyndon" <Lyndon.Li@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

-	    adev->in_suspend || adev->ddev.unplugged)

I don't think the code base is correct. Please double check it.

Regards,
Guchun

-----Original Message-----
From: lyndonli <Lyndon.Li@amd.com>=20
Sent: Thursday, March 2, 2023 12:57 PM
To: amd-gfx@lists.freedesktop.org
Cc: Koenig, Christian <Christian.Koenig@amd.com>; Chen, Guchun <Guchun.Chen=
@amd.com>; Chai, Thomas <YiPeng.Chai@amd.com>; Xu, Feifei <Feifei.Xu@amd.co=
m>; Li, Lyndon <Lyndon.Li@amd.com>
Subject: [PATCH] drm/amdgpu: Fix call trace warning and hang when removing =
amdgpu device

On GPUs with RAS enabled, below call trace and hang are observed when shutt=
ing down device.

v2: use DRM device unplugged flag instead of shutdown flag as the check to =
prevent memory wipe in shutdown stage.

[ +0.000000] RIP: 0010:amdgpu_vram_mgr_fini+0x18d/0x1c0 [amdgpu] [ +0.00000=
1] PKRU: 55555554 [ +0.000001] Call Trace:
[ +0.000001] <TASK>
[ +0.000002] amdgpu_ttm_fini+0x140/0x1c0 [amdgpu] [ +0.000183] amdgpu_bo_fi=
ni+0x27/0xa0 [amdgpu] [ +0.000184] gmc_v11_0_sw_fini+0x2b/0x40 [amdgpu] [ +=
0.000163] amdgpu_device_fini_sw+0xb6/0x510 [amdgpu] [ +0.000152] amdgpu_dri=
ver_release_kms+0x16/0x30 [amdgpu] [ +0.000090] drm_dev_release+0x28/0x50 [=
drm] [ +0.000016] devm_drm_dev_init_release+0x38/0x60 [drm] [ +0.000011] de=
vm_action_release+0x15/0x20 [ +0.000003] release_nodes+0x40/0xc0 [ +0.00000=
1] devres_release_all+0x9e/0xe0 [ +0.000001] device_unbind_cleanup+0x12/0x8=
0 [ +0.000003] device_release_driver_internal+0xff/0x160
[ +0.000001] driver_detach+0x4a/0x90
[ +0.000001] bus_remove_driver+0x6c/0xf0 [ +0.000001] driver_unregister+0x3=
1/0x50 [ +0.000001] pci_unregister_driver+0x40/0x90 [ +0.000003] amdgpu_exi=
t+0x15/0x120 [amdgpu]

Signed-off-by: lyndonli <Lyndon.Li@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_object.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c b/drivers/gpu/drm/a=
md/amdgpu/amdgpu_object.c
index d50f8bfb9be9..5554ff22d724 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
@@ -1314,7 +1314,7 @@ void amdgpu_bo_release_notify(struct ttm_buffer_objec=
t *bo)
=20
 	if (!bo->resource || bo->resource->mem_type !=3D TTM_PL_VRAM ||
 	    !(abo->flags & AMDGPU_GEM_CREATE_VRAM_WIPE_ON_RELEASE) ||
-	    adev->in_suspend || adev->ddev.unplugged)
+	    adev->in_suspend || drm_dev_is_unplugged(adev_to_drm(adev)))
 		return;
=20
 	if (WARN_ON_ONCE(!dma_resv_trylock(bo->base.resv)))
--
2.34.1

