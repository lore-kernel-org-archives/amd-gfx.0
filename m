Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A36B8C433FE
	for <amd-gfx@archiver.kernel.org>; Wed, 26 Oct 2022 05:19:20 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D935310E379;
	Wed, 26 Oct 2022 05:19:19 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2052.outbound.protection.outlook.com [40.107.244.52])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 403E410E375
 for <amd-gfx@lists.freedesktop.org>; Wed, 26 Oct 2022 05:19:17 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TID9DO1PpkoTFFgdwsvsRN6Z1flYvzEyscZ4RxlHcNHoXg51YbwaUsWZ0k50LHlfE97dQzmia94GCKUojw2tSgT/azWkteUZgmHmJpafGXpuYrashtetRzJFgO0cjtpftMT2/4sMQrneOBuu4n1NW9wUeGmS7//XyKvskSFr6w1PxPeBrRntcIZDvhxQoP/Ie2FNskAlXIrB9HzQMyKp/Jh+ZEoaKD+sDk2mLbAL+1laDslaXZeVB04Sxy5PufvtDERDonPBg/l6U++JPcP1orLEkr1YoN84DjiN1O9UhD2eqEbxd517uCUyopyi1GhhpLRZy3fnKpGC7gEFMgNwZg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=m2K/0lw+tSOuDbjyyMNAEJgt61j5o6e8+kQNtCvfWHY=;
 b=koc1yeMc61DawwhWUS7EbwKBhkiHg4iPjllUt5TOwxIxGAiRS84WKD+AWYdYxMXG81fvoKI5rO9epxdbEGXhGzyWaFJRv19PAQOb7gfK1aO/03PenFtyRl5M0Qye55iwteLqPJx5CgeTyxTOcEdssXTz6dFh7rYmcxqZBbgmYeEXDrsj7xJWHt2m2vbJX3AZ1HqWBLVfLDZ6isuRpomwOt858aVjfXZRwKKIBVJvvUQlvs9vxodcUvv+Jiiw4EAygq5WuoYGS8wPIUmdsQOAtd2PU0HurBPRFjErikY33TCrI00YH98yZUQH9Mx2Pr+CafFOfreMa/SZL+PvA8PgeQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=m2K/0lw+tSOuDbjyyMNAEJgt61j5o6e8+kQNtCvfWHY=;
 b=QJjNWH2ZKD9746Uu95qsMwYUypEukEYGgaU9QnI1Dtv7TdNyz/xiSxFHB+SeWuFjS12CBUvOslw5O2MXqEkUeNkEHZqhYFHPPmH4EQLVYSE1AmIhgJfPK00dnOGDJEZbwBVl7UDxi7lArruZdshJyZVxJaHRsGeWDQksvkLzrQI=
Received: from BN9PR12MB5257.namprd12.prod.outlook.com (2603:10b6:408:11e::16)
 by PH7PR12MB5829.namprd12.prod.outlook.com (2603:10b6:510:1d4::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5723.29; Wed, 26 Oct
 2022 05:19:15 +0000
Received: from BN9PR12MB5257.namprd12.prod.outlook.com
 ([fe80::8bd7:b65c:13f4:9b]) by BN9PR12MB5257.namprd12.prod.outlook.com
 ([fe80::8bd7:b65c:13f4:9b%9]) with mapi id 15.20.5746.021; Wed, 26 Oct 2022
 05:19:15 +0000
From: "Zhang, Hawking" <Hawking.Zhang@amd.com>
To: "Li, Candice" <Candice.Li@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH 2/2] drm/amdgpu: Optimize TA load/unload/invoke debugfs
 interfaces
Thread-Topic: [PATCH 2/2] drm/amdgpu: Optimize TA load/unload/invoke debugfs
 interfaces
