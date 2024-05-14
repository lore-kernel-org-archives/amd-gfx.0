Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A65C7C25B79
	for <amd-gfx@archiver.kernel.org>; Tue, 14 May 2024 01:52:31 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F056210E072;
	Tue, 14 May 2024 01:52:30 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="aVcQAvGS";
	dkim-atps=neutral
Received: from NAM02-SN1-obe.outbound.protection.outlook.com
 (mail-sn1nam02on2058.outbound.protection.outlook.com [40.107.96.58])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A724010E072
 for <amd-gfx@lists.freedesktop.org>; Tue, 14 May 2024 01:52:29 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Cbt3/dcwk/XtCTpr3ss41sCqt4J9JYAKp5DTCxc/jmWaCJavy3uJF703yweNGznu23Jra/eVuBll+DZkIOTY0GvBV75BfFXI+Ziql4c7t5QTE2J69q6JwA5obBrq/g8/j2ypHIV+ljCmqa+SlPoA+Y6DTZw6RtSVbkAZmxEK3Gutb5qkMZvqIhRGcifp4krqVZq1+vIgrGityDRZYbfXqbsqXoOm0mVwqJ2b80vQTrJPLQIXrrznPioOqZ0YMCTdp9HTDsiM0GA88O4mscoP1gJqmr5WiMCtVO3bzOWzZzMiWumotclBU9ZLnQNaqQC2/1vn59noN5v3riBim6ja7A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iBQLMv2L9+bhbQx7TReKouBnfpJdOLDtK10SFajotn4=;
 b=LhtJIKI50EIySZZr242YvlEk0tYT6POTgt38cUqMzeUwKeCFSH3ej0T3LM4lxjFt959TBAmoUtUrKkQdI01+tNZPkELtAKblqTtIuQDbN111hIitQq4ktbIwVBS3DoKsUDOHrtbhmIxjyU5xYbJyeTeBXQinVLi5Dfhiqxp92suVbdRqVVYBlLDl7ZdhFOoJygR7UAfAlRm3wVmuXNmlLaZqJ2zk0w5tPp1yvn9MVx6fDcloLw5rqMrbEKa0r/vJkJ2y+Hh6DCaA1TAzYOI9p/GV9vsHJzQl+MQ/eNvDDH0Y3E0k51/cvIJTmEIx0jUAeF2qt4D6Z4lprahxL2RKAQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iBQLMv2L9+bhbQx7TReKouBnfpJdOLDtK10SFajotn4=;
 b=aVcQAvGSQRU8F0DCHmWb0/KmgKRVCgc5gS/ACkLyT3c6xdEWs3QgKlxl3Pyh/0SCAtrt6WjJUmbp3LbUpAzcZoumHFMbtBNzqT+l8ZIoGN4cgO+JVrz+NA3tdhY35f5IfNi0PfvGptRmq/g320KK3VT/viwCkken0wbK01hRLHo=
