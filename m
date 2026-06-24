Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 19BA9CDB481
	for <amd-gfx@archiver.kernel.org>; Wed, 24 Jun 2026 13:24:24 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A54CA10EF2B;
	Wed, 24 Jun 2026 13:24:23 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="BeEZP9gc";
	dkim-atps=neutral
Received: from SN4PR0501CU005.outbound.protection.outlook.com
 (mail-southcentralusazon11011024.outbound.protection.outlook.com
 [40.93.194.24])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AE93610EF24
 for <amd-gfx@lists.freedesktop.org>; Wed, 24 Jun 2026 13:24:21 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=We9k+7b0h4YDIU9KLE49CGe0vvvFDSQ32iV4WvZ/6Lk6OHqsbRHQbcUmgw78XVVw823zmc5Fb5V8p+k64yOJbrhVD84x8fdOxc+GqKmqhu/MQkYts0t8IShIUkFrFZFUrSim9wWxKyuCjHxsC6Rf2SAccB8KNj24Pw95t+OOjGk7/i1MRlIjyziKm9mIunJl9IGJOVZemYNdSoz6JWi2pw6Hud7AftQdf+tG84CyNMCEA9YywsKnqGYb9CL215BOH0UWYMjdL9o9VfjpMe4fHeg4eFAfiicdJxRAw4ygHxfUfMApylNeAt7qX/nNfQJgzC9CP+eOaXd4eg+Y2fLyWA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ETdQGHJAwYOe9gjuf3XaRmIXR/hqBTzX0APK1hnVSSk=;
 b=e7PY60LzitD8kayqyiHCA6Xfedulr1kxQ0jR8tZW27H48AWAxsiaGI71Zw1WB3mUnazpkUd03dzNhiwinCXptaifhqbzCv+Ojgo9EjUf/x2bRvSu7MTGWYQfFPOLp37yA/QFO47hDJEkfxRpgleW/VcZF6Ri+saCBR8Bxtt9Z4zIqH3bo1zoGr5SieyqL8f5rTNcIvxt+kX4Wr2CKZpuGb1VQXmxKXd1KZ+GLC0pPyG1O22TEnmoJAnYvitoJwQikiiqVHpxH6kv6+ABxsDYNxxsUsryqvp0527dbSNdvemqdxA79X0BRv8t9Dfa3SE67LfxZWMlxMnSDdD5X1UaZA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ETdQGHJAwYOe9gjuf3XaRmIXR/hqBTzX0APK1hnVSSk=;
 b=BeEZP9gcO5ER/d50pIuP3+sPpZbPg3qDEiBYhYZAAkslsj0+/1GcZbTegd22xfpPEh8fpk2wZ100rH/Uftobm6yt/kZLui5Plprg3DizqUqwTFTvD/yRwh3BZkpaT0+AOcyCw4F1pvWEnBDJ0haD67SF/GI7Ab+WYb4f4jZbXhw=
