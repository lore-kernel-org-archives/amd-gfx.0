Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3466DD15DB7
	for <amd-gfx@archiver.kernel.org>; Wed,  3 Dec 2025 17:45:25 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C9DCA10E18C;
	Wed,  3 Dec 2025 17:45:24 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="T8oHdk9d";
	dkim-atps=neutral
Received: from BN1PR04CU002.outbound.protection.outlook.com
 (mail-eastus2azon11010053.outbound.protection.outlook.com [52.101.56.53])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B56E210E18C
 for <amd-gfx@lists.freedesktop.org>; Wed,  3 Dec 2025 17:45:23 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=L4dROR/weqez40pcdaHoCJKB7+rsafUvXlrWcvy9z3WiaidaG8kj0xL++9r4PFfjDyK1H4okYexJ2Sm5cyxzIX9phYxueRdnIgoWFo1lgMj1uzAXcUBL6ZZMHlxWJMgU62wpfSeohehLxFXo6cNXhzmnxOl/1ZVfWrgnDslLHSJbthVj+NUGj94k4/PurELYLmcbvBQKvLoBSkawR9inKnmk9p4OqAUriPFdlNG6woo6+QN+xumQV3qowxum2zg4XakDEqH3r99Ghr8oRWkmjQQPAPf7N2RYm8fHIrwWim5oBMwry9CJvXJ1M0dcqF44GFO/QfoUgx5c1hec1CBDpQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PmypdG1JkILeAGQ3r0NQgQjl3/ydTxe6e/ywA+yvNcw=;
 b=FmvIhsDvuoCLEhQCmXuftpW8dXIfKzbt/qz+P4vNkGj8SoLKpXkIC34WGJC08Lb1Im5l7ttQvnN/f3n1HroxkJ6xrN0+tx44sMXHYkyiZKLxqCKkyMjSp22u/9EZFIh1qeDgM16U3m+9F3MqqEZyqvnTdBnJrTbn/wrfbQSHhoIewrnd1wQGLrGZB6N9+hcBRPsHMngFiXcYLNQaWeywLxKClqsapzEB0PIC7g8gV7RnLpbtQvAPrr1U6oHGp37AV7qR1WeJBXj+i+PTCtHQF3b4kaN1iX2trs2JDHx5PO9SjHtXiA5a6SBjsWR5HlEpPm3O/b+saiuOT5X1WIl4YQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PmypdG1JkILeAGQ3r0NQgQjl3/ydTxe6e/ywA+yvNcw=;
 b=T8oHdk9dm/m1Vl0z6SCjru5SRwVVo+4UvYr56rGtTN8ETwTPatO4xMnr7R2P4qoxmKPe2wFaluljKE2xFcgYVGmHDAOxi8VW1y3qNTkMmRfEoQDQ7/xbum888dLqi6QOv/8JZxcjWbfxzlek36ek8UGVY/1MgqgPNn0FaFZxtYU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN9PR12MB5115.namprd12.prod.outlook.com (2603:10b6:408:118::14)
 by SJ0PR12MB6807.namprd12.prod.outlook.com (2603:10b6:a03:479::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9366.17; Wed, 3 Dec
 2025 17:45:20 +0000
Received: from BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::9269:317f:e85:cf81]) by BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::9269:317f:e85:cf81%6]) with mapi id 15.20.9388.003; Wed, 3 Dec 2025
 17:45:20 +0000
Message-ID: <fd6eb40c-cf75-430e-ac44-db6244d48762@amd.com>
Date: Wed, 3 Dec 2025 12:45:18 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/4] drm/amdkfd: Add domain parameter to alloc kernel BO
To: Philip Yang <yangp@amd.com>, "Russell, Kent" <Kent.Russell@amd.com>,
 "Yang, Philip" <Philip.Yang@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Cc: "Koenig, Christian" <Christian.Koenig@amd.com>,
 "Yat Sin, David" <David.YatSin@amd.com>
