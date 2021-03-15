Return-Path: <SRS0=AQd/=IN=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.0 required=3.0 tests=BAYES_00,DATE_IN_PAST_06_12,
	DKIM_INVALID,DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5EDF6C433E0
	for <amd-gfx@archiver.kernel.org>; Mon, 15 Mar 2021 11:23:46 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2070460C3E
	for <amd-gfx@archiver.kernel.org>; Mon, 15 Mar 2021 11:23:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2070460C3E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D7DEC89E26;
	Mon, 15 Mar 2021 11:23:45 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2044.outbound.protection.outlook.com [40.107.237.44])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9F71589E26
 for <amd-gfx@lists.freedesktop.org>; Mon, 15 Mar 2021 11:23:44 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=O73qYnfYTau0QlpjGwAvN05fw5etN4PGV6fsSz3nrw7hS3TlyvNyuTp5k9ieAeBt3t+RzV71NcHNr4aCXG/d72e5CwgwOxHVsYyKqcciFmHve0A6vz9+6ahD6QYDf1Vtq8bM0ldDTry3lGktPHPDikp0p5H8FVvF59qYgXukDV6Z9pZ9onqiWUa/vzYOBHgvGA2APHhC6/IKc+X9uqjPAWZWhv0PBRTS0RCUyhg9iqB0jgjZeWU9oSFP1DEd5ZMkntSKNrkNb4ngJvxvv9Vk50lUqMWpnhYDheTzbpygDONJAptGOpzAQSy7cIxgRo3wVDzj7zpgfy8OarvsEAjwYg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TJsmNATIF+FURCMftKA/VOO4Xapq+MHs/GFB8EkOLEQ=;
 b=EhmovWnDIJF6A+RDsm1tmhYYT7p3NLT0yfv8jZdTqqngRX6jpwWTH0Rk1JnWWB7PGaKr+H9xeNUjKMUW1EfnQ+8fSZ592kGk6BSto+SntbzwyywUY42CbyLkYIUl8rpPVc03Zf/8taaWSHtkqfi+wmFoF3I4hh+mEwKPafPDWNuS1dKZ0EzIb/b0ylA7l4vfRjFr2dG22/isqgKX8jBUaAcFFpM+4xToORgMnZtzeZhPkQMwdyjjlh6qIcB4uTHvcgeDIasam+d696bUGCa0U9Bf0t8WMOSgxd8a5/HeXWnysKVsOQOCOq/btv6wIsQYzfQS4v2mtNTr0sVKEfnGQA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TJsmNATIF+FURCMftKA/VOO4Xapq+MHs/GFB8EkOLEQ=;
 b=XZqeJBxVmZK0YDqdTT9I8+E80GHsTJixFz0miukbW99fc+O5O4OCLfzFrmMuc5j0i1Q4cEQP1z+rnUxBTNJ0vrm3rqZYyCJQOYj6d+1a4QLjbYKPHwfG3hipd3i1fjbhKBPlCF60wRpq7QulgGsFcIGTWGR2L8XczgDfG75Oqx8=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB2604.namprd12.prod.outlook.com (2603:10b6:5:4d::15) by
 DM6PR12MB4617.namprd12.prod.outlook.com (2603:10b6:5:35::24) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3933.32; Mon, 15 Mar 2021 11:23:43 +0000
Received: from DM6PR12MB2604.namprd12.prod.outlook.com
 ([fe80::1c30:5644:fcfa:a1a7]) by DM6PR12MB2604.namprd12.prod.outlook.com
 ([fe80::1c30:5644:fcfa:a1a7%7]) with mapi id 15.20.3933.032; Mon, 15 Mar 2021
 11:23:43 +0000
