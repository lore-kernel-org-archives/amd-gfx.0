Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E9A8FC77B7A
	for <amd-gfx@archiver.kernel.org>; Tue, 30 May 2023 07:08:06 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7D8CA10E349;
	Tue, 30 May 2023 07:08:06 +0000 (UTC)
Received: from NAM04-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam04on2061d.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7e8b::61d])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 47B1C10E349
 for <amd-gfx@lists.freedesktop.org>; Tue, 30 May 2023 07:08:05 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FhW0UgF9YQbvnBToNZAVrxXqwAvlnz5M4UR8R1q0RZYgYHJpjZWeGMcsvl8R5F0iOHItCMXQqTD0eOAaLM20l22ZOvNy9xGOMJsYqfswF0V0asDxFR1mT7WFHzopeBSVXruEi/cYBmZbAt0yqu+2I6vpV1xjrBQ9p8LQ42oVn0PkXlaBw7lCW9U3OMSH6Zf3or1dlReLBSwMyRB/AFCVhD8R1dcFci4ge5oDZEA4j9cdu5xxG7lgU0KlP0k1mLAaLIlM5Zf26vtafsfDdifLI1yWkfkBBmpPlSIaNpARElDfY5VZD3wH6iR8aT+nxHkK6HMfcyxAK2Fu13wCt2IaaQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uz5cZrK2tYW4fReDfLQuf07DxXyitNlxHrifoc3S/yY=;
 b=GiFWd5gxLOUTQu/sMD7aptqkxNhQuJ6mNvTAlLhgK25ku1Ts6meWO9nmLL8WUnzT9w+//VCnFlExk3HPTQNKh8sgFNovpI5uY8ZzoE1l+JfTxfdby3mK4yGRGxTXQZGSQ7ZVEkK5qWGBaQ5PrjqRPHWYqVwYc1kVpnW4uq+E9FRlDXoqJYz+gPVpebHmZXJrI+sWmmmdYyxWHzum5RHUerAmJ3rcKWANly0ZZi3txtupd/8rUTupGXsdKnPo6rZ2s0MqcYS4PAYV385BokwXKz7O5hG+BZ31VWcEhha7/zj3SXTdFvT01ooaPd+yWCIFNGoGidVZckNFegqQ5jrePw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uz5cZrK2tYW4fReDfLQuf07DxXyitNlxHrifoc3S/yY=;
 b=2a56bxF54hqgoC7NQTaYR8jeoKkhX8nAmV9WiBFYhSUGWG5eaexFiXTbKwJqDPgRqSwa6vHdmWIS+jHOOXaw9SycsnBrFL19iIW307EvdFrQuhdXCnuUr1vvgnuEb0hqxXPwiCyt3Sh0XSNBcwCGitUhvEzupYZ/xOY8bDClIO0=
