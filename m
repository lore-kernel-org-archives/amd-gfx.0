Return-Path: <SRS0=iszZ=JR=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0EE99C433ED
	for <amd-gfx@archiver.kernel.org>; Tue, 20 Apr 2021 08:54:02 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A1C4361168
	for <amd-gfx@archiver.kernel.org>; Tue, 20 Apr 2021 08:54:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A1C4361168
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 230C06E4AB;
	Tue, 20 Apr 2021 08:54:01 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2089.outbound.protection.outlook.com [40.107.93.89])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3ADAB6E49C
 for <amd-gfx@lists.freedesktop.org>; Tue, 20 Apr 2021 08:53:59 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kdzLKjUYZ6Ad4mNPAYQqJSp78njXQ8P+xV4cdqdU1kfYK4Es5CABNz7UKUsZq2iKLyUbKfYNbtPFpvjNXz9TbPvQk4tV0VAv1bZDC08G7SOS3lHnEg83GY8/SWOu3mGLoK74s3xIkffSuF517PqDnPAfENJMLAyWZj1w6rJo94TxkGhvQgd+w47K+qMoAeighWUKLoef3rQi4yH8Lt4mwo+e7czP3laROYyQHc/ctJsbiZndn7Tp2zB9/Er7msnUaz3POhTts5BRgKCFDzqh7++jasqIZHdLYNx3KC+N6SvaxIY3R68PfxWAHxYT4PlYlrsfhx0oCTgagw1waLyREA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=r2vqhNCwoWCptGKcJvOmVwR73FNyj9V68Yxw0/4nLgE=;
 b=DlhwAdiO5UgvF/LoOQtk3MjMWEQB9+pMN8LLZXtD/Gx3deGENo/FxM8Vec5Dmz+nHKthx4VM5hMldxhK0889ImSOtrRwBF2ndVbToNRdcUmt0hr2mhgYJ2csEesnj4xCLwC5C+vPDRuNSbpkFkao14fr+v0j1J+OEIQ97tA/VoGWDPkoFKy7L/0Qe8ksAvEtvddriYzYRA6HBe9/MxbUd40USy5iQ4c5lslz9mxjoBZq3PoBnKPOruU3PlhSmyAJQJBkrAdWDVlyj3glbn7AswgkttqXhaqp14KVuuTr53Hi+9jdUEbRC2264DRNf6Xs33eBftZJi8aquRpsZKZqCg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=r2vqhNCwoWCptGKcJvOmVwR73FNyj9V68Yxw0/4nLgE=;
 b=nXnDhcVIHXn3Ae/DjDbMd5ucQzf1Uv+l1rxQYMcegn2yl1TLP10OL+0C5F4c6mFKm2zhC5vEnxga/3KcZBWVw27bRI/dTxmYgdtOMRvm5ob0LYKLYTodR2knQLPmsR3nJwJbU0sSEZP6LOQME3ln5ovrNlOgahd/GbCzriFXnDI=
Received: from CY4PR12MB1606.namprd12.prod.outlook.com (2603:10b6:910:10::15)
 by CY4PR1201MB0213.namprd12.prod.outlook.com (2603:10b6:910:21::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4042.21; Tue, 20 Apr
 2021 08:53:57 +0000
Received: from CY4PR12MB1606.namprd12.prod.outlook.com
 ([fe80::5c7c:99fe:5cd5:5848]) by CY4PR12MB1606.namprd12.prod.outlook.com
 ([fe80::5c7c:99fe:5cd5:5848%6]) with mapi id 15.20.4042.024; Tue, 20 Apr 2021
 08:53:57 +0000
From: "Sun, Roy" <Roy.Sun@amd.com>
To: "Sun, Roy" <Roy.Sun@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH 2/2] drm/amdgpu: Add show_fdinfo() interface
Thread-Topic: [PATCH 2/2] drm/amdgpu: Add show_fdinfo() interface
Thread-Index: AQHXNOT0LMiJQd5SFUuouJFgP1HYa6q9Gzcw
Date: Tue, 20 Apr 2021 08:53:57 +0000
Message-ID: <CY4PR12MB160684A2AD3C7F6A2EAE664CFF489@CY4PR12MB1606.namprd12.prod.outlook.com>
References: <20210419062624.27688-1-Roy.Sun@amd.com>
 <20210419062624.27688-2-Roy.Sun@amd.com>
