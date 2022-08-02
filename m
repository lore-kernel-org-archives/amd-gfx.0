Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7D37CC00144
	for <amd-gfx@archiver.kernel.org>; Tue,  2 Aug 2022 03:47:53 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0399F10F37A;
	Tue,  2 Aug 2022 03:47:39 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2084.outbound.protection.outlook.com [40.107.237.84])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C7B3011A68A
 for <amd-gfx@lists.freedesktop.org>; Tue,  2 Aug 2022 03:47:26 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LdRW3N8CJ0yy3AAdYYWs4HPhtFFDE7LK9lNo5idvdBpQ0YxjwNj3Gd9SqnONkJSAtxAo9Dwz9vCPuTaVUm19/yhSrAX+HeD2Cwd58vwDWAZrUWhz1TSoGXTvNjImWPCMh8wNYskIIOPEHfEtJBStUsj6R2g8DojXoTa6Vr7RJjZF4VRQdIsHSlY2ZXBtDEeyLJOur6WwlQENB14eiF3uFBeTTbcmKGWZLU3c8El/dPzgnBypMJXOZMYBt3CU6z4Vq8wf4xv+ypqA9H5s65FfLQreDLjkOjuDb3VyOjZUECEBrMbx+UFGtL1egMbO9k/oKf7CIzdueIX3A+aR/jl9qw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8adia28b5di0+6Gu0aQSKgew18VbvY0yMn7Wqy+KlGk=;
 b=oGKRf/5OimHRk+ae3emLlaSV1stELLEZVvtFhJVX4jqYDvKnE2X4T1ZpYEo5XRVvSD+k3IOxSUndpYZJvWhE7f8L/OrJFOaaIsO/AcVkqcj1NFa6m1DXtvpyfLLUwLEzD7+cVxjUhvPdBfcPBEuc16gVKcyZm8AUyYw0tBAQ4NHv13KjxRweMn0PGYZzQ+PX82J2FTTBXVk2Vn1zaJh2xCOPLj8LXC1ZeGBLO6VkhI7P8JsOoTBZnbsAxGR5Y/Md+Cr89KuVAHt0S+5yEMi8JNF4VZiL63l5etcLJarxhPOvetYrXYhmoxKjO1mDkr2pZ1OMkxPs9sXQsraGzKDjNQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8adia28b5di0+6Gu0aQSKgew18VbvY0yMn7Wqy+KlGk=;
 b=fYbaaI7WF5YYdnc9oNX4QtRT6+jHeIMqMXZ8D6DdHnXs/5gFf8o1Epjy/YcAhQbinZMLguKpi2+u34EJ54BcWz05YPCEs9GqZ3sZ8WYoTxCODJUeSHwyxjEsaFrw+1waPB2TKogBv1eaI6PVGeq5R04wwi8UINpOCTpu8atlgig=
