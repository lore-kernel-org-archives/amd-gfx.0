Return-Path: <SRS0=3j8t=LP=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D941C48BE5
	for <amd-gfx@archiver.kernel.org>; Mon, 21 Jun 2021 17:12:50 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5FE086102A
	for <amd-gfx@archiver.kernel.org>; Mon, 21 Jun 2021 17:12:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5FE086102A
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0F1966E239;
	Mon, 21 Jun 2021 17:12:48 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2077.outbound.protection.outlook.com [40.107.220.77])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 571656E219
 for <amd-gfx@lists.freedesktop.org>; Mon, 21 Jun 2021 17:12:44 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nZNNwEO/6+5SyFKseMPy+qHhSnWOPM3YDn97LYvNCO97kkqV/gzyM4whrpmTB3kg6fp5iI/P1OmIoqFEgyuMye5TZpjvoRmK2Bd9Y5+VUcqTPpJzfn0HeebxxVuX2BXc7OYuRxee1xYpw0dxmc25EhDMaU5vikTC/sVFbhvqQXQjvqyscjRB0Uy6t15cun00psLsTkW2KE2gibhVvECHXJ5HZo5yGJmdP/UIDqxYwEoFSBAzqb/TMu5Gy6d5GIM4hXEXwVQQIv8DyS928lbqLhvMPrQ3vOOm7d0zDU2pIDw1jEas+8HVxnCCqwfWX9BkF9F2RJKAluW22INiOGigxg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=c9ZN0zS7dWr/UByPOYTNOFCSxHuVkiMzdoVppLcnUzI=;
 b=AhMOJhH5meMCKwGgmMpT4LNUOG6hxh+hw/hFFgAiS9BQ/gzJcQWMcpXy4Ao/ZtE4gsm4s6qkNUoZ3s/ToYn4rc9Fbv44asfBj2wPiCa0l4DKC40KK1CGs3apz0YrZayIRSp+8jgLn6+J8zqdO8HZP456lqYaWmZ72tbZMB7FdcnjuWEnlYFJJyDziJHPYIHUB0SWQTtbjyub7tUUdLd3YZpX5FqFZgCp5qjP/ijvokwnLj2/FISZ+i3S9zKQxt54FvpoETmEG+ZyCxjTOcyLm3F6qtFFEK3sUo4PtOUMIlOdjkT2bYyJd7V5fWdUqmboGcDOoJ8QOFHmk9SYaYZOHg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=c9ZN0zS7dWr/UByPOYTNOFCSxHuVkiMzdoVppLcnUzI=;
 b=RcN4zPSLjvIa3V2PgvCpJQiu11yC9lA5Mf6C+rcZGRqMIi7ruUZ2l76vrqtyQ1/sPRFEs7FusWrKSX9z4/sJR0huHnTR7sqCC1Gok68wploMzLEWurElPFHLlAWuz/UbpSlUYelxyTUhEV/L6GQB38FHJBSYcJ1XCqcgyCCk4uU=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB3962.namprd12.prod.outlook.com (2603:10b6:5:1ce::21)
 by DM6PR12MB3865.namprd12.prod.outlook.com (2603:10b6:5:1c4::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4242.21; Mon, 21 Jun
 2021 17:12:43 +0000
Received: from DM6PR12MB3962.namprd12.prod.outlook.com
 ([fe80::142:82e3:7e9d:55a0]) by DM6PR12MB3962.namprd12.prod.outlook.com
 ([fe80::142:82e3:7e9d:55a0%6]) with mapi id 15.20.4242.023; Mon, 21 Jun 2021
 17:12:43 +0000
From: Luben Tuikov <luben.tuikov@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 12/43] drm/amdgpu: Remember to wait 10ms for write buffer
 flush v2
Date: Mon, 21 Jun 2021 13:11:50 -0400
Message-Id: <20210621171221.5720-13-luben.tuikov@amd.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210621171221.5720-1-luben.tuikov@amd.com>
References: <20210621171221.5720-1-luben.tuikov@amd.com>
X-Originating-IP: [108.162.138.69]
X-ClientProxiedBy: YT1PR01CA0054.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:2e::23) To DM6PR12MB3962.namprd12.prod.outlook.com
 (2603:10b6:5:1ce::21)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost.localdomain (108.162.138.69) by
 YT1PR01CA0054.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:2e::23) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4242.15 via Frontend Transport; Mon, 21 Jun 2021 17:12:42 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: be0a4a51-7e92-49eb-243e-08d934d7c7eb
