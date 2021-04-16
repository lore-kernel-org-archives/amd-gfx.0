Return-Path: <SRS0=1d99=JN=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BDD32C433ED
	for <amd-gfx@archiver.kernel.org>; Fri, 16 Apr 2021 06:49:32 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5EFCE61166
	for <amd-gfx@archiver.kernel.org>; Fri, 16 Apr 2021 06:49:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5EFCE61166
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 07B0B6E0FC;
	Fri, 16 Apr 2021 06:49:32 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2048.outbound.protection.outlook.com [40.107.92.48])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D0C266EB2B
 for <amd-gfx@lists.freedesktop.org>; Fri, 16 Apr 2021 06:49:30 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bWuTzXrahjXxzw1rW1/ILWbfbtjnf2deMlBogrQawOe1Ms5wmIoAgXQjF90II6iygDur0chwrrjrfdbse/yefp1qtPuIJeX8uviykFbgXT7LOy+CC6SrGoikuRnB5ZBOAzQGQiyeirOfCDPQCFmNWl1GEvAnUMNfa5gpa4zOlHRlZAA9bcEa6wL2ApV2d9eGACnpJBoUcrJp1lZigVbSrlTqQ2FDp9XiN6k68haiA9Xjlnc/mG9BYn2j6tNUnEqpgTa3ShTqxBiCSHiw+82Em6zyO95IfbYvgCUcgFSXuWehoXoFK9gQgloAxOBOswdTdYXRX68q/Kh+CcVnXGs0ww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xmWIX/1vlCJ5NKIe2UbuhRVsuvUa+1ypwaKuuwXBG+o=;
 b=PUqYaf9FehPls9HXttITIrXvHWawHx9Y22GkabY7KY/MKMV1lI3XBN9xZpqxIUZRIOKapOrK2XmPi3MMRWgvIztkh009ZAiIgdFcPw8Ja1trN/PcHl38q2XXJmdsX+mG5OmfUANQMnWvP1OalHjMUCsLnmOC0WUMcUGT2XbH9l3bLWVE6JZKwTwirzDPi0+jGuRRHH1wxcw69rwkh/vo+oIYfu5ba4tLlkc2fRbejiASfLXdmJuDB0zX6naC0OKFJ0VS8/GP8me/VMHHOHu684I8MZBmh4X41aPbIIpgRZ6DZKaJbNnJs6gfiHXXQIBzxOglcnK+0zYsTM9u3KqU6Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xmWIX/1vlCJ5NKIe2UbuhRVsuvUa+1ypwaKuuwXBG+o=;
 b=OHitX/f/Y9QtnIDqwbgUPYRr6kelNSyT2eJU+E5yufuYGKMSR5NCwoaE0IcVOHg/l1uJqoOwv1Qtwf4qijT54+IphjzIomCOHeHIbltP09kt0v71l/M6RMAerpc6/DCsDkXxyghRFjiKh6WkbOMdBgKDmYGBZEe6LqvSrDY6Wwo=
