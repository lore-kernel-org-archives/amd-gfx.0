Return-Path: <SRS0=SqeI=EC=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 826D3C63777
	for <amd-gfx@archiver.kernel.org>; Tue, 27 Oct 2020 20:53:10 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2654721D24
	for <amd-gfx@archiver.kernel.org>; Tue, 27 Oct 2020 20:53:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="i2zhnDmW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2654721D24
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C02EA6EC68;
	Tue, 27 Oct 2020 20:53:07 +0000 (UTC)
Received: from NAM04-SN1-obe.outbound.protection.outlook.com
 (mail-eopbgr700082.outbound.protection.outlook.com [40.107.70.82])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B81606EC5E
 for <amd-gfx@lists.freedesktop.org>; Tue, 27 Oct 2020 20:53:04 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FudRmcBArpudLhRRc9NDVyK/2zzi4ZaCZLxeY5iDcViOP2NIUsBNbUAtf2m8UVo9MGn1YBrFSbfcUq+zkSu76X2fcT1OmTFHU8R+xn30iF6fgBwmQ7m3c4nM0PB31fsQ52AIikM6ddPxQJqubvVywzd2no68uQBZhTn4DXJMzLGgw/0xs3jql07sreyT1l8Gf6k0NFxFBUODXUUX+DRZsKF/r9ZSwFYAy88NQm4H8rOJdyZiZjVwGzWVo1hen5HQnl/6kJo6xee4uu4buJa4+By8bfgYYQoJzTO78aGYErAIaarzHAgDZ2tERx5AyFa8ijGPLMjZuHVh5XoeTDIoDA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tqPP7eE7qBc45q4w7xBUrGOXEmlgPJckIAWtoV1hxYg=;
 b=XhYX3TovYVaa6HAdvjN4SLw701JMNdrP7Azp1IKsvpZ6cLVzT81ciLo1km1OjK8XF+wZGhV8GMGsU9J4ur0Tg62Oax0GBdt1AE9FLE8h2BFoGr4EnpE+Q3FSGP4PpVvlElI0gAZPAdf9YA4ZCVDRIh3AIgFX7bTOsQE1oR1c8ir9KZma/d/T3nYfeZWa4c+JT6HCw5vDnHczzdYtmRYhsyIC2B/EheTejtkoczz1f961ipW9vrZdQxnMpAkQrsmr9Y3AtD6BXmwXA4upWgIlKPGCBK+QUPHj7kUx4Uu3atN+kKvOaK4GIlPrloba/7tscuij6Rik1bUEdhjWAd6QJQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tqPP7eE7qBc45q4w7xBUrGOXEmlgPJckIAWtoV1hxYg=;
 b=i2zhnDmWA//x+zLK7jo3EabA6BgtwwJUVPYcSiXjPhQdtuUI+7pgFynZLxNHRVlnquZHSiWFNU+IkyExJ+CsGYc2NU1TLZG1mYLnwUArxnGCfj+Viytfi7qmmLoTUMHWKsPS6g0kloDVqvWJku4fsaADgi4+SfMRFRcQmCSz5ac=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from DM5PR12MB1884.namprd12.prod.outlook.com (2603:10b6:3:10d::12)
 by DM6PR12MB3595.namprd12.prod.outlook.com (2603:10b6:5:118::29) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3477.20; Tue, 27 Oct
 2020 20:53:03 +0000
Received: from DM5PR12MB1884.namprd12.prod.outlook.com
 ([fe80::a82c:a1d:81ad:42f7]) by DM5PR12MB1884.namprd12.prod.outlook.com
 ([fe80::a82c:a1d:81ad:42f7%3]) with mapi id 15.20.3477.028; Tue, 27 Oct 2020
 20:53:03 +0000
From: Qingqing Zhuo <qingqing.zhuo@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 17/25] drm/amd/display: Do not warn NULL dc_sink if forcing
 connector
Date: Tue, 27 Oct 2020 16:52:26 -0400
Message-Id: <20201027205234.8239-18-qingqing.zhuo@amd.com>
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
 15.20.3499.18 via Frontend Transport; Tue, 27 Oct 2020 20:52:55 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: c365ea9a-8741-40b6-0d74-08d87aba47dc
