Return-Path: <SRS0=z84W=H2=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7CB18C433E9
	for <amd-gfx@archiver.kernel.org>; Wed, 24 Feb 2021 22:21:54 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 46BB564EDD
	for <amd-gfx@archiver.kernel.org>; Wed, 24 Feb 2021 22:21:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 46BB564EDD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A89576EB7E;
	Wed, 24 Feb 2021 22:21:50 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2087.outbound.protection.outlook.com [40.107.94.87])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CE14A6EB72
 for <amd-gfx@lists.freedesktop.org>; Wed, 24 Feb 2021 22:21:47 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bx+NzgqpMVe0meW9AjmzpSgOWIwXXMylUadHpIE1FNVIXC993lrgNUQxaTVskfDPkl9hoiE1jQxnhJvpgGvGk4IrcZRePF20Eb4WpaN22Ff+eGEL4lrBTvYNtZfTaRNd8jfrJFKNRBkOKPleDbo/eq7C5fU+TUuiu2ha/0MvRbhfYELxFZlrdzQcPiQnsB+8OMT0+eD+Qbj4XMEYc5Z2kj2zFQkNSOTi6Vi/IDQB8fmkjIPiJAgGZGDrocJomtCi/4/ZoIm+35/WHZUQZrpT08F7aa6ET9rwzOCKx1jLHTbQXh4e2+O7fkmRfu23SNL+vVWygxFq+fZuCUztMF8HdQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=a4k2zB95qe457oon3qN27IkZYpaXcd5f8VLbOxOvhJw=;
 b=GayIWJ88FAyjOzGCAfOjw6k6w20JiZRbjVX1ZLqmOZtD3xQ8HnjYKAI2JJUPAmwde1igzbX1K/GkDvWgzM05fv6T9MuJQGtowBatJz816uF4c1sjZ6s5LJ2EH/nN94rGeHNAI+Q91nizS7PL/7XTxNBkEoSKw7fCyKUge6gEJfrLrW5Llv8NdubVF6rF7VNzi3xyIiX5RXc/++ZAzyzFwvUBSI5lWvr6aF1LKFYe/mlx54A6JUAvw3eh5tqxpO7f4hETYA1xuXvSTUSWnJOv68yH5/mo1hY6V1AC9J8jA8poQgppW41hF1mzOCq+lKRasfw3eFNWZsZlDB8LzZdcEg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=a4k2zB95qe457oon3qN27IkZYpaXcd5f8VLbOxOvhJw=;
 b=A3V/EzKxG3HZCCaUkjg0BlDJjW1m1EUh4F8JzLZ1J07mRJRU9/qSQ+m2P0w9Qvqj4pGBcuCF8pDl+klA+wXtLYm2dt6Wja6GkZ6070wUy6fP887jK8D0mAdP3FxBPL4J6bWiniiByUFkHFRjsYF/fIstrKfCOmAkrYDVco2dvPk=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from MN2PR12MB4488.namprd12.prod.outlook.com (2603:10b6:208:24e::19)
 by MN2PR12MB4046.namprd12.prod.outlook.com (2603:10b6:208:1da::23)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3890.19; Wed, 24 Feb
 2021 22:21:46 +0000
Received: from MN2PR12MB4488.namprd12.prod.outlook.com
 ([fe80::b0c4:9a8b:4c4c:76af]) by MN2PR12MB4488.namprd12.prod.outlook.com
 ([fe80::b0c4:9a8b:4c4c:76af%7]) with mapi id 15.20.3868.033; Wed, 24 Feb 2021
 22:21:46 +0000
From: Alex Deucher <alexander.deucher@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 111/159] drm/amdgpu/pm: Remove unsupported MP1 messages from
 aldebaran
