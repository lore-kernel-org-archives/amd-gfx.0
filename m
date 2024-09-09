Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 38689ECE57A
	for <amd-gfx@archiver.kernel.org>; Mon,  9 Sep 2024 12:52:52 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D99D010E500;
	Mon,  9 Sep 2024 12:52:51 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="VAJtswEW";
	dkim-atps=neutral
Received: from NAM04-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam04on2073.outbound.protection.outlook.com [40.107.101.73])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0E8F510E500
 for <amd-gfx@lists.freedesktop.org>; Mon,  9 Sep 2024 12:52:51 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=o/ykEBE8CNb8ruhcjvXQFo6JmfE9DB71i0igMEQ5HSK0Dhmo7yPIkXf2IsVbqJKO75TFnmbOlzqw0djD1AXKtkjBoSygMkqU3yqzXp5Ck25xf5JNMUmDv2pqC8wFKu0OiYS6mQR7BOUCTR2WqLiTwBOcn5q/fWeo+ZjT86mSDUo7AMV/urLFpsF5YpyvO382CNmYFI6zDIH9ThIwu6IOZKHb7G6NQ23xrGliiovCONkKCJyQNULrtkBeMDBdoWOX44jUMUCHo8z8ocHnBntFQxBKDz1amRGShzvlxcRGMYATl5iC3YmiUjJovYw8MfgCYo+MpUqMgqAUCFkX7r8+NQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=02lYp9U6Ba4AZW+yBK8G+OiSkAeRmFu24Sabf+gTUzE=;
 b=dpyKj9WZZXjgakHtd7MSF3gPdEfHdyyplD1SXRTDqr2BAZlYhDALw7Gvm2JqBD1uweaRdGUPQhmuSaxnqK1TUZ17H9D7IW3nJPF+QoWnkFJ+OI4W1I/zM6dO9iFtvyJYMeucr5iPv9Et1ZTNqgCeni9yWXiLxsaiQ3LpTpf9QYnEueyqm2/0cFeSCmoU4f1WpSwYWSI8dJSc0Un+G0e8LBz32NrjZgHoWtaaIQC7sUJECS7pxj7WOT8VKpJoQvzpXWKjoeiNeMWk7eVT4vw9eR6jSEKOELxnopTR0z8LX1SNrcNTY4hgwbtIlxq56idDqwl6syHpGbutBa1bhsb7vQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=02lYp9U6Ba4AZW+yBK8G+OiSkAeRmFu24Sabf+gTUzE=;
 b=VAJtswEW+cWJ+yqPHO7xxk52PMAEmRwvLGmiSp7kkWqku8xmNDpa8duhHGW3Gbpb1XHyse2pjQt8tegxwO0jWyACjsMbKfa0MCSpCFF2UXSgwo+03pQStGSUbYGOW2jpWWg7CSQZsxvUQxgwqEF0WENaVZuFnCU3LRTm+pa8HlM=
