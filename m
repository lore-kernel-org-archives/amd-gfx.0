Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6934DC77B76
	for <amd-gfx@archiver.kernel.org>; Sun, 23 Apr 2023 07:05:52 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AEE7D10E37F;
	Sun, 23 Apr 2023 07:05:51 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2049.outbound.protection.outlook.com [40.107.237.49])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 582B210E37F
 for <amd-gfx@lists.freedesktop.org>; Sun, 23 Apr 2023 07:05:50 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QcaZoB5WmTgKpdC7LDoS2HQUuMyI0F8MGIQeXoulwSsaFlV/LJpbAJZfAj2m2PHgPljzYpqDMX0VHLUJMnio3zIS0/BLFmXEc67+G7v/5HoAyzLHntCJo8EQ8307VFIr2oe/3OGasZs0i/DcznjHuaD5TktImvR13RWQpfc7rPbo8W99U+LqCEAxZbxKddWDzqjXsM5P9EyA0l9g0YL3kg54b+xc7ZRnG153iPI7BCGHd5zxZA+zpv1k1Uizg/Kh9pE/p86pMeNc6JmidsLm6iTf6Ocw13tLhONKEozgn7NCs7j1pCblO4qloHJTBJ/WTJKS+v/Y40NHZT2QB9Bc7g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FsK9T7l6aBELLpIXFxk4G1JmqyK8/A8mRMI9QbtfP3k=;
 b=aBO4E8kzyR7gT7K/12doGaWaZeVzb2l2PvC/r6zJs+UYyT2FAg7qt43gNbwzjxr/jP24hDtXbhXcKRNGmMF+oDNAu+4RVAfJBt7H5EzvKqjHeTGH0Rc/7XiflHMLcSc5RFo5BDLuC+v6isHrloxzUJEEGVSehgWjDdnzzfQugd8rZ8YsGjZ0ZLqfOdNP0OM25yDWLSd1HQG2WBIIgk/UzSiuCBmN5jHQSFUwYqRL68DDwUEPbhwqIhyBRF4OL0uzCh2IYG+KBp37e6BaonIAH01bRvbFofdRxhZcHBH4zxF5gk9QDb+845G9N4PAHUVRzZysro9ZgL/rlBIoY/0iAg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FsK9T7l6aBELLpIXFxk4G1JmqyK8/A8mRMI9QbtfP3k=;
 b=2STigDndsnNQKDEnDFMplNEIdI2foh89BuYpLAtk9l/TXjNPQkQa8GDcMuMykOUfeIr2VxTEAJ49zOq+0bLQsRuFVJTU/UYqhi8+0QjPFumM165gDipzFP/gA5sVjr1MGiBCoPIvJsV6BmM0AAj4FlHitaGyPv+Y52D42ytrHdU=
Received: from DM6PR12MB3035.namprd12.prod.outlook.com (2603:10b6:5:3a::24) by
 IA1PR12MB7712.namprd12.prod.outlook.com (2603:10b6:208:420::9) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6319.22; Sun, 23 Apr 2023 07:05:44 +0000
Received: from DM6PR12MB3035.namprd12.prod.outlook.com
 ([fe80::e92a:7e3b:f506:ee9f]) by DM6PR12MB3035.namprd12.prod.outlook.com
 ([fe80::e92a:7e3b:f506:ee9f%5]) with mapi id 15.20.6319.028; Sun, 23 Apr 2023
 07:05:44 +0000
