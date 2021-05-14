Return-Path: <SRS0=oeKV=KJ=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1097C43460
	for <amd-gfx@archiver.kernel.org>; Fri, 14 May 2021 04:51:20 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 88AEE61184
	for <amd-gfx@archiver.kernel.org>; Fri, 14 May 2021 04:51:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 88AEE61184
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3B9896EDFF;
	Fri, 14 May 2021 04:51:20 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2042.outbound.protection.outlook.com [40.107.223.42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 793406EDFF
 for <amd-gfx@lists.freedesktop.org>; Fri, 14 May 2021 04:51:18 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=N/4KVohxEUAO3F6La02IIh/yKHbDX0wOFory8xCbg+hh2JGYrdCxiF4OjBewOI54qWZ66mA2qFeBPSElSshf9ejr/kvre28DUdXWJd3aeY0A6SXXkg4cg48BgLgX6vQ+0huchOIxyJUPd1fRPGyb4i7mGu9ClOqn3ZVCy/RhFt0zr86kqsXdZu1EV940NEZi7Id0aE8jeHTA9eBIWXzjzVQxPptszz9VJmJD521lICwuDuPc4zvt/FlIV6+pKQnTwd/UmiCnKgOljBC8KegG/uARFifZHBO0T6q/3sra0D80jH9cLWxwWCO94Oo9SCtCjjJqIK3VF8Nh1a65euVBXg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=S9rul3+qyA9ez9OpaUgqMEpzKd+vaIBnr9LzCQwjk1o=;
 b=i4Dmvj5G7jYM7N1+SiqHD/ucKwfT03LW/1io3C1iqMHYshzHKEF0Vt9meR+njyXhcVSJ8lIcFIQj4th93ES25YhdN1gF4RmlsOpld+z+qud5gw7w4eCma8FVWdxTW5DJna2U5UomLnR6GHjqcO7HHswHRiPHaEiiYpNE/Vd9Mg27vRNkfA6HY63hz32JSsjNpLnDRWJIX2V8tN6ymdqUO+D819NoIYmqVWQA4y40UgYPBzMtciXKkmHEtSNEluMo4nS9jiandxAbzsZOjo174rNk3bOWuVGTAylsK8jEvtAxJQ8QFlXfu4wCwGdA39L9zYsaH2fG6XbI01g87XYx7w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=S9rul3+qyA9ez9OpaUgqMEpzKd+vaIBnr9LzCQwjk1o=;
 b=GFjuzwbeCnTp9qAOwm6lozsnKi6lyRST98QUguEX/LWQMq3riJqgpw5hYcIQus1mTCTfDylJw3ars0gxqsvU+xqg4dKUTAiWWid3At2ky0GnQksH0ks9Yy5WoaXwjvlXmPLY5cZSItJgQ9lIRCILlIWoFbkE/mJoUbMBiPyFrSw=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from DM5PR12MB1226.namprd12.prod.outlook.com (2603:10b6:3:75::7) by
 DM6PR12MB3129.namprd12.prod.outlook.com (2603:10b6:5:3b::26) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4129.28; Fri, 14 May 2021 04:51:17 +0000
Received: from DM5PR12MB1226.namprd12.prod.outlook.com
 ([fe80::16d:e05a:d9f2:8c23]) by DM5PR12MB1226.namprd12.prod.outlook.com
 ([fe80::16d:e05a:d9f2:8c23%9]) with mapi id 15.20.4108.035; Fri, 14 May 2021
 04:51:17 +0000
From: Stylon Wang <stylon.wang@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 14/20] drm/amd/display: Add Overflow check to skip MALL
Date: Fri, 14 May 2021 12:49:57 +0800
Message-Id: <20210514045003.3069681-15-stylon.wang@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210514045003.3069681-1-stylon.wang@amd.com>
References: <20210514045003.3069681-1-stylon.wang@amd.com>
X-Originating-IP: [165.204.134.251]
X-ClientProxiedBy: HK2PR02CA0147.apcprd02.prod.outlook.com
 (2603:1096:202:16::31) To DM5PR12MB1226.namprd12.prod.outlook.com
 (2603:10b6:3:75::7)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from stylon-rog.amd.com (165.204.134.251) by
 HK2PR02CA0147.apcprd02.prod.outlook.com (2603:1096:202:16::31) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4108.31 via Frontend Transport; Fri, 14 May 2021 04:51:14 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 26730edb-d18d-43b2-b285-08d91693e89b
