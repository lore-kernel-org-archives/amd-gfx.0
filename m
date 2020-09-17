Return-Path: <SRS0=QzDn=C2=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UPPERCASE_50_75,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11C37C43461
	for <amd-gfx@archiver.kernel.org>; Thu, 17 Sep 2020 05:27:40 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8884D206C3
	for <amd-gfx@archiver.kernel.org>; Thu, 17 Sep 2020 05:27:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="utx3TiGM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8884D206C3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1D02C6E0C5;
	Thu, 17 Sep 2020 05:27:39 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2088.outbound.protection.outlook.com [40.107.94.88])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CCE6C6E0C5
 for <amd-gfx@lists.freedesktop.org>; Thu, 17 Sep 2020 05:27:37 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Jul4u8U4IYM4tAH2orbOx6upA4dtI7lSGp+3ruQv8KbZ5EIsQm360VaZbtV3L2PirkBGaraFlm0YN4pG78PV38OLhu1Z+CzTKHN1G3LoSaar/t+nDZU+1NEphkFdqAdHBzCTDQ6dZSDp131buSrlQguaisKYmpbv051MNX0QCBw57RyJX/wmiADJrwLkDBD/3VFuaq2501ktjietKOW3oAMdB7WYrumDV6IDL6h1OfUlvSFpvpvB34vt9FY3Qt5btTtFNQv2rWW8dyJsBFvUEuzU101fiKXONizfoyqSam9pWwGiriIdo87gdXHzNkaHnAsVg0rKSQWDRYBG33m8xQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NigfjjCqMgQOqn67g1/ycOxaoEgJljeco4VSaida46s=;
 b=DPPq2syqtxAOZrMtKTi8SzmZP5GK370zBnX6EnV9bAQIMn/GKkZxi6dz2dSMS+Zpb68penJ67LgDNNSj3d1NUhrFT+owHj0xuqZzh3LOzqzDidoH0lkykjf+rZuBuMmCNdqoy1CW/CWetrpsWknloPiC09wfE1cnVH23mcAgrsekRKozV/PyYRYUpfQuUYCo5mXjVrCbvg2boAhQtrpgy4khbZhIk89hh0FrGJ6ncrEQmGgI16QlikA5qpggEWO5wnRVBoKnwTAvgTxZVO2b5mYx+53a7cHpn7t6INz142YKtqVYUgK6qcv89zD67brKKwrm6iLGPrAz0k+FoHmLLA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NigfjjCqMgQOqn67g1/ycOxaoEgJljeco4VSaida46s=;
 b=utx3TiGMdnzd8jMY3b/IiEqPBj9tsBbGrga0VhFk8/aXi+2fzDXFI0CSw7Jqg/wZVfj0hcv02at2QWom90ADB53muPV4KcsmzHIDqS1vN2szaBP+SawdzQ1rzQQlco/nN7k67rUzL96oZmdjgXpT8XGzM0fGv1mdKjQGctwehKs=
Received: from DM6PR12MB4075.namprd12.prod.outlook.com (2603:10b6:5:21d::8) by
 DM5PR12MB1707.namprd12.prod.outlook.com (2603:10b6:3:108::21) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3391.14; Thu, 17 Sep 2020 05:27:36 +0000
Received: from DM6PR12MB4075.namprd12.prod.outlook.com
 ([fe80::b51c:2b0e:7e1:b233]) by DM6PR12MB4075.namprd12.prod.outlook.com
 ([fe80::b51c:2b0e:7e1:b233%9]) with mapi id 15.20.3391.014; Thu, 17 Sep 2020
 05:27:36 +0000
From: "Zhang, Hawking" <Hawking.Zhang@amd.com>
To: Alex Deucher <alexdeucher@gmail.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH 2/4] drm/amdgpu: add VCN 3.0 AV1 registers
Thread-Topic: [PATCH 2/4] drm/amdgpu: add VCN 3.0 AV1 registers
Thread-Index: AQHWi41xGbVMp/ix6Ea+axute5QdmalsTy1w
Date: Thu, 17 Sep 2020 05:27:36 +0000
Message-ID: <DM6PR12MB4075546F0A349680F9872FA2FC3E0@DM6PR12MB4075.namprd12.prod.outlook.com>
References: <20200915182409.68727-1-alexander.deucher@amd.com>
 <20200915182409.68727-2-alexander.deucher@amd.com>
