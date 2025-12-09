Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CFD4AD3B7F8
	for <amd-gfx@archiver.kernel.org>; Tue,  9 Dec 2025 15:53:26 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 571E510E1FC;
	Tue,  9 Dec 2025 15:53:26 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="xI9KF52b";
	dkim-atps=neutral
Received: from SN4PR2101CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11012026.outbound.protection.outlook.com
 [40.93.195.26])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F042B10E1FC
 for <amd-gfx@lists.freedesktop.org>; Tue,  9 Dec 2025 15:53:24 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=A4Te5z2yNGixXAIuRq2mJ7UYnCPD5f6H7nY0H4aPTrUHPjAjPKY3RXTns1Fkfd3qg9rrpLbwNxSwk1yOmmu8OX9jnJ1IkGO4VEPHkJdznCfdveEsrYdjiBuOkxNJSmoUPltTvUaoeag71/kO/dOjOQrize/g5Gf7i/2Jjp04EtZcLjO4PtBlXiS1kzXGMaIRAWv6K9Jq3EollBxN0QEhOiHHN2tiZhkN7BFN68/WVUYpHgrsCwVoMWVZ8ap136ClFz85NtkA4ZpUHJp36cokSSQMBDtrydmiZ/feO5Yfunk4ITRGPPyQMUYC8w7tx7yv1+1XHP3PACT9ZIwv8uFiYA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EeH4G/O1LvmEQtah47lcOVwYadoqfWfJNcjUlSTu7pQ=;
 b=sV5aM0qHJmlZ+x/wTC3J4JE/gUprahN+dr+H6l9z3+M+brVjZhXfeMLeI4w9KYVgZ4IR4wi3GlEwXzHsRpEjZWPIZpukULTdyz9rkJpYuDKWiI6K1AnjbRDmV9LhFr4NthcGIAlxaq98DZn9UpA0sNJ39HfnnSO36fEhWgtbFWpND1lPQ/A8rHHtBOnvbGrk+xY5ghmko1Cl75a5UvOfGIsxa6T52YK0+U1CKP3JyGyfnUdx1NzIFWwxFbyaKdr9Qc3oWe6wG3sU9x0HAx7Nu0FWDtkAnHanZ1SV6h23ger2VWOWHGLZ1o+Okid4ph0jd8I8UjJQG0bBzRw+ZNhFVQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EeH4G/O1LvmEQtah47lcOVwYadoqfWfJNcjUlSTu7pQ=;
 b=xI9KF52bk+pE2haVsK8TGFch7MKkUpIKqJIsiLrps3NA+A1LxJjDEi5w05/CiGrpevqZYkhSSA+wVdvUlTib/oELF5RApTVFqiYTxDgYrxoNvaYhW9zxl6Iw9/aDgYn0E3rqyCAY5b95xpjJsMG7SD/2jXj4aBbOQyq6Fj0vrFw=
