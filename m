Return-Path: <SRS0=0i2d=KW=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0DB69C4707F
	for <amd-gfx@archiver.kernel.org>; Thu, 27 May 2021 12:07:55 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C714761378
	for <amd-gfx@archiver.kernel.org>; Thu, 27 May 2021 12:07:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C714761378
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 737AD6EE9F;
	Thu, 27 May 2021 12:07:54 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2059.outbound.protection.outlook.com [40.107.93.59])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 006D46EE9F
 for <amd-gfx@lists.freedesktop.org>; Thu, 27 May 2021 12:07:52 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=j/JeS8voSAb6WArMKHZjYcegaBVB9R3Gx4oLxFcfkUAg/KZP+FxrfgILWshS/z/wjgDHaUqvUEdBIdLQMbh/PviyYOXw/rN6UaogGdTMZbyYQZYqX1fYi1kCT6QU3OP1DX6gAj9gf92gG1UqZvbFbtW/r+DvxvcfTd+skEPX2aJeqe+pgUXZr8DLJiJn0FLIhgg00958GVT+4AYq9BXtD9x8XgAgujahtG/5z/36ktiPCZi3K9Xykl9Mk5R0PgT1UBbzcJk8ev69JclVVtw49VaI0BMnDXpoxiw68kDesecR6Lllr+QxaqJJBoTmgi/SKgfQ7lutDQk4CL0rrSeF7w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+A2J0WVxo9eVijfa7Ty5Gssd7izLM8/PVY1Bf4ho0cw=;
 b=JCgUZMV8/dJI6ojOH3nIRxF+90VHSvxgwoP85aAlAcUyTl5KqmASug/DMYTIoTQxAg96i8mGGpZJEh9pBTydy9HSPjVvDRoUBP1liopkK2g5RW2GMxWBt8VUpklBkFnfEE6J/tWp3gOS0wNvonIlSiGDT/Adecd/zwpAj9Ak0gsLfTdb/q4r50Alx+Fea7IIDcvCEt5/q4wqSLSXWb940U9h/jGTZkwt1pJNJyZyuaVyMSAZ1D5LiN39jz0K4sVtCIP2uf92CnVM8xmehSyr4eYEkY3522dP6FZBhHWX3CpXuE/ll3JPQX6Z2y1w+irFGwZp4zuzXN4hua6NwqoDuQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+A2J0WVxo9eVijfa7Ty5Gssd7izLM8/PVY1Bf4ho0cw=;
 b=Z8vUEH2MzLjLAz/2frr3gqsoZb5hiKgtO0/iuaSZh2zvzfP169FjFbVKFbARbqASOfTH+wmyEbdn8fTBCxyeUnVHWvRGBdhy1rA5fuTJyF96FwZgoFnFN+K+tBFOqpa02z7FeEWMxzq0s1K7gyLNNherjaTDd7i/1a1gyJNhKhE=
Authentication-Results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB5136.namprd12.prod.outlook.com (2603:10b6:5:393::23)
 by DM4PR12MB5117.namprd12.prod.outlook.com (2603:10b6:5:390::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4173.22; Thu, 27 May
 2021 12:07:50 +0000
Received: from DM4PR12MB5136.namprd12.prod.outlook.com
 ([fe80::4074:4943:244:a5fa]) by DM4PR12MB5136.namprd12.prod.outlook.com
 ([fe80::4074:4943:244:a5fa%6]) with mapi id 15.20.4173.022; Thu, 27 May 2021
 12:07:50 +0000
From: Nirmoy Das <nirmoy.das@amd.com>
To: harry.wentland@amd.com
Subject: [PATCH 1/1] drm/amd/display: do not dereference on NULL
Date: Thu, 27 May 2021 14:07:37 +0200
Message-Id: <20210527120737.25409-1-nirmoy.das@amd.com>
X-Mailer: git-send-email 2.31.1
X-Originating-IP: [217.86.111.109]
X-ClientProxiedBy: FR3P281CA0020.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:1c::21) To DM4PR12MB5136.namprd12.prod.outlook.com
 (2603:10b6:5:393::23)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from brihaspati.fritz.box (217.86.111.109) by
 FR3P281CA0020.DEUP281.PROD.OUTLOOK.COM (2603:10a6:d10:1c::21) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4195.9 via Frontend Transport; Thu, 27 May 2021 12:07:49 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c4dd0edc-a25e-47b7-e7ed-08d921080c59
