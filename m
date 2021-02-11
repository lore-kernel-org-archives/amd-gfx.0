Return-Path: <SRS0=yskd=HN=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 363ECC433DB
	for <amd-gfx@archiver.kernel.org>; Thu, 11 Feb 2021 21:45:00 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E313E64DA1
	for <amd-gfx@archiver.kernel.org>; Thu, 11 Feb 2021 21:44:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E313E64DA1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9ED196E204;
	Thu, 11 Feb 2021 21:44:59 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2040.outbound.protection.outlook.com [40.107.92.40])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 558EF6E204
 for <amd-gfx@lists.freedesktop.org>; Thu, 11 Feb 2021 21:44:58 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=g9IYCXflqz6EQMMk1GVsxm7H7mKcROvWzlTtw/hbj6nhDXOTpmhXFcs0mnfDRrF6gxC/UBW30SqxAhvyMYlTXZ2PhsZn7dLYG3G6WJ47cTOHRsFR/eSEDQQqEZBMfGxzoJqcu8Bf6IMGL3pcxnD4+fuRXyiFZiPiv2AATuvrwrGbGrQIDj3rVGL4jrmA1Gg8FxAooyPrPO1LBubEIE1teBjgkOXaxnGEVeaXxwxLHFWir1JEINf4nXLte810ENMR5Yuam8qBqw9RAIcA8pKs+yTI0ct17k7TFv0Y5kTow7q7dqVfVrsxx5yH8uGWg8gWvpr7e92QGf3Ihq/cBor5+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6aZBq8cYA4ZRFxZyjKZSZPdh7zhY3rEU2jeFRhwg5/o=;
 b=SsisWUKH0GNAAFqW99Wurxe6BB1AWCnhpoCuGfyOB9jnuBTfB0Nj0n1QFd4hhWLoDtaRMHWhxoKgSu2lnVGAQ4FUFVy01tPMvw+bGjiHiX1zIBYW98znWl7IJrLBwM//nVKi3xt/G89XmCz9qdPEomU9ZwIQaf8PtvH0nxhNaJ/Sa3Q/rmlD27KU5rJJ9uy/Q1iSOrDDszmPH53KS3NAldj0P/MeHOhl/MEvH7siDJJwF395BMEbilJPMTdXTMqKf6xDXG7agatk4gmkoZ3YkvccQsqlHRHSZdPgzhqJlidHVt0XSOqz0S0FeUvFuRZUdIJOrY3Ir5GcXwHM2KzRhA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6aZBq8cYA4ZRFxZyjKZSZPdh7zhY3rEU2jeFRhwg5/o=;
 b=B91TGWCUXUCwobPYrktJRxKv3c//eZCFBqr4eKbELVsencP15Yov5IpN6Ahf5fq325KiTw2Q8uGHBbaTj3kkJ7DeCKLVnR4LN9uVLM1Rr5MwtGblp7mWqjK+gwoqcAVo0sxMbdD9qScdYcTsFNOFatEXgWeNbTSHvKkZBjEs2jk=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB2939.namprd12.prod.outlook.com (2603:10b6:5:18b::24)
 by DM6PR12MB4235.namprd12.prod.outlook.com (2603:10b6:5:220::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3846.29; Thu, 11 Feb
 2021 21:44:56 +0000
Received: from DM6PR12MB2939.namprd12.prod.outlook.com
 ([fe80::bcb5:dc9f:c49c:9faf]) by DM6PR12MB2939.namprd12.prod.outlook.com
 ([fe80::bcb5:dc9f:c49c:9faf%2]) with mapi id 15.20.3846.027; Thu, 11 Feb 2021
 21:44:56 +0000
From: Qingqing Zhuo <qingqing.zhuo@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 00/14] DC Patches Feb 15th, 2021
Date: Thu, 11 Feb 2021 16:44:30 -0500
Message-Id: <20210211214444.8348-1-qingqing.zhuo@amd.com>
X-Mailer: git-send-email 2.17.1
X-Originating-IP: [165.204.55.250]
X-ClientProxiedBy: YTBPR01CA0026.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:14::39) To DM6PR12MB2939.namprd12.prod.outlook.com
 (2603:10b6:5:18b::24)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost.localdomain (165.204.55.250) by
 YTBPR01CA0026.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:14::39) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3825.17 via Frontend Transport; Thu, 11 Feb 2021 21:44:55 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 2e441b99-a3ee-459b-9e3f-08d8ced645a0
