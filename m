Return-Path: <SRS0=/TO6=LI=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6EAE0C48BE6
	for <amd-gfx@archiver.kernel.org>; Mon, 14 Jun 2021 17:47:49 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 42B4E611EE
	for <amd-gfx@archiver.kernel.org>; Mon, 14 Jun 2021 17:47:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 42B4E611EE
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D93436E14C;
	Mon, 14 Jun 2021 17:47:48 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2048.outbound.protection.outlook.com [40.107.220.48])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E88C86E141
 for <amd-gfx@lists.freedesktop.org>; Mon, 14 Jun 2021 17:47:47 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jjWfgiTeCG9Rfjf0lHiECYiWjVoVPxEVvEwuVFFxS0rauS6g0jlXpTtrPKxwGe5JByoUMPmqv5+HJ7y9LtuGIehN7rsitXWd0ZmYUEGGhs7ir6HSRDC4pz95RYJqMO32yRUwCyj+sjzqKyiZNBsC03UTzeMiAiWu20gfhHp34jxELg/tRWs8rxbfIY0Zc+dtfBL/9DiWiyTJ1CG8d11BomRJks/KybEqr+BB/3WT+9WiunPma1BblS0wByj61Z1rAAQv5V4KWaltyXEppz/457D/1+RB/04btLCWLqUuBVFK7G3ucnbkqfd9XtDcI0QEmj/Nwm47yr2NfhelA4v0Vw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=keP1u3RZpBWhcz9QqHLns5tjPm5bXuaB1EIWVxFJMoc=;
 b=KweFg8O5GOCt2aYZWtpMF0TdBs9Z5+/MKG8q+OABWIW86WIaue2qvmfCvwraUHSIso0NswhhPSjwBcahYWiH6M1CuvBc4DaO37AsmeBmGn79tpZy/pdZ03zgPqVLsBtCGgGe1MLf2LOC4jhOQ6TXHiR+s2KwvoeETFJZ8gq8N1c3lBBXBaRfz0WO4voNwSAglvZ2BH3esURi9UhSB5/lz/CgTLMiq6kDEJ/hHTDZngKBcZUsN655GtMgifGuGSDK7J1K3KXPgASEFMEzIpa5pTUUN9ONJyys6F7+4VNtBFjoaRKX0CuJ1TZ5RbD6mGSIrh5EPzkBQDYiIirgsqrUQg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=keP1u3RZpBWhcz9QqHLns5tjPm5bXuaB1EIWVxFJMoc=;
 b=lz+mJqI9ctr0jsZeMSwAFXrdOAC0yDl8N3dv1AqPbBQTJX8ReYnsvmvIu+QWaqDS6reMlTnj96abTXuQCzCDiM/umPoNfG42fw5u/fS3LBFLLZpZgnKIMv8SERCwnfWDL1VSLeCWhrZWoKCSEmgDVmTBZigI/WK+R6f/FMyRL2E=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB3962.namprd12.prod.outlook.com (2603:10b6:5:1ce::21)
 by DM6PR12MB3577.namprd12.prod.outlook.com (2603:10b6:5:3a::26) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4219.20; Mon, 14 Jun
 2021 17:47:46 +0000
Received: from DM6PR12MB3962.namprd12.prod.outlook.com
 ([fe80::142:82e3:7e9d:55a0]) by DM6PR12MB3962.namprd12.prod.outlook.com
 ([fe80::142:82e3:7e9d:55a0%6]) with mapi id 15.20.4219.025; Mon, 14 Jun 2021
 17:47:46 +0000
From: Luben Tuikov <luben.tuikov@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 33/40] drm/amdgpu: Fix amdgpu_ras_eeprom_init()
Date: Mon, 14 Jun 2021 13:46:25 -0400
Message-Id: <20210614174632.20818-34-luben.tuikov@amd.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210614174632.20818-1-luben.tuikov@amd.com>
References: <20210614174632.20818-1-luben.tuikov@amd.com>
X-Originating-IP: [108.162.138.69]
X-ClientProxiedBy: YTXPR0101CA0019.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b00::32) To DM6PR12MB3962.namprd12.prod.outlook.com
 (2603:10b6:5:1ce::21)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost.localdomain (108.162.138.69) by
 YTXPR0101CA0019.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b00::32) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4219.21 via Frontend Transport; Mon, 14 Jun 2021 17:47:15 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 9337e285-872c-4aa7-dda1-08d92f5c72a5
