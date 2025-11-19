Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 40DAECF2583
	for <amd-gfx@archiver.kernel.org>; Wed, 19 Nov 2025 06:13:40 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D6CD610E224;
	Wed, 19 Nov 2025 06:13:39 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="0J+/D3NX";
	dkim-atps=neutral
Received: from BN1PR04CU002.outbound.protection.outlook.com
 (mail-eastus2azon11010007.outbound.protection.outlook.com [52.101.56.7])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8AD4810E224
 for <amd-gfx@lists.freedesktop.org>; Wed, 19 Nov 2025 06:13:38 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FqEnctmSX4LWZpZTmM03E5zA+eyHt7O/VmylgEUEF/ZqpOD19GNYOVaF+JSQi42jkYK4OuYnUeZw4KA8kGpQMNcmfjRptWgzxhHA7XHMMkj3OdqQFJ2SrfqQwdSiCDoeObQMhVs/7rmaI9lCZZ4DAAYn3Rc6NsXsIk4D7NyozDEHXHLUb6R6Xv9zdDnDB0vVCzpAn70Og9vI0IPQPV5WpZll98P96RJVdFjuGhh5ZbhhgVFVjYeK2TTOAXOcttVYWcrYN+O7EK1kK9imVxNvxP8WfYDyWY4t4GaR04rEGUTmP68EcFMh7BxBBogEeA13S0rFsYPpi8xsSslV1R1Tiw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=a1JzUbLvLBKuzulw/Y9DWCH2KgSgWwzOQimhvnwSxWY=;
 b=hD4qDjkGCkj0PkVzHOmA0MXIEGxsuYeA19emB1+KtC0uyW4EcMtaSsWWeZvdqP/aB4sLOmFQBCJnyYc+gnfAQVyDKQwitGifWaErncRInmSx3jbQkHPh3ZG+4BHx5PKkGZcbqrJd0rMq1x/21ngi3+Tc5Z9ACPFHLLmSz3EP7t7DRt6YsO30INP8xkch7MDg+KoQnVA9Fh3coAXmCBkblpsPmvFQ1ySXKAnyqggUd9rhG5SYVKQdQJtWUIq3SExRVY9bxLeTITHp1RdM+fZ7h5d1hfcdwlQuBAuPUJSLGiSdrTeWzzwKSQerkTlHM69mFsP+Dzz3IHUVUjL7Q3bhZg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=a1JzUbLvLBKuzulw/Y9DWCH2KgSgWwzOQimhvnwSxWY=;
 b=0J+/D3NXF3SolCQuyX1PPZQYtxBttab/KtjLPB4hFQKM/8tsx+eKzY49KpCL/6iLnKs3Gmx5i3DYy+2QZpJghL7wXqiS2UZBs62d6Hyftx/1wGWLnhYqPrqwXbmBBVQd9zpoZHYvqaNZVVHhYB4dGyRnY2iGpNBeDse2vSigNYs=
