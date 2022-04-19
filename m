Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8002BC433F5
	for <amd-gfx@archiver.kernel.org>; Tue, 19 Apr 2022 00:48:36 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0523710E07F;
	Tue, 19 Apr 2022 00:48:36 +0000 (UTC)
Received: from NAM04-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam08on2062.outbound.protection.outlook.com [40.107.102.62])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 949F010E07F
 for <amd-gfx@lists.freedesktop.org>; Tue, 19 Apr 2022 00:48:34 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IKhiYtnvrl6dkP6O14A5gEgkH9m79lb5LAtC1WjGJQphZCH2+7gu2YPa3ccuD5plcZTHkKaeLDUPK4vlaiQ2wNJPZM3MY3XqRkd20OHuqQnKbvUOaTejxC9txjvf6oMeI1yA8t1oUlz5U0OWid3oqj21+LapZyv1s3z/1FTXk9l5CJVDsBgg9NnhSOJIXhKWw7DNua+VvEaQoDYSfHkEVK/i0GvW8yV8IwoQs2ZNrtTcC0BUiG9AutmtoDYZW42PLXd6vCHAJ0WrQfrWr8xJNBvCpPMQEq+TSHy0eX5gBJYOE7wxFc7Kvt3oCP4/iTNgwcOqKlViTvdw+LlaMBEvuw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FGVNcARddW/y+++1GCRcwjsLnsOPpOaNoVV+gCd3H3U=;
 b=OmaQiYDe9rmoqQXJLIv5BcoBJmj4oDP5kqJRTFQm8y83h9JihNXV3nOZ5+wNZH+V15O07YBk/qGhrrageTWNg4HeFk/YT/R1q1L4lXfY5tdpEceSZIR0jtVLtpKMM/4t3D747dE1CNKCUILY0jj5G3Yuxb5QDMFNXsuo83Q4huW8BqE3jJ6zNutvX55VL8kJFj79MPkv/ekhgSJWrGuEXS1kUDcyC10g32GqeWdwM7QG/IMbVAUGZkgMIN4qgHAHL4Upd3R2Ukp5WHulAxt1CmsVmJKOPp+lUU1FZ17hrZQdY0T/Z8c5ym6NO3Jc4WVKNkkHy4xUxIz47JQ+ngSaRQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FGVNcARddW/y+++1GCRcwjsLnsOPpOaNoVV+gCd3H3U=;
 b=IGf0N66G29dyJ+UXPhDDyTBF68Zt3iZDvoNQ+Cs4iRP82cwvDuQF6PFOOgIkkUb4OwKq+eRlcHIi+V2umC0JjK/LiDxydBLId8K03Cnr1NjSfCRZHPu6pEOBk9dU2iAPf0oWUh/nVQlu+Lt76PPUmz3Z2Qb36hLrDC5STetfpsA=
Received: from CY4PR12MB1496.namprd12.prod.outlook.com (2603:10b6:910:10::8)
 by MW2PR12MB2523.namprd12.prod.outlook.com (2603:10b6:907:11::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5164.20; Tue, 19 Apr
 2022 00:48:31 +0000
Received: from CY4PR12MB1496.namprd12.prod.outlook.com
 ([fe80::b802:f477:9024:61a2]) by CY4PR12MB1496.namprd12.prod.outlook.com
 ([fe80::b802:f477:9024:61a2%9]) with mapi id 15.20.5164.026; Tue, 19 Apr 2022
 00:48:28 +0000
From: "Li, Candice" <Candice.Li@amd.com>
To: "Zhou1, Tao" <Tao.Zhou1@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH 1/2] drm/amdgpu: Use indirect buffer and save response
 status for TA load/invoke
Thread-Topic: [PATCH 1/2] drm/amdgpu: Use indirect buffer and save response
 status for TA load/invoke
Thread-Index: AQHYUtHIvpl8zFWV4kyq7OPMP9/IV6z1CtqAgAFWdZA=
Date: Tue, 19 Apr 2022 00:48:28 +0000
Message-ID: <CY4PR12MB14965D53439CCC6846C6BD9C91F29@CY4PR12MB1496.namprd12.prod.outlook.com>
References: <20220418030927.11320-1-candice.li@amd.com>
 <DM5PR12MB17706AD781619615A0A81B56B0F39@DM5PR12MB1770.namprd12.prod.outlook.com>
