Return-Path: <SRS0=8BU1=C7=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41CDDC4346E
	for <amd-gfx@archiver.kernel.org>; Tue, 22 Sep 2020 03:02:55 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B77BA239D4
	for <amd-gfx@archiver.kernel.org>; Tue, 22 Sep 2020 03:02:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="NREEUnbB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B77BA239D4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 319DF6E5D5;
	Tue, 22 Sep 2020 03:02:54 +0000 (UTC)
Received: from NAM04-BN3-obe.outbound.protection.outlook.com
 (mail-eopbgr680079.outbound.protection.outlook.com [40.107.68.79])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5836D6E5D5
 for <amd-gfx@lists.freedesktop.org>; Tue, 22 Sep 2020 03:02:52 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=agfHYEQ9qeH2NngFwQXIoehAeWY3mMfzwuZOrA9nvyhoVlVDOoOJDa18ruAiITonA8DEeVVenBdcsmWEMJtRF4ScSPXoM8jeMgb19UBlkUZ1yjIB78Nds0sNLkcJ5W1ZRQGjU2Xhyd7CnI1BpTpLgQkYHghX+UFX4KZ8ZVMBpCDfNhtrC7j76LbOyYgXGdAoDGLC8d92x5RAZZsG3AXExcJUG8R+Zulr8xqVNm3ZyQCJukMmj1znh4ZOET0uMuU8iBNDOE6voMIpbo3m997iLIzOhoqxhIV5/b6uW0KTsCNP+I+n3oJTd3//JMVqxbNvHkhWoXJl0dibw3dRPGNNvA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7Q0wLie0+2Ds/xCe1E9eAw+8abNcvIt+Fmvx5v5v3qA=;
 b=gv0voKpTVHR/S2PbDPWym4T3XPKev/VH1ywR+C5Zgblt+rU7c4u/vTyFmzwR+cd5dgLnwG4UH6QmWSJTx+6JG+KrbcwCfSGf45GgTtWnq97YKdpHEU1NUIUJc7y/iwKrlJjBYHu6TRzzPdeoYIJ+C5hdu8Rijmxw2zBEVXIw6dItjlU+VnnZsTkLEfwrWGUtsbsLW300JkCVJxCOHh0PP9zMzf7KrOefxAMxco64N8e6FzTf1pt0t3S966ATnx+8q2xpMwE6o/p1uNeasEQnlTYH/TL8YK+ra1WNHT2igo4P+IxVFTOSgyOAoVbWOeYGJsMDHXxWVALOoSoFtYJJYg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7Q0wLie0+2Ds/xCe1E9eAw+8abNcvIt+Fmvx5v5v3qA=;
 b=NREEUnbB6lQM9GcuUuPf6cXJVbWlb3CT/99VVlOSA0G75lFtvY/yzR/5Lc2aRKIBwOhVwanqDRYGe2Gs3HA1BmRFGsM5VmMycCkjlYtoWUEGXrnd1oejRPUKXDWEoZlhzlW4scB/5imMdKipgiJqXIHWqho1wdTf2obHqeQaXPM=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from MW2PR12MB2586.namprd12.prod.outlook.com (2603:10b6:907:11::21)
 by MW2PR12MB2394.namprd12.prod.outlook.com (2603:10b6:907:f::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3391.15; Tue, 22 Sep
 2020 03:02:50 +0000
Received: from MW2PR12MB2586.namprd12.prod.outlook.com
 ([fe80::cc6c:f743:c8fa:953c]) by MW2PR12MB2586.namprd12.prod.outlook.com
 ([fe80::cc6c:f743:c8fa:953c%3]) with mapi id 15.20.3391.024; Tue, 22 Sep 2020
 03:02:50 +0000
From: Xiaojie Yuan <xiaojie.yuan@amd.com>
To: amd-gfx@lists.freedesktop.org,
	tom.stdenis@amd.com
Subject: [PATCH umr] Fix register name lookup for sdma POLL_REGMEM packet
Date: Tue, 22 Sep 2020 11:02:24 +0800
Message-Id: <20200922030224.22239-1-xiaojie.yuan@amd.com>
X-Mailer: git-send-email 2.20.1
X-ClientProxiedBy: HK2PR02CA0184.apcprd02.prod.outlook.com
 (2603:1096:201:21::20) To MW2PR12MB2586.namprd12.prod.outlook.com
 (2603:10b6:907:11::21)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from c0.amd.com (58.247.170.242) by
 HK2PR02CA0184.apcprd02.prod.outlook.com (2603:1096:201:21::20) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3391.11 via Frontend Transport; Tue, 22 Sep 2020 03:02:48 +0000
X-Mailer: git-send-email 2.20.1
X-Originating-IP: [58.247.170.242]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: d05f708c-3001-4eaa-648f-08d85ea3fd60
X-MS-TrafficTypeDiagnostic: MW2PR12MB2394:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MW2PR12MB23946AA0E8CE68F378FE047A893B0@MW2PR12MB2394.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:175;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: TdSv+NuWOMgOI40+QENgQUUEIgHOSp7k74t1ZnpQK4FhGSbJMUBNaCiGVX4KJQkBqdi5HwCYwqAcMgp1hU1rO1/nulPtrIq4aYH9jTCeAZEUpaCUafQ0lC2VbmCHfEFW7FjvysZH62XJCKyjlXCSf7TOMzLGzlJQ1NVuG/EMTEvpatqQLUj63u1wIAj9hdDa3iowTBxYLv03P2u2HGYqB6Sn1kNDuO/iHxGiQksfepvBeAjBtRfh/iPc2T/LGtaPyl1DuBwqQ2pzjgdTheuSHsHDvrj+HchZqasMNFWnnwxW6zBZJRV/NtF7NQ4fhVDc2kSEWsOO1et1WtjiBPRKFQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MW2PR12MB2586.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(346002)(136003)(39860400002)(376002)(396003)(366004)(478600001)(16526019)(2616005)(186003)(956004)(7696005)(4326008)(8936002)(52116002)(44832011)(6666004)(8676002)(2906002)(83380400001)(36756003)(316002)(66946007)(66556008)(66476007)(6636002)(26005)(5660300002)(86362001)(6486002)(1076003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: 5anqb3SNLZDG6kwx40HaYbwXIjCz5X2kwgicVAHc1Kl+IU+NyQs4lnnlgD+EqaxmQgwemW0yeB3k4/DrMFVtbLBJ8DMIw4Xk0JACMUQEMgmLVrH1bYCzkdtOCL/C/vgv0yplWoye7shtAae1q/xuRaH/FxW839Xd1m0002kh0CXz/XkRtBibXFdSF9MDYUuQYX0vuti+npM2H2cZ0EB81b7ZpuKpLMvMhS1z0ZDRaE2fQCaJnVAD3B/3eY3fYL2/tsvUJ65TPaoZTjCbdxzE65qDG096jbaRBlZT9FWC2sn6dxnQRUZLzrBFsE0hKfLQ+becCB0Xht2/j2fQ6ajb4OPONfUz3VlU62caqCaL4q6QQ5Ay2ciOJPHknNSRVl9mvQh/cOQvtbWPMwHCMCzR29mMOvGq5jKHBIZ2EWcnaCYNgMRTPlYVs2gexXpjw5U5F7kzPSGr0itnvS/O8lH/PtIRzJjvWdBgAe/qefSvo+s77kbRCVyqj6Vntyy2EuvmPfZ9gkLFDZ67DCBlrmcsLXoT9o14zCTQ9l6duLSQHfZhg6vQk0keK0g9q0L1pnnllC1+gCEuz9EnVmWl6iZnvEnR+2Imj6zdDzYUki9QEmsF4bKvQZ1ksvLATl8KpWcSyG8c41UY3C2FE2d4HMqwog==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d05f708c-3001-4eaa-648f-08d85ea3fd60
X-MS-Exchange-CrossTenant-AuthSource: MW2PR12MB2586.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Sep 2020 03:02:50.0835 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5UYxZO1c75bv3sj2ZiMIy1z/dPayKya6xrrSdoHRZbWcfVyKuttTQltV0SpXyupS
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW2PR12MB2394
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
Cc: Xiaojie Yuan <xiaojie.yuan@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

POLL_REGMEM_ADDR_LO/HI are in byte but umr_reg_name() expects register address in dword

Signed-off-by: Xiaojie Yuan <xiaojie.yuan@amd.com>
---
 src/lib/ring_decode.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/src/lib/ring_decode.c b/src/lib/ring_decode.c
index a74229d..b5838d1 100644
--- a/src/lib/ring_decode.c
+++ b/src/lib/ring_decode.c
@@ -1904,10 +1904,10 @@ static void parse_next_sdma_pkt(struct umr_asic *asic, struct umr_ring_decoder *
 				case 0: // WAIT_REG_MEM
 					switch (decoder->sdma.cur_word) {
 						case 1: printf("POLL_REGMEM_ADDR_LO: %s0x%08lx%s", YELLOW, (unsigned long)ib, RST);
-							if (!(decoder->sdma.header_dw & (1UL << 31))) printf("(%s)", umr_reg_name(asic, ib));
+							if (!(decoder->sdma.header_dw & (1UL << 31))) printf("(%s)", umr_reg_name(asic, ib >> 2));
 							break;
 						case 2: printf("POLL_REGMEM_ADDR_HI: %s0x%08lx%s", YELLOW, (unsigned long)ib, RST);
-							if (!(decoder->sdma.header_dw & (1UL << 31))) printf("(%s)", umr_reg_name(asic, ib));
+							if (!(decoder->sdma.header_dw & (1UL << 31))) printf("(%s)", umr_reg_name(asic, ib >> 2));
 							break;
 						case 3: printf("POLL_REGMEM_ADDR_VALUE: %s0x%08lx%s", BLUE, (unsigned long)ib, RST);
 							break;
-- 
2.20.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
