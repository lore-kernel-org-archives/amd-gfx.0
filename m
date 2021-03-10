Return-Path: <SRS0=9uSV=II=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90ABFC433E6
	for <amd-gfx@archiver.kernel.org>; Wed, 10 Mar 2021 17:11:58 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4485764FC6
	for <amd-gfx@archiver.kernel.org>; Wed, 10 Mar 2021 17:11:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4485764FC6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3D3606EA4B;
	Wed, 10 Mar 2021 17:11:56 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2049.outbound.protection.outlook.com [40.107.92.49])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 18B326EA4B
 for <amd-gfx@lists.freedesktop.org>; Wed, 10 Mar 2021 17:11:55 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iR8R/Qa1WbU7w1l2lclX8eTCLuc3pX6Mhbgdl9/RIv7HBOJhI3dOX0md3Umyv6rtLgOIm+OxfcfHXBGVbjQL06zNemtysRMFY3cPdHbSlZCyKtcX97ozP6GCE+SZZcHNvRZHNuB6Z04met+oVG0A5u9+NWf+TCYqhwxCRb7fVOeGkplj3vwdiANmJgmo90EQn88jG69KC7HFlVMtn/mkYLHuKR0pvIgANWiBzrNvZ76e5pFa13XFKM/HkPg1AMvxCgEAPn8+ZiLeHnXfr5r7vpVPUoYgxD2Q2xs6x0hUAOVJPg9H1MbYYv1yVxGUYn+0uFGuCKs4zg+xCD68Mk0XPQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fI6xufb1dm7Agk3cugEhjLLUOxYpq+okAVJYJ02xxtY=;
 b=RRTOC/JbWlzE4DQYAXRXkGl9eGBQMfNcbXjTVlqicgLZpwQGeHMrZ2AERfBLe5+tcJnXT6h/AgL2RMEZcBxy7DMBPK/X6PnndeWUKqgdSvKHVNvWbBuQv51mJLpkWrPNBzBJIbTD56Pe+8qtp9tsDDyDdZAG+Ci45tA00CzRLZJajwFjYC9FdZ4ySbMgJ1eShTqhfFLfQ7BEd+rro+1ZC/9JCH2BdnsK68FCDfqLDIOyUNAtEhleHJ1HEHPpeACABjhIkwHUDz+Fc10er0kw/bpGDCRRxORoS90QmWO7z5bCM0qSCl1o/pc1LXgxK0rKSzFm/x115ng0GAuZSfWd5g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fI6xufb1dm7Agk3cugEhjLLUOxYpq+okAVJYJ02xxtY=;
 b=RuxG47vy1LGjXY0ibpFw/I1QKFQSxreBBCOWOBdioTSqt+iNG8b337GJplOXac15ESwJX1pTOHNPCjzSOtiYJpqgVFhsu7U7PlL4W75IKXJdxGvGxLEKmpAwyoRJ663DLB0eDQQ5PrpzYpNLxXJz1/+97LkF22VD5r8pZ71WVXc=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from MN2PR12MB4488.namprd12.prod.outlook.com (2603:10b6:208:24e::19)
 by MN2PR12MB4581.namprd12.prod.outlook.com (2603:10b6:208:260::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3912.27; Wed, 10 Mar
 2021 17:11:53 +0000
Received: from MN2PR12MB4488.namprd12.prod.outlook.com
 ([fe80::5deb:dba7:1bd4:f39c]) by MN2PR12MB4488.namprd12.prod.outlook.com
 ([fe80::5deb:dba7:1bd4:f39c%4]) with mapi id 15.20.3912.030; Wed, 10 Mar 2021
 17:11:53 +0000
From: Alex Deucher <alexander.deucher@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 2/2] drm/amdgpu/smu8: return an error rather than 50% if busy
 query fails
