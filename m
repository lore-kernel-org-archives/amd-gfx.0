Return-Path: <SRS0=BT7C=ID=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08D75C433E0
	for <amd-gfx@archiver.kernel.org>; Fri,  5 Mar 2021 06:25:43 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9B43164E74
	for <amd-gfx@archiver.kernel.org>; Fri,  5 Mar 2021 06:25:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9B43164E74
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 14E306EAD8;
	Fri,  5 Mar 2021 06:25:42 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2043.outbound.protection.outlook.com [40.107.223.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A03386EAD8
 for <amd-gfx@lists.freedesktop.org>; Fri,  5 Mar 2021 06:25:40 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=j89SjECRcmezng1gH49a2B5YFFqimYANuq0jomSGidgg+sUOkikvEkZlaVZ0l6j+DlUP7FN8hYiyvUejurHPkVVRDZ1qTBhbtVbLEbSf9juc9uvP2HBQWHYExNewCqMwKcBqLQXUrWBZlP88Z2yGbgoF6Wj91IgIQZh5NG+5r608kO1jkFPcO/sWOKU3h8fGAvU9zdq11SQxrNW/P4jsy6NsVK2qR+2PKUGzZ98/+Rs1fBWsl8WgE29vJeuQyrBLSTvCmnPmZrajIwXQ0sl1H4NUUajOquhE8gkPvFIIaVyXg4nDp4JAWb8s2/DVKH1nzqRMaLMMEjrZONxucBMVfA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aGMrttAHJygkC4MqiwCvg/x0CslGoWWK8+sde1XK6PQ=;
 b=IT1pJuCYyl0rEpfp6TzBpXnhOKSmjlK17ezVnclU9rtgAKtsV+v62sfYbYKup6BkiUXBegZOgRug0ML2G+/EdAtw5s1rbSCGqLJtFMfeiHrocBL8jk9vxiDvBubsB5333JKX17tHri6VARRhc830/J5UacVTT1HGIGV+rDWLC0KiGb5C723j4qig+3K4GjLFr2jX0CWtiU2sFjtSmA/sJxnxgrK5XkWKJHBP75rniXbDiw6r3rJ6taG4B62isGuVtZkO6XdI7KgXxPBIiauZ6IHj3YAUlx3GJUdkY5xgKAx/DhwB2YiyNCpSs9Oxh7pScsdE9a/gm4jlI3ugLXJ1xw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aGMrttAHJygkC4MqiwCvg/x0CslGoWWK8+sde1XK6PQ=;
 b=yQnaoFSkDHsIv7JlNt6fmRRfzh+jFzJvf2/j70HyphWveJBH+rZrc+Be23AQMBoQwcAYasTAga22ArkwzmzPlECOrLtZ4lUZS9hLbfeUwaTAgmONV+b6HIIsEtLxCCPD7gOlWYYIc+PpHwYaRhXf2jB2071zWGsK91E1UDqqEd0=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB2619.namprd12.prod.outlook.com (2603:10b6:5:45::18) by
 DM6PR12MB3371.namprd12.prod.outlook.com (2603:10b6:5:116::27) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3890.28; Fri, 5 Mar 2021 06:25:38 +0000
Received: from DM6PR12MB2619.namprd12.prod.outlook.com
 ([fe80::11e6:53ff:8e98:31f0]) by DM6PR12MB2619.namprd12.prod.outlook.com
 ([fe80::11e6:53ff:8e98:31f0%3]) with mapi id 15.20.3890.034; Fri, 5 Mar 2021
 06:25:38 +0000
From: Evan Quan <evan.quan@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH] drm/amd/pm: correct the watermark settings for Polaris
Date: Fri,  5 Mar 2021 14:25:17 +0800
Message-Id: <20210305062517.583041-1-evan.quan@amd.com>
X-Mailer: git-send-email 2.29.0
X-Originating-IP: [180.167.199.189]
X-ClientProxiedBy: HK2PR02CA0221.apcprd02.prod.outlook.com
 (2603:1096:201:20::33) To DM6PR12MB2619.namprd12.prod.outlook.com
 (2603:10b6:5:45::18)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from equan-buildpc.amd.com (180.167.199.189) by
 HK2PR02CA0221.apcprd02.prod.outlook.com (2603:1096:201:20::33) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3912.17 via Frontend Transport; Fri, 5 Mar 2021 06:25:36 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 25cdebc0-7e1c-4080-eb98-08d8df9f7e59