Received: from DM5PR12MB2469.namprd12.prod.outlook.com (2603:10b6:4:af::38) by
 CY4PR1201MB2532.namprd12.prod.outlook.com (2603:10b6:903:d8::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5482.14; Tue, 2 Aug
 2022 03:47:21 +0000
Received: from DM5PR12MB2469.namprd12.prod.outlook.com
 ([fe80::b554:38a0:aa8b:819d]) by DM5PR12MB2469.namprd12.prod.outlook.com
 ([fe80::b554:38a0:aa8b:819d%7]) with mapi id 15.20.5482.016; Tue, 2 Aug 2022
 03:47:19 +0000
From: "Chen, Guchun" <Guchun.Chen@amd.com>
To: "Ma, Jun" <Jun.Ma2@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>, "Deucher, Alexander"
 <Alexander.Deucher@amd.com>
Subject: RE: [PATCH RESEND] drm/amdgpu: Remove redundant reference of header
 file
Thread-Topic: [PATCH RESEND] drm/amdgpu: Remove redundant reference of header
 file
Thread-Index: AQHYph56uBielKLxQ0WcJw6l3KFkr62a+Jew
Date: Tue, 2 Aug 2022 03:47:19 +0000
Message-ID: <DM5PR12MB2469DE5A39E0030231E4618CF19D9@DM5PR12MB2469.namprd12.prod.outlook.com>
References: <20220802031729.2088825-1-Jun.Ma2@amd.com>
In-Reply-To: <20220802031729.2088825-1-Jun.Ma2@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 301a32b9-e518-4bcd-6787-08da7439b307
x-ms-traffictypediagnostic: CY4PR1201MB2532:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 8jMFA29Jg6VWVi0wMeqHA+5iJXyi0JFBP3SXPWjbIyoP+JHnmJf33E55BTeEOSvuB1l/4TI9gGM6j9kYZfF4O6XzpME4yFluBckJHvJ7EHaiQi2/1pNHF9yjdJT4M44DZey85IXveBEAUT19WPkFZs8j8o+lZpLDP3xxWqcrBSbaMPkpWuu40UyKErre5fwabxLLw4Mnvx+5NWxtRowjrc7ngTvL7OirOSncylLxirCzALS48rFQKc3G+/d3BS1/zuNRTqw75U+YMgkU9NDvlkiYoCqeBbodGhhMF1oujgFdD4gGebZNmpm0/iFxRnwU/DegUhuPpw/O1efZKiADPHa18RS0NWgpFGi6gZ7N7cQVm3JkC+S7sIwcrK1EV4iBQXPBL8t5rJtH+4fKJtyC4mtKxEmfMVXtQFxkwBfsUYPiMCOmnMjdkCK4bE2QJJ8x/BDSp7e36Ku6brczhpwPEusf2bFOWli6EaSChxLdW59J3uijPZ5ygTayMVP44r16fsp0WXbMFsh0qH3lqqLUAmj0lPqFJGKgY/Btid4XXaNOFzF55K75s8YcFhj4juIxGBidyoybpLfeQiOLsZCB6OWH0q8P4XVqDirYczLWRETJVo8cJd1Nzq7xfYILFpi6hC9xDsfUDOWGChi5VO3lAsByi9WUatM4G3F4xKgpm7M3PSBSoU2o6FW//rGCwART5yHKH6mbSavx2lJyqovTeFvwZ79jryevRXhfLzTGqhqIM6Uq/EJDmVo5OoXgdbTb2x+LlZoK+jCKXKSq0cyBxb+6gb5QlkRuCTyNaPA1kALADGUcOMtDbMAvu7Aah2/w
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM5PR12MB2469.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230016)(4636009)(39860400002)(366004)(136003)(346002)(396003)(376002)(55016003)(122000001)(38100700002)(7696005)(6506007)(9686003)(26005)(53546011)(110136005)(38070700005)(83380400001)(2906002)(41300700001)(6636002)(4326008)(8676002)(64756008)(66446008)(66476007)(66556008)(66946007)(52536014)(8936002)(71200400001)(316002)(76116006)(33656002)(86362001)(5660300002)(478600001)(186003)(4744005);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?mRS2zP7alXOqDUiDVW64vDciO4kohiYpTEQ8d08lbHOPwE7CIvZBVByPGHXX?=
 =?us-ascii?Q?2Ijh+JF5F5O5B2FjNzlSQFya/dNB38enDtAmdOig6OOidbLIGT7Gblm09VnL?=
 =?us-ascii?Q?/wdHTbkiTQnUs10Sy3MaUyPSCixanv3tpv3yIsXBDqb74ZNppcT3b8mQMQ5K?=
 =?us-ascii?Q?INBhXhFH8fdjlOGWdyKZI1d5SVnyqhBsg1m2/E2H31TxVR8ztjVrp2OFnMZn?=
 =?us-ascii?Q?N4C9OIXKPTS6VUtgq9Yn08+BLl7WEQmjTNpzVAf336eJLDSma4qa+uD3r9Xo?=
 =?us-ascii?Q?cnYSjw+AtgZO26vv+qYFfBeUmsNwYYkoJhmIqs8nCD2tyXe+ANX4ySKiqSD/?=
 =?us-ascii?Q?JrfWEC4BeBs3cgmzH4tQCET/F+LS8EDdD6bCCslST7VNO1PbJ5oO4lmT9izm?=
 =?us-ascii?Q?7h73dl5m2sgE4agRZsBD/126j0OgAiuzvoGIxRK254ffNoT4xuuRK0V2tROF?=
 =?us-ascii?Q?fNSbjbIKzlAQZLTzmfJ5Ho8qCkasp99seqfWxfe0r2ylPFPhzEikH5eXgqt8?=
 =?us-ascii?Q?fhGrOzs6Crpvo97D0XHfAzKgjI96IR5cZ0ZWrHCQLTJsD5UcpP1N7pw9CaXy?=
 =?us-ascii?Q?5VVTeoCjb2uTILBOi+hm9rFBGh85h06iojVA1hSBFkTeplwADWXaT3Wtf+nc?=
 =?us-ascii?Q?MYA0kD5QoninIMCOBQDCeQhFcb5mIndAy6QhsZ9p/jEVTkI5JGI6Pyh3bNMm?=
 =?us-ascii?Q?DFePWZgL42OP5oSL8qWGhV7xerHTXVltJtWiZm99l1JuwmcLxontVF04vYmo?=
 =?us-ascii?Q?XC6PaoXbyv5wECvJAKhVo9pZqaDrREfoeB6Wi1tSgR273ygyXKh5e5Gg1Kgm?=
 =?us-ascii?Q?XKgkMAKgg7I1jGZzqIg6NewpY288anAhvd9cWh3P+pLMTd0nuIO4IclWOz00?=
 =?us-ascii?Q?K4rgZkmzMvNwvzFj/cUnttkSwB2ly/sLP3uC5Buk1+ebYVr524sxSRD0m0Ug?=
 =?us-ascii?Q?g1wmKG9NsCNQGCpLkHWwZVe3APChMtr+n9U2a+sepRTb8ZcPT8xmLq2fF+Ck?=
 =?us-ascii?Q?2imHnmLKrE21YJe+N169slMb94JJzMTX9eTy2F0YSYX0dB6S+Zhu5ecZX8NP?=
 =?us-ascii?Q?XM59lLN2qBKejN63llCxJgkhHiojjVzyNQll8DctXPA/Zd1PIQeltiS2uCXD?=
 =?us-ascii?Q?P13Ku2Hm+PBXNsvTIuUOCGRLPYD3nJh7d+5urZieypmSChsrObTLyk3YAtdx?=
 =?us-ascii?Q?uRXPJ9f8weg7rOh7wirSQpkgHIsbfp2lNBtL0sRg4QFvfzsp/Q+e4oWxmFHG?=
 =?us-ascii?Q?taCx6DLSLK89qa9aTnauoj/iOn3fB1UZmCjZpQHU+9zavV0/07PGXLmiHJFd?=
 =?us-ascii?Q?8PWkR5+hJJcWsL6tB9c6EKmS2PoKQ1HERv5HMFvFuDq1C3uWhFUshcJDvZLt?=
 =?us-ascii?Q?bmfDeZTJM582OHQWvbQjYDUcXTBidCsiOPS+BMtUNK1qrQmGOk0abvfsV6Ka?=
 =?us-ascii?Q?YjG8gDhXemA8oc9DaLHHajZXjQgOQPIq5YDkMbyVGTAjcityJ0ghodsh4OlH?=
 =?us-ascii?Q?ovdI2AItExchmFssGWZSYUgYJaGKkffVgMfTFyOhes+iErKoCS09kbX3m5bZ?=
 =?us-ascii?Q?/+rkPdoOpYzGmujuJ450WpBs1+9VjvZQ+eH/xNKk?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM5PR12MB2469.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 301a32b9-e518-4bcd-6787-08da7439b307
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Aug 2022 03:47:19.1286 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 9Dm7EdaU/eWGV47uQoA/kgjvivSVRvzqyvANZGy25dmKct13iskqG4vDLeRTv5HCCZedfwRxi2beajXUROM+6g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR1201MB2532
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
Cc: "Zhang, Hawking" <Hawking.Zhang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Reviewed-by: Guchun Chen <guchun.chen@amd.com>

