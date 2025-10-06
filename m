Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0ED23CCA470
	for <amd-gfx@archiver.kernel.org>; Mon,  6 Oct 2025 04:28:41 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 91D9E10E044;
	Mon,  6 Oct 2025 04:28:41 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="4U4kyJuY";
	dkim-atps=neutral
Received: from PH7PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11010026.outbound.protection.outlook.com [52.101.201.26])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DFE0B10E044
 for <amd-gfx@lists.freedesktop.org>; Mon,  6 Oct 2025 04:28:39 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hCJnFcXxt5hk6/HlDQlMZhKbzhnHlqy3cSVaUmMkc6o3Fi2UMq4rXYOQhFRlSyKxaQqDuWGZadceZmeuF8RVgjZV1VBSSRgMXHqVw1DCFQz1Y3Yp0xzuWwzE2VRI99qTTbcqHbWRA0MeM4rbHVHAKhz7znZG9yhViZWEZB2HcHQPlSmaNYtaFMveqA3Q9dRDLGU+rqwpzIfEPWR7MDUm/drsB7tFX3iE7S1wKYwxRaMh/snlmX9UlZBZ8vasVwJUWDV/oMcoU/iUG2vnPoZRcrmLvJmEblquYP1tU+L9ZIS9aAnO3S92IPu1HQi8mMFFK0JsX5eKJ1C6ApWlBa2fXg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TnRt9HNCxdPIdgsG2rl5Q7XFyyQxpz/bxgj1SsBod1w=;
 b=fpA+pro2wJvEgBw6KpOFJs6Evuevld/XjTqXX1Vvj2su1Gfqs3CyQL5XQSfUqhmQ2ba4qROm/2lZURYHi5TgHogQUDJzW7Hb7Oe/DXohInsSpW9yz31hLOR8z9QtqPaLPwUvohtEqqdC2JrTowr4cMvt22ZDMh04Sub689t9zLIMoZJS5Xdka1dAohV7H+08aiZrKEpB18EG7Yj/hxqaN+sXJkoARPYSAtHGPWMVj1RYOHbI3/ueCqYhpZSJ7rp0BolK+o3L1spbQcf9VyWUyzOsneYwV1sqyzc0uJ2sof4ILHhIsxjhB0VdPq7jD2TaOCU+Hwl4qcjzsV48X2MwKA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TnRt9HNCxdPIdgsG2rl5Q7XFyyQxpz/bxgj1SsBod1w=;
 b=4U4kyJuYur7hFRG1d0HUmKgEdlLmaKNQPlvY3gwf28vKTItIBZdvB01lREf3QCXG/9UV5n2rt1Q/D7IeYJ4QKHU49RmXGkuR0bFgMPnPzf2+N+vtfw0xOGan01IwYJDsY/jDcWOjdqaNlRlCOOLtAc95M15CJIDmKC+JFbja6FI=
