Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 81735C4345F
	for <amd-gfx@archiver.kernel.org>; Sun, 28 Apr 2024 07:47:56 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DA1FC10F161;
	Sun, 28 Apr 2024 07:47:55 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="hZEj88mC";
	dkim-atps=neutral
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2063.outbound.protection.outlook.com [40.107.243.63])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B2B9B10F235
 for <amd-gfx@lists.freedesktop.org>; Sun, 28 Apr 2024 07:47:54 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=euFGg4PACAhsP6q1NnZcui7+TZyF348+syyRcizCYhc5yfpkPAWj+WT/wZDmDsqk3zIrBCm/a0yGYLE2c85Len+V9rDrx4MGdueZlhwbiR2O9bd4fDP+ivxa/GkQDWZbAs3Mn/xIedpxMYg8ZHsXcAja3atyZOuicTUJY9v9TXKgaaQ7vla+ZsNPa0mLieyW09YHd3AxfeQrriUV1Laa/bz5X/kFk6AB9vTn4Mc0hUvzkUYlh6ZXWtILe5AQI0uab6537LfaOpm5ZlDPAl1c0ZvkOSC4rRYKx6UjWju9tumpIqzxO+6ThlS5j6cVwl2lmwB5xFDVQfUzpPipzJjQnA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wjhNE1bofc8+coCdS4m06muCCAhtleNoZv1eUySR6Iw=;
 b=cgwm4ujD9P2HzQHSOMx2+tNo4XCMxC0ey/RLFlhQA0Dhrw0T0s0Q9AwMojfFHcPITA3GBZvjsAMJcJzkqO8joee3F09OmwcmPDHJoFDIFQmyZgJ9lkJvtqQWT14jttuN7l/7JqAK5jyH0mLw2yEvWeVAOiMQP3d3N758uyFcQBcZ2xNgtgNHqJ0ca/7vosAsjztm9BYPmYZoaBL8yVEfwbUM2YQ8VbCzi7DE+N/Wqrf/6/wg6SjR8QbiV5u359b/0bpxfr/dp5oLidjT6maC9u64YrpLsdJZPlQ7SiFadsYygrXi5N3Ov7ukxq48/uKHZ/L0sCaZ6SbFuJvbfoq7sw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wjhNE1bofc8+coCdS4m06muCCAhtleNoZv1eUySR6Iw=;
 b=hZEj88mCQGzCscZLF3ucTDwpiGzRNIlFtmpS4XHk3jkl6zlbVvEEAsOxsoLEtlwtIv4r5X0kk/qxtJbXQRwFDbTPdRVsv263LrNdcQyEYRPe4gSfDSgX6iOH27RdPDBQyFxKEwKAeMD6a/2WsaIsX9nVoClUvl43pofIS1AMdcw=
