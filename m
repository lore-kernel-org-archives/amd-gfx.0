Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C29B2C02198
	for <amd-gfx@archiver.kernel.org>; Sun, 16 Feb 2025 12:14:00 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1DBA410E2D4;
	Sun, 16 Feb 2025 12:14:00 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="WhW6Ekol";
	dkim-atps=neutral
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2062.outbound.protection.outlook.com [40.107.92.62])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C4F9B10E2D4
 for <amd-gfx@lists.freedesktop.org>; Sun, 16 Feb 2025 12:13:58 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MEbzgL39doQ8civBIMq6ICzGPSTb7Iq0uRGKvokwhI1WEEoYeuqyTQjK3i5bX7UNthGATkZ/EdmCOTcHruiDMRjx+4C2q1Nf2lTwCuht0TaCLjVori6R2pFlo7hpBlrdMtGpNzfaHq1JC3x4Ud4WvZj10wrphj89NqbhfqWcWPUCPlKa6jLUSps79GYod7dEXE6vMVUpLULNUUy19H8hAanEGGaNWtFeuC29YrNctJqYdOkqZlW8AsRhU68y/+CuJ44UWMpbL0v/X7qmSLcqM2+pScF6X4lrNV0N+wliTBO+cxMCAPOP7a/wyc7ELm1VCQIxP/KRiwBH2rtr1jhDcw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BjIrpdfYA7eqTReSHSJPYRlNoiTnV+PGuPdzbW5pTMo=;
 b=LR6ZxfX/SF10mlAx5ygbMpeDzDoSMTH2SKcoI9rMhVmSlsh9cv5u+kXOTayZ2L3444vm8bvNsWtmNhCAqUzo3xs22VolC1x/XeoUAhYVQzUl1wpvsza7p7e/cGTBu/2JhwPYaA5E7uGPlDbsmRkwHIO91qLkx2smRIhIDLhfvltR+jf2pW7zZiBZ2f1zxkXwpHkFwLWJ5VB73vBq8YudJtSRCnvmuOqTmc5ZJjGbnO9Kp7eeGZpqWaCNsFBFVQTqTmmxDgkm/ugFoKDjrvwbPicY7E94fdZzuFtTr+Q4WtRo/lWyqXhmbQfl5QphFkbhPpE4QZxKbRKh/QAdM8ryjA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BjIrpdfYA7eqTReSHSJPYRlNoiTnV+PGuPdzbW5pTMo=;
 b=WhW6Ekol/rkEstP7Wr/GAQqF/I1ZpOrFvhU2jqU2wiAH5ibKu+WPecqQ1NX3MK7DBDF/jo9sVIasjAD5mtOIyTByaTpZdIIexKjKnmbYLalZzYvatAOUIIw4BaNqKh66OVHv9pk9qNlC7v/0nE3a7mkXMvpYv0I3HDH8IbobwD8=
