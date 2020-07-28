Return-Path: <SRS0=z2P7=BH=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54B52C433E1
	for <amd-gfx@archiver.kernel.org>; Tue, 28 Jul 2020 07:49:56 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2601121D95
	for <amd-gfx@archiver.kernel.org>; Tue, 28 Jul 2020 07:49:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="4dm+DNLd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2601121D95
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E7D346E1F6;
	Tue, 28 Jul 2020 07:49:55 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2056.outbound.protection.outlook.com [40.107.94.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 553E76E1F6
 for <amd-gfx@lists.freedesktop.org>; Tue, 28 Jul 2020 07:49:55 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LcsHjiB/aG4cuFOR2VTc8p8DjedS/aFu4jPP+aB/TmWlnALyh7RdR2uHtgIWpbxsrAfy7IV1S3emlNJjTjMZHliHKpscu2/MCeVQF+t7ZhXgxiMevCVaaGRMMUHnL/89VpmdTiOEuv8GyOGhLk0W2sB4zcmxEDVcwNZ4BhnYLOl4AGbtyb8JoTaQdDtPnLINaOsRUfQ342Z7OmPa9rVKhxLddTeEWEraruxIsfEQl7yFD0vO1EbUBDLnqKBFjXOmgXtdLMS+HN4mrNqcrBAt+h3xJwiGsqz/ku5jspu/euzHg9qTpLYTi2UiNBCtBi1BPHd2/rMmhPSFwjy0HL16kQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RzJ/nMahNWkwpdlo7Vlq3uxE8BdOtG90gbJJcvJJEA8=;
 b=dEZFMnjFGC94irxbfYE/UxDQOxG8NIriXIqXEo69hcb+rdsTbLuY4IT5OOEI1NXyhE8nGZ45tMt/iYQ9Rtp13ck+15+d/b3bigEH2FvYlD2BNwzP5cakked94zidkXkr/4OJ4RiOA9zoDFs5fU7DbP1ZvN4kvleC5fVSRIR0J5jd0gZX2t+1mMboZ2Y755ONKMQ2Mt6WCXREEDkBZOBy9KuyRoCYpHzQvvXjGgCLpTRcXiwahqvoPrq5XXG7YwaghwomtSyodUfqa6cN2rN66xtGqKC3jAIjZQEe1TlWjtQIYQKQc80iwBkx3xhCwImh5x82b7he7Pen8Poekg+9Ng==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RzJ/nMahNWkwpdlo7Vlq3uxE8BdOtG90gbJJcvJJEA8=;
 b=4dm+DNLdDlSBIAjGFKnZ3lZrQYh5LIiS9oQVI8oOx48lYU9WLtDvSLlZu8VaVmF5ZE3Lf8sJ9U4bcCTtoBWnFdNTd6MDLSwF+vpIZ5RdHgPajgjYewhNh/jegbyUvmBUFf0XFRVc/OZ0aRDcpSoZKFlDptOq37hsnRAwuF53ijo=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from CY4PR12MB1287.namprd12.prod.outlook.com (2603:10b6:903:40::8)
 by CY4PR12MB1752.namprd12.prod.outlook.com (2603:10b6:903:120::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3216.24; Tue, 28 Jul
 2020 07:49:54 +0000
Received: from CY4PR12MB1287.namprd12.prod.outlook.com
 ([fe80::e0b1:48e7:bcbc:351c]) by CY4PR12MB1287.namprd12.prod.outlook.com
 ([fe80::e0b1:48e7:bcbc:351c%11]) with mapi id 15.20.3216.033; Tue, 28 Jul
 2020 07:49:54 +0000
From: Guchun Chen <guchun.chen@amd.com>
To: amd-gfx@lists.freedesktop.org, alexander.deucher@amd.com,
 Hawking.Zhang@amd.com, Dennis.Li@amd.com, andrey.grodzovsky@amd.com,
 Tao.Zhou1@amd.com, John.Clements@amd.com, lijo.lazar@amd.com,
 christian.koenig@amd.com, stanley.yang@amd.com
Subject: [PATCH 00/12] BAD GPU retirement policy by total bad pages
Date: Tue, 28 Jul 2020 15:49:22 +0800
Message-Id: <20200728074934.12490-1-guchun.chen@amd.com>
X-Mailer: git-send-email 2.17.1
X-ClientProxiedBy: HKAPR03CA0004.apcprd03.prod.outlook.com
 (2603:1096:203:c8::9) To CY4PR12MB1287.namprd12.prod.outlook.com
 (2603:10b6:903:40::8)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from guchchen-System-Product-Name.amd.com (58.247.170.242) by
 HKAPR03CA0004.apcprd03.prod.outlook.com (2603:1096:203:c8::9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3239.9 via Frontend Transport; Tue, 28 Jul 2020 07:49:50 +0000
X-Mailer: git-send-email 2.17.1
X-Originating-IP: [58.247.170.242]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 3138d83a-5846-4a70-9b22-08d832cad0a7
X-MS-TrafficTypeDiagnostic: CY4PR12MB1752:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <CY4PR12MB17529B96CEC6DCD2A496FFB1F1730@CY4PR12MB1752.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 62rFgF3HRuYRL5hDSMGl6HI8UkacEKeoDvXVj28RBmSfjDjoBE+ksqoAcCO4a/sGfhNsrSzof07qv4BmhtnCerZkKwSH3b6sXmjzTcQMBNnl35tPfdnjWYvCe72egsP9Jmhq8Hksd6kqC2Y21FCwm6CrVtnIAIBhuWWqMCIJRBRzhqdlZjFuAal4iazdtJlfZPscBHCFIQ4WNA8bXStzaxS8Z7blgtlxmlNhSHB+0vb24NqjaCBx5s5y56tI9jQlNPhsnDmT293UUH1CgILXcneIMZN7GBR5dvkGIWZjQjmsQvl3W2aLcREWxmLmIqZ+cG7Xqw/hQrDQGjPa945RAWfO7pJd3VqIK55eDqC94o6pf7VrWEoL9gJnCqurO+s7
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CY4PR12MB1287.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(136003)(376002)(366004)(396003)(346002)(39860400002)(2906002)(956004)(2616005)(1076003)(6486002)(66476007)(66556008)(4326008)(6636002)(66946007)(52116002)(478600001)(36756003)(44832011)(86362001)(83380400001)(316002)(6666004)(16526019)(186003)(26005)(5660300002)(7696005)(8936002)(8676002)(921003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: l0d6sRqmmXeMPCm3fFBue4ghMUtfAxufltMprNNmoJ4QYbl1m/yYzUQ1bkKnKzHmaIxSq6TsbXg4F52YWlM8FAl27Wo2XXFQS9xsZMAYT5C4bdbxTeFsYKx7LW3Zlm6ueuYu7MXyqWrUi7KCUMp6vnBeDu/In+NtsZ0tNzV3j8qlBceCYDaOYAKHsFOfcAzcwiYpC/5JS6CdLnot65F9oi7Pb2uRl75faWC/2OFKRaNUDYuXmE6Icn3x13pM9kKKxMBfZnik+bdZ5k8gDKDKyO8Hu3CE+O8z6f5ZlX+zT8/sJAU7PWJSofj2obCDD8QYIbTFQK1dW/97te0NXDRGzHhwmIyHm/BjMSb8BQDkYcY3dEjLIli9JZzy/SFNzRR96j2sywxJQ7o0iuYHrwkNSB4ewhwc9E1cTtQjf6chUUHJvDSNqo0q1hcHxyWe0ByiqW/cAHyeVjHTbjdQQx4p4+837G2GPlLKTX0Hyxj0zGSomAFS9EHE1Yi2Fdz9uNUq
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3138d83a-5846-4a70-9b22-08d832cad0a7
X-MS-Exchange-CrossTenant-AuthSource: CY4PR12MB1287.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jul 2020 07:49:54.1951 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0XJkri98l8CHybTK9Up7wUK6CWlGSCHIsLc1hbZwxCXBEXwleoLWK1Lv7LfhOwQRqjFVvsxZb4GMGXDfczvbWQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR12MB1752
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

The series is to enable/disable bad page feature and apply different
bad page reservation strategy by different bad page threshold
configurations.

When the saved bad pages written to eeprom reach the threshold,
one ras recovery will be issued immediately and the recovery will
fail to tell user that the GPU is BAD and needs to be retired for
further check or setting one valid bigger threshold value in next
driver's probe to skip corresponding check.

During bootup, similar bad page threshold check is conducted as
well when eeprom get initialized, and it will possibly break boot
up for user's awareness.

When user sets bad_page_threshold=0 once probing driver, bad page
retirement feature is completely disabled, and driver has no chance to
process bad page information record and write it to eeprom.

Guchun Chen (12):
  drm/amdgpu: add bad page count threshold in module parameter
  drm/amdgpu: validate bad page threshold in ras
  drm/amdgpu: add bad gpu tag definition
  drm/amdgpu: break driver init process when it's bad GPU
  drm/amdgpu: skip bad page reservation once issuing from eeprom write
  drm/amdgpu: schedule ras recovery when reaching bad page threshold
  drm/amdgpu: break GPU recovery once it's in bad state
  drm/amdgpu: restore ras flags when user resets eeprom
  drm/amdgpu: define one macro for RAS's sysfs/debugfs name
  drm/amdgpu: decouple sysfs creating of bad page node
  drm/amdgpu: disable page reservation when amdgpu_bad_page_threshold =
    0
  drm/amdgpu: reset eeprom once specifying one bigger threshold

 drivers/gpu/drm/amd/amdgpu/amdgpu.h           |   1 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c    |  32 ++-
 drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c       |  11 ++
 drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c       | 186 ++++++++++++++----
 drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h       |  19 +-
 .../gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c    | 102 +++++++++-
 .../gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.h    |   9 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_umc.c       |   5 +-
 8 files changed, 312 insertions(+), 53 deletions(-)

-- 
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
