Return-Path: <SRS0=9Rk5=3F=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ABBF5C33CB1
	for <amd-gfx@archiver.kernel.org>; Thu, 16 Jan 2020 04:51:51 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7CF6020730
	for <amd-gfx@archiver.kernel.org>; Thu, 16 Jan 2020 04:51:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="DCU0gqrz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7CF6020730
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 347EB6EBCF;
	Thu, 16 Jan 2020 04:51:51 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2086.outbound.protection.outlook.com [40.107.244.86])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 237926EBCF
 for <amd-gfx@lists.freedesktop.org>; Thu, 16 Jan 2020 04:51:50 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fN9600vrWK9N9cr0cZCKgqVklJ+vMt5Ws1genlOl4X6JJ4CFPpTkc5f2d8GKAiiRmyH+O7B/Eckii7KYVHM202kYmAB6yOAasz9HzjfJjjRQWLD8eGDZiHLm+OavGrCRbfqxulwsmCxId7/hOtBnM0oC/4TJe7c/PAw8l5wlF1fVAndUpTHnI9c0EC9Xdb+OgK6KnhFGNu3n4GUPqkqkiXQf9L2dfGWGJ0IJOy4+m/l7TryBvXVJ3tmH3DGWrMO/TEcwhaxOAfPRmHFsn7FVnqvk26R1sHW9LEVO/ZqdvttMHcySdnn9Zh2ZSdSAjKnUr2pjU1OohZlvRmj96yXwHg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5uFR6lA190nT6ZzRU/doXwtECaddNKtlZdeVtqW1xZ0=;
 b=R5vqrAGFktnbYnIieoOJ8eXyUOHWdvvypAtB63rYc9iEpK5bnmhoUr42VIPj3ker3zznxc6vqt0lkEGgAVJtY7/0bBr0yZsewUdwPDL7Uy2SdH8Nql5zbXm/zMd67mgpCRGV3FFFa6oUKQPTmjlRbxgt0rq2Zm0f4R4IqlyOYwoVNwaH0gl6gTULigLwXa0TWf/2fyaCCO5nve99xi1BWQ/kUL45z35gcF/Fsfo+yKD4VHhyL6KNh03DAQ5cGDKnppr3oIvWOiZVGC4uJWHyAPwCL7gv3ew4a+rKxPI3RgyQs01zIvd52zsQtC5HG2qz5VfwV0EGpEwRpL8N0uSgEw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5uFR6lA190nT6ZzRU/doXwtECaddNKtlZdeVtqW1xZ0=;
 b=DCU0gqrzWpBEemM211bD1jBFCSPIc1oRvHcyzt1Q5mgL73nYLv6c335ejEFwFw8v2rOsnE1as8MvHQHKU6fF112gFjmPJQo33K4B9RoMFX/yUcyQNrtg3ZZF+CmWS2n1PspK6RDlvJvzV8ClkqH8cJahiDIj71VbkIwOXUXhRCw=
Received: from BYAPR12MB2806.namprd12.prod.outlook.com (20.176.254.20) by
 BYAPR12MB3046.namprd12.prod.outlook.com (20.178.196.14) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2644.20; Thu, 16 Jan 2020 04:51:46 +0000
Received: from BYAPR12MB2806.namprd12.prod.outlook.com
 ([fe80::bccf:40ec:3b93:4269]) by BYAPR12MB2806.namprd12.prod.outlook.com
 ([fe80::bccf:40ec:3b93:4269%6]) with mapi id 15.20.2623.015; Thu, 16 Jan 2020
 04:51:46 +0000
From: "Chen, Guchun" <Guchun.Chen@amd.com>
To: "Zhang, Hawking" <Hawking.Zhang@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>, "Deucher, Alexander"
 <Alexander.Deucher@amd.com>, "Clements, John" <John.Clements@amd.com>
Subject: RE: [PATCH 2/2] drm/amdgpu: add arcturus to gpu recovery check code
 path
Thread-Topic: [PATCH 2/2] drm/amdgpu: add arcturus to gpu recovery check code
 path
Thread-Index: AQHVzCgIPV8j+/rl1ECqGrBR54UhB6fsuMYA
Date: Thu, 16 Jan 2020 04:51:45 +0000
Message-ID: <BYAPR12MB2806A8030B0C4D16C05EDDB9F1360@BYAPR12MB2806.namprd12.prod.outlook.com>
References: <20200116044705.9398-1-Hawking.Zhang@amd.com>
 <20200116044705.9398-2-Hawking.Zhang@amd.com>
