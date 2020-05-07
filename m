Return-Path: <SRS0=+Cdj=6V=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6CF05C38A24
	for <amd-gfx@archiver.kernel.org>; Thu,  7 May 2020 13:54:12 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2DA732082E
	for <amd-gfx@archiver.kernel.org>; Thu,  7 May 2020 13:54:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="GL79/VZC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2DA732082E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D6EAC6E9B0;
	Thu,  7 May 2020 13:54:11 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2073.outbound.protection.outlook.com [40.107.243.73])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D2A376E9B0
 for <amd-gfx@lists.freedesktop.org>; Thu,  7 May 2020 13:54:10 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZX/3dCRIg9voKv2njA60K+mTDQXs/foG0W4WE+7S55Vz+GEpn1TFAQPjKhcaWLcaUIWmHlb/yNBnLO4Seoekn10Y2kT8OqstRE97AtBGxpnHJONlEA1xojWb3uruz0ZtJdzasstrPPW6q4w9s5LT4LwRbDON6n5f3GmHlvSRCkh7edMYiHZp7bs2mO2Wm0XU7hmwX+T4uBPLd5Zko4yzgezUXJbxn1Q+8XiioyVQWAbgWjCeZuY2ptIj30jKLTi8X8xQvabg1aKppaASmJ+MDcxr+RGLfZFzXbkoIq3QAevZnbhihVzik7GW5bg4vVwjhPRT8X/cvnKBZtS4WPyEFA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JFSGN2lKtXg1QsdrTY7oNXfS27EMyK4L0v2ljZpmORw=;
 b=jgb44Xl8Rc2kedJf9DENpjFWARp1M0QwXorftsyx1ur5oOYDyW/CyKzhslPEO9DjyoUAwVL6xUFeGzm+neLwcARjf/gf8teqjniR8GTYzQhZkVe0+j9C0RYd87Ld73ZbjMYUpgqPyyEiXvlLjz9sIWTM07M4+nvyUbtVDpHDdeWTp6mL5Sg5C5Ws2+2MjI70aVgjPC+SKCRvgOWbsTPX2UGIcWd8AtFjEn4NrUf90xywGWi1g1qW8lxoRYF2XTpqIADlf6Hc0B2yxGzWW4ht/OKCXqJvnxNB0NV2tEeDZY9vh8/kxlOWx+GNuzP1RmVgkDeaOfOxZA6Jsepm3hH3LA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JFSGN2lKtXg1QsdrTY7oNXfS27EMyK4L0v2ljZpmORw=;
 b=GL79/VZC7uk63EzgtXEDAzTdPdouJQ6O3nuuj5dAf1IPbtFripkWakDi4cuGZplfXAAi3d3YaCTul5Lw2AeUPKOjPYDoWdMcYjxu//Lb+0C73fV1Z7pL3sWlXqKfdt/aAVuKaejK71AS485sy1/Ir9IarG9W+yUHPLY6oUWRZn0=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB3721.namprd12.prod.outlook.com (2603:10b6:5:1c2::18)
 by DM6PR12MB3081.namprd12.prod.outlook.com (2603:10b6:5:38::27) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2958.29; Thu, 7 May
 2020 13:54:09 +0000
Received: from DM6PR12MB3721.namprd12.prod.outlook.com
 ([fe80::e027:654c:5d9f:a648]) by DM6PR12MB3721.namprd12.prod.outlook.com
 ([fe80::e027:654c:5d9f:a648%3]) with mapi id 15.20.2958.030; Thu, 7 May 2020
 13:54:09 +0000
From: Kent Russell <kent.russell@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH] drm/amdgpu: Don't report unique_id for Arcturus
Date: Thu,  7 May 2020 09:53:59 -0400
Message-Id: <20200507135359.18138-1-kent.russell@amd.com>
X-Mailer: git-send-email 2.17.1
X-ClientProxiedBy: YT1PR01CA0116.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:2c::25) To DM6PR12MB3721.namprd12.prod.outlook.com
 (2603:10b6:5:1c2::18)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from krussell.amd.com (165.204.55.251) by
 YT1PR01CA0116.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:2c::25) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2979.26 via Frontend Transport; Thu, 7 May 2020 13:54:09 +0000
