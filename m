Return-Path: <SRS0=8zgd=GH=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 228D3C4332D
	for <amd-gfx@archiver.kernel.org>; Mon,  4 Jan 2021 06:57:21 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AA1C42151B
	for <amd-gfx@archiver.kernel.org>; Mon,  4 Jan 2021 06:57:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AA1C42151B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C1BDC8946E;
	Mon,  4 Jan 2021 06:57:19 +0000 (UTC)
Received: from NAM02-BL2-obe.outbound.protection.outlook.com
 (mail-eopbgr750072.outbound.protection.outlook.com [40.107.75.72])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 35D698946E
 for <amd-gfx@lists.freedesktop.org>; Mon,  4 Jan 2021 06:57:18 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QTdIOTszh8V5NFU6TbUGMNGHEoRzQc6k391CHCBbuHhIaQit6dI1J2nr7WGLdfEAk3rudttV0A/7KX0UqoEhKHHwKhJ7kj2W4iprDEzJa3MzMcnxs0MxqULmLM2tJEprSeWmohCO0iX/KGeiqJ6mKgOl0y+sbZn0Bzu51qhGHnlDOhAukL1XPc5OYeYMe6f8ffUc/Ryg8D0Zzm5Rka8m1JYDbySmin6qzZ+Zez8EKYdc2CIfBl9g2QFL75/uCZJdBloI1c3BMyzX3l0iIsO5BztxwJ3z7ZreDpfBId9AfWWf3TqFilcMfC4+dM6dYNR6GNjzY7NCRp1kVEYnKVAgqw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sBj7jDNxihxtqHYF+4yEVBPdKl++Z7g9QkOY87iqaVw=;
 b=QXdmtmHC5yQSdws+RF9W4s+UXdOj0tjdt15iKuunsmFobODXMMO2oOHDivbdFteMUX8Ur8mulDk4xOpJzFf/JcU0enF84cyilDmaiNYfXnJzA+aUQ62qHYiLFrsgDU7agUGAunFgCbegg8Mti7cJ/QNaX+RMXRoiJn/JCuBzvrTp2LTfa/hlzAD1nTwxVKSlWMyA0FjUcDHuNQO+ZtY3h88IxnO4iK31scFCV5v267RLgNEX27+QLJ31+Uno69CXNppHf3fwlUYow5d6YLGF2NiWPlGlz7q5ZxAzS0Hokq9L5BkTwXz/uTDN6iR0nhqrBEZYlBzExsEt4Nff3xeqeQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sBj7jDNxihxtqHYF+4yEVBPdKl++Z7g9QkOY87iqaVw=;
 b=U6eVhRlXQLL+jZgcaXsxq4KAgP8ng68BtDW5X3IAIyML/IpyB0zWrmRogffyXc40jCAtezVCLBqrL5XQjp4ByEmvKtJeFEpKUgR6uBNrnHkIbN5WuUtuFBmEsXMeoOM9oDDGXEnWKezu68vcWnTzUc75nyxHLAEsAfMIIzT5u3A=