X-MS-TrafficTypeDiagnostic: DM6PR12MB3577:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR12MB3577BCCD5A87357FFAF0DB2C99319@DM6PR12MB3577.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5797;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: CXYPfPJNWRkZR3+2BvMG6jzmiYn9X45tIbalZhjfW52Y3VQhltJCfT/eU7hCAc8X+GL0eXheElPc+8d4FiwymUIs7liox6XYgVVdPjTi6KMvNFV7m0R2WezajmIYPr5PvJqCVcGZOI1cAyRqLjZh/m+bGeF/FEAVzpkTPYKFABdidAzuOrNCfvr/9MHL77OmkGwDnffMv8cUDYDHGYSHiv+VDRffBk0D3wAthzO++ftOLzk2erb3CJMcX6TljPfnJnpC9hU/a4bA3AVbJ2fd7u9qpqN0kMIxHC/rXOpHRbge3xGMkx3PxJgxT2MPf9VQI1/4aR73NcoJCR6ENf+OKTyMcQz5h4jdp5Oa9TAiMrL6dfWRiMpYlm6hEFP/oQIAQzXG0AKqZez1FVsG7n7syGzDAqOMHryPBig8PIXPj8Q3Wy4pDSLCqLnbozypZUhhvbzvR8HOTAcMa9vpWDbltPmqKBP5TaaeoY4Ok0pAtv1w8QfkDzA5FwFR7qiZsp4FriKGrgrq5xh7g0IIlY6QE25dGjD0I+WsuIGni1C91I7enjQ8nL4XNwHsVCR0qK7FSLhtO/y+NTptFbdNPf3F5md0h3vFE6Xh0jB0XY6rtuGLfYZjFDi7z+ng5+SLnUIRA1COiRXZ3WCoNiTa48tECo2Yo1NPcfkRR/kgDqy/JnXtNgxqmdzgM03pVsns/Du0
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB3962.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(346002)(376002)(136003)(39860400002)(366004)(396003)(44832011)(6512007)(36756003)(6486002)(16526019)(186003)(86362001)(52116002)(38350700002)(38100700002)(8676002)(2906002)(5660300002)(8936002)(478600001)(316002)(54906003)(66476007)(6916009)(6666004)(66556008)(26005)(83380400001)(956004)(55236004)(1076003)(2616005)(6506007)(4326008)(66946007)(69590400013);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?3HzKhawgguE0c+3bO1P6cwemlqeztaaDvILTXztePQOis2X9M1OddaZbpJUl?=
 =?us-ascii?Q?frdI+xAn6Pt57a75Q3Ve7m4ImMe6ESe030cSV3YxaNRdEClMA5LmHnBL23qk?=
 =?us-ascii?Q?Hzzh3babfSXGRnYtzNpXDX4hxpLbZh4QQsaNoouiZ3eB9w4XA2+v/O0l2hR1?=
 =?us-ascii?Q?G6jDXOsYWGSy8DjjLyPBDaoWecP0h5RH6kTcjQUIG5eFUEx66KAjUXyaWaO9?=
 =?us-ascii?Q?PU4MUHqBdA4mjdA3R3iAdD9EaMZ6UkTQMaQm2R20ROUueISEQhWZgxo88QVF?=
 =?us-ascii?Q?2VCEdBZhU+KjkP2AvC88Hx6UTyY0qJO0jmuQ7ig6ZHp0ZbG7pGVc0iWcXEj7?=
 =?us-ascii?Q?LayCMAuVO+3pwh7vDwozniHbmVz8PkKwyy75Y7Jdb9n7w6Cz5u/VrwLYoTlz?=
 =?us-ascii?Q?W3lPpix93ZH3oOg7/k5dwdGtdGBi6T0C7CYjizwo9hAIM9oDZR1WZI0rfagl?=
 =?us-ascii?Q?OBrUQcOgE+7kBTR7oCqv3SpXApXlLaXf2hR0dg/BEc/6ERulSEY2KXQoW14F?=
 =?us-ascii?Q?gR/yeKFHM8QVDe4w742wz0AeMy0nvDtyzNXReRAttR5oWoIAMg74zh9s2gHi?=
 =?us-ascii?Q?TTcEiDQjN2e1/1gK5JglIExRFtdPYw+fOokxbheNWHTgN9iYg2WnG9pJ4lKv?=
 =?us-ascii?Q?ywkoOwZFuQS0v/wuNyGkct5vdacRq0JEd7qerbnqLXpcg+SIbTj+jKiu1n7g?=
 =?us-ascii?Q?fZfQoYRYjY16926EtS7y1xILbowM9u2lihxUbjdJ+eIB3NDuaCj/yW74e1qS?=
 =?us-ascii?Q?C0mHfj0b0Uk1mEAcBRmV2+2nAjpsO5ZmU1DwrwEEbAGPHAiO6BkdKmkgtmA8?=
 =?us-ascii?Q?6CkJia+LyT/CiR1OIvYSkeRiKHjHylbvzZ0ZdiuwRNutip+CZkylTosjaktc?=
 =?us-ascii?Q?pTkaDZKcUTVES58PfoJiijH55nMBhw07hnDJIzadg41dx1ehjPCu9WGBj7Tv?=
 =?us-ascii?Q?CCVaR+cs7xooi3PkosmyK0Lz5+jcOX60RYNNFon0S8O7agVuxGEA5H/T/gOc?=
 =?us-ascii?Q?UxCMQ8EYWFX8YlKRTwhretAYkR4qLjUhAbfNNV+8SEKtYt9b9HuAcc3pU/Za?=
 =?us-ascii?Q?KQvkbcO5bQcall9XQqqf03XETD7lB7c6jpPFPCebdWZ0Py5XPmQGszs0ofXY?=
 =?us-ascii?Q?WMPSRb2c75BhT/0069bvlVCxeieWVdA5XaVFKcq8tNxowquNgWogf4rXk9k7?=
 =?us-ascii?Q?kmAp1FuSuc87vHbi57LW35/faKFvJUHASAdbdyB4/hpX7PiyUZCEqmfbcW+3?=
 =?us-ascii?Q?NfybfuhkRXIk9mAm/g+pFpNzHJasriuymBykXUESBBylgajypI+yyPC0rvQc?=
 =?us-ascii?Q?79ywt8yYUSUo/gvrMGB/Z17q?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9337e285-872c-4aa7-dda1-08d92f5c72a5
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3962.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jun 2021 17:47:15.7994 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /t8sCitLNZ/UC/iBaEBTsxHe2qda+gbLMiZG5PNhRjamsjIrcxfEzN/o6EUIGNor
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3577
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
 Andrey Grodzovsky <andrey.grodzovsky@amd.com>,
 Luben Tuikov <luben.tuikov@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

No need to account for the 2 bytes of EEPROM
address--this is now well abstracted away by
the fixes the the lower layers.

Cc: Andrey Grodzovsky <andrey.grodzovsky@amd.com>
Cc: Alexander Deucher <Alexander.Deucher@amd.com>
Signed-off-by: Luben Tuikov <luben.tuikov@amd.com>
Acked-by: Alexander Deucher <Alexander.Deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c
index dc48c556398039..7d0f9e1e62dc4f 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c
@@ -306,7 +306,7 @@ int amdgpu_ras_eeprom_init(struct amdgpu_ras_eeprom_control *control,
 		return ret;
 	}
 
-	__decode_table_header_from_buff(hdr, &buff[2]);
+	__decode_table_header_from_buff(hdr, buff);
 
 	if (hdr->header == RAS_TABLE_HDR_VAL) {
 		control->num_recs = (hdr->tbl_size - RAS_TABLE_HEADER_SIZE) /
-- 
2.32.0

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
