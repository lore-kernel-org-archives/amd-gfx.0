Return-Path: <SRS0=anlk=IC=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39AA2C433DB
	for <amd-gfx@archiver.kernel.org>; Thu,  4 Mar 2021 07:41:21 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EE65B6023B
	for <amd-gfx@archiver.kernel.org>; Thu,  4 Mar 2021 07:41:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EE65B6023B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B64956E9FC;
	Thu,  4 Mar 2021 07:41:20 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2055.outbound.protection.outlook.com [40.107.243.55])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 19E9F6E9FC
 for <amd-gfx@lists.freedesktop.org>; Thu,  4 Mar 2021 07:41:20 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LbS4iMW/6rGQMsgB9UFZWTdhGnGdmXxtag5kIi8IHWBbCSuGKM/lTm4cYxtyo90OCWyFp/BdwESvzplnIHs6hUdC/resAiZBf5AtUtDKGSY9F1EQ3AzBWDLxQHp1sKVZo4/AoITC9IP+mVhLwmjfSao2gnx3gSRfmbmkndFc6AKl4CatRTH5R7KyB3KL9JrK1f/1ixOxiDMWOrlmOpbR7r94djR7vIkmBSmF23ISnwPw5DZakC0lwyzCc/GmakxoQFpKfbAj1JPyN7SmHefPhIJVOWapWoqW4Wj5upveZEgzxwDRD/5BUqVdXhJ6MTTHSZu2JHNSqt9zxBlwnQiHyg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sI5nXfdd0MFidp6wCbJFv2YO4RkKpAH6I3SMo3s7oZM=;
 b=Ugb4gFFJSXuaDDng9wykDiGoHdW2wu8Vz0Bqg9l6Tdr5i+rjB1va4bq8FaHwsNMjfqRm4/ifgA1xMsiMgUihAwOt/DyD3TUTer27l13DOcsCo6fJI6gNSWpp7BUfgW75La4jF0hFJXX90vIF4XIVFTVOpwt8iSvW5umETQwFp/PymA1xpeXULJ+S8BIamsNN/By1EaG6W6F4bf92UEnsBrN2yk724V/s0diADmDFynr9oUccN//UwzQy8S6kiaxHiPKiYxQMIR26B+OgZdAgSTWCdpgJFDrHLFjunup2keYbi+8La8MMsuhvPCTwjidGbIGLcknK0mAKUu5ydcPdGg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sI5nXfdd0MFidp6wCbJFv2YO4RkKpAH6I3SMo3s7oZM=;
 b=yAD48OoOPqHJIvDZe7NFfrDehsiZGN8Xr4smUoxv3V/J7oI5QVkbRJhdZ7s8VIw4kTRYvvSBSGoUHRgnnCzSxUQmuTQHURhju+NrAeRdkI4tWMRMUP0PZdCjrQUdzaeojpMqtAMKwU+PSc4HciuXcD/7lMNORLpz5RNjPUFqQEw=
