Return-Path: <SRS0=iwxs=L6=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D538EC07E96
	for <amd-gfx@archiver.kernel.org>; Tue,  6 Jul 2021 11:04:53 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 922EB61A33
	for <amd-gfx@archiver.kernel.org>; Tue,  6 Jul 2021 11:04:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 922EB61A33
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 384DB89F0B;
	Tue,  6 Jul 2021 11:04:53 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2073.outbound.protection.outlook.com [40.107.223.73])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5987C89F0B
 for <amd-gfx@lists.freedesktop.org>; Tue,  6 Jul 2021 11:04:51 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CE+uqvbTZv7Ee5VI//1IH2zpdhaJVB4W9SS62w+Q9bS7IfLDKlIB4HnmDBTl5+MEv92zJcCwpeiMRGajamaGEfjwStaXWLsDKuXNatWpZB78hnfXO/YpL2bNFbJFt/lJtijr/Iv2tqXHdlFiErXG9EU682xSxL/nbx4gXxeRCAH36LfWK1eDnN46UtbbBe8LCqLI5oe/aQfZ4EyjNBRnFHxeKAL9FeKMm/4tBGEnvTtDgzag1QzCZH0nH8hWC1ZIYzx7OKIrheFq1ztceQvk2TdgZhAKjX4lOkVjTVv00hCbUSjjR7IThDtMs6YHn17EupQs0SMZrxvku1JEL0H7TQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1eBSYF4lkDVCYi0+0Vg9EQmYJg/UPIA9GyHn/pTMNm4=;
 b=bGUNkK6pcQQcqnDHbu1m0GlpMaRr5V9yAWsnVcUpgKJxeHCs2YYxCIPoUnHHEBJV4q+qYWXlcqtixLT0LfHBye/NF/3IsoM+Xc7iaZ8NanJx6zU4rMTkoROgdNQa/iw9ccaFtuNHIkzPxB9ahxmVY7gotbziWYJqSnxSiLGkA+0RriAiSmGwXL+65UKwmAadSSbd4ji7lp8zhk3kCM40yIeaJykfdCBa8DapFQ33wDkHoZhJuU2c73I9gump4jAu08RWBWlFDqujyL0Vjq/6wgAa5x6FBY4swnoto4/PHaGrB0HhmqgdHrbKa6iaxR1M3i4EUAlzwoK7tfaF0m0ptg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1eBSYF4lkDVCYi0+0Vg9EQmYJg/UPIA9GyHn/pTMNm4=;
 b=iMRk4O5AC+fVqhfwXINhCIXZTsOUy5jaBbAjqJItJbJj3d0hZ6i9EVoKGqGgc05aZgo/R/L/uFIrwVzuxgl4/YQ2asn5HbV5M4aT/mciNAhQbAUtfFjI9b7DkeOFK1NU5dpQqLZ39bsccyOKm5hbFSJ5P42OmHNSGBUwcH8PWcA=
Received: from CH0PR12MB5348.namprd12.prod.outlook.com (2603:10b6:610:d7::9)
 by CH0PR12MB5281.namprd12.prod.outlook.com (2603:10b6:610:d4::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4287.32; Tue, 6 Jul
 2021 11:04:49 +0000
Received: from CH0PR12MB5348.namprd12.prod.outlook.com
 ([fe80::240c:be22:4f42:8068]) by CH0PR12MB5348.namprd12.prod.outlook.com
 ([fe80::240c:be22:4f42:8068%9]) with mapi id 15.20.4308.020; Tue, 6 Jul 2021
 11:04:49 +0000
From: "Lazar, Lijo" <Lijo.Lazar@amd.com>
To: "Quan, Evan" <Evan.Quan@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH V2 1/3] drm/amd/pm: new SmuMetrics data structure for
 Sienna Cichlid
Thread-Topic: [PATCH V2 1/3] drm/amd/pm: new SmuMetrics data structure for
 Sienna Cichlid
