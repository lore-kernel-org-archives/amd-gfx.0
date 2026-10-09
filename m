Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E56F2CA6012
	for <amd-gfx@archiver.kernel.org>; Fri,  9 Oct 2026 07:00:06 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7229310FEE3;
	Fri,  9 Oct 2026 07:00:06 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="PIz2bIap";
	dkim-atps=neutral
Received: from PH8PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11012068.outbound.protection.outlook.com [40.107.209.68])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D9AB410FEE3
 for <amd-gfx@lists.freedesktop.org>; Fri,  9 Oct 2026 07:00:05 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pqtbPjtloH/OBlZopDZXtFxo1kP77lvquw6VEDAWG5GFnnhv5W87ObSkcKYhOqaDTMJQj41XGuTOOYW+qQnaybHHGOUCrd9EzbKfXw968NeVGUuB1+w6cIbE7tsb1LhaH/Ftommf9zbRYGtdSRZfQZKIyGMPp7MEv/7MHD//4ebHiLH1/3wuSrSNYMh0n2z9Hy9Kwfz8nlXs7aI7As8Kzp7dchVdTiF2gGRVcYxRm07gzr11DuEDolawzmvJ/FHBQRDPpmhT3dB72d7rGWUMFpMcZIkWc15vbtnd0N6Qp+gjoUVfaI2/YNWpB6gTMZvlG0sGZlIdYh/2+rsutM/ofg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vrLkLQA/JXfHeLnoh5HNAPPEE8ANeKxBQbfUhFztDq0=;
 b=Pi1ZEgVsy1+wuM7XZ+3XH+oNuyE0eBZgIcduWAspJwZBVB850b5OLAieydjRiqrglWRAwZC6Weh1FW+JAWJ+ZN6/6OoNgJvS+4tDtatGo5Zw7ELwG2q6w08qHVlr/QA2G/YrCt6S3YA3JpvO/uC4MiNwHP2CGH9TOSsKnNdvDbqxQf96yjLEPVgxjP0MxbnNZLFq6xmjovyxKs7YZPo3YbxM1UPW47ZKllA8AWsMcWkLj4dBwW7OYZKarXJmZEi8Zjt/NmMw03mHtJ48ZCxaJzMWEtStxTAdTwTwaMy/Pvk4H+cfgLV3LYE1qO7dkYk0IRoymxSYtU5K8swIBaXREg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vrLkLQA/JXfHeLnoh5HNAPPEE8ANeKxBQbfUhFztDq0=;
 b=PIz2bIapQqkiKGXzzZlOdyhE5xc3WlV4uQMGGR4BK5+VW9roNg5asji60EDaQ9CVwJVl5SK28EuvquaihVA9/WjEKwh0oVlbkKDsMQ/rqevJC4+2kf7QM53jmcUN6v2Rw7fQZq1lw24aShpyMyhnRuLYWe6NVIRPvYdVuvoUU3w=
