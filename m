Return-Path: <SRS0=d4Si=JU=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF444C433ED
	for <amd-gfx@archiver.kernel.org>; Fri, 23 Apr 2021 15:36:10 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 61BA8613B7
	for <amd-gfx@archiver.kernel.org>; Fri, 23 Apr 2021 15:36:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 61BA8613B7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F2CD36E139;
	Fri, 23 Apr 2021 15:36:09 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2073.outbound.protection.outlook.com [40.107.220.73])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DB4B86E139
 for <amd-gfx@lists.freedesktop.org>; Fri, 23 Apr 2021 15:36:06 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mU99EhFVMCANqrrmEs89kStvRy+ixC/Hh2vIWlsvjwyoEWpRevXMJDr7U2hjVy6Iut2AHT3ydc7DW1OJDu6unl9LxH2ErUT7YlxqlnvppTdhITWXstJm39ERtyuMeNUHNbcBa+7d9HIuZb4Xw5QEVzNbnGyGmNoLmHEfhn0G7MRPxo+fPbNy+rkIcs9twP1Niag0eiwK5oEF+cfQ1SlMXuto9L2oSY37S3Nd34QEJAzlhD0nNrf4Aki3xY3KnlSSGRm2uVohY8wNe3P5oaye0IrtpmxwjbbhpZLayFapS9u/b0ewkaO93neRpVwJBSFY9txcrIPxqYKRAmhWIPkbYg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ULJ7d2JdhvtEVYgX8s/vlODaH0jP/8Cge7KZdFeczRE=;
 b=ciLyAjHKTL/rHfOnYlpC5QH/Mgm6zZ0Vmq/NNFlMYEBHJsBpqWgDWZZaR3YUSekUx1ygN+lZyFehWDv9TC7e+4CFtjlsJMO1DbagJ6Y5rprsRZEbdTD+dok8z5gEAhRrVi1Y7urD3tY0NkqjKLgFV+a6W7l3E6XLJMePFp3mlFwSsHUvYR0g3+EadWvKIwf0ypMhQ1grZC0qe+WVxGl6kE9DCVudpqTN1W2RJnXS7n9iNGY4VQq5QL5iyGF7A6e1x1bB2X5CeJC/UEzZKSWJydOIlLmE7tZh3m3F0zJDQJLHxIaPUyOZy9iZHxS+1EEXGvuQZOlbKhzBiq9bzBqV0g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ULJ7d2JdhvtEVYgX8s/vlODaH0jP/8Cge7KZdFeczRE=;
 b=kOGR22mKh5ZfE68ti6Qq517nuP+QkzX0jflwRBhylBD1qU2xNGKkEYRSoOGbywRr/mGUyo3QHbukn72Z0/UGE9gwzZKwQssenHKk5Tr+n56mDb51Un0QHfjmJfV5SM3M5yOC1QH/1COa8OlNAc8W2yY2DV2ae22c63yuRIMBUh0=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from DM5PR12MB2583.namprd12.prod.outlook.com (2603:10b6:4:b3::28) by
 DM6PR12MB4810.namprd12.prod.outlook.com (2603:10b6:5:1f7::15) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4065.24; Fri, 23 Apr 2021 15:36:05 +0000
Received: from DM5PR12MB2583.namprd12.prod.outlook.com
 ([fe80::d568:cff1:dc2a:5baa]) by DM5PR12MB2583.namprd12.prod.outlook.com
 ([fe80::d568:cff1:dc2a:5baa%3]) with mapi id 15.20.4065.025; Fri, 23 Apr 2021
 15:36:05 +0000
From: Philip Yang <Philip.Yang@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 5/5] drm/amdkfd: enable subsequent retry fault
Date: Fri, 23 Apr 2021 11:35:50 -0400
Message-Id: <20210423153550.25188-2-Philip.Yang@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210423153550.25188-1-Philip.Yang@amd.com>
References: <20210423153550.25188-1-Philip.Yang@amd.com>
X-Originating-IP: [165.204.55.251]
X-ClientProxiedBy: YT1PR01CA0094.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:2d::33) To DM5PR12MB2583.namprd12.prod.outlook.com
 (2603:10b6:4:b3::28)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from Philip-Dev.amd.com (165.204.55.251) by
 YT1PR01CA0094.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:2d::33) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4042.21 via Frontend Transport; Fri, 23 Apr 2021 15:36:05 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 57523731-99ad-4261-cb40-08d9066d824c
