Return-Path: <SRS0=sNMb=MA=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F32D2C07E95
	for <amd-gfx@archiver.kernel.org>; Thu,  8 Jul 2021 03:32:18 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 985BF61CD6
	for <amd-gfx@archiver.kernel.org>; Thu,  8 Jul 2021 03:32:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 985BF61CD6
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F07A16E20E;
	Thu,  8 Jul 2021 03:32:17 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2075.outbound.protection.outlook.com [40.107.243.75])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 150606E20E
 for <amd-gfx@lists.freedesktop.org>; Thu,  8 Jul 2021 03:32:16 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=A2AwZ48wtOA25eUeikfR1s0Ljcc/a84h2d9Oyhvb2bZBSmO+ETMlMO+YqdxWa1x/6PwNLNmsrEvG7yjfNf+k0k27xFLIFv/iYFh/TVPUXg+KkvM3HdrGGLaF80QuO6/q6J2BYro6RtVhR0+CQeE9fW48LK9wxMNmalY8CxcPJAZRP4zjIEir5zDwOWZgCn4baoXH4n9IebShShcVotk8P6TBfra11qX/gLDWYm6beOXPgDA9cq3o9rWzEliwW8kL0EaqqyzLs2M/y4esL5MykHiXssXc8JMG2F+VnNnfXfxRN11RGyyrQSGAo2l71j5jztycZYMEnzE+F2QWaN5S1w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=itsPrRUXH6CBfVDEH3cF7iDfsKxbwBZYFzqP/8Dsw/c=;
 b=L8QzdjM0YZMJUiayioPvcQcNbWSAE/JHr2/B2pqBuhoIZp8ODCssi0CceYcBdVgdg9AioQH2thrEmAZ2/Au0duXfoEc7QCvil29Km9umM7/axROEo5GMKc5lEu+rcIk6ZG8jIMT41m1RueuATipgD5x0sZL5zYF4c/7n8ROdTvB6Oz3AXl8kkUmAB6oXnlMAoR/hfNaijGfPBGxxS/EbooT0IoImOe36LBBTlDQTbggg5L9RO6edlfddY0rHEaGqsDeo2nzTaZomeLeui8HJLgDBlw4Ngo8xTGLp2mcEW4Ni7ZszK2m0QONSNk3jcabDNWCc+Vg3SYeZmVoWqxTk2w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=itsPrRUXH6CBfVDEH3cF7iDfsKxbwBZYFzqP/8Dsw/c=;
 b=qCP7hTw3n4v/Fm99RwO+7ojj/6e7Qx4tsbovbXbc9acOHUAhiNC0TsXrsw5xS7zEJ4d6gG8MmhAtJOt1JT42MIrUPLSBLcPOsHASkywxGnPsiMCkHpkUXneaKkzBN608fr/huU7cr3oUhreXtY1e+0BupXSXKwrgPD2y8/Dth1w=
