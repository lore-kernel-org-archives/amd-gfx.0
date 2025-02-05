Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F19C3C02192
	for <amd-gfx@archiver.kernel.org>; Wed,  5 Feb 2025 23:11:30 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9C18C10E218;
	Wed,  5 Feb 2025 23:11:30 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="TZXKiggh";
	dkim-atps=neutral
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2070.outbound.protection.outlook.com [40.107.92.70])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4F94F10E218
 for <amd-gfx@lists.freedesktop.org>; Wed,  5 Feb 2025 23:09:21 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CDZIvTbU4I9dg4chYL2DYXCqNRkiBpGaxtAWvuCagxzMpbIMNOcGpmG8S5DQr9LiAzfZE+wKUtdM+TafUYcDyJBK2A7gzJL+Z7VJCtXfApM4C4eRGXejooXI8wkuUa1i8lhPbg/OCVcTyZETZeE+hJ/smW0HY4I5k+haOKrE5yM9TbkdS3bCdnM5vCHhRyO2A6bUZGUlGqGpKobvv6u68eph9YSA+0qSrjqh02TtxD3TAAVnS4v4Cl6qNuCi6y++qJNcH2D0iAejhjVPoD9rjWaifjqTheLYavvm4Td2Goktnq4cJQy4zkq1xG0XFSefY50nLZtfT4ibMfK/96rY3w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZhRFOHfHAv3jXUQJ1nOKy0gD9vaL4W9swpiFBRACQvk=;
 b=Xleow/6fHwhz/9k7aga/N6vpZo0MiYciHhIMjtS2+r32XDLFzfARJiRcijXHvOyEtzXl3VrtRiQCe2DC9jF7hyMiASnHBGheI9ObxwPEP6ozvNvvHKioO10M0qUCConB5pSpcdq72zixCYaTtpbuNGQhqLcM84D+GrcMlIA9ALh/Dxeoge59oRMsjLr5fkmJXh6HK2aHoW79S0Y8rNtNZ8rcCbuufjkOyPpsFQjRpqubO88MZ/X9VdpdmxhXnsOQSUIMLrlkF8LuvRjGxu+Pp4hDZr7lJLwZqaL6JOd4YSPm2zy2hp7I3XodcIsXQ3fZ1jwA0PcxzCs1Weaa03Cgqw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZhRFOHfHAv3jXUQJ1nOKy0gD9vaL4W9swpiFBRACQvk=;
 b=TZXKigghgwOW9uZ4mvuz0vxP61aZHA7O0QhkzMUEE+vcdqKBAqOxWGVEzmwrmj+QH5bHDg6enZu3fz2PBlSRCFLZtRZ35mGX0fjVgfOvoseGTSOkuM6SGdlZ6ixAEYdLvXRawg/9i/aRqSRuAA7I6jJwJ+UVDp6EmVHtKR6JbzE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB5149.namprd12.prod.outlook.com (2603:10b6:5:390::14)
 by SA1PR12MB8143.namprd12.prod.outlook.com (2603:10b6:806:333::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8398.24; Wed, 5 Feb
 2025 23:09:17 +0000
Received: from DM4PR12MB5149.namprd12.prod.outlook.com
 ([fe80::36fa:deca:aaeb:75da]) by DM4PR12MB5149.namprd12.prod.outlook.com
 ([fe80::36fa:deca:aaeb:75da%6]) with mapi id 15.20.8422.011; Wed, 5 Feb 2025
 23:09:17 +0000
Message-ID: <e7610eb5-e5de-1f64-fc1b-2219e652674f@amd.com>
Date: Wed, 5 Feb 2025 18:09:15 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH] drm/amdgpu: Set snoop bit for SDMA for MI series
Content-Language: en-US
To: Harish Kasiviswanathan <Harish.Kasiviswanathan@amd.com>,
 amd-gfx@lists.freedesktop.org
