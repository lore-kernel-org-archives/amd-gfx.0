Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 735C3C433F5
	for <amd-gfx@archiver.kernel.org>; Mon, 29 Nov 2021 08:17:02 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E14606E1F8;
	Mon, 29 Nov 2021 08:17:01 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2067.outbound.protection.outlook.com [40.107.237.67])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 114416E1F8
 for <amd-gfx@lists.freedesktop.org>; Mon, 29 Nov 2021 08:17:00 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LmHQ+BDY/XkLKdEB2XSS0nlml3/atSInIjF96EaG1gZbXuoDDgUxW4rtTXZwl3UlKCFHGXNEqedKT1TBSZqK2t7BhFw/2FVkNnqxBSXyHWw9+u8cVxSzryk/aVCtTx3OSxJibYjO52LXGv2xS+MMF5pkTAErq2NROHNDCrkPopmsElJKYBGswIWHl9VBFVC2Lj+m+7MtKhaVFIh6YSlFMw7sCoaaaZzFAppd6qaqOt0dLOiuHkh40Pwga1zBc4svR9Tf00bbHU60rvFY9Zk7N5j+GxKFE6+MVDicssXl6ght9PDGECiJiSQglNzxy0CkvOW9Nzzew6ukSs4MN+uR0Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=drQSqepJsKUwFPoN6MTgvSwaQw7T1fJunkVuyp51FuE=;
 b=TM2m8OXPlxfhoLr4WHu7YUBKrLK6ETVfcyTeHsrLg+CEB4Q9P5J3h1LLB99mhmyV/KmzMvIpgU9twvtkpWbdi6GcJ8bwdbxXt/85jcdFuU3WlVwmOA9wCZ5AK4rXLlHCaGKBzVZHi1KIIU6reweo/GoILGyA8h35BccKPf3ANlNGB+9Hfan9rxlvwIBarhZGoNzL+VzbNmjf/YQaVzJgAsTqEGSv8ToX8qXaptg8OBJx0XzEH5riWdlu0CVzWZmKsINbIhbEfNHN/UFDqWPYnd4edHmR0O4XQoxDL70qVhjU2cSOV8fjpxcONQBrQ0/2vkBKSj0zDnaEvjYV87BKDQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=drQSqepJsKUwFPoN6MTgvSwaQw7T1fJunkVuyp51FuE=;
 b=A7VQXn1TI+ijlCEwrb8PaFi4DZaJA+PqPu4RUDoWMaTkO+EmIBlDu9JGMhebx4KIgdTOsfD6Kz2eSl6mUJA8SNRY/wrrm6nzVi4wOwqIhVll4Wt09WqBz3e0qjDnJWJ1/nnXdQQB+4cd1cLg/9AqmloLNV9ZuQme8fS3k/rZ89o=
