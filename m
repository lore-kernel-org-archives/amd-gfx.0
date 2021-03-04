Return-Path: <SRS0=anlk=IC=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA989C433DB
	for <amd-gfx@archiver.kernel.org>; Thu,  4 Mar 2021 07:24:01 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8D46664E21
	for <amd-gfx@archiver.kernel.org>; Thu,  4 Mar 2021 07:24:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8D46664E21
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 34B986E9F5;
	Thu,  4 Mar 2021 07:24:01 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2068.outbound.protection.outlook.com [40.107.92.68])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E7EA56E9EE
 for <amd-gfx@lists.freedesktop.org>; Thu,  4 Mar 2021 07:23:59 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZIV5D3tiZBv4uNu30/kwfDEnH7mijKGzqzCN5HjuS36A0uuNjssSbLunzcFoCum7EXkQ0e09EN4v+da1txPFDyjDCdYG2HbqejRCLRrP/kDta8NZ6EPuHAzTwpLyEhSGo3awAzkB581qYzCz4kxmvg39Kt6f4jqUJRT0ycl+BtJKQzOfLmaFLozzSh6qWvtEyFm7eimPL7z580g8d3i4cXQq3GvItsx5nb1yqZidp7J5odLsV39SLlSjMo4aiOZ1nR/1WaruUs0mtO8PSBhpj4b9rDn5w6vXKbD5FYKATcqVkHhYO6tcQwiiWXEs95XAvXZz8V5defOumkPwFiwwig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/v7fsbtazWSpNOBz5gKxy1P6VpOzhxeK2M7LbvrRg8g=;
 b=kD9ZR+gqzpp8bO2tmglxMI+mmdyxWQ9UPLcsbman4n3DJWE0iVqvOcC5ZcBa7D2tVby785SfxvtKZOgi8Y50XYKWzDufRwKdyj6X+LeuY64lv/lnxHlUmzWz6Fo/kf7ujvQnrUGQpeaqm2JaRlEd3voUz/dlqCLIx7tFmU0bJvfDz+lneqRJbG0N3dY508rxYhsO7XuucTLkuvu3AQ7iJ8Fkx27Wm9n7CsCuc2Zp5SielEw03ZgJRHhF1fXfUz5j8Pb60Pglh6yUtkj9QPWFrvtabhMeAiXpPBypIVtYL0CNk33SE9gBMLzCfyLQGTSuLq6Y2z4mSx6xOb7eP2q1xg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/v7fsbtazWSpNOBz5gKxy1P6VpOzhxeK2M7LbvrRg8g=;
 b=Q07qPKyltRljN8Ola7SPUKadktQzEJwz7SdcZCbcMgvzLDxrp7M6eAvWEqELphLK6Vp3oovEYtIfp66jvVpe62K+Ejy49isL51qwyjgdY/oNtrTVAzxhfbC32S0x1zk5o+07eAIwBJj0+LC/CSCWD2Uizjxnt9YGazUfxprDdng=
Received: from DM6PR12MB4603.namprd12.prod.outlook.com (2603:10b6:5:166::11)
 by DM6PR12MB2889.namprd12.prod.outlook.com (2603:10b6:5:18a::26) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3912.17; Thu, 4 Mar
 2021 07:23:56 +0000
Received: from DM6PR12MB4603.namprd12.prod.outlook.com
 ([fe80::69b7:e163:347a:ba70]) by DM6PR12MB4603.namprd12.prod.outlook.com
 ([fe80::69b7:e163:347a:ba70%6]) with mapi id 15.20.3890.028; Thu, 4 Mar 2021
 07:23:55 +0000
From: "Xu, Feifei" <Feifei.Xu@amd.com>
To: "Zhang, Hawking" <Hawking.Zhang@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amdgpu: add sdma 4_x interrupts printing
Thread-Topic: [PATCH] drm/amdgpu: add sdma 4_x interrupts printing
Thread-Index: AQHXEKjB3VxKJU9CgUSBgmz6yaxHXKpzZOoAgAAIHlA=
Date: Thu, 4 Mar 2021 07:23:55 +0000
Message-ID: <DM6PR12MB46039ECD2CC316B8F882CBB3FE979@DM6PR12MB4603.namprd12.prod.outlook.com>
References: <20210304034450.37535-1-Feifei.Xu@amd.com>
 <DM6PR12MB4075BD28F5F20D621E864867FC979@DM6PR12MB4075.namprd12.prod.outlook.com>
