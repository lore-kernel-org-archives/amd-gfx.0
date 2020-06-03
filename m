Return-Path: <SRS0=8ysN=7Q=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD143C433E0
	for <amd-gfx@archiver.kernel.org>; Wed,  3 Jun 2020 05:32:34 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AEF162065C
	for <amd-gfx@archiver.kernel.org>; Wed,  3 Jun 2020 05:32:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="pWG0kbQR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AEF162065C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 243056E235;
	Wed,  3 Jun 2020 05:32:33 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2068.outbound.protection.outlook.com [40.107.94.68])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 772A66E235
 for <amd-gfx@lists.freedesktop.org>; Wed,  3 Jun 2020 05:32:32 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PFNsmC5MPQCg8fCv777UGWHiILdoxEAgF/WPyuddPI4c/r0YN9U/UOIVKo8LaFzohpjogy0aMq5OpAL/rUwatnsBaTD/xcpiqJkyfVFhyBzJhZ+5tGK8AnsM4/u2LIkV3d/MqkpY+cNst9BOl+5DkLvCqqyPi2YEgKk4UGHIVonEEwxRTkMrQQaT80ysnQUjsgA9MD8i392//S6f4CEw3AZ+UBS/yipuVbdg/YHpmtdR7EPYqhRFfDuR91i8lM5ele+ky22tG0D767VobGIgpPGhVbvtiPJj5D53CPs59Lc+XVPxQ3pr5UgsQi2rOXq7FjvtWJkkKo+10BXX0Ckizw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1YpaSavDnGUrfI4KzOjlROnDcgJL5p3XubQgElMHymU=;
 b=POhlheT7ST+UdVZKuiuxQ92UpyB+UkdkUoRkzG9VO+PbK0kfr8LJGJfeoonNdZE17V9brmWLRBYH2at8H+q7q7N7Q1PMY0XuHv5rueVmA78+0/sHvqmcFVYLz46EJhqbjUffYQtjzpXuro3gQrGXtN+vtdWWQ84YpbbHJZ+r1BwTbriycrf9ffvbxlYJ5r22xZllutYlAbspCSAquvV2PhRAGwaANyZH0jhtMXFeU09liM2LiEEE4FTHYFnEJx6Wys5QJPLjWNLlCNJ1UaCQHnBTpmaiaNpYm+l3tp/cpvNA7x1yXZybHT/y2kzic2aUcZJtCscH3Rq3aN41leA3nQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1YpaSavDnGUrfI4KzOjlROnDcgJL5p3XubQgElMHymU=;
 b=pWG0kbQRqt+LXRgvwnlLhJ4Jne+PoW6oXemKj5mZANLBavLp8AkmBV/Ny37d7vkQr/tIyVS7fDZs6X0Ra1ygSrSFdtXbmUT4zhRg56fmi/CBSxZoe+FIoZw9BShoyubhQHwKlAcZePN04GuJBBaI2KoeSLslDByoga4wI7+/JeE=
