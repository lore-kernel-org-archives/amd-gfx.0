Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 23259EDF022
	for <amd-gfx@archiver.kernel.org>; Thu, 12 Feb 2026 02:39:03 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9925E10E115;
	Thu, 12 Feb 2026 02:39:02 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="zM8u8jbD";
	dkim-atps=neutral
Received: from SN4PR0501CU005.outbound.protection.outlook.com
 (mail-southcentralusazon11011030.outbound.protection.outlook.com
 [40.93.194.30])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8F87A10E115
 for <amd-gfx@lists.freedesktop.org>; Thu, 12 Feb 2026 02:39:01 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JbEN7fl3yQFYBW6wJkiC6WbypcIrcXGwVBtCqwVmlRKx07c7/vb2WMSqlqafi0t0H3ecH28kw11vvc9RSOQaO8h8RiERFz4UaWSElVSaomSwf76ytzNIzN+qQyFZ0e4zKev4sPBOURvzE1s9hjgQjpkiM0WntpChwECdjcTuw2Ij+lHa+7ynKK3bDCjAHKsJPK3Ej1abEra9peuAPzI+S/+HwegHKgd1kR448rPx5tLzm2T400YxvppXQG3kVQpl1baJ6m63yLRvJ94HuzbyrmsBNXiVUpKLkEiZNAuThh+x5ra8I6b2rIFLRmZ2ySIuMVQ7nwvsEgiKJvFuf3e9sA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=W9FGuWPU0eVj7By88SDq8PqB2ToRNoGqpPiUvYkrSQk=;
 b=BOBibgkfhrsJvY+PFQ85Xcc19dAOKG/Pwh1EJd5sC8msievg49wMUHcS82pE1s3IWUXgzZN4BiOOaKX0ri/oOSQ+s+rT2Rv5cXE7vo1XJpIkzlXdP43y0s+T8tgyjVfjm2QrKx24RijyKBB5kJYRo9gDuRprir1x4nl24gj8C9abGG8UPZO8EP2ODztBhc9uQ2WUZ08HFUNHBSk2GHaR1jdxgb9q1+pfEAxd5K5vwA6MM+0qnBxzRtK1Wz7yik2vhX9cxMxqUpIPWdUhKt8FK3hu2UkBrlZa5Ni4vgRJ8phQUezDfJWv+oIbCMJx6nTFEIPhEdWf8BY+mP8IqFTZpg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=W9FGuWPU0eVj7By88SDq8PqB2ToRNoGqpPiUvYkrSQk=;
 b=zM8u8jbDVNXr0YC0jXTyI99YZ56NlZq59ieenf1+QcjJ5oM3et4CZZhafo1TpWbdSCaGMRySYuy+dVAxjv54W9n6OMDqbslsgKnrHVrXdAEJ2eu1q4IFexmtdO1YR5FPfss6VDL82ILC5T5xk+LKfJaEP2kj/HciAjnLpFpoJq4=
