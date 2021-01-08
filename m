Return-Path: <SRS0=yWhT=GL=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79523C433DB
	for <amd-gfx@archiver.kernel.org>; Fri,  8 Jan 2021 21:51:00 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3AF4223A9C
	for <amd-gfx@archiver.kernel.org>; Fri,  8 Jan 2021 21:51:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3AF4223A9C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D0F426E8F6;
	Fri,  8 Jan 2021 21:50:59 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2085.outbound.protection.outlook.com [40.107.244.85])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 13AD56E8F6
 for <amd-gfx@lists.freedesktop.org>; Fri,  8 Jan 2021 21:50:58 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XEioPXDlOOQ//MErTQmY2yQQiBq8NvKNDY6q7tCJuoxPiTGO685b4FuhHzzfZ9+HVYm9sPPC9sygGo2KMAyPQxe8Zt+tLgnH2V5pv4EIfWRe9kW80IZu4leyFD+sibRrT18+tYH3gxT2prWXBqRLQRMnIZr9ZJfBjuKT2DeTrvNlkhKoZ+DScmmLWv+r6BiftVxsEjc9bFIIbNo0XZcIRiVQEoDftlI9p0I0qM20RpOMYSkyyiKYQpwc9qPayRXqFi7Sx6X14m2PzADfmSt9SrnXOWS+01+/9SS4OnDROdkmEAzkMao3V2ttXmeFg4NVL+1Rrx2ukypChS0KVE0kVg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7PGIdAKRogNpyKIGktGBdF8sgT/vaSfRsVn5vt0ko28=;
 b=XaWM1Aktc/Km18tHFgaw5Cisg0z6UoRljTupeVzgkA4r1+aQ/zTy2J6bxZP2a6XVm+YpNKlUid/WvsYt27xL3bcz8OVrd9xtom/sdF8fmf+4ME5EppUR5H7+VLLqI57WB33ACPakacA5YnVId+ji8FQrtvyzVsYgKwndDn27Zv2u9gqxtpPtLTBfwi1nNwr6CiYxGOwdZwmQur0J5wyb/jlYhB8BBfcyt82Zthf3MvpsO8VqWtDqT23WEeaLHUusi0Nv0KfYhUxhx7Mg7IorqOrftu+n1VVLFBXCz604Dv1GJVltLc6gKGOmN+nAMoSNUMR8wKU8qZ1zqecKSoycPg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7PGIdAKRogNpyKIGktGBdF8sgT/vaSfRsVn5vt0ko28=;
 b=FpolJ9ySSaEk8o5PRPsCltil7Nt6RU2u2pyrOvEZiwokExBnsGktOaLoZheBvs56pkJiIb/4NkQXFmXSonUDxygkh6X6lsxGDL56zgDU49MJwK7b6LK/Gxcl7RyDVjF8MAHAyL14DbuYCftWTDGks6jSEPVV61djN8PNTNrOlcs=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from DM5PR12MB1753.namprd12.prod.outlook.com (2603:10b6:3:10d::16)
 by DM5PR12MB1882.namprd12.prod.outlook.com (2603:10b6:3:112::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3742.8; Fri, 8 Jan
 2021 21:50:57 +0000
Received: from DM5PR12MB1753.namprd12.prod.outlook.com
 ([fe80::1cf5:9c9e:7374:4540]) by DM5PR12MB1753.namprd12.prod.outlook.com
 ([fe80::1cf5:9c9e:7374:4540%12]) with mapi id 15.20.3742.009; Fri, 8 Jan 2021
 21:50:57 +0000
From: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 19/21] drm/amd/display: Revert patch causing black screen
Date: Fri,  8 Jan 2021 16:50:05 -0500
Message-Id: <20210108215007.851249-20-Rodrigo.Siqueira@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210108215007.851249-1-Rodrigo.Siqueira@amd.com>
References: <20210108215007.851249-1-Rodrigo.Siqueira@amd.com>
X-Originating-IP: [2607:fea8:56e0:6d60:691c:c3e7:a457:38d0]
X-ClientProxiedBy: BN6PR19CA0063.namprd19.prod.outlook.com
 (2603:10b6:404:e3::25) To DM5PR12MB1753.namprd12.prod.outlook.com
 (2603:10b6:3:10d::16)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from atma2.hitronhub.home (2607:fea8:56e0:6d60:691c:c3e7:a457:38d0)
 by BN6PR19CA0063.namprd19.prod.outlook.com (2603:10b6:404:e3::25) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3742.6 via Frontend
 Transport; Fri, 8 Jan 2021 21:50:55 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: b3b26524-6f74-4b8b-7917-08d8b41f7aee
