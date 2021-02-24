Return-Path: <SRS0=z84W=H2=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1FE18C433E9
	for <amd-gfx@archiver.kernel.org>; Wed, 24 Feb 2021 22:20:43 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DF7A964E20
	for <amd-gfx@archiver.kernel.org>; Wed, 24 Feb 2021 22:20:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DF7A964E20
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6B1E66EB56;
	Wed, 24 Feb 2021 22:20:42 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2049.outbound.protection.outlook.com [40.107.94.49])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8FC556EB3B
 for <amd-gfx@lists.freedesktop.org>; Wed, 24 Feb 2021 22:20:29 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=djR9IayVQzJTgwqSTDgLPOfvijXH4TUu7GF6LHkCdno1TnR/B5LM1JaaaxYZYGGDSOp3ORZ1BMJKljjHrtq1+tOon/A1qCQ1A0y6plGRdw5mQKXKn4fEEgRBEADUpcM38irum/XAk63Y0WDwQ+Akc2j3pRRTXL5d1Uk1MLXiyq6iEoowKyR1X1AubL2wkvv+tbUYMKdgGl61aCznzf8ydV8BX6pIXhgMKG05qMq/fE8pUYtCztWlUSgV5KgbPd/SILhTjwZXOr3IZBo7KT7OwBQTRiDRTIbjDltir5uH+l41+8ewkm8xeLXz5flmTV61M3W0fxDf8wJOmY5RHcbeWQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KY3ObTophW6cIjee1+srgO6xXQ8C3DR30umYEQxElaM=;
 b=e6MVIckPIzmB805hTMXYH8MWNp/WyYwuqmH1+cgfwm9Z3FOXUvn/JsghGp4VJXF+IlUhIMDk+Yd++t/+R4fWddkM7twA9c2fMONxRVoZYAl3EhXbE+8A8UKAaio4KnuAcLeWawFzHI2SCUyzX1PGU0JfPwc3UiLzakqiF33+YFA8gR0eoAiZh3raN/g5RhYYBXrwhssbIqAPVMjwXxO2zmZD5EheW0riRFFpaKBXpJnpMwhx/LK8Xrai0Vwce9ZmUzWI8MGKmUOzIluuo/4I0H/+iJ7miG/BFRhCmcEFkK7HMSy6oclHbsQOXhBNDad5fnRSl7db/m+7rBfkIackEg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KY3ObTophW6cIjee1+srgO6xXQ8C3DR30umYEQxElaM=;
 b=ezhuF8Nclq9ozgGKhswIHbg4VgZuITzkZdFabdVdbNd00F868cT/p0+IIsAdTgeoDG5MXDyGeRNuPmv+dSpcPWV0iHmi9Em9wAXYkii3Vll8bKkTMAZz+Yf1gjXSX6O1Eh6z4fXWouBY9HFyTyoNxYj9PGihFh2mkFea7a5Tw3U=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from MN2PR12MB4488.namprd12.prod.outlook.com (2603:10b6:208:24e::19)
 by MN2PR12MB4175.namprd12.prod.outlook.com (2603:10b6:208:1d3::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3890.19; Wed, 24 Feb
 2021 22:20:28 +0000
Received: from MN2PR12MB4488.namprd12.prod.outlook.com
 ([fe80::b0c4:9a8b:4c4c:76af]) by MN2PR12MB4488.namprd12.prod.outlook.com
 ([fe80::b0c4:9a8b:4c4c:76af%7]) with mapi id 15.20.3868.033; Wed, 24 Feb 2021
 22:20:28 +0000
From: Alex Deucher <alexander.deucher@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 064/159] drm/amdgpu: updated host to psp mailbox cmd (v2)
Date: Wed, 24 Feb 2021 17:17:24 -0500
Message-Id: <20210224221859.3068810-57-alexander.deucher@amd.com>
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
 Transport; Wed, 24 Feb 2021 22:20:04 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 6b7cdfc7-7a73-42ae-f7e0-08d8d91255c5
