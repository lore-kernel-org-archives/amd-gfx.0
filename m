Return-Path: <SRS0=8BU1=C7=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67641C2D0E2
	for <amd-gfx@archiver.kernel.org>; Tue, 22 Sep 2020 09:56:25 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B049C2388B
	for <amd-gfx@archiver.kernel.org>; Tue, 22 Sep 2020 09:56:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="AA+VeLLB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B049C2388B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DFB736E0B6;
	Tue, 22 Sep 2020 09:56:23 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2087.outbound.protection.outlook.com [40.107.223.87])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6A8046E845
 for <amd-gfx@lists.freedesktop.org>; Tue, 22 Sep 2020 09:55:56 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=E8u/sEecGLeJj1q6r8ttTafElCPzchbBFNwWA7tPeJBSlSGj/L8/DjR1WsVGT7Q0qqThOPOdjnCb0f3gbBQujyoxKadg1cjKD2GEXoegOcc/0xYOqFKTb5FxMefiYqo27p1SBSdJdeNRTpqbSjw0s7YkiFy7HjYNThUxoXBgUGepfuNNqVA3XSrgF1ZSr8nap7TXo+WwR8sMbUmJuYiKqR4rqPAWvhp67vMHl8eDSfFUXEbWiGn6fCNBNuPlWdyDvG/a3HM3D4/sX8snYbUJChYGmLNtAK6uyBxT4RULy5ImIAvZkRmjLqiLAAZgXJBU8ICvmL20re2k5x76P94h9g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oxnvhn6zTYp9kS6SBo3aTrzuLAqwo1f/qwCYNARvDJU=;
 b=S8clFLHdgGZJ/9ruWVVt6Rb0pWIwtXNNYs9VewWQmPcdQ5/KL8qV3l7vaYV2PJwAj+L8FgUPyceO05lN5c5VADHIskfqulDKFtLeeAC225ksDcaphpzD9J3DrhR+oHN+qwl9HI1gS7S34Y24BnIh+3mGXI8XtXcBIOqDDYLePQlO1u7inY3zSeBzP6DjTN2+do6/bDhbVfKzEhDDEgQ2x3FeCfnXDsT6ZszLib1kGzNs3qr63t7228uz1mMOXkcTXByKZeVJEbgBc0mL7z0wEkafqvg8hLuVX2ZPf/IZgIt6wOFngSe7f89hP32xH4p18dCkPMcZgO9H020zFnXhEA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oxnvhn6zTYp9kS6SBo3aTrzuLAqwo1f/qwCYNARvDJU=;
 b=AA+VeLLBSQMGxsET/X8tDOo5VRPS25cwj/rc0of8+9FVwKgNztnPQq3J9iabIB+BdVXCbgRA5UDmGx0vlIiJ7l1ts2hIrw9yzBhFfSZNELUDOxRL98gzViMafCIBJXYS33VFdyi5CE4uXtp72AmFCxZxGSfS1e6BbOHvcUNETOc=
Received: from DM6PR12MB4075.namprd12.prod.outlook.com (2603:10b6:5:21d::8) by
 DM5PR1201MB2507.namprd12.prod.outlook.com (2603:10b6:3:e9::21) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3391.11; Tue, 22 Sep 2020 09:55:54 +0000
Received: from DM6PR12MB4075.namprd12.prod.outlook.com
 ([fe80::b51c:2b0e:7e1:b233]) by DM6PR12MB4075.namprd12.prod.outlook.com
 ([fe80::b51c:2b0e:7e1:b233%9]) with mapi id 15.20.3412.020; Tue, 22 Sep 2020
 09:55:54 +0000
