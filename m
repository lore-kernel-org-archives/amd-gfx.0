Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4F51ECD343F
	for <amd-gfx@archiver.kernel.org>; Thu,  7 May 2026 20:19:55 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E827A10F222;
	Thu,  7 May 2026 20:19:54 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="3a3Lu317";
	dkim-atps=neutral
Received: from BN1PR04CU002.outbound.protection.outlook.com
 (mail-eastus2azon11010002.outbound.protection.outlook.com [52.101.56.2])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 10F8910F222
 for <amd-gfx@lists.freedesktop.org>; Thu,  7 May 2026 20:19:54 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uw8sp2+oIwBeME08yAP34zJPh7Rjg2GHJK9nvQ5SjL5iCdLzoLiIugAqtca21+0zHLx+j0YOaBJQTwjpiGwx0lCNqxoJUJRzBrCWt46nWurk/wgWX+SKB/nA/+1PoKxzW1np0Wh9kYuPX1Sh7FQMDr4hsXrerTyO5ETkMa+kOtTrtWOtZO7F028urnUPdJ8+w/8AiJ9erFYWuXWAGtNuDF6TfIvWm/i+0SVsZ9VKSXKm8FzTrGN+NYNcIQX1q6ETW4CuEAH10yt3dok9bJwyJtbOIeT5Hcrh5zRCFHB8Xl8C1T/r8skz/70IuzN4j/JD4Ro/l/ArHthxHEoRKmne3Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pktg1DR5pWIEWvoI/6wjn9kR4xyVBQghNlVKhCKgCG8=;
 b=sGi2fcujQoZq1RgQlr1vJZKmnGMlOuYvPX+oDQFnabloMzZxRRt6GDrkOcEYfH8dzAtbu9wsijbblpWvG1VyxaHBrBkskUD2B997Cr7+vb/pk1YJ4rVhgl0gfRK0qGkbM/X91Wl5KSm6a79oanilNUMjNObwuFbYPg+18lPb9WRxr1HPBgssi/4fSKKIJMFkhEYgZ5Rrxp3xMPHpVzNXho8TIsz0Jfw7RaYURRAeCCQf1ZM7WjpdSU81g7yo9zW3vnxx7DAfca3WQ/zXosNZUheXHWnbyo+Zdp5Wi3Du7Ew2AN6CWREFix6gXl9wCaRTcy3g7GgpPcR/wQx8WMnIZg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=m1k.cloud smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pktg1DR5pWIEWvoI/6wjn9kR4xyVBQghNlVKhCKgCG8=;
 b=3a3Lu317fbTcjg+wv1bvAU0SFVmdXbGlYIHBUtSIrzffhWq8nm4092QRqTvUyI+xrWfiTcXkWzZPE+zoEFckxRDcfImTSPsymGmQEV2EwKZa05jtIDqlj551OwW1lxSu7kaZ8QXNs36RsVqTwnpoR/ehWs8/dGK+q2S1/9dbA2U=
