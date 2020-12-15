Return-Path: <SRS0=Z3Jh=FT=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53B4CC4361B
	for <amd-gfx@archiver.kernel.org>; Tue, 15 Dec 2020 07:40:50 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id ED87D222B3
	for <amd-gfx@archiver.kernel.org>; Tue, 15 Dec 2020 07:40:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ED87D222B3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 66E676E15E;
	Tue, 15 Dec 2020 07:40:47 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2081.outbound.protection.outlook.com [40.107.243.81])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 124FD6E15E
 for <amd-gfx@lists.freedesktop.org>; Tue, 15 Dec 2020 07:40:46 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jayV7bLo4GldSnNlvvzJe5LmZcMNN1pgmHlLqK7NhNpHJCaz4/GOZsgqf7LHdLcdX7kkotJsBl4gzmKXr3DOneHi7bAxHFkHC3iqpNUEmmjGDhkZjfzqzOAgvKFwQeQruI+mx1jHBAQlTy0OMBIVMcTeSXQgYQa9CRFllNLl4B+mfoaE6idiP30hi8Mv8Ki5kggi+wKbBM4Wt5PtQoFOExUx4Tcg+RRBnH18gQH+FIOJWFT8pumFTozT8LEbpCeh7dxVBpzpjtjY1HVOnfsXVk/72VNCEGbPfiqFS4HnTDI63yT4aIQB0xlFjMdnpK+T12QPLhNttNd3lTCZTcHr8g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=U5+KhBoPkspNAWy0YTTLdXyACsFzymW79Csb9LrZfrY=;
 b=W0OaiY5oTDBEdkRZ/LJOj9/sd7jJLeUSMjQlkBuu+8bCse172FKWHHXv5vOrcP+P8DW48cELHsn3XKc85CSA/UOYJvxqdXXEQfNVLAjx07oVddZ9YxGygVg3B2aXOMJA11OfKYldKcW/O95nhKWv0tkMfPNZfWl7Cz5fnGNzuhpOorGApIJHweKO9TAzjky0HFnJaVD/uHbtRtmBxTyNYjGcS7kqebZTwn/XffnvHjvyqpWlOEVH7YSQTw/cHaCJ225qdvNzOzHcVSAKOV1F160D8x4ThDJ9LAiiVwRJvvnZeC8DasvojUwD48CHSyBWF6rsH+v6/CzpRHIrtQHsfQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=U5+KhBoPkspNAWy0YTTLdXyACsFzymW79Csb9LrZfrY=;
 b=PNLrltiPl+PdYEPuy4IDSw36jtaNcyIpz1bzD3GMCZiVqyi2YAwaIRCUDJMabGPs9FK4mAXiZ9lc5DMg8N4JJfcAt3a49n2GsfcvVnJjGvT5Lgq2eWk6RhKVUidFA6JOckOfPI5nw9o4yM4JjUaGhw+8hgb1t/RmdiAvijOVSE4=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from DM5PR12MB1657.namprd12.prod.outlook.com (2603:10b6:4:d::21) by
 DM6PR12MB3018.namprd12.prod.outlook.com (2603:10b6:5:118::11) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3654.14; Tue, 15 Dec 2020 07:40:44 +0000
Received: from DM5PR12MB1657.namprd12.prod.outlook.com
 ([fe80::481c:77dc:e670:1598]) by DM5PR12MB1657.namprd12.prod.outlook.com
 ([fe80::481c:77dc:e670:1598%9]) with mapi id 15.20.3654.025; Tue, 15 Dec 2020
 07:40:44 +0000
From: Xiaojian Du <Xiaojian.Du@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH] drm/amd/pm: correct the sensor value of power for vangogh
Date: Tue, 15 Dec 2020 15:40:19 +0800
Message-Id: <20201215074019.9317-1-Xiaojian.Du@amd.com>
X-Mailer: git-send-email 2.17.1
X-Originating-IP: [180.167.199.189]
X-ClientProxiedBy: HK2PR04CA0066.apcprd04.prod.outlook.com
 (2603:1096:202:14::34) To DM5PR12MB1657.namprd12.prod.outlook.com
 (2603:10b6:4:d::21)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from jenkins-System-Product-Name.amd.com (180.167.199.189) by
 HK2PR04CA0066.apcprd04.prod.outlook.com (2603:1096:202:14::34) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3654.12 via Frontend Transport; Tue, 15 Dec 2020 07:40:41 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 8ce3bca2-69fa-46e2-aff4-08d8a0ccbb05