Received: from DM6PR12MB4603.namprd12.prod.outlook.com (2603:10b6:5:166::11)
 by DM5PR12MB1770.namprd12.prod.outlook.com (2603:10b6:3:108::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3890.28; Thu, 4 Mar
 2021 07:41:18 +0000
Received: from DM6PR12MB4603.namprd12.prod.outlook.com
 ([fe80::69b7:e163:347a:ba70]) by DM6PR12MB4603.namprd12.prod.outlook.com
 ([fe80::69b7:e163:347a:ba70%6]) with mapi id 15.20.3890.028; Thu, 4 Mar 2021
 07:41:18 +0000
From: "Xu, Feifei" <Feifei.Xu@amd.com>
To: "Xu, Feifei" <Feifei.Xu@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amdgpu: add sdma 4_x interrupts printing
Thread-Topic: [PATCH] drm/amdgpu: add sdma 4_x interrupts printing
Thread-Index: AQHXEMmXvx51eh+iBEqwH8f17wiJTqpzcb8A
Date: Thu, 4 Mar 2021 07:41:17 +0000
Message-ID: <DM6PR12MB460392995608AA07E08BE380FE979@DM6PR12MB4603.namprd12.prod.outlook.com>
References: <20210304073953.51400-1-Feifei.Xu@amd.com>
In-Reply-To: <20210304073953.51400-1-Feifei.Xu@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ActionId=b7e7d138-c9db-40e1-b0ba-7bcf8041e94f;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ContentBits=0;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Enabled=true;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Method=Standard;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Name=Internal
 Use Only - Unrestricted;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SetDate=2021-03-04T07:40:34Z;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [180.167.199.189]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 346b6c93-c95a-4fcf-90e3-08d8dee0e5b9
x-ms-traffictypediagnostic: DM5PR12MB1770:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM5PR12MB17701E6782D46B7DB5F811C1FE979@DM5PR12MB1770.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:386;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: sCjQerGw85IGX44uHoQkZ/tGqHpvBPdFJVJr5kFP/BJiD0bDiHMmIw8Sz+JaTJp0NtUh087Hv5Q+EwBYdK5s/oYst1xR2rEac92y2uLix5JYpvesn0iA2QKGH8upNHilpdauOCYT1V5786zBMUPB/FvZ5rWi7coNkyA5pEP9Eyp2PPWAzB4yrOp0TvkavfTVFGvsLHPNnt0xiTW/1nZDuTInk6AOUQS+1S/ecEuKUhaVgLqwTVtJBLMVZ/Ac7OHD00qD45ixBiMJxdtfZVihstpuD2qrSFv7Fmvv5zPJjuD2C+8+9Vy5GJm0q5cUSjHY+Ga3lfSGBEUE3lHWNh1tiUVMt/usdpqPeY4GpGyd2OBeBBmZ1GfuioxEUvXHKezSnNOLE7eKDdZAY/gIaFFweGE7+JtuFO6Ij66G1WSH5sd9ycl52bvveuTYZ42UkIZXreAbnG79wA9g/gy3knzOQ369AIgnatNlhN0PUW0xPHSq+myNGUZr0NZFBCsDMmc/5J7a5XqRCAZcbSWEMD2TbQ==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB4603.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(396003)(376002)(366004)(39860400002)(136003)(346002)(7696005)(55016002)(316002)(2906002)(83380400001)(5660300002)(52536014)(26005)(66476007)(64756008)(66446008)(66946007)(66556008)(53546011)(71200400001)(8676002)(186003)(6506007)(478600001)(4326008)(9686003)(86362001)(76116006)(8936002)(110136005)(33656002);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?IhnhvgUNmVhuYXogmE98FaWONPjhR0QcZYDslXnFoRo9J96c8QGVGhvFhKph?=
 =?us-ascii?Q?zgzc6xsmIri3RbvD8CJsZ/X3QGiQKTaiSzdN7iTjetomr7sajtY8vF2W0P6H?=
 =?us-ascii?Q?h34dYQsAAavSzxENGS/td7fbubcBfhruf89syaQV0Vw6pskBl7CmEeBuh+tM?=
 =?us-ascii?Q?JyumO4b5vRVVa9GcpI2x8PJKPmZ7SNBMI+YaXv4qHVAln2eCRo/wVRhzfUzI?=
 =?us-ascii?Q?k9VAvb0cSdC0dezbjfJZ9+62VZt4JHjUXb9qVDqx4pI8I6toPwDrTPn7ZWsH?=
 =?us-ascii?Q?jNwI08JMhN3oHJZEeJ3zvQwJBZTvCnQIcte6wvJQRJNSh1oSzk8sgIwO/JIO?=
 =?us-ascii?Q?OqCjcTw+bfwKH1spSt78x/TdSQ3ChuO40mlJ7kGISpn07uPfWwqHdohkwYLk?=
 =?us-ascii?Q?q7uWbF/TBuTWlsXhqzPzLSfHe3NkZtNzkFQHSU146RpHBKB1D7gHQi4l1rVq?=
 =?us-ascii?Q?4DyXUFB2VbEwWcvl9J5tEEIT1TEZdSb6ZkBYiMXpHB16f67XOXDaaSyBnNJt?=
 =?us-ascii?Q?QuzPkR9I9tcg9+XPHk1qPMxLYmnDsHQINKX4ezNWnixNWIBaPphHZmuD2Vyy?=
 =?us-ascii?Q?vRlzd8p0q1FMrJwpkH5RpD96TGO0GaqmmhAKaghpdOM6pvcmCgos9xUXqP65?=
 =?us-ascii?Q?jXgv2Lg126jBkiypzvE5WZaV9HS1TxQgo9rJJ4o0v5JvQ1nob05UF5CGwAro?=
 =?us-ascii?Q?vj5/8/MhMEApjYkNFXoyTDx76D2ZOa0vCu9Tfg6JnMxg9c1YYm7UHeF5Kr+g?=
 =?us-ascii?Q?feJr38TlMKmRYQhvVi+CgmGatAA1HodvMYIytwZUshB5c5PMA/JdBtX+XhzW?=
 =?us-ascii?Q?cVZOpaIUpqp0+VxPkcPifmK2I9VgVU6SMRM1yTMddWpcnRBWahrvkAzOV0Rk?=
 =?us-ascii?Q?pI7yFkLjz2m+TZtq6h/BhypVYzBoj8EwzyQaFCzBvjFCR/tXd34XpqaZXUEY?=
 =?us-ascii?Q?nVK52WuB898sBGCw6TgsCmNv9sfY0kPYez7bgXWMPizWwO9Q7JG/b1MYSeL3?=
 =?us-ascii?Q?W1uauQbNq/7X0eGg8R/Hh2DbU2HW4qzD//daBuUTdnD5PFzn20NYqblruZKo?=
 =?us-ascii?Q?l/5NBO0VVeJq9SRLt5IDQJN45MuElwYv/cKaEFp2OjC7eJC0Kl3A7z35BdlY?=
 =?us-ascii?Q?PwAMLXsMNKHAmFDtSyasqKrtuKrieHdmz28VdK1bYclQJs+bPWEgVmPOJUsL?=
 =?us-ascii?Q?PTSSiFRcxCxYKRZrUdUDPc7S5Dy5s03uckw+tJu8/j1NLQ5lBNlccKzcdkHg?=
 =?us-ascii?Q?L53mK8k+TlxNdXKpnVDIrv2PdP2TQlllMGuYXfmUcZCsBaoJ+puySa1oBSVD?=
 =?us-ascii?Q?2ke5foMXmjtDkfBbZzj6BwAo?=
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4603.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 346b6c93-c95a-4fcf-90e3-08d8dee0e5b9
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Mar 2021 07:41:17.9730 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: iMYJDbIi5gpZZX6fv4a2DtdAQhj3jjIaQXP1BS/R8KyNc7SjJ8SlLEd+9kPg6Obh
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1770
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
Cc: "Zhang, Hawking" <Hawking.Zhang@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Official Use Only - Internal Distribution Only]

