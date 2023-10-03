Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2187EE7AD77
	for <amd-gfx@archiver.kernel.org>; Tue,  3 Oct 2023 17:34:43 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B64BC10E013;
	Tue,  3 Oct 2023 17:34:42 +0000 (UTC)
Received: from NAM04-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam04on2068.outbound.protection.outlook.com [40.107.101.68])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3218F10E013
 for <amd-gfx@lists.freedesktop.org>; Tue,  3 Oct 2023 17:34:41 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hnxo4hYPerWqrGahQsEUNMPUFfFv8IyCXIqZNmfW5s2hTtyE1KLfT2a0pxCbvRmR1o4yzN6rGCm1zORhEsAwUzfrCOjtG7WewzaO4AgXMd+WhrV4jF6Yjt1iH4W7IyxDU1NIJq4omcBbz/Yg5nFjEJ+VjawqRcnI2XLAghnyr+WE2Cr8d3odjT5RyHfhDbD00ByiNd2wOVV72NbUqXEKiHz201qdc+31b0Xlp46mK9ICSvdgkQQ/677EltkX9xN7DfYGSd0w30jxKVC7G5qWbgHKHtd/UzpzMlFCa3gk56yfjvMglSJp4lWJ2ZzD1JqxhZK7xVjiac+G+8DIcVLtmg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/TfYQ7fPcE4gaSNvLA/U7hCcCYtMqDJL7jAiOl3SpNE=;
 b=oCpgEpklOsgOJK93wnklRcDTHhWPy0PTsTw7kJGfe/NhG/okffRp4Wx3xDrRYHlfbqjYxZyyTw7rHOEEwnqo4/XlOhNUdpC4ocS3smGO6aVjA02kkWOW7x9tE4RGpD0Fys5Fo881wJost+K7e1YlKGELPBo4tuj+7lrDwERJUUdBiz4AYAlVH0qiB/4LcFGKbjeu+2Dy9uIhWVS2DNkmwERMy0eRD2UoryH9cERlIfB3wV/b19JAOW2ib3XbvKT3+x6AM+2Pr82DyXF1un1EeOidbIRoeq9MUChal32My6G4lAZQ5XqkPUuLlMMaHMovWg79gIBV4vXPWjvvLjO/Cw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/TfYQ7fPcE4gaSNvLA/U7hCcCYtMqDJL7jAiOl3SpNE=;
 b=SDqTUX4RmAd+Trj23m1MveeYlb9QiyJ1tjtdWLOT+c28HVWZdzhGQ0YOiuDqOnFuQpJRu/tLQCbEcJWDxaRIZ/HWuaxEXqjWyoacMB6ISXwxzgG2BVM0uTePCXIJkfCJSr6993bhSV+sD69LpYg82yt0GHwOvdSyQzsCocHYCk8=
