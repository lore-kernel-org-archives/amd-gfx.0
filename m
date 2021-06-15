Return-Path: <SRS0=xdlw=LJ=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2DBA8C48BE5
	for <amd-gfx@archiver.kernel.org>; Tue, 15 Jun 2021 21:34:46 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C58CD610C8
	for <amd-gfx@archiver.kernel.org>; Tue, 15 Jun 2021 21:34:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C58CD610C8
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6793A89198;
	Tue, 15 Jun 2021 21:34:44 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2056.outbound.protection.outlook.com [40.107.92.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2890389198
 for <amd-gfx@lists.freedesktop.org>; Tue, 15 Jun 2021 21:34:43 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cqyBcX4jBm4jbFWMzS+x1tmoXiiew81y3jZAZuL9eFO8f76KwcUcj/V0WyRbhx50QQVZHBNyTenVUgIdi7yfNsQ+YPNhXUW5FEJWKEEnuAaviWA0n6Whj38HgVVEqHKJiLAgk7shhnLNa8p00J2cjiV8tldWbjI1XmM54AS4BSBR2b2v5oxagpE9mHdXCrRCnca122fWywIGoKzYRRztOJAgBXoK01eC/hdhHIp0e2c/mK13oIOk7re83Z7fHIzAPvAf+Llwnk50OhTy3ajbEcY6jRc/lhINdLB687IyNDzNHAJMKRDCf0gS3JwIwqYXFRnIkTogsnJfxSXhoJstsw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=j3HcmBdRSdkQfiwXdlveKl3KNOxwFR5g7yHD8Jgt094=;
 b=CvVQNyBl/zIBs5kyLji8SMtlN0IN9pdJ46MdNijUmvaB0SF/+68rDZMsn4wMgFvg7Kg8B2eGg4pZDPd+jPZj1DO2H/OU3JyxyoCndgSIDHVg4F1ZRkAAIa5sw8RGcstqamNr3y2sGZnd83dAWJwFH72gVeFr3qyKeVxfGoY1goNAiTCcNwBsAsNe4W+J2dQ/0Ck2QgpDkfH44cl4QkEOp/T/h441kED+7HOQCcij5VjtogYN1xdJU9h//1OV8g+DNgOAx9+XwVu6XgT+ZbBo+mniGH6BLaxMSzzxHmxQiihiJ6id0YmmYB5CthSOXsg46rnrg5z4oO183HKPqRIUYg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=j3HcmBdRSdkQfiwXdlveKl3KNOxwFR5g7yHD8Jgt094=;
 b=WhevGp1CjmG899ILWI64G0fM+YcNGBI6mtgXqo2VMSinVwekqEAjEswerRHWIBfc7FQhRzZjDbjA3bweko4QUozOKmE4LZTkGkAhyjdkPuFdvdLmGbnJgugczAg5FzQLnoR9y1cM1KBZ3Uy1piK+NC6cvCDCEhbUCVPMFecwfOs=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from BL1PR12MB5144.namprd12.prod.outlook.com (2603:10b6:208:316::6)
 by BL1PR12MB5047.namprd12.prod.outlook.com (2603:10b6:208:31a::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4242.16; Tue, 15 Jun
 2021 21:34:37 +0000
Received: from BL1PR12MB5144.namprd12.prod.outlook.com
 ([fe80::3c38:805a:5664:9047]) by BL1PR12MB5144.namprd12.prod.outlook.com
 ([fe80::3c38:805a:5664:9047%3]) with mapi id 15.20.4242.016; Tue, 15 Jun 2021
 21:34:37 +0000
From: Alex Deucher <alexander.deucher@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH] drm/amdgpu/vcn3: drop extraneous Beige Goby hunk
Date: Tue, 15 Jun 2021 17:32:59 -0400
Message-Id: <20210615213259.1326051-1-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.31.1
X-Originating-IP: [192.161.79.207]
X-ClientProxiedBy: MN2PR05CA0052.namprd05.prod.outlook.com
 (2603:10b6:208:236::21) To BL1PR12MB5144.namprd12.prod.outlook.com
 (2603:10b6:208:316::6)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost.localdomain (192.161.79.207) by
 MN2PR05CA0052.namprd05.prod.outlook.com (2603:10b6:208:236::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4242.9 via Frontend
 Transport; Tue, 15 Jun 2021 21:34:36 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 2b9e903f-b6ce-474f-94f6-08d930455ff1
X-MS-TrafficTypeDiagnostic: BL1PR12MB5047:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BL1PR12MB50471267355686B47AB3CC38F7309@BL1PR12MB5047.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1201;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: zzgtImT6a9RH2vzPSB5A+MP+T0/8Nh74HRN0U6AlGcpxVRTjOzEMWzBPRHKnS5H2QwWyAXJK7BJzT1+gm2M8uvPIQnT5GLCSRAm4AlxyZ6aR+5G004kuDElv+yGVV2thGeTEq4tEkQ/MkTvFCk2wkUOOglUeMyduPUob1BukPlEqmjD99yl8FYCVPNc3xZ7Ixl755aLyc2SNjfYZj4JjhW1s6B6ciQPaBhta+OTKoueunc7ARl9Uu/u/8KjYfwLvhwjn1gP+BI2yqPLoJ4xkaBdpiw8N+Hs+5pAR7PhVM9hvz1tDVzb0A3mV1mIJBHwTYi86Par3Bfs0EdXI9TSdgeRqy5dVYM90g/6gFgGHBL/cerFLuHixHYbjE2M/0snPYIpZLPrrO4YO+jwjrazfSTHG7RTTvM0+Yp0D+aLWnyQw0DyE0FYSvTYrx11hZ/HqhCdF3TZzfTuxUrpIWnPNms/nAKqFqLF5owc3ojOsyx07AjzxYTAG22kpxbebS8CFdRheqZ+awzlbMZKYF8xXYnkzSC5mxCfK9MqaR8TtwYucJpNHH6ZbV2pgy2MvSwoDdLH1mrI2udGDsSzTTsctza0K3LowpIJtlC9apHl1gOgfdwFR70JJ9RaQVlpyyNVVwoT2ny5pEjRYcHiEqTNJSUUBs45vTGn9xOx4xEfq6oT03mdfF0ZL0ktgqhrr+slh
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL1PR12MB5144.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(136003)(39860400002)(396003)(366004)(376002)(346002)(66476007)(6512007)(2616005)(1076003)(8936002)(2906002)(956004)(66556008)(26005)(6486002)(38100700002)(16526019)(83380400001)(38350700002)(66946007)(186003)(478600001)(6506007)(4326008)(6916009)(8676002)(316002)(52116002)(86362001)(6666004)(5660300002)(36756003)(4744005)(69590400013);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?5QQ/G81KbdDSF2hZB4R9nqAxLsUa+BFYag+8tL++VndL/jmRJ4YLQWW1oSUw?=
 =?us-ascii?Q?NmshSSs6JOtQANJzRHrAnY9nJwqOvaurPMyXgX8D2dWWtq/egbwJ/Fmv8ocQ?=
 =?us-ascii?Q?21kKdWjdbK8N9vqqz1J/GvaF3QxoTs7358BC8SBx7VutJnxfQOxZ36CA4TkG?=
 =?us-ascii?Q?+4QDj4/1HzSjuNbMw5IEP/xOVssO5lQ57TO3RKmhmoWYqY/n27OML65nfu1u?=
 =?us-ascii?Q?WsMoggYFvabARsUN5gqzu29cfon1yEL8f0nVj+VUI32d2ini3qJxEoHDx/4F?=
 =?us-ascii?Q?5VrUXKZ9srGcPbP7Gf5dLEz6EB4H01aiZTHEqRL4iskG0tCmpRGNhhhhzxRi?=
 =?us-ascii?Q?NHob5NDJYIa17TlEvuDx+5ofeJLHiduCuROYOXakown9dh5G9tbofOHProRd?=
 =?us-ascii?Q?WAlgDY6FSak6ZXOu8VZlBBwDmIARN7MjZQdzm4RAHODzipipIa/RPyG9AlXN?=
 =?us-ascii?Q?kRlNxpHMer9M0Rv/dj8D0nWrSuvFzQRVlXAbGu1gqu16oN86+v6sTkD3z8hU?=
 =?us-ascii?Q?YjnhFjLO7V4zVO3QhIwCxW/DTntt2FJujIV9Ytb8yErW0Tn+6sW8jMzBkYmI?=
 =?us-ascii?Q?R1+0KrypVY9GVUSM6Qla677ul9ZDO6xq0AHb93lg+e/sX7vc3tAz0d5Oh7je?=
 =?us-ascii?Q?DPjkUSTDJ1wfE7Dw4wTKxFnmVHYbIbW5hYRp23OAd8DggL/z8ZnkgdGTs2jZ?=
 =?us-ascii?Q?n3lvn0Naz7kxRlRWQaYA14ne0+S+Jm/7mhfkxz0YqxhGJkCyZ+RNl7QD0WL5?=
 =?us-ascii?Q?Qw/d4WQIxfzRnoGX14txhiRx2AVxBYPlQNpikd6QS1AM+D3JNvT6Bl6jobtV?=
 =?us-ascii?Q?HK6IA7UvqcONq8P0k+doJ1PQFsUM2naCBAmkwJv0nRkBjJW9S7Tru+w+9b9/?=
 =?us-ascii?Q?nZenbaICJtZklvCY8c2c3fqi5wmi1zuwRaZPGH3wNGbtYTehaYPGnhNN/1Go?=
 =?us-ascii?Q?2ba5s2AelS+LvmLzHBYt8IUwZQhdPjtaz4PxtEWriUX99kPHRnL4JVLA27Sh?=
 =?us-ascii?Q?rvCSmG4XZRWYuzHcWzRRb/vSKy94nYeKzn5UIUgMIMuyWBwc26neT+avut/Z?=
 =?us-ascii?Q?JpONn8SJEAYp3nDY48M8YiIRX9DkwsbzIUy1TS05l62K2RxQwMen7rJrKBN5?=
 =?us-ascii?Q?2zQeTtFo0MDcLckPRwi9QHrtsLDSJ22NJuq5C0qDxsj9TmZEfRMFIx3plxWz?=
 =?us-ascii?Q?5EkQh89Rkk1BAVcxKmFTRHd4SR7iVgGJTXyOhA/diwGbglzVT3vfRuqF/a+C?=
 =?us-ascii?Q?iVQodsU9mztGXLC2meJrpEH2UihW8VOcD4B/a8fsZbPtiC2SHDQI91Hrt8fq?=
 =?us-ascii?Q?1XlN0nrppXQ/OuCHaKBE7jvx?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2b9e903f-b6ce-474f-94f6-08d930455ff1
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5144.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jun 2021 21:34:37.4710 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +uyuuFNLzFuUbT7SbdaDn3dfN3nszu5OuiM/Gc3SwHaSMBj8MoNe8dZcuPmNZWis7ScDJYq7hckr7MtD07i6Qw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5047
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

Probably a rebase leftover.  This doesn't apply to SR-IOV, and
the non-SR-IOV code below it already handles this properly.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c b/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c
index 4c36fc5c9738..ea6487ca997a 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c
@@ -93,11 +93,6 @@ static int vcn_v3_0_early_init(void *handle)
 		adev->vcn.harvest_config = 0;
 		adev->vcn.num_enc_rings = 1;
 
-	if (adev->asic_type == CHIP_BEIGE_GOBY) {
-		adev->vcn.num_vcn_inst = 1;
-		adev->vcn.num_enc_rings = 0;
-	}
-
 	} else {
 		if (adev->asic_type == CHIP_SIENNA_CICHLID) {
 			u32 harvest;
-- 
2.31.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
