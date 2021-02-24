Return-Path: <SRS0=z84W=H2=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A842C4332B
	for <amd-gfx@archiver.kernel.org>; Wed, 24 Feb 2021 22:21:24 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4DF9164ED1
	for <amd-gfx@archiver.kernel.org>; Wed, 24 Feb 2021 22:21:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4DF9164ED1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 808756EB6B;
	Wed, 24 Feb 2021 22:21:23 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2085.outbound.protection.outlook.com [40.107.94.85])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 36F906EB58
 for <amd-gfx@lists.freedesktop.org>; Wed, 24 Feb 2021 22:21:11 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HcI4b/Vvnibz7aL4vTgPgJKOwZ11/+Y85andR7a/XQwVOcwu3/W2Gz/+b4YZAXgDe2zWJe9Pb5gIIpAro1tOXoZNqUW3tWYfBZiOV1y0VhHXk+OPHj6UPbYyCM6Hvw/1vKbjBB4SgGLwVAKPikZfxjGwNjw1CwvdiMhIW6iMyN3baP+v1udTmnoSA0Z92TUDyaU1Tr3GSK8kWth4H1tm+LfRlBomK0rvdOP7Fq+UZRJ8CBZWfRgDfr/Ndh1HETBJ7PCa6KW6bhajvXXKOaqJo3VYykFkrqiO34//FBaSSoQDQ1REiqlfHSi8EE4I5+/p9AREMrpzR4J6690j9e9uow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GzMk6KgNY3rS59MgolgBJNMelq/ClECZC9VghHziVUQ=;
 b=Sm6g67YEI1gyF/TITLpWrjAd5IdgS71k3xcq1HdQgtKe9pKyeUsG2OqchL9U9o/5oozpX9rR2/d/Qp1WRkB4Yg2PzJLt/9YKttUt4kN9UTMJLc6Ec1kMSVcqtTQXBei6/ZUVWpWKuBN/PFHb/w15/Z4KRTQvUxG25wGdPdInwaFWv5ahMmS+PMRujYAdWic61ZroUWOGIc+Qkez53zxTO40JkB4lxavnxYsYXF94HUZU3IYYyNIrClcz/d/I+SMZ2wEYmZKQqr07ha90RRLYSD3Boslqj3fOAx72BF03Gg/OnO3y54+AGmohoTRB+3KYr4/OQuoVfwYBhIvGU3lHeQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GzMk6KgNY3rS59MgolgBJNMelq/ClECZC9VghHziVUQ=;
 b=V+zQRnEfktmYffZedg5/i6MZrn13AZWVHY5ZkyNR48Kc35s0SQF06ofQ2zIaAG1qpY0kTAjyqi5BOturKLf0/efkuikzprMFQY0UMhR57WqrsLd+X8upXurCdNx/TGH1cdRd8qb5zu2jx06C+RC4RvFNa5FXDC13Eso35vTE6Ro=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from MN2PR12MB4488.namprd12.prod.outlook.com (2603:10b6:208:24e::19)
 by MN2PR12MB4046.namprd12.prod.outlook.com (2603:10b6:208:1da::23)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3890.19; Wed, 24 Feb
 2021 22:21:10 +0000
Received: from MN2PR12MB4488.namprd12.prod.outlook.com
 ([fe80::b0c4:9a8b:4c4c:76af]) by MN2PR12MB4488.namprd12.prod.outlook.com
 ([fe80::b0c4:9a8b:4c4c:76af%7]) with mapi id 15.20.3868.033; Wed, 24 Feb 2021
 22:21:10 +0000
From: Alex Deucher <alexander.deucher@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 093/159] drm/amd/pm: Remove CPU virtual address notification
 in aldebaran
