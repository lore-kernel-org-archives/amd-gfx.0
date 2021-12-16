Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A02FDC433F5
	for <amd-gfx@archiver.kernel.org>; Thu, 16 Dec 2021 20:04:15 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4968A10EDF6;
	Thu, 16 Dec 2021 20:04:15 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2080.outbound.protection.outlook.com [40.107.92.80])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 53EDA10EDF6
 for <amd-gfx@lists.freedesktop.org>; Thu, 16 Dec 2021 20:04:14 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dV//nmHQhBRPibvB/gQ81C8axqWbwgPQ1b8WHa+UkPECHN/JLarqSY+3CPNiOJ2mp14AQpiTqhzTF2ZT/Jj7sVfTe+X1yEMia5POPTIrhvFSqv8QYUjyVMPBqAOXLHc1WIUuZ3i1BT18S7Go+Ik62F4vs2FjW9h3o0D96h33MGv9IGaV4Gjoyq59qb8LOufpqkEPK3Xc7Z01lxPsb4jClcF0rXxXUDoZNtvm1Qig8o5cfesVhzTIazrN8h5wW+yyiqlsPMugIkh44UIzSnUtkZ/8MoN36RZ7G9OHjxn4HqjWvURnT7R0x7D1exAME7nAlp9gMvYq3xawxd1lmLMVJg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2LdpSeC6q2tmrLu69iZE0abeNd9xbE89Ovhs+N/of4o=;
 b=X7vIUfC+z+QJn6NX/uixVBhfoSI8Kha8qUkRR0/Yb/oF/IFUhhvm0wC0kwMH828zFVmSFjVT3NxVIA9UiRfZsoegQvlvkLzC8gXNSu1J5/7KnSnLc2F8KaaRDlrJNTW7dJ4RZzMc6xYCS6BB0AkW0BUoHO5J3pPTURtqWq284T41xFlTJ2qZghafUm7pY5HSO5zF64IIMKsqCFN4qSMVqq4Nh4t9nHSaZUr7CG9efif9P6NwBo7ukw1ckm/sHXzJ/GU7gNdeRGcP4Q8arvXuPtUx6BuGHL4Tc1NVKvOv+1yJUQfRHp7/55dMX1Md1hiv6FpCzFt7dQe7z9nBYKl3eA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2LdpSeC6q2tmrLu69iZE0abeNd9xbE89Ovhs+N/of4o=;
 b=ASwEc9uc9JQ+Q8+Z94I7BWCsJy4LXrzHzrqFGaWM4pmafXSmtOue/uFTliHWY01BdPe77+/kV+wsygprFCO/PmRegM2AiMq5KJXfqxskbUduTwUnx93cafnaVoArf06rAH9tZfSvKA8EAivtHzHm+tS8mscWVd6G1WRv3DVitXI=