In-Reply-To: <20210419062624.27688-2-Roy.Sun@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Enabled=true;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SetDate=2021-04-20T08:53:13Z; 
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Method=Standard;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Name=Internal Use Only -
 Unrestricted;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ActionId=8d31dff2-86ef-49b7-bcc9-485ad6d7eeab;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ContentBits=1
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [180.167.199.189]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: b7263935-436c-4216-7af1-08d903d9d572
x-ms-traffictypediagnostic: CY4PR1201MB0213:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <CY4PR1201MB0213B32F12E04D99B5332C10FF489@CY4PR1201MB0213.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:800;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 6U1igU9zjp4NiVKgxVlc/2nKJuKVh2B1e0NT+LkmjQYG2BKzmgFN+Vyfm8WsUmCvZh/n/6avkdvqTq/FMEEutrhYCIphRFdaGIWA4M9sFqrRqMg+PXUaYrFar3r5iz0SIkWXoq3oFYephK3ajOax4a1zQZlRUinqAZtjwoT0lavQodNV4W32S7C9tOtpDWmtOv4FyolyUQn6ZF1rZcWI9tLzaD6WHZAmJoHCxbvf11awSp3fiwpn9PAhv/t0a4YnCRA19kVK+iT3lPsS/B8yXYHs21oHlYytdR277Ytsz3pwmaaCsWD4BkDVw5S3pzFW+nMKYGxbKMt3iK/eHPN7uUMritOX0XTUbeZXrvMiUb588jnwAOdw8cI25LCmJaUmD+XlpctKm7ldf26N9Cb2ltaJ3y8V3DgwbeyRagYjyJObLDqzM60HX+rCJUMs72JXVpLKCn3bmmHE6Q01ZPvt0Bpzs8X1FtNXJXQ5zuEfptOtDUsqYe1NFs4x5CRt5zuUCyyejJjKSbJ3zzfVDwq5DH3cxA1nbQyHqZ0P0RLJHSiNh0g1Ao2BYmTRBcHBgko3YvDwdZBO48yBdxRwWZ+vfCA0HAx4Djzo503SR/lINck=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CY4PR12MB1606.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(346002)(396003)(376002)(366004)(39860400002)(136003)(71200400001)(316002)(6506007)(7696005)(66946007)(53546011)(86362001)(76116006)(30864003)(52536014)(8676002)(110136005)(5660300002)(8936002)(83380400001)(4326008)(186003)(33656002)(9686003)(66556008)(66476007)(66446008)(64756008)(26005)(55016002)(122000001)(2906002)(478600001)(38100700002);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?cuhDvD1g+2AlBb694cbN63BCJj9+m+zmViVWFgz1xaSZdDOUpqHH0ceAH0zN?=
 =?us-ascii?Q?mNniUFpbFNjRoGtQy4JqL6oeDhreENhCjBC9lysl4LwCM3+CVGIKHs+Ldlp7?=
 =?us-ascii?Q?RmVUDFhYJpMhMozswoLrAdVN2SMVbSQv+4frLrqUXA/ntN3fyrYxB5Zsa1Ur?=
 =?us-ascii?Q?FpQUfRxdlU3e7aUO9oPs9F47gLLuejrSYukaiI+2nk6qC1uDops/CKt82l/M?=
 =?us-ascii?Q?I1nbZBReRKmqXpYH6hwxIlcFVzsKlS/7YDeMqxAXPIzLmPdlzPmg5Zk6FyQR?=
 =?us-ascii?Q?u369AHa7nVe6UtxJi+0w8VbSgFqL6ZJBT7xt/gb+OSfj0cenA7qtI/3YAfaQ?=
 =?us-ascii?Q?41iehhkeVoFvlCnhezILq63vnYn8j9cBbwyuPEeGlY8Zv/ic2XA5q0S/iVuP?=
 =?us-ascii?Q?prpLSyY71Yup4K8YQ37QRvx/ogoJfmGp8EA/8zi7m8kc0SZ7msTr0iceWMRl?=
 =?us-ascii?Q?iRclM6iD+9iJhdvc8KxyNruyO8INUVpgy/VLvsREarR4naCv6U5VSLgiBO+Q?=
 =?us-ascii?Q?vbWU8WYD3JcX+BF8frxinRF9dw65ZOkajZBNBI3++wrJ5cIyyYDOtai7J85h?=
 =?us-ascii?Q?Hm9YndT8L+ML4rIbm5+9//OfVg9WRiyVpZuuy40HtmNwIkDfRoJ5lVriO+yh?=
 =?us-ascii?Q?DrKT8hQ6k0zDW+2sdQfF0tiHT84q4KWi0We2eoYNu9P+4GLN5RlfKepOpuBO?=
 =?us-ascii?Q?eZPyvQE59HhjpcIS79b6kIlnn1CHIphwtocqViLgk75HGWsBq4Jy/vS2PJcG?=
 =?us-ascii?Q?2+lHguiVWZDEWiCy/FXd2wgsOOxot4BKZnjxi09nUYnixItSpEPssbwMTUiv?=
 =?us-ascii?Q?Yx7Vw4lgw+nLVhnNOJLkAU5MH6HdHjMLxxaMKdqKNenBokEpawt82QCmNs78?=
 =?us-ascii?Q?VVOf+QXpZK2hYYek0rA2oK1sl1cFAmzKoR5YKGgGvmGWf4yVB4iQaDTLMruG?=
 =?us-ascii?Q?8CGoUYBc5Hh8VIZ2CqRSMEzRS8JODp5wJW4gny8FHkMwgKOfhEfSzjCsFiWl?=
 =?us-ascii?Q?tshFis4S9tCmG7rkifOwij22OJ6Dqq8ZvNoTP30dbeoy93Ihd44nTo45tV5M?=
 =?us-ascii?Q?c9ACzqcEdoPZe2KSR85Lk/DNCzluwBQtwc1lHqa1K9gV7t/cpSs8RPivWFiL?=
 =?us-ascii?Q?CuwYqp2od3ke4MnWohdb7LtdHth7htczFrUJB4/nR3rJbJt0/eR6xpvT8KP9?=
 =?us-ascii?Q?FdL75holaIF2swRw0uVzQtSMM+ZKnoh+61O0eLtrd6/upte0yFqG7BUSxlbO?=
 =?us-ascii?Q?pnFpdvpyzlikhb0vmbaRbTz2XsVZyMyXLH0RDV7NsV2LzwX8ca2JS15+Vonl?=
 =?us-ascii?Q?7qyQrF3xeLUaCb2RQxDNirzC?=
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY4PR12MB1606.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b7263935-436c-4216-7af1-08d903d9d572
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Apr 2021 08:53:57.1812 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: c7hgyvyiepVF77EzS8ViPQ1YlvSB6fKIPv0LkIS9Pi5w2AYTSONLbC46inq5c3PUnOH+tPHTPf2sYkr6CYLogg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR1201MB0213
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
Cc: "Nieto, David M" <David.Nieto@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Official Use Only - Internal Distribution Only]

