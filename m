Return-Path: <SRS0=h6PS=JL=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96838C433ED
	for <amd-gfx@archiver.kernel.org>; Wed, 14 Apr 2021 15:21:50 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5D02F61155
	for <amd-gfx@archiver.kernel.org>; Wed, 14 Apr 2021 15:21:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5D02F61155
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4F5E46E934;
	Wed, 14 Apr 2021 15:21:46 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2076.outbound.protection.outlook.com [40.107.93.76])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E8B9E6E92F
 for <amd-gfx@lists.freedesktop.org>; Wed, 14 Apr 2021 15:21:42 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TQg/PgRPO8hriKy4+bU2GoOhH7RcixTwN/Dg3WLwxneZQSQVy3fRse4/RTORwPoriBu3ErnyRruLMKOtKokky0PHZfWXa8RPWn58rOdJn3SzMVFEeYLrWpadQyOEbdYzSpGmXIS25NzmO+cB/JK7qiYFThfHukQHdLRbarYAXTfpp8G88tCCOSEvJIqp+v31neo3E49erh/RH+qlVLSlvyUTYGaLAHWv1pMS4LlXssyGswYd9fw/7TN/uas2PtZJExw7G1t0A/5/url4mwZ9J0s6yBe+n4+7zOPWiwi8mVHHZE3XPoptrTpp2kimdeZdBiFcnhRBh2M1hZCubfqD0Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Nyzi2x3Zd0MgQQXS4pPKEQfFYXfkSmDzgeJXHAPn2pA=;
 b=DrIRT/zkafuZjROUgTMvrjlHSF9Q+HQdqVOBsD01JIOnOGHsgiD4CuXomRxbeQl1Nd8WvZMsvo9BLp7Vm2noTDHJrJaoiXqPSFR3MtRaCUwaEJB7cakgMEl78ql3iE2R8Oo7AfoIU3tQJqmICCXNjfOSsSEuVlSzw46eNlbalzDmqUVuEUe8q2UIHumQa8EHI0xc2v9s/LCL/GUI/aLD27Mn7pcnzot/AXI/cw9VB1HTbXaQCEP9nidW//SJ0viMS9J2KAs0cNi+IPowuDSfXBpr7ipyqwCtveMHM1no+Fm0vaRLobmWYnG9ght4XE42IFKQenbaw7ZxAOHPexFZUg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Nyzi2x3Zd0MgQQXS4pPKEQfFYXfkSmDzgeJXHAPn2pA=;
 b=YU0rjRJHlvEGTXcqB3qi1dVIVgFVbeo4v2RBEszfccpu8C02OFwhS1q2SKx7LyMjC+ZafxWmHVwvNSlHXMp8SUMfvSnCygRqSaRcz6a4gT8GqtthS4vz9FsvvIkBTt7VdtXkj/Y2BTSGoI/xy9AT6hZmKS2lRk0ILJ2A9nbK66o=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB3962.namprd12.prod.outlook.com (2603:10b6:5:1ce::21)
 by DM5PR1201MB0219.namprd12.prod.outlook.com (2603:10b6:4:56::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4020.18; Wed, 14 Apr
 2021 15:21:41 +0000
Received: from DM6PR12MB3962.namprd12.prod.outlook.com
 ([fe80::cc66:8fc2:7029:d660]) by DM6PR12MB3962.namprd12.prod.outlook.com
 ([fe80::cc66:8fc2:7029:d660%4]) with mapi id 15.20.4042.016; Wed, 14 Apr 2021
 15:21:41 +0000
From: Luben Tuikov <luben.tuikov@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH] drm/amdgpu: Add double-sscanf but invert
Date: Wed, 14 Apr 2021 11:21:26 -0400
Message-Id: <20210414152126.24685-1-luben.tuikov@amd.com>
X-Mailer: git-send-email 2.31.0.97.g1424303384
X-Originating-IP: [165.204.84.11]
X-ClientProxiedBy: YT2PR01CA0022.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:38::27) To DM6PR12MB3962.namprd12.prod.outlook.com
 (2603:10b6:5:1ce::21)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost.localdomain.amd.com (165.204.84.11) by
 YT2PR01CA0022.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:38::27) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4020.22 via Frontend Transport; Wed, 14 Apr 2021 15:21:40 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 0b95d33f-a7b9-411b-8581-08d8ff590132