From: Solomon Chiu <solomon.chiu@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 20/23] drm/amd/display: fix dml prefetch validation
Date: Mon, 15 Mar 2021 09:40:07 +0800
Message-Id: <20210315014010.16238-21-solomon.chiu@amd.com>
X-Mailer: git-send-email 2.29.0
In-Reply-To: <20210315014010.16238-1-solomon.chiu@amd.com>
References: <20210315014010.16238-1-solomon.chiu@amd.com>
X-Originating-IP: [165.204.134.249]
X-ClientProxiedBy: HK2P15301CA0002.APCP153.PROD.OUTLOOK.COM
 (2603:1096:202:1::12) To DM6PR12MB2604.namprd12.prod.outlook.com
 (2603:10b6:5:4d::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from LAPTOP-K5LN3AJ2.localdomain (165.204.134.249) by
 HK2P15301CA0002.APCP153.PROD.OUTLOOK.COM (2603:1096:202:1::12) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id
 15.20.3977.2 via Frontend Transport; Mon, 15 Mar 2021 11:23:38 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 2ccdeb53-c905-4903-1d00-08d8e7a4ca59
X-MS-TrafficTypeDiagnostic: DM6PR12MB4617:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR12MB46177C57C6D66D2D68B103C3976C9@DM6PR12MB4617.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:843;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 2bOk3VCdLtz+FIpqaxkSYiMcTStAabSxDv4I9QzEu8iu01NaPmy+VQ7CKFvu4u0M6rs6Xll/QyoKC7Vu78eNnCAhwp48oSNrzpqnfS7Sv+JBcysRQznMbq3n7sL130sK6c6l28nAZDOovTyHQSGmAksjUUHdqwF2hERHzgFOXlBgGA8hwh8mXCL1j4nmi1GDU1i52P5j+TnIumy9Om2mElgYTd/ZtJUgK4wHShPk35r/STjHbiIDVwuptaTbeZlyHcu4R0W6Z9T0IuY7cnX5jA8Mu5j9MffhuiAekZncV+2Y5aR/diMP7ZGUr14g0/pEuJ8Ij14TvSk/Jg408Ga6uL1TRDYJP3La0DkCTiLQ3db/NOtwKe9HlTO4ygnNUKe6R4DcW4j4v5Vm/Ccdg/iNvqbF5qy7k+TvACMor6N8fdYOBcOvcgSIiZ+pDiBYjxdeKM6VSyUsOzwW690gVb/lHSx0ko+UnrtH1mfQUo1F9hX4qEEiv31JNDdvZZxPxosyMWhtdbHzrgeuioUBD+AfJ/ynB1CwqT2GUt/4MGGL7NIkE4sBAu/v8q2eL8pNVM9wA7ujqAdAqKsuYmMEHjcqyzA5GMTgrsegdCKAQa4doL4=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB2604.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(346002)(39860400002)(136003)(376002)(366004)(396003)(8676002)(6666004)(54906003)(8936002)(52116002)(4326008)(86362001)(5660300002)(316002)(186003)(16526019)(26005)(83380400001)(2616005)(2906002)(6486002)(6512007)(66946007)(66556008)(36756003)(6916009)(956004)(44832011)(66476007)(6506007)(478600001)(1076003)(44824005);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?9NP897KYbjJaOm9Jz5QrsVFeyDIyhQSQGTesqueaIt3Q4DxPjIpRq9s2ZGAl?=
 =?us-ascii?Q?fkjYmQjfO4Ui3rj6wW34Z8nSb8ZbTkTeNnG1EwODLVDmP3A9H2hGnGJFW/k/?=
 =?us-ascii?Q?wmq5EMWPjMNdqK0RrWhbaU+70mqysm9hzcFt6LHm6kcXA3lKl706Bh7O84SJ?=
 =?us-ascii?Q?s+kmr/i0gMSZHP8JD8hXGi36azwQbXaIz33ekVaWDzURP3gxoa0BSdJ8dnqs?=
 =?us-ascii?Q?qXzq2UgbbenRWCtpMF2FcDsu1yJN2Ihztwai5aLulR80Dm8GdeEikabor+X3?=
 =?us-ascii?Q?JqirGxASw2rgTOEnpr1dvlvvvjPMZT1BA0eyNwfd4sel03u7DTPL42F7fsrN?=
 =?us-ascii?Q?xq/2BaG6ShRQy2shOrtpvjCc4cY3OLBZ1mBakCpXhNlcDkigJSKhZWiNL91q?=
 =?us-ascii?Q?KJYslNp1t8+TyvvuYlxTzw16InlrPa5h/cjL5L/Z0PMepDCiwkAmda+jb37l?=
 =?us-ascii?Q?LjevIRdMDjRU4AaoXDE28vDhKU4KjtDmTkfCsT//Z8EJ7F3VUtwFMmCrZX2U?=
 =?us-ascii?Q?Q/hbUOPYE8+AUZEoRHd4pB4NQ2vtQ05WjeQPj3Xjvz58bNaXkXp/k6o5nuSb?=
 =?us-ascii?Q?DeycyXddYfJ+P4DC3o+8aaaMi8ww9Z7meAPf+G8vUQ+oKSXKlBw0i+2OoVUu?=
 =?us-ascii?Q?/RFMX/RE+ZpSLVoF1DVZI4cZvvwGG98O4DGWqK142e1DcuTXXXSW+lvAif/O?=
 =?us-ascii?Q?MmVjluA9jKFl3HhtA7Y6zvufdODDsvhIsJTiAvbwtdNAnEBT4hykjbwe40py?=
 =?us-ascii?Q?refDV4p0tKJbOoGBw1WZQ7RhdudEASzjq0NdCMjqbnPL1Pwqt4IkcLtVq56u?=
 =?us-ascii?Q?aKPiRfR5KpgHKyiqO0Aq43o5nPwc3HNspQ5YoWfuOuOD6Br+Q3anDrujnRUj?=
 =?us-ascii?Q?0f+ecvJSrsNQPi3Et9obtOUM0ySXP310W4zQ0VGD+7sjRWxgm2Pi6/G4/e8R?=
 =?us-ascii?Q?Li68eafSoa0nofp452qBfY5S/sEeml+XoDAiQeUTdDao6pnYEXiQRY7DxhBr?=
 =?us-ascii?Q?9/ybMcaMXIf38l0jviFsZ/5GJj1i164lzJIvjeLL4wO1fXtupBmGZ3o1bNPQ?=
 =?us-ascii?Q?jcHm2vUKQqI9dUvWjq1sDKkW/xAZ2zgbH/lbJkzNMLKgumir7F3nZsLhBpC4?=
 =?us-ascii?Q?L8xsIDT1eZ1LklopmImX6Ml1TC4bVcZU8uzwkCQj9BaFOJdKOM+BbC0R1yYO?=
 =?us-ascii?Q?xqYHFkRfZHk4Cz5uHL1FMksR0ZLEe9s8eUrnUk7nmPr1ZONynN9UKkxDVjze?=
 =?us-ascii?Q?6MTHAaz39ObLjW0QYIgWTCOmhgG89HpFjs8RLHemZ2fkX8Jye95jj96+i5LP?=
 =?us-ascii?Q?4rqwAAHhkf/3cOQ8ZRbB+At+amXJBV6MUVCQSVBvaJHWUw=3D=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2ccdeb53-c905-4903-1d00-08d8e7a4ca59
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB2604.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Mar 2021 11:23:43.0924 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: iKfXQru/KtZ/PghfPV1Rp/6amPJpV1AalrmaJwuel/n3TQPGQ4PO+kYD1DgI1oBRAELBtRC1zdS12Za/NMqhJA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4617
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
Cc: Dmytro Laktyushkin <Dmytro.Laktyushkin@amd.com>, Eryk.Brol@amd.com,
 Solomon Chiu <solomon.chiu@amd.com>, Sunpeng.Li@amd.com,
 Harry.Wentland@amd.com, Qingqing.Zhuo@amd.com, Rodrigo.Siqueira@amd.com,
 Anson.Jacob@amd.com, Aurabindo.Pillai@amd.com,
 Eric Bernstein <Eric.Bernstein@amd.com>, Bhawanpreet.Lakha@amd.com,
 bindu.r@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Dmytro Laktyushkin <Dmytro.Laktyushkin@amd.com>

Incorrect variable used, missing initialization during validation.

Signed-off-by: Dmytro Laktyushkin <Dmytro.Laktyushkin@amd.com>
Reviewed-by: Eric Bernstein <Eric.Bernstein@amd.com>
Acked-by: Solomon Chiu <solomon.chiu@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dml/dcn20/display_mode_vba_20.c   | 1 +
 drivers/gpu/drm/amd/display/dc/dml/dcn20/display_mode_vba_20v2.c | 1 +
 2 files changed, 2 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/dc/dml/dcn20/display_mode_vba_20.c b/drivers/gpu/drm/amd/display/dc/dml/dcn20/display_mode_vba_20.c
index 0f3f510fd83b..9729cf292e84 100644
--- a/drivers/gpu/drm/amd/display/dc/dml/dcn20/display_mode_vba_20.c
+++ b/drivers/gpu/drm/amd/display/dc/dml/dcn20/display_mode_vba_20.c
@@ -3437,6 +3437,7 @@ void dml20_ModeSupportAndSystemConfigurationFull(struct display_mode_lib *mode_l
 			mode_lib->vba.DCCEnabledInAnyPlane = true;
 		}
 	}
