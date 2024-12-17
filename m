Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9BF9DE7717F
	for <amd-gfx@archiver.kernel.org>; Tue, 17 Dec 2024 02:20:08 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 482DA10E836;
	Tue, 17 Dec 2024 02:20:08 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="2ze4kIWG";
	dkim-atps=neutral
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2065.outbound.protection.outlook.com [40.107.220.65])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7C41410E836
 for <amd-gfx@lists.freedesktop.org>; Tue, 17 Dec 2024 02:20:06 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JYhGptZZvNqkYuzsLB7iKFAIBumG0nawv9dYvq1Ck3MlvZIOAd4jLl3g4VdDDmMD5fVfCCTHfBmp6jjVjMLKvaAzr2KMUlKF2j7LZBsPwwhiTC3b1K0RuC1ZhsoeriWc+OJy8Qd5Krv+ayBqiCTkqsllIb9jByh3VSNHM27/LBNYNAdgWpt1jVTnnfBjcGrlcH74/BBR7FFW/BxEzb1O/TN1/jaAr9Rc85/l8qR40mCCuj5ziujftfn0h1swndP3ADzYw6OibszDurUCdh9ksBQ0PT4qiP7DD00CGvzG3woxMtWGMP8hLILkx5gtsIkMfY1M3tHsYJdnNVn/XveEbQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jyOCtGxQVUCjLdol3IQrgQgW4FGO+XLUeT9/sG2yhBU=;
 b=cZ28ptLwBv5+1B3tkKWP0Io2lA54ZX64Y6nsEFXRWJM0Zwh5ogXg2C+789GzwSVyh3JlR9JAk47bnp2wXxOGZbaRCfwu/NaUVM4R8Nru0lagRY/p4ywdEOj/yn2aqTioxEloKmoADNqSnPyoTAPYUPpkAqr212xiFNyKD8+ZnpvSAJLljes20pN0fdp75MKM2/wnzwTcivM0bBCljj8FTZRJBMr83Yehv7NAc77LSWqcXbWztm2qOF5f8BoaHUYYecqoUclQ6INFkJvfkq8UP8XdpRnXlcGYP5claNCxPHVVMKDO5I5QtiVeF2qjcweHlXkT1uu2VWX/9Z7NUH99LA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jyOCtGxQVUCjLdol3IQrgQgW4FGO+XLUeT9/sG2yhBU=;
 b=2ze4kIWGf060pWYkZxfvEapr/zXZb3SlCskYxNt1Z6AcezYow5Xfr+CljV8nfOaLK3kOapHLF5JcbOMlU1tTc0r7BFJRKCDyq9gD41xZ56nP3gRFSJ91ybn+IfflPf6U7bCSZiqCI8yqx5wRXZchepWxzp4o4tby2ikSegA/I7E=
