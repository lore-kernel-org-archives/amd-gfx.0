Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 670BEC5B552
	for <amd-gfx@archiver.kernel.org>; Tue, 10 Jun 2025 16:37:51 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 66CF010E293;
	Tue, 10 Jun 2025 16:37:45 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="4yKjztFz";
	dkim-atps=neutral
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2041.outbound.protection.outlook.com [40.107.94.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B796310E293
 for <amd-gfx@lists.freedesktop.org>; Tue, 10 Jun 2025 16:37:44 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=md/y0wKC1nZPIFpNAbgdwHQ5umiL624ecRLTiLTTP/WmIa/cGMgcoog3KkfOYuhMOS+ItNWjCsBKsDODHZTV/dRsQ0ZSfcpsmpPk/eA8DQXAqrVsFKuEaK6pNZTdQpG5XYt6oOqa7byzu/0ecs+ibx4iHclgJY6j575ijSlSIZU0YuxMLac92P0kzp0bFy0PAuXa01jjjNQxeCfrMwXsulgqiFXlT9ceH6yCfBDOzBTHTcJbHz29bLevVfKt84Xm8lQLkhUyMQ015O4s3alflUkV1vsbpY2SuJk80+Ov4WQTvYiJOh0C9gHZyyk5DZDduXAAku5WAlAIjfJh7LmSCw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sIkHOQheU/6Jv4vITDcr31dTQC8GUc3HeC9HDNR9eLk=;
 b=ojwngKlMiJvLH1i+GzbJqOBWs/JT6bmGpPOr+c+qbB/aMRV90OGnJJ7aSDQ6RsY04FGlIscOBGQzNwvotDAsJroKP+c0AMqBvW2epH3kAg6CLahzON9DvmHyj+5fXlghXT+zolCUnsNDU0z+2i2r4DI/rY92JazjeGaYFi5XwSUA3jy1InommXU5Igb5kntPfACnUwZoP/rJcGHx63zInvR5kybJqX7YwFJAq7wUwMySK/1+ZCrraGbbLVWvYU91ZUKtwPv73PEoEQkyfiHvQ1FuBLcYCSwGezPyHuytCcPP7ZiRXoia5KmD5qcwXizzbnCHEvWlZ3WDLlVmcyNe0w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sIkHOQheU/6Jv4vITDcr31dTQC8GUc3HeC9HDNR9eLk=;
 b=4yKjztFzXDKDzXs2HezYyzJZLtjfv4YEF0tXNPep6+GJ7MYql++/xqAKu/XcRf0mRmPKm5oeSiuyUKRLVk/i+B8qopStjyxGuVVPDg+BtUZi53mYRQyAIyXITuoecL1vLzmW4gizaoVGsk/9IOtKNWPiOGKCsLzLHJbojVYnh74=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN0PR12MB6293.namprd12.prod.outlook.com (2603:10b6:208:3c2::22)
 by CY3PR12MB9556.namprd12.prod.outlook.com (2603:10b6:930:10a::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8835.18; Tue, 10 Jun
 2025 16:37:41 +0000
Received: from MN0PR12MB6293.namprd12.prod.outlook.com
 ([fe80::49ac:e84e:ea32:d743]) by MN0PR12MB6293.namprd12.prod.outlook.com
 ([fe80::49ac:e84e:ea32:d743%7]) with mapi id 15.20.8792.040; Tue, 10 Jun 2025
 16:37:41 +0000
Message-ID: <7028b1b8-34ea-47f9-b155-70fb9bcc6a3f@amd.com>
Date: Tue, 10 Jun 2025 22:07:37 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 06/29] drm/amdgpu: update ring reset function signature
To: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 Alex Deucher <alexdeucher@gmail.com>
Cc: Alex Deucher <alexander.deucher@amd.com>, amd-gfx@lists.freedesktop.org
References: <20250606064354.5858-1-alexander.deucher@amd.com>
 <20250606064354.5858-7-alexander.deucher@amd.com>
 <62a1601e-990a-498e-a64b-d96bfa5567e6@amd.com>
 <CADnq5_NVyLr6O71si=svVJr-Ev6TOGtLs4W32T6fayQPDyfr8Q@mail.gmail.com>
 <c2ea0f45-5962-472e-bd05-547f8bbb71eb@amd.com>
Content-Language: en-US
From: "Sundararaju, Sathishkumar" <sasundar@amd.com>
In-Reply-To: <c2ea0f45-5962-472e-bd05-547f8bbb71eb@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PN3PR01CA0118.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:96::19) To MN0PR12MB6293.namprd12.prod.outlook.com
 (2603:10b6:208:3c2::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR12MB6293:EE_|CY3PR12MB9556:EE_
X-MS-Office365-Filtering-Correlation-Id: 25a06051-909c-4743-78ec-08dda83d1e7b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?OFM3UlFpUHVIRDVtUnhOOFJMWE85eE5maUh5SnhzOXFVaGdianNsYTRlNGpU?=
 =?utf-8?B?c3Vrb1RBY2IxSi95YjY0ZDg4azdkSGZOc3o4dVJPSXc0Mk1YSWZvZ0pjZXZ0?=
 =?utf-8?B?cFNOZGhHeUZhTW05c3ZzU0l5Y3dmTVBrMTFmQk9sd1NkdVVueDNQeUdJdHJO?=
 =?utf-8?B?Z25UbXdpN3IrbDJvNzR0YTR0ekdlWklFYmtaL3RhQ1NrL1Q3TnZ6WHVVL3RW?=
 =?utf-8?B?OUhqM2tlNDVGZzlNMzMxbCtPa3Q4a0w2MXFVMGFDN2VLMUIrL0ZQd0U1TnVw?=
 =?utf-8?B?aGd3UlIrVnYrQTByUXloYVlKeDY5VHlrOFl5TDVOSkc5VXBZS1Q5VzloK0wr?=
 =?utf-8?B?MEQ4MXpRRW5LamxNMjkvMFc3Mkk4NE1zeVpIaFcwWVJEMWlMaHdXcGVUQmxY?=
 =?utf-8?B?dklsVHhtcHBCemNSWEgzeWpSM3NRcFo0M2lGOWNIZmJQT0xpV1dhbG1GdWh4?=
 =?utf-8?B?bzM4TlpVZ2pxT0h1eTZnTThDamxkdEpSbXN3RTVtQmNmekJUb3V4R0pwdFVX?=
 =?utf-8?B?S20wWm9TOHRYd21yMWRvMXlMMThTUDNzSjA2S29WUXhmRFl2TVlza2R2eDcx?=
 =?utf-8?B?RmlVTS9SamJuMEU1VUFCN0FEckNmWVZ1ekVvaTZiRlI1eTY1ckJwZEdBY2NF?=
 =?utf-8?B?S1lZZUtDZHVCOEZzQVhUU2NPOUFCditCMXVvVHI4SkpXNitLMEhPQ2J0MTZP?=
 =?utf-8?B?ZUpvRjFybWRncDI3TWkwNGpCVTNObDJXWHZ4L3lyTE9ibnpHd0wrOTFvc2NB?=
 =?utf-8?B?eTYzZnBWdm54ZUJGV2FIckg0bEl2OXQ1UThTNDY2QnY2a01BdWFSZ0d5OE9a?=
 =?utf-8?B?S3IwWVpwVEVTNkVralN0c0ZsTnBFN3R0YWN3ZjIzNS9EWHhMY1RDNEJLZlQ0?=
 =?utf-8?B?WmlvSzU2ckxPZmxRS2dCYytLYWxmN3l4ZXB3S0RUUlFWMElnTHV2Q0J4Slhi?=
 =?utf-8?B?Tk91YndHOVdyQ2o1QU1mWEpnVmlJT0hadzRqNFhLWCs1MnhTdDIyaWZreWtJ?=
 =?utf-8?B?ZzlHRnlyenNGMEdMZmREQkIvQlUwSmhlYXkrM2lpQ0ZPdmlvZXZXamovUnZP?=
 =?utf-8?B?TlJ3aDBwVnN5L3g2d3RyQUxrd3FtNDg2cHkrT240UDNBdUNqdDhHVWJiMDJn?=
 =?utf-8?B?NUtaOE8rdHdxbjJpK3YrSEhFOEVsRVByQlB4cDg3QmdQOG9vMDErZHZRUjR1?=
 =?utf-8?B?alpuNS9UTzJQdHd1aHlFY0lQVUxLRmZkWnFBa1o1VkljMFRuT2UraDcxOFBa?=
 =?utf-8?B?UjBJeDYxZjVreHlNNHdHbCs3dVFuRFNEUGJqVEVFa0crSkp2emwvT21uamt0?=
 =?utf-8?B?ekhkUDk0T3YrSnp0bVl4YU9YanVEMi92T1hXSkJ0SGtjRVFUakFxWnpDaGV5?=
 =?utf-8?B?Z0NjMks3Ri9sWGV5akhpOU1PQ3JmNnRhRG5zQVFBbGJ4Qnk0SWtxUHpvcElT?=
 =?utf-8?B?RzVBemZPd280TU9SN2NHUERkUVVyZkhscTM3ZGZNRmdNZjN5dEhBSlBaTWl5?=
 =?utf-8?B?aWdsL0dwR0MwVFdneE5NTXkvRnE4MGVCWHhuM0Fybm1xQXBmai9abE15OFpH?=
 =?utf-8?B?M0ZQbjNOckNVSzNjNFA3UzluNytLRHpRU1k0NDU1aUpSdHlZSkFvYjFGMFZL?=
 =?utf-8?B?UXB6cENJanRsZVIzdWR5QUtSRWUwc2dMS0tvR1ZqWDYydmNBZWFrNloxWWpN?=
 =?utf-8?B?K3N5Qk5aZEE3UEJITlViL1Uvc3ZzUjVlN1gzaE1oMlNUMjIwY3pYak9xSGR0?=
 =?utf-8?B?LzZNa0JXRXhYN0h3QXdlNUdPbWh5RHBNdDB1Z2lqdXpwN1YxQnZrR1B1dHQ5?=
 =?utf-8?B?akpMK3RsSE9EYWpQMmZZVXpvUXoxczdPbVNrTzR2bXRKMmNzaHJEOFZ2WXps?=
 =?utf-8?B?RjdtclN6RytnMUJSOXhaRVo0WGVYazdyRko0ZEVnUTNsbkI2N1NyK0FMMWp6?=
 =?utf-8?Q?LNhL82VDYRU=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN0PR12MB6293.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZWM0dFVscHZGK3cxL01LMUpuNlJLdlV0SlNJZ05abjdmL2txUjRWUkRQczI4?=
 =?utf-8?B?aU1KVitSZTNVOGJOcHpXT0tRcWZRWXNXUTFWWmRyZm9xMGxTSXltLzNiWERD?=
 =?utf-8?B?TGZNa3ZYTU5KMWlmMUpSekNPMnc0WlhYY3l5cUh0clUxa1dqV0RpUmt5ZXkx?=
 =?utf-8?B?ZE05V2l3R08zQkRlY1luTkYxM3pDY1ZCU01TVklucEZEbFFUcmZUdXlUR283?=
 =?utf-8?B?SXZpMDludExiZ05TMTVYU3NCdHM0WGp6dkJ6QWRjUzhUZ3dybTREaU1YdXJk?=
 =?utf-8?B?ZnMySlJTbTA4TEtYRGtYYWUyL2tzNlU0blY3ODl5VlBONkRBQm9kVlM3ZVFO?=
 =?utf-8?B?eXM4TDE5R2NIVVZpRHJyQnRzUkZFMTBvb0NRLytIOXlxbmg2dzFMSlpHU0dV?=
 =?utf-8?B?UEIyZHUweFNrV1FXazJNd1pSZnI2KzVsZ0RaakpmdGVWK1ZGdjZQMytQZ0lT?=
 =?utf-8?B?K1RzMHE0ditCdzc5SkJUUGV1b0NodDl1SW9kTGVhZUk3V3pZNkpEUzJ1QThQ?=
 =?utf-8?B?MTg5by9meDQra29IaWRJK2NrTlBUUU5CcTJLajhiNGZod1dIUzBIbGVpRElR?=
 =?utf-8?B?WXBnM3FSODRyRmFsRjFXbmxCNTlVNk9SSDZCZXJCbXZSU1VScXhNYzR3cEwr?=
 =?utf-8?B?Y2tmT2pzTUtVeE9nSEpsWHh3RHhqb0xBRUVuSWkveXlQbGRSRElCd2l4cmJQ?=
 =?utf-8?B?ekNjbS9aQ21FV2VBN2RSWUREa0s1ak5tOVZGVWkxQ1NDNEd2NEh1ajFuSmQr?=
 =?utf-8?B?Q0dsR1Baa0IxdHZVWUlLcG1sNDFpcjNnUEZFZDNiNXJWeCs4UEVIYnM5TE1D?=
 =?utf-8?B?cE1WWnNTcC92aGNPK241MnRnVFQzZkFwcWt6MDQvNTQwR2MxemRuSWtoZGFG?=
 =?utf-8?B?ZDRvNVZyM3hGdGhzYXpiTms0VHFPa3VaN21zK3oxK2VLVjBRalQzc0M1bXJP?=
 =?utf-8?B?dk80amV2ZExyQ3FjQktkcEkzTWgrMWplYjhTekJVYWEzZG5CNTQ0d3c5STZh?=
 =?utf-8?B?cjU1VnRXaFdqWEs5a1Vtd1NvbkhqZUxMUjVuVG1vZzRBNE5mNWtBaE9kd0Zj?=
 =?utf-8?B?KzdzQ0ZiRkI2b1hLTDlzTStDU21BQ2d6YzJGZndVaUpvSlAxWnlPVGRZVDJt?=
 =?utf-8?B?QlJKQll3Z1lGbDZtai9nQ1RhY0Q1LzlrTFNyaFVndWR0amt2MVZqYkNDZGR5?=
 =?utf-8?B?Tll6d3JSOE5LemVaZG9tamlBWTZ3TWFIN3hkb2x2MFdQNEw1WWhFZzczcUNr?=
 =?utf-8?B?UHJxZnhjNStyL040eXFSSmpZc2N4UW5Nb2x3cmt0d1I2M3hTOXJyV0xwNDU1?=
 =?utf-8?B?bU1SbUg3eGRRRGF6Nk5YZVd5ZWlGQ3pUK1drQ0dFN2hIeCtmT3FrL3AyT0hR?=
 =?utf-8?B?Qnk0WStyWkp2MGRKUFVCZnVnVmFqQjh2bmdHMTRzTWpCSjhSVEk5bmhiSWll?=
 =?utf-8?B?U01vTHA2VHV5T1YxTDFYSk82bDZrU2ZCbnRSWVZURkczT3duUHBZbTc3Tkpw?=
 =?utf-8?B?MGw3d1g2Mkh2cVhWSjFlWDdPRzIzRWRmY3p1RVpyd3BoZ2lydmJnRVRCWElL?=
 =?utf-8?B?TjZFSWN2djJXamZsNVpnYld6ZWFMSXVpUlR1eFFrUWhTMkdzaFNSTTZQdmZH?=
 =?utf-8?B?TkVvbDdTRFVIZ05TOXdaKzRiRTZLZ2dIclg3WHR2K2U0d2U0MGR3NG05ZXkx?=
 =?utf-8?B?cnhCNysvWi8yN0w2T0V6dVQvNVlrdE9LckE0SjNXTEVmenJDZTZZd2JpcjZH?=
 =?utf-8?B?SThXWkVsTTNPOUF2MXovQzdoa0I5ZmFDUkpvYmlUTEV5bDZQZ1lFOXhiMXU5?=
 =?utf-8?B?akU2cjBTd2ZEcXI4Q0N0MlNuVGpwYXY5dm5DQUJMRFBsbzBiSUN2dU5hZGla?=
 =?utf-8?B?dXY0bFZuWkNIdHd6M0FRZThNdDVlZ3dkWTFTYk9tcE0rVlBWM3hIOHdWZ0Rh?=
 =?utf-8?B?bEx0OEZNNlY0OG1RTitmclNxWm12MkR3SndQUDMyc0pENUZyUm94SFU1SHhB?=
 =?utf-8?B?aDVXRDFQMXBSR2FGTGowOXpPZ0FIamUwL0FKRklhdHpkZDhScFV5alVQWGlR?=
 =?utf-8?B?Sjg2SUljOGFzVm9TdmlKQmZ0enNUSFI5MlJtdTRmTlF3UFhCVnpyZ2RFSmRv?=
 =?utf-8?Q?yhp90Ccsn2DvGGdkz1EfnKujA?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 25a06051-909c-4743-78ec-08dda83d1e7b
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6293.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jun 2025 16:37:41.7689 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: le97acizWAJhebNYzMuJX2D8KNPigkxWUyGZSEsseTYl7BrV6RTaYz0xf0upQ+om2DS52kBykid3kbPuSYLdLw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY3PR12MB9556
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



On 6/10/2025 1:54 PM, Christian König wrote:
> On 6/6/25 18:00, Alex Deucher wrote:
>> On Fri, Jun 6, 2025 at 7:41 AM Christian König <christian.koenig@amd.com> wrote:
>>> On 6/6/25 08:43, Alex Deucher wrote:
>>>> Going forward, we'll need more than just the vmid.  Everything
>>>> we need in currently in the amdgpu job structure, so just
>>>> pass that in.
>>> Please don't the job is just a container for the submission, it should not be part of any reset handling.
>>>
>>> What information is actually needed here?
>> We need job->vmid, job->base.s_fence->finished, job->hw_fence.
> VMID and HW fence make sense, but why is the finished fence needed?

That's used because amdgpu_fence_driver_guilty_force_completion is just 
forcing the completion of guilty job's hw_fence without setting any 
error on it.
so dma_fence_set_error(&job->base.s_fence->finished, -ETIME) is called 
explicitly to set the error on the waiters fence (finished) to return 
appropriate error.

Alternatively the hw_fence could also be set with the error and force 
completed in amdgpu_fence_driver_guilty_force_completion,
that would be propagated to waiters fence (finished) , just tested it, 
has the same result.

--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c
@@ -766,6 +766,7 @@ void 
amdgpu_fence_driver_guilty_force_completion(struct dma_fence *fence)
  {
         struct amdgpu_fence *am_fence = container_of(fence, struct 
amdgpu_fence, base);

+       dma_fence_set_error(fence, -ETIME);
         amdgpu_fence_write(am_fence->ring, fence->seqno);
         amdgpu_fence_process(am_fence->ring);
  }


Regards,
Sathish

>
> Christian.
>
>
>> Alex
>>
>>> Regards,
>>> Christian.
>>>
>>>
>>>> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
>>>> ---
>>>>   drivers/gpu/drm/amd/amdgpu/amdgpu_job.c  |  2 +-
>>>>   drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h |  4 ++--
>>>>   drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c   |  7 ++++---
>>>>   drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c   | 10 ++++++----
>>>>   drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c   | 10 ++++++----
>>>>   drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c    |  2 +-
>>>>   drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c  |  2 +-
>>>>   drivers/gpu/drm/amd/amdgpu/jpeg_v2_0.c   |  3 ++-
>>>>   drivers/gpu/drm/amd/amdgpu/jpeg_v2_5.c   |  3 ++-
>>>>   drivers/gpu/drm/amd/amdgpu/jpeg_v3_0.c   |  3 ++-
>>>>   drivers/gpu/drm/amd/amdgpu/jpeg_v4_0.c   |  3 ++-
>>>>   drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_3.c |  3 ++-
>>>>   drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_1.c |  3 ++-
>>>>   drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c |  3 ++-
>>>>   drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c   |  3 ++-
>>>>   drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c   |  3 ++-
>>>>   drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c   |  5 +++--
>>>>   drivers/gpu/drm/amd/amdgpu/sdma_v7_0.c   |  5 +++--
>>>>   drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c    |  3 ++-
>>>>   drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c  |  3 ++-
>>>>   drivers/gpu/drm/amd/amdgpu/vcn_v4_0_5.c  |  3 ++-
>>>>   drivers/gpu/drm/amd/amdgpu/vcn_v5_0_0.c  |  3 ++-
>>>>   22 files changed, 53 insertions(+), 33 deletions(-)
>>>>
>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c
>>>> index ddb9d3269357c..80d4dfebde24f 100644
>>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c
>>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c
>>>> @@ -155,7 +155,7 @@ static enum drm_gpu_sched_stat amdgpu_job_timedout(struct drm_sched_job *s_job)
>>>>                if (is_guilty)
>>>>                        dma_fence_set_error(&s_job->s_fence->finished, -ETIME);
>>>>
>>>> -             r = amdgpu_ring_reset(ring, job->vmid);
>>>> +             r = amdgpu_ring_reset(ring, job);
>>>>                if (!r) {
>>>>                        if (amdgpu_ring_sched_ready(ring))
>>>>                                drm_sched_stop(&ring->sched, s_job);
>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
>>>> index e1f25218943a4..ab5402d7ce9c8 100644
>>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
>>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
>>>> @@ -268,7 +268,7 @@ struct amdgpu_ring_funcs {
>>>>        void (*patch_cntl)(struct amdgpu_ring *ring, unsigned offset);
>>>>        void (*patch_ce)(struct amdgpu_ring *ring, unsigned offset);
>>>>        void (*patch_de)(struct amdgpu_ring *ring, unsigned offset);
>>>> -     int (*reset)(struct amdgpu_ring *ring, unsigned int vmid);
>>>> +     int (*reset)(struct amdgpu_ring *ring, struct amdgpu_job *job);
>>>>        void (*emit_cleaner_shader)(struct amdgpu_ring *ring);
>>>>        bool (*is_guilty)(struct amdgpu_ring *ring);
>>>>   };
>>>> @@ -425,7 +425,7 @@ struct amdgpu_ring {
>>>>   #define amdgpu_ring_patch_cntl(r, o) ((r)->funcs->patch_cntl((r), (o)))
>>>>   #define amdgpu_ring_patch_ce(r, o) ((r)->funcs->patch_ce((r), (o)))
>>>>   #define amdgpu_ring_patch_de(r, o) ((r)->funcs->patch_de((r), (o)))
>>>> -#define amdgpu_ring_reset(r, v) (r)->funcs->reset((r), (v))
>>>> +#define amdgpu_ring_reset(r, j) (r)->funcs->reset((r), (j))
>>>>
>>>>   unsigned int amdgpu_ring_max_ibs(enum amdgpu_ring_type type);
>>>>   int amdgpu_ring_alloc(struct amdgpu_ring *ring, unsigned ndw);
>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
>>>> index 75ea071744eb5..c58e7040c732a 100644
>>>> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
>>>> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
>>>> @@ -9522,7 +9522,8 @@ static void gfx_v10_ring_insert_nop(struct amdgpu_ring *ring, uint32_t num_nop)
>>>>        amdgpu_ring_insert_nop(ring, num_nop - 1);
>>>>   }
>>>>
>>>> -static int gfx_v10_0_reset_kgq(struct amdgpu_ring *ring, unsigned int vmid)
>>>> +static int gfx_v10_0_reset_kgq(struct amdgpu_ring *ring,
>>>> +                            struct amdgpu_job *job)
>>>>   {
>>>>        struct amdgpu_device *adev = ring->adev;
>>>>        struct amdgpu_kiq *kiq = &adev->gfx.kiq[0];
>>>> @@ -9547,7 +9548,7 @@ static int gfx_v10_0_reset_kgq(struct amdgpu_ring *ring, unsigned int vmid)
>>>>
>>>>        addr = amdgpu_bo_gpu_offset(ring->mqd_obj) +
>>>>                offsetof(struct v10_gfx_mqd, cp_gfx_hqd_active);
>>>> -     tmp = REG_SET_FIELD(0, CP_VMID_RESET, RESET_REQUEST, 1 << vmid);
>>>> +     tmp = REG_SET_FIELD(0, CP_VMID_RESET, RESET_REQUEST, 1 << job->vmid);
>>>>        if (ring->pipe == 0)
>>>>                tmp = REG_SET_FIELD(tmp, CP_VMID_RESET, PIPE0_QUEUES, 1 << ring->queue);
>>>>        else
>>>> @@ -9579,7 +9580,7 @@ static int gfx_v10_0_reset_kgq(struct amdgpu_ring *ring, unsigned int vmid)
>>>>   }
>>>>
>>>>   static int gfx_v10_0_reset_kcq(struct amdgpu_ring *ring,
>>>> -                            unsigned int vmid)
>>>> +                            struct amdgpu_job *job)
>>>>   {
>>>>        struct amdgpu_device *adev = ring->adev;
>>>>        struct amdgpu_kiq *kiq = &adev->gfx.kiq[0];
>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
>>>> index afd6d59164bfa..0ee7bdd509741 100644
>>>> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
>>>> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
>>>> @@ -6806,7 +6806,8 @@ static int gfx_v11_reset_gfx_pipe(struct amdgpu_ring *ring)
>>>>        return 0;
>>>>   }
>>>>
>>>> -static int gfx_v11_0_reset_kgq(struct amdgpu_ring *ring, unsigned int vmid)
>>>> +static int gfx_v11_0_reset_kgq(struct amdgpu_ring *ring,
>>>> +                            struct amdgpu_job *job)
>>>>   {
>>>>        struct amdgpu_device *adev = ring->adev;
>>>>        int r;
>>>> @@ -6814,7 +6815,7 @@ static int gfx_v11_0_reset_kgq(struct amdgpu_ring *ring, unsigned int vmid)
>>>>        if (amdgpu_sriov_vf(adev))
>>>>                return -EINVAL;
>>>>
>>>> -     r = amdgpu_mes_reset_legacy_queue(ring->adev, ring, vmid, false);
>>>> +     r = amdgpu_mes_reset_legacy_queue(ring->adev, ring, job->vmid, false);
>>>>        if (r) {
>>>>
>>>>                dev_warn(adev->dev, "reset via MES failed and try pipe reset %d\n", r);
>>>> @@ -6968,7 +6969,8 @@ static int gfx_v11_0_reset_compute_pipe(struct amdgpu_ring *ring)
>>>>        return 0;
>>>>   }
>>>>
>>>> -static int gfx_v11_0_reset_kcq(struct amdgpu_ring *ring, unsigned int vmid)
>>>> +static int gfx_v11_0_reset_kcq(struct amdgpu_ring *ring,
>>>> +                            struct amdgpu_job *job)
>>>>   {
>>>>        struct amdgpu_device *adev = ring->adev;
>>>>        int r = 0;
>>>> @@ -6976,7 +6978,7 @@ static int gfx_v11_0_reset_kcq(struct amdgpu_ring *ring, unsigned int vmid)
>>>>        if (amdgpu_sriov_vf(adev))
>>>>                return -EINVAL;
>>>>
>>>> -     r = amdgpu_mes_reset_legacy_queue(ring->adev, ring, vmid, true);
>>>> +     r = amdgpu_mes_reset_legacy_queue(ring->adev, ring, job->vmid, true);
>>>>        if (r) {
>>>>                dev_warn(adev->dev, "fail(%d) to reset kcq and try pipe reset\n", r);
>>>>                r = gfx_v11_0_reset_compute_pipe(ring);
>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
>>>> index 1234c8d64e20d..a26417d53411b 100644
>>>> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
>>>> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
>>>> @@ -5307,7 +5307,8 @@ static int gfx_v12_reset_gfx_pipe(struct amdgpu_ring *ring)
>>>>        return 0;
>>>>   }
>>>>
>>>> -static int gfx_v12_0_reset_kgq(struct amdgpu_ring *ring, unsigned int vmid)
>>>> +static int gfx_v12_0_reset_kgq(struct amdgpu_ring *ring,
>>>> +                            struct amdgpu_job *job)
>>>>   {
>>>>        struct amdgpu_device *adev = ring->adev;
>>>>        int r;
>>>> @@ -5315,7 +5316,7 @@ static int gfx_v12_0_reset_kgq(struct amdgpu_ring *ring, unsigned int vmid)
>>>>        if (amdgpu_sriov_vf(adev))
>>>>                return -EINVAL;
>>>>
>>>> -     r = amdgpu_mes_reset_legacy_queue(ring->adev, ring, vmid, false);
>>>> +     r = amdgpu_mes_reset_legacy_queue(ring->adev, ring, job->vmid, false);
>>>>        if (r) {
>>>>                dev_warn(adev->dev, "reset via MES failed and try pipe reset %d\n", r);
>>>>                r = gfx_v12_reset_gfx_pipe(ring);
>>>> @@ -5421,7 +5422,8 @@ static int gfx_v12_0_reset_compute_pipe(struct amdgpu_ring *ring)
>>>>        return 0;
>>>>   }
>>>>
>>>> -static int gfx_v12_0_reset_kcq(struct amdgpu_ring *ring, unsigned int vmid)
>>>> +static int gfx_v12_0_reset_kcq(struct amdgpu_ring *ring,
>>>> +                            struct amdgpu_job *job)
>>>>   {
>>>>        struct amdgpu_device *adev = ring->adev;
>>>>        int r;
>>>> @@ -5429,7 +5431,7 @@ static int gfx_v12_0_reset_kcq(struct amdgpu_ring *ring, unsigned int vmid)
>>>>        if (amdgpu_sriov_vf(adev))
>>>>                return -EINVAL;
>>>>
>>>> -     r = amdgpu_mes_reset_legacy_queue(ring->adev, ring, vmid, true);
>>>> +     r = amdgpu_mes_reset_legacy_queue(ring->adev, ring, job->vmid, true);
>>>>        if (r) {
>>>>                dev_warn(adev->dev, "fail(%d) to reset kcq  and try pipe reset\n", r);
>>>>                r = gfx_v12_0_reset_compute_pipe(ring);
>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
>>>> index d50e125fd3e0d..5e650cc5fcb26 100644
>>>> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
>>>> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
>>>> @@ -7153,7 +7153,7 @@ static void gfx_v9_ring_insert_nop(struct amdgpu_ring *ring, uint32_t num_nop)
>>>>   }
>>>>
>>>>   static int gfx_v9_0_reset_kcq(struct amdgpu_ring *ring,
>>>> -                           unsigned int vmid)
>>>> +                           struct amdgpu_job *job)
>>>>   {
>>>>        struct amdgpu_device *adev = ring->adev;
>>>>        struct amdgpu_kiq *kiq = &adev->gfx.kiq[0];
>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c b/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
>>>> index c233edf605694..a7dadff3dca31 100644
>>>> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
>>>> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
>>>> @@ -3552,7 +3552,7 @@ static int gfx_v9_4_3_reset_hw_pipe(struct amdgpu_ring *ring)
>>>>   }
>>>>
>>>>   static int gfx_v9_4_3_reset_kcq(struct amdgpu_ring *ring,
>>>> -                             unsigned int vmid)
>>>> +                             struct amdgpu_job *job)
>>>>   {
>>>>        struct amdgpu_device *adev = ring->adev;
>>>>        struct amdgpu_kiq *kiq = &adev->gfx.kiq[ring->xcc_id];
>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/jpeg_v2_0.c b/drivers/gpu/drm/amd/amdgpu/jpeg_v2_0.c
>>>> index 4cde8a8bcc837..6cd3fbe00d6b9 100644
>>>> --- a/drivers/gpu/drm/amd/amdgpu/jpeg_v2_0.c
>>>> +++ b/drivers/gpu/drm/amd/amdgpu/jpeg_v2_0.c
>>>> @@ -764,7 +764,8 @@ static int jpeg_v2_0_process_interrupt(struct amdgpu_device *adev,
>>>>        return 0;
>>>>   }
>>>>
>>>> -static int jpeg_v2_0_ring_reset(struct amdgpu_ring *ring, unsigned int vmid)
>>>> +static int jpeg_v2_0_ring_reset(struct amdgpu_ring *ring,
>>>> +                             struct amdgpu_job *job)
>>>>   {
>>>>        jpeg_v2_0_stop(ring->adev);
>>>>        jpeg_v2_0_start(ring->adev);
>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/jpeg_v2_5.c b/drivers/gpu/drm/amd/amdgpu/jpeg_v2_5.c
>>>> index 8b39e114f3be1..8ed41868f6c32 100644
>>>> --- a/drivers/gpu/drm/amd/amdgpu/jpeg_v2_5.c
>>>> +++ b/drivers/gpu/drm/amd/amdgpu/jpeg_v2_5.c
>>>> @@ -643,7 +643,8 @@ static int jpeg_v2_5_process_interrupt(struct amdgpu_device *adev,
>>>>        return 0;
>>>>   }
>>>>
>>>> -static int jpeg_v2_5_ring_reset(struct amdgpu_ring *ring, unsigned int vmid)
>>>> +static int jpeg_v2_5_ring_reset(struct amdgpu_ring *ring,
>>>> +                             struct amdgpu_job *job)
>>>>   {
>>>>        jpeg_v2_5_stop_inst(ring->adev, ring->me);
>>>>        jpeg_v2_5_start_inst(ring->adev, ring->me);
>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/jpeg_v3_0.c b/drivers/gpu/drm/amd/amdgpu/jpeg_v3_0.c
>>>> index 2f8510c2986b9..3512fbb543301 100644
>>>> --- a/drivers/gpu/drm/amd/amdgpu/jpeg_v3_0.c
>>>> +++ b/drivers/gpu/drm/amd/amdgpu/jpeg_v3_0.c
>>>> @@ -555,7 +555,8 @@ static int jpeg_v3_0_process_interrupt(struct amdgpu_device *adev,
>>>>        return 0;
>>>>   }
>>>>
>>>> -static int jpeg_v3_0_ring_reset(struct amdgpu_ring *ring, unsigned int vmid)
>>>> +static int jpeg_v3_0_ring_reset(struct amdgpu_ring *ring,
>>>> +                             struct amdgpu_job *job)
>>>>   {
>>>>        jpeg_v3_0_stop(ring->adev);
>>>>        jpeg_v3_0_start(ring->adev);
>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0.c b/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0.c
>>>> index f17ec5414fd69..c8efeaf0a2a69 100644
>>>> --- a/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0.c
>>>> +++ b/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0.c
>>>> @@ -720,7 +720,8 @@ static int jpeg_v4_0_process_interrupt(struct amdgpu_device *adev,
>>>>        return 0;
>>>>   }
>>>>
>>>> -static int jpeg_v4_0_ring_reset(struct amdgpu_ring *ring, unsigned int vmid)
>>>> +static int jpeg_v4_0_ring_reset(struct amdgpu_ring *ring,
>>>> +                             struct amdgpu_job *job)
>>>>   {
>>>>        if (amdgpu_sriov_vf(ring->adev))
>>>>                return -EINVAL;
>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_3.c b/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_3.c
>>>> index 79e342d5ab28d..8b07c3651c579 100644
>>>> --- a/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_3.c
>>>> +++ b/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_3.c
>>>> @@ -1143,7 +1143,8 @@ static void jpeg_v4_0_3_core_stall_reset(struct amdgpu_ring *ring)
>>>>        WREG32_SOC15(JPEG, jpeg_inst, regJPEG_CORE_RST_CTRL, 0x00);
>>>>   }
>>>>
>>>> -static int jpeg_v4_0_3_ring_reset(struct amdgpu_ring *ring, unsigned int vmid)
>>>> +static int jpeg_v4_0_3_ring_reset(struct amdgpu_ring *ring,
>>>> +                               struct amdgpu_job *job)
>>>>   {
>>>>        if (amdgpu_sriov_vf(ring->adev))
>>>>                return -EOPNOTSUPP;
>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_1.c b/drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_1.c
>>>> index 3b6f65a256464..0a21a13e19360 100644
>>>> --- a/drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_1.c
>>>> +++ b/drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_1.c
>>>> @@ -834,7 +834,8 @@ static void jpeg_v5_0_1_core_stall_reset(struct amdgpu_ring *ring)
>>>>        WREG32_SOC15(JPEG, jpeg_inst, regJPEG_CORE_RST_CTRL, 0x00);
>>>>   }
>>>>
>>>> -static int jpeg_v5_0_1_ring_reset(struct amdgpu_ring *ring, unsigned int vmid)
>>>> +static int jpeg_v5_0_1_ring_reset(struct amdgpu_ring *ring,
>>>> +                               struct amdgpu_job *job)
>>>>   {
>>>>        if (amdgpu_sriov_vf(ring->adev))
>>>>                return -EOPNOTSUPP;
>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c b/drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c
>>>> index 9c169112a5e7b..ffd67d51b335f 100644
>>>> --- a/drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c
>>>> +++ b/drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c
>>>> @@ -1667,7 +1667,8 @@ static bool sdma_v4_4_2_page_ring_is_guilty(struct amdgpu_ring *ring)
>>>>        return sdma_v4_4_2_is_queue_selected(adev, instance_id, true);
>>>>   }
>>>>
>>>> -static int sdma_v4_4_2_reset_queue(struct amdgpu_ring *ring, unsigned int vmid)
>>>> +static int sdma_v4_4_2_reset_queue(struct amdgpu_ring *ring,
>>>> +                                struct amdgpu_job *job)
>>>>   {
>>>>        struct amdgpu_device *adev = ring->adev;
>>>>        u32 id = GET_INST(SDMA0, ring->me);
>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c b/drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c
>>>> index 9505ae96fbecc..46affee1c2da0 100644
>>>> --- a/drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c
>>>> +++ b/drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c
>>>> @@ -1538,7 +1538,8 @@ static int sdma_v5_0_soft_reset(struct amdgpu_ip_block *ip_block)
>>>>        return 0;
>>>>   }
>>>>
>>>> -static int sdma_v5_0_reset_queue(struct amdgpu_ring *ring, unsigned int vmid)
>>>> +static int sdma_v5_0_reset_queue(struct amdgpu_ring *ring,
>>>> +                              struct amdgpu_job *job)
>>>>   {
>>>>        struct amdgpu_device *adev = ring->adev;
>>>>        u32 inst_id = ring->me;
>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c b/drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c
>>>> index a6e612b4a8928..581e75b7d01a8 100644
>>>> --- a/drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c
>>>> +++ b/drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c
>>>> @@ -1451,7 +1451,8 @@ static int sdma_v5_2_wait_for_idle(struct amdgpu_ip_block *ip_block)
>>>>        return -ETIMEDOUT;
>>>>   }
>>>>
>>>> -static int sdma_v5_2_reset_queue(struct amdgpu_ring *ring, unsigned int vmid)
>>>> +static int sdma_v5_2_reset_queue(struct amdgpu_ring *ring,
>>>> +                              struct amdgpu_job *job)
>>>>   {
>>>>        struct amdgpu_device *adev = ring->adev;
>>>>        u32 inst_id = ring->me;
>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c b/drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c
>>>> index 5a70ae17be04e..d9866009edbfc 100644
>>>> --- a/drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c
>>>> +++ b/drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c
>>>> @@ -1537,7 +1537,8 @@ static int sdma_v6_0_ring_preempt_ib(struct amdgpu_ring *ring)
>>>>        return r;
>>>>   }
>>>>
>>>> -static int sdma_v6_0_reset_queue(struct amdgpu_ring *ring, unsigned int vmid)
>>>> +static int sdma_v6_0_reset_queue(struct amdgpu_ring *ring,
>>>> +                              struct amdgpu_job *job)
>>>>   {
>>>>        struct amdgpu_device *adev = ring->adev;
>>>>        int i, r;
>>>> @@ -1555,7 +1556,7 @@ static int sdma_v6_0_reset_queue(struct amdgpu_ring *ring, unsigned int vmid)
>>>>                return -EINVAL;
>>>>        }
>>>>
>>>> -     r = amdgpu_mes_reset_legacy_queue(adev, ring, vmid, true);
>>>> +     r = amdgpu_mes_reset_legacy_queue(adev, ring, job->vmid, true);
>>>>        if (r)
>>>>                return r;
>>>>
>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v7_0.c b/drivers/gpu/drm/amd/amdgpu/sdma_v7_0.c
>>>> index ad47d0bdf7775..c546e73642296 100644
>>>> --- a/drivers/gpu/drm/amd/amdgpu/sdma_v7_0.c
>>>> +++ b/drivers/gpu/drm/amd/amdgpu/sdma_v7_0.c
>>>> @@ -802,7 +802,8 @@ static bool sdma_v7_0_check_soft_reset(struct amdgpu_ip_block *ip_block)
>>>>        return false;
>>>>   }
>>>>
>>>> -static int sdma_v7_0_reset_queue(struct amdgpu_ring *ring, unsigned int vmid)
>>>> +static int sdma_v7_0_reset_queue(struct amdgpu_ring *ring,
>>>> +                              struct amdgpu_job *job)
>>>>   {
>>>>        struct amdgpu_device *adev = ring->adev;
>>>>        int i, r;
>>>> @@ -820,7 +821,7 @@ static int sdma_v7_0_reset_queue(struct amdgpu_ring *ring, unsigned int vmid)
>>>>                return -EINVAL;
>>>>        }
>>>>
>>>> -     r = amdgpu_mes_reset_legacy_queue(adev, ring, vmid, true);
>>>> +     r = amdgpu_mes_reset_legacy_queue(adev, ring, job->vmid, true);
>>>>        if (r)
>>>>                return r;
>>>>
>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c
>>>> index b5071f77f78d2..47a0deceff433 100644
>>>> --- a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c
>>>> +++ b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c
>>>> @@ -1967,7 +1967,8 @@ static int vcn_v4_0_ring_patch_cs_in_place(struct amdgpu_cs_parser *p,
>>>>        return 0;
>>>>   }
>>>>
>>>> -static int vcn_v4_0_ring_reset(struct amdgpu_ring *ring, unsigned int vmid)
>>>> +static int vcn_v4_0_ring_reset(struct amdgpu_ring *ring,
>>>> +                            struct amdgpu_job *job)
>>>>   {
>>>>        struct amdgpu_device *adev = ring->adev;
>>>>        struct amdgpu_vcn_inst *vinst = &adev->vcn.inst[ring->me];
>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c
>>>> index 5a33140f57235..d961a824d2098 100644
>>>> --- a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c
>>>> +++ b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c
>>>> @@ -1594,7 +1594,8 @@ static void vcn_v4_0_3_unified_ring_set_wptr(struct amdgpu_ring *ring)
>>>>        }
>>>>   }
>>>>
>>>> -static int vcn_v4_0_3_ring_reset(struct amdgpu_ring *ring, unsigned int vmid)
>>>> +static int vcn_v4_0_3_ring_reset(struct amdgpu_ring *ring,
>>>> +                              struct amdgpu_job *job)
>>>>   {
>>>>        int r = 0;
>>>>        int vcn_inst;
>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_5.c b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_5.c
>>>> index 16ade84facc78..10bd714592278 100644
>>>> --- a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_5.c
>>>> +++ b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_5.c
>>>> @@ -1465,7 +1465,8 @@ static void vcn_v4_0_5_unified_ring_set_wptr(struct amdgpu_ring *ring)
>>>>        }
>>>>   }
>>>>
>>>> -static int vcn_v4_0_5_ring_reset(struct amdgpu_ring *ring, unsigned int vmid)
>>>> +static int vcn_v4_0_5_ring_reset(struct amdgpu_ring *ring,
>>>> +                              struct amdgpu_job *job)
>>>>   {
>>>>        struct amdgpu_device *adev = ring->adev;
>>>>        struct amdgpu_vcn_inst *vinst = &adev->vcn.inst[ring->me];
>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_0.c b/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_0.c
>>>> index f8e3f0b882da5..7e6a7ead9a086 100644
>>>> --- a/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_0.c
>>>> +++ b/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_0.c
>>>> @@ -1192,7 +1192,8 @@ static void vcn_v5_0_0_unified_ring_set_wptr(struct amdgpu_ring *ring)
>>>>        }
>>>>   }
>>>>
>>>> -static int vcn_v5_0_0_ring_reset(struct amdgpu_ring *ring, unsigned int vmid)
>>>> +static int vcn_v5_0_0_ring_reset(struct amdgpu_ring *ring,
>>>> +                              struct amdgpu_job *job)
>>>>   {
>>>>        struct amdgpu_device *adev = ring->adev;
>>>>        struct amdgpu_vcn_inst *vinst = &adev->vcn.inst[ring->me];