Ping.
Could you help review this patch again?

BR
Roy

-----Original Message-----
From: Roy Sun <Roy.Sun@amd.com> 
Sent: Monday, April 19, 2021 2:26 PM
To: amd-gfx@lists.freedesktop.org
Cc: Sun, Roy <Roy.Sun@amd.com>; Nieto, David M <David.Nieto@amd.com>
Subject: [PATCH 2/2] drm/amdgpu: Add show_fdinfo() interface

Tracking devices, process info and fence info using /proc/pid/fdinfo

Signed-off-by: David M Nieto <David.Nieto@amd.com>
Signed-off-by: Roy Sun <Roy.Sun@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/Makefile        |  2 +
 drivers/gpu/drm/amd/amdgpu/amdgpu.h        |  1 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c    | 61 ++++++++++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.h    |  5 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c    |  5 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_fdinfo.c | 95 ++++++++++++++++++++++  drivers/gpu/drm/amd/amdgpu/amdgpu_fdinfo.h | 43 ++++++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c    |  1 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c     | 24 ++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h     |  4 +
 10 files changed, 239 insertions(+), 2 deletions(-)  create mode 100644 drivers/gpu/drm/amd/amdgpu/amdgpu_fdinfo.c
 create mode 100644 drivers/gpu/drm/amd/amdgpu/amdgpu_fdinfo.h

