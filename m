Return-Path: <SRS0=n+xW=KC=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8163C433ED
	for <amd-gfx@archiver.kernel.org>; Fri,  7 May 2021 01:15:01 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 25CDA610F7
	for <amd-gfx@archiver.kernel.org>; Fri,  7 May 2021 01:15:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 25CDA610F7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BE4286E1D3;
	Fri,  7 May 2021 01:15:00 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2046.outbound.protection.outlook.com [40.107.236.46])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5C9D36E1D3
 for <amd-gfx@lists.freedesktop.org>; Fri,  7 May 2021 01:14:59 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MueNZYMeiHX7RUKI3LpIIh3F6h7Za0D4O6uv47tArPFMviptf5d/fBnTzzH3+LyVLKwZnS0hI7GAGz0CLplkNR+gvHHHdDmND5i7H+wHSEuHUKs/NwPN4SA+P+CQZbg4KLwY6wkrw/onaeDdmg6RgMReuVRKe7HkdE2ZxNflfQ40LC0Y2GAo1osfHDHt1yyaMiJ7HKR762AccvbjK36HyukmT8Vq0y0jBFqYfo1+NORDy00FU9i8LpXo+MywOoAKIOb3WlPA7BBHWC7Gl1sSg/qK6s+eRPWrN/3cUucfh/F7Jpjn8hgNWBqSAuh904eYm6gWUA6svB5YSEUlsXLPpw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VaSe4npqy7aQmUmSPUxefrn2Et6flXAszGJPrCmoG2s=;
 b=JdXx0xbGRaxnLQo6c/NgkeWuLD7FWZ3jMXxoAdZwVTRDOV7cn5HRQrSiCGuTXZBwDkQ1OsYO/sUXeXgpmHB3TGFsDoPU8Y048QfXs3iebL+uNlzrZ9wQxfZ/vV205ssuRhcddBll6UNNxQGrCzsGFKphx5WDmFIEKpXsI/TaRco3GZNMAdlyaQ1dpmxuESil8tfV4qs0OvElk3iQLq62tJhHsqp1z5wkpTCIeTDRhlRzqpi1YcjundkjSzrJ/NkfdkUcd9T4Tvhkjhdqt+FkWz8tbm9FmLHIaeGLHOg2F+X/24rO/tfICgBuf45hxZusmbl5wUDmSfmOZHUDU/qmAw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VaSe4npqy7aQmUmSPUxefrn2Et6flXAszGJPrCmoG2s=;
 b=w1/+Se338TWjfZfjFBwoc5lyCiBJpzF0Fd8k6ag4r1nuRYkx3UEnKA0kbSM7/n/nRDk865gFPPZNok/dS6VSLt+MmeaCXLmvUTwL0vIZuhCAgG5aVKyMF9SteUCwcFB/Cl7Efp0U3VgBUJKsqKoWL8Xg+BkjwpudGpaaqc25d4k=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB4732.namprd12.prod.outlook.com (2603:10b6:5:32::25) by
 DM6PR12MB3161.namprd12.prod.outlook.com (2603:10b6:5:182::20) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4108.25; Fri, 7 May 2021 01:14:57 +0000
Received: from DM6PR12MB4732.namprd12.prod.outlook.com
 ([fe80::f40e:1245:84b6:e2a4]) by DM6PR12MB4732.namprd12.prod.outlook.com
 ([fe80::f40e:1245:84b6:e2a4%3]) with mapi id 15.20.4108.026; Fri, 7 May 2021
 01:14:57 +0000
From: Oak Zeng <Oak.Zeng@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH] drm/amdgpu: Quit RAS initialization earlier if RAS is disabled
Date: Thu,  6 May 2021 20:14:45 -0500
Message-Id: <1620350085-22406-1-git-send-email-Oak.Zeng@amd.com>
X-Mailer: git-send-email 2.7.4
X-Originating-IP: [165.204.55.250]
X-ClientProxiedBy: YTOPR0101CA0009.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b00:15::22) To DM6PR12MB4732.namprd12.prod.outlook.com
 (2603:10b6:5:32::25)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from ozeng-develop.amd.com (165.204.55.250) by
 YTOPR0101CA0009.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b00:15::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.20.4065.25 via Frontend
 Transport; Fri, 7 May 2021 01:14:56 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 91f4f215-5798-4def-cfcb-08d910f5872d