+	mode_lib->vba.UrgentLatency = mode_lib->vba.UrgentLatencyPixelDataOnly;
 	for (i = 0; i <= mode_lib->vba.soc.num_states; i++) {
 		locals->FabricAndDRAMBandwidthPerState[i] = dml_min(
 				mode_lib->vba.DRAMSpeedPerState[i] * mode_lib->vba.NumberOfChannels
diff --git a/drivers/gpu/drm/amd/display/dc/dml/dcn20/display_mode_vba_20v2.c b/drivers/gpu/drm/amd/display/dc/dml/dcn20/display_mode_vba_20v2.c
index 210c96cd5b03..51098c2c9854 100644
--- a/drivers/gpu/drm/amd/display/dc/dml/dcn20/display_mode_vba_20v2.c
+++ b/drivers/gpu/drm/amd/display/dc/dml/dcn20/display_mode_vba_20v2.c
@@ -3544,6 +3544,7 @@ void dml20v2_ModeSupportAndSystemConfigurationFull(struct display_mode_lib *mode
 			mode_lib->vba.DCCEnabledInAnyPlane = true;
 		}
 	}
+	mode_lib->vba.UrgentLatency = mode_lib->vba.UrgentLatencyPixelDataOnly;
 	for (i = 0; i <= mode_lib->vba.soc.num_states; i++) {
 		locals->FabricAndDRAMBandwidthPerState[i] = dml_min(
 				mode_lib->vba.DRAMSpeedPerState[i] * mode_lib->vba.NumberOfChannels
-- 
2.29.0

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
