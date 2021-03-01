Return-Path: <SRS0=hzAD=H7=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E5D4C433E0
	for <amd-gfx@archiver.kernel.org>; Mon,  1 Mar 2021 09:31:13 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2B7A364E22
	for <amd-gfx@archiver.kernel.org>; Mon,  1 Mar 2021 09:31:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2B7A364E22
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C7CC46E544;
	Mon,  1 Mar 2021 09:31:11 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2076.outbound.protection.outlook.com [40.107.223.76])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AE9706E544
 for <amd-gfx@lists.freedesktop.org>; Mon,  1 Mar 2021 09:31:10 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RvSZnQT/p0RGYX+7ZgFR1DUWO6kK3WTqzQYaHJmcnpjYwvaiHXMF4YVxfYf3osvBg+5qQcJX0EwYD/Vn16T/Q6zpnudik6V1byZ4AF8pbUOJGScliwct16Bvn8u3qMuJLjFFcifUs82DPWJVxbmENxa05KvkC4RGZKDtlTcAsaqTq2vjVgbhEYMx8qrF79p13XVsFrHwvPhIRymMmCaBuoC/N39q2CyJO9urWGBL5b13wOMxRzNBDbnQh1oMF7RGjiRdbvHPK8Pq57Z8bx0UyDvxlOEUFI3WIgkNFTKHNRln0kQ/rPN1IorF4har1sgAljTQvtzm3DHyzEqiPfTEIA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UsYcs6EvJDb3ZGQeikrvus68RT3K6eqDEZWDmc7JmXs=;
 b=A9q0EGhK1qX+SIb/vuJZMfDqDJ06UBqGpreHbuz0161N78a4dgSr89evOVH56PhbbXzJw57jk5LbAEtD2ix6LXYU7wkfLJ3f5l2RhJ7uo6wDES0lVzoKyQfhV3+m5SUFaRbcwZiL8As8OqxkuwJoiLt50hsHrZdFZUh+g2zFOIPVy1dfmxZ5ttRkvNuY82vVeeJJlhtWWSlAqVw9xEoAfo4MD3DQwg0BA5lZ6VFJkhmJjAFkmdvhzRsLwoKdokCsmxuQiSDeDalcQggdwSA3+vGc7mjjNJRZWSy3ZMo7NW94GohGsgyj4elnUI+W5brtIoxD0UWbf+KBK1FJKdflUQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UsYcs6EvJDb3ZGQeikrvus68RT3K6eqDEZWDmc7JmXs=;
 b=2SVGTJzl9sUGKuyDY74QidpAq9TCjEtpVA2uEfZxf+QTFFXinnnFliBo3d4lx8YA1ZACQsG0wKINN9ZTKvpbcPvGOKNxrX7qHpyO7enYr9UwYGYlY379qYkq7+cNFB9vgqJCWT/OAlDOctKdZh37zKA1ypT40df+S+M516hE+zA=
Received: from DM6PR12MB4075.namprd12.prod.outlook.com (2603:10b6:5:21d::8) by
 DM6PR12MB3180.namprd12.prod.outlook.com (2603:10b6:5:182::28) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3890.23; Mon, 1 Mar 2021 09:31:08 +0000
Received: from DM6PR12MB4075.namprd12.prod.outlook.com
 ([fe80::34e3:c46e:188c:ef53]) by DM6PR12MB4075.namprd12.prod.outlook.com
 ([fe80::34e3:c46e:188c:ef53%5]) with mapi id 15.20.3890.028; Mon, 1 Mar 2021
 09:31:08 +0000
From: "Zhang, Hawking" <Hawking.Zhang@amd.com>
To: "Wang, Kevin(Yang)" <Kevin1.Wang@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH 1/2] drm/amdgpu: refine PSP TA firmware info print in
 debugfs
Thread-Topic: [PATCH 1/2] drm/amdgpu: refine PSP TA firmware info print in
 debugfs
