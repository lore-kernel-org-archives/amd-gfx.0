Return-Path: <SRS0=/TO6=LI=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71356C48BE6
	for <amd-gfx@archiver.kernel.org>; Mon, 14 Jun 2021 17:47:52 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3FD3A60FDB
	for <amd-gfx@archiver.kernel.org>; Mon, 14 Jun 2021 17:47:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3FD3A60FDB
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AC4746E159;
	Mon, 14 Jun 2021 17:47:51 +0000 (UTC)
Received: from NAM02-SN1-obe.outbound.protection.outlook.com
 (mail-sn1anam02on2072.outbound.protection.outlook.com [40.107.96.72])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 62E926E150
 for <amd-gfx@lists.freedesktop.org>; Mon, 14 Jun 2021 17:47:50 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gJZAFhEhuHgsisADMsDHcRaNJtsa6TdsmX40M+0l5NUDUzw/CnwkX5f7yGTaNAHsg5CbehwIwk8JdPZg0F7kk0Cmy9FB0IVowfn4E3JrCw0E13RB2XF5ngBfpVwcrdbZwn/Kg4D+pPBN8L7FYwTiYp0q2pBNJsIonCZdL+aBe7yadEmcNKqv7lT1UTikw5eCiYBUAgRXpm1uoTcxP9n6V7v3pdf3TftBstIdIlLiEKsGZWQDTcX1smFr6h1BrT4vkbHsnk+JM4A8an5U5/TeaRHNKoxwGr8TOM7B13QwlzDWl9fiabtt3jLeLhccNgapGe/TaPy7qn3wK0w9NQz9ew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RlMi+Sol6U0JpP27Bgw5pmoaCRMrJHWIQZSwN1FnY7k=;
 b=bRmFemiISMXOZlOxTy6DIDn5c+6H0MbjRVzhMc8bJFLRLG6DBtVZ8UG8G200C3p2Rpi0+LDrSipnqt4gaYhFkboa9Sb57bNeMotVyt9OyGeud1GPbjHjm90+KYNKpFJ1qn4K9b0jnIq1eLMYDUOonbt3ojOat8DTWUnnc9Raf/HMigXFdWAjd4UPXUSz3/TF5VgsabKq1i/cCLrPoTnlMbY3yiCf4svkq+/3FdVonJMUWzRuzPHHm5LolTblJ6IU/skO5ubdjQGr/hSpEyVB7DBfXyECq5S6Po6cgRYz+JLA2l9H7eXDbw0c6UEVbLQ8D+7VoJnq5NJQAIlAnw3NOA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RlMi+Sol6U0JpP27Bgw5pmoaCRMrJHWIQZSwN1FnY7k=;
 b=OKixLpy2zWiuWYeH/KBj34zclMKBmyHATbvdthulKNuA08eER9U4XR/OL/6/C4TcUnEt8aMnw9MgfsTzqCxoIN4B4JPoupQ9YOXRj+jgTPRbpkKuuNvg5g5fyOydznl2vUyR10HhsOitZaMr0GH1Y2X/qs4O+VltDTZJbbi3iZA=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB3962.namprd12.prod.outlook.com (2603:10b6:5:1ce::21)
 by DM6PR12MB4355.namprd12.prod.outlook.com (2603:10b6:5:2a3::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4219.25; Mon, 14 Jun
 2021 17:47:49 +0000
Received: from DM6PR12MB3962.namprd12.prod.outlook.com
 ([fe80::142:82e3:7e9d:55a0]) by DM6PR12MB3962.namprd12.prod.outlook.com
 ([fe80::142:82e3:7e9d:55a0%6]) with mapi id 15.20.4219.025; Mon, 14 Jun 2021
 17:47:48 +0000
From: Luben Tuikov <luben.tuikov@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 38/40] drm/amdgpu: Fix koops when accessing RAS EEPROM
Date: Mon, 14 Jun 2021 13:46:30 -0400
Message-Id: <20210614174632.20818-39-luben.tuikov@amd.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210614174632.20818-1-luben.tuikov@amd.com>
References: <20210614174632.20818-1-luben.tuikov@amd.com>
X-Originating-IP: [108.162.138.69]
X-ClientProxiedBy: YTXPR0101CA0019.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b00::32) To DM6PR12MB3962.namprd12.prod.outlook.com
 (2603:10b6:5:1ce::21)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost.localdomain (108.162.138.69) by
 YTXPR0101CA0019.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b00::32) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4219.21 via Frontend Transport; Mon, 14 Jun 2021 17:47:18 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 9b7b5ca3-09e6-4add-91e8-08d92f5c74b8
