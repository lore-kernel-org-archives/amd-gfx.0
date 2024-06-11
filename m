Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A340DC25B76
	for <amd-gfx@archiver.kernel.org>; Tue, 11 Jun 2024 12:48:23 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0B53410E08C;
	Tue, 11 Jun 2024 12:48:23 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="xQ1zIDjN";
	dkim-atps=neutral
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2048.outbound.protection.outlook.com [40.107.237.48])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B2C8210E601
 for <amd-gfx@lists.freedesktop.org>; Tue, 11 Jun 2024 12:48:15 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=j/jeocRc4efz497sTWAR6xZyH6PSnO9rtwVNiPza5jDS34Vtidh2clQ9/F/NfMSPCoAMuTiqjk42yaSCYtryTZT/rInwEZP4YGDfuj0onL5Jfe0R0/x55C/NLmRUEPGR6FjrtNe+pgVI6QXASykyRO2HXYjQnkeZVDJnDnVpsG9PFyHKXUhgO2vVe9esHt+omgou6KRN4xFn+vh3P2iEA2bc8kCtlFwgwVG4bB2gkj88DKHj7UsJl3fb8xPO6zASuOWWj50PUB4yDkSXxgWLU00/5C/pvHw5W8PvNFGjNJ8bMKeSPE9o6tsERGlZTAFnZ7SoqwqxLum/xcy0Y65rkg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BKNBAsehN8o4R3zbxMTgrvhO+fBYjyU2pHN17+PEKeM=;
 b=NXz+Z/s3wKoqjwUe2CqHfkQ02f+Ebd5fD9o19iDfccWBLpu283tr6DYUVsorPfgnzjrqRldzEb8AsTRiO7mAjkvtHGW0t+1gAOwgNDKVKGbm/+f0VfoxHZuuY9hXc3eLMqhf1X6Kv5Kue0PCfhqaOaImynIDRCxOaA0SepIgflVjvKDh8ou3vJN+x/R92hC0+v62WuFIYp5EJhTzTTJnZBNxaGh3gMZWJnf6ghhCkx82u4r7mAIRWGZNFIEuKSq932YitPWM8rfjdd5sA44TVGmiaREhzOx0WDIYdtpF0taGeXUzWXqBQrTa7QXpvAsBifIIemps4ibPt5YXU07kDQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BKNBAsehN8o4R3zbxMTgrvhO+fBYjyU2pHN17+PEKeM=;
 b=xQ1zIDjN0QdmFn+vREatu8/urfw5/8IqrD7+oU6rMTLbtgo2m2TvszFZnL1JEhpBtN4LLcIRAUBFFsHhzmSQgi3Fv6gCQHVfmbEpAn67IA32NohZoAQVIoc2cNrGdl/cLHt+smCS9RrmSQJ+slSEuFGrJWTKAiFvsLPQ25wyYYk=
