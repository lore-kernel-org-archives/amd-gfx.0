Return-Path: <SRS0=OOkP=LC=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00EF6C4743D
	for <amd-gfx@archiver.kernel.org>; Tue,  8 Jun 2021 21:40:29 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C94D2610E5
	for <amd-gfx@archiver.kernel.org>; Tue,  8 Jun 2021 21:40:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C94D2610E5
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 67F006EC41;
	Tue,  8 Jun 2021 21:40:26 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2084.outbound.protection.outlook.com [40.107.244.84])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6617C6EBA0
 for <amd-gfx@lists.freedesktop.org>; Tue,  8 Jun 2021 21:40:22 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IQT3QDJyOpkOMDECJqE5N1PzMgCGCPbNe9yY4oQdNJd57rQeGpITUGnM8LmycBPO4T0MLLR+LY6aqbttj6VLUcO5Ua1BPJuxCPmGi6A4Mt3+AWCTvV4tVnDIUQVegz0nTaPLm2hG7piOCoa9xfusfoiMEkwwtxx++X0Z4QI56c4JoLvJxg8pw74s9FCSCtf/IQDgAMD9FXhe0AvMuurpDGY7mdiL0c6JMr6rh2gvh2bwkZCCQuXSytE+w28KEExGJXprvmtUE5oi3zA6/InCxUg1g7Qub4WA/X+Z8KcTzeUVmzgwbGJSLcrG69nlbhZnr6C6SF3W5vYbhr5HelTMQA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=c9ZN0zS7dWr/UByPOYTNOFCSxHuVkiMzdoVppLcnUzI=;
 b=TDtvbbjRAutNSpl0c7tZ897Xl0ATWu+kZ/EHpMAAdGmwvAp6pip/9EziSX0yDOXayp3E2/Wx6x5Idg3chB5pFBN7SA07YaHXTk+YPA3z2fVt0+sRLaPQ8tUEBl9LZgyZxxtIfAO85MfSfz3LJzd39vWF43FNW7rAt6nCW0ag8lEiPTYMLvh0SQpS7JYvtCujTHLdHPgcIa5RXjT7xoCF3DMbgYtijWL3dnonxXpwsJ9gzXD5JmoPOWKly8fiAuTUEfYg7k2ke+2HON/RvJziPWse4hED8OwjNhkovUtzMyxCpeSBMM15dck184JzT56d1GMGsLh+I8jVDcCgnslCPw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=c9ZN0zS7dWr/UByPOYTNOFCSxHuVkiMzdoVppLcnUzI=;
 b=rC8wBbKPzMhuN2onHKbtOlxHeVfK7gvri8knrdt87JgGuiqSSTJQiZMI3ve8j9WHFuaLbz9CTPZFIbDnevYSPxssnK3XySlPv9NvhLEv5/6EpYbF4K0T80toTKf7MmFry1BFij8bLV7TtLi2gcHTcw6LX6pFQzPmKu6aVhdZl5s=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB3962.namprd12.prod.outlook.com (2603:10b6:5:1ce::21)
 by DM6PR12MB4435.namprd12.prod.outlook.com (2603:10b6:5:2a6::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4195.24; Tue, 8 Jun
 2021 21:40:21 +0000
Received: from DM6PR12MB3962.namprd12.prod.outlook.com
 ([fe80::142:82e3:7e9d:55a0]) by DM6PR12MB3962.namprd12.prod.outlook.com
 ([fe80::142:82e3:7e9d:55a0%6]) with mapi id 15.20.4195.030; Tue, 8 Jun 2021
 21:40:21 +0000
From: Luben Tuikov <luben.tuikov@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 12/40] drm/amdgpu: Remember to wait 10ms for write buffer
 flush v2
Date: Tue,  8 Jun 2021 17:39:26 -0400
Message-Id: <20210608213954.5517-13-luben.tuikov@amd.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210608213954.5517-1-luben.tuikov@amd.com>
References: <20210608213954.5517-1-luben.tuikov@amd.com>
X-Originating-IP: [108.162.138.69]
X-ClientProxiedBy: YTBPR01CA0029.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:14::42) To DM6PR12MB3962.namprd12.prod.outlook.com
 (2603:10b6:5:1ce::21)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost.localdomain (108.162.138.69) by
 YTBPR01CA0029.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:14::42) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4219.21 via Frontend Transport; Tue, 8 Jun 2021 21:40:21 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 3e3bb251-df12-44d9-4925-08d92ac60450