Received: from BN7PPFFF39339DD.namprd12.prod.outlook.com
 (2603:10b6:40f:fc02::6eb) by PH0PR12MB7861.namprd12.prod.outlook.com
 (2603:10b6:510:26e::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.27; Fri, 9 Oct
 2026 07:00:01 +0000
Received: from BN7PPFFF39339DD.namprd12.prod.outlook.com
 ([fe80::9e62:eec6:fa38:a6a6]) by BN7PPFFF39339DD.namprd12.prod.outlook.com
 ([fe80::9e62:eec6:fa38:a6a6%4]) with mapi id 15.21.0472.016; Fri, 9 Oct 2026
 07:00:01 +0000
From: "Zhang, Hawking" <Hawking.Zhang@amd.com>
To: "Yang, Stanley" <Stanley.Yang@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
CC: "Zhou1, Tao" <Tao.Zhou1@amd.com>, "Chai, Thomas" <YiPeng.Chai@amd.com>,
 "Li, Candice" <Candice.Li@amd.com>, "Liu, Xiang(Dean)" <Xiang.Liu@amd.com>,
 "Sun, Ce(Overlord)" <Ce.Sun@amd.com>, "Xie, Patrick" <Gangliang.Xie@amd.com>, 
 "Yang, Stanley" <Stanley.Yang@amd.com>
Subject: RE: [PATCH Review v2 1/1] drm/amd/ras: Support invoke ras command
Thread-Topic: [PATCH Review v2 1/1] drm/amd/ras: Support invoke ras command
Thread-Index: AQHdV7RXpLjjZo9x5Em0+7hDEKpswrb0yBkQ
Date: Fri, 9 Oct 2026 07:00:00 +0000
Message-ID: <BN7PPFFF39339DDFB073AB8C670D2363E12FC922@BN7PPFFF39339DD.namprd12.prod.outlook.com>
References: <20261009060553.62203-1-Stanley.Yang@amd.com>
In-Reply-To: <20261009060553.62203-1-Stanley.Yang@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Enabled=True;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SetDate=2026-10-09T06:59:40.0000000Z;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Name=AMD General
 v26; MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_ContentBits=3;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Method=Standard
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN7PPFFF39339DD:EE_|PH0PR12MB7861:EE_
x-ms-office365-filtering-correlation-id: 9d81d803-da8e-4754-ed1c-08df25d2effc
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|23010399003|376014|1800799024|10067099003|5023799004|3023799007|56012099006|6133799003|11063799006|18002099003|22082099003|38070700021;
x-microsoft-antispam-message-info: f/KDTSwZr5avTLdsX0om4lyfmm3pBO7LDtNxGUP125/2HlmMo7tHKQy+dGtjqo5G/qFQGimhQk4v1XghLT4gA04FCnymNLbn8tf0zjl7a4teIHbk/S13CRhijlNVh+zgx5j1Bg7qX32ctUIvpDipMcmOpQVLb98PeOn8hpN8f/a3QXl6bl8Rh/Lra1whbOZbwVrYTrQ1zvCjUmDYY6KKAjCbA2bZI6hLNNw5yd5hZ0f0fUnZuowipU/UPEKxG00hDtoVAvVx/JzgQYT7Wu7NSi+DyAkVFUjvgb2Wm6BYZRByatLLU57gwmJN24o7sMIG74QqxdxhZalYvnUUun7r1/UaVUhQMSVlx1vAqi10wiNm/1A/GGCah7/2jgdmWilcAc+IHmo6DBtFRE779ZAtgbABJrkBPAgvG0BaNE1u74FwE06HKOAygkZqhbIj0BzsuVlt1qUM1qYo/teXf28/fcja2XEMHhE0tDRGSuWcdtZcqydABA/3g582HtJMezicy7QlC4FnlSL2uAs28yWAc8IHfxMNRXpZ7nxwZX/wPWhF4r5K72n6ilxHHfCUxszagiUcJD4v9hCynWsciVHwVgxyQINcNDbfa96YYzPKDu+XZNUgNE6/oDhLrOiQXl/TfUEzjQiK34uG5oRX4WFw0Quq1BTd/BPRyaFfjhNPhwgU6JekyOxepSQAGV4LFWziWLbVvnflnbzTqAReQIOeAkkYFO52AN+G2bIm+wSy+RU=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN7PPFFF39339DD.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(23010399003)(376014)(1800799024)(10067099003)(5023799004)(3023799007)(56012099006)(6133799003)(11063799006)(18002099003)(22082099003)(38070700021);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?jL5fcmC3bQnkDWiXR+DumJaJgP62kFXWp8+z364NAspWMts/4DwFPMty+M0A?=
 =?us-ascii?Q?1k62izN3tqUNfkb9gF2dEJqrkmEyETNAxOIXseHwlZLz1NC3pptxZB0Xd/Ug?=
 =?us-ascii?Q?eDAW74Tz1Y/go53L/ApAodnliVUG6JxdSwpAoBBq89iF72oPu0c1tUJGptqj?=
 =?us-ascii?Q?+PWzUEybMxuHgeOkwtuhpMLQth0wLsc1EoWG2EJH0Z0aRf77wdK5Mft330gR?=
 =?us-ascii?Q?Sx4F3IoOdG4XMH38Z2Gji0K6JOquoz6g+iJh0s/RJhYnSOt7Z1UmaRnJPWBe?=
 =?us-ascii?Q?svwE2DLSx29OLGPCyPFZCz20Xn2GjTy/erEYd03WF3iDXm39hwwmIDoLpHBS?=
 =?us-ascii?Q?79n+DI6yCBHHftSedM0Ka3HEqoY0qpf2TPheKRCfa8yFVC31exJ/yVhndop+?=
 =?us-ascii?Q?9KO6Hfw/4GQNIa+wf+hAlDHZUxQKokuvP2uOwsBN2cyxRK/IceJHY9XmYQW/?=
 =?us-ascii?Q?WZLQhhJoW2vqfpWWb9V05vb+YMpE0t9dNXeCaINy+CQMyTQ3tozhhkDnmdn7?=
 =?us-ascii?Q?oqsAlmxCpCWfMYhzDOJsUNuaB7xVRST+91UZlNO5ywbCrhwbndjqHMbMYhti?=
 =?us-ascii?Q?KW9CndgW4tpFcYIqY2iWEteAFNx1rt/XjaM/JTZC2s+G2Du2gMNfRkCw/FAT?=
 =?us-ascii?Q?IMT03Krg23UKS1vVJyohmX9CWziDTh6wGLL5+EwsaGWsF5YeDwqr7ESALVbx?=
 =?us-ascii?Q?yPOTC/Fqn2HQfeFe8Ot+w7lHoAarU5NA2G4gK8HWiau+ijQu7pgryvORdmo+?=
 =?us-ascii?Q?FVNr3dYEdtXWpY0weGHsNSic7QNtqh9ehQtONvIP086xfA1h1BgG77Kz1T6N?=
 =?us-ascii?Q?pvSZX98zHNIkO/k4OANOyYgw4KJwjmHqTB81MeOUQYBXbV/FmBQJcxK7GCd4?=
 =?us-ascii?Q?WNAFJF6vmmoLYMXP9qje11FPJtSkSAx2YGCEeKHAhJi8DtluUvALMmBOrer9?=
 =?us-ascii?Q?R6Ic7K041jT2nzlZIaZo7NVt9z60ORhH9HysAUGDeXR/mSg10Y18wIPb40po?=
 =?us-ascii?Q?AgpO1Pc2j5V2DRM37/Ej2JlaWXH5xfbMUq26+SsP4hlJvpnzQI72Bhq+f5Vp?=
 =?us-ascii?Q?Bs7J1B5GXkI+p0zdq9nGGbWdMnHepR34EOtll6JZj0crApw04BUW8pGPxb0Y?=
 =?us-ascii?Q?z2GpxDMpojHYkTmtiNGNtgXe8scgtMp17KA0DiUE+xlXud1yaXaQ+m23j7Wp?=
 =?us-ascii?Q?alZEeoy6EYEYiRRQBcnLUJNMPyIearcfeUKlaUfoKB7TMpsNlEVE4rhvHel5?=
 =?us-ascii?Q?IsiFtKUgzXECHl45iGEFENy1uvwguf3sxNem2M9YE92+us11vWyAATAvBD2I?=
 =?us-ascii?Q?9o8Yi7nJaA//ZpK24yl5ifiSi0MIYooG4H8//sOY2ylszYD/HqRlv0rD7bHa?=
 =?us-ascii?Q?zay4lJ+AtixeTspQSuUAggI9jJ3Fkz3XhYyLiSK4ID76rkli8rPHxPwmh092?=
 =?us-ascii?Q?pj3rGv33LFWEn9Hu+W586bSzdWucrl+wX8mGye9oooTbSo5IKxpVLL6exQn7?=
 =?us-ascii?Q?aebpj9oSDXQA7UNiFDwwVN4JQOr0z/h7IZ808qj5nEy7DrOCjQPle6nTWC1Y?=
 =?us-ascii?Q?EFefvQk+2txiXHOZBtw67bu4ZxuWGnrBCtoA02oUOkoFkrvAs32Y5Kbc5Xlj?=
 =?us-ascii?Q?9jYQ7kOdBupGP2dAUHdVF6Uk3hWg0AfKhgYTld4wK9m5HEQnh/JQB6F6xN49?=
 =?us-ascii?Q?SQ8H0EfmWRcRE4UIIWTSAKY/hD4G8WyuR4lXQlbu6WiiiNJs?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN7PPFFF39339DD.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9d81d803-da8e-4754-ed1c-08df25d2effc
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Oct 2026 07:00:00.9424 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: BkApIc2E3Th2u8gYkxE/5rMOCVXJb5EecfZNYIcmn/3gvnmIx90Om8O64Cpa9sV5/yq7eA1rrZTcj9iu/lig8w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB7861
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

Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>

Regards,
Hawking
-----Original Message-----
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Stanley.=
Yang
Sent: Friday, October 9, 2026 2:06 PM
To: amd-gfx@lists.freedesktop.org
Cc: Zhang, Hawking <Hawking.Zhang@amd.com>; Zhou1, Tao <Tao.Zhou1@amd.com>;=
 Chai, Thomas <YiPeng.Chai@amd.com>; Li, Candice <Candice.Li@amd.com>; Liu,=
 Xiang(Dean) <Xiang.Liu@amd.com>; Sun, Ce(Overlord) <Ce.Sun@amd.com>; Xie, =
Patrick <Gangliang.Xie@amd.com>; Yang, Stanley <Stanley.Yang@amd.com>
Subject: [PATCH Review v2 1/1] drm/amd/ras: Support invoke ras command

Use uniras core to invoke ras command.

Changed from v1:
        use common function send_ras_ta_runtime_cmd in ras_psp_invoke_ras_t=
a

Signed-off-by: Stanley.Yang <Stanley.Yang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_psp_ta.c | 17 +++++++++
 drivers/gpu/drm/amd/ras/core/ras_psp.c     | 40 +++++++++++++++++-----
 drivers/gpu/drm/amd/ras/core/ras_psp.h     |  3 ++
 drivers/gpu/drm/amd/ras/core/ta_if.h       |  1 +
 4 files changed, 53 insertions(+), 8 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp_ta.c b/drivers/gpu/drm/a=
md/amdgpu/amdgpu_psp_ta.c
index 8ae72c862d11..2d494ac57eb4 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp_ta.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp_ta.c
@@ -23,6 +23,7 @@

 #include "amdgpu.h"
 #include "amdgpu_psp_ta.h"
+#include "amdgpu_ras_mgr.h"

 #if defined(CONFIG_DEBUG_FS)

@@ -330,6 +331,22 @@ static ssize_t ta_if_invoke_debugfs_write(struct file =
*fp, const char *buf, size
        if (IS_ERR(shared_buf))
                return PTR_ERR(shared_buf);

+       if (ta_type =3D=3D TA_TYPE_RAS && amdgpu_uniras_enabled(adev)) {
+               struct amdgpu_ras_mgr *ras_mgr =3D amdgpu_ras_mgr_get_conte=
xt(adev);
+
+               if (!ras_mgr || !ras_mgr->ras_core) {
+                       ret =3D -EINVAL;
+                       goto free_shared_buf;
+               }
+
+               ret =3D ras_psp_invoke_ras_ta(ras_mgr->ras_core, ta_id, cmd=
_id,
+                                          shared_buf, shared_buf_len);
+               if (!ret && copy_to_user((char *)&buf[copy_pos], shared_buf=
, shared_buf_len))
+                       ret =3D -EFAULT;
+
+               goto free_shared_buf;
+       }
+
        set_ta_context_funcs(psp, ta_type, &context);

        if (!context || !context->initialized) { diff --git a/drivers/gpu/d=
rm/amd/ras/core/ras_psp.c b/drivers/gpu/drm/amd/ras/core/ras_psp.c
index ed53cd25d6bd..c3c6039bfe7a 100644
--- a/drivers/gpu/drm/amd/ras/core/ras_psp.c
+++ b/drivers/gpu/drm/amd/ras/core/ras_psp.c
@@ -426,7 +426,8 @@ static int __check_ras_ta_cmd_resp(struct ras_core_cont=
ext *ras_core,  }

 static int send_ras_ta_runtime_cmd(struct ras_core_context *ras_core,
-                       enum ras_ta_cmd_id cmd_id, void *in, uint32_t in_si=
ze,
+                       uint32_t session_id, enum ras_ta_cmd_id cmd_id,
+                       void *in, uint32_t in_size,
                        void *out, uint32_t out_size)
 {
        struct ras_ta_ctx *ta_ctx =3D &ras_core->ras_psp.ta_ctx; @@ -467,7 =
+468,7 @@ static int send_ras_ta_runtime_cmd(struct ras_core_context *ras_c=
ore,
        memcpy(&ras_cmd->ras_in_message, in, in_size);

        invoke_cmd.ta_cmd_id =3D cmd_id;
-       invoke_cmd.session_id =3D ta_ctx->session_id;
+       invoke_cmd.session_id =3D session_id;

        ret =3D send_psp_cmd(ras_core, GFX_CMD_ID_INVOKE_CMD,
                        &invoke_cmd, sizeof(invoke_cmd), &resp); @@ -494,10=
 +495,15 @@ static int send_ras_ta_runtime_cmd(struct ras_core_context *ras=
_core,
                goto unlock;
        }

-       if (!ras_cmd->ras_status && out && out_size)
+       /* Hand the TA output back regardless of status; ret carries the st=
atus. */
+       if (out && out_size)
                memcpy(out, &ras_cmd->ras_out_message, out_size);

-       ret =3D __check_ras_ta_cmd_resp(ras_core, ras_cmd);
+       /* cmd from user space requires special handling for CHECK_ACA_BANK=
_ERROR_TYPES */
+       if (cmd_id =3D=3D RAS_TA_CMD_ID__CHECK_ACA_BANK_ERROR_TYPES)
+               __check_ras_ta_cmd_resp(ras_core, ras_cmd);
+       else
+               ret =3D __check_ras_ta_cmd_resp(ras_core, ras_cmd);

 unlock:
        mutex_unlock(&ta_ctx->ta_mutex);
@@ -536,7 +542,9 @@ static int trigger_ras_ta_error(struct ras_core_context=
 *ras_core,
        dev_mask &=3D RAS_TA_INST_MASK;
        info->sub_block_index |=3D dev_mask;

-       return send_ras_ta_runtime_cmd(ras_core, RAS_TA_CMD_ID__TRIGGER_ERR=
OR,
+       return send_ras_ta_runtime_cmd(ras_core,
+                               ras_core->ras_psp.ta_ctx.session_id,
+                               RAS_TA_CMD_ID__TRIGGER_ERROR,
                                info, sizeof(*info), NULL, 0);
 }

@@ -785,6 +793,21 @@ int ras_psp_unsideload_ras_ta(struct ras_core_context =
*ras_core,
        return unload_ras_ta_fw(ras_core, ras_ta_unload);  }

+int ras_psp_invoke_ras_ta(struct ras_core_context *ras_core,
+               uint32_t session_id, uint32_t cmd_id,
+               void *shared_buf, uint32_t shared_buf_len) {
+       /* The debugfs caller hands over a full ras_ta_cmd shared buffer. *=
/
+       struct ras_ta_cmd *ras_cmd =3D shared_buf;
+
+       if (!shared_buf || shared_buf_len < sizeof(*ras_cmd))
+               return -EINVAL;
+
+       return send_ras_ta_runtime_cmd(ras_core, session_id, cmd_id,
+                       &ras_cmd->ras_in_message, sizeof(ras_cmd->ras_in_me=
ssage),
+                       &ras_cmd->ras_out_message, sizeof(ras_cmd->ras_out_=
message));
+}
+
 int ras_psp_reload_firmwares(struct ras_core_context *ras_core,
                uint32_t flags)
 {
@@ -810,7 +833,7 @@ int ras_psp_enable_features(struct ras_core_context *ra=
s_core,
                return -ENOEXEC;
        }

-       return send_ras_ta_runtime_cmd(ras_core,
+       return send_ras_ta_runtime_cmd(ras_core, ta_ctx->session_id,
                        enable ? RAS_TA_CMD_ID__ENABLE_FEATURES :
                                 RAS_TA_CMD_ID__DISABLE_FEATURES,
                        info, sizeof(*info), NULL, 0);
@@ -846,8 +869,9 @@ int ras_psp_query_address(struct ras_core_context *ras_=
core,
        if (!addr_in || !addr_out)
                return -EINVAL;

-       return send_ras_ta_runtime_cmd(ras_core, RAS_TA_CMD_ID__QUERY_ADDRE=
SS,
-               addr_in, sizeof(*addr_in), addr_out, sizeof(*addr_out));
+       return send_ras_ta_runtime_cmd(ras_core, ta_ctx->session_id,
+               RAS_TA_CMD_ID__QUERY_ADDRESS, addr_in, sizeof(*addr_in),
+               addr_out, sizeof(*addr_out));
 }

 int ras_psp_sw_init(struct ras_core_context *ras_core) diff --git a/driver=
s/gpu/drm/amd/ras/core/ras_psp.h b/drivers/gpu/drm/amd/ras/core/ras_psp.h
index 4cc133c6a6d3..91d17fdd6bda 100644
--- a/drivers/gpu/drm/amd/ras/core/ras_psp.h
+++ b/drivers/gpu/drm/amd/ras/core/ras_psp.h
@@ -196,6 +196,9 @@ int ras_psp_sideload_ras_ta(struct ras_core_context *ra=
s_core,
                struct ras_psp_ta_load *ta_load);
 int ras_psp_unsideload_ras_ta(struct ras_core_context *ras_core,
                struct ras_psp_ta_unload *ras_ta_unload);
+int ras_psp_invoke_ras_ta(struct ras_core_context *ras_core,
+               uint32_t session_id, uint32_t cmd_id,
+               void *shared_buf, uint32_t shared_buf_len);
 int ras_psp_enable_features(struct ras_core_context *ras_core,
        struct ras_ta_enable_features_input *info, bool enable);  int ras_p=
sp_trigger_error(struct ras_core_context *ras_core, diff --git a/drivers/gp=
u/drm/amd/ras/core/ta_if.h b/drivers/gpu/drm/amd/ras/core/ta_if.h
index 30c058a524db..87d5aa3f8477 100644
--- a/drivers/gpu/drm/amd/ras/core/ta_if.h
+++ b/drivers/gpu/drm/amd/ras/core/ta_if.h
@@ -44,6 +44,7 @@ enum ras_ta_cmd_id {
        RAS_TA_CMD_ID__QUERY_BLOCK_INFO,
        RAS_TA_CMD_ID__QUERY_SUB_BLOCK_INFO,
        RAS_TA_CMD_ID__QUERY_ADDRESS,
+       RAS_TA_CMD_ID__CHECK_ACA_BANK_ERROR_TYPES =3D 10,
        MAX_RAS_TA_CMD_ID
 };

--
2.43.0

