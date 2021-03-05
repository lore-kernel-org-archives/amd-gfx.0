Return-Path: <SRS0=BT7C=ID=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5C38C433DB
	for <amd-gfx@archiver.kernel.org>; Fri,  5 Mar 2021 17:52:06 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9CF44650A3
	for <amd-gfx@archiver.kernel.org>; Fri,  5 Mar 2021 17:52:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9CF44650A3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5C46B6E231;
	Fri,  5 Mar 2021 17:52:06 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2060d.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7e88::60d])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B062B6E231
 for <amd-gfx@lists.freedesktop.org>; Fri,  5 Mar 2021 17:52:05 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=W7HdD0QcbRQFDDkpAjNZMxo8/fjlaNlNp16ZZp4YSkwW42e9KNeFAbDeZx+GyjdzpLk0u5VWINuwVo0Avpm8FT04AwfND2y/5LVs7M+dQb8cSE/rsQZwoUHlK3WmKaeLoW7ZsmcZSUriqnoQhvTR3+FQ0qEBhpBYiVSNWqqVUyIlSCDGeseMSOBCOl8i/tGBIF2XNsazP4SNKA6FGbzqu6AVFGrd1Kw/9TB/JOreiveLIifqdWXEGmAcdXJDAqV4dTYvAmtHNKtl84yzH3Qwq4fDDl06U74BnRuG2/stZ1j2Am2ESI/kjU1lIU2zack2RJtKwOAIBgNCTR2YE1n7gg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=i14rWFqYND8IVTn4UFql8mUxULBWPG4lv1/H78ASfIM=;
 b=LBQwhMU5ja1Zqy6lW8hsHCWkU2WZV70zsUR2wanlWACslxIjd40ZKp4eJTW4FhuBOTDVtNclRV3CZLvuxZkymoTpNhs9u7Dub0EP9503799CDwiXf1gjyW15byyh/1OkNo/gGuTQr9DZLCHvfYZotbeJHdXXWVGTlVt40s+qsiehRGlq4o9PataxYGhshseLjpO6Qz+X64l+da4ID8+Vx0amxDTFeZxmaDArFds24nRvmY60UQ4wtYXBbGeveuU2o3RzL1ow5nVvzOa1ssTn/ZDB7qBhjQvpPzuz4zxwMXcQ+iWvEu1sLKpxCzOhlclxoNf4r4/yGixnUhPg3ijfSA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=i14rWFqYND8IVTn4UFql8mUxULBWPG4lv1/H78ASfIM=;
 b=T68BfNNDtRUfHq/Awog+M17CH9jbyzkYh8TllIs6u4qDp42PjOvwyjEnbYpvTtvLPkN6zwWHEls+bR/6K+iFdW6zZ5/Jk8pGEZEVDV6eHzHduh2m1M3ijrOiXACy2TUYG1ojFWnZglIKxOs1cZLdO+Hs9o9lZl4JBgudZi4jsW8=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB3835.namprd12.prod.outlook.com (2603:10b6:5:1c7::12)
 by DM5PR12MB1754.namprd12.prod.outlook.com (2603:10b6:3:10f::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3890.20; Fri, 5 Mar
 2021 17:52:02 +0000
Received: from DM6PR12MB3835.namprd12.prod.outlook.com
 ([fe80::102:2c9a:54ce:63e9]) by DM6PR12MB3835.namprd12.prod.outlook.com
 ([fe80::102:2c9a:54ce:63e9%6]) with mapi id 15.20.3912.025; Fri, 5 Mar 2021
 17:52:02 +0000
From: shaoyunl <shaoyun.liu@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 2/5] drm/amdgpu: Add kfd init_complete flag to check from
 amdgpu side
Date: Fri,  5 Mar 2021 12:51:49 -0500
Message-Id: <20210305175149.32020-1-shaoyun.liu@amd.com>
X-Mailer: git-send-email 2.17.1
X-Originating-IP: [165.204.55.250]
X-ClientProxiedBy: YTOPR0101CA0063.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b00:14::40) To DM6PR12MB3835.namprd12.prod.outlook.com
 (2603:10b6:5:1c7::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from shaoyunl-dev1.amd.com (165.204.55.250) by
 YTOPR0101CA0063.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b00:14::40) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3890.25 via Frontend
 Transport; Fri, 5 Mar 2021 17:52:02 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: dbba27ba-3be4-4808-5650-08d8dfff61e6
