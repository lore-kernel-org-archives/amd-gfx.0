Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8F12FC2BBCA
	for <amd-gfx@archiver.kernel.org>; Fri, 28 Jun 2024 10:01:11 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2A24510E01F;
	Fri, 28 Jun 2024 10:01:11 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="jMss0gLc";
	dkim-atps=neutral
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2085.outbound.protection.outlook.com [40.107.236.85])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9B7FA10E01F
 for <amd-gfx@lists.freedesktop.org>; Fri, 28 Jun 2024 10:01:09 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OTbTsbZvQWZ/XVpku7WvQVm9aijmmbc3+SQc83Ej5QXAry5UCF5cAie3y/rNfsGCvw2q81deHEws6AuE72T9wgDpIaexh7IBV9h5TIe7zeKlVbXo874niqHf2OP+amUYy2krPoNRrhdDLnmjaN5j8TpcQPnjF/G9KEjYpNgDCHYuGTyxH1jQULMjV97lSXRY4JQkCRLiWgczi56g9IcYXdcPk3fOqHw0pYAd/WvKmXnosYCjgP9UN8aH9TJ0N053XCCJ/FVZFsME6nYqpQhdANPr9XLf5mtT9lN1dULyXpJJLnokM++Mo6Lb3f4HaHabXL4qoO7u18861SeNzG7xIg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aj4tX3GoQv5EcrKYDw73D0y3Ocj+rVFjcL2EZpQsJ1c=;
 b=Djm5WMgAqVDWy3bfpsH2WM1G1stzIVxoRHVJV1HXL0ZKcT/7izRiMBm4LUomr+LAmcO9D+ASfyLw5G/d54QXWivoYMnr2qq3SKPononWiHhSM5d7VAURzE7saCunZf3Yev+hl0chhuYhpOb9OSszrZA1TOjmQXd8PcWUQmB9fS/6j0LEj95C0TTDOhErgzy2nOD5kzPYyF2ZPO//RZp8pZoYu1OEpgOAGPcNGe79pQGl1n28MnrcrTL+nVYBhWOBVwvbE4muRXw4xWsxg6AVGKKwqvFh7HeVYsZv9OaZ0THeIPBoc95fAovY0Z/j/hxyUAWAAt8l9nMmNfmZlp9x3w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aj4tX3GoQv5EcrKYDw73D0y3Ocj+rVFjcL2EZpQsJ1c=;
 b=jMss0gLcgYZOwYTITfBKR6BuZL6BcNCDXX3AuUlly19TN0gJRrx7WiQpXQHv2WKZu+B+9NJubACZ/VNSxfCPl25/AVzF2NfdbARcJkB9gsihjBN13BAR6KG7QKe/C2tUb3eDr2kZy7rcjDFyD+dYfEG0yvkNP9Sz95rp76f1l8A=
