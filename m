Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CADB7C369CB
	for <amd-gfx@archiver.kernel.org>; Wed, 23 Apr 2025 15:05:32 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6BB2310E6C6;
	Wed, 23 Apr 2025 15:05:32 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="YdqhjGW7";
	dkim-atps=neutral
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2088.outbound.protection.outlook.com [40.107.243.88])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DE2DC10E6C6
 for <amd-gfx@lists.freedesktop.org>; Wed, 23 Apr 2025 15:05:31 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Nt2gtXLpKop5EtRLm/ReRczWu2i+AS9a8hQxsArlsGE+Yc1O1S3cPnbB56KoDpKPtdOh2cX0ee6uc9uRASnNAh4NkLl2ROb9jw22BVl6605dXDVrFftO6ltt+aaG8z1xILHp8ilLK/u2DtczZPhNUG1JVlqFKRI0CDyQVgso4yHAfegcY9cMhNx0z5I5T7CjCg+oOJpTAI8vrqgUuYbjWtPCeQCKLMtne1kwL7uizXLwTPGYEz3rTa3y7/B9nwz1pMQ9q+b0J6dJKOuTTAEBUhVWe+yCR4DD1OSmJtl17TxIguq76KOtQE4d69aMtb59uGbHbi1hn7/XbOR94hwErQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jK5s61lrhHUHwpJ04e+gavJ9YKCNcJmXqA5hxY2pspc=;
 b=uSRHtcohH65WQHaIU46klr152JhXtTcO1jE9LO2WXQu73ZHmH4LLlCTbaV0FFuuPX+gr8DtEJHxzFsl+4ZYbZMYaUu25vl9nem+wSTfLW+yKPnKkfT0wBHfjzDXA2fd3LnmJKokc7Jtbtylm8Scj7C4BduD9cbT1pBPIhobecETyP06VRBuIv5IFTeNFltqVh4ibHcX6MSTh9Gz9oVhOKiKwCPBYbznzvrc+AZdZXJzFIVlNCIItcqca1F6aLoQUs+idl7CTVvPVk8rK0qCDgZKiSn1mZP5iQvlbs4LLX3KHr2vG/wXLzb/8ihfOzKPjduQnNcbwCXsdYwZCHAj0kg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jK5s61lrhHUHwpJ04e+gavJ9YKCNcJmXqA5hxY2pspc=;
 b=YdqhjGW7Hx1ip7j+/P05Hv5BIMXu9qEnyRoBvL2ebK4LKjiBfC5WotJB+Zi0KhlDL1xGsc7SSCjy9xlqSI/j8OBBATZ2qc+BxErBDGeOTxc6t8R7g5vAeRzx25mOQCXoE7MHam7QrhHcxgfrABF4HTpxX14sc15QZs3LaL4dSEU=
Received: from DS7PR12MB6005.namprd12.prod.outlook.com (2603:10b6:8:7c::17) by
 DM6PR12MB4090.namprd12.prod.outlook.com (2603:10b6:5:217::11) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8678.23; Wed, 23 Apr 2025 15:05:26 +0000
Received: from DS7PR12MB6005.namprd12.prod.outlook.com
 ([fe80::4dc0:f34c:9e7e:ccb]) by DS7PR12MB6005.namprd12.prod.outlook.com
 ([fe80::4dc0:f34c:9e7e:ccb%6]) with mapi id 15.20.8655.033; Wed, 23 Apr 2025
 15:05:24 +0000
From: "Liang, Prike" <Prike.Liang@amd.com>
To: "Koenig, Christian" <Christian.Koenig@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
CC: "Deucher, Alexander" <Alexander.Deucher@amd.com>
Subject: RE: [PATCH 2/2] drm/amdgpu: properly release the eviction fences
Thread-Topic: [PATCH 2/2] drm/amdgpu: properly release the eviction fences
Thread-Index: AQHbtFNMQ7TAmF9hDUm4DByEw4v3XrOxRugAgAAKbfA=
Date: Wed, 23 Apr 2025 15:05:24 +0000
Message-ID: <DS7PR12MB60051B77DF6F131F4754500CFBBA2@DS7PR12MB6005.namprd12.prod.outlook.com>
References: <20250423132604.4002242-1-Prike.Liang@amd.com>
 <20250423132604.4002242-2-Prike.Liang@amd.com>
 <337da064-628f-4746-8609-e17c2d0b7d56@amd.com>
