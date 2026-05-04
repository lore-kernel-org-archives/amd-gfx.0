Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9AD17CD3427
	for <amd-gfx@archiver.kernel.org>; Mon,  4 May 2026 18:48:46 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3A1CE10E7F8;
	Mon,  4 May 2026 18:48:46 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Ona53lyv";
	dkim-atps=neutral
Received: from BL2PR02CU003.outbound.protection.outlook.com
 (mail-eastusazon11011023.outbound.protection.outlook.com [52.101.52.23])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A087110E7F8
 for <amd-gfx@lists.freedesktop.org>; Mon,  4 May 2026 18:48:44 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=eJXiw2+jEUo3q1A/sSdKcdo90sgNWacnhrHhDr/nVlf33LQbxTUKBt93L/zMxGcDX4WWZgJvo9jy9kr7W5HKhzXTlcdp8G1eC+buqT+BsVeiSGlNcmz9aWEUwPWL5IgfSt+Crj1Z3p2KdoOR8q+sxKEUN2SQ+3wphQbURvu1eDRyOXsDGtqlEzfsQk5xwNv7G5Ce+/Mv3lFksdmVhjEdw5t+4S8dB4KzW75QlmdYmSXNLFb8wulMgTfB7uLyP1V7iAKsT8LSwZcM+xsbp0zJRCdRFB01WgT4jASjDjszJi2v8jLHS9O1RgQ3UYPkh2Eq8yk5NG4qr4ky0RFpZJQRBw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0suEX+yBg7iP8RdGJwO53jHgIchf/CBjc5+uoRE5kHk=;
 b=QTLu1fzFjszpDMe6dlTsyfVLE59jIQSV6HqhbcNfXnpkA349wIXt3a5vH87oSyI/f9GBTv2s2v1HjRaEatUH+L41sjnJYujJnMTu/zTp/gvgEZvas7ntG9MINKGzMh/8XfWKPs4pbQBaqe2llA3TE7V3P6fMIXpRYP7QPzxwWeSVxP20s5HJOmaaZYoWwepFohnRL8r6I53g//YJ0jy3Tm2ECoQY+DoQx23YFPDPRpBx8k0vKNSJm2ceLFdZcD9ouO3QJ8snChJ82d0BSI6goSC8HvfZ94HL5wnzSrFC0sHIc7HsYcCUgrWx0d6pux6mu8Ia4runujqn+lihcsYnFw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=m1k.cloud smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0suEX+yBg7iP8RdGJwO53jHgIchf/CBjc5+uoRE5kHk=;
 b=Ona53lyvEWUOTaAXE60uiG6zPfIsCjHbH9jzVXWD5ZKxWWXYzPRhVh80Xegs3bNCY4uxmZUJyKHmGKlBS4bm1zAqY+o+1DRbLkKxMLAKAesf4U+ZJp6yklydih2UNZ0sPr/hT1z2nUqjzSzMsbqRMW68cEGib5PVLleJc8LY6Bg=
