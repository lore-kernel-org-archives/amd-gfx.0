Return-Path: <SRS0=hRd6=IB=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E719C433DB
	for <amd-gfx@archiver.kernel.org>; Wed,  3 Mar 2021 15:20:48 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 930C664E7C
	for <amd-gfx@archiver.kernel.org>; Wed,  3 Mar 2021 15:20:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 930C664E7C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0BE9D89650;
	Wed,  3 Mar 2021 15:20:47 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2085.outbound.protection.outlook.com [40.107.223.85])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B0F7C89650
 for <amd-gfx@lists.freedesktop.org>; Wed,  3 Mar 2021 15:20:46 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CkbyFo7RwelTXvUcIUzNcIj3aGYacF31jQ3E5HXbdGqAH0NShsuY754cchsJUx6TPqGcgZwUa1MBlgJEkuH6WdZjxOJh+1aYX1VQPFvXK4UDjOkL7PL/VH78cR4XDk55IQfX/Sv/wKB/iuIaE5ox9rQe1otBTW2OoEpXJQto/jZae3AmlzJSU2Smsmr1gQf71N4uSclm5/IXu5hyupS0XmO+1W2zTMXHsOoD9eRm66tJIT4X6ENW5DvtTATqfMnEcWhhRfM69ZSJ/xDDRiCiL/W56zYk8GHtEOtDP3CbEdP/nLv7mV9zpkltrFXTTz97D3nOtoL60I+Csx6jWHiKAA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6hWKLp+IPeOmy5shmrrnqn4BU1pOxM8qOMZ1cfnqOik=;
 b=AYaV5Das5z5zYmg7mcIG6rqKhlW0sNJpxVo8ZnfzpOoNZuAbQD+JDWoiAfZXkyxs6HgtoPRAGeAXMeHccsFyFHBlq5sB9xjDHuxw4SF3NhprBdU0FSPgmcCorPFiB7dUnQomWC204UxxfW47pnK29wNmB0cEzsAfULFewnzIXuVW7IVE9/qkip+/azvuP48Mo5YFU+axJiWXbzru4347wuoeAdZ+SWAJQgtq2ljMtKOYLFvhpoDmHRoKzf0FNpYeXpq3GsSLM7G+RFsIgMckjs/9OtSZAkwxu/RpgaflzmMVLrKSwYJuiQ4iNxvG+KKmTTx4OzJNFyC4IOmbLaCujg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6hWKLp+IPeOmy5shmrrnqn4BU1pOxM8qOMZ1cfnqOik=;
 b=oBG8ihFN9+rtykyyeBv0cCg4epgbrfVQ9qiAwif0wZ5zfTrOHyrX+/SzVHAFQCTWVET7kA8lYJ/c7M3ey04dKH43EPvKznGXmk33X/x04TV70mqe5tDAOygjHSEdS09QQ1g08trl3CbdDZFNDjWdRdc+zeFKCaRz13J1W6OT8PM=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from MN2PR12MB4488.namprd12.prod.outlook.com (2603:10b6:208:24e::19)
 by MN2PR12MB4471.namprd12.prod.outlook.com (2603:10b6:208:26f::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3912.18; Wed, 3 Mar
 2021 15:20:41 +0000
Received: from MN2PR12MB4488.namprd12.prod.outlook.com
 ([fe80::b0c4:9a8b:4c4c:76af]) by MN2PR12MB4488.namprd12.prod.outlook.com
 ([fe80::b0c4:9a8b:4c4c:76af%7]) with mapi id 15.20.3890.028; Wed, 3 Mar 2021
 15:20:41 +0000
From: Alex Deucher <alexander.deucher@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH] drm/amdgpu/dc: fill in missing call to atom cmd table for pll
 adjust v2