In-Reply-To: <20200915182409.68727-2-alexander.deucher@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Enabled=true;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_SetDate=2020-09-17T05:27:32Z; 
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Method=Privileged;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Name=Public_0;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_ActionId=c4e302c1-b0c3-468d-b3fe-0000bfc36ccd;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_ContentBits=1
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_enabled: true
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_setdate: 2020-09-17T05:27:28Z
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_method: Standard
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_name: Internal Use Only -
 Unrestricted
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_actionid: a8a14a57-470c-4b52-8a85-00003e33f752
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_contentbits: 0
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_enabled: true
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_setdate: 2020-09-17T05:27:33Z
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_method: Privileged
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_name: Public_0
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_actionid: 9889efcd-9082-4243-8e63-00006a2a9362
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_contentbits: 0
authentication-results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [58.247.170.242]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: e7fb530a-4673-45b8-6851-08d85aca6305
x-ms-traffictypediagnostic: DM5PR12MB1707:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM5PR12MB1707A4D67FC6B81207FF6164FC3E0@DM5PR12MB1707.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:626;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: +CxtFTFyiChZzBx4msPIfZ++8SkPasA6bc13E82EwGvXi7y1HCghp/tf5bmaeUXxOtuovllzy/mFv/+W/xfS6/OZpc7qWQhiVp/IMi/K+WxCzGttCWiOgG5zjkYuPsjTulYKmMZkdTRWoPE2CPBs2XyphwV/cUdkpCxwEHdjD8JrjfzFd3UydXJpIToUICJzfN/YfnPOo4LvIXb0smT7p+DHSz41LNecPObXsje/Zl53Z9SBmUtY38ipbQfYX5bpYAzGgJdj+Zrb6NyiiFTXu1WwSSpY4hI1peoX8oJhSxgt8yUG8jJjCtYkJ47UGAKzoSPIAk9BlvU0AL/j9JVyXMjE9bmyzizPXAo/ITqtK5ytdhiRk87zUP7iKj2XkGcX+DqsEB8VQJdybqjXLvfs7DpytACO2nq/ybnMsvyDdDM=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB4075.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(396003)(39860400002)(346002)(136003)(376002)(366004)(966005)(55016002)(4326008)(52536014)(110136005)(33656002)(9686003)(7696005)(53546011)(2906002)(6506007)(5660300002)(64756008)(66946007)(66446008)(66556008)(66476007)(76116006)(71200400001)(45080400002)(86362001)(186003)(26005)(8676002)(8936002)(83380400001)(478600001)(316002);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: wCV4RdjLpgTyHlf4HOohdQst+OKCGjIWo4aWOtQMx8MSVvmBBVrRE+IgdriQCrDgTiZcg02szT6jih9kmwXqmBlOT74YYL423mnxTLFwPyZ9vl71dorOjMks1HEddMN0xz1tq4C4TNWwVnlXpZY9WNu4XkX8PL7DL6hy/uNLsFzfUlUb8Q9eP7fsy4TMgjvo5BmSgoc2ClYoKKOiuwv8FW6LZcK9npWZj9rZXvHI6D+GtOOKBZih7XKgEEHdk1hZF3FdhL9UEjWOTi1HarBDYlrSzAwPbGQMgGMMDN3dH2nqFJ/H8Bok602LTCcuowK4NFIJLaPV50EoKVJdkK6PYbWni9NTOHSyxAxKyYsQwAZWfT66424kcY6uz4EFMVBZsirepbvZQmbwUH/9XC3/CsnyQyHbjNojj11LYTF8yrnSXcyEoXPOCrxBApHffRLprEOM550FQnRr67abW+htFExJ8bxMTNn7bJaeWkAmjIonDf7ol19ACg2STZyRXmZotZzRrsGE+i3dPSYiVe2B7txMLdbm/tn6qeDIfGYQNqqvTQjUhBNyHsN9jkD6N3cEZSXGTZyYV5TpQfARJXfvAEA6Q2x4k4SKYPE/BYF0FOwkDfycgK/2HzUXIJK/w/Apw0lubEBe7OOZz9mIzUS4Fw==
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4075.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e7fb530a-4673-45b8-6851-08d85aca6305
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Sep 2020 05:27:36.3102 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: TH14HnWXI8dgzdPudEkkbIcMo+v1zkC6GrHSwpMJwAI9oSA0IWxIlYGsZz+Fjf5Vkjk1+b5TkG7O6fjIKRbt+w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1707
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
Sent: Wednesday, September 16, 2020 02:24
To: amd-gfx@lists.freedesktop.org
Cc: Deucher, Alexander <Alexander.Deucher@amd.com>
Subject: [PATCH 2/4] drm/amdgpu: add VCN 3.0 AV1 registers

