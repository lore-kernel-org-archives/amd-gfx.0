Return-Path: <SRS0=n+xW=KC=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 268FCC433ED
	for <amd-gfx@archiver.kernel.org>; Fri,  7 May 2021 15:00:16 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C6115613F1
	for <amd-gfx@archiver.kernel.org>; Fri,  7 May 2021 15:00:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C6115613F1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6769D6EE4E;
	Fri,  7 May 2021 15:00:15 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2066.outbound.protection.outlook.com [40.107.236.66])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 16CB66EE4E
 for <amd-gfx@lists.freedesktop.org>; Fri,  7 May 2021 15:00:14 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WW97/3OkaHvwMhS1LGMJ8Ylvre5DlQ8B10mrjojjaYVe2my68qCiZqTUJyVp3a3QEmGxehj9llcngITXgf3XpeyoXLL8KS8FOXK9/fF0ISqj3kkVALvdSekYX1IPvjiT9sQapRdw/3lmB21rdce82PtUicqhSBLwzZaWgpFj5MCO2MUiz7Kq8SNe/cbklXuNXqX9n4I7a1zlrvl5+2hXo6F99LZkQLYS0X7fUbkRYpRK4xXrLXMC6oepV+3zLT7ginfrg+dYn8vWEnUVMUHDfNtN8ozk/ngqhegmEWp2KI6pobBI8taAcO61I9/7F4edQoRSjgqsqnUJNzswVDmDig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GupiFxYAXnQWIMKqMMgfWfy+SVqfmlzPR80YQrzzZrk=;
 b=RjM9BP9zLF9ell/v1sCUqI69JjFqXCGRtA5A1TRbcroiSc4rokFFdzwwUxa8GaR+gWJz6futeA3KPcws7xutDYQgVAwltvlyYWTwokxGo2r2wRlmjMalimBBY3XzVfCiD2w/+ngfb3M4Jmk/kEHRZFSbX+fH/KZVaeHLCfTD85z4pNZzFAT+W5c97CYEU31OkE0+OiCLqp9TTy65PoaiczpoEn1pYWr7GiLprfjUx3tvovLG86Vfk3il0yKMycgMg6mGh4QH2lMouBmuV+MzX31tsEkXm8QS7bpRIQBzYQ2QdpwNQp3wpKGfLWEZifrdx+h0KLGYHtW97DPYTJLwRQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GupiFxYAXnQWIMKqMMgfWfy+SVqfmlzPR80YQrzzZrk=;
 b=h0EI+GDxK0B4EvpqzruEzCky1RqjipZXxULzKsNX9s4qkG/dxtNk2CBg47ZssulG9yUHTcjXcDLPuAIJuesThNozhxubyr6bJZmDcwcVhXj4tUbM977NDQb5Oe5TEeeP+d1VqnaW7p3dwTPfqdurpEmUZScVONXQdBChqotI+Wk=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from DM5PR12MB1226.namprd12.prod.outlook.com (2603:10b6:3:75::7) by
 DM5PR12MB1786.namprd12.prod.outlook.com (2603:10b6:3:112::14) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4108.25; Fri, 7 May 2021 15:00:12 +0000
Received: from DM5PR12MB1226.namprd12.prod.outlook.com
 ([fe80::16d:e05a:d9f2:8c23]) by DM5PR12MB1226.namprd12.prod.outlook.com
 ([fe80::16d:e05a:d9f2:8c23%9]) with mapi id 15.20.4087.044; Fri, 7 May 2021
 15:00:12 +0000
From: Stylon Wang <stylon.wang@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 12/14] drm/amd/display: 3.2.135
Date: Fri,  7 May 2021 22:58:20 +0800
Message-Id: <20210507145822.248029-13-stylon.wang@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210507145822.248029-1-stylon.wang@amd.com>
References: <20210507145822.248029-1-stylon.wang@amd.com>
X-Originating-IP: [165.204.134.251]
X-ClientProxiedBy: HK2PR04CA0045.apcprd04.prod.outlook.com
 (2603:1096:202:14::13) To DM5PR12MB1226.namprd12.prod.outlook.com
 (2603:10b6:3:75::7)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from stylon-rog.amd.com (165.204.134.251) by
 HK2PR04CA0045.apcprd04.prod.outlook.com (2603:1096:202:14::13) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4108.25 via Frontend Transport; Fri, 7 May 2021 15:00:09 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f14fe2be-6247-48ae-6654-08d91168d07c
