Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 45C2BC4167B
	for <amd-gfx@archiver.kernel.org>; Tue, 28 Nov 2023 16:21:11 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AB57C10E0B7;
	Tue, 28 Nov 2023 16:21:10 +0000 (UTC)
Received: from NAM02-DM3-obe.outbound.protection.outlook.com
 (mail-dm3nam02on2051.outbound.protection.outlook.com [40.107.95.51])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EB06610E0B7
 for <amd-gfx@lists.freedesktop.org>; Tue, 28 Nov 2023 16:21:08 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=a/Zrwy7hRdJGdigulaK9/dMFxbGTRs6dqnEvsJAIKUXajfW6xuI10TNEqLhvyL7c4q3lJvr+PTgYttkQqwXh21v2Kssa2hfkx0Rdstsd73T8kogFQQ3wqJleAfialvjFK7fcFLvD5WP68p+vy4GicIFu8YIMQxq5IRNwm+jnsPzXzS3MFo4xqokmvNIExaqr6b3fXIzbcdilIUkGwTqHBUpKhJOPZAfVjxKOZ8Ndz2yUWxXR+JePNeaWqFZcVnO1YY89WXZ+ZfrBRe3x6Da/Iub/QIqoOXO/zlkTpse2yVKvK8qHzSbifdlAYPXWwgFiI5BRL7rPL+yzKNGobuW/HA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Kh1b7Ayw9MEk4QOLraAJyiZtDDe0IDbYAFBPrn5lRWs=;
 b=ofz9leuEonHUtqQvNjU9N1zcKYkuqMNRGfKEhoet1CCgJcu1RJZW5p/1JGZDxHswig7fFUirHPZXnhV+HZX+WuYHhMMVqG18HDmQXnRC4hXqoyqwsqLF1xYz+zNuUVIcSXox0KF21yJ5p8BQxLmWWXoaWY/bdFoF9xQpef7bVoUxjjzihuDTHjf8Z0XAhXimCMDuwFVGoexmP/n1+Xz6OpcxiM5SLwWkams914KCtwFT09Jbl9B23WjQDftsjmsHr4TPbfkiLeAXWaxtaJZHMa9XU/twjPmJHGR3KwRNVbPMplW5bCjMGxsSh1BA7SJP2s5Hp8XXL89DotUZHDVe7g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Kh1b7Ayw9MEk4QOLraAJyiZtDDe0IDbYAFBPrn5lRWs=;
 b=o2IkdnR5nVMpa8mj0aPaEKR6LDNJXsnHBeruzdc2wrVvK1Bt/isL53UzTne0QdNTQjNtET7jp76bbpPpYgcgMFcV3jb9StcU8NTHavqHuq9ruK95yiwoGQ+SayTUON+kk5L9NVbPH32LIwrVOSQuH5ndyHx3J/cdK9WpJ+XnUiA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
 by BY5PR12MB4210.namprd12.prod.outlook.com (2603:10b6:a03:203::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7025.29; Tue, 28 Nov
 2023 16:21:06 +0000
Received: from MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::83d7:9c4f:4d9b:1f2a]) by MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::83d7:9c4f:4d9b:1f2a%5]) with mapi id 15.20.7025.022; Tue, 28 Nov 2023
 16:21:06 +0000