Received: from CY8PR12MB7099.namprd12.prod.outlook.com (2603:10b6:930:61::17)
 by BL0PR12MB5507.namprd12.prod.outlook.com (2603:10b6:208:1c4::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.31; Tue, 3 Oct
 2023 17:34:39 +0000
Received: from CY8PR12MB7099.namprd12.prod.outlook.com
 ([fe80::5c4b:b312:5533:6381]) by CY8PR12MB7099.namprd12.prod.outlook.com
 ([fe80::5c4b:b312:5533:6381%7]) with mapi id 15.20.6838.016; Tue, 3 Oct 2023
 17:34:39 +0000
From: "Kasiviswanathan, Harish" <Harish.Kasiviswanathan@amd.com>
To: "Yang, Philip" <Philip.Yang@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amdkfd: Fix EXT_COHERENT memory allocation crash
Thread-Topic: [PATCH] drm/amdkfd: Fix EXT_COHERENT memory allocation crash
Thread-Index: AQHZ9hrDpoicO5y23kSfqCP9OImDmbA4U3pg
Date: Tue, 3 Oct 2023 17:34:38 +0000
Message-ID: <CY8PR12MB7099682BB2F6367ECAF308828CC4A@CY8PR12MB7099.namprd12.prod.outlook.com>
References: <20231003165727.10854-1-Philip.Yang@amd.com>
In-Reply-To: <20231003165727.10854-1-Philip.Yang@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=bbc9fb45-7e7f-4190-b206-379b058edf46;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=0;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2023-10-03T17:34:21Z;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CY8PR12MB7099:EE_|BL0PR12MB5507:EE_
x-ms-office365-filtering-correlation-id: c756534c-80ab-47eb-b9a5-08dbc4370508
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: F1mTGAQ6hTDwQPlV3zEvW5Hg2/F1DTJa+mKd3RxIn2aSjEAiSEF7Su8bZErgw+iG2xBqgVMdaZN914CtQhof/rkl2mti3G5cjnxWM5I686qLHLqk3q04QBidqljNgLn8wE6g0GHxekhGGGKHuoB5PJJd8S0Ga10cRLDzG5YAK+B/qduk4GPnB4yDkWcqdRPtSPT7JRV0Az+cs7KrpoqwKOke/Y50oe53bK+mxAeSf3hwBIUQn/noQvgSRKgG7/FZsM+i5xE1fw+j2li+Hk6QK4/7qOBMZv+rPuXYSdvdGqH/McgVynYiVAaztLymfH9Fo8Gyn5dn2nefuLZjWWNWV1aRWdx01fG+qWGQM7dMJhGtoCkpAIEm1iRSBbKnwb/ny9rWePsW69fNH9AiJlJFB9oQPPgM68bMKMrbu1gUBRuin2d8uaYlmZiKvgmiPX56deGIM4MC7/1Vjd/BPnWz9rCrUK8V3vD8Qcp7v76NzypXE2OcJ9XPQi4T18Vau/liL/WN8QBq1r5xMyRd5r+pCTmdMXyDbdlqS2Ilh3PDEhQHaDMFeAFVPkYes6R7jCS4RXjDaW5uQHiuUBIiYRLIuvclCDJN1Iy5WK1BSG5CnjqRfoDYGsz6B6qR2ci4hHm6
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CY8PR12MB7099.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(39860400002)(366004)(136003)(376002)(346002)(396003)(230922051799003)(186009)(64100799003)(451199024)(1800799009)(6506007)(52536014)(7696005)(110136005)(53546011)(41300700001)(76116006)(54906003)(66476007)(64756008)(66946007)(66446008)(316002)(66556008)(2906002)(4326008)(5660300002)(8936002)(8676002)(478600001)(71200400001)(55016003)(122000001)(86362001)(33656002)(83380400001)(26005)(9686003)(38070700005)(38100700002);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?DdEULJYt7zu/E5KHuK7TKV9djWi9tf7n9PeI0536RMWWrxlLq/wMC4rp1cle?=
 =?us-ascii?Q?q70oF0PqhoSZQmlt3NlSDqNPozP5SeMi+efTkCO+m7jEr/QFMGffAPgTH+0e?=
 =?us-ascii?Q?Beu0zIPHl+3X4YHnh8YLnWfhPSfOUnKfx5t/fX14ZjpXI6Qcs6X2TFiq3RBL?=
 =?us-ascii?Q?RTjbEOiOxK88RE75ajlD6T9eJn8DmJqzRwTgv4+p7VyAjKIWtSJy7uy+x/XR?=
 =?us-ascii?Q?OSOBPXKzPHVPJfA+Iox3xd7MTgjh9IFNaPiky1CCXSf97V3haVvFHaaQhtap?=
 =?us-ascii?Q?/ZAxCN3xYe81nDM2r+MbkaM28WkGlQaGf8jPr8BaJaPQzRRLGSdM4hy5QG3e?=
 =?us-ascii?Q?i6oye5BPW/fBfVZK6zRg4aUwqDdEgY26gSajwa25y0qgTgZa+HC6sZdzbjyl?=
 =?us-ascii?Q?X93kxI9I2CUMHCdKXfWGxjcEL8qyNbc4MmLELat7asCDaddOhSa0WLhWll+L?=
 =?us-ascii?Q?8lwtGgCoWMiAicizCtjf5RnucyUi5UU3chHNd8mNC6TFZxoq1S3jB/ES2U7C?=
 =?us-ascii?Q?8qxxOCNn75POdx46doOMD6DCUZ5vvz24LTywYtk05e2cTEX+t2uJCNgKw/Bx?=
 =?us-ascii?Q?OBUezVfy7Sxe1lC5C3xvGQsGkI6w1CeykmNiioZllbF2g+eXMCLVUcMLFkw8?=
 =?us-ascii?Q?rV1EQFGwzur0TfdICk6TFNuv/A4uKjEwx93WYhK+W67h2gmI/wrJaXtUZQ1F?=
 =?us-ascii?Q?PKimBSKa7nXwolcWuZRIDnFUeTSbAp/kGdvPShNVWkUAmweeCFwxzKazhef6?=
 =?us-ascii?Q?sIFQtknMDhEoR0cUzULH7kDWUWTKLtR+4/axt1BZeQcUaKWROAv8PHDKlu5K?=
 =?us-ascii?Q?KNQL7P7OYGEqJVIcKN2cPwYpTNK6C+Qmc92tWkStBA58+DdFSG6NlYZ8Sqsn?=
 =?us-ascii?Q?lO5ehfTwEUubFBUCPlpBaKOHxpwxHeq4E2ya2FbZc8+HlbtoX/eVgae7Wk4b?=
 =?us-ascii?Q?7I7Ji9KCzmkgCplAbQ5/bbxGfTYRS9aEzv1WcNTJ5z2sfgequy7/LxFtwBeV?=
 =?us-ascii?Q?vVECPkS3iYIQXXJYHBbsMFyjNep+gfyINYJt8TrsfivEgbUKEQ2jkfCfJrh7?=
 =?us-ascii?Q?azMdEe3C28IetKd1pp8D+hzV+iFwUtVXQOBIpxfUzm3z79voSk4JU7xjCi77?=
 =?us-ascii?Q?1KJzRYQMPB4Xeo1bo84oevjQOPcSgT8q7OjF8EtdvNItWmLJR9wTYeiZrR+H?=
 =?us-ascii?Q?+h/yl13ubhVnSXUGkmvPRW0UQDc/afXmpPrBeV++MuIeD+8aqzCNxEk5z7dp?=
 =?us-ascii?Q?+88oHWVYPGu/PKFPUW8p7MbqdcB6wyOI7zlxXj5eRG+6BxyCcvPPXwkdJl/V?=
 =?us-ascii?Q?6XAWDZA1K5JowPkPrqhfgPLndFJcr06xLiuDz50P3IOgeBaVfVjgavE8bc/U?=
 =?us-ascii?Q?0LN32XsqJtDndIq/hesax57bzsLLeCeqAC0IkqrVOyIEASHOm15VIJBT8Dzv?=
 =?us-ascii?Q?Iu8uh2/2DWKSCnlTDoS9rJZ6/X0106KYuHIZ1QzldxgKl9h1YBbtMuEixvFv?=
 =?us-ascii?Q?YJJgjjw2OuyZpnzslmgbpzQj+DaMpnCGoSWV9mz/aEydPyF6ospghGBHQPQT?=
 =?us-ascii?Q?PlVSDvt1y5EipdJNAI4=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY8PR12MB7099.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c756534c-80ab-47eb-b9a5-08dbc4370508
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Oct 2023 17:34:38.9495 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: oBIl1ti34ldCuAziys94/bWHUnRK2uQkhFDK3x42CYtLJtJ/C/zmQSRtYQqH9K8LM9uDQ3lSJ3MujENEX6y1SQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR12MB5507
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
Cc: "Yang, Philip" <Philip.Yang@amd.com>, "Kuehling,
 Felix" <Felix.Kuehling@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Official Use Only - General]

Acked-by: Harish Kasiviswanathan <Harish.Kasiviswanathan@amd.com>

-----Original Message-----
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Philip Y=
ang
Sent: Tuesday, October 3, 2023 12:57 PM
To: amd-gfx@lists.freedesktop.org
Cc: Yang, Philip <Philip.Yang@amd.com>; Kuehling, Felix <Felix.Kuehling@amd=
.com>
Subject: [PATCH] drm/amdkfd: Fix EXT_COHERENT memory allocation crash

If there is no VRAM domain, bo_node is NULL and this causes crash. Move
the EXT_COHERENT support change to VRAM domain path.

Need another patch to support override PTE flag on APU.

Fixes: 55d7e2001c7e ("drm/amdgpu: Add EXT_COHERENT memory allocation flags"=
)
Signed-off-by: Philip Yang <Philip.Yang@amd.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_svm.c | 14 ++++++--------
 1 file changed, 6 insertions(+), 8 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c b/drivers/gpu/drm/amd/amd=
kfd/kfd_svm.c
index 0d88698ae33f..150a3e88691d 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
@@ -1252,19 +1252,17 @@ svm_range_get_pte_flags(struct kfd_node *node,
                snoop =3D true;
                if (uncached) {
                        mapping_flags |=3D AMDGPU_VM_MTYPE_UC;
-               } else if (ext_coherent) {
-                       /* local HBM region close to partition */
-                       if (bo_node->adev =3D=3D node->adev &&
-                           (!bo_node->xcp || !node->xcp || bo_node->xcp->m=
em_id =3D=3D node->xcp->mem_id))
-                               mapping_flags |=3D AMDGPU_VM_MTYPE_CC;
-                       else
-                               mapping_flags |=3D AMDGPU_VM_MTYPE_UC;
                } else if (domain =3D=3D SVM_RANGE_VRAM_DOMAIN) {
                        /* local HBM region close to partition */
                        if (bo_node->adev =3D=3D node->adev &&
                            (!bo_node->xcp || !node->xcp || bo_node->xcp->m=
em_id =3D=3D node->xcp->mem_id))
-                               mapping_flags |=3D mtype_local;
+                               if (ext_coherent)
+                                       mapping_flags |=3D AMDGPU_VM_MTYPE_=
CC;
+                               else
+                                       mapping_flags |=3D mtype_local;
                        /* local HBM region far from partition or remote XG=
MI GPU */
+                       else if (ext_coherent)
+                               mapping_flags |=3D AMDGPU_VM_MTYPE_UC;
                        else if (svm_nodes_in_same_hive(bo_node, node))
                                mapping_flags |=3D AMDGPU_VM_MTYPE_NC;
                        /* PCIe P2P */
--
2.35.1

