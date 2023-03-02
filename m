Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 98FC2C6FA8E
	for <amd-gfx@archiver.kernel.org>; Thu,  2 Mar 2023 06:37:18 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3245910E37A;
	Thu,  2 Mar 2023 06:37:18 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2061.outbound.protection.outlook.com [40.107.223.61])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5635B10E37A
 for <amd-gfx@lists.freedesktop.org>; Thu,  2 Mar 2023 06:37:15 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ddVkV1L5LjQL0jZdwog6/fb0bYJq1o5bf7Ofg6o25OJAA3SOPQIGLrQlPcOBSCT7F/RV2nS+kehaI6SMTmS2puOa1yQsJNCK5cbG1MVHjiL6syscSnnEeQ8lXndPSGZ4PavukqDfWe4G9eeKXhOVBAbjKsAHH99OQ8WMzvgnvqU0U8227QXJOCEoPL4sB56VrNpbJdPcgGdok6NELFsFdFqeKgeAhRZeGgKgl04NYN6a2okVELCM/So8qDOF5Qeeb8uyPvh11Df90tiPBehXSF3YOKow+XCxk+FBvn5hdYT3Fk1U8MvFVK5iuneDaeE+2rANKdAKQpeKP7pw4lBUVQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=X7DkA0Zkf7UdbIHDJWUiKYCAA4Um8jxHJAmpF49iQHc=;
 b=n5aafeQy1KfOhyGxujyeZo1S0G2moxbUvkIgl/AKObM7hkV1y7a0O+4hESu4Lej/ualKkwpQif0J37MEtYcvj3m7tReQQRhgiYCyp8baCe2gei9qV5S+PUD7Fzc9sLAjexY70AKm0Znr53TpgXkvA9fbw18fTN22PtNwEZERfmACwx0bv0NogjxIgGArj6bKe7NDB+sgK9Alav6ygr/fxP2KPjhzgDyBVatRdK+aZOrD1OH81/K2oh1nD10GvmuWYnxoGZIJwFFyrqy5YZk8Y/4/BDtlMISFYEyZ5qWZdYAp8bVxqa3SLKW25AMIeR+kEQG2e4v+M0fTQqcK6b8Vjw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=X7DkA0Zkf7UdbIHDJWUiKYCAA4Um8jxHJAmpF49iQHc=;
 b=lgl1L59gauNKhoRJnnyczFske1XGWTKryeB0fzUzoQDbnO3idnQE1bvl3dJ0yIA2n5oJtgxuY/cqayojKYWhNlAO+xpVdmRTCg+sjIYwg6JCFFQBExVLRgfY78oaNUk6JTvS+qTcWxE0lv1ADjWPfMMmTTgnehSgnBhZB7S2Q4w=
Received: from DM5PR12MB2469.namprd12.prod.outlook.com (2603:10b6:4:af::38) by
 BY5PR12MB4132.namprd12.prod.outlook.com (2603:10b6:a03:209::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6156.18; Thu, 2 Mar
 2023 06:37:13 +0000
Received: from DM5PR12MB2469.namprd12.prod.outlook.com
 ([fe80::5ca6:3a18:d6ee:c103]) by DM5PR12MB2469.namprd12.prod.outlook.com
 ([fe80::5ca6:3a18:d6ee:c103%7]) with mapi id 15.20.6156.018; Thu, 2 Mar 2023
 06:37:12 +0000
From: "Chen, Guchun" <Guchun.Chen@amd.com>
To: "Li, Lyndon" <Lyndon.Li@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH v2] drm/amdgpu: Fix call trace warning and hang when
 removing amdgpu device
Thread-Topic: [PATCH v2] drm/amdgpu: Fix call trace warning and hang when
 removing amdgpu device
