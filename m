Return-Path: <SRS0=Inwe=AH=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB212C433E0
	for <amd-gfx@archiver.kernel.org>; Fri, 26 Jun 2020 16:12:56 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 91444206BE
	for <amd-gfx@archiver.kernel.org>; Fri, 26 Jun 2020 16:12:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="ARDXcXcB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 91444206BE
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 54E0C6ECCF;
	Fri, 26 Jun 2020 16:12:56 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2081.outbound.protection.outlook.com [40.107.220.81])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0E1C26ECCF
 for <amd-gfx@lists.freedesktop.org>; Fri, 26 Jun 2020 16:12:54 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BnWkkfppqxkfR+qRJVxVFCd/rEZsJPTZIZsK8+4W3cI9UBuxc1S6D+XMtEhG8GAvn7vdcjqNSoTkT6d8699I2aWCXq3j6K236/LWwpHjNYOaqpo4GKFRZJeKgNeTE6BwcVDoTKYSX35h6CWAdID6KnFOnKkSfq3/A9nqVqLWeUOHc9clnhdBxkgYgA0TELJoxSJRFY9eznCrLPJszL8mN4dsj0q9WOishM0qu3BVlKIQKEur2eeNJVGYXJJJdAT9uXorISGDxTNuxWEPXyuc4UHcw7XlEjdymD9wrCP7wQa6jeAnagVoXoG7bTSYmf2RQ149SmZgnUMRKHMTyJJzuA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RFNfPIob6ySHuC8W2E2Uaiz0cCf7SzVSwTUYRAgH1rA=;
 b=i8ggQY/W0zH7vse5EPwbGuqlHI1QjO7e3SWr8FMNmcxnqBhtN/mRdINLHCo4rXLzeXqYWyDkO8O+hvVMT5X3mawJBLKf3GCUPEGVeF+BG+A1bpNPMdV5eJMs/8NfkASpcduwFdJ1sNSkYKeKaRn9ga0gH96s1DpH7xxfG1zYCcFngNYcOFac+Z3/8iorFuPGlx5T1p1l1oxFnVRFho2YvivGDFStR9PjO0ukRVswZzYtB0JKALxzMTDA1uI2v501Fu/Lr8lIPJ0sCNijj0gcw2SIYpDeSftoaoDH9u8lPaRLxek8eJDKeovZTguy8YEKDGBJAw3WikJJfm01vKjvwA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RFNfPIob6ySHuC8W2E2Uaiz0cCf7SzVSwTUYRAgH1rA=;
 b=ARDXcXcB2gwqpE2xGCeGKHqiVQNXHHLoDD4uakH6vx1uGfBACK7oF/gtiN5UDLgVw7WEDvrF3dCaGyF/zs87dn/K9ueP0JEqlERUeVgrSFcQcZ1zXCfxlv3U2zPDNBMY4pUlmYJuzSu67eiaV0U1plR9e5NlyjjFC5p21GHessA=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from DM5PR12MB2422.namprd12.prod.outlook.com (2603:10b6:4:b9::27) by
 DM6PR12MB3225.namprd12.prod.outlook.com (2603:10b6:5:188::19) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3131.23; Fri, 26 Jun 2020 16:12:54 +0000
Received: from DM5PR12MB2422.namprd12.prod.outlook.com
 ([fe80::5894:5a7:8db9:327b]) by DM5PR12MB2422.namprd12.prod.outlook.com
 ([fe80::5894:5a7:8db9:327b%4]) with mapi id 15.20.3131.023; Fri, 26 Jun 2020
 16:12:54 +0000
From: Alex Jivin <alex.jivin@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH] drm/amdgpu: Adding wait time before reading upll control
 register
