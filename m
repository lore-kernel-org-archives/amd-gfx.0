Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 90B31C3DA41
	for <amd-gfx@archiver.kernel.org>; Wed, 10 Jul 2024 15:54:00 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3497B10E821;
	Wed, 10 Jul 2024 15:54:00 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="swfC8u1R";
	dkim-atps=neutral
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2085.outbound.protection.outlook.com [40.107.220.85])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6EDCF10E821
 for <amd-gfx@lists.freedesktop.org>; Wed, 10 Jul 2024 15:53:59 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bBNDwyxuKc9hv8uyiDvuKhwRVvzMcbsnN1jtnXQEE5Qz+5xQpm1NCaO/G2zmWVLgUJpcAHwTuOSByO3FeTAkwxY/d//KREqgvV9uKJnbLxwHgvt4dvZoAo0nSSggHgsisJqzQHV7asI7TUwe8OMGuOY6dldt4eB+8ji2iCNNhsNMcu8MLk7UR9ezc6bSSUEA5cAIyCY7TsZGjIv/S/IVjRGwXTGfwTu59XHkCIS8P/X4IXG90+NPsMDJrEedSFJK07TeK8lq3xsUIXM5iYmMtT9Y51BJmoD5BMAg8NhHO8vhAT7Ti5DqNlLt1Fn9agG7sD3RfH1IsPKVyVxf145BHA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fFPj9gp4Qcyckp4ZyRFWeULyupdKCSo6bdJHWtCnE7E=;
 b=a8TogyfSO9wwmyoYviiC8KrCDUVt+vDqbI9eJ6k0q+0kgCYGketG7EqoWWDJgg+77IVDTVCnyFjVZGTFk0AxWp8T3hPuYLmUIebivWB/W4HAVk+A+LGfVQGuolY5uFfx/gXPU/dIBMA+4is0MBcGD94NHrxoikxXCqnzXIf/cV8WITXcBdovu51AtccjKlfzt7OUCNimUXemxqhdnCJU8zwS/HEwaPrQkyeh+3+XElxrAbJfPhcim0XnNQyLJnQAufvvsUVLuB9Yx0xhU+SHDjBJ31oWNqtFek/xhE9/GTSpRjLrIoD5twzLuqkj0xrT4pmpeTBxG/ifK4hBLObwiQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fFPj9gp4Qcyckp4ZyRFWeULyupdKCSo6bdJHWtCnE7E=;
 b=swfC8u1Rv7hGVQ1+q1jv5t4kjmEyG7pw+17RhToCF0Y8E4dUkGzqsV/Tj7q2kAs0EE1q9LNnfZsXEMUpBh1E2GB5YaGWcUhgHRtBgC39RWhepTVGEdA6SYqcpvALjZFtMRgrCJO6uOReyrhO1sqRTVWKHTXg1D2Y1KZlBpvZawM=
