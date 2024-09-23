Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E9687CF9C72
	for <amd-gfx@archiver.kernel.org>; Mon, 23 Sep 2024 14:58:50 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9826B10E25C;
	Mon, 23 Sep 2024 14:58:50 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Bqr/jlwI";
	dkim-atps=neutral
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2063.outbound.protection.outlook.com [40.107.92.63])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5820710E25C
 for <amd-gfx@lists.freedesktop.org>; Mon, 23 Sep 2024 14:58:49 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kpLI9ww5xlvqfbpXTr7a4JiO3bK4G/FoPY1sWHqtcRyK/wIY0ESU4z/TouOpJIB4mwlsXMd8/QX3o2+vuvilgCz9m+tkYt6nknoV1/uk5/oScnpiPNF3eRYwB/eKaIcy87No7gi8sqykLTBbwqf84vovzN3i4j0RpB6IjDuutvJ0apc0MqkrXOFhih5dp2t1M9T9qthnNZueyWqZNZAPQZr2hhhbEMyChlSaQW1qXppVMQlrKbvvACrml/8WAMJ2d5IvOIiOTeb7sVFPUdrFfDJ8WdCwEScjW1xAOIAUuWKFpGGfFgS7Hgf/Xgt1I0iVAPWyqULKqrBYDTM5pV0Y5A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rK1nkwMuxeoWyXr7UI8+UqighTDOKEdT4erkO8a8Otk=;
 b=MnJkbZrWiV214jrsQw7OeLMwcLIYnqU8UU/cf6G23yK+jBtMBlIDuYwazL99NHTbF1AJ8DzRLGpWL4S3A8lINsFXuQZFGcllNbpxyqOnUiVOCFh8uivGaIUG/2ReBeH2GNn/Y1xGpbrYemstSYQoUj/cvP/enYd3PI/WXFhBTV4ejoL0j/jgCCc4OZM6hpx9/q7U3YJP5lDNpPg08w4zhJcxiDWsECaI6tMy/WvFMQm+CP2uEdLh7mmuBn70jfrK4vp3BLnTi7n0W2U8CD9sGZh37CbrD9cR9oXCT6XTRuu0Rgu9pJDP2UPJ0OrMi/CuxbRi9xB0gaDzy+IkhBKZ+w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rK1nkwMuxeoWyXr7UI8+UqighTDOKEdT4erkO8a8Otk=;
 b=Bqr/jlwIvASFGCHT3ahexAjOac93xYcy3yPX5HbsHRWwPOhYmf3y70Jwwww+mwCN5Spb0mvrncER1fs+a/sgGelpE+Rag/ZISxBxc2oN8eYPeOA0YcZCzljcX4ILqQ164qirFbQdulmCMwgPSKARWWEoxDc1RAczW6+LPHn5yhM=
Received: from CY8PR12MB7099.namprd12.prod.outlook.com (2603:10b6:930:61::17)
 by DS7PR12MB8417.namprd12.prod.outlook.com (2603:10b6:8:eb::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7982.25; Mon, 23 Sep
 2024 14:58:43 +0000
Received: from CY8PR12MB7099.namprd12.prod.outlook.com
 ([fe80::314f:877c:8b6f:52d6]) by CY8PR12MB7099.namprd12.prod.outlook.com
 ([fe80::314f:877c:8b6f:52d6%7]) with mapi id 15.20.7982.022; Mon, 23 Sep 2024
 14:58:43 +0000
From: "Kasiviswanathan, Harish" <Harish.Kasiviswanathan@amd.com>
To: "Joshi, Mukul" <Mukul.Joshi@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH 2/2] drm/amdkfd: Fix CU occupancy for GFX 9.4.3
Thread-Topic: [PATCH 2/2] drm/amdkfd: Fix CU occupancy for GFX 9.4.3
Thread-Index: AQHbC6EeBT0nb3PE/k+JsyIQsnhl/LJleedQ
Date: Mon, 23 Sep 2024 14:58:43 +0000
Message-ID: <CY8PR12MB7099ABCC8BFD35576E86A1F18C6F2@CY8PR12MB7099.namprd12.prod.outlook.com>
References: <20240920210715.64118-1-mukul.joshi@amd.com>
 <20240920210715.64118-2-mukul.joshi@amd.com>
