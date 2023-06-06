Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D3603C7EE29
	for <amd-gfx@archiver.kernel.org>; Tue,  6 Jun 2023 16:24:37 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2AAA910E382;
	Tue,  6 Jun 2023 16:24:37 +0000 (UTC)
Received: from NAM04-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam04on20625.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7e8b::625])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7FCDC10E382
 for <amd-gfx@lists.freedesktop.org>; Tue,  6 Jun 2023 16:24:34 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=biPJDD4dqFbcFSQ/QXz05A1KEGmACW8A7lG0y4QZoMunlFU4bniTocZBvaUrFv07TfAyarNJqATkkK2vObrppFU9RpgOEPmg8C0uLBesdHAmHAVZGmIi+QvzOx14ADhqSHxe4kOAT3Dt01sDoR+hG5mgsuFQ8XgVobJm4b9QGsQ8mxGuEzAbDaEPgZOUdzOAtr5OqIS2+iqzEd1x+iI05ceI5/IbRBcUq00TmktJENwM+M2jsGm8DLHr4N7WSkHHat8ClYYfzKIQ94+XOlaJtDubiV2p9XiK4vr178H8nLN5aPaB3+hiqEUWNOD5oZ0jrI9wwy3Rq3wMCqrC132EGA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BlX1ynL5D7rqPWLI8JL55JV9/RI3DxlADvpojke2r1s=;
 b=XrO75MljmXhB4asXuhjScvAsyIedXmRWsdtIt2mvkYmdHB/P5WbWarOuV7F4P/42QQlrFPI7gHmP1BJvcn3Rc75Rv/MQ3rL8wYsQvJQQDkSXK84Z8TGmnlCzk8L2SQzC+vypHIjqmDOhkGO+nH+uMhJhSEvYmS+B+QjJqcharrqhiU1+kX2/sxXQQ29/5vJFZi+e/bjwMQAPXxauKvKXW+yvbFCiMTA3eOncGMPtKUagF2XCG7bCf4eb31UdFjzqFkQKZfKxNGr6E2IkVg4veyWp7Qy7hBUqmxC8DmaDXG5vWqlnfe47LxJnlUCEJy5S+2GezmrmipQPuU6SQYXbeg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BlX1ynL5D7rqPWLI8JL55JV9/RI3DxlADvpojke2r1s=;
 b=NXBr4G7tElViD9MvFNj6TGFLMgFm6YAW2RVMeSWItg1z4c/aM/eU9jAiaMQefiZVRPPDQCQ71VK6uXgMrnpHH058QzxXvI4paFcVZQgOjt1FCJXAc++UNULpO618Fwug9cUqg6HnsQ5K5vvvEgJTiaaiOpWD0YtrsN85QuG5HHc=