Thread-Index: AQHY6NUZMEqGrLeh4UWLRB/+ujSz364gINKQ
Date: Wed, 26 Oct 2022 05:19:14 +0000
Message-ID: <BN9PR12MB5257B6E5994246AE0B93ACD5FC309@BN9PR12MB5257.namprd12.prod.outlook.com>
References: <20221026005059.26249-1-candice.li@amd.com>
In-Reply-To: <20221026005059.26249-1-candice.li@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2022-10-26T05:19:12Z; 
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=c63665fb-d8d3-4873-9f84-ea0c51b59e36;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=1
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR12MB5257:EE_|PH7PR12MB5829:EE_
x-ms-office365-filtering-correlation-id: f10f523d-0ded-49e5-612e-08dab7119fd9
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: yOGp916oQqNsW+bLaW7uMz8mE7iIvyROxf8rv9CN1gDLhbPF5lQKaWcsBMlkSoFhpXDGVTsu0UUfoZ2fHUuG97zPeNppa4aqmojhSXektu3wQ1kJHEsUC5iWX+WVM6dh5kfLZMP9a8bxAA+fFUxtkbnM4Rf2S+bk5IsdsZ3NTkJ4nejr2pt2u8bHb0Q5ldjslE+h8WY94XL7EpmhduMWWLtGNtDLA45Xi0H1UGg8b+lwCw55oVCEMD45LD49NIh77aSYJYnNBMNECz3wCcO6MIqEZAtwY3JUcxolCbaNjNcqVA0Ds/aNByuu3Msd5yVVBuyPLWNTvCE+rArgBDZj2yGhEuZZJ3d/PYBv6CTMCta/FSWQDyA5UfMW3qQObSKiceDt7xptsqDWK7O8bgiSVgvDP0PRpsncnckSHZWF1K/ajl5m2Icy98SYekc20ZzgkZezbJP/zgC60qFpc+xnuOYdLyrpQXAGJRfDpunzehGtf7mu6mAad7zhppVbIJuvirQcjuS7VFcNHFZuwLtY0EOxO04sLA6ik+p5yFhK42Ph7kk8GtPyKYi2BBa8PuerG65tDrRkwKD8Eckj6Iv5PBpASXmmTF6OZ6FuSKOrvCgjbvkE0A6lfOSLQUowpt6QHTJNC2rPicUhtTRErYe/Nd8xQM/l9H2vuvi4xAD7jOVmhoNIT6ean0s5KvbeC1AU10KLQclKqxgcEHJImNGJ3kan6oG0p/AldRBEoq1viq8GJgk5ITlHcZP1xqlQlWdG16Q3Wv6Kfvmu2lPPkv3InG0e3mrOStvNbPoxP4YWClc=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5257.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230022)(4636009)(366004)(346002)(396003)(136003)(39860400002)(376002)(451199015)(41300700001)(66446008)(8676002)(76116006)(5660300002)(53546011)(316002)(38100700002)(4326008)(64756008)(86362001)(52536014)(30864003)(8936002)(7696005)(122000001)(26005)(66946007)(66476007)(9686003)(478600001)(71200400001)(6506007)(186003)(66556008)(110136005)(83380400001)(38070700005)(2906002)(33656002)(55016003)(461764006)(579004);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?TkyeCXLoZdz9Y5lKeqoH+3ROc8bShHahx2jSf2FXROBO8+JV1bKrSh12cWvp?=
 =?us-ascii?Q?hBHwlia8y1GQNNwto6N71h6LbMMWIS8PrUATX59+6A807f1X9DObdjf4EK7F?=
 =?us-ascii?Q?U3gOfApF4bATxTE4zrIAJAqu887GkIMoujZ8MkuY2SDKFFuf3CE8wlUsX41K?=
 =?us-ascii?Q?Gy7pXyztYo+XXYlCPuiHNxpuHinKy1pRfPs4nqJpGzBIiWS5uclkZcxGSSeL?=
 =?us-ascii?Q?UmgrVdunfQHZ2KSds3Y9f0gMHmdoo9XIv3R4QxrpcISn23MnDjkad4NRE/o/?=
 =?us-ascii?Q?U6eeYR1MNkxieXv0gZaoxCiNPUV+Tt+MSrM5uocsA3m8Lx3zJwXjNVFppqsN?=
 =?us-ascii?Q?hMF07S2yoCqkdi0YdJ8YYGwPVcL1CLZFoCfhnZdgLsa+odmyd1iBVrsGM1Xo?=
 =?us-ascii?Q?x3f/qxciPtIK4lBmvslAOHvZrG0r0r3Y4BDxqGLeS6C+pLrpbSOynIMnbzNP?=
 =?us-ascii?Q?wlOwFSjA2bmcdIsc/4I5LegA3DGqwESx7Pzi2mKdcQLuRxUwKNvkhRjoZ8/i?=
 =?us-ascii?Q?UI8PIUANRqIphDYoCj/m2e+c9+wJEFA8AAq81SnSRybNWGk9mWlvFHzLk0kD?=
 =?us-ascii?Q?I+5AM/kXnPNpK43P+3VFY+R7Ak5/DEe0BgMmI1z1p9Q9B7NAVXNBx4GZNPOz?=
 =?us-ascii?Q?OodlhtIk01rJBHxGcSR7GEX1paEvqnqGdoZcfA/6O7ymNLaeFsVumfquDNiP?=
 =?us-ascii?Q?J5VGJW35cBu/Kc1y+RptOVLb1uNucJP6uizQb5Gi2KqrCL42C+eCLeu3nx1Y?=
 =?us-ascii?Q?y1szr5ay4frw4fP03lS14CFrEt6EPJOpbKxJUh+eHHanUhGYQHdnpDVVxPaD?=
 =?us-ascii?Q?LNDCHY5RKL2GD1j4+B9Dm95X9MTHTPzMyt+dyv12RYZXEQIeTI8/77W62eJ1?=
 =?us-ascii?Q?FQnIy1oJv2EiAcib3w6ifPv48KLcp1gxXSR8EcWq7TGKhv56opI2Z/cSJtvz?=
 =?us-ascii?Q?Tu+iB7+NfE8y0wsSDBclMNCbhWGI4torCdtQRJ4YuuQM+8wBNio6pVh/AOh0?=
 =?us-ascii?Q?UKwOw5t5KCJtXDvxeRxQF4fzovWmONZJChJu/Qeo1lrUcgKbUYUhNmJp2m1v?=
 =?us-ascii?Q?nAPfGApEyUBtv/qO8khCLJnKq7c+Wi/NBikcYNjr2IyQ54IKW5rb5aIt6mV8?=
 =?us-ascii?Q?wd9uCsQPijszYfcHDjNKockvB8pYj01sR7Kf39YjOqvfh0xTgcf5kz++QNjt?=
 =?us-ascii?Q?PNOAHMQBErVQtmuUncgoEsH+qZy571U1zHbyG4r+CWx3k0Zl7h0XKUuKVREB?=
 =?us-ascii?Q?Tg5Lyvw1OY4fRpG/NdKRNQdAfxHvdPdFYe8by58xPqswbPiUUC0O3qlR+w4a?=
 =?us-ascii?Q?H8uu0WX5pg4gJZorGpvwUBUhXoV5ICIaPrtGAKjKsSPufxFhBK7LssSOz3nC?=
 =?us-ascii?Q?ZoDoHQIhmZMsGZg8hZX7ZLkJzUSGNET1pff5tFntZ6rmf+yVlUWxLFvbaTnf?=
 =?us-ascii?Q?WSN4yOEKCx4dOwfhkXtcxSUHyXOVeEHeFMghULS67H1YVXR09p8b+i8p110T?=
 =?us-ascii?Q?6AzNk0dD3O7+y/9exHubIiAST4pc+jC8UV3fvZB9ppTPdR49lYACWKekEFUt?=
 =?us-ascii?Q?SkmAZD+/rZQ4gYfaoK37W/x1L4lFJAGFVYYqC1II?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5257.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f10f523d-0ded-49e5-612e-08dab7119fd9
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Oct 2022 05:19:14.9872 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: DfM11aWgUBQq6ZXvBI2xlKFt0xsebodKn5lSbEqkRY+vncikF4PoXX9Szbo8e/UMicHMzIfRKXB955sJCa1+tg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB5829
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
Cc: "Li, Candice" <Candice.Li@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Official Use Only - General]

