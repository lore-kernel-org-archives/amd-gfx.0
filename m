Return-Path: <SRS0=awHg=KH=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13499C2B9F6
	for <amd-gfx@archiver.kernel.org>; Wed, 12 May 2021 17:31:34 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AB5C861059
	for <amd-gfx@archiver.kernel.org>; Wed, 12 May 2021 17:31:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AB5C861059
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 176076EC72;
	Wed, 12 May 2021 17:31:32 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2077.outbound.protection.outlook.com [40.107.243.77])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7E2EE6EC62
 for <amd-gfx@lists.freedesktop.org>; Wed, 12 May 2021 17:31:26 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eE3c1c4PmOdohqI1FYQHY2MPEaSUKBIYQ2dGos9LQmVoY+OyH4rvhWKBt3SNSf0RnVDRu5zBUpIi0jhO3WcA+qIZyDPEYXCumhTshMXm98ifwM2J2BTgRxTtfSWBMqj18hiua0/irwyZg6/FM6qkY85tBIE1Gf6ngXwsXEbF6+CwnsOccR7OqVW9T62VWhsMMy8FvPaydZkukmigOXqT20Z76FV9p5ymD17bj6s4x/rlMb3mKJtlPb3ZSbIohZLTJOtC2ZtrOhSob2cdxWktcy0LbEaJ+jek/qbhLz5AOFm9fdeC8RTTAmVNfPVg4Qlgigaqn4s+t25zUrNmvTRE/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=M6hMM8VgRwhfr0SBjWuHDzbAFPm70hkHaQKGnPGFolU=;
 b=Nw19xJgP+j1ytnVLR8ll89zSEib1J6OfdxdchSwplmkPZlgzigRW0Z7qbNboSCT6ilu/1mYLkHPjN5eaDotCvXecX14i0xCYjszoHdL+RYb2p3M23lJGGeV0kdfyswZgWLQlHbbJgRo0aT7abSBJVgsZeOX4yhzSVtK09eG3mX7V8AlGms6GRY/cxKxVG4jbcIqshAtle7RzH9GWfpNMD3Bak9YrM1Ba6Z5+MO8lf/kaIuD16B7zeOVnakfaFJ1Wvg10Twstx1nSgOqU6FVifUFjuHiAhFgay7LEzfu5yqHJN6XRCo+k2fVG9oO0TZedZLHMVj0EtLPTc0Jfk6xx1A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=M6hMM8VgRwhfr0SBjWuHDzbAFPm70hkHaQKGnPGFolU=;
 b=4PWqi0ZLVioRreNYRq7I5iBbEa22/2R3DJPgUbCaDt3Bs2SnIDDvRQAWXOu7SuPmMs90Hj3mGjMllk8BxoohesB+tL75VpiRib0HADTgxbWSh6IZimeNX7Fwr4NNIyhNbwTm0Y9lAydhM+Dblk/gvf//o6Nl1nFWemCsjwCeWuw=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from MN2PR12MB4488.namprd12.prod.outlook.com (2603:10b6:208:24e::19)
 by BL0PR12MB2340.namprd12.prod.outlook.com (2603:10b6:207:4d::30)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4129.25; Wed, 12 May
 2021 17:31:23 +0000
Received: from MN2PR12MB4488.namprd12.prod.outlook.com
 ([fe80::3d98:cefb:476c:c36e]) by MN2PR12MB4488.namprd12.prod.outlook.com
 ([fe80::3d98:cefb:476c:c36e%8]) with mapi id 15.20.4129.026; Wed, 12 May 2021
 17:31:23 +0000
From: Alex Deucher <alexander.deucher@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 15/49] drm/amd/amdgpu: add virtual display support for
 beige_goby