X-MS-TrafficTypeDiagnostic: DM6PR12MB3018:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR12MB301818D4BA0CE23E47D7CA4AF1C60@DM6PR12MB3018.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3276;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: crRp7eLGwl5B7Kifjfbrirmbb7IwTLYrOZhQgbgyGRuq5eLhQTzxFYqj5hD8bza6OMH7+w7VKJppp/3/Vv4nyDaZov4U/UAinbLvd5yHVIKEmCB8wsJWMjrTHxjyh/jxl64OGMkFNRx0hAqkNjkqkTLjqCtOGlnWSgL0jmG5WDCxgIKV+aJ/lerscGcc2B658IByI0J4RlYWiQ8DSxbP1P5ttZ5ie3eFFmBPa1Lgnif0fhFXhEuqWb1a+qx+t9oKUrGvdbPtFpHFdOaO22WoxVOsO79fTDNtRFg5FbFDcUokJqMbfmeJxrKXmvcUm6TOIhy/tX5XwJ7EkYFuJZAsSPEZuRKYzrRa1lVXvIEHEP/zxlteN+UVYBmIetyOTH5c
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM5PR12MB1657.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(376002)(136003)(346002)(366004)(4744005)(66946007)(66556008)(4326008)(83380400001)(86362001)(8676002)(36756003)(8936002)(1076003)(2616005)(956004)(2906002)(508600001)(186003)(6666004)(34490700003)(5660300002)(16526019)(66476007)(26005)(7696005)(52116002)(6916009)(6486002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?HMa+Hln5uxib+drdzuUXj5xnW7gOg80sQwoI7gTxrXJGdaVFO5C8X9pJmA09?=
 =?us-ascii?Q?uXUh8+dQLz+4pQMuV8QLTvRXIwNbUthQfRzAkkFTvUeP16RNueV2vlVwztLc?=
 =?us-ascii?Q?+GLXlENBNZOfRyiLgze3tYlNbkmpNA/badW0Y8iWaqmJW435J0IKWRsacsdi?=
 =?us-ascii?Q?qYwVaaTqzm+kfLJwzGjiL7Nxa0uBbiPtVpuNJFqF/9G5+wlCCIErXKG36ScZ?=
 =?us-ascii?Q?48AZriKomU1aUGVvcaTcx46h5RglWxmRLasM9koQzdOgmVtUZ/2jkS3tpP6f?=
 =?us-ascii?Q?tDY5szBvCzdhDf2audOlho8z5eBJipbIhpPAFor4g0uVhWDqRwNk7nxeiGH2?=
 =?us-ascii?Q?jsRazgnVZwHvcEoUnKjsOF+8Nj/YkIP8FNeyya9SJw/I7xk32LsU0lnJhqj2?=
 =?us-ascii?Q?pWSYQBMg5ZmXIM7Z6kKXcGtZq1owfKjao0T/HFt0oLYZvD09xbTHNuy5zj2Q?=
 =?us-ascii?Q?hhsyMb+BGsiIV8pjz9W//n1EstxIQCPtuNtxgzcxvCMEGmc5LI9ymzEahCT2?=
 =?us-ascii?Q?MOU85KVmptOvu5pgfIXQC/b1ckYE4MQJ4CgkQzTt/3Wf/zQJwqa9mKP9k+Kx?=
 =?us-ascii?Q?eP5rq9240b32NbeG4JEcPwJm0xHc/fF4dzvF4nigAlO1Mj8B6KTvT/7CUGhv?=
 =?us-ascii?Q?Hk1S6+g/Cs3gmXzYcJTdU/mIOzi2Sxv3/EFfAFudug877h0dWaKMh59A9yUv?=
 =?us-ascii?Q?5KxDmPJHkxFOIdmDwVEdUKoA22W21qWaL/46kq/X8bPt3JHVJIhHJMy8y7Vs?=
 =?us-ascii?Q?pZsspRUvIdTuYYB34503tVO0LgGgW+4/Ty81aniQ2ndS6NdTovXZuikZzpXl?=
 =?us-ascii?Q?s9AYGzVTq300+XGR0yUtqFK8wbV7NU+e23vNjb/D38nSkrkZiby8eSAT+dSD?=
 =?us-ascii?Q?zloXtfKMXQ27PHz/pyOWA8RGFSAibEpQNt/sxai5cJJAQiS2bRiqfHc/j+AD?=
 =?us-ascii?Q?/qPcMqWJ5IZroLS9AhovO2oZ/AZI5Eboa1HfuJIoQ+gjIiPGoxkdy7Hl7Ift?=
 =?us-ascii?Q?Y9mh?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthSource: DM5PR12MB1657.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Dec 2020 07:40:44.3690 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-Network-Message-Id: 8ce3bca2-69fa-46e2-aff4-08d8a0ccbb05
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: igHVmCFafuPpMpJgNB1Auq+AegvTKu2feOUfEhuFxjCCBFVSUBZuUS76Wwy1zJj4G5pTtNelFIJXDD3UKv/X4A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3018
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
Cc: Lijo.Lazar@amd.com, Xiaojian Du <Xiaojian.Du@amd.com>, kevin1.wang@amd.com,
 xinmei.huang@amd.com, ray.huang@amd.com, Alexander.Deucher@amd.com,
 evan.quan@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

This patch is to correct the sensor value of power for vangogh.

Signed-off-by: Xiaojian Du <Xiaojian.Du@amd.com>
---
 drivers/gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c
index 9bccf2ad038c..a33c1e07c5df 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c
@@ -252,7 +252,8 @@ static int vangogh_get_smu_metrics_data(struct smu_context *smu,
 		*value = metrics->UvdActivity;
 		break;
 	case METRICS_AVERAGE_SOCKETPOWER:
-		*value = metrics->CurrentSocketPower;
+		*value = (metrics->CurrentSocketPower << 8) /
+		1000 ;
 		break;
 	case METRICS_TEMPERATURE_EDGE:
 		*value = metrics->GfxTemperature / 100 *
-- 
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
