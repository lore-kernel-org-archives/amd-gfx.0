Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D660FC02198
	for <amd-gfx@archiver.kernel.org>; Sat,  8 Feb 2025 06:40:55 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 28ED910E3A4;
	Sat,  8 Feb 2025 06:40:55 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="BDxhgXXQ";
	dkim-atps=neutral
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2050.outbound.protection.outlook.com [40.107.236.50])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 01A6210E05C
 for <amd-gfx@lists.freedesktop.org>; Sat,  8 Feb 2025 06:23:42 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VHVtIF51At6PdN2jriP0ytqIwI2gCz4NRcZNGVCqAfLk+E3ZuCW4hDHNIqiZCD7gs6lqmW3ppp9q25WD6VhLMvON6yalNKpjl95H6KMZmijRPyylsu3+MMqnU0cDpVnx43yD2p9Qfex7kPlip9sgoSO+xMwUv78fbRzIA4iS9e2wVAPjzf4Q9+YdVKT/6Bh264NziA5VGFWYFOhuR0vYBspCEJlbsj0IFx/+7UuGoKhlzyBbUF2edpBU+y95B+4HZr5vBRNOdm1t+x4H1s5lgTzNNtajhlOInSVDvEfedgEQW+fcNW0pBSTq9S8D8+VJl57hJTVJxB9RiPfjSxe3yQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FOoYvp5g/CymVN1smRs3TzOldgL45IwgR5u6U98I9IE=;
 b=KrmIZ9eMUl30swckvC+ElcCHgpaDWi4js9z9qc89gOdnOfaC+nG7wm+V570TUiVtEwpm4C7yUKTNXWNnYtRe8ObLhtaYSGXHjK+oTrmJeA7D+U/YUYfKdObb7Znr41ifOt8vHPJFT83/ajzfpyVqWlOswZnux1LdbPxTcXLc/TF+ttHZMBDRTDu0NQVMkAZGQ6aF3lnOvyQxsamOTyaUTKC9IzEXKyL1pMsfrBepFRPzQ/ZeHywx7oTHb5eqmYHe2tG48RfJuVzsYzCUMnmLYJhJdnXb2nkcJyIDjG7yQOR+8L5yUirMO704VYe3uvyr+oiVAmf/BtNuVxFf+lHz8g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FOoYvp5g/CymVN1smRs3TzOldgL45IwgR5u6U98I9IE=;
 b=BDxhgXXQ9hERn8l9fPd/EKLDAiUAsB+oFKO9GBrI7vUMJ2bXj9yVx1BH8gNlC0UaqY1CIB67XiXKWzvBO0VnVg97vpqkwmCIn1Y50nyhn1Uu/DDRU9+Qwt7nU2zqZWsAt8fttlJ10pr/GqbGV1ZykyG6PvBVxD9oDBhtBN7ZVu0=