X-Mailer: git-send-email 2.17.1
X-Originating-IP: [165.204.55.251]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 73bdaf2b-dc92-4966-98d1-08d7f28e1d99
X-MS-TrafficTypeDiagnostic: DM6PR12MB3081:|DM6PR12MB3081:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR12MB3081A330E8C9A04A807AC8C185A50@DM6PR12MB3081.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1824;
X-Forefront-PRVS: 03965EFC76
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: AboOb33cfM4zN8QzUwCfY/qS4LzQwlKjP+y6sTkmFMkQAmwJurYHtSLf2GMLOMxPwDW9LojQTl3sMsc9ABkbWOqWSSdQe4WIjX2feVFBRnJEDeHkhArd1nU1DK2+rxDoJDykKUlGaaqxrLmTSF1+VPjWzo7PMDLgk96BKqPqyDj/kjYjY6cfOWd9wvA8Ow3CsyJKBFSceRlicswh5vR6IkkL8L01UHvkAamAYZ/BeJrlTfFSnHZCZRVG9TWIyJYNL9kFgfeQ9XGLGU90ljQvBh9aiUmYvQC8+jcJLe7NkZ6M0b/w6ExoD5mN6QYkz60HPKAQ7EH53fNxlZONs6TVMUDPHn3hLGTwDe7T1flxHszDxvJT7ZZdU2yhq3W1RPbR2MldbH010yo1gGF8tsucziaxG1aVJlGWNs/nHp9tqV8jXTGlBfoPHVORT6YbdTEqbXz7t9rIiH/g+UcHn8TGef7PSE5kKHtZd0B7avrevVho7ZLmCvgPLhDA4JfS1zNAGCUUL1jCjlBXc9ZmszjhWw==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB3721.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(136003)(366004)(396003)(376002)(346002)(39860400002)(33430700001)(186003)(6916009)(36756003)(7696005)(956004)(44832011)(4744005)(6486002)(2616005)(83300400001)(8936002)(316002)(83320400001)(26005)(83280400001)(83310400001)(83290400001)(4326008)(8676002)(2906002)(66556008)(1076003)(6666004)(16526019)(52116002)(478600001)(5660300002)(66476007)(66946007)(33440700001)(86362001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: TrwbgG/kPWyPbC8td0uWggsCGfr6GUgSE8GebVLaZxWL8VazRvIgGR1cIREtmmvQUZbG183OzPfTA8WZFxg8iIYxQt/Qw/JCQwNbeNBJTKZM5ffuiz1RSk+kkb3iNKkyZImhq8jGdvswgQnxM0THCPBgEefO4/QICGHo1N9jTRovE9SMHGRSM7ZVznp91wr4BhRfG8YNWhWibidQjiMhixtFw3I+itZo5OlC+sd07+rwWfXQsEZGpWC/yoO8xAECXdhGHw18psX4ejF0nuqJbzU06OujTMT/RoMl3sqGkbJp9sDFhLP73RU/kljMWuapc03Wv5wQH0lzAg+9hqe34MizdLUFJC57C3gY921/Gz5+1jE/k2CHgPhmrFfY2AdUmEyzMuVS52p3yn2UZ82YXqEeckErQw5In986FVql83GGvGYOfWEt49kKgdX5q9+u5iz090v8lkUJEH0FDQ5lc+NpNTraK/Or+yx4/ex3qL8S+E4p+/zjNNZQr2+V4NZDqMkoE/arOQy7gmsNqzFGP0SSygf1gLkCerUDGFM1//8u22mOENJzmruzrsPHpEOJIOS41wCuwDrybMeUhaTYPvdovFe9E4MacONIQW5WDRZ51G+zKBrUiedWsf506cfsUIob5fOnEPyaKemeykJ+DbEd97xO/POD9gqFCdbErv7Joer/hjaXiKFaPSu8DPD/aORkDJ4M750TArBp1UlMro5Sl9NQOPDoICY4qZhXplMXmfgBx6gSbaGpRmy4hqTANBkK2qVF7dku0nu1EF2wY5IZlSusmuMVw2GgFznM8T0=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 73bdaf2b-dc92-4966-98d1-08d7f28e1d99
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 May 2020 13:54:09.4196 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qloRmBUlUqYIsYORci5U748Qw21/xJsoWrBAZqv6Aah+iKi/n2HYLvdpfq5+6li4oUOg8RhlyAZk8pbbYF4MnQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3081
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
Cc: Kent Russell <kent.russell@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

This isn't supported in the SMU yet, so just break early. This can be
reverted once the SMU supports the feature

Signed-off-by: Kent Russell <kent.russell@amd.com>
Change-Id: I09945613aa7400afdf3f9d5dc0ffb636ee2896f7
---
 drivers/gpu/drm/amd/powerplay/arcturus_ppt.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/gpu/drm/amd/powerplay/arcturus_ppt.c b/drivers/gpu/drm/amd/powerplay/arcturus_ppt.c
index f55f9b371bf2..cb90825aacf1 100644
--- a/drivers/gpu/drm/amd/powerplay/arcturus_ppt.c
+++ b/drivers/gpu/drm/amd/powerplay/arcturus_ppt.c
@@ -317,6 +317,11 @@ static int arcturus_tables_init(struct smu_context *smu, struct smu_table *table
 	smu_table->metrics_time = 0;
 
 	if (smu->adev->asic_type == CHIP_ARCTURUS) {
+		/* TODO: SMU doesn't currently support this. Return
+		 * early and remove this once SMU supports it
+		 */
+		return 0;
+
 		/* Get the SN to turn into a Unique ID */
 		smu_send_smc_msg(smu, SMU_MSG_ReadSerialNumTop32,
 				 &top32);
-- 
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
