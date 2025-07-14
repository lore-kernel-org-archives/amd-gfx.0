Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8178CC83F1D
	for <amd-gfx@archiver.kernel.org>; Mon, 14 Jul 2025 02:21:10 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id ED28010E14F;
	Mon, 14 Jul 2025 02:21:09 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="aAFTtuF/";
	dkim-atps=neutral
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2060.outbound.protection.outlook.com [40.107.236.60])
 by gabe.freedesktop.org (Postfix) with ESMTPS id ABA6910E14F
 for <amd-gfx@lists.freedesktop.org>; Mon, 14 Jul 2025 02:21:08 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rmFwG8VsqSHsXaSrtL7nRD8H4/ik3y8MuhUEmkKhT9Qw8N4YajrN9O56tVQ9idMdcQkLZ2Owz8xnYjdrAFVdybj6FhC5eFJFuI/QlG+FVpN1CvfbFzUEs1h7Czas5PLcZqj9+oZtPigLP5oxTmPSuqqJgmrZrZLCC8BD9HFRi5vgqo8AlcH1UGWVNUCDzwxo8GH/ETDGWRtEZLm3RLhUyvyG2QJCweru37/dtI1IblcEXQEByjYqxfBouc8miGU0ZUeEF1XNvZw5wkvBLYK8lrpAGelwovFkLly7C3GH/u5x2HcBCS4BCRgMmnSy0y1U/FrM9LOJIf89FGVnNaJnAQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fbuFRNEwW7M6aie6V75aUXbLFdmY5/8AXVU6Nw+xMb8=;
 b=wStpUzfUgixU4PF2/3PsZoEGHtR4sRWbqBI4JjqAFNKNGCme4X8a0ls7oKTfoKmqW/5ZXWOHyJJ1TkF+TTNbawYvgbK8eVq7LUJGnaw7UwWkZy5bAhy2cHgKsT5rtfeyHn+LJn/Cfiivw34DBwz0c6UpvQQMT9SF5wj8/06mOeGRM8K5iz883sucJtH9hTOxnfSJliJTM4EHAGuSdSaGxbQKejd7O6zjQldza1trev4ucK26652j/1xs0Nq7QmWHklUHr7dZw2nrKpu/r2paxTiF031OByKunYIqdOjd8TCBpc5tcMLVlq/ALOHYJmkigM8owS36yqwcwNq1uZgD0Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fbuFRNEwW7M6aie6V75aUXbLFdmY5/8AXVU6Nw+xMb8=;
 b=aAFTtuF/l6Siwgt69II3yhnQVY6mwvssPp8iWzpAKdCwbHj8nMj+CpMj8IlIP3UACNjvvNud2Cina6oDnRzpWdDBWzkA8dIZ0KagY8f20GXVnAUINppcUQ8U4Al5nqf68V/doWUxTg9wRYIdjlDLtX6o380RwU+kwIswQdIID54=