From: "Wang, YuBiao" <YuBiao.Wang@amd.com>
To: "Deucher, Alexander" <Alexander.Deucher@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amdgpu: put MQDs in VRAM
Thread-Topic: [PATCH] drm/amdgpu: put MQDs in VRAM
Thread-Index: AQHZc6EIl96KGRHKKky0jk8S93tRDK84ezag
Date: Sun, 23 Apr 2023 07:05:44 +0000
Message-ID: <DM6PR12MB303568F1C971F49793126FFDE5669@DM6PR12MB3035.namprd12.prod.outlook.com>
References: <20230420155839.634172-1-alexander.deucher@amd.com>
In-Reply-To: <20230420155839.634172-1-alexander.deucher@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM6PR12MB3035:EE_|IA1PR12MB7712:EE_
x-ms-office365-filtering-correlation-id: 219d9b2f-1831-4637-d03f-08db43c927ff
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: CwrLlu7MoQh3jDFfiYg7rW1MHJrZOy9Ya1FqXsT78s6oJp9U5NmxHCQi5LFB8vOFwz3PA5NcWhT9EHYzFpsQfi4PGalDVkVwhGQCLk02IfSuAcn47D50a63ykfO9hVan1iybiEl3E+vEbUYuRL/OkKEZOfGLQDQWdCc+E6w7i43F2zkEVEWNCa3vCHnyqeOoapIvKl2gd599l9weuYl+A9REHUu6hQNvWdjCWfkEG2FZwu8t00O5nXv1sPT7ENXIIymMVdmy2hXO5zjxbsQykocAfq1o9+GDM7d5FStvEnlAuqaojKIMCUn0YUwz+0S272QN5JRPusPoqCrTdnmNaQZ0KIzvwnxaNs9CFyUhbFdjgJUvpZXwxG1CkEMel5vtftoqUifce0ZL2TyW8eqxZakdUSjzL8/xm4d9qVSoDoTr9YLU0hDn8vMzwRLLrC30jnWEDkkRz3RMB0IwmEY/0Xvx/HeT92noQPoMbDMaSifFwWmYYkNU4cE20KdWagLEhmy9JwEUjPG9ysh9ZhdSJ8DsnHbalo88o2538Wsca0wHGsYhVaoc/IsZ+GCae9dSFz8o/TLPhTxs4YC+bvtk2NM/j+xPn5hFpA3U3IkKpYq4wQAjKKHGSv8wXHv209Ju
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB3035.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(4636009)(376002)(136003)(346002)(39860400002)(396003)(366004)(451199021)(8676002)(7696005)(8936002)(71200400001)(38100700002)(5660300002)(33656002)(52536014)(55016003)(110136005)(41300700001)(122000001)(66946007)(76116006)(66476007)(66446008)(66556008)(478600001)(64756008)(4326008)(38070700005)(186003)(316002)(53546011)(86362001)(83380400001)(6506007)(26005)(2906002)(9686003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?ouWUGj0QV3BZvkxOx3ecnHm1FbIAYLhiz5nkXg/uW57QiOZpkItxBEewPUqD?=
 =?us-ascii?Q?UINGoAWIjkwGDcV3lDTo0KJF0Va5VkImt4ivnZQH2bnQ2GQmbCWICOOmIJNC?=
 =?us-ascii?Q?kO7Or5br360x0R6sKXBy1J5xXGf+RJj9CsseCuzR/h3ep/+WwuFK0fAphEzR?=
 =?us-ascii?Q?qpnKuLjF5GFWXgy/htNSSyEO6f0vCXxQ3sBh6UxSQ+nHQYHjqHKCon2hLQ1k?=
 =?us-ascii?Q?grq4sLHJo71uaLSK73OI3eCjfFWgZ2HforghMd1aIqPjejAMbL1ev+IgFSxQ?=
 =?us-ascii?Q?As0WKJ5+0xesaVyuXwLvvYl0LCfElqhq3kk4DUw6qnx2hlPuNQiNwReTX2Jn?=
 =?us-ascii?Q?m18N3LZ6dpv78yhgOgBGQ05Anp7M6WjO589TBk6bG8bFiklHTdiBGxmvZuhO?=
 =?us-ascii?Q?A+6UpJLYOkySydcEm99orLBu4rhcwLFecSDEhY5rGmHHap5JgPaQuTN2MVts?=
 =?us-ascii?Q?MtUro1M7OILYbn3QhLb/cm4SdXNbdZu5Hth1C3iy6DLGr3AsnNpHxs+Au/lF?=
 =?us-ascii?Q?rTZsf/wqStL+aa6FkB3a8dWl/nFFgAZ1EdRWFsCOHEImbo42cQFjjsVQ4KvW?=
 =?us-ascii?Q?IVUSCvlUQO30i/hlBmbyYgjC6rXVCdnHTzLtm/ZROXLRPTjd3SJy5YhASg9R?=
 =?us-ascii?Q?F7iuaPCPR60YLBOl22VdNq49X5mMfZbGuNU6Au2HvAS35e3DGgInlzDD4zYv?=
 =?us-ascii?Q?ozDxR7AxrHWbVCuqC07nX6MMgLRhqiMOSrvmfRYZAW5Sp+z8L72bn3nKiqow?=
 =?us-ascii?Q?SmqF/RXwsAh1XC03RYwuJKtqIhD/45RBvJbR99Swxdau8635ow3iqb0nN6UJ?=
 =?us-ascii?Q?VtlhvIAqdwRvoDzoTY8kFzbd7JxSwSHY2NZLEb6TEbG10BhqcE/xBCTyYy6W?=
 =?us-ascii?Q?Rryh529Mn0z86sA0q63PArFbJ14X44Yqmpzsg/auZHU871IDKHmfd2NVCxd3?=
 =?us-ascii?Q?qOI7J1zMx0+2X+Gzp7qowLAm2r8SFPHqj+dKVu5vLrhIjuyp2LKwXzOC5lAl?=
 =?us-ascii?Q?tErIxvsRq/tVX2IIkqs0az1UwTDV8XNKHZ1XSZJPiyihEJkKtqfjFHd569ZB?=
 =?us-ascii?Q?+UsZgEO6uSgEATLTM1cu43Ly8j5NEcrVcK+Vqu2vGHEFKWGFOQSkIleYxAVe?=
 =?us-ascii?Q?MHArRndUPez64oBRx6QGqxLlg5VVRg7utx5Pfmjq2N7mtS42egFKpGPO0S2x?=
 =?us-ascii?Q?Uq8UXeb11H+UTIdPDa/3w31Niu+cIZbqg5ZV0j6j+DxygNHImwIECos9Rxu1?=
 =?us-ascii?Q?nFfHfeq3XdmSo4/wGxeNTnt4U1Qz503G0l/pnysvXALywadWfUTRtpZJeNoH?=
 =?us-ascii?Q?znKF4rc2jOcmOU/ybQZm6MMKUzBYY2FhnZDi97LWH4xev2HSLfV444wrLNjM?=
 =?us-ascii?Q?U0NzGWvPNqBP074npYQSo1I0bbR3NidxhbhGCbOaOy/4qTrpzHu/A/Dnggck?=
 =?us-ascii?Q?KG1vHOrsQvZyMJjHmWSSy7voCsiDCBHQd7EIaJ8hqnSTPJzIniAxlaQYLjL6?=
 =?us-ascii?Q?OXwsAGpBlccmOzfYdZMX6UXEOEgkdin3tOYwivgTFrm0ZorEq9BQZk+rZogA?=
 =?us-ascii?Q?xCNfpG/9vQnh8SqxBug=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3035.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 219d9b2f-1831-4637-d03f-08db43c927ff
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Apr 2023 07:05:44.1348 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: MkCqOl3X7VllcYMOfvVGsRwJeLxLrgLgfpiyCBEcXxeAFpl3NMcnDl/nFB6oKo3CJt1q9nEmareyJ0AG4/SaiA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB7712
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

Hi Alex,

We might want to move the mes_v11_0's mqd to VRAM, too. According to my tes=
t result, moving mes queue's mqd to vram will lead to better performance th=
an only moving gfx&compute queues' mqd.

Regards & Thanks,
Yubiao

-----Original Message-----
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Alex Deu=
cher
Sent: Thursday, April 20, 2023 11:59 PM
To: amd-gfx@lists.freedesktop.org
Cc: Deucher, Alexander <Alexander.Deucher@amd.com>
Subject: [PATCH] drm/amdgpu: put MQDs in VRAM

Reduces preemption latency.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c b/drivers/gpu/drm/amd/=
amdgpu/amdgpu_gfx.c
index 60bb4bba1994..f52feee1d64d 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
@@ -413,6 +413,7 @@ int amdgpu_gfx_mqd_sw_init(struct amdgpu_device *adev,
 			ring =3D &adev->gfx.gfx_ring[i];
 			if (!ring->mqd_obj) {
 				r =3D amdgpu_bo_create_kernel(adev, mqd_size, PAGE_SIZE,
+							    AMDGPU_GEM_DOMAIN_VRAM |
 							    AMDGPU_GEM_DOMAIN_GTT, &ring->mqd_obj,
 							    &ring->mqd_gpu_addr, &ring->mqd_ptr);
 				if (r) {
@@ -434,6 +435,7 @@ int amdgpu_gfx_mqd_sw_init(struct amdgpu_device *adev,
 		ring =3D &adev->gfx.compute_ring[i + xcc_id * adev->gfx.num_compute_ring=
s];
 		if (!ring->mqd_obj) {
 			r =3D amdgpu_bo_create_kernel(adev, mqd_size, PAGE_SIZE,
+						    AMDGPU_GEM_DOMAIN_VRAM |
 						    AMDGPU_GEM_DOMAIN_GTT, &ring->mqd_obj,
 						    &ring->mqd_gpu_addr, &ring->mqd_ptr);
 			if (r) {
--=20
2.40.0

