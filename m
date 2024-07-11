Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7C091C3DA41
	for <amd-gfx@archiver.kernel.org>; Thu, 11 Jul 2024 14:57:56 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2348A10EAB0;
	Thu, 11 Jul 2024 14:57:56 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="fDUSiFow";
	dkim-atps=neutral
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2049.outbound.protection.outlook.com [40.107.223.49])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A2A4D10EAB0
 for <amd-gfx@lists.freedesktop.org>; Thu, 11 Jul 2024 14:57:54 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vhtK9kDzuuyFDO+HZ669luvsIk0n26gVmJ4JHxPdDjbobiyM88j2pJr8w7G6NuFoL/sNKxvEPPUClf7lfS6yRhWvzfzXD3ZKb8Hbtkqr28Py0wYTBF5RIUtyIEeHrgxu36Xho6Vs4rgGwX6JIhJmI8cpwuw9niSs4VfmXjUv5z5PvrvNfWbrmGPDfJC1pKeflkJgcIXe+NMFkMZJxeWxUl5VA7DZwt5tiwTmzugyT5NmO6DB0HGYYwkFWEey9Qf9I36C+DaELc5zSyW54PV/KOEbAVUihCh3hhfYRqHZMUtqVNequU27tRq65Jfsdw09tYJxxz/oyvMxBt8wE2wOtA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6Nj5kGb9yaZR0PSItyPFEn9f9m82wWa3+OJPKGjRAXg=;
 b=GS45kv9kGemOJ/PJyWwqkezCynIG1+TQ+NGtYxzVobrUi0nEG3/Mifsa21cIU6+QA/qr3XH+kT95klcQZjVXjvGd4l6HsjPbEWcmwFptK1jH8pc9rhIf+3SvRSfwS5iKu12N6CdqIKJFufL7duh7nkaCN458CewpMGXAJ8IDvbieTX9bxtKKELnhV5VKJRIv6oo9gNBZGLeCOWp1xT8is+KEKvgdtyI1+N2+vdvORJhR+LXCaHexcVofGYLv9HxcC8WhssL1Nc/QXMJYE95FMW6hEBh+nJxHd+zmRL2xa0oN3+ObMdl+ALj/ncnApOA2ZeyjWZsBy1DH7b3qMKD1Tg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6Nj5kGb9yaZR0PSItyPFEn9f9m82wWa3+OJPKGjRAXg=;
 b=fDUSiFowa/nAiJ4nfSp2s/5JApjDRYjJSMLTncbvPlaz3MZNPwrMRJrwPnFSFZHb1QLYwjlaD3A/1FX2Wjd6Fka88J8A4Rzn6K5GFi6QNoEcTHiwiqkf5UV4TtnemuRi2EIr1Qz8FPFpuczMxLdGvgJxXm7ylCgVbn1VLLwNESI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
 by MN2PR12MB4469.namprd12.prod.outlook.com (2603:10b6:208:268::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7741.36; Thu, 11 Jul
 2024 14:57:48 +0000
Received: from MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::37ee:a763:6d04:81ca]) by MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::37ee:a763:6d04:81ca%6]) with mapi id 15.20.7741.033; Thu, 11 Jul 2024
 14:57:48 +0000
Message-ID: <264bd285-d2cf-45c6-9b48-2b96ee533b36@amd.com>
Date: Thu, 11 Jul 2024 09:57:46 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: amdgpu [drm] *ERROR* dc_dmub_srv_log_diagnostic_data: DMCUB error
 - collecting diagnostic data
To: Thomas Glanzmann <thomas@glanzmann.de>,
 Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 Xinhui.Pan@amd.com