Received: from SA1PR12MB8144.namprd12.prod.outlook.com (2603:10b6:806:337::15)
 by SJ2PR12MB8942.namprd12.prod.outlook.com (2603:10b6:a03:53b::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.159.13; Wed, 24 Jun
 2026 13:24:18 +0000
Received: from SA1PR12MB8144.namprd12.prod.outlook.com
 ([fe80::56ac:f44f:8336:d7ec]) by SA1PR12MB8144.namprd12.prod.outlook.com
 ([fe80::56ac:f44f:8336:d7ec%7]) with mapi id 15.21.0159.012; Wed, 24 Jun 2026
 13:24:18 +0000
From: "Francis, David" <David.Francis@amd.com>
To: "Sun, Yongqiang" <Yongqiang.Sun@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: Re: [PATCH] drm/amdkfd: bound v9 CRIU control stack restore to
 allocated MQD region
Thread-Topic: [PATCH] drm/amdkfd: bound v9 CRIU control stack restore to
 allocated MQD region
Thread-Index: AQHdA0gdtUIn0xA5vk+RKn9CsuX5GLZNsqew
Date: Wed, 24 Jun 2026 13:24:18 +0000
Message-ID: <SA1PR12MB81441F54637FC8DD284F05BDEFED2@SA1PR12MB8144.namprd12.prod.outlook.com>
References: <20260623193949.4184400-1-Yongqiang.Sun@amd.com>
In-Reply-To: <20260623193949.4184400-1-Yongqiang.Sun@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Enabled=True;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SetDate=2026-06-24T13:24:17.735Z;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Name=AMD
 General; MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_ContentBits=1;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Method=Standard; 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR12MB8144:EE_|SJ2PR12MB8942:EE_
x-ms-office365-filtering-correlation-id: 5dd82cdc-58fd-48da-5f94-08ded1f3e4e7
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|23010399003|376014|366016|6133799003|18002099003|22082099003|56012099006|11063799006|38070700021;
x-microsoft-antispam-message-info: z58cMC31U7CKcA/Jub0Fz+1c6km223HUSsZ/+r0TB5wJo9P3Qd5kWvP1jQrr8APvywD3BhNyVEjkVw2BWan0WjQgdzqQAYOubLHBXcb/7/9zooG33rxDe+utBglVJ8eHgsXbivkBd9Eepo0/yMdTW2/TYlCJAvssODxSBm8eQr95l9rY34hiclWui5vQoErMJWt2gmlI0Ibd6SdxUluIMYwcdDerE4E7pctYg6yAgIxp7DvMOlqN/qoovcpseW1p0hee2HdcaD5YUW/E4bkODdd2JJsLGEjr1TaBkSknbNHPSXw3twTTumTOBinpobd/46ZzXIdYgcm1WK/ALqSmnHZ7KtbaKPofuOGiLLAnYQRJN26nb2wpDB9uyhNbEOCJEzm2lhAgRJD8vSLLHji07eG8znyAc7u59c18h6Q6eZzLiuHHEg4d4CZU/YzIZWFCS7jUXGHpYlO0nIBzEvZh6LGVhOYICSLTfNu5L7LdGGJPXnu05UpHmoyQ5YMDJZLvjGrdXxuUmOTTbD0AbkF8gjAHM9wywP3ZzK6qt8CUHWfZyM+yiU4Hzl6h0Se0iXy3mcJhEvWJft6+6ej/LWaKu4lTOQlio4ihz1MB8rWXNMabkxpW2yjJKjPgzLOLmNgZAlRqbh+Gj0auJW46EGN84XyO/CTCIbB0BoZ9khEY5UGttdA+cppZAT1me0LPKbtAAdfZ6D7nQFCVh33ewsM9aBdA0lyF5bWTYyytfYzpkug=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SA1PR12MB8144.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(23010399003)(376014)(366016)(6133799003)(18002099003)(22082099003)(56012099006)(11063799006)(38070700021);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?6ReTBvMi7JxxeeUp6+8knBlgU8jvGKEj3w1KymSvNVEJzSWixv9Vstx9gy?=
 =?iso-8859-1?Q?eX4SlUBapb6CczXWRjQa7HC0UFmnclnYzRwQhdTc2vhqoqt7ORsn2gHGLT?=
 =?iso-8859-1?Q?IGx5WgGOhQp3/kIkuYzhV6QYByUfH+GJA8UT7cdMf49aYEb0p7YCpgpkd/?=
 =?iso-8859-1?Q?SJ0EQ+m4pD4iHQqRTWLfEc4VPR0wpLBkAfOXT++3fHY8cB06KwPVFLJYc7?=
 =?iso-8859-1?Q?P2T/c1kHA/GJFDIfNrCr5jGCwSVg9Qnf6+vZObbNugfqmlSr+7UBOoi1mp?=
 =?iso-8859-1?Q?gtEXVKRuBFrfUH42cEepEjfLYTCWd+TlPEAlE1VVdqxkeGe1V8YrEQtn67?=
 =?iso-8859-1?Q?Y6Q9i7CYk+oAevZGPVIr2Gr+TqSeqKmF6M+rlCJJ4HE3Jf/9zWd2QX1CQB?=
 =?iso-8859-1?Q?F8v0hoIXfyNfFxKHouJ2aAsOI6UEtA4uXSZjy88UwCL22ipd58dA5Bx01f?=
 =?iso-8859-1?Q?RLvr055XBWwUUIIZmgs9cn66bTreS5839BDsxWNLihfTWflnC/Rhf+VNwd?=
 =?iso-8859-1?Q?fVTnk7BHNv18rQFWhj4BcNoocZcX5YhFLZa3ehx4gK9t/H9pwe1fjJ2ATP?=
 =?iso-8859-1?Q?VwmCRpcHxRLP1SQ6R00qK68jsKg9edSXaZZSxvlqCmDxjf3+VSM9UFH6KZ?=
 =?iso-8859-1?Q?9tzfR48mKmy6uGfPU9abcDeZSULMWNe4GW2ygN8NhUEwo7DcPx6gELhakZ?=
 =?iso-8859-1?Q?MUYL+4BWfNU1XnJ5YWP45hCyiGsp61hgoZNYPzVL/MlBtr83DNtbE4/aSx?=
 =?iso-8859-1?Q?N4YiKtHpQBxcsmC9/7bJ9ZHA7SGmZQ4le3F3p6DAKOIoYWbmfV5rsNiegA?=
 =?iso-8859-1?Q?F6qrgolIL5+cNBc7/WdKkoQrgmAGr5w40V+HWGBiR4Iz7KNAvO49tDskre?=
 =?iso-8859-1?Q?uUuBXPS6y93a1Ue2kPyhOAZDp6MwC8U2vtfP+LY80J30wXqX0omgbOKblc?=
 =?iso-8859-1?Q?/FhMtdj0Nk+HifsEZ8kHRzr/D7nhNlpMPVYeXbOGa+7d8pwl8gxkXVOW5z?=
 =?iso-8859-1?Q?HZjGW336vzEhVu2bKm7q42CP244Na/JIxa6txxKgRoAyxB5muAAzlzbHh0?=
 =?iso-8859-1?Q?kUl6VXKBHZUdTxOenzzOK77MKzt5X5/x1IF1BgyDs4YBwePdBicXIp3hJF?=
 =?iso-8859-1?Q?aX2Ux93EN2e4z6MMPpBs+gj+5YkQFXNwsUSR19p8XGXblxVeFpyBVp/SUa?=
 =?iso-8859-1?Q?TjtH4xuxDtZsVKXD/zn/T3yDRaGCeelsDkd1RTXPCqhFvwjZGCO2PkgGL0?=
 =?iso-8859-1?Q?opo/MvlaI8AEIEVQhQ7qZY/WBsKLjRi2P/02ukSMSGApCl1kHqzufXwL+Y?=
 =?iso-8859-1?Q?89517bPnuZDgRvL6NIxgxS3eLX2So9WJrud6KUp67iLYvEY9GcAzlu7bcT?=
 =?iso-8859-1?Q?neM0JjP1vJPgoaANrO/OD01+6lmvMH7V9S36Ls/jfR3EZ2o8m/6q1hbU8o?=
 =?iso-8859-1?Q?wm2mFoP7ODsThj6jWYB/09siwj+WQrzHbL9fZjKtWEJZnJGj3AXq41vTV1?=
 =?iso-8859-1?Q?rmsStJYMBEHmq78Y9ny4pTq0+wja5fOs3o2Z4OvGwoH0WSQ+oGA1aoQqVe?=
 =?iso-8859-1?Q?7cVS6v2oJPphakLTSwEe652zTAjx9BFgLncDd7DYTz4gATLohTegdfwVD+?=
 =?iso-8859-1?Q?Fneb308pR7FdIB/0Hn6TQWjxJcxDMohOgk1D5fkFhdLE234ePlkip9+jUo?=
 =?iso-8859-1?Q?vufYsTWr/K0pG8ribatjWyfiIQQ0CkObqTxt78SQ33R7WUJtesVN4s0Z2H?=
 =?iso-8859-1?Q?xTurMyQc0oHVzE1aMl12JCuOYvc6ZBjz7Ne0+mNuUwOlPm?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA1PR12MB8144.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5dd82cdc-58fd-48da-5f94-08ded1f3e4e7
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Jun 2026 13:24:18.0536 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: R+ppP+9jGzbQ2rtTUT4woR3F2t3QMBEjEKnnCC3N0tDoat8EBuipBTvz8bF3cFcz
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8942
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

> +=A0=A0=A0=A0=A0=A0 if (ctl_stack_size > qp->ctl_stack_size) {=0A=
=0A=
This looks wrong to me. Tracking both of these values back to their origin,=
 =0A=
ctl_stack_size comes from the CRIU private queue data, and qp->ctl_stack_si=
ze=0A=
is filled in by set_queue_properties_from_criu, also from the CRIU private =
queue data.=0A=
So this check is useless.=0A=
=0A=
David Francis=0A=
=0A=
=0A=
________________________________________=0A=
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> on behalf of Yongqian=
g Sun <Yongqiang.Sun@amd.com>=0A=
Sent: Tuesday, June 23, 2026 3:39 PM=0A=
To: amd-gfx@lists.freedesktop.org=0A=
Cc: Sun, Yongqiang=0A=
Subject: [PATCH] drm/amdkfd: bound v9 CRIU control stack restore to allocat=
ed MQD region=0A=
=0A=
During CRIU restore, restore_mqd() copies the MQD control stack using a=0A=
size derived from the untrusted, user-supplied q_data->ctl_stack_size. On=
=0A=
multi-XCC GFX9.4.3 parts the divisor used to size the MQD allocation can=0A=
differ from the one used for the copy, so the memcpy at the fixed=0A=
+AMDGPU_GPU_PAGE_SIZE offset can write attacker-controlled bytes past the=
=0A=
TTM/BO-backed MQD buffer into adjacent kernel memory, allowing local=0A=
privilege escalation (requires CAP_CHECKPOINT_RESTORE and /dev/kfd).=0A=
=0A=
Clamp the control stack copy in restore_mqd() to qp->ctl_stack_size, the=0A=
page-aligned region allocate_mqd() actually reserves, and reject oversized=
=0A=
q_data->ctl_stack_size early in kfd_criu_restore_queue() by bounding the=0A=
per-XCC size to the node's advertised control stack size.=0A=
=0A=
Signed-off-by: Yongqiang Sun <Yongqiang.Sun@amd.com>=0A=
---=0A=
 .../gpu/drm/amd/amdkfd/kfd_mqd_manager_v9.c   | 16 +++++++++++-=0A=
 .../amd/amdkfd/kfd_process_queue_manager.c    | 26 +++++++++++++++++++=0A=
 2 files changed, 41 insertions(+), 1 deletion(-)=0A=
=0A=
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v9.c b/drivers/gpu/=
drm/amd/amdkfd/kfd_mqd_manager_v9.c=0A=
index ce379ab17916..9117fbae0a1a 100644=0A=
--- a/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v9.c=0A=
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v9.c=0A=
@@ -453,8 +453,22 @@ static void restore_mqd(struct mqd_manager *mm, void *=
*mqd,=0A=
        if (gart_addr)=0A=
                *gart_addr =3D addr;=0A=
=0A=
-       /* Control stack is located one page after MQD. */=0A=
+       /*=0A=
+        * Control stack is located one page after the MQD. allocate_mqd()=
=0A=
+        * sized this region from qp->ctl_stack_size (page aligned). On the=
=0A=
+        * CRIU restore path ctl_stack_size is derived from the untrusted,=
=0A=
+        * user-supplied q_data->ctl_stack_size and, on multi-XCC parts, fr=
om=0A=
+        * a divisor that may not match the one used to size the allocation=
.=0A=
+        * Bound the copy to the allocated region so a malicious checkpoint=
=0A=
+        * cannot write past the MQD buffer object into adjacent kernel=0A=
+        * (TTM/GTT) memory.=0A=
+        */=0A=
        ctl_stack =3D (void *)((uintptr_t)*mqd + AMDGPU_GPU_PAGE_SIZE);=0A=
+       if (ctl_stack_size > qp->ctl_stack_size) {=0A=
+               pr_err_ratelimited("ctl_stack_size 0x%x exceeds allocated 0=
x%x, clamping\n",=0A=
+                                  ctl_stack_size, qp->ctl_stack_size);=0A=
+               ctl_stack_size =3D qp->ctl_stack_size;=0A=
+       }=0A=
        memcpy(ctl_stack, ctl_stack_src, ctl_stack_size);=0A=
=0A=
        m->cp_hqd_pq_doorbell_control =3D=0A=
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c b/drive=
rs/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c=0A=
index 071f956f183c..7c4f89cf283c 100644=0A=
--- a/drivers/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c=0A=
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c=0A=
@@ -27,6 +27,7 @@=0A=
 #include "kfd_device_queue_manager.h"=0A=
 #include "kfd_priv.h"=0A=
 #include "kfd_kernel_queue.h"=0A=
+#include "kfd_topology.h"=0A=
 #include "amdgpu_amdkfd.h"=0A=
 #include "amdgpu_reset.h"=0A=
=0A=
@@ -984,7 +985,9 @@ int kfd_criu_restore_queue(struct kfd_process *p,=0A=
 {=0A=
        uint8_t *mqd, *ctl_stack, *q_extra_data =3D NULL;=0A=
        struct kfd_criu_queue_priv_data *q_data;=0A=
+       struct kfd_topology_device *topo_dev;=0A=
        struct kfd_process_device *pdd;=0A=
+       uint32_t max_ctl_stack_size, num_xcc;=0A=
        uint64_t q_extra_data_size;=0A=
        struct queue_properties qp;=0A=
        unsigned int queue_id;=0A=
@@ -1032,6 +1035,29 @@ int kfd_criu_restore_queue(struct kfd_process *p,=0A=
                goto exit;=0A=
        }=0A=
=0A=
+       /*=0A=
+        * q_data->ctl_stack_size is user-supplied and is consumed across a=
ll=0A=
+        * XCCs of the node when restoring the MQD control stack. Reject si=
zes=0A=
+        * that could not have come from a valid checkpoint before sizing a=
ny=0A=
+        * allocation or copy, so a bogus value can never drive an=0A=
+        * out-of-bounds control stack write during MQD restore.=0A=
+        */=0A=
+       num_xcc =3D NUM_XCC(pdd->dev->xcc_mask);=0A=
+       topo_dev =3D kfd_topology_device_by_id(pdd->dev->id);=0A=
+       if (!num_xcc || !topo_dev) {=0A=
+               ret =3D -EINVAL;=0A=
+               goto exit;=0A=
+       }=0A=
+       max_ctl_stack_size =3D ALIGN(topo_dev->node_props.ctl_stack_size, P=
AGE_SIZE);=0A=
+       if (q_data->type =3D=3D KFD_QUEUE_TYPE_COMPUTE &&=0A=
+           q_data->ctl_stack_size > (uint64_t)max_ctl_stack_size * num_xcc=
) {=0A=
+               pr_err("CRIU restore ctl_stack_size 0x%x exceeds max 0x%llx=
\n",=0A=
+                      q_data->ctl_stack_size,=0A=
+                      (uint64_t)max_ctl_stack_size * num_xcc);=0A=
+               ret =3D -EINVAL;=0A=
+               goto exit;=0A=
+       }=0A=
+=0A=
        /*=0A=
         * data stored in this order:=0A=
         * mqd[xcc0], mqd[xcc1],..., ctl_stack[xcc0], ctl_stack[xcc1]...=0A=
--=0A=
2.43.0=0A=
=0A=
