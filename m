Return-Path: <SRS0=mwd6=IK=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BAFFAC433E0
	for <amd-gfx@archiver.kernel.org>; Fri, 12 Mar 2021 03:42:18 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7BC9464F70
	for <amd-gfx@archiver.kernel.org>; Fri, 12 Mar 2021 03:42:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7BC9464F70
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 22C2388007;
	Fri, 12 Mar 2021 03:42:17 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2053.outbound.protection.outlook.com [40.107.243.53])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2D22E6EC90
 for <amd-gfx@lists.freedesktop.org>; Fri, 12 Mar 2021 03:42:15 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PTI+QA3HxIj5zaeCWmRvInpQx4+Z8fofRzVYy9PkEiHe8zMPlTjKmOFGXnH8+M+zoqMfzJuSHsGTFauEr1xwL3PJCyGAlUfy1Cy3+h46khseJ5kcCJKNwC2howYHzFiPD6ZFC7waf4q0+ALFanFOWNxWyYUK2MCpvUfUoYzY01RZkRKTGyhpHzOE9i+1FrWTY79r39iZbs1IcCLDbUNXWgQFX/JNPi+AxDz40wIWRARUiOuIgZxo1l0cdtCYG40RXCZhgeIhuKWGqAL6OAwpCEsHhz/hXKQNffLffGJhgSj1mohM+fanHzowJPVBznZ9EGyXdG6Wg4W4JzYLlYCUNw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pGAx3B9Y+XIA69Dg66HKDRTxg7/+0KFVE+He5VxHgL4=;
 b=aa+CHfkW4jKvh2X08oRVdKZ7NTuYQo396kIkP83yjpSB3eTXuoI0/w0sf32wIxGCVlO5Bw/vQtdLu+wouOcH57BB4P+Td0Yea9MZjCa+sRAM6QQZZrjWTZNLPDyAphauJIQKDFy47bNe7cd3ihguz/FshxlSeOBFhGCYXjCkSZQ0KV9oqxXRf4IGSHAew/IhTO+mrcHirwQjma1U5cWIJP1plh1RtjJz+lKU2Nxs+oI+vrNI0URRAcBq3zWjuWU0xifJ0I/WJAdTc+e2AP3qIoyWz5c9Cuk9z6SJx9MNsXjiFhPKpwjTUt5AkIwqcbVUo7wGw1W7L5KtJmyPNQu7ag==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pGAx3B9Y+XIA69Dg66HKDRTxg7/+0KFVE+He5VxHgL4=;
 b=IjDzXWPwfCQ1oG6qt/zbntqkkYJnXlr1JqwZEHVGL9dVXvrmdSbb5knrVVGlX4mBfD7DRa0xTJAjqJDMzIeuphKdj+xoRHiK/hXjCIP44y5DSzZ5FuBdTQySqP2tzEu63X/5C03J+hLe3jHSwmlXo8sD296Lm7WPIWWEL0n/yr0=
Received: from MN2PR12MB4549.namprd12.prod.outlook.com (2603:10b6:208:268::15)
 by MN2PR12MB4782.namprd12.prod.outlook.com (2603:10b6:208:a3::33)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3912.17; Fri, 12 Mar
 2021 03:42:13 +0000
Received: from MN2PR12MB4549.namprd12.prod.outlook.com
 ([fe80::c1a6:7b2b:9494:776a]) by MN2PR12MB4549.namprd12.prod.outlook.com
 ([fe80::c1a6:7b2b:9494:776a%3]) with mapi id 15.20.3912.030; Fri, 12 Mar 2021
 03:42:13 +0000
From: "Lazar, Lijo" <Lijo.Lazar@amd.com>
To: "Liu, Shaoyun" <Shaoyun.Liu@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amdgpu: Enable light SBR in XGMI+passthrough
 configuration
Thread-Topic: [PATCH] drm/amdgpu: Enable light SBR in XGMI+passthrough
 configuration
