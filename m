Return-Path: <SRS0=W/Sk=6I=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34AADC55186
	for <amd-gfx@archiver.kernel.org>; Fri, 24 Apr 2020 03:39:08 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D78F020706
	for <amd-gfx@archiver.kernel.org>; Fri, 24 Apr 2020 03:39:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="KE3E+Ext"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D78F020706
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 85A706E428;
	Fri, 24 Apr 2020 03:39:07 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2078.outbound.protection.outlook.com [40.107.220.78])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D47CE6E428
 for <amd-gfx@lists.freedesktop.org>; Fri, 24 Apr 2020 03:39:05 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SITYQnzuI35g32/4c2uSysXuPk4Wmu/sxADhw3QRUCEclT4ruQqM4o+84eS6M+xpUhql9aoUC18Ry6o1U/+VYCnzDKKQRe0H0iC1qpMmc4U+lW1eVRaX9n0zge1p8qGO35pnKW917asbB3T9pDyyXi90SP6UzBTmqVwcShXzssz43HBceMISiVh9ZcEMXcvBF4cgfBRm/rR/V385ePxZ8YSBp10jUfpGfaourLRgWe+vnfQQ5DBpoNsiLfjpoNXSI57GUllPB8jpISG0JyDKiPfV5LELX32ByAamCIJDPgU+VorYcZeNBBC84wnar03f6K+Q2zKECX7jARR8GvHDrQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=58AfUj/XFSr/WnvFGDSpSER+ixrsoryWhglEI4Z69jk=;
 b=Vx5Tz6IOo4Rn5zyoGeEynksVWiSAVi85BOa3T6k3QSyNvfEDRIIbDGU+0yUVO1xntWpSyai3tmFdQpcTp2ekXIMLuS+j/R7M4uvN5XaRv1TWlvyZVpUPSKADW6iSlTAvB0nDmK1GWOJ7N39AHnVlhWKMGWPlPVR1F8HHlA58O0cLIIqRaiQhCQJbGQC3UcDzbQpTtO+VyjmdmyCUd32aoRlD8Gxtulf5jXZJlajCRTUTAx2FQ7C0opQ5DUI0wAXVlrH9eyHXKsn59ToLtAcDGbRQY56cBIhbQZBLfER9T3IQ8WFQ9ghU0UrqyijVLTOzSOSdKGTmtPeqRQmPiVbf+Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=58AfUj/XFSr/WnvFGDSpSER+ixrsoryWhglEI4Z69jk=;
 b=KE3E+ExtP19Tq34nuKvi860l9tNbhkXpls/XapaAoDeQBQhlf0O2yuCeN0r+c+BtOrN5TGSsikGKUI9QrPaZZpb+SQGGWQXAzidB29T80Pph38s37KkcuoO9cVQBao7Xd9R5+Ay3tm3YRekLvHg8SSJO6AHtEPG24ML6uQ0vaZ8=
Received: from DM6PR12MB2619.namprd12.prod.outlook.com (2603:10b6:5:45::18) by
 DM6PR12MB2635.namprd12.prod.outlook.com (2603:10b6:5:45::23) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2937.13; Fri, 24 Apr 2020 03:39:01 +0000
Received: from DM6PR12MB2619.namprd12.prod.outlook.com
 ([fe80::5c27:185c:be20:1fb6]) by DM6PR12MB2619.namprd12.prod.outlook.com
 ([fe80::5c27:185c:be20:1fb6%5]) with mapi id 15.20.2921.030; Fri, 24 Apr 2020
 03:39:01 +0000
From: "Quan, Evan" <Evan.Quan@amd.com>
To: "Liu, Monk" <Monk.Liu@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH 6/8] drm/amdgpu: enable one vf mode for nv12
Thread-Topic: [PATCH 6/8] drm/amdgpu: enable one vf mode for nv12
Thread-Index: AQHWGT0c8BnF2EWRqkuFawh2TsOqUqiHn7dA
Date: Fri, 24 Apr 2020 03:39:01 +0000
Message-ID: <DM6PR12MB261961E290BF026BD39ECABAE4D00@DM6PR12MB2619.namprd12.prod.outlook.com>
References: <1587625306-20704-1-git-send-email-Monk.Liu@amd.com>
 <1587625306-20704-6-git-send-email-Monk.Liu@amd.com>
