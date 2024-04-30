Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 03F37C4345F
	for <amd-gfx@archiver.kernel.org>; Tue, 30 Apr 2024 14:43:46 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8F0C010FEB4;
	Tue, 30 Apr 2024 14:43:45 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="nOfac+kl";
	dkim-atps=neutral
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2078.outbound.protection.outlook.com [40.107.94.78])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CF2DA10FEB4
 for <amd-gfx@lists.freedesktop.org>; Tue, 30 Apr 2024 14:43:44 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WkjzO9fGbivdZ2v8411S+fPJeVtVt+T5EsttxwqCP+k2Eypj9wf0VBIh1/kChtAUCAYu8m8oc2p/K5Ks/7fVXPN7LrMt6pP/lCQjlTV1Vgc0HrMARtQShKuT087ECCYK8FGff5r4G0DCfAmHmBviVbSTake/8wRzLREr+rlbaWoWQtVl0Tu4I9eV4VrOVe/2wTJu8/vghoxrCJmld81jTIPzjOpS8TGjPipJxLV7/xkOz+wWpYLnsOTh1qc6lmLkieee3vj45D4X9GSSCV15lAqMkBrQcXQRa/bJ2pJqQx7F07n1DyGXpZ0c4vaOKZBm2LEH+Qw9O2ZW1Li+LhSARg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=o1rKHr4Bo+VL7cS8QBDYW56JuEthXA5PogQBXWM8OEw=;
 b=NvMzbeCiQRVZ4+ZbPZadyHW84ZzrU0fjJ6OpiYoiFuBMflRcOID5Mn4DsOPjs+LCNlDpth5rQqw7b402atlXVnTAW2fHGiR6nytrYw1TgDGjwnxcPW6IyyEoYy1+l336GDD6TOufy6NEADxPeKuyRvy6htAVzhXjtQuGP53OVjqyCL/gvZ5dL2do2jqOTGk8jqZnfJKe9c+UnhJ9eKgjHkZq5dq3Dc8XoyKYG98OMH6H4vny/DLhLzU7XCnPBBXuUuHlgi2BSUvXwCC+cdnCrNKODqkdomhrs8tPmlyrI8/Fs9QE6NqjZC24IX0YIihIr+aPKSwjmrvP0dwozzoc3A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=o1rKHr4Bo+VL7cS8QBDYW56JuEthXA5PogQBXWM8OEw=;
 b=nOfac+kledNxEAHVhapc3I7HakddZarWKPIuHi1bbEJI3MV+0do4V2wwbg7m2hiNl6ttaDJpIpJ8pF7kE1mbOISdVmJBzBXxpGcRclqXuZfJZIlRUAehFJ5iMOSTxt+MtdRVEbYEo0uL6rrr38aYkhFf+4B8mS9o0dPYl02V2lU=
