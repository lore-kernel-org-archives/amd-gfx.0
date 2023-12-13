Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 735B7C4332F
	for <amd-gfx@archiver.kernel.org>; Wed, 13 Dec 2023 02:04:42 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0E8D310E0D5;
	Wed, 13 Dec 2023 02:04:42 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2062.outbound.protection.outlook.com [40.107.220.62])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7C6AC10E0D5
 for <amd-gfx@lists.freedesktop.org>; Wed, 13 Dec 2023 02:04:39 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gKiAoYovi/xQ8laGhdYlD5DKzU2V2iVBeuO0SfCrqtkWwjuWXwwHH5OVybo630JCE3E0ZU7sWgd0RUS24O2vmwNJyGl/ZMxBXiYAWEaYPnZttsy/6jEmi4xOsXdK+8uywS5vCtyVmrb96fsN6SRanuBlQMHxcBBr4Cs4V3sjN4kkw5LPAe6bHdhtl8Qni6O2HbsP7PUXqZU0FISUguOyYnW2xQuxZIz8c3Tt1ZKK6UDx+nAT/jx/QeB+dOqIDYHzj4An82fv4LF4c3dPVqx1BUA5B2cH0HZ6vSEAmcviddlM+mHw5cyGFIBiSV+7Hf+yZ/cX5NlyAhNzhRtnfHGUsg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TCpsLgW7iGbvOucJkWQvS3dPyq9K29vYAONShGkZXcQ=;
 b=dCvPi6pWf1lN9pmVTKDMddE2hN5ptCkKoqBq2MYvT3PbrlK+zSCMw28wYI1lLrHSwIqMHjOCdQIiZ2kW2j5oeM18Ww6dxGhI30jFHw0TNnFGdxGElyMuzU5IiBhgATT6uLKa2M9t33Kbz1AgbmwA8bKMsBPDQkOQ3dJ7HoH35h8hTddCcrqCkbbpRc6zvLkBK0+3AmieJSJ9+GU5krjEim+dOEGpdAmDyiwpG3gOpyWfeLa4LMVBDnnQR5GACjBdjK0ccAqTgxqaDiZp/DF22A1gd/TUlJmJlCXFlyAQS15qkICQytSTAZndxjTHpUPXA65Inso4tdfPUqYj5A0poQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TCpsLgW7iGbvOucJkWQvS3dPyq9K29vYAONShGkZXcQ=;
 b=5OP47Gat6h8O8mgf7B2M4Emglg7QfeLukMEfbHXpaY1eBq+NiXTYqKGmRwdM5IbEzlrIwn0E6qVnyA3vLZPefW/KQAB2nOgvgsHLQ2Y7EAPmMfC1V+fWIqtaPczlLw0BNZtjZXkTQ3YmnXHdMUWyPaPBDFqUUO1GhNJA2U2vjTU=