In-Reply-To: <1587625306-20704-6-git-send-email-Monk.Liu@amd.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ActionId=92d64d08-d8e8-4bc9-b0ba-0000c46892b1;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ContentBits=0;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Enabled=true;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Method=Standard;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Name=Internal
 Use Only - Unrestricted;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SetDate=2020-04-24T03:33:19Z;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Evan.Quan@amd.com; 
x-originating-ip: [58.247.170.242]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 3b4b51cf-5331-4440-9c79-08d7e801075c
x-ms-traffictypediagnostic: DM6PR12MB2635:|DM6PR12MB2635:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM6PR12MB263569F6E0A95917AC13D689E4D00@DM6PR12MB2635.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6430;
x-forefront-prvs: 03838E948C
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB2619.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(346002)(39860400002)(366004)(376002)(136003)(396003)(66556008)(26005)(66476007)(66946007)(81156014)(7696005)(4326008)(76116006)(6506007)(2906002)(8936002)(8676002)(186003)(86362001)(71200400001)(53546011)(55016002)(9686003)(110136005)(52536014)(66446008)(64756008)(478600001)(33656002)(45080400002)(966005)(316002)(5660300002);
 DIR:OUT; SFP:1101; 
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: XlLdck2hmXYFz345Riph4wwlm1NWEz8G+OFV40tPmugOBQ3z8OFhibmgU55LRzbx8GFrPY/iaqywb3RDk2Mpc4B4J+nmMD2vEvxouIDXINo98QAKG8hahj+FBHLawSiQ1C9CggxpJI/AALQam8jyh5vF/R3YRI1jglxBgRvVXl8dEUZQSZrzUmAHWgMWSt6GfaiaOtdn8gbsWyQqRdhjUBwl9seQiLU8uaAnkks8GTGwS3L08V88j+DgK0TaKQ0foxOs0zW1G2IEt9fwnDwWRUb5XRavNEXETYPMhP9oio/brMbFQGvIPUJyixEXDTmm/sG2QIEsvDhnWzA6aQAx7KlglC0M2yiamafAtl8fcEiMN2VfB5auwcOvYrm1NhA8r9iftsihaWzQLzd9Wp1fAoLYdXV9k4+iWD/llQe+TaBUSe39S6zkfsiuntwFxNsl3sxf56PMFZPtjh8ZfbW18uI8KUNabpQ3RQqs8T5CllM=
x-ms-exchange-antispam-messagedata: ND7HBlXrfdgsjwY7oJbrieeCsnPcjmB2K0iXS0haJ+PWTjAAG/XnXmOVe2b0ltCRKi/DM+EQ1R8iQ/zj6pnECoaN6dXRjGKtutlJR3HIcJjvjddZl6Ju2uLtcQGhj61W3QjIuQes0ieSBKW3xIT79Q==
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3b4b51cf-5331-4440-9c79-08d7e801075c
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Apr 2020 03:39:01.1296 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: GmFXxyUMF9hP41SU3zMMxDgwvm9tizMR0H5aZiw2ryb9EMQ13aostzpKH1AVHD0o
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB2635
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
Cc: "Liu, Monk" <Monk.Liu@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>



-----Original Message-----
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Monk Liu
Sent: Thursday, April 23, 2020 3:02 PM
To: amd-gfx@lists.freedesktop.org
Cc: Liu, Monk <Monk.Liu@amd.com>
Subject: [PATCH 6/8] drm/amdgpu: enable one vf mode for nv12

Signed-off-by: Monk Liu <Monk.Liu@amd.com>
---
 drivers/gpu/drm/amd/powerplay/amdgpu_smu.c | 12 +++-----  drivers/gpu/drm/amd/powerplay/navi10_ppt.c |  6 +++-  drivers/gpu/drm/amd/powerplay/smu_v11_0.c  | 49 +++++++++++++++++++++++++-----
 3 files changed, 52 insertions(+), 15 deletions(-)

