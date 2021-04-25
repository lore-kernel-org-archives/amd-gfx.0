Return-Path: <SRS0=b4Qt=JW=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80661C433B4
	for <amd-gfx@archiver.kernel.org>; Sun, 25 Apr 2021 07:18:30 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 09E9861480
	for <amd-gfx@archiver.kernel.org>; Sun, 25 Apr 2021 07:18:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 09E9861480
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AA2D66E4D4;
	Sun, 25 Apr 2021 07:18:29 +0000 (UTC)
Received: from NAM02-DM3-obe.outbound.protection.outlook.com
 (mail-dm3nam07on2042.outbound.protection.outlook.com [40.107.95.42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 690496E4D4
 for <amd-gfx@lists.freedesktop.org>; Sun, 25 Apr 2021 07:18:27 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Y9nXed3Cb15JvsjDfD29Rdm8epYyqVWHMExJgCB86uFLBoVxuYpfuKHiV0Tx8M3aZliaeO4ZpopI0aLcrXAoLN8ig0tMFEWvoyXr5OVW+sfBPDEvMw8jDrd8v5HAVfmiQzbRFO0osWMDTP9+esGmeZctZ8Y/vZpSRjWqRWdO67M7ZczUssOwZvwYbXdpBor4H/Dp473E3NtqK4fQm9C/Dy8NiRvsmprnXpmLVQirLzC2T3H5YuI7BmgXM5WfTwH5vnwh55iDnqzmgX6YtVjTN0kUZXmvJrOXmJyvvgx/atzotJ4MkmHkqNzYZQVOCx7z9vNYjIeO5gwhsB747cITEw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oPiTNJT6eoRy9Rz+OZuIzFYyYmm8Yj5C0dS+zGhKxjY=;
 b=VHueZBFOny8+5k3MtckLMuwsc16qTDjJlI2ts9tuAELI1h+EDyjVSo2xcIFsg2tFV6t00WcFxLHeiwDGyiSgcjO7RL+zycnIOm2CsEDuFniHIbPL9gvBbkiZS8b9RIF63m6dCn59r6twnjBX20vloqhDzWsKCpsDc+kz4ep2PdjZbxhMVEDac/wAWGvDhkXappPVRdVdfK7V/yPBxvCg2Z5lDKwMi9Qh2r/AW5g/6cJrvtdJUUpQ55fFlmUhsLbKKEkuSufP6QWhl71sv989QuOtmlmULweVcCYhUysRh+BZxaQzjHGmKnGtn6Q1aDCFrFXNs10aSmNTuCSOBsLl2w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oPiTNJT6eoRy9Rz+OZuIzFYyYmm8Yj5C0dS+zGhKxjY=;
 b=B2KoIWQFOTmWhArPgfXuEKrgb1LN1wMYaJV32poMR//Lg5utrAbkiS4OjEetqssaK7UUBBFNT2jEKV2nZbQS95UlFdeNjdBQ9Gr50BwXASLC0APXpuY9IrIM98N0gTocJmXN6Lg9R0M3HJ3GZ8VWNG4pvlb5owDYLsLqbRgGiR0=
Received: from DM6PR12MB4603.namprd12.prod.outlook.com (2603:10b6:5:166::11)
 by DM6PR12MB3691.namprd12.prod.outlook.com (2603:10b6:5:1c5::30) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4065.24; Sun, 25 Apr
 2021 07:18:25 +0000
Received: from DM6PR12MB4603.namprd12.prod.outlook.com
 ([fe80::555d:5042:518f:50d6]) by DM6PR12MB4603.namprd12.prod.outlook.com
 ([fe80::555d:5042:518f:50d6%5]) with mapi id 15.20.4065.025; Sun, 25 Apr 2021
 07:18:25 +0000
From: "Xu, Feifei" <Feifei.Xu@amd.com>
To: "Zhang, Hawking" <Hawking.Zhang@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amdgpu: correct sdma 4.x irq.num_types.
Thread-Topic: [PATCH] drm/amdgpu: correct sdma 4.x irq.num_types.
Thread-Index: AQHXOaH1SLFJaf5JwUWK7J84uJgF+6rE0ZIAgAABc3A=
Date: Sun, 25 Apr 2021 07:18:24 +0000
Message-ID: <DM6PR12MB4603A2BE48EAF80AC0EEE33EFE439@DM6PR12MB4603.namprd12.prod.outlook.com>
References: <20210425070934.44672-1-Feifei.Xu@amd.com>
 <BN9PR12MB5368A0D32092B97B38E8B51DFC439@BN9PR12MB5368.namprd12.prod.outlook.com>
In-Reply-To: <BN9PR12MB5368A0D32092B97B38E8B51DFC439@BN9PR12MB5368.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Enabled=true;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_SetDate=2021-04-25T07:12:56Z; 
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Method=Privileged;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Name=Public_0;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_ActionId=d8d760bf-2f38-4be5-80c5-be09553f6c9a;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_ContentBits=1
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [180.167.199.189]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 65f4d62a-957c-4311-58ae-08d907ba50d3
x-ms-traffictypediagnostic: DM6PR12MB3691:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM6PR12MB36917312A05F0AD29B334BF1FE439@DM6PR12MB3691.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:130;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: bzH8g23dhKiOrhnCaxkwrRN/X9c5AS4FFejde47EP3yecNJRuWHwAO1Bt2/5JquAiLfG2uhfnjieNAmkLTo04qglWecMP7lpohYeSi58hqW3hRST2x1YRiXrgq1n+0PzJEWwn4X6ERbwKz6G1wRuW1hmRTea/PiGMCWpEoli82W5JjvXrdkxe0LO3owvyi05yqko3YIZLLXC0ZiSvClpJG7IqMAhVkMA55S8fYwbR7r4AJ1jAnK6iKEwZg4YOAjtkzEmttJx/BdOvMVHyrXAx5SlonRQ+Rsmrwd0j1a9bZ3Jh+A5njhJCuq3FVmaco4dir14SUReGXBdvL1G8ymC/+7gfLg2dvDypfiQhofhSOSZWYKW5lFHQT0T3E+5o5wGmsA2jyZ6fBv5cgL/Erf6jYvOlNRyH7locpk6z8K2TRvay1mQaHbj/64E49d3Krd8rX9gxZxM7W2UeUx2OjTGjbrSAv8PmhF8HhiwphJcPnMO/ppBSBqil70CNszBRqI4MYXpxs/Fr19kVapbi50bz2EfUHi6pdTyD8F0Kurv456soiobWwh83YBfInhiiuI/Ay1nOf68u4QcF8dxdiSX13rApEZ/HFDBA+LGJ4xYVV4=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB4603.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(396003)(39860400002)(376002)(136003)(346002)(366004)(316002)(53546011)(110136005)(5660300002)(6506007)(52536014)(55016002)(66556008)(2906002)(9686003)(66446008)(66946007)(38100700002)(33656002)(7696005)(86362001)(71200400001)(122000001)(26005)(8676002)(8936002)(186003)(478600001)(66476007)(64756008)(76116006)(83380400001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?ZRfMwr8X7x4iiAk0bIeAxp8hhc12B2Ly+98GkzfeUmmEf3FA1QWxsjQkE9I8?=
 =?us-ascii?Q?gtW0wdiw+Gh3TBNuEgw9Nu1U5W6o/IV2VVnVAxHLgJeSasAW88uFK3343xGc?=
 =?us-ascii?Q?snNpFDltEoyHQDAa4jBXu3gSi69n9rWvE6Ncp+vp9dp7YaRabH/7v74Yltqq?=
 =?us-ascii?Q?fwPxzzeOsajuu16P0ibmm5dYDDVG30yy0Ys27ePfOe9P2ioFJDlMqBYq8Pp+?=
 =?us-ascii?Q?goQVJiMdJuSJrRYro5O18kd0zvxbtbBXnbfDUNuHOygyRSC2dIquDvklYQVr?=
 =?us-ascii?Q?FSVSRRPY8dxs1OpuH511o92Y9AENBpTY/31/TQb4bIzrv/Tz61Sl8vd8Y3FC?=
 =?us-ascii?Q?Xk6vQDokoXeSlS8P9GnNJa+c8vzZ0brP+pEXPblaNmsytvRIcv9KElT29Q8b?=
 =?us-ascii?Q?isi/JdnqPwVqurqQ7DogG/qEkLYQ/QrOS6GpLLNF9G5JJEWmLtXc4S/WcSzK?=
 =?us-ascii?Q?NELzwVilS2gv3Df0oie+l5MVqR43YiNoOjg8mczghhGOsWsIi4YCs1Uc0hWU?=
 =?us-ascii?Q?hJrUNeGkeAYKpVd+X0LlJ88m5K2Y/Cjb+gGAdr7QIkWWES5bkqC+ap09QNO0?=
 =?us-ascii?Q?60r/9BxR4GRqpj3NKUCDiZEM+UT0UyHNJydXwOwLW95rahwy1jDnQFUtSroE?=
 =?us-ascii?Q?AdjIBF9tpXrpsztbqUH6nVX+hKeicmqi3S2PIjQjNBYH3cbhhEZEOpte0oCW?=
 =?us-ascii?Q?f4v1/2P1REFCNG0FXxjOOwqJFKXSRYODOnSplbQc7MtKP4gmxNSiuvNn8mr/?=
 =?us-ascii?Q?OERRg7IlJ0ogCgvsEix50w2164DMZhslvAEVVkP2MCs0suUkezoAUnRXOHTD?=
 =?us-ascii?Q?SWyHF4nWVjWsw+0qdnMc935LiYJ7GfGEEhT59LZDVIl3RGbtRC/U3lotQ9kH?=
 =?us-ascii?Q?YA3hX4+/j+SUsDVHjNq/LWcTkVbnU59YJGz9rROGU2vC7JHDsh2kJdvf16uo?=
 =?us-ascii?Q?1cWypug5DucbLgeC/CbBDvJW1beJAV0WGjknlHq0itIwaJJydD1ib1yTmUG9?=
 =?us-ascii?Q?QvESCg/nmSWmEiRkeJ81ODGzJa31f231BpvJEGMX9ZIhzFzVcfr86STebtug?=
 =?us-ascii?Q?uGjtmznFSzXM2tVHZO/COCdBD78SAjWEbPzYVgBE5ra2ggIi59c2T/6JBSZR?=
 =?us-ascii?Q?zouthahNhDWAwiTWbhlFsIaffmcw8Gqa07sSnlDfiMHlUq9yiexi1KlFRVWM?=
 =?us-ascii?Q?KAT58UybFZXasR+q4CyO5+niWLiKZvFHNaSQ+F+MxyKxfDjOaoJibvGk9bxX?=
 =?us-ascii?Q?hLEPRyuvcTE+1RV8w/fPYLpJhrQJGwq3ekHnKnYsHcQn3gSrHhEn+u3rhucE?=
 =?us-ascii?Q?xBTeKT6RH0W4c5unXEChre8h?=
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4603.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 65f4d62a-957c-4311-58ae-08d907ba50d3
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Apr 2021 07:18:24.7357 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 7rugt2OHWLWJEqqkEwA42OrWe74gJLImkSEHlClX0cdqaHfEQVyQgZSm1CK4OtSA
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3691
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

Thanks. Will send V2 with the change.

Thanks,
Feifei

-----Original Message-----
From: Zhang, Hawking <Hawking.Zhang@amd.com> 
Sent: Sunday, April 25, 2021 3:13 PM
To: Xu, Feifei <Feifei.Xu@amd.com>; amd-gfx@lists.freedesktop.org
Cc: Xu, Feifei <Feifei.Xu@amd.com>
Subject: RE: [PATCH] drm/amdgpu: correct sdma 4.x irq.num_types.

[AMD Public Use]

Please split the patch into two so the commit description matches with the change.

Regards,
Hawking

-----Original Message-----
From: Feifei Xu <Feifei.Xu@amd.com>
Sent: Sunday, April 25, 2021 15:10
To: amd-gfx@lists.freedesktop.org
Cc: Zhang, Hawking <Hawking.Zhang@amd.com>; Xu, Feifei <Feifei.Xu@amd.com>
Subject: [PATCH] drm/amdgpu: correct sdma 4.x irq.num_types.

Change the sdma interrupt info print level to debug.

Signed-off-by: Feifei Xu <Feifei.Xu@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c | 28 +++++++++++++++-----------
 1 file changed, 16 insertions(+), 12 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c b/drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c
index fbb701560ced..7870fd09d98d 100644
--- a/drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c
@@ -2220,7 +2220,7 @@ static int sdma_v4_0_print_iv_entry(struct amdgpu_device *adev,
 
 	instance = sdma_v4_0_irq_id_to_seq(entry->client_id);
 	if (instance < 0 || instance >= adev->sdma.num_instances) {
-		dev_err_ratelimited(adev->dev, "sdma instance invalid %d\n", instance);
+		dev_err(adev->dev, "sdma instance invalid %d\n", instance);
 		return -EINVAL;
 	}
 
@@ -2230,7 +2230,7 @@ static int sdma_v4_0_print_iv_entry(struct amdgpu_device *adev,
 	memset(&task_info, 0, sizeof(struct amdgpu_task_info));
 	amdgpu_vm_get_task_info(adev, entry->pasid, &task_info);
 
-	dev_info_ratelimited(adev->dev,
+	dev_dbg_ratelimited(adev->dev,
 		   "[sdma%d] address:0x%016llx src_id:%u ring:%u vmid:%u "
 		   "pasid:%u, for process %s pid %d thread %s pid %d\n",
 		   instance, addr, entry->src_id, entry->ring_id, entry->vmid, @@ -2243,7 +2243,7 @@ static int sdma_v4_0_process_vm_hole_irq(struct amdgpu_device *adev,
 					      struct amdgpu_irq_src *source,
 					      struct amdgpu_iv_entry *entry)  {
-	dev_err_ratelimited(adev->dev, "MC or SEM address in VM hole\n");
+	dev_dbg_ratelimited(adev->dev, "MC or SEM address in VM hole\n");
 	sdma_v4_0_print_iv_entry(adev, entry);
 	return 0;
 }
@@ -2253,7 +2253,7 @@ static int sdma_v4_0_process_doorbell_invalid_irq(struct amdgpu_device *adev,
 					      struct amdgpu_iv_entry *entry)  {
 
-	dev_err_ratelimited(adev->dev, "SDMA received a doorbell from BIF with byte_enable !=0xff\n");
+	dev_dbg_ratelimited(adev->dev, "SDMA received a doorbell from BIF with 
+byte_enable !=0xff\n");
 	sdma_v4_0_print_iv_entry(adev, entry);
 	return 0;
 }
@@ -2262,7 +2262,7 @@ static int sdma_v4_0_process_pool_timeout_irq(struct amdgpu_device *adev,
 					      struct amdgpu_irq_src *source,
 					      struct amdgpu_iv_entry *entry)  {
-	dev_err_ratelimited(adev->dev,
+	dev_dbg_ratelimited(adev->dev,
 		"Polling register/memory timeout executing POLL_REG/MEM with finite timer\n");
 	sdma_v4_0_print_iv_entry(adev, entry);
 	return 0;
@@ -2272,7 +2272,7 @@ static int sdma_v4_0_process_srbm_write_irq(struct amdgpu_device *adev,
 					      struct amdgpu_irq_src *source,
 					      struct amdgpu_iv_entry *entry)  {
-	dev_err_ratelimited(adev->dev,
+	dev_dbg_ratelimited(adev->dev,
 		"SDMA gets an Register Write SRBM_WRITE command in non-privilege command buffer\n");
 	sdma_v4_0_print_iv_entry(adev, entry);
 	return 0;
@@ -2609,14 +2609,18 @@ static void sdma_v4_0_set_irq_funcs(struct amdgpu_device *adev)
 	case 5:
 		adev->sdma.trap_irq.num_types = AMDGPU_SDMA_IRQ_INSTANCE5;
 		adev->sdma.ecc_irq.num_types = AMDGPU_SDMA_IRQ_INSTANCE5;
+		adev->sdma.vm_hole_irq.num_types = AMDGPU_SDMA_IRQ_INSTANCE5;
+		adev->sdma.doorbell_invalid_irq.num_types = AMDGPU_SDMA_IRQ_INSTANCE5;
+		adev->sdma.pool_timeout_irq.num_types = AMDGPU_SDMA_IRQ_INSTANCE5;
+		adev->sdma.srbm_write_irq.num_types = AMDGPU_SDMA_IRQ_INSTANCE5;
 		break;
 	case 8:
-		adev->sdma.trap_irq.num_types = AMDGPU_SDMA_IRQ_LAST;
-		adev->sdma.ecc_irq.num_types = AMDGPU_SDMA_IRQ_LAST;
-		adev->sdma.vm_hole_irq.num_types = AMDGPU_SDMA_IRQ_INSTANCE5;
-		adev->sdma.doorbell_invalid_irq.num_types = AMDGPU_SDMA_IRQ_LAST;
-		adev->sdma.pool_timeout_irq.num_types = AMDGPU_SDMA_IRQ_LAST;
-		adev->sdma.srbm_write_irq.num_types = AMDGPU_SDMA_IRQ_LAST;
+		adev->sdma.trap_irq.num_types = AMDGPU_SDMA_IRQ_INSTANCE7;
+		adev->sdma.ecc_irq.num_types = AMDGPU_SDMA_IRQ_INSTANCE7;
+		adev->sdma.vm_hole_irq.num_types = AMDGPU_SDMA_IRQ_INSTANCE7;
+		adev->sdma.doorbell_invalid_irq.num_types = AMDGPU_SDMA_IRQ_INSTANCE7;
+		adev->sdma.pool_timeout_irq.num_types = AMDGPU_SDMA_IRQ_INSTANCE7;
+		adev->sdma.srbm_write_irq.num_types = AMDGPU_SDMA_IRQ_INSTANCE7;
 		break;
 	case 2:
 	default:
--
2.25.1
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
