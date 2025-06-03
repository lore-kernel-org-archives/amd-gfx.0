Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6CE81C5B555
	for <amd-gfx@archiver.kernel.org>; Tue,  3 Jun 2025 13:01:03 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DD37510E5BD;
	Tue,  3 Jun 2025 13:01:02 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="POxNUyrd";
	dkim-atps=neutral
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2073.outbound.protection.outlook.com [40.107.92.73])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9BD5010E5BD
 for <amd-gfx@lists.freedesktop.org>; Tue,  3 Jun 2025 13:01:01 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TZk4bfY4LymXbEApdg4HZHs3WpnnlkFgEQXKsjTXUO49KTD+MRsODOziDxrVvEZMPOkfdx1jkwNbunljiQhYmNjZXZWyl54zuYijivmuAJ+O7cKJQIfK7vzfFyv/EYShCfmZ1aIKtf+mAQPbp2ON3w+ialdA41n9VNnROD6LuUHhuJWJEZwIKMFYxy32EPaujK6G6zu7uJktS7z7r0rrErzr1oLBJkh/Sy3czCfg7jKMKrgiAgkfUAlr7yY3ibY1uwbmLEioBu2uuFdkksBbgR5bqmUcJQsKfYu9dUbiNVRYF5RBoQpqKP3ZR8lopsC/Z9HzZ4lnODqheDqMtYL4aw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jreHHOszTDJLGrD4b9xVS0N1pPofqbmBDr4VPmNpTiU=;
 b=p5ZEo2rbJUzbUFy8kviPjyVmKlWNYzmzYCo55BTLC08M5ctvzh/TqavwbjZj5eEdgCnNjmASibX5NYDFnYvK1Kn35+ZYi2l1VUDLXlauIHHu87MRZ4j0w2zYV0XUw0HgzAsjdqMKTb95YXSxqIf1kvY2IOilRqGHL34IawP66d+cRD7i6GTF/WrnmS8OxtWLwNr3oo56b7GfyzH7OQBpwwlZs3zqePOyfpt0Q33o+mXT8hL2725frgaMs3MM5OpXEZeR3mz6PEIZKRjxBBapo2XNNeBFBykgY28nv2xOT++rxxuh1+L62SiSNmR/irnBIIfn04cOK56OMHGKm4c+VQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jreHHOszTDJLGrD4b9xVS0N1pPofqbmBDr4VPmNpTiU=;
 b=POxNUyrd+um0DJ/lIi2T+qAr8FHLvZLVC/YPrOvEo0In9VO/Bp604UXIgeEjUSbZCoSRWF/EMRDDE3PU7VDzGISMyeBP2G/iOyFJ7wa4cxcz+xlY1UNSzLY8adv3ppK6zPhY47zVGemgLztPQuhLVJ0NnXS4leVWeal4AwOsGYM=