Thread-Index: AQHXDnqqZVxfu1FInUSeVj4n9rrEBqpu23Ww
Date: Mon, 1 Mar 2021 09:31:08 +0000
Message-ID: <DM6PR12MB407548F416DADBEAB2ABDCFAFC9A9@DM6PR12MB4075.namprd12.prod.outlook.com>
References: <20210301090951.43956-1-kevin1.wang@amd.com>
In-Reply-To: <20210301090951.43956-1-kevin1.wang@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Enabled=true;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_SetDate=2021-03-01T09:31:06Z; 
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Method=Privileged;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Name=Public_0;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_ActionId=570af684-b80a-49a9-bb4c-a45006becc23;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_ContentBits=1
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [180.167.199.189]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: ad187238-d461-4dc1-2198-08d8dc94beee
x-ms-traffictypediagnostic: DM6PR12MB3180:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM6PR12MB31807B06CE7F4D45C81A19C5FC9A9@DM6PR12MB3180.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:1417;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: QDKZMmrBmiNpTvNK9nL9foZnwrD9X/BmevTUx3xorWPa9Xp4WK5hhtfD8pBnRuOK2tbkWf7EBba4jS6vuo8S8iNrMduDeCQHn8BzzcKtOLhEFED37CXRdIU4jkKUm7WJjW5XxRf6pwVgAc6EacqgoZjSNB04eiRGOE4+rX6sLpQuFDkZw+r6B9sDAjUT68aFFYWkHyltSrei+pAUrx3qvKq7KkaO6V30ZtuQHW1CJVeUOgkXvggbg/A1F5xFfYTGUbysKFEr091BnTujw3P/vAY9f0WAjMHhmqzf59tkLBpefTRRYHq/bA1GVB2rbe1vXYO+DpUyjVvoOb4pS2ESARpF5BE49k2amqLErY/y9b9lODhthOkeftqHRzrL8jL5Ipki9i5cckNgPvexTh1LiMxvtfHf7b7nq1HAp2/KNLsnhAlWDomShjX7ajeCZyu6fnzIwtaBvEJMFIEnkCX7sD+WKzz/Ik2sT4377iO7GAifkyVy+7UzcvLTNF5KFTRCyd+nNaTNU3FNsV7W7jbnhg==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB4075.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(39860400002)(366004)(346002)(376002)(136003)(396003)(186003)(26005)(2906002)(8936002)(86362001)(33656002)(55016002)(6506007)(66946007)(5660300002)(66476007)(66446008)(53546011)(9686003)(76116006)(71200400001)(7696005)(8676002)(52536014)(66556008)(83380400001)(316002)(64756008)(478600001)(110136005);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?pCp/R5AQBC5mtj9HKfAry+PV/f1PxxMA8Qhcd170evQDz5XXrapDgoO1eLNQ?=
 =?us-ascii?Q?/l3YMJrgA4BJVsXhnR7c3IgPjUZ4Eak4NnvjnXaGBiCoM3vSFyclPc9KDcPu?=
 =?us-ascii?Q?LUw/6TNcVLxFzdwU0vDKUIe70y5pd8FvdpvufGlGs3wC0TTC6Go0Y53DqrIN?=
 =?us-ascii?Q?+m5sEv2ujZcFr3WZ7mfvD4JMgx0jupI4Id7HcJRi7lVfdEzo9kxzVeZO2h30?=
 =?us-ascii?Q?nqQmsuBqANq2u7+5gCWqX9J5QlDqVh1Q/tDyw6sfWGRrrWbSKfFLOmgu7lwJ?=
 =?us-ascii?Q?ZxvFWHaHOBompxIjkNW3o9fTPRzlbY3AbUAERGF2vv3l2vMmFiCfkxGHCpdH?=
 =?us-ascii?Q?bXr4sh/dTOxcuSFnOvs0fCk+CmbDIvT/0NjXnFwhM2DMpBn8f/YQjX8vbAIr?=
 =?us-ascii?Q?WbSWk8LeS3N1aCUJdjsujDkMuae5qh+xji309R5AkpUNqp763YCq+fFmcfs7?=
 =?us-ascii?Q?f5RVSIPV04JLJeTZwHPb1yS3fCHfnNCxbzZf1BzMti9gP4SLqWn2wYSn6HtQ?=
 =?us-ascii?Q?XV+OxvqE+Zk321imR7f8dD1VidBMg2KlVqIeC9x39pTuJzFiInx4JxgzvD7R?=
 =?us-ascii?Q?Ts/tYjJMWKV6mOPBlPYNIru3VXDOlQWuO+nDjYNgAVxA33vm30V1EE7X+73/?=
 =?us-ascii?Q?6ouLUAlC9HFx/qqs6B/i6yc2emio+XruNHSEH9+RttIz2hFBRBOqVmQnon+h?=
 =?us-ascii?Q?5VTqzXynrHcdvtfXYGhD+P5ApTByAnKF6FSGxnTx7zM6QtW0bWKiFcjgncpQ?=
 =?us-ascii?Q?dgy+nO3KhJ252DUi7tKr2QCWyW2Bj9nP7kepwXgnbFhWB7SXkDVEApfEUgn1?=
 =?us-ascii?Q?rc6ouM+N2NgBEnJyvnKn2yeQ1pmJv7v0Sm7C8XMvm+wvTrImiMwyxuh5HGpv?=
 =?us-ascii?Q?SO4Lj+EJ0+CcywSdyldOKGdP/hbuVlsMwXYxKe5SzgHswLxJKkCGA5725+Z/?=
 =?us-ascii?Q?C76TzHKt3rfSUCaay/0sjjXGi4gr1Q/csSZTgGcOqm7b3bHC0BzWkuoEozCr?=
 =?us-ascii?Q?q4vQDVLbCqlq2c0l8zPnqQXx9gNRRzUnKWScyb7SzvBcuT7HK37YXagGZ+IR?=
 =?us-ascii?Q?mcb1/rdnMgf4m1v0ycsPTr1O6YAbdCePuxPWB9NKhnIbcTOfoLPvSgYjTvEx?=
 =?us-ascii?Q?jqWus9WaTHhs7LdHRHtbAtMfmIhBHRrBWNmcTtPwcYX+8lKlLarAJi5HX2SJ?=
 =?us-ascii?Q?UdNGL8Tn0yTscgTksVz2NyRwUGkcj9WuwC9H6hs2TmK0VXh/3ItAB0wfAt33?=
 =?us-ascii?Q?ybP6z4AAsEyQy1GaMdXG+bbmn9Kz/ImSS3Buuza05xTWEx3+fTKBKKKmvK49?=
 =?us-ascii?Q?74S8Ax7/DxkqNJRgcs9eiFj0?=
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4075.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ad187238-d461-4dc1-2198-08d8dc94beee
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Mar 2021 09:31:08.8925 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: G4PXCOmg3XklPtD6qWyAdn6merOT4TEc82x/iNQnaUlHEf1r7cAGxXbLJUX+TwLjR3YtzMPESx9Ow3VkX7ypdA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3180
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

