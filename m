Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 11842CFC26B
	for <amd-gfx@archiver.kernel.org>; Tue, 15 Oct 2024 06:09:10 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A250910E03A;
	Tue, 15 Oct 2024 06:09:10 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="UXotNXAZ";
	dkim-atps=neutral
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2061.outbound.protection.outlook.com [40.107.243.61])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E234B10E03A
 for <amd-gfx@lists.freedesktop.org>; Tue, 15 Oct 2024 06:09:08 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=G4CSwE0rgboVZ01UM9y0wA+MtckdKrT9cMY6DhcW9qJ4KmYwo/6mf/Wz8zXDOXoGOqUl+KVgy4z3UazK/FStRS08jPT/xwGKs4GgnosdjnNhCILZv11Og+uMUSQAcPjaksXyxY5Mf33TK8axBmVTgqp4SDZIBEUriD2NobyLTzFAS6rOECrmX510V+osplNnmGrK59j+lJ416DxylUDIICk1hlPiNBKtoWHLcKKSci5k4lrqOjD5AVn6nEjnZ443dm1/TOQYdVxVNQ4J6ZBVV8fvVdLYM7kKgevd+nZOkhyT0cHNXOZ/ZrHU7tpXWbpNO8LkWnLX6gP9nvgzgF2aFQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=12PuoGv4H8ODAn9DKQ8TwZK4EqVtpj1oTV7ftthANsY=;
 b=htqnYt/Lb0dMCy5yGDoEOED96xMSytqcOX94lhYNFB0qpRxbpnoUVtUX+rV4b7GYVwOKX6mYu1CgG81Qn/lqIhz6ROMwcpwYtEE8mMjqWit0lS7SCQ+AMHtvTJq5SWbpEaugOPYEiwNAxIgZgbl7voVGNrTAWP+CuPOCRtyOoBTfO2XY7/JJag4eAfhJdzWxDMFZGGrc7IeTDL2wNU9xFru9ng0Ey6oTp3hmkv9Q/ii1hJJ7TS3XRcvRwdHotF5kapNDwLwqJmiYEphFKHBQIchJxAaCQRoOuQvIBqzMND5wJoO5m03F1SpiU3bnxeI9ejhMg0pt3nociARJ0OK02Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=12PuoGv4H8ODAn9DKQ8TwZK4EqVtpj1oTV7ftthANsY=;
 b=UXotNXAZBQsEQtp8VsU+Rw6M8xylVXoeZWwH+D2bf4tGlce24hOvx5i2DAK+6gf08H4BUCJBWf/MTKc7jFAaX5ZTp8XqxO7+rU4/2Re8xzWpqIJbI9bKv/RdL93prsvDGaTXwMGrx7NY8DhVuTEp1A9jzA5/6uw4A7MIFN+7iSc=
