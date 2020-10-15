Return-Path: <SRS0=r20P=DW=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0945DC433E7
	for <amd-gfx@archiver.kernel.org>; Thu, 15 Oct 2020 08:34:46 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 655622075B
	for <amd-gfx@archiver.kernel.org>; Thu, 15 Oct 2020 08:34:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="PkYKWGSG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 655622075B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B789C6EC24;
	Thu, 15 Oct 2020 08:34:44 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2068.outbound.protection.outlook.com [40.107.244.68])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6A2FC6EC24
 for <amd-gfx@lists.freedesktop.org>; Thu, 15 Oct 2020 08:34:43 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VcRBQb+Ta3q2C7oh/yti29FN+0R9TG+MTLLFUYDsCisH0eh1FA6rpk1an/eGbW0sDvM9XZCn/aXsCsQC8pz72YZoMOYXZOfEFjFbSdnl9wCOEz47cHr5Qohd/9y9oyFkqpmTFxE48ZWHOTtN2svU2Pn/kjIhoLxvGAYOjTMKzhxNOnjRhsynzrnqabaZuoyZwghVSkYXApfORj8ME11ibM3biNVkEeucX5eE4EhLqrEJcueppKJ34gns5pja2zNX368S+5a41QbDMaJsj2TxeDSC8VHtcleBfbdvFwRbZ+w3ssNtkF0kSxoBYpRaibcd3StXJkOhkjuA8K7r8pcTtw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/Xx2QfFTQBfWb0BImfQ+FNm0WyKSs09jqoC/hz894k8=;
 b=b+dzFfmBIBuegthgfP+LwUMltin8z3obS9tc/iMUtoN7l9NZCvpPb1hGKRvhsI0DzsbIqTikg3wQzh2cOIBPs1VZY3oPUaGndCPPctGjVgJdZw24vn0ozwRs1dQQIr7OV2JIEM45wG6qH2VynaEIdVWACtlY0aU0BiDuNHfwriP2qjGw7Hz4mQFtmVJ3OvKLEHhPd8kaGNgckt7BY6FhKQmPeEbSjxQ+67u+K1D2cMNA9bzVY5vtE748xFBzzmNaQdKwyddVREXZG0xZSotg37DqcGK2SGeogfm+GdXtAc77Uq7/7Su5A0feQR6aePA0wafXhV/AFMWC5GArhksOOQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/Xx2QfFTQBfWb0BImfQ+FNm0WyKSs09jqoC/hz894k8=;
 b=PkYKWGSG1w0gHWZBAKs4/UjTJEnYe7nBvQKTm519whjUcYWemQ2frryKJeY48zKRKYFqPd4xCpBlv7OWw8IME9lql851RjPZfoKAyr4DcPdm7v/if4t9bt4l7IK/kowpHapYnHyAKpSrblnBrLz4ZuPOIRFZNrh131g7FRKVUIo=
Received: from MN2PR12MB3549.namprd12.prod.outlook.com (2603:10b6:208:107::17)
 by MN2PR12MB3118.namprd12.prod.outlook.com (2603:10b6:208:c6::33)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3455.28; Thu, 15 Oct
 2020 08:34:42 +0000
Received: from MN2PR12MB3549.namprd12.prod.outlook.com
 ([fe80::50d1:2a06:c83c:2cbd]) by MN2PR12MB3549.namprd12.prod.outlook.com
 ([fe80::50d1:2a06:c83c:2cbd%3]) with mapi id 15.20.3455.035; Thu, 15 Oct 2020
 08:34:41 +0000
From: "Jian, Jane" <Jane.Jian@amd.com>
To: "Quan, Evan" <Evan.Quan@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amdgpu: correct the gpu reset handling for job !=
 NULL case
Thread-Topic: [PATCH] drm/amdgpu: correct the gpu reset handling for job !=
 NULL case
Thread-Index: AQHWosFOyKorioFRtEW5Wd2KsY+dtKmYVfZg
Date: Thu, 15 Oct 2020 08:34:41 +0000
Message-ID: <MN2PR12MB3549B10E5DA21384C6465033FF020@MN2PR12MB3549.namprd12.prod.outlook.com>
References: <20201015070313.14078-1-evan.quan@amd.com>
In-Reply-To: <20201015070313.14078-1-evan.quan@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ActionId=628a3187-eeef-443d-8489-0000bf4e8ba9;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ContentBits=0;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Enabled=true;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Method=Standard;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Name=Internal
 Use Only - Unrestricted;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SetDate=2020-10-15T08:32:37Z;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [58.247.170.242]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 991d9c4b-edb6-4856-e34a-08d870e52989