In-Reply-To: <20240920210715.64118-2-mukul.joshi@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ActionId=c1f65293-a376-4f87-af56-0f828498e02c;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=0;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=true;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution Only;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2024-09-23T14:55:08Z;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CY8PR12MB7099:EE_|DS7PR12MB8417:EE_
x-ms-office365-filtering-correlation-id: 81f0607c-d917-456d-a0fa-08dcdbe03787
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|1800799024|376014|366016|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?76HCLLhUGwTpPyQOxZ9xZQtpfeIdOEfeEI+Qh/zn4mMdyTzNYy96Utg8HuwG?=
 =?us-ascii?Q?Z0i9XQfNJcFrf0+hq2mdEt2oqsI8imY6u66nXnGGvPyR0K+ewYthfzQLiYcb?=
 =?us-ascii?Q?F8GXiVR/OErcS8ArEIAeSCjwLeXd52bYuhrRBccHZ6gySn4Y6WwjaIe+FXAs?=
 =?us-ascii?Q?ci4V8HKl5y/U9pukRJOFJIpN84/zV7NX41zr73TWRYuyzvV1OyGm/hVHubx/?=
 =?us-ascii?Q?dDkedAnjTUkhKiDX8qPrCdSqbM2uznhTrHza5nN43u0OGkboGvwzX5oAcRad?=
 =?us-ascii?Q?i2JctXw6CMiLqrGGH3m8tonhBheJRTHfD2R81kdE8k8EjRt/n79QEaeeyDTN?=
 =?us-ascii?Q?c0noTg9yhnF/ZmpqBbHwdFVQSq9gSkrQxPiR/GSRCs2HEAho39mSV6AWE/0Z?=
 =?us-ascii?Q?uZ8uyXZrQ0k57GPGrTA5h/2oxxox/Bxs9nXyJyCX6TCOiZqMOnzizw37OqdK?=
 =?us-ascii?Q?Eh/zIxi4T5rQeBoM8lEXyT/4I0WnpWa1ReA7ZR334FmZm6ghTDC2qzEbFxXr?=
 =?us-ascii?Q?Ad46JXORUNPcKbw1MKl5/KMKTevdpXTP/wdllWPfsDzAPdpRB08OQA2Q7qt1?=
 =?us-ascii?Q?EfSWS/d/JGbn5D18gZJoE11S3xiPGo/I4MR4Vyerj5t3UbIIAwvzpiFn8U9F?=
 =?us-ascii?Q?ftEpKwj5ZHbQwC1h0kQ7+/vHeqom3sLt13udFgMwmEYFvlTvZ9r+ETfv+UJJ?=
 =?us-ascii?Q?ubFCM6/7wHQYyTEBQml+iiHWCUYsvCLP8VVFRVDFdnY1+fgTr2ZSGJfDdBYs?=
 =?us-ascii?Q?Aq/SRC90sGEX2GEaQBeDptjnqwqvaQwi0X0Zc/8/yi2rGDsL6yPM9bOCfOOg?=
 =?us-ascii?Q?dmNxezVozudCrAu44RYz5B5KeKPbdMkeB1hCjzjhUj1ZevpnfixGd4JqnOJk?=
 =?us-ascii?Q?bVMucDOvLAEaC0tlgciESSN4aAe1EkByG1V7dKOqsGiCApPgpKFzgW+wtpdZ?=
 =?us-ascii?Q?IQNy4afSzXCUzwtkWvIJ9d3x2NTPLOUvC//AST3n5sasDREjr2AKzAgEYrLV?=
 =?us-ascii?Q?BW0QjzNbwCxAznq7BtxXEs0TQHjYRbNLw2XG1i0l3KF65bjF4cYuJc8/dzoq?=
 =?us-ascii?Q?RUF5mtl3ct2LavVwSO/M6zmAke0MfCiJ8YqeiWk2xa9fp2PrwP+r5xUSLF7v?=
 =?us-ascii?Q?RTvSdFhOIE5AdgxYL1EMVkvmhF9SgF1vH1y/A2yLh7XV3tyvg9M93dBxfCNq?=
 =?us-ascii?Q?yxWTruhPfrOJvEhsYDyqKzXuNDeYLcrChp4gukbmdnFmWoowlnxv5vRkrNJf?=
 =?us-ascii?Q?2VQcMNU5DPWN+YFtoQS60egzT+5DOs+xd5HEH5vLDql9Wynx6kh6kO98nzmR?=
 =?us-ascii?Q?hxmjkCSdVckNGKh2CnK6KvT7y4KuSqnhB8vQ1d/SZqHmGg=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CY8PR12MB7099.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(38070700018); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?b4xAS9WUZl+sgdT/YKLBIeZrYJUtiRgHAyqPA+pvgnkOIXiZgECHCabwE0MB?=
 =?us-ascii?Q?EcOPDYljU46r1111ayi6vbr0AhXzf1gtFyX1VrGSRmQHHlmQSPoBo2WWWrsE?=
 =?us-ascii?Q?RpDFM77GVCP8XDIdWakVHqDEXt+qA19FuYrm+48cf7+E2/tSYDcHLWSGiYmc?=
 =?us-ascii?Q?7tRfRkPt9AIYPzBuDBRwIsGH5ez/rPWNZFnXV2PIU98XGLGTyD9z9++6H6r8?=
 =?us-ascii?Q?VwkIEaL3+q/D25dgg/78AvgGrw1QMlprEO6MGYL2FHpyAonddQEbX2GEOcdS?=
 =?us-ascii?Q?7k8XlysWVzs8Tn3ZfkweJWlkxTIEzRNN7YF9pmgn19ruYUZ34PNKdtFOLy1D?=
 =?us-ascii?Q?+MPRTYNWnnLRW14ACX3nQtcBfV22uU2xGHHKz9peVbSMS15ugLtOFqjMMLrJ?=
 =?us-ascii?Q?KcGgfXZgkNoUzCbfKPBuk5wZcPi/mBe2n02F2SCK8L74WSc2LM8kslcYGjFc?=
 =?us-ascii?Q?CZWAIZnS+lt1dtT26/1lZsbsd4LD3TK9DUWJocNdXn/gUXub0QW76BnD5cC7?=
 =?us-ascii?Q?YvsSw3jkJCYLq1VqPyq13LQ3llKPp3cQ0cSqdpBtiIihQPzlCjoiIFRew8/m?=
 =?us-ascii?Q?Red7mcS9Xkswifpt0+5vvB0GShxk6L2B+DhLRHP9cn9wauGFFjtp/01cZU+k?=
 =?us-ascii?Q?mPk+FAc4xjjrjO37iTv2/SgatZaVSP1PY6Gf+MMBi9WkdWu60U42Nxvdbk8Q?=
 =?us-ascii?Q?P/3zyNKHeeTiyRY8RPQDjmF1wBA0ZIRyNEkNkVN7fPiUrArkyBIqBDNEFE53?=
 =?us-ascii?Q?JekOMNm+Vd6sTIdv4jRcqSjxUf0oXRYPgmL1xvVbm98UU+JNSg/AbVEl+4Yn?=
 =?us-ascii?Q?jt3VaLKQXsn2Rs7K5mDvIAONgMufgvGQPAg9pnkWI9QVQlt9BhcA1ncCjudw?=
 =?us-ascii?Q?cCn2Em0RJu3RHUado5I1Gfcdb+nWZYbb1PiWKmdk0NWn9CmWUbboTtA5Uxwj?=
 =?us-ascii?Q?1Rh/PZ0CHAqikI3WlfF5kHu47FLZpSTUcpxU+m5qgSlM5c86kwcP2a9IIhKr?=
 =?us-ascii?Q?djBqxiirXxKwqRellE341mj0O4DvkBaULUS2Z6JzcDg0HMt7jdPKTPsphtrX?=
 =?us-ascii?Q?Jisvs6PI3xSRm/rGUmW2LVlJGtnt3KEFfc6vtU20ZWqxsD8uinD6FHnsvHhp?=
 =?us-ascii?Q?uJ1PWa9iRyzJdlaDRvYtWNjIko8NY5kQIlz/zU1JBawnhQcFzlhnbx7lyyhD?=
 =?us-ascii?Q?v/cNqz/OW5iyGOJ9SEhu/5bt/IpM7vDMWBAwGoCGTv9pENq/JwXHw9zSYtmS?=
 =?us-ascii?Q?bU7nItdg9fEXb46sx6butgVp5bLAee1eA/pe/2g1+MiwzZ72iHzMh503/+yF?=
 =?us-ascii?Q?gWGw/uufI8/7O6K4GmwF+anDEKe0LsQyJ9zBohpv2JqD5E+kc3EOFRS7Z2Sr?=
 =?us-ascii?Q?wlnzPPTW+49l/2NlEdZGUO7j38xy5Mk+hDQhtmNonHtA1zMOIMr7H238tFDA?=
 =?us-ascii?Q?q6jMkr4HqCNCnQEC1VrJFD0rlDnd107KEoqJGUPGE/Uh7ad3f1F9W5ncEnMM?=
 =?us-ascii?Q?y2EfJovT4B6QjItGOfSNxcIVqE75rxGkUcjDMmvZo9z1XqhkUx41ttNJdTsM?=
 =?us-ascii?Q?s8bvfbOJY66W4h/lWjE=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY8PR12MB7099.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 81f0607c-d917-456d-a0fa-08dcdbe03787
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Sep 2024 14:58:43.0498 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 6k5GfBp/UmKye86YDgn996ePVsm6SHlTigjZdEi9pIXEu8DioWgwy8UjfcCn4MesRhzN1KP7qfOciJs5uSwOUw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB8417
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

