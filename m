Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8CF5BC3271E
	for <amd-gfx@archiver.kernel.org>; Tue,  9 Jul 2024 02:34:34 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 17A8F10E40B;
	Tue,  9 Jul 2024 02:34:34 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="xzBEJjfN";
	dkim-atps=neutral
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2054.outbound.protection.outlook.com [40.107.223.54])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 76CBB10E40B
 for <amd-gfx@lists.freedesktop.org>; Tue,  9 Jul 2024 02:34:33 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Qnp4Z9r1FJ8Rov4Gxa6stg2/neRLCOdDm18XoosKdk6kE9pHespVFcrYAADMwU16FNijwCz6eAo/FpReYaLLV6zVs/yJbwLdasoE44z6hBEoZiRuCJbpvjcW08MgmUH5JmDdQrPGHsFK6fgpcZeSRYWtwGzONIsr87yksvbw6RPH78p+SP9NRVc/g8CZqSpyqBhMu1KMb64L8P2OwhEt2fpMduPv889NX6xRm24p+Il6qhcvZFqBoK99zeaxCClzvKCHkn2VLlgGP7QIJ3u0vmJ5895r9+DgkfGbc4MuEe8aFGPfd7RwNq9CPhGwLPI5QvN7R97X5v2JUNmhJzMRYg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WjQQu890QAW6oU2D3hScbASsqu4NufjAow9Fw/V5GYw=;
 b=ldy0S70aW07yWAyJgApd0o4TRickXNtv9qEQM0wZLlMWPtL3aXBWuOgJ2ifSB4vDCuojImaRcsY4OnUKwCs+Ycmn6iOKhEfDVXVIXiLFEE1eql/OZeLnj43Cu+l/pvxGZynVMtpvW9Jg6ZOwW0xwHnQP46qIxINZS5w2V7/MLV7G0gEivKkqgimZXwgSW6nxwZCysrZW88asqn2ALqqZYqNl47XTzTRwOsTXtOYSQOp5GmMV8VSAb/yUrYsZwoqJd/IJW/6KNJrsR/hvkux7Iq+USfzxzsywezqWGdek1m9MIl8Z2ldQjlfuu7flnQBy7Y+/ReiHW/Xm6eEEBdKNCA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WjQQu890QAW6oU2D3hScbASsqu4NufjAow9Fw/V5GYw=;
 b=xzBEJjfNJQVYynt0ng4P/x/cn602D1TK11WvcWgJCBRyovl8BH0bm4/vE8ufk4LeVriDWS5ggmqViOvc2zbYM/ys5HSt+NeH24cqqicSHUDMj9BLSA7rnHt/ZFCo87pqRfv/6m0bbKWz+8WoCpACspaLgzMQrPBYspf8ptB75i8=
