Return-Path: <SRS0=3j8t=LP=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4469C4743C
	for <amd-gfx@archiver.kernel.org>; Mon, 21 Jun 2021 17:12:53 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B5B3860FF2
	for <amd-gfx@archiver.kernel.org>; Mon, 21 Jun 2021 17:12:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B5B3860FF2
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 761FB89FCE;
	Mon, 21 Jun 2021 17:12:53 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2040.outbound.protection.outlook.com [40.107.220.40])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CF34B6E235
 for <amd-gfx@lists.freedesktop.org>; Mon, 21 Jun 2021 17:12:47 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Kd09hRUDddTVeCnwXAgTcepY+NKLE6cJrPZMOcprESInaCaPL+/6LgBiiCKcDT2Lx1PrK3EPUR0iMItNq/h9M6Vm7h4GXjyjeJK62loy9VZs2l+JW5etqtKG4d+vwpvbrww+evzpzU2oeNJlY4TYrM8uSxLarFgJMyVsTzImQ48F/7j6X2h4GuFhMgD9LnWBxXVd36jlLSNhzb/S5mBOsh45PHzfRJqGcYuY58w2KGyHIxbx7kNOs/UED4x7XwEnZLIp7oaKmkheCH/lmoN9udjXsqurqj8NmTtSfOG3/BKYCs1uvijhJg+IrMWsmPizgLPtjxCaAm520Bpn0GKC1w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=O/xpDL56dkhTwBWxko3fk+FA2LTsD+E31VH4Hgas0CI=;
 b=D2SXZtGwzQldWfS9bbb8YyuZbtTz7D/Sz4qU1Djqq54WIwO8ZfQ29ugzQJ7i4nkGEq9xZtID/bbW4i/XJQ+EHMXOXYzXsqivmkR9T4qx0c+m7TRPxa0ULUeTnQLsHe+sr0rw4jmmu/1KSRVbYKgrQlkDojy9hjF2zOOYagLYZTkqbBmHsyseXVUB9uwfn/QUmqhY4q5lmz0sHm38pPRHEqC5HRurB0gpgntwZUeAKR0UW8xmOFM/L5AbBAZ9Om2sYW6Fv7uV2iX16wo6wFO04hGb0KD+UQ0uEXJQPCG86G/s3xN0NSVGlVmqvywyVGs/JCOuQDRTjgnlciXmQNYx0g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=O/xpDL56dkhTwBWxko3fk+FA2LTsD+E31VH4Hgas0CI=;
 b=BfhCNx6UNY3bFit2Ne639r16l+xH3Mg8rmRa2ZJkBAxAbg2Uvf1bpcTGo7u4vnBsOjxz0RZJ4dZK842C8Vat749Vzym7LDeXKYfDuh6JvQlM8YKZJ0kF7dYGfckukfJ7mzKxkwxLWvXMJxzlDmv20PcudOkOsIJ+Lx96B7JjVaQ=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB3962.namprd12.prod.outlook.com (2603:10b6:5:1ce::21)
 by DM6PR12MB3865.namprd12.prod.outlook.com (2603:10b6:5:1c4::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4242.21; Mon, 21 Jun
 2021 17:12:45 +0000
Received: from DM6PR12MB3962.namprd12.prod.outlook.com
 ([fe80::142:82e3:7e9d:55a0]) by DM6PR12MB3962.namprd12.prod.outlook.com
 ([fe80::142:82e3:7e9d:55a0%6]) with mapi id 15.20.4242.023; Mon, 21 Jun 2021
 17:12:45 +0000
From: Luben Tuikov <luben.tuikov@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 14/43] drm/amdgpu: Drop i > 0 restriction for issuing RESTART
Date: Mon, 21 Jun 2021 13:11:52 -0400
Message-Id: <20210621171221.5720-15-luben.tuikov@amd.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210621171221.5720-1-luben.tuikov@amd.com>
References: <20210621171221.5720-1-luben.tuikov@amd.com>
X-Originating-IP: [108.162.138.69]
X-ClientProxiedBy: YT1PR01CA0054.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:2e::23) To DM6PR12MB3962.namprd12.prod.outlook.com
 (2603:10b6:5:1ce::21)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost.localdomain (108.162.138.69) by
 YT1PR01CA0054.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:2e::23) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4242.15 via Frontend Transport; Mon, 21 Jun 2021 17:12:44 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ba9fe323-5a29-4304-4deb-08d934d7c93e
