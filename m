Return-Path: <SRS0=VH8F=JF=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93A0AC433ED
	for <amd-gfx@archiver.kernel.org>; Thu,  8 Apr 2021 03:32:59 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3C79961182
	for <amd-gfx@archiver.kernel.org>; Thu,  8 Apr 2021 03:32:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3C79961182
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 834246E9E7;
	Thu,  8 Apr 2021 03:32:58 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2078.outbound.protection.outlook.com [40.107.220.78])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 014AD6E9E7
 for <amd-gfx@lists.freedesktop.org>; Thu,  8 Apr 2021 03:32:57 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=b1sei02sls65hvOSKJjI4Agtrq6joNOunwRc5SDLCs0rWDNl7uhSq4ji03L++MN6pgAuA9hRKgf+HEcdfxm603OSrR0Hf7b914Qa2jTHYavuKkavEtpEjwIRfcC2QAmYi63xP1zlwEkDETqUW7n2jis/dR8LioeuZdELta9ZvTe+5H7dUj2zX/bG8/QQCW3oE6zE+YVnjWNyzhZN/iZhGYBE4Ug3nWzOm4WYb7jcNUQpC/E2UC+FIKqA68i1xjuxperUrm0tjy0Hbxs8Fw9p0xhqSyI/I20Uff+TERUI8SUbRGND+LflRQQOUwdOfO6VvFn2WDh34IUfiKqkHWuyNA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RZypieheDN1FGk/mmlKRkfHfXoTu+hT/5p88+ztlv+g=;
 b=OWTNTqL15WDDaDX7M+0rCNVesVOLixRRi5MiqKcNY/txDjMtCP0qJJQop9b0TCAaHu6WGGRen3JSsMNmCcUWa9bcvNwT5Hjkq54o12Y10M1Hp+m+MeFCTMMAmJX+wHrUAcSUIJAPwEBJmJmPzrlyyf9ojk8kaJFIMHEZxUgjNRETXZrdSeMFw9eoVyI82tAxBHuQrBjcS1PZL0UxXy/xkeG/JzebgN+dWI+4WyD3OfL6psUC+8dP/Hm100umso6BpKH3mLd35veP3+O329sApomV8kLtLF0AkpP6Tcb4qLgJzI+x8BZD0xy1mE33RFR1gyo00dMl0aEynjK2pEAZQA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RZypieheDN1FGk/mmlKRkfHfXoTu+hT/5p88+ztlv+g=;
 b=yA5IKVz3ZKM2MmQJ04Aexw7Qmu5TmlFpGIWHLz+/usO2CzduLrTshI8RqNx6r+54cBHdTQ82ncsdmZ+131B6jqKH1U1GvHsH8qApb5kSMesAWrPz34DVyeTo537qEl9Y/ZPg7GTQoleG6CHJo6+WBZmG200L3jmjRO2smPMehLI=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from BN6PR12MB1140.namprd12.prod.outlook.com (2603:10b6:404:19::14)
 by BN6PR12MB1203.namprd12.prod.outlook.com (2603:10b6:404:19::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3999.32; Thu, 8 Apr
 2021 03:32:56 +0000
Received: from BN6PR12MB1140.namprd12.prod.outlook.com
 ([fe80::ed12:8b0c:4402:1a3]) by BN6PR12MB1140.namprd12.prod.outlook.com
 ([fe80::ed12:8b0c:4402:1a3%4]) with mapi id 15.20.4020.016; Thu, 8 Apr 2021
 03:32:56 +0000
From: charles sun <charles.sun@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [0001-increase-time-out-2s-send-msg-to-smu.patch] drm/amd/pm:
 increase time out value when sending msg to SMU
Date: Thu,  8 Apr 2021 11:32:34 +0800
Message-Id: <20210408033234.960661-1-charles.sun@amd.com>
X-Mailer: git-send-email 2.25.1
X-Originating-IP: [180.167.199.189]
X-ClientProxiedBy: HK0PR01CA0055.apcprd01.prod.exchangelabs.com
 (2603:1096:203:a6::19) To BN6PR12MB1140.namprd12.prod.outlook.com
 (2603:10b6:404:19::14)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from cs-Flute.amd.com (180.167.199.189) by
 HK0PR01CA0055.apcprd01.prod.exchangelabs.com (2603:1096:203:a6::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4020.16 via Frontend
 Transport; Thu, 8 Apr 2021 03:32:53 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a79d25c8-af3d-4472-0c31-08d8fa3effe0
X-MS-TrafficTypeDiagnostic: BN6PR12MB1203:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BN6PR12MB1203FBB7F0D5A4FA8B42A1BDF9749@BN6PR12MB1203.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2399;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: G+LUwD147qiLfdWRJ5MYo60qCThV/eli/X/Bem8L4jj/giXR3yLydmjGuYvu1aKggkjplhTSXpTxrzG7NgOfUAitvzX9Z9OxW2028e/60NHzXwS2CAI5X1urzG/yjEoO5oSOBMSo323wzGSCUJr28xisytpal7J8JHcpqbLCL1vufecjccnO01l+25ypquGCeLCSIY7/bfdJKZxEAllvdXOES9kOkK01QRwGEK0WnMQQzsAlijLvZd967RgslYQNjKpktcuRIXoQdzDWe2Kh+pvwyuyUlTZjjJ0bP+Y1x/2MYjvonN1bIj66Bm/fRTRivG6e33UGsg8fuvADv2WAUXGwlmuWyHCNQkBsw6h+6sSWafm77yaypK9O+uZk/cFkm94SaQr8N9Mq1oX27fP3qzdk7M93o2W5qxQbJYt3LvAf+q1kMDV4aveyv5YJkDyXCumndKSA2+LMCbmTSWVqLxBl79SSU6ICy50fObVum81u7DA360eIWxAbFNOoTgbT10OkgbmbV6dYcHp+CyKufXFxIVjvYm0Dv522lFakt/Wpw4pCIzOQ3ysr9AKXgzliER6FZjccKrtUE8VWyQ6duduweHz6Fw/kpz+DurOb75reAESKqGEvTeepmsr3qkdJ57y7A8nNTAuMStksWMk4CMNG/mPHF1mzqxCtYSq3v4c2zWWzdrzF5M4vKrpEFk7X
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN6PR12MB1140.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(39860400002)(366004)(136003)(376002)(346002)(396003)(7696005)(4744005)(4326008)(38350700001)(2906002)(1076003)(8936002)(16526019)(36756003)(956004)(66556008)(2616005)(52116002)(186003)(26005)(66946007)(478600001)(66476007)(38100700001)(83380400001)(8676002)(86362001)(6666004)(6486002)(54906003)(316002)(6916009)(5660300002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?RdZDwycQtUhWEcoQW1AZB54rXzzHEPttCYFp9QVVjio8RrEphjtGbZdWkYVo?=
 =?us-ascii?Q?QGtfJZ/W1yzvLItYX1oc9mo1B2e2Bd2vB/1Jl1z4r4jUSvpF1OH5/ljcEYCo?=
 =?us-ascii?Q?vK4/T+rRbL7DPUrJRQDK+7DHRTYMubLY/xb0L2VYysOtr2RX+qKZGn0Pa1Xt?=
 =?us-ascii?Q?7QMZPPgkx2dhMCbX7W76kAVLrWlRsPUoG7f4KdTw0Qx4W6RbATySM4WRldSD?=
 =?us-ascii?Q?4RomxUMjU7WxV55tsqzuSZ4IOxcUr2/qNhOF3dDTFzDy3HtmQiFgiidT8lYP?=
 =?us-ascii?Q?30ZKjSBNXwy71rI3vf6C3GcGxYOyP+ep7/KAZG6qYG61V+S7TdSPKEFu2uij?=
 =?us-ascii?Q?PQY2g1MDn+Rkrj4T1ZWEsE5BzReJTsJetVtVZvhmL6IB2ExgklKSvZX9tozK?=
 =?us-ascii?Q?/2kryqu+uTmTSPKmvCi3NZcLt23SImBFb3OwHUEBNd0dIVNU6v9t+Aaxz1Bj?=
 =?us-ascii?Q?8At06YOzZxO1VAMfkR/gkiXejzUENqrQkVdPf3XjV9U5JXxZw0ubxzHj4ur3?=
 =?us-ascii?Q?oqF+cH37n1/qlGBH+blnIVP1Iha81b3nyO1JWGPFB0Obi7hGygsIhLSfhY7O?=
 =?us-ascii?Q?l2UaFoF2sx9Bi1cYaaXY63ghCVrK6epWyKyj4BdSLzVP+xumIBdUg0JVqleo?=
 =?us-ascii?Q?yInwn7QCJFlEcRIqdXEamxahAiFZq5sBDo9PZE4s7HpeYIHWwqtHpK3RLaW/?=
 =?us-ascii?Q?EkXXKQ/Veg48LqUq3twRSGYfIZ1aG25hhzN2+pU+n3ZPCNLj8taPudNSI33y?=
 =?us-ascii?Q?KKINiJD6uAvIbvEQwBOJa8C1bPZ1FpQ54YhhUitpms0OQoT8eJpOik/aB+eQ?=
 =?us-ascii?Q?PKGdksmSUxlOqR1RA3ZPfOL35AZsJNZUNEmAD5D0QH372KYR6aK3PuhFxjso?=
 =?us-ascii?Q?j4h2rYkCUtDzRXU2AQzQwQkS24Bp8m1MER5/lcfzTDOG2YRTkYTZTE3leXIp?=
 =?us-ascii?Q?dEGh8NDdxw3m6KIRVPWjS9VnmySO9MWeTicBTJjrIkwTItcl/+voaIFqD6rE?=
 =?us-ascii?Q?jwXVZF+tyLmvPy74QvytCNkOqnIlxqViv+6mjvOcf7XmE84lGo4bpGOWNuPu?=
 =?us-ascii?Q?jylg2Fx7P8/bPmbTLtbDI6/ZsvwPL9S5deGd+ZHOI0U8Dzk+RlASSdcU0U3+?=
 =?us-ascii?Q?cbrhvWcFO68YJxv6Oie9VMQtTn1MBIAaI4aaWNBFBqXra744uAzU0vnZNIEp?=
 =?us-ascii?Q?RR1CB2Nx0qYyvwgzsOqRi4Z+E6j494jI/16XiY0cqEsMJrOr0GImqfUKDe4n?=
 =?us-ascii?Q?aP3GjUBotvk3qOcD0O2Nl45FvI15XMjjEuCyGFLNmOCpfvYQOLPRBzjM6kB3?=
 =?us-ascii?Q?4BDo/58AxuZ/0CHWhOFbLQWVZq9uanMBxhFLBTER4i7rDw=3D=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a79d25c8-af3d-4472-0c31-08d8fa3effe0
X-MS-Exchange-CrossTenant-AuthSource: BN6PR12MB1140.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Apr 2021 03:32:56.4613 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ogy2/7MJeXLIrQJGP/uE6CDsHl4yM7zfasM0+Pgo5nEV7ddeSNgp/cTbLQPp2N0i
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR12MB1203
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
Cc: Alex Deucher <alexander.deucher@amd.com>, Jinzhou.Su@amd.com,
 Zhan.Liu@amd.com, charles sun <charles.sun@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

when do S3 stress, low rate that PowerUpVcn message will get response
more than 1s, so here increase the timeout to 2s

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c b/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c
index b725f263092b..dc7d2e71aa6f 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c
@@ -79,7 +79,7 @@ static void smu_cmn_read_arg(struct smu_context *smu,
 int smu_cmn_wait_for_response(struct smu_context *smu)
 {
 	struct amdgpu_device *adev = smu->adev;
-	uint32_t cur_value, i, timeout = adev->usec_timeout * 10;
+	uint32_t cur_value, i, timeout = adev->usec_timeout * 20;
 
 	for (i = 0; i < timeout; i++) {
 		cur_value = RREG32_SOC15(MP1, 0, mmMP1_SMN_C2PMSG_90);
-- 
2.25.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
