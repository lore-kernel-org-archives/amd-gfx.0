Return-Path: <SRS0=8n1M=EW=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6EBDC4742C
	for <amd-gfx@archiver.kernel.org>; Mon, 16 Nov 2020 15:17:32 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6E8BF2137B
	for <amd-gfx@archiver.kernel.org>; Mon, 16 Nov 2020 15:17:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="OaZVmbOD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6E8BF2137B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2A5B689DA7;
	Mon, 16 Nov 2020 15:17:32 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2052.outbound.protection.outlook.com [40.107.220.52])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5019189DA7
 for <amd-gfx@lists.freedesktop.org>; Mon, 16 Nov 2020 15:17:31 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XeyvOWnvVaEM42DoImFNpf+zTrmKwTcy262ELtbDDUhluq8G+6DXIC5ToSZQ3pu1NxaoSA1VKvjZTT2YaYli4ZnMOv7FcewZoyAg6KNXjQvcD2B3UeelbP6fvxmrsp1E7VWKXMXbEq53da0nOtsFn7fOEr55+l7VWmOVLVEsa7JQDUa3d3a4bmNMowkg93mrOvZGCC26KiIqkT8f7XI9mPpFQsZ26g5xukLK86sCeEikZWc/shl0y9zLbgeohdOjWidkf4eygxjGV6I0l0wti1zgDCtUuW2K1iP0a0ccwTeEOnmig9xNNxqeIsyxLbqCnbPq9DG7rtzSZPLHfUhk0w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VLD5KVhhEJslOmo4UoKIVrfsj/SYhtwuB1/5QQb1fYA=;
 b=nCBGK/OMzNvwh9fYWvq0Z9IYFwx8hWwdcEBTVnL7iaRPQ24/pHKxKoxQSsIQf7hEUezSIqADivbbOQoVvT0UrTkdMx/Q/Jy99822+iJfC68Jq7MLXRsb6pVYa/NaMrm/z+ZiMDg2U1kXMg4C5+Ej7oe60+jHlhtW3Ev/3J0THvT+4Wj/mUk1tcjaX0nb/laDoC62a6Y3xRcu0yZbkudEe7A73Yo23/JgkxlmS96vnz1gps53TM1rcvAdKa/zLpajK37F0qDD8WGUuVBw8sARPMUcBTv4/ngp/ldiwwO6D8Nr2IG7e5FAC65sKLa3P31bDfnBYebX3VyGnGDVAsQHaA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VLD5KVhhEJslOmo4UoKIVrfsj/SYhtwuB1/5QQb1fYA=;
 b=OaZVmbODeNrltIzseEA/9ezdXwLTMTAsqubSEsIGRDZ0ihOS0rUHxXgpDGd4L/sMxKCC/XF4bB6c3JStEvQEUf8ENISHNICTjzAT/eAnBWQU71aJa0UvZYL7J+GaG4U8ovTVhUaOHOFCPy7UryJbqpEWfxdCvZ5NF3WbYSXV6IU=
Received: from DM6PR12MB4075.namprd12.prod.outlook.com (2603:10b6:5:21d::8) by
 DM5PR12MB2357.namprd12.prod.outlook.com (2603:10b6:4:b7::14) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3564.25; Mon, 16 Nov 2020 15:17:26 +0000
Received: from DM6PR12MB4075.namprd12.prod.outlook.com
 ([fe80::214c:5fb0:3572:853d]) by DM6PR12MB4075.namprd12.prod.outlook.com
 ([fe80::214c:5fb0:3572:853d%8]) with mapi id 15.20.3564.028; Mon, 16 Nov 2020
 15:17:26 +0000