From: "Zhang, Hawking" <Hawking.Zhang@amd.com>
To: "Yang, Stanley" <Stanley.Yang@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH 1/1] drm/amdgpu: fix hdp register access error
Thread-Topic: [PATCH 1/1] drm/amdgpu: fix hdp register access error
Thread-Index: AQHWkMA2G1/XmGWBdU+s8PiWU0MsxKl0a2Bw
Date: Tue, 22 Sep 2020 09:55:54 +0000
Message-ID: <DM6PR12MB40759648DC8953B820BAAFFDFC3B0@DM6PR12MB4075.namprd12.prod.outlook.com>
References: <20200922091022.31676-1-Stanley.Yang@amd.com>
In-Reply-To: <20200922091022.31676-1-Stanley.Yang@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Enabled=true;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_SetDate=2020-09-22T09:55:51Z; 
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Method=Privileged;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Name=Public_0;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_ActionId=2a55c4ac-123e-4421-b806-0000d8a1332d;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_ContentBits=1
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_enabled: true
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_setdate: 2020-09-22T09:55:48Z
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_method: Standard
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_name: Internal Use Only -
 Unrestricted
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_actionid: 7b9522e2-19a6-4463-931a-0000889039c2
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_contentbits: 0
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_enabled: true
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_setdate: 2020-09-22T09:55:52Z
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_method: Privileged
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_name: Public_0
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_actionid: ce97f699-9985-47ea-939a-000086517dee
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_contentbits: 0
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [58.247.170.242]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 3feda9a5-c726-44d6-f50e-08d85eddb22c
x-ms-traffictypediagnostic: DM5PR1201MB2507:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM5PR1201MB2507703B0FEA9620189CD3F3FC3B0@DM5PR1201MB2507.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:4303;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: kMJDNd1v1onllFoyOyzLd2snYQHS/mu7TxljGAutxhPrb6J1wiyrLk54GQZleL03lK78yPXAt3eGO+lg22PLCf8IxlHYHzyVsxhDU157nRnNguTE3e4Me4ZkApv6YiXlGFnhd0wHVVbdOHMvtpbjibbyoVUVq2pKiP4CzgFAU6VhxX8NxGf913QsVNyGaAl0uj7rlB0k4ozZNNdHo3yaRSlP2mbjkxJuzLWKIqALXIWTjfHMLRD8QJO+ZdLUjMGiHa4f4eQdUPPSc0H1gwMOH7o4UROVWSqzlGuSENWeymBr0hcBqtQkoJhNqRFb4VcRlcQnKotmDpBTrWEyiNmvCk6AOV0QKMNjUG8iuwUJ86Q=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB4075.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(39860400002)(376002)(136003)(366004)(346002)(396003)(64756008)(66556008)(4326008)(66446008)(71200400001)(76116006)(66946007)(52536014)(9686003)(8676002)(55016002)(8936002)(186003)(66476007)(7696005)(110136005)(316002)(53546011)(33656002)(86362001)(83380400001)(478600001)(5660300002)(26005)(6506007)(2906002);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: yYm9xRmKLIUqwpimdT2XC65QZAGx59XEzmXYoq/mSZyE89hKgz6ch48mbYSd3VMCqzDtMG3rwA0I0rpkg6wf0dY/c30x4i0fuOlcAAT7qRNu4dEx3ekQ0iRWWaJ2oAd0YFDsNJ8GvUpGjfec5ogfLtl6nFK54Uj1E7vdYsjxZNrcj7G9TgKT8hzRmMma6Is2Ll1aQQ8eJfUMxq+wOpGYzaP2/IVyBSqmrfDD0BoajazyX2x/3hsnIs88z4V9FYEEm8jgsBEZLN86Alwqq8JGGbNJHIuQwFnkpuMfot4PaoN12+35VBbwfarmGPVhtlW6jSTIEyyvM+uxXKK+R5eaouXY3ZaxHaHLrysMTO06W9ATWUKBLsrg+kCd32ArSMgG9GBk7jZmlQQceebcPoBAKPL5cyjTXsfO+NOYV+E+o4BJrhiw8OrU0K+zKH8pMpYMPmt0BgrhZ9g/41cjOYh9GV3P6CTRILVe00V27andCVVc4RfDWfR48LeYPSyIMPymhprnABDwpqIUcit6SwUgIO5CvkcwGlwsi/MudHa0P4RqugVaWdypkuslcxGYBZzcSs4d3mY+pV5EKZMDhcSkpg2m9rZxyOSRD2ZkeJWXXfxMjntbdfql13voehs9YL/+QBe/eIqaf+IyqbCQUin6Zw==
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4075.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3feda9a5-c726-44d6-f50e-08d85eddb22c
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Sep 2020 09:55:54.1595 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: MVStEcwy9hGe+23nZpwPpG1kqM6VxLZbmA2xweShe+BCi/NAHyPgHJebLjVs+zPNw9Islz6j+zPnu6YAriy+wQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR1201MB2507
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
Cc: "Yang, Stanley" <Stanley.Yang@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Public Use]

Thanks.

Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>

Regards,
Hawking
-----Original Message-----
From: Stanley.Yang <Stanley.Yang@amd.com> 
Sent: Tuesday, September 22, 2020 17:10
To: amd-gfx@lists.freedesktop.org
Cc: Zhang, Hawking <Hawking.Zhang@amd.com>; Yang, Stanley <Stanley.Yang@amd.com>
Subject: [PATCH 1/1] drm/amdgpu: fix hdp register access error

mmHDP_READ_CACHE_INVALIDATE register is in HDP not in NBIO

Signed-off-by: Stanley.Yang <Stanley.Yang@amd.com>
Change-Id: I4375a8a67d3a13f9605479e169169e22dd5833d1
---
 drivers/gpu/drm/amd/amdgpu/nv.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/nv.c b/drivers/gpu/drm/amd/amdgpu/nv.c index 0ec66030bd11..bc894cfba60c 100644
--- a/drivers/gpu/drm/amd/amdgpu/nv.c
+++ b/drivers/gpu/drm/amd/amdgpu/nv.c
@@ -621,7 +621,7 @@ static void nv_invalidate_hdp(struct amdgpu_device *adev,
 				struct amdgpu_ring *ring)
 {
 	if (!ring || !ring->funcs->emit_wreg) {
-		WREG32_SOC15_NO_KIQ(NBIO, 0, mmHDP_READ_CACHE_INVALIDATE, 1);
+		WREG32_SOC15_NO_KIQ(HDP, 0, mmHDP_READ_CACHE_INVALIDATE, 1);
 	} else {
 		amdgpu_ring_emit_wreg(ring, SOC15_REG_OFFSET(
 					HDP, 0, mmHDP_READ_CACHE_INVALIDATE), 1);
--
2.17.1
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