This adds the AV1 registers.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 .../include/asic_reg/vcn/vcn_3_0_0_sh_mask.h  | 34 +++++++++++++++++++
 1 file changed, 34 insertions(+)

diff --git a/drivers/gpu/drm/amd/include/asic_reg/vcn/vcn_3_0_0_sh_mask.h b/drivers/gpu/drm/amd/include/asic_reg/vcn/vcn_3_0_0_sh_mask.h
index c0efd90808f2..58cf7adb9d54 100644
--- a/drivers/gpu/drm/amd/include/asic_reg/vcn/vcn_3_0_0_sh_mask.h
+++ b/drivers/gpu/drm/amd/include/asic_reg/vcn/vcn_3_0_0_sh_mask.h
@@ -2393,6 +2393,7 @@
 #define VCN_FEATURES__HAS_MJPEG2_IDCT_DEC__SHIFT                                                              0x7
 #define VCN_FEATURES__HAS_SCLR_DEC__SHIFT                                                                     0x8
 #define VCN_FEATURES__HAS_VP9_DEC__SHIFT                                                                      0x9
+#define VCN_FEATURES__HAS_AV1_DEC__SHIFT                                                                      0xa
 #define VCN_FEATURES__HAS_EFC_ENC__SHIFT                                                                      0xb
 #define VCN_FEATURES__HAS_EFC_HDR2SDR_ENC__SHIFT                                                              0xc
 #define VCN_FEATURES__HAS_DUAL_MJPEG_DEC__SHIFT                                                               0xd
@@ -2407,6 +2408,7 @@
 #define VCN_FEATURES__HAS_MJPEG2_IDCT_DEC_MASK                                                                0x00000080L
 #define VCN_FEATURES__HAS_SCLR_DEC_MASK                                                                       0x00000100L
 #define VCN_FEATURES__HAS_VP9_DEC_MASK                                                                        0x00000200L
+#define VCN_FEATURES__HAS_AV1_DEC_MASK                                                                        0x00000400L
 #define VCN_FEATURES__HAS_EFC_ENC_MASK                                                                        0x00000800L
 #define VCN_FEATURES__HAS_EFC_HDR2SDR_ENC_MASK                                                                0x00001000L
 #define VCN_FEATURES__HAS_DUAL_MJPEG_DEC_MASK                                                                 0x00002000L
@@ -2809,8 +2811,10 @@
 #define UVD_SUVD_CGC_GATE__IME_HEVC__SHIFT                                                                    0x18
 #define UVD_SUVD_CGC_GATE__EFC__SHIFT                                                                         0x19
 #define UVD_SUVD_CGC_GATE__SAOE__SHIFT                                                                        0x1a
+#define UVD_SUVD_CGC_GATE__SRE_AV1__SHIFT                                                                     0x1b
 #define UVD_SUVD_CGC_GATE__FBC_PCLK__SHIFT                                                                    0x1c
 #define UVD_SUVD_CGC_GATE__FBC_CCLK__SHIFT                                                                    0x1d