Date: Wed, 24 Feb 2021 17:18:11 -0500
Message-Id: <20210224221859.3068810-104-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210224221859.3068810-1-alexander.deucher@amd.com>
References: <20210224221859.3068810-1-alexander.deucher@amd.com>
X-Originating-IP: [192.161.79.246]
X-ClientProxiedBy: BLAPR03CA0027.namprd03.prod.outlook.com
 (2603:10b6:208:32b::32) To MN2PR12MB4488.namprd12.prod.outlook.com
 (2603:10b6:208:24e::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost.localdomain (192.161.79.246) by
 BLAPR03CA0027.namprd03.prod.outlook.com (2603:10b6:208:32b::32) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3890.19 via Frontend
 Transport; Wed, 24 Feb 2021 22:20:39 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 467eaa29-9a41-4195-e1f0-08d8d9126a91
X-MS-TrafficTypeDiagnostic: MN2PR12MB4046:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MN2PR12MB40469433CA147032C0EC5470F79F9@MN2PR12MB4046.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1850;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Bs/Dho/o5tOd/X3LqulBpbR3zdK6mOzxbW1iiYr/BPFi9EhulVlS1xCRjK57MxVPSYMTLODh7C3xTT5dLeX0vqWUWaFde6AttowErmJmtysGuj0FVadlPeBR/nIAEdgb9vuxij6fYxQl6h91bK7/6JpHijd/wkaw80wfJHMq7Ieviotu6t5xFjx/knerHefOutk36RaC/AgttTR8Eiqhi0i6UjD+hZcI5lmiG8RirSOCySHo9S5mncL/gQOupnCvKPn9qlyLg807VoLAEvS+q8st9zZWb3VMkYk8SVby9mhSK4o7bOAioezilmwFhVxxUsRQs92E15dK0ab+jXDcjjlLNMs2AzaW0/iHdWiGqB6SdZZPF684oCnEP6zmFvb+NfbecjFFahi245VbfUan2Un82P7AijMYjED6fYm91qZk8dmcAbDVW7i0JZlN8OkRn/k6nNKhwjb0U1YF65WhtZL3rCJj24Nxsm9YYZysZgXjmUsezGfAeN9lngJuHJl3jy3CQ4U2cN462Yqnxvh7OleTBBybnqXMba3ujUx4In6EjbRiC1BzqCIseheEFfYePbybjhV36NYKZ7BoBIwU0A==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB4488.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(376002)(366004)(346002)(39860400002)(396003)(136003)(83380400001)(86362001)(4326008)(956004)(2906002)(6486002)(2616005)(478600001)(69590400012)(19627235002)(6916009)(8676002)(8936002)(1076003)(6512007)(66556008)(66946007)(5660300002)(66476007)(15650500001)(26005)(6666004)(186003)(52116002)(6506007)(54906003)(36756003)(316002)(16526019);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?COHZGf09/RdPcjPyTqndrd/9L88zssCgZ9KEhlzVcpaABtUZe5NjKX5LYkqs?=
 =?us-ascii?Q?hmpuKn806u7IxWdhRXgJ3Olm4bCYCajl613yLuntjmRbj+r2F2705hUyl6dn?=
 =?us-ascii?Q?mn++qJUvg3RzQu1+uuVc2E1NYxquOTCEx9hU7b3rgyrzkDxkX1UmxSd3dzZS?=
 =?us-ascii?Q?pE1rx1c8j7yR6uLGGqqxn5uXbt9qkjCGpOofKjJb0AjayMcN1bC1E6VviQJa?=
 =?us-ascii?Q?yJv2O9/uhu9zTyu8EzauweDmx1beXVjKaCu8cg9tdAJzGCIUViz2aBt+ht58?=
 =?us-ascii?Q?KH/LUTlaBhkQHoHATRnK2I25zdziH4w9pOFtLUTek5SaEdDpGxez7Th5L+jz?=
 =?us-ascii?Q?LvWfpNqjmgZuGMmTiQixb1qySr4Xf9mzArwZsPbzVGZBQrMKUwqmSgf0FDY2?=
 =?us-ascii?Q?cT++Aw7yP341c/oEnEsP+01L34mDvsD0AASk+JTiGM6YQGnzPdIyTKTBOAmy?=
 =?us-ascii?Q?d0N6HxFgrWtZ3quQgZrje0OKzYCnM+E6QnTTgCNkqL7QqrG1mxJeYs2tgD9B?=
 =?us-ascii?Q?JKWcwY4YcX/nqTWj/Iz+KqRyhOp4RPJNCOje7W7ZcDOyOD6QNuR25cbzfdd3?=
 =?us-ascii?Q?EFpyJY/Ui1lF6yd0p88UaWK0sSbCJh1hX4rmzF5NVpgLhROW9V8+j3zg9abs?=
 =?us-ascii?Q?LbJsCVi8s54X4t/EmRxUR1+zXAsKJvjc2pEz9s2kQ8qKCxaZewo9TYlQmnPp?=
 =?us-ascii?Q?5K7GzJs3xMIOKeIO0k2w4LaS3C9jKkOLofLqwhigGzFcN8dWT8/8hqBG8aRC?=
 =?us-ascii?Q?y9rjer2RWe4xB+zJhu8VFFsvmjJ16NZqAT3iy0I8pHy04JqDyU7fhus8CTNr?=
 =?us-ascii?Q?i19/s3B1B0a6YzKje6jijg0z9g7ebcLv6L2ZLIPg8paLPozR9h1cFx8CMg4B?=
 =?us-ascii?Q?FMdwozldUuyDQ5F94YE0huK4cxFawIl/qThQ5TdVQ41NC5XV+cw5Vt9h2ROu?=
 =?us-ascii?Q?O8h0Rj8vAYyBiDIpT73kGNxwylwAdlUX3ntHGDcCtyv+uMLLJhw2l3LNcBuH?=
 =?us-ascii?Q?dWcJ4jIuHwKVBLuDxOLA+LsPg46i54CJlX8tBn68/e8XIjc8AdwAfg/I2pj0?=
 =?us-ascii?Q?vsBJG3lN4xMJrVgoaLyclVb1jPNGvTubII+NwoKwEJt2SrqINDCbKRzAdYVl?=
 =?us-ascii?Q?gLjkzlZgkHs6GQHtmwD8FvVdRGfTFaBXBqeR3s0UPlLYtGKOSMiAi0eW6vXV?=
 =?us-ascii?Q?qct5GIuXNEN3PBrJPW2kinY9YPxpXU31CO3HF1mhY4S4g8+1Ryw8v/jWH5oj?=
 =?us-ascii?Q?Bg+6PjLwIo4RpHfl1cIJ9EZ1nRTQGo6GuMk6w1iLjDDNBpJdmsO6AKbc321Z?=
 =?us-ascii?Q?1VFLVnemj4D9/TNq3nrQ3UPt?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 467eaa29-9a41-4195-e1f0-08d8d9126a91
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB4488.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Feb 2021 22:20:39.5311 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9L66shjqon8hBAFf4qpwBgKPFEJUA0Kfl3/L1gcQ4Fk8zemmtSEwdfRI4LveyJK0fSN8XS7OdJL0j81cobJ9NQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4046
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
Cc: Alex Deucher <alexander.deucher@amd.com>, Feifei Xu <Feifei.Xu@amd.com>,
 Lijo Lazar <lijo.lazar@amd.com>, Kevin Wang <kevin1.wang@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Lijo Lazar <lijo.lazar@amd.com>

PrepareMp1Reset and SoftReset messages are not supported on aldebaran.

Signed-off-by: Lijo Lazar <lijo.lazar@amd.com>
Reviewed-by: Feifei Xu <Feifei.Xu@amd.com>
Reviewed-by: Kevin Wang <kevin1.wang@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c          | 3 ---
 drivers/gpu/drm/amd/pm/swsmu/smu13/aldebaran_ppt.c | 2 --
 2 files changed, 5 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
index 90a00bb986b3..474a5dd04c43 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
@@ -1823,9 +1823,6 @@ int smu_set_mp1_state(struct smu_context *smu,
 		msg = SMU_MSG_PrepareMp1ForUnload;
 		break;
 	case PP_MP1_STATE_RESET:
-	/*TODO: since the SMU_MSG_PrepareMp1ForReset is retired in Aldebaran
-	* Add handling here forAldebaran.
-	*/
 		msg = SMU_MSG_PrepareMp1ForReset;
 		break;
 	case PP_MP1_STATE_NONE:
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/aldebaran_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/aldebaran_ppt.c
index 2f3c87bf535b..b561c1eb4678 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/aldebaran_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/aldebaran_ppt.c
@@ -108,9 +108,7 @@ static const struct cmn2asic_msg_mapping aldebaran_message_map[SMU_MSG_MAX_COUNT
 	MSG_MAP(SetPptLimit,			     PPSMC_MSG_SetPptLimit,			0),
 	MSG_MAP(GetPptLimit,			     PPSMC_MSG_GetPptLimit,			1),
 	MSG_MAP(PrepareMp1ForUnload,		     PPSMC_MSG_PrepareMp1ForUnload,		0),
-	MSG_MAP(PrepareMp1ForReset,		     PPSMC_MSG_PrepareMp1ForReset,		0),
 	MSG_MAP(GfxDriverReset,			     PPSMC_MSG_GfxDriverReset,			0),
-	MSG_MAP(SoftReset,			     PPSMC_MSG_SoftReset,			0),
 	MSG_MAP(RunDcBtc,			     PPSMC_MSG_RunDcBtc,			0),
 	MSG_MAP(DramLogSetDramAddrHigh,		     PPSMC_MSG_DramLogSetDramAddrHigh,		0),
 	MSG_MAP(DramLogSetDramAddrLow,		     PPSMC_MSG_DramLogSetDramAddrLow,		0),
-- 
2.29.2

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