X-MS-TrafficTypeDiagnostic: DM6PR12MB3865:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR12MB386596A3BE078928A9AE1DAA990A9@DM6PR12MB3865.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7691;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: wttJjhp25hE39nf4KwP/IssUdVlrY7jO9A4KK0AkHhp+xsvoYFq9tUs9j4MNQIGhXs4y5JfapdDRco6y3DH/59MP3YbEWQULwJjVVu52Vs2NnFjFNb2CQPyPn5Ji0Eby1k6hxuKNiH1hh+TRMYYvAAE+XW3rEaLnyvN/sXMGx/nphvV3DwDHv2QqQ+YsXDHT0FuVViRaLJp+ELK1t7USqMP3+ZZ/IlY8WS+s0io4opzvUwI5EsHxD1U8qZuG9A8xD5FXtr2j+Zrem6T8C0loUrhVjPsZ1DCffyrY/z8WgMZoqka7Br3eBSwSgbDKYA2H0x1zckfv1Od+PILnPyL23ikYl0EzyYuGtZ7n+MiPqE2uBJM76A+bprg7HGRPMhTWcMxD3AymzxKZ6NV6jxfCNKhHnkp+UT3aS20QJQHDrXDJOf2RxpKDtQov/9U3/C4HjboCY4dZqaa7nzlr+A3a2XOtGIuc58do3L807DKHF67BmaUb9SvRHHpqFuQg4cRxit08mW8YNpTg18tEfegA/Vbuy1XzNUpeHpZiUN53/3rY3eTU/aOusa47cv/RFaghyAqSrWZAcYBS0JqpkFUE5rmBvMYTeQ9te3SVSxf68zUuwUvSPEIaAGxStoFAsNZQUE70gzXqDdYDAKgmL2lPPQLymfy6bYWF4g0P6tYGc7jwrIGitcymT5XxQ6X8plzi
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB3962.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(136003)(366004)(39860400002)(376002)(346002)(396003)(478600001)(44832011)(54906003)(52116002)(316002)(66556008)(6916009)(66476007)(66946007)(8676002)(2906002)(5660300002)(956004)(26005)(6512007)(6666004)(83380400001)(1076003)(8936002)(38100700002)(38350700002)(186003)(6486002)(2616005)(16526019)(55236004)(36756003)(86362001)(6506007)(4326008)(69590400013);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?spbPQpOIAoiPiUJO0muk1L6nLCRK8yfbfU7K44qjICnSjpAzzulgqFDQmd7d?=
 =?us-ascii?Q?7ObYsChv5WHGYFpuCAqL/+DnQOtrx2FjcFLk591uE3uiB2yr5VH+Qw90cjpc?=
 =?us-ascii?Q?+Y/XM8Q6mFzL+xVtcZvo0Td45Kh3E7Qp4e6BNlaiisScHmcyEYUbJTOBJZho?=
 =?us-ascii?Q?LquvgsiQnNPqKDg4laBFrXtlkhGJhwvIVzfHPqKxblX07aT6HXWszMOmEhm4?=
 =?us-ascii?Q?+NjwdYxraU8rsBCapPs09sTa8ZDqi495PPVmM2XZDXNUvd0R7yD9fTVcteSb?=
 =?us-ascii?Q?sz6aFOCYyFKnaJd9TUzxdBDXqwrKDNhbyWIpR9K8srohDKw2dFLz+CC+/83K?=
 =?us-ascii?Q?WYIaxIZGxmT1sEcxF7+FGGFZQyKVOd4fjgdQxBxWJYGTB3XnECGteFEGZg8k?=
 =?us-ascii?Q?s7XS94QTiUbeWl9k8aHm/EP0Bc+h6litr3a1rC7I031AIIYYVYlApGAFPrdK?=
 =?us-ascii?Q?7Bz3YhHPVEjlkg4ppxdsAeBz4LHhFbdUMclwQZceciOSvX9IyFr4+jtif3V6?=
 =?us-ascii?Q?UJTr42ZI0rxZH3TI+RQkQgfHmk23bhEbMeePN3s1aVDTF2XuOLQcG3cGCRdL?=
 =?us-ascii?Q?Vtn+uGcaubApIpZp4bH6kzoH8unCXPe2gPyHUcEl3jAWJQE4JpiAguCFRoC9?=
 =?us-ascii?Q?wLdGebOwsN4BAoyV29SUSHWBd7EtbsAMfazmtVEcl4uGQ94s22Br12Kia026?=
 =?us-ascii?Q?4mKRFpMEMyHyjEEUvOPzTYmNvNFQAQEGdB9p4H2ynRXybbgO5l4fwGPeyysu?=
 =?us-ascii?Q?TJfXVUqN+krYVZ1RjpAZSZskwcZtESxGabKYUgxHjpxA2K2hN2bGJJNtTWYb?=
 =?us-ascii?Q?MI1S7dyxx5vjaTCx4snJADCsOx/sVTlNEIbgduIcTb8QoTrJxjgC9Q/IsLHl?=
 =?us-ascii?Q?VoiJHcuZ8v9ReqJ9pIbkjVh0y32epBTROkxPo9kaX9o1xZAi/46klM/SoZE/?=
 =?us-ascii?Q?hL8472Qp9CgdbUfkAZSp2xoQ4kvXRvdTTkTt9DHVMwfPLPXBNQcmhVz5hkDY?=
 =?us-ascii?Q?DfRnFjoYTtMNbuULYCpvH5Zt6JUhpsWugIASCLroUzQSEE4bcgc+o7wACwI+?=
 =?us-ascii?Q?fvifmpPF/MKuT0kgvQbadpdC2idzz7T8Q4HT7i1EdbTcArDdfy7qrkUxrrtX?=
 =?us-ascii?Q?R4y6s3AIkLvcCR3h8evLtWfBLAP9O7+EQE0xTKEXd6sn4xwpCT42HPVugEz8?=
 =?us-ascii?Q?b1MyHDTNHDzs89yKl2WGc7CZXghPg+l1dMj+THMyHFEHl9Qc4oqspuU1Z3qO?=
 =?us-ascii?Q?PPsM1sTwmKSgr6Rr84tH1ny55cvBMx8whZrTSU4sLcrsJHR3fvSqBkHMJrKc?=
 =?us-ascii?Q?vdSv3RevRn9MHYRdWhWRFun7?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: be0a4a51-7e92-49eb-243e-08d934d7c7eb
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3962.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jun 2021 17:12:42.7364 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: viD6dzEzkHBh///cEz6alkAwy9ykjRU+tXt9mLR6ZUvdfcIbDtht8rfGbBv1tLev
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3865
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
 Andrey Grodzovsky <andrey.grodzovsky@amd.com>,
 Luben Tuikov <luben.tuikov@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Andrey Grodzovsky <andrey.grodzovsky@amd.com>