Received: from BN9PR12MB5257.namprd12.prod.outlook.com (2603:10b6:408:11e::16)
 by SA5PPFE91247D15.namprd12.prod.outlook.com
 (2603:10b6:80f:fc04::8e8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8722.33; Tue, 3 Jun
 2025 13:00:53 +0000
Received: from BN9PR12MB5257.namprd12.prod.outlook.com
 ([fe80::c593:f43d:c798:e009]) by BN9PR12MB5257.namprd12.prod.outlook.com
 ([fe80::c593:f43d:c798:e009%4]) with mapi id 15.20.8792.034; Tue, 3 Jun 2025
 13:00:53 +0000
From: "Zhang, Hawking" <Hawking.Zhang@amd.com>
To: "Lazar, Lijo" <Lijo.Lazar@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
CC: "Deucher, Alexander" <Alexander.Deucher@amd.com>
Subject: RE: [PATCH] drm/amdgpu: Add more checks to PSP mailbox
Thread-Topic: [PATCH] drm/amdgpu: Add more checks to PSP mailbox
Thread-Index: AQHb05Btk4SMHDOuTk+OWjCEs0r/nLPxZ2uQ
Date: Tue, 3 Jun 2025 13:00:53 +0000
Message-ID: <BN9PR12MB5257607D911F2EE3B34E58A7FC6DA@BN9PR12MB5257.namprd12.prod.outlook.com>
References: <20250602073136.634742-1-lijo.lazar@amd.com>
In-Reply-To: <20250602073136.634742-1-lijo.lazar@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ActionId=c366962f-c667-4215-9083-7fca100f5c6a;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=0;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=true;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution Only;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2025-06-03T12:59:00Z;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Tag=10, 3, 0, 1;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR12MB5257:EE_|SA5PPFE91247D15:EE_
x-ms-office365-filtering-correlation-id: 276129b8-a7be-4f01-d833-08dda29eac2f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|1800799024|366016|7053199007|38070700018; 
x-microsoft-antispam-message-info: =?us-ascii?Q?dmsMX4rOFG7y7d5pT75Kq1QsqET6ddE5kLOYBgMJEh9Oc86DMWq2k8p5UF9j?=
 =?us-ascii?Q?YmkrADuLQYVBLZ6ftqWm3138l8mXnH9yRissfThtL5N9lzj2OhHKtzsPvPv7?=
 =?us-ascii?Q?GlBrQfL8xN81TTf6pdmSv4q4zTvBYsbLLjJe0PDnzcS+iNDQuFYRcreeIh6y?=
 =?us-ascii?Q?mDKWfhaRFEwg29rLBHxRYZIAK1GxF/Z6EtxgN2zQXs+p+iWLT6Vfsg/U/o+q?=
 =?us-ascii?Q?ms4ZL/dBviSjb/6H1lfughMvaeS/xNu/brGpBLSUKop7TWHlFO9aLA98X0dT?=
 =?us-ascii?Q?WuigZHSZVz3TbgVIYbSgM5Gz9S7EiQv6/057sBLZyiuxgmEhHMGFf8/+QcpK?=
 =?us-ascii?Q?8u16BT4f46TVG21a449wy6qyyjqHbYHZwGw3f6NKekWUB6tM+BRDNR9FUf7L?=
 =?us-ascii?Q?ZsWREZM7mj/PknTSMFo1X/aTHP3UEhdX2/1HVyT0UfFE67pcjE/Eu8FcYHxT?=
 =?us-ascii?Q?lK/zHkz1g0eHQS2HoPBvq/nobLFLA2znx1oA/pDJgq4dMeBoVp1rdVdzNPp9?=
 =?us-ascii?Q?va6BVBNTFFgrqqSPK+QxGIRlKtS/2v5zMxKgbXWzMpzkIe9mzmWVtbPUpDGW?=
 =?us-ascii?Q?ybMoJCtjP3AHbJ2df6BaWLmDVAoc2zNB0t5t7YyRFqhrdEXRZn+evFvkvUgg?=
 =?us-ascii?Q?LvS8u56fPts1LOVfE/mr0kZLxdUqv0BuC1rfS+RZHJBg5CUjMY1ptDLecGbn?=
 =?us-ascii?Q?7hcKzl6GYi8C2clBKMYN2NTVrTjBr0UhgLYgnfrl36UYknOOPX6ifX2wk9vB?=
 =?us-ascii?Q?yhgg/z9x9a4kTaVe19lhDnQsbTGXRhRwPZQtuL9cT/niRXsV85K62319x3dF?=
 =?us-ascii?Q?Qc59ePD6ZE7Y2J+untM61Qy8QMkjIfg8IgWT0D4PcOo5uv7WIEobGUicIdQA?=
 =?us-ascii?Q?qPJx6xPSmSlv22cJgqOuYgSEanxolroWw5+nb6+wyHnK+iqZvaS2ECJk6xDU?=
 =?us-ascii?Q?riF7SX1m9sNXm1A5mnGp0tDXu30W9+08nWPJoF5rEcBd8TwGiH9+mq8kKr/z?=
 =?us-ascii?Q?2VBRFOdx4j4v/PN8ztwjcgquALwaixf9OJ3t6STNc1p1d8VZHq1LBd6jpDMD?=
 =?us-ascii?Q?wG2Lwvg9wOXVqe+1zrEQNsWQEJq/F4+cbwW/YLa89qBe9sgtHI4aTvJUUtK3?=
 =?us-ascii?Q?rAz7lVlqSB58KK8rrp+3VtKi7gjD8TyoHykhsDwFY3TdX38bGa9tqf+gNW79?=
 =?us-ascii?Q?BHle7rk+tnysUjojeSXI89WVZzMGkxzmjxQTSpoGKNZBHSM5kNLlMmBhBM1V?=
 =?us-ascii?Q?nrHaMvh9EyjKnsv8uKvcIbvWwcPPCZGQkUxv3roALz4CM0kJIhXR1J8Jz3JO?=
 =?us-ascii?Q?7ARO0tqLGtCsErBe3MECeifczx8/gCZGv0jURlUnFSIL5zeE/Mxkq7s64v/y?=
 =?us-ascii?Q?dyfbcGypdmM716RHy7lWdYR2MiPpZHtQWL8tNcxX9RWhmLGma7i1/AHN4zYC?=
 =?us-ascii?Q?B0vFpu7756CyKRV43M6WOOtU7+JvaAH/f7Mbk6uiHpKwc0ZihndbSA=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5257.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(7053199007)(38070700018); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?hqL60+d3pc1hCvVyVpX1LaCPPrTT1Ekk1SMJ3Pf9JgstOdvdnNYEnIX9aqxI?=
 =?us-ascii?Q?Kvs6kd7WpQL73Cf9JBehCu73dt8oaZ/ZFuf7oS0zzQlC2JbA45HOaO4dAeTi?=
 =?us-ascii?Q?vJP2pYBaCymC0RtqwJh1Um9E/Dnjr9lSgdbbuFeO31NQhEbPmEWgB3WjON10?=
 =?us-ascii?Q?+8gsPnVQX6BVQxeyP0/hHaHDW/2oEW7lVlNPs6HO8iYpOXlOvUKTy7/5Quf4?=
 =?us-ascii?Q?0ZwrSbkkRnAAg/z6HzfuSO2UvxpMo+gUx9+aphUh+3xIMSxaC6vgHh8gmo/4?=
 =?us-ascii?Q?IhDaAQ4IyaAVVsNaJNJ/510NwCU4oEMZr7AXe1DljwzsGY7DRTondvdB/yvh?=
 =?us-ascii?Q?rGcdIqKFhG12TELfwcp0bKmpZIGQ4QI0TQTISot5KBLmFFFOEOlsdXYHtUjC?=
 =?us-ascii?Q?lhsTbO51UdpcHyPsfe55vokJGyQCNlV6+FKEvEdk99SjkmfZd3Yq65dRnchB?=
 =?us-ascii?Q?Nsij0THL7GE4PFEdwvy5zMR18xJhx+tOPpAL4ZSdtQBoHmPtLomzZFNGT+Tn?=
 =?us-ascii?Q?+nD/6vmQXg6g+1OoEh0bhioh2T3SVZsRrS4IyJS8AKDvR0/8ovmxEFqvxeJV?=
 =?us-ascii?Q?39wHblZMaNjfEKiiH5gjHxUvM/CW9MytP80TvnrAZPXs5FCC/MhnjLpkg6mm?=
 =?us-ascii?Q?SH5grAfBNqde6Bj95Ur0qQ46a8GafZZfSBpdOJdXZdfauF2YZMWpZps8Hn3W?=
 =?us-ascii?Q?aEVVKXhHOmdc6Q95mRdZwioZdhCjoznvYmrRgXiWLJB82/0v6ZpPMxUF4YJV?=
 =?us-ascii?Q?xn0q62PzrEaP37Vnw1l2ccNIO53ZAHPjHBgKFBTiZljHWoUdRDArjlKINgTP?=
 =?us-ascii?Q?0YVXHDbr7yoImTK5K4NKpPMdmS7V9je9GQ8jq+sezRgV6xdQ9zP6u0uFt+tR?=
 =?us-ascii?Q?1LG5h2NO/Fo53FUVDQl5IqGqkNRC3SceDtrPTKJzTqmFU9UEK27MvdHRlwF4?=
 =?us-ascii?Q?cuIeTOmDzI/VzxjZaYnw+d7Xrnnld9dkjsiiTDFkjk6eG6OjgOxq1W2h++NN?=
 =?us-ascii?Q?275GrF0tfef6bCzEWAeE6jh9ul8eUScD55L9kq2Oip3JfvJ3jwCN/gjVG1UX?=
 =?us-ascii?Q?v3p5ipp7s21S2YVU9N11hKOK7bZeXhg5i2AaUUxDqy1Ubl9JcVXIf1EGHN8x?=
 =?us-ascii?Q?41mSaUeHqtygTPgFaHqFdyNtCT9MQeQzrRHzQyICoY2j2efk/4KJv/ftIhUz?=
 =?us-ascii?Q?606Hi4MbD1ChvuJaCpy3TrBM5PlwrrEchPQy51MUL3WmvQtUiEeWJetyRcN6?=
 =?us-ascii?Q?EcbtIye1CuJdFgbJsxqE7KrFsU3jYSUGc0n9X5ftxrHX5LvRF+vP7nXDS4Ei?=
 =?us-ascii?Q?WPI25sgzXWJV8szs9wKOO7YZ61E+wl1Db9ql1vqphlPgFXX0kWaQZNQUe6FK?=
 =?us-ascii?Q?o05kGyokFLVrnftPA02USxzBm4o6fo5kkLAMwIq/5UGRmr08JCtXgCRn+1cY?=
 =?us-ascii?Q?AzuPPi0wIjTxfdIcSvKk/TnMeZ01sAYB4zaP9pHDnJDpIZsdmU6ehCxUDZ/M?=
 =?us-ascii?Q?UOqB+cLlZKHT2c2BnJP2eYSNdzcZsJ20TgmwROfKB5BeuIG6Qy5vhpS8OWhb?=
 =?us-ascii?Q?Al2SsyvZOvuMrLqBzbU=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5257.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 276129b8-a7be-4f01-d833-08dda29eac2f
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Jun 2025 13:00:53.3355 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: k/X1oJkPCJnlPhbbXDXNiJt5C8KPwsmZ2b8Viu7AFcjgVYHf6XrKiiFS7LBu3wSyRc85GuxzC4a9cnPiB4PJGw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA5PPFE91247D15
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

RE - log error if waiting if waiting on a psp response fails/times out

Please the redundant repetition of 'if waiting' from the commit description=
.

The patch is

Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>

Regards,
Hawking
-----Original Message-----
From: Lazar, Lijo <Lijo.Lazar@amd.com>
Sent: Monday, June 2, 2025 15:32
To: amd-gfx@lists.freedesktop.org
Cc: Zhang, Hawking <Hawking.Zhang@amd.com>; Deucher, Alexander <Alexander.D=
eucher@amd.com>
Subject: [PATCH] drm/amdgpu: Add more checks to PSP mailbox

Instead of checking the response flag, use status mask also to check agains=
t any unexpected failures like a device drop. Also, log error if waiting if=
 waiting on a psp response fails/times out.

Signed-off-by: Lijo Lazar <lijo.lazar@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c  |  4 +++  drivers/gpu/drm/amd/amd=
gpu/amdgpu_psp.h  | 11 +++++++++
 drivers/gpu/drm/amd/amdgpu/psp_v10_0.c   |  4 +--
 drivers/gpu/drm/amd/amdgpu/psp_v11_0.c   | 31 +++++++++++++++---------
 drivers/gpu/drm/amd/amdgpu/psp_v11_0_8.c | 25 +++++++++++--------
 drivers/gpu/drm/amd/amdgpu/psp_v12_0.c   | 18 ++++++++------
 drivers/gpu/drm/amd/amdgpu/psp_v13_0.c   | 25 +++++++++++--------
 drivers/gpu/drm/amd/amdgpu/psp_v13_0_4.c | 25 +++++++++++--------
 drivers/gpu/drm/amd/amdgpu/psp_v14_0.c   | 25 +++++++++++--------
 9 files changed, 107 insertions(+), 61 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c b/drivers/gpu/drm/amd/=
amdgpu/amdgpu_psp.c
index 9e64f478d9f2..5ee913780780 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
@@ -596,6 +596,10 @@ int psp_wait_for(struct psp_context *psp, uint32_t reg=
_index,
                udelay(1);
        }

+       dev_err(adev->dev,
+               "psp reg (0x%x) wait timed out, mask: %x, read: %x exp: %x"=
,
+               reg_index, mask, val, reg_val);
+
        return -ETIME;
 }

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.h b/drivers/gpu/drm/amd/=
amdgpu/amdgpu_psp.h
index 428adc7f741d..a4a00855d0b2 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.h
@@ -51,6 +51,17 @@
 #define C2PMSG_CMD_SPI_GET_ROM_IMAGE_ADDR_HI 0x10  #define C2PMSG_CMD_SPI_=