In-Reply-To: <DM5PR12MB17706AD781619615A0A81B56B0F39@DM5PR12MB1770.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Enabled=true;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SetDate=2022-04-19T00:22:09Z; 
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Method=Privileged;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Name=Public-AIP 2.0;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ActionId=0c7a7fa0-a0f5-4caa-b628-ca895968fad1;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ContentBits=1
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_enabled: true
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_setdate: 2022-04-19T00:47:00Z
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_method: Privileged
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_name: Public-AIP 2.0
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_actionid: 2eedd838-db1e-4a18-8fca-bf074976612e
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_contentbits: 0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 6c109ec4-1253-4642-8474-08da219e519d
x-ms-traffictypediagnostic: MW2PR12MB2523:EE_
x-microsoft-antispam-prvs: <MW2PR12MB25230B152D292B68F05C64E491F29@MW2PR12MB2523.namprd12.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: paTz1guCpz4VmoHRSrcwyrL9dhrITHzmKa3Sax8liB9LLtx3TqSfJnEStbeUg1ZrLl0HTGTDE6nynWZ3Gx3Ck8aQDLCp0NqKXKjfKgSTk55sijH7t7n6H5hyy0aznIPoYT93dfAprEFC+TQAF275BImSkCkVrN43fZDi/sHuQ6g/txNoD+LFSSKcYKsAkzdhimEuBbQ79H92OmjFM4KbRSe5sEAwAaeWJara+mQNrzK6Az1eQnyCucAni3MxU8bi4yecKVX1tV172umOSfDxVdZOsg2zywdX1QHSH2MkZ36Iq2DUmFeNFvq/0Jbv6z0EOq0RAbCSiFPBcWhvoPJp3nDapRE1lvu+6l9+BgcRds3qE+ebWZ+qICS5/0kx/MH64sANSGF3Dly6S29rjYRtJr0s3fPQMsOrdPIihQUxjj1abWrsBsiGZzwmsIddM+xW4rqVhYUhLQDIoneDHdMY+9KmE4SunSl2KgwgOieUwaYdhkzX7qrxLDx5TFd9Sejq29UK1HuU4iqiGEfWEiyy68UGLfH+HVdNonZaPNdJ6vtJQ1fhxXc3GVzNfnAeth771MWBErHJ+agtxpjekDW37vbE/rTUeJOqxVP/eh+0XMPh3cfcigIefBVcPjn8yhI8c+WpLq35oEJxOBv/z8MhyVZXCaAOLUl2xAL7QSMK+N7fiIjqiuHUCwqa6JKNHev5v6ViOgchPERJWj3vfaNywQ==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CY4PR12MB1496.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(4636009)(366004)(33656002)(53546011)(508600001)(52536014)(30864003)(66476007)(66556008)(66946007)(66446008)(110136005)(8936002)(316002)(83380400001)(186003)(5660300002)(4326008)(8676002)(122000001)(76116006)(64756008)(55016003)(38100700002)(86362001)(38070700005)(6506007)(9686003)(7696005)(26005)(71200400001)(2906002);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?2ihumqzbxXpaXgtAh5UAXj89AyvCBmkttPRDxtDFmDTO97oXLpnIAYuP3Let?=
 =?us-ascii?Q?n+qCjzaiMpuAJPu72cadj7ieRo/WODs8Lmf+a2IJY5qmUX1zyx40yFfdiV9i?=
 =?us-ascii?Q?pGNRGaSHbTV8nso7dyFTnZpgAKU4SJw89Uop9DGqL63tekMyvKaJmQUl+SCK?=
 =?us-ascii?Q?9kviFRb9oEftRkq2MV/wk8DTu0j2BenN3DsxnuVUGEXOoA4rQop8VfeHVokS?=
 =?us-ascii?Q?crKjEdFO15b1kR8yjBNLjjWTZZ2eXz+OPLW67uyBBXb+EC8jJrbL7lY2Iwkc?=
 =?us-ascii?Q?oqhiPtitarlyNhr6oIj5bf+WdjFKRH6nnsbcZj1qhivGq8T6JPAz1AHbuzvt?=
 =?us-ascii?Q?8xfmM8XTq3W2eiiW3H9B3B3aVAPmGml+gEnFuh78T6KeOqF+SwcpoDHBImkj?=
 =?us-ascii?Q?iGJ1R55TBjlWgUiB8A4Hh0OZbzolAm8Jj3ob4mwj3dUkxg4j689JrYfGbedG?=
 =?us-ascii?Q?1oPA9Gsti7mPyfeCcf7K1Ie9u2sX2jV/HJp9/HnSE315yTDOM5qL9ZMaicOa?=
 =?us-ascii?Q?7uwQ0n7XIvtrjiQXLmVBcBhrwaqY5DjnUO5s5z+qqQkS4IZVgg+wHu7aZUUI?=
 =?us-ascii?Q?dxs5SreEpYwWoxEnsSrKeR8M9Hi6R4l3LrEBrjTxow3BdJESyGfZjAW+OrtD?=
 =?us-ascii?Q?BXztuUkWMnjxT9Kry9hY1cflPYMIWbBB0TOVS3dHZLGv9Em/1xJxR4emx164?=
 =?us-ascii?Q?ufdz/aqc7FifiRl0wZ015aNre1o14UaPj6yNeNNA9tX6+4S6VtU2jvaPNKLp?=
 =?us-ascii?Q?GzWn7kMyjSXLnv7PFt+nYLEgx9/yosCuTmokzsvTbKCm/EKzkIsEDEXl0Es5?=
 =?us-ascii?Q?j9S0GmKiFzFs+22Oh/RKPAqLg5URJnL9MTWR/G1WHwQGdPm4UtmoNXKw1JXP?=
 =?us-ascii?Q?2mgHVYVCE9qGCyZeyFpTUeOka38VqpN8aZmFnP4Sz4JgpPCsqHzOUppmtcmc?=
 =?us-ascii?Q?Z4uqyKBrzYZUW6LuOQg306Zn/Wn439WLIdA05dyNe96o+HUDaoFOsX8cI3Lv?=
 =?us-ascii?Q?/VNdh2bGxkcXOLk5Js6uqiQhW7UeuqjPzbsfy6RLWCQO1LQ3S2rrXYuisWZ5?=
 =?us-ascii?Q?Up4Tm2WqIsKgOkrAM4A1PU4Vs2PgYJVIp95UjEMb9P7C0xU+Y8s3HIXV04o+?=
 =?us-ascii?Q?ygKQaiEMZfU9JYTVeKjHsh7MDlnKRw2EojMpc997jxIlvfEBlM+yUMKdlzYo?=
 =?us-ascii?Q?qmgFrNuENEN1O0+PSBaYNBXf4o1V1E2BTTCKKLAvIuXw9yan7GNmi67sh3kH?=
 =?us-ascii?Q?E7wKwVtwGcPDli4xepJ58NVK2LB48c783HIwbcrihCoOXtqKVwDPPADLAWdo?=
 =?us-ascii?Q?y+osm3XZLelZoFqedMLsSghzRWTD+nrPcYig6MRbTxc9UKkCsqDPXsf7RgR4?=
 =?us-ascii?Q?r2e4XnAU6RA4XoyNllVZnLMrkUG92Qc+v1SM7fFxmJxktNDe87m+CT19b5gb?=
 =?us-ascii?Q?+426OEJbf97b8Zm80tI67pmJcw7ZXlVUT1d4lv0+1wAyYn0Hgho7oHZ9y7TH?=
 =?us-ascii?Q?0rBzV3f8q/sRABPrPTs+5dPTGkyaCP0LRXsNrtnun4ZA9fv/itG5JacyHbIR?=
 =?us-ascii?Q?Urk4bahKctHxMqMsEBWNzITR/a8JufkE+Axgs46LncuGnf94rEgKJIjH4HUK?=
 =?us-ascii?Q?Z9tPZhvwcPe/jdCBwVe4WGSwvMqwV3zxuKxhNpuA1wAjvkvG4uj1z0WSB1F3?=
 =?us-ascii?Q?y+4qTbPqbqck3xIyUkDLDagkivwpM0NK+J+iSqqpN0DmnesI?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY4PR12MB1496.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6c109ec4-1253-4642-8474-08da219e519d
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Apr 2022 00:48:28.1361 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Uhwf1yCapjat7EY/7B+9TrxAeKDfNH9Q68NrbJOId/hi0HyCrGo61kXD0zjhCWKi
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW2PR12MB2523
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
Cc: "Clements, John" <John.Clements@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[Public]

