Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6A32DEC0477
	for <amd-gfx@archiver.kernel.org>; Tue,  3 Mar 2026 09:02:22 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BB58810E798;
	Tue,  3 Mar 2026 09:01:57 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=outlook.com header.i=@outlook.com header.b="bXBNH/cy";
	dkim-atps=neutral
Received: from TY3P286CU002.outbound.protection.outlook.com
 (mail-japaneastazolkn19010004.outbound.protection.outlook.com [52.103.43.4])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EF6C810E65B
 for <amd-gfx@lists.freedesktop.org>; Tue,  3 Mar 2026 08:17:30 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hNqQZ12kp+mL4bEH1tIceIyQylcooAhWbsRrPvjbx4Xar/w+sec5bx/ioK9UdoKIGGJrLzI8EaMQ9183X7jF5YsGI/fhEtCbtlHmauyUApXjPalSOtxzUrJNIXmDoBFsLyEvwRz5d1PJmUAtIY1ZKIzcaYniuuGtblKnXySeJ2Zi1YGvbJkKlxeKplznWQcSg9JRMXqiC1FamHh24cbjPxQ/vABtD6PqX/VJ0JTIUVHU+fqZeP6yClxekZ8y5s0AXAqGvBJRZnsdzdTTP/FEJ01o/nKMSUB2ceWq7SLV9pxebV7st/mhUj1BfjUHqut7yr9D4b59aXx9sFTz2LZgMA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SJpA4faPT/bNLgdFc9emCe966wxg4E2M5HpMxja9yJk=;
 b=WaNtut6mV0Dr+sgLfqgV6o8MaNY8db/1TpGGLIl8iOx+tFmwhayCo/t+FVQ8unNvJintkAQkOO9yNvtRpojqXpQT3ZK+lbAlrcKidACkmm1oo/wwWpcTsmCPZYyL3KIV+4Y5UhK/4LBU1dJLQEwxYPn2wuyPUmQVJ8JhdTC1PK9PRReZjhWhvllBAYP9oD8LBB6fwiV0YKq2Ve20IoYvu/SiaflTUErzZHVUKhpTPLuvTR0yhrtty+v9oUTslq0CDbyjHctws5jrMTomKJbh2d67xfP98C2dxBgoDN7sR4K56LVux3EbmiRl1yQtSE2iU1H3lforRjFnptNFA5wt0A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SJpA4faPT/bNLgdFc9emCe966wxg4E2M5HpMxja9yJk=;
 b=bXBNH/cyGP5DguXONqTKE/3WVxzM0D3Akh2NiGT2yUmM/we0cMsecH/Qkd/0DeFjse1N/zv/01zP7XyqUGh1MnZVNXY0+3qQmeZJ4LY71L538vfLDBCfT4MEP4Whw5AcTRLWvOyovIqlHeAPMg8iFWZ1gq4WnyMVJyKi/LbtyvB24WGDEU6P98PRTg7S4iXAnr6pmC+vDnhGFpieJuzRbwj2gZfpuJch4B8evemYU/TaXRlDAGZAZbtEbcQowGSJtS9BprGQhDoDXXDQZuy6GKJudKCyqVJLdWp9ud3eSJliFDtQ99JqhhTXHN9ENIWSxWU7+T+zJyuaGkHbybTAIw==
