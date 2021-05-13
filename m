Return-Path: <SRS0=x6gI=KI=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6DEEC433ED
	for <amd-gfx@archiver.kernel.org>; Thu, 13 May 2021 03:28:09 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9626D611CC
	for <amd-gfx@archiver.kernel.org>; Thu, 13 May 2021 03:28:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9626D611CC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 000226E80B;
	Thu, 13 May 2021 03:28:08 +0000 (UTC)
Received: from NAM02-SN1-obe.outbound.protection.outlook.com
 (mail-sn1anam02on2073.outbound.protection.outlook.com [40.107.96.73])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B0DBD6E80B
 for <amd-gfx@lists.freedesktop.org>; Thu, 13 May 2021 03:28:07 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gOZcPr7GsA3lfAuMs1/istpvUoRGXFaidsVB9MwvNM/qZo8GlMpQZ3YztKIkGPa7oZLg1+1uBk+atLgxJ/LWGUrMYUurjAtjQ4ZXvK5m7GOGRTVI8zUIUgUUI1Ak+sbB5nGTRC3qp+EIS9+h+9yKeEp6tei1VXa/9Dmm5jrnHnJd9kLirywK0muoiW+xBVP3NUMjFJ+mAkOL656Mjba1Jpe+Sz6UYc4nCQ34UhkEIC38jas+ifadrfYoid8tS0V3ertfZmwUuSd4ChYRLAjjXPYygbMNteXZlTeplQZyZwGwSV+lDmV+yNLvEgDqNuCsXEwx66UUb1JOqR6WQgZqxg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xWFt5FtJH62WHCKU6doueTEcWfb9lyB2Iz8gl0XuD50=;
 b=R0e1hCrpUelcNUFhyDWKLFyYUuAc6C2A6/wJ+5UjiSSURfLJpx8X4OCRM+V1IHT4C7GJ84UUHO2qmWHBluaiP/PseTRzCM/7ZUOmN39x0V7e2VClLyQrlarKaQqiSdcfVerYD9FVBQ5rIx42VhW9oBM4nSlk//QeSYSJt4Z9cK0+orcPto+yGkmRoFSiiK9nEnxvNKbk+u0ycU4MqBQFLcJS5jp3GyjCKC+RAkBfBhVMR/kT75VCpp3Ne3Ph7qv0C/Mtp26MP/v4sVlfk3GIh27f8wjGJdg+MSy2TcW9tNO9p3r99/vHesOuhQaIOnZVUFH6uMHtLTacWtzbb7C2Fg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xWFt5FtJH62WHCKU6doueTEcWfb9lyB2Iz8gl0XuD50=;
 b=iJ3C3pXvav6Ta3YwNEZ69iBpQcDu6VbkZqcwGCRXYLO/HpqCHqk/oUoVp4S/Hr+WjDW4rntnnbpP4ObSV53WZ89GkwFevTGKXRmA1UtQtfrP+vqQrWGbIqPlP3lKOoKnKFOrIbmZA0U1irUAh+YqEYAsu991z4xcMubusCOyTqU=