I suggest you add comments here to remind people check whether set_ta_conte=
xt_funcs is called *before* using the following macros. They seems general =
ta related interfaces but now *only* used by tools.=20

Going forward, we can a). introduce more TA type support, and b). move the =
ta_funcs initialization to psp ip early_init. In such case, people can use =
these macro anywhere in kernel driver and don't need to worry about referri=
ng to NULL pointers.

+#define psp_fn_ta_initialize(psp)=20
+((psp)->ta_funcs->fn_ta_initialze((psp)))
+#define psp_fn_ta_invoke(psp, ta_cmd_id)=20
+((psp)->ta_funcs->fn_ta_invoke((psp), (ta_cmd_id))) #define=20
+psp_fn_ta_terminate(psp) ((psp)->ta_funcs->fn_ta_terminate((psp)))
+

Apart from that, the series is

Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>

Regards,
Hawking
-----Original Message-----
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Candice =
Li
Sent: Wednesday, October 26, 2022 08:51
To: amd-gfx@lists.freedesktop.org
Cc: Li, Candice <Candice.Li@amd.com>
Subject: [PATCH 2/2] drm/amdgpu: Optimize TA load/unload/invoke debugfs int=
erfaces

1. Add a function pointer structure ta_funcs to psp context 2. Make the int=
erfaces generic to all TAs 3. Leverage exisitng TA context and remove unuse=
d functions 4. Fix return code bugs

