Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 08523C4345F
	for <amd-gfx@archiver.kernel.org>; Wed, 24 Apr 2024 06:12:06 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7ED5B113819;
	Wed, 24 Apr 2024 06:12:06 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="D8pWGX+S";
	dkim-atps=neutral
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2048.outbound.protection.outlook.com [40.107.93.48])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1B19A113819
 for <amd-gfx@lists.freedesktop.org>; Wed, 24 Apr 2024 06:12:06 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OIVtd+dDs+L4dfYtafNtER+cURidYlOmxXq9/T7CU07gMmsPFoLRnyeNyzR/dKcDnKn/OPKCD/VGbXo5g5yBNReEaK7LfpS6lISYrmH/YiYn+QBeFW/XsZnS3EGWZoUvclW4dyXIXp+sXacfMUovWwYUO3ly57WpENNMXBmUuv38Ny9d3FE6Gs+MVYDm81PeJnhdU/20Q5U2AJaBKvlR235u3aeegalPIVUd4eDUNbSw8t35Qm/GWkLClegnSHoOvT9hI/FNszORHTrMs2Cfatw6KR3L0NfvsQE3CD4uvLf0ryFpUlBESgF1ngfSsZw/Tqq1CSv4oB+hE+AkuEvadw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SLTyv62m7tCfH84bZhn5SpXB5a5QsUZ/opHZFT2P6Kk=;
 b=RpoZp/rIG1dOVafCRjp/kCsl/xQiP1XXDwfOxvqod8oxi7gFK/EviYClXV0hKl27dLx9LvjW7Qgsxajr6/ztIvHsqPr2o4wrFwVJxM9hUT2GJZtz4z6NwPvCETaaI8xM22lpcjM5RUfWclkK/h6dLol6s61IH68fs7YmVeNSLsG/Pm0f7pvC00xq369JqL5F5I0cxsA6BVesXuDvvfoTz5O4hdMITMJD7oyHDjZ+GPTiYq/aqx8hJG7sFoXdWeDWGQVmvE5ntSdjHW3cR6UKuVCqg7mV5k0Uq5AqXU3Y30Z7X4cgU/o4SBjELGmiy1GHrakbHdVv5l2IXw1ahTXuXA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SLTyv62m7tCfH84bZhn5SpXB5a5QsUZ/opHZFT2P6Kk=;
 b=D8pWGX+ShrpwhfPlGpe3dUGeOeE8zkneOBDNUp6F81Wg57FfCs+xLscrzdKwMkpiLe/EsbUxlpYOrfCCQy9Yf1W/K5NN1xGuhOKz/E95qV3aXfdvilP8xs9dVA14mlGhlA56xzhCx5XAXuUFK1ksRN9XeGZ4oyISH5NNlxU4CEY=