GET_FLASH_IMAGE 0x11

+/* Command register bit 31 set to indicate readiness */ #define
+MBOX_TOS_READY_FLAG (GFX_FLAG_RESPONSE) #define MBOX_TOS_READY_MASK
+(GFX_CMD_RESPONSE_MASK | GFX_CMD_STATUS_MASK)
+
+/* Values to check for a successful GFX_CMD response wait. Check
+against
+ * both status bits and response state - helps to detect a command
+failure
+ * or other unexpected cases like a device drop reading all 0xFFs  */
+#define MBOX_TOS_RESP_FLAG (GFX_FLAG_RESPONSE) #define
+MBOX_TOS_RESP_MASK (GFX_CMD_RESPONSE_MASK | GFX_CMD_STATUS_MASK)
+
 extern const struct attribute_group amdgpu_flash_attr_group;

 enum psp_shared_mem_size {
diff --git a/drivers/gpu/drm/amd/amdgpu/psp_v10_0.c b/drivers/gpu/drm/amd/a=
mdgpu/psp_v10_0.c
index 145186a1e48f..2c4ebd98927f 100644
--- a/drivers/gpu/drm/amd/amdgpu/psp_v10_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/psp_v10_0.c
@@ -94,7 +94,7 @@ static int psp_v10_0_ring_create(struct psp_context *psp,

        /* Wait for response flag (bit 31) in C2PMSG_64 */
        ret =3D psp_wait_for(psp, SOC15_REG_OFFSET(MP0, 0, mmMP0_SMN_C2PMSG=
_64),
-                          0x80000000, 0x8000FFFF, false);
+                          MBOX_TOS_RESP_FLAG, MBOX_TOS_RESP_MASK, false);

        return ret;
 }