X-MS-TrafficTypeDiagnostic: DM6PR12MB4235:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR12MB4235AD3B09B1E2AFF08A782AFB8C9@DM6PR12MB4235.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3631;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: FKl3iOfcaRSx9T1Qx94LdlZBMqHv24xT2u9YI43fgdehQx51+vBqIITs8C1nOZt2jsa+OKhvjXVIpZpF2VXfA2AFfVfuIPg8z94O6CgVaNopJ5OiQFFHingF9cLcdZ3g7E9gOKCPviaEm7a+a1F5XHGtT7b+CLEl87EFtqKRUpRUXXpU6+Lmy1H7WExAuWao/qpW1MZyvdP2+/DQfMNFuwA74cYAmXzVe3hfUTGgD99/smxpcUv16pV9MBWXH5ct+4v2a7OhP7TXJkMqmc9WSubsxEave0c72jxviiCPqLIczPnH0oMUixniCJueBLnlDhSvEZymOJ708WWeDZuVMCFeLuiV/B3cvYJrTgCIscZZihj6mF0xUvVSbcvSPftxUkIesNAX+cQGU054XgTi3rEJf9mzLgr/jdPUTp61RNNzucrMu+1b5EeMKICpHH3hMiOtfuOD5CBBluDp6sDNgIEacks+nIzrCxFLROpUsuX08f/XLwItsjkpMzgnza/RCLCXFG1INbkFD3ZY1QyZWOLtCHD074tqKYvcRILhfgSGd4+sGSbrjB+UBVObE/oXiQVS+ha7KhFjJEz/fFJlXw==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB2939.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(136003)(346002)(39860400002)(396003)(376002)(83380400001)(16526019)(8936002)(8676002)(478600001)(86362001)(6916009)(6506007)(66946007)(6486002)(6666004)(1076003)(52116002)(186003)(36756003)(4326008)(956004)(44832011)(69590400011)(6512007)(5660300002)(66556008)(2906002)(316002)(66476007)(2616005)(26005);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?fs7fgUkQ2mD/id1Si/xJd1RmgOS267MDpfVEyZYRlvLIRFZz2lYKYVxGk5zp?=
 =?us-ascii?Q?FcINisB0qqcc2PATAiiCWhgIm6sDwyWOH+DTEH6hAlB5kBh6XgYqKqD8Gczh?=
 =?us-ascii?Q?HU5y3U4ReHYqQW+VLuHcQ1w7vVQ+2H2Md6Q/axS4gz0Rid7l68qv3cOkYRIb?=
 =?us-ascii?Q?YBx9s1/I3WRaHwnTuPukofbbGEK3JYKWyey/PLSiaI7PZb2cFYAUFN+9LLBx?=
 =?us-ascii?Q?oiH4BGYxYmF4CzLDbooOcv3f6eoHpkCFot0P7IG4/DO4xSavNey25r10n4EI?=
 =?us-ascii?Q?Y9lyjoHN509YqvAywq8x1DNVfArMeh2WIykfON+G+ssJilw5TYz/6MmV4vmD?=
 =?us-ascii?Q?1/yPtCSVSPp/iGsB3s1vRBp5xCCd0UbH5ifEayAu+5pJUeeXOE5a6FgrLMuF?=
 =?us-ascii?Q?Te6BCfs7981FhLrc5WLHTVMhSYKQm6u9RowgsCyiL69BTyunvfOlTbfHv+bF?=
 =?us-ascii?Q?HkVJO7o5W8FL3zB/HdYFG250rwOLjxeIQypZ1g+bYZNCrG8/LYzNRiThcs53?=
 =?us-ascii?Q?SvT58V+x4T3W1+AIGx1sBedLubFZqWmVWMtGI03NjSzf6Atp5yhPVhlGUoXN?=
 =?us-ascii?Q?gVO+xkxZ5Iw45Y39tj3bA2Spp/aP11YxgkiEMGCvX+ziAJzg9Zd2nrYk9bEc?=
 =?us-ascii?Q?nYCR6OJRMXRUxs8u6YhiDG9c+Qynvbi+RxLFrmnAqXA/7w9iY4CsHgKzPEjn?=
 =?us-ascii?Q?qWiDSSAjZfiV9PMKgLwmmLTRorbO75Gg8OH5gOVMLprnZeyQmCOPdj9KyB7N?=
 =?us-ascii?Q?b5XHtohjdErr79KoVZLaPyfwVHpVKgdeZtcGn1BcDpOurKZybsuInkChPFSv?=
 =?us-ascii?Q?6uP6rLqvshwoJjR1PdPDp03DRE3g4fZL+/5RUCdTFpBK9EjkWDESG2vBOKmp?=
 =?us-ascii?Q?85ovACjLmnvHyvGrsRDi9Ebq2AjrDDPsOVfXSG3cIwYUNggF9xRz0s2edK2e?=
 =?us-ascii?Q?JDHhUaMzs4xVMHecCtFMxk/D2IyQO68Tsuuss/vOgdwaQFsZDivotWq4nqXG?=
 =?us-ascii?Q?Mb1s24ub+DqeZLuTQlNdwLWYB/8iW3mQ5FONs11DxURoYx3OuujpeLeJNPSI?=
 =?us-ascii?Q?3zH9PelXlo6Y00R2IsvBs4Vix419hES50KiJnJtBuELBg2++oReeVhXL+hfM?=
 =?us-ascii?Q?Kbe0bbXcZgZhhvfmxMYcNgdk0cWDCBIe4WBVhPJ/9nzgl+1aY16ap86+XKf1?=
 =?us-ascii?Q?m/Bn0ccD4nyU+kQhNuFFZrYaPWGCoKQqbP4j+GYXEQjKaAA/zDDp3AkwkeMS?=
 =?us-ascii?Q?pjy6/gzedqWj6WRuj1TANCz4E0c6CC4Im27D4w7XrIuEEi1A0kP2pVeiObyo?=
 =?us-ascii?Q?U2cCTGOSKHVWBlME5uI4YGJz?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2e441b99-a3ee-459b-9e3f-08d8ced645a0
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB2939.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Feb 2021 21:44:56.1261 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wQaLKM63gw+R8OuO/4XA+Eg9k6mzdNSFaKPlVaudTMql1hUpiZs/nKxRUYpijdSY
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4235
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
Cc: Eryk.Brol@amd.com, Sunpeng.Li@amd.com, Harry.Wentland@amd.com,
 qingqing.zhuo@amd.com, Rodrigo.Siqueira@amd.com, roman.li@amd.com,
 Anson.Jacob@amd.com, Aurabindo.Pillai@amd.com, Bhawanpreet.Lakha@amd.com,
 bindu.r@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