Received: from BN9PR12MB5257.namprd12.prod.outlook.com (2603:10b6:408:11e::16)
 by BL1PR12MB5756.namprd12.prod.outlook.com (2603:10b6:208:393::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7698.39; Tue, 9 Jul
 2024 02:34:26 +0000
Received: from BN9PR12MB5257.namprd12.prod.outlook.com
 ([fe80::c593:f43d:c798:e009]) by BN9PR12MB5257.namprd12.prod.outlook.com
 ([fe80::c593:f43d:c798:e009%6]) with mapi id 15.20.7741.033; Tue, 9 Jul 2024
 02:34:26 +0000
From: "Zhang, Hawking" <Hawking.Zhang@amd.com>
To: "Wan, Gavin" <Gavin.Wan@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
CC: "Wan, Gavin" <Gavin.Wan@amd.com>
Subject: RE: [PATCH] drm/amd/amdgpu: fix SDMA IRQ client ID <-> req mapping.
Thread-Topic: [PATCH] drm/amd/amdgpu: fix SDMA IRQ client ID <-> req mapping.
Thread-Index: AQHa0aevjAu0lfurW0mhblSvJTIwNbHtrZfw
Date: Tue, 9 Jul 2024 02:34:26 +0000
Message-ID: <BN9PR12MB52575E45D304369D10996B51FCDB2@BN9PR12MB5257.namprd12.prod.outlook.com>
References: <20240709022654.2796-1-Gavin.Wan@amd.com>
In-Reply-To: <20240709022654.2796-1-Gavin.Wan@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ActionId=daba1abd-e435-4de3-b5fa-d167ebeee939;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=0;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=true;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution Only;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2024-07-09T02:33:58Z;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR12MB5257:EE_|BL1PR12MB5756:EE_
x-ms-office365-filtering-correlation-id: 8314daed-3f4e-4346-3cf0-08dc9fbfa6cd
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|1800799024|376014|366016|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?xhoLIOgF/CGdxTCN8MRpPk2YysoepPTEZKLm9+1hQQrcdGBZDRlXa98MQbS2?=
 =?us-ascii?Q?EyyVgVKXJD0zg/fA0hGftTuP59Kh/l9+wzUy/vEeFKHr4D9BFoJzXcc95z73?=
 =?us-ascii?Q?aJyvdLqYtQ8jNaV/oAsQAIlLMBRQeen716aBOYdzLI5KVQ59/cfHtrjbFr+r?=
 =?us-ascii?Q?2gvyPgyj7Bx6e9BdBzdbj4W/hmkB/PRmq8QnILeYvrszj1eIc9QgiJ+2Fr4t?=
 =?us-ascii?Q?n1LN/Pbtsxgyh/ijR1jk27V7wR5rgfS0jO0eQCUIGrZGBRBj1rDTS6HA8RZ4?=
 =?us-ascii?Q?1EV3to4HaqibRYOCzIAGMMQ/1oLcBv8M8KFzcaBzF0HeAHTYc5Df2Z51fVUx?=
 =?us-ascii?Q?k9gPrQbeEE3O0M/9C+lkJQAHv5icu+vVM+L4l4oVqy378Bjc0W01IFDkmv4U?=
 =?us-ascii?Q?362UkZKm7/VhitQNpc85A32HWRAloq9HZtb8f8ToI2y9o4tKEmxgJTxROzM9?=
 =?us-ascii?Q?rzlSNYiikRyDmWEQeKt5fnzw9qph+gBNVCs7D+YLfXQKd40M3O+sRiFbNRwV?=
 =?us-ascii?Q?6NwlZWgI4r9BLcYNxoHkzTU79vl4HPhQWBJfESsFOQB7Te7FbtcFu4+KV5Rx?=
 =?us-ascii?Q?/0nJS5eaK6iOsvkwCUQRHu5he01beefBXBM5V+roS+7AuobTUJ9Dv98K9/87?=
 =?us-ascii?Q?0oDQrm8x5MvNyt1tuEu97rI6fcRSovAhObauHVcvTbH7pXD52gTmFl4GAnIP?=
 =?us-ascii?Q?HF9RYriyRTCXa9S6mxsgnl+RsmadZFaVBxiqEo7N2lRr/VsNw4Ob6p1lxK8F?=
 =?us-ascii?Q?8KLXTS8d/Wd5z/hry1ujRMu6yvR6omVbWpRpkJIhClorR9xLHyH51jFE1AYi?=
 =?us-ascii?Q?MaX0V2qwi0huq3OA8UMurP+Fw7XphFgbzdIeVlvby369gRDfjwBfWquC3EX6?=
 =?us-ascii?Q?zLUvL08teNeQUE4zl7rqIAPsLuWP1lLlha1OhIY4qaD+dUL4FJN+3DFz+gWj?=
 =?us-ascii?Q?q6X6hw9hXlqXNE3MCoJ4rEPid5tvsY/n4E0voZnnmI+5ARQAxak6lVEpIZmy?=
 =?us-ascii?Q?eHCE0nhwvs0fmRSV9CV0vuoC7xt9VfFuKv/CB/1AFHURCeiAvl23ZEVJ49Lk?=
 =?us-ascii?Q?Junq2lZ9cpi+fa4BlbIZs/oA8WaowI/pvLu7c5THymRiuSAY4rZsRiRnu06L?=
 =?us-ascii?Q?Fc++Mxsba/lwYLOQFULi1ZhyJVe0FXZkoAflpiMycThqVi9QfgiNw2Z72i9U?=
 =?us-ascii?Q?oxUiurUgo05ra8N0XUw60K7YlEU+JBjxYoBlLC5H8eok/p3M5UiRG1QdR9HG?=
 =?us-ascii?Q?U3g/RRL9X2aTQiT/cS5p7COr5C9jkNlzNDdrMex4tBB3XXEyaq87oFao6+DW?=
 =?us-ascii?Q?P7enkCHHlYGUuL4oN3JwyGVLN3I96D8ryEJ4teK03vK6rBWsMAhMel/SaF4r?=
 =?us-ascii?Q?5gX/CoYxtD4ZpO2kM71LY3HnpIvq11OlTbLq58yoft/evdnlBA=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5257.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(38070700018); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?yJrRgGVe3use8THkGn6pUlAL/Xkzh3k+7bii1/BAjquXsbtbgWelggj/EMZy?=
 =?us-ascii?Q?Hu4XfSAiRQGxSEG7fs7XlyR3+2c+Xo1+eExyyihcc6JihrhHqVhAoLX1mFA2?=
 =?us-ascii?Q?Gk0Pk+xDeR1PLr1VLigY1OSha41n4+BiMJx4iHZQwTpQUcEkvOaEubkYXaMv?=
 =?us-ascii?Q?cuotKVwyp49EOB7cf9tQZNu4E4Ay+Lgn+/ZZwWupxKT0hUo1cx9W07Mjmzct?=
 =?us-ascii?Q?qVswJcwo76neULpuF41jREpJ8UrVBc8p3IFD94ht6OLkmA0Mh/g6lZJ3wh3E?=
 =?us-ascii?Q?zo8cYDbTIrC/t+Kqdze3EeHqGCeKkk/r3tHpcbWd3uOTYQsN4jXFu+owEklL?=
 =?us-ascii?Q?4FXmtpYQjivB2WR2ykeugulSfEjZaZsqdqaziB2BTqd78Rvb0CCql/+2gXeq?=
 =?us-ascii?Q?veTZliBgharNyXvPGVWo9aHy8RtWNTf1iNbA+Z+dFVvKGKbWKBVUpO3vj13r?=
 =?us-ascii?Q?d6ErAeGAM+aundS5NEN6z+m1EJpx/BlP+ITeh1S+zFH0sqwO46YK73sWT2NW?=
 =?us-ascii?Q?cAHjjTm06mx6ILaJrDVHSLgNzFumxhbXB09+ZAzHPoY32ENevrZOokkjZTPB?=
 =?us-ascii?Q?V7Ly6xwtujdkJVogZ2VCP9m3fQZER5W3M1VwXGNoLQro2DrMbWSOArGYyZ+Y?=
 =?us-ascii?Q?ATUJ1Vx5mcIRwyAG0ULttUEZkmyPP2SWRjuED5sXYjnqR9FRg/qTsYJcQUAE?=
 =?us-ascii?Q?YwZ4o9kIgPshStFuu8ILrfZwGf5NFBsMLmZeNYd+nAx9ExnNLUCcFY9kFeqS?=
 =?us-ascii?Q?lq/xDd6guSHRFNOsA/6lx61FajxLf71EXzVHkQpbQRH1kvSmLr/cNgKZU9Sf?=
 =?us-ascii?Q?btIGbxd4cS2VQuU791EYCXHH9T6S8G4nfFzjFkz7HwW2LwCu57BBfhTLiMj1?=
 =?us-ascii?Q?C+3JLCMHH5c1PvTR4eXsxwA2Ud7z2swtiaZwdHh1cljYaSg28PPHYxx2A8tY?=
 =?us-ascii?Q?tBxvNDZSB/Iwd2+AgFsIvILY/QUUWXwOJapfEiZQ9aDNCpnlF4cav/0h6Qnj?=
 =?us-ascii?Q?Y5FazBsioyGY2PvVMo6pBnK6rBgC8Ua4oBRc5ywEwqL2IncqxTgfS7xbx/fJ?=
 =?us-ascii?Q?7xFblN/qe40pJEh8bDEWCkOoiTM2o6vLdM/kDzScTAsXR/CdcKJS9P4vEiaJ?=
 =?us-ascii?Q?q8icRCt8qI1HuoUS+ZxUWf876gADUNrm9D70VJbClmwI05iPWFz3PfpoWNIb?=
 =?us-ascii?Q?367in6tgBuNtz8+Z6DSGhDDu6jrBx0kN4nlw5dLe+qRNPrEY9cyjQ0lVyahT?=
 =?us-ascii?Q?7nBy60XwcqjRpqZYwTKp5zjjW0NV+psVFeFeshDQxePIZ9gzHWl5/1R5I2mP?=
 =?us-ascii?Q?U06hZMo/5yBF/5L7cTNzh6rtiYdYV0ukIWuhBQsjI11RlnrQeh7KD+obDXVq?=
 =?us-ascii?Q?e48yFg8Y2VcnsC79a1uy/76yERvOJdAm1NXZInaGAS/rnZjqVhk5mv5oYjH3?=
 =?us-ascii?Q?Y84nVS1mmi6h0yHfPAitzkd0Jvxydxj5qM0IDCjJUYeqHhm6jBBlleRUQR3o?=
 =?us-ascii?Q?CVtuuF8ZxLMjNs9X2KKTCmslXNUJfZHMyrDl4d/QGNeeM9TFxW0ZWJXKDbRq?=
 =?us-ascii?Q?7G4JR4OMAJb17VcmkYQoUGymYsaxiaRu0FeUauxF?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5257.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8314daed-3f4e-4346-3cf0-08dc9fbfa6cd
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Jul 2024 02:34:26.5476 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: nE764Xx+hZHzNFdXwg4TfQTHgGMS9SgptJZCwMKgouzGuoRbOFltmeJdeMh3TOZspFJoAbLGtbhSdhrMEeq/Yw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5756
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
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Gavin Wa=
n
Sent: Tuesday, July 9, 2024 10:27
To: amd-gfx@lists.freedesktop.org
Cc: Wan, Gavin <Gavin.Wan@amd.com>
Subject: [PATCH] drm/amd/amdgpu: fix SDMA IRQ client ID <-> req mapping.

sdma has 2 instances in SRIOV cpx mode. Odd numbered VFs have
sdma0/sdma1 instances. Even numbered vfs have sdma2/sdma3. For Even numbere=
d vfs, the sdma2 & sdma3 (irq srouce id
CLIENTID_SDMA2 and CLIENTID_SDMA3) shoud map to irq seq 0 & 1.

Signed-off-by: Gavin Wan <Gavin.Wan@amd.com>
Change-Id: Ie850114932ca98ea3c9176370dde5dd393ddf7e7
---
 drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c | 20 +++++++++++++-------
 1 file changed, 13 insertions(+), 7 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c b/drivers/gpu/drm/amd=
/amdgpu/sdma_v4_4_2.c
index fec5a3d1c4bc..4516cb0b3ae8 100644
--- a/drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c
+++ b/drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c
@@ -82,7 +82,7 @@ static unsigned sdma_v4_4_2_seq_to_irq_id(int seq_num)
        }
 }