One comment below. With that addressed
Reviewed-by: Harish Kasiviswanathan <Harish.Kasiviswanathan@amd.com>


-----Original Message-----
From: Joshi, Mukul <Mukul.Joshi@amd.com>
Sent: Friday, September 20, 2024 5:07 PM
To: amd-gfx@lists.freedesktop.org
Cc: Kasiviswanathan, Harish <Harish.Kasiviswanathan@amd.com>; Joshi, Mukul =
<Mukul.Joshi@amd.com>
Subject: [PATCH 2/2] drm/amdkfd: Fix CU occupancy for GFX 9.4.3

Make CU occupancy calculations work on GFX 9.4.3 by
updating the logic to handle multiple XCCs correctly.

Signed-off-by: Mukul Joshi <mukul.joshi@amd.com>
---
v1->v2:
- Break into 2 patches, one for the generic change
  and the other for GFX v9.4.3.
- Incorporate Harish's comments.

 drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v9.c | 12 ++++++------
 drivers/gpu/drm/amd/amdkfd/kfd_process.c          | 10 +++++++++-
 2 files changed, 15 insertions(+), 7 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v9.c b/drivers/gp=
u/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v9.c
index fe8a8e7e9a9a..e6bc808d9c59 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v9.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v9.c
@@ -963,14 +963,14 @@ static void get_wave_count(struct amdgpu_device *adev=
, int queue_idx,
         */
        pipe_idx =3D queue_idx / adev->gfx.mec.num_queue_per_pipe;
        queue_slot =3D queue_idx % adev->gfx.mec.num_queue_per_pipe;
-       soc15_grbm_select(adev, 1, pipe_idx, queue_slot, 0, inst);
-       reg_val =3D RREG32_SOC15_IP(GC, SOC15_REG_OFFSET(GC, inst,
+       soc15_grbm_select(adev, 1, pipe_idx, queue_slot, 0, GET_INST(GC, in=
st));
+       reg_val =3D RREG32_SOC15_IP(GC, SOC15_REG_OFFSET(GC, GET_INST(GC, i=
nst),
                                  mmSPI_CSQ_WF_ACTIVE_COUNT_0) + queue_slot=
);
        wave_cnt =3D reg_val & SPI_CSQ_WF_ACTIVE_COUNT_0__COUNT_MASK;
        if (wave_cnt !=3D 0) {
                queue_cnt->wave_cnt +=3D wave_cnt;
                queue_cnt->doorbell_off =3D
-                       (RREG32_SOC15(GC, inst, mmCP_HQD_PQ_DOORBELL_CONTRO=
L) &
+                       (RREG32_SOC15(GC, GET_INST(GC, inst), mmCP_HQD_PQ_D=
OORBELL_CONTROL) &
                         CP_HQD_PQ_DOORBELL_CONTROL__DOORBELL_OFFSET_MASK) =
>>
                         CP_HQD_PQ_DOORBELL_CONTROL__DOORBELL_OFFSET__SHIFT=
;
        }
@@ -1034,7 +1034,7 @@ void kgd_gfx_v9_get_cu_occupancy(struct amdgpu_device=
 *adev,
        DECLARE_BITMAP(cp_queue_bitmap, AMDGPU_MAX_QUEUES);

        lock_spi_csq_mutexes(adev);
-       soc15_grbm_select(adev, 1, 0, 0, 0, inst);
+       soc15_grbm_select(adev, 1, 0, 0, 0, GET_INST(GC, inst));

        /*
         * Iterate through the shader engines and arrays of the device
@@ -1047,7 +1047,7 @@ void kgd_gfx_v9_get_cu_occupancy(struct amdgpu_device=
 *adev,
        se_cnt =3D adev->gfx.config.max_shader_engines;
        for (se_idx =3D 0; se_idx < se_cnt; se_idx++) {
                amdgpu_gfx_select_se_sh(adev, se_idx, 0, 0xffffffff, inst);
-               queue_map =3D RREG32_SOC15(GC, inst, mmSPI_CSQ_WF_ACTIVE_ST=
ATUS);
+               queue_map =3D RREG32_SOC15(GC, GET_INST(GC, inst), mmSPI_CS=
Q_WF_ACTIVE_STATUS);

                /*
                 * Assumption: queue map encodes following schema: four
@@ -1072,7 +1072,7 @@ void kgd_gfx_v9_get_cu_occupancy(struct amdgpu_device=
 *adev,
        }

        amdgpu_gfx_select_se_sh(adev, 0xffffffff, 0xffffffff, 0xffffffff, i=
nst);
-       soc15_grbm_select(adev, 0, 0, 0, 0, inst);
+       soc15_grbm_select(adev, 0, 0, 0, 0, GET_INST(GC, inst));
        unlock_spi_csq_mutexes(adev);

        /* Update the output parameters and return */
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_process.c b/drivers/gpu/drm/amd=
/amdkfd/kfd_process.c
index d73841268c9b..831e0e92bd23 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_process.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_process.c
@@ -292,8 +292,13 @@ static int kfd_get_cu_occupancy(struct attribute *attr=
, char *buffer)
        wave_cnt =3D 0;
        max_waves_per_cu =3D 0;

+       /*
+        * For GFX9.4.3, fetch the CU occupancy from the first XCC in the p=
artition.
+        * Later we multiply the wave count by number of XCCs in the partit=
ion to get
+        * the total wave counts across all XCCs in the partition.
+        */

Could you please elaborate little bit on this comment? So, here the assumpt=
ion is that it is AQL queue with cooprative dispatch. The values will not b=
e accurate for PM4 user queues.

        dev->kfd2kgd->get_cu_occupancy(dev->adev, cu_occupancy,
-                       &max_waves_per_cu, 0);
+                       &max_waves_per_cu, ffs(dev->xcc_mask) - 1);

        for (i =3D 0; i < AMDGPU_MAX_QUEUES; i++) {
                if (cu_occupancy[i].wave_cnt !=3D 0 &&
@@ -302,6 +307,9 @@ static int kfd_get_cu_occupancy(struct attribute *attr,=
 char *buffer)
                        wave_cnt +=3D cu_occupancy[i].wave_cnt;
        }

+       /* Update wave_cnt for the number of XCCs in the partition */
+       wave_cnt *=3D NUM_XCC(dev->xcc_mask);
+
        /* Translate wave count to number of compute units */
        cu_cnt =3D (wave_cnt + (max_waves_per_cu - 1)) / max_waves_per_cu;
        return snprintf(buffer, PAGE_SIZE, "%d\n", cu_cnt);
--
2.35.1

