Return-Path: <SRS0=rOad=5B=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 679A4C0044D
	for <amd-gfx@archiver.kernel.org>; Mon, 16 Mar 2020 13:50:02 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3ABC22051A
	for <amd-gfx@archiver.kernel.org>; Mon, 16 Mar 2020 13:50:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="NRxOcbhh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3ABC22051A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E3FFD6E459;
	Mon, 16 Mar 2020 13:50:01 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2080.outbound.protection.outlook.com [40.107.236.80])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3487C6E454
 for <amd-gfx@lists.freedesktop.org>; Mon, 16 Mar 2020 13:50:00 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nN/YrhaqYSbu/TggqOuWi6hwzXcOpDK7zzoC/MVj2jqsXIzqPL7RRMC/CxOGf69mgkWCCix+rZwTbjtaVYZSkkdp9d30UxRYf2/6fHuj1B4e7ow9DMIBoeRVdo3OWeKoQjrkgXbRSjhgQiQbae1+bEIhnj0tZrlnB7r511YPruJnszYoZNVNQ+VKWeFARICAD0JLkm0eoCgspkbntPVhwnlegndpQBDca6QB2G33Cve0TdfFdyWhtlw09Sn6PILquPbMlf8ZsdrUE0ky9HZPuTCqdkWKsID8yhC2SHk27YBmVL/URfwPNpSgfB9QUuRx9PeLrjHb/OO+n1vn5o18iw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lLl9YIs7GRh+6tOyfSjlFPxeKJlAOo12erbbUOel9Rk=;
 b=nxEMBIdc/iIaDx8GJDKixxuGvkdf6VawOq2jsFS+LPHbTsBg5+W2ogy+ilOx6j+nZ7erd1H3zpD8JxmmYFI2nui54TsIpiDQSTPK1CsEubzlde+aBrdkZRivrYgPR9pS7YLhgFoNWdtj6cShqbkSA4VMtY/G5U2d86GApt/u7NoOHF0gLH4/po+3EFkjyZBNpUZx/EW631A0iKcLbWyg7CaI7UJ11SHobZDTMo6z5xdsS1h7GK0rD3RFkGp1xcajAP3BNSML0WEy58Vn2qbymiwhidc8x3cvMMXpRMB5AaFt6E1P7+qoSPw1UGnUngnDonxLc4sW+6p5vjvgLpbz6Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lLl9YIs7GRh+6tOyfSjlFPxeKJlAOo12erbbUOel9Rk=;
 b=NRxOcbhhmXgBaD+3biXsn6Pkq8o1uaGmMAaszreOB/j6GSLf80RaUPG0FhQkqmy0F4bHKjWbGm0cHh9Yz+ETOG4hAAWKbsKLNg42qjyDQ8Ww9sia4AvOxiHfshQz54fuPoqfYYMwMn9fpqStNF5xlINKHjFP79DABrLicYyk3sU=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Rodrigo.Siqueira@amd.com; 
Received: from MW2PR12MB2524.namprd12.prod.outlook.com (2603:10b6:907:9::27)
 by MW2PR12MB2363.namprd12.prod.outlook.com (2603:10b6:907:f::33) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2814.14; Mon, 16 Mar
 2020 13:49:58 +0000
Received: from MW2PR12MB2524.namprd12.prod.outlook.com
 ([fe80::91a7:e6f7:b17a:bfa5]) by MW2PR12MB2524.namprd12.prod.outlook.com
 ([fe80::91a7:e6f7:b17a:bfa5%6]) with mapi id 15.20.2814.021; Mon, 16 Mar 2020
 13:49:58 +0000
From: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 06/19] drm/amd/display: Pass triplebuffer surface flip flags
 down to plane state
Date: Mon, 16 Mar 2020 09:49:07 -0400
Message-Id: <20200316134920.2526155-7-Rodrigo.Siqueira@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200316134920.2526155-1-Rodrigo.Siqueira@amd.com>
References: <20200316134920.2526155-1-Rodrigo.Siqueira@amd.com>
X-ClientProxiedBy: YTXPR0101CA0009.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b00::22) To MW2PR12MB2524.namprd12.prod.outlook.com
 (2603:10b6:907:9::27)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from atma2.amd.com (165.204.55.250) by
 YTXPR0101CA0009.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b00::22) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2814.14 via Frontend Transport; Mon, 16 Mar 2020 13:49:57 +0000
