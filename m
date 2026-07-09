Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 06495C43458
	for <amd-gfx@archiver.kernel.org>; Thu,  9 Jul 2026 17:32:17 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8E14B10E0A0;
	Thu,  9 Jul 2026 17:32:16 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="GG7I4FOw";
	dkim-atps=neutral
Received: from BL2PR02CU003.outbound.protection.outlook.com
 (mail-eastusazon11011061.outbound.protection.outlook.com [52.101.52.61])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6FDC410E0A0
 for <amd-gfx@lists.freedesktop.org>; Thu,  9 Jul 2026 17:32:14 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mn3Pp3dbyLOQgLif3bqZ7WgVPK5cFTc3c7WmY9ihk1w7Q6hliTutRpQwqvz7p9FLdqIs8XSVdLqs9+1Og1lhSBl6ZkeZZ8I0GIuPaB89kb72fViprScgcS+fivEKI1o0c/1WJrxj0N1RJ9FNkLhEkF3cPZB729ULPN5U+ct97k9rvGUuhK6g6hJ13w4s3BAOlOqE2GB9V/7IA+hDm1JIudi3qVLe63CDtHTE4HYwRa6tT3pbvKkp6VCr7FTj4MRrkPm0CALz2x7CyC6LRbnWYonXvVDjOUyLh20CqSpYHxEh4AO6tzAwoYO59/XmZxJ5H7EPp5DiBUn3dfpmASOOSQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0LaRSRFjomzAUTePqhZ2jZsOQv1DAYTVBuFMN+varFI=;
 b=dGPB/PsoTal/RAMS6HFlaA4PUzkesn2CuSnKKRgqUDOix6bwGwyTAeuJVrJyDCHfWZO7BQjILJH6NHpXCE/3DUyejcmSL1TXWspaEtBjb8YoHYMBi4Efa2cMH3DLbFUA8dMoL6wB/rdQ3kW6F/uNKvFlwni0NOhmfQUI/jKjT5KOmoIIKqEIm3OWaiDiCcgsAvBljqnEQpEdqO2/WKltrolSOnjjbr4+F3Q5OyheefC2hWPwBtC2K4SrpRAunc4URJKOvWPFqKBRJigC2IAx+RDsgHcZ8PNuudUHnhEA6Fh62uQDKPoqpS0bbc8Yg0879MX+F243RlfXhCqoV0wgAA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0LaRSRFjomzAUTePqhZ2jZsOQv1DAYTVBuFMN+varFI=;
 b=GG7I4FOwNPNqSa7dzh5Z1PuqBmK+C4dvgPlMF/E1nyUEAB/nFOneIBcJ9rzpkpUqk7b1dq4nvh49XoT8mXpf3XIFxoMitAi3PFB2ru0FO+T47e86HU/T4qzWBZUrM46MbNhf5//p+gR9ffPvQeN9UMbpO2FIGiPT30xlfuoMhmM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by SA3PR12MB8048.namprd12.prod.outlook.com (2603:10b6:806:31e::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.10; Thu, 9 Jul
 2026 17:32:06 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c%5]) with mapi id 15.21.0181.008; Thu, 9 Jul 2026
 17:32:05 +0000
Message-ID: <42ed9967-7eb3-41c6-9f7a-c43b93833589@amd.com>
Date: Thu, 9 Jul 2026 19:32:01 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amdgpu: improve the amdgpu device init progress in
 sriov mode
To: "Li, Chong(Alan)" <Chong.Li@amd.com>, "Lazar, Lijo" <Lijo.Lazar@amd.com>, 
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Cc: "Deng, Emily" <Emily.Deng@amd.com>, "Chang, HaiJun"
 <HaiJun.Chang@amd.com>, "Skvortsov, Victor" <Victor.Skvortsov@amd.com>,
 Cursor <cursoragent@cursor.com>
