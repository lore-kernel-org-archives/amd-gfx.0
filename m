Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 13747C83F21
	for <amd-gfx@archiver.kernel.org>; Tue, 15 Jul 2025 13:55:23 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id ACAC710E5E2;
	Tue, 15 Jul 2025 13:55:22 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="v+Kf5xSP";
	dkim-atps=neutral
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2047.outbound.protection.outlook.com [40.107.92.47])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0E97310E5E1
 for <amd-gfx@lists.freedesktop.org>; Tue, 15 Jul 2025 13:55:21 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NG20bmhOlH0yWx+10ZXG9NcoUVUw54N8NLUlchSwu3BGu5xK29O4U73go/CFWjFDjBFLWGv4nm04xt0r70NOEecX/HzqYm5FiNZVBt7S/SeMuSkXUdHdxcaeLW/uxzaOeN0yNDALQf9hxaoEoSrihuf3W0Last9n5C/wCOp0wCSO8ikqPg2XWSCHJyssC+GZztyo8/t0ZBJlxVo9SabDw87TFY5Ymc8rHZNENpnQ/6ztvu5zRWcAR/yaXUWu7w9j+s/Paw95ehbR3ifi8V88h+K4rlp2Xi6Obt45Cem32a+ZzzHvmAcdD53ZAqeJbqHlynRDdTeiQUISD3IZTS+CXQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=B29o5IjKmD+YPDSqQLdIFClgkSldRUwrNP1LHQml19s=;
 b=L9qe/a5fCLPl1dErs33SReFhpWjzcaX32xGAsRIZgQLBgxtpkmjij9LO2BlPqaKGiqWv67lbS319ZCZ1qbpmMw8lSHV+qIewjNq+AyEl2wreKMqMvIkfaH1/nTtap5NTzGWipoSXiK9ESRBGzsezQH/54AyQt5e19UoAfNEPlM/iYmm5L3kE6CkRa+jhlWR8EZw9ntVDTDVWMjkILmUTwnjwEmLJJJelKNkrDfY932EXW33ufV9qy87zPZAYEvMavjV9jvtXQnJoeq2bRnlEXje89YbZTXizL/LxoAxl5hxj9vST1mOfdXd20m+SQrrxZck3/IypLq9kvBDgwY4Uzw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=B29o5IjKmD+YPDSqQLdIFClgkSldRUwrNP1LHQml19s=;
 b=v+Kf5xSPfG61ue1xrXvZ+V+TMXMKBA64vCNGoo0EThGm/p3EUjpABgpVFKROVqDKwGhzYh6O9Mytz7VOFoDRMzrkcLQnunBbZTCr62PHKdVidXi2ahr3adJRU1Zl2KZ8qdZLPW+NUlQr9d7Gn7NP8VGrYUIgO8iD+1tAcc+QoTQ=
