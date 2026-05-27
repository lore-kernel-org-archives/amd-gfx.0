Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 39DA6CD5BC9
	for <amd-gfx@archiver.kernel.org>; Wed, 27 May 2026 10:44:07 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CDBCB10E785;
	Wed, 27 May 2026 10:44:06 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="PwgnAeXz";
	dkim-atps=neutral
Received: from CH1PR05CU001.outbound.protection.outlook.com
 (mail-northcentralusazon11010013.outbound.protection.outlook.com
 [52.101.193.13])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E3B6D10E782
 for <amd-gfx@lists.freedesktop.org>; Wed, 27 May 2026 10:44:05 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uGrH2lCGv1EBWQcbQ3aGp8cTGatIJcHMVD92fwy0dAI/HDiGd2lO7zQFnuO+S4AZaIHkVV2EX5a09JmirQRAcPH49gT6H5j9aFTqYc5iAYI+MztQM0VZGZU8q/WQJSZvEF9iC1L3X8B11jdxP4v5/CydkkFsknNKzvqDARkakejsQNk2vxxytSi7ocmEAAqoBR3yCVDsQeuzZvbZ3Cpr5Qs97LQfbPeNqmpDn603yxOOlk1MHweCGdD5OHjEOp+39ffednanZycz+qZOh9pPbkLk1Tv16zBnSYnTGx8bOgQDkQ7XbA1az6xyE2ME5jRzDSEOO7ewAl+EaymkZOyMOw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tmN9RE5qFdgYQdwwA6Srr2kxT0Ads8U1lYWodMxeZiY=;
 b=XJc3W2Pb1P64U/CTT0Qw0ODID9YQb8XI1QjrMrW/MfBWnvpSVsHpU9T+E7WY80RIh8kzpCFxVL8XMloHm5ySPkW761JsYIqlu7pgnxYiDjoUStd7ZSKJdQqlEIJgu3xA20ygCmCCBgkctyvOzaFmL3mbvZYksKtydnUKyI1I9LVb/DttQQ4rjKeNkw1ysDS1+EjnbQ+Y0+RAbbjNcTSi/1OoJG8Ky7KI3AkpfMyZNlBu97UO5BlTxEHuzAVq1c6pcvUFPzsflh/SH5wMuqkfIY45tdfitPbtzt+5MhZVWEMdDSAUgLkEAJB8Si4iDN6PVGB+novG4tTBcuNXL0lyIQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tmN9RE5qFdgYQdwwA6Srr2kxT0Ads8U1lYWodMxeZiY=;
 b=PwgnAeXzVDyyriYgP3dc14NpTY8sNWGdsXExkHmdK3EZK/1teZmJToJR3RUp/OLQ8mGqh9HXnfSAvvl6TqEJo9CMruBREFySJ9z3PTidzdbc46eGEr7etKDEY96YJu63UFLVD/VqXlp4sv9PlXo9ondP8KctwgcDsayV0NgroUA=