Received: from SJ0PR13CA0029.namprd13.prod.outlook.com (2603:10b6:a03:2c0::34)
 by BL4PR12MB9533.namprd12.prod.outlook.com (2603:10b6:208:58f::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.25; Thu, 7 May
 2026 20:19:50 +0000
Received: from SJ1PEPF000023CD.namprd02.prod.outlook.com
 (2603:10b6:a03:2c0:cafe::f0) by SJ0PR13CA0029.outlook.office365.com
 (2603:10b6:a03:2c0::34) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.25.9 via Frontend Transport; Thu, 7
 May 2026 20:19:50 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 SJ1PEPF000023CD.mail.protection.outlook.com (10.167.244.8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9891.9 via Frontend Transport; Thu, 7 May 2026 20:19:49 +0000
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Thu, 7 May
 2026 15:19:48 -0500
Received: from [10.254.92.125] (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Thu, 7 May 2026 15:19:48 -0500
Message-ID: <184d937f-31dc-4d38-890d-e7d93d0efd60@amd.com>
Date: Thu, 7 May 2026 16:19:47 -0400
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
 <9c37520f-ad9a-4fac-bd21-e92f2107ca36@amd.com>
 <e4f72783-6086-4e7e-9de6-273ffbe743e7@m1k.cloud>
Content-Language: en-US
From: Leo Li <sunpeng.li@amd.com>
In-Reply-To: <e4f72783-6086-4e7e-9de6-273ffbe743e7@m1k.cloud>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF000023CD:EE_|BL4PR12MB9533:EE_
X-MS-Office365-Filtering-Correlation-Id: 97717dea-da29-4e99-bb81-08deac75fd9f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|30052699003|376014|1800799024|42112799006|36860700016|32650700020|82310400026|13003099007|22082099003|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info: 0Zthk1zF2JqxyJ0mdWMWAQqzPAQZFdypG0iz2SF1wkOnZAnSiTTGiCv1lqdc+4IxKNuogxEiYCHUHsJUQ47+NiX+RC/IhQQXj9WWclD7pzjh1TbdAj31anQntiPsXi5Y6pBwfmYsG2Pz+s1gxKkwIrBvt82LRiVmtjgIF/7rjKRs3XVallJk7M1T+2no9Gh6v77oaTDs+VR0ex/HgWSCy8R1aZZJZImy1mZoGwRm9m2445JflypLa2JSHJQkYUynPJxKdCnMSYcnqu36NoNyPDP2vdx8RhXl2xWRrprjf1ab2N/tbaVKemeuC0WxPHOZmnP1J68+VrlQDzlQ7n0CD/+kBdLBmsm7cg7mWO2XG++fdttADSnBDMbIXoegYjJlWsf3efatf/KVr8n81EuKLkPiKIdtDtuaBpSUQMpOpXRJ4ug+4qQlNh7n7Ya/V9YU9L5gIGmwlAb+GZZMTy7cdrUZce+6YH4eZGJ1RjrPg08y+hxNPBJVg+P95tcN2yq18gP7WTaaQwhJdz67LAMOkDcBTcgsKgRgs2E9dL/YCr+LvQ8JE3eOeDAdzBZiKljP5mSLndxbNHcgOP4qjBphl0LBM4OjxPZiXY3At5RSmGCCnyDR8XbI7iL2UA9qku73cTeqyxNMHgXWKgFstZ1Mgt6328N0xR+vgkr7MJTD4IuhUqHOy5+WUiXxsI8wCOim
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(30052699003)(376014)(1800799024)(42112799006)(36860700016)(32650700020)(82310400026)(13003099007)(22082099003)(18002099003)(56012099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 3QbcpJGTORg7JW7YxDdk9bmSpOFxrgGzZLq2DMWEfgSqTgo4VQ8+ANkwpmYkIjl0GucFodK6g/BIjuJ+Lbl/VmNRceQMLZ87CUZDlXXo+fhAjv9dEKv4ovyjK0YhRqjKVL49cvKGFrji4038HumMQ6IKZOV+QfwIDc5GC2ZwgpPJgPG/jb12QvaQUmlAOoLf0boQhsGIr7UsLZ5otvM59NXKQu0A+u9BQwQxOpXmy3SvFXDDHqPEmOIXdxc2O9fe+HduqMbqnlOThEX1Zv6V8Yjf8pMaouw+zmdDanEPNaLi6+J1BLs61frzuMuWe0CjQENrPgPnACiUTWsQURHIjQToNnOyB2zaaDT/+nuQMc4aIhBKB9c9rzFE8fouJvLscFlYmSg4PDt/mtO1hOFBD5uvQyJtSnoh8SyoKyVhpmq06CG62wKqkkoXssXItqxD
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 May 2026 20:19:49.7991 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 97717dea-da29-4e99-bb81-08deac75fd9f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF000023CD.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL4PR12MB9533
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



On 2026-05-05 03:27, Michele Palazzi wrote:
> On 5/4/26 20:48, Leo Li wrote:
>>
>> Hi Michel, Shengyu,
>>
>> I sent out a potential fix here: https://lore.kernel.org/amd-gfx/20260504183649.165131-1-sunpeng.li@amd.com/T/#u
>> If you get a chance, can you give it a spin and let me know the results(*)? The issue remains elusive on my end.
>>
>> (*) Of course, make sure the Restore 5s vbl offdelay change is not applied, and that no other debug patch/kernel cmdline are applied.
>>
>> Thanks,
>> Leo
>>
> 
> Hi Leo,
> building it right now, will let you know how it goes.
> 
> Michele

In the event that you do hit the timeout again, would you give this branch a spin?
https://gitlab.freedesktop.org/leoli/linux-asdn/-/commits/lileo/flip_done_timeout

It contains this patch, plus some additional debug dumps on timeouts/dmub hangs.
In the event you hit the timeout with this branch, please post the full dmesg.

Thanks,
Leo