1) Fix the hardcode as:
if (instance < 0 || instance >= adev->sdma.num_instances) {

2) Fix some coding style error/warning

Thanks,
Feifei

-----Original Message-----
From: Feifei Xu <Feifei.Xu@amd.com>
Sent: Thursday, March 4, 2021 3:40 PM
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
 struct amdgpu_irq_srctrap_irq;
 struct amdgpu_irq_srcillegal_inst_irq;
 struct amdgpu_irq_srcecc_irq;
+struct amdgpu_irq_srcvm_hole_irq;
+struct amdgpu_irq_srcdoorbell_invalid_irq;
+struct amdgpu_irq_srcpool_timeout_irq;
+struct amdgpu_irq_srcsrbm_write_irq;
+
 intnum_instances;
 uint32_t                    srbm_soft_reset;
 boolhas_page_queue;
diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c b/drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c
index 70d247841d14..bcf3d62e3cb8 100644
--- a/drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c
@@ -1944,6 +1944,33 @@ static int sdma_v4_0_sw_init(void *handle)
 return r;
 }

+/* SDMA VM_HOLE/DOORBELL_INV/POLL_TIMEOUT/SRBM_WRITE_PROTECTION event*/
+for (i = 0; i < adev->sdma.num_instances; i++) {
+r = amdgpu_irq_add_id(adev, sdma_v4_0_seq_to_irq_id(i),
+      SDMA0_4_0__SRCID__SDMA_VM_HOLE,
+      &adev->sdma.vm_hole_irq);
+if (r)
+return r;
+
+r = amdgpu_irq_add_id(adev, sdma_v4_0_seq_to_irq_id(i),
+      SDMA0_4_0__SRCID__SDMA_DOORBELL_INVALID,
+      &adev->sdma.doorbell_invalid_irq);
+if (r)
+return r;
+
+r = amdgpu_irq_add_id(adev, sdma_v4_0_seq_to_irq_id(i),
+      SDMA0_4_0__SRCID__SDMA_POLL_TIMEOUT,
+      &adev->sdma.pool_timeout_irq);
+if (r)
+return r;
+
+r = amdgpu_irq_add_id(adev, sdma_v4_0_seq_to_irq_id(i),
+      SDMA0_4_0__SRCID__SDMA_SRBMWRITE,
+      &adev->sdma.srbm_write_irq);
+if (r)
+return r;
+}
+
 for (i = 0; i < adev->sdma.num_instances; i++) {
 ring = &adev->sdma.instance[i].ring;
 ring->ring_obj = NULL;
@@ -2198,6 +2225,72 @@ static int sdma_v4_0_set_ecc_irq_state(struct amdgpu_device *adev,
 return 0;
 }

+static int sdma_v4_0_print_iv_entry(struct amdgpu_device *adev,
+      struct amdgpu_iv_entry *entry) {
+int instance;
+struct amdgpu_task_info task_info;
+u64 addr;
+
+instance = sdma_v4_0_irq_id_to_seq(entry->client_id);
+if (instance < 0 || instance >= adev->sdma.num_instances) {
+dev_err(adev->dev, "sdma instance invalid %d\n", instance);
+return -EINVAL;
+}
+
+addr = (u64)entry->src_data[0] << 12;
+addr |= ((u64)entry->src_data[1] & 0xf) << 44;
+
+memset(&task_info, 0, sizeof(struct amdgpu_task_info));
+amdgpu_vm_get_task_info(adev, entry->pasid, &task_info);
+
+dev_info(adev->dev,
+   "[sdma%d] address:0x%016llx src_id:%u ring:%u vmid:%u "
+   "pasid:%u, for process %s pid %d thread %s pid %d\n",
+   instance, addr, entry->src_id, entry->ring_id, entry->vmid,
+   entry->pasid, task_info.process_name, task_info.tgid,
+   task_info.task_name, task_info.pid);
+return 0;
+}
+
+static int sdma_v4_0_process_vm_hole_irq(struct amdgpu_device *adev,
+      struct amdgpu_irq_src *source,
+      struct amdgpu_iv_entry *entry) {
+dev_err(adev->dev, "MC or SEM address in VM hole\n");
+sdma_v4_0_print_iv_entry(adev, entry);
+return 0;
+}
+
+static int sdma_v4_0_process_doorbell_invalid_irq(struct amdgpu_device *adev,
+      struct amdgpu_irq_src *source,
+      struct amdgpu_iv_entry *entry) {
+dev_err(adev->dev, "SDMA received a doorbell from BIF with byte_enable !=0xff\n");
+sdma_v4_0_print_iv_entry(adev, entry);
+return 0;
+}
+
+static int sdma_v4_0_process_pool_timeout_irq(struct amdgpu_device *adev,
+      struct amdgpu_irq_src *source,
+      struct amdgpu_iv_entry *entry) {
+dev_err(adev->dev,
+"Polling register/memory timeout executing POLL_REG/MEM with finite timer\n");
+sdma_v4_0_print_iv_entry(adev, entry);
+return 0;
+}
+
+static int sdma_v4_0_process_srbm_write_irq(struct amdgpu_device *adev,
+      struct amdgpu_irq_src *source,
+      struct amdgpu_iv_entry *entry) {
+dev_err(adev->dev,
+"SDMA gets an Register Write SRBM_WRITE command in non-privilege command buffer\n");
+sdma_v4_0_print_iv_entry(adev, entry);
+return 0;
+}
+
 static void sdma_v4_0_update_medium_grain_clock_gating(
 struct amdgpu_device *adev,
 bool enable)
@@ -2503,7 +2596,21 @@ static const struct amdgpu_irq_src_funcs sdma_v4_0_ecc_irq_funcs = {
 .process = amdgpu_sdma_process_ecc_irq,  };

+static const struct amdgpu_irq_src_funcs sdma_v4_0_vm_hole_irq_funcs = {
+.process = sdma_v4_0_process_vm_hole_irq, };
+
+static const struct amdgpu_irq_src_funcs sdma_v4_0_doorbell_invalid_irq_funcs = {
+.process = sdma_v4_0_process_doorbell_invalid_irq,
+};

+static const struct amdgpu_irq_src_funcs sdma_v4_0_pool_timeout_irq_funcs = {
+.process = sdma_v4_0_process_pool_timeout_irq,
+};
+
+static const struct amdgpu_irq_src_funcs sdma_v4_0_srbm_write_irq_funcs = {
+.process = sdma_v4_0_process_srbm_write_irq, };

 static void sdma_v4_0_set_irq_funcs(struct amdgpu_device *adev)  { @@ -2515,10 +2622,18 @@ static void sdma_v4_0_set_irq_funcs(struct amdgpu_device *adev)
 case 5:
 adev->sdma.trap_irq.num_types = AMDGPU_SDMA_IRQ_INSTANCE5;
 adev->sdma.ecc_irq.num_types = AMDGPU_SDMA_IRQ_INSTANCE5;
+adev->sdma.vm_hole_irq.num_types = AMDGPU_SDMA_IRQ_INSTANCE5;
+adev->sdma.doorbell_invalid_irq.num_types = AMDGPU_SDMA_IRQ_INSTANCE5;
+adev->sdma.pool_timeout_irq.num_types = AMDGPU_SDMA_IRQ_INSTANCE5;
+adev->sdma.srbm_write_irq.num_types = AMDGPU_SDMA_IRQ_INSTANCE5;
 break;
 case 8:
 adev->sdma.trap_irq.num_types = AMDGPU_SDMA_IRQ_LAST;
 adev->sdma.ecc_irq.num_types = AMDGPU_SDMA_IRQ_LAST;
+adev->sdma.vm_hole_irq.num_types = AMDGPU_SDMA_IRQ_INSTANCE5;
+adev->sdma.doorbell_invalid_irq.num_types = AMDGPU_SDMA_IRQ_LAST;
+adev->sdma.pool_timeout_irq.num_types = AMDGPU_SDMA_IRQ_LAST;
+adev->sdma.srbm_write_irq.num_types = AMDGPU_SDMA_IRQ_LAST;
 break;
 case 2:
 default:
@@ -2529,6 +2644,10 @@ static void sdma_v4_0_set_irq_funcs(struct amdgpu_device *adev)
 adev->sdma.trap_irq.funcs = &sdma_v4_0_trap_irq_funcs;
 adev->sdma.illegal_inst_irq.funcs = &sdma_v4_0_illegal_inst_irq_funcs;
 adev->sdma.ecc_irq.funcs = &sdma_v4_0_ecc_irq_funcs;
+adev->sdma.vm_hole_irq.funcs = &sdma_v4_0_vm_hole_irq_funcs;
+adev->sdma.doorbell_invalid_irq.funcs = &sdma_v4_0_doorbell_invalid_irq_funcs;
+adev->sdma.pool_timeout_irq.funcs = &sdma_v4_0_pool_timeout_irq_funcs;
+adev->sdma.srbm_write_irq.funcs = &sdma_v4_0_srbm_write_irq_funcs;
 }

 /**
--
2.25.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
