Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 64963C9830E
	for <amd-gfx@archiver.kernel.org>; Fri, 25 Sep 2026 18:27:31 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E2E4E10E211;
	Fri, 25 Sep 2026 18:27:30 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="ewaCgctw";
	dkim-atps=neutral
Received: from MW6PR02CU001.outbound.protection.outlook.com
 (mail-westus2azon11012051.outbound.protection.outlook.com [52.101.48.51])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 19ED110E211
 for <amd-gfx@lists.freedesktop.org>; Fri, 25 Sep 2026 18:27:30 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WIxfBaEnHrbeT8wRPdBPF/+NFtmd6MONJF/Z+opfnqpuSMfDhQwE5zUDJtUCqUboclqjuJcL0dfP2q7PZwoeAwO6LitOSW++xJ7fj/QoopRs8wlt9BRCRTpQhDZPu0xK006+CD/l7baFf7y5EMFxgOMCidlku4b4fNlI/E3P+T39V+ZyEN6ynMl5H/nm8G09nj2V8Q5ORyu6KnzI6c35tBZ/g8f2tGTjeXnQT3Il5fikM+3wSol5lsKjfxOWwAHef7lRhmi6VKDfRmPtzDDl1fzCj5cPh0iGiZsKKVfQdDSZbRPjpTwHx30I198cQ7TS5yT8PSzUL7WC+Kf4Va+Vmg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tdw3u53k35AtrGTHqXblFFeYKRyrIphAXLmbxOcERDg=;
 b=MeMRSSL9NGGBD/GIU8E1qmaCIZrCQxj5f/PlokPYBbC9+EYCPZiL0UlF5Jp7p0L+MBgcNwYHnSLWC6+xoEcWdQc1cKd5U5WSvTpGtAumpNzgkJFlMWvMXloNUiWplQ5jGwXG8D3REwPSNTRGLkh2w17DJGGEBUUhwkdOqf+zRtH7niO8R6UWW7d3d/EJaS+Zjgs5HlOH/cq4YZiHa60kvZrQYinlZvpXgfMJtm3O2OqcmzjDnLXUZsQsKWk5ZfefLgh7nBxdq/uDKrvdYWC3OHUVXFIrGycL4EIj2k+sUms+EHDiGEqm8iIBEeK1Fex4M/lD8fFfegdQ02nIk/R6EQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tdw3u53k35AtrGTHqXblFFeYKRyrIphAXLmbxOcERDg=;
 b=ewaCgctwUky2DqMkQWMG4bQhjhtyEZA+mIZzOISjgX/1ydk52KuelWX1LbPxYUTJKyUNPEdjaGdUT2Nawc3it3SXylW3RJaiwDnq4cxk/TE3G5P6r8Yx2gkjkyTOtARib6w7zFdQz2ssLGl71nuX8Ny0Jo3f+hmHGmsr7HWBYIU=