Received: from BN9PR12MB5368.namprd12.prod.outlook.com (2603:10b6:408:105::24)
 by BN9PR12MB5337.namprd12.prod.outlook.com (2603:10b6:408:102::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4042.16; Fri, 16 Apr
 2021 06:49:29 +0000
Received: from BN9PR12MB5368.namprd12.prod.outlook.com
 ([fe80::1ef:6c3d:170c:8328]) by BN9PR12MB5368.namprd12.prod.outlook.com
 ([fe80::1ef:6c3d:170c:8328%6]) with mapi id 15.20.4042.019; Fri, 16 Apr 2021
 06:49:29 +0000
From: "Zhang, Hawking" <Hawking.Zhang@amd.com>
To: "Xu, Feifei" <Feifei.Xu@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amdgpu: use ratelimited print in sdma4 interrupt
Thread-Topic: [PATCH] drm/amdgpu: use ratelimited print in sdma4 interrupt
Thread-Index: AQHXMb4uTvcOdI/cYESI1AYNCLmbi6q2ta6Q
Date: Fri, 16 Apr 2021 06:49:28 +0000
Message-ID: <BN9PR12MB5368D782CF4DEE72FC0919D8FC4C9@BN9PR12MB5368.namprd12.prod.outlook.com>
References: <20210415061119.2946390-1-Feifei.Xu@amd.com>
In-Reply-To: <20210415061119.2946390-1-Feifei.Xu@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Enabled=true;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_SetDate=2021-04-16T06:49:27Z; 
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Method=Privileged;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Name=Public_0;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_ActionId=1557cd12-1e92-4152-a821-232fe7ce741f;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_ContentBits=1
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [180.167.199.189]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 82b5dc10-70f9-4570-d97f-08d900a3c85b
x-ms-traffictypediagnostic: BN9PR12MB5337:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BN9PR12MB5337FD282D932B065AC32FA5FC4C9@BN9PR12MB5337.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:83;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: eGl/Hqze2q/lUpxijGL81iw9WOD0wDQNOILiC5Mm2Hiof0nX3pu6476bIS7rQS4DDgakSzb3J7nX1U1KMKdbNRkUBwOU+iJSt2HgFWGhy/1PtYBzt1jBzsGNw0Ak1TOqH1889xbx3VjZ8DHkBp9plslMIi6kY///q+OoJtA4EjI2PnJ61t8W8m+dmmNHon68iupSrga56TH11o2ALMSZWWY5Me+J7mtdY1hrTUOMy+n+Wn5PcdzRkWJvv36jgtyNpxeIHctDNpiPcmtPZDQKPjphZ3gdZBv7Gau+W7OXJmwTBaQhth+DGHY83LvQqpamknSUuI3oWNi6y1qJ3xwT77KfXl5a5GWuAuRs2r5xjirThIa5y14LmaD8lJfh2nbKJOqW5S3dLU9/EKBf4hd1d309KVXPcTBcKrZhQtvWiJO4513MiB+aQ044z6TLd+y+s92VGIhCerYIB7KFr769qsT/S7aZw9RQLdNuafspCHxKXoLVQJoaQehe/M2LPHTv1Lb+S8ID5hG8gCCf2aZJJPqx6SA6XPJDLY+9fGEMKGPr6jSp23ClTgkwdB63XfCNvXxj1tlrL1Vo3aHgE4SCFMJCAwdn18iiKGTVZ05adSySA0iy813+6pPywhd6ult3cGFOE3JxUZKRXgAXlfZUzQ==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5368.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(136003)(346002)(396003)(376002)(366004)(39860400002)(7696005)(966005)(9686003)(122000001)(53546011)(2906002)(55016002)(8676002)(66946007)(26005)(71200400001)(6506007)(66476007)(52536014)(86362001)(66446008)(83380400001)(478600001)(316002)(64756008)(8936002)(33656002)(5660300002)(186003)(45080400002)(4326008)(76116006)(38100700002)(110136005)(66556008);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?o3+IWWbP3kg4dmOYvcKaSirOr5KDhYKec9r4WkUiWX7p5qX3Imeya5o5KKsX?=
 =?us-ascii?Q?B8b5P6voL8ngJzkhWxirqrV9Q6oD6lReGPziZs6UVXFnaz1fSRXAN0hAkXf0?=
 =?us-ascii?Q?GYYWjTS71YwlwoQYlFhNHUUb1/UzROM8EKebK8sRGGjZ2pf+T7nEAqE+S7vY?=
 =?us-ascii?Q?9IhI8LylFAyDl7ZVqCAC9XFGOSUwBusJFHujoGfxGVZM3UW+WdT8Xz2Q6fg/?=
 =?us-ascii?Q?bng2xeGniKBNgHnWv9hWGxEvjujhZabBtEsObebTCXcspwyUr/IhdiiF6KnG?=
 =?us-ascii?Q?TU96u8/0p0bulJZpkM4keIGJQEK8W8z75wfoOm5lMcq5YstpCOEUdRWVbDOz?=
 =?us-ascii?Q?mwhLXaHI5MbB2VlWh4ZRmPoxthxaHXGJSwGLZsV/P2rNZsykYN1AgPF+venR?=
 =?us-ascii?Q?nPS6fO1f/2kciFhR4zt/2v/TfN0PnLMJ692zgZUhIWbtabj2C18/g5zPjYhV?=
 =?us-ascii?Q?70YDikpRi2p75sZ5U67tZgvpy4brllaP4dG3MAxkaWw0YYJZMEwEnlZ12zSx?=
 =?us-ascii?Q?YdSAsXnvK5llI2hTA75nLX2dkeujMTdwwO3R0bUDzoA4b8JXshBhkqmgJEBZ?=
 =?us-ascii?Q?3wsn1Eql7FHHZL0S4vUJGqUpuS8XNrDwtCWy2KlwWFBH71AwKlWBVnNaEskb?=
 =?us-ascii?Q?H1N4B6b12NjWYZkLwRnpD/dmbz7/8vRFWLRqfuF0QFL6/D/LuR43b+ZUis8P?=
 =?us-ascii?Q?mCWp9glBccNZYbBzeByZPYMXptHSQTdrk8uK0cfWTn4UgmbleppcEdM4TrnB?=
 =?us-ascii?Q?fvFXV5hptysMQ0igf3IIcYfr75kmES9sJnD5fJhbjk4c4nF8rtvDL6G8ewaq?=
 =?us-ascii?Q?WKfI0t5H8OTFnOnG/KrJi0tchQSaB8CuUWPeevbw2edTG+zE0vqwMFfr21au?=
 =?us-ascii?Q?qEt5YseYdgQ2QUrBJffF9EfcON2Ik8ukdkbb8/LmaDzcZ9IexOp1TRFd5+si?=
 =?us-ascii?Q?UO7U+LPejhb+WwJL+2w0KLfE7ximne2F6Xey4bhhdzN3NiIRnhp+yTDwqZlP?=
 =?us-ascii?Q?uu28cM3zc6kvC07NYtPL/rRno/WRx+2c2Aus76rVwsj64bBB3Bl1Pnx0D4ZQ?=
 =?us-ascii?Q?NKLQYL1iyKZEomqqm9518qSP2GRy/6F/u4wbtbu13S91kDd3l88GgP/3VPIU?=
 =?us-ascii?Q?zTqS99f+D3uIZp1ninfGTts5wAAbwU7AZfHkQw0safNMFdj8EBO3HAK9aqFN?=
 =?us-ascii?Q?GCuO5q2PWuwGdgrbMFW1+ytwNTI7zKz/NzEGcm4GBSl5pEA2rcaf+W5bOgwG?=
 =?us-ascii?Q?rPj5aJfpzx/CyZNZhWpWOPVSErlJsNnEqCb1TKJm8KDPZmrrF/sGuMTFfanw?=
 =?us-ascii?Q?9AFwaZCT5DwQDuoWl3Bm3OFl?=
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5368.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 82b5dc10-70f9-4570-d97f-08d900a3c85b
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Apr 2021 06:49:28.9762 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: CwlhxcQr0roZe1wxMHFj8jnBfHD7v6L0gUqT4zfe0i+r5FimDgyq6NFW5czcy2womkPx3mZOjpR4Tmboe5/SZA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR12MB5337
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
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Feifei Xu
Sent: Thursday, April 15, 2021 14:11
To: amd-gfx@lists.freedesktop.org
Cc: Xu, Feifei <Feifei.Xu@amd.com>
Subject: [PATCH] drm/amdgpu: use ratelimited print in sdma4 interrupt

dev_*_ratelimited printing will avoid dmesg flush.

Signed-off-by: Feifei Xu <Feifei.Xu@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c | 13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c b/drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c
index 06247ad454b6..1bc5292ebb33 100644
--- a/drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c
@@ -2218,7 +2218,7 @@ static int sdma_v4_0_print_iv_entry(struct amdgpu_device *adev,
 
 	instance = sdma_v4_0_irq_id_to_seq(entry->client_id);
 	if (instance < 0 || instance >= adev->sdma.num_instances) {
-		dev_err(adev->dev, "sdma instance invalid %d\n", instance);
+		dev_err_ratelimited(adev->dev, "sdma instance invalid %d\n", 
+instance);
 		return -EINVAL;
 	}
 
@@ -2228,7 +2228,7 @@ static int sdma_v4_0_print_iv_entry(struct amdgpu_device *adev,
 	memset(&task_info, 0, sizeof(struct amdgpu_task_info));
 	amdgpu_vm_get_task_info(adev, entry->pasid, &task_info);
 
-	dev_info(adev->dev,
+	dev_info_ratelimited(adev->dev,
 		   "[sdma%d] address:0x%016llx src_id:%u ring:%u vmid:%u "
 		   "pasid:%u, for process %s pid %d thread %s pid %d\n",
 		   instance, addr, entry->src_id, entry->ring_id, entry->vmid, @@ -2241,7 +2241,7 @@ static int sdma_v4_0_process_vm_hole_irq(struct amdgpu_device *adev,
 					      struct amdgpu_irq_src *source,
 					      struct amdgpu_iv_entry *entry)  {
-	dev_err(adev->dev, "MC or SEM address in VM hole\n");
+	dev_err_ratelimited(adev->dev, "MC or SEM address in VM hole\n");
 	sdma_v4_0_print_iv_entry(adev, entry);
 	return 0;
 }
@@ -2250,7 +2250,8 @@ static int sdma_v4_0_process_doorbell_invalid_irq(struct amdgpu_device *adev,
 					      struct amdgpu_irq_src *source,
 					      struct amdgpu_iv_entry *entry)  {
-	dev_err(adev->dev, "SDMA received a doorbell from BIF with byte_enable !=0xff\n");
+
+	dev_err_ratelimited(adev->dev, "SDMA received a doorbell from BIF with 
+byte_enable !=0xff\n");
 	sdma_v4_0_print_iv_entry(adev, entry);
 	return 0;
 }
@@ -2259,7 +2260,7 @@ static int sdma_v4_0_process_pool_timeout_irq(struct amdgpu_device *adev,
 					      struct amdgpu_irq_src *source,
 					      struct amdgpu_iv_entry *entry)  {
-	dev_err(adev->dev,
+	dev_err_ratelimited(adev->dev,
 		"Polling register/memory timeout executing POLL_REG/MEM with finite timer\n");
 	sdma_v4_0_print_iv_entry(adev, entry);
 	return 0;
@@ -2269,7 +2270,7 @@ static int sdma_v4_0_process_srbm_write_irq(struct amdgpu_device *adev,
 					      struct amdgpu_irq_src *source,
 					      struct amdgpu_iv_entry *entry)  {
-	dev_err(adev->dev,
+	dev_err_ratelimited(adev->dev,
 		"SDMA gets an Register Write SRBM_WRITE command in non-privilege command buffer\n");
 	sdma_v4_0_print_iv_entry(adev, entry);
 	return 0;
--
2.25.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Flists.freedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;data=04%7C01%7Chawking.zhang%40amd.com%7C9c54e549a4de44a3ea5208d8ffd54f5e%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637540638934360168%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C1000&amp;sdata=qCg%2Fc9k8Xj6cS4se72CFDCcy6H8WwAciRoS8MKhuoOU%3D&amp;reserved=0
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
