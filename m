Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 68517CA0EEB
	for <amd-gfx@archiver.kernel.org>; Thu, 21 Aug 2025 20:12:18 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E999A10EA25;
	Thu, 21 Aug 2025 20:12:17 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="eYbtDxPS";
	dkim-atps=neutral
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2042.outbound.protection.outlook.com [40.107.243.42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C90E810EA25
 for <amd-gfx@lists.freedesktop.org>; Thu, 21 Aug 2025 20:12:16 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NDkMmybOAHDZhETZGsqFcopsCIzerocw7zRhE70TwxJga/0W0uxXIyQEKo0Jyja6LUtsh1efFM1Smc4i/3ctwHm+cdl81XnUzXKcM2l+jNWNVTQUl9fPoBIhH15XHpnU4W8EqWdPyaKw/Rnxef4HGCSjPR5WU9XkwIfBUwvmLMOwxSlWCqgGdM8bwvjPUWUFtxTai3whs/9x1fEZN4YWHX8wB905GQwTO7sFuCcIBGsvGBiKXCrBvhFLLVbwoaHwDuUh7htRDV19W6iJqvGoSqZCb+2TQTYiqhhhAjAkmx2ChMsrvsxjtIRiSt1p2wYqJQr7y8sGQK9iPfMghamVVw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7GRzbxqrO9IkkkwPgK63cK0PfSoRtWiwbkUM3y3bMCY=;
 b=WMFqw0gUpuXBRJf+k19lHFZdw51YiNCukffNOJSTzknBrv8BNr70ImNRXXfscQX6dDm3VKtsAoqbnz0n+LX7sCl9wdc1hC9Hm++XXukVTEHDEjtq0dj9i7rLKw0fXaRdR3CaOu79W3SNhXqGTynA9vZCpWFWeKSaLXtEUyUPVqvhmMKGjwbiFHqh6W1IG/Bwr5ZvwJr7TC6PBkiniTWGpX2BDsHYub8j6+8nXaoOBLv4tyTTIn3MZUNmbGP67AAXaHDWjUjjmmZVSP/0noeVZOzr6rWscZGpkvu15QY6uFUu0s10WhqpRkkxrnZ5cJDeACbNMw0hbUZNu8SJ258wgw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7GRzbxqrO9IkkkwPgK63cK0PfSoRtWiwbkUM3y3bMCY=;
 b=eYbtDxPS979dFWNtFDjFjWzXq+UKNjs7Fa1yU4cyyJUBCtZD+b+aQMZp/9KllVOQA17WnPDcfStGaNYD0ROeWQKj7KuganjdWMGGV8N2j4D2xig53t3zNCNKv1t+t7L8cMb0Qx9EVEgC1SO+R2pKo/RxiU8kjU6iahWt6dOkQS8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB7210.namprd12.prod.outlook.com (2603:10b6:510:205::17)
 by SJ2PR12MB8884.namprd12.prod.outlook.com (2603:10b6:a03:547::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9031.24; Thu, 21 Aug
 2025 20:12:11 +0000
Received: from PH7PR12MB7210.namprd12.prod.outlook.com
 ([fe80::54c:74b2:5935:6041]) by PH7PR12MB7210.namprd12.prod.outlook.com
 ([fe80::54c:74b2:5935:6041%3]) with mapi id 15.20.9031.023; Thu, 21 Aug 2025
 20:12:10 +0000
Content-Type: multipart/alternative;
 boundary="------------WnzBecR9BjO0PXRd7zXW0RX1"
Message-ID: <79985309-4649-4373-b199-0bda5015e8fd@amd.com>
Date: Thu, 21 Aug 2025 16:12:08 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amdgpu/vcn: drop extra cancel_delayed_work_sync()
To: Alex Deucher <alexdeucher@gmail.com>, "Wu, David" <David.Wu3@amd.com>
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
References: <20250813193658.2444953-1-alexander.deucher@amd.com>
 <CADnq5_PqnUUxF7Suj0fg4Q6F6ELa8ugT78gFWHd5Djg1GGB8hg@mail.gmail.com>
 <45a4074e-860a-4c82-8fa2-6423286a2268@amd.com>
 <CADnq5_Mhdg6-7xOkofj0NT8MiFyv-EKcmZLObSApLjWX7Z-zrg@mail.gmail.com>
Content-Language: en-US
From: David Wu <davidwu2@amd.com>
In-Reply-To: <CADnq5_Mhdg6-7xOkofj0NT8MiFyv-EKcmZLObSApLjWX7Z-zrg@mail.gmail.com>
X-ClientProxiedBy: YT1P288CA0022.CANP288.PROD.OUTLOOK.COM (2603:10b6:b01::35)
 To PH7PR12MB7210.namprd12.prod.outlook.com
 (2603:10b6:510:205::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB7210:EE_|SJ2PR12MB8884:EE_
X-MS-Office365-Filtering-Correlation-Id: 605e6b33-b018-4138-d466-08dde0ef028a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016|8096899003;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?QWpRWGY4UU9jRVdzR1M0QXBMT2wyWFhrOVl6TWNrK1I5K3RCaDJkcFN5QXgy?=
 =?utf-8?B?eHZ0MEEwakd5UXA1VlhxVHBOSG9OdmVkcDZ3U2UvYnpLcG8rbFJLZ1VHT2pK?=
 =?utf-8?B?VDczbTdDQWhkaDdsMW9XbzRIaUxSNXRQVXZNbnN1b0pDb3NZVklrZkVqU3FO?=
 =?utf-8?B?QjdJVStzM0ZvN0lBWkEwQVpCcC9YWkpLc3RsMkhGS0JPcDJFOHQxek1obFVt?=
 =?utf-8?B?cXUwOXNGYlhtbWl0WC9iMGtKeWdIaW5MT3FVMlU4eUZKRVF1YS9wMkdwVDVI?=
 =?utf-8?B?OXRSYkZEZnU3bGI2ZW4xZnY1MVNzN2Q3dUlLSW5ZUGNQNTNJTmNKYzhXbW9W?=
 =?utf-8?B?dzJ1TmtpYisza2M3ZjVadnhiUkYzLzRPWVVBb1JQbDFIMlZRa2VOeHpDcFV6?=
 =?utf-8?B?aVE3Y3lRVWw1NWZZL3FYUnVsbCtrdWRCdlF0eVNrcjRQOWtvakhKcGROaTBz?=
 =?utf-8?B?KzAxZG44Q2g5T1FETCs0ck5QV0RFZktSa1gyRW11bmpPT0dodk4rdGIrS0xq?=
 =?utf-8?B?blR5eDRRSGllLzNvSHJRTXZySWNZbGV2TUtWMmhEWis3dEE5eVFpSyt0ckRO?=
 =?utf-8?B?WGVHU2x4UlhDNUZFRThHSThZWG02UEN2M1dzSXpESzA3cWYzclRmNUFkTHIx?=
 =?utf-8?B?ZzRGTDAwRmcweU1acUVDL09MeWpLb2dWY0ZSYzdNRTZPQVdqOFN1N04rUkUr?=
 =?utf-8?B?Znd1MnBlWE9nK1h3M210Nlp0V1VoOFpwTkJlTUlUSGV0dmtYZkRBbkRoTDNw?=
 =?utf-8?B?Tm5BNGM0TElMS1hqWmhNcjV2alN6OGFabnNDMm1BcDBQUjdXLzJQZkxyZGlE?=
 =?utf-8?B?aUo3N0RLcTNIVnYyL085aUlvWWxwWXF4R2Zhamd0UGM3b0dtckQ5VytZQ0lT?=
 =?utf-8?B?VlpCVFB6eWJwSURPMUg5eUxqUFFvcExQQjdMWlVOUC9xV1pVRVAzN0VEc3Jn?=
 =?utf-8?B?ZGNBSll1TW5kV3FSTElYdjJMMXZGQk5JcjIwNGdzcUxSd0g1TzRPY0E0bUFn?=
 =?utf-8?B?emd5RzQ3MDhGNy9PTUxsWElWZk9paVZJOGRsalV3SVk5cU1PMk5iYTdoOFhS?=
 =?utf-8?B?SnBKMERpSGEyaGl6QytqNUlZbE1NS1dVN0Q5Vzc2ZGR2dmNtbVFzY0JFN2Vs?=
 =?utf-8?B?SVdDUmJmNlNvcHdTSkV0SnZVVmdqMlNOZ0w5dTQrQU8yeU1UOGdWcGtZMlVp?=
 =?utf-8?B?RUFDRGJwbkZoUnB3YnJmcmtudzJYVmE0b1JIWGYwVW9PWklMMndIb3RRK044?=
 =?utf-8?B?bjZqeW1jZGh3ZmJzZnM1eGVSNEtWbExCRVc0dENhSGhyclY0ajVzL1NacU5B?=
 =?utf-8?B?TEVXTTllVXRhd1gxUDdUK3Yyam1nSFZ0cit6ZnVJRmRzZi9XSlV3K0tBSUxi?=
 =?utf-8?B?UFgvZ3JxSmYxU3Z1bzBhUFB1OFVKblFNaXR3K2FpUVJrRUQ5UWgxbFd2V1J5?=
 =?utf-8?B?ZjB6M1Y4Vld3a2tlUTRXME1kUlcxTUh3VDZnbFNMV1VFdkQ1aTdtMnk4YW1C?=
 =?utf-8?B?QTBCYnJDWUpta0dJbUduWmZoRWNjazlFbUl0SEVMd0NLUFRsK1cvNW9MWkxs?=
 =?utf-8?B?WFVnOG1zbTBVc1lCZ1E5dTlGeXhxendnRG9wSWpFaTRSK2x5WmFEcGpkMkVT?=
 =?utf-8?B?V09mbHIyMW9QY2txUUwwMlRFazM1NXpLMytDL01ycWhmanE0RitFa2dBSmJh?=
 =?utf-8?B?NWtiOTZYa2ZTRzJvdVd1UGpnT0NOMmp5RGpSemJqdE5JN0JsendHTU83bi9H?=
 =?utf-8?B?a1NoT3p2SVdQc3BNUW84Snh4THVFY3UwbDU0YUFwNmpiRDRHOXVyRUlOaHpV?=
 =?utf-8?B?akFVTTBYL1Q0MGQ4Mk9jUWtrdGhORzR0YmVJTTdHZ1pHWERTSjdjV0s0SGhR?=
 =?utf-8?B?N2ZyUlQ5UXJsdjVZdGQ0ZGFhamZhSFVxSWhlMUV0elRBbkJjN0trZnlpejV1?=
 =?utf-8?Q?U46UWQPn5Jw=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB7210.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(8096899003); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MXhCVmxYOVdLMVRndzRLTzdhV2dJQS90dnd3YkxFclZoMWNhaE8vYVBvQUh0?=
 =?utf-8?B?SEoxbW9PL2RFUTBXQ0xFR0J2Q0NnSXBpWHBldVJndkVxdkVZNzBFWVZlV3hC?=
 =?utf-8?B?NE5KV01LSnN0cmd2UEtLUkVvSmg1ZWlBbFM5Sjg5TEUxQ0hxU1NtZFE0WnhL?=
 =?utf-8?B?U0sxSFoyQkVQVk1semNhMGlSYk0xRTdsZFZZNnN1dHlCd2h5OUZuaXJLVXJR?=
 =?utf-8?B?Z3VLbG5COXBkcy9WdGs0YlM4RmpudkZ4S0N0Y2tsWjE2TjJXcVRnS0c0Z0s2?=
 =?utf-8?B?dFllMjhqVG5mYmdCdjNaMnBka0Nnbk02MlUxNkgwYm00a0RwWjZqMXdXMzYy?=
 =?utf-8?B?SnhuZlpTS2V2UVpxV2JvOFFQMlFKOHV6VGlVdTA0Z0tRU0NSalVSQW1td0x6?=
 =?utf-8?B?VGZLaDI4aE1UZkxPblRMd3I4YlNIREtzeFR4TTNaZkQyTS9XckdZUDNEcUhR?=
 =?utf-8?B?ZnBITmhIRjZSZlRWN01ubEt2YXJ0cXF1dlZaaFpyYmk5SnBCN1JhWHVHMU44?=
 =?utf-8?B?UlJWamJ4ZGRsK0RyTys3WGtFaStZNmJWSzUzTzlnbnZBbEcvZ1pTTEl3NDlL?=
 =?utf-8?B?ZWQ4TGNHSW1pbmJHVHIvSmZrUFF0Q1ZuMS9xbVBSZldGTmcxaE5rbXZLK0lL?=
 =?utf-8?B?Z0sxbWtDUGx3emxIOUsvZmlwUlhCb2JQblRncTVRdXBoMm1ZdXBJV25MVHF1?=
 =?utf-8?B?NjhreEd0THAwYXRRcjJFZzBhSGk4eDJrVTU4WEtwSmYxMnZ4WWJjNjA1Y0VW?=
 =?utf-8?B?V0NrbUtod3RaYmU2bU0yNW44RW9YZzFMWG40M050cXJaY0xuSUtuT05qbHNv?=
 =?utf-8?B?T0h3SUdJdStNeldpUlovVkhHOUJUM3F0aGFESFhic1BRckxXQ0c3OEFiOXZX?=
 =?utf-8?B?U0Y1OWtkS0xIKzB4dENCNS9BNUFpOUdQcGcwTVJBRVBDNnN3dlA2Wkk5c3Ez?=
 =?utf-8?B?QWw5RW1pRWQzT3lGdzAxMmxyQXVYT0krcUs4NDRnV1NmSHZRT3JBSWxPL0pV?=
 =?utf-8?B?NU5XdWRxQ01HNU5xVVpwMXV1WXVQWk1mUGpNdHkyaCt0SitoR2xMQnYxUC9F?=
 =?utf-8?B?anlTMUxMTk11eVhYRWZpRkZzTVpUUXJPNFAxdlF3VEd3ZE8vOFVTaUExUzNH?=
 =?utf-8?B?ZUxrb2NlUjdlK09MZWQybFRreVY3WlA2VDZ0L1daMmZ5Y1hTemtzWU03WXpK?=
 =?utf-8?B?OXF0a1F0UkJ3emJEZVB6UWNiN0tMaVRuNklaOG1udVN6dWRKSDYyU1czcGxT?=
 =?utf-8?B?WStuZ2F1N0N6TEYrY1Q2ekJCSlh1clRjcG5ibGlBNDR3b1k3S0VnVUNRdVVS?=
 =?utf-8?B?ZkhYRWVkMkxwOTk0QWpQZHdMMGczVG45YTJ6M2QreFB5UEFvUWtGODJ2Z1ZY?=
 =?utf-8?B?aCtMY25vMU9JR1c3SU15VzNPQVRCaHlJaE50ZXprZnRkU2tRTTVlM0tIZVNv?=
 =?utf-8?B?YTUvb2lLSmNZNVhIekMzTDdlcTF0VnQ1T0ZuMmRLNG5zOXlvdTBCcWpRSWlX?=
 =?utf-8?B?RHA5eUc1UXk2UWFkQW9GSWFDY29lV010Tjh2VmwxS2NSS3Q3STg4UThJVUpN?=
 =?utf-8?B?NFZzeFptMFJGY1IxZ1ZPZm5FV0hEVzZVZ0xCOHZ6ZEppSHY1MHlObHU4VktQ?=
 =?utf-8?B?VXdIVFdqa0liTFp1REtucTkwL3UydXNKVDZLYmhVWkY0YThOUUJmMXlyZlJv?=
 =?utf-8?B?d0ZCa21kR2VwU1p5akRGUkdYRjdHRTRkZ0k0MUw0aElFVzdIeGRPRFVzSmtl?=
 =?utf-8?B?STVQdk9HLzU4eFpHWkV3NjFwTFBKRE1OdjBQWkcvQmUxcjI5ZHd3QVdQc25Z?=
 =?utf-8?B?TFJaVUxsaVB1ZlZzM2lhckFvM0t6eWdsdER6LzVmcStQTkVGTGVacWNLODQ4?=
 =?utf-8?B?dFMwcXVoY2dEYmJpbDh5NFRLd21yN045RzE5U3dOWUVRZW56bmttcGhzWXo4?=
 =?utf-8?B?OVo3SHFnZG1YRlhhQ0tSTFZVTXZKaVNQbXZodkJBYmtRRk5lWmJMeE9EVkFM?=
 =?utf-8?B?K1JXOXh0YU9RQ1E4QTBrbE5IMFY3Sng1cnczUFk0SkM1NTRma09TYWhDYVFC?=
 =?utf-8?B?T2o3R0d3enk4Vzk5MGg1c1NlNjdMcnJkQk1NV1RGRW14ZlJFeFZCc2U0aytr?=
 =?utf-8?Q?GyNDShbvpiOPG0nFPPGnuFhQZ?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 605e6b33-b018-4138-d466-08dde0ef028a
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB7210.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Aug 2025 20:12:10.2606 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PV8gkNwIsj6+x5lDwAuQCVC1LDhwinaUEC4phytL4nsn0v95vOmpiZIeJzvJU9cTP+fm/xIDVVjG/IccEhnX/A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8884
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

--------------WnzBecR9BjO0PXRd7zXW0RX1
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Did some tests with the sw callbacks which were called with rmmod.
It will fail if there are jobs, otherwise no need to cancel delayed work as
there is not any outstanding work and idle handler called or not did not affect
the removal of the module. insmod continues to work after that.
The case for hw_fini works as expected.
Tested-by: David (Ming Qiang) Wu<David.Wu3@amd.com>

Thanks,

David

On 2025-08-20 15:43, Alex Deucher wrote:
> On Wed, Aug 20, 2025 at 3:29 PM Wu, David<David.Wu3@amd.com> wrote:
>> [AMD Official Use Only - AMD Internal Distribution Only]
>>
>>
>> one thing I noticed:
>>     amdgpu_vcn_suspend() also gets called in vcn_v2_5_sw_fini() for example
>>     where there isn't cancel_delayed_work_sync() call. Does the removal work in this case?
> The sw callbacks are not supposed to touch any hardware, so that's
> wrong to begin with.  That said, this should never end up doing
> anything because we've already cancelled the delayed worker in hw_fini
> and after hw_fini the hw is stopped so no work should be outstanding.
>
> Alex
>
>> David
>> On 8/20/2025 2:36 PM, Alex Deucher wrote:
>>
>> Ping?
>>
>> On Wed, Aug 13, 2025 at 3:37 PM Alex Deucher<alexander.deucher@amd.com> wrote:
>>
>> We already call this in the hw_fini() methods for all
>> VCN instances, so no need to call it again in
>> amdgpu_vcn_suspend().
>>
>> Signed-off-by: Alex Deucher<alexander.deucher@amd.com>
>> ---
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c | 2 --
>>   1 file changed, 2 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
>> index 9a76e11d1c184..fd8ebf4b5a824 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
>> @@ -357,8 +357,6 @@ int amdgpu_vcn_suspend(struct amdgpu_device *adev, int i)
>>          if (adev->vcn.harvest_config & (1 << i))
>>                  return 0;
>>
>> -       cancel_delayed_work_sync(&adev->vcn.inst[i].idle_work);
>> -
>>          /* err_event_athub and dpc recovery will corrupt VCPU buffer, so we need to
>>           * restore fw data and clear buffer in amdgpu_vcn_resume() */
>>          if (in_ras_intr || adev->pcie_reset_ctx.in_link_reset)
>> --
>> 2.50.1
>>
>>
--------------WnzBecR9BjO0PXRd7zXW0RX1
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: 8bit

<!DOCTYPE html><html><head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
  </head>
  <body>
    <pre>Did some tests with the sw callbacks which were called with rmmod.
It will fail if there are jobs, otherwise no need to cancel delayed work as
there is not any outstanding work and idle handler called or not did not affect 
the removal of the module. insmod continues to work after that.
The case for&nbsp;hw_fini works as expected.
Tested-by: David (Ming Qiang) Wu <a class="moz-txt-link-rfc2396E" href="mailto:David.Wu3@amd.com">&lt;David.Wu3@amd.com&gt;</a></pre>
    <pre>Thanks,</pre>
    <pre>David</pre>
    <div class="moz-cite-prefix">On 2025-08-20 15:43, Alex Deucher
      wrote:<br>
    </div>
    <blockquote type="cite" cite="mid:CADnq5_Mhdg6-7xOkofj0NT8MiFyv-EKcmZLObSApLjWX7Z-zrg@mail.gmail.com">
      <pre wrap="" class="moz-quote-pre">On Wed, Aug 20, 2025 at 3:29 PM Wu, David <a class="moz-txt-link-rfc2396E" href="mailto:David.Wu3@amd.com">&lt;David.Wu3@amd.com&gt;</a> wrote:
</pre>
      <blockquote type="cite">
        <pre wrap="" class="moz-quote-pre">
[AMD Official Use Only - AMD Internal Distribution Only]


one thing I noticed:
   amdgpu_vcn_suspend() also gets called in vcn_v2_5_sw_fini() for example
   where there isn't cancel_delayed_work_sync() call. Does the removal work in this case?
</pre>
      </blockquote>
      <pre wrap="" class="moz-quote-pre">
The sw callbacks are not supposed to touch any hardware, so that's
wrong to begin with.  That said, this should never end up doing
anything because we've already cancelled the delayed worker in hw_fini
and after hw_fini the hw is stopped so no work should be outstanding.

Alex

</pre>
      <blockquote type="cite">
        <pre wrap="" class="moz-quote-pre">
David
On 8/20/2025 2:36 PM, Alex Deucher wrote:

Ping?

On Wed, Aug 13, 2025 at 3:37 PM Alex Deucher <a class="moz-txt-link-rfc2396E" href="mailto:alexander.deucher@amd.com">&lt;alexander.deucher@amd.com&gt;</a> wrote:

We already call this in the hw_fini() methods for all
VCN instances, so no need to call it again in
amdgpu_vcn_suspend().

Signed-off-by: Alex Deucher <a class="moz-txt-link-rfc2396E" href="mailto:alexander.deucher@amd.com">&lt;alexander.deucher@amd.com&gt;</a>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
index 9a76e11d1c184..fd8ebf4b5a824 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
@@ -357,8 +357,6 @@ int amdgpu_vcn_suspend(struct amdgpu_device *adev, int i)
        if (adev-&gt;vcn.harvest_config &amp; (1 &lt;&lt; i))
                return 0;

-       cancel_delayed_work_sync(&amp;adev-&gt;vcn.inst[i].idle_work);
-
        /* err_event_athub and dpc recovery will corrupt VCPU buffer, so we need to
         * restore fw data and clear buffer in amdgpu_vcn_resume() */
        if (in_ras_intr || adev-&gt;pcie_reset_ctx.in_link_reset)
--
2.50.1


</pre>
      </blockquote>
    </blockquote>
  </body>
</html>

--------------WnzBecR9BjO0PXRd7zXW0RX1--
