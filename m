Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 32AAEC77B7A
	for <amd-gfx@archiver.kernel.org>; Tue, 30 May 2023 06:23:59 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7E34010E33B;
	Tue, 30 May 2023 06:23:58 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2088.outbound.protection.outlook.com [40.107.243.88])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9B52110E33B
 for <amd-gfx@lists.freedesktop.org>; Tue, 30 May 2023 06:23:56 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kZ5urAmoh9FLbLyCwdSlq3NZRUdVWVeL6Nf2Cdcpv+XzKR8LozWHnxxmipCxNLTWCDjnFiPWfQKqomlSyVcfSQl1xhXW/vTnPaVcH/DqzvPqkSFjatNlGWPFnwdBAVsbj3bCSQnvQ5bUUDWyShYN20AKVYnp0vO04nyWyS7VFt35q/FvAG8jfxcj6CezYIs7IcdMs2b1wCY7oGaQ2lWmzwsuz0YoU3MOpG2JTX9mHUpFruQ845lgVMQXIheOTgRdE4XUCnAlVXSOxNOo/hsD6y8iEhUMy+rEg/fqSUye+QZlmmsf+6ChVbA53h4fhcav2+7FGInUZWkPIB9yZIQgBw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2azWBz4nefOxt1HPfMpZVpxliHpUkbYpZcnqdgwtpB0=;
 b=JT1GJqFfUcytNzQRNebCmSEcsmLWPEeZIgcbqYC37ajsh88mKGmEPf3TqLCmhcMLST8QuZYTJuJuQmw3n6YbRGg6jZb4s2KRHD53PZ8/pmIvrTJwYELf4uCTCcbDJOkuqJEssiVJRSG2fyBTXiLhy8oA5PZL6/wwkkrMTOS0CQf2lTPxedBG8ZyIoHBrLr/8vcaBOu3E4hMK6Of3NA1+AHYwcqVXx/Ve3i8S4k5vLkppTQo/fPQLKQCjx9IdWGsgnBZ3ARWrEYGOAxjGdOwwwWkY8BlL0fP1loQkmyTeBhII9qBvdmhRZaetWFEx93ee6C+eWxyRzx1jOZXODLh9qw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2azWBz4nefOxt1HPfMpZVpxliHpUkbYpZcnqdgwtpB0=;
 b=qWalznUplNJmmhB5gue6tDCSiKWLfaQ8x4cRoprZqL/lL67sZD27/RZWSEJICJDYslrVI4GytscRLz1/fA7yu+oJPGvhtbiL7SFEB4qYlcbngvK7ZBElHwvWOQs9hBdf1wkGxZjCu9tM+TdxluuE20cTP6BSVtrLLCO2EW38Y7E=
Received: from DS7PR12MB6333.namprd12.prod.outlook.com (2603:10b6:8:96::15) by
 DM4PR12MB6182.namprd12.prod.outlook.com (2603:10b6:8:a8::15) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6433.22; Tue, 30 May 2023 06:23:54 +0000
Received: from DS7PR12MB6333.namprd12.prod.outlook.com
 ([fe80::bdad:6f78:dae:358c]) by DS7PR12MB6333.namprd12.prod.outlook.com
 ([fe80::bdad:6f78:dae:358c%4]) with mapi id 15.20.6433.022; Tue, 30 May 2023
 06:23:53 +0000
From: "Zhu, Jiadong" <Jiadong.Zhu@amd.com>
To: "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH 1/2] drm/amdgpu: Modify indirect buffer packages for
 resubmission
Thread-Topic: [PATCH 1/2] drm/amdgpu: Modify indirect buffer packages for
 resubmission
