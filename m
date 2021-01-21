Return-Path: <SRS0=VJnr=GY=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51D34C433E0
	for <amd-gfx@archiver.kernel.org>; Thu, 21 Jan 2021 02:14:06 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 972AF23788
	for <amd-gfx@archiver.kernel.org>; Thu, 21 Jan 2021 02:14:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 972AF23788
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C9E5F6E49C;
	Thu, 21 Jan 2021 02:14:04 +0000 (UTC)
Received: from NAM02-CY1-obe.outbound.protection.outlook.com
 (mail-eopbgr760047.outbound.protection.outlook.com [40.107.76.47])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1403C6E49C
 for <amd-gfx@lists.freedesktop.org>; Thu, 21 Jan 2021 02:14:03 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=I6lwSZP4bjVLoY4EbBQuFNF1hGAPmMu+IpUS9Ch6pO49HqigLh3LF4pP0UM/6MTIuAj7S/7dFHeABKbWnPnuE2USvJSCZZiw1KH8Ui43mvcuhoXwDcL5O4B53jor9oEk/IxfBueLvuIPm7AVChaeIOkPXR0nxJpPRanxcneMw1k5/UuN7tR7CJO41oOr55BsMpfPxdVZ5C5nltdqioft9gkr8kneN5dJttx5vAPK+Px46yL3Z//nTjnfvGW8+YNF8mSuSdApVx4cOlNbdgvKth+3jZWoLDzYLk4u6ngera3DgEWFtpIhiIsFOd6ROKs05iBxLzly3cGXmnQC3bnzig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Y7n5UBajR+Nk+DtxvHZfMCnEDas+TrpVPPYdmPMgYjg=;
 b=jc5xL38qNjtQeGwB/vpypfhE7CxR1dMZaU/nkQNqfqUBqDTv9jo1qjps0prmaPu7ho6Ea0e1fX5eEuUq+cDwglAOkkTw/xE04l7EYDeVLHBfr6RbL2zg/685rFVPSV0m7Hfmh9EUDgZaXyr97vS1ay4U/0+7K8yxQVxdoscswrazptIzwO/Qz0xLs8PQcEuquLSWQkR5s5VUnQzAVMOn3OdI927VcOyXWvZYzLmVcV3esN/hpuRJ9xdKkSMoJnEfhQd+2Vdt8Jq8DqWKeIqPwtGluU1669er2c/kcMnvWvkmiIz4hdl9gHMxWcCF/3wRvaWiLDyc2EH6ya0iPMGhow==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Y7n5UBajR+Nk+DtxvHZfMCnEDas+TrpVPPYdmPMgYjg=;
 b=lpustIbNuYNSJ188Y/UleSwYPvjvNakpAAPu49dLf1jvj1VHYYBoPYdr38OEoCzkEnubP3X5yF0NREEhi7O4juCc5maZ8c7m/UIyq75yenktRFcQQHBwjQTltiTfNmtx52WOKBW6hGt0sjnZh7FEy7WqnQ5jz1iPzoxEUbPIcm4=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB2812.namprd12.prod.outlook.com (2603:10b6:5:44::27) by
 DM6PR12MB4483.namprd12.prod.outlook.com (2603:10b6:5:2a2::22) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3784.12; Thu, 21 Jan 2021 02:14:02 +0000
Received: from DM6PR12MB2812.namprd12.prod.outlook.com
 ([fe80::79e9:b52b:c230:6118]) by DM6PR12MB2812.namprd12.prod.outlook.com
 ([fe80::79e9:b52b:c230:6118%3]) with mapi id 15.20.3763.014; Thu, 21 Jan 2021
 02:14:02 +0000
From: Jinzhou Su <Jinzhou.Su@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH] drm/amdgpu: Allow GfxOff on Vangogh as default
Date: Thu, 21 Jan 2021 10:13:40 +0800
Message-Id: <20210121021340.19062-1-Jinzhou.Su@amd.com>
X-Mailer: git-send-email 2.17.1
X-Originating-IP: [180.167.199.189]
X-ClientProxiedBy: HK2PR03CA0048.apcprd03.prod.outlook.com
 (2603:1096:202:17::18) To DM6PR12MB2812.namprd12.prod.outlook.com
 (2603:10b6:5:44::27)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from jinzhosu-System-Product-Name.amd.com (180.167.199.189) by
 HK2PR03CA0048.apcprd03.prod.outlook.com (2603:1096:202:17::18) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3805.6 via Frontend Transport; Thu, 21 Jan 2021 02:14:00 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 4cc62e52-4fbc-448c-2a7d-08d8bdb2384e
