Return-Path: <SRS0=ko+j=DX=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8581BC433DF
	for <amd-gfx@archiver.kernel.org>; Fri, 16 Oct 2020 02:01:19 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CD9E820878
	for <amd-gfx@archiver.kernel.org>; Fri, 16 Oct 2020 02:01:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="mHsiI8Ct"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CD9E820878
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 30F646E874;
	Fri, 16 Oct 2020 02:01:18 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2079.outbound.protection.outlook.com [40.107.243.79])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6C4FB6E874
 for <amd-gfx@lists.freedesktop.org>; Fri, 16 Oct 2020 02:01:17 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ivGMCckLA32HdD27Gd4a+nE4bn/NM9t18Fdx0emHLyFNyoK7O0kW+Bg5kxCwDLPi4znHb6ssZlC7Ap1hSFB8rzCZZ7SpvDlebKWWCq0pjGjsrUsWfv6OJi4njJ9V7xTRBSHG60RzHAzRBFZycyFJrNcH4nbJyVN+ivr9D9GkjoWRw8phpQ+su4TS3JdDHUoEDSl32oyiRQEeizAJerM8fadD6K+62ZjaojahmdduGL5eT3vrYw8Mh8HE2H/S/caDTp2FZEqGV7GQMY/aptIDYvjSu/SKTnu36YJpfFjEGVq0b16lUkh19hJZH/TOVnJcQUODDEo1itvI+K3o+Pzc5A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kIRsjRTvYkcjXK3rRya0uYiCCpNArhI/NI0/RazvER0=;
 b=I7Iknt0QfN4LXcgH5irMGMPze7M/wkAz8QMZ6tMTLNpZ09rmLCUdJV9F+YDEXTXwe+hj0yK6iz9b8NIdH42ByBw5Q7jmKGWWoTkG170aH74dIVmMoNFiK4VS3z4O0VkCmsnt17zC1Z5C9pppyNbBtzqzjTIOAQzPMmFbO4hqROYZI0hq8b/P9QdmvdlwaH6TGzbTUfpqERIigsxU1f2c87ygBdRbNorBEjpHvTfRgywn1wIzLhoLLVPxZ87eSnG0NJPYAEZyZfWkY6zud5x2MQdkoTlYpexZo2nQ57PysgsxqOJSu56h9oEo3pG+Z7t4/Iy0vZe95k12qRHQwpijHw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kIRsjRTvYkcjXK3rRya0uYiCCpNArhI/NI0/RazvER0=;
 b=mHsiI8CtJAviXcGl2cegfa7W2XP3zRjjZbGCUf2UE+EpcKVtIaSvVfoHfW1PSq6N/mjpDtKCxpS22gjoJ0by6g8+heWqPJicrR9dUvfH7HAd4GLIhwU5tn5PY639PvJls4UQc9scgp7yxWQJ7/Nd2Lg1o0+23molBZdR74aJCTQ=
Received: from BN6PR12MB1425.namprd12.prod.outlook.com (2603:10b6:404:1f::19)
 by BN8PR12MB2932.namprd12.prod.outlook.com (2603:10b6:408:96::26)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3477.23; Fri, 16 Oct
 2020 02:01:13 +0000
Received: from BN6PR12MB1425.namprd12.prod.outlook.com
 ([fe80::38d1:aeb8:764d:c2af]) by BN6PR12MB1425.namprd12.prod.outlook.com
 ([fe80::38d1:aeb8:764d:c2af%12]) with mapi id 15.20.3477.022; Fri, 16 Oct
 2020 02:01:13 +0000