+#define UVD_SUVD_CGC_GATE__SCM_AV1__SHIFT                                                                     0x1e
 #define UVD_SUVD_CGC_GATE__SMPA__SHIFT                                                                        0x1f
 #define UVD_SUVD_CGC_GATE__SRE_MASK                                                                           0x00000001L
 #define UVD_SUVD_CGC_GATE__SIT_MASK                                                                           0x00000002L
@@ -2839,8 +2843,10 @@
 #define UVD_SUVD_CGC_GATE__IME_HEVC_MASK                                                                      0x01000000L
 #define UVD_SUVD_CGC_GATE__EFC_MASK                                                                           0x02000000L
 #define UVD_SUVD_CGC_GATE__SAOE_MASK                                                                          0x04000000L
+#define UVD_SUVD_CGC_GATE__SRE_AV1_MASK                                                                       0x08000000L
 #define UVD_SUVD_CGC_GATE__FBC_PCLK_MASK                                                                      0x10000000L
 #define UVD_SUVD_CGC_GATE__FBC_CCLK_MASK                                                                      0x20000000L
+#define UVD_SUVD_CGC_GATE__SCM_AV1_MASK                                                                       0x40000000L
 #define UVD_SUVD_CGC_GATE__SMPA_MASK                                                                          0x80000000L
 //UVD_SUVD_CGC_STATUS
 #define UVD_SUVD_CGC_STATUS__SRE_VCLK__SHIFT                                                                  0x0
@@ -2873,6 +2879,8 @@
 #define UVD_SUVD_CGC_STATUS__IME_HEVC_DCLK__SHIFT                                                             0x1b
 #define UVD_SUVD_CGC_STATUS__EFC_DCLK__SHIFT                                                                  0x1c
 #define UVD_SUVD_CGC_STATUS__SAOE_DCLK__SHIFT                                                                 0x1d
+#define UVD_SUVD_CGC_STATUS__SRE_AV1_VCLK__SHIFT                                                              0x1e
+#define UVD_SUVD_CGC_STATUS__SCM_AV1_DCLK__SHIFT                                                              0x1f
 #define UVD_SUVD_CGC_STATUS__SRE_VCLK_MASK                                                                    0x00000001L
 #define UVD_SUVD_CGC_STATUS__SRE_DCLK_MASK                                                                    0x00000002L
 #define UVD_SUVD_CGC_STATUS__SIT_DCLK_MASK                                                                    0x00000004L
@@ -2903,6 +2911,8 @@
 #define UVD_SUVD_CGC_STATUS__IME_HEVC_DCLK_MASK                                                               0x08000000L
 #define UVD_SUVD_CGC_STATUS__EFC_DCLK_MASK                                                                    0x10000000L
 #define UVD_SUVD_CGC_STATUS__SAOE_DCLK_MASK                                                                   0x20000000L
+#define UVD_SUVD_CGC_STATUS__SRE_AV1_VCLK_MASK                                                                0x40000000L
+#define UVD_SUVD_CGC_STATUS__SCM_AV1_DCLK_MASK                                                                0x80000000L
 //UVD_SUVD_CGC_CTRL
 #define UVD_SUVD_CGC_CTRL__SRE_MODE__SHIFT                                                                    0x0
 #define UVD_SUVD_CGC_CTRL__SIT_MODE__SHIFT                                                                    0x1
@@ -2919,6 +2929,8 @@
 #define UVD_SUVD_CGC_CTRL__SMPA_MODE__SHIFT                                                                   0xc
 #define UVD_SUVD_CGC_CTRL__MPBE0_MODE__SHIFT                                                                  0xd
 #define UVD_SUVD_CGC_CTRL__MPBE1_MODE__SHIFT                                                                  0xe