Thread-Index: AQHZj3AdldxIekJtjUuRZQm4VxlM9a9yX5Gg
Date: Tue, 30 May 2023 06:23:53 +0000
Message-ID: <DS7PR12MB63333AA94098FF3191BCE8FFF44B9@DS7PR12MB6333.namprd12.prod.outlook.com>
References: <20230526011846.3331119-1-jiadong.zhu@amd.com>
In-Reply-To: <20230526011846.3331119-1-jiadong.zhu@amd.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=c4cd1481-fa86-44f2-a5f1-facbacfd9cf7;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=0;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2023-05-30T06:23:17Z;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS7PR12MB6333:EE_|DM4PR12MB6182:EE_
x-ms-office365-filtering-correlation-id: 9d7a67e2-bd4f-4a7d-d6e6-08db60d670df
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: YnVW7hvXj5BNYOma7dJuXA+nFWftcXQw160Xox4J7TJmP6TgYaUfUEvUnzpQWnWihaN8s77ae9B9Y1N/ui0qHtA5iyDOAVtNACiiS7E3495G3rTODUHd10lLWBQZxjh38WglOwLrTHqYnqSAcPF8H8MHKvRrrJvLaPUhXugnffhQgtiewptefxUUZs+ZnHnyH05wumJoywkYO6fMlwt/ix2l+xAvJpWfNfyLrqMOdFQDvpI6cwjzOj3oitlqrqUujNTwIVlJ8VfzuJ1+5d53CRKOqRBM71rgDcfMZEJyRpDVCNXpebsSJ3aHghlnF3g0s1/Pqx0/8w0l4HxOvZ92YieOJhHT7sabnm+fWEvFYHjwdMANxvabJf2T+bGI0/2U219+fCyjc3tawuNyZDCLVthSBc6K4fPs7angX/m6qmuGbn27iD/DyG4c1WczWKWEaqs1ZfOrmlB0dKB8rZFMy0pkS5UTdgth/QNojYhUa51d1Q6Vaam5f1iE9Fhcp9RL/0aEh7rz1vSV1PiDVw/jjMBNpGjzZYdmz70CCcbNQPSwSXRIQ45m7y+lh0ZcI6tu9f/Zjy71LueE1xWXLYVEWML01RUmgZxrythHmGHiZTKLzLRCetikeJAl6EiNNls3
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS7PR12MB6333.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(4636009)(366004)(376002)(39860400002)(136003)(396003)(346002)(451199021)(71200400001)(478600001)(8676002)(8936002)(52536014)(5660300002)(2906002)(86362001)(33656002)(38070700005)(76116006)(66446008)(66556008)(6916009)(64756008)(66476007)(122000001)(66946007)(316002)(55016003)(38100700002)(41300700001)(6506007)(9686003)(186003)(83380400001)(53546011)(7696005);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?n/bnkVNPHa5iWBbfhU5jmdkVctog11Iy0MYkqQU2d0KIgyRgFZLNYOz0WOgA?=
 =?us-ascii?Q?dKh1Sk70VCzW+nUop0hKR4gCn0FmY8Z2AQLjprqq2KCcyKV3IG/jOH5B+2rK?=
 =?us-ascii?Q?2mf6/wvuvK8O1AkYQv/DCpNlvouPXDDMPliJbOarbKsaYndB3rz9OMXJyDMF?=
 =?us-ascii?Q?cAFq++X9z5bJkaXgiagsaOdC8JexuhYJpFlEV1zW5Ot0FfPF39+YkBwx/1F3?=
 =?us-ascii?Q?rKrkZluh54yI6yinD9vZxGWqNp3wuC66EDJXlGnRrUOhFA3ew4H7sOiV+j9Y?=
 =?us-ascii?Q?KGbw2WTWHD85ZoNj/OF8c0RHMY8/2R41zi3sKd6FWE57SERmC+LBtKWnwzAG?=
 =?us-ascii?Q?o2rEEEQ9Cdb5w6nQgvFqPeJvWt3c/I/kzteHR9XnUHusfUx4bJWZHMrYLnYG?=
 =?us-ascii?Q?uVASo5AFDQzMi+fHay/yaboMJpdgYBLPK4GuTkI1+I7KQ1inUG696Ed0qL20?=
 =?us-ascii?Q?TVbyGgWJJMIYKG0ZJwjWezs4AFT5BkdkuvqUsBm8cq+klWY8dccKMXYdDynj?=
 =?us-ascii?Q?ago09vaksSXh2J5WhX3qh0itAnh1jqtWkLXRHDYqBjTVRcJ6BAbdQSTCMXU7?=
 =?us-ascii?Q?SydjyPSLrW0gqdwKzYw2zQvUhXtiVxOfGETV0O7lp9aRsaRl+qY7OwYManpC?=
 =?us-ascii?Q?5+H7JDhzTLYS4cKD0oYYXvc8/TCt46cdwv9xXHGs+k4A4tK3KJvMBYfNnT2L?=
 =?us-ascii?Q?N1qD1fiYasgQp/VrNF/OIL12qDdxLACZbH/N2odL9MVs9W3fkhS46Ia0t7Lc?=
 =?us-ascii?Q?Cfj37jC5ZfdbmUeCBzLnigkPYokqdTFcDwLa+1OoVpM4o5S9x2qO19XsLgmu?=
 =?us-ascii?Q?ci8RL4UwCj6i87FppNBetR9iTbJLqnSgZJ3uHBsQ7zn2HRpOCk1F5Rldnh+T?=
 =?us-ascii?Q?TgvYqvHQcT6RdjwO1lWTShRwNBUvwuOe8yC8MshWOt+seOO0nObwLWOft7dJ?=
 =?us-ascii?Q?ejKehJZdjrOR06SUFd6hB0dxf+AmHx9exIQ2ylRlWH29kOvowA5F1uAvIjeP?=
 =?us-ascii?Q?WkyZFcoMpZjLiZDknWN6KxQiMOTm9zpAGCbaHbHHXnHDw+10TrKDPF8RM2A2?=
 =?us-ascii?Q?kROCULQbtD6oOLzP5Uxm4SWtgNmNFliJi/aPia98lgB9dku/lr/uvvd4xOlt?=
 =?us-ascii?Q?DQMw/NaWi7SMs41hE6zf+CKnPf+CIs/Me/6Liztt4P5NfW1nJuRYFk2o0maZ?=
 =?us-ascii?Q?rGMpAJW4F2/dgUNIaGgfos2EsLesayaqW39k1ww0MDd3plOpfH6xAzlRTWr7?=
 =?us-ascii?Q?GGKeh/l9IInSv4lPqB9RtAdhtRQudJaepvDFd6NaGH4G1MLuPMXxqtRYDqQ/?=
 =?us-ascii?Q?cCmyKscxx+7sNAaASA9F/DTrrmXE5Rf+5lZo5EnW57lkPEs+0OEZuSgjGw9D?=
 =?us-ascii?Q?tl4+hNP747Yoryv05gjJb1NFp6zDm3HEmV/42CjAKeFSiHVOKvWOfHUF4Tel?=
 =?us-ascii?Q?WRZnZ882TsId3rMSXUy0pP42ZHigF4eODfvQ5D/jiCPq6+VdQ833IWnB0dBC?=
 =?us-ascii?Q?e5tuzrtWDf+vvssUkKDc3I3uMBB4fj/r0uEcW1nFw0EvMkhP89RFED+Cwg?=
 =?us-ascii?Q?=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB6333.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9d7a67e2-bd4f-4a7d-d6e6-08db60d670df
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 May 2023 06:23:53.5517 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: SDSMbhoK7pY68UwWqA9TFRo1nzAE66V5AkBA+Wg1Asm3r32uINJW61Qp6+ncOFoUTIN5SUVJ+bxy2ZWfgBHNkw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6182
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

