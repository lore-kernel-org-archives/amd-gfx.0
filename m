Return-Path: <SRS0=V/Q8=BI=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92BC4C433DF
	for <amd-gfx@archiver.kernel.org>; Wed, 29 Jul 2020 02:57:20 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 66AF42076E
	for <amd-gfx@archiver.kernel.org>; Wed, 29 Jul 2020 02:57:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="GUZ6JMdq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 66AF42076E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2EF056E43B;
	Wed, 29 Jul 2020 02:57:20 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2088.outbound.protection.outlook.com [40.107.237.88])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D47596E43B
 for <amd-gfx@lists.freedesktop.org>; Wed, 29 Jul 2020 02:57:18 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Z+hwcBdEsQ6rAnikMOgu8zNCATM49dqjp46OmFuUgzUmwDPgRsmF2vn5v/8w+0aYrQhlFSG6Rlp+/wxSSbqtF6uQxcMy3/nf9SoCvFjxYsPcb2a7pNzaplxYSSVAh4nr6OrCYuOJag+U27HorJ1+g8Zl4wwxYHdHEBk9QySdAqtafVtnxHAjWGF3I0613uETQ8Vdj4cAHqI8ko9N7sqsDRiq8QPYUPBlB24HRlGGNL9ExNdtNKkNvVyLWMu1rOX6vGE5GE08eBeHrrkE0HV353g0Dyc9GlNm+MvkQI2m1gmSnU3bh1Bcsde5t1QxDtjBtDPfzbhybEqej+Fh8RCVww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PJZmx/VeBMz2JxJ9BKEq10bWvnIE7p6vnF/VlGScpss=;
 b=ERwb4lxgYAvkU7FWxQEhpnHq9ddy0nzFM6mKQyh5pMOmkaxNXroFJF5K8Y+S+tcjkr/j69ekKbvE0/9PXsO5ZubZOn+yxSk6MsPARngPvFec5DbptPVL7iHStvU/TI9AjkSDMpAZrdP2M5kgA1HCqs87QfuS5JpLuCrY4BEE82SyLo42pm7rThtCdzAsEF7PaA1OWMgxZRePhXD0Njpbs8t6xHfEhNNsqy1tZkLxPvnUxUSgX5hTqTsC9f81sfNogroiI7Q+ukGWUfhWo8h3ZyVXQoqMshSlDeTyePypCMqUhGKhmHV1Zt/lYIt5qy4NWVUKyVWHHnqB9Q29tVnF9w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PJZmx/VeBMz2JxJ9BKEq10bWvnIE7p6vnF/VlGScpss=;
 b=GUZ6JMdqcPDnPV67r2bzyPFEkhIyVPlFCt78rsoz+zre/cTgffJK6vrixrLsgk3XueSU2I+6COTN8S+tASHNGXVz4ki+gl9YsQA0sOtEgdRaqcrx1mKnLf1ZTcKXZznjkszsl7FL2QvqfcaCVpkTO6id6bZL56gVpfn6vzu+MiE=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from CY4PR12MB1287.namprd12.prod.outlook.com (2603:10b6:903:40::8)
 by CY4PR12MB1285.namprd12.prod.outlook.com (2603:10b6:903:3e::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3216.26; Wed, 29 Jul
 2020 02:57:17 +0000
Received: from CY4PR12MB1287.namprd12.prod.outlook.com
 ([fe80::e0b1:48e7:bcbc:351c]) by CY4PR12MB1287.namprd12.prod.outlook.com
 ([fe80::e0b1:48e7:bcbc:351c%11]) with mapi id 15.20.3216.033; Wed, 29 Jul
 2020 02:57:17 +0000
From: Guchun Chen <guchun.chen@amd.com>
To: amd-gfx@lists.freedesktop.org, alexander.deucher@amd.com,
 Hawking.Zhang@amd.com, Dennis.Li@amd.com, andrey.grodzovsky@amd.com,
 Tao.Zhou1@amd.com, John.Clements@amd.com, lijo.lazar@amd.com,
 christian.koenig@amd.com
Subject: [PATCH 08/12] drm/amdgpu: restore ras flags when user resets eeprom
Date: Wed, 29 Jul 2020 10:56:25 +0800
Message-Id: <20200729025629.19355-9-guchun.chen@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200729025629.19355-1-guchun.chen@amd.com>
References: <20200729025629.19355-1-guchun.chen@amd.com>
X-ClientProxiedBy: HK0PR01CA0066.apcprd01.prod.exchangelabs.com
 (2603:1096:203:a6::30) To CY4PR12MB1287.namprd12.prod.outlook.com
 (2603:10b6:903:40::8)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from guchchen-System-Product-Name.amd.com (58.247.170.242) by
 HK0PR01CA0066.apcprd01.prod.exchangelabs.com (2603:1096:203:a6::30) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3239.17 via Frontend
 Transport; Wed, 29 Jul 2020 02:57:14 +0000
X-Mailer: git-send-email 2.17.1
X-Originating-IP: [58.247.170.242]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: aeebf672-aba7-49e5-b654-08d8336b1a6c
X-MS-TrafficTypeDiagnostic: CY4PR12MB1285:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <CY4PR12MB1285D61BBD397D117C85CA3DF1700@CY4PR12MB1285.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:428;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: iuW9EcrsjG1scxznVZXDTODTM7CErmD6aSv1HZSsCuH6qCnrisRceDbziykYqMni7tC2feZVKf9e+jPPm5sXWRG89W3I5xvq8suAUFpkIGjicPpz5JirqPn4wOPdrSxIb3U5G8Otl+R4ixwrFwH2lJQjDDfMPXFHxbh50YqqXDTjaDlSSdvGEfgqEZ21TDtzBX/Kuhs+aCfT2NE7pYnFfhzTWcDRKEVKF+rlPeA4kXAOoYmakoIH0FzbNS0kV3V61Ff+rDQRZQsrn2LXlSYSbK5pt55kvP7hr4+jCKOPBb1ggLkhP60Mhbg1Hp/P4zSId0xO4sKSmmJ/MzBt6fEbpw==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CY4PR12MB1287.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(366004)(39860400002)(376002)(346002)(136003)(396003)(26005)(2906002)(66946007)(6636002)(52116002)(66556008)(8676002)(86362001)(66476007)(186003)(7696005)(16526019)(6666004)(44832011)(36756003)(5660300002)(4326008)(1076003)(316002)(8936002)(956004)(83380400001)(6486002)(478600001)(2616005);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: oifj5F184x25Yw7/N0YKQSFb9ofXmIbcUT4sgCpEyGb7L1yYu/Y0hojl4HEkNnycmtBUN+QFatndIT2o7nvzgsn+eEuCFB/OqbwbBkcT8xfac5arOpDKpVsgvXAIe3Xk7FbVccQxEYAqcAAA+ehT77KkNL+1l5fhzkoM8gJji+2DJDSMKMPTk1jKJyZ/65SFmVWZCiR9SmdSYjCZ2nezodkWphTL6D6DfJ32Xh/cDSVJoTNZkadm58GFo9tczhDtrAGLDTy+L2BlIQTc64DPWsTMLWDpPF8oARMaUYI087wTpAYtU+nRQzTss1ZgEPcxcrwtNUGTlN1E2O0ZvW/D7mKDD29GUXMXNOgxspp24CrvXVh13YHcjNSgfaWyHURWG9yaRUYeboz/inUdgyGb6+c3Lp2CCUFWBqJmDk7oD7RP1cG0vkKxta8eYO0U9aMLPIVgyB+His5S3aQHbPjenXGZPkj5+Lx/i9QtlrnkLjQR5VXKLsuXxlx0QSymqjfb
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: aeebf672-aba7-49e5-b654-08d8336b1a6c
X-MS-Exchange-CrossTenant-AuthSource: CY4PR12MB1287.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jul 2020 02:57:17.4792 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +7iMjhFX3HNk0ngrzD6PNRAstVf2903g/J7IXX7KzcBjKHB+bwluTHet0Ur0ez/L2VRKqZfFvjKwTuuV+ohTYA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR12MB1285
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
Cc: Guchun Chen <guchun.chen@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

RAS flags needs to be cleaned as well when user requires
one clean eeprom.

v2: RAS flags shall be restored after eeprom reset succeeds.

Signed-off-by: Guchun Chen <guchun.chen@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c | 13 ++++++++++---
 1 file changed, 10 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
index fab6f8d6bee6..c519948ebcff 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
@@ -368,12 +368,19 @@ static ssize_t amdgpu_ras_debugfs_ctrl_write(struct file *f, const char __user *
 static ssize_t amdgpu_ras_debugfs_eeprom_write(struct file *f, const char __user *buf,
 		size_t size, loff_t *pos)
 {
-	struct amdgpu_device *adev = (struct amdgpu_device *)file_inode(f)->i_private;
+	struct amdgpu_device *adev =
+		(struct amdgpu_device *)file_inode(f)->i_private;
 	int ret;
 
-	ret = amdgpu_ras_eeprom_reset_table(&adev->psp.ras.ras->eeprom_control);
+	ret = amdgpu_ras_eeprom_reset_table(
+			&(amdgpu_ras_get_context(adev)->eeprom_control));
 
-	return ret == 1 ? size : -EIO;
+	if (ret == 1) {
+		amdgpu_ras_get_context(adev)->flags = RAS_DEFAULT_FLAGS;
+		return size;
+	} else {
+		return -EIO;
+	}
 }
 
 static const struct file_operations amdgpu_ras_debugfs_ctrl_ops = {
-- 
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