X-MS-TrafficTypeDiagnostic: DM6PR12MB3161:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR12MB3161ABF209010BC6524A707280579@DM6PR12MB3161.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2449;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ta62nOdROqDPheeQg5k95X3HaNSyPoLeyAMeLqjCog1NAUW2bMwutmwiMxss90Ofq+ib0GzH+lgqIzKb5S+8TUonSy40/G6b0LjyO96yrWQUA9VCUombtNkUwqB8c2mnKr+tkavuCDrDjuItWlLfg2qPBQvuSH/b78ipWTde2WkpquI2mQujNA8ImpM/zsI9RTrJXi+lD/RSX1xy8ZGEM8enYRF+HDTA7zKcgC35r4FJvlFbHRRxzS80nEWGLFIQSBAIy00NhQ0JbEc7t+0jEiRb8iuqBESyEUUxQEIbXJ1ifVkGo/MpZgw4tvBmEaqILYF+QvwsKxebszCelYN8QblGlfK3qep/tAj09HD2h0Z8eQYtyrBsVPnSH9Kz11HzkOyvNtRLfL1AnerVBFi1UJxm1w/N9fjSGIjeHo4SekdFAvpsSaaj1MJnqcjunt5buXNmzPO0TkncYJpaDyx5UZ9PEuIgrfvnXV2pLgdVEjp6HLa/Jj2RATU56mJO/8qgZuG+kCacpfxa+MuC0/f/n/sriheVHBFdRZZ2ngbxH4Va34lg62DCIhmFJdbaP91SwZ9OpFx0A/Sibk4NiVQJn6U+6+fMAMEoV4/Kk5cqZ93nDV1S3EsQx2xt7dtD6O5bpS/Z3Z4oFRfn/hQwYb8CGqkVFccBg+zt3Dqi9ssLs78=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB4732.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(136003)(376002)(396003)(366004)(346002)(39860400002)(6486002)(38100700002)(26005)(38350700002)(36756003)(4744005)(83380400001)(2616005)(6666004)(186003)(7696005)(6916009)(2906002)(66946007)(316002)(52116002)(478600001)(86362001)(5660300002)(4326008)(66556008)(8936002)(66476007)(8676002)(956004)(16526019);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?EgDV/lu+Us7DW8/97e0F8z4Z3EJIjfMfvSJZiaSu/jIxooFpGtFZPjepZvJL?=
 =?us-ascii?Q?E9RX2/UFNwQKgMbrUjZizfYo8muApc0sPg3fE1kUfF1gCt1RlQ+HGk9Xn1/c?=
 =?us-ascii?Q?Bk6Tql9727IrS6Qtcz8ZxDkDtCwu/TVEU/ZD1lGPuLCrAKNV1OgSPpQQBZ79?=
 =?us-ascii?Q?vjhElrRgqvWK67ryHAoKZwXjzOmecWBuvddqpn1TL7Ofx/zEOGjTFmI2Hast?=
 =?us-ascii?Q?63nSDv4L2Q1wBvDJbyRb+Ua27A+9S+zWFw2+Rk+La6cIgG2xbWpfoT8a91Wr?=
 =?us-ascii?Q?JE6QuKu17UW0GaPztyyD9Rfl/IiYV61fk0iB4ov44TMaLNJFdakr/RZ1CAOu?=
 =?us-ascii?Q?xtXOw1owIjbReNK/QJucNBSR4481MEaQ6/cZ27Z82oZIlsZHKH+9gjU80RZH?=
 =?us-ascii?Q?PPs3VHIWNfr6ArtMG+DYi/fsjo0k/eejaWoV53MfkocvWBq//l7Za9PkP+4X?=
 =?us-ascii?Q?kMQcBrnm5vc5O/UADLYm9huN7I7pJKK20JrMnzj5HIwZ61mSnQD36ctPIcFe?=
 =?us-ascii?Q?vQCjtsb6Cb30CRzTYVJF6QB+NhuSuFOyLQauH/+Px72W61jh4PNILEAeEee9?=
 =?us-ascii?Q?Tvk9Avj7zhJRcBWAUp5k4F4NnG3rX8/e9o8Nb6hN1IEpRMH1fJYySYoc5hLZ?=
 =?us-ascii?Q?HQqdIfQV9SiCXROn3jvknZc9g8UKMLAlg1Q26dN7kZiDTwvVn1lrxYsTXFhr?=
 =?us-ascii?Q?/rVPfLQAHCYcyej/uINNwJ69CiPJNujmwC7pq8LE9w59WXnQAtAzUcKtq6yM?=
 =?us-ascii?Q?w9GMdl7uzU6/rnnTOwaSPPIu6/mxUjSU/OS1ND3+bHSWiDWyxDoPIa1wMt26?=
 =?us-ascii?Q?AITenWRYWAb2cNHVqf0DwrpCfedZd9zctzIgc7BClOW3NY7UyHsdHAodudoA?=
 =?us-ascii?Q?yxXuOUUit4CU/f22LYZdSO/Poxc3igxYcOxNgHTTthBGQ4wrO0BSJj/eiwB3?=
 =?us-ascii?Q?fYFPRnwGJHi7LUZ75+juE0AiGVBFF6ESYm7LF3rEz6EYsiGyObgXeanqLfjE?=
 =?us-ascii?Q?RNiYdCr+p8Fsx/Z/RS+DvS9FILJNr5L844FF53r64ss7LjZ08lj3bvN3DmqM?=
 =?us-ascii?Q?yQhl6hDrI8v8+BNlgVaODQCBdcQw/WT780svmkxy4E2zQbdbyDNjFO+oLGSo?=
 =?us-ascii?Q?pP++sijwxwDsd4K5dF7fTXFUs7P+PqNlefCnKw3Dthjr78H2LVXHzuNn0YlH?=
 =?us-ascii?Q?AAgUEwo0eR7NhbtfvcGbSlsaHgOQa/m+HVwvR7SHc16Ilmn8vUinRgrPr6+3?=
 =?us-ascii?Q?eUVzV9gTrcBY5jjBS7qFc5Z+FozbxvMWSgHyv6rdZf/q/pS73BfEiK0tRZuy?=
 =?us-ascii?Q?1qRE7uJqtx4J8y7osT+uiK/D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 91f4f215-5798-4def-cfcb-08d910f5872d
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4732.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 May 2021 01:14:57.2633 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4T0w/RFN5Ws6qrSOArCJyQauYTOUTwlpyGODAlCkUFAMnzlvi0r5+7VilFqPkpUf
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3161
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
Cc: mukul.joshi@amd.com, Oak Zeng <Oak.Zeng@amd.com>, lijo.lazar@amd.com,
 John.clements@amd.com, hawking.zhang@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

If RAS is disabled through amdgpu_ras_enable kernel parameter,
we should quit the RAS initialization eariler to avoid initialization
of some RAS data structure such as sysfs etc.

Signed-off-by: Oak Zeng <Oak.Zeng@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
index ebbe2c5..7e65b35 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
@@ -2155,7 +2155,7 @@ int amdgpu_ras_init(struct amdgpu_device *adev)
 
 	amdgpu_ras_check_supported(adev, &con->hw_supported,
 			&con->supported);
-	if (!con->hw_supported || (adev->asic_type == CHIP_VEGA10)) {
+	if (!adev->ras_features || (adev->asic_type == CHIP_VEGA10)) {
 		/* set gfx block ras context feature for VEGA20 Gaming
 		 * send ras disable cmd to ras ta during ras late init.
 		 */
-- 
2.7.4

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