diff --git a/drivers/gpu/drm/amd/amdgpu/Makefile b/drivers/gpu/drm/amd/amdgpu/Makefile
index ee85e8aba636..d216b7ecb5d1 100644
--- a/drivers/gpu/drm/amd/amdgpu/Makefile
+++ b/drivers/gpu/drm/amd/amdgpu/Makefile
@@ -58,6 +58,8 @@ amdgpu-y += amdgpu_device.o amdgpu_kms.o \
 	amdgpu_umc.o smu_v11_0_i2c.o amdgpu_fru_eeprom.o amdgpu_rap.o \
 	amdgpu_fw_attestation.o amdgpu_securedisplay.o
 
+amdgpu-$(CONFIG_PROC_FS) += amdgpu_fdinfo.o
+
 amdgpu-$(CONFIG_PERF_EVENTS) += amdgpu_pmu.o
 
 # add asic specific block
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
index 125b25a5ce5b..3365feae15e1 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
@@ -107,6 +107,7 @@
 #include "amdgpu_gfxhub.h"
 #include "amdgpu_df.h"
 #include "amdgpu_smuio.h"
+#include "amdgpu_fdinfo.h"
 
 #define MAX_GPU_INSTANCE		16
 
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c
index 0350205c4897..01fe60fedcbe 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c
@@ -651,3 +651,64 @@ void amdgpu_ctx_mgr_fini(struct amdgpu_ctx_mgr *mgr)
 	idr_destroy(&mgr->ctx_handles);
 	mutex_destroy(&mgr->lock);
 }
+
+void amdgpu_ctx_fence_time(struct amdgpu_ctx *ctx, struct amdgpu_ctx_entity *centity,
+		ktime_t *total, ktime_t *max)
+{
+	ktime_t now, t1;
+	uint32_t i;
+
+	now = ktime_get();
+	for (i = 0; i < amdgpu_sched_jobs; i++) {
+		struct dma_fence *fence;
+		struct drm_sched_fence *s_fence;
+
+		spin_lock(&ctx->ring_lock);
+		fence = dma_fence_get(centity->fences[i]);
+		spin_unlock(&ctx->ring_lock);
+		if (!fence)
+			continue;
+		s_fence = to_drm_sched_fence(fence);
+		if (!dma_fence_is_signaled(&s_fence->scheduled))
+			continue;
+		t1 = s_fence->scheduled.timestamp;
+		if (t1 >= now)
+			continue;
+		if (dma_fence_is_signaled(&s_fence->finished) &&
+			s_fence->finished.timestamp < now)
+			*total += ktime_sub(s_fence->finished.timestamp, t1);
+		else
+			*total += ktime_sub(now, t1);
+		t1 = ktime_sub(now, t1);
+		dma_fence_put(fence);
+		*max = max(t1, *max);
+	}
+}
+
+ktime_t amdgpu_ctx_mgr_fence_usage(struct amdgpu_ctx_mgr *mgr, uint32_t hwip,
+		uint32_t idx, uint64_t *elapsed)
+{
+	struct idr *idp;
+	struct amdgpu_ctx *ctx;
+	uint32_t id;
+	struct amdgpu_ctx_entity *centity;
+	ktime_t total = 0, max = 0;
+
+	if (idx >= AMDGPU_MAX_ENTITY_NUM)
+		return 0;
+	idp = &mgr->ctx_handles;
+	mutex_lock(&mgr->lock);
+	idr_for_each_entry(idp, ctx, id) {
+		if (!ctx->entities[hwip][idx])
+			continue;
+
+		centity = ctx->entities[hwip][idx];
+		amdgpu_ctx_fence_time(ctx, centity, &total, &max);
+	}
+
+	mutex_unlock(&mgr->lock);
+	if (elapsed)
+		*elapsed = max;
+
+	return total;
+}
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.h
index f54e10314661..10dcf59a5c6b 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.h
@@ -87,5 +87,8 @@ void amdgpu_ctx_mgr_init(struct amdgpu_ctx_mgr *mgr);  void amdgpu_ctx_mgr_entity_fini(struct amdgpu_ctx_mgr *mgr);  long amdgpu_ctx_mgr_entity_flush(struct amdgpu_ctx_mgr *mgr, long timeout);  void amdgpu_ctx_mgr_fini(struct amdgpu_ctx_mgr *mgr);
-
+ktime_t amdgpu_ctx_mgr_fence_usage(struct amdgpu_ctx_mgr *mgr, uint32_t hwip,
+		uint32_t idx, uint64_t *elapsed);
+void amdgpu_ctx_fence_time(struct amdgpu_ctx *ctx, struct amdgpu_ctx_entity *centity,
+		ktime_t *total, ktime_t *max);
 #endif
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
index 0369d3532bf0..01603378dbc9 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
@@ -42,7 +42,7 @@
 #include "amdgpu_irq.h"
 #include "amdgpu_dma_buf.h"
 #include "amdgpu_sched.h"
