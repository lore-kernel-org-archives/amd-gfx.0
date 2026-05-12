Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 92C19CD4851
	for <amd-gfx@archiver.kernel.org>; Tue, 12 May 2026 15:47:28 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 248A189EBB;
	Tue, 12 May 2026 15:47:28 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="0Yahj6LD";
	dkim-atps=neutral
Received: from CY7PR03CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11010003.outbound.protection.outlook.com
 [40.93.198.3])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AB8FF89EBB
 for <amd-gfx@lists.freedesktop.org>; Tue, 12 May 2026 15:47:26 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GYfEwqC2D8ME0O1HV4vSZBsETAGBbGinBXICqqJAiefs37EyZLzqNVWiHaTsn+9evelA+gS1uKO+CuQOCPdK9K7voc7AYgmL/vp8uTDGFCjQK1J+cwS8jTVp519WwFX1XiI2qa/+M9OcLy1rqsoPe/NAt9J+5GTQzV3z8MUwRbcO6QIDBUGVTu80dx2RpMEap4u7j29OOaAcbqvuK1gG6xH9xf/JR1DHGAWTB4GQgUYXsocNuVXEJG3VuXResGsWKdT+80Hum0Gsa3Ieq7FAj38DZYBj8AUIVSFa237dcDWdWKKKjtg+xu6bw1CcOjVGkcHMotM0NIR0+6ymBMgtAw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FOOikasyaM7X4Sg3dLIXfy83O/SGHBSL7+bK4QeH6kE=;
 b=HqZWGCc/1EbWVB91QcJytuMYJUo5KJLgGAJ8ATSTBvbwyMwKNtE/baX1/NhncUr8gAmG66bZGNrMQx3my3Yy4CUdG+j8dFr049RK6RFPwc0Q5R5BeCrY2XzBDO7tBksvXxggiwTPZeDl8le0vckuX/q/Kre8Guvg3nHGU4VVeO9ZtU1811WgCSWxkODaillhJVknaocIc31hPCc2lIv4n8J6EmYRSCffjpQqmeBJlrrFVXrlJdBLJ60aK0ygj7ZTYsRdS0lVBO+BS+gKAUv0Q6WiQmFYm9CmXiakBvq0VPRHPaAqWDd+USXO4caHxRuUAHxTtwqhV7vG9YLJypwjQQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FOOikasyaM7X4Sg3dLIXfy83O/SGHBSL7+bK4QeH6kE=;
 b=0Yahj6LDGgBQHrRYpPnWLgBKjlRGm9MnmhQNCT5O6L4MpdZpUHUIv3SrXKGKlFHiF4MK0/A/26V7hQI/+O3lh9nXTULhuCdxjzPZ8+Yq41Ds1sKzYRkoONS04bM5+pAzqePdBHsScqbzCmoRP6gZm0T15iSH14zMxvqhKv0zO1E=
Received: from SA0PR12MB7462.namprd12.prod.outlook.com (2603:10b6:806:24b::5)
 by SJ5PPF09E5F035B.namprd12.prod.outlook.com
 (2603:10b6:a0f:fc02::988) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9891.21; Tue, 12 May
 2026 15:47:20 +0000
Received: from SA0PR12MB7462.namprd12.prod.outlook.com
 ([fe80::dccd:b6c:87ab:8b5f]) by SA0PR12MB7462.namprd12.prod.outlook.com
 ([fe80::dccd:b6c:87ab:8b5f%6]) with mapi id 15.20.9913.009; Tue, 12 May 2026
 15:47:17 +0000
From: "Pan, Ellen" <Yunru.Pan@amd.com>
To: "Lazar, Lijo" <Lijo.Lazar@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
CC: "Zhang, Hawking" <Hawking.Zhang@amd.com>, "Deucher, Alexander"
 <Alexander.Deucher@amd.com>