X-MS-TrafficTypeDiagnostic: DM6PR12MB4810:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR12MB4810B1A884403B4A7F096695E6459@DM6PR12MB4810.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3631;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: So9OyPnvSmScX/UZmgTee0wjcApUHBvvuZFT73SHnmFIP/2h5jKGa79ZzpbUvEf3i10+2l6AcesYo/X50N4dAAZouvBT+mOQkwkpK81mM25Zu9bXpIYBCH2Dk2F9Ad97U/TNDO7tt0eub20rsTwKuOCVxegAMxKs2JR3JU8vSFB2bf+/0GnKislPS19qPi84zJgRZMg/x4b3VXd/BRz7O5o10ASi6JKlsupdxF7/X1V2+9Wms/LDCt5pTMpgcG5UlSSifnG8dGN+EKkb8RMMcqyz2pnQKKJ9ntROEwXsd3WPyhJuxKN5p3J6l02KCbIdL+096iHkxv9nCRtHQbsh7lpNP7MkIWDZ6oFuWu/ke6WDUDPIOP8Go8/fa26EpH8d+XeM+f7N6zuXx1CxaLBjSp5CL7gR/YbIXQN9AkR983g2F6bCWjAd2KY9uNfcdOE02V2J0IyGLyvENbZvTvaThYY5zvvyanFHav0SbiNpqn3Tlx7/yN4rBWuFCFk2l6lusDGzh8cz/upVPypOE/gZuXYIs5QgXKRGkP+ihtqdT0i5KHtFemSy5wGkGmvytTkM00xSaIXJNVrDohn+G3YZ04LWYVm5gWrtIaCjNXjuODnIlQwTpjO4LcOCVQ1rS3BztgOL5D0R1VIYxwm3pt9gOHXostorDA1MqUBurU/i7Xs=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM5PR12MB2583.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(376002)(366004)(396003)(346002)(39850400004)(136003)(6916009)(66946007)(52116002)(36756003)(2906002)(316002)(66556008)(66476007)(6666004)(8676002)(4326008)(8936002)(7696005)(38100700002)(478600001)(2616005)(86362001)(186003)(83380400001)(38350700002)(26005)(6486002)(5660300002)(956004)(16526019)(1076003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?43ZWU0knyS9IwibKZ5s4gn2d3D1AFjqcqWepxJQgpn8HAtfi39XfJtfK682E?=
 =?us-ascii?Q?Nv32eikRXX1uhnkGN/GfDCjW3Oki+rvACM+quNKPR67KQe5Pp/R6LzIPBCAs?=
 =?us-ascii?Q?vmmmLmvPwT1j7Cj/q5Td0maQFlpgKBWqcycmQQVVaCqfCbrieEaa8ZPvzIex?=
 =?us-ascii?Q?pI7u7jdcRzmoLAgnVsU1CnJ21nvPOU1Hfg81Vb/OYp0Tmppvm4vxzA3cRiod?=
 =?us-ascii?Q?qcNcDbHEPnVMFoZzaJPEJnkRvUZzjyA5RMeVjT6mgrxgPoDD9h30vQNfUqJL?=
 =?us-ascii?Q?siAsnk9eyWvwKKrWErcsxoZF/TMAb8RSCNNVnbo4y2e0DT64dKNNh5kV96rw?=
 =?us-ascii?Q?XxxH61qmHmEnFBKKtVVCKQo2MA4/8h7KTppfzkaxcqZKlRXYpr6TZrPRlHwN?=
 =?us-ascii?Q?v0YzSetalh4WoiJX5kO5FsDCo3DurW+vm0F58fKb0qPEAXAN4zf3eZW0F3T/?=
 =?us-ascii?Q?qnYx3s+E5iTOPg8QflK6GnpNA7p9IP/v4QZ4S20eJyk4/5S5+ueoY56uRos1?=
 =?us-ascii?Q?GxaPgeLZlmp02tZJkIVK4O14I/WSrUxqOQ0p46kEYF9ghj2XQplj8IRdycq4?=
 =?us-ascii?Q?c/HPtLpYyHSEugd3o8Jdr02x9bcg8zA32WdlkvdhKkC4Kjq+Iz0yU5mTzzbX?=
 =?us-ascii?Q?wegtVMecYZ2c0FzgT2lUl4asWt5ie3T3IYAG3eIC9mBA1LHYBYoU8CfNVwjT?=
 =?us-ascii?Q?Y7psOk92kJcI5u4uHUWlEPTkyKBeI52h7SPskUXSOzRpTZ6DrWzOFDxTS54P?=
 =?us-ascii?Q?uS3DstqUPrrN11FepMdm5p1q/9AEpmPy66T93YwzwiN8KGvuqDHCrKrKOZDH?=
 =?us-ascii?Q?fzqGqSud97UI0aKVrFD0mU6pJh8lFQdFwJSYwzouz77tsx5iotufEEjwQOtn?=
 =?us-ascii?Q?Rb5DObm2TlFZr8SOcowLYbVJK0dyaGTSTkwffJpLUv5t0EGTVuGwyBbDhUvg?=
 =?us-ascii?Q?Pdcno9jrm58PbsDQlJwQbYP9rkDDdz8Njhg2HrLtbe8K+eDoSGLeofjV6qDc?=
 =?us-ascii?Q?9yV3mIn5/ex5vTpo4iEiOTHZSd/P5gn84XC7fswdJlEd+IfUyDlJACp8FgKV?=
 =?us-ascii?Q?RFLId6AidVgMxGBAADfHPlWstyMx6Q505mGi6Xl6f6s7ztF8ckTwjacbHUPq?=
 =?us-ascii?Q?F9cJmuDxtkBy/ipAjmI4odGPd9Ur9LrgsqC9tardEHWcYn0dpccKG4+T/B3I?=
 =?us-ascii?Q?ntx2SvjqCsdNIG0trf7CKUVxX6Xw2N4eyH6KPP7+OqOWULqzD8iff+597KOw?=
 =?us-ascii?Q?jxCpaGiCGD5Xytb4bc06xwohC9w4cl4weX6qVbRDBcc4jQGA+xTEHMf6AQuN?=
 =?us-ascii?Q?ZcRRQPVTxvTMwWNwMqIlCyIn?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 57523731-99ad-4261-cb40-08d9066d824c
X-MS-Exchange-CrossTenant-AuthSource: DM5PR12MB2583.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Apr 2021 15:36:05.7967 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YWUHa7f9Qv7+X/vJqIKzAf9Cix58cuQmo+83EVcSfP1RqD4Qw7nnzD24EBQZgreE
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4810
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
Cc: Philip Yang <Philip.Yang@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

After draining the stale retry fault, or failed to validate the range
to recover, have to remove the fault address from fault filter ring, to
be able to handle subsequent retry interrupt on same address. Otherwise
the retry fault will not be processed to recover until timeout passed.

Signed-off-by: Philip Yang <Philip.Yang@amd.com>
Reviewed-by: Felix Kuehling <Felix.Kuehling@amd.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_svm.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
index 6490f016aa6e..5ed7dda2d14f 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
@@ -2363,8 +2363,10 @@ svm_range_restore_pages(struct amdgpu_device *adev, unsigned int pasid,
 
 	mutex_lock(&prange->migrate_mutex);
 
-	if (svm_range_skip_recover(prange))
+	if (svm_range_skip_recover(prange)) {
+		amdgpu_gmc_filter_faults_remove(adev, addr, pasid);
 		goto out_unlock_range;
+	}
 
 	timestamp = ktime_to_us(ktime_get()) - prange->validate_timestamp;
 	/* skip duplicate vm fault on different pages of same range */
@@ -2426,6 +2428,7 @@ svm_range_restore_pages(struct amdgpu_device *adev, unsigned int pasid,
 
 	if (r == -EAGAIN) {
 		pr_debug("recover vm fault later\n");
+		amdgpu_gmc_filter_faults_remove(adev, addr, pasid);
 		r = 0;
 	}
 	return r;
-- 
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