Received: from BN9PR12MB5368.namprd12.prod.outlook.com (2603:10b6:408:105::24)
 by BN9PR12MB5082.namprd12.prod.outlook.com (2603:10b6:408:133::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4129.25; Thu, 13 May
 2021 03:28:05 +0000
Received: from BN9PR12MB5368.namprd12.prod.outlook.com
 ([fe80::245d:c14d:fd99:be85]) by BN9PR12MB5368.namprd12.prod.outlook.com
 ([fe80::245d:c14d:fd99:be85%6]) with mapi id 15.20.4129.025; Thu, 13 May 2021
 03:28:05 +0000
From: "Zhang, Hawking" <Hawking.Zhang@amd.com>
To: "Chen, Jiansong (Simon)" <Jiansong.Chen@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amdgpu: remove unsafe optimization to drop preamble ib
Thread-Topic: [PATCH] drm/amdgpu: remove unsafe optimization to drop preamble
 ib
Thread-Index: AQHXR6cZtAVVKlCa1k6NfNAlu1wNAKrgwHYg
Date: Thu, 13 May 2021 03:28:05 +0000
Message-ID: <BN9PR12MB5368749BF17DED99C1E1806EFC519@BN9PR12MB5368.namprd12.prod.outlook.com>
References: <20210513032130.3069-1-Jiansong.Chen@amd.com>
In-Reply-To: <20210513032130.3069-1-Jiansong.Chen@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Enabled=true;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_SetDate=2021-05-13T03:28:03Z; 
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Method=Privileged;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Name=Public_0;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_ActionId=f15639c7-ca37-4943-b2d2-c2165c1af187;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_ContentBits=1
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [165.204.134.244]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: ed4e51d1-db0a-4ba5-7873-08d915bf1f40
x-ms-traffictypediagnostic: BN9PR12MB5082:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BN9PR12MB5082B42791C2DA946B5D49F7FC519@BN9PR12MB5082.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:4941;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: D4X5ScRXsc9+3q7QnC1IKfOucA650xYm+488pM6PF0ibRywaHSXvVA17xAzxmagjDHZKB54eMi0c1Bduwgmanm9EMa19oTeg5rSUXdvhKuhJDq2UdU+yb/O0m38kVeTwva8MZwV2RdfNfwQFWdyesceRqffRjNxWMAtOd9SXP+WWCXTTXaxx5HfC+0BnrTc+sH3qSOgi5JJPtRN1XK1eWkxEePFp8ZofySXrTn0v+ScD4/W2JmhYiAJdYDL8jekz54DSlc3jaJzLRd1gLPGRY4DMRpHdLHudgJaqfss8VCnBYnOuEvVY5xjUJT1K4+Y1EkVEzINRhajRmmg83GisUHIxrOIQT9cJnwhTCUDKvZZJAZNt++JSaqUE8Zqb3zGYyo7Q20hAiibeQpPl1e1hsZASLIE4VvG6qCmvXFFSCPXbPh9bJJCPFThK9772kgJaKfFS/KmuABs6fRkvNYE0hVP+uREOH7yMZJXR5PZLs138bgtbU/6gR7jgOPvo+h2gqvTsQ7P4wh5r9BBwh/i2BYrPaRhUqs15HGpYEKxX+7cK+q6haCXLX87zwSamTlq4gI0ybitRPcYAqLSLQMxHK43ZcSGRhwttI26mb9ydvL8=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5368.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(39860400002)(396003)(376002)(136003)(346002)(33656002)(122000001)(4326008)(55016002)(53546011)(66476007)(38100700002)(316002)(54906003)(76116006)(478600001)(2906002)(8676002)(6506007)(71200400001)(26005)(64756008)(66446008)(5660300002)(9686003)(8936002)(110136005)(86362001)(83380400001)(7696005)(52536014)(186003)(66946007)(66556008);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?JdgmIaQNQZfYyl1nuOBsyCFlTpnaQijUtamP76lTMisnPyP2TXWlisq875a7?=
 =?us-ascii?Q?WHKyZoi1dTkPRwdfYHwmXD3br/jTNQowQzRWqjQWTX1pffkyCH4S9QPBS0Ki?=
 =?us-ascii?Q?04QWFJFX51PzDBcrM/DKde0PZ2xwaaE2kybsTRLjyLOMfFdVInph3aw0hmyH?=
 =?us-ascii?Q?1gi6SHz4anCE/+FnWoDghdRBhQ/FIjStWzIZsarj3gOdOqqX53kFQQQt5r5q?=
 =?us-ascii?Q?j7NP0PShtI2WeZwY8Jctvb6ipzIbUMkqSTG8zqHJKdc7W47ZymkNHPFnWqmE?=
 =?us-ascii?Q?z3xqqPQJzY7fNjwoPAOUqPAuvDInvpVkdwbt7EBRMvqbLWIKNg43bm9Yin8t?=
 =?us-ascii?Q?q+SDsvd1ET9FLOdtQ2JkoLoeYXnIH7we6MyKv4qo8SnV0sAPgTIDsE0lx0St?=
 =?us-ascii?Q?Y8B1lbWkT+1QyRsZuwHiXRUxsbSWKrAxoo5ZyGkVeS7vUdh6Ak1KpJvH08cm?=
 =?us-ascii?Q?Cv/tItI66DyJl0s75BqGfnXqVpRbEhT38jwVPGc0xUFI3vE1OL0L/po5HV2B?=
 =?us-ascii?Q?CgPqS4K6g5rvuWuiKFae4/RK2G95EjDNlPO60k2yoo6Lm8XzNyhX6Gx/XV/c?=
 =?us-ascii?Q?gN2Z0FTPP9JoE7i39x2FzX5MaDXc/daV2rJadoNx03ScHXAA3H3DR6FMD2TU?=
 =?us-ascii?Q?1me59uFsNZ5b02yzuZQwcsqeTB2EcvAsQmBhGNvQvi0+/KT/2SlokwoPA6uI?=
 =?us-ascii?Q?VAQx64WuMFIqPyjpCnxBWbHf9RU/hd9vqCCmvOluvXwuj26nVts0K68lSi5o?=
 =?us-ascii?Q?ty850z0fRLeGrl5k9I6OJkZN5uJ4yOdU07Wu13HwZGaMn2fhE7++UaTrwq8g?=
 =?us-ascii?Q?XdMjLbZEIfV3YjxMRwqTVUi6PemlN8vTIrGi4/qgECWlEtTQiqbntCSzjXi/?=
 =?us-ascii?Q?Y8roLtg5hSUGuRxS3SSXvRjRQhTbY3ESQ/FHOKJ6Y0H/9d8YDqLcyTDSeG3t?=
 =?us-ascii?Q?cwb1Qcd9OZb21cyhptlkBh5P1eFKxMpqhFBnXAUCELSKXa87G0UhixiJwG9p?=
 =?us-ascii?Q?ffvPkrw4M88MvQ5KPcuc/BmMLasWptecShHMIv3PW9WdJhzh3Q+PqEPOTtvv?=
 =?us-ascii?Q?0Ur/YGuCu5PD5cLiaA1pLRDloZIoPtWzxsi2qe9WK3HrdGXAn2WYozVc79jC?=
 =?us-ascii?Q?+f/NhyGXCTwCfT14A4Nua0IM3KHb0B3rcRP5JO4VLhX75cUSkk2BXKKqarMB?=
 =?us-ascii?Q?APBn0Q5LLR+xAImts5mOB840Ue9BatEKSOa4fzvlUQ3ftA+WpGLHNB0gX42S?=
 =?us-ascii?Q?OV9+4G2b3inc9evnPLJt/f+Gb21FfG/vOpRM0XMZG3uNQI5nKekKioplTG2S?=
 =?us-ascii?Q?WT47qoEdfzVkOR6WdPxUX8SP?=
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5368.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ed4e51d1-db0a-4ba5-7873-08d915bf1f40
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 May 2021 03:28:05.6075 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: TNzvioXSqxcguY5lDj2laBSO7wS4PrO4y5rkxzexkytri0UF+azxSr2EzD1GiSDq4hUk3TdTmPlzjCmGdieGNg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR12MB5082
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
Cc: "Koenig, Christian" <Christian.Koenig@amd.com>, "Chen,
 Jiansong \(Simon\)" <Jiansong.Chen@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Public Use]

Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>

Regards,
Hawking
-----Original Message-----
From: Jiansong Chen <Jiansong.Chen@amd.com> 
Sent: Thursday, May 13, 2021 11:22
To: amd-gfx@lists.freedesktop.org
Cc: Zhang, Hawking <Hawking.Zhang@amd.com>; Koenig, Christian <Christian.Koenig@amd.com>; Chen, Jiansong (Simon) <Jiansong.Chen@amd.com>
Subject: [PATCH] drm/amdgpu: remove unsafe optimization to drop preamble ib

Take the situation with gfxoff, the optimization may cause corrupt CE ram contents. In addition emit_cntxcntl callback has similar optimization which firmware can handle properly even for power feature.

Signed-off-by: Jiansong Chen <Jiansong.Chen@amd.com>
Change-Id: I962946557108bb0575f8b2afc25b18a6dcf0d838
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c | 11 +----------
 1 file changed, 1 insertion(+), 10 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c
index 2e6789a7dc46..77baf9b48d67 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c
@@ -130,7 +130,7 @@ int amdgpu_ib_schedule(struct amdgpu_ring *ring, unsigned num_ibs,
 	struct amdgpu_device *adev = ring->adev;
 	struct amdgpu_ib *ib = &ibs[0];
 	struct dma_fence *tmp = NULL;
-	bool skip_preamble, need_ctx_switch;
+	bool need_ctx_switch;
 	unsigned patch_offset = ~0;
 	struct amdgpu_vm *vm;
 	uint64_t fence_ctx;
@@ -227,7 +227,6 @@ int amdgpu_ib_schedule(struct amdgpu_ring *ring, unsigned num_ibs,
 	if (need_ctx_switch)
 		status |= AMDGPU_HAVE_CTX_SWITCH;
 
-	skip_preamble = ring->current_ctx == fence_ctx;
 	if (job && ring->funcs->emit_cntxcntl) {
 		status |= job->preamble_status;
 		status |= job->preemption_status;
@@ -245,14 +244,6 @@ int amdgpu_ib_schedule(struct amdgpu_ring *ring, unsigned num_ibs,
 	for (i = 0; i < num_ibs; ++i) {
 		ib = &ibs[i];
 
-		/* drop preamble IBs if we don't have a context switch */
-		if ((ib->flags & AMDGPU_IB_FLAG_PREAMBLE) &&
-		    skip_preamble &&
-		    !(status & AMDGPU_PREAMBLE_IB_PRESENT_FIRST) &&
-		    !amdgpu_mcbp &&
-		    !amdgpu_sriov_vf(adev)) /* for SRIOV preemption, Preamble CE ib must be inserted anyway */
-			continue;
-
 		if (job && ring->funcs->emit_frame_cntl) {
 			if (secure != !!(ib->flags & AMDGPU_IB_FLAGS_SECURE)) {
 				amdgpu_ring_emit_frame_cntl(ring, false, secure);
--
2.25.1
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