Received: from BL1PR12MB5144.namprd12.prod.outlook.com (2603:10b6:208:316::6)
 by CYXPR12MB9385.namprd12.prod.outlook.com (2603:10b6:930:e2::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.37; Tue, 11 Jun
 2024 12:48:11 +0000
Received: from BL1PR12MB5144.namprd12.prod.outlook.com
 ([fe80::491a:cce3:e531:3c42]) by BL1PR12MB5144.namprd12.prod.outlook.com
 ([fe80::491a:cce3:e531:3c42%7]) with mapi id 15.20.7633.036; Tue, 11 Jun 2024
 12:48:11 +0000
From: "Deucher, Alexander" <Alexander.Deucher@amd.com>
To: =?iso-8859-1?Q?Christian_K=F6nig?= <ckoenig.leichtzumerken@gmail.com>
CC: "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Subject: Re: [PATCH 2/2] drm/amdgpu: reject gang submit on reserved VMIDs
Thread-Topic: [PATCH 2/2] drm/amdgpu: reject gang submit on reserved VMIDs
Thread-Index: AQHau/Ss/xG99/7opEeujai1AF9OZLHCgzwd
Date: Tue, 11 Jun 2024 12:48:11 +0000
Message-ID: <BL1PR12MB51441A514B89AE04BE820E9AF7C72@BL1PR12MB5144.namprd12.prod.outlook.com>
References: <20240611114358.1774-1-christian.koenig@amd.com>
 <20240611114358.1774-3-christian.koenig@amd.com>
In-Reply-To: <20240611114358.1774-3-christian.koenig@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=True;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2024-06-11T12:48:09.701Z;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution
 Only; MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=0;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard; 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL1PR12MB5144:EE_|CYXPR12MB9385:EE_
x-ms-office365-filtering-correlation-id: 5c5aa690-1922-46af-d018-08dc8a14c078
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230031|376005|1800799015|366007|38070700009;
x-microsoft-antispam-message-info: =?iso-8859-1?Q?TR3NVO9dTs+pwlTlGwGB5ZE7LLG9y6XXQh+v15KHnD9bzGM5cUFuE8rXek?=
 =?iso-8859-1?Q?W8r30hzlwEgMi+ikWg+UYFfaKp3L/jfRf2M7Sp5rOFOyEYOdU1Tl3vNiWk?=
 =?iso-8859-1?Q?9rfJEzTOmWAYfX1gaQdj0dQqAkyDDA6J+llC/Gn0Y1EssROFTpGMOfBJ7n?=
 =?iso-8859-1?Q?TXHaLqgpVQKYQcEgfcXINbgzUc+MRJ/OsnIQi2ZjRLtqil36PaKa0rfSCp?=
 =?iso-8859-1?Q?zJ7I+y6cqOx3RqSF4zBvbVcH0HOISJiR9dyT8/hirG8QKVCSQexJy99hQF?=
 =?iso-8859-1?Q?yD+McdsZMTtn2zwYMdxyrhLlEYvXYsrNE9/+r35kTKxaoPq957rYQZy/Xq?=
 =?iso-8859-1?Q?cG5INDgURFqRp3JnCnu/mfZbEYT1tLtOJ1AdeyVWm91B789Y8ZTBky89TU?=
 =?iso-8859-1?Q?mp2c4P5gjxAK7JUCEtTMx1F/Mkh16pLGP0LN3Bmhu5Nsb0R0RRW3bjG7S9?=
 =?iso-8859-1?Q?YCb2iVRvhl+SQw16J7pJ9hE8kbxqWN8a2npf7x/ODTDoQMEiVzBA2QW6Lc?=
 =?iso-8859-1?Q?PLwzWw9J7TYYRh3BpZw49zoDTF5Bq6i5+3IRtVLOSFvYhAUK+X6jUCJl63?=
 =?iso-8859-1?Q?ec/7S/oRyaVdJVENr/UiWbeCl9/cjd5j6O5LDepU6Hr1HxlAkX9eaLTNnB?=
 =?iso-8859-1?Q?ULUPaFUUFGoSGlwPREXVurhrYcO/8+IlwF6apc4+UIRgJpQzu93MBTf8gw?=
 =?iso-8859-1?Q?MHFVbQrhoyhvNdlIEEruQdJBMo52MBTpThz9cpgN7K5NYkzdSCW/2GYMJ0?=
 =?iso-8859-1?Q?+nMryAcZiRaKM+ZfYBqx0g3lBsPWYBJQlg639e1CdtpRGdRhYEsN3BWmDr?=
 =?iso-8859-1?Q?c8/o+k8TlZ3p2gnjUU0cfZGlFLYgNRqXqI57LelkM70YZ+f4jPw+TsYItc?=
 =?iso-8859-1?Q?QjbrJQtnoiP1DweB0/v42SExtcoPhHyVQngR93mBRB37EiT+SnYNT5m8Zv?=
 =?iso-8859-1?Q?T7M8VG7FxKUdxHbBziI2pwthi4PAl2OsWbRF6+N3fdslzonoEy7XFisQnv?=
 =?iso-8859-1?Q?SfyKYF2ALQCZWT8lbti+6VHzUI+eaA5pI9n7Y0VtXU3IBEZMZDVjIPjhLh?=
 =?iso-8859-1?Q?7d41a2qv1X4OIYsdWjXwhl7dL5y+8ZXrlUzYSqM+kBu0lP8c2+4vsRx5Dk?=
 =?iso-8859-1?Q?CHj2Z6jTt6yDUf7LYA7Wq8ZlieUPTeD7LVLC/HxxDZffX3Asl1gD4AQHh+?=
 =?iso-8859-1?Q?/tG8JxPBlA1mivUL+IcCzVz4Tp1zpqwRyygZYonSfnFyB/T+9zRUemzy6n?=
 =?iso-8859-1?Q?wxyolRhxm6/J7SlQEsGvpKSo5KgUXJMNzi5TbhGhM4o+bmxacfsLqlPuQa?=
 =?iso-8859-1?Q?WkFS3beCrKjXvR1sBpJYPb1PVJXy8d74Qx2pxcgtpgKeMohjYtHiBeHEK1?=
 =?iso-8859-1?Q?4yxJNyoq/9ZjRGwjWJW2QVuwDyqQmeO/SO+PWcJIdI3tZ8SkxDP7g=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL1PR12MB5144.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(376005)(1800799015)(366007)(38070700009); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?dVL8OtskfBOYL7CKxgp9SyURUOn3/0XG3ixWixHHe+g3ZMr8Tlqe4+Gcoj?=
 =?iso-8859-1?Q?bxxfc2M9D5FdjPJfsTe7StRiI5Rc6eZiuaP5qlFidp6q+j4B/hADHeWah1?=
 =?iso-8859-1?Q?EknbHaOwJS6+rtWFgy+rkBad7Odybl90t88GuFJ25f4/RbZ+riYLqbK9/K?=
 =?iso-8859-1?Q?Fw8UrDnCGmfKV2ZNWqB9HBIU5YhlqoRvg4eoFBjCKlJiiZezlOFF13ogFJ?=
 =?iso-8859-1?Q?ckTRT6ENjbtK+7l9OpDwsp8c9518fQKvOgxHmDbHTCFRDC+IOi7mUSjyQ9?=
 =?iso-8859-1?Q?+uV3HtUHPckEOC7taixC5Vt2/55S/iQdVprECYl+ZN2c8nVfxo53AqJli3?=
 =?iso-8859-1?Q?aabmHOyAf4iqiXpz/m7NwHpnMgXC1IEAO+33Mt1vZ1CgMUwTqtA4xYItsa?=
 =?iso-8859-1?Q?QHbJg0oba2hUXjsTRRqo4A9Xu9oW3CziQABRg2Ym2SkmlaQua05rC8pnWS?=
 =?iso-8859-1?Q?vqEsKI/ss5IOYRMUDVWfbgpd7aLV1cC90nDb9J5NGmtXkpkB3bGcso6W/f?=
 =?iso-8859-1?Q?Xa3VlIHxVxGU5BM8Pv2hPzUUVnsid++JD8/cjdL8wiDg5VvAeZA/MhUShE?=
 =?iso-8859-1?Q?DpGyM1p1G40hj43niTZNjAlEIGLdEma8MW5zW2lEsKAwf8qOyuVk4Kid8B?=
 =?iso-8859-1?Q?3ugJXXyHgsnDRxUEuzjlAZBLkhAh9acg6Obb9HAeTnebZsmh6P6ip+va2S?=
 =?iso-8859-1?Q?lxTem84YZukHvbc9+RuqENHYtgdWiQ0zuFQ/ysh+SC5WoXBtJTYrD3b9tt?=
 =?iso-8859-1?Q?rWfN9fhyPOWQsuJhSvajyPNfGXuGfkQaIvqO/n4B4N68oxY/PKNgnS9Kvn?=
 =?iso-8859-1?Q?NqMDLbf306mreXVtXlwXS79D5MkwYRp3etXnJglvB46lVjZalG4IUR7ShE?=
 =?iso-8859-1?Q?DK9uuECHoNIuWvvVTfplUZQA2ks5HaG+1ek6v8Sv43unb4zXG0Si9IsWkL?=
 =?iso-8859-1?Q?bMgB5AkV7lgWdxRBILUjpxpgi3crHMW9PPJmdw2Q/nt6vOz6BEfih6uZdG?=
 =?iso-8859-1?Q?1n81TDjy21qZ+hjuPl87c9rPjXSwkPE0y5fybUQpPyXM4Kk26CXcEcy8T+?=
 =?iso-8859-1?Q?30CMjAiYIUxh62XS8mAmPFMnO2kjoSGYjd8HY5Tuk9rShb3zfYzrUAAB9U?=
 =?iso-8859-1?Q?c8QmEXaJX5MiB2jp80yk0w/WbKm6B9mLqV2eH65Hpl+qFTWWHnvrMA+7DA?=
 =?iso-8859-1?Q?mLMlg7jwnMpnDOTQAVQgHsQIKilmkJL5r8oPhOIbcblaGbFUQ9SheunPkj?=
 =?iso-8859-1?Q?9WLGJpyq0jp61DL8rRqHXpYy4En8EqToH9zcWLnCPvYkxkbg6xlz/ri3cf?=
 =?iso-8859-1?Q?PrDv3+IFlCy2PttZEfOfhEeifCJxwB7J4QqIoxQOR7AdtUghi4TjY8lajG?=
 =?iso-8859-1?Q?CFtmdc/X8G1lu/OCPRxChN89YPukASX5aZSb7Tt2vDVTV4AwXBznL9ilfh?=
 =?iso-8859-1?Q?XfC5FGceSV6hJkW0aiVdRHz8oGv8bjAT6KltYQ0tAVk05Hbf1kpjDPi45O?=
 =?iso-8859-1?Q?iDGTEOsMWxX+PjQyp4nyMdtrTIrVgI26jkcMmICcjaCa/4DuU8daLhv1RE?=
 =?iso-8859-1?Q?O7ROivZlIgf/t0iw2PVGXXM5E2jNIfLRjsnTzPuWU1m+JSjPg34Y++t5Wd?=
 =?iso-8859-1?Q?NI2nekTmUBj0c=3D?=
Content-Type: multipart/alternative;
 boundary="_000_BL1PR12MB51441A514B89AE04BE820E9AF7C72BL1PR12MB5144namp_"
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5144.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5c5aa690-1922-46af-d018-08dc8a14c078
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Jun 2024 12:48:11.2584 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: h3+6pbXgzOPVAsdGIsCv2xkS1RIvknO2Jg9yxEJbQ0ScB+WkIcmjW+5Tg+QKU4t3UD+DziIccZahWlQIBK0xKA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYXPR12MB9385
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

--_000_BL1PR12MB51441A514B89AE04BE820E9AF7C72BL1PR12MB5144namp_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

[AMD Official Use Only - AMD Internal Distribution Only]

Series is:
Reviewed-by: Alex Deucher <alexander.deucher@amd.com>
________________________________
From: Christian K=F6nig <ckoenig.leichtzumerken@gmail.com>
Sent: Tuesday, June 11, 2024 7:43 AM
To: Deucher, Alexander <Alexander.Deucher@amd.com>
Cc: amd-gfx@lists.freedesktop.org <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 2/2] drm/amdgpu: reject gang submit on reserved VMIDs

