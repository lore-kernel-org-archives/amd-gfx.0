Return-Path: <SRS0=AQd/=IN=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.0 required=3.0 tests=BAYES_00,DATE_IN_PAST_06_12,
	DKIM_INVALID,DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4EE36C433E0
	for <amd-gfx@archiver.kernel.org>; Mon, 15 Mar 2021 11:22:24 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BC5F664E61
	for <amd-gfx@archiver.kernel.org>; Mon, 15 Mar 2021 11:22:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BC5F664E61
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 749828881E;
	Mon, 15 Mar 2021 11:22:23 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2041.outbound.protection.outlook.com [40.107.237.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8248D894D4
 for <amd-gfx@lists.freedesktop.org>; Mon, 15 Mar 2021 11:22:21 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ej/zmKAxnGVyDRjajCIEnSMwB7gTd9UNLjbZB1kbtQAU7VItnXHflnjsRg5qKc9l5/7IwmZj3MhY7LWGsQYaNHTI9e0uzwuqv3lLndeMhEFenBECUkGDyDlvLjMxw6yLOVEjFi8n+g4lBaIm8D9kWVK8YX0jAGBBpHUapIC8DiJK0G63ixwnDXod+2JMK3gt7GZzsYnPv0fVSqMc4ewJMoJoiULYTiEry9l4B92/eZjKi/dnXbigv/1nRl87pKF7lmaphl5+3jEPLMTmjFLvXrbGM8o8va3hZ85w4Jrcj6EcXyuDSxlDWng7rRITv8umEkhYRl2kiHVvqzjA701+tQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ySC2qY9u4bH4MLgHDWaHoPu8woc9d80J4CrPAHEX4FA=;
 b=hynb/PY3/7G1mVHE0FyFU1nlWZPTCHGWu9kWCEHPWOzTaMwyJwDFDZFZxEk8ojkTEW18pX575k9vna8L8jgpOmf47hjNI48P10KI5AM20ZPDHW3voYVdLwwOKlOaArwtdiB9YPmJnHvYkMeixm3CxVHecJpC7l30kGnOdQh02I/AwyF6BC8QAbc4/5JTWoc+YHQkn2riL23l1wLMqiWv5Xv7GlhIeH3SryJ+2rYrgciNMGZLFO0qL9mAN9ffPvFDjRH5SadUPZiIhdwMZZ9Tn9T9LovFgNvYo3g3ilAXND2m3IRQFDYJaKCeP0ZSDbtu6TkBCWE8nmepXzlQQ0gFMQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ySC2qY9u4bH4MLgHDWaHoPu8woc9d80J4CrPAHEX4FA=;
 b=u67p5Y2b/XiqBd6MWTewwsvtrYWA2dgrr3zSFuXxTOaLbI1mvmxDobew+sfQTjErh8XPG74h9r+IQFBFxOY4rCeu1LrCfdagb+kPDjuFZ+VlIPPhzxcR/Tvj5LohZjjhGAwmUVVxfB+0A6A67f73/6sowoFll20KQO8iVxnGj9o=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB2604.namprd12.prod.outlook.com (2603:10b6:5:4d::15) by
 DM6PR12MB4617.namprd12.prod.outlook.com (2603:10b6:5:35::24) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3933.32; Mon, 15 Mar 2021 11:22:19 +0000
Received: from DM6PR12MB2604.namprd12.prod.outlook.com
 ([fe80::1c30:5644:fcfa:a1a7]) by DM6PR12MB2604.namprd12.prod.outlook.com
 ([fe80::1c30:5644:fcfa:a1a7%7]) with mapi id 15.20.3933.032; Mon, 15 Mar 2021
 11:22:19 +0000
From: Solomon Chiu <solomon.chiu@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 01/23] drm/amd/display: 3.2.126.1
Date: Mon, 15 Mar 2021 09:39:48 +0800
Message-Id: <20210315014010.16238-2-solomon.chiu@amd.com>
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
 15.20.3977.2 via Frontend Transport; Mon, 15 Mar 2021 11:22:15 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 78d7f683-c09f-4502-2714-08d8e7a4988f