Received: from BN9PR12MB5226.namprd12.prod.outlook.com (2603:10b6:408:11f::11)
 by BN9PR12MB5243.namprd12.prod.outlook.com (2603:10b6:408:100::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4308.20; Thu, 8 Jul
 2021 03:32:14 +0000
Received: from BN9PR12MB5226.namprd12.prod.outlook.com
 ([fe80::d863:def1:2b7e:fc89]) by BN9PR12MB5226.namprd12.prod.outlook.com
 ([fe80::d863:def1:2b7e:fc89%9]) with mapi id 15.20.4308.021; Thu, 8 Jul 2021
 03:32:14 +0000
From: "Clements, John" <John.Clements@amd.com>
To: "Yang, Stanley" <Stanley.Yang@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH Review 1/1] drm/amdgpu: initialize umc ras function
Thread-Topic: [PATCH Review 1/1] drm/amdgpu: initialize umc ras function
Thread-Index: AQHXc6lU1C9CG2g8pkua/PC/qluFk6s4bDIw
Date: Thu, 8 Jul 2021 03:32:14 +0000
Message-ID: <BN9PR12MB52268CA9890446D849E32CA7FB199@BN9PR12MB5226.namprd12.prod.outlook.com>
References: <20210708032821.23553-1-Stanley.Yang@amd.com>
In-Reply-To: <20210708032821.23553-1-Stanley.Yang@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Enabled=true;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SetDate=2021-07-08T03:32:11Z; 
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Method=Standard;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Name=AMD Official Use
 Only-AIP 2.0;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ActionId=2e2303d3-3e19-41bf-9904-5826832c299d;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ContentBits=1
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: bc546c0c-c82d-4596-1258-08d941c0fa7b
x-ms-traffictypediagnostic: BN9PR12MB5243:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BN9PR12MB52438B3D5A6BD0238E87D7C9FB199@BN9PR12MB5243.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:473;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: uCRaAttfQf3VUHhxIERrtXyacARCykJoAQUKnOLokMPb5kEuBV13OFmtlyiDrrZQorEYrLysA3GyD4Dg8ELxQrZiTqxTgDimmJf9dqVXLlsUeZdTA4YmWDR7bTYxrVAPDhRm3xeVWxPpU67k7I57OH940QtSNjanmbXohoKe7C+2pWjji9jZvLSsR2tALoFkhRU+wbMQqB/uAPYW3uRVHuN/eTZAP8GhkHDVOthrqyUjQLxeMZnnM4S01ihCsUZRrdYuJKcNwKMRIoOvfb6R+56tAq7eUcTNi0cVxKijUO5j8nqOZsod41r+S9i9JNEo4BatwVusexjcd3QEOAFm509FixZ+6MSYFYvEdVDitjnK8j80/aWkm99hyktYk3XVarn5DMFRI01KMw3UtMZBvGSMO3mfhZUPSTcmN0NMqOw8VSEV6/w8wpR/l6FFnbmMDkQdQKmQj4yeDL0H3Sx+8rDQLBtsrtE0r//T8K517FJ6pxIGa1YHLqFZstyxfZiisl8FKaRLZmm8vsVzciRdh5OcUVgp+sYeIuIdLYAo7xC4aI96IS2JD0gLs5CSSMCxGiOFddjTY1g3HwJMduLgJGvZHvuWOf9GnbBGVcejj+6ecI9jXcQL+oPVU30y7sGMVqqWgcokApD1BCPXvXZAEg==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5226.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(346002)(39860400002)(366004)(396003)(376002)(136003)(4326008)(54906003)(66446008)(26005)(64756008)(2906002)(83380400001)(110136005)(86362001)(55016002)(6506007)(9686003)(76116006)(71200400001)(5660300002)(66476007)(66556008)(66946007)(186003)(7696005)(33656002)(316002)(53546011)(52536014)(38100700002)(8676002)(8936002)(478600001)(122000001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?zJPllMnPOGRddspxkeTtB5UcSlXdEdkNtUQawsKvf8951gAeft8PCdk+6FkR?=
 =?us-ascii?Q?YvlNdbgvNUUnB7QmPrwlUvQuHepzCKUwwhkjWHeIYH9p/8ftKEeA/C378/eL?=
 =?us-ascii?Q?2saMNTfTLGHW5mqAkUVKZVtj28ibJbV7BnJ0udCUtKhII8tH3eD5rze7O8WD?=
 =?us-ascii?Q?5MRJ/fgjER6hl+3ZJmce+PdmqXwGNlw/sz7HebVCeQVPbgvOXX6ihpps7Vgh?=
 =?us-ascii?Q?rczcczhvkIQRw71JzJj58NJYqKRXVXfrxVriD0btNSPob30zTr8ayRCpXIdg?=
 =?us-ascii?Q?RIWaHatPBLImhlRqyyJxZZEmd/pkDAybBv9CxHbiRgL3OqdMnh9pRXhczsWT?=
 =?us-ascii?Q?pJHOz0Mb7U4IYllVCamWtKHFr2plw7H+AFa0cw0/81cwJUZ55RBcteHRMT8s?=
 =?us-ascii?Q?RqAdhlT4xmnrMntQE9irqqjbrT3sjChPNT7HErMC9/x/2m4FIFZConJjb3nA?=
 =?us-ascii?Q?De9sLzjXpg5L6wL5NIaAflNaqic1a/6zIaFCJrxHLZ2RrsclvVMXNAfjZrtB?=
 =?us-ascii?Q?If7ViqFHsF2i5bzzXXkbB9hweUv9bFalUw5xaGotsKDhQCK7j5k9VfPqWimA?=
 =?us-ascii?Q?5/czJtJZ+oXKXhLTzIWX8ty/7iG43fJim78XX2fY0/Ui9R8S8wYP8tbklWaT?=
 =?us-ascii?Q?IAkoQDUcsUKIk37Bv/qdwwkRg0A3xzcwweA5Oth68vXdHdOBhBuj92MgYTwx?=
 =?us-ascii?Q?24ye0BLbKkl7slsVQ/Q9bPH/oCn6O44HubDm4MKrl3AZBpAWeIsr50ay0nW9?=
 =?us-ascii?Q?4GwPHDkWETThoJj6JV/3K4G9CzBt4HwG5Z+OWomyA2xyD87oov+AdFoj67pq?=
 =?us-ascii?Q?l9aUECFQyfPkVlEAnwslvAwm1Mbb+x3KCewquoIAHHU2E5rXwIEXIaEl626n?=
 =?us-ascii?Q?kXAXyTHSNINVL5kMS6qyFfcEBOUHG5dq+Q9h5wPF4At7CkIWhUqsNRLA7+xU?=
 =?us-ascii?Q?1dPrtnQnH55QCiLNhHCIkE6uBcHDnHddbiLugdQeCUpfyFUPz3uhpYPFKPyM?=
 =?us-ascii?Q?2apAMx4ZizgDgbtb3bZWWIP6KQ1NoT6fC9G76V4rMaTtc8EEFzdsimYcIpry?=
 =?us-ascii?Q?dKb8xLhHy9nyJpLTLVczkZPaNNydM8s5u00j9DhopEMOUes+7B3Kej9pSdmM?=
 =?us-ascii?Q?gIPoswdBfESZXDTFmpl3gKYuXpWN+nmNslk+VxRksSfOab6v3j5lRVIXpW1P?=
 =?us-ascii?Q?S4AAHK6jhjMnFflqoqLW0y31McxEucgGHQXlck6krkU25xLfGP8B7rbVDNqm?=
 =?us-ascii?Q?bd+VJKWu6qzsGeFOz1dfJd/0Lahn+lM7hH9onB2spRSzAZ/fUsZuXrX51HKh?=
 =?us-ascii?Q?wKH+Ugue09k+zr44bOTMFF30?=
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5226.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bc546c0c-c82d-4596-1258-08d941c0fa7b
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Jul 2021 03:32:14.1173 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: w+6iFJOOu8mXH9sA73wQwW3JsyAcFqXl7tnKYNdQg+0nJCHavKhaumI1HM0/AebtSN0NjAghvKoLOLuOzs5Rlg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR12MB5243
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
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Yang,
 Stanley" <Stanley.Yang@amd.com>, "Zhang, Hawking" <Hawking.Zhang@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Official Use Only]

