Return-Path: <SRS0=FsAh=JQ=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E896C433ED
	for <amd-gfx@archiver.kernel.org>; Mon, 19 Apr 2021 02:39:53 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3BA4360241
	for <amd-gfx@archiver.kernel.org>; Mon, 19 Apr 2021 02:39:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3BA4360241
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DE77689F8B;
	Mon, 19 Apr 2021 02:39:52 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2045.outbound.protection.outlook.com [40.107.243.45])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9259C89F8B
 for <amd-gfx@lists.freedesktop.org>; Mon, 19 Apr 2021 02:39:52 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=G4A/ucetUJiRX3qU2NhaYSWbD3F/Ij5xTpiQf+VNR2ZqDmc55FeIbXH3cSqgrq0qD8m2T3OgYu4tXC+E7YcRuOdmBWt/SWCqnHlyWFOdZEf9ej7/a2sS1joz1F8ZaaAsrb7cyBXTcsxQW+y8n7GYeFLJqLAdA85MHDcxvBnCfjJrsjJD08sapS9j2FiQ1pe6BQQ8YXWDFdqPZRW1AMFxKyuOAO+RCvDQmX7xOx+PgKQ/yo2PClglV3lA8KrVEztM5MdGf/vh0hvF8HufWW/YVEeEcIjcVNDGFnUgksMuhZJ5RjG/I+28ImNkkUdZ1hR14yH3jwbTnvviOVORHg44fg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WNr8cZOyW2XvwDY133hTJ09nv9ghOMkl/h/ZRnyPPbw=;
 b=DCkyiHR+nouvZ57Wcsr1hCeNe4MZo5ZMN+soXl6i/2U84ne/izEfZyGiZNDuPhnlo1yGM+6rAnLAYAy9OPd26d5I0dKOIBmm9WJjrLKpT3kfV22Ce6UvEJg7nHWXypxcGX3v3KTnIiRY4XwFL73U7v+F7W77B8agZUlh55K8SiIV5A7emx8Iih02i9XGbMZvptZEilQTonhhMSelPHvU/YVuJLZTLYBm+B7eQ8DQY3OEYS4dwjH/7SUUuPhOinDkscQtHREy9tKBDGqNnTCgc+hutfaoozoqPMl0HScdHpTg68HSZQkC6YrqR/9/In+hmd1mByawwiuVXCXoPNwd0Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WNr8cZOyW2XvwDY133hTJ09nv9ghOMkl/h/ZRnyPPbw=;
 b=KKbkz+CPd42uNg7saINxoOYRSm8qSpXQwKcIS2U023+oJ2tV8cTG1La5bTWTFV7IsaLf2UHdJIV3UOxCtCNcyhTys/dA36IDt694P4ocueJzesb18A9Sq5JP8qW4vrjGUlZ/M0pfFm0Szb2TAeKpDloZZ9Jj+h8bD6kTJXtEKZY=