X-MS-TrafficTypeDiagnostic: DM4PR12MB5117:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM4PR12MB5117573AD85485E470B0E5988B239@DM4PR12MB5117.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:85;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ++WxBalHv2Na+JFhClRDnVn1pyxYM0b091ZUBWG3hOEdp+lnZl6Rn1rR0VUWEAWebb//umBXhgsTlcy/ubV68yWeQ6dE6uFI6+sl9hhvTQDLoIaPHWbQxZeXSB2F3g3bMJkerEAQbo4JD3xgFpVVGJlp8UeP8ZgHUcRvPuM9VG7lS1FypU9ejntOdVL16qfjm+j0nGpr1dagFepRQ9Q1kEc1nDFpkCseblSvG25Yw37uUv5d+avrLw3Eg9oAkxj7Qdz5vLFEG/RCpFS+Ot5YpojpD0kFQ5ovNnyZnBc9XprCxNGPCoHK9lVyxtbilKXNXRdNPGDNT9T8D9nZuFVkvEOZtwVENl/ePk1ug/PycHwdICrZGisX+/j/Az31p3AvcoTfHkZp/m4amLQCeiVTBNPVdRsioFK/timfHhnvc9Bou9hYgEgybB632DInuwK4SgLIZYmRnFoTR08kjhEcuNzHqFvh3CT+pqPkb/0AB6aM4PoDPn8t1fOuZFCpUWzKvFcJPkx6WXwxWTZislIxrBAXKPyxE/F+IGeyjmevkKCHWMODPLMKo7TSvUeb05q3n6WzduC6mtjEkT3xNkG3TPHmz0bFkeK+yfYoXR2ZjNNag17sYM6g2Kg76nct0+ORLE0FJgfc43rzEFB/fucLfSle0nezlPMw0QqrgFx/Sg0=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB5136.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(346002)(366004)(396003)(376002)(136003)(39860400002)(36756003)(5660300002)(38350700002)(86362001)(38100700002)(478600001)(52116002)(6486002)(37006003)(316002)(2906002)(26005)(6506007)(6512007)(186003)(16526019)(6636002)(8936002)(4744005)(8676002)(34206002)(956004)(1076003)(6666004)(4326008)(44832011)(2616005)(66946007)(66476007)(66556008)(83380400001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?sEsm31xP7fUCGIUA0wT9ycDJ6hVY9iyJUlBAksSDLGlExAYZfiwm5CxB1c28?=
 =?us-ascii?Q?8+Rm3BQ5RVZb0rc5r8i7kGQOfs3RnyZsVlJshDtKI8AHPCfeWMsQg0mOrw9u?=
 =?us-ascii?Q?Y132JLEg6k0fFlblHeU1t/IzncLvSRg41+klDaw+1lQ8jlrpF3LnA/891eQ+?=
 =?us-ascii?Q?lOSMZ5KvUErWzx8qYO3Bdd5ylLg1SHrXTbCyef8UfxfZxB7myVIJnCvfKLy+?=
 =?us-ascii?Q?caZYyOqGPiJ4N8Bu1KjMiApAK1QQYXYqeVCLmGlCfVCeE3M0LV5h/9Z21y99?=
 =?us-ascii?Q?AXoVXozKxNM2t81cRYOHbtLDD2Oj7WtCYn6grSea5SiLwZQUijP43E0WxU2I?=
 =?us-ascii?Q?sOUaZo9jcTI61lGX8oNJ74bCM2d779aca3Vjlryu6D9riK2B4GXzvb9WIXBG?=
 =?us-ascii?Q?G7RbZE9599dBRJqCTnB0kOCkKAsy9EicwXcP+6N4C02/oYbti45PapqNGyiO?=
 =?us-ascii?Q?Wfdku46sup/r55m9yuXeF8jltAqmVU/6WalD6n5CTAW4HEjwB+wzVZzIDzDA?=
 =?us-ascii?Q?qcZ4LgnUtvHJy/9r3yglROsL9SNgJ2o7TEvPHBA0r4tRyubDZaG9UP+qgaZi?=
 =?us-ascii?Q?aBWggnurZTFWTbc2NVYdSCY5CNNpCd1Lr47qKuQ/ud4kZAee6Sa9kWS6NpHS?=
 =?us-ascii?Q?3a8eMXT0RO4bUBBA8ilB4zi7nutegiA3MkyPTvN7sK6ejvd57cPCHBZCsTas?=
 =?us-ascii?Q?Aogt6UNEAWi+cp5IyCnOgANAIjkskfLCs+GUwaAoBCVcRwrHItsOiY/zcVUw?=
 =?us-ascii?Q?dFCBOMUDsiqaUS6sqNjttxYy8ch9unG2zM0EfYJ25fSGtXGdRYNJqfSqzc14?=
 =?us-ascii?Q?nArd3NtAoQLHtgY0YsBOvYy5/XTP9pBm/m+SZtjZu4a6nsTxXgDcXaWlK+y7?=
 =?us-ascii?Q?ziGIHvSeCqVfn7/5OPlEJQwLXJuhC5COe3BTEO+herbp72SNDcO2HOK8yKUh?=
 =?us-ascii?Q?/pnJwDIMtW+1z/GRy+Rzd+Vep1Dqu+cr6Pdf/gplexgYFMfEGaEnUQN+JpoO?=
 =?us-ascii?Q?P2iAAdIvYZmWBoUIMEtrFXVFE/2O5mB+d/YXHoQzwG/02bwALiwABbwQMYcZ?=
 =?us-ascii?Q?fYQVNqsmddhEGQtkpOnfkC6ZXgTrzCC5FFbr4CnJW1RpBYcVIVnQM4cW8KAV?=
 =?us-ascii?Q?GdCEQ+4HSHAnAdytp9Pq4dkOutesStmzc/p9Eag5IeO/dU55dRZ3MSrjNvFZ?=
 =?us-ascii?Q?Ti4Xx3SwhfvyKU2CeLkUXSF58c4RP3lhaxJCgADlu63p480nCFfDu18B9is7?=
 =?us-ascii?Q?C5mTxKsvqANiPFYEj8eYilVAhO10XfXl+YLNRWqeOrjRpKYKOULZUazRhEF8?=
 =?us-ascii?Q?FGObbVvlCuopjpfOfcypjgLI?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c4dd0edc-a25e-47b7-e7ed-08d921080c59
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5136.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 May 2021 12:07:50.2748 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4QVwxPlLO0iNaj9OUL8pZCl6NdSsH6Ui9TBnnA+sxd7swNwxTJOtrnO1L6OSAeogqFsyYDC2l3eJo6PobOC0Rg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5117
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
Cc: alexander.deucher@amd.com, Nirmoy Das <nirmoy.das@amd.com>,
 christian.koenig@amd.com, amd-gfx@lists.freedesktop.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

WARN_ON() will not kill the process so the second WARN_ON()
will try to dereference NULL pointer.

Signed-off-by: Nirmoy Das <nirmoy.das@amd.com>
---
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index 1134cf6eac82..f2ed51484980 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -9108,7 +9108,10 @@ static void amdgpu_dm_atomic_commit_tail(struct drm_atomic_state *state)
 		}
 
 		status = dc_stream_get_status(dm_new_crtc_state->stream);
-		WARN_ON(!status);
+
+		if (WARN_ON(!status))
+			continue;
+
 		WARN_ON(!status->plane_count);
 
 		/*
-- 
2.31.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
