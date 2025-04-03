Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 264DBC3600C
	for <amd-gfx@archiver.kernel.org>; Thu,  3 Apr 2025 13:22:18 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BC28E10E9C0;
	Thu,  3 Apr 2025 13:22:17 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Er41Ivop";
	dkim-atps=neutral
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2056.outbound.protection.outlook.com [40.107.236.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 38FA910E9C0
 for <amd-gfx@lists.freedesktop.org>; Thu,  3 Apr 2025 13:22:16 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MDUJ1fXC35k2MRzdd2wmUpRYvdp3ReFkKjTdQ8L2ZBTaas3HHa1kcSrQhSfmwueSMqNUC9O87BakwR1+tUYJo6sve5I3QRPYa5ko5gBxLU581HRuNnTsE+PGlfs+4/9ZvNL+oky0ub2IMmptr62CyetW988X6tlfuc7+eNvFHGa9Ydso0xh5mQOQ/T5simzbzUGHeZb2kB9iqVcPZ8BHfeU8Ia64JpOrXH6MFtYaKKYiIvZaHs/+Q1e4LQVAEztFVWTydYFNNvQEF46rhtt12Mb5Ayz1dJFd8IbwN+5a5P+1Oxz8iklplJtHVvgr/Vb2JG4veqf8QRZ6xmxbm24SOw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=05vsYMSmL953RWUqKtj7/945uGNabsmP3FZteBOnFV8=;
 b=tEeY4+tHl4HAKPE6NcE/WXZVoly0boF4HWTcotFjO1x2obXrjtM8rkSluLqd5r48bspPGxkd2axybgOSKQuvQ7TkbZvlxjOB6LKaL6vxN+SHcahDn9psFPZ/4mkwuBzkcDkuiWYvyigC36ZV2U+acZqwlh720GbCjw3kCc0POoZNVstnools8oe0irE2cfaTdW797K0H6JZARKQ3SVo/9/1XOzmOSIZ35pNOLHjbeJ9BNLO6enTap1bbave44PyqBVXW4gdGO90PdNiygMmGj62a5IK3h0qEtIySgBQgGPIZ+vQTAe4IFrYuoH3wmQSP2LgLUP4xCxT14+nz2meNmQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=05vsYMSmL953RWUqKtj7/945uGNabsmP3FZteBOnFV8=;
 b=Er41Ivop0a471sx3WqP3RKWhaNSLsXEzluWTdzN0MgxBVp5olhwjzv1Ggw5rUmp7uI1rRS8aRLK119jhUyHxEFntGoyqsn+iEBhtmbD/EVXVEeF4CENp4GR/ErpfJ9VFgfBYGmPE2fh3/ZrYntmz45ZASOdvxjt3MTPDFSKqYOc=
Received: from MN0PR12MB6032.namprd12.prod.outlook.com (2603:10b6:208:3cc::20)
 by IA0PR12MB8930.namprd12.prod.outlook.com (2603:10b6:208:481::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.54; Thu, 3 Apr
 2025 13:22:13 +0000
Received: from MN0PR12MB6032.namprd12.prod.outlook.com
 ([fe80::cd54:d061:bc5f:4c1a]) by MN0PR12MB6032.namprd12.prod.outlook.com
 ([fe80::cd54:d061:bc5f:4c1a%6]) with mapi id 15.20.8534.043; Thu, 3 Apr 2025
 13:22:13 +0000
From: "Rehman, Ahmad" <Ahmad.Rehman@amd.com>
To: "Pan, Ellen" <Yunru.Pan@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
CC: "Skvortsov, Victor" <Victor.Skvortsov@amd.com>
Subject: RE: [PATCH] drm/amdgpu: Enable amdgpu_ras_resume for gfx 9.5.0
Thread-Topic: [PATCH] drm/amdgpu: Enable amdgpu_ras_resume for gfx 9.5.0
Thread-Index: AQHbo9jpixjSDD4Xf0Cb2HwMqwjO4rOR7tEw
Date: Thu, 3 Apr 2025 13:22:13 +0000
Message-ID: <MN0PR12MB6032BA93DBFADCA8A445931E8FAE2@MN0PR12MB6032.namprd12.prod.outlook.com>
References: <20250402140938.7845-1-yunru.pan@amd.com>
In-Reply-To: <20250402140938.7845-1-yunru.pan@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ActionId=d2ec6a31-80cd-4a5c-813b-8b4fe2e3e442;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=0;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=true;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution Only;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2025-04-03T13:21:06Z;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Tag=10, 3, 0, 1;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MN0PR12MB6032:EE_|IA0PR12MB8930:EE_
x-ms-office365-filtering-correlation-id: fa9bb09c-2e34-4186-f92d-08dd72b28bf9
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|38070700018|7053199007; 
x-microsoft-antispam-message-info: =?us-ascii?Q?eq7vn/M7Qqqx29sHoS284/fK4jfl3T67ZoIzz6qSt7+A5sSjTka5UxqlVsHE?=
 =?us-ascii?Q?NOOUe/YHJzLBjwRfCuby4E2cXzbRq8TUMqo1K4AavR7F7TI0dPE2Qh7v5jCx?=
 =?us-ascii?Q?Udxcynt5LpttMJzDb8QxdLmUfUDTpAXMFsgoMw63xu7Qd4BQ5cUrSEwY3ETe?=
 =?us-ascii?Q?DaXcUj9/figIu+JThZ1VR+D930yW8T/WC8W1hUotxIN/4MlQoabnJJyoMb5X?=
 =?us-ascii?Q?lOZOVuZbrdIo5/U/P35JgL10/4B558fiAbdnoaEPJMh7U+rfesrCLNhAZEBG?=
 =?us-ascii?Q?AQi1eenFNbB/s8UkvtmKvj2g0l7QzvppjKY6kntQWWPjmgdOyDYfTuYVU3mz?=
 =?us-ascii?Q?03TfS6k08sNbqF5kAoshM6UExn/Bqjmhdc1h6Fc2nmmzb6OGJE7g1MzS3Mr0?=
 =?us-ascii?Q?IUlfwjT3n6Z31OR+lf1UkkIMNxGkRkZ+yN4vdXJ0y6m5WcQ6vR0gW6jO7XlP?=
 =?us-ascii?Q?0owNw7yNK0ilXeuoSPiN9iQf37R2wkmhx3W7BOAumDHaLL03jFssgqYJNWFM?=
 =?us-ascii?Q?qKTACkFpSyKUuJjDJk+WswP+mWgtH8Y17APBwWo8WO7lCgvZIDzIygVDKGRB?=
 =?us-ascii?Q?aLMLS6box7ycJ8qzzxMP+RZ+kI9lTBA4BhO2LdK1YL+FHV0TpRL9cm/rsUZf?=
 =?us-ascii?Q?bHTRhj01dKVSPXOxQ72uPLw3AFiAa6QAe3virkgriCFXYdj+NpqjAchPt5g6?=
 =?us-ascii?Q?5Kxgtjknr6IbKqXa2B6fwXLr/NafzEDccpL5HzbyAByXa9v0HhlTTkZtSS1i?=
 =?us-ascii?Q?7ITOEaJjAJ0uZrLEOI/w8K1RsL5SWjScS3gJoGF5XYJi3m2giOtN6r/RUAvW?=
 =?us-ascii?Q?yGsO1CIbi/WE+f+t1oiPZPLV01GxtPWM9PWBxoZ1uNxzMPQiqWgSgOhdBUPS?=
 =?us-ascii?Q?SCp8e03kKKP0JiDN312I/4HO5tSkZm85K/SgUd2kBbXC/b48jLkNzLr9XEnN?=
 =?us-ascii?Q?LOO+0yJrbezVPoSX0yo/RGXlqGnpS0Ul2sZYeHFLTVr9nbt9SbCWEWoa88gH?=
 =?us-ascii?Q?ODwdZf4+EM1f3e4lgXCUTLP+zZcOfYBm60NXCeeken6ogVzE9KNw8i0QrH+m?=
 =?us-ascii?Q?4dgSiAQ1kyQsP//0VA2rK2yOahBnlaupszHTn3+Hfi22ypicW75Q04oDVjv1?=
 =?us-ascii?Q?sUbwZX1CrHMne9i+WHVUBZnxHuwZfp0QUXsWGYwC6ryqRHDs9k7S258sma8E?=
 =?us-ascii?Q?zG718PQiS4NciBfHRflXGTQXKFItHTKxCZZFZoO2RPPqVwSFaqqEpcsV8r2j?=
 =?us-ascii?Q?X15D+09nx/8j0x+MOzcEQdW+Oda7RB8vt7uTqzMDAMrfFWoGHEfa+iYY1Coc?=
 =?us-ascii?Q?ODxZQKJDGHO00JdV89rCwS4IXQIUJ2gHHfJJMmK+9fn4u+I25EXrTDpYkGF/?=
 =?us-ascii?Q?ds680rO8M3faXcv8qNJ8+T8CPhJamupNsz/dgO1EVaxPqZ5cgUDYDukMGnqn?=
 =?us-ascii?Q?JQtSmdz9mvNNtyt0e5CnaM91hav8aA+U?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN0PR12MB6032.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(38070700018)(7053199007); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?g4CbJLkad8I9zxk5NQ/B7Zgcw/FmbKNWLiwtBko72yTTLfoKY8HIL3nP1Fau?=
 =?us-ascii?Q?UmU3Bs7CCH2cbXBD3o2ZogAm4QEk+encKdfgK9eej2CsxaujbvtUELjj4VQN?=
 =?us-ascii?Q?Ttuw2I/SfZ9Rgob7mtLvNb+/UnsFL8oNSiP7p7NrSPiuOM3tug3An8QWUu0s?=
 =?us-ascii?Q?/VLvigaSzjgJCt2ph03RFbTtgUMv6Xy1IVC2SbyrCmS4eQFPRY5iMNIrtxUa?=
 =?us-ascii?Q?VmujfyAEuuNlqEbTKeJ1QZJe8GHBlFQRcYZSnXPmKifsn2aNryNjk83CtcUq?=
 =?us-ascii?Q?0herNnNh/eZyfZOjAEzkIr/i13HiJmS2xE/k9hJpFjUXuPnBjcwIirdXWE0l?=
 =?us-ascii?Q?w+9F44pKO8V9BEbcsCxuBZlCs0geNbZA5XYKqPpwUMmq0adicwQVegsU/IXt?=
 =?us-ascii?Q?ejn0jreRQhKa2Z39K44FbZ07lTL0eS/RKyopkxXlaPdOuWzJpsWy0xQxQ5FN?=
 =?us-ascii?Q?2hjfbzjFCdjAOMMvDWJFEA4R9UDZd+t0fl5OXn0T5pk5ZNX2MT8a+AdDGQgX?=
 =?us-ascii?Q?Nb/Qcag8jSvQtAqFyiZLKc64imCMTRnEFrEFoV0REUd9Na7s4tbqWHlRFX9l?=
 =?us-ascii?Q?eK67y6PxsXPcEUW+fdnq2d511+6unYHb6pSEwgOgLVLfXhqy0d+DsweVoCM7?=
 =?us-ascii?Q?wmytKlY1QreILAthsLsUcbpmAPSaGu27sN1PFWbTwevIEAt6+sGBV449B/Ri?=
 =?us-ascii?Q?Z9h0ypAeYDUuEczZEUQr86EPeEANhL/ZNp9L2nMC8ZFRcf/Oh+NNfTnUCozc?=
 =?us-ascii?Q?NCbbXDTbnXhOUamlfM+iJl5McQSVg1gXwPJsGFtJPzQaSTAXRxyyYZO8MCS5?=
 =?us-ascii?Q?cwxIWE5yizTBJsEJEiqFdGRIw/caaMJvxMi34811GCcFCqHVU0GRv6nhoWH7?=
 =?us-ascii?Q?gdmhCPoluka0SdU+qNwrpTDNkYbC0NGHS3iAWqmejvk15oCMIJKbOJ7uMjbQ?=
 =?us-ascii?Q?UjeBUTrQyZ1Kx1JIr2MquwXBEkLvA0uxqelummaFp41+uQl51ee0feVNVze7?=
 =?us-ascii?Q?xTzheTtWGLoK/MTZOLVKFCzXng1YEjJjRzrpRE9aqSwztODkFqUu2YLUYQ1P?=
 =?us-ascii?Q?VnhC1lTtwNCVkzNRysVBIuufUY52ktvGhgdqhJ+fK05Elrmj8osAf3PriIXe?=
 =?us-ascii?Q?9HavmRfZX7KApRmcOmC6DGtlPCgUvPMexBK0tdWCZxx2qDJsl37Cjz+V5sPt?=
 =?us-ascii?Q?wn6rgPWQe486DzK1e75QVgP6bmob9yc9bYuyGwYmc6nrOjHs8F7Ey4L7UmW/?=
 =?us-ascii?Q?o103f/pQn1kgYWD2AY6CWO5G3MRDQ3kXmX9LMGt1UvkBtPcllk6odeipw35Q?=
 =?us-ascii?Q?HSL5sdFbsogwfgXlt//4KqxqZxJ5wJZHloH0KLWiFBuSQXKQgWH4JDUwWnaz?=
 =?us-ascii?Q?ipFfyYpMjbgufbHB8e/o/IfIu9+Gulqp3C3rdFqHmNRQQZ5gCMJ7Ua9O4jdW?=
 =?us-ascii?Q?Goe6oHLpT/oFcZB6wkQxU1OengYEiyv8q7cAqDAz8+PN4VFyjydL4DsiXiwx?=
 =?us-ascii?Q?y/SprswmMURMJOMM8g9lKnR57WMTu7m4HUlFntuvXnMi9uS9mWZO3P0TnYk0?=
 =?us-ascii?Q?CTJb6yfhQxiSTjigxk8=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6032.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fa9bb09c-2e34-4186-f92d-08dd72b28bf9
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Apr 2025 13:22:13.4427 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ATD+tHs3CgsDssNYhULJmj9D6SiWxLBFlCo+cCRAWqT/D6/GH8Eo8b2+xkP3qhZ1kuysqPVYETufGR1wd8Me9Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8930
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

Looks good.

Reviewed-by: Ahmad Rehman <Ahmad.Rehman@amd.com>

Thanks,
Ahmad

-----Original Message-----
From: Pan, Ellen <Yunru.Pan@amd.com>
Sent: Wednesday, April 2, 2025 10:10 AM
To: amd-gfx@lists.freedesktop.org
Cc: Skvortsov, Victor <Victor.Skvortsov@amd.com>; Rehman, Ahmad <Ahmad.Rehm=
an@amd.com>; Pan, Ellen <Yunru.Pan@amd.com>
Subject: [PATCH] drm/amdgpu: Enable amdgpu_ras_resume for gfx 9.5.0

This enables RAS to be resumed in SRIOV after gpu recovery on gfx_9_5_0.

Signed-off-by: Ellen Pan <yunru.pan@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/a=
md/amdgpu/amdgpu_device.c
index 90c2bc473cb3..07799917b9a6 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -5369,6 +5369,7 @@ static int amdgpu_device_reset_sriov(struct amdgpu_de=
vice *adev,
        if (amdgpu_ip_version(adev, GC_HWIP, 0) =3D=3D IP_VERSION(9, 4, 2) =
||
            amdgpu_ip_version(adev, GC_HWIP, 0) =3D=3D IP_VERSION(9, 4, 3) =
||
            amdgpu_ip_version(adev, GC_HWIP, 0) =3D=3D IP_VERSION(9, 4, 4) =
||
+           amdgpu_ip_version(adev, GC_HWIP, 0) =3D=3D IP_VERSION(9, 5, 0) =
||
            amdgpu_ip_version(adev, GC_HWIP, 0) =3D=3D IP_VERSION(11, 0, 3)=
)
                amdgpu_ras_resume(adev);

--
2.34.1

