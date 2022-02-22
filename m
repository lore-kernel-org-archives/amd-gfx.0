Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 43AF0C433EF
	for <amd-gfx@archiver.kernel.org>; Tue, 22 Feb 2022 14:59:42 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BB1F510E7C2;
	Tue, 22 Feb 2022 14:59:41 +0000 (UTC)
Received: from NAM04-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam08on2065.outbound.protection.outlook.com [40.107.100.65])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D842310E701
 for <amd-gfx@lists.freedesktop.org>; Tue, 22 Feb 2022 14:59:40 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RNJ4IKz36GBVbYSTGLTyccfSMk9H7n7EynaNzlZkLmOe+jULhpkmXa/DaX5aecY9rb8I5DF0Bw+TouNqbfS7086mo2mF3ebOSUjxrRqn/7N/hVJN37qSKZ7BfPTn55HOH0lXlnTxHoCBL1qKLY4by51vi6dvXaLQQQR3PpnqvLXI/4zDyZsyoUBgLUjLICxHtg4KstC1TFQNd4dN1aL0tEexUPxmf4Do4DJER6T+IeblQSy1BWCSQK29sboPhwpGLxcf5U8aStC8Bhf+wnGCB+WDq5dSNuSG4VSOEWONFYZ3QLgIJ3uGLaqHkSxR7yIRzSKnpaAOJWI2A0KFfv2X9Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=u+T5fx1G0Lr5cftEim/BzOQIRsSQVTs7DbZFJkdEl+M=;
 b=UMrzSPlTji7t67FSaC4W8BKlosiILK5xGADd9o7+OI2nAEWS+WIrqvAqAKC2fFAsGvfvP2WUyEYrVYuvdoHUmVqxtTZTlZ82b+P3T/dK4ExranmTKolRqBA1RWNBKvAvja8fq4MSNj8PDZ6HKB8F7nU1QUIosRJJWO9A/Qtutym+boE7BH0pilJsKih2W1obSqYc7Brs+9z5nbXpQmQUYuwAqz1tJ2r2hZ+XjbTH/PC9tDlgVy7DxmZi5ABWxggZyCbtr2kj0IuSVwB75H/3ZoiESYwh2YRdB/8weRNOjr2Hl6w2ZqoIsib5xQJMWYpDGNIjSkXB1MrhgyQP0JsQ8w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=u+T5fx1G0Lr5cftEim/BzOQIRsSQVTs7DbZFJkdEl+M=;
 b=ARJIh+q4gnvrsNR5ZHk3twvRiF5DUclSznwbOEt+SmjxM8s8zwdZ17HvAYXb4y8g4OUXyM9lq0Mqk/XgO4aBUQFS8J25+1SpGM2Xm+LnXmBk0VBoKMBob1nhm0L1NXZFhKFSmqIUJDI5i+tPTcw/wquStCDu7GiB+5zFsFclNnc=
Received: from DM5PR12MB1323.namprd12.prod.outlook.com (2603:10b6:3:75::12) by
 DM6PR12MB3673.namprd12.prod.outlook.com (2603:10b6:5:1c5::11) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4995.24; Tue, 22 Feb 2022 14:59:38 +0000
Received: from DM5PR12MB1323.namprd12.prod.outlook.com
 ([fe80::39af:792f:29e6:f69f]) by DM5PR12MB1323.namprd12.prod.outlook.com
 ([fe80::39af:792f:29e6:f69f%5]) with mapi id 15.20.4995.027; Tue, 22 Feb 2022
 14:59:38 +0000
From: "Kasiviswanathan, Harish" <Harish.Kasiviswanathan@amd.com>
To: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Chen, Xiaogang"
 <Xiaogang.Chen@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amdgpu: config HDP_MISC_CNTL.READ_BUFFER_WATERMARK to
 fix applications running across multiple GPU config hang.
Thread-Topic: [PATCH] drm/amdgpu: config HDP_MISC_CNTL.READ_BUFFER_WATERMARK
 to fix applications running across multiple GPU config hang.