This DC patchset brings improvements in multiple areas.
In summary, we highlight:

* DC 3.2.123
* Firmware release 0.0.52
* Bug fixes on MPC OGAM sequence, display experience, etc.
* Improvements on timing, transmitter control, etc.

---

Anthony Koo (1):
  drm/amd/display: [FW Promotion] Release 0.0.52

Aric Cyr (1):
  drm/amd/display: 3.2.123

Chris Park (1):
  drm/amd/display: AVMUTE simplification

Eric Bernstein (1):
  drm/amd/display: Implement transmitter control v1.7

Lewis Huang (1):
  drm/amd/display: remove global optimize seamless boot stream count

Martin Leung (1):
  drm/amd/display: changing sr exit latency

Nicholas Kazlauskas (2):
  drm/amd/display: Add dc_dmub_srv helpers for in/out DMCUB commands
  drm/amd/display: Fix MPC OGAM power on/off sequence

Po-Ting Chen (1):
  drm/amd/display: Change ABM sample rate

Stylon Wang (1):
  drm/amd/display: Add Freesync HDMI support to DM

Sung Lee (2):
  drm/amd/display: Populate dcn2.1 bounding box before state duplication
  drm/amd/display: Copy over soc values before bounding box creation

Wesley Chalmers (2):
  drm/amd/display: Old path for enabling DPG
  drm/amd/display: Unblank hubp based on plane enable

 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 175 ++++++++++++++----
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h |   8 +
 .../gpu/drm/amd/display/dc/basics/dc_common.c |  20 +-
 .../gpu/drm/amd/display/dc/basics/dc_common.h |   4 +-
 .../drm/amd/display/dc/bios/command_table2.c  |  72 ++++++-
 drivers/gpu/drm/amd/display/dc/core/dc.c      |  43 ++---
 drivers/gpu/drm/amd/display/dc/dc.h           |   3 +-
 drivers/gpu/drm/amd/display/dc/dc_dmub_srv.c  |  22 +++
 drivers/gpu/drm/amd/display/dc/dc_dmub_srv.h  |   2 +
 drivers/gpu/drm/amd/display/dc/dc_stream.h    |  11 --
 drivers/gpu/drm/amd/display/dc/dce/dmub_abm.c |  10 +-
 .../drm/amd/display/dc/dcn20/dcn20_hwseq.c    |   2 +-
 .../drm/amd/display/dc/dcn21/dcn21_resource.c |   9 +-
 .../drm/amd/display/dc/dcn30/dcn30_hwseq.c    |   2 +-
 .../gpu/drm/amd/display/dc/dcn30/dcn30_mpc.c  |  24 +--
 .../drm/amd/display/dc/dcn30/dcn30_resource.c |   2 +-
 .../gpu/drm/amd/display/dmub/inc/dmub_cmd.h   |   8 +-
 17 files changed, 300 insertions(+), 117 deletions(-)

-- 
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