X-MS-TrafficTypeDiagnostic: DM6PR12MB3129:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR12MB3129BD75A8185BA499176C5CFF509@DM6PR12MB3129.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: raxJMCE2X7np7Rr78pwhdEEAsuNhS1ma0V5H+Ww3UMn9kM1maK+cfw5BtSdXVeM6YKPP8mxnj+anY7xUD3WTZeIucbWQBrblP5IqFb2vK714m8EjL81eVPVV9LuG42AD18kqPzkR6RwhgZ/goUQM1RTXL1HoXQTNfQFx65v6n/wKqmaZmJOz2yMc5MHhonj/QgEsGZxTDhmI/8hV7T6xcpkeJn/kJxBztoRlalqJeqXGmp2glNay9RO+pzqv/B/ok3A7jkf9uYf2JExeRkw4M4zgq/QwjnQirsVP/OasSurKz0xLqo/hCedf187tH0oE4WYMrdk8CNOMvVAIKMBsC2M4XhHt7DPgSAU75P14Dxfab3XFy2QTLB3TuzvOYBi1J232vjVTyerMKWrKbkS6S3iXiyy0jyEpyR48iPWdkcn38OcK456sYOU+kucgHZdyLMhsl77WhiszBXBs29QYpGFe+E6NqwCObTHfjs7xCzYaIlM5pQ3ucmkq2mPEOlMrY2b/kBQwP45M9gJyUY83iDk9uOzE5Wmv2V2QbLFHf1OUU3EeZmKgx7I2muhKScRY6ATt3XRNIR99qC18qi7d+MUPvJegZBJfWSyByEStXrlFjgvhiHEWLJmoZ3rngPJiPXsfu6VgmaTLWMLwRpjgVw6XdVk9cUry2gZWEAQGbuc=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM5PR12MB1226.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(8676002)(498600001)(83380400001)(26005)(956004)(86362001)(54906003)(7696005)(4326008)(38350700002)(2616005)(6916009)(1076003)(44832011)(38100700002)(186003)(66556008)(66476007)(66946007)(16526019)(6486002)(6666004)(8936002)(52116002)(5660300002)(36756003)(2906002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?nWB8iMVemcyzRCJjhVHB1xW/0/wDbaM3B2CuNZEdXmcr8W3mNk4GEi/c7RyY?=
 =?us-ascii?Q?8jcwOHN5zhKX8YSNvblQdJm5A0izs2x5pOtTo6aSORDDHCZSs4L8b+yVntyM?=
 =?us-ascii?Q?WCVF9D1lRsNKWkEAuNWYl7FD5w5vEUJgrq7qPtgaU/MnkmMWi+xa3aS2iWhv?=
 =?us-ascii?Q?rforXUUCKbGkb3xGBU3ghV5Z60Bnth1cSDqizDLgRTM+KIGBOjJ526WcLmjL?=
 =?us-ascii?Q?sS9WVkeRTmkLoSNvB99DYGBCvexbAWX7w/sZyKs2ZhtcEfx7gHyvWrCEZlOl?=
 =?us-ascii?Q?Y4K7yPreV47Cul4ySwoaYZ7mCLi/o8h1W/B2YoCK1lRDhmKnQxkEu/YmHMJJ?=
 =?us-ascii?Q?xp8b67yjeq2mAqNDvIsIdwcslJBRliAJRntrZYXIpJBdysGAaL5OBVTB+ZCc?=
 =?us-ascii?Q?OB/zO+K8seegCpQzM+Imb/NhhmbcSXrZ4CW6DwV06/VxiTB0XyVrBXermMue?=
 =?us-ascii?Q?Nojhw8g95RPq0UbRZtAvk5DuE16MaRkLOxFDClapZfptQbQh79HawK+mKjit?=
 =?us-ascii?Q?HO1rFE9YxDdogAMwf0EY052aZFpBXFnwVhMyH0h7xrAlMNASC3rLWhESL/72?=
 =?us-ascii?Q?be1z/xy4n3g91dwTSJbgI4RTxvXFVoa0qKZ3BWRoN3D8ST3DqPFbWxi5AuRN?=
 =?us-ascii?Q?GBoQCAHAowzvh71FH4fmYcRX9W5U+ECoTtp4GqnEmXbGYMwLUKYW8iF3PFdd?=
 =?us-ascii?Q?zhjEQXM2Ceb3OjAu66f68fQkAiKA2wyiODlt8Tu0E5uaWfhec+7392DxAMzl?=
 =?us-ascii?Q?vnrhq6b0OwPREiatjt4HZXVTUYlzhSs/4LQ4GFTToBndhODlSg0Q0D1TT2U1?=
 =?us-ascii?Q?Mb1QEM78WMzkm2JlHokW6HIYsLb0wqKvuehqSsmHGHrlK1eNitwgjlrnPGjV?=
 =?us-ascii?Q?0K8Arikj0PQfJLi2xEgzs/YQQHAiaVcjeut7UVoU/5ybmZJ4tdV5hrKPsuUg?=
 =?us-ascii?Q?Djw6KtQbH+4DMH+ZrXZCAI+o26mKFGsArC2BeiZSqDn8imm0FdTskFKHY5QT?=
 =?us-ascii?Q?OfAMWf9SommtFRf+afeKA43mgsR63VD2o+G1eltqB8A0CqYs3H0/tErbG1Mj?=
 =?us-ascii?Q?MvudlfFaV49VICvEcjbqjhNafVQ7omQYqpdg639G6TtMSZOM2fyAqv1xKePT?=
 =?us-ascii?Q?GnulkpdfzdC6r0NClvPgaQVVftKf0th12tQbED+jfopVi/iCGUbPKWmaYcvh?=
 =?us-ascii?Q?kWPdCUx9ykiZpvMS9JolWunv6zn+R68x5w2HIeOhRuvyUMtWawpdFuSeJY1z?=
 =?us-ascii?Q?SwPrUyGQUiZfrs2ttjbdHFUYNm0btkoDZgRg0tuh0uJSiaNwtfMU4aHZLrl2?=
 =?us-ascii?Q?Uw/tkB+g6fnWxCuZrj62qEmjYlnEUQ0m8B0UlwgdFInJtQ=3D=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 26730edb-d18d-43b2-b285-08d91693e89b
X-MS-Exchange-CrossTenant-AuthSource: DM5PR12MB1226.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 May 2021 04:51:17.0256 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jLnZeiZ9wRyEe98zkq4SXIQ+qjSst/L46nmqrloOdtf+WoMXN1g5soDgYnFdHXY6g3QZgz/r1mKn6LbrckF3Vw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3129
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
Cc: Stylon Wang <stylon.wang@amd.com>, Eryk.Brol@amd.com, Sunpeng.Li@amd.com,
 Harry.Wentland@amd.com, Qingqing.Zhuo@amd.com, Rodrigo.Siqueira@amd.com,
 Anson.Jacob@amd.com, Aurabindo.Pillai@amd.com, Jun Lei <Jun.Lei@amd.com>,
 Bhawanpreet.Lakha@amd.com, bindu.r@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Bhawanpreet Lakha <Bhawanpreet.Lakha@amd.com>

[Why]
In some small modes (<200pixels) the stutter period is really big and will cause
overflow. In these cases we shouldnt try to enable MALL as it will exceeds range
of hysteresis timer (this can be seen in some IGT tests where the
plane size is small)

[How]
Compare the stutter_period with the frame time and if we will overflow
there is no point in trying to enable MALL (and see the ASSERT) so we
early exist in this case

Signed-off-by: Bhawanpreet Lakha <Bhawanpreet.Lakha@amd.com>
Reviewed-by: Jun Lei <Jun.Lei@amd.com>
Acked-by: Stylon Wang <stylon.wang@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dcn30/dcn30_hwseq.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_hwseq.c b/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_hwseq.c
index d53f8b39699b..83685310a391 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_hwseq.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_hwseq.c
@@ -813,6 +813,15 @@ bool dcn30_apply_idle_power_optimizations(struct dc *dc, bool enable)
 						(100LL + dc->debug.mall_additional_timer_percent) + denom - 1),
 						denom) - 64LL;
 
+				/* In some cases the stutter period is really big (tiny modes) in these
+				 * cases MALL cant be enabled, So skip these cases to avoid a ASSERT()
+				 *
+				 * We can check if stutter_period is more than 1/10th the frame time to
+				 * consider if we can actually meet the range of hysteresis timer
+				 */
+				if (stutter_period > 100000/refresh_hz)
+					return false;
+
 				/* scale should be increased until it fits into 6 bits */
 				while (tmr_delay & ~0x3F) {
 					tmr_scale++;
-- 
2.25.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
