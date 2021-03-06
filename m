Return-Path: <SRS0=7qc2=IE=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79030C433E0
	for <amd-gfx@archiver.kernel.org>; Sat,  6 Mar 2021 21:20:28 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0A5DF64DFF
	for <amd-gfx@archiver.kernel.org>; Sat,  6 Mar 2021 21:20:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0A5DF64DFF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AC06A6E07F;
	Sat,  6 Mar 2021 21:20:27 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2076.outbound.protection.outlook.com [40.107.244.76])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0B10C6E07F
 for <amd-gfx@lists.freedesktop.org>; Sat,  6 Mar 2021 21:20:26 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bUmf1SbvCD//4cW16dQcXDWnViS4hgspcOm/D8a3vrO5tIOeMR7UIz+alKed4PUbMTVO+84CaDUJM+avchcON/Qcpqk7RT7dxDnavilxTmATkCGXYtcK00r/ms095O8gC85UY6uyPOBz9vYMThYjjKc2EIOKQWeG6iPsnDx9Eep9q207G8ttLVZ/VGWha4yAN3yx02gdTIOcYD4NiT+h6pUxeiIEav7Yrsq73y5zR65rpt3ekVuEo6tq4MP/96vfh/lkNBUmo2LlMZcZUodx6gQXStitMqItbjqAvQrqzBtgkx2u9jS0lj6vkygRISeEz7A/TWgJKTQ2PVXTTVtoDw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=q+bej26VD/P19yTQgYGezChXiROZL36B7uRAkfUbVzY=;
 b=oekn2QwKwVLq4udfg6L7N97jvlfT5EPyIGf/k9ihA44Atku++VY9wr1PnR5OqmQpVu1bIWVMLVAzsh+0Uwy3uBAKKq81AKrzBR0QBl8z5JOI2ON7rbizQ8QnMswfJiXiTJKP+ZlzhcLwKfvzFz9wqOk7yj2TKHjOcttttJU3iy/11O2h8Tkn72vQmiaLgrAoOD6wH7p6KGOOhVasnkfeZYNqpR4Y7vx0ifGYzKa0MOUpP5v04Dgn/DlLDbTlKidkaT7Lv5cAbNzu5qxZJ/WH75iHyuX/Cl/5adV3AAdVyTOlVHL9XkI5YhuvqIcaZGdFmKOS5DCCrOeIe92oQ2LUEA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=q+bej26VD/P19yTQgYGezChXiROZL36B7uRAkfUbVzY=;
 b=d1M1WzzQacGwNIOWBLnunxAFfL7ChHBucJKHYGPKgHriCvY3S3H7YB15Cep1wCvB/KYjqkhH9ON8nejiLlXIwnOW/sNP97zTwTulPNcgGrwUnuDcvHAbhXz3vBqX4XnuIdjvr9EZw09nqKBR5YXLnOHseTXYwDru7NZ2HAd7jqs=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB3835.namprd12.prod.outlook.com (2603:10b6:5:1c7::12)
 by DM6PR12MB2809.namprd12.prod.outlook.com (2603:10b6:5:4a::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3890.28; Sat, 6 Mar
 2021 21:20:23 +0000
Received: from DM6PR12MB3835.namprd12.prod.outlook.com
 ([fe80::102:2c9a:54ce:63e9]) by DM6PR12MB3835.namprd12.prod.outlook.com
 ([fe80::102:2c9a:54ce:63e9%6]) with mapi id 15.20.3912.025; Sat, 6 Mar 2021
 21:20:23 +0000
From: shaoyunl <shaoyun.liu@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 4/5] drm/amdgpu: Add reset_list for device list used for reset
Date: Sat,  6 Mar 2021 16:20:06 -0500
Message-Id: <20210306212006.14368-1-shaoyun.liu@amd.com>
X-Mailer: git-send-email 2.17.1
X-Originating-IP: [165.204.55.250]
X-ClientProxiedBy: YT1PR01CA0138.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:2f::17) To DM6PR12MB3835.namprd12.prod.outlook.com
 (2603:10b6:5:1c7::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from shaoyunl-dev1.amd.com (165.204.55.250) by
 YT1PR01CA0138.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:2f::17) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3912.26 via Frontend Transport; Sat, 6 Mar 2021 21:20:22 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 0385405b-f23b-45b6-2266-08d8e0e5a702
