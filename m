Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DDC49C4332F
	for <amd-gfx@archiver.kernel.org>; Wed, 13 Dec 2023 07:27:27 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9341C10E712;
	Wed, 13 Dec 2023 07:27:27 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2041.outbound.protection.outlook.com [40.107.236.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 157B310E70B
 for <amd-gfx@lists.freedesktop.org>; Wed, 13 Dec 2023 07:27:25 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KMh+fTqbBpmx4f4u+rSvoo17f7yTWsfHC5MvJBMj2qgkpBVH4J4yQcxgtrw/PaEOgQxoyyYFtcuufR+AEfVl94jaR4CZV0heCc22oo13lWlybt7FPglTgI8cmJmfBJZxEW+UAQAEcnua0x1XyxSWH8jdCbQIxmBTBZXkqItbCsIR3VrgfyS7m/pb7SukROLv1VkKtx6Z8lKoTXMPvr4u2IStbCIMxAoxxzqkaOwgpYWiPwTKi+JiTI3B/GgKBj9gF3QBroaCfaPIbrXF4F75eZwlyQAVW/WxDmQZ6xvxAnv6SwFxvmzznvaLbx38tEvA4UI4/9EPfjEP1gxyV8E5AQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3L9vIdtptrpuLOygZo7ou0OUDf39Q6973BH3d0Rl9+E=;
 b=mKjYrZKUaOnABOXOGoBoSjLSC8r02co1la3m6lPtGTUxuJOiyjWFWulwVgOm40yr5PhTqgOqWrfQ2tfAtwB/cMO7IBJ8gEu3DjrBI0udqIV+srzqwKzTPWOYu7gcWgdQXdopwlgNUuGw02wksvWgZgQaMIE5AeZGEk/FaJLjPZJKAE5r4n/RN3VDhdxTABUqjMoSKAN5kd1uWEdcRGjiTnU1YPcvVMIem383QJIdTqiqbLO5Xl1wthPES/T/SifkB6Rh6f5KqT1eXQhTOLCBbp1GSkcsexhxtNkYfwfA1bXhIOOk5kpQ6qrJcFeC6VsyJiBANCH9WfTxqFrmBd7Dhw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3L9vIdtptrpuLOygZo7ou0OUDf39Q6973BH3d0Rl9+E=;
 b=2zzGEcsspNVBBrw2mXyCRyqSjtB80h51v/QSdzTpcQIiqUcdhggMKv+1v56pLGPpUMOIaWDrTHvjgOutPhXqoOVoFEXadSa98cAhLe7ufwG9M9HXxYqvqBOZ1nlDVGsMtBd9r+uk3zZZiPR8Ma/vd4WT4ssrLZEog/Kf5JYYh3s=
Received: from BY5PR12MB4194.namprd12.prod.outlook.com (2603:10b6:a03:210::7)
 by IA1PR12MB9030.namprd12.prod.outlook.com (2603:10b6:208:3f2::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7091.26; Wed, 13 Dec
 2023 07:27:20 +0000
Received: from BY5PR12MB4194.namprd12.prod.outlook.com
 ([fe80::d0a9:48b7:231a:f627]) by BY5PR12MB4194.namprd12.prod.outlook.com
 ([fe80::d0a9:48b7:231a:f627%5]) with mapi id 15.20.7091.022; Wed, 13 Dec 2023
 07:27:17 +0000
From: "Wang, Beyond" <Wang.Beyond@amd.com>
To: "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Subject: RE:  [PATCH v3] drm/amdgpu: fix ftrace event amdgpu_bo_move always
 move on same heap
Thread-Topic: [PATCH v3] drm/amdgpu: fix ftrace event amdgpu_bo_move always
 move on same heap
Thread-Index: AQHaLZXMeeyP6u7Fhk2FOBq7AofkQw==
Date: Wed, 13 Dec 2023 07:27:16 +0000
Message-ID: <BY5PR12MB41949DF20026C57A77489022F78DA@BY5PR12MB4194.namprd12.prod.outlook.com>
References: <BY5PR12MB4194EF791E7B45D0A2251CD4F78DA@BY5PR12MB4194.namprd12.prod.outlook.com>
In-Reply-To: <BY5PR12MB4194EF791E7B45D0A2251CD4F78DA@BY5PR12MB4194.namprd12.prod.outlook.com>
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
x-ms-traffictypediagnostic: BY5PR12MB4194:EE_|IA1PR12MB9030:EE_
x-ms-office365-filtering-correlation-id: 4e5f0eef-5694-4e00-77a5-08dbfbaceee1
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Sc0hJaPx4OJLXLXfGnuwlLDpzSocamrAL7wsKxTudHOOIBCWazN+Ahl+illML8rT2A6augg/iToPSwalBWbsZZei58rAhYAzNj1iEcZ4kYzCqjh0Px9dPq03k+QhukVX7rg6Ryes7Hnu1E/7MJFlNoHfMs6zDiWpnup/Nc5qv4fB6H8KkvDFeVIN9mlpbIf6ldaaxRYXWgpz6MJYlcIENxRv9ZPa2/1G0DMh24tgKITRm2LoGENK+mm3RzJYX4EGf/n9mijOzNL3/hOnxJfGhYm3u88+YHwNTA3O2wBoYlXRKdedBmWBWfdTtETh6G1vm17tSVrlTk2r5XZnyumCxJjmeuFCCwM5uF9/gPcbTR/P3f795KwuIKMXzwVN4C1c/SqEtju9gpOuumClMcllugjTAYjSCQ2Sn2o8kizK26IvMh78v/fg9iR9isvceIxQGEqHcuYipSgz3RiIkGjRGdnozrEldZ3W+UYOY7PqhW/qcX2lbtQiZjQpWNQChhsguhQF6G4pjXgMcuOUvVKpkd3uXMemdz3E44LyKlXqrYVAnEPQdZWVi6mXDVWrMgdf4d5HG5qGW+zCj0YPL/qxZojAX9w5Ub5dbMgFLTDXfP6pv0ZqQC6kBZ8ZnGkMWyRS
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BY5PR12MB4194.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(346002)(39860400002)(396003)(376002)(136003)(366004)(230922051799003)(186009)(451199024)(1800799012)(64100799003)(38070700009)(55016003)(66476007)(76116006)(66946007)(66556008)(38100700002)(122000001)(33656002)(86362001)(66446008)(26005)(83380400001)(2940100002)(9686003)(6506007)(7696005)(2906002)(64756008)(6916009)(316002)(478600001)(71200400001)(5660300002)(8936002)(8676002)(4326008)(41300700001)(52536014);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?Czss47VFJSEoAlcxod/nPK3Ux8Ygv0hIzTq3Kj30ikN0C0ClMv7FvEnD3poF?=
 =?us-ascii?Q?4s6Z1rp1hGAH7utsEWWPdJyQzRZJ6lfWu6twIAurTQhexSoi8OjWzAH+1Bqm?=
 =?us-ascii?Q?8vG52MXgZF4Y03RX1LCZPVlZXR1G7mTwDVYbjsBtuWWP5j1FtrOBzK037sZF?=
 =?us-ascii?Q?gzTkORf7ZarPlHusPv4O16PDierllGHmtuW8pjPYUL7LCywTK2nTYFI/w+/q?=
 =?us-ascii?Q?CTvuwWxTlB4qUr//aPtlI+x1efnMysDGx17w/O2PXbNCMUFFtuCumwQBLlhf?=
 =?us-ascii?Q?YzwUyWJjpKDtodvjwbnuEPsIL5I+vU5Rpky/0N1FoV/SlYKINbR5srDZHKFT?=
 =?us-ascii?Q?VSfudYDzeoQFkcC6wYLLAmlxM4wx4swKRwYW9dzVOOb0TgsMCJ5Km1kzQbxq?=
 =?us-ascii?Q?uAEINsRyazj0gsPWQp3307x5NscFpMdDmodcG3c34ynGpW6fX7e2QNfcVG6A?=
 =?us-ascii?Q?OR40rfEkk/qcLI97VVbqM007mH5RbyymIXyvhV4cwicvKXEgCPRC1MZAa4Md?=
 =?us-ascii?Q?vsqc/TM3tRXUX9YpXtI8gtRVTiyWWb0h0KsVddr3h26/Td97rlZH1KMKdB+q?=
 =?us-ascii?Q?hmRl88xFw5w02h7ms7khvgc/hTWqpeXk8f2JlyrXh3h3pc/Y9jOoDF6qBv1U?=
 =?us-ascii?Q?HWUfkb9BgW5JVxgH4slow6Fm4vzLakfASFcog/nxtTX1FOYy5eqKUomglEAC?=
 =?us-ascii?Q?2pv9EuncFgl5kYcjT1LusByFESQctgl5JGdXC8yZN51gLi1xXZtXsGeD4Qzh?=
 =?us-ascii?Q?3FIlUF7EqboTZ0Ljtq32FfT+d/Y8qQm3SIzA70uc32vPPozcH4441LVysDs1?=
 =?us-ascii?Q?V6h0/IFDV30pfO8kutTu3xQk7HKlbvV7GIibmxtaR8tRfq9MvSi7IYe2BMwO?=
 =?us-ascii?Q?h9S5qVWUUd4qv4mINF9OxUwHgM9xqBU6gfJp9H1z4SUyKXFJ+GLeozUzOmlz?=
 =?us-ascii?Q?8Jc+YLrh/ot94u7vicvxbWj0CQPWFH4lR+j1LLKvY7M9UjF31vEwhJqGA1p0?=
 =?us-ascii?Q?aVjqn3lFp/zIDJAS0yCmAYNI2aD50Xkp/zRq6QRv1AH5r8FVqVkDhiL1O7tx?=
 =?us-ascii?Q?Fi9kB17Hm+w5R3xtsCFHgwb6cx2s/1yxTUI45Qhnbrdsc9tdv9Z60m8A5M3e?=
 =?us-ascii?Q?l01zEvbT+ToNN6m6DkqmCFXDnrboio4DjSoRbuC6weGa8ivnnXvSSHL5pqR/?=
 =?us-ascii?Q?BWgxbS8cpTEVhb++hPxtiHz9mBwZm48cUs0MNo7Hl2xY2+LS7yFSy05QZwEL?=
 =?us-ascii?Q?b7XBc+dBal4cBYm8LPfcng8LkqU9OMxjGYVnV23b6OPr87JZlqPwecaV8Fgl?=
 =?us-ascii?Q?GE1Sz4gJcAWuWDhjUgenzEss+4xpkYscX4A+fw+fN3O0gmYnnSAGy3KaprZh?=
 =?us-ascii?Q?kIfcvdZ2X7s7NtSbq7BSAFOYIZ0HEGxLh40N2zPx3u4Rlskt2UQZBdgWjRrw?=
 =?us-ascii?Q?F/bb9OOtd9TBia9rYAjrv0njROd41o1Ku8aTkkptw3fYV2YfILCcNQgoyGZX?=
 =?us-ascii?Q?7FhI+A6yoqopuePVsRcfTNKNm1LO0GJySRhEezlpKEo9P2jPtZJpAOM533ZL?=
 =?us-ascii?Q?Rf8APO123425xWqaqik=3D?=
Content-Type: multipart/alternative;
 boundary="_000_BY5PR12MB41949DF20026C57A77489022F78DABY5PR12MB4194namp_"
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BY5PR12MB4194.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4e5f0eef-5694-4e00-77a5-08dbfbaceee1
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Dec 2023 07:27:16.3500 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: IF8Hndgw0GIwW7K5x7w1WFxHGezCuy54b0jZAbOEfJdPM2Z+Uuty67vtTs7i6kyDSXgNxmOcUoz92yzbnKDjGQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB9030
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

--_000_BY5PR12MB41949DF20026C57A77489022F78DABY5PR12MB4194namp_
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


--_000_BY5PR12MB41949DF20026C57A77489022F78DABY5PR12MB4194namp_
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
.MsoChpDefault
	{mso-style-type:export-only;
	font-size:10.0pt;
	mso-ligatures:none;}
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

--_000_BY5PR12MB41949DF20026C57A77489022F78DABY5PR12MB4194namp_--
