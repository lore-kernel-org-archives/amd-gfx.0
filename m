Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C1D24ECE564
	for <amd-gfx@archiver.kernel.org>; Tue, 10 Sep 2024 08:40:26 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 610FA10E571;
	Tue, 10 Sep 2024 08:40:26 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="WD/uxtZx";
	dkim-atps=neutral
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2073.outbound.protection.outlook.com [40.107.223.73])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4A67510E571
 for <amd-gfx@lists.freedesktop.org>; Tue, 10 Sep 2024 08:40:24 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xli3H/e6U8wVcKXnUbiBNilsO8bxeTHb+D/kSXEG1KMJF8h6utkeqXR/zx6A699kVLO8EkTd0sXwk91PufA1FyPbOEiZWo5kxey8MyfsZfcNz0TT6DpSkjSsgYb3afr/93j8TkrJtnHgP6q9yj5HUB4KJbwodeOGMuUZuNvYvBzcy3qNo7ytulcWxbWtWTNFxNgt9G2NjtvSKuImINpB7ZJbdiMMH0IXSTaJxww9dfszdhWNZ/DCdRBfVSSMmJLb93/i7SL4C5+MWcU8btfJazZDnjMNfxFx6X9LKkGxMrB00VExsjS8ZrcktifOLgPLVFVKv9IN+FDaZ/UpuMzlFg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FF5bjnKvBzWY3/VOfzReYdHLfyl85rwiregnm1pRP0c=;
 b=jsE96sl5cw4NUiNNgjbqRg5Xw3aM8wuidNR1FRqEVuHEBX/xshrkIs2uLXQpW/2cBsSWW934P5d5Pjt6v8ZMJyFKr2e0/CdzYP+2Zi2kHWc7JqMH0JbeXRoEsCfG/grhGh5dQYn7p2YxXRxDYYG631vS/oQicrSrteb0j7Nt0M5ibRctvMDUUOGcW+Uxgo21HK7uuwimoWPtAexsCSoeZBPh1v194TwlFLcedSuGqPneGeo/lL00uiDVKm3zk81+D3JzCX+K8OZM+wMtvVd3NyRM7ABr0iNd/ATiBHylL3YAGD0IQi5n4UhGMzhBQAQbvlsaw5ybeRXannf31nyboA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FF5bjnKvBzWY3/VOfzReYdHLfyl85rwiregnm1pRP0c=;
 b=WD/uxtZxrw5rKV9qKiuN1PvLAzsUHlRE2S89jzOX8vg8mWeaF8dhW4PfoyaZad5v843cQBwC617LXabqYamUDGESPSjha6LGKXscJkXZxFCEvJqfBJX8azL4PGSfDcc93T9f68xaFKbTumhzmbJxcz8SntwfPMmr3ahCIfmiQxk=
Received: from BN9PR12MB5257.namprd12.prod.outlook.com (2603:10b6:408:11e::16)
 by MW3PR12MB4409.namprd12.prod.outlook.com (2603:10b6:303:2d::23)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7939.24; Tue, 10 Sep
 2024 08:40:19 +0000
Received: from BN9PR12MB5257.namprd12.prod.outlook.com
 ([fe80::c593:f43d:c798:e009]) by BN9PR12MB5257.namprd12.prod.outlook.com
 ([fe80::c593:f43d:c798:e009%4]) with mapi id 15.20.7939.022; Tue, 10 Sep 2024
 08:40:18 +0000
From: "Zhang, Hawking" <Hawking.Zhang@amd.com>
To: "Zhou1, Tao" <Tao.Zhou1@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amdgpu: disable GPU RAS bad page feature for specific
 ASIC
Thread-Topic: [PATCH] drm/amdgpu: disable GPU RAS bad page feature for
 specific ASIC