Received: from BYAPR12MB2840.namprd12.prod.outlook.com (2603:10b6:a03:62::32)
 by BYAPR12MB4630.namprd12.prod.outlook.com (2603:10b6:a03:107::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4801.14; Thu, 16 Dec
 2021 20:04:12 +0000
Received: from BYAPR12MB2840.namprd12.prod.outlook.com
 ([fe80::5425:7b82:3787:d5fa]) by BYAPR12MB2840.namprd12.prod.outlook.com
 ([fe80::5425:7b82:3787:d5fa%5]) with mapi id 15.20.4778.019; Thu, 16 Dec 2021
 20:04:11 +0000
From: "Nieto, David M" <David.Nieto@amd.com>
To: "Skvortsov, Victor" <Victor.Skvortsov@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>, "Deng,
 Emily" <Emily.Deng@amd.com>, "Liu, Monk" <Monk.Liu@amd.com>, "Ming, Davis"
 <Davis.Ming@amd.com>, "Liu, Shaoyun" <Shaoyun.Liu@amd.com>, "Zhou, Peng Ju"
 <PengJu.Zhou@amd.com>, "Chen, JingWen" <JingWen.Chen2@amd.com>, "Chen,
 Horace" <Horace.Chen@amd.com>
Subject: Re: [PATCH v3 3/5] drm/amdgpu: Modify indirect register access for
 amdkfd_gfx_v9 sriov
Thread-Topic: [PATCH v3 3/5] drm/amdgpu: Modify indirect register access for
 amdkfd_gfx_v9 sriov
Thread-Index: AQHX8rUfuaEgEDHSf06pC7EYxCwb2qw1isD0
Date: Thu, 16 Dec 2021 20:04:11 +0000
Message-ID: <BYAPR12MB2840998060B18B3BA660CB9CF4779@BYAPR12MB2840.namprd12.prod.outlook.com>
References: <20211216194233.3839-1-victor.skvortsov@amd.com>
 <20211216194233.3839-4-victor.skvortsov@amd.com>
In-Reply-To: <20211216194233.3839-4-victor.skvortsov@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Enabled=True;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SetDate=2021-12-16T20:04:11.219Z;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Name=AMD
 Official Use
 Only; MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ContentBits=0;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Method=Standard; 
suggested_attachment_session_id: 6a9c23aa-c691-88d1-ad33-c2ba3b968f89
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: dcca9426-d3a2-4200-3064-08d9c0cf3a61
x-ms-traffictypediagnostic: BYAPR12MB4630:EE_
x-microsoft-antispam-prvs: <BYAPR12MB46307FA495F66B06AF7813C0F4779@BYAPR12MB4630.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:475;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: pV3Sj8cIgjhzq0hwyYhNgUkRt9wjatWEp3WR1NjEazOzj+mSG1TS91i0CbmZkP8BZr9ncKOlLBwzYkEbvJAXv5QhfKUfcktyWrjstrr2T9IbAtE7qjLR71XWJsV76Vp9dWXz0KyKk0p9xEeAbrDyBSVOBDz5nzWCj4wNT73FDJOHF/MawkqBCk9ealYzMAj6TG/TKJqo/m9MVeN2hcpAdhVBuzm3FHw7M9y85/NIz2KwpobaHDA1At8U0fwtjywh86TvfTqX7PRQ7lWnDEMZ/IS6wlIwUj1yKlpE+BDsNi8RM4dB7OsYfOQ6+y+m87Ub2ZA6I8Gs4zvUmXvUiDTPwGaiXR4ngxGeYjj7NByFQdhRTPxmL2SGkxT0Bbel00QGJKFIPFa6mkVrlF5cvRp7/fbysgXQktWB117ES3lW00jbNlYrrkEwIXDvRcRTpFyq+eAaTdY+Ez5ODRHUwycJZ6vJuZ9ACw7I3oGaSOOyJfVxfeWu51oivybXFzSdOqOaPBjYKzvpHjl1Gfy/LDppoHW/FfjTXLhQZYen4gBLDfA2ipmH8AyYM04ljBuVHDKxurwq+SgtVmncPlqTMaFtjo4zcwVndvWE3NOhBuZOMkp1xIpzrklpJjAAJBPOQwwMZkR6TMsYxKpV1MHlZhm/tys/bS9Z+qIU0GfRSoEIe0zqVxAY7b6zqto6IOYP4fGZ9AggllpVG0dWI4a+0MDCi60LbknOJ2ixu7EVUcLCxaM=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR12MB2840.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(33656002)(110136005)(55016003)(2906002)(6636002)(38070700005)(19627405001)(316002)(66476007)(86362001)(7696005)(53546011)(6506007)(52536014)(83380400001)(921005)(66946007)(5660300002)(76116006)(8676002)(66446008)(64756008)(66556008)(186003)(508600001)(9686003)(8936002)(122000001)(38100700002)(71200400001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?l1BcTAqLL2+4D9PjiQ1/SJasB/ZuekJ/d/LdkC6DhZJqBjM/Tnuvw7FsoRc4?=
 =?us-ascii?Q?aZzozL3hT6Lr1kvHqsA3DwGzJQVMr6Ev62b5nLSN5GGe1J0gUWAh3W+k9Est?=
 =?us-ascii?Q?RYUqBqFMmOjTMKql/8FTTyvaL/y9HTDUUtM+l6xQXgLDLd0lEgIt2D7CoAUM?=
 =?us-ascii?Q?S9Sob/FYNTyQfsc4xyIlps0aN+dTzrzb/OE7b3Z5+Lwy0Au9SdB8GKmxUD+H?=
 =?us-ascii?Q?txoWcD85P4PSFONhyxcCfHvQltKDahPBlbvfRygqc3GlfR0M8zTKH6Bq3fmh?=
 =?us-ascii?Q?vvOO6KEQtacJd93+bsc69vx1DZJztwTfbcYKZhybrC9ynxLibt/65yukXrDR?=
 =?us-ascii?Q?xuFS6LbJf7EI4dQ3KM3/B89vsMEC8zoX7icRwF2rh3OyBK97e6iOypYLd8Vv?=
 =?us-ascii?Q?CNilRYAtz8I1D0T7AoAtFYIgx3PVI0JF7ZFOsetWBkoHQ3XWYLzaYUlgOqkX?=
 =?us-ascii?Q?lDqFviOXsvkk/YBfbIIjXf8/UzOr94j4UASG/dvw9UNKGiDo2QeU0/O/2Xfz?=
 =?us-ascii?Q?cXafWSuj3qyszRTHGCxcddKQvtORWNiupOXUrmulmKBQWPFqw83ZAtf56JBL?=
 =?us-ascii?Q?Hw0lv/jMP7mODiTh+oZLUTa47QHjmvodMfAiIgjxK0itEKTP+HdU2mzQn20l?=
 =?us-ascii?Q?mXiKWqdtDFLm00LwzlFH4Gr6bcoWrvpEFYgwhdrL45YPaJiRGdvdUwO9kHda?=
 =?us-ascii?Q?SXViAjkHyPpPH6lysoGkIg8SXMATLXHdUPbZGTD7maiM6d9vWmsTGtmU4nls?=
 =?us-ascii?Q?icCV1qSwVmpx07tFZwicXMF6mizxW7Hkst9UERqvuLL8n6qsWfsAxDSaWbJ9?=
 =?us-ascii?Q?1oSKMikB/V1vJtiB8iRkjg9z1Db+5jNVkddYygZcv8UgDdU0ad981vjz/azC?=
 =?us-ascii?Q?Xwxz4uTB7pHpjZ25zpq2pHHiDX8LQwBtr3lboCnPMufOTXdbyHmcjySxU4UV?=
 =?us-ascii?Q?7iefVnvC/atm8gMNTYc0QUifDJoZCpUIbsyXIVSe0YbGfnB6RTg1A/jK0GQX?=
 =?us-ascii?Q?aniFCaS9EEQDNkiew2pPQU4C4/JsNXs8STQg65m53Fo4irHuMOeWHRVVS22z?=
 =?us-ascii?Q?lyDs74e/xw+zfPZWT90/BitTYhL3BfrvcxPc5uytqcWF6P2LWQbkIAJ0VymC?=
 =?us-ascii?Q?bxD6eHCIXNEZOrEbLtMIH95c406Y9i08WH7z/Oz58w9/jkVSAPQEx9Mk5lvT?=
 =?us-ascii?Q?MOquNcOG/1frcgyykH04wUwEOxftnaAPKBEf8ujYU9DC2rf3R4D+zNEivrWK?=
 =?us-ascii?Q?U1PiMc4Vwv90CTacmkIGQd0594beZPhZ0yO3NNheTDPH5ivQ68SOOjIe5cp0?=
 =?us-ascii?Q?kjJNnUTkGsrj7HCayOfOuPkyOUjKumFJkn9TL4xHmNnAOag3ORNoqVw9khCX?=
 =?us-ascii?Q?4pQ+EoGALdIQTieo0qeWLG65DtzIdGJ3sWwPVqsSxjateibv6eGRfOA5NBdC?=
 =?us-ascii?Q?z1Q5k4ItnfH05H3g7/5he3ZyW6ynECZTHHNvl7h/NadrXaCab5lTG+AMCUWt?=
 =?us-ascii?Q?DrodPSWgwK12HeWBY/Gr+EDMpGNHfjm9vImujOylEDFzGnzQcJYiWM2GZ2tN?=
 =?us-ascii?Q?yR8m3O0EyadsFvTMVB/7mzn4bqFhooeZ92gKR3A9?=
Content-Type: multipart/alternative;
 boundary="_000_BYAPR12MB2840998060B18B3BA660CB9CF4779BYAPR12MB2840namp_"
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB2840.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dcca9426-d3a2-4200-3064-08d9c0cf3a61
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Dec 2021 20:04:11.7928 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: wrRs1ur8TFQTIckwFIxs0mFUki3/O6jq+WocDiFgnOhPBxfCxpBoe63J3aMIBVFm
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB4630
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

--_000_BYAPR12MB2840998060B18B3BA660CB9CF4779BYAPR12MB2840namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

[AMD Official Use Only]

Reviewed-by: David Nieto <david.nieto@amd.com>
________________________________
From: Skvortsov, Victor <Victor.Skvortsov@amd.com>
Sent: Thursday, December 16, 2021 11:42 AM
To: amd-gfx@lists.freedesktop.org <amd-gfx@lists.freedesktop.org>; Deng, Em=
ily <Emily.Deng@amd.com>; Liu, Monk <Monk.Liu@amd.com>; Ming, Davis <Davis.=
Ming@amd.com>; Liu, Shaoyun <Shaoyun.Liu@amd.com>; Zhou, Peng Ju <PengJu.Zh=
ou@amd.com>; Chen, JingWen <JingWen.Chen2@amd.com>; Chen, Horace <Horace.Ch=
en@amd.com>; Nieto, David M <David.Nieto@amd.com>
Cc: Skvortsov, Victor <Victor.Skvortsov@amd.com>
Subject: [PATCH v3 3/5] drm/amdgpu: Modify indirect register access for amd=
kfd_gfx_v9 sriov

Modify GC register access from MMIO to RLCG if the indirect
flag is set

Signed-off-by: Victor Skvortsov <victor.skvortsov@amd.com>
---
 .../gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v9.c | 27 +++++++++----------
 1 file changed, 13 insertions(+), 14 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v9.c b/drivers/gp=
u/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v9.c
index ddfe7aff919d..1abf662a0e91 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v9.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v9.c
@@ -166,7 +166,7 @@ int kgd_gfx_v9_init_interrupts(struct amdgpu_device *ad=
ev, uint32_t pipe_id)

         lock_srbm(adev, mec, pipe, 0, 0);

-       WREG32(SOC15_REG_OFFSET(GC, 0, mmCPC_INT_CNTL),
+       WREG32_SOC15(GC, 0, mmCPC_INT_CNTL,
                 CP_INT_CNTL_RING0__TIME_STAMP_INT_ENABLE_MASK |
                 CP_INT_CNTL_RING0__OPCODE_ERROR_INT_ENABLE_MASK);

@@ -279,7 +279,7 @@ int kgd_gfx_v9_hqd_load(struct amdgpu_device *adev, voi=
d *mqd,
                        lower_32_bits((uintptr_t)wptr));
                 WREG32_RLC(SOC15_REG_OFFSET(GC, 0, mmCP_HQD_PQ_WPTR_POLL_A=
DDR_HI),
                        upper_32_bits((uintptr_t)wptr));
-               WREG32(SOC15_REG_OFFSET(GC, 0, mmCP_PQ_WPTR_POLL_CNTL1),
+               WREG32_SOC15(GC, 0, mmCP_PQ_WPTR_POLL_CNTL1,
                        (uint32_t)get_queue_mask(adev, pipe_id, queue_id));
         }

@@ -488,13 +488,13 @@ bool kgd_gfx_v9_hqd_is_occupied(struct amdgpu_device =
*adev,
         uint32_t low, high;

         acquire_queue(adev, pipe_id, queue_id);
-       act =3D RREG32(SOC15_REG_OFFSET(GC, 0, mmCP_HQD_ACTIVE));
+       act =3D RREG32_SOC15(GC, 0, mmCP_HQD_ACTIVE);
         if (act) {
                 low =3D lower_32_bits(queue_address >> 8);
                 high =3D upper_32_bits(queue_address >> 8);

-               if (low =3D=3D RREG32(SOC15_REG_OFFSET(GC, 0, mmCP_HQD_PQ_B=
ASE)) &&
-                  high =3D=3D RREG32(SOC15_REG_OFFSET(GC, 0, mmCP_HQD_PQ_B=
ASE_HI)))
+               if (low =3D=3D RREG32_SOC15(GC, 0, mmCP_HQD_PQ_BASE) &&
+                  high =3D=3D RREG32_SOC15(GC, 0, mmCP_HQD_PQ_BASE_HI))
                         retval =3D true;
         }
         release_queue(adev);
@@ -556,7 +556,7 @@ int kgd_gfx_v9_hqd_destroy(struct amdgpu_device *adev, =
void *mqd,

         end_jiffies =3D (utimeout * HZ / 1000) + jiffies;
         while (true) {
-               temp =3D RREG32(SOC15_REG_OFFSET(GC, 0, mmCP_HQD_ACTIVE));
+               temp =3D RREG32_SOC15(GC, 0, mmCP_HQD_ACTIVE);
                 if (!(temp & CP_HQD_ACTIVE__ACTIVE_MASK))
                         break;
                 if (time_after(jiffies, end_jiffies)) {
@@ -645,7 +645,7 @@ int kgd_gfx_v9_wave_control_execute(struct amdgpu_devic=
e *adev,
         mutex_lock(&adev->grbm_idx_mutex);

         WREG32_SOC15_RLC_SHADOW(GC, 0, mmGRBM_GFX_INDEX, gfx_index_val);
-       WREG32(SOC15_REG_OFFSET(GC, 0, mmSQ_CMD), sq_cmd);
+       WREG32_SOC15(GC, 0, mmSQ_CMD, sq_cmd);

         data =3D REG_SET_FIELD(data, GRBM_GFX_INDEX,
                 INSTANCE_BROADCAST_WRITES, 1);
@@ -722,7 +722,7 @@ static void get_wave_count(struct amdgpu_device *adev, =
int queue_idx,
         pipe_idx =3D queue_idx / adev->gfx.mec.num_queue_per_pipe;
         queue_slot =3D queue_idx % adev->gfx.mec.num_queue_per_pipe;
         soc15_grbm_select(adev, 1, pipe_idx, queue_slot, 0);
-       reg_val =3D RREG32(SOC15_REG_OFFSET(GC, 0, mmSPI_CSQ_WF_ACTIVE_COUN=
T_0) +
+       reg_val =3D RREG32_SOC15_IP(GC, SOC15_REG_OFFSET(GC, 0, mmSPI_CSQ_W=
F_ACTIVE_COUNT_0) +
                          queue_slot);
         *wave_cnt =3D reg_val & SPI_CSQ_WF_ACTIVE_COUNT_0__COUNT_MASK;
         if (*wave_cnt !=3D 0)
@@ -809,8 +809,7 @@ void kgd_gfx_v9_get_cu_occupancy(struct amdgpu_device *=
adev, int pasid,
                 for (sh_idx =3D 0; sh_idx < sh_cnt; sh_idx++) {

                         gfx_v9_0_select_se_sh(adev, se_idx, sh_idx, 0xffff=
ffff);
-                       queue_map =3D RREG32(SOC15_REG_OFFSET(GC, 0,
-                                          mmSPI_CSQ_WF_ACTIVE_STATUS));
+                       queue_map =3D RREG32_SOC15(GC, 0, mmSPI_CSQ_WF_ACTI=
VE_STATUS);

                         /*
                          * Assumption: queue map encodes following schema:=
 four
@@ -860,17 +859,17 @@ void kgd_gfx_v9_program_trap_handler_settings(struct =
amdgpu_device *adev,
         /*
          * Program TBA registers
          */
-       WREG32(SOC15_REG_OFFSET(GC, 0, mmSQ_SHADER_TBA_LO),
+       WREG32_SOC15(GC, 0, mmSQ_SHADER_TBA_LO,
                         lower_32_bits(tba_addr >> 8));
-       WREG32(SOC15_REG_OFFSET(GC, 0, mmSQ_SHADER_TBA_HI),
+       WREG32_SOC15(GC, 0, mmSQ_SHADER_TBA_HI,
                         upper_32_bits(tba_addr >> 8));

         /*
          * Program TMA registers
          */
-       WREG32(SOC15_REG_OFFSET(GC, 0, mmSQ_SHADER_TMA_LO),
+       WREG32_SOC15(GC, 0, mmSQ_SHADER_TMA_LO,
                         lower_32_bits(tma_addr >> 8));
-       WREG32(SOC15_REG_OFFSET(GC, 0, mmSQ_SHADER_TMA_HI),
+       WREG32_SOC15(GC, 0, mmSQ_SHADER_TMA_HI,
                         upper_32_bits(tma_addr >> 8));

         unlock_srbm(adev);
--
2.25.1


--_000_BYAPR12MB2840998060B18B3BA660CB9CF4779BYAPR12MB2840namp_
Content-Type: text/html; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<html>
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Dus-ascii"=
>
<style type=3D"text/css" style=3D"display:none;"> P {margin-top:0;margin-bo=
ttom:0;} </style>
</head>
<body dir=3D"ltr">
<p style=3D"font-family:Arial;font-size:10pt;color:#0000FF;margin:5pt;" ali=
gn=3D"Left">
[AMD Official Use Only]<br>
</p>
<br>
<div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0); background-color: rgb(255, 255, 255);">
<span style=3D"color: rgb(0, 0, 0); background-color: rgb(255, 255, 255); d=
isplay: inline !important;">Reviewed-by: David Nieto &lt;david.nieto@amd.co=
m&gt;</span><br>
</div>
<div id=3D"appendonsend"></div>
<hr style=3D"display:inline-block;width:98%" tabindex=3D"-1">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" st=
yle=3D"font-size:11pt" color=3D"#000000"><b>From:</b> Skvortsov, Victor &lt=
;Victor.Skvortsov@amd.com&gt;<br>
<b>Sent:</b> Thursday, December 16, 2021 11:42 AM<br>
<b>To:</b> amd-gfx@lists.freedesktop.org &lt;amd-gfx@lists.freedesktop.org&=
gt;; Deng, Emily &lt;Emily.Deng@amd.com&gt;; Liu, Monk &lt;Monk.Liu@amd.com=
&gt;; Ming, Davis &lt;Davis.Ming@amd.com&gt;; Liu, Shaoyun &lt;Shaoyun.Liu@=
amd.com&gt;; Zhou, Peng Ju &lt;PengJu.Zhou@amd.com&gt;; Chen, JingWen
 &lt;JingWen.Chen2@amd.com&gt;; Chen, Horace &lt;Horace.Chen@amd.com&gt;; N=
ieto, David M &lt;David.Nieto@amd.com&gt;<br>
<b>Cc:</b> Skvortsov, Victor &lt;Victor.Skvortsov@amd.com&gt;<br>
<b>Subject:</b> [PATCH v3 3/5] drm/amdgpu: Modify indirect register access =
for amdkfd_gfx_v9 sriov</font>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt;=
">
<div class=3D"PlainText">Modify GC register access from MMIO to RLCG if the=
 indirect<br>
flag is set<br>
<br>
Signed-off-by: Victor Skvortsov &lt;victor.skvortsov@amd.com&gt;<br>
---<br>
&nbsp;.../gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v9.c | 27 +++++++++---------=
-<br>
&nbsp;1 file changed, 13 insertions(+), 14 deletions(-)<br>
<br>
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v9.c b/drivers/gp=
u/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v9.c<br>
index ddfe7aff919d..1abf662a0e91 100644<br>
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v9.c<br>
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v9.c<br>
@@ -166,7 +166,7 @@ int kgd_gfx_v9_init_interrupts(struct amdgpu_device *ad=
ev, uint32_t pipe_id)<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; lock_srbm(adev, mec, pipe,=
 0, 0);<br>
&nbsp;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; WREG32(SOC15_REG_OFFSET(GC, 0, mmCPC_=
INT_CNTL),<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; WREG32_SOC15(GC, 0, mmCPC_INT_CNTL,<b=
r>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; CP_INT_CNTL_RING0__TIME_STAMP_INT_ENABLE_MASK |<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; CP_INT_CNTL_RING0__OPCODE_ERROR_INT_ENABLE_MASK);<br>
&nbsp;<br>
@@ -279,7 +279,7 @@ int kgd_gfx_v9_hqd_load(struct amdgpu_device *adev, voi=
d *mqd,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; lower_32_bi=
ts((uintptr_t)wptr));<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; WREG32_RLC(SOC15_REG_OFFSET(GC, 0, mmCP_HQD_PQ_WPTR_P=
OLL_ADDR_HI),<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; upper_32_bi=
ts((uintptr_t)wptr));<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; WREG32(SOC15_REG_OFFSET(GC, 0, mmCP_PQ_WPTR_POLL_CNTL1),<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; WREG32_SOC15(GC, 0, mmCP_PQ_WPTR_POLL_CNTL1,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; (uint32_t)g=
et_queue_mask(adev, pipe_id, queue_id));<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&nbsp;<br>
@@ -488,13 +488,13 @@ bool kgd_gfx_v9_hqd_is_occupied(struct amdgpu_device =
*adev,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t low, high;<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; acquire_queue(adev, pipe_i=
d, queue_id);<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; act =3D RREG32(SOC15_REG_OFFSET(GC, 0=
, mmCP_HQD_ACTIVE));<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; act =3D RREG32_SOC15(GC, 0, mmCP_HQD_=
ACTIVE);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (act) {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; low =3D lower_32_bits(queue_address &gt;&gt; 8);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; high =3D upper_32_bits(queue_address &gt;&gt; 8);<br>
&nbsp;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; if (low =3D=3D RREG32(SOC15_REG_OFFSET(GC, 0, mmCP_HQD_PQ_BASE))=
 &amp;&amp;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp; high =3D=3D RREG32(SOC15_REG_OFFSET(GC, 0, mmC=
P_HQD_PQ_BASE_HI)))<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; if (low =3D=3D RREG32_SOC15(GC, 0, mmCP_HQD_PQ_BASE) &amp;&amp;<=
br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp; high =3D=3D RREG32_SOC15(GC, 0, mmCP_HQD_PQ_BA=
SE_HI))<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; retva=
l =3D true;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; release_queue(adev);<br>
@@ -556,7 +556,7 @@ int kgd_gfx_v9_hqd_destroy(struct amdgpu_device *adev, =
void *mqd,<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; end_jiffies =3D (utimeout =
* HZ / 1000) + jiffies;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; while (true) {<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; temp =3D RREG32(SOC15_REG_OFFSET(GC, 0, mmCP_HQD_ACTIVE));<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; temp =3D RREG32_SOC15(GC, 0, mmCP_HQD_ACTIVE);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; if (!(temp &amp; CP_HQD_ACTIVE__ACTIVE_MASK))<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; break=
;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; if (time_after(jiffies, end_jiffies)) {<br>
@@ -645,7 +645,7 @@ int kgd_gfx_v9_wave_control_execute(struct amdgpu_devic=
e *adev,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mutex_lock(&amp;adev-&gt;g=
rbm_idx_mutex);<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; WREG32_SOC15_RLC_SHADOW(GC=
, 0, mmGRBM_GFX_INDEX, gfx_index_val);<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; WREG32(SOC15_REG_OFFSET(GC, 0, mmSQ_C=
MD), sq_cmd);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; WREG32_SOC15(GC, 0, mmSQ_CMD, sq_cmd)=
;<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; data =3D REG_SET_FIELD(dat=
a, GRBM_GFX_INDEX,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; INSTANCE_BROADCAST_WRITES, 1);<br>
@@ -722,7 +722,7 @@ static void get_wave_count(struct amdgpu_device *adev, =
int queue_idx,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; pipe_idx =3D queue_idx / a=
dev-&gt;gfx.mec.num_queue_per_pipe;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; queue_slot =3D queue_idx %=
 adev-&gt;gfx.mec.num_queue_per_pipe;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; soc15_grbm_select(adev, 1,=
 pipe_idx, queue_slot, 0);<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; reg_val =3D RREG32(SOC15_REG_OFFSET(G=
C, 0, mmSPI_CSQ_WF_ACTIVE_COUNT_0) +<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; reg_val =3D RREG32_SOC15_IP(GC, SOC15=
_REG_OFFSET(GC, 0, mmSPI_CSQ_WF_ACTIVE_COUNT_0) +<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
 queue_slot);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; *wave_cnt =3D reg_val &amp=
; SPI_CSQ_WF_ACTIVE_COUNT_0__COUNT_MASK;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (*wave_cnt !=3D 0)<br>
@@ -809,8 +809,7 @@ void kgd_gfx_v9_get_cu_occupancy(struct amdgpu_device *=
adev, int pasid,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; for (sh_idx =3D 0; sh_idx &lt; sh_cnt; sh_idx++) {<br=
>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; gfx_v=
9_0_select_se_sh(adev, se_idx, sh_idx, 0xffffffff);<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; queue_map =3D RR=
EG32(SOC15_REG_OFFSET(GC, 0,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp; mmSPI_CSQ_WF_ACTIVE_STATUS));<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; queue_map =3D RR=
EG32_SOC15(GC, 0, mmSPI_CSQ_WF_ACTIVE_STATUS);<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /*<br=
>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
 * Assumption: queue map encodes following schema: four<br>
@@ -860,17 +859,17 @@ void kgd_gfx_v9_program_trap_handler_settings(struct =
amdgpu_device *adev,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /*<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * Program TBA regist=
ers<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; */<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; WREG32(SOC15_REG_OFFSET(GC, 0, mmSQ_S=
HADER_TBA_LO),<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; WREG32_SOC15(GC, 0, mmSQ_SHADER_TBA_L=
O,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; lower=
_32_bits(tba_addr &gt;&gt; 8));<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; WREG32(SOC15_REG_OFFSET(GC, 0, mmSQ_S=
HADER_TBA_HI),<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; WREG32_SOC15(GC, 0, mmSQ_SHADER_TBA_H=
I,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; upper=
_32_bits(tba_addr &gt;&gt; 8));<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /*<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * Program TMA regist=
ers<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; */<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; WREG32(SOC15_REG_OFFSET(GC, 0, mmSQ_S=
HADER_TMA_LO),<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; WREG32_SOC15(GC, 0, mmSQ_SHADER_TMA_L=
O,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; lower=
_32_bits(tma_addr &gt;&gt; 8));<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; WREG32(SOC15_REG_OFFSET(GC, 0, mmSQ_S=
HADER_TMA_HI),<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; WREG32_SOC15(GC, 0, mmSQ_SHADER_TMA_H=
I,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; upper=
_32_bits(tma_addr &gt;&gt; 8));<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; unlock_srbm(adev);<br>
-- <br>
2.25.1<br>
<br>
</div>
</span></font></div>
</div>
</body>
</html>

--_000_BYAPR12MB2840998060B18B3BA660CB9CF4779BYAPR12MB2840namp_--