References: <20251201142838.1516452-1-Philip.Yang@amd.com>
 <20251201142838.1516452-3-Philip.Yang@amd.com>
 <BL1PR12MB58984080C0F17CDA486C8B8085DBA@BL1PR12MB5898.namprd12.prod.outlook.com>
 <1256b740-65b5-48ad-ad65-4149d3b880e6@amd.com>
Content-Language: en-US
From: "Kuehling, Felix" <felix.kuehling@amd.com>
In-Reply-To: <1256b740-65b5-48ad-ad65-4149d3b880e6@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: YQBPR0101CA0288.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:6d::8) To BN9PR12MB5115.namprd12.prod.outlook.com
 (2603:10b6:408:118::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN9PR12MB5115:EE_|SJ0PR12MB6807:EE_
X-MS-Office365-Filtering-Correlation-Id: 10896c86-3976-488b-bae4-08de3293ba7b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?aGpsdHJKR0tFVnNZc0RBQ1I1NVBEK1ZXaFg1bktPTnBGVTNVZlg1bHFjUERO?=
 =?utf-8?B?SnNBb2x4bCtoZllodTM0ZmR3ZGpxNm5GMkVEZmlCS2sydVlpQmxEUTk4WG03?=
 =?utf-8?B?cHNHUCtmeUozSk9uMWRNTjEySkhWNlVTanhvbUU3QTJnL1hWbEZOZC91cURF?=
 =?utf-8?B?ZVlIUmFnSU5HUnlQMlZEOXVJY2psSGx1MzgrdzNoNXE4TEN0RVBFVFZIekt4?=
 =?utf-8?B?Wk1FcThHVzVNa2duWEZyU25IWGpqK0JoRERDaC9qdlQrWFg4WUtOWVVTNVJh?=
 =?utf-8?B?NDZlOXdxTjZOcDRlS01FWCtmRU9jSUMzMnpkODlwM3Y1WExJSXgvcWljNnoz?=
 =?utf-8?B?a0szRC8ycWpGTCtCb3pvcVJOcnhhNmFZeVh4T2Z2cUU3SXFEZHNaUWZoY2xT?=
 =?utf-8?B?ZFJ5Wjl0a0V0eHM1UkhpUDFmLzF0M3RqWXlXTTg4T2NZSCtyT3R5WklFYWYr?=
 =?utf-8?B?UXl5Ny9IL001bVJJTU1aM3ZMT3Y0RzJVNDRqRXRSZ0pCdkpRamlPTythcVBW?=
 =?utf-8?B?VVJDUHlDalFlSElNUVkzU3FTRmdRYTFEVFpBRnNVcW0vNTZZSnl1bkFnRFNS?=
 =?utf-8?B?VFhLckk2QXRVLzNuUnZRRDdxOGdDd2s5Tk1Zc2IxeTBpei9PWHRuaWVqakxP?=
 =?utf-8?B?WWhJK1N1SlRaYzhjU0JtdmhtNUY2Zk1PN3FINU0ybzljMnpaRG9sL2laT3FZ?=
 =?utf-8?B?ZUV3SDA2bzYvNkdsYUFXUFdRTVlxZHZjR21Xb0tSRVJaUE1MVkQwQ2JURTRQ?=
 =?utf-8?B?bFhuY1FLMGhtTkkzcTFmSFVuRTE0cDdISjI0ekQ1RXE1YlhzbktpVGc3TC84?=
 =?utf-8?B?OTFlTE85VTIzK1NpR0JFbEFqbUplTFFnVnhjUHNjWG1oT0xxbXVacndjTUI5?=
 =?utf-8?B?NkZtUURxc0JsaDAvM01jdHNyNGEwKzc4MFJpZzJWT1ZLa0xCdEdyWVZLbHVj?=
 =?utf-8?B?ejRuOEtLcldxMzZmVndwQ3h6b2puUVQ3bXVoTlFDVVducDE3NnBnR3hvUW9Z?=
 =?utf-8?B?cG4vTFlmTytuNFR0V09HdmRycm5KT1gyem5HQzA0dHZxK0VBYU9ZbWpaRGNU?=
 =?utf-8?B?Zlh6UmRJdnVyMDJBamZuQml3ZUhwUzR4cXhoaEZ6UWEzbW1PVExzcHBBQUNV?=
 =?utf-8?B?QXErOFV4cTZYZlkySDdHVWhwWllsTkFySlFqYkZoa09yelhWSFRncmp5OXdy?=
 =?utf-8?B?eWl1Wm1TRE9TcDhSNkpTcTY1b2ZYcyt0NmFYWHRrTnZ6V0p1WitFSXRZSWx3?=
 =?utf-8?B?dUgvUm9yRG91WmRqRXB2ajZQK1BsU3BIaDBWc2tJdFFxM2pTK1dJVjVQeG1t?=
 =?utf-8?B?Wm9GeE9FYlhYeU1tZXpEcEhyVU1SQWpNc3lQdlBsTng0eEtEVjV1Sm0wenJ0?=
 =?utf-8?B?Q1g5Ukw4Sk9RVWZtOUIzWG54K2RmMHhwUmc5OUNBeWJVKzZvTmlOMkZ1aE43?=
 =?utf-8?B?eVhmb2NkK3Vld1h6MmcxUjFPTEt2SEl6UzhUNERFdXVmWkptTHhXemoyTERh?=
 =?utf-8?B?eWlpalVyUmdxYXdONHZDc09XL25qQzdJVGJGdUlKVmpveVpJRFhXcGlBcEJ3?=
 =?utf-8?B?RGwvL1RwVEl6NllUVXRqYmFFVEVhOHpVa2l2cUxsZW1taXZjMTZ4dm0zeTNR?=
 =?utf-8?B?RmZDczd6dlU0UitmbXF4c0JKUHVBZ3E4RDlBZjBUMGFMbnlUcjdvbjBhL04x?=
 =?utf-8?B?TUFCNDRtUG8zTzQ2YjBSd0h6aEZrNWtiNFduZWJ5RmZwYityNjVnZWM4aTJa?=
 =?utf-8?B?QXYzYnNTRmxuUXdWdFJOZWNwejczSEduSGxBQnpHYmdWSHh6MmVSOUNEeVJM?=
 =?utf-8?B?M2l4UFlBeXR3TWZqdlpUUVkyRUdjYS81UjNhVE1WSXg5YnlxSTF5UFljdkJ2?=
 =?utf-8?B?bVNFUEZWclh2SEM3Y0hrT1laT1pNQmpvem5JR05lR0I0UkZzNUpXdWtSQjUz?=
 =?utf-8?Q?VM2ZJVkn92walZ36fHzxmu6Be7USuBSI?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5115.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(7053199007); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RUtRMVZCQ00rY0N2bFBpcXM2ZHlETGhib3QzWlBtZTVyb3JrVnFnVndRcFVR?=
 =?utf-8?B?bmFOQ0tuL0ZCNGp1cFRObDF5UHVNTzBBdkxrbmZWN2FPYXJjNW9RYmpvSnhn?=
 =?utf-8?B?YTZrMkk2ZGUwSXQ2L0hFMDF2a1E2eTRRWXlsZ3owT25CSWNnWDFuZElmb09z?=
 =?utf-8?B?ejBqNENiYXp4d09GVTQrQjZsTkkzTzNkc2RXL1RMNG0yR3lRZFJOZTQ4OWJC?=
 =?utf-8?B?ZnQzMHVDR09YSXVxYlA5TGRiY1o4Q3lKajQ0TnRDam40cGNrci9ZU2Y5WSs2?=
 =?utf-8?B?bEtOYVcwL3hIcjNvZjRKL3RVNzAvcitLbHJjc3B1SmVRV01wQzNuQXlzc1RH?=
 =?utf-8?B?dUhidk9kMlVTQkJnak9EVDZseXRwVDJKRG1aTnlxbHNjdWtsbDB0cVZXUHNJ?=
 =?utf-8?B?d0VUNDkrOFE4WWUwbDJrOVlMcVZHMVUzd1lCZ3Fod1VpL0NtcFdyYmJXNkJL?=
 =?utf-8?B?a2VKRGpXdyt6TUI5UE9LL1YrWWh5K25rRU5VK294RFZPdllLVnErdzYwTUov?=
 =?utf-8?B?TzZhV2E3K1RYdVRXRFFaZW1UM25MVVNSSDlVcE85NXYzZUJhMVNFSm96U0Vt?=
 =?utf-8?B?RFNueHZFcU5QSmFsR2JiSkw3dDNyZWxHbjVwUmt3cWlOQ3U3WkF2TW1XS1M1?=
 =?utf-8?B?T3VkN0Faald4MUZnRExQNzVONmQweCtCSWVOQWk1ek5ndzM5SUhJdzNSd09h?=
 =?utf-8?B?cHhzN3JNbUVtZ1g2WHZNT3J2RDlxK1RjdXVUR0VVWElLODhXRTVjZGp0bVkx?=
 =?utf-8?B?WWFYaFpsMU5seE1RSVFwMjJqK0JGby9Wd043ZXQyMEVpSGhaRFpWSzlWL3hO?=
 =?utf-8?B?NmN0WXNyLzZYallRa3JYU3NlQXd1akQxUWtPa3gycDRCTGN1OW8xR25DL3B2?=
 =?utf-8?B?ZFdZNlhUQmtRYTErNnZENCtxazdVTUE2WDRCclBDSTlpazdDZ0w1UUxwekY2?=
 =?utf-8?B?VlorMXU2Z21SSTVWbjlTUnFZN3ExMFdxYTV6R0h2NmdMcmxqZkRmTS9pclhI?=
 =?utf-8?B?cG9tZmR3WnlRVzU5K2xkWXhQY3hscGlkL1RNcnBwd0plNE9IMnEvKzNwNUp5?=
 =?utf-8?B?VWxuMFZlZnY3ZU0zeGRCdHB5Nlh1NXBQTldCRThlU3NRcnc5dzd6bVl4R2pB?=
 =?utf-8?B?Q1RDOXlvVGJRbEFNWXV6NkgyNnFOeEUrOTRaMk5RV3FLSlBweTVXdVd3RFUr?=
 =?utf-8?B?RXBqVVNnTXRPcGRWQXFJaFFITE4yYkc2cmhDL3k2RllCYzI1VkdUVnQvM1Fz?=
 =?utf-8?B?L0c3T21nT1plTVZ1WSt6NE5vVmNvckFycHpqa0NmeGJZUzRFYTVFUkt3MTNs?=
 =?utf-8?B?WUdwb3N0RUNjbmpLSEJ4SE5ITVUvTGNOalZCTDl4K0cyYVFnSzZjbDB3MFN2?=
 =?utf-8?B?VzBEeXVGVlRUcmR0U29YM1JVVlpSd09UYTBMaWpLWDBmYVJsYUJSSzVIdE5Q?=
 =?utf-8?B?dXJ0WnlJcVlvUUxoOEJXSGJyNE5NcjhIK0pyekRLU2ZDNktWckhxcDR6Zi81?=
 =?utf-8?B?cTh1eXkrRWJkeGM3c2s3K0JCTUxSTmphbWZ4WTZTaVphQlpNckdCZ3FBTEdE?=
 =?utf-8?B?dmRteHZyUW9MdTFUeFJ1SURGaUZ4dlJVRS9aeG45eHhJRFRoSWsxWExyVUEx?=
 =?utf-8?B?L0RJRjNjaWxQUzAvb0NDZVlnZjhNMkg2M2I0ZTVBVnF2anJUeTd5NDZsb2Nm?=
 =?utf-8?B?dWxnaXh1UmJrNFRsc1NFaDBialpJYndQUnhvU0x1YWg5c1B2YWl4ek5QYjBl?=
 =?utf-8?B?MUQycnAwOWU2K3U4WHJVVUc2ODFOUmZGTEhBYldXVEdGZTNnUDRvRjVnVVpH?=
 =?utf-8?B?V28wTit1dlRaUnlOTHNhTWNQR2pVSGd1WTZJeU1tNFN1c1p2clo1ZlZTY1Zo?=
 =?utf-8?B?WnBuV1BZcnhCZFBpUG4yVVlvMEZFRitZOHFLKy8vbFJYNklBQ3A5Rmk4ckF4?=
 =?utf-8?B?M2M3VVRNRHREUVVVQ1JqNEhNTDJtWTUzQWl0TFJMU1FrYzJGaTNDTmlFQ2JO?=
 =?utf-8?B?S3pESnVsSHpkMU15UmYvWU9rcE5vTDU2MHlGbDBCY0tvZDVzQWR0WHllalJB?=
 =?utf-8?B?M3RrV3E2K01GU0Q3OUxxZnJaMGxUa0V6cmpiVlJSbVFKUjRjWndleGpEYlRF?=
 =?utf-8?Q?/leuevPbWe7/jNdaW35UISuvG?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 10896c86-3976-488b-bae4-08de3293ba7b
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5115.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Dec 2025 17:45:20.4904 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pCin5tmrBQ94WL/8q3kX/RzXhlaqwrnAQmKi+DoZOPmGKaE5qyeQp5bQd7X5bBjUSWD1xLlMkIDt3gMgYx44lw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB6807
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


On 2025-12-01 15:31, Philip Yang wrote:
>
>
> On 2025-12-01 12:38, Russell, Kent wrote:
>> [Public]
>>
>> I know that it makes the change more complicated, but should we be 
>> renaming the function since we're no longer guaranteeing a GTT memory 
>> allocation in the alloc_gtt_mem function?
> yes, you are right, I have the patch to 
> s/alloc_gtt_mem/alloc_kernel_mem/g, s/free_gtt_mem/free_kernel_mem/g, 
> and found it is too much changes,

I see amdgpu_amdkfd_alloc_gtt_mem being called in 7 places in KFD. I 
don't think that's too much churn. You need to change all those places 
anyway to add a new parameter, so you might as well change the function 
name while you're there.

Regards,
   Felix


>  not related to the purpose of this patch series, so I dropped that 
> patch. We can cleanup this in the followup patch, probably remove the 
> alloc/free_gtt_mem functions and use amdgpu_bo_create_kernel instead.
>
> Regards,
> Philip
>>
>>   Kent
>>
>>> -----Original Message-----
>>> From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of 
>>> Philip Yang
>>> Sent: Monday, December 1, 2025 9:29 AM
>>> To: amd-gfx@lists.freedesktop.org
>>> Cc: Kuehling, Felix <Felix.Kuehling@amd.com>; Koenig, Christian
>>> <Christian.Koenig@amd.com>; Yat Sin, David <David.YatSin@amd.com>; 
>>> Yang,
>>> Philip <Philip.Yang@amd.com>
>>> Subject: [PATCH v2 2/4] drm/amdkfd: Add domain parameter to alloc 
>>> kernel BO
>>>
>>> To allocate kernel BO from VRAM domain for MQD in the following patch.
>>> No functional change because kernel BO allocate are all from GTT 
>>> domain so far.
>>>
>>> amdgpu_amdkfd_alloc_gtt_mem has many duplicate code as
>>> function amdgpu_bo_create_kernel, with one extra flag MQD_GFX9
>>> to bind MQD and control stack in GART with different mtype,
>>> the duplicate code could be removed in future.
>>>
>>> Signed-off-by: Philip Yang <Philip.Yang@amd.com>
>>> ---
>>>   drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c             | 6 +++---
>>>   drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h             | 2 +-
>>>   drivers/gpu/drm/amd/amdkfd/kfd_debug.c                 | 1 +
>>>   drivers/gpu/drm/amd/amdkfd/kfd_device.c                | 3 ++-
>>>   drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c  | 1 +
>>>   drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v9.c        | 1 +
>>>   drivers/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c | 2 ++
>>>   7 files changed, 11 insertions(+), 5 deletions(-)
>>>
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
>>> index a2879d2b7c8e..9cd1660b8f60 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
>>> @@ -317,7 +317,7 @@ void amdgpu_amdkfd_gpu_reset(struct amdgpu_device
>>> *adev)
>>>   }
>>>
>>>   int amdgpu_amdkfd_alloc_gtt_mem(struct amdgpu_device *adev, size_t 
>>> size,
>>> -                             void **mem_obj, uint64_t *gpu_addr,
>>> +                             u32 domain, void **mem_obj, uint64_t 
>>> *gpu_addr,
>>>                                void **cpu_ptr, bool cp_mqd_gfx9)
>>>   {
>>>        struct amdgpu_bo *bo = NULL;
>>> @@ -328,7 +328,7 @@ int amdgpu_amdkfd_alloc_gtt_mem(struct 
>>> amdgpu_device
>>> *adev, size_t size,
>>>        memset(&bp, 0, sizeof(bp));
>>>        bp.size = size;
>>>        bp.byte_align = PAGE_SIZE;
>>> -     bp.domain = AMDGPU_GEM_DOMAIN_GTT;
>>> +     bp.domain = domain;
>>>        bp.flags = AMDGPU_GEM_CREATE_CPU_GTT_USWC;
>>>        bp.type = ttm_bo_type_kernel;
>>>        bp.resv = NULL;
>>> @@ -351,7 +351,7 @@ int amdgpu_amdkfd_alloc_gtt_mem(struct 
>>> amdgpu_device
>>> *adev, size_t size,
>>>                goto allocate_mem_reserve_bo_failed;
>>>        }
>>>
>>> -     r = amdgpu_bo_pin(bo, AMDGPU_GEM_DOMAIN_GTT);
>>> +     r = amdgpu_bo_pin(bo, domain);
>>>        if (r) {
>>>                dev_err(adev->dev, "(%d) failed to pin bo for 
>>> amdkfd\n", r);
>>>                goto allocate_mem_pin_bo_failed;
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
>>> index 335d733751cb..14b5ab6fa051 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
>>> @@ -237,7 +237,7 @@ int amdgpu_amdkfd_bo_validate_and_fence(struct
>>> amdgpu_bo *bo,
>>>   #endif
>>>   /* Shared API */
>>>   int amdgpu_amdkfd_alloc_gtt_mem(struct amdgpu_device *adev, size_t 
>>> size,
>>> -                             void **mem_obj, uint64_t *gpu_addr,
>>> +                             u32 domain, void **mem_obj, uint64_t 
>>> *gpu_addr,
>>>                                void **cpu_ptr, bool mqd_gfx9);
>>>   void amdgpu_amdkfd_free_gtt_mem(struct amdgpu_device *adev, void 
>>> **mem_obj);
>>>   int amdgpu_amdkfd_alloc_gws(struct amdgpu_device *adev, size_t size,
>>> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_debug.c
>>> b/drivers/gpu/drm/amd/amdkfd/kfd_debug.c
>>> index ba9a09b6589a..494a563e072e 100644
>>> --- a/drivers/gpu/drm/amd/amdkfd/kfd_debug.c
>>> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_debug.c
>>> @@ -359,6 +359,7 @@ int kfd_dbg_set_mes_debug_mode(struct
>>> kfd_process_device *pdd, bool sq_trap_en)
>>>        if (!pdd->proc_ctx_cpu_ptr) {
>>>                r = amdgpu_amdkfd_alloc_gtt_mem(adev,
>>>                        AMDGPU_MES_PROC_CTX_SIZE,
>>> +                     AMDGPU_GEM_DOMAIN_GTT,
>>>                        &pdd->proc_ctx_bo,
>>>                        &pdd->proc_ctx_gpu_addr,
>>>                        &pdd->proc_ctx_cpu_ptr,
>>> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device.c
>>> b/drivers/gpu/drm/amd/amdkfd/kfd_device.c
>>> index 9f183d27a0ef..b0cfad750919 100644
>>> --- a/drivers/gpu/drm/amd/amdkfd/kfd_device.c
>>> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_device.c
>>> @@ -787,7 +787,8 @@ bool kgd2kfd_device_init(struct kfd_dev *kfd,
>>>        size += 512 * 1024;
>>>
>>>        if (amdgpu_amdkfd_alloc_gtt_mem(
>>> -                     kfd->adev, size, &kfd->gtt_mem,
>>> +                     kfd->adev, size, AMDGPU_GEM_DOMAIN_GTT,
>>> +                     &kfd->gtt_mem,
>>>                        &kfd->gtt_start_gpu_addr, 
>>> &kfd->gtt_start_cpu_ptr,
>>>                        false)) {
>>>                dev_err(kfd_device, "Could not allocate %d bytes\n", 
>>> size);
>>> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
>>> b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
>>> index 36ac35d64126..028fca1d2755 100644
>>> --- a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
>>> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
>>> @@ -2906,6 +2906,7 @@ static int allocate_hiq_sdma_mqd(struct
>>> device_queue_manager *dqm)
>>>                NUM_XCC(dqm->dev->xcc_mask));
>>>
>>>        retval = amdgpu_amdkfd_alloc_gtt_mem(dev->adev, size,
>>> +             AMDGPU_GEM_DOMAIN_GTT,
>>>                &(mem_obj->gtt_mem), &(mem_obj->gpu_addr),
>>>                (void *)&(mem_obj->cpu_ptr), false);
>>>
>>> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v9.c
>>> b/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v9.c
>>> index 2e9b6bcf2704..a489d43d5f64 100644
>>> --- a/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v9.c
>>> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v9.c
>>> @@ -139,6 +139,7 @@ static struct kfd_mem_obj *allocate_mqd(struct 
>>> kfd_node
>>> *node,
>>>                        (ALIGN(q->ctl_stack_size, PAGE_SIZE) +
>>>                        ALIGN(sizeof(struct v9_mqd), PAGE_SIZE)) *
>>>                        NUM_XCC(node->xcc_mask),
>>> +                     AMDGPU_GEM_DOMAIN_GTT,
>>>                        &(mqd_mem_obj->gtt_mem),
>>>                        &(mqd_mem_obj->gpu_addr),
>>>                        (void *)&(mqd_mem_obj->cpu_ptr), true);
>>> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c
>>> b/drivers/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c
>>> index 5f8cda4733f9..e0c5ec7e2fe9 100644
>>> --- a/drivers/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c
>>> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c
>>> @@ -266,6 +266,7 @@ static int init_user_queue(struct 
>>> process_queue_manager
>>> *pqm,
>>>        if (dev->kfd->shared_resources.enable_mes) {
>>>                retval = amdgpu_amdkfd_alloc_gtt_mem(dev->adev,
>>> AMDGPU_MES_GANG_CTX_SIZE,
>>> + AMDGPU_GEM_DOMAIN_GTT,
>>> &(*q)->gang_ctx_bo,
>>> &(*q)->gang_ctx_gpu_addr,
>>> &(*q)->gang_ctx_cpu_ptr,
>>> @@ -369,6 +370,7 @@ int pqm_create_queue(struct process_queue_manager
>>> *pqm,
>>>        if (!pdd->proc_ctx_cpu_ptr && 
>>> dev->kfd->shared_resources.enable_mes) {
>>>                retval = amdgpu_amdkfd_alloc_gtt_mem(dev->adev,
>>> AMDGPU_MES_PROC_CTX_SIZE,
>>> + AMDGPU_GEM_DOMAIN_GTT,
>>> &pdd->proc_ctx_bo,
>>> &pdd->proc_ctx_gpu_addr,
>>> &pdd->proc_ctx_cpu_ptr,
>>> -- 
>>> 2.50.1
>
