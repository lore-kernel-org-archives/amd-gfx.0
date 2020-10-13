Return-Path: <SRS0=VV5o=DU=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ABFB9C433DF
	for <amd-gfx@archiver.kernel.org>; Tue, 13 Oct 2020 07:45:30 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 021C920708
	for <amd-gfx@archiver.kernel.org>; Tue, 13 Oct 2020 07:45:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="4La0nGXv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 021C920708
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7F67B6E09C;
	Tue, 13 Oct 2020 07:45:29 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2042.outbound.protection.outlook.com [40.107.94.42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9A4266E09C
 for <amd-gfx@lists.freedesktop.org>; Tue, 13 Oct 2020 07:45:28 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=K9SX6P1XzoEYrQf9ckmvQFiORiyTP0GrcEKtaTsQTC1iTGmNUjfZn6Py4pK0oke5c7ldpwQdDrmkWL9hRSoKakwbOmS6Ve6ufEptEAOPQKx6WmG8k+9dNR7h8S6cLfoWqExoMuXCTTnSV+Tgdfux+TqtKqAAxAU5UCA9Xw4/mqNy2F4X2o6CTjFJHe8cDvTipszDdsk7PBWwc/I/jW+brajZ6aX/3/M3/PRUPqIAKOjdSYRLu3lm/Z7GutxC1IaZGpcqsW6KJKk3ABSLRWkQJN74T+ZP1Jm7HNX7E6MmbONBe1d7E4pVNoQvIcItxIcMTTw2YPoseliV1+e052lW2g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wRe4TaESXXkDWtaLo2p1kRxobGgjul1bYFJQ5yiZ+4k=;
 b=XsYTWG1NzMjEy/lCOWK/vXwuCAt/Lf0MDAa83eSLNqFl8vdTt1YunPmUGvrvS8YN+ul8LThvMzmfMF7kYGLwEf6MFdUlAetIQez2sen8DLP7giX9R2govkgE9IjhKqN8IcGqjCxB91WYXW/7mUgEO8Yp/yIU9Mre33OGO/2puCfXj+P/Nrl6Haiby1G85cQQjuhOc1rKnBohcvjPwebaKp47Z10TEwFbrYOGIG+ZBjont/mEMov4Yv3/HXJd524dkNYwzuqtkx1v/GRUbGHOS/SMaGsrPBqjJkPWAUOgzYvopBHACVBrqfLUcSWBQ43gBtZ0Y1mhsykcVQBI5vfksQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wRe4TaESXXkDWtaLo2p1kRxobGgjul1bYFJQ5yiZ+4k=;
 b=4La0nGXvnDsZhU7psqWT/BAWnfM3pKYFgNGLZIN87HAR+h8ejBdCbF/BhmDqWmc2wLrrbJEl08nx5txSW6Ggr2byulJaogmTsfxR5akeWbAPfIvNQaw8hSKWvWVi/1Td/jM4QzvFGutZcc3qsXHO571uLWvQxBK+8ALCmO7IDKE=
Received: from CY4PR12MB1287.namprd12.prod.outlook.com (2603:10b6:903:40::8)
 by CY4PR12MB1622.namprd12.prod.outlook.com (2603:10b6:910:f::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3477.20; Tue, 13 Oct
 2020 07:45:24 +0000
Received: from CY4PR12MB1287.namprd12.prod.outlook.com
 ([fe80::ad96:acee:5c1c:d92c]) by CY4PR12MB1287.namprd12.prod.outlook.com
 ([fe80::ad96:acee:5c1c:d92c%4]) with mapi id 15.20.3455.031; Tue, 13 Oct 2020
 07:45:23 +0000
From: "Chen, Guchun" <Guchun.Chen@amd.com>
To: "Gui, Jack" <Jack.Gui@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>, "Deucher, Alexander"
 <Alexander.Deucher@amd.com>
Subject: RE: [PATCH] drm/amd/amdgpu: set the default value of noretry to 1 for
 some dGPUs
Thread-Topic: [PATCH] drm/amd/amdgpu: set the default value of noretry to 1
 for some dGPUs
Thread-Index: AQHWoRo9hcmQoSRBvU+MFXiparfT16mVJUEg
Date: Tue, 13 Oct 2020 07:45:23 +0000
Message-ID: <CY4PR12MB1287D70DC1CE5F4F4B498C82F1040@CY4PR12MB1287.namprd12.prod.outlook.com>
References: <20201013043445.23648-1-Jack.Gui@amd.com>
In-Reply-To: <20201013043445.23648-1-Jack.Gui@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Enabled=true;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_SetDate=2020-10-13T07:37:43Z; 
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Method=Privileged;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Name=Public_0;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_ActionId=fbd47cfe-679d-427f-8727-0000ee49677e;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_ContentBits=1
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_enabled: true
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_setdate: 2020-10-13T07:45:21Z
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_method: Privileged
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_name: Public_0
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_actionid: d211c5c7-b852-47c5-9522-0000f50ac4ea
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_contentbits: 0
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [58.247.170.242]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 4473f934-378e-4c7d-18d4-08d86f4bf18a
x-ms-traffictypediagnostic: CY4PR12MB1622:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <CY4PR12MB162243943E103E86AF329786F1040@CY4PR12MB1622.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: PCB3IwYkBvA6I80zjFhKJN1Gpiz+aSd/g23iOypwt5rwaCbjdeWoJiRnhTxqghzOp27yBe/VaJDQ7HZbdQFwzkPMRazX9JGWuzOa4qDnrosGa8UKovdA3YH6a+a7ZrmXdOuFD0e0q7eESyxXJaJRTRS6zIDNqk7qV36iDAsTBlXgmFGHGRl9S3fgRGBSnocal3F8m7WVJb7L7KxQc8YDnVSwVLEmV0YkugMQROTWNWcGgiAo6rjNXfU3TCbgHa/Bv7nHphZgdnPs+O459kEwSez0qYdJ76zvfXH5hkRFdRfG9gweWbk8vFSui96EDqmo
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CY4PR12MB1287.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(376002)(136003)(346002)(396003)(366004)(39860400002)(5660300002)(33656002)(55016002)(6506007)(6636002)(54906003)(110136005)(186003)(316002)(26005)(86362001)(7696005)(53546011)(8936002)(478600001)(8676002)(71200400001)(66946007)(66476007)(2906002)(66446008)(64756008)(66556008)(52536014)(83380400001)(9686003)(76116006)(4326008);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: gLpCDfZchDY9GXGyFaxyQ2mMXe96MvKB4O6AObm5LPjKorNDDUf5TZYAFiNjZV3VmRBhwTuB/B2WSPlMKVeRdscYtFXirEVSwPsuG8eB7XS/2Lxz3RGbPHpuyjC9Nr8RYym+EPCFhuJ+R7uJLfXeJCv28BPQf81yQuY1/TFuVVqbbs72nPhvBNk7M43LfSaIoPJ+vVe1TJFa5H3x14qcBfpPkmLPThnS1CagSCZUfnPY+SQnmUEjwmmXvJiOEg788wctkLM5p8SJfruiY0wpz0Ygzqr1UO2T5mPPXp4wbPRVxexa6G9f2XwWzcjzO8HKR7pbHyplAjlYdcKHY2fHV5t8hl+58yYzwSxB5hqbuAW5PSxBIlEJNcIlXGvPGmLsWpMkpQH0hUbtFRdpueMTdxh6J8g5nmeO6Y56T3Lc1UEJpl13jHY6gpZIoPOZKosvMwJEjsoi5TGH/jZKJmQ8iJe1pC0Hxja9hZJDzthSp5khoTtXifREqXC6zLHVTahtPGRW0ZA1NHcM3lW6csEpKU+lWJkkjveR6i2AwRaf0RHF/Sy7NY+QvsgTPvqNBu4kdjMSB+wp7G0jNsL6vFzgfOq7zYCjPrV6n9GfjO4jJ/jwLpFHDfYkdH28n+hmbXn73L8FbT+xsuAMcb3fVwKX7g==
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY4PR12MB1287.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4473f934-378e-4c7d-18d4-08d86f4bf18a
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Oct 2020 07:45:23.6155 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: fU6SPFoOX0jAYotYvw8TZ+AOAlmKSE/E70hXqoNs9+r0F1Onw2+jXXjjNzZyCGEna88bnlc+BaTIVqyXSP4OvQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR12MB1622
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
Cc: "Kuehling, Felix" <Felix.Kuehling@amd.com>, "Zhou1,
 Tao" <Tao.Zhou1@amd.com>, "Huang, 
 Ray" <Ray.Huang@amd.com>, "Gui, Jack" <Jack.Gui@amd.com>, "Zhang,
 Hawking" <Hawking.Zhang@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Public Use]

Hi Jack,

How about improving the patch a bit like below? As the code for raven and default case is totally the same, maybe we could squash both together with adding the comment for RAVEN and other default ASICs for readiness.

switch (adev->asic_type) {
	case CHIP_VEGA20:
	case CHIP_NAVI10:
	case CHIP_NAVI14:
	case CHIP_ARCTURUS:
		/*
		 * noretry = 0 will cause kfd page fault tests fail
		 * for some ASICs, so set default to 1 for these ASICs.
		 */
		if (amdgpu_noretry == -1)
			gmc->noretry = 1;
		else
			gmc->noretry = amdgpu_noretry;
		break;
	case CHIP_RAVEN: 
	default:
	/* Raven currently has issues with noretry
	 * regardless of what we decide for other
	 * asics, we should leave raven with
	 * noretry = 0 until we root cause the
	 * issues. The same for other default ASICs.
	 */
		if (amdgpu_noretry == -1)
			gmc->noretry = 0;
		else
			gmc->noretry = amdgpu_noretry;
		break;
	
Regards,
Guchun

-----Original Message-----
From: Chengming Gui <Jack.Gui@amd.com> 
Sent: Tuesday, October 13, 2020 12:35 PM
To: amd-gfx@lists.freedesktop.org; Deucher, Alexander <Alexander.Deucher@amd.com>
Cc: Gui, Jack <Jack.Gui@amd.com>; Zhou1, Tao <Tao.Zhou1@amd.com>; Rui.Huang@amd.com; Chen, Guchun <Guchun.Chen@amd.com>; Zhang, Hawking <Hawking.Zhang@amd.com>; Kuehling, Felix <Felix.Kuehling@amd.com>
Subject: [PATCH] drm/amd/amdgpu: set the default value of noretry to 1 for some dGPUs

noretry = 0 cause some dGPU's kfd page fault tests fail, so set noretry to 1 for these special ASICs:
vega20/navi10/navi14/ARCTURUS

Signed-off-by: Chengming Gui <Jack.Gui@amd.com>
Change-Id: I3be70f463a49b0cd5c56456431d6c2cb98b13872
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
index 36604d751d62..f317bdeffcb1 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
@@ -437,6 +437,19 @@ void amdgpu_gmc_noretry_set(struct amdgpu_device *adev)
 		else
 			gmc->noretry = amdgpu_noretry;
 		break;
+	case CHIP_VEGA20:
+	case CHIP_NAVI10:
+	case CHIP_NAVI14:
+	case CHIP_ARCTURUS:
+		/*
+		 * noretry = 0 will cause kfd page fault tests fail
+		 * for some ASICs, so set default to 1 for these ASICs.
+		 */
+		if (amdgpu_noretry == -1)
+			gmc->noretry = 1;
+		else
+			gmc->noretry = amdgpu_noretry;
+		break;
 	default:
 		/* default this to 0 for now, but we may want
 		 * to change this in the future for certain
--
2.17.1
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
