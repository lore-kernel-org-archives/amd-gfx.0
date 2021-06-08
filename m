Return-Path: <SRS0=OOkP=LC=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E44BC47082
	for <amd-gfx@archiver.kernel.org>; Tue,  8 Jun 2021 21:40:18 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D6DB6610F8
	for <amd-gfx@archiver.kernel.org>; Tue,  8 Jun 2021 21:40:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D6DB6610F8
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 629876E19A;
	Tue,  8 Jun 2021 21:40:17 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2069.outbound.protection.outlook.com [40.107.223.69])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7B8C76E19A
 for <amd-gfx@lists.freedesktop.org>; Tue,  8 Jun 2021 21:40:16 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Vc9ufulcS8Lhm2g2tlOY9beHuSwp/H53AZxmDVk2wKddakvnGDt8/C/6kmA3Sr72uK44eDah6rY/m3xMRZeJEdtHdEgnJ+XQmUu4QpSewgmVnqbNKceosva3aepyO8Hfg7QCaLA52csslmJ85NDU8O32OEXE0AcSBrIBK5JgXBvgSadwHfVLC4gc0DOTbcYPU0uMjRMko0kSsdQ28Q8f+kv2r/nhNl6VPROFlW2VUs1+94JgvCf0ii0GYKnEPkN+Wdno/2SZ+D9iZuJCfcTvqsOxQxz6hHcahYltE9byJOmkS99ySK2tL9W68g69xeC+Zjy58cpyTR2phviphdp+uQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=R+bciKcRwCogV1X2yodSGdAhM+x2xYXr2wN+/7X1+28=;
 b=REmaWgc0siCAqkHhzE4356PyshMCT6cLd+2dR5Bt8SNXm+GMDRSUuotU1306r/f1fxL9QEQmI84kW5Xx9wZD9cc0mbOTCYD3UUPSW8p+R1m4R3J+sB0uYjJK9PiW7aBLA5E2E8zoJ06VIXLAHEaoeIGIjS0pfztmntrhyXk/FLFAJNXw/4pz9hqZ9NwNCN6PHMqVEItlkI0ySd/yxLOrpGayEkWbGmVlJQU0ZDfXNiLcQKHmKy89J0C7IwyQdusBcGDToEYB5umNsdc4RHsZSNIqwXTCOekldzgWi0yCr9QhJ0cyrz0z/+IfFwN61bYqxpl27sO4NjckP9tr1UoZ5A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=R+bciKcRwCogV1X2yodSGdAhM+x2xYXr2wN+/7X1+28=;
 b=bll/rzrDqN1UAdvEKwJwRmKqN6fYlBxiZsbG9MggyhcJdlFGSYMo+P4318fFb/TrYVagiwap+ILtYxqzSvIcgdKJ1cNHhSPedSeh9OjTyYKR5uXB6y5NQrhyY7gMQpzYMWyFu+NSLeF5+DVG2HRNChNHM2ww8qgBPid+HiY7tiQ=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB3962.namprd12.prod.outlook.com (2603:10b6:5:1ce::21)
 by DM6PR12MB4355.namprd12.prod.outlook.com (2603:10b6:5:2a3::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4195.24; Tue, 8 Jun
 2021 21:40:13 +0000
Received: from DM6PR12MB3962.namprd12.prod.outlook.com
 ([fe80::142:82e3:7e9d:55a0]) by DM6PR12MB3962.namprd12.prod.outlook.com
 ([fe80::142:82e3:7e9d:55a0%6]) with mapi id 15.20.4195.030; Tue, 8 Jun 2021
 21:40:13 +0000
From: Luben Tuikov <luben.tuikov@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 01/40] drm/amdgpu: add a mutex for the smu11 i2c bus (v2)
Date: Tue,  8 Jun 2021 17:39:15 -0400
Message-Id: <20210608213954.5517-2-luben.tuikov@amd.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210608213954.5517-1-luben.tuikov@amd.com>
References: <20210608213954.5517-1-luben.tuikov@amd.com>
X-Originating-IP: [108.162.138.69]
X-ClientProxiedBy: YTBPR01CA0029.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:14::42) To DM6PR12MB3962.namprd12.prod.outlook.com
 (2603:10b6:5:1ce::21)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost.localdomain (108.162.138.69) by
 YTBPR01CA0029.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:14::42) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4219.21 via Frontend Transport; Tue, 8 Jun 2021 21:40:13 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 6d7ec3a4-8276-4144-0204-08d92ac5ffb3