X-MS-TrafficTypeDiagnostic: DM6PR12MB4435:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR12MB44359EF888529234C946342E99379@DM6PR12MB4435.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7691;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Cx0S87UpwD04MBAA4KCm+o8ENjwH7fAAfs/NzVh/tknuOf4x1rn35l1BcPgzMh8e5je9upDc9YUGFChhCi0S+BHrryNM6js3FBKVp7rlmAxXOJJXoi7CZsCGlbAwvtaFwViVn05rs3P8ED5Vj4hEe+tEPHn0o7esVcoDluThx3ki0hgJ9yyx8XmlaGKDqa3VSJqziEKJAemmRICrGLoxy9lFti+duxKW5/4rNh1bdpolegLq+pSOB4Rip/Ixe7YZpTqAWSoe3ZoSrZsMwLICo0UVQWyes6eWb2sQsqtSSSnCDXjrZhKtdP4Idd6qm7KuzZjaHnvrZSQLykMwXpI7lv205V+F0uELgR9HQCjrycAQwCorG0sovf9kT9x4rQVrs2XOjxn3A69Lj7SWoAdyiYRNEUvBf2hB5WrAm4LJiYDEynR4PWezH8lK61LMU4Short3hreXJdtYfnbTopgSTzWNuWZ7p3qBfrfbIdrTGdOU8Iv7hqJbgyfQPIoyYLaVYLQg6gzuy8kp2RKTwwtMMP3kxnyEFeBDAUsLIFP4U8xQ6RVimoRrZb4e4rDCyHuCDfFrVMR1xaY86CCLr2G3AU17CCdg1cliH9evEFgqdmoK5X23NhqlN/DEeF8RQYFkFDV3TtY6gPkwjQniZy+K+pY8dUVxRZS2z+l2zDD5lKNmRHF3q6Lplgh/JsjJNv2N
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB3962.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(136003)(396003)(346002)(366004)(376002)(39850400004)(6916009)(8676002)(6506007)(6512007)(36756003)(6486002)(66476007)(38100700002)(38350700002)(26005)(16526019)(1076003)(8936002)(2906002)(54906003)(316002)(4326008)(66946007)(186003)(5660300002)(66556008)(83380400001)(52116002)(2616005)(956004)(55236004)(44832011)(86362001)(478600001)(69590400013);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?OSWZ2VmKIAzZ1wJfcAeuhcUDb0XPe+nRI2oePIMttkIDhmXEId3IxRg+N8sI?=
 =?us-ascii?Q?Yb3xA49N4a/on9a1wE2nBDrHL7R33TzeORXxUdZEO/L43EUq6ZQB09x2piXr?=
 =?us-ascii?Q?4nVzQxw9FJy9y+402zmQFcLr2t1jE+dKI/kSYc3or4X8k478WRA+eUau72g4?=
 =?us-ascii?Q?taDM7tUtq+3I31JEdnL/G6BM+DCbJjFjI37toFA1XbfYbSAexRmQPW5F9v6B?=
 =?us-ascii?Q?1sBWlqXL3lLlUQJH3tvKsHkEn+8HCTlPwIOS9PJ1GJ1V5/pNcNrKBgLJEV+/?=
 =?us-ascii?Q?r7363Jp8yGyYHeZBp42u6+6oDEsPOAvcWRkyStahxsdgYhmIUAQgMgdutePf?=
 =?us-ascii?Q?vle/Kl/RojpKUy8Tlvp9eDh7N5ceO+CUp3FvKMQ/gl4JzKDPN3J31yjRfqyL?=
 =?us-ascii?Q?qp46vfGZ827yNc2CKb0j0XVIeIw3rGDx4bfigqeO+EVUYGXS/jQjRKjCGm2X?=
 =?us-ascii?Q?R9/5ZIhVmBVrT+dyem8eU0iZ3o3f3oYfftU/sTiO6Meyi+eMwyJXgA1MLhXG?=
 =?us-ascii?Q?jjFjoJgVl7/2ycYUSoeBberDAdWHFbjuPwL1ejbSjTJPcwnpLB5cB/wBw7rb?=
 =?us-ascii?Q?ey1ln7yYDmxx2/J8UoRvNJQgM6NmTa/5Yy9BTVFeAUjX7g0FtNEIxOEsO/OF?=
 =?us-ascii?Q?+muI6FjghzJWoOezjk40JgvskgTku03pAaEZEleeMxHtpnNYJWyj+8DQTkOa?=
 =?us-ascii?Q?ItqZqzrupdL6y3ugZdX1uq+CwHJZOui3NK3hhbB/CIcgOhjYX3hYJ1quV1DH?=
 =?us-ascii?Q?DnEm/s9Njy8bd1kiu4OufKWx9LUjMgYLJDj0ulGwdoCJvE8nDkKC5iBSnE13?=
 =?us-ascii?Q?sKjmhEPu8dyx8fCZWpuwVvW8jWjIvXiUr0v5F8ACSeOMSYexkiHg5qbZuIQH?=
 =?us-ascii?Q?A1JdzIjlbWBOo2YN7qJkzf+lo2NQia5lKYJpCJrCHxjk+Jp2N1DamYN+k7tV?=
 =?us-ascii?Q?1XHClsrzTn7c8ukDZm24C+e5SDY/7lbfn/savagZhGo3LIuQtoFYBKzEDakr?=
 =?us-ascii?Q?UI0v0ti/ZdBU5Mg2Qf84zKKt5BbXY6/OlKscJtTAyjYExCzNpdpMruvHaPC0?=
 =?us-ascii?Q?tl9+ZQh7zKoLpCGmOxaGpbu0p/oHthan+dshWTpZQ5KKaEd1pQmSFIX8VS2s?=
 =?us-ascii?Q?bIL4zBhvav1N8ZP6QamUFXfCwH69RrS6B4PGES+Y/0YShdCpyhHTE6/cZvAF?=
 =?us-ascii?Q?sNDhsxYD0dZFGlBUkOldIc8K1BT+2oHi+J48NN7MOLAsmDUlt2a1xeR1Qj8l?=
 =?us-ascii?Q?RZWCstDQ2w+eEcGKY5r8HFJ3f9UtpO1Utz2uoRCBWVPUpieQgD9rb1ISuG/1?=
 =?us-ascii?Q?1WHSSO6AFK2EXT96YqP77jpD?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3e3bb251-df12-44d9-4925-08d92ac60450
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3962.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jun 2021 21:40:21.5066 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZPKaBFrjHOrUAMDNN/pwa9YB26uh3RC3NlD3SKOKt8/wN+0h9Qg6RVGxUnNswrEw
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4435
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