Signed-off-by: Candice Li <candice.li@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c    |  38 +---
 drivers/gpu/drm/amd/amdgpu/amdgpu_psp.h    |  12 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_psp_ta.c | 217 +++++++++++++++------
 drivers/gpu/drm/amd/amdgpu/amdgpu_psp_ta.h |   4 +
 4 files changed, 167 insertions(+), 104 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c b/drivers/gpu/drm/amd/=
amdgpu/amdgpu_psp.c
index 643810c4148120..cdb0605d04f7cb 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
@@ -1071,42 +1071,6 @@ int psp_ta_init_shared_buf(struct psp_context *psp,
 				      &mem_ctx->shared_buf);
 }
=20
-static void psp_prep_ta_invoke_indirect_cmd_buf(struct psp_gfx_cmd_resp *c=
md,
-				       uint32_t ta_cmd_id,
-				       struct ta_context *context)
-{
-	cmd->cmd_id                         =3D GFX_CMD_ID_INVOKE_CMD;
-	cmd->cmd.cmd_invoke_cmd.session_id  =3D context->session_id;
-	cmd->cmd.cmd_invoke_cmd.ta_cmd_id   =3D ta_cmd_id;
-
-	cmd->cmd.cmd_invoke_cmd.buf.num_desc   =3D 1;
-	cmd->cmd.cmd_invoke_cmd.buf.total_size =3D context->mem_context.shared_me=
m_size;
-	cmd->cmd.cmd_invoke_cmd.buf.buf_desc[0].buf_size =3D context->mem_context=
.shared_mem_size;
-	cmd->cmd.cmd_invoke_cmd.buf.buf_desc[0].buf_phy_addr_lo =3D
-				     lower_32_bits(context->mem_context.shared_mc_addr);
-	cmd->cmd.cmd_invoke_cmd.buf.buf_desc[0].buf_phy_addr_hi =3D
-				     upper_32_bits(context->mem_context.shared_mc_addr);
-}
-
-int psp_ta_invoke_indirect(struct psp_context *psp,
-		  uint32_t ta_cmd_id,
-		  struct ta_context *context)
-{
-	int ret;
-	struct psp_gfx_cmd_resp *cmd =3D acquire_psp_cmd_buf(psp);
-
-	psp_prep_ta_invoke_indirect_cmd_buf(cmd, ta_cmd_id, context);
-
-	ret =3D psp_cmd_submit_buf(psp, NULL, cmd,
-				 psp->fence_buf_mc_addr);
-
-	context->resp_status =3D cmd->resp.status;
-
-	release_psp_cmd_buf(psp);
-
-	return ret;
-}
-
 static void psp_prep_ta_invoke_cmd_buf(struct psp_gfx_cmd_resp *cmd,
 				       uint32_t ta_cmd_id,
 				       uint32_t session_id)
@@ -1549,7 +1513,7 @@ int psp_ras_terminate(struct psp_context *psp)
 	return ret;
 }
=20
-static int psp_ras_initialize(struct psp_context *psp)
+int psp_ras_initialize(struct psp_context *psp)
 {
 	int ret;
 	uint32_t boot_cfg =3D 0xFF;
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.h b/drivers/gpu/drm/amd/=
amdgpu/amdgpu_psp.h
index 58ce3ebb446cf8..edc266f65b4e2b 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.h
@@ -136,6 +136,12 @@ struct psp_funcs
 	int (*vbflash_stat)(struct psp_context *psp);  };
