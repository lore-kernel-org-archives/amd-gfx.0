Return-Path: <SRS0=gTHH=EF=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96690C56202
	for <amd-gfx@archiver.kernel.org>; Fri, 30 Oct 2020 04:33:28 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EC7242151B
	for <amd-gfx@archiver.kernel.org>; Fri, 30 Oct 2020 04:33:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="L6MxiVH7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EC7242151B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E0F336E94C;
	Fri, 30 Oct 2020 04:33:26 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2074.outbound.protection.outlook.com [40.107.244.74])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E4C456E94C
 for <amd-gfx@lists.freedesktop.org>; Fri, 30 Oct 2020 04:33:25 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BVYmdS4vm5xH8bKsSV0ZfwTiw1Y/4BU8L15PLQPgfHme9dcioTHMkgmaoNu2Fsl4PgDrOVK6YClhEQ5nao/3Q3Y3CG+26mmHJIR2tqm+su+hRLxiqEdYTYdWvDPx/Yzz42qXhRfSwEwF3YL3O/0BLdUZ6hS/hqwaLX/CDnPcIO7hkkZSywTxsAePGtYOV2EmCbLmA321B1cuQ9b9bfDTwLznNjiOvOT/lvDZnMuebl3E9Y8xIdd4noJACx3k9RBc+KSTkyM9iJVroa+cIoDpaNmwwq45eZJFt2O7xu+x+SvEq2DnEVWMvwdUPkH+MY8Il6m079ir2OpcpyEKE4yZWg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vFSNoSm5+I1QmH4YKkDgYMr1CxbIF5AEd5hy0+0yKSc=;
 b=ZnfFe8ze2+SGn2U5o+iGjrLIy+BWunRimPlirSOJAan7Tp4vADXkmMm6riN2mbdqfQMkhL3w8CHDbHHLk/KrRRlWho0D0wiaCfRhQXVbbffkZI37WYTw8Foo4RchZ/xJkFPs6mJjW+shyrFwr3NwzuQ2MaqYSlJDgL5gKqmvW8NaSv4PGUj+eYfrHimSblxvwZWg79s93j6apaSI0BTz4k5QIAOj0uuKKBaEvy/cZyLUcrfhrizgQ9nXe8cnt3reCoRPL612R6IJ6cIA7KUt3yAd9nLmxDsxJ44gHn/CpyMxbU4LJ+/ypNRHw6HNQZfpFKimjwdny3KL79idjTy2SA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vFSNoSm5+I1QmH4YKkDgYMr1CxbIF5AEd5hy0+0yKSc=;
 b=L6MxiVH78vpF1ZDidOdXooCMraJUK96N6ja3hq3laD0b/id5K86BnKGr1haHWz1ZuqK1H/Dd4NcjhNBn9nxgp8Eejt/2zWl38Ia51gSwDxG0dZdscoSbjt2PkdoJ3aMbAHBFCOMuiVqjn64ZF8Z5XRZeOMiEC3WY7TlwZolJqgA=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from MWHPR12MB1854.namprd12.prod.outlook.com (2603:10b6:300:114::19)
 by MWHPR1201MB2493.namprd12.prod.outlook.com (2603:10b6:300:ec::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3499.18; Fri, 30 Oct
 2020 04:33:24 +0000
Received: from MWHPR12MB1854.namprd12.prod.outlook.com
 ([fe80::5930:79ab:d15c:2826]) by MWHPR12MB1854.namprd12.prod.outlook.com
 ([fe80::5930:79ab:d15c:2826%3]) with mapi id 15.20.3499.027; Fri, 30 Oct 2020
 04:33:24 +0000
From: Likun Gao <likun.gao@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH xf86-video-amdgpu] Fix drmmode_crtc_scanout_create logic
Date: Fri, 30 Oct 2020 12:33:06 +0800
Message-Id: <20201030043306.1557713-1-likun.gao@amd.com>
X-Mailer: git-send-email 2.25.1
X-Originating-IP: [58.247.170.242]
X-ClientProxiedBy: HK2P15301CA0010.APCP153.PROD.OUTLOOK.COM
 (2603:1096:202:1::20) To MWHPR12MB1854.namprd12.prod.outlook.com
 (2603:10b6:300:114::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from lnx-glk.amd.com (58.247.170.242) by
 HK2P15301CA0010.APCP153.PROD.OUTLOOK.COM (2603:1096:202:1::20) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3541.5 via Frontend Transport; Fri, 30 Oct 2020 04:33:22 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: cffa89ed-6571-40f6-3941-08d87c8cf030
X-MS-TrafficTypeDiagnostic: MWHPR1201MB2493:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MWHPR1201MB2493159935043BB3AE6F0CC3EF150@MWHPR1201MB2493.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:331;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: NRoZ0RpC4++g3qNBbZSKUPL4+YM/CaLn2sA9GrFnq14EftG+1RcZwGefN/qS6dOFd5vXvAlRLi84TSLoDRMu7t1jEMw4k2TiMb0V1e30XtXTUiK9fj9InPz7fb56ujpZpCW2Wv6Z9Ldc+5IpU5HUwKyxAX568Z5bZup9IkVv7nYKjcjnag5FpgaW38xCxCY4Zw/ZfkAi2Zhl002NqlYZHguy3KLsMQXbvRBLi5nTXDBI6RUlozcq4WF7Nys9+8CObmU8lgbseMpE8YodkLMoNs7CTFSZVAZL0rG85wXvgeK9ZZ5alZAsdRFgq64K0Id6
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MWHPR12MB1854.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(346002)(39860400002)(366004)(376002)(136003)(396003)(6486002)(2906002)(6666004)(86362001)(186003)(4326008)(16526019)(478600001)(66476007)(66556008)(2616005)(956004)(66946007)(8936002)(6916009)(316002)(54906003)(8676002)(26005)(83380400001)(44832011)(52116002)(36756003)(1076003)(5660300002)(4744005)(7696005);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: lhAPa+gjz4exEA+/5j8DkX+Rg/2/+kC0fBkjr1MKM5+V9Nd39YrNzooiElersSa39h9pF7g4n3jjAPOARJpbSJ3nlImmGOLPpEZEi/UP64Qun8x+/eLTGLWtvvjQ+Ah9ambPKp+hP705DHYFOJGxprCysFaAMtFF2WjdTuFe4yZNcxZFs3M/GoUwGh2R7fwsYlJv3BqRyay5tetuhlMh8D1POUviKka/SukOxjvGDHSCyvkXsliknaomqy79GAD1VbwxM44nCnaS0ZtPj26gTpd6qPql8ylMtq9Jiz07N6tR+NYoh2VyKPt1/Mm5x0wVwKgPVVBsDuIHC55av/QTv1fyFGuDl2komSuFbzUElNWVaK31cSsPlLWd9JPssBT7EVjvJB0wYjbaiKRF0wJ8tnV07mITvuSucP3k2k2pyvteEUMsrI0zAbOcrFmEf7WppUpMds2vOK+ps23uhdhbGq7/lR+ZHDzJ5qj++lrMmWhhqnEnr7PY7B03+e2R8FqGHEOJcz1G96J6cRVRSKkUE6WUzZ+5CAHs2qKbXWfCm6GVYw4Tu3z7OgYBN9Qp7V0VmJ3owmmtZ7WSD7duSzHkTPWVo0U+lVaX5WoZM7/UmdET/oeDLXCikipxw+hQxiUPbfjo1z3rC0yprKpoWMC87w==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cffa89ed-6571-40f6-3941-08d87c8cf030
X-MS-Exchange-CrossTenant-AuthSource: MWHPR12MB1854.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Oct 2020 04:33:24.5240 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Hw2e85KTCGfocFfb7ktP0c7QdavDHCLiTJBXLL7aeUoukRfksagtDVfnAny+QJVn
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR1201MB2493
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
Cc: Likun Gao <Likun.Gao@amd.com>, Guchun Chen <Guchun.Chen@amd.com>,
 Hawking Zhang <hawking.zhang@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Likun Gao <Likun.Gao@amd.com>

If crtc scanout create successfully, the function of
drmmode_crtc_scanout_create should return TURE.

Signed-off-by: Likun Gao <Likun.Gao@amd.com>
Change-Id: I4b7540b0d128c2d55f2b8491569004741435f343
---
 src/drmmode_display.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/src/drmmode_display.c b/src/drmmode_display.c
index f74106e..465915f 100644
--- a/src/drmmode_display.c
+++ b/src/drmmode_display.c
@@ -513,9 +513,10 @@ drmmode_crtc_scanout_create(xf86CrtcPtr crtc, PixmapPtr *scanout,
 		ErrorF("failed to create CRTC scanout FB\n");
 error:		
 		drmmode_crtc_scanout_destroy(scanout);
+		return FALSE;
 	}
 
-	return FALSE;
+	return TRUE;
 }
 
 static void
-- 
2.25.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
