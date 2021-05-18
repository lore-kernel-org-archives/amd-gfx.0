Return-Path: <SRS0=uqvu=KN=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9AF4C433ED
	for <amd-gfx@archiver.kernel.org>; Tue, 18 May 2021 12:47:54 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8011E611AD
	for <amd-gfx@archiver.kernel.org>; Tue, 18 May 2021 12:47:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8011E611AD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EA0B06EB5A;
	Tue, 18 May 2021 12:47:53 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2084.outbound.protection.outlook.com [40.107.243.84])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CC7FB6EB5A
 for <amd-gfx@lists.freedesktop.org>; Tue, 18 May 2021 12:47:52 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AHuVKB3hCtAo7oX7TaS9kJ6dOv03WyulY4mmWRxR35z6NoU9GPUAidFDynTg+/lhyF8F9wgz69gqkTpGSEC+n/R7YpSmxeTc87YJc1bviB/rCtJraG2G++45XkOvPwOK3x/jsD8bTt7UkCWVq+SDBZf4BAHoykaa+CpXL1yqhk65G8xVEhOajZjFN9WBB1hEMXdMOGJmr9+MO0ff2FvpJDyoh0HPxYUP9ME3UoglB4Y2yH1Ox49rWWSIe5Pm8jMaYjxTb4tYmRQdwRT/0XK4cfIjNE1pUazOX8UhRIjd9kVvgnT5xUjEG6tFGKXMC6rH7u+g1saFJOJxRQNWtJraYA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Qn93PM7RWFH6ldS6YCFST0dx2X7xqlKi0vQJ4cIxAqc=;
 b=c1ajApphpg9w5ghvRRhHOo0FdegB4EgwEqbXwbE5rFRNxN6YaKxm8SkHGvqI0tWyOvIcEFdI55KiVMUn601r+UU5IPrkERcxPp2a30ajJHaYcQhEgi4Zdpa+ThhBHa9i4lZGbaFsEnmB6U1UKIrn2JPKLlwroCzvRUQWIuEAZGt+IXGDZM/j7Kote4cecTh8c4MnErVq6WcjUuciMq7KMRhcGCN/M0yro+uvztMZzh3uc1sMqtFkD0gF+plSrkbRICO3BMji9G04MlDCRiPEf2VtRfT7EC+rxY4UYCQ1tAiDo8nuu32ZOx2yBgl26bAPGViWcLxMzzSJEuj7chVJBg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Qn93PM7RWFH6ldS6YCFST0dx2X7xqlKi0vQJ4cIxAqc=;
 b=g2AelZ0sDIkTUTHwm0IPkp2ksBeHic5BHMGM3NXUiCBjaLyNCWrnug+mMgy975FMJ524CK8j9EHt+29qXUk3AqXdXaD1f3/CPlUJs4PjMVaXBErTYE368aDUXe7ISSAX9xP75njZoamJiIGMhPP1O+SbeckVn5VBoPxLzQMOzIM=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from DM5PR12MB2517.namprd12.prod.outlook.com (2603:10b6:4:bb::13) by
 DM5PR12MB1131.namprd12.prod.outlook.com (2603:10b6:3:73::10) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4129.28; Tue, 18 May 2021 12:47:51 +0000
Received: from DM5PR12MB2517.namprd12.prod.outlook.com
 ([fe80::8d83:baf6:c6c6:9ac3]) by DM5PR12MB2517.namprd12.prod.outlook.com
 ([fe80::8d83:baf6:c6c6:9ac3%3]) with mapi id 15.20.4129.032; Tue, 18 May 2021
 12:47:51 +0000
