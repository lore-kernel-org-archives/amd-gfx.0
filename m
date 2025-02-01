Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C3342C0218A
	for <amd-gfx@archiver.kernel.org>; Sat,  1 Feb 2025 03:36:56 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3AB1210E062;
	Sat,  1 Feb 2025 03:36:56 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="lDVklg4m";
	dkim-atps=neutral
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2053.outbound.protection.outlook.com [40.107.92.53])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9C70410E062
 for <amd-gfx@lists.freedesktop.org>; Sat,  1 Feb 2025 03:36:54 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=reoo0n5fHoFn7fUvdeXwMu3Ov2Xe8UTM1p1GXS6W1Zub9Kru3YOA+akgS9CF/Fvs6+29lhvPnYH17SZmHn76XrllAZFkg0erFd38HlsA0y7XCPpx68J6BuPxhYm9/WNmYzGrpVqTiVi2XDM19tCR+Dlx8ZqAuvFebTSuTjDwDia3lahGnynD5v/JwcgsxGkjpppFhNgXGQnx/XAJO4JVWV0Eqy66qXaYbcIBP1YZYRGxfG2ruJYM0ka0hZAz272hYLnviKKn1gTnk/edgQtQsPqDYBJOiIh/17kwyC1T7VdE0v/2Gi32Y2p9GfqgM1uuT47Ossj+FCxU3g76PRgwog==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HdiK4EuQcYGzzlu/HvDtoV6Zb8x248Tqm0NCtoUIabg=;
 b=GDMaz+debZk28k0x1meLe653lNgeJvkyb62RgX7k3v8AScnWKP80vUdf/iwRFHeiBDYj4qdBLKUQ1Ll0MAbB+ykiTA6TvT78ahuBjUDb3QdiTcy97xCKMkp7jPoWMNsmT5sdEBhXXiMEB3WhZYg3qvLujNJ8j8IEdRblSUtZRkLQhFI3Q3+yZurzklxlcd/lG6dtVxKDhgqWAjndUsw0Q+rcCYN2lVsrtUfP2ZC5g+IGkBuyOZcQbHJYjbSCNvbnyy0YLtouKwVpqpJzKmkPft02BU1jo5W/2C0DlnAjOVhwmGOcsoIAbiYQDpVZvxEtLj7DQhWZbWhVhtFPj4WmIA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HdiK4EuQcYGzzlu/HvDtoV6Zb8x248Tqm0NCtoUIabg=;
 b=lDVklg4ml9WHcjwlw8v0YdW3K01kU3V7rNs7e4Z6BQE9sWq3pMmqc4bopz4TKdw/81VvbiENZq5OHFVN9gTcGdmnYzJ6L2VxxzmDX1L4pnpCkBM94Ew+lqz+b+h4/s16ANF9dgeS8cwn3Vj9mXFa/kHGPn5lsB8ceFoWFGCZVAc=
