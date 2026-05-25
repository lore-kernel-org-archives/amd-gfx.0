Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 31066CD5BBF
	for <amd-gfx@archiver.kernel.org>; Mon, 25 May 2026 08:50:34 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C4E2310E51F;
	Mon, 25 May 2026 08:50:33 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="MGZIPQmE";
	dkim-atps=neutral
Received: from SA9PR02CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11013018.outbound.protection.outlook.com
 [40.93.196.18])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3AABA10E414
 for <amd-gfx@lists.freedesktop.org>; Mon, 25 May 2026 08:50:32 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dbiJ3rXQJas4bjqHd6rqXnTiOhFDwBiqubSXLnI5NTLTvwytoYdLkXc9BLG85yBBR18lKW5F9FCylb0zgvuAUiukvkfvTWoTrN59pAyU4779+Eut0qUQiHrqdMwv4cCgE3o3t+lzCBt6Is/lUX+XOn2VpVI/gl3eAV1IhX0SU7m1mtR3pV6YV9RZtCuTmf752fNvFmZj/2Epob6FXO5SQUCrykr/zKrI7qS2NXBgOU0T3kOqLW05en2D/VRNZKFseppu7yZdxozqihcnR7MCQAlMh5BRQfT9NA3EvrOBonCd7ai3q/oT7F6CCbYn6msUPS+omsiW2Jn+aRpGe0OoWg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eUrIKAY64W48wg1KghAMjeVLBsNUQTOwqs88CN6h8X8=;
 b=eoMnepXS7uSr0sMuTNMFOBZhvp2+eZzfcqZvw4mn0SOHU/3H9qDwX5lTcCdyhGZEWPGpgb1pMa/OZNMhqDfFUbIfz0opeJJG8251NWogRifTGezTV/9avaSaPl8FU/REbpz1JEOR0s+f76t1cFX4qwIZ6qKht5wezPsVHWOGYW5tgBTbrjTNAXkorDXJb3YhIJsUrBzUtvREBP9LXELbARVoSxS05AMCaXhMms0QlNSnHdxTmL1qt+JVWwBFG1GTzszhsrW0YxPNlTYVLEhsH54Hpx6aZz/tQsvDxkeOBwF2K/cfIZXk8YMpc8h6IwZJaEJZvRnkef8NUPCR3d57Ww==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eUrIKAY64W48wg1KghAMjeVLBsNUQTOwqs88CN6h8X8=;
 b=MGZIPQmEe7aYY2Tt/iEuvTDOqo/6/taSZEfjEzS6iO90E1GKHYXAhFzfgV5lG4r4IOYjMxC3PMXBXK6D23xf5bQCF61Yf0XcyDhoV+1D0gWj5rOvY0ELwNG6jrwDevgu2+62vKsVZ94XfpqvNov789PboueRmaskRdhDO1C5eKI=