Received: from MN2PR12MB4175.namprd12.prod.outlook.com (2603:10b6:208:1d3::13)
 by MN2PR12MB2989.namprd12.prod.outlook.com (2603:10b6:208:c4::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3045.18; Wed, 3 Jun
 2020 05:32:31 +0000
Received: from MN2PR12MB4175.namprd12.prod.outlook.com
 ([fe80::4cbc:93e:87ac:2fc1]) by MN2PR12MB4175.namprd12.prod.outlook.com
 ([fe80::4cbc:93e:87ac:2fc1%5]) with mapi id 15.20.3066.018; Wed, 3 Jun 2020
 05:32:30 +0000
From: "Feng, Kenneth" <Kenneth.Feng@amd.com>
To: "Gao, Likun" <Likun.Gao@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amd/powerplay: update driver if file for
 sienna_cichlid
Thread-Topic: [PATCH] drm/amd/powerplay: update driver if file for
 sienna_cichlid
Thread-Index: AQHWOWCI8D3ZqvEHVk6B/qjUrbY2+qjGXdKA
Date: Wed, 3 Jun 2020 05:32:30 +0000
Message-ID: <MN2PR12MB4175EF86FC45D758BED23B5C8E880@MN2PR12MB4175.namprd12.prod.outlook.com>
References: <20200603043546.3330085-1-likun.gao@amd.com>
In-Reply-To: <20200603043546.3330085-1-likun.gao@amd.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Enabled=true;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SetDate=2020-06-03T05:31:58Z; 
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Method=Standard;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Name=Internal Use Only -
 Unrestricted;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ActionId=189a719c-621c-4763-9296-00009e838429;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ContentBits=1
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_enabled: true
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_setdate: 2020-06-03T05:31:58Z
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_method: Standard
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_name: Internal Use Only -
 Unrestricted
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_actionid: c87bd7a4-6586-4379-9953-00006721b576
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_contentbits: 0
msip_justification: I confirm the recipients are approved for sharing this
 content
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [58.247.170.242]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: b977002b-4418-4c31-c8a0-08d8077f82c6
x-ms-traffictypediagnostic: MN2PR12MB2989:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MN2PR12MB2989A32D7F38408B95615FD58E880@MN2PR12MB2989.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:5236;
x-forefront-prvs: 04238CD941
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 6bElB0789N6vxxGZ+80p8w7GAwSNnZJ4ceAmLxOAcGLWF8JR48Pqh2SGlpkCF5GxggPR5V+9am45tB70H4Ur/eeBqzM+5mpLs3fZlYXlijNLA/didq0ozbJp5nOsTMR1T9S0rKEVOP6m4J9kJc1BN1SCd/AMv9inX5g4K7LtMu+x9AaRGTUIdd9eR/Mb8cp5SQwIKOrrBQzLqUxFzK0jEzOlTsHsm5VW/jvTxLt/Ot95iyHAo45qM3RJIUXkIqvu5W9kfCqDxZAh++xxJI6f6TmYtrSxaICdwD5GohmNso+Y19Hfql1UtroJpjPC4ShO
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB4175.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(376002)(366004)(396003)(346002)(39860400002)(136003)(64756008)(6506007)(52536014)(66476007)(66556008)(26005)(66446008)(9686003)(33656002)(86362001)(55016002)(66946007)(19627235002)(83380400001)(2906002)(186003)(76116006)(5660300002)(15650500001)(53546011)(8936002)(71200400001)(316002)(4326008)(478600001)(7696005)(110136005)(8676002);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: r1Zx4C2Tpt5oHdHxx1wVEmNHqsHuh/EmGJDqaBUojXFBxe0JvSzmUADmfdsLSQ4qBwVuRQ3J74yVT+SVC1qbT2f6Kqe8ApZ5+2svOFsrIZr7XDAEtM1dptRMe6MdzQc80107U+s7U5nggMWk3NDpt+4AW9NBWXir5cyAwO2QtFjN7xXHzUHXTts3FpraU24RqAQHDUW/LjOxlLnPWWHgz5LBsFbpYYEsE+3hHClvEULb7Uj3v42AqK6ByLB4kWQs5okKCokT0ynlWQgHjvcYx+7YIT8YvpFZE7M1RblVl0kWNioz8q4s1PVax/rtBfa2N33s5tOgT9KVvHxamnV06pU6JPJulIl8K+Or/UPxqq+RTT8rphefW17qU0jq40n/BBcDKBsC1kkgwLCAxGdvDBgEplyzgWhRPPBYhN9aTOo7Vc+BdBK0IcZuFSvybeljkemGT3KJKTxgRcYxor17Wb109sAaRFMK8ZrA7rFsibJ19tTtxZGFqJk0TH++UuLs
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b977002b-4418-4c31-c8a0-08d8077f82c6
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Jun 2020 05:32:30.7489 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: GqESZ+NvohaDJiZLfpLCIdnHfIaT+qpqbjssfrG4dDnbwpzyZnuo+JemYPtwkx1V
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB2989
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
Cc: "Quan, Evan" <Evan.Quan@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Official Use Only - Internal Distribution Only]

Reviewed-by: Kenneth Feng <kenneth.feng@amd.com>


Best Regards
Kenneth

-----Original Message-----
From: Gao, Likun <Likun.Gao@amd.com> 
Sent: Wednesday, June 3, 2020 12:36 PM
To: amd-gfx@lists.freedesktop.org
Cc: Feng, Kenneth <Kenneth.Feng@amd.com>; Quan, Evan <Evan.Quan@amd.com>; Gao, Likun <Likun.Gao@amd.com>
Subject: [PATCH] drm/amd/powerplay: update driver if file for sienna_cichlid