X-MS-TrafficTypeDiagnostic: DM5PR12MB1754:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM5PR12MB17549C408520553027696A79F4969@DM5PR12MB1754.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4303;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: M4IEWV75OEUcP1Q87PIPQcfVBcoRxtkDV5/d2158aRp7jZ9lsRYxhb6AMxHnSxWYKysC5b3EBRh27htnsPGVIqZ+NW8cAQtclNWUJkVhyMz+KFnQ5vfpAePkwC0vAyz+h7FOj6quyxiKtY/QD+qYyNoYAr5MkmS5rS7YhTML1bwupzNYe9LG0PoG84CBU/9y+QGxQjXeB1XYjtGDe0dn9A7anyQz+Di3WKu0Ud5ZLiurREzw6CXPcTRqO37yiDZI78rj5kzFEbzeLhPZxkGeGtGOdl8aQQurW2zfKnw8zum0sm3u8QDX7D9O/lkoW2kaiUVkpMiJcXJ2qQh4YS0vtPsUaFL51mbxJacOP27wgSy+TtblDoBfuDl8PNEFUDMvvwSmQgxpgLj1io7hxQ+S5llPVnKh6tK9D3ZBHkLXjxt1xaM4NQklcSJfFQQXw9K46SQa/Mrc7Wj1gpeZg3M52DyDk0P3OogUvzlkaLHBAxnMf2zcrKxUvk6VyWOmBOdv9QDydxDvy/QOZxk2mzwx/DkHzJ0s02uQBE87dXwvPh+1dLMLYqm3sEALHNbH34ne
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB3835.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(396003)(39860400002)(376002)(366004)(346002)(136003)(7696005)(52116002)(26005)(2906002)(316002)(8676002)(8936002)(86362001)(478600001)(4326008)(2616005)(16526019)(186003)(956004)(6666004)(83380400001)(6916009)(6486002)(36756003)(66946007)(66476007)(5660300002)(66556008)(1076003)(43062004);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?1V0PjldUC17FqHRfTqzAh5Y7YlcVI13D/WaOd9Q1m+gGez2ZmTdcr7Cj47zY?=
 =?us-ascii?Q?xXMyPksmUsc8Gd7J5jV7hGeRJDmzJlPw+2HmEL5oP0dD6KggYKX7L+cFn7RE?=
 =?us-ascii?Q?EPdjpIQ/J0QQb7rksQlc+h0zveDbzkZm9mGt641CR3VkYV3Q5HRdk4TJSOKI?=
 =?us-ascii?Q?ajt0/jg6VPq4QPlZzA3YPtNaBptusDKwhp6nSdYKtTl/6nignL+C3BsQjDCm?=
 =?us-ascii?Q?e9AxHrBGYEjqIoNwzlaYM6v+VwrPw3OAyC+5iI3HOuN/GhA9CObHc4Y1vMCf?=
 =?us-ascii?Q?QLqb1cJ/eS+VrlICrA9qv0YqZPtzZ3EmNun3dHDlgKdR6SiqEfU7DhYWznJ+?=
 =?us-ascii?Q?DdkRO7d4XOM5KeXACZmyFwbQWDTB5fdDAupFOUHO4+d6mZhC03D5vgywrp5T?=
 =?us-ascii?Q?ubWVvlM/BZ4WrE/MWweDGBbSESSx/LDAqYQMAV7B3k8VbXvcxbaKOKoJO24n?=
 =?us-ascii?Q?WVQEDFDoBGTj8YVbmcBVv6ACRGGt782NunbWVW+pQNmAa3EXjcVhRS5g8a9d?=
 =?us-ascii?Q?9obB4zMuFJ67RfZh4S5jAWOMmGZ3v+1LyCSYmmYxQzwmqZxaLPAz7oioFLw/?=
 =?us-ascii?Q?moanWDR9GOjy3TB0+UXgO+wTlQuyPOpbxcugcgAV/B/oSHJg9pSevPqB0EKa?=
 =?us-ascii?Q?k08mIOBMC8GKW2bXYxZd71hMRBQ41MsG5xi8lIrxWJax7QuTIwLhF6gezn8Q?=
 =?us-ascii?Q?zkA+Z/unwlihF5LuvpZ6lTuAV6egwuN5OcdxCpyejTKsZM0iCOEezlhjMLsO?=
 =?us-ascii?Q?5Ci1vw6j32W3nPazfzVZd/0D2g6jpzBc4JgBVjw8bqUt769bYsRiIGTDmcbK?=
 =?us-ascii?Q?MtIZAi8SIJls7/HDklJ25kQxH65wV1m0lmI79ZupRXmi2XbRErJeapu+dE/m?=
 =?us-ascii?Q?ybbj2GY5W0P7nW2CLU4UUD1sUMXFBCkckXwFoWzgMxHKOxGqckbPsr0V/6Cv?=
 =?us-ascii?Q?Yr3WO+JzrJRKPgp1MBBNomYXxwT6CzHQaJAo0t6Vdm6PsBZuQBBHjfIZ/ure?=
 =?us-ascii?Q?ZO4/VuLVi5LqdTPb8BTbpoHCO5aNo9lQMCz1WJl7gLH53Nwrum2yLl9tCCUM?=
 =?us-ascii?Q?YAWzsvB6yxrQc3FaIWfZ0p8eE5Vg3M+cko+ikfb+jsa2UtE3g1TUuoE5d/0W?=
 =?us-ascii?Q?35WN3SHFvyUIWT/mq49HVThKTlmL9TWVJ6lU9ndeurRZfOxhku7zTfSXcmm9?=
 =?us-ascii?Q?FUE+M68Ut0a/8MKMq7FOMUh2cb5HW4wR9OjTCgUr8tm1+ANKjbLwieblkN4y?=
 =?us-ascii?Q?rDhtQd93jeKfqmp7BdRvgDXNu3cjn10/aIQouIR9gWy9Nq53bFpdYy+VBHZf?=
 =?us-ascii?Q?qildjsu20zZ+pNkG09uQ6TEi?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dbba27ba-3be4-4808-5650-08d8dfff61e6
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3835.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Mar 2021 17:52:02.7083 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mZosOmkRA6G/l2kMi7h2Rvhe9vL3IN0T25LoVbMZN8m8EP/sU/DxmPAuXOy8OKd3YiTkSDvPq3MYnUf4+cQ7xA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1754
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