EEPROM spec requests this.

v2: Only to be done for write data transactions.

Signed-off-by: Andrey Grodzovsky <andrey.grodzovsky@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Reviewed-by: Luben Tuikov <luben.tuikov@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_eeprom.c | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_eeprom.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_eeprom.c
index 10551660343278..fe0e9b0c4d5a38 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_eeprom.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_eeprom.c
@@ -55,6 +55,21 @@ int amdgpu_eeprom_xfer(struct i2c_adapter *i2c_adap,
 		r = i2c_transfer(i2c_adap, msgs, ARRAY_SIZE(msgs));
 		if (r <= 0)
 			return r;
+
+		/* Only for write data */
+		if (!msgs[1].flags)
+			/*
+			 * According to EEPROM spec there is a MAX of 10 ms required for
+			 * EEPROM to flush internal RX buffer after STOP was issued at the
+			 * end of write transaction. During this time the EEPROM will not be
+			 * responsive to any more commands - so wait a bit more.
+			 *
+			 * TODO Improve to wait for first ACK for slave address after
+			 * internal write cycle done.
+			 */
+			msleep(10);
+
+
 		bytes_transferred = r - EEPROM_OFFSET_LENGTH;
 		eeprom_addr += bytes_transferred;
 		msgs[0].buf[0] = ((eeprom_addr >> 8) & 0xff);
-- 
2.32.0

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
