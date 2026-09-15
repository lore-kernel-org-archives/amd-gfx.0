Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BD7C6C88E72
	for <amd-gfx@archiver.kernel.org>; Tue, 15 Sep 2026 01:54:56 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1A1CD10F848;
	Tue, 15 Sep 2026 01:54:56 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Vc3qZucx";
	dkim-atps=neutral
Received: from CH4PR04CU002.outbound.protection.outlook.com
 (mail-northcentralusazon11013025.outbound.protection.outlook.com
 [40.107.201.25])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BCC1710F848
 for <amd-gfx@lists.freedesktop.org>; Tue, 15 Sep 2026 01:54:54 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CBHk6Forl1nBftwGYCe6oMTg6QRU5wHacNUM722VNTdJlK0KYgPMpUbN4MFnkfcHWtMLJpvw7j4alglx9LrOTz2OdYB2fsAYk36evXHcoxm5o1k1YI2sRD81A3f4vsh3L0hp5bsETCNl5JA1hAc/dhfjSNoyln1pu5fO1rWw1ebbgqNKc390cd042dPAPswXwjUWiR7Q3jZLLxmlvAb2ogmm3h5wQhcFFMV0kg/oCddLHGNRBtICJ3+gPd1D5znhhJQqQzzouIyRLH4XzZH9v96bwrz8QbI/MZwqrMe8Ua6mfyW70rZyCBFMnSs8JwAX+6gqcGVHE3Lj9vKpuJY8pQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2G2rRHerGDlg2Pw/PtVF0yVm0/qCGGD0pr9ltu8KJZA=;
 b=sJnvDu6Cxr57Ch45NvM89iSfRTeMkxX7sh1hW2MDYGwCym8pu4CA0aYqjss2c9cf23LCV0qARfxuv63I1OfttvcNsFLbbUypnubE5HqfyFtXjNyqDQdPdy/aiEB7JfAEQdUPYFG7PBuk5N59wBnE2VfThy+d833cQlvCEryK0atpAMultPU0YlGXc5WVukIEW6HztTS/qF0ZmueaNGyBK+og30YS8xQfUhz81y7buZJeB1kkrHeZCe+XuKwDC+/twcYBgeuLlWLhVN0apctI+FdtXBcGqN0Z4GfrSQx8w9z5hZXBhhvYswjyZxZ2HH6kvqb6t7rbtevhNEsD4PxUww==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2G2rRHerGDlg2Pw/PtVF0yVm0/qCGGD0pr9ltu8KJZA=;
 b=Vc3qZucxqCbgJYd7VbqAR9RRvGVkcXearzJEGnu2OiMEbQhlM5f/uyVN5B7fk2OAbO9C39EoNe80z0n+TennKVHp4GAnqPcI8cxlhvZHqQwlP3SPHWZa3lCZcdRaTjV3an9cPr/XtvL/bRCjiBsrt31D97vnY8Febux8Cxa8GhY=
Received: from CH2PR12MB9457.namprd12.prod.outlook.com (2603:10b6:610:27c::7)
 by DM6PR12MB4386.namprd12.prod.outlook.com (2603:10b6:5:28f::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.12; Tue, 15 Sep
 2026 01:54:51 +0000
Received: from CH2PR12MB9457.namprd12.prod.outlook.com
 ([fe80::85a8:1df:840a:cd4c]) by CH2PR12MB9457.namprd12.prod.outlook.com
 ([fe80::85a8:1df:840a:cd4c%4]) with mapi id 15.21.0406.007; Tue, 15 Sep 2026
 01:54:51 +0000
From: "Zhu, Lingshan" <Lingshan.Zhu@amd.com>
To: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Kuehling, Felix"
 <Felix.Kuehling@amd.com>
CC: "Huang, Ray" <Ray.Huang@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH RESEND 00/10] drm/amdgpu: secure userq lifecycle by its
 kref
Thread-Topic: [PATCH RESEND 00/10] drm/amdgpu: secure userq lifecycle by its
 kref
