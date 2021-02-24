Return-Path: <SRS0=z84W=H2=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86C70C4332B
	for <amd-gfx@archiver.kernel.org>; Wed, 24 Feb 2021 22:21:16 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4BC3A64ED6
	for <amd-gfx@archiver.kernel.org>; Wed, 24 Feb 2021 22:21:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4BC3A64ED6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BBE176EB6A;
	Wed, 24 Feb 2021 22:21:13 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2076.outbound.protection.outlook.com [40.107.94.76])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 446A96EB66
 for <amd-gfx@lists.freedesktop.org>; Wed, 24 Feb 2021 22:21:08 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZmYUQ8M+RhMKwajng64m7+nO1bMSrH79oRug71DyWML0hXLwA7lyazhOUlEIsq0VNiAm2TCQCqTf3cn4FuL1BISGWZdp4ekLPPJnZn5FnSqBq6QMP7gZyhY49Jotvx79ELGZQ9+S54CFUKyQCYfGoaJvDEewhCVfG+FPjBrRaYZ7d7UtQoldUUkPfTg2ME+aEC1pOusHBKDjNl9T/pdpgQlb0wF5nZ7SMZyK72Q1y2FP0sZsaVVaHO6FnwcRpgabiDqnHVNK0qSxbuYrvA8wWhD6KU7bx1YrKTIAd7SsbYA4cajhEI/PFB7TEMXqwAHWQKuPNVdmnWONfWfs0AwbUg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NbAPk+ncCO3EWCaoDa/ov9LNC+vQfasd1uVwv82cMNE=;
 b=jqiSn0bRqRhFYR5ZB79yUmFRZLEa+g8bU4DKvAwdmAa3BCcvjzQoQ/j/lkXfa4gS/eYm+K2XVcq0TPjD6X1rlcqJ79uIee4FE7Z3HbA83XjJgv3KbLgLW818qRB8c+HeDqv5R+xV1kW26VDgKL5pPiqRM/aaXUnpePog5DEqKIZ5A4abVxQrK62StSjdaE/+s8MkS0bc1FqcGDx7asbh2fPw6LdALFR+xotHI0f55fYK2AzLy7bIojLl4cbQ/J/heps6w/v/aLEMbZkpBoGxJnvIK8ar9nGS+x8uKzVJ2RKX0UY+09wSMW4HQeH9odYS91Q0oJvqRG2eWJfICyojvQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NbAPk+ncCO3EWCaoDa/ov9LNC+vQfasd1uVwv82cMNE=;
 b=qrGxmah8GmaG3aDP9LuY1B2R21YNmTreD3AgmSU4Gim03eQx6TANKNymtQqNbT+tAyynamd+KMoUJpdUQsQYXItVBWW6KXbV03EPIZLy0nfB72En5xl4EK7SveKxbkyqFyMLrhDU4lRq/wvJLVBUcZCbdNHOxY/SYC1ofJRyaK0=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from MN2PR12MB4488.namprd12.prod.outlook.com (2603:10b6:208:24e::19)
 by MN2PR12MB4046.namprd12.prod.outlook.com (2603:10b6:208:1da::23)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3890.19; Wed, 24 Feb
 2021 22:21:07 +0000
Received: from MN2PR12MB4488.namprd12.prod.outlook.com
 ([fe80::b0c4:9a8b:4c4c:76af]) by MN2PR12MB4488.namprd12.prod.outlook.com
 ([fe80::b0c4:9a8b:4c4c:76af%7]) with mapi id 15.20.3868.033; Wed, 24 Feb 2021
 22:21:07 +0000