+	for (i = TA_FW_TYPE_PSP_ASD; i < TA_FW_TYPE_PSP_COUNT; i++) {

I think we still rely on AMDGPU_INFO_FW_ASD to query ASD firmware version. Therefore, we need to start from TA_FW_TYPE_PSP_XGMI.

+	TA_FW_TYPE_PSP_COUNT,
+	static const char *ta_fw_name[TA_FW_TYPE_PSP_COUNT]

The enum is a little bit confusing, might rename to TA_FW_TYPE_MAX_INDEX, 

Regards,
Hawking

-----Original Message-----
From: Wang, Kevin(Yang) <Kevin1.Wang@amd.com> 
Sent: Monday, March 1, 2021 17:10
To: amd-gfx@lists.freedesktop.org
Cc: Zhang, Hawking <Hawking.Zhang@amd.com>; Wang, Kevin(Yang) <Kevin1.Wang@amd.com>
Subject: [PATCH 1/2] drm/amdgpu: refine PSP TA firmware info print in debugfs

refine PSP TA firmware info print in amdgpu_firmware_info().

Signed-off-by: Kevin Wang <kevin1.wang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c   | 50 +++++++++--------------
 drivers/gpu/drm/amd/amdgpu/amdgpu_ucode.h |  1 +
 2 files changed, 21 insertions(+), 30 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
index 6c8ea9d26320..1a27673271b0 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
@@ -289,23 +289,23 @@ static int amdgpu_firmware_info(struct drm_amdgpu_info_firmware *fw_info,
 		break;
 	case AMDGPU_INFO_FW_TA:
 		switch (query_fw->index) {
-		case 0:
+		case TA_FW_TYPE_PSP_XGMI:
 			fw_info->ver = adev->psp.ta_fw_version;
 			fw_info->feature = adev->psp.ta_xgmi_ucode_version;
 			break;
-		case 1:
+		case TA_FW_TYPE_PSP_RAS:
 			fw_info->ver = adev->psp.ta_fw_version;
 			fw_info->feature = adev->psp.ta_ras_ucode_version;
 			break;
-		case 2:
+		case TA_FW_TYPE_PSP_HDCP:
 			fw_info->ver = adev->psp.ta_fw_version;
 			fw_info->feature = adev->psp.ta_hdcp_ucode_version;
 			break;
-		case 3:
+		case TA_FW_TYPE_PSP_DTM:
 			fw_info->ver = adev->psp.ta_fw_version;
 			fw_info->feature = adev->psp.ta_dtm_ucode_version;
 			break;
-		case 4:
+		case TA_FW_TYPE_PSP_RAP:
 			fw_info->ver = adev->psp.ta_fw_version;
 			fw_info->feature = adev->psp.ta_rap_ucode_version;
 			break;
@@ -1355,6 +1355,17 @@ static int amdgpu_debugfs_firmware_info_show(struct seq_file *m, void *unused)
 	struct atom_context *ctx = adev->mode_info.atom_context;
 	int ret, i;
 
+	static const char *ta_fw_name[TA_FW_TYPE_PSP_COUNT] = { #define 
+TA_FW_NAME(type) [TA_FW_TYPE_PSP_##type] = #type
+		TA_FW_NAME(ASD),
+		TA_FW_NAME(XGMI),
+		TA_FW_NAME(RAS),
+		TA_FW_NAME(HDCP),
+		TA_FW_NAME(DTM),
+		TA_FW_NAME(RAP),
+#undef TA_FW_NAME
+	};
+
 	/* VCE */
 	query_fw.fw_type = AMDGPU_INFO_FW_VCE;
 	ret = amdgpu_firmware_info(&fw_info, &query_fw, adev); @@ -1472,35 +1483,14 @@ static int amdgpu_debugfs_firmware_info_show(struct seq_file *m, void *unused)
 		   fw_info.feature, fw_info.ver);
 
 	query_fw.fw_type = AMDGPU_INFO_FW_TA;
-	for (i = 0; i < 5; i++) {
+	for (i = TA_FW_TYPE_PSP_ASD; i < TA_FW_TYPE_PSP_COUNT; i++) {
 		query_fw.index = i;
 		ret = amdgpu_firmware_info(&fw_info, &query_fw, adev);
 		if (ret)
 			continue;
-		switch (query_fw.index) {
-		case 0:
-			seq_printf(m, "TA %s feature version: 0x%08x, firmware version: 0x%08x\n",
-					"RAS", fw_info.feature, fw_info.ver);
-			break;
-		case 1:
-			seq_printf(m, "TA %s feature version: 0x%08x, firmware version: 0x%08x\n",
-					"XGMI", fw_info.feature, fw_info.ver);
-			break;
-		case 2:
-			seq_printf(m, "TA %s feature version: 0x%08x, firmware version: 0x%08x\n",
-					"HDCP", fw_info.feature, fw_info.ver);
-			break;
-		case 3:
-			seq_printf(m, "TA %s feature version: 0x%08x, firmware version: 0x%08x\n",
-					"DTM", fw_info.feature, fw_info.ver);
-			break;
-		case 4:
-			seq_printf(m, "TA %s feature version: 0x%08x, firmware version: 0x%08x\n",
-					"RAP", fw_info.feature, fw_info.ver);
-			break;
-		default:
-			return -EINVAL;
-		}
+
+		seq_printf(m, "TA %s feature version: 0x%08x, firmware version: 0x%08x\n",
+			   ta_fw_name[i], fw_info.feature, fw_info.ver);
 	}
 
 	/* SMC */
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ucode.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_ucode.h
index 46449e70348b..c03f32ec3ebc 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ucode.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ucode.h
@@ -136,6 +136,7 @@ enum ta_fw_type {
 	TA_FW_TYPE_PSP_DTM,
 	TA_FW_TYPE_PSP_RAP,
 	TA_FW_TYPE_PSP_SECUREDISPLAY,
+	TA_FW_TYPE_PSP_COUNT,
 };
 
 struct ta_fw_bin_desc {
--
2.17.1
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
