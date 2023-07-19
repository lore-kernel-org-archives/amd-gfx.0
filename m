Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E5314C0015E
	for <amd-gfx@archiver.kernel.org>; Wed, 19 Jul 2023 16:30:55 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 45B2310E0F9;
	Wed, 19 Jul 2023 16:30:55 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2041.outbound.protection.outlook.com [40.107.236.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CB96210E0E8
 for <amd-gfx@lists.freedesktop.org>; Wed, 19 Jul 2023 16:30:52 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bmiEdsplvzc16w+kojmBt2pMmhIiapwEWW0JTsPo2ohpo3paRmyLeDiA2u2JcFTz+XIuElV36LiT1urfxpTZaW1oQM9YjHEhnDAxryfiPKPGGJ5lCGgrWrDUHe+yrIFCshVqwVafXGW0bwb2X3JKAnBGOnOkIcfZIQ2CGHOQ6nhb6E+quEVJKNIntvAbN4aX/3LxDKD5y/zGHRxlxRBs7G5WSKRVjpoezwgbdfSc/ExlN5bOWID8FMEduZ6Ax0pMR/WioVZdidOciq2rY8YN8dBBgI4dknU8KqPi4xBWfYHyC8qMRLxlNbVJovUtadlSxFtz8wY+nTbivJ8/730/yQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+63E3ifL63yq2yoeFPwT3SwWCYjKSlJqxO8MR0KHRrA=;
 b=X9j2yjJUzvMGL1gFHSzeulLHcrplNhwMguOmLX0KSBjD4D46zbc98VMvKVAlN+B/DxJsF/vgXMwFyoa+Czt5QTBXK5L/jlnOl5soPgJXTOxQagD9/cFzbIpH3X0UORWnnQAsLJx78lv2z+kDXqdKEUzAGg8NQyNvKvMuAa1jnZRGLeAe97q5FQTToe3YPdMP4UcCFYb3S8f0WCzS5vYadOlYi1xVmlCBd+314uttaPY7EuKN5EZ75s1nnPpey9TRKGDZg8W0oNuYxE3A964Eq0TUOxpbuabFIPcpSEwKw3oY+WkGkQZS1nZ5Vf8V0qMJ/g3eOv6ofZnCGKZ9VVdcew==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+63E3ifL63yq2yoeFPwT3SwWCYjKSlJqxO8MR0KHRrA=;
 b=k3q7YNlcwi+oK9m4Yed2CfU4yehBuITObgg6HT+7Ra9E2Dyay5Tc6uo7IdNqr7BDuUqGZfZL3ErHrMM7GefQ3RMNNmIJ/xA4EzEOz5HHiqG1U3E7dNNjUaIcDctq0lJJZITacrxnPNKvngi9Qr0D5tZr29qCb19ro2Ipui47kIs=
Received: from BL1PR12MB5144.namprd12.prod.outlook.com (2603:10b6:208:316::6)
 by SJ2PR12MB8884.namprd12.prod.outlook.com (2603:10b6:a03:547::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6565.24; Wed, 19 Jul
 2023 16:30:49 +0000
Received: from BL1PR12MB5144.namprd12.prod.outlook.com
 ([fe80::bcfa:7757:68bd:f905]) by BL1PR12MB5144.namprd12.prod.outlook.com
 ([fe80::bcfa:7757:68bd:f905%5]) with mapi id 15.20.6588.031; Wed, 19 Jul 2023
 16:30:49 +0000
From: "Deucher, Alexander" <Alexander.Deucher@amd.com>
To: "Lu, Victor Cheng Chi (Victor)" <VictorChengChi.Lu@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Subject: Re: [PATCH v2] drm/amdgpu: Fix infinite loop in
 gfxhub_v1_2_xcc_gart_enable (v2)
Thread-Topic: [PATCH v2] drm/amdgpu: Fix infinite loop in
 gfxhub_v1_2_xcc_gart_enable (v2)
Thread-Index: AQHZulC7R+x1D0ix2U61EoXsBs4PQ6/BR+C5
Date: Wed, 19 Jul 2023 16:30:49 +0000
Message-ID: <BL1PR12MB5144EAD7988C1B060AAC54B7F739A@BL1PR12MB5144.namprd12.prod.outlook.com>
References: <20230719145208.3769-1-victorchengchi.lu@amd.com>
In-Reply-To: <20230719145208.3769-1-victorchengchi.lu@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Enabled=True;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SetDate=2023-07-19T16:30:48.794Z;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Name=Public;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ContentBits=0;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Method=Privileged; 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL1PR12MB5144:EE_|SJ2PR12MB8884:EE_
x-ms-office365-filtering-correlation-id: 11816cd1-924b-45e1-8a1b-08db88758321
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: JCVqQ0sbGGchfJ9zXELFdQsaoTiGKMyDRAirhhWusne54JQbJHJuvckMvhXfYDRsjqdrzXGZRj8TMzg2XUJAK3J6fzdy1JPMRGH4BuuPHOCpW02ycCTmnVjoBfxnkW3eeB8Or6V0WvY4sW4y04ifJJk6hyJgOz/OVatImW5HrnPhAh3xGP920+6SoDWYvlOJXZQaWBmsUDor7MphTwUh25XeSovHvttgKLGyk0QulO8oT8tf1hvNtJ2VT6cLO2Or7ViUHsyDsEnP1oMMA5hRfzqrV2BmHcrJtL9tszrCkVLcpHVSgXw+ubJYhqAgIK2XtQ+iGbWMKFGmKQa6+lBQY0mVWRczXYvJVNYdi4tiuTrxVmI89u9NEvFb9Ca510V64iHovreWTryo8KisAUeZcM3OLcemdjUmwON3RwJf9soaczEAhyvFt+fjaw2ipc0wylFxApTzdw1dViNi3G/jnVXZFiYMmLDMfrUBtrB4I2rA55MAjYXjF+YSHxSwGO6FC2nMNdI+YuakZTbNGmsqF7EtTIWPnuCZZMOxl2fDc8KFp13iM4LftgOgh4NqeEDz9aZVzoPzUbTK+2PhKWX4JncSyirpR8BobnC92sVzt7tRaTO17bIhQpYoZBn8rFMQ
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL1PR12MB5144.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(4636009)(136003)(39860400002)(346002)(366004)(376002)(396003)(451199021)(76116006)(55016003)(38100700002)(66476007)(4326008)(5660300002)(64756008)(66446008)(41300700001)(66556008)(8936002)(66946007)(33656002)(86362001)(38070700005)(52536014)(2906002)(8676002)(316002)(186003)(7696005)(71200400001)(19627405001)(83380400001)(26005)(53546011)(6506007)(122000001)(9686003)(54906003)(478600001)(110136005);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?CEjDwomjAPECbJiqUfBU7TyD5HMRadfpTx3MgJYBfMoivhIG+LXdlZJF/ZZx?=
 =?us-ascii?Q?QYok8+NXp8QwWHFtwuSl4N3xGp6P+uQNHIJ0MdGvDFiK+SXTpY/EUiu9+Dy9?=
 =?us-ascii?Q?1CCLwUu0DrCMAJ7UTnDp6bfq+h/8LBGsC2Ex1hmzdqeDMwCLcZ2VJ19PPHvp?=
 =?us-ascii?Q?tzo9i1n1G3NA71xx9OVMKaTT5d7miDGK7su2C08L/KAS5bVOnE1u95UZ7EDG?=
 =?us-ascii?Q?5abD4CXMQ+42bCYIP5RThsAFE3xh+czYIpYJaXQBz1Od9vlC6accBiBHWIXV?=
 =?us-ascii?Q?ukSHBc1u411gQeVQdNl2z2juf618T9ema+F7FVul0w1dVu6Q38lSn5/FpwRc?=
 =?us-ascii?Q?cuMEd5yKwE0L9wkEUccS6t8b5k3kdNDgv6I1oWiiqKn9jZUnGzhf1RzyHLLk?=
 =?us-ascii?Q?AagkkrXaI8R0nz/84IVq5fKShLKseqqSfoZ6Q5GU+AuT6psTi747iztMFsq9?=
 =?us-ascii?Q?2UQBrN3HxlAxMXOEPjar+djK7ECHCkuVYyIIeVdBRvUZyfn8t7a7Mgc/fElz?=
 =?us-ascii?Q?ql42lzKSK32Pv7nuIHSshAiw5CFg7AfwpEFjvuWdJOwVw4IRt1PswJeI8PAW?=
 =?us-ascii?Q?BtdYbQzIordVjyWueu9bM52Jsiv5/cbcANsjTUSWLFl/FrseOWbISzzEfJiU?=
 =?us-ascii?Q?CYS61j0NVXKq90kV6PdzB8vO8fWZ8+xDV/2OdHTcjAzqUfV6SKvK7Z/oAcfx?=
 =?us-ascii?Q?6gAUzqK3FGyvoszqCJUULy8ILLFCS0vfreBSgyOJ+YSSP9ZbLAoeQCGVeKeL?=
 =?us-ascii?Q?et1jGyNaciCKhMG3EMksMx9o2UncVEj9OY5L4Lj1iPmITRH3PsxZBlNtazux?=
 =?us-ascii?Q?1pqZeBgmnc5vIebpNJWoA1R8x82nar/Ym3ThRdJMBQU7Q7tnfQGic+5f9jqu?=
 =?us-ascii?Q?sgLIhM0JtZURONEQPS81ujJiodKPcXTl+nxIF+I3XoeC8pkXRVdFFVwQ4txW?=
 =?us-ascii?Q?fka7eyH/eA5TJpJgfOXKaPcGxeNOSqWXHB8t8IFbHbXVf8ajPJrkrvS7UQC3?=
 =?us-ascii?Q?QSRHZfMjLTR/X+7HDZlShAQJxJIbxSH4eMetfuJpUkjy6VuaTtrNNDZl4+dC?=
 =?us-ascii?Q?4QNEwzDAVSNmsoK46LU5ZfOY705/ZuG9l+4BK7zlrV5j/puCFeUWwCkbh9kz?=
 =?us-ascii?Q?xHGMM5Dom6wQA4pLakCMzfVnGXB89HK2I04CcLZz/DOQ/OtK7dtMZiIo4/td?=
 =?us-ascii?Q?mLiUHmMFL2ACUnV2L0F5QdVBxLg2S+39UPNx8bxEWX1cNvAlmsMy9BYS2dVg?=
 =?us-ascii?Q?zLN5YZBUJT47bNEdhdx+Bh8VndfGNHwJU5Tz4VoPunPbSNn6c3qZo/hVaCwM?=
 =?us-ascii?Q?DnAuyPP4le8cYrdRSq1HN0lU/yEqqeMEqMSjAraANQmwMxjaZFdUNmcY4TVm?=
 =?us-ascii?Q?tXQtQDRFQoQ04eysl9O54x1+TYomRRnUmtZXQ9U6mg1TttTqmOoqxsI564YK?=
 =?us-ascii?Q?IuMkHKe6jfhhQkmsh0Cqqh//SiDsxcBMObzSg1G9xnZ51iV8Vfhl/VaXIIHH?=
 =?us-ascii?Q?uFJPDKZ8fUEfdDLsIzOqTMPH2smq07nbU5Sa6C/SjL/yO/vGttO+Xs9e+9s+?=
 =?us-ascii?Q?8vCZ+kjzewrb8RzpiB8=3D?=
Content-Type: multipart/alternative;
 boundary="_000_BL1PR12MB5144EAD7988C1B060AAC54B7F739ABL1PR12MB5144namp_"
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5144.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 11816cd1-924b-45e1-8a1b-08db88758321
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Jul 2023 16:30:49.5537 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: DRIwG+rpPlGcGei73I8E9AQu8KCPRK2h5Sb4Tvz5ijwcO8hr4lPqK2pcobQG+rR624eszmYq+7OFp0Oy59pYQg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8884
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
Cc: "Zhou, Bob" <Bob.Zhou@amd.com>, "Lazar, Lijo" <Lijo.Lazar@amd.com>,
 "Skvortsov, Victor" <Victor.Skvortsov@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--_000_BL1PR12MB5144EAD7988C1B060AAC54B7F739ABL1PR12MB5144namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

[Public]

With the scripts/package/builddeb changes dropped, the patch is:
Acked-by: Alex Deucher <alexander.deucher@amd.com>
________________________________
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> on behalf of Victor L=
u <victorchengchi.lu@amd.com>
Sent: Wednesday, July 19, 2023 10:52 AM
To: amd-gfx@lists.freedesktop.org <amd-gfx@lists.freedesktop.org>
Cc: Skvortsov, Victor <Victor.Skvortsov@amd.com>; Zhou, Bob <Bob.Zhou@amd.c=
om>; Lazar, Lijo <Lijo.Lazar@amd.com>; Lu, Victor Cheng Chi (Victor) <Victo=
rChengChi.Lu@amd.com>
Subject: [PATCH v2] drm/amdgpu: Fix infinite loop in gfxhub_v1_2_xcc_gart_e=
nable (v2)

An instance of for_each_inst() was not changed to match its new
behaviour and is causing a loop.

v2: remove tmp_mask variable

Fixes: 50c1d81d6365 ("drm/amdgpu: Modify for_each_inst macro")
Signed-off-by: Victor Lu <victorchengchi.lu@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gfxhub_v1_2.c |  5 +-
 scripts/package/builddeb                 | 60 ++++++++++++------------
 2 files changed, 31 insertions(+), 34 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfxhub_v1_2.c b/drivers/gpu/drm/amd=
/amdgpu/gfxhub_v1_2.c
index 47f95ec218a3..dbdee1a0aefe 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfxhub_v1_2.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfxhub_v1_2.c
@@ -402,18 +402,15 @@ static void gfxhub_v1_2_xcc_program_invalidation(stru=
ct amdgpu_device *adev,
 static int gfxhub_v1_2_xcc_gart_enable(struct amdgpu_device *adev,
                                        uint32_t xcc_mask)
 {
-       uint32_t tmp_mask;
         int i;

-       tmp_mask =3D xcc_mask;
         /*
          * MC_VM_FB_LOCATION_BASE/TOP is NULL for VF, because they are
          * VF copy registers so vbios post doesn't program them, for
          * SRIOV driver need to program them
          */
         if (amdgpu_sriov_vf(adev)) {
-               for_each_inst(i, tmp_mask) {
-                       i =3D ffs(tmp_mask) - 1;
+               for_each_inst(i, xcc_mask) {
                         WREG32_SOC15_RLC(GC, GET_INST(GC, i), regMC_VM_FB_=
LOCATION_BASE,
                                      adev->gmc.vram_start >> 24);
                         WREG32_SOC15_RLC(GC, GET_INST(GC, i), regMC_VM_FB_=
LOCATION_TOP,
diff --git a/scripts/package/builddeb b/scripts/package/builddeb
index 67cd420dcf89..c5508054bfc8 100755
--- a/scripts/package/builddeb
+++ b/scripts/package/builddeb
@@ -164,23 +164,23 @@ if is_enabled CONFIG_MODULES; then
                 mv "$tmpdir/lib/modules/$version"/* "$tmpdir/usr/lib/uml/m=
odules/$version/"
                 rmdir "$tmpdir/lib/modules/$version"
         fi
-       if [ -n "$BUILD_DEBUG" ] ; then
-               for module in $(find $tmpdir/lib/modules/ -name *.ko -print=
f '%P\n'); do
-                       module=3Dlib/modules/$module
-                       mkdir -p $(dirname $dbg_dir/usr/lib/debug/$module)
-                       # only keep debug symbols in the debug file
-                       $OBJCOPY --only-keep-debug $tmpdir/$module $dbg_dir=
/usr/lib/debug/$module
-                       # strip original module from debug symbols
-                       $OBJCOPY --strip-debug $tmpdir/$module
-                       # then add a link to those
-                       $OBJCOPY --add-gnu-debuglink=3D$dbg_dir/usr/lib/deb=
ug/$module $tmpdir/$module
-               done
-
-               # resign stripped modules
-               if is_enabled CONFIG_MODULE_SIG_ALL; then
-                       INSTALL_MOD_PATH=3D"$tmpdir" $MAKE -f $srctree/Make=
file modules_sign
-               fi
-       fi
+       #if [ -n "$BUILD_DEBUG" ] ; then
+       #       for module in $(find $tmpdir/lib/modules/ -name *.ko -print=
f '%P\n'); do
+       #               module=3Dlib/modules/$module
+       #               mkdir -p $(dirname $dbg_dir/usr/lib/debug/$module)
+       #               # only keep debug symbols in the debug file
+       #               $OBJCOPY --only-keep-debug $tmpdir/$module $dbg_dir=
/usr/lib/debug/$module
+       #               # strip original module from debug symbols
+       #               $OBJCOPY --strip-debug $tmpdir/$module
+       #               # then add a link to those
+       #               $OBJCOPY --add-gnu-debuglink=3D$dbg_dir/usr/lib/deb=
ug/$module $tmpdir/$module
+       #       done
+
+       #       # resign stripped modules
+       #       if is_enabled CONFIG_MODULE_SIG_ALL; then
+       #               INSTALL_MOD_PATH=3D"$tmpdir" $MAKE -f $srctree/Make=
file modules_sign
+       #       fi
+       #fi
 fi

 # Install the maintainer scripts
@@ -220,18 +220,18 @@ fi

 create_package "$packagename" "$tmpdir"

-if [ -n "$BUILD_DEBUG" ] ; then
-       # Build debug package
-       # Different tools want the image in different locations
-       # perf
-       mkdir -p $dbg_dir/usr/lib/debug/lib/modules/$version/
-       cp vmlinux $dbg_dir/usr/lib/debug/lib/modules/$version/
-       # systemtap
-       mkdir -p $dbg_dir/usr/lib/debug/boot/
-       ln -s ../lib/modules/$version/vmlinux $dbg_dir/usr/lib/debug/boot/v=
mlinux-$version
-       # kdump-tools
-       ln -s lib/modules/$version/vmlinux $dbg_dir/usr/lib/debug/vmlinux-$=
version
-       create_package "$dbg_packagename" "$dbg_dir"
-fi
+#if [ -n "$BUILD_DEBUG" ] ; then
+#      # Build debug package
+#      # Different tools want the image in different locations
+#      # perf
+#      mkdir -p $dbg_dir/usr/lib/debug/lib/modules/$version/
+#      cp vmlinux $dbg_dir/usr/lib/debug/lib/modules/$version/
+#      # systemtap
+#      mkdir -p $dbg_dir/usr/lib/debug/boot/
+#      ln -s ../lib/modules/$version/vmlinux $dbg_dir/usr/lib/debug/boot/v=
mlinux-$version
+#      # kdump-tools
+#      ln -s lib/modules/$version/vmlinux $dbg_dir/usr/lib/debug/vmlinux-$=
version
+#      create_package "$dbg_packagename" "$dbg_dir"
+#fi

 exit 0
--
2.34.1


--_000_BL1PR12MB5144EAD7988C1B060AAC54B7F739ABL1PR12MB5144namp_
Content-Type: text/html; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<html>
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Dus-ascii"=
>
<style type=3D"text/css" style=3D"display:none;"> P {margin-top:0;margin-bo=
ttom:0;} </style>
</head>
<body dir=3D"ltr">
<p style=3D"font-family:Arial;font-size:10pt;color:#008000;margin:15pt;font=
-style:normal;font-weight:normal;text-decoration:none;" align=3D"Left">
[Public]<br>
</p>
<br>
<div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);" class=3D"elementToProof">
With the <font size=3D"2"><span style=3D"font-size:11pt" class=3D"ContentPa=
sted0">scripts/package/builddeb</span></font> changes dropped, the patch is=
:</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);" class=3D"elementToProof">
Acked-by: Alex Deucher &lt;alexander.deucher@amd.com&gt;<br>
</div>
<div id=3D"appendonsend"></div>
<hr style=3D"display:inline-block;width:98%" tabindex=3D"-1">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" st=
yle=3D"font-size:11pt" color=3D"#000000"><b>From:</b> amd-gfx &lt;amd-gfx-b=
ounces@lists.freedesktop.org&gt; on behalf of Victor Lu &lt;victorchengchi.=
lu@amd.com&gt;<br>
<b>Sent:</b> Wednesday, July 19, 2023 10:52 AM<br>
<b>To:</b> amd-gfx@lists.freedesktop.org &lt;amd-gfx@lists.freedesktop.org&=
gt;<br>
<b>Cc:</b> Skvortsov, Victor &lt;Victor.Skvortsov@amd.com&gt;; Zhou, Bob &l=
t;Bob.Zhou@amd.com&gt;; Lazar, Lijo &lt;Lijo.Lazar@amd.com&gt;; Lu, Victor =
Cheng Chi (Victor) &lt;VictorChengChi.Lu@amd.com&gt;<br>
<b>Subject:</b> [PATCH v2] drm/amdgpu: Fix infinite loop in gfxhub_v1_2_xcc=
_gart_enable (v2)</font>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt;=
">
<div class=3D"PlainText">An instance of for_each_inst() was not changed to =
match its new<br>
behaviour and is causing a loop.<br>
<br>
v2: remove tmp_mask variable<br>
<br>
Fixes: 50c1d81d6365 (&quot;drm/amdgpu: Modify for_each_inst macro&quot;)<br=
>
Signed-off-by: Victor Lu &lt;victorchengchi.lu@amd.com&gt;<br>
---<br>
&nbsp;drivers/gpu/drm/amd/amdgpu/gfxhub_v1_2.c |&nbsp; 5 +-<br>
&nbsp;scripts/package/builddeb&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; | 60 ++++++++++++------=
------<br>
&nbsp;2 files changed, 31 insertions(+), 34 deletions(-)<br>
<br>
diff --git a/drivers/gpu/drm/amd/amdgpu/gfxhub_v1_2.c b/drivers/gpu/drm/amd=
/amdgpu/gfxhub_v1_2.c<br>
index 47f95ec218a3..dbdee1a0aefe 100644<br>
--- a/drivers/gpu/drm/amd/amdgpu/gfxhub_v1_2.c<br>
+++ b/drivers/gpu/drm/amd/amdgpu/gfxhub_v1_2.c<br>
@@ -402,18 +402,15 @@ static void gfxhub_v1_2_xcc_program_invalidation(stru=
ct amdgpu_device *adev,<br>
&nbsp;static int gfxhub_v1_2_xcc_gart_enable(struct amdgpu_device *adev,<br=
>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp; uint32_t xcc_mask)<br>
&nbsp;{<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t tmp_mask;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int i;<br>
&nbsp;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; tmp_mask =3D xcc_mask;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /*<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * MC_VM_FB_LOCATION_=
BASE/TOP is NULL for VF, because they are<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * VF copy registers =
so vbios post doesn't program them, for<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * SRIOV driver need =
to program them<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; */<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (amdgpu_sriov_vf(adev))=
 {<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; for_each_inst(i, tmp_mask) {<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; i =3D ffs(tmp_ma=
sk) - 1;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; for_each_inst(i, xcc_mask) {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; WREG3=
2_SOC15_RLC(GC, GET_INST(GC, i), regMC_VM_FB_LOCATION_BASE,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ad=
ev-&gt;gmc.vram_start &gt;&gt; 24);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; WREG3=
2_SOC15_RLC(GC, GET_INST(GC, i), regMC_VM_FB_LOCATION_TOP,<br>
diff --git a/scripts/package/builddeb b/scripts/package/builddeb<br>
index 67cd420dcf89..c5508054bfc8 100755<br>
--- a/scripts/package/builddeb<br>
+++ b/scripts/package/builddeb<br>
@@ -164,23 +164,23 @@ if is_enabled CONFIG_MODULES; then<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; mv &quot;$tmpdir/lib/modules/$version&quot;/* &quot;$=
tmpdir/usr/lib/uml/modules/$version/&quot;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; rmdir &quot;$tmpdir/lib/modules/$version&quot;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; fi<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if [ -n &quot;$BUILD_DEBUG&quot; ] ; =
then<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; for module in $(find $tmpdir/lib/modules/ -name *.ko -printf '%P=
\n'); do<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; module=3Dlib/mod=
ules/$module<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mkdir -p $(dirna=
me $dbg_dir/usr/lib/debug/$module)<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; # only keep debu=
g symbols in the debug file<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; $OBJCOPY --only-=
keep-debug $tmpdir/$module $dbg_dir/usr/lib/debug/$module<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; # strip original=
 module from debug symbols<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; $OBJCOPY --strip=
-debug $tmpdir/$module<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; # then add a lin=
k to those<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; $OBJCOPY --add-g=
nu-debuglink=3D$dbg_dir/usr/lib/debug/$module $tmpdir/$module<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; done<br>
-<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; # resign stripped modules<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; if is_enabled CONFIG_MODULE_SIG_ALL; then<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; INSTALL_MOD_PATH=
=3D&quot;$tmpdir&quot; $MAKE -f $srctree/Makefile modules_sign<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; fi<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; fi<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; #if [ -n &quot;$BUILD_DEBUG&quot; ] ;=
 then<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; #&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
 for module in $(find $tmpdir/lib/modules/ -name *.ko -printf '%P\n'); do<b=
r>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; #&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; module=3Dlib/modules/$modu=
le<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; #&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mkdir -p $(dirname $dbg_di=
r/usr/lib/debug/$module)<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; #&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; # only keep debug symbols =
in the debug file<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; #&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; $OBJCOPY --only-keep-debug=
 $tmpdir/$module $dbg_dir/usr/lib/debug/$module<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; #&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; # strip original module fr=
om debug symbols<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; #&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; $OBJCOPY --strip-debug $tm=
pdir/$module<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; #&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; # then add a link to those=
<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; #&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; $OBJCOPY --add-gnu-debugli=
nk=3D$dbg_dir/usr/lib/debug/$module $tmpdir/$module<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; #&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
 done<br>
+<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; #&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
 # resign stripped modules<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; #&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
 if is_enabled CONFIG_MODULE_SIG_ALL; then<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; #&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; INSTALL_MOD_PATH=3D&quot;$=
tmpdir&quot; $MAKE -f $srctree/Makefile modules_sign<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; #&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
 fi<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; #fi<br>
&nbsp;fi<br>
&nbsp;<br>
&nbsp;# Install the maintainer scripts<br>
@@ -220,18 +220,18 @@ fi<br>
&nbsp;<br>
&nbsp;create_package &quot;$packagename&quot; &quot;$tmpdir&quot;<br>
&nbsp;<br>
-if [ -n &quot;$BUILD_DEBUG&quot; ] ; then<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; # Build debug package<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; # Different tools want the image in d=
ifferent locations<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; # perf<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mkdir -p $dbg_dir/usr/lib/debug/lib/m=
odules/$version/<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; cp vmlinux $dbg_dir/usr/lib/debug/lib=
/modules/$version/<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; # systemtap<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mkdir -p $dbg_dir/usr/lib/debug/boot/=
<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ln -s ../lib/modules/$version/vmlinux=
 $dbg_dir/usr/lib/debug/boot/vmlinux-$version<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; # kdump-tools<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ln -s lib/modules/$version/vmlinux $d=
bg_dir/usr/lib/debug/vmlinux-$version<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; create_package &quot;$dbg_packagename=
&quot; &quot;$dbg_dir&quot;<br>
-fi<br>
+#if [ -n &quot;$BUILD_DEBUG&quot; ] ; then<br>
+#&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; # Build debug package<br>
+#&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; # Different tools want the image in differ=
ent locations<br>
+#&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; # perf<br>
+#&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mkdir -p $dbg_dir/usr/lib/debug/lib/module=
s/$version/<br>
+#&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; cp vmlinux $dbg_dir/usr/lib/debug/lib/modu=
les/$version/<br>
+#&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; # systemtap<br>
+#&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mkdir -p $dbg_dir/usr/lib/debug/boot/<br>
+#&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ln -s ../lib/modules/$version/vmlinux $dbg=
_dir/usr/lib/debug/boot/vmlinux-$version<br>
+#&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; # kdump-tools<br>
+#&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ln -s lib/modules/$version/vmlinux $dbg_di=
r/usr/lib/debug/vmlinux-$version<br>
+#&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; create_package &quot;$dbg_packagename&quot=
; &quot;$dbg_dir&quot;<br>
+#fi<br>
&nbsp;<br>
&nbsp;exit 0<br>
-- <br>
2.34.1<br>
<br>
</div>
</span></font></div>
</div>
</body>
</html>

--_000_BL1PR12MB5144EAD7988C1B060AAC54B7F739ABL1PR12MB5144namp_--
