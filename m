Return-Path: <SRS0=uqaI=KB=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E11BC433ED
	for <amd-gfx@archiver.kernel.org>; Thu,  6 May 2021 00:11:01 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AA2EC61077
	for <amd-gfx@archiver.kernel.org>; Thu,  6 May 2021 00:11:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AA2EC61077
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4F6316EC85;
	Thu,  6 May 2021 00:11:00 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2050.outbound.protection.outlook.com [40.107.92.50])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EE66D6EC84
 for <amd-gfx@lists.freedesktop.org>; Thu,  6 May 2021 00:10:58 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HrrtBy2F1vGv3Kf8aoA2ZO003sRw6fTWtLFrgSV8/f7LdtrdOE8xRe4TrI1zI+JGcj0EewrU+wejiNOeVGj9S/Wj2GIvJMUDXz2eluA69BGiK9a7osWNlL6jJMS7vkymVvplE+fgS8y1Z9CwUDRnnWPHWLav7bGrRYWakaN4/kXDM12QYZJbKiyOA6rT4cHg4n7BlcCIH95+xvpLGG0wS4kbEvdbjJfySPBujytL0vvdf4Uo6h0ehqRcnqtLH6MxcEknDZG9cO+2ivmNk/BIJRRzV7b+AY9psb6Eb6+IUevreBwa0Ou300lUfWWutQWJDu2nmYO6LQEyc/DcR/gsAA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2eYgS4SL5YMn52rSafXUcPyRR7Rtc3cROYqZypAJz2g=;
 b=cgaUfQcHPg5lLW274WAyWqW5nD71yxjRfborC8MpZ84TqTMieQv/KBZdURyWGgcHQyy0pCI8o3lu9u3kd6lNei2s2PR8x3I7N2NIuqc6CkIcvmz3FIgsdxUj3pHLflnFg3v0wxCg0YGAZta55cmJ/RmwfqwYSPQlSqprnQIR/4MASpbSk0AryzZZo5gcejF9WcT83OvwhKq1fMaW/rMW9LlwNusB3CEG4/cndOVmSU+27hwlAW98YK3Pu81luI44OEOJ9jwBL6QfexLkloyEaWPcg0DeZ6+TPOxzq5LgGQHK0rhKfsD3BL4cidT70d+O/bczkdlTKfWY70L6yHEgeA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2eYgS4SL5YMn52rSafXUcPyRR7Rtc3cROYqZypAJz2g=;
 b=LOX/5QRWoDOdvaIoxvMdruhOOGHrtnNw6VN9AlCDaIbLgxcbNwN830bHx+/cjY8PbYJPNXON4NOhnyugkNNwqnxzYfygYPM3Tq7PzgQetcUZCXUmHkXbc+MSBDyZ1t45qMfwAGo9DpHdqa6KlM5pyfSVZOpQrPhi2LnOFTeRZ90=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB3962.namprd12.prod.outlook.com (2603:10b6:5:1ce::21)
 by DM6PR12MB2892.namprd12.prod.outlook.com (2603:10b6:5:182::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4087.43; Thu, 6 May
 2021 00:10:56 +0000
Received: from DM6PR12MB3962.namprd12.prod.outlook.com
 ([fe80::142:82e3:7e9d:55a0]) by DM6PR12MB3962.namprd12.prod.outlook.com
 ([fe80::142:82e3:7e9d:55a0%6]) with mapi id 15.20.4108.026; Thu, 6 May 2021
 00:10:56 +0000
From: Luben Tuikov <luben.tuikov@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 0/1] Fix the slowdown for Vega 20 server boards
Date: Wed,  5 May 2021 20:10:37 -0400
Message-Id: <20210506001038.15150-1-luben.tuikov@amd.com>
X-Mailer: git-send-email 2.31.0.97.g1424303384
X-Originating-IP: [108.162.138.69]
X-ClientProxiedBy: YTBPR01CA0036.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:14::49) To DM6PR12MB3962.namprd12.prod.outlook.com
 (2603:10b6:5:1ce::21)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost.localdomain (108.162.138.69) by
 YTBPR01CA0036.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:14::49) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4087.39 via Frontend Transport; Thu, 6 May 2021 00:10:55 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: caf49d4d-a093-4c9c-d8e0-08d910236b7b
