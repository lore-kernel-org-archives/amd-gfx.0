Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 91FEBC25B10
	for <amd-gfx@archiver.kernel.org>; Fri, 10 May 2024 06:27:48 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E302710E109;
	Fri, 10 May 2024 06:27:47 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="kDqPB/99";
	dkim-atps=neutral
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2045.outbound.protection.outlook.com [40.107.237.45])
 by gabe.freedesktop.org (Postfix) with ESMTPS id ABDDB10E109
 for <amd-gfx@lists.freedesktop.org>; Fri, 10 May 2024 06:27:46 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NkJzw6oZzuWFBfwrvmsNOkVHgyjsSYd/mQJUxoXkYOAH9KkyOCf5NQ18xVpyDCB7oMUKRJfVBfG/sik3I1LlW4yQWIEuwUwfnb+CEoetUZLgwMKUJ1DNUJGCIAj0XRxhx0X5p1Sd94wLNjCYGGR+mHT28krx4AcCpDZ/CSIg6PUdv5/xd3c/7guDYx1YrefsklViuEy/hDzZwwv2KE9n7WWuNLSnQvotlwNJbSQL2IsuyrnMyAnf9PEIrWj9CT5TUSshW3Ek+WFFdwhy+6mEeeh12DMIc9nD/FV0tFxFXABT59DK1pcjeJZjNbEvC5BPDWYOY8QT4+Tkmx+jkkdcLw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mAv06sJ70cGM5/1THocubI1KgJ38yqwX3bKU4hqmoEA=;
 b=dZQVZY/JTD9jVhSLiPsJwTPofyqo0ribz96Jpl9QExUiY3ufvEN6FupGFrk5jydhibgTXu9/n2YWa3g61KGsK5nR0L/i0o9gpH7J7X84onnexBJNoOgEetGnK0u48eGqtICevawB3VsR/uX2EXJiSS6Wz9n/JJBeHPtxgbW77JVLIdWVQca+wTP93Z1h6KvExRWvizE6eZxyw2T/xaFkTWYgXoSgR8r0e9Q1rdjd+sbAI7mykvKkNK/ZTGVG6696s+ZWrvAOfjXJUU6W9+VF+RmltklGLSjiHvbFb1Uh8Ebl8UigtWrhmFHiv/jvLi2Q35mxzvyLe18UJ62USSaXng==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mAv06sJ70cGM5/1THocubI1KgJ38yqwX3bKU4hqmoEA=;
 b=kDqPB/99pFv9B1Ku5miOeNAutIa95BByS867Rs2IzEPWDu9M7kMtQQdtliLCS5E/EDQ9innL4PL4a/RXel6JA6cQEYqT7N3BFRZ+tr0FzYQrt4HTliWZuTAHAElPTmzqMHJ0uukA/Dx3vShYVgutgB2f5iGtVY6baWS+5xcxhCs=
