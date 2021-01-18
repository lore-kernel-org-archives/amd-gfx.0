Return-Path: <SRS0=twpl=GV=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BBBA0C433E6
	for <amd-gfx@archiver.kernel.org>; Mon, 18 Jan 2021 13:22:09 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 64BAA206F9
	for <amd-gfx@archiver.kernel.org>; Mon, 18 Jan 2021 13:22:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 64BAA206F9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EBF346E218;
	Mon, 18 Jan 2021 13:22:08 +0000 (UTC)
Received: from NAM02-BL2-obe.outbound.protection.outlook.com
 (mail-eopbgr750058.outbound.protection.outlook.com [40.107.75.58])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C100C6E218
 for <amd-gfx@lists.freedesktop.org>; Mon, 18 Jan 2021 13:22:07 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Gvh4uL/N8FTDovkh74Situ9TaGhKh6ZNBnmRzu5WUmnsAOu/keybahofM++GbLp7vvTGOdmfQMPEUDkcQjJVecwTVx/g9aRfXDnPm26gKoS5M+fw1kj4axQTFxNu6b1tWAY0pNKB3DXJowMm8l17/nm3YdX2MQEy9U3xICs4lOWlpYXg/jth+GYwGb4jEyBSnHHiaEf58rJhEuSXAcfLLNUl1o5+Q9efVEFYBZ37AheXsw3xE8KOK5mHCWzp/gbVD1KyPLmGk6SOO/ni4QFatF3KKrgWO47IL8sCEQ41MZCL6qRuihFgI1/tlNtIh6/vKMPYdANekJGXzOp0ssNMNQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=f2I3H59mdV+j9anavipuzN1TAjHZ/TVeKeJ2P8QALkE=;
 b=kzj2eDmQZgrKvro2XWkFHSHvKjUz/18x3OtyKNhEIHZhNKdRDsPxVjIgL68JCIBk44LfqBTP6Un7WJrAgijy3kBACzWCfAWtFiR8pja8RoqCwaeEZDASL11QcUZDBs3l9e4PbhMlCIXFujbfQMVggeCCfTlmXxlEt4Rshl/vX7UviyEU4uKLYaIWaL5jeFdR3Tt3oTw+/7tdQHu98Gh11hXJSKlADQcX4Mqax8uECQsxlTAJQGgI1XYbhQxDtYXNdpoEr+ut4vM4f8bCJ80Ewm5VIt2aszGr5uRwNmIYxTFe08Ag5LVX65XGaYrkOqwyN4z1sjhB+BEscrqstk6fsg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=f2I3H59mdV+j9anavipuzN1TAjHZ/TVeKeJ2P8QALkE=;
 b=VvMAIinctH88aNV/+meDFZBdKcZaG/3BmHXPBgiXQqnDl8VBYVIHmmr4RP55AqYpZNsZpCZgrfVMkrGMTLtmTzssq1dmsTICxdwcpsnmgs+M17eG27l8qC4eNv4hsME1VC7NezbusUMkBcVSNb2vC7asc8rXH+uVHbMSES5xHJQ=
Received: from DM6PR12MB4156.namprd12.prod.outlook.com (2603:10b6:5:218::17)
 by DM6PR12MB4059.namprd12.prod.outlook.com (2603:10b6:5:215::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3763.9; Mon, 18 Jan
 2021 13:22:06 +0000
Received: from DM6PR12MB4156.namprd12.prod.outlook.com
 ([fe80::b803:7e6e:40ec:4a0d]) by DM6PR12MB4156.namprd12.prod.outlook.com
 ([fe80::b803:7e6e:40ec:4a0d%9]) with mapi id 15.20.3763.014; Mon, 18 Jan 2021
 13:22:06 +0000
From: "Wu, Hersen" <hersenxs.wu@amd.com>
To: "Vishwakarma, Pratik" <Pratik.Vishwakarma@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] Revert "drm/amd/display: Tune min clk values for MPO for
 RV"
Thread-Topic: [PATCH] Revert "drm/amd/display: Tune min clk values for MPO for
 RV"
Thread-Index: AQHW7YmmBbhZRHqq90WJ1kKbJIl026otXjhQ
Date: Mon, 18 Jan 2021 13:22:06 +0000
Message-ID: <DM6PR12MB4156C4367E5755786E85E75AFDA40@DM6PR12MB4156.namprd12.prod.outlook.com>
References: <20210118110341.489585-1-Pratik.Vishwakarma@amd.com>
In-Reply-To: <20210118110341.489585-1-Pratik.Vishwakarma@amd.com>
Accept-Language: en-CA, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Enabled=true;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SetDate=2021-01-18T13:22:01Z; 
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Method=Standard;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Name=Internal Use Only -
 Unrestricted;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ActionId=91ec07ec-002d-41c9-b519-c1741d9a2f13;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ContentBits=1