Received: from CY4PR12MB1287.namprd12.prod.outlook.com (2603:10b6:903:40::8)
 by CY4PR1201MB0039.namprd12.prod.outlook.com (2603:10b6:910:1e::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3721.21; Mon, 4 Jan
 2021 06:57:16 +0000
Received: from CY4PR12MB1287.namprd12.prod.outlook.com
 ([fe80::bc0f:dd2:ef80:de2]) by CY4PR12MB1287.namprd12.prod.outlook.com
 ([fe80::bc0f:dd2:ef80:de2%12]) with mapi id 15.20.3721.024; Mon, 4 Jan 2021
 06:57:16 +0000
From: "Chen, Guchun" <Guchun.Chen@amd.com>
To: "Zhang, Hawking" <Hawking.Zhang@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>, "Deucher, Alexander"
 <Alexander.Deucher@amd.com>, "Yang, Stanley" <Stanley.Yang@amd.com>, "Li,
 Dennis" <Dennis.Li@amd.com>, "Zhou1, Tao" <Tao.Zhou1@amd.com>, "Clements,
 John" <John.Clements@amd.com>
Subject: RE: [PATCH] drm/amdgpu: drop ras ta firmware loading for non-ras asic
Thread-Topic: [PATCH] drm/amdgpu: drop ras ta firmware loading for non-ras asic
Thread-Index: AQHW4lYt7eveuvOQHkSTMfUhjQQnMqoW/00AgAABNDA=
Date: Mon, 4 Jan 2021 06:57:16 +0000
Message-ID: <CY4PR12MB1287B5959D62E8554A1B4CA6F1D20@CY4PR12MB1287.namprd12.prod.outlook.com>
References: <20210104045741.22623-1-guchun.chen@amd.com>
 <DM6PR12MB40753D9F3AD6F45122AD08EEFCD20@DM6PR12MB4075.namprd12.prod.outlook.com>
In-Reply-To: <DM6PR12MB40753D9F3AD6F45122AD08EEFCD20@DM6PR12MB4075.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Enabled=true;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_SetDate=2021-01-04T06:22:30Z; 
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Method=Privileged;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Name=Public_0;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_ActionId=cdfbdbad-02bb-4862-8a8d-c469d16352e3;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_ContentBits=1
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_enabled: true
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_setdate: 2021-01-04T06:57:13Z
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_method: Privileged
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_name: Public_0
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_actionid: d7474cdf-930d-419c-b9a2-00009205ef15
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_contentbits: 0
dlp-product: dlpe-windows
dlp-version: 11.5.0.60
dlp-reaction: no-action
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [180.167.199.189]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: bf889153-e9c4-4f32-d95f-08d8b07df8b4
x-ms-traffictypediagnostic: CY4PR1201MB0039:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <CY4PR1201MB00396E288F9E245BE02657AFF1D20@CY4PR1201MB0039.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 9Rq5Ahd7VPXLo2NtR0K2R0WXTlHIdRMHGA0PfCMKWK52NRj0M//lOlD6zxIQ1ElBFAjmChcTqTjjS4JWJHxTu28ZLuOC6xeKQoTRCWnfzoZ4F/ClXjhKxC9xLFRuH99thXnKioerIwrg1zHH2vVIeA2pNYuAyq+yMIeZxLBHE+493G5f1uUmK7nFMGsLJVPeY5QowWijCLxF83I8Q0SSPVa6J992S9vVYRueCH2rRmkNUYwPTkpVy5094o/PWo40qXfk6pwo0JPtab/K8rwsJJlXw8JuFbqLoNcXJ3kjHbvt5yQGexSmSgDXEmPARUJCBU+hcPJq48kMiNSpvydDpdvyCHFEjVzLgb54ECuDTxSDJkdQmG0i89cfZRAGoXBg7fgKQcQpkuQe0ThVOL07zv37r/rPKkdqoKZhnFQWE48uFilvGocZtIkOJhJdxc/S
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CY4PR12MB1287.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(346002)(396003)(39860400002)(366004)(376002)(136003)(7696005)(33656002)(478600001)(55016002)(186003)(52536014)(5660300002)(66446008)(64756008)(66556008)(66946007)(66476007)(76116006)(8676002)(2906002)(83380400001)(8936002)(110136005)(6636002)(6506007)(53546011)(316002)(86362001)(921005)(71200400001)(9686003)(26005);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?6n6pv+igbIOZTftYqw4HiSXvqT53+eH8PspWy5ISJNVCV4FwteuWAr3CShXE?=
 =?us-ascii?Q?X5oY4ay7nX+QGJ7Cj93bp8mdZqap6dNgGAPBnYz2mmBF9hsa6+evI89KREec?=
 =?us-ascii?Q?GqSqqNnfqXMeB4PrOJgc/mqDQoCeJJDCcACZy0kCPWtPM2vvv4ur/UGGS7+W?=
 =?us-ascii?Q?RmJuTHCZWRI9D7qgZjOgaqX8dQiLMHK6sR3A64uMkuRzATcXRpbN7XruNxKN?=
 =?us-ascii?Q?R4dhTVFzLEZcrLcyE58a9ezZvoLBZFjB4Bax9LXrLP2hfBKCNGUetTHDd/O0?=
 =?us-ascii?Q?fzIAOpHkxaQ+xKTjOWw/J1LB6ouqST2rnwdxJA+n5CUiRW7tLCc47x851WSf?=
 =?us-ascii?Q?a4CAa2id1EMJkx0ZnN95b4xcyssd4G9ZioOC0MooJK2JGIlMAj9V55u50QJB?=
 =?us-ascii?Q?wds5DTJxuNZHAFri1XAOwqJM/kWLeqRyZpuzz4f2WSRwAv6Gm3wluSKNkCNE?=
 =?us-ascii?Q?sCUfjbWnslvEPuD7kfpgaOkff+dHdpshKjFSNBD8C19gJFKKx7SEIH1qonKz?=
 =?us-ascii?Q?mfOIbFzo+kpzHlu9a+I4THRMNYC4VLcRsJ2zmZ7hLPgmPnd/UwsVCtcHB4D0?=
 =?us-ascii?Q?JEd+dyt6CniymPLBT6hBMBq9wsGCCDzVE+SyG53DVwp3wMiNssZn9HwIwBQj?=
 =?us-ascii?Q?MzLOMU0uBbK2qxOJMwGtHzUznyQBne/qZDUCQ5ySgRU19CdDbU/4XRVmwlQX?=
 =?us-ascii?Q?Uej2DZkXRd7ijt/yE2XHIsejhHtusMblZSlc7y0jot9tTIg6b6EF4pJpWWp6?=
 =?us-ascii?Q?Xw/td1vlrN0USsemul1Y3/OSGrLYrEKJRpsocrTnIv+xvqecKInAjnkd/6tO?=
 =?us-ascii?Q?vcBAR/iwjmPdQT/QSpmQIQq26JQORWLSHcVo0a0mlrwcze7fliUMUw+Vyu5u?=
 =?us-ascii?Q?RgcWLdEYh4L8NI2wRXhV1xXdAqSLnhyD3Bgq+/Rgd6/E0QuLY2Yrmox5CA9z?=
 =?us-ascii?Q?XjJAvKNpEM2g2pQ63ti64FMssEaR4BJ8g/IDVvkuvGjY6rgx9RLwyImKAZ78?=
 =?us-ascii?Q?2zM0?=
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY4PR12MB1287.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bf889153-e9c4-4f32-d95f-08d8b07df8b4
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Jan 2021 06:57:16.0698 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Vbu0Ii/uZhiB6QCEwibr46+uFpnQNWCyU7y7OAPAaiEhCQ/1w8N1ePhPgXOsCncEtRFemEzi0zF58WCVC3XFMA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR1201MB0039
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

[AMD Public Use]

Hi Hawking,

Yes, these kernel messages are indeed not harmful, but some audiences may feel confused on this, as they will guess why kernel said " ras ta ucode is not available " during boot up, and furthermore, if the users miss some FWs? So this is to exclude the confusion on the ASICs that don't have RAS feature.

Asic type check for ras is not introduced by this patch, it exists already as it's used in amdgpu_ras_checked_support. This patch extends its scope by moving it to header file(amdgpu_ras.h) for wide usage.

Regards,
Guchun

-----Original Message-----
From: Zhang, Hawking <Hawking.Zhang@amd.com> 
Sent: Monday, January 4, 2021 2:23 PM
To: Chen, Guchun <Guchun.Chen@amd.com>; amd-gfx@lists.freedesktop.org; Deucher, Alexander <Alexander.Deucher@amd.com>; Yang, Stanley <Stanley.Yang@amd.com>; Li, Dennis <Dennis.Li@amd.com>; Zhou1, Tao <Tao.Zhou1@amd.com>; Clements, John <John.Clements@amd.com>
Subject: RE: [PATCH] drm/amdgpu: drop ras ta firmware loading for non-ras asic

[AMD Public Use]

We shall check ras ta firmware image size or/and ras ta binary start address to exclude ASICs that don't support ras.

Introduce asic type check here is unnecessary and the functional also need to be modified every time we add a new asic with ras capablility.

Kernel message that indicates ras ta, and other ta are optional one seems no harm to me. this is not limited to ras, but also hdcp/dtm.etc. If people have concern on this kind of messages, we can leverage amdgpu_ras_checked_support to only allow the message for ASICs that support RAS, although I don't think that is necessary.

Regards,
Hawking
-----Original Message-----
From: Chen, Guchun <Guchun.Chen@amd.com> 
Sent: Monday, January 4, 2021 12:58
To: amd-gfx@lists.freedesktop.org; Deucher, Alexander <Alexander.Deucher@amd.com>; Zhang, Hawking <Hawking.Zhang@amd.com>; Yang, Stanley <Stanley.Yang@amd.com>; Li, Dennis <Dennis.Li@amd.com>; Zhou1, Tao <Tao.Zhou1@amd.com>; Clements, John <John.Clements@amd.com>
Cc: Chen, Guchun <Guchun.Chen@amd.com>
Subject: [PATCH] drm/amdgpu: drop ras ta firmware loading for non-ras asic

Otherwise, below confused message is always printed during boot for asics without ras feature, but with common ta firmware.

amdgpu: RAS: optional ras ta ucode is not available

Signed-off-by: Guchun Chen <guchun.chen@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c |  5 +++--  drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c | 22 ++++++++++++----------  drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h |  2 ++
 3 files changed, 17 insertions(+), 12 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
index eb19ae734396..730bc1fe2036 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
@@ -1135,9 +1135,10 @@ static int psp_ras_initialize(struct psp_context *psp)
 	int ret;
 
 	/*
-	 * TODO: bypass the initialize in sriov for now
+	 * TODO: bypass the initialize in sriov and non-ras case
 	 */
-	if (amdgpu_sriov_vf(psp->adev))
+	if (amdgpu_sriov_vf(psp->adev) ||
+		!amdgpu_ras_check_enablement_by_asic(psp->adev))
 		return 0;
 
 	if (!psp->adev->psp.ta_ras_ucode_size || diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
index c136bd449744..41d97e56271e 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
@@ -1897,15 +1897,17 @@ int amdgpu_ras_request_reset_on_boot(struct amdgpu_device *adev,
 	return 0;
 }
 
-static int amdgpu_ras_check_asic_type(struct amdgpu_device *adev) -{
-	if (adev->asic_type != CHIP_VEGA10 &&
-		adev->asic_type != CHIP_VEGA20 &&
-		adev->asic_type != CHIP_ARCTURUS &&
-		adev->asic_type != CHIP_SIENNA_CICHLID)
-		return 1;
-	else
-		return 0;
+bool amdgpu_ras_check_enablement_by_asic(struct amdgpu_device *adev) {
+	switch (adev->asic_type) {
+	case CHIP_VEGA10:
+	case CHIP_VEGA20:
+	case CHIP_ARCTURUS:
+	case CHIP_SIENNA_CICHLID:
+		return true;
+	default:
+		return false;
+	}
 }
 
 /*
@@ -1924,7 +1926,7 @@ static void amdgpu_ras_check_supported(struct amdgpu_device *adev,
 	*supported = 0;
 
 	if (amdgpu_sriov_vf(adev) || !adev->is_atom_fw ||
-		amdgpu_ras_check_asic_type(adev))
+		!amdgpu_ras_check_enablement_by_asic(adev))
 		return;
 
 	if (amdgpu_atomfirmware_mem_ecc_supported(adev)) { diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h
index 762f5e46c007..06b5f9d14bea 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h
@@ -629,4 +629,6 @@ void amdgpu_ras_global_ras_isr(struct amdgpu_device *adev);  void amdgpu_ras_set_error_query_ready(struct amdgpu_device *adev, bool ready);
 
 bool amdgpu_ras_need_emergency_restart(struct amdgpu_device *adev);
+
+bool amdgpu_ras_check_enablement_by_asic(struct amdgpu_device *adev);
 #endif
--
2.17.1
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
