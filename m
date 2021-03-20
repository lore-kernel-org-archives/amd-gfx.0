Return-Path: <SRS0=4T84=IS=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99FE5C433DB
	for <amd-gfx@archiver.kernel.org>; Sat, 20 Mar 2021 04:19:18 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6280961979
	for <amd-gfx@archiver.kernel.org>; Sat, 20 Mar 2021 04:19:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6280961979
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2C5AC6EB25;
	Sat, 20 Mar 2021 04:19:18 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2049.outbound.protection.outlook.com [40.107.93.49])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B457C6EB25
 for <amd-gfx@lists.freedesktop.org>; Sat, 20 Mar 2021 04:19:17 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MyYfS4seUy4bNjTzkrdqKFs9fzPyvKHuSYhgI1V9eEk8VIFe8oRrE4mEYpGJCSjCQzmHjcUUZBgN4tmjOIE29zXGc3pPalZ8zv9ryQD+aW/ri/Tvqx/DSYrcwZEIaJudP36VwMU1r+oq0Ek726K9dGna3DT+WM5yntS4QDJTDrZJP7gDEzOltJO+6G3afT2qsGbQyzh/VHCiPpvTkly35V6ZvAdbQ4PCIgPxncuymDFpjlXX9f8kbnax40IiTc4HZvTJ2co7vKUkNs1LYllIpPGiS+5FJnxXbKkwW40o6aFo9wvLbRtF5bL+GEJ+GTTPon2uO0J3L9mrzTURwtV49w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xV70kfLf+9JHjDcYJv9tpqGEbQ4I+0YgF1KGmCr1tt4=;
 b=CaD1s34QBIJbPOVIXQN+Ah9SveoUVMp7jKPfF4zIqAuYWTu+8nbM2si41NNzJmb8+1cS/yhCcbbJG90kpyMrJrwAX1DizJOcUiTpKTl5Ni4u9ZWG3BcFtPpN/SSOhpaIzhu+yF7gT/DiVHv32VrwS4VvPFEMH/JnPevh2LSp/x6fjdyuUSjnzfD32aJ3dx/x5svKYE3lYq4BcckHI4nScFOkPMHSx8ZrhTtDFhcqXtAoiOMD1Z9LTbU+3xUWvPOzzVjxT62ciE9kzZOJgmbCQyA7N0VTu8lTVyVvQsLmytn7Bg3W/OctxoEMtgQYwBfXBBaM1bWw3ZdpRv0q4aX4Qg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xV70kfLf+9JHjDcYJv9tpqGEbQ4I+0YgF1KGmCr1tt4=;
 b=lk+oGBsPypF1jy8+z1Ig+QzH0wfDB7hcCx0py30mdkrV+TR3cEq3z4RSgijuRia7TBIPk9PZ+GEYplCdidnn518N7w1pzzMLXsrWFN6otoDuno5FyqEMWbw7VmuAYAdMBMOfU71zRluZ2V9/gJ/TVyaVXfFqEzlYk5E1Q534MaA=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from SN6PR12MB2605.namprd12.prod.outlook.com (2603:10b6:805:6a::11)
 by SN6PR12MB4704.namprd12.prod.outlook.com (2603:10b6:805:e8::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3955.18; Sat, 20 Mar
 2021 04:19:15 +0000
Received: from SN6PR12MB2605.namprd12.prod.outlook.com
 ([fe80::5c4e:1bdd:5eed:b2d1]) by SN6PR12MB2605.namprd12.prod.outlook.com
 ([fe80::5c4e:1bdd:5eed:b2d1%6]) with mapi id 15.20.3955.018; Sat, 20 Mar 2021
 04:19:15 +0000
From: Solomon Chiu <solomon.chiu@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 08/14] drm/amd/display: Deallocate IRQ handlers on
 amdgpu_dm_irq_fini