msip_justification: I confirm the recipients are approved for sharing this
 content
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [2607:fea8:3c60:9c20:5c34:a4d4:1511:51e8]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: b8f46b24-3ecb-448d-cefe-08d8bbb40d48
x-ms-traffictypediagnostic: DM6PR12MB4059:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM6PR12MB40591A3149238C8CFA33654AFDA40@DM6PR12MB4059.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:93;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: f54N+JZBKpH17I3gOp+MOgxRm8uhSdG6xp9mHR9l9iZEXCG7Cx2mc5SlG1foQbrLhxr/pFvgPoMVX7MKTnEnXElSvWb0KyMcuA7vNIoxRkTWqjE0Bm9eXGojPV8j9wEGCShMbzuUgPkcBZHXjes4n70zVoGiCM6mp+d3ddKD9gWvieM8O3hsspVT6IMfbtSX+wHE83ui+xNP4BtdWPd2OuN1RQhqbAnM+RL8XHHlI4p55B9C6VU+oHWdHIZug3KFs/ZYg8YQHWo6PjVqDGHxbfQ/xRzFNexeWLW9VR0tvPzq2TSH0hawMRLBy86qKeLPVuTCu2qGwFyJwPoo4vpb2h9efXBHO3gHqpJbyFAtu2vpXPfbaRu7Vooj5Rq2JDBVexQPGyIKUfcVv61EQq3yDg==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB4156.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(136003)(366004)(346002)(396003)(376002)(39860400002)(66446008)(64756008)(66556008)(9686003)(2906002)(316002)(186003)(110136005)(52536014)(55016002)(66946007)(66476007)(76116006)(478600001)(8936002)(8676002)(6506007)(5660300002)(86362001)(53546011)(83380400001)(33656002)(7696005)(71200400001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?kfo6egY4iBCgugmefSukQGfEwVDwRqfi+kxIgKVSzi4Xkh+vYwluKNFt2/7w?=
 =?us-ascii?Q?LS31hCEvvvmOzgdkUqu8sMGsQZpMzMWdg4milMnhLQZQpEkEmmHY4l7FlcAm?=
 =?us-ascii?Q?FUs1qZSez/+rgzeWFWvRijiPZgubVzvmRmRWhqp0JeiMA0jeDtaEC8SlWgro?=
 =?us-ascii?Q?B/FDy7XeROCiHvX6fRs7B1UwDdBF2UyoO8X/Bgteymj79DbuCFpRGL1RwgR4?=
 =?us-ascii?Q?UOfiozwKGwNsKvR2uragJasQyp20/tJnNUJdOzruK3sX6w8RmGXRrV2UvF40?=
 =?us-ascii?Q?t7oNUc6IV9Uv2B8IAbiVgG/UCc5KfSjMU//5rRjmCgkxlgUd7SaDu5LUcbhE?=
 =?us-ascii?Q?jIFZcjAc0j2gpv36IyEjrw6U4WYCCfMYti9d+3EZq5zH0Ac2RHkaAiUdD4pH?=
 =?us-ascii?Q?Bt23YJ54cUwwFJGS3XMr4HCh1mIS+veYiUbnxu4p96S2xBFSkGvA7GOsKhC3?=
 =?us-ascii?Q?e/OLi39F8ShhPdOLbpa6DJshqSO2MTmSC7NNf7jRoGkjR2G3nILHn20AIozQ?=
 =?us-ascii?Q?bKTi682qZqDQfrA5kDbCl9lw2lgTJJyJDCiaertC7jtplPTpAGMDl3jWy7sJ?=
 =?us-ascii?Q?sexTbeqw993ehknb7lOo+kL1rqjxxV7njaHXG8Ou+oe+AkgxX3u69lA1WRo9?=
 =?us-ascii?Q?dHKpaV7UPIG7SwrtpFTlikEUwdNCICzKzmDHs/n7tg8f1zFbk4FGceJS6+6L?=
 =?us-ascii?Q?YGXmzy1KtSNElcggvm632xOJLTgibVCs0Jm8hl/JCI3UmJshelsw4tmC+XXf?=
 =?us-ascii?Q?wtDMk94K2/z0TZ1L4DqDRd4qDVgyxdxVLFhSjn2uk2yhk10IWwkfgRTWNxkL?=
 =?us-ascii?Q?c26xLnE49DYyGQJdyvpFy+gdzo/zaIqRynswizvzTjKir209wbQwou1t8R/P?=
 =?us-ascii?Q?jG0ZMmyKqTEs1/haRWi02iqECu4FIl3a3Tk2ZMUhzAlIMcZ1WuE9NwZQeW1/?=
 =?us-ascii?Q?FJhKkbFQ1592itwiZKf601eL1nxr1ix8qCuxmy7c+nuRfLjlPJlETYaQ1Vzl?=
 =?us-ascii?Q?y1rcLDC3IMWFtKdg6fMy/C6bdEkZT08N0dga/EKaKJbYxnna56YDRwDgR3ql?=
 =?us-ascii?Q?QUiX9khrAI04Pr0kaDbcGtDOfnGivEfskJoQ5lmw452ukIKeekuhv/Bux90g?=
 =?us-ascii?Q?Q410Y1aoB4Bi?=
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4156.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b8f46b24-3ecb-448d-cefe-08d8bbb40d48
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Jan 2021 13:22:06.3043 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Q2wdn+lJ5mHjHjDc2E33Jj8yyUHzVcetQTTd1xKzkQF2eScZgachE8X+L1rRw9iorVAyyA45MqF3Pv3q2QrbnQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4059
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Official Use Only - Internal Distribution Only]