From: Alex Deucher <alexander.deucher@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 084/159] drm/amdgpu: disallow use semaphore on aldebaran
Date: Wed, 24 Feb 2021 17:17:44 -0500
Message-Id: <20210224221859.3068810-77-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210224221859.3068810-1-alexander.deucher@amd.com>
References: <20210224221859.3068810-1-alexander.deucher@amd.com>
X-Originating-IP: [192.161.79.246]
X-ClientProxiedBy: BLAPR03CA0027.namprd03.prod.outlook.com
 (2603:10b6:208:32b::32) To MN2PR12MB4488.namprd12.prod.outlook.com
 (2603:10b6:208:24e::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost.localdomain (192.161.79.246) by
 BLAPR03CA0027.namprd03.prod.outlook.com (2603:10b6:208:32b::32) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3890.19 via Frontend
 Transport; Wed, 24 Feb 2021 22:20:17 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: ac7ecfce-0ff6-4d94-fa7e-08d8d9125dda
X-MS-TrafficTypeDiagnostic: MN2PR12MB4046:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MN2PR12MB4046D8DCD6AAEDDD9B786EDDF79F9@MN2PR12MB4046.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:626;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 4e89XuxquW+PeQCii9ATxmLjym4J9t/HeGijBjaNkvLjJtujJG1TzyRWLb3nOAS2unijTIjEGfTyO8PYLClwuafyiUkaI3fMZNo36FmOkcOccAMuZnm9U93BqKdRAZ5PPefRcxh75WQH+YdH8Be/2CtsVtbvEzTdLsDdcrGo4eehUhG57Zv8bIjMS8EREMTjNDafR7v9cgqbZIZB2zQ4ZB0MO3PspLzc/hp8HuVTZx1Ir8h/gZDnTj6diK3LQ+Mvs2PvdARcDhVs5Fxw0zW/kxUFb5TNs15C2l4cKOG2zHdH1AVrJdpIEPTvS/kA+Gxlp25WW0YRDph8FmGB9/HCHIZJR0eI2yfKhv0SFWHeCII3PqVTPep89uwBRbhRlLVnv6t4iFDwJjMz6snsyclw6TTxR9iAy5iPZA/ISFOPtEQ1R8tQlHpn19/TiKRdzINBoaOO5VJwKprCxk2XeXcQkf3t6oWqSsBxZ2x/GhxK/7s4p/aqpq1sn9qY9UCW4/Qrw4ZtOpwJBOmF/bj19cpHc12O88KjhALnkJJytiGmI8cLHZI4Kqyxn7UN5AYXeEmxUVNo5fPGa+oTNK0dFsBsig==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB4488.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(376002)(366004)(346002)(39860400002)(396003)(136003)(83380400001)(86362001)(4326008)(956004)(2906002)(6486002)(2616005)(478600001)(69590400012)(6916009)(8676002)(8936002)(1076003)(6512007)(66556008)(66946007)(5660300002)(66476007)(4744005)(26005)(6666004)(186003)(52116002)(6506007)(54906003)(36756003)(316002)(16526019);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?wRB/NPu04AL0XgHaE8Txd3uUv3tpqtDyUmJUfP1xapnudLAt186CogJqBRcP?=
 =?us-ascii?Q?x2P2wW52Jf+jB1QxY9lIMUgTgY5NCpiH0uGbjtTdHqUkW/Am+Zi96S2fMcYA?=
 =?us-ascii?Q?dxc52fk63O03ZR2Jk7MT8BPfvpS63nsusBnnWyz3xGJLN71A0zqwazbQUezQ?=
 =?us-ascii?Q?HXobGIKxVpE3YnxsFnChgePU8eiEWvMWoh42sf2WoiqzyD43AM//Rm2FKzoZ?=
 =?us-ascii?Q?3Oj3P5BBJ8sVqInxQgBxLeqBweU56PkrgHP7e6+Sq266cfZ1QJWnV1plIToN?=
 =?us-ascii?Q?e2OZrHeSt7C2WjQp5lGdQjgkl8Hrjmej/kXbqbHLi6K5Kt8rJMQDZyVrdQj6?=
 =?us-ascii?Q?vbBmdz83OA+9o/01lUE3KG9HRFl/daK+6RHyZJ+z2HAtWFP18AxQGDQT35K0?=
 =?us-ascii?Q?DOvWf/Zg59Gewrqzyi5TEFm69k4/EXXjETJMFX+LKCv3j2jzPHXK37SzCjSO?=
 =?us-ascii?Q?ad7stherr1ZLefbXOjCe8M3cHuIDaseITvw8nDvIfAzZf7sbLXpEOS4PPSaZ?=
 =?us-ascii?Q?HoFIrvk/MBGyVHgd0wbHNgma2g6CY5g256lBFxbX1BwH65xZ72VBfb1AErDd?=
 =?us-ascii?Q?8QdiETbj6fEvW6+XYQIeSuUW2Jc9EQx1FlDNDFdncx5ZvV4KDCTGISrfwbVe?=
 =?us-ascii?Q?t9njm5mqoKmfoeWhrV6xF+SJLzeTFml/9tN1smbZTs2tssb0YsDzqs6ouLv/?=
 =?us-ascii?Q?FxglmOPI/dzblDyyYfdj7gBC6f/Ji0MkEeSEP4NyT3hGlXNVtUhV1N23hZZW?=
 =?us-ascii?Q?D6EL0iP9ISl5+73lUn1s3E5uymm0lnRVi+tuXPsyK/NPJisI7vmO9pGoagzc?=
 =?us-ascii?Q?OoATmopSeMdw+sKCfeDJLj4JdG7RQxuKwIuzpFWWdqgw8bkeJFnsShCwcFxF?=
 =?us-ascii?Q?3zI+Q3bXEug7pWT4Q9kgFeDCvjJSNYBADne3ZQu/KkP1FQ/LndhxchBuuw95?=
 =?us-ascii?Q?+CRSMjVZvLC0lZhgApl4pgFZVhqFrqdl/j6GLOdbILwftn5F79fNEdjX0mrN?=
 =?us-ascii?Q?aqyeqiGiUvts9b6PtLrmu3l88zTnct7t8/fQevz7bkvqVx9bBb86dc5WMsMa?=
 =?us-ascii?Q?Ec/EL/vc755nV6rxHgWz8u4Xyzz0KU5ini/aziTDU4ww3s3aFd96t/FtDz2p?=
 =?us-ascii?Q?STJ6xfmEefrZmSIHABkrp10SBAzbh4s1+3Lw6ckPbIyXUWzumuDc63KC+nuW?=
 =?us-ascii?Q?ZsdBOZ6JppCdkL23gCF407n+L1cUqb5NYY1uqEuu9Ea0+CT01OYn5vN7Mhh/?=
 =?us-ascii?Q?5hIvMAxUYRG7uUaYBsYhQy+ntvBndxOMYOlfhK8i93STeyKS27/z4v18Fn1P?=
 =?us-ascii?Q?eoDIyE2QChv7dhbj24Lo/0yZ?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ac7ecfce-0ff6-4d94-fa7e-08d8d9125dda
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB4488.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Feb 2021 22:20:18.1948 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kZts4LsSEdQPBZOguyvuF/tVkLw5jPKRSdeVkokK//5SWuzjr6wych6d5keM0Rpiha05+hvzgdoLY/Urj8T7VA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4046
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
Cc: Alex Deucher <alexander.deucher@amd.com>,
 Hawking Zhang <Hawking.Zhang@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Hawking Zhang <Hawking.Zhang@amd.com>

shall revisit the change later

Signed-off-by: Hawking Zhang <Hawking.Zhang@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
index 37c815094adf..6009aee49fa6 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
@@ -644,6 +644,13 @@ static uint32_t gmc_v9_0_get_invalidate_req(unsigned int vmid,
 static bool gmc_v9_0_use_invalidate_semaphore(struct amdgpu_device *adev,
 				       uint32_t vmhub)
 {
+	switch (adev->pdev->device) {
+	case 0x740c:
+		return false;
+	default:
+		break;
+	}
+
 	return ((vmhub == AMDGPU_MMHUB_0 ||
 		 vmhub == AMDGPU_MMHUB_1) &&
 		(!amdgpu_sriov_vf(adev)) &&
-- 
2.29.2

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