Ping for the series.

Thanks,
Jiadong

-----Original Message-----
From: Zhu, Jiadong <Jiadong.Zhu@amd.com>
Sent: Friday, May 26, 2023 9:19 AM
To: amd-gfx@lists.freedesktop.org
Cc: Zhu, Jiadong <Jiadong.Zhu@amd.com>
Subject: [PATCH 1/2] drm/amdgpu: Modify indirect buffer packages for resubm=
ission

From: Jiadong Zhu <Jiadong.Zhu@amd.com>

When the preempted IB frame resubmitted to cp, we need to modify the frame =
data including:
1. set PRE_RESUME 1 in CONTEXT_CONTROL.
2. use meta data(DE and CE) read from CSA in WRITE_DATA.

Add functions to save the location the first time IBs emitted and callback =
to patch the package when resubmission happens.

Signed-off-by: Jiadong Zhu <Jiadong.Zhu@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c     | 18 ++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h     |  9 +++
 drivers/gpu/drm/amd/amdgpu/amdgpu_ring_mux.c | 60 ++++++++++++++++++++  dr=
ivers/gpu/drm/amd/amdgpu/amdgpu_ring_mux.h | 15 +++++
 4 files changed, 102 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c b/drivers/gpu/drm/amd=
/amdgpu/amdgpu_ring.c
index 7429b20257a6..12ba863e69f4 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c
@@ -692,3 +692,21 @@ void amdgpu_ring_ib_end(struct amdgpu_ring *ring)
        if (ring->is_sw_ring)
                amdgpu_sw_ring_ib_end(ring);
 }