In-Reply-To: <20200116044705.9398-2-Hawking.Zhang@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Enabled=true;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_SetDate=2020-01-16T04:51:25Z; 
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Method=Privileged;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Name=Public_0;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_ActionId=a49ca64b-7931-438f-b17c-0000ceae3123;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_ContentBits=1
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_enabled: true
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_setdate: 2020-01-16T04:51:44Z
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_method: Privileged
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_name: Public_0
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_actionid: 6310207c-ce78-49b2-83e2-0000db7d6ce7
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_contentbits: 0
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Guchun.Chen@amd.com; 
x-originating-ip: [180.167.199.189]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: d7f04a8b-30c1-4f01-766f-08d79a3fca32
x-ms-traffictypediagnostic: BYAPR12MB3046:|BYAPR12MB3046:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BYAPR12MB3046564586212D41381C5CDBF1360@BYAPR12MB3046.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2000;
x-forefront-prvs: 02843AA9E0
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(4636009)(136003)(376002)(396003)(366004)(39860400002)(346002)(199004)(189003)(8676002)(4326008)(2906002)(86362001)(55016002)(9686003)(6636002)(81156014)(71200400001)(8936002)(81166006)(478600001)(66476007)(64756008)(66556008)(66446008)(7696005)(316002)(66946007)(110136005)(186003)(33656002)(4744005)(26005)(76116006)(52536014)(6506007)(53546011)(5660300002);
 DIR:OUT; SFP:1101; SCL:1; SRVR:BYAPR12MB3046;
 H:BYAPR12MB2806.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: vCQxXuwtR66bnMCaQ/nfPENX+t55mLBnMxCvyPJCrVfDWY88xTadvt9Q64kf+x8WQty2EwXoP3vvvnzYAJ6Ky/FPOg/FwUqq6KC/za4ASZET/xPgA25QRj1FxI8PnT12Jwn7C43Im2I/RCCxUiNDSBkEm9n4+HG8olh7BJjbOHBT52PK0+8JlQkRYbDWIOiHJ0p0kVCVz3/jjhM2ctH2Jeo3H9IDsEki+kkdbde3sQ+P8YAP0O25wimrLLmBDRZTwt4FPHyccA1xKeF2ycnkxrnpwtyns7Q+myvEoZhUB+zmHLRL8zTsY4fGpI+ZqFsN+f2tV506o21NmlF4gUFZ9W7mgw0+/7665yJUYmEwku1q+YvbmmwDXViCZc/Eddgw9levLcBiuADJpqkEuGk8zIsodAh7h48VQ2DY9UTKpLP7LJXi8gkjtTOOcCaCVuuA
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d7f04a8b-30c1-4f01-766f-08d79a3fca32
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Jan 2020 04:51:45.9647 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: AHLqhXlNc1z72ES0hYklXD6mEngtlqAbEu6s0J2t2MCJlKWZyOmqPkRdJWUM6uvXUWW9iyB+xsa2DTYGnSZtAw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB3046
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

[AMD Public Use]

Series is: Reviewed-by: Guchun Chen <guchun.chen@amd.com>

Regards,
Guchun

-----Original Message-----
From: Hawking Zhang <Hawking.Zhang@amd.com> 
Sent: Thursday, January 16, 2020 12:47 PM
To: amd-gfx@lists.freedesktop.org; Chen, Guchun <Guchun.Chen@amd.com>; Deucher, Alexander <Alexander.Deucher@amd.com>; Clements, John <John.Clements@amd.com>
Cc: Zhang, Hawking <Hawking.Zhang@amd.com>
Subject: [PATCH 2/2] drm/amdgpu: add arcturus to gpu recovery check code path

support check if dirver should try gpu recovery for arcturus

Signed-off-by: Hawking Zhang <Hawking.Zhang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index 706a30e81fcc..8e2f0a380461 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -3799,6 +3799,7 @@ bool amdgpu_device_should_recover_gpu(struct amdgpu_device *adev)
 		case CHIP_VEGA10:
 		case CHIP_VEGA12:
 		case CHIP_RAVEN:
+		case CHIP_ARCTURUS:
 			break;
 		default:
 			goto disabled;
--
2.17.1
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