Thread-Index: AQHZTNDTHR1Mv27QOEKFllJV+F3JOK7nCMEw
Date: Thu, 2 Mar 2023 06:37:12 +0000
Message-ID: <DM5PR12MB24697AF86D8EB001697D9B75F1B29@DM5PR12MB2469.namprd12.prod.outlook.com>
References: <20230302063243.11096-1-Lyndon.Li@amd.com>
In-Reply-To: <20230302063243.11096-1-Lyndon.Li@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM5PR12MB2469:EE_|BY5PR12MB4132:EE_
x-ms-office365-filtering-correlation-id: ccb686ac-29cd-48eb-e142-08db1ae88e69
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: MbFf/Hw4j6Jvbv23UDBmhbklYT5xzPGRQkvwmmN1bTeKmMFcQZHpPJmdrigQULVOqKeb0qAUUuxdUxuJ2vzBX4spHPK2LdzsJdFIfIf/v/fabnBXiXKvz27+SraNl3mM7rOtNkG7Fv+vrsyAAtO2+pj3kYpei9wfQw5kwKP7qwK9DiEoX76xhBCK4QTW2AmVXT/KC7NMm6/7r1gUMbChEUrI7SeQUXeL9DPU1vBeBxyAAVdQih5n8ysIVB1MlKnaiznKWCUpCFY5g36lpXpkCXmnE0AhxoIClvEwmroUwS54z22EH0FhEECXTo2HFTxegRyX3ftDlAWXZ6+xtGFJzSAuLb7Oh2re3uTO/w947uTbqgrd8UF8V6mfR3nvtHGR3lXBtTBE1c6M9MzpKoYJqElrbUrSlqPN67xPpxwoKHrrPCMGBRn41EuLA2JcOGrUWZQ0UsIyUKPKy/YDTKzdDu8vBCQFnW/5tHqB6FAjGMksCqonfpysge4s6fcu+vD34aZ4AcnV5deZczHBe+Pqy/aGP9rsEobMhETWrhSfijyZWprwjtIWmEmleAdxxpKby1RqEUkVhgkNtHkKyDTZuQdWGEnV4MoZxzjmnU5J4VA09Af6FNhs8BsBnx9s1rzRWAKxVziNhXCCeqkq8Xl/9ytjhIKy0i/ZJqQDtTrpcGzIA0JsnU8hD3tGqSRBCoywsm1I+in8ayu4wCb0Le8L5g==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM5PR12MB2469.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230025)(4636009)(376002)(136003)(396003)(39860400002)(366004)(346002)(451199018)(83380400001)(38100700002)(122000001)(5660300002)(478600001)(8936002)(52536014)(66556008)(33656002)(86362001)(38070700005)(55016003)(26005)(186003)(9686003)(53546011)(71200400001)(6506007)(66946007)(64756008)(66446008)(66476007)(8676002)(7696005)(2906002)(76116006)(316002)(4326008)(41300700001)(110136005)(54906003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?9QDZNsyMB17hMyEqBn1ELkH4E9tsCmwMpmVLzvyx0KtBeaqsMfkSVqRsLjDs?=
 =?us-ascii?Q?Mp5jVln/uI5ky93Q5ZAhrQRgId9ewCdQow7/X66dMlfbllzDU9yNQvMSdUoQ?=
 =?us-ascii?Q?l21Ack6BN/OxMPkf+GZZ8x0k+3rXnoIbVo8Fh4qqRGOJMsclIrFrmhs1w5T+?=
 =?us-ascii?Q?zQyMGmHDOdaAFIMLpYKGgeX+QVAz15u9bMS9kdY06dBnWtnNiIJWyu0YcJT5?=
 =?us-ascii?Q?I3UBwJKKDAGK1cBCAb5J3ZW8VjG9TtH+4YOXRkipCv6IarX49kOGs4eONrQu?=
 =?us-ascii?Q?+YVUux1RM9MXgFYdmOilxiBl8zJhiW8uubapGy0ThEv+mkIKNtWxFJjxh6P5?=
 =?us-ascii?Q?fBYRyiC5j6/RDHfhVjkBXPSUl7vHjVpZNDLI8mRUZ37c2or5rnHq3P51PNEm?=
 =?us-ascii?Q?XuilbwlAwPMhFiTtyc6T/omGH+qyvdc3Bd4Wx8h0ZhFSixvo0KhX67/tC9wB?=
 =?us-ascii?Q?X9VnwlL5TgvCVEk3rd3k+60WJdcSpbZVGO27btwiV0mohn5gBJB8qh4+TaZ0?=
 =?us-ascii?Q?WsZg5J5KJVdUr0zIKvdDPBSNvk3/3JVM6WkQrO/BOsgFOmS9E7qmST9t3aj+?=
 =?us-ascii?Q?d40fL0K0DcU760Y29rPNpvPkYXxYP1wnHfLwoPTCMNAhNNcijJvnOLUZ7iPL?=
 =?us-ascii?Q?avVV3j+EL+1+ZdVAbR4nYcxeA9oe0pfeGe6ZisR+6serIhzcSx+Xiu2n5Qjq?=
 =?us-ascii?Q?o/FoY+WWQuEhybdDBKV38+QWn7jrkBxPXhlKTFXKjX8Y41yXoNBZRcbDLY1Z?=
 =?us-ascii?Q?EEl3KUa0c8vV42r5zelyukmcGgguKG1tbwISqvCAb9mel8JDgOmvIm3P6vcE?=
 =?us-ascii?Q?rP9ommFICqZ6Oc0t3lqTBGogum38akxvF5k7QKbYhraUkygj4IdAxNyg97Ua?=
 =?us-ascii?Q?2r8nU0PO1o3JBQr6hbBBRQJXtdxC22eOTW+dpaFnp1a6IrvZ4BoKuAhhOIAY?=
 =?us-ascii?Q?EhCoehsdQAgSB2zf4K5ccX7jm7HRuoh6Zmz6Zr1LBav+wwUYbfA+2vNz8wFk?=
 =?us-ascii?Q?jfH3fY7keeX9UF7XLGhG2OsayfgECUPvqjZsN0fFY3oBcHdifKqWQ+5gpdh0?=
 =?us-ascii?Q?l350IXmDsJp7g1JFGmK5qT3tS1oBkjUJTBfg/zp/tL/wO9Tweo1CYN0Jd0N+?=
 =?us-ascii?Q?+mn0ulh8+AkhFR9oM4H5aMvkmV5hZVPsQqEluEpLzRPfaWGTTkskhmqbm2Jc?=
 =?us-ascii?Q?9i33wdQiG/3FiowvrAnCcCt/bxd4VV/9kwIhAu2gLRLff9xx76zHqOZpDM6p?=
 =?us-ascii?Q?1EGNsIvum7CYJetYAon5RV/H0zF0JyZ5wRpFUbpQ+ypa5H+5LqpWoITRNlr+?=
 =?us-ascii?Q?MCZFkmp4BZ5wd2VxC0lUgIVMUgU+kb2UMdWFrqk2s918tM+ts44sdgeXSSkI?=
 =?us-ascii?Q?gu8fACIZrvrGyvHIcFL4HT7Xdv4wmDG6CeemKX9i2Q7ebBcPjKcKMZ0r9N3r?=
 =?us-ascii?Q?70m5FtGHtzNn0rHjy8KwSC4zR+Jq5vU10Gk0iehZ0K0XynYBui9mFFXQUh6Y?=
 =?us-ascii?Q?GAOFJ2yEBK+45a43nHh6z3Z/RiKublCKs9HCgTD0zW+3102XucxHNnX1yI7C?=
 =?us-ascii?Q?zGsSQiWZpnH5CMO1pAOgJZYdqqCceq58GqYu0Pgu?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM5PR12MB2469.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ccb686ac-29cd-48eb-e142-08db1ae88e69
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Mar 2023 06:37:12.6783 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 0/ZCP+Tjg6FYKpfNyFPI5hvXTkkB5bxXRtZWB0rfjR6YvsFiwrby7rJ4y0kohPVa7d+ZZO+DCmA1aWoHViJRvQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4132
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

Reviewed-by: Guchun Chen <guchun.chen@amd.com>

Regards,
Guchun

-----Original Message-----
From: lyndonli <Lyndon.Li@amd.com>=20
Sent: Thursday, March 2, 2023 2:33 PM
To: amd-gfx@lists.freedesktop.org
Cc: Koenig, Christian <Christian.Koenig@amd.com>; Chen, Guchun <Guchun.Chen=
@amd.com>; Chai, Thomas <YiPeng.Chai@amd.com>; Xu, Feifei <Feifei.Xu@amd.co=
m>; Li, Lyndon <Lyndon.Li@amd.com>
Subject: [PATCH v2] drm/amdgpu: Fix call trace warning and hang when removi=
ng amdgpu device

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
index 1c3e647400bd..5554ff22d724 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
@@ -1314,7 +1314,7 @@ void amdgpu_bo_release_notify(struct ttm_buffer_objec=
t *bo)
=20
 	if (!bo->resource || bo->resource->mem_type !=3D TTM_PL_VRAM ||
 	    !(abo->flags & AMDGPU_GEM_CREATE_VRAM_WIPE_ON_RELEASE) ||
-	    adev->in_suspend || adev->shutdown)
+	    adev->in_suspend || drm_dev_is_unplugged(adev_to_drm(adev)))
 		return;
=20
 	if (WARN_ON_ONCE(!dma_resv_trylock(bo->base.resv)))
--
2.34.1