Received: from PH7PR12MB5997.namprd12.prod.outlook.com (2603:10b6:510:1d9::21)
 by MW6PR12MB8865.namprd12.prod.outlook.com (2603:10b6:303:23b::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.32; Sun, 28 Apr
 2024 07:47:52 +0000
Received: from PH7PR12MB5997.namprd12.prod.outlook.com
 ([fe80::d1a1:5993:ef75:9419]) by PH7PR12MB5997.namprd12.prod.outlook.com
 ([fe80::d1a1:5993:ef75:9419%6]) with mapi id 15.20.7519.031; Sun, 28 Apr 2024
 07:47:52 +0000
From: "Wang, Yang(Kevin)" <KevinYang.Wang@amd.com>
To: "Chai, Thomas" <YiPeng.Chai@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
CC: "Zhang, Hawking" <Hawking.Zhang@amd.com>, "Zhou1, Tao"
 <Tao.Zhou1@amd.com>, "Li, Candice" <Candice.Li@amd.com>, "Yang, Stanley"
 <Stanley.Yang@amd.com>
Subject: RE: [PATCH] drm/amdgpu: add mutex to protect ras shared memory
Thread-Topic: [PATCH] drm/amdgpu: add mutex to protect ras shared memory
Thread-Index: AQHamTrcgT4Iug6Df0e98N+sOAVHuLF9TOIg
Date: Sun, 28 Apr 2024 07:47:52 +0000
Message-ID: <PH7PR12MB599731EAE3607BA58FAEB27B82142@PH7PR12MB5997.namprd12.prod.outlook.com>
References: <20240428070801.376129-1-YiPeng.Chai@amd.com>
In-Reply-To: <20240428070801.376129-1-YiPeng.Chai@amd.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=064223ac-c921-440f-930e-c0b9b039dfe7;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=0;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2024-04-28T07:42:51Z;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR12MB5997:EE_|MW6PR12MB8865:EE_
x-ms-office365-filtering-correlation-id: 5b6a7051-63ce-4815-7775-08dc67578204
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230031|1800799015|376005|366007|38070700009;
x-microsoft-antispam-message-info: =?us-ascii?Q?O1Z1YKRZKIkxihDcFeuKeeh974mPcCFspY2s91DL7niXmOujci4QahLfuZyi?=
 =?us-ascii?Q?sgo5mk2aDO1T7YA0zZIokvtWYFFBuhisOdFCCtGO3bmLJGkmoiaYSLESS8ld?=
 =?us-ascii?Q?biGodYAE1QbgayhbtRIeUYwgC6vThDs4X8F66QIxDXndNdKgwGH8SxEjkJEu?=
 =?us-ascii?Q?Qcz3Kjz9NUtLYNcyKhugaUuK4qJ+jJowIF0mFsVBcKL29H6E5nt/bi6a8ZFk?=
 =?us-ascii?Q?B+OAsXd2JcNx/2He2kF/LrAu9ex5lJl0WcFiTEafQZYCSGXwGKFaggahTtXV?=
 =?us-ascii?Q?DpB7XLg6/oHJyqV5Zl1n3sxULTB2dP3gHga7/pgj+bZ+lqsrCxpx+Ed95mfE?=
 =?us-ascii?Q?GXw0RbVzxOlaCxHnhG2fvyuwOkYTBCiCnGqExnHo9lx2wK48fpRA9M3+VCkr?=
 =?us-ascii?Q?wk78KnrKquRKiO8dQvrVsielN0mRIu/pSMpSx+ejZt/jPixCJdFrjZ8b4NIf?=
 =?us-ascii?Q?RIcOPLgTRNhjJ/IXZvVX6F812tGE/wMWfRY47ShIXfq2DnByEv6NpvJkX0aZ?=
 =?us-ascii?Q?dbYKl7aG8mtHlVhrNvnhtQFCrs1twf7vSjh+VWQYMc8SwwpDu7SWKrJfkwl7?=
 =?us-ascii?Q?8XzIHBgXEicZBldo671ZXHAMMP6L8BmrMrIymta7MQ2duBjJdgo2o8tscD7c?=
 =?us-ascii?Q?lTehBqA8w4XB9D/qK2MTssUJJxHRoyAKmJzIj8wOEtc/yrtXNI8MX3zNIhom?=
 =?us-ascii?Q?OMW+jYgx3mKOVvJGuVGAo8JHZWK29sD7lY2NQqS+LvsLVdJ7zsjFX8BnGc5m?=
 =?us-ascii?Q?eTEF3aAQsutAIuQLOiGnFAHKY6oiBsyhDVdKTlofhIhYGIkeq0zLE6XhlSEc?=
 =?us-ascii?Q?sJ5eHW4BZVD52SZ33V3N1s9+06jQz0PnkAIHoMsN0I6BSxB1/Lqt+zFd4zo2?=
 =?us-ascii?Q?+yN3Qk+LlOo9eTlRPkT+4HtpwhBekFhuIzD6OFdJ7/rKeYUhgon68xUyf/Zb?=
 =?us-ascii?Q?/QTulhVrJcWFxwlTHRtWmx6UVuBUzSdGzIC7HkvSyhntxG4yM4NjVeq7wO1k?=
 =?us-ascii?Q?4F5q1hZmDS1h91ZkzQhUJV+NfXcav6jMHD9fQCU+Oa3qg+krl3nsbBIbqmNp?=
 =?us-ascii?Q?DRImEYA1FeapfLvWg8HjRLfIvEpgR5js6rkHUCKxAMwnOf91ilTmcY7fxnHi?=
 =?us-ascii?Q?Lsd/YO2jyDfJXtJrmPfZ+2jeQEaKht7LI6bmyDl0IgL/ofVqeLUmwXU3w5t8?=
 =?us-ascii?Q?xQQ5Rm7PtKPjyvifyHNgSMVcUzqgPHOszPan5M+8gRXrMy8ER9fBL2C6HCTh?=
 =?us-ascii?Q?pJjzXLnKfJMfBX6moMbvvd1SZOpmykAMG66wmlQ3vAWpUM0+w8NzPm5PSLMY?=
 =?us-ascii?Q?OPjdNQNyV77kO9y8o6XOVtEILbsSOmvBhPxGZ+Fw/5WSsg=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5997.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(1800799015)(376005)(366007)(38070700009); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?vV5h3z5eqMaRO26v32ZY/3dFPGlwifhitqtZucR325siKbPj6r1BgDwVm1y4?=
 =?us-ascii?Q?T8pANvgal1XC7M6Z1TxeZI+skLAajOp5Fd1gPxOVeIx2eeq0ota/A6aEIhep?=
 =?us-ascii?Q?XrOV8ntiWkrhiF59qC14ZUTNDRb9Mq56gadatGWniE2MYoFreTQXeYECEi1Z?=
 =?us-ascii?Q?cSAHrqUwdqtM1rqBeV9Z/sWTffhJfmiiPF9lv1uSpDf96wA2StCaYofjmumd?=
 =?us-ascii?Q?328LlW0VQQpGjhafZRPb/7XfMqjD6TfIySK4n5dsKDM16J4oDIWQnT/R+bKl?=
 =?us-ascii?Q?NTJ7bxMntkDqY7kwM7QNfqU8jelSPMgSwBFQyOntxQNtT4RkcMi5ipU8Sw6Z?=
 =?us-ascii?Q?UY7/2keXIYGMNXdZ/bGQg4kXakJepNiueA5cAlvR1/U0W28sHhEEm9Z5+FhJ?=
 =?us-ascii?Q?RQEz/RyJD3yhMEFBKOMf3Qd5VNZBLiB5emL/FDvXb+9WVzbZzC8RRf6DxTBZ?=
 =?us-ascii?Q?RSBz8rXJp0k5Rt4jQSj0i1kGgE3SMBcb7cBtvMvXv3sIsydndNRt0n27ttwh?=
 =?us-ascii?Q?tN3enlO0WRpw8MrTm/wQ9gAAPx+na81FcyBIL4ZvH+V0SQLMOJSHsJQE0pZG?=
 =?us-ascii?Q?nLVUBd8J6PBvPzJ8ue9J/V2fVR7PI7fpkH98Sx97SzQkpD11t48wVD7oiCbz?=
 =?us-ascii?Q?NbGJxRK2qRdYNVtRcoqG4/1ipki1ruJikvvxap6whdvKI/W340nVLozYEVKp?=
 =?us-ascii?Q?CLQGyxc6SHzY06n2i3gyw+EKg8qFCAItdCWcNEFHU8B6CcCiAGEInrl6xiC5?=
 =?us-ascii?Q?Kptq5IuROUcj/KpxlPxlvH6y31BL2wj+Ftw3/tNh85VVA/wSnLm+mkdVIv4u?=
 =?us-ascii?Q?FVwPHoEkoZQaWXwSqZZGRKNZN1ZqnkXdYSFocw2P6OVV2a2Dd8j5ZkKvo36d?=
 =?us-ascii?Q?IbIWoM193ZxZ19jFlz4MlSjNkf3nVJ8mxKxhuePEd80DPfnezRKTnupDvroG?=
 =?us-ascii?Q?/km3qNuj3WcWpal8QWeGM2pGZCZMgKN+g8Wozun78rBBym3LJKxxROHJfbmt?=
 =?us-ascii?Q?OiVoD2aPzx1J2nI1lahflgBS7mQIyKtHGDqcnm3AX99moDb+Yit/MdcjVVqn?=
 =?us-ascii?Q?T/aN6FL6tSzJpyzjo3I1NuQb4WTnIRYX5LTxloh7W3tpFeGv2WbRpCoEiEiu?=
 =?us-ascii?Q?fXrtyoLQq2wViMwmCfpOAF20AJ0/FdL0WvsVPjfP4EhYsEK52EWfxmlQz0Lp?=
 =?us-ascii?Q?M7/HK2Vghu7pSZ3/JijWhRS72Ua3qIEWYE0DWISOGxENcQV2+klw1pZncNYl?=
 =?us-ascii?Q?UT9ZlIpb2hnBf0eU0Puo4OPuba3hbxlIJeyFRaDaDwHcPOnIV0ZwpaF2TRDz?=
 =?us-ascii?Q?/CzUN+OYt0pFTTm7iEqcc/BmasLYU4LRZqK1rKH1ai5MRKlx2QSh6c2a2qGg?=
 =?us-ascii?Q?p+0v/9w/znjSzHfLS59cU0nRnmRpVxK1REYMX8GMvuzsJRNJYzCKkgAMfOwx?=
 =?us-ascii?Q?AbwA37fCF+IiE5Fg/go7n8lugW8mqfwIxMFQz2b/b5HHs0KZWaKma0kWu3Z6?=
 =?us-ascii?Q?Vh50cm6hp+/IHfv3ZqK4lTmZotEXRtjlebzx2Rhrh2LOglkU1c7qwVJ6TLcv?=
 =?us-ascii?Q?k3goPzntjRE96uRzLPA=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5997.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5b6a7051-63ce-4815-7775-08dc67578204
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Apr 2024 07:47:52.0327 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: dR4X+t6XwA6XZp9bYapOSNgDn2l82PIWkXMqU+/QxUq1+eQkDFjHaBFB8oyM8Ktz
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW6PR12MB8865
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

[AMD Official Use Only - General]

-----Original Message-----
From: Chai, Thomas <YiPeng.Chai@amd.com>
Sent: Sunday, April 28, 2024 3:08 PM
To: amd-gfx@lists.freedesktop.org
Cc: Zhang, Hawking <Hawking.Zhang@amd.com>; Zhou1, Tao <Tao.Zhou1@amd.com>;=
 Li, Candice <Candice.Li@amd.com>; Wang, Yang(Kevin) <KevinYang.Wang@amd.co=
m>; Yang, Stanley <Stanley.Yang@amd.com>; Chai, Thomas <YiPeng.Chai@amd.com=
>
Subject: [PATCH] drm/amdgpu: add mutex to protect ras shared memory

Add mutex to protect ras shared memory.

Signed-off-by: YiPeng Chai <YiPeng.Chai@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c    | 121 ++++++++++++++-------
 drivers/gpu/drm/amd/amdgpu/amdgpu_psp.h    |   1 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_psp_ta.c |   2 +
 3 files changed, 84 insertions(+), 40 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c b/drivers/gpu/drm/amd/=
amdgpu/amdgpu_psp.c
index 5583e2d1b12f..fa4fea00f6b4 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
@@ -1564,6 +1564,66 @@ static void psp_ras_ta_check_status(struct psp_conte=
xt *psp)
        }
 }

