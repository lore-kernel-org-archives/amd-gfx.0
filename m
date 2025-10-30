Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7CF71CCF9FE
	for <amd-gfx@archiver.kernel.org>; Thu, 30 Oct 2025 20:14:26 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2706910EA17;
	Thu, 30 Oct 2025 20:14:26 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="lnwLXnE8";
	dkim-atps=neutral
Received: from MW6PR02CU001.outbound.protection.outlook.com
 (mail-westus2azon11012009.outbound.protection.outlook.com [52.101.48.9])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6C99910EA17
 for <amd-gfx@lists.freedesktop.org>; Thu, 30 Oct 2025 20:14:25 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dDrnQ4uU+xKBbjVaJncTx0dwRcTfo9s35AJ3/GV4iE8+13jcWmHE7sfVv+drGiX4nG1pxK8KgBFtXcyUgoKLu60CqX+VkGW/prQlGTosvaf5ejA94aWOZJgHfk9R2cPCNTsoPN3/D1RLsOF6JwEPV9fagOxqc3cDATDnw99MIpfXaYGAgAc08wvEYZiBdrDiqzCiPmxqWrqNffhp2y6Il4eTGJiQomp74oqVqkLZRWXpJQGfZwHoBpupdZ0hFFGOdiwYT1t8/uRqKQQ08r2pmK6VbrlDwmi5rSVqUGphxxj0d7KgP+F8hObU2SVYL+AbB2rTGWGXQFBdTpjrlLMaFQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cbEXIGjQydaCz2Fs7VfiK3zC0bA333hgBzbBnWNMtxU=;
 b=kzs1ZsVf+1D+6A6/M0wOCQbEVHiCbPycdtH+UG9XfOQW+5lLu2MCk52bKvFFjuWjsTVQALlyqkoTD+Qf32PlJrk8WFO8ASlET+eu9wKuNPXbTQpeOyPUEM2RQid0mpJr89aG1GbSUJUSwtbHenJ/jjcw12wtlhZTT5wSqnDcJtc92keIBp0jif4Iej2syOaJDs4D4RlaHPydcJkJ02IjxHgsjLFkZqoEMtoBOzkJd8/3gOMHfn+oo7muJIlq7QeVpF38IErE7jpUv18rM+jYb+8bv60BsT8pJnDizcxlD/y2RIiU/KHu8ysrzYJtTVNzrrFpbOm9ueSKrwVwgmDr4w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cbEXIGjQydaCz2Fs7VfiK3zC0bA333hgBzbBnWNMtxU=;
 b=lnwLXnE83rCEfOtrpb+w3KXcHLWket7BrVkafrVbQqp3C9eY76aIwJwVYd2NJBdFHOVFdW/FpZn0CqjcWcIrLfrJT4C96VeaGJI9mewIaljga8v/n2C6CC2mvzv2kTrnkEJtY6YXRq4tc/1rafGOs5vMNWuur/3UXnr+5D9vKQo=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB5149.namprd12.prod.outlook.com (2603:10b6:5:390::14)
 by CH1PPF934D73F2C.namprd12.prod.outlook.com (2603:10b6:61f:fc00::61a) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9275.12; Thu, 30 Oct
 2025 20:14:22 +0000
Received: from DM4PR12MB5149.namprd12.prod.outlook.com
 ([fe80::36fa:deca:aaeb:75da]) by DM4PR12MB5149.namprd12.prod.outlook.com
 ([fe80::36fa:deca:aaeb:75da%4]) with mapi id 15.20.9253.018; Thu, 30 Oct 2025
 20:14:21 +0000
Message-ID: <0c8c8f75-a4ab-d0c3-067f-cb389d7c61f1@amd.com>
Date: Thu, 30 Oct 2025 16:14:18 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v2] drm/amdkfd: Fix GPU mappings for APU after prefetch
Content-Language: en-US
To: Alex Deucher <alexdeucher@gmail.com>,
 Harish Kasiviswanathan <Harish.Kasiviswanathan@amd.com>
