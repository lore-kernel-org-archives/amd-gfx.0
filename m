Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DEF8CF53D7E
	for <amd-gfx@archiver.kernel.org>; Mon, 16 Mar 2026 18:39:11 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7BCD510E317;
	Mon, 16 Mar 2026 18:39:11 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Vi7960E9";
	dkim-atps=neutral
Received: from SN4PR2101CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11012037.outbound.protection.outlook.com
 [40.93.195.37])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8B32510E317
 for <amd-gfx@lists.freedesktop.org>; Mon, 16 Mar 2026 18:39:10 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=i1bcGmXM65jRZIRV2kh1p2CLNAMvO4dZrGUuN3pGF+u5gqP0bcOQRBTo/FhL/n26Wvu4FOu6FON//Krtcy0z0nw33ie06wt3RhlXo9Osszs3LXaddP+cozr1ReXfm+Bq98O+HtVbWz+RVzyuZslIrPmcwQ9AsrAS9mxcv4r1aUO+7Il7mD8qbuFyyXu4Y6ikO3Vx7Vlg/Qm1x8X8dK7cHiVC3aQacTRmRLhTFDcJqa/0FBb8uIwRijQ59NQ5x218jTDnxEYuCcQiBkBMXsLioH9WI+0efcYw9p7h/wZgLB8zmuCdsp7PaTa+b/GiS93HBSzZfki121u1ofvcpJ+MsQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=p9tZXVXqDPkD+GPK6dCA2xZptPztrIBp4XnxJ6O+rj0=;
 b=KRRtoAz00RLyED4gfWama1fO/RaDQef6qNcMNWjmDzvQBPR/rniT2zXHg6n0k2LvVltUvQzHKBBMq5vxXFmC2ZykMqihY/JftGs9eCFASKyTIa4d0XVF7Y8o81VZ9PhV0fih+LdlqSzHegSw9gyRnJPu5C1fjGr1GudlLrIgtZmsn6VeVg0PhQNr9+Q8AnUZ58uFVtrzZ9vAufrCxyCGLz7ImyAyI48ByS24BTQPD2hN4KgFQ/n8464UnLe4CZJBAxJ5K4lhfcwOer3a0rtzOWMJsfBUNFwTNgTNoAk2Pbjs9Fi7c+afp95+//NqydePlBCz5TIOirDB1p058jPqvQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=m1k.cloud smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=p9tZXVXqDPkD+GPK6dCA2xZptPztrIBp4XnxJ6O+rj0=;
 b=Vi7960E9q5JaFY3l1RtiFToL15L/+Sa4p2uogn0znPGJ0KY0GkjS0QkIBETrQX41F/lqHYlxbzZikhzMYBUtFqnthAzI2JlFXwK0y1G91Z7RAP2mr1wQ/bebyUPIaHlbc0FAO80JBeEH6FssD9IEWrpknR5Dcg6BYK7ktrCTyUw=
