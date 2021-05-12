Return-Path: <SRS0=awHg=KH=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69ABEC433B4
	for <amd-gfx@archiver.kernel.org>; Wed, 12 May 2021 17:31:30 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0205961417
	for <amd-gfx@archiver.kernel.org>; Wed, 12 May 2021 17:31:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0205961417
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 23B196EC6B;
	Wed, 12 May 2021 17:31:29 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2077.outbound.protection.outlook.com [40.107.243.77])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4D7406EC61
 for <amd-gfx@lists.freedesktop.org>; Wed, 12 May 2021 17:31:26 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JteTDegy2Zp5dSubvrerjzswC7OfaY400PMyIKKaa20sqjeEJF37R2aFdO4mSQTlHaFThPTIy3MIZJIdgEsYb4gNYn+HiZzR7nJqWze1ADfWnSR0FXpxoo1ASwh1+d+An9R7vUD0Trrsqd7pXh/A1AA9XRsrdrpU3q5apUj9k+GmDjnfr1cpZKgBWTExeoycklU5o1Pun3z7P23LPGgI8WblnsoQVL2Vy6myU4+JGBiO9tieJmz31Ju7O5xdBgIW8TC/YE5WJFdm/n4JWoCQt9eOSwqeRaHFqju7jtBlPwt8HaCe8i3Mvv6LGmgoKBb4l5v4q72pskMSJ/YBGLHbwg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=j8tmQ8GKH2ioVmyyvCuoDfsnbidYO/QIFZQVm7i7h4E=;
 b=bACaRoWhqT7mErHBMwkXkE8+Wa1MWpi3afFl4+Uyg5cFqfu1HXN01ofdicZvV7o1M1k2go86xX909Y0P3c0OAPwCxJxPooLSyHNqEZKGc/vkP0qZTcxL7dyhTjRiL4Egi7W5JxchcHV97gjw4vK4aiDdMfyVyt3cPQEk/UPZe9CU6e6f4iWgaCnD/G6AhH53Cek+LRG/Uzjrt/6TC8DOCZUGUfMkA2O7KP/rDlTVdfBN/kBE6t2n4vKFIbvcSivI/CFYH7ovNg3rk4EvuEh3vDaVCtbpJogN+lZIjVPF2c9CvpU3s82QU2kp3bPtE6aF6UcCHilvmNeYOqSkmj1qtw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=j8tmQ8GKH2ioVmyyvCuoDfsnbidYO/QIFZQVm7i7h4E=;
 b=iSYx7r7+m38LB9sLVV76zUC1MoGQrhRwGbn81/43ZE6dHbLIm0M8U+x15pcXJmwNVa68zCkDqfIK6hBsfVfnAX9Hef56OnQ0T2JuVv0F+Ixv+3R5fva7RRj4cTjsWyVOWvDSujo1YuaBuK7EhjZtGBKxTie4vWppOFgH3le1G+g=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from MN2PR12MB4488.namprd12.prod.outlook.com (2603:10b6:208:24e::19)
 by BL0PR12MB2340.namprd12.prod.outlook.com (2603:10b6:207:4d::30)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4129.25; Wed, 12 May
 2021 17:31:24 +0000
Received: from MN2PR12MB4488.namprd12.prod.outlook.com
 ([fe80::3d98:cefb:476c:c36e]) by MN2PR12MB4488.namprd12.prod.outlook.com
 ([fe80::3d98:cefb:476c:c36e%8]) with mapi id 15.20.4129.026; Wed, 12 May 2021
 17:31:24 +0000
From: Alex Deucher <alexander.deucher@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 16/49] drm/amd/amdgpu: support cp_fw_write_wait for beige_goby
Date: Wed, 12 May 2021 13:30:21 -0400
Message-Id: <20210512173053.2347842-17-alexander.deucher@amd.com>
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
 Transport; Wed, 12 May 2021 17:31:23 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a73d184b-efbb-4f9e-093a-08d9156bc372