Received: from CY3PR12MB9631.namprd12.prod.outlook.com (2603:10b6:930:ff::6)
 by CYXPR12MB9426.namprd12.prod.outlook.com (2603:10b6:930:e3::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.19; Fri, 25 Sep
 2026 18:27:24 +0000
Received: from CY3PR12MB9631.namprd12.prod.outlook.com
 ([fe80::3595:9a8c:8f99:4e55]) by CY3PR12MB9631.namprd12.prod.outlook.com
 ([fe80::3595:9a8c:8f99:4e55%4]) with mapi id 15.21.0451.014; Fri, 25 Sep 2026
 18:27:24 +0000
From: "Liu, Shaoyun" <Shaoyun.Liu@amd.com>
To: "Sun, Yongqiang" <Yongqiang.Sun@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH 1/3] drm/amdgpu: update MES v11/v12 API for mes_dbgext
Thread-Topic: [PATCH 1/3] drm/amdgpu: update MES v11/v12 API for mes_dbgext
Thread-Index: AQHdS5BgYF9aKHGnNE+t00HLxLhEBrbfn8Uw
Date: Fri, 25 Sep 2026 18:27:24 +0000
Message-ID: <CY3PR12MB9631039CF4A3F1EC526E790BF4802@CY3PR12MB9631.namprd12.prod.outlook.com>
References: <20260923191842.976419-1-Yongqiang.Sun@amd.com>
In-Reply-To: <20260923191842.976419-1-Yongqiang.Sun@amd.com>
Accept-Language: en-CA, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Enabled=True;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SetDate=2026-09-25T18:26:58.0000000Z;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Name=AMD General
 v26; MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_ContentBits=3;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Method=Standard
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CY3PR12MB9631:EE_|CYXPR12MB9426:EE_
x-ms-office365-filtering-correlation-id: a2435839-069e-4b34-8c6d-08df1b32a531
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|23010399003|376014|366016|1800799024|56012099006|11063799006|10067099003|6133799003|22082099003|18002099003|38070700021;
x-microsoft-antispam-message-info: IN00PwIIq9v0ruz8MZFSrZdTAjUNyySe+iwZh+1DDEh6I86KNgvUikoNp/O1nV7iERYw8jyLAU8nCPq5ngCmfo8fRpbY9+KCagwLX8iX3n8MgTaoPZJghBFJ6clE+deqSZvHiU4frEtmlt42voat+fucQKqFLyllzr12021ji/7nNyMumjjT/qoOTN/ICQhhZHC643tZtv1E3tvLODhZIwauOxG2buiu00waUAZJe4TlvVdhsuzEm8v+1FFiXoewSGukre8zlT2hSeiwA68FkipsnWcRamRCSXNSP9Zt7QyGbJOuIV+qmA5N3t3RwfvOiH5pK6WXziGubPTeXeXFm0wXTtsa+9+ZG8ZsKq+zbNt+Y8Cg8c0p1m5kqpl1DHppADwM2CNjy2OJrnsc2Wuv/EUTchZq40qeoOnEHWqemEgjU2iydE99sI21qtFeqBXrI0ssFFMv2GcFg0I9o21K8uxfLi0ctYeHDA7w3RGgK/M/zYr6plAMldk8/9XCsKksbym8sqBOEZWnO0++3PA5vcmOn8AYK5lLZLA4mx4b28bgKL/pMZA3QKBSnOBYGEihYhhOaE7W0rVOLhd1PXe1WZsmEAtwhModg7/ZEe9dVWTmOhEJkmAcF96Ylg+OCwGdRyi+DDITeI8HujnGeYnPhHXagKiw7kp4HunYb+i/g2C40+vpZBNxOTugVVeW2Mgh+ETIsjaJLI8dgcfT51IpWTcoY5Z1NOmpcJDgRUYeDCw=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CY3PR12MB9631.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(376014)(366016)(1800799024)(56012099006)(11063799006)(10067099003)(6133799003)(22082099003)(18002099003)(38070700021);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?g8b+dwk3ThYPC4GiJ5/6S+OfzNHboBqgtMut1sQR9ali8U4+raVLKoVaZVzw?=
 =?us-ascii?Q?+neCFXn/gMBUrjVgv5gJ76rIERM8zArMSK8n5LYn5jj9UEDzMXaPlL1t5E42?=
 =?us-ascii?Q?xRqKAuOJyPDUAehSkSYDmRIGEt09pgYJOUskEZWonl/euuk6Kb6eMtBybWWx?=
 =?us-ascii?Q?kEurzLv12/Svz0xLzhSt+MJ0jfcHgjc5oqB2Lpe6mS83Is0zUrfqImjE14nX?=
 =?us-ascii?Q?ugiDv006S5frjkSIQopvd/dwF6jWkkWWrtrLD2zMak0ZbkZEthg39l/COMpW?=
 =?us-ascii?Q?6xL/xF0lOVpY0U6tfwcaYOn0bcQO3R6NCZ1ECv2+bJ3xjKe2Z7q5yRH/bd82?=
 =?us-ascii?Q?jX3+PMcksbEqrU2nUBDysLOWh7XoDdXjA0JL1f7P9mfFvYI5mXVBDqWH+/x1?=
 =?us-ascii?Q?dr7IsyurZRvF85SM7F38Je1OADadD07Ud+R9XTCkYQ/B6yIOkPXxXBWmePZf?=
 =?us-ascii?Q?EU8bPMSn7svyp8IoCYdooZxbZMmou2pfagKbUtjrR7vYoJyKRQ388dxav7P+?=
 =?us-ascii?Q?g9t4SW+tcTSiR96rDZCrA64BrJPz9Ka6h+nvzuZ7u6ljf+LVuHCqniM4utHE?=
 =?us-ascii?Q?RxiFRo7iUt/netOMMgfzKDuBEQFz907TKpmJKq4hJIet2F0S6MOHmwbPMjpZ?=
 =?us-ascii?Q?fKHg+SfmCX98qeXfw3VHCg5h6ml472ZzOAa+Lc+lRI0fi1dPfJF8IIXDKLQB?=
 =?us-ascii?Q?kI7jcw7N5papdTzJnNKg6gUASpGEZR263vxTwHUWPuGjd6TfOxdTn9J1Qr5Z?=
 =?us-ascii?Q?5DXljgU6XE59PUcGzKrhM86yXzOowZCVArfKgTmeyvvmsDrocQc1RgBwvnZT?=
 =?us-ascii?Q?O2Y5CTqPdcgxzx+eCCdYLym/FKH4ux2tNMUCH0lh1T8+vFe/9ewkVV8Pfa4a?=
 =?us-ascii?Q?QebDYwpTTHDRCNYidpghj55LeL3DK7LRD+8nH6Pl9Z/0pWxBnP0HZrFapfa1?=
 =?us-ascii?Q?6TAVhqvEKg9Rp92337V/GmxyYDDDQcXt6IT47kFuzcImhJfYxXFs14Wmkeqx?=
 =?us-ascii?Q?Hqo7ulsQo7IXWtB4Gy5EJzi8lPOIQvtJG4+PoFA+IIsGjW6bTZ5GR5SgWXeg?=
 =?us-ascii?Q?hHOrUIKp08nD9izhiNiokycdkTIsZoIEY4IzM/LvRVeGcUP+O6Hj/DHZph6B?=
 =?us-ascii?Q?JoiiSIVN+/Y++KpCyxVrIJCC+rhDuCuvcRkqusO4x6TRafF62z0WZ5OTfzPF?=
 =?us-ascii?Q?V+Us7cdhqQYGPQLrucuknR/DB3+3iyfsCObsP1VNziVinf8LAg4szXUd7AyX?=
 =?us-ascii?Q?ZLbPRFdJYk57uvhuZPjFWX+E/rUA6+mhWB00Dsd0zaZMJlEoFvxfGYPr9m/4?=
 =?us-ascii?Q?60RMG+nRGW/t08x2foP0ZDbS0pq/cxkZF0XiwjrEPaD//Xzb1ESJFetk9MJG?=
 =?us-ascii?Q?0AzYHt1zFwHzPXzvFt8aDe/wO1+tgnXgjI8fMBefltpJXXTSnfw5bh1e6Ezm?=
 =?us-ascii?Q?eVuPgf5FME3vKXTUEDdq9g5LKUKhRiBLSb3wITV39VFA8tRoTqqdkf7l6JB7?=
 =?us-ascii?Q?mbdeRY9LGlQwZhx3uFvw1uPXVjRMUbKm7I0MSn3J8jTW7G43urRQmh4oH78H?=
 =?us-ascii?Q?2sJB2BTTx8yp3zRjemjvPt6oqn2SfWUCrK2jBdAR7Eut8APORF7HNIyA9bVV?=
 =?us-ascii?Q?M21Jt33cQZRivTeSMQjnJzXbmFtVU0Fd/ltXAmCdl/WsikT73uTHIyGbFIj7?=
 =?us-ascii?Q?UWRTeXPwrbXoDdKjohFiWg6zz8Noe87wSIxkkyGWkCZu+hdW?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY3PR12MB9631.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a2435839-069e-4b34-8c6d-08df1b32a531
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Sep 2026 18:27:24.3410 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: L5TsXMkj4COaxYUqJzvwvU45Bs0KV6AZARRyvmPz+/9mJo7bRYJFua0Lg/Cskgk26MZQNajPRanLCeLnbMhjRg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYXPR12MB9426
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