+
+void amdgpu_ring_ib_on_emit_cntl(struct amdgpu_ring *ring) {
+       if (ring->is_sw_ring)
+               amdgpu_sw_ring_ib_mark_offset(ring, AMDGPU_MUX_OFFSET_TYPE_=
CONTROL);
+}
+
+void amdgpu_ring_ib_on_emit_ce(struct amdgpu_ring *ring) {
+       if (ring->is_sw_ring)
+               amdgpu_sw_ring_ib_mark_offset(ring, AMDGPU_MUX_OFFSET_TYPE_=
CE); }
+
+void amdgpu_ring_ib_on_emit_de(struct amdgpu_ring *ring) {
+       if (ring->is_sw_ring)
+               amdgpu_sw_ring_ib_mark_offset(ring, AMDGPU_MUX_OFFSET_TYPE_=
DE); }
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h b/drivers/gpu/drm/amd=
/amdgpu/amdgpu_ring.h
index baa03527bf8b..702ce55b962a 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
@@ -229,6 +229,9 @@ struct amdgpu_ring_funcs {
        int (*preempt_ib)(struct amdgpu_ring *ring);
        void (*emit_mem_sync)(struct amdgpu_ring *ring);
        void (*emit_wave_limit)(struct amdgpu_ring *ring, bool enable);
+       void (*patch_cntl)(struct amdgpu_ring *ring, unsigned offset);
+       void (*patch_ce)(struct amdgpu_ring *ring, unsigned offset);
+       void (*patch_de)(struct amdgpu_ring *ring, unsigned offset);
 };

 struct amdgpu_ring {
@@ -323,11 +326,17 @@ struct amdgpu_ring {  #define amdgpu_ring_init_cond_e=
xec(r) (r)->funcs->init_cond_exec((r))  #define amdgpu_ring_patch_cond_exec=
(r,o) (r)->funcs->patch_cond_exec((r),(o))
 #define amdgpu_ring_preempt_ib(r) (r)->funcs->preempt_ib(r)
+#define amdgpu_ring_patch_cntl(r, o) ((r)->funcs->patch_cntl((r), (o)))
+#define amdgpu_ring_patch_ce(r, o) ((r)->funcs->patch_ce((r), (o)))
+#define amdgpu_ring_patch_de(r, o) ((r)->funcs->patch_de((r), (o)))

 unsigned int amdgpu_ring_max_ibs(enum amdgpu_ring_type type);  int amdgpu_=
ring_alloc(struct amdgpu_ring *ring, unsigned ndw);  void amdgpu_ring_ib_be=
gin(struct amdgpu_ring *ring);  void amdgpu_ring_ib_end(struct amdgpu_ring =
*ring);
+void amdgpu_ring_ib_on_emit_cntl(struct amdgpu_ring *ring); void
+amdgpu_ring_ib_on_emit_ce(struct amdgpu_ring *ring); void
+amdgpu_ring_ib_on_emit_de(struct amdgpu_ring *ring);

 void amdgpu_ring_insert_nop(struct amdgpu_ring *ring, uint32_t count);  vo=
id amdgpu_ring_generic_pad_ib(struct amdgpu_ring *ring, struct amdgpu_ib *i=
b); diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring_mux.c b/drivers/gpu=
/drm/amd/amdgpu/amdgpu_ring_mux.c
index 62079f0e3ee8..73516abef662 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring_mux.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring_mux.c
@@ -105,6 +105,16 @@ static void amdgpu_mux_resubmit_chunks(struct amdgpu_r=
ing_mux *mux)
                                amdgpu_fence_update_start_timestamp(e->ring=
,
                                                                    chunk->=
sync_seq,
                                                                    ktime_g=
et());
+                               if (chunk->sync_seq =3D=3D
+                                       le32_to_cpu(*(e->ring->fence_drv.cp=
u_addr + 2))) {
+                                       if (chunk->cntl_offset <=3D e->ring=
->buf_mask)
+                                               amdgpu_ring_patch_cntl(e->r=
ing,
+                                                                      chun=
k->cntl_offset);
+                                       if (chunk->ce_offset <=3D e->ring->=
buf_mask)
+                                               amdgpu_ring_patch_ce(e->rin=
g, chunk->ce_offset);
+                                       if (chunk->de_offset <=3D e->ring->=
buf_mask)
+                                               amdgpu_ring_patch_de(e->rin=
g, chunk->de_offset);
+                               }
                                amdgpu_ring_mux_copy_pkt_from_sw_ring(mux, =
e->ring,
                                                                      chunk=
->start,
                                                                      chunk=
->end);
@@ -407,6 +417,17 @@ void amdgpu_sw_ring_ib_end(struct amdgpu_ring *ring)
        amdgpu_ring_mux_end_ib(mux, ring);
 }

+void amdgpu_sw_ring_ib_mark_offset(struct amdgpu_ring *ring, enum
+amdgpu_ring_mux_offset_type type) {
+       struct amdgpu_device *adev =3D ring->adev;
+       struct amdgpu_ring_mux *mux =3D &adev->gfx.muxer;
+       unsigned offset;
+
+       offset =3D ring->wptr & ring->buf_mask;
+
+       amdgpu_ring_mux_ib_mark_offset(mux, ring, offset, type); }
+
 void amdgpu_ring_mux_start_ib(struct amdgpu_ring_mux *mux, struct amdgpu_r=
ing *ring)  {
        struct amdgpu_mux_entry *e;
@@ -429,6 +450,10 @@ void amdgpu_ring_mux_start_ib(struct amdgpu_ring_mux *=
mux, struct amdgpu_ring *r
        }

        chunk->start =3D ring->wptr;
+       /* the initialized value used to check if they are set by the ib su=
bmission*/
+       chunk->cntl_offset =3D ring->buf_mask + 1;
+       chunk->de_offset =3D ring->buf_mask + 1;
+       chunk->ce_offset =3D ring->buf_mask + 1;
        list_add_tail(&chunk->entry, &e->list);  }

@@ -454,6 +479,41 @@ static void scan_and_remove_signaled_chunk(struct amdg=
pu_ring_mux *mux, struct a
        }
 }