+static int psp_ras_send_cmd(struct psp_context *psp,
+               enum ras_command cmd_id, void *in, void *out) {
+       struct ta_ras_shared_memory *ras_cmd;
+       uint32_t cmd =3D cmd_id;
+       int ret =3D 0;
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
[Kevin]:
It's better to check 'ret' value first before use this 'out' data.

Best Regards,
Kevin
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
        struct ta_ras_shared_memory *ras_cmd;
@@ -1605,23 +1665,15 @@ int psp_ras_invoke(struct psp_context *psp, uint32_=
t ta_cmd_id)  int psp_ras_enable_features(struct psp_context *psp,
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

@@ -1645,6 +1697,8 @@ int psp_ras_terminate(struct psp_context *psp)

        psp->ras_context.context.initialized =3D false;

+       mutex_destroy(&psp->ras_context.mutex);
+
        return ret;
 }

@@ -1729,9 +1783,10 @@ int psp_ras_initialize(struct psp_context *psp)

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

@@ -1745,12 +1800,12 @@ int psp_ras_initialize(struct psp_context *psp)  in=
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
@@ -1774,13 +1829,8 @@ int psp_ras_trigger_error(struct psp_context *psp,
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
+                       TA_RAS_COMMAND__TRIGGER_ERROR, info, &ras_status);
        if (ret)
                return -EINVAL;

@@ -1790,9 +1840,9 @@ int psp_ras_trigger_error(struct psp_context *psp,
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
@@ -1802,25 +1852,16 @@ int psp_ras_query_address(struct psp_context *psp,
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
+                       TA_RAS_COMMAND__QUERY_ADDRESS, addr_in, addr_out);

-       return 0;
+       return ret;
 }
 // ras end

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.h b/drivers/gpu/drm/amd/=
amdgpu/amdgpu_psp.h
index ee16f134ae92..686023918ce3 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.h
@@ -197,6 +197,7 @@ struct psp_xgmi_context {  struct psp_ras_context {
        struct ta_context               context;
        struct amdgpu_ras               *ras;
+       struct mutex                    mutex;
 };

 #define MEM_TRAIN_SYSTEM_SIGNATURE             0x54534942
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp_ta.c b/drivers/gpu/drm/a=
md/amdgpu/amdgpu_psp_ta.c
index ca5c86e5f7cd..87f213f92d83 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp_ta.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp_ta.c
@@ -348,6 +348,7 @@ static ssize_t ta_if_invoke_debugfs_write(struct file *=
fp, const char *buf, size

        context->session_id =3D ta_id;

+       mutex_lock(&psp->ras_context.mutex);
        ret =3D prep_ta_mem_context(&context->mem_context, shared_buf, shar=
ed_buf_len);
        if (ret)
                goto err_free_shared_buf;
@@ -366,6 +367,7 @@ static ssize_t ta_if_invoke_debugfs_write(struct file *=
fp, const char *buf, size
                ret =3D -EFAULT;

 err_free_shared_buf:
+       mutex_unlock(&psp->ras_context.mutex);
        kfree(shared_buf);

        return ret;
--
2.34.1

