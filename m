Return-Path: <SRS0=bbC/=KX=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.2 required=3.0 tests=BAYES_00,DATE_IN_PAST_24_48,
	DKIM_INVALID,DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9EF9FC4708D
	for <amd-gfx@archiver.kernel.org>; Fri, 28 May 2021 08:02:13 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5EFF5610C9
	for <amd-gfx@archiver.kernel.org>; Fri, 28 May 2021 08:02:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5EFF5610C9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 17DD76F53A;
	Fri, 28 May 2021 08:02:13 +0000 (UTC)
Received: from NAM04-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam08on2046.outbound.protection.outlook.com [40.107.101.46])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1D0E56F53A
 for <amd-gfx@lists.freedesktop.org>; Fri, 28 May 2021 08:02:11 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MbZwsJOh1jHXU73KzE4ia306DJ16XGXbc06DB5RR9h3U/2cwFeahZnLMYJfNeHRLDYCKzBwZC0tKltCVi/XLXRQmP+SfhCH1Dwy3Vn2qtnoljuJVZEIjxylNkUNGBogSYZqUAehUnUtOfa1kiBc957t1nlM3FRNg3zrYZ+rj+b7RkzV/dH2BjePQ7Ph1QDGNr7uyoimD64UYxOa2MK9Q4gel15Ki98gJZ+YJePMoa5bKifrK3N/oYAESk6J0Eq8YPP/CA6lebs+RP44gl6en/6BDuNIbj5FtYfMPo403f2pgX47DegHkAgDYCT6xiE9aEKICni6HydTVCZtVv9t4mg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9kMC1n2BAfK8V5SxuGr9AjRbdo91cNFWSMNjsmRfZz0=;
 b=CxT8isuxTK7ufBy+RMPEtFe2JMVEp5HgCQYv311j79tuKoUJzyU4MJSLmtreo7MNGrVlGPixVxz22IJviC3SCKvyra/oS+9e+NU9sLFG4Pmo4EWeiRjq5xxlvTfdrNDBmaB8aD58zEiA2qYDmsDC/X1b4ja3C6xHcvUyo0wncW5t0tJ74FR+3haVC3IUjpRgkYBqXxbYXwflowkmCU8eAXSNiqmzconeNHZAOcJH5iL82QOZZjggdRes7y7KPge7lIYXy9WXxPtLg2T0aioWI6UNmsJOTmdbmeU74O/09krVd/bMVbFKZm+34hJIUwD3gtbbuOVTZhW9nqTdaYDGKQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9kMC1n2BAfK8V5SxuGr9AjRbdo91cNFWSMNjsmRfZz0=;
 b=UP4/i5xoVmX3tWZ+DnR43N0VpbIir13tAc91aYjp75fFBTu27uSqjUddYEalWdmCdRAAvDGSJSyFZguUOxhUSCyzxLzFX5qtUUqFII8b7hXl5jc1S2/FMK1hKxFGGkYeyPhE2ARrCCCKnPkqbL7ldAuV1MxTqt0bqgZ/oRHu8Bo=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from MN2PR12MB3839.namprd12.prod.outlook.com (2603:10b6:208:168::22)
 by MN2PR12MB4566.namprd12.prod.outlook.com (2603:10b6:208:26a::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4150.26; Fri, 28 May
 2021 08:02:09 +0000
Received: from MN2PR12MB3839.namprd12.prod.outlook.com
 ([fe80::c14f:8ae9:c5fd:212c]) by MN2PR12MB3839.namprd12.prod.outlook.com
 ([fe80::c14f:8ae9:c5fd:212c%5]) with mapi id 15.20.4173.024; Fri, 28 May 2021
 08:02:09 +0000
From: Sathishkumar S <sathishkumar.sundararaju@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH] drm/amd/pm: use attr_update if the attr has it
Date: Thu, 27 May 2021 09:53:42 +0530
Message-Id: <20210527042342.29763-1-sathishkumar.sundararaju@amd.com>
X-Mailer: git-send-email 2.17.1
X-Originating-IP: [165.204.157.251]
X-ClientProxiedBy: MA1PR01CA0180.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:d::18) To MN2PR12MB3839.namprd12.prod.outlook.com
 (2603:10b6:208:168::22)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from arun-Mandolin-PCO.amd.com (165.204.157.251) by
 MA1PR01CA0180.INDPRD01.PROD.OUTLOOK.COM (2603:1096:a01:d::18) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4173.20 via Frontend Transport; Fri, 28 May 2021 08:02:07 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e07d053a-9a3a-4c38-7b1c-08d921aee47d