Thread-Index: AQHdREnxMpC1e9Sj8US/NzomEkhfFrbO4bIg
Date: Tue, 15 Sep 2026 01:54:51 +0000
Message-ID: <CH2PR12MB945710EE0E52DC2498C528C28CBA2@CH2PR12MB9457.namprd12.prod.outlook.com>
References: <20260914130724.130794-1-lingshan.zhu@amd.com>
In-Reply-To: <20260914130724.130794-1-lingshan.zhu@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Enabled=True;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SetDate=2026-09-15T01:54:25.0000000Z;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Name=AMD General
 v26; MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_ContentBits=3;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Method=Standard
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH2PR12MB9457:EE_|DM6PR12MB4386:EE_
x-ms-office365-filtering-correlation-id: 03044de9-4aca-4037-81ae-08df12cc54e0
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|366016|1800799024|23010399003|56012099006|11063799006|10067099003|18002099003|22082099003|38070700021;
x-microsoft-antispam-message-info: 107NojDTIqyb9mL94XU3Bu/b2P5JITbzcpXv2NIN1300YY2xPhYUaqdnXUwVwWUGiH9uljibpYg5fbvkZwuA91KdggT/IXezF35jbQHDZjitbxNxEgi4duCt2wyGKe9PFOTuYcMaKxrZLt39hwqjLiDn0lYDzqPa8n7UqlFACZo44xwVa8w61u8oXBt38HZ04AwCCRbVov7/p0jjKZtlDukKVssW+LFM2G69TIgutni/2Pg0dkwhwq/ZmoNbwOnPCPQt4ezZTh3f9yh0LLN0Va7D2S+mGzigNAvHZpYx3a5uI37hhQ61GD7PvvIz4sIuJYb8y2XKok76OTDWdE1k7ytPm2Ts9vww2qPftc0IuZEHjNV5XLeGwNcj6GJG8AvTaZDUvOyc5tnp4+HSeRgk9nC02FBLb25yXX0GWugLrjpD6xp3XisG7F/hb6jdVZnaAHPx/EfGBFwvIFmsNAwc0kuGEQHO6w054NTvIoBj8XzYuizC6Eg28GwTxJFnjG5E5hRPuk+E7YxENtFflI1w7ZR2woEqdpYnOs62gWA7Q0z3lab7IR8zuChygqvr98f31O3qMDs9ikWfZS8UHp9hUs96CI3STVCcZ4h54XkoYaprz8JviFgvS6juQcDcfzRh14VBXBpkTq54kPEMNeuBzJwPjyY/0ycuOE541Uy7NC0=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH2PR12MB9457.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(23010399003)(56012099006)(11063799006)(10067099003)(18002099003)(22082099003)(38070700021);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?ZCKEnrEyy/n7DOQBgXG7jQKzPXGwHGz82Msk2ezW9dnDS5l6lUaSHBdiaIyd?=
 =?us-ascii?Q?wycwSphYZhD/LcOLr83sJe5+nYA/TIkfHuz+6esrTsN4mLz37bAavGZvVQLZ?=
 =?us-ascii?Q?unSTAk/9hmDMUhIN1IkLwfpKbTOJjjvleaDP1LPNIS9AfxJPB1zeD1Apt+Cw?=
 =?us-ascii?Q?IArcnDu1o0biaRmF9kj7KqpKsbr7m+K4aJyb+mcTqPVT7gYD4phKgrhIoq6y?=
 =?us-ascii?Q?6nWHJ5RsKNiyrKdg58ST31l9sHTV5qQ9tHz4GOrc80Uk6Me3g/MPpeCgdTCx?=
 =?us-ascii?Q?DbsuOswUxk7+pi+gP+xjKXJPxgdzlZo8Xuvz0TJTAsri52lS87oX8iX/yPNr?=
 =?us-ascii?Q?KMHZMrjOo1PRzNfFLSlei3Y/tWfoZ5lGwEcev/MDTaB4+zzAdZzmdxlkE5IO?=
 =?us-ascii?Q?fi92gi9+1CqYuaRshCw/AUyAc0RVf+ANa2/teH4sl/8+6XIvZjGo2JG9UplO?=
 =?us-ascii?Q?0hXHKHA106J4k37DQvc4adFdwzEem58cuY4mxvkwln9Ufr8Hx6W3u0pMERyV?=
 =?us-ascii?Q?TtQTq9cM0qU9PPfuS2HHRa4ZOQnCmGpxnZoVseE7d+Kk5iMwwrPK7pS71KCj?=
 =?us-ascii?Q?1Udqej0UPKQ+Sm7cGX6kGdb3UfQmCocrYVGCygSeWdLqGabxahsKdvzJuO8e?=
 =?us-ascii?Q?g0yzMLx+Nx/WXGM1skto1rxXG50cuPAE7OQhW4wfnENwdcTinxZ5TIn1YYNz?=
 =?us-ascii?Q?TdnkEHKIwm3a/6b9T6XbM8QWUK3agaIIZhv9f5stcIEgoKzL6OPPnuz3kfcJ?=
 =?us-ascii?Q?79+W7MwK47FFJ8OnsstmrkmwlW/w2FcVXLjxA0i3liGhw4skqeAZSGxNiooW?=
 =?us-ascii?Q?YjOj46WmLBonOOk9Yo/0yta98P3nxFbzADWaLSksQHJqgE3Hc7erv5N4Z1Lq?=
 =?us-ascii?Q?1Se7+0uAXGovPEsMEjVz5zQZpOLMyrxCn9yv5P6R+j4hLgdclWIjOzLtRWZc?=
 =?us-ascii?Q?nXUh8UCXo3X17hreIWbKf4UDnOA2XAKxAFpqNZXIgk+/5O8GHwBSRvNwmqHC?=
 =?us-ascii?Q?QLbIzuHkcKUKCHwnAGStIlQ3hExRaHSJjUevc8K75xQbOYoQajyWPZYaNJzc?=
 =?us-ascii?Q?Qe1wBpdxVKJjNWwNJU9namzyUfW2WxkINmITNg+8F/KKyOK/gont9tI1hrvv?=
 =?us-ascii?Q?e38a6yDWAXlUTxQnDJBVY+5UCCqWJKwST96DkSKIqKqwhDTTdGqvaxpavOlQ?=
 =?us-ascii?Q?cXhrLA+knvqbOvC2RdebwBZwiUxLjUpGhupa9cGzE1j2tD0A8MPkHSKWewaF?=
 =?us-ascii?Q?W9pqGQu1BXwtEcR8/DgxneMEUX+JSOFN/5QY+e8Li8zDYSA+6T2BZ2/AA3HS?=
 =?us-ascii?Q?LL7+dCwQJs2yhms8d6BfvqkBrdpsAkNl6v85a8e5zOE7gtlNl/LwB5izrVoV?=
 =?us-ascii?Q?8KSGOoXC6e6WgMiKBb0taXeXR8uESxRUuNulre2MMM32GLDSH4ke/tOXgwX9?=
 =?us-ascii?Q?Bey1UOujYQ1iUTG8YWi2E3y/sNEI5dczTeu+R5gHcSNFLmCupWIJYkRZHH1X?=
 =?us-ascii?Q?5JFlJ01vwZmFwMjbn0saABHMsbd4m1YSw6LFPfCdquj8O5FKbKI9XOphj9B/?=
 =?us-ascii?Q?X9LPegLYlJkV91utWPCj+LcnE48ZcnZIfzgliUVSYfCkGxhL1NjfH8LTgPZU?=
 =?us-ascii?Q?mX+wZT0ZXjUvByDTCPqDlZRB2o8QlofAZdw22z7FoJyHTrxbeJhHVY3NPoxP?=
 =?us-ascii?Q?Z1cGQ2j2CSv45dVZhxrXNpX3am/5vKCs5E6JKSUtVwyPEojt?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH2PR12MB9457.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 03044de9-4aca-4037-81ae-08df12cc54e0
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Sep 2026 01:54:51.4812 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: dzmYrgpRKxADaiJgpKkAtXpcNKHXsiyBZWkK7Wei6AbdeMbvjS7IaxIlhvgDZCSpkNrRyR8UZhbkrd5z3mZhYA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4386
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

