Return-Path: <SRS0=8Fgq=FS=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D1DBC4361B
	for <amd-gfx@archiver.kernel.org>; Mon, 14 Dec 2020 14:04:17 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CC95820757
	for <amd-gfx@archiver.kernel.org>; Mon, 14 Dec 2020 14:04:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CC95820757
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 33DF06E20A;
	Mon, 14 Dec 2020 14:04:16 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2042.outbound.protection.outlook.com [40.107.93.42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 578C76E20A
 for <amd-gfx@lists.freedesktop.org>; Mon, 14 Dec 2020 14:04:14 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hIZIN0qNF02XPpNgwwYZuOREsiizX/2c8SKfGOnuF7ZbNGnPWpXSDXxbTGMA7q2F4IHDKznbHpH6PHLJw3G3RmZS13sjtwtuN9URHSzVrv/EIRa8fKEvrRKOPMzAJshcYK0e3Ivj1dN10bM298K1+S9GGpEvH2VUV6aBhvx/3bZldUYF9WexnykV/3rnUdZRyS7iq1mkxtwvm/Pdew6wHqc4Mutd7ypzGw2G/SzFbR2gWWuR8VCLogq9+xl/t/DCHXGgi6KAbn2vqScuTaFGAv2hgRwOCfejeZpa7oLdcxOixj3Dt6Q7EAJgo/oxJoCPcjr7pf25vuFuL+1sypET3Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ExdBPCs2PP26+K1h9+G5+5Uufj+m9j6+puK/QL7bfws=;
 b=ko1RdA2WyIS/qbOQMWeulENK5Se+HxXdUgFUzxNAoQx55f6jM5sn10OuMQ6XhgkHISpV/utgNoSDY4+c2KfdMml0B1B3Rcwm0OEwSTg29sPhV5iSVA7rthuIXrsQC0EYnw5krlD3HGATZn2Clw7ramO8qBLL5XlSdj4Yz7a0cc69ey86tXI0EvTsN5rIb9oQxeUdUGEztbqe2nKkQgWalhdQGXTgLrWszlsLAfdWq7I1aBgV9CKZc733QPPzyzApss5ztQbVsSJPQssjNmEWnz5fu9TCpRBGCDjPiRwOyjDdhqZk2CdjxOOPb0yRreJdMuCvQ7ZOiWoWn9w9Lj0R6A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ExdBPCs2PP26+K1h9+G5+5Uufj+m9j6+puK/QL7bfws=;
 b=bmnMY3JAk+hzOMKaAl3NsRq+hXPXrGfhwttP5guYnCUKHO0m5dEXdvhF2TRQhZXszjYsoYtkoYJsMWPi+OP5hBoSFrzh+XE6CGDsSyl3rkCXWnu1QTs5WOF4z56ALVTTPcYM1YrsWkU4gg/RygxfHQzskCaZrz7gysi1q7T7mBM=
Received: from CY4PR12MB1287.namprd12.prod.outlook.com (2603:10b6:903:40::8)
 by CY4PR1201MB0118.namprd12.prod.outlook.com (2603:10b6:910:20::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3654.21; Mon, 14 Dec
 2020 14:04:12 +0000
Received: from CY4PR12MB1287.namprd12.prod.outlook.com
 ([fe80::bc0f:dd2:ef80:de2]) by CY4PR12MB1287.namprd12.prod.outlook.com
 ([fe80::bc0f:dd2:ef80:de2%12]) with mapi id 15.20.3654.025; Mon, 14 Dec 2020
 14:04:12 +0000
From: "Chen, Guchun" <Guchun.Chen@amd.com>
To: "Yang, Stanley" <Stanley.Yang@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>, "Jian, Jane" <Jane.Jian@amd.com>
Subject: RE: [PATCH V2 1/1] drm/amdgpu: skip load smu and sdma microcode on
 sriov for SIENNA_CICHLID
Thread-Topic: [PATCH V2 1/1] drm/amdgpu: skip load smu and sdma microcode on
 sriov for SIENNA_CICHLID
Thread-Index: AQHW0gTYYu8ujvKM5UacG7W+KMtepKn2n9hA
Date: Mon, 14 Dec 2020 14:04:12 +0000
Message-ID: <CY4PR12MB1287E5716AFD9BE6E28F07ECF1C70@CY4PR12MB1287.namprd12.prod.outlook.com>
References: <20201214103519.20030-1-Stanley.Yang@amd.com>
In-Reply-To: <20201214103519.20030-1-Stanley.Yang@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Enabled=true;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_SetDate=2020-12-14T14:03:50Z; 
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Method=Privileged;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Name=Public_0;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_ActionId=a3e0ff12-17e2-4f2f-8627-000084f6e6df;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_ContentBits=1
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_enabled: true
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_setdate: 2020-12-14T14:04:05Z
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_method: Privileged
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_name: Public_0
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_actionid: 6f128dfb-a905-4a63-bf39-00001d5144cb
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_contentbits: 0
dlp-product: dlpe-windows
dlp-version: 11.5.0.60
dlp-reaction: no-action
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [114.92.157.236]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 2159bc8d-ba29-409b-9226-08d8a0392257
x-ms-traffictypediagnostic: CY4PR1201MB0118:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <CY4PR1201MB0118A26D3C37D9E06FBECC0BF1C70@CY4PR1201MB0118.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:3276;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: nbL0SrAUIqNg96vMhpMye0x2YLVd5Ww9hOACODJiXY7+eRv74y/qUs5tl216LuiOVSQtVxTJqtTpsWNw2HO4VAWfWnEHSZyQvOGPM76I9LzLdb9r3bUwZOMjkW/RKlj2iFj+vgI5SYk49ERbmDVVWJzL+QGs4s0QiqAbhzl7KfoXm1KnHTs6Y5E3tmrF13g6Q3+lkvLz6eyHLcuu04xiov8NMXeso9Rs+vw97gOnB0i8uVB9i4FQrwf3l1N4N2os1MSTPhnZVoc9BjlGsr9b/Kql5wPf81tsVdCm3eZ5GPp2YO8oiO1DCZIOGAPmp+K0t+2/+wo9sSP+mdtU+UISdjyTqMFy61KJ3ZOlsxnbDqM=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CY4PR12MB1287.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(346002)(376002)(136003)(366004)(8676002)(45080400002)(5660300002)(26005)(508600001)(186003)(2906002)(6506007)(9686003)(110136005)(966005)(55016002)(53546011)(7696005)(71200400001)(86362001)(6636002)(4326008)(66556008)(33656002)(83380400001)(8936002)(66476007)(52536014)(76116006)(66946007)(66446008)(64756008);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?INQkqVB4ABIcHkysapiVa3/q9te+GTHaQHHGlR+oW8m2FgWF+gJ4K6Wi2sCD?=
 =?us-ascii?Q?/BNWkZvATwialHGffydHYu9c3mas3A+L4el74LED64GSXBCUiEvi9TebNkz9?=
 =?us-ascii?Q?/s33iGbn0B+gEf8eHKOcSe1u7EDlbYlgubBKF35jGFXIsAE3h5OLGi9UwBKV?=
 =?us-ascii?Q?+LposF7FxvykKn7lTXFb9Qr8Ymjj0t5QrvafLGx2/ID9qFHe3sgWSdbnWssJ?=
 =?us-ascii?Q?VWdJLfdrHVX1EjND05GgOkzHRdcjqy4EwbjaDRtwmN7IsNyJZtys7X3j5ioe?=
 =?us-ascii?Q?6WBNxrYxNF4gAhB7oiFz9ym2lgLj+V/eYp+5WcuQudsqCwu4lH+brC94ldgg?=
 =?us-ascii?Q?qPmFV+GqbgADNgy50OOcFIjm0/CxQHIEZa1gmnUBIa5mFwD41/hGRKYwTNZm?=
 =?us-ascii?Q?373BMSjEOsf3/2CPUfDynJRDFSVYmsqhED8drfhf6K0zfggiaEtFBe4TTw3R?=
 =?us-ascii?Q?FSwzF5h1FYahzO6x0MFPaFCos6bjkDuu8+VSX/E0BEW1ihxtIFGO08hLB2W+?=
 =?us-ascii?Q?ioTdBSxV08IebOiukztvkl65kd1MxYWKet3StK9dgGXN4KbqeDZeBwGrMEQe?=
 =?us-ascii?Q?IyYu3mPeS1yOGflxqSfmmLV/eos7GQ8rdocQkiPLGyKVbZa3CCJGXrvGd8JE?=
 =?us-ascii?Q?vXNwwCwXWVh3CLIxT/5lQWeLmckNHTWkCun2kklVnHdtEY4+8mQzY/VlkGH2?=
 =?us-ascii?Q?X8A4qBKtZdCUeGFQAIaIRcMDZnewof40NEAuKkXDzLgCRO4bTU34483gNud/?=
 =?us-ascii?Q?Qs4PwwKCSFvBI6QLNzAT/ZNS0+2M5yPgqjKk97e1SKIragMCOCMhIxFh7+rZ?=
 =?us-ascii?Q?ouLDokiU35gHtJI0aesh7NjR0QFAzrhty2lHQRQnw3eoErcn/Qn6BtF6W9de?=
 =?us-ascii?Q?TttVEri1V24s/w5BDOYwAa2d+rGfvfdiV868zL5T9MZ5cEkjrfvhT2OKd4hD?=
 =?us-ascii?Q?UCnH51FOJ43XFz/BYTzsQtitM057NgLb0AjVgG5HUDo=3D?=
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY4PR12MB1287.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2159bc8d-ba29-409b-9226-08d8a0392257
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Dec 2020 14:04:12.1500 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: V/hOt71V9MBxY0zNizzKuLnDZnt5Ro9R3GUpMq8oiz5H/BUiutnWN8k8GVElIHFxk1i1oiJ1OxdCJsZzYd6IMg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR1201MB0118
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

Reviewed-by: Guchun Chen <guchun.chen@amd.com>

Regards,
Guchun

-----Original Message-----
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Stanley.Yang
Sent: Monday, December 14, 2020 6:35 PM
To: amd-gfx@lists.freedesktop.org; Jian, Jane <Jane.Jian@amd.com>
Cc: Yang, Stanley <Stanley.Yang@amd.com>
Subject: [PATCH V2 1/1] drm/amdgpu: skip load smu and sdma microcode on sriov for SIENNA_CICHLID

skip load smu and sdma fw on sriov due to sos, ta and asd fw have been skipped for SIENNA_CICHLID.

V2:
    move asic check into smu11

Signed-off-by: Stanley.Yang <Stanley.Yang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c         |  3 +++
 drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c      | 10 ++++------
 drivers/gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c |  5 +++++
 3 files changed, 12 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c b/drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c
index 39e17aae655f..87566dee048d 100644
--- a/drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c
+++ b/drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c
@@ -153,6 +153,9 @@ static int sdma_v5_2_init_microcode(struct amdgpu_device *adev)
 	struct amdgpu_firmware_info *info = NULL;
 	const struct common_firmware_header *header = NULL;
 
+	if (amdgpu_sriov_vf(adev) && (adev->asic_type == CHIP_SIENNA_CICHLID))
+		return 0;
+
 	DRM_DEBUG("\n");
 
 	switch (adev->asic_type) {
diff --git a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
index cf999b7a2164..8b867a6d52b5 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
@@ -847,12 +847,10 @@ static int smu_sw_init(void *handle)
 	smu->smu_dpm.dpm_level = AMD_DPM_FORCED_LEVEL_AUTO;
 	smu->smu_dpm.requested_dpm_level = AMD_DPM_FORCED_LEVEL_AUTO;
 
-	if (!amdgpu_sriov_vf(adev) || (adev->asic_type != CHIP_NAVI12)) {
-		ret = smu_init_microcode(smu);
-		if (ret) {
-			dev_err(adev->dev, "Failed to load smu firmware!\n");
-			return ret;
-		}
+	ret = smu_init_microcode(smu);
+	if (ret) {
+		dev_err(adev->dev, "Failed to load smu firmware!\n");
+		return ret;
 	}
 
 	ret = smu_smc_table_sw_init(smu);
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c b/drivers/gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c
index 624065d3c079..c3c181975c9d 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c
@@ -91,6 +91,11 @@ int smu_v11_0_init_microcode(struct smu_context *smu)
 	const struct common_firmware_header *header;
 	struct amdgpu_firmware_info *ucode = NULL;
 
+	if (amdgpu_sriov_vf(adev) &&
+			((adev->asic_type == CHIP_NAVI12) ||
+			 (adev->asic_type == CHIP_SIENNA_CICHLID)))
+		return 0;
+
 	switch (adev->asic_type) {
 	case CHIP_ARCTURUS:
 		chip_name = "arcturus";
--
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Flists.freedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;data=04%7C01%7Cguchun.chen%40amd.com%7C170ed7c1105e4f1e9ff208d8a01bf99f%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637435389305874015%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C1000&amp;sdata=QFTPPWPl7ZluqKDLvzwLLrPa6bPNJ7OF86YMaMs0ObE%3D&amp;reserved=0
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
