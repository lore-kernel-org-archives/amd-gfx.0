Return-Path: <SRS0=ko+j=DX=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 554ECC433E7
	for <amd-gfx@archiver.kernel.org>; Fri, 16 Oct 2020 03:28:32 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D966A206ED
	for <amd-gfx@archiver.kernel.org>; Fri, 16 Oct 2020 03:28:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="WIEGGIFb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D966A206ED
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7AA3C6EA88;
	Fri, 16 Oct 2020 03:28:31 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2053.outbound.protection.outlook.com [40.107.92.53])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B3C056EA86
 for <amd-gfx@lists.freedesktop.org>; Fri, 16 Oct 2020 03:28:30 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=H2GHKK3NJ+KBeDkSTxauxmNh5dOu8s2HS0HoPPS62sdDusGebLSSdRyZmUT7DV0Nmuqyi3pwD6FO2akb0+dPI0CLD82Fff0qZK1bqOHy4m2jzhMlJIyEClDDwH6qXCpptGDNFsq5gt429UcBznG9nL6hAQuMkAtrcheIMoA/uu4MTzsbtRdO/hu/0naTg9rRkBSrUK5a3JnAP0otfv78VVqp5RAeKEJx65/DvBQKFP2scaAqVT8wHP2PHhB4CCcH3idJcPMBQ2uzu8tW8lUUB8yd4T/XFfjqB7rJoGNC/vFvSzcbiZZprT+Cd3znYybxlNDUp/J7tLaxQYZCzpXhAQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7PNDmUKTBRP2CLQk7itfOXbYy90v8zWcXecuXNJW0Fk=;
 b=ZAmNjz2vycYyM3upR6qFaecq5OyVrxu4k7U9jyAHl7Kf6GHH7e4pu3SVVj+hKf3dBRonQrX9pcw4/Ojq/N0uBlknQKLrRaK8n7fOOULHVHn0YQnxhL+TgpmgaOAp2IUQIpNTv2Z88I+4xYUbkBok7ucukVBKbwrfnBVfoHZSBQeDyaGoNxmdeXuBND76cjrYRrx14F37hMMO8YDDc12W8AkNzc/XF809TxTvTMOzQwT83Ap8pf0GALjnJhWx5x9YNpxhWLEkLm6P2N+3xYqrsnyRTItqAdV3IGedWw8TJpS7J3NDDHM9agAqjmy1tGzU+tl5UAY+W4r4lOxoHf8QDw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7PNDmUKTBRP2CLQk7itfOXbYy90v8zWcXecuXNJW0Fk=;
 b=WIEGGIFbofPsGzk3upKUHQbKiBqWavmxWJp93UW852bwiKue/qvFKay5WVeXD5uZU2bSuggKq/XDlLHOFjjcwSqpYEirfwvZGZQdGaZP/TaO1hdztxwMHj8LyCYIe5sqtAl+SbiSs+IzHtnmfyg1ToHkkjTx9HOfP+PXcQHa6AU=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB2619.namprd12.prod.outlook.com (2603:10b6:5:45::18) by
 DM5PR12MB1354.namprd12.prod.outlook.com (2603:10b6:3:7a::17) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3477.21; Fri, 16 Oct 2020 03:28:29 +0000
Received: from DM6PR12MB2619.namprd12.prod.outlook.com
 ([fe80::bcb1:de80:f60c:8118]) by DM6PR12MB2619.namprd12.prod.outlook.com
 ([fe80::bcb1:de80:f60c:8118%5]) with mapi id 15.20.3477.023; Fri, 16 Oct 2020
 03:28:29 +0000
From: Evan Quan <evan.quan@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 32/40] drm/amd/pm: correct clk/voltage dependence setup
Date: Fri, 16 Oct 2020 11:26:44 +0800
Message-Id: <20201016032652.507-33-evan.quan@amd.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20201016032652.507-1-evan.quan@amd.com>
References: <20201016032652.507-1-evan.quan@amd.com>
X-Originating-IP: [58.247.170.242]
X-ClientProxiedBy: HK2PR0302CA0007.apcprd03.prod.outlook.com
 (2603:1096:202::17) To DM6PR12MB2619.namprd12.prod.outlook.com
 (2603:10b6:5:45::18)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from equan-buildpc.amd.com (58.247.170.242) by
 HK2PR0302CA0007.apcprd03.prod.outlook.com (2603:1096:202::17) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3499.8 via Frontend Transport; Fri, 16 Oct 2020 03:28:27 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 9d06f157-2b35-4665-5631-08d871838cdc