x-ms-traffictypediagnostic: MN2PR12MB3118:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MN2PR12MB31182F7CE0DAD08F0C14620DFF020@MN2PR12MB3118.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2150;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: WN0MirsDpv8vtVL/Vam5YIdoXJE7ReEFyUhM1YaYOL++L4piElC5hckmXwdw1wuPUSf9yhrJmVCHDLVemsv25f04VsccZnwPHHtCSsMGrhyPjjO89WWE2HbDpdHkdYUHFcuE3HZCB02vDlyTqW+6cT1eTdqPRTtSd69sB8b0hwCdTXV7WD4ovVdeMUXvHUzCSubp31pmSXhlozYabK96xZynmmmnOqnQ2Mu3p7O1uyYDo8BteejkbWfpIokcLJWa26W3MQd9Jzq4csNQNf2TOiq3RavSc7+VHPTENrNlDrUROjLKRbDMzThsxwv0VC3BURIbHXLY44B7vzzyFa1gcoLiUCSG1EeAc0PyyIurXFCwGICDF2GpiNQM1usmqe6iYEleos7yNkNDNFM55UmuzA==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB3549.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(39860400002)(136003)(396003)(366004)(376002)(346002)(8936002)(33656002)(26005)(5660300002)(6506007)(66556008)(64756008)(76116006)(66446008)(186003)(7696005)(53546011)(8676002)(66476007)(52536014)(478600001)(55016002)(66946007)(9686003)(71200400001)(86362001)(4326008)(83380400001)(110136005)(2906002)(316002)(116360200002);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: VEfpkWmZvb0sRVQmJ6nYBLalEuFZWi4NJ1mUXYopKulEhwmLfHJy+tONE2dKWzsIm+BTTI86+usNQ9ORbEC5hcRJCFx35oaccvJwlz6s43fPg+ZaWm8bIZOAYLQxKAS6jpdzAVRpbAUhnvYhI2QjTPcXgSZvXiHpUYxC4I7wwwJeN9S1PMymSwgw/zwJRUC0bMq9VzVQQvOYRa6K8OVEuZZ9dJdXZzFcO1T0+Sfuuqgx0++y7O1dB+EWXiPT2bjSdVEd0qDI3omTim+eMaq39rrl1mEAbD7hwnLhjHE2jsNrwzmDI0oSgrDWbmmFYdcHuLJZDtixhfy/VEEcqpk5DJa13Vy1rfqmhOK8qhN8ZsuMbEQFULG29bCoIhw7sod9Ecan5LJYqCNNKEWXAQEDSP6mny9SR0+JN54p+f4O8s9vGmv36B3vKEI2BZEM35DzjNP3zd9b9usML99EkgxtAqe1bk6yXwpFiYRDbonNTHBAEBoxCWmDu3v/+J074voPPymBE+02zEi34yC3f3Jz7OJ2YeL2nrss2sC350bW8xQoQjsl89GmjOfwzzP7TxFfUwC7MiRZITiz/jqC0SINX6IeBM5/E6aG943UF5zMwAxw7eqdXDMF8m3oJdi8iEY2z4ltV0d/EYxi43cKgWEE+g==
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB3549.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 991d9c4b-edb6-4856-e34a-08d870e52989
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Oct 2020 08:34:41.9139 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: VaqHUIyCrZvzsnMwL5wEeHtSMNJOlu1rtTQ5pSaEB1w4zjVN5i+rVeaWsVkCOjVA3QFO67yT9939nOcnbUEf4Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3118
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

[AMD Official Use Only - Internal Distribution Only]

Reviewed-by: Jane Jian <Jane.Jian@amd.com>

-----Original Message-----
From: Quan, Evan <Evan.Quan@amd.com>
Sent: Thursday, October 15, 2020 3:03 PM
To: amd-gfx@lists.freedesktop.org
Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Jian, Jane <Jane.Jian@amd.com>; Quan, Evan <Evan.Quan@amd.com>
Subject: [PATCH] drm/amdgpu: correct the gpu reset handling for job != NULL case

Current code wrongly treat all cases as job == NULL.

Change-Id: I3d686617bbe67bf64e8a6ff8cc5b0de11b80afb6
Signed-off-by: Evan Quan <evan.quan@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index a2f0ce854160..24e6de3aa8d8 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -4643,7 +4643,7 @@ int amdgpu_device_gpu_recover(struct amdgpu_device *adev,
 retry:/* Rest of adevs pre asic reset from XGMI hive. */
 list_for_each_entry(tmp_adev, device_list_handle, gmc.xgmi.head) {
 r = amdgpu_device_pre_asic_reset(tmp_adev,
- NULL,
+ (tmp_adev == adev) ? job : NULL,
  &need_full_reset);
 /*TODO Should we stop ?*/
 if (r) {
--
2.28.0

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
