Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6593DC433F5
	for <amd-gfx@archiver.kernel.org>; Wed,  8 Dec 2021 10:09:47 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EB5026F3C6;
	Wed,  8 Dec 2021 10:09:46 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2070.outbound.protection.outlook.com [40.107.236.70])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6C3FF6F3C6
 for <amd-gfx@lists.freedesktop.org>; Wed,  8 Dec 2021 10:09:45 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VlcoJWOfWZ099TD/utu/Arhs7D+j1soIBwdDHWDNLYtmoZCXDo6ux0ESpJb5LrM5LDiUM1nfSZsqkyJGBMLGEltmhphrehD90BjZOlxy9CUZbG27MmvzGIdcLXvOxBwkKq/CVzqHaAxA+lxEXSPCINeStJptyAkfwN1ElGhgg0Sdo1Qv36jdl8XHrC0Cj3MP4Tj1xu3EBwIk/C5NAorKeke3+sVqLVKgs1V2aJYG4NE4SYhobOuptBSxBxgfYvp1+P4Y7Wwtn7n2Oo2pcNprnwu5rC7hbAs8w//ISipYhwcUlIlPjIPrh81Brznh1SyWn4czYb21z1ESHb30bqpyvA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9CGcD2p0UAPEprsN8vo7fJJ96HWPN3TmrdUmh5oE/yE=;
 b=B+TsYC3iWGrog6f/Mwq4TmSMDHivCn0R5BMJ6CiM+W4Sb1y7F5G/RfKrDNdzN3QXc7tS0jk8LhXVbP7WpEuwtQZmzkPe/5whUZxodYT5hHiUGTO4x7eBjZ0Ve3tclOR/sLxd7pld8aU0bkksgOTmhUAGdCtF2NlvYgg8jteRj+TtuxOizJPBzsyWuWsVo2usGmUIklrw3Uozw464nBqMI1DzkmgGazGw8UGRFKEuCKLnMIdYY+kOEbCU/ieSfMXoj5b51IbSuqDmjpHpams6/PudHDbDvkIo7gRe9qeXgbwFXVzecaWKBRvFaL/ljAkOsAhStIv+zO3Lw4LyKZgwVg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9CGcD2p0UAPEprsN8vo7fJJ96HWPN3TmrdUmh5oE/yE=;
 b=K0DJBpZD5KDughwOG6U0JPlmxq37YNXqVJc/SLpJ+lpfxRBobKy07oQCWWWpLOQE2OYY9XbTDhkqyVkH5i5F2Q5E5Mw5YMPeuR1vBS6nAln5zPXTxeQANpnCoVDo0SabmdcXsTEwVj7HXX73VUHQA2/KZun27fDliHCexfQ+lLo=