Received: from CH2PR12MB4215.namprd12.prod.outlook.com (2603:10b6:610:ab::24)
 by MN0PR12MB6269.namprd12.prod.outlook.com (2603:10b6:208:3c3::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.55; Tue, 14 May
 2024 01:52:27 +0000
Received: from CH2PR12MB4215.namprd12.prod.outlook.com
 ([fe80::b053:488f:853d:892a]) by CH2PR12MB4215.namprd12.prod.outlook.com
 ([fe80::b053:488f:853d:892a%4]) with mapi id 15.20.7544.052; Tue, 14 May 2024
 01:52:27 +0000
From: "Chai, Thomas" <YiPeng.Chai@amd.com>
To: "Ma, Jun" <Jun.Ma2@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
CC: "Feng, Kenneth" <Kenneth.Feng@amd.com>, "Deucher, Alexander"
 <Alexander.Deucher@amd.com>, "Wang, Yang(Kevin)" <KevinYang.Wang@amd.com>,
 "Koenig, Christian" <Christian.Koenig@amd.com>, "Ma, Jun" <Jun.Ma2@amd.com>
Subject: RE: [PATCH 5/5] drm/amdgpu: Remove dead code in
 amdgpu_ras_add_mca_err_addr
Thread-Topic: [PATCH 5/5] drm/amdgpu: Remove dead code in
 amdgpu_ras_add_mca_err_addr
Thread-Index: AQHapRODM6RRzC13UEqm4nPafY2lKLGV+BnA
Date: Tue, 14 May 2024 01:52:27 +0000
Message-ID: <CH2PR12MB4215CF781EB4F498737473A0FCE32@CH2PR12MB4215.namprd12.prod.outlook.com>
References: <20240513085616.584249-1-Jun.Ma2@amd.com>
 <20240513085616.584249-5-Jun.Ma2@amd.com>
In-Reply-To: <20240513085616.584249-5-Jun.Ma2@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ActionId=ae6fb83a-042e-4d14-a008-57db66acb070;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=0;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=true;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution Only;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2024-05-14T01:50:41Z;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH2PR12MB4215:EE_|MN0PR12MB6269:EE_
x-ms-office365-filtering-correlation-id: 86b8275b-5dc2-4cdb-0a18-08dc73b881fe
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230031|366007|1800799015|376005|38070700009;
x-microsoft-antispam-message-info: =?us-ascii?Q?wZCYUBVJBOzuwQcALWKQLu5gqfkFYrPJ9THcHm9JcLG5K5cJoKEYRpIae7zs?=
 =?us-ascii?Q?4X6IYXHPVCMpNNZBr8wkndq/cOyL2tfVDSWKEqUieyVhlArEZz+bF+GO/f1G?=
 =?us-ascii?Q?+HyWTvH+G86hPNgkHZjksql69CgeDvsf6qL6Yl8zzlzxubDSmpUVNgAtDzM5?=
 =?us-ascii?Q?McwOlZsoeVpsi2qFkrilzCi/959C/coTQZF5SpLc1adSt3LEFvouKy2KXcu7?=
 =?us-ascii?Q?W/Ir/AWZvxjM20nXVwAm1IY4EFDRj/i8yyu6LkecWI2MWc9psc3dpfBU2g0a?=
 =?us-ascii?Q?Xfq61GEhNEBKR1nhSo17w9ZXP5lZWDmFLUMJ/R7fpktIXEdbTSywn0+FPmNF?=
 =?us-ascii?Q?XL6aGx7ikhu/Si5YdVVe9GwdFAT661FnUNf+JksU9mK4XrA11NF1qoqD2gLj?=
 =?us-ascii?Q?64M0mRSdinPkQGmgi3nrrqx8AiZx1zrmi6L4kVsz/WG708Wkll23/3zHztrD?=
 =?us-ascii?Q?IRHf7v5ZqzEOIymcopXZZwbXq+wLWfQPOQhQYxEsz9N5NaQ8+v4hcYrTmz1/?=
 =?us-ascii?Q?oIqT5dsW+P8eHNue+3lX5q6Qb8FRp5FdYBmGx6swbxvLFbYSRQsBje3nQm3/?=
 =?us-ascii?Q?3tk+VX5lKyvwisd9XwyxRij+k5XDxIDuAnOTF35IxHtu1WaMR1o6fAtuLNKf?=
 =?us-ascii?Q?wHOXxqiqjGRtf65Z6t9yrCxa2yJ8z3rBJjqe7JJ7idYi2WxXVeNR2ubzbAl1?=
 =?us-ascii?Q?Eiuy47j/ENHo9utNqt8z2nN0mzS4byPOt3RJ64pH4N0pXfk+/avZpCbHVxJ9?=
 =?us-ascii?Q?HeiZXbDeOEPtBYSeRRwUWox80qWto1IKGNrv/JsSHBn3TI7hD8WZLFJ87QY7?=
 =?us-ascii?Q?pF+rAFxbZEvzvZJkfdp+nVmOmmre9SgKbW+2CRdpgoEgorL3W30ZoU/V5at6?=
 =?us-ascii?Q?8JiMUA5XNiCHrv/6EbkkP78lP/pW9H3zt9Te3YgqORfu953Wk0aFDM6BwjHa?=
 =?us-ascii?Q?7Jod+cq/lf5zr7x6DisSDOcoqT8Zep2v4aTTC2vLGkvBFclMPxbN3Exdw9Er?=
 =?us-ascii?Q?rRqRXRfn6J5xGw2JLy51VQ/1b1hsSU/zcp3iBZGfCz2sw/rehp+xS17LcG/1?=
 =?us-ascii?Q?kosNMKx0no2YgTWsEwU+OzfefviwEWAkdwDXZrB9phk/W1jbrElKtjC60Nzr?=
 =?us-ascii?Q?CWaNmd7WrUcUnqwR2K3G7jlJVX64FTPhJlZBy1a+TQUwoqFaZNLPScqRKW7N?=
 =?us-ascii?Q?UmbGLtv6W/Gj8zgkYSL8tpk8w4wQ2M4xmY4JiRWl67hIYEu2jR6R4ZQIflWT?=
 =?us-ascii?Q?QE+VPNlUvNO+7eAGMMvEOT2jH+Jffla2DVudGy84W6llLj/opEvZPlVpe5DV?=
 =?us-ascii?Q?rQSi1TNosvXZmWN6JibWGfY/6quBcdyWGS1EbE1vWBbfPw=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH2PR12MB4215.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(366007)(1800799015)(376005)(38070700009); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?jyH5JendAOReLOLSyypgtuzQpHHGSfaNSRoD0LQL/1HpDZvUM6sBPmtgyLsk?=
 =?us-ascii?Q?So+SGwXUi9H9WiqEnw3Rn/IlAkG0rAl31aFZrD5FYqtGSs7DVqVJHmuAgvHk?=
 =?us-ascii?Q?2Ustx3c9CHspzLxSnVLv93SDwEOTgrwhey3LRdVftHlmM9KvNgtIxAQ30ypi?=
 =?us-ascii?Q?Yk3yIJSAFDMJfpz2J52a3WTaggTOTcKrgYk1wzYsXPt4zf4EutjE/Do9Ojwg?=
 =?us-ascii?Q?DfeGL5zVOMa4r/U7+NUctf39mdbzuBAxv5cKff7yf8zv72DlZbhK2ZX+NnRS?=
 =?us-ascii?Q?XGXFg564PGO+GvsPtBqoUS4duT6/2RG5C16CN6pSO02b7n9XS/xbw6PiAKYw?=
 =?us-ascii?Q?veMql4JwloQ27/fi5jDB+JtaNM/Rh6honEyGr9a1vBroT5tglXFUCaV9ZchF?=
 =?us-ascii?Q?onXSRsidL/uKufGUNkHrb8dXIPIhP7n2wQwZ5+ZQku6COAo2BorvMIGpyUgF?=
 =?us-ascii?Q?zd+3qADPTfK6ExcN5jNEpakAl4EPLwfWqRkoMcA5liq2cB23x+FcaV3gLnZh?=
 =?us-ascii?Q?zFHHVG/mNjJJjf85bhveLe8aQnSs9qyT0+WFUYSa8AVGwbSiF91gn59fPVP4?=
 =?us-ascii?Q?LPV9dWVuPyIgaYLBylwHnVNz/HrewnLSOFahBUA6k2VdPDdDFtCOdDaVMjty?=
 =?us-ascii?Q?0k/VcmWPaBtaX1FLCUnsUR2aBhMU7cpdWSuECnrxGnriYtYm0lypdF1AI2Qx?=
 =?us-ascii?Q?O0huZ96ph6xnQ5QOBcr9Txf1Q1x4AR70xB0IppCV7hx9JJYFh8pCwUYmOyV5?=
 =?us-ascii?Q?OOJyqPhI/CJGwCkEBqeLGfY5q3l8pGVbfdmk3Pn6hm6l45e+3myoj3nF7wGH?=
 =?us-ascii?Q?tkUOl9GUVNjb7k6YjIDBRQ91msaWnoXs56Bh/65A+5Uim2pbqjdgZMMvzaDr?=
 =?us-ascii?Q?389Bj+WQc7pcAehdHqs5+kPOMK2addwJYC3nQu/DRxp+cBxJn+9c2SFHUnyC?=
 =?us-ascii?Q?EXPXaZ5bRKFz8e+jPlWXj2HNfkDPKD6GM4XVyuO0ge2yJZWgbCrqe+crItuP?=
 =?us-ascii?Q?U3Ztlk+Mwt1ZW+0dXF9Fs665kkQqsxfD+dPyK0wi98ebXWtC/xWTx3bku8d4?=
 =?us-ascii?Q?bzG0Rej3rAEM/26OEGmtr1Er0EulOW3NXOA3kwAdpcTGf2y4zybpGOpjyISr?=
 =?us-ascii?Q?J9GgJzoO73IrR+M4a/wW7c02+nZ+KhruqgWed3xAXk6PGQzR0bjvnL/XorOf?=
 =?us-ascii?Q?Xp3YsomAWuLXQlSUuJNKDoy/1W8uxV4rEEqPJVqnsaPsw5fhPPN+BBRJm7Hi?=
 =?us-ascii?Q?3yRHcoDQ5LqNuSr96KMZ0AbwkDGwJsfYHmHV+R5PC01FVohnJJtWPOCQ5XdK?=
 =?us-ascii?Q?g2gxCCFvuNtqOc4MAN52lZHdJGnhEA4IfEcWsPxWe2bUXc/uq214g74rUZGT?=
 =?us-ascii?Q?6ImCcH9gMZglMLjBkh0te4A7N9IGhlRS+GWl72jWf0/aPuTqq3dgTuT2zPKD?=
 =?us-ascii?Q?zasOO6wF3j6sx0qhM6fpmgPcBrxVWv5UXxLq+oIVG6hGs2jhGObSHhMknXow?=
 =?us-ascii?Q?ciV1e/VQbY7kKjHAWWPO9yDpdakkai/X2WAGKuJMxnril1HbMcJn1dONZPVk?=
 =?us-ascii?Q?UMZcXas81/cafVqijrw=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH2PR12MB4215.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 86b8275b-5dc2-4cdb-0a18-08dc73b881fe
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 May 2024 01:52:27.1781 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: xa+mko9hVXFddQC56JlYZUhBB5kM7OoFBNRnKOiOKv3zBotd/noi7/l88wT5veDunpzXSfWtniR2YChantLqFw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB6269
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

Reviewed-by: YiPeng Chai <YiPeng.Chai@amd.com>

-----------------
Best Regards,
Thomas

-----Original Message-----
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Ma Jun
Sent: Monday, May 13, 2024 4:56 PM
To: amd-gfx@lists.freedesktop.org
Cc: Feng, Kenneth <Kenneth.Feng@amd.com>; Deucher, Alexander <Alexander.Deu=
cher@amd.com>; Wang, Yang(Kevin) <KevinYang.Wang@amd.com>; Koenig, Christia=
n <Christian.Koenig@amd.com>; Ma, Jun <Jun.Ma2@amd.com>
Subject: [PATCH 5/5] drm/amdgpu: Remove dead code in amdgpu_ras_add_mca_err=
_addr

Remove dead code in amdgpu_ras_add_mca_err_addr

Signed-off-by: Ma Jun <Jun.Ma2@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c | 13 -------------
 1 file changed, 13 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c b/drivers/gpu/drm/amd/=
amdgpu/amdgpu_ras.c
index 6da02a209890..0cf67923c0fc 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
@@ -4292,21 +4292,8 @@ static struct ras_err_info *amdgpu_ras_error_get_inf=
o(struct ras_err_data *err_d

 void amdgpu_ras_add_mca_err_addr(struct ras_err_info *err_info, struct ras=
_err_addr *err_addr)  {
-       struct ras_err_addr *mca_err_addr;
-
        /* This function will be retired. */
        return;
-       mca_err_addr =3D kzalloc(sizeof(*mca_err_addr), GFP_KERNEL);
-       if (!mca_err_addr)
-               return;
-
-       INIT_LIST_HEAD(&mca_err_addr->node);
-
-       mca_err_addr->err_status =3D err_addr->err_status;
-       mca_err_addr->err_ipid =3D err_addr->err_ipid;
-       mca_err_addr->err_addr =3D err_addr->err_addr;
-
-       list_add_tail(&mca_err_addr->node, &err_info->err_addr_list);
 }

 void amdgpu_ras_del_mca_err_addr(struct ras_err_info *err_info, struct ras=
_err_addr *mca_err_addr)
--
2.34.1