X-MS-TrafficTypeDiagnostic: DM5PR12MB1882:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM5PR12MB18825816C086D28BD0B75BDE98AE0@DM5PR12MB1882.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:404;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: W6inoG1TdB+YcLkhuEfWJE4k3un6jWnDELPeL2hnOVbJgAAkTjgm/17RzzgcxCs2Q7iu0NX6AEP4LJXnUDZU1zEcsx4wn0XIkBgXUUszDOFxAFkzWzOFONrMzJVkuYhmB5/zYBZEFWrySrtoc0Ydke0lpAAUwtiLqF7Fvhl6sme8QmZn5W+ZtPAQrQoBJVC/5sJE824mNl2/k7DaicI/8bAoRItWJj6bxoRgD7RW6UTT785s4o+SFife/y9xm21WUskXjBSwqFbbB4ueY0d7t0qL3J+NP/JZAn9GyMAb0eu9jspCJ2mwYC3sdjaZaYcx6xzmz/I8VC9JF0/FUxzwq/OeLNrb3d39gjBtQ92SsopOqGKAJBLA+F6EbVlQuHsqr/GJUwOqQCEqmLNRAMvw+Q==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM5PR12MB1753.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(136003)(366004)(39860400002)(346002)(376002)(396003)(5660300002)(6512007)(478600001)(86362001)(66476007)(6486002)(4326008)(52116002)(83380400001)(6916009)(66946007)(66556008)(8676002)(1076003)(16526019)(36756003)(2906002)(6666004)(316002)(54906003)(6506007)(186003)(2616005)(8936002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?xBa/9sZ8Aykrxw0KcLO9rvtY45yDupZ1m1UX/dNYBxF51ZsvW5n0/U2CHoFY?=
 =?us-ascii?Q?eyp+OE/1m5Dl5G5+ovp0SWEwt4N0fJqLLlUOlVGnhYYxHzfXrnYVznJ0CiN9?=
 =?us-ascii?Q?6D3HV9OaNiYrCcEr8aIUhjEgpj8A7cqJB78v7ekeTBTi1WekWDCvFeOo8KJV?=
 =?us-ascii?Q?CUmtnazH0Ku6DiA+zSnA7RerEcdlCxqZ9D2MmPExHufYQGIhN5pMiJT5FzJi?=
 =?us-ascii?Q?1cvyxB6iPBYaW2pmVF34Q+J2QbqoPAvtfxXNvAxGK1Gcx5YeomEpCTR0pmlo?=
 =?us-ascii?Q?/vUQREcFre34EuzPTZoAu6qv9sAjjSMyQ+uZvxDxAZ8DmfFT6gPqOrijwaRB?=
 =?us-ascii?Q?S41OVzjfr3Id5C3KVBAVIfv0zltcnYozDM2BREMX0QviHk+8c6Cdnia+5HGG?=
 =?us-ascii?Q?qUWK4KUHZtvEFkrSFDCYXd17U6jBDaCU2TmWzlJGnWjLqQneEbfbwAzWdeWu?=
 =?us-ascii?Q?+vuaMU2xdnr44DNj8SbPdJ9LR9MVcmiv6br3pmD5Leai2RX1e35Hl1qjm+mF?=
 =?us-ascii?Q?0AxfjB1vlrAo3Q7+V5MKpZSTof7NWxvtiej5nHM8rnZ4awp4vxRFN+U3vywm?=
 =?us-ascii?Q?OM0Z5bybGrHHAmRYmhl0hu3WTKxVQQuLjlpWYnzJOSELCTQMsw5chmdl63+P?=
 =?us-ascii?Q?QxPazpbp7QTALpPpJPNggVU16gEDBM4rEUopnlpKtIny2j1glrNrj19ZnLo7?=
 =?us-ascii?Q?FNbuvdcc2Tja6LrgEs/+cjA5yh6klevVf3BGg535EYSUcDQtfcj2Nm2aWXF6?=
 =?us-ascii?Q?EQIFinwlUSA5WUnAVpGyYekT0fV8FpZKtBJEYfOEZxD6p20JUfRqAFmjExKy?=
 =?us-ascii?Q?tHgtETBCQt8eDEj8WFpcDo0Q4o/dTIPKKBsE0EwYIA4gABYZM1ZyVPc/5Nbk?=
 =?us-ascii?Q?JmlG1hRIsike0jHm14Krh1sE3LB+ZsuIZj3mRiNoRKKLYa1SRvQnwqcvg+cB?=
 =?us-ascii?Q?IcY3ZUkksMzyipRCiX4zydLCi3EVdsmxMxy4yEXj7ZArJ7OFneaAu8O7jDOz?=
 =?us-ascii?Q?/H1Z0o8SZIkbDVOhD0Heic5avA4VK4Hn4j0rV36D0WWsC7ipqrYYmTqrxiz3?=
 =?us-ascii?Q?pehiYYYu?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthSource: DM5PR12MB1753.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jan 2021 21:50:57.0810 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-Network-Message-Id: b3b26524-6f74-4b8b-7917-08d8b41f7aee
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /5CWvMWtEa3WT0gv4lf6szZVbaSxHytME9DmNjrCJqVn5ULVOUxPBMyy4FaqxeGvhTZBUmtKvGvP8ncFZe83Zg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1882
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
Cc: Stylon Wang <stylon.wang@amd.com>, Eryk.Brol@amd.com, Sunpeng.Li@amd.com,
 Harry.Wentland@amd.com, qingqing.zhuo@amd.com, Rodrigo.Siqueira@amd.com,
 Roman Li <Roman.Li@amd.com>, Aurabindo.Pillai@amd.com,
 Bhawanpreet.Lakha@amd.com, bindu.r@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Stylon Wang <stylon.wang@amd.com>

[Why]
Previous patch is causing black screen from S3 hotplug.

[How]
Revert patch until correct solution is developed.
This reverts 2b09ac8145dc.

Signed-off-by: Stylon Wang <stylon.wang@amd.com>
Reviewed-by: Roman Li <Roman.Li@amd.com>
Acked-by: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
---
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index 228b5e51c41e..3c1552667a2a 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -2386,7 +2386,6 @@ void amdgpu_dm_update_connector_after_detect(
 			drm_connector_update_edid_property(connector,
 							   aconnector->edid);
 			aconnector->num_modes = drm_add_edid_modes(connector, aconnector->edid);
-			drm_connector_list_update(connector);
 
 			if (aconnector->dc_link->aux_mode)
 				drm_dp_cec_set_edid(&aconnector->dm_dp_aux.aux,
-- 
2.25.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
