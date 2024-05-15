Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BB945C25B75
	for <amd-gfx@archiver.kernel.org>; Wed, 15 May 2024 03:59:10 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 410E210E083;
	Wed, 15 May 2024 03:59:10 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="ZHcP78Bm";
	dkim-atps=neutral
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2074.outbound.protection.outlook.com [40.107.236.74])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BD84210E083
 for <amd-gfx@lists.freedesktop.org>; Wed, 15 May 2024 03:59:09 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=f96rKlTXU2iFUSrk/jjg2nwFMX47N6ecqv3Cbxav4614b/fApBsuM+YgsjMEWTR0Ln0w6sx1xgwpBHNq61SEwLaekVxcsFrzf9bEnFGgzLrGdjyOpPu2yKTuxgNdM871o/9FcGy+ZddtwEKS0BhngVDpKsve/+lSO4mioh62bzvh7MbFA8mvdf5yEw7NWfUDp6pJ31CsYkFsdXb6tjWXjcqnnmamaGP/crJ/NJXGUTUWTsVdtIElyeHNclbXNTsRTSkYD5oalKr2Zotll9sEWpdAHjMcDSYsLgyY9JQuFCHoJfOiIxq+glMExuCvH1P3t26Y4iZdzXw4mgPloaZz/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VSmGBUyYarQRZDEoyqvJfgsTlQQnQA8/XaJzaU+u4Uk=;
 b=mUrTOL/vuk16qxj19FEe5F870qHsWLi908/wgSqqahNLbo71Yal8W15bbvakhOi5WNFVNV3cIcy0i/wutDnQsB8DESifE+pzfDBCZgRzJQV0G7MFoHp3j/QgmeGORyRd+tNkIZFUWWebBEiS8aSf8eGnbVQsaeCpYiEYugd2/OnfBBbMLEN5YwM2fIwhICUkdbRYG4bHj2brx3naVQei2JPzYYgm7UYeSoCPCBoMVmPkwPVqcR0YKruTtqiTImR5S6tznRIpZEJRipkD2tMfQS42iak/uHCpoqBrpRPHaErpbSzGcqdfcQW5PentlptRtJ+PoE/Q+b8ZPU9Uz4xPIw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VSmGBUyYarQRZDEoyqvJfgsTlQQnQA8/XaJzaU+u4Uk=;
 b=ZHcP78Bms7IJwb8V/vWuNJLPZM9VxRrvjX29HI5kPN6tLBhNteK7l2zNSoqRL7BPCGlIeuycxKWeLA9ovtN7Antm5AWLLEFh2ovn53t8s8U+YLeMXPS9sjO1TW4di6ZvkwKKrHbIPUn1qV9j7KL7WSJOKNDzsjjOQ2LgKg7Pvlo=