References: <20250204230235.150757-1-Harish.Kasiviswanathan@amd.com>
From: Philip Yang <yangp@amd.com>
In-Reply-To: <20250204230235.150757-1-Harish.Kasiviswanathan@amd.com>
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: YQXP288CA0034.CANP288.PROD.OUTLOOK.COM
 (2603:10b6:c00:41::45) To DM4PR12MB5149.namprd12.prod.outlook.com
 (2603:10b6:5:390::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB5149:EE_|SA1PR12MB8143:EE_
X-MS-Office365-Filtering-Correlation-Id: 57c69252-c41d-4507-e0cb-08dd463a1d41
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024|8096899003;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?UHRxSEZQdkhoM2g0OEVMd0xHQU9ObVFZVXQwc1c0eStOM09CUGJ3QUNiQ3Jr?=
 =?utf-8?B?anNsdUx4TmxMT0RiU2l5WmU1dGt3VkhuaEppcUd5VnlodVhQVklnU0R4aDBU?=
 =?utf-8?B?RmJBamRHWGVZQXZwZ05Md3hOaVFQS3RnaW4vQWF2TnM3eDdTbi8ySitjR3pW?=
 =?utf-8?B?d202TnpQdXpkbVhGV21oc0RxU1U0b3JGdTFRTGwrNExHU2ZXcERhZVdGYk91?=
 =?utf-8?B?a3NpRklWTW1OOStTNnpYdHdXa3lKMGhDZVdnTlpQS0E2ejZvOUJQbGNkS1B5?=
 =?utf-8?B?SHBMUjkzWUNYcmZyUXAyNFlCaW4xeVpIZlY1ckJKUGxrT1VYbnBZNHhlb1N3?=
 =?utf-8?B?UStFbVNudUJhb0dReUh0RTNwTXBoenE5L3o2NEVxTC9RbDQ3OGk3VGpacG1G?=
 =?utf-8?B?SnAxTTJvazltc2ErbndoRGcwWDZ2WnhobFBmeVR1MmM3V1QrbGNLZUJRS3M3?=
 =?utf-8?B?YXcrcjdXVFUrazN2RmR2UTlNTkRCRGxTeHJLd2VhU2V6dG5YWG54a2ZpTVdC?=
 =?utf-8?B?TXFraFFEZ0QwT3drU1lCWURUMUhCalRrdzBObTl6TVU0RGE2SlRnYllSYVpt?=
 =?utf-8?B?VndaZHB6WGoreFB3SEthUTVNQVFSQWNJQVo3d05ZdnEwNzR3RG0rYlhydEQr?=
 =?utf-8?B?TVFQaEZ4Y1NWd2pvdUc3YnAwNE1WTlo2bEJTUXNRdXVwZWM3S2QzS3VHWDd6?=
 =?utf-8?B?RTR2UDJydlpPTDZkT3dLcEUza1RmSkFuRGN4V3dUdHU3TVIyclczWEhtTTZj?=
 =?utf-8?B?aTVrQWNOK1RvWHhGaEJObHNSdDU0YThBQmlqYU0wM0Izd0lDb1Y2bE4wYXdo?=
 =?utf-8?B?VEpGUTNDQVdxSXdETStuUENQaS8wMkUxR0tLdVY4R042VXVlNEVUN2hZaEQ5?=
 =?utf-8?B?NDlHRmRFbEZ4M1cwdXVvRVRqZEJpSExmQzlkTnJMN3N6VlpzSk4zeWJDdERj?=
 =?utf-8?B?Y054QjlDWTk1RkR3YWdkTTRTQUFGVXdiZ2ZjdTRSOXp2bDNKVGdyTStWQXN1?=
 =?utf-8?B?aE82N1V5b3hUMWkvSWI5RnEzNjBFcXFsY3JFdVprUW4ybXpndFhLenpsTnZM?=
 =?utf-8?B?SzJ1WnZSZ3ZUQ05TNitGK1dqZHA3M0UvREZub3lMWGMwU2RBaFZDck80c0NM?=
 =?utf-8?B?SUwreVJ0WndabXM3SmlTeDl2S3JWTEwrQXVDODlUdmZXYXBIb2dXZ0pqRW9s?=
 =?utf-8?B?ZTlNM3pWWm83cmpxNGg2OTFYTXdqZ1J2eFlMbFdlZVI2bXExbFhsckFEbDZC?=
 =?utf-8?B?NlcxUy83cnpwYVQwdHhwNmp4QTVHdmtnaVIxV1k5OFFJRG5UNko3Wnc4YzFS?=
 =?utf-8?B?QXJvOVFTeFloSUxWaFllR1ArQVZLSHNXNHdFWmhlczBHQmdSenVXckcwWmE1?=
 =?utf-8?B?d1laQVV5QjhYbTBnYjBscnlWL1E3YUVIYmRJMlg0WkhCRnp2WnllSGtaNjdH?=
 =?utf-8?B?QXk4VGtyZVMyREtoREVOWndnWlo2dDBQblpPakFSci9RZzFiTDlxSlhHd1dI?=
 =?utf-8?B?RUk0bzZ0bjdiN0F0UTNYVmVOWnI2Y0Rwd2RWc0JSUkMxRG5YNk1UOWkxSWV6?=
 =?utf-8?B?anBHZk5PVzZ1SUQ4NWRrTE8rT0piR2VVVnN1ZDA3RTNMSTAvbitxVjkzTzlP?=
 =?utf-8?B?MFptamtReUdkUUF3ZmZVM3hZczM2WWdxOXFJdzRqQWFNWHlCaGFLYlNtdjRJ?=
 =?utf-8?B?UnhmQnZWeUVENG52L1l1dkU1Z1VvOTdhWUZoYVd5d3ZkczJJU3lXUU1jWDUv?=
 =?utf-8?B?dkZmUDF1NVk3UnV1MGw5NEJhNGVyMGlZZllrTUwxQkVZTWczNzFlRExESWc3?=
 =?utf-8?B?aHJHTzVKSTFvOGZoeHdwTC9kdzNuckF5aUZicG4rTlFKTDBuNlVPRmlTZDJt?=
 =?utf-8?Q?MEBQ0kPQTWFqV?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB5149.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(8096899003); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?L294STg0WmcxMHpXOGc3SDNMVWdJdUpnU0I0K2Uxck1QYjRmSU1RaGorTjdQ?=
 =?utf-8?B?T0F0bmFNRlZBNEJ4R1o3c29Nc3RpbGs0L0Y4OUVXbHd1ZnB1RlR2NEZjRDlK?=
 =?utf-8?B?Qll6TmxrYU1yU2hkN0N5N1M2dThqcFZJUUZrYis2Q1RNa0ZiRnlqNjh6dkZs?=
 =?utf-8?B?cFhIc3hvMWtxNXlDa1A5SWhNL0FtemNUcm5FYzkrMlJmVEhEOUdqSjdDUTQy?=
 =?utf-8?B?ZEVxMFpPa0VuSm8reEVNM2t2cWQ3V1Z2a2JpTG5UQXQ2bS9SY3dkRFV6bmVK?=
 =?utf-8?B?QTJyeS9GQ2xiVkdUT3dYSzZZY0RlSzV6V3ExQWVjdXYyT2tNR3ZMdDlDMTI4?=
 =?utf-8?B?Myt0dGxnYXFLbUhQdzFpSk9kdGFMVko1TWYrMS9Ud1pMaG43b2hkMTJndmtJ?=
 =?utf-8?B?QWFvUjc1cGFpcysrd3c1VHZ5Q1dXUC85N3l3akx3Ulc0djhncHVBdUtkV2s5?=
 =?utf-8?B?L0d5OGJzTlBYOS9Hc2VvY1N0VVB5SXlIalZHd0NROStNZDhaWUJxYlcvT1JT?=
 =?utf-8?B?OGxIK3IxYWNyWDAyNStRY0NaVVV5RHVkT0RaNko2M05PcDNGZHlPc1Z6R2Z6?=
 =?utf-8?B?OFd5UXlwaUQwZXl6YVk2RmxDY21YU2dJaVFDMjZZZldYSUMvMGlJTjI3Tmls?=
 =?utf-8?B?VFpuR0g0ZDhZK0J5cTBtVktETlJKTDVBTWlERjdaelFCVlVkUVNoZlFqdzNz?=
 =?utf-8?B?enl1VEh0RnFMOU1seTZsaWVreWhMY1Qrem52QXFyK2kxck10eEdkN2JlYjgw?=
 =?utf-8?B?eHFyamZKQWxKcFdLZS9PUkV0Yy9wU1lSUEFNeEZGdFhxUVpJZi9DWGFkVk9D?=
 =?utf-8?B?SHluOGlJeDYzU2FPb0tHcFI5S1Zob2xyVGc5TkhSdm1XYWZMb2NKM3FrWlFl?=
 =?utf-8?B?OEdnaEdrUFBZVFRpaXMvQTlnT2NpRmc2RUFtb0xYa1ppSnlmRml2aVU5RHhZ?=
 =?utf-8?B?d1QxOFFsNlQ3dk1TQUR0UmV4cjJoQVBuTDBidFVyNjFrNWZIbkpNQklvSFli?=
 =?utf-8?B?WVRFSGc4QmZSRXNVK2dPbVNybk0xdXYvMFZFOHY3aHV4MnZWcGxmNDBydGln?=
 =?utf-8?B?ZFBVUDJhc05tN0ZWUUFjb3piMUdoR1NjbXhEZU1FOUgyd0xFYXMxeDhnbm5r?=
 =?utf-8?B?Vk9GdWJpYVFzYk5yek9Qak9JZ043VCtRb3I4OUwvWDNKL1JwclBnOWlWaDF6?=
 =?utf-8?B?dVNrcDZxaFpoSmFiOWVxQjFVM3U2aXdNSDNuWmlhTXhKa3Boa0FhYzlsenA3?=
 =?utf-8?B?a2k3blBDZ1BGbzArZjRZMUhXTVRuSG9FY1dGZ2M1T2FydlQyK1VobjlEdEgy?=
 =?utf-8?B?YTVleC9ZQWJwUFNHQVRQckZrSzlUVVZBU2p5d1NNT2J3TFp4TklFYUZTanM2?=
 =?utf-8?B?eXZuaTUyVGhVVjgyT3lGNi9vNzEzTEMvbFVLZG9EMGZ3aGlyc3Jjd25TYXFz?=
 =?utf-8?B?c1N3cHZETlJkMUorZEJ2cmxaRktMRWhWRTlROG5SVGN6ZzJMcm4zeFV4NDVN?=
 =?utf-8?B?Ynh6V0VsaFcrRU93QlNMWG13a1R1dkE2RFVhQnV6Uk4zRUtVdWdZQ2h2UXR0?=
 =?utf-8?B?RDNOZ3FvbFdMVXJodkZUSHFPSmxtUktNZXFXSzRoRUhMbWR1NnNLWHMvR3Qx?=
 =?utf-8?B?cTVRS2hoWnEvcjlsenVZNmtvZit0ZnhUYkNmczFGYUFYTnhCVXZrUFhPUXdu?=
 =?utf-8?B?T0tZelU2R1cyeHk4Q2tscFRxMEpseEl3S21QeXpzZTE3Rk9ETjZGQWdwVits?=
 =?utf-8?B?MVoydGJVeFlsZ3hDM0VYTUJVTmpPRk4xVGVjUEdOUEZ4WnNydUdUck1yVkxa?=
 =?utf-8?B?aERJSlRzNzh0bGRpRzF2MW5UUGNHWVoweGplZDVRN3NMVm1CMnE1ODkzT2g2?=
 =?utf-8?B?THV1dWdtVWJYcnpBVVVtbzlpc1BpZjkwRzVIYUYxMWZwTlB3anJaZTR3bTlN?=
 =?utf-8?B?eHpGUEdtMXV2bDJhSk1vM0lDV3hDRmtzRjNQSk5PM1VEY0JLMzFhVjh0cHBD?=
 =?utf-8?B?NElMbzQrbTNFblZMWjAvd1BZZ3lPa256ekhGUE9OdjNnQXlPZ3RvazVXMjBR?=
 =?utf-8?B?R1pncmVmS1lqZ3kzT09HOUhQd0VPdXFuZzNLcHA1bzNPeWhMT3lQWU5nOGlt?=
 =?utf-8?Q?5Dbw=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 57c69252-c41d-4507-e0cb-08dd463a1d41
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5149.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Feb 2025 23:09:17.0809 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: eXgS3xd0MK2750Z5l6Y4RYvw60OlQRW9nByPcTroBlTlnpsnGqzkK/AtnLE3iEfr
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB8143
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
    <p><br>
    </p>
    <div class="moz-cite-prefix">On 2025-02-04 18:02, Harish
      Kasiviswanathan wrote:<br>
    </div>
    <blockquote type="cite" cite="mid:20250204230235.150757-1-Harish.Kasiviswanathan@amd.com">
      <pre class="moz-quote-pre" wrap="">SDMA writes has to probe invalidate RW lines. Set snoop bit in mmhub for
this to happen.

Signed-off-by: Harish Kasiviswanathan <a class="moz-txt-link-rfc2396E" href="mailto:Harish.Kasiviswanathan@amd.com">&lt;Harish.Kasiviswanathan@amd.com&gt;</a>
---
 drivers/gpu/drm/amd/amdgpu/mmhub_v1_7.c       | 25 ++++++++++
 drivers/gpu/drm/amd/amdgpu/mmhub_v1_8.c       | 27 +++++++++++
 drivers/gpu/drm/amd/amdgpu/mmhub_v9_4.c       | 30 ++++++++++++
 .../asic_reg/mmhub/mmhub_9_4_1_offset.h       | 32 +++++++++++++
 .../asic_reg/mmhub/mmhub_9_4_1_sh_mask.h      | 48 +++++++++++++++++++
 5 files changed, 162 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/mmhub_v1_7.c b/drivers/gpu/drm/amd/amdgpu/mmhub_v1_7.c
index 9689e2b5d4e5..55659a4cbd10 100644
--- a/drivers/gpu/drm/amd/amdgpu/mmhub_v1_7.c
+++ b/drivers/gpu/drm/amd/amdgpu/mmhub_v1_7.c
@@ -172,6 +172,30 @@ static void mmhub_v1_7_init_tlb_regs(struct amdgpu_device *adev)
 	WREG32_SOC15(MMHUB, 0, regMC_VM_MX_L1_TLB_CNTL, tmp);
 }
 
