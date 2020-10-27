Return-Path: <SRS0=SqeI=EC=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2DE5EC56201
	for <amd-gfx@archiver.kernel.org>; Tue, 27 Oct 2020 20:53:01 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D9383218AC
	for <amd-gfx@archiver.kernel.org>; Tue, 27 Oct 2020 20:53:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="yHHtSRRl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D9383218AC
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 812226EC59;
	Tue, 27 Oct 2020 20:53:00 +0000 (UTC)
Received: from NAM04-SN1-obe.outbound.protection.outlook.com
 (mail-eopbgr700077.outbound.protection.outlook.com [40.107.70.77])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 85A2F6EC57
 for <amd-gfx@lists.freedesktop.org>; Tue, 27 Oct 2020 20:52:58 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Z6jvvIzsVXYhJuk6S6qpskm1mpDWeFoOIQ0USrkNo34VwYIu/JTqQg4EDGQFDehIjr4Ov/PJdUKYdv+QUs+M/4I4OSGtlRsR0/3VYWvpMHMw8VdHOXlovc9PmwwkOwzAwesAZ0r/0cM64AvKAvgIfptzn0L69l6UuPWWE4lb5OxGJdna6wAS3pkUAyL5WxjnV7gyckOMTlbKRMVyXx1A3reGRU32bBHciHV2PgZPOUT/G2kxBwsLf0thbGZxT6MtIt3mRbgReFsArXtRrIB/z4fR6xBhHQA8np6rQxd0s9gsKEQsIZpHAvLH81xf5hw5hPaQfum+6bEfC+AT4R+z3Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SJ7Ysz1RjnWrYxRZMcAFTY6dxJE69suYMpJs2HrFxrc=;
 b=h1iVBdcgYVwcw8L+IxW0YYNOW7dJgY7LZjGnkXEaCQIsa6tS9IkRvdfbycC19zEJlD2bbFW3Ato2bRlg5exYyhOEzdPYO3UNsq6En3UeJQVWnbDsKUJCVEvaH/Vps507DyCLwEEbwCHCHy4A77Ccun7w1AX7sKE5sPAdW+o4qMiaXedmgAs8txdNbcPqX2IldOqaDw30eoTam8DBH/JkYQRxjegMujPQUIfUhTo7sltCUMzShKBLSqL14ycaMn5ZGQLNxsipRke+8Ek8bbcg08ndPIjyGVgoW8bf6jbAVS0ihRUn8a4YOtErDfD9i67tSzkmhNJ4+iYJ/IOhKJCkjA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SJ7Ysz1RjnWrYxRZMcAFTY6dxJE69suYMpJs2HrFxrc=;
 b=yHHtSRRlN7qbwvRXC8OdJg5OnHf23UgIIefQIiwlh9hbcpWM5rhVdCP2rEOH5agMcwhGHPS5edCddEnNZngKsFM/lTqXZo8qSfyB1ToHnIfnOZLkaHHe0htrlt1yi99hGDptT+O7DrrKg+pp30kKG2xr/iVxVT2xx2CgJUewNYI=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from DM5PR12MB1884.namprd12.prod.outlook.com (2603:10b6:3:10d::12)
 by DM6PR12MB3595.namprd12.prod.outlook.com (2603:10b6:5:118::29) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3477.20; Tue, 27 Oct
 2020 20:52:56 +0000
Received: from DM5PR12MB1884.namprd12.prod.outlook.com
 ([fe80::a82c:a1d:81ad:42f7]) by DM5PR12MB1884.namprd12.prod.outlook.com
 ([fe80::a82c:a1d:81ad:42f7%3]) with mapi id 15.20.3477.028; Tue, 27 Oct 2020
 20:52:56 +0000
From: Qingqing Zhuo <qingqing.zhuo@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 07/25] drm/amd/display: stop top_mgr when type change to
 non-MST during s3