X-MS-TrafficTypeDiagnostic: MN2PR12MB4175:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MN2PR12MB4175374850C9F2085DC80D26F79F9@MN2PR12MB4175.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2331;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: dKA2QRi+t9grYNWoqc0fZkLBt0yvdjg5W9BCw4hL14wF5IAu1iByDJ3t1eQdDwNrSbvLG8bs8hGZftwOYi3y2rKacMI/2PQwD5jJJ5b+Un3uv6W9vyYfdwfxu1kWnEdJBDhfvVF9n078PMMpeRArfomdnseA5du/eEM4X2krVM64xm/HMKN9S4ErkKwN+BIr/vcfeHK2oYCtDV/dPpLTxW+wvpod5BHyaMW+nK863fBWr7vfNsjtr5+fPAN1HXkjcUSC/TFtxvk3Ott0DqKP2o6kM8FrNrsguCgSceG6d8uX6uK+iNdw0B1hiRhmdAncvZNpXtfCL/VOMAch2aWABDSk7oMEqZcLv7E9iEEjhVHwiI8VttOCuBxAdiFghuNqi4krpeCJnUtkFNoCpAoVXhunKbd09hWQcLZpGW8eOODF8A8ycuHw3ak5S+ElhhIz0MOxYLnuj3y4znKuPKSnNTfEqecFBlgE74iaIFKzU3VNs1hbc8JGGMc9zLllTqqQvHvP+j9SLISAn9FVDfjc6PHzCw2oZp/TsWgZIzCvGyTD/z1h4Ou9CIGc68Ild4atBjHXAXqFdqiDOrc3JQ1fmg==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB4488.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(136003)(39860400002)(346002)(396003)(376002)(66946007)(5660300002)(4326008)(6512007)(66476007)(6916009)(26005)(36756003)(66556008)(2616005)(186003)(956004)(16526019)(478600001)(8936002)(6506007)(2906002)(69590400012)(86362001)(1076003)(54906003)(4744005)(6666004)(83380400001)(52116002)(8676002)(6486002)(316002)(15650500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?Et7Y+HOVq6iO1uaUFuh+MOse8djFh34L6WtlLzmLFDBoO+gFRT2ZOs/WItnB?=
 =?us-ascii?Q?3jJVrs8utfDQtLkXDsk54k8ToXbE4O4tPq4JdSgUcaTKOUAvqzzkGWyIScB8?=
 =?us-ascii?Q?GGr/nkvUtjE5yT8/3CZ7fOXSkp5/VivzL//4hDRAT0NnLV7yLsG4tYhrEbAd?=
 =?us-ascii?Q?AprPzq1Yxi3jvxs2R4mMO9e1g7FyWA/FjX9qUU88UQCMHoUsgj/4qjp7XW2d?=
 =?us-ascii?Q?it82XFzQgTgR4lt5nYYoIKWJc3HrHyIFFkEEYvjUg5VAYK1ekQ6f3/fJ8X3y?=
 =?us-ascii?Q?acJSvCyYZB+bYRXaekCvZzOa2LPqNzj8e958N8cKUFGlFVcOl8nXhQaebiif?=
 =?us-ascii?Q?F6caVSRBF0RthvOMG0kEaQpR7UYaN0DLTBdE9cAz11gSABjlndPJ+f25KoUR?=
 =?us-ascii?Q?eWbGsg9Y49mE4FiDpwJ4DJ3ClZBMdOjqkrurk/85UQYcQSkE5ChE++6HBP3o?=
 =?us-ascii?Q?P46RSVMeGDtVmrWGHlJDjKfXCZASDHJmFP/BPnleuLebkZjwACPDDENEm8Wr?=
 =?us-ascii?Q?DnwRe0++PgHCaDZeri+LB6+9S7rf0aILGaZKoBiKqec+XQ0cJJKQlpvQTSXO?=
 =?us-ascii?Q?SDgxgIXVpoS62CBhhhv/I627RoVrQii/DMTrTizprUKJkYVCEF/pV06mdO1v?=
 =?us-ascii?Q?Bifs+1EC16dIVuD8pEuI0yabuHCgnbeuUIQGJU2yD0CpVbn10Mccgrwyde3D?=
 =?us-ascii?Q?e8oGpNNPj7Le6YC7AYAKauKisRNP9Pz5rjiVbyNDSqYq+Qf3zZi1TIoy0JO6?=
 =?us-ascii?Q?Dj4ZcUL4EtJOIdCum79QArZMKIyQc526Jr/RIsJ7Hcp9W2Fu1IFfOLUsFivE?=
 =?us-ascii?Q?/2U2StWe9Dwata5fMaMu8BSuPnxjtWl7qE6AwBEIF6sjfJ/+7cHHs/9RGQKF?=
 =?us-ascii?Q?cl+xF0RpJuAq4YwYfMHVIxrbh+a8FePOomQ10a53o79usSBv2Q6Yh5+5f4Cz?=
 =?us-ascii?Q?HYRDPIFfkCsJ8hB+BSsI//LVL8KW/wSoPunOrL8u927uQmh74auvtpy4xNYK?=
 =?us-ascii?Q?wvG6wrFuc60mW3Bj9tQxQ1CmdobL+qD0O6CwCKFUTXzLOYiPi7mnbb5b0t6M?=
 =?us-ascii?Q?7PegH0x8oNRE5Jnb0akkihfmYQqHJf8v7SLqDi0buQoqX+XxQQahBcwyza/G?=
 =?us-ascii?Q?S/akbgC81txqFpfgTFsF94Cv/jxMRmTJfF6CW75TGBxtxE69OsRYTSguCoY7?=
 =?us-ascii?Q?2SqvtSANrBhr/ziyVRHQq115GmL/hStb96ymOopeeW1yX/YPiZjsx7z9a08V?=
 =?us-ascii?Q?MW83ssuB1Pztu3tOxaimSVuEKuIxj6ksRdzu4yucTB2JMRtr14+pKf9orMeg?=
 =?us-ascii?Q?CWRWRS22Zya0XUKgbd6zCFIC?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6b7cdfc7-7a73-42ae-f7e0-08d8d91255c5
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB4488.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Feb 2021 22:20:04.7000 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: swl/Hz3cUqVyJGSVeEGFSn6aydxg2JlOXyEaLRNGgrq5rjaY2/CcXw9RqohkIMirnv8rbxVZ2cHI7Sgf5RiyTQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4175
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
Cc: Alex Deucher <alexander.deucher@amd.com>,
 John Clements <john.clements@amd.com>, Hawking Zhang <Hawking.Zhang@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: John Clements <john.clements@amd.com>

added host to psp cmd for register list

v2: update to new interface (Alex)

Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>
Signed-off-by: John Clements <john.clements@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/psp_gfx_if.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/psp_gfx_if.h b/drivers/gpu/drm/amd/amdgpu/psp_gfx_if.h
index 3ba7bdfde65d..a41b054fe0ba 100644
--- a/drivers/gpu/drm/amd/amdgpu/psp_gfx_if.h
+++ b/drivers/gpu/drm/amd/amdgpu/psp_gfx_if.h
@@ -235,6 +235,7 @@ enum psp_gfx_fw_type {
 	GFX_FW_TYPE_SDMA6                           = 56,   /* SDMA6                    MI      */
 	GFX_FW_TYPE_SDMA7                           = 57,   /* SDMA7                    MI      */
 	GFX_FW_TYPE_VCN1                            = 58,   /* VCN1                     MI      */
+	GFX_FW_TYPE_REG_LIST                        = 67,   /* REG_LIST                 MI      */
 	GFX_FW_TYPE_MAX
 };
 
-- 
2.29.2

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
