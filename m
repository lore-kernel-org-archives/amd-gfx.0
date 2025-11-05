Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6544CCCFA0D
	for <amd-gfx@archiver.kernel.org>; Wed,  5 Nov 2025 12:37:50 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1369810E720;
	Wed,  5 Nov 2025 12:37:50 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="qQkmW+xT";
	dkim-atps=neutral
Received: from CH1PR05CU001.outbound.protection.outlook.com
 (mail-northcentralusazon11010018.outbound.protection.outlook.com
 [52.101.193.18])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9961910E71E
 for <amd-gfx@lists.freedesktop.org>; Wed,  5 Nov 2025 12:37:48 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=B6bzThH1ChosZ+8JnsPQsdUXbimk4NyKG0dHStclRWX4Ab1IrcyzJh/lfYYI+cdyJhHE9/uFHzdt0PqJqVaLoX1tER9Rq+Tm5FUz6tUgz7EJcex+viB4HtskqV7k7OxulQt7g7Reuj0YFESjgVtfcMp2Re6UfyHZ4Ts8/78LUMd5/hGdOdZ1CFaBjyMEcRNxCfAPBKLEGM6Tn/lm6P2vatChUgpCBeragmAGRW+QwETqoAzfVRZk0ckyVwcrPFDXCO+CATL2OnORoc0fX1VyqjMZYJwdSKHMzxwVhEiJJAeP3bgmTxhj50YgbArIvkD6xgoDwNncSLgoTxVRZL16lQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=p04RhCCePpapO6Bl1swfDAaVr78ug7iMYmu2PZ/IhxY=;
 b=cct9BqZBLUXG8xaXqBmKBSaOYdoZGB9+Q0s1TNVL4h+IeLKFOnL5V0xMBImB17KmKzBn2hzEyIaVj0L+QoWa2VsvxHHg7AICqnZmBPfDQyvxjS+/g3b5qO+03oFiRqgNM3I0H9VKrCLgvIcZImeatB2x1NI35jvUJM7WexhmpXBn8AtR8xkw8suJ7VyKb0RL8Z+rTvTlNgZZnyzki6mXlLiQ+0YURBGTJYHAGdDVo3/bwTFJdNrx0yGuAGHyBoShnanjq3Vguoj70qszjNbcCG2m7B5Ejy/8UGmpVvgURQam9WZFSDeip/dxPFM2mP1fD5ToHmZWjw2znuhOpWBbVA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=p04RhCCePpapO6Bl1swfDAaVr78ug7iMYmu2PZ/IhxY=;
 b=qQkmW+xT/c31TdsxaEr+ugJYqM7tczjFHprU6cDA1MV1b/YaSLBOOCJjzSce7+vsUIOy9aJc1NvvKFDI/Xi8qARKYWuDH2rqoY+QG9KqDrfBxLRdAvGu304n+XXRVRL8Gaha/j/fz+K9b5y3UEKeNGhu0ZRWzqmh2wQ2O78JKzw=
