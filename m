Return-Path: <SRS0=chDG=IV=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D186C433DB
	for <amd-gfx@archiver.kernel.org>; Tue, 23 Mar 2021 17:06:30 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E282E60C41
	for <amd-gfx@archiver.kernel.org>; Tue, 23 Mar 2021 17:06:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E282E60C41
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3BDC66E91C;
	Tue, 23 Mar 2021 17:06:26 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2075.outbound.protection.outlook.com [40.107.94.75])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DF9EF6E918
 for <amd-gfx@lists.freedesktop.org>; Tue, 23 Mar 2021 17:06:24 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=V1kRmDP221ApzGy8r8sZKSTRtqgzRHsnCwYoJkoyapSEZ/s8wxaVhhTW0+WqEEgZIQLBnJ3OONXPic4MNdobzo5UN5ZWjfFG0Wfxnfccsc4Rg4D/vio0nypOElEWjrPA0+04a82h1316cUdbO/Kjq77YutfRBLZNP+L80Hk0rZgS/pSkHUtq0T4sdzXb7Bfs2Co/E0oBL21V0pVTzcUL6mNYOgUlwhB32R48TspEC8gNifwnGxRmWzttINHy56BYbeLSN8BspZ9TO55woBvS8lfRg0tIBmDzMofwLCoAuCu1z5949P4Vs6oVSjWXFg3Hsc2jQ/Z5SlH9cuNXut4vvA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dLmNmt6G5Y9C6IBapMA7O0f8N5LvC7bUwwfom17BUs8=;
 b=cpLdmuwONjBDb2FaTkfJVzisKsS9tH8kaWkpn3DUqH9FWwlUXXid9K6WdZKtfqIrPEpoFBGr4RCN0+oNBV2i+Df0RsWFPn9I/jtPUA44bzBkvdyP2asyRZshxMFa4+ReDISD1RyX2mtHZ/CoXNXH2zxzTVUT/8cMF/54PT0p2nkNJ+FidiFhoRbwlbjVJ1ENWJ/NyPwNwWfT+1u6fuaL8WMPsaZyf0O/1Odl6UZYQOlg3dKchiMXUJyWfsyEqELMd0okvW4kUWVEz+p4bWDN4iCAotDGXctIZqaqs47kZnyhH2Bw+5Dt8qYLSl9YALtf+7a94Ur4MTSA99Mfk4AdYg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dLmNmt6G5Y9C6IBapMA7O0f8N5LvC7bUwwfom17BUs8=;
 b=vUd0r3ZzJaDrIHAFJ3t7GbFsOSpcb3MK6bv0bH8pHm+s+Q6mHVLUvzQMmSx8o4dBYauWaVj7QjIqA1lYQKZcUjP0+a26AUh95kIwp1ApR2hzHZXaUvoS0Y/aVfpUP0MSjkk2CRltIMoOn7/SjXd5qjZCL7eVwPjEIBvVwGLBZHE=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from MN2PR12MB4488.namprd12.prod.outlook.com (2603:10b6:208:24e::19)
 by MN2PR12MB4406.namprd12.prod.outlook.com (2603:10b6:208:268::23)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3955.18; Tue, 23 Mar
 2021 17:06:22 +0000
Received: from MN2PR12MB4488.namprd12.prod.outlook.com
 ([fe80::3d98:cefb:476c:c36e]) by MN2PR12MB4488.namprd12.prod.outlook.com
 ([fe80::3d98:cefb:476c:c36e%6]) with mapi id 15.20.3955.025; Tue, 23 Mar 2021
 17:06:22 +0000