X-MS-TrafficTypeDiagnostic: DM6PR12MB3865:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR12MB38658056C7BA24347ED19A92990A9@DM6PR12MB3865.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:534;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 1WZkzp86rns4BtA226CLkRmeL090RK5YsOPzSvMDkydPlfk5fC0aHsWDCE38opVVPL2T9S3IccZW8mrrhjUg5KTqVwVbX2SkivOPNSxnSuQwW221aO787+RfYim/WimoBHhwAqxJLxhW/RBbCydTzwSeYtWM6H3SLkWm6+5glBhlDMbQGWMV2dhMi63rYIhnTLb/AbwuEp3hroo6y0tzKE5ozEV3Np053UMctsuF7xNo2PIapN3MuRx7+aqyEIf+tUiH1KMDQaQ+9c5wp/SO4YV1GFkkPklWJoXKLW1UeSC0936/D+So3qwOeEBtJ78X9NJEftinB4aJLp9m9NBseYmHtOWlauaecQznlpbdlEal4LWkrhKbpgBg49t5OnPdEiXaaoASPlS+js/8G64fch/eOx8ODSq0gWZObnZBrnEZrUrbdgHaY9gzc2kdOWMXIRHZVnuSRuF1o59svSPs0IwJrGYFJZLUFIYbeJAtuO0dZSOepMRPw3fUTxHmaONwb8ysU+GxI3RF1no0Cl0YfKjvS2c59ijuaDhjOQ6rb/3/yO/oejBFNueFGFN/onzA3QRpr3razufc3d7s6LFZt2AhQSh9ZoIDRzDf/jETM/d7BPP14oJ8vXlfK2fJebVDofiZOTkj3YM24QvBtizQXou5AjUggzQfIEOOG4xe8xW8iWZKt8U+gykyoqn4fQDM
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB3962.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(136003)(366004)(39860400002)(376002)(346002)(396003)(478600001)(44832011)(54906003)(52116002)(316002)(66556008)(6916009)(66476007)(66946007)(8676002)(2906002)(5660300002)(956004)(26005)(6512007)(6666004)(83380400001)(1076003)(8936002)(38100700002)(38350700002)(186003)(6486002)(2616005)(16526019)(55236004)(36756003)(86362001)(6506007)(4326008)(69590400013);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?DytUB2xwANoiGPWyjFtCiCCvm4ZeabfGn44Z7fHEDPgKCA/GExux1C01fPU4?=
 =?us-ascii?Q?6FZ/DTb7dL1xtb6T95+BRNWnA8nPWsuA0TQh/L5K9OnGzSG5gsuFeK/HBOvn?=
 =?us-ascii?Q?v1IeqmAtYjgimlvW4VhE7n9h+fM6m2pRG2T+CcH8FcWVXCVATaSOlu0LtZJ9?=
 =?us-ascii?Q?b1C/n3Er255D9c7vBB2uDLQnac6m0a7YqxdFi2EQ+7R8pvic+HK3ss8XKAMp?=
 =?us-ascii?Q?rAZPTT9k9EYL5OZuJf1vFzLFn8paUJAoHQRPafhCW6X1e5TG5dOck7iF2Pph?=
 =?us-ascii?Q?CF8cnGwcfnd6vWdwrqG3pmtPmcY0freXJlSxjD3d8bKsSyoCjQM1anP9yWsz?=
 =?us-ascii?Q?gj/GccWD4kPgrRasnhWZr08pufqW5CLftpdbZiHty2DIHLyid6Q+8+EtQLMG?=
 =?us-ascii?Q?ttVVl8wkFumlHXHwom2uramFin3dPkS/H9Yc/IB2w39qi4zuxkXGGSnZ1cQf?=
 =?us-ascii?Q?zcpBLvrW4mMcwfZoNipn2d60o5mQ+pOZ3Po1eBOjG4cCRHs7irW0TBOXRj5m?=
 =?us-ascii?Q?2NmX+7KSms1dVXN9jy2+LMvRo3g/lY2a95DK6iY7/qPIeALwpRWhGr1CX++L?=
 =?us-ascii?Q?dkgsOyOADECn/D2LRtG7A5zGKn1x4oZghW5pACEMW5/RLnmuYPzXeTmerJbU?=
 =?us-ascii?Q?uvYsUqUutjW83kuPHPsoH+KhluwpFs04Tf3OA2ZYO6yNiantG0Oq2XcrAXLq?=
 =?us-ascii?Q?HB0yGJ4pABIaWcgn7JZDfXCyj0M+0p0er8/6BfokVWJYtXa9BiAWle4uvi9A?=
 =?us-ascii?Q?VafNhulhPUEWosh6dUFDs2DJIXdA6Pc/OzzPp5lKO5f53sYy5owQNyTggFrW?=
 =?us-ascii?Q?u50wTRjxaTv4evrff+rsvJ4K7/Ur4oc0j7PvwMEhnQdCNS4cjcJ29yw+dpSm?=
 =?us-ascii?Q?OSxUiNonWtJcH4n4HBLOI1VTYlJKfpPvRKm1o5zQ4QAGCECTjB338dNfy7Y+?=
 =?us-ascii?Q?KlzOjNO7x+QMXhIsps56FtM6V0Svp22KiQkHm8ZJhyvLZx+fXONMXnA/u0cB?=
 =?us-ascii?Q?pakyD391Ny/L0wMQxtbvc5Pp12YWl5LPQfJIsBHibuvsnXfb+1KsjSimuFE7?=
 =?us-ascii?Q?6PaQbfuFCA+qwlMfacxSEdwbPWMY1qUN8OqfKvuAokqR1twSWhuoMeaI7pEC?=
 =?us-ascii?Q?CxeLqeLmb9AWsat/aNaPcnpOvz/8neQEEWnj0kVeQh3m+wzfuYfQme0UrQQS?=
 =?us-ascii?Q?vhL47YUSmvcNWjKzGwC7pBpLOa2a3xSPhZ8HMl4GlPi8ksj3D7WD74bt8ut9?=
 =?us-ascii?Q?75W4LxomV+AaEU4AKt/GD+WQUT+llz3nZi0JkjX/UqBSDhCCRN0dzhufqUJb?=
 =?us-ascii?Q?jhrQI5GLrMVaSvXdbkKdSQDU?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ba9fe323-5a29-4304-4deb-08d934d7c93e
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3962.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jun 2021 17:12:44.9861 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vWxGPdzN9LhJBWEfNep0hnmooViZ4Wce0AYmbWNmQGTs2QUMeebB0wbDwHBX68W/
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3865
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
Cc: Andrey Grodzovsky <andrey.grodzovsky@amd.com>,
 Lijo Lazar <Lijo.Lazar@amd.com>, Luben Tuikov <luben.tuikov@amd.com>,
 Stanley Yang <Stanley.Yang@amd.com>,
 Alexander Deucher <Alexander.Deucher@amd.com>, Jean Delvare <jdelvare@suse.de>,
 Hawking Zhang <Hawking.Zhang@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Andrey Grodzovsky <andrey.grodzovsky@amd.com>

