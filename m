Return-Path: <SRS0=nWm5=BC=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6EBCAC433DF
	for <amd-gfx@archiver.kernel.org>; Thu, 23 Jul 2020 08:34:16 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3DB872084D
	for <amd-gfx@archiver.kernel.org>; Thu, 23 Jul 2020 08:34:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="3u/1WFpq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3DB872084D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0E30C89C03;
	Thu, 23 Jul 2020 08:34:16 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2065.outbound.protection.outlook.com [40.107.236.65])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BD8E489C03
 for <amd-gfx@lists.freedesktop.org>; Thu, 23 Jul 2020 08:34:14 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BjhYmryntUz3V1S7sKtknIWtiq5bl3gCMAGjmDh7GJQeka4Rfi8+ig5fqiXOjPnVRu/thkeX94mcAF2hbpU5d6GAGlJZySgREmU2yQxRGxqMDg3zpjPc/2d1J1LeCUtgY0Xs0uuWFkmM5oTfNN3158neR+gu0BfkOWa5QfdPvU9M1rscnvcpQSDQB1E3YcJpMeDeB32kGyxyeqSHVUT5/hi2I0RDBG6Cn7Gl2VtrJqeMSCexCsPr1vLrSFMh+YcFwhpUNRRAIKXtj/e2WfCgQrFvQWmsSLIZKTTC5ivBzQjyXgRLO3UOV8uNTXjTXYYcoLzBoyhKgT3QyaJT6NRmHw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LkUe+8PJ1tNVstU5wy2upawKyc2Q6lJpcDD1y1mdAhg=;
 b=nhqFrWkVS1Csas4yja5NvczOAa0ZpN0Zk9AH7a4adQeMQW78aWo1ooZcMN3Nv4SaHt/dae8F2/a0zMINfLmZpZmGm9SBGCD3JibZ7n6O76wmk/gbd8ThL5OcWge9VH+Df7LEJY4i1Nj/UjQ3Rx62apIPoOSRsIKpG2S4ueO0EnW6B1GL/UteOw9+BRDElRQAgxtxJDnp8klY0h8aZRLo1wPIqhiKUPheTjIgwA/KhbnoM3nagLRSh+E42DBmrX7J6L2pIWHcS65XKMU91QyDB1rVrPUT6xP+OwQC3Qj0GozpH1LCyDD+V743pqMvBuJGqayszSVUpnos9Xpkk+H0ZQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LkUe+8PJ1tNVstU5wy2upawKyc2Q6lJpcDD1y1mdAhg=;
 b=3u/1WFpq4ST6fQ9YeGQLxmYqsPDegkE2kyFIJiwizJReoroNMO2AYATlxLGln5ZLl7hvvghbung0alopbHG7Vib07RgY7w9ylf7oAIGnFVMVkesZhro7GwPveD8qQz4jfoAISnSLQ61APxrPtSg6+LEJhxdVeueDlstmSEuxpLY=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from CY4PR12MB1287.namprd12.prod.outlook.com (2603:10b6:903:40::8)
 by CY4PR1201MB0005.namprd12.prod.outlook.com (2603:10b6:903:d1::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3216.24; Thu, 23 Jul
 2020 08:34:05 +0000
Received: from CY4PR12MB1287.namprd12.prod.outlook.com
 ([fe80::e0b1:48e7:bcbc:351c]) by CY4PR12MB1287.namprd12.prod.outlook.com
 ([fe80::e0b1:48e7:bcbc:351c%11]) with mapi id 15.20.3216.024; Thu, 23 Jul
 2020 08:34:05 +0000
From: Guchun Chen <guchun.chen@amd.com>
To: amd-gfx@lists.freedesktop.org, alexander.deucher@amd.com,
 Hawking.Zhang@amd.com, Dennis.Li@amd.com, Stanley.Yang@amd.com,
 Tao.Zhou1@amd.com, John.Clements@amd.com, lijo.lazar@amd.com
Subject: [PATCH 0/9] BAD GPU retirement policy by total bad pages
Date: Thu, 23 Jul 2020 16:33:37 +0800
Message-Id: <20200723083346.8743-1-guchun.chen@amd.com>
X-Mailer: git-send-email 2.17.1
X-ClientProxiedBy: HK0PR03CA0105.apcprd03.prod.outlook.com
 (2603:1096:203:b0::21) To CY4PR12MB1287.namprd12.prod.outlook.com
 (2603:10b6:903:40::8)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from guchchen-System-Product-Name.amd.com (58.247.170.242) by
 HK0PR03CA0105.apcprd03.prod.outlook.com (2603:1096:203:b0::21) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3216.21 via Frontend Transport; Thu, 23 Jul 2020 08:34:02 +0000
X-Mailer: git-send-email 2.17.1
X-Originating-IP: [58.247.170.242]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: f8624dd3-e3f8-4c84-10e8-08d82ee328e2
X-MS-TrafficTypeDiagnostic: CY4PR1201MB0005:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <CY4PR1201MB00057BD562D6AD7CD2AA6756F1760@CY4PR1201MB0005.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: /s5mtA0wq46dHV6qgf02hySjiGIZrZIB/1Sm7+69+gYG9fNEq2ZQSTeXbS293od5G+SA38bqWVyC+lTsMPGxQJFAw26wyAY2ak5sLo8Kzt4IL4AzFe6iRkLU7cm9xmidadZmJl9Krrj9xNXZAC72MzRYWXjqBNTikgtRVPV2z5/JQfZbxpWqhVv1y5BcABejYvnBQNJzJKgQrluFtlkvY+5Ao6WlyYqCNDjf+pog7u7MN12FDGTVEhj05VLcItLT+8cQx4wwoh6RZhKk2/BtngNWJu7cqBh0mNMsH/MLWrhZLaNMlISIFxb3NofQBtV1aovUBPrUlT2aM+p5CZD64g==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CY4PR12MB1287.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(346002)(376002)(396003)(39860400002)(136003)(366004)(8936002)(316002)(2616005)(36756003)(2906002)(16526019)(186003)(8676002)(6486002)(44832011)(4326008)(956004)(26005)(7696005)(478600001)(52116002)(5660300002)(66476007)(66556008)(66946007)(83380400001)(1076003)(6636002)(86362001)(6666004);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: 6oA5ITysTdFmGFns/7rNQGM3F3RBnGEPV76ofdXm6wp+BuT4tKP1A32pFuUGU+p+G+ErLhL35N4FDwi3NCdPWh4hbf4fQcVRxiD/P7wn2NSeftlePlNHJPmQBFLswRxMMd6P8n5wq8qB5AoSB3pEMgi5pIe/Ga5LzyxQaOF0vp7+npEns9MXnCQ+eXZB3txcxCgX836LBAleDF4qAj0TXLAKEEcKXuCC4z7VB37c2ULIEq7yWR/UuFXSUfpHxV6KvwPSu9q57DdLG+iX5DWKrPIIIgGT0DYQV8JDmP4NDQ2jvyh8MXfm2zFAnqb6QsHqkWBIVTHwucUu0kHMuf6e3qsJThPiT/klJwi/xnv6rZu8tADcn7sEKgK6fAZn9y++47EEIuv7vFVhd/UA1lKLsbCFD1c+zIjRzHH8vNYm8p/BuUIzKsyosy/0BuB8JaIFvf4TrAkgZ0+evJJJOXRVLMbL6mKS47XxuKXJPdG28MxNllNiXFF0/b4AVUd1tjWz
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f8624dd3-e3f8-4c84-10e8-08d82ee328e2
X-MS-Exchange-CrossTenant-AuthSource: CY4PR12MB1287.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jul 2020 08:34:05.4101 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jkjf+ZcuoCKrn/ggTN+zUfHDHZnvFbD8PWJ5KTS7D0T61zM8j8tIHzdK27VHjmfkcT8oHU+PCLAlKWHfeHVh/g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR1201MB0005
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

The series is to enable GPU retirement feature, which is trigged
when bad pages detected by RAS ECC exceed the threshold value.

When the saved bad pages written to eeprom reach the threshold,
one ras recovery will be issued immediately and the recovery will
fail to tell user that the GPU is BAD and needs to be retired for
further check.

During bootup, similar BAD GPU check is conducted as well when
eeprom get initialized, and it will break boot up for user's
awareness.

User could set bad_page_threshold=0 when probing amdgpu driver to
disable this feature and bring up GPU as usual.

Guchun Chen (9):
  drm/amdgpu: add bad page count threshold in module parameter
  drm/amdgpu: validate bad page threshold in ras
  drm/amdgpu: add bad gpu tag definition
  drm/amdgpu: break driver init process when it's bad GPU
  drm/amdgpu: skip bad page reservation once issuing from eeprom write
  drm/amdgpu: schedule ras recovery when reaching bad page threshold
  drm/amdgpu: break GPU recovery once it's bad
  drm/amdgpu: restore ras flags when user resets eeprom
  drm/amdgpu: calculate actual size instead of hardcode size

 drivers/gpu/drm/amd/amdgpu/amdgpu.h           |   1 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c    |  29 ++++-
 drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c       |  11 ++
 drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c       |  77 ++++++++++++-
 drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h       |  19 ++-
 .../gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c    | 109 ++++++++++++++++--
 .../gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.h    |   8 +-
 7 files changed, 230 insertions(+), 24 deletions(-)

-- 
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