From: Alex Deucher <alexander.deucher@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH] drm/amdgpu/display: fix clkmgr for SI
Date: Tue, 23 Mar 2021 13:06:03 -0400
Message-Id: <20210323170603.1223424-3-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210323170603.1223424-1-alexander.deucher@amd.com>
References: <20210323170603.1223424-1-alexander.deucher@amd.com>
X-Originating-IP: [165.204.84.11]
X-ClientProxiedBy: BLAPR03CA0105.namprd03.prod.outlook.com
 (2603:10b6:208:32a::20) To MN2PR12MB4488.namprd12.prod.outlook.com
 (2603:10b6:208:24e::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from tr4.amd.com (165.204.84.11) by
 BLAPR03CA0105.namprd03.prod.outlook.com (2603:10b6:208:32a::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3955.18 via Frontend
 Transport; Tue, 23 Mar 2021 17:06:22 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 8dc726fc-c1f5-4676-9764-08d8ee1dfc35
X-MS-TrafficTypeDiagnostic: MN2PR12MB4406:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MN2PR12MB44066DD79FEBAFCACDB4E205F7649@MN2PR12MB4406.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4303;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: t6aNFtsVsOSKh1eKNDn+2UTnW2WjYNwxJ0j6TbLDN6h2NXNdmQRZCMvrsRIeaz7WHWBaSoT3r01yoDOn4FT6SXTU1Isvpjz7P5dI38a0Xam9PdbU994hOYBvHuQcOhMueiOXqv7MPVXNYuNG2GFcGUPIrGL53J7iAE0U7JEC+iuAcJs7hJhnUY8vmIyS/T3JE3lOYHTnECniJ1O21uf2gl/eefSVGPP/SRfVr4hAi5jLTQiyPqYCI6sVUSYpraTMHTp8MdH8MPmBHfa0bSvVhDnY9MhUeWLEMjToFF+QXL/6qcZXXBzPdF0Sol81gPEfEGkwtg3gr8qqII0LbpNXkvEaJ0rzG6wLSgkW8ZiKUvBHom0Oy5cWTVgh5JS1ks6WfKMwBWD8ySuTxfVPkDvx904cYaSK5xWum/QqRZMVaYTfVkDWBI+z1S/MbNShdi/ucicjIpR/yPpMC75tpQBnrz5QIHdUjN1KnC2TkaLPlWqPlJ1Qc6tUhBAdWs9OrgiaqS5k7GbCB/ExAFtgpWM9KwhrAHA/kmcijKWHBr6EJhS3T4OsR0zjcMz36ihT812TmatjIj53rytoE9LOclhTrd+txKcn7RpNyrunKXx/6MRFUUqOShuhCvKv6CTUZ87qm9lKNEaxAHuL9YJOdbs369+dTPaKeLNK5/Af8J6G8iuJiBql5XjkI4/5EIqgapU4
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB4488.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(26005)(16526019)(38100700001)(86362001)(7696005)(498600001)(66476007)(1076003)(8936002)(6666004)(6486002)(8676002)(66556008)(66946007)(4326008)(2906002)(6916009)(52116002)(4744005)(5660300002)(956004)(36756003)(2616005)(186003)(40753002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?zZWk9Fn9H86jqBnP/fYqs/DL8lVUcV1NypMxCwcNtGrLV56HwYk6SPfsiO/b?=
 =?us-ascii?Q?noyczKIDM6SioHsOEGoSkTAqytjt6oo305bw9LH6vBWdwlUKdwcDk7pOsGIR?=
 =?us-ascii?Q?o4un1WcDgnLcglgLyfUnMU7gpWPGA9q5iPWlZ31ztSn9OrrCJKNB5hnJJKic?=
 =?us-ascii?Q?8u8FuSbtj23HhVcO0Njn37c9QAZp9g1SYVM3HdhzbcVgTqCIsbAVZw/qfrcl?=
 =?us-ascii?Q?PNjEemWU2/pUZItYiHLw9ESpx0m4RvV8iobeJL25X17CIa69hcJZgFkpvkjA?=
 =?us-ascii?Q?wwDU9RxGK3e6bhxsS9hYITeg60ddYtrjQEauMNOWn0qNRj5wTWB4MvyDSUkY?=
 =?us-ascii?Q?5BPpIKtfpj/tatbuE4m1mvxaUep9XDdZnF38CKSjgOICkTHka89/ZXHxLl/4?=
 =?us-ascii?Q?jT/TuAG1V5WVQ2xZGpKbT25q1GhiUF+fNb2H1mnowHRQPcUDyeRyCZSTOsyW?=
 =?us-ascii?Q?U2pw6ZAg+pMEJ+wxUTdF+za/a+U/Q10QJ/RHk6O8I9lWfxBRe8mdu1md8yVm?=
 =?us-ascii?Q?0PcM62Lfh3XQ8hxo5nFXLx9+vERmIsulxDbEAXR526xO6gbNcA39opv+5eb1?=
 =?us-ascii?Q?Saat4lECzaCjAeFqb9bkHqdGIfPNQ2gvSu/sFWXyTSIdcleokk6W/sWbRMFR?=
 =?us-ascii?Q?IJIC008mRGq0W4ASlS2J15X+51zq83guEDmG/ufHC3Ny2kBO6NdcSaNpEFFQ?=
 =?us-ascii?Q?FrTbdBpbatFMvlEhOXZdnKBMuW1Vv6h4NmnxYG1V7xX26fUAKGSqlVyQTC7z?=
 =?us-ascii?Q?II5k8PzknMy4bKuRza2ZEm04vFik1YHvOtoBVoZxB/1tdpL5SYRb+yvo/nmD?=
 =?us-ascii?Q?FfyC1Inzg2+Co+n6t795qRGDxe5tVh5om0/hz13XTnMSAUajV2Ehz08r8qfC?=
 =?us-ascii?Q?MGTRCGYXIo9s9DdAhY+yCz1VqEngO3chqzclmkQAxq8AO98eeYLUotLyW3h9?=
 =?us-ascii?Q?qGXl0xCYi/N9AlcLLjA2J9FRl4KBVr39RPt6zTdG0g9fOuiiotsJ3rl9Fto7?=
 =?us-ascii?Q?MhJLSpPEsPLgSQDUWzlx/GosJ0y3xqFi/sfH/VedhRGIA9mls6ptFdp+ZNO/?=
 =?us-ascii?Q?kHoERcTZxTyHY0aqlxoRKg2Z3RAhIpjCnlph9y6Hf6z+nHDfi6i4/g0N30cY?=
 =?us-ascii?Q?eWdsteql3O+AH7nC3JDCkXaeXsc4jxXqID2/pPLILUpsmfSoPv4Vx3R48VKv?=
 =?us-ascii?Q?B9jl/CyQbR8cXrEbnfhx0FrHXxdwQs4xRoeOzj6y1xP48sV8vVH0bx48iMRS?=
 =?us-ascii?Q?PYVNb/tgymPTv/QTa+RUmGdzKDSlH2+5EaHWLxaC40Re03n3bsDJDw3ceGEk?=
 =?us-ascii?Q?4HaTKgpRRnrlRQzjzAdCpusX?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8dc726fc-c1f5-4676-9764-08d8ee1dfc35
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB4488.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Mar 2021 17:06:22.7470 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: O0B6ubMIaIKnVPsJ1MdZGqE8P3bVJOi6JZQCJfqGPPGYBtaR1ARkIKisjN0y5WsoBL41Rc70IvDPrDdNxfdnPA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4406
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
Cc: Alex Deucher <alexander.deucher@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

It looks like the SI case was missed.  Need to return
the clkmgr struct for SI.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/display/dc/clk_mgr/clk_mgr.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/amd/display/dc/clk_mgr/clk_mgr.c b/drivers/gpu/drm/amd/display/dc/clk_mgr/clk_mgr.c
index c81da30faf03..7d6c68c5dea9 100644
--- a/drivers/gpu/drm/amd/display/dc/clk_mgr/clk_mgr.c
+++ b/drivers/gpu/drm/amd/display/dc/clk_mgr/clk_mgr.c
@@ -136,6 +136,7 @@ struct clk_mgr *dc_clk_mgr_create(struct dc_context *ctx, struct pp_smu_funcs *p
 		}
 		dce60_clk_mgr_construct(ctx, clk_mgr);
 		dce_clk_mgr_construct(ctx, clk_mgr);
+		return &clk_mgr->base;
 	}
 #endif
 	case FAMILY_CI:
-- 
2.30.2

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