Received: from BN9PR12MB5257.namprd12.prod.outlook.com (2603:10b6:408:11e::16)
 by SA3PR12MB9089.namprd12.prod.outlook.com (2603:10b6:806:39f::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8251.21; Tue, 17 Dec
 2024 02:20:04 +0000
Received: from BN9PR12MB5257.namprd12.prod.outlook.com
 ([fe80::c593:f43d:c798:e009]) by BN9PR12MB5257.namprd12.prod.outlook.com
 ([fe80::c593:f43d:c798:e009%7]) with mapi id 15.20.8251.015; Tue, 17 Dec 2024
 02:20:04 +0000
From: "Zhang, Hawking" <Hawking.Zhang@amd.com>
To: "Li, Candice" <Candice.Li@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
CC: "Li, Candice" <Candice.Li@amd.com>
Subject: RE: [PATCH] drm/amdgpu: Enable psp v14_0_3 RAS support for non-SRIOV
 configurations.
Thread-Topic: [PATCH] drm/amdgpu: Enable psp v14_0_3 RAS support for non-SRIOV
 configurations.
Thread-Index: AQHbT5w9FY6WSgZhGEW7Wv9AO9wV0LLptQxA
Date: Tue, 17 Dec 2024 02:20:04 +0000
Message-ID: <BN9PR12MB5257F740EE13297EDAFD80B6FC042@BN9PR12MB5257.namprd12.prod.outlook.com>
References: <20241216092334.286870-1-candice.li@amd.com>
In-Reply-To: <20241216092334.286870-1-candice.li@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ActionId=8d83395d-1628-4f25-8fe4-842e1e2bbd56;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=0;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=true;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution Only;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2024-12-17T02:19:43Z;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR12MB5257:EE_|SA3PR12MB9089:EE_
x-ms-office365-filtering-correlation-id: a34bf3d1-1da5-4814-c678-08dd1e415183
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|1800799024|366016|7053199007|38070700018; 
x-microsoft-antispam-message-info: =?us-ascii?Q?Ji9R5BDFi8fvdIDGG6qHsSwj3hqgCv4aqdQW/q4axurEAOoj1b6rP8iT6gtn?=
 =?us-ascii?Q?RZEeQ1OA5foIZxeJ+t28GTonrdpqAq3MTGKEKIpRSLUA6qfEzT8esA/j/LUO?=
 =?us-ascii?Q?1ieaiQM/dXpSL+Z1ZvtGPgSasa8MsmbNOdMxyPPt1gPLud2oSvX391bDm333?=
 =?us-ascii?Q?ZnYovjICB6FCbIfOmlmmF0Hqz/eAT1XmbuVD2Dgq4pXOTjdcikLm17E+BG7R?=
 =?us-ascii?Q?lVt607Rm//WMKA/yp1QzudeSeFg7x35zCxSRZJy7zh9tXcdx28xlSpavXRTd?=
 =?us-ascii?Q?HtqUPUOd0PTZAoorcJB4iEMb8BUAc4hUzjvSCuN06AWZftA35BSBOCIbIc2f?=
 =?us-ascii?Q?vBZAFywpHWnRV5VHAQyFMhq4CHaflhOovCiu7MX5DzJqWCOtJybicon4D/IX?=
 =?us-ascii?Q?vS4+GqtsBBzuBCuqIKWz9ZZ7u/XH/NGncZSpC4lAS9EjCBs2ra5sc1B5tavv?=
 =?us-ascii?Q?xhfgatBpFU90ZnMY4hMwTKRhkqd1Oa46VW+v2WAPVIO6eCl99sJ/F/6lzFhE?=
 =?us-ascii?Q?Ye/wlZd7sMg3bOi+ySUY8BU6JMYyX58sN9FDz3Q1MUruodYXrZWll1p/M8n0?=
 =?us-ascii?Q?cdFG7okiWoXW68rYFOmuW2P/4GZglYJOEx5RjuZ0jlVpXvSGvvQ34iKJkxJo?=
 =?us-ascii?Q?k4n/W/Zg/LLZ19adhXs6ddUG7nGdw7HIG+7+FR1qtQwcB+aPpTX3HGjIceIi?=
 =?us-ascii?Q?jmkkgL3Y6RXYi0lAuV0hV/YHsZizorjF3RfcncSsCZuh91xGMoA99MONqhof?=
 =?us-ascii?Q?rKPOc1EDqozelSdJHm1vakCiyO6iL4KjKLb7agRzVSQq0J6JZWIAQYy4X104?=
 =?us-ascii?Q?BXVORlkS6Z5Y6QZFVgMehOGSHwt1g+p8G+vAfygWuUQtEJ6mH0knFPyDm0T6?=
 =?us-ascii?Q?mwjWTAOcnkaCU+l+hxpfpoXjMQ/wmbKI0T2pX0WAqJJSSjN2mDHEYRnBtgSB?=
 =?us-ascii?Q?GeSeXugQAH6GM6rn7yFxeGQttMYY3QrIB6BYgQjSf12cq0+MD0aWQutwh3vB?=
 =?us-ascii?Q?lXBBqUYHo3JI0l5jWCiDbAngsQqAWpuePijHF4zIxpOw8GT4hLwo2fhQ+da1?=
 =?us-ascii?Q?U7X7SOGqf139oQeiT9J3psIbtAmaXL1SBxoNd6neXjY80d6Lkz273I6Z8DuN?=
 =?us-ascii?Q?KGE71VhyEKJVQX8ksyjN8Oxg4gz9UK/UWIBohnVQ1wnnTkh9uhs19thAYy2l?=
 =?us-ascii?Q?9dUxp/j3dtI9OnfJlhDTt7SsxLw9naiIJcJM97M9uYpI3K0xLHYTBCcwnJuw?=
 =?us-ascii?Q?mJ0tOvuXRPkbJ7I12DiqYcjpgk9gUc3eXY3E+h6CtmEH4TRKzIqq+wadogHq?=
 =?us-ascii?Q?IJhBqdd1Cm/9rLZj9Mtq6N6dl0hkf7ZMcs9o0TusN9h/JlE/X6qvM7YUzU+7?=
 =?us-ascii?Q?Gka3Ov8GS/EAzmX1H9VxYApkeBYfDB0iNZs+CMglfA+KtN1GdSlRmDSC3U+0?=
 =?us-ascii?Q?J2gKzEtuGxJcmneX/ZW7LOnWQ3XtQt8T?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5257.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(7053199007)(38070700018); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?qGpD09SDdsQkTo+OKvS9/RJXiakHiAjcndFK/wJ6lHN5KWusP/VyPzyVHtt4?=
 =?us-ascii?Q?h9a2AUl1w2+t2W3oh+NpZkziUlJagAhZ6guudECyA6oQ4DbvF/AQjyTITlss?=
 =?us-ascii?Q?62PPYm2QuFDMm/X4UPrJ3mHQMmuJpRvs6zbIwP+oAQf5M2ddXt5bJnRfNHvQ?=
 =?us-ascii?Q?Jcw8nMGsO+Ul3S66fDZZNBf01gqkN7vApUm+0dyT8QvwokKw3nb6XnCf1J+H?=
 =?us-ascii?Q?FgkGCWe+99PL0Y53Txrsh7gkrClh3QqdChEgbGmxzCM5dMwrHN5W3xAETF1e?=
 =?us-ascii?Q?aOYr3SpPhH/dOSUhX6uyYD2gbBjPKNLUS5UwaqozKS1YSINvwt16Q/IY84qK?=
 =?us-ascii?Q?D5bBpXjJGl/swJN4/XhhACcHQ1LvK/FUpYKG85rfPLgIGzbGKB7P3S51luvz?=
 =?us-ascii?Q?+B3QzhIqDJGd6PMdWw+dqdK+PUrYOODOdpKuv0Q2eS2qNEediDAzNWiBRrZ/?=
 =?us-ascii?Q?sPa5PlHfa+HOfUw+eSAzgBzDIKx8kNuNB92dxpsWri8aGhWOOxr0i4ewWH8v?=
 =?us-ascii?Q?x2tFXqGBj7lbNqjXlJsVtL3tnex0lOhQWq8V6/WDCG/sFnt2DeeDDCZzjed9?=
 =?us-ascii?Q?Ki7GcYO83AohQuyaMrZ2xaYuFVPoFa3B2jsoON0xp0a24h1UNqPbZTK5scPH?=
 =?us-ascii?Q?be+dmPVOyrTLoCSEuP0PZk2KRYdlhJIFTeSxqxouQ+MgA5uPLueB5WsMZiPJ?=
 =?us-ascii?Q?/6sKHj21ppbMqjvKhX6/xdIlAug5lTqoaHYkCB+OgfD7eni3Ka56NYOdrcPY?=
 =?us-ascii?Q?QxT/B3TdPkxb/RMKEpOwssB8cj6zW+6vcvKYa1mexdN1rwATc1ekZtN3CD98?=
 =?us-ascii?Q?a2Gm0nTcX3lWZvdWWjLaZdqFrdUEOy7qLEi4H2FqG4f6+GQ9bKNCp8lqjiUT?=
 =?us-ascii?Q?VwyOjsUGQE9kaxxSLgpLwXnWrEkJyMmtT7qqCVrweBaR8k7hxwKgIVx0Uj5v?=
 =?us-ascii?Q?jv1tRno/mMjIDv1uvG7KJ+imqvUyhX+1pOTgZXv5H76UzxxRyqir2rAz4+Dx?=
 =?us-ascii?Q?mvySNz7z0C48UG3dzv48US9YlIk3nCpSzrKQdS+qjjqDGt9g9dWzS0xcTbAx?=
 =?us-ascii?Q?JKtJhhOzgnI7LXW1ZbbRcY0NPGtSs992vG5wbimpDEhAXAFp1YJ134nagsdQ?=
 =?us-ascii?Q?GMhRdndb+OMhhqPj0adkA4wO6AQh2mFh+8lzYILJlDCWQCEHpX+lLtAtO6sk?=
 =?us-ascii?Q?tZwL2SF0BU3Ja1XiV1uT2ALQbLQjG98T3BMQAv8sQ3vmmefPhmsCwhkq+Th8?=
 =?us-ascii?Q?nxBIfbmQm6KQyED/sTR3t1S2ysCULlCyq3VGbY2vf8rgBtx+JUlreCVO7RXL?=
 =?us-ascii?Q?kA2N1lbNiJjef/SDSfQMOihGR7E+XxtsFJgxUbMIlj7gEfk3KdEx/DrWKOHh?=
 =?us-ascii?Q?ZKn9k2vFXYsakipsqPYWZiSqUPdImQ9m53G+pSebxL38Pm+aWach4henfNxq?=
 =?us-ascii?Q?BoQjh2QrMTUg7JBEBGBPCov/n1+fBNOXd55vO1Tw/qKottCBcJfehCZ3Zk6R?=
 =?us-ascii?Q?OlxLDAXW2//FzeYI/xoo4CFsqezyd4WzwmyEOJJUk9/k8SpaWTY3ug+JaJjZ?=
 =?us-ascii?Q?UtjuMlJxjSSbBf7D8zlIIS+2nPKS52NUEI5P7KJz?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5257.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a34bf3d1-1da5-4814-c678-08dd1e415183
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Dec 2024 02:20:04.5527 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: EaqwwFjw3ALo+lYaqIYwe3d06tZ4Sg822dOcAENjIc7te0nC/07MmV/KIqSV24IIRC7S4gPLiSVqPG1kdiZduA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB9089
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
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Candice =
Li
Sent: Monday, December 16, 2024 17:24
To: amd-gfx@lists.freedesktop.org
Cc: Li, Candice <Candice.Li@amd.com>
Subject: [PATCH] drm/amdgpu: Enable psp v14_0_3 RAS support for non-SRIOV c=
onfigurations.

Enable psp v14_0_3 RAS support for non-SRIOV configurations.

Signed-off-by: Candice Li <candice.li@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c b/drivers/gpu/drm/amd/=
amdgpu/amdgpu_ras.c
index db081618e85c3b..01c947066a2eb0 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
@@ -3572,7 +3572,6 @@ static bool amdgpu_ras_asic_supported(struct amdgpu_d=
evice *adev)
                case IP_VERSION(13, 0, 6):
                case IP_VERSION(13, 0, 12):
                case IP_VERSION(13, 0, 14):
-               case IP_VERSION(14, 0, 3):
                        return true;
                default:
                        return false;
@@ -3586,6 +3585,7 @@ static bool amdgpu_ras_asic_supported(struct amdgpu_d=
evice *adev)
                case IP_VERSION(13, 0, 10):
                case IP_VERSION(13, 0, 12):
                case IP_VERSION(13, 0, 14):
+               case IP_VERSION(14, 0, 3):
                        return true;
                default:
                        return false;
--
2.25.1