Received: from IA0PR12MB7675.namprd12.prod.outlook.com (2603:10b6:208:433::9)
 by BN7PPF915F74166.namprd12.prod.outlook.com
 (2603:10b6:40f:fc02::6d9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9388.9; Tue, 9 Dec
 2025 15:53:19 +0000
Received: from IA0PR12MB7675.namprd12.prod.outlook.com
 ([fe80::b2f4:4979:b048:3060]) by IA0PR12MB7675.namprd12.prod.outlook.com
 ([fe80::b2f4:4979:b048:3060%2]) with mapi id 15.20.9388.013; Tue, 9 Dec 2025
 15:53:19 +0000
From: "Kasiviswanathan, Harish" <Harish.Kasiviswanathan@amd.com>
To: "Yang, Philip" <Philip.Yang@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
CC: "Lazar, Lijo" <Lijo.Lazar@amd.com>
Subject: Re: [PATCH] drm/amdkfd: Handle GPU reset and drain retry fault race
Thread-Topic: [PATCH] drm/amdkfd: Handle GPU reset and drain retry fault race
Thread-Index: AQHcaSG115kiYGI7mEq5VKDeOMlW77UZdYkX
Date: Tue, 9 Dec 2025 15:53:18 +0000
Message-ID: <IA0PR12MB7675E00D1763E5E4C21D74A88CA3A@IA0PR12MB7675.namprd12.prod.outlook.com>
References: <20251209153706.195420-1-Philip.Yang@amd.com>
In-Reply-To: <20251209153706.195420-1-Philip.Yang@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=True;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2025-12-09T15:53:19.113Z;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution
 Only; MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=1;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard; 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA0PR12MB7675:EE_|BN7PPF915F74166:EE_
x-ms-office365-filtering-correlation-id: d6dbab10-aa31-4d67-fef2-08de373b12b3
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|376014|1800799024|38070700021|7053199007|8096899003; 
x-microsoft-antispam-message-info: =?iso-8859-1?Q?XMRMRwp7/01YP23hkBvAVpgV40XETU78xgZJeIHmfNgpnB5mNSP9IlHtfR?=
 =?iso-8859-1?Q?J8+VPpXmlKOZxjx+Nu1URdoF9bMjzVIDRKpD/6UsHfbfQmRqCgoergGQTb?=
 =?iso-8859-1?Q?PN5JoHXPSzrl+LoccnQQ9Ri1dYnkWdUXxskXpWQOZ89C0j5wTXrEuetvey?=
 =?iso-8859-1?Q?22eCuzFpU9aryLMKyQ8zZnPq/uMWSGACiLe2tr8Iz+F87YZr5qIm0szZuz?=
 =?iso-8859-1?Q?lmQEMxfdFLky5BZdDF/Pa4S2Hpc/qZkIw63RQo/N78Rvvc9YuI/R41KS67?=
 =?iso-8859-1?Q?PZk2f1HFMsFu747nsEMMpWbioHBqntNaj/NU87yPeDL1ZRE0mUpAWYL6c7?=
 =?iso-8859-1?Q?WU/XuQ/bBMELKF6a0vaqJScrK8bVPNmVmojnnYbm14LoyL6Fhsx9Q82djD?=
 =?iso-8859-1?Q?89cBN9UbtoonWLH9TB5PBh9GCj6Bo1CtXWrusVtz5mssx8Q2AMCMBc3Adg?=
 =?iso-8859-1?Q?1rzyqD7XHF6tOcDbn+NbGmnk6QjSEq6QfNs4Nl+D+yRdG4q6x6/TYHOKJV?=
 =?iso-8859-1?Q?uGAAzzFUTfmUXsPGL4gI8U3/WDk9GJrd3Z1BhEZM2pZy9ip7rU8B1izEos?=
 =?iso-8859-1?Q?rnNLyHMghZTEJBPaeCnkJ7qDXwivOZnX1WXplJmxOUge7p5BCeKaSQ18g/?=
 =?iso-8859-1?Q?N8mNFZcq9O68kX6fR5gfcBUOdn0khdr/89V0CUby5Qj8uLRLdbhoSW6URB?=
 =?iso-8859-1?Q?SZm7yFBGmivfDUI/L2twXbo082jT2MGo2if3ItR6tDqvhHpVETc183TI9P?=
 =?iso-8859-1?Q?IW1C++Z+Fn2Mf/JXNQZ589t3NDvXBffP3DkyX7KW/cStVWk2bsPer0EG+Z?=
 =?iso-8859-1?Q?nnqhQ6WMIm9w+djpPykpM3u1jqD0CRuhy/Lwrfa97jgooJt1vAOJv4HxH8?=
 =?iso-8859-1?Q?Go+7Y3gO5sbaM5SI6jnIw625+DYB+9IFU0sWP+yoNxKYHZeETNrVULet8g?=
 =?iso-8859-1?Q?0za0rfexHPCLNhfHCUWLTem5aUOcTPD7OnA7Z+jm01jebImDzK8WYqKD8m?=
 =?iso-8859-1?Q?dE0jW1WZkZMXHmZGj6QhcdrN2a61dPnLGEDXG/OyA6Oa31gA3CAw7VacE+?=
 =?iso-8859-1?Q?ERQEbwLIgN5sQ/bEv/JCGxDG7hwfEheS9O1g1hGAAIAwBdOdk7oN9Nlvd/?=
 =?iso-8859-1?Q?j9TZ9AUO7SvyvpjverYle12i+rMaJ5sPrdiH4sxIRuREHKnEYzOulSI45P?=
 =?iso-8859-1?Q?FFwCeSP4Q58iPotcGwtr1vRvKU2SqNpugbTklYlLANtdmv2uEx6slA8TkT?=
 =?iso-8859-1?Q?I9LOeIocDabglKMBxKydxWLVA4DYAPOOrAN9cFr99Ci+1g3JanOyW/U5Qd?=
 =?iso-8859-1?Q?2SrkO1PC8IGEmJW0X5tKHyG1gN4DIciXFUGWE1UEmemICB0WNkx6bG2++T?=
 =?iso-8859-1?Q?JYgt3A0gtohfsadQP2xH35I6FSurSigLBLJbLLaeanj9uhapZQuL/I6Ci1?=
 =?iso-8859-1?Q?hZzQ1TeOA2jSciOabwoBfTrJwTpGlELeohzfwymiMPDELpdW/iAIwQScJR?=
 =?iso-8859-1?Q?gL0cHS0sjxYKZMUweKD2xk30jS510hioSJRGvFfuxD4w5fqrVpnKYRh+gD?=
 =?iso-8859-1?Q?KShSiJ+SAXg6M3oAXWI71Dbu3Bnh?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA0PR12MB7675.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(38070700021)(7053199007)(8096899003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?uTAQ6dwF5aE9cvCSrJaxkCYZtJEkuNs8kYtuvqhYtdfzcEZ05PbYeWvfBU?=
 =?iso-8859-1?Q?KsZY3sGz8mEH11apI5rSSHQ+6+pIz3wJMOOB6J0X6LtQ35KqFoXBs1CHah?=
 =?iso-8859-1?Q?eYi8tT5+bNoQDbaHDNkd/smyii35JbsT9wIulWkJHDxwHJjgPnsxr2QebI?=
 =?iso-8859-1?Q?6FoTg78uECH96LM/rkOV6hppyMlULnvGMxZZ+ymws5xe4OGHoT6hH+HPN0?=
 =?iso-8859-1?Q?Vok6Tpp8FiVC5wM+SuSnfdNdhGsro/3sjYy5nMbkV+C7E03ky36DQIxKZf?=
 =?iso-8859-1?Q?iyKNhSQ8s3PkNMolzKyTThkUkDsUWkG8m3zAsWxObnyT4od3MdPjCAtStn?=
 =?iso-8859-1?Q?aHtUYQl1mXefmA0M8veHdUf2fhE1iKHYDqrDRfN5ycdpy+t/cnx0iXuDGM?=
 =?iso-8859-1?Q?dYQO59/ugDhBZl63VoyAmQm5f/xvnHnTfhvxXD5OECeO3AGWCxJEsdEX2/?=
 =?iso-8859-1?Q?xsij7/INZvPmsFAsAo8I8/kO7bYhOcVNI8OzjdMUf3ID/CwxjcFn7qJ52o?=
 =?iso-8859-1?Q?iDrWXGS9Yn/pg/Dk4ejlSm7Ge/H0+ymU6Noz4FpfSq+uXTT8D8rAc2OoDa?=
 =?iso-8859-1?Q?eqDujc5eAluOYyXMPCMZ9JO7egt9dvO2MVEVz7Ta7nOtM++Ob6kRH7owbA?=
 =?iso-8859-1?Q?tdOdudZywA4OHwHfGR2WPhH2rTynwCeEFnTQxZzjxHa3a1hpY0s7KYg91K?=
 =?iso-8859-1?Q?JQs1UkYrJsNEgUv8/rhAsSkzVXSTR/HpsHXfK6L1L/Bg247nc2e/Q8o/tZ?=
 =?iso-8859-1?Q?88TB/DNBaWR7ZYxf2uYbVtCaMYX5A6IihmOXAjHqob2SYJjgUkZhz2UkxX?=
 =?iso-8859-1?Q?jquEuDSIzae208Ug+BP+bqFPPNQAHLkiilljenwKksvLmBTVegVkrQ+5zW?=
 =?iso-8859-1?Q?MQVoxgiFUrqnbjydc5KC654kigf+aAYxp/ZN/DP2GuTFRNXuPBPn08ibAr?=
 =?iso-8859-1?Q?mLVAMdjE08+OOTptrE6tUm/ptOhVZEbJZn2hTn4MFfMTzUVM6/u4MRyd85?=
 =?iso-8859-1?Q?3R+e0sFgRL759is2BDNDuMdVZ51qq3ZDOeJ6Ea3FBahruAM/SG+O5hwh0O?=
 =?iso-8859-1?Q?cC4d813r40mYMzpAZjZ16x19MII9jBMSbK+la6mIV/abfan4kNKwpwDV/T?=
 =?iso-8859-1?Q?i+wXEZ+24yAhvLf1VG4NtsZQ4IwuIokd/mS+6sdw+cF7Hop9LrW01qTmKg?=
 =?iso-8859-1?Q?628AIbu4r61oiIsftpzaWdQXPc3dKjxAyz5eDIFA1EecpFh9ucASVfIv6H?=
 =?iso-8859-1?Q?vqfoPvIPUYI3LqH+HClhTb9nlzU81IxkXbFdJL94NK8wwCqRJz+OXyhsU2?=
 =?iso-8859-1?Q?jTZJ76WQmlgypp4IBsSSLXIN0IQsZ5MIk09tJWHzB/fXW4DG0yf2BxbeA7?=
 =?iso-8859-1?Q?eXhH5Vtjfo9NamJAwAqo/s7bXbtL6xhac//8qdW1/um1YAa7fmU0Xvl2fP?=
 =?iso-8859-1?Q?6a3XZwSL5DO+1QKbHzjZsLAMx9jzc/gAkuMrEkyZbUpeITn0cG8OivUeZP?=
 =?iso-8859-1?Q?OxPAgQsaGZ/D60AdwifukZsZZ++w89h5k2KdS8eKwTcbXQSJGQK2TxcFAl?=
 =?iso-8859-1?Q?eu8pxRkUWcoiC5dtG2cC/Gvku2HgLGRnAvFfwnkLk8xZ5C298ZGSMSnCBM?=
 =?iso-8859-1?Q?kk6tBOpbvqdk4=3D?=
Content-Type: multipart/alternative;
 boundary="_000_IA0PR12MB7675E00D1763E5E4C21D74A88CA3AIA0PR12MB7675namp_"
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA0PR12MB7675.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d6dbab10-aa31-4d67-fef2-08de373b12b3
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Dec 2025 15:53:18.9183 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 7WBNWeMxKc8h1Pjl+JAvLqUZEDzC1zEGLhWqkMUbavxLbAu91iN15/dA1XDRo7GaWj9Ar57IGMls+kF5eORJvA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN7PPF915F74166
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

--_000_IA0PR12MB7675E00D1763E5E4C21D74A88CA3AIA0PR12MB7675namp_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

[AMD Official Use Only - AMD Internal Distribution Only]

Reviewed-by: Harish Kasiviswanathan <Harish.Kasiviswanathan@amd.com>



________________________________
From: Yang, Philip <Philip.Yang@amd.com>
Sent: Tuesday, December 9, 2025 10:37 AM
To: amd-gfx@lists.freedesktop.org <amd-gfx@lists.freedesktop.org>
Cc: Kasiviswanathan, Harish <Harish.Kasiviswanathan@amd.com>; Lazar, Lijo <=
Lijo.Lazar@amd.com>; Yang, Philip <Philip.Yang@amd.com>
Subject: [PATCH] drm/amdkfd: Handle GPU reset and drain retry fault race

Only check and drain IH1 ring if CAM is not enabled.

If GPU is under reset, don't access IH to drain retry fault.

Signed-off-by: Philip Yang <Philip.Yang@amd.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_svm.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c b/drivers/gpu/drm/amd/amd=
kfd/kfd_svm.c
index 377dd75f026b..89c5163b867d 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
@@ -33,6 +33,7 @@
 #include "amdgpu_hmm.h"
 #include "amdgpu.h"
 #include "amdgpu_xgmi.h"
+#include "amdgpu_reset.h"
 #include "kfd_priv.h"
 #include "kfd_svm.h"
 #include "kfd_migrate.h"
@@ -2367,6 +2368,9 @@ static void svm_range_drain_retry_fault(struct svm_ra=
nge_list *svms)

                 pr_debug("drain retry fault gpu %d svms %p\n", i, svms);

+               if (!down_read_trylock(&pdd->dev->adev->reset_domain->sem))
+                       continue;
+
                 amdgpu_ih_wait_on_checkpoint_process_ts(pdd->dev->adev,
                                 pdd->dev->adev->irq.retry_cam_enabled ?
                                 &pdd->dev->adev->irq.ih :
@@ -2376,6 +2380,7 @@ static void svm_range_drain_retry_fault(struct svm_ra=
nge_list *svms)
                         amdgpu_ih_wait_on_checkpoint_process_ts(pdd->dev->=
adev,
                                 &pdd->dev->adev->irq.ih_soft);

+               up_read(&pdd->dev->adev->reset_domain->sem);

                 pr_debug("drain retry fault gpu %d svms 0x%p done\n", i, s=
vms);
         }
@@ -2559,7 +2564,7 @@ svm_range_unmap_from_cpu(struct mm_struct *mm, struct=
 svm_range *prange,
                 adev =3D pdd->dev->adev;

                 /* Check and drain ih1 ring if cam not available */
-               if (adev->irq.ih1.ring_size) {
+               if (!adev->irq.retry_cam_enabled && adev->irq.ih1.ring_size=
) {
                         ih =3D &adev->irq.ih1;
                         checkpoint_wptr =3D amdgpu_ih_get_wptr(adev, ih);
                         if (ih->rptr !=3D checkpoint_wptr) {
--
2.50.1


--_000_IA0PR12MB7675E00D1763E5E4C21D74A88CA3AIA0PR12MB7675namp_
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
<div>
<div style=3D"font-family: Calibri; text-align: left; color: rgb(0, 0, 255)=
; margin-left: 5pt; font-size: 10pt;">
[AMD Official Use Only - AMD Internal Distribution Only]</div>
<br>
</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 11pt; color: rgb(0, 0, 0);" clas=
s=3D"elementToProof">
Reviewed-by: Harish Kasiviswanathan &lt;Harish.Kasiviswanathan@amd.com&gt;<=
/div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 11pt; color: rgb(0, 0, 0);" clas=
s=3D"elementToProof">
<br>
</div>
<div id=3D"appendonsend"></div>
<div><br>
</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
<br>
</div>
<hr style=3D"display: inline-block; width: 98%;">
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
<b>From:</b>&nbsp;Yang, Philip &lt;Philip.Yang@amd.com&gt;<br>
<b>Sent:</b>&nbsp;Tuesday, December 9, 2025 10:37 AM<br>
<b>To:</b>&nbsp;amd-gfx@lists.freedesktop.org &lt;amd-gfx@lists.freedesktop=
.org&gt;<br>
<b>Cc:</b>&nbsp;Kasiviswanathan, Harish &lt;Harish.Kasiviswanathan@amd.com&=
gt;; Lazar, Lijo &lt;Lijo.Lazar@amd.com&gt;; Yang, Philip &lt;Philip.Yang@a=
md.com&gt;<br>
<b>Subject:</b>&nbsp;[PATCH] drm/amdkfd: Handle GPU reset and drain retry f=
ault race </div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
<br>
</div>
<div style=3D"font-size: 11pt;">Only check and drain IH1 ring if CAM is not=
 enabled.<br>
<br>
If GPU is under reset, don't access IH to drain retry fault.<br>
<br>
Signed-off-by: Philip Yang &lt;Philip.Yang@amd.com&gt;<br>
---<br>
&nbsp;drivers/gpu/drm/amd/amdkfd/kfd_svm.c | 7 ++++++-<br>
&nbsp;1 file changed, 6 insertions(+), 1 deletion(-)<br>
<br>
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c b/drivers/gpu/drm/amd/amd=
kfd/kfd_svm.c<br>
index 377dd75f026b..89c5163b867d 100644<br>
--- a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c<br>
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c<br>
@@ -33,6 +33,7 @@<br>
&nbsp;#include &quot;amdgpu_hmm.h&quot;<br>
&nbsp;#include &quot;amdgpu.h&quot;<br>
&nbsp;#include &quot;amdgpu_xgmi.h&quot;<br>
+#include &quot;amdgpu_reset.h&quot;<br>
&nbsp;#include &quot;kfd_priv.h&quot;<br>
&nbsp;#include &quot;kfd_svm.h&quot;<br>
&nbsp;#include &quot;kfd_migrate.h&quot;<br>
@@ -2367,6 +2368,9 @@ static void svm_range_drain_retry_fault(struct svm_ra=
nge_list *svms)<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; pr_debug(&quot;drain retry fault gpu %d svms %p\n&quo=
t;, i, svms);<br>
&nbsp;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; if (!down_read_trylock(&amp;pdd-&gt;dev-&gt;adev-&gt;reset_domai=
n-&gt;sem))<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; continue;<br>
+<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; amdgpu_ih_wait_on_checkpoint_process_ts(pdd-&gt;dev-&=
gt;adev,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; pdd-&gt;dev-&gt;adev-&gt;irq.ret=
ry_cam_enabled ?<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &amp;pdd-&gt;dev-&gt;adev-&gt;ir=
q.ih :<br>
@@ -2376,6 +2380,7 @@ static void svm_range_drain_retry_fault(struct svm_ra=
nge_list *svms)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgp=
u_ih_wait_on_checkpoint_process_ts(pdd-&gt;dev-&gt;adev,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &amp;pdd-&gt;dev-&gt;adev-&gt;ir=
q.ih_soft);<br>
&nbsp;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; up_read(&amp;pdd-&gt;dev-&gt;adev-&gt;reset_domain-&gt;sem);<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; pr_debug(&quot;drain retry fault gpu %d svms 0x%p don=
e\n&quot;, i, svms);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
@@ -2559,7 +2564,7 @@ svm_range_unmap_from_cpu(struct mm_struct *mm, struct=
 svm_range *prange,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; adev =3D pdd-&gt;dev-&gt;adev;<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; /* Check and drain ih1 ring if cam not available */<b=
r>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; if (adev-&gt;irq.ih1.ring_size) {<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; if (!adev-&gt;irq.retry_cam_enabled &amp;&amp; adev-&gt;irq.ih1.=
ring_size) {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ih =
=3D &amp;adev-&gt;irq.ih1;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; check=
point_wptr =3D amdgpu_ih_get_wptr(adev, ih);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (i=
h-&gt;rptr !=3D checkpoint_wptr) {<br>
--<br>
2.50.1<br>
<br>
</div>
</body>
</html>

--_000_IA0PR12MB7675E00D1763E5E4C21D74A88CA3AIA0PR12MB7675namp_--