Received: from CY5PR12MB6369.namprd12.prod.outlook.com (2603:10b6:930:21::10)
 by SN7PR12MB6888.namprd12.prod.outlook.com (2603:10b6:806:260::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8398.24; Sat, 8 Feb
 2025 06:23:38 +0000
Received: from CY5PR12MB6369.namprd12.prod.outlook.com
 ([fe80::d4c1:1fcc:3bff:eea6]) by CY5PR12MB6369.namprd12.prod.outlook.com
 ([fe80::d4c1:1fcc:3bff:eea6%6]) with mapi id 15.20.8398.025; Sat, 8 Feb 2025
 06:23:38 +0000
From: "Zhang, Yifan" <Yifan1.Zhang@amd.com>
To: "Huang, Tim" <Tim.Huang@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
CC: "Deucher, Alexander" <Alexander.Deucher@amd.com>
Subject: RE: [PATCH] drm/amdgpu: add discovery support for DCN IP version 3.6.0
Thread-Topic: [PATCH] drm/amdgpu: add discovery support for DCN IP version
 3.6.0
Thread-Index: AQHbedxJE3QZWPoVzEi6bNf8s65s4LM88ADA
Date: Sat, 8 Feb 2025 06:23:38 +0000
Message-ID: <CY5PR12MB6369B72DBB0EF59B1E2CB68CC1F02@CY5PR12MB6369.namprd12.prod.outlook.com>
References: <20250208034553.684282-1-tim.huang@amd.com>
In-Reply-To: <20250208034553.684282-1-tim.huang@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_ActionId=cdaf0a18-3578-4580-97fb-1416f4ec1c93;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_ContentBits=0;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Enabled=true;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Method=Privileged;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Name=Open Source;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_SetDate=2025-02-08T06:22:54Z;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CY5PR12MB6369:EE_|SN7PR12MB6888:EE_
x-ms-office365-filtering-correlation-id: 4740082d-29c4-44e0-5c50-08dd48091fe6
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|366016|376014|38070700018|7053199007; 
x-microsoft-antispam-message-info: =?us-ascii?Q?3W8Dq3oZCH5g6I8FIGzUrkxdGVd2paO0auGT+BCnWkfocxN3PwhOP6E86JBw?=
 =?us-ascii?Q?+btWO7ekx5MKDeubtKrOM3O8deAIWIg/kc4gJlCpNrR4sgzlqco4KtCuZ02o?=
 =?us-ascii?Q?d4H/9r+tswuij6otHkVlc6xRgraHL651XuUuoqxAf7nfRxaFlzv+RfNTsBFd?=
 =?us-ascii?Q?efrJOn5F+4eJFjL+RKw3HrhzqkJgx7swQY2njxgqAXzvxxUf2XSleb0VlcHz?=
 =?us-ascii?Q?wxF9yulHQrbz78va1tpuP78dNRCoQ/Dxnk8WxQ6KwN1SO5oDmJv4zUfBygON?=
 =?us-ascii?Q?qH99bIuqeSWb9f4B1fU0ckU3iSaDkRfGKagqw4ppbDW9hXXVM8KuUS7OoQvu?=
 =?us-ascii?Q?BarpdQxON6EI0WVCGxsgIxU0sZescYzEwulGWo8N3LGUru3tvZdP9RkWGi5H?=
 =?us-ascii?Q?Kk5Rvd6ttNpzkeJeBcw96Ov104aakVrB3zlt1srQmaHRxGDQKDnf3nchCOxC?=
 =?us-ascii?Q?Tx5jfWWyo2deYNsRb0MKDuIqKRm4+42ezM8e7X60vOobngseGQkWHwvqDxMi?=
 =?us-ascii?Q?47JGLmfbtA4fiBzF1LwAUIk0wH5Bw40wIDI3Cv25c2p0UJs/S0mmrV3gppdm?=
 =?us-ascii?Q?B/O6FvS3OhEX3IEMwfwwYK1wcBVDaRIMjDRTxXxqXw9R4Y9CSXzj1ZVam0ah?=
 =?us-ascii?Q?jd7FHh6hwE8cbE/KbtJUwd51mucxNk3gWQjQpXthFaYOBjuzUEH04J04xHbt?=
 =?us-ascii?Q?qEcx6qjNHubaWB2b4HdoGKnYO79Mf1/x87m5JO62zIWtvR5CkqT8GBno0dqc?=
 =?us-ascii?Q?A274dm826+7DWogqwhGLjjtab5CLWCT/AVNnXXdKNNcuzCeIUjs+3kcymbkX?=
 =?us-ascii?Q?zl5i/qo3Oi7x+oxiGLbTHMSeTMB8NXIdV6dLzHj5nA15lscoeVY/EN/CLfaQ?=
 =?us-ascii?Q?EFB+Hj5TIrCMPZxEUdTjLvdv9+6JsrVwkQCScSWlMqYgaWazVSXC2VHnfmfj?=
 =?us-ascii?Q?kTTM0gV6UKGbCBnsNuRGkBM1GvFJF/eycJJfbDzp2MIqTVpb8BogvlI/FUDF?=
 =?us-ascii?Q?zkmUAELqcpBK721uZd/YzUTHOq3ufV7lUpo9+PbZ0Rdjqyz2yl4+l+3Ki9IP?=
 =?us-ascii?Q?Q8Hz5JEG11p8CppkuWBanyEnVfOCnvDaYnq1B+mj8zufT223PCsmLxpI1G+Z?=
 =?us-ascii?Q?xBvZ0L67ysG7bLX/TihjiaKvadmVDCkjoupdMGJZlrALchkGDIVerfljpDfB?=
 =?us-ascii?Q?QlLphMSTWT2PEla5w6tgrqX2ZxMIycZjBG0rZKh31wY8Bxc4yzCO5I0YaB7h?=
 =?us-ascii?Q?i/og4P8xn62Ojp9HMo185Af0Vjdfh5L9Vw1xiUrRgk7JMLT3bDwKuny8n6Ui?=
 =?us-ascii?Q?3dxmBehNuxeT93hPyLGKmX1sgb+zgeKSM9dL/X2LHAfc86AQnmEHonic7kzn?=
 =?us-ascii?Q?3fagIm9FKBeVISVbtCJ7M4mi8fmUPiTG2O95PXeV1ddZ4/xFL+fPA6lZtTX9?=
 =?us-ascii?Q?k27YBbWKVite/3LEamGPvFKmZrQwM/nn?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CY5PR12MB6369.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(38070700018)(7053199007); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?1DmSiG+xM7w+kNprcJj3pr3cAG3P8ZnSUtxucwjZHWnqPjjNd/Ke8USt3GP5?=
 =?us-ascii?Q?XsFWF0JLagqsBT/P1XREEwr9NRUO5IBgWaeqATsCy+huDpciUhMbcbRitb8h?=
 =?us-ascii?Q?vukuxgVCQ+BiTPjgLH9WJIq4W4C+Pf/3KhoRjA+2N+2vzUC63hBycaH/151S?=
 =?us-ascii?Q?BVJxKQzSGUhOAKqoLeqZdu3WfbA54AX72jEzshalF7+PIs/Uda8CI/HtG/BA?=
 =?us-ascii?Q?qPNB2eNMqkfDNs2BB06Iz2CIc5RHk1TGJqxiS25FCXk6rGXiOmr2uYFFnu+A?=
 =?us-ascii?Q?NcnKNfv+hEezhpiO/k3+Cyp0My8PSkkHyfvH65GqY8lkvSOBQ9RvGsIuWddH?=
 =?us-ascii?Q?EpVoUFdA21L/FAj52inFJ0Lvc71CuimmgDji31dSiQxBGzt92c1SBvFo/sIe?=
 =?us-ascii?Q?MMjlCaFJ0zbNkoZ94o67qqNFi9dyCTsftk6anuP29Lt5TfViYQ6FnNwuakl3?=
 =?us-ascii?Q?eFZqkpnqSr8UJv41t9kPhN9xWxLMoYGYky0tZlqDK8fzogBR1PAaoAK60PcU?=
 =?us-ascii?Q?FmMQ+8xxJS9AsogH9acrFSNHETRpfo2N7IyBYG/5yyNFUoRcKfBN2TuF92cj?=
 =?us-ascii?Q?dRoDMmVY9VR+jSMGzWTmjTjjjMYehFOZDhPE0WwdkKvjSRXZJeJXvdBu+rHR?=
 =?us-ascii?Q?GCMmvmcACZgdNOfDgtuBL77YimYvJl3lMRZ9YIfWaIkUnEQzUMK8kw6qyOil?=
 =?us-ascii?Q?2rRRHWljVAV280oGBwfFeUflxBZFXclch63lrrJNklVH87UX8uNyszGJIDn1?=
 =?us-ascii?Q?aePCOUitHcpyrLOENneSWUiHLq/CpZiXxYaNdY7lH4rprapeRkTQs5HLwwNR?=
 =?us-ascii?Q?qFmhqxBbtcI2rY/Bf/s+cxoLvdgSJ9V4XuDF6FvLwHStIYkg3fgAhEgh4Zvv?=
 =?us-ascii?Q?y4vWcee6zbEsflsr3oBfxzkgAPB+nw0cwaFPD2qPmzBSufWrDIwpZY32dqeA?=
 =?us-ascii?Q?FZzBK0qkcY3q5h1Ut9zx1MuaaBuRPsbrdo3SIYdFlVRlFMvEz8bNFzXJH3Zw?=
 =?us-ascii?Q?OV1VMQFAZaFbRDO/wDVFGK4zsbPlFH1rXQcyjUpLT5FkPEdG6jfFeSY0HnVw?=
 =?us-ascii?Q?DH1l9EMBCQq2bESEHONG7iDKjduyOsQSqiP5NckOy0JIAKnqRm+hJZEuBEBZ?=
 =?us-ascii?Q?mBXy8HZdO/39LwxJlbGKf2XHEi0SYvCymHOIXu3nvfGAf18xS6x+5uAYXZ9b?=
 =?us-ascii?Q?mRSHHWFYmnQHECyMkPBq7gp+sc6nQDmyfHTWozes842M8gthRFhEr6+VhE7o?=
 =?us-ascii?Q?hqYGKgzb68AOYuPOPnUNG721pYbCmqPpe+sxLBJCWkPbkQpMnMxlhMoqo8Z1?=
 =?us-ascii?Q?/QEB6zTfWSPR+ovnd0g8cz6JVwv5wbsSxANBhwDTWz35c+44C60wzDWbRK7T?=
 =?us-ascii?Q?Yny1LxRPL/QRafF6K2PwXmdf91BwYZsVVWbx94FXlwQQinNDC89Gy/crXWdV?=
 =?us-ascii?Q?AAqsDsuy2oNcZU4zF4k6x20bxxndq494ziQ1Z6eDwv1m6kfbVefM0GvQJYI+?=
 =?us-ascii?Q?C0KkGwU74lEgxqhamcqABfmAc3tqTY2SeQ4nOAl3aEUd7+gD6C9fyCupYob4?=
 =?us-ascii?Q?TgBqjRWkpi+/U2cHNzE=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY5PR12MB6369.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4740082d-29c4-44e0-5c50-08dd48091fe6
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Feb 2025 06:23:38.3220 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: HzVSTTCuHRK9iHOVSBzfe6Q6Ts9Kd+XA6rejN1kZnOLaxmSJWYjh1YGCZNMpV8Sp
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB6888
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

Reviewed-by: Yifan Zhang <yifan1.zhang@amd.com>


-----Original Message-----
From: Huang, Tim <Tim.Huang@amd.com>
Sent: Saturday, February 8, 2025 11:46 AM
To: amd-gfx@lists.freedesktop.org
Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Zhang, Yifan <Yifan1.Zh=
ang@amd.com>; Huang, Tim <Tim.Huang@amd.com>
Subject: [PATCH] drm/amdgpu: add discovery support for DCN IP version 3.6.0

Add discovery entry for DCN IP version 3.6.0.

Signed-off-by: Tim Huang <tim.huang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c b/drivers/gpu/dr=
m/amd/amdgpu/amdgpu_discovery.c
index eca431e52038..998a5e48ba0d 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
@@ -2162,6 +2162,7 @@ static int amdgpu_discovery_set_display_ip_blocks(str=
uct amdgpu_device *adev)
                case IP_VERSION(3, 2, 1):
                case IP_VERSION(3, 5, 0):
                case IP_VERSION(3, 5, 1):
+               case IP_VERSION(3, 6, 0):
                case IP_VERSION(4, 1, 0):
                        /* TODO: Fix IP version. DC code expects version 4.=
0.1 */
                        if (adev->ip_versions[DCE_HWIP][0] =3D=3D IP_VERSIO=
N(4, 1, 0))
--
2.43.0

