Return-Path: <SRS0=anlk=IC=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C924DC433DB
	for <amd-gfx@archiver.kernel.org>; Thu,  4 Mar 2021 07:48:29 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8056864EFC
	for <amd-gfx@archiver.kernel.org>; Thu,  4 Mar 2021 07:48:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8056864EFC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2CAB96EA02;
	Thu,  4 Mar 2021 07:48:29 +0000 (UTC)
Received: from NAM04-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam08on2051.outbound.protection.outlook.com [40.107.101.51])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3E9466EA02
 for <amd-gfx@lists.freedesktop.org>; Thu,  4 Mar 2021 07:48:28 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FACCrTtTVmAm9LW9rlnA4GzRRPJu43JLcmsFpYBrFdeFylN7myggPteyMFpGioyk+w6Jc/Yp+wTt3LknJyN2HyKNHDnI8VWhWh+7P2pO7IWgmWFF1Nu9lBVwMybgWh1jp12IwiOLNwFIX4hIk5eqqdzCndf/rbs70K5oke6y5MR6/XxrOZ97d5aI0fKGDfCBQbSJbO6DpewQPLNxzC4pNjBPfgwFCEov1/IOcoj2fJ97ZmPoNKjqakYUEsgLz4//5XNC7svNAjfM/Ddct3hd7R1HxbBAW1PL5PAxVg+0EQV7puP/Y87tRdVZI0bHF9Vr3bWySQKuZEfHOi+BWNhgxw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qEmJCssSSwmkMBxODUBJ5lNBKffs1/qC7MivRpf/TXE=;
 b=ZBqfogHjU8BJUyz11q5JZDqgO1Acu9J0O547kLt9e3eX+VV5v9FCdqd1K39uFT1iVOVPUrK1ZoQ1sX38/6+IPtnC7pWepXJw1aZzY4x/jRE0S+lN/4Y9Bva6RT6D/wGCthoRGtE5jHxgsP+arOf0XmWY4eM9Ld2mivAdyJbuLmh/r3Y2v0LcnF2eksTOKySvgwNXg+Tk9TLGYnA8nxwYErq/SMVgVgCXEbxMixMRVcSn+oVygArsxp1cSEQHw6rxm7xBPLDs+jBO1UFKyg6glPodhkHboFFtricGLf/cV5hdmdICbb09WLpn1KMJsAbvYUDPhhF+n5ogUpWo8Dy7Rg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qEmJCssSSwmkMBxODUBJ5lNBKffs1/qC7MivRpf/TXE=;
 b=mtRD0MOgtn4UXI48NfatcX/JmkuUVgWc3QlHIHkJckM/8tI7MnohEcIUkRjpj2ve5Z5d7ulN1R1OD+NdgLjaOsR1acTwNVCXNiofFvedBzo/kqSnT7N3ai1Fu1f+wIC2cbPr1Evz1Pr6IAADL/RjHeVkKP9Yjpp0vcdwCYJOq3s=
Received: from DM6PR12MB4075.namprd12.prod.outlook.com (2603:10b6:5:21d::8) by
 DM6PR12MB4959.namprd12.prod.outlook.com (2603:10b6:5:208::16) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3784.12; Thu, 4 Mar 2021 07:48:26 +0000
Received: from DM6PR12MB4075.namprd12.prod.outlook.com
 ([fe80::34e3:c46e:188c:ef53]) by DM6PR12MB4075.namprd12.prod.outlook.com
 ([fe80::34e3:c46e:188c:ef53%5]) with mapi id 15.20.3890.029; Thu, 4 Mar 2021
 07:48:26 +0000