X-MS-TrafficTypeDiagnostic: MN2PR12MB4566:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MN2PR12MB4566DCAE7CD7EA7397485BB49D229@MN2PR12MB4566.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1284;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ONeuJYPkiFCKLfpy2P81aDXRXcE8oyMR4/fbBsVaN+eDzxX7EzvijhymevPpBqgVjYYRkgrIzZ+VfqXiBi0nJQAODZuMwKFAhISmKFpztLVclIJ/oRqYQ6FvuWQaRcPwQSLknbOZJHdYYxqewzhjtKOzfJe9Af4fdE3ffBb7dUopqpBFtbJEFn4TSXGPmeQXoXFrDQvEPaVvPa+W75cPesBxMbliEp4wYoo9mTke5bzi3opdL06dLTuwnqhLIcqjekgq/vrLKXueDtH/5NvvqXL+1ynugnADpa0S9NPu20fkR9WIbtBW35f3KQwbuITcs38jam+BBayiZWk83jtqeugZOIZ0KN9BbyIdx55Kon2D2C22ufcEST98bAfTNRQTYullHTIkROsd54mD5sJjveuqiWoqaZ5Mc816/hib5wLtvxhDOxTnFuwzfylXjSv1YLwBWvKJ8ni6Q9e4j3uY/11taMqdIWmA5l6+WaOTviP5QI7/SInNv4KwUhsR7Zs8S4eQme5qOhZhe+9fMFYYwLcILrME7vNVCYe6jk0q3tmVjMbmJ076de/hFxdr5ukq2Xy3KtoFRoTviPLayhh68pbMR7RULcunTX0KzCH0zS0fWtsOsj7RfL7H7Hp5DBnsB+HqWIZZAoXvGtSFESFzD4bExlEsUUMeFXUmXDac/5w=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB3839.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(136003)(346002)(366004)(39860400002)(376002)(396003)(2616005)(186003)(16526019)(86362001)(36756003)(4744005)(8936002)(956004)(66476007)(5660300002)(66556008)(54906003)(26005)(1076003)(2906002)(66946007)(6666004)(6916009)(83380400001)(38100700002)(38350700002)(8676002)(478600001)(6486002)(4326008)(316002)(52116002)(7696005);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?VHM5OXdmcENNOGFKQnZ0aVRUVlFhUmNpUVRWRTV0czdYeUFuQkdQOXdNY2FL?=
 =?utf-8?B?MGx6SVBTOXZCcDRLRmdqTEhHS0xldmlPS1Zmd2dkMysrSXFUWlArSjFFQkY2?=
 =?utf-8?B?WElZVi9pYlZxWTlIenJMdmhHYXJmdkVGc1ppd1ViYitSZGtuSnd1dnJhU01G?=
 =?utf-8?B?cFo4K1BHV1J6R2NUOHFSSFcrMEpxb3A4Z2RJNVJIcHpxaHBZQmdIem1yalFI?=
 =?utf-8?B?WmUyM1lFN09peTA5aG1zZFROQ1VNTDIzMTdwRUE2OWVUdjBvQzE3S0N5czB6?=
 =?utf-8?B?NzhmczJ6WHVqZ0Y1WlYvV1pXUm5DKzRKWmhLL2RReVNDWFAwYXJnUkRQcEpL?=
 =?utf-8?B?dFNWUmVSWk93VTA3QXlCTUpObExIeDA0ZUNrMXQvQlRFdjJLQzUzREhSN3BD?=
 =?utf-8?B?eGh3WnprQS9BSWpwOWh0czFlUldhWmVicHBXYUNVd3VJcCtsbnJQZmpwVzBI?=
 =?utf-8?B?cXN2R2hMcjRGcjdqYjlCekhOelVISGNTZUlEcFp6OCtKbWk4eWVvOVcyYTQx?=
 =?utf-8?B?cEdKai9oVzB6a2s3a0Jab2N4TEw5eWhOcHd3T0xPY2tsK1hQWkViRnlOcXhk?=
 =?utf-8?B?ZE5Dd2x2amU5OW5HRmV3TTkwY2NQM2sxOVFoOWZhUjlNYjZ2T3BsZjUwZ1Zy?=
 =?utf-8?B?aExrREFwT3FTL1haR1dFR3o5MW9lbWd0RWdZSTRMdTlCeThyQW9SbkdMWGVS?=
 =?utf-8?B?LzJOM2VyL1l2MUN3dmE2bGM1Q1BwQnJIbll6L21GTkJvM1V4b2NJVXVaS2sz?=
 =?utf-8?B?Nzl6WGRWMDZqc2tFY3d4ZnlRVW5qSDZPYUVZRTZzNVhadEJOMDVxeE11aWNX?=
 =?utf-8?B?c1BKZS9FZDEvZERGMFZqR2FTaEdsRGFxYllFVTdIYThuSlBLSlZ2OXZrcTV4?=
 =?utf-8?B?dyszTFVYSnhJWTVNaTI2dTZEUm16TzZYeGtCMFVIeGNIeUpMUmVzbGpyU2Zr?=
 =?utf-8?B?c1NtSGlpQlVXeXkxaDBhdFBpWWtkSUVjaks4SElGRHlMcG9peFkyTFJ0OTUr?=
 =?utf-8?B?OW1RZnphM1A5b3VmbWQwNXQyOVJySWozSlZreDR6eGxxOVROZEM2TFdWV0xu?=
 =?utf-8?B?RGx1OGtTMDUzSm9MVXo0Y2ZmSmtRRGFUQzFCeXdvczAyMTJ6cW1kb1QzeGdm?=
 =?utf-8?B?NlpZNzhFQzQzT2pLK1JmbTR3dW03TktiR3NrSWVDTERpazNiY2p4OFA2RXlz?=
 =?utf-8?B?U0Y3QVZVaFBBU1YrR3NkTUszcUExZXRWRE9ZdjBtOGdoMjJMa0xZUnlFdFVj?=
 =?utf-8?B?NytZY0xHYW5GdzdJdGRLNG1TMDJVQWc0K1lSRUkxbHZVSGdZc3pMRWg2WEZq?=
 =?utf-8?B?NzJxUFZDelduNlJQc2NVK0dvRGFkVDlYQ2oyalRQZTBUTDg0b0UxL3RVTG1o?=
 =?utf-8?B?VkhNbytZd080ZzdMNmk3ZC91QTR3N3V0WUYvbS8vNzJUNG14Yi8wV3pWVDls?=
 =?utf-8?B?dk9xeW94ZDYwNHZUVlBNWGxIMGJVeVNJaWhDSU1hdWtyVzZRT2NqbE5abjZI?=
 =?utf-8?B?TGIzUjdScWJmWXJwcy9RQkF3M0FIc3c0cnJkcVJGT1lnWmJ5aTA1M0Fmdzl1?=
 =?utf-8?B?NU5ONHgrODJoUVVUbGZKNnJGbWQ5ZkZBMlFyN3ZuRXk2WW0wMGdVd0tFMGlk?=
 =?utf-8?B?RTFPaG1oMWk0RmNYenpqckRUcS9KMFpZQ0lmQzloVEZ0ZU9uUHJGNmQ5NkRo?=
 =?utf-8?B?TXpOUFY1MHBjYUFTVm5UMHN6YVNvQWlmWnJnTzB1SUQ5MmFJLzlBRitLbUJm?=
 =?utf-8?B?L3NQMWN0bFg4NG5ISzh5TkFqSU5PNjA5MjlWNFB2TzhjWXFwVFpydFVVWURN?=
 =?utf-8?B?UzNOSEtrUVhqWENsRTBxUT09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e07d053a-9a3a-4c38-7b1c-08d921aee47d
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB3839.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 May 2021 08:02:09.4998 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6ovQFLEmiaxLgYTe4K6ORagg3B7vtgHSw6UiGv7TxKphnYq6AuZ2vin+Yv8tG7cEYJw2VKRlkcz/SWjChyVkvA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4566
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
Cc: Alexander Deucher <Alexander.Deucher@amd.com>,
 Sathishkumar S <sathishkumar.sundararaju@amd.com>,
 Shashank Sharma <Shashank.Sharma@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

use attr_update if its available as part of the attribute.
default_attr_update was used even if attr->attr_update is true.

Signed-off-by: Sathishkumar S <sathishkumar.sundararaju@amd.com>
Reviewed-by: Shashank Sharma <Shashank.sharma@amd.com>
---
 drivers/gpu/drm/amd/pm/amdgpu_pm.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/pm/amdgpu_pm.c b/drivers/gpu/drm/amd/pm/amdgpu_pm.c
index 13da377888d2..f48132bc089d 100644
--- a/drivers/gpu/drm/amd/pm/amdgpu_pm.c
+++ b/drivers/gpu/drm/amd/pm/amdgpu_pm.c
@@ -1942,7 +1942,7 @@ static int amdgpu_device_attr_create(struct amdgpu_device *adev,
 
 	BUG_ON(!attr);
 
-	attr_update = attr->attr_update ? attr_update : default_attr_update;
+	attr_update = attr->attr_update ? attr->attr_update : default_attr_update;
 
 	ret = attr_update(adev, attr, mask, &attr_states);
 	if (ret) {
-- 
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