Received: from DS0PR12MB7804.namprd12.prod.outlook.com (2603:10b6:8:142::5) by
 SN7PR12MB8129.namprd12.prod.outlook.com (2603:10b6:806:323::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9182.20; Mon, 6 Oct
 2025 04:28:33 +0000
Received: from DS0PR12MB7804.namprd12.prod.outlook.com
 ([fe80::e71b:4ec9:237f:24ea]) by DS0PR12MB7804.namprd12.prod.outlook.com
 ([fe80::e71b:4ec9:237f:24ea%5]) with mapi id 15.20.9182.017; Mon, 6 Oct 2025
 04:28:33 +0000
From: "Lazar, Lijo" <Lijo.Lazar@amd.com>
To: "Lazar, Lijo" <Lijo.Lazar@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
CC: "Zhang, Hawking" <Hawking.Zhang@amd.com>, "Deucher, Alexander"
 <Alexander.Deucher@amd.com>, "Zhang, Jesse(Jie)" <Jesse.Zhang@amd.com>
Subject: RE: [PATCH] drm/amdgpu: Remove redundant return value
Thread-Topic: [PATCH] drm/amdgpu: Remove redundant return value
Thread-Index: AQHcJs42TEKjzSloGUqBnMtmUD4pHrS0pZxg
Date: Mon, 6 Oct 2025 04:28:33 +0000
Message-ID: <DS0PR12MB7804CED4985F1F246C4E352A97E3A@DS0PR12MB7804.namprd12.prod.outlook.com>
References: <20250916055235.3070689-1-lijo.lazar@amd.com>
In-Reply-To: <20250916055235.3070689-1-lijo.lazar@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Enabled=True;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_SetDate=2025-10-06T04:28:18.0000000Z;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Name=Open
 Source; MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_ContentBits=3;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Method=Privileged
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS0PR12MB7804:EE_|SN7PR12MB8129:EE_
x-ms-office365-filtering-correlation-id: f6872657-0f6c-4373-7866-08de0490cf52
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|366016|376014|38070700021|7053199007; 
x-microsoft-antispam-message-info: =?us-ascii?Q?f8k43Qx2uBFSEFVFbF1KcAuhcxzWu7Y825zUiKiAS8CtPpMlk5la6PohWcZh?=
 =?us-ascii?Q?Z0jUmYHcy6Q6b0ODKe6BC6V98U4VbvYzxxKYStAfG9E9LtIgE4sTH57cW+Mk?=
 =?us-ascii?Q?2oxjvjFzEO3wNxjY9e6xssEueIW6N29e0TY7dzCrxLvT5qrHBtVcHg1Bs7AN?=
 =?us-ascii?Q?YWsMu0o6CvADnNY2XvcOgGkP/MuCmOfzN97SJdpypqTuvbEuBql3oBJ2wG7k?=
 =?us-ascii?Q?Ga+LtjqAoF0FmgOZnc0SMAUnMfOZ/ptNBm5Ji8JLZozBoLiTygGrR20RSkAf?=
 =?us-ascii?Q?N4PD/CwmBtAsLtuI75uaD2M5FH7CAko7sdn10mt0OViPKTcIBoJAxF6S6YPL?=
 =?us-ascii?Q?in7F8bx81zyyck6VoxlPik0G3M+XI3plk0C4X0iMGyyt5Z/OTSS3Z151z57h?=
 =?us-ascii?Q?HVkP/lSatJ+XZJea5CyMs9GTKBR9g7bRRfc5CvuucPkJ5pHU1OAF91kG+H8k?=
 =?us-ascii?Q?GcIIQ2xKg3/11etx8ixByQHToIb5mUo86aCnto2dBBwU1kbQ6K+3UJ6uhElF?=
 =?us-ascii?Q?9EA0TLnOZjgKZuaOQuYx6n/e9yZwlhHqPOtZQV266ekvDt86CFDpTBwCUhAl?=
 =?us-ascii?Q?pl3HMl15PZnIM/lQ3Ad2/J/HdSubIGwrlx/TJdVUwJV/lAOHe0bFiSuutdqF?=
 =?us-ascii?Q?xAfBM1sxqMzBdW2LW/o01xHmccp3yYX07g+fyA6gPcS9YkLSnlapPu3kjSnO?=
 =?us-ascii?Q?7SE+atIoOZ+rchXcbullxEiMtf1X4bgo/ypzl58WH/U0Th7IRUoeFP+3goyz?=
 =?us-ascii?Q?IPbFGmm4GXtb23k+0Aprd9H3Or+Jw6e0CUuWNlgZGt7nt+iZTpNR6rABsMea?=
 =?us-ascii?Q?6oNyAKMeLLBTs8y+OMFPNowZp7vfRPrDrUa/E15ttzKNH/AjFLItMRdKWBJv?=
 =?us-ascii?Q?0GGFb0iU5f2Hi76y56Ea1gyhAGOD+5y9+9x6JLgsSgQoXZNVzdUiMwVLij1T?=
 =?us-ascii?Q?ovXR1L6UlVZyC1ZAJD+PL9N+cdk7cDwpfiRBPADGBako0zwTYthvJJnmN7Xr?=
 =?us-ascii?Q?zlBg5XQItEVZup4O6cRDpvHUZmy2jT0xP1FGRZRI/bOuVE/QV9Q/lMs8zD6+?=
 =?us-ascii?Q?yL9OR+vlSlSCCQjV06fIIjfY+80iNUWKrBu/LVaT7TGLM7Ng9KytV+HDCFFK?=
 =?us-ascii?Q?PGKvHmWfMOATC0ZmNSYX8tJgAVrpfJk8MzzcZfxp4JJzznY1jHs4hcV1gRdP?=
 =?us-ascii?Q?dRI0HkfFZeYKU62+5y7xBk/eIZek6LoKygHj8xRYto3PDivMBRMwh5osvWdj?=
 =?us-ascii?Q?6ohqDiRZJ0TxcIOQ0iWqXGo+o7FU6MR3pkqdyH2S3sqYOUE6PDYwAjEQ2zQ5?=
 =?us-ascii?Q?233N7YnxCdiVRgXTEpy4iM6UGliqqhO3lNcATCuPkn3Esfz0CGAwmHWhFK6E?=
 =?us-ascii?Q?pXbiXnCBwv65Xi8v236c/BNlhQoPEowRLSk5nQy8HdL4h72c2gKWAWXMdMzs?=
 =?us-ascii?Q?AibP7YoML2ptsOtVqhBzl0CMTZVwyhNZzS0XXghguUySttQsj+4iXN1bE6MJ?=
 =?us-ascii?Q?9mSZb94llO+CC7d2QMfFj1pEHFtFhMCz32eE?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR12MB7804.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(38070700021)(7053199007); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?SGql7V9uEgK3GOavBMCCC0UbAXTJJyUldRsSBRp+2zjsMjPGlfHPYXqwXhXg?=
 =?us-ascii?Q?bgHB7zlEaEjIXER2WaBXe8xrV3xSLIELCHk05lSnLtcT2wW4bmST4Pht+ogg?=
 =?us-ascii?Q?WFOsS6/sauxdRa4YYZK7gNFer/oecNT3qi1/Q9cr40+bH7WBwXlEG6n5+mNv?=
 =?us-ascii?Q?SiaqYvg9CRIELK3FN6sZoz4wAFpcz7QD8nsTvnSGboS+WHJUWNHx3M395I/k?=
 =?us-ascii?Q?VD+Q1R2Ujr0rGgk28Lrkks9AOXSv6XDirbjkxHyiP1SDMVgKLRG5B3ZJAs/a?=
 =?us-ascii?Q?+30la2p/OLgCOKrEuMkWlc3EwJ6Qn+usH3HN2luOmEisvrLWqYGoSarcSJIM?=
 =?us-ascii?Q?O6U5HHXATShTqwzcMgj7W45L1n2/Xdc3tVGW6BTfYYunUpT9ywZ2xW1cn2GD?=
 =?us-ascii?Q?0beQ3L4RuY2jlj/MlITJi8yX0hem4Qw8ZYfujZwl3cRc1zg3lggLo5R8CRkA?=
 =?us-ascii?Q?o0W5gZnoACA3KIC/2AVyS0PwOh2dxHs4cAtImUjuXqSWs+VuHMXNyiwxp5B5?=
 =?us-ascii?Q?xLysYucqoy6JPu19Bt1Y0VDELT2uKcHMDwmF1Emr7QwYBX51KJgPHJB5JXcN?=
 =?us-ascii?Q?XaUb8+6OyazFScgUC3Um13MJp9wige7REUdB1tN/HVjJW35GiXs9q+5J0bWn?=
 =?us-ascii?Q?6tNaPUbpfHzKfm0u/rjXIMGanvQI0foVWwvlgzqL0xuz+bwBUdc37y/tw9c+?=
 =?us-ascii?Q?fyBtyBrQnCxx9VlE4UIGxPLzV94isNGODn0cRqkmU8IKn/5N5v5obSwsqqoL?=
 =?us-ascii?Q?3FAV1KDoFW3nf6+jKqfuw+dXh5d/tdCfDv1LbNKAiHoADWPVmkIdY9u2doSP?=
 =?us-ascii?Q?EcWNbVUq772Zza67KUvmfxcmRfBpkqkU25LfU29MIUBMMbFNl7JHwQk21Knn?=
 =?us-ascii?Q?IyzZb6QWmQ0jsGgJ39+AIZbbFkJYH0JJz9hXC+L0qxfMTHFu2U5bmUug8do5?=
 =?us-ascii?Q?IN+OiZvrWjYkpzmiV/8j+NFbendiG0t539d4u8RtjT8z0S6IxtaO19l60Mrt?=
 =?us-ascii?Q?58fweRLFPjb8Om6F5EleiCMnLB3pFqZgN2UqdegmZ18KX+x6V0ACRTXz2SRX?=
 =?us-ascii?Q?kqzk17jFwuMwd/EXRRtXbJT3Wtg9TpRMI7VG3ISRPypaiDBDF6nCuTKNDFAn?=
 =?us-ascii?Q?weoxV0SBVFKJAOH+STUF6ja6fmf92ynpzMNzcJrMBXQRpfWHBGJ9ut1Ui0f/?=
 =?us-ascii?Q?v5ElJpH+gYTMEAAUJp0Et0+XUq7nOsejwSshh3udYxdkHiTOXkYnodTFNIHM?=
 =?us-ascii?Q?y1DrrT/D5rtwWUl0GhHbe/crvQ06kh+jo2yqxktvtSTt8IDJZiE600GZAnZa?=
 =?us-ascii?Q?9cKLy1cBUuM0RJWDuH7IOzzgCeks49SCE3PUdJv3jpA3x6qibAYSD4gLDic4?=
 =?us-ascii?Q?bqLeobJmlV2jvgl+HZ1ar6ro9IHA2CcAnsvZZKUsyvspGuFH/tBMc4h4DOns?=
 =?us-ascii?Q?edigF5hZjncCA432wDdWWjg8xLyOKB4M2KoUU9fLyirphc+SIrZKItTJ8ZlF?=
 =?us-ascii?Q?/m2k+oNJuTc8rnPgAe5v/TafZN7VguZVYsQVMXhgUN2oZrIcqz9ZdM3sEwy4?=
 =?us-ascii?Q?BHUxIg+qEPJIBNfptU4=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB7804.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f6872657-0f6c-4373-7866-08de0490cf52
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Oct 2025 04:28:33.2917 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: I4iHlmZdo0flgL0p0UrEUVbeCEVQNx2Lvdu13ZtOiNTLY/jSX4vG+IFrdVROaPWb
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB8129
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

<Ping>

Thanks,
Lijo
-----Original Message-----
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Lijo Laz=
ar
Sent: Tuesday, September 16, 2025 11:23 AM
To: amd-gfx@lists.freedesktop.org
Cc: Zhang, Hawking <Hawking.Zhang@amd.com>; Deucher, Alexander <Alexander.D=
eucher@amd.com>; Zhang, Jesse(Jie) <Jesse.Zhang@amd.com>
Subject: [PATCH] drm/amdgpu: Remove redundant return value

gfx_v9_4_3_xcc_kcq_init_queue doesn't have a fail condition.

Signed-off-by: Lijo Lazar <lijo.lazar@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c | 18 ++++++------------
 1 file changed, 6 insertions(+), 12 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c b/drivers/gpu/drm/amd/=
amdgpu/gfx_v9_4_3.c
index 8ba66d4dfe86..665ae33bc272 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
@@ -2152,7 +2152,8 @@ static int gfx_v9_4_3_xcc_kiq_init_queue(struct amdgp=
u_ring *ring, int xcc_id)
        return 0;
 }

