Return-Path: <SRS0=hzAD=H7=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B080C433E0
	for <amd-gfx@archiver.kernel.org>; Mon,  1 Mar 2021 09:10:07 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 42CBF64E01
	for <amd-gfx@archiver.kernel.org>; Mon,  1 Mar 2021 09:10:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 42CBF64E01
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CFA366E52A;
	Mon,  1 Mar 2021 09:10:06 +0000 (UTC)
Received: from NAM02-SN1-obe.outbound.protection.outlook.com
 (mail-eopbgr770052.outbound.protection.outlook.com [40.107.77.52])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7A22D6E52A
 for <amd-gfx@lists.freedesktop.org>; Mon,  1 Mar 2021 09:10:05 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=U3ia/rtXxAwlYSBGRWXSuN//K1iHUO3HnNYucmARxGeI4jCJdlyPuTfCJnSrlpA9Jh54sj0MibC4t+kbf1LMzcy3cmAS+m+jgiolBrwURSBnjQU1PKTmO9WynvW/Hnw6eBlfPZM1RJUi0E0l+GBe/R7ELe5I88vne6rr7y7FNTdsP7D9cE+p3QX+DV9crgIT7c8xTjAnnYHTgbtarunMAlfX6gCzzSZvWjOPSdHSYIXhc+843xOSjMhlJMh8z8x5+0hY5guU3X6fwmyDj33qq7hvGKikvWL1F2zX2FS8J9ZEKh1GvDMBrMOP98whUSEP4ja9egiHj1PVUQ+l/4zYnA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yrvn91cL4RLHB7b24qGboCPRjcH9kiKandWoJZfuNmY=;
 b=P6O7IN+Jvd/3nTd1MT0iRiyqY6KlT5Yp/hy0TOG3CUm9C4LrpiOIxKEGjX3v2Lszc+UhYDODOYPCZaK1BemS3ruO+R87hS+gIIvIx704e+nq1r65U5q2Osjb7bZAnJ6KAkUYJAVbY/1/lje/oWez2QO4CJTh9wTQ2hMmWtm9UqHIa7HiNH60dgRqEabsr5BaZgB94PopciiFQf48zyEyxiv42+C+NxxWhhue+qFKTNU2UxOs4NeZntuBIpmEIFR9h6Sa7Xf5RASNqbR3Xwe/9pn64WjybfhEY5OUTS3oEAZb+IRxystn0C8kBfMqHh8ovYlf2DBEVSuxJRSkYhi+RQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yrvn91cL4RLHB7b24qGboCPRjcH9kiKandWoJZfuNmY=;
 b=hYmfqymCvnnZzVKz7iW1WM7GqB/PdSRd4nJG4mQ4zKVMkB2pC77jQd2wZ0zgCth6zzTKy1g9bLXU5sotIry9OHKbqt0sC55REkPgNsaX8IIOC10HUIdN0olLMP/6iM/09RgRAmj1JsATjPKxk2yPq6uhnk+P4XnuBl44AvtCHdE=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from MN2PR12MB3022.namprd12.prod.outlook.com (2603:10b6:208:ce::32)
 by MN2PR12MB3390.namprd12.prod.outlook.com (2603:10b6:208:c9::25)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3890.28; Mon, 1 Mar
 2021 09:10:04 +0000
Received: from MN2PR12MB3022.namprd12.prod.outlook.com
 ([fe80::49f7:4979:3a0a:4554]) by MN2PR12MB3022.namprd12.prod.outlook.com
 ([fe80::49f7:4979:3a0a:4554%6]) with mapi id 15.20.3890.028; Mon, 1 Mar 2021
 09:10:04 +0000