X-MS-TrafficTypeDiagnostic: DM6PR12MB4483:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR12MB448352FB2DAFC1296B6261D890A19@DM6PR12MB4483.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:510;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ULu+l2HuE440DqUlViOhSABBAo3ayjcd+41FJh17ECwxnQHSigFcX3kVq3pu3b17bC1Y0/Srr2hpjxf+0jPeH+GG3LEl9/7VaazCSv863QKqr6lsbo77FEYs9JBe1eb66/yhyNIphrysUKEwfD9wUuYWQToF881vZZq+nLCR0FvqoLkz9csSvozzIeof9xI340xHOBoonpUb1dYKpmImKhBK+226qeLhxmUp3r3pbogdiWDQiDGn4fwMKXiGVFPh09vDRXIe9mW2/VOMM+Gy0lgLR6iCXmTg3Brd7Tz/k9o4QDGAJG3l0px0r8SpBguElsOZVG57IrpjrF/m9FED7k1dib0m0ZFMGYftaJQuG92tRCFqgPktx4SJ4R86BBnTWtTqpAGC4WzM8rxyP0PiCQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB2812.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(136003)(376002)(346002)(39860400002)(396003)(66476007)(36756003)(316002)(83380400001)(66556008)(66946007)(52116002)(478600001)(6916009)(86362001)(6486002)(1076003)(6666004)(4326008)(4744005)(186003)(8936002)(26005)(16526019)(7696005)(2906002)(2616005)(956004)(5660300002)(8676002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?W6ovsf2G917fniHTuvem13PSUeablzXKXQgtLiACk32WvLkJLxwqaOv9JHYd?=
 =?us-ascii?Q?bPN70ayil+7l/IOpEDai95Jbpc8mpo2Wh9vpiEf9hNBUXxUFR1lvI+P38hqa?=
 =?us-ascii?Q?Z4O9guKzBCDMKbEc1017h1mlu/3u6oW0b92elgFb4VsOg+E8DNnvJQy6upoG?=
 =?us-ascii?Q?VhpXnVWwEO/cZCZ3XXcFIxuWsur63+cuFX2H9vq+e5OQr1xpoJeetOSoZcER?=
 =?us-ascii?Q?Gd9LV3nHJfbQLELV5Ay0cbFHL4O9XSZGTqYQLV64r8nOt9I7b59LFA+Fww+D?=
 =?us-ascii?Q?iohZWhRqXWA1NwqYLjoL5WqQG/eeCK4i+gd+M9XCuyjzvrX0p7sdr/0gBbs2?=
 =?us-ascii?Q?L5IE9hVroyv8THLBQketfKQVnMa01zSyyqcZFGeI7q6dZOKfXQQ0kRYmu3Pu?=
 =?us-ascii?Q?SWSudLSIKDteiyabt0JNqXc8KtDsOwNhLuzkVfnBBb/4JI1CrjuwhIb82yYd?=
 =?us-ascii?Q?+ToR9oZv2oB+3NCCIXOON2tTs++tTwOI6ASvfRn8jTBRhMX7BaH5BgrPg741?=
 =?us-ascii?Q?akcNgW2RMehnKayeGEUHDcO+/wlEWajIsQxe/cc93bkE45mJ4ZfJQSWEGOFn?=
 =?us-ascii?Q?dH8ESFAbaThOVTBSnpe4LC84ltliZFbDGSJ7B4FRPYkDm2CUYSWNwlxVhYnz?=
 =?us-ascii?Q?7uM7grr4TYIs9qx0nrQMoHtTtwPQCy1eZXlbQOjuwfXxwgGaoYFdCM/yK1pH?=
 =?us-ascii?Q?7AqdmcUhEejKRuHhWeNly7TfYk9kzM7JNdOU6OjtVNuF3BsQmeEmxlKL7CPK?=
 =?us-ascii?Q?iwD5kFNqBI117PgxX1mP6K+bqGE348UUVX3Ycysq7YwYlO/q4lVxTlUkgNkW?=
 =?us-ascii?Q?b2ho95MaZX8ixN0fE7SqjYKEc5trkY9nGKrFrI8dHFdEZ4uRjXJ7Mr3iX6Hd?=
 =?us-ascii?Q?eRz+lEmr8A9xuMWr88n4vWEbt326soioguFl5mLraA3IZH27EODNtVeP0s6T?=
 =?us-ascii?Q?BBrc37PB6jzUBrCtVl166qLNR+KyPZtbkoN+2XAwENK6Nh9Suh/RIFvXcJO9?=
 =?us-ascii?Q?arA9?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4cc62e52-4fbc-448c-2a7d-08d8bdb2384e
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB2812.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jan 2021 02:14:02.3328 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2C9LhouuP5PdnTFn8D9WR5RqXK3s2IrrHGHsKOdY/3QXoUsERwLJy5vkU0CKr/hDpVpXxFDpgwZY9ri0o385nw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4483
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
Cc: Jinzhou Su <Jinzhou.Su@amd.com>, ray.huang@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Send allow GfxOff message to SMU to enter GfxOff
mode as default.

Signed-off-by: Jinzhou Su <Jinzhou.Su@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
index dd102cc2516a..426a217ce83f 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
@@ -7905,6 +7905,7 @@ static int gfx_v10_0_set_powergating_state(void *handle,
 		break;
 	case CHIP_VANGOGH:
 		gfx_v10_cntl_pg(adev, enable);
+		amdgpu_gfx_off_ctrl(adev, enable);
 		break;
 	default:
 		break;
-- 
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