Received: from DS7PR03CA0051.namprd03.prod.outlook.com (2603:10b6:5:3b5::26)
 by DM4PR12MB5793.namprd12.prod.outlook.com (2603:10b6:8:60::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.15; Mon, 4 May
 2026 18:48:39 +0000
Received: from DS3PEPF0000C37B.namprd04.prod.outlook.com
 (2603:10b6:5:3b5:cafe::f8) by DS7PR03CA0051.outlook.office365.com
 (2603:10b6:5:3b5::26) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9870.25 via Frontend Transport; Mon,
 4 May 2026 18:48:39 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 DS3PEPF0000C37B.mail.protection.outlook.com (10.167.23.5) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9891.9 via Frontend Transport; Mon, 4 May 2026 18:48:39 +0000
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Mon, 4 May
 2026 13:48:38 -0500
Received: from [10.4.13.76] (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Mon, 4 May 2026 13:48:38 -0500
Message-ID: <9c37520f-ad9a-4fac-bd21-e92f2107ca36@amd.com>
Date: Mon, 4 May 2026 14:48:38 -0400
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
 <7a148774-3364-4ce2-9f55-2e77889bfb53@amd.com>
 <a8a3d8d1-ee55-4fc0-ac98-45d70ad0bd6a@amd.com>
 <deb792f8-70a5-41f9-bcf8-1425994aad14@m1k.cloud>
 <4e48ec7b-ac73-4637-9e42-9c328067ed72@amd.com>
 <fe88c29c-3fc3-48b5-b6a2-ee4c210e7a83@m1k.cloud>
 <e415c38b-4102-40e4-a195-0256caf34802@m1k.cloud>
Content-Language: en-US
From: Leo Li <sunpeng.li@amd.com>
In-Reply-To: <e415c38b-4102-40e4-a195-0256caf34802@m1k.cloud>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS3PEPF0000C37B:EE_|DM4PR12MB5793:EE_
X-MS-Office365-Filtering-Correlation-Id: 87c5c3be-ee9e-4d69-c3c9-08deaa0dc194
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|376014|82310400026|32650700020|42112799006|1800799024|30052699003|13003099007|18002099003|56012099003|22082099003;
X-Microsoft-Antispam-Message-Info: vThjZ2ex3GC0BDGcbppnHGU6KeiJhGjBsumVybOV1sORwvQnoBaZgtNa1ptE0by11h9halK+waMyOungkIwF3fQurUtjYgKtTeaLdZSw9jJs59jmvveYPyP4XQHEO8kTupUNcXDPKui/4MuaFtu7mq/9jSw/gX6nYLfsk8ef3dscwgDUniB/lQLPj7HeSur2I0sO5/0OInUzwT6sS4RDqpO3+vyiWnR5REu+QfhQ5yJ8f67roS9XSFX74/RpcCvsGNLM+q5IIf9U14RA6Fgzjp5iVLX6pGMVLzI4OXCnpQ6tQZ0ImS2gKdhKjkk/53u4uDlF8FpONOcNXIB6VdSBXoDHhQQISZgqU7Z7lz/1Af0a2CzfnXdyYDWOmV2u1ZARn8qtMimGMN2rvbIpSNnAJTfzHc30qKRuCyYD0krMVTGCwjoeb88qmWOmFmaA3xHoVBNaukS1BKxQ2wK9o2VfUMtETmvf8DY5FezUymKaWcWtwHpIdzBxX0Z/x0FQN7sNnqibJytoIbCG57rGhWPrZ+aqHCBNKgnURUZHvDWZoVy7HaXbZwk8hKcf52pN6/616HnMxPLq9wOyuV3gZxdgYXJHxGVLzX2O1ZxUoB8uw5shjTkTRFJAO18Um1YeBu/ErK2fePfA0rPX/rU+6STMLBkpSymUgHlow7aVCJdg1AJHKGkbFC7dji5Tc6h0XXqFrsZynEfmzV6gZLXV59HLO+2IUMAaTgtDwlfcudiWziY=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(376014)(82310400026)(32650700020)(42112799006)(1800799024)(30052699003)(13003099007)(18002099003)(56012099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: oBftHWsEIKtSH/WS0cBI88OTKZi8Z0AvBqDLM0wMTWwZe6iAySDqn8/+902LKYEkG3Yq7SyoXWk3/H8/51YPv76qSOctIoDvQUa/m+T1fiHUwJTJEFB06mKJ9Yuy2rg9xRfWgCoyRhXHw89TjsyWcrYViOImYer0ntWIoBqtrH0AjwkZQkFllpNA7BVyccDtyXO84ceFb9aV3biMut2gwSJcOak/mAbXrH+GPCjR9yqxAsGSI7tl20i5cFSh53zIdnbn6/MYOrltI77jZLnE1j6Vq9EE0E5VnPlRNw8Hd0NQZC1wIXdC98OEuf5Jvueryqw3MGRUx61KSGHcB8vYJN1KLu6LA7gzsZB6mMbiCBJOln0Wf9GiQmJROetXLcBDLMJp/+M5M0o0JPbr39+Z3eBtk6H6538UNMcJT51TLljEMa8SxjCrCBV/zL5Ed+wi
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 May 2026 18:48:39.1440 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 87c5c3be-ee9e-4d69-c3c9-08deaa0dc194
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS3PEPF0000C37B.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5793
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



On 2026-03-31 08:57, Michele Palazzi wrote:
>> On 3/20/26 01:52, Leo Li wrote:
> 
>>> Did you happen to try disabling some idle optimization features mentioned in a previous reply?
>>> https://lore.kernel.org/amd-gfx/1356e93b-af76-47f3- afc5-29535a9518bb@amd.com/
>>
> 
> 
> Sorry for the delay i have been away due to business travel, anyway since resuming testing i can't seem to reproduce the timeout with idle optimization features disabled.

Hi Michel, Shengyu,

I sent out a potential fix here: https://lore.kernel.org/amd-gfx/20260504183649.165131-1-sunpeng.li@amd.com/T/#u
If you get a chance, can you give it a spin and let me know the results(*)? The issue remains elusive on my end.

(*) Of course, make sure the Restore 5s vbl offdelay change is not applied, and that no other debug patch/kernel cmdline are applied.

Thanks,
Leo