Gentle Ping Alex

-----Original Message-----
From: Zhu, Lingshan <Lingshan.Zhu@amd.com>
Sent: Monday, September 14, 2026 9:07 PM
To: Deucher, Alexander <Alexander.Deucher@amd.com>; Kuehling, Felix <Felix.=
Kuehling@amd.com>
Cc: Huang, Ray <Ray.Huang@amd.com>; amd-gfx@lists.freedesktop.org; Zhu, Lin=
gshan <Lingshan.Zhu@amd.com>
Subject: [PATCH RESEND 00/10] drm/amdgpu: secure userq lifecycle by its kre=
f

A struct kref is embedded in user queue, which manages the lifecycle of a u=
ser queue. However, several code paths access user queues without hoding th=
e kref of a user queue, especially from the doorbell XArray.

These accesses can race with the queue destruction process and result in us=
e-after-free bugs.

To fix this issue, this commit:
1) Introduces a new helper amdgpu_lookup_queue_by_doorbell, which looks up =
a user queue with locking and hold its kref during access.

2) Implement asynchronous userq destruction routine, because the last put o=
f a queue kref may be placed in a code path where can not sleep or conflict=
 locking with the destruction process.

3) Hold kref during access the user queues

4) Keep the userq manager alive as long as its queues, to avoid UAF issues.

This seires passed amd_basic tests in igt tests

Link to previus discussions: https://lists.freedesktop.org/archives/amd-gfx=
/2026-August/151692.html

Please help review

Thanks
Lingshan

Zhu Lingshan (10):
  drm/amdgpu: introduce amdgpu_lookup_queue_by_doorbell
  drm/amdgpu: keep the userq manager alive as long as its queues
  drm/amdgpu/gfx11: hold userq refs in private fault worker
  drm/amdgpu/gfx12: hold userq refs in private fault worker
  drm/amdgpu: implement asynchronous userq destruction routine
  drm/amdgpu: hold userq kref in MES reset
  drm/amdgpu: hold userq kref during isolation scheduling
  drm/amdgpu: hold userq kref during suspend and resume
  drm/amdgpu: free userq by kref_put when fails to create
  drm/amdgpu: take queue kref in userq_create to avoid UAF

 drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c  | 214 +++++++++++++++++++--  dr=
ivers/gpu/drm/amd/amdgpu/amdgpu_userq.h  |  18 ++
 drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c     |   7 +-
 drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c     |   7 +-
 drivers/gpu/drm/amd/amdgpu/mes_userqueue.c |  46 ++---
 5 files changed, 246 insertions(+), 46 deletions(-)

--
2.53.0