Received: from BY5PR12MB4194.namprd12.prod.outlook.com (2603:10b6:a03:210::7)
 by DM3PR12MB9414.namprd12.prod.outlook.com (2603:10b6:0:47::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7091.26; Wed, 13 Dec
 2023 02:04:35 +0000
Received: from BY5PR12MB4194.namprd12.prod.outlook.com
 ([fe80::d0a9:48b7:231a:f627]) by BY5PR12MB4194.namprd12.prod.outlook.com
 ([fe80::d0a9:48b7:231a:f627%5]) with mapi id 15.20.7068.033; Wed, 13 Dec 2023
 02:04:35 +0000
From: "Wang, Beyond" <Wang.Beyond@amd.com>
To: "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Subject: [PATCH v2] drm/amdgpu: fix ftrace event amdgpu_bo_move always move
Thread-Topic: [PATCH v2] drm/amdgpu: fix ftrace event amdgpu_bo_move always
 move
Thread-Index: AdotaGvI5IYYDAx4SXCooIvPfazAzQ==
Date: Wed, 13 Dec 2023 02:04:35 +0000
Message-ID: <BY5PR12MB4194EF791E7B45D0A2251CD4F78DA@BY5PR12MB4194.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=c15f55c3-be0d-43f2-85f7-67d721c4b8f1;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=0;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2023-12-13T01:59:42Z;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BY5PR12MB4194:EE_|DM3PR12MB9414:EE_
x-ms-office365-filtering-correlation-id: 2d551ab6-a23d-4107-65f1-08dbfb7fdaf0
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: QELjPQJXhIlBTLYOSiUiplaaTr+Hbqsa/LxzdpkSSg4kznNaX5/vvCAU0z/5W1QE2hS66eTp0KG2++SQGEzoySyzX+HenoIigsNSgY8Xo+jOaNfmCUZH56SewH6R9z6f7Ed9DrIGY0a1nYdY15QBTbiXohwr/RJpsKnAuZ9G3AQQGuBcK5VC4WbSJsc8cutch3EUTYmF5qZUkC62FNBtXYCEygAh7vex/VlJ5SWN+Hy6GvlPtkoa3TmfIZTtHquqysn3PcTeXi7+xFZ5ZHbPq0kkigpCxI7VszyWTrxoZvLzP2MlU6Rrmo8M25tybpEYY2sfIZIAoKTp13cQcQdo2qsrwnTxwjbMCGXHdKK+Gan50YldS+Bm2Tz5jTlFeYiJzm42JdIKINioQzEfZPNNgdsc6pmNuHtT3Sx+cngtu1txg6odsFuFl+8jf2uWBlj9fb15ugq5CJTVdUXFshwLZ7GWdfAva4CU45q6wxXySnoDYjJndZIgvY5c+2rqc/1f714+cLHNpEqIiNHfcntjFrPHRUTlFy6xzL34mPtIEIT6/d3bKmyFSRGphtadxSPWNc8lAG9N3sY5Cp25mH/jrSSMYobMOg6TY8JEPUrec/pqOuhWWQok+i1nEaf1XG1/
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BY5PR12MB4194.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(346002)(376002)(136003)(396003)(39860400002)(366004)(230922051799003)(451199024)(1800799012)(186009)(64100799003)(26005)(83380400001)(6506007)(9686003)(38100700002)(122000001)(7696005)(5660300002)(4326008)(8936002)(52536014)(8676002)(41300700001)(2906002)(478600001)(71200400001)(316002)(66476007)(66446008)(6916009)(64756008)(66556008)(66946007)(76116006)(33656002)(86362001)(38070700009)(55016003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?u2IsF0R0IolExm8YwQtdoBpTQ75epHYkve+YJCFb46LwC8tK0mKk6UGwWSt6?=
 =?us-ascii?Q?elIKs+CI5FLPQt/BWRJiR8cEAZEgpqEftES0gfpuRLOONGJolm3ZEt2MF7jx?=
 =?us-ascii?Q?uI0YU1sfZf1WvjyRMDiQtEwNL8DYVOpqmKV79V8fCsldybuJArrOAq6BHd0w?=
 =?us-ascii?Q?6966EnXO1w2r34q1E33kuPzPiFH0isozSqy2uWtg6t4JxX2wac+igTnf+I1X?=
 =?us-ascii?Q?AF/s5RMskFygf4mkOYlxtttQLvd820sBpCV6rMoRGqeLQQgq0gcE9KcveJBf?=
 =?us-ascii?Q?j/ev0l35SMwCWl1iuL4eLjDTBpZU4mY8yklUZqaqUgo6p3Z1tl+ZSZFeY7fC?=
 =?us-ascii?Q?yUMR2rzCy5fV+0Ei4wPpB1MjeJMx4d4tvAWdHPVGUAK5KH+fS9mZ9If8inj5?=
 =?us-ascii?Q?jxUifugKs/7QwV92Mnd6eugfndnxAN04qxXX5VdpDx/qoODPC4iJOszhJBJR?=
 =?us-ascii?Q?c2Z/8gQWkP8LYAIj75JCGFi4G7mz6Z+nqJUC1/LOEjw0nnzJcWT/lq4l5vC/?=
 =?us-ascii?Q?GrYYb8Le+0bh4IRGjlXsHDCj/EH1fDOBrDBhPijz76kMrY/lar7EksQjBPki?=
 =?us-ascii?Q?wOoBag45usNhRc0bk527AGQWR1Hb0oqUsuYtAkglyAipI+hqViPb/VDeZZBg?=
 =?us-ascii?Q?Ud3+PV5SyIsgI0o638QBZq3Tx9kGV8ToWoYlRAzx8tBBvf7z6P+31v1JweEZ?=
 =?us-ascii?Q?G3qTQuErj5Xw0i77ze0FwCqd+o8PG4y5E4DyrOKxCdPJd1mcr2JmAfwVhdJx?=
 =?us-ascii?Q?BkzK+OhAOThpk/jTkw4UEsGW4lpJyySc9lhnZg6cxS0wBmsTLNo7ACDZcHVk?=
 =?us-ascii?Q?i97YGPd1wRZB1Ztz6kcHQDlB0uPqwdfRg60sXPnjXgZ9pqwGmfDPiZZjtHhe?=
 =?us-ascii?Q?oGK2VNMmFJrjFfvLS7WoWQqYN+vMM9z419HtaAeZjTG7+gqP+GIrPuymhW0M?=
 =?us-ascii?Q?txOUG+tnhu6++lXxHH44p7C3HjqUMQqpZQI1oAH7vMgnDcOyxUqjRSbfn5Yh?=
 =?us-ascii?Q?CHPoHlRKVgQMYw0eATmgjvMmUNbI8P55DGmnuyvin++UYrcN1QMoqtCa0LOI?=
 =?us-ascii?Q?+GS8zBelDpC8WAfasfnK2B9190jTdEVgVVYbiptExkHTdwRcSeOlWUTPY5oL?=
 =?us-ascii?Q?eR4QPb/0D4r1FHRbpyQX6nQbBMDgYTEHGGAuMU9WbRHYpzIcjF66Jifuw7Kr?=
 =?us-ascii?Q?oVHFSlKW0PA1iXxEr93UGtRuwr+pZ37zP5G1+3DNMRIIwMFA85bN1OI7+jlj?=
 =?us-ascii?Q?KnetSI0ea5A/v51vAB7t2v6VZkoBa/2Tluli4IPxKH+Cuakl11v6s/rpeekX?=
 =?us-ascii?Q?Fq9LF9cXSCJbqp7urm+7z4pFHxaA0RzOcSD/YiB/Qqzyi5mPgPbdNLAmE/PU?=
 =?us-ascii?Q?lWWfURiX6y6OEIbzxhsNknbFhsGePOPDUWwQZMGiGek1t+pSBGwuqaLz2WnM?=
 =?us-ascii?Q?8vJJX9gTZAwVkq+culqWKQLDHEPsFE2O8t7eWv5PDjGnH3aMzoOX+9zKPT3S?=
 =?us-ascii?Q?W5Wg7/3jlbNzbgxbEdl9IS/Qw+DFYdH3I3Cfu1nXpmL7hubc3Sx+eMBrlFXY?=
 =?us-ascii?Q?3u3miOfOrY2HOTtDtRk=3D?=
Content-Type: multipart/alternative;
 boundary="_000_BY5PR12MB4194EF791E7B45D0A2251CD4F78DABY5PR12MB4194namp_"
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BY5PR12MB4194.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2d551ab6-a23d-4107-65f1-08dbfb7fdaf0
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Dec 2023 02:04:35.5124 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: fa1uQZkTQ3zQp20T6uLrbdO/8zkMdLjD5SzcQTkSsqGYlNpLRDCIFWt1gfYMUmQyS+jICnQjlGkvkorNs6n4pA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM3PR12MB9414
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
Cc: "Jin, Jason\(Yong\)" <JasonYong.Jin@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--_000_BY5PR12MB4194EF791E7B45D0A2251CD4F78DABY5PR12MB4194namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

[AMD Official Use Only - General]


Issue: during evict or validate happened on amdgpu_bo, the 'from' and
'to' is always same in ftrace event of amdgpu_bo_move

where calling the 'trace_amdgpu_bo_move', the comment says move_notify
is called before move happens, but actually it is called after move
happens, here the new_mem is same as bo->resource

Fix: move trace_amdgpu_bo_move from move_notify to amdgpu_bo_move

Signed-off-by: Wang, Beyond Wang.Beyond@amd.com<mailto:Wang.Beyond@amd.com>
---
drivers/gpu/drm/amd/amdgpu/amdgpu_object.c | 13 +------------
drivers/gpu/drm/amd/amdgpu/amdgpu_object.h |  4 +---
drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c    |  5 +++--
3 files changed, 5 insertions(+), 17 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c b/drivers/gpu/drm/a=
md/amdgpu/amdgpu_object.c
index 7416799750c1..1870775d582c 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
@@ -1282,19 +1282,15 @@ int amdgpu_bo_get_metadata(struct amdgpu_bo *bo, vo=
id *buffer,
  * amdgpu_bo_move_notify - notification about a memory move
  * @bo: pointer to a buffer object
  * @evict: if this move is evicting the buffer from the graphics address s=
pace
- * @new_mem: new information of the bufer object
  *
  * Marks the corresponding &amdgpu_bo buffer object as invalid, also perfo=
rms
  * bookkeeping.
  * TTM driver callback which is called when ttm moves a buffer.
  */
-void amdgpu_bo_move_notify(struct ttm_buffer_object *bo,
-                          bool evict,
-                          struct ttm_resource *new_mem)
+void amdgpu_bo_move_notify(struct ttm_buffer_object *bo, bool evict)
{
        struct amdgpu_device *adev =3D amdgpu_ttm_adev(bo->bdev);
        struct amdgpu_bo *abo;
-       struct ttm_resource *old_mem =3D bo->resource;

        if (!amdgpu_bo_is_amdgpu_bo(bo))
                return;
@@ -1313,13 +1309,6 @@ void amdgpu_bo_move_notify(struct ttm_buffer_object =
*bo,
        /* remember the eviction */
        if (evict)
                atomic64_inc(&adev->num_evictions);
-
-       /* update statistics */
-       if (!new_mem)
-               return;
-
-       /* move_notify is called before move happens */
-       trace_amdgpu_bo_move(abo, new_mem->mem_type, old_mem->mem_type);
}

void amdgpu_bo_get_memory(struct amdgpu_bo *bo,
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.h b/drivers/gpu/drm/a=
md/amdgpu/amdgpu_object.h
index 876acde6b10a..dee2c577427e 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.h
@@ -360,9 +360,7 @@ int amdgpu_bo_set_metadata (struct amdgpu_bo *bo, void =
*metadata,
int amdgpu_bo_get_metadata(struct amdgpu_bo *bo, void *buffer,
                           size_t buffer_size, uint32_t *metadata_size,
                           uint64_t *flags);
-void amdgpu_bo_move_notify(struct ttm_buffer_object *bo,
-                          bool evict,
-                          struct ttm_resource *new_mem);
+void amdgpu_bo_move_notify(struct ttm_buffer_object *bo, bool evict);
void amdgpu_bo_release_notify(struct ttm_buffer_object *bo);
vm_fault_t amdgpu_bo_fault_reserve_notify(struct ttm_buffer_object *bo);
void amdgpu_bo_fence(struct amdgpu_bo *bo, struct dma_fence *fence,
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c b/drivers/gpu/drm/amd/=
amdgpu/amdgpu_ttm.c
index 41ed6a3e5a06..f0fffbf2bdd5 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
@@ -576,10 +576,11 @@ static int amdgpu_bo_move(struct ttm_buffer_object *b=
o, bool evict,
                        return r;
        }

+       trace_amdgpu_bo_move(abo, new_mem->mem_type, old_mem->mem_type);
out:
        /* update statistics */
        atomic64_add(bo->base.size, &adev->num_bytes_moved);
-       amdgpu_bo_move_notify(bo, evict, new_mem);
+       amdgpu_bo_move_notify(bo, evict);
        return 0;
}

@@ -1852,7 +1853,7 @@ static int amdgpu_ttm_access_memory(struct ttm_buffer=
_object *bo,
static void
amdgpu_bo_delete_mem_notify(struct ttm_buffer_object *bo)
{
-       amdgpu_bo_move_notify(bo, false, NULL);
+       amdgpu_bo_move_notify(bo, false);
}

static struct ttm_device_funcs amdgpu_bo_driver =3D {
--
2.34.1


--_000_BY5PR12MB4194EF791E7B45D0A2251CD4F78DABY5PR12MB4194namp_
Content-Type: text/html; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<html xmlns:v=3D"urn:schemas-microsoft-com:vml" xmlns:o=3D"urn:schemas-micr=
osoft-com:office:office" xmlns:w=3D"urn:schemas-microsoft-com:office:word" =
xmlns:m=3D"http://schemas.microsoft.com/office/2004/12/omml" xmlns=3D"http:=
//www.w3.org/TR/REC-html40">
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Dus-ascii"=
>
<meta name=3D"Generator" content=3D"Microsoft Word 15 (filtered medium)">
<style><!--
/* Font Definitions */
@font-face
	{font-family:"Cambria Math";
	panose-1:2 4 5 3 5 4 6 3 2 4;}
@font-face
	{font-family:DengXian;
	panose-1:2 1 6 0 3 1 1 1 1 1;}
@font-face
	{font-family:Calibri;
	panose-1:2 15 5 2 2 2 4 3 2 4;}
@font-face
	{font-family:"\@DengXian";
	panose-1:2 1 6 0 3 1 1 1 1 1;}
/* Style Definitions */
p.MsoNormal, li.MsoNormal, div.MsoNormal
	{margin:0cm;
	font-size:11.0pt;
	font-family:"Calibri",sans-serif;
	mso-ligatures:standardcontextual;}
a:link, span.MsoHyperlink
	{mso-style-priority:99;
	color:#0563C1;
	text-decoration:underline;}
span.EmailStyle17
	{mso-style-type:personal-compose;
	font-family:"Calibri",sans-serif;
	color:windowtext;}
.MsoChpDefault
	{mso-style-type:export-only;
	font-family:"Calibri",sans-serif;}
@page WordSection1
	{size:612.0pt 792.0pt;
	margin:72.0pt 72.0pt 72.0pt 72.0pt;}
div.WordSection1
	{page:WordSection1;}
--></style><!--[if gte mso 9]><xml>
<o:shapedefaults v:ext=3D"edit" spidmax=3D"1026" />
</xml><![endif]--><!--[if gte mso 9]><xml>
<o:shapelayout v:ext=3D"edit">
<o:idmap v:ext=3D"edit" data=3D"1" />
</o:shapelayout></xml><![endif]-->
</head>
<body lang=3D"EN-US" link=3D"#0563C1" vlink=3D"#954F72" style=3D"word-wrap:=
break-word">
<p style=3D"font-family:Arial;font-size:10pt;color:#0000FF;margin:5pt;font-=
style:normal;font-weight:normal;text-decoration:none;" align=3D"Left">
[AMD Official Use Only - General]<br>
</p>
<br>
<div>
<div class=3D"WordSection1">
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">Issue: during evict or validate happened on amdgpu_b=
o, the 'from' and<o:p></o:p></p>
<p class=3D"MsoNormal">'to' is always same in ftrace event of amdgpu_bo_mov=
e<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">where calling the 'trace_amdgpu_bo_move', the commen=
t says move_notify<o:p></o:p></p>
<p class=3D"MsoNormal">is called before move happens, but actually it is ca=
lled after move<o:p></o:p></p>
<p class=3D"MsoNormal">happens, here the new_mem is same as bo-&gt;resource=
<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">Fix: move trace_amdgpu_bo_move from move_notify to a=
mdgpu_bo_move<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">Signed-off-by: Wang, Beyond <a href=3D"mailto:Wang.B=
eyond@amd.com">
Wang.Beyond@amd.com</a><o:p></o:p></p>
<p class=3D"MsoNormal">---<o:p></o:p></p>
<p class=3D"MsoNormal">drivers/gpu/drm/amd/amdgpu/amdgpu_object.c | 13 +---=
---------<o:p></o:p></p>
<p class=3D"MsoNormal">drivers/gpu/drm/amd/amdgpu/amdgpu_object.h |&nbsp; 4=
 +---<o:p></o:p></p>
<p class=3D"MsoNormal">drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c&nbsp;&nbsp;&=
nbsp; |&nbsp; 5 +++--<o:p></o:p></p>
<p class=3D"MsoNormal">3 files changed, 5 insertions(+), 17 deletions(-)<o:=
p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_objec=
t.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c<o:p></o:p></p>
<p class=3D"MsoNormal">index 7416799750c1..1870775d582c 100644<o:p></o:p></=
p>
<p class=3D"MsoNormal">--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c<o:p=
></o:p></p>
<p class=3D"MsoNormal">+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c<o:p=
></o:p></p>
<p class=3D"MsoNormal">@@ -1282,19 +1282,15 @@ int amdgpu_bo_get_metadata(s=
truct amdgpu_bo *bo, void *buffer,<o:p></o:p></p>
<p class=3D"MsoNormal">&nbsp; * amdgpu_bo_move_notify - notification about =
a memory move<o:p></o:p></p>
<p class=3D"MsoNormal">&nbsp; * @bo: pointer to a buffer object<o:p></o:p><=
/p>
<p class=3D"MsoNormal">&nbsp; * @evict: if this move is evicting the buffer=
 from the graphics address space<o:p></o:p></p>
<p class=3D"MsoNormal">- * @new_mem: new information of the bufer object<o:=
p></o:p></p>
<p class=3D"MsoNormal">&nbsp; *<o:p></o:p></p>
<p class=3D"MsoNormal">&nbsp; * Marks the corresponding &amp;amdgpu_bo buff=
er object as invalid, also performs<o:p></o:p></p>
<p class=3D"MsoNormal">&nbsp; * bookkeeping.<o:p></o:p></p>
<p class=3D"MsoNormal">&nbsp; * TTM driver callback which is called when tt=
m moves a buffer.<o:p></o:p></p>
<p class=3D"MsoNormal">&nbsp; */<o:p></o:p></p>
<p class=3D"MsoNormal">-void amdgpu_bo_move_notify(struct ttm_buffer_object=
 *bo,<o:p></o:p></p>
<p class=3D"MsoNormal">-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp; bool evict,<o:p></o:p></p>
<p class=3D"MsoNormal">-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp; struct ttm_resource *new_mem)<o:p></o:p></p>
<p class=3D"MsoNormal">+void amdgpu_bo_move_notify(struct ttm_buffer_object=
 *bo, bool evict)<o:p></o:p></p>
<p class=3D"MsoNormal">{<o:p></o:p></p>
<p class=3D"MsoNormal">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct am=
dgpu_device *adev =3D amdgpu_ttm_adev(bo-&gt;bdev);<o:p></o:p></p>
<p class=3D"MsoNormal">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct am=
dgpu_bo *abo;<o:p></o:p></p>
<p class=3D"MsoNormal">-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct ttm_res=
ource *old_mem =3D bo-&gt;resource;<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!amdg=
pu_bo_is_amdgpu_bo(bo))<o:p></o:p></p>
<p class=3D"MsoNormal">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return;<o:p></o:p></p>
<p class=3D"MsoNormal">@@ -1313,13 +1309,6 @@ void amdgpu_bo_move_notify(st=
ruct ttm_buffer_object *bo,<o:p></o:p></p>
<p class=3D"MsoNormal">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* rememb=
er the eviction */<o:p></o:p></p>
<p class=3D"MsoNormal">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (evict=
)<o:p></o:p></p>
<p class=3D"MsoNormal">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; atomic64_inc(&amp;adev-&gt;num_evict=
ions);<o:p></o:p></p>
<p class=3D"MsoNormal">-<o:p></o:p></p>
<p class=3D"MsoNormal">-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* update stat=
istics */<o:p></o:p></p>
<p class=3D"MsoNormal">-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!new_mem)<=
o:p></o:p></p>
<p class=3D"MsoNormal">-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return;<o:p></o:p></p>
<p class=3D"MsoNormal">-<o:p></o:p></p>
<p class=3D"MsoNormal">-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* move_notify=
 is called before move happens */<o:p></o:p></p>
<p class=3D"MsoNormal">-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; trace_amdgpu_b=
o_move(abo, new_mem-&gt;mem_type, old_mem-&gt;mem_type);<o:p></o:p></p>
<p class=3D"MsoNormal">}<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">void amdgpu_bo_get_memory(struct amdgpu_bo *bo,<o:p>=
</o:p></p>
<p class=3D"MsoNormal">diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_objec=
t.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.h<o:p></o:p></p>
<p class=3D"MsoNormal">index 876acde6b10a..dee2c577427e 100644<o:p></o:p></=
p>
<p class=3D"MsoNormal">--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.h<o:p=
></o:p></p>
<p class=3D"MsoNormal">+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.h<o:p=
></o:p></p>
<p class=3D"MsoNormal">@@ -360,9 +360,7 @@ int amdgpu_bo_set_metadata (stru=
ct amdgpu_bo *bo, void *metadata,<o:p></o:p></p>
<p class=3D"MsoNormal">int amdgpu_bo_get_metadata(struct amdgpu_bo *bo, voi=
d *buffer,<o:p></o:p></p>
<p class=3D"MsoNormal">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp; size_t buffer_size, uint32_t *metadata_size,<=
o:p></o:p></p>
<p class=3D"MsoNormal">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint64_t *flags);<o:p></o:p></p>
<p class=3D"MsoNormal">-void amdgpu_bo_move_notify(struct ttm_buffer_object=
 *bo,<o:p></o:p></p>
<p class=3D"MsoNormal">-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp; bool evict,<o:p></o:p></p>
<p class=3D"MsoNormal">-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp; struct ttm_resource *new_mem);<o:p></o:p></p>
<p class=3D"MsoNormal">+void amdgpu_bo_move_notify(struct ttm_buffer_object=
 *bo, bool evict);<o:p></o:p></p>
<p class=3D"MsoNormal">void amdgpu_bo_release_notify(struct ttm_buffer_obje=
ct *bo);<o:p></o:p></p>
<p class=3D"MsoNormal">vm_fault_t amdgpu_bo_fault_reserve_notify(struct ttm=
_buffer_object *bo);<o:p></o:p></p>
<p class=3D"MsoNormal">void amdgpu_bo_fence(struct amdgpu_bo *bo, struct dm=
a_fence *fence,<o:p></o:p></p>
<p class=3D"MsoNormal">diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c=
 b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c<o:p></o:p></p>
<p class=3D"MsoNormal">index 41ed6a3e5a06..f0fffbf2bdd5 100644<o:p></o:p></=
p>
<p class=3D"MsoNormal">--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c<o:p></=
o:p></p>
<p class=3D"MsoNormal">+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c<o:p></=
o:p></p>
<p class=3D"MsoNormal">@@ -576,10 +576,11 @@ static int amdgpu_bo_move(stru=
ct ttm_buffer_object *bo, bool evict,<o:p></o:p></p>
<p class=3D"MsoNormal">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp; return r;<o:p></o:p></p>
<p class=3D"MsoNormal">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<o:p></o=
:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; trace_amdgpu_b=
o_move(abo, new_mem-&gt;mem_type, old_mem-&gt;mem_type);<o:p></o:p></p>
<p class=3D"MsoNormal">out:<o:p></o:p></p>
<p class=3D"MsoNormal">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* update=
 statistics */<o:p></o:p></p>
<p class=3D"MsoNormal">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; atomic64_=
add(bo-&gt;base.size, &amp;adev-&gt;num_bytes_moved);<o:p></o:p></p>
<p class=3D"MsoNormal">-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_bo_move=
_notify(bo, evict, new_mem);<o:p></o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_bo_move=
_notify(bo, evict);<o:p></o:p></p>
<p class=3D"MsoNormal">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return 0;=
<o:p></o:p></p>
<p class=3D"MsoNormal">}<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">@@ -1852,7 +1853,7 @@ static int amdgpu_ttm_access_m=
emory(struct ttm_buffer_object *bo,<o:p></o:p></p>
<p class=3D"MsoNormal">static void<o:p></o:p></p>
<p class=3D"MsoNormal">amdgpu_bo_delete_mem_notify(struct ttm_buffer_object=
 *bo)<o:p></o:p></p>
<p class=3D"MsoNormal">{<o:p></o:p></p>
<p class=3D"MsoNormal">-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_bo_move=
_notify(bo, false, NULL);<o:p></o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_bo_move=
_notify(bo, false);<o:p></o:p></p>
<p class=3D"MsoNormal">}<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">static struct ttm_device_funcs amdgpu_bo_driver =3D =
{<o:p></o:p></p>
<p class=3D"MsoNormal">--<o:p></o:p></p>
<p class=3D"MsoNormal">2.34.1<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
</div>
</div>
</body>
</html>

--_000_BY5PR12MB4194EF791E7B45D0A2251CD4F78DABY5PR12MB4194namp_--