Cc: amd-gfx@lists.freedesktop.org, Philip Yang <Philip.Yang@amd.com>
References: <20251030010027.2503555-1-Harish.Kasiviswanathan@amd.com>
 <CADnq5_MMZ+mE1=0aRRLE7dbfpndVOXL9UCODB7BeQg9QMyspJw@mail.gmail.com>
From: Philip Yang <yangp@amd.com>
In-Reply-To: <CADnq5_MMZ+mE1=0aRRLE7dbfpndVOXL9UCODB7BeQg9QMyspJw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: YQBPR0101CA0290.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:6d::26) To DM4PR12MB5149.namprd12.prod.outlook.com
 (2603:10b6:5:390::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB5149:EE_|CH1PPF934D73F2C:EE_
X-MS-Office365-Filtering-Correlation-Id: 04d71eac-7ba5-4df1-84b9-08de17f0e988
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?S1NWdm1ONFhlWGdNVFNqYUFpb1g4TGxJVXhVU1pSQzB2a2VpSkVqVVg3ZFNs?=
 =?utf-8?B?R3lRVEt1NEo0OTRzRG9pQmZNVWRkaUt2c1BDS2NFUk16UnlsbEpZRUVmLyt3?=
 =?utf-8?B?MGkrQStpcngwN3R3TzBreHd0NzBzc2FHbGhhK01oM3R0c2FTU3YzcTBRZEt1?=
 =?utf-8?B?U2pkc0xya3hmbFBBWVVSemtRLzhmcXpTQXAreHo4R1p2ditoSnJiT016dkF2?=
 =?utf-8?B?MFBwcEVkakp2bm8xY0RVZXE3Mys0K01KV3UxS1F4TmZzRnlSLy9NVzJZZWNh?=
 =?utf-8?B?T0FsWDBXZjlHaWJsNlhnOW1lbEFkU2xiUlBhL3ZxTDhDbFBQUUtrdlRoNGRT?=
 =?utf-8?B?dCs4TFRHNGZHaW9yWWNuQmNnUU1qR1gxZGtFM0NtTHoxUkVGYmdUOElFZFhU?=
 =?utf-8?B?dUJSS1daL1Iwb0NjMGxnQ1JjdUZYNkViYng1czQ0R1VSdy9KU1RoQW9aVGF3?=
 =?utf-8?B?TC8wKzFKSlBVdEVlVVJ1SzZLK1NuMVNRbEpUZmdVbWhSakJ5ckp3bTZaNXla?=
 =?utf-8?B?Z1M2N0k2eTNTUUQ3WTlLY1NDSTc5QzhVaXFmeE9Gd0VWNUpGc2ZpOHlsQkZa?=
 =?utf-8?B?alhVRHRudHdmNkRxTW9JaEJ5aGN4eDdCckdXUjRXWVRQeHZyMFROeXZRaDMv?=
 =?utf-8?B?UklMalBHT1YrZlc2QnZiakZwejVoQnhTSGlRNEd0SzdNaWMrQk5HTXhLRTlS?=
 =?utf-8?B?N0liNlN1WnkwQmxEeEdER2NFUHdqQjBKY0tBZUpaOGI5TFpGWUNIZmxTeHdQ?=
 =?utf-8?B?dFlmVHp5Q3g4VHVOL1VHejhGTUMxK3ZtUTFjbkdHMElQN3VyVDZoUUF1ei9K?=
 =?utf-8?B?b0lEbitPc3Y1Q05OenJlZGtlNTdTK1dVMEcreW9ndEdUR1FscUFhN1JyRUZ1?=
 =?utf-8?B?QzhESVFkNGRwUHNrS1I3NnNIQ2lLbXlOTUJnZFdxUFhTRSt5S2VqSFJRT0Zl?=
 =?utf-8?B?TWtISHZEYVBSd2J1K3Z0TCt1cnEzc0VSRytTVnRjbEN4TDFzRG5QSWpFN1ZP?=
 =?utf-8?B?V1o2bSszY1dmZVlxK3hKcXBFNnUwbUlRWFhOVW44RlBmT3hMbGRwR1RhZDRR?=
 =?utf-8?B?WDRyVTF2Z0lJd2l1MmVzcWRLOFVZbzIzUnR0RnJhcGVkNGtmQXhvdThZeHFk?=
 =?utf-8?B?VVNsV1BsYytLdWxRWW9zalhuR1Z2MXZ3U1hieE4rTGplMUcrZkF2TjRkMTdv?=
 =?utf-8?B?K0poTGFQbHJkdzM0WS8yZHdmeWI1NExMN2xIQW5VTW1PTDNhTzY0bm9SeExk?=
 =?utf-8?B?OHpjaG11a2JUK1JtSkNTWFJlZjVEclp6b2xPU0FwbzJJc0VobFZIeCtqaU84?=
 =?utf-8?B?WkNteHp4eWl5TjdGMkZXNGJGRnI5MXY1MXZUQ2YvTHJJMW5OSys4aWI2YXJV?=
 =?utf-8?B?Q0hzK0hYUXV3UDBnTS9pU1ZIckdaK2t5ZFBCWXdUbzZDR3VFRzliL2ZhSU9a?=
 =?utf-8?B?MVlxRjNjclNvL2hJbjFtbTdKeWVkd25lZEM5R3VUYnFWc2lkcUR5YXNTaWJB?=
 =?utf-8?B?Y0pzMTZXRGJ4VU1vcndZN2hESGV6SmRCdUEzbC9Ccm1NcFd2RURyQ1MyREoy?=
 =?utf-8?B?Nk5qb1NUbnpPMTUzWXNJUlVlNDlrZ0lYTzdKQ2lhK3U1ZWhuNThpdVhBVExz?=
 =?utf-8?B?WDNsTk5FN0hzZkxLY2tVQTBvSllTODhKRnZ5VzMzTzBYODZFL2xEck5qTUpr?=
 =?utf-8?B?eFFJYk0rRTJ5T2NaeFdBdzVvMzFpZjZ6QlQ5bFQySHg5VW9MbW5rMk9KbVpR?=
 =?utf-8?B?L2VQZVkvVDlPalo3emZuK2IySS96K2ZOZzFtM3N1aSsvc0IrK2JBeEJjUUdZ?=
 =?utf-8?B?OVUwS3I4VlpLU245N0dQbDU5WVBsVVF4bzg1REhxaVVQWGVhSG1pYzhSSWlS?=
 =?utf-8?B?bHpxSGZYUVRWUHZBVTB0UXQ5UnZLVkNQMlB6RWJnMytGdUs4MDFvR3FaNUVn?=
 =?utf-8?Q?C42QHyjYUHVnqLmSBbX1iPPGIq9CPmGB?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB5149.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WE4vaHhKbm1iZXdhbVNFMVd5NjhyT1lSQTRadnBuVEFyTUFIR3l4bVpCVHZt?=
 =?utf-8?B?TEdLb3gzSGlwdmFTZ0dzK1JEZWdZU3RWL09zVXlzZklrUlFDUWp2d0NKaWJC?=
 =?utf-8?B?c2o4bUJwQytrMTk1aFNuY0Z1K3VxdURybUdVeHBDWXZvKzBEUDc4N1FPU1VJ?=
 =?utf-8?B?Y2wzVzFqTzRUZWxPejQyb2xDMDhXRDBIWURMT2dNUTJscGxlZEhqL2N2bGE3?=
 =?utf-8?B?RjYwMVdOMlYwOXFVVHRySDJNM3g5OVhvdzZraFNxVzh6SmhMVHA0bC9XTjlY?=
 =?utf-8?B?a0NVZXY0Q09WVG9VRjduOElDd3VrQ0pYSWJTTmxjS3JVMytNZ0ROd1dxbjR6?=
 =?utf-8?B?TEpVbVltTTI1Q0dHRTFFWklxMWFwQ09DMENmM05TQmhlY0t1d1dxeTBNR0FV?=
 =?utf-8?B?RWNuNFlVd282R1dqcHNnSWdGVy8rdFBMM0c3Uk9XbG4yM3ZHSXN4SmZTUWRO?=
 =?utf-8?B?akg1TS9GWXRuMWtpYTVYL1YycHQzRTcwOFA3OFhFWmJiSHZGQ3krZjlFUlJY?=
 =?utf-8?B?Sm81UkVkMFNsUE5tb2ZuSHFZbGo2UGtheGZ6Ui9qbWpvNUdZcUJaNFhCYk5m?=
 =?utf-8?B?OVRraW8wdXpiY0U0aUV2OUxBQk5RdzJrTHVGUlEzMzFiaEp4UCtSR29aRHA1?=
 =?utf-8?B?U1pHR05uc2ZyMlRoRWVIazNKS2hZdzAwVHJzSGJPbUNBTDdmOUVocWpYdzd0?=
 =?utf-8?B?aGozaUxvSThGOE85eWNnQVAxWFlhZGtqNWlBQmZhak5iVjRveCt2TFkwSXZO?=
 =?utf-8?B?eTlGeEltbUhsMnQ4REZiRk5rKzVqUU41MmJ0UnhBeEtwU1BkNDkzblNtZWtt?=
 =?utf-8?B?WFhVbUwrMGlmUXlGK1B2ZzRjbmE4WjFjU05BdWZRbWhCUVpLbEhkbG1HWGp0?=
 =?utf-8?B?NTc5eVI0UUUzeFc0UVRKc1JZR0NSNDd1RkJWMVRyOWd1bUVpT0U1UWx5SWww?=
 =?utf-8?B?dFlhS2pQbk9mUDVjRXNXK2F4U3laS093TWt3TFo0a2RyRnVMZ1Vxdi91Z0lB?=
 =?utf-8?B?OExpTUN5VnE1blhzVmNLbUZUN3VoVFVuZzJHNlREYlZBUUpSTTE1ODA4YzRT?=
 =?utf-8?B?b3FiYlJHMzN2WXRhZUNZMENKQkVxSUJRbnJyOXBFQ1doVk1hQUJWc2hIOXZ3?=
 =?utf-8?B?bWRMMXlNY2Z5a3RUaTl1RlFzWjZEcW5mTTNHWEpMZXU3QmJSQVFHZkVjZGlz?=
 =?utf-8?B?bEpSdE1RWU1ES2pXZ0xwVVdleEhBbGE4MmJNY2ZzWjdtWm5KcmUwa2pKQTg5?=
 =?utf-8?B?N1JoNmI4TWlxV3RnYzRWbk9sZVYrcGZGUkM2cGNqVTdwOGRXRGJMYXU5WHdW?=
 =?utf-8?B?WWZqbkhPUUMxZkp4UnJ5UUJ0d2NrUExReDZGSzVtTGlRNnNUc1MrWDFoWDA5?=
 =?utf-8?B?bEZmQjcvbXpnTlFTbGNuUFNMYk1KWEdta3JDbTZNVUpUMkpKVWpRRTdYb0xP?=
 =?utf-8?B?NHg1aGN0dzBqaGZIazA0RHBjWjZpeisyUFJBVTdGZjh6SmpKd2t5R25aeXE0?=
 =?utf-8?B?djN6MXFJWHQ2MGpkYzNmdUxRRmE1aVVmQWpmYUNJME4vaHNsQWN1STJwOVlw?=
 =?utf-8?B?WlQrN2RUSjE0ZjFOUlBQK1ArNUU5aWFPb2ZxK2Fxa1llUlA1N1d5VDRJLzFk?=
 =?utf-8?B?a2wza29BQTVyc3l5OGhXU2VQMWJ6cnRPQ3dqaHkvY1o0aTNRNUZLYVU1T1Z1?=
 =?utf-8?B?SC9BQmFVZE9mQmhwdlh0ZG01NHFTcis0U0hML3E1UVBXcktBY3MzYzB3aXo2?=
 =?utf-8?B?L1V0aUxSNmZXR3JZcVV6R3d2VVQ2a2JmYUg1clBUNjFBWnpreThQMGg3Tmtt?=
 =?utf-8?B?U1Nsb0lsdUVVNFNJakIrMlpCOHliNHYrcnF4Ym5oc3ZyVXdjY0Y4RERSb2xE?=
 =?utf-8?B?K0toSlFmTU9GNndWNGhpcWFqTk5HLzMzWEhlVkdUZ2dvbE9leWhLOGdFeDlW?=
 =?utf-8?B?cWpVUzJzazYrbDdUbFIwdHh1b1RNWkZJNzJwYndRTFRodXJCdTcxSHhEeTBY?=
 =?utf-8?B?SDFZUlpDSWhNZTl0YlRoNXRDZ0tHbkNpUlJGMlBuSGhEc3J5T21NZDdBUFBl?=
 =?utf-8?B?bFU0dHVPSC9LRU1zUVhNZldjTS9tSVR6bCsxV1NoWC9DRVlrZWlWK3NZZGl0?=
 =?utf-8?Q?pQLU=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 04d71eac-7ba5-4df1-84b9-08de17f0e988
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5149.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Oct 2025 20:14:21.2529 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /lXCKx5ruuPKQUKLMDD+RWKY22zPCfGf3duriVMq1ZHN6/EQb1ArlhoqHECdzeSB
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH1PPF934D73F2C
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


On 2025-10-30 10:20, Alex Deucher wrote:
> On Wed, Oct 29, 2025 at 9:36 PM Harish Kasiviswanathan
> <Harish.Kasiviswanathan@amd.com> wrote:
>> Fix the following corner case:-
>>   Consider a 2M huge page SVM allocation, followed by prefetch call for
>> the first 4K page. The whole range is initially mapped with single PTE.
>> After the prefetch, this range gets split to first page + rest of the
>> pages. Currently, the first page mapping is not updated on MI300A (APU)
>> since page hasn't migrated. However, after range split PTE mapping it not
>> valid.
>>
>> Fix this by forcing page table update for the whole range when prefetch
>> is called.  Calling prefetch on APU doesn't improve performance. If all
>> it deteriotes. However, functionality has to be supported.
>>
>> v2: Use apu_prefer_gtt as this issue doesn't apply to APUs with carveout
>> VRAM
> apu_prefer_gtt is used by small APUs as well.  It depends on how much
> VRAM vs GTT is available on the system.
>
>          if (adev->flags & AMD_IS_APU) {
>                  if (adev->gmc.real_vram_size < gtt_size)
>                          adev->apu_prefer_gtt = true;
>          }

yes, if apu_perfer_gtt is true, then no page migration because 
best_prefetch_location is always CPU. For small APU, it will have same 
issue if KFD is used, prefetch split range page table not updated 
because no migration. This patch can fix the issue on both small APU and 
APP APU.

Reviewed-by: Philip Yang<Philip.Yang@amd.com>

> Alex
>
>> Suggested-by: Philip Yang <Philip.Yang@amd.com>
>> Signed-off-by: Harish Kasiviswanathan <Harish.Kasiviswanathan@amd.com>
>> ---
>>   drivers/gpu/drm/amd/amdkfd/kfd_svm.c | 7 +++++++
>>   1 file changed, 7 insertions(+)
>>
>> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
>> index c30dfb8ec236..76cab1c8aaa2 100644
>> --- a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
>> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
>> @@ -766,14 +766,21 @@ svm_range_apply_attrs(struct kfd_process *p, struct svm_range *prange,
>>   {
>>          uint32_t i;
>>          int gpuidx;
>> +       struct kfd_node *node;
>>
>>          for (i = 0; i < nattr; i++) {
>>                  switch (attrs[i].type) {
>>                  case KFD_IOCTL_SVM_ATTR_PREFERRED_LOC:
>>                          prange->preferred_loc = attrs[i].value;
>> +                       node = svm_range_get_node_by_id(prange, attrs[i].value);
>> +                       if (node && node->adev->apu_prefer_gtt && !p->xnack_enabled)
>> +                               *update_mapping = true;
>>                          break;
>>                  case KFD_IOCTL_SVM_ATTR_PREFETCH_LOC:
>>                          prange->prefetch_loc = attrs[i].value;
>> +                       node = svm_range_get_node_by_id(prange, attrs[i].value);
>> +                       if (node && node->adev->apu_prefer_gtt && !p->xnack_enabled)
>> +                               *update_mapping = true;
>>                          break;
>>                  case KFD_IOCTL_SVM_ATTR_ACCESS:
>>                  case KFD_IOCTL_SVM_ATTR_ACCESS_IN_PLACE:
>> --
>> 2.34.1
>>