+void amdgpu_ring_mux_ib_mark_offset(struct amdgpu_ring_mux *mux,
+                                   struct amdgpu_ring *ring, u64 offset,
+                                   enum amdgpu_ring_mux_offset_type type) =
{
+       struct amdgpu_mux_entry *e;
+       struct amdgpu_mux_chunk *chunk;
+
+       e =3D amdgpu_ring_mux_sw_entry(mux, ring);
+       if (!e) {
+               DRM_ERROR("cannot find entry!\n");
+               return;
+       }
+
+       chunk =3D list_last_entry(&e->list, struct amdgpu_mux_chunk, entry)=
;
+       if (!chunk) {
+               DRM_ERROR("cannot find chunk!\n");
+               return;
+       }
+
+       switch (type) {
+       case AMDGPU_MUX_OFFSET_TYPE_CONTROL:
+               chunk->cntl_offset =3D offset;
+               break;
+       case AMDGPU_MUX_OFFSET_TYPE_DE:
+               chunk->de_offset =3D offset;
+               break;
+       case AMDGPU_MUX_OFFSET_TYPE_CE:
+               chunk->ce_offset =3D offset;
+               break;
+       default:
+               DRM_ERROR("invalid type (%d)\n", type);
+               break;
+       }
+}
+
 void amdgpu_ring_mux_end_ib(struct amdgpu_ring_mux *mux, struct amdgpu_rin=
g *ring)  {
        struct amdgpu_mux_entry *e;
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring_mux.h b/drivers/gpu/drm=
/amd/amdgpu/amdgpu_ring_mux.h
index 4be45fc14954..b22d4fb2a847 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring_mux.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring_mux.h
@@ -50,6 +50,12 @@ struct amdgpu_mux_entry {
        struct list_head        list;
 };

+enum amdgpu_ring_mux_offset_type {
+       AMDGPU_MUX_OFFSET_TYPE_CONTROL,
+       AMDGPU_MUX_OFFSET_TYPE_DE,
+       AMDGPU_MUX_OFFSET_TYPE_CE,
+};
+
 struct amdgpu_ring_mux {
        struct amdgpu_ring      *real_ring;

@@ -72,12 +78,18 @@ struct amdgpu_ring_mux {
  * @sync_seq: the fence seqno related with the saved IB.
  * @start:- start location on the software ring.
  * @end:- end location on the software ring.
+ * @control_offset:- the PRE_RESUME bit position used for resubmission.
+ * @de_offset:- the anchor in write_data for de meta of resubmission.
+ * @ce_offset:- the anchor in write_data for ce meta of resubmission.
  */
 struct amdgpu_mux_chunk {
        struct list_head        entry;
        uint32_t                sync_seq;
        u64                     start;
        u64                     end;
+       u64                     cntl_offset;
+       u64                     de_offset;
+       u64                     ce_offset;
 };

 int amdgpu_ring_mux_init(struct amdgpu_ring_mux *mux, struct amdgpu_ring *=
ring, @@ -89,6 +101,8 @@ u64 amdgpu_ring_mux_get_wptr(struct amdgpu_ring_mu=
x *mux, struct amdgpu_ring *ri
 u64 amdgpu_ring_mux_get_rptr(struct amdgpu_ring_mux *mux, struct amdgpu_ri=
ng *ring);  void amdgpu_ring_mux_start_ib(struct amdgpu_ring_mux *mux, stru=
ct amdgpu_ring *ring);  void amdgpu_ring_mux_end_ib(struct amdgpu_ring_mux =
*mux, struct amdgpu_ring *ring);
+void amdgpu_ring_mux_ib_mark_offset(struct amdgpu_ring_mux *mux, struct am=
dgpu_ring *ring,
+                                   u64 offset, enum amdgpu_ring_mux_offset=
_type type);
 bool amdgpu_mcbp_handle_trailing_fence_irq(struct amdgpu_ring_mux *mux);

 u64 amdgpu_sw_ring_get_rptr_gfx(struct amdgpu_ring *ring); @@ -97,6 +111,7=
 @@ void amdgpu_sw_ring_set_wptr_gfx(struct amdgpu_ring *ring);  void amdgp=
u_sw_ring_insert_nop(struct amdgpu_ring *ring, uint32_t count);  void amdgp=
u_sw_ring_ib_begin(struct amdgpu_ring *ring);  void amdgpu_sw_ring_ib_end(s=
truct amdgpu_ring *ring);
+void amdgpu_sw_ring_ib_mark_offset(struct amdgpu_ring *ring, enum
+amdgpu_ring_mux_offset_type type);
 const char *amdgpu_sw_ring_name(int idx);  unsigned int amdgpu_sw_ring_pri=
ority(int idx);

--
2.25.1

