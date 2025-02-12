Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E88A2C02198
	for <amd-gfx@archiver.kernel.org>; Wed, 12 Feb 2025 23:00:36 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2572610E07F;
	Wed, 12 Feb 2025 23:00:36 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="afMDCm4n";
	dkim-atps=neutral
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2068.outbound.protection.outlook.com [40.107.94.68])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 13FD610E07F
 for <amd-gfx@lists.freedesktop.org>; Wed, 12 Feb 2025 23:00:35 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OkgYqxw+lu7DOeKP9kI5Kj0ezpIn10762uRsHy0MuI9rxLOwO4n1/BsBCBO9hr5nAqV+W0XwHsnT8sKHR4GsYs8N+gaB6gajhRMjxhr5bBd5GUdYNNjnBcmedxxKVJF5wQCdRGgGCJSOWbdPSOuKMup+y8KvFXAQz0eGvb5T+0FYFKAU+iw1uGewGI51fgfnAjR5KuLXGgK4ltVOMN3XpTB1f/QeODrlIKQvImIj1F5CVQWBpuCr0U1uw7rugavB7ne2nn2JOIKkn3bgiQAawkdg13/JNwqz3BCngONlsHVaxuCkCz9EDeINwI1ju/yYQtB7pAB5hFFk7MNb4KlwIA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/FfAVY+lzxDfU2xIvGmQ0SE9TKkCX9jTnXE13Y65cjc=;
 b=tgBr3qlcbUt8UVOF7KEel8S54hrxUGyiX6mT6WlNLpTssL878JqsldrLWtXPzPN6Y/gvdXPlupl93XprhBaKkCy+eSBSutEvoCTIod05iWZC3FPCi+ZgEj0/kbJJmFVnZ2Xnjqi1VzN75fnISUad+B3c59Fiwx+E1Q2+QwiRKfEYgvHSv736raUc8qDOsNNu09ftC2p2/wIdIk2iZKJlpxqbbK06U4qOKe8k0WuogKf0NT1ki2t8quddOgbwMDQWLZLkSArXOSYAja/HcHg45VGnCPRSv3Dg35WHsQ2HJcnDp7jBlwf8n6YHLUoxN6YyAWwzB/PWmAOXFKl8rlSnsA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/FfAVY+lzxDfU2xIvGmQ0SE9TKkCX9jTnXE13Y65cjc=;
 b=afMDCm4n9uqLtiYQPEtnYOn53VLDIyJMe9Mcitol+h2/SSfQ1+BDTX4qtt/Oda86lBMBYfs/dIoe8ZNSwXluFir2HXUHkJ+eO70H7uDb9Uk8fP35KBZxlh7vwQHqcK5eTfG8z0M8JeIikJDuUPJpCk17T8S4H4/tujAwxO9/E2s=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB5149.namprd12.prod.outlook.com (2603:10b6:5:390::14)
 by IA1PR12MB8309.namprd12.prod.outlook.com (2603:10b6:208:3fe::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8422.19; Wed, 12 Feb
 2025 23:00:32 +0000
Received: from DM4PR12MB5149.namprd12.prod.outlook.com
 ([fe80::36fa:deca:aaeb:75da]) by DM4PR12MB5149.namprd12.prod.outlook.com
 ([fe80::36fa:deca:aaeb:75da%6]) with mapi id 15.20.8445.008; Wed, 12 Feb 2025
 23:00:31 +0000
Message-ID: <03fd1d10-5562-fc1f-7c30-50043e2815cd@amd.com>
Date: Wed, 12 Feb 2025 18:00:28 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH] drm/amdkfd: Fix user queue validation on Gfx7/8
Content-Language: en-US
To: Philip Yang <Philip.Yang@amd.com>, amd-gfx@lists.freedesktop.org
Cc: Felix.Kuehling@amd.com, alexander.deucher@amd.com, trnka@scm.com
References: <20250130000412.29812-1-Philip.Yang@amd.com>
From: Philip Yang <yangp@amd.com>
In-Reply-To: <20250130000412.29812-1-Philip.Yang@amd.com>
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: YQZPR01CA0159.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:8c::17) To DM4PR12MB5149.namprd12.prod.outlook.com
 (2603:10b6:5:390::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB5149:EE_|IA1PR12MB8309:EE_
X-MS-Office365-Filtering-Correlation-Id: da937a56-53a0-42cf-122a-08dd4bb90c84
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016|8096899003;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?L0Nka2JXQTg3ZzFmL2IrWk5wL2RNYUN6d2pBK3E0WWhsVFJSTTdwQ3k4SSt1?=
 =?utf-8?B?dkhVSU44U2lTS1ZvMjZGMHVxSm5Odk92TlNjMVBEQXQ1MWMvdlV4SEpFM3lZ?=
 =?utf-8?B?OWN4Q2dWRFE5NDlVbTlTY3gzVXVYRHRhK3ljV2tMZ3I1WFpYbUpRMjcrcEk4?=
 =?utf-8?B?eEdKOVJyYVgzTXExSmVhTkVGMEIycjIxVDc4bDRPMC9PWnZvaGtSOWphN2NH?=
 =?utf-8?B?WUs5aXRweGRXbkRNdTdRRVlrclVEbUJkbmk2QjhFNTV0RW1BMzg2U1k3aWZj?=
 =?utf-8?B?SG1wVk9QbWFNeFh2bHZWeXZPMHlFUHJyMWVwbXZYQ0ZsWVNoSVZqM0VFRkxX?=
 =?utf-8?B?TkJGSE5hb0xjMEpxSWtBcWZYeUxzQW4weTlPRUIrZ05KQnFLQkFid253a3Zi?=
 =?utf-8?B?KzhlSDByc2lOL2RQd0FlN2ZmbllNRDlsMkVYWHk3Ykh0ZlppbVZGNk5RL2gw?=
 =?utf-8?B?ZFk2YjhTdVZPNDlOVUQ1cVVBQ1BHdU12aEFGcEhxVFREWGJZcTFWTm5tQ1hn?=
 =?utf-8?B?S1JaQ1Q5bm1IdWJLRGtvRnl5SngvU1FLTkFuVFNOQzdlaHhZbzM4Z1p5dzlH?=
 =?utf-8?B?MXNnMW9PLyt4K3hHUWUrNkZCTTFrSy9tTEFsREt3VkI2a0liWFBCY3oyUlBL?=
 =?utf-8?B?UXdzWFF0TzdTYlFnZ0hJN2VRaU9nTENySmcvQWRna1FucEVINzdHbFBBK0pa?=
 =?utf-8?B?cWxUYmZhYjJxazRBbTkzU09RTEtQZVdhK3VuQ2UzOXpQRXd3TnQ3eHg3L2Zy?=
 =?utf-8?B?aFo3cmNBN1ltK1FRWXFBZXFUN1ZQcUZUNUFRKzc2bGZaaFRkdk9KTmNQRmo0?=
 =?utf-8?B?SkxjQVFRU0pzTUlxQUk1a1QwYVFpdEIyRGJMYVU4WmlHNmF1YmVKSWZSRHVQ?=
 =?utf-8?B?amI5UGFUYlU3WitLUE1xdkNRbHhzL1lNT3Z6WXdzYXByTDBVdVBBTzFVb0gz?=
 =?utf-8?B?RnQvTlBpcU9td2ZYeGR1OGYvUDZOVUpYcFl1L0JvVE9tWGxud0ZSUkxBUzVV?=
 =?utf-8?B?L05FazQ5UHAzajNPaVlNN1l0ZklRbXdiaStKL1ArTkZnMUVSSHNrUnZ3aXp2?=
 =?utf-8?B?MENxaStzVHNqZU5ZQitEemRwTnNtdFdkbkZkTFYxNTlDbnpCVjBMdVlIUWFv?=
 =?utf-8?B?a1pTR1NJNkJpR3dRTWxpWjRKcUlBY01hbUo5MVk0YXR0MnBWQ1pDMStJUTJI?=
 =?utf-8?B?czRzQ0tVZUNOSHdpdk1oU05GUDlXNW9OK25PanNsZmdOMHcwbUdxRGtzSGhI?=
 =?utf-8?B?MytpZEp2cTNMdVd3RXZFTjh2Z2JTTXFPbzFiVjJCS1dqcE5RNmJieW80ODBM?=
 =?utf-8?B?alkrdDBkaW8zU2FmWUQwbjNqdDVMRzlaTWV0d1ZqTktHby92QjRzRnN4Y2R0?=
 =?utf-8?B?NGluY0RCYVZWZ3FlM2VNUnBCbGd5Q2wxc0hVaFR4aFhFTmJhdDBZTjdlS1hO?=
 =?utf-8?B?TGRoR3VoenZwUmNicEY5RXF2RHE3MWt3OGpOSnd3ZFhOZEZzaVFuM0h6MUxr?=
 =?utf-8?B?ZUFXMzFPZzRXNGdzNGhhNmZvMU9RNHZGclNzdDdiZlkrdWVrejVVbDhIa3ZK?=
 =?utf-8?B?aUZodStmcWxzTmx3dnVYaVExU1QwcHRXQmdMekZVU2tPUnhuQ3cyaWs5aHFv?=
 =?utf-8?B?Rk91UVBFQzFaWURQUlFmM2NtZzlUM3FaUEpVN2hZMzEvWmFidXhJUitPUTlq?=
 =?utf-8?B?bmN0T0tyUEdOTmNCakNrUi9SOWp0c1BHWE12S2p5b1RtOWFvOTBnaEdpdE1k?=
 =?utf-8?B?OGNUeTU1N1o5WFg0UjVrNUx0Qk5GMVpUZnEreHl1QjNJemV6ckU1UEJodzJT?=
 =?utf-8?B?Q0U3NDBkeU9XS0wrN3QrSElWYVFKYlBsTFBTNXBVY0VyY2RWUlBCWFdHamN0?=
 =?utf-8?Q?fc4SXNVpK7q3y?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB5149.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(8096899003); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bk5sNGloVEtndGRFejJ5U0ZQMzROM3lrZnBSRzNHZit5VnJEZVR2cFNGV1VI?=
 =?utf-8?B?YVNJNDljQStSeW9ZR3d3VmZpVTczdUIvOU01KzBORVJsSmF6VXY3WmRWTk9J?=
 =?utf-8?B?djVUTUhlWndLM0MydzhHY1luSnQwQ0JPVm9JTkxBamptcTNLQ1E3NmZVUHNx?=
 =?utf-8?B?VWtQK205YWpNM01jWlByd2ltRjYyYnMxbUtUWmxNNjNWeVFRbWpKdzBTZVQw?=
 =?utf-8?B?SU5TSzZnRkFQMWs4OFZVemNPZzZPRlJtQ1kzTEhCeEZ4cVByN0c5d3oyY2NK?=
 =?utf-8?B?OGJxVWQ3bFV6anRpOWRTN2lmNUpqRGRyUUk0U25uUEpmYmRweEdZSDBQdk5p?=
 =?utf-8?B?Q2l1aE02bjdlZlVDNytQWS9MeVEzOGY1eDRtczdxcFFHb25OUnB2YWZFYkZs?=
 =?utf-8?B?RzB2WUFSdWIrV0xXUVpjSFRlQVNRYXk0MlFCa0FQNXVVaEFMMEJ3TmZVZGc1?=
 =?utf-8?B?NG1DNWN0Z2orcCtTdGxsY0ZsSndFNmZZZVFzQjNIZG1HdTV2aXQvTENjeFBV?=
 =?utf-8?B?Ym1QaXlnS3dWcVFyOUwvb29IZG10RzdSZ0dlbXU3alZPV25RYVFxZUIxUURY?=
 =?utf-8?B?VVZ2YVk3bVppUlY4anUwWkpQZUZPK1NIdVp6VkNnV3NUN3hrN29McWJaL2kz?=
 =?utf-8?B?MEhxaDlBVnAwWjd1TkIrNFZyTGM4czFZWE13YkJEYXFOZ0JSRThqSzBRUjRy?=
 =?utf-8?B?SDM3bVFOUGdLem9zVFdzKzZGOSt0dEZoVFJPaUlsS3J3WFV4eVdNVFpQazVJ?=
 =?utf-8?B?b0J1NjhXUTFPZ0RmZWhKekFWaGlPR0Vab1RTdFFBWURYaUZjbksrc0E4TVU2?=
 =?utf-8?B?THk0ZGhUeVlhNmowK2xRL0ZlUEh4cWN6bm8zTHpVeTc0TGN1aFNMS0hoOFk0?=
 =?utf-8?B?b0ZvNEFaQ0pIbk1JbDcwR1FXTytuMTVzZDFOdWZxSkh3ZzcrV292aDl4blFK?=
 =?utf-8?B?dmVBMlcxWmFLOUpsMXhQc2tETnMrT3B2UXEvQkovRjdjcDh2OUVyRmdQeGlW?=
 =?utf-8?B?RE9qUlZPVnA0SVBFOFI3ZGYrZmtxSHRLQmR2ckp4elZZZnRsNUlVSEltSEtC?=
 =?utf-8?B?OG5kUitrV0Y4enJPTVUvemU5L3FDeFc0djRpRmdqeDhtMTcvVVZEWUEyTmtx?=
 =?utf-8?B?U0NkKzd2T2lISDdUQ1ZLTjVLbVNlVEtBSlBTMGtrWG5mTmZBNWthejYvRjR0?=
 =?utf-8?B?YWpnMHYvajRsTTFnOHQ1bko1WTFKOGpjMTByZm1VZHdGRTYvS3lVRWtheWx1?=
 =?utf-8?B?NFd3dkhDRzhudFZrYnVnbHBEUFM3eHJLdGZ4emxkZ2JFQUtUV2NUdTdTdUh4?=
 =?utf-8?B?RVE0NFFHQWZPaUtqeHprT0phUW1zMHZORDVZTW9QbStGSkxwTG1JZk5DRWhw?=
 =?utf-8?B?SWgvajdhem5MVWQ3TDlkTDQxYnZQTmxuZGlKNHdWWVRHYndOY255RlNUSVdk?=
 =?utf-8?B?T3BIMkxHeTY3UDZTamF1NlhCc1FFMThtYWp5S3FYMXJvck05NWFvai9JWUFQ?=
 =?utf-8?B?U3dsVlJCT09NZE5iRFlueE9oK0lvdnBpbC9kcU80MUpZTWo1UmY3NktDWXVa?=
 =?utf-8?B?K0d3d3diTWJ3K3V6enJ1OGlBdFpsNVI1REtrUjhEb3ZLbWU5UXdyaWhlMEtV?=
 =?utf-8?B?R3R6SFNpTzlYanR5UnJSUmw5ZElMa1JPRzF0b0xNRnVDT2NVbHdUZXR5U25q?=
 =?utf-8?B?MTRGK2JCelRwKzVhYXVnVm9xd3Vya3ZIMDMxMWhEMzhCRnFYSzQ5bjI2bC8y?=
 =?utf-8?B?eHhLbXRVMlBvL0RTNDNXVS91aU9iOWVvQ205ZTF2RUlTdFRBZ0NBSlpzVUdT?=
 =?utf-8?B?dThWMVNJRnQ0anA0aXhvM3E5Q1JXRzdWK244dW1zcnQ4VmtGYmFlQkRYR2U5?=
 =?utf-8?B?MXZUbFdiUnB2aHIyWWRHbFJZRkZLWHBiR1VFOTdNMkhYVElBUklnMTJxd0E4?=
 =?utf-8?B?N1BJOVhaY081ckJ5QnJHZVR4cVBwb3lWWGl5a3Q1OFdEcWZIWEwwRlBQZTI0?=
 =?utf-8?B?VXRVMmJLTHUvOWc4ZWFQV0ZxT3VTVW1lRXYwZUpxdlVrZDBUV3Q2WGRvdU96?=
 =?utf-8?B?NjVZaEFPc1hWbk9WYSt4NUZRbUtBK3NJZjNrQzZPb0g5bDdFTEVyZjV4eWJZ?=
 =?utf-8?Q?tEXx0qaMWaFkLx328JVk1/Wpo?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: da937a56-53a0-42cf-122a-08dd4bb90c84
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5149.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Feb 2025 23:00:30.9354 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7QEoEFQX68CcVSL2MlfrE5S8qu4JUaS3WQca7yXXln6AoMP/C1pAZTbb3R+FuhgG
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB8309
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

<html><head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
  </head>
  <body>
    <p>ping...<br>
    </p>
    <div class="moz-cite-prefix">On 2025-01-29 19:04, Philip Yang wrote:<br>
    </div>
    <blockquote type="cite" cite="mid:20250130000412.29812-1-Philip.Yang@amd.com">
      <pre class="moz-quote-pre" wrap="">To workaround queue full h/w issue on Gfx7/8, when application create
AQL queues, the ring buffer bo allocate size is queue_size/2 and
mapped to GPU twice using 2 attachments with same ring_bo backing
memory.

For this case, user queue buffer validation should use queue_size/2 to
verify ring_bo allocation and mapping size.

Fixes: 68e599db7a54 (&quot;drm/amdkfd: Validate user queue buffers&quot;)
Suggested-by: Tomáš Trnka <a class="moz-txt-link-rfc2396E" href="mailto:trnka@scm.com">&lt;trnka@scm.com&gt;</a>
Signed-off-by: Philip Yang <a class="moz-txt-link-rfc2396E" href="mailto:Philip.Yang@amd.com">&lt;Philip.Yang@amd.com&gt;</a>
---
 drivers/gpu/drm/amd/amdkfd/kfd_queue.c | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_queue.c b/drivers/gpu/drm/amd/amdkfd/kfd_queue.c
index ecccd7adbab4..62c635e9d1aa 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_queue.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_queue.c
@@ -233,6 +233,7 @@ void kfd_queue_buffer_put(struct amdgpu_bo **bo)
 int kfd_queue_acquire_buffers(struct kfd_process_device *pdd, struct queue_properties *properties)
 {
 	struct kfd_topology_device *topo_dev;
+	u64 expected_queue_size;
 	struct amdgpu_vm *vm;
 	u32 total_cwsr_size;
 	int err;
@@ -241,6 +242,15 @@ int kfd_queue_acquire_buffers(struct kfd_process_device *pdd, struct queue_prope
 	if (!topo_dev)
 		return -EINVAL;
 
+	/* AQL queues on GFX7 and GFX8 appear twice their actual size */
+	if (properties-&gt;type == KFD_QUEUE_TYPE_COMPUTE &amp;&amp;
+	    properties-&gt;format == KFD_QUEUE_FORMAT_AQL &amp;&amp;
+	    topo_dev-&gt;node_props.gfx_target_version &gt;= 70000 &amp;&amp;
+	    topo_dev-&gt;node_props.gfx_target_version &lt; 90000)
+		expected_queue_size = properties-&gt;queue_size / 2;
+	else
+		expected_queue_size = properties-&gt;queue_size;
+
 	vm = drm_priv_to_vm(pdd-&gt;drm_priv);
 	err = amdgpu_bo_reserve(vm-&gt;root.bo, false);
 	if (err)
@@ -255,7 +265,7 @@ int kfd_queue_acquire_buffers(struct kfd_process_device *pdd, struct queue_prope
 		goto out_err_unreserve;
 
 	err = kfd_queue_buffer_get(vm, (void *)properties-&gt;queue_address,
-				   &amp;properties-&gt;ring_bo, properties-&gt;queue_size);
+				   &amp;properties-&gt;ring_bo, expected_queue_size);
 	if (err)
 		goto out_err_unreserve;
 
</pre>
    </blockquote>
  </body>
</html>