Received: from BN9PR12MB5257.namprd12.prod.outlook.com (2603:10b6:408:11e::16)
 by CH3PR12MB7545.namprd12.prod.outlook.com (2603:10b6:610:146::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.34; Tue, 30 Apr
 2024 14:43:40 +0000
Received: from BN9PR12MB5257.namprd12.prod.outlook.com
 ([fe80::c593:f43d:c798:e009]) by BN9PR12MB5257.namprd12.prod.outlook.com
 ([fe80::c593:f43d:c798:e009%3]) with mapi id 15.20.7544.023; Tue, 30 Apr 2024
 14:43:40 +0000
From: "Zhang, Hawking" <Hawking.Zhang@amd.com>
To: "Luo, Zhigang" <Zhigang.Luo@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
CC: "Saye, Sashank" <Sashank.Saye@amd.com>, "Chan, Hing Pong"
 <Jeffrey.Chan@amd.com>, "Lazar, Lijo" <Lijo.Lazar@amd.com>
Subject: RE: [PATCH] drm/amdgpu: update vf to pf message retry from 2 to 5
Thread-Topic: [PATCH] drm/amdgpu: update vf to pf message retry from 2 to 5
Thread-Index: AQHamwoCzcdcLf8l6US82kbPxcfIcLGA42nQ
Date: Tue, 30 Apr 2024 14:43:40 +0000
Message-ID: <BN9PR12MB5257A9AE94366485937E84BBFC1A2@BN9PR12MB5257.namprd12.prod.outlook.com>
References: <20240430142329.23407-1-Zhigang.Luo@amd.com>
In-Reply-To: <20240430142329.23407-1-Zhigang.Luo@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=cfb3c71c-d058-4c59-bf3c-2010b6be7388;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=0;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2024-04-30T14:43:20Z;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR12MB5257:EE_|CH3PR12MB7545:EE_
x-ms-office365-filtering-correlation-id: 35776c64-c95d-4d6f-b138-08dc6923ed6c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230031|1800799015|376005|366007|38070700009;
x-microsoft-antispam-message-info: =?us-ascii?Q?nYNbNVDeFOShfA3JQjt2z4qBqk6dsCvPC1Ny+12TEC9w3p0nNxZ8h0dVYBZZ?=
 =?us-ascii?Q?woEFHB/8GDZNySh90w6id8Ns3wdbaV65Uz7saESjqC6hcpkB4XzVNx1bR2DK?=
 =?us-ascii?Q?ovcF773TI0ctGmLCUXJfNVnNFmZXZR4IcjFsOH3zN7XAXbKHfDR4G2iC6enw?=
 =?us-ascii?Q?xg+QdW/5XkWZUpx2JTGPszWcHriEJaH5IKQCTFckoWRLh0EEJlZr2YkvWN9p?=
 =?us-ascii?Q?gn6UF+gDHDNX/o/5exJfOcxZbkeX4/0olN7Ql3LgX9LUVpHzvNVkRqEDBhvc?=
 =?us-ascii?Q?T5UFScXGpYTqvrsJz/JjkMeXEvDkxyH2kp730xF4Lh+1ZKUiyvXLBZlf+SUr?=
 =?us-ascii?Q?a+g0in8/QklbOR16JEcrOve5G6bPM51kPDDHlrtZsUFmQZBtJGlqJSw4+Kz4?=
 =?us-ascii?Q?TdpQ+9bc41Z8lf4CCJ9nZYX06p1KDCuc6IyfKoOto7Z2X2dsz/4/RENeLtVg?=
 =?us-ascii?Q?C8QFucMVb0ExI7x5EuL4IjX23uarjMsf6xpvAluS2XOl5zPjjPL+Y6EgciwS?=
 =?us-ascii?Q?wSeHSvA41Elm8fZHFiL/kQmHjGPmtPkPPLQB1ckUL41lQACUvvGVJnFYnowC?=
 =?us-ascii?Q?N1wauvSqdNqtDWDX71tOSaSXDQCWBH4Bvehdzk+45XKuZyw80xdzEb17enwm?=
 =?us-ascii?Q?X4KZGN+G5k6E2zUpNoA2T3s93KYWtMJe/viB9MhEafm5D6KfLiP/1KJgD5AV?=
 =?us-ascii?Q?ZwrrCYIVjnYGkxuIIHVZpj+/32OamL43JHKM0rlztlSzBEy6GO1XUCVSIYRE?=
 =?us-ascii?Q?eC/zlqrP9SIakSHa2q6cXSAhiiBHdjOKl85ulWYKuSsiEOwy9SomngSUaAFK?=
 =?us-ascii?Q?xSP19rOzFy9gSOyBubg95ZpvanoJ1vdnK76dlgOJWCkc3cpgEwC/b+NlOHW3?=
 =?us-ascii?Q?nl0PMVR82oVLwHc6ZIJ2tesqbr8gIiIK6U6l408cCbMQuMHs8r3J+/zCze+i?=
 =?us-ascii?Q?u+OkSiqCVaIE23FSpn8dlI0YQb3Vq84FTTZsbLxOtmyDoyRwA9Kxl9736I2U?=
 =?us-ascii?Q?0CIYPtO8zatxF4qGh0EeH8+0cnICdS8EfASy35qpKFd8Bjtp8baXO4EGBV9T?=
 =?us-ascii?Q?0lhDErAeWWUsImw97DVUollSAAvVdML0ORwhHkYlUj29eZ3xMZFLR0nHJ6IY?=
 =?us-ascii?Q?Strs13gb1D4Z8arPdfWBIZrv0OD3HGcdLkELBbCWlw9oPCA0SBPfhRfb5C2l?=
 =?us-ascii?Q?5jkNZeRYeWQpV9ghApwglDzqGvR5liZnI0Byx+7IfNn3rqsoHrnRPhF/Wdk6?=
 =?us-ascii?Q?IebFvKz9FnyEw7sJS+uXY+cIZBq+PxyROAjrixwAUVKTKgXUXR1AVek8FSkS?=
 =?us-ascii?Q?0B3kFEZD1ByoaSI6JG2sYlqO7sOiNZYA/AjIlERqUbPM9w=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5257.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(1800799015)(376005)(366007)(38070700009); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?TihGg6QzNwSG9mKtUMpAR/KUJTfNLx6opptFM5fHVTLoz08kO72D8zzVpAZO?=
 =?us-ascii?Q?SkRMc2sA/p3+ZzR9wuGxsR8Y/sYnCpHMISclFuAB6ejO6RkCTcL9O/i3zZda?=
 =?us-ascii?Q?oSITiIBEbD6NooqoC1eGt2Jfmk/kI/xdlVQoteozy3t8AL6eO/SFSVeCGssG?=
 =?us-ascii?Q?UGADZDaPqRfPyDNCmkXoNKTZSdQITTSfpL3ZgL9ahusX/G624KVNyT009x3y?=
 =?us-ascii?Q?VLbw6upoyQEhd4OI5IGbYKCBry08ec5qHOA1453M5wnWWiM0o7/0ptneX2jY?=
 =?us-ascii?Q?XkLHI+h6OZZj8aECLT9h7z2LKTfh8zxYir+ZiRcQdzjHVw2TILtknyUqnP0C?=
 =?us-ascii?Q?0wEMkm+lH4YV0bywsnUS/o3ZlHEeOhFnfGgp/WXahOgwkQ9gr9doPyMx9sQB?=
 =?us-ascii?Q?J/PZdBo8GjOijtxP2kjX/GXXTSzzYeezj50a47qivpoPzi26lebG0CUjrXy0?=
 =?us-ascii?Q?WTkgXBx+snLQ1eI/96WT/eOHWbzUu8RGtr9TCWooU6Uhqn3qu3jpdR8CjJVw?=
 =?us-ascii?Q?CZFeeYjAwc5iM4rXsDMZdXm8ylef+0/QJxe2JNiyXs2RDezgwndoKxjBrXD7?=
 =?us-ascii?Q?X52D2adsAjrI3bfyaEgUw1llyl/xXXOGOCy/bA4GI5TBwRSNlGxo2VI3YHmh?=
 =?us-ascii?Q?wft4nKxBknhzteLZC0nnBN0vZjb9KOCWe/wdpIFSPI/Lg4vmBeHViHfi2tBw?=
 =?us-ascii?Q?FrfM9WqF5EM16vb978wYJVc5QCVlpLNDXJmZfY2B6wLAnP4M9e7vFrdAa9cM?=
 =?us-ascii?Q?uGta+TJa1zjGFfvw6+SJEYWlr+qzM4vbN0ot67/tfZfvTIfsRy+Il26y/WA5?=
 =?us-ascii?Q?O+7Tn4X/tTzzTRT5yd7VVp/2pfa3Y7ipIXlNKuTHoP09KkshIvJ+ezqShBVc?=
 =?us-ascii?Q?kG5gF7VaGjqXHt8vdYk9kJJL2+FKWuO6LXzz3wog3odjwzWbAiXIyFbAa5Nt?=
 =?us-ascii?Q?gkxX4Rdv3yK09On7SczIuHFzv6Qxk+FbfRcQfCLlKC2uZxzKMha/V7RWNmIb?=
 =?us-ascii?Q?UBx3uO7r9aHcB8chQ63BQqAg4sXZsHhCZuq0VcNmt+xLK9aeP3ugkJTSgUhm?=
 =?us-ascii?Q?1QPMC1PLmWqc5yOzfzihYETb8sFFa/ZkXTDaK6l1RBT3CPj68+LVU1yUks6z?=
 =?us-ascii?Q?pCNhRj8wmq05mqya60JOqXdcECJW/8fXpifaKHjCUGo7mnySMNZFjKmJVA0T?=
 =?us-ascii?Q?Xsx3vdALkoIxFThLC1zf2iqjol387jQXjY8ZHuQAI2XQMFBVqEBJKFkeirUJ?=
 =?us-ascii?Q?bvXJWHWRSyvZ8vIuqc0YtMzMh8bE2g3F6AUIw7Eii5UcHwiuTu81StLYTjDg?=
 =?us-ascii?Q?83FgAgvql6qurd8zHW/ZcFhZ3XEuV56Krbgydqvddmb8xVeEWCHO1XN+nSBC?=
 =?us-ascii?Q?J1W9XsHYqKgqqiBup0F4YLfYi0eByEZoE04I9rdTo5yz89F7q8dOb6Sa1Hsz?=
 =?us-ascii?Q?6GuQgzVvPjwlDbZCTNs5gKlzL+bv8aORCGp8GFVPcNo7xerWj7EHRVsMw9pI?=
 =?us-ascii?Q?ZXtmTeLZ6jJHtm730msVPAJkH640SfV7fGXFl/3K1DT64OwG9drZdGalfGSl?=
 =?us-ascii?Q?pVW3f9E48kOgCBPLD4PsyUnQkqdqYDR4NODTQrnu?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5257.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 35776c64-c95d-4d6f-b138-08dc6923ed6c
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Apr 2024 14:43:40.7340 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ySILPW37d/Ar8kH5cQ+E47YWTjcvViT9SEBOwtWzuzrUWUSRbQfxDmNRRUpcuCw4OvCCdHX3kb2dZ8EYQMyOYg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB7545
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

[AMD Official Use Only - General]

Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>

Regards,
Hawking
-----Original Message-----
From: Luo, Zhigang <Zhigang.Luo@amd.com>
Sent: Tuesday, April 30, 2024 22:23
To: amd-gfx@lists.freedesktop.org
Cc: Zhang, Hawking <Hawking.Zhang@amd.com>; Saye, Sashank <Sashank.Saye@amd=
.com>; Chan, Hing Pong <Jeffrey.Chan@amd.com>; Lazar, Lijo <Lijo.Lazar@amd.=
com>; Luo, Zhigang <Zhigang.Luo@amd.com>
Subject: [PATCH] drm/amdgpu: update vf to pf message retry from 2 to 5

increase retry times to wait host has enough time to complete reset.

Signed-off-by: Zhigang Luo <Zhigang.Luo@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/mxgpu_nv.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/mxgpu_nv.c b/drivers/gpu/drm/amd/am=
dgpu/mxgpu_nv.c
index 89992c1c9a62..8b0ab075b728 100644
--- a/drivers/gpu/drm/amd/amdgpu/mxgpu_nv.c
+++ b/drivers/gpu/drm/amd/amdgpu/mxgpu_nv.c
@@ -181,7 +181,7 @@ static int xgpu_nv_send_access_requests_with_param(stru=
ct amdgpu_device *adev,
        if (event !=3D -1) {
                r =3D xgpu_nv_poll_msg(adev, event);
                if (r) {
-                       if (retry++ < 2)
+                       if (retry++ < 5)
                                goto send_request;

                        if (req !=3D IDH_REQ_GPU_INIT_DATA) {
--
2.25.1