Received: from CH0PR12MB5372.namprd12.prod.outlook.com (2603:10b6:610:d7::10)
 by BL4PR12MB9482.namprd12.prod.outlook.com (2603:10b6:208:58d::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8398.21; Sat, 1 Feb
 2025 03:36:51 +0000
Received: from CH0PR12MB5372.namprd12.prod.outlook.com
 ([fe80::fec0:2b36:85c1:fc9b]) by CH0PR12MB5372.namprd12.prod.outlook.com
 ([fe80::fec0:2b36:85c1:fc9b%4]) with mapi id 15.20.8398.020; Sat, 1 Feb 2025
 03:36:50 +0000
From: "Liu, Shaoyun" <Shaoyun.Liu@amd.com>
To: "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amd : Update MES API header file for v11 & v12
Thread-Topic: [PATCH] drm/amd : Update MES API header file for v11 & v12
Thread-Index: AQHbdFplCWbLtUfeEEyo5Xkw0NOKkLMxzDOQ
Date: Sat, 1 Feb 2025 03:36:50 +0000
Message-ID: <CH0PR12MB5372C2160B86A032406A15B4F4EB2@CH0PR12MB5372.namprd12.prod.outlook.com>
References: <20250201033505.3020-1-shaoyun.liu@amd.com>
In-Reply-To: <20250201033505.3020-1-shaoyun.liu@amd.com>
Accept-Language: en-CA, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ActionId=4fb81d50-941e-426b-b1f3-0ef1517b716b;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=0;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=true;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution Only;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2025-02-01T03:36:18Z;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH0PR12MB5372:EE_|BL4PR12MB9482:EE_
x-ms-office365-filtering-correlation-id: 684fc6d3-8419-425a-4ead-08dd4271a9da
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|376014|366016|38070700018|7053199007; 
x-microsoft-antispam-message-info: =?us-ascii?Q?6A8V5ULti9/rK/wG0BQGihUQ/IbgS4nMXuZwwk3aeLD9H8nEkE3gXMehg9gU?=
 =?us-ascii?Q?SRjfFTkC0ETX5mvRKN+7ooJnbLi+JmLqjXjfQgw5KayARAn8ulH9tPR64BS2?=
 =?us-ascii?Q?B4RlYqyS3E/xx0KzI+F8I+6kMptTrV4n8ew/gytxmeH/aaRayqd77DcnjK+o?=
 =?us-ascii?Q?O6nwbqTIfqWSgwW+IUhwUy/M4wwrHbbrR72UMEoPpDl+6jOA44NJsxY/VR2p?=
 =?us-ascii?Q?CoLSMULzL5MWAavGhY4Yfold20lEwWvFggiZNTqTnmxX31rxl8tt8FqA8qYY?=
 =?us-ascii?Q?UlQwQeu1Lv+88JCxcp1w42dhf7E//+2M8Y6QJdAK1Lh3ALYtZzcsJPwnIfPN?=
 =?us-ascii?Q?rmsOTEy5hEcNHHvhTlwTCH9yYF5fZlE6zK3tLBxW9BzEWdyJM12g1lqc3uI5?=
 =?us-ascii?Q?R91PV4tIoKkCIC7wPdiUlRXOXBEsRCyQLNX+RvZYhoMwm9S7+/UMCsFsukiZ?=
 =?us-ascii?Q?ASdWRAROOn2bHfe1z447TGFMRvoFE6sohCbpLyk0zGb3inSdXoZkyAiiCFxq?=
 =?us-ascii?Q?vScAQB2rLRAqd5YHays62fyt28FUEeDaXN9I/le1Ie386Vwy/VjOz03Cpboh?=
 =?us-ascii?Q?DfzzBKqaL/+q3wT57xENlUcnlpQIqiKgmSwyzv8xmMNe3nkL23o/ivozIWwS?=
 =?us-ascii?Q?6llCH7rLRFtOtrI/m5qm0gePHnFSCA9bPj+BN3+83Zg3rMP4J9gu6LypxLHG?=
 =?us-ascii?Q?vIsaUHFY/YTAavSEOKGS1IgMmBVjo73WUBLlL4Xt6j73Ge+bDuMKpbvyHTeG?=
 =?us-ascii?Q?6JsZDWKkDyc2vWzCO5nDbJqejMxqjLyPFYz9cbpWryfCUOLMdL1HWbVjvEsd?=
 =?us-ascii?Q?FQGccUyOIdMkS37GwPorBulaw9UnhtqGK3A23B+IIxYCFAbmgNcFKgWvQPud?=
 =?us-ascii?Q?k9ApEi11ODUaZIHr43u6cY4EVwXP2FVUUwmZMgLeLihA+yKeMTQmftegIjSY?=
 =?us-ascii?Q?OZZ2O2ApO6A7SSaFbW1UIxwVVWVBHWrh+ytuib10qviT9YtDWdvUF5p9AUBc?=
 =?us-ascii?Q?aIMnTHVJOpLznHW8h9UdXBlWRJ1/C4RNh5E3GnEarfEMTl9SMdlGxkB1Stai?=
 =?us-ascii?Q?lesW2vmip0+OrNC4GaE3FayjlEsmBG1vvu69wBq9lITiD7m2e67ey+/7T0vs?=
 =?us-ascii?Q?k0Ucb4w/CrlLXM8srKkbrfUoAzVLnyJ99f0NVZOhmPteu27ywJElcy+6ezpU?=
 =?us-ascii?Q?wzfndnkoXyZSsthixQYTDGVQCvRJbgYTnoqqyfbACFHf/SE++Ag28D3VYDDY?=
 =?us-ascii?Q?xf8Ypc4eCNZ6hR6zBexo4GjN0NL5fE6eNLk4ibeoLg8wZFPjIvXNrHpYCDg1?=
 =?us-ascii?Q?bSd6BAqFmG4460EwJRGiPuGMlPPDnTREwdvh0ZnXigUzplhQ0xGrAmSUZtYE?=
 =?us-ascii?Q?OtwJl6dAGPzsSGPkvZbrj8Q/0/jfEyvjJyEzaXomm/64z0dNpHG0ZR4oVJsk?=
 =?us-ascii?Q?gE7SZpXYz+FwiCvK8cm/D5NCD9Am6aX6?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH0PR12MB5372.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(38070700018)(7053199007); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?CTHUtQlaW9efteq29uqbh9xxd1zUdOYEFHAO8d+8Gd2FC5v0o9y9ebEiQjr5?=
 =?us-ascii?Q?GcyoR2kJrnSb4qJ2l/gaNVXulmlDyyvNKBDK5TBSbAUcvxTJxKZSBDXIqMU+?=
 =?us-ascii?Q?zVszybyn43dzm50SL3ZtkKL6bX/RRPzc5lARdz1azg3Eu7ObmL0LKIoIIMet?=
 =?us-ascii?Q?onkAKuo8vX8qbE7oyMkVYmd8rnm6pplDFjDCpLXOrUbE5ZJT63jHFMEBmgH9?=
 =?us-ascii?Q?K6ME1AisXsKhVSMJZyas0Y+u88jeBhVYqhV9bhWIy66cNtpUqqbJjf1FWUVT?=
 =?us-ascii?Q?Xb7tDVsEpsLCSXIzT/pkQF0f9Xc7ZeygDR0+K7ZNlU1NIxjUAuQivKsrvxaW?=
 =?us-ascii?Q?sq+r/qiphjh7wooiT2wqd+rEmxGlafN1J38tNNDcKLGLUdiikyiZkHFjT0OE?=
 =?us-ascii?Q?KPbfi1GSbE1YtH+fOTyH0RTR+l3pkUp/AgV6ddWthp5EvOPtICNEwARop63p?=
 =?us-ascii?Q?SkqL54i8QA8sEfAg7nqkdUEC9wGV+yyeTZGz6nBMImmWsD6rrVxL7DYKW+OU?=
 =?us-ascii?Q?jvxmscEEs/WyzDDMIq3oZIzNBF0K9GwvuWct9mBf74tYWO6DIWQ+t48yUZbX?=
 =?us-ascii?Q?JiH9jer0oDk5ys35su2dcUB0F+Ni/eCbp7Fh9U/uyudStk/dRF7hGIIHnQfK?=
 =?us-ascii?Q?kaPALxQ1ogWwBbI17TC3l8NElBp1I2RGgZ7n10N7UYqxjoXi0Ux/6E1ErQQf?=
 =?us-ascii?Q?MJzeUqciz0iDhX6gBeXT3QFAb5PBf0mF5XC4roeqyKag8M5C8LdNML0Js8Dt?=
 =?us-ascii?Q?Qlz/UQdvcBfBNSq/3X3yqqxy9+DWQ1bA43GR2IzZewJRJnlHzBe7jzPMuQJ/?=
 =?us-ascii?Q?baN2hjSls34/xqmvp58U4kHzKgYVd4NbKdOE45PJCeBHsxhJF4fPdsFIZeFE?=
 =?us-ascii?Q?ztoQm8oOCJs6PsLDTZiB5LxQoc8lIzcdbURlU+PEHPLutt18yMDcfbaKgILn?=
 =?us-ascii?Q?D0LUYl4y24I9j+zNhanMM8RhJfTcv7E7CyvsXwfIryVNSb4G6wTtDPsJrDZA?=
 =?us-ascii?Q?Ibjqz8iZ2HLa9nHEnIHDxD47OK1qmC3d0+Y/v3TI6QhZ2shuUHjKzDIF7oR5?=
 =?us-ascii?Q?0eutW1y5zbThj+l2GqsFAC4M7EZmGDVEdnnLeZqEdj9LX5JEU7WXb8dGvJNY?=
 =?us-ascii?Q?9Lmn6Avh8QpIkQIcYdItIgzeGKwXAr0w0eBch4rpZlDN+gW6bYrG2bbce4op?=
 =?us-ascii?Q?wnlWpxDhLT4po4TFyV0MF7jcjf4qLrdlb/yTAamNGrsH97flGqipVcOkzp4P?=
 =?us-ascii?Q?as9rZ1Wj5roaJ44jHpnLfQJiZ2MyyJtpEDtZf5NOyMV4OwxqXDV3tpT6ow6k?=
 =?us-ascii?Q?k8pcTeFi2TvMB2TrEMs79RihKskEJ19nsFToRnHPb2oMCn3FGcYgRNSyz8vi?=
 =?us-ascii?Q?I05lVxje618SHOQlu4Gus2vwjGBL8p9K0FRjF6/G7oJR0SQjg3sCwXVz++dV?=
 =?us-ascii?Q?cHgxFFHyjP05lQTdupf+Uj+3D4Y3dCNyby52A9JBq36sfqZHxWGE05T+6F61?=
 =?us-ascii?Q?BjVvhmrYdN7wD6UJMnhq1FcJs8wL9MV4FqjG93LGwhrLTeG69ujyLMtCtjOS?=
 =?us-ascii?Q?B4aAxS/gtoyY7YMCFrM=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH0PR12MB5372.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 684fc6d3-8419-425a-4ead-08dd4271a9da
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Feb 2025 03:36:50.4506 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: e47mZaQBbso0IOmnBwzv2FGZdaTXHPHe8c92+pIeWTT48mzU3ZBc8uhXHuaWbe8F/rhAnXyTWRtOgZabdDh9UA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL4PR12MB9482
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

Sorry, please ignore this one . sent wrong patch.

Regards
Shaoyun.liu

-----Original Message-----
From: Liu, Shaoyun <Shaoyun.Liu@amd.com>
Sent: Friday, January 31, 2025 10:35 PM
To: amd-gfx@lists.freedesktop.org
Cc: Liu, Shaoyun <Shaoyun.Liu@amd.com>
Subject: [PATCH] drm/amd : Update MES API header file for v11 & v12

New features require the new fields defines

Signed-off-by: Shaoyun Liu <shaoyun.liu@amd.com>
---
 drivers/gpu/drm/amd/include/mes_v11_api_def.h | 46 ++++++++++++++++++-  dr=
ivers/gpu/drm/amd/include/mes_v12_api_def.h | 34 +++++++++++++-
 2 files changed, 78 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/include/mes_v11_api_def.h b/drivers/gpu/dr=
m/amd/include/mes_v11_api_def.h
index 21ceafce1f9b..a9ff45334fdf 100644
--- a/drivers/gpu/drm/amd/include/mes_v11_api_def.h
+++ b/drivers/gpu/drm/amd/include/mes_v11_api_def.h
@@ -230,13 +230,23 @@ union MESAPI_SET_HW_RESOURCES {
                                uint32_t disable_add_queue_wptr_mc_addr : 1=
;
                                uint32_t enable_mes_event_int_logging : 1;
                                uint32_t enable_reg_active_poll : 1;
-                               uint32_t reserved       : 21;
+                               uint32_t use_disable_queue_in_legacy_uq_pre=
emption : 1;
+                               uint32_t send_write_data : 1;
+                               uint32_t os_tdr_timeout_override : 1;
+                               uint32_t use_rs64mem_for_proc_gang_ctx : 1;
+                               uint32_t use_add_queue_unmap_flag_addr : 1;
+                               uint32_t enable_mes_sch_stb_log : 1;
+                               uint32_t limit_single_process : 1;
+                               uint32_t is_strix_tmz_wa_enabled  :1;
+                               uint32_t reserved : 13;
                        };
                        uint32_t        uint32_t_all;
                };
                uint32_t        oversubscription_timer;
                uint64_t        doorbell_info;
                uint64_t        event_intr_history_gpu_mc_ptr;