Reviewed-by: Hersen Wu <hersenxs.wu@amd.com>

-----Original Message-----
From: Vishwakarma, Pratik <Pratik.Vishwakarma@amd.com> 
Sent: Monday, January 18, 2021 6:04 AM
To: Wu, Hersen <hersenxs.wu@amd.com>; amd-gfx@lists.freedesktop.org
Cc: Vishwakarma, Pratik <Pratik.Vishwakarma@amd.com>
Subject: [PATCH] Revert "drm/amd/display: Tune min clk values for MPO for RV"

This reverts commit 6f3fca64cfb91fedf9b34ea27b2581e88d48c9b2.
Flash line issue when MPO enabled on idle screen was fixed by commit 9d03bb102028 ("drm/amd/display: disable dcn10 pipe split by default")

This patch is no more required

Signed-off-by: Pratik Vishwakarma <Pratik.Vishwakarma@amd.com>
---
 .../display/dc/clk_mgr/dcn10/rv1_clk_mgr.c    | 30 ++-----------------
 1 file changed, 3 insertions(+), 27 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn10/rv1_clk_mgr.c b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn10/rv1_clk_mgr.c
index 75b8240ed059..e133edc587d3 100644
--- a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn10/rv1_clk_mgr.c
+++ b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn10/rv1_clk_mgr.c
@@ -187,17 +187,6 @@ static void ramp_up_dispclk_with_dpp(
 	clk_mgr->base.clks.max_supported_dppclk_khz = new_clocks->max_supported_dppclk_khz;
 }
 
-static bool is_mpo_enabled(struct dc_state *context) -{
-	int i;
-
-	for (i = 0; i < context->stream_count; i++) {
-		if (context->stream_status[i].plane_count > 1)
-			return true;
-	}
-	return false;
-}
-
 static void rv1_update_clocks(struct clk_mgr *clk_mgr_base,
 			struct dc_state *context,
 			bool safe_to_lower)
@@ -295,22 +284,9 @@ static void rv1_update_clocks(struct clk_mgr *clk_mgr_base,
 		if (pp_smu->set_hard_min_fclk_by_freq &&
 				pp_smu->set_hard_min_dcfclk_by_freq &&
 				pp_smu->set_min_deep_sleep_dcfclk) {
-			// Only increase clocks when display is active and MPO is enabled
-			if (display_count && is_mpo_enabled(context)) {
-				pp_smu->set_hard_min_fclk_by_freq(&pp_smu->pp_smu,
-						((new_clocks->fclk_khz / 1000) *  101) / 100);
-				pp_smu->set_hard_min_dcfclk_by_freq(&pp_smu->pp_smu,
-						((new_clocks->dcfclk_khz / 1000) * 101) / 100);
-				pp_smu->set_min_deep_sleep_dcfclk(&pp_smu->pp_smu,
-						(new_clocks->dcfclk_deep_sleep_khz + 999) / 1000);
-			} else {
-				pp_smu->set_hard_min_fclk_by_freq(&pp_smu->pp_smu,
-						new_clocks->fclk_khz / 1000);
-				pp_smu->set_hard_min_dcfclk_by_freq(&pp_smu->pp_smu,
-						new_clocks->dcfclk_khz / 1000);
-				pp_smu->set_min_deep_sleep_dcfclk(&pp_smu->pp_smu,
-						(new_clocks->dcfclk_deep_sleep_khz + 999) / 1000);
-			}
+			pp_smu->set_hard_min_fclk_by_freq(&pp_smu->pp_smu, new_clocks->fclk_khz / 1000);
+			pp_smu->set_hard_min_dcfclk_by_freq(&pp_smu->pp_smu, new_clocks->dcfclk_khz / 1000);
+			pp_smu->set_min_deep_sleep_dcfclk(&pp_smu->pp_smu, 
+(new_clocks->dcfclk_deep_sleep_khz + 999) / 1000);
 		}
 	}
 }
--
2.25.1
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