Looks ok to me .  You can add me as RB .

Regards
Shaoyun.liu

-----Original Message-----
From: Sun, Yongqiang <Yongqiang.Sun@amd.com>
Sent: Wednesday, September 23, 2026 3:19 PM
To: amd-gfx@lists.freedesktop.org
Cc: Liu, Shaoyun <Shaoyun.Liu@amd.com>; Sun, Yongqiang <Yongqiang.Sun@amd.c=
om>
Subject: [PATCH 1/3] drm/amdgpu: update MES v11/v12 API for mes_dbgext

Add the MES firmware debug-extension ("mes_dbgext") API definitions to the =
shared MES v11 and v12 interface headers: the MESAPI_MISC__SETUP_MES_DBGEXT=
 misc opcode, the MES_DBGEXT_INIT_DATA struct (log buffer MC address + opti=
on bits), and the corresponding dbgext_init_data member of union MESAPI__MI=
SC.

These describe the SETUP_MES_DBGEXT packet the firmware expects and are con=
sumed by the per-IP mes_dbgext wiring for gfx11 and gfx12.

Signed-off-by: Yongqiang Sun <Yongqiang.Sun@amd.com>
---
 drivers/gpu/drm/amd/include/mes_v11_api_def.h | 18 ++++++++++++++++++  dri=