Received: from BYAPR07CA0053.namprd07.prod.outlook.com (2603:10b6:a03:60::30)
 by LV2PR12MB5965.namprd12.prod.outlook.com (2603:10b6:408:172::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.32; Tue, 6 Jun
 2023 16:24:31 +0000
Received: from DM6NAM11FT048.eop-nam11.prod.protection.outlook.com
 (2603:10b6:a03:60:cafe::d4) by BYAPR07CA0053.outlook.office365.com
 (2603:10b6:a03:60::30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6477.19 via Frontend
 Transport; Tue, 6 Jun 2023 16:24:30 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT048.mail.protection.outlook.com (10.13.173.114) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6455.33 via Frontend Transport; Tue, 6 Jun 2023 16:24:30 +0000
Received: from work-495456.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Tue, 6 Jun
 2023 11:24:29 -0500
From: James Zhu <James.Zhu@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH v2 0/3] drm/amdkfd: new event wait support
Date: Tue, 6 Jun 2023 12:24:15 -0400
Message-ID: <20230606162418.1862540-1-James.Zhu@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT048:EE_|LV2PR12MB5965:EE_
X-MS-Office365-Filtering-Correlation-Id: 0d5c18ca-673f-4def-b568-08db66aa8199
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: JkNcCK+sV00TNyp/kpjsLliegi1Yv4f/lim4lRx6QR/Wk8YYT/4YzUcguFwTd/u5PKNq4vMxnu4blZO/X1lHm5M+O+1qTMBSPWSjddl8yJSKNLhlUwaErVAyqreE3Bp2e+/tRi8xRboxSbatdscAfbKhCPP7B+PY11icgCeUbMyf9O9Hp7iQhnGJlm7v7JdNROM7Isn4n8CyNw1kYV///BX2lC8Ez6HrEtSy97dHBCX1RmGHN70qp+Rjs5UkIL8qYF31/EeQbro2ZmDUJqnXhwv18ZXYHLJwePAJsEskb3iNvVnU3i7FXHqvWcOh+gida0wJ+RyouXBW0UPp+sSwR0LBKPe9CsTW4DCkXDCSM+yUBlQdfPVX/xs68yy1il8qeVf1GMcmL0Qm0YEteIyPP4uK+3wpZEckV7Puj+Vvd1I0gn+NPpEh5TLaEkYnNGEfd3G81zsxAxJNH2QMtQFxVMDvZ4WttHyPH2t2kBUFfgNJxRvlzGv7/ESpLMf/SCPXMBPEQPRRdhPFRT+MDtq8uTW1wCfArNfvz7K9euI/bAayXwIFZokd3LGf6tE64AIhQ9jb6WORAPsAgNgmLyycsibI7vowdC/SYJ036xA222h8by2xfe5Vod/apbShRUhSnh+rx84hNL1Djo+GHD71Xb6OMl/mQvLO9B9Hmvs56KVGOURlfkLbgHmB3TfPnR7CJbg/sAw58CIHofg3Yw5EuIEi22EyGJ/Is2uPV/hYJFbFcF6m04TfqwXNjeifimuDhyZOvi15jfQnP0hFYx5n793+oZZHi4Plhw40WWEVB9M=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(136003)(376002)(39860400002)(346002)(396003)(451199021)(36840700001)(46966006)(40470700004)(70206006)(70586007)(2906002)(478600001)(4326008)(316002)(8936002)(6916009)(8676002)(41300700001)(54906003)(6666004)(5660300002)(7696005)(1076003)(40460700003)(26005)(82310400005)(966005)(16526019)(356005)(82740400003)(186003)(2616005)(40480700001)(336012)(426003)(83380400001)(47076005)(36860700001)(81166007)(36756003)(86362001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jun 2023 16:24:30.7083 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0d5c18ca-673f-4def-b568-08db66aa8199
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT048.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR12MB5965
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
Cc: Felix.kuehling@amd.com, jamesz@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

In kernel amdgpu driver, kfd_wait_on_events is used to support user space signal event wait
function. For multiple threads waiting on same event scenery, race condition could occur
since some threads after checking signal condition, before calling kfd_wait_on_events, the 
event interrupt could be fired and wake up other thread which are sleeping on this event.
Then those threads could fall into sleep without waking up again. Adding event age tracking
in both kernel and user mode, will help avoiding this race condition.

The changes for The user space ROCT-Thunk-Interface/ROCR-Runtime are listed below for
review togehter with kernel mode changes.

ROCT-Thunk-Interface:
https://github.com/RadeonOpenCompute/ROCT-Thunk-Interface/commit/efdbf6cfbc026bd68ac3c35d00dacf84370eb81e
https://github.com/RadeonOpenCompute/ROCT-Thunk-Interface/commit/1820ae0a2db85b6f584611dc0cde1a00e7c22915

ROCR-Runtime:
https://github.com/RadeonOpenCompute/ROCR-Runtime/compare/master...zhums:ROCR-Runtime:new_event_wait_review
https://github.com/RadeonOpenCompute/ROCR-Runtime/commit/e1f5bdb88eb882ac798aeca2c00ea3fbb2dba459
https://github.com/RadeonOpenCompute/ROCR-Runtime/commit/7d26afd14107b5c2a754c1a3f415d89f3aabb503

-v2: remove unnecessay link

James Zhu (3):
  drm/amdkfd: add event age tracking
  drm/amdkfd: add event_age tracking when receiving interrupt
  drm/amdkfd: don't sleep when event age unmatch

 drivers/gpu/drm/amd/amdkfd/kfd_events.c | 21 +++++++++++++++++++++
 drivers/gpu/drm/amd/amdkfd/kfd_events.h |  1 +
 include/uapi/linux/kfd_ioctl.h          | 13 +++++++++++--
 3 files changed, 33 insertions(+), 2 deletions(-)

-- 
2.34.1