X-MS-TrafficTypeDiagnostic: DM6PR12MB3595:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR12MB3595C8D9BF8DB7895D90881FFB160@DM6PR12MB3595.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3044;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: /ol10/QLKPSFJUk1FVK5SK7aWbW3L+nTB/WT9eJsm+1Egu7nHA6VnTeCY+lHqdx9Ka+6fsB9PF06Fie93eZOWvXlWIvbXgsRVfysp6igavtXjentRWURfs78YllFVr8OzpNa/snogD1g84VBIcc8IVnZ2lvur3W3B2i55qN7jlsCTR3FHxxHj8bYZEBx50qywRLxbpOlfXRxiYDeXufFJ8Tr5/YcrgRn356Ra2hygzUs537ry84aNKmKFrZW7pViWRcLKSnXnx1MtEb7QuubRTD9YTKhJwppBhs/4LKjUSzY8FnkGtOTizw3wQMHugHtwbYUoMTazG4Q9q+BklPgSQwyfQtUCUAD6bTOo2ZRQBhpecLA5rWX5JX+pL4xBoWi
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM5PR12MB1884.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(39860400002)(346002)(376002)(396003)(136003)(6486002)(6506007)(2906002)(26005)(66556008)(16526019)(186003)(6666004)(2616005)(6916009)(52116002)(956004)(66946007)(316002)(1076003)(69590400008)(44832011)(8676002)(478600001)(66476007)(5660300002)(4326008)(86362001)(36756003)(6512007)(8936002)(83380400001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: nCS/AjDY/Yc1S+1fo8BZ4CV3S8qvMI6umD5mZvqtNYryDOjl7QbbaLPw6qML7qwtL0DPuD/ZjLcsKgvT8ZXaeqtgMrHx/0OKtoF1gxXhGtvZKQk6CLSVrOQiDIzQoI1CUIXsQQmJ9lRS6IGLHjzekbiXHuOgMsU5l4Jg5I9OUyvb9k/Z2fMl2BFc06oA/c0WHE8xPtnHp4vtrmnr7lmEfQYTRfgn2r/Of5H6m0Y8WgTWWOLlIeDFfVaDJBn/7ENkmebQo7dit8575aSNg3vIdislgEDUI4OxXJ25wCzjM0VgMW93G6uZnXKaMODsN/SrPs9yVs+4U42dcHcyNhJTDepz3a663XttDHvRSrNqaRNyqXB5WVQJPzv9ipDRU+JrfzEmACMuEnMI9HRcmmARgLb7Lxbc0BzPsoLEcPiHvRUFgdfsrd1r0ncCIS4+7X2lmbZ10SreoLyVtmRUDYGxSA4dBg+QiKmT6XdW/FWmpoh9NYhzJmdidRqkykDpY5Q/rVHc36OrRy40TIEhaJrjX5jHLY9cN17K+Sq4PmnCpHl+tiZSExaKB+pnuNVhTYU2pKiqqH/Hg8WJ7phDT2pGlP/thLAJv0Aar+SJNCTU1e/+84Fuhsa+lEApocwcfJNFCaW8FJ5843Q86GvEkPgkFw==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c365ea9a-8741-40b6-0d74-08d87aba47dc
X-MS-Exchange-CrossTenant-AuthSource: DM5PR12MB1884.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Oct 2020 20:52:56.2913 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HPXDy8DeVoKSgYA5M8w2VWn715qTiHfn/kIOfk2RZzoSPpBvZuew1IUno6MfHxeh
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
Cc: Eryk.Brol@amd.com, Sunpeng.Li@amd.com, Harry.Wentland@amd.com,
 Qingqing.Zhuo@amd.com, Rodrigo.Siqueira@amd.com,
 Victor Lu <victorchengchi.lu@amd.com>, Bhawanpreet.Lakha@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Victor Lu <victorchengchi.lu@amd.com>

[why]
There is a DRM_ERROR when the dc_sink is NULL and
there should not be this warning when the connector
is forced.

[how]
Do not warn if dc_sink is NULL if the connector
is forced.

Signed-off-by: Victor Lu <victorchengchi.lu@amd.com>
Reviewed-by: Nicholas Kazlauskas <Nicholas.Kazlauskas@amd.com>
Acked-by: Qingqing Zhuo <qingqing.zhuo@amd.com>
---
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index 345eb2130869..6b3ae523e62e 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -5485,7 +5485,8 @@ enum drm_mode_status amdgpu_dm_connector_mode_valid(struct drm_connector *connec
 
 	dc_sink = to_amdgpu_dm_connector(connector)->dc_sink;
 
-	if (dc_sink == NULL) {
+	if (dc_sink == NULL && aconnector->base.force != DRM_FORCE_ON_DIGITAL &&
+				aconnector->base.force != DRM_FORCE_ON) {
 		DRM_ERROR("dc_sink is NULL!\n");
 		goto fail;
 	}
-- 
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