Date: Wed, 12 May 2021 13:30:20 -0400
Message-Id: <20210512173053.2347842-16-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210512173053.2347842-1-alexander.deucher@amd.com>
References: <20210512173053.2347842-1-alexander.deucher@amd.com>
X-Originating-IP: [192.161.79.245]
X-ClientProxiedBy: BL1PR13CA0159.namprd13.prod.outlook.com
 (2603:10b6:208:2bd::14) To MN2PR12MB4488.namprd12.prod.outlook.com
 (2603:10b6:208:24e::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost.localdomain (192.161.79.245) by
 BL1PR13CA0159.namprd13.prod.outlook.com (2603:10b6:208:2bd::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4150.11 via Frontend
 Transport; Wed, 12 May 2021 17:31:22 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c3cc268f-769a-4608-fc32-08d9156bc31a
X-MS-TrafficTypeDiagnostic: BL0PR12MB2340:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BL0PR12MB2340FE14F8F126B8E252C657F7529@BL0PR12MB2340.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:949;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 3I0yJ7M0mhrqkRTKHEB2q+MVYfgfwlwRmmkcNT9nJjnJNiKkzKmJa09cnpptJBOZt3qBJWEFcNI0T0K3tSoIZN1ueWUr+epLdc0rJRlIZxoZnCFIa0XT/6oX1DCfaV3Q/9ZF4NTi8BkOwWggIFhOB4jBVwk9JForikZQQzH4LaBAaYKGRQELk5MdZKBq0f202pdbNgW/1UbkTn47U3aFdapDeRsTC63YhEYg36ZrIWjUQ1VNRACiJNYragEKoV0cAm4zl8Oeeyh1/KHTjgnzD9gStStTgMQB+Ds9Bg1BRpzYQ/g7eRkl+HdALUWSMcpiW3VUjosLhNNrvFZ9cNdvMZkNF+3e1EIluvvTw08XSsFR1a2XjBIf3HgKRDiIOdzC4Yp8xO8+lMFmU9fHs4s84Fw8cif+VJLgNMbOeQYpll3LQK7NYOzsMzh8NChH5GNC0GeoTnSWCv+w2lssCixXznL2MYURQjmJ5T9DOVRWSy+TauP4dqoMRT1w8l0VD71bU9IMkR3Owo4jzlQ+PRNVdh0kxt+YPC3f9nQ87h6OoYmFcXQrPYlilVQDdMonUl6IA+Uvz95nX0OBHpI8hp47nzgb577cfTzkr7Jr5B7H4T9OrqZ+69dBHOLIvK9wwGDJzthwU31ecYPEU81qDIvWuyNokb5UJuaFEPu7NZTPb5SOkb/h2LFKsHoeLY1oADY8
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB4488.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(346002)(39850400004)(366004)(396003)(136003)(376002)(6506007)(26005)(38350700002)(66476007)(38100700002)(86362001)(4326008)(316002)(478600001)(2906002)(8676002)(52116002)(66946007)(66556008)(36756003)(5660300002)(54906003)(6916009)(2616005)(4744005)(956004)(6486002)(8936002)(16526019)(1076003)(83380400001)(6512007)(186003)(69590400013);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?WYwTkiZZDKBKrfrAOXWbeSx7AN5+LK9QRcsmFDnrlpKbWO1faUp4ZQPLp7uB?=
 =?us-ascii?Q?lORNvLNCTf2YPWY1Mj/7ujZKIOAleOJ5v1v91Ra0q8fO0ZeHkgJooX83DOw5?=
 =?us-ascii?Q?Z8JF0gE5669p+/hKJVN/3gidrHlGRXSBGSZR2LFMNVI5WuA/UQUFQjd/yD+n?=
 =?us-ascii?Q?ZIaCH1x1lBpCv7UA70BXrBcLdNtuoNcaPUZpg+z4FRVyz94/EsoWZRJUFPoh?=
 =?us-ascii?Q?4f9lZt2VfJVTdRQQ+FPwIbpRYc45fvrFP5AY/DTTKMCTrRG2Ybu3/fEgLL93?=
 =?us-ascii?Q?U+HMQ8HfzNcp5R89J1QcTXMfYds8SEw/rdCCpCLlifgqAoYDkkx5SlME+ovZ?=
 =?us-ascii?Q?9XZY5jNoJkfEWVgkKNtgHv4MB2v8WxNHoEnTMZKsgmJt5ei+8v8M9CsyvFP7?=
 =?us-ascii?Q?+OGhC02Ib/+bUtxcORka7VL9yOoa364wn7Jsu2WnaYigYiGzsJg0rDgPsaRT?=
 =?us-ascii?Q?PGgsHMTzo3qXhiFGuvpSki+iuKNiR7ACJiLDLYUbzkkLU6d3KqCjpxwP7bq7?=
 =?us-ascii?Q?b190FX1KFZlppdpbI1y4GakUUeOfBkUM2IJ8HPn6RRiIRfncD+6EffD2F4nz?=
 =?us-ascii?Q?DLOKtXgtTrx7zD/ROY4ShYLRvd638y1gJHY/A3QFdvSGcmOSNffBxuSnSBSX?=
 =?us-ascii?Q?RYbAdEZZSbNgfT9kvoStXmp3z1doXEl9uENuNJYjzzpKsneA9gM43b+UlMu3?=
 =?us-ascii?Q?5Bwll5D6JH6IyNNpqBME5eOdi0+fCgiTo15yAl3+vZrGumVYwgKtHD52mYGa?=
 =?us-ascii?Q?KPWdqLX7InRI4Hk7HPTgKkSltvIgOXnV8DBOcqpvlL2686h75NOGXd8wpo3H?=
 =?us-ascii?Q?0m9vC+3d9MvkgPecvlnPsEi1o69EMZMavSyflxXSFRoHf0vUviwP6V/8aWqF?=
 =?us-ascii?Q?/5NUjjjNnRHiU+LZSQATYj1EXM6vdo8bnpAWhlWxbBlziSnIeQNpQ+5gudzn?=
 =?us-ascii?Q?VvUR5oangzmJhaRzd7vSVnhF8lHYBWaEFmzLxOUCrO49UBuO5NSofBQhguXU?=
 =?us-ascii?Q?M+VIj9VpkFC4Nn9IgjxR1zNrId8YL/IpXrGn9ZrzhvdWFfxiz/X2jkl1Xupv?=
 =?us-ascii?Q?ycMHAj+2jyZgimoBcInvjfE7L1X7H8S2mnfKPKQdRDB9nDu28upzMomlsFcz?=
 =?us-ascii?Q?BG/PyaNwR0zOwNmY+b/2Kn1h8QXsQ5qRCEKZyLnKogi1CCR43FIcTIG+hsYs?=
 =?us-ascii?Q?F932bT9LpObgBYpPqwjtKhoPwnhrjV0Xg28AoCxF7/HhZBCJwwlIUPmIon2L?=
 =?us-ascii?Q?tW9QOkrYy/1WpRK0bc/zBYAMjfxCd3EIaktkTahXJN1TwYa5fqyMh6IvPSnF?=
 =?us-ascii?Q?lFtUQBefTcC1apRQ6+e1RmRU?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c3cc268f-769a-4608-fc32-08d9156bc31a
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB4488.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 May 2021 17:31:23.0298 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZbBgSzz9zZe5GCKu17XZR2Obkix3M+cd4jOgT0wkgoE/T5P5Z9yD0ffqwgVgZ32NzjlWoVfFs/x6dNkT7mjerw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR12MB2340
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
Cc: Alex Deucher <alexander.deucher@amd.com>, Tao Zhou <tao.zhou1@amd.com>,
 Chengming Gui <Jack.Gui@amd.com>, Hawking Zhang <Hawking.Zhang@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Chengming Gui <Jack.Gui@amd.com>

Add virtual ip block for beige_goby

Signed-off-by: Chengming Gui <Jack.Gui@amd.com>
Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>
Reviewed-by: Tao Zhou <tao.zhou1@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/nv.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/nv.c b/drivers/gpu/drm/amd/amdgpu/nv.c
index 2966775d4663..3fd81da00ab7 100644
--- a/drivers/gpu/drm/amd/amdgpu/nv.c
+++ b/drivers/gpu/drm/amd/amdgpu/nv.c
@@ -851,6 +851,8 @@ int nv_set_ip_blocks(struct amdgpu_device *adev)
 		amdgpu_device_ip_block_add(adev, &navi10_ih_ip_block);
 		amdgpu_device_ip_block_add(adev, &gfx_v10_0_ip_block);
 		amdgpu_device_ip_block_add(adev, &sdma_v5_2_ip_block);
+		if (adev->enable_virtual_display || amdgpu_sriov_vf(adev))
+			amdgpu_device_ip_block_add(adev, &dce_virtual_ip_block);
 		break;
 	default:
 		return -EINVAL;
-- 
2.31.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
