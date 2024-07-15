Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7FC05C2BD09
	for <amd-gfx@archiver.kernel.org>; Mon, 15 Jul 2024 07:29:35 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EE8C210E077;
	Mon, 15 Jul 2024 07:29:34 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Lk6uUsUQ";
	dkim-atps=neutral
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2075.outbound.protection.outlook.com [40.107.220.75])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E391710E09D
 for <amd-gfx@lists.freedesktop.org>; Mon, 15 Jul 2024 07:29:32 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=V1vXyee0gxGt71Z0a04whxGt0wBhXQNfsfDejf+dj8DVBeLXMGHVneLOm1ks/qHBoPxTmAsb9R6z4QJ1BOmp9qK6aJi7ClsVhgUvHXWvKJ/uoAl/VQpeI5Rj2mCHPdNH+vrhg09H8SoyeIJ7c1rQxV3ua1Ouyj2LQSL8kMWk9A9Jucm9xkPAeSfmuH3dn8Artli0+94dKvW47skMLt0NsMt/vcmhPTqCTu58xgg3RDun5kDfsAMUdqnX1tDE+fJ0SM8aMb3L/BrUX8ayzkDvqh00pl7mJeda/Y+eidBPET2kXAr5iu6ymMxWuhJOqKMID7jN7E7opih/q+isXKzbzA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=38RCsQkD5qU5uBqg3pjGS1op2EQonRYUn/K2yM1UiYY=;
 b=FpbvLRiRvXen8Cs/fS3/P7CMONwnvD0U9kxT+lxyO3gSxYBR1AWnM7OqvCFz91P2f0ghx6XzjlfBhF9KDrvv9ni+LJvjdit4QkwfZzCSLi1iDD8KaeEQydZenupAPDheqauj4PRX83nN48nZ5obwk36rKKnDC0JNQjpg3ZGfpWvS4tXJvDv2Xxd26+ecZ63UTmPlr12EXPCSgSgt5Avnp8NfWbwIIizMgYOVnq29kIaIoe8Necr5qevTvyVK8MWL3pK+AcgklY81zjScgf/XDlEhSiwuqYTXO91qnALsU3CaioWs1WSPdTLx1cROACnu71aIgntkN+OZJKUL9gi4/g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=38RCsQkD5qU5uBqg3pjGS1op2EQonRYUn/K2yM1UiYY=;
 b=Lk6uUsUQe01HzFgelnMNhdfDJI4evhEV8Lwi+QyCb3suDHxMFnTqqBrgk3+JbYvaDjNaX15eukCf9LhxJbDnZi/+S5tgAevW0TQpPGQp7+I3FpWSOiR9PxE+aRsMXFNIY/aGrGeljnefNmKBnuLJeiUKYYQV5wDwPdYFLhRruIA=