Thanks for the review, I have added the change back and will submit a new o=
ne if needed.

The upcoming TA debugfs interface needs to use indirect buffer
when performing TA invoke and check psp response status for TA
load and invoke.

Signed-off-by: John Clements <john.clements@amd.com>
Signed-off-by: Candice Li <candice.li@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c | 54 +++++++++++++++++++++----
 drivers/gpu/drm/amd/amdgpu/amdgpu_psp.h | 26 ++++++++++++
 2 files changed, 72 insertions(+), 8 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c b/drivers/gpu/drm/amd/=
amdgpu/amdgpu_psp.c
index a6acec1a6155d0..f6527aa19238a8 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
@@ -46,8 +46,6 @@ static int psp_sysfs_init(struct amdgpu_device *adev);
 static void psp_sysfs_fini(struct amdgpu_device *adev);
=20
 static int psp_load_smu_fw(struct psp_context *psp);
-static int psp_ta_unload(struct psp_context *psp, struct ta_context *conte=
xt);
-static int psp_ta_load(struct psp_context *psp, struct ta_context *context=
);
 static int psp_rap_terminate(struct psp_context *psp);
 static int psp_securedisplay_terminate(struct psp_context *psp);
=20
@@ -862,7 +860,7 @@ static void psp_prep_ta_unload_cmd_buf(struct psp_gfx_c=
md_resp *cmd,
 	cmd->cmd.cmd_unload_ta.session_id =3D session_id;
 }