From: Likun Gao <Likun.Gao@amd.com>

Update sienna_cichlid driver if header file to match pptable changes.

Signed-off-by: Likun Gao <Likun.Gao@amd.com>
Change-Id: Ie0652935d512124c03f16ae75c44e134567ef5da
---
 .../inc/smu11_driver_if_sienna_cichlid.h        | 17 ++++++++++++++---
 drivers/gpu/drm/amd/powerplay/inc/smu_v11_0.h   |  2 +-
 2 files changed, 15 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/powerplay/inc/smu11_driver_if_sienna_cichlid.h b/drivers/gpu/drm/amd/powerplay/inc/smu11_driver_if_sienna_cichlid.h
index bdffba1f0086..5322f6da3071 100644
--- a/drivers/gpu/drm/amd/powerplay/inc/smu11_driver_if_sienna_cichlid.h
+++ b/drivers/gpu/drm/amd/powerplay/inc/smu11_driver_if_sienna_cichlid.h
@@ -27,7 +27,7 @@
 // *** IMPORTANT ***
 // SMU TEAM: Always increment the interface version if  // any structure is changed in this file -#define SMU11_DRIVER_IF_VERSION 0x30
+#define SMU11_DRIVER_IF_VERSION 0x31
 
 #define PPTABLE_Sienna_Cichlid_SMU_VERSION 4
 
@@ -914,12 +914,14 @@ typedef struct {
   uint16_t     GfxActivityLpfTau;
   uint16_t     UclkActivityLpfTau;
   uint16_t     SocketPowerLpfTau;  
+  uint16_t     VcnClkAverageLpfTau;
+  uint16_t     padding16; 
 } DriverSmuConfig_t;
 
 typedef struct {
   DriverSmuConfig_t DriverSmuConfig;
 
-  uint32_t     Spare[8];  
+  uint32_t     Spare[7];  
   // Padding - ignore
   uint32_t     MmHubPadding[8]; // SMU internal use
 } DriverSmuConfigExternal_t;
@@ -984,11 +986,20 @@ typedef struct {
   uint8_t D3HotEntryCountPerMode[D3HOT_SEQUENCE_COUNT];
   uint8_t D3HotExitCountPerMode[D3HOT_SEQUENCE_COUNT];
   uint8_t ArmMsgReceivedCountPerMode[D3HOT_SEQUENCE_COUNT];
+
+  //PMFW-4362
+  uint32_t EnergyAccumulator;
+  uint16_t AverageVclk0Frequency  ;
+  uint16_t AverageDclk0Frequency  ;
+  uint16_t AverageVclk1Frequency  ;
+  uint16_t AverageDclk1Frequency  ;
+  uint16_t VcnActivityPercentage ; //place holder, David N. to provide 
+ full sequence  uint16_t padding16_2;
 } SmuMetrics_t;
 
 typedef struct {
   SmuMetrics_t SmuMetrics;
-  uint32_t Spare[5];
+  uint32_t Spare[1];
 
   // Padding - ignore
   uint32_t     MmHubPadding[8]; // SMU internal use  
diff --git a/drivers/gpu/drm/amd/powerplay/inc/smu_v11_0.h b/drivers/gpu/drm/amd/powerplay/inc/smu_v11_0.h
index 4ad3f07891fe..282eb45e7b86 100644
--- a/drivers/gpu/drm/amd/powerplay/inc/smu_v11_0.h
+++ b/drivers/gpu/drm/amd/powerplay/inc/smu_v11_0.h
@@ -31,7 +31,7 @@
 #define SMU11_DRIVER_IF_VERSION_NV10 0x36  #define SMU11_DRIVER_IF_VERSION_NV12 0x33  #define SMU11_DRIVER_IF_VERSION_NV14 0x36 -#define SMU11_DRIVER_IF_VERSION_Sienna_Cichlid 0x30
+#define SMU11_DRIVER_IF_VERSION_Sienna_Cichlid 0x31
 
 /* MP Apertures */
 #define MP0_Public			0x03800000
--
2.25.1
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
