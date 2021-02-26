Return-Path: <SRS0=SLyk=H4=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63F6EC433E6
	for <amd-gfx@archiver.kernel.org>; Fri, 26 Feb 2021 22:37:55 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1664764ED5
	for <amd-gfx@archiver.kernel.org>; Fri, 26 Feb 2021 22:37:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1664764ED5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AB6ED6E450;
	Fri, 26 Feb 2021 22:37:54 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2049.outbound.protection.outlook.com [40.107.223.49])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 944CB6E456
 for <amd-gfx@lists.freedesktop.org>; Fri, 26 Feb 2021 22:37:53 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MKfSTGjxwld7yNOqWiPCcqLAqhWjtR+pcdD3RyxkdIv3xuPvHMC7k52i0j/f1v3NJRyy3R+NUP9cMgPHRUVVbF2fKnXsddnEp/IaxgFfiXINdXtuDr6t3xKjzzTEovfeLeU4y77Kpsnhm3zFzCRhTvGbJOEvmLunfVJNiKcAovECWDzQUw9LH9qLQNbIgKemBCBFA4Y80Vg1FYtJg0tdd/X6FqYjNQKdreL+RftbSCm7dgB1dUAVaK+2YtqA5SVvd52TkiYxvIVNBMp5HiObGp6KWo6AkPjzF/qusRRPHVGnDCAA5D9TR21xmVRZEG7xjrxFyvojnvjrarFdwfudsw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lhoRru1lGzHC2AS0spuP4i7bzHcjXr1SxhU21K5xx/c=;
 b=j6aok/LUuE5LMfskusJdGnZe3aOhOAlqLrZHwAnNUiLDIglnooeM67QiSLSd+fA5OfLgZyB9fCcUnW5V4mPxx7zWqzyVR6QLKprsfm8675uEWQZ4uMcWl00t9Ll2ZH/x8qLElofZjVnHBKdm9z5EK8zNziTlDkQiExXjcDEfxyYd4eMMPjyf66w0p57ztgVXaLMEET0/h4VpGxeJU5TUzL4XUm/ohUjmXt2uinHyVwKUCwq6Uw/Ob1WfVIrSlFD0V9F6awX7xS5zQoIvIFZKSDe6FrL3SzitSZMPmsH8Cl3nTn7nt3mzQQFeKCQgG0Pq9JLqzLkluLoC95BpV9Rosg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lhoRru1lGzHC2AS0spuP4i7bzHcjXr1SxhU21K5xx/c=;
 b=kQgQGvQ7b0WMtVEfb+6+xASMU4lGNfzty9nIchAfXPKtIvI5u6TOT1njReFGr4Of++M2n+bcJTHbhmdNmcJLbta3KUwCLLenUy9JdIBTToxGm7mPL/vzf5FxQyG6OFRPfstp9Zv8rErX8LTLCv84KE1ZOuwTXIDHjzrcU/BLhkY=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB2601.namprd12.prod.outlook.com (2603:10b6:5:45::27) by
 DM5PR12MB1883.namprd12.prod.outlook.com (2603:10b6:3:113::16) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3890.19; Fri, 26 Feb 2021 22:37:52 +0000
Received: from DM6PR12MB2601.namprd12.prod.outlook.com
 ([fe80::e887:3273:c806:d089]) by DM6PR12MB2601.namprd12.prod.outlook.com
 ([fe80::e887:3273:c806:d089%7]) with mapi id 15.20.3868.033; Fri, 26 Feb 2021
 22:37:52 +0000