Received: from CH2PR12MB4215.namprd12.prod.outlook.com (2603:10b6:610:ab::24)
 by CH3PR12MB8879.namprd12.prod.outlook.com (2603:10b6:610:171::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.35; Mon, 14 Jul
 2025 02:21:03 +0000
Received: from CH2PR12MB4215.namprd12.prod.outlook.com
 ([fe80::b053:488f:853d:892a]) by CH2PR12MB4215.namprd12.prod.outlook.com
 ([fe80::b053:488f:853d:892a%5]) with mapi id 15.20.8922.028; Mon, 14 Jul 2025
 02:21:03 +0000
From: "Chai, Thomas" <YiPeng.Chai@amd.com>
To: "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
CC: "Zhang, Hawking" <Hawking.Zhang@amd.com>, "Zhou1, Tao" <Tao.Zhou1@amd.com>
Subject: RE: [PATCH] drm/amdgpu: query the allocated vram address block info
Thread-Topic: [PATCH] drm/amdgpu: query the allocated vram address block info
Thread-Index: AQHb8WYaJOJoOIBw2E+PJjPKh/8uDLQw6PdQ
Date: Mon, 14 Jul 2025 02:21:03 +0000
Message-ID: <CH2PR12MB42153B299D236DEB2AFAB802FC54A@CH2PR12MB4215.namprd12.prod.outlook.com>
References: <20250710064355.670983-1-YiPeng.Chai@amd.com>
In-Reply-To: <20250710064355.670983-1-YiPeng.Chai@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=True;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2025-07-14T02:20:35.0000000Z;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution
 Only; MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=3;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH2PR12MB4215:EE_|CH3PR12MB8879:EE_
x-ms-office365-filtering-correlation-id: 36f26e2f-a04e-468d-7ee9-08ddc27d14de
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|366016|376014|7053199007|38070700018; 
x-microsoft-antispam-message-info: =?us-ascii?Q?YqxFaQkxp/T8qU1GoTtZ3zqKah9uniqYRlMZhsklQH1tGODKesEDeq7EnMQt?=
 =?us-ascii?Q?xJhDgjdKhYsgcbiEvJGioMjfu/wUlw99foarMwPmsMhgqn31qLAaXXrg4Brc?=
 =?us-ascii?Q?ieI1cFtxivA6PRB0PKdkiElYzJfprzARC3DQavBtseSyhLKnGwjw82gOvwlj?=
 =?us-ascii?Q?tSHjxexavh8eyDZbJq4kbf+sDh6d/c3gtmr8FDKwQpCcW3u8r14fJVtfb241?=
 =?us-ascii?Q?Dss6eCNC6K3DoAz55RGtdTzaNcQY7FFkLcyfgn6SyGh8C1q9UvyNSEJXIW3s?=
 =?us-ascii?Q?QI3WRqOV2tkOvha/jLKM9x9lSdxGIm2SfWakRpX1GUpsp11YWLr/apTi//Xt?=
 =?us-ascii?Q?4S1+lbbtM8/o39/CKE535a6pFK1HSklRHSpHODtQlmkBlpUbrWcDMt/bpuFN?=
 =?us-ascii?Q?aiauRL/p4mxJo/nzj+/SCEtP2vul2rala1/kGYlOlCoif6yGKIG9Aim1zzs+?=
 =?us-ascii?Q?pS5ycjSl1NRVIykq9BB4RThScSVxl7DlmrK5wJjyZ5xRsuY/agn7UINfdKNd?=
 =?us-ascii?Q?K1NFYlBOskpTQBJjSRMtb/GuvjQEY4xLzN2Ir4eu7a9vAE7IKi6ZWhPo461O?=
 =?us-ascii?Q?Pg2PBAAFggQfku+IWe5fjjDQc4mhaFtRyZDpkKhF5uksr4u+D13gID+e/qSl?=
 =?us-ascii?Q?lD9jxGvj0rQyBd3RQlw6L47JpqfaMudOHnTGdMDUEHqDwO9oV8icpEAbuqCx?=
 =?us-ascii?Q?U1opCqM6EbLWyWLOfjgDb15TyGud0c7hUdNTa+THliW+hb50bgJANVf1T3s5?=
 =?us-ascii?Q?Fj14jwrsTPGGTRSdb3zGktl23/KzcPRuWQLrT2S4pWWOkDkf+2nPbsbLNhxd?=
 =?us-ascii?Q?C+pb62O8lLdrCJNy7Yd1PsYlD9U9KXCTjjj6r2gFRm1hHuI4Tp5cB9TozYEo?=
 =?us-ascii?Q?StXe3g5zTq6LvwELIWVgS2ioSZxJE8SN74hPTBYgUjf5ca3tD+7dqF5xe36a?=
 =?us-ascii?Q?ledqoTHuiKFtCL1T8grrzzcmOJ/IedI8WzN7BtvbYBhY2KvOBOGB+I6hKFzX?=
 =?us-ascii?Q?Uq17foHBpteNdAQXIUgdFp6D1VS55HShScs2rArkBRHJMUXNXSKiNnDC08/5?=
 =?us-ascii?Q?iRCpqwHwUkqzGdPwfMGQmWQ+A1bJCw/EXi6cbh/mvCSEd9+bqV8HZehKFFsN?=
 =?us-ascii?Q?asjqCdpX8OWFtQjjIFHI461gBfueAsL9hv3QcUCSVdofpMXxDWvXe7Jp5ly1?=
 =?us-ascii?Q?U7x/TmCrYT27vsqDWGHRjSqqUmGrGSpGIUS/NxBYKrFqlMGa8Ik1ILT+JweW?=
 =?us-ascii?Q?4PZhFRMXWYVZKzXXEEakGOebo+6o3sSlEk10qrEf0HC9AuxRW3dQB9gYifXq?=
 =?us-ascii?Q?2CBGPGqqjpEPb70BSt6xOxKlQNjYkKJOLZmmLJ6u1wUqhYSTrq+bbGBOHImW?=
 =?us-ascii?Q?anKzbqIFZ5+kgY/2vbWmq1jLSQc8js02WrUdbltgjewbv24loNZrRZQSbhfa?=
 =?us-ascii?Q?kGFHfRZLCOCy5bp9GosJUOoeBBtj17hvEqVMLdZIH0PUR2zi5Fg47Q=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH2PR12MB4215.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(7053199007)(38070700018); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?cqKrlwlrX2UsXGxF3fntFeoaF9ElZ7QQnHryUef51LW+0SbnAt6d5OMwuP9w?=
 =?us-ascii?Q?U6US4oKElDW9FrQYlIr7sOKETC8PyAnWzFSMT0ZNo9ucuVWU6WnWaI6A9htQ?=
 =?us-ascii?Q?+4SR/m/dRPqrX3NW2SmcAZY17NwWASMqpWJ10x4HMyRBaqLba+AfJiGEFNor?=
 =?us-ascii?Q?X1P74FArHf2iLhr8o7s0O4dfEmkLdr+zzQ4Z/6vSQaiQizA+DU5/rzPjsUFi?=
 =?us-ascii?Q?gvUm4fFPXCqupmotIlTArrzsDGiN0jQVWSF7q4AuztJO2D28KjBiOXNTTR3q?=
 =?us-ascii?Q?3kl3jThj0vvhnx0AhXz6m0qJUL2gXTm16VpuXe1GTq19l1wsVOE58oxCno4S?=
 =?us-ascii?Q?RLzAzKdowOfP5NSnrjEx3zgBUwSUYSJ8oW5uy0F2zq335LIbvsyx3UYDKqhQ?=
 =?us-ascii?Q?QDVcHaNmWHSF6+ZVAff/+0YNnRzDVuZC0k31n9HiB8VrJNq7MruM//ooNLsb?=
 =?us-ascii?Q?NcXI8412PA1S+onOTua8qBPdd2jatYsoFzLnoXPHf/q/8rJIsBANZuwxfvLY?=
 =?us-ascii?Q?0LbQXR8fGOeM18W7HdaB81djkJW9/qBAvRfdDDI+/jXKWPKa6nAIdHdxMG72?=
 =?us-ascii?Q?nz8+KMawEDGXChjCvbcU+xYpkNB9Wn23C10KGKCLXsvJRZObPvmMMfyVmlIB?=
 =?us-ascii?Q?lJdi1+jsF/DtsMkFrKDij7pKjscY5NXfgnm3AWnM3LKDk0R46Z0Nwc+YWWFa?=
 =?us-ascii?Q?xtWdpckpwqHt0R2tpMEhWvQ4wvkIgCUaF8Wk7bPiYSWfm0EgF3WM3FbskCHP?=
 =?us-ascii?Q?K8k72S3I8nFHkcu50FkCgr1XjBFER9nCvs3snmD7S70+nfDnMKmOsy+P0N5y?=
 =?us-ascii?Q?yb+ZuHcwKiTFweT6o/i2rSOD00wXHY/CV2vRyJRvPc/huhE2lk+Dfhq4sxlx?=
 =?us-ascii?Q?7PHWf5BvUIq6Loe67qqRNYxyv5eiknN0UhBLXkKAPDWkonLubcp/bfJSyS10?=
 =?us-ascii?Q?Y6+EUS7BulaLrub7oZeNSCGvdYv/OWHtbtfKt8o6psXkwmxV8UJ7FmXGY2wx?=
 =?us-ascii?Q?1Jbi4JLWrvI54O+u2QBTk79a6jNX4KYKds4pv3h7RCYxCCkrNr7upoFS2kZQ?=
 =?us-ascii?Q?/WI9+uSL4bEXg1qxwF8uJxV+7w5GBhUmd4p7RJL4uzs3Tbjcyx3LFAGrbVXx?=
 =?us-ascii?Q?K7xadGo9uOVPIiHfT2YlmOQ9txFOa/gmm4m4lpfhlZ37R9RILs242fmAliqz?=
 =?us-ascii?Q?ampPHGMIeqZpYSkLkIHXwZJIJkEI7QmpUXtnn47J1rhfkwaltDsJc61gJT7K?=
 =?us-ascii?Q?Cm9yYfYgPja+kJAFm7l0JlJMgxfdVixCVv/+NsVcj74Xj1Eb67uv+4mVUG6b?=
 =?us-ascii?Q?4UdawRAGVPeJiHgG+bb++wL2NVtheuIjo9DDPPVakhyz3z3Y/pFWR2wlzyDX?=
 =?us-ascii?Q?GDTuQtUW7xsRQGqhWmB6pJo5k+D/gcPFJWaUSdWjgAC6bugn7aYDCyXDDgwr?=
 =?us-ascii?Q?CngjXr/CucNspR4f3l3wxFYsTlMt8U8nWG5six9Ilo970GsMP/CiKgzUfKHg?=
 =?us-ascii?Q?bWlKE95HvfVSh9oT1P86cZYqKtsHAJ9x5xaRDJlYUD0Bm5lTyAjNQxs1hEtF?=
 =?us-ascii?Q?MVvFCUf2lxOuwndcQn8=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH2PR12MB4215.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 36f26e2f-a04e-468d-7ee9-08ddc27d14de
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Jul 2025 02:21:03.2781 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: PWPu85wR1wWyt1fWGeuxRjbYaXZjNmPDRjZUjm1jgWlERe6uQ+ClPBWHn/E8RkE+wDYf8tBt4buanL3hWazNaw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8879
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

Ping.....

-----Original Message-----
From: Chai, Thomas <YiPeng.Chai@amd.com>
Sent: Thursday, July 10, 2025 2:44 PM
To: amd-gfx@lists.freedesktop.org
Cc: Chai, Thomas <YiPeng.Chai@amd.com>; Zhang, Hawking <Hawking.Zhang@amd.c=
om>; Zhou1, Tao <Tao.Zhou1@amd.com>; Chai, Thomas <YiPeng.Chai@amd.com>
Subject: [PATCH] drm/amdgpu: query the allocated vram address block info

The bad pages that need to be retired are not all allocated in the same poi=
son consumption process, so an interface is needed to query the processes t=
hat allocate the bad pages.
By killing all the processes that allocate the bad pages, the bad pages can=
 be reserved immediately.

Signed-off-by: YiPeng Chai <YiPeng.Chai@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_vram_mgr.c | 38 ++++++++++++++++++++  dr=
ivers/gpu/drm/amd/amdgpu/amdgpu_vram_mgr.h | 17 +++++++++
 2 files changed, 55 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vram_mgr.c b/drivers/gpu/drm=
/amd/amdgpu/amdgpu_vram_mgr.c
index abdc52b0895a..4bf3e99f47fe 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vram_mgr.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vram_mgr.c
@@ -396,6 +396,35 @@ int amdgpu_vram_mgr_query_page_status(struct amdgpu_vr=
am_mgr *mgr,
        return ret;
 }

+int amdgpu_vram_mgr_query_address_block_info(struct amdgpu_vram_mgr *mgr,
+                       uint64_t address, struct amdgpu_vram_block_info *in=
fo) {
+       struct amdgpu_vram_mgr_resource *vres;
+       struct drm_buddy_block *block;
+       u64 start, size;
+       int ret =3D -ENOENT;
+
+       mutex_lock(&mgr->lock);
+       list_for_each_entry(vres, &mgr->allocated_vres_list, vres_node) {
+               list_for_each_entry(block, &vres->blocks, link) {
+                       start =3D amdgpu_vram_mgr_block_start(block);
+                       size =3D amdgpu_vram_mgr_block_size(block);
+                       if ((start <=3D address) && (address < (start + siz=
e))) {
+                               info->start =3D start;
+                               info->size =3D size;
+                               memcpy(&info->task, &vres->task, sizeof(vre=
s->task));
+                               ret =3D 0;
+                               goto out;
+                       }
+               }
+       }
+
+out:
+       mutex_unlock(&mgr->lock);
+
+       return ret;
+}
+
 static void amdgpu_dummy_vram_mgr_debug(struct ttm_resource_manager *man,
                                  struct drm_printer *printer)
 {
@@ -568,6 +597,10 @@ static int amdgpu_vram_mgr_new(struct ttm_resource_man=
ager *man,
                        remaining_size -=3D size;
        }

+       vres->task.pid =3D task_pid_nr(current);
+       get_task_comm(vres->task.comm, current);
+       list_add_tail(&vres->vres_node, &mgr->allocated_vres_list);
+
        if (bo->flags & AMDGPU_GEM_CREATE_VRAM_CONTIGUOUS && adjust_dcc_siz=
e) {
                struct drm_buddy_block *dcc_block;
                unsigned long dcc_start;
@@ -645,6 +678,10 @@ static void amdgpu_vram_mgr_del(struct ttm_resource_ma=
nager *man,
        uint64_t vis_usage =3D 0;

        mutex_lock(&mgr->lock);
+
+       list_del(&vres->vres_node);
+       memset(&vres->task, 0, sizeof(vres->task));
+
        list_for_each_entry(block, &vres->blocks, link)
                vis_usage +=3D amdgpu_vram_mgr_vis_size(adev, block);

@@ -917,6 +954,7 @@ int amdgpu_vram_mgr_init(struct amdgpu_device *adev)
        mutex_init(&mgr->lock);
        INIT_LIST_HEAD(&mgr->reservations_pending);
        INIT_LIST_HEAD(&mgr->reserved_pages);
+       INIT_LIST_HEAD(&mgr->allocated_vres_list);
        mgr->default_page_size =3D PAGE_SIZE;

        if (!adev->gmc.is_app_apu) {
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vram_mgr.h b/drivers/gpu/drm=
/amd/amdgpu/amdgpu_vram_mgr.h
index b256cbc2bc27..f5ac0eeb092c 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vram_mgr.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vram_mgr.h
@@ -35,12 +35,26 @@ struct amdgpu_vram_mgr {
        struct list_head reserved_pages;
        atomic64_t vis_usage;
        u64 default_page_size;
+       struct list_head allocated_vres_list;
+};
+
+struct amdgpu_vres_task {
+       pid_t pid;
+       char  comm[TASK_COMM_LEN];
+};
+
+struct amdgpu_vram_block_info {
+       u64 start;
+       u64 size;
+       struct amdgpu_vres_task task;
 };

 struct amdgpu_vram_mgr_resource {
        struct ttm_resource base;
        struct list_head blocks;
        unsigned long flags;
+       struct list_head vres_node;
+       struct amdgpu_vres_task task;
 };

 static inline u64 amdgpu_vram_mgr_block_start(struct drm_buddy_block *bloc=
k) @@ -69,4 +83,7 @@ static inline void amdgpu_vram_mgr_set_cleared(struct =
ttm_resource *res)
        to_amdgpu_vram_mgr_resource(res)->flags |=3D DRM_BUDDY_CLEARED;  }

+int amdgpu_vram_mgr_query_address_block_info(struct amdgpu_vram_mgr *mgr,
+               uint64_t address, struct amdgpu_vram_block_info *info);
+
 #endif
--
2.34.1