Date: Fri, 26 Jun 2020 12:12:39 -0400
Message-Id: <20200626161239.19762-1-alex.jivin@amd.com>
X-Mailer: git-send-email 2.17.1
X-ClientProxiedBy: BN6PR19CA0080.namprd19.prod.outlook.com
 (2603:10b6:404:133::18) To DM5PR12MB2422.namprd12.prod.outlook.com
 (2603:10b6:4:b9::27)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from alejivin-ThinkPad-T495.amd.com (165.204.84.11) by
 BN6PR19CA0080.namprd19.prod.outlook.com (2603:10b6:404:133::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3131.20 via Frontend
 Transport; Fri, 26 Jun 2020 16:12:53 +0000
X-Mailer: git-send-email 2.17.1
X-Originating-IP: [165.204.84.11]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: ec78f104-1e21-4721-14a9-08d819ebc804
X-MS-TrafficTypeDiagnostic: DM6PR12MB3225:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR12MB3225474838F866AF4D624C7A91930@DM6PR12MB3225.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3631;
X-Forefront-PRVS: 0446F0FCE1
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: oUkqzRsrfWh9Mdk7V+XBzjgVM+BzqqOckZPPoM1pmx6RfOqn7fK2oE/QM5Ewtnaqao/VS2IWBMfpCBo78CRvvVOW4HHqMcVRqAgznAEkHn2svyVRKqKM1tmBwu2l45rvK9JNhnAxj0xnmuW0W1YF+z3vn8Wdj0B2j6P7qbAfRvemKgf5EPl+Ze6vfoJLhYRR/N8qh9phvBsBG2F/qbxqkOBW0d1RfcR6FsBXRx6Nmzd0X4SHDxb0HCVmyIR8VHCur3BUUCWmXy5w8chbVWO1HA1P3A2yHfHeB7ldr83I0HPvZujoNVxtt1ZMDHpnrp6z1mWU86YOpKd2VAhV18TmEQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM5PR12MB2422.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(39860400002)(376002)(396003)(366004)(136003)(346002)(7696005)(52116002)(16526019)(2616005)(6916009)(478600001)(66476007)(956004)(5660300002)(66556008)(86362001)(66946007)(6486002)(44832011)(8936002)(4326008)(8676002)(1076003)(6666004)(2906002)(4744005)(186003)(54906003)(316002)(36756003)(26005);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: CMEhpwkN/bfCOxxhI8hEr6MIG4u9lgxhgsbZpXiemgXwgpHgGeAiFYJqvFXvOTFPVW/EiN/AUxLvqxTUv86inuN7YHRUR02jvWdJtT1tQKsl8O20T8oBJVmWpueGknFJ+d22qCyqZ+4tcXTwj0tNRlqE8tF+N6cq2uaucSUWzfx5FgaGMYa7kHMNY7eM1DJPLjIboOnIRY+UZ0/fCI/RASJefhz10GHEh3gYHOywl2nQD9mODlhemwIxWrUlzmfqfMvSwTXWvXUnGV+l5olkJ3BLqU+NZXHhjA8hzFsDy6DNFOjZWZb3qfKVGHwKRPJDGl2IEeRhknwrVbzKZn39nBZJScai2mTstk+zfWRE/85GlrMzq+zXljsIF7YTbedoTQFOLwyTWuXLvxf/gNY8me0bf3FUAizB2+y8wzRCuVyUOcfyCINCp1p6QtWuZrPzoBzy7m7knFyvtbNR7JP+pl381F2K3Ptu0isfZ/ieW5JmFGDodOIsqUZ+hOToH/IU
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ec78f104-1e21-4721-14a9-08d819ebc804
X-MS-Exchange-CrossTenant-AuthSource: DM5PR12MB2422.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jun 2020 16:12:53.9792 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QGYvbVUGLk7RI93Ed3zdhXWb7p8BcK55PL3tNqchA2ku1CwJhJlUfHgqxazA970zv8BlVeWwzsZMvUgiktOdKA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3225
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

Adding a delay between writing to UVD control register and reading from it.
This is to allow the HW to process the write command.

Signed-off-by: Alex Jivin <alex.jivin@amd.com>
Suggested-By: Luben Tukov <luben.tuikov@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/si.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/si.c b/drivers/gpu/drm/amd/amdgpu/si.c
index 9d7b4ccd17b8..42cdc14fb79d 100644
--- a/drivers/gpu/drm/amd/amdgpu/si.c
+++ b/drivers/gpu/drm/amd/amdgpu/si.c
@@ -1435,6 +1435,12 @@ static int si_uvd_send_upll_ctlreq(struct amdgpu_device *adev,
 	/* Assert UPLL_CTLREQ */
 	WREG32_P(cg_upll_func_cntl, UPLL_CTLREQ_MASK, ~UPLL_CTLREQ_MASK);
 
+	/* Waiting for HW to process the previous write.
+	 * This is to give a chance to HW to act before
+	 * the first read is done.
+	 */
+	mdelay(1);
+
 	/* Wait for CTLACK and CTLACK2 to get asserted */
 	for (i = 0; i < SI_MAX_CTLACKS_ASSERTION_WAIT; ++i) {
 		uint32_t mask = UPLL_CTLACK_MASK | UPLL_CTLACK2_MASK;
-- 
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