X-MS-TrafficTypeDiagnostic: DM6PR12MB4355:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR12MB4355649A1590C6992E2812AC99319@DM6PR12MB4355.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2150;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: G/syIzwh+Qi/ysjKJ89o5hW2ymAJGmCOi3jDQ4ORDZnvjO2FFR89sTih5ptGxL0r1Pd1q/8UHRJ2xhMPvHCQo8g1Cdgn6gEONmxIiYrs20p2Ay+e4HmFoS3iQAOt67zk56NgY0PaC70QSsyaoc/KpRxcMe31olAfgybKICg0XLuszSlm35++yUD7oIiNTQ0XOhrhIBHyH8bvP9xzHZ8qt7JQ8TnPWV0IwpvrdUbGmLNmLabqxzI7e4tkdoXL+/zHP8bY5G7MKy7+nVB+celvGbTUa2JniQzaZeL/9UKd7QYSo4tC7+xwpB+uC4TqHiraoE2oX8pnkImvr1wcqjZd00N6jclu9dBWo8H3xEDvUMkouR01qp3D4NtzJNm8tMn3MNwbyi/ctt74ze+tiBmeddGqwG952o3ziLXIgw1YQe1rtiVSWFfHrNdworskKwS/z57KzJzrEN2Jue2Fkz3ZXaAmFv/9D3Dv962V4+8IwDzGSwQKwOdRMwXtUWB/AUadwIEwfambGU/12uml8tqiovJ/HDZSQv5Ylvt9MCubWir9GF0h/XpPBIM6mVskdNeXHI6juC43HgCQ4oKWSpPAxqm8/BfWODsxemgTbBipWtxe0QdBItaX45x25CQGhI1dD95iNY6VzRZMr06pgyMEzdiWzVJ929tWwaBo3kJPsAsKCqS0Wql1OGxyeNjMfn7g
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB3962.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(346002)(366004)(136003)(376002)(39860400002)(396003)(36756003)(83380400001)(86362001)(38350700002)(16526019)(38100700002)(478600001)(8936002)(5660300002)(4326008)(956004)(6512007)(66556008)(66476007)(66946007)(8676002)(316002)(44832011)(54906003)(2616005)(6506007)(2906002)(55236004)(6916009)(6486002)(186003)(1076003)(52116002)(26005)(6666004)(69590400013);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?N311W2t6S2AzWWwzD5oHDwMUNX3Y8rirJg2ioCEqVc028X4YXJLODAAlCnRx?=
 =?us-ascii?Q?pctTIooPVMQvI1qJLtF7hj06/9xoMSbPMz5wBXR0PmdwLXE4bP2wcer82MP/?=
 =?us-ascii?Q?XRa7XGyF9v5kKxCT4DkLhDQjBaur1HhIK5lVnY6bPqdw5cgaCvqdqLq7ugJw?=
 =?us-ascii?Q?LkLovzZb9oB7nZUcXKIhhGdtKLCtM5GQDpnhp+U69Nhjv+N7ZWv5J9FuGEIy?=
 =?us-ascii?Q?22/zaWW2/GIyH6bz5L/S2jqP4KQlygzrQeSyE0xGhMOjIhUDAiS1WDeCy40C?=
 =?us-ascii?Q?zYdr1UrkLpWD7srNxButhvKxpXhxSbejM6hZ0EWoA4NrWZo0FHLY51ISRpY7?=
 =?us-ascii?Q?TMGXDPvsJCUDiDuFT9Daskm77y7PM+nhb+b0Om9kR130IBbw/lxkag7ZF5Kv?=
 =?us-ascii?Q?fJgyo3TTEgByCYtKjkZ1qP0sLRhzk7FRaMhgn+aPwmftYMtHZxlIZoUKQC3p?=
 =?us-ascii?Q?p5RD2q2g2Nks3cWWqdYGJhrPWggymYHLw4O8QiVN0C9HQEOAQ6c8pQhWPz+9?=
 =?us-ascii?Q?XbizJd8zR09lV71eKvu29rHVn/JDeq8JgKYigZ8ePsw8mQ54g2pHm7B0aDfn?=
 =?us-ascii?Q?rqVXX2QzvcU3GQLUk40OGl5MQytYbmwunrBD2UTUJ90nJbWkDqKCmIzNjysj?=
 =?us-ascii?Q?foueQKvSZK+Cl+N9HC5yHktyC0V+Ria3v3o9U0+nBbvqx0/QvxZ/vu3jna2g?=
 =?us-ascii?Q?60uy3diUUaLj5vScNZbVpWIlohW3ygzkrLLRKBqS34Ye1UfTkEYHnLcsYB5r?=
 =?us-ascii?Q?OZqZNaqpoPfT4kMijXgNy22/IP9pq4npvBLwN8IEAa30KwnFIgDkS/tlyhGC?=
 =?us-ascii?Q?G6bFWN7DIKRrQm8T9ZmrQbXHcI4KCdSdS7V6cnJxcusOQQsYiUlhTQ2ls7L2?=
 =?us-ascii?Q?2XP9qSuqfXAYboTTTd4oN/Cm9alfFMwWhzU9y2NI3rqmHElQGIzJJdYp/1u3?=
 =?us-ascii?Q?dePZ7e7LN+bv/JQm1ltnCzys2022feAari1OVJcizho5bbXKRShvYgjIsYih?=
 =?us-ascii?Q?U022VL3b3Zj2R3Y9Ge/S7TMuKzezUlUbjdYJcJng5aGhmvNgC3oZEtwpPcyM?=
 =?us-ascii?Q?tJi7VmXXD7YYGHVXKoq88egE66R+nrm7rOlPJ3393xAtJJsuDoOv8WTRyPnZ?=
 =?us-ascii?Q?DK18+gUmIUeEbQXwc1TTKNiPev+MXCeRz5kQsJWMztYAnOE1t+ZOr7FIb6Vi?=
 =?us-ascii?Q?zhfOSlSN1gHT29ECd9I41AnZOxrGs1T2uRfScGynUhLeIkzGMKLETjvHYZwe?=
 =?us-ascii?Q?ecGy+lKHdHwCEN8tXUK3pEF+PL/v7nWjjSEKkSEPJuGXEheU4ipHh+79mUvA?=
 =?us-ascii?Q?W9eub92MbgCG7x8BXjVzy2lx?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9b7b5ca3-09e6-4add-91e8-08d92f5c74b8
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3962.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jun 2021 17:47:19.2405 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: u3akf8tpOnBH7Xn7e/A/tjBDWMSsZuhxiRE2LWbXkhuxs7BEB+zZBFKDGdChOsLm
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4355
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