X-MS-TrafficTypeDiagnostic: DM6PR12MB3371:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR12MB33717651582B100CF47EFF4AE4969@DM6PR12MB3371.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5516;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: wFQIqHaTzHQqEIqpzwdMM1k6LIDJ6SY1kcl4Xyr7AIbGnq+P04y77/iQwFvzSVwPmrFRSCPEVx1vwzPmogR37Xy7O+YwiR1DT2cpRFcYF5WCLT3KOAfEQ/udNsrru1EckyDSNCISg2D7nFYbw8GSwAbLCxTQ+qSNXg+Anm7Xai80Z4KQq3xBaSSpt7yQXoPkuyXHgl13TCg1mtFe6yayL/mXS96fjei0utEWRZCsbL+9VuZx8hgrPZkFA9pUzHdRg6+eET87OGcOONUNnZCAlDjIMT/mqqwDtclZSYNk4gInbvPjp585YGdlkxbeOyDIbe0vMzV3Gap3c+nRKscUlQ80qml28nm+hadlSQsQcYOqGbh61wztWqTtCTC696hF5JuEneADbdZFi+eTks6H07pS68G8ghAePioytKbxV83U0eanvyQRXzs0rmiGyYHnUU9C1rTj0mrKAafYrwrgHli7blJ5/ed32kNgMjXcpAyogE2eC+MD7N+c656L3syDFZk5zgRi/1yrxKYvlzrhMA==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB2619.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(396003)(39860400002)(376002)(136003)(346002)(316002)(6666004)(6486002)(86362001)(5660300002)(36756003)(478600001)(8936002)(66476007)(66556008)(8676002)(186003)(26005)(16526019)(83380400001)(2906002)(7696005)(66946007)(1076003)(6916009)(4326008)(44832011)(54906003)(52116002)(956004)(2616005);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?VusIa+wtJJuGmM8Bp4Q+9Gl65NtvRcHWN9fHprKeFQpJ+tebiU5KvoTqNtOl?=
 =?us-ascii?Q?EkaX80pRmiqx6CUpprnk7kB+lXgMuiaCLXd0d4xcwdK+M4RLaUEgQH4aHNKU?=
 =?us-ascii?Q?wmj0u6ihcagNd8qJz5KxOZIywYfr5YDVIhK1d88x+igOCCvritcErBdv8Kvc?=
 =?us-ascii?Q?e6TnL1ylBiOygGnIzNGa8bA2fJC4xCEBfDpARU45Eatz8TpxDFO3cRdUOwiD?=
 =?us-ascii?Q?hGejAihfa8O7Y1wrXlbIs82d9Ecq1TX6puiINKXpIPimOR4V6FEIQcsrYYcA?=
 =?us-ascii?Q?2GcjIeQEee7OMqqpTXhMh+xX3osUeMH/FjSpuFuHSdYXDmH62F+sT4PhwyqN?=
 =?us-ascii?Q?mrpg/XqkMXEz68Qk6QEYiBOMSdMP7sOYoPbU669uDvJcCotPwiZTheXX69O8?=
 =?us-ascii?Q?uSQmaZ26bJ4YXum6B2QvBpDo3Fgp1kq79XX/trvE4ZjqHwYoaWikdJLubHwU?=
 =?us-ascii?Q?35zfDLqKeRVvZ6E4aw3VX820labM9+nuTAnu4lX+sOlNiCUfXT8qs+7JTbXY?=
 =?us-ascii?Q?EbdsUz13BeQVQnUyp2XChUie/uzjbBA0g3SK6HoLanvJFdeX6YSj/P52okjE?=
 =?us-ascii?Q?F/5X9+yMyAJc8ppI5ontO3Q5BT3K6ci/IaE57ej54aYVMNFhTKZw3ScROvhe?=
 =?us-ascii?Q?AuBXz9AXTb0sLAj2dgsluMn2i93yvrmQbV+9x7II75BV0AUEDMSrMSEnVKuR?=
 =?us-ascii?Q?Lppq0oWkAqbN625g25jq3oujx6kTMtZ7nSt2UnAGhIQs3BDwjtj49nagRM3M?=
 =?us-ascii?Q?hQe1NjqouMmLSf5nhzmTuJ4Zh4xWVbB1bS5XYcFA7btAyzzSVB01ce+UrKZw?=
 =?us-ascii?Q?uIhiJaXJKoaY8b7dZNt9pCClQ+xY4aTgSA/tQs6XEo6p49aPf456zCPiOSnE?=
 =?us-ascii?Q?mOsKwdwB842RbVS8F46QfE+0xFlQ5uwhFIVh1YjLgsZsqxPFa+nX9K4jrLEt?=
 =?us-ascii?Q?pEFRa3Zc3ptj+8buE2nl5yvVj8YIz/GzFBF9GU7Av3P6150S9ac2aD1SFjZY?=
 =?us-ascii?Q?UCsaRRnFKq4JFRhGHvpBzoc/r7wlIALSpDr91WRso7gjTbuOrl0kiqTurnaJ?=
 =?us-ascii?Q?bJ01lL/NPnqWz5JWYKoWZ2QLIVw4yA3QZdF0rT4KpIT5ReWEdqygj06+BBr0?=
 =?us-ascii?Q?n2BNdRi3D38TI/kfgIjiBLnzEh2I2Cc2bwHlK3/FvLZeoHXqS1Y2p5Y0nAr+?=
 =?us-ascii?Q?GoeHrGZfQxK7KmnlIbUJZR8v/dkO4R6aLrDYff+EIaSu4RCwjLXgL64M/iZU?=
 =?us-ascii?Q?LMdTqmkedhcOgg3MyZSGpubo4K7RFyRe61TWaovHRgRgvANlu6TCtHhw7+Xi?=
 =?us-ascii?Q?J/KCX9jcyuU1kNJixbIOmvCO?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 25cdebc0-7e1c-4080-eb98-08d8df9f7e59
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB2619.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Mar 2021 06:25:38.7780 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: f6pCgbkK/PWveTlAVQ7Hx6/TEV7T+3ZSArR1EcOYm65/G5/o5FBSfsuRdeqqIjQq
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3371
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
Cc: Alexander.Deucher@amd.com, Georgios Toptsidis <gtoptsid@gmail.com>,
 Evan Quan <evan.quan@amd.com>, guchun.chen@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