@@ -115,7 +115,7 @@ static int psp_v10_0_ring_stop(struct psp_context *psp,

        /* Wait for response flag (bit 31) in C2PMSG_64 */
        ret =3D psp_wait_for(psp, SOC15_REG_OFFSET(MP0, 0, mmMP0_SMN_C2PMSG=
_64),
-                          0x80000000, 0x80000000, false);
+                          MBOX_TOS_RESP_FLAG, MBOX_TOS_RESP_MASK, false);

        return ret;
 }
diff --git a/drivers/gpu/drm/amd/amdgpu/psp_v11_0.c b/drivers/gpu/drm/amd/a=
mdgpu/psp_v11_0.c
index 215543575f47..1a4a26e6ffd2 100644
--- a/drivers/gpu/drm/amd/amdgpu/psp_v11_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/psp_v11_0.c
@@ -277,11 +277,13 @@ static int psp_v11_0_ring_stop(struct psp_context *ps=
p,

        /* Wait for response flag (bit 31) */
        if (amdgpu_sriov_vf(adev))
-               ret =3D psp_wait_for(psp, SOC15_REG_OFFSET(MP0, 0, mmMP0_SM=
N_C2PMSG_101),
-                                  0x80000000, 0x80000000, false);
+               ret =3D psp_wait_for(
+                       psp, SOC15_REG_OFFSET(MP0, 0, mmMP0_SMN_C2PMSG_101)=
,
+                       MBOX_TOS_RESP_FLAG, MBOX_TOS_RESP_MASK, false);
        else
-               ret =3D psp_wait_for(psp, SOC15_REG_OFFSET(MP0, 0, mmMP0_SM=
N_C2PMSG_64),
-                                  0x80000000, 0x80000000, false);
+               ret =3D psp_wait_for(
+                       psp, SOC15_REG_OFFSET(MP0, 0, mmMP0_SMN_C2PMSG_64),
+                       MBOX_TOS_RESP_FLAG, MBOX_TOS_RESP_MASK, false);

        return ret;
 }