Date: Wed,  3 Mar 2021 10:20:22 -0500
Message-Id: <20210303152022.260614-1-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.29.2
X-Originating-IP: [192.161.79.247]
X-ClientProxiedBy: MN2PR15CA0041.namprd15.prod.outlook.com
 (2603:10b6:208:237::10) To MN2PR12MB4488.namprd12.prod.outlook.com
 (2603:10b6:208:24e::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost.localdomain (192.161.79.247) by
 MN2PR15CA0041.namprd15.prod.outlook.com (2603:10b6:208:237::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3912.17 via Frontend
 Transport; Wed, 3 Mar 2021 15:20:41 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 266385ec-c532-4e98-e9f0-08d8de57e882
X-MS-TrafficTypeDiagnostic: MN2PR12MB4471:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MN2PR12MB447197975B4696A223961379F7989@MN2PR12MB4471.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6790;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: uiluDt9l4pyIw4p/rYf+x7lPpMQr/UT5L1C7fyNFDS7EXARLyR96xOtrwJjI3tnsUddKJWdgpuFNjSJX1st9kjwKdwgouPxfvs8brpoL+4P5cCVvXsia0G5dnbtt9dKFCVIh9Z1PEM9dw3QD6poW0wOQkMYWIY80cOvuODii7NlQVlkNOaP6TkaJnNnwp0FzB08z+0hb9Uo5guWcnUGJcPZVbKdgSQuxfEEKxbnFiGeMFIRoB5f3nuDH6ismC0Ou0DThDwydNPCNOQwFizmki2KWhNWo6HMiA/NMuugghTWwW0enZ63nRO36UnS/K9eXGA3Pcd5w4KGz8RPCTrG3N7cHH5OgHCCXFC8n0zHM+M/pN1CkIKFDX8LXXnKzsjSGsoSuThBq6la8XjqHDO7qZC2tIKtelyrOmT1Aw/gD2e157D5TL8covLbWcFU9X8cjybTFqln06Gy/gVGYa60W+d3sssRYjGJek9EtXpg0w0kMF1E8/nJw0fJJiOjTwRinkq370fbOBPpmlMF8nkWpaiXKFBPvHSUN1npNcXkhYhM//QM8Vly7plTsjjhVAWi5wjHuksANwIWHlbWum1+xTA==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB4488.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(396003)(376002)(39860400002)(136003)(346002)(366004)(83380400001)(36756003)(52116002)(1076003)(478600001)(16526019)(186003)(5660300002)(26005)(2616005)(956004)(6506007)(8676002)(8936002)(6512007)(69590400012)(66476007)(66946007)(66556008)(6486002)(6666004)(2906002)(4326008)(316002)(86362001)(6916009);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?B1iBbaBKMLytKRQ4MTF1sBUolyHKoRtlbQtoj67tKrcx04/A5bCPTdu5sh3Y?=
 =?us-ascii?Q?aY/vBuLEG7m+FxrmgjAFrMK9hjM4pLDiQBmEbRLFify2sTDT0MNgFeCMFDR9?=
 =?us-ascii?Q?G47pDSM1NpuexQQ0twmevxbUA+wP8xpKeD5T27q5XvoD3l+0zR9/aw/l/4Or?=
 =?us-ascii?Q?ivChrh0hGRSIOPS7TWWStTSzxmJO2qHRjs6KCjJjKy5pVvN0LdJn9ZASZypf?=
 =?us-ascii?Q?4KfEn2UcV7qwRD7CoGwTiKYcpcgDuSeXknoJqj8k/57VhiueSF9lITPJwVFG?=
 =?us-ascii?Q?jf02w8smKlNYL69UGEPB2nbA7ugkFbg85q1/IGA+LS2p6aFSdJI93PehZErU?=
 =?us-ascii?Q?ehF03Mybr/0xbkLPZhtpCg7QPH4H1tb7BdlU/YBUDC5juwLSPIgVG4D98PV5?=
 =?us-ascii?Q?ruqWLtAh2PvisnPi5iKsrsVqlm9kIVEKrE5v7Yz4TidJq1n85RHOSmwfjh5E?=
 =?us-ascii?Q?9CmdYAsbbi6MW0FJqDvA5Wbkz/LxhB9gR87SoHGF60O4qqqRxVx84oBYCaYD?=
 =?us-ascii?Q?LE0qxTU8R/HU0J9VSFIs8MRkRXJSPd/YOuckqwDS2GE3MQIA+Y+sdDJIpULJ?=
 =?us-ascii?Q?BnVoNVV7jc3BNUZHBB8QxXvtMEU4rxorLMsXWiXaeaTdkp3A3OlVQ6w4Llg+?=
 =?us-ascii?Q?xJ9Zj8mISEGgEUAWjeV2MBrDoqe6G82B2ChLSKzCZ+Wl7gBjBhUBdaoHmGHC?=
 =?us-ascii?Q?0pcEHckNJjc9BSxxjeAMNs4FwMuimPyDO99FseNCL3tlzUKyU/DE07ujYGJY?=
 =?us-ascii?Q?9DK8l93BhWIc+AyCWqPt7fMIUJsjZecw3job+M7pfhLwqNuixnYZup3Lk9V/?=
 =?us-ascii?Q?lOuLHw9O83l5kqSSp4b4G4HhFBfiNxiULkn2WEMxsVNAqy8U198tkAa723S6?=
 =?us-ascii?Q?jHCZk4q/iAlaGpYN0twvbI1VXQh2Q7r5jTE37WfKQnJ4JbuQb3thkPivHhkA?=
 =?us-ascii?Q?K/Y13wtT3LcTYLneSmpgVbx1FejmMne2crELrdSZM+SkPndU174jTZtTtai1?=
 =?us-ascii?Q?eCwmaC0/UkDWIRKEqfp08uuXDDUhd1UY7NwUBp/wNtQL0OcYoPuvdTn2dM7T?=
 =?us-ascii?Q?46L93oZL8cyMAAhO9jgOxWWmhcfgXv0/DJLA/TkE2ufQOzVEykVIRA2frZin?=
 =?us-ascii?Q?e/0nTbqS/wsq9JPScbK8CfbJhuez6SBHr8tqnuaImu81VeOkEaTcVobKbJVk?=
 =?us-ascii?Q?s9xPjidNGTvqOaZ8biFJEfsa1MPn/365URTvUoWObyNDrUjf4XPnKjTUoJEC?=
 =?us-ascii?Q?gK1Qxt1tNQwa+QuK5A3MAMnvwcmks5FVyDMH/phPpo4eIcQCQzjtZhxd/Df3?=
 =?us-ascii?Q?edPTFg3TCVfiFLX8nl692Twq?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 266385ec-c532-4e98-e9f0-08d8de57e882
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB4488.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Mar 2021 15:20:41.9002 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: P1N2e/2n7qXrqkPznmYz2uZRM8RrF8a8NdohNOUbSnPy9wGbdRMMh405JEXGrEcFcRWytGl4Qd2xCY5cH37dLw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4471
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

We set up the parameters, but never called the atom table.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 .../drm/amd/display/dc/bios/command_table.c   | 21 +++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/dc/bios/command_table.c b/drivers/gpu/drm/amd/display/dc/bios/command_table.c
index afc10b954ffa..ad13e4e36d77 100644
--- a/drivers/gpu/drm/amd/display/dc/bios/command_table.c
+++ b/drivers/gpu/drm/amd/display/dc/bios/command_table.c
@@ -1531,6 +1531,27 @@ static enum bp_result adjust_display_pll_v2(
 	params.ucEncodeMode =
 			(uint8_t)bp->cmd_helper->encoder_mode_bp_to_atom(
 					bp_params->signal_type, false);
+
+	if (EXEC_BIOS_CMD_TABLE(AdjustDisplayPll, params)) {
+		/* Convert output pixel clock back 10KHz-->KHz: multiply
+		 * original pixel clock in KHz by ratio
+		 * [output pxlClk/input pxlClk] */
+		uint64_t pixel_clk_10_khz_out =
+				(uint64_t)le16_to_cpu(params.usPixelClock);
+		uint64_t pixel_clk = (uint64_t)bp_params->pixel_clock;
+
+		if (pixel_clock_10KHz_in != 0) {
+			bp_params->adjusted_pixel_clock =
+					div_u64(pixel_clk * pixel_clk_10_khz_out,
+							pixel_clock_10KHz_in);
+		} else {
+			bp_params->adjusted_pixel_clock = 0;
+			BREAK_TO_DEBUGGER();
+		}
+
+		result = BP_RESULT_OK;
+	}
+
 	return result;
 }
 
-- 
2.29.2

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