Received: from BN9PR12MB5306.namprd12.prod.outlook.com (2603:10b6:408:103::12)
 by IA4PR12MB9835.namprd12.prod.outlook.com (2603:10b6:208:54f::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.48.20; Mon, 25 May
 2026 08:50:29 +0000
Received: from BN9PR12MB5306.namprd12.prod.outlook.com
 ([fe80::9976:3768:a636:3c3d]) by BN9PR12MB5306.namprd12.prod.outlook.com
 ([fe80::9976:3768:a636:3c3d%2]) with mapi id 15.21.0048.019; Mon, 25 May 2026
 08:50:29 +0000
From: "Chai, Thomas" <YiPeng.Chai@amd.com>
To: "Yang, Stanley" <Stanley.Yang@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
CC: "Zhang, Hawking" <Hawking.Zhang@amd.com>, "Zhou1, Tao"
 <Tao.Zhou1@amd.com>, "Li, Candice" <Candice.Li@amd.com>
Subject: RE: [PATCH 1/1] drm/amd/ras: Return RAS TA injection result to
 userspace
Thread-Topic: [PATCH 1/1] drm/amd/ras: Return RAS TA injection result to
 userspace
Thread-Index: AQHc7BtjHi1zchNIp0e5T1hFmP+MYbYebYdg
Date: Mon, 25 May 2026 08:50:29 +0000
Message-ID: <BN9PR12MB5306AD8575F8AA230AE56725FC0A2@BN9PR12MB5306.namprd12.prod.outlook.com>
References: <20260525075145.41818-1-Stanley.Yang@amd.com>
In-Reply-To: <20260525075145.41818-1-Stanley.Yang@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Enabled=True;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SetDate=2026-05-25T08:45:43.0000000Z;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Name=AMD General
 v26; MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_ContentBits=3;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Method=Standard
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR12MB5306:EE_|IA4PR12MB9835:EE_
x-ms-office365-filtering-correlation-id: 8c4f67af-a6c8-4cf3-dfc5-08deba3aac64
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|1800799024|366016|22082099003|18002099003|56012099003|38070700021|3023799007|11063799006;
x-microsoft-antispam-message-info: ZvGuAuMGUTiv24ImsBVUYsv/9PXqRSaCZQgR52SOYnckbIyAyapmQ+Gh0NS4Ey6lPSLw+1ntSnJHlz5nrEX2ZwoH0DykeqKqEbEk+SxOhyfm8oUE4iPcSFEQjnS/nNm0SF78GgDuV74m8BKrmVZEXay5YiaPbyB/j/MXNfytkSLaFKZoSD5SPu6hL1LP28/F7lAW2xm/SKLQ+L3WbVQxdvA/3pcj9fmfVJDiPWIogvuZCK0O8ydLeHguliGaMoZbwfecwg+RBdjE4aNuhKRQIj0jI/gXhSMRrhqSEuLtF8YfgcLIHYFC2maDFC0CFogDwxabVdyWRox9FD270VAN8OFu10Y37OrxV06nw9wkrWm9Gq/E2sRp6MT09ew1Q4QuimXiKv0/fAEs4RHhKt4RZEwwMYc0KEDp2CNPQ1CS1gorSrCts04cazr5urJr9Gwho6AAYuuoj9fsdum3hAAXJ2jF5Jqp0GVi+Uj94CpOigUYV4Xx5+VIin7s2uuqMiEbnCTE9+PBCv0lBAWf5d17DdFxi6Ysu/xQTc12NBrHqlYCVdTxkgtwFlE3+s0KuTrOzyilayCt/xP+rtNFM5BiRTjN1YhnZ1gCmjNDDLIixdnsyJqugG5T824c+y1Kto08xUjLaIJSvXwQ34aB005eyuB8ocOrBDrwuiuF2VXO2VB9c96M3hfgEUsFCgyr/xE3LO6ixzsg5yiHzkLtv68xcz8n4MWxhRJGaRuGPeYPG33bm9UpPQzidv0Ui1kl5o+d
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5306.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(22082099003)(18002099003)(56012099003)(38070700021)(3023799007)(11063799006);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?l5MfChAzmZroU2aO4BzmWqMA4r33wk2Xtg+2TSSbjd/DfRUBYGS2y4sE3Quo?=
 =?us-ascii?Q?HDyJZrsQfusSmfa4mFUJRpIfeJaLh33HyY+g3Vm7rWqr/hLrtRE/M6bEQeAA?=
 =?us-ascii?Q?peGKyppXLCM8xmjOZOL6Yo2RLRRCNplov3781Rlzy4vwIWicjgRTN0EeW0pV?=
 =?us-ascii?Q?F6IRceRJtdx4OK9zuUYULFOe4ymz35jme2DAgVMPzVwH2TDWP/2fXrCacckJ?=
 =?us-ascii?Q?QBy6QdvkOWi9krFwM8AIdrlN+9k+S0nb8kVY1xCyNsbDe096tADf33ZoVmZr?=
 =?us-ascii?Q?QThgsgSjVeQei30HsscM5IGaBFpvn5Lm+OdgbAjT3A4EKfFWya60Y1D0vr72?=
 =?us-ascii?Q?vY7VUjCmZMRx8ytINEFkAd952F3OImFNvEVuUjzMcwyzwMMr2p7TUos0RKRL?=
 =?us-ascii?Q?GYLNS7zu6d8bVNM0XiL7aMe2DkR61btq7OglkiXrxDAQ2/WohQNXTBkVbKt8?=
 =?us-ascii?Q?MFvhx7CN7hf3jZm37LcnRPheBt7c0s4T76CxxuIqDVs3dcAmTbFE3k9MllyY?=
 =?us-ascii?Q?xlJ0vxRD4H4ZU2oX94e9zjzqNaB+R0+zI4MkUM4ViwdkkZZKPFvgYKrap2B8?=
 =?us-ascii?Q?d7/GdFffgD9wlCnjZeYzvEJKgPFO1Ad0txHbau8ou00h6eWKAvx+ZbF9L4aQ?=
 =?us-ascii?Q?CIeevOwIGbEoKS7iQmRKWMhDZjXt1W7C/0xd1PVHO1mbo/TMuzj+lSljFgUF?=
 =?us-ascii?Q?S7u8jszKVBYcxxRWQNmiE0VbLs4Fl4+5jiOtWcdzImyG/+1H8VNHpPpFTZA5?=
 =?us-ascii?Q?NcaNi3QJz11+HVGmA6+PtjgD4B7pfF87su70sGBd3NdmlR2HoUjk5NeVwO3v?=
 =?us-ascii?Q?BM3pp1vr+q9NsKjAJ/7UlPChFC+VGNdbw1NlMRCZIm+vRBfGznzHSU2RpaDS?=
 =?us-ascii?Q?Z6aKadLTQrU1q4hESU42HDKLSLOdRI4G+hZ3/EhgL6N7ljWADH0zA4LkoqiY?=
 =?us-ascii?Q?5R87CE/gvuH8+pe36ssas+mJM5lMPolJg8FXl7DpVWz9Ls9u2MaXBkJQFzfO?=
 =?us-ascii?Q?y0Y7uGKlCN0nB6mKEBwxk1yyuFTiqJq/GqxFXjP9Egpe/4lOb7ZrUKaE8ZqA?=
 =?us-ascii?Q?rXPrN27lC+GKzasRHAN1UQtk8vbORBOBV/KA7oQ5x4YsXWXS8j16Qu9z+el8?=
 =?us-ascii?Q?itAm6WhCqhONKMDnltXDmBeWEqafsrAzpPVobwy7ohDRK/ycRnAwqf8EdpdW?=
 =?us-ascii?Q?HanA0cArhUbs3ZCQAk/g9U7C4knahn07wLTHReLgJFfDEXTPqvBowUeKU12Y?=
 =?us-ascii?Q?XeieTcN3l2gnKVEN4aNx7lqM2nMvL40tUdSrdVdweg98vOgYzQcKnMIb8VN3?=
 =?us-ascii?Q?haKbRG1+2zNn5ZxU6qMR/wB2wD4FjRRbp3N4kJmrEZhe6lUN3R8i95U2jQD3?=
 =?us-ascii?Q?m36NFXLp6apUb/WpFIvWDUM/zoYGbkbpL6xcO0xRcUZa9MQSL5StsV8kbSZh?=
 =?us-ascii?Q?JPVBAAImKZp3cjWTqe+4wAMNW322EbLQiwlE4bVpjNJfUcoeLgniA2AGPwFo?=
 =?us-ascii?Q?QdxoJfMpXmo7arU30WoOfB+WvRgTBuHaF9C5Wx2Km+GSoInLvaMZUDZMUWAV?=
 =?us-ascii?Q?iZIDTs8OTE+UdZFDHaA4/bbdqZE7+7gpcEaF9qkbLJTtfVe2GG1gQMn1DPkb?=
 =?us-ascii?Q?krBVu1ux4G92mZKPsuXGJ4f/3WSV9R+3L277sazBIsZf+ie0FBXSsS1fvLuo?=
 =?us-ascii?Q?LUyeqS13gjS7UPODGSxgAmvdZ+eT40z9frVHrBalArEtm961?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5306.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8c4f67af-a6c8-4cf3-dfc5-08deba3aac64
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 May 2026 08:50:29.5800 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: xV0BPNa/D6TosLz71m/70yav06Sr5EzMuOT7NHJnrXgTc0EVW8wk6NeyD6ydhuF7EL6mt/qkvqjLN6tnx/E+TQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA4PR12MB9835
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

Best Regards,
Thomas
-----Original Message-----
From: Yang, Stanley <Stanley.Yang@amd.com>
Sent: Monday, May 25, 2026 3:52 PM
To: amd-gfx@lists.freedesktop.org
Cc: Zhang, Hawking <Hawking.Zhang@amd.com>; Zhou1, Tao <Tao.Zhou1@amd.com>;=
 Chai, Thomas <YiPeng.Chai@amd.com>; Li, Candice <Candice.Li@amd.com>; Yang=
, Stanley <Stanley.Yang@amd.com>
Subject: [PATCH 1/1] drm/amd/ras: Return RAS TA injection result to userspa=
ce

Return RAS TA injection result to userspace that avoid app continue to load=
 work once injection failed.

Signed-off-by: Stanley.Yang <Stanley.Yang@amd.com>
---
 drivers/gpu/drm/amd/ras/ras_mgr/amdgpu_ras_mgr.c | 3 +++
 drivers/gpu/drm/amd/ras/rascore/ras_psp.c        | 5 +++++
 2 files changed, 8 insertions(+)

diff --git a/drivers/gpu/drm/amd/ras/ras_mgr/amdgpu_ras_mgr.c b/drivers/gpu=
/drm/amd/ras/ras_mgr/amdgpu_ras_mgr.c
index ef09a6fad659..11f01b2ec211 100644
--- a/drivers/gpu/drm/amd/ras/ras_mgr/amdgpu_ras_mgr.c
+++ b/drivers/gpu/drm/amd/ras/ras_mgr/amdgpu_ras_mgr.c
@@ -686,6 +686,9 @@ int amdgpu_ras_mgr_handle_ras_cmd(struct amdgpu_device =
*adev,
        if (!ret && !cmd_ctx->cmd_res && output && (out_size =3D=3D cmd_ctx=
->output_size))
                memcpy(output, cmd_ctx->output_buff_raw, cmd_ctx->output_si=
ze);

+       if (cmd_ctx->cmd_res && cmd_id =3D=3D RAS_CMD__INJECT_ERROR)
+               ret =3D cmd_ctx->cmd_res;
+
        kfree(cmd_ctx);

        return ret;
diff --git a/drivers/gpu/drm/amd/ras/rascore/ras_psp.c b/drivers/gpu/drm/am=
d/ras/rascore/ras_psp.c
index 5d556e2a7000..e26fe8107ac7 100644
--- a/drivers/gpu/drm/amd/ras/rascore/ras_psp.c
+++ b/drivers/gpu/drm/amd/ras/rascore/ras_psp.c
@@ -417,6 +417,11 @@ static int send_ras_ta_runtime_cmd(struct ras_core_con=
text *ras_core,
        if (!ras_cmd->ras_status && out && out_size)
                memcpy(out, &ras_cmd->ras_out_message, out_size);

+       if (ras_cmd->ras_status =3D=3D TA_RAS_STATUS__TEE_ERROR_ACCESS_DENI=
ED)
+               ret =3D -EACCES;
+       else if (ras_cmd->ras_status)
+               ret =3D -EINVAL;
+
        __check_ras_ta_cmd_resp(ras_core, ras_cmd);

[Thomas] Can we refactor __check_ras_ta_cmd_resp to return a value and assi=
gn ret =3D __check_ras_ta_cmd_resp(...), moving the above changes into the =
__check_ras_ta_cmd_resp function?

 unlock:
--
2.43.0