Received: from CH2PR12MB4215.namprd12.prod.outlook.com (2603:10b6:610:ab::24)
 by SN7PR12MB8131.namprd12.prod.outlook.com (2603:10b6:806:32d::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7698.37; Fri, 28 Jun
 2024 10:01:01 +0000
Received: from CH2PR12MB4215.namprd12.prod.outlook.com
 ([fe80::b053:488f:853d:892a]) by CH2PR12MB4215.namprd12.prod.outlook.com
 ([fe80::b053:488f:853d:892a%6]) with mapi id 15.20.7719.022; Fri, 28 Jun 2024
 10:01:01 +0000
From: "Chai, Thomas" <YiPeng.Chai@amd.com>
To: "Zhang, Hawking" <Hawking.Zhang@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
CC: "Zhou1, Tao" <Tao.Zhou1@amd.com>, "Li, Candice" <Candice.Li@amd.com>,
 "Wang, Yang(Kevin)" <KevinYang.Wang@amd.com>, "Yang, Stanley"
 <Stanley.Yang@amd.com>
Subject: RE: [PATCH] drm/amdgpu: add mutex to protect ras shared memory
Thread-Topic: [PATCH] drm/amdgpu: add mutex to protect ras shared memory
Thread-Index: AQHax29xE3LsY0JZak6lE7te1qFckbHc8A8AgAAFMdA=
Date: Fri, 28 Jun 2024 10:01:01 +0000
Message-ID: <CH2PR12MB4215C667B550C62A10881881FCD02@CH2PR12MB4215.namprd12.prod.outlook.com>
References: <20240626022001.1139403-1-YiPeng.Chai@amd.com>
 <BN9PR12MB525743E2957686C33851547AFCD02@BN9PR12MB5257.namprd12.prod.outlook.com>
In-Reply-To: <BN9PR12MB525743E2957686C33851547AFCD02@BN9PR12MB5257.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ActionId=66cd1c4c-c409-4098-a1ce-1c02a6aacb55;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=0;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=true;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution Only;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2024-06-28T09:38:59Z;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH2PR12MB4215:EE_|SN7PR12MB8131:EE_
x-ms-office365-filtering-correlation-id: 49799e9e-d011-47ee-db0f-08dc97593723
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|376014|366016|1800799024|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?w+k9tt2wsAPx2QTgrzk0MnwlHwppbt94UA9HlLCyaZKu+F5JisNqqQ+uYlIn?=
 =?us-ascii?Q?8pyJsGlhgf6tWmTSevS8XGJiMHfNqeV4BNY3mo6DgRJizDAn5hK7to7U+GQG?=
 =?us-ascii?Q?yO3sTJxAs7WxVx+9CKtKMPU0bpiSZr4bVJNZSnZC/ObixqdgkBxQi1r3r+Az?=
 =?us-ascii?Q?1YhOn1RumhL7M4d9STNwSmnQaISyUSetMHaXHkT6xpP4s4Fn8DRPRuvNb1OM?=
 =?us-ascii?Q?c9TiKncSmFkwtx2zygH07i49u5v5Btl6qy3UHG/I9/Wmhxxc03aigATHz287?=
 =?us-ascii?Q?R75anT5rTKbrXtcZVUDdGKonQBTUbMz7FLFCunR5AcW0NnSFFWb4qMuuN719?=
 =?us-ascii?Q?QIhCYT+ntojGqF11IffMVauXdxZ7sEI9pYDyYse77MY9Q+0gn/PVtHCGEnl0?=
 =?us-ascii?Q?Aw0WpfCPWbOnevmOEJYrKNpFcyuyWww3fv7NHr2ohVZx1HUULjumfa7Yr9i6?=
 =?us-ascii?Q?132Ls4k9lS5LH7TkEmsjC8MCzoVpNz5iVzM+LQmW+RAdGjJ8JFx+lBkgSnnx?=
 =?us-ascii?Q?ebRJvDCEWWERB9euunv1Ek398UrNTbcXsv7lFdII9PdTGA+kSIVKyEaDijHX?=
 =?us-ascii?Q?QqKCkRgMKzY5DWpkwo0l9kR0mHYn58qwh/3TlJqvMVPil55qFq8iMT2SeRQd?=
 =?us-ascii?Q?IMETebn+MH2yg9R1nbb586w65XDNtvypwEKgxQPWVhwMDncApGw1zTzHJuQD?=
 =?us-ascii?Q?aJqwQfO1/W/QvOmpqcuACfwANeA8wCtA0R2iChBvEWjvTbXEv0NnHDxd0bWE?=
 =?us-ascii?Q?p0CYLfsFmn1mfLwGkZFR58Uray9q5uzOHwdClRkQTcsEoe9ik/wJ5dU2xyD0?=
 =?us-ascii?Q?RqY3TtWCGd8T6wg58w6OkVnJ/GQiD7cZ4SsmV3mPZaWoV2rVpb0TxreG46F2?=
 =?us-ascii?Q?RL33NMqI1pgx1TbZs2oxUc2/dE06s3+5NzlQjLvk+NAcdrtxT6iMYrfBAL8H?=
 =?us-ascii?Q?Ozvd2v0ekc3pQAOXNiQdqJ3iLuxzwrxbkwj64VI90Jyln00azGCeAbecoAsG?=
 =?us-ascii?Q?zc0HVjIUrTNOT5ZWTUSxaejXqNfnaeo9YcNd2YANxCiyyF/tFFFiF7qhn98m?=
 =?us-ascii?Q?tXlKg7srKQmAIYEwEN2cJ5Uk49B7WOVcr73sR9uKx5PjFOvdY3Duj/UpQKzz?=
 =?us-ascii?Q?n7sMc9mD6Oop+FDFjWOC8lMgiivtcQw2aOuxL+bUzJ15hJjgUHYkgByLX4Yl?=
 =?us-ascii?Q?D8FAuEFEZOkU95DeavxCt1L1ulxXEuQx26spfnEAPBUvo4K11wCrUE8OiwiC?=
 =?us-ascii?Q?xq/Kkwbd9gUO1ECz2nTEY/R/egfl5PtPfkY2ElGVWCnaqrJ14Kl5pyHiWsuG?=
 =?us-ascii?Q?bWxosfVuUyXvGIowMIzUUiCx0xDQB/7dSXegKoqYK+1yrZTR6TuScVBgLvou?=
 =?us-ascii?Q?zMA0LFL9qgdi2+BCKkPu4fJA/7qwgaA/ncNZL1jCVaLMXDLOGg=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH2PR12MB4215.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(38070700018); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?zQMH5UyDvAp+UOE5VBUG3Tjo6idRgtDUoXWCsZMwxpnBKgUeqP2Q2zvYPSdD?=
 =?us-ascii?Q?kOs+9bliXRIR2RVEesC7RhZxXxQ5lnHver5qIsMzobsTNHFQuJXec2RhysEB?=
 =?us-ascii?Q?ONErS7wXMtsnFK4gbUdXUAHB+M4aYTl3bDDlWyfE2yDGzaGRTSmiRZP5D6Te?=
 =?us-ascii?Q?o5NidoT/JYrtmHZa96ep1zkRXdaoIwhSFIhYatGYwWugzWSi+x9I596cvyDg?=
 =?us-ascii?Q?bMUei9kww6RgU08XkC9clAV/5ieh4tYAGYK2/sVCQyTmOi89Fnq812DvtHKx?=
 =?us-ascii?Q?ICBeiRRNwQBU/xQY96Z7GICn3jrCseypb9n76cKiswvEUuWJcAFJdJ9OUrYv?=
 =?us-ascii?Q?kuTDKxeaQOXM2m2/f1qhD8O65RMsZJNXsoQQILMkuC+TqkPgF1Mx0DAolRZW?=
 =?us-ascii?Q?nAH4pPp/bj25eAmwOg56KMOF7Lk9TZ6/H///n+4gQc9KfrAU5NZbPnv3lhwR?=
 =?us-ascii?Q?ORouxnm9SUP8hQMFNUsYxzXBEMI5gObu95yxj0t4ZLCghR+C5tlWRAJ2wZZW?=
 =?us-ascii?Q?OvnZ5h0JZ7YYEevgnkoZP6xPHTdK+tNs7ylXyLZIwXQFLj1/NI5WlJ4IkGSG?=
 =?us-ascii?Q?wn2QJufH2PTcoBzO+18H85khgDFI84AmZ5bdpmdNtNh1UzENq9ghZGykp020?=
 =?us-ascii?Q?z2uxGbZyXRnNGha8cS1x8xefbkCizpI1vdJ+YmNUBtOqw0mUXZbHhwijrPbq?=
 =?us-ascii?Q?+HY89Wm9G/BMu/rQxX9HKjQFKEhcL2nvEePfN8FeR2awayOozuqQbdLvjuSR?=
 =?us-ascii?Q?zYS1vygRUtHbZGsLR8BISLkfWtPcXOX2R4vdjKS7Yz6eGqOIoguhAgLePjEx?=
 =?us-ascii?Q?D0NE4pKVOIXxkJ6IdnqvOd98xl8Yfehmi18Ga99arqPRDOLa/Dy+XPrxDNYi?=
 =?us-ascii?Q?5Ej8FttfaRsNjwc0NcRGFz4cMeQR/cPq45ORYBGa+gXcOOWreYq3Hwq2EEAX?=
 =?us-ascii?Q?NazWwmWIHKVhOE5GvBT8u9YRtvR7d6TqO1/SaZqJOccYmNTeExS8JNKeCuxT?=
 =?us-ascii?Q?JGCgPjo1W+MLa9N2syWFCVbyMSkDoM/P6mHIyv4ee+M7Xw4POgFwvaoz0S+N?=
 =?us-ascii?Q?vLSivNIXx6dI2I8cMiIVNbhsUYEsCFhdo+YS/tPlQDCqgvPDyqZfgPl9cL7h?=
 =?us-ascii?Q?Y85PQhFRVaVrQkM9+CmmH64zq35Phwk3DyRTGXftXjlPp8C8aK5PdLa5jb0/?=
 =?us-ascii?Q?C4hIfS5e83PHDy0DJeUZI9xJbotQgIoN8+eOoFbO+U26cAjcgJ6E2Vq7Q+RI?=
 =?us-ascii?Q?f18Mg+GZc4A3InUEfbQqNP5j78qW0ItD/lh3xTdu79k9z93cCyNUsvqZcCyO?=
 =?us-ascii?Q?HOYbObBYLaYwQj3mO9Sm/1lH/9xw5W4DOA+pv3rODPj2P0JHxZoiqsSIHDd2?=
 =?us-ascii?Q?QKKZ+B86jaUGf5kntjZxWZB5ZBvhIVRdDDR1yB67gIN25ngLELKHwRo685bv?=
 =?us-ascii?Q?HN5n+Zdwj5+2Rc/MZ8sGz2d7S2tD61XbNf7RAd4bfAPWEmsDui3Qv6EChTKm?=
 =?us-ascii?Q?V3/EyF+Q/hYYH+fkdF1yS43uri1vbNk0Z2EWbxdIQ+LxCcCKtGw3X4tlDxHI?=
 =?us-ascii?Q?A893A+/0/nrGCUF9ZRM=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH2PR12MB4215.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 49799e9e-d011-47ee-db0f-08dc97593723
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Jun 2024 10:01:01.2652 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: N3m0JmfB7b2/pwhMGio1ZzmSbt+yAhyzQrHQC2B5dyhP7OGvmfVRAfE3OMhjCrQhN1gUPUlvR1vUobG9TRUJUQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB8131
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

OK


-----------------
Best Regards,
Thomas

-----Original Message-----
From: Zhang, Hawking <Hawking.Zhang@amd.com>
Sent: Friday, June 28, 2024 5:42 PM
To: Chai, Thomas <YiPeng.Chai@amd.com>; amd-gfx@lists.freedesktop.org
Cc: Zhou1, Tao <Tao.Zhou1@amd.com>; Li, Candice <Candice.Li@amd.com>; Wang,=
 Yang(Kevin) <KevinYang.Wang@amd.com>; Yang, Stanley <Stanley.Yang@amd.com>=
; Chai, Thomas <YiPeng.Chai@amd.com>
Subject: RE: [PATCH] drm/amdgpu: add mutex to protect ras shared memory

[AMD Official Use Only - AMD Internal Distribution Only]

+       ret =3D psp_ras_invoke(psp, ras_cmd->cmd_id);

+       case TA_RAS_COMMAND__TRIGGER_ERROR:
+               if (out) {
+                       uint32_t *ras_status =3D (uint32_t *)out;
+
+                       *ras_status =3D ras_cmd->ras_status;
+               }
+               break;
+       case TA_RAS_COMMAND__QUERY_ADDRESS:
+               if (ret || ras_cmd->ras_status || psp->cmd_buf_mem->resp.st=
atus)
+                       ret =3D -EINVAL;

Shall we make the following check for both TRIGGER_ERROR and QUERY_ADDRESS =
command?

+               if (ret || ras_cmd->ras_status || psp->cmd_buf_mem->resp.st=
atus)
+                       ret =3D -EINVAL;

Regards,
Hawking
-----Original Message-----
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of YiPeng C=
hai
Sent: Wednesday, June 26, 2024 10:20
To: amd-gfx@lists.freedesktop.org
Cc: Zhang, Hawking <Hawking.Zhang@amd.com>; Zhou1, Tao <Tao.Zhou1@amd.com>;=
 Li, Candice <Candice.Li@amd.com>; Wang, Yang(Kevin) <KevinYang.Wang@amd.co=
m>; Yang, Stanley <Stanley.Yang@amd.com>; Chai, Thomas <YiPeng.Chai@amd.com=
>
Subject: [PATCH] drm/amdgpu: add mutex to protect ras shared memory

Add mutex to protect ras shared memory.

Signed-off-by: YiPeng Chai <YiPeng.Chai@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c    | 124 ++++++++++++++-------
 drivers/gpu/drm/amd/amdgpu/amdgpu_psp.h    |   1 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_psp_ta.c |   2 +
 3 files changed, 87 insertions(+), 40 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c b/drivers/gpu/drm/amd/=
amdgpu/amdgpu_psp.c
index fec968d8340f..323b3c470c5c 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
@@ -1573,6 +1573,69 @@ static void psp_ras_ta_check_status(struct psp_conte=
xt *psp)
        }
 }

