Return-Path: <SRS0=b4Qt=JW=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB338C433ED
	for <amd-gfx@archiver.kernel.org>; Sun, 25 Apr 2021 07:13:03 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AB53B61474
	for <amd-gfx@archiver.kernel.org>; Sun, 25 Apr 2021 07:13:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AB53B61474
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2AF2B6E4D2;
	Sun, 25 Apr 2021 07:13:03 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2064.outbound.protection.outlook.com [40.107.243.64])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 45F8A6E4D2
 for <amd-gfx@lists.freedesktop.org>; Sun, 25 Apr 2021 07:13:01 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ljmemgilI9Mpynk+uRCHcKExdr2TxHFS8M7YYLxQedTuLX2bnpVfKuCQ8hX08/D1fsRimXpQQLHLtRW+wdck3IkthTno5AIc2Funk+0CvortHoEXJFP7nRcKV30pfj42N6UVpzxA4l5u8H1eapYZfq3bLTDGfEjbS2rjxkXrgQKQkJtltXT0vpQ6qwFrq1OpEKxnd/c4BLHTYyoclyxe5GHE5h2LfUwADzCu1iucGN5v8ZIZqBcvG3lI4mqrUFoQvegahNgbwdOVBtaHNhhzUZ5YXaLcqiouDrl7DFnh3acEhU4LI8S/pX1rDrddi9mxMa1KKfdbFYKhU7hqaJaSzg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FgKO8kL9e7axKbrgn/ym4kkgjgrADJjRyISr4izHbew=;
 b=DLLyj5x5cpVjgqHDzTItZx+xHEtKI9G4SToBuolCisyxx97bKrOmfi1tuYkQnqWmLe++ypNsLqeU1i0Uiax8D6DccJVgU2KJq/iK7frIip+SaS5XXgTBZwJuci1nRsB10ukUCvCkeYlHyrDzhilPBGvcjP3zDevKrzUasSmP/N9Qr8IpIklzh6zMEhfR+9HgKRUFW6vF2JXvOkVu3dLkyAMwLrm259O5kmpwbTh8MVYrYq2HyOPed/ECzCs0OWH2INIGG0ghGQK0ehPxoxvtdksgphOvRNrZrF4KThzY1jpZcaFdx/hGI0AZqTh4QgrTVdPUxKZknYkb2IPufbZMNQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FgKO8kL9e7axKbrgn/ym4kkgjgrADJjRyISr4izHbew=;
 b=18RSPfOoT79HIOD+YYxMwfx/CXPsdgAR46SIvGNWQQ83vaeoFLmCh+CIk44xJ9KnOLQpSSsWdYNSvP3POfyo213r7ruR+P6DR36r0wyVNWqXb7Zpl7KD9TZB/n156bbvhcsTgFF96BdYDcoVUfdhfrLgFug3n9lbZiJ1j53ZzfA=
