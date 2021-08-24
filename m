Return-Path: <SRS0=c7t5=NP=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5490BC4320A
	for <amd-gfx@archiver.kernel.org>; Tue, 24 Aug 2021 17:36:50 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 17CC560698
	for <amd-gfx@archiver.kernel.org>; Tue, 24 Aug 2021 17:36:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 17CC560698
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AE1A489654;
	Tue, 24 Aug 2021 17:36:49 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (unknown
 [40.107.220.63])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5F30989654
 for <amd-gfx@lists.freedesktop.org>; Tue, 24 Aug 2021 17:36:48 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=c0is+E/GVaxvhBcFospJsgoq52zTPDx+WvZkuqDg5F8jM7T7oDCgLOVaj6yiMr13Zv49h8SvVRBmADr1OBXpEwoRccZ2ICvU/385NwaD26zMcoiiTzFlbw4lIU0nt9jkfdPW40uZ+ka/P/3DRPYQQFeYFbXCEnGNBEGX4lYSbPvXNBds9JSkZ7F52C+6y2IBL7kC6G2JUUADuHF0G+u8eXFJdzfKkzSo/6+E8GX3bqxhtyL0d8P+lz9FVUNvtGUKzRHNx7Jdrfoq/SaJScEBDWmXM6GYjn/g1D/XCsqkbB71ayfwjMI5RqkRON/alqZauEz7+ddL9Ep/cKGKwAoeHA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/r+XBeHe5i1no2+yS9KVzD4qq44cvUBPs72wJg/JPqc=;
 b=HRiVOG/VWwytbn91xBEohtHbe79mf3L8R3S2GCBMGTpyH/S/PWJwQW31ohP4l0DFgV+9l34JEDIa9vIQZPEcqAPzZkvaIGTeBy4La/nSErJOzdCP33+RdycY4UeR/CT5dxMgBCEVagARHSmpMJISXVH92F8nfIixojicZytomRunVL2cDZzrQXV7KCKF0rBjrU/j2jZoGymk41KJeUVVy/XeptTS9B4Qk7JjiNh9HNsYwiPT52LidX7v7joyUH2pkQvl/SiVSIO7snnHqtM8ED5nNxrIhVYtEMbLSHD+jOmsm+8PsdXQ/8A1QsKzw8DNEiX/uMN0chr7WDjybyrgTg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/r+XBeHe5i1no2+yS9KVzD4qq44cvUBPs72wJg/JPqc=;
 b=hlboDcS+eN9dR8eGK7eyzZCy4y7+6/t10RBPkgnZaGBOs26KoOmYqQmN05e6oUu9aFErjBTioIu7khGCQPPP3S1tNCUC5wlmwKvPKBNuQxAm/DapA/MJtnXDsUYRzKgz5HzKIs61RWlXD6pewnZ9nN/FYPW5iWpQfW05+wPqdus=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from BL1PR12MB5144.namprd12.prod.outlook.com (2603:10b6:208:316::6)
 by BL1PR12MB5126.namprd12.prod.outlook.com (2603:10b6:208:312::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4436.24; Tue, 24 Aug
 2021 17:36:43 +0000
Received: from BL1PR12MB5144.namprd12.prod.outlook.com
 ([fe80::5dfc:ea54:4a18:89f5]) by BL1PR12MB5144.namprd12.prod.outlook.com
 ([fe80::5dfc:ea54:4a18:89f5%4]) with mapi id 15.20.4436.024; Tue, 24 Aug 2021
 17:36:43 +0000
From: Alex Deucher <alexander.deucher@amd.com>
To: amd-gfx@lists.freedesktop.org
Cc: Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 2/8] drm/amdgpu/display: fix unhandled cases in
 get_phyd32clk_src()
