Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B5212C433EF
	for <amd-gfx@archiver.kernel.org>; Tue, 22 Mar 2022 13:10:05 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 54EA510E54F;
	Tue, 22 Mar 2022 13:10:05 +0000 (UTC)
Received: from NAM04-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam08on2080.outbound.protection.outlook.com [40.107.100.80])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D250C10E54F
 for <amd-gfx@lists.freedesktop.org>; Tue, 22 Mar 2022 13:10:03 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YMhS4bW1XXz6XX5kED5To815r8HwjXSEOepKEcXK5cftwIj47NGt30Xqtwn1XjH/nuUD1FRrA3PxeiLIijLUylrkcVHrDjKdDR5H9JtxIXDP7XjkJcxAe/XJrt9jEHWzrpThv1qV8fLR0qlDfA5m2gT3IW7eN7HhIfT8Q7kfqCNvgcpiDTyXjRrQ7mdoT/JAC4ru9s5eUpY7/EpgHRcGswOvPh4OgTPq1Yrnc6ZulEEs3jlL0rjf/E51eGwyxcwA+rG0b+xiNQqpEKKYXIUipZ7c1/NGO8Oc/vd5lqhc/85nYaOsHikqdMpyflHqLrCbQltgLJO6YXuIxBeFaIqO0g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hhsLnGPqrBDA9jeOn2vdA4KSFJFRSXsgj7ItUI3ZdxU=;
 b=kBjnEkecWmmHaw/X01tvdXzPDzokPnTxFqmv6zNJw8KpMWwXz+dSP+Rc0EnTr7Dq1dhZ2/mhfEiNyH8hP5vqEtH0Y1Lcu4GCwNAJAkWBm9JGYNrAdz5ghc3vY/oUm21I4xPeWXHVZcLGDxvvVqMaV4wy//tPDQm0p1yocGf99iBFn2XK25cN5iRshzZrRokuRD6cBhnp+/8V8ISOejZul/UfpJegsPGx2Bvy8wvgdxgkbbXkJEBJcHV/VOzuM7jgmsK5mVoUBeav3YJy74Xr5AJZb78efJLWUzeQgp/eI1rKfMjpbmxZCBiwbvUqJz1rs+cYSjJFwplNiLU/SQMNhg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hhsLnGPqrBDA9jeOn2vdA4KSFJFRSXsgj7ItUI3ZdxU=;
 b=nC8w3nMm3E1NveJXW5DST1lSn2cZTec29yd59t2AvZQipgmBZ/4UmbzSnowy8C7Uv6cLNOLxvReu8bJmaz1W3ydkwq6qAuYYOi8R9MXEGVwcIxk4vCv+O6gfcuvMAbZWKMTJbw6FbxdNWHcHnvJ07TcJwXuv5BJVnQp15brRSu0=
Received: from DM5PR12MB2469.namprd12.prod.outlook.com (2603:10b6:4:af::38) by
 CH0PR12MB5026.namprd12.prod.outlook.com (2603:10b6:610:e1::14) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5081.17; Tue, 22 Mar 2022 13:10:00 +0000
Received: from DM5PR12MB2469.namprd12.prod.outlook.com
 ([fe80::dd89:5054:25de:2942]) by DM5PR12MB2469.namprd12.prod.outlook.com
 ([fe80::dd89:5054:25de:2942%3]) with mapi id 15.20.5081.023; Tue, 22 Mar 2022
 13:10:00 +0000
From: "Chen, Guchun" <Guchun.Chen@amd.com>
To: "Ma, Jun" <Jun.Ma2@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amdgpu: Correct the parameter name of amdgpu_ring_init
Thread-Topic: [PATCH] drm/amdgpu: Correct the parameter name of
 amdgpu_ring_init