Date: Sat, 20 Mar 2021 09:46:50 +0800
Message-Id: <20210320014656.23350-9-solomon.chiu@amd.com>
X-Mailer: git-send-email 2.29.0
In-Reply-To: <20210320014656.23350-1-solomon.chiu@amd.com>
References: <20210320014656.23350-1-solomon.chiu@amd.com>
X-Originating-IP: [165.204.134.249]
X-ClientProxiedBy: HKAPR03CA0030.apcprd03.prod.outlook.com
 (2603:1096:203:c9::17) To SN6PR12MB2605.namprd12.prod.outlook.com
 (2603:10b6:805:6a::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from LAPTOP-K5LN3AJ2.localdomain (165.204.134.249) by
 HKAPR03CA0030.apcprd03.prod.outlook.com (2603:1096:203:c9::17) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id
 15.20.3977.9 via Frontend Transport; Sat, 20 Mar 2021 04:19:11 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 0b1fc3ac-6c74-43c7-4689-08d8eb5752a0
X-MS-TrafficTypeDiagnostic: SN6PR12MB4704:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SN6PR12MB4704EE624C39D6256DF096D197679@SN6PR12MB4704.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:541;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: anDqr9FIxi/D3JJ8Y86qE0WGkoGeXcHDRs5oV6gFVQpzntQ8Ps3IDp9eUnbWV5NAD3pBonIMN0F8F5PayOlsefv9pyBmYKOkj2bJfgdYN7Zx4T3IeqIiQuJSM6stp5VWLAJUidEiKEpWm/IGmbQwM+AisWJTT8BrWcLwMS06vWpgHnVZNFqUHDM53Q64QAk5n9RzvsDf8PrrjkF7TcZHs5R1RHMqX6eNfcqkHyOcYRhocwbGft6RrS/W3TvOCpjq83zVutSiHkHOkD/hPDYE7NlWgK8EE50cT+WpSjvuGquzlwL8VU7iYBFcUpYWVjAlNymURztw6an5AoZNvGveT0kCqZu7cSDjutW2jyGf92Aq9OWqHAgpS8f2lMXTmeFjtwbSdvfiftHIbuNhXWyrWsA9QkteZyylSc/IaEm6SNWC/4QTA8zMGDN+buLgWFtWxW8PqCsWjYGdINYF+IXM0nBxUiDIvwAgcMYppuo9ivivAdAZi16IaJh1nR1rWQwQBAtoyKET9aEmTI0mx7d9NChMgXe/7PtoMANY0PGkriUHLPZKnKeP4S9TS/1CJNPChOem+skqy3XYKPkL2czOCz1PPxU957TX2c8f7bxwR+VG+idGCGAKSJ179/8vDel/NxxMXXP+bwFyDeoHJP5uznCSXK/yMObETedaPTom+Jk=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SN6PR12MB2605.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(346002)(366004)(39860400002)(396003)(376002)(136003)(8936002)(6512007)(44832011)(6666004)(26005)(478600001)(4326008)(8676002)(52116002)(38100700001)(36756003)(316002)(86362001)(6916009)(6486002)(1076003)(2616005)(54906003)(83380400001)(5660300002)(66556008)(66946007)(186003)(956004)(16526019)(66476007)(2906002)(6506007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?2PMUeVLnEogiI6mQvDb7oZLDQiAgd5A1OGmD3lhfwJUJOofMWElYlTAYK6kI?=
 =?us-ascii?Q?RfHyM70oeIO1/Nu0S/OOy2a27QtwHDO5icha5C7tQfTgJa59JGjbGTtek3Q8?=
 =?us-ascii?Q?QCSfZdLDoBM13IVtbXqm9CLVJabg6KcgNWVT734FhxBrj+ZSadulvVhgSTDC?=
 =?us-ascii?Q?war9g2DSJXqJ+SeDKIGHdBi2ZiHq1qJdrIW6N3PLGluUbvylH5RVVDhqWKmy?=
 =?us-ascii?Q?7LVNA9wQgDNUCjBt28/HhKktqk41ieH83VMSFTY6bAczJDRSFF0R1OVoB+/i?=
 =?us-ascii?Q?eoAqudeqrsFqxbHED6TLbzV2mxH3wdgMWREOVpaqjUe6oddrNfY1PPXuAUqE?=
 =?us-ascii?Q?jbyv4nEse/8ckdGVK5U+EgH4g3r+eaKkE4aX3bTnVotPwW3rC7f5/v2Um1HD?=
 =?us-ascii?Q?ze6o8tUA0gfML+qFhJ3s69gjTPcuOAm0hIb2CGAxpiKILDdlHrx43na6SBet?=
 =?us-ascii?Q?sfMNe7X+NEF/BwtYfil4lzPBi8X3u1afXCqtWkp8Pk3xA7By4FNIsG2ceOCb?=
 =?us-ascii?Q?YZsJMr7fxThVWaJSWDL1XREZUpCGVLJnRRb84N+lhhEsBTVPFO5BK1Zgq+Uv?=
 =?us-ascii?Q?FU9Kbyiz+wdvjFezbQ2wIfom9+bkr/+Ps5KA2JAt6oTXgYhJEQU8H1Ucv0GB?=
 =?us-ascii?Q?dEJsi/i5ECNfm9Dz5mF4GsT8r/kIASLpYTIsZ0MB1INkguk1ENRqEXfmOd+r?=
 =?us-ascii?Q?eFLKMM0M13LBS86t95h4FaXy5P63EeXtQIu51gWy+oU3ryouorQgETzp+pCB?=
 =?us-ascii?Q?dCBUBJP3KbYirf9ktRCO08K1lKrL58tAwMvdKxMpVUoi8jnWT9lHxlMJOo4u?=
 =?us-ascii?Q?BKc3VS87vKVs6UsWYOqm5QfuBpu+Yx7wSCU+uIziiLuwWTnmhMa20nr9LVaM?=
 =?us-ascii?Q?60MGzIdfzqPizXXqHeGBSKVWUjzHpwwNTGFYSkP14iFGoCiKelss7afJTsMz?=
 =?us-ascii?Q?3h3BHSggmKUhRb3nltmEy/hi0tnVJl6ZTkajhF9A+fS8hvcOWiNQkSU25DKW?=
 =?us-ascii?Q?eGX18Btap5HDz8XR2YblGWygyiPRv81Czk4bnQ5jzsOgttZh/lkdoVpmux4D?=
 =?us-ascii?Q?mkmjMxNZtB7UmjQR0DLmtvjQznsmFlH0YA05cy+4db9n8hL0LOysjKwFxeX5?=
 =?us-ascii?Q?8eWwItUbkAb83xGRLdscUt6TZaKYZ8NZsA3s3m80YqYLR23+hrwLzIOIYl22?=
 =?us-ascii?Q?1SvMH19Rp8uGnsqrLIZkXAbPb54wbUeTlFLdHie9zvJkER+wdJnaodzB5y68?=
 =?us-ascii?Q?ergq1NqVa46QbDyqUsmHZOnV2rDBWlME6iWcQoFI/XbqxGdgLt+gYDuJQg53?=
 =?us-ascii?Q?v8WIDdE6+Y2JnT7sgo2huWvt?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0b1fc3ac-6c74-43c7-4689-08d8eb5752a0
X-MS-Exchange-CrossTenant-AuthSource: SN6PR12MB2605.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Mar 2021 04:19:15.6711 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: isV1bcW3Yqa9dkxwTWTLyVcIm85V5CUCUu65csGBXzrpYJzyzVo9dmz+RwzhAF3uUoNNGOQF21bajIk3BUZk8g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR12MB4704
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
Cc: Eryk.Brol@amd.com, Solomon Chiu <solomon.chiu@amd.com>, Sunpeng.Li@amd.com,
 Harry.Wentland@amd.com, Qingqing.Zhuo@amd.com, Rodrigo.Siqueira@amd.com,
 Roman Li <Roman.Li@amd.com>, Victor Lu <victorchengchi.lu@amd.com>,
 Anson.Jacob@amd.com, Aurabindo.Pillai@amd.com, Bhawanpreet.Lakha@amd.com,
 bindu.r@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Victor Lu <victorchengchi.lu@amd.com>

[why]
The amdgpu_dm IRQ handlers are not freed during the IRQ teardown.

[how]
Add function to deallocate IRQ handlers on amdgpu_dm_irq_fini step.

Signed-off-by: Victor Lu <victorchengchi.lu@amd.com>
Reviewed-by: Roman Li <Roman.Li@amd.com>
Acked-by: Solomon Chiu <solomon.chiu@amd.com>
---
 .../drm/amd/display/amdgpu_dm/amdgpu_dm_irq.c | 51 +++++++++++++++++++
 1 file changed, 51 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_irq.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_irq.c
index ffd18cd90947..da2703a04e23 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_irq.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_irq.c
@@ -184,6 +184,55 @@ static struct list_head *remove_irq_handler(struct amdgpu_device *adev,
 	return hnd_list;
 }
 
+/**
+ * unregister_all_irq_handlers() - Cleans up handlers from the DM IRQ table
+ * @adev: The base driver device containing the DM device
+ *
+ * Go through low and high context IRQ tables and deallocate handlers.
+ */
+static void unregister_all_irq_handlers(struct amdgpu_device *adev)
+{
+	struct list_head *hnd_list_low;
+	struct list_head *hnd_list_high;
+	struct list_head *entry, *tmp;
+	struct amdgpu_dm_irq_handler_data *handler;
+	unsigned long irq_table_flags;
+	int i;
+
+	DM_IRQ_TABLE_LOCK(adev, irq_table_flags);
+
+	for (i = 0; i < DAL_IRQ_SOURCES_NUMBER; i++) {
+		hnd_list_low = &adev->dm.irq_handler_list_low_tab[i];
+		hnd_list_high = &adev->dm.irq_handler_list_high_tab[i];
+
+		list_for_each_safe(entry, tmp, hnd_list_low) {
+
+			handler = list_entry(entry, struct amdgpu_dm_irq_handler_data,
+					     list);
+
+			if (handler == NULL || handler->handler == NULL)
+				continue;
+
+			list_del(&handler->list);
+			kfree(handler);
+		}
+
+		list_for_each_safe(entry, tmp, hnd_list_high) {
+
+			handler = list_entry(entry, struct amdgpu_dm_irq_handler_data,
+					     list);
+
+			if (handler == NULL || handler->handler == NULL)
+				continue;
+
+			list_del(&handler->list);
+			kfree(handler);
+		}
+	}
+
+	DM_IRQ_TABLE_UNLOCK(adev, irq_table_flags);
+}
+
 static bool
 validate_irq_registration_params(struct dc_interrupt_params *int_params,
 				 void (*ih)(void *))
@@ -414,6 +463,8 @@ void amdgpu_dm_irq_fini(struct amdgpu_device *adev)
 			}
 		}
 	}
+	/* Deallocate handlers from the table. */
+	unregister_all_irq_handlers(adev);
 }
 
 int amdgpu_dm_irq_suspend(struct amdgpu_device *adev)
-- 
2.29.0

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