From: "Liu, Aaron" <Aaron.Liu@amd.com>
To: "Das, Nirmoy" <Nirmoy.Das@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH 1/2] drm:amdgpu: check before setting hw priority
Thread-Topic: [PATCH 1/2] drm:amdgpu: check before setting hw priority
Thread-Index: AQHWojFYIvon9THTK0+2ZliLNrxVL6mZe1VQ
Date: Fri, 16 Oct 2020 02:01:13 +0000
Message-ID: <BN6PR12MB14251D2075382624337B56E8F0030@BN6PR12MB1425.namprd12.prod.outlook.com>
References: <20201014135242.24619-1-nirmoy.das@amd.com>
In-Reply-To: <20201014135242.24619-1-nirmoy.das@amd.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Enabled=true;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_SetDate=2020-10-16T02:01:01Z; 
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Method=Privileged;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Name=Public_0;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_ActionId=8825355d-1a4c-481b-b85a-000048d3d606;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_ContentBits=1
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_enabled: true
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_setdate: 2020-10-16T02:01:06Z
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_method: Privileged
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_name: Public_0
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_actionid: 7ef65494-0162-4ca2-b165-0000da63b467
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_contentbits: 0
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [58.247.170.242]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 26a897f9-ef4f-41a8-514c-08d871775c35
x-ms-traffictypediagnostic: BN8PR12MB2932:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BN8PR12MB2932A5F0A74531BCC6834A58F0030@BN8PR12MB2932.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:376;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: w8ZKUOV/60LogGI1qC0RY2aZEwZ/Q8OyZifO41+5UZutRfydjPZj4fcHW5+3hF+urbbTYKIRmZCR3/tfiDLGRTgyteKQMQnZbY/i0jOKhFCG+bAz8w2w+JRPdNQ+trSQUHqhRh3z/SUIwTkKraG4NYRsaJMauN2XLC7SH+LclFdAgwQP1PWgGRe5h7Qk9Ers8PLlLZODxfIHyHuBvL2WyKY0qYoZIlosD0646JJsdKyCjo9yOBt8UN9JIkIqvjeCDETdupnDPxEPuUU3M8vL1orG0aXHYtyh1D/VRP8jT9VobGGdwBijuvwGsWIrQyH76wM+UnPzV1vpeBhStEGmBQ==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN6PR12MB1425.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(39860400002)(366004)(346002)(396003)(136003)(376002)(55016002)(316002)(71200400001)(66946007)(66556008)(110136005)(66476007)(86362001)(9686003)(76116006)(186003)(83380400001)(54906003)(7696005)(4326008)(8936002)(478600001)(2906002)(8676002)(6506007)(53546011)(26005)(33656002)(64756008)(52536014)(66446008)(5660300002);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: zB3A7DltKXHz3vTFRYIrotF1Zqyx6vVPJ73hBJq186ArVrAhNpVrHj5ii7Ep/XCtazzmHfJfg6JkUsf8eFX5Pfy/T0gIQdImjFPzjn1UGWRJAYNjBq5S1/SpPSclwZ7jphGbW7Jw9rBtMLV8A0g850ckoC8EVvyilpwjo6CKiNwMej5ngaRNbI2F8g9m69aJv82x7BW7lAhvRLNbqRrmsszz2Nwl0RC7MgqYf9Tt3pwYGxsB7Sk00hkBekutthbeGNQ+T1PhX2WXWVIR2cUh/4XILWjYWIPIhLm8b7Ixu1sJpmbng65aDh1nRFC7MmpbrsSIS40jqiPf+DIUe5LnkdG/1WQMIlWot8R6NXdFwoEB8Auh3X3wy6TnUD/d05XOF0OvwmHCitTcCbb/BLE3SPTPse6KfxbsbzYBlvsK6QyrqCYHZVXS2w9xTtba5pv9w/pjlCZz51xifplRjn6VnJoT+gtQyoFhWoSjIc4MisBDYzVZcJALh0Jjz7sBByMeNij2/4cbOsdPTApsa0jpD/gkkZmskguD+xHTynBETKe4P1uP4j7IC+/h8Ql4+Dd1PP2qhc9SZaKDO9tMeeiW9SmZkDTYneDr4qLPaXktDdW38jI18tUBMAoRPDlU3xAdUdHPFZ5qXHdyu6s3eN5Mqw==
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN6PR12MB1425.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 26a897f9-ef4f-41a8-514c-08d871775c35
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Oct 2020 02:01:13.3330 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Ex47iEb383xjJtxtUUmCr/hjABx9pHFtoQ5m85XLv6rqLreUTW/62jUozKRQjwAS
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR12MB2932
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
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Koenig,
 Christian" <Christian.Koenig@amd.com>, "Chen, Guchun" <Guchun.Chen@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Public Use]

Series is:
Tested-by: Aaron Liu <aaron.liu@amd.com>

--
Best Regards
Aaron Liu

-----Original Message-----
From: Das, Nirmoy <Nirmoy.Das@amd.com> 
Sent: Wednesday, October 14, 2020 9:53 PM
To: amd-gfx@lists.freedesktop.org
Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Koenig, Christian <Christian.Koenig@amd.com>; Chen, Guchun <Guchun.Chen@amd.com>; Liu, Aaron <Aaron.Liu@amd.com>; Das, Nirmoy <Nirmoy.Das@amd.com>
Subject: [PATCH 1/2] drm:amdgpu: check before setting hw priority

Check validity of drm_gpu_scheduler before setting hw priority.
Also fix a minor indentation issue.

Signed-off-by: Nirmoy Das <nirmoy.das@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c
index a03398c87344..c8da0978d4f6 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c
@@ -504,9 +504,9 @@ struct dma_fence *amdgpu_ctx_get_fence(struct amdgpu_ctx *ctx,  }
 
 static void amdgpu_ctx_set_entity_priority(struct amdgpu_ctx *ctx,
-					    struct amdgpu_ctx_entity *aentity,
-					    int hw_ip,
-					    enum drm_sched_priority priority)
+					   struct amdgpu_ctx_entity *aentity,
+					   int hw_ip,
+					   enum drm_sched_priority priority)
 {
 	struct amdgpu_device *adev = ctx->adev;
 	unsigned int hw_prio;
@@ -523,6 +523,9 @@ static void amdgpu_ctx_set_entity_priority(struct amdgpu_ctx *ctx,
 		hw_prio = array_index_nospec(hw_prio, AMDGPU_RING_PRIO_MAX);
 		scheds = adev->gpu_sched[hw_ip][hw_prio].sched;
 		num_scheds = adev->gpu_sched[hw_ip][hw_prio].num_scheds;
+		if (!scheds || !num_scheds)
+			return;
+
 		drm_sched_entity_modify_sched(&aentity->entity, scheds,
 					      num_scheds);
 	}
--
2.28.0
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
