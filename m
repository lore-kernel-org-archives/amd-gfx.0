Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 40193C5DF81
	for <amd-gfx@archiver.kernel.org>; Thu, 20 Aug 2026 16:08:11 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B8E7B10E21E;
	Thu, 20 Aug 2026 16:08:10 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="F36+e/ko";
	dkim-atps=neutral
Received: from BN1PR04CU002.outbound.protection.outlook.com
 (mail-eastus2azon11010006.outbound.protection.outlook.com [52.101.56.6])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E22D410E202
 for <amd-gfx@lists.freedesktop.org>; Thu, 20 Aug 2026 16:08:08 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=e5Q684oODkcN8Znnbci4xHDphUdmME35nOr2bdWG5w/5QUaZSIOox7oJ+SMRlbnpZ2mmPyVy/Xw5U13IVDXsrJttscrvAsews9fjQtGHvu1WQh3c/Mc0ryZwxHMiMNbyrM1CWEVUJg3sMgRcmq4srlM4/jbySKGkUGng+8WFMYr2tiLLFo9wndPFGBDl8oAscYzNRvIYcE5YZYBeoiRQakdIaW4Vfa5nPtO0691E04wck1Vqwb3WIKCf/roLwnUhs5/f4DekKESA+yjdJ1Fvx/QIPPtg/tA7wBlUKwiSllC58ouWm6eburysh8F5O8+R9onGbDt80wtACFpr3HTFAg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Uybdr4Itw30mTaPJr9T/AuRevhEE+asGgaX7D2t2gpk=;
 b=Zf5CvvlpoOFSDK/qnANaGYTUioIaVz8+4U4a9nyz0jC7iBLuEP147kG5zVIWlTQdH5L3sU/tfZ7Z3G8MiPK96OtP9BHMizygFUSy90sfS3gR3/kUPRU4vtz3yk7pngR9MA1ZqYhJm3zzGx5f/j+MrfpnGfkliueiK3SXTP5OYayPyXGwDf+vV9l/ja7FjVDOIn67Nc4xjEJhk/v74NoB/N0wg7+WmTV09woKsl6Kx3KsNsVROilkbOwmvI74/eppqO77En4U7z7tEsO563/dnVRgGVJXzETP3RcC9UMV7OlPzJZ43vCH90GSwW1ILTmAMXkHF4tnGu95sxnrGMap8A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Uybdr4Itw30mTaPJr9T/AuRevhEE+asGgaX7D2t2gpk=;
 b=F36+e/koXOzBwhpSMevKuXQsylvcJch7X4m3dLkvkNGXa+hw4CNqCWaxRRYULwcdhUu6s14I7Kuf4oUb8D5AG8Vv0BwBCjGoS0sdBqZ9MFr7dtWtdOu6LxG8ajBffUqPI6l8AvIEO7mAwjNXZ9F8S8cHst0r77VZ8aj5tTLDKnE=
