Return-Path: <SRS0=SWRn=ML=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 692B3C07E95
	for <amd-gfx@archiver.kernel.org>; Mon, 19 Jul 2021 19:52:24 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2423A610D2
	for <amd-gfx@archiver.kernel.org>; Mon, 19 Jul 2021 19:52:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2423A610D2
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CEC8E6E07B;
	Mon, 19 Jul 2021 19:52:22 +0000 (UTC)
Received: from NAM02-DM3-obe.outbound.protection.outlook.com
 (mail-dm3nam07on2067.outbound.protection.outlook.com [40.107.95.67])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 46FBC6E07B
 for <amd-gfx@lists.freedesktop.org>; Mon, 19 Jul 2021 19:52:22 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=X4sX+h/Odql8U7oTBnlBEqgsjmZFuG/UEqTsqwR5Dt7BOkpBr0qXzOvpFEIp654d4vM/MYSnFGe6NwOZuC20wBLQCbM/AlPlu9cmcRA9onboWFiQ3sGT9HQGyY14pj8NJ+yqc+dC0cHae/3EpwSrjT+u6ndx8Aha8lCAgEJV3pxmOxcZj2eWtx7KAFHPR+ZEe4RFDERo99SxXg4BEKWXDep7PLUA65/lwlm0zuipVi2vPiFTKCYncxrfcoIvern93mJ+gbkzYBZduuHPUdONtzza5wA8B02QXHa1yy6/gt5RAiJWTH1IOJh4mwMgB1fT+1yUTf7u5U5+9/HWmjzNfw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ax8mRcKVkQOJOWyti60+vmIA7HGm+o8v+VNoWaBseQA=;
 b=W+j3gEvhb0nJ/hPEcSB+DQHT6maRXU9FDJZefhdfWAR5wEx2aC+e4gUKYCJ2OYyE4cvijS+pEYyHWZwZs2EYmW4C3YSAkXwwquXXxbjldmGd412qOlSJNoogTEoazmfEngNTF1bS9gd5Vip5Xd+icNcxWAO9s1Z/CO5/JV/xYqfcwYDSJYPEYeRmRwzvFxw54rUIcVFeO4JCEnO88WqU9kj/KALFEc/yTtmHQFgwODUaR0+ycRb0LmzXD01o4iJatHFLu0Nv143Ef3CDT2XpDLOoGms3s1oCcSDA+Fjkz32mY6usRQ8QEfHReZaJcqAKm9HOI76IxkmQly55TxzOXQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=ellerman.id.au smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ax8mRcKVkQOJOWyti60+vmIA7HGm+o8v+VNoWaBseQA=;
 b=YukCeZoctdlT8vyt+TNzkv1TSgm3eAOHfl5klOjrpOrPdeokPAHjA162r+nB+ewunbX61BK3ak9CiO0c6YOz1mfhFUdUar4EmbIABpdy71NHHIsrQIGIXjTMKS79paae+1gyIqrYS/8u0ixd+vuJkuPEPMoAgZhjCXBcL0BqZq8=
Received: from DM5PR06CA0064.namprd06.prod.outlook.com (2603:10b6:3:37::26) by
 BN7PR12MB2804.namprd12.prod.outlook.com (2603:10b6:408:2f::30) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4331.23; Mon, 19 Jul 2021 19:52:16 +0000