In-Reply-To: <DM6PR12MB4075BD28F5F20D621E864867FC979@DM6PR12MB4075.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Enabled=true;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_SetDate=2021-03-04T06:53:42Z; 
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Method=Privileged;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Name=Public_0;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_ActionId=0d0d4dec-5dfb-4899-bca2-2aa24e1fb5af;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_ContentBits=1
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [180.167.199.189]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 9061e566-b279-46cb-3410-08d8dede7890
x-ms-traffictypediagnostic: DM6PR12MB2889:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM6PR12MB28898BDD2AB78187815F8A6DFE979@DM6PR12MB2889.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:506;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: db915cis6v6KlH3YzZoLoPCAmLbe3s45Hcpof14WgaTOH+ZZuXj6ubeD30pWzZCZxy/KCZ0RKC7w5dh/fyhl+ckG9fdRJ2thHvlyP5kIo/gwQWytii+dzEcC0YQ7W7mhGTPzWqUD9UdBI4ZlheCMWMcTdRDJgz4JdVL6n73+u6gIfDjusKvUMGSbkVlQWo3FHVVg1mGB8bA3WFbUrhZVIORvU4hRPyvQc5Lel6tkr2wlm3tm8Nx3UtKNo+a8loWxiYr7SzdiPQsRkFLwpC2DW2NEDLhEZmYlxyYasTGrmpDxfndHbSWfw4GSI3yuzCwRrcteEa8WOziMtMU8QudiiOBjSC+uVGDKH2BYz6a67SR8JdPN1ozBuG3SSzf7YkQV91BOe9O3RijHwCyKmgZ5ABbfjLQLTKy9g/ZQhwGSAG3kvmEJrvRgnZ4swqLGGrg+6Xjn/PjcszUi+Dm5Gym2UvXqHG+k3JUTAWF0UYAjY2T5x5Ctrl5PJeNVenJomWDhOpF3LiVy3dE+BjdHxlkIAA==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB4603.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(39860400002)(136003)(376002)(396003)(346002)(366004)(8936002)(478600001)(55016002)(9686003)(26005)(53546011)(8676002)(71200400001)(86362001)(5660300002)(6506007)(186003)(66946007)(52536014)(7696005)(2906002)(33656002)(66446008)(76116006)(64756008)(66476007)(316002)(66556008)(83380400001)(110136005);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?q7rrKwR3OlV+mnFcCVKHeDHTPM8owWnhOb5HCDBM7PDU7s0Lue+HzH+uIMnM?=
 =?us-ascii?Q?dhFgnXDfJIQkCgc8CKvB+pE5QR35bRoZMbG0BoZRG0nVbHTx8pYiNzdhvzp2?=
 =?us-ascii?Q?yaIkqwDNHzVJwXoxpSunaw1xotUBmRUg+gMjToUFfopCm6CrXt0LuEO3/EWW?=
 =?us-ascii?Q?Dm34m4kTfIfjwYqz0gbKL9inVqSq4hYBxuDDCdAQzwfvgpFuEgUlPA90Btzg?=
 =?us-ascii?Q?EHx2bRokLDA6gHADNLGoLHe6yB6gKEFzRK46CoAhpEg8EeUxqYc4Smn1qDfN?=
 =?us-ascii?Q?2wm48i9NQIBzjUWVK1p3uRdP4a9qSe8yPIVsFg5pa2WCKedtOm+uym93pE68?=
 =?us-ascii?Q?fZmwfxa1y9W9FV7r/LZA02KTuleD6r87iPmNFHy0qLITcJuusFq/gaR1j6oe?=
 =?us-ascii?Q?9JbjlAyHkgmgZzW7cJiC69rnGaYP+LOCZzLmhye655E6p9qd9ruVeeGz8trh?=
 =?us-ascii?Q?u8iGxOt342dlJmZhdoAAQBjpespVGG+O6zRa61tcvTZRMoBhQHo7WEtuB4L2?=
 =?us-ascii?Q?2MIjFXpkFYhxPfJwB0XdqGL0/C6fA1/GVnqfCSWI3fP6vx50nUyNC52R56oE?=
 =?us-ascii?Q?ZLWI4yEqObpUrs7S/1YEhfC0qYIcIxskRp+6ZJSvYSYwPuLDpl54BVUUGooE?=
 =?us-ascii?Q?3gPQBtnran2D178vU16uxailiAtAS7+i/6VmXVKhcwKi3nolI4XamrS5BVYo?=
 =?us-ascii?Q?wKr1dnQ7TSeabNVGkiC1YcdnjqxxD9xjz0ibFzmSMeAeYB6kwO8k5CRSBx1p?=
 =?us-ascii?Q?IuWLZKS+Siz3l1mPt25sI3MjOQVpQptXgeQGsAW7bsxRRpy1NsU/S02ZwE2C?=
 =?us-ascii?Q?xJlbH2x5+gs0CDoma7bp0gW12h46g4RRXvWrx4xmp4KDL5ZuEvQ0qkDBjTsR?=
 =?us-ascii?Q?WBxYmwOSnJysp7eib5JtDFe9s+d8MSOjSBu3tZWdoFE6/oeXAfxYvpo1LzlQ?=
 =?us-ascii?Q?2M8cEmtLGDAQvi1yNIeSY10CitThlPmNmAt4LU09WAKJE/fqhPxgk+VZ31Qh?=
 =?us-ascii?Q?YcM8sFhhoq/VtPJjtrTo1rb7nrNwfY2VCSGJoulNZOLuqDomSrl0vQLCi/DP?=
 =?us-ascii?Q?EcTpd24OagSU0l9GHSTP2YWdYBF2o8TIfI2Cp1rAEWfiTVQdKtVqDc1E1H5a?=
 =?us-ascii?Q?ZGCfh/M8tmzoilhiRJzbsd/N+K2pvBCGKDAsox7ddf8M1hjezi5tzmC9Fkih?=
 =?us-ascii?Q?MN7QDdpkp/WT24cesNaG4/IrrFUFk98CLzicB3R2jP4xpXVKD0ocdhn1iXIg?=
 =?us-ascii?Q?pAchwvTsfEgZ282ZSZ+ZK9BE9zbPgRD9pEaeqabucHsGbCmDy918AK1BNJzb?=
 =?us-ascii?Q?HSOD3Um06ah+Wc+l4UwO6r5N?=
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4603.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9061e566-b279-46cb-3410-08d8dede7890
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Mar 2021 07:23:55.7868 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: E3JQkwVGQHgGzRA36kd7VXm33Q6ewsjnu9sTjd8oCxOdjts82bnZB+LwTRbMNNv5
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB2889
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Thanks. Will modify like this:
if (instance < 0 || instance > adev->sdma.num_instances) {

Thanks,
Feifei

-----Original Message-----
From: Zhang, Hawking <Hawking.Zhang@amd.com> 
Sent: Thursday, March 4, 2021 2:54 PM
To: Xu, Feifei <Feifei.Xu@amd.com>; amd-gfx@lists.freedesktop.org
Cc: Xu, Feifei <Feifei.Xu@amd.com>
Subject: RE: [PATCH] drm/amdgpu: add sdma 4_x interrupts printing

[AMD Public Use]

+	if (instance < 0 || instance > 7){

Please check sdma.num_instances for the maximum instance, instead of hard coded to 7. The SDMA instance numbers vary from ASIC to ASIC.

With above fixed, the patch is

Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>

Regards,
Hawking
-----Original Message-----
From: Feifei Xu <Feifei.Xu@amd.com> 
Sent: Thursday, March 4, 2021 11:45
To: amd-gfx@lists.freedesktop.org
Cc: Zhang, Hawking <Hawking.Zhang@amd.com>; Xu, Feifei <Feifei.Xu@amd.com>
Subject: [PATCH] drm/amdgpu: add sdma 4_x interrupts printing

Add VM_HOLE/DOORBELL_INVALID_BE/POLL_TIMEOUT/SRBMWRITE
interrupt info printing.

Signed-off-by: Feifei Xu <Feifei.Xu@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.h |   5 +
 drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c   | 119 +++++++++++++++++++++++
 2 files changed, 124 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.h
index e5b8fb8e75c5..f8fb755e3aa6 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.h
@@ -64,6 +64,11 @@ struct amdgpu_sdma {
 	struct amdgpu_irq_src	trap_irq;
 	struct amdgpu_irq_src	illegal_inst_irq;
 	struct amdgpu_irq_src	ecc_irq;
+	struct amdgpu_irq_src	vm_hole_irq;
+	struct amdgpu_irq_src	doorbell_invalid_irq;
+	struct amdgpu_irq_src	pool_timeout_irq;
+	struct amdgpu_irq_src	srbm_write_irq;
+
 	int			num_instances;
 	uint32_t                    srbm_soft_reset;
 	bool			has_page_queue;
diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c b/drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c
index 3bede8a70d7e..3305b8ec5025 100644
--- a/drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c
@@ -1944,6 +1944,33 @@ static int sdma_v4_0_sw_init(void *handle)
 			return r;
 	}
 
+	/* SDMA VM_HOLE/DOORBELL_INV/POLL_TIMEOUT/SRBM_WRITE_PROTECTION event*/
+	for (i = 0; i < adev->sdma.num_instances; i++) {
+		r = amdgpu_irq_add_id(adev, sdma_v4_0_seq_to_irq_id(i),
+				      SDMA0_4_0__SRCID__SDMA_VM_HOLE,
+				      &adev->sdma.vm_hole_irq);
+		if (r)
+			return r;
+
+		r = amdgpu_irq_add_id(adev, sdma_v4_0_seq_to_irq_id(i),
+				      SDMA0_4_0__SRCID__SDMA_DOORBELL_INVALID,
+				      &adev->sdma.doorbell_invalid_irq);
+		if (r)
+			return r;
+
+		r = amdgpu_irq_add_id(adev, sdma_v4_0_seq_to_irq_id(i),
+				      SDMA0_4_0__SRCID__SDMA_POLL_TIMEOUT,
+				      &adev->sdma.pool_timeout_irq);
+		if (r)
+			return r;
+
+		r = amdgpu_irq_add_id(adev, sdma_v4_0_seq_to_irq_id(i),
+				      SDMA0_4_0__SRCID__SDMA_SRBMWRITE,
+				      &adev->sdma.srbm_write_irq);
+		if (r)
+			return r;
+	}
+
 	for (i = 0; i < adev->sdma.num_instances; i++) {
 		ring = &adev->sdma.instance[i].ring;
 		ring->ring_obj = NULL;
@@ -2198,6 +2225,72 @@ static int sdma_v4_0_set_ecc_irq_state(struct amdgpu_device *adev,
 	return 0;
 }
 
+static int sdma_v4_0_print_iv_entry(struct amdgpu_device *adev,
+					      struct amdgpu_iv_entry *entry) {
+	int instance;
+	struct amdgpu_task_info task_info;
+	u64 addr;
+	instance = sdma_v4_0_irq_id_to_seq(entry->client_id);
+	if (instance < 0 || instance > 7){
+		dev_err(adev->dev, "sdma instance invalid %d\n", instance);
+		return -EINVAL;
+	}
+
+	addr = (u64)entry->src_data[0] << 12;
+	addr |= ((u64)entry->src_data[1] & 0xf) << 44;
+
+	memset(&task_info, 0, sizeof(struct amdgpu_task_info));
+	amdgpu_vm_get_task_info(adev, entry->pasid, &task_info);
+
+	dev_info(adev->dev,
+		   "[sdma%d] address:0x%016llx src_id:%u ring:%u vmid:%u "
+		   "pasid:%u, for process %s pid %d thread %s pid %d\n",
+		   instance, addr, entry->src_id, entry->ring_id, entry->vmid,
+		   entry->pasid, task_info.process_name, task_info.tgid,
+		   task_info.task_name, task_info.pid);
+	return 0;
+}
+
+static int sdma_v4_0_process_vm_hole_irq(struct amdgpu_device *adev,
+					      struct amdgpu_irq_src *source,
+					      struct amdgpu_iv_entry *entry) {
+	dev_err(adev->dev,"MC or SEM address in VM hole. \n");
+	sdma_v4_0_print_iv_entry(adev, entry);
+	return 0;
+}
+
+static int sdma_v4_0_process_doorbell_invalid_irq(struct amdgpu_device *adev,
+					      struct amdgpu_irq_src *source,
+					      struct amdgpu_iv_entry *entry) {
+	dev_err(adev->dev,
+		"SDMA received a doorbell from BIF with byte_enable != 0xff.  \n");
+	sdma_v4_0_print_iv_entry(adev, entry);
+	return 0;
+}
+
+static int sdma_v4_0_process_pool_timeout_irq(struct amdgpu_device *adev,
+					      struct amdgpu_irq_src *source,
+					      struct amdgpu_iv_entry *entry) {
+	dev_err(adev->dev,
+		"Polling register/memory timeout executing POLL_REG/MEM with finite timer\n");
+	sdma_v4_0_print_iv_entry(adev, entry);
+	return 0;
+}
+
+static int sdma_v4_0_process_srbm_write_irq(struct amdgpu_device *adev,
+					      struct amdgpu_irq_src *source,
+					      struct amdgpu_iv_entry *entry) {
+	dev_err(adev->dev,
+		"SDMA gets an Register Write SRBM_WRITE command in non-privilege command buffer.\n");
+	sdma_v4_0_print_iv_entry(adev, entry);
+	return 0;
+}
+
 static void sdma_v4_0_update_medium_grain_clock_gating(
 		struct amdgpu_device *adev,
 		bool enable)
@@ -2515,7 +2608,21 @@ static const struct amdgpu_irq_src_funcs sdma_v4_0_ecc_irq_funcs = {
 	.process = amdgpu_sdma_process_ecc_irq,  };
 
+static const struct amdgpu_irq_src_funcs sdma_v4_0_vm_hole_irq_funcs = {
+	.process = sdma_v4_0_process_vm_hole_irq, };
+
+static const struct amdgpu_irq_src_funcs sdma_v4_0_doorbell_invalid_irq_funcs = {
+	.process = sdma_v4_0_process_doorbell_invalid_irq,
+};
 
+static const struct amdgpu_irq_src_funcs sdma_v4_0_pool_timeout_irq_funcs = {
+	.process = sdma_v4_0_process_pool_timeout_irq,
+};
+
+static const struct amdgpu_irq_src_funcs sdma_v4_0_srbm_write_irq_funcs = {
+	.process = sdma_v4_0_process_srbm_write_irq, };
 
 static void sdma_v4_0_set_irq_funcs(struct amdgpu_device *adev)  { @@ -2527,10 +2634,18 @@ static void sdma_v4_0_set_irq_funcs(struct amdgpu_device *adev)
 	case 5:
 		adev->sdma.trap_irq.num_types = AMDGPU_SDMA_IRQ_INSTANCE5;
 		adev->sdma.ecc_irq.num_types = AMDGPU_SDMA_IRQ_INSTANCE5;
+		adev->sdma.vm_hole_irq.num_types = AMDGPU_SDMA_IRQ_INSTANCE5;
+		adev->sdma.doorbell_invalid_irq.num_types = AMDGPU_SDMA_IRQ_INSTANCE5;
+		adev->sdma.pool_timeout_irq.num_types = AMDGPU_SDMA_IRQ_INSTANCE5;
+		adev->sdma.srbm_write_irq.num_types = AMDGPU_SDMA_IRQ_INSTANCE5;
 		break;
 	case 8:
 		adev->sdma.trap_irq.num_types = AMDGPU_SDMA_IRQ_LAST;
 		adev->sdma.ecc_irq.num_types = AMDGPU_SDMA_IRQ_LAST;
+		adev->sdma.vm_hole_irq.num_types = AMDGPU_SDMA_IRQ_INSTANCE5;
+		adev->sdma.doorbell_invalid_irq.num_types = AMDGPU_SDMA_IRQ_LAST;
+		adev->sdma.pool_timeout_irq.num_types = AMDGPU_SDMA_IRQ_LAST;
+		adev->sdma.srbm_write_irq.num_types = AMDGPU_SDMA_IRQ_LAST;
 		break;
 	case 2:
 	default:
@@ -2541,6 +2656,10 @@ static void sdma_v4_0_set_irq_funcs(struct amdgpu_device *adev)
 	adev->sdma.trap_irq.funcs = &sdma_v4_0_trap_irq_funcs;
 	adev->sdma.illegal_inst_irq.funcs = &sdma_v4_0_illegal_inst_irq_funcs;
 	adev->sdma.ecc_irq.funcs = &sdma_v4_0_ecc_irq_funcs;
+	adev->sdma.vm_hole_irq.funcs = &sdma_v4_0_vm_hole_irq_funcs;
+	adev->sdma.doorbell_invalid_irq.funcs = &sdma_v4_0_doorbell_invalid_irq_funcs;
+	adev->sdma.pool_timeout_irq.funcs = &sdma_v4_0_pool_timeout_irq_funcs;
+	adev->sdma.srbm_write_irq.funcs = &sdma_v4_0_srbm_write_irq_funcs;
 }
 
 /**
--
2.25.1
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