The "/ 10" should be applied to the right-hand operand instead of
the left-hand one.

Change-Id: Ie730a1981aa5dee45cd6c3efccc7fb0f088cd679
Signed-off-by: Evan Quan <evan.quan@amd.com>
Noticed-by: Georgios Toptsidis <gtoptsid@gmail.com>
---
 drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu7_hwmgr.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu7_hwmgr.c b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu7_hwmgr.c
index c57dc9ae81f2..a2681fe875ed 100644
--- a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu7_hwmgr.c
+++ b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu7_hwmgr.c
@@ -5216,10 +5216,10 @@ static int smu7_set_watermarks_for_clocks_ranges(struct pp_hwmgr *hwmgr,
 		for (j = 0; j < dep_sclk_table->count; j++) {
 			valid_entry = false;
 			for (k = 0; k < watermarks->num_wm_sets; k++) {
-				if (dep_sclk_table->entries[i].clk / 10 >= watermarks->wm_clk_ranges[k].wm_min_eng_clk_in_khz &&
-				    dep_sclk_table->entries[i].clk / 10 < watermarks->wm_clk_ranges[k].wm_max_eng_clk_in_khz &&
-				    dep_mclk_table->entries[i].clk / 10 >= watermarks->wm_clk_ranges[k].wm_min_mem_clk_in_khz &&
-				    dep_mclk_table->entries[i].clk / 10 < watermarks->wm_clk_ranges[k].wm_max_mem_clk_in_khz) {
+				if (dep_sclk_table->entries[i].clk >= watermarks->wm_clk_ranges[k].wm_min_eng_clk_in_khz / 10 &&
+				    dep_sclk_table->entries[i].clk < watermarks->wm_clk_ranges[k].wm_max_eng_clk_in_khz / 10 &&
+				    dep_mclk_table->entries[i].clk >= watermarks->wm_clk_ranges[k].wm_min_mem_clk_in_khz / 10 &&
+				    dep_mclk_table->entries[i].clk < watermarks->wm_clk_ranges[k].wm_max_mem_clk_in_khz / 10) {
 					valid_entry = true;
 					table->DisplayWatermark[i][j] = watermarks->wm_clk_ranges[k].wm_set_id;
 					break;
-- 
2.29.0

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