Received: from TY4PR01MB14432.jpnprd01.prod.outlook.com
 (2603:1096:405:235::10) by TYCPR01MB11205.jpnprd01.prod.outlook.com
 (2603:1096:400:3c4::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9654.22; Tue, 3 Mar
 2026 08:17:26 +0000
Received: from TY4PR01MB14432.jpnprd01.prod.outlook.com
 ([fe80::de2b:6c81:9bd7:99c2]) by TY4PR01MB14432.jpnprd01.prod.outlook.com
 ([fe80::de2b:6c81:9bd7:99c2%6]) with mapi id 15.20.9654.020; Tue, 3 Mar 2026
 08:17:26 +0000
Message-ID: <TY4PR01MB14432450DA5BDEFA272476A2F987FA@TY4PR01MB14432.jpnprd01.prod.outlook.com>
Date: Tue, 3 Mar 2026 16:17:20 +0800
User-Agent: Mozilla Thunderbird
Cc: wiagn233@outlook.com, harry.wentland@amd.com, alexander.deucher@amd.com,
 christian.koenig@amd.com, siqueira@igalia.com,
 =?UTF-8?Q?Michel_D=C3=A4nzer?= <michel.daenzer@mailbox.org>
Subject: Re: [PATCH 1/1] drm/amd/display: complete cursor vblank events
 immediately
To: Leo Li <sunpeng.li@amd.com>, Michele Palazzi <sysdadmin@m1k.cloud>,
 amd-gfx@lists.freedesktop.org
References: <20260217191632.1243826-1-sysdadmin@m1k.cloud>
 <f43075c8-e5f1-426c-b70e-743d1e7e4c59@amd.com>
 <84316e45-f596-49c4-b3e7-cdfc7a19a519@m1k.cloud>
 <bc9b30d6-3ca9-44f0-825f-82b1142c8b48@m1k.cloud>
 <2be6dc58-e2dc-4733-aa25-26329cd1d2d3@amd.com>
From: Shengyu Qu <wiagn233@outlook.com>
Content-Language: en-US
Autocrypt: addr=wiagn233@outlook.com; keydata=
 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
In-Reply-To: <2be6dc58-e2dc-4733-aa25-26329cd1d2d3@amd.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------8nEDaeiE1b0mh6D75amhyvMW"
X-ClientProxiedBy: SL2P216CA0078.KORP216.PROD.OUTLOOK.COM
 (2603:1096:101:2::11) To TY4PR01MB14432.jpnprd01.prod.outlook.com
 (2603:1096:405:235::10)
X-Microsoft-Original-Message-ID: <55036e76-59bc-486b-9f54-3ba085717b3f@outlook.com>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TY4PR01MB14432:EE_|TYCPR01MB11205:EE_
X-MS-Office365-Filtering-Correlation-Id: 84c7332a-c88f-4885-dc9a-08de78fd4d70
X-MS-Exchange-SLBlob-MailProps: a+H6FLLcF3qkJ+BXrfQxbsvYfyGqqDaQ6J6XUinwLd7pzm9H92qQZQO3aswqwKKltMxdnNT4pwrcTehOPPkQFPcxwHxer3peF7I3PNfqmZ2AonZVn1ZEcHJ97FtGaxFCmvHqCgxIcN9fP5RozrOf7cNpTN+/cOWyGK4Z6BtpCJeeD48yPPwHNtr9TG8+olnSvX8vKS+uUxjxzWag+5NEr91R8pbuIxoqSkR3Q01+TA61/DULOCLNsm/nwsT1jdgVceRuu3LZLUbHwPVxEqr1APamIhQN0MNNsTZP5/nQO1Zpu9vRxxASRCGEQZ2GnVgwHOCsXHovd9aYk2wMibTtL6xJ7zYlEWOtJgmMt4ZwRh8qz6HeF6gDMGDy7QSRweudB65JdLtSJIAgmKZ4iXiSNeZCFg3CnW64jV/Npj/uKi3C4cRVvdCV9eT+cJWAjP/1T5Fk1tt2xJaVqR5dyQAcJPnL9HarsBCWQXGRC/ysBFgzB6QZVqpBOWM3KFPU5c5ug2sF8ynVvMjIolNnhZQu/IIRQeXwGv52yg5wtEqn9wxCMa6FQcLNjrvxfz50EV7ZpQ+bX7/1WljOj6ZhtV4o2qgmZURV3MygZw2HFy2eqaBvi2F5GUfTwX1mdrF1259vuJ4Br6ea6LEDnyjbeAfhW/5p5aOf3iddQbGkvV+9MRMt0wsEk47SNKIoKpUD1UNX660X56rbMLDyh1wzVzngTvg448lfQ4bGMkdAnhnVFEtwAfpZ6l5qCn0Wz5JZSAcuNCuVS6L93+sTjllU//t58icRZptu7fXYk8iOZ97ES849HcncPjL/KyU7lLyFXYb/
X-Microsoft-Antispam: BCL:0;
 ARA:14566002|12121999013|15080799012|23021999003|6092099016|19110799012|8060799015|5072599009|51005399006|461199028|440099028|3412199025|26104999006|20055399003|40105399003|1710799026;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?YVBXdVBud0Q0ZHFRbHZ6enJPRUJCZWJteWNrSHpXWHVZendLRlEwSzRhVUd4?=
 =?utf-8?B?ZkFJTTh6aURldDlVc1A5c1c0bGhnemFFWnlHT0JJc1pHZjJNTlZydnRrRzhY?=
 =?utf-8?B?S0NmU1NYOUlZbHEwRW90RUdPeFV1WVprMTUrMVBEOTF0WU90OXowZ0NFRzd1?=
 =?utf-8?B?c0hKTHZ3V1RXNTdlenZJUE10RjZDd2RNdUNydGR1Q0FvTUtNS0JOU3RsdnN6?=
 =?utf-8?B?UktQZSttakFOZ0I0aVZMNUpDa1FMMTFaL1kwTkFyKzUrUEpicGVyQ0J4dEMz?=
 =?utf-8?B?cldIUDJrSFlLeEZDWHFRUzdXZ25CYkdMUWQ4NFk1eDJBTHNrMyt3TFJIYnJL?=
 =?utf-8?B?Y01VQ2puMXR2RzlUWGplenh4dlJJeGxtUEhRV3FMMEtIUVJnNW9mQkMyOGFS?=
 =?utf-8?B?cUlKWHpRT1Mvc2dpdU9VOGtrVnNncUI3clhqQUZNTWFQWFFqa05LcEo0YitM?=
 =?utf-8?B?dHRjMkhCQitEaytKK2ZKc1NGYllpZjRJL1R1MEV3bURFbG01R0hYQ0JHV0xw?=
 =?utf-8?B?dXliQmN2QWhpNUNJMFFhNDF0MHJVd3VLMmg4bTlrb3hMa3FuRXJZeG12SU5V?=
 =?utf-8?B?T2VkZzlQTjlFckdiZ1Q0OU8xejZVRndHZW9jd3lDd0xCN3VFMW9Yb1VUMVBa?=
 =?utf-8?B?RVNvc085eitPVWJzUVpqYlZUVHFHMU5CbVdVcCs3YU94cTdiU0gvTzFVeW5Q?=
 =?utf-8?B?QzBqbE9JSzZNeFNES1RnT3dCQkdSUkVqVHpPVDR1bTBkSGhaMnlPUTBDcHg1?=
 =?utf-8?B?bytvRjc5WjNjdTNyWFFHSVN3RVVhWFZ0c1hSVWNDTTNOQVVBUGdLcElMNE53?=
 =?utf-8?B?M2RpcTlVZ3hSRVZwdlFKZEpNMjY0RHZwNVpuQUxLZUdMV1kxbmxINzU2VzRZ?=
 =?utf-8?B?OXVwVkVkdkZIcGUrZHdBR095UmpuZHJWdXh6VjdSWnFCYzJ1SHlBcStVajlo?=
 =?utf-8?B?UnVEajZYekRma2xlYi9HMDFTUjFUY0VNTlZBdmhXUVZXZVFUa1FRRkhWR0tm?=
 =?utf-8?B?dmdBYndSNlhZLzhlWGx1SytVVEViNEY3OWtOUkdNNjJmdVlueUFqdDMzZlBF?=
 =?utf-8?B?ZDhIdTFWOHFJOEY5b0cxOHV0bmJPd2tvS3ZUd0JSTHB5UWJRSDBwMFEzN2Zj?=
 =?utf-8?B?b3Y4QXBobWhYSWhUTytlOXM2aXlUUnlwamJNa3MyRHZ0MkU5Y3NjWVdPZ3NB?=
 =?utf-8?B?Mk9iMWl6QzVqa3kzZCtzY1hRbUluMUVTZzg5bkh1Y1FSTVZwZFpZY1B1eDRH?=
 =?utf-8?B?TFhzYjZGYk1peTBGZXpwSE0zWVloUWxxUzRaTHdXU0FqRDNKT0NOUzVldnZB?=
 =?utf-8?B?SFBqQ0tIRFc3YTRjdW1aODlncmpGYkd1VitaUC9MUldLRTRlMWF5QVd6cXR0?=
 =?utf-8?B?a3ZaV01OUXhhOGNMVU9ETDY4MVU2MFgzei9GNDhSbjNERm1YdDZhYzV6UjNW?=
 =?utf-8?B?ZkZYVHpGN2JwYm9vRStJVHdpRmRzRmJJSVROb0dsYWlIQkgrOHFEZ24rYlBW?=
 =?utf-8?Q?Q26Cr0=3D?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ejJ6Vkh2MzVEZi9KT2FxaWt4TjltS01Uczl5Qi9xZ0x5MjVQR1IzdmpjQUxG?=
 =?utf-8?B?SktvV1VSVVQveCs0UzdMNllNRE13K01oNlA2MytkUXcwSFcvdWREQUJmeGdX?=
 =?utf-8?B?YVhpRWJJR2NJWnhOSjNiamxLQ1R5dlpidTl5NTVhWFVNbFg3ZnhWeFRJY3hB?=
 =?utf-8?B?YmdZQjVndDBsd2FKVmljUnA2aC9oTnA3Uk54N2FtSnJLYVRyNCt1aURCSWI1?=
 =?utf-8?B?clN5QnJpWDBNRjIxcDVRZ3h2KzlWdE5JL2Q0ZmY2dFd1bUhnN1pBZ0hjdGl1?=
 =?utf-8?B?eUdIU3oxY1oyVkcyTkUyOHVNTmkzWXVoamhWazM0VUlhOEhCaS9XeThIOUpC?=
 =?utf-8?B?UC9HeW5STVZ4aFJNaTJZWXNGT2FpQUZMWFNrdnVtK3hkSnQvZlk1ZDNpUXJm?=
 =?utf-8?B?NEpORFd4eExMTGJwTVlDN1ZwQnVadlBuYWhvQkRWVE15YU4xOTZURmlxaEUw?=
 =?utf-8?B?TTVlTkdFekROb0EyUUNlWTk0Z2N5cVRsKzRuTjVScmlUVHZUcFNJK0I4Z2dZ?=
 =?utf-8?B?OHY5U0hFZ2g0Tit1SE5CcG1hVm44N2hjb3BXbVR6MzQwWlBkUHg0RHVscEZX?=
 =?utf-8?B?Y3o4UGhDV1krSjAzQk1JR0JKOGtxUTU1U1lHNS90V1ZrOGZrNmt1eTdWZlox?=
 =?utf-8?B?UlJ1anhMVFJCQ3BOU0ZZdTNFRlRRWUE0T1hid2grNUZNcFJmU2hoQ01GZFRu?=
 =?utf-8?B?RmxDRTZ5YkRZc0Y5K0lWTWFJZXYvKzZiNHJvMkNKdVZKWHdTWmNiYzZGNS9v?=
 =?utf-8?B?SXgzY2RFM2xsNVk1dUxEa0o4L0hWbHcvaHE2R1BFSXROcDBYTGpzWmhXWFJs?=
 =?utf-8?B?ZFJENm1MYnVXa0M1aGFkd280MWhFdkIzNEc4QUxGMlg3aHR5S0c5aXh5S0tw?=
 =?utf-8?B?S1lkSHhna1MrbERrZnBWdXZDMFM2TVczazRsOW56TkxOQkg4VDV1ZzBRZjNQ?=
 =?utf-8?B?MmlLMi9QM2RMM3BPVjczTUw2VHpBajMyWWIxeE9adU1Nc2cwMGM3TElHMmdn?=
 =?utf-8?B?ZlpOVEE4alA2eWZiS3VCMmJiQXk5WEZQc2FMbndVS0VMQmNzN09VNnVlaHpn?=
 =?utf-8?B?OW5VcitGdTJuQXBEMW1oVVVUSzBUR0YwRUlCL2Y3WkRWSXhDU3ZIdHc0azlC?=
 =?utf-8?B?SjUzamxUOW1OMzZhSWVxVElUMzgzN3E2NzVVRDQ2alFhUkl6bTB1TWxuMlFX?=
 =?utf-8?B?ZzF3bUNOTmxhRzdZS0hXdjNHak8vSWpXL3BuTDI5alVQU05haVNmZjl2Qk5M?=
 =?utf-8?B?Q1hZOFNIdVd2aEZqZURoMUI1MVcwdElnYUcyaitiQ2lJZDk2RHNqM2EvWmNn?=
 =?utf-8?B?Y21mWDNDWVVKVWlRejljMVFYaTBlSVVHRUxrNFlSUGZSalBUcUdwS25NUXRn?=
 =?utf-8?B?WityTFlDVWM2ZUM4dU9yUjdNVHlaSXdTOWU4RHhPOTNxRUg4K2R3Z2VyVk9V?=
 =?utf-8?B?eXVPRG0wZ1BQUzhsZFdJT2p5ZkRRVUQzeUd5N2hkeDQ3M1RkM3F2eG5uQ3dl?=
 =?utf-8?B?d0FhSW1oODdqK1ozWGxVVmhCejJtcUUzVjE1aFlkb0d6VDBoR0lpVGk1Mnpn?=
 =?utf-8?B?WGkvUzRmNUFDb28wQjZMNzU4cGhrM0VMMU9QeUhwSEw4WmgzNDVKREdKalZ5?=
 =?utf-8?B?YkFtWUF4UHBpNU9uWUR6cnlwNFU5ZE1ZaEl4N3FYMmlJSmwzMFk3cUpaVlh3?=
 =?utf-8?B?VXFrWnNLZnFFNllGREVWeG43Rng1T25RakNyU013Y043QmlzcExZTVNQSkdn?=
 =?utf-8?B?M1lRajhpZ0Q5OVF5SDFhODNkbVZMaGd6cFNUbmNDNEJ0YXRNMlhNMnRrQWJY?=
 =?utf-8?B?WFdDUWp1YUVnUm8ycHZTalAwNG5UTW9LbnVoUnhjQkxKczVJQXhLSHMyblJM?=
 =?utf-8?B?dmxHY0l0WE1jWHl0R2oxSE56VzNqVW1ra3lIV0VEZ0Q0OVlVV1dia3A4YnR3?=
 =?utf-8?Q?C/a+ZIewIi4z0ViKq1yOSZI3qSgrZ/IN?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 84c7332a-c88f-4885-dc9a-08de78fd4d70
X-MS-Exchange-CrossTenant-AuthSource: TY4PR01MB14432.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Mar 2026 08:17:25.9985 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYCPR01MB11205
X-Mailman-Approved-At: Tue, 03 Mar 2026 09:01:31 +0000
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

--------------8nEDaeiE1b0mh6D75amhyvMW
Content-Type: multipart/mixed; boundary="------------BUmbr4iFKTcdobBoFcTLYjZ2";
 protected-headers="v1"
From: Shengyu Qu <wiagn233@outlook.com>
To: Leo Li <sunpeng.li@amd.com>, Michele Palazzi <sysdadmin@m1k.cloud>,
 amd-gfx@lists.freedesktop.org
Cc: wiagn233@outlook.com, harry.wentland@amd.com, alexander.deucher@amd.com,
 christian.koenig@amd.com, siqueira@igalia.com,
 =?UTF-8?Q?Michel_D=C3=A4nzer?= <michel.daenzer@mailbox.org>
Message-ID: <55036e76-59bc-486b-9f54-3ba085717b3f@outlook.com>
Subject: Re: [PATCH 1/1] drm/amd/display: complete cursor vblank events
 immediately
References: <20260217191632.1243826-1-sysdadmin@m1k.cloud>
 <f43075c8-e5f1-426c-b70e-743d1e7e4c59@amd.com>
 <84316e45-f596-49c4-b3e7-cdfc7a19a519@m1k.cloud>
 <bc9b30d6-3ca9-44f0-825f-82b1142c8b48@m1k.cloud>
 <2be6dc58-e2dc-4733-aa25-26329cd1d2d3@amd.com>
In-Reply-To: <2be6dc58-e2dc-4733-aa25-26329cd1d2d3@amd.com>

--------------BUmbr4iFKTcdobBoFcTLYjZ2
Content-Type: multipart/mixed; boundary="------------Be7nZvoRhaKPxEOg6brQ4Vgc"

--------------Be7nZvoRhaKPxEOg6brQ4Vgc
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64

PiBIZXJlJ3MgYSBwYXRjaCB0aGF0IGluc2VydHMgYSBmZXcgdHJhY2UgZXZlbnRzLg0KPiBo
dHRwczovL3Bhc3RlYmluLmNvbS9kcExuVlNidQ0KPiANCj4gQ291bGQgeW91IHRyeSB0byBy
ZXByb2R1Y2UgdGhlIGhhbmcgYWdhaW4gd2hpbGUgcmVjb3JkaW5nIHRoZXNlIHRyYWNlIGV2
ZW50cz8NCj4gVXNpbmcgdHJhY2UtY21kICh3aXRoIHN0YWNrIHRyYWNlIGVuYWJsZWQgJy1U
Jyk6DQoNCkkgdGhpbmsgTWljaGVsZSBzYWlkIHRoYXQgdGhlIHRpbWVvdXQgaXNzdWUgd291
bGQgYmUgbWFza2VkIGJ5IGRybS5kZWJ1ZyANCmR1ZSB0byBvdmVyaGVhZD8NCg0KPiANCj4g
ICAgICB0cmFjZS1jbWQgcmVjb3JkIC1lIGFtZGdwdV9kbV9ldmVudF9hcm0gLWUgZHJtX3Zi
bGFua19kYmcqIC1UDQo+ICAgICAgdHJhY2UtY21kIHJlcG9ydCB0cmFjZS5kYXQNCj4gDQo+
IFRoZSB0aW1lb3V0IGNhbiBiZSBmb3VuZCBieSBzZWFyY2hpbmcgJ3JlbWFpbmluZ193YWl0
X21zPTAnLg0KPiANCj4gUmVnYXJkaW5nIHRoZSBkZWZlcnJlZCB2YmxhbmsgcGF0Y2hzZXQs
IGlmIHRoZSBpc3N1ZSBpcyBpbmRlZWQgcmFjaW5nIHdyaXRlcyBvZg0KPiBhbWRncHVfY3J0
Yy0+ZXZlbnQsIHRoZW4gSSBkb24ndCBpbWFnaW5lIHRoYXQgcGF0Y2hzZXQgd291bGQgaGVs
cC4gSXQncw0KPiBpbnRlbmRlZCB0byBzb2x2ZSBhIGRpZmZlcmVudCByYWNlLg0KPiANCj4g
VGhhbmtzLA0KPiBMZW8NCj4gDQo+IA0KPj4NCj4+IGZpeGVkIHNpcXVlaXJhQGlnYWxpYS5j
b20gY2MNCj4gDQoNCg==
--------------Be7nZvoRhaKPxEOg6brQ4Vgc
Content-Type: application/pgp-keys; name="OpenPGP_0xE3520CC91929C8E7.asc"
Content-Disposition: attachment; filename="OpenPGP_0xE3520CC91929C8E7.asc"
Content-Description: OpenPGP public key
Content-Transfer-Encoding: quoted-printable

-----BEGIN PGP PUBLIC KEY BLOCK-----

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
scUnWnv8sErY943hM8MUsMQ5D0P2
=3DUrys
-----END PGP PUBLIC KEY BLOCK-----

--------------Be7nZvoRhaKPxEOg6brQ4Vgc--

--------------BUmbr4iFKTcdobBoFcTLYjZ2--

--------------8nEDaeiE1b0mh6D75amhyvMW
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature.asc"

-----BEGIN PGP SIGNATURE-----

wsF5BAABCAAjFiEET/yoGP3p5Zl+RKVuX75KBAfJsRkFAmmmmREFAwAAAAAACgkQX75KBAfJsRly
1A//WsBf8OUwyJ4PxVU5gAtR1Ca4gLDkZiIpRwe7zBJ31quhMaYcZGxJigMjzpRjIs2JQ3ui3Ouo
Q1amoAO58D5YdCL9cPw5y6S1JggO3S0jC26DZhwFm6xtR71fnhORUZ7jfUrcxv6A3S7xkTLzImGc
YYuv7C8cuk37d08HxiJWUIrs41wJmpxs8MOBH0E6FM1kuADzQ9o2HY1UEFbH+L4QrKPSrLoXneG/
SvbaBmWOxJs7zTcJFKxgYILyXm0odQwj779DfQ65XsIdD3vAKLUK83ZqLf/qXgIlE8nxwwSr9kA8
JXoGghtZ5ZXD7RBrgd1KDW0eLFFGdPB3OV/Q6PSNC5504PnaQL3R9HvHROa5QCPCNk3c4KJOOQOz
CJY64XRDu+Xg1FII8JfG1cpy5vwi+o7NRL4WqXSDsbci/rqRUveWqGQpfveB60mOBI7B9rbmEeNw
E7SgFd8Sf2kbDlAyEmG4zO0rBlERPn2gi2OjdW88mqbV80dVWItTUiq5rzU2KqKalYYbWL5DY0iL
607mDBSFEeHouJUbO0qkgiQtFkJBvMGn6E2wISF4SS4fyNnAXrY/JK/f0NqDxTVJ+PEA3MEBjrf7
GBWRO57Fc4EwHdrjLRLOb2fvlF+eBJsona3yySJiHx1h170tB6If69suH0hb4ti55RcG+G+Uqvei
wsc=
=qF8M
-----END PGP SIGNATURE-----

--------------8nEDaeiE1b0mh6D75amhyvMW--
