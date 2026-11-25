Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71CAE606A31E
	for <amd-gfx@archiver.kernel.org>; Wed, 25 Nov 2026 10:45:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=M6a8eCme
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 10ADC10FB18;
	Wed, 25 Nov 2026 10:45:20 +0000 (UTC)
Received: from PH7PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11010020.outbound.protection.outlook.com [52.101.201.20])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7118810FB18
 for <amd-gfx@lists.freedesktop.org>; Wed, 25 Nov 2026 10:45:14 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SatdXabAgnw6n6rm13qGBHrbpW8LXwnUNs/GgBqYKcF1VQiq7CBnf3KxxAoGpzAApqByaA/ywusXt9qWAhl8TfxCZUNPVmt/BH7/9E91cd5H3ll1NurtWTN8CNJ+4Irayi1vJ2f1oP/z7lZuCiwzae8qtWMmt7sh5p7IJFReGZBFh9cuiRRMcBFNdEBiZrRrGF+CVu4oWBgyrNdsvNqAaVjveqaqS3VkxFFSfqrKopFACfmES8DOWGRFPQADUrZn5IbcvqA9NgoBU50+iz0YwAgDbF6s1KGfQK50MJFrN8EEbFM2u2KRJZ9brUAo9WoA1BjTKeH+zuNRaiY8uNbymg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aQhVcEwsjKMUr9anyHqzFucnRszTi1RarOKBOv8aG84=;
 b=J/I4EGFOAUNUBC7p8tmyXXs6G5ATP+UTcE6Wf6Xxm71ZgKKmpVqwgeAOJMvRe9YpbKgKc4tVQQO+69SYMsAFnou5WrAUnBs3NCLcpNtRBSI9P32X3UfVwQXiAmOVVMfsdSYIFt/rR3J0W8fp4QI9c1lnxzQazgSKaIzBLNZDseWVkJn6m2muRoC0M0V7hxS3+retTJZXXneU01djCk+eF6BoCqobzEvJOWBiPka+NZD5L4dyVzJIqLxSRKwFEF7xUXtEY/1t11vv7f1YetdHpVZeXMNNqIhHOn93bOu0ctnPtpRh0DBf/9bGnfoHU5icjHLUnRZqNzfZiZSENTpp4g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aQhVcEwsjKMUr9anyHqzFucnRszTi1RarOKBOv8aG84=;
 b=M6a8eCmec9vSf6utXUduPG8rOIE+gFomR5iVFfCC8WbrzQbpS7bXPuoB1xifTyIQ6+dFJuvuvFLPZjYA/es2Vyebg6KQ4yQnjl5bv4bdciMxmT/fnZxJOTCg7f9PNPzVuBEIHCCjeGgMBPUJE1wU1VOInkYBwr/Bag1d9ArXwsc=