From: "Zhang, Hawking" <Hawking.Zhang@amd.com>
To: "Xu, Feifei" <Feifei.Xu@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amdgpu: add sdma 4_x interrupts printing
Thread-Topic: [PATCH] drm/amdgpu: add sdma 4_x interrupts printing
Thread-Index: AQHXEMmXc0ixJFOuQEW724Ive4JQt6pzc9Vg
Date: Thu, 4 Mar 2021 07:48:26 +0000
Message-ID: <DM6PR12MB40755D720CAFA4AA2AB4A565FC979@DM6PR12MB4075.namprd12.prod.outlook.com>
References: <20210304073953.51400-1-Feifei.Xu@amd.com>
In-Reply-To: <20210304073953.51400-1-Feifei.Xu@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Enabled=true;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_SetDate=2021-03-04T07:48:24Z; 
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Method=Privileged;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Name=Public_0;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_ActionId=de530bfc-54df-4711-aa8e-4fbe67dcbb4c;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_ContentBits=1
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [180.167.199.189]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 7ce1c6a6-2b5c-4a24-8d1a-08d8dee1e538
x-ms-traffictypediagnostic: DM6PR12MB4959:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM6PR12MB4959DCB2EB7DD14E70DAE7D3FC979@DM6PR12MB4959.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:67;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 8pywWrM5WVGcF1f+JG2Ao+IofaMFznJfilmiyV3+4/dK/9WhmR6jBehmJOtl3h2W+Pt1pWdW3XeFoVc53Cx+GLrpG84ft4D8TWumzlckMkDEPvOdCkISX9jKULzO3AztIt8v7vW7r0adDjaUO6Rt9kvALDqtP4Z01JQrVGAv35OXhlqMQ8+lF9S7FZNHeVQjTXfI5SR/tEmGBN1gLu+YPfOjhclEEnL+GoCNglRiXg5CIGNrQJKrM2CzEPJuFN3Qkjo8sV/EYBKickxyCj8LViHYuYJcKD22FaWprKAtt5oQvE05w9XAk0VQQEu6P8CJCyCIem3fXcvrTDTIqns5jkI7jCjWg3K6ixSTLu7GR6C0jRihu++JV/8rR2druHq5rz204MELF+WNq7XVxpeJZlevV0r/UjtZ0xZmk1RftNybASlJueViymot+v/jkQcJGfHwkxQf1N3HuRFjsW63a7C2IUH9viK15zludmP+r67qXXsvqDKidZpxfQ5K51T/k0c3QWIUkoWrT3tQFD8g6g==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB4075.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(376002)(39860400002)(396003)(136003)(346002)(76116006)(66556008)(66946007)(55016002)(86362001)(64756008)(110136005)(9686003)(478600001)(66476007)(5660300002)(8936002)(26005)(186003)(4326008)(83380400001)(6506007)(52536014)(33656002)(7696005)(66446008)(316002)(8676002)(71200400001)(53546011)(2906002);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?4HdiViqzujq1iBivfWkdYi8QE3xVFNm8nQjt3Ez1W9TAi/pS5mr2tySdFsP2?=
 =?us-ascii?Q?1DWGUG3v2czMuRGHA80JYvwRumMv5GPPCthygasE2QDfR91yUdbi2WjPbQq3?=
 =?us-ascii?Q?H7ABSxCM2zt280dDXwAlY2r04H3ZUKCcFDNiKkKNtxiYGQoB5zc++HECsZKH?=
 =?us-ascii?Q?DauzAK/Ak7XJXsyC/72OpQ7nfC7tufttC9wu/E9spjnDbItC34gXDRM3XGN5?=
 =?us-ascii?Q?HJztfXcwOvxZ4DJiF5B5V1uMkmU1mIbTSgFYzdjQk5ipHJLIJYh99lQfKkoT?=
 =?us-ascii?Q?FUe5Eykt8QhufeOsnBYUYgKzurAcpyqtYuZwMg8woHVaOrbNsZHnNID8eHN0?=
 =?us-ascii?Q?0nmX5LZcGzJ5szbrAoLf5VwTbtJLpvU+sNnepGASWDzIaTCrEV/uWzuOM2vE?=
 =?us-ascii?Q?bOZci8NjMMsoPKUPXKbOTdBfRduXb/yZRt3YuOcXz+S3yyjFvPD3RNMURutZ?=
 =?us-ascii?Q?blUTKwGq15caIWtEY9uCt+rcSPrE0pdEoHua1khSdC21V/vMaYeoROG105lb?=
 =?us-ascii?Q?PCbfX5PCeRL+O/mV2XLnMxOx3uRUZmhd4lYz9JmnnFxLu+Jjp4Lu3HCgYjgp?=
 =?us-ascii?Q?wjqaB98dQcCdElMV8OWwIPtN7purmlO9zST76/DJN7XJYfBRMbPHbgvQhQ/e?=
 =?us-ascii?Q?hZT4U7aGc91zd3plMxZe6IEAQ7OvmIG3m1ss9jKqNr4GX+gXU74v2NVYDt3K?=
 =?us-ascii?Q?LLWQ0PpgKv2pduLkEuh01c3oZlRizOggIn5Lv+zYywqoC5PUUY9OeSX7VQcv?=
 =?us-ascii?Q?RRgR9HH22ZaULS1FJsbUbnKKvJ3SnywC/bFTC3wNQlAzTXuRTk3ePYaXKI7I?=
 =?us-ascii?Q?wycCQNvlDkLsnuwmAQr2qI9OwZlXhBzXCAqKfUvH+yGKS3+uFhLLphSZTr0L?=
 =?us-ascii?Q?qOnWWVEd/J7kXs7zTbmf0ChL4n8MOBuv67UDGZn8BcvJQ4fNUOHiGh64EUnV?=
 =?us-ascii?Q?BG7awFkCNi++JE4bYfm+Z5O5oRM8r6pj/QP2wDBDMjSbL34f9JUXxEorJkDn?=
 =?us-ascii?Q?m2KZUQS1KySzJQWG4qvLdYl3NPskfX8hIA21nsvghXIwiyHCLdCn3AUooUaO?=
 =?us-ascii?Q?NXS3H4+dn8Y+ENUOzLu6CZEzr7WSVn8NqWj8tsmmgtHm6pXJM+zWbG1bNnit?=
 =?us-ascii?Q?4eN8Zem/7af76KXtiw/OlOymymx0Vtleod6KmJx0h/+7t7VBZTBk4BrhVRty?=
 =?us-ascii?Q?LC6xKGkhmn0dJAONIZwhbSVytdHyatskG5iHOYuYaLC0iV9i0SziF0frY8aa?=
 =?us-ascii?Q?+foN8bHz5em6nSa5QXtndeHf7CjA8mK1HyIKs30dMuGPYlBBojl8DtpFGAfn?=
 =?us-ascii?Q?u990TXTwwKbR9XOj07qdWjSc?=
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4075.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7ce1c6a6-2b5c-4a24-8d1a-08d8dee1e538
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Mar 2021 07:48:26.6576 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Qw87T+chDzm1kaSKK5eYIWpS2I28epuXUJw/+o3fyV9AJUx/wz5gBPaIQIAlQthjqlHaEQbqHiJwGbDPzdOing==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4959
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
Cc: "Xu, Feifei" <Feifei.Xu@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Public Use]

Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>