-static int sdma_v4_4_2_irq_id_to_seq(unsigned client_id)
+static int sdma_v4_4_2_irq_id_to_seq(struct amdgpu_device *adev,
+unsigned client_id)
 {
        switch (client_id) {
        case SOC15_IH_CLIENTID_SDMA0:
@@ -90,9 +90,15 @@ static int sdma_v4_4_2_irq_id_to_seq(unsigned client_id)
        case SOC15_IH_CLIENTID_SDMA1:
                return 1;
        case SOC15_IH_CLIENTID_SDMA2:
-               return 2;
+               if (amdgpu_sriov_vf(adev) && (adev->gfx.xcc_mask =3D=3D 0x1=
))
+                       return 0;
+               else
+                       return 2;
        case SOC15_IH_CLIENTID_SDMA3:
-               return 3;
+               if (amdgpu_sriov_vf(adev) && (adev->gfx.xcc_mask =3D=3D 0x1=
))
+                       return 1;
+               else
+                       return 3;
        default:
                return -EINVAL;
        }
@@ -1541,7 +1547,7 @@ static int sdma_v4_4_2_process_trap_irq(struct amdgpu=
_device *adev,
        uint32_t instance, i;

        DRM_DEBUG("IH: SDMA trap\n");
-       instance =3D sdma_v4_4_2_irq_id_to_seq(entry->client_id);
+       instance =3D sdma_v4_4_2_irq_id_to_seq(adev, entry->client_id);

        /* Client id gives the SDMA instance in AID. To know the exact SDMA
         * instance, interrupt entry gives the node id which corresponds to=
 the AID instance.
@@ -1584,7 +1590,7 @@ static int sdma_v4_4_2_process_ras_data_cb(struct amd=
gpu_device *adev,
        if (amdgpu_ras_is_supported(adev, AMDGPU_RAS_BLOCK__SDMA))
                goto out;

-       instance =3D sdma_v4_4_2_irq_id_to_seq(entry->client_id);
+       instance =3D sdma_v4_4_2_irq_id_to_seq(adev, entry->client_id);
        if (instance < 0)
                goto out;

@@ -1603,7 +1609,7 @@ static int sdma_v4_4_2_process_illegal_inst_irq(struc=
t amdgpu_device *adev,

        DRM_ERROR("Illegal instruction in SDMA command stream\n");

-       instance =3D sdma_v4_4_2_irq_id_to_seq(entry->client_id);
+       instance =3D sdma_v4_4_2_irq_id_to_seq(adev, entry->client_id);
        if (instance < 0)
                return 0;

@@ -1647,7 +1653,7 @@ static int sdma_v4_4_2_print_iv_entry(struct amdgpu_d=
evice *adev,
        struct amdgpu_task_info task_info;
        u64 addr;

-       instance =3D sdma_v4_4_2_irq_id_to_seq(entry->client_id);
+       instance =3D sdma_v4_4_2_irq_id_to_seq(adev, entry->client_id);
        if (instance < 0 || instance >=3D adev->sdma.num_instances) {
                dev_err(adev->dev, "sdma instance invalid %d\n", instance);
                return -EINVAL;
--
2.40.1