X-MS-TrafficTypeDiagnostic: DM6PR12MB2892:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR12MB2892C3B98F72F07300290F8B99589@DM6PR12MB2892.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5516;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: fSqfoCWSFJL2mVI7uXPNrIa6JOnwNtVjYkiAVFdA0yhPhiK7YOCOwoKjOiVNfvqicdSYqmo5FfapsBzTM7FSt4NQOWXQLiadlS9nJzwqVt9OGImle/kukA4IqZ0/9Er5ktL+DwqoLjx8tHuBAeGBmyEGpe95Fn0kGGA5hRANZ8KaFR8FdbkaUPlGBqzBEYLVbB0oHRNnBchLj4LWTfdZxx0YYrq4NfPshdugrGIqyxCsXXIckiX6VmU+XXXX4sBjVmApCLEFjF0MWeYLkkBTeXclhxLm6R0NzBh+9jOggkTBW8HHfUea+4u4TB4B5dmJMbJzs12XB7c7Bn3r+zNCYYDUvCZenQd/mHE1RjzRARPLn+f+MXCn4dA3iryTMZSK7spVK/a8pHqXPXQBp3n+tgtMGRLV4ioZFfBtguKiCvIee85gVP8JDiSaEgwZaeADipmMnZWch82j/zw5dQRDCnGJwfq04VU+2inPmHFEJB2c1M1uffCOO3u//7i45cPELO2Q4btH0AtqFFrIQYBqBLIPqKgPRcOnR5C98yKLOnBAO6BieoSI+Ec7hmGacoYp3yFg8DRl3Ld0RC71TU5EHt/kKIOE7sMiiPIPMDAeUxSIWs982yPSS76Hq/YZh/nkX5MQspJmz07TU9QzvBS9/6D7guk5ZKUzQoCgFVADfSipMMEtkALe2eiz1p+FTqOm
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB3962.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(396003)(366004)(346002)(136003)(376002)(39860400002)(66556008)(66476007)(26005)(38100700002)(6486002)(83380400001)(8936002)(5660300002)(6506007)(66946007)(186003)(2616005)(16526019)(55236004)(52116002)(956004)(8676002)(38350700002)(86362001)(4326008)(4744005)(1076003)(2906002)(44832011)(36756003)(6512007)(6916009)(6666004)(316002)(54906003)(478600001)(69590400013);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?B5obkBi5ijiEuUaaRakjFYJ6q9H2nHZDS+qi3+hJMTeduA+0CnkBHHEf3wkS?=
 =?us-ascii?Q?8rIAoN11QfFlHnsCGQlYn6ebXhqVljFL0vgxtdUdHNjs9g/J1yZRIWlJYg8f?=
 =?us-ascii?Q?IStYAxgc1Po2Dj9DI/yAxsEy+cMpmWe6+OWlGsHLW5JZQpKb30oVrYzqWtj/?=
 =?us-ascii?Q?iJUmwGqowla7coQasJGg/YVfAHF5mm/yHY6QREeLD7YM7yHjZuWPo0eeEn0h?=
 =?us-ascii?Q?+/KPuGW6huBv7hcmxXXCzjZpX+sD8Vrl3ZfoyeuTRrzhutWd72IwGnCAgK1/?=
 =?us-ascii?Q?PM3YiFNM3ZdCMs3ltihQrF2Jy8g0DHPlYi/uJoAzPF5OfV+E2aknGW8/wkJ7?=
 =?us-ascii?Q?Upu+uMQOACVPlw/QxdxV25+wW3qnHPXm+rIB51XHVAZ6KPaTEOsU0OLWAsjI?=
 =?us-ascii?Q?noAtkxJLKY/o0Bk+yLmam98SVyYdSnLyf2/QwRH4i5hruJUm4sU8nWHMO32Z?=
 =?us-ascii?Q?GfOXZdfhyyjkX3n4GS0cX8KDwTDqY2zg8zoYkAVArtO3iDvK9z8zkCFyPY9K?=
 =?us-ascii?Q?dorwwRh3qFcOAzngvh1wFJhcYnvJhpx8+w/ob667kHedoWn2z0eTlyhDZ8ut?=
 =?us-ascii?Q?8u4vzKwJXSFgYubHFhzIZKZxgi9/sUj7ipYMWjWFni5q2/fCow7sSkWzFr0m?=
 =?us-ascii?Q?yBRNjid9PtczPkOMJ5whzQH/tKky9AMNYCMqykmDbBNsKXZJvyxcO0XaQGYS?=
 =?us-ascii?Q?aW64ZfolhE/+N8weH0qk74Ho9LDMMGia/PrkNBm8SPmvXAKXI/Uygvkxfs3o?=
 =?us-ascii?Q?GpHBkNfAnbOU89RT/9gF9c4SXS4rdGqIv4Vy9k3WiYfvS/kp1Tv487/dXY3W?=
 =?us-ascii?Q?g7DDPG43VfUUuUSo1V86AOgYz3h4v0gmjRznt+1yTVKxZYxCV7XIcrltGHJ7?=
 =?us-ascii?Q?zRbs3kbPr/HecUpFwB7eWWQiSqX9bmFC+Zwwd+j6uSrqZeOEkLDANr5GLAO1?=
 =?us-ascii?Q?70pKXAzMSOGVl95vdbcverGUzf2u4iX7zrRL9Ia/g7mZFzZ96kUQ5E/IRv/V?=
 =?us-ascii?Q?+skFInHcs3cZx+tcCoijXuS3uoIe7ewJ9anxuiM8VL/imPm6TW97KS5sVPOS?=
 =?us-ascii?Q?hK6qMsj1ZwbeERlNAXqaPSKd3LGOA7d1DixBCU28oSWbtPJGwUy4k0cNIWCQ?=
 =?us-ascii?Q?HsJbh+Y0giumM/w3Y6XuZdM1RJRS4wec8jJLBX+s05h1sPEaI87/wIFycySY?=
 =?us-ascii?Q?w6jl1SszDFGGBLHRlGBHNyJFVches8S/b8FdpeOzL5eAnE4JnAaurooPfibA?=
 =?us-ascii?Q?8AXS0l/9wiFWi80P54TovigqABN6fsT1J9qH1JthBxXs53FRaXhm3NEHdrUe?=
 =?us-ascii?Q?POqfTlK2D+C19gNaBNV3gW/W?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: caf49d4d-a093-4c9c-d8e0-08d910236b7b
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3962.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 May 2021 00:10:56.5562 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: R7gof6KOymQLzygDj+hsHWSpD3AiTao/HHEWMAAu8qCVw9Ru6ZEEFhSLt5FNngcz
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB2892
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
Cc: Alexander Deucher <Alexander.Deucher@amd.com>,
 Luben Tuikov <luben.tuikov@amd.com>, John Clements <john.clements@amd.com>,
 Hawking Zhang <Hawking.Zhang@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

This patch fixes the interactive--to the point of
unusability--slowdown when RAS is enabled on Vega 20 server
boards--which support full RAS.

Luben Tuikov (1):
  drm/amdgpu: Poll of RAS errors asynchronously

 drivers/gpu/drm/amd/amdgpu/amdgpu.h     |  1 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c | 32 +++++++------
 drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c |  9 ++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c | 61 +++++++++++++++++++++----
 drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h |  8 ++--
 5 files changed, 85 insertions(+), 26 deletions(-)

Cc: Alexander Deucher <Alexander.Deucher@amd.com>
Cc: John Clements <john.clements@amd.com>
Cc: Hawking Zhang <Hawking.Zhang@amd.com>

-- 
2.31.0.97.g1424303384

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
