Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5CC5AC5B572
	for <amd-gfx@archiver.kernel.org>; Mon, 17 Aug 2026 15:36:45 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F24AE10E871;
	Mon, 17 Aug 2026 15:36:44 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="llc0jmwc";
	dkim-atps=neutral
Received: from BN1PR04CU002.outbound.protection.outlook.com
 (mail-eastus2azon11010011.outbound.protection.outlook.com [52.101.56.11])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CF0F910E871
 for <amd-gfx@lists.freedesktop.org>; Mon, 17 Aug 2026 15:36:43 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Nj3xFXg98IhC828j0DING2Fe7YYzJMQj1IgOkTYxHAH/1FmqUEBFp67tOuqLyDWVgMNHEdNSTMNB047gKa0/f5FgsjaH0b1oP1/W7j3SgYHz5D5SfXvt7tSVY8EDL8z2+nFCypPOWpatJIFOyrEY9FcQ8kRsGW5/j6ZHjCqY3DGj+mee2iJZ86HKE2ua7FJm79Z4i5aP9odlrb6cEHtryRZGuyu/RgMrZjfOwG4p8j14iW7kSsUGjih21g8l5bGalat1H3tbVcQXvb5uV4HwYg+94ohi2Z2ELWbIQ3RiHFvS7UDN19VTq3nW9zk3T5nz0DtfuTC4z6gBXAoM6kkGtw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3osVOBnzXAd43LsuNux69D0f1gz1ECEhIWnjLEdtIzs=;
 b=n2wcf0hqxl7OpdEjCDGDMqRULewCvnufpvKcSQb3mLKnq/bos7DfmhhqmJ1gq45MO9AakWKVT5sWttKfmxQMxEsv8zYmGd7/Rti/vgu7cwxQxIt7B+xn911sWSC9fUt8AAN0wSuF243rdNe5xAjcQQ+62NGKWqqEG27JBPRCPzXqHHH4tyX9Eqiel5vrvKU2zeUCII2fvpVXMAjahsC4QH+D5uFi9dT6+JInpBPR1oPEk0wr+tSvp8BLJ8JAYy2KW6d3hwfFWVcgADvm5CWUjlj2zkhYYS/aVajzyh+Z8eOpg65RgX9Vz5CHFjDdQivBSwSjFTT9MH4dUBxdVO3WPA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3osVOBnzXAd43LsuNux69D0f1gz1ECEhIWnjLEdtIzs=;
 b=llc0jmwcWX+xyMIIuqrX0kSOuo/n+XEm9XCGZIJ5yqyfrTR4J+AWLDbeeKLzvXQ2cy6v4UPKCiCMfPMTFms6L+hwajxbIVc2tiB/g30kDVtYf9mi7/izOLJUqGwwcwxT+E14N39wmFQyEka5eoxOLgksOl5KQ1qGmvqD5uG2hO4=