X-MS-TrafficTypeDiagnostic: DM6PR12MB2809:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR12MB28090C544CBCCDC298BB98D4F4959@DM6PR12MB2809.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: +inudZ1rAsGs+NbRTfUAbbxZ/p44ML1ZoYK48rdBxxgJ7U3TKiZVaqWi3NOJB1smUkqTcS005J1zcmdjdTPOyI/YkZped006FNiMz9ydRH/x/SUE1CraKJx5+eMDa11CgxMyy4SRo06W+4BJWtLRt2kGULvSnFr2Mv6L2Pby+stnnaUWUg0hEmRa18S5h+Pe/fBqigjFZAifJd62oTPA+V57ymfDpe8OwH90rpORfljaVMkT3xrVUxRZh02ODLYwDQC3ZIedv8wph9fVZKmWprHrFKZp+fSFJ2dRRDY1MItUHw1FGXmECucrZWpFZTbtmQqxAkrbScZfoDVdBvH+yIo7vW/Mi+tg7NKZe+V+85aZ7XBYWWkUIyexTzuGOkFq//BU5jC8EJCi1r/dHNNExHSDlm78Z+fUncRCqocj4W6TOFmURFtWuUwdolkzgckrKF8S54knZwGSNkEGuKXdsGcz//51AkDLdt3UW9WSW43nQI9sKYXA3oU0i1LfkmRvmjG7pxchwXLgUyQprv/d7+a3UVdGHDCmPJaTEMzv0+FESNy90XwVX7Aeh64A5Api
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB3835.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(376002)(346002)(136003)(396003)(366004)(39860400002)(316002)(66476007)(83380400001)(6916009)(66556008)(7696005)(2616005)(66946007)(956004)(52116002)(186003)(6486002)(478600001)(6666004)(86362001)(36756003)(2906002)(5660300002)(1076003)(16526019)(8936002)(8676002)(4326008)(26005)(43062004);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?wIAGlNpJL0Scv5G5BYdyyhs4YNWEMmNxg1avjVSbMO4A91d2/X6HvHMZKVe2?=
 =?us-ascii?Q?T7hCW4QqOf2k66crV09aTP3KE9C2e2Ni79zW1+r40J/YKAs31L/9wuK9vLBP?=
 =?us-ascii?Q?fYQhsEt1njWu6m7vHEWAG6j7C8v+xKbZDhPLqe5iHer3j4pdaVLOpSgRnpRr?=
 =?us-ascii?Q?XBX01tN2fY8oH7uioEf23lTYtGMYj2EdffwMxKB/VBHETCB5TZPokqdmfjtA?=
 =?us-ascii?Q?jTpFg9poP2Ay/NSBXZqa5xmRGfVgfWcRO0EsEBnILVJxLYbDXlgfcMv5rz8o?=
 =?us-ascii?Q?bvUAqLV+7xe1oW4MSW5eWIwBxlV3XKbLqittCli7uBA6SRe+RIS6mKR/lxMY?=
 =?us-ascii?Q?zPt4a8ucmzoG5drOdlI4NVvH33w44UbOh+/RGh0IK5HEX2E+nzjRTCxFGsf6?=
 =?us-ascii?Q?st7GC+2XOWsuZzqxZrnup5U6if3Va46iddWVcUCIfdiaS+z7QMSLSNt71IgC?=
 =?us-ascii?Q?FmbCvQwOJ7USmDiBmz5fmluKF8qyS+Dkn02cDeInpj9WHuJOqRq0SHnqFdOw?=
 =?us-ascii?Q?/Z9ZwCHod/9BI5SfwLfW34PiC93Fo4uKDVF2HROktA45aW5oWw1zuFFBIi6k?=
 =?us-ascii?Q?zTBOANydOVk5jREyktbcSbx27uOweFMWW5jLubMioxBG/GSfXacatDZ3c2w8?=
 =?us-ascii?Q?ZYXzXPBIGyfSIliRx/6L/JGLqBlvBd6WuAuM/NdGwSyvARppkKjXtcqqjgxd?=
 =?us-ascii?Q?Uj7cwZlz0PHdSCP8kkfdyGmOPyvY2LSu3RSXRI4DTZfB0F6xRaFJG5wGePum?=
 =?us-ascii?Q?IOOagE8CgWkiwhwZUQ6FYW6JVmjH53mtsoifjIwEvN2GUT7hYupLniyP8prK?=
 =?us-ascii?Q?Wcvo99KYXmKOA1eKNIINnDLcsRNOFect6ReiYQ6O/LmCyzCUoRxevWA/9aOZ?=
 =?us-ascii?Q?pwWclJBLt/t2AJQW0NSvYm80K9vbTb72k2zu7JVWY0za7oWjNiSaJbLv7zkm?=
 =?us-ascii?Q?x9NDhLa/+iFraTEkiqe1syHOi/xDrjs8yI66cJ+CDoSn1RlOeY9B1012vrKN?=
 =?us-ascii?Q?nWGS/zConDm+OR4XNpkBvdfVxnMJFp5b+1ADa6hhBiHiw3RMkyW4VhJpUU2f?=
 =?us-ascii?Q?WX4lc4GXkalCTdoamEhFa77nNeJlh3mB4s7OsORmc/9xZwu3EkwSACmc0Q9n?=
 =?us-ascii?Q?Jw2t8NH6BOQ7Sft06HbJVqb4geAO9dHCP4TcY00+AVquysdcZ51fjYDh/s7H?=
 =?us-ascii?Q?cQonVYeeETDPiE5a6BFBSuIphQrmd5tialVOhUBojtmI1dE5GEWvq+7UlCqv?=
 =?us-ascii?Q?bu0m4AckB6SE5HBilIemCJfW3SctKZwV0987MDYt1Z9qcbTUMwx8O6tEeB7z?=
 =?us-ascii?Q?BrpyXSbcqIFM6kjVndckoJT3?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0385405b-f23b-45b6-2266-08d8e0e5a702
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3835.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Mar 2021 21:20:23.0480 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Kwlhu8Jn3J92T7IezBvTfqwXr+U8qFdP1idGngqNONcg43vHk5YC7be9id6Sax5fKYK5xVX9c/i+TIFBntARDg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB2809
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
Cc: shaoyunl <shaoyun.liu@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