Received: from BYAPR12MB3192.namprd12.prod.outlook.com (2603:10b6:a03:139::14)
 by MN2PR12MB4192.namprd12.prod.outlook.com (2603:10b6:208:1d5::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.339.8; Thu, 20 Aug
 2026 16:08:05 +0000
Received: from BYAPR12MB3192.namprd12.prod.outlook.com
 ([fe80::b4a2:3223:31a2:ab7a]) by BYAPR12MB3192.namprd12.prod.outlook.com
 ([fe80::b4a2:3223:31a2:ab7a%4]) with mapi id 15.21.0315.016; Thu, 20 Aug 2026
 16:08:05 +0000
From: "Zhang, Hawking" <Hawking.Zhang@amd.com>
To: "Liu, Xiang(Dean)" <Xiang.Liu@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
CC: "Zhou1, Tao" <Tao.Zhou1@amd.com>, "Yang, Stanley" <Stanley.Yang@amd.com>, 
 "Chai, Thomas" <YiPeng.Chai@amd.com>, "Liu,
 Xiang(Dean)" <Xiang.Liu@amd.com>
Subject: RE: [PATCH 3/3] drm/amd/ras: keep reporting the socket id in the RAS
 feature mask
Thread-Topic: [PATCH 3/3] drm/amd/ras: keep reporting the socket id in the RAS
 feature mask
Thread-Index: AQHdMK0B0nV1sMA2CkOzURoGWpDFCbanGqFA
Date: Thu, 20 Aug 2026 16:08:05 +0000
Message-ID: <BYAPR12MB3192099B95CBBA7C724DF7D6FCA42@BYAPR12MB3192.namprd12.prod.outlook.com>
References: <20260820140454.1340848-1-xiang.liu@amd.com>
 <20260820140454.1340848-3-xiang.liu@amd.com>
In-Reply-To: <20260820140454.1340848-3-xiang.liu@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Enabled=True;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SetDate=2026-08-20T16:07:25.0000000Z;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Name=AMD General
 v26; MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_ContentBits=3;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Method=Standard
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BYAPR12MB3192:EE_|MN2PR12MB4192:EE_
x-ms-office365-filtering-correlation-id: 167776f7-c532-49f1-254a-08defed53819
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|1800799024|23010399003|366016|22082099003|18002099003|56012099006|4143699003|38070700021|6133799003|11063799006|10067099003;
x-microsoft-antispam-message-info: NXop7/92MGpInvdmsQzgi6Ri/Qvo967wGwWvW/lGsCWxfqYPEVrI3m9xzqRkZRmWkvd1h2oqynQ7iOTyso8RD1R3MQufCoQqapAQLKQYZHPfR74d+Xr5vQWuel4Rh0D6HYUPB+VEe94PHvo9rLW9reRXs5RfnBuIb5hvcJqAtBadVtdyiOOb2fK1JXlFBlnNzvpRskxTvI2j1XItynEdjf4+xUlgcD3mRvQBM1hOc0d74Rmh7qKS0XSQy+90E7Dt8L+f6QRuE2+ECjSdapkP5ERNX2bpUN9ysdZ+UvOZNLLvf8o3SU3q7I+kWxCXqp/tP48IXzAjAc0LPVGtnmwChTgfQ43RaDlFSJEQykwSkeA00vhFef7GKHLmGG3DZl3qEeeCByqvq0+KJGiSLYz7UJHx8eSxogMjJzK9IWt2ZziTI+4Fucjhj1ya19kFVC16QgJRbvJnrE2EYxIxKiJS+RQQH3y8Oiw8mUyrI0CgalqdLtbDnNxrZHyEniMCFNI5lLuguEHn7hqkpOcPUeFVB5TtJnVfum71mYXTnW7mYtMYvgmJ/5puJewo4tDc/5vlLvFWLCjmQXuZqrPz6RGxtzOQiXdD/W4tJAsPIJ8AEEcxTM4ml9vbFzUni6Kd9l8ssgnoZVgGWuOwITBhmVyHu57UxLe8iFwjDmFr2NaV8HGq4l678n/OmSHuWxNnBNJqNHq1X7+xU2Xh5c7ifL3xM0niFeDGBTMFSI+SvvKmVYM=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR12MB3192.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(23010399003)(366016)(22082099003)(18002099003)(56012099006)(4143699003)(38070700021)(6133799003)(11063799006)(10067099003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?O+B4XzMMuTWKbhse3jM3mJ42KVXCKWptQAY0mIrimLeQBwavrxgLuH/wfCWz?=
 =?us-ascii?Q?Nmv1jU5n0bDl8y4DipxLt+zFGvD2aI7vGidzPAKU+I8qri6n1N0L9CC54zdW?=
 =?us-ascii?Q?jZUs+t5ZNeBcdS2aZXO6Dl3ifK2IKKT5cAeDdSoqlkSiqIUcGdouxNNfDYPu?=
 =?us-ascii?Q?o+kQStyN/gYi4oXZxyZvoIW4oo9QTDGRMUgwaljGtfI+ynIVJH9pSsu2fk49?=
 =?us-ascii?Q?lYvms43T46ioPXjnQGsZl7L3+MkJfHyuYkAuFgdsWkvItpzC3jcXRvrZjZox?=
 =?us-ascii?Q?F1V8d/3OjRyri034IPZQwqEAd7EJduJKCDkRq+5JDA0mxHFdhx5rPaCWQkW1?=
 =?us-ascii?Q?QR7T3bdByW4FOZx3Wiizrtrb77peliVu0jTvbvgxKXkQik28mQhsgd9Mv1XU?=
 =?us-ascii?Q?2OwtWS9CA9DXBVZQlZWW0xOv+iwdl641No163AxNYRmZNYd2/FGnsPF2ul62?=
 =?us-ascii?Q?ihXqBHcGF20iqulElIcNrzf8gu84flrrQBUf3/vatB0Ca9V+l7C3Agfi1X7m?=
 =?us-ascii?Q?OxUq5bKA16iqjkV5kSR6zGuSTYH+fMQBmQ6CZQsWOwIavY9EOqosPe4JpI8M?=
 =?us-ascii?Q?KYYNoyYt9x2mwBaXgkEoL9wONwgIISHTwLF49tGgjqfwKap2hTTrzqiKBNbT?=
 =?us-ascii?Q?zlLwrHM+o51/4iSQYZ8IOlPkZLBd6+qnpk0UVhNRQpMCvW5osiN2DDtn0ptb?=
 =?us-ascii?Q?cbsndxiCgVQ6gHeOZltXQCm47ceLgnZ19BoZUR/vsUKMieIF2VXHnZvxTUKW?=
 =?us-ascii?Q?w+RkfXx/IRps4rT/GGqcv1eLvhJnr8qK8gc2oZfscuAM0X/ka/zmxkvbOld0?=
 =?us-ascii?Q?1LLCRH34x87w2BxaYE6R3X5daX8egXNLCO9lk+hPN730zMsPXDEsYfGwxe65?=
 =?us-ascii?Q?cIW/O26eganxoemLn9HydEl0NZPp28ajwPGYGb4pkekTFYaXnW9+KNtXt+O0?=
 =?us-ascii?Q?XSnnQDZM9QI0Xf4A5PjmpBslHbXHV81r1QbNgF+rQcT9SjnOpUf0+BXsje3u?=
 =?us-ascii?Q?PWANU7nCHjmhRlexYnl/CVi+t1Im682coH86zLTrREoclTwYbhQq1h/heohz?=
 =?us-ascii?Q?UBSJRqPR9CRbFQFlEKrrJ75xrmk1SBaM8Pt0qzSlXDF35ybi4Zz5R1D/R/ry?=
 =?us-ascii?Q?Eoy7ANrepB8PnJ7chOJdWqSOe7d5G9ZGCxgbZ4Hf/vRo3A2lb7HngPs6M8tS?=
 =?us-ascii?Q?djWc6N/CybUctGVv1kjF1N+7F504vq08AVKvE84SbU/fsA11KAfi0b+IFxz8?=
 =?us-ascii?Q?OBUlcXyVPU54wIvmYVOlql+digcix2of6sALp0MiBFXczPkmjbzuHS+ohyDf?=
 =?us-ascii?Q?TH8zga2JSn2+5SiDoZA3ebe9SK/4MvDxiLzeGnAwVBfKIiSIv6ER5KszLKOi?=
 =?us-ascii?Q?uGSd5qGz6GhFnB68ST0B5zc2MA8C8eiA3yYkQCmGMud8RyzjcUDuH6nPHQij?=
 =?us-ascii?Q?ZIxz3GPVt4VoXTYPra+IpgwCbfTDlQ/m4O8pQolUin9z99NYf5M9vbX17N4v?=
 =?us-ascii?Q?ficNF4CJVI1ccJr1uZ8VTyBRkMMV2yCQOzyYujQnjoQgGHWiPjlyF8cn4fzf?=
 =?us-ascii?Q?N+fReyw5yUwHjIXzvh++JFZiC9Bino3TjW10SIU0zU0sWVnrruyv1NPeA+Pr?=
 =?us-ascii?Q?v6Xp9byaKEYN/ye30X4QbdLapgvtVaj0H36414mIe2qqvKW2UoLy2iVq/QIz?=
 =?us-ascii?Q?PQu0rvCiXO/P6AdBPi34gJ33dC6xpvMS/bwFqoCkkNsHX8R8?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB3192.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 167776f7-c532-49f1-254a-08defed53819
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Aug 2026 16:08:05.5390 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: nciBYEiAr+7aTi8yuRtQV3/JsiLx4mSL1n0PRLaAiOcWjMb+Qr69TeFRmr+yVwjK8AAi9WFgmUCIzhL1EggB/Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4192
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

AMD General

Patch # 1 ~ 2 are
Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>

Patch #3 is not needed.

Regards,
Hawking

-----Original Message-----
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Xiang Li=
u
Sent: Thursday, August 20, 2026 10:05 PM
To: amd-gfx@lists.freedesktop.org
Cc: Zhang, Hawking <Hawking.Zhang@amd.com>; Zhou1, Tao <Tao.Zhou1@amd.com>;=
 Yang, Stanley <Stanley.Yang@amd.com>; Chai, Thomas <YiPeng.Chai@amd.com>; =
Liu, Xiang(Dean) <Xiang.Liu@amd.com>
Subject: [PATCH 3/3] drm/amd/ras: keep reporting the socket id in the RAS f=
eature mask

The socket id of a device is exported through the ras "features" sysfs node=
, where con->features carries it in bits[31:29].

Reporting the RAS capability mask there instead changes that layout: it spe=
nds bits[55:0] on block bits and so carries the socket id in bits[62:60]. T=
ools that decode bits[31:29] then read block capability bits, which are ide=
ntical on every device of a hive.

XGMI error injection depends on this. The tool resolves a WAFL sub block to=
 its destination socket, looks up the device carrying that socket id and in=
jects there. Once every device claims the same socket id the lookup silentl=
y falls back to the first device and to instance mask 0, so the injection l=
ands on the wrong device and the RAS TA rejects it with RAS_TA_STATUS__ERRO=
R_PCS_STATE_HANG.

Only report the capability mask on parts whose tools decode the wider layou=
t, and keep reporting con->features on the others.

Fixes: 6ae383bdf282 ("drm/amdgpu: Support obtaining ras capabilities")
Signed-off-by: Xiang Liu <xiang.liu@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c | 13 +++++++++++--
 1 file changed, 11 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c b/drivers/gpu/drm/amd/=
amdgpu/amdgpu_ras.c
index d168e5d54d87..0dec6da3f1d3 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
@@ -1845,10 +1845,19 @@ static ssize_t amdgpu_ras_sysfs_features_read(struc=
t device *dev,  {
        struct amdgpu_ras *con =3D
                container_of(attr, struct amdgpu_ras, features_attr);
+       struct amdgpu_device *adev =3D con->adev;
        u64 ras_features;

-       ras_features =3D amdgpu_uniras_enabled(con->adev) ?
-               amdgpu_uniras_get_ras_caps(con->adev) : con->features;
+       /* The wide capability mask needs bits[31:29] for block bits and so
+        * reports the socket id in bits[62:60] instead. Only newer parts m=
ay
+        * use it: on older ones tools still decode bits[31:29], and withou=
t a
+        * socket id there they cannot tell the devices of a hive apart.
+        */
+       if (amdgpu_uniras_enabled(adev) &&
+           amdgpu_ip_version(adev, GC_HWIP, 0) >=3D IP_VERSION(12, 1, 0))
+               ras_features =3D amdgpu_uniras_get_ras_caps(adev);
+       else
+               ras_features =3D con->features;

        return sysfs_emit(buf, "feature mask: 0x%llx\n", ras_features);  }
--
2.34.1

