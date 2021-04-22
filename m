Return-Path: <SRS0=IWiu=JT=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F9A8C433B4
	for <amd-gfx@archiver.kernel.org>; Thu, 22 Apr 2021 15:40:43 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7C1826140F
	for <amd-gfx@archiver.kernel.org>; Thu, 22 Apr 2021 15:40:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7C1826140F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0AD676E2D5;
	Thu, 22 Apr 2021 15:40:41 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2076.outbound.protection.outlook.com [40.107.92.76])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 198976E235
 for <amd-gfx@lists.freedesktop.org>; Thu, 22 Apr 2021 15:40:40 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TnchusX5u6fYf7HHltZBYwsF11xaTAbwEsR6B84pOhbn4g6s25Yd6/vDllA11ZboiXD5Otrjc2dY8WNxNUXRwurE7u0tRKx2ZXmrgRzjiH56PdzvoA1xpv4Fjabi565x9nDmZGQiMuLzm37puLOGrcD/y0T4CwU+TBXduzMwFpTNIcjZiujiNpMvRRpo5XrmWhDEy/UR8Ufq+UtYSGAatYda4fiuCtrJh5wROV8Q/B4m7CMRoI/zu7L3d7REIOVaMuMPXRNqG49c4luEkkdJs+Pc1Mt9KiMHsa59VxKsYevFy3LnM8NOU24jp2YKp45F8bdnbQ8zh8evbxTw6LNyHQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xEuLDEF246JjLkvkpoaDQIH2i16S9IddAKOE1T4yGU4=;
 b=dlMRMdSBO6Oh3iy8Obli1XxK0Rc40lLcvxHbScsQgfQwXbVx8wQgCGKBirR0m3zegHn+32fV1AzquDk81pi1GdXKvdW3uX6zsiOWJuN4/9ssPX8Z0YuGdREI5TaXMcOp66efIQJ3ewJvsF7RqFNBQGKXDsjVowA06oZ861paK9a3m4LWuXAhsHO6jbdGZzOcpBDuPYwOEDUTgsAVdr4QvhjYON9h7+7JPXPRzsW1USsFtzAENADTaHJdaeJoX7iy9qezRwuHGcHKO1uOyy2Wsdl/BJDIioxCmOmwkrRBuxi5piIUvYOWDPG2p+Dku8GvOQvrVcvgg9NX7jkFd/nFZw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xEuLDEF246JjLkvkpoaDQIH2i16S9IddAKOE1T4yGU4=;
 b=DZysIseO/9VgwElRCTfhb7LU8yP67vDhCQjO+g5mwPLr+sSD+6qzc0O4j9q0QW1L4NfCQ2jsEDu3TBtd3AOMQKFSe91hmVpm0dFOa2AXQXKrX568SVwjms7s0q/fSCZjw92kR0LaCY4+wGUTA4D1/3NnnZYra10aXNDqn6gJbVc=