Thread-Index: AQHXFpo6OffAU9/QCU2PzCAhGlJLMqp/tYhg
Date: Fri, 12 Mar 2021 03:42:13 +0000
Message-ID: <MN2PR12MB45495AB3BB248A637F218F38976F9@MN2PR12MB4549.namprd12.prod.outlook.com>
References: <20210311171548.10671-1-shaoyun.liu@amd.com>
In-Reply-To: <20210311171548.10671-1-shaoyun.liu@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Enabled=true;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_SetDate=2021-03-12T03:42:08Z; 
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Method=Privileged;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Name=Public_0;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_ActionId=2f66d67c-278b-420c-8fd3-4bd41db97282;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_ContentBits=1
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [49.207.202.46]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 1ed8a9b5-65d5-4240-c5e1-08d8e508d2c8
x-ms-traffictypediagnostic: MN2PR12MB4782:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MN2PR12MB4782C0AD3DF69F634C78EFCE976F9@MN2PR12MB4782.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:4502;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: fZ2v8cp1D9e2RnpCmAFqaitunRcAukuphjCxmBvdKPM2q+Br15vfbfsod/cA7hk6AC7+8pFSptojbz9s6jGVkC+UElElJVTKbOYYg/v3z9ReqL8PrDkXgD7CS4H94X7FWFuJtruLtFW5KjqFVg/oS9l7oTx3KFGgypZTFu9gbTEqEKFYfmB7LN2rbcTlsBHpGfCwlW+NSgCodv2H02TUv1cAgtyV3G/QclnNmESQCOk6Cmt+0PF3nTXsCdbRyqHJ3keNd/kqTzUwYbZKyL7HTng9AHzsB9MYDy1KJoMYuLM1hCNpXD8C6j12ga9lNxZ8WmZuSi2+5ZAo370f7Qq+Nm18A8mfPnX3M9/1B3RPO+U21GJDtcXgjZHyakamvVnEH8MqavrgWtFP6y8WWW5vaNKieeIgdfoVQ8IwyJJMEPVrdyc5vH0t5kR0Nshp0+HOURsGT0dNFVTxPMfCONZEYFbRXWDuo701jr5n0Db4GI2EIqGlWNvh6WG6H+/HwiViLB3nHcvkAzqLGYcOi994m71L82ujinAAHBSq32+INQFsU622czNVeCn0Aa9a0Q5D
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB4549.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(396003)(376002)(346002)(136003)(39860400002)(366004)(186003)(76116006)(33656002)(86362001)(8936002)(55016002)(26005)(4326008)(66946007)(110136005)(7696005)(55236004)(71200400001)(316002)(8676002)(45080400002)(966005)(53546011)(478600001)(66476007)(83380400001)(2906002)(64756008)(52536014)(5660300002)(66556008)(66446008)(6506007)(9686003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: Xkj94vJMFZy9NRiEw8jF1kFVJrH8GIMj23yGUSK6fRgjxUGnpzpDQHpOQRQuW84Ku5mnFSroNVL1EJPxVhC6uW7M4CNsJn6OgA0Q2eTakbNZzk0j+I720XPd3rwY5cwxI8voYXEWq/Vum7CsoWEPsfmSohPS0Cg8Vqr5ee66Ivd0PqNu8Zl2MOgoLWhcCzhW0oK382CcWDhkeOyapQU/Y71yH3nRH0dWS2lV40q8arSg4bHhQ2lR4J9fNY1Xq2eT8RxSBwbm6zPmrRmNVt/arZcCZ9m/UUl6k5Vz09ref+Ckie9gLr9+MlDQ1kQ1hpurftVj1j64NWVs+11u+jhlvQAA+JBTh9qPDdD4gRawxwFZHtylnjbIFI2NKR4kGC9twBS88Am3MdDrAQNoqDQ+DqGPdwKuERs/Hx6+HrtAt9eYs6VYVcJJeGvx4EaGSABX5wxMJBpRgWdZnyFIZSiha/WSzMBH/9Qpt9NSOreM2I+5U0i0px2047XOW0PcYiLM6PmlV7mNnH29KmV4N8CcErbwT5TXdhPXeAlOtgHsPz14DDYmXd2s1zo4ymvrN+nLeuJb2LX0BUV+NYOdkOOuq7VVZUfPsMlvLKSnkTfterbLHzPgJ+hIQ8F8zFVedoPmTLQ23NRfYwryHBjLAmkJemHqBlzr7dekjjcmS6KQcahMvX/2FyxtZpjT7Syn1qNJ3FStvfEJaMH/T77IcxujMVEp3bpCP3LOC1f8YQpNpRo=
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB4549.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1ed8a9b5-65d5-4240-c5e1-08d8e508d2c8
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Mar 2021 03:42:13.0523 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: zj1PNo478WyV0L7iXF224tU30iJsvxq0wlT9iBxc4ydHOVWBk0tlciHsPzxJ66iu
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4782
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
Cc: "Liu, Shaoyun" <Shaoyun.Liu@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Public Use]

We don't need this as a generic ppt_func. Reset functionalities are changing over programs and this could be valid only for Arcturus. Please move it to Arcturus swsmu late init. 

Thanks,
Lijo

-----Original Message-----
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of shaoyunl
Sent: Thursday, March 11, 2021 10:46 PM
To: amd-gfx@lists.freedesktop.org
Cc: Liu, Shaoyun <Shaoyun.Liu@amd.com>
Subject: [PATCH] drm/amdgpu: Enable light SBR in XGMI+passthrough configuration

This is to fix the commit dda9bbb26c7 where it only enable the light SMU on normal device init. This feature actually need to be enabled after ASIC been reset as well.

Signed-off-by: shaoyunl <shaoyun.liu@amd.com>
Change-Id: Ie7ee02cd3ccdab3522aad9a02f681963e211ed44
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index cada3e77c7d5..fb775a9c0db1 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -2513,6 +2513,9 @@ static int amdgpu_device_ip_late_init(struct amdgpu_device *adev)
 	if (r)
 		DRM_ERROR("enable mgpu fan boost failed (%d).\n", r);
 
+	/* For XGMI + passthrough configuration , enable light SBR */
+	if (amdgpu_passthrough(adev) && adev->gmc.xgmi.num_physical_nodes > 1)
+		smu_set_light_sbr(&adev->smu, true);
 
 	if (adev->gmc.xgmi.num_physical_nodes > 1) {
 		mutex_lock(&mgpu_info.mutex);
@@ -3615,10 +3618,6 @@ int amdgpu_device_init(struct amdgpu_device *adev,
 	if (amdgpu_device_cache_pci_state(adev->pdev))
 		pci_restore_state(pdev);
 
-	/* Enable lightSBR on SMU in passthrough + xgmi configuration */
-	if (amdgpu_passthrough(adev) && adev->gmc.xgmi.num_physical_nodes > 1)
-		smu_set_light_sbr(&adev->smu, true);
-
 	if (adev->gmc.xgmi.pending_reset)
 		queue_delayed_work(system_wq, &mgpu_info.delayed_reset_work,
 				   msecs_to_jiffies(AMDGPU_RESUME_MS));
--
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Flists.freedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;data=04%7C01%7Clijo.lazar%40amd.com%7Cc5aedb6c2d9d49d2fee408d8e4b15b5c%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637510797685776785%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C1000&amp;sdata=7ndhtOVmyZcRMe3UQiGvF%2BprCdBVgo7f6IATXSbQNg4%3D&amp;reserved=0
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