Thread-Index: AQHYJ3eiV7AJS6d9f0CbBCoQHApZdKyfmIqAgAARc2A=
Date: Tue, 22 Feb 2022 14:59:38 +0000
Message-ID: <DM5PR12MB132300A9BF764789D61B7B308C3B9@DM5PR12MB1323.namprd12.prod.outlook.com>
References: <20220221230531.1246382-1-xiaogang.chen@amd.com>
 <BL1PR12MB5144EC79690EEC4A9CF258C5F73B9@BL1PR12MB5144.namprd12.prod.outlook.com>
In-Reply-To: <BL1PR12MB5144EC79690EEC4A9CF258C5F73B9@BL1PR12MB5144.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Enabled=true;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SetDate=2022-02-22T14:59:36Z; 
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Method=Privileged;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Name=Public-AIP 2.0;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ContentBits=1
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_enabled: true
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_setdate: 2022-02-22T14:59:35Z
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_method: Privileged
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_name: Public-AIP 2.0
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_actionid: ddca961b-eb07-4072-9727-5724c45cf2e7
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_contentbits: 0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 23f7a370-80cf-4f69-fdfc-08d9f613f27a
x-ms-traffictypediagnostic: DM6PR12MB3673:EE_
x-microsoft-antispam-prvs: <DM6PR12MB36739C9DF2B5E4B77B180D218C3B9@DM6PR12MB3673.namprd12.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: HOvCi7aUvVZ+NOUruKgQpSevWd37T1HJHg7pJZ3UxuylDk4cNzHfoqj3Pr6KnCdHBa0ZAOLvMojZ8Jedo7DzFHFwbM9sRslIuYoz8eKzuCqFanNXUtpcOEX4Oj9OyHdtjNhffwYHBuphkboRkTk9U4jVJZPFFdFKffD+uOZ1n85JYVg4/QttK30DLwBuUpVevHrvcpmSpHlPhajTiUgjHW+9zJO55uo0fGl/zupOBYkNWEzD41i37Tvqlb6eZQvtHdpLTRMrjkfBc6mCgXXlpMvEbCfFF8wwvzp0nNUNzLzzLa0l+bKgXO8N0bN7WdizrzUNR+Tfd+UWTYcO/GZZ+yJrCKp9Z5no//6Qmyr9+gdETcfZPqdPTBnNMsWbJcox7uQXLdO/LkWFDJXzQK2JldZHaxC2kysENhVp3eDAO4Qivxcvxd0VrX1yVqZ7kuVCK7+Gwdo8uZTi2pcrfTUleY9metpj2shJNXJdhF9tYTB6r3YfpQR1qcJoLhWfYC3jqaICAp8pPHOtA77fD13JtIBIUoBN1L59ycK18Bsu4adCS0THI9YXzrebmQsqFmatf3b7n1qkHNOhHJxJ5P7k5H2EtXsvSaMc0tnEqPFcdrLE11vkBQIwMdhu6bQ/btC4fE+r8esVbjmRn9TDFxLtjUAlNVAqKqTvvVU0aIXEg2P8usm6ZXJ+AiV2vdsUFh4tsf3Qv1dN6O00hTL5ymquUA==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM5PR12MB1323.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(4636009)(366004)(110136005)(64756008)(66946007)(26005)(8936002)(66476007)(66556008)(186003)(52536014)(5660300002)(83380400001)(76116006)(86362001)(66446008)(8676002)(122000001)(316002)(7696005)(38070700005)(33656002)(71200400001)(6506007)(2906002)(38100700002)(508600001)(55016003)(53546011)(9686003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?s2Ui+b8Fm5MgUefbtqb12dRnjJrOE3+6tCFwt1TROOe1STvj3AUlv9cXQTSC?=
 =?us-ascii?Q?aIg978cUgML38LOADv8tCFMBHv5Yka90UIEUlg1V1CdrTuHSoUamsDqVZvEX?=
 =?us-ascii?Q?p+eCHS4v7rboKwpgdcKb+NF1a25Ml0EfzmYiBuxjJW62JHBHSZJBm0HzFpEI?=
 =?us-ascii?Q?FgrqHFIqLfvbKALIfZBByVCck1b7D7xGSGtIAcmt3iiJk5OzyNTG/O8NjWsE?=
 =?us-ascii?Q?cMggfoUOepzAXIeYb26/d5qh7i8BgxLMd5wd6rg7jxX9VWqlD6yOpVBWLwy+?=
 =?us-ascii?Q?VR1+eTjHxeCwDBaBwRP5tmqRYOwqamDYtwTZnCBk65qZjTDYPk0Sxno+IFO+?=
 =?us-ascii?Q?SNgJth0QwA7rv20oOzq7OG14a5a1o44irZdhxT9HR+x9pAhVpjfGjt/hlRLb?=
 =?us-ascii?Q?Mhc+t15sxi+y/ZCxUZzrx/IZQlk4esq+sK9XMwOCLDZG2eaCaOUjMPel/z6p?=
 =?us-ascii?Q?2zv49y+EtZ1zMZaDlwhJ2xuyqwnp9ng7Agt1ZoTpU6q2bpIuLnKR/WYwOHiR?=
 =?us-ascii?Q?WJdbSEWOPDk0fXArUe+UfrWuLakOEIMiYBmH5a4UxUnVfSZlGcFNs4rd9WcJ?=
 =?us-ascii?Q?XyWR6Q0KwLU/MUh5L9AA/yAtrKLBwLkWzdV7INYW2Nk8zoAEQaipmdt4J+53?=
 =?us-ascii?Q?5kDTvSVV1hYp9QCdexZZz97x1nEQFN/FeBr/xsmrlo9ZDXHw/xx2RsETucIR?=
 =?us-ascii?Q?mrQw551Q4kuqsjTuY/TMQKtLjBNlkO/YhkogqQagzqNgHfSW6UWQpaWXWRAE?=
 =?us-ascii?Q?JqYRCT2Ryf/IIDinFerdN5hbwWWJNi4K7kpVYGmMi8iXXB8WycxFceqURRbJ?=
 =?us-ascii?Q?zfIACGfODI0JkyCTeelguEElGTmwVRNPmsgNXT8iDddTld/YyKS9U1VfXsEz?=
 =?us-ascii?Q?qDyW1bwWNEILkgv4fwnobZ+n0Ggk+CLhhb0CKyNeVYqBhbiknq1Mj5350ZQd?=
 =?us-ascii?Q?kHeFDHnoFZGRZaZsQdjqcCHn72vba4LxDyk/JANITqgRyk91qzmSV5cub0EY?=
 =?us-ascii?Q?C8LC/WtnrKbW9H/ZAKMx8KU4RQY1JqhwJENARnK7A2Oda8veLvC1mEU00GPS?=
 =?us-ascii?Q?cOwh74ED0Dx/9T2V5pOQtlnWaUZqZMY/awL8acOlMK5GgeOKbe00RJMvpNtK?=
 =?us-ascii?Q?FY4L18QuXqS0uiGL60xAybpJo8jha8pjGbCXt4efO8u4mZQ7JXDau/Lxh7oe?=
 =?us-ascii?Q?jIRxX3SY17f23zHw/vtZ/Fyns2/UgXn3cLTY7pc9+jgE2983q0L/oitnhZoc?=
 =?us-ascii?Q?BD5T0Kgz72ysWn9Eu5P71nRwD/v/wPVZoFZpkJpwNhStTzHyw3nwHjfifgT+?=
 =?us-ascii?Q?lnlmafUIkrTPJspH3VDkIYD1DkS6jeRC/NtzOxF7DY+yWrVW8eQni/FOdizR?=
 =?us-ascii?Q?GbjtMv1/yNBuj8C7ahawJAbLQhtpamGEtaWcrR4QtlexTzAFQFwdZwjU10rf?=
 =?us-ascii?Q?nfGgyHoj1cIRykqoUC69+EVv3kdb48vYCH/CJ5WcE6m4HXZwx2QBSTHCpZBV?=
 =?us-ascii?Q?FoT4ICubS550khFChWhiMnz5s5zRmVCo5GK1kaHKM+NlxK2XB7PbsEhP7Kbs?=
 =?us-ascii?Q?cKgAoYeJB/92allR64MhVLFlqISC4ZLNHBb5ooi3omGlAwuBzaY3ACmEqSGQ?=
 =?us-ascii?Q?ligoVnVVUNFlgISSbRuFHu4=3D?=
