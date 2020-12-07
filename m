Return-Path: <SRS0=y+Th=FL=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA69CC433FE
	for <amd-gfx@archiver.kernel.org>; Mon,  7 Dec 2020 06:07:07 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5C516229EF
	for <amd-gfx@archiver.kernel.org>; Mon,  7 Dec 2020 06:07:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5C516229EF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id ADC5989FA6;
	Mon,  7 Dec 2020 06:07:06 +0000 (UTC)
Received: from NAM04-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam08on2087.outbound.protection.outlook.com [40.107.102.87])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5B3B389FA6
 for <amd-gfx@lists.freedesktop.org>; Mon,  7 Dec 2020 06:07:05 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Vn3YZjujHwSOcP8zFyoRMViyZ8ZbktxTQmWp0qMv1oq7SIhd02JlQgI+qlCwK0pL9eWBxu3IDmFtPfud1uz2u347tFP2w/pcJ3o6kAYN852YpgNa0WeeJSJ5YKntggXX6xLye8P8C3abbl/6W1aniVwVN7aZ0SyFeHcZgkM/oGVb2FFBXPD/8nMNAK51j0IkBSvkjaAcXBjPMf7/k5qXcq+3k7Put/kMheAom9cL/yieeZZA5vXdiZHuL6T1BQnqQYvR6FYx61lGpmah4jmw0gArxY2Kx1/LGBclkKcEny+gyfjbFHsgDWjV6HT0gE43wrEOJEWvX+IyBmE1mgsTTQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AVY2TnYiI+P7F5qu9bd6hBY8dl3VZMsw/cEnpqgvaQY=;
 b=JWdsb7tB6VK5NVDkQ6FoFFDvehJK7F1pJeqTXI79eDDl0u3foCx7HQ+BpUodLLvxljaAt+g+Dfkl4F6d5QXck8cbxJEFUsE6gp7sXlegNJZvY+Ppt85M4UNSKPTvu0Sk0p1YUBrD0oxM4hjcmaafFtf9LDs4h9uHemmgdbx6VFgXNz+//cjvVw55RfDNqkwSKed9KqamB8TGh3RNTCjyRbSXzt0basiiKvx50ZrO0OJHCXQ8xlMv6EC7/tNfaEgP5V+8wHUxtZDb1es9yZZC9dExp90EbNbvRcjMjH1WglepT2B/X1OiKw4NTOtFXQgWwD4JxR2+R3xoR+SI8phq4Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AVY2TnYiI+P7F5qu9bd6hBY8dl3VZMsw/cEnpqgvaQY=;
 b=n6MLyoNzqtqd7p4wDxXan9vmUBBk1oyxiNSZU5TiVjTIQwWkpY+ZPmzLtHA+XNJz6CBbjzk7994jkk3EK/y9HT4oWRPw292ARYYdbBTrvdKMV7bV0I9Rmqj9wgKmrF/P6WyY12yjtayjYiiTyUaVhpl9eSIGJZ6avi02Ue4qOF0=