Date: Wed, 24 Feb 2021 17:17:53 -0500
Message-Id: <20210224221859.3068810-86-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210224221859.3068810-1-alexander.deucher@amd.com>
References: <20210224221859.3068810-1-alexander.deucher@amd.com>
X-Originating-IP: [192.161.79.246]
X-ClientProxiedBy: BLAPR03CA0027.namprd03.prod.outlook.com
 (2603:10b6:208:32b::32) To MN2PR12MB4488.namprd12.prod.outlook.com
 (2603:10b6:208:24e::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost.localdomain (192.161.79.246) by
 BLAPR03CA0027.namprd03.prod.outlook.com (2603:10b6:208:32b::32) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3890.19 via Frontend
 Transport; Wed, 24 Feb 2021 22:20:25 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 9f71b305-ee8c-465d-2066-08d8d9126281
X-MS-TrafficTypeDiagnostic: MN2PR12MB4046:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MN2PR12MB4046F67F3BAAFC16033A984EF79F9@MN2PR12MB4046.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1284;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: QtA6vDTb54+7WiMoMllvYmCzOFgEMKa3lpbvSw8UbdLDpehtfCj3F3awZkpfVCtak4Wf2yNiP/gbvSsWtfeW8N/nTzMbrxEYmk+U3nooMEmuIMaMaRANiLQmJ1zL5ZeP9QtIbv2WvYMJJDLH2XfTvTiPdrSqiFruJiCxMjOa67Yh5JVSxkenxyqJgJeNtOsXCeJzVpPj5AMph2I6f9iDUf8/Mxow4uTcGxXjGgbtjlUX1eZ48uSe3ozuxPfCWfB4vmBxKfETuIv7D5wWnuPoRTPMVITe40/o3NlcoV74z/RUZLqld4o34KKFyZ0bFqlyK0hiqshz+KdQs/upIBbvfHhihl80CIThaJj6IaxU5/MfL3BaBwWC5+MUvBvXj5QaHTJhf74mBiG6uDGYFUrV42d5ZyOpoWdRhEkndADvm0YT50NeRhPwzyThAA17tK/vD9SKunHm7HRU/T15MTKIfaSegxfVmcZQUfMFtzeRer4I/nOrf13yUV1XTF3zsv8n59BCXcdPefgCtIc2+TwW/q5I0kx7w14XIaUOoXCZLt2dBK1Vi+6cPi4SF7qqqREXwtddjATttsHg6wukJSL8tg==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB4488.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(376002)(366004)(346002)(39860400002)(396003)(136003)(83380400001)(86362001)(4326008)(956004)(2906002)(6486002)(2616005)(478600001)(69590400012)(6916009)(8676002)(8936002)(1076003)(6512007)(66556008)(66946007)(5660300002)(66476007)(15650500001)(26005)(6666004)(186003)(52116002)(6506007)(54906003)(36756003)(316002)(16526019);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?oblbZSI1liJSNP5NR5QcmTiZBX5mfR8waEhBcBwW/qqDHGhOgynEIyAdNmTa?=
 =?us-ascii?Q?7cTn+XhmAP4D0UtkvYmml+SkjHDfIaOgG9YYZaqJaAAEI/jQcFUXVq45GFm8?=
 =?us-ascii?Q?V424KIXyIkbDpdvdNlI2mSsrcoFDLehqsSE1RY3BQtptt28lglgPWogMOxkb?=
 =?us-ascii?Q?uJngiDqLOuy9ikOaBdfG/75UX3/0CXs3gx7VceO5up99bMlqpVnq88+u+u5M?=
 =?us-ascii?Q?msq631UCzymCtF0CS4exTLyoXrOdId6QvqZFcjek2PeJly4GMlf0bnSru3hA?=
 =?us-ascii?Q?gW4J7mbvgWWT1guFMMVpU7nleU+++DMOOidQKZSu0oA2mksnUj0NC6TpZY5c?=
 =?us-ascii?Q?8MYuJnWAooT2mVDMVpA8IzJusGjO+WEMNxdNLK+8QdQ2DCOLdylVXBoHpXAe?=
 =?us-ascii?Q?SJdtR6fDMVdBAL5czeAIC2PqHmCvtnl2glI9ncLnJKJNPe8MsmLRCcj0WXeQ?=
 =?us-ascii?Q?+o+ppV120+YNe13iVP2A1o0ISd3+Z3T0g3PUdw0WBJL44EVNY6vxch8cLv9f?=
 =?us-ascii?Q?wLksFZFFsE37WjGOMHyhzuXH5VE8c2X6WxQWW26KbQZQjMswLKIc5k0gf6zN?=
 =?us-ascii?Q?+kWnn+42gM6dZn6TgGcrwXSXMCuZtzDqxmF767gQJ6y1Bpxy/nFiHIIsfAfY?=
 =?us-ascii?Q?pOGKDXE1BuFNQVNIlbTV9wiH6WK8r2jM6SrqhZo4SIIt/6T2il/TeyfFH8B8?=
 =?us-ascii?Q?p4fvLzoW6FsGCP+xGCOFtWcJbFMxLRwHevZc5gP7n+Y/Xg3M43yOlTSJMfMh?=
 =?us-ascii?Q?5y7R4KELv5tLeCJ/+dZMbXNoWjfW83qwIc0r7B7IZmDEYEy/UdjGV8a6laAU?=
 =?us-ascii?Q?sh9ly3ZDPY2V7A25UjJorEju9NXYSf0MhBFK2U+9LgVa3fJ8CpxVC5VKDMZZ?=
 =?us-ascii?Q?g9nURpQIgjmjEhys72vqe3N5SAwbGJEQQzeRbgacPZq2Os4jIxKyVUGdWoPw?=
 =?us-ascii?Q?qEXtzN+qIRXfe5jInDeCzKavNumXhpUmCxSVlPZZvQSnTEhFrUPEYp45dcTn?=
 =?us-ascii?Q?oUvVjL/OeH/ZX/yYmuAqA6M2RMybRIQOfJdFJvlKht6yLFcjq2vvElnXEFex?=
 =?us-ascii?Q?gGdZP3/SY0ZeozGlfXd5rZKBjzH7FzpkJonoCIgG2clA1KN0ZAhOJLRJ3ZUU?=
 =?us-ascii?Q?NDQMCJtGjwrtraNyffidu/uV+a91BF+zp9T5vN8QXCwyCKdE5q2GSOqiMtJ9?=
 =?us-ascii?Q?Sr1ud5HaO5lqRAaVSJwU6q6kt3j+DqV9hR+DsZv0Cfu4gUZyBf1bDLyqIYZH?=
 =?us-ascii?Q?VfIRlin5vd0HGK4nmCiUwoZd7C/kjO0WDsM6zzMO3fdNRMACjuyb8joVeLqa?=
 =?us-ascii?Q?NaPd7weRqmbOEIehVFcrWQ2W?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9f71b305-ee8c-465d-2066-08d8d9126281
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB4488.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Feb 2021 22:20:26.1399 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Y49GkPKdXI2GdwUofKRjxemrN2DVQwc6C8Fcq/VuVuWwMKuqpRpDkLlDoTpwEyuAZ1DZC8tGP8WGE794qORhKg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4046
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
Cc: Alex Deucher <alexander.deucher@amd.com>, Feifei Xu <Feifei.Xu@amd.com>,
 Lijo Lazar <Lijo.Lazar@amd.com>, Kenneth Feng <Kenneth.Feng@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Lijo Lazar <lijo.lazar@amd.com>

PPSMC_MSG_SetSystemVirtualDramAddrHigh/Low messages are not handled by
PMFW in aldebaran

Signed-off-by: Lijo Lazar <Lijo.Lazar@amd.com>
Reviewed-by: Kenneth Feng <Kenneth.Feng@amd.com>
Reviewed-by: Feifei Xu <Feifei.Xu@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c | 17 -----------------
 1 file changed, 17 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c
index e6c25a5814e8..ce160f233323 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c
@@ -584,23 +584,6 @@ int smu_v13_0_notify_memory_pool_location(struct smu_context *smu)
 	if (memory_pool->size == 0 || memory_pool->cpu_addr == NULL)
 		return ret;
 
-	address = (uintptr_t)memory_pool->cpu_addr;
-	address_high = (uint32_t)upper_32_bits(address);
-	address_low  = (uint32_t)lower_32_bits(address);
-
-	ret = smu_cmn_send_smc_msg_with_param(smu,
-					      SMU_MSG_SetSystemVirtualDramAddrHigh,
-					      address_high,
-					      NULL);
-	if (ret)
-		return ret;
-	ret = smu_cmn_send_smc_msg_with_param(smu,
-					      SMU_MSG_SetSystemVirtualDramAddrLow,
-					      address_low,
-					      NULL);
-	if (ret)
-		return ret;
-
 	address = memory_pool->mc_address;
 	address_high = (uint32_t)upper_32_bits(address);
 	address_low  = (uint32_t)lower_32_bits(address);
-- 
2.29.2

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