Reviewed-by: John Clements <john.clements@amd.com>

-----Original Message-----
From: Stanley.Yang <Stanley.Yang@amd.com> 
Sent: Thursday, July 8, 2021 11:28 AM
To: amd-gfx@lists.freedesktop.org
Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Zhang, Hawking <Hawking.Zhang@amd.com>; Clements, John <John.Clements@amd.com>; Clements, John <John.Clements@amd.com>; Yang, Stanley <Stanley.Yang@amd.com>
Subject: [PATCH Review 1/1] drm/amdgpu: initialize umc ras function

From: John Clements <john.clements@amd.com>

support umc ras function initialization for aldebaran

Change-Id: I84155d4d3eaae86a8c1bd2331b1964946c47f6da
Signed-off-by: John Clements <john.clements@amd.com>
Signed-off-by: Stanley.Yang <Stanley.Yang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c | 13 +++++++++++++  drivers/gpu/drm/amd/amdgpu/umc_v6_7.c | 15 +++++++++++++++  drivers/gpu/drm/amd/amdgpu/umc_v6_7.h | 12 ++++++++++++
 3 files changed, 40 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
index 3332c9e0a4e2..42d7244573b5 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
@@ -53,6 +53,7 @@
 #include "mmhub_v1_7.h"
 #include "umc_v6_1.h"
 #include "umc_v6_0.h"
+#include "umc_v6_7.h"
 #include "hdp_v4_0.h"
 
 #include "ivsrcid/vmc/irqsrcs_vmc_1_0.h"
@@ -1163,6 +1164,18 @@ static void gmc_v9_0_set_umc_funcs(struct amdgpu_device *adev)
 		adev->umc.channel_idx_tbl = &umc_v6_1_channel_idx_tbl[0][0];
 		adev->umc.ras_funcs = &umc_v6_1_ras_funcs;
 		break;
