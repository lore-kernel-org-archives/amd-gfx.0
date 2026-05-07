Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 00006CD343F
	for <amd-gfx@archiver.kernel.org>; Thu,  7 May 2026 14:08:46 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8900810E08C;
	Thu,  7 May 2026 14:08:46 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="tuo3IYDn";
	dkim-atps=neutral
Received: from CY7PR03CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11010053.outbound.protection.outlook.com
 [40.93.198.53])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 96D6410E08C
 for <amd-gfx@lists.freedesktop.org>; Thu,  7 May 2026 14:08:44 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FF6hRd1CMCX2LSZU0pf+uCNxwQBv1nfT6oU9X7yjMJXigSKiT/OMaBZaO87mtnz0MhxePKRcq37SDOKqKpxjCFlI0HMzUkHUOJL/hRfk3F5Jr4I5/rEfTV/L5jPvHs8fioDYakJxdib/1CJ/Pn3yqfztwG0O9F/OSxWgGrFgORj3h9Vo6EN+UOKajEDG/jB6Ko9aWCunEH2Rivc4ELg/5j75UMRAywzp2TVO1YYpK0iBjp6q4xDGW33u1Yy7Vh0Wi5yFF85oQ58poZCx74cd2BPoXZsFA2LkcjUHFWJKVzJduxlNeUMeiUcu6JKnz+r3PAoOw+OF2ccjPGBC58Goww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QP7sRDu5cHkyXHAwIGPvD3gKhw+M3Ol842sjdMIOTW8=;
 b=NIC7rG6U0c+mwQoduAcZQPa9DDI27lDRPmP2wxnC3kbdNXYaOk0S5bLFyAkkQCCRz3LDyJmEsCrfDUIYdH1nhwXX99LZC7+qU/+OwLiYCmOU1AzmN4QTK308Mff3GeXFkoNAuqA7DjH4pS0B2IU2lIa4+7/lQWJRUNEwSgbUJusAKS5NydrMbR+OPo94v8wvj+E4atn4f5oWHN/Zg3DL4oc0UpjmsW4ydaycRFUrltN/w5FXLhgtdEJ2WurpcgcolC0e1tuDEScecB005hdGZvFV+58cKz0diWhyYZ5xeF1rlz+j+qo7aJYwyQdIXBDhSi/HQWQvSFhhms130Cp+7g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=gmail.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QP7sRDu5cHkyXHAwIGPvD3gKhw+M3Ol842sjdMIOTW8=;
 b=tuo3IYDnbeU54VQBpOMapNMHSuViPb6kSogbbpynOagf4T9ExxxVJt+J2QV7i3nzKh4sEABoE1SoAbTsTg2xPSdU/s9NwszAtmS0YZw7djYRc5LsL4NCxMIY21JAqmDHRTnkR/Ig/6uhDRKY2HN3zAaNqO786Mw1cukNAb+pjHg=