+/* Set snoop bit for SDMA so that SDMA writes probe-invalidates RW lines */
+static void mmhub_v1_7_set_snoop(struct amdgpu_device *adev)
+{
+	uint32_t tmp;
+	int j;
+	uint32_t distance = regDAGB1_WRCLI_GPU_SNOOP_OVERRIDE -
+			    regDAGB0_WRCLI_GPU_SNOOP_OVERRIDE;
+
+	for (j = 0; j &lt; 5; j++) { /* DAGB instances */
+		tmp = RREG32_SOC15_OFFSET(MMHUB, 0,
+			regDAGB0_WRCLI_GPU_SNOOP_OVERRIDE, j*distance);
+		tmp |= (1 &lt;&lt; 15); /* SDMA client is BIT15 */
+		WREG32_SOC15_OFFSET(MMHUB, 0,
+			regDAGB0_WRCLI_GPU_SNOOP_OVERRIDE, j*distance, tmp);
+
+		tmp = RREG32_SOC15_OFFSET(MMHUB, 0,
+			regDAGB0_WRCLI_GPU_SNOOP_OVERRIDE_VALUE, j*distance);
+		tmp |= (1 &lt;&lt; 15);
+		WREG32_SOC15_OFFSET(MMHUB, 0,
+			regDAGB0_WRCLI_GPU_SNOOP_OVERRIDE_VALUE, j*distance, tmp);
+	}
+
+}
+
 static void mmhub_v1_7_init_cache_regs(struct amdgpu_device *adev)
 {
 	uint32_t tmp;
@@ -337,6 +361,7 @@ static int mmhub_v1_7_gart_enable(struct amdgpu_device *adev)
 	mmhub_v1_7_init_system_aperture_regs(adev);
 	mmhub_v1_7_init_tlb_regs(adev);
 	mmhub_v1_7_init_cache_regs(adev);
+	mmhub_v1_7_set_snoop(adev);
 
 	mmhub_v1_7_enable_system_domain(adev);
 	mmhub_v1_7_disable_identity_aperture(adev);
diff --git a/drivers/gpu/drm/amd/amdgpu/mmhub_v1_8.c b/drivers/gpu/drm/amd/amdgpu/mmhub_v1_8.c
index e646e5cef0a2..92afffd27415 100644
--- a/drivers/gpu/drm/amd/amdgpu/mmhub_v1_8.c
+++ b/drivers/gpu/drm/amd/amdgpu/mmhub_v1_8.c
@@ -213,6 +213,32 @@ static void mmhub_v1_8_init_tlb_regs(struct amdgpu_device *adev)
 	}
 }
 