A gang submit won't work if the VMID is reserved and we can't flush out
VM changes from multiple engines at the same time.

Signed-off-by: Christian K=F6nig <christian.koenig@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c  | 15 +++++++++++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_ids.c | 15 ++++++++++++++-
 drivers/gpu/drm/amd/amdgpu/amdgpu_ids.h |  1 +
 3 files changed, 30 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c b/drivers/gpu/drm/amd/a=
mdgpu/amdgpu_cs.c
index ec888fc6ead8..916b6b8cf7d9 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
@@ -1093,6 +1093,21 @@ static int amdgpu_cs_vm_handling(struct amdgpu_cs_pa=
rser *p)
         unsigned int i;
         int r;

+       /*
+        * We can't use gang submit on with reserved VMIDs when the VM chan=
ges
+        * can't be invalidated by more than one engine at the same time.
+        */
+       if (p->gang_size > 1 && !p->adev->vm_manager.concurrent_flush) {
+               for (i =3D 0; i < p->gang_size; ++i) {
+                       struct drm_sched_entity *entity =3D p->entities[i];
+                       struct drm_gpu_scheduler *sched =3D entity->rq->sch=
ed;
+                       struct amdgpu_ring *ring =3D to_amdgpu_ring(sched);
+
+                       if (amdgpu_vmid_uses_reserved(vm, ring->vm_hub))
+                               return -EINVAL;
+               }
+       }
+
         r =3D amdgpu_vm_clear_freed(adev, vm, NULL);
         if (r)
                 return r;
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ids.c b/drivers/gpu/drm/amd/=
amdgpu/amdgpu_ids.c
index b5b9d4f40f53..b6a8bddada4c 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ids.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ids.c
@@ -424,7 +424,7 @@ int amdgpu_vmid_grab(struct amdgpu_vm *vm, struct amdgp=
u_ring *ring,
         if (r || !idle)
                 goto error;

-       if (vm->reserved_vmid[vmhub] || (enforce_isolation && (vmhub =3D=3D=
 AMDGPU_GFXHUB(0)))) {
+       if (amdgpu_vmid_uses_reserved(vm, vmhub)) {
                 r =3D amdgpu_vmid_grab_reserved(vm, ring, job, &id, fence)=
;
                 if (r || !id)
                         goto error;
@@ -474,6 +474,19 @@ int amdgpu_vmid_grab(struct amdgpu_vm *vm, struct amdg=
pu_ring *ring,
         return r;
 }

+/*
+ * amdgpu_vmid_uses_reserved - check if a VM will use a reserved VMID
+ * @vm: the VM to check
+ * @vmhub: the VMHUB which will be used
+ *
+ * Returns: True if the VM will use a reserved VMID.
+ */
+bool amdgpu_vmid_uses_reserved(struct amdgpu_vm *vm, unsigned int vmhub)
+{
+       return vm->reserved_vmid[vmhub] ||
+               (enforce_isolation && (vmhub =3D=3D AMDGPU_GFXHUB(0)));
+}
+
 int amdgpu_vmid_alloc_reserved(struct amdgpu_device *adev,
                                unsigned vmhub)
 {
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ids.h b/drivers/gpu/drm/amd/=
amdgpu/amdgpu_ids.h
index fa8c42c83d5d..240fa6751260 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ids.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ids.h
@@ -78,6 +78,7 @@ void amdgpu_pasid_free_delayed(struct dma_resv *resv,

 bool amdgpu_vmid_had_gpu_reset(struct amdgpu_device *adev,
                                struct amdgpu_vmid *id);
+bool amdgpu_vmid_uses_reserved(struct amdgpu_vm *vm, unsigned int vmhub);
 int amdgpu_vmid_alloc_reserved(struct amdgpu_device *adev,
                                 unsigned vmhub);
 void amdgpu_vmid_free_reserved(struct amdgpu_device *adev,
--
2.34.1


--_000_BL1PR12MB51441A514B89AE04BE820E9AF7C72BL1PR12MB5144namp_
Content-Type: text/html; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

<html>
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Diso-8859-=
1">
<style type=3D"text/css" style=3D"display:none;"> P {margin-top:0;margin-bo=
ttom:0;} </style>
</head>
<body dir=3D"ltr">
<p style=3D"font-family:Calibri;font-size:10pt;color:#0000FF;margin:5pt;fon=
t-style:normal;font-weight:normal;text-decoration:none;" align=3D"Left">
[AMD Official Use Only - AMD Internal Distribution Only]<br>
</p>
<br>
<div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
Series is:</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
Reviewed-by: Alex Deucher &lt;alexander.deucher@amd.com&gt;</div>
<div id=3D"appendonsend"></div>
<hr style=3D"display:inline-block;width:98%" tabindex=3D"-1">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" st=
yle=3D"font-size:11pt" color=3D"#000000"><b>From:</b> Christian K=F6nig &lt=
;ckoenig.leichtzumerken@gmail.com&gt;<br>
<b>Sent:</b> Tuesday, June 11, 2024 7:43 AM<br>
<b>To:</b> Deucher, Alexander &lt;Alexander.Deucher@amd.com&gt;<br>
<b>Cc:</b> amd-gfx@lists.freedesktop.org &lt;amd-gfx@lists.freedesktop.org&=
gt;<br>
<b>Subject:</b> [PATCH 2/2] drm/amdgpu: reject gang submit on reserved VMID=
s</font>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt;=
">
<div class=3D"PlainText">A gang submit won't work if the VMID is reserved a=
nd we can't flush out<br>
VM changes from multiple engines at the same time.<br>
<br>
Signed-off-by: Christian K=F6nig &lt;christian.koenig@amd.com&gt;<br>
---<br>
&nbsp;drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c&nbsp; | 15 +++++++++++++++<br>
&nbsp;drivers/gpu/drm/amd/amdgpu/amdgpu_ids.c | 15 ++++++++++++++-<br>
&nbsp;drivers/gpu/drm/amd/amdgpu/amdgpu_ids.h |&nbsp; 1 +<br>
&nbsp;3 files changed, 30 insertions(+), 1 deletion(-)<br>
<br>
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c b/drivers/gpu/drm/amd/a=
mdgpu/amdgpu_cs.c<br>
index ec888fc6ead8..916b6b8cf7d9 100644<br>
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c<br>
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c<br>
@@ -1093,6 +1093,21 @@ static int amdgpu_cs_vm_handling(struct amdgpu_cs_pa=
rser *p)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; unsigned int i;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int r;<br>
&nbsp;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /*<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * We can't use gang submit on w=
ith reserved VMIDs when the VM changes<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * can't be invalidated by more =
than one engine at the same time.<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; */<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (p-&gt;gang_size &gt; 1 &amp;&amp;=
 !p-&gt;adev-&gt;vm_manager.concurrent_flush) {<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; for (i =3D 0; i &lt; p-&gt;gang_size; ++i) {<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct drm_sched=
_entity *entity =3D p-&gt;entities[i];<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct drm_gpu_s=
cheduler *sched =3D entity-&gt;rq-&gt;sched;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_ri=
ng *ring =3D to_amdgpu_ring(sched);<br>
+<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (amdgpu_vmid_=
uses_reserved(vm, ring-&gt;vm_hub))<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return -EINVAL;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; }<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
+<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; r =3D amdgpu_vm_clear_free=
d(adev, vm, NULL);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (r)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; return r;<br>
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ids.c b/drivers/gpu/drm/amd/=
amdgpu/amdgpu_ids.c<br>
index b5b9d4f40f53..b6a8bddada4c 100644<br>
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ids.c<br>
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ids.c<br>
@@ -424,7 +424,7 @@ int amdgpu_vmid_grab(struct amdgpu_vm *vm, struct amdgp=
u_ring *ring,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (r || !idle)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; goto error;<br>
&nbsp;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (vm-&gt;reserved_vmid[vmhub] || (e=
nforce_isolation &amp;&amp; (vmhub =3D=3D AMDGPU_GFXHUB(0)))) {<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (amdgpu_vmid_uses_reserved(vm, vmh=
ub)) {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; r =3D amdgpu_vmid_grab_reserved(vm, ring, job, &amp;i=
d, fence);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; if (r || !id)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; goto =
error;<br>
@@ -474,6 +474,19 @@ int amdgpu_vmid_grab(struct amdgpu_vm *vm, struct amdg=
pu_ring *ring,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return r;<br>
&nbsp;}<br>
&nbsp;<br>
+/*<br>
+ * amdgpu_vmid_uses_reserved - check if a VM will use a reserved VMID<br>
+ * @vm: the VM to check<br>
+ * @vmhub: the VMHUB which will be used<br>
+ *<br>
+ * Returns: True if the VM will use a reserved VMID.<br>
+ */<br>
+bool amdgpu_vmid_uses_reserved(struct amdgpu_vm *vm, unsigned int vmhub)<b=
r>
+{<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return vm-&gt;reserved_vmid[vmhub] ||=
<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; (enforce_isolation &amp;&amp; (vmhub =3D=3D AMDGPU_GFXHUB(0)));<=
br>
+}<br>
+<br>
&nbsp;int amdgpu_vmid_alloc_reserved(struct amdgpu_device *adev,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; unsigned vmhub)<br>
&nbsp;{<br>
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ids.h b/drivers/gpu/drm/amd/=
amdgpu/amdgpu_ids.h<br>
index fa8c42c83d5d..240fa6751260 100644<br>
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ids.h<br>
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ids.h<br>
@@ -78,6 +78,7 @@ void amdgpu_pasid_free_delayed(struct dma_resv *resv,<br>
&nbsp;<br>
&nbsp;bool amdgpu_vmid_had_gpu_reset(struct amdgpu_device *adev,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_vmid *id);<br>
+bool amdgpu_vmid_uses_reserved(struct amdgpu_vm *vm, unsigned int vmhub);<=
br>
&nbsp;int amdgpu_vmid_alloc_reserved(struct amdgpu_device *adev,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; unsigned vmhub);<br>
&nbsp;void amdgpu_vmid_free_reserved(struct amdgpu_device *adev,<br>
-- <br>
2.34.1<br>
<br>
</div>
</span></font></div>
</div>
</body>
</html>

--_000_BL1PR12MB51441A514B89AE04BE820E9AF7C72BL1PR12MB5144namp_--
