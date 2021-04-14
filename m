Return-Path: <SRS0=h6PS=JL=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33820C433ED
	for <amd-gfx@archiver.kernel.org>; Wed, 14 Apr 2021 15:27:30 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E4F7061158
	for <amd-gfx@archiver.kernel.org>; Wed, 14 Apr 2021 15:27:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E4F7061158
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A77886E94F;
	Wed, 14 Apr 2021 15:27:29 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2056.outbound.protection.outlook.com [40.107.236.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 774336E94F
 for <amd-gfx@lists.freedesktop.org>; Wed, 14 Apr 2021 15:27:28 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NWZft99+7csDqu78rwWhm3jH3mK3lTr34Om62S2IZ4Fc2uDgSZSqTyHKtlYymu5rRwoQ/oGGZv/jQOtTKOuJWV8A6B3h/UlXkt5z1Ewh7+K/m9djc1SeHvYLIEXbekL7+AhH9Qalyi04Qbb7VGLY4/D4X6TlOb8Yiz54HzplJj/bk2emrYWDsvPQzhf/irPG867XaHQjsjSMpHqGynMfM0U61Nq78uQ0z/GoC7PTNDgWelYADojWA4g/3VzuF+SuGpGCXmziZ9lBvFxOzhvTJYZ9xsYDTjtk0XqGXs/Z9a6EAARAXF1hOwgYj8hWcPt6v/Fy/n7oWnetUjCqC0FQJA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Axoe0Zylw9TZrPvIWFCs8U2VShrWLC5HC9m651CmP6E=;
 b=eP8sXeggum3Ft/ZFv3oRDASAzeLdFAQR3022JCpuw02WfneykxP1g7dFd1HaS+NGew6gPtgWPDvyKz/adaPX0IBEircxmmlZCanBZDqpfZJSAYWfh7LqiaDwdUyKSTkoX2KBXcUr9Iu+5rsgjc2rhrMqKhqcPC4LqdFRBi+PJvGggEKdP3LneHgicPVlpQCPX83B7jC3ec+k6jFLdjvYezoZQafNWAt5V3M6EKAlZ0u3FZmosAOgCzaCFotVe3jETz6C2xeM8DREmqZuzQAngV33ja48rrwFcJG7ElwfTFfbKSKwUzYAMBjAl/ct8Yr1D0OcyO2TBtwMuK9SlLWIqg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Axoe0Zylw9TZrPvIWFCs8U2VShrWLC5HC9m651CmP6E=;
 b=zGlWg3iAHGLAerlPec1oGwYXS6+iIKJFikIdKBZNno8r1n3/A42WltPh4CrdpgW1lQbPAWDEJSm/05t14bcaK1mRabfH5MJgUmvcYCkpYtjExjeE0tfIvfSeBUyt45BLctq+y/v9/FsXwnj7qfMFez2ggt0yDMmxLk3w6zXN97Q=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB3962.namprd12.prod.outlook.com (2603:10b6:5:1ce::21)
 by DM5PR12MB2502.namprd12.prod.outlook.com (2603:10b6:4:af::28) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4020.16; Wed, 14 Apr
 2021 15:27:25 +0000
Received: from DM6PR12MB3962.namprd12.prod.outlook.com
 ([fe80::cc66:8fc2:7029:d660]) by DM6PR12MB3962.namprd12.prod.outlook.com
 ([fe80::cc66:8fc2:7029:d660%4]) with mapi id 15.20.4042.016; Wed, 14 Apr 2021
 15:27:25 +0000
From: Luben Tuikov <luben.tuikov@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH] drm/amdgpu: Add double-sscanf but invert
Date: Wed, 14 Apr 2021 11:27:12 -0400
Message-Id: <20210414152712.25349-1-luben.tuikov@amd.com>
X-Mailer: git-send-email 2.31.0.97.g1424303384
In-Reply-To: <20210414152126.24685-1-luben.tuikov@amd.com>
References: <20210414152126.24685-1-luben.tuikov@amd.com>
X-Originating-IP: [165.204.84.11]
X-ClientProxiedBy: YT1PR01CA0023.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01::36)
 To DM6PR12MB3962.namprd12.prod.outlook.com
 (2603:10b6:5:1ce::21)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost.localdomain.amd.com (165.204.84.11) by
 YT1PR01CA0023.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01::36) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4020.21 via Frontend Transport; Wed, 14 Apr 2021 15:27:24 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: cf7b6d90-240e-4a8f-f7a4-08d8ff59ce87