+/* Set snoop bit for SDMA so that SDMA writes probe-invalidates RW lines */
+static void mmhub_v1_8_set_snoop(struct amdgpu_device *adev)
+{
+	uint32_t tmp, inst_mask;
+	int i, j;
+	uint32_t distance = regDAGB1_WRCLI_GPU_SNOOP_OVERRIDE -
+			    regDAGB0_WRCLI_GPU_SNOOP_OVERRIDE;
+
+	inst_mask = adev-&gt;aid_mask;
+	for_each_inst(i, inst_mask) {
+		for (j = 0; j &lt; 5; j++) { /* DAGB instances */
+			tmp = RREG32_SOC15_OFFSET(MMHUB, i,
+				regDAGB0_WRCLI_GPU_SNOOP_OVERRIDE, j*distance);
+			tmp |= (1 &lt;&lt; 15); /* SDMA client is BIT15 */
+			WREG32_SOC15_OFFSET(MMHUB, i,
+				regDAGB0_WRCLI_GPU_SNOOP_OVERRIDE, j*distance, tmp);
+
+			tmp = RREG32_SOC15_OFFSET(MMHUB, i,
+				regDAGB0_WRCLI_GPU_SNOOP_OVERRIDE_VALUE, j*distance);
+			tmp |= (1 &lt;&lt; 15);
+			WREG32_SOC15_OFFSET(MMHUB, i,
+				regDAGB0_WRCLI_GPU_SNOOP_OVERRIDE_VALUE, j*distance, tmp);
+		}
+	}
+}
+
 static void mmhub_v1_8_init_cache_regs(struct amdgpu_device *adev)
 {
 	uint32_t tmp, inst_mask;
@@ -418,6 +444,7 @@ static int mmhub_v1_8_gart_enable(struct amdgpu_device *adev)
 	mmhub_v1_8_init_system_aperture_regs(adev);
 	mmhub_v1_8_init_tlb_regs(adev);
 	mmhub_v1_8_init_cache_regs(adev);
+	mmhub_v1_8_set_snoop(adev);
 </pre>
    </blockquote>
    Why only change mmhub_v1_7/8, not other mmhub_v2/3/4 versions? Maybe
    the setting is not needed for old ASICS,&nbsp; only set this in
    mmhub_v9_4. <br>
    <blockquote type="cite" cite="mid:20250204230235.150757-1-Harish.Kasiviswanathan@amd.com">
      <pre class="moz-quote-pre" wrap="">
 	mmhub_v1_8_enable_system_domain(adev);
 	mmhub_v1_8_disable_identity_aperture(adev);
diff --git a/drivers/gpu/drm/amd/amdgpu/mmhub_v9_4.c b/drivers/gpu/drm/amd/amdgpu/mmhub_v9_4.c
index ff1b58e44689..557119cd1ecc 100644
--- a/drivers/gpu/drm/amd/amdgpu/mmhub_v9_4.c
+++ b/drivers/gpu/drm/amd/amdgpu/mmhub_v9_4.c
@@ -198,6 +198,35 @@ static void mmhub_v9_4_init_tlb_regs(struct amdgpu_device *adev, int hubid)
 			    hubid * MMHUB_INSTANCE_REGISTER_OFFSET, tmp);
 }
 