-
+#include "amdgpu_fdinfo.h"
 #include "amdgpu_amdkfd.h"
 
 #include "amdgpu_ras.h"
@@ -1692,6 +1692,9 @@ static const struct file_operations amdgpu_driver_kms_fops = {  #ifdef CONFIG_COMPAT
 	.compat_ioctl = amdgpu_kms_compat_ioctl,  #endif
+#ifdef CONFIG_PROC_FS
+	.show_fdinfo = amdgpu_show_fdinfo
+#endif
 };
 
 int amdgpu_file_to_fpriv(struct file *filp, struct amdgpu_fpriv **fpriv) diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_fdinfo.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_fdinfo.c
new file mode 100644
index 000000000000..781a06101c22
--- /dev/null
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_fdinfo.c
@@ -0,0 +1,95 @@
+// SPDX-License-Identifier: MIT
+/* Copyright 2021 Advanced Micro Devices, Inc.
+ *
+ * Permission is hereby granted, free of charge, to any person 
+obtaining a
+ * copy of this software and associated documentation files (the 
+"Software"),
+ * to deal in the Software without restriction, including without 
+limitation
+ * the rights to use, copy, modify, merge, publish, distribute, 
+sublicense,
+ * and/or sell copies of the Software, and to permit persons to whom 
+the
+ * Software is furnished to do so, subject to the following conditions:
+ *
+ * The above copyright notice and this permission notice shall be 
+included in
+ * all copies or substantial portions of the Software.
+ *
+ * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, 
+EXPRESS OR
+ * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF 
+MERCHANTABILITY,
+ * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.  IN NO EVENT 
+SHALL
+ * THE COPYRIGHT HOLDER(S) OR AUTHOR(S) BE LIABLE FOR ANY CLAIM, 
+DAMAGES OR
+ * OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR 
+OTHERWISE,
+ * ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE 
+OR
+ * OTHER DEALINGS IN THE SOFTWARE.
+ *
+ * Authors: David Nieto
+ *          Roy Sun
+ */
+
+#include <linux/debugfs.h>
+#include <linux/list.h>
+#include <linux/module.h>
+#include <linux/uaccess.h>
+#include <linux/reboot.h>
+#include <linux/syscalls.h>
+
+#include <drm/amdgpu_drm.h>
+#include <drm/drm_debugfs.h>
+
+#include "amdgpu.h"
+#include "amdgpu_vm.h"
+#include "amdgpu_gem.h"
+#include "amdgpu_ctx.h"
+#include "amdgpu_fdinfo.h"
+
+
+static const char *amdgpu_ip_name[AMDGPU_HW_IP_NUM] = {
+	[AMDGPU_HW_IP_GFX]	=	"gfx",
+	[AMDGPU_HW_IP_COMPUTE]	=	"compute",
+	[AMDGPU_HW_IP_DMA]	=	"dma",
+	[AMDGPU_HW_IP_UVD]	=	"dec",
+	[AMDGPU_HW_IP_VCE]	=	"enc",
+	[AMDGPU_HW_IP_UVD_ENC]	=	"enc_1",
+	[AMDGPU_HW_IP_VCN_DEC]	=	"dec",
+	[AMDGPU_HW_IP_VCN_ENC]	=	"enc",
+	[AMDGPU_HW_IP_VCN_JPEG]	=	"jpeg",
+};
+
+void amdgpu_show_fdinfo(struct seq_file *m, struct file *f) {
+	struct amdgpu_fpriv *fpriv;
+	uint32_t bus, dev, fn, i;
+	uint64_t vram_mem = 0, gtt_mem = 0;
+	struct drm_file *file = f->private_data;
+	struct amdgpu_device *adev = drm_to_adev(file->minor->dev);
+
+	if (amdgpu_file_to_fpriv(f, &fpriv))
+		return;
+	bus = adev->pdev->bus->number;
+	dev = PCI_SLOT(adev->pdev->devfn);
+	fn = PCI_FUNC(adev->pdev->devfn);
+
+	amdgpu_vm_get_memory(&fpriv->vm, &vram_mem, &gtt_mem);
+	seq_printf(m, "pdev:\t%02x:%02x.%d\npasid:\t%u\n", bus, dev, fn,
+			fpriv->vm.pasid);
+	seq_printf(m, "vram mem:\t%llu kB\n", vram_mem/1024UL);
+	seq_printf(m, "gtt mem:\t%llu kB\n", gtt_mem/1024UL);
+
+	for (i = 0; i < AMDGPU_HW_IP_NUM; i++) {
+		uint32_t count = amdgpu_ctx_num_entities[i];
+		int idx = 0;
+		uint64_t total = 0, min = 0;
+		uint32_t perc, frac;
+
+		for (idx = 0; idx < count; idx++) {
+			total = amdgpu_ctx_mgr_fence_usage(&fpriv->ctx_mgr,
+				i, idx, &min);
+			if ((total == 0) || (min == 0))
+				continue;
+
+			perc = div64_u64(10000 * total, min);
+			frac = perc % 100;
+
+			seq_printf(m, "%s%d:\t%d.%d%%\n",
+					amdgpu_ip_name[i],
+					idx, perc/100, frac);
+		}
+	}
+}
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_fdinfo.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_fdinfo.h
new file mode 100644
index 000000000000..41a4c7056729
--- /dev/null
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_fdinfo.h
@@ -0,0 +1,43 @@
+/* SPDX-License-Identifier: MIT
+ * Copyright 2021 Advanced Micro Devices, Inc.
+ *
+ * Permission is hereby granted, free of charge, to any person 
+obtaining a
+ * copy of this software and associated documentation files (the 
+"Software"),
+ * to deal in the Software without restriction, including without 
+limitation
+ * the rights to use, copy, modify, merge, publish, distribute, 
+sublicense,
+ * and/or sell copies of the Software, and to permit persons to whom 
+the
+ * Software is furnished to do so, subject to the following conditions:
+ *
+ * The above copyright notice and this permission notice shall be 
+included in
+ * all copies or substantial portions of the Software.
+ *
+ * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, 
+EXPRESS OR
+ * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF 
+MERCHANTABILITY,
+ * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.  IN NO EVENT 
+SHALL
+ * THE COPYRIGHT HOLDER(S) OR AUTHOR(S) BE LIABLE FOR ANY CLAIM, 
+DAMAGES OR
+ * OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR 
+OTHERWISE,
+ * ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE 
+OR
+ * OTHER DEALINGS IN THE SOFTWARE.
+ *
+ * Authors: David Nieto
+ *          Roy Sun
+ */
+#ifndef __AMDGPU_SMI_H__
+#define __AMDGPU_SMI_H__
+
+#include <linux/idr.h>
+#include <linux/kfifo.h>
+#include <linux/rbtree.h>
+#include <drm/gpu_scheduler.h>
+#include <drm/drm_file.h>
+#include <drm/ttm/ttm_bo_driver.h>
+#include <linux/sched/mm.h>
+
+#include "amdgpu_sync.h"
+#include "amdgpu_ring.h"
+#include "amdgpu_ids.h"
+
+uint32_t amdgpu_get_ip_count(struct amdgpu_device *adev, int id); void 
+amdgpu_show_fdinfo(struct seq_file *m, struct file *f);
+
+#endif
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
index 39ee88d29cca..b2e774aeab45 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
@@ -41,6 +41,7 @@
 #include "amdgpu_gem.h"
 #include "amdgpu_display.h"
 #include "amdgpu_ras.h"