Received: from BL1PR12MB5254.namprd12.prod.outlook.com (2603:10b6:208:31e::21)
 by SA1PR12MB6919.namprd12.prod.outlook.com (2603:10b6:806:24e::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.55; Wed, 15 May
 2024 03:59:07 +0000
Received: from BL1PR12MB5254.namprd12.prod.outlook.com
 ([fe80::826b:fb00:2eb9:5b58]) by BL1PR12MB5254.namprd12.prod.outlook.com
 ([fe80::826b:fb00:2eb9:5b58%6]) with mapi id 15.20.7587.025; Wed, 15 May 2024
 03:59:07 +0000
From: "Zhang, Hawking" <Hawking.Zhang@amd.com>
To: "Deucher, Alexander" <Alexander.Deucher@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
CC: "Deucher, Alexander" <Alexander.Deucher@amd.com>
Subject: RE: [PATCH 2/2] drm/amdgpu: fix documentation errors in gmc v12.0
Thread-Topic: [PATCH 2/2] drm/amdgpu: fix documentation errors in gmc v12.0
Thread-Index: AQHaph4SPdx3DQ5GiEGHHuI6d/gBt7GXrB8Q
Date: Wed, 15 May 2024 03:59:07 +0000
Message-ID: <BL1PR12MB5254D64806F545584ACB6A21FCEC2@BL1PR12MB5254.namprd12.prod.outlook.com>
References: <20240514164420.1111568-1-alexander.deucher@amd.com>
 <20240514164420.1111568-2-alexander.deucher@amd.com>
In-Reply-To: <20240514164420.1111568-2-alexander.deucher@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ActionId=f57dc635-9389-4992-b638-19e4285c5c08;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=0;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=true;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution Only;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2024-05-15T03:58:43Z;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL1PR12MB5254:EE_|SA1PR12MB6919:EE_
x-ms-office365-filtering-correlation-id: 1cfd1f54-9e36-4714-686b-08dc74935e57
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230031|366007|1800799015|376005|38070700009;
x-microsoft-antispam-message-info: =?us-ascii?Q?G8OI/0m2bluptm6Ocmy1OWnAYwO0KgN5l6rSCbU3Qtnj1mFspS49MO88b/3O?=
 =?us-ascii?Q?ZDNDHW8dQeuwW8r6UkRoDG7hj2mTSG4dNjoY/KFPV6LKXegf9GVzMp76qbln?=
 =?us-ascii?Q?mOANG9tcD+U2L7IIql45d14W6Ke5TDliUvxuxMcjWLEAA0qoXRw82Bz+64d6?=
 =?us-ascii?Q?IfEoyB1rFWrYIIzCroARL6sZPZjprG3vty7l1k+y10qZLL8PT/hUMq3uLPIB?=
 =?us-ascii?Q?PCv2TqJzqzI0qBGyO+BzMdwiUJY0ydTvrAPwwpUjDjjM+w5PfRyEdrHD0vn6?=
 =?us-ascii?Q?mszOd+KoWraDWj7xvHMq8fhFYvfX+6X7yklwh44OS5PZIUiQVy0vxdpI7iVe?=
 =?us-ascii?Q?GCqXW6vfQSLSAwqV0ieP3a9/O9ZAKIHuhUnsUtStdW25g0cLz+aCetFufUUr?=
 =?us-ascii?Q?0X8P/yuJ8ReD7Yky5/75nehDznU5ecJ2VByq7CM5eAcGgDETFrLC4hjkKJ+q?=
 =?us-ascii?Q?nmeziesy26T69sYpj7fTg25Nvt15VkAb/+KCORpSJUHo26hhkkOqIzgpod1c?=
 =?us-ascii?Q?M3S8aCVvzflzrGq+O8fk1SvaZzrUSyqS79cFXCQv+zOLuxPTHM2NPOQOR5mY?=
 =?us-ascii?Q?RDRolGWWkfevJv+8ramDdzhtrDLyEkkM67H2Xxff/z0pOTwOvY3tWNbNpGD5?=
 =?us-ascii?Q?PyOfPO1Jwxv8Axnq5IEctl9toy1nduaIVh6wbbsVtLSCg++FgnD5nvHUTFpX?=
 =?us-ascii?Q?17QccJEMCWKIR4FwUB0H0begu11YVv7zCAzJfKQ+ItLkJybhqIhbWqZyDt77?=
 =?us-ascii?Q?aGqQR5F1DHPKLB0OAgOco0KSu5f1gKZlvB5ucm2gzR03BLsIA4lzPlLfaK1C?=
 =?us-ascii?Q?kuPgn6zwhhBqGX0PWmJl8BCw5sF+Ha3Zvh4GCNd1iOcynJBu/baDCDhaQKDQ?=
 =?us-ascii?Q?1lnUZkLEMvvl5xkIEnPX8ElFzhu2CLSA02+UVglch7xBOhkR+NP464DhHxLQ?=
 =?us-ascii?Q?rGp6xR7p+Yx+OIaz+JAB9ET0r19t7/bCXWjuAE3AXrbOBx9KLKaENyBGWAQn?=
 =?us-ascii?Q?nOd053EG7wb1KTRKYojgoqHge5TEjRKu/uWjZFnxEmIVXR+oYE1ELRnCJOkP?=
 =?us-ascii?Q?LO+I1PoJ4QkRPVbVnTzVcrmFGP4pGVPV9wL7oECyUXzeN/0Si9E/4asHxgMT?=
 =?us-ascii?Q?5RAfQmLDOyTxV7Xvp4cirvjCPFSZ98DPl44NMnnIbGTOY+b02WqZyd4yISnt?=
 =?us-ascii?Q?avm8HFSTDaRoWKrzAYkmTxvAQUsRmuP+0eHXfv3XNLtwsCWsXmP0B62WEV/y?=
 =?us-ascii?Q?PeRkYgsW4DzHzrh5Id9LG5QpdiZBd9ETChUBwhuCaPfjEJmqkzoZXrl9jWNy?=
 =?us-ascii?Q?hmWGtJaIwvnp1LoYh6qxLkywk0Jv+WNn9g4pQimHPZYD+A=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL1PR12MB5254.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(366007)(1800799015)(376005)(38070700009); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?HVwM3wUgey1j3Tlxo6TFtbVCTFjgmMEUxOYL/PqigNy7SySanL7T7kV14gId?=
 =?us-ascii?Q?cc4a3BwKRfmiTYmBVhuvdk06bj3c0vpFOQVCNqFmVnF3MhBZv6gtjdV2L1Ai?=
 =?us-ascii?Q?HsYWrPqP/80Yp0XUDAqnkT07Bp5GUSFt6PcsClRZzRGEQ3kgAoCD/ME99/qQ?=
 =?us-ascii?Q?wuBbsAwSBo2xrnEGB6DwVHtm9GVEUMeFZQaClznBub8SWdDu42fhgTY27bFO?=
 =?us-ascii?Q?8I2eqCBXCBgzIROhffI6jvKV9j6KsioQkRKXon1WvBsp3UZUYUC1p/K75Lsg?=
 =?us-ascii?Q?cds7BCeTqKCiKzg0EZExMI/6+D79KQFBTjOVO6FcwW7sqfOxP2RBQrIz1Vd7?=
 =?us-ascii?Q?UmojP5sUFhlnp+QEzvvoYeLtV7+ihcHpk2HcxQFo3y39QIb25upMldX5gc14?=
 =?us-ascii?Q?yjG7/irQoUQNbxQFdxUvPmn9GNoWKLgz0dL53P0lzI8uC3/j+vcn05Sj05uz?=
 =?us-ascii?Q?eQKslSE+lJfrtGeVwFqeszGjriY9OxIw4ad4vC7Qu0V3Bk6OsAQ1yGK3CgiY?=
 =?us-ascii?Q?Ygrq946yFOa2xec9QtPBTtG6FbfYKn1EKzcwrkYBcW+xJTg/GZlu1Hi/X6Iy?=
 =?us-ascii?Q?m8zGlyPqWwJx7jA9yDH40ujiYZhaF8mYgMQpVp7wcl0xtlKbkuPs0F85q90H?=
 =?us-ascii?Q?K6UXx/D15uL9a+d9R/ZYCeyNENlxT7LqRbZk05eP45paQWF9ctpva1nvPCNQ?=
 =?us-ascii?Q?pp/cBBcpRmvNXFIHpN0u/nEqQA0oQ2DJs0uOA03PzfvCUVv3QgibUO5bWa9z?=
 =?us-ascii?Q?QCFkPPcSPLlc+47lCV7f+jnE2Yb910efhjA4dFtIS6zYmyxQgjMMhBFt2B1c?=
 =?us-ascii?Q?XeJ+fmxhokVl9SfnyRaV3qCxH6ohTF5CNEw+q8OsoUf+fyVMMUYkwAR6ASCK?=
 =?us-ascii?Q?WTshCEjPFDDyFeSZ7bf85nPmokbL8L8gxlPNqfktiqEWdBVUehTJLJ2iZPIS?=
 =?us-ascii?Q?yUw5yH7n5zglWl0+zQ9Fh6vphgMyOiq7zXcMSIboG3IX7KCqyfYxI7onT/xp?=
 =?us-ascii?Q?KOGbA5QXr93O/kiqS3z1lNN8csLkfuBItBltddCbj0SOZT4pOCbG9JZuY+hW?=
 =?us-ascii?Q?nFYOUoSin8P8Rq54jnEYGxJL7jz13A4NWsp7meWyVILo0HCC66y7E63MxgNm?=
 =?us-ascii?Q?YzHdVH2T2kLCFmzF+lrbQe+2iA0IFoF6yh4WVlyo05+EtjNDyBPw6m8NkW6l?=
 =?us-ascii?Q?JQEUi+LcvlLPs6bNU2GWf1NNhB9U7y9+pQK8goE6J/MrcSuCp/055Hk3EIzu?=
 =?us-ascii?Q?Rafo5I9KdrO3bJ9Nskwz0wivEnIEKKPu5wfcsSF46XzCcNMWBfjxhmtyb0sK?=
 =?us-ascii?Q?EZ0cnqN9EcIAPE1YUC9ha1qLSJhClKcGK5rOcZ0Al3K3eb1NAUh7aCPeMwmM?=
 =?us-ascii?Q?Yf/oNUG9GETciQPlouZiJHT5YhASdbvoUYgQ56WZLXiXX9v2q1Zg2riMztEe?=
 =?us-ascii?Q?2Qa92W1vLDRP6EfvXJwzi33t3c1ZkzhUElCkbhmRfjcH1JJllKsyNT+tjJP6?=
 =?us-ascii?Q?Q2ln2DNFbmMNyhIqPgtNC7qWR7CKuW8eqkwn/Yi6hs7Pf7IAtCsdCTuJzGBQ?=
 =?us-ascii?Q?IPDKqTu15kV51550MJKuouhfgQhQrhJp0OPx5v1t?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5254.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1cfd1f54-9e36-4714-686b-08dc74935e57
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 May 2024 03:59:07.0944 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Ohq86/MBok3NAr8bPyFUlx/qg2uJRRu4l2Cb0NaBuPLkW1dVhiYpvuxYcH2gbfOl/QOm+kZq6Be4E0yifwhy1A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB6919
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
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Official Use Only - AMD Internal Distribution Only]