Authentication-Results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
Received: from CY4PR12MB1463.namprd12.prod.outlook.com (2603:10b6:910:e::19)
 by CY4PR12MB1173.namprd12.prod.outlook.com (2603:10b6:903:41::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4065.20; Thu, 22 Apr
 2021 15:40:37 +0000
Received: from CY4PR12MB1463.namprd12.prod.outlook.com
 ([fe80::a457:1047:3886:4630]) by CY4PR12MB1463.namprd12.prod.outlook.com
 ([fe80::a457:1047:3886:4630%9]) with mapi id 15.20.4065.022; Thu, 22 Apr 2021
 15:40:37 +0000
From: Nirmoy Das <nirmoy.das@amd.com>
To: Christian.Koenig@amd.com
Subject: [PATCH 3/6] drm/amdgpu: remove unused vm context flags
Date: Thu, 22 Apr 2021 17:40:00 +0200
Message-Id: <20210422154003.4048-3-nirmoy.das@amd.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210422154003.4048-1-nirmoy.das@amd.com>
References: <20210422154003.4048-1-nirmoy.das@amd.com>
X-Originating-IP: [217.86.127.111]
X-ClientProxiedBy: PR3P189CA0083.EURP189.PROD.OUTLOOK.COM
 (2603:10a6:102:b4::28) To CY4PR12MB1463.namprd12.prod.outlook.com
 (2603:10b6:910:e::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from linux.fritz.box (217.86.127.111) by
 PR3P189CA0083.EURP189.PROD.OUTLOOK.COM (2603:10a6:102:b4::28) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4065.22 via Frontend Transport; Thu, 22 Apr 2021 15:40:36 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 24731b35-8461-4ea4-b7f3-08d905a4f9c5
X-MS-TrafficTypeDiagnostic: CY4PR12MB1173:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <CY4PR12MB117322DB9D00EBF68B63385F8B469@CY4PR12MB1173.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4125;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 6729bf1mbq6nTLJHrlHDR+O7v+dwqaS78D8pHLcxpvlzGNy3NyGQOm36JDrOypi4FJMDvUhdJtUSKWfb+JP6edMSc/YkhH3grXfXDywTYE5BXX3oLFuTgbx0Z3FF1DDk3qZHLI2b7Ja5w5Efx1M5bYGLw24g5nKh0dyYptcVfoo1PsQQujWZqNmZsRhiBbH6YgHk4F8DkIca2cThYX7cDB8WTCHGoMyCwMYwb0tKPWjmdQMHmHFaHdOyB7Krch4V1fScB3UwaG5SEtSOW/HOnGkkb5vVIko9TJZ/wrZNQXy3OTkypOgNBnDXkhmlRlo/JqZLb+AexAvsT+w50DmNbtCoM2VWwRB7rfNi+6tCu/BuYi5ymdhBOqkkovi5sojvkVH4ItLoJIwBSSmacjkP2D0pn/tnmDQOenkK7whvgQ1wdDctfgEsddp5eftUmmKdNBlWUzTinDG8r7/+RI51aU6r/78DhQNB6gBV6xgu2rXELG43RZ10I9Cu/jeljYN26Yijjbk+fycqNNBO8zCioomUkkN119lZ2bWysFv44DfoVhPmwxxWK1eDRkEMBfc8OAc+5RPmGE2q59ht562uYgNRRpbk6AQldIpevQe78gu9cdymuI2TrVv4FfenYTFVGX8b9DLtxhjPbnD93uRbPQPhEWvJVCxewba7RYuqXmo=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CY4PR12MB1463.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(396003)(376002)(366004)(346002)(136003)(39860400002)(83380400001)(38350700002)(2906002)(38100700002)(8936002)(34206002)(6636002)(66946007)(86362001)(66476007)(4744005)(66556008)(6512007)(316002)(26005)(44832011)(4326008)(6486002)(1076003)(37006003)(186003)(478600001)(52116002)(6666004)(8676002)(956004)(16526019)(2616005)(36756003)(6506007)(5660300002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?FA9XEGXG7Q6lpowkckzIiapQ4bm546TTBNUAjfViPAVgnKbyr5pPmT+Z9cmN?=
 =?us-ascii?Q?NkqIGQcyDaQZhiqWG+Xg8LQQLgf2rOu+x9XGBANA26IhmokLqRdG13ph8K3t?=
 =?us-ascii?Q?ilToV4YwHZW6WHO6PPkEL0njhEGpQjMxnNNjzRHjPMuEZ9WwEB94Q25BTiY2?=
 =?us-ascii?Q?FB3I/0uz4hGlz8t1aFYHNphMqvJ43tp014fGveFwde+l3Ynl3wGHlSZdBTvu?=
 =?us-ascii?Q?oiW/JueYEg2Tx+aUnbbfINmPbtxIbxBuSh/dnjbdMntASYkvZVgPHZmEe/w+?=
 =?us-ascii?Q?lLdWVI/B/xSlQfq3ubvfIqceoAkBZVPjHWoIPFnVrEOPy/hXqN4CdcNoY3b5?=
 =?us-ascii?Q?aWuwgrmBx9NTroAYb7+eWGi+uTWIxCUr6X6k1Xf5ok2EE5gK+wNoPcIKxJ2T?=
 =?us-ascii?Q?aOb9RRNcPAxq1nW4ddKXQEka9o+I07uUiOSsYfL2mYjGU+TQtZEF2liWYRjG?=
 =?us-ascii?Q?Rn0/k/dTM755m4STMrzO3Icjw2w8UQh4agFkozx3BHHlYFBBNmNtcfuRZJe0?=
 =?us-ascii?Q?fYYYG1TpD75EwLvHsgiStnaoBzAPpugD+v1euv550syT62TmcBpg4UP4QLG5?=
 =?us-ascii?Q?7Jcw3bd7a2NZGqqIa4Uy59TD9whyDZCBTwcjGnVvOl3tw1u8r1vcGvgP+8bE?=
 =?us-ascii?Q?sjsHS7bvYEO9bBRsLy7pSYO4Iwl5VSJxRM94QevWmAgi81UYzIHEKvI1uj/m?=
 =?us-ascii?Q?OmfTN/9nVtxkdiN/SKshAh9fV4xb7GWXgvr8qsw5HXvJaLHLec7pP4tG3lV8?=
 =?us-ascii?Q?B/s+HhRNPfjUVGWlqZKCUIMbWzGDek+qQgsJIBOGKq9i/okdLwAhAG4ZHjoK?=
 =?us-ascii?Q?yhcWwYkF0bLRjSXnSmMBRlOinvi/IC7IMi/IMLFsRQKoiq1mhz9/yzEDoAPV?=
 =?us-ascii?Q?VD9v8Vl6XEyDiqbjDe6+1vRLDAiS2M3YAbF/gKzefaS0Cj2jeIN9RDgFyCme?=
 =?us-ascii?Q?8EXEQtYfUXZHHS6L6fIkxRPcVWakEnr+j+AGf+Mdn5WhFi4i8Gqjq6JfW5Qx?=
 =?us-ascii?Q?Tz868DAJjoxPwf8F2UzajrHXg9mRaHB0PdiI8rk2HWANODveAqmxrKNAoK6e?=
 =?us-ascii?Q?cGEtr4Pm7G8/RhhAWJJGyWUheek/ZsQEMNbHuCle+9HlXTOBirYFdzUneuap?=
 =?us-ascii?Q?+JG/JYqGYYLuY7wJ219GvylKLAeK/2kddhov/ExATJmY9/y/Kh1HCMXHA53O?=
 =?us-ascii?Q?MSDTNr5mjFpXNVTrDNgakTrVtItpc0JJMyYAHg4B+z4M9DhEi6zpCJT2NLsy?=
 =?us-ascii?Q?u99+WeGpuwHDHrZVA51vpSBh5LDk6H205vBKTav4y/JxkxfWdiF0OxZKydWL?=
 =?us-ascii?Q?2cqJk4b0WUgGqjbYFzawd8Qm?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 24731b35-8461-4ea4-b7f3-08d905a4f9c5
X-MS-Exchange-CrossTenant-AuthSource: CY4PR12MB1463.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Apr 2021 15:40:37.5864 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1qX7bVkKOco0Y1m+fCY5jpugijkjNEjJBlq5cYFAHtmC6u0Aw6Mdeffw0wOIJGIJ8tHh40MJ9h3guj0Hbdw2IA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR12MB1173
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
Cc: felix.kuehling@amd.com, Nirmoy Das <nirmoy.das@amd.com>,
 amd-gfx@lists.freedesktop.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Remove unused AMDGPU_VM_CONTEXT_GFX and AMDGPU_VM_CONTEXT_COMPUTE
flags.

Signed-off-by: Nirmoy Das <nirmoy.das@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
index 7f07acae447b..6a9dcedfcf89 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
@@ -121,9 +121,6 @@ struct amdgpu_bo_list_entry;
 /* max vmids dedicated for process */
 #define AMDGPU_VM_MAX_RESERVED_VMID	1
 
-#define AMDGPU_VM_CONTEXT_GFX 0
-#define AMDGPU_VM_CONTEXT_COMPUTE 1
-
 /* See vm_update_mode */
 #define AMDGPU_VM_USE_CPU_FOR_GFX (1 << 0)
 #define AMDGPU_VM_USE_CPU_FOR_COMPUTE (1 << 1)
-- 
2.31.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