From: Kevin Wang <kevin1.wang@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 2/2] drm/amdgpu: add SECURE DISPLAY TA firmware info in debugfs
Date: Mon,  1 Mar 2021 17:09:51 +0800
Message-Id: <20210301090951.43956-2-kevin1.wang@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210301090951.43956-1-kevin1.wang@amd.com>
References: <20210301090951.43956-1-kevin1.wang@amd.com>
X-Originating-IP: [58.247.170.245]
X-ClientProxiedBy: HK0PR03CA0120.apcprd03.prod.outlook.com
 (2603:1096:203:b0::36) To MN2PR12MB3022.namprd12.prod.outlook.com
 (2603:10b6:208:ce::32)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from kevin-ws.amd.com (58.247.170.245) by
 HK0PR03CA0120.apcprd03.prod.outlook.com (2603:1096:203:b0::36) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3890.20 via Frontend Transport; Mon, 1 Mar 2021 09:10:02 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: f73d3a5d-e49f-49a3-8d02-08d8dc91ccaf
X-MS-TrafficTypeDiagnostic: MN2PR12MB3390:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MN2PR12MB33901F270F4BCE6494720226A29A9@MN2PR12MB3390.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:854;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: drSw2pNI3KRZi2Pt1AFtGMWT6X5ENPH4+EOTxASHKJWhhU2NrKcXUH5UNFfy5RPpW3xtk2dF2TaA53m4PRy9Xwju1NHNN0naIaqak3izf8z0jbhgzcV4IR9BTuyjdcSErcWoXaZY85Y9nID8JkT/3kti9dIwdJitDYNOjbiRcB6+2GQjbiccdPMZKtztOjJ70q9S8EFrIYIujdzyZ3yk1FLUHYS9OKtp07LkiygoKXLle/gin+LdCo9jHnhAqToWj7tfiQWGnR4lHHmwsto30EI5xCVM4eiYDhVFo92WJcZ4+LoAMx7hCbWHrwXZcXEacLJTIdfl6F3mmkYyj9LxwSpA0+2UMOHRjJjKefB1iJZsbbfJ7ePCzZWsSAX6nxABVQpl/T0l0jbgExSE4og8ZEYyt20snmnjyIEAkTbzl817+KvLjL9rM89erjj3Oz0sa3+5ZYh6NxCs4QhHJUJzsrLo3RXVdlemVKiHYuY8aULIseYHptqDc7bC325NhGwMY7aoFpiugZNtFSDzmFHBqg==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB3022.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(136003)(366004)(396003)(346002)(376002)(39860400002)(36756003)(26005)(66476007)(66946007)(16526019)(5660300002)(1076003)(186003)(8676002)(6666004)(66556008)(316002)(86362001)(6486002)(2906002)(8936002)(2616005)(956004)(6916009)(7696005)(52116002)(4326008)(478600001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?XgEczTN++Kjt1YEMHiLhZknvk9d7EOjP7QzJoDYGsIsMIDnnbuigruHZjFUL?=
 =?us-ascii?Q?PR/uhC7CaQoWmdbFI4CpfuUN/W7GSUXrcxqt1BVMa/5mXnYdaO2l22GolNG6?=
 =?us-ascii?Q?r8rMijsnqPTLK6vXakhgDbvPPDqYgKYSKa0bctqx7DMyKqMUeFhc/6wM4xF5?=
 =?us-ascii?Q?N1RflFYxzWpnez6PLDyif6pL7cE7jvw45ekQM0A8zW3csEjshy2NP5F4bA8K?=
 =?us-ascii?Q?jUjOZ6afkdKZG8HxqqK0bInuf36nA/r8Wc9uwyQdmk6KAQugGAY41e1aLlqz?=
 =?us-ascii?Q?bp49b9RplEDNqFG2YUSKG5Na3Pdb3GxWCu+4zf1IJYeblJ5bq1Av7qLRrpuX?=
 =?us-ascii?Q?t+wFyP4FHQS4gAohUEXeZABID6eC0LtXrASRNNS0LxCZ41hQFVWq/FR+4U66?=
 =?us-ascii?Q?DqJ+1RHoE35ZeFpGuXNhOJZguQlgwqIDXX/uqLs46ilWR21nPsTFvJ/z95h2?=
 =?us-ascii?Q?iYgOXsgR4XoQJYKFeS4NDAJ6qJ6P+OZIAHstUPoA7Qu0fXpCPqBvyAAXfmFo?=
 =?us-ascii?Q?qJvCVgsOYP8/bvoDgQtZR+ou9oS/QLm0FvR/rnWcumGHpp4waqQy8RcIKQQm?=
 =?us-ascii?Q?vXKfiaepqxLwLMbA5fLBH5BMyWcdodGdluPmvBMcDGaPKvnSaMBQ/sYB//Eg?=
 =?us-ascii?Q?QJFvektO88oVjDIXu9IrRbR8JyVbE2A/iuh3prgnbK4TVpcPO7do1LOSdD6A?=
 =?us-ascii?Q?/JY4rW1zBFKOXC/7KQvHODXFxPHCtad7oVnO++2ief9PWR5VCHX5Z0/kxWw4?=
 =?us-ascii?Q?IzumWhQitXczA9f/wWbp+4xTpTwy/lvqoWqfOprkr98G3FUn4P0COuuMO3fK?=
 =?us-ascii?Q?O11hLX2N23hnEIxT6FPIiztBK0CCwh6mANYJSKE2ZSSVjc2qjKnwpQwgzckW?=
 =?us-ascii?Q?kgk+6O8mGyFNxDIBTrwq9hSgvlyE/xHqZY1/fySPgIXgBzHgaucwu9+IZPNb?=
 =?us-ascii?Q?wC7HQ/OUew1pVqjC/0zKhyuzdVHhbIBfNxBOZiRB9kfobydxjXmH8ZD16vWl?=
 =?us-ascii?Q?5Z01wjs5mdIP9NCg9XRkgcgNKo0N0y/2GCvRFELENEniN70U6BrhYKOXIiUt?=
 =?us-ascii?Q?OAGd5SPqiXJvTij1IrdYJN6ZviB8r1MV5C6wHoXXrRzN42QB1HXM0P7hUX1w?=
 =?us-ascii?Q?gTzFQuF56nkMEXERxosTGTT60vh278wJZnNgCB9XQAHIUP3QpBl8cy8gQxnR?=
 =?us-ascii?Q?5Ht9zyHgweni5uxRwDjyuDnoCq3RS9yjkQaYONxtt0AfO/3AYRS/ewmuQh/C?=
 =?us-ascii?Q?OogvMpXqdnoLAxTuwOEHU76SGsyvSVNfw6MNI8KgRyJ062vdvchPHRIA7Owz?=
 =?us-ascii?Q?QtMOdDsZOalDEgZhmCj6QWBB?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f73d3a5d-e49f-49a3-8d02-08d8dc91ccaf
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB3022.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Mar 2021 09:10:04.0947 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: EZlQQ+gUbR/9nnfxGV+eRLueZY0a0vN05s08WRU91ZtyuiD4cDsmGuV8sTotI6WM
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3390
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
Cc: Kevin Wang <kevin1.wang@amd.com>, hawking.zhang@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

add SECUREDISPLAY TA firmware info in amdgpu_fimrware_info()

Signed-off-by: Kevin Wang <kevin1.wang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
index 1a27673271b0..ed51dd0468e8 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
@@ -309,6 +309,10 @@ static int amdgpu_firmware_info(struct drm_amdgpu_info_firmware *fw_info,
 			fw_info->ver = adev->psp.ta_fw_version;
 			fw_info->feature = adev->psp.ta_rap_ucode_version;
 			break;
+		case TA_FW_TYPE_PSP_SECUREDISPLAY:
+			fw_info->ver = adev->psp.ta_fw_version;
+			fw_info->feature = adev->psp.ta_securedisplay_ucode_version;
+			break;
 		default:
 			return -EINVAL;
 		}
@@ -1363,6 +1367,7 @@ static int amdgpu_debugfs_firmware_info_show(struct seq_file *m, void *unused)
 		TA_FW_NAME(HDCP),
 		TA_FW_NAME(DTM),
 		TA_FW_NAME(RAP),
+		TA_FW_NAME(SECUREDISPLAY),
 #undef TA_FW_NAME
 	};
 
-- 
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