Received: from PH7PR12MB5997.namprd12.prod.outlook.com (2603:10b6:510:1d9::21)
 by SJ0PR12MB6903.namprd12.prod.outlook.com (2603:10b6:a03:485::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.44; Wed, 24 Apr
 2024 06:12:04 +0000
Received: from PH7PR12MB5997.namprd12.prod.outlook.com
 ([fe80::d1a1:5993:ef75:9419]) by PH7PR12MB5997.namprd12.prod.outlook.com
 ([fe80::d1a1:5993:ef75:9419%6]) with mapi id 15.20.7472.044; Wed, 24 Apr 2024
 06:12:03 +0000
From: "Wang, Yang(Kevin)" <KevinYang.Wang@amd.com>
To: "Chai, Thomas" <YiPeng.Chai@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
CC: "Zhang, Hawking" <Hawking.Zhang@amd.com>, "Zhou1, Tao"
 <Tao.Zhou1@amd.com>, "Li, Candice" <Candice.Li@amd.com>, "Yang, Stanley"
 <Stanley.Yang@amd.com>
Subject: RE: [PATCH V2] drm/amdgpu: Fix ras mode2 reset failure in ras aca mode
Thread-Topic: [PATCH V2] drm/amdgpu: Fix ras mode2 reset failure in ras aca
 mode
Thread-Index: AQHalgulEmih4xyL5kGiJ1DLJvQrorF28HoQ
Date: Wed, 24 Apr 2024 06:12:03 +0000
Message-ID: <PH7PR12MB599755A281EDE8CF145F9E8F82102@PH7PR12MB5997.namprd12.prod.outlook.com>
References: <20240424055228.904041-1-YiPeng.Chai@amd.com>
In-Reply-To: <20240424055228.904041-1-YiPeng.Chai@amd.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=b84c9717-6e83-4b59-848b-d6d54c36090d;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=0;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2024-04-24T06:11:45Z;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR12MB5997:EE_|SJ0PR12MB6903:EE_
x-ms-office365-filtering-correlation-id: a4a34e98-7f4f-482b-6bc6-08dc6425762a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: =?us-ascii?Q?yrhVUdsuzs2fsoiG8XcFjOwJzs2NyWt/l0f9qBDvtbevqJhRx5CnsxMvZCI7?=
 =?us-ascii?Q?Tcz83e+xVyjYWyROUWnGWUJMOjQD6kBLrgr49G/y9SMiTO6lBCHdKosxVQuA?=
 =?us-ascii?Q?myVBDc+KS0yZb6QMhpMa08vYXP+DYJeuNoW+dnRmCfGea4KIToWfRLu68t8F?=
 =?us-ascii?Q?0yLfZk/RXmo6SQ3l0vrVyzDgFaSjnJ46ZsBHhoB/8hfH+JKyHaoTRJvYSjox?=
 =?us-ascii?Q?VylyqN6iZoY7A/c3POKJLjKcwGZhHTLwhbzrEwJER3nMZRrBvod/oQ+s5cly?=
 =?us-ascii?Q?vsJOLtAntupBd7D/Bsf5FLy4GzUbHOGaH3LhFnjnCZmK0rr04Rziq5bLi4gC?=
 =?us-ascii?Q?bt7gF+RtzdCAXSbS3H1h4nYaYdQz7ygbojAalVKSfaqyynUm0DeFW3ef3fJx?=
 =?us-ascii?Q?3qF/JgDK2+riZbrRfJinGA8ornXTEO4d1deCSUeuhxlN4eG988QXlPLBDdwB?=
 =?us-ascii?Q?jnRDzlaKmUrr3SREaVOXj4ifVbZw83sCw0CvGAcSwTFu5vCkEWi3D7VO5mXJ?=
 =?us-ascii?Q?Sqb/1azUfSea25JYM13Vcezol2ZUZkmiYAd04qKDSFXeI+KMaa/WwPUnK5su?=
 =?us-ascii?Q?2aCWg2tgQyg0tLL6a1z45QhiOXdCI+npuhaWBjURK8mKKQD76Hb7K/QRyZs/?=
 =?us-ascii?Q?JuRPqBWxFKWRNSN7/12P70C83SeSxyPdVEdsiW6M5Lib8JpwPBtxk5bEAIKc?=
 =?us-ascii?Q?bhtR/X7OE8DsA9jf40nORGvKJQVX1VHiIbrjuKRvafGLK3UCFPQXCPFzPwSM?=
 =?us-ascii?Q?y8Pygau9nQ3woCnsD5CPsO4ORQ8Pb2o1ZHFvhTcCejK8Bnv2H3h9nswEQrp3?=
 =?us-ascii?Q?unPyvrC9cW45TV/wwS++qnIQ0ZzN9wLnMFXgaO1TLyhrapnttAk905p6zGas?=
 =?us-ascii?Q?lu5bNxUaCOVMpBLrHoBlGaohRhUSph9m80HB3Qok9sLp+sXeZSoz1IRI/F3p?=
 =?us-ascii?Q?lSAV4py9RaPZqaqci6wE0U9n/x/QFSlTrkw74s4BszjUx1Obf4T8G2cDVSG0?=
 =?us-ascii?Q?zBh22CHyVw6ofwnoQgNbDZw6GJs+KH4UjEYKjGgiK4TImMrUoNXOw59q55Q3?=
 =?us-ascii?Q?vRGK+XEOUD6dzpV33jHwlcx+VfKRl5gm94S0t5H8VRnTZriSELuWa7iqN+NS?=
 =?us-ascii?Q?ZB4ivPYh6X7cmhPSXc9yZJIR8Ffi5scG9Y9PsrtBR+Mbl+HAycN2g1dJUW7w?=
 =?us-ascii?Q?5ES04RSF8iUC/zmgv52SNmqVxpcGKxmaSdo3MtqGnPd2H/6QCNpcHsItX2yv?=
 =?us-ascii?Q?t/zqWAsievWp0see8bQA7fo9gGsuV5/6aYGXTmy3jsYk1MmTU8ojz1TBYmKt?=
 =?us-ascii?Q?rxQzccOkgTgDpppNesdXiMXsOD6DFZNf1UR5OReB4y9i6A=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5997.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(366007)(376005)(1800799015)(38070700009); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?6DnJodff7KAjCXxbATXdgxACIvVXXRKtt3GzTbqTN+9AwkTrUTCr+muAqz9g?=
 =?us-ascii?Q?/6AfUjL7gD3ZGWHF3OK7Rw5xGkUxi6Rc2ZILGC5JYsp+mJrY5yJ70cROumaM?=
 =?us-ascii?Q?C1VxFdqGBwFQain+EmoMnd1aDl98iRKK8k9tqeTCZtEYoI61dpZFkrBSM8y6?=
 =?us-ascii?Q?e132UE5GQZCyePPTWGxLyL4Z1GTxLimahiQUzwmatxFVwuaBRGGdmOnf0cPx?=
 =?us-ascii?Q?EUiYjmJ3ShZPDZU9AqR2yZo6QJz+grdPOhM7gpua2TpYQTxjzJZaLGufzxyc?=
 =?us-ascii?Q?OqN4N0U90xip4C6K+wHXK0vEASZuI+j8nLJzG+Eh4lNedM3laegWx9MC8GK6?=
 =?us-ascii?Q?bZLyzuMMCngP9Wow1kMXPmh71SltH4HNoT3nQHHGpOmGNO4s79+Rcyau5ima?=
 =?us-ascii?Q?u1MGQyOeQaXFIbgz02J2AGfbNsS/u/ULBTOMxor2IU01M2BdFgcmF1s6Gn+X?=
 =?us-ascii?Q?aOiVkfzKFc4CV6LHmUt8Vm2P+erZBaUrFkwDpP1lR/gQulT5CPgC7uFEIIf3?=
 =?us-ascii?Q?rR/jzQ7lrjNbDroESTXg4Wdgu75W+NyZUceZqp87rjyJybtb3cKzoZJBDVf+?=
 =?us-ascii?Q?pm96hNByvNZH0gg285PtSmQ/ll+wzfdgmaoT9gK26aCCc8xIEAYy9zg4Zfxl?=
 =?us-ascii?Q?lJohPpj9OwgozmzXZ5mK/g5L3iO5SwWt1oqz+hEb24ZdHXHk7AMG+lsB9L3e?=
 =?us-ascii?Q?PuqsW/H37iZcLV3oKPs4eJtmdpNeZMkPjRHYUNfxT8mzwiqH6mIwMgXfxxAW?=
 =?us-ascii?Q?zP2SwxIPbyYdCSiR75pX0ODNvidQvJ1vHMMHgjfybDDZldBinWKlBZ7XS3FA?=
 =?us-ascii?Q?WFC5ZrtifDSRK2r2iHYhTl0AxTdhNCUnIqK8dZS+H8R9zegOsRKqtw7u6bby?=
 =?us-ascii?Q?LUAUOOOc3D5QJjrLj/KXCLqrVmibvDKKKl8NJtIBq5w72vUkCoZNGHPHW6M1?=
 =?us-ascii?Q?MYrNCmGgQIQ8pC6SnYPADXBz9L0E5zDy/kAYCiAAreUFruTdGTfHqwA6U1zt?=
 =?us-ascii?Q?iXvevv+h4PTAKLftxyqo6H056H6eHJysopTt5DBmEUTBBxCTXSnvh/lDMDFq?=
 =?us-ascii?Q?VElOBPtmWY5IsyBogf3MWGRpF68JM8UnQ5GJ1VZ1zmoB9jihghzMPUw6fR1a?=
 =?us-ascii?Q?OFoNck1yP2PhryqxBqD0DVWECxMH4ORFK2oZVU72l3hP/XOAeCpVXvW2Njy9?=
 =?us-ascii?Q?QGcjAKM2GuAvrFVN3mWW5NIPhlnEsk0r3LCr1ds7rmrKbpftx4JdimFQPZkD?=
 =?us-ascii?Q?Ppeh+whA19k2v4geTyteNMgig1U3njprH0fSCEyGiopkEkyCRw4H2SjSHQAG?=
 =?us-ascii?Q?OyzI4W91AhQHCIlo5whGdEFK5j4dYDMtAbkBIObyTGt6aX6w1zmIo4NF8R9X?=
 =?us-ascii?Q?RvHGizT/G+9LpPo3hWhBm7Vs4mPtrySbgARyEAIo6Smc3ms/gbuZQ/8viIq9?=
 =?us-ascii?Q?Qg/swSpfU2TvFObvkPWVBonCdr9POCzCL0uKzDb5jkpC5NUyyVBtlsTmzORU?=
 =?us-ascii?Q?/ewuDzI/BNzqdoXuUWQvGRUrWOdRj20om6ZKMPIdAy6SvE3Rclbkn/Lt/zem?=
 =?us-ascii?Q?Oslp6Pjk8BVwY1HWy3Y=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5997.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a4a34e98-7f4f-482b-6bc6-08dc6425762a
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Apr 2024 06:12:03.8187 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Y+nu4zp4c5dLEz7b/1Q3eU2ovKz/hYDoVZMHGb99xxFrfNwIlMPSlgFg1P+Y25Eg
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB6903
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

Reviewed-by: Yang Wang <kevinyang.wang@amd.com>

Best Regards,
Kevin

-----Original Message-----
From: Chai, Thomas <YiPeng.Chai@amd.com>
Sent: Wednesday, April 24, 2024 1:52 PM
To: amd-gfx@lists.freedesktop.org
Cc: Chai, Thomas <YiPeng.Chai@amd.com>; Zhang, Hawking <Hawking.Zhang@amd.c=
om>; Zhou1, Tao <Tao.Zhou1@amd.com>; Li, Candice <Candice.Li@amd.com>; Wang=
, Yang(Kevin) <KevinYang.Wang@amd.com>; Yang, Stanley <Stanley.Yang@amd.com=
>; Chai, Thomas <YiPeng.Chai@amd.com>
Subject: [PATCH V2] drm/amdgpu: Fix ras mode2 reset failure in ras aca mode

Fix ras mode2 reset failure in ras aca mode.

Signed-off-by: YiPeng Chai <YiPeng.Chai@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c b/drivers/gpu/drm/amd/=
amdgpu/amdgpu_ras.c
index edb3cd0cef96..11a70991152c 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
@@ -1254,6 +1254,10 @@ int amdgpu_ras_bind_aca(struct amdgpu_device *adev, =
enum amdgpu_ras_block blk,  {
        struct ras_manager *obj;

+       /* in resume phase, no need to create aca fs node */
+       if (adev->in_suspend || amdgpu_in_reset(adev))
+               return 0;
+
        obj =3D get_ras_manager(adev, blk);
        if (!obj)
                return -EINVAL;
--
2.34.1