vers/gpu/drm/amd/include/mes_v12_api_def.h | 17 +++++++++++++++++
 2 files changed, 35 insertions(+)

diff --git a/drivers/gpu/drm/amd/include/mes_v11_api_def.h b/drivers/gpu/dr=
m/amd/include/mes_v11_api_def.h
index a8e6ccc7817c..e251ccc41f9c 100644
--- a/drivers/gpu/drm/amd/include/mes_v11_api_def.h
+++ b/drivers/gpu/drm/amd/include/mes_v11_api_def.h
@@ -622,6 +622,7 @@ enum MESAPI_MISC_OPCODE {
        MESAPI_MISC__NOTIFY_TO_UNMAP_PROCESSES,
        MESAPI_MISC__CHANGE_CONFIG,
        MESAPI_MISC__LAUNCH_CLEANER_SHADER,
+       MESAPI_MISC__SETUP_MES_DBGEXT,

        MESAPI_MISC__MAX,
 };
@@ -702,6 +703,22 @@ struct CHANGE_CONFIG {
        } tdr_config;
 };

+/*
+ * MES firmware debug extension ("mes_dbgext"): the driver hands the
+MES a
+ * GART/GTT log buffer; the MES firmware writes text/binary log items
+into a
+ * circular, zone-partitioned buffer that the driver drains and prints.
+ */
+struct MES_DBGEXT_INIT_DATA {
+       uint64_t dbg_ext_mc_addr;
+       union {
+               struct {
+                       uint64_t trigger_interrupt_per_new_msg : 1;
+                       uint64_t reserved : 63;
+               };
+               uint64_t u64_all;
+       };
+};
+
 union MESAPI__MISC {
        struct {
                union MES_API_HEADER    header;
@@ -717,6 +734,7 @@ union MESAPI__MISC {
                        struct          SET_SHADER_DEBUGGER set_shader_debu=
gger;
                        enum MES_AMD_PRIORITY_LEVEL queue_sch_level;
                        struct          CHANGE_CONFIG change_config;
+                       struct          MES_DBGEXT_INIT_DATA dbgext_init_da=
ta;

                        uint32_t        data[MISC_DATA_MAX_SIZE_IN_DWORDS];
                };
diff --git a/drivers/gpu/drm/amd/include/mes_v12_api_def.h b/drivers/gpu/dr=
m/amd/include/mes_v12_api_def.h
index cb7ebdfffeeb..3e214cb4f6e1 100644
--- a/drivers/gpu/drm/amd/include/mes_v12_api_def.h
+++ b/drivers/gpu/drm/amd/include/mes_v12_api_def.h
@@ -839,6 +839,22 @@ struct CHANGE_CONFIG {
        } tdr_config;
 };

+/*
+ * MES firmware debug extension ("mes_dbgext"): the driver hands the
+MES a
+ * GART/GTT log buffer; the MES firmware writes text/binary log items
+into a
+ * circular, zone-partitioned buffer that the driver drains and prints.
+ */
+struct MES_DBGEXT_INIT_DATA {
+       uint64_t dbg_ext_mc_addr;
+       union {
+               struct {
+                       uint64_t trigger_interrupt_per_new_msg : 1;
+                       uint64_t reserved : 63;
+               };
+               uint64_t u64_all;
+       };
+};
+
 union MESAPI__MISC {
        struct {
                union MES_API_HEADER    header;
@@ -853,6 +869,7 @@ union MESAPI__MISC {
                        struct SET_SHADER_DEBUGGER set_shader_debugger;
                        enum MES_AMD_PRIORITY_LEVEL queue_sch_level;
                        struct CHANGE_CONFIG change_config;
+                       struct MES_DBGEXT_INIT_DATA dbgext_init_data;
                        uint32_t data[MISC_DATA_MAX_SIZE_IN_DWORDS];
                };
                uint64_t                timestamp;
--
2.43.0