Received: from CH2PR12MB4215.namprd12.prod.outlook.com (2603:10b6:610:ab::24)
 by SN7PR12MB7251.namprd12.prod.outlook.com (2603:10b6:806:2ab::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9587.20; Thu, 12 Feb
 2026 02:38:57 +0000
Received: from CH2PR12MB4215.namprd12.prod.outlook.com
 ([fe80::6749:e799:6045:d959]) by CH2PR12MB4215.namprd12.prod.outlook.com
 ([fe80::6749:e799:6045:d959%4]) with mapi id 15.20.9611.008; Thu, 12 Feb 2026
 02:38:56 +0000
From: "Chai, Thomas" <YiPeng.Chai@amd.com>
To: "Su, Joe" <Jinzhou.Su@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
CC: "Zhang, Hawking" <Hawking.Zhang@amd.com>, "Yang, Stanley"
 <Stanley.Yang@amd.com>, "Zhou1, Tao" <Tao.Zhou1@amd.com>
Subject: RE: [PATCH 5/5] drm/amd/ras: Handle check address validity in SR-IOV
Thread-Topic: [PATCH 5/5] drm/amd/ras: Handle check address validity in SR-IOV
Thread-Index: AQHcmnMNB5uZ611haEiTkvtk1HLOhbV+W5dQ
Date: Thu, 12 Feb 2026 02:38:56 +0000
Message-ID: <CH2PR12MB4215DDA97B909DA2C81BA1C4FC60A@CH2PR12MB4215.namprd12.prod.outlook.com>
References: <20260210095233.3078476-1-jinzhou.su@amd.com>
 <20260210095233.3078476-5-jinzhou.su@amd.com>
In-Reply-To: <20260210095233.3078476-5-jinzhou.su@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=True;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2026-02-12T02:35:26.0000000Z;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution
 Only; MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=3;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH2PR12MB4215:EE_|SN7PR12MB7251:EE_
x-ms-office365-filtering-correlation-id: 5a7089d5-4da8-4115-dce6-08de69dfdea4
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|366016|376014|38070700021|7053199007; 
x-microsoft-antispam-message-info: =?us-ascii?Q?gEzOWOj2pxcQI5LlgB5J12+1PyOzbQElxDfGJ65OHANXOQVRL/0W2+3RW5ld?=
 =?us-ascii?Q?UnI7SHBGD3c8JQf9TU3ITgOb50B6GOuEDD0YmVe9K9opxJVjj0CY8wSKMSVP?=
 =?us-ascii?Q?PRxvAng6606yuizwONJ6VEcgrWPxXx7pPOmivFeiyOWhUbbq5EG+rIcrqjm6?=
 =?us-ascii?Q?ihsXCpy3bDYXm/bzC1cbL55mcF/9ZKtvNdrUBBgqUdhfFji7RwJj9U5IrNKa?=
 =?us-ascii?Q?B07ZBGxPc4LmJkQhXbmAe56uFWeWPTkOTjfFUvT3NKEIlm6I4X6GrU6nT+J8?=
 =?us-ascii?Q?t174fgQCmE+NN2ioaDNA5FSAZbkTcDMRJjBrUS1x8ha2Ucme0tC+4O1bIONB?=
 =?us-ascii?Q?XwcZ13+HVN2Lqj/NfzITrk3UCzJ0GTt5KRxXFdlHD8DyDLja1ND3LQnQmGhq?=
 =?us-ascii?Q?qZw5JDlInvmrOLyRyMpKFZMTVOLN6W4d2ikdEwJtDLIf/PxOxtl8XcrfqAHW?=
 =?us-ascii?Q?6wpGZNY/9s0LIpzSD+84sbf4c4oFIFdtOm7OUUAThEhDhgddfnHR+DmBkOii?=
 =?us-ascii?Q?gHXJrcBtjoYOuJ3tvzl6xwRUhDXC1Cf2Sr4YoBg3zvZhtM/aEejTnPczO6Mf?=
 =?us-ascii?Q?wGy2twVKfJUTGrYTty87NcjSjmx7H0dOjy9/2nSLgaZaCtwwiPd7SAijj72X?=
 =?us-ascii?Q?6IddE6Ebs6CedVh/IuxoxYM6XGMMxXcUcCG3PSMDci8mr6y2eKgWMejM02zD?=
 =?us-ascii?Q?nAgMRUdXY1wLMNfHIfeqWTPvOJGcv2JRQWdbv9yiECUWhgW+NvNal4m99RI/?=
 =?us-ascii?Q?nGYqIuMO/oJptWK4VWifGWpBSRYOrKqDlHFrEtAnGM1vxEswS3YFHLh16kee?=
 =?us-ascii?Q?y1ZmILC4UE60+Qin059cxKkkRX3m2t+Gwae1ingGv5HUx2xhpLd0TAw52swt?=
 =?us-ascii?Q?tON6Qj+q+tfv8ExWJPVClpL80gDRCb6R3FT6hXi43ig1ENToYjGk9WGV8vaB?=
 =?us-ascii?Q?L+xBEm3wW9u3s1MvzDxXDzfU/jA9mgLBT9Nyy64A0h/DcpYnSNS2WceeI7J1?=
 =?us-ascii?Q?HP25+1dOxu3QiDxZ9x8aLFcZXZ55Vebe0I/0V0pqEQwOsme9PrPWjWgnlUtE?=
 =?us-ascii?Q?70+W68N8KP2hPTwJEDnx6J1hERNLc/KvFnhPXi26SSb37FLlqiLZuK7dZTBf?=
 =?us-ascii?Q?nYcR8FY4zALFBbA3SMrS1e/QOnQPcJ9nHzvx1jv2Hs7XgLqNe8BDbXSw8lAS?=
 =?us-ascii?Q?aCrTkFid3EQ8cFgRvynj69zs12tmQkAhaHt23a+vcnGEIizpJFIpUDOHnFgG?=
 =?us-ascii?Q?W4chBcs2VQCmaMHWavDKhiH3hrAWJ7a5KR1qsTKuHQFC7Wsz/v2PcRzlm5P2?=
 =?us-ascii?Q?EasBLejOQQJ60m1SAfNKC0kbU/fjLJWO3+5e05pdVy2fViJFxZejOMdTZ406?=
 =?us-ascii?Q?Njk6iVFiYhMvrkW/O669qP3FyHclPhAFfx847+Tr7rmGxIdqJqfCX+QYISwJ?=
 =?us-ascii?Q?AzMGeWjdjMbP3bRh/zSkX9TWkKdrggyhNfIvHicZQsZgOKzC5jMtJvyVCk9b?=
 =?us-ascii?Q?k3w6lgiBW5FTo6dHy9IpLWTQFGKO0Ij5mC5pmyTZPzCzzne7JqmdgjutcRoD?=
 =?us-ascii?Q?ZHU86oHIgqXe4d327dZRLqvG9AQMymPnfvE3FM9+CLcZ9RqPRiWyhOkxD/RO?=
 =?us-ascii?Q?JxE7td24T0iOJ/pItMr7dc4=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH2PR12MB4215.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(38070700021)(7053199007); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?/xpziQEFxop+/O2zK8X55PJatAP5r/8/yVyEJ1x0aXd3nTw+s5kHCg85FN2c?=
 =?us-ascii?Q?dwnksVYowlpfBwXV0OJC0MUSZF/+OMynI73sZHLZF092DsMvg7Ig2eTt5DQo?=
 =?us-ascii?Q?jNk36yOWyuRL3KCYJYtvvOqFmFG3n8gfVj1i2JtclZM4mFwklqrcfOqEF90L?=
 =?us-ascii?Q?qjxtZYpjCGjntAmBDK6R6HJ/rvAucxeNgZ5Gptkv/WToYa8eLE6D+xB+F2yY?=
 =?us-ascii?Q?HTQsw78Cv/gMMY4UH7REr2mL9cb05Gj1OZ9+QSKFaQdc/21eh5JslxqYt+kQ?=
 =?us-ascii?Q?J3KS8gW+0Ik+Ho9PQjQkdt9/L5Fgxi2vWc994w7DFTaS2p18CYWR8RDHHYlW?=
 =?us-ascii?Q?es+AxONRr3eiG1d3kF/TdxoTKsTVOminv8pKOGok8Nx5A5hjDMWutgnxN7IH?=
 =?us-ascii?Q?Y16sQCAcmJejVCmb5reCacmX4alh2J5V+sjxKabVoXKTwUtdak4no/F3qow8?=
 =?us-ascii?Q?cxOjcEZh0Tz5wWqxSG2SXbwRMHWQwrN3IhD1YwDHq7d3myAn/IpgglJ0++9o?=
 =?us-ascii?Q?UK8tdbsZMlPx837Eey+k3j+FI57Ss8KuG2RftmsVBQPqUrCd601Jcj3pvlH4?=
 =?us-ascii?Q?MBBHd1gKOQhFMU3dP54BtN5UaljRlNjQvdoSlwy/MWyLBVgOnVZbSBzxZk/x?=
 =?us-ascii?Q?2oS2ZkRxyoQUSdQxfaEXZawB3kgofuki6CyW9qYhvryW/u3phyF5d7eZhh9t?=
 =?us-ascii?Q?WxyuaEf+dp1ffb8hqDkIwp4SQL3kTWUgTvXlQ1/6sxetHtTb1BOShX+TVNFk?=
 =?us-ascii?Q?UgsNzIGsX47OM0fudtokysdWvQ81jwjhfls7YPrMIQrfLIoOEoqXrOgja5DC?=
 =?us-ascii?Q?1ZbPEZLcHmoLDHL3imov6m17f6gni9SZkh6eaqxfbGtrCgA8wnuCXzC/5NXH?=
 =?us-ascii?Q?M4ti/0WZQuu4WW2fYUYpBt4LdNEvqmyGGzNf1NOfOSKvD9FgzO82c4Hfq7wM?=
 =?us-ascii?Q?XW8pg1k+ufy2U0WDgLAHYhGEaDuQM8YCAdCTtcfmSAjRwtVPqe8eFnl4w5wx?=
 =?us-ascii?Q?nZLKaNHHU52Z/eIvj8mr2niXWpxNvj2xO7IrfTTgRxInN9TOaL/HXmQmOUKt?=
 =?us-ascii?Q?fZm5eULO3cbm9U00V9nAe5dj8YQY3mgq+49UdUPn7z5juADWN287TwLQ1oGN?=
 =?us-ascii?Q?Pexg97lNo4xXEqChuNs5+vwuT92ogg7uTliqwURrr0ZsIzgfiP8sFjq6Uff9?=
 =?us-ascii?Q?Z63VpCp8thTBkFDYa7ItlpZqgFpmC1C385A1I08gp/4/0CRh0JZ28+Kd9BL6?=
 =?us-ascii?Q?1wVxRBqvOgG8zLVnGy5Y0ET13u+DAleJ6wlgL9xxFMGaHL3cPuEZd6BUJ07v?=
 =?us-ascii?Q?3Zc2sZ4gBVM8eE+wQQGcnDRRw57IF7B4lDVpsVnWeHVlWB0AyR9t6NjkIbA3?=
 =?us-ascii?Q?o2XlAcZx+EV/F6quKJqLH69dT8XNIUEPys+E9pZtv2J/syRDzwlPi1XufXYW?=
 =?us-ascii?Q?KENNSwTd+bLQP3krfrtdXVsiKnEo246fz46TXkj9V5+I1YMagKOiLiPdaePj?=
 =?us-ascii?Q?TiNjsE7oSbCp9JykIytgwM+R7S8Gyrp3L4J5ghvpdSsvUo/Y0h8wqtpAiTlY?=
 =?us-ascii?Q?vBRCc4OZiuG2v8azieT8L/tZRcYhknrQeSzR8CmY//72f83ei0vgLTAdDqZ7?=
 =?us-ascii?Q?4YwYGWLNART7p8SGVmn3ZfLmYdJBNZadGx0yttJX1wgiFjP0euCjwBy3OT+2?=
 =?us-ascii?Q?mQU9SZTTqLP60dmmUVqlz3LnxjNPE1JFi07zqtRbIRYHeyJR?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH2PR12MB4215.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5a7089d5-4da8-4115-dce6-08de69dfdea4
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Feb 2026 02:38:56.7051 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: /bh21D0rnRLQJiZzwVsjAdhzqu4/xDMiZ7hHyfnfu+TVemKxuj+wG9nHnGdCEfB02uPOshdYNitUK7LLU4sHAQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7251
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

The series is:  Reviewed-by: YiPeng Chai <YiPeng.Chai@amd.com>

Best Regards,
Thomas
-----Original Message-----
From: Su, Joe <Jinzhou.Su@amd.com>
Sent: Tuesday, February 10, 2026 5:53 PM
To: amd-gfx@lists.freedesktop.org
Cc: Zhang, Hawking <Hawking.Zhang@amd.com>; Yang, Stanley <Stanley.Yang@amd=
.com>; Chai, Thomas <YiPeng.Chai@amd.com>; Zhou1, Tao <Tao.Zhou1@amd.com>; =
Su, Joe <Jinzhou.Su@amd.com>
Subject: [PATCH 5/5] drm/amd/ras: Handle check address validity in SR-IOV

Handle check address validity command in SR-IOV guest.

Signed-off-by: Jinzhou Su <jinzhou.su@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c | 26 ++++++++++++++++++-------
 1 file changed, 19 insertions(+), 7 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c b/drivers/gpu/drm/amd/=
amdgpu/amdgpu_ras.c
index 4c890cfea1cc..ff759f6425fc 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
@@ -42,6 +42,7 @@
 #include "amdgpu_reset.h"
 #include "amdgpu_psp.h"
 #include "amdgpu_ras_mgr.h"
+#include "amdgpu_virt_ras_cmd.h"

 #ifdef CONFIG_X86_MCE_AMD
 #include <asm/mce.h>
@@ -228,19 +229,30 @@ static int amdgpu_check_address_validity(struct amdgp=
u_device *adev,
                return 0;

        if (amdgpu_sriov_vf(adev)) {
-               if (amdgpu_virt_check_vf_critical_region(adev, address, &hi=
t))
-                       return -EPERM;
-               return hit ? -EACCES : 0;
+               if (amdgpu_uniras_enabled(adev)) {
+                       if (amdgpu_virt_ras_check_address_validity(adev, ad=
dress, &hit))
+                               return -EPERM;
+                       if (hit)
+                               return -EACCES;
+               } else {
+                       if (amdgpu_virt_check_vf_critical_region(adev, addr=
ess, &hit))
+                               return -EPERM;
+                       return hit ? -EACCES : 0;
+               }
        }

        if ((address >=3D adev->gmc.mc_vram_size) ||
            (address >=3D RAS_UMC_INJECT_ADDR_LIMIT))
                return -EFAULT;

-       if (amdgpu_uniras_enabled(adev))
-               count =3D amdgpu_ras_mgr_lookup_bad_pages_in_a_row(adev, ad=
dress,
-                       page_pfns, ARRAY_SIZE(page_pfns));
-       else
+       if (amdgpu_uniras_enabled(adev)) {
+               if (amdgpu_sriov_vf(adev))
+                       count =3D amdgpu_virt_ras_convert_retired_address(a=
dev, address,
+                               page_pfns, ARRAY_SIZE(page_pfns));
+               else
+                       count =3D amdgpu_ras_mgr_lookup_bad_pages_in_a_row(=
adev, address,
+                               page_pfns, ARRAY_SIZE(page_pfns));
+       } else
                count =3D amdgpu_umc_lookup_bad_pages_in_a_row(adev,
                                address, page_pfns, ARRAY_SIZE(page_pfns));

--
2.43.0

