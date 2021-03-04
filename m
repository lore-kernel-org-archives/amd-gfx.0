Return-Path: <SRS0=anlk=IC=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38463C433E0
	for <amd-gfx@archiver.kernel.org>; Thu,  4 Mar 2021 06:53:48 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B1B7E64EC4
	for <amd-gfx@archiver.kernel.org>; Thu,  4 Mar 2021 06:53:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B1B7E64EC4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 33A5A6E101;
	Thu,  4 Mar 2021 06:53:47 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2074.outbound.protection.outlook.com [40.107.220.74])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D65F66E101
 for <amd-gfx@lists.freedesktop.org>; Thu,  4 Mar 2021 06:53:45 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iCgT5WVcdiWiYQUb5fqVZrN9HOkKtCQXZkGKJzH1oA1o6EoFIU6xmymDN9F2q+Yjl+y2WGAhJ6Mzs13CH5GM76lXIIBmHYI0se8CwBgI9qS3MnkwZyqywpp7PGf4t6qT0Ns0ae/ZLpXRykFIcFsdOGhS/zDflmrR/aM7ZTZ9hxIrKXGK1vo2RtlHded+wIypMGze2WovmK/TFptp2+l4JDU8svBg6ignAPov1Rn6DpoLclyZOWIuAMW+2XrgeUXi8pmzLRGBFX/cincxPz885fDa1xaIDXzOtvyi+nXSMhcYAFU15Hm/MGPNyvVYeSLEaYc7lvebkz6BFOu4PEWkzA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=s8jk6IjiC57ZtonfwIijPrEdaA4znO3SxsjN72NOYPg=;
 b=hAsbAfCU9jNofjsv0KZKKjiuMXhD5i1McqOnFV2+cSaRLd3kLTGczyRxzHqbSmRYV2/HpCdoj31ZMMrqPbxsGK65Lu+wANqrTuf077U41pAV51qoCBJkifU46g/r+/ta0YS7la68OCi9dbta8b2gSV4DlWvJO2SoXvvOvx2RYo842l16bXYBmIvKEN/nQ4pUjX19+MkidzpiOtU1oao2/3d1KBD1iAQ+eGDM5BSaIYCOTv7RMh2nxveOSNR6t6e/8HrB2O2LfO686Zoeh1jAcy9Z4KviwLSHglyPrWeKEAaVDj+9e4bQZgVFeAX8Y4hCQHKIaPcoMJAHqv3GM3UwfA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=s8jk6IjiC57ZtonfwIijPrEdaA4znO3SxsjN72NOYPg=;
 b=qVKjxs9zBf5HGDNRHSc3RoBtfJWzxZk8cLm3ba404WL1hxheVOm9EwJEi2RExp17jRnUfWwG7Xms8GwH7wXkMXlAwBV49yhiUDv0TVJjZ8maaVhgVeyhwMkBUSNHIPJCJhRk557gtku6N7YpaMASJoHxiFH1uUsJBErtVwK62BY=
Received: from DM6PR12MB4075.namprd12.prod.outlook.com (2603:10b6:5:21d::8) by
 DM5PR12MB1162.namprd12.prod.outlook.com (2603:10b6:3:72::13) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3890.19; Thu, 4 Mar 2021 06:53:44 +0000
Received: from DM6PR12MB4075.namprd12.prod.outlook.com
 ([fe80::34e3:c46e:188c:ef53]) by DM6PR12MB4075.namprd12.prod.outlook.com
 ([fe80::34e3:c46e:188c:ef53%5]) with mapi id 15.20.3890.029; Thu, 4 Mar 2021
 06:53:44 +0000