In-Reply-To: <337da064-628f-4746-8609-e17c2d0b7d56@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_ActionId=e5f13d26-742e-4faa-b0c5-f4580830922c;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_ContentBits=0;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Enabled=true;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Method=Privileged;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Name=Open Source;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_SetDate=2025-04-23T14:35:53Z;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Tag=10, 0, 1, 1;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS7PR12MB6005:EE_|DM6PR12MB4090:EE_
x-ms-office365-filtering-correlation-id: a5f3aeee-2e17-4687-7deb-08dd8278467d
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|366016|376014|7053199007|38070700018; 
x-microsoft-antispam-message-info: =?us-ascii?Q?TNnHMOOLcKLLAMQB7JgBr1gSNfVWhV3ekpS3yFbi/yJpCiEl8D/S3lx3Ola0?=
 =?us-ascii?Q?PqOd/NMjoSCGQJUc7CQaW3pkOEjPxpPMEneQ1YPMNabGIcs7GHuGKJamZjlG?=
 =?us-ascii?Q?KS8XZ7WMuEfTIaE4HezlH5EHslnlE6by7IUqOGrG66EVBlZR9lvbvJaA0AES?=
 =?us-ascii?Q?WZRO1QqVkSNKxIOVlLSNWIWycwD78m/N6Ae/x09fSva4g50HNg74g8uCWrpw?=
 =?us-ascii?Q?LL5aqPlRgOquM5NjpE2XjNxOJDGD8mtP+YDenjvOUazD0Shes4LEjLQvM/i3?=
 =?us-ascii?Q?5RZDuATGREk00jygNvMybK4ZawPOQ/+delsItZ5+92i+0ZnwVTWxU0jto+EW?=
 =?us-ascii?Q?Ha6pRprNSAXBNVuJzQqE0Z2JuyV/Rx9ykIIMQpDugCwjKFkxXukX30xePTWb?=
 =?us-ascii?Q?qDf0TRqtmud20yE639SUDHw6UQ/Zi7z4rFnjc1Va3xpSOZID5OEkVHFNFzUA?=
 =?us-ascii?Q?evbecN0QWzqCVfu2CLRN+lMwW0w/u+w75eFnAr7BXFq5WJDhduvBxjVmETzx?=
 =?us-ascii?Q?j8Ru3K+X+ivEwRLS0hY4BmILokfBydLT7axEIXAqmYxC515hQHMFZMpioOBt?=
 =?us-ascii?Q?iA8hNKJ6nSIy6ib2It9TESqplu7rRBoqONWudJZc4jJavsFIgeJWWjq4XtWw?=
 =?us-ascii?Q?yGsIHjv6/BPqzYuLJHIPOJPMbPe1Z4kKb/vZT69CU+xlBJn7zb6+GeQx5pBb?=
 =?us-ascii?Q?PuQxkLd5rpR4OzeoIDQg1/U8PIx0YbgrVba4v8dpTcWm505/PxZ40g+JsurZ?=
 =?us-ascii?Q?kft6MRPqeb3xOb/LGCNV7n7V+goadxVVZexCA7NxuQZ9RwuU+jgDnBCh74ye?=
 =?us-ascii?Q?+gF4ksPFKkUg5lpXJS09dkF9tibYIYg15MR2ouR3bn7IMlViSe9lrVdm/+b6?=
 =?us-ascii?Q?CNRW3fMU/qgkvJ6EZbjSgGrQQ28vriEq+SimNJt6IB23jUvJAJwujNkFlint?=
 =?us-ascii?Q?EPp31MnMRkcSjFdPjk9kIh7wMl741cVECpF7/DxNUanDXFUaaPCLcDh04TD9?=
 =?us-ascii?Q?f+8gN32HPAncTypUXnR2u9jb6J7DtYVHNGGJF9LCVVC0nI0ODtk9a+eDU/w4?=
 =?us-ascii?Q?HbCRCWdBS1qCzKsO0LBxVdY1SZL3B+dj7T+8Gva7tmOyAxQEwwLjLkFQkKVb?=
 =?us-ascii?Q?MZscRQYjW77hXwHCo16FQaEFP5b28EvYVRTZ5DST6xj0lcyFzvOm0sHeVhmC?=
 =?us-ascii?Q?tfLrTQpYZ5C1aA+TGh8uRMoOMyWF7VZedpHdpdXl7rQomaTrbtcRv3Zw+Qw/?=
 =?us-ascii?Q?jGgkqIn5CKV54yNQFG6N6bKWho0pc/Y0dZY5uXGQgszvY08JK+F7l7PpXJmd?=
 =?us-ascii?Q?L0jzsDBg+keIng2V6h9K6cQtPJMKC7ar+dSwsDkd/BSh7z7cAEEQt5ubD4Gz?=
 =?us-ascii?Q?Wwitmiz4lVHLNQmx95EZ4XRls73F/2VtZrDgpwzor3wxI9GvrSxkOopz5Swr?=
 =?us-ascii?Q?b4w26uEnZW4xsK7HE4MfCS2pONRuzeILY6olNx3ZYl16qIR4j5SyYyiLBoPk?=
 =?us-ascii?Q?mGeWuVyFwqtl8UI=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS7PR12MB6005.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(7053199007)(38070700018); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?56fIR+niC1x0qWAVSPETbKPs2Zte5UTjOtLWvrC/ToTuc+I02pI5D9JG9wDw?=
 =?us-ascii?Q?Ui7t5r3AZ2jNdwEVwlXeXTO6wKvY4kCCnkd9L4WN7gK+4vZp6xZhHi/R9WhE?=
 =?us-ascii?Q?fPeQ7rVMoLi7juhEARg6b6BB/NXx225aPgXJweSfNmhZVzPdctjkShA6DC5B?=
 =?us-ascii?Q?0mx5k9i0q3B81BbVIs1uUrj0JLHjH9DFKzJv3g54NSUOsYuhX+LAlP86m+Ba?=
 =?us-ascii?Q?t33/2tgh/4jVEMasmm5mvStb9qiX20/apfMwExqEG5SdsTAXDZWhG0DHLhcT?=
 =?us-ascii?Q?fBio4GBmTcVjeP01t1Q7ZyPJCG5cNKT+NLZDI+FdiEtaPSu/GNeJrXOKcDrH?=
 =?us-ascii?Q?546KwdYd1CJKG571rH9oMkVUjBpHgGFmusn4BMIpG4Fa4nmmMXKsDWsqNO7H?=
 =?us-ascii?Q?LfDG5CsFXKgGElhsTpA8iX4Q2N81haOmpm+6a1q2rXm2XRZzm1yFGMAB4QES?=
 =?us-ascii?Q?X3BCb9JqrGW78RNDPg5RF46I6m+EEC9AOUyGs8NNBKWn/kNDP6SLe/SDyJ6G?=
 =?us-ascii?Q?McSpQBRFdCU84k6AYaPzgAB3hhybhPmaUNL48tPyGJyvvbRW/5g3Qf7aaTAf?=
 =?us-ascii?Q?KF5Qsti9yj1p0WofRy/RezDrMz+xFPeOU8u3lIzyNSgeD5WUoPPs8Lzhf7yb?=
 =?us-ascii?Q?imRFa1PFxg+sKEigfeFDbDJ51hdP+5O2glqR3TKkZ0Aee9ofQqX1PSDi29a3?=
 =?us-ascii?Q?5uSwJozS5PHmF/QQuob5GjZRNzhV5ID+ozYVr+/4w4Nue5LnrkjhhxeJmOLR?=
 =?us-ascii?Q?8QEzcjHWuwrxqh1FS7UC67QDsJy31OzcaRgYkEMgFsJMNsWwNiQKZ71+LhLj?=
 =?us-ascii?Q?5O5KABcYGYZkduRoI/voig87FplPI57M+PqXaPAeKC6jqMqUUucDpylGKTp8?=
 =?us-ascii?Q?DyO65rQDho+oJcIq1ymAu+1DqdFdAw+L12NAyisBQFXjLONBCiFl/GKeGJCI?=
 =?us-ascii?Q?Z/8NMMqKBoSLjsOa6xaaPSl9d2qTT4laULrlnzQRoQSCxEwYZgFLijjPz425?=
 =?us-ascii?Q?UjVj0HrUR3sjvxmVWmh3SdW+qoxH5juBe+V1jdDzVTTPh0sWqIjxgFadRFRY?=
 =?us-ascii?Q?1OBnlqOQ6xKedZ3qei/1qaTDKDDtmpLmEtrEYXwd55NewD4uVOG3tCb8HR6R?=
 =?us-ascii?Q?b06YLaZT6yoQ7FUhUqxz9ZJok+v8xR8yMHuU8tTKkWQ3XN6oZ8pQhhauCapx?=
 =?us-ascii?Q?1FLDGWP/y+1ADHOKwowOZu7j3xNnjktWiWwlnPcsAvePq2Bo6eZtWBcCaEpv?=
 =?us-ascii?Q?8Xeam+PBBuWPtSEEE4XP9bLk7XJEA/YkdzNbn09m5P9bF2yBdcNovQyvm6vy?=
 =?us-ascii?Q?REjStqbE0OZRiSNhc2+A1+mxY4hFweW0MkiN8QA/VW4eJKH8z+3EGwOxfinm?=
 =?us-ascii?Q?fWHrqfMG1aRPaix+0lw98316BOMCheALDu37Ehr5E9hVHihZuK2GJMfHLVRH?=
 =?us-ascii?Q?Yg9mmjQ5tJqH6eGt4apen4zNhcnOn+ZBtPlM7zJJfE4TUwvFp8+e7sIP//4C?=
 =?us-ascii?Q?D1LBYcRmxl3mwAEdF3OpW+0FsPfNNqqB+PnNa+014ezrV/+jPbLU5/H9Fh77?=
 =?us-ascii?Q?cy7kk7uM4LZPzOem7bg=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB6005.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a5f3aeee-2e17-4687-7deb-08dd8278467d
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Apr 2025 15:05:24.6487 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: pZyKKeeiHr7R75lAFWP5g7mZQ2isd1XVc9K9s9p0V4oYCBkI18ThUVEiNkFUsceH
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4090
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