Received: from BN9PR12MB5368.namprd12.prod.outlook.com (2603:10b6:408:105::24)
 by BN9PR12MB5291.namprd12.prod.outlook.com (2603:10b6:408:104::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4042.18; Mon, 19 Apr
 2021 02:39:50 +0000
Received: from BN9PR12MB5368.namprd12.prod.outlook.com
 ([fe80::1ef:6c3d:170c:8328]) by BN9PR12MB5368.namprd12.prod.outlook.com
 ([fe80::1ef:6c3d:170c:8328%6]) with mapi id 15.20.4042.024; Mon, 19 Apr 2021
 02:39:49 +0000
From: "Zhang, Hawking" <Hawking.Zhang@amd.com>
To: "Deucher, Alexander" <Alexander.Deucher@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amdgpu/gmc9: remove dummy read workaround for newer
 chips
Thread-Topic: [PATCH] drm/amdgpu/gmc9: remove dummy read workaround for newer
 chips
Thread-Index: AQHXMwjrqPrBil9ANkuW3ubME6x336q7JFdg
Date: Mon, 19 Apr 2021 02:39:49 +0000
Message-ID: <BN9PR12MB536836DA8ECA1EDFBB1BE0EEFC499@BN9PR12MB5368.namprd12.prod.outlook.com>
References: <20210416213830.1575820-1-alexander.deucher@amd.com>
In-Reply-To: <20210416213830.1575820-1-alexander.deucher@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Enabled=true;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_SetDate=2021-04-19T02:39:45Z; 
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Method=Privileged;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Name=Public_0;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_ActionId=38f1208f-612c-45f3-9dee-262f8b899382;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_ContentBits=1
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [180.167.199.189]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 68be56b9-039e-4bb3-0021-08d902dc6704
x-ms-traffictypediagnostic: BN9PR12MB5291:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BN9PR12MB5291A261DB27CCC7D1977FF7FC499@BN9PR12MB5291.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:5797;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: uZGMJMKXrCcQhz6BrgiMewdJFG1x49XKXN2ObscR/0IfLkEAlTyHgOMC0GagTFm2BkBafXVwdQV4YMPCqg7Zxs7+S9w2LRh+uKQZQEvaAtL6z2lJlU6PhC+Pz92frOlBA0n3w2yFekgp5okWtPsi4AbUVo6rKdqFc6OsslgKf+TMWYPif1bpUo5dzdylSygW2+AHKRn2hF6NNZxWfuI2puCaqtMg12go8rqPpNyolHzahOBWNEUWlGgRxIo6TSh5gd2pE4lFygO9Kqz+lB7emS7B/u9/qNAydCZ/+KTV7UUUDQniyuH1zp6OxDR73aiApbYntZj0CxZlSV/MM+w1gwUtW0rp8N4mv7XSxvMnUQjk6NbdNm40PkJGMiOl0xuYu2HfXvd2hEySYBB5Aqb8+wUaARDJCo9W7t19thri5NVcYWNdVtUjBaoEPzRF3sTdkVMUQdRg6rvwdY99IgPmP2+8ThrePv68X7QaAkPcrBYnYZyCJcutfoNSBhtn5HA+3btf52Jb6eLCQBNQ/wxq1I9F/ZT6XWiijbFtBliAHDhEdn9MY0UGI2IqhiNzw6aYTCJ21veFvyH66/AWLqghtjUUTRILowFj6pjHyCrzVVrBn7WusiP4YCON6lH/0m86Ee0Jc2g8R/OEOCRhYUsGIQ==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5368.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(396003)(346002)(136003)(376002)(39860400002)(478600001)(966005)(45080400002)(122000001)(55016002)(9686003)(83380400001)(186003)(8676002)(71200400001)(2906002)(6506007)(66946007)(66556008)(66476007)(38100700002)(52536014)(86362001)(5660300002)(7696005)(26005)(4326008)(76116006)(53546011)(8936002)(110136005)(33656002)(66446008)(64756008)(316002);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?mLuE6sjzBYnJS58w5Ach5X0hrU4Omf6z/UVenPRh6Z6y8Yp53xnz3RDrXMy4?=
 =?us-ascii?Q?r2J3R8JaUDAg52DqJ9Yn+J376puqQ3cVzBdr3rAPy3xRzZlT3vrOFKGgHUKV?=
 =?us-ascii?Q?3vwMo7w8q9TtlmewfT+s/KMLyRbB/k9lgYQZaaXjCmUNnYNfm0faos1MMUji?=
 =?us-ascii?Q?ykW570QqIIxRpdZ2Rs2v+vnnZcw8mXpnN+aLR0090OGqoLQvEVlO/l069ano?=
 =?us-ascii?Q?4PSRi07EVAEo7sD3A6qCS09LF5EHlNzbZ6ccNK3GD47nUs2oHQNmxhgc84QG?=
 =?us-ascii?Q?+yKGZw7XtV3pFoqQEWmHk/+6nbu2Q8yJza3MGBy1KVy1XxihDNYc4Hg3DYMc?=
 =?us-ascii?Q?gtmk4BnkDNHXBFlrBLb5cfOuGO3wXyOZwLx8KOzBYfqzWLmMqUpGu/phpzvS?=
 =?us-ascii?Q?FIeZxmfX1sPDKfJG6xTvAjcfV+ArvSAkrJWN6zfzdasCN5JweynYGMmUVdCk?=
 =?us-ascii?Q?RKAbDNYkvJrg5Qb246KjOuG1kR++L2OFXghS6bzVviBZuZ6+kZrwM0s8P2J6?=
 =?us-ascii?Q?20qAuauP3DqpCg1tk5+hkPNI51ghKKDfmBstoqBoZJidIgixQN/ltWgDCnZp?=
 =?us-ascii?Q?EnnbEvSPpdUNpqGKbqG30lGE7r5gf78lJ4JsmbNEfLB3Nc6+KJxk7yMGANOZ?=
 =?us-ascii?Q?vqwqG+BoQTOMuBqyXtyEX4zvmHeItgUKEQz9CAhCG7dL3rgl5W5U7avuaiZL?=
 =?us-ascii?Q?8PV18zWqmpO233flRkV1/PJEETrp68N0lG1BkUfDFa2GbW8GbaenC1yVixcM?=
 =?us-ascii?Q?cih+46cQZxWF+rsxth1QhcBG4keHFuNs5EKSMNO74gOH3Ry9qma3B2kMO812?=
 =?us-ascii?Q?LAMbsAp2XqpM23Nd8mCwAig5AdLoRPXNo/GY/g+pm+8a3Us2LJ+2FzJSeQ+i?=
 =?us-ascii?Q?BES0OyNXedaqjiMB7pWN60em347yeE4VKrxRrevNJy3SLMxBuhYkIIO5YTPg?=
 =?us-ascii?Q?qDaqEAtkwxt8YAcSZ5SuQP1jH16Ym6qtyJwHe1qAzKFYUWimiUIm81DTpfLP?=
 =?us-ascii?Q?7y5CF5GZDrN0hJQPfzMchhVEyGgXuFoejCJKXdL12IQFd2TVUlPxrF64J1za?=
 =?us-ascii?Q?Jk6ZB647060QmH8XUY55lNAdWMLugM9vwOSvMzm+I7LBQh9KD1Hv2yqWt0Zf?=
 =?us-ascii?Q?W5gMRw9qzsOw4arVuxnGElegp4nnzYG77yC1keWpQsVyVLSkZ9+Lew6GtEqS?=
 =?us-ascii?Q?zll1yd+cB1At8ZEG3zj0XSd3xGxSk2uqV0y60IqhmMw78469epjudIPrw7cG?=
 =?us-ascii?Q?SdhiX2Sfn4GXOERjH2wwQnV2yKvnh1d6+ksQDwQXFzx5TsE9zIAZaANTIC6c?=
 =?us-ascii?Q?L9xUf49pZqKK2UojQ9KhayIJ?=
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5368.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 68be56b9-039e-4bb3-0021-08d902dc6704
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Apr 2021 02:39:49.0835 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: haFM17YDMoKwj5We+uZ9Gut+2obTd+LGZQjd9/tO0qRovp21UwdcjPhJsLt2bEKQ0zD4Ptv4UTn0dJr0w/f6pA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR12MB5291
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
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Public Use]

Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>

