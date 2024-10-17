Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 597A0D2F7FA
	for <amd-gfx@archiver.kernel.org>; Thu, 17 Oct 2024 07:56:59 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D990910E301;
	Thu, 17 Oct 2024 07:56:58 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="VRa0kZbI";
	dkim-atps=neutral
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2051.outbound.protection.outlook.com [40.107.237.51])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E317710E301
 for <amd-gfx@lists.freedesktop.org>; Thu, 17 Oct 2024 07:56:57 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZgOMb3XwnBsC2DMp2z4g1hn2AeP7Mils/41itvJd8+heGLIU+TcgbaVQWvoCUPet+CRmo4ii7w/p31NbVLeKU2Lyc6+2tTr/xcyTMYwuvVDxJTPbkhU4UAo6xUD9PBUgcV5HDzhj9nimddJ1VQ/ws0F9Dbwnq7F2AbmM6YeQ2Zx1J5t7th1UPq2ezxv2y2Z435w3s8/YFPCZtqFoR/wBuWXV+CW7811zGgkwNoSP+Q7A14BCpG19ySVxkWxV8euHcsXy1MpQtBqKkLD9kI2M1avT1efgwC5gRrI4wnjPmpevSHFmP9ykL/bxm50ACJy0EKPGmn7SdnsCnuo9zqZkCw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AnXVhgP50vF6K4Hlv0sMdKuiTG/dU98uhXYHuZmY8kY=;
 b=KEuWrSVPpNc1uLbONlfUCET14Dk6ugVyhrZB6b94hgN4LhBDPK7fPiZXoA9VeZGkgFo5MtW++H2NAa+XqmneVqinMz9KQYLHp0gFckC6VE1QJs9f5cYsPSCRbSDEzDkQywhEEo/9MKlBgIkP1BDjAt56SbKSkFZ05YicIyaGFAPqUmo/l86G1a8BJ8ZZRBpx1lKUt32hxrT6djMqai6+xlD0XwPOoWycTLNA0wFYtFax8dblR8g7hJw+2kRcV8R5ovytJKQxCOLsHso8pJO/NQXKd8R56l/hFuuGHJ34uBNibnW6GnjTTvGK2j4MKU7cwR/vYlQ3osh+p1DC827ung==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AnXVhgP50vF6K4Hlv0sMdKuiTG/dU98uhXYHuZmY8kY=;
 b=VRa0kZbIbeJNDnz1Iv73M/OaQD79rdySz2FCI4XyHqgCJ6a7VotSY5ZM5O39MPWqH+LxclUn3FLNriWxsdowS8REjOuaTIdtcZg45JM/6/LkyhAodXdciHHxZhQDikO0cLcdmu3kZRTOeknINwBiMhDb9HwE6HGui9m3pvlv2wE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS0PR12MB7804.namprd12.prod.outlook.com (2603:10b6:8:142::5) by
 CYYPR12MB8750.namprd12.prod.outlook.com (2603:10b6:930:be::18) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8048.19; Thu, 17 Oct 2024 07:56:51 +0000
Received: from DS0PR12MB7804.namprd12.prod.outlook.com
 ([fe80::8327:d71a:ce21:a290]) by DS0PR12MB7804.namprd12.prod.outlook.com
 ([fe80::8327:d71a:ce21:a290%5]) with mapi id 15.20.8048.020; Thu, 17 Oct 2024
 07:56:51 +0000
Message-ID: <dad2b821-aee5-4a5d-baef-4af7fc5ee8c0@amd.com>
Date: Thu, 17 Oct 2024 13:26:44 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amd/pm: update deep sleep status on smu v14.0.2/3
To: "Feng, Kenneth" <Kenneth.Feng@amd.com>,
 "Wang, Yang(Kevin)" <KevinYang.Wang@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
References: <20241016071919.2138181-1-kenneth.feng@amd.com>
 <PH7PR12MB59978FA51CE8CF4FE824B9DA82462@PH7PR12MB5997.namprd12.prod.outlook.com>
 <DM4PR12MB5165E79EEDD00A4F1DFE25478E462@DM4PR12MB5165.namprd12.prod.outlook.com>