+#define UVD_SUVD_CGC_CTRL__SIT_AV1_MODE__SHIFT                                                                0xf
+#define UVD_SUVD_CGC_CTRL__SDB_AV1_MODE__SHIFT                                                                0x10
 #define UVD_SUVD_CGC_CTRL__MPC1_MODE__SHIFT                                                                   0x11
 #define UVD_SUVD_CGC_CTRL__FBC_PCLK__SHIFT                                                                    0x1c
 #define UVD_SUVD_CGC_CTRL__FBC_CCLK__SHIFT                                                                    0x1d
@@ -2937,6 +2949,8 @@
 #define UVD_SUVD_CGC_CTRL__SMPA_MODE_MASK                                                                     0x00001000L
 #define UVD_SUVD_CGC_CTRL__MPBE0_MODE_MASK                                                                    0x00002000L
 #define UVD_SUVD_CGC_CTRL__MPBE1_MODE_MASK                                                                    0x00004000L
+#define UVD_SUVD_CGC_CTRL__SIT_AV1_MODE_MASK                                                                  0x00008000L
+#define UVD_SUVD_CGC_CTRL__SDB_AV1_MODE_MASK                                                                  0x00010000L
 #define UVD_SUVD_CGC_CTRL__MPC1_MODE_MASK                                                                     0x00020000L
 #define UVD_SUVD_CGC_CTRL__FBC_PCLK_MASK                                                                      0x10000000L
 #define UVD_SUVD_CGC_CTRL__FBC_CCLK_MASK                                                                      0x20000000L
@@ -3658,6 +3672,8 @@
 #define UVD_SUVD_CGC_STATUS2__SMPA_VCLK__SHIFT                                                                0x0
 #define UVD_SUVD_CGC_STATUS2__SMPA_DCLK__SHIFT                                                                0x1
 #define UVD_SUVD_CGC_STATUS2__MPBE1_DCLK__SHIFT                                                               0x3
+#define UVD_SUVD_CGC_STATUS2__SIT_AV1_DCLK__SHIFT                                                             0x4
+#define UVD_SUVD_CGC_STATUS2__SDB_AV1_DCLK__SHIFT                                                             0x5
 #define UVD_SUVD_CGC_STATUS2__MPC1_DCLK__SHIFT                                                                0x6
 #define UVD_SUVD_CGC_STATUS2__MPC1_SCLK__SHIFT                                                                0x7
 #define UVD_SUVD_CGC_STATUS2__MPC1_VCLK__SHIFT                                                                0x8
@@ -3666,6 +3682,8 @@
 #define UVD_SUVD_CGC_STATUS2__SMPA_VCLK_MASK                                                                  0x00000001L
 #define UVD_SUVD_CGC_STATUS2__SMPA_DCLK_MASK                                                                  0x00000002L
 #define UVD_SUVD_CGC_STATUS2__MPBE1_DCLK_MASK                                                                 0x00000008L
+#define UVD_SUVD_CGC_STATUS2__SIT_AV1_DCLK_MASK                                                               0x00000010L
+#define UVD_SUVD_CGC_STATUS2__SDB_AV1_DCLK_MASK                                                               0x00000020L
 #define UVD_SUVD_CGC_STATUS2__MPC1_DCLK_MASK                                                                  0x00000040L
 #define UVD_SUVD_CGC_STATUS2__MPC1_SCLK_MASK                                                                  0x00000080L
 #define UVD_SUVD_CGC_STATUS2__MPC1_VCLK_MASK                                                                  0x00000100L
@@ -3674,25 +3692,41 @@
 //UVD_SUVD_CGC_GATE2
 #define UVD_SUVD_CGC_GATE2__MPBE0__SHIFT                                                                      0x0
 #define UVD_SUVD_CGC_GATE2__MPBE1__SHIFT                                                                      0x1
+#define UVD_SUVD_CGC_GATE2__SIT_AV1__SHIFT                                                                    0x2
+#define UVD_SUVD_CGC_GATE2__SDB_AV1__SHIFT                                                                    0x3
 #define UVD_SUVD_CGC_GATE2__MPC1__SHIFT                                                                       0x4
 #define UVD_SUVD_CGC_GATE2__MPBE0_MASK                                                                        0x00000001L
 #define UVD_SUVD_CGC_GATE2__MPBE1_MASK                                                                        0x00000002L