Received: from BN9PR12MB5306.namprd12.prod.outlook.com (2603:10b6:408:103::12)
 by IA0PR12MB8695.namprd12.prod.outlook.com (2603:10b6:208:485::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.71.11; Wed, 27 May
 2026 10:44:02 +0000
Received: from BN9PR12MB5306.namprd12.prod.outlook.com
 ([fe80::9976:3768:a636:3c3d]) by BN9PR12MB5306.namprd12.prod.outlook.com
 ([fe80::9976:3768:a636:3c3d%2]) with mapi id 15.21.0071.011; Wed, 27 May 2026
 10:44:02 +0000
From: "Chai, Thomas" <YiPeng.Chai@amd.com>
To: "Yang, Stanley" <Stanley.Yang@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
CC: "Zhang, Hawking" <Hawking.Zhang@amd.com>, "Zhou1, Tao"
 <Tao.Zhou1@amd.com>, "Li, Candice" <Candice.Li@amd.com>
Subject: RE: [PATCH 1/2] drm/amd/ras: Return RAS TA injection result to
 userspace
Thread-Topic: [PATCH 1/2] drm/amd/ras: Return RAS TA injection result to
 userspace
Thread-Index: AQHc7NXHbE7nhHQLtUGIkzABDG2c3rYhsDew
Date: Wed, 27 May 2026 10:44:02 +0000
Message-ID: <BN9PR12MB5306F83C3CCB8F410A273F1EFC082@BN9PR12MB5306.namprd12.prod.outlook.com>
References: <20260526060602.69082-1-Stanley.Yang@amd.com>
In-Reply-To: <20260526060602.69082-1-Stanley.Yang@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Enabled=True;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SetDate=2026-05-27T10:38:23.0000000Z;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Name=AMD General
 v26; MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_ContentBits=3;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Method=Standard
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR12MB5306:EE_|IA0PR12MB8695:EE_
x-ms-office365-filtering-correlation-id: d025d888-0874-4612-0756-08debbdcddd8
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|366016|1800799024|38070700021|56012099006|6133799003|11063799006|18002099003|22082099003;
x-microsoft-antispam-message-info: jhvl+RAEO1kBUW+zgznbwf3C0jRC2OsKuEb2xhrKxZoScPCMi3961aOQsbp2EhGoaXo4dCb0tjynOMWYLh6VDcdi6mT9XBlZPbgZ2817DvwBdnsUe5QPSpWMgGaxRzHSYpVF1vRqfzZDLaZ8WWUZBLE3EmH6XKrAx81/QnjcG3hfuUwUNwxltxeQIKA0BQHCyThBpsCJcccP37lyK1nF7//US+SKbNy8Z6/aCMyARm8g5waJ6D0txIT4Xj4keKORUL6l+xXfHnrxfIw9sipKugIsQtdsg4Buf/lS7Ghbnw8RFry7RMQ8w8Ht2riPXUEfyiX+RA9W4NgbJp33RQg/yqh81ERaVGonlH/0kFg/LnKCmfXApUwzpYurdAWvYb23FrVEhC1YtOxVwwJJkyJimcjTsIykQWTX5RUpq9ZaQoYUDIWWCN1JmLxAgbGz97VJMm5p/Qv/vKxJXuXARuZmHzKza5yS1GC1i/Fs4qyeHX8K947AisZkhzM0dzQlDQiCEuwd06p/pRlTPCDAALVzMDgibFeq4BCqkxOPLZTrUyplCl6SV2Fy5LTggaufeTE0dkzOwAwc+xMOMWnzqvXxdO4KfPDfIZylrgolMXwv7+jOGEmmmO/kHiLeTHj6NG5yw+P6dBftTESXNto5DFjVfviU/XIX1Mvi5qbmD6nc+xkIXXgdc51lheYSpteVXb38twfshA/42k4cVnzB3vn4chDeln2cQvhys6/ZN+TsbAvjVDGtQIW5a4LzzMy7DSg0
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5306.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(38070700021)(56012099006)(6133799003)(11063799006)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?byu3LMuy8+sYkWvp7t7ThIMbeEECLxeCHpQiHZZ9yXiIM3b/q0e1RrjPEcSL?=
 =?us-ascii?Q?aI+UCMn57oKICgvq8oxhzcvPaeNYlj9bU0UWCidtpd+tyGA+OvbZSGjBE6s8?=
 =?us-ascii?Q?zJNB9kUe9au+afSlCrvAEpD0chuqvALET2Ed5bBkSnhvY5iupMnGgmgW6i2c?=
 =?us-ascii?Q?nbdnjTMnSo3Gr0QmiONQ9PCuH+xdUCTu/vmeEKHckm4BVf26919G24W6XIbR?=
 =?us-ascii?Q?vYhpWhMIOco/5/ZbVcspraUcXPyIYP/0ov1QcKNpa53EmPDtrDn7qUupgS4b?=
 =?us-ascii?Q?TG5B7gA5YH3+n7dUkUzYeHjbKjdthSpgB7AkvpTSC4EDo6TSWIXxbPpWqJlu?=
 =?us-ascii?Q?t8+bH6stPKfc58OxKoK3vDfZSBwg5x+7n3Y4OGmL+XuJeLAhSMvE5l3fPEWQ?=
 =?us-ascii?Q?k8TLDSmhDu0vEF76b1l2C1sOI7q2vvO02B+crhtmS2phV7IqXpI7CxdzU8O9?=
 =?us-ascii?Q?rOlSC9bGrAr6q7o3z0PNTuvxVNGtrETRoQaQC44lTKk2HQva3Brq6Qv0ef+4?=
 =?us-ascii?Q?v9mUxKKUIwY2t5C2F3EyPDhAx0IfERL6eFeB49iJsgvPYDQypa/o3wj9zpxX?=
 =?us-ascii?Q?3GEhbFq2GzG9cxbrjdiHRCq8Xp6/iCSm0ZKGpdR3xBzAhgpy/tMlEuwIRrbP?=
 =?us-ascii?Q?BtQ85hHu3nXUxqo0a/YIOjwynhwoXKjIoQCVjcWHfBkXgw042Km5u+1+im4h?=
 =?us-ascii?Q?P9ejVaNmT/PMQIajNQjNJNz58Q7B6wHZ41r0dSdyulzddLmWtJFQTGQNmdPF?=
 =?us-ascii?Q?aDAlq2HE7CyZXhuVK1MG6Yys9ZuCZ732BkXRHunGGdIQBSuNfHPrQl1iorY2?=
 =?us-ascii?Q?Umx6gSMIrCoV9FH3p86rUteRvAvRZDnJ4iuNeoR4v5rF0X8ihJFLzeKhzf8n?=
 =?us-ascii?Q?Ryqo/NTEjxi9dqD6DnrpyJwi0Kp6JN5Qmbb1MmwS98HhntXwJ4UcsC2ShkAC?=
 =?us-ascii?Q?h/qEEvhDAk4Kd/dmozipoukIfLbXIl6Rtgol+5lnKUgNVpwNsSfdRq7+6Lxi?=
 =?us-ascii?Q?pJ+bKxrxWTEoxtwg/SIH4u0GiL/HgwLOfHzkL7VzgbyK+009lYL5t42Uh0Ns?=
 =?us-ascii?Q?HXUGP1xWO4MA13Dtlunu+HP5vYNlYSt+Te3EridtCcVjz2kAOOMJDbJKm8Fd?=
 =?us-ascii?Q?9BDRMhuiIvE5f9Ybj16YiCueQzzd4booy8wY1W4DBJJY1RzehIOso4YBNXQS?=
 =?us-ascii?Q?BtrRUOYjsOC+r6ahIDdXzGi8FtX34Md3QcgPlO/tnv9rI22j7bRiOl61Ny/l?=
 =?us-ascii?Q?dwGOF/2gi8VxZZOC3O8SCxYmE/KAzhwVO8NkBeLaADkALpdNTj1d/RYSD/KW?=
 =?us-ascii?Q?/2HiBMzmVhv8fG2ifuRQnAbuREUwWvsvY0DYv+51vUwW5rdGElnbwZrxdhrg?=
 =?us-ascii?Q?U160JsoVKlJhAw1U1Ko0xbV6vEk6l7TtxMY3YXG3t5PeRHbIvr4sQGm4g3Xc?=
 =?us-ascii?Q?sxzdCnU4VcUuMlBLJ5V9yactv6h+JddQuHBJAmqgudP73r818iSR1Rz8CJ5r?=
 =?us-ascii?Q?81sxII+UrPl5Nuh83j6mWh+2SaUJxf4lmKnSBZuh+4TIYwMHp09KtjMSGyDl?=
 =?us-ascii?Q?IcxH577bVlX2/+3NHm3TrBIOaVzATzII0+a79pSZM0OF//zkrPvGwAiX689W?=
 =?us-ascii?Q?2iPl0b1cr2GDk2d6elpA/n98qZSEaAHGLk+OjQ/TeAaErAsA7ixxpUnIpsyZ?=
 =?us-ascii?Q?H4VsUzqGUX9FGFm45rvQwIju5V05G5WfWiw0917zmQddl94c?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5306.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d025d888-0874-4612-0756-08debbdcddd8
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 May 2026 10:44:02.1977 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: dimT7J1jfbDyFTSWpD234Fp3Fp9y+xEJ3Y3Lq6W5cT7D7cHwvTr65ClKnC1Xrz5pLxSirHJfmC/Nqq7Qi2HGQQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8695
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

The __check_ras_ta_cmd_resp function should have a return statement added a=
t the end.

Fixed that the series is:

Reviewed-by: YiPeng Chai <YiPeng.Chai@amd.com>


Best Regards,
Thomas
-----Original Message-----
From: Yang, Stanley <Stanley.Yang@amd.com>
Sent: Tuesday, May 26, 2026 2:06 PM
To: amd-gfx@lists.freedesktop.org
Cc: Zhang, Hawking <Hawking.Zhang@amd.com>; Zhou1, Tao <Tao.Zhou1@amd.com>;=
 Chai, Thomas <YiPeng.Chai@amd.com>; Li, Candice <Candice.Li@amd.com>; Yang=
, Stanley <Stanley.Yang@amd.com>
Subject: [PATCH 1/2] drm/amd/ras: Return RAS TA injection result to userspa=
ce

Return RAS TA injection result to userspace that avoid app continue to load=
 work once injection failed.

Changed from V1:
        refactor function __check_ras_ta_cmd_resp return
        ras ta corresponding error.
        return res instead of RAS_CMD__SUCCESS in function
        amdgpu_ras_submit_cmd.

Signed-off-by: Stanley.Yang <Stanley.Yang@amd.com>
---
 .../gpu/drm/amd/ras/ras_mgr/amdgpu_ras_cmd.c  |  2 +-
 drivers/gpu/drm/amd/ras/rascore/ras_psp.c     | 21 ++++++++++---------
 2 files changed, 12 insertions(+), 11 deletions(-)

diff --git a/drivers/gpu/drm/amd/ras/ras_mgr/amdgpu_ras_cmd.c b/drivers/gpu=
/drm/amd/ras/ras_mgr/amdgpu_ras_cmd.c
index c22e53e84207..ff7f9af980d5 100644
--- a/drivers/gpu/drm/amd/ras/ras_mgr/amdgpu_ras_cmd.c
+++ b/drivers/gpu/drm/amd/ras/ras_mgr/amdgpu_ras_cmd.c
@@ -288,5 +288,5 @@ int amdgpu_ras_submit_cmd(struct ras_core_context *ras_=
core, struct ras_cmd_ctx
                return RAS_CMD__SUCCESS_EXEED_BUFFER;
        }

-       return RAS_CMD__SUCCESS;
+       return res;
 }
