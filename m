Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A0BC2C28B30
	for <amd-gfx@archiver.kernel.org>; Thu, 20 Mar 2025 06:33:33 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2518D10E593;
	Thu, 20 Mar 2025 06:33:33 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="otcy4/3D";
	dkim-atps=neutral
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2064.outbound.protection.outlook.com [40.107.220.64])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CAB1C10E593
 for <amd-gfx@lists.freedesktop.org>; Thu, 20 Mar 2025 06:33:31 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FCy/G2X4/O++nwa618BUEI9jNZL3Fn8TK6IajqLdHl0ZMQjYC0Z/F0AbV496DkGXQiQF6r5FbABNs/I8WvbaWAton3hO/+/FVTmixUl0+2V4AJqnYKjclSH1PFJrNCwE3bydb5H1/gKWruPdeRp7/JhMI8Ci3X9CvPtovUdjBcL8/UQGP/SQUEmpTqKUnIxhQuMg4jA6RAhan8V1VJfvq0n4jWx8FdIWMPd5W0d131s6e93fwBhoUi6Rq3/UyFg4ZZSvOJJcGAJgkbsC3VoaLZfGnug8fYno/H466kAreJEbhFslMVBBhXX5+8768HToCi44pFEcuitSWkktD3E7BA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0yWhbkSAMy0VN0tbpiAPiiMLn0iBNMeCZcdBW08XK9s=;
 b=TCjCR6erfpTXVEPKOhbL9SJfyS8FHrs18Os2FBEp/yF3xKaY3AzlV3fwUgz6ZAsiSzzX/MXJ69WiUI6nU561AEM+kOByelSCmVnEJ5cMu1Sb35cXAkYWB2AxsSNDnqI0IG9f4Als1kbV62AW/T8DHvIXwIL/5Ob326VO4qnm5i8G9jsftNIfGjeE31l5TDF7qhmQYOU9JKtJwQKb/z5M2/78yTWshGD/VyqzA7cGXhGQtD13ZvaBa2Vz/7xq0FGPgvAMarl+ZpYipRUX0kn6VXa4vvHNta5N1pnv6dkyqpdKpLxMl0dQox1mmdVLZORIThOpDJ7HJH11gSUHh41F/Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0yWhbkSAMy0VN0tbpiAPiiMLn0iBNMeCZcdBW08XK9s=;
 b=otcy4/3D6zkPEA0Uxeu9H/BCbW8xaSbQAKUwOT6cTzpDlTy5E6XLrGRx9qqD9pEDzwMcSD4ncbCDsfcJ9ARywoZ68w+5uNSn9BEEHv0wbr9vYgQM7YU2guL7bLT3H0nAAo39RfzT09nvWsW9cWjTL/ctKGtX6J44LFc4C/IoSWg=