Debugfs RAS EEPROM files are available when
the ASIC supports RAS, and when the debugfs is
enabled, an also when "ras_enable" module
parameter is set to 0. However in this case,
we get a kernel oops when accessing some of
the "ras_..." controls in debugfs. The reason
for this is that struct amdgpu_ras::adev is
unset. This commit sets it, thus enabling access
to those facilities. Note that this facilitates
EEPROM access and not necessarily RAS features or
functionality.

Cc: Alexander Deucher <Alexander.Deucher@amd.com>
Cc: John Clements <john.clements@amd.com>
Cc: Hawking Zhang <Hawking.Zhang@amd.com>
Signed-off-by: Luben Tuikov <luben.tuikov@amd.com>
Acked-by: Alexander Deucher <Alexander.Deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c | 16 ++++++++++++----
 1 file changed, 12 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
index 28378c7e729608..384031ec82f4f8 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
@@ -1947,11 +1947,20 @@ int amdgpu_ras_recovery_init(struct amdgpu_device *adev)
 	bool exc_err_limit = false;
 	int ret;
 
-	if (adev->ras_enabled && con)
-		data = &con->eh_data;
-	else
+	if (!con)
+		return 0;
+
+	/* Allow access to RAS EEPROM via debugfs, when the ASIC
+	 * supports RAS and debugfs is enabled, but when
+	 * adev->ras_enabled is unset, i.e. when "ras_enable"
+	 * module parameter is set to 0.
+	 */
+	con->adev = adev;
+
+	if (!adev->ras_enabled)
 		return 0;
 
+	data = &con->eh_data;
 	*data = kmalloc(sizeof(**data), GFP_KERNEL | __GFP_ZERO);
 	if (!*data) {
 		ret = -ENOMEM;
@@ -1961,7 +1970,6 @@ int amdgpu_ras_recovery_init(struct amdgpu_device *adev)
 	mutex_init(&con->recovery_lock);
 	INIT_WORK(&con->recovery_work, amdgpu_ras_do_recovery);
 	atomic_set(&con->in_recovery, 0);
-	con->adev = adev;
 
 	max_eeprom_records_count = amdgpu_ras_eeprom_max_record_count();
 	amdgpu_ras_validate_threshold(adev, max_eeprom_records_count);
-- 
2.32.0

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