X-MS-TrafficTypeDiagnostic: DM5PR12MB1354:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM5PR12MB1354607BC0EAD61C42985BF9E4030@DM5PR12MB1354.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:288;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: NZKe919+fE27KrCPoM0IchGyuz//aPNPWWNrBC8XkUYYvkOGsVx9Aa6mTxo+qq0KgVvRm2jv8Z4rD83FPKkiXQAgMkZz2MY2db7t8i9PFrDcz/cagAiRdY7aIb/AjAzCq38GYBIg64JRv0hG4/9gcW1iLf1iPc96pMbc3DJSLkWU+jMJ33q+J/+90fdD1jATz0sRVtQ7MMw58FAm3XIl9N8J1lkvNkvAeWhPi+RusaD38On3MYykBv3J4d3tWdBwGBndlmgKIiP+iB1rEUtcgXNJDQahgRtDc+LwHMtBX9SMj0DMhyuZcYOWHWihqBlljrBE8w0PAfi/fmrdfRtmAukeUNbiv9+jh0RFCQlA07I20E91YcmPgdqy3C7LP0qg
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB2619.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(39860400002)(346002)(396003)(136003)(376002)(66476007)(66946007)(83380400001)(1076003)(8676002)(6486002)(5660300002)(8936002)(66556008)(6916009)(86362001)(52116002)(36756003)(7696005)(4326008)(2616005)(34490700002)(478600001)(316002)(6666004)(44832011)(16526019)(186003)(54906003)(2906002)(26005)(956004);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: Jyyu1rpWTnFk2YLOGOhAh7O0N90yaU9skQ+5dgqXeHnNQuox/zJ1C/GrcU7W5kuLRNYg6C89+zSRn7OeRKr24yaJqEtmGsP2naMeF7wBQhnp8PiJ6AxELw3rw60TqpxAwDytZYAXKPoIPci7QCeMbXBvLKbLzmRnMWi/yZ4ZPtE54SFF2k+ATNLHwaJtma9AHjQkHmlmmVANi+NK8JFUX3ff9gHjE5+B4+mHzB2WjxpP1QSzkmhzSffRy41DVLUkKAYRB1tL1etjEXNVKECkyhPACE34az9acblwxN+NG4Nxij60I4my+TEKeEnFGw8fdBiCDPmyNOjD/DN3OT2WUp/tfbUfaPmJdfoME1G6AXuv0l2dtiHnazkLQuPFt3ppt3CpMQTKWGCl+u/MqkD5ZYlPoQJhsmIP11hL6ToXEPNQHlM/b1p4EWaP1FWJpFBLDO6JCPkZk+ocEKfzTzgP3i2K/fZ5gjtjoBgFjU2fZOpn8LdodZGWosSVnn6zuFSMWfbHFsw3R3j5cTn/BbwRap4FmMiTKFT/DcdQwb2d8/CWyj/s2IOZq+qeOSn+9yDntYruWWkWSSQjB/lis3KVxR01TSKU2mptZJSXXg+AW/Fl4V+fM/4wgHcVVS6AyI1TMVDIu8GJqNNm6/RB8Brwaw==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9d06f157-2b35-4665-5631-08d871838cdc
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB2619.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Oct 2020 03:28:29.3738 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: s1oEBCtPQ+n8h+AebchR2KeUO6eDyXWLlmnlkKZGu5PAslP4R/WyKGjSQnE1sM6z
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1354
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
Cc: Alex Deucher <alexander.deucher@amd.com>, Evan Quan <evan.quan@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Correct Polaris10 clk/voltage dependence setup.

Change-Id: I3f73782c8933f50778040c5cf3946134d9378ade
Signed-off-by: Evan Quan <evan.quan@amd.com>
Acked-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/pm/powerplay/smumgr/polaris10_smumgr.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/gpu/drm/amd/pm/powerplay/smumgr/polaris10_smumgr.c b/drivers/gpu/drm/amd/pm/powerplay/smumgr/polaris10_smumgr.c
index 41df6e7813ea..47230d8fb592 100644
--- a/drivers/gpu/drm/amd/pm/powerplay/smumgr/polaris10_smumgr.c
+++ b/drivers/gpu/drm/amd/pm/powerplay/smumgr/polaris10_smumgr.c
@@ -401,6 +401,8 @@ static int polaris10_get_dependency_volt_by_clk(struct pp_hwmgr *hwmgr,
 		*voltage |= (data->vbios_boot_state.vddci_bootup_value *
 				VOLTAGE_SCALE) << VDDCI_SHIFT;
 	else if (dep_table->entries[i-1].vddci) {
+		*voltage |= (dep_table->entries[i - 1].vddci * VOLTAGE_SCALE) << VDDC_SHIFT;
+	} else {
 		vddci = phm_find_closest_vddci(&(data->vddci_voltage_table),
 				(dep_table->entries[i].vddc -
 						(uint16_t)VDDC_VDDCI_DELTA));
-- 
2.28.0

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