Received: from CO6PR12MB5473.namprd12.prod.outlook.com (2603:10b6:303:13e::8)
 by CO6PR12MB5460.namprd12.prod.outlook.com (2603:10b6:5:357::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4755.21; Wed, 8 Dec
 2021 10:09:42 +0000
Received: from CO6PR12MB5473.namprd12.prod.outlook.com
 ([fe80::41ae:ed40:dc40:9205]) by CO6PR12MB5473.namprd12.prod.outlook.com
 ([fe80::41ae:ed40:dc40:9205%9]) with mapi id 15.20.4734.024; Wed, 8 Dec 2021
 10:09:42 +0000
From: "Wang, Yang(Kevin)" <KevinYang.Wang@amd.com>
To: "Yu, Lang" <Lang.Yu@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: Re: [PATCH 2/2] drm/amdgpu: only hw fini SMU fisrt for ASICs need that
Thread-Topic: [PATCH 2/2] drm/amdgpu: only hw fini SMU fisrt for ASICs need
 that
Thread-Index: AQHX7BfSef6IgowK4kKmv9FLvHitA6woXyP9
Date: Wed, 8 Dec 2021 10:09:42 +0000
Message-ID: <CO6PR12MB547377D3C826B438E6CC051A826F9@CO6PR12MB5473.namprd12.prod.outlook.com>
References: <20211208092642.173385-1-lang.yu@amd.com>
 <20211208092642.173385-2-lang.yu@amd.com>
In-Reply-To: <20211208092642.173385-2-lang.yu@amd.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Enabled=True;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SetDate=2021-12-08T10:09:41.396Z;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Name=AMD
 Official Use
 Only; MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ContentBits=0;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Method=Standard; 
suggested_attachment_session_id: f7aacde6-9012-d9d3-e585-50c06fdf17fc
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: c493850e-b16c-41a3-b06a-08d9ba32da42
x-ms-traffictypediagnostic: CO6PR12MB5460:EE_
x-microsoft-antispam-prvs: <CO6PR12MB546075C3B7723DAA223769DF826F9@CO6PR12MB5460.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:185;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: hcgF+sctPmK+Uin2+EAWA432Z5yQm3Xbhig5ofRjsaRLyue4RaIGQZqPmXVmhHZdZ0E8l3RpaCvfSkypV4yOCrdzGarhMIfO2LNFZt+AOK9bgHGTO7F7IC7Tsf0xZ+gEJFqyF7aKZbg+t/6+p+j7YXq7YZxazvm66ZbXNT6K81ziOrSDJnI8qDYr4tLPn+lB41yg4bsVwymI9cOTxcBszQd7PCTmP9ZcSSbYAJcygjFYWDeXlEupA8r7ewpMl5PsIeFNlEe6zIswgnig89KCb4KIoUJi8rrAtPpt1XtoLwSE6iUTd0uscp0l75zd26lPg7eLIq7yez+NeTAm8NiQQp7DXLJHYKpRmm4q8S8gttRo7L0t20Dor4+m5wsHnTjjsC5QRjgJ27g7qD7vg52DL3NgCV5ijlBznw+jbVyPa46j4MERhcj12pE2kAR2sXf5FfI7cILVhEDwQo8B2GZfWXTbJb4Rg24UBq4tCa5yrWjVVzZC4i0oKhOcppmCAW730e3RzG4IrMJesHko8WzWIBulbrdIAr65zqGVgevouZwiXWOGueUYlgHP9CgmsYUe+hOnDqWvDvZdjRSIPk0RnZc5l879lc9y3k82h+jYhZHVYnzxg3ON8SIwHU8uRbRkqbC9XUJCboKqIpz/ndEWFmGMdbd4fgHs6KOB1cGMh84aNVnhJUWxmO1LQFJHybl+AuUUkZmcxSd5GTp8pSvczzL4fpfJxRjQB0DQ1Uf4dCA=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CO6PR12MB5473.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(186003)(19627405001)(2906002)(52536014)(76116006)(55016003)(508600001)(5660300002)(8936002)(8676002)(66476007)(86362001)(83380400001)(66556008)(53546011)(6506007)(110136005)(7696005)(316002)(38100700002)(91956017)(66446008)(66946007)(54906003)(71200400001)(9686003)(4326008)(122000001)(38070700005)(33656002)(64756008)(21314003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?VqJ9IHTRKSIq9F2rSmA0x70KQPl75fS7Y6xjk7TOPzcKtw8mtYEknQso5l?=
 =?iso-8859-1?Q?ZkPowIPDntmh5Vt1zWPI5xaV5aj+RarPt6eS7AomOljJ+jyrzaIVjamJ8F?=
 =?iso-8859-1?Q?xpXngPTCMjk8D0M5LBJG3YxedRFZdSPqVdY+WmqDMxT3UI/aroB35cAZQs?=
 =?iso-8859-1?Q?PL9/0HpqYL8R3o8O5ptPsfH+l9wbZOjJ9oQ6YFaXpnL5Bvp1sv5xUm+Pvp?=
 =?iso-8859-1?Q?bz+HFlG/av7HU7UavnaS2fiGvEgY/fW2U09ZAeF+iicsSJFBdgfKYSgMy+?=
 =?iso-8859-1?Q?8G84HUybFTG05G1UpuQw0CvSndYf+zKtHJ4T3JzZAJfSVIJNojVh5+EysE?=
 =?iso-8859-1?Q?CSMbs0l+00gGMwU5gJ2H5jK+SHut/kFQfcTjIbR+ld56SaA1J24MZOhIFa?=
 =?iso-8859-1?Q?0Xw3Cj7pizKbL6fxELYdlZoitSG4U0sYjJvkmOoyP6bCgdXiLsuC0dHVDE?=
 =?iso-8859-1?Q?EwTbg5fUt48eN+agZAOSegIgAW1DLucBSulF9EyhWM7by1Kpz/6vfPyDxu?=
 =?iso-8859-1?Q?rfbB1eKOd0Qr0oW6RTYOGA/8EBGoMqS0LxY9l0maqoF+HJF5IoEWrOwEAF?=
 =?iso-8859-1?Q?2FhG7Ro+KbH434zwUGER7WaHyXLWHJ1UPT809OqCY0Vmnmtn1R32FDKR3p?=
 =?iso-8859-1?Q?8WDpY7fBNoONx35vIJFUDBmiVPywKOIqDVvunfUIYmkZ5r+7Om+LIG2KZR?=
 =?iso-8859-1?Q?7eNOa0P6DUYHwWJls9X0lWPIaszJX+yirFVklmSffIteT3y16hMp3kVxOD?=
 =?iso-8859-1?Q?+qWGHLeVi0R/l+mGpF1+C+I3VGk7aiICHUMt3DDo9Vq8zRPhee72qg4Ft7?=
 =?iso-8859-1?Q?/OPBj2zGl+MjeXZglY3Ynh7BFuuRkXdo46ZDHK9b/xbTBi83EWlSYjhyL5?=
 =?iso-8859-1?Q?OfOfGyvWftSCUX1ZS/AoUy0T7HU9TAwx8g4znoTfDe9Q6axe9sklTLbfUs?=
 =?iso-8859-1?Q?0uc44kF2J9BVuYAVgx+1KSUuFZLxcQrsIVzcdaGFYHvSRz6nvpt9c0orlO?=
 =?iso-8859-1?Q?bZzWkVMNFA2pzRRBT8MIMYf5dKFZZEKfGBm9o2EZ3eW4gVH23OkfMYsqLd?=
 =?iso-8859-1?Q?+AD+yhGQHgXFTtucJ9k9gOD464M+MV1bzbWv6rNIhnzPNtWbaFrhAJ+CAr?=
 =?iso-8859-1?Q?107bHUNigKZiOS3cU3A72aJmlwrKushX7hMMalgpfkK7SxKmIQ835MN6Q/?=
 =?iso-8859-1?Q?E3yP3f2SuS3I0sVCgb3KpR/PKR3x+Io2it75KO6wErPcggtc0JgGnRMRFN?=
 =?iso-8859-1?Q?SRKtXS1o5I9ASwD50hdu4Vk9AI4aJRA059hwUHJOb/PFx+vP73H2afVjZJ?=
 =?iso-8859-1?Q?/jbncDTAxtKcSCTSYwATUWadhfRJdY3/WDXbW8gtxJYe0KiYNP1PN9mNYZ?=
 =?iso-8859-1?Q?iOrn+f9kaQoiwUqgORqNnvnmdVEkW9j+hb16oOyV/xUVsVWaELKLNMYW0S?=
 =?iso-8859-1?Q?e/gTeNrkb5ocyr+0N5NP7IEFY38gGG9ZHyrbgEIuL9ALxx9v/p/vCPdCMx?=
 =?iso-8859-1?Q?u5drvJrKRlCQqwR5hbQ/HDzU9wRbiIIeQ8JzVCHOCNujPNugHzlgf+KL59?=
 =?iso-8859-1?Q?r7NrXg3xHfCu7f1s8VKvPZcJVOu1i/tomB3FAQdS+B6u/bkA3TIL40qpzy?=
 =?iso-8859-1?Q?gsqStNdnXJy2ujpgfLUqeYkxMXbyO5bSJ+ZlMUeC50TrvWVg/0zzpzyQ?=
 =?iso-8859-1?Q?=3D=3D?=
Content-Type: multipart/alternative;
 boundary="_000_CO6PR12MB547377D3C826B438E6CC051A826F9CO6PR12MB5473namp_"
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CO6PR12MB5473.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c493850e-b16c-41a3-b06a-08d9ba32da42
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Dec 2021 10:09:42.0469 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: UeTYf+re0rW9etdBtoEVV8Tm7Kokgu0u1rRq/hkQc1VRw0KnDt08TH24ZUhabUKB
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO6PR12MB5460
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
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Lazar,
 Lijo" <Lijo.Lazar@amd.com>, "Huang, Ray" <Ray.Huang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--_000_CO6PR12MB547377D3C826B438E6CC051A826F9CO6PR12MB5473namp_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

[AMD Official Use Only]

Reviewed-by: Kevin Wang <kevinyang.wang@amd.com>

Best Regards,
Kevin
________________________________
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> on behalf of Lang Yu =
<lang.yu@amd.com>
Sent: Wednesday, December 8, 2021 5:26 PM
To: amd-gfx@lists.freedesktop.org <amd-gfx@lists.freedesktop.org>
Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Yu, Lang <Lang.Yu@amd.c=
om>; Lazar, Lijo <Lijo.Lazar@amd.com>; Huang, Ray <Ray.Huang@amd.com>
Subject: [PATCH 2/2] drm/amdgpu: only hw fini SMU fisrt for ASICs need that

We found some headaches on ASICs don't need that,
so remove that for them.

Suggested-by: Lijo Lazar <lijo.lazar@amd.com>
Signed-off-by: Lang Yu <lang.yu@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 47 +++++++++++++++-------
 1 file changed, 32 insertions(+), 15 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/a=
md/amdgpu/amdgpu_device.c
index 3c5afa45173c..b5b32a582c51 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -2656,6 +2656,36 @@ static int amdgpu_device_ip_late_init(struct amdgpu_=
device *adev)
         return 0;
 }

+/**
+ * amdgpu_device_smu_fini_early - smu hw_fini wrapper
+ *
+ * @adev: amdgpu_device pointer
+ *
+ * For ASICs need to disable SMC first
+ */
+static void amdgpu_device_smu_fini_early(struct amdgpu_device *adev)
+{
+       int i, r;
+
+       if (adev->ip_versions[GC_HWIP][0] > IP_VERSION(9, 0, 0))
+               return;
+
+       for (i =3D 0; i < adev->num_ip_blocks; i++) {
+               if (!adev->ip_blocks[i].status.hw)
+                       continue;
+               if (adev->ip_blocks[i].version->type =3D=3D AMD_IP_BLOCK_TY=
PE_SMC) {
+                       r =3D adev->ip_blocks[i].version->funcs->hw_fini((v=
oid *)adev);
+                       /* XXX handle errors */
+                       if (r) {
+                               DRM_DEBUG("hw_fini of IP block <%s> failed =
%d\n",
+                                         adev->ip_blocks[i].version->funcs=
->name, r);
+                       }
+                       adev->ip_blocks[i].status.hw =3D false;
+                       break;
+               }
+       }
+}
+
 static int amdgpu_device_ip_fini_early(struct amdgpu_device *adev)
 {
         int i, r;
@@ -2676,21 +2706,8 @@ static int amdgpu_device_ip_fini_early(struct amdgpu=
_device *adev)
         amdgpu_device_set_pg_state(adev, AMD_PG_STATE_UNGATE);
         amdgpu_device_set_cg_state(adev, AMD_CG_STATE_UNGATE);

-       /* need to disable SMC first */
-       for (i =3D 0; i < adev->num_ip_blocks; i++) {
-               if (!adev->ip_blocks[i].status.hw)
-                       continue;
-               if (adev->ip_blocks[i].version->type =3D=3D AMD_IP_BLOCK_TY=
PE_SMC) {
-                       r =3D adev->ip_blocks[i].version->funcs->hw_fini((v=
oid *)adev);
-                       /* XXX handle errors */
-                       if (r) {
-                               DRM_DEBUG("hw_fini of IP block <%s> failed =
%d\n",
-                                         adev->ip_blocks[i].version->funcs=
->name, r);
-                       }
-                       adev->ip_blocks[i].status.hw =3D false;
-                       break;
-               }
-       }
+       /* Workaroud for ASICs need to disable SMC first */
+       amdgpu_device_smu_fini_early(adev);

         for (i =3D adev->num_ip_blocks - 1; i >=3D 0; i--) {
                 if (!adev->ip_blocks[i].status.hw)
--
2.25.1


--_000_CO6PR12MB547377D3C826B438E6CC051A826F9CO6PR12MB5473namp_
Content-Type: text/html; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

<html>
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Diso-8859-=
1">
<style type=3D"text/css" style=3D"display:none;"> P {margin-top:0;margin-bo=
ttom:0;} </style>
</head>
<body dir=3D"ltr">
<p style=3D"font-family:Arial;font-size:10pt;color:#0000FF;margin:5pt;" ali=
gn=3D"Left">
[AMD Official Use Only]<br>
</p>
<br>
<div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
Reviewed-by: Kevin Wang &lt;kevinyang.wang@amd.com&gt;</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
<br>
</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
Best Regards,</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
Kevin</div>
<hr tabindex=3D"-1" style=3D"display:inline-block; width:98%">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" co=
lor=3D"#000000" style=3D"font-size:11pt"><b>From:</b> amd-gfx &lt;amd-gfx-b=
ounces@lists.freedesktop.org&gt; on behalf of Lang Yu &lt;lang.yu@amd.com&g=
t;<br>
<b>Sent:</b> Wednesday, December 8, 2021 5:26 PM<br>
<b>To:</b> amd-gfx@lists.freedesktop.org &lt;amd-gfx@lists.freedesktop.org&=
gt;<br>
<b>Cc:</b> Deucher, Alexander &lt;Alexander.Deucher@amd.com&gt;; Yu, Lang &=
lt;Lang.Yu@amd.com&gt;; Lazar, Lijo &lt;Lijo.Lazar@amd.com&gt;; Huang, Ray =
&lt;Ray.Huang@amd.com&gt;<br>
<b>Subject:</b> [PATCH 2/2] drm/amdgpu: only hw fini SMU fisrt for ASICs ne=
ed that</font>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt"=
>
<div class=3D"PlainText">We found some headaches on ASICs don't need that,<=
br>
so remove that for them.<br>
<br>
Suggested-by: Lijo Lazar &lt;lijo.lazar@amd.com&gt;<br>
Signed-off-by: Lang Yu &lt;lang.yu@amd.com&gt;<br>
---<br>
&nbsp;drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 47 +++++++++++++++------=
-<br>
&nbsp;1 file changed, 32 insertions(+), 15 deletions(-)<br>
<br>
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/a=
md/amdgpu/amdgpu_device.c<br>
index 3c5afa45173c..b5b32a582c51 100644<br>
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c<br>
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c<br>
@@ -2656,6 +2656,36 @@ static int amdgpu_device_ip_late_init(struct amdgpu_=
device *adev)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return 0;<br>
&nbsp;}<br>
&nbsp;<br>
+/**<br>
+ * amdgpu_device_smu_fini_early - smu hw_fini wrapper<br>
+ *<br>
+ * @adev: amdgpu_device pointer<br>
+ *<br>
+ * For ASICs need to disable SMC first<br>
+ */<br>
+static void amdgpu_device_smu_fini_early(struct amdgpu_device *adev)<br>
+{<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int i, r;<br>
+<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (adev-&gt;ip_versions[GC_HWIP][0] =
&gt; IP_VERSION(9, 0, 0))<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; return;<br>
+<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; for (i =3D 0; i &lt; adev-&gt;num_ip_=
blocks; i++) {<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; if (!adev-&gt;ip_blocks[i].status.hw)<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; continue;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; if (adev-&gt;ip_blocks[i].version-&gt;type =3D=3D AMD_IP_BLOCK_T=
YPE_SMC) {<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; r =3D adev-&gt;i=
p_blocks[i].version-&gt;funcs-&gt;hw_fini((void *)adev);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* XXX handle er=
rors */<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (r) {<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; DRM_DEBUG(&quot;hw_fini of IP block &lt;%s&=
gt; failed %d\n&quot;,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp; adev-&gt;ip_blocks[i].version-&gt;funcs-&gt;name, r);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; adev-&gt;ip_bloc=
ks[i].status.hw =3D false;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; break;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; }<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
+}<br>
+<br>
&nbsp;static int amdgpu_device_ip_fini_early(struct amdgpu_device *adev)<br=
>
&nbsp;{<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int i, r;<br>
@@ -2676,21 +2706,8 @@ static int amdgpu_device_ip_fini_early(struct amdgpu=
_device *adev)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_device_set_pg_state=
(adev, AMD_PG_STATE_UNGATE);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_device_set_cg_state=
(adev, AMD_CG_STATE_UNGATE);<br>
&nbsp;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* need to disable SMC first */<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; for (i =3D 0; i &lt; adev-&gt;num_ip_=
blocks; i++) {<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; if (!adev-&gt;ip_blocks[i].status.hw)<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; continue;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; if (adev-&gt;ip_blocks[i].version-&gt;type =3D=3D AMD_IP_BLOCK_T=
YPE_SMC) {<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; r =3D adev-&gt;i=
p_blocks[i].version-&gt;funcs-&gt;hw_fini((void *)adev);<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* XXX handle er=
rors */<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (r) {<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; DRM_DEBUG(&quot;hw_fini of IP block &lt;%s&=
gt; failed %d\n&quot;,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp; adev-&gt;ip_blocks[i].version-&gt;funcs-&gt;name, r);<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; adev-&gt;ip_bloc=
ks[i].status.hw =3D false;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; break;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; }<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* Workaroud for ASICs need to disabl=
e SMC first */<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_device_smu_fini_early(adev);<b=
r>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; for (i =3D adev-&gt;num_ip=
_blocks - 1; i &gt;=3D 0; i--) {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; if (!adev-&gt;ip_blocks[i].status.hw)<br>
-- <br>
2.25.1<br>
<br>
</div>
</span></font></div>
</div>
</body>
</html>

--_000_CO6PR12MB547377D3C826B438E6CC051A826F9CO6PR12MB5473namp_--