+               uint64_t        timestamp;
+               uint32_t        os_tdr_timeout_in_sec;
        };

        uint32_t        max_dwords_in_api[API_FRAME_SIZE_IN_DWORDS];
@@ -563,6 +573,11 @@ enum MESAPI_MISC_OPCODE {
        MESAPI_MISC__READ_REG,
        MESAPI_MISC__WAIT_REG_MEM,
        MESAPI_MISC__SET_SHADER_DEBUGGER,
+       MESAPI_MISC__NOTIFY_WORK_ON_UNMAPPED_QUEUE,
+       MESAPI_MISC__NOTIFY_TO_UNMAP_PROCESSES,
+       MESAPI_MISC__CHANGE_CONFIG,
+       MESAPI_MISC__LAUNCH_CLEANER_SHADER,
+
        MESAPI_MISC__MAX,
 };

@@ -617,6 +632,34 @@ struct SET_SHADER_DEBUGGER {
        uint32_t trap_en;
 };

+enum MESAPI_MISC__CHANGE_CONFIG_OPTION
+{
+       MESAPI_MISC__CHANGE_CONFIG_OPTION_LIMIT_SINGLE_PROCESS =3D 0,
+       MESAPI_MISC__CHANGE_CONFIG_OPTION_ENABLE_HWS_LOGGING_BUFFER =3D 1,
+       MESAPI_MISC__CHANGE_CONFIG_OPTION_CHANGE_TDR_CONFIG    =3D 2,
+
+       MESAPI_MISC__CHANGE_CONFIG_OPTION_MAX =3D 0x1F };
+
+struct CHANGE_CONFIG
+{
+       enum MESAPI_MISC__CHANGE_CONFIG_OPTION opcode;
+       union {
+               struct {
+                       uint32_t limit_single_process : 1;
+                       uint32_t enable_hws_logging_buffer : 1;
+                       uint32_t reserved : 31;
+               } bits;
+               uint32_t all;
+       } option;
+
+       struct {
+               uint32_t tdr_level;
+               uint32_t tdr_delay;
+       } tdr_config;
+};
+
+
 union MESAPI__MISC {
        struct {
                union MES_API_HEADER    header;
@@ -631,6 +674,7 @@ union MESAPI__MISC {
                        struct          WAIT_REG_MEM wait_reg_mem;
                        struct          SET_SHADER_DEBUGGER set_shader_debu=
gger;
                        enum MES_AMD_PRIORITY_LEVEL queue_sch_level;
+                       struct          CHANGE_CONFIG change_config;

                        uint32_t        data[MISC_DATA_MAX_SIZE_IN_DWORDS];
                };
diff --git a/drivers/gpu/drm/amd/include/mes_v12_api_def.h b/drivers/gpu/dr=
m/amd/include/mes_v12_api_def.h
index 101e2fe962c6..62df832810ca 100644
--- a/drivers/gpu/drm/amd/include/mes_v12_api_def.h
+++ b/drivers/gpu/drm/amd/include/mes_v12_api_def.h
@@ -643,6 +643,10 @@ enum MESAPI_MISC_OPCODE {
        MESAPI_MISC__SET_SHADER_DEBUGGER,
        MESAPI_MISC__NOTIFY_WORK_ON_UNMAPPED_QUEUE,
        MESAPI_MISC__NOTIFY_TO_UNMAP_PROCESSES,
+       MESAPI_MISC__QUERY_HUNG_ENGINE_ID,
+       MESAPI_MISC__CHANGE_CONFIG,
+       MESAPI_MISC__LAUNCH_CLEANER_SHADER,
+       MESAPI_MISC__SETUP_MES_DBGEXT,

        MESAPI_MISC__MAX,
 };
@@ -713,6 +717,34 @@ struct SET_GANG_SUBMIT {
        uint32_t slave_gang_context_array_index;  };

+enum MESAPI_MISC__CHANGE_CONFIG_OPTION
+{
+       MESAPI_MISC__CHANGE_CONFIG_OPTION_LIMIT_SINGLE_PROCESS =3D 0,
+       MESAPI_MISC__CHANGE_CONFIG_OPTION_ENABLE_HWS_LOGGING_BUFFER =3D 1,
+       MESAPI_MISC__CHANGE_CONFIG_OPTION_CHANGE_TDR_CONFIG    =3D 2,
+
+       MESAPI_MISC__CHANGE_CONFIG_OPTION_MAX =3D 0x1F };
+
+struct CHANGE_CONFIG
+{
+       enum MESAPI_MISC__CHANGE_CONFIG_OPTION opcode;
+       union {
+               struct  {
+                       uint32_t limit_single_process : 1;
+                       uint32_t enable_hws_logging_buffer : 1;
+                       uint32_t reserved : 30;
+               }bits;
+               uint32_t all;
+       } option;
+
+       struct {
+               uint32_t tdr_level;
+               uint32_t tdr_delay;
+       } tdr_config;
+};
+
+
 union MESAPI__MISC {
        struct {
                union MES_API_HEADER    header;
@@ -726,7 +758,7 @@ union MESAPI__MISC {
                        struct WAIT_REG_MEM wait_reg_mem;
                        struct SET_SHADER_DEBUGGER set_shader_debugger;
                        enum MES_AMD_PRIORITY_LEVEL queue_sch_level;
-
+                       struct CHANGE_CONFIG change_config;
                        uint32_t data[MISC_DATA_MAX_SIZE_IN_DWORDS];
                };
                uint64_t                timestamp;
--
2.34.1