Received: from DS7PR03CA0049.namprd03.prod.outlook.com (2603:10b6:5:3b5::24)
 by DS0PR12MB9424.namprd12.prod.outlook.com (2603:10b6:8:1b4::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.17; Mon, 16 Mar
 2026 18:39:06 +0000
Received: from DS3PEPF000099E0.namprd04.prod.outlook.com
 (2603:10b6:5:3b5:cafe::9a) by DS7PR03CA0049.outlook.office365.com
 (2603:10b6:5:3b5::24) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9700.24 via Frontend Transport; Mon,
 16 Mar 2026 18:39:06 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 DS3PEPF000099E0.mail.protection.outlook.com (10.167.17.203) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9700.17 via Frontend Transport; Mon, 16 Mar 2026 18:39:05 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Mon, 16 Mar
 2026 13:39:05 -0500
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Mon, 16 Mar
 2026 13:39:05 -0500
Received: from [10.4.13.226] (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Mon, 16 Mar 2026 13:39:04 -0500
Message-ID: <7a148774-3364-4ce2-9f55-2e77889bfb53@amd.com>
Date: Mon, 16 Mar 2026 14:39:04 -0400
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/1] drm/amd/display: complete cursor vblank events
 immediately
To: Michele Palazzi <sysdadmin@m1k.cloud>
CC: <amd-gfx@lists.freedesktop.org>, <harry.wentland@amd.com>,
 <alexander.deucher@amd.com>, <christian.koenig@amd.com>,
 <siqueira@igalia.com>, =?UTF-8?Q?Michel_D=C3=A4nzer?=
 <michel.daenzer@mailbox.org>, Shengyu Qu <wiagn233@outlook.com>
References: <20260217191632.1243826-1-sysdadmin@m1k.cloud>
 <f43075c8-e5f1-426c-b70e-743d1e7e4c59@amd.com>
 <84316e45-f596-49c4-b3e7-cdfc7a19a519@m1k.cloud>
 <bc9b30d6-3ca9-44f0-825f-82b1142c8b48@m1k.cloud>
 <2be6dc58-e2dc-4733-aa25-26329cd1d2d3@amd.com>
 <TY4PR01MB14432450DA5BDEFA272476A2F987FA@TY4PR01MB14432.jpnprd01.prod.outlook.com>
 <49434297-d6e8-4eaf-b4c7-ce14134d7869@amd.com>
 <96f4df42-2675-4bda-b0f2-753b09f7a80d@m1k.cloud>
 <ca869a77-4bdc-47b7-a8f3-788224be48be@amd.com>
 <fdb2d4ad-10e5-43ca-92db-f1dad48b7890@amd.com>
 <c4cae811-e3a4-4aae-8501-6de0977566a5@m1k.cloud>
 <6e1f5a30-82c3-4872-add3-7d46a266c37c@m1k.cloud>
 <6ac9fc7f-0493-446f-97e8-760a54e209d8@amd.com>
 <7fdc3c4f-c321-48f5-93f9-17a1a8ded9f8@m1k.cloud>
 <1356e93b-af76-47f3-afc5-29535a9518bb@amd.com>
 <aa3891fb-ed89-48e6-bfb8-86e704447a2e@m1k.cloud>
 <51219a7b-eeec-43f2-a335-06710809415c@m1k.cloud>
Content-Language: en-US
From: Leo Li <sunpeng.li@amd.com>
In-Reply-To: <51219a7b-eeec-43f2-a335-06710809415c@m1k.cloud>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS3PEPF000099E0:EE_|DS0PR12MB9424:EE_
X-MS-Office365-Filtering-Correlation-Id: 695a376c-d063-4372-ce74-08de838b4d69
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|32650700020|36860700016|376014|42112799006|1800799024|13003099007|22082099003|56012099003|18002099003;
X-Microsoft-Antispam-Message-Info: fvgKDo5l0NpiuZZm2hLaYFV/kLiuX/YYSmC2txKTMLxtDZCIFERzOvq45Bn+AL7BUlVvjlgepHyFefn/xzr4pdIqSqMhh8K80s3vssV40Q6cipNxMLGm/V1lu7HxO3wlp7UQ/zhkIeXZGNCvAxdPJe5NhhJddRS7t3bntej+7l60YMUMN8shu+gPmQCvbwgpdS/ALxXu0HI42/BSqMSIF4Plx/rrsGSS/DDWtOQruvBvbAUoiCpcj4SS+3RgX3cgbd4xblaEVcxJNnNl0cj2j38MKPFX8plT+jMTpQLDcWncrr+wtGZ87eUqLWuRtZH73eu6nWNTtGzzdnuSxCHQg42n3lR6+FV1EYjkz6YQVQcp7oQipbzbH8hZxBCPOD9S6P1TMrrMxrXJXK8fa4XVORkUzPXtQNjEWuBY+0o72VRyOX+MWZhHG0x/tiXf2vzDULKiQAmJQsAULf/2WaVH9HH9ogt0C6UyqtUF1bhh23cSO/+33Hwy6oTKFuj88Z2BOyMcpKoECGd62zbCAbwubexuQbFYSfEFvIScMJn6Hk8TLiJNvpIGl/9y4dBsYHCUiCDTIwvkqci8ypekoTCL4SMJ0InC1BMNvEl5jaViCENeC3IYagF07pAh88lSCy82S3djexyy0CSaWmT5//ONoaKnN15JoEOqBxTTbXRMK8SadCihpLzO/tT1i60Mb0HpHCyThRiaELH11LLWUk+bQw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(32650700020)(36860700016)(376014)(42112799006)(1800799024)(13003099007)(22082099003)(56012099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: JB2wjqOpoD/3jb+bnbYOhXu4YnRCrJmV1evJ5WOSrL2eeQ/i8DKVDAPv2ZC/hd9wMaYgZlQM32h/vxVOmmN4b4G8qihqRSpGIqP+tEwC7+unYX16kSZff2OKL3H4SkkjKgjTjnfzwPNpTSd6uWZyDpnbejxlkTaOwoUm/LBmEd5nTSTOHn02btWmXuaD8Iwc3PW2WFDpk3tso35Veb2/4NW2mZf+OZ8on/dHEPnrw9XjmeihRXGm+yMTOBdPPMsujworaMkhPwagKSSi7jjWPoyqyMsJtl0r0qCOpYoV2gsi5X2v0s4XENO4uEYMt26/Pp5UwBHPqAAD9Ko6TdaL9XmkArPNVxQBrkbgFdmJrOf5x7qYfk9yhUw7Ryudrhz3whE/HlK6Ob+BBpnjL58JLaxbPKY3185SJVOqVnc2mdD0MJEtf+eMR9leoSxZWc1w
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Mar 2026 18:39:05.5009 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 695a376c-d063-4372-ce74-08de838b4d69
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS3PEPF000099E0.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB9424
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



On 2026-03-16 11:17, Michele Palazzi wrote:
>> took me a while to get the umr output after the timeout (taken within 1 second from the flip timeout)
>>
>> https://pastebin.com/dz4tkfDV
>>
>>
> 
> actually there were 3 dumps in rapid succession, here you have all 3 for completeness
> 
> 16 mar 15.33 umr_dump_20260316_153356.txt https://pastebin.com/LvYrjw5y
> 16 mar 15.35 umr_dump_20260316_153540.txt https://pastebin.com/SmSvCXva
> 16 mar 15.35 umr_dump_20260316_153550.txt https://pastebin.com/BbsWbbTN

Thanks for the dumps, looks like interrupts were disabled, which is surprising
given drm_vblank_disable_and_save() was not called. OTG0 seems to be active as
the FRAME_COUNT is incrementing.

Does force-enabling the VSTARTUP interrupt on OTG0 revive the hanging display
once the timeout happens?

sudo umr --instance 1 -wb '*.dcn410.regOTG0_OTG_GLOBAL_SYNC_STATUS.VSTARTUP_INT_EN' 1

- Leo