@@ -317,13 +319,15 @@ static int psp_v11_0_ring_create(struct psp_context *=
psp,
                mdelay(20);

                /* Wait for response flag (bit 31) in C2PMSG_101 */
-               ret =3D psp_wait_for(psp, SOC15_REG_OFFSET(MP0, 0, mmMP0_SM=
N_C2PMSG_101),
-                                  0x80000000, 0x8000FFFF, false);
+               ret =3D psp_wait_for(
+                       psp, SOC15_REG_OFFSET(MP0, 0, mmMP0_SMN_C2PMSG_101)=
,
+                       MBOX_TOS_RESP_FLAG, MBOX_TOS_RESP_MASK, false);

        } else {
                /* Wait for sOS ready for ring creation */
-               ret =3D psp_wait_for(psp, SOC15_REG_OFFSET(MP0, 0, mmMP0_SM=
N_C2PMSG_64),
-                                  0x80000000, 0x80000000, false);
+               ret =3D psp_wait_for(
+                       psp, SOC15_REG_OFFSET(MP0, 0, mmMP0_SMN_C2PMSG_64),
+                       MBOX_TOS_READY_FLAG, MBOX_TOS_READY_MASK, false);
                if (ret) {
                        DRM_ERROR("Failed to wait for sOS ready for ring cr=
eation\n");
                        return ret;
@@ -347,8 +351,9 @@ static int psp_v11_0_ring_create(struct psp_context *ps=
p,
                mdelay(20);

                /* Wait for response flag (bit 31) in C2PMSG_64 */
-               ret =3D psp_wait_for(psp, SOC15_REG_OFFSET(MP0, 0, mmMP0_SM=
N_C2PMSG_64),
-                                  0x80000000, 0x8000FFFF, false);
+               ret =3D psp_wait_for(
+                       psp, SOC15_REG_OFFSET(MP0, 0, mmMP0_SMN_C2PMSG_64),
+                       MBOX_TOS_RESP_FLAG, MBOX_TOS_RESP_MASK, false);
        }

        return ret;
@@ -381,7 +386,8 @@ static int psp_v11_0_mode1_reset(struct psp_context *ps=
p)

        offset =3D SOC15_REG_OFFSET(MP0, 0, mmMP0_SMN_C2PMSG_64);

-       ret =3D psp_wait_for(psp, offset, 0x80000000, 0x8000FFFF, false);
+       ret =3D psp_wait_for(psp, offset, MBOX_TOS_READY_FLAG,
+                          MBOX_TOS_READY_MASK, false);

        if (ret) {
                DRM_INFO("psp is not working correctly before mode1 reset!\=
n"); @@ -395,7 +401,8 @@ static int psp_v11_0_mode1_reset(struct psp_contex=
t *psp)

        offset =3D SOC15_REG_OFFSET(MP0, 0, mmMP0_SMN_C2PMSG_33);

-       ret =3D psp_wait_for(psp, offset, 0x80000000, 0x80000000, false);
+       ret =3D psp_wait_for(psp, offset, MBOX_TOS_RESP_FLAG, MBOX_TOS_RESP=
_MASK,
+                          false);

        if (ret) {
                DRM_INFO("psp mode 1 reset failed!\n"); diff --git a/driver=
s/gpu/drm/amd/amdgpu/psp_v11_0_8.c b/drivers/gpu/drm/amd/amdgpu/psp_v11_0_8=
.c
index 5697760a819b..338d015c0f2e 100644
--- a/drivers/gpu/drm/amd/amdgpu/psp_v11_0_8.c
+++ b/drivers/gpu/drm/amd/amdgpu/psp_v11_0_8.c
@@ -41,8 +41,9 @@ static int psp_v11_0_8_ring_stop(struct psp_context *psp,
                /* there might be handshake issue with hardware which needs=
 delay */
                mdelay(20);
                /* Wait for response flag (bit 31) */
-               ret =3D psp_wait_for(psp, SOC15_REG_OFFSET(MP0, 0, mmMP0_SM=
N_C2PMSG_101),
-                                  0x80000000, 0x80000000, false);
+               ret =3D psp_wait_for(
+                       psp, SOC15_REG_OFFSET(MP0, 0, mmMP0_SMN_C2PMSG_101)=
,
+                       MBOX_TOS_RESP_FLAG, MBOX_TOS_RESP_MASK, false);
        } else {
                /* Write the ring destroy command*/
                WREG32_SOC15(MP0, 0, mmMP0_SMN_C2PMSG_64, @@ -50,8 +51,9 @@=
 static int psp_v11_0_8_ring_stop(struct psp_context *psp,
                /* there might be handshake issue with hardware which needs=
 delay */
                mdelay(20);
                /* Wait for response flag (bit 31) */
-               ret =3D psp_wait_for(psp, SOC15_REG_OFFSET(MP0, 0, mmMP0_SM=
N_C2PMSG_64),
-                                  0x80000000, 0x80000000, false);
+               ret =3D psp_wait_for(
+                       psp, SOC15_REG_OFFSET(MP0, 0, mmMP0_SMN_C2PMSG_64),
+                       MBOX_TOS_RESP_FLAG, MBOX_TOS_RESP_MASK, false);
        }

        return ret;
@@ -87,13 +89,15 @@ static int psp_v11_0_8_ring_create(struct psp_context *=
psp,
                mdelay(20);

                /* Wait for response flag (bit 31) in C2PMSG_101 */
-               ret =3D psp_wait_for(psp, SOC15_REG_OFFSET(MP0, 0, mmMP0_SM=
N_C2PMSG_101),
-                                  0x80000000, 0x8000FFFF, false);
+               ret =3D psp_wait_for(
+                       psp, SOC15_REG_OFFSET(MP0, 0, mmMP0_SMN_C2PMSG_101)=
,
+                       MBOX_TOS_RESP_FLAG, MBOX_TOS_RESP_MASK, false);

        } else {
                /* Wait for sOS ready for ring creation */
-               ret =3D psp_wait_for(psp, SOC15_REG_OFFSET(MP0, 0, mmMP0_SM=
N_C2PMSG_64),
-                                  0x80000000, 0x80000000, false);
+               ret =3D psp_wait_for(
+                       psp, SOC15_REG_OFFSET(MP0, 0, mmMP0_SMN_C2PMSG_64),
+                       MBOX_TOS_READY_FLAG, MBOX_TOS_READY_MASK, false);
                if (ret) {
                        DRM_ERROR("Failed to wait for trust OS ready for ri=
ng creation\n");
                        return ret;
@@ -117,8 +121,9 @@ static int psp_v11_0_8_ring_create(struct psp_context *=
psp,
                mdelay(20);

                /* Wait for response flag (bit 31) in C2PMSG_64 */
-               ret =3D psp_wait_for(psp, SOC15_REG_OFFSET(MP0, 0, mmMP0_SM=
N_C2PMSG_64),
-                                  0x80000000, 0x8000FFFF, false);
+               ret =3D psp_wait_for(
+                       psp, SOC15_REG_OFFSET(MP0, 0, mmMP0_SMN_C2PMSG_64),
+                       MBOX_TOS_RESP_FLAG, MBOX_TOS_RESP_MASK, false);
        }

        return ret;
diff --git a/drivers/gpu/drm/amd/amdgpu/psp_v12_0.c b/drivers/gpu/drm/amd/a=
mdgpu/psp_v12_0.c
index 80153f837470..d54b3e0fabaf 100644
--- a/drivers/gpu/drm/amd/amdgpu/psp_v12_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/psp_v12_0.c
@@ -163,7 +163,7 @@ static int psp_v12_0_ring_create(struct psp_context *ps=
p,

        /* Wait for response flag (bit 31) in C2PMSG_64 */
        ret =3D psp_wait_for(psp, SOC15_REG_OFFSET(MP0, 0, mmMP0_SMN_C2PMSG=
_64),
-                          0x80000000, 0x8000FFFF, false);
+                          MBOX_TOS_RESP_FLAG, MBOX_TOS_RESP_MASK, false);

        return ret;
 }
@@ -184,11 +184,13 @@ static int psp_v12_0_ring_stop(struct psp_context *ps=
p,

        /* Wait for response flag (bit 31) */
        if (amdgpu_sriov_vf(adev))
-               ret =3D psp_wait_for(psp, SOC15_REG_OFFSET(MP0, 0, mmMP0_SM=
N_C2PMSG_101),
-                                  0x80000000, 0x80000000, false);
+               ret =3D psp_wait_for(
+                       psp, SOC15_REG_OFFSET(MP0, 0, mmMP0_SMN_C2PMSG_101)=
,
+                       MBOX_TOS_RESP_FLAG, MBOX_TOS_RESP_MASK, false);
        else
-               ret =3D psp_wait_for(psp, SOC15_REG_OFFSET(MP0, 0, mmMP0_SM=
N_C2PMSG_64),
-                                  0x80000000, 0x80000000, false);
+               ret =3D psp_wait_for(
+                       psp, SOC15_REG_OFFSET(MP0, 0, mmMP0_SMN_C2PMSG_64),
+                       MBOX_TOS_RESP_FLAG, MBOX_TOS_RESP_MASK, false);

        return ret;
 }
@@ -219,7 +221,8 @@ static int psp_v12_0_mode1_reset(struct psp_context *ps=
p)

        offset =3D SOC15_REG_OFFSET(MP0, 0, mmMP0_SMN_C2PMSG_64);

-       ret =3D psp_wait_for(psp, offset, 0x80000000, 0x8000FFFF, false);
+       ret =3D psp_wait_for(psp, offset, MBOX_TOS_READY_FLAG,
+                          MBOX_TOS_READY_MASK, false);

        if (ret) {
                DRM_INFO("psp is not working correctly before mode1 reset!\=
n"); @@ -233,7 +236,8 @@ static int psp_v12_0_mode1_reset(struct psp_contex=
t *psp)

        offset =3D SOC15_REG_OFFSET(MP0, 0, mmMP0_SMN_C2PMSG_33);

-       ret =3D psp_wait_for(psp, offset, 0x80000000, 0x80000000, false);
+       ret =3D psp_wait_for(psp, offset, MBOX_TOS_RESP_FLAG, MBOX_TOS_RESP=
_MASK,
+                          false);

        if (ret) {
                DRM_INFO("psp mode 1 reset failed!\n"); diff --git a/driver=
s/gpu/drm/amd/amdgpu/psp_v13_0.c b/drivers/gpu/drm/amd/amdgpu/psp_v13_0.c
index df612fd9cc50..08ec69d6a137 100644
--- a/drivers/gpu/drm/amd/amdgpu/psp_v13_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/psp_v13_0.c
@@ -382,8 +382,9 @@ static int psp_v13_0_ring_stop(struct psp_context *psp,
                /* there might be handshake issue with hardware which needs=
 delay */
                mdelay(20);
                /* Wait for response flag (bit 31) */
-               ret =3D psp_wait_for(psp, SOC15_REG_OFFSET(MP0, 0, regMP0_S=
MN_C2PMSG_101),
-                                  0x80000000, 0x80000000, false);
+               ret =3D psp_wait_for(
+                       psp, SOC15_REG_OFFSET(MP0, 0, regMP0_SMN_C2PMSG_101=
),
+                       MBOX_TOS_RESP_FLAG, MBOX_TOS_RESP_MASK, false);
        } else {
                /* Write the ring destroy command*/
                WREG32_SOC15(MP0, 0, regMP0_SMN_C2PMSG_64, @@ -391,8 +392,9=
 @@ static int psp_v13_0_ring_stop(struct psp_context *psp,
                /* there might be handshake issue with hardware which needs=
 delay */
                mdelay(20);
                /* Wait for response flag (bit 31) */
-               ret =3D psp_wait_for(psp, SOC15_REG_OFFSET(MP0, 0, regMP0_S=
MN_C2PMSG_64),
-                                  0x80000000, 0x80000000, false);
+               ret =3D psp_wait_for(
+                       psp, SOC15_REG_OFFSET(MP0, 0, regMP0_SMN_C2PMSG_64)=
,
+                       MBOX_TOS_RESP_FLAG, MBOX_TOS_RESP_MASK, false);
        }

        return ret;
@@ -428,13 +430,15 @@ static int psp_v13_0_ring_create(struct psp_context *=
psp,
                mdelay(20);

                /* Wait for response flag (bit 31) in C2PMSG_101 */
-               ret =3D psp_wait_for(psp, SOC15_REG_OFFSET(MP0, 0, regMP0_S=
MN_C2PMSG_101),
-                                  0x80000000, 0x8000FFFF, false);
+               ret =3D psp_wait_for(
+                       psp, SOC15_REG_OFFSET(MP0, 0, regMP0_SMN_C2PMSG_101=
),
+                       MBOX_TOS_RESP_FLAG, MBOX_TOS_RESP_MASK, false);

        } else {
                /* Wait for sOS ready for ring creation */
-               ret =3D psp_wait_for(psp, SOC15_REG_OFFSET(MP0, 0, regMP0_S=
MN_C2PMSG_64),
-                                  0x80000000, 0x80000000, false);
+               ret =3D psp_wait_for(
+                       psp, SOC15_REG_OFFSET(MP0, 0, regMP0_SMN_C2PMSG_64)=
,
+                       MBOX_TOS_READY_FLAG, MBOX_TOS_READY_MASK, false);
                if (ret) {
                        DRM_ERROR("Failed to wait for trust OS ready for ri=
ng creation\n");
                        return ret;
@@ -458,8 +462,9 @@ static int psp_v13_0_ring_create(struct psp_context *ps=
p,
                mdelay(20);

                /* Wait for response flag (bit 31) in C2PMSG_64 */
-               ret =3D psp_wait_for(psp, SOC15_REG_OFFSET(MP0, 0, regMP0_S=
MN_C2PMSG_64),
-                                  0x80000000, 0x8000FFFF, false);
+               ret =3D psp_wait_for(
+                       psp, SOC15_REG_OFFSET(MP0, 0, regMP0_SMN_C2PMSG_64)=
,
+                       MBOX_TOS_RESP_FLAG, MBOX_TOS_RESP_MASK, false);
        }

        return ret;
diff --git a/drivers/gpu/drm/amd/amdgpu/psp_v13_0_4.c b/drivers/gpu/drm/amd=
/amdgpu/psp_v13_0_4.c
index eaa5512a21da..f65af52c1c19 100644
--- a/drivers/gpu/drm/amd/amdgpu/psp_v13_0_4.c
+++ b/drivers/gpu/drm/amd/amdgpu/psp_v13_0_4.c
@@ -204,8 +204,9 @@ static int psp_v13_0_4_ring_stop(struct psp_context *ps=
p,
                /* there might be handshake issue with hardware which needs=
 delay */
                mdelay(20);
                /* Wait for response flag (bit 31) */
-               ret =3D psp_wait_for(psp, SOC15_REG_OFFSET(MP0, 0, regMP0_S=
MN_C2PMSG_101),
-                                  0x80000000, 0x80000000, false);
+               ret =3D psp_wait_for(
+                       psp, SOC15_REG_OFFSET(MP0, 0, regMP0_SMN_C2PMSG_101=
),
+                       MBOX_TOS_RESP_FLAG, MBOX_TOS_RESP_MASK, false);
        } else {
                /* Write the ring destroy command*/
                WREG32_SOC15(MP0, 0, regMP0_SMN_C2PMSG_64, @@ -213,8 +214,9=
 @@ static int psp_v13_0_4_ring_stop(struct psp_context *psp,
                /* there might be handshake issue with hardware which needs=
 delay */
                mdelay(20);
                /* Wait for response flag (bit 31) */
-               ret =3D psp_wait_for(psp, SOC15_REG_OFFSET(MP0, 0, regMP0_S=
MN_C2PMSG_64),
-                                  0x80000000, 0x80000000, false);
+               ret =3D psp_wait_for(
+                       psp, SOC15_REG_OFFSET(MP0, 0, regMP0_SMN_C2PMSG_64)=
,
+                       MBOX_TOS_RESP_FLAG, MBOX_TOS_RESP_MASK, false);
        }

        return ret;
@@ -250,13 +252,15 @@ static int psp_v13_0_4_ring_create(struct psp_context=
 *psp,
                mdelay(20);

                /* Wait for response flag (bit 31) in C2PMSG_101 */
-               ret =3D psp_wait_for(psp, SOC15_REG_OFFSET(MP0, 0, regMP0_S=
MN_C2PMSG_101),
-                                  0x80000000, 0x8000FFFF, false);
+               ret =3D psp_wait_for(
+                       psp, SOC15_REG_OFFSET(MP0, 0, regMP0_SMN_C2PMSG_101=
),
+                       MBOX_TOS_RESP_FLAG, MBOX_TOS_RESP_MASK, false);

        } else {
                /* Wait for sOS ready for ring creation */
-               ret =3D psp_wait_for(psp, SOC15_REG_OFFSET(MP0, 0, regMP0_S=
MN_C2PMSG_64),
-                                  0x80000000, 0x80000000, false);
+               ret =3D psp_wait_for(
+                       psp, SOC15_REG_OFFSET(MP0, 0, regMP0_SMN_C2PMSG_64)=
,
+                       MBOX_TOS_READY_FLAG, MBOX_TOS_READY_MASK, false);
                if (ret) {
                        DRM_ERROR("Failed to wait for trust OS ready for ri=
ng creation\n");
                        return ret;
@@ -280,8 +284,9 @@ static int psp_v13_0_4_ring_create(struct psp_context *=
psp,
                mdelay(20);

                /* Wait for response flag (bit 31) in C2PMSG_64 */
-               ret =3D psp_wait_for(psp, SOC15_REG_OFFSET(MP0, 0, regMP0_S=
MN_C2PMSG_64),
-                                  0x80000000, 0x8000FFFF, false);
+               ret =3D psp_wait_for(
+                       psp, SOC15_REG_OFFSET(MP0, 0, regMP0_SMN_C2PMSG_64)=
,
+                       MBOX_TOS_RESP_FLAG, MBOX_TOS_RESP_MASK, false);
        }

        return ret;
diff --git a/drivers/gpu/drm/amd/amdgpu/psp_v14_0.c b/drivers/gpu/drm/amd/a=
mdgpu/psp_v14_0.c
index 256288c6cd78..ffa47c7d24c9 100644
--- a/drivers/gpu/drm/amd/amdgpu/psp_v14_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/psp_v14_0.c
@@ -248,8 +248,9 @@ static int psp_v14_0_ring_stop(struct psp_context *psp,
                /* there might be handshake issue with hardware which needs=
 delay */
                mdelay(20);
                /* Wait for response flag (bit 31) */
-               ret =3D psp_wait_for(psp, SOC15_REG_OFFSET(MP0, 0, regMPASP=
_SMN_C2PMSG_101),
-                                  0x80000000, 0x80000000, false);
+               ret =3D psp_wait_for(
+                       psp, SOC15_REG_OFFSET(MP0, 0, regMPASP_SMN_C2PMSG_1=
01),
+                       MBOX_TOS_RESP_FLAG, MBOX_TOS_RESP_MASK, false);
        } else {
                /* Write the ring destroy command*/
                WREG32_SOC15(MP0, 0, regMPASP_SMN_C2PMSG_64, @@ -257,8 +258=
,9 @@ static int psp_v14_0_ring_stop(struct psp_context *psp,
                /* there might be handshake issue with hardware which needs=
 delay */
                mdelay(20);
                /* Wait for response flag (bit 31) */
-               ret =3D psp_wait_for(psp, SOC15_REG_OFFSET(MP0, 0, regMPASP=
_SMN_C2PMSG_64),
-                                  0x80000000, 0x80000000, false);
+               ret =3D psp_wait_for(
+                       psp, SOC15_REG_OFFSET(MP0, 0, regMPASP_SMN_C2PMSG_6=
4),
+                       MBOX_TOS_RESP_FLAG, MBOX_TOS_RESP_MASK, false);
        }

        return ret;
@@ -294,13 +296,15 @@ static int psp_v14_0_ring_create(struct psp_context *=
psp,
                mdelay(20);

                /* Wait for response flag (bit 31) in C2PMSG_101 */
-               ret =3D psp_wait_for(psp, SOC15_REG_OFFSET(MP0, 0, regMPASP=
_SMN_C2PMSG_101),
-                                  0x80000000, 0x8000FFFF, false);
+               ret =3D psp_wait_for(
+                       psp, SOC15_REG_OFFSET(MP0, 0, regMPASP_SMN_C2PMSG_1=
01),
+                       MBOX_TOS_RESP_FLAG, MBOX_TOS_RESP_MASK, false);

        } else {
                /* Wait for sOS ready for ring creation */
-               ret =3D psp_wait_for(psp, SOC15_REG_OFFSET(MP0, 0, regMPASP=
_SMN_C2PMSG_64),
-                                  0x80000000, 0x80000000, false);
+               ret =3D psp_wait_for(
+                       psp, SOC15_REG_OFFSET(MP0, 0, regMPASP_SMN_C2PMSG_6=
4),
+                       MBOX_TOS_READY_FLAG, MBOX_TOS_READY_MASK, false);
                if (ret) {
                        DRM_ERROR("Failed to wait for trust OS ready for ri=
ng creation\n");
                        return ret;
@@ -324,8 +328,9 @@ static int psp_v14_0_ring_create(struct psp_context *ps=
p,
                mdelay(20);

                /* Wait for response flag (bit 31) in C2PMSG_64 */
-               ret =3D psp_wait_for(psp, SOC15_REG_OFFSET(MP0, 0, regMPASP=
_SMN_C2PMSG_64),
-                                  0x80000000, 0x8000FFFF, false);
+               ret =3D psp_wait_for(
+                       psp, SOC15_REG_OFFSET(MP0, 0, regMPASP_SMN_C2PMSG_6=
4),
+                       MBOX_TOS_RESP_FLAG, MBOX_TOS_RESP_MASK, false);
        }

        return ret;
--
2.25.1

