Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3AA42CD4F26
	for <amd-gfx@archiver.kernel.org>; Tue, 23 Jun 2026 04:57:21 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6F95C10E935;
	Tue, 23 Jun 2026 04:57:20 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="TdMFaAG6";
	dkim-atps=neutral
Received: from BYAPR05CU005.outbound.protection.outlook.com
 (mail-westusazon11010048.outbound.protection.outlook.com [52.101.85.48])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3EBB110E935
 for <amd-gfx@lists.freedesktop.org>; Tue, 23 Jun 2026 04:57:19 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EQ2dgGulLoJ91+AgL6ebHs2SeoJ5N8W7+LAoPAF9tTTE1Jnfy42DncX2nWKdutQFgwvZg21F01kaTgRoFzKcCaylaSkAWP/TANSFwC8rr1Vvrt/Zq9zaoSbTerxo7r8DI9P+YJ2Gw75gLTNqPEuIw4JRLTkKoUaZ5MUKhPdlbX1a8f33oEqkMA5Xs4oD9giferO193U7pbmeK89Wq/TQCiErTYSNWnJMAq6LZ8LOV5t6WNM3vW8yR6kjluCBXrDnTzy0dpMyaanC0Q1sIZWCKjFqqyddwWphLlVxVQ4u675v/G3YnEivYujDWN6Xv32pgAqpApRobPr0nPoNdq2mLg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jiW12J6R9GI8Z9TOyUzeCcLWKYnQTN2OrGjCV8WG2jY=;
 b=ukt5QbFSrXiD20MtgoNtjameUVSJyd8Q4b6XAjcPkNAKSaue49EaY+GdIfDcu3nK9ULO65xrKyi8Ki1TSBPiI54wSDIB0rR68graWH2G5qIKMOfw/4rkLmV7h6dSvLLCo0Dsj6Mv3z3KNlysJy710/KvFayw5nzU1P/kxJOadWJJrOmYHUaLi2Fb+n9tUcUCb2AUpKPEkmbzKBh+5BHPYfT7MMOVcljaG4o9rkJ8jAIX5QV0ikgfK+KZiMkIBfKcFCu0twBa3NDKEdv+X4xKUeVODHjcHyNY7JZk640Y2JQdJJt0cMBkumWJOBOSGw40g4dQFwBscNyghGkzrhfPeA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jiW12J6R9GI8Z9TOyUzeCcLWKYnQTN2OrGjCV8WG2jY=;
 b=TdMFaAG6GNSVXqkGBiikI5HoYxC0qip9YZY61IhMFX8b1IfRdjV70tfdFXfmWoL+r7I4AGp+tNL/tc90n+paFX0yCX1qCf0e4fhbXiFPTV5X4xeg6qV7prnpUAFxUh4/qKxTo3EqTuuDbtMyog7vnIY4XmGZEcsTE2kX6YhH4qM=