Regards,
Hawking
-----Original Message-----
From: Feifei Xu <Feifei.Xu@amd.com> 
Sent: Thursday, March 4, 2021 15:40
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
index 70d247841d14..bcf3d62e3cb8 100644
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
+
+	instance = sdma_v4_0_irq_id_to_seq(entry->client_id);
+	if (instance < 0 || instance >= adev->sdma.num_instances) {
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
+	dev_err(adev->dev, "MC or SEM address in VM hole\n");
+	sdma_v4_0_print_iv_entry(adev, entry);
+	return 0;
+}
+
+static int sdma_v4_0_process_doorbell_invalid_irq(struct amdgpu_device *adev,
+					      struct amdgpu_irq_src *source,
+					      struct amdgpu_iv_entry *entry) {
+	dev_err(adev->dev, "SDMA received a doorbell from BIF with byte_enable !=0xff\n");
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
+		"SDMA gets an Register Write SRBM_WRITE command in non-privilege command buffer\n");
+	sdma_v4_0_print_iv_entry(adev, entry);
+	return 0;
+}
+
 static void sdma_v4_0_update_medium_grain_clock_gating(
 		struct amdgpu_device *adev,
 		bool enable)
@@ -2503,7 +2596,21 @@ static const struct amdgpu_irq_src_funcs sdma_v4_0_ecc_irq_funcs = {
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
 
 static void sdma_v4_0_set_irq_funcs(struct amdgpu_device *adev)  { @@ -2515,10 +2622,18 @@ static void sdma_v4_0_set_irq_funcs(struct amdgpu_device *adev)
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
@@ -2529,6 +2644,10 @@ static void sdma_v4_0_set_irq_funcs(struct amdgpu_device *adev)
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