Authentication-Results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
Received: from BYAPR12MB2888.namprd12.prod.outlook.com (2603:10b6:a03:137::24)
 by BYAPR12MB2998.namprd12.prod.outlook.com (2603:10b6:a03:dd::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3632.21; Mon, 7 Dec
 2020 06:07:02 +0000
Received: from BYAPR12MB2888.namprd12.prod.outlook.com
 ([fe80::617c:f1eb:fd73:b236]) by BYAPR12MB2888.namprd12.prod.outlook.com
 ([fe80::617c:f1eb:fd73:b236%7]) with mapi id 15.20.3632.021; Mon, 7 Dec 2020
 06:07:02 +0000
From: Tao Zhou <tao.zhou1@amd.com>
To: jiansong.chen@amd.com, jack.gui@amd.com, hawking.zhang@amd.com,
 amd-gfx@lists.freedesktop.org
Subject: [PATCH] drm/amd/pm: update driver if version for dimgrey_cavefish
Date: Mon,  7 Dec 2020 14:05:53 +0800
Message-Id: <20201207060553.27981-1-tao.zhou1@amd.com>
X-Mailer: git-send-email 2.17.1
X-Originating-IP: [180.167.199.189]
X-ClientProxiedBy: HK2PR02CA0154.apcprd02.prod.outlook.com
 (2603:1096:201:1f::14) To BYAPR12MB2888.namprd12.prod.outlook.com
 (2603:10b6:a03:137::24)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from taozhou1u2.amd.com (180.167.199.189) by
 HK2PR02CA0154.apcprd02.prod.outlook.com (2603:1096:201:1f::14) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3632.17 via Frontend Transport; Mon, 7 Dec 2020 06:07:00 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 0fdbbc13-4137-42b9-4718-08d89a76508d
X-MS-TrafficTypeDiagnostic: BYAPR12MB2998:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BYAPR12MB2998B88DEC51D239D5A6E3E3B0CE0@BYAPR12MB2998.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:296;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: LNXXyAz1knT0OWyd9q/RHfa4dMZLYhVacdSxWKrwaSoPLHWeSpymeKjq5EaczETMVi4ySt0po5N0R0bsKsGXdD9TRm8llVAG+SCkjO82WpkQuc4j6ErIBhR1dl74D4X8oMHz9ThEZDBiw/4ar6UZVLtnc4tD1vR8JnRGfgbtsy3aLEKjKDrY6RymL5n8ScznvTfG1iqRfpEWRITxPfQF99PMO222OdXEwIWopmG8QYK8ZfGeeM/iUbH4yJdV1kHrjwj2SZq0qpxSD7L9uJFgQp7BychcWj9wM0oFKdV4AVv6p0vg5C7LDXRty0I9HHhrmtdjMeKWPBvv1NIDFx2Dbw==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR12MB2888.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(39860400002)(346002)(136003)(366004)(396003)(376002)(66556008)(86362001)(6666004)(36756003)(66476007)(8936002)(52116002)(956004)(66946007)(83380400001)(7696005)(478600001)(26005)(6486002)(2906002)(2616005)(186003)(1076003)(16526019)(4744005)(8676002)(4326008)(316002)(5660300002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?BoYHeedQGZmkwllCpuRhQ/5OR6duSYyuOlsQCavUDhS465sez/5ElgR/GFdK?=
 =?us-ascii?Q?pz+YB8odo9kPuwUd+4gYSDmlNe1Da+ZBcH+k3hTcPWplr08zQFypAProCMvE?=
 =?us-ascii?Q?9lUOBI4Mzld0vvNWiPBe69t3SCa9WU5guxQOEHYo24izwk2SLYERQz3fktVn?=
 =?us-ascii?Q?f0iPiEhzisfMu4o7dJzwus+Y2Nh71M2VgD2J9/ggtlo5IMCtZa4K4Dz3na16?=
 =?us-ascii?Q?OJF4hJiKo4ScJQCUr8j4QOtV1elOHa32RtSIz8lKm8/3qlg5bzIQy8uyaLUw?=
 =?us-ascii?Q?6hcOzhbd6OmouN3eaoxpGYWW7oMWyWlnqTt8LV+cTeE4ZVF/YtbBjEWDHbNY?=
 =?us-ascii?Q?p5dSL4YPv1pUD8PA+sC0MpBlBgNs5GJ34olUQxijENH1X3qpQx4WjBZDk8NB?=
 =?us-ascii?Q?hXeLV78F3o1eV7vmeJwzn2pefo8jaAv8ynNLRCjOJC7+SlAIcXANjADHN7v5?=
 =?us-ascii?Q?RSS4qE9sGbMJJZS2g7dA22QlQ916CMwhRIhs4WZfEm7TqMlntQrzjFmDqsQS?=
 =?us-ascii?Q?b3h6izwdiot7xWN6CN0HR4EKtIHLI5kJ2+cYWq7ncKjt+aQN7ICQN0mk8KG4?=
 =?us-ascii?Q?GecOCHTx8rullYbVEYKSaSb1BXZlPyB3uI1YIIZRtI8zmU/s2yGyNZ1MasZc?=
 =?us-ascii?Q?vU6k3pd3Do2QYwAitfZeiN0LwwOwKTKfVvWQOOwXDaNTk8L85WkJR9prL7hE?=
 =?us-ascii?Q?MRfctfJKo3cQ5ZlJqCnZKrTViJN3WuOCiaNrkS5ocdGD6vZQzgprN5tQPl3S?=
 =?us-ascii?Q?H0Uin0IL77armSHDvP89N1QejVXYyNA/zSyyaXJPINw3tQpeFcbwTDmFxpAk?=
 =?us-ascii?Q?3lVKuHQmNI5eyLxyPjkveVbOOd/zicq+D4zyjvtgNMPBOPQnQR1L/rqZJcWb?=
 =?us-ascii?Q?Gmv2ToU2HfAeE6yBw9pxyWZQyn/H5uOe4tSkmrG3T1aZ+1tAhbRgHZoaimAo?=
 =?us-ascii?Q?n/O5e8Norra+Yi8pzThksEXeD14txdELeZadhVVi8uyTX64ZHCEmRjljxzhW?=
 =?us-ascii?Q?ur2p?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB2888.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Dec 2020 06:07:02.0380 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-Network-Message-Id: 0fdbbc13-4137-42b9-4718-08d89a76508d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yUzMm5kr2hXqBWcVnO9VgHQTFsYfCgOhT5ITaHR1Tb9KWkQ2QwzE4IyOOVTkdHm9
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB2998
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
Cc: Tao Zhou <tao.zhou1@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Per PMFW 59.16.0.

Signed-off-by: Tao Zhou <tao.zhou1@amd.com>
---
 drivers/gpu/drm/amd/pm/inc/smu_v11_0.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/pm/inc/smu_v11_0.h b/drivers/gpu/drm/amd/pm/inc/smu_v11_0.h
index c1cb472f8f0f..e5aa0725147c 100644
--- a/drivers/gpu/drm/amd/pm/inc/smu_v11_0.h
+++ b/drivers/gpu/drm/amd/pm/inc/smu_v11_0.h
@@ -33,7 +33,7 @@
 #define SMU11_DRIVER_IF_VERSION_Sienna_Cichlid 0x3B
 #define SMU11_DRIVER_IF_VERSION_Navy_Flounder 0xC
 #define SMU11_DRIVER_IF_VERSION_VANGOGH 0x02
-#define SMU11_DRIVER_IF_VERSION_Dimgrey_Cavefish 0xD
+#define SMU11_DRIVER_IF_VERSION_Dimgrey_Cavefish 0xF
 
 /* MP Apertures */
 #define MP0_Public			0x03800000
-- 
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