References: <20260708083035.186400-1-chongli2@amd.com>
 <d3ffa862-8fff-40cb-8779-97d3bb4a429b@amd.com>
 <DS7PR12MB5768E74BF2292A0F8F87E0CE9BFF2@DS7PR12MB5768.namprd12.prod.outlook.com>
 <3ac3c6d5-8fad-4b0e-933d-42fa71a43657@amd.com>
 <49ba42a4-b661-4673-95a0-c218ec1482e3@amd.com>
 <de530731-21de-4470-9316-dccb767c87ac@amd.com>
 <DS7PR12MB5768E211043CC584F05A16569BFF2@DS7PR12MB5768.namprd12.prod.outlook.com>
 <989fc4ae-cbac-4f17-94cd-5be270845081@amd.com>
 <c963d1df-e1a3-4fa6-8514-3c4ab204088f@amd.com>
 <DS7PR12MB576870FE38FFB13002872F529BFF2@DS7PR12MB5768.namprd12.prod.outlook.com>
 <2d96166c-b192-41be-83d1-19eb64d7306f@amd.com>
 <DS7PR12MB57684EB76694DC4EB12791A09BFE2@DS7PR12MB5768.namprd12.prod.outlook.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <DS7PR12MB57684EB76694DC4EB12791A09BFE2@DS7PR12MB5768.namprd12.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR0P281CA0013.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:15::18) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|SA3PR12MB8048:EE_