Received: from BN9PR12MB5257.namprd12.prod.outlook.com (2603:10b6:408:11e::16)
 by MN0PR12MB6343.namprd12.prod.outlook.com (2603:10b6:208:3c0::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9320.22; Wed, 19 Nov
 2025 06:13:35 +0000
Received: from BN9PR12MB5257.namprd12.prod.outlook.com
 ([fe80::c593:f43d:c798:e009]) by BN9PR12MB5257.namprd12.prod.outlook.com
 ([fe80::c593:f43d:c798:e009%4]) with mapi id 15.20.9343.009; Wed, 19 Nov 2025
 06:13:35 +0000
From: "Zhang, Hawking" <Hawking.Zhang@amd.com>
To: "Chai, Thomas" <YiPeng.Chai@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
CC: "Zhou1, Tao" <Tao.Zhou1@amd.com>, "Li, Candice" <Candice.Li@amd.com>,
 "Yang, Stanley" <Stanley.Yang@amd.com>, "Su, Joe" <Jinzhou.Su@amd.com>,
 "Zhou1, Tao" <Tao.Zhou1@amd.com>
Subject: RE: [PATCH 7/7] drm/amd/ras: Support sriov uniras to obtain cper data
Thread-Topic: [PATCH 7/7] drm/amd/ras: Support sriov uniras to obtain cper data
Thread-Index: AQHcWGwj0fSGZU2pNkWKLFsyOyAbnrT5hlNw
Date: Wed, 19 Nov 2025 06:13:35 +0000
Message-ID: <BN9PR12MB52578C9241E2C9EB159661F3FCD7A@BN9PR12MB5257.namprd12.prod.outlook.com>
References: <20251118091559.959683-1-YiPeng.Chai@amd.com>
 <20251118091559.959683-7-YiPeng.Chai@amd.com>
In-Reply-To: <20251118091559.959683-7-YiPeng.Chai@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=True;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2025-11-19T06:13:12.0000000Z;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution
 Only; MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=3;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR12MB5257:EE_|MN0PR12MB6343:EE_
x-ms-office365-filtering-correlation-id: 6b3743d3-f3d0-4f91-6201-08de2732c617
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|38070700021|7053199007; 
x-microsoft-antispam-message-info: =?us-ascii?Q?Hui1QA3hxVUuW4tnDixakXsljIZR9bRBvA4JNX6DtQHh+7KHKgij+lm6/1Eb?=
 =?us-ascii?Q?5zNYHceauM+b4JiJlCIDPw097SdZyFNCgW3+wZaIfni9YBUepsOQBurGyOVi?=
 =?us-ascii?Q?qc2aqW5/EJGQvw2nK9eUmtGebkIGKfZGvHSqgo5aiPpzeulKveugy79Jj0en?=
 =?us-ascii?Q?95MyeE8JxbPTvI1oJxBWwpK15upd0kVpx4FHYUWl7F5Osqfo3duq6FN/sAnI?=
 =?us-ascii?Q?AdCHy3vaAFbMiLGed/5YUWTZe6hHDZp5GRfGbN8p6EU+mQA5+fDOC9I8Gr/c?=
 =?us-ascii?Q?bOwwBBmK1hVm1dPwKb2yDXlufyPnuxA+QZroRFYR40NamiYVXYoskq+CJhCo?=
 =?us-ascii?Q?MeF9EUjsqwk6/9D7h95hdkAWQiqH6Rsbpft09Ksl7RU6B/Aasf4RJ3/GUsvE?=
 =?us-ascii?Q?dwReo1Mg6JF5oc9CZ+13XqCsjKXV2V+s493RsUyKBwLbE/M3+anNm40JGHHr?=
 =?us-ascii?Q?tu78TdbKjK9nyerJ604wDclMe4gC4FtLDebbj5U4HuYA+Pp1hmjMeKZeAi+U?=
 =?us-ascii?Q?Vz20aWhRbVc9OJLF5yZ140QgFNDdJ9Qz+wHCjV0uLhi7CMxM8YpK2Y/xBfJv?=
 =?us-ascii?Q?8WvZ0j1zTUB+McckGjt8rB8Ti7gbPnrnG7xE8cPBqb4f083XvednfApdRBMq?=
 =?us-ascii?Q?/eg69B4U+vbujxrfM0jLO0x/4SjEIlzbjDgqQ/oW8CbBA5AltqC++2iz3ZKz?=
 =?us-ascii?Q?uuYfvK8aiAaY4hyoFNYOvKWII6IevtGB87S1vlq7cmu59bjpKSmMt5bEdnP3?=
 =?us-ascii?Q?rh0ly5B0eeimsVHMSNf9oTU1tGii9+5OcXsrjuHwSA6aDUrUWLFBSBFztSMb?=
 =?us-ascii?Q?wdYm358jhWL9wPHN9wlUZzF3qvLO9IFWsikyKKyCRACyifE2hRunLjUosGDE?=
 =?us-ascii?Q?au1zOOBkukzUlL3vCPkUUjtgBBn9RrwUhRHviSDyKZ3p4qt4PbnMaJPSw2pI?=
 =?us-ascii?Q?KkCoGy6N4uDi2H7dSFFUd6VCUtjNgOdoaMKtTXiv6B/8Ks1R+6iZJlSUcpWk?=
 =?us-ascii?Q?ah1xqgRfO7SSzYf4ztyhiZDse4EHPP3xgGa3c4HR/C8agOy4Z3P9NqepB81l?=
 =?us-ascii?Q?uOlVW1hU4D181C9fXQGQ1QZQTSMXwGf57xg7Q61+qu1BA80y+ohMLsBV2SJS?=
 =?us-ascii?Q?ttLlE2U4aGkNgjtxmVUPl4ZNCZfPA14tMOSQZfiwZZOM/D3jX0DvtvWcwEoy?=
 =?us-ascii?Q?hokeMlz3o9e+2Pr/TcJBPaYoBCSNB4vsmlM4UC7oT64zkbc7nt+H/PsHXNuq?=
 =?us-ascii?Q?IaXU9I7YTdZ+A6bRiNk9taJw8i6ho/DIZLWCVo8wfAkcEcIEV+k9rRHd9aW4?=
 =?us-ascii?Q?w0RPYL4Jha/YeG144WvPTu9BbybAGCVR9guJfrRydMByX55OpOvh6kHrdQFM?=
 =?us-ascii?Q?pMT4ELLdMwFEU9naFF92b087CztvLHwnM68lXnm6PAnk+nyFmwQuY8dz2VCv?=
 =?us-ascii?Q?QXg9RV5TkMN3Fs2S/HGwPPoW1AH3n+kmzeitgesoXcGKha1ZYVRj5FvvsUHz?=
 =?us-ascii?Q?4rmEb6Yaj+3rYzZHjPq9vOvC3ZrRPJI55Czc?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5257.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(38070700021)(7053199007); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?cnFaEgQSXNlF579cWlQnmhRd6uSWe4qU6Ty1Au6cp75Mot8nhNpkfo/mrsXg?=
 =?us-ascii?Q?U5WeTMvMQF2Md+sfP/EN3E3eU4gQOBywWuAptAi9Q3IobZnBcasJKe8mSaQc?=
 =?us-ascii?Q?uiF1QnOHN/cjqkloRzTskoTd1yjeyjAE+TbtbJsgvMSKLzF8VGoNZHWxX+3V?=
 =?us-ascii?Q?L4edtLtsYPgouH4xjsjcCeUGSOuxqtWE3PdVFhSIfaUUpI20LfWGWAi2i9Wl?=
 =?us-ascii?Q?TnwtD5ZEewdS8iXFHjjlt+Sb8b605FLcKUu8+faBo1DIAWECSgofPHc13gR3?=
 =?us-ascii?Q?tVEeuukOnzsimMSeWIT/VrAGsI4jFkqClf50qc37uH1ptYELy2PQE6RViOBp?=
 =?us-ascii?Q?dSvs10OMvxPh3f8GTkFWnV23PrvS2iF9fVmpwPaRB5RGW+uqYgb3GviO9jtn?=
 =?us-ascii?Q?+DK59JSmXEiTK7D3Jwp8CamlbFDFNbE6Tp7ywgvN9P1ahw62s2hzQNkaxnMn?=
 =?us-ascii?Q?m9igAayALFFAAfSfM56+Vm79nOZpQAQxv0B2wMeWwXM+PIPtQI+9xhgLYvtZ?=
 =?us-ascii?Q?dndipVqwMys/WiGUw4DAjBRJKc69KYuWP4RXH3jelPDUc4WlKClPMx8AahNT?=
 =?us-ascii?Q?PzXO4fkGijsA6erXszsWeMAqqbhvY+QwR5sM3VZ1FS15hNZ4fLC8n1KEo9fV?=
 =?us-ascii?Q?lAUUqJHdkEmgSdoBkcvsY0FRJtXJs9QICnV6IfTRqGzIACYt3kWgUcg1ZMKe?=
 =?us-ascii?Q?6WRgB+DQjI9xQ0fL8mY2IjQiZY8xXxX8bjpM4w1v/mX0wjZin4Ev4wQODF2C?=
 =?us-ascii?Q?RrQ9R8ay+L1Ozg/32vNTDS1ctuWQWYHqVzD/JZ7nN7zTSbjYfKH/EE6H6EZz?=
 =?us-ascii?Q?v9s4LHteELJIcwQJi6lKTwXjoXhmf2VYVsv3a+ybM2lF+dHqa19QH09LEgC5?=
 =?us-ascii?Q?ZjAQw0fZOiA9+3XaYjQWpX9mhYknoGjnUvtJy50BnjI2j8ugfgWDuYhYTusv?=
 =?us-ascii?Q?jXNs4Xc4+MxZIo2J3MU6xlkrqOgU8AfgAiuAfLRe4eeEDziiNhlfjSg4R8ff?=
 =?us-ascii?Q?7jRnjfO2rRH8aJPUa+Uw4VGU74uRSZBlLwG8kwIOvrt6FtxP7P58cRABFQuu?=
 =?us-ascii?Q?GfpD69Nr/1uwYdDXvzMYEhjLGcaBkVWopSguMEbKIJO7UVME/8ucl0I3/qRP?=
 =?us-ascii?Q?cwT3NpWGL3iYUYXLiMeWvf2LTN8aqDk7LqmnXwLmeXTIYUy5A4RhxrGSUNQr?=
 =?us-ascii?Q?O4XWQ1AInxXBIpwgY3yeTkI9m6d61B55G7KtlxOg89FPajdsB2eMfqnMKwbl?=
 =?us-ascii?Q?TDZZ22wcqJzkLslJM0Zxl2ekbkknvzQOrzCwA1QISqUH6XV4jYJroqTolllD?=
 =?us-ascii?Q?ew3/UtpBLy/N6xI04yKFff4NfzwsuKIPV/UBqZ5nL+9mZsuwOWhPTwlMKCEV?=
 =?us-ascii?Q?9ahKJrigxR9ykpHpssdW+j8aasGS8bgYp30CpewHiNj79pm2rqXmVx/Gs4v5?=
 =?us-ascii?Q?LUWpgAGTPCKxsxQaQR7lY/8N28nyhqcGZ2j6TzlpPneUgpykbh8iwZGZHna7?=
 =?us-ascii?Q?ZH2H3OzkvHrFLcHity51aO2vwz3YKjhx8i/AbAB6/Iv+pOl2efOXrSJFnpQV?=
 =?us-ascii?Q?w6H4g14stLfrZJUIHhg=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5257.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6b3743d3-f3d0-4f91-6201-08de2732c617
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Nov 2025 06:13:35.8122 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: rG5/FNtygfte3klGddAgvP9W26pLRpovjIEZDpyh+mLcqL97nCuA40/hDNlJELjW3n3EedJYuuQ51cvdJmsImQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB6343
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

Series is

Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>

Regards,
Hawking
-----Original Message-----
From: Chai, Thomas <YiPeng.Chai@amd.com>
Sent: Tuesday, November 18, 2025 17:16
To: amd-gfx@lists.freedesktop.org
Cc: Zhang, Hawking <Hawking.Zhang@amd.com>; Zhou1, Tao <Tao.Zhou1@amd.com>;=
 Li, Candice <Candice.Li@amd.com>; Yang, Stanley <Stanley.Yang@amd.com>; Su=
, Joe <Jinzhou.Su@amd.com>; Chai, Thomas <YiPeng.Chai@amd.com>; Zhou1, Tao =
<Tao.Zhou1@amd.com>
Subject: [PATCH 7/7] drm/amd/ras: Support sriov uniras to obtain cper data

Support sriov uniras to obtain cper data.

Signed-off-by: YiPeng Chai <YiPeng.Chai@amd.com>
Reviewed-by: Tao Zhou <tao.zhou1@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_cper.c   | 5 ++++-
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 3 +--
 2 files changed, 5 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_cper.c b/drivers/gpu/drm/amd=
/amdgpu/amdgpu_cper.c
index 425a3e564360..90e6e89b1fe0 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_cper.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_cper.c
@@ -23,6 +23,7 @@
  */
 #include <linux/list.h>
 #include "amdgpu.h"
+#include "amdgpu_ras_mgr.h"

 static const guid_t MCE                        =3D CPER_NOTIFY_MCE;
 static const guid_t CMC                        =3D CPER_NOTIFY_CMC;
@@ -559,7 +560,9 @@ int amdgpu_cper_init(struct amdgpu_device *adev)  {
        int r;

-       if (!amdgpu_aca_is_enabled(adev) && !amdgpu_sriov_ras_cper_en(adev)=
)
+       if (amdgpu_sriov_vf(adev) && !amdgpu_sriov_ras_cper_en(adev))
+               return 0;
+       else if (!amdgpu_uniras_enabled(adev) && !amdgpu_aca_is_enabled(ade=
v))
                return 0;

        r =3D amdgpu_cper_ring_init(adev);
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/a=
md/amdgpu/amdgpu_device.c
index 860ac1f9e35d..deead462a72f 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -3320,8 +3320,7 @@ static int amdgpu_device_ip_init(struct amdgpu_device=
 *adev)

        amdgpu_fru_get_product_info(adev);

-       if (!amdgpu_sriov_vf(adev) || amdgpu_sriov_ras_cper_en(adev))
-               r =3D amdgpu_cper_init(adev);
+       r =3D amdgpu_cper_init(adev);

 init_failed:

--
2.34.1