-static int gfx_v9_4_3_xcc_kcq_init_queue(struct amdgpu_ring *ring, int xcc=
_id, bool restore)
+static void gfx_v9_4_3_xcc_kcq_init_queue(struct amdgpu_ring *ring, int xc=
c_id,
+                                         bool restore)
 {
        struct amdgpu_device *adev =3D ring->adev;
        struct v9_mqd *mqd =3D ring->mqd_ptr;
@@ -2186,8 +2187,6 @@ static int gfx_v9_4_3_xcc_kcq_init_queue(struct amdgp=
u_ring *ring, int xcc_id, b
                atomic64_set((atomic64_t *)&adev->wb.wb[ring->wptr_offs], 0=
);
                amdgpu_ring_clear_ring(ring);
        }
-
-       return 0;
 }

 static int gfx_v9_4_3_xcc_kcq_fini_register(struct amdgpu_device *adev, in=
t xcc_id) @@ -2220,7 +2219,7 @@ static int gfx_v9_4_3_xcc_kiq_resume(struct=
 amdgpu_device *adev, int xcc_id)  static int gfx_v9_4_3_xcc_kcq_resume(str=
uct amdgpu_device *adev, int xcc_id)  {
        struct amdgpu_ring *ring;
-       int i, r;
+       int i;

        gfx_v9_4_3_xcc_cp_compute_enable(adev, true, xcc_id);

@@ -2228,9 +2227,7 @@ static int gfx_v9_4_3_xcc_kcq_resume(struct amdgpu_de=
vice *adev, int xcc_id)
                ring =3D &adev->gfx.compute_ring[i + xcc_id *
                        adev->gfx.num_compute_rings];

-               r =3D gfx_v9_4_3_xcc_kcq_init_queue(ring, xcc_id, false);
-               if (r)
-                       return r;
+               gfx_v9_4_3_xcc_kcq_init_queue(ring, xcc_id, false);
        }

        return amdgpu_gfx_enable_kcq(adev, xcc_id); @@ -3603,11 +3600,8 @@ =
static int gfx_v9_4_3_reset_kcq(struct amdgpu_ring *ring,
                        return r;
        }

-       r =3D gfx_v9_4_3_xcc_kcq_init_queue(ring, ring->xcc_id, true);
-       if (r) {
-               dev_err(adev->dev, "fail to init kcq\n");
-               return r;
-       }
+       gfx_v9_4_3_xcc_kcq_init_queue(ring, ring->xcc_id, true);
+
        spin_lock_irqsave(&kiq->ring_lock, flags);
        r =3D amdgpu_ring_alloc(kiq_ring, kiq->pmf->map_queues_size);
        if (r) {
--
2.49.0