Received: from CH3PR12MB8074.namprd12.prod.outlook.com (2603:10b6:610:12b::9)
 by MW4PR12MB7309.namprd12.prod.outlook.com (2603:10b6:303:22f::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.48; Fri, 10 May
 2024 06:27:44 +0000
Received: from CH3PR12MB8074.namprd12.prod.outlook.com
 ([fe80::7f58:8648:262d:89e9]) by CH3PR12MB8074.namprd12.prod.outlook.com
 ([fe80::7f58:8648:262d:89e9%4]) with mapi id 15.20.7544.047; Fri, 10 May 2024
 06:27:43 +0000
From: "Huang, Tim" <Tim.Huang@amd.com>
To: "Zhang, Jesse(Jie)" <Jesse.Zhang@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
CC: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Koenig, Christian"
 <Christian.Koenig@amd.com>, "Zhang, Jesse(Jie)" <Jesse.Zhang@amd.com>,
 "Zhang, Jesse(Jie)" <Jesse.Zhang@amd.com>
Subject: RE: [PATCH 04/22] drm/amd: fix the warning unchecking return vaule
 for sdma_v7
Thread-Topic: [PATCH 04/22] drm/amd: fix the warning unchecking return vaule
 for sdma_v7
Thread-Index: AQHaooUUL8H1rN0k1k+Ltp1YdakIlLGP9VcQ
Date: Fri, 10 May 2024 06:27:43 +0000
Message-ID: <CH3PR12MB8074051BA5C26BF9EBE20357F6E72@CH3PR12MB8074.namprd12.prod.outlook.com>
References: <20240510025038.3488381-1-jesse.zhang@amd.com>
 <20240510025038.3488381-4-jesse.zhang@amd.com>
In-Reply-To: <20240510025038.3488381-4-jesse.zhang@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=6c7fcc74-962c-40c1-acb1-f0acc6437796;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=0;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2024-05-10T05:44:57Z;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH3PR12MB8074:EE_|MW4PR12MB7309:EE_
x-ms-office365-filtering-correlation-id: ad8b45b9-d3bc-4e43-c60c-08dc70ba4d10
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230031|376005|366007|1800799015|38070700009;
x-microsoft-antispam-message-info: =?iso-8859-1?Q?GFNsJBLdQvAQJ8m9TQoscaAwPMnyfVIJhgUGe074j9qkpTFdcTLwMzT/4Q?=
 =?iso-8859-1?Q?6/hWnDDl3iqaLu/ZUH9rCisrRJ+rQYnnyXHHN8h36t4yOm7+q5IvRXWwK/?=
 =?iso-8859-1?Q?E8RwuGOqIK1pYD4XUTYgb3gfW8a0qaWxeMjbGgMMQE28kpx3ypwNrZtBzN?=
 =?iso-8859-1?Q?nu2Djy++DlCcsIRuqmCU3ZLpPctfGGKeTkzshoeIqI12LsA16FTzNfQQfv?=
 =?iso-8859-1?Q?tmuRgiFL8GHh9gr/1pXIAJjIfmSRBvj+yWOsr4XVe2qxUPyZebSdDX6dLh?=
 =?iso-8859-1?Q?vd6/sTIszLQQVI+f/i42PbrDeXv+lyIOu4DPPV8wDe4X2bIztemcsFKZsO?=
 =?iso-8859-1?Q?cHt86AeAmlQjd3t5iVx05HzDj8bs1DriVwAMsw9o5vW9KMv0fU4Jwn+87x?=
 =?iso-8859-1?Q?eOeFp86N+OOwdTIHitEgh3a7hRbjrBkpBJKSitBc3rvpuAnjTf/0mX+4oF?=
 =?iso-8859-1?Q?kuugLtUM++vxUYFrejrrHCoigSrd6bSGgmsJNSG9Pop3EPOkAUaf48SBLZ?=
 =?iso-8859-1?Q?Xqd2ZmnJ4uabqZGX3cHDLmT9zIhHsZJAlIhe2f0vr70Iazaru8i/o/Wm/I?=
 =?iso-8859-1?Q?M1q2xR1OgjfHPfdv8iR3p7AgFoj/GnhLulU4lsPlJEXx4dr/xF8w1kqIjX?=
 =?iso-8859-1?Q?8EHBQZMARvKXL+2B1/7s1rVzPx9qZCLxChCxl9VosvGwdq1FsN5wOcbS8M?=
 =?iso-8859-1?Q?8EK2L2rrvUzwOsF+xT62KjbjLu/HLfc6PSS00Z7W4O5pWNBj25MsMysqlW?=
 =?iso-8859-1?Q?7aLTN27e47NF74RicIgNn8OV9eABzv0NEu5JmkSprpyH2oZq0nNDItxRcr?=
 =?iso-8859-1?Q?mB1O59nm1ugty6dlQOlGc9Z9Qh8MpneEP6aPyAr0xUKN5xMAeQDPzxPSCY?=
 =?iso-8859-1?Q?jEIi8gkBD46dMt6b40QZNaJtNyfALFXsnih7zbmOfMf2Rs8OVPoWSWRm0O?=
 =?iso-8859-1?Q?XnArFrptbfOi/X04DTzrxZrSzBQOxCOvrKfnX35+Xkm6TetoV9fdnLNMIW?=
 =?iso-8859-1?Q?h+9pNE7Gye5pfNeVva1Ef/6jK+Rp+9/FBdhCgGqBbW8WlPSPihcC+pLDyt?=
 =?iso-8859-1?Q?dJbFCc7PYXW8xdIbrYOk2GnzqWf2eoNE/5Luna9pL/ASaO50VT/8sjtjIp?=
 =?iso-8859-1?Q?r1VT4wPdv7rwzF07hTbxqPzsMe7Bx+rLqrQdKZUxJZkhNoh6cBrto0HYru?=
 =?iso-8859-1?Q?0HI+9RzqJgfRxJ/y9LgZeSB8188blpHsm2rI/YU8x0bS3tULIuTTfijQKe?=
 =?iso-8859-1?Q?T6SAFXTwP1LBhxWrS37bmyIkI7dKmk/C1LtvDrNa4xIhzCHL1XOSfoIzna?=
 =?iso-8859-1?Q?DRccrfyI+Yoh3hGvKYbgbAk/JBbe2fPXiXr2ybbY6XS4zw2lHsOtozS+7y?=
 =?iso-8859-1?Q?1fKiuQ9OnQcm/MU8j9G20OeDAKKuSsGg=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH3PR12MB8074.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(376005)(366007)(1800799015)(38070700009); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?j+qHjt0lWsgYx+Xg1pF9IjgZwRs/bnWM9OExbKEo6/uwrU9vLirRdXEH2Z?=
 =?iso-8859-1?Q?J+dnTCi5yR0mRKfxfR3YrMM+N4aGI2KakgiJpal47SWtSbx38KjjJxwpv5?=
 =?iso-8859-1?Q?cdGv1CCC9769Q7Q7NRKS7UNu22Et+zhmlNlCdN9RhzzTHLzUigYlsf4nL4?=
 =?iso-8859-1?Q?r935MfcY1c+oix39tXWxhpk3u9UK8/Z0K3F7qEDefLXW+E6VTYNL5s85rw?=
 =?iso-8859-1?Q?lrqZII2VZpt0qk9g4uwX6duYOLgoM5IDYhi0d4/2N32utgER+QD+pDu1Wi?=
 =?iso-8859-1?Q?+TGcoq8May10LarMfFa1OQsCiy+Olp6XJf0PDY/Vi4aIKQNrwfbg4AUj1g?=
 =?iso-8859-1?Q?ut+dzGn6v5rJ6ETcMNGoRBwNxWi4IkdUZStre/xjDW6SEYuZanJOHEDMyE?=
 =?iso-8859-1?Q?dbGDPrW+joY8WQ9pDRYAy3Q7eyaJK7hrCBpPH4DPjLPYxX3BdzW0pd0j1w?=
 =?iso-8859-1?Q?ieyvaLY6A6H+lMPTVbHfpUYoagxErLrtK2uH2G7xun1kosNGm8oQQntJVJ?=
 =?iso-8859-1?Q?JrOnfSp9N1kyTxMiqYSLPTxNeUeB1h6L945/05sPFDrjx1JydX9S2kVu62?=
 =?iso-8859-1?Q?v9f+UDttHfNI4yEmWB7oAYT2q4bG9MnpEgPzm2ChdbIqDZjS/qDpUxbubP?=
 =?iso-8859-1?Q?JA6eEubE/0El9SgEt/8bvY7M3A6pcsLCVFfHRemb6ZSIG3NuB0IcWe523m?=
 =?iso-8859-1?Q?UogdpwGcXuWtENQAlsMrN2JesgbnCVtuSzpZXKC6nHIZ1/O5o3xJtQ7JuS?=
 =?iso-8859-1?Q?bYZWF7jzk268qwKx1CFzZgNKO3a3U9B5NZjisEJrovjymXpgZCG/Bj/H6C?=
 =?iso-8859-1?Q?TzDZGURi9DALVw5Etmrd6j56NO9EbSrw5o2TkVmbOldh7Q/CtyeR/aqRSP?=
 =?iso-8859-1?Q?T/F/W7N+ewtbb23zdX0XHvwvt+GsFDvC9QQjD7RlK55UOtmYWDsVYVuPgR?=
 =?iso-8859-1?Q?5qRur2CudkxgB4UsOBkZWQct1jqGMn2/KLLP3C2TA7OwzZedZBdTPWw3aT?=
 =?iso-8859-1?Q?l3WyxrzZjXbIPTtHgdSsw1/Wy/tqCw+b9kkh3jtnAu61vW8MQI/4/YNn6+?=
 =?iso-8859-1?Q?h4QHIHP9mWplLiOPUztZY2J7qgHKkviqv6NYsK7OkZe5nVH5bNRExGoay0?=
 =?iso-8859-1?Q?Wy1951q3qG87TEsaT1P2G4nEyyTRQQPDWpzSeUY9M9tYCAnclNtv1kRfg8?=
 =?iso-8859-1?Q?zA2cN1a/5bpuUSYUt0VEsxZWBaGTXHcm99H3MHDBakE1dWHW+CPZKNZmgR?=
 =?iso-8859-1?Q?4Wioxw3GUW8xuAceCK4vsgQePslvfglSS34Lm1IQz1d1JVHdYPKXrzfcaR?=
 =?iso-8859-1?Q?PW8ZOhJ3JGUrtVbnJIad4IqX6BMJSvp8SE2w5ekMomGE9//5BAihh8LrMX?=
 =?iso-8859-1?Q?WhT0rc0KUUwjSjPehDd4AWD0jpnOFmqIvfn90mZ4q9yLfrWMV16k/ylSDp?=
 =?iso-8859-1?Q?zJ22ef9mlhxtNLlcbotXhQVGdGMLVFins9OxvgwcBh0nu2JhirgXMVA8zD?=
 =?iso-8859-1?Q?n2zQn7/KpYOxcGNCofiWrI2BX40tf+dHAMwQxBnIEjcO7WnDOVKYEf2upl?=
 =?iso-8859-1?Q?jQ/KxBHxwOQCdX54HRPNjW4mUbzuUVMsYMyEiMe1AzBJc1CDVmF6qjcqh+?=
 =?iso-8859-1?Q?iE+wG0VX0J6EM=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8074.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ad8b45b9-d3bc-4e43-c60c-08dc70ba4d10
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 May 2024 06:27:43.8912 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 7MmH9lsGiCgBeI5mU8c07YweU7bfWiOXjSv14AjlYDAQfgzxPRADYteOJYz+fvpTnmL5q7wh/2NnTiPoq5kaAw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB7309
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

This patch is,

Reviewed-by: Tim Huang <Tim.Huang@amd.com>



> -----Original Message-----
> From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Jesse
> Zhang
> Sent: Friday, May 10, 2024 10:50 AM
> To: amd-gfx@lists.freedesktop.org
> Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Koenig, Christian
> <Christian.Koenig@amd.com>; Huang, Tim <Tim.Huang@amd.com>; Zhang,
> Jesse(Jie) <Jesse.Zhang@amd.com>; Zhang, Jesse(Jie)
> <Jesse.Zhang@amd.com>
> Subject: [PATCH 04/22] drm/amd: fix the warning unchecking return vaule f=
or
> sdma_v7
>
> check ring allocate success before emit preempt ib
>
> Signed-off-by: Jesse Zhang <Jesse.Zhang@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/sdma_v7_0.c | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v7_0.c
> b/drivers/gpu/drm/amd/amdgpu/sdma_v7_0.c
> index 0b5af1c50461..7db53a96cff0 100644
> --- a/drivers/gpu/drm/amd/amdgpu/sdma_v7_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/sdma_v7_0.c
> @@ -1347,7 +1347,11 @@ static int sdma_v7_0_ring_preempt_ib(struct
> amdgpu_ring *ring)
>
>       /* emit the trailing fence */
>       ring->trail_seq +=3D 1;
> -     amdgpu_ring_alloc(ring, 10);
> +     r =3D amdgpu_ring_alloc(ring, 10);
> +     if (r) {
> +             DRM_ERROR("ring %d failed to be allocated \n", ring->idx);
> +             return r;
> +     }
>       sdma_v7_0_ring_emit_fence(ring, ring->trail_fence_gpu_addr,
>                                 ring->trail_seq, 0);
>       amdgpu_ring_commit(ring);
> --
> 2.25.1