=20
+struct ta_funcs {
+	int (*fn_ta_initialze)(struct psp_context *psp);
+	int (*fn_ta_invoke)(struct psp_context *psp, uint32_t ta_cmd_id);
+	int (*fn_ta_terminate)(struct psp_context *psp); };
+
 #define AMDGPU_XGMI_MAX_CONNECTED_NODES		64
 struct psp_xgmi_node_info {
 	uint64_t				node_id;
@@ -309,6 +315,7 @@ struct psp_context
 	struct psp_gfx_cmd_resp		*cmd;
=20
 	const struct psp_funcs		*funcs;
+	const struct ta_funcs		*ta_funcs;
=20
 	/* firmware buffer */
 	struct amdgpu_bo		*fw_pri_bo;
@@ -463,9 +470,6 @@ int psp_ta_load(struct psp_context *psp, struct ta_cont=
ext *context);  int psp_ta_invoke(struct psp_context *psp,
 			uint32_t ta_cmd_id,
 			struct ta_context *context);
-int psp_ta_invoke_indirect(struct psp_context *psp,
-		  uint32_t ta_cmd_id,
-		  struct ta_context *context);
=20
 int psp_xgmi_initialize(struct psp_context *psp, bool set_extended_data, b=
ool load_ta);  int psp_xgmi_terminate(struct psp_context *psp); @@ -479,7 +=
483,7 @@ int psp_xgmi_get_topology_info(struct psp_context *psp,  int psp_x=
gmi_set_topology_info(struct psp_context *psp,
 			       int number_devices,
 			       struct psp_xgmi_topology_info *topology);
-
+int psp_ras_initialize(struct psp_context *psp);
 int psp_ras_invoke(struct psp_context *psp, uint32_t ta_cmd_id);  int psp_=
ras_enable_features(struct psp_context *psp,
 		union ta_ras_cmd_input *info, bool enable); diff --git a/drivers/gpu/drm=
/amd/amdgpu/amdgpu_psp_ta.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp_ta.c
index 0988e00612e515..93e1c07861e47b 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp_ta.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp_ta.c
@@ -41,30 +41,46 @@ static uint32_t get_bin_version(const uint8_t *bin)
 	return hdr->ucode_version;
 }
=20
-static void prep_ta_mem_context(struct psp_context *psp,
-					     struct ta_context *context,
+static int prep_ta_mem_context(struct ta_mem_context *mem_context,
 					     uint8_t *shared_buf,
 					     uint32_t shared_buf_len)
 {
-	context->mem_context.shared_mem_size =3D PAGE_ALIGN(shared_buf_len);
-	psp_ta_init_shared_buf(psp, &context->mem_context);
+	if (mem_context->shared_mem_size < shared_buf_len)
+		return -EINVAL;
+	memset(mem_context->shared_buf, 0, mem_context->shared_mem_size);
+	memcpy((void *)mem_context->shared_buf, shared_buf, shared_buf_len);
=20
-	memcpy((void *)context->mem_context.shared_buf, shared_buf, shared_buf_le=
n);
+	return 0;
 }
=20
 static bool is_ta_type_valid(enum ta_type_id ta_type)  {
-	bool ret =3D false;
+	switch (ta_type) {
+	case TA_TYPE_RAS:
+		return true;
+	default:
+		return false;
+	}
+}
+
+static const struct ta_funcs ras_ta_funcs =3D {
+	.fn_ta_initialze =3D psp_ras_initialize,
+	.fn_ta_invoke    =3D psp_ras_invoke,
+	.fn_ta_terminate =3D psp_ras_terminate
+};
=20
+static void set_ta_context_funcs(struct psp_context *psp,
+						      enum ta_type_id ta_type,
+						      struct ta_context **pcontext) {
 	switch (ta_type) {
 	case TA_TYPE_RAS:
-		ret =3D true;
+		*pcontext =3D &psp->ras_context.context;
+		psp->ta_funcs =3D &ras_ta_funcs;
 		break;
 	default:
 		break;
 	}
-
-	return ret;
 }
=20
 static const struct file_operations ta_load_debugfs_fops =3D { @@ -85,8 +1=
01,7 @@ static const struct file_operations ta_invoke_debugfs_fops =3D {
 	.owner  =3D THIS_MODULE
 };
=20
-
-/**
+/*
  * DOC: AMDGPU TA debugfs interfaces
  *
  * Three debugfs interfaces can be opened by a program to @@ -111,15 +126,=
18 @@ static const struct file_operations ta_invoke_debugfs_fops =3D {
  *
  * - For TA invoke debugfs interface:
  *   Transmit buffer:
+ *    - TA type (4bytes)
  *    - TA ID (4bytes)
  *    - TA CMD ID (4bytes)
- *    - TA shard buf length (4bytes)
+ *    - TA shard buf length
+ *      (4bytes, value not beyond TA shared memory size)
  *    - TA shared buf
  *   Receive buffer:
  *    - TA shared buf
  *
  * - For TA unload debugfs interface:
  *   Transmit buffer:
+ *    - TA type (4bytes)
  *    - TA ID (4bytes)
  */
=20
@@ -131,59 +149,92 @@ static ssize_t ta_if_load_debugfs_write(struct file *=
fp, const char *buf, size_t
 	uint32_t copy_pos   =3D 0;
 	int      ret        =3D 0;
=20
-	struct amdgpu_device *adev   =3D (struct amdgpu_device *)file_inode(fp)->=
i_private;
-	struct psp_context   *psp    =3D &adev->psp;
-	struct ta_context    context =3D {0};
+	struct amdgpu_device *adev    =3D (struct amdgpu_device *)file_inode(fp)-=
>i_private;
+	struct psp_context   *psp     =3D &adev->psp;
+	struct ta_context    *context =3D NULL;
=20
 	if (!buf)
 		return -EINVAL;
=20
 	ret =3D copy_from_user((void *)&ta_type, &buf[copy_pos], sizeof(uint32_t)=
);
 	if (ret || (!is_ta_type_valid(ta_type)))
-		return -EINVAL;
+		return -EFAULT;
=20
 	copy_pos +=3D sizeof(uint32_t);
=20
 	ret =3D copy_from_user((void *)&ta_bin_len, &buf[copy_pos], sizeof(uint32=
_t));
 	if (ret)
-		return -EINVAL;
+		return -EFAULT;
=20
 	copy_pos +=3D sizeof(uint32_t);
=20
 	ta_bin =3D kzalloc(ta_bin_len, GFP_KERNEL);
 	if (!ta_bin)
-		ret =3D -ENOMEM;
+		return -ENOMEM;
 	if (copy_from_user((void *)ta_bin, &buf[copy_pos], ta_bin_len)) {
 		ret =3D -EFAULT;
 		goto err_free_bin;
 	}
=20
-	ret =3D psp_ras_terminate(psp);
-	if (ret) {
-		dev_err(adev->dev, "Failed to unload embedded RAS TA\n");
+	/* Set TA context and functions */
+	set_ta_context_funcs(psp, ta_type, &context);
+
+	if (!psp->ta_funcs || !psp->ta_funcs->fn_ta_terminate) {
+		dev_err(adev->dev, "Unsupported function to terminate TA\n");
+		ret =3D -EOPNOTSUPP;
 		goto err_free_bin;
 	}
=20
-	context.ta_type             =3D ta_type;
-	context.ta_load_type        =3D GFX_CMD_ID_LOAD_TA;
-	context.bin_desc.fw_version =3D get_bin_version(ta_bin);
-	context.bin_desc.size_bytes =3D ta_bin_len;
-	context.bin_desc.start_addr =3D ta_bin;
+	/*
+	 * Allocate TA shared buf in case shared buf was freed
+	 * due to loading TA failed before.
+	 */
+	if (!context->mem_context.shared_buf) {
+		ret =3D psp_ta_init_shared_buf(psp, &context->mem_context);
+		if (ret) {
+			ret =3D -ENOMEM;
+			goto err_free_bin;
+		}
+	}
+
+	ret =3D psp_fn_ta_terminate(psp);
+	if (ret || context->resp_status) {
+		dev_err(adev->dev,
+			"Failed to unload embedded TA (%d) and status (0x%X)\n",
+			ret, context->resp_status);
+		if (!ret)
+			ret =3D -EINVAL;
+		goto err_free_ta_shared_buf;
+	}
+
+	/* Prepare TA context for TA initialization */
+	context->ta_type                     =3D ta_type;
+	context->bin_desc.fw_version         =3D get_bin_version(ta_bin);
+	context->bin_desc.size_bytes         =3D ta_bin_len;
+	context->bin_desc.start_addr         =3D ta_bin;
=20
-	ret =3D psp_ta_load(psp, &context);
+	if (!psp->ta_funcs->fn_ta_initialze) {
+		dev_err(adev->dev, "Unsupported function to initialize TA\n");
+		ret =3D -EOPNOTSUPP;
+		goto err_free_ta_shared_buf;
+	}
=20
-	if (ret || context.resp_status) {
-		dev_err(adev->dev, "TA load via debugfs failed (%d) status %d\n",
-			 ret, context.resp_status);
+	ret =3D psp_fn_ta_initialize(psp);
+	if (ret || context->resp_status) {
+		dev_err(adev->dev, "Failed to load TA via debugfs (%d) and status (0x%X)=
\n",
+			ret, context->resp_status);
 		if (!ret)
 			ret =3D -EINVAL;
-		goto err_free_bin;
+		goto err_free_ta_shared_buf;
 	}
=20
-	context.initialized =3D true;
-	if (copy_to_user((char *)buf, (void *)&context.session_id, sizeof(uint32_=
t)))
+	if (copy_to_user((char *)buf, (void *)&context->session_id,=20
+sizeof(uint32_t)))
 		ret =3D -EFAULT;
=20
+err_free_ta_shared_buf:
+	/* Only free TA shared buf when returns error code */
+	if (ret && context->mem_context.shared_buf)
+		psp_ta_free_shared_buf(&context->mem_context);
 err_free_bin:
 	kfree(ta_bin);
=20
@@ -192,58 +243,85 @@ static ssize_t ta_if_load_debugfs_write(struct file *=
fp, const char *buf, size_t
=20
 static ssize_t ta_if_unload_debugfs_write(struct file *fp, const char *buf=
, size_t len, loff_t *off)  {
-	uint32_t ta_id  =3D 0;
-	int      ret    =3D 0;
+	uint32_t ta_type    =3D 0;
+	uint32_t ta_id      =3D 0;
+	uint32_t copy_pos   =3D 0;
+	int      ret        =3D 0;
=20
-	struct amdgpu_device *adev   =3D (struct amdgpu_device *)file_inode(fp)->=
i_private;
-	struct psp_context   *psp    =3D &adev->psp;
-	struct ta_context    context =3D {0};
+	struct amdgpu_device *adev    =3D (struct amdgpu_device *)file_inode(fp)-=
>i_private;
+	struct psp_context   *psp     =3D &adev->psp;
+	struct ta_context    *context =3D NULL;
=20
 	if (!buf)
 		return -EINVAL;
=20
-	ret =3D copy_from_user((void *)&ta_id, buf, sizeof(uint32_t));
+	ret =3D copy_from_user((void *)&ta_type, &buf[copy_pos], sizeof(uint32_t)=
);
+	if (ret || (!is_ta_type_valid(ta_type)))
+		return -EFAULT;
+
+	copy_pos +=3D sizeof(uint32_t);
+
+	ret =3D copy_from_user((void *)&ta_id, &buf[copy_pos],=20
+sizeof(uint32_t));
 	if (ret)
-		return -EINVAL;
+		return -EFAULT;
=20
-	context.session_id =3D ta_id;
+	set_ta_context_funcs(psp, ta_type, &context);
+	context->session_id =3D ta_id;
=20
-	ret =3D psp_ta_unload(psp, &context);
-	if (!ret)
-		context.initialized =3D false;
+	if (!psp->ta_funcs || !psp->ta_funcs->fn_ta_terminate) {
+		dev_err(adev->dev, "Unsupported function to terminate TA\n");
+		return -EOPNOTSUPP;
+	}
+
+	ret =3D psp_fn_ta_terminate(psp);
+	if (ret || context->resp_status) {
+		dev_err(adev->dev, "Failed to unload TA via debugfs (%d) and status (0x%=
X)\n",
+			ret, context->resp_status);
+		if (!ret)
+			ret =3D -EINVAL;
+	}
+
+	if (context->mem_context.shared_buf)
+		psp_ta_free_shared_buf(&context->mem_context);
=20
 	return ret;
 }
=20
 static ssize_t ta_if_invoke_debugfs_write(struct file *fp, const char *buf=
, size_t len, loff_t *off)  {
+	uint32_t ta_type        =3D 0;
 	uint32_t ta_id          =3D 0;
 	uint32_t cmd_id         =3D 0;
 	uint32_t shared_buf_len =3D 0;
-	uint8_t	 *shared_buf    =3D NULL;
+	uint8_t *shared_buf     =3D NULL;
 	uint32_t copy_pos       =3D 0;
 	int      ret            =3D 0;
=20
-	struct amdgpu_device *adev   =3D (struct amdgpu_device *)file_inode(fp)->=
i_private;
-	struct psp_context   *psp    =3D &adev->psp;
-	struct ta_context    context =3D {0};
+	struct amdgpu_device *adev    =3D (struct amdgpu_device *)file_inode(fp)-=
>i_private;
+	struct psp_context   *psp     =3D &adev->psp;
+	struct ta_context    *context =3D NULL;
=20
 	if (!buf)
 		return -EINVAL;
=20
+	ret =3D copy_from_user((void *)&ta_type, &buf[copy_pos], sizeof(uint32_t)=
);
+	if (ret)
+		return -EFAULT;
+	copy_pos +=3D sizeof(uint32_t);
+
 	ret =3D copy_from_user((void *)&ta_id, &buf[copy_pos], sizeof(uint32_t));
 	if (ret)
-		return -EINVAL;
+		return -EFAULT;
 	copy_pos +=3D sizeof(uint32_t);
=20
 	ret =3D copy_from_user((void *)&cmd_id, &buf[copy_pos], sizeof(uint32_t))=
;
 	if (ret)
-		return -EINVAL;
+		return -EFAULT;
 	copy_pos +=3D sizeof(uint32_t);
=20
 	ret =3D copy_from_user((void *)&shared_buf_len, &buf[copy_pos], sizeof(ui=
nt32_t));
 	if (ret)
-		return -EINVAL;
+		return -EFAULT;
 	copy_pos +=3D sizeof(uint32_t);
=20
 	shared_buf =3D kzalloc(shared_buf_len, GFP_KERNEL); @@ -254,26 +332,39 @@=
 static ssize_t ta_if_invoke_debugfs_write(struct file *fp, const char *buf=
, size
 		goto err_free_shared_buf;
 	}
=20
-	context.session_id =3D ta_id;
+	set_ta_context_funcs(psp, ta_type, &context);
+
+	if (!context->initialized) {
+		dev_err(adev->dev, "TA is not initialized\n");
+		ret =3D -EINVAL;
+		goto err_free_shared_buf;
+	}
+
+	if (!psp->ta_funcs || !psp->ta_funcs->fn_ta_invoke) {
+		dev_err(adev->dev, "Unsupported function to invoke TA\n");
+		ret =3D -EOPNOTSUPP;
+		goto err_free_shared_buf;
+	}
=20
-	prep_ta_mem_context(psp, &context, shared_buf, shared_buf_len);
+	context->session_id =3D ta_id;
=20
-	ret =3D psp_ta_invoke_indirect(psp, cmd_id, &context);
+	ret =3D prep_ta_mem_context(&context->mem_context, shared_buf, shared_buf=
_len);
+	if (ret)
+		goto err_free_shared_buf;
=20
-	if (ret || context.resp_status) {
-		dev_err(adev->dev, "TA invoke via debugfs failed (%d) status %d\n",
-			 ret, context.resp_status);
-		if (!ret)
+	ret =3D psp_fn_ta_invoke(psp, cmd_id);
+	if (ret || context->resp_status) {
+		dev_err(adev->dev, "Failed to invoke TA via debugfs (%d) and status (0x%=
X)\n",
+			ret, context->resp_status);
+		if (!ret) {
 			ret =3D -EINVAL;
-		goto err_free_ta_shared_buf;
+			goto err_free_shared_buf;
+		}
 	}
=20
-	if (copy_to_user((char *)buf, context.mem_context.shared_buf, shared_buf_=
len))
+	if (copy_to_user((char *)buf, context->mem_context.shared_buf,=20
+shared_buf_len))
 		ret =3D -EFAULT;
=20
-err_free_ta_shared_buf:
-	psp_ta_free_shared_buf(&context.mem_context);
-
 err_free_shared_buf:
 	kfree(shared_buf);
=20
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp_ta.h b/drivers/gpu/drm/a=
md/amdgpu/amdgpu_psp_ta.h
index cfc1542f63ef94..21f043bd3cbfff 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp_ta.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp_ta.h
@@ -24,6 +24,10 @@
 #ifndef __AMDGPU_PSP_TA_H__
 #define __AMDGPU_PSP_TA_H__
=20
+#define psp_fn_ta_initialize(psp)=20
+((psp)->ta_funcs->fn_ta_initialze((psp)))
+#define psp_fn_ta_invoke(psp, ta_cmd_id)=20
+((psp)->ta_funcs->fn_ta_invoke((psp), (ta_cmd_id))) #define=20
+psp_fn_ta_terminate(psp) ((psp)->ta_funcs->fn_ta_terminate((psp)))
+
 void amdgpu_ta_if_debugfs_init(struct amdgpu_device *adev);
=20
 #endif
--
2.17.1