Received: from PH7PR12MB5997.namprd12.prod.outlook.com (2603:10b6:510:1d9::21)
 by MW4PR12MB7192.namprd12.prod.outlook.com (2603:10b6:303:22a::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.17; Tue, 15 Oct
 2024 06:09:03 +0000
Received: from PH7PR12MB5997.namprd12.prod.outlook.com
 ([fe80::c5da:9b53:9d77:c708]) by PH7PR12MB5997.namprd12.prod.outlook.com
 ([fe80::c5da:9b53:9d77:c708%5]) with mapi id 15.20.8048.020; Tue, 15 Oct 2024
 06:09:02 +0000
From: "Wang, Yang(Kevin)" <KevinYang.Wang@amd.com>
To: "Lazar, Lijo" <Lijo.Lazar@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
CC: "Zhang, Hawking" <Hawking.Zhang@amd.com>, "Deucher, Alexander"
 <Alexander.Deucher@amd.com>, "Koenig, Christian" <Christian.Koenig@amd.com>
Subject: RE: [PATCH] drm/amdgpu: Zero-initialize mqd backup memory
Thread-Topic: [PATCH] drm/amdgpu: Zero-initialize mqd backup memory
Thread-Index: AQHbHsPiCNc/f0V/LUezFu/GGhSNXbKHU9Qg
Date: Tue, 15 Oct 2024 06:09:02 +0000
Message-ID: <PH7PR12MB599794373BF7931611F130F682452@PH7PR12MB5997.namprd12.prod.outlook.com>
References: <20241015053345.3044483-1-lijo.lazar@amd.com>
In-Reply-To: <20241015053345.3044483-1-lijo.lazar@amd.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ActionId=5f12f438-b4a0-46af-ae50-c911f87769bf;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=0;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=true;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution Only;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2024-10-15T06:08:40Z;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR12MB5997:EE_|MW4PR12MB7192:EE_
x-ms-office365-filtering-correlation-id: 4423c05f-56a4-423f-2f61-08dcecdfddd9
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|1800799024|376014|366016|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?7PouzuWVvb6OLE1h0WO31QCTOwAhNDTM/urjgXuUbRpf+3SEQAsDJEiyCqCt?=
 =?us-ascii?Q?kcUPozyG6RRmXpUB6RuYOWqWGoT6joPtRaRkmnZDwj1tPgunFdW42yNLRfz/?=
 =?us-ascii?Q?Gr6TiacL/8jtlkpKh/OaXGkL0Uny34/gZbb1NKhZ3jZ90O9QcnuL1obJ9U3v?=
 =?us-ascii?Q?jvH+PMCR/l54RW9PdQGPcVcR7IRFxxyPguRDupFsuD/UbYn48VeNBjxVXf8/?=
 =?us-ascii?Q?84nlaYHPX3mdBQ1+z6SNTn8YNT4h1Bxt0V1aFbTunkYYnH1T7rf/k2wPdHkY?=
 =?us-ascii?Q?KMVAZFV18LqPvnkHtoqbwUgoQm3CEPh47BvtsQX6N5WNdZVJVFBokyKJcUNM?=
 =?us-ascii?Q?Dy4CRYpuwuUDZTrJmITLkC7Gq3NrxGg+xxcLDC6ptDrpTiV5+wowmPYSnwFu?=
 =?us-ascii?Q?1WtStjz3f7cjADQhJI1Hv/YSM1N++1WyzNjRWvbkRtVXaWOtVV7ERo6zXEp0?=
 =?us-ascii?Q?1lnhiHmVDdiOxk3Stc0i7yOzemBL4alCShnBolVAED/oob1C9aas1bBqy2zy?=
 =?us-ascii?Q?ANYGnSW+GG9Q8RsjdXezbn6r9rWex78TZ2zDWXmteJd8KybUbH+Qz5nkZJ7h?=
 =?us-ascii?Q?JiXjW4Tn0yqi0U4bql+c2gxnngTQzjpD8cdr+oEH/vfSh6bwbG1K+MpwjmhU?=
 =?us-ascii?Q?mArYAiW4Vg/i5ghKWaf8FP4Nib28bfa/uJT0vmAXHs5V3zAFuNfIn/YrkOeR?=
 =?us-ascii?Q?1kWbw2VHnN8WnZI/DtiSqcp2eEYhVensTgXt7eRitB8lgV18ZFnOz2M1QO4C?=
 =?us-ascii?Q?5zzpKyjN48OzrWBv7W8ghbuPxcKgaqMzy/QXhSoJZuIT2f6VTY/Fuh3bCv7U?=
 =?us-ascii?Q?enXcEv03MFGaVY4Ms6e5KLVpU6pQDG5tHhYirJEnvahsZMmgnpFCNkRtnei3?=
 =?us-ascii?Q?USToKx06BlEg31YIio9QWdivLwclT8nUMBoatlFVOqz8ABAgF+NGTNrYF9+0?=
 =?us-ascii?Q?m9bTDMBmcY8k84moZ1jD5nj/m2I0dLB9jPyCH/AX6rksNt0CFJribrV1Y/TN?=
 =?us-ascii?Q?42fIcgW7VOxhQU4m0WRwi+U9rjhDYFKDEHVAKJcnRnFZZvLHI2+qVQSoXcXE?=
 =?us-ascii?Q?kdJIdjtKa5jUpgj1dQqCsSXedY1sI4mB9MtFOqdplmik4lK7A7rZ2sm6Is19?=
 =?us-ascii?Q?/d3FoHCNXP9Acfr+Kx9P3WMLRN06NDmDH0bHa0Ad8hUQa9JAqmlCHddLgHM7?=
 =?us-ascii?Q?FPx1BI5GJRkljoH1XO/5nDG7IbUDDyTL95bmniz+qPCkuSHlWtuGiHyM4PQp?=
 =?us-ascii?Q?xC6fIa5PFvphogwnEkNGogAdig0a1yofk4oIXIFNW59fjZjjF4w4EBtdDynH?=
 =?us-ascii?Q?sAeIKzbKTOGfZHJnnTFr0kDn?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5997.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(38070700018); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?MCcuYsJxZ9AIBS3mID40j2lriK/hAtWaBHrfF+A23QKhFAzdzN01r3T1w6xa?=
 =?us-ascii?Q?QKQaZHT63EOIfFG6Dz27eITO1fITf8rF4wk9fQSGfI4JSsXPa3Wz6yya1n20?=
 =?us-ascii?Q?eYlnYzPpCIMdHX4fpRCbu3EPW6m2tJG5TkoomRx9NcQBbVDCIKgIUK0m4gD/?=
 =?us-ascii?Q?XD2heHqCKqHP6BYOlxQAr0kwo060j0o12RcJYIafg9iLbOmpR6sQtFTikgwK?=
 =?us-ascii?Q?g0saNt4elI6IblfZPA5gxwvC2Ghr0Nq7eUsGpSPSTTqoEzYMUTs2+zOIaubm?=
 =?us-ascii?Q?DdVY/nN5MUbjNtNTdWY/cuwTeMsRpE9RMD72qQQ5PX8vITykam2N+/LSLWKE?=
 =?us-ascii?Q?B5ZcEXpE3Y2qgN1TEmGt01lD5qJpUlBnpFI3ftgewlwBjQK97fGVJYQGcB5A?=
 =?us-ascii?Q?bdX1beLe1dyc+1MgX2n0PnZ+Q/GQAVituWim7pxC1o4Enhbugp2SI5xTYrad?=
 =?us-ascii?Q?yrocs7/RoAOxsbW1jjyWyFqYOTc0oT8NaBkTJnhc3+lUaZj0wocIGNdH8Sxd?=
 =?us-ascii?Q?9a4G27EzzxkBr0joJXVDWHkY0JilLBaDI0Ql7SyyAY/lNJTqAzpzo8cM5ip8?=
 =?us-ascii?Q?1Bj2zzUz5CHaw+wMxc8qBITrq8PAFc1SuDLN6Jh4+NA4UkoYTzBlubPw/Yi3?=
 =?us-ascii?Q?vbsKLNzeIopo5FbIpXqNlMWgXoU/mUM1s8IEpYyz/wo1Wcw/QL9AYwzkOYAN?=
 =?us-ascii?Q?KthKCcnjLLCFoWkCyCgig1x73OnJEiHIoi8mXvSGXaoMmEqhK9OpxrkoIaeG?=
 =?us-ascii?Q?Zq7qODUbyhII964zcbp2b9fhTsTQVSr+9wkIjPpwdtm2JRzwqvKZP85lYA2M?=
 =?us-ascii?Q?jdcU0qRAuj6aYZm+PU7uzPsy6QLgDlCr8TCaSjs01UaihT3WbeQRROdyy0Hc?=
 =?us-ascii?Q?08nds8KTX1gqXSiAPETyo6/0o/+pksRU3ZcfvtfBraFRC/iskSRVQnp7+FoL?=
 =?us-ascii?Q?lQPSo/QdQ6kveGMt5CtR0QVZyHghWc2WBXayaaFwpV7goQ/j3XIUN/O9KXJI?=
 =?us-ascii?Q?aRejFkP1+gmV/pS9ch2LcHliAEKMn02GXJvnjYMTnZ7Sypa33ZujuPypReCt?=
 =?us-ascii?Q?H81QO4twVW1WR3URzed6Fxr0NXLeEhcv6ai+TxKb8vuGIlRhiUVOW6PpHifA?=
 =?us-ascii?Q?w2Im/LO8MfCRaZ9DQqWUQjrTG5U03uZ79mMhXJ3r9s1jrXRFU05YliRQ/V9i?=
 =?us-ascii?Q?RAf3xoCa+LwiQd28xu2J+8o6mVpAVCfNgrZ63mzKdMV6STgSVY48UGWsEOYu?=
 =?us-ascii?Q?9n8gHg9TI17ULziANkoPzIsWH5/oPvljqfmPMCCD77w8SrqYfC6bWsMIYKxc?=
 =?us-ascii?Q?WG6GNtK2I6BH24WLFvmpx5Hy6eeJpCSvoG2SzHBxsrcVcKnxCC9OCHxvZ+Oi?=
 =?us-ascii?Q?5Y4QiEnnoyKQcX+ckUozhjmDH1lpo0YzQJi8XgRWCSGc79PwMeVwtIiHvtRy?=
 =?us-ascii?Q?SzqC3SJgTyI4f144EJ70f8+ZexMVj2JWsl9X06vQXWDbygIE8Q/4nw4nVvw3?=
 =?us-ascii?Q?9GgmIS/G4nTIuayNiodwdw9htRofV76CLKKAG0DvtDMPgaV1HPnqzqrHL0bQ?=
 =?us-ascii?Q?e5lO4hlRbUZfgUAAs34=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5997.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4423c05f-56a4-423f-2f61-08dcecdfddd9
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Oct 2024 06:09:02.3238 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: SQ5soteTZ4hvp7IDpHrx0PnsbkSFzJYoJE9L/c8HgYJmUpZ5S3T3QGvvYzfjQUEW
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB7192
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

Reviewed-by: Yang Wang <kevinyang.wang@amd.com>

Best Regards,
Kevin

-----Original Message-----
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Lijo Laz=
ar
Sent: Tuesday, October 15, 2024 1:34 PM
To: amd-gfx@lists.freedesktop.org
Cc: Zhang, Hawking <Hawking.Zhang@amd.com>; Deucher, Alexander <Alexander.D=
eucher@amd.com>; Koenig, Christian <Christian.Koenig@amd.com>
Subject: [PATCH] drm/amdgpu: Zero-initialize mqd backup memory

Zero-initialize mqd backup memory, otherwise the check for 'already-backed-=
up' could go wrong.

Signed-off-by: Lijo Lazar <lijo.lazar@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c b/drivers/gpu/drm/amd/=
amdgpu/amdgpu_gfx.c
index b6acbe923b6b..e96984c53e72 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
@@ -405,7 +405,7 @@ int amdgpu_gfx_mqd_sw_init(struct amdgpu_device *adev,
                }

                /* prepare MQD backup */
-               kiq->mqd_backup =3D kmalloc(mqd_size, GFP_KERNEL);
+               kiq->mqd_backup =3D kzalloc(mqd_size, GFP_KERNEL);
                if (!kiq->mqd_backup) {
                        dev_warn(adev->dev,
                                 "no memory to create MQD backup for ring %=
s\n", ring->name); @@ -428,7 +428,7 @@ int amdgpu_gfx_mqd_sw_init(struct am=
dgpu_device *adev,

                                ring->mqd_size =3D mqd_size;
                                /* prepare MQD backup */
-                               adev->gfx.me.mqd_backup[i] =3D kmalloc(mqd_=
size, GFP_KERNEL);
+                               adev->gfx.me.mqd_backup[i] =3D kzalloc(mqd_=
size, GFP_KERNEL);
                                if (!adev->gfx.me.mqd_backup[i]) {
                                        dev_warn(adev->dev, "no memory to c=
reate MQD backup for ring %s\n", ring->name);
                                        return -ENOMEM;
@@ -452,7 +452,7 @@ int amdgpu_gfx_mqd_sw_init(struct amdgpu_device *adev,

                        ring->mqd_size =3D mqd_size;
                        /* prepare MQD backup */
-                       adev->gfx.mec.mqd_backup[j] =3D kmalloc(mqd_size, G=
FP_KERNEL);
+                       adev->gfx.mec.mqd_backup[j] =3D kzalloc(mqd_size, G=
FP_KERNEL);
                        if (!adev->gfx.mec.mqd_backup[j]) {
                                dev_warn(adev->dev, "no memory to create MQ=
D backup for ring %s\n", ring->name);
                                return -ENOMEM;
--
2.25.1