Received: from BN9PR12MB5257.namprd12.prod.outlook.com (2603:10b6:408:11e::16)
 by DS0PR12MB8198.namprd12.prod.outlook.com (2603:10b6:8:f2::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7741.34; Wed, 10 Jul
 2024 15:53:52 +0000
Received: from BN9PR12MB5257.namprd12.prod.outlook.com
 ([fe80::c593:f43d:c798:e009]) by BN9PR12MB5257.namprd12.prod.outlook.com
 ([fe80::c593:f43d:c798:e009%6]) with mapi id 15.20.7762.016; Wed, 10 Jul 2024
 15:53:52 +0000
From: "Zhang, Hawking" <Hawking.Zhang@amd.com>
To: "Deucher, Alexander" <Alexander.Deucher@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
CC: "Deucher, Alexander" <Alexander.Deucher@amd.com>
Subject: RE: [PATCH] drm/amdgpu: remove exp hw support check for gfx12
Thread-Topic: [PATCH] drm/amdgpu: remove exp hw support check for gfx12
Thread-Index: AQHa0tOuSTT8Z5Qg002jBUuNlVvLn7HwHPSA
Date: Wed, 10 Jul 2024 15:53:52 +0000
Message-ID: <BN9PR12MB52579526A3779BA610B905B7FCA42@BN9PR12MB5257.namprd12.prod.outlook.com>
References: <20240710141527.2224390-1-alexander.deucher@amd.com>
In-Reply-To: <20240710141527.2224390-1-alexander.deucher@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ActionId=4ad6e816-0114-44fc-9385-111aaaa6fcc9;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=0;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=true;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution Only;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2024-07-10T15:53:27Z;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR12MB5257:EE_|DS0PR12MB8198:EE_
x-ms-office365-filtering-correlation-id: 3de575f2-0951-464a-9d88-08dca0f87f36
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|1800799024|376014|366016|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?IY6bCsBxfnLqAJIpPwRl4i/Ep8aRNFQkChglJfF2ba6hh7vS1Zmb3krEVgpC?=
 =?us-ascii?Q?JCzC96YfTyCnzoj/X7xtnJjoI4xyelO5gF5wEugbcmEJMCINg8vUvKlX+/rp?=
 =?us-ascii?Q?6esT/gKa/RlM3pxFgXZzMdJsA8lhIX3jgo2ZvLeTdMKGv3AjKMX6SXosrXL+?=
 =?us-ascii?Q?9/2GuF/I0P40k1lvFOultMACIGw6pVOO2ZWYW8UlqVkvCRdrmSv1bxb057dY?=
 =?us-ascii?Q?w8GOH7VwvggikBkWPfjV8sAgkmJOLFwn1OoMJBAmShUx3Obh/EBYtf1b2ri/?=
 =?us-ascii?Q?ibb7j/8MwQvfjE3OnWvxCpxl4a0afH3GipzlE4XqE3Ikr9J71HOBmX/zZzWU?=
 =?us-ascii?Q?dCNUNbpPeU9ESc8HteuIjZeB0EWcvjUl2g4vEh9vASQ6A2NGMJRSjXvD4isY?=
 =?us-ascii?Q?SrOb7cnAPOoS63XBut/HVad0zHRuhkVTt47sSDi/sDkQOfNIT2n+Aju2tdo4?=
 =?us-ascii?Q?FHPWP7MSAwUCCwfGC73rnAA8/juhrcKa6tWWSWjJVn7RPrcZA6Sib+SYsmUT?=
 =?us-ascii?Q?sVL2UQdhLBVjDivdfGqgbDcjOXqxkBYNS9bA8RIg0rabqhFGq2wkbyqwc0l+?=
 =?us-ascii?Q?sVLqUY2DTaW9AyxUdn8BF55YUzMriulU92cGUwP8hY4asRQixdZasa1H9jpM?=
 =?us-ascii?Q?7X0mBc+kcw6wIFIhLGZlSg20N0ERa021jbDypdR6AeI1YuGTzDzkUdCjdw1y?=
 =?us-ascii?Q?2pOMilVerVKzB9dUrstgIiX0VdyXNhrKstnAN8Mn+AGq7xlIxLyBgvYpbrEQ?=
 =?us-ascii?Q?Ga4PxET+sHXYn4AbnHb9UESKO11/TIz30Y8fJz8Pdxg1pj9Pvx/MZwUl9Wlk?=
 =?us-ascii?Q?+xbZKUisr6S1w21b0IkZCyCdZf3Cb0Z9J4TOPqPHwlvFJtibsgInoAEXdVgE?=
 =?us-ascii?Q?Ji6CtIfLP2kkKj1uECt8EW5QDXR1/dbvYSY66zmpek2yB3R6KfpEROk/xBdA?=
 =?us-ascii?Q?pPjoHsqIdXXW+U8QRRPpALDvJ5d0EBH1INK9x9lvL7sQLG03xtapq7aAYQ+s?=
 =?us-ascii?Q?/LoX7dzCNWF2gzk5cVez8c+LmmAsakTRg+/qmTeDF9h/Ql8ttjiNmODyIi9t?=
 =?us-ascii?Q?xxhnjYEq8DOSv92/YQcPUNX+M8OazcrH3put7tXaA3vdLX829WlTHAH6OdXb?=
 =?us-ascii?Q?zH9zwpQuSa4swnU1M1KWQY8yBAOgmmSxYHpAEn9JuJS0hk6Id6/A2lX0co2Y?=
 =?us-ascii?Q?3+YfK869Xn9NV5tk058GbmmCFRMOM1OysI81+Yb/s8FuhLhovpeQa+57DA5M?=
 =?us-ascii?Q?9t8onahOavMaOMha9rFwnyGs8ASKOF6KYF524fHjcGDp4Hd6RSfS+wPJ2UU7?=
 =?us-ascii?Q?zSyoyjSjA1xScpsgRkMBfbPTNjRMrbv2hq3qEjbuLTTEzWr6AUan9zUMMB/d?=
 =?us-ascii?Q?eE/frLN8SuzRohCFC8RzJr1P2qhtcbZ1wZpySx7/W+zKEgTNww=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5257.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(38070700018); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?//Us2Da3g2Nysp8X9tiwu9hIRHmHxwuFmJl+vh6BFQ4VkCQLNYF/xnSJpdQp?=
 =?us-ascii?Q?bptaMElU+pkILmxy7ywDy3WlphHyE/9lpzlGFEqNxS9M1ARBnRf3U4Msi9t9?=
 =?us-ascii?Q?YAgW9FLYjxGFvp2tpnVkQWrQFs8Se2U/FYa1QlIoLRHHC2fqOSoks4z5NGSp?=
 =?us-ascii?Q?XtGcdL0sryUTHmim2RZCU66EXuDHbnz6vTtoBzWZTrvP1Kn5sSoqsLXiWxig?=
 =?us-ascii?Q?GpSqQb3AmbjEOVA7FZ3LVKWqldnAvH9YYUw6lF0aq0AEynHjYHEjFCnMieQH?=
 =?us-ascii?Q?xzbVH7PPPuMuCajFTuIli0q2E9DHOJQPP4TLFxXUfnVd/l33Fz9RF1WQtwXG?=
 =?us-ascii?Q?1QwrdprDnj6LWO1fsRtci4zVO/dNQeq+NnIgArp1gt3jEvR28hh6NAapKjU1?=
 =?us-ascii?Q?8IGxZ8zepBtAZyHtD0wYTGgrkE7PMpeKmwAUkNnfrUppBRO3y87VxPItzr+A?=
 =?us-ascii?Q?7kAsCVzgzkaxNYj+IiWK9tw+AjLADbgVQCZkkoL0HauJvF/34j6vxSrYgS+v?=
 =?us-ascii?Q?PYPQhn44TTbWtXWzudYSL7wcLDWoPSr5AzChOTTEamDae9T0Eh+JKGUllmfA?=
 =?us-ascii?Q?E1YKbGczG+3Qm2tpTGzQ/m9VB9F2LwUQkPupr/vvZoclkgWfUXCMobnHst1s?=
 =?us-ascii?Q?XbuPWb7TH6dxVOcm1yveowoI8m6ViGai5mf8bx5j94JHokg15Fl8KTgwtEaQ?=
 =?us-ascii?Q?LGazxGNHjHmGr7n065vQ01KeJQARoBrpk73jLk/VYDTSjDrumKIVvW+oQqmI?=
 =?us-ascii?Q?yC7RWErIaI4EECDKDiHg5zMz0AQja0DBHSNeoe5jAWe8glOkoMtZeBkoWLAW?=
 =?us-ascii?Q?nDDxeWOU0OpaCIeNcPZdM7+ARbdYkEE2ovu5NWJFV1MGyynVAEUSmTpVOji9?=
 =?us-ascii?Q?BfFJhPTxbBRG2NtzUAzov5JLiaxZiQFWe1C+SyoAV7aem9TdY+QATmE0Xk0a?=
 =?us-ascii?Q?SjTUP6yA2ZhUcAr/b6iXgEn4eQUsBvrBXWTmKuOTc2eq/YVcJPat5H9SWyNU?=
 =?us-ascii?Q?3U4WsZRnCjkaOxGPkRytbm+2vI3Npl/PKgfWPopanEfxC3FD5b5SBtgPNonB?=
 =?us-ascii?Q?WRaYJSailD60OL6eoQTTwSEnL9cWD8qyrHRVwCbYgLQP5WdLkx66schurXuv?=
 =?us-ascii?Q?hfPav963eaygK7924a+d2kXxexAsESZI52t6YGRwdC/1uxxFAQs92nGos4Nr?=
 =?us-ascii?Q?zW9QYq0jPTsjyIK4j1N738HBWBGFV1+8akym7rPnYlZOj9hbPbNglsN/mq/I?=
 =?us-ascii?Q?Zod8KyZ9QT+U4qDCHNeu09c8NcL1pKpcOY91u/fTdT+8LgyS1lNokc7ZscP/?=
 =?us-ascii?Q?M9yIbgPqkkKzQG8HylpLtdK6dOXHUbI0vqD/4eBrLRxB3S/hHGpgp5v1I83/?=
 =?us-ascii?Q?ESvOi0SlOs01DaPolgPcfQYVJGbPDrxq0NAS0ndWPyFGN3YO/inSW7hhtapd?=
 =?us-ascii?Q?VJkRmO1+T/vQxgwHwQWP3QrOsT+AImLNpHnE33ETij4SzsGenHCq1IxQW7q8?=
 =?us-ascii?Q?y1H+6EbIBpbRr9A8aun7/uWOVfrdZ6KSDg4p3k2o9P1Xc6+Z4T45ka5eIGy7?=
 =?us-ascii?Q?O4UdqqkyMlKPAONK8Ak=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5257.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3de575f2-0951-464a-9d88-08dca0f87f36
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Jul 2024 15:53:52.6179 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 7Ay5FXgQ31FuvNqeFPhckl43LD1QtwAYbfgZa3jFAVEh6dpC18AoNP9VuxrIP2Uc0ow5vFZFo3FO3LEmn0NjZg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8198
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
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Alex Deu=
cher
Sent: Wednesday, July 10, 2024 22:15
To: amd-gfx@lists.freedesktop.org
Cc: Deucher, Alexander <Alexander.Deucher@amd.com>
Subject: [PATCH] drm/amdgpu: remove exp hw support check for gfx12

Enable it by default.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c b/drivers/gpu/dr=
m/amd/amdgpu/amdgpu_discovery.c
index f927ccd7ec45..b241f61fe9c9 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
@@ -2161,8 +2161,6 @@ static int amdgpu_discovery_set_gc_ip_blocks(struct a=
mdgpu_device *adev)
                break;
        case IP_VERSION(12, 0, 0):
        case IP_VERSION(12, 0, 1):
-               if (!amdgpu_exp_hw_support)
-                       return -EINVAL;
                amdgpu_device_ip_block_add(adev, &gfx_v12_0_ip_block);
                break;
        default:
--
2.45.2