+	case CHIP_ALDEBARAN:
+		adev->umc.max_ras_err_cnt_per_query = UMC_V6_7_TOTAL_CHANNEL_NUM;
+		adev->umc.channel_inst_num = UMC_V6_7_CHANNEL_INSTANCE_NUM;
+		adev->umc.umc_inst_num = UMC_V6_7_UMC_INSTANCE_NUM;
+		adev->umc.channel_offs = UMC_V6_7_PER_CHANNEL_OFFSET;
+		if (!adev->gmc.xgmi.connected_to_cpu)
+			adev->umc.ras_funcs = &umc_v6_7_ras_funcs;
+		if (1 & adev->smuio.funcs->get_die_id(adev))
+			adev->umc.channel_idx_tbl = &umc_v6_7_channel_idx_tbl_first[0][0];
+		else
+			adev->umc.channel_idx_tbl = &umc_v6_7_channel_idx_tbl_second[0][0];
+		break;
 	default:
 		break;
 	}
diff --git a/drivers/gpu/drm/amd/amdgpu/umc_v6_7.c b/drivers/gpu/drm/amd/amdgpu/umc_v6_7.c
index 3a8f787374c0..7da12110425c 100644
--- a/drivers/gpu/drm/amd/amdgpu/umc_v6_7.c
+++ b/drivers/gpu/drm/amd/amdgpu/umc_v6_7.c
@@ -28,6 +28,21 @@
 #include "umc/umc_6_7_0_offset.h"
 #include "umc/umc_6_7_0_sh_mask.h"
 
+const uint32_t
+	umc_v6_7_channel_idx_tbl_second[UMC_V6_7_UMC_INSTANCE_NUM][UMC_V6_7_CHANNEL_INSTANCE_NUM] = {
+		{28, 12, 6, 22},	{19, 3, 9, 25},
+		{20, 4, 30, 14},	{11, 27, 1, 17},
+		{24, 8, 2, 18},		{15, 31, 5, 21},
+		{16, 0, 26, 10},	{7, 23, 29, 13}
+};
+const uint32_t
+	umc_v6_7_channel_idx_tbl_first[UMC_V6_7_UMC_INSTANCE_NUM][UMC_V6_7_CHANNEL_INSTANCE_NUM] = {
+		{19, 3, 9, 25},		{28, 12, 6, 22},
+		{11, 27, 1, 17},	{20, 4, 30, 14},
+		{15, 31, 5, 21},	{24, 8, 2, 18},
+		{7, 23, 29, 13},	{16, 0, 26, 10}
+};
+
 static inline uint32_t get_umc_v6_7_reg_offset(struct amdgpu_device *adev,
 					      uint32_t umc_inst,
 					      uint32_t ch_inst)
diff --git a/drivers/gpu/drm/amd/amdgpu/umc_v6_7.h b/drivers/gpu/drm/amd/amdgpu/umc_v6_7.h
index 4eb85f247e96..aa282687e0e4 100644
--- a/drivers/gpu/drm/amd/amdgpu/umc_v6_7.h
+++ b/drivers/gpu/drm/amd/amdgpu/umc_v6_7.h
@@ -32,6 +32,18 @@
 
 #define UMC_V6_7_INST_DIST	0x40000
 
+/* number of umc channel instance with memory map register access */
+#define UMC_V6_7_CHANNEL_INSTANCE_NUM		4
+/* number of umc instance with memory map register access */
+#define UMC_V6_7_UMC_INSTANCE_NUM		8
+/* total channel instances in one umc block */
+#define UMC_V6_7_TOTAL_CHANNEL_NUM	(UMC_V6_7_CHANNEL_INSTANCE_NUM * UMC_V6_7_UMC_INSTANCE_NUM)
+/* UMC regiser per channel offset */
+#define UMC_V6_7_PER_CHANNEL_OFFSET		0x400
 extern const struct amdgpu_umc_ras_funcs umc_v6_7_ras_funcs;
+extern const uint32_t
+	
+umc_v6_7_channel_idx_tbl_second[UMC_V6_7_UMC_INSTANCE_NUM][UMC_V6_7_CHA
+NNEL_INSTANCE_NUM];
+extern const uint32_t
+	
+umc_v6_7_channel_idx_tbl_first[UMC_V6_7_UMC_INSTANCE_NUM][UMC_V6_7_CHAN
+NEL_INSTANCE_NUM];
 
 #endif
--
2.17.1
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