The gmc.xgmi.head list originally is designed for device list in the XGMI hive. Mix use it
for reset purpose will prevent the reset function to adjust XGMI device list which is required
in next change

Signed-off-by: shaoyunl <shaoyun.liu@amd.com>
Change-Id: Ibbdf75c02836151adf5bb44186e6ced97dbf8c1d
---
 drivers/gpu/drm/amd/amdgpu/amdgpu.h        |  1 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 33 ++++++++++++----------
 2 files changed, 19 insertions(+), 15 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
index f01b75ec6c60..d46d3794699e 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
@@ -1040,6 +1040,7 @@ struct amdgpu_device {
 
 	int asic_reset_res;
 	struct work_struct		xgmi_reset_work;
+	struct list_head		reset_list;
 
 	long				gfx_timeout;
 	long				sdma_timeout;
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index 62d7ce621457..3c35b0c1e710 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -3290,6 +3290,8 @@ int amdgpu_device_init(struct amdgpu_device *adev,
 	INIT_LIST_HEAD(&adev->shadow_list);
 	mutex_init(&adev->shadow_list_lock);
 
+	INIT_LIST_HEAD(&adev->reset_list);
+
 	INIT_DELAYED_WORK(&adev->delayed_init_work,
 			  amdgpu_device_delayed_init_work_handler);
 	INIT_DELAYED_WORK(&adev->gfx.gfx_off_delay_work,
@@ -4301,11 +4303,11 @@ static int amdgpu_do_asic_reset(struct amdgpu_hive_info *hive,
 	int r = 0;
 
 	/*
-	 * ASIC reset has to be done on all HGMI hive nodes ASAP
+	 * ASIC reset has to be done on all XGMI hive nodes ASAP
 	 * to allow proper links negotiation in FW (within 1 sec)
 	 */
 	if (!skip_hw_reset && need_full_reset) {
-		list_for_each_entry(tmp_adev, device_list_handle, gmc.xgmi.head) {
+		list_for_each_entry(tmp_adev, device_list_handle, reset_list) {
 			/* For XGMI run all resets in parallel to speed up the process */
 			if (tmp_adev->gmc.xgmi.num_physical_nodes > 1) {
 				if (!queue_work(system_unbound_wq, &tmp_adev->xgmi_reset_work))
@@ -4322,8 +4324,7 @@ static int amdgpu_do_asic_reset(struct amdgpu_hive_info *hive,
 
 		/* For XGMI wait for all resets to complete before proceed */
 		if (!r) {
-			list_for_each_entry(tmp_adev, device_list_handle,
-					    gmc.xgmi.head) {
+			list_for_each_entry(tmp_adev, device_list_handle, reset_list) {
 				if (tmp_adev->gmc.xgmi.num_physical_nodes > 1) {
 					flush_work(&tmp_adev->xgmi_reset_work);
 					r = tmp_adev->asic_reset_res;
@@ -4335,7 +4336,7 @@ static int amdgpu_do_asic_reset(struct amdgpu_hive_info *hive,
 	}
 
 	if (!r && amdgpu_ras_intr_triggered()) {
-		list_for_each_entry(tmp_adev, device_list_handle, gmc.xgmi.head) {
+		list_for_each_entry(tmp_adev, device_list_handle, reset_list) {
 			if (tmp_adev->mmhub.funcs &&
 			    tmp_adev->mmhub.funcs->reset_ras_error_count)
 				tmp_adev->mmhub.funcs->reset_ras_error_count(tmp_adev);
@@ -4344,7 +4345,7 @@ static int amdgpu_do_asic_reset(struct amdgpu_hive_info *hive,
 		amdgpu_ras_intr_cleared();
 	}
 
-	list_for_each_entry(tmp_adev, device_list_handle, gmc.xgmi.head) {
+	list_for_each_entry(tmp_adev, device_list_handle, reset_list) {
 		if (need_full_reset) {
 			/* post card */
 			if (amdgpu_device_asic_init(tmp_adev))
@@ -4655,16 +4656,18 @@ int amdgpu_device_gpu_recover(struct amdgpu_device *adev,
 	 */
 	INIT_LIST_HEAD(&device_list);
 	if (adev->gmc.xgmi.num_physical_nodes > 1) {
-		if (!list_is_first(&adev->gmc.xgmi.head, &hive->device_list))
-			list_rotate_to_front(&adev->gmc.xgmi.head, &hive->device_list);
-		device_list_handle = &hive->device_list;
+		list_for_each_entry(tmp_adev, &hive->device_list, gmc.xgmi.head)
+			list_add_tail(&tmp_adev->reset_list, &device_list);
+		if (!list_is_first(&adev->reset_list, &device_list))
+			list_rotate_to_front(&adev->reset_list, &device_list);
+		device_list_handle = &device_list;
 	} else {
-		list_add_tail(&adev->gmc.xgmi.head, &device_list);
+		list_add_tail(&adev->reset_list, &device_list);
 		device_list_handle = &device_list;
 	}
 
 	/* block all schedulers and reset given job's ring */
-	list_for_each_entry(tmp_adev, device_list_handle, gmc.xgmi.head) {
+	list_for_each_entry(tmp_adev, device_list_handle, reset_list) {
 		/*
 		 * Try to put the audio codec into suspend state
 		 * before gpu reset started.
@@ -4729,7 +4732,7 @@ int amdgpu_device_gpu_recover(struct amdgpu_device *adev,
 	}
 
 retry:	/* Rest of adevs pre asic reset from XGMI hive. */
-	list_for_each_entry(tmp_adev, device_list_handle, gmc.xgmi.head) {
+	list_for_each_entry(tmp_adev, device_list_handle, reset_list) {
 		r = amdgpu_device_pre_asic_reset(tmp_adev,
 						 (tmp_adev == adev) ? job : NULL,
 						 &need_full_reset);
@@ -4756,7 +4759,7 @@ int amdgpu_device_gpu_recover(struct amdgpu_device *adev,
 skip_hw_reset:
 
 	/* Post ASIC reset for all devs .*/
-	list_for_each_entry(tmp_adev, device_list_handle, gmc.xgmi.head) {
+	list_for_each_entry(tmp_adev, device_list_handle, reset_list) {
 
 		for (i = 0; i < AMDGPU_MAX_RINGS; ++i) {
 			struct amdgpu_ring *ring = tmp_adev->rings[i];
@@ -4787,7 +4790,7 @@ int amdgpu_device_gpu_recover(struct amdgpu_device *adev,
 	}
 
 skip_sched_resume:
-	list_for_each_entry(tmp_adev, device_list_handle, gmc.xgmi.head) {
+	list_for_each_entry(tmp_adev, device_list_handle, reset_list) {
 		/* unlock kfd: SRIOV would do it separately */
 		if (!need_emergency_restart && !amdgpu_sriov_vf(tmp_adev))
 	                amdgpu_amdkfd_post_reset(tmp_adev);
@@ -5108,7 +5111,7 @@ pci_ers_result_t amdgpu_pci_slot_reset(struct pci_dev *pdev)
 	DRM_INFO("PCI error: slot reset callback!!\n");
 
 	INIT_LIST_HEAD(&device_list);
-	list_add_tail(&adev->gmc.xgmi.head, &device_list);
+	list_add_tail(&adev->reset_list, &device_list);
 
 	/* wait for asic to come out of reset */
 	msleep(500);
-- 
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