Received: from BN9PR12MB5257.namprd12.prod.outlook.com (2603:10b6:408:11e::16)
 by DS0PR12MB7899.namprd12.prod.outlook.com (2603:10b6:8:149::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.35; Tue, 15 Jul
 2025 13:55:18 +0000
Received: from BN9PR12MB5257.namprd12.prod.outlook.com
 ([fe80::c593:f43d:c798:e009]) by BN9PR12MB5257.namprd12.prod.outlook.com
 ([fe80::c593:f43d:c798:e009%7]) with mapi id 15.20.8901.028; Tue, 15 Jul 2025
 13:55:18 +0000
From: "Zhang, Hawking" <Hawking.Zhang@amd.com>
To: "Lazar, Lijo" <Lijo.Lazar@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
CC: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Koenig, Christian"
 <Christian.Koenig@amd.com>
Subject: RE: [PATCH] drm/amdgpu: Increase reset counter only on success
Thread-Topic: [PATCH] drm/amdgpu: Increase reset counter only on success
Thread-Index: AQHb9H9WiwOn9sLUJkG+0fXHkLHf4rQzNyIg
Date: Tue, 15 Jul 2025 13:55:18 +0000
Message-ID: <BN9PR12MB52571FB55B992AC290FD1E4DFC57A@BN9PR12MB5257.namprd12.prod.outlook.com>
References: <20250714052218.1523140-1-lijo.lazar@amd.com>
In-Reply-To: <20250714052218.1523140-1-lijo.lazar@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=True;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2025-07-15T13:55:03.0000000Z;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution
 Only; MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=3;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR12MB5257:EE_|DS0PR12MB7899:EE_
x-ms-office365-filtering-correlation-id: d05338df-06fc-47c3-ffa1-08ddc3a73b9d
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|376014|366016|7053199007|38070700018; 
x-microsoft-antispam-message-info: =?us-ascii?Q?jhyvItdSLTtNuq/qSknukxitIbP7uFp4YuWt3hUqUy8RIdFv0jTRmvxM2EJe?=
 =?us-ascii?Q?P4jPyjkXfBAtlHjjRGGSSqNMcnxJ4VLk1KMJRxXT4YAZBXBu2CeUMEW5sm9Y?=
 =?us-ascii?Q?xcbOJkTQIyerBMT/ODnkagc+iz7/iyjmG5IEI1LtyyD497UxNh6mOQZ/iLA4?=
 =?us-ascii?Q?0RYfRG84ieelRvRkoQ6VmjeNAGBSHuZwTw1B6EHztCsFQA/UNPo4/svhYdsB?=
 =?us-ascii?Q?mPhkpeIGxTVPWtpE2vm4pzuwl9ARr5TwSSRoMIgwsbYl9uD2v9yi+eAwaXV6?=
 =?us-ascii?Q?BLmwfJT8jOLuKJb9fmGceGHZPyoM8UO+rbEJqK5OTCi1lMURzORf5k2TWjFM?=
 =?us-ascii?Q?nA4dDnHB5VifIAF052IHFvd0oN56RoEzAt8YuJgOkg+Qxx5WKTz5Dk/H8JNI?=
 =?us-ascii?Q?kO92mPbGTb2rNGLxrwYmMl0VzMnIX5ZoFRhU/KSbEG+Z9X/e73Xb2GVZaxu6?=
 =?us-ascii?Q?8HeUwrvFJk21vrZmMn9+Nogo/DkmONNy9LZUToYbSbhzj5mFQzsreWfQO4nq?=
 =?us-ascii?Q?5QEz0V/fy8bLmi8YUXTAUCv1lp+n8BmbqTCEejcjI8YxRWs+WbbB0in74AdZ?=
 =?us-ascii?Q?TieFoDBZu716xun6W9Pkkze5t9NLRaFzVk2PGRyKGchZMA8gGTcF4EfBu+Sh?=
 =?us-ascii?Q?4GqDST3qG+pOQPkdJk0cRndezbsfNmERKqCIfycMjYZmVdVbih26e1GXgP1P?=
 =?us-ascii?Q?Uq8AfxKU7pRV2M46Pxff6LvyyzRtRxAeud/PoOzInVgpQLzkuNg477edW8xo?=
 =?us-ascii?Q?epLiCFKvHss1b37w5EwrGmiB//dIfS6+OieadOJHU2SIG66eFSwudxq4ewCi?=
 =?us-ascii?Q?L7JkKNwSb9QY+w4m8MGefdeBI5dOGrSyAk60PvOFSEJkE26tfl4QfDrjlvG1?=
 =?us-ascii?Q?mt2BX/muQ/wAVU+vz0ndhkfaPMcz1cBnRfODSaNJJP4k8H0jMlp8DcYRG2d5?=
 =?us-ascii?Q?IdSJ6R7nVdVAfOZw4nu4GtGJN6JbHD5olzeIHwCerT/kmTUfCiuyKBb9d3Ri?=
 =?us-ascii?Q?9PnDsTMKhu9HRBQ0YpJIbRuBLOBIrQ4zE/u2x6hlilyzu53eA4bPgo3890LY?=
 =?us-ascii?Q?LlQjhfHeQWvG6FtL54LhMNJWraxMGL/HkyQ309ndfPtzJaNbw/fbMxFD1K27?=
 =?us-ascii?Q?GtVakyHTSt0Qxu0Qj778AyrNrIzyRPQqN20ia3GUbgdxke12KEm0tp8nY27t?=
 =?us-ascii?Q?pHlxd3Rqpn7pdCMy6LRN18OJwaVYKoTndp/EAQkdsH5FtbSu6w+ffZnUnLi7?=
 =?us-ascii?Q?F0g577/us2suYjkmL4d75+vGF5xnzhERbg3wxOwlUFuHeFiDDKA/nQXvTXzn?=
 =?us-ascii?Q?kq2uO80XW2RZlnnVImteEh4GCVFwUNakHMKnRs6y25vY3Dv5ZWkLh90dgGNA?=
 =?us-ascii?Q?GRO71YbxeRgDqlMFNRyJg7jNKLjTLGoJwa9WRANVPjkELzwrGPHxgQtqHJs2?=
 =?us-ascii?Q?VsbkfeAeZQeTLpNtc+ELJJB69yFtqP16O+uE3d6zc/rJtaQCnvk07w=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5257.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(7053199007)(38070700018); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?IplBv1VeaUy25ucp3U5nu6PCtmL9mbq2PLVn8V7HStrUzougWFZ/mwJPWHyK?=
 =?us-ascii?Q?2+DCUoptGpg26ygG1MGkj+Ysrp1Tw0OsTShr8ndCkKpFtyfDZH7XXAUt1g4S?=
 =?us-ascii?Q?sXiV8NqodOEobqz5YPfWcLFiStP2eJ+PMVrWvMtI9ng1mbsdkBmrPFAgbpeW?=
 =?us-ascii?Q?JtW7zfN7kawQew7EjaUvwhIlpsSsEFUaizVhu0fhsr1r6ukiZbOoCNfHO5yl?=
 =?us-ascii?Q?2b7Wd1UgrHbDRSTBIpSgseYjwP7Pz0F1wIEwIX75sb7M3M3gNuNphABWGp9U?=
 =?us-ascii?Q?UV4R9gKH4ZfE4XHH8iag8veVRsGMfvTR673ZIhYU6QT7NBqtuN80QdBVruEP?=
 =?us-ascii?Q?qcC3KuIxOY/wxi2338WOcZujLbncquF87UsV1i/Ra8NBYCVWOsBPBkFX7fLU?=
 =?us-ascii?Q?QaTjoXALrCeHnAq8sq2yt59ch7Fo/14BJzy4cOr3VSnyXcwCc2oLMUyxkeQJ?=
 =?us-ascii?Q?70W/yfgI20d1mBmNcZCqGKaMtk4JgswFszUiLivJgKJGRAH6uV+RKnJ76pMC?=
 =?us-ascii?Q?xTOEjqVr2RpPn33bCrVo6arAH+vyBbh8xTF4dXtdcEMOmSyWuM3Xa6LS7Nit?=
 =?us-ascii?Q?t6hgAXT6qmTvocBi/M97e1h+y4XNE9X3XNyzmnguetQ6g3PJVl9rygVmoUpz?=
 =?us-ascii?Q?39gfHOSYrKsB66wbuKDzkIiqmsUi1Zv/vj0TIp5DL5+QrHCGDXSgt3sfpkUY?=
 =?us-ascii?Q?lprJplfI7YbNS6/3oO+wKDWCZSghpzOhSbvErXaixPLEVEgOar2o+GQbLw1X?=
 =?us-ascii?Q?VI2UH1zi08uZiwpiQ/avYponGvjTzkgCaXs5h2BM3T9HpJBjGKjw4CRRQJas?=
 =?us-ascii?Q?FWtdeuNTEzkAse2kaMj5w5fkrKVl1ZcJcQaAZ5yNvXHPKwWw8EweXYtiNCyH?=
 =?us-ascii?Q?/f9/ZfUVWCok+ASY2/QAVqH7TUocvzPI1jlTbLGd8noRBQmRo5FwqJNdguTs?=
 =?us-ascii?Q?fhfUErTmT5Kbq7NYJIKxVPxder49SE0hWKL3P4JhtEtbZch/nVRRT9NQzaGw?=
 =?us-ascii?Q?WUofCHXwPdl3+pCwMZ0B/QMzR7r4ofxI9MCGPCd3jOXvnbgSHAphC2XX5pVs?=
 =?us-ascii?Q?wreNRIlhSgCa0JiZTY6f5R2GsB72mR46pmZJ/CkU8P2HbfwSUpWu91GNTtch?=
 =?us-ascii?Q?sHRXlpSRt5dr8jGcOOsD/t10L+g4mFe+24s6T5xHdoMmQK/6zGeVZf7vK2cs?=
 =?us-ascii?Q?zj2BXzBKZiK8O+F4v1VigFmie9/3WzhU5rqde1pDrySeWLR+qNXEzqoNjHNk?=
 =?us-ascii?Q?KxkPbFvcsCttlHbq6R92eV9WtoFI9xakgtxqcQeyEsQeeq0Xh5cKcmDvfg9L?=
 =?us-ascii?Q?zLLN5uRfq8tFCBALjqe6A5xduoi7VTZmhUFtXDtAJ7sikLdMUFsHjlS8iBXB?=
 =?us-ascii?Q?afreDTFu1shUDc5OJ/szdX5uyFaa4uXdG6xltHs3ZwDAFz4jQeMTFTXrj3XQ?=
 =?us-ascii?Q?DLoYG2mymYrH4Kf162bJVpRAGu3WPO7LBGr9CUyRQffNebSvJ/9CbE2xTo4r?=
 =?us-ascii?Q?VtLsMOJYcTV+c4bbQEujp6XfZ/uXWE9I0FX1QdCqCbVEBqF0ctS/13Fjb0ce?=
 =?us-ascii?Q?d4M43fFK7xPGBsuAg6E=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5257.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d05338df-06fc-47c3-ffa1-08ddc3a73b9d
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Jul 2025 13:55:18.3034 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: xtY7RURSv9lbxajvv7qPWE/kXqSi/JCo4NjA3sZS07mINdE/qnqv6tdpfXoLOCch63SVh6QgwrLv6KGUbfOQsg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7899
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

[AMD Official Use Only - AMD Internal Distribution Only]

Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>

Regards,
Hawking
-----Original Message-----
From: Lazar, Lijo <Lijo.Lazar@amd.com>
Sent: Monday, July 14, 2025 13:22
To: amd-gfx@lists.freedesktop.org
Cc: Zhang, Hawking <Hawking.Zhang@amd.com>; Deucher, Alexander <Alexander.D=
eucher@amd.com>; Koenig, Christian <Christian.Koenig@amd.com>
Subject: [PATCH] drm/amdgpu: Increase reset counter only on success

Increment the reset counter only if soft recovery succeeded. This is consis=
tent with a ring hard reset behaviour where counter gets incremented only i=
f hard reset succeeded.

Signed-off-by: Lijo Lazar <lijo.lazar@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c b/drivers/gpu/drm/amd=
/amdgpu/amdgpu_ring.c
index 426834806fbf..6ac0ce361a2d 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c
@@ -427,6 +427,7 @@ bool amdgpu_ring_soft_recovery(struct amdgpu_ring *ring=
, unsigned int vmid,  {
        unsigned long flags;
        ktime_t deadline;
+       bool ret;

        if (unlikely(ring->adev->debug_disable_soft_recovery))
                return false;
@@ -441,12 +442,16 @@ bool amdgpu_ring_soft_recovery(struct amdgpu_ring *ri=
ng, unsigned int vmid,
                dma_fence_set_error(fence, -ENODATA);
        spin_unlock_irqrestore(fence->lock, flags);

-       atomic_inc(&ring->adev->gpu_reset_counter);
        while (!dma_fence_is_signaled(fence) &&
               ktime_to_ns(ktime_sub(deadline, ktime_get())) > 0)
                ring->funcs->soft_recovery(ring, vmid);

-       return dma_fence_is_signaled(fence);
+       ret =3D dma_fence_is_signaled(fence);
+       /* increment the counter only if soft reset worked */
+       if (ret)
+               atomic_inc(&ring->adev->gpu_reset_counter);
+
+       return ret;
 }

 /*
--
2.49.0