Received: from BN9PR12MB5257.namprd12.prod.outlook.com (2603:10b6:408:11e::16)
 by BN9PR12MB5132.namprd12.prod.outlook.com (2603:10b6:408:119::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4734.23; Mon, 29 Nov
 2021 08:16:58 +0000
Received: from BN9PR12MB5257.namprd12.prod.outlook.com
 ([fe80::2919:f0f6:40a9:e1c0]) by BN9PR12MB5257.namprd12.prod.outlook.com
 ([fe80::2919:f0f6:40a9:e1c0%7]) with mapi id 15.20.4713.026; Mon, 29 Nov 2021
 08:16:58 +0000
From: "Zhang, Hawking" <Hawking.Zhang@amd.com>
To: "Lazar, Lijo" <Lijo.Lazar@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amdgpu: Don't halt RLC on GFX suspend
Thread-Topic: [PATCH] drm/amdgpu: Don't halt RLC on GFX suspend
Thread-Index: AQHX5Pjknsmpcqe4okK43a939BBRgKwaKN8Q
Date: Mon, 29 Nov 2021 08:16:58 +0000
Message-ID: <BN9PR12MB52570D4E50034BF65ECF9A10FC669@BN9PR12MB5257.namprd12.prod.outlook.com>
References: <20211129081224.156654-1-lijo.lazar@amd.com>
In-Reply-To: <20211129081224.156654-1-lijo.lazar@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Enabled=true;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SetDate=2021-11-29T08:16:55Z; 
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Method=Standard;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Name=AMD Official Use
 Only-AIP 2.0;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ActionId=d07c63c5-e6cf-47f5-9333-bafabc8ac7db;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ContentBits=1
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 90cb4422-92a1-454b-a9f2-08d9b3109cdb
x-ms-traffictypediagnostic: BN9PR12MB5132:
x-microsoft-antispam-prvs: <BN9PR12MB51323BB96D63E16E85D2BBD0FC669@BN9PR12MB5132.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:22;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: lmcJJTJSiehJ1XddYDIgzvqg8jhDJQ6zywrO4SQE9nluzspBCxVuhdZ5xAxtmSvwvYw54usDryMx634SWl+OOAIR86ZJnX7GgK5qWmEAKJdtqdPK0+vok2QnPvX7GIvvOrtTC2C3kbUWKMJdt/eIHOjFP4Qp+Zb292WMSKS1pfewpA9R16dCugm+xyr47nZiJp3yq+WQo2KoyVrHUm6i6WnEr4sajZZnW+eBpY6nBemfek4la/I8Zerk7ejgxSyHgLp3+Z9qe85sgUFWvdLmDekILcEqKVnoeWvio0g+ChFq2D4HQZUz/mDI8Aeuh7p2BQATx4DrkiWz1+vhZK5Xe+lQc3IiRuT5IkaZ/EfVYzX8qOzrJG8KDx0QhAPxmd70b5ONJkj0w7GU7xoOOZNhHfHM+LWunhVFxwvzP8ItHmBhlXvc76maHocFeJZ0DPhdGUuUpAva/FSEFpBiUlomXazVc54u6qulo4xv79vFsH4ORllF6zawr3xcLba2FBK8NhS04z/0DNl0+NWGZkhtJ0VTG9BPTkqaTVsbWHvaL/oEqOGs+YbFtevT4GJyd2vdaoaC+ncKr0aElAGHli3uQeyTVkv+ehJcVPV3gRJ81mqHYOK+7+FFj8Nq81SczALAE53x2U9EVj2T44K/nrs8Hc/F3JvRTSA9j689m8HRf9PRROVrVDeCjFIlGHFwsRRZhaEQpJaaYLTwmOUmCHL58w==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5257.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(110136005)(53546011)(6506007)(54906003)(55016003)(64756008)(2906002)(66476007)(122000001)(66556008)(83380400001)(8676002)(7696005)(76116006)(4326008)(66446008)(15650500001)(508600001)(26005)(86362001)(52536014)(8936002)(5660300002)(186003)(9686003)(33656002)(316002)(66946007)(71200400001)(38070700005)(38100700002);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?La/fOcoD7wHk8bieGFWe+CVkq2GMUA1EytfqymoWux0fMFAvxYXGKIelYX8O?=
 =?us-ascii?Q?x96G5k0CaPmUjBUmjqt6z88ji154mJOGDkZn0JqpwcpRIMol5HU8SImy6uCT?=
 =?us-ascii?Q?w92/5qpEi/ApVZzHueKjV8MB1xWiALFtHz0N9lURr1knfQuJRO3D6OQTSHox?=
 =?us-ascii?Q?iT0XdiFsoT5MpSfzEWUn21AEfhcRmbzIR/5lZZrtXGqvzbF1Z340VMutAHjm?=
 =?us-ascii?Q?J43eC1W3bF0F+KMExbytLM5HMUfd7WTkwqeJdwRz6eQ8Qs6j0LIV9bQpwusn?=
 =?us-ascii?Q?SJ9/5lr9PgUr6VAImhYxJ7bztvL3di4gkQGBT7zTIWrkaluIKLhfXqFKx6Mt?=
 =?us-ascii?Q?DS27bBYk42zZchp7tm59bMa277FLSQCZBEWKRbzWpuK9OnkJTmh6Gss0M2b2?=
 =?us-ascii?Q?BfVHKI3oCooGZmVJ6c/2Yurvd3ZeqSEx5NiWnhkhB/bJ3XK7XVLt0amS9WBj?=
 =?us-ascii?Q?FQGJWgA77DybkS0m3Ul8k+ryBhJrjOzm6WwfgoDJXCGiZOdGjIIJzTRS9e+5?=
 =?us-ascii?Q?IzP0XusVfmMMm7nIS5D0Ntbq5s2vbXCm8fJzl0YQtiawFTXexTOEpNWAQqJZ?=
 =?us-ascii?Q?lRoYxlK2efhQZKpXfqqfQ1os35GEY0Ej2BORy7okuASmok9nzvI9jGjdaP+X?=
 =?us-ascii?Q?PkeZuaTJJ3av2jCQZh1Fj5vwbSGI7kdMLqgjl5GmGUkGlylWAuOXsheOQQOJ?=
 =?us-ascii?Q?o4ItNAD7JJIxrD/L/pcM/PSvvFB4vkYaSOFiIwkODSOsT5haMZK8tXGFHz9L?=
 =?us-ascii?Q?haWGwCWDqk0+uPPEeoeVRj6iNTiE34KviNy6FhiXyXZc+iz7mscLbm4C02XZ?=
 =?us-ascii?Q?au+I7Ec9FB83lcrP4vzkJOYoehBxpETaoBiB0LXQJZAjodIqykz5PK/QT3+A?=
 =?us-ascii?Q?KVqlHV1g7BT2RfAV453MhXeX6EbzbUUcBSKzKPIdmOjNtd32y/pKGvxVuudV?=
 =?us-ascii?Q?eJ4Z4R7VvdIREoquWTeQHdUpSxah7fjZT4kGFCeWZmNeLIAl6uBcO7pRPncA?=
 =?us-ascii?Q?jrOpJcYwU/dljGJvnFSCUPPigB9kdKHlrcv1scxYSzYFOU+js3z++IV/HUaj?=
 =?us-ascii?Q?rMsfjR8KuwEPUuKSLZNlQNhKmNUqgd5vcLTOom92xnWFiXjC/mpE2T0CJzr6?=
 =?us-ascii?Q?uNNZD8d8GbZOxqNaYM/PYqMHw4eDaq1OxNKeUn5iaOvkYuOX2KlHXDcHcXbK?=
 =?us-ascii?Q?tDkI8mpSIAJ5pWj1tuZS+iviH2iLxXS3xsxFEX/Ib8yKrV6AvwwlGF1B2VwC?=
 =?us-ascii?Q?Q5u6lyJqG3KCNnm0jaDQNrPDI7EEUAT/Wg4Ecp8HKAoZyt6osDqjz3ltZFC7?=
 =?us-ascii?Q?rx8ul3HPJxE1qz0xe5Sh4sjzHkPODHBPV0zKpbeK7x9mV52hPgKxFUfIDGXa?=
 =?us-ascii?Q?Oqt/ChRrGMmjenczf5T8WY12djBaM200sYSN2t4zQfelmfsy2V/n/mEUzKFy?=
 =?us-ascii?Q?9jzAXtuSZYcXWhsI8FzSlJcUd5qobw2Cj8RenfA0bpg8U9pn60rovaJvp2Pb?=
 =?us-ascii?Q?cqjLXyjNSK/ZA/5J8doOYBCb/ZS6Budtm48g8l/R7A48gLFbl6ZoxYXYklYL?=
 =?us-ascii?Q?7Q4FVt653TunlpMhtseDhdRyfuGQzIWKSe778yqpgQZVeJMICpWl0bLupoNE?=
 =?us-ascii?Q?w2grMKQW9ix2XcqcsR8lfJY=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5257.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 90cb4422-92a1-454b-a9f2-08d9b3109cdb
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Nov 2021 08:16:58.0851 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: jMTvaJX0d+JTasNVuYcSoxEL5rsJWJl5f0+WF1DyLzjPCBA6h0pLTOYBCSlgkuikquLHsX0iJ8xd8MHR7CPn5A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR12MB5132
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
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Clements,
 John" <John.Clements@amd.com>, "Zhou1, 
 Tao" <Tao.Zhou1@amd.com>, "Yang, Stanley" <Stanley.Yang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Official Use Only]

Good catch.
Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>

Regards,
Hawking
-----Original Message-----
From: Lazar, Lijo <Lijo.Lazar@amd.com>=20
Sent: Monday, November 29, 2021 16:12
To: amd-gfx@lists.freedesktop.org
Cc: Zhang, Hawking <Hawking.Zhang@amd.com>; Deucher, Alexander <Alexander.D=
eucher@amd.com>; Yang, Stanley <Stanley.Yang@amd.com>; Clements, John <John=
.Clements@amd.com>; Zhou1, Tao <Tao.Zhou1@amd.com>
Subject: [PATCH] drm/amdgpu: Don't halt RLC on GFX suspend

On aldebaran, RLC also controls GFXCLK. Skip halting RLC during GFX IP susp=
end and keep it running till PMFW disables all DPMs.

    [  578.019986] amdgpu 0000:23:00.0: amdgpu: GPU reset begin!
    [  583.245566] amdgpu 0000:23:00.0: amdgpu: Failed to disable smu featu=
res.
    [  583.245621] amdgpu 0000:23:00.0: amdgpu: Fail to disable dpm feature=
s!
    [  583.245639] [drm:amdgpu_device_ip_suspend_phase2 [amdgpu]] *ERROR* s=
uspend of IP block <smu> failed -62
    [  583.248504] [drm] free PSP TMR buffer

Signed-off-by: Lijo Lazar <lijo.lazar@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c     | 7 ++++---
 drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c | 2 +-
 2 files changed, 5 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c b/drivers/gpu/drm/amd/am=
dgpu/gfx_v9_0.c
index 34478bcc4d09..b305fd39874f 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
@@ -4060,9 +4060,10 @@ static int gfx_v9_0_hw_fini(void *handle)
=20
 	gfx_v9_0_cp_enable(adev, false);
=20
-	/* Skip suspend with A+A reset */
-	if (adev->gmc.xgmi.connected_to_cpu && amdgpu_in_reset(adev)) {
-		dev_dbg(adev->dev, "Device in reset. Skipping RLC halt\n");
+	/* Skip stopping RLC with A+A reset or when RLC controls GFX clock */
+	if ((adev->gmc.xgmi.connected_to_cpu && amdgpu_in_reset(adev)) ||
+	    (adev->ip_versions[GC_HWIP][0] >=3D IP_VERSION(9, 4, 2))) {
+		dev_dbg(adev->dev, "Skipping RLC halt\n");
 		return 0;
 	}
=20
diff --git a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c b/drivers/gpu/drm/am=
d/pm/swsmu/amdgpu_smu.c
index ea99afb38d2b..5839918cb574 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
@@ -1474,7 +1474,7 @@ static int smu_disable_dpms(struct smu_context *smu)
 			dev_err(adev->dev, "Failed to disable smu features.\n");
 	}
=20
-	if (adev->ip_versions[GC_HWIP][0] >=3D IP_VERSION(10, 0, 0) &&
+	if (adev->ip_versions[GC_HWIP][0] >=3D IP_VERSION(9, 4, 2) &&
 	    adev->gfx.rlc.funcs->stop)
 		adev->gfx.rlc.funcs->stop(adev);
=20
--
2.25.1