From: "Zhang, Hawking" <Hawking.Zhang@amd.com>
To: Alex Deucher <alexdeucher@gmail.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amdgpu: remove experimental flag from arcturus
Thread-Topic: [PATCH] drm/amdgpu: remove experimental flag from arcturus
Thread-Index: AQHWvCrRXb8cGXtxQUixvvrayI+VUanK3rSA
Date: Mon, 16 Nov 2020 15:17:26 +0000
Message-ID: <DM6PR12MB4075B62AF4F293E5AC7A2B24FCE30@DM6PR12MB4075.namprd12.prod.outlook.com>
References: <20201116151138.1532420-1-alexander.deucher@amd.com>
In-Reply-To: <20201116151138.1532420-1-alexander.deucher@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Enabled=true;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_SetDate=2020-11-16T15:17:22Z; 
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Method=Privileged;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Name=Public_0;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_ActionId=59075a37-3f20-4a1a-9324-0000dbcefed3;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_ContentBits=1
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_enabled: true
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_setdate: 2020-11-16T15:17:16Z
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_method: Standard
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_name: Internal Use Only -
 Unrestricted
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_actionid: 012cefbb-85e5-425e-abe8-0000e6d80c24
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_contentbits: 0
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_enabled: true
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_setdate: 2020-11-16T15:17:23Z
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_method: Privileged
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_name: Public_0
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_actionid: 49175d71-acc1-4790-b4db-0000a1df5c62
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_contentbits: 0
authentication-results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [58.247.170.242]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 31873034-9a95-4e36-aee6-08d88a42b9f3
x-ms-traffictypediagnostic: DM5PR12MB2357:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM5PR12MB2357FC2A494FDBE0694B67D9FCE30@DM5PR12MB2357.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:327;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: grflc1O2IZHcgFQTXyfIQs7v+FJEDZqEN4+AbbAJqaXfZd4Ap8DHKCBKO+/YJ3wW9LHjh2XTCwM3Xqc9NE8yDllSkTPCzRxgnITTnB7Nl90Nm4eKaOHRuNbhwnIm8jroWvvDsvngSEJ98Pgwcs6ZdgbTipHuF667lWof9tplk+Y/oSw0yBSQ3d4l2FWB3p34tRK8PWOM3q/w/2V/t6vIbDDlAcjKXj938OP3sphqB5ydEUg3IVb6p8CJhWreQW2x0qc5+muBLghlSKNPd+LklT9DQUj8Zz+fzoXnuTIq47h2ifmKfFKXPZ1gxIdhUFL30o5Z3ZIZSZn5J9vAwpxd8BFnD6utQX5x3Ccacr2Di2s=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB4075.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(396003)(136003)(346002)(366004)(39860400002)(376002)(66556008)(110136005)(316002)(7696005)(6506007)(66476007)(66946007)(66446008)(76116006)(64756008)(478600001)(186003)(4326008)(26005)(45080400002)(53546011)(966005)(5660300002)(52536014)(83380400001)(8676002)(8936002)(33656002)(9686003)(55016002)(86362001)(71200400001)(2906002);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: lA8sHZi2O92aOR1dBs7n4ATunSkFB7e+4VcTjohBn9Xv1FhSCBGciLdH9zWsElCPCT3xolN43feWJaaJGykCaRJtcyoIr5obmYjzJeoJhPdEOuYWN5s349ivukOXYrSY9Qi3VcC0upsoa9QiLCbJ3bG9UgGtMwp7aq0yKYnSyouAcuv2/OwzAcfiwsW0P/CWWEWc0VqdA89o0AdIFir0Z1P7Q21IDSn63+63f5s1L9mnjIUFDB3HVAD5nNO2vXI22ZxW96A+RXhx2h0p4QP7Z67jVCQMAkQCWL1whE7Gr9ktV9x80DWXceRVKtQesq8eo+UAWGXhK88XwAFl6lDpUHQXkeuwqvRcebDWvsOeO6TfnYZcYUk2asNOgTGVZLIVLeOHw2WjykeIxZVibTiTY1t+XlQIPaYWyjSK88hxLfTuB/9+QwyuJtDGkevNsxPZ7z/Pw5hUZGkNs5HusU6/8eb9INFFUFtGfDipAiuqEzw0dwas7rvC6FT+LGpoiSRchypqtng45/bEkQqXSQBtcdtNkfW758iPxJaJ33oCup+dmXJDiaRZk+Ypm64cuIXEhfQchFxzmciF1If+1BCEAcJ5tmupKWxDzyaWcDTkn9S88mWoOWy1jGyFpchTSZBdzCLPDVNdl5CrisAtF1fuJMFunoTZ07KyumPZL21cHCev2a6dFt3cV/Z+pBASCALUvlkLoQwoiDf6Y2I4R2YQuwDVA0NhTrl4IwYstzA50vmAsL5l2zk7AN3w7OcRu1Te++IBt3nnrFkx8e6vg08s0rP9x7txmJjmVB0fSeoyCh0hELA/M0V5cK//bWc48UsWL4+R9B2uMBOgK9CRyFU082cd9UPf1YfyAt7Ch21afITM4e1s5hCWZ1IDAu8wXklws7k4RTND5Vdudd6V5i3EPQ==
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4075.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 31873034-9a95-4e36-aee6-08d88a42b9f3
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Nov 2020 15:17:26.3740 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 1/89+da20hT8+QmAPGGNCsq+vtHQDiqhrLZzvMnIgMZdeWtakzrmerUhGEusbQ0BwZQFqW7pt73CA3ZXDrmcrw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB2357
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
Sent: Monday, November 16, 2020 23:12
To: amd-gfx@lists.freedesktop.org
Cc: Deucher, Alexander <Alexander.Deucher@amd.com>
Subject: [PATCH] drm/amdgpu: remove experimental flag from arcturus