X-MS-TrafficTypeDiagnostic: DM5PR1201MB0219:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM5PR1201MB02190A334D76C05D69BB9AF2994E9@DM5PR1201MB0219.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:51;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: NMMhoyUg+pJBIMXeHY9CnEonlkL2Eh+3JPKfiwdHadigkWwDOawXpi0O8R82/72vqGCpUxdbIJ8bDEV8Pe4PRTCHG0VPihk/SAUwOEkmzibaY724yyZRBgUpuaEl3/HIhvqZn0hDxlnLAwggDac39HjLvjqSABDeyK8B9IjP2X6X4/a7kyD3gZ8pHKDsVAdPOO822suJmum85aHcL6HiPopHRZWAuM+iwbWW2bd5OYMRIXM/9vF+qTXGHjKVRhFd8v+auYjd0LpW4FM5gii/2gWzWiTb597M437Py+toEuIqL/Y+FZo0ihVleqYPiksIyC+eGI/9GzRA2zFWsPYNngyrM9xiLG7o2S//sLAmoLKo+NIyh5YwtAXiMRj2OozfLfeJWuNlsJSiyXkqaet1CgJvz7fZqPWcVwz2sTr4A+IuJVWIufdk5Qyq9m5s1N9aLSiau8U6YOTuzyHUMGQ3MK5NM3r24xQ0UeaC5DpN5wQkSzVJ9A3HmaSA40VFZzk7/HQNS+xPILoSYzFdUKPcq2qt1E0e2H9bh5pAOsKIaYeL35sn6E48jqqIn7+/O2jz5L7mbGxEb5CBFdeVjH7R4sEFoCTDTfRnPNhFJGZyfGopTN87WolgviLgxpCPB4/ILzQOE/tX4VQ1WRT+5JSpQA==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB3962.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(39860400002)(366004)(396003)(376002)(346002)(136003)(956004)(4326008)(1076003)(2616005)(38100700002)(36756003)(38350700002)(2906002)(54906003)(26005)(6916009)(86362001)(8936002)(83380400001)(316002)(16526019)(52116002)(7696005)(44832011)(66476007)(5660300002)(66556008)(6486002)(186003)(6666004)(8676002)(66946007)(478600001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?yFgT8/ce+D3Bao77AJ04fmY2vHKh8fbyZw5GYJwwd4VvToDziF7+ZerjSxN4?=
 =?us-ascii?Q?CKh+HRjjI++UTFvjg9UjLi/fCULzCpKJCPj9MsuPVrcu6SqrlNtB5Cm9scco?=
 =?us-ascii?Q?IRLI8SzHeq4SOUuPvn6qPvJSAi0faHDAv32hDL5sAz4mNnoto/bL+OrvXBxk?=
 =?us-ascii?Q?2vDzx7u0x5WQGszsxBdqR04fUa2zgUvmBFYgvpJ2/9htHuqApL5R0Q07/WJc?=
 =?us-ascii?Q?SrY0uHRk7L8M2jSmHXCQ/GzqA5UPLUW6DiSToiAjwLxxdWg0IBFZnx56R3kU?=
 =?us-ascii?Q?b8d039DTlTNn8bIadXVXAmCbtNIa8xC39WH3PkDVEBtJidPbeJiuNfAjrmiL?=
 =?us-ascii?Q?nv+Y6gQDiOQlRrnZJj5dx4oKjIcMVmBpfMu2jLRN+IpwYYj9+KDqyNY6A0hu?=
 =?us-ascii?Q?6HARhwfVcfrhKY4yLOlWBPtxbI27QghGw25O0bk72QYET1Cb9KkB2m4qRC/z?=
 =?us-ascii?Q?njMxpa/S8dVXBOMefQekcCLJ/56o0dK9kfcJ0dCx/b2Dl8eaYmZenmveojHV?=
 =?us-ascii?Q?cESgIit8IBjAVagttYetCrSl5cH4ismEPxitHyhoh4WnaRw59mjGZmDxNbSf?=
 =?us-ascii?Q?wlA7Tkjk/FrYcOhfTgbozm5IdMEplO5Rr8ScV13FscXrxtWKxIU1tU6TtU/M?=
 =?us-ascii?Q?jQUO+VTK417xOBDiVxQ+ZMGd/5IZc3H60IcqhTR1QtL+w0TT9ZoEws1lw6bE?=
 =?us-ascii?Q?ho2OsIVGNwA6YyLMpsbGOR4faOvlqGu7pRYXgRe80CkDhi+5Mz4L1BTjtK7b?=
 =?us-ascii?Q?7oO7u/to30VxBYLfEE/KxUjK6bqR2cUT4NBogcxO2bSNFUj580ztx30Jdnvw?=
 =?us-ascii?Q?4TgbRikpf3BedniM8r1LRfMn6UsAHIVQnjxd+X0NgLaBcMqrmufETSY0znhl?=
 =?us-ascii?Q?HwomCA0Dc7+cTrpWLUJXgraywDEtNASadQjqAlvWCnrKq0IRREZkjBoz/yne?=
 =?us-ascii?Q?NzwBL+hVzbL8YTWlX0GeV8VfLSCtB7Lm/s0mOlwrFj3Sx1XDVs8w32bqKV//?=
 =?us-ascii?Q?hW7I6A0fa3JLJoA40hdNwtrtNVP0glLszVwQTaEkbaC3hiPXWZdxNRNNZF6G?=
 =?us-ascii?Q?rlUgACJ62lAfaCW/fCkUrTd0EXfbRKWrPZdJCrk1FkwZ3VT+rGtqpSS6EFYH?=
 =?us-ascii?Q?/vyWA4ly+vDx41fk+m0qcEQuK6YwIxSgmY315NFnj1Eip4I+Y2oDI36TiHko?=
 =?us-ascii?Q?Y82n5qnqZziw2VwTimVm5GqQClOFcN586Hf3BKUsVHp108OrsfuLv/4gsnJO?=
 =?us-ascii?Q?SayNfFieCDfVm5Y2X4ImHv6xTSKiVhDqi7a5XstCbtNweeuuRL4M4TWsLNuU?=
 =?us-ascii?Q?m/KPXAWEG0sA7Yh2Dmehzzkj?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0b95d33f-a7b9-411b-8581-08d8ff590132
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3962.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Apr 2021 15:21:41.1894 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: U+bw2gZQcfs/nK6ibkrScxMol1YyDvtBh0u111d/lOhFomR0FzOCY7Bwjpmkq1Vy
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR1201MB0219
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
Cc: John Clements <john.clements@amd.com>
Cc: Hawking Zhang <Hawking.Zhang@amd.com>
Signed-off-by: Luben Tuikov <luben.tuikov@amd.com>
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