Date: Wed, 10 Mar 2021 12:11:37 -0500
Message-Id: <20210310171137.1056593-2-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210310171137.1056593-1-alexander.deucher@amd.com>
References: <20210310171137.1056593-1-alexander.deucher@amd.com>
X-Originating-IP: [192.161.79.247]
X-ClientProxiedBy: BL1PR13CA0286.namprd13.prod.outlook.com
 (2603:10b6:208:2bc::21) To MN2PR12MB4488.namprd12.prod.outlook.com
 (2603:10b6:208:24e::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost.localdomain (192.161.79.247) by
 BL1PR13CA0286.namprd13.prod.outlook.com (2603:10b6:208:2bc::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3933.13 via Frontend
 Transport; Wed, 10 Mar 2021 17:11:53 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 5a167319-1167-4c68-4b95-08d8e3e79a00
X-MS-TrafficTypeDiagnostic: MN2PR12MB4581:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MN2PR12MB458145EF975CB09CF96F7667F7919@MN2PR12MB4581.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:346;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: GA0xNVLLLTSUQ31v4wbVOrvqDy8fZmeAeguTE8EIzUNgSOe7ZY2/hlgagm0wWaR/Lgk57/AH4DcAq2N5dpPp2ZBhz1/pRbWV5CXUwb+T2B8bGh8PgxARsMITX8k4zbZe+dCLaJ1p5IhnWy3yMEVO0zb77Ty3TVJYkFvr9qLEAoRImY7aLbNXBPLgoQBoEQazv6qMkvosOlNEe3++JXXAtJsr1KoNHwumxJaSKdYT/qTH77TS+ptj78i53IeoVXzWtOBIKG3OGVACQ99P/DiRvelq9233b0U/Wyt1mJfY/wZ/qhc2Dw+6TWf0uZzHeZEII54GaWxB97TCG0w0Lb/BWOQlCNfNclqlQ7qJoptlAjfbjynBWVvs7k6XUvSlt46GcQRzFMa24DwHDxIWWHHu4P5Jt1hhSglrRNYRZ/ZABZigGZYPq0vtWq5cHLKe1S6WZOt2aNcGNMQHlm/mf8QVnCTap0MGmf0SYDs6qXJJtR/r4637if3Xa5RUiKTy3k8gH3h/S733ug8EAJfMQ8q3m2DLwn3xPQTMHIJlBAROaFjf95goRad6IFdUDElKWYnlbYAoy9UGzhOFPNKWrCA3/Q==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB4488.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(376002)(396003)(39860400002)(346002)(136003)(366004)(86362001)(1076003)(4744005)(2906002)(52116002)(478600001)(6512007)(8676002)(6916009)(8936002)(316002)(5660300002)(83380400001)(36756003)(6506007)(2616005)(956004)(4326008)(26005)(6666004)(6486002)(69590400012)(66556008)(66946007)(66476007)(186003)(16526019);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?EnCfVIqycxMu5IhP09nyy6gJkSokiZbUVgKxsV9jqbg360q+2/6SlmslcDdy?=
 =?us-ascii?Q?Tsjf6erpKVlGds/+AHgjsIpnNXNsxVYyOq7nluh7+RF1zkoNAFpezJu9fJQ6?=
 =?us-ascii?Q?I+ZpTRKFODiq6gUQa6MO9IVRNZSaMsuvmSbfVq9bf0sHGiDq2jkGlLDRdpv5?=
 =?us-ascii?Q?4tM3Qxab2QahXLPAD9rOL/EDF8Ar2nqUwRBY1kybpLr4OdxLsDMcIpxteImr?=
 =?us-ascii?Q?DPsKlFADLIvcl4cAsEg8x2zUYd30UvMaV0HR+M358YUgIMs8fyqMaPNQ2Kwu?=
 =?us-ascii?Q?uVF0fn1C82CWJ5XCaSH95+fqCZrSVNmhL/iYnpz2xEy1P9xXOPDfO3edXd0e?=
 =?us-ascii?Q?jEK/2g2CMNd1DmYwtkeDAziqiyL6uw9i0QUgqBLUqghRKQibwoNztHCcnP70?=
 =?us-ascii?Q?kxr0Veoer53zQQcAybCcU85FAW8Scqrmw8uQ90ImQtyfvwj3Kn2ocrLzsmFf?=
 =?us-ascii?Q?t2sdUHzAdcn4GoNZsh4Qpu+wLCh4GB40oKMDQD+P4h8cz5xVNEJLmDdTkWOt?=
 =?us-ascii?Q?/VS1pJT15iwgImK0CQoQwo2N1E0EiAtTdvIUk223Q9jlph85fPXwMJABTRvD?=
 =?us-ascii?Q?N5P69hcoPbEOJrAKRUv0xQGGZQL+kyxZUz913BPrDIYxxs41DuejjFeOzDqz?=
 =?us-ascii?Q?y484k/XDaGYiNbABj2Y4nVFAeKb2shF18ELabLQN5W5eQpbQeScfF0CIHbV9?=
 =?us-ascii?Q?tYUBBAv2Wwb4ewxbWvHRfnplv/aSEl2nWfg/HI3AiEHHySB8MZczXqaoXx/a?=
 =?us-ascii?Q?NodI3T0DMGG382gdfOyU+Q3p5CjGCZbD3jyjQFXbhuyNfLC2YN/Tr6AM8u+e?=
 =?us-ascii?Q?eTVhIcxGtHp7yvadxiK6iFWHZcd3a1z694+tq3h4fB4/mV4IndWvjkx54R7s?=
 =?us-ascii?Q?dWaZC/YJXI+5jQqOv5+eu5Z6RCerRN4xSeN8cpxxi25I7jrBGmL2IfebAvMK?=
 =?us-ascii?Q?PL7aRVzhagjW/2hu36NlzF4DUut8Hd7a092+DYvtsz5/mvq5FCG7ZlJz+Zfc?=
 =?us-ascii?Q?k8k3iLXmIFFpd0jqi2jZfprWFvHplsIjl8xSDDaZ4TYtBnfpdLZl6nfEPppr?=
 =?us-ascii?Q?LxYKv2hi0duYWZp41LuW7FSQLeJYvW55uruSAVh9lj4fG9VCSO1bgnHtfLMO?=
 =?us-ascii?Q?FKW91T4G54oNLgaHLprq4OSgnirIpXZWVtXWn8K4VfLWMbP7xbKBZescjJgx?=
 =?us-ascii?Q?XfaWJA2cyhmD4Kws2e9JUPiPcnaMxVimGWpDFe5/6BzSnfwMggZx1dF7jcOB?=
 =?us-ascii?Q?HjoD0tz6KFuvaTp5ibRQsgBdYO6R/U/1TMUYcFUE8H6NidisTcYKg9zNhCEN?=
 =?us-ascii?Q?36VKyY7FiAxDXdLz6xrD+GYN?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5a167319-1167-4c68-4b95-08d8e3e79a00
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB4488.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Mar 2021 17:11:53.5876 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UBQhIna8PNlhwb+9Y61cl8yWSR9oeRFOClddNqREw0gajiWH6+/JlRETJ8OabUQ3B2kKbPTll36GFohnRlZK/g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4581
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
Cc: Alex Deucher <alexander.deucher@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

For consistency with SMU10.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu8_hwmgr.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu8_hwmgr.c b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu8_hwmgr.c
index 2cef9c0c6d6f..e64c6ff75b44 100644
--- a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu8_hwmgr.c
+++ b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu8_hwmgr.c
@@ -1791,7 +1791,7 @@ static int smu8_read_sensor(struct pp_hwmgr *hwmgr, int idx,
 		if (0 == result) {
 			activity_percent = activity_percent > 100 ? 100 : activity_percent;
 		} else {
-			activity_percent = 50;
+			return -EIO;
 		}
 		*((uint32_t *)value) = activity_percent;
 		return 0;
-- 
2.29.2

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