Drop i > 0 restriction for issuing RESTART.

Cc: Jean Delvare <jdelvare@suse.de>
Cc: Alexander Deucher <Alexander.Deucher@amd.com>
Cc: Andrey Grodzovsky <Andrey.Grodzovsky@amd.com>
Cc: Lijo Lazar <Lijo.Lazar@amd.com>
Cc: Stanley Yang <Stanley.Yang@amd.com>
Cc: Hawking Zhang <Hawking.Zhang@amd.com>
Signed-off-by: Andrey Grodzovsky <andrey.grodzovsky@amd.com>
Signed-off-by: Luben Tuikov <luben.tuikov@amd.com>
Reviewed-by: Luben Tuikov <luben.tuikov@amd.com>
---
 drivers/gpu/drm/amd/pm/swsmu/smu11/arcturus_ppt.c       | 2 +-
 drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c         | 2 +-
 drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/arcturus_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu11/arcturus_ppt.c
index 843eb2357afaaf..a6d6ea1ef9e31b 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu11/arcturus_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/arcturus_ppt.c
@@ -1984,7 +1984,7 @@ static int arcturus_i2c_xfer(struct i2c_adapter *i2c_adap,
 			if ((msg[i].flags & I2C_M_STOP) ||
 			    (!remaining_bytes))
 				cmd->CmdConfig |= CMDCONFIG_STOP_MASK;
-			if ((i > 0) && (j == 0) && !(msg[i].flags & I2C_M_NOSTART))
+			if ((j == 0) && !(msg[i].flags & I2C_M_NOSTART))
 				cmd->CmdConfig |= CMDCONFIG_RESTART_BIT;
 		}
 	}
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c
index abb3647ea0a892..e682bbd3c26d82 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c
@@ -2783,7 +2783,7 @@ static int navi10_i2c_xfer(struct i2c_adapter *i2c_adap,
 			if ((msg[i].flags & I2C_M_STOP) ||
 			    (!remaining_bytes))
 				cmd->CmdConfig |= CMDCONFIG_STOP_MASK;
-			if ((i > 0) && (j == 0) && !(msg[i].flags & I2C_M_NOSTART))
+			if ((j == 0) && !(msg[i].flags & I2C_M_NOSTART))
 				cmd->CmdConfig |= CMDCONFIG_RESTART_BIT;
 		}
 	}
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
index 9e49505a6ac109..93acf3f869227a 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
@@ -3490,7 +3490,7 @@ static int sienna_cichlid_i2c_xfer(struct i2c_adapter *i2c_adap,
 			if ((msg[i].flags & I2C_M_STOP) ||
 			    (!remaining_bytes))
 				cmd->CmdConfig |= CMDCONFIG_STOP_MASK;
-			if ((i > 0) && (j == 0) && !(msg[i].flags & I2C_M_NOSTART))
+			if ((j == 0) && !(msg[i].flags & I2C_M_NOSTART))
 				cmd->CmdConfig |= CMDCONFIG_RESTART_BIT;
 		}
 	}
-- 
2.32.0

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