Content-Type: multipart/alternative;
 boundary="_000_DM5PR12MB132300A9BF764789D61B7B308C3B9DM5PR12MB1323namp_"
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM5PR12MB1323.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 23f7a370-80cf-4f69-fdfc-08d9f613f27a
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Feb 2022 14:59:38.1031 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: CSLFd1sexSV2tGVip09PnWiUchZH3YKk/BaW0DtebYRy8vqlTDexMVAlMXTlMHYP2nipqcOaQsX+8ihtnuhK9A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3673
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
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--_000_DM5PR12MB132300A9BF764789D61B7B308C3B9DM5PR12MB1323namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

[Public]

I think is safer only to set it for IP_VERSION(4, 4, 0): which is Aldebaran=
.


From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Deucher,=
 Alexander
Sent: Tuesday, February 22, 2022 8:55 AM
To: Chen, Xiaogang <Xiaogang.Chen@amd.com>; amd-gfx@lists.freedesktop.org
Subject: Re: [PATCH] drm/amdgpu: config HDP_MISC_CNTL.READ_BUFFER_WATERMARK=
 to fix applications running across multiple GPU config hang.


[Public]


[Public]

Please be sure to test this on other asics which use the HDP 4.0 code.  I d=
on't think this field exists for all of them.

Alex