From: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 09/11] drm/amd/display: 3.2.125
Date: Fri, 26 Feb 2021 17:37:02 -0500
Message-Id: <20210226223704.400472-10-Rodrigo.Siqueira@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210226223704.400472-1-Rodrigo.Siqueira@amd.com>
References: <20210226223704.400472-1-Rodrigo.Siqueira@amd.com>
X-Originating-IP: [2607:fea8:56e0:6d60:acb7:edb9:ffaa:d7cf]
X-ClientProxiedBy: BN9PR03CA0067.namprd03.prod.outlook.com
 (2603:10b6:408:fc::12) To DM6PR12MB2601.namprd12.prod.outlook.com
 (2603:10b6:5:45::27)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from atma2.hitronhub.home (2607:fea8:56e0:6d60:acb7:edb9:ffaa:d7cf)
 by BN9PR03CA0067.namprd03.prod.outlook.com (2603:10b6:408:fc::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3890.20 via Frontend
 Transport; Fri, 26 Feb 2021 22:37:51 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: d5e66685-f5e6-4eed-60bd-08d8daa726f5
X-MS-TrafficTypeDiagnostic: DM5PR12MB1883:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM5PR12MB1883FA7EDA6E1E0F00EEA2E5989D9@DM5PR12MB1883.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1332;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: JLx8SZUH2w8Gow3I5Gj1KXx8Z26BpamONGajIlIKRNHNkIK7GqeDS1nZ1hWdSxPrW7FflczM+cPNmlVLtF3Ov2bKq2DH6wzfCA2lE4Ydgf5L2Q+R+xgL6exF1mNx9XmNFG5PdIREjwhv5XTP4D1UhZw8FHdtBLwjn0dScpt0wX8L6H0eSGHdWQj24kKz7d2TRlII39lC8pVakFGcZL226QhOlmxK0v/tfGG4jVYhOoWq6oVlir/wnctNa7go2jU3OnLvHT5McFxIByFvsE9hmroUTlPo8cDwoANYT0yhncwtaVlUyPy0FtejjSZJwQ8ZDsL4E02Cv/fJMboN2/9iKQInDaYBKO5UM8WJM8YHfq/FquhnR3GxFdwn6z5f3lpcYuyMEyI/0NXZdhtoNQX8uCryaJmm9T3G54HJ027tOeNrNGgkDZ8LGS7YUIlyH6FDWbDi4Xlfji7kvyA4zSIYkywd4MdOnys1ZIDCA2obzjQHhJbdPoLFgfNna/zTWd/l4s9N1UqXMXLyd+M2vvJ1dQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB2601.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(396003)(376002)(366004)(136003)(346002)(39860400002)(2906002)(4744005)(6916009)(2616005)(5660300002)(66946007)(316002)(16526019)(186003)(1076003)(83380400001)(36756003)(6486002)(478600001)(66556008)(52116002)(4326008)(6506007)(66476007)(6512007)(8936002)(8676002)(6666004)(86362001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?6buDWHYCO5XPzcFKaBKKVnRMfYjOh+8YTeTGwNmgvlCYyEI0Jyto4i5IaCj1?=
 =?us-ascii?Q?oecNyA600TkjwjpTtO373Nq3DJqHFSCrTFBw98GwvPTnK5vFszoa90VVu7Qk?=
 =?us-ascii?Q?U3YSN1+SxGxdu29c7EVh8Bfs4setgMAb2AO0OlEqkEyZBb/LAivZaOqd+ejD?=
 =?us-ascii?Q?YJopKpjBuF0Qi5B6/A4Ll6YAAx5D3ZmSt51Hv5X+azBuQR7le8n+mUNnWz+3?=
 =?us-ascii?Q?HpdXk8Tg0GOL+pfrrVohVNiAINTi7M05VOgWz9PByBvRiUnwoeIW0TOFX/a9?=
 =?us-ascii?Q?VSWBQfFGMe+VkhmCEFmj6TIlh6nfAknzPIjKlQEwkWRwf5dkme/VlQME4ciy?=
 =?us-ascii?Q?K5RLkYjWSC3bLE02MbR50Moi8t9H7urHek/Zb0HE5Li+PAsNNDP5Zgjbg6Hb?=
 =?us-ascii?Q?bv/mL9MfPHci5+DmmyuTZoJxFC4cin18NA7SiA5t/G1/mcN0zxqakNqOm48S?=
 =?us-ascii?Q?ogCGINgU+i/vURJbbvDqGuYH2wD1xf5AvzeP0jl9UXbpbdchLz5SBUhdJyhi?=
 =?us-ascii?Q?0edNLIdtraZ2LRgfoOeyXlKUFDcIgDiEbwN1V5lWJacEA1xH9jSMX9i3Rvxc?=
 =?us-ascii?Q?1mwOl6nWRLftSs/qZZZQM+YItjr7wqwnIsCWnb0+h6IlH0NKT45weRIhjE5W?=
 =?us-ascii?Q?6Toh3pwrJAZmlmAKm5/4yvwiB2798nSUC3m4YSSuGlSjZqLPP1T7lDUgS+jY?=
 =?us-ascii?Q?mlsmyytl0YLO9ktMLn4KUvKRff3MzEEeAq1qG9Fdbza5RDXLatEj+OGJ9y2p?=
 =?us-ascii?Q?VQP1Y+lvFMS7zcL1JesOsoPeSj3PdiB5NL4OLp/ZW+B/3iyIIX5DFHT3NJCp?=
 =?us-ascii?Q?l1lTU6WAKwMEX25IfW2rqJymz1ONRh7Z4hg0DquUV+o8ynkLXdLDMJ2twLbh?=
 =?us-ascii?Q?1rbryutxso5VqUrzQSExaxVvzwDa6M+04ryooGC3QeGz9BrQm96D4mGJs224?=
 =?us-ascii?Q?Ke5ka0Cy9EcfskLIfiwjklW+Fq6ssDdtv4eoUgmAknJW6FM0RfktiXt1eP1J?=
 =?us-ascii?Q?v195Xz3BBRE/RkSbc3FK5P9BOarZ3sAbk6gA3XV84qspvEO8TYfvJMCr9yl+?=
 =?us-ascii?Q?tga4jBfRYC2780Op0DX+w0tsmNDdNjtLJlMZOk6XVHOC5aeq8LVdOl5gYJKd?=
 =?us-ascii?Q?Pa+B8UNfDpsfVQ0wloXt9NZ75/Z5jdxSZuE0fwnyCI2+lAqrho4asJ3Evaro?=
 =?us-ascii?Q?eGaenY8H+F+1rJu8PhBl6rigyDmNgfin8rOFH79aWUzo+qkGL/fznqp82ZsS?=
 =?us-ascii?Q?aBP10X8RBWRDiqfVUqsaIjJ/fEc3hCfamxDw3Rtc9DSdpvRDWqX6RtJdonAl?=
 =?us-ascii?Q?LXSSBIDHEJrYiSxqpAeO79sstOW+QjVMtzubgaDWkEEEsdatTTcXomul7TEk?=
 =?us-ascii?Q?QW0Z8VIoD6QdRaMRz5nWblP4qDSwl6LyYBuxortTyIAK+7zoeA=3D=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d5e66685-f5e6-4eed-60bd-08d8daa726f5
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB2601.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Feb 2021 22:37:52.3532 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DffHpLTACz8+b6SjJ+j4Z+sy7A71726qwiA+OsGZjv8jU5qgMwkZJsUTwX67F9v1bte1CnPJ0JVlgPpnv5B+SQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1883
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
Cc: Aric Cyr <aric.cyr@amd.com>, Eryk.Brol@amd.com, Sunpeng.Li@amd.com,
 Harry.Wentland@amd.com, qingqing.zhuo@amd.com, Rodrigo.Siqueira@amd.com,
 roman.li@amd.com, Anson.Jacob@amd.com, Aurabindo.Pillai@amd.com,
 Bhawanpreet.Lakha@amd.com, bindu.r@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Aric Cyr <aric.cyr@amd.com>

DC version 3.2.125 brings improvements in multiple areas. In summary, we
highlight:

- DSC fixes
- Enable ASSR
- Firmware relase 0.0.54
- eDP interface refactor for multiple eDP

Signed-off-by: Aric Cyr <aric.cyr@amd.com>
Acked-by: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dc.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dc.h b/drivers/gpu/drm/amd/display/dc/dc.h
index 4ada3fe36b2b..3b2b66104a31 100644
--- a/drivers/gpu/drm/amd/display/dc/dc.h
+++ b/drivers/gpu/drm/amd/display/dc/dc.h
@@ -45,7 +45,7 @@
 /* forward declaration */
 struct aux_payload;
 
-#define DC_VER "3.2.124"
+#define DC_VER "3.2.125"
 
 #define MAX_SURFACES 3
 #define MAX_PLANES 6
-- 
2.25.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