Cc: amd-gfx@lists.freedesktop.org
References: <Zo4Z2yCK4RrYtJKo@glanzmann.de> <Zo7M9us1xwUdYaP6@glanzmann.de>
Content-Language: en-US
From: Mario Limonciello <mario.limonciello@amd.com>
In-Reply-To: <Zo7M9us1xwUdYaP6@glanzmann.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SN6PR05CA0009.namprd05.prod.outlook.com
 (2603:10b6:805:de::22) To MN0PR12MB6101.namprd12.prod.outlook.com
 (2603:10b6:208:3cb::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR12MB6101:EE_|MN2PR12MB4469:EE_
X-MS-Office365-Filtering-Correlation-Id: 02cdeef1-a150-47b0-de0a-08dca1b9d44a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?TUNoTThuSmpmVEp2OXVDNEt6VFFKanVjSmNXUjVNaG1JamJtczg5MmN6eVBS?=
 =?utf-8?B?YWovMFlmcFZqZml2aExpdG44UzdqcmxCcFh0aE14QThzclMxaW9ycjJsR0pO?=
 =?utf-8?B?M1QzemFEQUl5R3VxZGVHQVAvTGgvbDRSeVBaejhYZEdWN0d6L2V0WThmbUhw?=
 =?utf-8?B?Y2dSY0syZk4wMy9NMGFZMU1CY0ZNZ3FRVEMrSG85T2F3dzYrR1VJTEt0dnJH?=
 =?utf-8?B?bnJTejJrTENlOVdlK0F3U21MdVZJdTRCV0YrVGVJT2VrQk8ySmhQQ1h3Y1Zt?=
 =?utf-8?B?enF6L3IrZmErNFFYcHlXd2k0aE0reW80UWRRRTBMVlJZa0ROcUx5S1NsQzRB?=
 =?utf-8?B?emNYbTZpOTM0dHFOT3VoK0doa3QzaDNtcG1FYWlaTUVPK0ExRGExRmIvTG5H?=
 =?utf-8?B?R2NDNCtvQjNDR080aFY3Q0lKNTNtUlN0UnZ0bWtsOFRpWlovS1ZQcklTSDNh?=
 =?utf-8?B?c28waEpUb05zNU5sRGdvRWpTWUlsNUF1K1JwblpJT21tQ0U4WWJsbTVPN2lt?=
 =?utf-8?B?RVRpTnBFOWJtSXREblZ4bTM3VEVncVRsZHNoL040N3kwTVNMK3cvTmFSZlEw?=
 =?utf-8?B?RE9OVlRUeDFRSnE2dzVBSjQvMDlWYnpaQU8vaWRyVDl5UmkzRW5wWTgvb1hV?=
 =?utf-8?B?blc5WmdJaXA2QjgrWUloZXNjOGVYS0gvTDhwdXhyN3J6Nys4UUwvYzdMQXJV?=
 =?utf-8?B?ZTJ6RFZ4dWpXL0RqbHZQWWZlbjRJSWpISVhlWWUxNFhpcWdsZFFnMUh6MDNj?=
 =?utf-8?B?UkYrUVBQYUY2a0FVa0R0T2lxNi8vOVVNaUJVUVRWSXBZWUh0Tm8zeUVrcERY?=
 =?utf-8?B?em5kbG92MWJqdC91Q0NWQXBUd05RZHVnci8vZXJkTGtVNjNZVGowZjhVSjhI?=
 =?utf-8?B?VWxHSjhKRFUrQlRsLzFwTGJJNDFFemRjZ2Y4SDJSZEVGYUYrUDVjTElTNmRa?=
 =?utf-8?B?R2c4M1JYUGx2SWhiWDZmYkNDMGVjY1BDSS90aXBSVjBYdUgzRFBGNW5KeERl?=
 =?utf-8?B?c3RRdzk4c0xLQmxYdDFvU2tBVk14aGVRUFZjYWxrNDVUZnN5ZTA2cU4vTnlV?=
 =?utf-8?B?UmpCZG0ybDN6aUE0SGF3Y3RGL0lhOE1idnpYZUtpanZGY3BZTnZWdml5NFRV?=
 =?utf-8?B?ZWxxUm1jL3lzMGwwcEVkVTMzK2lxcnBFcDhrNllhQXZXcmloV2s1M1pFSUtu?=
 =?utf-8?B?SlZjcDZEZDFzS2VXSWlMaG9XZXlqWjd3QlplUGVpT1YyVjZCVjRYbjlvUVlT?=
 =?utf-8?B?WldwZjZHVHprUnRMREs3c1d4cTVoR0N2Z2dTY0l6dldNa09GN0R2VE1vZjZh?=
 =?utf-8?B?VTJIaVFhRmlacDdkeW9MNTZFV2hleWZ4OWNUczJoRGF1U2VGNTFmZ1pnUTcw?=
 =?utf-8?B?aDBDQzBWeDZ5c0FHWWs2OXBJeVd0amZzOHhlUkYwb016dXVieUZEUHBtbEU1?=
 =?utf-8?B?Q1UwMmUzQVU5UlZXd1g1V3FHWHZDRm5WaXZFQmQyTkNEV2tlaWlWZWVveitR?=
 =?utf-8?B?UnAwdVlyb1RNdkVvbzNiMi9vMkJ2aDU4ODBrUUVVRVhGMWxPN2M0N3kwYXNN?=
 =?utf-8?B?TVhueWdobTNzaEh5a0pxaFliZ0VJa2h1WFZ1NWp6cGNBUDh5a2lzOEp5S3ZH?=
 =?utf-8?B?SlFuQzJJVmZSNkY0ekRXMXF2bXlaSVpoMlFoMlR1Yk5OY3V5b3J6bTExMlhO?=
 =?utf-8?B?N3dCZk1lVWVKQW1oVXFvSGRZNGIyalpPYlNoTVZJdkxhaERndWJPSm5zVU9h?=
 =?utf-8?B?UXcrYXdEUnA4U2tYM1FON0tNNFVac2NGSGR1eHpGem1ETWtiUVB3aStCVzVV?=
 =?utf-8?B?MXZLaG9WbDEwbGx1eldzUT09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN0PR12MB6101.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?YU92eEw4L054c3JGMHZwRFB2Y3lqR3VRaHJBREQ2WUJkd241TVJhazd1dzNY?=
 =?utf-8?B?UHRSRjdONkJHU25qTURXYmsvVDgvRlBwdm8zcEozRDA3ckRKcnozK1NyM0lR?=
 =?utf-8?B?bzNiazVINTk1bnJqNFFnd1UrTTlGblREbWZLVmMvZ0hWUWZGNk8zSU55VFJm?=
 =?utf-8?B?T0Y1cGFROC8xcU1qc1N2ejZqRjJtNTlEUFpNZ0k4dCtkbkxtSUVpWTFKUTM0?=
 =?utf-8?B?Wk1oNUF2Z3Z1b0xUZnF5SUh0QUxWRkVlU04rVVBDNVBwSVhCamxkdUw1QlFQ?=
 =?utf-8?B?SzN1V0hTM1lPTzJHRUJ4V0NwbGdMQ0VJS2ZpOVpyazVOOGRBSmxBN2RWMEhw?=
 =?utf-8?B?dCttU1R6WWhIcEw4UGRXWVpIQzNaeDJUZTM3ajlJRzlyaDJTRERJSGFiN3dy?=
 =?utf-8?B?R1lxdThqU1MwUVphQzdyQncwTWkyRDhZTjlYYXE0Tk9oYi9mWUdtUmtkTVE3?=
 =?utf-8?B?RHBrRXlJbDJjZDhaY0I4bktubjZxbmFBb2s0Sm40TWFsMFk2TlZ5ZGZsNDFt?=
 =?utf-8?B?RHBRM1UzUGdJR2tZR2U1SzBicWRjeko2RnpkZE11N0tTTlhXa2NhM3ViMGdJ?=
 =?utf-8?B?S3F2aDhOdVJqVzhSQ01TM2FVZCt3Uk1rS0hoOFhvYmlzSlgzUWJNNGRFQmcz?=
 =?utf-8?B?RVFnK2c0MlNvRDhZOVVJcmRBRUhIVFRJN3NrV2poZUdZQlhxNzYzK0N5RFdn?=
 =?utf-8?B?WFRzc05OTCsrMis5NHpiTXhUQUpEeXNxRUVLNysvTE9pem5qMldMbWMwbCtZ?=
 =?utf-8?B?MlpQd2lKMC9jN2xmK0VsOHlsbU5qY1BoVTJVT2w4YnM3RFV0ZTA2bmhUWnlS?=
 =?utf-8?B?akVhUHJmUW14QklDU21DRVVNSUx5ODBoRmJJdnFTTUJOSk50bW0wRWVrOTNO?=
 =?utf-8?B?OXlYNW56anl6M1dWY1ZyQXg5aFVnYk5vNENSRlFQTldQMWVUdjNiaXFHY3E4?=
 =?utf-8?B?UU1UK0Q3RW9Kam55L0RFZG4zU256MG5MWEJVL2FJRGVST3Vib28rSytyWUFT?=
 =?utf-8?B?UXVLWXk2UzRicmZzcU56SFJKSDZwaUo0RVBNZ0d6NjNIVjY3MmtuOXJPQkxj?=
 =?utf-8?B?MysrWUNFQkx4ZlpwTFd6TWNMVE1sOXFocGc1MDZFSGlTdkZoMzlWOHBwN1I4?=
 =?utf-8?B?a2g3ZVlyaFgyQlYzZU5uV1YxZ3YzMnpiUzhvbzRFM2Q4dWJIc241eWxpTE8r?=
 =?utf-8?B?YWJFd1ZtT1BTMG5LMkZNNHArazNXSE1KVzlqcWl2UUg2ZEhUZlBHUjkySUxn?=
 =?utf-8?B?VUc5YzdtMG5OVXhGL0M4ZGtuUlRNUVY1RFgxWi9PWWlFaDNkS0RSQWxwL1VP?=
 =?utf-8?B?WnZTTUFpNEU2KytSR1c3S0lGMGFXR0R5WXZHUC8rWGI3YTU0dml3dnRlbklZ?=
 =?utf-8?B?N3c1WGpEQW1GOGRXRmVoV1BUZ2tqbHBJdENiM2Q4Y0UwaFdzaGlMMm8yZ0RQ?=
 =?utf-8?B?bFZPSDlTdmNQVlNpM0RQVnJQbHlNcExCV1JucmI1LzcxbDRudnAvZTArNHpj?=
 =?utf-8?B?SU12em9IQTRHbVVmRVVwRjRRSnNPbDFvMXQ1VEM4MTdTbWtMUlFsRVRYdE9Z?=
 =?utf-8?B?bFgybHFnc0hUb1R0QzNxN1dMQ3Rnb2NkUEhOR3pXUU8wR2tJUFhPM1VFMFkr?=
 =?utf-8?B?TmF2dVVnalY5Q0Y3cklGRXlFOTVmNkhtRitkRlYrckRPVm11OEdGTnJPK0NJ?=
 =?utf-8?B?T0k3ellQa1EweTZjMHRWaXp3VnR4bityQ1NVRm0wNFV3dy9reFpvOC9vQXhC?=
 =?utf-8?B?U0dVNHNabEl0T3loanZyWDVEUWZCSml1U1NoUTFrUVI0VTc0bkJMSE9sbjBl?=
 =?utf-8?B?a3gxcDdvMTlSNXZTaXprNVpvWnE5MjlLNEtKcTloS0MreC85cFQ0Nkg1TUNu?=
 =?utf-8?B?OFNBcGpFT0VnR0IycU13MmZTYU1lK1p5YjNBeWtTdnVNNE4yN0VmaXBJMk9R?=
 =?utf-8?B?bGtsQTBwelZlYkJwOEI4c3ZYTUVWVy9tbmt5Y3ZLR0F1V1dNZFlsNGgvTDZt?=
 =?utf-8?B?K1pCSTdYYklQOU9NbnQ0M3NNaUM5cEc1R1hwNFhiUVlGaEpNZ2ZnMENKLzEy?=
 =?utf-8?B?cVZKaW9SYUswNm5udnk3WDlmKy9ta0RJUmtVOW1HcjlOZzdDamI4YjE2STNG?=
 =?utf-8?Q?BXNoo87g+kdhoFZHC+vWxG2b9?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 02cdeef1-a150-47b0-de0a-08dca1b9d44a
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jul 2024 14:57:48.5122 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SV00KRV8eAI2I3bDAmhichfdo1hHclUbr7SURDYx3JAf1XaxA+Fc0VGBKzbYD5udQTPodluBR0Jbi6lt0VJKhw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4469
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

On 7/10/2024 13:03, Thomas Glanzmann wrote:
> Hello,
> 
> * Thomas Glanzmann <thomas@glanzmann.de> [2024-07-10 07:19]:
>> [   11.902016] amdgpu 0000:0b:00.0: [drm] *ERROR* dc_dmub_srv_log_diagnostic_data: DMCUB error - collecting diagnostic data
> 
> I resolved the issue by updating my firmware:
> 
> git clone https://git.kernel.org/pub/scm/linux/kernel/git/firmware/linux-firmware.git
> cd linux-firmware.git
> sudo make install
> sudo reboot
> 
> Cheers,
>          Thomas
> 

You're not the first person to complain about problems root caused with 
extremely outdated firmware in Debian.

Can I ask you to please file a request with Debian to update all of 
amdgpu firmware to a new snapshot?

Thanks,