Received: from DM6NAM11FT064.eop-nam11.prod.protection.outlook.com
 (2603:10b6:3:37:cafe::23) by DM5PR06CA0064.outlook.office365.com
 (2603:10b6:3:37::26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4331.21 via Frontend
 Transport; Mon, 19 Jul 2021 19:52:16 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; ellerman.id.au; dkim=none (message not signed)
 header.d=none;ellerman.id.au; dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com;
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 DM6NAM11FT064.mail.protection.outlook.com (10.13.172.234) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4331.21 via Frontend Transport; Mon, 19 Jul 2021 19:52:16 +0000
Received: from SATLEXMB07.amd.com (10.181.41.45) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.4; Mon, 19 Jul
 2021 14:52:15 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB07.amd.com
 (10.181.41.45) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.4; Mon, 19 Jul
 2021 12:52:15 -0700
Received: from Bumblebee.amd.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2242.4 via Frontend
 Transport; Mon, 19 Jul 2021 14:52:13 -0500
From: Anson Jacob <Anson.Jacob@amd.com>
To: <mpe@ellerman.id.au>, <benh@kernel.crashing.org>, <paulus@samba.org>,
 <christophe.leroy@csgroup.eu>, <linuxppc-dev@lists.ozlabs.org>,
 <amd-gfx@lists.freedesktop.org>
Subject: [RFC 0/2] Add generic FPU api similar to x86
Date: Mon, 19 Jul 2021 15:52:09 -0400
Message-ID: <20210719195211.520428-1-Anson.Jacob@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 6440b284-8d41-4038-8d38-08d94aeeb5d4
X-MS-TrafficTypeDiagnostic: BN7PR12MB2804:
X-Microsoft-Antispam-PRVS: <BN7PR12MB2804BF368BAF38AEF2AE5342EBE19@BN7PR12MB2804.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3968;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: eJL8RrTOLYngrUp4EeU2f1Wf83VCir+Tv8Bd0bMy9ir7b6q/j+51Gk++1Q0Jv3mjcD+H3VBGsFF00LFkyrkZcZWUhQVBxdCQ4FBseUKGE7TahbfxMPmknRovxsiDYd1bOQ8gc0LFBmYWIFbjR0hvP2KJWor6cwPNSXRUH8BQA6O6bOLgRXuiR9bdT1y/PmXabRglJ4teckFmoI8MvPCJtNMEtH/uEBD190wfg/aY3M3E1DaF9gFlXLdtZh5EpM8XL6NyeV1yREIu55nG0pv2PvFNryAaSvC+tk59OLExGp9BpnTMADbS1N9nHBL3keLN1V9NhUFuPy1rISOD+DAaTcW3ykUczvzUPMpmrQtsOrNd2tQDFNxmUcPpFMpUR6UpLlI1M5RLCkALObsYaEWjFl7zSZIUI0zGcbkymSPnwyZVlSOITAVWV4jkNAGlDnc1OU7GPoWLU0+kqi49R/uRQ43kUXAWP2s2hicvq9HnkSkn/yn8QMCSTrwZFdDSPO9n5TsafQd9TjO/i63YikuIAXO7YS8bCKbkgCmaB2WI+CmFg+EN7znTFGnhUDbJq2JWQU0v2lKHTsac4P/FHVS8g2BoWZzEOg2tqhD54chttKNoRh9QXke6586CaA/aUNjpfS11zysIshmc+cT8jPWPSZ2SGmoHXpS/UHz2lxNyJznDZeVbOswQUCsYnr0m4urmbp7c656ZQqZ6cVWeD358oc9KBdxX3xn8ltbDFhhtYV7TvcnlcL/I7Ip8c03NEB9Lkg4va9FRXhek3K9O5kEbVg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(136003)(39860400002)(346002)(376002)(396003)(46966006)(36840700001)(2616005)(316002)(86362001)(8676002)(36756003)(82310400003)(82740400003)(47076005)(4326008)(81166007)(7696005)(26005)(110136005)(54906003)(186003)(426003)(356005)(36860700001)(2906002)(336012)(4744005)(6666004)(8936002)(83380400001)(70586007)(478600001)(70206006)(5660300002)(1076003)(41533002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jul 2021 19:52:16.1734 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6440b284-8d41-4038-8d38-08d94aeeb5d4
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT064.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN7PR12MB2804
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
Cc: Sunpeng.Li@amd.com, Harry.Wentland@amd.com, qingqing.zhuo@amd.com,
 Rodrigo.Siqueira@amd.com, roman.li@amd.com, Anson.Jacob@amd.com,
 Aurabindo.Pillai@amd.com, Bhawanpreet.Lakha@amd.com, bindu.r@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

This is an attempt to have generic FPU enable/disable
calls similar to x86. 
So that we can simplify gpu/drm/amd/display/dc/os_types.h

Also adds FPU correctness logic seen in x86.

Anson Jacob (2):
  ppc/fpu: Add generic FPU api similar to x86
  drm/amd/display: Use PPC FPU functions

 arch/powerpc/include/asm/switch_to.h      |  29 ++---
 arch/powerpc/kernel/process.c             | 130 ++++++++++++++++++++++
 drivers/gpu/drm/amd/display/dc/os_types.h |  28 +----
 3 files changed, 139 insertions(+), 48 deletions(-)

-- 
2.25.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