diff --git a/drivers/gpu/drm/amd/powerplay/amdgpu_smu.c b/drivers/gpu/drm/amd/powerplay/amdgpu_smu.c
index 361a5b6..5964d63 100644
--- a/drivers/gpu/drm/amd/powerplay/amdgpu_smu.c
+++ b/drivers/gpu/drm/amd/powerplay/amdgpu_smu.c
@@ -347,13 +347,13 @@ int smu_get_dpm_freq_by_index(struct smu_context *smu, enum smu_clk_type clk_typ
 	param = (uint32_t)(((clk_id & 0xffff) << 16) | (level & 0xffff));
 
 	ret = smu_send_smc_msg_with_param(smu, SMU_MSG_GetDpmFreqByIndex,
-					  param, &param);
+					  param, value);
 	if (ret)
 		return ret;
 
 	/* BIT31:  0 - Fine grained DPM, 1 - Dicrete DPM
 	 * now, we un-support it */
-	*value = param & 0x7fffffff;
+	*value = *value & 0x7fffffff;
 
 	return ret;
 }
@@ -535,7 +535,6 @@ int smu_update_table(struct smu_context *smu, enum smu_table_id table_index, int
 	int table_id = smu_table_get_index(smu, table_index);
 	uint32_t table_size;
 	int ret = 0;
-
 	if (!table_data || table_id >= SMU_TABLE_COUNT || table_id < 0)
 		return -EINVAL;
 
@@ -691,7 +690,6 @@ int smu_feature_is_enabled(struct smu_context *smu, enum smu_feature_mask mask)
 
 	if (smu->is_apu)
 		return 1;
-
 	feature_id = smu_feature_get_index(smu, mask);
 	if (feature_id < 0)
 		return 0;
@@ -1339,6 +1337,9 @@ static int smu_hw_init(void *handle)
 	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
 	struct smu_context *smu = &adev->smu;
 
+	if (amdgpu_sriov_vf(adev) && !amdgpu_sriov_is_pp_one_vf(adev))
+		return 0;
+
 	ret = smu_start_smc_engine(smu);
 	if (ret) {
 		pr_err("SMU is not ready yet!\n");
@@ -1352,9 +1353,6 @@ static int smu_hw_init(void *handle)
 		smu_set_gfx_cgpg(&adev->smu, true);
 	}
 
-	if (amdgpu_sriov_vf(adev) && !amdgpu_sriov_is_pp_one_vf(adev))
-		return 0;
-
 	if (!smu->pm_enabled)
 		return 0;
 
diff --git a/drivers/gpu/drm/amd/powerplay/navi10_ppt.c b/drivers/gpu/drm/amd/powerplay/navi10_ppt.c
index c94270f..2184d24 100644
--- a/drivers/gpu/drm/amd/powerplay/navi10_ppt.c
+++ b/drivers/gpu/drm/amd/powerplay/navi10_ppt.c
@@ -1817,7 +1817,8 @@ static int navi10_get_power_limit(struct smu_context *smu,
 	int power_src;
 
 	if (!smu->power_limit) {
-		if (smu_feature_is_enabled(smu, SMU_FEATURE_PPT_BIT)) {
+		if (smu_feature_is_enabled(smu, SMU_FEATURE_PPT_BIT) &&
+			!amdgpu_sriov_vf(smu->adev)) {
 			power_src = smu_power_get_index(smu, SMU_POWER_SOURCE_AC);
 			if (power_src < 0)
 				return -EINVAL;
@@ -1960,6 +1961,9 @@ static int navi10_set_default_od_settings(struct smu_context *smu, bool initiali
 	OverDriveTable_t *od_table, *boot_od_table;
 	int ret = 0;
 
+	if (amdgpu_sriov_vf(smu->adev))
+		return 0;
+
 	ret = smu_v11_0_set_default_od_settings(smu, initialize, sizeof(OverDriveTable_t));
 	if (ret)
 		return ret;
diff --git a/drivers/gpu/drm/amd/powerplay/smu_v11_0.c b/drivers/gpu/drm/amd/powerplay/smu_v11_0.c
index a97b296..3e1b3ed 100644
--- a/drivers/gpu/drm/amd/powerplay/smu_v11_0.c
+++ b/drivers/gpu/drm/amd/powerplay/smu_v11_0.c
@@ -57,7 +57,7 @@ static int smu_v11_0_send_msg_without_waiting(struct smu_context *smu,
 					      uint16_t msg)
 {
 	struct amdgpu_device *adev = smu->adev;
-	WREG32_SOC15(MP1, 0, mmMP1_SMN_C2PMSG_66, msg);
+	WREG32_SOC15_NO_KIQ(MP1, 0, mmMP1_SMN_C2PMSG_66, msg);
 	return 0;
 }
 
@@ -65,7 +65,7 @@ static int smu_v11_0_read_arg(struct smu_context *smu, uint32_t *arg)  {
 	struct amdgpu_device *adev = smu->adev;
 
-	*arg = RREG32_SOC15(MP1, 0, mmMP1_SMN_C2PMSG_82);
+	*arg = RREG32_SOC15_NO_KIQ(MP1, 0, mmMP1_SMN_C2PMSG_82);
 	return 0;
 }
 
@@ -75,7 +75,7 @@ static int smu_v11_0_wait_for_response(struct smu_context *smu)
 	uint32_t cur_value, i, timeout = adev->usec_timeout * 10;
 
 	for (i = 0; i < timeout; i++) {
-		cur_value = RREG32_SOC15(MP1, 0, mmMP1_SMN_C2PMSG_90);
+		cur_value = RREG32_SOC15_NO_KIQ(MP1, 0, mmMP1_SMN_C2PMSG_90);
 		if ((cur_value & MP1_C2PMSG_90__CONTENT_MASK) != 0)
 			return cur_value == 0x1 ? 0 : -EIO;
 
@@ -83,7 +83,10 @@ static int smu_v11_0_wait_for_response(struct smu_context *smu)
 	}
 
 	/* timeout means wrong logic */
-	return -ETIME;
+	if (i == timeout)
+		return -ETIME;
+
+	return RREG32_SOC15_NO_KIQ(MP1, 0, mmMP1_SMN_C2PMSG_90) == 0x1 ? 0 : 
+-EIO;
 }
[Evan] This is redundant. As original logics already cover this.
 
 int
@@ -107,9 +110,9 @@ smu_v11_0_send_msg_with_param(struct smu_context *smu,
 		goto out;
 	}
 
-	WREG32_SOC15(MP1, 0, mmMP1_SMN_C2PMSG_90, 0);
+	WREG32_SOC15_NO_KIQ(MP1, 0, mmMP1_SMN_C2PMSG_90, 0);
 
-	WREG32_SOC15(MP1, 0, mmMP1_SMN_C2PMSG_82, param);
+	WREG32_SOC15_NO_KIQ(MP1, 0, mmMP1_SMN_C2PMSG_82, param);
 
 	smu_v11_0_send_msg_without_waiting(smu, (uint16_t)index);
 
@@ -119,6 +122,7 @@ smu_v11_0_send_msg_with_param(struct smu_context *smu,
 		       smu_get_message_name(smu, msg), index, param, ret);
 		goto out;
 	}
+
 	if (read_arg) {
 		ret = smu_v11_0_read_arg(smu, read_arg);
 		if (ret) {
@@ -728,8 +732,9 @@ int smu_v11_0_parse_pptable(struct smu_context *smu)
 	struct smu_table_context *table_context = &smu->smu_table;
 	struct smu_table *table = &table_context->tables[SMU_TABLE_PPTABLE];
 
+	/* during TDR we need to free and alloc the pptable */
 	if (table_context->driver_pptable)
-		return -EINVAL;
+		kfree(table_context->driver_pptable);
 
 	table_context->driver_pptable = kzalloc(table->size, GFP_KERNEL);
 
@@ -769,6 +774,9 @@ int smu_v11_0_set_deep_sleep_dcefclk(struct smu_context *smu, uint32_t clk)  {
 	int ret;
 
+	if (amdgpu_sriov_vf(smu->adev))
+		return 0;
+
 	ret = smu_send_smc_msg_with_param(smu,
 					  SMU_MSG_SetMinDeepSleepDcefclk, clk, NULL);
 	if (ret)
@@ -812,6 +820,9 @@ int smu_v11_0_set_tool_table_location(struct smu_context *smu)
 	int ret = 0;
 	struct smu_table *tool_table = &smu->smu_table.tables[SMU_TABLE_PMSTATUSLOG];
 
+	if (amdgpu_sriov_vf(smu->adev))
+		return 0;
+
 	if (tool_table->mc_address) {
 		ret = smu_send_smc_msg_with_param(smu,
 				SMU_MSG_SetToolsDramAddrHigh,
@@ -831,6 +842,12 @@ int smu_v11_0_init_display_count(struct smu_context *smu, uint32_t count)  {
 	int ret = 0;
 
+	if (amdgpu_sriov_vf(smu->adev))
+		return 0;
+
+	if (!smu->pm_enabled)
+		return ret;
[Evan] I think this will get display count setting skipped on baremetal since pm_enabled is always false before hw_init finished.
Please double confirm and make sure this does not break baremetal.
+
 	ret = smu_send_smc_msg_with_param(smu, SMU_MSG_NumOfDisplays, count, NULL);
 	return ret;
 }
@@ -842,6 +859,9 @@ int smu_v11_0_set_allowed_mask(struct smu_context *smu)
 	int ret = 0;
 	uint32_t feature_mask[2];
 
+	if (amdgpu_sriov_vf(smu->adev))
+		return 0;
+
 	mutex_lock(&feature->mutex);
 	if (bitmap_empty(feature->allowed, SMU_FEATURE_MAX) || feature->feature_num < 64)
 		goto failed;
@@ -870,6 +890,9 @@ int smu_v11_0_get_enabled_mask(struct smu_context *smu,
 	struct smu_feature *feature = &smu->smu_feature;
 	int ret = 0;
 
+	if (amdgpu_sriov_vf(smu->adev) && !amdgpu_sriov_is_pp_one_vf(smu->adev))
+		return 0;
+
 	if (!feature_mask || num < 2)
 		return -EINVAL;
 
@@ -925,6 +948,12 @@ int smu_v11_0_notify_display_change(struct smu_context *smu)  {
 	int ret = 0;
 
+	if (amdgpu_sriov_vf(smu->adev))
+		return 0;
+
+	if (!smu->pm_enabled)
+		return ret;
[Evan] Same as smu_v11_0_init_display_count.
+
 	if (smu_feature_is_enabled(smu, SMU_FEATURE_DPM_UCLK_BIT) &&
 	    smu->adev->gmc.vram_type == AMDGPU_VRAM_TYPE_HBM)
 		ret = smu_send_smc_msg_with_param(smu, SMU_MSG_SetUclkFastSwitch, 1, NULL); @@ -1084,6 +1113,9 @@ int smu_v11_0_set_power_limit(struct smu_context *smu, uint32_t n)
 	int ret = 0;
 	uint32_t max_power_limit;
 
+	if (amdgpu_sriov_vf(smu->adev))
+		return 0;
+
 	max_power_limit = smu_v11_0_get_max_power_limit(smu);
 
 	if (n > max_power_limit) {
@@ -1809,6 +1841,9 @@ int smu_v11_0_override_pcie_parameters(struct smu_context *smu)
 	uint32_t pcie_gen = 0, pcie_width = 0;
 	int ret;
 
+	if (amdgpu_sriov_vf(smu->adev))
+		return 0;
+
 	if (adev->pm.pcie_gen_mask & CAIL_PCIE_LINK_SPEED_SUPPORT_GEN4)
 		pcie_gen = 3;
 	else if (adev->pm.pcie_gen_mask & CAIL_PCIE_LINK_SPEED_SUPPORT_GEN3)
--
2.7.4

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Flists.freedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;data=02%7C01%7Cevan.quan%40amd.com%7C3241a6478c6b451e12d408d7e7543931%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637232221317924807&amp;sdata=ANSnKbPwZeAOYdEGdHOM8ZuWhXlilA9CXjnCjhmx6wU%3D&amp;reserved=0
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