X-MS-Office365-Filtering-Correlation-Id: 13dfbeb1-7ece-4c43-33a0-08dedddffea3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|366016|23010399003|4143699003|11063799006|3023799007|5023799004|22082099003|18002099003|56012099006|6133799003;
X-Microsoft-Antispam-Message-Info: tT7uD0CSMbFF7FMtDdaDUxYqXrPvazZE2WhAYHl/kDr6/Pe3fyanvbLSgluuxRlUC5F3w3lk/Bf4fYVpX+U47TnYBB7T+9wlzxyW6J1+ka/pGyASTEG8XeOYh28yhbLbXPXziYvBnv/0aKR2lXSnZc2kBQ6mxLbWdSmVoXRnx6UVQY2+mGvQECffY2OhnFDiCcUt45MlxdzLeWNq+YKnGb5C4f49oyfYYju6GhbdJprQQhS5N0/x+xTyMsesRvBXsnTSM8xSZULLg0vnjVpm0RuLOhq8BQxHtVzKzgNPa6LS0MoAHtcGagg90nlxkaG/5wQweCep/rg9wdTtvR0e8fX8mXd4Ns9O28vmDdXOXtFhcRgSpeQ7KhCZi6RI1mPBgJO47+HiPddl+4EGTxK3MdgfWG1Fjy30xAeh02uQjxd0/GpPX7T/UF8PNN2aLFY/3ffp0bKQSo2enm1MLWfTGgXAt9EoRVwhpIWulVU/d7gE4QHlZEQoVajLHPqFbluhQ2pOuKv5VaEvdv+wDq+oYUYU+xjS+qsYsZhHWhqPSsN40QkQ/fB68Xsdc2f5sPmWMcUadWZmO7Bt0v6Pn6A1LwoAJcqN8pT7sjlXidavM19g8Ax+psGK6MUSfz9JYlC2G6vH3xyNHuXUl0tBlcxVu+YXPayGTCJnAkSZXyLkFNU=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(23010399003)(4143699003)(11063799006)(3023799007)(5023799004)(22082099003)(18002099003)(56012099006)(6133799003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TlFCbkgwb3BIZjM2SzE2RjQ4UUZaVzE2b2pTQjgyZEhUVmk3akU4OXhaamZB?=
 =?utf-8?B?Y1d6MVd1Y2JBZ1o0dVdUVkdpY29jK010ZW00QmlIVFRJaW1ydTlJWFI3SWc4?=
 =?utf-8?B?aU9zOHYxampiQW9aTEc5aVBMWHBXRmkxM2o2VEY1dEVIWVBIbEpmem5SZEt4?=
 =?utf-8?B?ajBNelpiUEtheWNkUWs3UkFIWVA0VzJoRHo3enpvRm9QUURmejhXbjBlU1Zk?=
 =?utf-8?B?QkVOWDhWVDJqZW1RRFFIZkFVellTak1QSkRKZ1JFYkJmQS91RjZ4NVp4Tmxu?=
 =?utf-8?B?WkJMUHdEamo5QzE3Yk9LbzduaFUwRHpEOGpHQnRUSVFvMUhXQmhTM2Q1a0Np?=
 =?utf-8?B?cTJSb3QwWVBYdHVWREdSZDJZbVRoUlhBWjk3c0FVa28wQ3lBK0pBRERqYmVT?=
 =?utf-8?B?OURpa2tuNENJc0xuSzZqTVFtZEtlemtLd0hPcmJIalVHMEFoZ3QwMG5kNjd2?=
 =?utf-8?B?aGp3dHlMOHA3OGZSUXRDdzk0VlE4SFUyazVNK0dnZm9EcnhtUjRSRHIrRkNE?=
 =?utf-8?B?TjRSV3ZaTW1vSy9OdVZJTlcxL0RUNDVJREFSZE1NTzFKQTdrekR4WGZYYTRx?=
 =?utf-8?B?WFB1N1FYMDJ5OFMvRzloQjA3SzlBQXAzY3NPaFU0MldXcWY4K29NejVOZ1FO?=
 =?utf-8?B?aFFxZ0JxNkZrVTVCUU00WFNRcEZmbmJHUVFiOUo2TmRES2F0OXkwN1dyMVhV?=
 =?utf-8?B?d2V5WlVoQm12MjROdWZkVDVOUFM0aThGcG1IR3Q0aFFJeVhUWTJucU9RbHB1?=
 =?utf-8?B?Wk40UExERTJNcWVFQUV1WmdVS20reVdUNjhvR3FvaTFBelowbmJRWUtUVTE3?=
 =?utf-8?B?eEU5SVpSdmNtVHMzS3IzQ2d3ZExNUGJSVlpsbmErWlVMWjdFQVZNc2RjQWpH?=
 =?utf-8?B?QkkvMnV6YXJ0aURITlhEbDhjVitncHhxdHVoUnJvUjZ5SzVsN2U4cjF6YXRE?=
 =?utf-8?B?UGxBWTRoaWlpV3R0NHZCNlBTZjVPY21JQllIbjBFMnFnc0gvVVlKQWdMNGZK?=
 =?utf-8?B?Mk5rZytaa3M1WDFWa1R3Mk9TNmVaaU9saG9BU2dGRVZKc09vNW1XUXBZRTJV?=
 =?utf-8?B?bWVpYjBpZmdJNndYZkFjK204c1RwTFBkRnBmVnN6dElzUTROb0Q1K2JTUXNV?=
 =?utf-8?B?czJub00wS0FwdFdTNTdHS2pSVklOakk1a1A3STlMSnhUZU5HcldhTVNuY1Ji?=
 =?utf-8?B?Rkx5enI1eGNDZm9vTTdYN1ZxMWYwNzZCNUpKaU5SbUJLVFUvRkRrZ0hRWFpT?=
 =?utf-8?B?eDI2WXIrbnpXWjRJVE9tME95ck96NlJmSEdzenJLVEloYmIvZXhLVmx5RVR0?=
 =?utf-8?B?bDlmOTVvc1JrYUVWT3ZSNEFUNUxuWjhwRjdZYjdVS0hEanMydms0NytXSzVD?=
 =?utf-8?B?R1BMTENabDlnVERPOTZveThCcm14cDkrU2JpNURKNGhicExXNnlvZGNoRHJL?=
 =?utf-8?B?MmZyZjJKR2hiaXMwT0xueFZTZHE0bTZNTVJ0QW9jRzBhTW9ObjA3d2Yyd1FY?=
 =?utf-8?B?aEVWbEgxVHlUdFhNZFB3dUFmUDlGRXVERVhhWGR5azdKUTNzRWpMY3o4NEJH?=
 =?utf-8?B?Rk1yVjJXSDBQVnlHTjRjd1pwNFhOejdMVUQzU2ZjMEtJcnQrYXp5ZThXdTJ6?=
 =?utf-8?B?WE9MaWEvNzROSE9xMk9uRW92bTJ2TGh4V1BBL0MwME5MN1hmTERWaGh5ZWhL?=
 =?utf-8?B?VXhveC9pcmxFbTJUVnBRZDBLZ2lLdWVWaUdPaHBEeXg3eC8zdVpWWWpBaCs0?=
 =?utf-8?B?Q0dteU90YVJuUWM5TXExdllBTmg2am1lT1M2VXRKWmF3aVpJcXJYY2lWSXEw?=
 =?utf-8?B?cjl5WWN2RkpOVXBFQ1VNWGNoNGxyOUQ4ZHFvT2ZucGltM3lmeGFVRjNaTzMz?=
 =?utf-8?B?Zy9MQ2gxa2VxSEN4WTdscXY3WHFncHJRckdUZDlXdWlMSjg1RnBVb2ZXQUFB?=
 =?utf-8?B?YnpoVjNYVUhNcmJ0bHYwY0JLSmZReUtvUjM0WTRJT0ppZUZjbFlpTDcrZE8x?=
 =?utf-8?B?YXN4VGd3UDBnRXFpK3ZhS3RnVmlCYThmRzJWSFJEdlh1UEoxYXdudVU0WENZ?=
 =?utf-8?B?MlNrM21KUTBzYi9MRmdrWnk3MSsyMktzWnF4RVN6MThYLzBncjVhSE04eG1l?=
 =?utf-8?B?bkRFVG9kQUxsV1dKbDZDWVgraEZTdHR3cnNBdlhBcytpRll2OWRyUDRFTDhG?=
 =?utf-8?B?Vlp5Tk93ZWhGeGVlODNYSENmVEhCVnZMMjl2ZEhDVmdxSzdEM2xyQUVGalFV?=
 =?utf-8?B?L3FaTWw5UTlZTEJaU3A3cklCY0hJVno1WjZINWtEUmVid3hNZm1pRlU3MUxo?=
 =?utf-8?Q?XI4E6LB0swbvsDQKjW?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 13dfbeb1-7ece-4c43-33a0-08dedddffea3
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jul 2026 17:32:05.6134 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uCAZYeuDOHDzHzCe9BcZxaq5dSHuum669mv8J8zLYxgfTFOuKGFMCKZBX/rsvnJN
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB8048
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

Hi all,

I've discussed the issue with Alex today.

The current approach of keeping full GPU access while discovery has been intentionally added this way over 6 years ago after some back and forth discussion.

So that has been working reliable for quite a while and we don't see any justification to change that.

If the ESXi hypervisor has a problem with this then that needs to be handled on the hypervisor side.

This patch is rejected.

Regards,
Christian.

On 7/9/26 12:35, Li, Chong(Alan) wrote:
> AMD General
> 
> Hi, Lijo.
> 
> Yes, the current GIM driver ensures the early init data is placed within the VF’s visible BAR0 aperture.
> 
> 
> Thanks,
> Chong.
> 
> -----Original Message-----
> From: Lazar, Lijo <Lijo.Lazar@amd.com>
> Sent: Thursday, July 9, 2026 3:56 PM
> To: Li, Chong(Alan) <Chong.Li@amd.com>; Koenig, Christian <Christian.Koenig@amd.com>; amd-gfx@lists.freedesktop.org
> Cc: Deng, Emily <Emily.Deng@amd.com>; Chang, HaiJun <HaiJun.Chang@amd.com>; Skvortsov, Victor <Victor.Skvortsov@amd.com>; Cursor <cursoragent@cursor.com>
> Subject: Re: [PATCH] drm/amdgpu: improve the amdgpu device init progress in sriov mode
> 
> 
> 
> On 08-Jul-26 6:12 PM, Li, Chong(Alan) wrote:
>> AMD General
>>
>> Hi, Lijo.
>>
>> " In this commit, the statement is different."
>> " It says FB access is enabled if init_data request is sent."
>>
>> Yes, VF FB access is enabled if init_data request is sent.
>>
>> However, without full GPU access, the guest cannot access the MM_INDEX/MM_DATA registers.
>>
>> With the legacy/existing read path, VF_FB_EN must be enabled so the
>> host can dump early init data into the VF FB, and full GPU access is required so the guest can copy that data through the MM_INDEX/MM_DATA registers.
>>
>> I submitted patch " [PATCH 1/2] drm/amdgpu: read FB through BAR0 when
>> aperture is unavailable " , With the new
>> amdgpu_device_read_fb_via_bar0() path, the guest can read the VF FB
>> without full GPU access
>>
> 
> Yes, I saw that one. One other question - does host driver guarantee that discovery data will always be copied to visible BAR aperture of VF?
> If not, it will still require mmindex/data regardless of FB access enablement.
> 
> Thanks,
> Lijo
> 
>>
>> Thanks,
>> Chong.
>>
>>
>> -----Original Message-----
>> From: Lazar, Lijo <Lijo.Lazar@amd.com>
>> Sent: Wednesday, July 8, 2026 7:18 PM
>> To: Koenig, Christian <Christian.Koenig@amd.com>; Li, Chong(Alan)
>> <Chong.Li@amd.com>; amd-gfx@lists.freedesktop.org
>> Cc: Deng, Emily <Emily.Deng@amd.com>; Chang, HaiJun
>> <HaiJun.Chang@amd.com>; Skvortsov, Victor <Victor.Skvortsov@amd.com>;
>> Cursor <cursoragent@cursor.com>
>> Subject: Re: [PATCH] drm/amdgpu: improve the amdgpu device init
>> progress in sriov mode
>>
>>
>>
>> On 08-Jul-26 4:18 PM, Christian König wrote:
>>> Hi Chong,
>>>
>>> On 7/8/26 12:25, Li, Chong(Alan) wrote:
>>>> AMD General
>>>>
>>>> Hi, Christian.
>>>>
>>>> The code " early_full_gpu_access = (adev->virt.req_init_data_ver == 0);" is related to the ASIC type, not the host platform:
>>>>
>>>>
>>>> adev->virt.req_init_data_ver is initialized by amdgpu_virt_request_init_data().
>>>>
>>>> Some legacy ASICs, such as CHIP_VEGA20 and CHIP_ALDEBARAN, do not send amdgpu_virt_request_init_data() to the host.
>>>>
>>>> For those ASICs, the host dumps the early init data only after the guest requests full GPU access.
>>>> Therefore, those ASICs still need to request full GPU access before the guest driver can read the early init data from the VF FB.
>>>
>>> No, exactly that is not the case as far as I can see. See the commit I mentioned below.
>>>
>>> According to that starting from SIENNA_CICHLID the full GPU access is mandatory for reading the discovery table.
>>>
>>
>> It could also be because the legacy/existing way used mmindex/data, and that required full access including mmio register access.
>>
>> In this commit, the statement is different.
>>
>> "In SR-IOV, the guest sends GPU_INIT_DATA, then the host enables VF_FB_EN and places early initialization data, such as IP discovery, VBIOS, and PF-VF exchange data, in the VF FB"
>>
>> It says FB access is enabled if init_data request is sent.
>>
>> Thanks
>> Lijo
>>
>>> So I absolutely clearly have to reject your patch here.
>>>
>>> As far as I can see this is a hack for ESXi and that is not going to fly.
>>>
>>> Regards,
>>> Christian.
>>>
>>>>
>>>>
>>>>
>>>>           static bool amdgpu_virt_init_req_data(struct amdgpu_device *adev, u32 reg)
>>>>           {
>>>>                   ...
>>>>                   case CHIP_VEGA20:
>>>>                   case CHIP_ARCTURUS:
>>>>                   case CHIP_ALDEBARAN:
>>>>                           soc15_set_virt_ops(adev);
>>>>                           break;
>>>>                   case CHIP_NAVI10:
>>>>                   case CHIP_NAVI12:
>>>>                   case CHIP_SIENNA_CICHLID:
>>>>                   case CHIP_IP_DISCOVERY:
>>>>                           nv_set_virt_ops(adev);
>>>>                           /* try send GPU_INIT_DATA request to host */
>>>>                           amdgpu_virt_request_init_data(adev);
>>>>                           break;
>>>>                   ...
>>>>           }
>>>>
>>>> Thanks,
>>>> Chong.
>>>>
>>>> -----Original Message-----
>>>> From: Koenig, Christian <Christian.Koenig@amd.com>
>>>> Sent: Wednesday, July 8, 2026 6:24 PM
>>>> To: Lazar, Lijo <Lijo.Lazar@amd.com>; Li, Chong(Alan)
>>>> <Chong.Li@amd.com>; amd-gfx@lists.freedesktop.org
>>>> Cc: Deng, Emily <Emily.Deng@amd.com>; Chang, HaiJun
>>>> <HaiJun.Chang@amd.com>; Skvortsov, Victor
>>>> <Victor.Skvortsov@amd.com>; Cursor <cursoragent@cursor.com>
>>>> Subject: Re: [PATCH] drm/amdgpu: improve the amdgpu device init
>>>> progress in sriov mode
>>>>
>>>> On 7/8/26 12:03, Lazar, Lijo wrote:
>>>>>
>>>>>
>>>>> On 08-Jul-26 3:23 PM, Christian König wrote:
>>>>>> On 7/8/26 11:35, Li, Chong(Alan) wrote:
>>>>>>> AMD General
>>>>>>>
>>>>>>> Hi, Christian.
>>>>>>>
>>>>>>> This version of the patch is not host-platform dependent; all host platforms follow the same path.
>>>>>>>
>>>>>>> I verified this patch with KVM in my local environment and with ESXi on a borrowed server.
>>>>>>>
>>>>>>> Distinguishing the host platform was a mistake, and I have
>>>>>>> explained the situation at the end of the patch email.
>>>>>>>
>>>>>>> I have pasted the content below:
>>>>>>>
>>>>>>>            Hi, Christian and Lijo.
>>>>>>>
>>>>>>>            Sorry, I made a mistake.
>>>>>>>            Host access to the VF FB is not platform-dependent. After the host driver sets VF_FB_EN in response to GPU_INIT_DATA, the host can access the VF FB.
>>>>>>>
>>>>>>>            I borrowed an ESXi server and tested this patch there.
>>>>>>>            The amdgpu driver works normally.
>>>>>>>
>>>>>>>            I rewrote the background. Is anything still unclear?
>>>>>>
>>>>>> You still have this check here in the code: "early_full_gpu_access = (adev->virt.req_init_data_ver == 0);".
>>>>>>
>>>>>> As far as I can see that is Hypervisor specific and a NO-GO.
>>>>>>
>>>>>
>>>>> I think this should be seen as a policy set by host driver on when a guest operation is allowed. Host driver could do it based on other conditions also, not specific to hypervisor environment.
>>>>
>>>> No, this was intentionally changed in 2020 because of a new feature. See this commit here:
>>>>
>>>> commit 00a979f3d69e0c275e88c741b854dbe0d5238ae0
>>>> Author: Wenhui Sheng <Wenhui.Sheng@amd.com>
>>>> Date:   Tue Jun 23 13:43:49 2020 +0800
>>>>
>>>>       drm/amdgpu: invoke req full access early enough
>>>>
>>>>       From SIENNA_CICHLID, HW introduce a new protection
>>>>       feature which can control the FB, doorbell and MMIO
>>>>       write access for VF, so guest driver should request
>>>>       full access before ip discovery, or we couldn't access
>>>>       ip discovery data in FB.
>>>>
>>>>       Signed-off-by: Wenhui Sheng <Wenhui.Sheng@amd.com>
>>>>       Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>
>>>>       Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
>>>>
>>>> So as far as I can see this change here will break older hypervisor versions and that is absolutely clear reason to NAK it.
>>>>
>>>> Regards,
>>>> Christian.
>>>>
>>>>>
>>>>> Thanks,
>>>>> Lijo
>>>>>
>>>>>> Regards,
>>>>>> Christian.
>>>>>>
>>>>>>>
>>>>>>> Thanks,
>>>>>>> Chong.
>>>>>>>
>>>>>>>
>>>>>>>
>>>>>>>
>>>>>>>
>>>>>>>
>>>>>>> -----Original Message-----
>>>>>>> From: Koenig, Christian <Christian.Koenig@amd.com>
>>>>>>> Sent: Wednesday, July 8, 2026 5:05 PM
>>>>>>> To: Li, Chong(Alan) <Chong.Li@amd.com>;
>>>>>>> amd-gfx@lists.freedesktop.org
>>>>>>> Cc: Deng, Emily <Emily.Deng@amd.com>; Chang, HaiJun
>>>>>>> <HaiJun.Chang@amd.com>; Skvortsov, Victor
>>>>>>> <Victor.Skvortsov@amd.com>; Lazar, Lijo <Lijo.Lazar@amd.com>;
>>>>>>> Cursor <cursoragent@cursor.com>
>>>>>>> Subject: Re: [PATCH] drm/amdgpu: improve the amdgpu device init
>>>>>>> progress in sriov mode
>>>>>>>
>>>>>>> On 7/8/26 10:25, chong li wrote:
>>>>>>>> v2:
>>>>>>>> Some legacy ASICs do not send amdgpu_virt_request_init_data().
>>>>>>>> Only keep the full GPU access request early when request_init_data is not sent.
>>>>>>>>
>>>>>>>> v1:
>>>>>>>> Move the initialization of non-GPU resources out of the full GPU
>>>>>>>> access region during AMDGPU device initialization.
>>>>>>>>
>>>>>>>> Background:
>>>>>>>> In SR-IOV, the guest sends GPU_INIT_DATA, then the host enables
>>>>>>>> VF_FB_EN and places early initialization data, such as IP
>>>>>>>> discovery, VBIOS, and PF-VF exchange data, in the VF FB. The
>>>>>>>> guest should then be able to read this data before requesting full GPU access.
>>>>>>>>
>>>>>>>> Before this patch, the VF still requested full GPU access in
>>>>>>>> amdgpu_device_ip_early_init(). At that point TTM is not
>>>>>>>> initialized yet, so the normal VRAM aperture mapping is
>>>>>>>> unavailable and the guest falls back to MM_INDEX/MM_DATA
>>>>>>>> register access. That register path requires full GPU access.
>>>>>>>>
>>>>>>>> Use the BAR0 framebuffer read path,
>>>>>>>> amdgpu_device_read_fb_via_bar0(), for the early init-data copy
>>>>>>>> instead of MM_INDEX/MM_DATA. This lets the driver delay the full
>>>>>>>> GPU access request until after the early init data has been copied.
>>>>>>>
>>>>>>> That looks like it goes into the right direction, but as far as I can see it is still an ESXi specific change.
>>>>>>>
>>>>>>> So once more: We can't adjust the driver to the hypervisor!
>>>>>>>
>>>>>>> Either this works on all hypervisors or I have to reject the change.
>>>>>>>
>>>>>>> Regards,
>>>>>>> Christian.
>>>>>>>
>>>>>>>>
>>>>>>>> Signed-off-by: chong li <chongli2@amd.com>
>>>>>>>> Co-authored-by: Cursor <cursoragent@cursor.com>
>>>>>>>> ---
>>>>>>>>     drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 21
>>>>>>>> +++++++++++++++++----
>>>>>>>>     drivers/gpu/drm/amd/amdgpu/mxgpu_ai.c      |  4 ++--
>>>>>>>>     2 files changed, 19 insertions(+), 6 deletions(-)
>>>>>>>>
>>>>>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>>>>>>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>>>>>>>> index 610d82b79de3..ac66796e8634 100644
>>>>>>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>>>>>>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>>>>>>>> @@ -38,6 +38,10 @@
>>>>>>>>     #include <linux/apple-gmux.h>
>>>>>>>>     #include <linux/nospec.h>
>>>>>>>>
>>>>>>>> +#ifdef CONFIG_X86
>>>>>>>> +#include <asm/hypervisor.h>
>>>>>>>> +#endif
>>>>>>>> +
>>>>>>>>     #include <drm/drm_atomic_helper.h>
>>>>>>>>     #include <drm/drm_client_event.h>
>>>>>>>>     #include <drm/drm_crtc_helper.h> @@ -1987,16 +1991,19 @@
>>>>>>>> static int amdgpu_device_ip_early_init(struct
>>>>>>>> amdgpu_device *adev)  {
>>>>>>>>          struct amdgpu_ip_block *ip_block;
>>>>>>>>          struct pci_dev *parent;
>>>>>>>> -     bool total, skip_bios;
>>>>>>>> +     bool total, skip_bios, early_full_gpu_access = false;
>>>>>>>>          uint32_t bios_flags;
>>>>>>>>          int i, r;
>>>>>>>>
>>>>>>>>          amdgpu_device_enable_virtual_display(adev);
>>>>>>>>
>>>>>>>>          if (amdgpu_sriov_vf(adev)) {
>>>>>>>> -             r = amdgpu_virt_request_full_gpu(adev, true);
>>>>>>>> -             if (r)
>>>>>>>> -                     return r;
>>>>>>>> +             early_full_gpu_access =
>>>>>>>> +(adev->virt.req_init_data_ver == 0);
>>>>>>>> +             if (early_full_gpu_access) {
>>>>>>>> +                     r = amdgpu_virt_request_full_gpu(adev, true);
>>>>>>>> +                     if (r)
>>>>>>>> +                             return r;
>>>>>>>> +             }
>>>>>>>>
>>>>>>>>                  r = amdgpu_virt_init_critical_region(adev);
>>>>>>>>                  if (r)
>>>>>>>> @@ -2159,6 +2166,12 @@ static int
>>>>>>>> amdgpu_device_ip_early_init(struct amdgpu_device *adev)
>>>>>>>>          if (!total)
>>>>>>>>                  return -ENODEV;
>>>>>>>>
>>>>>>>> +     if (amdgpu_sriov_vf(adev) && !early_full_gpu_access) {
>>>>>>>> +             r = amdgpu_virt_request_full_gpu(adev, true);
>>>>>>>> +             if (r)
>>>>>>>> +                     return r;
>>>>>>>> +     }
>>>>>>>> +
>>>>>>>>          if (adev->gmc.xgmi.supported)
>>>>>>>>                  amdgpu_xgmi_early_init(adev);
>>>>>>>>
>>>>>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/mxgpu_ai.c
>>>>>>>> b/drivers/gpu/drm/amd/amdgpu/mxgpu_ai.c
>>>>>>>> index 9a40107a0869..340703d89d6b 100644
>>>>>>>> --- a/drivers/gpu/drm/amd/amdgpu/mxgpu_ai.c
>>>>>>>> +++ b/drivers/gpu/drm/amd/amdgpu/mxgpu_ai.c
>>>>>>>> @@ -185,8 +185,8 @@ static int
>>>>>>>> xgpu_ai_send_access_requests(struct
>>>>>>>> amdgpu_device *adev,
>>>>>>>>          } else if (req == IDH_REQ_GPU_INIT_DATA){
>>>>>>>>                  /* Dummy REQ_GPU_INIT_DATA handling */
>>>>>>>>                  r = xgpu_ai_poll_msg(adev,
>>>>>>>> IDH_REQ_GPU_INIT_DATA_READY);
>>>>>>>> -             /* version set to 0 since dummy */
>>>>>>>> -             adev->virt.req_init_data_ver = 0;
>>>>>>>> +             /* Version is set to 1 since GPU_CRIT_REGION_V1 */
>>>>>>>> +             adev->virt.req_init_data_ver = GPU_CRIT_REGION_V1;
>>>>>>>>          }
>>>>>>>>
>>>>>>>>          return 0;
>>>>>>>
>>>>>>
>>>>>
>>>>
>>>
>>
> 