Regards,
Guchun

-----Original Message-----
From: Ma, Jun <Jun.Ma2@amd.com>=20
Sent: Tuesday, August 2, 2022 11:17 AM
To: amd-gfx@lists.freedesktop.org; Deucher, Alexander <Alexander.Deucher@am=
d.com>
Cc: Ma, Jun <Jun.Ma2@amd.com>; Chen, Guchun <Guchun.Chen@amd.com>; Zhang, H=
awking <Hawking.Zhang@amd.com>
Subject: [PATCH RESEND] drm/amdgpu: Remove redundant reference of header fi=
le

Remove redundant reference of header file dev_printk.h

Signed-off-by: Ma Jun <Jun.Ma2@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/psp_v13_0.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/psp_v13_0.c b/drivers/gpu/drm/amd/a=
mdgpu/psp_v13_0.c
index c9821f89eeed..c39e8b333181 100644
--- a/drivers/gpu/drm/amd/amdgpu/psp_v13_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/psp_v13_0.c
@@ -20,7 +20,6 @@
  * OTHER DEALINGS IN THE SOFTWARE.
  *
  */
-#include <linux/dev_printk.h>
 #include <drm/drm_drv.h>
 #include "amdgpu.h"
 #include "amdgpu_psp.h"
--=20
2.25.1

