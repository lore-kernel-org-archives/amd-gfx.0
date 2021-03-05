Return-Path: <SRS0=BT7C=ID=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 305DBC433E0
	for <amd-gfx@archiver.kernel.org>; Fri,  5 Mar 2021 17:52:53 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CAF9A650A5
	for <amd-gfx@archiver.kernel.org>; Fri,  5 Mar 2021 17:52:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CAF9A650A5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 850626EC0A;
	Fri,  5 Mar 2021 17:52:52 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2069.outbound.protection.outlook.com [40.107.220.69])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 958AB6EC0A
 for <amd-gfx@lists.freedesktop.org>; Fri,  5 Mar 2021 17:52:51 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AUNBv2ZTBMLffZ2DPv1RgECcc+rY3FctpUi2ZA8lptP3vazdgnGKCAz+mS5WVWE7f8TndslRsQZfkvbhcWu6NxTIfUuN9oIy/m27Xg1LOFlF0drnrx8BHHEljZDDIgjTfzlj+5jBIFvy4gCmOF5OWKstLXBkCU8rxjiku1pnUaG7VOkt3nu2fVZ4vmt5RRqDhbOkDg34cIX58TWoVjqigRLNzQ3pghcyAKHU8snhdSluiswdvkklRM6qJKTtWkp6/F3X//UrdZWA+WjKecUDoFHC6Re2Ut1VcTf1y4MOYWgYf/KWH+T8YPGXbmetcQHuDYb12EsYboGEU3QYIR4S1A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=q+bej26VD/P19yTQgYGezChXiROZL36B7uRAkfUbVzY=;
 b=QNTcDCUaDq0KPZHdebcJvDWTiki7Cbssn4AXkQDkX1JMLDTGMftXf5wRd7M427oomlebjYSd91Ao7F9c1RBbxmDC1t+TcBxp8/Nsqq1YBrXavJt19QdpdFjBgnqBYIU+jTOxWvEevCFQycfNQW4g7q2QsFubrlvKtsa90BTP50H5ydRJxYep1BD5lp8TtP07PjU8IFgW04Kmh1REd0LsGbBGgoEF5/mqfSJUHdpMQ711yDtT141E8byFekOdhkessCoK2vPGaFqAA/RoG8Jr3GT78Ao9fjxXeQeqmu3s5wCmbhw/7DltyTucZVfRR3m+xqbTo5ZFgiLT1qta7P2Utg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=q+bej26VD/P19yTQgYGezChXiROZL36B7uRAkfUbVzY=;
 b=yGRVVowOe6zY88VTEcCccEcorv+DSbMeXuEni2ugjYX5qNstn1sTZbo/K9di8cOCSwjoNjBDOPR4xv6WlQJIaiuIOoWdSU4FEFnks6Gv6gPqjEkxq2JmceHPwIxmiZQLMTj02vWuKl5urw4Ai/4GJ9taTgYd3MzFt/mnB7URAoA=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB3835.namprd12.prod.outlook.com (2603:10b6:5:1c7::12)
 by DM6PR12MB4009.namprd12.prod.outlook.com (2603:10b6:5:1cd::25) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3890.28; Fri, 5 Mar
 2021 17:52:49 +0000
Received: from DM6PR12MB3835.namprd12.prod.outlook.com
 ([fe80::102:2c9a:54ce:63e9]) by DM6PR12MB3835.namprd12.prod.outlook.com
 ([fe80::102:2c9a:54ce:63e9%6]) with mapi id 15.20.3912.025; Fri, 5 Mar 2021
 17:52:49 +0000