Received: from BN9PR12MB5257.namprd12.prod.outlook.com (2603:10b6:408:11e::16)
 by PH8PR12MB6820.namprd12.prod.outlook.com (2603:10b6:510:1cb::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7939.24; Mon, 9 Sep
 2024 12:52:48 +0000
Received: from BN9PR12MB5257.namprd12.prod.outlook.com
 ([fe80::c593:f43d:c798:e009]) by BN9PR12MB5257.namprd12.prod.outlook.com
 ([fe80::c593:f43d:c798:e009%4]) with mapi id 15.20.7918.024; Mon, 9 Sep 2024
 12:52:48 +0000
From: "Zhang, Hawking" <Hawking.Zhang@amd.com>
To: "Zhang, Hawking" <Hawking.Zhang@amd.com>, "Zhou1, Tao"
 <Tao.Zhou1@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
CC: "Zhou1, Tao" <Tao.Zhou1@amd.com>
Subject: RE: [PATCH] drm/amdgpu: disable RAS bad page feature for specific APU
Thread-Topic: [PATCH] drm/amdgpu: disable RAS bad page feature for specific APU
Thread-Index: AQHbAqgxtrH9ZU5wWUGsTb7vw+y7JLJPXCBwgAAMxcA=
Date: Mon, 9 Sep 2024 12:52:48 +0000
Message-ID: <BN9PR12MB5257A6921EC4A92DB2056810FC992@BN9PR12MB5257.namprd12.prod.outlook.com>
References: <20240909110508.19202-1-tao.zhou1@amd.com>
 <BN9PR12MB5257D7D20C08EE756F27D051FC992@BN9PR12MB5257.namprd12.prod.outlook.com>
In-Reply-To: <BN9PR12MB5257D7D20C08EE756F27D051FC992@BN9PR12MB5257.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ActionId=4e291243-7132-44b3-a40e-7aceeae231ca;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=0;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=true;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution Only;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2024-09-09T12:06:36Z;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR12MB5257:EE_|PH8PR12MB6820:EE_
x-ms-office365-filtering-correlation-id: 74d3eabe-0344-4130-4a6a-08dcd0ce4ea7
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|376014|1800799024|366016|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?zXVnSGyfP/V3Qouu1mi0+y3xfDM5MN1PkWYULT1pewkgwo06imcdrZ6b5WG/?=
 =?us-ascii?Q?84gDd6vLU+RlV6ZCMW79J1Q8h65EowWzmkM4HJwbldn+yLbZDA4Hs3ZyXwgT?=
 =?us-ascii?Q?fduQxBgrHKZbm47tAVSJX4NTx5VylZBLWt/HglXfycmvwjprvBRQBrj4FkvU?=
 =?us-ascii?Q?xBkoy84HGcAIacO2IyVNImPvXvy0eZqDfrGDaXaQtdATITxODS8h/hjQ38Qb?=
 =?us-ascii?Q?KtmXboBFKSjSCXueFPuQxzLBtr90eA4wy5UPoeDU+gJbztqkXoRj5EYT2FoJ?=
 =?us-ascii?Q?QAOrx8Un0RrmkW2kDhYPH7GAI8JlbeEpN3QayEEgiHX1EN9MMpUmne1I8w2T?=
 =?us-ascii?Q?ijX2R5uehYDFsNUTWUzVi8w4rQpHI8T7wUJb7WrlbpDQV/ewilUB0s8E6Z23?=
 =?us-ascii?Q?Ueiqf8iNHJYMW0+sBU8KvxOQ9rcjBF2QzqnQHl1haKTv9CwMNqNt7u+fYsCl?=
 =?us-ascii?Q?uAFyJKvJRyObLOcy6pOxXGie7oK+vluuLCRy2ck8nVgZdUQCKkv10b/2cQlx?=
 =?us-ascii?Q?47XOY/Gq0E2ihEPuKLdIHJHKxnzJy8TRJ3X3P+87VsM2Jo678nvzSm1OwaLI?=
 =?us-ascii?Q?J6nscMHbck1NP8z5rYAvZ9OAMtCT6+I8aEEA/9GOij1jMfcFwDnvD/vTUtmx?=
 =?us-ascii?Q?B6vpScgl7kzJJNPoKN5lf3aEAn8HixYd9o1ry7hzU5Lxkiv3D82B+miXeA5U?=
 =?us-ascii?Q?7gs+nvte1gmxYgKJ2pgqALkgKAxpiWhAu2RQ+axjseMZSGVuEC7PqOjFwut0?=
 =?us-ascii?Q?xdbJHUorrYmhaTTRwzoT7DBISdmYrtQ3APFu2vglOpGsulpgNKAADPKFSA2v?=
 =?us-ascii?Q?IheFjIi2UVIwsMFw08K/trILubxQ9PC7pl6D6k7r2+ynX454aqiVmMJ+NCwM?=
 =?us-ascii?Q?FHG9e1Xn39Zka/HrXpiQxDzQwPzVrXIbYHgJEzMUJfCO2gowmWlevavS3zYF?=
 =?us-ascii?Q?g7danFQfc6GC2Yizx1UoEf4CDOjtwFWCUnxk8N4XRm8bevSwsVNTCqLMOUQh?=
 =?us-ascii?Q?i4PhX8A20m8cV1cF1lQ62GBAR/bcFjyOGixshqHdeaBHPPsINwFKX6lp4DZr?=
 =?us-ascii?Q?HfO99QYsVRmvMlGbFfVVABpQTc3N0Rn5asLd7Z5DGsyGCPot3JM7xYSJe61U?=
 =?us-ascii?Q?RLMBWsGhyX+xpv2se8cDk3EyxvMS7TO+x9Gc4uJRv0SFGPi2wcMLdEzPLFyz?=
 =?us-ascii?Q?sotam4oJaloT73E93t6nBdDacn7XlyHI6T+S6GqKdBCnBVg2S7zyB9jQNxiY?=
 =?us-ascii?Q?GpK2NRBG1BwWKUoiV90OWZ1vQLSgFDS9vA4jKChN/EZwIuy9Xt8IBmTQT8lp?=
 =?us-ascii?Q?/k0KC6twTM2BmvHVT9EKAMaf7qcdCa1o2+vv+fJwkkurORZOOa/7EDKD4v9n?=
 =?us-ascii?Q?/bNUU+SUqcmZSKj+DH1EfqZQTO9HiAvMzwJorkSij+kY5Oz/hg=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5257.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(38070700018); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?erq4FGuCeeNhh0K4UVKZ+xFMZHr/zuRd1DSKGntnWiKsqggEjheUT5GgzxoH?=
 =?us-ascii?Q?/rmlhvC5Jt8bDoV728RNDavtsXnhqDTXAr8dUQLM91+4Tsvoe2Y09HIIZbQ5?=
 =?us-ascii?Q?5Iv9u2Md0R2m0rkjA74+qlnNah1ADURRLT1MDNKUX4tx9nFE8glQTWBihHlD?=
 =?us-ascii?Q?iMBET8fTK85iQq7SVRJi5wVkQ4DxEd7ZwXWzI3fUjM28jpJ/ygBRNz1nW0LJ?=
 =?us-ascii?Q?9iqiWW53Ei4Ic5thqhyipjFvXv22HzCaUAAAqr34LYKFnQxTjYQvZtTyfoRB?=
 =?us-ascii?Q?l7zW0AVT1c76TWjo9ZIsus+ItCXTAaU7VLGxahMNHWRa/g6IiM9Z4cdeSrdK?=
 =?us-ascii?Q?LoYWUZOwsa9iNumsY0a5U9iqKc7Hpp8S/vXZAk3w+MPcguk1YiDvYOsFkzZV?=
 =?us-ascii?Q?5HEwIZGT13TsiQRUNnnB1vlxDPHXxcDTQd6hn5J2IBnJ7DfeaM0cpmz3IUpk?=
 =?us-ascii?Q?vyxFgzgudjH6W9MvhvC/LyW9teXOBs64GfpsSWFBBD3yccU6O6iH3qVm7Dxv?=
 =?us-ascii?Q?4O6/9tI/H6iIXmDY7Vz9xUw4l9aJ0E0oJU/HIGu3zkQExFZR3KMYSJnAgxGK?=
 =?us-ascii?Q?764oYOHj5RIap5/2USo/XUhvqkk0TMni1NgF2ZLDBk7HStXd40iipVMb9zqm?=
 =?us-ascii?Q?qA3KUrfqcOJoLq/Sp6t7VeWeIaBfwou4W0mnM92/8dTD+2D21cWxRAMHEJJR?=
 =?us-ascii?Q?iKZcV+gB5+ue293SBAL9BsiWlAgPnDBYEQkhVS9WEsjTAbB00rlFntWIOeqA?=
 =?us-ascii?Q?yPgtVVjK7y8xK6hVM0EvriGZ5QqXqCbcbPBItYINUnFQEqDomqaHz5wrhZ0Q?=
 =?us-ascii?Q?1U3NhWeS2NN3+Krl/uFoWG2vJ3UZJUAtVvTSXONEP+Phz20Rvvn2y6ILzo/K?=
 =?us-ascii?Q?nVBgizcOMVyja7XVbaYhsjmpsLU70wri//38o8gv2ZznQx4JTQIKsAMRomU4?=
 =?us-ascii?Q?ScK8Qe4HmBGxflBLRhn0RDm4YAGeQxBaBvJyM/NMUE+HgHcyutaYtSEYs0Qk?=
 =?us-ascii?Q?1y3qthFR41YiFRtQgkdvRvz0xTYHOuG/gR4pB8bO7QyfBDGk3dZHVw+nEXxU?=
 =?us-ascii?Q?zI+DxOE+sDy7KU6sXYrXH9WB0SLat+ep0I0Tm2CqCB7SHeVQ/g1FskC+2kcQ?=
 =?us-ascii?Q?BoMnsETA8bFLdNGzlBYmiCNidmvjrYrDl3MRyrrC8guLSK93DVD4sLaR+0ba?=
 =?us-ascii?Q?TCQlC234dWofiFg38f75kyCoUOVA9Il8OsTfwkwY6AvpXe2+hDjveNsZRwnE?=
 =?us-ascii?Q?igukx+X2k6CYte2GHDGfasohafXWI8jCFBwJRbKVxB1WBYcPTry5cq08AaLL?=
 =?us-ascii?Q?XzgDa8REhevVb9O4lw5RuaG4FJG4kCHL7yzyU90BTYShHY+iLdciwBqgSbUx?=
 =?us-ascii?Q?BksWCDbbt21Csh4W23kodimo42yS7xpV+UDiG07RLPNHzHUw4sndXOQw5IoI?=
 =?us-ascii?Q?R7xjYvZNnX0wO+3Zdqx02b3Sawiuaj0Sk/HgsGwQUXf53RIayZdjJyKcFc0Z?=
 =?us-ascii?Q?d122Wblmsm+cXheeX15AUYLBDXDpJI+9wyabCxsacB/5HOh7mW5vthyOJ1s0?=
 =?us-ascii?Q?aJOLLIiOdcADTVGSWc7aJYqWi6mYKdlPJdUipicy?=
Content-Type: multipart/alternative;
 boundary="_000_BN9PR12MB5257A6921EC4A92DB2056810FC992BN9PR12MB5257namp_"
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5257.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 74d3eabe-0344-4130-4a6a-08dcd0ce4ea7
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Sep 2024 12:52:48.0774 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: xIf9FpJH5ZXGbhvizgcfvu+p0NrT7SPXClcYNFQwgIEyyGDydm8J13GLPmtzSC/woutrGAjR+aLL/ktSNKVm1A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB6820
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

--_000_BN9PR12MB5257A6921EC4A92DB2056810FC992BN9PR12MB5257namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

[AMD Official Use Only - AMD Internal Distribution Only]


Fixed typo in red

-----Original Message-----
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Zhang, H=
awking
Sent: Monday, September 9, 2024 20:22
To: Zhou1, Tao <Tao.Zhou1@amd.com>; amd-gfx@lists.freedesktop.org
Cc: Zhou1, Tao <Tao.Zhou1@amd.com>
Subject: RE: [PATCH] drm/amdgpu: disable RAS bad page feature for specific =
APU

[AMD Official Use Only - AMD Internal Distribution Only]

[AMD Official Use Only - AMD Internal Distribution Only]

connected_to_cpu is legacy design - I understand UMC IP version is also use=
d so it works. Checking is_app_apu flag is good enough at this stage.

It would be better to move the code change to amdgpu_ras_fs_init.

In addition, it's more accurate to say that bad_pae_thread is not applicabl=
e to specific app platform, or something like that. Bad bad page feature is=
 supported on the APU, but just GPU driver is not involved.

Regards,
Hawking

-----Original Message-----
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org<mailto:amd-gfx-bounces=
@lists.freedesktop.org>> On Behalf Of Tao Zhou
Sent: Monday, September 9, 2024 19:05
To: amd-gfx@lists.freedesktop.org<mailto:amd-gfx@lists.freedesktop.org>
Cc: Zhou1, Tao <Tao.Zhou1@amd.com<mailto:Tao.Zhou1@amd.com>>
Subject: [PATCH] drm/amdgpu: disable RAS bad page feature for specific APU

The feature is unsupported on specific APU.

Signed-off-by: Tao Zhou <tao.zhou1@amd.com<mailto:tao.zhou1@amd.com>>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c b/drivers/gpu/drm/amd/=
amdgpu/amdgpu_ras.c
index dbfc41ddc3c7..d46f216a33b1 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
@@ -3679,6 +3679,12 @@ int amdgpu_ras_init(struct amdgpu_device *adev)

        amdgpu_ras_init_reserved_vram_size(adev);

+       /* bad page feature is unspported on specific APU */
+       if ((adev->gmc.xgmi.connected_to_cpu ||
+           adev->gmc.is_app_apu) &&
+           amdgpu_ip_version(adev, UMC_HWIP, 0) =3D=3D IP_VERSION(12, 0, 0=
))
+               amdgpu_bad_page_threshold =3D 0;
+
        if (amdgpu_ras_fs_init(adev)) {
                r =3D -EINVAL;
                goto release_con;
--
2.34.1


--_000_BN9PR12MB5257A6921EC4A92DB2056810FC992BN9PR12MB5257namp_
Content-Type: text/html; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<html>
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Dus-ascii"=
>
<meta name=3D"Generator" content=3D"Microsoft Exchange Server">
<!-- converted from rtf -->
<style><!-- .EmailQuote { margin-left: 1pt; padding-left: 4pt; border-left:=
 #800000 2px solid; } --></style>
</head>
<body>
<font face=3D"Calibri" size=3D"2"><span style=3D"font-size:10pt;">
<div style=3D"padding-right:5pt;padding-left:5pt;"><font color=3D"blue">[AM=
D Official Use Only - AMD Internal Distribution Only]<br>

</font></div>
<div style=3D"margin-top:5pt;"><font face=3D"Times New Roman" size=3D"3"><s=
pan style=3D"font-size:12pt;"><br>

</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">Fixe=
d typo in <font color=3D"red">red</font></span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">&nbs=
p;</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">----=
-Original Message-----<br>

From: amd-gfx &lt;amd-gfx-bounces@lists.freedesktop.org&gt; On Behalf Of Zh=
ang, Hawking<br>

Sent: Monday, September 9, 2024 20:22<br>

To: Zhou1, Tao &lt;Tao.Zhou1@amd.com&gt;; amd-gfx@lists.freedesktop.org<br>

Cc: Zhou1, Tao &lt;Tao.Zhou1@amd.com&gt;<br>

Subject: RE: [PATCH] drm/amdgpu: disable RAS bad page feature for specific =
APU</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">&nbs=
p;</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">[AMD=
 Official Use Only - AMD Internal Distribution Only]</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">&nbs=
p;</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">[AMD=
 Official Use Only - AMD Internal Distribution Only]</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">&nbs=
p;</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">conn=
ected_to_<font color=3D"red">cpu</font> is legacy design - I understand UMC=
 IP version is also used so it works. Checking is_app_apu flag is good enou=
gh at this stage.</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">&nbs=
p;</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">It w=
ould be better to move the code change to amdgpu_ras_fs_init.</span></font>=
</div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">&nbs=
p;</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">In a=
ddition, it's more accurate to say that bad_pae_thread is not applicable to=
 specific app platform, or something like that. Bad bad page feature is sup=
ported on the APU, but just GPU driver
is not involved.</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">&nbs=
p;</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">Rega=
rds,</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">Hawk=
ing</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">&nbs=
p;</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">----=
-Original Message-----</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">From=
: amd-gfx &lt;<a href=3D"mailto:amd-gfx-bounces@lists.freedesktop.org">amd-=
gfx-bounces@lists.freedesktop.org</a>&gt; On Behalf Of Tao Zhou</span></fon=
t></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">Sent=
: Monday, September 9, 2024 19:05</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">To: =
<a href=3D"mailto:amd-gfx@lists.freedesktop.org">amd-gfx@lists.freedesktop.=
org</a></span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">Cc: =
Zhou1, Tao &lt;<a href=3D"mailto:Tao.Zhou1@amd.com">Tao.Zhou1@amd.com</a>&g=
t;</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">Subj=
ect: [PATCH] drm/amdgpu: disable RAS bad page feature for specific APU</spa=
n></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">&nbs=
p;</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">The =
feature is unsupported on specific APU.</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">&nbs=
p;</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">Sign=
ed-off-by: Tao Zhou &lt;<a href=3D"mailto:tao.zhou1@amd.com">tao.zhou1@amd.=
com</a>&gt;</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">---<=
/span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;"> dri=
vers/gpu/drm/amd/amdgpu/amdgpu_ras.c | 6 ++++++</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;"> 1 f=
ile changed, 6 insertions(+)</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">&nbs=
p;</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">diff=
 --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c b/drivers/gpu/drm/amd/amdg=
pu/amdgpu_ras.c</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">inde=
x dbfc41ddc3c7..d46f216a33b1 100644</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">--- =
a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+++ =
b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">@@ -=
3679,6 +3679,12 @@ int amdgpu_ras_init(struct amdgpu_device *adev)</span></=
font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">&nbs=
p;</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_ras_init_reserved_vram_size(a=
dev);</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">&nbs=
p;</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* bad page feature is unspported on spec=
ific APU */</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if ((adev-&gt;gmc.xgmi.connected_to_cpu |=
|</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; adev-&gt;gmc.is_a=
pp_apu) &amp;&amp;</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_ip_version=
(adev, UMC_HWIP, 0) =3D=3D IP_VERSION(12, 0, 0))</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp; amdgpu_bad_page_threshold =3D 0;</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+</s=
pan></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (amdgpu_ras_fs_init(adev)) {</spa=
n></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp; r =3D -EINVAL;</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp; goto release_con;</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">--</=
span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">2.34=
.1</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">&nbs=
p;</span></font></div>
</span></font>
</body>
</html>

--_000_BN9PR12MB5257A6921EC4A92DB2056810FC992BN9PR12MB5257namp_--