From: James Zhu <James.Zhu@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH] drm/amdgpu: add video_codecs query support for aldebaran
Date: Tue, 18 May 2021 08:47:44 -0400
Message-Id: <1621342064-18012-1-git-send-email-James.Zhu@amd.com>
X-Mailer: git-send-email 2.7.4
X-Originating-IP: [165.204.55.251]
X-ClientProxiedBy: YT1PR01CA0071.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:2d::10) To DM5PR12MB2517.namprd12.prod.outlook.com
 (2603:10b6:4:bb::13)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from work_495456.amd.com (165.204.55.251) by
 YT1PR01CA0071.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:2d::10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id
 15.20.4108.30 via Frontend Transport; Tue, 18 May 2021 12:47:51 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 2db3e273-b2b2-43d2-bddb-08d919fb25cd
X-MS-TrafficTypeDiagnostic: DM5PR12MB1131:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM5PR12MB11317E255C5A12370AB70A3CE42C9@DM5PR12MB1131.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1303;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Vbjm5ca4embi7YjGLSIz8o7ZYp9Zaxw0R+SPL7wn+yKYgO/akPWwlEW4jiE9OEnnbIFFDQNe4e8ybBENniNTcU4hNcy5t26lqOPDAaAUphKIqKJl/HcD98Dv7iSIWMyyawfhz/vLphNDTMWjaYCNPnEKoeNyJ26dPWdnOgBc4NH58vr7F+Lm0HF1q4Z4hdPt4DVJrsre/432EHMJAfizFQNUlVosukCce8ePyaSOxi1Z7j1Ay8uexE/IlyBXC54F8JDQXYnohWnqwHhFRE3DAWo3ShJo/Ryzhx2M172Olum/pdOB6j5t+F1MdLK6YSjvQFOlpD4Rng+xUG+mlVMbJI0XR2p7aRBXio+zXKMXmS0mp/tEoufF3ZQzUldUNISDhsxUzSqzwIN4Gb5Qqn22aff7DikMoZMFYDTs94MYCLRxNmWwQ6HNltXHoOxGcSy/58W5XM+Cct+1bg4ruKCfLz1QUbWiNkqCJosGNITH7lA+qsdcRqX2ALICZRDJcTwyEYH23qdADXWrKNhjZwqsU61tTwvgb3bGPXUAd3eJMWtTsjTWnnFIpvxZvOrF71HiiaJhrX6+wReJHyGMmY1abbn+btq+qTVav52tugLvNbu7tM2ERe4z3fj7HiHSLwV9+4h67w7KzMTOxQZyc2QcnQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM5PR12MB2517.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(376002)(346002)(396003)(39860400002)(136003)(366004)(5660300002)(2906002)(316002)(4744005)(956004)(478600001)(36756003)(26005)(2616005)(6916009)(186003)(16526019)(8936002)(6666004)(66556008)(66946007)(4326008)(38100700002)(86362001)(66476007)(6486002)(8676002)(7696005)(38350700002)(52116002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?5g9epEIBa/k0VF8d7Id6lOHJT4zI6sjSWJVBgh47v5sA5Gw0iJSOCwdyLDD+?=
 =?us-ascii?Q?PHH1Of3dm4EHRAXUmcUGDp9LIZQdRiVl0bupF23wWsG7wbXbwZgksJifo1Ly?=
 =?us-ascii?Q?FathIMQsbfaTWVqniK7/dhcBswbxspBY/kqAIjccXg7N84IRAtjQFZAmbHOl?=
 =?us-ascii?Q?76lUyIeg1f/TGftVuDw2ileFr2eoIcKrWRb6aVqZ4dwj+OV2BnN4Y5q909Ml?=
 =?us-ascii?Q?0jG15sy6cvqaPX+k861QL7xcU2no9rk2itaeDOQstlZ2drQAma8GrgBw7OZB?=
 =?us-ascii?Q?0kjNNP7lig1tCOQOSrovnNgMNWWcSKtuVL+Qwng37fTeHKi7i6RVWzH33EaW?=
 =?us-ascii?Q?xsphtslMfO1b3TycpbgysLa9MWPvWKfxz1JSJGhObQRMXgOa24SahMtZyX5j?=
 =?us-ascii?Q?mgrXmpFOJteRSzXKxBotby9XaBKk8YhUbME83/DNQJtK+/lfxmFm1wcxubR1?=
 =?us-ascii?Q?4+DcX3r8P2vNMc9/sOFF+dA6JzOcryaZ4u/GuWq9ri+fbPmsb1Kgmu2v7LJh?=
 =?us-ascii?Q?pMcj5KEZmMRWxkMTqWxGX374bfoppUpilOsMZu2Mu0Cdq1nmTATTwq3WSXLG?=
 =?us-ascii?Q?CkFn6BwPQ5Bhkkaue81jB2P96QGDLvdYd8QSwOOfGs1CQXzY6wCEw9oEiET9?=
 =?us-ascii?Q?LNFLs86lyDR9Cv+m4AH15SOVxETec5toZrr15kSkGCxDn2RN1LXlAUJHhM8v?=
 =?us-ascii?Q?5V5Fub1FynwyiHhjIhWzFzwhi3N1fSWvMlDwEVZCm1MbUXpmI4QEWpQSO+So?=
 =?us-ascii?Q?fxTw9m2DROQCggarMKcac99+F+yYZRBCpZ0hUUIusejh9AHTKQ391hJ8/Pfo?=
 =?us-ascii?Q?/1YWgvwbksojwM4U4P6OaHyXQ6z4H8RzPo4flTqKx2T4RBuIEba3CvrMeQby?=
 =?us-ascii?Q?ibkvCx6VVQIxMoFsOhe0py7kHnWymGJfVd7SHkJN1koC57GXKQFZqEiosYY/?=
 =?us-ascii?Q?IWN/fpn2m8vLjSpIns1WOXExDxeLdJwID0BHqh0eHMUX2RuubYqT6dHGIaSQ?=
 =?us-ascii?Q?ByG6NFKOAAtOqdtuHiIgycypY7sS/jQhuWr6RRBlepRqPaMpxOFHoYIwYXk0?=
 =?us-ascii?Q?PpCO3mycxRcNc0mokOpcnfWhStIXd/m8OhSfbwdyxVcDN3quPxSBleTkzINK?=
 =?us-ascii?Q?DIHXnNQQwr+5yeqGCXX1fBjz7HvqP3YnIduO6jnDHlj3DxG40vAOJcynrLJV?=
 =?us-ascii?Q?obqQyl7LLRyTmjdZp7N1OgnBlRa0T51OYbFLKoSz2jhzymSAlGx/thHI5xCT?=
 =?us-ascii?Q?A5/1V70gRHnll8cCeSyolrlBzy+YsQQu+N0t7wqRXUJTzCwuHLkCoSWzMLeR?=
 =?us-ascii?Q?Fuy7NnisTEtQc8KiI85CtAWg?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2db3e273-b2b2-43d2-bddb-08d919fb25cd
X-MS-Exchange-CrossTenant-AuthSource: DM5PR12MB2517.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 May 2021 12:47:51.3170 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: o4U/NXIM44A/yFsMnlm2PPhX9hWzj0A8kmFgHeOlsZBNJ7EB15qi8LwnUqRPPqj0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1131
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
Cc: jamesz@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Add video_codecs query support for aldebaran.

Signed-off-by: James Zhu <James.Zhu@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/soc15.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/soc15.c b/drivers/gpu/drm/amd/amdgpu/soc15.c
index 080e715..75008cc 100644
--- a/drivers/gpu/drm/amd/amdgpu/soc15.c
+++ b/drivers/gpu/drm/amd/amdgpu/soc15.c
@@ -302,6 +302,7 @@ static int soc15_query_video_codecs(struct amdgpu_device *adev, bool encode,
 			*codecs = &rv_video_codecs_decode;
 		return 0;
 	case CHIP_ARCTURUS:
+	case CHIP_ALDEBARAN:
 	case CHIP_RENOIR:
 		if (encode)
 			*codecs = &vega_video_codecs_encode;
-- 
2.7.4

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
