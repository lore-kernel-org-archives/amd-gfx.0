Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A1571C02198
	for <amd-gfx@archiver.kernel.org>; Fri, 14 Feb 2025 14:45:07 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 44C4210ECA8;
	Fri, 14 Feb 2025 14:45:07 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Leo1MW5l";
	dkim-atps=neutral
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2084.outbound.protection.outlook.com [40.107.220.84])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5FF4E10ECB0
 for <amd-gfx@lists.freedesktop.org>; Fri, 14 Feb 2025 14:45:05 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=A33Q3lZ5+U2ORFaEm3mzCSp/OaIeHYqMz0dOd4LiH6zqoUnFzDpM/zzJdwG9TR9c/lhdXQ69skSuj7mF2SM9DaGykZMobI+Efbm/QPypu10PAZ4OiYF2xHn2G3Zn8kvSCicaOX9/nWnXNUWdC5vayqaO64y2tb7Ckh/V+iVUC1DnWomSjS7SyC4G/vMQYh6eLo1Hfngq1ewhdpw1hFiIj5FyDbv1RTjKjH0p7kkZ8mywmumbGTLEOTRMpXRem9If3eA4yadZvEfCcJfUXZDlZTJnsbWO8dXTKtFKD5A11dwyi05JxLCO6x+pFQf0RmNVCPvFQlKaFMc/RLoF4wvrDA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=J00VVJvO4sVsi+30gssqjgB+PhRkF5W1FQVkEcueYIU=;
 b=DEIuD5apJVs7kxmZynWZZkPXjBK7sEc/Zw2aWXmSZN557+8rxKDtEG95slLcykdTaHXdINcAmlh7Qw7XN+vu16vLkOEKv9NqU2xppBTT+m4mAt3a2PSBJxS/W5bJWeRMaFkpT5/N/qQTrMKLBKX5lCktOZf6ZYdUS9UQPLGUGC+eV+dOehs9fgVcB6iPNZYEbam/VMXf/NDDJhljBRCHnQPtvnxGHMtQBhdPS5x+3fCMHPXNmilPCRoodQAW3ml51GinMIDjtuG+2GTZlVfL+FwYg+8MJt4mHMFKhO2/9Tkoyk7FtXoa5mdY4rtp00vKUZ6oOvp2fjh1IwHE+ZNUTg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=J00VVJvO4sVsi+30gssqjgB+PhRkF5W1FQVkEcueYIU=;
 b=Leo1MW5lD/EYjsyWxnk9h0jiRpoJ3Pzvzwbj0yG5M7bO5h47yn8T/1S89S/nNgGWTxVPCykC3eSG1Ty10ELohrL/e+h0sO8kC44xp3/G3mzzDJHEyRTlJfBImVQ/v3XXxdLDxfI9eFupsoCSPinhcoNRB4pQdVyICbjkNKkI984=
