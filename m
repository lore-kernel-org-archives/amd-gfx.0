Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2097FC27C53
	for <amd-gfx@archiver.kernel.org>; Fri,  7 Jun 2024 14:51:27 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A86E010EC7F;
	Fri,  7 Jun 2024 14:51:26 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="GzfkNuHt";
	dkim-atps=neutral
Received: from NAM04-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam04on2071.outbound.protection.outlook.com [40.107.100.71])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2886910EC7F
 for <amd-gfx@lists.freedesktop.org>; Fri,  7 Jun 2024 14:51:25 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JKqQbwYNuh3oUqaSNBOy7bkv51yvOF/dL/crrTLc1JBXo+j2ePsBlTZyhCLXqPhbQXBIA5teTQJudCGPRt1IYUKGq1QdaAFhi6zqx33qdJbWIz0GvIgpODJ15pRRDjdHucaoMEG9Si8tA4oBlX7sv5yr3Sb5Ou86Ko1q8SjVOeoURcQ0z17+KNlKy0bwrsk6zFyBYthbDe9uQiUUTHk21QRD6q+o9sM2TZLLla4BSDqxJC4AFkx2lZrc1TEtsFUgXHmRf7adFkTl+OlN0HbPctO83yVGAuJTHGWixw6cuXT0P3VI+KQOG8d8uJ8kB3EZ1JyRX8Ekt8tEH0EyWtSkMw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8ZHJ5raT4mhSnNNc3wLMhLntfUinyAdyShrmPoeMP4o=;
 b=U/udZtCVTk3CjPilXpS47MG6d75gE5doudjJqYRzOp1KWLlxmFIkbGJCHeG9uHLtdoBpoO+v7lmL7zQUu+J6G5tGbs0HdujeMV8S7okMxoBr5Ko5wbltfHcj+9ftAJgbbJOYWBRA+YxMPVpnj9oFywu5QZVTwgpbFoh22HXW4LWy9JOGBW0TUvYiE2XJ+Va6Hk9Vof+BKkIkkV3Jz8tDXW5YE/OEDg9BN3QO7hXEL4JgFivOi/XDhIEHLS+Nz/k6b37isTm5X9QdpYPJ5lypbq1aELSchzuMHWRKT6J7GKp5CIH93gtQEkWpVSoFPtUrpJ7eI3TDRJjkt81FOk+pVQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8ZHJ5raT4mhSnNNc3wLMhLntfUinyAdyShrmPoeMP4o=;
 b=GzfkNuHt1BU9+R8P2NqeUFSDP0caQKT8rgwmcXs9speZ+DddHLQ3lE+ADJFA98oXU/td2iuOqhFJZ1jkZjbtc97NFqETWg/aZ382/c69q1Ze+UuIje97MTbx2CAakkSZz2LnTZlZ9IxQ7aXU97vXU58htSdTO/GtKwuIk7xRhpI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SJ0PR12MB5673.namprd12.prod.outlook.com (2603:10b6:a03:42b::13)
 by DM4PR12MB6253.namprd12.prod.outlook.com (2603:10b6:8:a6::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.24; Fri, 7 Jun
 2024 14:51:20 +0000
Received: from SJ0PR12MB5673.namprd12.prod.outlook.com
 ([fe80::ec7a:dd71:9d6c:3062]) by SJ0PR12MB5673.namprd12.prod.outlook.com
 ([fe80::ec7a:dd71:9d6c:3062%2]) with mapi id 15.20.7633.021; Fri, 7 Jun 2024
 14:51:19 +0000
Message-ID: <ddc7a5cc-0ce8-4769-8807-56cb2fc9e166@amd.com>
Date: Fri, 7 Jun 2024 16:51:15 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/ttm: Add cgroup memory accounting for GTT memory
To: "Joshi, Mukul" <Mukul.Joshi@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Cc: "Kuehling, Felix" <Felix.Kuehling@amd.com>,
 "Bhardwaj, Rajneesh" <Rajneesh.Bhardwaj@amd.com>,
 "Yang, Philip" <Philip.Yang@amd.com>
References: <20240606192233.2836986-1-mukul.joshi@amd.com>
 <c2ce5317-a817-48d8-9fa7-ae6dcfbdaf3b@amd.com>
 <DM4PR12MB64450D65311D55DF3ABABE0FEEFB2@DM4PR12MB6445.namprd12.prod.outlook.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <DM4PR12MB64450D65311D55DF3ABABE0FEEFB2@DM4PR12MB6445.namprd12.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR0P281CA0138.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:96::7) To SJ0PR12MB5673.namprd12.prod.outlook.com
 (2603:10b6:a03:42b::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR12MB5673:EE_|DM4PR12MB6253:EE_
X-MS-Office365-Filtering-Correlation-Id: 744960d3-62e8-4402-20de-08dc87014ab0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|1800799015|366007|376005;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?RlFBUW1HZUVCVEtMU2ZIdHBlaW56Zy9QbjNHUWhrYmI1cm9BRjdUb296anFK?=
 =?utf-8?B?S3ZReCs0MFhCelAwVjV0eW9IUkdxNWd6dENSbzU2M1h1ZEYveitsemJ5V3dw?=
 =?utf-8?B?QzU1TDN4d01NY1lld2EwcTZWS0J1US83dC9TbGRGNVg3RFpSVG55UFdiVlZV?=
 =?utf-8?B?cWdYYXBUVlpZUG9xbDMwbG5KTi8vSlFkV0dYVjl3dmZQYjcvOUk3QnR0bXRB?=
 =?utf-8?B?N2ZXYVFYL01pMUIxaTA5aHlFcEd5dyt0ZFBUQmtWYW1FS0V4QVEvQmJGZWo5?=
 =?utf-8?B?aGlvQ0xVNTR0Y0xjM0pvdk4yR280UVNObzVZYVowY0tQWG5iYk1sdEg1OUxP?=
 =?utf-8?B?Q2pzcm00RktqMDRCYmdrT1hZQWhUZVViNXdVcHgwQ3hSYjlIT3o0Sks0enZL?=
 =?utf-8?B?ZVB1ck1jUVJVeHVBNk54eVVCSkVGbEFyQkVkNEdwT3RzYUl3VFkzL3lRYXdz?=
 =?utf-8?B?eTFmS3hnMXpBRUFoRktQbjl3UEtjRnM3ZGhQM0FCeTZaSFVKc29EdE8xU2da?=
 =?utf-8?B?YmM2Q3RESnE0eHZ0aXpJeTNuZ1h2OHNDaTROcE1RcER1R3pQTTc5SXUveDBV?=
 =?utf-8?B?aXgza3NRQzBSUmpSQ3VrSXJxSmZESUxySzVqYTRKZjhpb1NXRFp0WHN5ZFdk?=
 =?utf-8?B?eVI5c2NMUUxTNEg4L1VwTE1OdzNBMTEwOTJkRkpMRGVYeU9oaDgvOWFCQloy?=
 =?utf-8?B?ZGYwaTRiTStCb21HcDcyZTRhTlZxLzg4UFhQRzhPZkh0VGhSQjk4dXlVdmxH?=
 =?utf-8?B?MjhDdGRQK1VMN0NqaEt2WHB1VXRKZDA3eFBQUGFtYjF5MWZuUERHM0dBQWda?=
 =?utf-8?B?bEdwSmYxc1lWdFVCdVRnMTg5UGxtRVJEOVdzUEEwbFJEMTVNRGlOM05iV2ls?=
 =?utf-8?B?ay94OHJZTW5LU2pnS1cxRW5LbnJIdmhVbFVVbUpIWTBkT0VrRWgrY25pNWRa?=
 =?utf-8?B?OUg1Wi9Ebm5vK3UvVFJqQUFQQjFOTEpMOStxaGFxQmVNNzFzMGduMHBXc1Jh?=
 =?utf-8?B?OVFlWXNHM3VCNlJFSy9KeHR4cmN4ckl2MWMvWERMSmExSGIvQXc0U213T0dG?=
 =?utf-8?B?VFhNQlRWSFZyaHdGM1VnVlVsOGxzRmg0aWttQTVuaE1rWlAvYVl5dnFJN2xZ?=
 =?utf-8?B?ejgvUmNIdTIrMDRYckdsSGpmcFFoaFZSMGw3NEt2RWlCNGVrOEFuRk9OOFhh?=
 =?utf-8?B?bUxTMDNsVjREdlVUM1oyelpGdytuNXRMdlY5VkJuUy9wL3pCYjA0R3NGMFpz?=
 =?utf-8?B?bXI5Q0VlSjVJMGpZUk43K1RFNVgxdXJ2cnJTOTVkZ2hvQXQ4QXBOYXV2Nk9W?=
 =?utf-8?B?Um9ZOUV4Z1hBODRBRTNibHpQdEdQWkgweGdnTXBRbEk3YXE4RGxoT1h2ajN5?=
 =?utf-8?B?UUZ6NVNVQXBTcnhWOHZ0dEd3RkNIcXlNclZrUW5NcUtnT1dSSDhnVU9pN1Ru?=
 =?utf-8?B?U0VRa3MzMFd3eVAyV252a3Z2OFFkTnY1eU9ITnExa3lwQi96T3Q4NTY1aSt4?=
 =?utf-8?B?Q2VmTEhsdHV3aTYxU0JzUnF4Wm1HOEVscDBDVWtXdUhvc1MxSHNFOUJWMjl1?=
 =?utf-8?B?S05abDZOV1l1Rnl1YVA3Vnl3MG5XaGIreUtNU3R6dzRoNSttQlZWdUJpQ2lv?=
 =?utf-8?B?VGc3ZHR1a0swTzJKeng1cTNseVRUS3EyclIrMkowR0NROUhZekp2bzVEWnRG?=
 =?utf-8?B?OFpQOVAzV05COXJjVi9Zb0FlTDVwVThwMTI4aHlqYnBpRVlmUTRKMTVrTm5P?=
 =?utf-8?Q?WRGUnCXxkp/bCNO6PccHy/gI356o+7iCJCbTLc5?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ0PR12MB5673.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(1800799015)(366007)(376005); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UlNucGoyZWJ6cWVKY0V2d3VObnBTMXlGU2haSmFsOU5zdm5kZ0ZIcXF1dTJL?=
 =?utf-8?B?TVRJZGtZL09qTURRbEpleGthWmpZWFI4VlVkQS9pT0NienR4UFdPMnBSSzJk?=
 =?utf-8?B?a254aG5WamRHWlhIMjJMaHlHZHoxWTZBZzJCalVBZE5QalFqYkc4TDZONUNS?=
 =?utf-8?B?T3NZNlJBS01UZnIrd1Jnck40enBWSUwwa0hQZWhGdDFmVHBhN0w1bDhtMjNQ?=
 =?utf-8?B?M3FxNGs4Q25TWWZTRzFBMGtQRExtYk9wQThuVVMyanhNL2lGbTFDR1JlU0VX?=
 =?utf-8?B?WTJFMEZPZGxtVnpjZzczVW4wcFZQaE1qSjV5MTF3bUplSEhidXVpVkJ2NVFE?=
 =?utf-8?B?Z2U3dWtnc3BnT09aUmNXYk9LMmZSTXNnVHN5TGxYV0o4QitNZWVvUkVXTWU0?=
 =?utf-8?B?NFdtZmluZWFzVmMyTzZ6YkgwR2hmNUoxdkl1Tk1RWmNKeU5RdGVHb3YvK0pi?=
 =?utf-8?B?S1lmTTJMV3lqR0hYMGg1ajZPVE0zZEEvOXgrMkhoSlNrbjdyQ1A0NDdZTHRO?=
 =?utf-8?B?d2JnMG5ud0gvaHgwREJ1dWVnLzhJVXBKYStEK1R3T3UvMkZCWHQwYWFmWCt3?=
 =?utf-8?B?VUQ2YlRsVUdzVldTNlBNd2FUZGRJRFpwbEU5NTYzWE96azI4WTRCQ3V2RzZS?=
 =?utf-8?B?SGVWRDB6NWoxNHZlM3RMQVVSSExjdFhPOVdRMXZIbG5RbG9JcUpWZmJEVjdt?=
 =?utf-8?B?STRZVWFIMSs0ZVY2eXJoNWJXcnRVU2d4dk96a3BxVmpmbVZLbU1VZk4vOFNy?=
 =?utf-8?B?NEZLRFhEaTNGa1d2UkhVQXI0ZmVNMWR0cUJwZjcxQnJWYXpRU0JGMDVsVHRD?=
 =?utf-8?B?WlFOZDNIU3pLb3FwTzl4WjVrMm5mN0l2aTVwUlZRNWlwZFBreXZrS2Vvc2lW?=
 =?utf-8?B?bEloOVpRd0h3eFRpMnJjQ0tobWhQUXdEOWhpVStRQXdtV0xKbFZ6Q1pkZkpr?=
 =?utf-8?B?dVRIQnh1Z3kzZEdlb01ScnBxeTdQNXFmWUQ1aWtaZjArQmNkMnFEa2h4b1hC?=
 =?utf-8?B?N05US3d4OTlNQ0haaVpCTzBFalowR2pObGw2bW8rTG92aml2TVU4TGhVM0h1?=
 =?utf-8?B?dDdBYU9yWCtlQ0c4T3pDWmVQWVkvZWxmb1J5RC9rbzlSekNRb2FyS0RLZCtR?=
 =?utf-8?B?WTV2YnlSYjlxWnY2RTljV1F5d0Z2RzJ3dFQ3UjY2ZWMrR1BLUW5LOFI3Wlhk?=
 =?utf-8?B?YXUrbm9NaXcrSlpmYk9pMEQvRm1iNmJ3NFYyS1ovUm1QSE16bGlCdE9tQTBQ?=
 =?utf-8?B?MVRCOGx2SWdHOGlWYnNRZ0Rxa1Rlb3dXbjV1QWNBejFHVmJQMjZzMnovNXA5?=
 =?utf-8?B?c1NtSHhIZ3pwK2VXZjFPZ0t4Rms0ZUV4WjAwZ1Fubk95MGxqSGZZY1poZVZL?=
 =?utf-8?B?cWYrSUVHN1BOZjg0eDdRWkt4ZWZWQVRQT3JheWxXTWNkNEpmR3hYNHZLelVY?=
 =?utf-8?B?Vld2MlN5ZlRQaHBudW5tK1AvcEdEeUlWK3RmUVZTQU5HN3ZiU0pabXVadmJn?=
 =?utf-8?B?ZnUzeEF3M2cvdWQzbVROQ3EwT3QyK0xETnMyZTlQSGlEU0JPSzR1d3VVUTN1?=
 =?utf-8?B?K2VRTVBicDJ1S0taSUdsTjduQTh0SldQbjlXS21oT0tuK2swTXpyTFYzZXlt?=
 =?utf-8?B?MzFmVU91RzRtbG1GcFM5OVhja21QaGtjY3JRUXpkY1M3dVowMklid2QrTFNz?=
 =?utf-8?B?aWRsTmpoa3pFNlRZbzViQTRYQUVwVHdhTW8velIvZHIzN1lNd3JlQUdOUXVi?=
 =?utf-8?B?TWRPaENLYUh4VWFpb08weFhJamtpaVFlNkJ2cDllaHhMQm81cG82ejdMVExi?=
 =?utf-8?B?a2xVbGE5UU52SkNLajZHS0ZyUncwZSt3b0ZLMC8rY2plZDFFTyt1SllDMU1m?=
 =?utf-8?B?eFZ1eHJVS3h6bDJKVkhZUncvM044YllrTjhUeFU0QWVBdTE0eVhXUDIyZk9y?=
 =?utf-8?B?clZndnhkaTNDcjZ4OGdKeTVNL0w0dTBRSmhzMmNXenRIdFVPQXdMSXVlcm0z?=
 =?utf-8?B?WUVkUHR2OEN4YW9PakFqdVNsYnlqYkllQlpGU2xBajR6eFVLb3pEUUl1c2RC?=
 =?utf-8?B?QklPVDgrc2RRY0ZSZlNGY1Z4d1ZPcWEwU1ZVUlFWVXFlOFBpUmJ0bW1LQ2Z6?=
 =?utf-8?Q?Nnnm21kxh4IwFoEAQGwgvDbSo?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 744960d3-62e8-4402-20de-08dc87014ab0
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR12MB5673.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jun 2024 14:51:19.8987 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2NOY+2UWY0bqxE3QakjuC5sEuUcREbARbRUoX8ogCeDE3j/Dx3iK+BCN+TAEzpKi
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6253
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

Am 07.06.24 um 16:43 schrieb Joshi, Mukul:
> [AMD Official Use Only - AMD Internal Distribution Only]
>
>> -----Original Message-----
>> From: Koenig, Christian <Christian.Koenig@amd.com>
>> Sent: Friday, June 7, 2024 3:26 AM
>> To: Joshi, Mukul <Mukul.Joshi@amd.com>; amd-gfx@lists.freedesktop.org
>> Cc: Kuehling, Felix <Felix.Kuehling@amd.com>; Bhardwaj, Rajneesh
>> <Rajneesh.Bhardwaj@amd.com>; Yang, Philip <Philip.Yang@amd.com>
>> Subject: Re: [PATCH] drm/ttm: Add cgroup memory accounting for GTT
>> memory
>>
>> Am 06.06.24 um 21:22 schrieb Mukul Joshi:
>>> Make sure we do not overflow the memory limits set for a cgroup when
>>> doing GTT memory allocations.
>> NAK, That's intentionally not done like that.
>>
>> Please see the cgroup discussion on memory management on the public
>> mailing list.
>>
> Can you please point us to that discussion?

IIRC search the mailing list for mails prefixed with "drm/cgroup:".

At some point I stopped looking into this mail thread, but the idea of 
using __GFP_ACCOUNT was abandoned rather early in the thread.

For adding it in the TTM pool the whole idea falls apart when you 
consider that the process calling this is usually not the process 
actually using the memory.

For example when a process causes VRAM pressure it allocates memory to 
swap out the BOs from other processes to system memory.

Regards,
Christian.

>
> Thanks,
> Mukul
>
>> Regards,
>> Christian.
>>
>>> Suggested-by: Philip Yang <philip.yang@amd.com>
>>> Signed-off-by: Mukul Joshi <mukul.joshi@amd.com>
>>> ---
>>>    drivers/gpu/drm/ttm/ttm_pool.c | 2 +-
>>>    1 file changed, 1 insertion(+), 1 deletion(-)
>>>
>>> diff --git a/drivers/gpu/drm/ttm/ttm_pool.c
>>> b/drivers/gpu/drm/ttm/ttm_pool.c index 6e1fd6985ffc..59e1accdef08
>>> 100644
>>> --- a/drivers/gpu/drm/ttm/ttm_pool.c
>>> +++ b/drivers/gpu/drm/ttm/ttm_pool.c
>>> @@ -91,7 +91,7 @@ static struct page *ttm_pool_alloc_page(struct
>> ttm_pool *pool, gfp_t gfp_flags,
>>>       */
>>>      if (order)
>>>              gfp_flags |= __GFP_NOMEMALLOC | __GFP_NORETRY |
>> __GFP_NOWARN |
>>> -                   __GFP_KSWAPD_RECLAIM;
>>> +                   __GFP_KSWAPD_RECLAIM | __GFP_ACCOUNT;
>>>
>>>      if (!pool->use_dma_alloc) {
>>>              p = alloc_pages_node(pool->nid, gfp_flags, order);