Date: Tue, 27 Oct 2020 16:52:16 -0400
Message-Id: <20201027205234.8239-8-qingqing.zhuo@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20201027205234.8239-1-qingqing.zhuo@amd.com>
References: <20201027205234.8239-1-qingqing.zhuo@amd.com>
X-Originating-IP: [165.204.55.250]
X-ClientProxiedBy: YT1PR01CA0099.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:2c::8) To DM5PR12MB1884.namprd12.prod.outlook.com
 (2603:10b6:3:10d::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost.localdomain (165.204.55.250) by
 YT1PR01CA0099.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:2c::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3499.18 via Frontend Transport; Tue, 27 Oct 2020 20:52:49 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 96342b22-e5d7-4c8f-a2bc-08d87aba4400
X-MS-TrafficTypeDiagnostic: DM6PR12MB3595:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR12MB35954D3680A764172C08EEA7FB160@DM6PR12MB3595.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 86yoHYeTinj4FWbHEM1nKsK6tkIyXh6HXi2sx5k5ClMzIJZXn3SsDwsOb9n6RyWzBuhAbrXAAs1m3d9k8qymY8Pp0nHUz8owAlKselRRlqdZ9bykBZDbDdm8YANQ97WLSMzvN+LcTL2vsVDV2y2RytitR4rsxNylx+hvaMWVB0xF366gVUOVyMka+c4ZSI3ikf1tkoXPwsFcu3wmynBl3I5W1ugN+VbaUnASRRiqhE7Ks9jBIpPLTLEy72NBuAVgPRAeDDhPjYXMFrIGsI3eYwvuCTmgxICx727KwAKgqBZ8vvCanein80xUzlCcPVCwdBb/UwdHS2GbS+a9sV5RUGlT1p8ID2JJONQjc15U/YLjmyExKXWetitiIIbiKMoU
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM5PR12MB1884.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(39860400002)(346002)(376002)(396003)(136003)(6486002)(6506007)(2906002)(26005)(66556008)(16526019)(186003)(6666004)(2616005)(6916009)(52116002)(956004)(66946007)(316002)(1076003)(69590400008)(44832011)(8676002)(478600001)(66476007)(5660300002)(4326008)(86362001)(36756003)(6512007)(8936002)(83380400001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: 56OODmKn03U6OMtb28wzIcxgyLhCQMA+P8UTjGSi6eXOeDUlolCO2beBl2iB+L9R8ZC52+2IkZki0f9MxhusmJLJ6r/SeD9c6QfYS56AF9IyvvmpkYjO5EcLyjDmDoe+Ot3tdaT5uIS27QREPT2Rc98IaEChdJdBkVgbaAAFSAJGUmL42vQFeYg/5sxFfbp5DQN4NHkh34E+h/+8HBrJz5EcjfTkw32EP0sSefGXXdwVnORYhQK5TRFv23HSe3PqCW4NM7ubIXwP1d0Db0Vej+zQ9zVBlnonHXMO2UYHa3CMdJCCgE9FRWwIQ0L1ui7hJA3RCbEi0uq7G+Joe8zUKslWIwsIDNJQebwvm7cjWCDCsPL37lJru5hsBTjTqobmjyxeJvbzA+CpaelSTE66gFI3NCditMZgZIuId+TlSTT2EBGQL9RnZBrRUdO1Ch83zjyAfIFfWV74ZB7HtSMeVhddjJMXabY58dEJ4XxKLfSg8/1QzRYyU+scgPJkgZMK5i3fW/maXCy2UzimXk0f3amJKYQC9XbQk0jDHgPJt63APdYWVFRMOrvvh9bs3hMJOhjwxq9XV5fcW0/nltaN/za4yGojKAfXbvSZ8vAYj638fN6jECQXfElaC0zE+qzIx5oiEq3QmHssYBGxX+f4qA==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 96342b22-e5d7-4c8f-a2bc-08d87aba4400
X-MS-Exchange-CrossTenant-AuthSource: DM5PR12MB1884.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Oct 2020 20:52:49.7782 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: O2Zhp7n6fWqnIOCP6RNaBrw27ZBNBk1QgWChxq3nl1Hj83iFFfyYA9rbgmMKRFD0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3595
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
Cc: Lewis Huang <Lewis.Huang@amd.com>, Eryk.Brol@amd.com, Sunpeng.Li@amd.com,
 Harry.Wentland@amd.com, Qingqing.Zhuo@amd.com, Rodrigo.Siqueira@amd.com,
 Bhawanpreet.Lakha@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Lewis Huang <Lewis.Huang@amd.com>

[Why]
Driver keeps the invalid information cause report the
incorrect monitor which save in remote sink to OS

[How]
When connector type change from MST to non-MST,
stop the topology manager.

Signed-off-by: Lewis Huang <Lewis.Huang@amd.com>
Reviewed-by: Tony Cheng <Tony.Cheng@amd.com>
Acked-by: Qingqing Zhuo <qingqing.zhuo@amd.com>
---
 drivers/gpu/drm/amd/display/dc/core/dc_link.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_link.c b/drivers/gpu/drm/amd/display/dc/core/dc_link.c
index 5652a072d9be..4dfa70c0301b 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_link.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_link.c
@@ -854,6 +854,7 @@ static bool dc_link_detect_helper(struct dc_link *link,
 	struct dpcd_caps prev_dpcd_caps;
 	bool same_dpcd = true;
 	enum dc_connection_type new_connection_type = dc_connection_none;
+	enum dc_connection_type pre_connection_type = dc_connection_none;
 	bool perform_dp_seamless_boot = false;
 	const uint32_t post_oui_delay = 30; // 30ms
 
@@ -889,6 +890,7 @@ static bool dc_link_detect_helper(struct dc_link *link,
 
 	link_disconnect_sink(link);
 	if (new_connection_type != dc_connection_none) {
+		pre_connection_type = link->type;
 		link->type = new_connection_type;
 		link->link_state_valid = false;
 
@@ -962,6 +964,12 @@ static bool dc_link_detect_helper(struct dc_link *link,
 				return true;
 			}
 
+			// link switch from MST to non-MST stop topology manager
+			if (pre_connection_type == dc_connection_mst_branch &&
+				link->type != dc_connection_mst_branch) {
+				dm_helpers_dp_mst_stop_top_mgr(link->ctx, link);
+			}
+
 			if (link->type == dc_connection_mst_branch) {
 				LINK_INFO("link=%d, mst branch is now Connected\n",
 					  link->link_index);
-- 
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