+static int psp_ras_send_cmd(struct psp_context *psp,
+               enum ras_command cmd_id, void *in, void *out) {
+       struct ta_ras_shared_memory *ras_cmd;
+       uint32_t cmd =3D cmd_id;
+       int ret =3D 0;
+
+       if (!in)
+               return -EINVAL;
+
+       mutex_lock(&psp->ras_context.mutex);
+       ras_cmd =3D (struct ta_ras_shared_memory *)psp->ras_context.context=
.mem_context.shared_buf;
+       memset(ras_cmd, 0, sizeof(struct ta_ras_shared_memory));
+
+       switch (cmd) {
+       case TA_RAS_COMMAND__ENABLE_FEATURES:
+       case TA_RAS_COMMAND__DISABLE_FEATURES:
+               memcpy(&ras_cmd->ras_in_message,
+                       in, sizeof(ras_cmd->ras_in_message));
+               break;
+       case TA_RAS_COMMAND__TRIGGER_ERROR:
+               memcpy(&ras_cmd->ras_in_message.trigger_error,
+                       in, sizeof(ras_cmd->ras_in_message.trigger_error));
+               break;
+       case TA_RAS_COMMAND__QUERY_ADDRESS:
+               memcpy(&ras_cmd->ras_in_message.address,
+                       in, sizeof(ras_cmd->ras_in_message.address));
+               break;
+       default:
+               dev_err(psp->adev->dev, "Invalid ras cmd id: %u\n", cmd);
+               ret =3D -EINVAL;
+               goto err_out;
+       }
+
+       ras_cmd->cmd_id =3D cmd;
+       ret =3D psp_ras_invoke(psp, ras_cmd->cmd_id);
+
+       switch (cmd) {
+       case TA_RAS_COMMAND__TRIGGER_ERROR:
+               if (out) {
+                       uint32_t *ras_status =3D (uint32_t *)out;
+
+                       *ras_status =3D ras_cmd->ras_status;
+               }
+               break;
+       case TA_RAS_COMMAND__QUERY_ADDRESS:
+               if (ret || ras_cmd->ras_status || psp->cmd_buf_mem->resp.st=
atus)
+                       ret =3D -EINVAL;
+               else if (out)
+                       memcpy(out,
+                               &ras_cmd->ras_out_message.address,
+                               sizeof(ras_cmd->ras_out_message.address));
+               break;
+       default:
+               break;
+       }
+
+err_out:
+       mutex_unlock(&psp->ras_context.mutex);
+
+       return ret;
+}
+
 int psp_ras_invoke(struct psp_context *psp, uint32_t ta_cmd_id)  {
        struct ta_ras_shared_memory *ras_cmd; @@ -1614,23 +1677,15 @@ int p=
sp_ras_invoke(struct psp_context *psp, uint32_t ta_cmd_id)  int psp_ras_ena=
ble_features(struct psp_context *psp,
                union ta_ras_cmd_input *info, bool enable)  {
-       struct ta_ras_shared_memory *ras_cmd;
+       enum ras_command cmd_id;
        int ret;

-       if (!psp->ras_context.context.initialized)
+       if (!psp->ras_context.context.initialized || !info)
                return -EINVAL;

-       ras_cmd =3D (struct ta_ras_shared_memory *)psp->ras_context.context=
.mem_context.shared_buf;
-       memset(ras_cmd, 0, sizeof(struct ta_ras_shared_memory));
-
-       if (enable)
-               ras_cmd->cmd_id =3D TA_RAS_COMMAND__ENABLE_FEATURES;
-       else
-               ras_cmd->cmd_id =3D TA_RAS_COMMAND__DISABLE_FEATURES;
-
-       ras_cmd->ras_in_message =3D *info;
-
-       ret =3D psp_ras_invoke(psp, ras_cmd->cmd_id);
+       cmd_id =3D enable ?
+               TA_RAS_COMMAND__ENABLE_FEATURES : TA_RAS_COMMAND__DISABLE_F=
EATURES;
+       ret =3D psp_ras_send_cmd(psp, cmd_id, info, NULL);
        if (ret)
                return -EINVAL;

@@ -1654,6 +1709,8 @@ int psp_ras_terminate(struct psp_context *psp)

        psp->ras_context.context.initialized =3D false;

+       mutex_destroy(&psp->ras_context.mutex);
+
        return ret;
 }

@@ -1738,9 +1795,10 @@ int psp_ras_initialize(struct psp_context *psp)

        ret =3D psp_ta_load(psp, &psp->ras_context.context);

-       if (!ret && !ras_cmd->ras_status)
+       if (!ret && !ras_cmd->ras_status) {
                psp->ras_context.context.initialized =3D true;
-       else {
+               mutex_init(&psp->ras_context.mutex);
+       } else {
                if (ras_cmd->ras_status)
                        dev_warn(adev->dev, "RAS Init Status: 0x%X\n", ras_=
cmd->ras_status);

@@ -1754,12 +1812,12 @@ int psp_ras_initialize(struct psp_context *psp)  in=
t psp_ras_trigger_error(struct psp_context *psp,
                          struct ta_ras_trigger_error_input *info, uint32_t=
 instance_mask)  {
-       struct ta_ras_shared_memory *ras_cmd;
        struct amdgpu_device *adev =3D psp->adev;
        int ret;
        uint32_t dev_mask;
+       uint32_t ras_status;

-       if (!psp->ras_context.context.initialized)
+       if (!psp->ras_context.context.initialized || !info)
                return -EINVAL;

        switch (info->block_id) {
@@ -1783,13 +1841,8 @@ int psp_ras_trigger_error(struct psp_context *psp,
        dev_mask &=3D AMDGPU_RAS_INST_MASK;
        info->sub_block_index |=3D dev_mask;

-       ras_cmd =3D (struct ta_ras_shared_memory *)psp->ras_context.context=
.mem_context.shared_buf;
-       memset(ras_cmd, 0, sizeof(struct ta_ras_shared_memory));
-
-       ras_cmd->cmd_id =3D TA_RAS_COMMAND__TRIGGER_ERROR;
-       ras_cmd->ras_in_message.trigger_error =3D *info;
-
-       ret =3D psp_ras_invoke(psp, ras_cmd->cmd_id);
+       ret =3D psp_ras_send_cmd(psp,
+                       TA_RAS_COMMAND__TRIGGER_ERROR, info,
+ &ras_status);
        if (ret)
                return -EINVAL;

@@ -1799,9 +1852,9 @@ int psp_ras_trigger_error(struct psp_context *psp,
        if (amdgpu_ras_intr_triggered())
                return 0;

-       if (ras_cmd->ras_status =3D=3D TA_RAS_STATUS__TEE_ERROR_ACCESS_DENI=
ED)
+       if (ras_status =3D=3D TA_RAS_STATUS__TEE_ERROR_ACCESS_DENIED)
                return -EACCES;
-       else if (ras_cmd->ras_status)
+       else if (ras_status)
                return -EINVAL;

        return 0;
@@ -1811,25 +1864,16 @@ int psp_ras_query_address(struct psp_context *psp,
                          struct ta_ras_query_address_input *addr_in,
                          struct ta_ras_query_address_output *addr_out)  {
-       struct ta_ras_shared_memory *ras_cmd;
        int ret;

-       if (!psp->ras_context.context.initialized)
-               return -EINVAL;
-
-       ras_cmd =3D (struct ta_ras_shared_memory *)psp->ras_context.context=
.mem_context.shared_buf;
-       memset(ras_cmd, 0, sizeof(struct ta_ras_shared_memory));
-
-       ras_cmd->cmd_id =3D TA_RAS_COMMAND__QUERY_ADDRESS;
-       ras_cmd->ras_in_message.address =3D *addr_in;
-
-       ret =3D psp_ras_invoke(psp, ras_cmd->cmd_id);
-       if (ret || ras_cmd->ras_status || psp->cmd_buf_mem->resp.status)
+       if (!psp->ras_context.context.initialized ||
+               !addr_in || !addr_out)
                return -EINVAL;

-       *addr_out =3D ras_cmd->ras_out_message.address;
+       ret =3D psp_ras_send_cmd(psp,
+                       TA_RAS_COMMAND__QUERY_ADDRESS, addr_in,
+ addr_out);

-       return 0;
+       return ret;
 }
 // ras end

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.h b/drivers/gpu/drm/amd/=
amdgpu/amdgpu_psp.h
index 3635303e6548..74a96516c913 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.h
@@ -200,6 +200,7 @@ struct psp_xgmi_context {  struct psp_ras_context {
        struct ta_context               context;
        struct amdgpu_ras               *ras;
+       struct mutex                    mutex;
 };

 #define MEM_TRAIN_SYSTEM_SIGNATURE             0x54534942
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp_ta.c b/drivers/gpu/drm/a=
md/amdgpu/amdgpu_psp_ta.c
index 8e8afbd237bc..0c856005df6b 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp_ta.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp_ta.c
@@ -348,6 +348,7 @@ static ssize_t ta_if_invoke_debugfs_write(struct file *=
fp, const char *buf, size

        context->session_id =3D ta_id;

+       mutex_lock(&psp->ras_context.mutex);
        ret =3D prep_ta_mem_context(&context->mem_context, shared_buf, shar=
ed_buf_len);
        if (ret)
                goto err_free_shared_buf; @@ -366,6 +367,7 @@ static ssize_=
t ta_if_invoke_debugfs_write(struct file *fp, const char *buf, size
                ret =3D -EFAULT;

 err_free_shared_buf:
+       mutex_unlock(&psp->ras_context.mutex);
        kfree(shared_buf);

        return ret;
--
2.34.1


