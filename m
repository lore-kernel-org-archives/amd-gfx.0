Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B8E68C55196
	for <amd-gfx@archiver.kernel.org>; Mon,  3 Aug 2026 20:30:39 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5284D10E085;
	Mon,  3 Aug 2026 20:30:39 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="yyCIHnZ6";
	dkim-atps=neutral
Received: from BYAPR05CU005.outbound.protection.outlook.com
 (mail-westusazon11010068.outbound.protection.outlook.com [52.101.85.68])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B5F9610E085
 for <amd-gfx@lists.freedesktop.org>; Mon,  3 Aug 2026 20:30:37 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TCEVH8H/ltl5vmG9+UdVnx39kFiGaZh4d2UgY8kZyRdjsbyZtvHTwaJMXmIfL466HfwBMmuuXY539ciy/2weALQBKN/SCC1euwZbe0Tz7tiFtu2b8DvWUHttsg+eMITzrMdK9FciEFQ5KMF28CFbV+Icn3XTUZsTeg4tcTljczOM1sFiI4AG6n9ptrj9iGbu3RG0SgHH7NEevLSj1BTxgONeo7iaEx+r6shZf/ORO+eu2rn17d0nbz7quNtqKzzEwqQt+fxm4M6tZhCtR9VWMbwCvKQ8A4CgffywxLhHeYbacrbVOq6EUYwoKgpJ/mbnxMowjmUx9qzzS2DKfgUzvw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CoNdfQHdGmKmwC8FHTlZ7SY8etJeoUyT+pKCKAj1tPo=;
 b=yZXrRam2M3+HQeZHUBbWM8AleOTmn2QN5D0omu5xceGeHqe61p0Rtbh5iEEtHt9lIRB+gtMDGngXQl3sOaszZ2trRF58zPu2o+8C6R8wPoumIB558A01HheVb2WteRMBoRRKG01ohOJAJsFRv3Vj+4j9flAd2e5u0QE2b5ZcAxYQ6qB4yEtB81hCMPMeJ9j8Y/CoF7kUk+3oPMv5uzCnEgmAlHmixmuyhOFwB1MtpJpyxLsaxdkIjPHTDD1GghZXtGr543bbA76r5WYKZUSAOZ6B7ulkMaAMq5jl1kxm/cYNoZzw+y9pHSNfh70NmmDEFriDYWB4QaX37kfY59St8A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CoNdfQHdGmKmwC8FHTlZ7SY8etJeoUyT+pKCKAj1tPo=;
 b=yyCIHnZ6Ppd+nSLoe+0OKqYaxOGv1YwdMKoDT1MxCPgw8SdAzjNsqMCgQoWuIeWx1EeP3hMHcLJ/V8Wia12Lp6qdrDQEmcJqALWtPdn1jonHyrO1WgOQiecZWQA5Hwiu/hmI7p/TdoBLcwKVneIP9+1mOLXNbzYy0Aqb6S8SmHI=