Received: from MW4PR03CA0243.namprd03.prod.outlook.com (2603:10b6:303:b4::8)
 by DS7PR12MB8251.namprd12.prod.outlook.com (2603:10b6:8:e3::6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9891.15; Thu, 7 May 2026 14:08:38 +0000
Received: from SJ1PEPF00001CE5.namprd03.prod.outlook.com
 (2603:10b6:303:b4:cafe::b8) by MW4PR03CA0243.outlook.office365.com
 (2603:10b6:303:b4::8) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9891.15 via Frontend Transport; Thu,
 7 May 2026 14:08:38 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 SJ1PEPF00001CE5.mail.protection.outlook.com (10.167.242.21) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9891.9 via Frontend Transport; Thu, 7 May 2026 14:08:37 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Thu, 7 May
 2026 09:08:37 -0500
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Thu, 7 May
 2026 09:08:37 -0500
Received: from [10.254.92.116] (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Thu, 7 May 2026 09:08:36 -0500
Message-ID: <1eba6328-acc1-411d-b7fd-c066a4335c06@amd.com>
Date: Thu, 7 May 2026 10:08:36 -0400
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amd/display: Use vline2 interrupt on DCN instead of
 vstartup
To: =?UTF-8?Q?Timur_Krist=C3=B3f?= <timur.kristof@gmail.com>,
 <amd-gfx@lists.freedesktop.org>
CC: <Harry.Wentland@amd.com>, <Aurabindo.Pillai@amd.com>,
 <mario.limonciello@amd.com>, <wiagn233@outlook.com>, <sysdadmin@m1k.cloud>
References: <20260504183649.165131-1-sunpeng.li@amd.com>
 <2349271.vFx2qVVIhK@timur-hyperion>
 <d988ded3-92e5-4900-b6d1-887a96891852@amd.com>
 <2381512.vFx2qVVIhK@timur-hyperion>
Content-Language: en-US
From: Leo Li <sunpeng.li@amd.com>
In-Reply-To: <2381512.vFx2qVVIhK@timur-hyperion>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF00001CE5:EE_|DS7PR12MB8251:EE_
X-MS-Office365-Filtering-Correlation-Id: 11bb42d5-cc9c-4adc-400d-08deac422260
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|376014|36860700016|1800799024|42112799006|32650700020|18002099003|56012099003|22082099003;
X-Microsoft-Antispam-Message-Info: No3WuJiyXyO7b8Vv2jXnvSeqXLlY/R2wuEntKfZ4USecJjr/CktXbxPKWXUERG4+fYnj/ylU8ox+3jykRou4cG7EraMjIVdWvWLvE5Y/00G0ix25Iwa5a0qlrOokADjAdEWi2/IUE8LXZfNVBnubFml09d08a3zi2qWO1elr0eXDyK4EqedSXOzCz8qC4gXCc1dPU6F0pT2lwXsuWVe7d9w2QDCk6H+Sx17u8xSIinlOeAUZcoVuI11F87tvJ9HZ6cwlaXcH8AnRv1co/vQ0OXem+4+gherGhCTpLN9wpCewh/rhuuVDOIe2Jh30pepQy5tW3VhT32wgpbWGfT+n7z72L0oyNU53UcFrkAODasNa1nPAxgnbD2Y9nFOyORtOUPeb1I5LmNm9/h6/w7Cb3/1qFRZyL+9ec83a/gat6iU2VL2thko4OmBh31lvw1QwAhN9FSYVlR/vC+4vqbBAqbOTSkfmWjgBUYyytEf9ZHC5PDhtr/ruE54omxgh99B9Qp2AraqwJW1xmS26ayQBWFRQZgGue4bVeFT6xnJzauJjpK/DtmAq/43K3tj/5+dQTBkgeCt04ZZp6QQbFa3Hd7zuclgImtaBjU7P8XdSJlKW+HXw2l7qQVl2RwLjhaDLaaHHmNeyUtK692bAXPXZzAkf7WIywuYQCIdS8KkWgtU61FhUE/BRvun+vhpqa1BUmp3ZM9U3AMZzKCKW8n1t3qRlfRy5U8OGFxYQMNHJKzc=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(376014)(36860700016)(1800799024)(42112799006)(32650700020)(18002099003)(56012099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: pudRFLgm0y21oU6rZAEVu4+vPfo4a0wChL2vny2SD2bupyjmVPpH6RN20YjhC6TQg/7zyHgyxTEww7FD1CqhdCd+dyGPJMMZAxwDzzBGhPqSSANx8IoUDQ8zvFOcnCODKmwiCENWipCuh6roC16/JbOJD94RzeM7Yu9C1YV7RGh6Cq9tVOAreY/JQ8YVjEsg0vvNHIKnLkqAeGms4NumtpECOZcX2jK4sTCUHOgvUu5+sz21Oq7XlVc7958yJ8inLLCcbWgq95lUFDfRtTxwhCcOW3gXauuKCpLkID3Vb5+BhqAApG6FPRjYDC38bN05oM0EYUBt95L2PGtrutLIuBfvyNmAaIuDe02h7Y0ZaNf38kR2PIHWZY9/MC7X9oOymlCKTa91o2DdCee1olEyRtnC8ZxByRIVlZPV+pAuVdjmQNOrXEUOWfzz4X8RpnGl
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 May 2026 14:08:37.6580 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 11bb42d5-cc9c-4adc-400d-08deac422260
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF00001CE5.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB8251
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
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>



On 2026-05-06 18:03, Timur Kristóf wrote:
> Thanks for the explanation.
> Just one more question: does DCN always mask the VSTARTUP interrupt under 
> those conditions or is that configurable?

AFAIK, yes. The masking is part of HW operation and not something we can
toggle (short of disabling the features that cause the masking conditions)

- Leo
