Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 955F5C3DA4A
	for <amd-gfx@archiver.kernel.org>; Tue, 20 Aug 2024 06:06:43 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3E0BB10E4C4;
	Tue, 20 Aug 2024 06:06:43 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="s7xm9oc7";
	dkim-atps=neutral
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2049.outbound.protection.outlook.com [40.107.94.49])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 75C9C10E4C4
 for <amd-gfx@lists.freedesktop.org>; Tue, 20 Aug 2024 06:06:42 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Cv837aIFx1ZH8qknI/QC9aPv4CIlxzIcQe3oBijAMzSTJIjFiakJK73VV77qWqwoEJsihB8TEvUN0hP9ekeOGi/KaoIa2XJ9/2j733ENEUc0vqjulkPPRjmSrX3ZuSGDGWshGxqwCUOCtcqejZugGNhDS7QJ7EyyWhv9xoyuN7FBS35RdIvQx6YFbpQ8B2kJXJn+JGnphZ9KCuo5pg2/6M7ntEGp6ZpVyl36KFyt4nPCeyb7W+KnjinOLA6yGMaahhQOUPzkqXY4OXBEjU7twy1B5eJyu3s958PbFKdsO3pPBTX9Dx9odp/reGnGbVc8NPvS+99uivdQRLyfXVpovQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pP6QG6qQbzk/06fJtAnTUgeV7zsOSFYexoQbk3fLuO8=;
 b=XL8WN7fCrB+3fbeOcofJUr0Xo7k5r+uvAP0Cc8Fpl3VTnuv9N5SbeADNoKU7OEg10kmwwpyLETDcBDBg39e0SKET2Yq11NdzI6yd1zUfMpZwmk/sLiZ/uREELeJdJKU9GqQJi4ub5YtsYwEeQe7zu63h0iFbJPGFkMDXePFX1imVLrRkqqZRsm+EkXsoeZRfbAVSVNZUop36aUG6OuoZmc/oPqe4GwHjn8MXv3oRNxXZwr2a2vCRcifeHjNPhRvyivcmWl5YQ6I5cul4FAn3qRVl+hFXJ4AeVvLqsnxicfc0FGkxR2DZWXkTU7udU5b0jrEiMnvZrQRq7BlBVptFpQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pP6QG6qQbzk/06fJtAnTUgeV7zsOSFYexoQbk3fLuO8=;
 b=s7xm9oc7CmxCNOVSMJwBBQVhO+byNuP3SkwDLI8r+XekH+DzrFO6lQium3tPdQu0EAtXm/kqNwrOhh8Hw9W1cgKI536MnLWy+7LpFA40cGyteoihT64XcJH1ueQe38Ghreny6h5+BrYfUPCZstl+SDIXUwSDN454SazoAnwOz3Q=