Thread-Index: AQHXcjKTJdoQluooyEeVFpMaNman96s1xeNQ
Date: Tue, 6 Jul 2021 11:04:49 +0000
Message-ID: <CH0PR12MB5348C0A552573F33671E132F971B9@CH0PR12MB5348.namprd12.prod.outlook.com>
References: <20210706064536.123524-1-evan.quan@amd.com>
In-Reply-To: <20210706064536.123524-1-evan.quan@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Enabled=true;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SetDate=2021-07-06T11:04:44Z; 
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Method=Privileged;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Name=Public-AIP 2.0;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ActionId=a7e6d939-6871-4789-9131-376ac8aa6281;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ContentBits=1
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 7dcc84a0-9416-4ef0-f1ac-08d9406ddf97
x-ms-traffictypediagnostic: CH0PR12MB5281:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <CH0PR12MB5281C51C337C7A6743A82B17971B9@CH0PR12MB5281.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:4125;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: iCwLQcUXfJmhlOSfLW67wnAtL/ZEQMXz46Y1hlegn4DfVcUQlK6JSyMazs+FwjEdNfJEQYbBGDadH/cZEV062tO81Sm4NsSnQtuk+myvkdxzacRPkbhe42rGGOgByN9JFs/YVmUscuIY+9AEzgw+lQGsfoPzp3JXUYqauwhVAGLdKs8v/QRVkqvJUHCZ2WWo8SZUbpco8tj4syWWBL67P5nsRCRRdd+JPQFs0Z27/oci1lMlGse7Elg5dWXpDlR6UqgZZEmQ5aEOZpCBAXfy8EEptZi/FEkLhA5VRMRHVgvkDa38bhHPQ/cOv8C3LDiTxdwzwHSm1GuCt8busc/gHeFgQu0F3zAZopD/XQUWhG75yc2F1A7+0A9CknNjrRQeJmTfVxZxAfZOgQ7VlvqM7+DqBytT4fLzTvHJ2fkcXDpVGpqgigsDPUhroh6GBB6hJx87jHhmC933OuQTWVe5o+OWj8YxsgRJdoAndgk+MoCDyLLXMOKLDo/zEUTG2j8RHgV8R3tXr/fqmr8A4AceJy5O5z3imXLfpjde2nuB16z3sIaAlv6wMO7MJxHZ7lhXAaVcMi53XXO5eLYaMy/rtCzxmpAJzy7U6SzKg/nNFl/vw/JUFmF2rLlo5PDcSQpgUHNj/0y6wUtSUuW6RwnpLQ==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH0PR12MB5348.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(39860400002)(396003)(366004)(346002)(376002)(136003)(122000001)(316002)(86362001)(8676002)(33656002)(83380400001)(26005)(71200400001)(6506007)(9686003)(38100700002)(55016002)(53546011)(186003)(478600001)(2906002)(52536014)(8936002)(66556008)(66476007)(5660300002)(66446008)(19627235002)(64756008)(110136005)(7696005)(76116006)(66946007)(4326008);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?qHEeGE21hhlGw3SqRhZ0f25SwNBkfxOef3DBkEmrY59txyXmuuj153ZaXNMk?=
 =?us-ascii?Q?dDGY1af/S4MnlRUlrH4BAofF9aghwGp1zCZx8cPE8dFH8wA7wWuLttkdPTE6?=
 =?us-ascii?Q?gsqg2G/WR9RwuTO3wLXNYkbAFAGf3Vg7pyN751GFHonf7xNaGDKhXoQ9XYfy?=
 =?us-ascii?Q?PlHIM+3pOSD2ABtT2pzfSv5DwSjIJCOJl5jU24yl4ZbMUFesjATxeDWU0dQC?=
 =?us-ascii?Q?GJ3d9C6TNJaSoSuA0rIY5yvZZE3w5JohKh5WF88OA7BptUpGkF3y4Xnky/2d?=
 =?us-ascii?Q?fnM1ZKsmWYtR1FasP2ThbspZzbTHeNeJhV5vwuoEUT+qKBJzi7oC2HMPWRXG?=
 =?us-ascii?Q?2g8CppCqq5rkibHNLeGkSFNWnnrMY7dLvBCrqmGmFkORbugUUq3d2EZ2kH9h?=
 =?us-ascii?Q?n4hEPgC+t5GPQ/Bviy8p0d2YOdYftvDeMoRdVpmDfKxjIitdARHd6df53Obj?=
 =?us-ascii?Q?VwUU6sghmDiBGeIZlW/dnJcNWNJM/3ACxNcE31cSc8Mn6SqhJG7JV8H77LHl?=
 =?us-ascii?Q?4imdvHy4EsC2PTSXErgfl/bB2q1FWFvP5VSxzoNQ5JNKlnelFUGduHfEzI9u?=
 =?us-ascii?Q?CdG3rMKunBjZA21c4NSrpgJBv9YGbaRC+ioTdiC+RKnnjuUbUlx/v7SSHT3M?=
 =?us-ascii?Q?AJP8Pe7F9xM5hNONKwTGKhzB4oreVG/dpKUmq/OglhQ68MeY+ZO3pyzLmGZk?=
 =?us-ascii?Q?KpV4IUlDZOu/VVZ7rZKBzGJ7dERVb78DvlNmIA3WOqQp3kzngffn6I46ZfKr?=
 =?us-ascii?Q?n2XDIYptOqxoY+bIbU0VQEdsYh2VbboDukgqQei2sgoA6sl8ygLBZs4dHdz2?=
 =?us-ascii?Q?H5iNwuiSLFDSkbgZyThaCa1OWN2dsCNUkS4ZJ2c4zT2yszEq7qfMxkcHps9z?=
 =?us-ascii?Q?1sBLMWHIvpS8a05Bx5T60nrpIGlCeyniuBYct/ofz0gZUIpIDzyjtfRgGyQk?=
 =?us-ascii?Q?NE7JdEFs8UTF7SVM2sQ26HIZpBam+j1n2rNp3iNfz8+gqBz0ayV4MlCRgx2V?=
 =?us-ascii?Q?Y50W5I/O5DQRj/nmzIdYmBAGYqeljpuDYLf3zyF36S4/bp+aVoGyPqbr92MN?=
 =?us-ascii?Q?ie8jrGbIsWo7g/Bg6vxnJi+QmWohf3jVjwHFfuC5P5HlNZCglDEiOo6VCfxt?=
 =?us-ascii?Q?4437zhhwJ72Jb9maV9gLBZ7/n0yfAotqtdoYo5TGBsFVruAWaCxRUfmtL0zY?=
 =?us-ascii?Q?x/TVf+ItJR1GQCSa5tYg5RHgxmnohabIyGwCNnlEmMjg7+oOjw6xkeO+8g1x?=
 =?us-ascii?Q?9aytRumhOBBmQ1BwtYqa5vTEux7e9rC2iIa13MybXTLNzZtHo55QWHaiR5rL?=
 =?us-ascii?Q?wCDzxcrCDgPwz6xZJyVPa979?=
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH0PR12MB5348.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7dcc84a0-9416-4ef0-f1ac-08d9406ddf97
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Jul 2021 11:04:49.4922 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: G7p8Rb7874ZF/s1N8zeqmwY8RabycNSfGZf6KeaaEOhl2GhXpxCQCAWhsvNKPDVw
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR12MB5281
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

