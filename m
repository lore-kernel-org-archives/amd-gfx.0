Return-Path: <SRS0=Oizy=I4=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0876DC433DB
	for <amd-gfx@archiver.kernel.org>; Tue, 30 Mar 2021 21:03:17 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AA9FA619B1
	for <amd-gfx@archiver.kernel.org>; Tue, 30 Mar 2021 21:03:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AA9FA619B1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5096B89DD2;
	Tue, 30 Mar 2021 21:03:16 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2040.outbound.protection.outlook.com [40.107.220.40])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BA3FB89DD2
 for <amd-gfx@lists.freedesktop.org>; Tue, 30 Mar 2021 21:03:14 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UNyMR5WlxQwmECosHqNrKbSpVzTlhvmzM2Aj3ic6zenFZFwDOuYuHvEoeTZ1g6HohLri5CW8i3eZBy9CsYluTYsoVLU52iWmDzsEKOsZMavvkipkmWQexg9osjq4eTHAzqOkmTst87q4jKACq+UudLlu/ENoLia3iInSovwPlNUDEGciXivV+k45RyvBk68zHYiciZeP51188zkdYLnpLdnp0jl1KkYSKZw4dm8jcQS0kZK7LryEKeRpBk4r/eLQax6XS41HtjwbGhey5kLbj5v+EcO/mxNyXl/q3tJSAM0/zzYmNgRiRAgvIawqR8U0KoIvittclQ717SlXfnRWSA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yd0KDZsmy2uB+cunG7QaPDGNdrkWPRhEcktFfB6f+gM=;
 b=ASC51YM4QcqaJc+1HqQidbpBqK1CfzYnjwhoTsHn1bDJiqsGurwD7RamcIguA4Q8BYbRlS/1BxIpm13DtqKfj10/2+dFMX8yDgHkDg8vtiIaRtXtLIwinXnSdHyK7bE5M2/j91CkfZr/n3uPorC+EJ7lQ6PQe6bcpQ44tDX6jkvsexGuGeRkP7725Bs85hChsKidunG2cPgoF5dv0DaFbJMT0LysPgeJQQTZwfc2bAyX9suF0I7op1tMCs5QBdgECsg7bv1p2xuWXDwHNJerYr4lHkoau5JyXLdFFEAxsmjC6urPhANApIhHdGcHIrE2QTTy93TW7ZKFuUMQ6we5/A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yd0KDZsmy2uB+cunG7QaPDGNdrkWPRhEcktFfB6f+gM=;
 b=aewfcdz9YiC8jRRwuJNXrDIar43E7CJjHne7PEfJtuNmUJ+a6zJa2XPUil8BCo9873Y7kTeWZFA0kqXAJETSfBbDJ8hVR67VwH98oKD6+YYJ+L6akeWe87dqSKdZhPVXBJbsvUHvMBojmtT6t4ggPc4Lby4R38ga9LewDkR8GKY=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB3370.namprd12.prod.outlook.com (2603:10b6:5:38::25) by
 DM6PR12MB3370.namprd12.prod.outlook.com (2603:10b6:5:38::25) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3977.24; Tue, 30 Mar 2021 21:03:09 +0000
Received: from DM6PR12MB3370.namprd12.prod.outlook.com
 ([fe80::c584:b4b5:83d8:f06f]) by DM6PR12MB3370.namprd12.prod.outlook.com
 ([fe80::c584:b4b5:83d8:f06f%6]) with mapi id 15.20.3977.033; Tue, 30 Mar 2021
 21:03:09 +0000
From: Amber Lin <Amber.Lin@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH] drm/amdkfd: Avoid null pointer in SMI event
Date: Tue, 30 Mar 2021 17:02:36 -0400
Message-Id: <20210330210236.23732-1-Amber.Lin@amd.com>
X-Mailer: git-send-email 2.17.1
X-Originating-IP: [165.204.55.251]
X-ClientProxiedBy: YT2PR01CA0029.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:38::34) To DM6PR12MB3370.namprd12.prod.outlook.com
 (2603:10b6:5:38::25)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from alin.amd.com (165.204.55.251) by
 YT2PR01CA0029.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:38::34) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3977.31 via Frontend Transport; Tue, 30 Mar 2021 21:03:08 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: cf433987-be5a-4648-5692-08d8f3bf38b3