X-MS-TrafficTypeDiagnostic: DM5PR12MB1786:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM5PR12MB17868FA0D0807E694088F75EFF579@DM5PR12MB1786.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:296;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Wq1kYAzl2COsLa/195WjGjdKC9y0pV41XkvyE3br0NBLjBfncWt7eHYzmghzk67cSg976+JQUKOrJ0PbTWBhjxoSAXS10Hfmy0jreEiCW7bXK2aU0XMZXbHuyFojdi+18ANK6tSkaBZz0aBqEPWhcj/UB5ZvgBug5VfuKZDOkEa7fEtKDNu/ZZc+SurSYNiq7+l8GV8afdaLpD3Jz+26Qm94oOdzF6pGSdt4Y6ZGz5yAOHjJhMfpL6ymnx5D+hrbFK0QbGgaIYZPEq+Rwvip/Gqq5oj9IGNYw31UxOsK+vaXtXrnKFwlkNlfy2N68slgWDQIVWlXbTqLvlCAZVDBU9pK72/DV5umANhxrYHzoqmSitKQAS+VksNTJajw80laFRy8Lhh8AmXlvbn8pOPVq/LzQBmrvucXbHyJhtZ3i6kVGIPewNED2cltUCRZYrDDV4nyrXYaa9b5Bo9FOw3e3wI25qxTb3UxC2/XyYBD7I89zjAtvXiYJyoJTQFLbcjg/RwK8uFVSzCJCEj9SMu5lJjHmPjY0XHlbDdWIo4jtOdCaCLNNV9Fnis4Qnv/lTjOI1pXMZBTlhZFlyIISVT6FWOUA8TuJOms/cloB/21bs9ESyxH1DhcSiX3ZKEMjb4QFMYWexcWSpKD+TgyI3TUTjIrnwqlY+6JRxfDV0PC/ck=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM5PR12MB1226.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(136003)(39860400002)(346002)(376002)(366004)(396003)(66556008)(66476007)(66946007)(6486002)(54906003)(83380400001)(26005)(6666004)(16526019)(86362001)(956004)(38350700002)(38100700002)(316002)(4326008)(186003)(478600001)(2906002)(6916009)(4744005)(5660300002)(52116002)(7696005)(8936002)(1076003)(8676002)(36756003)(2616005)(44832011);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?63dPJDyHRpNfSoOaYQd/U7FajsRTXXTFo4b94XzdDAyfB78BjjnTZ80PTZ29?=
 =?us-ascii?Q?5anuTnfO0/Ms3RRbHWjU5/YT6koycUieoX8bwI+ognXBsFNvfSEoQ1ZohYXj?=
 =?us-ascii?Q?ocPa8lfivm4ZocMxKD1+rXbZyWW5dHTVrNLojX8YS5T0d7lFFJ8ShbVKEdpu?=
 =?us-ascii?Q?7kLBku226h4/vnnEUPKzFn7ri9HqwhMo5zkRH00WdTT+DsG9emgjNlAHAn6K?=
 =?us-ascii?Q?wb2cbqKS/HaQiuhvdiASK48yGG1EE4Kc2nicIXUsssQ6AvQGTkgzlGoBzgS2?=
 =?us-ascii?Q?onGWBCez9LWxtYFHIULbjrzcDq3MDJIxfLKNQZKVqaRXBBuik0bX091ar64c?=
 =?us-ascii?Q?hCNqC6HV3lmGo1rOiBsaCLE1s4ROtAQ8Tbq6puVqx35I99XRdiWwpnTxWqKj?=
 =?us-ascii?Q?X6T5VzxxWYvIMoVa2gA9pZfUPEqgVqHVbykK3cnwlWc9rbvw01fgVUsvlq+D?=
 =?us-ascii?Q?scvmnPCBWo8NnEmiI3wv8qTWGDSDt83OErFP92BRCa70Q7SGPcVk8rVzvQRo?=
 =?us-ascii?Q?6Dclp9g5OVx3e4RdvKvwE7bU2TQ1dXx9T8rouvrdVTHuRt5mCJ2+p4m/IzX3?=
 =?us-ascii?Q?8zUhRO5+5hiUOpZ6L0UxCdPt95OCCEhvXfYi87rKMHiTgB0fB0FF2HfiKggK?=
 =?us-ascii?Q?fhPEcZw4hjUVaMolxt2xxVQCku8wEZOa4LBrFGivwcO2vpcdnsGZXqvztv7A?=
 =?us-ascii?Q?fYwkRgth+uLWX/y9PoE1b18k8fOqLlKdCw1saOcruFGXTBidv9Za2mkhkdZ4?=
 =?us-ascii?Q?GbZ+VlqYrheAC1Kq7Ae/xZm8r/Lxm88oOvpFJSbEU0aIuZdO1Nie/MEXonHn?=
 =?us-ascii?Q?go4tkJDfvjsh6XALFvCDmzzcSBnbBoveuF7VjAkOVaBdDvkNN3Cv+qX9vOG0?=
 =?us-ascii?Q?Q9qvvRytKPywY39oYcYfL43quoISwtoJW06UkljenqvL09Msk04HmTc5fzqf?=
 =?us-ascii?Q?Xeg3r3LklkpZf30SanofyLyK+HXK4ORLDG4l+CCQWZyOTMTVvEDmiGP1lcgd?=
 =?us-ascii?Q?hB/h1/RQrYxhYLn5czwJ9HmKfztN5JPhC+/gOmMuaQn6UYEZdYuM1mXU3BuJ?=
 =?us-ascii?Q?oiD1RvbsqVgpi94Fi3nq0Mq84Zi9LEu4x0BbGTGDwQnzAPv6f/oA5TSLBeN7?=
 =?us-ascii?Q?KxApyh9sgzTom3tlElWvUe3TIwjgbt0dpazoPaYr5AWBxu6/B7/WRgd7snsp?=
 =?us-ascii?Q?+hEqn+WmlRV1Nxc83ze8A8A47AqhtVqqHmLQwQLOtaw9bZ+8b/5YvaZHr6mj?=
 =?us-ascii?Q?djwrXICtODqp0DJ+1ufZcKCgeaQ68xbqHGq/j5T5Hq69CC3schXaCT9Izo3V?=
 =?us-ascii?Q?wxRzLFak57qYZzUuYBknnFqp?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f14fe2be-6247-48ae-6654-08d91168d07c