amdgpu driver may be in reset state during init which will not initialize the kfd,
driver need to initialize the KFD after reset by check the flag

Signed-off-by: shaoyunl <shaoyun.liu@amd.com>
Acked-by: Alex Deucher <alexander.deucher@amd.com>
Change-Id: Ic1684b55b27e0afd42bee8b9b431c4fb0afcec15
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c | 3 ++-
 drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h | 1 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 9 ++++++++-
 3 files changed, 11 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
index c5343a5eecbe..a876dc3af017 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
@@ -165,7 +165,8 @@ void amdgpu_amdkfd_device_init(struct amdgpu_device *adev)
 					adev->doorbell_index.last_non_cp;
 		}
 
-		kgd2kfd_device_init(adev->kfd.dev, adev_to_drm(adev), &gpu_resources);
+		adev->kfd.init_complete = kgd2kfd_device_init(adev->kfd.dev,
+						adev_to_drm(adev), &gpu_resources);
 	}
 }
 
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
index 4687ff2961e1..3182dd97840e 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
@@ -80,6 +80,7 @@ struct amdgpu_amdkfd_fence {
 struct amdgpu_kfd_dev {
 	struct kfd_dev *dev;
 	uint64_t vram_used;
+	bool init_complete;
 };
 
 enum kgd_engine_type {
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index a11760ec3924..62d7ce621457 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -4788,9 +4788,16 @@ int amdgpu_device_gpu_recover(struct amdgpu_device *adev,
 
 skip_sched_resume:
 	list_for_each_entry(tmp_adev, device_list_handle, gmc.xgmi.head) {
-		/*unlock kfd: SRIOV would do it separately */
+		/* unlock kfd: SRIOV would do it separately */
 		if (!need_emergency_restart && !amdgpu_sriov_vf(tmp_adev))
 	                amdgpu_amdkfd_post_reset(tmp_adev);
+
+		/* kfd_post_reset will do nothing if kfd device is not initialized,
+		 * need to bring up kfd here if it's not be initialized before
+		 */
+		if (!adev->kfd.init_complete)
+			amdgpu_amdkfd_device_init(adev);
+
 		if (audio_suspended)
 			amdgpu_device_resume_display_audio(tmp_adev);
 		amdgpu_device_unlock_adev(tmp_adev);
-- 
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