X-MS-TrafficTypeDiagnostic: DM6PR12MB4617:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR12MB4617E63EE6D70FF084A8A12C976C9@DM6PR12MB4617.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1079;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: adgztetBB1Hj04gBLHiXoMOJAwJqGoy9+l1SGKA0FPRkvyl0Mj7FKmDfAxqQCz2UDStqdkbz3Y/OJ28trulB1rXlz++Nwr2WxeSZc+k3pTdbJeOweyA16qLeAbHIO7b6WeFeuQHvQRHKth7yTcYBcoB9dDfV04fZerjoT7cL7li4MPYyaowxuZz8SyhalSINgR+520RUX9/lZJlMMi6vnVC2jUCbS9r+geYmJvDuzfqYaFgYQRT0inrNiZoHmCSrryY7Gl7nFdpW2KZMgX33Kwju0ulm5nuTok6GnRljH2J/BrnMRl9i6TZhPNTBEokQSc0r6F3BmElHlWSrr0R2EIvW/U8mNXlN55rBkzAzX8G/vTgyrSb0kMpZd8upWDgN89zzZ6TWXwzHY3B1ONyyKnmyxcRjJdTXEiaRiaWYZ4WZlZINBxPPL5v2TBcUlsUBOGgJidCekyIKc6HeNY7KiaiDURSJVV+yE/au25jqhvapMbBcan9DUww6T6jQLvC6FjvMA5hCTH6qC/+stJ+H9Q9bUc4bpTWk6V31bLADVqYahFhMz+q/E9depmNc4VOh
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB2604.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(346002)(39860400002)(136003)(376002)(366004)(396003)(8676002)(6666004)(54906003)(8936002)(52116002)(4744005)(4326008)(86362001)(5660300002)(316002)(186003)(16526019)(26005)(83380400001)(2616005)(2906002)(6486002)(6512007)(66946007)(66556008)(36756003)(6916009)(956004)(44832011)(66476007)(6506007)(478600001)(1076003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?0KcZazekMHilY1mfwIgKALWT6XE4rPLN0kjn0p45kvpj1bx/3EwTmnL60kw1?=
 =?us-ascii?Q?L8PRwAkpsKqcZM9nh7eDv+A68kTve53WdNcT/ESjtfztn7vkO9T1yKrbzE//?=
 =?us-ascii?Q?GQ0eLYlNeljh7i4AbF9fth+t7CPxYjxihbCKd8cy0MEF+KeQiIPt3qMCdNu8?=
 =?us-ascii?Q?TFx2aWMivYPCFkkmi7mxyiiADYO92MeywGopea44utY9LonFdeSDaM6RPVwT?=
 =?us-ascii?Q?LiInHd3XSV51oEg+qwGwvxI+eCdYRY/QjVFKUOMwCJ+bAymYmAB8lrJ6j25S?=
 =?us-ascii?Q?m6FZFGTOJBcjcOg239/aFoUMgB23HV0FGHNsxdlnrkuNNWUn/IxgZZTx0Qm4?=
 =?us-ascii?Q?2SVTj8TmLHP0S9RUIVVmsOvpL3YyubmaKC8x8HVLLUvbZghM7vwAxa0P81jW?=
 =?us-ascii?Q?kSY3U3x0i1DUu7XB1Y+RopFVvfFr0MYtkNyLD881hFxBc+G9kqxkc4v/rIV8?=
 =?us-ascii?Q?Hz7qw08rN5UFanCNtbo9zzLGE0phkdoE4weyswomIVHY/kdxSn8TiJs80DHN?=
 =?us-ascii?Q?ksyGDjYZMq94pLZyD9s4eDGDKkAJmeIyQzDwaJ2W5OJYuszMVMRI9Dh7De+c?=
 =?us-ascii?Q?XVxNxjXV7bNFJpPWkyAK4fVQrUhGR74LJbej3M6lfW3LLhVBSM9wH4veyqhQ?=
 =?us-ascii?Q?UYanX4AKL8p8tST8oCjSh8T50eRFBvC8gOA+DbMzK+F0jklPnCXpzWVA6u97?=
 =?us-ascii?Q?t+2UXzVjTu1nlN2AWHao1xq83DabqJdctEWeQYTVVmIOEpO84MXA6w6uxDP6?=
 =?us-ascii?Q?JLtjw32Quz0iSmYOdvMBO0IhWhyH4ywcMQ4rXUNFMsVRelgO1yy3O1oeagzH?=
 =?us-ascii?Q?f7M+bgbl2styIXXNYx9xaPKGNUxlZfHOb+07eZ77NoOJASUnFZmQZPo9m4WE?=
 =?us-ascii?Q?9IYOJPfBYw+dIaRJ6nAt6E1v64xb6wjnrDN6b+yoHP9upLTARsS2WrcSzLTQ?=
 =?us-ascii?Q?kK3N7U1Z5bzwEDPfvj+iZwXqfgkWf2KX354Ke/XlC79vl3hPl4/sV6fkfqPt?=
 =?us-ascii?Q?SlSusRQPhtZPO4a+P3/EKlh/InQmKwHWS6NyZq2jQM94gSCLohvwb7wni4E2?=
 =?us-ascii?Q?KOQpIyiJp/QKh1+7B1u3wp078aTqxC+IDixxUxGeawQfnDQl8W1zsCn0JD6h?=
 =?us-ascii?Q?UGwItlh4y1G02TwCTzK9069MIeHeg4qPLZ7QEY5hKNPK2soFDwFCG+j9ypha?=
 =?us-ascii?Q?OjmE19HZAGm0QmiIaqJsuj3sT3ENmVbzEnldexprYB/GrnCkVTFBGafLVbEN?=
 =?us-ascii?Q?Z5s5GdwzGlXOfOs2oitOWMiF+0ZSiq3H6c7IErfkvEMmNQebsIAEtDen/KPk?=
 =?us-ascii?Q?xFNKTzj1kIuFfMAvfh0eMFy3?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 78d7f683-c09f-4502-2714-08d8e7a4988f
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB2604.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Mar 2021 11:22:19.7144 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: E837vkFMpwTtFtOlpABXZW7R7Zm/5GLgf+VogM0B6LmfrCsZ0xfpzwjIp2M+K1aiFKc6bmh7h4l7vErY3VlrTA==
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
Cc: Aric Cyr <Aric.Cyr@amd.com>, Eryk.Brol@amd.com,
 Solomon Chiu <solomon.chiu@amd.com>, Sunpeng.Li@amd.com,
 Harry.Wentland@amd.com, Qingqing.Zhuo@amd.com, Rodrigo.Siqueira@amd.com,
 Anson.Jacob@amd.com, Aurabindo.Pillai@amd.com, Bhawanpreet.Lakha@amd.com,
 bindu.r@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Aric Cyr <aric.cyr@amd.com>

Bumping DC version for DMU FW fix

Signed-off-by: Aric Cyr <aric.cyr@amd.com>
Reviewed-by: Aric Cyr <Aric.Cyr@amd.com>
Acked-by: Solomon Chiu <solomon.chiu@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dc.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dc.h b/drivers/gpu/drm/amd/display/dc/dc.h
index e0ee6d72b7f4..153093abafbd 100644
--- a/drivers/gpu/drm/amd/display/dc/dc.h
+++ b/drivers/gpu/drm/amd/display/dc/dc.h
@@ -45,7 +45,7 @@
 /* forward declaration */
 struct aux_payload;
 
-#define DC_VER "3.2.126"
+#define DC_VER "3.2.126.1"
 
 #define MAX_SURFACES 3
 #define MAX_PLANES 6
-- 
2.29.0

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