X-MS-TrafficTypeDiagnostic: DM6PR12MB3370:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR12MB33703336A160B0AE50C61FA1E17D9@DM6PR12MB3370.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1060;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 5Yq63DSoyUGVBywSY+i7X+8CcdEhXSs6ypFSXP1RZp+pDG0jsgs7OfNJCN3PD8oKpGyW/sc5XhJu59krjc8SEgsia3q1IYtAeLhqayBej+K6lpreAcgKExPrAKn/paBFViCKBsqZQqdx2jLB2cqu2FTff4+l4b3fTGa69Vbo7qGnIJ6uv+7YMYmo1OiIzAZujUC2ujjA1jC/sn7PAzLtrPMOmCJbNLzecSW6LG1h8prTvkrDFgCJuw8aaM+/JCuDlcGgAlhW+lPM5/+Eef0yy4IQ3t1Xp2eToBgluvIMpgKic1DzPFySnGG0lieGlmXY3a3vj2Q3qf/foYcUpXvLsD7LnjFlGzxhNVS1cCZr7ganpW/9f03BCnVe8XQg+vUpIn3KqlPjQV+zcgcUyPH6gkKx1QcVAh5NyLy6dxdi5NkeXY1LnV+WQ5tt5AMkMi8khehL6ZQf4qi916ssBQrUFY4/dtQ++ZmpIjJzTpdQHU8Ta+TjoGzfCtW90yN0tSubCHNxCLKZe3am5kmgs7cXd0jghSg2Kg8bQIlFCOnea1ZLFiM8kmIqBAU0SxYCSoxvhP//QtGgEXSpv6RJxdfg4d5h1KG4KgqX1Ft+RGp1lQ25X3buiy4Oewq1Py4t7ksrL+FLoTe7wk6cDlvB8CS4acOYX9AYoANxtnuDZQTv0Ao=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB3370.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(136003)(346002)(366004)(376002)(39860400002)(396003)(83380400001)(2906002)(6486002)(52116002)(26005)(66476007)(66556008)(36756003)(16526019)(7696005)(4326008)(956004)(1076003)(5660300002)(8936002)(6916009)(6666004)(186003)(8676002)(4744005)(2616005)(38100700001)(478600001)(86362001)(316002)(66946007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?x6TpIDdNRhD/QXSqGYELsnWcidiErXp5wBBxnyuE48b52b1puXz+1s9aYLV4?=
 =?us-ascii?Q?UxN2qVaDLXGA5CqQjvs+kpbiqiPL6hLhXd1YAq2VpNl8cMKX11rXevwaydZJ?=
 =?us-ascii?Q?7100+7F0f7s3LFvm0HumW0GoPIxj+f8/yMApmA/D+mMysK2A0Ond4Qcsm2NQ?=
 =?us-ascii?Q?QJWgbaAldN4tgUTPziOjEmKcd6yCjLWIpc46FgLY07NnDnUHGAJiVJy5BFk0?=
 =?us-ascii?Q?FB7OIHXK++51P3WJDrDURkzyZdWKl0Eb2mh/4E1zec4oGq0IS5lpqT8qzu0s?=
 =?us-ascii?Q?/oTiRZdwJXtIpY1iEjFs1oW1Gj72JNMCt77EUmlN1ufb21fr+yb0yesGlA8i?=
 =?us-ascii?Q?KFJCj5AHgFtlrrXDs9kZQVO+hKVRFl8iXJfLAe2L3ZLjN3QFvLPT0FMW7/RG?=
 =?us-ascii?Q?yoRxoOVzxUdsVf9HcZLVC+5jYige+7TGAIY1vWtsD5A4hkNXDVnVtw4FWi2m?=
 =?us-ascii?Q?/VBRZpjMQIIhS964abJ57CRJWkOD5mctqttNzNP6HrX9nRquyTd98Hc60RUB?=
 =?us-ascii?Q?6h9+LV+Pb0OJu1Xq015kyTBrm3XhyM641AMy0+NkEi0kgimzIEZ08qItg0Wn?=
 =?us-ascii?Q?8+mVegcTLgYteHLIeP4BIeYWhANObgN4WlDROC4jg2i21jSmgD7V9IXk7WpS?=
 =?us-ascii?Q?prj93GlpAJaLLOqG3oE8nrFYyhbA8htLcEL1UnAaFDC986x9ckes45GJvAjG?=
 =?us-ascii?Q?aJMbuOIDd3t+f+LcadI+CHi4nnrjkqKBHJfZ8CbdIDDafHfOM4UzyOGf0DDN?=
 =?us-ascii?Q?cbORX2qUHdqM3HDsJcjNAKpKeBuNhiRME2xOVA8TD4rpjSAvB1qV8atZwjLF?=
 =?us-ascii?Q?A3uFXXUfE6jao0XkTMCQOhxgv51JI+oQNNA3EsFn7m9XwBTtkV7zFVGSs+qs?=
 =?us-ascii?Q?ZDQk3bsAnhOaxtHS73kMLbJGtnoR5I5qk2+Rx/V36yAwHRJXa3U4XNdlFxFn?=
 =?us-ascii?Q?ILrsQjqzCJ8dat9v1hSVr9ORFCxtaksFv3FfvSQRx1WwSNW1bR+N9o0exVSD?=
 =?us-ascii?Q?tFq5hP0j5TCvNgTSZ76PF3T2TOxFkJMuiVZIrLHwe6nrpfkgDAGVjTvCPeNj?=
 =?us-ascii?Q?u168RpCEZ0bl4cZzUFZDRMVUwFGdpJKBN8RI9/N/saLAfioMWKR1/Rje5ne6?=
 =?us-ascii?Q?lDp+M6cx0Mfd3WXbH4oxzGVW8TA9Jnhq23Ug88lNAdAw2dI7u9/E8KISMWSf?=
 =?us-ascii?Q?C346CvsyBcTu053LPq0C3lAPXIoTUgrLJJxPnUI/WU3sCErKM79Ymd7O2AdX?=
 =?us-ascii?Q?L7v8gq4O2JUYwTusgrfhQoSgkCb63oyyotbrM2jXuWFgDar4XgXIdnxjUXxQ?=
 =?us-ascii?Q?dqPTrpzCbVnP93yKQWd9uV7Y?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cf433987-be5a-4648-5692-08d8f3bf38b3
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3370.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Mar 2021 21:03:09.0334 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ewsEjLSg07YP1irAjt0AIPfg+p+U/1lhTW5SZX8eZz3pSgTgUNKbFYeGYaGFyL5c
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3370
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
Cc: Amber Lin <Amber.Lin@amd.com>, mukul.joshi@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Power Management IP is initialized/enabled before KFD init. When a
thermal throttling happens before kfd_smi_init is done, calling the KFD
SMI update function causes a stack dump by referring a NULL pointer (
smi_clients list). Check if kfd_init is completed before calling the
function.

Signed-off-by: Amber Lin <Amber.Lin@amd.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_device.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device.c b/drivers/gpu/drm/amd/amdkfd/kfd_device.c
index 72c893fff61a..3cd46d7190b3 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_device.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_device.c
@@ -1297,7 +1297,7 @@ void kfd_dec_compute_active(struct kfd_dev *kfd)
 
 void kgd2kfd_smi_event_throttle(struct kfd_dev *kfd, uint32_t throttle_bitmask)
 {
-	if (kfd)
+	if (kfd && kfd->init_complete)
 		kfd_smi_event_update_thermal_throttling(kfd, throttle_bitmask);
 }
 
-- 
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