This has been stable for a while.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
index 26cf369003e1..4825b33f83ed 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
@@ -1063,10 +1063,10 @@ static const struct pci_device_id pciidlist[] = {
 	{0x1002, 0x15dd, PCI_ANY_ID, PCI_ANY_ID, 0, 0, CHIP_RAVEN|AMD_IS_APU},
 	{0x1002, 0x15d8, PCI_ANY_ID, PCI_ANY_ID, 0, 0, CHIP_RAVEN|AMD_IS_APU},
 	/* Arcturus */
-	{0x1002, 0x738C, PCI_ANY_ID, PCI_ANY_ID, 0, 0, CHIP_ARCTURUS|AMD_EXP_HW_SUPPORT},
-	{0x1002, 0x7388, PCI_ANY_ID, PCI_ANY_ID, 0, 0, CHIP_ARCTURUS|AMD_EXP_HW_SUPPORT},
-	{0x1002, 0x738E, PCI_ANY_ID, PCI_ANY_ID, 0, 0, CHIP_ARCTURUS|AMD_EXP_HW_SUPPORT},
-	{0x1002, 0x7390, PCI_ANY_ID, PCI_ANY_ID, 0, 0, CHIP_ARCTURUS|AMD_EXP_HW_SUPPORT},
+	{0x1002, 0x738C, PCI_ANY_ID, PCI_ANY_ID, 0, 0, CHIP_ARCTURUS},
+	{0x1002, 0x7388, PCI_ANY_ID, PCI_ANY_ID, 0, 0, CHIP_ARCTURUS},
+	{0x1002, 0x738E, PCI_ANY_ID, PCI_ANY_ID, 0, 0, CHIP_ARCTURUS},
+	{0x1002, 0x7390, PCI_ANY_ID, PCI_ANY_ID, 0, 0, CHIP_ARCTURUS},
 	/* Navi10 */
 	{0x1002, 0x7310, PCI_ANY_ID, PCI_ANY_ID, 0, 0, CHIP_NAVI10},
 	{0x1002, 0x7312, PCI_ANY_ID, PCI_ANY_ID, 0, 0, CHIP_NAVI10},
-- 
2.25.4

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Flists.freedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;data=04%7C01%7Chawking.zhang%40amd.com%7C64fc6aa66adf4194be4a08d88a41f1e3%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637411363133433306%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C1000&amp;sdata=H31yESbTEU27QSsiC228iqbn9uDStOOb2eM0nE72%2FDg%3D&amp;reserved=0
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