Received: from BN9PR12MB5257.namprd12.prod.outlook.com (2603:10b6:408:11e::16)
 by DM6PR12MB4354.namprd12.prod.outlook.com (2603:10b6:5:28f::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.139.20; Tue, 23 Jun
 2026 04:57:16 +0000
Received: from BN9PR12MB5257.namprd12.prod.outlook.com
 ([fe80::1aeb:47e6:faf1:5f13]) by BN9PR12MB5257.namprd12.prod.outlook.com
 ([fe80::1aeb:47e6:faf1:5f13%5]) with mapi id 15.21.0139.009; Tue, 23 Jun 2026
 04:57:16 +0000
From: "Zhang, Hawking" <Hawking.Zhang@amd.com>
To: "Liu, Xiang(Dean)" <Xiang.Liu@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
CC: "Zhou1, Tao" <Tao.Zhou1@amd.com>, "Yang, Stanley" <Stanley.Yang@amd.com>, 
 "Chai, Thomas" <YiPeng.Chai@amd.com>
Subject: RE: [PATCH] drm/amdgpu: protect XCP scheduler selection
Thread-Topic: [PATCH] drm/amdgpu: protect XCP scheduler selection
Thread-Index: AQHdAsgVe/3HLm/hUEyZqnv8GWfsDbZLk96w
Date: Tue, 23 Jun 2026 04:57:16 +0000
Message-ID: <BN9PR12MB5257AD53A0670D4D6771C1C5FCEE2@BN9PR12MB5257.namprd12.prod.outlook.com>
References: <20260623042319.561959-1-xiang.liu@amd.com>
In-Reply-To: <20260623042319.561959-1-xiang.liu@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Enabled=True;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SetDate=2026-06-23T04:56:56.0000000Z;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Name=AMD General
 v26; MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_ContentBits=3;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Method=Standard
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR12MB5257:EE_|DM6PR12MB4354:EE_
x-ms-office365-filtering-correlation-id: 10f9a220-3685-44cc-3ae6-08ded0e3e5cd
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|376014|1800799024|23010399003|11063799006|56012099006|18002099003|22082099003|38070700021;
x-microsoft-antispam-message-info: MEPKAFNlAiiFoDDiW9gqiju/dUCd6K+51W3TxN4Z5cLR7gNY9kH7Kwr+heUJIcM7sUkmHSRsrs7bmjNJq9B2i61Qpc8SPoIUCaDfGB79YNcw30jdY5+eA/+pNtaPpzgctRC/VorrdqtuK32cTrZthpxcnCoG5+3ukO/E64w8Y+u5Xv4/hts11fZSbgXuj7dI4lKWRi/7V2fzTEFY+1NOsAA2xTJDPgCPhhTBi/04KCeIAs1QwJFgZMQ8w0JzAHSue64OBxCWrSzYHXKMpcD7oZj7tvTyTMRIOQEaf71yYZXvmUP7b9BDmqTut0WQmImytDpweOU+H9NOGTHPs+ewfKL7VXhkVPh+225cw4dt8GlzAJHC/34JHEfmmbrcT/2OC92qcsBJBIWpbaSF6oAhNzsdDF1wF/7d+ZNAx5j7IrPLNQkyKgbOnlx4rf9zjnzSeDtdoz7oVI2CnjHCOjH/SuSJcRZ8n/zg/PmA7S8Pl1N1qruEQov4LkHHBnWHwXQXzDyrXCvEVpE9XZHNK5Ef3a6hrBpqGsLtRVFT58OP3Hab653U6hztVcS7ni+2kURPzdov7qJ3Txmgf22jb9JbJdQrYWo3smFg6vln4W8VqIo1fWqfGFloXwyAc6yY7W0LJcDQmlnKm4IDLkymxn4BpWxysBp5JCPvrvOANRaZ+ddZc2pioHIMMGXU4gNFyGbtyDDtYqpnvi4kDTjiYkk7AA==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5257.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(23010399003)(11063799006)(56012099006)(18002099003)(22082099003)(38070700021);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?MK3ysyNM2vKRB2NL2jxIO0W4/DCw236mmQE+5LO24+MKJxbPg0qW+ohnxcUY?=
 =?us-ascii?Q?TJ24Nv5w3w40ZjHorH12kEa25ITZeSFyFTO6quqY+yihQWb9nYQ6qyM8B7bE?=
 =?us-ascii?Q?EdMRdOJvu7WP79jQ4qGVstYq7I6mH0UnwZbP1G2JrizapoS07MAx9LG2Ks9a?=
 =?us-ascii?Q?2Nd9vT40OH8EydHxgUHX/Aoj78DZiR0S7kw+GURMGBtHZGqNOcP7wLqPXxp9?=
 =?us-ascii?Q?KDLcr5CvDPaxqXG/Rp2kbTosmC/gqS5TshdmCvXtUxVCiLJsYIEmPLHZ1eDR?=
 =?us-ascii?Q?YxrljlHRVbCeAjz6oRMVCi6o7afyqB7RM6YwC/9BTO4GAznc76feiFk+tgiK?=
 =?us-ascii?Q?paUBNzZ4dsprqghoMZvEtcmvtKTT6R+KlofNSGZHKV9H0gKjkk7TWuvuVFMm?=
 =?us-ascii?Q?DH05H5kFIFAPPjIv6OXVFy27oWimGcRzaOm0gMwVFa3BACiYv95IaiYPY0l1?=
 =?us-ascii?Q?E3PzErcCVF0S38/Bmr0O/pnVuwD/jtNQYdoxi91PT6vmbx7/JEXP6PCxeKge?=
 =?us-ascii?Q?vrwvOLsQzAhbaM+93VrFEAsooISRaU9+wSi2FyScum+CkvFBMNBGklbi8ezF?=
 =?us-ascii?Q?KZsBVWuP492k1eLkQoE9KAaDyaWLt12of+qAMePPy3mtsLiOKTqiHPpLaWgm?=
 =?us-ascii?Q?uHKowQSi3pbrqlA3LmCaFL0iJFfgOM+YHj19mUSBRkKKuFkPYbqsSnLOpe0i?=
 =?us-ascii?Q?msKJMwMikScVVo6dhQSn+J5+IbmIgIeOEPQrZMMHfnUALo67Dk8c0VjG8ECm?=
 =?us-ascii?Q?iP0zD05y///hnwUCWTWUGyXH3p2ALH0kaXFVPesZQkRZ1MT6DOiX1Q6tk6pC?=
 =?us-ascii?Q?fluXRoZaniDB5CEjyDyHRnVrejHZDCoOZ2kciTEseb3wMrRFfB4HxNv6XFx/?=
 =?us-ascii?Q?GWaMjbn9yA8/ieme9QUhy9XAn+9oocH/aAGae5uoEptKVopTb9kZmaSZjOZo?=
 =?us-ascii?Q?2ADw/k3yummfQQMv2nqFCfU3ezFIoST8ZkEUVNzXu5pzEc6IB7/FNBP96WCX?=
 =?us-ascii?Q?v8s4wpZjLcvCdHGTpSqYwvI84sDn5wdgwcbd1E1ZVzzVeVCVw3Bdq3fsmx+2?=
 =?us-ascii?Q?Dlh5bEtygH/Oy9/VqtIAjjRt0qQcjtDD2JVYlFqP0x6ZiCF15EHZ23vq5zm6?=
 =?us-ascii?Q?bRsxT9MN2PHpiihvndbvtqIF5TlxVRlPNCHCVKk1MHiitc5Ie89MQ/XmRSk/?=
 =?us-ascii?Q?DE2EOB7/F1oKGWcgZzRGwKIM7mbigVq3dVBNHUU28w8Y9UzwyoSMm6aX2L3Z?=
 =?us-ascii?Q?MX1q5lj/MFKIGVhVQe3Fe/Wzpr1R8KSsiJQTOvqQUaO17I5hGxbxUjDbCrmB?=
 =?us-ascii?Q?utQFMUITD+csTgxrCWJJjZ96oYlaplLIUJbVFCpu0d/4AN0ivLJDe7KO/hML?=
 =?us-ascii?Q?WOWhF9r/kTlcYpL/YwY7YCNJdQCoOkkbWhxPWZC7fRdBz31/k0U/dCu5r57q?=
 =?us-ascii?Q?FwvSCHE2xRdpZqKWkCCCrV0wa9SIV0+7/sXlYwcFLLXmz2BrmaP5dejzHDLb?=
 =?us-ascii?Q?W2BwmoqqiN2njZ7EpZFwCx34cn9HyPjtV5Jnm9khssl1EEmPywThF+Yj9z7r?=
 =?us-ascii?Q?abQWnt7W4hubR+nrlDCJVMbxHC0uncdREL7rkpQiJzbl/bf4fDfWajM9B9i0?=
 =?us-ascii?Q?0AljnARz6EOabJWttB/rr/3jPdkosgSG4s2llMU7Ok2yUarvKpGCCRa3Fe5s?=
 =?us-ascii?Q?aoDBh8PGs8D/f+72BVSHwxd0RBykcrmRwa0E6dda/X2U3nYz?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5257.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 10f9a220-3685-44cc-3ae6-08ded0e3e5cd
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Jun 2026 04:57:16.4560 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: i0Chk9LSKHSAp3OxEODQiWF2ORVzd0jos725QooNDZ3EgsBaOwP1BnyhvDfbMbE6J+li+TNpyKPZe5E84PLmMg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4354
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

AMD General

Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>

Regards,
Hawking
-----Original Message-----
From: Liu, Xiang(Dean) <Xiang.Liu@amd.com>
Sent: Tuesday, June 23, 2026 12:23
To: amd-gfx@lists.freedesktop.org
Cc: Zhang, Hawking <Hawking.Zhang@amd.com>; Zhou1, Tao <Tao.Zhou1@amd.com>;=
 Yang, Stanley <Stanley.Yang@amd.com>; Chai, Thomas <YiPeng.Chai@amd.com>; =
Liu, Xiang(Dean) <Xiang.Liu@amd.com>
Subject: [PATCH] drm/amdgpu: protect XCP scheduler selection

amdgpu_xcp_select_scheds() reads the per-XCP scheduler list.
Partition switching rebuilds the same table under xcp_lock.

Take xcp_lock around XCP scheduler selection and release.
This prevents readers from observing partially rebuilt state.

Also revalidate the selected XCP id before indexing the table.
An open file can outlive a switch to another partition mode.

Signed-off-by: Xiang Liu <xiang.liu@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_xcp.c | 37 +++++++++++++++++--------
 1 file changed, 26 insertions(+), 11 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_xcp.c b/drivers/gpu/drm/amd/=
amdgpu/amdgpu_xcp.c
index 88e6eab91bc6..1db7d2ad01fc 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_xcp.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_xcp.c
@@ -469,16 +469,21 @@ void amdgpu_xcp_release_sched(struct amdgpu_device *a=
dev,  {
        struct drm_gpu_scheduler *sched;
        struct amdgpu_ring *ring;
+       struct amdgpu_xcp_mgr *xcp_mgr =3D adev->xcp_mgr;

-       if (!adev->xcp_mgr)
+       if (!xcp_mgr)
                return;

        sched =3D entity->entity.rq->sched;
-       if (drm_sched_wqueue_ready(sched)) {
-               ring =3D to_amdgpu_ring(entity->entity.rq->sched);
-               if (ring->xcp_id < MAX_XCP)
-                       atomic_dec(&adev->xcp_mgr->xcp[ring->xcp_id].ref_cn=
t);
-       }
+       if (!drm_sched_wqueue_ready(sched))
+               return;
+
+       ring =3D to_amdgpu_ring(sched);
+
+       mutex_lock(&xcp_mgr->xcp_lock);
+       if (ring->xcp_id < xcp_mgr->num_xcps && xcp_mgr->xcp[ring->xcp_id].=
valid)
+               atomic_dec(&xcp_mgr->xcp[ring->xcp_id].ref_cnt);
+       mutex_unlock(&xcp_mgr->xcp_lock);
 }

 int amdgpu_xcp_select_scheds(struct amdgpu_device *adev, @@ -490,7 +495,9 =
@@ int amdgpu_xcp_select_scheds(struct amdgpu_device *adev,
        u32 sel_xcp_id;
        int i;
        struct amdgpu_xcp_mgr *xcp_mgr =3D adev->xcp_mgr;
+       int r =3D 0;

+       mutex_lock(&xcp_mgr->xcp_lock);
        if (fpriv->xcp_id =3D=3D AMDGPU_XCP_NO_PARTITION) {
                u32 least_ref_cnt =3D ~0;

@@ -507,19 +514,27 @@ int amdgpu_xcp_select_scheds(struct amdgpu_device *ad=
ev,
        }
        sel_xcp_id =3D fpriv->xcp_id;

+       if (sel_xcp_id >=3D xcp_mgr->num_xcps || !xcp_mgr->xcp[sel_xcp_id].=
valid) {
+               dev_err(adev->dev, "Selected partition #%d is not valid.", =
sel_xcp_id);
+               r =3D -ENODEV;
+               goto out;
+       }
+
        if (xcp_mgr->xcp[sel_xcp_id].gpu_sched[hw_ip][hw_prio].num_scheds) =
{
                *num_scheds =3D
-                       xcp_mgr->xcp[fpriv->xcp_id].gpu_sched[hw_ip][hw_pri=
o].num_scheds;
+                       xcp_mgr->xcp[sel_xcp_id].gpu_sched[hw_ip][hw_prio].=
num_scheds;
                *scheds =3D
-                       xcp_mgr->xcp[fpriv->xcp_id].gpu_sched[hw_ip][hw_pri=
o].sched;
-               atomic_inc(&adev->xcp_mgr->xcp[sel_xcp_id].ref_cnt);
+                       xcp_mgr->xcp[sel_xcp_id].gpu_sched[hw_ip][hw_prio].=
sched;
+               atomic_inc(&xcp_mgr->xcp[sel_xcp_id].ref_cnt);
                dev_dbg(adev->dev, "Selected partition #%d", sel_xcp_id);
        } else {
                dev_err(adev->dev, "Failed to schedule partition #%d.", sel=
_xcp_id);
-               return -ENOENT;
+               r =3D -ENOENT;
        }

-       return 0;
+out:
+       mutex_unlock(&xcp_mgr->xcp_lock);
+       return r;
 }

 static void amdgpu_set_xcp_id(struct amdgpu_device *adev,
--
2.34.1