[Public]

Series is 
	Reviewed-by: Lijo Lazar <lijo.lazar@amd.com>

-----Original Message-----
From: Quan, Evan <Evan.Quan@amd.com> 
Sent: Tuesday, July 6, 2021 12:16 PM
To: amd-gfx@lists.freedesktop.org
Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Lazar, Lijo <Lijo.Lazar@amd.com>; Quan, Evan <Evan.Quan@amd.com>
Subject: [PATCH V2 1/3] drm/amd/pm: new SmuMetrics data structure for Sienna Cichlid

Due to the structure layout change: "uint32_t ThrottlerStatus" -> "
uint8_t  ThrottlingPercentage[THROTTLER_COUNT]".

Change-Id: Ia62195857c5b377e8c95f76de0ec08e8674f04da
Signed-off-by: Evan Quan <evan.quan@amd.com>
---
 .../pm/inc/smu11_driver_if_sienna_cichlid.h   | 63 ++++++++++++++++++-
 1 file changed, 62 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/pm/inc/smu11_driver_if_sienna_cichlid.h b/drivers/gpu/drm/amd/pm/inc/smu11_driver_if_sienna_cichlid.h
index 61c87c39be80..0b916a1933df 100644
--- a/drivers/gpu/drm/amd/pm/inc/smu11_driver_if_sienna_cichlid.h
+++ b/drivers/gpu/drm/amd/pm/inc/smu11_driver_if_sienna_cichlid.h
@@ -211,6 +211,7 @@ typedef enum {
 #define THROTTLER_FIT_BIT          17
 #define THROTTLER_PPM_BIT          18
 #define THROTTLER_APCC_BIT         19
+#define THROTTLER_COUNT            20
 
 // FW DState Features Control Bits
 // FW DState Features Control Bits
@@ -1406,7 +1407,67 @@ typedef struct {
 } SmuMetrics_t;
 
 typedef struct {
-  SmuMetrics_t SmuMetrics;
+  uint32_t CurrClock[PPCLK_COUNT];
+
+  uint16_t AverageGfxclkFrequencyPreDs;  uint16_t 
+ AverageGfxclkFrequencyPostDs;  uint16_t AverageFclkFrequencyPreDs;  
+ uint16_t AverageFclkFrequencyPostDs;  uint16_t 
+ AverageUclkFrequencyPreDs  ;  uint16_t AverageUclkFrequencyPostDs  ;
+
+
+  uint16_t AverageGfxActivity    ;
+  uint16_t AverageUclkActivity   ;
+  uint8_t  CurrSocVoltageOffset  ;
+  uint8_t  CurrGfxVoltageOffset  ;
+  uint8_t  CurrMemVidOffset      ;
+  uint8_t  Padding8        ;
+  uint16_t AverageSocketPower    ;
+  uint16_t TemperatureEdge       ;
+  uint16_t TemperatureHotspot    ;
+  uint16_t TemperatureMem        ;
+  uint16_t TemperatureVrGfx      ;
+  uint16_t TemperatureVrMem0     ;
+  uint16_t TemperatureVrMem1     ;
+  uint16_t TemperatureVrSoc      ;
+  uint16_t TemperatureLiquid0    ;
+  uint16_t TemperatureLiquid1    ;
+  uint16_t TemperaturePlx        ;
+  uint16_t Padding16             ;
+  uint32_t AccCnt                ;
+  uint8_t  ThrottlingPercentage[THROTTLER_COUNT];
+
+
+  uint8_t  LinkDpmLevel;
+  uint8_t  CurrFanPwm;
+  uint16_t CurrFanSpeed;
+
+  //BACO metrics, PMFW-1721
+  //metrics for D3hot entry/exit and driver ARM msgs  uint8_t 
+ D3HotEntryCountPerMode[D3HOT_SEQUENCE_COUNT];
+  uint8_t D3HotExitCountPerMode[D3HOT_SEQUENCE_COUNT];
+  uint8_t ArmMsgReceivedCountPerMode[D3HOT_SEQUENCE_COUNT];
+
+  //PMFW-4362
+  uint32_t EnergyAccumulator;
+  uint16_t AverageVclk0Frequency  ;
+  uint16_t AverageDclk0Frequency  ;
+  uint16_t AverageVclk1Frequency  ;
+  uint16_t AverageDclk1Frequency  ;
+  uint16_t VcnActivityPercentage  ; //place holder, David N. to provide full sequence
+  uint8_t  PcieRate               ;
+  uint8_t  PcieWidth              ;
+  uint16_t AverageGfxclkFrequencyTarget;  uint16_t Padding16_2;
+
+} SmuMetrics_V2_t;
+
+typedef struct {
+  union {
+    SmuMetrics_t SmuMetrics;
+    SmuMetrics_V2_t SmuMetrics_V2;
+  };
   uint32_t Spare[1];
 
   // Padding - ignore
--
2.29.0
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