X-MS-TrafficTypeDiagnostic: DM6PR12MB4355:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR12MB4355BA6406089DD2C7E5CCE599379@DM6PR12MB4355.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4941;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: nRItVnHOmQmrPyWdrzVZLzQJdPNzc1d7wyWlxD9ALRNQR+FFyyF0dLJMaXx1JbCasaBSZ0PnwPDU6lYeOEyyPvL8vG8+KgRTx1c/JP9nKrtW4FlmDC+1IuD59tyL4xYF6wv3QgIWrXBSr7t6RMlX0LSqgeIXVti0xI+lujpd56xdZ0sPYLbEwXVGccu1FvaJbjKezsNafT6yEQQWeYXivSBCJQ37iT+LacZLTTzoQVCmLc+v4khX/DF7jqfZ393Kp3i3CC75EB47RLvo5zwQrGVmFvZnyYTqcYXIhp7tz3mQ3S+XviXcIOhRXerzChMgH1jlzsoj6iAhETY/pYxhDjZ1eTKwGS/5oHcwHHO/KE6YigYAYbrJvQ2yfWjfv5hARAlBp4XR9yeFsl9Hw44JU4gds2cV5K4ckBA83ov4hiFwj6cOakGDIfIkzzwzl0jjy4U6mvwyn5qSWPuRMmk9s52UItGz+wSgEd7fmblVS2uhuNg4/ng6Nm1F4pbOnxDOoZtyhcwG0lhpaFALQxvfAmaJ+9v48/lNvgUJFcvyQgLbYTBOVWmeTePqlaNxNtMzch4oPFzChdn3R9LoappOmmP0vXAJppaCdP7p3YkZbzvIIbX5iQvegZeoLzQtDhchpw6zF4W5dqLRER3KZK+TCDbY3OYQtKV5w1pgsZstQ3b499vrGJf39uwYRGUw6rnO
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB3962.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(136003)(396003)(376002)(39850400004)(346002)(44832011)(6512007)(66556008)(66476007)(5660300002)(38100700002)(956004)(38350700002)(6506007)(478600001)(66946007)(8936002)(36756003)(55236004)(2906002)(16526019)(6916009)(186003)(54906003)(86362001)(316002)(6486002)(83380400001)(4326008)(26005)(8676002)(2616005)(52116002)(1076003)(69590400013);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?o9+6ADl9QpM0aJuTZ6NUcZkTVFWcvvbfBp44tCI65dfP2Vn8DmvXlyDXOFfY?=
 =?us-ascii?Q?mAA8n0HGcVlLiPBQDFGFKs0k+HB6OZA6rPyrI2o/88oddapIPoC0hoYGfO9J?=
 =?us-ascii?Q?gir9gvSEotoKuI7aP3MJ/MErJCFhiXjnhLyz1F+do0Oq1SnKsRTVHR5ImYyC?=
 =?us-ascii?Q?/JWythSPlAZ+tEZDgMlox3okZxZn0an3ApyIzOEgSRudC9Z7/1Eo5YT31ZZd?=
 =?us-ascii?Q?XiafE3GkPxeBrahegFQZox+3Kg/60+dzfR2DMz+FBRviGoQ+Ns4DEnSwtQKY?=
 =?us-ascii?Q?alxH+Dr1pB6U3wLBE8Aq/6AjzR7qMDZBoXQo6XLSU9253GgyEpcBHaXsn9b4?=
 =?us-ascii?Q?iyyhdafH0B5S5wfdv0OZogmlkosUemEcQ7bg9zWMyBTyIzq2ZxOjoxY14f90?=
 =?us-ascii?Q?1rsX0EdioCyr+mGdKhDqQ91+IZcBdntk1gOJxoze9TuZ2R6J6Bx6x2ebwMVR?=
 =?us-ascii?Q?C4wuyPNYO1CRd9YKeEzX1dSbvmz8ynQUEasXcvr7IDrvrYkWCM+VhUQOT6Y0?=
 =?us-ascii?Q?jZXkNuneQP29iT+Zv6yOql1uALwwWEUOTSlA+GOJQXjmVLuJFhG6CWv9oOGG?=
 =?us-ascii?Q?ALvW+jMU+ygN54Ljsc/x5pBosCvAABbldmy4QGne2tVkXaNBnxB3fUgfqcF6?=
 =?us-ascii?Q?de6VQlTUQEXn29m7VU77+VQPYWJR+zmIShx4idUgv56pa6edifJbnjd5S84F?=
 =?us-ascii?Q?vnayXDkIFywU2L5IHVi14iZcRfDAJolgrmtj6nqndDZ+bnPLcj0p/ea6Vk+r?=
 =?us-ascii?Q?PpnQEcXyH2Yz0iy8rycey34bISxEMF9ydopS8Dj0WOVDdqM6xc4O0jjCbIfF?=
 =?us-ascii?Q?LaoTYBy54LLBAQ7Dfl4FYV9ukaXzn8xrC3UBkdOS84+FSkwioHdIaBYSdI4R?=
 =?us-ascii?Q?7RoQdRqYrNaUMn5eakOt0zX2KUcpllqEHnpQuTYvV/hXD31wODhjQyCDOFfM?=
 =?us-ascii?Q?sg129Lsz7roSsGlYNmYRdUoOpAUw6/TJCb6iPt6iwmQw31XkmiJhqeXjqC3R?=
 =?us-ascii?Q?Up36YO4sBovoRCgFDZzVvE99nvcxw1rcOAMFLE+lRK2bIP9NA/hIXhKv+Tes?=
 =?us-ascii?Q?CAbaNaZuSd4NS64ZvruP7rKoVDxaSuo4EtYd9tw06aDprWYg/bkg3UwGVWUa?=
 =?us-ascii?Q?4uktnlGTfq8lhfjf4rYjyKw7htr329SE3mu3kT5Ya823QfxmQkekyIX0+evN?=
 =?us-ascii?Q?fOuVtH6ElNuqealOCULyFl/ijCSjn21FxeidQrvCa145thY2yey5FIdhISNU?=
 =?us-ascii?Q?fwkxbhjTc2BWgfVKHgsvT10uyKhEUmjnmRXpZVo+U8L61qO74wL/EVV/0FLj?=
 =?us-ascii?Q?BJfWH9oc5bzOn77M6YpXbcgo?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6d7ec3a4-8276-4144-0204-08d92ac5ffb3
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3962.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jun 2021 21:40:13.8040 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QTPs26EPD1upvb7KWp36sCl9U2BLGQ6AkRWAL7dtYbM0ccroDBwKncMmz4dNpDsI
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4355
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
Cc: Alex Deucher <alexander.deucher@amd.com>,
 Luben Tuikov <luben.tuikov@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Alex Deucher <alexander.deucher@amd.com>