X-Mailer: git-send-email 2.25.1
X-Originating-IP: [165.204.55.250]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: dba087bb-8b46-4902-3826-08d7c9b0ea57
X-MS-TrafficTypeDiagnostic: MW2PR12MB2363:|MW2PR12MB2363:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MW2PR12MB23632BE636519C0D3D51832A98F90@MW2PR12MB2363.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-Forefront-PRVS: 03449D5DD1
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10009020)(4636009)(396003)(136003)(346002)(376002)(39860400002)(366004)(199004)(8936002)(16526019)(478600001)(8676002)(7696005)(52116002)(186003)(81156014)(81166006)(6666004)(26005)(6916009)(54906003)(316002)(5660300002)(36756003)(66556008)(66476007)(86362001)(66946007)(2616005)(956004)(2906002)(6486002)(1076003)(4326008);
 DIR:OUT; SFP:1101; SCL:1; SRVR:MW2PR12MB2363;
 H:MW2PR12MB2524.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ZVbf6dOqTVGJfOKU4GnDeEwxs7g4d/jg+jKsYCyc5ykGd6q40/H+bW4Oz1VduIPCWmD10J8m/Bx/olcLbMoN9qVvzskgXE31zM0jqJ6OWn7On581mZgsw693odvnG+D2ss0cL13rGdnWuF6sn13BunQExGDcSoj06nPJqHoKgODYiz+DmONQ16tf+wik+UP6/TP5nX6QWoVV0mXi6f5t+N4kLLnAl5sYJICAi/CO+RGrME2NnVDwZBHShi7AUvMGyNxfXuD5gY1S6Dt20DukKqZN9ZhrQHb2okKnNvkmFZgvCqJ3yq8K3/MWg83+5AemaCryczCk/nypZNQy0hTfanZSsj+vuDjzJDy0jLCSRSH/VTV8IXhV7OGZUzwtclOiSc3pj64JZUnseqKCURfoP8ttW9tlsETRdvU+fCltRsA7M2qyBtlswufklTyBH/0k
X-MS-Exchange-AntiSpam-MessageData: htJvSdQ0ftfFyzWmDFrpwIYX8NHjJsjm3pasUPoyWkX14Oe5YIUY+VHhBElSWoOQNJNMjMOWQ6aZpYP2zxXtOGeY0HYCDG4HRlDp81/XlBYE3XWS8WX1GedBPNTE4+AUCrfQWaEn6RO/E2IFFiTSDw==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dba087bb-8b46-4902-3826-08d7c9b0ea57
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Mar 2020 13:49:58.2654 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Ky9Z3nWlvwE+EtxrZS0Ejy8HEv3vIkXqAOmYb25QeW/mpCDvwgLD3MpZ/cdImunnXNwiIkAGjbPFVaDLcCae7w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW2PR12MB2363
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
Cc: Sunpeng.Li@amd.com, Harry.Wentland@amd.com, Rodrigo.Siqueira@amd.com,
 Hersen Wu <hersenxs.wu@amd.com>, Bhawanpreet.Lakha@amd.com,
 Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>

[Why]
A "dcn20_program_front_end_for_ctx" warning is observed on Renoir.

Since the resource definition doesn't explicitly disable triplebuffer
flips like Navi10 DC actually attempts to go and setup triplebuffering
even when we pass in false to the plane state.

If we hit a full update after triplebuffering has been setup we see the
assertion since we don't expect full updates while performing
triplebuffer flips.

Normally this would get reset back to false whne we pass in the new
plane state, but since we never actually copy the flag when doing
surface updates this doesn't happen.

[How]
Copy the flag onto the plane update based on the requested surface
update state.

Signed-off-by: Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>
Reviewed-by: Hersen Wu <hersenxs.wu@amd.com>
Acked-by: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
---
 drivers/gpu/drm/amd/display/dc/core/dc.c | 2 ++
 drivers/gpu/drm/amd/display/dc/dc.h      | 1 +
 2 files changed, 3 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc.c b/drivers/gpu/drm/amd/display/dc/core/dc.c
index df285f57fe92..137180ad6a25 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc.c
@@ -1871,6 +1871,8 @@ static void copy_surface_update_to_plane(
 		surface->time.index++;
 		if (surface->time.index >= DC_PLANE_UPDATE_TIMES_MAX)
 			surface->time.index = 0;
+
+		surface->triplebuffer_flips = srf_update->flip_addr->triplebuffer_flips;
 	}
 
 	if (srf_update->scaling_info) {
diff --git a/drivers/gpu/drm/amd/display/dc/dc.h b/drivers/gpu/drm/amd/display/dc/dc.h
index 1e6413a79d47..280b015d10bd 100644
--- a/drivers/gpu/drm/amd/display/dc/dc.h
+++ b/drivers/gpu/drm/amd/display/dc/dc.h
@@ -872,6 +872,7 @@ struct dc_flip_addrs {
 	unsigned int flip_timestamp_in_us;
 	bool flip_immediate;
 	/* TODO: add flip duration for FreeSync */
+	bool triplebuffer_flips;
 };
 
 bool dc_post_update_surfaces_to_stream(
-- 
2.25.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