Received: from CY5PR12MB6345.namprd12.prod.outlook.com (2603:10b6:930:22::21)
 by DM6PR12MB4481.namprd12.prod.outlook.com (2603:10b6:5:2af::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.33; Thu, 20 Mar
 2025 06:33:26 +0000
Received: from CY5PR12MB6345.namprd12.prod.outlook.com
 ([fe80::542:90bb:6ae5:a2b]) by CY5PR12MB6345.namprd12.prod.outlook.com
 ([fe80::542:90bb:6ae5:a2b%4]) with mapi id 15.20.8534.034; Thu, 20 Mar 2025
 06:33:26 +0000
From: "Liu, Xiang(Dean)" <Xiang.Liu@amd.com>
To: "Zhang, Hawking" <Hawking.Zhang@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
CC: "Wang, Yang(Kevin)" <KevinYang.Wang@amd.com>, "Zhou1, Tao"
 <Tao.Zhou1@amd.com>, "Chai, Thomas" <YiPeng.Chai@amd.com>
Subject: Re: [PATCH] drm/amdgpu: Decode deferred error type in gfx aca bank
 parser
Thread-Topic: [PATCH] drm/amdgpu: Decode deferred error type in gfx aca bank
 parser
Thread-Index: AQHbmV9oVSkgRsGeHE6WI6cRNj0M2LN7jk6AgAAClNA=
Date: Thu, 20 Mar 2025 06:33:26 +0000
Message-ID: <CY5PR12MB63455190AF9EBCCFABBE4536FAD82@CY5PR12MB6345.namprd12.prod.outlook.com>
References: <20250320061437.572914-1-xiang.liu@amd.com>
 <BN9PR12MB525744C2A9073AB0999C312CFCD82@BN9PR12MB5257.namprd12.prod.outlook.com>
In-Reply-To: <BN9PR12MB525744C2A9073AB0999C312CFCD82@BN9PR12MB5257.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=True;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2025-03-20T06:33:27.688Z;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution
 Only; MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=0;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard; 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CY5PR12MB6345:EE_|DM6PR12MB4481:EE_
x-ms-office365-filtering-correlation-id: f39043e1-8805-4e86-e770-08dd67791f0d
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|366016|376014|38070700018|8096899003|7053199007; 
x-microsoft-antispam-message-info: =?us-ascii?Q?4yH4wipuOQVQw7DK0dj+15G0QgQ59c/i6nfC7cPoHrMNxXQ1HROqrmfF8L+5?=
 =?us-ascii?Q?abW/VVXKhAd3wLYDN9eJwBo7rzlF9NCNz/PyDtgxr67HnBQ2ZT8g9ncA8dc2?=
 =?us-ascii?Q?6Z34JvzESZMsx4rnY8fiwEJsVR/Qjo9UStI9tf6IxiN70HslxwbF95DowL7l?=
 =?us-ascii?Q?KZGR82RXHKE1qRYi2DUAyfsMk3HvtDTEPijbguhYgp7KWYSq5zKSLhEXm0fk?=
 =?us-ascii?Q?Q+ZACcy/8/NjAuULKKVvArbVv9y84EqmChhlOGALMH+34WuYl8uhCTY3xHQ3?=
 =?us-ascii?Q?LU8SgGcZeC0w1JqIWHTK0kMa5zukIeeb92Dj6OaIoUIQLLmCaipZM8+gHiKa?=
 =?us-ascii?Q?G7H9ZRVYYcWBENzMx3vhCsMe9yp5W2dhLoaTJMTUl6UNltqtFGQAJVSdUbvd?=
 =?us-ascii?Q?zdu4JQ3nm9v7lMORlQQmBurU3FEjNx1I3LmN0mNLIv+fEm9wz8HT3DSGfvN3?=
 =?us-ascii?Q?XIpcVcBTb7QBSYBRf91I3+CNYePzhKZBnm4Q/rbl2fw5sVt0CLfflriJ5f62?=
 =?us-ascii?Q?wcD0pqtP4Da3ruScb6ysA3vIBpYFgvDv0DyhOC6cVJfyCVAn/lx//RGPOhNq?=
 =?us-ascii?Q?FTdp+XDjcjedkzCnuh69oCRY3B/SQSSKWpDJhMRGeP9yy3vx2J46IK++uUi6?=
 =?us-ascii?Q?eepr05MDjb+UzDNdfx/4LHEgb81nmR0YUzo+1tanUc0yWnos+gY5aZg+XiWt?=
 =?us-ascii?Q?hAgdZJavtGvi1cPxb7KZQ0gbuLdMCYhK7PWsoKkGgEM5Y83RKMpgtXFLLsBq?=
 =?us-ascii?Q?5B6OJiIfnDkttSGu9jP8DQfWMYl8mU9ylQLw7KpvWj5iD+h4zVkZuDkHDOcw?=
 =?us-ascii?Q?6uLg2rYheo90BDN/62jBOMNVi5wit0wlKgYb1VnBwynKEELaFholWycrHgJw?=
 =?us-ascii?Q?8QJeTa0cP3ZgvcbSc2Zu7dk59AeysShROeEETYCSwsxkkY3OLWkBzYCSdplR?=
 =?us-ascii?Q?3JBbnhe1u5NEUcBp+9IDPnvq9UVKiWgEJN7SJ1RPha7C8xu6TNUjtgaeJlDa?=
 =?us-ascii?Q?/zYi+Vds9AjwXBWVSj/n9WlOjdH92S8fa7vCfqaNrdrHIubCIdsxw4lyC/v1?=
 =?us-ascii?Q?m7wbcORcbk2CcO2kMMr5bJPYHk8LW3MN+DWaMejVk6G+8MLjAM+h62G9dWYU?=
 =?us-ascii?Q?pLy/SJmjArNne39RIq2BC0czCGIskHcfZ9+Vzi+5+Oj2igiwRB3SVO1jqi1G?=
 =?us-ascii?Q?b6P84UzOLUCzGpbwZO07WC0Uf9LFiBHFdIzYMWSmQUVL4AjkzEiXl8Vlo6rf?=
 =?us-ascii?Q?eG0i+h9R7qCExfDzoia/Ua8SOMpm72KI/QYjCf4agepYljT1AF7jj2POiAei?=
 =?us-ascii?Q?XHoMKZmVKKqz3Puwgzku3A4ugRczrKAJEKGNsVhezE4zbjR3oWtqCMxtEMW2?=
 =?us-ascii?Q?Chs1MadZmw6c2EVU+FonHBvkp6mTpfUtXtA7iOymq5R3XZtMWDM93BY+5KW+?=
 =?us-ascii?Q?TQv6tY6FJcLcePHRuWPqwyDZCmuPxlM1?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CY5PR12MB6345.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(38070700018)(8096899003)(7053199007);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?2mYH8ra+QElLA2yta5y/cpSHrk6EjpM8rA/UJKvF3XfbdJeLPIxt3cGEBWLA?=
 =?us-ascii?Q?ZQozS4+CjSmIqobgmUD/35jiPyUT6L0eeXq6Q3WL1rdZzl+vlELh25ND+e++?=
 =?us-ascii?Q?fFT367i13d6k1l9Xg54BBadxz6+wjDa2BWj1IB9PrM9lr83JLBrqYwsDyhNR?=
 =?us-ascii?Q?L+bAXlj8GwxGtbxyBO8q8ZNmQ+ELx5RfBvSkJ21EgfULhb5BIPfhGszcJbtl?=
 =?us-ascii?Q?+shDXFFwVnR7BY2EcFjwP1OndpHzY0vdccRWBLUI2cpSK0ZTtsQqCbo4FwPR?=
 =?us-ascii?Q?ZPL9gOT/mLraCCnA/mAiW4QjqyS8VpgjAs+0I2pw5sNYnNVT/AoXg2LTyg0Y?=
 =?us-ascii?Q?T1WIkMcHIP4WBs9r9tX1b2Yl29G+DwJAUGWH6MsdocXd75bTDwGejQjsTWVn?=
 =?us-ascii?Q?zNhj9rbrsS7T/d+SYdoqsQThGy/oy3dpmyQOx164J3fFUh/pGgY2JjnTDN5B?=
 =?us-ascii?Q?d6G1+OhFAYLb1uCJZrHwQWj5E7OjkLvPUn5PjLxZyFY4uWP3gnQyiWQ1H0/W?=
 =?us-ascii?Q?g4Zn9Uo1ecfpV3HsGBLbZ8uCFZjBkao5IKGTyOQ/N2GbVPVdFTKb7OE26QQJ?=
 =?us-ascii?Q?WGDyjH/jRa4/vOY2tCY8TkSfwCgmJuYcatQHIthfhUdfmljJPK6mIsR9lJr/?=
 =?us-ascii?Q?KiwvxYusdDP9RXkxUHG/P0jtjuqBdOzdF57lHubm7Qmp15t6r7doG2lDkOEB?=
 =?us-ascii?Q?IAHuGHGeBpsYfdfNS2Swzj9NjBL8emaGG6yF8lhvJ5TpzitqDyjJuxBgm48Z?=
 =?us-ascii?Q?TPtWNrci/T/xVZINjTpJ4OpuzydH207Lq9Jt0Cy0fg7CXg+F90Ew5qrfhETH?=
 =?us-ascii?Q?BlJn1SPyaXamfN/pVoZqFD7rLhCKC7pY1jt5RgKQDcxbvwf6tuKoAQPtKPhp?=
 =?us-ascii?Q?s6f+XFgf94jU/RQqqsM8TRqfW/UoOVvlzuZy0F7scSzndgHLqGXsAE0T4y2E?=
 =?us-ascii?Q?SX6YNmhEmwtOSFkJI2hEJehOv01HMXsfhZB8dd1+K94oQ60soqQ4ja7GUBAn?=
 =?us-ascii?Q?oaz2bNUgsMVQbKQ4wfv+Iwp5SJf0fPyK3OCw2hDuInHsjQTK9eafbowVy77i?=
 =?us-ascii?Q?TI1YSpj0UDdiB3S+djprGUV/RfrTAcM6bQxQpFLHn3rWJg2kSlmCKpCTMcUr?=
 =?us-ascii?Q?vZjxiyNqAnqrXffNIiKnNrQbRgxdX6MwmkRVmpAZg/DkrfStZ7vvh8BK9kUn?=
 =?us-ascii?Q?NnzGR7mUUFvJxgKNKSv5JbvLaHgqeMyOMz59E3taDJgQQb0VnMs9ipIILoSW?=
 =?us-ascii?Q?imfRWKmswRCJSJ1vmYjTaCXozyQcPg9XfP+M+Se8u5eOCWcZRYs23hOCeUNg?=
 =?us-ascii?Q?ddpoLjN+RJSa7ERGlScHRB4G3qKI5aqHpGiKzcrxtNjxXHTpmMmvoPVh//IN?=
 =?us-ascii?Q?Lvfe6Rvbj7OGhg+8q3+rBLdUNKbtNeDc/BBiJgy+zl2tuDXNkpIZXIFUS03z?=
 =?us-ascii?Q?4MIWV2Cu4vrV4xH1spXEfPNcIk72Q++OrKTfrrnCC+DgGJyNqE3ATzBKjwbj?=
 =?us-ascii?Q?9RtwtENCZujhF9PGJNHE6Y4eKSbpvFlfbE7OcbRssU0vScuMB7eh+bGuHy8q?=
 =?us-ascii?Q?AThwAMj/GQnbmA6fVXk=3D?=
Content-Type: multipart/alternative;
 boundary="_000_CY5PR12MB63455190AF9EBCCFABBE4536FAD82CY5PR12MB6345namp_"
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY5PR12MB6345.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f39043e1-8805-4e86-e770-08dd67791f0d
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Mar 2025 06:33:26.5576 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: lo81CULsgu52nJ2Id/I5U4ZYxCDEWfp5OZqsaKSlDwMCLDC/MMPiY7cyzPd9p3YyvPWqjOXbm+tN/+XZiilvEg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4481
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

--_000_CY5PR12MB63455190AF9EBCCFABBE4536FAD82CY5PR12MB6345namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

[AMD Official Use Only - AMD Internal Distribution Only]

Thanks, will improve it.

Best Regards,

Dean

________________________________
From: Zhang, Hawking <Hawking.Zhang@amd.com>
Sent: Thursday, March 20, 2025 2:22 PM
To: Liu, Xiang(Dean) <Xiang.Liu@amd.com>; amd-gfx@lists.freedesktop.org <am=
d-gfx@lists.freedesktop.org>
Cc: Wang, Yang(Kevin) <KevinYang.Wang@amd.com>; Zhou1, Tao <Tao.Zhou1@amd.c=
om>; Chai, Thomas <YiPeng.Chai@amd.com>
Subject: RE: [PATCH] drm/amdgpu: Decode deferred error type in gfx aca bank=
 parser

[AMD Official Use Only - AMD Internal Distribution Only]

+               bank->aca_err_type =3D (ACA_REG__STATUS__POISON(status) ||
+                                     ACA_REG__STATUS__DEFERRED(status)) ?
+                                               ACA_ERROR_TYPE_DEFERRED :
+                                               ACA_ERROR_TYPE_UE;

Does it make more sense to create a macro similar to ACA_BANK_ERR_CE_DE_DEC=
ODE for above code segment?

Regards,
Hawking

-----Original Message-----
From: Liu, Xiang(Dean) <Xiang.Liu@amd.com>
Sent: Thursday, March 20, 2025 14:15
To: amd-gfx@lists.freedesktop.org
Cc: Zhang, Hawking <Hawking.Zhang@amd.com>; Wang, Yang(Kevin) <KevinYang.Wa=
ng@amd.com>; Zhou1, Tao <Tao.Zhou1@amd.com>; Chai, Thomas <YiPeng.Chai@amd.=
com>; Liu, Xiang(Dean) <Xiang.Liu@amd.com>
Subject: [PATCH] drm/amdgpu: Decode deferred error type in gfx aca bank par=
ser

In the case of injecting uncorrected error with background workload, the de=
ferred error among uncorrected errors need to be specified by checking the =
deferred and poison bits of status register.

Signed-off-by: Xiang Liu <xiang.liu@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_aca.c |  3 +++  drivers/gpu/drm/amd/amdg=
pu/gfx_v9_4_3.c | 11 +++++++----
 2 files changed, 10 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_aca.c b/drivers/gpu/drm/amd/=
amdgpu/amdgpu_aca.c
index ffd4c64e123c..3f45a600f547 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_aca.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_aca.c
@@ -541,6 +541,9 @@ static int __aca_get_error_data(struct amdgpu_device *a=
dev, struct aca_handle *h
        if (ret)
                return ret;

+       if (type =3D=3D ACA_ERROR_TYPE_UE)
+               aca_log_aca_error(handle, ACA_ERROR_TYPE_DEFERRED, err_data=
);
+
        return aca_log_aca_error(handle, type, err_data);  }

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c b/drivers/gpu/drm/amd/=
amdgpu/gfx_v9_4_3.c
index c0de682b7774..b21d784a7f9c 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
@@ -876,7 +876,7 @@ static int gfx_v9_4_3_aca_bank_parser(struct aca_handle=
 *handle,
                                      void *data)
 {
        struct aca_bank_info info;
-       u64 misc0;
+       u64 misc0, status;
        u32 instlo;
        int ret;

@@ -890,12 +890,15 @@ static int gfx_v9_4_3_aca_bank_parser(struct aca_hand=
le *handle,
        info.die_id =3D instlo =3D=3D mmSMNAID_XCD0_MCA_SMU ? 0 : 1;

        misc0 =3D bank->regs[ACA_REG_IDX_MISC0];
+       status =3D bank->regs[ACA_REG_IDX_STATUS];

        switch (type) {
        case ACA_SMU_TYPE_UE:
-               bank->aca_err_type =3D ACA_ERROR_TYPE_UE;
-               ret =3D aca_error_cache_log_bank_error(handle, &info,
-                                                    ACA_ERROR_TYPE_UE, 1UL=
L);
+               bank->aca_err_type =3D (ACA_REG__STATUS__POISON(status) ||
+                                     ACA_REG__STATUS__DEFERRED(status)) ?
+                                               ACA_ERROR_TYPE_DEFERRED :
+                                               ACA_ERROR_TYPE_UE;
+               ret =3D aca_error_cache_log_bank_error(handle, &info,
+bank->aca_err_type, 1ULL);
                break;
        case ACA_SMU_TYPE_CE:
                bank->aca_err_type =3D ACA_BANK_ERR_CE_DE_DECODE(bank);
--
2.34.1


--_000_CY5PR12MB63455190AF9EBCCFABBE4536FAD82CY5PR12MB6345namp_
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
<p style=3D"font-family:Calibri;font-size:10pt;color:#0000FF;margin:5pt;fon=
t-style:normal;font-weight:normal;text-decoration:none;" align=3D"Left">
[AMD Official Use Only - AMD Internal Distribution Only]<br>
</p>
<br>
<div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
Thanks, will improve it.</div>
<p class=3D"elementToProof" style=3D"text-align: left; text-indent: 0px; ba=
ckground-color: white; margin: 0px;">
<span style=3D"font-family: Aptos, sans-serif; font-size: 11pt; color: blac=
k;">Best Regards,</span></p>
<p class=3D"elementToProof" style=3D"text-align: left; text-indent: 0px; ba=
ckground-color: white; margin: 0px;">
<span style=3D"font-family: Aptos, sans-serif; font-size: 11pt; color: blac=
k;">Dean</span></p>
<div id=3D"appendonsend"></div>
<hr style=3D"display:inline-block;width:98%" tabindex=3D"-1">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" st=
yle=3D"font-size:11pt" color=3D"#000000"><b>From:</b> Zhang, Hawking &lt;Ha=
wking.Zhang@amd.com&gt;<br>
<b>Sent:</b> Thursday, March 20, 2025 2:22 PM<br>
<b>To:</b> Liu, Xiang(Dean) &lt;Xiang.Liu@amd.com&gt;; amd-gfx@lists.freede=
sktop.org &lt;amd-gfx@lists.freedesktop.org&gt;<br>
<b>Cc:</b> Wang, Yang(Kevin) &lt;KevinYang.Wang@amd.com&gt;; Zhou1, Tao &lt=
;Tao.Zhou1@amd.com&gt;; Chai, Thomas &lt;YiPeng.Chai@amd.com&gt;<br>
<b>Subject:</b> RE: [PATCH] drm/amdgpu: Decode deferred error type in gfx a=
ca bank parser</font>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font face=3D"Times New Roman" size=3D"3"><span=
 style=3D"font-size:12pt;"><a name=3D"BM_BEGIN"></a>
<div><font size=3D"2"><span style=3D"font-size:11pt;">[AMD Official Use Onl=
y - AMD Internal Distribution Only]<br>
<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; bank-&gt;aca_err_type =3D (ACA_REG__STATUS__POISON(status) ||<br=
>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ACA_REG=
__STATUS__DEFERRED(status)) ?<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ACA_ERROR_TYPE_DEFERRE=
D :<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ACA_ERROR_TYPE_UE;<br>
<br>
Does it make more sense to create a macro similar to ACA_BANK_ERR_CE_DE_DEC=
ODE for above code segment?<br>
<br>
Regards,<br>
Hawking<br>
<br>
-----Original Message-----<br>
From: Liu, Xiang(Dean) &lt;Xiang.Liu@amd.com&gt;<br>
Sent: Thursday, March 20, 2025 14:15<br>
To: amd-gfx@lists.freedesktop.org<br>
Cc: Zhang, Hawking &lt;Hawking.Zhang@amd.com&gt;; Wang, Yang(Kevin) &lt;Kev=
inYang.Wang@amd.com&gt;; Zhou1, Tao &lt;Tao.Zhou1@amd.com&gt;; Chai, Thomas=
 &lt;YiPeng.Chai@amd.com&gt;; Liu, Xiang(Dean) &lt;Xiang.Liu@amd.com&gt;<br=
>
Subject: [PATCH] drm/amdgpu: Decode deferred error type in gfx aca bank par=
ser<br>
<br>
In the case of injecting uncorrected error with background workload, the de=
ferred error among uncorrected errors need to be specified by checking the =
deferred and poison bits of status register.<br>
<br>
Signed-off-by: Xiang Liu &lt;xiang.liu@amd.com&gt;<br>
---<br>
&nbsp;drivers/gpu/drm/amd/amdgpu/amdgpu_aca.c |&nbsp; 3 +++&nbsp; drivers/g=
pu/drm/amd/amdgpu/gfx_v9_4_3.c | 11 +++++++----<br>
&nbsp;2 files changed, 10 insertions(+), 4 deletions(-)<br>
<br>
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_aca.c b/drivers/gpu/drm/amd/=
amdgpu/amdgpu_aca.c<br>
index ffd4c64e123c..3f45a600f547 100644<br>
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_aca.c<br>
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_aca.c<br>
@@ -541,6 +541,9 @@ static int __aca_get_error_data(struct amdgpu_device *a=
dev, struct aca_handle *h<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (ret)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; return ret;<br>
<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (type =3D=3D ACA_ERROR_TYPE_UE)<br=
>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; aca_log_aca_error(handle, ACA_ERROR_TYPE_DEFERRED, err_data);<br=
>
+<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return aca_log_aca_error(handle,=
 type, err_data);&nbsp; }<br>
<br>
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c b/drivers/gpu/drm/amd/=
amdgpu/gfx_v9_4_3.c<br>
index c0de682b7774..b21d784a7f9c 100644<br>
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c<br>
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c<br>
@@ -876,7 +876,7 @@ static int gfx_v9_4_3_aca_bank_parser(struct aca_handle=
 *handle,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; vo=
id *data)<br>
&nbsp;{<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct aca_bank_info info;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; u64 misc0;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; u64 misc0, status;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; u32 instlo;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int ret;<br>
<br>
@@ -890,12 +890,15 @@ static int gfx_v9_4_3_aca_bank_parser(struct aca_hand=
le *handle,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; info.die_id =3D instlo =3D=3D mm=
SMNAID_XCD0_MCA_SMU ? 0 : 1;<br>
<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; misc0 =3D bank-&gt;regs[ACA_REG_=
IDX_MISC0];<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; status =3D bank-&gt;regs[ACA_REG_IDX_=
STATUS];<br>
<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; switch (type) {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case ACA_SMU_TYPE_UE:<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; bank-&gt;aca_err_type =3D ACA_ERROR_TYPE_UE;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; ret =3D aca_error_cache_log_bank_error(handle, &amp;info,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp; ACA_ERROR_TYPE_UE, 1ULL);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; bank-&gt;aca_err_type =3D (ACA_REG__STATUS__POISON(status) ||<br=
>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ACA_REG=
__STATUS__DEFERRED(status)) ?<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ACA_ERROR_TYPE_DEFERRE=
D :<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ACA_ERROR_TYPE_UE;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; ret =3D aca_error_cache_log_bank_error(handle, &amp;info,<br>
+bank-&gt;aca_err_type, 1ULL);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; break;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case ACA_SMU_TYPE_CE:<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; bank-&gt;aca_err_type =3D ACA_BANK_ERR_CE_DE_DECODE(bank);<=
br>
--<br>
2.34.1<br>
<br>
</span></font></div>
</span></font></div>
</div>
</body>
</html>

--_000_CY5PR12MB63455190AF9EBCCFABBE4536FAD82CY5PR12MB6345namp_--