Received: from BN9PR12MB5257.namprd12.prod.outlook.com (2603:10b6:408:11e::16)
 by SA1PR12MB6848.namprd12.prod.outlook.com (2603:10b6:806:25f::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9298.7; Wed, 5 Nov
 2025 12:37:45 +0000
Received: from BN9PR12MB5257.namprd12.prod.outlook.com
 ([fe80::c593:f43d:c798:e009]) by BN9PR12MB5257.namprd12.prod.outlook.com
 ([fe80::c593:f43d:c798:e009%4]) with mapi id 15.20.9298.006; Wed, 5 Nov 2025
 12:37:45 +0000
From: "Zhang, Hawking" <Hawking.Zhang@amd.com>
To: "Chai, Thomas" <YiPeng.Chai@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
CC: "Zhou1, Tao" <Tao.Zhou1@amd.com>, "Li, Candice" <Candice.Li@amd.com>,
 "Yang, Stanley" <Stanley.Yang@amd.com>, "Su, Joe" <Jinzhou.Su@amd.com>
Subject: RE: [PATCH] drm/amd/ras: Fix the issue of incorrect function call
Thread-Topic: [PATCH] drm/amd/ras: Fix the issue of incorrect function call
Thread-Index: AQHcTk8Y00IikTtqY06fGJuoBbGexLTkBUDg
Date: Wed, 5 Nov 2025 12:37:44 +0000
Message-ID: <BN9PR12MB52575604FDC942E03D12F4DEFCC5A@BN9PR12MB5257.namprd12.prod.outlook.com>
References: <20251105122337.4066923-1-YiPeng.Chai@amd.com>
In-Reply-To: <20251105122337.4066923-1-YiPeng.Chai@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=True;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2025-11-05T12:37:23.0000000Z;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution
 Only; MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=3;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR12MB5257:EE_|SA1PR12MB6848:EE_
x-ms-office365-filtering-correlation-id: d615f289-053b-4566-b5e4-08de1c681ead
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|376014|1800799024|38070700021|7053199007; 
x-microsoft-antispam-message-info: =?us-ascii?Q?+TJWQfauYVggblN4mjZNCh8qeTfvBcU2vWx/srdFmw1QYUaFIAywnMdc6xQk?=
 =?us-ascii?Q?W6jyIZ7ph20Q4s8rGhiatvhlEDlNdFkihCNqbCUiHNG384xJObOjoTfgtIkX?=
 =?us-ascii?Q?croCuzBlEeEJhy3ib3QKT+IWIo4DSxVfjPTEitx3cXPCjpdUs+Q/s2bt8E8P?=
 =?us-ascii?Q?XNiGk1Y89zaK5NAlhv0HqUwpYcm6wQWxXNnIO2bZ6O0/54w2KC1k4z7RLdLg?=
 =?us-ascii?Q?HabU78EHIAuStTyrCcps+HG46GRXGt35Su4d5Bi/+8DAEPQ55KkCte0UR8ZW?=
 =?us-ascii?Q?eKx9L317813TkDidmBgDRWNYM7RdgNAD1RGzAfdDFE54ci+a353iTZVx3MV9?=
 =?us-ascii?Q?3w3I5H3uisYMeQbXy/JRnG143uEJp5R9sIijF/MBBol7ZeqGpavomvifv8bM?=
 =?us-ascii?Q?heJ1zMfH+pSb/vA1jUKBMQX0V3JlumnQtBdu9pV+sIWZhIPhOnLoG418M5PE?=
 =?us-ascii?Q?61WdtHX/ncvYak0wBlwooXmS52oAvb0MwUelXj5XZnUza+uPrqbpAKpyv9Rc?=
 =?us-ascii?Q?n3GxVcg7ybyag1JQOmVB9JsG0kbZBfEMUc7lNYdBgPYZbBB4va+bHAs4P0LU?=
 =?us-ascii?Q?KpGrTWn05dqUQKnV81H3mkg+tzqfbjHXdz9t7/WJE941plfTyXt1BdxevDBS?=
 =?us-ascii?Q?T46EGWyUWTGN1pKtLL2oW1Nx38faWT3kM44+xEQQpeSuokNlz4/kteF/puBM?=
 =?us-ascii?Q?F7WC6o272JvofhGyN9dsOrCgFeWPVUQNkS9UkeWRSHc2LNFP0J0IH1BlJ++K?=
 =?us-ascii?Q?DoJvic3eZv9nsQu7Ne6PGwS03p7cbOg5MjoMzEAPxoqUe0lNMvwM+tEHdeK2?=
 =?us-ascii?Q?4ABZjNzCkeuGuUY0Kk+MGz/8wbkK5AerZ90eCqM3ThV7C3XXxTQFx0Ul4NXn?=
 =?us-ascii?Q?zyuJB0B8Lo7m9eT5Zmm6Q8QBx+DHUG9LwYPBJsPoESGyMONUbR1IOebSnh4m?=
 =?us-ascii?Q?EzTXtg5K+UZUY1fyCkRPEqOeZ1X96lQy/Ws+z19XJtrjGt4xTlNf+ZBiaKh5?=
 =?us-ascii?Q?Uq1vuklsW0an0Law3oBJfxnjweAQ4JcTv8yd6Bb1rbFWnr8nduFK/o6DD8XP?=
 =?us-ascii?Q?ObLyulr+xwfMoWqY5czdt6EHWCpMMrKPnshiKbAGCJHpO1NDEEkxoyrVeaCl?=
 =?us-ascii?Q?GFd0Ni2RaJJvS2YRXvKUt+Ks9QwYnjTWIbg4m2QLBIogvTArh6qPcOSJfl1v?=
 =?us-ascii?Q?6jhP5reZKQFGic7CU7eVglot4INjrbPz98iZjxNmM1v47CSBQ/wOG6p2/RD0?=
 =?us-ascii?Q?dJMUn3EnuV289XwARluJ2fSqSdb82Q/M6OenYveHwvNeBOA6y7B+PlrpLDo7?=
 =?us-ascii?Q?eHx96GKJ9qWdm7VGdv3VrQrIxPpkAzinYmBN83htFl40l1dtz0K2/hWBK1aL?=
 =?us-ascii?Q?uEeWDg6vvwWDlk+An3TB12M0FjG1NeK1vd6Ebd2bJxqllmGSBQZAobDZcIPv?=
 =?us-ascii?Q?92sTTf6sRBW3k8Qi3WdCi5giFek/q0oV8YJMIhdNP39nLoerQCVWnRp8byTE?=
 =?us-ascii?Q?YqJ/636xzSJ3xWrujVvjkSPiMeoD6wBdMAML?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5257.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(38070700021)(7053199007); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?4Fa7/ijz3TUJnzzi76Jn4jvlekdREpSXGjsLlIl5pwVq10nS3qQ5lbz/aFYn?=
 =?us-ascii?Q?sn1xQtnW/oeXt/tPBnD3GLKpNy2fAInAVbY2vtuK96FYzCbHMVs+IFq2Y+bT?=
 =?us-ascii?Q?a5Y665XiZ2bGPV5oNk7ZhuhPYAAhaLzGKjUMSn5QdO/pjtKyoSb86QvAF6CG?=
 =?us-ascii?Q?vb85leqBr7Y+JBWzK22eLIX8YCTrM+sDZiOenvHErm9B+uQSI2k4fibJW+5H?=
 =?us-ascii?Q?IXaW747e3Y8o6H9u/QWIabhMjV0ZcYla/ruBLU08kc6mLsXmHDShbkvxNwD2?=
 =?us-ascii?Q?1I8E+7130FF9OZttnLxANr+Ywmh7XqG8btHxUh1hEd/lKGc5CXNuxqgCRsOr?=
 =?us-ascii?Q?jmcuZ4l8qRqu8diT5dw//xzGhymr7ARYIE6Zy8SCYv6K/6DZ+CMIgjOGCR0Q?=
 =?us-ascii?Q?wtI0NG2QklhbLFhLrIWdQAQjy4qRtWl61F0tZ6T2yEZ9f0CdsnF2Hvngrbq1?=
 =?us-ascii?Q?DFVcivyGYhn00RkAsxdEkGQ8WbVays4r385zrm4kip9Z0oqvNSNhlsmoebNR?=
 =?us-ascii?Q?UrTKXcPkzcGEuAY0lu5OzDimDI7P7va6WON30HepDZg7qYS3SFzl7Y3/NMaY?=
 =?us-ascii?Q?mp+larDzcv3DHiguMjns2NWTadpetk/spR80cGda8ogk4AkGDQg9NWfwxluJ?=
 =?us-ascii?Q?MgFXtqr5W2bQ4nLZIRHiFiLR8m04ocaBbz7/q+pKLAW9tGDMHvUm5DmOhuTc?=
 =?us-ascii?Q?Jmuk0KWvVojkUuZX9EifDA9VqckHpHeTnPptnDpyFh9M7WTjrdc5RiP7y+3X?=
 =?us-ascii?Q?VM2XXKxl+8kOaHJsIUco7mD+kiJUWj5UIDY4gngtBrXm5r0oqlfmEn417qM2?=
 =?us-ascii?Q?vGntbstpD8AF3fV+a6qBYkJ2Usn2D+6yGYqHm0ykma91WgOjznA30Jbh15Dd?=
 =?us-ascii?Q?sDAEHKZPbgurrDeVyCi+xVUsgTdhk/BAaLnSAXev5sWzfWXekx3ciIM80zt1?=
 =?us-ascii?Q?h5e/IUaBhyH1MvH6x37CMm5sWL6EoDzVj81nSZxcqhfBfPHeTgfvu4lc5zUx?=
 =?us-ascii?Q?DYAbxDoASQULGKzsPwiUuxh5t2DaPUX9zPYoXdF9w2qCO8QOXNQ/V06FEald?=
 =?us-ascii?Q?dDGd5MxFOBq6n7w898aAuVmphjl2SwrJUMmEgbzn3fSA2G0t1vEuMLE0BLUX?=
 =?us-ascii?Q?LlMem2g3BrDXXGQ1p/bIL04VxTx4Iz7J0aivqcqWbsabkANoZdJdC7QQ/PZD?=
 =?us-ascii?Q?8Qp7cudO+IdDalj3TpIjytjbGR+I1pT386OhMGsjBpWGURW0T/FhFl02VNlb?=
 =?us-ascii?Q?WYQhmvPAcqJ+t4mBe4K+kZZrzEupJbsL1KyVmnZ7SpCee5ljbhaKXOYhBkxj?=
 =?us-ascii?Q?ZW8JRXNVoPfNetlN0jI02Bc5HPhWZ7uOfhROwHHoFLLamPMhigh3j++2prtK?=
 =?us-ascii?Q?Fjt22WQNo6zJZ92Yw0iXvjYwiLdmZB1yEWDVFT5EHpR8ycV+d+8F1z3UZu87?=
 =?us-ascii?Q?457ocNNMqryIICP8LI0Fx7aFdj3A0iRBwiPB9vO3Fq0ndr1U1UzfSp9DBMIG?=
 =?us-ascii?Q?tJhnxhkFJ1aDQg6ezHvO++5hfZsBM0LydWOWLx1pyskkdTV2fwfm6+ddc1or?=
 =?us-ascii?Q?kG3rGjg+MmmXjLVr/ys=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5257.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d615f289-053b-4566-b5e4-08de1c681ead
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Nov 2025 12:37:44.9708 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 8WLgpZG6Apflf4vwz+cUsYfUKloPrdR9soXHUaPV+fLojqF8oEZMlDcGZGVYNRrUJjhxUV8QpMSdI/EaSWSfRg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB6848
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
From: Chai, Thomas <YiPeng.Chai@amd.com>
Sent: Wednesday, November 5, 2025 20:24
To: amd-gfx@lists.freedesktop.org
Cc: Zhang, Hawking <Hawking.Zhang@amd.com>; Zhou1, Tao <Tao.Zhou1@amd.com>;=
 Li, Candice <Candice.Li@amd.com>; Yang, Stanley <Stanley.Yang@amd.com>; Su=
, Joe <Jinzhou.Su@amd.com>; Chai, Thomas <YiPeng.Chai@amd.com>
Subject: [PATCH] drm/amd/ras: Fix the issue of incorrect function call

When amdgpu_device_health_check fails, amdgpu_ras_pre_reset will not be cal=
led and therefore amdgpu_ras_post_reset cannot be called either.

Signed-off-by: YiPeng Chai <YiPeng.Chai@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/a=
md/amdgpu/amdgpu_device.c
index 7ee3dabc0cf5..eca11fbc637a 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -6751,8 +6751,8 @@ int amdgpu_device_gpu_recover(struct amdgpu_device *a=
dev,
        amdgpu_device_gpu_resume(adev, &device_list, need_emergency_restart=
);
 reset_unlock:
        amdgpu_device_recovery_put_reset_lock(adev, &device_list);
-end_reset:
        amdgpu_ras_post_reset(adev, &device_list);
+end_reset:
        if (hive) {
                mutex_unlock(&hive->hive_lock);
                amdgpu_put_xgmi_hive(hive);
--
2.34.1