Subject: RE: [PATCH] drm/amdgpu: Fix discovery offset check under VF
Thread-Topic: [PATCH] drm/amdgpu: Fix discovery offset check under VF
Thread-Index: AQHc4iFgKcY4o8LOlUC3VAmSYuNF3LYKiO7Q
Date: Tue, 12 May 2026 15:47:17 +0000
Message-ID: <SA0PR12MB7462E672680A19283688D1D8E9392@SA0PR12MB7462.namprd12.prod.outlook.com>
References: <20260512150924.206200-1-lijo.lazar@amd.com>
In-Reply-To: <20260512150924.206200-1-lijo.lazar@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Enabled=True;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SetDate=2026-05-12T15:47:11.0000000Z;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Name=AMD General
 v26; MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_ContentBits=3;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Method=Standard
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA0PR12MB7462:EE_|SJ5PPF09E5F035B:EE_
x-ms-office365-filtering-correlation-id: b785e903-257e-4e34-47e9-08deb03dbebd
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|376014|1800799024|18002099003|11063799003|38070700021|56012099003|22082099003;
x-microsoft-antispam-message-info: 0JCnMn9+0MSbvjfLY3JcYzEih2iDH39g6QFfF82Vq0VRPXoP5JZuuiVudjUGXW4FdeQ94alm+NrmPFEiSyJjxLuLFV8RtE/Tz6Fy/+FXgWh95dstSilW8F7eX/MJLwnEbtcWa28fWYsi4dIsigQoKsZ1SQiar26X6RA1deovloUCRyzJoGKEg3VTbGAt6XKY1/VCJFSopW8LLTf1HNinvtPrZsaEa/SZoUMcXAQWhXK4865614DuQmN+n2V8jrTcPLPvm62iRkKamhRxYprk1oXQk2cC/uMVt5LmHYh6xI1QC2RK3Ds4jlJHPbZupyF+UGCKKKWFC+hVXfH4c7Ym8vpTYp+7L43I85sLrdAsboM0yMN8pCX/ElxJ8HyH28Qtjq+CD3acVVtFboNJw+vkQcDEghEyk+j9qFD/cSZ7kCsKRQ4hzFbjCAMROn2O9ViOaguZxGpoIsQIhY6lShQvuT3l84Gc9Sti1Mavg1Of/mHN0VSwjxCZM1D2cUJsAJYEAySgSqG7JSi2lt7FPVQIyyLKN9ib48S4dCqIvCDSjKqspZvDIoPnENneUdWTESGeSlafsL/PScTBNpu3v28Ioxhk9qSzJbO/9aPVRUkavQdrycqMTmKWplAqkR+fxpjMJ6ba83sJKvpVJ7g80ny+QL+lo6WXiSPAD9sCBATGf5ZuJoimJEyHOl6rEOK+icCNXXxcMSjbXuy8QeoP1pqSdxbLaYtaOemAWHwPV5yx+qZ2ptc0n5kK9qI+HbUSF6il
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SA0PR12MB7462.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(18002099003)(11063799003)(38070700021)(56012099003)(22082099003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?EQDArTqIrjw0t+bDevyLmoqv4Qm2VNS+SygYk0XHGVkOZTXigVDSNNs3zZ9w?=
 =?us-ascii?Q?SPf0LPcL4pTl3Ns7pm1wMaIYf7An2GPTj41EeNU/T7IznF4t6MLjgTbBoCh6?=
 =?us-ascii?Q?mHYUDdDF6fNOSArhh6fSma4MQhN1QCZ8KQugRTdUMD2s5OOi0Os3n16Kvyii?=
 =?us-ascii?Q?LCsLmB5aQ89yPUWvMmWPtSg8me08ZN3O8KTZgFOaQRxu5q92eYYWy30CN0Ag?=
 =?us-ascii?Q?DFV/c0teGA0bA2eYsafpeXNder5lLSCtPiFdNMDXd/3QY42MR6rUPZ7kR0c0?=
 =?us-ascii?Q?TAPBeSPcdgHwo0dYMroGdNS7kd7ADxh0zYltXMxzmCgjFhjXc93+rLvQbQJ8?=
 =?us-ascii?Q?Z0TLdMyRVQlOFbHfOG2oe3uhGY4Ff20maE6fqQiXTWx4aJpJT0/Y/g3ShvBE?=
 =?us-ascii?Q?uwOwTXQWVT1CIyX8NsM+5cprxRVJKNsRWU6/4KVkMg2moYIHBrdPDk8KBZKk?=
 =?us-ascii?Q?R4W1exutDD+PdMfznuK7i8w6qhMkxCpr+uSXTYLzalH8USm1tA8sMia5GZL8?=
 =?us-ascii?Q?3HOO+HkiSJoQ8NPszkfWKaqsYzAnAEcd6yymfm51hpJBCfodYFBfQEfctJbW?=
 =?us-ascii?Q?KOYBxwlpP3yy89fSSF4IQ2Xc3VXUbLYSGyamF8xe/gqcABKCzS4i9WPn2rIE?=
 =?us-ascii?Q?Hqqick2IY9zX73hESh9P8Jv3KzCZvkhfhYBRjFfx7auinc1YXuLbNMOdN0Zr?=
 =?us-ascii?Q?kjqjh/L6hf8oK4THUIx1MQcghRDYwo1F6hIYlb0VLe+B0k0SUUD/wwX+zay4?=
 =?us-ascii?Q?zyBaG62hEpiO4KIenF/TuDaS+GIxSOt5z2c3z7T7SwIoq31PgpeDQQPADJmk?=
 =?us-ascii?Q?Yy+Km/yg0XIZrzuvGdg2iXsxY2emh9+/bJppJj8bBHit9NocsOeFd0daivIP?=
 =?us-ascii?Q?f+PDx9yWHs7uRl9H1GFkEeQ4VyKNAFuONlQm53w6v9Y0yDJZmswJW/R97Rc3?=
 =?us-ascii?Q?aCJGIJD60HqFf724ctqJa9wcB+firHBk/V3esZrbzw0VbAPBGVSatniJjrN2?=
 =?us-ascii?Q?cmgWYqi1QJFBlDmj0VRWZuLATqSr7w3C6J1OqEBC6rL/ApqpA7emjcTkZPJ7?=
 =?us-ascii?Q?FNVRbtfkwGGIDYh73G85J01/nIbQ0Zj89p5bRnKPRBb3SY219OL0bnzd+3S/?=
 =?us-ascii?Q?d5fYg4OjgM5RFB6AxZaJ5h5f7Q2VKwyW6dH6iS1uK9K1OJiy/uUNM0QEcwfL?=
 =?us-ascii?Q?lbYquDZuq2w6vT1E3RwkwClKcOea6CiTp9XnAvc2IeBKUYXQbezT2rBCBzdE?=
 =?us-ascii?Q?s8n50y4CM3IaeDbXFqzoUEPJ3S4e5LfTtuPEAiDRt6frpRiGDSvKBWqUyjnj?=
 =?us-ascii?Q?3Hm9wTPpgwS458tCWC6gF9LB8nOKtoHmdzswdzsZwUtmz/raM+FPvNSH/Uq4?=
 =?us-ascii?Q?nSP8UXQMdnYrsKjtmKCPv64Pf2W0qsAhHbiXkMWtGkOyKGSePWL6l7KdYoh9?=
 =?us-ascii?Q?09FbH4epa2rr6RtLZKEWeHJh9uFSDXSvplaK1A1doG2tDli4FGJVXAHgncGI?=
 =?us-ascii?Q?mr0kywDuzEszH2j4IXuksDVho8yibM/GKozlq+HOfnRiSH8cVBB29dGL4grC?=
 =?us-ascii?Q?vDuZ+XBCybDrsOIfIlYwznjszHtYp44fCD7rF/rSH3orX4xHTMj16KExK02v?=
 =?us-ascii?Q?i4TK5h7I4jV9b6xM0sr3vNdrg18FMvXsemyPFH8rH1iGDrlB4LzxvQwu6RF8?=
 =?us-ascii?Q?ubPlK8XCrLTk15Q2WfWt8VfuL9ealdE7JYWLpAwJnJKACFOR?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA0PR12MB7462.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b785e903-257e-4e34-47e9-08deb03dbebd
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 May 2026 15:47:17.1899 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ps7GzgRGhLE6CiNaPBtlUj8QQtBb7WjO4b9dvkLl0tAA5eStEs4/jnv+EP0iSkpD
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ5PPF09E5F035B
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

Reviewed-by:  Ellen Pan <yunru.pan@amd.com>

-----Original Message-----
From: Lazar, Lijo <Lijo.Lazar@amd.com>
Sent: Tuesday, May 12, 2026 11:09 AM
To: amd-gfx@lists.freedesktop.org
Cc: Zhang, Hawking <Hawking.Zhang@amd.com>; Deucher, Alexander <Alexander.D=
eucher@amd.com>; Pan, Ellen <Yunru.Pan@amd.com>
Subject: [PATCH] drm/amdgpu: Fix discovery offset check under VF

Discovery table may be kept at offset 0 by host driver. Remove the validati=
on check.

Fixes: b69911681fd5 ("drm/amdgpu: fallback to default discovery offset/size=
 in sriov guest")

Signed-off-by: Lijo Lazar <lijo.lazar@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c b/drivers/gpu/dr=
m/amd/amdgpu/amdgpu_discovery.c
index bbb807a16a50..8e3b6a4050e9 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
@@ -305,7 +305,7 @@ static int amdgpu_discovery_get_tmr_info(struct amdgpu_=
device *adev,
                                adev->virt.crit_regn_tbl[AMD_SRIOV_MSG_IPD_=
TABLE_ID].offset;
                        adev->discovery.size =3D
                                adev->virt.crit_regn_tbl[AMD_SRIOV_MSG_IPD_=
TABLE_ID].size_kb << 10;
-                       if (!adev->discovery.offset || !adev->discovery.siz=
e)
+                       if (!adev->discovery.size)
                                return -EINVAL;
                } else {
                        goto out;
--
2.49.0