Received: from SA1PR12MB8600.namprd12.prod.outlook.com (2603:10b6:806:257::19)
 by IA0PR12MB8254.namprd12.prod.outlook.com (2603:10b6:208:408::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.315.17; Mon, 17 Aug
 2026 15:36:38 +0000
Received: from SA1PR12MB8600.namprd12.prod.outlook.com
 ([fe80::96bd:d94:4dac:b1d0]) by SA1PR12MB8600.namprd12.prod.outlook.com
 ([fe80::96bd:d94:4dac:b1d0%5]) with mapi id 15.21.0315.008; Mon, 17 Aug 2026
 15:36:37 +0000
From: "Marioukhine, Vladimir" <Vladimir.Marioukhine@amd.com>
To: "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
CC: "Deucher, Alexander" <Alexander.Deucher@amd.com>
Subject: RE: [PATCH 2/2] drm/amdkfd: implement restore_mqd callbacks for
 GFX12/12.1
Thread-Topic: [PATCH 2/2] drm/amdkfd: implement restore_mqd callbacks for
 GFX12/12.1
Thread-Index: Ad0rRP4kFISiQg/GR8m9zNZ9FUrsfADGS+MQ
Date: Mon, 17 Aug 2026 15:36:37 +0000
Message-ID: <SA1PR12MB8600CBE6F2B9B8D6BBEBEA349FA72@SA1PR12MB8600.namprd12.prod.outlook.com>
References: <SA1PR12MB860060695EBBCE15BD0FCBBA9FDB2@SA1PR12MB8600.namprd12.prod.outlook.com>
In-Reply-To: <SA1PR12MB860060695EBBCE15BD0FCBBA9FDB2@SA1PR12MB8600.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Enabled=True;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SetDate=2026-08-13T16:58:22.0000000Z;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Name=AMD General
 v26; MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_ContentBits=3;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Method=Standard
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR12MB8600:EE_|IA0PR12MB8254:EE_
x-ms-office365-filtering-correlation-id: 70a05164-7f20-4c1a-ff2d-08defc755393
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|1800799024|366016|23010399003|38070700021|10067099003|56012099006|11063799006|8096899003|18002099003|22082099003;
x-microsoft-antispam-message-info: H717uVQnoYU92DtejDs5+5LzUI5DqOVNVPSxkXtyyF5n5x4Dzat4hxPg3oTJ1kWF5Q5HHMtVoX8Nor3wAKkoGZ4Fvl+tMYSxN4CpJHEPPy/4GzZVvizAyPtEMis2zVRbD4ULL0J9ZKi47RfNuHiH4fE9F+tbOrK42XF1sYfESDvoeWo6tUIxn2nCFPG6vpKnhQnos9U9LQaAfoGkG5a/eQpKlR2y4eHX+5gwXD+n9s/1YLRI84/znO1jfCsRPyHSvjBK+PqRmIv7LxsA732IJph3+1uvr+PiE+oXom7cNc4+C6rFy9cZmyk2lEx7HTKwvKtajJFgGT9ZlxLRtavU0ZXtDj20cS7d5Gq8Jsn2jcFnCGEVlQbLUOon8KA4xv+QL5OcVQut+wjqzf/5O4iE7C0cMLGl5/NKIIN+Cy196ZMBneUijKxjEnIENw0QGFBtyL/IWHlwVymfVRyoAKD5brveJB7/mU8ix9KuyJeJtRAhRsoXQEoch5XaVWxoVeVGOnu/spcDlng95/tH7pozCYvFYrbVtG3eNmaXkd5lula/XNzswAzaVFj/27Rl01mBhTWT61Fy3TXNs3qT3VgDgeNtqZlHzbfy90XrZkcqCxANy1Nioh0TmI4uBAB3nOCKPXaVyC8xmlxYGslMOWzV3WSYo7Y53mhFRUWH8EvH451/t0qbobAtMXlqZeepFQ/sj6pB8EfWdr09/c4iWGHlH8wVZ2OcxDGtIZYGECsQNcg=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SA1PR12MB8600.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(23010399003)(38070700021)(10067099003)(56012099006)(11063799006)(8096899003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?aBa79v4BHHV1LcqX24ojZpr7UJ2kdZckdXvZ1lowyQFJMzIzQUoTucgIg3nZ?=
 =?us-ascii?Q?Nf+ZmjVPYQOFRUAPpk2R+IUW+Hl0sUmX+phSyKhCY7/SFY1VYPU9+/PH1q8t?=
 =?us-ascii?Q?1x6Vr+AvJiwgNCgmK2U0qD6fHIcxdIX/x9+VqbioFcXJCL/6j/efywo2rZRR?=
 =?us-ascii?Q?aQsSJyn7DXMfVUX5wlbHH3HXtjlJFcrBCuoNbGbuC7UHCu4UTpImKJvqFlCI?=
 =?us-ascii?Q?+wfEhHhgKsu3FlLY9lcgdx9HvKSyyhK6AcKOyoRACXLEelxQngdY5B6FymgW?=
 =?us-ascii?Q?llU53RQijjxlm0KiDqRWHBKW8v24kX0ZXbWpNum5YXLGtYvadtXYqj66Z7QN?=
 =?us-ascii?Q?V1eZfMXF4CZ2rL4q78lFhh8KvVe5iRVWpMAA1mOe/Hi4xO7JoiKt4bsJe8vF?=
 =?us-ascii?Q?0aco/MSbVUWqyzZb1q64ozpdjyGSLN1wBhQ3sV1jVFAIuS0jOjsqd8/4k4FO?=
 =?us-ascii?Q?XiVBMTyeHZ2Lj8Sm2e736f+mqsCaJfvlbG70vYcoju50U48xt1q5IrHYjzC7?=
 =?us-ascii?Q?8ykhDbmDFCgmDdEvKGribDMubkTMHsZDPIq9F6mEvFOkSfapv+c0D2TUONvd?=
 =?us-ascii?Q?DdM6vAZLNLSM/Soi/otuInHgzr+371kT8fxqlluBQX/NVa89/vtGdL3Q6PQl?=
 =?us-ascii?Q?zIREguIG4gsb+peyvyN1eglPs42RWBV2DFmFE4BHAg9pl2ZgFtut8cbsaHKP?=
 =?us-ascii?Q?jKECZ4QFCNjbMXV0AQEzdT9NRY/D1ZWHqWFEW1bYps5M29OBeqoqb2BOhd5e?=
 =?us-ascii?Q?e1djcN7fONsgx+rhKQzT2AnObZwe1DhtAtHMDN3LbKkQEFHBmKYnY37+h6nr?=
 =?us-ascii?Q?I9kmSlSTZrVONYppVIdAEUDbbrGLhlJ6ng6tpu9i7lW7tmDw9FzUGE+lxWZ4?=
 =?us-ascii?Q?cYanmmKfIPcYvPuz2At1RkY/mCZFyPOf7nwgZUnFPAnMzVqAsJJKz+5tmg+F?=
 =?us-ascii?Q?ehAsSRR6UtBDavHg62CyUv1e5SMSTTUEp88VjD68wlqi9UikhDj1nm9t6s8P?=
 =?us-ascii?Q?CR8ZD1g9er9EK9n7050tFSmuapHUL/Gl5B+klGx+KvQ/pSgNXIAiLqgGzlUL?=
 =?us-ascii?Q?4aVny3ykUdsKV5dQUjNJrsU0LZeDT7G5uQSW7U7Yw2izCRF7/jwtNXCz7pel?=
 =?us-ascii?Q?L0wjPJuu6aLq3i/AhO3jLs6Ta2Es0hzIcJCrNjmViq59uUMK72ZD1+7fcbGs?=
 =?us-ascii?Q?dEpKMMK5+8Ve0gaAmTGQe1h/4G4Ji8DfHOL4EqMI9np+dTjfyU8MGVfJ6GY8?=
 =?us-ascii?Q?z5F8WNEIHIwGORC2TtZQNYHevpyGM0p+jvti55s/M19qzMmdvVmM9fDUYD5i?=
 =?us-ascii?Q?oU+f1FUsdA1CcKOU+GVwYaAzn/W79G+Vnf4MW7WOysj+zrL10V/syq8ItYa5?=
 =?us-ascii?Q?iNJqGJe1PZBs019vzskg/OfG/ZcPx8t9ivAoeVoE3vqqr1D5QZOByEc3ldZZ?=
 =?us-ascii?Q?ednUQgjEL9SQ6XiAQZjOpwnCNMZ9oaLhWcs+44P2ZwSKgzSW1fPTzgR4g88v?=
 =?us-ascii?Q?b0C01l1KwB8u2tupL2BXbHmfBugsPH9Jc3QlX+qR7UgTLo1hch8RzP9tp/+Y?=
 =?us-ascii?Q?PKuhzxds0wIKIggJJBbQSn93ux+0dqKG+8JkJKae8RFNKziNlpI7fonJtLr6?=
 =?us-ascii?Q?WpUlSVzrSE07WwNADQQDx9NCBeGcbchVXkcFDVo4aSfoMZzTzDM0tRcSnT04?=
 =?us-ascii?Q?bjNpyx2v+tT0uTjVVECOS6COLnGNyy72Q+L1gxcVahSeK58o?=
Content-Type: multipart/alternative;
 boundary="_000_SA1PR12MB8600CBE6F2B9B8D6BBEBEA349FA72SA1PR12MB8600namp_"
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA1PR12MB8600.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 70a05164-7f20-4c1a-ff2d-08defc755393
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Aug 2026 15:36:37.6689 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: X5MxDIa/oumAOfzBLefLkJwBhWAVpnsApOEHuEBcgbPKM4a0ZY/qNFuUHih2NnPqhpJ4hgHHahO7/YMuq/iB6w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8254
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

--_000_SA1PR12MB8600CBE6F2B9B8D6BBEBEA349FA72SA1PR12MB8600namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

AMD General


Ping,



Can I get a review on this change please?



Kind regards,

Vladimir

From: Marioukhine, Vladimir
Sent: Thursday, August 13, 2026 12:59 PM
To: amd-gfx@lists.freedesktop.org
Cc: Deucher, Alexander <Alexander.Deucher@amd.com>
Subject: [PATCH 2/2] drm/amdkfd: implement restore_mqd callbacks for GFX12/=
12.1

kfd_mqd_manager_v12.c (GFX 12.0) and kfd_mqd_manager_v12_1.c (GFX 12.1)
do not implement restore_mqd or checkpoint_mqd callbacks, leaving the
function pointers NULL and making CRIU restore non-functional on GFX12.

Implement restore_mqd and checkpoint_mqd for both compute and SDMA
queues in kfd_mqd_manager_v12.c and kfd_mqd_manager_v12_1.c, modeled
after the GFX 11 implementation. Only restore_mqd is registered for
now; checkpoint_mqd registration is deferred until get_checkpoint_info
is implemented to avoid silently dropping the CWSR control stack.

Fixes: 48f0bdf4e38e ("drm/amdkfd: Added MQD manager files for GFX12.")
Fixes: 01bbc4a4b947 ("drm/amdkfd: Add MQD manager for GFX 12.1.0")
Signed-off-by: Vladimir Marioukhine <Vladimir.Marioukhine@amd.com<mailto:Vl=
adimir.Marioukhine@amd.com>>
---
drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v12.c   | 87 +++++++++++++++++++=
++
drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v12_1.c | 87 +++++++++++++++++++=
++
2 files changed, 174 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v12.c b/drivers/gpu=
/drm/amd/amdkfd/kfd_mqd_manager_v12.c
index 7c387fa90076..a9a2dc4a0a75 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v12.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v12.c
@@ -380,6 +380,87 @@ static int debugfs_show_mqd_sdma(struct seq_file *m, v=
oid *data)

 #endif

+static void checkpoint_mqd(struct mqd_manager *mm, void *mqd,
+                                              void *mqd_dst, void *ctl_sta=
ck_dst)
+{
+            /*
+            * GFXv12 control stack checkpoint is not yet implemented;
+            * get_checkpoint_info is unset, so ctl_stack_dst is always unu=
sed.
+            */
+            struct v12_compute_mqd *m;
+
+            m =3D get_mqd(mqd);
+
+            memcpy(mqd_dst, m, sizeof(struct v12_compute_mqd));
+}
+
+static void restore_mqd(struct mqd_manager *mm, void **mqd,
+                                          struct kfd_mem_obj *mqd_mem_obj,=
 uint64_t *gart_addr,
+                                          struct queue_properties *qp, con=
st void *mqd_src,
+                                          const void *ctl_stack_src, const=
 u32 ctl_stack_size)
+{
+            u64 addr;
+            struct v12_compute_mqd *m;
+
+            if (ctl_stack_size)
+                           pr_debug("GFX12 ctl stack restore not supported=
\n");
+
+            m =3D (struct v12_compute_mqd *)mqd_mem_obj->cpu_ptr;
+            addr =3D mqd_mem_obj->gpu_addr;
+
+            memset(m, 0, AMDGPU_MQD_SIZE_ALIGN(mm->mqd_size));
+            memcpy(m, mqd_src, sizeof(*m));
+
+            *mqd =3D m;
+            if (gart_addr)
+                           *gart_addr =3D addr;
+
+            m->cp_hqd_pq_doorbell_control =3D
+                           qp->doorbell_off << CP_HQD_PQ_DOORBELL_CONTROL_=
_DOORBELL_OFFSET__SHIFT;
+            pr_debug("cp_hqd_pq_doorbell_control 0x%x\n", m->cp_hqd_pq_doo=
rbell_control);
+
+            qp->is_active =3D 0;
+}
+
+static void checkpoint_mqd_sdma(struct mqd_manager *mm, void *mqd,
+                                                         void *mqd_dst, vo=
id *ctl_stack_dst)
+{
+            struct v12_sdma_mqd *m;
+
+            m =3D get_sdma_mqd(mqd);
+
+            memcpy(mqd_dst, m, sizeof(struct v12_sdma_mqd));
+}
+
+static void restore_mqd_sdma(struct mqd_manager *mm, void **mqd,
+                                               struct kfd_mem_obj *mqd_mem=
_obj, uint64_t *gart_addr,
+                                               struct queue_properties *qp=
,
+                                               const void *mqd_src,
+                                               const void *ctl_stack_src,
+                                               const u32 ctl_stack_size)
+{
+            u64 addr;
+            struct v12_sdma_mqd *m;
+
+            if (ctl_stack_size)
+                           pr_debug("GFX12 ctl stack restore not supported=
\n");
+
+            m =3D (struct v12_sdma_mqd *)mqd_mem_obj->cpu_ptr;
+            addr =3D mqd_mem_obj->gpu_addr;
+
+            memset(m, 0, AMDGPU_MQD_SIZE_ALIGN(mm->mqd_size));
+            memcpy(m, mqd_src, sizeof(*m));
+
+            m->sdmax_rlcx_doorbell_offset =3D
+                           qp->doorbell_off << SDMA0_QUEUE0_DOORBELL_OFFSE=
T__OFFSET__SHIFT;
+
+            *mqd =3D m;
+            if (gart_addr)
+                           *gart_addr =3D addr;
+
+            qp->is_active =3D 0;
+}
+
struct mqd_manager *mqd_manager_init_v12(enum KFD_MQD_TYPE type,
                             struct kfd_node *dev)
{
@@ -407,6 +488,7 @@ struct mqd_manager *mqd_manager_init_v12(enum KFD_MQD_T=
YPE type,
                             mqd->mqd_size =3D sizeof(struct v12_compute_mq=
d);
                             mqd->get_wave_state =3D get_wave_state;
                             mqd->mqd_stride =3D kfd_mqd_stride;
+                           mqd->restore_mqd =3D restore_mqd;
#if defined(CONFIG_DEBUG_FS)
                             mqd->debugfs_show_mqd =3D debugfs_show_mqd;
#endif
@@ -453,6 +535,7 @@ struct mqd_manager *mqd_manager_init_v12(enum KFD_MQD_T=
YPE type,
                             mqd->is_occupied =3D kfd_is_occupied_sdma;
                             mqd->mqd_size =3D sizeof(struct v12_sdma_mqd);
                             mqd->mqd_stride =3D kfd_mqd_stride;
+                           mqd->restore_mqd =3D restore_mqd_sdma;
#if defined(CONFIG_DEBUG_FS)
                             mqd->debugfs_show_mqd =3D debugfs_show_mqd_sdm=
a;
#endif
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v12_1.c b/drivers/g=
pu/drm/amd/amdkfd/kfd_mqd_manager_v12_1.c
index 431a940f91f3..daca9e39468e 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v12_1.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v12_1.c
@@ -641,6 +641,87 @@ static int debugfs_show_mqd_sdma(struct seq_file *m, v=
oid *data)

 #endif

+static void checkpoint_mqd_v12_1(struct mqd_manager *mm, void *mqd,
+                                                         void *mqd_dst, vo=
id *ctl_stack_dst)
+{
+            /*
+            * GFXv12 control stack checkpoint is not yet implemented;
+            * get_checkpoint_info is unset, so ctl_stack_dst is always unu=
sed.
+            */
+            struct v12_1_compute_mqd *m;
+
+            m =3D get_mqd(mqd);
+
+            memcpy(mqd_dst, m, sizeof(struct v12_1_compute_mqd));
+}
+
+static void restore_mqd_v12_1(struct mqd_manager *mm, void **mqd,
+                                                struct kfd_mem_obj *mqd_me=
m_obj, uint64_t *gart_addr,
+                                                struct queue_properties *q=
p, const void *mqd_src,
+                                                const void *ctl_stack_src,=
 const u32 ctl_stack_size)
+{
+            u64 addr;
+            struct v12_1_compute_mqd *m;
+
+            if (ctl_stack_size)
+                           pr_debug("GFX12 ctl stack restore not supported=
\n");
+
+            m =3D (struct v12_1_compute_mqd *)mqd_mem_obj->cpu_ptr;
+            addr =3D mqd_mem_obj->gpu_addr;
+
+            memset(m, 0, AMDGPU_MQD_SIZE_ALIGN(mm->mqd_size));
+            memcpy(m, mqd_src, sizeof(*m));
+
+            *mqd =3D m;
+            if (gart_addr)
+                           *gart_addr =3D addr;
+
+            m->cp_hqd_pq_doorbell_control =3D
+                           qp->doorbell_off << CP_HQD_PQ_DOORBELL_CONTROL_=
_DOORBELL_OFFSET__SHIFT;
+            pr_debug("cp_hqd_pq_doorbell_control 0x%x\n", m->cp_hqd_pq_doo=
rbell_control);
+
+            qp->is_active =3D 0;
+}
+
+static void checkpoint_mqd_sdma_v12_1(struct mqd_manager *mm, void *mqd,
+                                                               void *mqd_d=
st, void *ctl_stack_dst)
+{
+            struct v12_sdma_mqd *m;
+
+            m =3D get_sdma_mqd(mqd);
+
+            memcpy(mqd_dst, m, sizeof(struct v12_sdma_mqd));
+}
+
+static void restore_mqd_sdma_v12_1(struct mqd_manager *mm, void **mqd,
+                                                            struct kfd_mem=
_obj *mqd_mem_obj, uint64_t *gart_addr,
+                                                            struct queue_p=
roperties *qp,
+                                                            const void *mq=
d_src,
+                                                            const void *ct=
l_stack_src,
+                                                            const u32 ctl_=
stack_size)
+{
+            u64 addr;
+            struct v12_sdma_mqd *m;
+
+            if (ctl_stack_size)
+                           pr_debug("GFX12 ctl stack restore not supported=
\n");
+
+            m =3D (struct v12_sdma_mqd *)mqd_mem_obj->cpu_ptr;
+            addr =3D mqd_mem_obj->gpu_addr;
+
+            memset(m, 0, AMDGPU_MQD_SIZE_ALIGN(mm->mqd_size));
+            memcpy(m, mqd_src, sizeof(*m));
+
+            m->sdmax_rlcx_doorbell_offset =3D
+                           qp->doorbell_off << SDMA0_QUEUE0_DOORBELL_OFFSE=
T__OFFSET__SHIFT;
+
+            *mqd =3D m;
+            if (gart_addr)
+                           *gart_addr =3D addr;
+
+            qp->is_active =3D 0;
+}
+
struct mqd_manager *mqd_manager_init_v12_1(enum KFD_MQD_TYPE type,
                             struct kfd_node *dev)
{
@@ -668,6 +749,7 @@ struct mqd_manager *mqd_manager_init_v12_1(enum KFD_MQD=
_TYPE type,
                             mqd->mqd_size =3D sizeof(struct v12_1_compute_=
mqd);
                             mqd->get_wave_state =3D get_wave_state_v12_1;
                             mqd->mqd_stride =3D kfd_mqd_stride;
+                           mqd->restore_mqd =3D restore_mqd_v12_1;
#if defined(CONFIG_DEBUG_FS)
                             mqd->debugfs_show_mqd =3D debugfs_show_mqd;
#endif
@@ -714,6 +796,7 @@ struct mqd_manager *mqd_manager_init_v12_1(enum KFD_MQD=
_TYPE type,
                             mqd->is_occupied =3D kfd_is_occupied_sdma;
                             mqd->mqd_size =3D sizeof(struct v12_sdma_mqd);
                             mqd->mqd_stride =3D kfd_mqd_stride;
+                           mqd->restore_mqd =3D restore_mqd_sdma_v12_1;
#if defined(CONFIG_DEBUG_FS)
                             mqd->debugfs_show_mqd =3D debugfs_show_mqd_sdm=
a;
#endif


--_000_SA1PR12MB8600CBE6F2B9B8D6BBEBEA349FA72SA1PR12MB8600namp_
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
<!--[if gte mso 9]><xml>
<w:WordDocument>
<w:DontUseAdvancedTypographyReadingMail/>
<w:DontUseJustificationAdvancedTypographyReadingMail/>
<w:DontUseHyphenationAdvancedTypographyReadingMail/>
</w:WordDocument>
</xml><![endif]--><style><!--
/* Font Definitions */
@font-face
	{font-family:"Cambria Math";
	panose-1:2 4 5 3 5 4 6 3 2 4;}
@font-face
	{font-family:Calibri;
	panose-1:2 15 5 2 2 2 4 3 2 4;}
@font-face
	{font-family:Aptos;}
/* Style Definitions */
p.MsoNormal, li.MsoNormal, div.MsoNormal
	{margin:0in;
	font-size:12.0pt;
	font-family:"Aptos",sans-serif;
	mso-ligatures:standardcontextual;}
a:link, span.MsoHyperlink
	{mso-style-priority:99;
	color:#467886;
	text-decoration:underline;}
p.MsoPlainText, li.MsoPlainText, div.MsoPlainText
	{mso-style-priority:99;
	mso-style-link:"Plain Text Char";
	margin:0in;
	font-size:11.0pt;
	font-family:"Calibri",sans-serif;
	mso-ligatures:standardcontextual;}
span.EmailStyle20
	{mso-style-type:personal-reply;
	font-family:"Aptos",sans-serif;
	color:windowtext;}
span.PlainTextChar
	{mso-style-name:"Plain Text Char";
	mso-style-priority:99;
	mso-style-link:"Plain Text";
	font-family:"Calibri",sans-serif;
	mso-ligatures:standardcontextual;}
.MsoChpDefault
	{mso-style-type:export-only;
	font-size:10.0pt;
	mso-ligatures:none;}
@page WordSection1
	{size:8.5in 11.0in;
	margin:1.0in 1.0in 1.0in 1.0in;}
div.WordSection1
	{page:WordSection1;}
--></style><!--[if gte mso 9]><xml>
<o:shapedefaults v:ext=3D"edit" spidmax=3D"1026" />
</xml><![endif]--><!--[if gte mso 9]><xml>
<o:shapelayout v:ext=3D"edit">
<o:idmap v:ext=3D"edit" data=3D"1" />
</o:shapelayout></xml><![endif]-->
</head>
<body lang=3D"EN-US" link=3D"#467886" vlink=3D"#96607D" style=3D"word-wrap:=
break-word">
<p style=3D"font-family:Calibri;font-size:10pt;color:#0000FF;margin:5pt;fon=
t-style:normal;font-weight:normal;text-decoration:none;" align=3D"Left">
AMD General<br>
</p>
<br>
<div>
<div class=3D"WordSection1">
<p class=3D"MsoPlainText">Ping,<o:p></o:p></p>
<p class=3D"MsoPlainText"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoPlainText">Can I get a review on this change please?<o:p></o=
:p></p>
<p class=3D"MsoPlainText"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoPlainText">Kind regards,<o:p></o:p></p>
<p class=3D"MsoPlainText">Vladimir<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<div>
<div style=3D"border:none;border-top:solid #E1E1E1 1.0pt;padding:3.0pt 0in =
0in 0in">
<p class=3D"MsoNormal"><b><span style=3D"font-size:11.0pt;font-family:&quot=
;Calibri&quot;,sans-serif;mso-ligatures:none">From:</span></b><span style=
=3D"font-size:11.0pt;font-family:&quot;Calibri&quot;,sans-serif;mso-ligatur=
es:none"> Marioukhine, Vladimir
<br>
<b>Sent:</b> Thursday, August 13, 2026 12:59 PM<br>
<b>To:</b> amd-gfx@lists.freedesktop.org<br>
<b>Cc:</b> Deucher, Alexander &lt;Alexander.Deucher@amd.com&gt;<br>
<b>Subject:</b> [PATCH 2/2] drm/amdkfd: implement restore_mqd callbacks for=
 GFX12/12.1<o:p></o:p></span></p>
</div>
</div>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">kfd_mqd_manager_v12.c (GFX 12.0) and kfd_mqd_manager=
_v12_1.c (GFX 12.1)<o:p></o:p></p>
<p class=3D"MsoNormal">do not implement restore_mqd or checkpoint_mqd callb=
acks, leaving the<o:p></o:p></p>
<p class=3D"MsoNormal">function pointers NULL and making CRIU restore non-f=
unctional on GFX12.<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">Implement restore_mqd and checkpoint_mqd for both co=
mpute and SDMA<o:p></o:p></p>
<p class=3D"MsoNormal">queues in kfd_mqd_manager_v12.c and kfd_mqd_manager_=
v12_1.c, modeled<o:p></o:p></p>
<p class=3D"MsoNormal">after the GFX 11 implementation. Only restore_mqd is=
 registered for<o:p></o:p></p>
<p class=3D"MsoNormal">now; checkpoint_mqd registration is deferred until g=
et_checkpoint_info<o:p></o:p></p>
<p class=3D"MsoNormal">is implemented to avoid silently dropping the CWSR c=
ontrol stack.<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">Fixes: 48f0bdf4e38e (&quot;drm/amdkfd: Added MQD man=
ager files for GFX12.&quot;)<o:p></o:p></p>
<p class=3D"MsoNormal">Fixes: 01bbc4a4b947 (&quot;drm/amdkfd: Add MQD manag=
er for GFX 12.1.0&quot;)<o:p></o:p></p>
<p class=3D"MsoNormal">Signed-off-by: Vladimir Marioukhine &lt;<a href=3D"m=
ailto:Vladimir.Marioukhine@amd.com">Vladimir.Marioukhine@amd.com</a>&gt;<o:=
p></o:p></p>
<p class=3D"MsoNormal">---<o:p></o:p></p>
<p class=3D"MsoNormal">drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v12.c&nbs=
p;&nbsp; | 87 +++++++++++++++++++++<o:p></o:p></p>
<p class=3D"MsoNormal">drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v12_1.c |=
 87 +++++++++++++++++++++<o:p></o:p></p>
<p class=3D"MsoNormal">2 files changed, 174 insertions(+)<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_mqd_mana=
ger_v12.c b/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v12.c<o:p></o:p></p>
<p class=3D"MsoNormal">index 7c387fa90076..a9a2dc4a0a75 100644<o:p></o:p></=
p>
<p class=3D"MsoNormal">--- a/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v12=
.c<o:p></o:p></p>
<p class=3D"MsoNormal">+++ b/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v12=
.c<o:p></o:p></p>
<p class=3D"MsoNormal">@@ -380,6 +380,87 @@ static int debugfs_show_mqd_sdm=
a(struct seq_file *m, void *data)<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">&nbsp;#endif<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">+static void checkpoint_mqd(struct mqd_manager *mm, =
void *mqd,<o:p></o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; void *mqd_=
dst, void *ctl_stack_dst)<o:p></o:p></p>
<p class=3D"MsoNormal">+{<o:p></o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; /*<o:p></o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; * GFXv12 control stack checkpoint is not yet implemented;<o=
:p></o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; * get_checkpoint_info is unset, so ctl_stack_dst is always =
unused.<o:p></o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; */<o:p></o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; struct v12_compute_mqd *m;<o:p></o:p></p>
<p class=3D"MsoNormal">+<o:p></o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; m =3D get_mqd(mqd);<o:p></o:p></p>
<p class=3D"MsoNormal">+<o:p></o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; memcpy(mqd_dst, m, sizeof(struct v12_compute_mqd));<o:p></o=
:p></p>
<p class=3D"MsoNormal">+}<o:p></o:p></p>
<p class=3D"MsoNormal">+<o:p></o:p></p>
<p class=3D"MsoNormal">+static void restore_mqd(struct mqd_manager *mm, voi=
d **mqd,<o:p></o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct kfd_mem_obj *mqd_mem_o=
bj, uint64_t *gart_addr,<o:p></o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct queue_properties *qp, =
const void *mqd_src,<o:p></o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; const void *ctl_stack_src, co=
nst u32 ctl_stack_size)<o:p></o:p></p>
<p class=3D"MsoNormal">+{<o:p></o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; u64 addr;<o:p></o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; struct v12_compute_mqd *m;<o:p></o:p></p>
<p class=3D"MsoNormal">+<o:p></o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; if (ctl_stack_size)<o:p></o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; pr_debug(&quot;GFX12 ctl stack restore not s=
upported\n&quot;);<o:p></o:p></p>
<p class=3D"MsoNormal">+<o:p></o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; m =3D (struct v12_compute_mqd *)mqd_mem_obj-&gt;cpu_ptr;<o:=
p></o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; addr =3D mqd_mem_obj-&gt;gpu_addr;<o:p></o:p></p>
<p class=3D"MsoNormal">+<o:p></o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; memset(m, 0, AMDGPU_MQD_SIZE_ALIGN(mm-&gt;mqd_size));<o:p><=
/o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; memcpy(m, mqd_src, sizeof(*m));<o:p></o:p></p>
<p class=3D"MsoNormal">+<o:p></o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; *mqd =3D m;<o:p></o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; if (gart_addr)<o:p></o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; *gart_addr =3D addr;<o:p></o:p></p>
<p class=3D"MsoNormal">+<o:p></o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; m-&gt;cp_hqd_pq_doorbell_control =3D<o:p></o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; qp-&gt;doorbell_off &lt;&lt; CP_HQD_PQ_DOORB=
ELL_CONTROL__DOORBELL_OFFSET__SHIFT;<o:p></o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; pr_debug(&quot;cp_hqd_pq_doorbell_control 0x%x\n&quot;, m-&=
gt;cp_hqd_pq_doorbell_control);<o:p></o:p></p>
<p class=3D"MsoNormal">+<o:p></o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; qp-&gt;is_active =3D 0;<o:p></o:p></p>
<p class=3D"MsoNormal">+}<o:p></o:p></p>
<p class=3D"MsoNormal">+<o:p></o:p></p>
<p class=3D"MsoNormal">+static void checkpoint_mqd_sdma(struct mqd_manager =
*mm, void *mqd,<o:p></o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; void *mqd_dst,=
 void *ctl_stack_dst)<o:p></o:p></p>
<p class=3D"MsoNormal">+{<o:p></o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; struct v12_sdma_mqd *m;<o:p></o:p></p>
<p class=3D"MsoNormal">+<o:p></o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; m =3D get_sdma_mqd(mqd);<o:p></o:p></p>
<p class=3D"MsoNormal">+<o:p></o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; memcpy(mqd_dst, m, sizeof(struct v12_sdma_mqd));<o:p></o:p>=
</p>
<p class=3D"MsoNormal">+}<o:p></o:p></p>
<p class=3D"MsoNormal">+<o:p></o:p></p>
<p class=3D"MsoNormal">+static void restore_mqd_sdma(struct mqd_manager *mm=
, void **mqd,<o:p></o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp; stru=
ct kfd_mem_obj *mqd_mem_obj, uint64_t *gart_addr,<o:p></o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp; stru=
ct queue_properties *qp,<o:p></o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp; cons=
t void *mqd_src,<o:p></o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp; cons=
t void *ctl_stack_src,<o:p></o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp; cons=
t u32 ctl_stack_size)<o:p></o:p></p>
<p class=3D"MsoNormal">+{<o:p></o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; u64 addr;<o:p></o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; struct v12_sdma_mqd *m;<o:p></o:p></p>
<p class=3D"MsoNormal">+<o:p></o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; if (ctl_stack_size)<o:p></o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; pr_debug(&quot;GFX12 ctl stack restore not s=
upported\n&quot;);<o:p></o:p></p>
<p class=3D"MsoNormal">+<o:p></o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; m =3D (struct v12_sdma_mqd *)mqd_mem_obj-&gt;cpu_ptr;<o:p><=
/o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; addr =3D mqd_mem_obj-&gt;gpu_addr;<o:p></o:p></p>
<p class=3D"MsoNormal">+<o:p></o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; memset(m, 0, AMDGPU_MQD_SIZE_ALIGN(mm-&gt;mqd_size));<o:p><=
/o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; memcpy(m, mqd_src, sizeof(*m));<o:p></o:p></p>
<p class=3D"MsoNormal">+<o:p></o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; m-&gt;sdmax_rlcx_doorbell_offset =3D<o:p></o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; qp-&gt;doorbell_off &lt;&lt; SDMA0_QUEUE0_DO=
ORBELL_OFFSET__OFFSET__SHIFT;<o:p></o:p></p>
<p class=3D"MsoNormal">+<o:p></o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; *mqd =3D m;<o:p></o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; if (gart_addr)<o:p></o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; *gart_addr =3D addr;<o:p></o:p></p>
<p class=3D"MsoNormal">+<o:p></o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; qp-&gt;is_active =3D 0;<o:p></o:p></p>
<p class=3D"MsoNormal">+}<o:p></o:p></p>
<p class=3D"MsoNormal">+<o:p></o:p></p>
<p class=3D"MsoNormal">struct mqd_manager *mqd_manager_init_v12(enum KFD_MQ=
D_TYPE type,<o:p></o:p></p>
<p class=3D"MsoNormal">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct kfd_node *dev)<o:p></o:p><=
/p>
<p class=3D"MsoNormal">{<o:p></o:p></p>
<p class=3D"MsoNormal">@@ -407,6 +488,7 @@ struct mqd_manager *mqd_manager_=
init_v12(enum KFD_MQD_TYPE type,<o:p></o:p></p>
<p class=3D"MsoNormal">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mqd-&gt;mqd_size =3D sizeof(struc=
t v12_compute_mqd);<o:p></o:p></p>
<p class=3D"MsoNormal">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mqd-&gt;get_wave_state =3D get_wa=
ve_state;<o:p></o:p></p>
<p class=3D"MsoNormal">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mqd-&gt;mqd_stride =3D kfd_mqd_st=
ride;<o:p></o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mqd-&gt;restore_mqd =3D restore_mqd;<o:p></o=
:p></p>
<p class=3D"MsoNormal">#if defined(CONFIG_DEBUG_FS)<o:p></o:p></p>
<p class=3D"MsoNormal">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mqd-&gt;debugfs_show_mqd =3D debu=
gfs_show_mqd;<o:p></o:p></p>
<p class=3D"MsoNormal">#endif<o:p></o:p></p>
<p class=3D"MsoNormal">@@ -453,6 +535,7 @@ struct mqd_manager *mqd_manager_=
init_v12(enum KFD_MQD_TYPE type,<o:p></o:p></p>
<p class=3D"MsoNormal">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mqd-&gt;is_occupied =3D kfd_is_oc=
cupied_sdma;<o:p></o:p></p>
<p class=3D"MsoNormal">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mqd-&gt;mqd_size =3D sizeof(struc=
t v12_sdma_mqd);<o:p></o:p></p>
<p class=3D"MsoNormal">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mqd-&gt;mqd_stride =3D kfd_mqd_st=
ride;<o:p></o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mqd-&gt;restore_mqd =3D restore_mqd_sdma;<o:=
p></o:p></p>
<p class=3D"MsoNormal">#if defined(CONFIG_DEBUG_FS)<o:p></o:p></p>
<p class=3D"MsoNormal">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mqd-&gt;debugfs_show_mqd =3D debu=
gfs_show_mqd_sdma;<o:p></o:p></p>
<p class=3D"MsoNormal">#endif<o:p></o:p></p>
<p class=3D"MsoNormal">diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_mqd_mana=
ger_v12_1.c b/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v12_1.c<o:p></o:p>=
</p>
<p class=3D"MsoNormal">index 431a940f91f3..daca9e39468e 100644<o:p></o:p></=
p>
<p class=3D"MsoNormal">--- a/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v12=
_1.c<o:p></o:p></p>
<p class=3D"MsoNormal">+++ b/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v12=
_1.c<o:p></o:p></p>
<p class=3D"MsoNormal">@@ -641,6 +641,87 @@ static int debugfs_show_mqd_sdm=
a(struct seq_file *m, void *data)<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">&nbsp;#endif<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">+static void checkpoint_mqd_v12_1(struct mqd_manager=
 *mm, void *mqd,<o:p></o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; void *mqd_dst,=
 void *ctl_stack_dst)<o:p></o:p></p>
<p class=3D"MsoNormal">+{<o:p></o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; /*<o:p></o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; * GFXv12 control stack checkpoint is not yet implemented;<o=
:p></o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; * get_checkpoint_info is unset, so ctl_stack_dst is always =
unused.<o:p></o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; */<o:p></o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; struct v12_1_compute_mqd *m;<o:p></o:p></p>
<p class=3D"MsoNormal">+<o:p></o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; m =3D get_mqd(mqd);<o:p></o:p></p>
<p class=3D"MsoNormal">+<o:p></o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; memcpy(mqd_dst, m, sizeof(struct v12_1_compute_mqd));<o:p><=
/o:p></p>
<p class=3D"MsoNormal">+}<o:p></o:p></p>
<p class=3D"MsoNormal">+<o:p></o:p></p>
<p class=3D"MsoNormal">+static void restore_mqd_v12_1(struct mqd_manager *m=
m, void **mqd,<o:p></o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
; struct kfd_mem_obj *mqd_mem_obj, uint64_t *gart_addr,<o:p></o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
; struct queue_properties *qp, const void *mqd_src,<o:p></o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
; const void *ctl_stack_src, const u32 ctl_stack_size)<o:p></o:p></p>
<p class=3D"MsoNormal">+{<o:p></o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; u64 addr;<o:p></o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; struct v12_1_compute_mqd *m;<o:p></o:p></p>
<p class=3D"MsoNormal">+<o:p></o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; if (ctl_stack_size)<o:p></o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; pr_debug(&quot;GFX12 ctl stack restore not s=
upported\n&quot;);<o:p></o:p></p>
<p class=3D"MsoNormal">+<o:p></o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; m =3D (struct v12_1_compute_mqd *)mqd_mem_obj-&gt;cpu_ptr;<=
o:p></o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; addr =3D mqd_mem_obj-&gt;gpu_addr;<o:p></o:p></p>
<p class=3D"MsoNormal">+<o:p></o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; memset(m, 0, AMDGPU_MQD_SIZE_ALIGN(mm-&gt;mqd_size));<o:p><=
/o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; memcpy(m, mqd_src, sizeof(*m));<o:p></o:p></p>
<p class=3D"MsoNormal">+<o:p></o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; *mqd =3D m;<o:p></o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; if (gart_addr)<o:p></o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; *gart_addr =3D addr;<o:p></o:p></p>
<p class=3D"MsoNormal">+<o:p></o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; m-&gt;cp_hqd_pq_doorbell_control =3D<o:p></o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; qp-&gt;doorbell_off &lt;&lt; CP_HQD_PQ_DOORB=
ELL_CONTROL__DOORBELL_OFFSET__SHIFT;<o:p></o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; pr_debug(&quot;cp_hqd_pq_doorbell_control 0x%x\n&quot;, m-&=
gt;cp_hqd_pq_doorbell_control);<o:p></o:p></p>
<p class=3D"MsoNormal">+<o:p></o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; qp-&gt;is_active =3D 0;<o:p></o:p></p>
<p class=3D"MsoNormal">+}<o:p></o:p></p>
<p class=3D"MsoNormal">+<o:p></o:p></p>
<p class=3D"MsoNormal">+static void checkpoint_mqd_sdma_v12_1(struct mqd_ma=
nager *mm, void *mqd,<o:p></o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp; void *mqd_dst, void *ctl_stack_dst)<o:p></o:p></p>
<p class=3D"MsoNormal">+{<o:p></o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; struct v12_sdma_mqd *m;<o:p></o:p></p>
<p class=3D"MsoNormal">+<o:p></o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; m =3D get_sdma_mqd(mqd);<o:p></o:p></p>
<p class=3D"MsoNormal">+<o:p></o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; memcpy(mqd_dst, m, sizeof(struct v12_sdma_mqd));<o:p></o:p>=
</p>
<p class=3D"MsoNormal">+}<o:p></o:p></p>
<p class=3D"MsoNormal">+<o:p></o:p></p>
<p class=3D"MsoNormal">+static void restore_mqd_sdma_v12_1(struct mqd_manag=
er *mm, void **mqd,<o:p></o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp; s=
truct kfd_mem_obj *mqd_mem_obj, uint64_t *gart_addr,<o:p></o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp; s=
truct queue_properties *qp,<o:p></o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp; c=
onst void *mqd_src,<o:p></o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp; c=
onst void *ctl_stack_src,<o:p></o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp; c=
onst u32 ctl_stack_size)<o:p></o:p></p>
<p class=3D"MsoNormal">+{<o:p></o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; u64 addr;<o:p></o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; struct v12_sdma_mqd *m;<o:p></o:p></p>
<p class=3D"MsoNormal">+<o:p></o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; if (ctl_stack_size)<o:p></o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; pr_debug(&quot;GFX12 ctl stack restore not s=
upported\n&quot;);<o:p></o:p></p>
<p class=3D"MsoNormal">+<o:p></o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; m =3D (struct v12_sdma_mqd *)mqd_mem_obj-&gt;cpu_ptr;<o:p><=
/o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; addr =3D mqd_mem_obj-&gt;gpu_addr;<o:p></o:p></p>
<p class=3D"MsoNormal">+<o:p></o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; memset(m, 0, AMDGPU_MQD_SIZE_ALIGN(mm-&gt;mqd_size));<o:p><=
/o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; memcpy(m, mqd_src, sizeof(*m));<o:p></o:p></p>
<p class=3D"MsoNormal">+<o:p></o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; m-&gt;sdmax_rlcx_doorbell_offset =3D<o:p></o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; qp-&gt;doorbell_off &lt;&lt; SDMA0_QUEUE0_DO=
ORBELL_OFFSET__OFFSET__SHIFT;<o:p></o:p></p>
<p class=3D"MsoNormal">+<o:p></o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; *mqd =3D m;<o:p></o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; if (gart_addr)<o:p></o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; *gart_addr =3D addr;<o:p></o:p></p>
<p class=3D"MsoNormal">+<o:p></o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; qp-&gt;is_active =3D 0;<o:p></o:p></p>
<p class=3D"MsoNormal">+}<o:p></o:p></p>
<p class=3D"MsoNormal">+<o:p></o:p></p>
<p class=3D"MsoNormal">struct mqd_manager *mqd_manager_init_v12_1(enum KFD_=
MQD_TYPE type,<o:p></o:p></p>
<p class=3D"MsoNormal">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct kfd_node *dev)<o:p></o:p><=
/p>
<p class=3D"MsoNormal">{<o:p></o:p></p>
<p class=3D"MsoNormal">@@ -668,6 +749,7 @@ struct mqd_manager *mqd_manager_=
init_v12_1(enum KFD_MQD_TYPE type,<o:p></o:p></p>
<p class=3D"MsoNormal">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mqd-&gt;mqd_size =3D sizeof(struc=
t v12_1_compute_mqd);<o:p></o:p></p>
<p class=3D"MsoNormal">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mqd-&gt;get_wave_state =3D get_wa=
ve_state_v12_1;<o:p></o:p></p>
<p class=3D"MsoNormal">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mqd-&gt;mqd_stride =3D kfd_mqd_st=
ride;<o:p></o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mqd-&gt;restore_mqd =3D restore_mqd_v12_1;<o=
:p></o:p></p>
<p class=3D"MsoNormal">#if defined(CONFIG_DEBUG_FS)<o:p></o:p></p>
<p class=3D"MsoNormal">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mqd-&gt;debugfs_show_mqd =3D debu=
gfs_show_mqd;<o:p></o:p></p>
<p class=3D"MsoNormal">#endif<o:p></o:p></p>
<p class=3D"MsoNormal">@@ -714,6 +796,7 @@ struct mqd_manager *mqd_manager_=
init_v12_1(enum KFD_MQD_TYPE type,<o:p></o:p></p>
<p class=3D"MsoNormal">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mqd-&gt;is_occupied =3D kfd_is_oc=
cupied_sdma;<o:p></o:p></p>
<p class=3D"MsoNormal">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mqd-&gt;mqd_size =3D sizeof(struc=
t v12_sdma_mqd);<o:p></o:p></p>
<p class=3D"MsoNormal">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mqd-&gt;mqd_stride =3D kfd_mqd_st=
ride;<o:p></o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mqd-&gt;restore_mqd =3D restore_mqd_sdma_v12=
_1;<o:p></o:p></p>
<p class=3D"MsoNormal">#if defined(CONFIG_DEBUG_FS)<o:p></o:p></p>
<p class=3D"MsoNormal">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mqd-&gt;debugfs_show_mqd =3D debu=
gfs_show_mqd_sdma;<o:p></o:p></p>
<p class=3D"MsoNormal">#endif<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
</div>
</div>
</body>
</html>

--_000_SA1PR12MB8600CBE6F2B9B8D6BBEBEA349FA72SA1PR12MB8600namp_--