Content-Language: en-US
From: "Lazar, Lijo" <lijo.lazar@amd.com>
In-Reply-To: <DM4PR12MB5165E79EEDD00A4F1DFE25478E462@DM4PR12MB5165.namprd12.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PN3PR01CA0035.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:97::14) To DS0PR12MB7804.namprd12.prod.outlook.com
 (2603:10b6:8:142::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB7804:EE_|CYYPR12MB8750:EE_
X-MS-Office365-Filtering-Correlation-Id: f05120d3-5cb1-41c5-7876-08dcee814277
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?Qk8zVExYWVVucHpNZmUzcUNqUG9weXlGdkRMbUU4aVVKTG8zZkZjV2RYNnFj?=
 =?utf-8?B?Szk1SkViSkR0VlI5ZUNtUDFlM0ZPUlJtWWVEUnF3blVxbldncjBva1RYUVpT?=
 =?utf-8?B?RXRNUFBmdEVPRWtPV1ZiUlViT3g1bWJXZldhWmJsemRQNE1nY0ZiOGYxVHl2?=
 =?utf-8?B?WUV6Y0ZvcE9ZM1FKVEJoR01jT0VOamhuK3UrRnVBNlFwbm9neFJ2RUt3ZjFp?=
 =?utf-8?B?WTdMVXdGMGlOOHpDVEdVaHg1bUZLREcxamIwa1N3bGdCWExETHZYRWF1UnF2?=
 =?utf-8?B?REx4N1M2bVl2eXdEZkdJRzZJN1Y1Wmoxc0tnaHdyZERTdmJYcDFNZ1h6LzdD?=
 =?utf-8?B?SjdTaUMvVkltK09IdTlGdzZKNmt4alRzRVoyVjluV2FwTE8xdnpJSDFNNkF6?=
 =?utf-8?B?Q3I2aWFESHBQUDU0T3htKzQzVEl5NTd1RXBXWHVvbjhhdnpKZnVpM09rSUhh?=
 =?utf-8?B?eWQvT2dEUlhGdmFMQ2hOSUhUUFltSjRZM2RNTktKbUwrN1hjRzg4ZkdPdXFs?=
 =?utf-8?B?MzRlclhUWHR6STROamlYekhXZmFIZWlFMkI0WDhzNjI2TUNnMStSNmRhZ3Iz?=
 =?utf-8?B?QmpXVVdISEdjaTNCVGg2VFp0QkpIR09XYkZsVXhZUG5nZHlBVXAycHFFY2Jn?=
 =?utf-8?B?ci9HNVord1lLcENOb1RNekJIV0t4N1c4NTRHVnl6Mm1sOFovbm1sNWRweVFu?=
 =?utf-8?B?OVlWUDQzaG1IZGVoMllHb25ESmZHdnFYQ0EyS09ySTVHbHAxYzVzWE9JVTVk?=
 =?utf-8?B?SllOZUl6RzVRRUhmWG8wMXlSNFhXUDB3ZjhKaE1lOEdab3FQWFVHd25pYXFh?=
 =?utf-8?B?STJ6UHYxUGVhWW9DdFUvNVNieVVTaWxUQlpmM2Zjc0VFQVUvZmZENnBoSWFk?=
 =?utf-8?B?eUl5NzkxamgzWUFyZDcramxaRlkwd0RlV1ZmRnM3Um1TRm1JTmFXL1dialZw?=
 =?utf-8?B?YzBEOVR3TU5ueGp6VjdwV3FxV1JFa0xFYXRSc29OQ2FyejV4anFzdVdZSURh?=
 =?utf-8?B?aFV0bUwwcW9iTHFSMEIyN2RoTXg0UVZyV01VWGtrV25Rc2ErVXVwU0FvdjZm?=
 =?utf-8?B?MGJwU1YxNytxU0VHRGJER0xPajJlTGduTTRFY2NqWUtudEhGVVpramhNdVJ5?=
 =?utf-8?B?Q3NYdDc1OWxXclowSURVb1RBT1ZSK1ovb3djajFYNkpDVXBmVEJyaUwzclM2?=
 =?utf-8?B?OXg4MWJXN2xVdWZaUTBDYnl3UmZWK3hLVHg5TTR1ZjBjOWJIWXU5MU9zNllQ?=
 =?utf-8?B?ckZ3SkJhblhwaFNpdS9VNzI3N1RxZ3IxbE91NVRqR0JZQ1BTQUwwYldDN1FJ?=
 =?utf-8?B?M0Fac2t3QTdvT2NrSVIzLzdJTk9KRUQzNnlrS05aWllaUFBQT3lrbTJEaTlj?=
 =?utf-8?B?UmtNRmdvSXZzNFVvMXdkT1ZBS0ZhLzZPU1VYVWNSUFMvUlE2TWxCWEd6NWI0?=
 =?utf-8?B?SGRTT1hmOGdpZEs4MXV1aFlCTVJJSDhGMU9XdmYxTHlCTlR1VzJPdVVWSFRn?=
 =?utf-8?B?NzlxOS9ib3lER25XazhWZUxBVTJkajByUTBSd0JPZDVQbHJ2TzYwY2FWODZ5?=
 =?utf-8?B?WlV2MytFcE1TdHdOWVZaZmdvbDhTeHpsSmJhaU85ajVaeGFOQlFnM3dlNWkz?=
 =?utf-8?B?SGxKYzhxcnVGdGZaNGEzcUVoaVV4cFA1VHlJdnloQjBWUHNON01nOUlhK2tm?=
 =?utf-8?B?MHRhSEdnalM0clhvUDcxOTB4UFVMV0owbG82Q1Q2N1RNRUNvdEFjLzN3SEla?=
 =?utf-8?Q?EbbLW1plO9w6iRxZCosQkW9+M81+ke+up4iXTZa?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR12MB7804.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?eVRyeUs3K2s3M3lNUU5XYWhYQ2NXMWY4RHB1OWhrc1V6dGwrYlVaYzdYV081?=
 =?utf-8?B?WnNqRkl2aWJQMHE2NmlBbzJWVWZYMytQbjFvTUhGUVBVUnd5UXN6NjE1VnBt?=
 =?utf-8?B?T2dnZlhKOWdvcjRrYi9ldEFhalZyeFhRbk8yRGxxUlJydTJIZVdkUDNVOSto?=
 =?utf-8?B?M29BZjJXaWZ5V2RvL081eWNrYVF3LzBzNHVJanc5Q1AvcU5uaVIrM3ZMM1R6?=
 =?utf-8?B?N0UyTTh1eXJWNElPZW1ldThIV0xIcTRwWU1QVVJqTVdRcjFONm1QM0IwWE9q?=
 =?utf-8?B?bXJJVCtkSVIyQ0dDeHJMZjhMam9oMkJJMXlBYVdUdTh1SE9CUUZuZmVOR29Z?=
 =?utf-8?B?VCtwenVvSWc0VnhRZmc4M2Y5d0I5Y3dIaFRvM1RWRnBqOURYRmpNYm5KSktz?=
 =?utf-8?B?RGJiTWlJUCtlRUNRRlBYZUZjWTc5YytHbTVWR01maUFSd0cxS1ZLcE1XT0lP?=
 =?utf-8?B?Ukpvbk9oTkR3TmMrQjRJMElUdGFST1N5ZVEvSEdtU3E0SExOWlNVd3AyYmpo?=
 =?utf-8?B?Q0JleStRQVVhUXRJUEdaTVh0TkFTa056VmR6bjNwbVZJYXFBWW9vaEsrTlNN?=
 =?utf-8?B?akJnL2g4VitkdVdCVjRENHpLMVZBdkxUdnczOFVPUjZ0R2tvcVJvQ2dWOXd5?=
 =?utf-8?B?THIxeXEvWTdlVURjQTk0SUNLdFZ5REkvYkYvQXhQcGdMaG5UM1dKVTNUUW1P?=
 =?utf-8?B?cFNsejNJQnBSNkpKbTB5Z0hHdnJGaHd5dEJtQ1dUTmN5NWw1bTFBem0xZmh1?=
 =?utf-8?B?K1MzNGhsZXlNelhiWEpDV2FCWlFaTnJVdzQ0bFk2bkdFREpCLy9QeHhIS1Zz?=
 =?utf-8?B?TzdsanI5WnV6Ukp4NHp1b2lXMnNBaGFlTm9ETmxveEM4dXZrdFhjc3BTYkxa?=
 =?utf-8?B?S1YyZGd4QUQ3Znd6SUZ4bVRQbTJ0RmJ4SUFJS09JNllqU3gxYkgxb2FRT243?=
 =?utf-8?B?MVhuUFZiV0VreFlMMlFUQ0VzYXVDZ2Iya05odlRKdzFRNU9US2s4eVQ4cDhV?=
 =?utf-8?B?VVIyTWczb2ZXTTlIaWE4SStCQ1FpT2VoVThIZGNsc3VTVlltWU1ZeXRqeDlL?=
 =?utf-8?B?eWJMNFBZS3J2ZUZNRzMzRTdmRVFka3I2eURWZ3FhcWZGWkVkK1hRdk9Td1hl?=
 =?utf-8?B?WUZnZ0x0SmtNTVFNRjRVT3A2WDJLaUFJYnUwNFhVK3ZHanQxa2tXdU1KMHhQ?=
 =?utf-8?B?Z1dVN0FRbDgyV01Yb3dKUHVLdkdNai9xSHZtUUdVa0UyTzg4VjZ5dU1RbytJ?=
 =?utf-8?B?czc0NXQ2WHBWY1VCNG9zRkp3dnhiaSszVDQxbmxNc2ErcWxLWldmUWE0VFdB?=
 =?utf-8?B?ZTBnRzZvQjJ3SlkyNWNidXgzbW5CajA4MnBFODEwTDgxbWxvRmhkTmlXQVQw?=
 =?utf-8?B?Sk1DRFhYaWJQK2xtbnBpQ0dzN1VFc2g5aDV5WklTV2VQUUNLdnNwaUhyTEIr?=
 =?utf-8?B?NGVncVdwRS90SUJjTzl0Ulo4VjRGOVFJV1NCQ1pjRDJudUxjUi9JbC92UHJx?=
 =?utf-8?B?TnFBNW1JRVJ4cm9ZM0lSS3ZZbkhFOWhzb0M1Mm15dDhJMk5zNGd2WndGQnJv?=
 =?utf-8?B?WUFCNVc0WXd0R25WN1RGYXlkS0FPTmwvbjg3Z25IR0lpSWQzVFVSc1V3WmJX?=
 =?utf-8?B?SVgzMWVlU2gzb2FGaUt1NHF4R1hmSUtCWk01cWlYbjJPd1hwYWU3dG8vajNu?=
 =?utf-8?B?SXFINCtCQVhWVklYVG9leHhRSEVpc2g1MGl4OXI1SWliNG9zbWphV3lFc3hH?=
 =?utf-8?B?cEJVTDMybkw1bFJkZTVsY3BBdE8wYkxKdnFFY21zMWtxd0h5ZFpmS3FBM1Bl?=
 =?utf-8?B?MWJRZS8wTEtOTHErZlN3K01jSi80aXNDT2RHcVd5ZEZ3VWhWd1U5NUVhVzJo?=
 =?utf-8?B?Q2MvUGkrQkhGNDdSOU1LSkQzbUN5K010SnZCUG1Ua1Z1Y2E1a21Wd3NFTmZV?=
 =?utf-8?B?UGR6ZWRDdmZyVjJHeXFOMjJHbkx2VlFPZXg1eTRLZnhEeUY0NWlvSG1JV2tU?=
 =?utf-8?B?R09EUnlYeURmZWhadGppcWtLVVBDZTZocFRHbG5nekdaQ1o0dnFHMjQzZ1FO?=
 =?utf-8?B?amNUNmp2U2ZsM25VYXNnRkprQ1ZvVWxrM09pWTBiRE9BOGN5S1V1K0puV0l5?=
 =?utf-8?Q?te9HjgVI1ynvVlS+wC1v0cI7c?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f05120d3-5cb1-41c5-7876-08dcee814277
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB7804.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Oct 2024 07:56:51.4427 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gyl/A8RX6JHwRSKYIZG6hFrVtQ4xsvUe5luJATms0HCc9UuhNyyNg+n2iZhdZk+L
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYYPR12MB8750
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



On 10/17/2024 5:16 AM, Feng, Kenneth wrote:
> [AMD Official Use Only - AMD Internal Distribution Only]
> 
> [AMD Official Use Only - AMD Internal Distribution Only]
> 
> The logic is that when entering the compute workload, enable deep sleep.
> When exiting the compute workload, disable deep sleep.
> It's not required to do the deep sleep setting in other workload type.
> Thanks.
> 

This patch looks good. Please name temp_profile_mode as current_profile
for clarity and may be comment about smu->power_profile_mode as the
new/target mode.

With those -
	Reviewed-by: Lijo Lazar <lijo.lazar@amd.com>

Thanks,
Lijo


> 
> -----Original Message-----
> From: Wang, Yang(Kevin) <KevinYang.Wang@amd.com>
> Sent: Wednesday, October 16, 2024 8:38 PM
> To: Feng, Kenneth <Kenneth.Feng@amd.com>; amd-gfx@lists.freedesktop.org
> Cc: Feng, Kenneth <Kenneth.Feng@amd.com>
> Subject: RE: [PATCH] drm/amd/pm: update deep sleep status on smu v14.0.2/3
> 
> [AMD Official Use Only - AMD Internal Distribution Only]
> 
> -----Original Message-----
> From: Kenneth Feng <kenneth.feng@amd.com>
> Sent: Wednesday, October 16, 2024 3:19 PM
> To: amd-gfx@lists.freedesktop.org
> Cc: Wang, Yang(Kevin) <KevinYang.Wang@amd.com>; Feng, Kenneth <Kenneth.Feng@amd.com>
> Subject: [PATCH] drm/amd/pm: update deep sleep status on smu v14.0.2/3
> 
> disable deep sleep during the compute workload for the potential performance loss on smu v14.0.2/3
> 
> Signed-off-by: Kenneth Feng <kenneth.feng@amd.com>
> ---
>  drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0_2_ppt.c | 7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0_2_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0_2_ppt.c
> index 27f4e0ce447d..ecdd11a87311 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0_2_ppt.c
> +++ b/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0_2_ppt.c
> @@ -1784,7 +1784,7 @@ static int smu_v14_0_2_set_power_profile_mode(struct smu_context *smu,
>         DpmActivityMonitorCoeffInt_t *activity_monitor =
>                 &(activity_monitor_external.DpmActivityMonitorCoeffInt);
>         int workload_type, ret = 0;
> -
> +       uint32_t temp_profile_mode = smu->power_profile_mode;
>         smu->power_profile_mode = input[size];
> 
>         if (smu->power_profile_mode >= PP_SMC_POWER_PROFILE_COUNT) { @@ -1842,6 +1842,11 @@ static int smu_v14_0_2_set_power_profile_mode(struct smu_context *smu,
>                 }
>         }
> 
> +       if (smu->power_profile_mode == PP_SMC_POWER_PROFILE_COMPUTE)
> +               smu_v14_0_deep_sleep_control(smu, false);
> +       else if (temp_profile_mode == PP_SMC_POWER_PROFILE_COMPUTE)
> +               smu_v14_0_deep_sleep_control(smu, true);
> [Kevin]:
> ﻿
> This code logic doesn't seem easy to understand, If I understand correctly, can I modify it to the following writing style:
> ﻿
> If (new profile != current profile) {
>             smu_v14_0_deep_sleep_control(smu, new profile == compute profile ? false : true);
>             smu->power_profile_mode = new profile.
> }
> ﻿
> Best Regards,
> Kevin
>         /* conv PP_SMC_POWER_PROFILE* to WORKLOAD_PPLIB_*_BIT */
>         workload_type = smu_cmn_to_asic_specific_index(smu,
>                                                        CMN2ASIC_MAPPING_WORKLOAD,
> --
> 2.34.1
> 
> 