=20
-static int psp_ta_unload(struct psp_context *psp, struct ta_context *conte=
xt)
+int psp_ta_unload(struct psp_context *psp, struct ta_context *context)
 {
 	int ret;
 	struct psp_gfx_cmd_resp *cmd =3D acquire_psp_cmd_buf(psp);
@@ -944,7 +942,7 @@ static void psp_prep_ta_load_cmd_buf(struct psp_gfx_cmd=
_resp *cmd,
 	cmd->cmd.cmd_load_ta.cmd_buf_len =3D context->mem_context.shared_mem_size=
;
 }
=20
-static int psp_ta_init_shared_buf(struct psp_context *psp,
+int psp_ta_init_shared_buf(struct psp_context *psp,
 				  struct ta_mem_context *mem_ctx)
 {
 	/*
@@ -958,7 +956,7 @@ static int psp_ta_init_shared_buf(struct psp_context *p=
sp,
 				      &mem_ctx->shared_buf);
 }
=20
-static void psp_ta_free_shared_buf(struct ta_mem_context *mem_ctx)
+void psp_ta_free_shared_buf(struct ta_mem_context *mem_ctx)
 {
 	amdgpu_bo_free_kernel(&mem_ctx->shared_bo, &mem_ctx->shared_mc_addr,
 			      &mem_ctx->shared_buf);
@@ -969,6 +967,42 @@ static int psp_xgmi_init_shared_buf(struct psp_context=
 *psp)
 	return psp_ta_init_shared_buf(psp, &psp->xgmi_context.context.mem_context=
);
 }
=20
+static void psp_prep_ta_invoke_indirect_cmd_buf(struct psp_gfx_cmd_resp *c=
md,
+				       uint32_t ta_cmd_id,
+				       struct ta_context *context)
+{
+	cmd->cmd_id                         =3D GFX_CMD_ID_INVOKE_CMD;
+	cmd->cmd.cmd_invoke_cmd.session_id  =3D context->session_id;
+	cmd->cmd.cmd_invoke_cmd.ta_cmd_id   =3D ta_cmd_id;
+
+	cmd->cmd.cmd_invoke_cmd.buf.num_desc   =3D 1;
+	cmd->cmd.cmd_invoke_cmd.buf.total_size =3D context->mem_context.shared_me=
m_size;
+	cmd->cmd.cmd_invoke_cmd.buf.buf_desc[0].buf_size =3D context->mem_context=
.shared_mem_size;
+	cmd->cmd.cmd_invoke_cmd.buf.buf_desc[0].buf_phy_addr_lo =3D
+				     lower_32_bits(context->mem_context.shared_mc_addr);
+	cmd->cmd.cmd_invoke_cmd.buf.buf_desc[0].buf_phy_addr_hi =3D
+				     upper_32_bits(context->mem_context.shared_mc_addr);
+}
+
+int psp_ta_invoke_indirect(struct psp_context *psp,
+		  uint32_t ta_cmd_id,
+		  struct ta_context *context)
+{
+	int ret;
+	struct psp_gfx_cmd_resp *cmd =3D acquire_psp_cmd_buf(psp);
+
+	psp_prep_ta_invoke_indirect_cmd_buf(cmd, ta_cmd_id, context);
+
+	ret =3D psp_cmd_submit_buf(psp, NULL, cmd,
+				 psp->fence_buf_mc_addr);
+
+	context->resp_status =3D cmd->resp.status;
+
+	release_psp_cmd_buf(psp);
+
+	return ret;
+}
+
 static void psp_prep_ta_invoke_cmd_buf(struct psp_gfx_cmd_resp *cmd,
 				       uint32_t ta_cmd_id,
 				       uint32_t session_id)
@@ -978,7 +1012,7 @@ static void psp_prep_ta_invoke_cmd_buf(struct psp_gfx_=
cmd_resp *cmd,
 	cmd->cmd.cmd_invoke_cmd.ta_cmd_id	=3D ta_cmd_id;
 }
=20
-static int psp_ta_invoke(struct psp_context *psp,
+int psp_ta_invoke(struct psp_context *psp,
 		  uint32_t ta_cmd_id,
 		  struct ta_context *context)
 {
@@ -990,12 +1024,14 @@ static int psp_ta_invoke(struct psp_context *psp,
 	ret =3D psp_cmd_submit_buf(psp, NULL, cmd,
 				 psp->fence_buf_mc_addr);
=20
+	context->resp_status =3D cmd->resp.status;
+
 	release_psp_cmd_buf(psp);
=20
 	return ret;
 }
=20
-static int psp_ta_load(struct psp_context *psp, struct ta_context *context=
)
+int psp_ta_load(struct psp_context *psp, struct ta_context *context)
 {
 	int ret;
 	struct psp_gfx_cmd_resp *cmd;
@@ -1010,6 +1046,8 @@ static int psp_ta_load(struct psp_context *psp, struc=
t ta_context *context)
 	ret =3D psp_cmd_submit_buf(psp, NULL, cmd,
 				 psp->fence_buf_mc_addr);
=20
+	context->resp_status =3D cmd->resp.status;
+
 	if (!ret) {
 		context->session_id =3D cmd->resp.session_id;
 	}
@@ -1415,7 +1453,7 @@ int psp_ras_enable_features(struct psp_context *psp,
 	return 0;
 }
=20
-static int psp_ras_terminate(struct psp_context *psp)
+int psp_ras_terminate(struct psp_context *psp)
 {
 	int ret;
=20
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.h b/drivers/gpu/drm/amd/=
amdgpu/amdgpu_psp.h
index ff7d533eb746ce..cf8d3199b35bf0 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.h
@@ -48,6 +48,17 @@ enum psp_shared_mem_size {
 	PSP_SECUREDISPLAY_SHARED_MEM_SIZE	=3D 0x4000,
 };
=20
+enum ta_type_id {
+	TA_TYPE_XGMI =3D 1,
+	TA_TYPE_RAS,
+	TA_TYPE_HDCP,
+	TA_TYPE_DTM,
+	TA_TYPE_RAP,
+	TA_TYPE_SECUREDISPLAY,
+
+	TA_TYPE_MAX_INDEX,
+};
+
 struct psp_context;
 struct psp_xgmi_node_info;
 struct psp_xgmi_topology_info;
@@ -151,9 +162,11 @@ struct ta_mem_context {
 struct ta_context {
 	bool			initialized;
 	uint32_t		session_id;
+	uint32_t		resp_status;
 	struct ta_mem_context	mem_context;
 	struct psp_bin_desc		bin_desc;
 	enum psp_gfx_cmd_id		ta_load_type;
+	enum ta_type_id		ta_type;
 };
=20
 struct ta_cp_context {
@@ -407,6 +420,18 @@ int psp_gpu_reset(struct amdgpu_device *adev);
 int psp_update_vcn_sram(struct amdgpu_device *adev, int inst_idx,
 			uint64_t cmd_gpu_addr, int cmd_size);
=20
+int psp_ta_init_shared_buf(struct psp_context *psp,
+				  struct ta_mem_context *mem_ctx);
+void psp_ta_free_shared_buf(struct ta_mem_context *mem_ctx);
+int psp_ta_unload(struct psp_context *psp, struct ta_context *context);
+int psp_ta_load(struct psp_context *psp, struct ta_context *context);
+int psp_ta_invoke(struct psp_context *psp,
+			uint32_t ta_cmd_id,
+			struct ta_context *context);
+int psp_ta_invoke_indirect(struct psp_context *psp,
+		  uint32_t ta_cmd_id,
+		  struct ta_context *context);
+
 int psp_xgmi_initialize(struct psp_context *psp, bool set_extended_data, b=
ool load_ta);
 int psp_xgmi_terminate(struct psp_context *psp);
 int psp_xgmi_invoke(struct psp_context *psp, uint32_t ta_cmd_id);
@@ -425,6 +450,7 @@ int psp_ras_enable_features(struct psp_context *psp,
 		union ta_ras_cmd_input *info, bool enable);
 int psp_ras_trigger_error(struct psp_context *psp,
 			  struct ta_ras_trigger_error_input *info);
+int psp_ras_terminate(struct psp_context *psp);
=20
 int psp_hdcp_invoke(struct psp_context *psp, uint32_t ta_cmd_id);
 int psp_dtm_invoke(struct psp_context *psp, uint32_t ta_cmd_id);
--=20
2.17.1


Thanks,
Candice

-----Original Message-----
From: Zhou1, Tao <Tao.Zhou1@amd.com>=20
Sent: Monday, April 18, 2022 11:56 AM
To: Li, Candice <Candice.Li@amd.com>; amd-gfx@lists.freedesktop.org
Cc: Li, Candice <Candice.Li@amd.com>; Clements, John <John.Clements@amd.com=
>
Subject: RE: [PATCH 1/2] drm/amdgpu: Use indirect buffer and save response =
status for TA load/invoke

[AMD Official Use Only]



> -----Original Message-----
> From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Candic=
e
> Li
> Sent: Monday, April 18, 2022 11:09 AM
> To: amd-gfx@lists.freedesktop.org
> Cc: Li, Candice <Candice.Li@amd.com>; Clements, John
> <John.Clements@amd.com>
> Subject: [PATCH 1/2] drm/amdgpu: Use indirect buffer and save response st=
atus
> for TA load/invoke
>=20
> The upcoming TA debugfs interface needs to use indirect buffer when
> performing TA invoke and check psp response status for TA load and invoke=
.
>=20
> Signed-off-by: John Clements <john.clements@amd.com>
> Signed-off-by: Candice Li <candice.li@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c | 60 +++++++++++++++++++------
> drivers/gpu/drm/amd/amdgpu/amdgpu_psp.h | 26 +++++++++++
>  2 files changed, 72 insertions(+), 14 deletions(-)
>=20
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
> index a6acec1a6155d0..cb7e081b1ef426 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
> @@ -46,8 +46,6 @@ static int psp_sysfs_init(struct amdgpu_device *adev);
> static void psp_sysfs_fini(struct amdgpu_device *adev);
>=20
>  static int psp_load_smu_fw(struct psp_context *psp); -static int
> psp_ta_unload(struct psp_context *psp, struct ta_context *context); -stat=
ic int
> psp_ta_load(struct psp_context *psp, struct ta_context *context);  static=
 int
> psp_rap_terminate(struct psp_context *psp);  static int
> psp_securedisplay_terminate(struct psp_context *psp);
>=20
> @@ -862,7 +860,7 @@ static void psp_prep_ta_unload_cmd_buf(struct
> psp_gfx_cmd_resp *cmd,
>  	cmd->cmd.cmd_unload_ta.session_id =3D session_id;  }
>=20
> -static int psp_ta_unload(struct psp_context *psp, struct ta_context *con=
text)
> +int psp_ta_unload(struct psp_context *psp, struct ta_context *context)
>  {
>  	int ret;
>  	struct psp_gfx_cmd_resp *cmd =3D acquire_psp_cmd_buf(psp); @@ -
> 944,7 +942,7 @@ static void psp_prep_ta_load_cmd_buf(struct
> psp_gfx_cmd_resp *cmd,
>  	cmd->cmd.cmd_load_ta.cmd_buf_len =3D context-
> >mem_context.shared_mem_size;
>  }
>=20
> -static int psp_ta_init_shared_buf(struct psp_context *psp,
> +int psp_ta_init_shared_buf(struct psp_context *psp,
>  				  struct ta_mem_context *mem_ctx)
>  {
>  	/*
> @@ -958,7 +956,7 @@ static int psp_ta_init_shared_buf(struct psp_context
> *psp,
>  				      &mem_ctx->shared_buf);
>  }
>=20
> -static void psp_ta_free_shared_buf(struct ta_mem_context *mem_ctx)
> +void psp_ta_free_shared_buf(struct ta_mem_context *mem_ctx)
>  {
>  	amdgpu_bo_free_kernel(&mem_ctx->shared_bo, &mem_ctx-
> >shared_mc_addr,
>  			      &mem_ctx->shared_buf);
> @@ -969,6 +967,42 @@ static int psp_xgmi_init_shared_buf(struct psp_conte=
xt
> *psp)
>  	return psp_ta_init_shared_buf(psp, &psp-
> >xgmi_context.context.mem_context);
>  }
>=20
> +static void psp_prep_ta_invoke_indirect_cmd_buf(struct psp_gfx_cmd_resp
> *cmd,
> +				       uint32_t ta_cmd_id,
> +				       struct ta_context *context)
> +{
> +	cmd->cmd_id                         =3D GFX_CMD_ID_INVOKE_CMD;
> +	cmd->cmd.cmd_invoke_cmd.session_id  =3D context->session_id;
> +	cmd->cmd.cmd_invoke_cmd.ta_cmd_id   =3D ta_cmd_id;
> +
> +	cmd->cmd.cmd_invoke_cmd.buf.num_desc   =3D 1;
> +	cmd->cmd.cmd_invoke_cmd.buf.total_size =3D context-
> >mem_context.shared_mem_size;
> +	cmd->cmd.cmd_invoke_cmd.buf.buf_desc[0].buf_size =3D context-
> >mem_context.shared_mem_size;
> +	cmd->cmd.cmd_invoke_cmd.buf.buf_desc[0].buf_phy_addr_lo =3D
> +				     lower_32_bits(context-
> >mem_context.shared_mc_addr);
> +	cmd->cmd.cmd_invoke_cmd.buf.buf_desc[0].buf_phy_addr_hi =3D
> +				     upper_32_bits(context-
> >mem_context.shared_mc_addr);
> +}
> +
> +int psp_ta_invoke_indirect(struct psp_context *psp,
> +		  uint32_t ta_cmd_id,
> +		  struct ta_context *context)
> +{
> +	int ret;
> +	struct psp_gfx_cmd_resp *cmd =3D acquire_psp_cmd_buf(psp);
> +
> +	psp_prep_ta_invoke_indirect_cmd_buf(cmd, ta_cmd_id, context);
> +
> +	ret =3D psp_cmd_submit_buf(psp, NULL, cmd,
> +				 psp->fence_buf_mc_addr);
> +
> +	context->resp_status =3D cmd->resp.status;
> +
> +	release_psp_cmd_buf(psp);
> +
> +	return ret;
> +}
> +
>  static void psp_prep_ta_invoke_cmd_buf(struct psp_gfx_cmd_resp *cmd,
>  				       uint32_t ta_cmd_id,
>  				       uint32_t session_id)
> @@ -978,7 +1012,7 @@ static void psp_prep_ta_invoke_cmd_buf(struct
> psp_gfx_cmd_resp *cmd,
>  	cmd->cmd.cmd_invoke_cmd.ta_cmd_id	=3D ta_cmd_id;
>  }
>=20
> -static int psp_ta_invoke(struct psp_context *psp,
> +int psp_ta_invoke(struct psp_context *psp,
>  		  uint32_t ta_cmd_id,
>  		  struct ta_context *context)
>  {
> @@ -990,12 +1024,14 @@ static int psp_ta_invoke(struct psp_context *psp,
>  	ret =3D psp_cmd_submit_buf(psp, NULL, cmd,
>  				 psp->fence_buf_mc_addr);
>=20
> +	context->resp_status =3D cmd->resp.status;
> +
>  	release_psp_cmd_buf(psp);
>=20
>  	return ret;
>  }
>=20
> -static int psp_ta_load(struct psp_context *psp, struct ta_context *conte=
xt)
> +int psp_ta_load(struct psp_context *psp, struct ta_context *context)
>  {
>  	int ret;
>  	struct psp_gfx_cmd_resp *cmd;
> @@ -1010,6 +1046,8 @@ static int psp_ta_load(struct psp_context *psp, str=
uct
> ta_context *context)
>  	ret =3D psp_cmd_submit_buf(psp, NULL, cmd,
>  				 psp->fence_buf_mc_addr);
>=20
> +	context->resp_status =3D cmd->resp.status;
> +
>  	if (!ret) {
>  		context->session_id =3D cmd->resp.session_id;
>  	}
> @@ -1415,16 +1453,10 @@ int psp_ras_enable_features(struct psp_context
> *psp,
>  	return 0;
>  }
>=20
> -static int psp_ras_terminate(struct psp_context *psp)
> +int psp_ras_terminate(struct psp_context *psp)
>  {
>  	int ret;
>=20
> -	/*
> -	 * TODO: bypass the terminate in sriov for now
> -	 */
> -	if (amdgpu_sriov_vf(psp->adev))
> -		return 0;
> -

[Tao] it seems the change is unrelated to the patch.

>  	if (!psp->ras_context.context.initialized)
>  		return 0;
>=20
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.h
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.h
> index ff7d533eb746ce..cf8d3199b35bf0 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.h
> @@ -48,6 +48,17 @@ enum psp_shared_mem_size {
>  	PSP_SECUREDISPLAY_SHARED_MEM_SIZE	=3D 0x4000,
>  };
>=20
> +enum ta_type_id {
> +	TA_TYPE_XGMI =3D 1,
> +	TA_TYPE_RAS,
> +	TA_TYPE_HDCP,
> +	TA_TYPE_DTM,
> +	TA_TYPE_RAP,
> +	TA_TYPE_SECUREDISPLAY,
> +
> +	TA_TYPE_MAX_INDEX,
> +};
> +
>  struct psp_context;
>  struct psp_xgmi_node_info;
>  struct psp_xgmi_topology_info;
> @@ -151,9 +162,11 @@ struct ta_mem_context {  struct ta_context {
>  	bool			initialized;
>  	uint32_t		session_id;
> +	uint32_t		resp_status;
>  	struct ta_mem_context	mem_context;
>  	struct psp_bin_desc		bin_desc;
>  	enum psp_gfx_cmd_id		ta_load_type;
> +	enum ta_type_id		ta_type;
>  };
>=20
>  struct ta_cp_context {
> @@ -407,6 +420,18 @@ int psp_gpu_reset(struct amdgpu_device *adev);  int
> psp_update_vcn_sram(struct amdgpu_device *adev, int inst_idx,
>  			uint64_t cmd_gpu_addr, int cmd_size);
>=20
> +int psp_ta_init_shared_buf(struct psp_context *psp,
> +				  struct ta_mem_context *mem_ctx);
> +void psp_ta_free_shared_buf(struct ta_mem_context *mem_ctx); int
> +psp_ta_unload(struct psp_context *psp, struct ta_context *context); int
> +psp_ta_load(struct psp_context *psp, struct ta_context *context); int
> +psp_ta_invoke(struct psp_context *psp,
> +			uint32_t ta_cmd_id,
> +			struct ta_context *context);
> +int psp_ta_invoke_indirect(struct psp_context *psp,
> +		  uint32_t ta_cmd_id,
> +		  struct ta_context *context);
> +
>  int psp_xgmi_initialize(struct psp_context *psp, bool set_extended_data,=
 bool
> load_ta);  int psp_xgmi_terminate(struct psp_context *psp);  int
> psp_xgmi_invoke(struct psp_context *psp, uint32_t ta_cmd_id); @@ -425,6
> +450,7 @@ int psp_ras_enable_features(struct psp_context *psp,
>  		union ta_ras_cmd_input *info, bool enable);  int
> psp_ras_trigger_error(struct psp_context *psp,
>  			  struct ta_ras_trigger_error_input *info);
> +int psp_ras_terminate(struct psp_context *psp);
>=20
>  int psp_hdcp_invoke(struct psp_context *psp, uint32_t ta_cmd_id);  int
> psp_dtm_invoke(struct psp_context *psp, uint32_t ta_cmd_id);
> --
> 2.17.1