Series is

Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>

Regards,
Hawking
-----Original Message-----
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Alex Deu=
cher
Sent: Wednesday, May 15, 2024 00:44
To: amd-gfx@lists.freedesktop.org
Cc: Deucher, Alexander <Alexander.Deucher@amd.com>
Subject: [PATCH 2/2] drm/amdgpu: fix documentation errors in gmc v12.0

Fix up parameter descriptions.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gmc_v12_0.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v12_0.c b/drivers/gpu/drm/amd/a=
mdgpu/gmc_v12_0.c
index 34e751b9b7003..c12c96f5bbaae 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v12_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v12_0.c
@@ -282,6 +282,8 @@ static void gmc_v12_0_flush_vm_hub(struct amdgpu_device=
 *adev, uint32_t vmid,
  *
  * @adev: amdgpu_device pointer
  * @vmid: vm instance to flush
+ * @vmhub: which hub to flush
+ * @flush_type: the flush type
  *
  * Flush the TLB for the requested page table.
  */
@@ -321,6 +323,9 @@ static void gmc_v12_0_flush_gpu_tlb(struct amdgpu_devic=
e *adev, uint32_t vmid,
  *
  * @adev: amdgpu_device pointer
  * @pasid: pasid to be flush
+ * @flush_type: the flush type
+ * @all_hub: flush all hubs
+ * @inst: is used to select which instance of KIQ to use for the invalidat=
ion
  *
  * Flush the TLB for the requested pasid.
  */
--
2.45.0