+#include "amdgpu_fdinfo.h"
 
 void amdgpu_unregister_gpu_instance(struct amdgpu_device *adev)  { diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
index f95bcda8463f..773acb4437f7 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
@@ -25,6 +25,7 @@
  *          Alex Deucher
  *          Jerome Glisse
  */
+
 #include <linux/dma-fence-array.h>
 #include <linux/interval_tree_generic.h>  #include <linux/idr.h> @@ -322,6 +323,7 @@ static void amdgpu_vm_bo_base_init(struct amdgpu_vm_bo_base *base,
 	base->vm = vm;
 	base->bo = bo;
 	base->next = NULL;
+	INIT_LIST_HEAD(&base->bo_head);
 	INIT_LIST_HEAD(&base->vm_status);
 
 	if (!bo)
@@ -329,6 +331,7 @@ static void amdgpu_vm_bo_base_init(struct amdgpu_vm_bo_base *base,
 	base->next = bo->vm_bo;
 	bo->vm_bo = base;
 
+	list_add(&base->bo_head, &vm->bo_list);
 	if (bo->tbo.base.resv != vm->root.base.bo->tbo.base.resv)
 		return;
 
@@ -2541,6 +2544,7 @@ void amdgpu_vm_bo_rmv(struct amdgpu_device *adev,
 
 	spin_lock(&vm->invalidated_lock);
 	list_del(&bo_va->base.vm_status);
+	list_del(&bo_va->base.bo_head);
 	spin_unlock(&vm->invalidated_lock);
 
 	list_for_each_entry_safe(mapping, next, &bo_va->valids, list) { @@ -2800,6 +2804,7 @@ int amdgpu_vm_init(struct amdgpu_device *adev, struct amdgpu_vm *vm,
 	spin_lock_init(&vm->invalidated_lock);
 	INIT_LIST_HEAD(&vm->freed);
 	INIT_LIST_HEAD(&vm->done);
+	INIT_LIST_HEAD(&vm->bo_list);
 
 	/* create scheduler entities for page table updates */
 	r = drm_sched_entity_init(&vm->immediate, DRM_SCHED_PRIORITY_NORMAL, @@ -3267,6 +3272,25 @@ void amdgpu_vm_get_task_info(struct amdgpu_device *adev, u32 pasid,
 	spin_unlock_irqrestore(&adev->vm_manager.pasid_lock, flags);  }
 
+void amdgpu_vm_get_memory(struct amdgpu_vm *vm, uint64_t *vram_mem,
+				uint64_t *gtt_mem)
+{
+	struct amdgpu_vm_bo_base *base = &vm->root.base;
+
+	list_for_each_entry(base, &vm->bo_list, bo_head){
+		struct amdgpu_bo *bo = amdgpu_bo_ref(base->bo);
+		if (!bo)
+			continue;
+		if (amdgpu_mem_type_to_domain(bo->tbo.mem.mem_type) ==
+				AMDGPU_GEM_DOMAIN_VRAM)
+				*vram_mem += amdgpu_bo_size(bo);
+		if (amdgpu_mem_type_to_domain(bo->tbo.mem.mem_type) ==
+				AMDGPU_GEM_DOMAIN_GTT)
+				*gtt_mem += amdgpu_bo_size(bo);
+		amdgpu_bo_unref(&bo);
+	}
+
+}
 /**
  * amdgpu_vm_set_task_info - Sets VMs task info.
  *
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
index 848e175e99ff..72727117c479 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
@@ -150,6 +150,7 @@ struct amdgpu_vm_bo_base {
 	/* protected by spinlock */
 	struct list_head		vm_status;
 
+	struct list_head		bo_head;
 	/* protected by the BO being reserved */
 	bool				moved;
 };
@@ -274,6 +275,7 @@ struct amdgpu_vm {
 	struct list_head	invalidated;
 	spinlock_t		invalidated_lock;
 
+	struct list_head	bo_list;
 	/* BO mappings freed, but not yet updated in the PT */
 	struct list_head	freed;
 
@@ -458,6 +460,8 @@ void amdgpu_vm_move_to_lru_tail(struct amdgpu_device *adev,
 				struct amdgpu_vm *vm);
 void amdgpu_vm_del_from_lru_notify(struct ttm_buffer_object *bo);
 
+void amdgpu_vm_get_memory(struct amdgpu_vm *vm, uint64_t *vram_mem,
+				uint64_t *gtt_mem);
 #if defined(CONFIG_DEBUG_FS)
 void amdgpu_debugfs_vm_bo_info(struct amdgpu_vm *vm, struct seq_file *m);  #endif
--
2.31.1
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