[Public]

> From: Koenig, Christian <Christian.Koenig@amd.com>
> Sent: Wednesday, April 23, 2025 9:58 PM
> To: Liang, Prike <Prike.Liang@amd.com>; amd-gfx@lists.freedesktop.org
> Cc: Deucher, Alexander <Alexander.Deucher@amd.com>
> Subject: Re: [PATCH 2/2] drm/amdgpu: properly release the eviction fences
>
> On 4/23/25 15:26, Prike Liang wrote:
> > The following cases require releasing and deferring the eviction
> > fences properly
> >
> > 1) Detach the old eviction fences before attaching a new one.
> > 2) Drop the eviction fence init reference.
> > 3) Correct the attached eviction fence reference.
> > 4) Free the eviction fence when the attached BOs are released.
> >
> > Signed-off-by: Prike Liang <Prike.Liang@amd.com>
> > ---
> >  .../drm/amd/amdgpu/amdgpu_eviction_fence.c    | 53 +++++++++++++++----
> >  .../drm/amd/amdgpu/amdgpu_eviction_fence.h    |  2 +
> >  drivers/gpu/drm/amd/amdgpu/amdgpu_object.c    |  1 +
> >  3 files changed, 45 insertions(+), 11 deletions(-)
> >
> > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_eviction_fence.c
> > b/drivers/gpu/drm/amd/amdgpu/amdgpu_eviction_fence.c
> > index d86e611a9ff4..a47db865c530 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_eviction_fence.c
> > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_eviction_fence.c
> > @@ -70,11 +70,6 @@ amdgpu_eviction_fence_replace_fence(struct
> amdgpu_eviction_fence_mgr *evf_mgr,
> >             return -ENOMEM;
> >     }
> >
> > -   /* Update the eviction fence now */
> > -   spin_lock(&evf_mgr->ev_fence_lock);
> > -   old_ef =3D evf_mgr->ev_fence;
> > -   evf_mgr->ev_fence =3D new_ef;
> > -   spin_unlock(&evf_mgr->ev_fence_lock);
>
>
> That is certainly incorrect. The new fence *must* be made public before a=
ttaching
> it to the existing BOs.
Here the new eviction fence also will be updated in the evf_mgr before atta=
ching it to the vm hold BOs, but it looks much better as before to cache an=
d update the eviction fence outside of the VM hold BOs iterations attached =
fences.