________________________________
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org<mailto:amd-gfx-bounces=
@lists.freedesktop.org>> on behalf of Xiaogang.Chen <xiaogang.chen@amd.com<=
mailto:xiaogang.chen@amd.com>>
Sent: Monday, February 21, 2022 6:05 PM
To: amd-gfx@lists.freedesktop.org<mailto:amd-gfx@lists.freedesktop.org> <am=
d-gfx@lists.freedesktop.org<mailto:amd-gfx@lists.freedesktop.org>>
Cc: Chen, Xiaogang <Xiaogang.Chen@amd.com<mailto:Xiaogang.Chen@amd.com>>
Subject: [PATCH] drm/amdgpu: config HDP_MISC_CNTL.READ_BUFFER_WATERMARK to =
fix applications running across multiple GPU config hang.

From: Xiaogang Chen <xiaogang.chen@amd.com<mailto:xiaogang.chen@amd.com>>

Signed-off-by: Xiaogang Chen <xiaogang.chen@amd.com<mailto:xiaogang.chen@am=
d.com>>
---
 drivers/gpu/drm/amd/amdgpu/hdp_v4_0.c                      | 1 +
 drivers/gpu/drm/amd/include/asic_reg/hdp/hdp_4_0_sh_mask.h | 2 ++
 2 files changed, 3 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/hdp_v4_0.c b/drivers/gpu/drm/amd/am=
dgpu/hdp_v4_0.c
index d7811e0327cb..aa2c7c3f721f 100644
--- a/drivers/gpu/drm/amd/amdgpu/hdp_v4_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/hdp_v4_0.c
@@ -145,6 +145,7 @@ static void hdp_v4_0_init_registers(struct amdgpu_devic=
e *adev)
         }

         WREG32_FIELD15(HDP, 0, HDP_MISC_CNTL, FLUSH_INVALIDATE_CACHE, 1);
+       WREG32_FIELD15(HDP, 0, HDP_MISC_CNTL, READ_BUFFER_WATERMARK, 2);

         WREG32_SOC15(HDP, 0, mmHDP_NONSURFACE_BASE, (adev->gmc.vram_start =
>> 8));
         WREG32_SOC15(HDP, 0, mmHDP_NONSURFACE_BASE_HI, (adev->gmc.vram_sta=
rt >> 40));
diff --git a/drivers/gpu/drm/amd/include/asic_reg/hdp/hdp_4_0_sh_mask.h b/d=
rivers/gpu/drm/amd/include/asic_reg/hdp/hdp_4_0_sh_mask.h
index 25e28691d62d..65c91b0102e4 100644
--- a/drivers/gpu/drm/amd/include/asic_reg/hdp/hdp_4_0_sh_mask.h
+++ b/drivers/gpu/drm/amd/include/asic_reg/hdp/hdp_4_0_sh_mask.h
@@ -104,6 +104,7 @@
 #define HDP_MISC_CNTL__OUTSTANDING_WRITE_COUNT_1024__SHIFT      0x5
 #define HDP_MISC_CNTL__MULTIPLE_READS__SHIFT    0x6
 #define HDP_MISC_CNTL__SIMULTANEOUS_READS_WRITES__SHIFT 0xb