Date: Tue, 24 Aug 2021 13:36:29 -0400
Message-Id: <20210824173630.1915457-1-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.31.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BL1PR13CA0068.namprd13.prod.outlook.com
 (2603:10b6:208:2b8::13) To BL1PR12MB5144.namprd12.prod.outlook.com
 (2603:10b6:208:316::6)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from tr4.amd.com (165.204.84.11) by
 BL1PR13CA0068.namprd13.prod.outlook.com (2603:10b6:208:2b8::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4457.5 via Frontend
 Transport; Tue, 24 Aug 2021 17:36:42 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 8fb2f268-be1a-4daa-5d38-08d96725bcf0
X-MS-TrafficTypeDiagnostic: BL1PR12MB5126:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BL1PR12MB5126465D86E132837BD14A45F7C59@BL1PR12MB5126.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:220;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 02llMfQa1YBWb1Z1FDYQLb79Aj86vHPQlz6UlNrAITm8Ued+hNj+ZTuXY3R92R6P6FKiVDH3x4YQS8CRgx2ux43ApgJ+99Ttk7hyUHNjC1qPyAkvtR0+2FLG+S/985OdmRC/1iy1frLTFU7/w0lsXYtZrvBKE3ky+LQRi5Fc8fX9aY2kWUNfwFiBixrGacvZeP4wkEYJbtEkUfR1XokHHNDD+HswAx2plw3I7DqH4xh6SWG0dbrMjsXcZFM90L3ivCzcvOO0dUfmH3AMd+aHj9Vs6BYtefSORkHiCSG4in+klDCM3sQCot/rFsOM+IjVaYiSi0yjK9bYOhGsIX5ox5mQqdcWwgSH306AdYKPl6ICieQmPt8AHLWVUkqU3pK78hkGmUVPTtKdbyiNrj2UFzhsGW3I2LSOAieJibcOoBfWpxtN0XHtBIi7Y/DCqgWp6f9OedvURLd/NvcTkaa8PYXLawa5NfeSusRE5BOubzDUWbeiA7fMfhc2tFdB77rA1xD/BUPrkwNuC0+vzR40pp/qaWbYoW170lPGEYEfv/vdiWzw/vGrxGqaP3ZIqvELLRCvl4I0/jNbhsA+dDUOzOh3EH/FMnlPopEkfy3gWhceaAdGeWFqMyEdVwvz2DM3lmcKdBX0pEKrzYPPpGGCNhmRV1d6TCwqwqn9uc4O2fRd7pKbYQF8Gam7yVUTpxLFV5ho2QXztIRoJ7RzZkmlvg==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL1PR12MB5144.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(396003)(376002)(136003)(366004)(39860400002)(346002)(186003)(8936002)(6916009)(4744005)(316002)(6666004)(478600001)(66946007)(4326008)(1076003)(8676002)(38100700002)(38350700002)(66476007)(26005)(66556008)(86362001)(2616005)(956004)(2906002)(52116002)(6486002)(83380400001)(36756003)(5660300002)(7696005);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?ipkBLMklzePy9vRQgYVnaz/YEIhCXe07ZvTJDcs/NdOLHqxAB4P5Xr7v0r4Y?=
 =?us-ascii?Q?bK2tVW65ZJ1CjqE+d47QvvvGaw+LXaTiBCzzo4SvHyBYigag4KvR9v8WKJvj?=
 =?us-ascii?Q?CZrxq2TEJ+7cp2a7Apese4rAmrDUOdgwkuFRj+PpH6jvTNJ3OKQX5uLy9z1N?=
 =?us-ascii?Q?heLaoPcIEL+M/MNjegqOVvysYoNQipDG5rmdL5JfdG+WzeS98brncUfKtjJV?=
 =?us-ascii?Q?Zvu8nYCa3Rx0WJHIngA+P8FYb0hpYYu3zNNBoCMo0OYI0eV+7qTiwW+9ZxLv?=
 =?us-ascii?Q?6NwO711xxORMqYB+HOkbnTkNEVKMVH+tNyKmoslWcBt9z97I17Pen7MG4FRO?=
 =?us-ascii?Q?HGAPSiYdGkxz4TmclLH6g/xTL9J5OtL+i+7PjGmZr3Uia7FLEl6qXV45xJ+P?=
 =?us-ascii?Q?JVYZV/IKY1ln4/OpQVfa0136G0yC3Xzdmm/vT13iiWEkUAYlL4S79m0uvNjU?=
 =?us-ascii?Q?rtp9JOzb1PtxXxS7fpE0Bk6zyNfB1s35P+E//iIhifWwyqbJkNsx/pCcj5NZ?=
 =?us-ascii?Q?0TAooQStndA7WbACGVPuIhvQwfbeW4m9qoD1dsD941bC+ybevsFc9w7Vpg3Y?=
 =?us-ascii?Q?4PflVjowGHDXj2tbh50xSp1tmmnepAhkwNGMx3SYF3AsyghHejhNkwdcsN+F?=
 =?us-ascii?Q?wCWXPqiWGAUHGw8YosHW+jThUz+Ho6rrqb53aiPW9VVfXzIQZ1vVaLU2GkWZ?=
 =?us-ascii?Q?zF10HoBuV7TI92AxgD2whCyk+xzzfApU0rPj8mDW1bE+SjSteRhWgcw+D1if?=
 =?us-ascii?Q?r7sGQBV2hcnk7FLceh6y8BUP1W+MYySTqPIyC2E9qIWi4P80C+UM4zVnNPm1?=
 =?us-ascii?Q?QdFTIA/oNK+8GiPCTOSTyEey8lg/NRY1nilHZiiUnfrvEk4OrTorCIfCVHfF?=
 =?us-ascii?Q?3cNB58q+PBEVFuop8La3+xqgW2PCpdxMYJiJKtkq+g1fv/4084QDsr/Hdxit?=
 =?us-ascii?Q?jg8jbJFHDF3L7ufqSqEdHmhiqBXtDpgEO7wcVqvHjedGJp5MQMhFeHqATsTf?=
 =?us-ascii?Q?gE4x8Ml1MiaHWI8h5bbg4eam+kOpqie+gG+LCnsR78RmCP9Jkp11GjanfstZ?=
 =?us-ascii?Q?v8KsbYwRtdJFFtqZKKLWHz0+mPsFqOfbJmMAJqz3TNwrJEyGq/mloqNBuhqB?=
 =?us-ascii?Q?FdA92sefcrU2VJ0XjHSzSXb8tflPZzdtkcP3KCZq41hh1u1PXz9/H9Nnkg/A?=
 =?us-ascii?Q?yhRhisTJPI05Ltq0cEZcaObGx+MRiCO9ZyKMrff68Tt9maYZCPKPD+UV+9vN?=
 =?us-ascii?Q?Br/CeXPmTRsxCjBNto914DNvpuyVlGb4nIMWQzYSTsQNkaYCSIQCFHTdXlCI?=
 =?us-ascii?Q?fVEMBaODJ8MOilu0jJHSurBd?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8fb2f268-be1a-4daa-5d38-08d96725bcf0
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5144.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Aug 2021 17:36:43.3146 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ye2yhfrvb/80e2ywQ/4NHoI2FchUW9fOdqE7voeMGlMnzdGyANpkPV5aeLourl8/Aqs7UPbhi2OxyUcnNGkEFA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5126
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
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Fixes an unhandled cases warning and defaults to a more
logical return value.

Fixes: 808a662bb3a8 ("drm/amd/display: Add DP 2.0 SST DC Support")
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/display/dc/core/dc_link_hwss.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_link_hwss.c b/drivers/gpu/drm/amd/display/dc/core/dc_link_hwss.c
index 97de1c5ab3a6..29b9c128c87c 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_link_hwss.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_link_hwss.c
@@ -730,10 +730,9 @@ static enum phyd32clk_clock_source get_phyd32clk_src(struct dc_link *link)
 		return PHYD32CLKD;
 	case TRANSMITTER_UNIPHY_E:
 		return PHYD32CLKE;
+	default:
+		return PHYD32CLKA;
 	}
-
-	//BREAK_TO_DEBUGGER();
-	return TRANSMITTER_UNIPHY_A;
 }
 
 void enable_dp_hpo_output(struct dc_link *link, const struct dc_link_settings *link_settings)
-- 
2.31.1