Received: from SJ1PR12MB6194.namprd12.prod.outlook.com (2603:10b6:a03:458::12)
 by MW4PR12MB7438.namprd12.prod.outlook.com (2603:10b6:303:219::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8445.13; Fri, 14 Feb
 2025 14:45:02 +0000
Received: from SJ1PR12MB6194.namprd12.prod.outlook.com
 ([fe80::df0b:3ee0:7884:c6a9]) by SJ1PR12MB6194.namprd12.prod.outlook.com
 ([fe80::df0b:3ee0:7884:c6a9%6]) with mapi id 15.20.8445.013; Fri, 14 Feb 2025
 14:45:02 +0000
From: "Dong, Ruijing" <Ruijing.Dong@amd.com>
To: "Rosca, David" <David.Rosca@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
CC: "Rosca, David" <David.Rosca@amd.com>
Subject: RE: [PATCH] drm/amdgpu/display: Allow DCC for video formats on GFX12
Thread-Topic: [PATCH] drm/amdgpu/display: Allow DCC for video formats on GFX12
Thread-Index: AQHbfjnoxOpt+n+PN02+v6SRMurFU7NG4WSA
Date: Fri, 14 Feb 2025 14:45:02 +0000
Message-ID: <SJ1PR12MB6194CB48C690414DD9CDE2E795FE2@SJ1PR12MB6194.namprd12.prod.outlook.com>
References: <20250213170639.30490-2-david.rosca@amd.com>
In-Reply-To: <20250213170639.30490-2-david.rosca@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ActionId=f151db24-fbe2-42ed-85ad-39df0e01d75b;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=0;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=true;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution Only;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2025-02-14T14:44:16Z;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Tag=10, 3, 0, 1;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ1PR12MB6194:EE_|MW4PR12MB7438:EE_
x-ms-office365-filtering-correlation-id: 1aa182c5-3721-4f21-f9cb-08dd4d0629b9
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|38070700018|7053199007; 
x-microsoft-antispam-message-info: =?us-ascii?Q?9EBX5LkdP4hf0db1am27EIge3gmLgr5IoNt7jy3gXoRTzQUOAE3cjwX++cN7?=
 =?us-ascii?Q?sTFF1n1H6hFrDP6O1od1LptcEgbiertuzhP56BrgRuqURj8N2M7QrW4Ofo73?=
 =?us-ascii?Q?fq/5dgVxaNOBA4vY8vkQEanhUqgHqKWV3BLXCYu5LR9OH55AcecOy9nHuMLb?=
 =?us-ascii?Q?3+wGXbDy5i2/Sli2DhulpKlwNGDsWsoA60ZurZfe7xYZ0SoiALb+AHUTGDQr?=
 =?us-ascii?Q?LFzi7XBtYTHPeRtf4k/5u8wDsZ9RdneeIschqYVidyOfLiVAIwY7Z9pEfH1f?=
 =?us-ascii?Q?hKcNLSwnOxhaD/1cVIz+QOpWe4FcuEsmq20q2eC46OdZG2vDcf2ImTAHBwbe?=
 =?us-ascii?Q?8urWlI92n5rwOjr1/0Dkd1JsJ3vcCzWjPihhDWK3HPdzUZ9in8h2qlUGG5r8?=
 =?us-ascii?Q?/uK+dGI7if6VdukxxXHQG9z9kh5dqPZ0zdb48b3+ec+sC0aR9u5O2RRlILLN?=
 =?us-ascii?Q?rROl16irSLVwz4qFMVEcAGGVvD93YB7q930G7ykyECCbHjejpevOa97lMIoZ?=
 =?us-ascii?Q?D2+wmSzRnBzLJLiwcWbCqS+jO3DRw0HmJZIL+6oQkX20t7cp2phml/gAZTHT?=
 =?us-ascii?Q?VYMJdszUSCSrBkH/K1/EiRnRJ2HGf5HZcXr2B2GcHpES24LaJlvNyu/ATj2+?=
 =?us-ascii?Q?W3nn2CFu1XzMKhWSJtOERDvuMclktShRrYIeVPDkW5PIhEqYvou1tVqKvqgq?=
 =?us-ascii?Q?cUiTw6DAlPAREawLSTO3Cij8MjqkqhvxChHoWOdSOLuzqjWimOF6Cbad64fg?=
 =?us-ascii?Q?oFzBgJvOFtD+px3wmu6RmYxluJCpIA5Pr+AoAHamEdUNogGIx8sx8EaGsfFh?=
 =?us-ascii?Q?BlBQPLqsQwmfyAN7WnYJsmLckMQetVR3HF7KZDvjiEd0IMgKe03bLRKPkDPg?=
 =?us-ascii?Q?BDnP4PdJZrLBbSllDtVQQPX5FJx/a0fLmqrnNI/9pQzRZHJEv68nkLiexke6?=
 =?us-ascii?Q?/BfVrkM/SHrKCkHjsC++jXgnKWfBy+SWqF8nYS4QplpyBG0/AEsI20CYtqPp?=
 =?us-ascii?Q?XJNjSqEgmY/YobM2qOVDmpa42Pvwa5YCRGli9hH86oUTskYs7cvEEtV0SlQJ?=
 =?us-ascii?Q?NiAt1hsMNVbh2fT5VRnMRpu4D4ua+3Gh4OIdvAHAfEn+f5mc7ifqy5YiQyRL?=
 =?us-ascii?Q?GgLclyWTHSEXOHibRusIkFGlF5Ve21+E92Alopm3H0Y61m3YJlE3WPl9G9rM?=
 =?us-ascii?Q?giKXeUxClCfE8uiIpKCOt3FIdfeYWMHoc0r+bmGUO954l8ZPZUuAZ1gPxijU?=
 =?us-ascii?Q?cxVHRRcapL8g8kkAe9uz7RXmcRKDFFT0fjRVnZY7y3aPmfdeOmz2ITRnnBOw?=
 =?us-ascii?Q?KZOuQFeDwalKOmvpXwE9wLEcOevDV4TYgawb0MEECFIJp6tyoVfm7Wo9Q7Ji?=
 =?us-ascii?Q?mCn99G+lPmpdk9Y3ho8nhuw1hrfwunWdKEU8TzmWhiwWqwH1ILeyT4zfyXpY?=
 =?us-ascii?Q?ZsnHHndFbdm2SWjSbFhQumFMLNR6F71F?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ1PR12MB6194.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(38070700018)(7053199007); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?zwH2BkGSTZa2nNlc7m9CAF9mlrYVh3yA76WS1WT/f1cRd17O7z2lNx9mLELj?=
 =?us-ascii?Q?jnDohItNCo4gnuuXHrcUZSWYrLslIb/V1g7ZGsf7kJPjvPEYezqulz+176c9?=
 =?us-ascii?Q?90WcCKi4r2Hbx/TgBCshg0FCJb5wS9xxkG2lPHd81X5ngrv3eERzboLRYWXx?=
 =?us-ascii?Q?pVFypAEoaFDgzJKNk59gvxEHTyXCH8r+P9o31GcuXEC0q3XQWy2GkKiLtnBG?=
 =?us-ascii?Q?1126qBgmPttlzXXeqz0IAHq597JU1KlQMIkwd+qcUt2RLeaZQYvyhsVA9IqG?=
 =?us-ascii?Q?8rcz/00Tt4y1MQ/s4P3Gd8SP9BaY25pHoPsrhbp8qRV5XgkIpX2n01d1ms3r?=
 =?us-ascii?Q?emf5Tq/4ZFnzTG9TSfRbIykZM94miQ3DemMjYu2x8TvemfMhslw4mSg2pZDx?=
 =?us-ascii?Q?Gi8z5sYeJYchRZPJTlmj6+vZnVtbvoExABMeJ/vE8b90G5sghX1mYerVN2XK?=
 =?us-ascii?Q?rHZUglTzoiFkbUcx0HN7hPsVRCckwRhHR0ShLez5neJjh8E7R79aAzPHEjy8?=
 =?us-ascii?Q?Xch5FZv2dYzsCoEPlcVFH1B4G8GrJU5/jIRn4dxGY5+KvWu0NVDyLm6vrssW?=
 =?us-ascii?Q?0YiPIo+B6RohxtT9ihzlecMbvhlZb3V8GTHWGAqYePqCFvJyluKi1VH7lt46?=
 =?us-ascii?Q?8fAA91VN1vjFE3lSCaI9xbbgBjWB0HLjyrgyYXCgrFAip2D5VyOSUR6+ri9c?=
 =?us-ascii?Q?Hiyt7cjJ2+i4LXlZ61QZZpKZxZR0UrW2GiEWsNOlV8yVt1YgqVqeBCo8Kdh6?=
 =?us-ascii?Q?gTeMuUrpzAf8Rp8u9GwndQ5gAsP7oCaYHSirGvGqBiN0TcPowjRGUdwgWgzh?=
 =?us-ascii?Q?+vlc8dn5bjwjSRrSKgPC/FqKbIy9+O+GiFEyxViJ4dFFXTcwIVM/7REnMorm?=
 =?us-ascii?Q?wmuPV4OCcHjzFvZ7WVbvQjt8jYuAaH00XWKkHKuKkkUXncPM338dkZx9brZh?=
 =?us-ascii?Q?neyOyKufIouvihIZONhISc3IE77R4A7ZexIaeNtW0NNJ4S3wSvi+lZRbVgCE?=
 =?us-ascii?Q?u9j6NcuqjP/vnUxyh4038zEnzFAwogohJ05zzx8DAHr8Ei0v1kVeTITkIFhg?=
 =?us-ascii?Q?IiGZqrGqP+gpwJKPRoN0Fn1BcRdl0ibyPcUcauf6B8WVWE4Vjy/D3JRtWa1M?=
 =?us-ascii?Q?LsOhDOoGoEuRKs7xorFwZSZlWkYIeBsfU1jW2cfI8UH289v1nEPmEQDY12P0?=
 =?us-ascii?Q?UFeR4JxDmM1dLZRT8GEDeMfndFaM4l5Fs+q1PYYLP1ucY7kB+/tSQAUwx/1K?=
 =?us-ascii?Q?cCL14H/QerGGWkEfKEQ1pJ/ab+K/MHJxha0Z5yS5lGUWsd3/GppBchYEsRss?=
 =?us-ascii?Q?JQEHsUDizoyh6WcDzvodhdF5XpFLeWjgHmXoRK0Ajs2/WCEsGI4Trorv68rb?=
 =?us-ascii?Q?BZS6pd2+K1thzdOgMgyNnHerYZGKUoKXozPlnwpEJsfiaV8Msk7FZzoMUnLu?=
 =?us-ascii?Q?4czdct5nusmQz+E2p1NEsu5QTOZVTyVUsRcZfsq45dbCgVUNwSjuwLON9zTF?=
 =?us-ascii?Q?v56C2q4M5Z3LAzJWYth8n6adlnRHD8XZW38VSnOSnO33cOmeX2mQfhF7bC9E?=
 =?us-ascii?Q?H6vKxz+90brzVkwbajY=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ1PR12MB6194.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1aa182c5-3721-4f21-f9cb-08dd4d0629b9
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Feb 2025 14:45:02.1491 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: GVztqv4zAWsKOhniszZ9tcc4ft3ufQ08k3Rt6BPLeByGyniLhbfuzutC+FGdi56a
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB7438
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

Reviewed-by: Ruijing Dong <ruijing.dong@amd.com>

-----Original Message-----
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of David Ro=
sca
Sent: Thursday, February 13, 2025 12:07 PM
To: amd-gfx@lists.freedesktop.org
Cc: Rosca, David <David.Rosca@amd.com>
Subject: [PATCH] drm/amdgpu/display: Allow DCC for video formats on GFX12

We advertise DCC as supported for NV12/P010 formats on GFX12, but it would =
fail on this check on commit.

Signed-off-by: David Rosca <david.rosca@amd.com>
---
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_plane.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_plane.c b/driv=
ers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_plane.c
index 774cc3f4f3fd..92472109f84a 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_plane.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_plane.c
@@ -277,8 +277,11 @@ static int amdgpu_dm_plane_validate_dcc(struct amdgpu_=
device *adev,
        if (!dcc->enable)
                return 0;

-       if (format >=3D SURFACE_PIXEL_FORMAT_VIDEO_BEGIN ||
-           !dc->cap_funcs.get_dcc_compression_cap)
+       if (adev->family < AMDGPU_FAMILY_GC_12_0_0 &&
+           format >=3D SURFACE_PIXEL_FORMAT_VIDEO_BEGIN)
+               return -EINVAL;
+
+       if (!dc->cap_funcs.get_dcc_compression_cap)
                return -EINVAL;

        input.format =3D format;
--
2.43.0