From: "Zhang, Hawking" <Hawking.Zhang@amd.com>
To: "Xu, Feifei" <Feifei.Xu@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amdgpu: add sdma 4_x interrupts printing
Thread-Topic: [PATCH] drm/amdgpu: add sdma 4_x interrupts printing
Thread-Index: AQHXEKjBrPNmyWH2rEm3/9G1PwE9japzY7cw
Date: Thu, 4 Mar 2021 06:53:44 +0000
Message-ID: <DM6PR12MB4075BD28F5F20D621E864867FC979@DM6PR12MB4075.namprd12.prod.outlook.com>
References: <20210304034450.37535-1-Feifei.Xu@amd.com>
In-Reply-To: <20210304034450.37535-1-Feifei.Xu@amd.com>
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
x-ms-office365-filtering-correlation-id: 95caf3ef-eb2f-4be9-0b4b-08d8deda40ca
x-ms-traffictypediagnostic: DM5PR12MB1162:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM5PR12MB1162E66831DF3220EC25BFEDFC979@DM5PR12MB1162.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:364;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: mlsoP8PKu5txnwIfP7WxMAWyJ6Wiq/ouQ7uPPxxU4IIZUIt9bCd/D5d5m03+5JKBFGMeJbF2AIJACel05ZfLhCUQxuamva5lWORhLWONqRend9EQOat+MtoP3Rg9b9lG9bSoujbdTchpAXTSfXDcc88K4M+iZFXR+ixWx02G/77X6qGkM8PamreXytT+0t39aUpfNmGMuQ3rrfh2uIw7U8jB70EAXpNrbOwPdxVq9jhnJBNr3Wjkq/7cP5cs+mgPExSnTw276be4Gt6UA6H6T3tV1KNwtYxNLvLmZMgiZ+8A1iodBBkP65KZ2VZy8yNu+bsK0/6KWbr49WRtJamRP8R+sDn1nTzA/GIxk16F5mW+ykNLBQMKPFmcd3OMJW8CwFvXz4IK/R+zfTx4mCzcmp5oP6QHEKbr0tKPM8ecjLNPs4Vl2M8/Tjn5rUv1+Lt7ZzPdDL8vXpNcEj8al1Nn1w8ZpOj+S3yYUU8El9OXXfMLo8xnCD0blpziINjWRvJD4pRRVbTWLB0Ddlhzc/cb+A==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB4075.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(396003)(376002)(346002)(136003)(39860400002)(366004)(76116006)(66446008)(66476007)(64756008)(110136005)(66946007)(66556008)(83380400001)(478600001)(33656002)(7696005)(2906002)(6506007)(71200400001)(52536014)(8936002)(9686003)(55016002)(5660300002)(86362001)(26005)(4326008)(186003)(8676002)(53546011)(316002);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?NKNumd49hyaPZ4qw2HvVHya/u4t+walW1zQcXRH8dgVDtpcPyFm6s7TKSKAW?=
 =?us-ascii?Q?BABMyJTF6O4LbdijxVgz9yssaE+VR0nzy+rtf6Q8jrvur337vaS/3IZcMVOX?=
 =?us-ascii?Q?X5Hbkxp+FYw5LybpC5yUD/HIU9lZPEicpWbnqJLdwMrwBWVaD6vPmV88Wr4W?=
 =?us-ascii?Q?HGPjmNgoWzPvlXNNkav6KF8i3AgJAy1tlBZ/6X/ig9coa2d9Yozn8fBvYTF1?=
 =?us-ascii?Q?oBQpueXESUm1WCZWsexl88q/dpUqHbSE0ErFsLM2k0BH/aDmFpm5kVCw2Hy3?=
 =?us-ascii?Q?34ziKqCNRNwY1Dw3YwSCHLRwQyLjaA/49D54iIRmUZORK2Wd+Xj7w83TDXr+?=
 =?us-ascii?Q?+v7m6AyZ6YJBkBq7cwKruZL1Fx9u/r5GWiHaa3a7CWfybqH0Z8gfnL0urqSo?=
 =?us-ascii?Q?Ty69D5u5C41wRvzebxvtzKCu88e4Zj/i2PKJ4uCSgifaVeuozqcWFIvHPy+a?=
 =?us-ascii?Q?7x358I4zBhwG6GDm4F7YbMedtAkCU2w9GWLQ44TUzSyrll7Z/rJxD8MmHIXn?=
 =?us-ascii?Q?XqDk4xlMCiqiVQB6/DTUHnkvaUWShOLknPOeByX/POdNtQD9FmK3UBOy7FB6?=
 =?us-ascii?Q?xn3TOLrq0WpoZplcUFzofzUcaw6sHAotSnQZrdmZt3pIkpuV2vppq1FKQnSo?=
 =?us-ascii?Q?BvNSD5sv79QOVkCWIc8yzF0UwdWLNqW5d5bW/n8CJSmfnkq/p7AsZ1vB7E+n?=
 =?us-ascii?Q?JUl86MYC4e9bh2AEYIg+N2WCGileC79TquBFL7JH7IpC+DMNFk0rg0QpWN+P?=
 =?us-ascii?Q?AiSGJkZuqEdtEFSgxPUW8GBzjg8n4CTz+7txk1VsXRoyUo6f+v6TaIns0vzI?=
 =?us-ascii?Q?AdodiFFsOd7PFhHqkVbNEU2Qt09GdErQ7c+h4/HFrWlh+33VND/ZM2XbgThO?=
 =?us-ascii?Q?gfes75dmRyjymPHj3CXxWAUz22uHc6wINaXUi8KmeteY0a2AZf71cmaf/x9H?=
 =?us-ascii?Q?95df78Giy43xCBKjxKfw9av8o3mOTXihIXOA7Tr4/NvsRVVhTOEJsj9rkcuh?=
 =?us-ascii?Q?oISRcCMqCXxb0JkrTh4yGAyg9zhdSFZqjLLyoqQnROBRWDKrnGSwKFLn/nsp?=
 =?us-ascii?Q?gHtpY6bhCgvObWy2ZQmlBZzcMKMrvpF5yB1VWcfTecqRhR/nhmX9FZ3IjNj5?=
 =?us-ascii?Q?LNnVCRPAYExB6N74ITcpZu/4Jx3aKHjCt07odiY1zwWsIw8r7OQkzDn+Xbig?=
 =?us-ascii?Q?PnNFpcnj9+AedV24IpygDqOVMzYY9E6F4q2RiM3UHStAQaOW/OscnN6hNjBx?=
 =?us-ascii?Q?265tyFCx6kLFUbw+F53ORfX/IMs244sdo6m0dEcitqBo75bznR0pjmdLik8s?=
 =?us-ascii?Q?yMkBk0CCaTrNqYmzIVF9Q2aU?=
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4075.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 95caf3ef-eb2f-4be9-0b4b-08d8deda40ca
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Mar 2021 06:53:44.2810 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: txI8gcRQuReAvm03FldK9FRI41N6GOidtVR7Iw6pQldgSQiPwMJm8k42t6x6uajMgLmrRDX8T7JZs9d1vPmSYA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1162
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