Received: from PH7PR12MB5997.namprd12.prod.outlook.com (2603:10b6:510:1d9::21)
 by DM6PR12MB4401.namprd12.prod.outlook.com (2603:10b6:5:2a9::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8445.19; Sun, 16 Feb
 2025 12:13:55 +0000
Received: from PH7PR12MB5997.namprd12.prod.outlook.com
 ([fe80::c5da:9b53:9d77:c708]) by PH7PR12MB5997.namprd12.prod.outlook.com
 ([fe80::c5da:9b53:9d77:c708%6]) with mapi id 15.20.8445.017; Sun, 16 Feb 2025
 12:13:55 +0000
From: "Wang, Yang(Kevin)" <KevinYang.Wang@amd.com>
To: "Feng, Kenneth" <Kenneth.Feng@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
CC: "Feng, Kenneth" <Kenneth.Feng@amd.com>
Subject: RE: [PATCH] drm/amd/pm: extend the gfxoff delay for compute workload
Thread-Topic: [PATCH] drm/amd/pm: extend the gfxoff delay for compute workload
Thread-Index: AQHbftHHG3HPgIkDWEa0+LHZ/LyoN7NJ2jkA
Date: Sun, 16 Feb 2025 12:13:55 +0000
Message-ID: <PH7PR12MB5997E2A3A7DEC42F6F5993DC82F82@PH7PR12MB5997.namprd12.prod.outlook.com>
References: <20250214111528.361280-1-kenneth.feng@amd.com>
In-Reply-To: <20250214111528.361280-1-kenneth.feng@amd.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ActionId=a840c346-5cce-4549-a18c-9115a9efd8d9;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=0;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=true;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution Only;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2025-02-16T12:11:39Z;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR12MB5997:EE_|DM6PR12MB4401:EE_
x-ms-office365-filtering-correlation-id: bb319b20-f54d-434a-b7d6-08dd4e83624b
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|376014|1800799024|38070700018|7053199007; 
x-microsoft-antispam-message-info: =?us-ascii?Q?6acso2iPzNcQ29VAyvlCi7BgVPl1kSWclGz0OkFB9vT+f5O5I5q8cIYMpqwH?=
 =?us-ascii?Q?qpCKnfT3IMY41aIacCu0UHJymGuBq1wsYLo0W2BmK2T5XUO3rWKFClrSJCud?=
 =?us-ascii?Q?+nTeFC/1EgQYM5f0XMYkghSTB8TmiBualgu+86csDoJVkfPfLpsnKSCUbSFA?=
 =?us-ascii?Q?eOwvyUoCiw/T0HqawJ+oTiYbGnCemljjQClOtwu9jLZICwtGTKHH1sLOEhLT?=
 =?us-ascii?Q?82GmLY/E5ogvI+Rz+blHO/JJ5i9v2bnQHGJDwvQzsv3FMiH13/Eo/piBsh0H?=
 =?us-ascii?Q?5IleeXF9s9y4jgMhSdVZhHxxbRbeOc6TOCsPt0wFhGWzEInA5UyakIVRSqLg?=
 =?us-ascii?Q?RjC8R5AgXATwusgYQJPHGj+jbyVHmyEK/HynpIO0kLc9+tB+AGllPPm3ZwV2?=
 =?us-ascii?Q?fiAtuWj2hh/oyVfTaowJeoyko4Q3reaZo7A7B2fVt87Ww46T+PV05MT6ES2+?=
 =?us-ascii?Q?fAjsA/uRt0h1cXvbUcu23PwkA0MIdb8QTRZcT0bvh1EvSKssiLxd19w1es1v?=
 =?us-ascii?Q?Hstb0qZmTF04Q4dChHCDyC6oQpeyAfygg0giC+5QmXEnKSZAbxrvHgyHQnNT?=
 =?us-ascii?Q?YXyaNsHtqNNBAt1HmPhprBZ9h+B5ZeCkS3D0HDGy8d9suQRLcJRgageMK614?=
 =?us-ascii?Q?8gy4cPuQErybOg2qmE6GVE0RTKZNGFuJgdGAVFeHtxQoRRpEA4P80OuVawyA?=
 =?us-ascii?Q?XsHXFb1kLezrgEJZX0Pt9O8JUoT+1XYRQPkltIwlvskW2AyyhjknNOWNrMeQ?=
 =?us-ascii?Q?1b3szQW3veal8C7papcEBZIbeWQ4X43+Zvk3TUULmRFrn/tZssgxXNXnLPl5?=
 =?us-ascii?Q?I2F9agRjr6FYo1IHSkb1uTJIAgin4V0rAx8xhGvfq6wP50yYXWezfYfbsuNE?=
 =?us-ascii?Q?QtMHxsDrCxypWKK2RiNLuV4pgeuF+B79Rzn9Hz6W1L3lLqDQiS74NPbD0M0E?=
 =?us-ascii?Q?MS6uiO1h8MuDblQK0tZnF2UcR1dtqitRN0hswqUOpgpB8xJWta/uofvUBn9H?=
 =?us-ascii?Q?f5f36eQOux8LJ7YJtmOYzXRwhwLDRbLHYgoIaJacEc5AtMWG/6D9Uy+6miev?=
 =?us-ascii?Q?SrklALVAUjb6zHENg65s/6lhqzWDo+IoyQyzlBd7n2wsmV6sWea98Orx0rwK?=
 =?us-ascii?Q?ZpBqh9UTunIiEtDSaBgWGnTU8mwfmGsnbdnCdr2+ybyGkDDSEdvxITx/20kR?=
 =?us-ascii?Q?+PoHm9IIZpFARdmdkM9AVG852Sb8MZkfUPdkA+Zbsvr4N1CWbm8EH3e1wuz9?=
 =?us-ascii?Q?nz55lcckt2F7iL3pPCg6Ak0ulziV9T8nmK4Q6StVqg2+Zh6eIeKNUWzuAVuI?=
 =?us-ascii?Q?T1WKq/LzBpKevVnpRDAKz+aar1BS9M4gITRY2kj87bcTqt4CufQRpMkHnADI?=
 =?us-ascii?Q?V2xn4aeP2DJTRhHZ0hQe78VKg1kCGwwYJ7gzFIcvuVka+E1kFV7cc6HmPZ23?=
 =?us-ascii?Q?+P8KmynL57p9f72FeIKQSs4iMmGPjsfM?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5997.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(38070700018)(7053199007); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?FJyrKBYMBt6T6eEvclpnuoughDAsuZXumHYysK5/XzEvE9Qvx+sriKO+zf30?=
 =?us-ascii?Q?+myn63jY1egiJV02wSHRjvZP+PHrDWHQy5GnQCdoQ0vIugz5Wce9uejepDf4?=
 =?us-ascii?Q?g9W5A7auK3y/upLK7WM92lTC53mVxjnU9u8pUKtigrQJwxTslp+xWmfUUDXr?=
 =?us-ascii?Q?RshUkGg8OjIM3Ws27F5mxSKeIj+vQ7crCd/IxEZoqd714r/bu3DeF7YzL6aQ?=
 =?us-ascii?Q?uaflMV7pBLigvx8+kt0RFZwYEiDv7+x48M+ycU++3ojRB7pJ4VPqgfbSv3AQ?=
 =?us-ascii?Q?btwuVZ9VuDrA+MEgC0ZDmu77hplpGupsXoTHmgopjbwiF0lDQnkHyIDnaNnG?=
 =?us-ascii?Q?CmjeOHp1ZnbvET7951ui/UyGqrJKrhJTmir7eABPZqaFxSQWVDQJdqhTQLh9?=
 =?us-ascii?Q?vVv1tAAZd03YmgC2m/pRIWUp3+mqNmOaRvSNfjpFuH4Lq68A349tRJnxT7lM?=
 =?us-ascii?Q?2GN2HJHRhSEGlqzJqR1RvDEZOJMoMeax41U8h60pekpnxEfcwFv+6wbUMjSU?=
 =?us-ascii?Q?qSh1ORLhRzvcCDrGoZ2L9J7mAXCmmqJWH+ex8i5C22dDKQGihIZJN33TgzVA?=
 =?us-ascii?Q?PgeOzgvzdyuEql4PcXtlcVc/7xD2Vi72RzWizzNC+JXKiyrdzLbtv9HN4LU3?=
 =?us-ascii?Q?JQvgeRm3dI+C6UU/KeShR8gTd2y68UOj320Oqbji74vd+EDyf4Y0F0wvbd+d?=
 =?us-ascii?Q?6hJ5aXUROlUJiMazXcY8A1M78QbvLvVhpAzAePEH9f0AeqL2m2k56+xkpTyz?=
 =?us-ascii?Q?gC0UXSwlftqDYV+mdcg+QvWAhnWryIYxpzPjfkIYIqIYLnuY3WPZZRobTGE1?=
 =?us-ascii?Q?rQgXZ0oyNdtn/l/tefQES8p9FSaPC76rhV/MaS9cEHOObNZIMcERwzj6c8si?=
 =?us-ascii?Q?VsMp66k0LorsaDqRJj2VEf4lsuGVAw6Ymo9u4Wc7geZ89seS6UkBXuZNdp8V?=
 =?us-ascii?Q?Qk4SvqcHAylB41fMfxDN+foLkSksAYTU4mefySTRRgUfOpaZrIbcv3J8OBvP?=
 =?us-ascii?Q?D+SOU5GLeaDFeoZIiPSixnl5IOAU9jBb02+ftgkCp0VqtKxOKfm0OnX5nhw9?=
 =?us-ascii?Q?u21m6AarNNIofGb/dW3/w8lrA3epKsQGRWGOQmYcgSvnhs3jye0scdQJnmNr?=
 =?us-ascii?Q?owK1NLfsRmhfWh06SooieZ9ocpljTmjWv/j7EgVo7RML7zyq26pxeDROq9k0?=
 =?us-ascii?Q?WnnFaJAwr4/fnCAn+OmNrGPiO0XplBxcpqVl93BLLV3QbsUUVmshHLXPdde/?=
 =?us-ascii?Q?ejRsyOsvFaSfZlfCYOlCVC5PLJVszNbF/QQjanIE/fA3cuvHMPuHHjuETD1v?=
 =?us-ascii?Q?9OLNuiQ8UfBsQqKdrodmi1dNx7Y0rAXC7jzxI/OSrjmJ+QTlCcWOCCgGQBUY?=
 =?us-ascii?Q?U3yjGcwcxLeS8oUW03v+6GEd0U9vuV7hnWVhvW3G4ZARHL3ep/njhWQAwu2n?=
 =?us-ascii?Q?ED+aq3ks1TC9AEm4s6J7hpGkta6qvqihDXNJptmZrN1YT0ZUGGUNSYHNxOAP?=
 =?us-ascii?Q?zR4fzXKABMuTWOmu6aTNFJi1AMaejLg6I4YJU6aXPGxgdOz4L1us9eCK9vsJ?=
 =?us-ascii?Q?DZOZ8zPJ4Jh+FlvoBsM=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5997.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bb319b20-f54d-434a-b7d6-08dd4e83624b
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Feb 2025 12:13:55.3211 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: iI8ER3SMqe6mOU8CoyAjLVLQn+YMywl4lZhAOEG4VvQhH+MJ7znYA6EX+HamenCh
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4401
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

-----Original Message-----
From: Kenneth Feng <kenneth.feng@amd.com>
Sent: Friday, February 14, 2025 19:15
To: amd-gfx@lists.freedesktop.org
Cc: Wang, Yang(Kevin) <KevinYang.Wang@amd.com>; Feng, Kenneth <Kenneth.Feng=
@amd.com>
Subject: [PATCH] drm/amd/pm: extend the gfxoff delay for compute workload

extend the gfxoff delay for compute workload on smu 14.0.2/3 to fix the kfd=
 test issue.

Signed-off-by: Kenneth Feng <kenneth.feng@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c       |  3 +++
 drivers/gpu/drm/amd/pm/amdgpu_dpm.c           | 14 ++++++++++++++
 drivers/gpu/drm/amd/pm/inc/amdgpu_dpm.h       |  1 +
 drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c     | 15 +++++++++++++++
 drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h |  2 ++
 5 files changed, 35 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c b/drivers/gpu/drm/amd/=
amdgpu/amdgpu_gfx.c
index b9bd6654f317..4ae6fde6c69c 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
@@ -776,6 +776,9 @@ static void amdgpu_gfx_do_off_ctrl(struct amdgpu_device=
 *adev, bool enable,  {
        unsigned long delay =3D GFX_OFF_DELAY_ENABLE;

+       if (amdgpu_dpm_need_extra_gfxoff_delay(adev))
+               delay *=3D 5;
+
        if (!(adev->pm.pp_feature & PP_GFXOFF_MASK))
                return;

[kevin]:

It's better to adjust the code position to avoid unnecessary condition chec=
k.

After that,
Reviewed-by: Yang Wang <kevinyang.wang@amd.com>

Best Regards,
Kevin

diff --git a/drivers/gpu/drm/amd/pm/amdgpu_dpm.c b/drivers/gpu/drm/amd/pm/a=
mdgpu_dpm.c
index 7a22aef6e59c..87de50b73a0e 100644
--- a/drivers/gpu/drm/amd/pm/amdgpu_dpm.c
+++ b/drivers/gpu/drm/amd/pm/amdgpu_dpm.c
@@ -873,6 +873,20 @@ int amdgpu_dpm_get_status_gfxoff(struct amdgpu_device =
*adev, uint32_t *value)
        return ret;
 }

+bool amdgpu_dpm_need_extra_gfxoff_delay(struct amdgpu_device *adev) {
+       struct smu_context *smu =3D adev->powerplay.pp_handle;
+       bool ret =3D false;
+
+       if (is_support_sw_smu(adev)) {
+               mutex_lock(&adev->pm.mutex);
+               ret =3D smu_need_extra_gfxoff_delay(smu);
+               mutex_unlock(&adev->pm.mutex);
+       }
+
+       return ret;
+}
+
 uint64_t amdgpu_dpm_get_thermal_throttling_counter(struct amdgpu_device *a=
dev)  {
        struct smu_context *smu =3D adev->powerplay.pp_handle; diff --git a=
/drivers/gpu/drm/amd/pm/inc/amdgpu_dpm.h b/drivers/gpu/drm/amd/pm/inc/amdgp=
u_dpm.h
index 1f5ac7e0230d..312ad348ce82 100644
--- a/drivers/gpu/drm/amd/pm/inc/amdgpu_dpm.h
+++ b/drivers/gpu/drm/amd/pm/inc/amdgpu_dpm.h
@@ -470,6 +470,7 @@ int amdgpu_dpm_get_residency_gfxoff(struct amdgpu_devic=
e *adev, u32 *value);  int amdgpu_dpm_set_residency_gfxoff(struct amdgpu_de=
vice *adev, bool value);  int amdgpu_dpm_get_entrycount_gfxoff(struct amdgp=
u_device *adev, u64 *value);  int amdgpu_dpm_get_status_gfxoff(struct amdgp=
u_device *adev, uint32_t *value);
+bool amdgpu_dpm_need_extra_gfxoff_delay(struct amdgpu_device *adev);
 uint64_t amdgpu_dpm_get_thermal_throttling_counter(struct amdgpu_device *a=
dev);  void amdgpu_dpm_gfx_state_change(struct amdgpu_device *adev,
                                 enum gfx_change_state state);
diff --git a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c b/drivers/gpu/drm/am=
d/pm/swsmu/amdgpu_smu.c
index a1164912f674..61cd170ec30a 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
@@ -133,6 +133,21 @@ int smu_get_status_gfxoff(struct smu_context *smu, uin=
t32_t *value)
        return 0;
 }

+bool smu_need_extra_gfxoff_delay(struct smu_context *smu) {
+       bool ret =3D false;
+
+       if (!smu->pm_enabled)
+               return false;
+
+       if (((amdgpu_ip_version(smu->adev, MP1_HWIP, 0) =3D=3D IP_VERSION(1=
4, 0, 2)) ||
+           (amdgpu_ip_version(smu->adev, MP1_HWIP, 0) =3D=3D IP_VERSION(14=
, 0, 3))) &&
+                smu->workload_mask & (1 << PP_SMC_POWER_PROFILE_COMPUTE))
+               return true;
+
+       return ret;
+}
+
 int smu_set_soft_freq_range(struct smu_context *smu,
                            enum smu_clk_type clk_type,
                            uint32_t min,
diff --git a/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h b/drivers/gpu/dr=
m/amd/pm/swsmu/inc/amdgpu_smu.h
index 3630593bce61..82f06c2a752d 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h
+++ b/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h
@@ -1626,6 +1626,8 @@ int smu_set_residency_gfxoff(struct smu_context *smu,=
 bool value);

 int smu_get_status_gfxoff(struct smu_context *smu, uint32_t *value);

+bool smu_need_extra_gfxoff_delay(struct smu_context *smu);
+
 int smu_handle_passthrough_sbr(struct smu_context *smu, bool enable);

 int smu_wait_for_event(struct smu_context *smu, enum smu_event_type event,
--
2.34.1