+#define HDP_MISC_CNTL__READ_BUFFER_WATERMARK__SHIFT 0xe
 #define HDP_MISC_CNTL__FED_ENABLE__SHIFT        0x15
 #define HDP_MISC_CNTL__SYSHUB_CHANNEL_PRIORITY__SHIFT   0x17
 #define HDP_MISC_CNTL__MMHUB_WRBURST_ENABLE__SHIFT      0x18
@@ -118,6 +119,7 @@
 #define HDP_MISC_CNTL__OUTSTANDING_WRITE_COUNT_1024_MASK        0x00000020=
L
 #define HDP_MISC_CNTL__MULTIPLE_READS_MASK      0x00000040L
 #define HDP_MISC_CNTL__SIMULTANEOUS_READS_WRITES_MASK   0x00000800L
+#define HDP_MISC_CNTL__READ_BUFFER_WATERMARK_MASK       0x0000c000L
 #define HDP_MISC_CNTL__FED_ENABLE_MASK  0x00200000L
 #define HDP_MISC_CNTL__SYSHUB_CHANNEL_PRIORITY_MASK     0x00800000L
 #define HDP_MISC_CNTL__MMHUB_WRBURST_ENABLE_MASK        0x01000000L
--
2.25.1

--_000_DM5PR12MB132300A9BF764789D61B7B308C3B9DM5PR12MB1323namp_
Content-Type: text/html; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<html xmlns:v=3D"urn:schemas-microsoft-com:vml" xmlns:o=3D"urn:schemas-micr=
osoft-com:office:office" xmlns:w=3D"urn:schemas-microsoft-com:office:word" =
xmlns:m=3D"http://schemas.microsoft.com/office/2004/12/omml" xmlns=3D"http:=
//www.w3.org/TR/REC-html40">
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Dus-ascii"=
>
<meta name=3D"Generator" content=3D"Microsoft Word 15 (filtered medium)">
<!--[if !mso]><style>v\:* {behavior:url(#default#VML);}
o\:* {behavior:url(#default#VML);}
w\:* {behavior:url(#default#VML);}
.shape {behavior:url(#default#VML);}
</style><![endif]--><style><!--
/* Font Definitions */
@font-face
	{font-family:"Cambria Math";
	panose-1:2 4 5 3 5 4 6 3 2 4;}
@font-face
	{font-family:Calibri;
	panose-1:2 15 5 2 2 2 4 3 2 4;}
/* Style Definitions */
p.MsoNormal, li.MsoNormal, div.MsoNormal
	{margin:0in;
	font-size:11.0pt;
	font-family:"Calibri",sans-serif;}
a:link, span.MsoHyperlink
	{mso-style-priority:99;
	color:#0563C1;
	text-decoration:underline;}
span.EmailStyle18
	{mso-style-type:personal-reply;
	font-family:"Calibri",sans-serif;
	color:windowtext;}
p.msipheader23c54b6f, li.msipheader23c54b6f, div.msipheader23c54b6f
	{mso-style-name:msipheader23c54b6f;
	mso-margin-top-alt:auto;
	margin-right:0in;
	mso-margin-bottom-alt:auto;
	margin-left:0in;
	font-size:11.0pt;
	font-family:"Calibri",sans-serif;}
.MsoChpDefault
	{mso-style-type:export-only;
	font-size:10.0pt;}
@page WordSection1
	{size:8.5in 11.0in;
	margin:1.0in 1.0in 1.0in 1.0in;}
div.WordSection1
	{page:WordSection1;}
--></style><!--[if gte mso 9]><xml>
<o:shapedefaults v:ext=3D"edit" spidmax=3D"1026" />
</xml><![endif]--><!--[if gte mso 9]><xml>
<o:shapelayout v:ext=3D"edit">
<o:idmap v:ext=3D"edit" data=3D"1" />
</o:shapelayout></xml><![endif]-->
</head>
<body lang=3D"EN-US" link=3D"#0563C1" vlink=3D"#954F72" style=3D"word-wrap:=
break-word">
<div class=3D"WordSection1">
<p class=3D"msipheader23c54b6f" style=3D"margin:0in"><span style=3D"font-si=
ze:10.0pt;font-family:&quot;Arial&quot;,sans-serif;color:green">[Public]</s=
pan><o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">I think is safer only to set it for IP_VERSION(4, 4,=
 0): which is Aldebaran.<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<div>
<div style=3D"border:none;border-top:solid #E1E1E1 1.0pt;padding:3.0pt 0in =
0in 0in">
<p class=3D"MsoNormal"><b>From:</b> amd-gfx &lt;amd-gfx-bounces@lists.freed=
esktop.org&gt;
<b>On Behalf Of </b>Deucher, Alexander<br>
<b>Sent:</b> Tuesday, February 22, 2022 8:55 AM<br>
<b>To:</b> Chen, Xiaogang &lt;Xiaogang.Chen@amd.com&gt;; amd-gfx@lists.free=
desktop.org<br>
<b>Subject:</b> Re: [PATCH] drm/amdgpu: config HDP_MISC_CNTL.READ_BUFFER_WA=
TERMARK to fix applications running across multiple GPU config hang.<o:p></=
o:p></p>
</div>
</div>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p style=3D"margin:15.0pt"><span style=3D"font-size:10.0pt;font-family:&quo=
t;Arial&quot;,sans-serif;color:green">[Public]<o:p></o:p></span></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<div>
<p style=3D"margin:15.0pt"><span style=3D"font-size:10.0pt;font-family:&quo=
t;Arial&quot;,sans-serif;color:green">[Public]<o:p></o:p></span></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<div>
<div>
<p class=3D"MsoNormal"><span style=3D"font-size:12.0pt;color:black">Please =
be sure to test this on other asics which use the HDP 4.0 code.&nbsp; I don=
't think this field exists for all of them.<o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal"><span style=3D"font-size:12.0pt;color:black"><o:p>&n=
bsp;</o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal"><span style=3D"font-size:12.0pt;color:black">Alex<o:=
p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal"><span style=3D"font-size:12.0pt;color:black"><o:p>&n=
bsp;</o:p></span></p>
</div>
<div class=3D"MsoNormal" align=3D"center" style=3D"text-align:center">
<hr size=3D"2" width=3D"98%" align=3D"center">
</div>
<div id=3D"divRplyFwdMsg">
<p class=3D"MsoNormal"><b><span style=3D"color:black">From:</span></b><span=
 style=3D"color:black"> amd-gfx &lt;<a href=3D"mailto:amd-gfx-bounces@lists=
.freedesktop.org">amd-gfx-bounces@lists.freedesktop.org</a>&gt; on behalf o=
f Xiaogang.Chen &lt;<a href=3D"mailto:xiaogang.chen@amd.com">xiaogang.chen@=
amd.com</a>&gt;<br>
<b>Sent:</b> Monday, February 21, 2022 6:05 PM<br>
<b>To:</b> <a href=3D"mailto:amd-gfx@lists.freedesktop.org">amd-gfx@lists.f=
reedesktop.org</a> &lt;<a href=3D"mailto:amd-gfx@lists.freedesktop.org">amd=
-gfx@lists.freedesktop.org</a>&gt;<br>
<b>Cc:</b> Chen, Xiaogang &lt;<a href=3D"mailto:Xiaogang.Chen@amd.com">Xiao=
gang.Chen@amd.com</a>&gt;<br>
<b>Subject:</b> [PATCH] drm/amdgpu: config HDP_MISC_CNTL.READ_BUFFER_WATERM=
ARK to fix applications running across multiple GPU config hang.</span>
<o:p></o:p></p>
<div>
<p class=3D"MsoNormal">&nbsp;<o:p></o:p></p>
</div>
</div>
<div>
<div>
<p class=3D"MsoNormal" style=3D"margin-bottom:12.0pt">From: Xiaogang Chen &=
lt;<a href=3D"mailto:xiaogang.chen@amd.com">xiaogang.chen@amd.com</a>&gt;<b=
r>
<br>
Signed-off-by: Xiaogang Chen &lt;<a href=3D"mailto:xiaogang.chen@amd.com">x=
iaogang.chen@amd.com</a>&gt;<br>
---<br>
&nbsp;drivers/gpu/drm/amd/amdgpu/hdp_v4_0.c&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; | 1 +<br>
&nbsp;drivers/gpu/drm/amd/include/asic_reg/hdp/hdp_4_0_sh_mask.h | 2 ++<br>
&nbsp;2 files changed, 3 insertions(+)<br>
<br>
diff --git a/drivers/gpu/drm/amd/amdgpu/hdp_v4_0.c b/drivers/gpu/drm/amd/am=
dgpu/hdp_v4_0.c<br>
index d7811e0327cb..aa2c7c3f721f 100644<br>
--- a/drivers/gpu/drm/amd/amdgpu/hdp_v4_0.c<br>
+++ b/drivers/gpu/drm/amd/amdgpu/hdp_v4_0.c<br>
@@ -145,6 +145,7 @@ static void hdp_v4_0_init_registers(struct amdgpu_devic=
e *adev)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; WREG32_FIELD15(HDP, 0, HDP=
_MISC_CNTL, FLUSH_INVALIDATE_CACHE, 1);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; WREG32_FIELD15(HDP, 0, HDP_MISC_CNTL,=
 READ_BUFFER_WATERMARK, 2);<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; WREG32_SOC15(HDP, 0, mmHDP=
_NONSURFACE_BASE, (adev-&gt;gmc.vram_start &gt;&gt; 8));<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; WREG32_SOC15(HDP, 0, mmHDP=
_NONSURFACE_BASE_HI, (adev-&gt;gmc.vram_start &gt;&gt; 40));<br>
diff --git a/drivers/gpu/drm/amd/include/asic_reg/hdp/hdp_4_0_sh_mask.h b/d=
rivers/gpu/drm/amd/include/asic_reg/hdp/hdp_4_0_sh_mask.h<br>
index 25e28691d62d..65c91b0102e4 100644<br>
--- a/drivers/gpu/drm/amd/include/asic_reg/hdp/hdp_4_0_sh_mask.h<br>
+++ b/drivers/gpu/drm/amd/include/asic_reg/hdp/hdp_4_0_sh_mask.h<br>
@@ -104,6 +104,7 @@<br>
&nbsp;#define HDP_MISC_CNTL__OUTSTANDING_WRITE_COUNT_1024__SHIFT&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; 0x5<br>
&nbsp;#define HDP_MISC_CNTL__MULTIPLE_READS__SHIFT&nbsp;&nbsp;&nbsp; 0x6<br=
>
&nbsp;#define HDP_MISC_CNTL__SIMULTANEOUS_READS_WRITES__SHIFT 0xb<br>
+#define HDP_MISC_CNTL__READ_BUFFER_WATERMARK__SHIFT 0xe<br>
&nbsp;#define HDP_MISC_CNTL__FED_ENABLE__SHIFT&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp; 0x15<br>
&nbsp;#define HDP_MISC_CNTL__SYSHUB_CHANNEL_PRIORITY__SHIFT&nbsp;&nbsp; 0x1=
7<br>
&nbsp;#define HDP_MISC_CNTL__MMHUB_WRBURST_ENABLE__SHIFT&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp; 0x18<br>
@@ -118,6 +119,7 @@<br>
&nbsp;#define HDP_MISC_CNTL__OUTSTANDING_WRITE_COUNT_1024_MASK&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0x00000020L<br>
&nbsp;#define HDP_MISC_CNTL__MULTIPLE_READS_MASK&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; 0x00000040L<br>
&nbsp;#define HDP_MISC_CNTL__SIMULTANEOUS_READS_WRITES_MASK&nbsp;&nbsp; 0x0=
0000800L<br>
+#define HDP_MISC_CNTL__READ_BUFFER_WATERMARK_MASK&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp; 0x0000c000L<br>
&nbsp;#define HDP_MISC_CNTL__FED_ENABLE_MASK&nbsp; 0x00200000L<br>
&nbsp;#define HDP_MISC_CNTL__SYSHUB_CHANNEL_PRIORITY_MASK&nbsp;&nbsp;&nbsp;=
&nbsp; 0x00800000L<br>
&nbsp;#define HDP_MISC_CNTL__MMHUB_WRBURST_ENABLE_MASK&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; 0x01000000L<br>
-- <br>
2.25.1<o:p></o:p></p>
</div>
</div>
</div>
</div>
</div>
</body>
</html>

--_000_DM5PR12MB132300A9BF764789D61B7B308C3B9DM5PR12MB1323namp_--
