Return-Path: <SRS0=w1A1=LX=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28EBFC11F67
	for <amd-gfx@archiver.kernel.org>; Tue, 29 Jun 2021 19:52:59 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E57D461DA2
	for <amd-gfx@archiver.kernel.org>; Tue, 29 Jun 2021 19:52:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E57D461DA2
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9F52C89D46;
	Tue, 29 Jun 2021 19:52:58 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2077.outbound.protection.outlook.com [40.107.93.77])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5631E89D53
 for <amd-gfx@lists.freedesktop.org>; Tue, 29 Jun 2021 19:52:57 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bLOPJM8ffruYGC7TH7qEYtc3fgFEyCK8X6PK7xTIzVHcEIeJh0YF84vhW4KMKYGdB9+eQ2F7kE/uTFbcK2ohI1SpbDrVGKzzns24i2FpzlTRb95XCUqrasIfeklkPmUaA3rzVjrooNO/5MEx9vnc6vGylBhi7UMB3tCe2f2uLna6obqFyVTxXR5eWIjn/YK9dbx/TxvcM7MpD94Zteo7/EGbVgWMa+6Zx9TVV3LNKBvzU7GzEHyLyaEy0SqsbHQ6C2YXY3aJlvmsz29rfcHeZB+1reQ4GQ1wjbDr2g5O1KpTZlb34ZN/wKbY7RJPDAOAJ0UWoueh4pd9Xhrd72tusg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Nf0wS2rbRZW1vBXqOHrAv/VcY5yjLxwxgKDY9tEe89I=;
 b=TsRZDAHKx5UfgsYegkMwDUaioktcmiZ5kbOL72mIZaAnRlVWkR4c7fQOI0n/QhhYFyMBwid0DemYH/1IAiAbWYfplUiBcHbd29ZuC0N5MshMz9kuSGA2LnOWSWdJTQTe8fXjMAnQ7oF1CWmqeFQGw9aY/35Ylel9iiH+og4GfjoVFHYDbBHGKHRJ0adUec8cy1dGPRX5zqJ6eao4L+9XK2Jg+ugzDSMXwqlIXj03L7CuxHaPHPt9tJ36SYYDhrEVu2A8vtw85XvPIJKjYTPJTQZw70h39Nl0UK1ysLwsV4yq1UMNrW89kX7qENy4EFShR2n9/zvVda/OPDEXLCMx2Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Nf0wS2rbRZW1vBXqOHrAv/VcY5yjLxwxgKDY9tEe89I=;
 b=z7XZeMnXmoxjUoa1o3KhKaIajuLyhDILIs8V1XU9khd76kWvnUx3uMdpNIcOS1nOwkaR1QC/EfNzgcy+f8yop4BUtlB5WmG7mWxaWObwv6SWXukD+olta4XhWuZ/T8K5RlxXU8nKYp+c/Se+3jJoaOWJVOf5XcPITVGNSu4FsKM=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from BL1PR12MB5144.namprd12.prod.outlook.com (2603:10b6:208:316::6)
 by BL1PR12MB5272.namprd12.prod.outlook.com (2603:10b6:208:319::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4264.19; Tue, 29 Jun
 2021 19:52:55 +0000
Received: from BL1PR12MB5144.namprd12.prod.outlook.com
 ([fe80::8cb6:59d6:24d0:4dc3]) by BL1PR12MB5144.namprd12.prod.outlook.com
 ([fe80::8cb6:59d6:24d0:4dc3%7]) with mapi id 15.20.4287.022; Tue, 29 Jun 2021
 19:52:55 +0000
From: Alex Deucher <alexander.deucher@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH] drm/amdgpu: add new dimgrey cavefish DID
Date: Tue, 29 Jun 2021 15:52:36 -0400
Message-Id: <20210629195236.326722-1-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.31.1
X-Originating-IP: [192.161.79.198]
X-ClientProxiedBy: BLAPR03CA0122.namprd03.prod.outlook.com
 (2603:10b6:208:32e::7) To BL1PR12MB5144.namprd12.prod.outlook.com
 (2603:10b6:208:316::6)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost.localdomain (192.161.79.198) by
 BLAPR03CA0122.namprd03.prod.outlook.com (2603:10b6:208:32e::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4287.22 via Frontend Transport; Tue, 29 Jun 2021 19:52:54 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e67fe395-5b89-426b-bad2-08d93b377c97
X-MS-TrafficTypeDiagnostic: BL1PR12MB5272:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BL1PR12MB52723295C042BC67E7CE6D15F7029@BL1PR12MB5272.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:296;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: jX0G1EBxD3YsK4Vp8JISqdFrLlDIB/ul0CFbTX6q2mNq8zmAmtb8TOJOf6W+sMitEyV9hf+/Zm4jhF6Rg9CpSqxBo7xCpby39YRA/kSEpnHrjvpGLLAaZh/KThnlhCymujWjhrq1R7rQdKOhqq+QrOjzKEoiOeGMbno0dIzOv4tciy6D1P7CDbCUE7zpOKtCQTEGiHdgiOS/49acmYOcQ1EZc4bS8mzsbbXvi43ZD/bbHWqFD4yHWC1IFdGa5FSACXoDG8/V/MYzpf70GLZC7Qyzlv3pLboWEh6Y1tj4TDlrCoKtUqvACGoOtzsf8erONW9LDaQh8dbdUrgTAty10UEQCPEAHPKGftISkhjxlYntU4MfktC3RHwwBH0urBrDTWkOz0TfKwlTNILDBAVLcMzky8hcJTyE2oUUxFZr834EypVuNKyq0yEdJboKKXbOXyuyiMWLMN04FBSTJK3f2oGmeCzas1nUIQFYbx5vPGc+ElZAort0hpjOwooN92zmf9CJpxWuSBec03ZsEUlybEoGPdyLMgugtgH+Des7iI6ghEqghI5HXvZUGxDSuPKC+ynGVvZfYLqoRB0hnM2frZtOUG81o7Q2jW/6kL6Wpt1IewKvfjs4M8mMYVAG3TDfh37ZgG5dyNSGJXE7ydHIoeBHkKAcerV+x2vJd44T+u+ZAQfadoytmfogrMneaf475JQpQhHpcBtpdf6UQiiZftKEf09i5aeVJA5qaj1n2gl4AbPZlOXsgAqUtonwu4Eg
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL1PR12MB5144.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(136003)(396003)(346002)(39860400002)(366004)(376002)(186003)(16526019)(86362001)(6512007)(478600001)(26005)(38100700002)(38350700002)(5660300002)(6506007)(956004)(52116002)(36756003)(316002)(6486002)(2616005)(4326008)(6666004)(66476007)(66556008)(1076003)(4744005)(2906002)(66946007)(8676002)(8936002)(6916009)(69590400013);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?RzTKpBCrwWgm35O2963vFiMfglyJR356mipVv+us7oGzRgwmWy1so9S0Of+E?=
 =?us-ascii?Q?DE80TDqm+OAInpQX7KSkTZUYlaY6X0NUBVP6i9m4k3+gz6kxl0pJtbYiwbzs?=
 =?us-ascii?Q?+7U+6Y2fEo7kc6WV/pi100z4iCkZg+n3wPpzI5HlRfD7WQEZ999Uvp1gFayE?=
 =?us-ascii?Q?GXCfDZVsmsfBrDiZPBm47FYwczo0lIne9QSuDhsbjJ/hJLzCLp2C86/RlKft?=
 =?us-ascii?Q?7cctev5zujBYMtJP4Stqo1x1C/BPwWwoXAfTrxl5HZObJCuKsoexi2cvjsR8?=
 =?us-ascii?Q?h+Ora/f9wWvmxarbgN86bfccuKpKFyDP5GEl743gb4w9K8/45ROh8NZW03H2?=
 =?us-ascii?Q?ZYnIQHTZrOAF5+kmFoQ+7ln5tNibNDYA86VEnMwIRNMRmErDOh3oG9qkuU2k?=
 =?us-ascii?Q?o5s2zHrbmVi+rych05xDGZTMi7FF3GEXi7hJDhrRtqitk3ZpvK3bYfC9nHbX?=
 =?us-ascii?Q?a/Jc4NC3XB9iOgBAUH2AbUb0VCc8yu0DAKQ4PZnV0D37l/WmMgy5YESWJ6dW?=
 =?us-ascii?Q?CR330RM1+/c8IfLlANCrELdnsVOAYljFnGwVkLyuqzjmsOknmN6uiBHq5eq1?=
 =?us-ascii?Q?QlEl+5M3Yi3tLBavLP1c4igUBwg/uRdLbNGWclb0JGlAq0NKzMPgvWO5Ocnc?=
 =?us-ascii?Q?Rns3KfU8NFRfENWMKSPA4iwkC9jr0ERNk4GDifo87TiCIDdnrtRXZ2Ltc0pJ?=
 =?us-ascii?Q?7WuuxmisdeVHA2yc+9FRSWDLUjPlnUVuAXysjGvbhh1zUVXetiOyJ5LiWvz6?=
 =?us-ascii?Q?AJ2A4s7Z2xhndayWP/uvcsxNQIl8kxxXwnfOVlt+YactQRMS3eacKKYkmqZD?=
 =?us-ascii?Q?uJZlvJiAFAi5+JwapuaLWIIlT8xgbL6vnoeVpmZF68TuaPTh4Iy5+phKcDJ4?=
 =?us-ascii?Q?sVW9/flOHIkJWRgRGfJQW5RXvFYNWcQBIFpNcPAfNTC7/ESN8VDos6EdHBNO?=
 =?us-ascii?Q?Js8mN1RQ4VbjG0S4t2mk0tqkkYh1TsQUg2lwSwzfsofaV5ckOn5EzLyEqqW8?=
 =?us-ascii?Q?goCWHYJLsV+o0eEGfx/PBune86wmUHp3hVUOUMpTED9B05jTBzq1IMI/cKg+?=
 =?us-ascii?Q?Ji9EA+OXHXMrGlHVIe3PgOyEqr2dTDzHesGmqZUGlavlfyCKD5CtE/4d4Dsb?=
 =?us-ascii?Q?xG88RLJC0xTw0SJl6jRuIuWSpr93jdxCI2Xdvswm3e67ruMomSENA022WtOG?=
 =?us-ascii?Q?8U0tXHz5/B9UGLQA+Hk3GO5l+8k3XKoYFLe4QteNZH52Z9saPIQXUXv1uhcu?=
 =?us-ascii?Q?H4UAfGtVHTvsRdnRwITTUDj3krmFrqlMc+ic8du1amzK+OQoYPxN8FUX3cGy?=
 =?us-ascii?Q?pYl4k5x+adQxHeSsCxn1NH+j?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e67fe395-5b89-426b-bad2-08d93b377c97
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5144.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jun 2021 19:52:55.1036 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uKffo1O79opLIFJW6YN6x4YLOOOd1cV6v0Qpn5a7zTG+VfYefN+36bWyHbhYgXTZWAnK99aJ4mqVfQOnT9sn5g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5272
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

Add new PCI device id.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
index 1a110b06cb6e..6419d75f1f18 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
@@ -1198,6 +1198,7 @@ static const struct pci_device_id pciidlist[] = {
 	{0x1002, 0x73E0, PCI_ANY_ID, PCI_ANY_ID, 0, 0, CHIP_DIMGREY_CAVEFISH},
 	{0x1002, 0x73E1, PCI_ANY_ID, PCI_ANY_ID, 0, 0, CHIP_DIMGREY_CAVEFISH},
 	{0x1002, 0x73E2, PCI_ANY_ID, PCI_ANY_ID, 0, 0, CHIP_DIMGREY_CAVEFISH},
+	{0x1002, 0x73E3, PCI_ANY_ID, PCI_ANY_ID, 0, 0, CHIP_DIMGREY_CAVEFISH},
 	{0x1002, 0x73FF, PCI_ANY_ID, PCI_ANY_ID, 0, 0, CHIP_DIMGREY_CAVEFISH},
 
 	/* Aldebaran */
-- 
2.31.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