Received: from BN9PR12MB5368.namprd12.prod.outlook.com (2603:10b6:408:105::24)
 by BN9PR12MB5305.namprd12.prod.outlook.com (2603:10b6:408:102::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4065.23; Sun, 25 Apr
 2021 07:12:58 +0000
Received: from BN9PR12MB5368.namprd12.prod.outlook.com
 ([fe80::245d:c14d:fd99:be85]) by BN9PR12MB5368.namprd12.prod.outlook.com
 ([fe80::245d:c14d:fd99:be85%6]) with mapi id 15.20.4065.025; Sun, 25 Apr 2021
 07:12:58 +0000
From: "Zhang, Hawking" <Hawking.Zhang@amd.com>
To: "Xu, Feifei" <Feifei.Xu@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amdgpu: correct sdma 4.x irq.num_types.
Thread-Topic: [PATCH] drm/amdgpu: correct sdma 4.x irq.num_types.
Thread-Index: AQHXOaH2wmew2Fv9REe5DWvj/8JBlqrE0Uzw
Date: Sun, 25 Apr 2021 07:12:58 +0000
Message-ID: <BN9PR12MB5368A0D32092B97B38E8B51DFC439@BN9PR12MB5368.namprd12.prod.outlook.com>
References: <20210425070934.44672-1-Feifei.Xu@amd.com>
In-Reply-To: <20210425070934.44672-1-Feifei.Xu@amd.com>
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
x-ms-office365-filtering-correlation-id: 19b8c8ed-3884-4528-fe53-08d907b98e30
x-ms-traffictypediagnostic: BN9PR12MB5305:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BN9PR12MB53057625FC8E41439A47A13CFC439@BN9PR12MB5305.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:101;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Ue50PK4oGxprVka18yeybJzFIA2z44auZ+WZI/lLXGknw34uwIivTEXMTNVBYElmfIpeCxnQxpoleVfmONAiP09zfyZw3iimyBFNXwgo3JJMlc3ypyCRMfM+nRrQlrB3uNxM9xTnAWxyQ7tAInVdgP3RzetAAtXrUMzTA5Y861ZCWTP7Sj7uFRwkOil9M6mhdnSXJB6K0JsMAJVf0zyRQ6nLRVtzdLeaYFRaCwHakiit7mxFwocbm/uUeLacEjsQrUqJvqnogs5waSA+dCfA3xE6Xuk/SGiRMGvulajz873ZrLXHMMJv1VrmqpTEKfDBAmyPlhgJ6rmIuiFkRunoPsxKRkhnFaYTSft1IVfS6FsV/HVhQNo1M67cQc+R26KJT6l/s3BBeQC6EBUKxnQpIs40jDEgw0v0SRdFLRfvaXgyG/iu0/29qEWD1SekwQ1GSThuID/HE+u+issBkM22aG2KnYyHuvZnQMwiL/ewqhLWk6sOHOqtxMukxSNFrPzDqFPpq3HGn+aq2P22xs+AfITd3HSs+lBrGJsbR/IvmjQxyoOAlRveKsBMwwoWndqOEByVpdUg8/Ue3OcFaJshHZMJlcIoXZgwyR0pueabBQQ=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5368.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(376002)(366004)(346002)(136003)(39860400002)(396003)(8676002)(26005)(478600001)(110136005)(33656002)(64756008)(66476007)(55016002)(66556008)(4326008)(9686003)(86362001)(122000001)(76116006)(83380400001)(66446008)(5660300002)(71200400001)(7696005)(38100700002)(2906002)(52536014)(8936002)(316002)(53546011)(186003)(6506007)(66946007);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?ojhw6/NyGUZLd8tcoYW+cMCFgG3VmXuRn0I8cLbEJ2w/C47c8rgaMCFC1h3N?=
 =?us-ascii?Q?Yi40UqNHfrCb6H6ho4uAM245cUz0b9T6fjV0kXQtKHYiV+/tfVMeqK8BZdVf?=
 =?us-ascii?Q?Sy8buK66n59euwojbEs1oY7C9ngK/biPBD+GWCtXXskr9zrak1320HX0XnZ7?=
 =?us-ascii?Q?l+3ZtGb1nOkGbDR6prADIh+x/8U7dqB7KQwqarWWrWubKi7fp6SQt19Ynufb?=
 =?us-ascii?Q?ScW5SFOdtsANQ9uSkQof6QQx6UbxkrnKHXOWn7pUbKvjdDRz7c6URy5JK6iq?=
 =?us-ascii?Q?jqsjyb0GW8OcoyVJvE8Qs936dQHbrEciviC2IdfW45c3I9yKleOSWNxl0Hjc?=
 =?us-ascii?Q?4o+Xcg4ZaPdpF4ArN4lF5AV4Zs3SGskIQdEFbSXoNt0J97F4bAP348lZ56+z?=
 =?us-ascii?Q?BWvz3yoJslgN1E9FnLUkuWYjCxUvBTZ9l6OHZwJtISYYsI45BYfcrBzlEYQX?=
 =?us-ascii?Q?kXdSzlk6aKLZa3wktyy4DGGwF7E3nFXko8qz3mBAeeFDmkC0zxB/xCB3fT16?=
 =?us-ascii?Q?3EITj9Yc4PMI56BGi/gP2gzLuhpp36GOHzOxch7qw4YANFTpKIANj7RhJPqL?=
 =?us-ascii?Q?qaS4ZOgho5nJbgtCuT/4xaQ23hWYMlbmBOWDYd5Nq6FZ5X2Iux3hgoTH26nZ?=
 =?us-ascii?Q?DppHC7V9eoRjtiCE4VYyykaL6XIrCzunze+y5VVM4iiZfg+u7Jj0QQrjdxyS?=
 =?us-ascii?Q?bqaaAJZIvZihd4e7OMIpJh4k5d7f4hFBPttmScMKttMTpkxtFGXPRoqVv6Lx?=
 =?us-ascii?Q?LENzdMWCLaLY5MsVLqzTO+ZToOM7kZbTOb6UH5ZqFWpNKeZJEiTocC+itCZT?=
 =?us-ascii?Q?mhZ3kv91Zhc18i6uvuePg2Dg6Hv7pCm21vflcdOkU3HPnbtLT1OleRZSUd2Z?=
 =?us-ascii?Q?j7JBDxN2R7fCou715m3xmyayfZt9bF4qBeO81cQPJSl+3FzQSERkElhg4cUh?=
 =?us-ascii?Q?01Iz5mm3i5HV+L1kTRrSD0fCL3icKidwDB07Qr/xhrHV5UD6MJhg0RbyX10X?=
 =?us-ascii?Q?dAYBI9el4NgsMatWhrMOLk25pNigrnOsqGo3HEsxy1ufeMb2t1aebQqsnpja?=
 =?us-ascii?Q?ja8LSTRjGxnIVsw3Lrn4ULEQ31yw5e4allnujWwCTi16pCuFGnYrIAsNmPOg?=
 =?us-ascii?Q?P6gcOU7OPu+JI15CfRfkXLq4IdisOp68ckFAuzs78stZiTLIOvQYkmDWOmgB?=
 =?us-ascii?Q?RB6IZz1lXQhlpFTpu+uwcG49xeKoTVaYn83U8vLnCqvji7lfApvrUxP/wfEI?=
 =?us-ascii?Q?p3HDU7SrPL0SOyczuJypWdTQXRGDlOOXfJMlgFlzCcjDRIKNHFVF/5KTB+T/?=
 =?us-ascii?Q?hZOWmgcNrdwDZPOa5iONJhbf?=
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5368.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 19b8c8ed-3884-4528-fe53-08d907b98e30
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Apr 2021 07:12:58.5047 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: MYHKYhm7EzUlqAm/TTIj9eZiZxvasV5tw+b6JZjGDDQBc8tlo9Wv171gl5rxqJfhScaapTcke2tBTMeDrDyaAQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR12MB5305
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