diff --git a/drivers/gpu/drm/amd/ras/rascore/ras_psp.c b/drivers/gpu/drm/am=
d/ras/rascore/ras_psp.c
index 5d556e2a7000..358f602b167d 100644
--- a/drivers/gpu/drm/amd/ras/rascore/ras_psp.c
+++ b/drivers/gpu/drm/amd/ras/rascore/ras_psp.c
@@ -317,36 +317,37 @@ static int send_psp_cmd(struct ras_core_context *ras_=
core,
        return ret;
 }

-static void __check_ras_ta_cmd_resp(struct ras_core_context *ras_core,
+static int __check_ras_ta_cmd_resp(struct ras_core_context *ras_core,
                        struct ras_ta_cmd *ras_cmd)
 {
-
        if (ras_cmd->ras_out_message.flags.err_inject_switch_disable_flag) =
{
                RAS_DEV_WARN(ras_core->dev, "ECC switch disabled\n");
                ras_cmd->ras_status =3D RAS_TA_STATUS__ERROR_RAS_NOT_AVAILA=
BLE;
-       } else if (ras_cmd->ras_out_message.flags.reg_access_failure_flag)
+       } else if (ras_cmd->ras_out_message.flags.reg_access_failure_flag) =
{
                RAS_DEV_WARN(ras_core->dev, "RAS internal register access b=
locked\n");
+               ras_cmd->ras_status =3D RAS_TA_STATUS__TEE_ERROR_ACCESS_DEN=
IED;
+       }

        switch (ras_cmd->ras_status) {
+       case RAS_TA_STATUS__SUCCESS:
+               return 0;
        case RAS_TA_STATUS__ERROR_UNSUPPORTED_IP:
                RAS_DEV_WARN(ras_core->dev,
                         "RAS WARNING: cmd failed due to unsupported ip\n")=
;
-               break;
+               return -EINVAL;
        case RAS_TA_STATUS__ERROR_UNSUPPORTED_ERROR_INJ:
                RAS_DEV_WARN(ras_core->dev,
                         "RAS WARNING: cmd failed due to unsupported error =
injection\n");
-               break;
-       case RAS_TA_STATUS__SUCCESS:
-               break;
+               return -EINVAL;
        case RAS_TA_STATUS__TEE_ERROR_ACCESS_DENIED:
                if (ras_cmd->cmd_id =3D=3D RAS_TA_CMD_ID__TRIGGER_ERROR)
                        RAS_DEV_WARN(ras_core->dev,
                                 "RAS WARNING: Inject error to critical reg=
ion is not allowed\n");
-               break;
+               return -EACCES;
        default:
                RAS_DEV_WARN(ras_core->dev,
                         "RAS WARNING: ras status =3D 0x%X\n", ras_cmd->ras=
_status);
-               break;
+               return -EINVAL;
        }
 }

@@ -417,7 +418,7 @@ static int send_ras_ta_runtime_cmd(struct ras_core_cont=
ext *ras_core,
        if (!ras_cmd->ras_status && out && out_size)
                memcpy(out, &ras_cmd->ras_out_message, out_size);

-       __check_ras_ta_cmd_resp(ras_core, ras_cmd);
+       ret =3D __check_ras_ta_cmd_resp(ras_core, ras_cmd);

 unlock:
        mutex_unlock(&ta_ctx->ta_mutex);
--
2.43.0