So we lock software as well as hardware access to the bus.

v2: fix mutex handling.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Reviewed-by: Luben Tuikov <luben.tuikov@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/smu_v11_0_i2c.c | 19 +++++++++----------
 drivers/gpu/drm/amd/pm/inc/amdgpu_dpm.h    |  1 +
 2 files changed, 10 insertions(+), 10 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/smu_v11_0_i2c.c b/drivers/gpu/drm/amd/amdgpu/smu_v11_0_i2c.c
index 5c7d769aee3fba..1d8f6d5180e099 100644
--- a/drivers/gpu/drm/amd/amdgpu/smu_v11_0_i2c.c
+++ b/drivers/gpu/drm/amd/amdgpu/smu_v11_0_i2c.c
@@ -584,12 +584,11 @@ static void lock_bus(struct i2c_adapter *i2c, unsigned int flags)
 {
 	struct amdgpu_device *adev = to_amdgpu_device(i2c);
 
-	if (!smu_v11_0_i2c_bus_lock(i2c)) {
+	mutex_lock(&adev->pm.smu_i2c_mutex);
+	if (!smu_v11_0_i2c_bus_lock(i2c))
 		DRM_ERROR("Failed to lock the bus from SMU");
-		return;
-	}
-
-	adev->pm.bus_locked = true;
+	else
+		adev->pm.bus_locked = true;
 }
 
 static int trylock_bus(struct i2c_adapter *i2c, unsigned int flags)
@@ -602,12 +601,11 @@ static void unlock_bus(struct i2c_adapter *i2c, unsigned int flags)
 {
 	struct amdgpu_device *adev = to_amdgpu_device(i2c);
 
-	if (!smu_v11_0_i2c_bus_unlock(i2c)) {
+	if (!smu_v11_0_i2c_bus_unlock(i2c))
 		DRM_ERROR("Failed to unlock the bus from SMU");
-		return;
-	}
-
-	adev->pm.bus_locked = false;
+	else
+		adev->pm.bus_locked = false;
+	mutex_unlock(&adev->pm.smu_i2c_mutex);
 }
 
 static const struct i2c_lock_operations smu_v11_0_i2c_i2c_lock_ops = {
@@ -665,6 +663,7 @@ int smu_v11_0_i2c_control_init(struct i2c_adapter *control)
 	struct amdgpu_device *adev = to_amdgpu_device(control);
 	int res;
 
+	mutex_init(&adev->pm.smu_i2c_mutex);
 	control->owner = THIS_MODULE;
 	control->class = I2C_CLASS_SPD;
 	control->dev.parent = &adev->pdev->dev;
diff --git a/drivers/gpu/drm/amd/pm/inc/amdgpu_dpm.h b/drivers/gpu/drm/amd/pm/inc/amdgpu_dpm.h
index f6e0e7d8a00771..d03e6fa2bf1adf 100644
--- a/drivers/gpu/drm/amd/pm/inc/amdgpu_dpm.h
+++ b/drivers/gpu/drm/amd/pm/inc/amdgpu_dpm.h
@@ -450,6 +450,7 @@ struct amdgpu_pm {
 
 	/* Used for I2C access to various EEPROMs on relevant ASICs */
 	struct i2c_adapter smu_i2c;
+	struct mutex		smu_i2c_mutex;
 	struct list_head	pm_attr_list;
 };
 
-- 
2.32.0

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