> >
> >     /* Attach the new fence */
> >     drm_exec_for_each_locked_object(exec, index, obj) { @@ -82,6 +77,16
> > @@ amdgpu_eviction_fence_replace_fence(struct
> > amdgpu_eviction_fence_mgr *evf_mgr,
> >
> >             if (!bo)
> >                     continue;
> > +
> > +           /*detach the old eviction fence first*/
> > +           amdgpu_eviction_fence_detach(evf_mgr, bo);
>
> That's completely nonsense. The old eviction fence is signaled at this st=
ate and
> doesn't need to be detached.

By using the amdgpu_eviction_fence_detach want to drop the old eviction fen=
ce which added the Bos before, so instead of confusing here and drop the ol=
d eviction of the BO directly before attach a new fence?

> > +
> > +           /* Update the eviction fence now */
> > +           spin_lock(&evf_mgr->ev_fence_lock);
> > +           old_ef =3D evf_mgr->ev_fence;
> > +           evf_mgr->ev_fence =3D new_ef;
> > +           spin_unlock(&evf_mgr->ev_fence_lock);
> > +
> >             ret =3D amdgpu_eviction_fence_attach(evf_mgr, bo);
> >             if (ret) {
> >                     DRM_ERROR("Failed to attch new eviction fence\n"); =
@@ -
> 89,9 +94,10
> > @@ amdgpu_eviction_fence_replace_fence(struct amdgpu_eviction_fence_mgr
> *evf_mgr,
> >             }
> >     }
> >
> > -   /* Free old fence */
> > +   /* Free the init eviction fence which was referred by the dma_init*=
/
> >     if (old_ef)
> >             dma_fence_put(&old_ef->base);
>
> The comment isn't really helpful. Additional to that it's valid to call d=
ma_fence_put()
> with a NULL fence to we can drop the extra if check.
>
> > +
> >     return 0;
> >
> >  free_err:
> > @@ -189,7 +195,6 @@ void amdgpu_eviction_fence_destroy(struct
> > amdgpu_eviction_fence_mgr *evf_mgr)  int
> amdgpu_eviction_fence_attach(struct amdgpu_eviction_fence_mgr *evf_mgr,
> >                              struct amdgpu_bo *bo)
> >  {
> > -   struct dma_fence *ef;
> >     struct amdgpu_eviction_fence *ev_fence;
> >     struct dma_resv *resv =3D bo->tbo.base.resv;
> >     int ret;
> > @@ -205,10 +210,12 @@ int amdgpu_eviction_fence_attach(struct
> > amdgpu_eviction_fence_mgr *evf_mgr,
> >
> >     spin_lock(&evf_mgr->ev_fence_lock);
> >     ev_fence =3D evf_mgr->ev_fence;
> > -   if (ev_fence) {
> > -           ef =3D dma_fence_get(&ev_fence->base);
> > -           dma_resv_add_fence(resv, ef, DMA_RESV_USAGE_BOOKKEEP);
> > -   }
> > +   /*
> > +    * The dma_resv_add_fence() already refer to the added fence, hence=
 in
> this
> > +    * placement needn't refer to the armed fence anymore.
> > +    */
>
> Please drop that comment.
>
> > +   if (ev_fence)
> > +           dma_resv_add_fence(resv, &ev_fence->base,
> DMA_RESV_USAGE_BOOKKEEP);
> >     spin_unlock(&evf_mgr->ev_fence_lock);
> >
> >     return 0;
> > @@ -224,6 +231,30 @@ void amdgpu_eviction_fence_detach(struct
> amdgpu_eviction_fence_mgr *evf_mgr,
> >     dma_fence_put(stub);
> >  }
> >
> > +void amdgpu_remove_all_eviction_fences(struct amdgpu_bo *bo) {
> > +   struct dma_resv *resv =3D &bo->tbo.base._resv;
> > +   struct dma_fence *fence, *stub;
> > +   struct dma_resv_iter cursor;
> > +
> > +   dma_resv_assert_held(resv);
> > +
> > +   stub =3D dma_fence_get_stub();
> > +   dma_resv_for_each_fence(&cursor, resv,
> DMA_RESV_USAGE_BOOKKEEP, fence) {
> > +           struct amdgpu_eviction_fence *ev_fence;
> > +
> > +           ev_fence =3D fence_to_evf(fence);
> > +           if (!ev_fence || !dma_fence_is_signaled(&ev_fence->base))
> > +                   continue;
> > +
> > +           dma_resv_replace_fences(resv, fence->context, stub,
> > +                           DMA_RESV_USAGE_BOOKKEEP);
> > +
> > +   }
> > +
> > +   dma_fence_put(stub);
> > +}
> > +
> >  int amdgpu_eviction_fence_init(struct amdgpu_eviction_fence_mgr
> > *evf_mgr)  {
> >     /* This needs to be done one time per open */ diff --git
> > a/drivers/gpu/drm/amd/amdgpu/amdgpu_eviction_fence.h
> > b/drivers/gpu/drm/amd/amdgpu/amdgpu_eviction_fence.h
> > index fcd867b7147d..7e6c55a334e0 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_eviction_fence.h
> > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_eviction_fence.h
> > @@ -42,6 +42,7 @@ struct amdgpu_eviction_fence_mgr {  };
> >
> >  /* Eviction fence helper functions */
> > +#define fence_to_evf(f)  container_of(f, struct
> > +amdgpu_eviction_fence, base)
> >  struct amdgpu_eviction_fence *
> >  amdgpu_eviction_fence_create(struct amdgpu_eviction_fence_mgr
> > *evf_mgr);
> >
> > @@ -66,4 +67,5 @@ amdgpu_eviction_fence_signal(struct
> > amdgpu_eviction_fence_mgr *evf_mgr,  int
> > amdgpu_eviction_fence_replace_fence(struct amdgpu_eviction_fence_mgr
> *evf_mgr,
> >                                 struct drm_exec *exec);
> > +void amdgpu_remove_all_eviction_fences(struct amdgpu_bo *bo);
> >  #endif
> > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
> > b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
> > index dbe57996a481..6d3eacffbcb9 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
> > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
> > @@ -1322,6 +1322,7 @@ void amdgpu_bo_release_notify(struct
> ttm_buffer_object *bo)
> >     amdgpu_vram_mgr_set_cleared(bo->resource);
> >     dma_resv_add_fence(&bo->base._resv, fence,
> DMA_RESV_USAGE_KERNEL);
> >     dma_fence_put(fence);
> > +   amdgpu_remove_all_eviction_fences(abo);
>
> That's a really bad idea. We only did that for the KFD eviction fence bec=
ause we
> didn't had any other choice.
>
> For the user queue eviction fence we should rather do that in
> amdgpu_gem_object_close() e.g. when amdgpu_vm_bo_del() is called.

Thanks for the suggestion, will further check it here.

Thanks,
Prike

> Regards,
> Christian.
>
> >
> >  out:
> >     dma_resv_unlock(&bo->base._resv);