Received: from BL1PR12MB5254.namprd12.prod.outlook.com (2603:10b6:208:31e::21)
 by SJ2PR12MB7941.namprd12.prod.outlook.com (2603:10b6:a03:4d3::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7875.21; Tue, 20 Aug
 2024 06:06:38 +0000
Received: from BL1PR12MB5254.namprd12.prod.outlook.com
 ([fe80::eb1a:4c36:7d9d:6176]) by BL1PR12MB5254.namprd12.prod.outlook.com
 ([fe80::eb1a:4c36:7d9d:6176%5]) with mapi id 15.20.7897.014; Tue, 20 Aug 2024
 06:06:37 +0000
From: "Zhang, Hawking" <Hawking.Zhang@amd.com>
To: "Zhang, Hawking" <Hawking.Zhang@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>, "Zhou1, Tao" <Tao.Zhou1@amd.com>, "Yang, 
 Stanley" <Stanley.Yang@amd.com>
CC: "Fan, Shikang" <Shikang.Fan@amd.com>
Subject: RE: [PATCH 1/3] drm/amdkfd: Check int source id for utcl2 poison event
Thread-Topic: [PATCH 1/3] drm/amdkfd: Check int source id for utcl2 poison
 event
Thread-Index: AQHa8sbwByWqUJUzE0iQtdyVIr/anbIvqHnw
Date: Tue, 20 Aug 2024 06:06:36 +0000
Message-ID: <BL1PR12MB5254CFCA29AD1C2801756482FC8D2@BL1PR12MB5254.namprd12.prod.outlook.com>
References: <20240820060512.16061-1-Hawking.Zhang@amd.com>
In-Reply-To: <20240820060512.16061-1-Hawking.Zhang@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ActionId=992e772c-5f60-4993-93d8-70384f5f9321;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=0;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=true;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution Only;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2024-08-20T06:05:53Z;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL1PR12MB5254:EE_|SJ2PR12MB7941:EE_
x-ms-office365-filtering-correlation-id: c4fd2273-cee4-4e57-8320-08dcc0de400b
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|366016|1800799024|376014|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?UXTQ/Ilf6DMVWFZ9OKhrQ6ENLZSDQ33vsY6cuAELItxh8pd9Bu0a0DjFSSiP?=
 =?us-ascii?Q?3rgZJSYVZp7wgmNRFKHykjI7TloGkAba3056wo89OyaBVxUccSc/hIeuVk17?=
 =?us-ascii?Q?+I8Fj5UMAaD9Zxi36MrHyzw1odrFLGu5kDGyDl/Ysiv/wfAZEJiaxEeQveA8?=
 =?us-ascii?Q?H3uKi+MdLU9nygrgnCTLPMvAEhQJ4Fsg2j44kDmw+p/YjOKTg07MPBIJZREF?=
 =?us-ascii?Q?oaagKqgcHqdmTkkTKNv2/E/8JyaHOdJuERXXvBwKnIqW/c2aHiGpnrcHjw65?=
 =?us-ascii?Q?Tyzvgse4pWirvjYndiZojtYxRa/fcHj4GKqn0tdy0yi320Vn7BmWHeOjWD9H?=
 =?us-ascii?Q?mCOvuJxvLR9lmT5W42gr7bP4diTGr08rBLZASBxZlvMR+e8X7YLK+d601BtW?=
 =?us-ascii?Q?/OzCLFLMZGhl+PrNsClT1g1eV0gsmackKrVbWU5LvsCH8xHyMsIqM1T6DgKt?=
 =?us-ascii?Q?ZMn76gneFNhgK8TT9KAXyNV8qp2AjwbYZd5ycXFvtHLDh34ZAAEbpsJEl5Os?=
 =?us-ascii?Q?h9gcbAMfcfWTVNApUFyKwIeuq4W6+dareJCbYGj3VbtM3ijHc7d8FfZ/Yr/z?=
 =?us-ascii?Q?i2KFgDM+LFcgfOeicMKWNc4xjY8shnwb1AaOXcx1G3z91UOt/z1xsW86LDAJ?=
 =?us-ascii?Q?7b7A+yLsMrsDvAHaYogpVGaBlNNWYBL/4YcPxqnx0hMAOXEFTT3jZnS0rVQn?=
 =?us-ascii?Q?8UPFe4okv34xvtmUv2KpTU6bL7V9YIBkuBgP507Qm8f45XyBtLIK44gwbuF3?=
 =?us-ascii?Q?/LBBiHTv/c/ODmKU81Aor2YF6hHh3gsEp2ZMklLtbssriNNhd4Bv9eeSO/2y?=
 =?us-ascii?Q?wqxresyTJcL1o0/zG0JdU8Rb+Rq85VpW/ZrMMiynobXoKONjsMnZDqfnFEjE?=
 =?us-ascii?Q?xfE2cXieQmKpWx01p7ZctgbJfbrOOPQAlBOlwdz+AzBA4FMkYpWjgl3Yzg9U?=
 =?us-ascii?Q?kv7INDl5gTXaiMZoSQY86gNypFTXsFQAH2l+W3Wk+mu6MFDmtkauoO7s6j2/?=
 =?us-ascii?Q?IQzJB7nxm8oq0I3xPqN7kB7+L1m/QWCuI+hl5kaq3xvN8B5O6sy0uEg4uFfs?=
 =?us-ascii?Q?VCKB+UXn+8QyqKpn1rc4sZdBTaF3bqTtZDB9D9erpGChxmnMdintM4y+Nxr8?=
 =?us-ascii?Q?xppdfmiRwflTRzHYidxYICHmzArzg4ouDfh+bZ+7FL3dyTwlnGfV+vLzlxPS?=
 =?us-ascii?Q?P+H4AWzX6O1Mkvmxet9A/q8RmWyOFBicVNSA30bOyhIB7fy9QZdgSd8HxP/i?=
 =?us-ascii?Q?LPwNKRZnRqVi4VL/2XfNgKApYLVDdBPnCBqy8LMNK/eP75qmM7aAYXl1IY4c?=
 =?us-ascii?Q?v4VOW4bczEmNAEDGyQP6WQm0aL30IR1fE0pWaKFXpdgicfUC8hNw1x5WOrVW?=
 =?us-ascii?Q?9g3zOY+1H5ALAzkKYUmuKhP5V980JY5uhKHdJorur0flJmQbMg=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL1PR12MB5254.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(38070700018); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?8sdGxrknz4FByt3vfiOxpFwhlYYRLtnJRLlqSVIPQ60Jt9A+X0dVXQL/JHzN?=
 =?us-ascii?Q?b12G+HoHxEExLQX93I5kgCcmL7piDH9396frk1SRMy8Y06lqJ346Paibf2ZP?=
 =?us-ascii?Q?nPmmPNDkK+LHJ2I0m8t9fJFPt/J1WLdu8wEbhLinPnX8PsezGlhI39e80hPn?=
 =?us-ascii?Q?ja2ewZQa4CUoObO1Lgi8zNcIS1qvV+DG1nau+ej8sxSI/QnGUdm69XQL23hm?=
 =?us-ascii?Q?EqaOz/oUde6K6bnSvuwbfGgeqVmihlWSFGjZIt79hozFDb8pKXWcaEBn1xiL?=
 =?us-ascii?Q?U4IlLrs0xNB3MS1wIZWvXqI7Emo5YbnfEofTdUunMBhXjVA3WoM3bKkVbiys?=
 =?us-ascii?Q?6sEd1OafNCn6wt7oexGAxtyD1yOyWXvU+seq7+PpsPSpCfsiVaq9ckdCaHpK?=
 =?us-ascii?Q?Z5QOb5wN1NY/Y/LFsb21OrZP9euqL85xKh9BKyUAJ9HHowimVGmqfnsfY6vL?=
 =?us-ascii?Q?ZuLGcKWYT3uPiRF4FYy4Bu/7XXzvH4iJ2cXclN1dJ7nBG4+Uq6LTjVul8lz4?=
 =?us-ascii?Q?pY1pv7C5V41JI3mnS8cDcWEb+eCb41Zd01uxJsL20+qP72vGaH8oHjiP8z+o?=
 =?us-ascii?Q?YtMeLyJHMcVWQNGaFPgSVGglruiJ/vvUvAqyTIV6V5rBWD1AzIpbPMPefZD9?=
 =?us-ascii?Q?LmZSETvqefIPWWFuNaf3CtXxvBYNCF909RZk0uZFmZmh6KkRFOlhBB8Nl8t7?=
 =?us-ascii?Q?tt6ryzWwG7puEhTkzDIU0n2Zty9pv1zx+VNjmi7H3hm7WKGIlcBEeLOhGXF/?=
 =?us-ascii?Q?ka+hGCXt9WkwQ85MiRaIK60BH1QNaWY91N7KcLyYS7T+mtOC5Pmmo2d3xfoU?=
 =?us-ascii?Q?a1xGeG8WcY9lgs/DwWf43tl7KMOpsoDyk31DoivX3rTcgRCZHvJNeNyXx0qJ?=
 =?us-ascii?Q?sjGQhkj37oKaMyxrL9r2OYy2xkAQbEd6Pc2lzpOzOWBwKyllO2Mbnf9hd1FA?=
 =?us-ascii?Q?7EENZQpnYMtC+sdwlON0DiOf9FuSQqCJ1/GA6c90FfBKDIaROrCVBAGDej+h?=
 =?us-ascii?Q?33ImNagPdfpMYmJ+lI+8mubvQVu9aSsVnsna0m7DVxu3JNw7WgIT1jTYku/V?=
 =?us-ascii?Q?/usVYgsy+/dVZOxbI3GUFj5j6LolgLjISlsnbUWC9iIVI1Onjw+173tyN6cV?=
 =?us-ascii?Q?OFN1ZmPCjiP+KhPjng/ol7t+0oIwhIRVbjyZxuVTo4LPWKKNMcEngzVYVzyV?=
 =?us-ascii?Q?u2Qermgw7LAoblgyUZC0Xv8SBX+tPhpdTBeLAbUk7ZAAl4N5rqmhbrIYhYoG?=
 =?us-ascii?Q?HrLw38F8a8m1sQptDLkN29vEyZTdvpavWER2bLaoTmpNZwFr3vFmJv1DsHAW?=
 =?us-ascii?Q?km1c3ZK8lYle4zSjQI7ruG5MgU5YC1Q1UnoPr7ZVA9j3eyVAmDpp06UA3vYx?=
 =?us-ascii?Q?jo5X7o8XOqrJQYZEUS2VpY0fLixKqb1ogCmmGfyKeYbtE9nenpaZOnnzO8PN?=
 =?us-ascii?Q?qSlq/mnFUR5a0rPeLRsZrBbVNhLyjhibhzRXsDQqEaCYKzblA2I6uLXEyYYz?=
 =?us-ascii?Q?6pD6svhvmASDkKuqk5Nf2wd2bw3PcUBA/PL9em2TdvUgNci9RCCF+k/DUkgq?=
 =?us-ascii?Q?wPclsLRHxB2qlTVy/twr2VLUpcwAVvL9s2h3Tokm?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5254.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c4fd2273-cee4-4e57-8320-08dcc0de400b
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Aug 2024 06:06:36.8916 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: K90Z/LxNaBFtuwqeZh3270xnGiwZFXL9xLgpjvdBqVztgZmUT6kcni8Nu6Ewu0fLJDAE/6JH3WLu59LIyAkGlg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB7941
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

Ignore this one. please review [PATCH v2 1/3] drm/amdkfd: Check int source =
id for utcl2 poison event

Regards,
Hawking


-----Original Message-----
From: Hawking Zhang <Hawking.Zhang@amd.com>
Sent: Tuesday, August 20, 2024 14:05
To: amd-gfx@lists.freedesktop.org; Zhou1, Tao <Tao.Zhou1@amd.com>; Yang, St=
anley <Stanley.Yang@amd.com>
Cc: Zhang, Hawking <Hawking.Zhang@amd.com>; Fan, Shikang <Shikang.Fan@amd.c=
om>
Subject: [PATCH 1/3] drm/amdkfd: Check int source id for utcl2 poison event

Traditional utcl2 fault_status polling does not work in SRIOV environment. =
The polling of fault status register from guest side will be dropped by har=
dware.

Driver should switch to check utcl2 interrupt source id to identify utcl2 p=
oison event. It is set to 1 when poisoned data interrupts are signaled.

v2: drop the unused local variable (Tao)

Signed-off-by: Hawking Zhang <Hawking.Zhang@amd.com>
---
 .../gpu/drm/amd/amdkfd/kfd_int_process_v9.c    | 18 +-----------------
 drivers/gpu/drm/amd/amdkfd/soc15_int.h         |  1 +
 2 files changed, 2 insertions(+), 17 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_int_process_v9.c b/drivers/gpu/=
drm/amd/amdkfd/kfd_int_process_v9.c
index a9c3580be8c9..fecdbbab9894 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_int_process_v9.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_int_process_v9.c
@@ -431,25 +431,9 @@ static void event_interrupt_wq_v9(struct kfd_node *dev=
,
                   client_id =3D=3D SOC15_IH_CLIENTID_UTCL2) {
                struct kfd_vm_fault_info info =3D {0};
                uint16_t ring_id =3D SOC15_RING_ID_FROM_IH_ENTRY(ih_ring_en=
try);
-               uint32_t node_id =3D SOC15_NODEID_FROM_IH_ENTRY(ih_ring_ent=
ry);
-               uint32_t vmid_type =3D SOC15_VMID_TYPE_FROM_IH_ENTRY(ih_rin=
g_entry);
-               int hub_inst =3D 0;
                struct kfd_hsa_memory_exception_data exception_data;

-               /* gfxhub */
-               if (!vmid_type && dev->adev->gfx.funcs->ih_node_to_logical_=
xcc) {
-                       hub_inst =3D dev->adev->gfx.funcs->ih_node_to_logic=
al_xcc(dev->adev,
-                               node_id);
-                       if (hub_inst < 0)
-                               hub_inst =3D 0;
-               }
-
-               /* mmhub */
-               if (vmid_type && client_id =3D=3D SOC15_IH_CLIENTID_VMC)
-                       hub_inst =3D node_id / 4;
-
-               if (amdgpu_amdkfd_ras_query_utcl2_poison_status(dev->adev,
-                                       hub_inst, vmid_type)) {
+               if (source_id =3D=3D SOC15_INTSRC_VMC_UTCL2_POISON) {
                        event_interrupt_poison_consumption_v9(dev, pasid, c=
lient_id);
                        return;
                }
diff --git a/drivers/gpu/drm/amd/amdkfd/soc15_int.h b/drivers/gpu/drm/amd/a=
mdkfd/soc15_int.h
index 10138676f27f..e5c0205f2618 100644
--- a/drivers/gpu/drm/amd/amdkfd/soc15_int.h
+++ b/drivers/gpu/drm/amd/amdkfd/soc15_int.h
@@ -29,6 +29,7 @@
 #define SOC15_INTSRC_CP_BAD_OPCODE     183
 #define SOC15_INTSRC_SQ_INTERRUPT_MSG  239
 #define SOC15_INTSRC_VMC_FAULT         0
+#define SOC15_INTSRC_VMC_UTCL2_POISON  1
 #define SOC15_INTSRC_SDMA_TRAP         224
 #define SOC15_INTSRC_SDMA_ECC          220
 #define SOC21_INTSRC_SDMA_TRAP         49
--
2.17.1