From: shaoyunl <shaoyun.liu@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 4/5] drm/amdgpu: Add reset_list for device list used for reset
Date: Fri,  5 Mar 2021 12:52:36 -0500
Message-Id: <20210305175236.32168-1-shaoyun.liu@amd.com>
X-Mailer: git-send-email 2.17.1
X-Originating-IP: [165.204.55.250]
X-ClientProxiedBy: YTXPR0101CA0042.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b00:1::19) To DM6PR12MB3835.namprd12.prod.outlook.com
 (2603:10b6:5:1c7::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from shaoyunl-dev1.amd.com (165.204.55.250) by
 YTXPR0101CA0042.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b00:1::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3912.17 via Frontend
 Transport; Fri, 5 Mar 2021 17:52:48 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: d79c9d84-7dc3-47c5-bf06-08d8dfff7d74
X-MS-TrafficTypeDiagnostic: DM6PR12MB4009:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR12MB400910148D0CEAC969730E5BF4969@DM6PR12MB4009.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: BqIxiwb8YUlfRzNYXfk1ipssCBpXxB6Ak0gIR9zar+/uhP+e1x0DULfmNzraZxyThnnyrLkBt2tXma8KeyIqRmMvGn36Ph8wF9JLxa7IPeW8dAa7jifwz2LRnF4Q+cCmUsA/bYhomOBcunTyVPXxUClZuZK33W9qre/i6yjh0iEndv4YPEFeRVv62kgv6uZYie7aNbyXJZjUIw4wemtvisotR9NZxK/kYRmb7AcMEx1G3jHojeZ+PqpSOowY3R3QI4tM/aN/mqWXpOSMtCiWkQSaJuJ6QjxxxB5Hf+kiGm9aS+q1dmnnKThtSABh6EW2FxAQHOx38aBoxSingNvuv4rCyGYqdM2H63eGs/mkII7B2qBKt1tAkoTsxQPWYQQEuxmDATzWIoK5f1hZpwNFcAIRBDH7vA3v3p+ZjJMKtMfVsCkZOBz0odWfJYWaiWhPqWcfJEinZhjrJvIvGGI+umXZZi+X4FG2S/aS7mLr0OaDUJ/HXV5nTpRKaRnfsz3Tg7H5GQshLh03S+LHC1zGJ0QoR1dNq/SQdNwVPu2S6x+QwCQolLoVud8XZG2+bBKb
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB3835.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(346002)(39860400002)(376002)(396003)(136003)(366004)(66946007)(16526019)(316002)(66556008)(52116002)(66476007)(7696005)(186003)(26005)(5660300002)(6486002)(2906002)(956004)(2616005)(1076003)(36756003)(6916009)(86362001)(83380400001)(8676002)(6666004)(8936002)(478600001)(4326008)(43062004);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?Dt3VthTOFlu84VMxvPq4HmmrwKPtjPQ+dVV+MP5/k1o1QOOjw1lohCPA4aiJ?=
 =?us-ascii?Q?OscQETKgF31YVkFAjbMbWUoMv9Vsu7nt+6yi1IUVh/QqwFYx/u0eeW/IYfEW?=
 =?us-ascii?Q?qe4hA/uVcbygFFen5bUtkEKfbWXQ7PhLH4fGowbEc7bkbmXr6lSnb4O7rJfq?=
 =?us-ascii?Q?A4Y7K3X5U127TjPY72xJTqFeLXmM41wGMKwCjrmOfYIQLhlSCRkXH6T45V1L?=
 =?us-ascii?Q?djyJ/XkDENp76KwzxYAbiJUOUl/YBB6c7t/r0QNUimtSKGZAiw9NrnKdmBJB?=
 =?us-ascii?Q?R0atR7wIvl+8cvClK9TcRmoJib1ywAQJ/K9L8gfnYUEVkhpXPW125WS9W6X8?=
 =?us-ascii?Q?KJCTD+SQG5S2qgsgsmzhb6liyWNpvJd4WwrDDNHHnwoCdSf45EJNS0ahj2ig?=
 =?us-ascii?Q?9LNOORb2ZY5l94TTnWKAjTWvl5SpAj5361/W+kE7cg7jUp1ZNHNpn9MkPN2s?=
 =?us-ascii?Q?hWFONM19/K9bRLDZ44UB/n/QJmah26srAFJO3FeurWejfivVSpzGq9thqaM5?=
 =?us-ascii?Q?sqaIKeh1QzVU/JD2Kjd+CgiXRYG3LOXw+92cd56TqJZcJ2wqx4fGx7AihYGg?=
 =?us-ascii?Q?H/tuMdWEc72vPmKPqPSUfkF2L3mJ0sEG1Jv/XXyGaU2XDf/cKatd/iHlMnCH?=
 =?us-ascii?Q?MYvzU8L3kqQnUk1OTKGZhApjQ3+U57kXKS9YcLYAcEvjoKhWD0ZiifcLbXAz?=
 =?us-ascii?Q?n15gFLeLbo9bsdJjbpFTshnnmb8A0y/oA2Aw7Z+lj5I1RW10jHIv+DKU3YUy?=
 =?us-ascii?Q?C2HjSwG7G0aP9tvRExTBSaFNzj5EMAduTFopnD4dCTJBGXiS81xr6EqyzRJy?=
 =?us-ascii?Q?Uzea/2pcaMChq/oieZbBqtyBG+4WIHonsAcSZCeGX+4uMa5RMZlOUBJBbSy2?=
 =?us-ascii?Q?sEL+9wTrZdRy1b7RGZXjXfdrdyIb+ZaUdXbd9WMDk16EjyIkq4yG1m9G/h4w?=
 =?us-ascii?Q?CSjUQiDim/zfRjr176/JNuqxt7x3BOa8rUCK2ZveZ77gVY4GqUVL6DrspFIO?=
 =?us-ascii?Q?jwgojbL8LTaU4UlbZlOx9tNXPv+fLadkurfisNRQpTm2oloEXkOsZUJmSF2s?=
 =?us-ascii?Q?/rmTLYacp0oz/121LZSLtDhAtqDZz5GIwxFmk6FJYQwnYzjaBwYqKjtWbWKz?=
 =?us-ascii?Q?PR0ka/YjcaTZqzhlBbBMLpH6aW0Qb5uEWOSsf1LEPSjh59Oi477NM6VeGRR0?=
 =?us-ascii?Q?wXszKj6/NlsTmwXycC3l1VPZi9J8UjUNRqNGj+3BzCQbAztWiLJla6d0cA3S?=
 =?us-ascii?Q?vhFCTtbgoZ3iD3oLrRiCf5tNh8KG5kngc+IgOqtqpO18KAXmEuyVZ+exB5tx?=
 =?us-ascii?Q?YMZNXSj/NB+QdNlGnQTHX4Sr?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d79c9d84-7dc3-47c5-bf06-08d8dfff7d74
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3835.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Mar 2021 17:52:48.9421 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2fIP2+sI/tVZSuCHrvCHuKyRj+93IkJYDJqx/TPeIoj+KSqvJHHv79NUa5nb/+q7oSkiXyeZMWUYTjWopRpq7A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4009
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