Regards,
Hawking
-----Original Message-----
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Alex Deucher
Sent: Saturday, April 17, 2021 05:39
To: amd-gfx@lists.freedesktop.org
Cc: Deucher, Alexander <Alexander.Deucher@amd.com>
Subject: [PATCH] drm/amdgpu/gmc9: remove dummy read workaround for newer chips

Aldebaran has a hw fix so no longer requires the workaround.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
index f354f670c7ad..455bb91060d0 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
@@ -574,7 +574,8 @@ static int gmc_v9_0_process_interrupt(struct amdgpu_device *adev,
 	 * be updated to avoid reading an incorrect value due to
 	 * the new fast GRBM interface.
 	 */
-	if (entry->vmid_src == AMDGPU_GFXHUB_0)
+	if ((entry->vmid_src == AMDGPU_GFXHUB_0) &&
+	    (adev->asic_type < CHIP_ALDEBARAN))
 		RREG32(hub->vm_l2_pro_fault_status);
 
 	status = RREG32(hub->vm_l2_pro_fault_status);
@@ -802,7 +803,8 @@ static void gmc_v9_0_flush_gpu_tlb(struct amdgpu_device *adev, uint32_t vmid,
 		 * be cleared to avoid a false ACK due to the new fast
 		 * GRBM interface.
 		 */
-		if (vmhub == AMDGPU_GFXHUB_0)
+		if ((vmhub == AMDGPU_GFXHUB_0) &&
+		    (adev->asic_type < CHIP_ALDEBARAN))
 			RREG32_NO_KIQ(hub->vm_inv_eng0_req +
 				      hub->eng_distance * eng);
 
-- 
2.30.2

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Flists.freedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;data=04%7C01%7Chawking.zhang%40amd.com%7Cadf46903384842b64d7808d901200c5b%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637542059440210168%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C1000&amp;sdata=N7uPwtKouRSONSqewksEIz1YtI3D9B3HWhUsd1sHNSM%3D&amp;reserved=0
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