X-MS-Exchange-CrossTenant-AuthSource: DM5PR12MB1226.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 May 2021 15:00:12.5428 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PI+QAtmeWLESE9yIspVuUJljQ9INA5K3gVcnVNmvH0xxYbVxcz/Fn+2way7PqAzaVf6vsDzx7qOGCd8NbzwEVQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1786
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
Cc: Stylon Wang <stylon.wang@amd.com>, Aric Cyr <Aric.Cyr@amd.com>,
 Eryk.Brol@amd.com, Sunpeng.Li@amd.com, Harry.Wentland@amd.com,
 Qingqing.Zhuo@amd.com, Rodrigo.Siqueira@amd.com, Anson.Jacob@amd.com,
 Aurabindo.Pillai@amd.com, Bhawanpreet.Lakha@amd.com, bindu.r@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Aric Cyr <aric.cyr@amd.com>

Signed-off-by: Aric Cyr <aric.cyr@amd.com>
Reviewed-by: Aric Cyr <Aric.Cyr@amd.com>
Acked-by: Stylon Wang <stylon.wang@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dc.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dc.h b/drivers/gpu/drm/amd/display/dc/dc.h
index d9e1657ba6a6..213a6cb05d11 100644
--- a/drivers/gpu/drm/amd/display/dc/dc.h
+++ b/drivers/gpu/drm/amd/display/dc/dc.h
@@ -45,7 +45,7 @@
 /* forward declaration */
 struct aux_payload;
 
-#define DC_VER "3.2.134"
+#define DC_VER "3.2.135"
 
 #define MAX_SURFACES 3
 #define MAX_PLANES 6
-- 
2.25.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