Message-ID: <34dd4c66-f7bf-44aa-af8f-c82889dd652c@amd.com>
Date: Tue, 28 Nov 2023 10:21:04 -0600
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: asad.kamal@amd.com
From: Mario Limonciello <mario.limonciello@amd.com>
Subject: PSP_VMBX_POLLING_LIMIT too big
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SA9PR13CA0002.namprd13.prod.outlook.com
 (2603:10b6:806:21::7) To MN0PR12MB6101.namprd12.prod.outlook.com
 (2603:10b6:208:3cb::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR12MB6101:EE_|BY5PR12MB4210:EE_
X-MS-Office365-Filtering-Correlation-Id: e5e5e7b3-af37-43d4-7b53-08dbf02e05ff
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: IB18+Mlia3vyg2iJwk/9G7UYXJ/ywadg8HlQjPCki9fsDsOqfyZlr4ggv1WjORpebbY3A/6t/b5ttZl91ORwf5MBRv6BjUt76RoKhlJRsWi1uPhVzkLq0kcx+OM/tI4G3LIplLc5wJUmwq2L2NaRL72vziSU3Jl8DwAhHVDaLv58gmEMPXtOmFzJ/1pmW+X9X7igtu7At0M1/u+Thx5IShNRW3D96rxP4sA+8A5B/ePduCI56Xus/sRL/vHeB/tGSGmxkApJpAvy4Ii/nylF2qOsGXHgacdgaCJNTlcyBqpcEuCyrAOaE2iRpph3x4SjS4OOOBhDJsHXI0EhSq83i4FS1JgPYIEq/LvOcHrmNdgKdZMiWjfTBUI+nKOnBCu3PaFsyr56srKQFOU73db5yYrn281owXfWlUhVO96Bf56/Km/Vfi420YKrTJpOE1ihuFQ6gpTvCw6RwF6cHac907RkfcAHY7oi0xK4fFm2q9wQFaIwiBsuniimLggXBjee/bwKm6Q4lfR9bN6mZCTO0igZiOG/2R5ZjWdecsqem4UnJnN5dlMAio2i2uRbFCJ5Xv8lyAHh+MgmS/msaUbh4AA2ybmLbAAoQvUwj2ny+F/s+GREiibng56Uzd17vBdCG7hydff8v9Ltv5eySq7lmg==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN0PR12MB6101.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(366004)(396003)(39860400002)(376002)(136003)(346002)(230922051799003)(451199024)(64100799003)(186009)(1800799012)(7116003)(34206002)(8936002)(4326008)(8676002)(6512007)(6506007)(66476007)(66556008)(66946007)(37006003)(316002)(6636002)(6486002)(478600001)(4744005)(38100700002)(36756003)(41300700001)(31686004)(86362001)(44832011)(2906002)(26005)(31696002)(2616005)(83380400001)(5660300002)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cUsvdTlHKzRMTHRLbGJLMGg4QmhaN2pGYnJQT3ZjZWZKaGJDbCsrNkprRU56?=
 =?utf-8?B?STVJbGlUOUdVMzhrS2hPeDByZlR4V1ZtTlVNK0swZjhGOVhGK3VZdlNvcmVR?=
 =?utf-8?B?dXhsc01LbXJCSWhhREtLcklYd1paWXRaSXVUeDZFbGJsUjQ0NUdneElMdUhL?=
 =?utf-8?B?TDJCemNaVU5wcmZGYTRIWlZSc253bFRRM0VwTURIOEtqaEZOOEtSOXlmZTN4?=
 =?utf-8?B?MXFkemZwTmthMkF5WkdvRWZBVDlmN3R3Wks1OUdVMWlOd0o3UFdKS2pGN0J5?=
 =?utf-8?B?WFRQbVFUd1VWalRjSG43WjRlVkpVTFVYNGhBaVRvV3ZhenJwUU5UdkUrMWE2?=
 =?utf-8?B?ZGhYTENoRkcwNzRQdGtkSUREeHo0c2hQQ09maXYzUDRKWVMwZ2V3WmJQMk1P?=
 =?utf-8?B?RGxkMWNLSS84OGdjazROZzllT3VIOXBWWkJnQ01yWDZzdzdGbnBUc04rU3pJ?=
 =?utf-8?B?QkZQZElMZmkvTjk1blhNN2Vtbm9EZnZmYXlJelpSOURXTm82YnZXMnY4cW5a?=
 =?utf-8?B?VnJuaHFJOTU3eE80Q0k1aFRPMlBMY0VpbnpQT1FuWkxKdk1vZEtUc1dOL0gz?=
 =?utf-8?B?UHQveXRXRnhJQ2VtelBkVW1PWExXaU1nVmpZSU1tVjhuQ0xabk5CS0lGcDI2?=
 =?utf-8?B?MzhuSGdxVDdUeEJUNXdaeS9QRStxa08wUXlNWDZWNW42TXVwTkZjV0VlVE5q?=
 =?utf-8?B?QXJGUm01clNRRDRqS2lWYTFSZE9XYTVCVGdQK1Z0bWlvelFQMUxoVFVmZVpF?=
 =?utf-8?B?Wm03SzVyclBBQkNCVTREakRRUmV0WlpCMGtqM3JmR3lZa2xYb3JjVDFQYTRK?=
 =?utf-8?B?YWRnMjNXM2FCbGRSV3RHY0dqSzFTbTk1RHBhTlVXRzVHUzg3S1pwaVlxbTNt?=
 =?utf-8?B?Yi94UXFkRW5qWkVQYlhpZ0ZxL2pHcUlGZlkxMVcwSTRrb2lQYmpHRFNOK05T?=
 =?utf-8?B?NXRsTFBZSTFJdEFJdXEzdDc3SC9BR1NjbTVXTDFVdVBmZXloWE9zOFpkYkRY?=
 =?utf-8?B?WHllQVlHTEFjSlowYkJGS3pIeXRDTUVPc3pJVWZDeUM5aWpNVkpGTXFGNFQr?=
 =?utf-8?B?N2RtM3l6dHVZbkgvMDZCV0RFNWdtcUQvMVdESmVENERKcEFUVkJ4eWxzWHgr?=
 =?utf-8?B?MG94cE1pOGZ0V0toNjRMOVZnbjBCVXo4aVlwMDhYOVRxczZ4TkRtejN4WDdm?=
 =?utf-8?B?V0ZONXdQSzUwY2lpZUFKWkhLK3crRGJTWWJpaDBXbmIxWEJYc2MzcWdPSk10?=
 =?utf-8?B?SlRvWXBQS0c0aWRCWXJlSVFIMUxld0Yxdkd2M2VwcVYyVkV0Q3NLb2tOMzdU?=
 =?utf-8?B?cXIxUVhQTEt1S1I5QnN4RUZzWU9XVnNDcTJYZnpLREU4Wi85ZUJQelZWR3hR?=
 =?utf-8?B?NVc5ODVzMzFXVTI1eXBRam5rN3R6QWtLYUxrWXBKOXE0T2xjNFowdnFOeDdm?=
 =?utf-8?B?MWdYYWtSYVRnVWVPUHk3b0kvcmQwS1RqWUo2a1lMQmxUckxPYTZUb1VKWWVN?=
 =?utf-8?B?bUxtNFczbFZxSGtEVElaaUZWUzkyN2NlaHFtUUxjVHZBWUMwQkVLWmdIMFpN?=
 =?utf-8?B?Z0czTERSU1FtYXFDUXdWdm5MR2IxTFc0RTRoQ3BLWnl1ZTBnT0FWckg4bVZS?=
 =?utf-8?B?UTZEWmxFZTFSbnJjM2xiWk5IT28za1hUOXJDL0NxektUZHVLOEpTbnpxSTFB?=
 =?utf-8?B?c1pHT3ZkQ3k3R0J2ckMrai8wWmJTQXo1S3JUNytZNk9wR1RLTHhWMUdIQUZ2?=
 =?utf-8?B?bzU3d09QUi9Xd01HT0pQSVB6UlV0ZS9ETkhuUldZMFdRT0dnUEp4eTN2YjFp?=
 =?utf-8?B?cUoyclJmakRiR2pKT1hkdVU1VnlsYTVrZnJDaVRHRjVEYjI2VTRUUXZaZHBJ?=
 =?utf-8?B?dTRmL1g4WkE4eHpFc1c2MzREM01sNXZVaWhDL0F2MXZOMjJGdlJHR3lNaTln?=
 =?utf-8?B?WG56VzNEdFZWOVJXdkcwLytITVQ4VXFDaTU0eHc2ZGlUZmFhaTVvS2Z6Mml6?=
 =?utf-8?B?a3o0S2RScllUVW0ydkZkdjFHaVAzRXExRjJRcXVoSXBUSzRrV05KekpXQnY5?=
 =?utf-8?B?Y2hEUU9QYllkWXpxZFc4ZHpvZW1Yd2tpRHhiODdMSm1VMFJsSURpR2p0Z0Qv?=
 =?utf-8?Q?AK/DJ7IP9XK+KuLMiKMRs6CEF?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e5e5e7b3-af37-43d4-7b53-08dbf02e05ff
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Nov 2023 16:21:06.4558 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XoOMIUXNQEgbhbHUPJSjI13FqnCT1to421DcaxxiGQDMQuXC/9KVo50WHWaYfeS7FQ/r4RxUkjGdVnNfbOI9bw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4210
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
Cc: lijo.lazar@amd.com,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Hi,

In amd-staging-drm-next 46fe6312082c ("drm/amdgpu: update retry times 
for psp BL wait") and upstream a11156ff6f41 ("drm/amdgpu: update retry 
times for psp BL wait") the number of loops for 
psp_v13_0_wait_for_bootloader() to try again increased significantly.

It went from 10 loops to 20k loops.  Essentially this means that the 
function can "effectively" no longer fail.

I've got an issue I'm looking at where runtime resume for a dGPU fails, 
and because of this change the system gets stuck in a never ending busy 
loop instead of cleanly returning an error code to the caller.  The 
outcome is the system appears hung while the 20k loops run instead of 
just the dGPU failing to resume.

Is this 20k value really required?  Or can we reduce it back to 
something more manageable?

Thanks,