Received: from BN9PR12MB5257.namprd12.prod.outlook.com (2603:10b6:408:11e::16)
 by MW6PR12MB8951.namprd12.prod.outlook.com (2603:10b6:303:244::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7762.28; Mon, 15 Jul
 2024 07:29:28 +0000
Received: from BN9PR12MB5257.namprd12.prod.outlook.com
 ([fe80::c593:f43d:c798:e009]) by BN9PR12MB5257.namprd12.prod.outlook.com
 ([fe80::c593:f43d:c798:e009%6]) with mapi id 15.20.7762.027; Mon, 15 Jul 2024
 07:29:28 +0000
From: "Zhang, Hawking" <Hawking.Zhang@amd.com>
To: "Chai, Thomas" <YiPeng.Chai@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
CC: "Zhou1, Tao" <Tao.Zhou1@amd.com>, "Li, Candice" <Candice.Li@amd.com>,
 "Wang, Yang(Kevin)" <KevinYang.Wang@amd.com>, "Yang, Stanley"
 <Stanley.Yang@amd.com>
Subject: RE: [PATCH V2] drm/amdgpu: add mutex to protect ras shared memory
Thread-Topic: [PATCH V2] drm/amdgpu: add mutex to protect ras shared memory
Thread-Index: AQHa1n3TEYUjB5mfnkiRflPntdiHY7H3ZFqA
Date: Mon, 15 Jul 2024 07:29:28 +0000
Message-ID: <BN9PR12MB525743C8C1F6E2E8B33A0CB9FCA12@BN9PR12MB5257.namprd12.prod.outlook.com>
References: <20240715060358.79736-1-YiPeng.Chai@amd.com>
In-Reply-To: <20240715060358.79736-1-YiPeng.Chai@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ActionId=c649c26f-4abf-4357-baec-8f23749fea1c;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=0;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=true;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution Only;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2024-07-15T07:29:03Z;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR12MB5257:EE_|MW6PR12MB8951:EE_
x-ms-office365-filtering-correlation-id: c89ad403-94ee-4b77-03a0-08dca49fdc31
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|1800799024|366016|376014|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?cLWdnhNmH+mNC/tr1P1booNjUbfxbLe/pbVW124umNUxGgJkSJjJjmq6bcrF?=
 =?us-ascii?Q?FCZpZ3J3aYGLxn3a8VRGy2+xMo8EGDQxJdL9h0xW4y0ipQ0cbd6eCsBloYTd?=
 =?us-ascii?Q?XuECbvmFUos8GNwy237qBxtfgziHFguSQNj+j1mcno2ilCiKUIJgYyT+Uh4O?=
 =?us-ascii?Q?eW5QnWHU09SQ7VxD6qss7wd/F+ld7Vw4tJFrOSM8httuPrkCDt7nUg/HdEz8?=
 =?us-ascii?Q?rEoOfInhIUqZCEys3KNBb9139iooDQjw9PlZCQeVAaE9mHydeENBE7cxnbp5?=
 =?us-ascii?Q?8TlWn/Lo2KEvxsOWPupIiM2RUWlpm/AHXr5/frKxGFu79DHkFQa5Yg1469Cp?=
 =?us-ascii?Q?dDnXl3/UgREPiauUOtU2V2rLr29q2asunP+cS1n/QZPErUn/NiH8qAGJocux?=
 =?us-ascii?Q?jk3bsLMuIylhBCxUxNjuOPM74IR10RvAkaNxZDpKIpSwX5h4ZlKc1eRhs1nM?=
 =?us-ascii?Q?tJiADqtKHTD5MgNvSZx47RuX/BbDPMLTtpj1xvjcQSTx46h6+xmJerUXWtYs?=
 =?us-ascii?Q?/jP5NgfMVWNk8mb0Yfg5GJ3+MInKaYeDZ3PPgJFaFHx1Wiu7kcwE4e80cvGR?=
 =?us-ascii?Q?UPbMq7K8COXamZLunDE0ydvzOmWjf+l+E8+yCNcPtJdUSxHhNZcnvvBoQfHR?=
 =?us-ascii?Q?Hrc0Vl4A+jnkMrqUL9eNUYbBP0r16JznpPDmDYg3MGzaK2XR02sQ5dgpe0TZ?=
 =?us-ascii?Q?4SmXwpjHtf4PnCrlXZ2eQf19UfUczMJT9f1m2e4aZKPz5M885vZlwLmNtMLC?=
 =?us-ascii?Q?qywYPA81KernwL9VD5re33eBGJz/ASNVHLNGQiUc2fP6A3zNaAgzPUrA7HEd?=
 =?us-ascii?Q?e7UnW2ThZ05eNZ9orRB5tusQLU5uouAaF1TxFT6g1J2YqcYFjtoqW/RqHdkE?=
 =?us-ascii?Q?DQ3p/xsZAor3tUeEg96605sEM+ib4FFGUZX29YTIj4exGjEAqKZis+/jn3f5?=
 =?us-ascii?Q?dXRLSF1yy9wQvuxk9T9QfzpQODm5E31eXNtHf3gLESPph2kk6M30rZ9v4bA5?=
 =?us-ascii?Q?k0ykuM5DS2YS7+t48qoPdBxdqR+sVsQuKBkh1hxb3yvfUHoGiGS0g1jRZMl9?=
 =?us-ascii?Q?t7R1M9JDAFpuHNgeW8Clgb4I6y76Lg9BA2e8D0aSKa/uTXloodeQszXFp9xC?=
 =?us-ascii?Q?45lyYamstItXTEu5P+NVvroF9Abu2G41NAvxVynP3F2R5rObvl9EkDxLMg//?=
 =?us-ascii?Q?UiMvcta/Axgth5NinHtuH8Z3UV9FwMCX3TlxqcNilPqgHSbhPTKQVdhaPVkQ?=
 =?us-ascii?Q?1ymUWToVyOzcRdlLQ6kmijcWcnCf1SsxsXZ17fNJ/MFosDjBgbKrE3fjhEwr?=
 =?us-ascii?Q?gTr1fs5kFVQCyQ9ZxvsOBwMe3VL7ks4sK2wJErJu49Z9UiFAE5lVSe6UpHzR?=
 =?us-ascii?Q?g3WfpYtGJ1KYQ/fOplupPY82jAVywwJ6wDKJJQmG2opctCr1ng=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5257.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(38070700018); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?0hEFjCnPk2VNj8GbmUyOuKsYR87X25xTfcCex2sjRviPgSwG2QV2ZKJtvHA3?=
 =?us-ascii?Q?EDaecka5ei8pJ+LtorvBd4EEw0SISg+/chejcn0RzkqqNp41r5MD7C57fV+U?=
 =?us-ascii?Q?5WG4EZ0ZJX7BlDpr+yqoHQXSSHLNGfE2078Byr3jsIeAHEG6HcK6fCU1Hakn?=
 =?us-ascii?Q?rLfcIxfmmCvjxT1TGJBBOEcpps9Z84M7HhfT63JhGKeo0JAnUalVUmjvmmZl?=
 =?us-ascii?Q?ZPzqwTW+IfV2IVmxcsxs+ObNlZ4Ma3FOKmS6dymQSNWdP0kB9bJiCDl0OYOk?=
 =?us-ascii?Q?SSsCRmphuLt9kaqSj2z89LUSC6NgYLN5Pf/8TRfWLTMsPPehLdEg+2xSnhj0?=
 =?us-ascii?Q?aPB75YIDkulCMf25OwAEmvfZNDvVNH0Pcd+aIX7xgyy/Srjby0cXULVyRry6?=
 =?us-ascii?Q?m3GTGenBCj8Erfuz6dQkYFkRE5dMQFNULKYsjpNLjkVbDDXJyZtFr2uoTyu2?=
 =?us-ascii?Q?fvFHOKuaZu2EqkVu7bwFmvXIzGfiFz6CoqO1TkP2pQ0SLisVxdwPh7db4YvS?=
 =?us-ascii?Q?dr+yrp6ozn/3qF2m+ywQh4ufn3YxY9rNB0Ew4zjQJ+r2A1isNrg6yTlbw/AQ?=
 =?us-ascii?Q?79i/Y4NExak8/lTZqnz/keD96fD1sjPAuNWdfFbNigB1s+MOEfMRvOtf2ORX?=
 =?us-ascii?Q?8Q1oILyahAq/QLTZwp1552bm3XBx8GsPuCdXMna6G3Ee8Emaphgiz6HsOuDA?=
 =?us-ascii?Q?oiblrPUImhod3QY086h/zDYWpRR6kkleElFz09ZjBWrF3L3qJJZTrUsMzZM1?=
 =?us-ascii?Q?QQOXEHB4Cq2DbrZT67dOdPd/O2vPV9f24kKFBjjzRtdOte8RIgIK/15+kLB1?=
 =?us-ascii?Q?6GlIzs7GGrVZy+zdowS1yF2tA4juyJibBhwudMQ+bn7yME7HH0s7v9SDfWtX?=
 =?us-ascii?Q?AlCGwaZ7qD0JhmuDvs8sSQPcnQQK3u+D+Fz2Q9jbKuormS65jNpy4mX3ZQKH?=
 =?us-ascii?Q?AI61RvWFtxyNSB2w+WSHqG+CMpWb6bhzlROq8KVg7gdnWPo7CMk9ua/RfPlX?=
 =?us-ascii?Q?PTEjfaiJf+oe3pFg7SnZWA5xHD4jN2MT8lYz89OZixzZap3lqfE6QqFygA4Q?=
 =?us-ascii?Q?DFGB7QPfJHqtFnNnRSvJL+XWEDziNDMeryN5FEjmUm20cOMcoC3nGmBcUxv5?=
 =?us-ascii?Q?cllDFAe8lD/3FOZpOIPLcoB/DetAUtU/s3wTMjbv30PUoBpa1qpVOxCkGrPL?=
 =?us-ascii?Q?uZWF3YMNlnjPxHYOpumEQKz13cYa7lTkHiqhq4ik9uoBCsh/pbNL4X5lvGaK?=
 =?us-ascii?Q?kgjcaL6z5zeHp3gTZiozwPKIEi0fyfkUzo56ndiUpRp9Zq6lc9Bl5o7wFeRs?=
 =?us-ascii?Q?nMxilukh8CvHQM2AvePiyJXdc0FKdCtuTymSnuS9FkwmebCsq9A3yk3E6ZEo?=
 =?us-ascii?Q?1T9gVliNaCg0BwsXvzC2Ne/jMRpsRBuFDbd/ps2lJS7urYaqlKm4uGKsMXXv?=
 =?us-ascii?Q?Lb5FauUybab+doY327vseRyVZ1qcqXUQEfomGVoX99rnKr2Nz+rEyqM/hKpN?=
 =?us-ascii?Q?r740Pwd5N1k9FQ9PYPM4LBVbi2hwST0sRv0JrTq3CxLEE1mIW+w4i6393l0i?=
 =?us-ascii?Q?a3jIqvuc+G9RqdyxNXc=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5257.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c89ad403-94ee-4b77-03a0-08dca49fdc31
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Jul 2024 07:29:28.0645 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: AnQzn12qTAxPpGRtQq9Ov2OsGcf88+1KrIGmVxnaJfc1VFDqWno0eiu1mopseLv6/rfXVhBFTLGxF+nttGrzwg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW6PR12MB8951
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

Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>

Regards,
Hawking
-----Original Message-----
From: Chai, Thomas <YiPeng.Chai@amd.com>
Sent: Monday, July 15, 2024 14:04
To: amd-gfx@lists.freedesktop.org
Cc: Zhang, Hawking <Hawking.Zhang@amd.com>; Zhou1, Tao <Tao.Zhou1@amd.com>;=
 Li, Candice <Candice.Li@amd.com>; Wang, Yang(Kevin) <KevinYang.Wang@amd.co=
m>; Yang, Stanley <Stanley.Yang@amd.com>; Chai, Thomas <YiPeng.Chai@amd.com=
>
Subject: [PATCH V2] drm/amdgpu: add mutex to protect ras shared memory

Add mutex to protect ras shared memory.

v2:
  Add TA_RAS_COMMAND__TRIGGER_ERROR command call
  status check.

Signed-off-by: YiPeng Chai <YiPeng.Chai@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c    | 123 ++++++++++++++-------
 drivers/gpu/drm/amd/amdgpu/amdgpu_psp.h    |   1 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_psp_ta.c |   2 +
 3 files changed, 86 insertions(+), 40 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c b/drivers/gpu/drm/amd/=
amdgpu/amdgpu_psp.c
index ba2abcf92d9c..e97a5e0ce208 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
@@ -1591,6 +1591,68 @@ static void psp_ras_ta_check_status(struct psp_conte=
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
+               if (ret || psp->cmd_buf_mem->resp.status)
+                       ret =3D -EINVAL;
+               else if (out)
+                       memcpy(out, &ras_cmd->ras_status, sizeof(ras_cmd->r=
as_status));
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
@@ -1632,23 +1694,15 @@ int psp_ras_invoke(struct psp_context *psp, uint32_=
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

@@ -1672,6 +1726,8 @@ int psp_ras_terminate(struct psp_context *psp)

        psp->ras_context.context.initialized =3D false;

+       mutex_destroy(&psp->ras_context.mutex);
+
        return ret;
 }

@@ -1756,9 +1812,10 @@ int psp_ras_initialize(struct psp_context *psp)

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

@@ -1772,12 +1829,12 @@ int psp_ras_initialize(struct psp_context *psp)  in=
t psp_ras_trigger_error(struct psp_context *psp,
                          struct ta_ras_trigger_error_input *info, uint32_t=
 instance_mask)  {
-       struct ta_ras_shared_memory *ras_cmd;
        struct amdgpu_device *adev =3D psp->adev;
        int ret;
        uint32_t dev_mask;
+       uint32_t ras_status =3D 0;

-       if (!psp->ras_context.context.initialized)
+       if (!psp->ras_context.context.initialized || !info)
                return -EINVAL;

        switch (info->block_id) {
@@ -1801,13 +1858,8 @@ int psp_ras_trigger_error(struct psp_context *psp,
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

@@ -1817,9 +1869,9 @@ int psp_ras_trigger_error(struct psp_context *psp,
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
@@ -1829,25 +1881,16 @@ int psp_ras_query_address(struct psp_context *psp,
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