Received: from BN9PR12MB5257.namprd12.prod.outlook.com (2603:10b6:408:11e::16)
 by SJ2PR12MB7866.namprd12.prod.outlook.com (2603:10b6:a03:4cc::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6433.22; Tue, 30 May
 2023 07:08:00 +0000
Received: from BN9PR12MB5257.namprd12.prod.outlook.com
 ([fe80::9c90:4cbc:7d12:fb99]) by BN9PR12MB5257.namprd12.prod.outlook.com
 ([fe80::9c90:4cbc:7d12:fb99%3]) with mapi id 15.20.6433.022; Tue, 30 May 2023
 07:08:00 +0000
From: "Zhang, Hawking" <Hawking.Zhang@amd.com>
To: "Lazar, Lijo" <Lijo.Lazar@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amdgpu: Initialize xcc mask
Thread-Topic: [PATCH] drm/amdgpu: Initialize xcc mask
Thread-Index: AQHZksMXoymaEM+q40WxQTsjEvERVa9yZR/A
Date: Tue, 30 May 2023 07:08:00 +0000
Message-ID: <BN9PR12MB52573AC13F3A63E4210127D0FC4B9@BN9PR12MB5257.namprd12.prod.outlook.com>
References: <20230530065040.573148-1-lijo.lazar@amd.com>
In-Reply-To: <20230530065040.573148-1-lijo.lazar@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=f82cdacc-1142-4a0c-bebf-af74de5c82ad;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=0;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2023-05-30T07:06:57Z;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR12MB5257:EE_|SJ2PR12MB7866:EE_
x-ms-office365-filtering-correlation-id: 48f1023e-836d-4219-57d8-08db60dc9aae
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ZBQd6eu4tEB6vNRQRQ/358yZahfDQHcV1PojfZ93UfUkhDm0E1eaYRmR80hSfo4O7iNy69zocovVgPLoVf5RPt983zFh9VSvXDKAIGXLt0QR5544iuYd9mfCQ9venyDMjhRvbQtHUiNwJ2zmCdRbAJCD64IKLHRmMRw6o73suRxnFPt2csyBXCiEZjJ/z//gi0BavWoRKtOdKuVBd5uT5cPpMxfOv3OKl3MiejfQCsyCbcKPiR9Mb2YhRh+2Oxf+7NmlOhDr24U2fv6g+K1LxKFb0WCh8w5QUQEbmNC0yEkX/b3s/d1dLKMMFrn4eehrGgHFXMKmnOGKkaSK+SuRCUx+q8f5vmDL0t8D0DdK3XvZKUp7wDqz6mRZzLM79hb9oaFnfOozM7/tAxyjTnkLL797U5IwDq/8JOpyX5AOtIiTNFS1zGX9mpo2TcpV3sCD4NkTM6x887LpMyjCPzoAmr+EnClCoWZh5OZ9iZO48F/crSP1je6VYmvvZPBfQuJ3F9MPb89GsYcS+g30rOvPIKeF5gcHr9VqlfAn/WxlUJZsPZUsR0w+yLW8eFs+rS8d7ALD1tX5fHxEEzD/SEvx+Gdlt4YekLvL/3p46B7quyH4megGmqKINPHATbowimnO
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5257.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(4636009)(346002)(376002)(136003)(366004)(39860400002)(396003)(451199021)(33656002)(26005)(186003)(53546011)(6506007)(7696005)(9686003)(316002)(2906002)(71200400001)(55016003)(5660300002)(52536014)(41300700001)(8676002)(8936002)(478600001)(122000001)(38100700002)(110136005)(4326008)(86362001)(76116006)(66946007)(38070700005)(66556008)(83380400001)(66446008)(64756008)(66476007);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?kCbmx/OZqKd8XUCTEG8TTWFatxARvvm7qEZC9mE29PrkH1cs7gU4Zl/rrQze?=
 =?us-ascii?Q?P0zjwrb3LesqDpVqb3R82RC9hwwF6mrJnKrZdU7NKQUaeHd21u88zCqyp1Gn?=
 =?us-ascii?Q?IHwQ/GwjgGFq9rrDr4aFe6H+jwaS5VGsgWCbqgAvG4vb1LFrjAknsIxJvH+h?=
 =?us-ascii?Q?89CcxlSKEXVub9m3u4vOABlrVc59H63o4C42pm9JV85gJejqAWC1OY5HUcmk?=
 =?us-ascii?Q?DOqHqMbNLqJ8LlFGcz30xKH/iAzvC945NgIacsmN588+fkwUjQzcKqGqWsp0?=
 =?us-ascii?Q?Dw7llSohFnnJtl6kwrOe0qAiqhq4bKaj28sQkvlTezJNm6T87LfuxECeZYyO?=
 =?us-ascii?Q?dJgLEyEyzTk0+zFfwfeOln4448MNuikYqv3kxZIHtKVn8zRwHks5SHCItBen?=
 =?us-ascii?Q?YaLXchcZ6RHUynIq82J7VbR5QUVsk98dbIsv3WOnHWwpeIKmEnPmUHDhDbDl?=
 =?us-ascii?Q?VYPcnd86jktKEILmDlcTnAOWIt1E1UDgjRHa9Sf7/DnDjbundZdzS9F4YVUU?=
 =?us-ascii?Q?xSlav+1/gBb/0srxO0iHH5ZVR+Kv/G4uXX/UNoewF/ZB5aHeSwPUwuxpPrLP?=
 =?us-ascii?Q?KkKp0ucU1WEZgi7JMN8uiljiXCzaTGS2dWNctNPTKSGdo8v86lgJveqGEkrl?=
 =?us-ascii?Q?CQ32HJGYgdQz9LsIzKd18G90kLo0L4I1mmA/02W632v3JS5Wv2OB2zcGc2ms?=
 =?us-ascii?Q?WJtKF2Ubg+nMTUWecfMGfrpFwiQMLRFhQkWgo8QvXgoPHhmuDly7hpeeVqv5?=
 =?us-ascii?Q?rcZUm+jbaxettdsDxhyGV/m54cys5/DhxPau0rGkftAgIwvs8mcSso+UmBv5?=
 =?us-ascii?Q?/qTKDvmVewTLN9x3DLBunxja4hdorcyLOVcBua+QNt0JTn6DdnLhr01QsKCk?=
 =?us-ascii?Q?k3Usj1Wpuhv/zsf4NlCs08fpBrG7DmnFKENPkknS9TOaWsCE0Edj+az3+x08?=
 =?us-ascii?Q?fnL6jaoZ/1xBxwWfgYPT1c2/7kMFbKzGeoc6pZ3AucUqFYTKYyqnwC7AifAW?=
 =?us-ascii?Q?7Ztn9n/lUtEz+aZ1GwLAgVm0udcfL3gcZs0efbEHckjSBkxs3Kyty8LEAA7G?=
 =?us-ascii?Q?fYysYCJkHP439lXhLe2ac1QVA8r3zGEavo0zTgq08yj7fc9E1y+jebuF+WBJ?=
 =?us-ascii?Q?+LI6Zbtbu1yMAzko9Jw0bd0YIXyZCB8E8bJE4IIruGUo4g0VpN/0+rkYj5qq?=
 =?us-ascii?Q?L3+Lfingivja8oqrQCCjIFjYP2m097/8Vhry1Fs95kEwY3Np8YPQD+4f2wSo?=
 =?us-ascii?Q?JarAOuIhnscH4OZyM2hLFyiGRZlMHYPd45KB+Mi2koxHBo2QEfkMkduz1/5x?=
 =?us-ascii?Q?aU0Xw1urfynn+7OFAWpe0nakWUZOM/QKjPG2RX7U1JtWzisZydTZNaON45vt?=
 =?us-ascii?Q?CnkRzs0CdPTuHIsSL8Pq0VNwcwptStkU4Eb8Xyqa6qwa924s4viWrDjxYE8D?=
 =?us-ascii?Q?Ps51K46piNEFh9nu0XvG+kPonPqCU2o0eFp66KABP9H5b1/7kbt4nniyZ/ce?=
 =?us-ascii?Q?SvG06os66jckK9L5FDvj4sMCa6+RdTszSgKhEhO2YlNb07n7md0Iy0a3Ivqu?=
 =?us-ascii?Q?qnl+PaYldagUOXWdzLMOc7iyy5x0ghIQ4DBzBciS?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5257.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 48f1023e-836d-4219-57d8-08db60dc9aae
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 May 2023 07:08:00.6914 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: B6bE3POCHxnzPKtX9pzM3rQDHjon/CIOCF8Docn138QG2+B7sQkVTCVkFJmRO9aIFoEV6rtYjje8QWLy/6uxSg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB7866
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

[AMD Official Use Only - General]

Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>

Regards,
Hawking
-----Original Message-----
From: Lazar, Lijo <Lijo.Lazar@amd.com>
Sent: Tuesday, May 30, 2023 14:51
To: amd-gfx@lists.freedesktop.org
Cc: Zhang, Hawking <Hawking.Zhang@amd.com>; Deucher, Alexander <Alexander.D=
eucher@amd.com>
Subject: [PATCH] drm/amdgpu: Initialize xcc mask

For ASICs which are not initialized through discovery, initialize GFX clust=
er as 1.

Signed-off-by: Lijo Lazar <lijo.lazar@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v6_0.c | 1 +  drivers/gpu/drm/amd/amdgpu/gf=
x_v7_0.c | 1 +  drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c | 1 +
 3 files changed, 3 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v6_0.c b/drivers/gpu/drm/amd/am=
dgpu/gfx_v6_0.c
index 809558c718e3..da6caff78c22 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v6_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v6_0.c
@@ -3028,6 +3028,7 @@ static int gfx_v6_0_early_init(void *handle)  {
        struct amdgpu_device *adev =3D (struct amdgpu_device *)handle;

+       adev->gfx.xcc_mask =3D 1;
        adev->gfx.num_gfx_rings =3D GFX6_NUM_GFX_RINGS;
        adev->gfx.num_compute_rings =3D min(amdgpu_gfx_get_num_kcq(adev),
                                          GFX6_NUM_COMPUTE_RINGS);
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v7_0.c b/drivers/gpu/drm/amd/am=
dgpu/gfx_v7_0.c
index 0f0c12bbe228..20fcd86a3e79 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v7_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v7_0.c
@@ -4179,6 +4179,7 @@ static int gfx_v7_0_early_init(void *handle)  {
        struct amdgpu_device *adev =3D (struct amdgpu_device *)handle;

+       adev->gfx.xcc_mask =3D 1;
        adev->gfx.num_gfx_rings =3D GFX7_NUM_GFX_RINGS;
        adev->gfx.num_compute_rings =3D min(amdgpu_gfx_get_num_kcq(adev),
                                          AMDGPU_MAX_COMPUTE_RINGS);
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c b/drivers/gpu/drm/amd/am=
dgpu/gfx_v8_0.c
index 2f1ef75e126c..51c1745c8369 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c
@@ -5262,6 +5262,7 @@ static int gfx_v8_0_early_init(void *handle)  {
        struct amdgpu_device *adev =3D (struct amdgpu_device *)handle;

+       adev->gfx.xcc_mask =3D 1;
        adev->gfx.num_gfx_rings =3D GFX8_NUM_GFX_RINGS;
        adev->gfx.num_compute_rings =3D min(amdgpu_gfx_get_num_kcq(adev),
                                          AMDGPU_MAX_COMPUTE_RINGS);
--
2.25.1