X-MS-TrafficTypeDiagnostic: BL0PR12MB2340:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BL0PR12MB23407D4D3C384E6F06C565F8F7529@BL0PR12MB2340.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:428;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: v3UEOm2vWwb+kET8lAdrZGbc6N/2/XP5kQTwVbUlIyUJQwQhGc3Gz5xVS96dsLAotMkRkk3106HvXPBcNd139eKL/y6HeErd+7xIGTdna2zvxcicAGpBGaUfkmdbuamaSPJq+WOsUeOeZnKKEHMK6gJWI6gfxKmMbbGlMTorQJo6esFi2pBm4q47Bu1HyqtCmBkvJoNLoYKMUFD8jbdXtn1V/f0IQBX10EaAVI/CcPsXwAtT5V8+2ZQCmrQPa5carb1WD5kbWGMD9yEIBbeJV3P6pC4PvIY076diYGgXHyJHWGhH9f9EOnmzCiFc0DnJka+OK8MMC5JMmY1X2KVITsttNzqt1AdUimEboJPeov0CUGbNwHKj5j8IM4nG2R55Kzw4GE6nIuan6gOE0P/+gqVvWoweqJP6CG2jauH4mi62oa7t3VpguGaf7xdSu6LapG3F5RG7VeY6s0jIqmgiejdbCZBGp28Lp+PVVuIkWHZ1IFUk4334VW2H5xTfS2QCs3XJ1hL0foQ5UnMcXSrvUSC0dE7vqyKmU/8SXmEGX8fXrxTGt7tzNEEQBg9KokoYBra5HKvwuS2eN2sNWLVwZGznMrrio3pneslDx/hk982PJDyz66Q0wGwOLdO0QC2/HqtPsTIiMwNFeVdKYbIURsu664eL7PS0lOANOLL8vcS8oCfn292kiAQRr3MPGadL
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB4488.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(346002)(39850400004)(366004)(396003)(136003)(376002)(6506007)(26005)(38350700002)(66476007)(38100700002)(86362001)(4326008)(316002)(478600001)(2906002)(8676002)(52116002)(66946007)(66556008)(36756003)(5660300002)(54906003)(6916009)(2616005)(4744005)(956004)(6486002)(8936002)(16526019)(1076003)(6512007)(186003)(69590400013);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?BEUrkZX6f7Y4fQYXCe2aRDXNNvNMqe7q/Z8l9FXCxYDpudReE+Dx7CUbRYPz?=
 =?us-ascii?Q?ebgTGOsX576DRaocv+6Qa/jmb0NLj7lkDzWO69KyBrymppwgLpSn1m7Q6Chw?=
 =?us-ascii?Q?N2ZzmcNYnLc5+WkvzTqnsHo3kcjehLqroVtHcotNdy5nDEFu+Y7G21NY1pEJ?=
 =?us-ascii?Q?3UjRnH4ZqsYrKLf+fNGNxv9lGmpxvP7nJFdzjO8K+VbYhVF9VEX5unmwi5n1?=
 =?us-ascii?Q?gC1IjmnFECAA/lEKH7W3O1Mc++aWbuqLgxpcFC3TUym+EKaNMBoOG1WEmvRn?=
 =?us-ascii?Q?B3RGEbV7/uDvaP+djdW94kKYkHLvo+YCh4rHiHbXBONh7EAq5vCuIRobbgbX?=
 =?us-ascii?Q?pzbmSKxI4907F4FpvIZAEeX4v29z85p+H+xZUjTPyp5kn/dCRqSKl1kYaewd?=
 =?us-ascii?Q?ZiruyWyCfpxxkfcNZFDE9NYNtipkpirfywBG4iID3ESC3jX8ZBZ3iYA7UF9F?=
 =?us-ascii?Q?QuWCAl3fViFUY2gRyG4LEC7+bOhXxvx892BAek76vDx3noSsI9Auv9ZQ1wS6?=
 =?us-ascii?Q?5uJqaO2RwSvdtIVeKBaqFjKLMZKmv3gjGx3SNw092IRl4sQyqiGPOguQksYd?=
 =?us-ascii?Q?z/yuR3gV6WwdJSNcxRkaTaqlefNiWTd7rz690ImzHsOMUFHLK//dSjejNVMC?=
 =?us-ascii?Q?C5ZTeRjv8yy48oy4487NywY3kDX1KcYd9p0beZQhL5N717I0jfmFRCt0t0o1?=
 =?us-ascii?Q?PXYlcTuQoH+TJavCapaXT24brt16VLO8uoO9qiZHcmqKQ1ny7whk3Q6yPIOT?=
 =?us-ascii?Q?R8IZSTT97V0X6wTSbcmkB6ei+Dg0RwNUGlGJvIuOTjXHI5p6TnAgYAZO1SW/?=
 =?us-ascii?Q?F1yEjiXFmXkcV1Q89vB374rGR8GANvbp4nI+8i8DNCgxB+xk2gmyZlOyKyxx?=
 =?us-ascii?Q?mf3oVZcSalXosfJIQi9nCaZZ3gw2UFcy7nmIwYwRflNI9w6JxXfZQpAFHcsT?=
 =?us-ascii?Q?6SmKFpVawpxljBjc7o+YFOQCels8sPcsToC6I53lIEtwDBw0XEMGmVj8XBkh?=
 =?us-ascii?Q?mnju1Y3soQZgRGbn25CG4HXT36Gbwms04bQr6QMvMhvegswYLqjYFXyzFVE2?=
 =?us-ascii?Q?bCylWdGcgAb7Amj3YgA//S0a6MrcBXytKPqAKtXnBBgk9H9p8T8QZptiY+ko?=
 =?us-ascii?Q?3x2d9jq+eO7alRNqsCW8VzcW1WPjxHFqgnePyv1IeUGqkT0p4aA8GbcP9hfJ?=
 =?us-ascii?Q?RZJPMVYKVwgRyROHlTLkeB0RpgLePivspvFk/+lmZ3mXwzlQW7SQ0pfE1W4q?=
 =?us-ascii?Q?u1UZ81uFXO/pYhQ+EJgE8tYNG8fTNurpnqyvewF+U5eLs8GOZoW9ciU9vqA6?=
 =?us-ascii?Q?ewTvS625l2ihx6ISg8zzQAoN?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a73d184b-efbb-4f9e-093a-08d9156bc372
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB4488.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 May 2021 17:31:23.6162 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WvWEDGXfLpewndcGtgkYY138H8AlRB73h4PkmOTJIU+GBii6tKNrAcCn/zgc5W9EfjBXzJ8mZ5yZvtbNFsvzNg==
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

Same as dimgrey_cavefish to support WAIT_REG_MEM packet.

Signed-off-by: Chengming Gui <Jack.Gui@amd.com>
Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>
Reviewed-by: Tao Zhou <tao.zhou1@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
index 771d8af4dd04..b7cc5a4247ad 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
@@ -3820,6 +3820,7 @@ static void gfx_v10_0_check_fw_write_wait(struct amdgpu_device *adev)
 	case CHIP_NAVY_FLOUNDER:
 	case CHIP_VANGOGH:
 	case CHIP_DIMGREY_CAVEFISH:
+	case CHIP_BEIGE_GOBY:
 		adev->gfx.cp_fw_write_wait = true;
 		break;
 	default:
-- 
2.31.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