+#define UVD_SUVD_CGC_GATE2__SIT_AV1_MASK                                                                      0x00000004L
+#define UVD_SUVD_CGC_GATE2__SDB_AV1_MASK                                                                      0x00000008L
 #define UVD_SUVD_CGC_GATE2__MPC1_MASK                                                                         0x00000010L
 //UVD_SUVD_INT_STATUS2
 #define UVD_SUVD_INT_STATUS2__SMPA_FUNC_INT__SHIFT                                                            0x0
 #define UVD_SUVD_INT_STATUS2__SMPA_ERR_INT__SHIFT                                                             0x5
+#define UVD_SUVD_INT_STATUS2__SDB_AV1_FUNC_INT__SHIFT                                                         0x6
+#define UVD_SUVD_INT_STATUS2__SDB_AV1_ERR_INT__SHIFT                                                          0xb
 #define UVD_SUVD_INT_STATUS2__SMPA_FUNC_INT_MASK                                                              0x0000001FL
 #define UVD_SUVD_INT_STATUS2__SMPA_ERR_INT_MASK                                                               0x00000020L
+#define UVD_SUVD_INT_STATUS2__SDB_AV1_FUNC_INT_MASK                                                           0x000007C0L
+#define UVD_SUVD_INT_STATUS2__SDB_AV1_ERR_INT_MASK                                                            0x00000800L
 //UVD_SUVD_INT_EN2
 #define UVD_SUVD_INT_EN2__SMPA_FUNC_INT_EN__SHIFT                                                             0x0
 #define UVD_SUVD_INT_EN2__SMPA_ERR_INT_EN__SHIFT                                                              0x5
+#define UVD_SUVD_INT_EN2__SDB_AV1_FUNC_INT_EN__SHIFT                                                          0x6
+#define UVD_SUVD_INT_EN2__SDB_AV1_ERR_INT_EN__SHIFT                                                           0xb
 #define UVD_SUVD_INT_EN2__SMPA_FUNC_INT_EN_MASK                                                               0x0000001FL
 #define UVD_SUVD_INT_EN2__SMPA_ERR_INT_EN_MASK                                                                0x00000020L
+#define UVD_SUVD_INT_EN2__SDB_AV1_FUNC_INT_EN_MASK                                                            0x000007C0L
+#define UVD_SUVD_INT_EN2__SDB_AV1_ERR_INT_EN_MASK                                                             0x00000800L
 //UVD_SUVD_INT_ACK2
 #define UVD_SUVD_INT_ACK2__SMPA_FUNC_INT_ACK__SHIFT                                                           0x0
 #define UVD_SUVD_INT_ACK2__SMPA_ERR_INT_ACK__SHIFT                                                            0x5
+#define UVD_SUVD_INT_ACK2__SDB_AV1_FUNC_INT_ACK__SHIFT                                                        0x6
+#define UVD_SUVD_INT_ACK2__SDB_AV1_ERR_INT_ACK__SHIFT                                                         0xb
 #define UVD_SUVD_INT_ACK2__SMPA_FUNC_INT_ACK_MASK                                                             0x0000001FL
 #define UVD_SUVD_INT_ACK2__SMPA_ERR_INT_ACK_MASK                                                              0x00000020L
+#define UVD_SUVD_INT_ACK2__SDB_AV1_FUNC_INT_ACK_MASK                                                          0x000007C0L
+#define UVD_SUVD_INT_ACK2__SDB_AV1_ERR_INT_ACK_MASK                                                           0x00000800L
 
 
 // addressBlock: uvd0_ecpudec
-- 
2.25.4

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Flists.freedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;data=02%7C01%7Chawking.zhang%40amd.com%7C9b1e38eea65d4b2560aa08d859a4923c%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637357910650084416&amp;sdata=fYvSnGArSMzAItsM2PKNNwfQCu5gqvKW48VaeLuSbis%3D&amp;reserved=0
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