X-MS-TrafficTypeDiagnostic: DM5PR12MB2502:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM5PR12MB2502D94B8270265CA9065631994E9@DM5PR12MB2502.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:51;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: CuO+3jUyv29I7v5kgcuO0TzeZflq1wTGzH2PSg/6xZqOWVwVFFga8Fxmu386zhbRqvOh+FOBU4DuVza0UpFU0bYmB3Ew8bGHWG1PGpsLAXygBj3sRlSN8F5l8tZsIlws0pXgK9hEfZqoYROBbTcUv038Re2HwUBdIX8s9HfO6bE+Mrzxo5wgoAXQ8TEyFEENa5qiUEiL5NUMSgbPz1dBYfZZVLFCbpXNG9wwmgzVxMqkVzKhvluj6RjyzwMYAMxpd2fDZIQU8a+Cy8oDTPUR4a8ce+WjQZWzgcXO/CJ5AIDl0qGJqgi570PS/Mqk+6rewOYbq1ZlHJhdR70WFLPIpb55sV83kbyhbQPu32Efal9mD9MCNjX92kosIqNQy/JPquwwuRNjwWw3jNgehRxxKbpE4KPUh0TDEnZgMvkTiv4zY32g3GBKW8DEadyH2UvHhncGLmbR7JUeqHFcR6OnmlVmc1bEiCCblFwG1/MKYNTMD+iJOJKD/RhLbd01TSG3xEfWIhevil73dV+sobK+utWDEUxg7F1MPNqUUeY5tp+W7nTR4H2lLZ01oHeGykrSpaZOuq8JOcWQlKj2Ev4Gp+zCSlLfscFjnb6wpIHw4VALueTImkOGdDk9HAennuWadJXoOTwSjR0eGXhxOWucog==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB3962.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(136003)(396003)(39860400002)(346002)(366004)(376002)(7696005)(5660300002)(52116002)(26005)(8936002)(2906002)(54906003)(186003)(36756003)(66946007)(8676002)(6916009)(38100700002)(86362001)(6666004)(66556008)(316002)(1076003)(4326008)(83380400001)(478600001)(956004)(6486002)(44832011)(2616005)(38350700002)(16526019)(66476007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?AExYxue/O9RhcwaDeB0gvyeNXQencsuqu/RTBM4OB65vUQkemKhkW4VZapjT?=
 =?us-ascii?Q?akUGHuISUz45CHZrvX6tjRMYn6/Yp7dRyuV81+4p9amcHxiTbSx1ZlF77IFz?=
 =?us-ascii?Q?mXuPZzoS5kOmEj1QifWWmHB/HNh6jqOeGZ9Tfo4Vqnm3pNz8Sd99MyGiWkEE?=
 =?us-ascii?Q?96RqZ10jMxcFAIgKmlqz4LkLGtZRMF9sFSY52ut3oh4rmWwZHO3yDzwoR9Y3?=
 =?us-ascii?Q?ou4x1XoQCYBuZ4ph8yDWVniGFszY5jW1z6OzAhsnfhSIFoWWw9vV4qdCf/jZ?=
 =?us-ascii?Q?p2NOF13EpDnfL78qGq3PCT2GfK3HqB+ChAmsmbJqYzqvp8b+Ls9K+iGnqzAr?=
 =?us-ascii?Q?+gc/9PACtD/GGyLjvW5cSHXS0wT+hPuBh/7v5iatDIOe1OLqqOYFvgZzU5lG?=
 =?us-ascii?Q?aJaRjf3pockM/3G8JgjovYLrc+d5E9vdBpJQdz0DM3jeGpF4wCouILo4uGlx?=
 =?us-ascii?Q?+2hvZlaIuZCr3OQ3sUvIhm95aZKmWdhZMfrquMCuhktcbbCN+zwHn3UPPKzf?=
 =?us-ascii?Q?5yfdYU1f2pghx4CInKy0PCsSK8xGAZSKgo1O4SjiaVlJL1pXg2kdohxWEmq9?=
 =?us-ascii?Q?m4StWeqoVt3DtasjlQ6lnniXOHT/pDnnHNbwbJsiKxw49XnWIwwxAbfJ+LJE?=
 =?us-ascii?Q?iDVJxzb6hxBbNWNZXOYRYhqkWovrf+2EA3jE7MZOHyQ28hFuvo3AbUJaGLv9?=
 =?us-ascii?Q?YdXNDg4cv5psn6ZGcVoWfa56BseJMxofHOk5iiordazqnavSfFSeHN+6s0O3?=
 =?us-ascii?Q?WfvCcosyUJoDD3WELoIeOGl9HIW8Rt/2CFxhlmj9cKA7pM1pSfDq1458St1C?=
 =?us-ascii?Q?KwJCkCOlodtbHrENCKQcd+myN727HLSYvkglVj8IXwacbDX679OkYk0lnOb1?=
 =?us-ascii?Q?bgbZs1SY+cd8ynio3RA/G3riOm2mww7agxJEhp6OKj7TdsIue0GNRgYDDR/W?=
 =?us-ascii?Q?Bu3e+Lx0Mmk8/dGJZ5YBuDbIGYSKheJ6FxtvGIdEkb7IVr8AcryHKJEZWmJ1?=
 =?us-ascii?Q?lNu6oVrwfCfjScLKstniz3kYUf52/Kx5db5iFA/L25KbWRuTfoR0mqhMIqJp?=
 =?us-ascii?Q?pDGnIrDjdE0omSnll9RzJ5cQICA8LMI0TOjt8Q2mDvDAIbiW1yIWRtR57c5D?=
 =?us-ascii?Q?CwSt+GHNrwQ/I0KWwOvQgzTN6Pb41M/V6W5N7uLzh4Mm5uB1avBGdgBqV+Fp?=
 =?us-ascii?Q?3wZ9ZFrCa1bWclOydyWhKZJh/G47CiPYHWhmWJxnaz0UPXhpAB/oI4RMnXp1?=
 =?us-ascii?Q?XNVtlpB8zw2gUpfArIerP66B3LOj1M28Sm1t7jF55uWeOxbEnnIVfBCNd8WN?=
 =?us-ascii?Q?g4IqIjXM6hHFKLDKhc+dqEBe?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cf7b6d90-240e-4a8f-f7a4-08d8ff59ce87
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3962.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Apr 2021 15:27:25.7053 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: A6utWKyyrs2h/HxIe65s7bntCBuH3S5pap5ZuCpi+EpA4RPVHEXw395xT9q6Hygg
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB2502
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
Cc: Alexander Deucher <Alexander.Deucher@amd.com>,
 Luben Tuikov <luben.tuikov@amd.com>, John Clements <john.clements@amd.com>,
 Hawking Zhang <Hawking.Zhang@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Add back the double-sscanf so that both decimal
and hexadecimal values could be read in, but this
time invert the scan so that hexadecimal format
with a leading 0x is tried first, and if that
fails, then try decimal format.

Also use a logical-AND instead of nesting double
if-conditional.

See commit "drm/amdgpu: Fix a bug for input with double sscanf"

Cc: Alexander Deucher <Alexander.Deucher@amd.com>
Cc: Hawking Zhang <Hawking.Zhang@amd.com>
Signed-off-by: Luben Tuikov <luben.tuikov@amd.com>
Reviewed-by: John Clements <john.clements@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
index 44dfb3613e37..38a691a3b600 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
@@ -229,7 +229,8 @@ static int amdgpu_ras_debugfs_ctrl_parse_data(struct file *f,
 
 	if (op != -1) {
 		if (op == 3) {
-			if (sscanf(str, "%*s %llx", &address) != 1)
+			if (sscanf(str, "%*s 0x%llx", &address) != 1 &&
+			    sscanf(str, "%*s %llu", &address) != 1)
 				return -EINVAL;
 
 			data->op = op;
@@ -253,7 +254,9 @@ static int amdgpu_ras_debugfs_ctrl_parse_data(struct file *f,
 		data->op = op;
 
 		if (op == 2) {
-			if (sscanf(str, "%*s %*s %*s %x %llx %llx",
+			if (sscanf(str, "%*s %*s %*s 0x%x 0x%llx 0x%llx",
+				   &sub_block, &address, &value) != 3 &&
+			    sscanf(str, "%*s %*s %*s %u %llu %llu",
 				   &sub_block, &address, &value) != 3)
 				return -EINVAL;
 			data->head.sub_block_index = sub_block;
-- 
2.31.0.97.g1424303384

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