Thread-Index: AQHbA1y8HpABRIza9EOENl2rJw0QebJQszJQ
Date: Tue, 10 Sep 2024 08:40:18 +0000
Message-ID: <BN9PR12MB52579499065AC705C185E0FEFC9A2@BN9PR12MB5257.namprd12.prod.outlook.com>
References: <20240910083739.20813-1-tao.zhou1@amd.com>
In-Reply-To: <20240910083739.20813-1-tao.zhou1@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ActionId=7ec86d47-4aa4-453d-b7ae-312f8287fe6d;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=0;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=true;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution Only;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2024-09-10T08:39:33Z;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR12MB5257:EE_|MW3PR12MB4409:EE_
x-ms-office365-filtering-correlation-id: f6310dc6-8355-4c27-bb15-08dcd1743371
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|366016|376014|1800799024|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?Mdb9wJ0DTLuUN6Wt6zsBeqYOsWae8EWYGhKTc3vF47q9kYJPKXO37VbRFe8v?=
 =?us-ascii?Q?a/4Wn8h85d7wvuwKcIqNygSCdJn9FLzgjDx60EZQsizmOSBh8nv5ZzIheNDn?=
 =?us-ascii?Q?JmYSNfUCjkg/Hv4XrvJPUh1qMQQO1A4NZtJPVOyjeDyMpcZS5Rkg/7hfgcOt?=
 =?us-ascii?Q?2qADe4mMqa4phbwphbZB06PIhTGRYhYZ5ZH/IKgQ7FkKBH6xyQuv31OzyOAv?=
 =?us-ascii?Q?3hVtGwwATAypw4gXgvg5oe6QI7EcKd3EqYntxmu7G3MmnhrqOUsAUDy1DkmQ?=
 =?us-ascii?Q?Rv8mJxu3bpPhOFYlgGaI83laeiVy+TBkQM8ISeI9HyAPBRwsEfSzCpV12O1n?=
 =?us-ascii?Q?PADp0Oa1EXuhuL3J1feeFfq5HWT3j954Wy3KUUa/6W4Uy2RCHb3LfCM76RuY?=
 =?us-ascii?Q?MhNW1huYmYVN1a4X5n6yPhVG7G3wQPSVR73r/CzBtINwmK348Y6chKOtoGpt?=
 =?us-ascii?Q?9c9NakWrpInbFIsF53ssoYSTp5+8OvPVAv4Rwfl13pt3LSPRUH7tXB6jcC0j?=
 =?us-ascii?Q?DhgbasiEf/68P6iwH28n57oeWO/oF1WmtbZ05mACH90y8JCWEXxgLJXCjgyo?=
 =?us-ascii?Q?wc3Anl8EnIScPF4HyS5+hMtKcHTAF6+q49rh/4K1XAE4cApeuzDSgFQP0R1r?=
 =?us-ascii?Q?I1lBriSn4ovlr5nWvYkGzjodofZ+EMdkLFghqrRYJBcUgQUECM9SqZfmxYp4?=
 =?us-ascii?Q?ixUIi+mv//S4THxym0HJLy0t0WxaUxowWQ/LyXvmWYCaw9xHaHveTHHFn5Jo?=
 =?us-ascii?Q?qhk/JNe7mBS+iCvbm2nj319Vf616pTjR6awE45v3XrWNAMnd3aASZNPKjsui?=
 =?us-ascii?Q?HSp441E99aDd/NOytKATRQg5Uk4Wydp9fyy9RlamyO+K1Kb8OIW46pWJw6Xi?=
 =?us-ascii?Q?VK6sOM/mNH94sMx+14wFvxNLdJk7DqB6lJ2dM2Z3HuxcXwdgclF3nAYsyOL5?=
 =?us-ascii?Q?iB7RWZsz/F7vehmCkBazhKiBKrkIN09egHbrAxc23xIn1aiu6m8YhJ7pqrJG?=
 =?us-ascii?Q?gFa4TZtJ85j2ZPMpjoBQ+IXVlG7CUzr+VddGNNJWgMitE7UJR7kvthrTBMFj?=
 =?us-ascii?Q?KrRdSkWdPrBVsXS7WA3HexU4NBMapwl5RdaKapDWMukW+W3JnyiXtFuhUhFl?=
 =?us-ascii?Q?FLU6FAD7G/78noToEFSEVsdDOknETvSTwVTO8sZ+vJ1uUnhTs/9o/FOEQiAX?=
 =?us-ascii?Q?QForOrTWLj6+g3ci/bs/VgnxuzsOpsh8gu6gLy+5Uc1JZQe7Kw6Ozs0yKj/7?=
 =?us-ascii?Q?hgqgoc+j2ijXxT8jxknPN47pkLYPN1OZHwIzaSvTt2FRUFuwZ7nH4t/Dzemi?=
 =?us-ascii?Q?VDjg2sRUEgn88J8Sgnrclt63rDEyestmBqORrD71EGaQuSvysEWtz7uHqB4E?=
 =?us-ascii?Q?ASRjf47G93VveXv7kiBlLmExVd6TP89T6rKRsXshF+7YAwPR8A=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5257.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(38070700018); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?llSEHJaVL+Fle2pMjwwDh/S+st26ThPyimPN9aNMwoyYiVPGDIJvG7vu4vNR?=
 =?us-ascii?Q?bZbpuMY6bTtc3panvUWgPX9dFq6y08JXAVX5kK3BSQM3ddZEsEpCVLDHZADo?=
 =?us-ascii?Q?gQXZSZKKvfwMPRYLnM7vLYMJiKgM6Z38brXAyZ2IVdoiW6dkz6k43yw9H1s4?=
 =?us-ascii?Q?LdPA1gYXiyr6Ia7+dfAXUXOiFCTHKE2WFAttb/htuKH9v7ou15EIcT7zSO52?=
 =?us-ascii?Q?ZI8XQYqzh9n2Ni7remc5WqdksNh5r6Jio/F4C65hmesgZ3W6zrwWJQ/hSuDu?=
 =?us-ascii?Q?R81A5diA2olScqY66XJ3cfnIPo7aea/Vu90chRsDinv8O/aETVFdYgja8fp2?=
 =?us-ascii?Q?ntZ00HW3cUDlTnTS7YJ+ja0ANiy2x3RViBzt+eWBtSuP4igB568lvQXf3aRi?=
 =?us-ascii?Q?ubb6HNarg3xH1lbDH/TMGZMI/kPjv4XowsMR/wd5phrgW2Y44zdG4/fCpsuc?=
 =?us-ascii?Q?zMcDh+nkcIjtCw0ykZFjFu80vgaDphyepAt6VPeLMftvdVW2YObJQGQfRx59?=
 =?us-ascii?Q?LmUaLhzKjZGchV2WYGb/J0F1QPeAqtFG4B+XoCLeTy3bO46ltUyDNrm2aTm6?=
 =?us-ascii?Q?fHwir0STGHdrHQvN0U8bpF3HALauH4Oph0Z2vN4+hjPhoDmL5VsvlzYsm3gE?=
 =?us-ascii?Q?5eXV0QQoAVrKhogNeDUqcvFA82pq6iy/xPsBCF+ddwZGh07+v/v+/JZbCQam?=
 =?us-ascii?Q?8lA2/VcuUfEe6o/5LsT2dZY2mRVzeQX6yPakM8L3iUafK7zMpliF+6Ha1nF3?=
 =?us-ascii?Q?WKGQhQGMi2SsP+RdksFYJv6Hszv485HrnMC0RMIDefjg8IyNd36Yq4LbSKAp?=
 =?us-ascii?Q?zmAwvtXBeliWMWISQ3ghdkEHnATA5PajiysaM51aZFxTQqPA2qEEJENTIkVH?=
 =?us-ascii?Q?p0OCE50uhRc9psb1ag4Jy9y+DuaDqPoYzovjQ6+Fq6AaO/jaB/iWotYNFel7?=
 =?us-ascii?Q?cL+PnqPf/pINPDh2iyEpfwyC6OtfPD8VRQWI13xC9Kvhau/PaaoKcfl0goMx?=
 =?us-ascii?Q?xcMrgqlv/f3U33abapBbzQrcwIVldMndtPrw1/treLhHCFpVeanLOnAsBK7c?=
 =?us-ascii?Q?lpKpTNTeVFtReOjvykyOzztmIta8GifD6TUIrnS/MudRrNYCuteav3VXr6Tw?=
 =?us-ascii?Q?5r3WO+NMLNDGbC+zIFqLs13iMsbB8YPg0K8/leTHI5Qx/IW/DCK99cJvSmbd?=
 =?us-ascii?Q?RVTE6CczbMDOm2BVTsdIQ0mVhk5QV5GAzmQTdW/JJjCq4lS3/rEBuAg6meZ9?=
 =?us-ascii?Q?n6p6qRllUQawWiSAT0/7e6YkV2B+EfjXqijDHualySq/MRcR4fpDV923EoFo?=
 =?us-ascii?Q?cBNy29cvvf8vDd54llYRZ/Cgo9+CxyCYLULx0+748t8V8THI+Vt11EGkxmn0?=
 =?us-ascii?Q?gow5HXg2jUOBWWWHxYSz+9MhX0ZrtmIsTKRPYFi9ty0VUXpPAMSfpCWITxc/?=
 =?us-ascii?Q?UYf20m8b7MlSM4pZ6vGRcbUhQuUoyYiLZ/1vYUBGOOehaYEJzAE2sblgKSuf?=
 =?us-ascii?Q?Z/4bPUCobZajn+iuq+lJfkVK4sGzXL7pRhLY99SKqszrc5xpgWlKjuTQlMKv?=
 =?us-ascii?Q?tDxTc9KlpiJ/mZTRLlhC1sr/d6neGOEZlnLyIejL?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5257.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f6310dc6-8355-4c27-bb15-08dcd1743371
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Sep 2024 08:40:18.9161 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: mVPyP0p06Cz3ijd42kBcskTxdHHEP4IlSsBphpHGWK1K9CNE7rYgk/koxDuPXaJ+BNDddbYlmpf/t34I/DpU8w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR12MB4409
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
From: Zhou1, Tao <Tao.Zhou1@amd.com>
Sent: Tuesday, September 10, 2024 16:38
To: amd-gfx@lists.freedesktop.org
Cc: Zhou1, Tao <Tao.Zhou1@amd.com>; Zhang, Hawking <Hawking.Zhang@amd.com>
Subject: [PATCH] drm/amdgpu: disable GPU RAS bad page feature for specific =
ASIC

The feature is not applicable to specific app platform.

v2: update the disablement condition and commit description
v3: move the setting to amdgpu_ras_check_supported

Signed-off-by: Tao Zhou <tao.zhou1@amd.com>
Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c b/drivers/gpu/drm/amd/=
amdgpu/amdgpu_ras.c
index dbfc41ddc3c7..ebe3e8f01fe2 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
@@ -3483,6 +3483,11 @@ static void amdgpu_ras_check_supported(struct amdgpu=
_device *adev)

        /* aca is disabled by default */
        adev->aca.is_enabled =3D false;
+
+       /* bad page feature is not applicable to specific app platform */
+       if (adev->gmc.is_app_apu &&
+           amdgpu_ip_version(adev, UMC_HWIP, 0) =3D=3D IP_VERSION(12, 0, 0=
))
+               amdgpu_bad_page_threshold =3D 0;
 }

 static void amdgpu_ras_counte_dw(struct work_struct *work)
--
2.34.1