Received: from DS7PR12MB5768.namprd12.prod.outlook.com (2603:10b6:8:77::18) by
 SN7PR12MB8791.namprd12.prod.outlook.com (2603:10b6:806:32a::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.662.6; Wed, 25 Nov
 2026 10:45:11 +0000
Received: from DS7PR12MB5768.namprd12.prod.outlook.com
 ([fe80::5d2c:ba94:5102:679b]) by DS7PR12MB5768.namprd12.prod.outlook.com
 ([fe80::5d2c:ba94:5102:679b%4]) with mapi id 15.21.0639.010; Wed, 25 Nov 2026
 10:45:11 +0000
From: "Li, Chong(Alan)" <Chong.Li@amd.com>
To: "Koenig, Christian" <Christian.Koenig@amd.com>, "timur.kristof@gmail.com"
 <timur.kristof@gmail.com>
CC: "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amdgpu: track finished page table updates with a
 fence chain
Thread-Topic: [PATCH] drm/amdgpu: track finished page table updates with a
 fence chain
Thread-Index: AQHde867+eOh4FISHE2VueIV8lDtRbc+js9Q
Date: Wed, 25 Nov 2026 10:45:11 +0000
Message-ID: <DS7PR12MB5768B725FF09752C9BD1E1F59B432@DS7PR12MB5768.namprd12.prod.outlook.com>
References: <20261124044544.3561866-1-chongli2@amd.com>
In-Reply-To: <20261124044544.3561866-1-chongli2@amd.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Enabled=True;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SetDate=2026-11-25T09:56:16.0000000Z;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Name=AMD General
 v26; MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_ContentBits=3;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Method=Standard
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS7PR12MB5768:EE_|SN7PR12MB8791:EE_
x-ms-office365-filtering-correlation-id: f165ecfd-f4cf-4505-4e27-08df4ae12e2d
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|376014|366016|23010399003|6133799003|261009223027099003|261009221227099003|18002099003|22082099003|3023799007|10067099003|5023799004|11063799006|56012099006|261102123227099003|261028144727099003|261026121527099003|261026140227099003|261021123027099003|261022075727099003|261022105027099003|261021121427099003|38070700021;
x-microsoft-antispam-message-info: Lz6r0eyggGwoAhW8YUaZGKzqrawVA/mobvTIAZ68tLpJzPJlQd45c6mdL/xuN72m3XCoVfYd1+ThIJE5BPv9ywWT2UKVbnGyMuPinlJzTxFMLee8Ka5OEsqJibgHH4gCdcdpSLXYdM22XcGaq2eWQg3d0aZGD6xOnVSE1eB8639oA+8XK7fgBhcneF6QcgB0P00SW5czATnqRoUfJpdglIZDbgotDLSyc8w8uXcqBPe1JJIdEd0QrlXzpDqaOQ/c7p8JQX0HyXdrbSTAz1GDeeenhkP/2hp6FGF7s2kK+D2bfyGfZM2IxYZjdBuCEIHTrrU9ebfwh2E0jqAFayW5b9NdVanFSGMQxrn5Jk8oGA5CzG+YQxljJ86G9SnZJVz13n7wZrh95XMUSX2LrobkxYfrZnpzK3Mxi3WpMT7aXADQnHa9YWR3ApO239XzHC1g1viITCrOK/F0E+5KnEDq1fi9cKY03lvNGKbuiwnDFkU3k/cwvtx+V5IiJDw/Caj5Pi6nrkb0NPD5Se+MEHUBYm5JHCQW8pv1pKHmqfi7CHDyN5RGaHeRzOKFjBv/HRsmLmBY7aY/yVOcj6uTfTMvESv2TV33P0xeYiTG/CV1YXVpZcFiJS61HUwuDyCO2XrZiMi9WdwFd4ukt3lG92sbSa73oetS1A3Hd9cvQ5BMCl8rqlwAEUO4DdzWsSvZUKXJOdn25w6U0bcqokPNfYOuDobEfwRUdkblMIhK4+eHT1s=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS7PR12MB5768.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(23010399003)(6133799003)(261009223027099003)(261009221227099003)(18002099003)(22082099003)(3023799007)(10067099003)(5023799004)(11063799006)(56012099006)(261102123227099003)(261028144727099003)(261026121527099003)(261026140227099003)(261021123027099003)(261022075727099003)(261022105027099003)(261021121427099003)(38070700021);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?/GOQ+aZPLLKJ9V11qn3WUDVmRD87QnsvyiEDA7K1XXdes8SdR72vIzpgEiv8?=
 =?us-ascii?Q?CxWh5YgiL2hMqlyTiPi4RkIxSz1P6sDD/QRH87Zuhf4/dk8E8D1bGvAuh86i?=
 =?us-ascii?Q?kVN7zxZeHikXY1gh9Xz2dEJfSBJWgyTnQ/Cwc8XEWZzSFGKvpI+eMNGiJMTF?=
 =?us-ascii?Q?04c4eejMXlR3h0weRFJuHFMl/4t+u2yRhzgfrb5mR01R7nKA/Bop5zy2Vq/I?=
 =?us-ascii?Q?9ZkiiqxppMg0t8d5a7mFwoTOMXCM85977hfu3FbtaRpyvcUAnX4JYmKg9kjN?=
 =?us-ascii?Q?DJ1wySUgiIrJUr6mJy+cBTGpGhdbyVH1pFr9f1OtQL18B68pedl+2byGf3AT?=
 =?us-ascii?Q?UwZCemzBGaYTYfsHfGBEXhJHI+rGJ/EIBd3kFnIDkiSuC2G46xHOHmbtkmid?=
 =?us-ascii?Q?8WrIMLL23fXOC34KYk67VdfAJ+1oi4+CFUR5o6gOCMxQUKIyK07rM0AaQuAP?=
 =?us-ascii?Q?83n2Etiv6eoJ2GflsyAjRfz1T4FG6CiPMGJ94c9bo+h/WvzV/INzsVj8oqkY?=
 =?us-ascii?Q?KjdlRmVwxT5iTw8jB1JsoH+r/O9SG1vxIBQNCK5n5vXP1id2JYA0G8uU1LgO?=
 =?us-ascii?Q?kNyh98uMq63/BFOV9wQJG+PQiFsFU8lGfqFRCN7pk4Mf7lrJ/iFNpF4wpMt4?=
 =?us-ascii?Q?6zAzsNPyGCqcdVVqywa1lIuUBiOcXARBQ0/3cjpqueSzerJpwdpLU/q+OrQD?=
 =?us-ascii?Q?lwZz0Jyj3aLLj1BPHPfd2fNERssuCU+7EdcBYdmecijyHYe2X1Sl+q0aPrNL?=
 =?us-ascii?Q?NGxRpZF13YPY38uZvlrqCZTRMKtzBWXhREqVJokez8Ne/i/9r+BxPHuEz3tT?=
 =?us-ascii?Q?g1/jKzNbUuWnrCM5CiXRDlsKjeq11MAU+LdHPJKjk8VGaCmZPvoO46pDlOTp?=
 =?us-ascii?Q?StuqtmP1Ed/4TIh9SUFJAXErHd1eCEIe6a8DBK1co/e+8R2Nmqg6oymJ20Ec?=
 =?us-ascii?Q?qcK2B5OgvvWj72rUtYFFHvPUYHHJAk9QdpAK4bNBGor6oPI/mBZlSl080GR5?=
 =?us-ascii?Q?Qz83O7R/zlqzs2CzL/rutzuiyGhGK0auH59N3gLvy7TiIwW4mgjohN0OHie+?=
 =?us-ascii?Q?fni4Y/Q/VGdPR/kG2MJIuGYO0c01/OfbZ8uqc3rN5UDI8WNFTsKba1gvLawj?=
 =?us-ascii?Q?wVWfpCAGP5vrJfBOXvjmapSUSOS4SgfzSDkeTpFQfV9DxwkP3UYxwgh8kOWj?=
 =?us-ascii?Q?Y7SgYoJz5AnMIEf4U8FBcfhs4L96gemU0y337pzwDLaae00mPSYaqehxfoq0?=
 =?us-ascii?Q?1OYXmfaR+PIMqV8/RkP9xzQI3nQ7gk27B/w7qFdq913O5B8PoHlutCHrOgxI?=
 =?us-ascii?Q?w4o6nlYW7fdfBppAYGdwKjpWZSL5tCq7rnAd0sbNGAbJAkYF+xVUT+aSKVrX?=
 =?us-ascii?Q?h2tPaU6n7tRqKjChAZh02bLwPEQ12whWoZ+lr/tjl+Fos5NdvosrTVPZmPU/?=
 =?us-ascii?Q?Dito/Fu7UZvWRFwTCrO1tRv3QvY/uz5NWv0/4Ji8ZlbLNud8lq8aNvB7wXzO?=
 =?us-ascii?Q?gLISp2x6kN50iaFDnRrWujrd1B2oNEpI1/l38a2TEfpjapKOQcr0EWKghlD8?=
 =?us-ascii?Q?prZVYRHYkwYI5hMguGuyWwP/WMR7+THoGW5hClXQmr22waH+SBb5uQr2kETq?=
 =?us-ascii?Q?VAu46+7MQmmqHqHhCYglm0cPQN0097ZuOrDvGheWL0IUGigUnAC8mHzSCsrU?=
 =?us-ascii?Q?TYyuQi1qnLOnP9ujo2pd+bK9uBgvpcX0Ibci8JNVQDJ5fqz1?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB5768.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f165ecfd-f4cf-4505-4e27-08df4ae12e2d
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Nov 2026 10:45:11.2402 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: oFljDdccMiRcr08M8vfv4kY44BwTJLph8tI2KVj+WDg31V/ByzMPyAfVjsa9SrHQTn52Bat7wNRFUCRVG4B2Ug==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB8791
X-BeenThere: amd-gfx@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Discussion list for AMD gfx <amd-gfx.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/amd-gfx>
List-Post: <mailto:amd-gfx@lists.freedesktop.org>
List-Help: <mailto:amd-gfx-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/amd-gfx>,
 <mailto:amd-gfx-request@lists.freedesktop.org?subject=subscribe>
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

AMD General

> Yeah that doesn't work either. There is no guarantee that the sequence
> numbers in the chain are contigious because of garbage collection.

My patch does not need the numbers of the remaining nodes to be
contiguous. It only uses the seqno of the head. For the nodes in the
chain it only checks whether their fence has signaled:

    seq +=3D head->seqno;
    dma_fence_chain_for_each(iter, head) {
        if (!dma_fence_is_signaled(dma_fence_chain_contained(iter)))
            --seq;
    }

- The nodes are numbered 1, 2, 3, ... when they are added, so
  head->seqno is the number of updates added so far.
- Garbage collection only removes nodes whose fence has signaled, so
  every unsignaled node is still in the chain.
- head->seqno minus the number of unsignaled nodes is therefore the
  number of finished updates, no matter which nodes were collected or
  in which order they finished.


> I will fix the code to break on the first signaled one and send that
> patch out again.

If I understand this correctly, the loop starts from the head and
breaks at the head when the head has signaled, so the older nodes are
not checked. When an older node signals later, amdgpu_vm_tlb_seq()
still returns the seqno of the head, so a job which waits for the older
node can skip the flush.

The count in my patch changes whenever a node signals, also in this case.
Could you take another look at my patch?
If you prefer to do the fix yourself, I can help review the new version.


-----Original Message-----
From: Li, Chong(Alan) <Chong.Li@amd.com>
Sent: Tuesday, November 24, 2026 12:46 PM
To: Koenig, Christian <Christian.Koenig@amd.com>; timur.kristof@gmail.com
Cc: amd-gfx@lists.freedesktop.org; Li, Chong(Alan) <Chong.Li@amd.com>
Subject: [PATCH] drm/amdgpu: track finished page table updates with a fence=
 chain

amdgpu_vm_tlb_seq() waits for the tlb_seq callback of a page table update b=
y taking the lock of vm->last_seq_flush. But every fence has its own lock, =
and a newer update replaces vm->last_seq_flush without waiting for the call=
backs of older updates. A job scheduled after an older fence has signaled, =
but before its callback has finished, takes the lock of the newer fence, mi=
sses the tlb_seq increment and can reuse a VMID without flushing the TLB af=
ter the page table update it waited for.

how to fix:
Stop incrementing tlb_seq from a fence callback. Put the fences of the upda=
tes which need a TLB flush into a dma_fence_chain and let
amdgpu_vm_tlb_seq() add the number of updates which have signaled. A depend=
ent job then sees the sequence change together with the signaled bit of the=
 fence it waited for. The chain nodes are numbered consecutively. The numbe=
r of the newest node minus the number of unsignaled nodes therefore also co=
unts the signaled nodes which were already pruned, in any completion order.=
 Nothing references the VM from a fence callback any more, so amdgpu_vm_fin=
i() no longer needs to wait for vm->last_seq_flush.

Signed-off-by: chong li <chongli2@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c | 77 +++++++-------------------  dr=
ivers/gpu/drm/amd/amdgpu/amdgpu_vm.h | 31 ++++++-----
 2 files changed, 38 insertions(+), 70 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c b/drivers/gpu/drm/amd/a=
mdgpu/amdgpu_vm.c
index a627a3092990..dafcebd95555 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
@@ -114,21 +114,6 @@ struct amdgpu_prt_cb {
        struct dma_fence_cb cb;
 };

-/**
- * struct amdgpu_vm_tlb_seq_struct - Helper to increment the TLB flush seq=
uence
- */
-struct amdgpu_vm_tlb_seq_struct {
-       /**
-        * @vm: pointer to the amdgpu_vm structure to set the fence sequenc=
e on
-        */
-       struct amdgpu_vm *vm;
-
-       /**
-        * @cb: callback
-        */
-       struct dma_fence_cb cb;
-};
-
 /**
  * amdgpu_vm_assert_locked - check if VM is correctly locked
  * @vm: the VM which schould be tested
@@ -1089,47 +1074,33 @@ int amdgpu_vm_update_pdes(struct amdgpu_device *ade=
v,
        return r;
 }

-/**
- * amdgpu_vm_tlb_seq_cb - make sure to increment tlb sequence
- * @fence: unused
- * @cb: the callback structure
- *
- * Increments the tlb sequence to make sure that future CS execute a VM fl=
ush.
- */
-static void amdgpu_vm_tlb_seq_cb(struct dma_fence *fence,
-                                struct dma_fence_cb *cb)
-{
-       struct amdgpu_vm_tlb_seq_struct *tlb_cb;
-
-       tlb_cb =3D container_of(cb, typeof(*tlb_cb), cb);
-       atomic64_inc(&tlb_cb->vm->tlb_seq);
-       kfree(tlb_cb);
-}
-
 /**
  * amdgpu_vm_tlb_flush - prepare TLB flush
  *
  * @params: parameters for update
  * @fence: input fence to sync TLB flush with
- * @tlb_cb: the callback structure
+ * @chain: preallocated chain node to track the update with
  *
  * Increments the tlb sequence to make sure that future CS execute a VM fl=
ush.
  */
 static void
 amdgpu_vm_tlb_flush(struct amdgpu_vm_update_params *params,
                    struct dma_fence *fence,
-                   struct amdgpu_vm_tlb_seq_struct *tlb_cb)
+                   struct dma_fence_chain *chain)
 {
        struct amdgpu_vm *vm =3D params->vm;
+       struct dma_fence *prev, *iter;

-       tlb_cb->vm =3D vm;
-       if (fence && !dma_fence_add_callback(fence, &tlb_cb->cb,
-                                            amdgpu_vm_tlb_seq_cb)) {
-               dma_fence_put(vm->last_seq_flush);
-               vm->last_seq_flush =3D dma_fence_get(fence);
-       } else {
-               amdgpu_vm_tlb_seq_cb(NULL, &tlb_cb->cb);
-       }
+       /* The reference of vm->last_seq_flush to prev moves into the chain=
 */
+       prev =3D rcu_dereference_protected(vm->last_seq_flush,
+                                        lockdep_is_held(&vm->eviction_lock=
));
+       dma_fence_chain_init(chain, prev,
+                            fence ? dma_fence_get(fence) : dma_fence_get_s=
tub(),
+                            prev ? prev->seqno + 1 : 1);
+       rcu_assign_pointer(vm->last_seq_flush, &chain->base);
+
+       /* Prune signaled nodes, not every VM reads the sequence */
+       dma_fence_chain_for_each(iter, &chain->base);

        /* Prepare a TLB flush fence to be attached to PTs */
        /* The check for need_tlb_fence should be dropped once we @@ -1177,=
7 +1148,7 @@ int amdgpu_vm_update_range(struct amdgpu_device *adev, struct =
amdgpu_vm *vm,
                           struct ttm_resource *res, dma_addr_t *pages_addr=
,
                           struct dma_fence **fence)
 {
-       struct amdgpu_vm_tlb_seq_struct *tlb_cb;
+       struct dma_fence_chain *chain;
        struct amdgpu_vm_update_params params;
        struct amdgpu_res_cursor cursor;
        int r, idx;
@@ -1185,8 +1156,8 @@ int amdgpu_vm_update_range(struct amdgpu_device *adev=
, struct amdgpu_vm *vm,
        if (!drm_dev_enter(adev_to_drm(adev), &idx))
                return -ENODEV;

-       tlb_cb =3D kmalloc_obj(*tlb_cb);
-       if (!tlb_cb) {
+       chain =3D dma_fence_chain_alloc();
+       if (!chain) {
                drm_dev_exit(idx);
                return -ENOMEM;
        }
@@ -1291,14 +1262,14 @@ int amdgpu_vm_update_range(struct amdgpu_device *ad=
ev, struct amdgpu_vm *vm,
                goto error_free;

        if (params.needs_flush) {
-               amdgpu_vm_tlb_flush(&params, *fence, tlb_cb);
-               tlb_cb =3D NULL;
+               amdgpu_vm_tlb_flush(&params, *fence, chain);
+               chain =3D NULL;
        }

        amdgpu_vm_pt_free_list(adev, &params);

 error_free:
-       kfree(tlb_cb);
+       dma_fence_chain_free(chain);
        amdgpu_vm_end_critical(&params);
        drm_dev_exit(idx);
        return r;
@@ -2685,7 +2656,7 @@ int amdgpu_vm_init(struct amdgpu_device *adev, struct=
 amdgpu_vm *vm,

        vm->last_update =3D dma_fence_get_stub();
        vm->last_unlocked =3D dma_fence_get_stub();
-       vm->last_seq_flush =3D dma_fence_get_stub();
+       RCU_INIT_POINTER(vm->last_seq_flush, NULL);
        vm->last_tlb_inv =3D dma_fence_get_stub();
        vm->generation =3D amdgpu_vm_generation(adev, NULL);

@@ -2730,7 +2701,6 @@ int amdgpu_vm_init(struct amdgpu_device *adev, struct=
 amdgpu_vm *vm,

 error_free_delayed:
        dma_fence_put(vm->last_update);
-       dma_fence_put(vm->last_seq_flush);
        dma_fence_put(vm->last_tlb_inv);
        dma_fence_put(vm->last_unlocked);
        ttm_lru_bulk_move_fini(&adev->mman.bdev, &vm->lru_bulk_move); @@ -2=
863,7 +2833,6 @@ void amdgpu_vm_fini(struct amdgpu_device *adev, struct amd=
gpu_vm *vm)
        struct amdgpu_bo_va_mapping *mapping, *tmp;
        bool prt_fini_needed =3D !!adev->gmc.gmc_funcs->set_prt;
        struct amdgpu_bo *root;
-       unsigned long flags;
        int i;

        amdgpu_amdkfd_gpuvm_destroy_cb(adev, vm); @@ -2876,11 +2845,7 @@ vo=
id amdgpu_vm_fini(struct amdgpu_device *adev, struct amdgpu_vm *vm)
                                      false, MAX_SCHEDULE_TIMEOUT);
        dma_fence_wait(vm->last_unlocked, false);
        dma_fence_put(vm->last_unlocked);
-       dma_fence_wait(vm->last_seq_flush, false);
-       /* Make sure that all fence callbacks have completed */
-       dma_fence_lock_irqsave(vm->last_seq_flush, flags);
-       dma_fence_unlock_irqrestore(vm->last_seq_flush, flags);
-       dma_fence_put(vm->last_seq_flush);
+       dma_fence_put(rcu_dereference_protected(vm->last_seq_flush, true));
        dma_fence_put(vm->last_tlb_inv);

        list_for_each_entry_safe(mapping, tmp, &vm->freed, list) { diff --g=
it a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h b/drivers/gpu/drm/amd/amdgpu/am=
dgpu_vm.h
index f6285a9d9e98..6142a86a8b80 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
@@ -24,6 +24,7 @@
 #ifndef __AMDGPU_VM_H__
 #define __AMDGPU_VM_H__

+#include <linux/dma-fence-chain.h>
 #include <linux/idr.h>
 #include <linux/kfifo.h>
 #include <linux/rbtree.h>
@@ -330,7 +331,7 @@ struct amdgpu_vm {

        /* Last TLB seq/fence */
        atomic64_t              tlb_seq;
-       struct dma_fence        *last_seq_flush;
+       struct dma_fence __rcu  *last_seq_flush;
        atomic64_t              kfd_last_flushed_seq;
        uint64_t                tlb_fence_context;
        struct dma_fence        *last_tlb_inv;
@@ -554,22 +555,24 @@ bool amdgpu_vm_is_bo_always_valid(struct amdgpu_vm *v=
m, struct amdgpu_bo *bo);
  */
 static inline uint64_t amdgpu_vm_tlb_seq(struct amdgpu_vm *vm)  {
-       unsigned long flags;
-       spinlock_t *lock;
+       u64 seq =3D atomic64_read(&vm->tlb_seq);
+       struct dma_fence *head, *iter;

-       /*
-        * Workaround to stop racing between the fence signaling and handli=
ng
-        * the cb. The lock is static after initially setting it up, just m=
ake
-        * sure that the dma_fence structure isn't freed up.
-        */
        rcu_read_lock();
-       lock =3D dma_fence_spinlock(vm->last_seq_flush);
+       head =3D dma_fence_get_rcu_safe(&vm->last_seq_flush);
        rcu_read_unlock();
-
-       spin_lock_irqsave(lock, flags);
-       spin_unlock_irqrestore(lock, flags);
-
-       return atomic64_read(&vm->tlb_seq);
+       if (!head)
+               return seq;
+
+       /* Add the updates in the chain which have finished, in any order *=
/
+       seq +=3D head->seqno;
+       dma_fence_chain_for_each(iter, head) {
+               if (!dma_fence_is_signaled(dma_fence_chain_contained(iter))=
)
+                       --seq;
+       }
+       dma_fence_put(head);
+
+       return seq;
 }

 void amdgpu_vm_update_fault_cache(struct amdgpu_device *adev,
--
2.48.1