Thread-Index: AQHYPevcBTaJScwcY0q2lxvpc7gTMazLYGDA
Date: Tue, 22 Mar 2022 13:09:59 +0000
Message-ID: <DM5PR12MB2469E50BCBFDF2F7B783869DF1179@DM5PR12MB2469.namprd12.prod.outlook.com>
References: <20220322125308.3771732-1-Jun.Ma2@amd.com>
In-Reply-To: <20220322125308.3771732-1-Jun.Ma2@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 600b9606-6c6f-4c56-1686-08da0c054527
x-ms-traffictypediagnostic: CH0PR12MB5026:EE_
x-microsoft-antispam-prvs: <CH0PR12MB502666297D0129DD090CFE03F1179@CH0PR12MB5026.namprd12.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ctowjN9WLoANneF2C4vzGYWeO09M2EKg2WmcNXhLgaKX5A+VUQE8aUAUYL/T6iYsKPADM9cccsNHtDvvcxPGkGEochVqA67Kov+uvSRHO47wCLjnPUTsNBBwMW82zoHaP9RqTpoundKQzHxjaSdGl7hvlq3ladJFPwvWDjgPQVgENuFtUvWOzj2bpoUnlOrHiLZII5kCIYxairN1YJEutSsfi+Jf/tIEEuAYQwXCAqjSyD0xb6ViSff7TErNXE+DbLSPlEVrlkWTKNsP9W+Wh0kMQDEWggyTgp3rBe8QwUfzp3ZwaOlzZ/T9hWAg/SscmJyF3tgI+xrlR5bXNDFezzymPfPc4qlIdJSWNPyYjtK28u6LeA7/dhG+hti2qXQSPhJCk0bEX4AD42aPJbZ8wVjnrjNALoUGnG8LrVQLfn2RanqBvxKW5BcCZfST4SpzTx49Fs34V5ySRkJ+2rnjzohH+AIwqkA0nh6hhWQ3saxfAIGeM5bmlIwVEq90Dm4yTUJkdB3JBhJXwv/UPRuUHAIRzgclrmsbeK2LFpVQ8l1uTESJmT9pzjEYWI/LiaBvyeZl1+AdzMjQ2XWzczDavu97+1IPqtr1GstAF5jYAyw/a7pF175vkZO1XKOsvlesPCgF88kU2y4l2AQf1vtn4nr0r62tF45emzykOY6xDQ+4hR/RMjzie5jundWFrsaUXeYcHxvalc2Z+AKcxKwdMw==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM5PR12MB2469.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(4636009)(366004)(2906002)(71200400001)(86362001)(508600001)(53546011)(26005)(9686003)(38070700005)(7696005)(6506007)(122000001)(186003)(38100700002)(83380400001)(64756008)(76116006)(66556008)(66476007)(66446008)(66946007)(54906003)(8676002)(4326008)(316002)(110136005)(5660300002)(33656002)(8936002)(52536014)(55016003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?PQO5jTLLxOOrl3RwnC8n0uVbxnyZlzTqFgPWoRMV4mXIP+o1GE5PcjX4k+Qu?=
 =?us-ascii?Q?B8NVXtUuo7Yw53t9TFU7sKnfEcNpYiU70mN54Q3hgQke2QP+Hqy+Enf8EZg/?=
 =?us-ascii?Q?Ezw+BuegllOtVRlJpignq2XvbG5UnuzNg+YZklEc09TagQA1KYoktvCRL442?=
 =?us-ascii?Q?FQiDQndgAu2UKfok6YpjBsuOBguQugHxs688f8d5B10AAt9crt1R9d5EKbPg?=
 =?us-ascii?Q?87/ArqZztj4+gVI59xKEU6K93zkfBWZNAGKyRAN3btHj3At9EfGARqjFDikz?=
 =?us-ascii?Q?Eh+Ug/xkUKpHdDNSYLqewX/ohCEWrNZBxgug9anrS6vfrfWUmy7sQfqwxV9n?=
 =?us-ascii?Q?NTqdV9Tu8kMHrt3COeHqD9mLM7MSSLqCC6plR78BUy7T2SQ4wwkWTr5zMMfS?=
 =?us-ascii?Q?rsX37Mj83nY6s11jWCLUYCQ1RMaGdHmgq9uXpint7mlppwVZtIUHOmDjjcHP?=
 =?us-ascii?Q?6CbZZt+MH7foK+qJ92W8arnaaYvN42FVMVwXhwiarUOhivAsURw+ugJl+QXt?=
 =?us-ascii?Q?8lTmrvidsmulq4/8FEyD/yAZpOtGIkocNr4H4V/FXruyqgMxvKqFItt1/ACR?=
 =?us-ascii?Q?jFw5WHz2MbHQ0rzyHEjGQxNeLN7jWvIbE3MJvxo1mocwbWvTq7QUdiftDWFp?=
 =?us-ascii?Q?sqcnrx5WdeIjwZxgb3gNd9cQ7SZyeZCpVNrCFn+1F4YgMEeaMf8RcwVx6W7I?=
 =?us-ascii?Q?MQFnJleESZjsmWHPRkDVzeylmP/qBannOT0AeSb51hLDEHhF43cLIO6mn4wz?=
 =?us-ascii?Q?5QC8iOMLcavQMqeWW45rT1iIX+3BBhnYqJyZElr0NXLuHmdWrm3eaVpn6X8I?=
 =?us-ascii?Q?38JhoswfpSe8SqS7bfPTQIBPd+rjPOF2zQDuB+UAuA6mhgy9gZlVo1y2RRgB?=
 =?us-ascii?Q?d640Dl5h3S+3X0O4ERlOy9kOZ8AsnPD+cnqlQ235qEJ2BdegusJ82GetIQk+?=
 =?us-ascii?Q?g8jeDQz6q2kAu1eGWg5G0LwDs2A3Uedz07jLpTusAo7zwRBj5k6rgsySFnwt?=
 =?us-ascii?Q?k9sU+Lo0bvBr8Ree/eZsuM/IAKvjzU8BPFOLfIv+qskuzpY8CCslJRNDhdw4?=
 =?us-ascii?Q?Zh35b5vV2A+61pvSNv3dKwxHx3n4DuXQMC14tkG8p7wLGben5duCEfhil8mI?=
 =?us-ascii?Q?OXYYwWsQo2rkKtgomuKO3SYTG1pmNQ+j+ma+G6WS42EKhOECRD35OufTS2VB?=
 =?us-ascii?Q?Ofd3Gv7K3p65R+35cfK9uQ79kFKQWuIKUPEg1E2VVp/0QSS9wwew/tmvCrP+?=
 =?us-ascii?Q?7j3pnVSnxCeyZdFjKsM3PzfvPUfRs2nM9V+6Xh1mUFLmF9BWoypyqSuxUx7c?=
 =?us-ascii?Q?CtQT69yFI8tbadiJyKv2KhFZDC/58Y62JO4lBDGm18W42cBtY/dQcbkmrPSj?=
 =?us-ascii?Q?i6W3OHUX1yE0EdVcmw3f4+gwOuNW/AxD5cTM+hL+Ht+4uf2m+5xFEcHI3zoX?=
 =?us-ascii?Q?ATBtZgE+lEaQKA8sAD4Gezd9N6m/+8O0?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM5PR12MB2469.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 600b9606-6c6f-4c56-1686-08da0c054527
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Mar 2022 13:09:59.9655 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 372rBehEzk30gCk8+ym1ncNeqC+8EKCbkYOkOTKm/0vysUFNLMB73GWXPTvz2SgQRjftNRtxS5Jc3ks5mVXFmQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR12MB5026
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
 Christian" <Christian.Koenig@amd.com>, "Zhang,
 Hawking" <Hawking.Zhang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Reviewed-by: Guchun Chen <guchun.chen@amd.com>

Regards,
Guchun

-----Original Message-----
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Ma Jun
Sent: Tuesday, March 22, 2022 8:53 PM
To: amd-gfx@lists.freedesktop.org
Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Koenig, Christian <Chri=
stian.Koenig@amd.com>; Zhang, Hawking <Hawking.Zhang@amd.com>
Subject: [PATCH] drm/amdgpu: Correct the parameter name of amdgpu_ring_init

Correct the parameter name of amdgpu_ring_init() in header file.

Signed-off-by: Ma Jun <Jun.Ma2@amd.com>
Change-Id: I202d76ba04b137926b456b1c8a4c05a5b1a01bff
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h b/drivers/gpu/drm/amd=
/amdgpu/amdgpu_ring.h
index 5320bb0883d8..317d80209e95 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
@@ -300,8 +300,8 @@ void amdgpu_ring_generic_pad_ib(struct amdgpu_ring *rin=
g, struct amdgpu_ib *ib);  void amdgpu_ring_commit(struct amdgpu_ring *ring=
);  void amdgpu_ring_undo(struct amdgpu_ring *ring);  int amdgpu_ring_init(=
struct amdgpu_device *adev, struct amdgpu_ring *ring,
-		     unsigned int ring_size, struct amdgpu_irq_src *irq_src,
-		     unsigned int irq_type, unsigned int prio,
+		     unsigned int max_dw, struct amdgpu_irq_src *irq_src,
+		     unsigned int irq_type, unsigned int hw_prio,
 		     atomic_t *sched_score);
 void amdgpu_ring_fini(struct amdgpu_ring *ring);  void amdgpu_ring_emit_re=
g_write_reg_wait_helper(struct amdgpu_ring *ring,
--
2.25.1