+/* Set snoop bit for SDMA so that SDMA writes probe-invalidates RW lines */
+static void mmhub_v9_4_set_snoop(struct amdgpu_device *adev, int hubid)
+{
+	uint32_t tmp;
+	int j;</pre>
    </blockquote>
    loop index uses variable i<br>
    <blockquote type="cite" cite="mid:20250204230235.150757-1-Harish.Kasiviswanathan@amd.com">
      <pre class="moz-quote-pre" wrap="">
+	uint32_t distance = mmDAGB1_WRCLI_GPU_SNOOP_OVERRIDE -
+			    mmDAGB0_WRCLI_GPU_SNOOP_OVERRIDE;
+
+	for (j = 0; j &lt; 4 - (2 * hubid); j++) {
+		/* DAGB instances 0 to 4 are in hub0 and 5 to 7 are in hub1 */</pre>
    </blockquote>
    <p>maybe define variable offset = hubid *
      MMHUB_INSTANCE_REGISTER_OFFSET + j * distance</p>
    <p>then use offset variable to remove the duplicate calculation.<br>
    </p>
    <p>Regards,</p>
    <p>Philip<br>
    </p>
    <blockquote type="cite" cite="mid:20250204230235.150757-1-Harish.Kasiviswanathan@amd.com">
      <pre class="moz-quote-pre" wrap="">
+		tmp = RREG32_SOC15_OFFSET(MMHUB, 0,
+			mmDAGB0_WRCLI_GPU_SNOOP_OVERRIDE,
+			hubid * MMHUB_INSTANCE_REGISTER_OFFSET + j * distance);
+		tmp |= (1 &lt;&lt; 15); /* SDMA client is BIT15 */
+		WREG32_SOC15_OFFSET(MMHUB, 0,
+			mmDAGB0_WRCLI_GPU_SNOOP_OVERRIDE,
+			hubid * MMHUB_INSTANCE_REGISTER_OFFSET + j * distance, tmp);
+
+		tmp = RREG32_SOC15_OFFSET(MMHUB, 0,
+			mmDAGB0_WRCLI_GPU_SNOOP_OVERRIDE_VALUE,
+			hubid * MMHUB_INSTANCE_REGISTER_OFFSET + j * distance);
+		tmp |= (1 &lt;&lt; 15);
+		WREG32_SOC15_OFFSET(MMHUB, 0,
+			mmDAGB0_WRCLI_GPU_SNOOP_OVERRIDE_VALUE,
+			hubid * MMHUB_INSTANCE_REGISTER_OFFSET + j * distance, tmp);
+	}
+
+}
+
 static void mmhub_v9_4_init_cache_regs(struct amdgpu_device *adev, int hubid)
 {
 	uint32_t tmp;
@@ -392,6 +421,7 @@ static int mmhub_v9_4_gart_enable(struct amdgpu_device *adev)
 		if (!amdgpu_sriov_vf(adev))
 			mmhub_v9_4_init_cache_regs(adev, i);
 
+		mmhub_v9_4_set_snoop(adev, i);
 		mmhub_v9_4_enable_system_domain(adev, i);
 		if (!amdgpu_sriov_vf(adev))
 			mmhub_v9_4_disable_identity_aperture(adev, i);
diff --git a/drivers/gpu/drm/amd/include/asic_reg/mmhub/mmhub_9_4_1_offset.h b/drivers/gpu/drm/amd/include/asic_reg/mmhub/mmhub_9_4_1_offset.h
index c488d4a50cf4..b2252deabc17 100644
--- a/drivers/gpu/drm/amd/include/asic_reg/mmhub/mmhub_9_4_1_offset.h
+++ b/drivers/gpu/drm/amd/include/asic_reg/mmhub/mmhub_9_4_1_offset.h
@@ -203,6 +203,10 @@
 #define mmDAGB0_WR_DATA_CREDIT_BASE_IDX                                                                1
 #define mmDAGB0_WR_MISC_CREDIT                                                                         0x0058
 #define mmDAGB0_WR_MISC_CREDIT_BASE_IDX                                                                1
+#define mmDAGB0_WRCLI_GPU_SNOOP_OVERRIDE                                                               0x005b
+#define mmDAGB0_WRCLI_GPU_SNOOP_OVERRIDE_BASE_IDX                                                      1
+#define mmDAGB0_WRCLI_GPU_SNOOP_OVERRIDE_VALUE                                                         0x005c
+#define mmDAGB0_WRCLI_GPU_SNOOP_OVERRIDE_VALUE_BASE_IDX                                                1
 #define mmDAGB0_WRCLI_ASK_PENDING                                                                      0x005d
 #define mmDAGB0_WRCLI_ASK_PENDING_BASE_IDX                                                             1
 #define mmDAGB0_WRCLI_GO_PENDING                                                                       0x005e
@@ -455,6 +459,10 @@
 #define mmDAGB1_WR_DATA_CREDIT_BASE_IDX                                                                1
 #define mmDAGB1_WR_MISC_CREDIT                                                                         0x00d8
 #define mmDAGB1_WR_MISC_CREDIT_BASE_IDX                                                                1
+#define mmDAGB1_WRCLI_GPU_SNOOP_OVERRIDE                                                               0x00db
+#define mmDAGB1_WRCLI_GPU_SNOOP_OVERRIDE_BASE_IDX                                                      1
+#define mmDAGB1_WRCLI_GPU_SNOOP_OVERRIDE_VALUE                                                         0x00dc
+#define mmDAGB1_WRCLI_GPU_SNOOP_OVERRIDE_VALUE_BASE_IDX                                                1
 #define mmDAGB1_WRCLI_ASK_PENDING                                                                      0x00dd
 #define mmDAGB1_WRCLI_ASK_PENDING_BASE_IDX                                                             1
 #define mmDAGB1_WRCLI_GO_PENDING                                                                       0x00de
@@ -707,6 +715,10 @@
 #define mmDAGB2_WR_DATA_CREDIT_BASE_IDX                                                                1
 #define mmDAGB2_WR_MISC_CREDIT                                                                         0x0158
 #define mmDAGB2_WR_MISC_CREDIT_BASE_IDX                                                                1
+#define mmDAGB2_WRCLI_GPU_SNOOP_OVERRIDE                                                               0x015b
+#define mmDAGB2_WRCLI_GPU_SNOOP_OVERRIDE_BASE_IDX                                                      1
+#define mmDAGB2_WRCLI_GPU_SNOOP_OVERRIDE_VALUE                                                         0x015c
+#define mmDAGB2_WRCLI_GPU_SNOOP_OVERRIDE_VALUE_BASE_IDX                                                1
 #define mmDAGB2_WRCLI_ASK_PENDING                                                                      0x015d
 #define mmDAGB2_WRCLI_ASK_PENDING_BASE_IDX                                                             1
 #define mmDAGB2_WRCLI_GO_PENDING                                                                       0x015e
@@ -959,6 +971,10 @@
 #define mmDAGB3_WR_DATA_CREDIT_BASE_IDX                                                                1
 #define mmDAGB3_WR_MISC_CREDIT                                                                         0x01d8
 #define mmDAGB3_WR_MISC_CREDIT_BASE_IDX                                                                1
+#define mmDAGB3_WRCLI_GPU_SNOOP_OVERRIDE                                                               0x01db
+#define mmDAGB3_WRCLI_GPU_SNOOP_OVERRIDE_BASE_IDX                                                      1
+#define mmDAGB3_WRCLI_GPU_SNOOP_OVERRIDE_VALUE                                                         0x01dc
+#define mmDAGB3_WRCLI_GPU_SNOOP_OVERRIDE_VALUE_BASE_IDX                                                1
 #define mmDAGB3_WRCLI_ASK_PENDING                                                                      0x01dd
 #define mmDAGB3_WRCLI_ASK_PENDING_BASE_IDX                                                             1
 #define mmDAGB3_WRCLI_GO_PENDING                                                                       0x01de
@@ -1211,6 +1227,10 @@
 #define mmDAGB4_WR_DATA_CREDIT_BASE_IDX                                                                1
 #define mmDAGB4_WR_MISC_CREDIT                                                                         0x0258
 #define mmDAGB4_WR_MISC_CREDIT_BASE_IDX                                                                1
+#define mmDAGB4_WRCLI_GPU_SNOOP_OVERRIDE                                                               0x025b
+#define mmDAGB4_WRCLI_GPU_SNOOP_OVERRIDE_BASE_IDX                                                      1
+#define mmDAGB4_WRCLI_GPU_SNOOP_OVERRIDE_VALUE                                                         0x025c
+#define mmDAGB4_WRCLI_GPU_SNOOP_OVERRIDE_VALUE_BASE_IDX                                                1
 #define mmDAGB4_WRCLI_ASK_PENDING                                                                      0x025d
 #define mmDAGB4_WRCLI_ASK_PENDING_BASE_IDX                                                             1
 #define mmDAGB4_WRCLI_GO_PENDING                                                                       0x025e
@@ -4793,6 +4813,10 @@
 #define mmDAGB5_WR_DATA_CREDIT_BASE_IDX                                                                1
 #define mmDAGB5_WR_MISC_CREDIT                                                                         0x3058
 #define mmDAGB5_WR_MISC_CREDIT_BASE_IDX                                                                1
+#define mmDAGB5_WRCLI_GPU_SNOOP_OVERRIDE                                                               0x305b
+#define mmDAGB5_WRCLI_GPU_SNOOP_OVERRIDE_BASE_IDX                                                      1
+#define mmDAGB5_WRCLI_GPU_SNOOP_OVERRIDE_VALUE                                                         0x305c
+#define mmDAGB5_WRCLI_GPU_SNOOP_OVERRIDE_VALUE_BASE_IDX                                                1
 #define mmDAGB5_WRCLI_ASK_PENDING                                                                      0x305d
 #define mmDAGB5_WRCLI_ASK_PENDING_BASE_IDX                                                             1
 #define mmDAGB5_WRCLI_GO_PENDING                                                                       0x305e
@@ -5045,6 +5069,10 @@
 #define mmDAGB6_WR_DATA_CREDIT_BASE_IDX                                                                1
 #define mmDAGB6_WR_MISC_CREDIT                                                                         0x30d8
 #define mmDAGB6_WR_MISC_CREDIT_BASE_IDX                                                                1
+#define mmDAGB6_WRCLI_GPU_SNOOP_OVERRIDE                                                               0x30db
+#define mmDAGB6_WRCLI_GPU_SNOOP_OVERRIDE_BASE_IDX                                                      1
+#define mmDAGB6_WRCLI_GPU_SNOOP_OVERRIDE_VALUE                                                         0x30dc
+#define mmDAGB6_WRCLI_GPU_SNOOP_OVERRIDE_VALUE_BASE_IDX                                                1
 #define mmDAGB6_WRCLI_ASK_PENDING                                                                      0x30dd
 #define mmDAGB6_WRCLI_ASK_PENDING_BASE_IDX                                                             1
 #define mmDAGB6_WRCLI_GO_PENDING                                                                       0x30de
@@ -5297,6 +5325,10 @@
 #define mmDAGB7_WR_DATA_CREDIT_BASE_IDX                                                                1
 #define mmDAGB7_WR_MISC_CREDIT                                                                         0x3158
 #define mmDAGB7_WR_MISC_CREDIT_BASE_IDX                                                                1
+#define mmDAGB7_WRCLI_GPU_SNOOP_OVERRIDE                                                               0x315b
+#define mmDAGB7_WRCLI_GPU_SNOOP_OVERRIDE_BASE_IDX                                                      1
+#define mmDAGB7_WRCLI_GPU_SNOOP_OVERRIDE_VALUE                                                         0x315c
+#define mmDAGB7_WRCLI_GPU_SNOOP_OVERRIDE_VALUE_BASE_IDX                                                1
 #define mmDAGB7_WRCLI_ASK_PENDING                                                                      0x315d
 #define mmDAGB7_WRCLI_ASK_PENDING_BASE_IDX                                                             1
 #define mmDAGB7_WRCLI_GO_PENDING                                                                       0x315e
diff --git a/drivers/gpu/drm/amd/include/asic_reg/mmhub/mmhub_9_4_1_sh_mask.h b/drivers/gpu/drm/amd/include/asic_reg/mmhub/mmhub_9_4_1_sh_mask.h
index 2969fbf282b7..5069d2fd467f 100644
--- a/drivers/gpu/drm/amd/include/asic_reg/mmhub/mmhub_9_4_1_sh_mask.h
+++ b/drivers/gpu/drm/amd/include/asic_reg/mmhub/mmhub_9_4_1_sh_mask.h
@@ -1532,6 +1532,12 @@
 //DAGB0_WRCLI_DBUS_GO_PENDING
 #define DAGB0_WRCLI_DBUS_GO_PENDING__BUSY__SHIFT                                                              0x0
 #define DAGB0_WRCLI_DBUS_GO_PENDING__BUSY_MASK                                                                0xFFFFFFFFL
+//DAGB0_WRCLI_GPU_SNOOP_OVERRIDE
+#define DAGB0_WRCLI_GPU_SNOOP_OVERRIDE__ENABLE__SHIFT                                                         0x0
+#define DAGB0_WRCLI_GPU_SNOOP_OVERRIDE__ENABLE_MASK                                                           0xFFFFFFFFL
+//DAGB0_WRCLI_GPU_SNOOP_OVERRIDE_VALUE
+#define DAGB0_WRCLI_GPU_SNOOP_OVERRIDE_VALUE__ENABLE__SHIFT                                                   0x0
+#define DAGB0_WRCLI_GPU_SNOOP_OVERRIDE_VALUE__ENABLE_MASK                                                     0xFFFFFFFFL
 //DAGB0_DAGB_DLY
 #define DAGB0_DAGB_DLY__DLY__SHIFT                                                                            0x0
 #define DAGB0_DAGB_DLY__CLI__SHIFT                                                                            0x8
@@ -3207,6 +3213,12 @@
 //DAGB1_WRCLI_DBUS_GO_PENDING
 #define DAGB1_WRCLI_DBUS_GO_PENDING__BUSY__SHIFT                                                              0x0
 #define DAGB1_WRCLI_DBUS_GO_PENDING__BUSY_MASK                                                                0xFFFFFFFFL
+//DAGB1_WRCLI_GPU_SNOOP_OVERRIDE
+#define DAGB1_WRCLI_GPU_SNOOP_OVERRIDE__ENABLE__SHIFT                                                         0x0
+#define DAGB1_WRCLI_GPU_SNOOP_OVERRIDE__ENABLE_MASK                                                           0xFFFFFFFFL
+//DAGB1_WRCLI_GPU_SNOOP_OVERRIDE_VALUE
+#define DAGB1_WRCLI_GPU_SNOOP_OVERRIDE_VALUE__ENABLE__SHIFT                                                   0x0
+#define DAGB1_WRCLI_GPU_SNOOP_OVERRIDE_VALUE__ENABLE_MASK                                                     0xFFFFFFFFL
 //DAGB1_DAGB_DLY
 #define DAGB1_DAGB_DLY__DLY__SHIFT                                                                            0x0
 #define DAGB1_DAGB_DLY__CLI__SHIFT                                                                            0x8
@@ -4882,6 +4894,12 @@
 //DAGB2_WRCLI_DBUS_GO_PENDING
 #define DAGB2_WRCLI_DBUS_GO_PENDING__BUSY__SHIFT                                                              0x0
 #define DAGB2_WRCLI_DBUS_GO_PENDING__BUSY_MASK                                                                0xFFFFFFFFL
+//DAGB2_WRCLI_GPU_SNOOP_OVERRIDE
+#define DAGB2_WRCLI_GPU_SNOOP_OVERRIDE__ENABLE__SHIFT                                                         0x0
+#define DAGB2_WRCLI_GPU_SNOOP_OVERRIDE__ENABLE_MASK                                                           0xFFFFFFFFL
+//DAGB2_WRCLI_GPU_SNOOP_OVERRIDE_VALUE
+#define DAGB2_WRCLI_GPU_SNOOP_OVERRIDE_VALUE__ENABLE__SHIFT                                                   0x0
+#define DAGB2_WRCLI_GPU_SNOOP_OVERRIDE_VALUE__ENABLE_MASK                                                     0xFFFFFFFFL
 //DAGB2_DAGB_DLY
 #define DAGB2_DAGB_DLY__DLY__SHIFT                                                                            0x0
 #define DAGB2_DAGB_DLY__CLI__SHIFT                                                                            0x8
@@ -6557,6 +6575,12 @@
 //DAGB3_WRCLI_DBUS_GO_PENDING
 #define DAGB3_WRCLI_DBUS_GO_PENDING__BUSY__SHIFT                                                              0x0
 #define DAGB3_WRCLI_DBUS_GO_PENDING__BUSY_MASK                                                                0xFFFFFFFFL
+//DAGB3_WRCLI_GPU_SNOOP_OVERRIDE
+#define DAGB3_WRCLI_GPU_SNOOP_OVERRIDE__ENABLE__SHIFT                                                         0x0
+#define DAGB3_WRCLI_GPU_SNOOP_OVERRIDE__ENABLE_MASK                                                           0xFFFFFFFFL
+//DAGB3_WRCLI_GPU_SNOOP_OVERRIDE_VALUE
+#define DAGB3_WRCLI_GPU_SNOOP_OVERRIDE_VALUE__ENABLE__SHIFT                                                   0x0
+#define DAGB3_WRCLI_GPU_SNOOP_OVERRIDE_VALUE__ENABLE_MASK                                                     0xFFFFFFFFL
 //DAGB3_DAGB_DLY
 #define DAGB3_DAGB_DLY__DLY__SHIFT                                                                            0x0
 #define DAGB3_DAGB_DLY__CLI__SHIFT                                                                            0x8
@@ -8232,6 +8256,12 @@
 //DAGB4_WRCLI_DBUS_GO_PENDING
 #define DAGB4_WRCLI_DBUS_GO_PENDING__BUSY__SHIFT                                                              0x0
 #define DAGB4_WRCLI_DBUS_GO_PENDING__BUSY_MASK                                                                0xFFFFFFFFL
+//DAGB4_WRCLI_GPU_SNOOP_OVERRIDE
+#define DAGB4_WRCLI_GPU_SNOOP_OVERRIDE__ENABLE__SHIFT                                                         0x0
+#define DAGB4_WRCLI_GPU_SNOOP_OVERRIDE__ENABLE_MASK                                                           0xFFFFFFFFL
+//DAGB4_WRCLI_GPU_SNOOP_OVERRIDE_VALUE
+#define DAGB4_WRCLI_GPU_SNOOP_OVERRIDE_VALUE__ENABLE__SHIFT                                                   0x0
+#define DAGB4_WRCLI_GPU_SNOOP_OVERRIDE_VALUE__ENABLE_MASK                                                     0xFFFFFFFFL
 //DAGB4_DAGB_DLY
 #define DAGB4_DAGB_DLY__DLY__SHIFT                                                                            0x0
 #define DAGB4_DAGB_DLY__CLI__SHIFT                                                                            0x8
@@ -28737,6 +28767,12 @@
 //DAGB5_WRCLI_DBUS_GO_PENDING
 #define DAGB5_WRCLI_DBUS_GO_PENDING__BUSY__SHIFT                                                              0x0
 #define DAGB5_WRCLI_DBUS_GO_PENDING__BUSY_MASK                                                                0xFFFFFFFFL
+//DAGB5_WRCLI_GPU_SNOOP_OVERRIDE
+#define DAGB5_WRCLI_GPU_SNOOP_OVERRIDE__ENABLE__SHIFT                                                         0x0
+#define DAGB5_WRCLI_GPU_SNOOP_OVERRIDE__ENABLE_MASK                                                           0xFFFFFFFFL
+//DAGB5_WRCLI_GPU_SNOOP_OVERRIDE_VALUE
+#define DAGB5_WRCLI_GPU_SNOOP_OVERRIDE_VALUE__ENABLE__SHIFT                                                   0x0
+#define DAGB5_WRCLI_GPU_SNOOP_OVERRIDE_VALUE__ENABLE_MASK                                                     0xFFFFFFFFL
 //DAGB5_DAGB_DLY
 #define DAGB5_DAGB_DLY__DLY__SHIFT                                                                            0x0
 #define DAGB5_DAGB_DLY__CLI__SHIFT                                                                            0x8
@@ -30412,6 +30448,12 @@
 //DAGB6_WRCLI_DBUS_GO_PENDING
 #define DAGB6_WRCLI_DBUS_GO_PENDING__BUSY__SHIFT                                                              0x0
 #define DAGB6_WRCLI_DBUS_GO_PENDING__BUSY_MASK                                                                0xFFFFFFFFL
+//DAGB6_WRCLI_GPU_SNOOP_OVERRIDE
+#define DAGB6_WRCLI_GPU_SNOOP_OVERRIDE__ENABLE__SHIFT                                                         0x0
+#define DAGB6_WRCLI_GPU_SNOOP_OVERRIDE__ENABLE_MASK                                                           0xFFFFFFFFL
+//DAGB6_WRCLI_GPU_SNOOP_OVERRIDE_VALUE
+#define DAGB6_WRCLI_GPU_SNOOP_OVERRIDE_VALUE__ENABLE__SHIFT                                                   0x0
+#define DAGB6_WRCLI_GPU_SNOOP_OVERRIDE_VALUE__ENABLE_MASK                                                     0xFFFFFFFFL
 //DAGB6_DAGB_DLY
 #define DAGB6_DAGB_DLY__DLY__SHIFT                                                                            0x0
 #define DAGB6_DAGB_DLY__CLI__SHIFT                                                                            0x8
@@ -32087,6 +32129,12 @@
 //DAGB7_WRCLI_DBUS_GO_PENDING
 #define DAGB7_WRCLI_DBUS_GO_PENDING__BUSY__SHIFT                                                              0x0
 #define DAGB7_WRCLI_DBUS_GO_PENDING__BUSY_MASK                                                                0xFFFFFFFFL
+//DAGB7_WRCLI_GPU_SNOOP_OVERRIDE
+#define DAGB7_WRCLI_GPU_SNOOP_OVERRIDE__ENABLE__SHIFT                                                         0x0
+#define DAGB7_WRCLI_GPU_SNOOP_OVERRIDE__ENABLE_MASK                                                           0xFFFFFFFFL
+//DAGB7_WRCLI_GPU_SNOOP_OVERRIDE_VALUE
+#define DAGB7_WRCLI_GPU_SNOOP_OVERRIDE_VALUE__ENABLE__SHIFT                                                   0x0
+#define DAGB7_WRCLI_GPU_SNOOP_OVERRIDE_VALUE__ENABLE_MASK                                                     0xFFFFFFFFL
 //DAGB7_DAGB_DLY
 #define DAGB7_DAGB_DLY__DLY__SHIFT                                                                            0x0
 #define DAGB7_DAGB_DLY__CLI__SHIFT                                                                            0x8
</pre>
    </blockquote>
  </body>
</html>