Received: from DM6PR12MB3611.namprd12.prod.outlook.com (2603:10b6:5:3c::17) by
 PH0PR12MB8824.namprd12.prod.outlook.com (2603:10b6:510:26f::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.270.18; Mon, 3 Aug
 2026 20:30:33 +0000
Received: from DM6PR12MB3611.namprd12.prod.outlook.com
 ([fe80::7861:6815:8b7d:bd0b]) by DM6PR12MB3611.namprd12.prod.outlook.com
 ([fe80::7861:6815:8b7d:bd0b%4]) with mapi id 15.21.0270.016; Mon, 3 Aug 2026
 20:30:32 +0000
From: "Chen, Michael" <Michael.Chen@amd.com>
To: "Liang, Prike" <Prike.Liang@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
CC: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Koenig, Christian"
 <Christian.Koenig@amd.com>, "Liu, Shaoyun" <Shaoyun.Liu@amd.com>
Subject: Re: [PATCH v2 2/2] drm/amdkfd: enable rs64mem for kfd queue
Thread-Topic: [PATCH v2 2/2] drm/amdkfd: enable rs64mem for kfd queue
Thread-Index: AQHdH8h0cy0vMxJ0skewm8RkvHhctraMzaqg
Date: Mon, 3 Aug 2026 20:30:32 +0000
Message-ID: <DM6PR12MB3611DD14C882B3CBAA936FE194D52@DM6PR12MB3611.namprd12.prod.outlook.com>
References: <20260730020911.234193-1-Prike.Liang@amd.com>
 <20260730020911.234193-2-Prike.Liang@amd.com>
In-Reply-To: <20260730020911.234193-2-Prike.Liang@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Enabled=True;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SetDate=2026-08-03T20:30:29.730Z;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Name=AMD
 General; MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_ContentBits=1;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Method=Standard; 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM6PR12MB3611:EE_|PH0PR12MB8824:EE_
x-ms-office365-filtering-correlation-id: 49742485-9ab7-481d-a5ff-08def19e1131
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|23010399003|1800799024|366016|38070700021|10067099003|56012099006|11063799006|4143699003|22082099003|18002099003|8096899003;
x-microsoft-antispam-message-info: AnWjny9aGzoqENE3x43ofFgXvZMX8+CJWRhHJ6tDHEz7WRlJnbY+sMkU2nT3I5fGKW2LaTo+vHT1S+LquPSd46YQCJv0/qV6IIw0i+dCBNcqDIo7OjzZKDQtV/c3Uxcjhsj9PLHjOvanMf/7vseELf2u580dCsncIpb8t8DO+/SdJxpFd67qhj1M3QofGZ/OfpuHnN+hf7woObwmBQpghGeDfDTj1KbczVo+GpVh3p0IOmfnUy/V0/MFbL7NznNS0sFqNhoWrR+yMlHomKpswzpva3MFZ7SCW1SHK0yNhwSsIgEbA3e+VbCjobQiyrS3F0PrV2aQxXjCdFbHwBp4suPYiO/pEHqwhSADqRKVmuJ6u6ESNLXaqeTdoQZ4zVP9UkXSD2vCLinCADruXqmXAUMkrWbAgiM0cF4v4xAjcnCbPUZB9WNuCbGyOvyuRzAr/esQmELETi3V6T6KBDV9tW7AvpzoxkR+3wglm8/C5otgbXc2lbc/RjrL6XVVAtj7a/2uYxHLXpVS+uyhxerWV10hwJmqwMdAs4u56EAeKl0c9yodNO6fZhoPO7wEesctRSKnb5dWXfuzPM4JBgjycArKXoF66+gTvmC7K2PkW/prqNiFzlymIfoSeeUiKXGzYdloH0TDPdcyb1QLRfnrCnEOHtbe1VCsfTd5jykkh8uvrftSyjuy09RT3px1XIut5BSzgUDGgQjRNXzvSsRnBDLXKRucT0vHtm9ZdpZI9yE=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB3611.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(23010399003)(1800799024)(366016)(38070700021)(10067099003)(56012099006)(11063799006)(4143699003)(22082099003)(18002099003)(8096899003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?xByZTP/DXep0g0izaqU/4YjGWByxu4XUWeFsXdU0Bx4v6Ei21IQePIlRxl?=
 =?iso-8859-1?Q?fUHl6Wpam7/HgPSOsCjUTnBAMxIJRGZK7W4Qu3fgObUXVFAp+IFxEEpHJk?=
 =?iso-8859-1?Q?6r82kknRdNlEeGxQMlKjyE9K2bIIeLTqG4vwJYRg4drWim9TiHZ4nAtbRt?=
 =?iso-8859-1?Q?lLtvBfO00BKW5DerVBfOFt+qLEeNQp7zClcJnzegAoCXFFGCTx+JF2qG+t?=
 =?iso-8859-1?Q?gRxoiPcM9fYM4Ie1EvgCbmm4veIMZS05+H44uQt6JZN0YSVcmV+aga9G4r?=
 =?iso-8859-1?Q?FzOvmslM2c9m+chjoCzWLk+4eq2r9V4Ol3PVblxQg7wZwlpg8RlHk+Hb9H?=
 =?iso-8859-1?Q?yCVUdxqI+DHBynn5ZmN5BP+W/NQD0FYlLH8deDKfrhL+lYgpO+Mh+tVr9N?=
 =?iso-8859-1?Q?YrigKDg2mA38FNzJedBJWgelMnnoS3Sk0+ZFX3NZ9VlTDIXdrbtsUArdRd?=
 =?iso-8859-1?Q?+RcfDkCqGWyD2/yUeIEhCBZ3MywqUdBpZFWNWPE8Z4rODtZIX43mB52fW2?=
 =?iso-8859-1?Q?/BrRf9DfT14K/4ZsiG6z4Ujq1MeTr9tPLJ8CAnXmJ61KGgugvhD8WuF6BC?=
 =?iso-8859-1?Q?/VvgUNX7XpJCHvRjUkTUJT6CAtwO+QE8UB9SZ+KoKK0yLWtBHsfQ3Pn53H?=
 =?iso-8859-1?Q?JQomCRNz4wk0EJLa1d85WDS8zwHnUah6/uTnFGPk4o9e5kKUa7IE6crW7T?=
 =?iso-8859-1?Q?U1yx12rvfcCo8RS3Ayu7MCMi0TL8fCXPVkbFFGxQDhZiApr0ANw49RK/d+?=
 =?iso-8859-1?Q?Bdrc8uSY3qkN6ZLn9elOKne2kKJJCWAu9Z0F9n1iQUGeO7WwRvdF3Dpxix?=
 =?iso-8859-1?Q?BAftC92a1fxQiK4bBh6J3cRBA/sSbAWblfNQSPFn/5ZbLBmETgGv6ihxXc?=
 =?iso-8859-1?Q?ADEmmnk0s8mA5FTCb/6LTj2XOeB7F9KysFCyZnNmx61jhmVu1BI7zoAUVW?=
 =?iso-8859-1?Q?PcWlEMMyZoP6sHgxOBTptyx1BQCNTaYZAMsCDU6cB2prdtOORH8P+AHwTc?=
 =?iso-8859-1?Q?PJ8f5q0RCD+5hgWmFShfqDMF+e8sQWXUYDdW++5a+2AmFKJQqQFQeOFLmo?=
 =?iso-8859-1?Q?orQmJekGs8Jfwn4QCaNsGifRRawaWjogx/NQI+rAt/TSNMc7rB3WQ90U/9?=
 =?iso-8859-1?Q?IHpDULaXyKshzptr6FHLpTIr1E0+oZvSRzyF65Gujtexqv2Xwt+VQuSKS6?=
 =?iso-8859-1?Q?cz9g6Qk1bEXjorZFWWQyWkb2JUH1YXVsT8FJq3M80LJuDEWPHBZ+A8aRRn?=
 =?iso-8859-1?Q?mYcojeIafIkDulcmUpfj+7tkKu6NQcZVrFH95yu6meZQCrw1NJDkl+rs8V?=
 =?iso-8859-1?Q?YjvBgek6zi/xwgYPm4+tj6i73dLpvbXEeuGn9gQbnZAQOBn3Vx3me17Sug?=
 =?iso-8859-1?Q?zWqfXTIMj4lRMe7XZ02DkqDfTbPdTSvPvPE92OuhivGJkCqz3gDlI9EkUv?=
 =?iso-8859-1?Q?1iJVzRyAe8/NCovEcXZbvLPS7PjqT2Supkb6apIgAu298GR84c3HQz5zcy?=
 =?iso-8859-1?Q?QFu23YVMvNqN5ZH5E9RTYttvf+mrtZ4n0g8CniINUJ38orhvYa0XaqEsZv?=
 =?iso-8859-1?Q?Sr7pbhN2xbJBRFhYhozMpW5ZAiKAImXV7oP+x3V/+ztTqa3KUwFD6+uoCX?=
 =?iso-8859-1?Q?BIV8RSr1tvbhQIae8U08MWXbVMkigPNCquqwaH3hheJkTQlkSfylwhh0J3?=
 =?iso-8859-1?Q?gm0fZmzxBKDSwVwZu7nWx/EnWOynnvjdCbAyN9k4b6l5NYlARWYw3+xefy?=
 =?iso-8859-1?Q?bemH0/QyPMBKCLI/Q43TYvh4iVsZ6BTbXsdnKtDbptKnDd?=
Content-Type: multipart/alternative;
 boundary="_000_DM6PR12MB3611DD14C882B3CBAA936FE194D52DM6PR12MB3611namp_"
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3611.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 49742485-9ab7-481d-a5ff-08def19e1131
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Aug 2026 20:30:32.8380 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: GO/RyCFDVHt58fEccPwrXhrb//oc0QQyYj2Vrg/jiDnT2YPjQS7wsdz6BjrfKUt/7OXBqpiZGHjAipcyGyyYww==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB8824
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

--_000_DM6PR12MB3611DD14C882B3CBAA936FE194D52DM6PR12MB3611namp_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

AMD General



________________________________
From: Liang, Prike <Prike.Liang@amd.com>
Sent: Wednesday, July 29, 2026 10:09 PM
To: amd-gfx@lists.freedesktop.org <amd-gfx@lists.freedesktop.org>
Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Koenig, Christian <Chri=
stian.Koenig@amd.com>; Chen, Michael <Michael.Chen@amd.com>; Liu, Shaoyun <=
Shaoyun.Liu@amd.com>; Liang, Prike <Prike.Liang@amd.com>
Subject: [PATCH v2 2/2] drm/amdkfd: enable rs64mem for kfd queue

Enabled RS64mem for KFD queues by integrating
process and gang context index allocation in
the per KFD device process and queue creation.

Signed-off-by: Prike Liang <Prike.Liang@amd.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c  |  3 +++
 drivers/gpu/drm/amd/amdkfd/kfd_priv.h                  |  3 +++
 drivers/gpu/drm/amd/amdkfd/kfd_process.c               |  5 ++++-
 drivers/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c | 10 ++++++++++
 4 files changed, 20 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c b/driver=
s/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
index 51ee9c39104b..ea9d87450eae 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
@@ -226,8 +226,10 @@ static int add_queue_mes(struct device_queue_manager *=
dqm, struct queue *q,
         /* MES unit for quantum is 100ns */
         queue_input.process_quantum =3D KFD_MES_PROCESS_QUANTUM;  /* Equiv=
alent to 10ms. */
         queue_input.process_context_addr =3D pdd->proc_ctx_gpu_addr;
+       queue_input.process_context_array_index =3D pdd->proc_ctx_array_ind=
ex;
         queue_input.gang_quantum =3D KFD_MES_GANG_QUANTUM; /* Equivalent t=
o 1ms */
         queue_input.gang_context_addr =3D q->gang_ctx_gpu_addr;
+       queue_input.gang_context_array_index =3D q->gang_ctx_array_index;
         queue_input.inprocess_gang_priority =3D q->properties.priority;
         queue_input.gang_global_priority_level =3D
                                         AMDGPU_MES_PRIORITY_LEVEL_NORMAL;
@@ -303,6 +305,7 @@ static int remove_queue_mes_on_reset_option(struct devi=
ce_queue_manager *dqm, st
         queue_input.queue_type =3D convert_to_amdgpu_ring_type(q->properti=
es.type);
         queue_input.remove_queue_after_reset =3D flush_mes_queue;
         queue_input.xcc_id =3D ffs(dqm->dev->xcc_mask) - 1;
+       queue_input.gang_context_array_index =3D q->gang_ctx_array_index;

         amdgpu_mes_lock(&adev->mes);
         r =3D adev->mes.funcs->remove_hw_queue(&adev->mes, &queue_input);
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h b/drivers/gpu/drm/amd/am=
dkfd/kfd_priv.h
index 88191a4c1657..3b89bcc625b3 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
@@ -635,6 +635,7 @@ struct queue {
         void *gang_ctx_bo;
         uint64_t gang_ctx_gpu_addr;
         void *gang_ctx_cpu_ptr;
+       uint32_t gang_ctx_array_index;

         struct amdgpu_bo *wptr_bo_gart;
 };
@@ -871,6 +872,8 @@ struct kfd_process_device {
         uint64_t proc_ctx_gpu_addr;
         void *proc_ctx_cpu_ptr;

+       uint32_t proc_ctx_array_index;
+
         /* Tracks queue reset status */
         bool has_reset_queue;

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_process.c b/drivers/gpu/drm/amd=
/amdkfd/kfd_process.c
index eb508fe3ded7..0a7c1900da95 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_process.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_process.c
@@ -1215,9 +1215,12 @@ static void kfd_process_destroy_pdds(struct kfd_proc=
ess *p)
                 kfd_free_process_doorbells(pdd->dev->kfd, pdd);

                 if (pdd->dev->kfd->shared_resources.enable_mes &&
-                       pdd->proc_ctx_cpu_ptr)
+                       pdd->proc_ctx_cpu_ptr) {
+                       amdgpu_mes_free_proc_ctx_index(&pdd->dev->adev->mes=
,
+                                                      pdd->proc_ctx_array_=
index);
                         amdgpu_amdkfd_free_kernel_mem(pdd->dev->adev,
                                                    &pdd->proc_ctx_bo);
+               }
                 /*
                  * before destroying pdd, make sure to report availability
                  * for auto suspend
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c b/drive=
rs/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c
index 8054e4fe0381..72913b5c8338 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c
@@ -210,6 +210,7 @@ static void pqm_clean_queue_resource(struct process_que=
ue_manager *pqm,
         }

         if (dev->kfd->shared_resources.enable_mes) {
+               amdgpu_mes_free_gang_ctx_index(&dev->adev->mes, pqn->q->gan=
g_ctx_array_index);
                 amdgpu_amdkfd_free_kernel_mem(dev->adev, &pqn->q->gang_ctx=
_bo);
                 amdgpu_amdkfd_free_kernel_mem(dev->adev, (void **)&pqn->q-=
>wptr_bo_gart);
         }
@@ -282,6 +283,9 @@ static int init_user_queue(struct process_queue_manager=
 *pqm,
                         goto cleanup;
                 }
                 memset((*q)->gang_ctx_cpu_ptr, 0, AMDGPU_MES_GANG_CTX_SIZE=
);
+               /* Bind one MES gang context slot per queue (gang). */
+               amdgpu_mes_alloc_gang_ctx_index(&dev->adev->mes,
+                                               &(*q)->gang_ctx_array_index=
);


  1.
Should check "mes->use_rs64mem" as you do in patch #1?
  2.
Check return error code (in oversubscription case, it may run out of index)


                 /* Starting with GFX11, wptr BOs must be mapped to GART fo=
r MES to determine work
                  * on unmapped queues for usermode queue oversubscription =
(no aggregated doorbell)
@@ -304,6 +308,7 @@ static int init_user_queue(struct process_queue_manager=
 *pqm,
         return 0;

 free_gang_ctx_bo:
+       amdgpu_mes_free_gang_ctx_index(&dev->adev->mes, (*q)->gang_ctx_arra=
y_index);
         amdgpu_amdkfd_free_kernel_mem(dev->adev, &(*q)->gang_ctx_bo);
 cleanup:
         uninit_queue(*q);
@@ -386,6 +391,11 @@ int pqm_create_queue(struct process_queue_manager *pqm=
,
                         goto err_allocate_pqn;
                 }
                 memset(pdd->proc_ctx_cpu_ptr, 0, AMDGPU_MES_PROC_CTX_SIZE)=
;
+               /* Bind one MES process context slot to the whole process
+                * (per device); every queue of this process reuses it.
+                */
+               amdgpu_mes_alloc_proc_ctx_index(&dev->adev->mes,
+                                               &pdd->proc_ctx_array_index)=
;

Same comment as above.

         }

         pqn =3D kzalloc_obj(*pqn);
--
2.34.1


--_000_DM6PR12MB3611DD14C882B3CBAA936FE194D52DM6PR12MB3611namp_
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
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
<div>
<div style=3D"font-family: Calibri; text-align: left; color: rgb(0, 0, 255)=
; margin-left: 5pt; font-size: 10pt;">
AMD General</div>
<br>
</div>
<br>
</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);">
<br>
</div>
<hr style=3D"display: inline-block; width: 98%;">
<div id=3D"divRplyFwdMsg">
<div style=3D"direction: ltr; font-family: Calibri, sans-serif; font-size: =
11pt; color: rgb(0, 0, 0);">
<b>From:</b> Liang, Prike &lt;Prike.Liang@amd.com&gt;<br>
<b>Sent:</b> Wednesday, July 29, 2026 10:09 PM<br>
<b>To:</b> amd-gfx@lists.freedesktop.org &lt;amd-gfx@lists.freedesktop.org&=
gt;<br>
<b>Cc:</b> Deucher, Alexander &lt;Alexander.Deucher@amd.com&gt;; Koenig, Ch=
ristian &lt;Christian.Koenig@amd.com&gt;; Chen, Michael &lt;Michael.Chen@am=
d.com&gt;; Liu, Shaoyun &lt;Shaoyun.Liu@amd.com&gt;; Liang, Prike &lt;Prike=
.Liang@amd.com&gt;<br>
<b>Subject:</b> [PATCH v2 2/2] drm/amdkfd: enable rs64mem for kfd queue</di=
v>
<div style=3D"direction: ltr;">&nbsp;</div>
</div>
<div style=3D"font-size: 11pt;">Enabled RS64mem for KFD queues by integrati=
ng<br>
process and gang context index allocation in<br>
the per KFD device process and queue creation.<br>
<br>
Signed-off-by: Prike Liang &lt;Prike.Liang@amd.com&gt;<br>
---<br>
&nbsp;drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c&nbsp; |&nbsp; 3=
 +++<br>
&nbsp;drivers/gpu/drm/amd/amdkfd/kfd_priv.h&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; |&nb=
sp; 3 +++<br>
&nbsp;drivers/gpu/drm/amd/amdkfd/kfd_process.c&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; |&nbsp; 5 ++++-<br>
&nbsp;drivers/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c | 10 +++++++++=
+<br>
&nbsp;4 files changed, 20 insertions(+), 1 deletion(-)<br>
<br>
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c b/driver=
s/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c<br>
index 51ee9c39104b..ea9d87450eae 100644<br>
--- a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c<br>
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c<br>
@@ -226,8 +226,10 @@ static int add_queue_mes(struct device_queue_manager *=
dqm, struct queue *q,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* MES unit for quantum is=
 100ns */<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; queue_input.process_quantu=
m =3D KFD_MES_PROCESS_QUANTUM;&nbsp; /* Equivalent to 10ms. */<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; queue_input.process_contex=
t_addr =3D pdd-&gt;proc_ctx_gpu_addr;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; queue_input.process_context_array_ind=
ex =3D pdd-&gt;proc_ctx_array_index;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; queue_input.gang_quantum =
=3D KFD_MES_GANG_QUANTUM; /* Equivalent to 1ms */<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; queue_input.gang_context_a=
ddr =3D q-&gt;gang_ctx_gpu_addr;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; queue_input.gang_context_array_index =
=3D q-&gt;gang_ctx_array_index;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; queue_input.inprocess_gang=
_priority =3D q-&gt;properties.priority;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; queue_input.gang_global_pr=
iority_level =3D<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; AMDGPU_MES_PRIORITY_LEVEL_NORMAL;<br>
@@ -303,6 +305,7 @@ static int remove_queue_mes_on_reset_option(struct devi=
ce_queue_manager *dqm, st<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; queue_input.queue_type =3D=
 convert_to_amdgpu_ring_type(q-&gt;properties.type);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; queue_input.remove_queue_a=
fter_reset =3D flush_mes_queue;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; queue_input.xcc_id =3D ffs=
(dqm-&gt;dev-&gt;xcc_mask) - 1;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; queue_input.gang_context_array_index =
=3D q-&gt;gang_ctx_array_index;<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_mes_lock(&amp;adev-=
&gt;mes);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; r =3D adev-&gt;mes.funcs-&=
gt;remove_hw_queue(&amp;adev-&gt;mes, &amp;queue_input);<br>
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h b/drivers/gpu/drm/amd/am=
dkfd/kfd_priv.h<br>
index 88191a4c1657..3b89bcc625b3 100644<br>
--- a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h<br>
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h<br>
@@ -635,6 +635,7 @@ struct queue {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; void *gang_ctx_bo;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint64_t gang_ctx_gpu_addr=
;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; void *gang_ctx_cpu_ptr;<br=
>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t gang_ctx_array_index;<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_bo *wptr_bo_=
gart;<br>
&nbsp;};<br>
@@ -871,6 +872,8 @@ struct kfd_process_device {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint64_t proc_ctx_gpu_addr=
;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; void *proc_ctx_cpu_ptr;<br=
>
&nbsp;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t proc_ctx_array_index;<br>
+<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* Tracks queue reset stat=
us */<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; bool has_reset_queue;<br>
&nbsp;<br>
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_process.c b/drivers/gpu/drm/amd=
/amdkfd/kfd_process.c<br>
index eb508fe3ded7..0a7c1900da95 100644<br>
--- a/drivers/gpu/drm/amd/amdkfd/kfd_process.c<br>
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_process.c<br>
@@ -1215,9 +1215,12 @@ static void kfd_process_destroy_pdds(struct kfd_proc=
ess *p)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; kfd_free_process_doorbells(pdd-&gt;dev-&gt;kfd, pdd);=
<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; if (pdd-&gt;dev-&gt;kfd-&gt;shared_resources.enable_m=
es &amp;&amp;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; pdd-&gt;proc_ctx=
_cpu_ptr)<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; pdd-&gt;proc_ctx=
_cpu_ptr) {<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_mes_free_=
proc_ctx_index(&amp;pdd-&gt;dev-&gt;adev-&gt;mes,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; pdd-&gt;proc_ctx_array_index);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgp=
u_amdkfd_free_kernel_mem(pdd-&gt;dev-&gt;adev,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp; &amp;pdd-&gt;proc_ctx_bo);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; }<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; /*<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp; * before destroying pdd, make sure to report av=
ailability<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp; * for auto suspend<br>
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c b/drive=
rs/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c<br>
index 8054e4fe0381..72913b5c8338 100644<br>
--- a/drivers/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c<br>
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c<br>
@@ -210,6 +210,7 @@ static void pqm_clean_queue_resource(struct process_que=
ue_manager *pqm,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (dev-&gt;kfd-&gt;shared=
_resources.enable_mes) {<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; amdgpu_mes_free_gang_ctx_index(&amp;dev-&gt;adev-&gt;mes, pqn-&g=
t;q-&gt;gang_ctx_array_index);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; amdgpu_amdkfd_free_kernel_mem(dev-&gt;adev, &amp;pqn-=
&gt;q-&gt;gang_ctx_bo);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; amdgpu_amdkfd_free_kernel_mem(dev-&gt;adev, (void **)=
&amp;pqn-&gt;q-&gt;wptr_bo_gart);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
@@ -282,6 +283,9 @@ static int init_user_queue(struct process_queue_manager=
 *pqm,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; goto =
cleanup;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; }<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; memset((*q)-&gt;gang_ctx_cpu_ptr, 0, AMDGPU_MES_GANG_=
CTX_SIZE);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; /* Bind one MES gang context slot per queue (gang). */<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; amdgpu_mes_alloc_gang_ctx_index(&amp;dev-&gt;adev-&gt;mes,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &amp;(*q)-&gt;gang_ctx=
_array_index);<br>
&nbsp;</div>
<ol start=3D"1" data-editing-info=3D"{&quot;applyListStyleFromLevel&quot;:f=
alse,&quot;orderedStyleType&quot;:1}" style=3D"margin-top: 0px; margin-bott=
om: 0px; list-style-type: decimal;">
<li style=3D"font-size: 11pt; margin-top: 0px; margin-bottom: 0px;">
<div class=3D"elementToProof" role=3D"presentation" style=3D"font-family: A=
ptos, Aptos_EmbeddedFont, Aptos_MSFontService, Calibri, Helvetica, sans-ser=
if; color: rgb(0, 0, 0);">
Should check &quot;mes-&gt;use_rs64mem&quot; as you do in patch #1?</div>
</li><li style=3D"font-size: 11pt; margin-top: 0px; margin-bottom: 0px;">
<div class=3D"elementToProof" role=3D"presentation" style=3D"font-family: A=
ptos, Aptos_EmbeddedFont, Aptos_MSFontService, Calibri, Helvetica, sans-ser=
if; color: rgb(0, 0, 0);">
Check return error code (in oversubscription case, it may run out of index)=
</div>
</li></ol>
<div style=3D"margin-top: 0px; margin-bottom: 0px; font-family: Aptos, Apto=
s_EmbeddedFont, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-s=
ize: 11pt; color: rgb(0, 0, 0);">
<br>
</div>
<div style=3D"margin-top: 0px; margin-bottom: 0px; font-family: Aptos, Apto=
s_EmbeddedFont, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-s=
ize: 11pt; color: rgb(0, 0, 0);">
<br>
</div>
<div class=3D"elementToProof" style=3D"font-size: 11pt;">&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; /* Starting with GFX11, wptr BOs must be mapped to GART for MES to dete=
rmine work</div>
<div class=3D"elementToProof" style=3D"font-size: 11pt;">&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp; * on unmapped queues for usermode queue oversubscription (no aggr=
egated doorbell)</div>
<div class=3D"elementToProof" style=3D"font-size: 11pt;">@@ -304,6 +308,7 @=
@ static int init_user_queue(struct process_queue_manager *pqm,</div>
<div class=3D"elementToProof" style=3D"font-size: 11pt;">&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return 0;</div>
<div class=3D"elementToProof" style=3D"font-size: 11pt;">&nbsp;</div>
<div class=3D"elementToProof" style=3D"font-size: 11pt;">&nbsp;free_gang_ct=
x_bo:</div>
<div class=3D"elementToProof" style=3D"font-size: 11pt;">+&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; amdgpu_mes_free_gang_ctx_index(&amp;dev-&gt;adev-&gt;me=
s, (*q)-&gt;gang_ctx_array_index);</div>
<div class=3D"elementToProof" style=3D"font-size: 11pt;">&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_amdkfd_free_kernel_mem(dev-&gt;adev, =
&amp;(*q)-&gt;gang_ctx_bo);</div>
<div class=3D"elementToProof" style=3D"font-size: 11pt;">&nbsp;cleanup:</di=
v>
<div class=3D"elementToProof" style=3D"font-size: 11pt;">&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uninit_queue(*q);</div>
<div class=3D"elementToProof" style=3D"font-size: 11pt;">@@ -386,6 +391,11 =
@@ int pqm_create_queue(struct process_queue_manager *pqm,</div>
<div class=3D"elementToProof" style=3D"font-size: 11pt;">&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; goto err_allocate_pqn;<=
/div>
<div class=3D"elementToProof" style=3D"font-size: 11pt;">&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; }</div>
<div class=3D"elementToProof" style=3D"font-size: 11pt;">&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; memset(pdd-&gt;proc_ctx_cpu_ptr, 0, AMDGPU_MES_PROC_CTX_SIZE);</div>
<div class=3D"elementToProof" style=3D"font-size: 11pt;">+&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* Bind=
 one MES process context slot to the whole process</div>
<div class=3D"elementToProof" style=3D"font-size: 11pt;">+&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; *=
 (per device); every queue of this process reuses it.</div>
<div class=3D"elementToProof" style=3D"font-size: 11pt;">+&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; *=
/</div>
<div class=3D"elementToProof" style=3D"font-size: 11pt;">+&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_=
mes_alloc_proc_ctx_index(&amp;dev-&gt;adev-&gt;mes,</div>
<div class=3D"elementToProof" style=3D"font-size: 11pt;">+&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &amp;pdd-&gt;proc_ctx_array_index);</div=
>
<div class=3D"elementToProof" style=3D"font-size: 11pt;"><br>
</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 11pt; c=
olor: rgb(0, 0, 0);">
Same comment as above.</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 11pt; c=
olor: rgb(0, 0, 0);">
<br>
</div>
<div class=3D"elementToProof" style=3D"font-size: 11pt;">&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }</div>
<div class=3D"elementToProof" style=3D"font-size: 11pt;">&nbsp;</div>
<div class=3D"elementToProof" style=3D"font-size: 11pt;">&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; pqn =3D kzalloc_obj(*pqn);</div>
<div class=3D"elementToProof" style=3D"font-size: 11pt;">--</div>
<div class=3D"elementToProof" style=3D"font-size: 11pt;">2.34.1</div>
<div class=3D"elementToProof" style=3D"font-size: 11pt;"><br>
</div>
</body>
</html>

--_000_DM6PR12MB3611DD14C882B3CBAA936FE194D52DM6PR12MB3611namp_--
